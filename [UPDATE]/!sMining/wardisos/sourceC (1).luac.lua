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
tunnelObjectRots = {}
junctionObjects = {}
threeJunctionsAt = {}
threeJunctionRots = {}
threeJunctionBombs = {}
shaftBombs = {}
openShaftsAt = {}
openShaftBombs = {}
fixOreCarts = {}
carryingFixOre = false
emptyingTurtle = false
bombDetonations = {}
mineMachineData = {}
mineFoundryData = {
  furnaceRunning = false,
  meltingOre = false,
  meltProgress = 0
}
addEventHandler("onClientResourceStart", resourceRoot, function()
  refreshGuiScheme()
  engineLoadIFP("files/animations/wallhit.ifp", "mining_hit")
  engineLoadIFP("files/animations/boxpour.ifp", "mining_box_pour")
  engineLoadIFP("files/animations/filldiesel.ifp", "mining_fill_diesel")
  for oreIndex, oreData in pairs(oreTypes) do
    oreData.itemOutput = {}
    oreData.itemPicture = ":see_items/files/items/" .. oreData.itemId - 1 .. ".png"
  end
end)
addEventHandler("onClientResourceStop", resourceRoot, function()
  if loadedMineLobby then
    exports.see_weather:resetWeather()
  elseif currentMine then
    unloadMine()
  end
  if pickaxeItem then --pickaxeMode
    exports.see_items:unuseItem(pickaxeItem)
    pickaxeItem = false
  end
  if bagItem then
    exports.see_items:unuseItem(bagItem)
    bagItem = false
  end
  if tabletItem then
    exports.see_items:unuseItem(tabletItem)
    tabletItem = false
  end
end)
addEvent("otherPlayerEnteredMine", true)
addEventHandler("otherPlayerEnteredMine", root, function(mineIdentity, _ARG_1_) --Itt az arg1-et nemtudom mi lehet
  if isElement(source) and (currentMine == mineIdentity or loadingMineEnter == mineIdentity) then
    currentMinePlayers[source] = _ARG_1_
  end
end)
addEvent("otherPlayerExitedMine", true)
addEventHandler("otherPlayerExitedMine", root, function(mineIdentity, _ARG_1_)
  if currentMine == mineIdentity then
    currentMinePlayers[source] = nil
  end
end)
addEvent("enteredMine", true)
addEventHandler("enteredMine", localPlayer, function(mineIdentity, ...)
  if not loadingCoroutine then
    addEventHandler("onClientPreRender", root, preRenderMineLoading)
    loadingMineEnter = mineIdentity
    loadingMineEnterSynced = mineIdentity
    loadingCoroutineStart = getTickCount()
    loadingCoroutine = coroutine.create(loadMine)
    coroutine.resume(loadingCoroutine, mineIdentity, ...)
  end
end)
addEvent("exitMine", true)
addEventHandler("exitMine", root, function()
  addEventHandler("onClientPreRender", root, preRenderMineUnloading)
  loadingMineExit = true
  loadingMineExitSynced = true
  startLoader(true)
  unloadingCoroutineStart = getTickCount() --Unload Start
  unloadingCoroutine = coroutine.create(unloadMine)
end)
function preRenderMineLoading()
  if loadingCoroutine then
    if coroutine.status(loadingCoroutine) == "dead" then
      loadingCoroutine = nil
    else
      loadingCoroutineStart = getTickCount()
      coroutine.resume(loadingCoroutine)
    end
  end
end
function preRenderMineUnloading()
  if unloadingCoroutine then
    if coroutine.status(unloadingCoroutine) == "dead" then
      unloadingCoroutine = nil
    else
      unloadingCoroutineStart = getTickCount()
      coroutine.resume(unloadingCoroutine)
    end
  end
end
function checkMineLoadingTime()
  if coroutine.running() and getTickCount() - loadingCoroutineStart > 15 then
    coroutine.yield()
  end
end
function checkMineUnloadingTime()
  if coroutine.running() and getTickCount() - unloadingCoroutineStart > 15 then
    coroutine.yield()
  end
end
function loadMine(mineIdentity, playerIdentity, mineData)
  unloadLobby()
  if isElement(mineExitMarker) then
    setElementDimension(mineExitMarker, mineIdentity)
  end
  if isElement(mineHq) then
    setElementDimension(mineHq, mineIdentity)
  end
  calculateBase()
  loaderText = "Textúrák betöltése"
  if tabletItem then
    exports.see_items:unuseItem(tabletItem)
    tabletItem = false
  end
  mineAssets.lcdCharset = dxCreateTexture("files/textures/charset_lcd.dds", "argb", true)
  mineAssets.mineFull = dxCreateTexture("files/textures/minefull.dds", "argb", true)
  mineAssets.mineCircle = dxCreateTexture("files/textures/minecircle.dds", "argb", true)
  mineAssets.mineAim = dxCreateTexture("files/textures/mineaim.dds", "argb", true)
  checkMineLoadingTime()
  mineAssets.smokeParticle = dxCreateTexture("files/textures/particle/smoke.dds", "argb", true)
  mineAssets.sparkParticle = dxCreateTexture("files/textures/particle/spark.dds", "argb", true)
  for _FORV_6_ = 0, 4 do
    mineAssets["railDraw" .. _FORV_6_] = dxCreateTexture("files/textures/rail/" .. _FORV_6_ .. ".dds", "argb", true)
  end
  mineAssets.arrowMarker = dxCreateTexture("files/textures/arrow.dds", "argb", true)
  for _FORV_6_ = 3, 4 do
    mineAssets["railSwitch_" .. _FORV_6_] = dxCreateTexture("files/textures/switch/" .. _FORV_6_ .. ".dds", "argb", true)
    for _FORV_10_ = 1, 2 do
      mineAssets["railSwitch_" .. _FORV_6_ .. "_" .. _FORV_10_] = dxCreateTexture("files/textures/switch/" .. _FORV_6_ .. "_" .. _FORV_10_ .. ".dds", "argb", true)
    end
    _FOR_()
  end
  mineAssets.railHighlight = dxCreateTexture("files/textures/highlight.dds", "argb", true)
  if not shaftWall then
    shaftWall = poolGetModel()
    if shaftWall then
      shaftTxd = engineLoadTXD("files/models/shaftwall.txd")
      shaftCol = engineLoadCOL("files/models/shaftwall.col")
      shaftDff = engineLoadDFF("files/models/shaftwall.dff")
      engineImportTXD(shaftTxd, shaftWall)
      engineReplaceCOL(shaftCol, shaftWall)
      engineReplaceModel(shaftDff, shaftWall)
      checkMineLoadingTime()
    end
    loaderText = "Adatok betöltése"
  end
  selfCharacterId = playerIdentity
  if pickaxeItem then
    exports.see_controls:toggleControl("fire", false, "minePickaxeMode")
  end
  mineTick = getTickCount()
  mineDelta = 0
  currentMine = mineIdentity
  currentMineName = mineData.mineName
  currentMineLocked = mineData.doorLocked
  currentMineOwnerId = mineData.rentedBy
  currentMineWorkers = mineData.workerNames or {}
  currentMineWorkersList = {}
  currentMinePermissions = mineData.workerPermissions or {}
  currentMineInventory = mineData.inventoryData or {}
  currentMineOrder = mineData.orderData
  currentMineOrderPaid = mineData.orderPaid
  currentMinePlayers = {}
  if not currentMinePlayers[localPlayer] then
    currentMinePlayers[localPlayer] = playerIdentity
  end
  for playerIdentity in pairs(currentMineWorkers) do
    table.insert(currentMineWorkersList, playerIdentity)
  end
  updateMineInventory("railIrons", currentMineInventory.railIrons or 0)
  updateMineInventory("railWoods", currentMineInventory.railWoods or 0)
  updateMineInventory("mineLamps", currentMineInventory.mineLamps or 0)
  if mineData.cartEmptying then
    for cartIdentity, playerElement in pairs(mineData.cartEmptying) do
      cartTurtleEmptying[cartIdentity] = playerElement
      if playerElement == localPlayer then
        emptyingTurtle = cartIdentity
      end
    end
  end
  revalidateTabletOrder()
  createShaft(0, -1, 0, 1, 0, pcos(0), psin(0), (rngCreate(0)))
  rngDelete((rngCreate(0)))
  shaftDepths = mineData.shaftDepths or {}
  _UPVALUE7_ = mineData.shaftLengths or {}
  if mineData.shaftList then
    loaderText = "Bányajáratok betöltése"
    for _FORV_6_ = 1, #mineData.shaftList do
      if mineData.shaftList[_FORV_6_] then
        if 0 < unpack(mineData.shaftList[_FORV_6_]) then
          rngSkip(rngCreate(unpack(mineData.shaftList[_FORV_6_])), unpack(mineData.shaftList[_FORV_6_]))
        end
        createShaft(_FORV_6_, unpack(mineData.shaftList[_FORV_6_]))
        _UPVALUE8_[_FORV_6_] = {
          unpack(mineData.shaftList[_FORV_6_])
        }
        _UPVALUE9_[_FORV_6_] = unpack(mineData.shaftList[_FORV_6_])
        _UPVALUE10_[_FORV_6_] = {
          unpack(mineData.shaftList[_FORV_6_])
        }
        if shaftDepths[_FORV_6_] then
          _UPVALUE11_[_FORV_6_] = rngCreate(unpack(mineData.shaftList[_FORV_6_]))
          if generateOpenShaftDff(_FORV_6_, true) then
            _UPVALUE13_[_FORV_6_] = true
            _UPVALUE14_[_FORV_6_] = nil
            _UPVALUE15_[_FORV_6_] = {}
            for _FORV_23_ = 1, wallBlockCount do
              if isElement((createObject(modelIds.v4_mine_wall, getShaftBlockPosition(_FORV_6_, _FORV_23_)))) then
                setObjectScale(createObject(modelIds.v4_mine_wall, getShaftBlockPosition(_FORV_6_, _FORV_23_)), 0)
                setElementAlpha(createObject(modelIds.v4_mine_wall, getShaftBlockPosition(_FORV_6_, _FORV_23_)), 0)
                setElementInterior(createObject(modelIds.v4_mine_wall, getShaftBlockPosition(_FORV_6_, _FORV_23_)), 0)
                setElementDimension(createObject(modelIds.v4_mine_wall, getShaftBlockPosition(_FORV_6_, _FORV_23_)), currentMine)
                removeShaderFromObject((createObject(modelIds.v4_mine_wall, getShaftBlockPosition(_FORV_6_, _FORV_23_))))
                checkMineLoadingTime()
              end
              _UPVALUE15_[_FORV_6_][_FORV_23_] = createObject(modelIds.v4_mine_wall, getShaftBlockPosition(_FORV_6_, _FORV_23_))
            end
          end
        else
          rngDelete((rngCreate(unpack(mineData.shaftList[_FORV_6_]))))
        end
        checkMineLoadingTime()
      end
      _UPVALUE16_[_FORV_6_] = true
    end
  end
  _UPVALUE17_ = _FOR_ or {}
  if mineData.junctionList then
    loaderText = "Elágazások betöltése"
    for _FORV_6_, _FORV_7_ in pairs(mineData.junctionList) do
      createJunction(unpack(_FORV_7_))
      checkMineLoadingTime()
    end
    checkMineLoadingTime()
  end
  if mineData.railTracks then
    loaderText = "Sínek betöltése"
    for _FORV_6_, _FORV_7_ in pairs(mineData.railTracks) do
      createRail(_FORV_6_, _FORV_7_)
      checkMineLoadingTime()
    end
    checkMineLoadingTime()
  end
  if mineData.railSwitches and mineData.railSwitchStates then
    loaderText = "Váltók betöltése"
    for _FORV_6_, _FORV_7_ in pairs(mineData.railSwitches) do
      createRailSwitch(_FORV_6_, _FORV_7_, mineData.railSwitchStates[_FORV_6_])
      checkMineLoadingTime()
    end
    checkMineLoadingTime()
  end
  if mineData.trainData then
    shouldRefreshJerryContent = false
    currentMineInventory.jerryCarry = mineData.trainData.jerryCarry
    currentMineInventory.jerryContent = mineData.trainData.jerryContent or 0
    currentMineInventory.displayedJerryContent = currentMineInventory.jerryContent
    currentMineInventory.jerryCan = false
    currentMineInventory.jerrySound = false
  end
  initMineTrain(currentMineInventory.dieselLoco, currentMineInventory.subCartNum or 0, mineData.trainData.fuelLevel or 0)
  if mineData.trainData then
    processRailCarSync(mineData.trainData, true)
  end
  checkMineLoadingTime()
  if not currentMineInventory.tankOutside and not currentMineInventory.fuelTankObject then
    currentMineInventory.fuelTankObject = createObject(modelIds.v4_mine_tank, minePosX - 32.7956, minePosY + 2.3363, minePosZ, 0, 0, -5)
    if isElement(currentMineInventory.fuelTankObject) then
      setElementInterior(currentMineInventory.fuelTankObject, 0)
      setElementDimension(currentMineInventory.fuelTankObject, currentMine)
    end
  end
  currentMineInventory.displayedFuelTankLevel = currentMineInventory.fuelTankLevel
  mineMachineData.machineRunning = mineData.sorterRunning
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
  if mineData.installedLights then
    for _FORV_6_ in pairs(mineData.installedLights) do
      for _FORV_10_ in pairs(mineData.installedLights[_FORV_6_]) do
        setStreamedLights(_FORV_6_, _FORV_10_, true)
      end
      checkMineLoadingTime()
    end
  end
  loadShaders()
  mineFoundryData.furnaceRunning = mineData.furnaceRunning
  mineFoundryData.meltingOre = mineData.meltingOre
  mineFoundryData.meltProgress = mineData.meltProgress or 0
  if mineFoundryData.meltingOre then
    setMeltingOre(mineFoundryData.meltingOre)
  end
  createSortingMachine()
  loaderText = "Ércek inicializálása"
  for _FORV_12_, _FORV_13_ in pairs(oreTypes) do
    _FORV_13_.bufferContent = mineData.bufferContent[_FORV_12_] or 0
    _FORV_13_.boxContent = 0
    _FORV_13_.displayedBoxContent = 0
    _FORV_13_.foundryContent = mineData.foundryContent[_FORV_12_] or 0
    _FORV_13_.displayedFoundryContent = _FORV_13_.foundryContent
    _FORV_13_.carriedBy = false
    if not _FORV_13_.instantItem then
      _FORV_13_.boxPosition = {
        machinePosX - 2.1249 - _FORV_13_.sorterOffset,
        machinePosY - 0.2139 - 1.0574,
        machinePosZ + 0.2109 - 1.6562
      }
      _FORV_13_.boxElement = createObject(modelIds.v4_mine_box, unpack(_FORV_13_.boxPosition))
      if isElement(_FORV_13_.boxElement) then
        setElementInterior(_FORV_13_.boxElement, 0)
        setElementDimension(_FORV_13_.boxElement, currentMine)
      end
      _FORV_13_.boxContentElement = createObject(modelIds.v4_mine_box_content, unpack(_FORV_13_.boxPosition))
      if isElement(_FORV_13_.boxContentElement) then
        refreshOreShader(_FORV_13_.boxContentElement, _FORV_12_)
        setElementInterior(_FORV_13_.boxContentElement, 0)
        setElementDimension(_FORV_13_.boxContentElement, currentMine)
      end
    end
    checkMineLoadingTime()
    if _FORV_13_.meltingPoint then
      _FORV_13_.foundryObject = createObject(modelIds.v4_mine_furnace, minePosX - 10.6672, minePosY - 8.1405, minePosZ + 0.0059, 0, 0, 180)
      if isElement(_FORV_13_.foundryObject) then
        setElementInterior(_FORV_13_.foundryObject, 0)
        setElementDimension(_FORV_13_.foundryObject, currentMine)
      end
      _FORV_13_.foundryPosition = {
        minePosX - 10.6672,
        minePosY - 8.1405,
        minePosZ + 0.0059
      }
      _FORV_13_.foundryInputPosition = {
        minePosX - 10.6672 - 1.0866,
        minePosY - 8.1405 + 0.7895,
        minePosZ + 0.0059 + 1.275
      }
      _FORV_13_.foundryButtonPosition = {
        minePosX - 10.6672 - 0.3792,
        minePosY - 8.1405 + 1.1672,
        minePosZ + 0.0059 + 1.0768
      }
      _FORV_13_.foundryDisplayPosition = {
        minePosX - 10.6672 - 0.3792,
        minePosY - 8.1405 + 1.1672,
        minePosZ + 0.0059 + 1.4624
      }
      _FORV_13_.ingotPosition = {
        minePosX - 10.6672,
        minePosY - 8.1405 + 1.2368,
        minePosZ + 0.0059 + 0.3614
      }
      _FORV_13_.meltPosition = {
        minePosX - 10.6672,
        minePosY - 8.1405 + 1.2368,
        minePosZ + 0.0059 + 0.5781
      }
      _FORV_13_.meltLightPosition = {
        minePosX - 10.6672,
        minePosY - 8.1405 + 1.2368,
        minePosZ + 0.0059 + 0.46975
      }
      _FORV_13_.furnaceSound = playSound3D("files/sounds/furnace.wav", minePosX - 10.6672, minePosY - 8.1405, minePosZ + 0.0059, true)
      _FORV_13_.furnaceTemperature = mineData.furnaceTemperature[_FORV_12_] or 0
      _FORV_13_.furnaceRunProgress = 0
      if isElement(_FORV_13_.furnaceSound) then
        setElementInterior(_FORV_13_.furnaceSound, 0)
        setElementDimension(_FORV_13_.furnaceSound, currentMine)
        setSoundMaxDistance(_FORV_13_.furnaceSound, 50)
        setSoundVolume(_FORV_13_.furnaceSound, 0)
      end
    end
    checkOreBuffer(_FORV_12_, true)
    syncOreBoxCarry(_FORV_12_, mineData.oreBoxCarrying[_FORV_12_])
  end
  loaderText = "Ércek betöltése"
  for _FORV_12_, _FORV_13_ in pairs(mineData.fixOres) do
    if isElement((createObject(modelIds[oreTypes[_FORV_13_[3]] and oreTypes[_FORV_13_[3]].modelName or "v4_mine_ore" .. math.random(1, 5)], minePosX + _FORV_13_[1], minePosY + _FORV_13_[2], minePosZ, math.random() * 360, math.random() * 360, math.random() * 360))) then
      refreshOreShader(createObject(modelIds[oreTypes[_FORV_13_[3]] and oreTypes[_FORV_13_[3]].modelName or "v4_mine_ore" .. math.random(1, 5)], minePosX + _FORV_13_[1], minePosY + _FORV_13_[2], minePosZ, math.random() * 360, math.random() * 360, math.random() * 360), _FORV_13_[3])
      setElementInterior(createObject(modelIds[oreTypes[_FORV_13_[3]] and oreTypes[_FORV_13_[3]].modelName or "v4_mine_ore" .. math.random(1, 5)], minePosX + _FORV_13_[1], minePosY + _FORV_13_[2], minePosZ, math.random() * 360, math.random() * 360, math.random() * 360), 0)
      setElementDimension(createObject(modelIds[oreTypes[_FORV_13_[3]] and oreTypes[_FORV_13_[3]].modelName or "v4_mine_ore" .. math.random(1, 5)], minePosX + _FORV_13_[1], minePosY + _FORV_13_[2], minePosZ, math.random() * 360, math.random() * 360, math.random() * 360), currentMine)
    end
    _UPVALUE18_[_FORV_12_] = {
      _FORV_13_[1],
      _FORV_13_[2],
      0,
      0,
      0,
      createObject(modelIds[oreTypes[_FORV_13_[3]] and oreTypes[_FORV_13_[3]].modelName or "v4_mine_ore" .. math.random(1, 5)], minePosX + _FORV_13_[1], minePosY + _FORV_13_[2], minePosZ, math.random() * 360, math.random() * 360, math.random() * 360),
      nil,
      nil,
      nil,
      _FORV_13_[3]
    }
    _UPVALUE19_[_FORV_12_] = true
    if _FORV_13_[4] == "cart" then
      attachFixOreToCart(_FORV_12_, _FORV_13_[5], _FORV_13_[6])
    elseif _FORV_13_[4] == "player" then
      attachFixOreToPlayer(_FORV_12_, _FORV_13_[5])
    else
      setFixOrePosition(_FORV_12_, _FORV_13_[1], _FORV_13_[2])
    end
  end
  loaderText = "Betöltés véglegesítése"
  while _UPVALUE20_[1] do
    processPendingEvent(1)
    coroutine.yield()
  end
  if not _UPVALUE21_ then
    _UPVALUE21_ = playSound("files/sounds/mineloop.mp3", true)
    if isElement(_UPVALUE21_) then
      setSoundVolume(_UPVALUE21_, 0.5)
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
  if tabletItem then
    exports.see_items:unuseItem(tabletItem)
    tabletItem = false
  end
  if mineAssets then
    removeEventHandler("onClientPreRender", root, preRenderMineLoading)
    _UPVALUE1_ = 0
    mineAssets = nil
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
  exports.see_weather:resetWeather()
  exports.see_dashboard:resetViewDistance()
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
  for _FORV_3_, _FORV_4_ in pairs(_UPVALUE2_) do
    checkMineUnloadingTime()
    if isElement(_FORV_4_) then
      destroyElement(_FORV_4_)
    end
    _UPVALUE2_[_FORV_3_] = nil
  end
  _UPVALUE2_ = {}
  if isElement(_UPVALUE3_) then
    destroyElement(_UPVALUE3_)
  end
  for _FORV_3_ in pairs(mineFoundryData) do
    checkMineUnloadingTime()
    if isElement(mineFoundryData[_FORV_3_]) then
      destroyElement(mineFoundryData[_FORV_3_])
    end
    mineFoundryData[_FORV_3_] = nil
  end
  unloadMineOres()
  unloadMineRails()
  unloadMineShafts()
  unloadMineInventory()
  _UPVALUE3_ = nil
  carryingFixOre = false
  emptyingTurtle = false
  _UPVALUE4_ = nil
  _UPVALUE5_ = nil
  _UPVALUE6_ = nil
  _UPVALUE7_ = nil
  _UPVALUE8_ = nil
  _UPVALUE9_ = nil
  _UPVALUE10_ = nil
  _UPVALUE11_ = nil
  _UPVALUE12_ = nil
  _UPVALUE13_ = nil
  _UPVALUE14_ = nil
  _UPVALUE15_ = nil
  _UPVALUE16_ = nil
  _UPVALUE17_ = {}
  _UPVALUE18_ = {}
  _UPVALUE19_ = {}
  _UPVALUE20_ = {}
  _UPVALUE21_ = {}
  _UPVALUE22_ = {}
  shouldRefreshBoxContent = false
  shouldRefreshFoundryContent = false
  mineFoundryData.furnaceRunning = false
  mineFoundryData.meltingOre = false
  mineFoundryData.meltProgress = 0
  exports.see_controls:toggleControl("fire", true, "minePickaxeMode")
  exports.see_controls:toggleControl({
    "fire",
    "crouch",
    "action"
  }, true, "minePickaxeAim")
  removeEventHandler("onClientPreRender", root, preRenderMineUnloading)
  collectgarbage()
end
function unloadMineShafts()
  for _FORV_3_, _FORV_4_ in pairs(mineAssets) do
    checkMineUnloadingTime()
    if isElement(_FORV_4_) then
      destroyElement(_FORV_4_)
    end
    mineAssets[_FORV_3_] = nil
  end
  for _FORV_3_, _FORV_4_ in pairs(_UPVALUE1_) do
    checkMineUnloadingTime()
    if isElement(_FORV_4_) then
      destroyElement(_FORV_4_)
    end
    _UPVALUE1_[_FORV_3_] = nil
  end
  for _FORV_3_, _FORV_4_ in pairs(_UPVALUE2_) do
    poolFreeModel(_FORV_4_)
  end
  for _FORV_3_ in pairs(_UPVALUE3_) do
    for _FORV_7_, _FORV_8_ in pairs(_UPVALUE3_[_FORV_3_]) do
      checkMineUnloadingTime()
      if isElement(_FORV_8_[5]) then
        destroyElement(_FORV_8_[5])
      end
      _FORV_8_[5] = nil
    end
  end
  for _FORV_3_ in pairs(_UPVALUE4_) do
    for _FORV_7_ in pairs(_UPVALUE4_[_FORV_3_]) do
      checkMineUnloadingTime()
      if isElement(_UPVALUE4_[_FORV_3_][_FORV_7_]) then
        destroyElement(_UPVALUE4_[_FORV_3_][_FORV_7_])
      end
      _UPVALUE4_[_FORV_3_][_FORV_7_] = nil
    end
  end
  for _FORV_3_ in pairs(_UPVALUE5_) do
    rngDelete(_UPVALUE5_[_FORV_3_])
  end
  for _FORV_3_ in pairs(_UPVALUE6_) do
    for _FORV_7_ in pairs(_UPVALUE6_[_FORV_3_]) do
      checkMineUnloadingTime()
      if isElement(_UPVALUE6_[_FORV_3_][_FORV_7_]) then
        destroyElement(_UPVALUE6_[_FORV_3_][_FORV_7_])
      end
      _UPVALUE6_[_FORV_3_][_FORV_7_] = nil
    end
    _UPVALUE6_[_FORV_3_] = nil
  end
  for _FORV_3_ in pairs(junctionObjects) do
    for _FORV_7_ in pairs(junctionObjects[_FORV_3_]) do
      checkMineUnloadingTime()
      if isElement(junctionObjects[_FORV_3_][_FORV_7_]) then
        destroyElement(junctionObjects[_FORV_3_][_FORV_7_])
      end
      junctionObjects[_FORV_3_][_FORV_7_] = nil
    end
    junctionObjects[_FORV_3_] = nil
  end
  if isElement(_UPVALUE7_) then
    destroyElement(_UPVALUE7_)
  end
  if isElement(_UPVALUE8_) then
    destroyElement(_UPVALUE8_)
  end
  if isElement(_UPVALUE9_) then
    destroyElement(_UPVALUE9_)
  end
  if _UPVALUE10_ then
    engineFreeModel(_UPVALUE10_)
  end
  clearRandomMDVD()
  for _FORV_3_ in pairs(openShaftBombs) do
    checkMineUnloadingTime()
    if isElement(openShaftBombs[_FORV_3_][1]) then
      destroyElement(openShaftBombs[_FORV_3_][1])
    end
    openShaftBombs[_FORV_3_][1] = nil
  end
  for _FORV_3_ in pairs(shaftBombs) do
    for _FORV_7_ in pairs(shaftBombs[_FORV_3_]) do
      for _FORV_11_ in pairs(shaftBombs[_FORV_3_][_FORV_7_]) do
        checkMineUnloadingTime()
        if isElement(shaftBombs[_FORV_3_][_FORV_7_][_FORV_11_][1]) then
          destroyElement(shaftBombs[_FORV_3_][_FORV_7_][_FORV_11_][1])
        end
        shaftBombs[_FORV_3_][_FORV_7_][_FORV_11_][1] = nil
      end
    end
  end
  for _FORV_3_ in pairs(threeJunctionBombs) do
    for _FORV_7_ in pairs(threeJunctionBombs[_FORV_3_]) do
      checkMineUnloadingTime()
      if isElement(threeJunctionBombs[_FORV_3_][_FORV_7_][1]) then
        destroyElement(threeJunctionBombs[_FORV_3_][_FORV_7_][1])
      end
      threeJunctionBombs[_FORV_3_][_FORV_7_][1] = nil
    end
  end
  _UPVALUE7_ = nil
  _UPVALUE8_ = nil
  _UPVALUE9_ = nil
  _UPVALUE10_ = nil
  _UPVALUE6_ = {}
  _UPVALUE11_ = {}
  tunnelObjectRots = {}
  junctionObjects = {}
  threeJunctionsAt = {}
  threeJunctionRots = {}
  threeJunctionBombs = {}
  _UPVALUE12_ = {}
  _UPVALUE13_ = {}
  _UPVALUE14_ = {}
  _UPVALUE15_ = {}
  _UPVALUE16_ = {}
  shaftBombs = {}
  _UPVALUE17_ = {}
  openShaftsAt = {}
  _UPVALUE5_ = {}
  _UPVALUE18_ = {}
  _UPVALUE19_ = {}
  _UPVALUE1_ = {}
  _UPVALUE2_ = {}
  mineAssets = {}
  _UPVALUE4_ = {}
  _UPVALUE20_ = {}
  _UPVALUE21_ = {}
  _UPVALUE22_ = {}
  _UPVALUE23_ = {}
  _UPVALUE24_ = {}
  _UPVALUE3_ = {}
  _UPVALUE25_ = {}
  openShaftBombs = {}
  bombDetonations = {}
end
function unloadMineRails()
  deleteMineTrain()
  for _FORV_3_, _FORV_4_ in pairs(railTracks) do
    for _FORV_8_, _FORV_9_ in pairs(_FORV_4_.objectList) do
      checkMineUnloadingTime()
      if isElement(_FORV_9_) then
        destroyElement(_FORV_9_)
      end
      _FORV_4_.objectList[_FORV_8_] = nil
    end
  end
  for _FORV_3_, _FORV_4_ in pairs(railSwitches) do
    checkMineUnloadingTime()
    if isElement(_FORV_4_.objectElement) then
      destroyElement(_FORV_4_.objectElement)
    end
    _FORV_4_.objectElement = nil
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
  for _FORV_3_, _FORV_4_ in pairs(mineAssets) do
    checkMineUnloadingTime()
    if isElement(_FORV_4_[6]) then
      destroyElement(_FORV_4_[6])
    end
    _FORV_4_[6] = nil
  end
  for _FORV_3_, _FORV_4_ in pairs(oreTypes) do
    for _FORV_8_, _FORV_9_ in pairs(_FORV_4_) do
      checkMineUnloadingTime()
      if isElement(_FORV_9_) then
        destroyElement(_FORV_9_)
      end
      if type(_FORV_9_) == "userdata" then
        _FORV_4_[_FORV_8_] = nil
      end
    end
  end
  for _FORV_3_ = 1, #_UPVALUE1_ do
    if isElement(_UPVALUE1_[_FORV_3_].oreElement) then
      destroyElement(_UPVALUE1_[_FORV_3_].oreElement)
    end
    _UPVALUE1_[_FORV_3_].oreElement = nil
  end
  for _FORV_3_ = 1, #_UPVALUE2_ do
    if isElement(_UPVALUE2_[_FORV_3_].objectElement) then
      destroyElement(_UPVALUE2_[_FORV_3_].objectElement)
    end
    _UPVALUE2_[_FORV_3_].objectElement = nil
  end
  for _FORV_3_ = 1, #_UPVALUE3_ do
    checkMineUnloadingTime()
    if isElement(_UPVALUE3_[1]) then
      destroyElement(_UPVALUE3_[1])
    end
    _UPVALUE3_[1] = nil
  end
  _UPVALUE4_ = _FOR_
  fixOreCarts = {}
  mineAssets = {}
  _UPVALUE5_ = {}
  _UPVALUE6_ = {}
  _UPVALUE7_ = {}
  _UPVALUE8_ = nil
  _UPVALUE1_ = {}
  _UPVALUE2_ = {}
  _UPVALUE3_ = {}
end
function unloadMineInventory()
  for _FORV_3_ in pairs(mineAssets) do
    checkMineUnloadingTime()
    if isElement(mineAssets[_FORV_3_]) then
      destroyElement(mineAssets[_FORV_3_])
    end
    mineAssets[_FORV_3_] = nil
  end
  mineAssets = {}
  for _FORV_3_ in pairs(_UPVALUE1_) do
    checkMineUnloadingTime()
    if isElement(_UPVALUE1_[_FORV_3_]) then
      destroyElement(_UPVALUE1_[_FORV_3_])
    end
    _UPVALUE1_[_FORV_3_] = nil
  end
  _UPVALUE1_ = {}
  for _FORV_3_ in pairs(_UPVALUE2_) do
    checkMineUnloadingTime()
    if isElement(_UPVALUE2_[_FORV_3_]) then
      destroyElement(_UPVALUE2_[_FORV_3_])
    end
    _UPVALUE2_[_FORV_3_] = nil
  end
  _UPVALUE2_ = {}
  for _FORV_3_, _FORV_4_ in pairs(mineMachineData) do
    checkMineUnloadingTime()
    if isElement(_FORV_4_) then
      destroyElement(_FORV_4_)
    end
    mineMachineData[_FORV_3_] = nil
  end
  mineMachineData = {}
  for _FORV_3_, _FORV_4_ in pairs(currentMineInventory) do
    checkMineUnloadingTime()
    if isElement(_FORV_4_) then
      destroyElement(_FORV_4_)
    end
    currentMineInventory[_FORV_3_] = nil
  end
  currentMineInventory = {}
end
function doMineLoadEnded()
  removeEventHandler("onClientPreRender", root, preRenderMineLoading)
  for _FORV_3_ = 1, #mineAssets do
    processPendingEvent(_FORV_3_)
  end
  loadingMineEnter = _FOR_
  loadingMineEnterSynced = false
  _UPVALUE1_ = 0
  _UPVALUE2_ = nil
  forceRefreshTrain = true
end
function doMineJobs()
  if mineAssets then
    if coroutine.status(mineAssets) == "dead" then
      mineAssets = nil
    else
      _UPVALUE1_ = getTickCount()
      coroutine.resume(mineAssets)
    end
    return true
  elseif #_UPVALUE2_ > 0 then
    if _UPVALUE2_[1].currentStage >= 6 then
      if #_UPVALUE3_ > 0 then
        mineAssets = coroutine.create(processDffExportQueue)
        _UPVALUE4_ = getTickCount()
      else
        mineAssets = coroutine.create(processShaftJobQueue)
        _UPVALUE4_ = getTickCount()
      end
    else
      mineAssets = coroutine.create(processShaftJobQueue)
      _UPVALUE4_ = getTickCount()
    end
    return true
  elseif #_UPVALUE3_ > 0 then
    mineAssets = coroutine.create(processDffExportQueue)
    _UPVALUE4_ = getTickCount()
    return true
  end
  return false
end
function processPendingEvent(_ARG_0_)
  if not table.remove(mineAssets, _ARG_0_) then
    return
  end
  if table.remove(mineAssets, _ARG_0_).eventName == "syncFixOreState" then
    if isElement(table.remove(mineAssets, _ARG_0_).sourceElement) and table.remove(mineAssets, _ARG_0_).sourceElement ~= resourceRoot then
      setPedAnimation(table.remove(mineAssets, _ARG_0_).sourceElement)
    elseif isElement(_UPVALUE1_[table.remove(mineAssets, _ARG_0_).handlerFunctionParams[1]]) then
      setPedAnimation(_UPVALUE1_[table.remove(mineAssets, _ARG_0_).handlerFunctionParams[1]])
    end
  elseif table.remove(mineAssets, _ARG_0_).eventName == "syncMineOreBoxCarry" then
    if isElement(table.remove(mineAssets, _ARG_0_).sourceElement) and table.remove(mineAssets, _ARG_0_).sourceElement ~= resourceRoot then
      setPedAnimation(table.remove(mineAssets, _ARG_0_).sourceElement)
    elseif isElement(oreTypes[table.remove(mineAssets, _ARG_0_).handlerFunctionParams[1]].carriedBy) then
      setPedAnimation(oreTypes[table.remove(mineAssets, _ARG_0_).handlerFunctionParams[1]].carriedBy)
    end
  end
  table.remove(mineAssets, _ARG_0_).handlerFunction(currentMine, unpack(table.remove(mineAssets, _ARG_0_).handlerFunctionParams))
end
function checkMinePermission(_ARG_0_)
  if not selfCharacterId or not currentMineOwnerId then
    return false
  end
  if selfCharacterId == currentMineOwnerId then
    return true
  end
  if _ARG_0_ and currentMinePermissions[selfCharacterId] then
    return bitTest(currentMinePermissions[selfCharacterId], _ARG_0_)
  end
  return false
end
addEvent("gotMineHandItems", true)
addEventHandler("gotMineHandItems", localPlayer, function(_ARG_0_, _ARG_1_, _ARG_2_)
  for _FORV_6_ in pairs(_ARG_0_) do
    triggerEvent("syncPickaxe", _FORV_6_, true)
  end
  for _FORV_6_ in pairs(_ARG_1_) do
    triggerEvent("syncBagWield", _FORV_6_, true)
  end
  for _FORV_6_ in pairs(_ARG_2_) do
    triggerEvent("syncMineTablet", _FORV_6_, true)
  end
end)
function setBagWieldMode(_ARG_0_)
  mineAssets = _ARG_0_
  if mineAssets then
    exports.see_controls:toggleControl("fire", not _ARG_0_, "bagWieldMode")
  end
  return triggerServerEvent("syncBagWield", localPlayer, type(mineAssets) == "number")
end
addEvent("syncBagWield", true)
addEventHandler("syncBagWield", root, function(_ARG_0_)
  if isElement(source) and _ARG_0_ then
    mineAssets[source] = true
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
  if mineAssets[source] and not _UPVALUE1_[source] then
    _UPVALUE1_[source] = createObject(exports.see_modloader:getModelId("v4_burlap_sack"), 0, 0, 0)
    if isElement(_UPVALUE1_[source]) then
      exports.pattach:attach(_UPVALUE1_[source], source, 25, -0.017693201914203, -0.091659694702951, 0.056322265779161, 0, 0, 0)
      exports.pattach:setRotationQuaternion(_UPVALUE1_[source], {
        0.74603372741722,
        -0.55551711504458,
        0.13616751367391,
        -0.34101733191787
      })
      setObjectScale(_UPVALUE1_[source], 0.62763045756295, 1, 0.85229540297405)
    end
  end
end
function bagStreamOut()
  if eventName ~= "onClientPlayerStreamOut" then
    mineAssets[source] = nil
  end
  if isElement(_UPVALUE1_[source]) then
    destroyElement(_UPVALUE1_[source])
  end
  _UPVALUE1_[source] = nil
end
function setPickaxeMode(_ARG_0_)
  mineAssets = _ARG_0_
  if currentMine then
    exports.see_controls:toggleControl("fire", not _ARG_0_, "minePickaxeMode")
  end
  return triggerServerEvent("syncPickaxe", localPlayer, _ARG_0_)
end
function setPlayerMineAim(_ARG_0_, _ARG_1_, _ARG_2_)
  if _ARG_1_ then
    if not mineAssets[_ARG_0_] then
      mineAssets[_ARG_0_] = {_ARG_1_, _ARG_2_}
    else
      mineAssets[_ARG_0_][1] = _ARG_1_
      mineAssets[_ARG_0_][2] = _ARG_2_
    end
  elseif mineAssets[_ARG_0_] then
    mineAssets[_ARG_0_] = nil
    if not _UPVALUE1_[_ARG_0_] then
      setPedAnimation(_ARG_0_)
    end
  end
  if _ARG_0_ == localPlayer then
    triggerServerEvent("syncMineAim", localPlayer, _ARG_1_, _ARG_2_)
    if eventName ~= "syncMineAim" then
      exports.see_controls:toggleControl({
        "fire",
        "crouch",
        "action"
      }, not _ARG_1_, "minePickaxeAim")
    end
  end
end
function setPlayerMineHit(_ARG_0_, _ARG_1_)
  if _ARG_1_ then
    if not mineAssets[_ARG_0_] then
      mineAssets[_ARG_0_] = 0
    end
    _UPVALUE1_[_ARG_0_] = true
  else
    _UPVALUE1_[_ARG_0_] = nil
  end
  if _ARG_0_ == localPlayer then
    triggerServerEvent("syncMineHit", localPlayer, _ARG_1_)
  end
end
addEvent("syncPickaxe", true)
addEventHandler("syncPickaxe", root, function(_ARG_0_)
  if isElement(source) and _ARG_0_ then
    mineAssets[source] = true
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
  if mineAssets[source] and not _UPVALUE1_[source] then
    _UPVALUE1_[source] = createObject(exports.see_modloader:getModelId("weapon_pickaxe"), 0, 0, 0)
    if isElement(_UPVALUE1_[source]) then
      exports.pattach:attach(_UPVALUE1_[source], source, "weapon")
    end
  end
end
function pickaxeStreamOut()
  if eventName ~= "onClientPlayerStreamOut" then
    mineAssets[source] = nil
  end
  if isElement(_UPVALUE1_[source]) then
    destroyElement(_UPVALUE1_[source])
  end
  _UPVALUE1_[source] = nil
end
;(function(_ARG_0_, _ARG_1_, _ARG_2_)
  addEvent(_ARG_0_, true)
  addEventHandler(_ARG_0_, _ARG_1_, function(_ARG_0_, ...)
    if not loadingMineExit then
      if loadingMineEnter then
        if _ARG_0_ == loadingMineEnter then
          table.insert(mineAssets, {
            eventName = _UPVALUE1_,
            handlerFunction = _UPVALUE2_,
            handlerFunctionParams = {
              ...
            },
            sourceElement = source
          })
        end
      elseif _ARG_0_ == currentMine then
        _UPVALUE2_(_ARG_0_, ...)
      end
    end
  end)
end)("syncMineAim", root, function(_ARG_0_, _ARG_1_, _ARG_2_)
  if isElement(source) then
    setPlayerMineAim(source, _ARG_1_, _ARG_2_)
  end
end)
;(function(_ARG_0_, _ARG_1_, _ARG_2_)
  addEvent(_ARG_0_, true)
  addEventHandler(_ARG_0_, _ARG_1_, function(_ARG_0_, ...)
    if not loadingMineExit then
      if loadingMineEnter then
        if _ARG_0_ == loadingMineEnter then
          table.insert(mineAssets, {
            eventName = _UPVALUE1_,
            handlerFunction = _UPVALUE2_,
            handlerFunctionParams = {
              ...
            },
            sourceElement = source
          })
        end
      elseif _ARG_0_ == currentMine then
        _UPVALUE2_(_ARG_0_, ...)
      end
    end
  end)
end)("syncMineHit", root, function(_ARG_0_, _ARG_1_)
  if isElement(source) then
    setPlayerMineHit(source, _ARG_1_)
  end
end)
function playerWastedMine()
  if currentActiveBlockId then
    setPlayerMineAim(localPlayer, false, false)
    currentActiveBlockId = false
  end
  if mineAssets then
    setPlayerMineHit(localPlayer, false)
    mineAssets = false
  end
  forceExitLoco()
end
function pedsProcessedMine()
  pedsProcessedTrain({})
  pedsProcessedTablet({})
  for _FORV_4_, _FORV_5_ in pairs(cartTurtleEmptying) do
    if isElement(_FORV_5_) then
      setElementPosition(_FORV_5_, getElementPosition(cartTurtleObjects[_FORV_4_]))
      setElementRotation(_FORV_5_, 0, 0, 0, "default", true)
      setElementBoneRotation(_FORV_5_, 2, 0, 20 * (cartTurtleRotation[_FORV_4_] or 0), 0)
      setElementBoneRotation(_FORV_5_, 3, 0, 15 * (cartTurtleRotation[_FORV_4_] or 0), 0)
      setElementBoneRotation(_FORV_5_, 22, 13.043463333793, -49.565267148225, -20.869540338931)
      setElementBoneRotation(_FORV_5_, 23, -33.912973818572, -57.391204833984, 5.4732612909447E-5)
      setElementBoneRotation(_FORV_5_, 32, -13.043463333793, -49.565267148225, 20.869540338931)
      setElementBoneRotation(_FORV_5_, 33, -33.912973818572, -57.391204833984, 5.4732612909447E-5)
      ;({})[_FORV_5_] = true
    end
  end
  for _FORV_4_, _FORV_5_ in pairs(mineAssets) do
    if not _UPVALUE1_[_FORV_4_] and isElementStreamedIn(_FORV_4_) then
      if getPedAnimation(_FORV_4_) ~= "mining_hit" or getPedAnimation(_FORV_4_) ~= "bather" then
        setPedAnimation(_FORV_4_, "mining_hit", "bather", -1, true, false, false, true, 0)
      end
      setPedAnimationSpeed(_FORV_4_, "bather", 0)
      setPedAnimationProgress(_FORV_4_, "bather", 0.15)
    end
    if isElementOnScreen(_FORV_4_) and _UPVALUE2_[_FORV_5_[1]] then
      if _UPVALUE3_ == _FORV_5_[1] then
      else
      end
      if 20 < math.deg((math.atan2(getElementPosition(_FORV_4_) - getShaftBlockPosition(_FORV_5_[1], _FORV_5_[2]), getElementPosition(_FORV_4_) - getShaftBlockPosition(_FORV_5_[1], _FORV_5_[2])) + PI_2 - math.rad(getElementRotation(_FORV_4_)) + PI) % TWO_PI - PI) then
        setElementRotation(_FORV_4_, getElementRotation(_FORV_4_))
      elseif math.deg((math.atan2(getElementPosition(_FORV_4_) - getShaftBlockPosition(_FORV_5_[1], _FORV_5_[2]), getElementPosition(_FORV_4_) - getShaftBlockPosition(_FORV_5_[1], _FORV_5_[2])) + PI_2 - math.rad(getElementRotation(_FORV_4_)) + PI) % TWO_PI - PI) - 180 * mineDelta / 1000 < -20 then
        setElementRotation(_FORV_4_, getElementRotation(_FORV_4_))
      end
      if not _FORV_5_[3] then
        _FORV_5_[3] = math.deg((math.atan2(getElementPosition(_FORV_4_) - getShaftBlockPosition(_FORV_5_[1], _FORV_5_[2]), getElementPosition(_FORV_4_) - getShaftBlockPosition(_FORV_5_[1], _FORV_5_[2])) + PI_2 - math.rad(getElementRotation(_FORV_4_)) + PI) % TWO_PI - PI) - 180 * mineDelta / 1000 + 180 * mineDelta / 1000
      elseif _FORV_5_[3] ~= math.deg((math.atan2(getElementPosition(_FORV_4_) - getShaftBlockPosition(_FORV_5_[1], _FORV_5_[2]), getElementPosition(_FORV_4_) - getShaftBlockPosition(_FORV_5_[1], _FORV_5_[2])) + PI_2 - math.rad(getElementRotation(_FORV_4_)) + PI) % TWO_PI - PI) - 180 * mineDelta / 1000 + 180 * mineDelta / 1000 then
        if 0 < _FORV_5_[3] - (math.deg((math.atan2(getElementPosition(_FORV_4_) - getShaftBlockPosition(_FORV_5_[1], _FORV_5_[2]), getElementPosition(_FORV_4_) - getShaftBlockPosition(_FORV_5_[1], _FORV_5_[2])) + PI_2 - math.rad(getElementRotation(_FORV_4_)) + PI) % TWO_PI - PI) - 180 * mineDelta / 1000 + 180 * mineDelta / 1000) then
          _FORV_5_[3] = math.max(math.deg((math.atan2(getElementPosition(_FORV_4_) - getShaftBlockPosition(_FORV_5_[1], _FORV_5_[2]), getElementPosition(_FORV_4_) - getShaftBlockPosition(_FORV_5_[1], _FORV_5_[2])) + PI_2 - math.rad(getElementRotation(_FORV_4_)) + PI) % TWO_PI - PI) - 180 * mineDelta / 1000 + 180 * mineDelta / 1000, _FORV_5_[3] - 180 * mineDelta / 1000)
        elseif 0 > _FORV_5_[3] - (math.deg((math.atan2(getElementPosition(_FORV_4_) - getShaftBlockPosition(_FORV_5_[1], _FORV_5_[2]), getElementPosition(_FORV_4_) - getShaftBlockPosition(_FORV_5_[1], _FORV_5_[2])) + PI_2 - math.rad(getElementRotation(_FORV_4_)) + PI) % TWO_PI - PI) - 180 * mineDelta / 1000 + 180 * mineDelta / 1000) then
          _FORV_5_[3] = math.min(math.deg((math.atan2(getElementPosition(_FORV_4_) - getShaftBlockPosition(_FORV_5_[1], _FORV_5_[2]), getElementPosition(_FORV_4_) - getShaftBlockPosition(_FORV_5_[1], _FORV_5_[2])) + PI_2 - math.rad(getElementRotation(_FORV_4_)) + PI) % TWO_PI - PI) - 180 * mineDelta / 1000 + 180 * mineDelta / 1000, _FORV_5_[3] + 180 * mineDelta / 1000)
        end
      end
      if not _FORV_5_[4] then
        _FORV_5_[4] = math.deg(math.asin((getShaftBlockPosition(_FORV_5_[1], _FORV_5_[2]) - getElementPosition(_FORV_4_)) / getDistanceBetweenPoints3D(getShaftBlockPosition(_FORV_5_[1], _FORV_5_[2]))))
      elseif _FORV_5_[4] ~= math.deg(math.asin((getShaftBlockPosition(_FORV_5_[1], _FORV_5_[2]) - getElementPosition(_FORV_4_)) / getDistanceBetweenPoints3D(getShaftBlockPosition(_FORV_5_[1], _FORV_5_[2])))) then
        if 0 < _FORV_5_[4] - math.deg(math.asin((getShaftBlockPosition(_FORV_5_[1], _FORV_5_[2]) - getElementPosition(_FORV_4_)) / getDistanceBetweenPoints3D(getShaftBlockPosition(_FORV_5_[1], _FORV_5_[2])))) then
          _FORV_5_[4] = math.max(math.deg(math.asin((getShaftBlockPosition(_FORV_5_[1], _FORV_5_[2]) - getElementPosition(_FORV_4_)) / getDistanceBetweenPoints3D(getShaftBlockPosition(_FORV_5_[1], _FORV_5_[2])))), _FORV_5_[4] - 180 * mineDelta / 1000)
        elseif 0 > _FORV_5_[4] - math.deg(math.asin((getShaftBlockPosition(_FORV_5_[1], _FORV_5_[2]) - getElementPosition(_FORV_4_)) / getDistanceBetweenPoints3D(getShaftBlockPosition(_FORV_5_[1], _FORV_5_[2])))) then
          _FORV_5_[4] = math.min(math.deg(math.asin((getShaftBlockPosition(_FORV_5_[1], _FORV_5_[2]) - getElementPosition(_FORV_4_)) / getDistanceBetweenPoints3D(getShaftBlockPosition(_FORV_5_[1], _FORV_5_[2])))), _FORV_5_[4] + 180 * mineDelta / 1000)
        end
      end
      setElementBoneRotation(_FORV_4_, 2, getElementBoneRotation(_FORV_4_, 2) + (math.max(-20, math.min(20, _FORV_5_[3])) - 22) / 2, getElementBoneRotation(_FORV_4_, 2) - math.min(20, _FORV_5_[4] - 10), getElementBoneRotation(_FORV_4_, 2))
      setElementBoneRotation(_FORV_4_, 3, getElementBoneRotation(_FORV_4_, 3) + (math.max(-20, math.min(20, _FORV_5_[3])) - 22) / 2, getElementBoneRotation(_FORV_4_, 3))
      ;({})[_FORV_4_] = true
    end
  end
  for _FORV_4_ in pairs({}) do
    updateElementRpHAnim(_FORV_4_)
  end
  processFixOrePlayers()
end
function isPlayerFreeFromAction(_ARG_0_)
  if not mineAssets[_ARG_0_] and currentMineInventory.jerryCarry ~= _ARG_0_ then
    if _ARG_0_ == localPlayer then
      return not carryingFixOre and not emptyingTurtle and getElementHealth(localPlayer) > 0
    else
      for _FORV_4_, _FORV_5_ in pairs(_UPVALUE1_) do
        if _FORV_5_ == _ARG_0_ then
          return false
        end
      end
      for _FORV_4_, _FORV_5_ in pairs(cartTurtleEmptying) do
        if _FORV_5_ == _ARG_0_ then
          return false
        end
      end
      return true
    end
  end
  return false
end
function preRenderMine(_ARG_0_)
  mineTick = getTickCount()
  mineDelta = _ARG_0_
  if not loadingMineExit then
    setTime(12, 0)
    setWeather(1)
    setSkyGradient(0, 0, 0, 0, 0, 0)
    setFarClipDistance(insideFarClipDistance)
    setFogDistance(21)
  end
  mineAssets = nil
  selfPosX, selfPosY, selfPosZ = getElementPosition(localPlayer)
  selfMineX = convertSingleMineCoordinate(selfPosX)
  selfMineY = convertSingleMineCoordinate(selfPosY)
  selfCamX, selfCamY, selfCamZ, selfCamTargetX, selfCamTargetY, selfCamTargetZ = getCameraMatrix()
  selfCamDirX = selfCamX - selfCamTargetX
  selfCamDirY = selfCamY - selfCamTargetY
  selfCamDirZ = selfCamZ - selfCamTargetZ
  selfCamDirX = selfCamDirX * (1 / math.sqrt(selfCamDirX ^ 2 + selfCamDirY ^ 2 + selfCamDirZ ^ 2))
  selfCamDirY = selfCamDirY * (1 / math.sqrt(selfCamDirX ^ 2 + selfCamDirY ^ 2 + selfCamDirZ ^ 2))
  selfCamDirZ = selfCamDirZ * (1 / math.sqrt(selfCamDirX ^ 2 + selfCamDirY ^ 2 + selfCamDirZ ^ 2))
  doMineJobs()
  if 1 >= convertSingleMineCoordinate(selfCamX) then
    for _FORV_5_ = 1, #_UPVALUE1_ do
      dxDrawMaterialSectionLine3D(unpack(_UPVALUE1_[_FORV_5_]))
    end
  end
  if isPlayerFreeFromAction(localPlayer) then
    freeFromAction = true
  else
    freeFromAction = false
  end
  if isElement(_UPVALUE2_) then
    setSoundVolume(_UPVALUE2_, 0.5 + math.max(0, math.min((selfCamX + 9) / 4, 1) * 0.5))
  end
  if not _UPVALUE3_ then
    _UPVALUE3_ = coroutine.create(doFixOreStreaming)
  elseif coroutine.status(_UPVALUE3_) == "dead" then
    _UPVALUE3_ = coroutine.create(doFixOreStreaming)
  else
    coroutine.resume(_UPVALUE3_)
  end
  if currentMineInventory.fuelTankLevel ~= currentMineInventory.displayedFuelTankLevel then
    if currentMineInventory.displayedFuelTankLevel < currentMineInventory.fuelTankLevel then
      currentMineInventory.displayedFuelTankLevel = currentMineInventory.fuelTankLevel
    else
      currentMineInventory.displayedFuelTankLevel = currentMineInventory.displayedFuelTankLevel - _ARG_0_ / 1000
      if currentMineInventory.displayedFuelTankLevel < currentMineInventory.fuelTankLevel then
        currentMineInventory.displayedFuelTankLevel = currentMineInventory.fuelTankLevel
      end
    end
  end
  if shouldRefreshJerryContent then
    if currentMineInventory.displayedJerryContent < currentMineInventory.jerryContent then
      currentMineInventory.displayedJerryContent = currentMineInventory.displayedJerryContent + _ARG_0_ / 1000
      if currentMineInventory.displayedJerryContent > currentMineInventory.jerryContent then
        currentMineInventory.displayedJerryContent = currentMineInventory.jerryContent
      end
    else
      currentMineInventory.displayedJerryContent = currentMineInventory.displayedJerryContent - _ARG_0_ / 1000
      if currentMineInventory.displayedJerryContent < currentMineInventory.jerryContent then
        currentMineInventory.displayedJerryContent = currentMineInventory.jerryContent
      end
    end
    if 0 >= math.abs(currentMineInventory.jerryContent - currentMineInventory.displayedJerryContent) / 0.5 then
      shouldRefreshJerryContent = false
      if isElement(currentMineInventory.jerrySound) then
        setSoundVolume(currentMineInventory.jerrySound, 0)
      end
    elseif isElement(currentMineInventory.jerrySound) then
      setSoundVolume(currentMineInventory.jerrySound, math.min(1, math.abs(currentMineInventory.jerryContent - currentMineInventory.displayedJerryContent) / 0.5) * 0.5)
    end
  end
  if shouldRefreshBoxContent then
    for _FORV_6_, _FORV_7_ in pairs(oreTypes) do
      if not _FORV_7_.instantItem then
        if _FORV_7_.boxContent ~= _FORV_7_.displayedBoxContent then
          if _FORV_7_.displayedBoxContent < _FORV_7_.boxContent then
            _FORV_7_.displayedBoxContent = _FORV_7_.displayedBoxContent + _ARG_0_ / 10000
            if _FORV_7_.displayedBoxContent > _FORV_7_.boxContent then
              _FORV_7_.displayedBoxContent = _FORV_7_.boxContent
            end
          else
            _FORV_7_.displayedBoxContent = _FORV_7_.displayedBoxContent - _ARG_0_ / 5000
            if _FORV_7_.displayedBoxContent < _FORV_7_.boxContent then
              _FORV_7_.displayedBoxContent = _FORV_7_.boxContent
            end
          end
        end
        refreshOreBoxScale(_FORV_6_)
      end
    end
    shouldRefreshBoxContent = checkOreBuffer(_FORV_6_) and true
  end
  if shouldRefreshFoundryContent then
    for _FORV_6_, _FORV_7_ in pairs(oreTypes) do
      if _FORV_7_.foundryContent ~= _FORV_7_.displayedFoundryContent then
        if _FORV_7_.displayedFoundryContent < _FORV_7_.foundryContent then
          _FORV_7_.displayedFoundryContent = _FORV_7_.displayedFoundryContent + math.min(_ARG_0_ / 2222.222222222222, _FORV_7_.foundryContent - _FORV_7_.displayedFoundryContent)
          _FORV_7_.furnaceTemperature = _FORV_7_.furnaceTemperature - math.min(_ARG_0_ / 2222.222222222222, _FORV_7_.foundryContent - _FORV_7_.displayedFoundryContent) * 150
          if 0 > _FORV_7_.furnaceTemperature then
            _FORV_7_.furnaceTemperature = 0
          end
        else
          _FORV_7_.displayedFoundryContent = _FORV_7_.displayedFoundryContent - _ARG_0_ / 10000
          if _FORV_7_.displayedFoundryContent < _FORV_7_.foundryContent then
            _FORV_7_.displayedFoundryContent = _FORV_7_.foundryContent
          end
        end
      end
    end
    shouldRefreshFoundryContent = true
  end
  if _UPVALUE4_ then
    if _UPVALUE5_[_UPVALUE4_] then
      if not isShaftWallVisible(_UPVALUE4_, true) then
        setCurrentActiveOpenShaft(false)
      else
        if _UPVALUE6_ then
          processCurrentActiveWorld()
        end
        dxDrawMaterialPrimitive3D("trianglelist", currentActiveShaftShader, "prefx", unpack(_UPVALUE7_))
      end
    else
      setCurrentActiveOpenShaft(false)
    end
  end
  for _FORV_8_ in pairs(_UPVALUE8_) do
    if isShaftWallVisible(_FORV_8_) and (not _UPVALUE4_ or not isShaftWallVisible(_UPVALUE4_, true) or isShaftWallVisible(_UPVALUE4_, true) > isShaftWallVisible(_FORV_8_)) then
    end
    if _UPVALUE4_ ~= _FORV_8_ and _FORV_8_ ~= _FORV_8_ and isShaftWallVisible(_FORV_8_) then
      if not _UPVALUE10_[_FORV_8_] then
        _UPVALUE10_[_FORV_8_] = createObject(_UPVALUE11_, _UPVALUE9_[_FORV_8_][1], _UPVALUE9_[_FORV_8_][2], minePosZ, 0, 0, _UPVALUE12_[_FORV_8_][1])
        if isElement(_UPVALUE10_[_FORV_8_]) then
          setElementInterior(_UPVALUE10_[_FORV_8_], 0)
          setElementDimension(_UPVALUE10_[_FORV_8_], currentMine)
        end
      end
      if mineTick - _UPVALUE13_[_FORV_8_] > 5000 and not _UPVALUE14_ then
        _UPVALUE8_[_FORV_8_] = nil
        _UPVALUE13_[_FORV_8_] = mineTick
        _UPVALUE14_ = coroutine.create(generateOpenShaftDff)
        _UPVALUE15_ = mineTick
        _UPVALUE16_ = _FORV_8_
      end
    end
  end
  for _FORV_8_ in pairs(_UPVALUE17_) do
    if not _UPVALUE18_[_FORV_8_] then
      if isShaftWallVisible(_FORV_8_, true) then
        _UPVALUE19_[_FORV_8_] = nil
      else
        _UPVALUE19_[_FORV_8_] = (_UPVALUE19_[_FORV_8_] or 0) + _ARG_0_
        if _UPVALUE19_[_FORV_8_] > 2500 or modelPoolCount > 10 then
          _UPVALUE8_[_FORV_8_] = true
          if isElement(_UPVALUE10_[_FORV_8_]) then
            destroyElement(_UPVALUE10_[_FORV_8_])
          end
          if isElement(_UPVALUE20_[_FORV_8_]) then
            destroyElement(_UPVALUE20_[_FORV_8_])
          end
          if _UPVALUE17_[_FORV_8_] then
            poolFreeModel(_UPVALUE17_[_FORV_8_])
          end
          _UPVALUE17_[_FORV_8_] = nil
        end
      end
    end
  end
  _UPVALUE21_ = false
  _UPVALUE22_ = false
  _UPVALUE23_ = false
  _UPVALUE24_ = false
  if _UPVALUE4_ then
    _UPVALUE21_ = _UPVALUE4_
    _UPVALUE22_ = getDistanceBetweenPoints2D(selfPosX, selfPosY, _UPVALUE25_, _UPVALUE26_)
    _UPVALUE23_ = _UPVALUE25_
    _UPVALUE24_ = _UPVALUE26_
  end
  for _FORV_8_ in pairs(_UPVALUE5_) do
    if isShaftWallVisible(_FORV_8_) then
      if isShaftWallVisible(_FORV_8_) <= (_UPVALUE22_ or isShaftWallVisible(_FORV_8_)) then
        _UPVALUE22_, _UPVALUE21_ = isShaftWallVisible(_FORV_8_)
        _UPVALUE22_, _UPVALUE21_ = isShaftWallVisible(_FORV_8_)
        _UPVALUE23_ = _UPVALUE9_[_FORV_8_][1]
        _UPVALUE24_ = _UPVALUE9_[_FORV_8_][2]
      end
    end
  end
  if not _UPVALUE27_ then
  elseif not _UPVALUE21_ then
  elseif openShaftBombs[_UPVALUE21_] then
  elseif not checkMinePermission(permissionFlags.MINING) then
  end
  for _FORV_9_ in pairs(_UPVALUE28_) do
    if 0 >= math.min(1, _UPVALUE28_[_FORV_9_] + (_UPVALUE29_[_FORV_9_] and _ARG_0_ / 750 or -_ARG_0_ / 187.5)) then
      _UPVALUE28_[_FORV_9_] = nil
      _UPVALUE29_[_FORV_9_] = nil
      if not _UPVALUE30_[_FORV_9_] then
        setPedAnimation(_FORV_9_)
      end
    else
      _UPVALUE28_[_FORV_9_] = math.min(1, _UPVALUE28_[_FORV_9_] + (_UPVALUE29_[_FORV_9_] and _ARG_0_ / 750 or -_ARG_0_ / 187.5))
      if isElementStreamedIn(_FORV_9_) then
        if getPedAnimation(_FORV_9_) ~= "mining_hit" or getPedAnimation(_FORV_9_) ~= "bather" then
          setPedAnimation(_FORV_9_, "mining_hit", "bather", -1, true, false, false, true, 0)
        end
        setPedAnimationSpeed(_FORV_9_, "bather", 0)
        setPedAnimationProgress(_FORV_9_, "bather", 0.15 + math.pow(math.min(1, _UPVALUE28_[_FORV_9_] + (_UPVALUE29_[_FORV_9_] and _ARG_0_ / 750 or -_ARG_0_ / 187.5)), 2) * 0.825)
      end
    end
  end
  if false then
    if getPedControlState(localPlayer, "aim_weapon") then
      if getPedTargetEnd(localPlayer) then
        if getScreenFromWorldPosition(getPedTargetEnd(localPlayer)) then
          dxDrawRectangle(getScreenFromWorldPosition(getPedTargetEnd(localPlayer)) - 12 - 5, getScreenFromWorldPosition(getPedTargetEnd(localPlayer)) - 2, 12, 4, guiColors.primaryGreen)
          dxDrawRectangle(getScreenFromWorldPosition(getPedTargetEnd(localPlayer)) + 5, getScreenFromWorldPosition(getPedTargetEnd(localPlayer)) - 2, 12, 4, guiColors.primaryGreen)
          dxDrawRectangle(getScreenFromWorldPosition(getPedTargetEnd(localPlayer)) - 5, getScreenFromWorldPosition(getPedTargetEnd(localPlayer)) - 4, 2, 8, guiColors.primaryGreen)
          dxDrawRectangle(getScreenFromWorldPosition(getPedTargetEnd(localPlayer)) + 3, getScreenFromWorldPosition(getPedTargetEnd(localPlayer)) - 4, 2, 8, guiColors.primaryGreen)
        end
        if _UPVALUE31_ then
          for _FORV_24_ = 1, wallBlockCount do
          end
          _UPVALUE31_ = _FOR_.min(1, _UPVALUE31_ + _ARG_0_ / 750)
          if not getKeyState("mouse1") then
            setPlayerMineHit(localPlayer, false)
            if _UPVALUE31_ > 0.3 then
              triggerServerEvent("handleMineHit", localPlayer, _UPVALUE21_, currentActiveBlockId, math.pow((_UPVALUE31_ - 0.3) / 0.7, 2))
            end
            _UPVALUE31_ = false
          end
        else
          if _UPVALUE22_ < 3 then
            for _FORV_25_ = 1, wallBlockCount do
              if computeLineDistance(getShaftBlockPosition(_UPVALUE21_, _FORV_25_) - _UPVALUE12_[_UPVALUE21_][3] * 0.1, getShaftBlockPosition(_UPVALUE21_, _FORV_25_) - _UPVALUE12_[_UPVALUE21_][4] * 0.1, getShaftBlockPosition(_UPVALUE21_, _FORV_25_)) then
                if computeLineDistance(getShaftBlockPosition(_UPVALUE21_, _FORV_25_) - _UPVALUE12_[_UPVALUE21_][3] * 0.1, getShaftBlockPosition(_UPVALUE21_, _FORV_25_) - _UPVALUE12_[_UPVALUE21_][4] * 0.1, getShaftBlockPosition(_UPVALUE21_, _FORV_25_)) <= (nil or computeLineDistance(getShaftBlockPosition(_UPVALUE21_, _FORV_25_) - _UPVALUE12_[_UPVALUE21_][3] * 0.1, getShaftBlockPosition(_UPVALUE21_, _FORV_25_) - _UPVALUE12_[_UPVALUE21_][4] * 0.1, getShaftBlockPosition(_UPVALUE21_, _FORV_25_))) then
                end
              end
              ;({})[_FORV_25_] = {
                getShaftBlockPosition(_UPVALUE21_, _FORV_25_) - _UPVALUE12_[_UPVALUE21_][3] * 0.1,
                getShaftBlockPosition(_UPVALUE21_, _FORV_25_) - _UPVALUE12_[_UPVALUE21_][4] * 0.1,
                getShaftBlockPosition(_UPVALUE21_, _FORV_25_)
              }
            end
            for _FORV_25_ = 1, wallBlockCount do
              if _FORV_25_ ~= _FORV_25_ then
                dxDrawMaterialLine3D(unpack(({})[_FORV_25_]))
              end
            end
          end
          if currentActiveBlockId ~= _FORV_25_ then
            currentActiveBlockId = _FORV_25_
            if _FORV_25_ then
              setPlayerMineAim(localPlayer, _UPVALUE21_, _FORV_25_)
            else
              setPlayerMineAim(localPlayer, false, false)
            end
          end
          if currentActiveBlockId and getKeyState("mouse1") and (_UPVALUE5_[_UPVALUE21_][_FORV_25_] - _UPVALUE5_[_UPVALUE21_][_FORV_25_]) / (wallMaximumDepth * wallMaximumDepth) <= 0.9 then
            _UPVALUE31_ = 0
            setPlayerMineHit(localPlayer, true)
          end
        end
        if currentActiveBlockId then
          if _UPVALUE31_ and 0 < math.pow(_UPVALUE31_, 2) then
            dxDrawMaterialSectionLine3D(getShaftBlockPosition(_UPVALUE21_, _FORV_25_) - _UPVALUE12_[_UPVALUE21_][3] * 0.1, getShaftBlockPosition(_UPVALUE21_, _FORV_25_) - _UPVALUE12_[_UPVALUE21_][4] * 0.1, getShaftBlockPosition(_UPVALUE21_, _FORV_25_) - 0.25 + 0.5 * math.pow(_UPVALUE31_, 2), getShaftBlockPosition(_UPVALUE21_, _FORV_25_) - _UPVALUE12_[_UPVALUE21_][3] * 0.1, getShaftBlockPosition(_UPVALUE21_, _FORV_25_) - _UPVALUE12_[_UPVALUE21_][4] * 0.1, getShaftBlockPosition(_UPVALUE21_, _FORV_25_) - 0.25, 0, 128 * (1 - math.pow(_UPVALUE31_, 2)), 128, 128 * math.pow(_UPVALUE31_, 2), _UPVALUE32_.mineCircle, 0.5, tocolor(getMiningZoneColor((_UPVALUE5_[_UPVALUE21_][_FORV_25_] - _UPVALUE5_[_UPVALUE21_][_FORV_25_]) / (wallMaximumDepth * wallMaximumDepth))[1], getMiningZoneColor((_UPVALUE5_[_UPVALUE21_][_FORV_25_] - _UPVALUE5_[_UPVALUE21_][_FORV_25_]) / (wallMaximumDepth * wallMaximumDepth))[2], getMiningZoneColor((_UPVALUE5_[_UPVALUE21_][_FORV_25_] - _UPVALUE5_[_UPVALUE21_][_FORV_25_]) / (wallMaximumDepth * wallMaximumDepth))[3], 200), getShaftBlockPosition(_UPVALUE21_, _FORV_25_) - _UPVALUE12_[_UPVALUE21_][3] * 0.1 - _UPVALUE12_[_UPVALUE21_][3], getShaftBlockPosition(_UPVALUE21_, _FORV_25_) - _UPVALUE12_[_UPVALUE21_][4] * 0.1 - _UPVALUE12_[_UPVALUE21_][4], getShaftBlockPosition(_UPVALUE21_, _FORV_25_))
          end
          dxDrawMaterialLine3D(getShaftBlockPosition(_UPVALUE21_, _FORV_25_) - _UPVALUE12_[_UPVALUE21_][3] * 0.1, getShaftBlockPosition(_UPVALUE21_, _FORV_25_) - _UPVALUE12_[_UPVALUE21_][4] * 0.1, getShaftBlockPosition(_UPVALUE21_, _FORV_25_) + 0.25, getShaftBlockPosition(_UPVALUE21_, _FORV_25_) - _UPVALUE12_[_UPVALUE21_][3] * 0.1, getShaftBlockPosition(_UPVALUE21_, _FORV_25_) - _UPVALUE12_[_UPVALUE21_][4] * 0.1, getShaftBlockPosition(_UPVALUE21_, _FORV_25_) - 0.25, _UPVALUE32_.mineAim, 0.5, tocolor(getMiningZoneColor((_UPVALUE5_[_UPVALUE21_][_FORV_25_] - _UPVALUE5_[_UPVALUE21_][_FORV_25_]) / (wallMaximumDepth * wallMaximumDepth))[1], getMiningZoneColor((_UPVALUE5_[_UPVALUE21_][_FORV_25_] - _UPVALUE5_[_UPVALUE21_][_FORV_25_]) / (wallMaximumDepth * wallMaximumDepth))[2], getMiningZoneColor((_UPVALUE5_[_UPVALUE21_][_FORV_25_] - _UPVALUE5_[_UPVALUE21_][_FORV_25_]) / (wallMaximumDepth * wallMaximumDepth))[3], 155), getShaftBlockPosition(_UPVALUE21_, _FORV_25_) - _UPVALUE12_[_UPVALUE21_][3] * 0.1 - _UPVALUE12_[_UPVALUE21_][3], getShaftBlockPosition(_UPVALUE21_, _FORV_25_) - _UPVALUE12_[_UPVALUE21_][4] * 0.1 - _UPVALUE12_[_UPVALUE21_][4], getShaftBlockPosition(_UPVALUE21_, _FORV_25_))
        end
      end
    else
      if currentActiveBlockId then
        setPlayerMineAim(localPlayer, false, false)
        currentActiveBlockId = false
      end
      if _UPVALUE31_ then
        setPlayerMineHit(localPlayer, false)
        _UPVALUE31_ = false
      end
    end
  else
    if currentActiveBlockId then
      setPlayerMineAim(localPlayer, false, false)
      currentActiveBlockId = false
    end
    if _UPVALUE31_ then
      setPlayerMineHit(localPlayer, false)
      _UPVALUE31_ = false
    end
  end
  if _FORV_8_ then
    setCurrentActiveOpenShaft(_FORV_8_)
  end
  for _FORV_9_, _FORV_10_ in pairs(_UPVALUE33_) do
    if _UPVALUE4_ == _FORV_9_ or isShaftWallVisible(_FORV_9_) then
      for _FORV_16_ = 1, #_FORV_10_ do
        if _FORV_10_[_FORV_16_] and not isElement(_FORV_10_[_FORV_16_][5]) then
          if unpack(_FORV_10_[_FORV_16_]) - 0.5 <= _UPVALUE34_[_FORV_9_] + 1.2 then
            if isElement((createObject(modelIds[oreTypes[unpack(_FORV_10_[_FORV_16_])] and oreTypes[unpack(_FORV_10_[_FORV_16_])].modelName or "v4_mine_ore" .. math.random(1, 5)], minePosX + unpack(_FORV_10_[_FORV_16_]), minePosY + unpack(_FORV_10_[_FORV_16_]), minePosZ + unpack(_FORV_10_[_FORV_16_]), math.random() * 360, math.random() * 360, math.random() * 360))) then
              refreshOreShader(createObject(modelIds[oreTypes[unpack(_FORV_10_[_FORV_16_])] and oreTypes[unpack(_FORV_10_[_FORV_16_])].modelName or "v4_mine_ore" .. math.random(1, 5)], minePosX + unpack(_FORV_10_[_FORV_16_]), minePosY + unpack(_FORV_10_[_FORV_16_]), minePosZ + unpack(_FORV_10_[_FORV_16_]), math.random() * 360, math.random() * 360, math.random() * 360), unpack(_FORV_10_[_FORV_16_]))
              setElementInterior(createObject(modelIds[oreTypes[unpack(_FORV_10_[_FORV_16_])] and oreTypes[unpack(_FORV_10_[_FORV_16_])].modelName or "v4_mine_ore" .. math.random(1, 5)], minePosX + unpack(_FORV_10_[_FORV_16_]), minePosY + unpack(_FORV_10_[_FORV_16_]), minePosZ + unpack(_FORV_10_[_FORV_16_]), math.random() * 360, math.random() * 360, math.random() * 360), 0)
              setElementDimension(createObject(modelIds[oreTypes[unpack(_FORV_10_[_FORV_16_])] and oreTypes[unpack(_FORV_10_[_FORV_16_])].modelName or "v4_mine_ore" .. math.random(1, 5)], minePosX + unpack(_FORV_10_[_FORV_16_]), minePosY + unpack(_FORV_10_[_FORV_16_]), minePosZ + unpack(_FORV_10_[_FORV_16_]), math.random() * 360, math.random() * 360, math.random() * 360), currentMine)
            end
            _FORV_10_[_FORV_16_][5] = createObject(modelIds[oreTypes[unpack(_FORV_10_[_FORV_16_])] and oreTypes[unpack(_FORV_10_[_FORV_16_])].modelName or "v4_mine_ore" .. math.random(1, 5)], minePosX + unpack(_FORV_10_[_FORV_16_]), minePosY + unpack(_FORV_10_[_FORV_16_]), minePosZ + unpack(_FORV_10_[_FORV_16_]), math.random() * 360, math.random() * 360, math.random() * 360)
          end
        end
      end
    end
  end
  processFallingOres(_ARG_0_ / 1000)
  processParticles(_ARG_0_ / 1000)
  processRailCars(_ARG_0_ / 1000)
  for _FORV_9_, _FORV_10_ in pairs(openShaftBombs) do
    processDynamiteEffect(_FORV_10_, _ARG_0_)
  end
  for _FORV_9_ in pairs(shaftBombs) do
    for _FORV_13_ in pairs(shaftBombs[_FORV_9_]) do
      for _FORV_17_ in pairs(shaftBombs[_FORV_9_][_FORV_13_]) do
        processDynamiteEffect(shaftBombs[_FORV_9_][_FORV_13_][_FORV_17_], _ARG_0_)
      end
    end
  end
  for _FORV_9_ in pairs(threeJunctionBombs) do
    for _FORV_13_ in pairs(threeJunctionBombs[_FORV_9_]) do
      processDynamiteEffect(threeJunctionBombs[_FORV_9_][_FORV_13_], _ARG_0_)
    end
  end
  for _FORV_9_ = #bombDetonations, 1, -1 do
    if 1 > bombDetonations[_FORV_9_][4] + 1.5 * _ARG_0_ / 1000 then
      bombDetonations[_FORV_9_][4] = bombDetonations[_FORV_9_][4] + 1.5 * _ARG_0_ / 1000
    else
      table.remove(bombDetonations, _FORV_9_)
    end
  end
  if _UPVALUE35_[localPlayer] and oreTypes[_UPVALUE35_[localPlayer]] then
    dxDrawMaterialLine3D(unpack(oreTypes[_UPVALUE35_[localPlayer]].foundryInputPosition))
  end
  for _FORV_12_ = 1, #cartTurtleObjects do
    if cartTurtleEmptying[_FORV_12_] then
      if 0 >= (cartTurtleRotation[_FORV_12_] or 0) and isElement((playSound3D("files/sounds/turtleemptying.wav", 0, 0, 0))) then
        setElementInterior(playSound3D("files/sounds/turtleemptying.wav", 0, 0, 0), 0)
        setElementDimension(playSound3D("files/sounds/turtleemptying.wav", 0, 0, 0), currentMine)
        setSoundMaxDistance(playSound3D("files/sounds/turtleemptying.wav", 0, 0, 0), 40)
        if isElement(cartTurtleObjects[_FORV_12_]) then
          attachElements(playSound3D("files/sounds/turtleemptying.wav", 0, 0, 0), cartTurtleObjects[_FORV_12_])
        end
      end
      cartTurtleRotation[_FORV_12_] = math.min(1, (cartTurtleRotation[_FORV_12_] or 0) + _ARG_0_ / 2000)
      if isElement(cartTurtleObjects[_FORV_12_]) then
        if getElementRotation(cartTurtleObjects[_FORV_12_]) >= 180 then
          setElementAttachedOffsets(cartTurtleObjects[_FORV_12_], 0.0212, 0, 0.801, 85 * getEasingValue(cartTurtleRotation[_FORV_12_], "InOutQuad"), 0, 0)
        else
          setElementAttachedOffsets(cartTurtleObjects[_FORV_12_], 0.0212, 0, 0.801, -85 * getEasingValue(cartTurtleRotation[_FORV_12_], "InOutQuad"), 0, 0)
        end
      end
    elseif cartTurtleRotation[_FORV_12_] then
      if 1 <= cartTurtleRotation[_FORV_12_] and isElement((playSound3D("files/sounds/turtleemptyingdone.wav", 0, 0, 0))) then
        setElementInterior(playSound3D("files/sounds/turtleemptyingdone.wav", 0, 0, 0), 0)
        setElementDimension(playSound3D("files/sounds/turtleemptyingdone.wav", 0, 0, 0), currentMine)
        setSoundMaxDistance(playSound3D("files/sounds/turtleemptyingdone.wav", 0, 0, 0), 40)
        if isElement(cartTurtleObjects[_FORV_12_]) then
          attachElements(playSound3D("files/sounds/turtleemptyingdone.wav", 0, 0, 0), cartTurtleObjects[_FORV_12_])
        end
      end
      cartTurtleRotation[_FORV_12_] = cartTurtleRotation[_FORV_12_] - _ARG_0_ / 2000
      if 0 > cartTurtleRotation[_FORV_12_] then
        cartTurtleRotation[_FORV_12_] = nil
        if isElement(cartTurtleObjects[_FORV_12_]) then
          setElementAttachedOffsets(cartTurtleObjects[_FORV_12_], 0.0212, 0, 0.801, 0, 0, 0)
        end
      elseif isElement(cartTurtleObjects[_FORV_12_]) then
        if getElementRotation(cartTurtleObjects[_FORV_12_]) >= 180 then
          setElementAttachedOffsets(cartTurtleObjects[_FORV_12_], 0.0212, 0, 0.801, 85 * getEasingValue(cartTurtleRotation[_FORV_12_], "InOutQuad"), 0, 0)
        else
          setElementAttachedOffsets(cartTurtleObjects[_FORV_12_], 0.0212, 0, 0.801, -85 * getEasingValue(cartTurtleRotation[_FORV_12_], "InOutQuad"), 0, 0)
        end
      end
    elseif cartLastSlot[_FORV_12_] and _UPVALUE37_[cartLastSlot[_FORV_12_]] then
      if getElementPosition(cartTurtleObjects[_FORV_12_]) >= conveyorStartX - 0.25 and getElementPosition(cartTurtleObjects[_FORV_12_]) <= conveyorStartX + 0.25 then
        dxDrawMaterialLine3D(getElementPosition(cartTurtleObjects[_FORV_12_]))
      elseif 4 > math.abs(conveyorStartX - getElementPosition(cartTurtleObjects[_FORV_12_])) then
        dxDrawMaterialLine3D(getElementPosition(cartTurtleObjects[_FORV_12_]))
      end
    end
  end
  if 0 < _FOR_.machineRunProgress or #_UPVALUE38_ > 0 or #_UPVALUE39_ > 0 then
    for _FORV_12_ = #_UPVALUE38_, 1, -1 do
      while true do
        if _UPVALUE38_[_FORV_12_].animationStage == 1 then
          if 1 <= (mineTick - _UPVALUE38_[_FORV_12_].animationStart) / _UPVALUE38_[_FORV_12_].animationLength then
            _UPVALUE38_[_FORV_12_].animationStage = _UPVALUE38_[_FORV_12_].animationStage + 1
            _UPVALUE38_[_FORV_12_].animationStart = mineTick
            spawnSmokeExSm(conveyorStartX + _UPVALUE38_[_FORV_12_].oreBias, conveyorStartY, conveyorStartZ)
          else
            if isElement(_UPVALUE38_[_FORV_12_].oreElement) then
              setElementPosition(_UPVALUE38_[_FORV_12_].oreElement, _UPVALUE38_[_FORV_12_].orePosX + (conveyorStartX + _UPVALUE38_[_FORV_12_].oreBias - _UPVALUE38_[_FORV_12_].orePosX) * ((mineTick - _UPVALUE38_[_FORV_12_].animationStart) / _UPVALUE38_[_FORV_12_].animationLength), _UPVALUE38_[_FORV_12_].orePosY + (conveyorStartY - _UPVALUE38_[_FORV_12_].orePosY) * ((mineTick - _UPVALUE38_[_FORV_12_].animationStart) / _UPVALUE38_[_FORV_12_].animationLength), _UPVALUE38_[_FORV_12_].orePosZ + (conveyorStartZ - _UPVALUE38_[_FORV_12_].orePosZ) * getEasingValue((mineTick - _UPVALUE38_[_FORV_12_].animationStart) / _UPVALUE38_[_FORV_12_].animationLength, "OutQuad"))
            end
            break
          end
        elseif _UPVALUE38_[_FORV_12_].animationStage == 2 then
          if 1 <= (mineTick - _UPVALUE38_[_FORV_12_].animationStart) / conveyorDuration then
            _UPVALUE38_[_FORV_12_].animationStage = _UPVALUE38_[_FORV_12_].animationStage + 1
            _UPVALUE38_[_FORV_12_].animationStart = mineTick
            spawnSmokeExSm(conveyorEndX + _UPVALUE38_[_FORV_12_].oreBias, conveyorEndY + 1, conveyorEndZ)
          else
            if isElement(_UPVALUE38_[_FORV_12_].oreElement) then
              setElementPosition(_UPVALUE38_[_FORV_12_].oreElement, conveyorStartX + (conveyorEndX - conveyorStartX) * ((mineTick - _UPVALUE38_[_FORV_12_].animationStart) / conveyorDuration) + _UPVALUE38_[_FORV_12_].oreBias, conveyorStartY + (conveyorEndY - conveyorStartY) * ((mineTick - _UPVALUE38_[_FORV_12_].animationStart) / conveyorDuration), conveyorStartZ + (conveyorEndZ - conveyorStartZ) * ((mineTick - _UPVALUE38_[_FORV_12_].animationStart) / conveyorDuration))
            end
            break
          end
        elseif _UPVALUE38_[_FORV_12_].animationStage == 3 then
          if 1 <= (mineTick - _UPVALUE38_[_FORV_12_].animationStart) / (conveyorDuration / conveyorLength) then
            table.remove(_UPVALUE38_, _FORV_12_)
            if isElement(_UPVALUE38_[_FORV_12_].oreElement) then
              destroyElement(_UPVALUE38_[_FORV_12_].oreElement)
            end
            if isElement((playSound3D("files/sounds/machinegrind.wav", conveyorEndX + _UPVALUE38_[_FORV_12_].oreBias, conveyorEndY + 1, conveyorEndZ))) then
              setElementInterior(playSound3D("files/sounds/machinegrind.wav", conveyorEndX + _UPVALUE38_[_FORV_12_].oreBias, conveyorEndY + 1, conveyorEndZ), 0)
              setElementDimension(playSound3D("files/sounds/machinegrind.wav", conveyorEndX + _UPVALUE38_[_FORV_12_].oreBias, conveyorEndY + 1, conveyorEndZ), currentMine)
              setSoundMaxDistance(playSound3D("files/sounds/machinegrind.wav", conveyorEndX + _UPVALUE38_[_FORV_12_].oreBias, conveyorEndY + 1, conveyorEndZ), 60)
              setSoundVolume(playSound3D("files/sounds/machinegrind.wav", conveyorEndX + _UPVALUE38_[_FORV_12_].oreBias, conveyorEndY + 1, conveyorEndZ), 2)
            end
            spawnSorterOre(_UPVALUE38_[_FORV_12_].oreType, _UPVALUE38_[_FORV_12_].oreAmount)
            break
          end
          if isElement(_UPVALUE38_[_FORV_12_].oreElement) then
            setElementPosition(_UPVALUE38_[_FORV_12_].oreElement, conveyorEndX + _UPVALUE38_[_FORV_12_].oreBias, conveyorEndY + (mineTick - _UPVALUE38_[_FORV_12_].animationStart) / (conveyorDuration / conveyorLength), conveyorEndZ)
          end
          break
        else
          table.remove(_UPVALUE38_, _FORV_12_)
          if isElement(_UPVALUE38_[_FORV_12_].oreElement) then
            destroyElement(_UPVALUE38_[_FORV_12_].oreElement)
          end
          break
        end
      end
    end
    mineMachineData.sorterProgress = (mineMachineData.sorterProgress + _ARG_0_ / 200 * math.min(1, mineMachineData.machineRunProgress)) % 1
    if isElement(mineMachineData.mineMachine2) then
      setElementPosition(mineMachineData.mineMachine2, machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02, machinePosY, machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03)
    end
    if #_UPVALUE39_ > 0 then
      for _FORV_31_ = #_UPVALUE39_, 1, -1 do
        if 0.5 > _UPVALUE39_[_FORV_31_].currentPosition then
          if _UPVALUE39_[_FORV_31_].currentPosition <= -0.3372985 then
            if isElement(_UPVALUE39_[_FORV_31_].objectElement) then
              setObjectScale(_UPVALUE39_[_FORV_31_].objectElement, 0)
            end
          elseif isElement(_UPVALUE39_[_FORV_31_].objectElement) then
            setObjectScale(_UPVALUE39_[_FORV_31_].objectElement, 1)
          end
          if 0.75 < (-0.3372985 - -2.849194) / 3.349194 then
            if (-0.3372985 - -2.849194) / 3.349194 > 0.8 and not _UPVALUE39_[_FORV_31_].oreType and not _UPVALUE39_[_FORV_31_].effectPlayed then
              _UPVALUE39_[_FORV_31_].effectPlayed = true
              if isElement((playSound3D("files/sounds/orefall" .. math.random(1, 4) .. ".wav", machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 2.1249 + (machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 11.1369 - (machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 2.1249)) / math.sqrt((machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 11.1369 - (machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 2.1249)) ^ 2 + (machinePosY - 0.2139 - (machinePosY - 0.2139)) ^ 2 + (machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 - 0.2445 - (machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 + 0.2109)) ^ 2) * ((-0.3372985 - -2.849194) / 3.349194), machinePosY - 0.2139 + (machinePosY - 0.2139 - (machinePosY - 0.2139)) / math.sqrt((machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 11.1369 - (machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 2.1249)) ^ 2 + (machinePosY - 0.2139 - (machinePosY - 0.2139)) ^ 2 + (machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 - 0.2445 - (machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 + 0.2109)) ^ 2) * ((-0.3372985 - -2.849194) / 3.349194), machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 + 0.2109 + (machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 - 0.2445 - (machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 + 0.2109)) / math.sqrt((machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 11.1369 - (machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 2.1249)) ^ 2 + (machinePosY - 0.2139 - (machinePosY - 0.2139)) ^ 2 + (machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 - 0.2445 - (machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 + 0.2109)) ^ 2) * ((-0.3372985 - -2.849194) / 3.349194) + (0.15 + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.04)))) then
                setElementInterior(playSound3D("files/sounds/orefall" .. math.random(1, 4) .. ".wav", machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 2.1249 + (machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 11.1369 - (machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 2.1249)) / math.sqrt((machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 11.1369 - (machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 2.1249)) ^ 2 + (machinePosY - 0.2139 - (machinePosY - 0.2139)) ^ 2 + (machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 - 0.2445 - (machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 + 0.2109)) ^ 2) * ((-0.3372985 - -2.849194) / 3.349194), machinePosY - 0.2139 + (machinePosY - 0.2139 - (machinePosY - 0.2139)) / math.sqrt((machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 11.1369 - (machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 2.1249)) ^ 2 + (machinePosY - 0.2139 - (machinePosY - 0.2139)) ^ 2 + (machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 - 0.2445 - (machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 + 0.2109)) ^ 2) * ((-0.3372985 - -2.849194) / 3.349194), machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 + 0.2109 + (machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 - 0.2445 - (machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 + 0.2109)) / math.sqrt((machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 11.1369 - (machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 2.1249)) ^ 2 + (machinePosY - 0.2139 - (machinePosY - 0.2139)) ^ 2 + (machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 - 0.2445 - (machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 + 0.2109)) ^ 2) * ((-0.3372985 - -2.849194) / 3.349194) + (0.15 + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.04)), 0)
                setElementDimension(playSound3D("files/sounds/orefall" .. math.random(1, 4) .. ".wav", machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 2.1249 + (machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 11.1369 - (machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 2.1249)) / math.sqrt((machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 11.1369 - (machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 2.1249)) ^ 2 + (machinePosY - 0.2139 - (machinePosY - 0.2139)) ^ 2 + (machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 - 0.2445 - (machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 + 0.2109)) ^ 2) * ((-0.3372985 - -2.849194) / 3.349194), machinePosY - 0.2139 + (machinePosY - 0.2139 - (machinePosY - 0.2139)) / math.sqrt((machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 11.1369 - (machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 2.1249)) ^ 2 + (machinePosY - 0.2139 - (machinePosY - 0.2139)) ^ 2 + (machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 - 0.2445 - (machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 + 0.2109)) ^ 2) * ((-0.3372985 - -2.849194) / 3.349194), machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 + 0.2109 + (machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 - 0.2445 - (machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 + 0.2109)) / math.sqrt((machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 11.1369 - (machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 2.1249)) ^ 2 + (machinePosY - 0.2139 - (machinePosY - 0.2139)) ^ 2 + (machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 - 0.2445 - (machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 + 0.2109)) ^ 2) * ((-0.3372985 - -2.849194) / 3.349194) + (0.15 + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.04)), currentMine)
              end
              spawnSmokeEx(machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 2.1249 + (machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 11.1369 - (machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 2.1249)) / math.sqrt((machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 11.1369 - (machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 2.1249)) ^ 2 + (machinePosY - 0.2139 - (machinePosY - 0.2139)) ^ 2 + (machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 - 0.2445 - (machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 + 0.2109)) ^ 2) * ((-0.3372985 - -2.849194) / 3.349194), machinePosY - 0.2139 + (machinePosY - 0.2139 - (machinePosY - 0.2139)) / math.sqrt((machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 11.1369 - (machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 2.1249)) ^ 2 + (machinePosY - 0.2139 - (machinePosY - 0.2139)) ^ 2 + (machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 - 0.2445 - (machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 + 0.2109)) ^ 2) * ((-0.3372985 - -2.849194) / 3.349194), machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 + 0.2109 + (machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 - 0.2445 - (machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 + 0.2109)) / math.sqrt((machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 11.1369 - (machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 2.1249)) ^ 2 + (machinePosY - 0.2139 - (machinePosY - 0.2139)) ^ 2 + (machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 - 0.2445 - (machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 + 0.2109)) ^ 2) * ((-0.3372985 - -2.849194) / 3.349194) + (0.15 + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.04))
            end
          elseif not _UPVALUE39_[_FORV_31_].oreType then
          end
          if isElement(_UPVALUE39_[_FORV_31_].objectElement) then
            setElementPosition(_UPVALUE39_[_FORV_31_].objectElement, minePosX - 12.5775 + (machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 2.1249 + (machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 11.1369 - (machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 2.1249)) / math.sqrt((machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 11.1369 - (machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 2.1249)) ^ 2 + (machinePosY - 0.2139 - (machinePosY - 0.2139)) ^ 2 + (machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 - 0.2445 - (machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 + 0.2109)) ^ 2) * (0.5 + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 * math.pow(((-0.3372985 - -2.849194) / 3.349194 - 0.8) / 0.2, 2)) - math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 * (1 - math.pow(((-0.3372985 - -2.849194) / 3.349194 - 0.8) / 0.2, 2)) - (minePosX - 12.5775)) * ((-0.3372985 - -2.849194) / 3.349194), minePosY + 7.6567 + (machinePosY - 0.2139 + (machinePosY - 0.2139 - (machinePosY - 0.2139)) / math.sqrt((machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 11.1369 - (machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 2.1249)) ^ 2 + (machinePosY - 0.2139 - (machinePosY - 0.2139)) ^ 2 + (machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 - 0.2445 - (machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 + 0.2109)) ^ 2) * (0.5 + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 * math.pow(((-0.3372985 - -2.849194) / 3.349194 - 0.8) / 0.2, 2)) - (minePosY + 7.6567)) * ((-0.3372985 - -2.849194) / 3.349194), minePosZ + 4.0229 + (machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 + 0.2109 + (machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 - 0.2445 - (machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 + 0.2109)) / math.sqrt((machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 11.1369 - (machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 2.1249)) ^ 2 + (machinePosY - 0.2139 - (machinePosY - 0.2139)) ^ 2 + (machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 - 0.2445 - (machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 + 0.2109)) ^ 2) * (0.5 + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 * math.pow(((-0.3372985 - -2.849194) / 3.349194 - 0.8) / 0.2, 2)) + (0.15 + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.04) * math.pow(((-0.3372985 - -2.849194) / 3.349194 - 0.8) / 0.2, 2) - math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 * (1 - math.pow(((-0.3372985 - -2.849194) / 3.349194 - 0.8) / 0.2, 2)) - (minePosZ + 4.0229)) * ((-0.3372985 - -2.849194) / 3.349194))
          end
        else
          if _UPVALUE39_[_FORV_31_].currentPosition >= 9.023499 then
          end
          if isElement(_UPVALUE39_[_FORV_31_].objectElement) then
            setElementPosition(_UPVALUE39_[_FORV_31_].objectElement, machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 2.1249 + (machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 11.1369 - (machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 2.1249)) / math.sqrt((machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 11.1369 - (machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 2.1249)) ^ 2 + (machinePosY - 0.2139 - (machinePosY - 0.2139)) ^ 2 + (machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 - 0.2445 - (machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 + 0.2109)) ^ 2) * (-0.3372985 + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 * ((_UPVALUE39_[_FORV_31_].currentPosition - 9.023499) / 0.35) + 0.85 * _UPVALUE39_[_FORV_31_].animationProgress) - math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 * ((_UPVALUE39_[_FORV_31_].currentPosition - 9.023499) / 0.35), machinePosY - 0.2139 + (machinePosY - 0.2139 - (machinePosY - 0.2139)) / math.sqrt((machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 11.1369 - (machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 2.1249)) ^ 2 + (machinePosY - 0.2139 - (machinePosY - 0.2139)) ^ 2 + (machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 - 0.2445 - (machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 + 0.2109)) ^ 2) * (-0.3372985 + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 * ((_UPVALUE39_[_FORV_31_].currentPosition - 9.023499) / 0.35) + 0.85 * _UPVALUE39_[_FORV_31_].animationProgress), machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 + 0.2109 + (machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 - 0.2445 - (machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 + 0.2109)) / math.sqrt((machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 11.1369 - (machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 2.1249)) ^ 2 + (machinePosY - 0.2139 - (machinePosY - 0.2139)) ^ 2 + (machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 - 0.2445 - (machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 + 0.2109)) ^ 2) * (-0.3372985 + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 * ((_UPVALUE39_[_FORV_31_].currentPosition - 9.023499) / 0.35) + 0.85 * _UPVALUE39_[_FORV_31_].animationProgress) + (0.15 + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.04) * (1 - (_UPVALUE39_[_FORV_31_].currentPosition - 9.023499) / 0.35) - math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 * ((_UPVALUE39_[_FORV_31_].currentPosition - 9.023499) / 0.35) - _UPVALUE39_[_FORV_31_].animationProgress)
            setObjectScale(_UPVALUE39_[_FORV_31_].objectElement, 0.5 + (1 - _UPVALUE39_[_FORV_31_].animationProgress) * 0.5)
          end
        end
        if _UPVALUE39_[_FORV_31_].currentPosition >= _UPVALUE39_[_FORV_31_].desiredPosition then
          _UPVALUE39_[_FORV_31_].currentPosition = _UPVALUE39_[_FORV_31_].desiredPosition
          _UPVALUE39_[_FORV_31_].animationProgress = _UPVALUE39_[_FORV_31_].animationProgress + _ARG_0_ / 500
          if _UPVALUE39_[_FORV_31_].animationProgress >= (_UPVALUE39_[_FORV_31_].currentPosition >= 9.023499 and 0.35 or 1) then
            if oreTypes[_UPVALUE39_[_FORV_31_].oreType] then
              oreTypes[_UPVALUE39_[_FORV_31_].oreType].bufferContent = oreTypes[_UPVALUE39_[_FORV_31_].oreType].bufferContent + _UPVALUE39_[_FORV_31_].oreAmount
              checkOreBuffer(_UPVALUE39_[_FORV_31_].oreType)
            else
              if isElement((playSound3D("files/sounds/orefall" .. math.random(1, 4) .. ".wav", machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 2.1249 + (machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 11.1369 - (machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 2.1249)) / math.sqrt((machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 11.1369 - (machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 2.1249)) ^ 2 + (machinePosY - 0.2139 - (machinePosY - 0.2139)) ^ 2 + (machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 - 0.2445 - (machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 + 0.2109)) ^ 2) * (-0.3372985 + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 * ((_UPVALUE39_[_FORV_31_].currentPosition - 9.023499) / 0.35) + 0.85 * _UPVALUE39_[_FORV_31_].animationProgress), machinePosY - 0.2139 + (machinePosY - 0.2139 - (machinePosY - 0.2139)) / math.sqrt((machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 11.1369 - (machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 2.1249)) ^ 2 + (machinePosY - 0.2139 - (machinePosY - 0.2139)) ^ 2 + (machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 - 0.2445 - (machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 + 0.2109)) ^ 2) * (-0.3372985 + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 * ((_UPVALUE39_[_FORV_31_].currentPosition - 9.023499) / 0.35) + 0.85 * _UPVALUE39_[_FORV_31_].animationProgress), machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 + 0.2109 + (machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 - 0.2445 - (machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 + 0.2109)) / math.sqrt((machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 11.1369 - (machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 2.1249)) ^ 2 + (machinePosY - 0.2139 - (machinePosY - 0.2139)) ^ 2 + (machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 - 0.2445 - (machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 + 0.2109)) ^ 2) * (-0.3372985 + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 * ((_UPVALUE39_[_FORV_31_].currentPosition - 9.023499) / 0.35) + 0.85 * _UPVALUE39_[_FORV_31_].animationProgress) + (0.15 + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.04) - 1))) then
                setElementInterior(playSound3D("files/sounds/orefall" .. math.random(1, 4) .. ".wav", machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 2.1249 + (machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 11.1369 - (machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 2.1249)) / math.sqrt((machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 11.1369 - (machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 2.1249)) ^ 2 + (machinePosY - 0.2139 - (machinePosY - 0.2139)) ^ 2 + (machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 - 0.2445 - (machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 + 0.2109)) ^ 2) * (-0.3372985 + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 * ((_UPVALUE39_[_FORV_31_].currentPosition - 9.023499) / 0.35) + 0.85 * _UPVALUE39_[_FORV_31_].animationProgress), machinePosY - 0.2139 + (machinePosY - 0.2139 - (machinePosY - 0.2139)) / math.sqrt((machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 11.1369 - (machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 2.1249)) ^ 2 + (machinePosY - 0.2139 - (machinePosY - 0.2139)) ^ 2 + (machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 - 0.2445 - (machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 + 0.2109)) ^ 2) * (-0.3372985 + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 * ((_UPVALUE39_[_FORV_31_].currentPosition - 9.023499) / 0.35) + 0.85 * _UPVALUE39_[_FORV_31_].animationProgress), machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 + 0.2109 + (machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 - 0.2445 - (machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 + 0.2109)) / math.sqrt((machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 11.1369 - (machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 2.1249)) ^ 2 + (machinePosY - 0.2139 - (machinePosY - 0.2139)) ^ 2 + (machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 - 0.2445 - (machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 + 0.2109)) ^ 2) * (-0.3372985 + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 * ((_UPVALUE39_[_FORV_31_].currentPosition - 9.023499) / 0.35) + 0.85 * _UPVALUE39_[_FORV_31_].animationProgress) + (0.15 + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.04) - 1), 0)
                setElementDimension(playSound3D("files/sounds/orefall" .. math.random(1, 4) .. ".wav", machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 2.1249 + (machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 11.1369 - (machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 2.1249)) / math.sqrt((machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 11.1369 - (machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 2.1249)) ^ 2 + (machinePosY - 0.2139 - (machinePosY - 0.2139)) ^ 2 + (machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 - 0.2445 - (machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 + 0.2109)) ^ 2) * (-0.3372985 + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 * ((_UPVALUE39_[_FORV_31_].currentPosition - 9.023499) / 0.35) + 0.85 * _UPVALUE39_[_FORV_31_].animationProgress), machinePosY - 0.2139 + (machinePosY - 0.2139 - (machinePosY - 0.2139)) / math.sqrt((machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 11.1369 - (machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 2.1249)) ^ 2 + (machinePosY - 0.2139 - (machinePosY - 0.2139)) ^ 2 + (machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 - 0.2445 - (machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 + 0.2109)) ^ 2) * (-0.3372985 + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 * ((_UPVALUE39_[_FORV_31_].currentPosition - 9.023499) / 0.35) + 0.85 * _UPVALUE39_[_FORV_31_].animationProgress), machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 + 0.2109 + (machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 - 0.2445 - (machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 + 0.2109)) / math.sqrt((machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 11.1369 - (machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 2.1249)) ^ 2 + (machinePosY - 0.2139 - (machinePosY - 0.2139)) ^ 2 + (machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 - 0.2445 - (machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 + 0.2109)) ^ 2) * (-0.3372985 + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 * ((_UPVALUE39_[_FORV_31_].currentPosition - 9.023499) / 0.35) + 0.85 * _UPVALUE39_[_FORV_31_].animationProgress) + (0.15 + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.04) - 1), currentMine)
              end
              spawnSmokeEx(machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 2.1249 + (machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 11.1369 - (machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 2.1249)) / math.sqrt((machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 11.1369 - (machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 2.1249)) ^ 2 + (machinePosY - 0.2139 - (machinePosY - 0.2139)) ^ 2 + (machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 - 0.2445 - (machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 + 0.2109)) ^ 2) * (-0.3372985 + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 * ((_UPVALUE39_[_FORV_31_].currentPosition - 9.023499) / 0.35) + 0.85 * _UPVALUE39_[_FORV_31_].animationProgress), machinePosY - 0.2139 + (machinePosY - 0.2139 - (machinePosY - 0.2139)) / math.sqrt((machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 11.1369 - (machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 2.1249)) ^ 2 + (machinePosY - 0.2139 - (machinePosY - 0.2139)) ^ 2 + (machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 - 0.2445 - (machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 + 0.2109)) ^ 2) * (-0.3372985 + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 * ((_UPVALUE39_[_FORV_31_].currentPosition - 9.023499) / 0.35) + 0.85 * _UPVALUE39_[_FORV_31_].animationProgress), machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 + 0.2109 + (machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 - 0.2445 - (machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 + 0.2109)) / math.sqrt((machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 11.1369 - (machinePosX + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - 2.1249)) ^ 2 + (machinePosY - 0.2139 - (machinePosY - 0.2139)) ^ 2 + (machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 - 0.2445 - (machinePosZ + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.03 + 0.2109)) ^ 2) * (-0.3372985 + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 * ((_UPVALUE39_[_FORV_31_].currentPosition - 9.023499) / 0.35) + 0.85 * _UPVALUE39_[_FORV_31_].animationProgress) + (0.15 + math.sin(mineMachineData.sorterProgress * TWO_PI) * 0.04) - 1)
            end
            table.remove(_UPVALUE39_, _FORV_31_)
            if isElement(_UPVALUE39_[_FORV_31_].objectElement) then
              destroyElement(_UPVALUE39_[_FORV_31_].objectElement)
            end
            _UPVALUE39_[_FORV_31_].objectElement = nil
          end
        elseif true or -0.3372985 < -0.3372985 + math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 - math.cos(mineMachineData.sorterProgress * TWO_PI) * 0.02 * ((_UPVALUE39_[_FORV_31_].currentPosition - 9.023499) / 0.35) + 0.85 * _UPVALUE39_[_FORV_31_].animationProgress then
          _UPVALUE39_[_FORV_31_].currentPosition = _UPVALUE39_[_FORV_31_].currentPosition + _ARG_0_ / 200 * 0.2
        end
      end
    end
    if mineMachineData.sortingRocks ~= true then
      mineMachineData.sortingRocks = true
      refreshMineMachineSound()
    end
  end
  if mineMachineData.forceMachine ~= true then
    mineMachineData.forceMachine = true
    if mineMachineData.forceMachine and not mineMachineData.machineRunning then
      nextSurge = mineTick
    end
  end
  if mineMachineData.machineRunning or true then
    if 1 > mineMachineData.machineRunProgress then
      mineMachineData.machineRunProgress = mineMachineData.machineRunProgress + _ARG_0_ / (true and 1000 or 10000)
      if 1 < mineMachineData.machineRunProgress then
        mineMachineData.machineRunProgress = 1
      end
    end
    if true and 2 > mineMachineData.machineRunProgress then
      mineMachineData.machineRunProgress = mineMachineData.machineRunProgress + _ARG_0_ / 1000
      if 2 < mineMachineData.machineRunProgress then
        mineMachineData.machineRunProgress = 2
      end
    elseif 1 < mineMachineData.machineRunProgress then
      mineMachineData.machineRunProgress = mineMachineData.machineRunProgress - _ARG_0_ / 1500
      if 1 > mineMachineData.machineRunProgress then
        mineMachineData.machineRunProgress = 1
      end
    end
    refreshMineMachineSound()
  elseif 0 < mineMachineData.machineRunProgress then
    mineMachineData.machineRunProgress = mineMachineData.machineRunProgress - _ARG_0_ / 5000
    if 0 > mineMachineData.machineRunProgress then
      mineMachineData.machineRunProgress = 0
    end
    refreshMineMachineSound()
  end
  for _FORV_12_ = #_UPVALUE40_, 1, -1 do
    if 0 >= unpack(_UPVALUE40_[_FORV_12_]) - _ARG_0_ then
      spawnSmokeExSm(unpack(_UPVALUE40_[_FORV_12_]))
    end
    _UPVALUE40_[_FORV_12_][3] = 300 + math.random() * 200
    if isElement(unpack(_UPVALUE40_[_FORV_12_])) then
      if 0 >= unpack(_UPVALUE40_[_FORV_12_]) - mineTick then
        destroyElement(unpack(_UPVALUE40_[_FORV_12_]))
        if isElement(unpack(_UPVALUE40_[_FORV_12_])) then
          setPedAnimation(unpack(_UPVALUE40_[_FORV_12_]))
        end
        table.remove(_UPVALUE40_, _FORV_12_)
      elseif unpack(_UPVALUE40_[_FORV_12_]) - mineTick < 500 then
        setSoundVolume(unpack(_UPVALUE40_[_FORV_12_]))
      end
    else
      table.remove(_UPVALUE40_, _FORV_12_)
    end
  end
  for _FORV_12_, _FORV_13_ in pairs(oreTypes) do
    if _FORV_13_.meltingPoint then
      if mineFoundryData.furnaceRunning == _FORV_12_ then
        _FORV_13_.furnaceTemperature = math.min(1000, _FORV_13_.furnaceTemperature + _ARG_0_ / _FORV_13_.furnaceSpeed)
        if 1 > _FORV_13_.furnaceRunProgress then
          _FORV_13_.furnaceRunProgress = _FORV_13_.furnaceRunProgress + _ARG_0_ / 2500
          if 1 < _FORV_13_.furnaceRunProgress then
            _FORV_13_.furnaceRunProgress = 1
          end
          if isElement(_FORV_13_.furnaceSound) then
            setSoundSpeed(_FORV_13_.furnaceSound, 0.75 + _FORV_13_.furnaceRunProgress * 0.25)
            setSoundVolume(_FORV_13_.furnaceSound, _FORV_13_.furnaceRunProgress)
          end
        end
      else
        _FORV_13_.furnaceTemperature = math.max(0, _FORV_13_.furnaceTemperature - _ARG_0_ / (_FORV_13_.furnaceSpeed * 10))
        if 0 < _FORV_13_.furnaceRunProgress then
          _FORV_13_.furnaceRunProgress = _FORV_13_.furnaceRunProgress - _ARG_0_ / 5000
          if 0 > _FORV_13_.furnaceRunProgress then
            _FORV_13_.furnaceRunProgress = 0
          end
          if isElement(_FORV_13_.furnaceSound) then
            setSoundSpeed(_FORV_13_.furnaceSound, 0.75 + _FORV_13_.furnaceRunProgress * 0.25)
            setSoundVolume(_FORV_13_.furnaceSound, _FORV_13_.furnaceRunProgress)
          end
        end
      end
      for _FORV_21_ = 1, 5 do
        if mineFoundryData.furnaceRunning == _FORV_12_ then
          if calculateFurnaceTemperature(_FORV_13_.furnaceTemperature, _FORV_13_.meltingPoint, mineTick) > 50 then
          else
          end
        end
        if 10 then
          dxDrawMaterialSectionLine3D(_FORV_13_.foundryDisplayPosition[1] + 0.9511 * 0.045 * 2, _FORV_13_.foundryDisplayPosition[2] + 0.309 * 0.045 * 2, _FORV_13_.foundryDisplayPosition[3] + 0.045, _FORV_13_.foundryDisplayPosition[1] + 0.9511 * 0.045 * 2, _FORV_13_.foundryDisplayPosition[2] + 0.309 * 0.045 * 2, _FORV_13_.foundryDisplayPosition[3] - 0.045, 10 * 32, 0, 32, 64, _UPVALUE32_.lcdCharset, 0.045, tocolor(220, 10, 10), _FORV_13_.foundryDisplayPosition[1] + 0.9511 * 0.045 * 2 - 0.309, _FORV_13_.foundryDisplayPosition[2] + 0.309 * 0.045 * 2 + 0.9511, _FORV_13_.foundryDisplayPosition[3])
        end
      end
    end
  end
  if mineFoundryData.meltingOre then
    mineFoundryData.meltProgress = math.min(1, mineFoundryData.meltProgress + _ARG_0_ / meltingTime)
    if isElement(mineFoundryData.meltObject) then
      if 0.9 < mineFoundryData.meltProgress * (meltingTime / 10000) then
        setElementPosition(mineFoundryData.meltObject, oreTypes[mineFoundryData.meltingOre].meltPosition[1], oreTypes[mineFoundryData.meltingOre].meltPosition[2], oreTypes[mineFoundryData.meltingOre].meltPosition[3] - 0.223179 * math.min(1, (mineFoundryData.meltProgress * (meltingTime / 10000) - 0.9) / 0.1))
      else
        setElementPosition(mineFoundryData.meltObject, oreTypes[mineFoundryData.meltingOre].meltPosition[1], oreTypes[mineFoundryData.meltingOre].meltPosition[2], oreTypes[mineFoundryData.meltingOre].meltPosition[3])
      end
      setObjectScale(mineFoundryData.meltObject, 0, 0, 1 - math.min(1, (mineFoundryData.meltProgress * (meltingTime / 10000) - 0.9) / 0.1))
    end
    if isElement(mineFoundryData.ingotObject) then
      setObjectScale(mineFoundryData.ingotObject, math.min(1, math.min(1, math.max(0, (mineFoundryData.meltProgress * (meltingTime / 10000) - 0.3) / 0.7)) * 4), math.min(1, math.min(1, math.max(0, (mineFoundryData.meltProgress * (meltingTime / 10000) - 0.3) / 0.7)) * 4), (math.min(1, math.max(0, (mineFoundryData.meltProgress * (meltingTime / 10000) - 0.3) / 0.7))))
    end
  end
  if not isLoading() then
    if not (selfPosZ < minePosZ) then
    elseif selfPosZ > minePosZ + (0 >= selfMineX and 4 or 3) then
      for _FORV_12_ = 0, 30 do
        if checkValidPlayerSpot(selfMineX - _FORV_12_, selfMineX + _FORV_12_, selfMineY - _FORV_12_, selfMineY + _FORV_12_) and checkValidPlayerSpot(selfMineX - _FORV_12_, selfMineX + _FORV_12_, selfMineY - _FORV_12_, selfMineY + _FORV_12_) then
          setElementPosition(localPlayer, minePosX + checkValidPlayerSpot(selfMineX - _FORV_12_, selfMineX + _FORV_12_, selfMineY - _FORV_12_, selfMineY + _FORV_12_) * 6, minePosY + checkValidPlayerSpot(selfMineX - _FORV_12_, selfMineX + _FORV_12_, selfMineY - _FORV_12_, selfMineY + _FORV_12_) * 6, minePosZ + 1)
          break
        end
      end
    end
  end
  if _UPVALUE41_ == "railSwitch" and not railSwitchFading[_UPVALUE42_] then
    railSwitchFading[_UPVALUE42_] = 0
  end
  for _FORV_12_ in pairs(railSwitchFading) do
    if _UPVALUE41_ == "railSwitch" and _FORV_12_ == _UPVALUE42_ then
      railSwitchFading[_FORV_12_] = railSwitchFading[_FORV_12_] + _ARG_0_ / 250
      if 1 < railSwitchFading[_FORV_12_] then
        railSwitchFading[_FORV_12_] = 1
      end
    else
      railSwitchFading[_FORV_12_] = railSwitchFading[_FORV_12_] - _ARG_0_ / 250
      if 0 > railSwitchFading[_FORV_12_] then
        railSwitchFading[_FORV_12_] = nil
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
      if _FOR_ and 0 < #railEditing.sidesList then
        for _FORV_12_ = 1, #railEditing.sidesList do
          if (junctionObjects[railEditing.sidesList[_FORV_12_].spotX] and junctionObjects[railEditing.sidesList[_FORV_12_].spotX][railEditing.sidesList[_FORV_12_].spotY]) ~= railEditing.sidesList[_FORV_12_].junctionId then
            setRailEditMode(railEditing.sidesList[_FORV_12_].spotX, railEditing.sidesList[_FORV_12_].spotY)
            break
          end
        end
      end
      if _FOR_ then
        if 0 < #railEditing.sidesList then
          for _FORV_12_ = 1, #railEditing.sidesList do
            for _FORV_17_ = 1, #railEditing.sidesList[_FORV_12_].drawList do
              dxDrawMaterialLine3D(unpack(railEditing.sidesList[_FORV_12_].drawList[_FORV_17_]) + unpack(railEditing.sidesList[_FORV_12_].drawList[_FORV_17_]), unpack(railEditing.sidesList[_FORV_12_].drawList[_FORV_17_]) - unpack(railEditing.sidesList[_FORV_12_].drawList[_FORV_17_]), minePosZ + 0.1, unpack(railEditing.sidesList[_FORV_12_].drawList[_FORV_17_]) - unpack(railEditing.sidesList[_FORV_12_].drawList[_FORV_17_]), unpack(railEditing.sidesList[_FORV_12_].drawList[_FORV_17_]) + unpack(railEditing.sidesList[_FORV_12_].drawList[_FORV_17_]), minePosZ + 0.1, _UPVALUE32_["railDraw" .. unpack(railEditing.sidesList[_FORV_12_].drawList[_FORV_17_])], 6, guiColors.primaryBlue, unpack(railEditing.sidesList[_FORV_12_].drawList[_FORV_17_]))
            end
          end
        else
          railEditing = nil
        end
      end
    end
  end
end
function calculateFurnaceTemperature(_ARG_0_, _ARG_1_, _ARG_2_)
  return getEasingValue(_ARG_0_ / 1000, "InOutQuad") * _ARG_1_ + 7.5 * math.sin(_ARG_2_ % 30000 / 30000 * math.pi * 2)
end
function computeParticleVector()
  if math.sqrt((getWorldFromScreenPosition(screenWidth / 2, screenHeight / 2, 128) - getWorldFromScreenPosition(screenWidth / 2, 0, 128)) * (getWorldFromScreenPosition(screenWidth / 2, screenHeight / 2, 128) - getWorldFromScreenPosition(screenWidth / 2, 0, 128)) + (getWorldFromScreenPosition(screenWidth / 2, screenHeight / 2, 128) - getWorldFromScreenPosition(screenWidth / 2, 0, 128)) * (getWorldFromScreenPosition(screenWidth / 2, screenHeight / 2, 128) - getWorldFromScreenPosition(screenWidth / 2, 0, 128)) + (getWorldFromScreenPosition(screenWidth / 2, screenHeight / 2, 128) - getWorldFromScreenPosition(screenWidth / 2, 0, 128)) * (getWorldFromScreenPosition(screenWidth / 2, screenHeight / 2, 128) - getWorldFromScreenPosition(screenWidth / 2, 0, 128))) * 2 ~= 0 then
  end
  return (getWorldFromScreenPosition(screenWidth / 2, screenHeight / 2, 128) - getWorldFromScreenPosition(screenWidth / 2, 0, 128)) / (math.sqrt((getWorldFromScreenPosition(screenWidth / 2, screenHeight / 2, 128) - getWorldFromScreenPosition(screenWidth / 2, 0, 128)) * (getWorldFromScreenPosition(screenWidth / 2, screenHeight / 2, 128) - getWorldFromScreenPosition(screenWidth / 2, 0, 128)) + (getWorldFromScreenPosition(screenWidth / 2, screenHeight / 2, 128) - getWorldFromScreenPosition(screenWidth / 2, 0, 128)) * (getWorldFromScreenPosition(screenWidth / 2, screenHeight / 2, 128) - getWorldFromScreenPosition(screenWidth / 2, 0, 128)) + (getWorldFromScreenPosition(screenWidth / 2, screenHeight / 2, 128) - getWorldFromScreenPosition(screenWidth / 2, 0, 128)) * (getWorldFromScreenPosition(screenWidth / 2, screenHeight / 2, 128) - getWorldFromScreenPosition(screenWidth / 2, 0, 128))) * 2), (getWorldFromScreenPosition(screenWidth / 2, screenHeight / 2, 128) - getWorldFromScreenPosition(screenWidth / 2, 0, 128)) / (math.sqrt((getWorldFromScreenPosition(screenWidth / 2, screenHeight / 2, 128) - getWorldFromScreenPosition(screenWidth / 2, 0, 128)) * (getWorldFromScreenPosition(screenWidth / 2, screenHeight / 2, 128) - getWorldFromScreenPosition(screenWidth / 2, 0, 128)) + (getWorldFromScreenPosition(screenWidth / 2, screenHeight / 2, 128) - getWorldFromScreenPosition(screenWidth / 2, 0, 128)) * (getWorldFromScreenPosition(screenWidth / 2, screenHeight / 2, 128) - getWorldFromScreenPosition(screenWidth / 2, 0, 128)) + (getWorldFromScreenPosition(screenWidth / 2, screenHeight / 2, 128) - getWorldFromScreenPosition(screenWidth / 2, 0, 128)) * (getWorldFromScreenPosition(screenWidth / 2, screenHeight / 2, 128) - getWorldFromScreenPosition(screenWidth / 2, 0, 128))) * 2), (getWorldFromScreenPosition(screenWidth / 2, screenHeight / 2, 128) - getWorldFromScreenPosition(screenWidth / 2, 0, 128)) / (math.sqrt((getWorldFromScreenPosition(screenWidth / 2, screenHeight / 2, 128) - getWorldFromScreenPosition(screenWidth / 2, 0, 128)) * (getWorldFromScreenPosition(screenWidth / 2, screenHeight / 2, 128) - getWorldFromScreenPosition(screenWidth / 2, 0, 128)) + (getWorldFromScreenPosition(screenWidth / 2, screenHeight / 2, 128) - getWorldFromScreenPosition(screenWidth / 2, 0, 128)) * (getWorldFromScreenPosition(screenWidth / 2, screenHeight / 2, 128) - getWorldFromScreenPosition(screenWidth / 2, 0, 128)) + (getWorldFromScreenPosition(screenWidth / 2, screenHeight / 2, 128) - getWorldFromScreenPosition(screenWidth / 2, 0, 128)) * (getWorldFromScreenPosition(screenWidth / 2, screenHeight / 2, 128) - getWorldFromScreenPosition(screenWidth / 2, 0, 128))) * 2)
end
function processFixOrePlayers()
  for _FORV_3_, _FORV_4_ in pairs(mineAssets) do
    if _UPVALUE1_[_FORV_3_] then
      if getElementBoneMatrix(_FORV_4_, 25) then
        getElementBoneMatrix(_FORV_4_, 25)[4][1] = (getElementBoneMatrix(_FORV_4_, 25)[4][1] + getElementBoneMatrix(_FORV_4_, 35)[4][1]) * 0.5 + getElementBoneMatrix(_FORV_4_, 25)[2][1] * 0.2
        getElementBoneMatrix(_FORV_4_, 25)[4][2] = (getElementBoneMatrix(_FORV_4_, 25)[4][2] + getElementBoneMatrix(_FORV_4_, 35)[4][2]) * 0.5 + getElementBoneMatrix(_FORV_4_, 25)[2][2] * 0.2
        getElementBoneMatrix(_FORV_4_, 25)[4][3] = (getElementBoneMatrix(_FORV_4_, 25)[4][3] + getElementBoneMatrix(_FORV_4_, 35)[4][3]) * 0.5 + getElementBoneMatrix(_FORV_4_, 25)[2][3] * 0.2
        for _FORV_12_ = 1, 3 do
          getElementBoneMatrix(_FORV_4_, 23)[2][_FORV_12_] = -getElementBoneMatrix(_FORV_4_, 23)[2][_FORV_12_]
          getElementBoneMatrix(_FORV_4_, 23)[3][_FORV_12_] = -getElementBoneMatrix(_FORV_4_, 23)[3][_FORV_12_]
        end
        if isElement(_UPVALUE1_[_FORV_3_][6]) then
          setElementMatrix(_UPVALUE1_[_FORV_3_][6], {
            getElementBoneMatrix(_FORV_4_, 23)[1],
            getElementBoneMatrix(_FORV_4_, 23)[2],
            getElementBoneMatrix(_FORV_4_, 23)[3],
            getElementBoneMatrix(_FORV_4_, 25)[4]
          })
        end
        setFixOrePosition(_FORV_3_, getElementBoneMatrix(_FORV_4_, 25)[4][1], getElementBoneMatrix(_FORV_4_, 25)[4][2])
      elseif isElement(_UPVALUE1_[_FORV_3_][6]) then
        setElementPosition(_UPVALUE1_[_FORV_3_][6], 0, 0, -100)
      end
    end
  end
end
function processFallingOres(_ARG_0_)
  for _FORV_4_ = #mineAssets, 1, -1 do
    if _UPVALUE1_[mineAssets[_FORV_4_]] then
      if (mineTick - _UPVALUE1_[mineAssets[_FORV_4_]][4]) / 1000 > 15 or not _UPVALUE1_[mineAssets[_FORV_4_]][7] then
        setFixOrePosition(mineAssets[_FORV_4_], minePosX + _UPVALUE1_[mineAssets[_FORV_4_]][1], minePosY + _UPVALUE1_[mineAssets[_FORV_4_]][2], minePosZ)
        table.remove(mineAssets, _FORV_4_)
        _UPVALUE1_[mineAssets[_FORV_4_]][7] = nil
      elseif _UPVALUE1_[mineAssets[_FORV_4_]][5] < _UPVALUE1_[mineAssets[_FORV_4_]][3] then
        _UPVALUE1_[mineAssets[_FORV_4_]][5] = 9.87 * ((mineTick - _UPVALUE1_[mineAssets[_FORV_4_]][4]) / 1000) * ((mineTick - _UPVALUE1_[mineAssets[_FORV_4_]][4]) / 1000) * 0.5
        setFixOrePosition(mineAssets[_FORV_4_], minePosX + _UPVALUE1_[mineAssets[_FORV_4_]][1], minePosY + _UPVALUE1_[mineAssets[_FORV_4_]][2], minePosZ + math.max(0, _UPVALUE1_[mineAssets[_FORV_4_]][3] - _UPVALUE1_[mineAssets[_FORV_4_]][5]))
        if _UPVALUE1_[mineAssets[_FORV_4_]][5] >= _UPVALUE1_[mineAssets[_FORV_4_]][3] then
          spawnSmokeEx(minePosX + _UPVALUE1_[mineAssets[_FORV_4_]][1], minePosY + _UPVALUE1_[mineAssets[_FORV_4_]][2], minePosZ + math.max(0, _UPVALUE1_[mineAssets[_FORV_4_]][3] - _UPVALUE1_[mineAssets[_FORV_4_]][5]))
          _UPVALUE1_[mineAssets[_FORV_4_]][5] = _UPVALUE1_[mineAssets[_FORV_4_]][3]
          _UPVALUE1_[mineAssets[_FORV_4_]][7] = nil
        end
        if processLineOfSight(minePosX + _UPVALUE1_[mineAssets[_FORV_4_]][1], minePosY + _UPVALUE1_[mineAssets[_FORV_4_]][2], minePosZ + math.max(0, _UPVALUE1_[mineAssets[_FORV_4_]][3] - _UPVALUE1_[mineAssets[_FORV_4_]][5]), minePosX + _UPVALUE1_[mineAssets[_FORV_4_]][1], minePosY + _UPVALUE1_[mineAssets[_FORV_4_]][2], minePosZ + math.max(0, _UPVALUE1_[mineAssets[_FORV_4_]][3] - _UPVALUE1_[mineAssets[_FORV_4_]][5]) - 0.3, false, false, false, true, false) then
          if not tunnelModels[processLineOfSight(minePosX + _UPVALUE1_[mineAssets[_FORV_4_]][1], minePosY + _UPVALUE1_[mineAssets[_FORV_4_]][2], minePosZ + math.max(0, _UPVALUE1_[mineAssets[_FORV_4_]][3] - _UPVALUE1_[mineAssets[_FORV_4_]][5]), minePosX + _UPVALUE1_[mineAssets[_FORV_4_]][1], minePosY + _UPVALUE1_[mineAssets[_FORV_4_]][2], minePosZ + math.max(0, _UPVALUE1_[mineAssets[_FORV_4_]][3] - _UPVALUE1_[mineAssets[_FORV_4_]][5]) - 0.3, false, false, false, true, false) and getElementModel(processLineOfSight(minePosX + _UPVALUE1_[mineAssets[_FORV_4_]][1], minePosY + _UPVALUE1_[mineAssets[_FORV_4_]][2], minePosZ + math.max(0, _UPVALUE1_[mineAssets[_FORV_4_]][3] - _UPVALUE1_[mineAssets[_FORV_4_]][5]), minePosX + _UPVALUE1_[mineAssets[_FORV_4_]][1], minePosY + _UPVALUE1_[mineAssets[_FORV_4_]][2], minePosZ + math.max(0, _UPVALUE1_[mineAssets[_FORV_4_]][3] - _UPVALUE1_[mineAssets[_FORV_4_]][5]) - 0.3, false, false, false, true, false)) or 0] then
            _UPVALUE1_[mineAssets[_FORV_4_]][1] = _UPVALUE1_[mineAssets[_FORV_4_]][1] - _UPVALUE2_[_UPVALUE1_[mineAssets[_FORV_4_]][7]][3] * (_ARG_0_ * 9.87 * math.max(1, (mineTick - _UPVALUE1_[mineAssets[_FORV_4_]][4]) / 1000))
            _UPVALUE1_[mineAssets[_FORV_4_]][2] = _UPVALUE1_[mineAssets[_FORV_4_]][2] - _UPVALUE2_[_UPVALUE1_[mineAssets[_FORV_4_]][7]][4] * (_ARG_0_ * 9.87 * math.max(1, (mineTick - _UPVALUE1_[mineAssets[_FORV_4_]][4]) / 1000))
          end
        end
      end
    end
  end
  for _FORV_4_ in pairs(_UPVALUE3_) do
    for _FORV_10_ = #_UPVALUE3_[_FORV_4_], 1, -1 do
      if (mineTick - _UPVALUE3_[_FORV_4_][_FORV_10_][4]) / 1000 > 15 then
        if _UPVALUE3_[_FORV_4_][_FORV_10_][6] then
          if isElement(_UPVALUE3_[_FORV_4_][_FORV_10_][6]) then
            destroyElement(_UPVALUE3_[_FORV_4_][_FORV_10_][6])
          end
          _UPVALUE3_[_FORV_4_][_FORV_10_][6] = nil
        end
        table.remove(_UPVALUE3_[_FORV_4_], _FORV_10_)
      elseif _UPVALUE3_[_FORV_4_][_FORV_10_][5] < _UPVALUE3_[_FORV_4_][_FORV_10_][3] then
        _UPVALUE3_[_FORV_4_][_FORV_10_][5] = 9.87 * ((mineTick - _UPVALUE3_[_FORV_4_][_FORV_10_][4]) / 1000) * ((mineTick - _UPVALUE3_[_FORV_4_][_FORV_10_][4]) / 1000) * 0.5
        if processLineOfSight(minePosX + _UPVALUE3_[_FORV_4_][_FORV_10_][1], minePosY + _UPVALUE3_[_FORV_4_][_FORV_10_][2], minePosZ + math.max(0, _UPVALUE3_[_FORV_4_][_FORV_10_][3] - _UPVALUE3_[_FORV_4_][_FORV_10_][5]), minePosX + _UPVALUE3_[_FORV_4_][_FORV_10_][1], minePosY + _UPVALUE3_[_FORV_4_][_FORV_10_][2], minePosZ + math.max(0, _UPVALUE3_[_FORV_4_][_FORV_10_][3] - _UPVALUE3_[_FORV_4_][_FORV_10_][5]) - 0.3, false, false, false, true, false) then
          if not tunnelModels[processLineOfSight(minePosX + _UPVALUE3_[_FORV_4_][_FORV_10_][1], minePosY + _UPVALUE3_[_FORV_4_][_FORV_10_][2], minePosZ + math.max(0, _UPVALUE3_[_FORV_4_][_FORV_10_][3] - _UPVALUE3_[_FORV_4_][_FORV_10_][5]), minePosX + _UPVALUE3_[_FORV_4_][_FORV_10_][1], minePosY + _UPVALUE3_[_FORV_4_][_FORV_10_][2], minePosZ + math.max(0, _UPVALUE3_[_FORV_4_][_FORV_10_][3] - _UPVALUE3_[_FORV_4_][_FORV_10_][5]) - 0.3, false, false, false, true, false) and getElementModel(processLineOfSight(minePosX + _UPVALUE3_[_FORV_4_][_FORV_10_][1], minePosY + _UPVALUE3_[_FORV_4_][_FORV_10_][2], minePosZ + math.max(0, _UPVALUE3_[_FORV_4_][_FORV_10_][3] - _UPVALUE3_[_FORV_4_][_FORV_10_][5]), minePosX + _UPVALUE3_[_FORV_4_][_FORV_10_][1], minePosY + _UPVALUE3_[_FORV_4_][_FORV_10_][2], minePosZ + math.max(0, _UPVALUE3_[_FORV_4_][_FORV_10_][3] - _UPVALUE3_[_FORV_4_][_FORV_10_][5]) - 0.3, false, false, false, true, false)) or 0] then
            _UPVALUE3_[_FORV_4_][_FORV_10_][1] = _UPVALUE3_[_FORV_4_][_FORV_10_][1] - _UPVALUE2_[_FORV_4_][3] * (_ARG_0_ * 9.87 * math.max(1, (mineTick - _UPVALUE3_[_FORV_4_][_FORV_10_][4]) / 1000))
            _UPVALUE3_[_FORV_4_][_FORV_10_][2] = _UPVALUE3_[_FORV_4_][_FORV_10_][2] - _UPVALUE2_[_FORV_4_][4] * (_ARG_0_ * 9.87 * math.max(1, (mineTick - _UPVALUE3_[_FORV_4_][_FORV_10_][4]) / 1000))
          end
        end
        if _UPVALUE3_[_FORV_4_][_FORV_10_][5] >= _UPVALUE3_[_FORV_4_][_FORV_10_][3] then
          spawnSmokeEx(minePosX + _UPVALUE3_[_FORV_4_][_FORV_10_][1], minePosY + _UPVALUE3_[_FORV_4_][_FORV_10_][2], minePosZ + math.max(0, _UPVALUE3_[_FORV_4_][_FORV_10_][3] - _UPVALUE3_[_FORV_4_][_FORV_10_][5]))
          _UPVALUE3_[_FORV_4_][_FORV_10_][5] = _UPVALUE3_[_FORV_4_][_FORV_10_][3]
        end
        setElementPosition(_UPVALUE3_[_FORV_4_][_FORV_10_][6], minePosX + _UPVALUE3_[_FORV_4_][_FORV_10_][1], minePosY + _UPVALUE3_[_FORV_4_][_FORV_10_][2], minePosZ + math.max(0, _UPVALUE3_[_FORV_4_][_FORV_10_][3] - _UPVALUE3_[_FORV_4_][_FORV_10_][5]))
      end
    end
    if #_FOR_[_FORV_4_] <= 0 then
      _UPVALUE3_[_FORV_4_] = nil
    end
  end
end
function processParticles(_ARG_0_)
  if #mineAssets > 0 or #_UPVALUE1_ > 0 then
    for _FORV_7_ = #mineAssets, 1, -1 do
      if mineAssets[_FORV_7_] then
        if mineTick - mineAssets[_FORV_7_][7] > mineAssets[_FORV_7_][8] and 0 >= 1 - (mineTick - mineAssets[_FORV_7_][7] - mineAssets[_FORV_7_][8]) / 600 then
          table.remove(mineAssets, _FORV_7_)
        end
        mineAssets[_FORV_7_][1] = mineAssets[_FORV_7_][1] + mineAssets[_FORV_7_][4] * _ARG_0_
        mineAssets[_FORV_7_][2] = mineAssets[_FORV_7_][2] + mineAssets[_FORV_7_][5] * _ARG_0_
        mineAssets[_FORV_7_][3] = mineAssets[_FORV_7_][3] + mineAssets[_FORV_7_][6] * _ARG_0_
        mineAssets[_FORV_7_][10] = mineAssets[_FORV_7_][10] + mineAssets[_FORV_7_][11] * _ARG_0_
        dxDrawMaterialLine3D(mineAssets[_FORV_7_][1] - computeParticleVector() * mineAssets[_FORV_7_][10], mineAssets[_FORV_7_][2] - computeParticleVector() * mineAssets[_FORV_7_][10], mineAssets[_FORV_7_][3] - computeParticleVector() * mineAssets[_FORV_7_][10], mineAssets[_FORV_7_][1] + computeParticleVector() * mineAssets[_FORV_7_][10], mineAssets[_FORV_7_][2] + computeParticleVector() * mineAssets[_FORV_7_][10], mineAssets[_FORV_7_][3] + computeParticleVector() * mineAssets[_FORV_7_][10], _UPVALUE2_.smokeParticle, mineAssets[_FORV_7_][10], tocolor(40, 35, 22, mineAssets[_FORV_7_][9] * 0))
      end
    end
    for _FORV_7_ = #_FOR_, 1, -1 do
      if _UPVALUE1_[_FORV_7_] then
        if mineTick - _UPVALUE1_[_FORV_7_][7] > _UPVALUE1_[_FORV_7_][8] and 0 >= 1 - (mineTick - _UPVALUE1_[_FORV_7_][7] - _UPVALUE1_[_FORV_7_][8]) / 600 then
          table.remove(_UPVALUE1_, _FORV_7_)
        end
        _UPVALUE1_[_FORV_7_][1] = _UPVALUE1_[_FORV_7_][1] + _UPVALUE1_[_FORV_7_][4] * _ARG_0_
        _UPVALUE1_[_FORV_7_][2] = _UPVALUE1_[_FORV_7_][2] + _UPVALUE1_[_FORV_7_][5] * _ARG_0_
        _UPVALUE1_[_FORV_7_][3] = _UPVALUE1_[_FORV_7_][3] + _UPVALUE1_[_FORV_7_][6] * _ARG_0_
        _UPVALUE1_[_FORV_7_][10] = _UPVALUE1_[_FORV_7_][10] + _UPVALUE1_[_FORV_7_][11] * _ARG_0_
        dxDrawMaterialSectionLine3D(_UPVALUE1_[_FORV_7_][1] - computeParticleVector() * _UPVALUE1_[_FORV_7_][10], _UPVALUE1_[_FORV_7_][2] - computeParticleVector() * _UPVALUE1_[_FORV_7_][10], _UPVALUE1_[_FORV_7_][3] - computeParticleVector() * _UPVALUE1_[_FORV_7_][10], _UPVALUE1_[_FORV_7_][1] + computeParticleVector() * _UPVALUE1_[_FORV_7_][10], _UPVALUE1_[_FORV_7_][2] + computeParticleVector() * _UPVALUE1_[_FORV_7_][10], _UPVALUE1_[_FORV_7_][3] + computeParticleVector() * _UPVALUE1_[_FORV_7_][10], 16 * math.random(0, 7), 0, 16, 16, _UPVALUE2_.sparkParticle, _UPVALUE1_[_FORV_7_][10], tocolor(255, 255, 255, _UPVALUE1_[_FORV_7_][9] * 0))
      end
    end
  end
end
function processDynamiteEffect(_ARG_0_, _ARG_1_)
  if _ARG_0_[4] / detonationTime > 0.085 then
    dxDrawLine3D(_ARG_0_[5] + _ARG_0_[3] * 0.5 * (1 - math.min(1, (_ARG_0_[4] / detonationTime - 0.085) / 0.915)), _ARG_0_[6] - _ARG_0_[2] * 0.5 * (1 - math.min(1, (_ARG_0_[4] / detonationTime - 0.085) / 0.915)), _ARG_0_[7], _ARG_0_[5], _ARG_0_[6], _ARG_0_[7], tocolor(0, 0, 0), 1)
    addOrangeLight(_ARG_0_[5] + _ARG_0_[3] * 0.5 * (1 - math.min(1, (_ARG_0_[4] / detonationTime - 0.085) / 0.915)), _ARG_0_[6] - _ARG_0_[2] * 0.5 * (1 - math.min(1, (_ARG_0_[4] / detonationTime - 0.085) / 0.915)), _ARG_0_[7], 0.5 + math.random() * 1.5, 1.5 + math.random() * 2.5)
    spawnSparkParticle(_ARG_0_[5] + _ARG_0_[3] * 0.5 * (1 - math.min(1, (_ARG_0_[4] / detonationTime - 0.085) / 0.915)), _ARG_0_[6] - _ARG_0_[2] * 0.5 * (1 - math.min(1, (_ARG_0_[4] / detonationTime - 0.085) / 0.915)), _ARG_0_[7], (math.random() - 0.5) * 0.15, (math.random() - 0.5) * 0.15, 0.125 + math.random() * 0.25, 100 + math.random() * 300, 200 + math.random() * 55, 0.025 + math.random() * 0.025, 0.001 + math.random() * 0.001)
  else
    dxDrawLine3D(_ARG_0_[5] + _ARG_0_[3] * 0.5, _ARG_0_[6] - _ARG_0_[2] * 0.5, _ARG_0_[7], _ARG_0_[5], _ARG_0_[6], _ARG_0_[7], tocolor(0, 0, 0), 1)
  end
  _ARG_0_[4] = _ARG_0_[4] + _ARG_1_
end
function renderMine()
  cursorX, cursorY = getCursorPosition()
  if cursorX then
    cursorX = cursorX * screenWidth
    cursorY = cursorY * screenHeight
  end
  mineAssets = nil
  _UPVALUE1_ = nil
  _UPVALUE2_ = nil
  _UPVALUE3_ = nil
  _UPVALUE4_ = mineTick % 1000 / 500
  if _UPVALUE4_ > 1 then
    _UPVALUE4_ = 2 - _UPVALUE4_
  end
  _UPVALUE4_ = getEasingValue(_UPVALUE4_, "InQuad")
  renderTrain()
  if carryingFixOre then
    for _FORV_5_ = 1, #cartTurtleObjects do
      if isElement(cartTurtleObjects[_FORV_5_]) and not cartTurtleEmptying[_FORV_5_] and not cartTurtleRotation[_FORV_5_] then
        if (cartMaxSlots[_FORV_5_] or 0) < #oreCartOffsets and getElementPosition(cartTurtleObjects[_FORV_5_]) then
          renderActionButton("downIcon", getElementPosition(cartTurtleObjects[_FORV_5_]))
        end
      end
    end
  elseif freeFromAction then
    if isRailCarStationary() then
      for _FORV_5_ = 1, #cartTurtleObjects do
        if not cartTurtleEmptying[_FORV_5_] and not cartTurtleRotation[_FORV_5_] and cartLastSlot[_FORV_5_] and _UPVALUE6_[cartLastSlot[_FORV_5_]] then
          if getElementPosition(cartTurtleObjects[_FORV_5_]) >= conveyorStartX - 0.25 and getElementPosition(cartTurtleObjects[_FORV_5_]) <= conveyorStartX + 0.25 then
            renderActionButton("emptyIcon", getElementPosition(cartTurtleObjects[_FORV_5_]))
          else
            renderActionButton("upIcon", getElementPosition(cartTurtleObjects[_FORV_5_]))
          end
        end
      end
    end
    if canExtendShaftAt(selfMineX, selfMineY) and (not openShaftsAt[selfMineX] or not openShaftsAt[selfMineX][selfMineY]) and not isStreamedLight(selfMineX, selfMineY) then
      renderActionButton("bulbIcon", minePosX + selfMineX * 6, minePosY + selfMineY * 6, minePosZ + 2.5, 2, 2.5, false, "buildLight")
    end
    if _UPVALUE7_ and not openShaftBombs[_UPVALUE7_] and _UPVALUE8_ <= 3.775 and not currentActiveBlockId and getShaftBlockPosition(_UPVALUE7_, math.ceil(wallBlockCount / 2)) then
      renderActionButton("digIcon", getShaftBlockPosition(_UPVALUE7_, math.ceil(wallBlockCount / 2)))
    end
    for _FORV_5_, _FORV_6_ in pairs(openShaftBombs) do
      if getDistanceBetweenPoints2D(_FORV_6_[5], _FORV_6_[6], selfPosX, selfPosY) < 3 and getScreenFromWorldPosition(_FORV_6_[5], _FORV_6_[6], _FORV_6_[7], 16) and 0 < 255 * (1 - math.max(0, (getDistanceBetweenPoints2D(_FORV_6_[5], _FORV_6_[6], selfPosX, selfPosY) - 2.75) / 0.25)) then
        renderBombTimer(_FORV_6_[4], getScreenFromWorldPosition(_FORV_6_[5], _FORV_6_[6], _FORV_6_[7], 16))
      end
    end
    if threeJunctionsAt[selfMineX] and threeJunctionsAt[selfMineX][selfMineY] then
      processExtendableShaft(false, pcos(threeJunctionsAt[selfMineX] and threeJunctionsAt[selfMineX][selfMineY]), (psin(threeJunctionsAt[selfMineX] and threeJunctionsAt[selfMineX][selfMineY])))
      if threeJunctionBombs[selfMineX] and threeJunctionBombs[selfMineX][selfMineY] then
        if 3 > getDistanceBetweenPoints2D((threeJunctionBombs[selfMineX] and threeJunctionBombs[selfMineX][selfMineY])[5], (threeJunctionBombs[selfMineX] and threeJunctionBombs[selfMineX][selfMineY])[6], selfPosX, selfPosY) and getScreenFromWorldPosition((threeJunctionBombs[selfMineX] and threeJunctionBombs[selfMineX][selfMineY])[5], (threeJunctionBombs[selfMineX] and threeJunctionBombs[selfMineX][selfMineY])[6], (threeJunctionBombs[selfMineX] and threeJunctionBombs[selfMineX][selfMineY])[7], 16) and 0 < 255 * (1 - math.max(0, (getDistanceBetweenPoints2D((threeJunctionBombs[selfMineX] and threeJunctionBombs[selfMineX][selfMineY])[5], (threeJunctionBombs[selfMineX] and threeJunctionBombs[selfMineX][selfMineY])[6], selfPosX, selfPosY) - 2.75) / 0.25)) then
          renderBombTimer((threeJunctionBombs[selfMineX] and threeJunctionBombs[selfMineX][selfMineY])[4], getScreenFromWorldPosition((threeJunctionBombs[selfMineX] and threeJunctionBombs[selfMineX][selfMineY])[5], (threeJunctionBombs[selfMineX] and threeJunctionBombs[selfMineX][selfMineY])[6], (threeJunctionBombs[selfMineX] and threeJunctionBombs[selfMineX][selfMineY])[7], 16))
        end
      else
        if not _UPVALUE9_ then
          for _FORV_9_ = selfMineX - 1, 1, -1 do
            if checkValidSpot(_FORV_9_, selfMineY) then
              break
            end
          end
        end
        if true then
          renderActionButton("digIcon", minePosX + selfMineX * 6 - psin(threeJunctionsAt[selfMineX] and threeJunctionsAt[selfMineX][selfMineY]) * 1.45, minePosY + selfMineY * 6 + pcos(threeJunctionsAt[selfMineX] and threeJunctionsAt[selfMineX][selfMineY]) * 1.45, minePosZ + 1.5, 2, 2.5, false, "extendThreeJunction")
        end
      end
    elseif _UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY] then
      processExtendableShaft((_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1], _UPVALUE10_[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]][3], _UPVALUE10_[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]][4])
      if (not _UPVALUE11_[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]] or (_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[2] <= _UPVALUE12_[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]] / 6) and _UPVALUE13_[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]] then
        if shaftBombs[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]] and shaftBombs[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]][(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[2]] and shaftBombs[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]][(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[2]][1] then
          if 3 > getDistanceBetweenPoints2D((shaftBombs[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]] and shaftBombs[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]][(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[2]] and shaftBombs[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]][(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[2]][1])[5], (shaftBombs[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]] and shaftBombs[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]][(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[2]] and shaftBombs[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]][(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[2]][1])[6], selfPosX, selfPosY) and getScreenFromWorldPosition((shaftBombs[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]] and shaftBombs[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]][(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[2]] and shaftBombs[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]][(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[2]][1])[5], (shaftBombs[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]] and shaftBombs[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]][(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[2]] and shaftBombs[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]][(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[2]][1])[6], (shaftBombs[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]] and shaftBombs[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]][(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[2]] and shaftBombs[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]][(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[2]][1])[7], 16) and 0 < 255 * (1 - math.max(0, (getDistanceBetweenPoints2D((shaftBombs[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]] and shaftBombs[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]][(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[2]] and shaftBombs[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]][(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[2]][1])[5], (shaftBombs[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]] and shaftBombs[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]][(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[2]] and shaftBombs[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]][(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[2]][1])[6], selfPosX, selfPosY) - 2.75) / 0.25)) then
            renderBombTimer((shaftBombs[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]] and shaftBombs[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]][(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[2]] and shaftBombs[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]][(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[2]][1])[4], getScreenFromWorldPosition((shaftBombs[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]] and shaftBombs[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]][(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[2]] and shaftBombs[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]][(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[2]][1])[5], (shaftBombs[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]] and shaftBombs[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]][(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[2]] and shaftBombs[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]][(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[2]][1])[6], (shaftBombs[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]] and shaftBombs[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]][(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[2]] and shaftBombs[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]][(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[2]][1])[7], 16))
          end
        else
          if not _UPVALUE9_ then
            for _FORV_12_ = selfMineX - 1, 1, -1 do
              if checkValidSpot(_FORV_12_, selfMineY) then
                break
              end
            end
          end
          if true then
            renderActionButton("digIcon", minePosX + selfMineX * 6 - _UPVALUE10_[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]][4] * 1.45 + _UPVALUE10_[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]][3] * 0.5, minePosY + selfMineY * 6 + _UPVALUE10_[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]][3] * 1.45 + _UPVALUE10_[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]][4] * 0.5, minePosZ + 1.5, 2, 2.5, false, "newShaft", (_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1], (_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[2], true)
          end
        end
        if shaftBombs[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]] and shaftBombs[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]][(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[2]] and shaftBombs[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]][(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[2]][0] then
          if 3 > getDistanceBetweenPoints2D((shaftBombs[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]] and shaftBombs[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]][(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[2]] and shaftBombs[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]][(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[2]][0])[5], (shaftBombs[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]] and shaftBombs[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]][(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[2]] and shaftBombs[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]][(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[2]][0])[6], selfPosX, selfPosY) and getScreenFromWorldPosition((shaftBombs[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]] and shaftBombs[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]][(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[2]] and shaftBombs[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]][(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[2]][0])[5], (shaftBombs[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]] and shaftBombs[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]][(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[2]] and shaftBombs[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]][(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[2]][0])[6], (shaftBombs[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]] and shaftBombs[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]][(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[2]] and shaftBombs[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]][(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[2]][0])[7], 16) and 0 < 255 * (1 - math.max(0, (getDistanceBetweenPoints2D((shaftBombs[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]] and shaftBombs[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]][(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[2]] and shaftBombs[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]][(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[2]][0])[5], (shaftBombs[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]] and shaftBombs[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]][(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[2]] and shaftBombs[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]][(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[2]][0])[6], selfPosX, selfPosY) - 2.75) / 0.25)) then
            renderBombTimer((shaftBombs[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]] and shaftBombs[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]][(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[2]] and shaftBombs[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]][(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[2]][0])[4], getScreenFromWorldPosition((shaftBombs[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]] and shaftBombs[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]][(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[2]] and shaftBombs[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]][(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[2]][0])[5], (shaftBombs[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]] and shaftBombs[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]][(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[2]] and shaftBombs[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]][(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[2]][0])[6], (shaftBombs[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]] and shaftBombs[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]][(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[2]] and shaftBombs[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]][(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[2]][0])[7], 16))
          end
        else
          if not _UPVALUE14_ then
            for _FORV_12_ = selfMineX - 1, 1, -1 do
              if checkValidSpot(_FORV_12_, selfMineY) then
                break
              end
            end
          end
          if true then
            renderActionButton("digIcon", minePosX + selfMineX * 6 + _UPVALUE10_[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]][4] * 1.45 - _UPVALUE10_[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]][3] * 0.5, minePosY + selfMineY * 6 - _UPVALUE10_[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]][3] * 1.45 - _UPVALUE10_[(_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1]][4] * 0.5, minePosZ + 1.5, 2, 2.5, false, "newShaft", (_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[1], (_UPVALUE5_[selfMineX] and _UPVALUE5_[selfMineX][selfMineY])[2], false)
          end
        end
      end
    else
      processExtendableShaft()
    end
    iterateGrid(_UPVALUE15_, selfMineX - 1, selfMineY - 1, selfMineX + 1, selfMineY + 1, function(_ARG_0_, _ARG_1_, _ARG_2_)
      for _FORV_6_ = 1, #_ARG_0_ do
        if not mineAssets[_ARG_0_[_FORV_6_]][7] and not fixOreCarts[_ARG_0_[_FORV_6_]] and not _UPVALUE1_[_ARG_0_[_FORV_6_]] then
          renderActionButton("carryIcon", minePosX + mineAssets[_ARG_0_[_FORV_6_]][1], minePosY + mineAssets[_ARG_0_[_FORV_6_]][2], minePosZ + 0.3, 1, 1.25, true, "pickUpFixOre", _ARG_0_[_FORV_6_], mineAssets[_ARG_0_[_FORV_6_]][10], false)
        end
      end
    end)
  end
  if selfMineX <= 0 then
    renderMineHQ()
  end
  for _FORV_9_ = selfMineX - 2, selfMineX + 2 do
    if railSwitchesAt[_FORV_9_] then
      for _FORV_13_ = selfMineY - 2, selfMineY + 2 do
        renderRailSwitch(railSwitchesAt[_FORV_9_][_FORV_13_])
      end
    end
  end
  if railEndsAt[selfMineX] and railEndsAt[selfMineX][selfMineY] then
    renderRailEditButton()
  elseif railSwitchesAt[selfMineX] and railSwitchesAt[selfMineX][selfMineY] and 3 >= #railSwitches[railSwitchesAt[selfMineX] and railSwitchesAt[selfMineX][selfMineY]].trackIds then
    renderRailEditButton()
  elseif railsAt[selfMineX] and railsAt[selfMineX][selfMineY] and junctionObjects[selfMineX] and junctionObjects[selfMineX][selfMineY] then
    for _FORV_9_ = 0, 270, 90 do
      if checkValidSpotEx(selfMineX + pcos((prad(_FORV_9_))), selfMineY + psin((prad(_FORV_9_)))) then
        renderRailEditButton()
      end
    end
  end
  if _FOR_ then
    for _FORV_9_ = 1, #railEditing.sidesList do
      renderActionButton("constructionIcon", minePosX + railEditing.sidesList[_FORV_9_].spotX * 6, minePosY + railEditing.sidesList[_FORV_9_].spotY * 6, minePosZ + 0.25, 6.5, 7, false, "doConstructRail", railEditing.sidesList[_FORV_9_].spotX, railEditing.sidesList[_FORV_9_].spotY, railEditing.sidesList[_FORV_9_].totalCost)
    end
  end
  if _FOR_ then
    mineAssets = nil
    _UPVALUE1_ = nil
    _UPVALUE2_ = nil
    _UPVALUE3_ = nil
  end
  tabletHovering = false
  if _UPVALUE17_ ~= mineAssets or _UPVALUE18_ ~= _UPVALUE1_ or _UPVALUE19_ ~= _UPVALUE2_ or _UPVALUE20_ ~= _UPVALUE3_ then
    _UPVALUE17_ = mineAssets
    _UPVALUE18_ = _UPVALUE1_
    _UPVALUE19_ = _UPVALUE2_
    _UPVALUE20_ = _UPVALUE3_
    if _UPVALUE17_ then
      exports.see_gui:setCursorType("link")
      if _UPVALUE17_ == "newShaft" or _UPVALUE17_ == "extendThreeJunction" then
        exports.see_gui:showTooltip("Új járat nyitása")
      elseif _UPVALUE17_ == "openShaftBomb" then
        exports.see_gui:showTooltip("Robbanótöltet felhelyezése")
      elseif _UPVALUE17_ == "openRailEditMode" then
        exports.see_gui:showTooltip("Sínépítés")
      elseif _UPVALUE17_ == "closeRailEditMode" then
        exports.see_gui:showTooltip("Sínépítés befejezése")
      elseif _UPVALUE17_ == "doConstructRail" then
        exports.see_gui:showTooltip("Sín megépítése\n[color=yellow]" .. _UPVALUE20_ * railIronCost .. "db sínszál\n[color=yellow]" .. _UPVALUE20_ * railWoodCost .. "db talpfa")
      elseif _UPVALUE17_ == "driveDieselLoco" then
        exports.see_gui:showTooltip("Mozdony vezetése")
      elseif _UPVALUE17_ == "dieselLocoPassenger" then
        exports.see_gui:showTooltip("Felszállás a mozdonyra")
      elseif _UPVALUE17_ == "pickUpFixOre" then
        if oreTypes[_UPVALUE19_] then
          exports.see_gui:showTooltip(oreTypes[_UPVALUE19_].displayName .. (_UPVALUE20_ and " kivétele a kocsiból" or " felvétele"))
        end
      elseif _UPVALUE17_ == "putOreInCart" then
        if oreTypes[_UPVALUE6_[carryingFixOre][10]] then
          exports.see_gui:showTooltip(oreTypes[_UPVALUE6_[carryingFixOre][10]].displayName .. " betétele a kocsiba")
        end
      elseif _UPVALUE17_ == "toggleSortingMachine" then
        exports.see_gui:showTooltip("Válogatógép " .. (mineMachineData.machineRunning and "ki" or "be") .. "kapcsolása")
      elseif _UPVALUE17_ == "emptyCart" then
        exports.see_gui:showTooltip("Kocsi kiürítése")
      elseif _UPVALUE17_ == "sackOre" then
        exports.see_gui:showTooltip(oreTypes[_UPVALUE18_].displayName .. " zsákolása")
      elseif _UPVALUE17_ == "pickUpOreBox" then
        exports.see_gui:showTooltip("Láda felvétele (" .. oreTypes[_UPVALUE18_].displayName .. ")")
      elseif _UPVALUE17_ == "putDownOreBox" then
        exports.see_gui:showTooltip("Láda letétele")
      elseif _UPVALUE17_ == "toggleFoundry" then
        if mineFoundryData.furnaceRunning == _UPVALUE18_ then
          exports.see_gui:showTooltip(oreTypes[_UPVALUE18_].ingotName .. "kohó kikapcsolása")
        else
          exports.see_gui:showTooltip(oreTypes[_UPVALUE18_].ingotName .. "kohó bekapcsolása")
        end
      elseif _UPVALUE17_ == "fillFoundry" then
        exports.see_gui:showTooltip(oreTypes[_UPVALUE18_].ingotName .. "kohó feltöltése")
      elseif _UPVALUE17_ == "makeIngot" then
        exports.see_gui:showTooltip(oreTypes[_UPVALUE18_].ingotName .. "rúd kiöntése")
      elseif _UPVALUE17_ == "takeIngot" then
        exports.see_gui:showTooltip(oreTypes[_UPVALUE18_].ingotName .. "rúd kivétele")
      elseif _UPVALUE17_ == "getJerryCan" then
        exports.see_gui:showTooltip("Kanna felvétele")
      elseif _UPVALUE17_ == "putJerryCan" then
        exports.see_gui:showTooltip("Kanna visszahelyezése")
      elseif _UPVALUE17_ == "fillJerryCan" then
        exports.see_gui:showTooltip("Kanna megtankolása")
      elseif _UPVALUE17_ == "fillLocoTank" then
        exports.see_gui:showTooltip("Mozdony megtankolása")
      elseif _UPVALUE17_ == "useComputer" then
        exports.see_gui:showTooltip("Számítógép használata")
      elseif _UPVALUE17_ == "buildLight" then
        exports.see_gui:showTooltip("Lámpa építése")
      elseif _UPVALUE17_ == "useFaucet" then
        exports.see_gui:showTooltip("Mosakodás")
      else
        exports.see_gui:showTooltip()
      end
    else
      exports.see_gui:setCursorType("normal")
      exports.see_gui:showTooltip()
    end
  end
end
function drawFoundryInfo(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  dxDrawText(_ARG_2_.ingotName .. "kohó (" .. _ARG_2_.meltingPoint .. " \194\176C)\n" .. math.floor(_ARG_2_.displayedFoundryContent) .. " rúdra elegendő nyersanyag", _ARG_0_ + 1, _ARG_1_ + 1, _ARG_0_ + 1, _ARG_1_ + 1, tocolor(0, 0, 0, _ARG_3_ * 0.8), guiFontScales.oreFont, guiFonts.oreFont, "center", "center")
  dxDrawText(_ARG_2_.ingotName .. "kohó (" .. _ARG_2_.meltingPoint .. " \194\176C)\n" .. math.floor(_ARG_2_.displayedFoundryContent) .. " rúdra elegendő nyersanyag", _ARG_0_, _ARG_1_, _ARG_0_, _ARG_1_, tocolor(255, 255, 255, _ARG_3_), guiFontScales.oreFont, guiFonts.oreFont, "center", "center")
  dxDrawRectangle(_ARG_0_ - 150 / 2, _ARG_1_ + guiFontHeights.oreFont + 4, 150, 8, tocolor(guiColorCodes.primaryGrey[1], guiColorCodes.primaryGrey[2], guiColorCodes.primaryGrey[3], _ARG_3_))
  dxDrawRectangle(_ARG_0_ - 150 / 2 + 1, _ARG_1_ + guiFontHeights.oreFont + 4 + 1, 150 - 2, 8 - 2, tocolor(guiColorCodes.primaryGreen[1], guiColorCodes.primaryGreen[2], guiColorCodes.primaryGreen[3], _ARG_3_ / 2))
  dxDrawRectangle(_ARG_0_ - 150 / 2 + 1, _ARG_1_ + guiFontHeights.oreFont + 4 + 1, (150 - 2) * (_ARG_2_.displayedFoundryContent % 1), 8 - 2, tocolor(guiColorCodes.primaryGreen[1], guiColorCodes.primaryGreen[2], guiColorCodes.primaryGreen[3], _ARG_3_))
end
function renderMineHQ()
  if mineAssets[localPlayer] then
    if oreTypes[mineAssets[localPlayer]] then
      renderActionButton("downIcon", oreTypes[mineAssets[localPlayer]].boxPosition[1], oreTypes[mineAssets[localPlayer]].boxPosition[2], oreTypes[mineAssets[localPlayer]].boxPosition[3], 1.5, 2, true, "putDownOreBox")
      if mineFoundryData.meltingOre ~= mineAssets[localPlayer] and renderActionButton("intoIcon", oreTypes[mineAssets[localPlayer]].foundryInputPosition[1], oreTypes[mineAssets[localPlayer]].foundryInputPosition[2], oreTypes[mineAssets[localPlayer]].foundryInputPosition[3], 1, 1.5, true, "fillFoundry", mineAssets[localPlayer]) then
        drawFoundryInfo(renderActionButton("intoIcon", oreTypes[mineAssets[localPlayer]].foundryInputPosition[1], oreTypes[mineAssets[localPlayer]].foundryInputPosition[2], oreTypes[mineAssets[localPlayer]].foundryInputPosition[3], 1, 1.5, true, "fillFoundry", mineAssets[localPlayer]))
      end
    end
  elseif freeFromAction then
    renderActionButton("toggleIcon", minePosX - 14.7006, minePosY + 6.7456, minePosZ + 1.466699999999, 0.75, 1, true, "toggleSortingMachine")
    for _FORV_4_, _FORV_5_ in pairs(oreTypes) do
      if not _FORV_5_.instantItem then
        if not _FORV_5_.carriedBy and 2 > getDistanceBetweenPoints2D(_FORV_5_.boxPosition[1], _FORV_5_.boxPosition[2], selfPosX, selfPosY) and getScreenFromWorldPosition(_FORV_5_.boxPosition[1], _FORV_5_.boxPosition[2], _FORV_5_.boxPosition[3] + 0.25, 16) and 0 < (1 - math.max(0, (getDistanceBetweenPoints2D(_FORV_5_.boxPosition[1], _FORV_5_.boxPosition[2], selfPosX, selfPosY) - 1.5) / 0.5)) * 255 then
          if _FORV_5_.displayedBoxContent == _FORV_5_.boxContent and not mineMachineData.machineRunning and not mineMachineData.forceMachine then
            if _UPVALUE1_ then
              if not _FORV_5_.meltingPoint and _FORV_5_.displayedBoxContent >= sackOreProportion then
                dxDrawRectangle(getScreenFromWorldPosition(_FORV_5_.boxPosition[1], _FORV_5_.boxPosition[2], _FORV_5_.boxPosition[3] + 0.25, 16) - 16, getScreenFromWorldPosition(_FORV_5_.boxPosition[1], _FORV_5_.boxPosition[2], _FORV_5_.boxPosition[3] + 0.25, 16) + 4, 32, 32, tocolor(guiColorCodes.primaryGrey[1], guiColorCodes.primaryGrey[2], guiColorCodes.primaryGrey[3], (1 - math.max(0, (getDistanceBetweenPoints2D(_FORV_5_.boxPosition[1], _FORV_5_.boxPosition[2], selfPosX, selfPosY) - 1.5) / 0.5)) * 255))
                if 255 <= (1 - math.max(0, (getDistanceBetweenPoints2D(_FORV_5_.boxPosition[1], _FORV_5_.boxPosition[2], selfPosX, selfPosY) - 1.5) / 0.5)) * 255 and cursorX and cursorX >= getScreenFromWorldPosition(_FORV_5_.boxPosition[1], _FORV_5_.boxPosition[2], _FORV_5_.boxPosition[3] + 0.25, 16) - 16 and cursorY >= getScreenFromWorldPosition(_FORV_5_.boxPosition[1], _FORV_5_.boxPosition[2], _FORV_5_.boxPosition[3] + 0.25, 16) + 4 and cursorX <= getScreenFromWorldPosition(_FORV_5_.boxPosition[1], _FORV_5_.boxPosition[2], _FORV_5_.boxPosition[3] + 0.25, 16) + 16 and cursorY <= getScreenFromWorldPosition(_FORV_5_.boxPosition[1], _FORV_5_.boxPosition[2], _FORV_5_.boxPosition[3] + 0.25, 16) + 4 + 32 then
                  _UPVALUE2_ = "sackOre"
                  _UPVALUE3_ = _FORV_4_
                  dxDrawImage(getScreenFromWorldPosition(_FORV_5_.boxPosition[1], _FORV_5_.boxPosition[2], _FORV_5_.boxPosition[3] + 0.25, 16) - 12, getScreenFromWorldPosition(_FORV_5_.boxPosition[1], _FORV_5_.boxPosition[2], _FORV_5_.boxPosition[3] + 0.25, 16) + 8, 24, 24, ":see_gui/" .. guiIcons.sackIcon .. guiIconTicks.sackIcon .. ".fa", 0, 0, 0, guiColors.primaryGreen)
                else
                  dxDrawImage(getScreenFromWorldPosition(_FORV_5_.boxPosition[1], _FORV_5_.boxPosition[2], _FORV_5_.boxPosition[3] + 0.25, 16) - 12, getScreenFromWorldPosition(_FORV_5_.boxPosition[1], _FORV_5_.boxPosition[2], _FORV_5_.boxPosition[3] + 0.25, 16) + 8, 24, 24, ":see_gui/" .. guiIcons.sackIcon .. guiIconTicks.sackIcon .. ".fa", 0, 0, 0, tocolor(255, 255, 255, (1 - math.max(0, (getDistanceBetweenPoints2D(_FORV_5_.boxPosition[1], _FORV_5_.boxPosition[2], selfPosX, selfPosY) - 1.5) / 0.5)) * 255))
                end
                if 255 <= (1 - math.max(0, (getDistanceBetweenPoints2D(_FORV_5_.boxPosition[1], _FORV_5_.boxPosition[2], selfPosX, selfPosY) - 1.5) / 0.5)) * 255 then
                  setActionKeyBind(getDistanceBetweenPoints2D(_FORV_5_.boxPosition[1], _FORV_5_.boxPosition[2], selfPosX, selfPosY), "sackOre", _FORV_4_)
                end
              end
            elseif _FORV_5_.meltingPoint then
              dxDrawRectangle(getScreenFromWorldPosition(_FORV_5_.boxPosition[1], _FORV_5_.boxPosition[2], _FORV_5_.boxPosition[3] + 0.25, 16) - 16, getScreenFromWorldPosition(_FORV_5_.boxPosition[1], _FORV_5_.boxPosition[2], _FORV_5_.boxPosition[3] + 0.25, 16) - 4 + 4, 32, 32, tocolor(guiColorCodes.primaryGrey[1], guiColorCodes.primaryGrey[2], guiColorCodes.primaryGrey[3], (1 - math.max(0, (getDistanceBetweenPoints2D(_FORV_5_.boxPosition[1], _FORV_5_.boxPosition[2], selfPosX, selfPosY) - 1.5) / 0.5)) * 255))
              if 255 <= (1 - math.max(0, (getDistanceBetweenPoints2D(_FORV_5_.boxPosition[1], _FORV_5_.boxPosition[2], selfPosX, selfPosY) - 1.5) / 0.5)) * 255 and cursorX and cursorX >= getScreenFromWorldPosition(_FORV_5_.boxPosition[1], _FORV_5_.boxPosition[2], _FORV_5_.boxPosition[3] + 0.25, 16) - 16 and cursorY >= getScreenFromWorldPosition(_FORV_5_.boxPosition[1], _FORV_5_.boxPosition[2], _FORV_5_.boxPosition[3] + 0.25, 16) - 4 + 4 and cursorX <= getScreenFromWorldPosition(_FORV_5_.boxPosition[1], _FORV_5_.boxPosition[2], _FORV_5_.boxPosition[3] + 0.25, 16) + 16 and cursorY <= getScreenFromWorldPosition(_FORV_5_.boxPosition[1], _FORV_5_.boxPosition[2], _FORV_5_.boxPosition[3] + 0.25, 16) - 4 + 4 + 32 then
                _UPVALUE2_ = "pickUpOreBox"
                _UPVALUE3_ = _FORV_4_
                dxDrawImage(getScreenFromWorldPosition(_FORV_5_.boxPosition[1], _FORV_5_.boxPosition[2], _FORV_5_.boxPosition[3] + 0.25, 16) - 12, getScreenFromWorldPosition(_FORV_5_.boxPosition[1], _FORV_5_.boxPosition[2], _FORV_5_.boxPosition[3] + 0.25, 16) - 4 + 8, 24, 24, ":see_gui/" .. guiIcons.upIcon .. guiIconTicks.upIcon .. ".fa", 0, 0, 0, guiColors.primaryGreen)
              else
                dxDrawImage(getScreenFromWorldPosition(_FORV_5_.boxPosition[1], _FORV_5_.boxPosition[2], _FORV_5_.boxPosition[3] + 0.25, 16) - 12, getScreenFromWorldPosition(_FORV_5_.boxPosition[1], _FORV_5_.boxPosition[2], _FORV_5_.boxPosition[3] + 0.25, 16) - 4 + 8, 24, 24, ":see_gui/" .. guiIcons.upIcon .. guiIconTicks.upIcon .. ".fa", 0, 0, 0, tocolor(255, 255, 255, (1 - math.max(0, (getDistanceBetweenPoints2D(_FORV_5_.boxPosition[1], _FORV_5_.boxPosition[2], selfPosX, selfPosY) - 1.5) / 0.5)) * 255))
              end
              if 255 <= (1 - math.max(0, (getDistanceBetweenPoints2D(_FORV_5_.boxPosition[1], _FORV_5_.boxPosition[2], selfPosX, selfPosY) - 1.5) / 0.5)) * 255 then
                setActionKeyBind(getDistanceBetweenPoints2D(_FORV_5_.boxPosition[1], _FORV_5_.boxPosition[2], selfPosX, selfPosY), "pickUpOreBox", _FORV_4_)
              end
            end
          end
          dxDrawText(_FORV_5_.displayName, getScreenFromWorldPosition(_FORV_5_.boxPosition[1], _FORV_5_.boxPosition[2], _FORV_5_.boxPosition[3] + 0.25, 16) + 1, 0, getScreenFromWorldPosition(_FORV_5_.boxPosition[1], _FORV_5_.boxPosition[2], _FORV_5_.boxPosition[3] + 0.25, 16) + 1, getScreenFromWorldPosition(_FORV_5_.boxPosition[1], _FORV_5_.boxPosition[2], _FORV_5_.boxPosition[3] + 0.25, 16) - 4 - 4 - 8 + 1, tocolor(0, 0, 0, (1 - math.max(0, (getDistanceBetweenPoints2D(_FORV_5_.boxPosition[1], _FORV_5_.boxPosition[2], selfPosX, selfPosY) - 1.5) / 0.5)) * 255 * 0.8), guiFontScales.oreFont, guiFonts.oreFont, "center", "bottom")
          dxDrawText(_FORV_5_.displayName, getScreenFromWorldPosition(_FORV_5_.boxPosition[1], _FORV_5_.boxPosition[2], _FORV_5_.boxPosition[3] + 0.25, 16) + 0, 0, getScreenFromWorldPosition(_FORV_5_.boxPosition[1], _FORV_5_.boxPosition[2], _FORV_5_.boxPosition[3] + 0.25, 16) + 0, getScreenFromWorldPosition(_FORV_5_.boxPosition[1], _FORV_5_.boxPosition[2], _FORV_5_.boxPosition[3] + 0.25, 16) - 4 - 4 - 8 + 0, tocolor(255, 255, 255, (1 - math.max(0, (getDistanceBetweenPoints2D(_FORV_5_.boxPosition[1], _FORV_5_.boxPosition[2], selfPosX, selfPosY) - 1.5) / 0.5)) * 255), guiFontScales.oreFont, guiFonts.oreFont, "center", "bottom")
          dxDrawRectangle(getScreenFromWorldPosition(_FORV_5_.boxPosition[1], _FORV_5_.boxPosition[2], _FORV_5_.boxPosition[3] + 0.25, 16) - 100 / 2, getScreenFromWorldPosition(_FORV_5_.boxPosition[1], _FORV_5_.boxPosition[2], _FORV_5_.boxPosition[3] + 0.25, 16) - 4 - 4 - 8 / 2, 100, 8, tocolor(guiColorCodes.primaryGrey[1], guiColorCodes.primaryGrey[2], guiColorCodes.primaryGrey[3], (1 - math.max(0, (getDistanceBetweenPoints2D(_FORV_5_.boxPosition[1], _FORV_5_.boxPosition[2], selfPosX, selfPosY) - 1.5) / 0.5)) * 255))
          dxDrawRectangle(getScreenFromWorldPosition(_FORV_5_.boxPosition[1], _FORV_5_.boxPosition[2], _FORV_5_.boxPosition[3] + 0.25, 16) - 100 / 2 + 1, getScreenFromWorldPosition(_FORV_5_.boxPosition[1], _FORV_5_.boxPosition[2], _FORV_5_.boxPosition[3] + 0.25, 16) - 4 - 4 - 8 / 2 + 1, 100 - 2, 8 - 2, tocolor(guiColorCodes.primaryGreen[1], guiColorCodes.primaryGreen[2], guiColorCodes.primaryGreen[3], (1 - math.max(0, (getDistanceBetweenPoints2D(_FORV_5_.boxPosition[1], _FORV_5_.boxPosition[2], selfPosX, selfPosY) - 1.5) / 0.5)) * 255 / 2))
          dxDrawRectangle(getScreenFromWorldPosition(_FORV_5_.boxPosition[1], _FORV_5_.boxPosition[2], _FORV_5_.boxPosition[3] + 0.25, 16) - 100 / 2 + 1, getScreenFromWorldPosition(_FORV_5_.boxPosition[1], _FORV_5_.boxPosition[2], _FORV_5_.boxPosition[3] + 0.25, 16) - 4 - 4 - 8 / 2 + 1, (100 - 2) * _FORV_5_.displayedBoxContent, 8 - 2, tocolor(guiColorCodes.primaryGreen[1], guiColorCodes.primaryGreen[2], guiColorCodes.primaryGreen[3], (1 - math.max(0, (getDistanceBetweenPoints2D(_FORV_5_.boxPosition[1], _FORV_5_.boxPosition[2], selfPosX, selfPosY) - 1.5) / 0.5)) * 255))
        end
        if _FORV_5_.meltingPoint then
          if renderActionButton("toggleIcon", _FORV_5_.foundryButtonPosition[1], _FORV_5_.foundryButtonPosition[2], _FORV_5_.foundryButtonPosition[3], 2, 2.5, true, "toggleFoundry", _FORV_4_) then
            drawFoundryInfo(renderActionButton("toggleIcon", _FORV_5_.foundryButtonPosition[1], _FORV_5_.foundryButtonPosition[2], _FORV_5_.foundryButtonPosition[3], 2, 2.5, true, "toggleFoundry", _FORV_4_))
          end
          if mineFoundryData.meltingOre == _FORV_4_ then
            if 1 <= mineFoundryData.meltProgress then
              renderActionButton("upIcon", _FORV_5_.meltPosition[1], _FORV_5_.meltPosition[2], _FORV_5_.meltPosition[3], 1.25, 1.5, true, "takeIngot", _FORV_4_)
            end
          elseif not mineFoundryData.meltingOre and _FORV_5_.furnaceTemperature >= 1000 and 1 <= _FORV_5_.displayedFoundryContent then
            renderActionButton("fillDripIcon", _FORV_5_.meltPosition[1], _FORV_5_.meltPosition[2], _FORV_5_.meltPosition[3], 1.25, 1.5, true, "makeIngot", _FORV_4_)
          end
        end
      end
    end
  end
  if (freeFromAction or currentMineInventory.jerryCarry == localPlayer) and not currentMineInventory.tankOutside and 2.5 > getDistanceBetweenPoints2D(minePosX - 32.7956, minePosY + 2.3363, selfPosX, selfPosY) and getScreenFromWorldPosition(minePosX - 32.7956, minePosY + 2.3363, minePosZ + 1.15, 16) then
    dxDrawText(string.format("%s/%s L", math.floor(currentMineInventory.displayedFuelTankLevel * 10) / 10, fuelTankCapacity), getScreenFromWorldPosition(minePosX - 32.7956, minePosY + 2.3363, minePosZ + 1.15, 16) + 1, 0, getScreenFromWorldPosition(minePosX - 32.7956, minePosY + 2.3363, minePosZ + 1.15, 16) + 1, getScreenFromWorldPosition(minePosX - 32.7956, minePosY + 2.3363, minePosZ + 1.15, 16) - 4 + 1, tocolor(0, 0, 0, (1 - math.max(0, (getDistanceBetweenPoints2D(minePosX - 32.7956, minePosY + 2.3363, selfPosX, selfPosY) - 2) / 0.5)) * 255 * 0.8), guiFontScales.oreFont, guiFonts.oreFont, "center", "bottom")
    dxDrawText(string.format("%s/%s L", math.floor(currentMineInventory.displayedFuelTankLevel * 10) / 10, fuelTankCapacity), getScreenFromWorldPosition(minePosX - 32.7956, minePosY + 2.3363, minePosZ + 1.15, 16))
    if currentMineInventory.jerryCarry == localPlayer then
      dxDrawRectangle(getScreenFromWorldPosition(minePosX - 32.7956, minePosY + 2.3363, minePosZ + 1.15, 16) - 16, getScreenFromWorldPosition(minePosX - 32.7956, minePosY + 2.3363, minePosZ + 1.15, 16) - 4 + 4, 32, 32, tocolor(guiColorCodes.primaryGrey[1], guiColorCodes.primaryGrey[2], guiColorCodes.primaryGrey[3], (1 - math.max(0, (getDistanceBetweenPoints2D(minePosX - 32.7956, minePosY + 2.3363, selfPosX, selfPosY) - 2) / 0.5)) * 255))
      if 255 <= (1 - math.max(0, (getDistanceBetweenPoints2D(minePosX - 32.7956, minePosY + 2.3363, selfPosX, selfPosY) - 2) / 0.5)) * 255 and cursorX and cursorX >= getScreenFromWorldPosition(minePosX - 32.7956, minePosY + 2.3363, minePosZ + 1.15, 16) - 16 and cursorY >= getScreenFromWorldPosition(minePosX - 32.7956, minePosY + 2.3363, minePosZ + 1.15, 16) - 4 + 4 and cursorX <= getScreenFromWorldPosition(minePosX - 32.7956, minePosY + 2.3363, minePosZ + 1.15, 16) + 16 and cursorY <= getScreenFromWorldPosition(minePosX - 32.7956, minePosY + 2.3363, minePosZ + 1.15, 16) - 4 + 36 then
        dxDrawImage(getScreenFromWorldPosition(minePosX - 32.7956, minePosY + 2.3363, minePosZ + 1.15, 16) - 12, getScreenFromWorldPosition(minePosX - 32.7956, minePosY + 2.3363, minePosZ + 1.15, 16) - 4 + 8, 24, 24, ":see_gui/" .. guiIcons.fuelIcon .. guiIconTicks.fuelIcon .. ".fa", 0, 0, 0, guiColors.primaryGreen)
        _UPVALUE2_ = "fillJerryCan"
      else
        dxDrawImage(getScreenFromWorldPosition(minePosX - 32.7956, minePosY + 2.3363, minePosZ + 1.15, 16) - 12, getScreenFromWorldPosition(minePosX - 32.7956, minePosY + 2.3363, minePosZ + 1.15, 16) - 4 + 8, 24, 24, ":see_gui/" .. guiIcons.fuelIcon .. guiIconTicks.fuelIcon .. ".fa", 0, 0, 0, tocolor(255, 255, 255, (1 - math.max(0, (getDistanceBetweenPoints2D(minePosX - 32.7956, minePosY + 2.3363, selfPosX, selfPosY) - 2) / 0.5)) * 255))
      end
    end
  end
  for _FORV_4_, _FORV_5_ in pairs(oreTypes) do
    for _FORV_9_ = #_FORV_5_.itemOutput, 1, -1 do
      if _FORV_5_.ingotPosition then
      else
      end
      if not _FORV_5_.ingotPosition then
      end
      if mineTick - _FORV_5_.itemOutput[_FORV_9_] > 2000 then
        table.remove(_FORV_5_.itemOutput, _FORV_9_)
      elseif 1000 < mineTick - _FORV_5_.itemOutput[_FORV_9_] then
      else
      end
      if getDistanceBetweenPoints2D(unpack(_FORV_5_.boxPosition)) < 5 and getScreenFromWorldPosition(unpack(_FORV_5_.boxPosition)) then
        dxDrawImage(getScreenFromWorldPosition(unpack(_FORV_5_.boxPosition)) - 20, getScreenFromWorldPosition(unpack(_FORV_5_.boxPosition)) - 20, 40, 40, _FORV_5_.itemPicture, 0, 0, 0, tocolor(255, 255, 255, (1 - math.max(0, (getDistanceBetweenPoints2D(unpack(_FORV_5_.boxPosition)) - 4.5) / 0.5)) * 255 * math.min(1, (mineTick - _FORV_5_.itemOutput[_FORV_9_]) / 250)))
      end
    end
  end
  renderActionButton("computerIcon", minePosX - 32.6914, minePosY - 3.7004, minePosZ + 0.9183, 1.5, 2, false, "useComputer")
  renderActionButton("washIcon", minePosX - 27.3901, minePosY + 2.8282, minePosZ + 1.1891, 1, 1.5, false, "useFaucet")
end
function renderBombTimer(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  dxDrawRectangle(_ARG_1_ - (timerFontWidth + 8) / 2, _ARG_2_ - (guiFontHeights.timerFont + 8) / 2, (timerFontWidth + 8) / 2 * 2, (guiFontHeights.timerFont + 8) / 2 * 2, tocolor(guiColorCodes.primaryGrey[1], guiColorCodes.primaryGrey[2], guiColorCodes.primaryGrey[3], _ARG_3_))
  dxDrawText(string.format("%02d:%02d", math.floor(math.floor(math.max(0, detonationTime - _ARG_0_) / 1000) / 60), math.floor(math.max(0, detonationTime - _ARG_0_) / 1000) - math.floor(math.floor(math.max(0, detonationTime - _ARG_0_) / 1000) / 60) * 60), _ARG_1_ - (timerFontWidth + 8) / 2, _ARG_2_ - (guiFontHeights.timerFont + 8) / 2, _ARG_1_ + (timerFontWidth + 8) / 2, _ARG_2_ + (guiFontHeights.timerFont + 8) / 2, tocolor(guiColorCodes.primaryRed[1], guiColorCodes.primaryRed[2], guiColorCodes.primaryRed[3], _ARG_3_), guiFontScales.timerFont, guiFonts.timerFont, "center", "center")
end
function renderRailSwitch(_ARG_0_)
  if not railSwitches[_ARG_0_] then
    return
  end
  if #railSwitches[_ARG_0_].trackIds <= 2 then
    return
  end
  if not isElementOnScreen(railSwitches[_ARG_0_].objectElement) then
    return
  end
  if getDistanceBetweenPoints2D(selfPosX, selfPosY, railSwitches[_ARG_0_].worldX, railSwitches[_ARG_0_].worldY) >= 15 then
    return
  end
  renderRailSwitchHighlight(_ARG_0_, mineAssets * (1 - math.max(0, (getDistanceBetweenPoints2D(selfPosX, selfPosY, railSwitches[_ARG_0_].worldX, railSwitches[_ARG_0_].worldY) - 14) / 1)) * 255)
  if getDistanceBetweenPoints2D(selfPosX, selfPosY, railSwitches[_ARG_0_].worldX, railSwitches[_ARG_0_].worldY) >= 7 then
    return
  end
  if 0 >= 255 * (1 - math.max(0, (getDistanceBetweenPoints2D(selfPosX, selfPosY, railSwitches[_ARG_0_].worldX, railSwitches[_ARG_0_].worldY) - 6) / 1)) then
    return
  end
  if not getScreenFromWorldPosition(railSwitches[_ARG_0_].worldX, railSwitches[_ARG_0_].worldY, minePosZ + 1, 128) or not getScreenFromWorldPosition(railSwitches[_ARG_0_].worldX, railSwitches[_ARG_0_].worldY, minePosZ + 1, 128) then
    return
  end
  if railSwitchFading[_ARG_0_] then
    if 255 <= 255 * (1 - math.max(0, (getDistanceBetweenPoints2D(selfPosX, selfPosY, railSwitches[_ARG_0_].worldX, railSwitches[_ARG_0_].worldY) - 6) / 1)) and cursorX and getScreenFromWorldPosition(railSwitches[_ARG_0_].worldX, railSwitches[_ARG_0_].worldY, minePosZ + 1, 128) - 64 * (1 + railSwitchFading[_ARG_0_] * 2) / 2 <= cursorX and getScreenFromWorldPosition(railSwitches[_ARG_0_].worldX, railSwitches[_ARG_0_].worldY, minePosZ + 1, 128) - 64 / 2 <= cursorY and cursorX <= getScreenFromWorldPosition(railSwitches[_ARG_0_].worldX, railSwitches[_ARG_0_].worldY, minePosZ + 1, 128) - 64 * (1 + railSwitchFading[_ARG_0_] * 2) / 2 + 64 * (1 + railSwitchFading[_ARG_0_] * 2) and cursorY <= getScreenFromWorldPosition(railSwitches[_ARG_0_].worldX, railSwitches[_ARG_0_].worldY, minePosZ + 1, 128) - 64 / 2 + 64 then
      _UPVALUE1_ = "railSwitch"
      _UPVALUE2_ = _ARG_0_
      _UPVALUE3_ = nil
      _UPVALUE4_ = nil
    end
    dxDrawRectangle(getScreenFromWorldPosition(railSwitches[_ARG_0_].worldX, railSwitches[_ARG_0_].worldY, minePosZ + 1, 128) - 64 * (1 + railSwitchFading[_ARG_0_] * 2) / 2, getScreenFromWorldPosition(railSwitches[_ARG_0_].worldX, railSwitches[_ARG_0_].worldY, minePosZ + 1, 128) - 64 / 2, 64 * (1 + railSwitchFading[_ARG_0_] * 2), 64, tocolor(guiColorCodes.primaryGrey[1], guiColorCodes.primaryGrey[2], guiColorCodes.primaryGrey[3], 255 * (1 - math.max(0, (getDistanceBetweenPoints2D(selfPosX, selfPosY, railSwitches[_ARG_0_].worldX, railSwitches[_ARG_0_].worldY) - 6) / 1))))
    for _FORV_24_ = 1, 3 do
      if true and getScreenFromWorldPosition(railSwitches[_ARG_0_].worldX, railSwitches[_ARG_0_].worldY, minePosZ + 1, 128) - 64 * (1 + railSwitchFading[_ARG_0_] * 2) / 2 + (_FORV_24_ - 1) * 64 * railSwitchFading[_ARG_0_] <= cursorX and cursorX <= getScreenFromWorldPosition(railSwitches[_ARG_0_].worldX, railSwitches[_ARG_0_].worldY, minePosZ + 1, 128) - 64 * (1 + railSwitchFading[_ARG_0_] * 2) / 2 + (_FORV_24_ - 1) * 64 * railSwitchFading[_ARG_0_] + 64 then
        dxDrawRectangle(getScreenFromWorldPosition(railSwitches[_ARG_0_].worldX, railSwitches[_ARG_0_].worldY, minePosZ + 1, 128) - 64 * (1 + railSwitchFading[_ARG_0_] * 2) / 2 + (_FORV_24_ - 1) * 64 * railSwitchFading[_ARG_0_], getScreenFromWorldPosition(railSwitches[_ARG_0_].worldX, railSwitches[_ARG_0_].worldY, minePosZ + 1, 128) - 64 / 2, 64, 64, tocolor(guiColorCodes.secondaryGrey[1], guiColorCodes.secondaryGrey[2], guiColorCodes.secondaryGrey[3], 255 * (1 - math.max(0, (getDistanceBetweenPoints2D(selfPosX, selfPosY, railSwitches[_ARG_0_].worldX, railSwitches[_ARG_0_].worldY) - 6) / 1)) * railSwitchFading[_ARG_0_]))
        if 1 <= railSwitchFading[_ARG_0_] then
          _UPVALUE3_ = _FORV_24_
        else
          _UPVALUE3_ = false
        end
      end
      dxDrawImage(getScreenFromWorldPosition(railSwitches[_ARG_0_].worldX, railSwitches[_ARG_0_].worldY, minePosZ + 1, 128) - 64 * (1 + railSwitchFading[_ARG_0_] * 2) / 2 + (_FORV_24_ - 1) * 64 * railSwitchFading[_ARG_0_] + (64 - (64 - 8)) / 2, getScreenFromWorldPosition(railSwitches[_ARG_0_].worldX, railSwitches[_ARG_0_].worldY, minePosZ + 1, 128) - (64 - 8) / 2, 64 - 8, 64 - 8, _UPVALUE5_["railSwitch_" .. #railSwitches[_ARG_0_].trackIds], math.floor((math.deg(math.atan2(railSwitches[_ARG_0_].worldY - selfCamY, railSwitches[_ARG_0_].worldX - selfCamX)) - railSwitches[_ARG_0_].angleDeg + 180) % 360 / 90 + 0.5) * 90, 0, 0, tocolor(guiColorCodes.middleGrey[1], guiColorCodes.middleGrey[2], guiColorCodes.middleGrey[3], _FORV_24_ == (railSwitchStates[_ARG_0_] or 1) and 255 * (1 - math.max(0, (getDistanceBetweenPoints2D(selfPosX, selfPosY, railSwitches[_ARG_0_].worldX, railSwitches[_ARG_0_].worldY) - 6) / 1)) or 255 * (1 - math.max(0, (getDistanceBetweenPoints2D(selfPosX, selfPosY, railSwitches[_ARG_0_].worldX, railSwitches[_ARG_0_].worldY) - 6) / 1)) * railSwitchFading[_ARG_0_]))
      if _FORV_24_ == 1 then
        dxDrawImage(getScreenFromWorldPosition(railSwitches[_ARG_0_].worldX, railSwitches[_ARG_0_].worldY, minePosZ + 1, 128) - 64 * (1 + railSwitchFading[_ARG_0_] * 2) / 2 + (_FORV_24_ - 1) * 64 * railSwitchFading[_ARG_0_] + (64 - (64 - 8)) / 2, getScreenFromWorldPosition(railSwitches[_ARG_0_].worldX, railSwitches[_ARG_0_].worldY, minePosZ + 1, 128) - (64 - 8) / 2, 64 - 8, 64 - 8, _UPVALUE5_["railSwitch_" .. #railSwitches[_ARG_0_].trackIds .. "_1"], math.floor((math.deg(math.atan2(railSwitches[_ARG_0_].worldY - selfCamY, railSwitches[_ARG_0_].worldX - selfCamX)) - railSwitches[_ARG_0_].angleDeg + 180) % 360 / 90 + 0.5) * 90, 0, 0, tocolor((_FORV_24_ == (railSwitchStates[_ARG_0_] or 1) and guiColorCodes.primaryYellow or guiColorCodes.lightGrey)[1], (_FORV_24_ == (railSwitchStates[_ARG_0_] or 1) and guiColorCodes.primaryYellow or guiColorCodes.lightGrey)[2], (_FORV_24_ == (railSwitchStates[_ARG_0_] or 1) and guiColorCodes.primaryYellow or guiColorCodes.lightGrey)[3], _FORV_24_ == (railSwitchStates[_ARG_0_] or 1) and 255 * (1 - math.max(0, (getDistanceBetweenPoints2D(selfPosX, selfPosY, railSwitches[_ARG_0_].worldX, railSwitches[_ARG_0_].worldY) - 6) / 1)) or 255 * (1 - math.max(0, (getDistanceBetweenPoints2D(selfPosX, selfPosY, railSwitches[_ARG_0_].worldX, railSwitches[_ARG_0_].worldY) - 6) / 1)) * railSwitchFading[_ARG_0_]))
      else
        dxDrawImage(getScreenFromWorldPosition(railSwitches[_ARG_0_].worldX, railSwitches[_ARG_0_].worldY, minePosZ + 1, 128) - 64 * (1 + railSwitchFading[_ARG_0_] * 2) / 2 + (_FORV_24_ - 1) * 64 * railSwitchFading[_ARG_0_] + (64 - (64 - 8)) / 2, getScreenFromWorldPosition(railSwitches[_ARG_0_].worldX, railSwitches[_ARG_0_].worldY, minePosZ + 1, 128) - (64 - 8) / 2 + (_FORV_24_ > 2 and 64 - 8 or 0), 64 - 8, (64 - 8) * (_FORV_24_ > 2 and -1 or 1), _UPVALUE5_["railSwitch_" .. #railSwitches[_ARG_0_].trackIds .. "_2"], math.floor((math.deg(math.atan2(railSwitches[_ARG_0_].worldY - selfCamY, railSwitches[_ARG_0_].worldX - selfCamX)) - railSwitches[_ARG_0_].angleDeg + 180) % 360 / 90 + 0.5) * 90, 0, 0, tocolor((_FORV_24_ == (railSwitchStates[_ARG_0_] or 1) and guiColorCodes.primaryYellow or guiColorCodes.lightGrey)[1], (_FORV_24_ == (railSwitchStates[_ARG_0_] or 1) and guiColorCodes.primaryYellow or guiColorCodes.lightGrey)[2], (_FORV_24_ == (railSwitchStates[_ARG_0_] or 1) and guiColorCodes.primaryYellow or guiColorCodes.lightGrey)[3], _FORV_24_ == (railSwitchStates[_ARG_0_] or 1) and 255 * (1 - math.max(0, (getDistanceBetweenPoints2D(selfPosX, selfPosY, railSwitches[_ARG_0_].worldX, railSwitches[_ARG_0_].worldY) - 6) / 1)) or 255 * (1 - math.max(0, (getDistanceBetweenPoints2D(selfPosX, selfPosY, railSwitches[_ARG_0_].worldX, railSwitches[_ARG_0_].worldY) - 6) / 1)) * railSwitchFading[_ARG_0_]))
      end
    end
  else
    dxDrawRectangle(getScreenFromWorldPosition(railSwitches[_ARG_0_].worldX, railSwitches[_ARG_0_].worldY, minePosZ + 1, 128) - 64 / 2, getScreenFromWorldPosition(railSwitches[_ARG_0_].worldX, railSwitches[_ARG_0_].worldY, minePosZ + 1, 128) - 64 / 2, 64, 64, tocolor(guiColorCodes.primaryGrey[1], guiColorCodes.primaryGrey[2], guiColorCodes.primaryGrey[3], 255 * (1 - math.max(0, (getDistanceBetweenPoints2D(selfPosX, selfPosY, railSwitches[_ARG_0_].worldX, railSwitches[_ARG_0_].worldY) - 6) / 1))))
    if 255 <= 255 * (1 - math.max(0, (getDistanceBetweenPoints2D(selfPosX, selfPosY, railSwitches[_ARG_0_].worldX, railSwitches[_ARG_0_].worldY) - 6) / 1)) and cursorX and getScreenFromWorldPosition(railSwitches[_ARG_0_].worldX, railSwitches[_ARG_0_].worldY, minePosZ + 1, 128) - 64 / 2 <= cursorX and getScreenFromWorldPosition(railSwitches[_ARG_0_].worldX, railSwitches[_ARG_0_].worldY, minePosZ + 1, 128) - 64 / 2 <= cursorY and cursorX <= getScreenFromWorldPosition(railSwitches[_ARG_0_].worldX, railSwitches[_ARG_0_].worldY, minePosZ + 1, 128) - 64 / 2 + 64 and cursorY <= getScreenFromWorldPosition(railSwitches[_ARG_0_].worldX, railSwitches[_ARG_0_].worldY, minePosZ + 1, 128) - 64 / 2 + 64 then
      _UPVALUE1_ = "railSwitch"
      _UPVALUE2_ = _ARG_0_
      _UPVALUE3_ = nil
      _UPVALUE4_ = nil
    end
    dxDrawImage(getScreenFromWorldPosition(railSwitches[_ARG_0_].worldX, railSwitches[_ARG_0_].worldY, minePosZ + 1, 128) - (64 - 8) / 2, getScreenFromWorldPosition(railSwitches[_ARG_0_].worldX, railSwitches[_ARG_0_].worldY, minePosZ + 1, 128) - (64 - 8) / 2, 64 - 8, 64 - 8, _UPVALUE5_["railSwitch_" .. #railSwitches[_ARG_0_].trackIds], math.floor((math.deg(math.atan2(railSwitches[_ARG_0_].worldY - selfCamY, railSwitches[_ARG_0_].worldX - selfCamX)) - railSwitches[_ARG_0_].angleDeg + 180) % 360 / 90 + 0.5) * 90, 0, 0, tocolor(guiColorCodes.middleGrey[1], guiColorCodes.middleGrey[2], guiColorCodes.middleGrey[3], 255 * (1 - math.max(0, (getDistanceBetweenPoints2D(selfPosX, selfPosY, railSwitches[_ARG_0_].worldX, railSwitches[_ARG_0_].worldY) - 6) / 1))))
    if (railSwitchStates[_ARG_0_] or 1) == 1 then
      dxDrawImage(getScreenFromWorldPosition(railSwitches[_ARG_0_].worldX, railSwitches[_ARG_0_].worldY, minePosZ + 1, 128) - (64 - 8) / 2, getScreenFromWorldPosition(railSwitches[_ARG_0_].worldX, railSwitches[_ARG_0_].worldY, minePosZ + 1, 128) - (64 - 8) / 2, 64 - 8, 64 - 8, _UPVALUE5_["railSwitch_" .. #railSwitches[_ARG_0_].trackIds .. "_1"], math.floor((math.deg(math.atan2(railSwitches[_ARG_0_].worldY - selfCamY, railSwitches[_ARG_0_].worldX - selfCamX)) - railSwitches[_ARG_0_].angleDeg + 180) % 360 / 90 + 0.5) * 90, 0, 0, tocolor(guiColorCodes.primaryYellow[1], guiColorCodes.primaryYellow[2], guiColorCodes.primaryYellow[3], 255 * (1 - math.max(0, (getDistanceBetweenPoints2D(selfPosX, selfPosY, railSwitches[_ARG_0_].worldX, railSwitches[_ARG_0_].worldY) - 6) / 1))))
    else
      dxDrawImage(getScreenFromWorldPosition(railSwitches[_ARG_0_].worldX, railSwitches[_ARG_0_].worldY, minePosZ + 1, 128) - (64 - 8) / 2, getScreenFromWorldPosition(railSwitches[_ARG_0_].worldX, railSwitches[_ARG_0_].worldY, minePosZ + 1, 128) - (64 - 8) / 2 + (2 < (railSwitchStates[_ARG_0_] or 1) and 64 - 8 or 0), 64 - 8, (64 - 8) * (2 < (railSwitchStates[_ARG_0_] or 1) and -1 or 1), _UPVALUE5_["railSwitch_" .. #railSwitches[_ARG_0_].trackIds .. "_2"], math.floor((math.deg(math.atan2(railSwitches[_ARG_0_].worldY - selfCamY, railSwitches[_ARG_0_].worldX - selfCamX)) - railSwitches[_ARG_0_].angleDeg + 180) % 360 / 90 + 0.5) * 90, 0, 0, tocolor(guiColorCodes.primaryYellow[1], guiColorCodes.primaryYellow[2], guiColorCodes.primaryYellow[3], 255 * (1 - math.max(0, (getDistanceBetweenPoints2D(selfPosX, selfPosY, railSwitches[_ARG_0_].worldX, railSwitches[_ARG_0_].worldY) - 6) / 1))))
    end
  end
end
function renderRailSwitchHighlight(_ARG_0_, _ARG_1_)
  if _ARG_1_ > 0 and railSwitches[_ARG_0_] and railSwitchRoutes[_ARG_0_] then
    for _FORV_8_ = 1, 4 do
      if railSwitchRoutes[_ARG_0_][_FORV_8_] then
        for _FORV_13_ = -1, 1, 2 do
          for _FORV_20_ = 0, 0.525, 0.025 do
            if railSwitchRoutes[_ARG_0_][_FORV_8_].curveAngle then
              _FORV_20_ = _FORV_20_ * 3
              if _FORV_20_ >= 2 then
              elseif _FORV_20_ >= 1 then
              else
              end
              if _FORV_20_ >= 2 then
              elseif _FORV_20_ <= 1 then
              end
            else
            end
            if _FORV_20_ > 0 then
              dxDrawMaterialLine3D(nil, nil, minePosZ + 0.15, railSwitches[_ARG_0_].worldX + railSwitchRoutes[_ARG_0_][_FORV_8_].offsetX + math.cos(railSwitchRoutes[_ARG_0_][_FORV_8_].curveAngle) * (2 - _FORV_13_ * 0.34708) - math.sin(railSwitchRoutes[_ARG_0_][_FORV_8_].curveAngle) * (_FORV_20_ - 2) * railSwitchRoutes[_ARG_0_][_FORV_8_].curveDirSign + math.sin(railSwitchRoutes[_ARG_0_][_FORV_8_].curveAngle) * (1 - _FORV_20_) * railSwitchRoutes[_ARG_0_][_FORV_8_].curveDirSign - railSwitchRoutes[_ARG_0_][_FORV_8_].offsetX * 2 * _FORV_20_ + railSwitchRoutes[_ARG_0_][_FORV_8_].offsetY / 3 * (_FORV_13_ * 0.34708), railSwitches[_ARG_0_].worldY + railSwitchRoutes[_ARG_0_][_FORV_8_].offsetY + math.sin(railSwitchRoutes[_ARG_0_][_FORV_8_].curveAngle) * (2 - _FORV_13_ * 0.34708) + math.cos(railSwitchRoutes[_ARG_0_][_FORV_8_].curveAngle) * (_FORV_20_ - 2) * railSwitchRoutes[_ARG_0_][_FORV_8_].curveDirSign - math.cos(railSwitchRoutes[_ARG_0_][_FORV_8_].curveAngle) * (1 - _FORV_20_) * railSwitchRoutes[_ARG_0_][_FORV_8_].curveDirSign - railSwitchRoutes[_ARG_0_][_FORV_8_].offsetY * 2 * _FORV_20_ - railSwitchRoutes[_ARG_0_][_FORV_8_].offsetX / 3 * (_FORV_13_ * 0.34708), minePosZ + 0.15, mineAssets.railHighlight, 0.2, tocolor(guiColorCodes.primaryYellow[1], guiColorCodes.primaryYellow[2], guiColorCodes.primaryYellow[3], _ARG_1_), railSwitches[_ARG_0_].worldX + railSwitchRoutes[_ARG_0_][_FORV_8_].offsetX + math.cos(railSwitchRoutes[_ARG_0_][_FORV_8_].curveAngle) * (2 - _FORV_13_ * 0.34708) - math.sin(railSwitchRoutes[_ARG_0_][_FORV_8_].curveAngle) * (_FORV_20_ - 2) * railSwitchRoutes[_ARG_0_][_FORV_8_].curveDirSign + math.sin(railSwitchRoutes[_ARG_0_][_FORV_8_].curveAngle) * (1 - _FORV_20_) * railSwitchRoutes[_ARG_0_][_FORV_8_].curveDirSign - railSwitchRoutes[_ARG_0_][_FORV_8_].offsetX * 2 * _FORV_20_ + railSwitchRoutes[_ARG_0_][_FORV_8_].offsetY / 3 * (_FORV_13_ * 0.34708), railSwitches[_ARG_0_].worldY + railSwitchRoutes[_ARG_0_][_FORV_8_].offsetY + math.sin(railSwitchRoutes[_ARG_0_][_FORV_8_].curveAngle) * (2 - _FORV_13_ * 0.34708) + math.cos(railSwitchRoutes[_ARG_0_][_FORV_8_].curveAngle) * (_FORV_20_ - 2) * railSwitchRoutes[_ARG_0_][_FORV_8_].curveDirSign - math.cos(railSwitchRoutes[_ARG_0_][_FORV_8_].curveAngle) * (1 - _FORV_20_) * railSwitchRoutes[_ARG_0_][_FORV_8_].curveDirSign - railSwitchRoutes[_ARG_0_][_FORV_8_].offsetY * 2 * _FORV_20_ - railSwitchRoutes[_ARG_0_][_FORV_8_].offsetX / 3 * (_FORV_13_ * 0.34708), minePosZ + 1)
            end
          end
        end
      end
    end
  end
end
function renderRailEditButton()
  if railEditing and railEditing.baseX == selfMineX and railEditing.baseY == selfMineY then
    renderActionButton("cancelIcon", minePosX + selfMineX * 6, minePosY + selfMineY * 6, minePosZ + 0.25, 2, 2.5, false, "closeRailEditMode")
  else
    renderActionButton("constructionIcon", minePosX + selfMineX * 6, minePosY + selfMineY * 6, minePosZ + 0.25, 2, 2.5, false, "openRailEditMode")
  end
end
function renderActionButton(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_, _ARG_5_, _ARG_6_, ...)
  if _ARG_5_ > getDistanceBetweenPoints2D(_ARG_1_, _ARG_2_, selfPosX, selfPosY) and getScreenFromWorldPosition(_ARG_1_, _ARG_2_, _ARG_3_, 16) and 0 < 255 * (1 - math.max(0, (getDistanceBetweenPoints2D(_ARG_1_, _ARG_2_, selfPosX, selfPosY) - _ARG_4_) / (_ARG_5_ - _ARG_4_))) then
    if 255 <= 255 * (1 - math.max(0, (getDistanceBetweenPoints2D(_ARG_1_, _ARG_2_, selfPosX, selfPosY) - _ARG_4_) / (_ARG_5_ - _ARG_4_))) and cursorX and cursorX >= getScreenFromWorldPosition(_ARG_1_, _ARG_2_, _ARG_3_, 16) - 16 and cursorY >= getScreenFromWorldPosition(_ARG_1_, _ARG_2_, _ARG_3_, 16) - 16 and cursorX <= getScreenFromWorldPosition(_ARG_1_, _ARG_2_, _ARG_3_, 16) + 16 and cursorY <= getScreenFromWorldPosition(_ARG_1_, _ARG_2_, _ARG_3_, 16) + 16 then
    else
    end
    dxDrawRectangle(getScreenFromWorldPosition(_ARG_1_, _ARG_2_, _ARG_3_, 16) - 16, getScreenFromWorldPosition(_ARG_1_, _ARG_2_, _ARG_3_, 16) - 16, 32, 32, tocolor(guiColorCodes.primaryGrey[1], guiColorCodes.primaryGrey[2], guiColorCodes.primaryGrey[3], 255 * (1 - math.max(0, (getDistanceBetweenPoints2D(_ARG_1_, _ARG_2_, selfPosX, selfPosY) - _ARG_4_) / (_ARG_5_ - _ARG_4_)))))
    dxDrawImage(getScreenFromWorldPosition(_ARG_1_, _ARG_2_, _ARG_3_, 16) - 12, getScreenFromWorldPosition(_ARG_1_, _ARG_2_, _ARG_3_, 16) - 12, 24, 24, ":see_gui/" .. guiIcons[_ARG_0_] .. guiIconTicks[_ARG_0_] .. ".fa", 0, 0, 0, (tocolor(255, 255, 255, 255 * (1 - math.max(0, (getDistanceBetweenPoints2D(_ARG_1_, _ARG_2_, selfPosX, selfPosY) - _ARG_4_) / (_ARG_5_ - _ARG_4_))))))
    if 255 <= 255 * (1 - math.max(0, (getDistanceBetweenPoints2D(_ARG_1_, _ARG_2_, selfPosX, selfPosY) - _ARG_4_) / (_ARG_5_ - _ARG_4_))) then
      if tocolor(255, 255, 255, 255 * (1 - math.max(0, (getDistanceBetweenPoints2D(_ARG_1_, _ARG_2_, selfPosX, selfPosY) - _ARG_4_) / (_ARG_5_ - _ARG_4_)))) == guiColors.primaryGreen then
        mineAssets, _UPVALUE1_, _UPVALUE2_, _UPVALUE3_ = ...
      end
      if _ARG_6_ then
        setActionKeyBind(getDistanceBetweenPoints2D(_ARG_1_, _ARG_2_, selfPosX, selfPosY), ...)
      end
    end
    return getScreenFromWorldPosition(_ARG_1_, _ARG_2_, _ARG_3_, 16)
  end
end
function restoreMine()
  if mineAssets then
    processCurrentActiveWorld()
  end
end
function clickMine(_ARG_0_, _ARG_1_)
  if _ARG_1_ == "up" then
    doInteraction(mineAssets, _UPVALUE1_, _UPVALUE2_, _UPVALUE3_)
  end
end
function triggerRemoteEvent(_ARG_0_, ...)
  if mineAssets[_ARG_0_] and getTickCount() - mineAssets[_ARG_0_] < 1000 then
    exports.see_gui:showInfobox("e", "Várj egy kicsit!")
    return
  end
  triggerServerEvent(_ARG_0_, ...)
  mineAssets[_ARG_0_] = getTickCount()
end
function doInteraction(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  if _ARG_0_ == "newShaft" then
    if checkMinePermission(permissionFlags.USE_BOMB) then
      triggerRemoteEvent("createNewMineShaft", localPlayer, _ARG_1_, _ARG_2_, _ARG_3_)
    else
      exports.see_gui:showInfobox("e", "Ehhez nincs jogosultságod!")
    end
  elseif _ARG_0_ == "extendThreeJunction" then
    if checkMinePermission(permissionFlags.USE_BOMB) then
      triggerRemoteEvent("extendMineThreeJunction", localPlayer, selfMineX, selfMineY)
    else
      exports.see_gui:showInfobox("e", "Ehhez nincs jogosultságod!")
    end
  elseif _ARG_0_ == "openShaftBomb" then
    if checkMinePermission(permissionFlags.USE_BOMB) then
      triggerRemoteEvent("handleMineDetonate", localPlayer, _ARG_1_)
    else
      exports.see_gui:showInfobox("e", "Ehhez nincs jogosultságod!")
    end
  elseif _ARG_0_ == "openRailEditMode" then
    if checkMinePermission(permissionFlags.CONSTRUCT_RAIL) then
      setRailEditMode(selfMineX, selfMineY)
      if not railEditing then
        exports.see_gui:showInfobox("e", "Nem lehet új sínt létrehozni ezen a helyen!")
      end
    else
      exports.see_gui:showInfobox("e", "Ehhez nincs jogosultságod!")
    end
  elseif _ARG_0_ == "closeRailEditMode" then
    railEditing = nil
  elseif _ARG_0_ == "doConstructRail" then
    if checkMinePermission(permissionFlags.CONSTRUCT_RAIL) then
      if _ARG_3_ * railIronCost <= currentMineInventory.railIrons and _ARG_3_ * railWoodCost <= currentMineInventory.railWoods then
        triggerRemoteEvent("createNewMineRailTrack", localPlayer, _ARG_1_, _ARG_2_)
      else
        exports.see_gui:showInfobox("e", "Nincs elég anyag az építéshez!")
      end
    else
      exports.see_gui:showInfobox("e", "Ehhez nincs jogosultságod!")
    end
  elseif _ARG_0_ == "railSwitch" then
    if railSwitches[_ARG_1_] and _ARG_2_ and railSwitchStates[_ARG_1_] ~= _ARG_2_ then
      if checkMinePermission(permissionFlags.USE_SWITCHES) then
        if not railSwitchBusy[_ARG_1_] then
          triggerRemoteEvent("setMineRailSwitch", localPlayer, _ARG_1_, _ARG_2_)
        else
          exports.see_gui:showInfobox("e", "Addig nem válthatod át, amíg rajta áll a vonat!")
        end
      else
        exports.see_gui:showInfobox("e", "Ehhez nincs jogosultságod!")
      end
    end
  elseif _ARG_0_ == "driveDieselLoco" then
    if checkMinePermission(permissionFlags.USE_RAILCAR) then
      driveLocomotive()
    else
      exports.see_gui:showInfobox("e", "Ehhez nincs jogosultságod!")
    end
  elseif _ARG_0_ == "dieselLocoPassenger" then
    triggerRemoteEvent("standMineLocoPassenger", localPlayer, _ARG_1_)
  elseif _ARG_0_ == "pickUpFixOre" then
    if checkMinePermission(permissionFlags.PICK_ORES) then
      triggerRemoteEvent("pickUpMineFixOre", localPlayer, _ARG_1_)
    else
      exports.see_gui:showInfobox("e", "Ehhez nincs jogosultságod!")
    end
  elseif _ARG_0_ == "putOreInCart" then
    triggerRemoteEvent("putOreInMineCart", localPlayer, _ARG_1_)
  elseif _ARG_0_ == "toggleSortingMachine" then
    if checkMinePermission(permissionFlags.USE_SORTER_MACHINE) then
      if not mineMachineData.forceMachine then
        triggerRemoteEvent("toggleMineSortingMachine", localPlayer)
      else
        exports.see_gui:showInfobox("e", "A válogatógép jelenleg nem kapcsolható ki!")
      end
    else
      exports.see_gui:showInfobox("e", "Ehhez nincs jogosultságod!")
    end
  elseif _ARG_0_ == "emptyCart" then
    if checkMinePermission(permissionFlags.USE_SORTER_MACHINE) then
      if mineMachineData.machineRunning then
        triggerRemoteEvent("emptyMineCart", localPlayer, _ARG_1_)
      else
        exports.see_gui:showInfobox("e", "Előbb kapcsold be a válogatógépet!")
      end
    else
      exports.see_gui:showInfobox("e", "Ehhez nincs jogosultságod!")
    end
  elseif _ARG_0_ == "sackOre" then
    if checkMinePermission(permissionFlags.COLLECT_PRODUCT) then
      triggerRemoteEvent("sackMineOre", localPlayer, _ARG_1_)
    else
      exports.see_gui:showInfobox("e", "Ehhez nincs jogosultságod!")
    end
  elseif _ARG_0_ == "pickUpOreBox" then
    if checkMinePermission(permissionFlags.USE_FOUNDRY) then
      triggerRemoteEvent("pickUpMineOreBox", localPlayer, _ARG_1_)
    else
      exports.see_gui:showInfobox("e", "Ehhez nincs jogosultságod!")
    end
  elseif _ARG_0_ == "putDownOreBox" then
    triggerRemoteEvent("putDownMineOreBox", localPlayer)
  elseif _ARG_0_ == "toggleFoundry" then
    if checkMinePermission(permissionFlags.USE_FOUNDRY) then
      if mineFoundryData.meltingOre then
        if mineFoundryData.meltProgress >= 0.9 then
          exports.see_gui:showInfobox("e", "Előbb vedd ki a kihűlt fémet az öntőformából!")
        else
          exports.see_gui:showInfobox("e", "Előbb várd meg a fém kiöntését!")
        end
      else
        triggerRemoteEvent("toggleMineFoundry", localPlayer, _ARG_1_)
      end
    else
      exports.see_gui:showInfobox("e", "Ehhez nincs jogosultságod!")
    end
  elseif _ARG_0_ == "fillFoundry" then
    if oreTypes[_ARG_1_] then
      triggerRemoteEvent("fillMineFoundry", localPlayer, oreTypes[_ARG_1_].boxContent)
    end
  elseif _ARG_0_ == "makeIngot" then
    if checkMinePermission(permissionFlags.USE_FOUNDRY) then
      triggerRemoteEvent("makeMineIngot", localPlayer, _ARG_1_)
    else
      exports.see_gui:showInfobox("e", "Ehhez nincs jogosultságod!")
    end
  elseif _ARG_0_ == "takeIngot" then
    if checkMinePermission(permissionFlags.COLLECT_PRODUCT) then
      triggerRemoteEvent("takeMineIngot", localPlayer, _ARG_1_)
    else
      exports.see_gui:showInfobox("e", "Ehhez nincs jogosultságod!")
    end
  elseif _ARG_0_ == "getJerryCan" then
    triggerRemoteEvent("getMineJerrycan", localPlayer)
  elseif _ARG_0_ == "putJerryCan" then
    triggerRemoteEvent("putMineJerrycan", localPlayer)
  elseif _ARG_0_ == "fillJerryCan" then
    triggerRemoteEvent("fillMineJerrycan", localPlayer)
  elseif _ARG_0_ == "fillLocoTank" then
    triggerRemoteEvent("fillMineLocoTank", localPlayer)
  elseif _ARG_0_ == "useComputer" then
    createComputer()
  elseif _ARG_0_ == "buildLight" then
    if checkMinePermission(permissionFlags.CONSTRUCT_LAMP) then
      if currentMineInventory.mineLamps > 0 then
        triggerRemoteEvent("buildMineLight", localPlayer, selfMineX, selfMineY)
      else
        exports.see_gui:showInfobox("e", "Nincs elég lámpa készleten!")
      end
    else
      exports.see_gui:showInfobox("e", "Ehhez nincs jogosultságod!")
    end
  elseif _ARG_0_ == "useFaucet" then
    triggerRemoteEvent("useMineFaucet", localPlayer)
  end
end
function keyMine(_ARG_0_, _ARG_1_)
  if _ARG_1_ and not isCursorShowing() and not isChatBoxInputActive() and not isConsoleActive() then
    if _ARG_0_ == "f" then
      if carryingFixOre then
        for _FORV_7_ = 1, #cartTurtleObjects do
          if not cartTurtleEmptying[_FORV_7_] and not cartTurtleRotation[_FORV_7_] then
            if (cartMaxSlots[_FORV_7_] or 0) < #oreCartOffsets and 2 >= getDistanceBetweenPoints2D(getElementPosition(cartTurtleObjects[_FORV_7_])) then
            end
          end
        end
        if _FORV_7_ and not oreTypes[mineAssets[carryingFixOre][10]].instantItem then
          triggerRemoteEvent("putOreInMineCart", localPlayer, _FORV_7_)
        else
          triggerRemoteEvent("putDownMineFixOre", localPlayer)
        end
      elseif _UPVALUE1_ then
        doInteraction(unpack(_UPVALUE1_))
      end
    elseif _ARG_0_ == "e" then
      if carryingFixOre and oreTypes[mineAssets[carryingFixOre][10]].instantItem then
        triggerRemoteEvent("giveInstantOre", localPlayer)
      end
    else
      doRailCarInteraction(_ARG_0_)
    end
  end
end
function setActionKeyBind(_ARG_0_, ...)
  if not mineAssets or _ARG_0_ < mineAssets.actionDistance then
    mineAssets = {
      actionDistance = _ARG_0_,
      ...
    }
  end
end
function checkValidSpot(_ARG_0_, _ARG_1_)
  return (not tunnelObjectRots[_ARG_0_] or not tunnelObjectRots[_ARG_0_][_ARG_1_]) and junctionObjects[_ARG_0_] and junctionObjects[_ARG_0_][_ARG_1_]
end
function checkValidSpotEx(_ARG_0_, _ARG_1_)
  if checkValidSpot(_ARG_0_, _ARG_1_) and (not openShaftsAt[_ARG_0_] or not openShaftsAt[_ARG_0_][_ARG_1_]) then
    return true
  end
  return false
end
function checkValidPlayerSpot(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  for _FORV_7_ = _ARG_0_, _ARG_1_ do
    if checkValidSpotEx(_FORV_7_, _ARG_2_) then
      return _FORV_7_, _ARG_2_
    end
  end
  for _FORV_7_ = _ARG_0_, _ARG_1_ do
    if checkValidSpotEx(_FORV_7_, _ARG_3_) then
      return _FORV_7_, _ARG_3_
    end
  end
  for _FORV_7_ = _ARG_2_ - 1, _ARG_3_ - 1 do
    if checkValidSpotEx(_ARG_0_, _FORV_7_) then
      return _ARG_0_, _FORV_7_
    end
  end
  for _FORV_7_ = _ARG_2_ - 1, _ARG_3_ - 1 do
    if checkValidSpotEx(_ARG_1_, _FORV_7_) then
      return _ARG_1_, _FORV_7_
    end
  end
  return _FOR_
end
function setRailEditMode(_ARG_0_, _ARG_1_)
  railEditing = {
    baseX = _ARG_0_,
    baseY = _ARG_1_,
    sidesList = {},
    checkList = {}
  }
  for _FORV_6_ = 0, 270, 90 do
    if canConstructRail(railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_)))) and checkValidSpotEx(_ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_)))) then
      if not ({})[_ARG_0_ + pcos((prad(_FORV_6_)))] then
        ({})[_ARG_0_ + pcos((prad(_FORV_6_)))] = {}
      end
      ;({})[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))] = true
      for _FORV_17_ = 0, 270, 90 do
        if not ({})[_ARG_0_ + pcos((prad(_FORV_6_))) + pcos((prad(_FORV_17_)))] then
          ({})[_ARG_0_ + pcos((prad(_FORV_6_))) + pcos((prad(_FORV_17_)))] = {}
        end
        ;({})[_ARG_0_ + pcos((prad(_FORV_6_))) + pcos((prad(_FORV_17_)))][_ARG_1_ + psin((prad(_FORV_6_))) + psin((prad(_FORV_17_)))] = true
      end
      for _FORV_20_ = 1, #(doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {}) do
        if (doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][1] == "extend" then
          if railTracks[(doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][2]] then
            table.insert({}, {
              1,
              railTracks[(doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][2]].spotX,
              railTracks[(doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][2]].spotY,
              railTracks[(doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][2]].angleCos,
              railTracks[(doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][2]].angleSin
            })
            table.insert({}, {
              (doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][3] and 1 or 0,
              railTracks[(doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][2]].spotX + railTracks[(doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][2]].angleCos,
              railTracks[(doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][2]].spotY + railTracks[(doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][2]].angleSin,
              railTracks[(doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][2]].angleCos,
              railTracks[(doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][2]].angleSin
            })
            if not ({})[railTracks[(doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][2]].spotX + railTracks[(doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][2]].angleCos] then
              ({})[railTracks[(doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][2]].spotX + railTracks[(doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][2]].angleCos] = {}
            end
            ;({})[railTracks[(doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][2]].spotX + railTracks[(doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][2]].angleCos][railTracks[(doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][2]].spotY + railTracks[(doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][2]].angleSin] = true
          end
        elseif (doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][1] == "openup" then
          if railTracks[(doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][2]] then
            table.insert({}, {
              1,
              railTracks[(doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][2]].spotX,
              railTracks[(doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][2]].spotY,
              railTracks[(doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][2]].angleCos,
              railTracks[(doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][2]].angleSin
            })
          end
        elseif (doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][1] == "single" then
          table.insert({}, {
            (doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][5] and 0 or 1,
            (doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][2],
            (doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][3],
            pcos((prad((doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][4]))),
            (psin((prad((doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][4]))))
          })
          if not ({})[(doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][2]] then
            ({})[(doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][2]] = {}
          end
          ;({})[(doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][2]][(doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][3]] = true
        elseif (doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][1] == "linked" then
          table.insert({}, {
            (doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][5] and 0 or 1,
            (doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][4],
            (doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][5],
            pcos((math.atan2((doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][5] - (doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][3], (doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][4] - (doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][2]))),
            (psin((math.atan2((doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][5] - (doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][3], (doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][4] - (doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][2]))))
          })
          for _FORV_32_ = (doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][2], (doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][4], (doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][2] > (doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][4] and -1 or 1 do
            if not ({})[_FORV_32_] then
              ({})[_FORV_32_] = {}
            end
            for _FORV_36_ = (doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][3], (doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][5], (doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][3] > (doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][5] and -1 or 1 do
              ({})[_FORV_32_][_FORV_36_] = true
            end
          end
        elseif (doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][1] == "switch" then
          if processSwitch((doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][2], (doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][3], {}) then
            table.insert({}, {
              processSwitch((doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][2], (doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][3], {})
            })
          end
        elseif (doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][1] == "extend-switch" then
          if railSwitches[(doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][2]] and processSwitch(railSwitches[(doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][2]].spotX, railSwitches[(doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][2]].spotY, {}) then
            table.insert({}, {
              processSwitch(railSwitches[(doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][2]].spotX, railSwitches[(doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][2]].spotY, {})
            })
          end
        elseif (doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][1] == "merge" then
          if not railTracks[(doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][2]] then
          end
          if railTracks[(doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][3]] then
            table.insert({}, {
              1,
              (doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][4] - railTracks[(doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][3]].angleCos,
              (doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][5] - railTracks[(doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][3]].angleSin,
              railTracks[(doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][3]].angleCos,
              railTracks[(doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][3]].angleSin
            })
            table.insert({}, {
              1,
              (doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][4],
              (doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][5],
              railTracks[(doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][3]].angleCos,
              railTracks[(doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][3]].angleSin
            })
            table.insert({}, {
              1,
              (doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][4] + railTracks[(doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][3]].angleCos,
              (doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][5] + railTracks[(doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][3]].angleSin,
              railTracks[(doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][3]].angleCos,
              railTracks[(doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})[_FORV_20_][3]].angleSin
            })
          end
        end
      end
      for _FORV_20_ = 1, #{} do
        ({})[_FORV_20_][2] = minePosX + ({})[_FORV_20_][2] * 6
        ;({})[_FORV_20_][3] = minePosY + ({})[_FORV_20_][3] * 6
        ;({})[_FORV_20_][4] = ({})[_FORV_20_][4] * 3
        ;({})[_FORV_20_][5] = ({})[_FORV_20_][5] * 3
      end
      _FOR_.insert(railEditing.sidesList, {
        junctionId = junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))],
        spotX = _ARG_0_ + pcos((prad(_FORV_6_))),
        spotY = _ARG_1_ + psin((prad(_FORV_6_))),
        drawList = {},
        totalCost = findRailConstructionCost(doConstructRail(nil, railsAt, railSwitchesAt, _ARG_0_ + pcos((prad(_FORV_6_))), _ARG_1_ + psin((prad(_FORV_6_))), junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))] and junctionObjects[_ARG_0_ + pcos((prad(_FORV_6_)))][_ARG_1_ + psin((prad(_FORV_6_)))]) or {})
      })
    end
  end
  if #_FOR_.sidesList > 0 then
    for _FORV_6_ in pairs({}) do
      for _FORV_10_ in pairs(({})[_FORV_6_]) do
        table.insert(railEditing.checkList, {
          spotX = _FORV_6_,
          spotY = _FORV_10_,
          railId = railsAt[_FORV_6_] and railsAt[_FORV_6_][_FORV_10_],
          switchId = railSwitchesAt[_FORV_6_] and railSwitchesAt[_FORV_6_][_FORV_10_]
        })
      end
    end
  else
    railEditing = nil
  end
end
function processSwitch(_ARG_0_, _ARG_1_, _ARG_2_)
  if #getNearTracks(railsAt, _ARG_0_, _ARG_1_, _ARG_2_) == 2 then
    if (patan2(_ARG_1_ - getNearTracks(railsAt, _ARG_0_, _ARG_1_, _ARG_2_)[1].trackY, _ARG_0_ - getNearTracks(railsAt, _ARG_0_, _ARG_1_, _ARG_2_)[1].trackX) - patan2(_ARG_1_ - getNearTracks(railsAt, _ARG_0_, _ARG_1_, _ARG_2_)[2].trackY, _ARG_0_ - getNearTracks(railsAt, _ARG_0_, _ARG_1_, _ARG_2_)[2].trackX) + PI) % TWO_PI - PI > 0 then
      return 2, psin((patan2(getNearTracks(railsAt, _ARG_0_, _ARG_1_, _ARG_2_)[2].trackY - _ARG_1_, getNearTracks(railsAt, _ARG_0_, _ARG_1_, _ARG_2_)[2].trackX - _ARG_0_))), -pcos((patan2(getNearTracks(railsAt, _ARG_0_, _ARG_1_, _ARG_2_)[2].trackY - _ARG_1_, getNearTracks(railsAt, _ARG_0_, _ARG_1_, _ARG_2_)[2].trackX - _ARG_0_)))
    else
      return 2, psin((patan2(getNearTracks(railsAt, _ARG_0_, _ARG_1_, _ARG_2_)[1].trackY - _ARG_1_, getNearTracks(railsAt, _ARG_0_, _ARG_1_, _ARG_2_)[1].trackX - _ARG_0_))), -pcos((patan2(getNearTracks(railsAt, _ARG_0_, _ARG_1_, _ARG_2_)[1].trackY - _ARG_1_, getNearTracks(railsAt, _ARG_0_, _ARG_1_, _ARG_2_)[1].trackX - _ARG_0_)))
    end
  else
    for _FORV_8_ = 1, #getNearTracks(railsAt, _ARG_0_, _ARG_1_, _ARG_2_) do
      if getNearTracks(railsAt, _ARG_0_, _ARG_1_, _ARG_2_)[_FORV_8_] then
        table.insert({}, {
          getNearTracks(railsAt, _ARG_0_, _ARG_1_, _ARG_2_)[_FORV_8_].trackId,
          patan2(_ARG_1_ - getNearTracks(railsAt, _ARG_0_, _ARG_1_, _ARG_2_)[_FORV_8_].trackY, _ARG_0_ - getNearTracks(railsAt, _ARG_0_, _ARG_1_, _ARG_2_)[_FORV_8_].trackX),
          getNearTracks(railsAt, _ARG_0_, _ARG_1_, _ARG_2_)[_FORV_8_].trackX,
          getNearTracks(railsAt, _ARG_0_, _ARG_1_, _ARG_2_)[_FORV_8_].trackY
        })
      end
    end
    _FOR_.sort({}, function(_ARG_0_, _ARG_1_)
      return _ARG_1_[2] < _ARG_0_[2]
    end)
    while ({})[1][2] % PI ~= ({})[3][2] % PI do
      table.insert({}, 1, table.remove({}, #{}))
    end
    return #{}, psin((patan2(({})[2][4] - _ARG_1_, ({})[2][3] - _ARG_0_))), -pcos((patan2(({})[2][4] - _ARG_1_, ({})[2][3] - _ARG_0_)))
  end
end
;(function(_ARG_0_, _ARG_1_, _ARG_2_)
  addEvent(_ARG_0_, true)
  addEventHandler(_ARG_0_, _ARG_1_, function(_ARG_0_, ...)
    if not loadingMineExit then
      if loadingMineEnter then
        if _ARG_0_ == loadingMineEnter then
          table.insert(mineAssets, {
            eventName = _UPVALUE1_,
            handlerFunction = _UPVALUE2_,
            handlerFunctionParams = {
              ...
            },
            sourceElement = source
          })
        end
      elseif _ARG_0_ == currentMine then
        _UPVALUE2_(_ARG_0_, ...)
      end
    end
  end)
end)("executeMineRailConstruction", root, function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_, _ARG_5_)
  if not ({})[_ARG_2_] then
    ({})[_ARG_2_] = {}
  end
  ;({})[_ARG_2_][_ARG_3_] = true
  for _FORV_10_ = 1, #_ARG_1_ do
    if _ARG_1_[_FORV_10_][1] == "extend" then
    elseif _ARG_1_[_FORV_10_][1] == "single" then
    elseif _ARG_1_[_FORV_10_][1] == "linked" then
    elseif _ARG_1_[_FORV_10_][1] == "split" then
    elseif _ARG_1_[_FORV_10_][1] == "switch" then
    elseif _ARG_1_[_FORV_10_][1] == "extend-switch" then
      if railSwitches[_ARG_1_[_FORV_10_][2]] then
      end
    elseif _ARG_1_[_FORV_10_][1] == "merge" then
      mergeRails(_ARG_1_[_FORV_10_][2], _ARG_1_[_FORV_10_][3], _ARG_1_[_FORV_10_][4], _ARG_1_[_FORV_10_][5])
    elseif _ARG_1_[_FORV_10_][1] == "openup" then
    end
    if openUpRail(_ARG_1_[_FORV_10_][2]) and openUpRail(_ARG_1_[_FORV_10_][2]) then
      if not ({})[openUpRail(_ARG_1_[_FORV_10_][2])] then
        ({})[openUpRail(_ARG_1_[_FORV_10_][2])] = {}
      end
      ;({})[openUpRail(_ARG_1_[_FORV_10_][2])][openUpRail(_ARG_1_[_FORV_10_][2])] = true
    end
  end
  if _FOR_ then
    if source == localPlayer or railEditing.baseX == _ARG_2_ and railEditing.baseY == _ARG_3_ then
      setRailEditMode(_ARG_2_, _ARG_3_)
    else
      for _FORV_12_ = 1, #railEditing.checkList do
        if ({})[railEditing.checkList[_FORV_12_].spotX] and ({})[railEditing.checkList[_FORV_12_].spotX][railEditing.checkList[_FORV_12_].spotY] then
          setRailEditMode(railEditing.baseX, railEditing.baseY)
          break
        end
      end
    end
  end
  if isElement((playSound3D("files/sounds/railconstruct.mp3", minePosX + _ARG_2_ * 6, minePosY + _ARG_3_ * 6, minePosZ + 0.25))) then
    setElementInterior(playSound3D("files/sounds/railconstruct.mp3", minePosX + _ARG_2_ * 6, minePosY + _ARG_3_ * 6, minePosZ + 0.25), 0)
    setElementDimension(playSound3D("files/sounds/railconstruct.mp3", minePosX + _ARG_2_ * 6, minePosY + _ARG_3_ * 6, minePosZ + 0.25), currentMine)
    setSoundMaxDistance(playSound3D("files/sounds/railconstruct.mp3", minePosX + _ARG_2_ * 6, minePosY + _ARG_3_ * 6, minePosZ + 0.25), 50)
  end
  updateMineInventory("railIrons", _ARG_4_)
  updateMineInventory("railWoods", _ARG_5_)
  forceRefreshTrain = true
end)
;(function(_ARG_0_, _ARG_1_, _ARG_2_)
  addEvent(_ARG_0_, true)
  addEventHandler(_ARG_0_, _ARG_1_, function(_ARG_0_, ...)
    if not loadingMineExit then
      if loadingMineEnter then
        if _ARG_0_ == loadingMineEnter then
          table.insert(mineAssets, {
            eventName = _UPVALUE1_,
            handlerFunction = _UPVALUE2_,
            handlerFunctionParams = {
              ...
            },
            sourceElement = source
          })
        end
      elseif _ARG_0_ == currentMine then
        _UPVALUE2_(_ARG_0_, ...)
      end
    end
  end)
end)("setMineRailSwitch", root, function(_ARG_0_, _ARG_1_, _ARG_2_)
  if _ARG_2_ then
    railSwitchStates[_ARG_1_] = _ARG_2_
  end
  if railSwitches[_ARG_1_] then
    if isElement(railSwitchSound) then
      destroyElement(railSwitchSound)
    end
    railSwitchSound = playSound3D("files/sounds/railswitch.mp3", railSwitches[_ARG_1_].worldX, railSwitches[_ARG_1_].worldY, minePosZ)
    if isElement(railSwitchSound) then
      setElementInterior(railSwitchSound, 0)
      setElementDimension(railSwitchSound, currentMine)
    end
    processRailSwitchRoutes(_ARG_1_)
  end
end)
;(function(_ARG_0_, _ARG_1_, _ARG_2_)
  addEvent(_ARG_0_, true)
  addEventHandler(_ARG_0_, _ARG_1_, function(_ARG_0_, ...)
    if not loadingMineExit then
      if loadingMineEnter then
        if _ARG_0_ == loadingMineEnter then
          table.insert(mineAssets, {
            eventName = _UPVALUE1_,
            handlerFunction = _UPVALUE2_,
            handlerFunctionParams = {
              ...
            },
            sourceElement = source
          })
        end
      elseif _ARG_0_ == currentMine then
        _UPVALUE2_(_ARG_0_, ...)
      end
    end
  end)
end)("mineRailSyncing", root, function(_ARG_0_, _ARG_1_)
  processRailCarSync(_ARG_1_, true)
end)
;(function(_ARG_0_, _ARG_1_, _ARG_2_)
  addEvent(_ARG_0_, true)
  addEventHandler(_ARG_0_, _ARG_1_, function(_ARG_0_, ...)
    if not loadingMineExit then
      if loadingMineEnter then
        if _ARG_0_ == loadingMineEnter then
          table.insert(mineAssets, {
            eventName = _UPVALUE1_,
            handlerFunction = _UPVALUE2_,
            handlerFunctionParams = {
              ...
            },
            sourceElement = source
          })
        end
      elseif _ARG_0_ == currentMine then
        _UPVALUE2_(_ARG_0_, ...)
      end
    end
  end)
end)("mineRailHorn", root, function(_ARG_0_)
  playLocoHorn()
end)
;(function(_ARG_0_, _ARG_1_, _ARG_2_)
  addEvent(_ARG_0_, true)
  addEventHandler(_ARG_0_, _ARG_1_, function(_ARG_0_, ...)
    if not loadingMineExit then
      if loadingMineEnter then
        if _ARG_0_ == loadingMineEnter then
          table.insert(mineAssets, {
            eventName = _UPVALUE1_,
            handlerFunction = _UPVALUE2_,
            handlerFunctionParams = {
              ...
            },
            sourceElement = source
          })
        end
      elseif _ARG_0_ == currentMine then
        _UPVALUE2_(_ARG_0_, ...)
      end
    end
  end)
end)("syncMineLocoPassenger", root, function(_ARG_0_, _ARG_1_)
  processLocoPassenger(source, _ARG_1_)
end)
;(function(_ARG_0_, _ARG_1_, _ARG_2_)
  addEvent(_ARG_0_, true)
  addEventHandler(_ARG_0_, _ARG_1_, function(_ARG_0_, ...)
    if not loadingMineExit then
      if loadingMineEnter then
        if _ARG_0_ == loadingMineEnter then
          table.insert(mineAssets, {
            eventName = _UPVALUE1_,
            handlerFunction = _UPVALUE2_,
            handlerFunctionParams = {
              ...
            },
            sourceElement = source
          })
        end
      elseif _ARG_0_ == currentMine then
        _UPVALUE2_(_ARG_0_, ...)
      end
    end
  end)
end)("syncMineSortingMachineState", root, function(_ARG_0_, _ARG_1_)
  mineMachineData.machineRunning = _ARG_1_
  if _ARG_1_ then
    nextSurge = getTickCount()
  end
  if isElement((playSound3D("files/sounds/machinebutton.mp3", minePosX - 14.7006, minePosY + 6.7456, minePosZ + 1.4667))) then
    setElementInterior(playSound3D("files/sounds/machinebutton.mp3", minePosX - 14.7006, minePosY + 6.7456, minePosZ + 1.4667), 0)
    setElementDimension(playSound3D("files/sounds/machinebutton.mp3", minePosX - 14.7006, minePosY + 6.7456, minePosZ + 1.4667), currentMine)
  end
  if mineAssets == "toggleSortingMachine" then
    exports.see_gui:showTooltip("Válogatógép " .. (mineMachineData.machineRunning and "ki" or "be") .. "kapcsolása")
  end
end)
;(function(_ARG_0_, _ARG_1_, _ARG_2_)
  addEvent(_ARG_0_, true)
  addEventHandler(_ARG_0_, _ARG_1_, function(_ARG_0_, ...)
    if not loadingMineExit then
      if loadingMineEnter then
        if _ARG_0_ == loadingMineEnter then
          table.insert(mineAssets, {
            eventName = _UPVALUE1_,
            handlerFunction = _UPVALUE2_,
            handlerFunctionParams = {
              ...
            },
            sourceElement = source
          })
        end
      elseif _ARG_0_ == currentMine then
        _UPVALUE2_(_ARG_0_, ...)
      end
    end
  end)
end)("updateMineInventory", root, function(_ARG_0_, _ARG_1_, _ARG_2_)
  updateMineInventory(_ARG_1_, _ARG_2_)
  if _ARG_1_ == "dieselLoco" or _ARG_1_ == "subCartNum" then
    initMineTrain(currentMineInventory.dieselLoco, currentMineInventory.subCartNum or 0)
    if currentMineInventory.dieselLoco then
      exports.see_controls:toggleControl({
        "fire",
        "crouch",
        "aim_weapon",
        "jump",
        "jog"
      }, true, "minecartPush")
    end
  elseif _ARG_1_ == "tankOutside" then
    if _ARG_2_ then
      if currentMineInventory.fuelTankObject then
        if isElement(currentMineInventory.fuelTankObject) then
          destroyElement(currentMineInventory.fuelTankObject)
        end
        currentMineInventory.fuelTankObject = nil
      end
    elseif not currentMineInventory.fuelTankObject then
      currentMineInventory.fuelTankObject = createObject(modelIds.v4_mine_tank, minePosX - 32.7956, minePosY + 2.3363, minePosZ, 0, 0, -5)
      if isElement(currentMineInventory.fuelTankObject) then
        setElementInterior(currentMineInventory.fuelTankObject, 0)
        setElementDimension(currentMineInventory.fuelTankObject, currentMine)
      end
    end
  end
  shouldRefreshUrmaMotoDevice = true
end)
function updateMineInventory(_ARG_0_, _ARG_1_)
  currentMineInventory[_ARG_0_] = _ARG_1_
  if _ARG_0_ == "railIrons" then
    for _FORV_6_ = math.min(#railIronOffsets, math.ceil(_ARG_1_ / railIronStack)) + 1, #mineAssets do
      if isElement(mineAssets[_FORV_6_]) then
        destroyElement(mineAssets[_FORV_6_])
      end
      mineAssets[_FORV_6_] = nil
    end
    for _FORV_6_ = 1, math.min(#railIronOffsets, math.ceil(_ARG_1_ / railIronStack)) do
      if not mineAssets[_FORV_6_] then
        if isElement((createObject(modelIds.v4_mine_cargo_rail, mineHqX + railIronOffsets[_FORV_6_][1], mineHqY + railIronOffsets[_FORV_6_][2], mineHqZ + railIronOffsets[_FORV_6_][3], railIronOffsets[_FORV_6_][4], railIronOffsets[_FORV_6_][5], railIronOffsets[_FORV_6_][6]))) then
          setElementInterior(createObject(modelIds.v4_mine_cargo_rail, mineHqX + railIronOffsets[_FORV_6_][1], mineHqY + railIronOffsets[_FORV_6_][2], mineHqZ + railIronOffsets[_FORV_6_][3], railIronOffsets[_FORV_6_][4], railIronOffsets[_FORV_6_][5], railIronOffsets[_FORV_6_][6]), 0)
          setElementDimension(createObject(modelIds.v4_mine_cargo_rail, mineHqX + railIronOffsets[_FORV_6_][1], mineHqY + railIronOffsets[_FORV_6_][2], mineHqZ + railIronOffsets[_FORV_6_][3], railIronOffsets[_FORV_6_][4], railIronOffsets[_FORV_6_][5], railIronOffsets[_FORV_6_][6]), currentMine)
        end
        mineAssets[_FORV_6_] = createObject(modelIds.v4_mine_cargo_rail, mineHqX + railIronOffsets[_FORV_6_][1], mineHqY + railIronOffsets[_FORV_6_][2], mineHqZ + railIronOffsets[_FORV_6_][3], railIronOffsets[_FORV_6_][4], railIronOffsets[_FORV_6_][5], railIronOffsets[_FORV_6_][6])
      end
    end
  elseif _ARG_0_ == "railWoods" then
    for _FORV_6_ = math.min(#railWoodOffsets, math.ceil(_ARG_1_ / railWoodStack)) + 1, #_UPVALUE1_ do
      if isElement(_UPVALUE1_[_FORV_6_]) then
        destroyElement(_UPVALUE1_[_FORV_6_])
      end
      _UPVALUE1_[_FORV_6_] = nil
    end
    for _FORV_6_ = 1, math.min(#railWoodOffsets, math.ceil(_ARG_1_ / railWoodStack)) do
      if not _UPVALUE1_[_FORV_6_] then
        if isElement((createObject(modelIds.v4_mine_cargo_wood, mineHqX + railWoodOffsets[_FORV_6_][1], mineHqY + railWoodOffsets[_FORV_6_][2], mineHqZ + railWoodOffsets[_FORV_6_][3], railWoodOffsets[_FORV_6_][4], railWoodOffsets[_FORV_6_][5], railWoodOffsets[_FORV_6_][6]))) then
          setElementInterior(createObject(modelIds.v4_mine_cargo_wood, mineHqX + railWoodOffsets[_FORV_6_][1], mineHqY + railWoodOffsets[_FORV_6_][2], mineHqZ + railWoodOffsets[_FORV_6_][3], railWoodOffsets[_FORV_6_][4], railWoodOffsets[_FORV_6_][5], railWoodOffsets[_FORV_6_][6]), 0)
          setElementDimension(createObject(modelIds.v4_mine_cargo_wood, mineHqX + railWoodOffsets[_FORV_6_][1], mineHqY + railWoodOffsets[_FORV_6_][2], mineHqZ + railWoodOffsets[_FORV_6_][3], railWoodOffsets[_FORV_6_][4], railWoodOffsets[_FORV_6_][5], railWoodOffsets[_FORV_6_][6]), currentMine)
        end
        _UPVALUE1_[_FORV_6_] = createObject(modelIds.v4_mine_cargo_wood, mineHqX + railWoodOffsets[_FORV_6_][1], mineHqY + railWoodOffsets[_FORV_6_][2], mineHqZ + railWoodOffsets[_FORV_6_][3], railWoodOffsets[_FORV_6_][4], railWoodOffsets[_FORV_6_][5], railWoodOffsets[_FORV_6_][6])
      end
    end
  elseif _ARG_0_ == "mineLamps" then
    for _FORV_6_ = math.min(#mineLampOffsets, math.ceil(_ARG_1_ / mineLampStack)) + 1, #_UPVALUE2_ do
      if isElement(_UPVALUE2_[_FORV_6_]) then
        destroyElement(_UPVALUE2_[_FORV_6_])
      end
      _UPVALUE2_[_FORV_6_] = nil
    end
    for _FORV_6_ = 1, math.min(#mineLampOffsets, math.ceil(_ARG_1_ / mineLampStack)) do
      if not _UPVALUE2_[_FORV_6_] then
        if isElement((createObject(modelIds.v4_mine_cargo_lamp, mineHqX + mineLampOffsets[_FORV_6_][1], mineHqY + mineLampOffsets[_FORV_6_][2], mineHqZ + mineLampOffsets[_FORV_6_][3], mineLampOffsets[_FORV_6_][4], mineLampOffsets[_FORV_6_][5], mineLampOffsets[_FORV_6_][6]))) then
          setElementInterior(createObject(modelIds.v4_mine_cargo_lamp, mineHqX + mineLampOffsets[_FORV_6_][1], mineHqY + mineLampOffsets[_FORV_6_][2], mineHqZ + mineLampOffsets[_FORV_6_][3], mineLampOffsets[_FORV_6_][4], mineLampOffsets[_FORV_6_][5], mineLampOffsets[_FORV_6_][6]), 0)
          setElementDimension(createObject(modelIds.v4_mine_cargo_lamp, mineHqX + mineLampOffsets[_FORV_6_][1], mineHqY + mineLampOffsets[_FORV_6_][2], mineHqZ + mineLampOffsets[_FORV_6_][3], mineLampOffsets[_FORV_6_][4], mineLampOffsets[_FORV_6_][5], mineLampOffsets[_FORV_6_][6]), currentMine)
        end
        _UPVALUE2_[_FORV_6_] = createObject(modelIds.v4_mine_cargo_lamp, mineHqX + mineLampOffsets[_FORV_6_][1], mineHqY + mineLampOffsets[_FORV_6_][2], mineHqZ + mineLampOffsets[_FORV_6_][3], mineLampOffsets[_FORV_6_][4], mineLampOffsets[_FORV_6_][5], mineLampOffsets[_FORV_6_][6])
      end
    end
  end
  revalidateTabletOrder()
end
;(function(_ARG_0_, _ARG_1_, _ARG_2_)
  addEvent(_ARG_0_, true)
  addEventHandler(_ARG_0_, _ARG_1_, function(_ARG_0_, ...)
    if not loadingMineExit then
      if loadingMineEnter then
        if _ARG_0_ == loadingMineEnter then
          table.insert(mineAssets, {
            eventName = _UPVALUE1_,
            handlerFunction = _UPVALUE2_,
            handlerFunctionParams = {
              ...
            },
            sourceElement = source
          })
        end
      elseif _ARG_0_ == currentMine then
        _UPVALUE2_(_ARG_0_, ...)
      end
    end
  end)
end)("handleMineHit", root, function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_, _ARG_5_)
  doHandleMineHit(_ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  doHandleMineHitCollision(_ARG_1_, _ARG_2_, _ARG_5_)
  doHandleMineHitAfter(_ARG_1_)
end)
;(function(_ARG_0_, _ARG_1_, _ARG_2_)
  addEvent(_ARG_0_, true)
  addEventHandler(_ARG_0_, _ARG_1_, function(_ARG_0_, ...)
    if not loadingMineExit then
      if loadingMineEnter then
        if _ARG_0_ == loadingMineEnter then
          table.insert(mineAssets, {
            eventName = _UPVALUE1_,
            handlerFunction = _UPVALUE2_,
            handlerFunctionParams = {
              ...
            },
            sourceElement = source
          })
        end
      elseif _ARG_0_ == currentMine then
        _UPVALUE2_(_ARG_0_, ...)
      end
    end
  end)
end)("handleMineDetonate", root, function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if _ARG_2_ then
    doHandleMineHit(_ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_, true)
  else
    for _FORV_9_ = 1, wallBlockCount do
      if not doHandleMineHitCollision(_ARG_1_, _FORV_9_) then
        break
      end
    end
    if false then
      doHandleMineHitAfter(_ARG_1_)
    end
  end
end)
;(function(_ARG_0_, _ARG_1_, _ARG_2_)
  addEvent(_ARG_0_, true)
  addEventHandler(_ARG_0_, _ARG_1_, function(_ARG_0_, ...)
    if not loadingMineExit then
      if loadingMineEnter then
        if _ARG_0_ == loadingMineEnter then
          table.insert(mineAssets, {
            eventName = _UPVALUE1_,
            handlerFunction = _UPVALUE2_,
            handlerFunctionParams = {
              ...
            },
            sourceElement = source
          })
        end
      elseif _ARG_0_ == currentMine then
        _UPVALUE2_(_ARG_0_, ...)
      end
    end
  end)
end)("closeMergedMineShafts", root, function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_, _ARG_5_)
  if _ARG_5_ then
    createJunction(_ARG_3_, _ARG_4_, _ARG_5_)
  end
  if _ARG_2_ then
    closeMergedShaft(_ARG_2_)
  end
  closeMergedShaft(_ARG_1_)
end)
function closeMergedShaft(_ARG_0_)
  if mineAssets[_ARG_0_] then
    for _FORV_4_ in pairs(mineAssets[_ARG_0_]) do
      if isElement(mineAssets[_ARG_0_][_FORV_4_][5]) then
        destroyElement(mineAssets[_ARG_0_][_FORV_4_][5])
      end
    end
  end
  if _UPVALUE1_[_ARG_0_] then
    for _FORV_4_ = 1, wallBlockCount do
      if isElement(_UPVALUE1_[_ARG_0_][_FORV_4_]) then
        destroyElement(_UPVALUE1_[_ARG_0_][_FORV_4_])
      end
    end
  end
  if isElement(_UPVALUE2_[_ARG_0_]) then
    destroyElement(_UPVALUE2_[_ARG_0_])
  end
  if _UPVALUE3_[_ARG_0_] then
    poolFreeModel(_UPVALUE3_[_ARG_0_])
  end
  if isElement(_UPVALUE4_[_ARG_0_]) then
    destroyElement(_UPVALUE4_[_ARG_0_])
  end
  if _UPVALUE5_[_ARG_0_] then
    rngDelete(_UPVALUE5_[_ARG_0_])
  end
  setOpenShaftAt(_UPVALUE6_[_ARG_0_][1] + _UPVALUE7_[_ARG_0_][3] * (_UPVALUE8_[_ARG_0_] - 1), _UPVALUE6_[_ARG_0_][2] + _UPVALUE7_[_ARG_0_][4] * (_UPVALUE8_[_ARG_0_] - 1))
  _UPVALUE2_[_ARG_0_] = nil
  _UPVALUE3_[_ARG_0_] = nil
  _UPVALUE4_[_ARG_0_] = nil
  _UPVALUE9_[_ARG_0_] = nil
  _UPVALUE10_[_ARG_0_] = nil
  _UPVALUE1_[_ARG_0_] = nil
  _UPVALUE11_[_ARG_0_] = nil
  mineAssets[_ARG_0_] = nil
  _UPVALUE12_[_ARG_0_] = nil
  _UPVALUE13_[_ARG_0_] = nil
  _UPVALUE14_[_ARG_0_] = nil
  _UPVALUE5_[_ARG_0_] = nil
  removeFromDffExportQueue(_ARG_0_)
end
function removeFromDffExportQueue(_ARG_0_)
  for _FORV_4_ = #mineAssets, 1, -1 do
    if mineAssets[_FORV_4_].shaftId == _ARG_0_ then
      if mineAssets[_FORV_4_].modelId then
        poolFreeModel(mineAssets[_FORV_4_].modelId)
      end
      if isElement(mineAssets[_FORV_4_].dffData) then
        destroyElement(mineAssets[_FORV_4_].dffData)
      end
      if isElement(mineAssets[_FORV_4_].objectElement) then
        destroyElement(mineAssets[_FORV_4_].objectElement)
      end
      table.remove(mineAssets, _FORV_4_)
    end
  end
end
;(function(_ARG_0_, _ARG_1_, _ARG_2_)
  addEvent(_ARG_0_, true)
  addEventHandler(_ARG_0_, _ARG_1_, function(_ARG_0_, ...)
    if not loadingMineExit then
      if loadingMineEnter then
        if _ARG_0_ == loadingMineEnter then
          table.insert(mineAssets, {
            eventName = _UPVALUE1_,
            handlerFunction = _UPVALUE2_,
            handlerFunctionParams = {
              ...
            },
            sourceElement = source
          })
        end
      elseif _ARG_0_ == currentMine then
        _UPVALUE2_(_ARG_0_, ...)
      end
    end
  end)
end)("gotExtendedMineShaft", root, function(_ARG_0_, _ARG_1_, _ARG_2_)
  if mineAssets[_ARG_1_] then
    setOpenShaftAt(_UPVALUE1_[_ARG_1_][1] + _UPVALUE2_[_ARG_1_][3] * (_UPVALUE3_[_ARG_1_] - 1), _UPVALUE1_[_ARG_1_][2] + _UPVALUE2_[_ARG_1_][4] * (_UPVALUE3_[_ARG_1_] - 1))
    setOpenShaftAt(_UPVALUE1_[_ARG_1_][1] + _UPVALUE2_[_ARG_1_][3] * (_UPVALUE3_[_ARG_1_] - 1) + _UPVALUE2_[_ARG_1_][3], _UPVALUE1_[_ARG_1_][2] + _UPVALUE2_[_ARG_1_][4] * (_UPVALUE3_[_ARG_1_] - 1) + _UPVALUE2_[_ARG_1_][4], _ARG_1_)
    if _UPVALUE2_[_ARG_1_][1] then
      createTunnelObject(mineAssets[_ARG_1_], _UPVALUE1_[_ARG_1_][1] + _UPVALUE2_[_ARG_1_][3] * (_UPVALUE3_[_ARG_1_] - 1) + _UPVALUE2_[_ARG_1_][3], _UPVALUE1_[_ARG_1_][2] + _UPVALUE2_[_ARG_1_][4] * (_UPVALUE3_[_ARG_1_] - 1) + _UPVALUE2_[_ARG_1_][4], _UPVALUE2_[_ARG_1_][1])
    end
    _UPVALUE3_[_ARG_1_] = _UPVALUE3_[_ARG_1_] + 1
    if canExtendShaftAt(_UPVALUE1_[_ARG_1_][1] + _UPVALUE2_[_ARG_1_][3] * (_UPVALUE3_[_ARG_1_] - 1) + _UPVALUE2_[_ARG_1_][3], _UPVALUE1_[_ARG_1_][2] + _UPVALUE2_[_ARG_1_][4] * (_UPVALUE3_[_ARG_1_] - 1) + _UPVALUE2_[_ARG_1_][4]) then
      setExtendableShaft(_UPVALUE1_[_ARG_1_][1] + _UPVALUE2_[_ARG_1_][3] * (_UPVALUE3_[_ARG_1_] - 1) + _UPVALUE2_[_ARG_1_][3], _UPVALUE1_[_ARG_1_][2] + _UPVALUE2_[_ARG_1_][4] * (_UPVALUE3_[_ARG_1_] - 1) + _UPVALUE2_[_ARG_1_][4], _ARG_1_, _UPVALUE3_[_ARG_1_])
    end
    if not _UPVALUE4_[_ARG_1_] then
      _UPVALUE4_[_ARG_1_] = {}
    end
    for _FORV_11_ = 1, #_ARG_2_ do
      table.insert(_UPVALUE4_[_ARG_1_], _ARG_2_[_FORV_11_])
    end
  end
end)
;(function(_ARG_0_, _ARG_1_, _ARG_2_)
  addEvent(_ARG_0_, true)
  addEventHandler(_ARG_0_, _ARG_1_, function(_ARG_0_, ...)
    if not loadingMineExit then
      if loadingMineEnter then
        if _ARG_0_ == loadingMineEnter then
          table.insert(mineAssets, {
            eventName = _UPVALUE1_,
            handlerFunction = _UPVALUE2_,
            handlerFunctionParams = {
              ...
            },
            sourceElement = source
          })
        end
      elseif _ARG_0_ == currentMine then
        _UPVALUE2_(_ARG_0_, ...)
      end
    end
  end)
end)("gotNewMineShaft", root, function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_, _ARG_5_, _ARG_6_, _ARG_7_, _ARG_8_, _ARG_9_, _ARG_10_, _ARG_11_, _ARG_12_, _ARG_13_)
  if _ARG_4_ then
    mineAssets[_ARG_4_] = nil
  end
  if _ARG_7_ then
    mineAssets[_ARG_7_] = nil
  end
  if _ARG_8_ then
    mineAssets[_ARG_8_] = nil
  end
  table.insert(_UPVALUE1_, {
    currentStage = 1,
    shaftId = _ARG_4_,
    shaftX = _ARG_1_,
    shaftY = _ARG_2_,
    shaftDeg = _ARG_3_,
    shaftRad = prad(_ARG_3_),
    shaftCos = pcos((prad(_ARG_3_))),
    shaftSin = psin((prad(_ARG_3_))),
    mainId = _ARG_7_,
    sideId = _ARG_8_,
    newShaftTunnels = _ARG_5_,
    newShaftSide = _ARG_6_ and "left" or "right",
    newShaftOres = _ARG_11_,
    newRandomSeed = _ARG_10_,
    newJunctionType = _ARG_9_,
    shaftToClose = _ARG_12_,
    shaftWallMoveForward = _ARG_13_
  })
  setExtendableShaft(_ARG_1_, _ARG_2_, false)
end)
function processShaftJobQueue()
  if mineAssets[1].currentStage == 1 then
    if mineAssets[1].shaftId and mineAssets[1].mainId then
      _UPVALUE1_[mineAssets[1].mainId] = _UPVALUE1_[mineAssets[1].shaftId]
      _UPVALUE2_[mineAssets[1].mainId] = nil
      removeFromDffExportQueue(mineAssets[1].shaftId)
      _UPVALUE3_[mineAssets[1].mainId] = _UPVALUE3_[mineAssets[1].shaftId]
      _UPVALUE4_[mineAssets[1].mainId] = _UPVALUE4_[mineAssets[1].shaftId]
      _UPVALUE5_[mineAssets[1].mainId] = _UPVALUE5_[mineAssets[1].shaftId]
      _UPVALUE6_[mineAssets[1].mainId] = _UPVALUE6_[mineAssets[1].shaftId]
      _UPVALUE7_[mineAssets[1].mainId] = _UPVALUE7_[mineAssets[1].shaftId]
      _UPVALUE8_[mineAssets[1].mainId] = _UPVALUE8_[mineAssets[1].shaftId]
      _UPVALUE9_[mineAssets[1].mainId] = _UPVALUE9_[mineAssets[1].shaftId]
      if mineAssets[1].shaftWallMoveForward then
        if _UPVALUE10_[mineAssets[1].shaftId] then
          for _FORV_13_ in pairs(_UPVALUE10_[mineAssets[1].shaftId]) do
            checkCoroutineTime()
            if isElement(_UPVALUE10_[mineAssets[1].shaftId][_FORV_13_][5]) then
              destroyElement(_UPVALUE10_[mineAssets[1].shaftId][_FORV_13_][5])
            end
            _UPVALUE10_[mineAssets[1].shaftId][_FORV_13_] = nil
          end
          _UPVALUE10_[mineAssets[1].shaftId] = {}
        end
        _UPVALUE11_[mineAssets[1].mainId] = 0
        for _FORV_13_ = 1, wallBlockCount do
          _UPVALUE9_[mineAssets[1].mainId][_FORV_13_] = 0
        end
      else
        if _UPVALUE11_[mineAssets[1].shaftId] then
          _UPVALUE11_[mineAssets[1].mainId] = _UPVALUE11_[mineAssets[1].shaftId] - mineAssets[1].newShaftTunnels * 6
        end
        _UPVALUE10_[mineAssets[1].mainId] = _UPVALUE10_[mineAssets[1].shaftId]
      end
      _UPVALUE12_[mineAssets[1].mainId] = _UPVALUE12_[mineAssets[1].shaftId]
      _UPVALUE1_[mineAssets[1].shaftId] = nil
      _UPVALUE8_[mineAssets[1].shaftId] = nil
      _UPVALUE2_[mineAssets[1].shaftId] = nil
      _UPVALUE11_[mineAssets[1].shaftId] = nil
      _UPVALUE9_[mineAssets[1].shaftId] = nil
      _UPVALUE3_[mineAssets[1].shaftId] = nil
      _UPVALUE4_[mineAssets[1].shaftId] = nil
      _UPVALUE10_[mineAssets[1].shaftId] = nil
      _UPVALUE12_[mineAssets[1].shaftId] = nil
      _UPVALUE6_[mineAssets[1].shaftId] = nil
      _UPVALUE7_[mineAssets[1].shaftId] = nil
      _UPVALUE13_[mineAssets[1].mainId] = _UPVALUE13_[mineAssets[1].shaftId]
      _UPVALUE14_[mineAssets[1].mainId] = {
        mineAssets[1].shaftX + pcos((prad(mineAssets[1].shaftDeg))),
        mineAssets[1].shaftY + psin((prad(mineAssets[1].shaftDeg)))
      }
      _UPVALUE15_[mineAssets[1].mainId] = {
        mineAssets[1].shaftDeg,
        prad(mineAssets[1].shaftDeg),
        pcos((prad(mineAssets[1].shaftDeg))),
        (psin((prad(mineAssets[1].shaftDeg))))
      }
      _UPVALUE16_[mineAssets[1].mainId] = math.max(1, _UPVALUE16_[mineAssets[1].shaftId] - mineAssets[1].newShaftTunnels)
      setOpenShaftAt(mineAssets[1].shaftX, mineAssets[1].shaftY)
      if 0 >= _UPVALUE16_[mineAssets[1].shaftId] - mineAssets[1].newShaftTunnels then
        createTunnelObject(_UPVALUE13_[mineAssets[1].mainId] or rngCreate(0), mineAssets[1].shaftX + pcos((prad(mineAssets[1].shaftDeg))), mineAssets[1].shaftY + psin((prad(mineAssets[1].shaftDeg))), mineAssets[1].shaftDeg)
        if true then
          rngDelete(_UPVALUE13_[mineAssets[1].mainId] or rngCreate(0))
        end
        if canExtendShaftAt(mineAssets[1].shaftX, mineAssets[1].shaftY) then
          setExtendableShaft(mineAssets[1].shaftX, mineAssets[1].shaftY, mineAssets[1].mainId, 1)
        end
      end
      for _FORV_13_ = 1, _UPVALUE16_[mineAssets[1].mainId] do
        if canExtendShaftAt(mineAssets[1].shaftX + pcos((prad(mineAssets[1].shaftDeg))), mineAssets[1].shaftY + psin((prad(mineAssets[1].shaftDeg)))) then
          setExtendableShaft(mineAssets[1].shaftX + pcos((prad(mineAssets[1].shaftDeg))), mineAssets[1].shaftY + psin((prad(mineAssets[1].shaftDeg))), mineAssets[1].mainId, _FORV_13_)
        end
      end
      _UPVALUE16_[mineAssets[1].shaftId] = mineAssets[1].newShaftTunnels - 1
      _UPVALUE13_[mineAssets[1].shaftId] = nil
    end
  elseif mineAssets[1].currentStage == 2 then
    if mineAssets[1].newRandomSeed then
      if mineAssets[1].newShaftSide == "left" then
      elseif mineAssets[1].newShaftSide == "right" then
      end
      mineAssets[1].shaftSin, mineAssets[1].shaftCos = psin((prad(((mineAssets[1].shaftDeg + 90) % 360 - 90) % 360))), pcos((prad(((mineAssets[1].shaftDeg + 90) % 360 - 90) % 360)))
      _UPVALUE9_[mineAssets[1].sideId] = {}
      _UPVALUE11_[mineAssets[1].sideId] = 0
      for _FORV_14_ = 1, wallBlockCount do
        _UPVALUE9_[mineAssets[1].sideId][_FORV_14_] = 0
      end
      createShaft(mineAssets[1].sideId, mineAssets[1].shaftX - mineAssets[1].shaftSin + mineAssets[1].shaftSin, mineAssets[1].shaftY + mineAssets[1].shaftCos - mineAssets[1].shaftCos, 1, ((mineAssets[1].shaftDeg + 90) % 360 - 90) % 360, pcos((prad(((mineAssets[1].shaftDeg + 90) % 360 - 90) % 360))), psin((prad(((mineAssets[1].shaftDeg + 90) % 360 - 90) % 360))), (rngCreate(mineAssets[1].newRandomSeed)))
      _UPVALUE14_[mineAssets[1].sideId] = {
        mineAssets[1].shaftX - mineAssets[1].shaftSin + mineAssets[1].shaftSin,
        mineAssets[1].shaftY + mineAssets[1].shaftCos - mineAssets[1].shaftCos
      }
      _UPVALUE16_[mineAssets[1].sideId] = 1
      _UPVALUE15_[mineAssets[1].sideId] = {
        ((mineAssets[1].shaftDeg + 90) % 360 - 90) % 360,
        prad(((mineAssets[1].shaftDeg + 90) % 360 - 90) % 360),
        pcos((prad(((mineAssets[1].shaftDeg + 90) % 360 - 90) % 360))),
        (psin((prad(((mineAssets[1].shaftDeg + 90) % 360 - 90) % 360))))
      }
      _UPVALUE13_[mineAssets[1].sideId] = rngCreate(mineAssets[1].newRandomSeed)
      checkCoroutineTime()
    else
      mineAssets[1].currentStage = 5
      if _UPVALUE9_[mineAssets[1].mainId] then
        setOpenShaftAt(mineAssets[1].shaftX - mineAssets[1].shaftSin + mineAssets[1].shaftSin + pcos(prad(mineAssets[1].shaftDeg)), mineAssets[1].shaftY + mineAssets[1].shaftCos - mineAssets[1].shaftCos + psin(prad(mineAssets[1].shaftDeg)), mineAssets[1].mainId)
      end
    end
  elseif mineAssets[1].currentStage == 3 then
    generateOpenShaftDff(mineAssets[1].sideId, true, true)
    _UPVALUE1_[mineAssets[1].sideId] = true
    _UPVALUE2_[mineAssets[1].sideId] = nil
    checkCoroutineTime()
  elseif mineAssets[1].currentStage == 4 then
    _UPVALUE3_[mineAssets[1].sideId] = {}
    for _FORV_7_ = 1, wallBlockCount do
      if isElement((createObject(modelIds.v4_mine_wall, getShaftBlockPosition(mineAssets[1].sideId, _FORV_7_)))) then
        setObjectScale(createObject(modelIds.v4_mine_wall, getShaftBlockPosition(mineAssets[1].sideId, _FORV_7_)), 0)
        setElementAlpha(createObject(modelIds.v4_mine_wall, getShaftBlockPosition(mineAssets[1].sideId, _FORV_7_)), 0)
        setElementInterior(createObject(modelIds.v4_mine_wall, getShaftBlockPosition(mineAssets[1].sideId, _FORV_7_)), 0)
        setElementDimension(createObject(modelIds.v4_mine_wall, getShaftBlockPosition(mineAssets[1].sideId, _FORV_7_)), currentMine)
        removeShaderFromObject((createObject(modelIds.v4_mine_wall, getShaftBlockPosition(mineAssets[1].sideId, _FORV_7_))))
        checkCoroutineTime()
      end
      _UPVALUE3_[mineAssets[1].sideId][_FORV_7_] = createObject(modelIds.v4_mine_wall, getShaftBlockPosition(mineAssets[1].sideId, _FORV_7_))
    end
    _FOR_()
  elseif mineAssets[1].currentStage == 5 then
    if not _UPVALUE10_[mineAssets[1].sideId] then
      _UPVALUE10_[mineAssets[1].sideId] = {}
    end
    for _FORV_7_ = 1, #mineAssets[1].newShaftOres do
      table.insert(_UPVALUE10_[mineAssets[1].sideId], mineAssets[1].newShaftOres[_FORV_7_])
    end
  elseif mineAssets[1].currentStage == 6 then
    deleteTunnelObject(mineAssets[1].shaftX, mineAssets[1].shaftY)
    if not mineAssets[1].sideId and mineAssets[1].mainId and mineAssets[1].newShaftOres then
      if not _UPVALUE10_[mineAssets[1].mainId] then
        _UPVALUE10_[mineAssets[1].mainId] = {}
      end
      for _FORV_9_ = 1, #mineAssets[1].newShaftOres do
        table.insert(_UPVALUE10_[mineAssets[1].mainId], mineAssets[1].newShaftOres[_FORV_9_])
      end
    end
    if _FOR_ then
      generateOpenShaftDff(mineAssets[1].mainId, true, true)
      _UPVALUE1_[mineAssets[1].mainId] = true
      _UPVALUE2_[mineAssets[1].mainId] = nil
      for _FORV_9_ = 1, wallBlockCount do
        if isElement(_UPVALUE3_[mineAssets[1].mainId][_FORV_9_]) then
          setElementPosition(_UPVALUE3_[mineAssets[1].mainId][_FORV_9_], getShaftBlockPosition(mineAssets[1].mainId, _FORV_9_))
        end
        checkCoroutineTime()
      end
    end
    if mineAssets[1].shaftId then
      if mineAssets[1].newShaftSide == "left" then
        createJunction(mineAssets[1].shaftX, mineAssets[1].shaftY, mineAssets[1].newJunctionType, (mineAssets[1].shaftDeg + 180) % 360)
      else
        createJunction(mineAssets[1].shaftX, mineAssets[1].shaftY, mineAssets[1].newJunctionType, mineAssets[1].shaftDeg)
      end
    else
      mineAssets[1].currentStage = 7
      collectgarbage()
      return
    end
    if mineAssets[1].shaftId then
      _UPVALUE17_[mineAssets[1].shaftId] = true
    end
    if mineAssets[1].mainId then
      _UPVALUE17_[mineAssets[1].mainId] = true
    end
    if mineAssets[1].sideId then
      _UPVALUE17_[mineAssets[1].sideId] = true
    end
    if mineAssets[1].shaftToClose then
      closeMergedShaft(mineAssets[1].shaftToClose)
    end
    table.remove(mineAssets, 1)
    return
  elseif mineAssets[1].currentStage == 7 then
    deleteTunnelObject(mineAssets[1].shaftX, mineAssets[1].shaftY)
    if mineAssets[1].shaftId then
      _UPVALUE17_[mineAssets[1].shaftId] = true
    end
    if mineAssets[1].mainId then
      _UPVALUE17_[mineAssets[1].mainId] = true
    end
    if mineAssets[1].sideId then
      _UPVALUE17_[mineAssets[1].sideId] = true
    end
    createJunction(mineAssets[1].shaftX, mineAssets[1].shaftY, mineAssets[1].newJunctionType)
    if mineAssets[1].shaftToClose then
      closeMergedShaft(mineAssets[1].shaftToClose)
    end
    table.remove(mineAssets, 1)
    return
  end
  mineAssets[1].currentStage = mineAssets[1].currentStage + 1
end
function getShaftBlockPosition(_ARG_0_, _ARG_1_)
  if mineAssets[_ARG_1_] and _UPVALUE1_[_ARG_0_] and _UPVALUE2_[_ARG_0_] then
    return _UPVALUE1_[_ARG_0_][1] + (mineAssets[_ARG_1_][1] * wallMeshWidth - wallMeshWidth / 2) * _UPVALUE2_[_ARG_0_][4] + _UPVALUE3_[_ARG_0_][_ARG_1_] * _UPVALUE2_[_ARG_0_][3], _UPVALUE1_[_ARG_0_][2] - (mineAssets[_ARG_1_][1] * wallMeshWidth - wallMeshWidth / 2) * _UPVALUE2_[_ARG_0_][3] + _UPVALUE3_[_ARG_0_][_ARG_1_] * _UPVALUE2_[_ARG_0_][4], minePosZ + mineAssets[_ARG_1_][2] * wallMeshHeight
  end
end
;(function(_ARG_0_, _ARG_1_, _ARG_2_)
  addEvent(_ARG_0_, true)
  addEventHandler(_ARG_0_, _ARG_1_, function(_ARG_0_, ...)
    if not loadingMineExit then
      if loadingMineEnter then
        if _ARG_0_ == loadingMineEnter then
          table.insert(mineAssets, {
            eventName = _UPVALUE1_,
            handlerFunction = _UPVALUE2_,
            handlerFunctionParams = {
              ...
            },
            sourceElement = source
          })
        end
      elseif _ARG_0_ == currentMine then
        _UPVALUE2_(_ARG_0_, ...)
      end
    end
  end)
end)("syncFixOreDelete", root, function(_ARG_0_, _ARG_1_)
  for _FORV_5_ = 1, #_ARG_1_ do
    if mineAssets[_ARG_1_[_FORV_5_]] then
      detachFixOre(_ARG_1_[_FORV_5_])
      removeFixOreSync(_ARG_1_[_FORV_5_])
      if isElement(mineAssets[_ARG_1_[_FORV_5_]][6]) then
        destroyElement(mineAssets[_ARG_1_[_FORV_5_]][6])
      end
    end
    mineAssets[_ARG_1_[_FORV_5_]] = nil
  end
end)
;(function(_ARG_0_, _ARG_1_, _ARG_2_)
  addEvent(_ARG_0_, true)
  addEventHandler(_ARG_0_, _ARG_1_, function(_ARG_0_, ...)
    if not loadingMineExit then
      if loadingMineEnter then
        if _ARG_0_ == loadingMineEnter then
          table.insert(mineAssets, {
            eventName = _UPVALUE1_,
            handlerFunction = _UPVALUE2_,
            handlerFunctionParams = {
              ...
            },
            sourceElement = source
          })
        end
      elseif _ARG_0_ == currentMine then
        _UPVALUE2_(_ARG_0_, ...)
      end
    end
  end)
end)("syncFixOreState", root, function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_, _ARG_5_, _ARG_6_, _ARG_7_)
  detachFixOre(_ARG_1_)
  if _ARG_2_ == "player" then
    attachFixOreToPlayer(_ARG_1_, source)
  elseif _ARG_2_ == "ground" then
    if mineAssets[_ARG_1_] then
      setFixOrePosition(_ARG_1_, _ARG_3_, _ARG_4_, minePosZ)
      if isElement((playSound3D("files/sounds/orefall" .. math.random(1, 4) .. ".wav", _ARG_3_, _ARG_4_, minePosZ))) then
        setElementInterior(playSound3D("files/sounds/orefall" .. math.random(1, 4) .. ".wav", _ARG_3_, _ARG_4_, minePosZ), 0)
        setElementDimension(playSound3D("files/sounds/orefall" .. math.random(1, 4) .. ".wav", _ARG_3_, _ARG_4_, minePosZ), currentMine)
        attachElements(playSound3D("files/sounds/orefall" .. math.random(1, 4) .. ".wav", _ARG_3_, _ARG_4_, minePosZ), mineAssets[_ARG_1_][6])
      end
      spawnSmokeExSm(_ARG_3_, _ARG_4_, minePosZ)
    end
  elseif _ARG_2_ == "cart" then
    if mineAssets[_ARG_1_] then
      attachFixOreToCart(_ARG_1_, _ARG_5_, _ARG_6_)
      if isElement((playSound3D("files/sounds/orefall" .. math.random(1, 4) .. ".wav", getElementPosition(mineAssets[_ARG_1_][6])))) then
        setElementInterior(playSound3D("files/sounds/orefall" .. math.random(1, 4) .. ".wav", getElementPosition(mineAssets[_ARG_1_][6])), 0)
        setElementDimension(playSound3D("files/sounds/orefall" .. math.random(1, 4) .. ".wav", getElementPosition(mineAssets[_ARG_1_][6])), currentMine)
        attachElements(playSound3D("files/sounds/orefall" .. math.random(1, 4) .. ".wav", getElementPosition(mineAssets[_ARG_1_][6])), mineAssets[_ARG_1_][6])
      end
      spawnSmokeExSm(getElementPosition(mineAssets[_ARG_1_][6]))
      if source ~= resourceRoot then
        setPedHeadingTo(source, cartTurtleObjects[_ARG_5_])
      end
    end
  elseif _ARG_2_ == "conveyor" then
    removeFixOreSync(_ARG_1_)
    if mineAssets[_ARG_1_] then
      if isElement(mineAssets[_ARG_1_][6]) then
        if isElement((playSound3D("files/sounds/orefall" .. math.random(1, 4) .. ".wav", getElementPosition(mineAssets[_ARG_1_][6])))) then
          setElementInterior(playSound3D("files/sounds/orefall" .. math.random(1, 4) .. ".wav", getElementPosition(mineAssets[_ARG_1_][6])), 0)
          setElementDimension(playSound3D("files/sounds/orefall" .. math.random(1, 4) .. ".wav", getElementPosition(mineAssets[_ARG_1_][6])), currentMine)
          attachElements(playSound3D("files/sounds/orefall" .. math.random(1, 4) .. ".wav", getElementPosition(mineAssets[_ARG_1_][6])), mineAssets[_ARG_1_][6])
        end
        detachElements(mineAssets[_ARG_1_][6])
        setElementInterior(mineAssets[_ARG_1_][6], 0)
        setElementDimension(mineAssets[_ARG_1_][6], currentMine)
        table.insert(_UPVALUE1_, {
          oreElement = mineAssets[_ARG_1_][6],
          orePosX = getElementPosition(mineAssets[_ARG_1_][6])
        })
      end
      mineAssets[_ARG_1_] = nil
    end
  elseif _ARG_2_ == "delete" then
    removeFixOreSync(_ARG_1_)
    if mineAssets[_ARG_1_] then
      if isElement(mineAssets[_ARG_1_][6]) then
        destroyElement(mineAssets[_ARG_1_][6])
      end
      mineAssets[_ARG_1_] = nil
    end
  end
end)
;(function(_ARG_0_, _ARG_1_, _ARG_2_)
  addEvent(_ARG_0_, true)
  addEventHandler(_ARG_0_, _ARG_1_, function(_ARG_0_, ...)
    if not loadingMineExit then
      if loadingMineEnter then
        if _ARG_0_ == loadingMineEnter then
          table.insert(mineAssets, {
            eventName = _UPVALUE1_,
            handlerFunction = _UPVALUE2_,
            handlerFunctionParams = {
              ...
            },
            sourceElement = source
          })
        end
      elseif _ARG_0_ == currentMine then
        _UPVALUE2_(_ARG_0_, ...)
      end
    end
  end)
end)("syncOreEmptying", root, function(_ARG_0_, _ARG_1_, _ARG_2_)
  if cartTurtleEmptying[_ARG_1_] == localPlayer then
    emptyingTurtle = false
  end
  cartTurtleEmptying[_ARG_1_] = _ARG_2_
  if _ARG_2_ == localPlayer then
    emptyingTurtle = _ARG_1_
  end
end)
function attachFixOreToCart(_ARG_0_, _ARG_1_, _ARG_2_)
  if mineAssets[_ARG_0_] then
    detachFixOre(_ARG_0_)
    if not _UPVALUE1_[_ARG_0_] then
      _UPVALUE1_[_ARG_0_] = true
      if isElement(mineAssets[_ARG_0_][6]) then
        setElementInterior(mineAssets[_ARG_0_][6], 0)
        setElementDimension(mineAssets[_ARG_0_][6], currentMine)
      end
    end
    if isElement(mineAssets[_ARG_0_][6]) then
      setElementModel(mineAssets[_ARG_0_][6], modelIds["v4_mine_ore" .. oreCartOffsets[_ARG_2_][1]])
      attachElements(mineAssets[_ARG_0_][6], cartTurtleObjects[_ARG_1_], unpack(oreCartOffsets[_ARG_2_], 2))
      setElementCollisionsEnabled(mineAssets[_ARG_0_][6], false)
    end
    fixOreCarts[_ARG_0_] = {_ARG_1_, _ARG_2_}
    if _ARG_2_ > (cartMaxSlots[_ARG_1_] or 0) then
      cartMaxSlots[_ARG_1_] = _ARG_2_
      cartLastSlot[_ARG_1_] = _ARG_0_
    end
    setFixOrePosition(_ARG_0_, getElementPosition(cartTurtleObjects[_ARG_1_]))
  end
end
function attachFixOreToPlayer(_ARG_0_, _ARG_1_)
  if mineAssets[_ARG_0_] then
    detachFixOre(_ARG_0_)
    if isElement(mineAssets[_ARG_0_][6]) then
      setElementCollisionsEnabled(mineAssets[_ARG_0_][6], false)
    end
    _UPVALUE1_[_ARG_0_] = _ARG_1_
    if _ARG_1_ == localPlayer then
      exports.see_gui:showInfobox("i", "A letételhez nyomj [F] gombot.")
      if oreTypes[mineAssets[_ARG_0_][10]].instantItem then
        exports.see_gui:showInfobox("i", "Az [E] gomb megnyomásával elteheted az inventorydba.")
      end
      carryingFixOre = _ARG_0_
    end
    processTablet(_ARG_1_, false)
    setPedAnimation(_ARG_1_, "CARRY", "CRRY_PRTIAL", 0, true, false, false, true)
    if isElement(mineAssets[_ARG_0_][6]) then
      setPedHeadingTo(_ARG_1_, mineAssets[_ARG_0_][6])
    end
  end
end
function detachFixOre(_ARG_0_)
  if carryingFixOre == _ARG_0_ then
    carryingFixOre = false
  end
  if fixOreCarts[_ARG_0_] then
    if isElement(_UPVALUE1_[_ARG_0_][6]) then
      if isElement(cartTurtleObjects[fixOreCarts[_ARG_0_][1]]) then
        detachElements(_UPVALUE1_[_ARG_0_][6], cartTurtleObjects[fixOreCarts[_ARG_0_][1]])
      end
      setElementCollisionsEnabled(_UPVALUE1_[_ARG_0_][6], true)
    end
    cartMaxSlots[fixOreCarts[_ARG_0_][1]] = 0
    cartLastSlot[fixOreCarts[_ARG_0_][1]] = nil
    fixOreCarts[_ARG_0_] = nil
    for _FORV_7_ in pairs(fixOreCarts) do
      if unpack(fixOreCarts[_FORV_7_]) > cartMaxSlots[unpack(fixOreCarts[_FORV_7_])] then
        cartMaxSlots[fixOreCarts[_ARG_0_][1]] = unpack(fixOreCarts[_FORV_7_])
        cartLastSlot[fixOreCarts[_ARG_0_][1]] = _FORV_7_
      end
    end
  end
  mineAssets[_ARG_0_] = nil
  if mineAssets[_ARG_0_] then
    processTablet(mineAssets[_ARG_0_])
  end
end
function removeFixOreSync(_ARG_0_)
  if mineAssets[_ARG_0_] and mineAssets[_ARG_0_][8] and mineAssets[_ARG_0_][9] and _UPVALUE1_[mineAssets[_ARG_0_][8]] and _UPVALUE1_[mineAssets[_ARG_0_][8]][mineAssets[_ARG_0_][9]] then
    for _FORV_7_ = #_UPVALUE1_[mineAssets[_ARG_0_][8]][mineAssets[_ARG_0_][9]], 1, -1 do
      if _UPVALUE1_[mineAssets[_ARG_0_][8]][mineAssets[_ARG_0_][9]][_FORV_7_] == _ARG_0_ then
        table.remove(_UPVALUE1_[mineAssets[_ARG_0_][8]][mineAssets[_ARG_0_][9]], _FORV_7_)
        break
      end
    end
  end
  _UPVALUE2_[_ARG_0_] = nil
end
function doFixOreStreaming()
  iterateGrid(mineAssets, selfMineX - 5, selfMineY - 5, selfMineX + 5, selfMineY + 5, function(_ARG_0_)
    for _FORV_4_ = 1, #_ARG_0_ do
      if _ARG_0_[_FORV_4_] and mineAssets[_ARG_0_[_FORV_4_]] then
        _UPVALUE1_[_ARG_0_[_FORV_4_]] = true
        if _UPVALUE2_[_ARG_0_[_FORV_4_]] ~= (getDistanceBetweenPoints2D(selfPosX, selfPosY, mineAssets[_ARG_0_[_FORV_4_]][1], mineAssets[_ARG_0_[_FORV_4_]][2]) < 25 and true or nil) then
          _UPVALUE2_[_ARG_0_[_FORV_4_]] = getDistanceBetweenPoints2D(selfPosX, selfPosY, mineAssets[_ARG_0_[_FORV_4_]][1], mineAssets[_ARG_0_[_FORV_4_]][2]) < 25 and true or nil
          if isElement(mineAssets[_ARG_0_[_FORV_4_]][6]) then
            setElementInterior(mineAssets[_ARG_0_[_FORV_4_]][6], 0)
            setElementDimension(mineAssets[_ARG_0_[_FORV_4_]][6], (getDistanceBetweenPoints2D(selfPosX, selfPosY, mineAssets[_ARG_0_[_FORV_4_]][1], mineAssets[_ARG_0_[_FORV_4_]][2]) < 25 and true or nil) and currentMine or 0)
          end
          coroutine.yield()
        end
      end
    end
  end)
  while true do
    for _FORV_5_ in pairs(_UPVALUE2_) do
      if not ({})[_FORV_5_] then
        _UPVALUE2_[_FORV_5_] = nil
        if isElement(_UPVALUE1_[_FORV_5_][6]) then
          setElementInterior(_UPVALUE1_[_FORV_5_][6], 0)
          setElementDimension(_UPVALUE1_[_FORV_5_][6], 0)
        end
        break
      end
    end
    if false then
      break
    end
    coroutine.yield()
  end
end
function setFixOrePosition(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  if _ARG_3_ and isElement(mineAssets[_ARG_0_][6]) then
    setElementPosition(mineAssets[_ARG_0_][6], _ARG_1_, _ARG_2_, _ARG_3_)
  end
  mineAssets[_ARG_0_][1] = _ARG_1_
  mineAssets[_ARG_0_][2] = _ARG_2_
  if convertMineCoordinates(_ARG_1_, _ARG_2_) ~= mineAssets[_ARG_0_][8] or convertMineCoordinates(_ARG_1_, _ARG_2_) ~= mineAssets[_ARG_0_][9] then
    if mineAssets[_ARG_0_][8] and mineAssets[_ARG_0_][9] and _UPVALUE1_[mineAssets[_ARG_0_][8]] and _UPVALUE1_[mineAssets[_ARG_0_][8]][mineAssets[_ARG_0_][9]] then
      for _FORV_11_ = #_UPVALUE1_[mineAssets[_ARG_0_][8]][mineAssets[_ARG_0_][9]], 1, -1 do
        if _UPVALUE1_[mineAssets[_ARG_0_][8]][mineAssets[_ARG_0_][9]][_FORV_11_] == _ARG_0_ then
          table.remove(_UPVALUE1_[mineAssets[_ARG_0_][8]][mineAssets[_ARG_0_][9]], _FORV_11_)
          break
        end
      end
    end
    _FOR_[_ARG_0_][8] = convertMineCoordinates(_ARG_1_, _ARG_2_)
    mineAssets[_ARG_0_][9] = convertMineCoordinates(_ARG_1_, _ARG_2_)
    if not _UPVALUE1_[convertMineCoordinates(_ARG_1_, _ARG_2_)] then
      _UPVALUE1_[convertMineCoordinates(_ARG_1_, _ARG_2_)] = {}
    end
    if not _UPVALUE1_[convertMineCoordinates(_ARG_1_, _ARG_2_)][convertMineCoordinates(_ARG_1_, _ARG_2_)] then
      _UPVALUE1_[convertMineCoordinates(_ARG_1_, _ARG_2_)][convertMineCoordinates(_ARG_1_, _ARG_2_)] = {}
    end
    table.insert(_UPVALUE1_[convertMineCoordinates(_ARG_1_, _ARG_2_)][convertMineCoordinates(_ARG_1_, _ARG_2_)], _ARG_0_)
  end
end
function doHandleMineHit(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  mineAssets[_ARG_0_][_ARG_1_] = mineAssets[_ARG_0_][_ARG_1_] + _ARG_2_
  if _ARG_3_ and _UPVALUE1_[_ARG_0_] then
    if not _UPVALUE2_[_ARG_0_] then
      _UPVALUE2_[_ARG_0_] = {}
    end
    for _FORV_9_ = #_UPVALUE1_[_ARG_0_], 1, -1 do
      if unpack(_UPVALUE1_[_ARG_0_][_FORV_9_]) and _ARG_3_[unpack(_UPVALUE1_[_ARG_0_][_FORV_9_])] then
        if not isElement(unpack(_UPVALUE1_[_ARG_0_][_FORV_9_])) and isElement((createObject(modelIds[oreTypes[unpack(_UPVALUE1_[_ARG_0_][_FORV_9_])] and oreTypes[unpack(_UPVALUE1_[_ARG_0_][_FORV_9_])].modelName or "v4_mine_ore" .. math.random(1, 5)], minePosX + unpack(_UPVALUE1_[_ARG_0_][_FORV_9_]), minePosY + unpack(_UPVALUE1_[_ARG_0_][_FORV_9_]), minePosZ + unpack(_UPVALUE1_[_ARG_0_][_FORV_9_]), math.random() * 360, math.random() * 360, math.random() * 360))) then
          refreshOreShader(createObject(modelIds[oreTypes[unpack(_UPVALUE1_[_ARG_0_][_FORV_9_])] and oreTypes[unpack(_UPVALUE1_[_ARG_0_][_FORV_9_])].modelName or "v4_mine_ore" .. math.random(1, 5)], minePosX + unpack(_UPVALUE1_[_ARG_0_][_FORV_9_]), minePosY + unpack(_UPVALUE1_[_ARG_0_][_FORV_9_]), minePosZ + unpack(_UPVALUE1_[_ARG_0_][_FORV_9_]), math.random() * 360, math.random() * 360, math.random() * 360), unpack(_UPVALUE1_[_ARG_0_][_FORV_9_]))
          setElementInterior(createObject(modelIds[oreTypes[unpack(_UPVALUE1_[_ARG_0_][_FORV_9_])] and oreTypes[unpack(_UPVALUE1_[_ARG_0_][_FORV_9_])].modelName or "v4_mine_ore" .. math.random(1, 5)], minePosX + unpack(_UPVALUE1_[_ARG_0_][_FORV_9_]), minePosY + unpack(_UPVALUE1_[_ARG_0_][_FORV_9_]), minePosZ + unpack(_UPVALUE1_[_ARG_0_][_FORV_9_]), math.random() * 360, math.random() * 360, math.random() * 360), 0)
          setElementDimension(createObject(modelIds[oreTypes[unpack(_UPVALUE1_[_ARG_0_][_FORV_9_])] and oreTypes[unpack(_UPVALUE1_[_ARG_0_][_FORV_9_])].modelName or "v4_mine_ore" .. math.random(1, 5)], minePosX + unpack(_UPVALUE1_[_ARG_0_][_FORV_9_]), minePosY + unpack(_UPVALUE1_[_ARG_0_][_FORV_9_]), minePosZ + unpack(_UPVALUE1_[_ARG_0_][_FORV_9_]), math.random() * 360, math.random() * 360, math.random() * 360), currentMine)
        end
        if type(_ARG_3_[unpack(_UPVALUE1_[_ARG_0_][_FORV_9_])]) == "table" then
        end
        if _UPVALUE1_[_ARG_0_][_FORV_9_][5] ~= createObject(modelIds[oreTypes[unpack(_UPVALUE1_[_ARG_0_][_FORV_9_])] and oreTypes[unpack(_UPVALUE1_[_ARG_0_][_FORV_9_])].modelName or "v4_mine_ore" .. math.random(1, 5)], minePosX + unpack(_UPVALUE1_[_ARG_0_][_FORV_9_]), minePosY + unpack(_UPVALUE1_[_ARG_0_][_FORV_9_]), minePosZ + unpack(_UPVALUE1_[_ARG_0_][_FORV_9_]), math.random() * 360, math.random() * 360, math.random() * 360) or unpack(_UPVALUE1_[_ARG_0_][_FORV_9_]) ~= _ARG_3_[unpack(_UPVALUE1_[_ARG_0_][_FORV_9_])][2] then
          _UPVALUE1_[_ARG_0_][_FORV_9_][5] = createObject(modelIds[oreTypes[unpack(_UPVALUE1_[_ARG_0_][_FORV_9_])] and oreTypes[unpack(_UPVALUE1_[_ARG_0_][_FORV_9_])].modelName or "v4_mine_ore" .. math.random(1, 5)], minePosX + unpack(_UPVALUE1_[_ARG_0_][_FORV_9_]), minePosY + unpack(_UPVALUE1_[_ARG_0_][_FORV_9_]), minePosZ + unpack(_UPVALUE1_[_ARG_0_][_FORV_9_]), math.random() * 360, math.random() * 360, math.random() * 360)
          _UPVALUE1_[_ARG_0_][_FORV_9_][6] = _ARG_3_[unpack(_UPVALUE1_[_ARG_0_][_FORV_9_])][2]
          refreshOreShader(createObject(modelIds[oreTypes[unpack(_UPVALUE1_[_ARG_0_][_FORV_9_])] and oreTypes[unpack(_UPVALUE1_[_ARG_0_][_FORV_9_])].modelName or "v4_mine_ore" .. math.random(1, 5)], minePosX + unpack(_UPVALUE1_[_ARG_0_][_FORV_9_]), minePosY + unpack(_UPVALUE1_[_ARG_0_][_FORV_9_]), minePosZ + unpack(_UPVALUE1_[_ARG_0_][_FORV_9_]), math.random() * 360, math.random() * 360, math.random() * 360), _ARG_3_[unpack(_UPVALUE1_[_ARG_0_][_FORV_9_])][2])
        end
        if not _ARG_4_ and isElement((playSound3D("files/sounds/orefall" .. math.random(1, 7) .. ".wav", minePosX + unpack(_UPVALUE1_[_ARG_0_][_FORV_9_]), minePosY + unpack(_UPVALUE1_[_ARG_0_][_FORV_9_]), minePosZ + unpack(_UPVALUE1_[_ARG_0_][_FORV_9_])))) then
          attachElements(playSound3D("files/sounds/orefall" .. math.random(1, 7) .. ".wav", minePosX + unpack(_UPVALUE1_[_ARG_0_][_FORV_9_]), minePosY + unpack(_UPVALUE1_[_ARG_0_][_FORV_9_]), minePosZ + unpack(_UPVALUE1_[_ARG_0_][_FORV_9_])), (createObject(modelIds[oreTypes[unpack(_UPVALUE1_[_ARG_0_][_FORV_9_])] and oreTypes[unpack(_UPVALUE1_[_ARG_0_][_FORV_9_])].modelName or "v4_mine_ore" .. math.random(1, 5)], minePosX + unpack(_UPVALUE1_[_ARG_0_][_FORV_9_]), minePosY + unpack(_UPVALUE1_[_ARG_0_][_FORV_9_]), minePosZ + unpack(_UPVALUE1_[_ARG_0_][_FORV_9_]), math.random() * 360, math.random() * 360, math.random() * 360)))
          setElementInterior(playSound3D("files/sounds/orefall" .. math.random(1, 7) .. ".wav", minePosX + unpack(_UPVALUE1_[_ARG_0_][_FORV_9_]), minePosY + unpack(_UPVALUE1_[_ARG_0_][_FORV_9_]), minePosZ + unpack(_UPVALUE1_[_ARG_0_][_FORV_9_])), 0)
          setElementDimension(playSound3D("files/sounds/orefall" .. math.random(1, 7) .. ".wav", minePosX + unpack(_UPVALUE1_[_ARG_0_][_FORV_9_]), minePosY + unpack(_UPVALUE1_[_ARG_0_][_FORV_9_]), minePosZ + unpack(_UPVALUE1_[_ARG_0_][_FORV_9_])), currentMine)
        end
        if type(_ARG_3_[unpack(_UPVALUE1_[_ARG_0_][_FORV_9_])]) == "table" then
          removeFixOreSync(_ARG_3_[unpack(_UPVALUE1_[_ARG_0_][_FORV_9_])][1])
          if _UPVALUE3_[_ARG_3_[unpack(_UPVALUE1_[_ARG_0_][_FORV_9_])][1]] then
            if isElement(_UPVALUE3_[_ARG_3_[unpack(_UPVALUE1_[_ARG_0_][_FORV_9_])][1]][6]) then
              destroyElement(_UPVALUE3_[_ARG_3_[unpack(_UPVALUE1_[_ARG_0_][_FORV_9_])][1]][6])
            end
            _UPVALUE3_[_ARG_3_[unpack(_UPVALUE1_[_ARG_0_][_FORV_9_])][1]][6] = nil
          end
          _UPVALUE3_[_ARG_3_[unpack(_UPVALUE1_[_ARG_0_][_FORV_9_])][1]] = {
            unpack(_UPVALUE1_[_ARG_0_][_FORV_9_])
          }
          _UPVALUE4_[_ARG_3_[unpack(_UPVALUE1_[_ARG_0_][_FORV_9_])][1]] = true
          if _ARG_3_[unpack(_UPVALUE1_[_ARG_0_][_FORV_9_])][1] then
            setFixOrePosition(_ARG_3_[unpack(_UPVALUE1_[_ARG_0_][_FORV_9_])][1], unpack(_UPVALUE1_[_ARG_0_][_FORV_9_]))
          end
          table.insert(_UPVALUE5_, _ARG_3_[unpack(_UPVALUE1_[_ARG_0_][_FORV_9_])][1])
        else
          table.insert(_UPVALUE2_[_ARG_0_], {
            unpack(_UPVALUE1_[_ARG_0_][_FORV_9_])
          })
        end
        table.remove(_UPVALUE1_[_ARG_0_], _FORV_9_)
      end
    end
  end
end
function doHandleMineHitCollision(_ARG_0_, _ARG_1_, _ARG_2_)
  if getShaftBlockPosition(_ARG_0_, _ARG_1_) then
    if isElement(mineAssets[_ARG_0_][_ARG_1_]) then
      setElementPosition(mineAssets[_ARG_0_][_ARG_1_], getShaftBlockPosition(_ARG_0_, _ARG_1_))
    end
    if _ARG_2_ ~= nil then
      if isElement((playSound3D("files/sounds/pickaxehit" .. math.random(_ARG_2_ and 16 or 1, _ARG_2_ and 20 or 15) .. ".wav", getShaftBlockPosition(_ARG_0_, _ARG_1_)))) then
        setElementInterior(playSound3D("files/sounds/pickaxehit" .. math.random(_ARG_2_ and 16 or 1, _ARG_2_ and 20 or 15) .. ".wav", getShaftBlockPosition(_ARG_0_, _ARG_1_)), 0)
        setElementDimension(playSound3D("files/sounds/pickaxehit" .. math.random(_ARG_2_ and 16 or 1, _ARG_2_ and 20 or 15) .. ".wav", getShaftBlockPosition(_ARG_0_, _ARG_1_)), currentMine)
      end
      spawnSmoke(getShaftBlockPosition(_ARG_0_, _ARG_1_))
    end
  end
  return getShaftBlockPosition(_ARG_0_, _ARG_1_)
end
function doHandleMineHitAfter(_ARG_0_)
  for _FORV_5_ = 1, wallBlockCount do
  end
  if mineAssets[_ARG_0_][_FORV_5_] > 0 then
    _UPVALUE1_[_ARG_0_] = _UPVALUE1_[_ARG_0_] + mineAssets[_ARG_0_][_FORV_5_]
    _UPVALUE2_[_ARG_0_] = {
      minePosX + _UPVALUE3_[_ARG_0_][1] * 6 + (_UPVALUE1_[_ARG_0_] - 3) * _UPVALUE4_[_ARG_0_][3],
      minePosY + _UPVALUE3_[_ARG_0_][2] * 6 + (_UPVALUE1_[_ARG_0_] - 3) * _UPVALUE4_[_ARG_0_][4]
    }
    for _FORV_5_ = 1, wallBlockCount do
      mineAssets[_ARG_0_][_FORV_5_] = mineAssets[_ARG_0_][_FORV_5_] - mineAssets[_ARG_0_][_FORV_5_]
    end
    if isElement(_UPVALUE5_[_ARG_0_]) then
      setElementPosition(_UPVALUE5_[_ARG_0_], _UPVALUE2_[_ARG_0_][1], _UPVALUE2_[_ARG_0_][2], minePosZ)
    end
  end
  _UPVALUE6_[_ARG_0_] = true
  _UPVALUE7_[_ARG_0_] = nil
  if _UPVALUE8_ == _ARG_0_ then
    _UPVALUE9_ = true
  end
end
function spawnSmoke(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  for _FORV_7_ = 1, math.random(10, 30) do
    spawnSmokeParticle(_ARG_0_, _ARG_1_, _ARG_2_, math.random() - 0.5, math.random() - 0.5, math.random() - 0.5, 1000 + math.random() * 2000, 150 + math.random() * 55, 0.4 + math.random() * 0.4, 0.2 + math.random() * 0.2)
  end
  if _ARG_3_ then
    for _FORV_7_ = 1, math.random(10, 30) do
      spawnSparkParticle(_ARG_0_, _ARG_1_, _ARG_2_, (math.random() - 0.5) * 4, (math.random() - 0.5) * 4, (math.random() - 0.5) * 4, 500 + math.random() * 1000, 200 + math.random() * 55, 0.025 + math.random() * 0.025, 0.001 + math.random() * 0.001)
    end
  end
end
function spawnSmokeEx(_ARG_0_, _ARG_1_, _ARG_2_)
  for _FORV_6_ = 1, math.random(20, 50) do
    spawnSmokeParticle(_ARG_0_, _ARG_1_, _ARG_2_, math.random() - 0.5, math.random() - 0.5, math.random() * 0.5, 2000 + math.random() * 2000, 150 + math.random() * 55, 0.6 + math.random() * 0.6, 0.25 + math.random() * 0.25)
  end
end
function spawnSmokeExSm(_ARG_0_, _ARG_1_, _ARG_2_)
  for _FORV_6_ = 1, math.random(20, 50) do
    spawnSmokeParticle(_ARG_0_, _ARG_1_, _ARG_2_, math.random() - 0.5, math.random() - 0.5, math.random() * 0.5, 1000 + math.random() * 1500, 150 + math.random() * 55, 0.3 + math.random() * 0.3, 0.125 + math.random() * 0.125)
  end
end
function spawnSmokeExBg(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  for _FORV_7_ = 1, math.random(100, 150) do
    spawnSmokeParticle(_ARG_0_ + (math.random() - 0.5) * 2, _ARG_1_ + (math.random() - 0.5) * 2, _ARG_2_ + (math.random() - 0.5) * 2, (math.random() - 0.5) * 0.25, (math.random() - 0.5) * 0.25, (math.random() - 0.5) * 0.25, 4000 + math.random() * 4000, 150 + math.random() * 55, 0.8 + math.random() * 0.8, 0.4 + math.random() * 0.4)
  end
  if _ARG_3_ then
    for _FORV_7_ = 1, math.random(20, 40) do
      spawnSparkParticle(_ARG_0_, _ARG_1_, _ARG_2_, (math.random() - 0.5) * 4, (math.random() - 0.5) * 4, (math.random() - 0.5) * 4, 500 + math.random() * 1000, 200 + math.random() * 55, 0.025 + math.random() * 0.025, 0.001 + math.random() * 0.001)
    end
  end
end
function spawnSmokeParticle(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_, _ARG_5_, _ARG_6_, _ARG_7_, _ARG_8_, _ARG_9_)
  table.insert(mineAssets, {
    _ARG_0_,
    _ARG_1_,
    _ARG_2_,
    _ARG_3_,
    _ARG_4_,
    _ARG_5_,
    getTickCount(),
    _ARG_6_,
    _ARG_7_,
    _ARG_8_,
    _ARG_9_
  })
end
function spawnSparkParticle(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_, _ARG_5_, _ARG_6_, _ARG_7_, _ARG_8_, _ARG_9_)
  table.insert(mineAssets, {
    _ARG_0_,
    _ARG_1_,
    _ARG_2_,
    _ARG_3_,
    _ARG_4_,
    _ARG_5_,
    getTickCount(),
    _ARG_6_,
    _ARG_7_,
    _ARG_8_,
    _ARG_9_
  })
end
function getMiningZoneColor(_ARG_0_)
  _ARG_0_ = math.min(1, _ARG_0_)
  if _ARG_0_ >= 0.9 then
    _ARG_0_ = (_ARG_0_ - 0.9) / 0.1
    return {
      guiColorCodes.primaryOrange[1] * (1 - _ARG_0_) + guiColorCodes.primaryRed[1] * _ARG_0_,
      guiColorCodes.primaryOrange[2] * (1 - _ARG_0_) + guiColorCodes.primaryRed[2] * _ARG_0_,
      guiColorCodes.primaryOrange[3] * (1 - _ARG_0_) + guiColorCodes.primaryRed[3] * _ARG_0_
    }
  end
  _ARG_0_ = math.pow(_ARG_0_ / 0.9, 1.5)
  return {
    guiColorCodes.primaryGreen[1] * (1 - _ARG_0_) + guiColorCodes.primaryOrange[1] * _ARG_0_,
    guiColorCodes.primaryGreen[2] * (1 - _ARG_0_) + guiColorCodes.primaryOrange[2] * _ARG_0_,
    guiColorCodes.primaryGreen[3] * (1 - _ARG_0_) + guiColorCodes.primaryOrange[3] * _ARG_0_
  }
end
function disableControls(_ARG_0_)
  if mineAssets ~= _ARG_0_ then
    mineAssets = _ARG_0_
    exports.see_controls:toggleControl("all", not _ARG_0_)
    setElementFrozen(localPlayer, _ARG_0_)
  end
end
function setCurrentActiveOpenShaft(_ARG_0_)
  if _ARG_0_ ~= mineAssets then
    if isElement(_UPVALUE1_[mineAssets]) then
      setElementInterior(_UPVALUE1_[mineAssets], 0)
      setElementDimension(_UPVALUE1_[mineAssets], currentMine)
    end
    mineAssets = _ARG_0_
    if _ARG_0_ then
      if not currentActiveNormalRT then
        currentActiveNormalRT = dxCreateRenderTarget(wallTextureWidth, wallTextureHeight)
      end
      if not currentActiveDepthRT then
        currentActiveDepthRT = dxCreateRenderTarget(wallTextureWidth, wallTextureHeight)
      end
      _UPVALUE2_ = {}
      if isElement(_UPVALUE1_[_ARG_0_]) then
        setElementInterior(_UPVALUE1_[_ARG_0_], 0)
        setElementDimension(_UPVALUE1_[_ARG_0_], 0)
      end
      if true then
        refreshActiveShaftShader()
      end
      processCurrentActiveWorld()
    else
      _UPVALUE2_ = nil
      _UPVALUE3_ = false
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
  generateRandomMDVD(mineAssets, {}, {})
  for _FORV_10_ = 1, wallBlockCount do
    processZoneDistance(mineAssets, _UPVALUE3_[mineAssets], {}, {}, _FORV_10_)
  end
  for _FORV_13_ = 1, wallVertexCount do
    _UPVALUE5_[_FORV_13_] = {
      _UPVALUE1_[mineAssets][1] + (unpack(_UPVALUE4_[_FORV_13_]) / wallTextureWidth - 0.5) * wallMeshWidth * _UPVALUE2_[mineAssets][4] + ({})[_FORV_13_] * _UPVALUE2_[mineAssets][3],
      _UPVALUE1_[mineAssets][2] - (unpack(_UPVALUE4_[_FORV_13_]) / wallTextureWidth - 0.5) * wallMeshWidth * _UPVALUE2_[mineAssets][3] + ({})[_FORV_13_] * _UPVALUE2_[mineAssets][4],
      minePosZ + unpack(_UPVALUE4_[_FORV_13_]) / wallTextureHeight * wallMeshHeight,
      4294967295,
      -(unpack(_UPVALUE4_[_FORV_13_]) / wallTextureWidth),
      -(unpack(_UPVALUE4_[_FORV_13_]) / wallTextureHeight)
    }
  end
  for _FORV_14_ = 1, wallVertexCount do
  end
  for _FORV_14_ = 1, wallVertexCount do
    ({})[_FORV_14_] = {
      _UPVALUE4_[_FORV_14_][1],
      _UPVALUE4_[_FORV_14_][2],
      tocolor(255 * math.max(0, (({})[_FORV_14_] - math.min(wallMaximumDepth, ({})[_FORV_14_])) / wallMaximumDepth), 255 * math.max(0, (({})[_FORV_14_] - math.min(wallMaximumDepth, ({})[_FORV_14_])) / wallMaximumDepth), 255 * math.max(0, (({})[_FORV_14_] - math.min(wallMaximumDepth, ({})[_FORV_14_])) / wallMaximumDepth), 255)
    }
  end
  for _FORV_14_ = 1, wallVertexCount, 3 do
    ({})[_FORV_14_] = {
      calculateSurfaceNormal(_UPVALUE5_[_FORV_14_], _UPVALUE5_[_FORV_14_ + 1], _UPVALUE5_[_FORV_14_ + 2])
    }
  end
  for _FORV_14_ in pairs(_UPVALUE6_) do
    for _FORV_21_ = 1, #_UPVALUE6_[_FORV_14_] do
    end
    ;({})[_FORV_14_] = {
      _UPVALUE4_[_FORV_14_][1],
      _UPVALUE4_[_FORV_14_][2],
      tocolor(math.floor((-(0 + ({})[_UPVALUE6_[_FORV_14_][_FORV_21_]][1]) / _FOR_.sqrt((0 + ({})[_UPVALUE6_[_FORV_14_][_FORV_21_]][1]) * (0 + ({})[_UPVALUE6_[_FORV_14_][_FORV_21_]][1]) + (0 + ({})[_UPVALUE6_[_FORV_14_][_FORV_21_]][2]) * (0 + ({})[_UPVALUE6_[_FORV_14_][_FORV_21_]][2]) + (0 + ({})[_UPVALUE6_[_FORV_14_][_FORV_21_]][3]) * (0 + ({})[_UPVALUE6_[_FORV_14_][_FORV_21_]][3])) * 0.5 + 0.5) * 255 + 0.5), math.floor((-(0 + ({})[_UPVALUE6_[_FORV_14_][_FORV_21_]][2]) / _FOR_.sqrt((0 + ({})[_UPVALUE6_[_FORV_14_][_FORV_21_]][1]) * (0 + ({})[_UPVALUE6_[_FORV_14_][_FORV_21_]][1]) + (0 + ({})[_UPVALUE6_[_FORV_14_][_FORV_21_]][2]) * (0 + ({})[_UPVALUE6_[_FORV_14_][_FORV_21_]][2]) + (0 + ({})[_UPVALUE6_[_FORV_14_][_FORV_21_]][3]) * (0 + ({})[_UPVALUE6_[_FORV_14_][_FORV_21_]][3])) * 0.5 + 0.5) * 255 + 0.5), math.floor((-(0 + ({})[_UPVALUE6_[_FORV_14_][_FORV_21_]][3]) / _FOR_.sqrt((0 + ({})[_UPVALUE6_[_FORV_14_][_FORV_21_]][1]) * (0 + ({})[_UPVALUE6_[_FORV_14_][_FORV_21_]][1]) + (0 + ({})[_UPVALUE6_[_FORV_14_][_FORV_21_]][2]) * (0 + ({})[_UPVALUE6_[_FORV_14_][_FORV_21_]][2]) + (0 + ({})[_UPVALUE6_[_FORV_14_][_FORV_21_]][3]) * (0 + ({})[_UPVALUE6_[_FORV_14_][_FORV_21_]][3])) * 0.5 + 0.5) * 255 + 0.5))
    }
  end
  for _FORV_14_ = 1, wallVertexCount do
    ({})[_FORV_14_] = ({})[_UPVALUE7_[_FORV_14_]]
  end
  _UPVALUE8_ = minePosX + _UPVALUE9_[mineAssets][1] * 6 + (_UPVALUE10_[mineAssets] + math.min(wallMaximumDepth, ({})[_FORV_14_]) - 3) * _UPVALUE2_[mineAssets][3]
  _UPVALUE11_ = minePosY + _UPVALUE9_[mineAssets][2] * 6 + (_UPVALUE10_[mineAssets] + math.min(wallMaximumDepth, ({})[_FORV_14_]) - 3) * _UPVALUE2_[mineAssets][4]
  refreshActiveShaftShaderBase(_UPVALUE8_ - _UPVALUE2_[mineAssets][4] * wallMeshWidth / 2, _UPVALUE11_ + _UPVALUE2_[mineAssets][3] * wallMeshWidth / 2, _UPVALUE2_[mineAssets][4], -_UPVALUE2_[mineAssets][3])
  dxSetRenderTarget(currentActiveDepthRT)
  dxDrawPrimitive("trianglelist", false, unpack({}))
  dxSetRenderTarget(currentActiveNormalRT)
  dxDrawPrimitive("trianglelist", false, unpack({}))
  dxSetRenderTarget()
  _UPVALUE12_ = false
end
function isShaftWallVisible(_ARG_0_, _ARG_1_)
  if mineAssets[_ARG_0_] then
    if getDistanceBetweenPoints2D(mineAssets[_ARG_0_][1], mineAssets[_ARG_0_][2], selfPosX, selfPosY) <= 50 then
      if _ARG_1_ then
      elseif isElement(_UPVALUE1_[_ARG_0_]) then
        if isElementOnScreen(_UPVALUE1_[_ARG_0_]) then
        end
      else
      end
    end
    return true, (getDistanceBetweenPoints2D(mineAssets[_ARG_0_][1], mineAssets[_ARG_0_][2], selfPosX, selfPosY))
  end
  return false
end
function createShaft(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_, _ARG_5_, _ARG_6_, _ARG_7_)
  for _FORV_11_ = 1, _ARG_3_ do
    createTunnelObject(_ARG_7_, _ARG_1_, _ARG_2_, _ARG_4_)
    if canExtendShaftAt(_ARG_1_, _ARG_2_) then
      setExtendableShaft(_ARG_1_, _ARG_2_, _ARG_0_, _FORV_11_)
    end
    _ARG_1_ = _ARG_1_ + _ARG_5_
    _ARG_2_ = _ARG_2_ + _ARG_6_
  end
  _ARG_1_ = _ARG_1_ - _ARG_5_
  _ARG_2_ = _ARG_2_ - _ARG_6_
  if mineAssets[_ARG_0_] then
    setOpenShaftAt(_ARG_1_, _ARG_2_, _ARG_0_)
  end
end
function setOpenShaftAt(_ARG_0_, _ARG_1_, _ARG_2_)
  if mineAssets[_ARG_0_] and isElement(mineAssets[_ARG_0_][_ARG_1_]) then
    if _ARG_2_ then
    end
    setElementModel(mineAssets[_ARG_0_][_ARG_1_], modelIds[("v4_mine_tunnel" .. _UPVALUE1_[_ARG_0_][_ARG_1_]) .. "_columnless"])
  end
  if not openShaftsAt[_ARG_0_] then
    openShaftsAt[_ARG_0_] = {}
  end
  openShaftsAt[_ARG_0_][_ARG_1_] = _ARG_2_
end
function setExtendableShaft(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  if _ARG_2_ and _ARG_3_ then
    if not mineAssets[_ARG_0_] then
      mineAssets[_ARG_0_] = {}
    end
    mineAssets[_ARG_0_][_ARG_1_] = {_ARG_2_, _ARG_3_}
  elseif mineAssets[_ARG_0_] and mineAssets[_ARG_0_][_ARG_1_] then
    mineAssets[_ARG_0_][_ARG_1_] = nil
  end
end
function processExtendableShaft(_ARG_0_, _ARG_1_, _ARG_2_)
  if not _ARG_0_ then
  end
  if mineAssets ~= _ARG_0_ or _UPVALUE1_ ~= selfMineX or _UPVALUE2_ ~= selfMineY then
    _UPVALUE2_, _UPVALUE1_, mineAssets = selfMineY, selfMineX, _ARG_0_
    if _ARG_0_ then
      if _ARG_2_ == 0 then
        _UPVALUE3_ = true
        _UPVALUE4_ = true
      elseif _ARG_2_ > 0 then
        _UPVALUE3_ = false
        _UPVALUE4_ = true
      elseif _ARG_2_ < 0 then
        _UPVALUE3_ = true
        _UPVALUE4_ = false
      end
    else
      if _ARG_2_ == 0 then
        _UPVALUE3_ = true
      else
        _UPVALUE3_ = false
      end
      _UPVALUE4_ = false
    end
  end
end
function deleteTunnelObject(_ARG_0_, _ARG_1_)
  if mineAssets[_ARG_0_] then
    if isElement(mineAssets[_ARG_0_][_ARG_1_]) then
      destroyElement(mineAssets[_ARG_0_][_ARG_1_])
    end
    mineAssets[_ARG_0_][_ARG_1_] = nil
  end
  if tunnelObjectRots[_ARG_0_] then
    tunnelObjectRots[_ARG_0_][_ARG_1_] = nil
  end
  if _UPVALUE1_[_ARG_0_] then
    _UPVALUE1_[_ARG_0_][_ARG_1_] = nil
  end
end
function createTunnelObject(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  if openShaftsAt[_ARG_1_] and openShaftsAt[_ARG_1_][_ARG_2_] then
  else
  end
  if not mineAssets[_ARG_1_] then
    mineAssets[_ARG_1_] = {}
  end
  if not mineAssets[_ARG_1_][_ARG_2_] then
    mineAssets[_ARG_1_][_ARG_2_] = createObject(modelIds["v4_mine_tunnel" .. math.floor(rngGetValue(_ARG_0_) * 5) + 1], minePosX + _ARG_1_ * 6, minePosY + _ARG_2_ * 6, minePosZ, 0, 0, 0)
    if isElement(mineAssets[_ARG_1_][_ARG_2_]) then
      setElementInterior(mineAssets[_ARG_1_][_ARG_2_], 0)
      setElementDimension(mineAssets[_ARG_1_][_ARG_2_], currentMine)
    end
  elseif isElement(mineAssets[_ARG_1_][_ARG_2_]) then
    setElementModel(mineAssets[_ARG_1_][_ARG_2_], modelIds["v4_mine_tunnel" .. math.floor(rngGetValue(_ARG_0_) * 5) + 1])
  end
  if isElement(mineAssets[_ARG_1_][_ARG_2_]) then
    setElementRotation(mineAssets[_ARG_1_][_ARG_2_], 0, 0, (rngGetValue(_ARG_0_) >= 0.5 and 180 or 0) + _ARG_3_)
  end
  if not _UPVALUE1_[_ARG_1_] then
    _UPVALUE1_[_ARG_1_] = {}
  end
  _UPVALUE1_[_ARG_1_][_ARG_2_] = math.floor(rngGetValue(_ARG_0_) * 5) + 1
  if not tunnelObjectRots[_ARG_1_] then
    tunnelObjectRots[_ARG_1_] = {}
  end
  tunnelObjectRots[_ARG_1_][_ARG_2_] = _ARG_3_
end
function createJunction(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  if not junctionObjects[_ARG_0_] then
    junctionObjects[_ARG_0_] = {}
  end
  if _ARG_3_ then
  else
  end
  if not junctionObjects[_ARG_0_][_ARG_1_] then
    junctionObjects[_ARG_0_][_ARG_1_] = createObject(modelIds["v4_mine_tunnel_crossing" .. _ARG_2_], minePosX + _ARG_0_ * 6, minePosY + _ARG_1_ * 6, minePosZ, 0, 0, 0)
    if isElement(junctionObjects[_ARG_0_][_ARG_1_]) then
      setElementInterior(junctionObjects[_ARG_0_][_ARG_1_], 0)
      setElementDimension(junctionObjects[_ARG_0_][_ARG_1_], currentMine)
    end
  elseif isElement(junctionObjects[_ARG_0_][_ARG_1_]) then
    setElementModel(junctionObjects[_ARG_0_][_ARG_1_], modelIds["v4_mine_tunnel_crossing" .. _ARG_2_])
  end
  if isElement(junctionObjects[_ARG_0_][_ARG_1_]) then
    setElementRotation(junctionObjects[_ARG_0_][_ARG_1_], 0, 0, _ARG_3_ or 0)
  end
  if threeJunctionsAt[_ARG_0_] then
    threeJunctionsAt[_ARG_0_][_ARG_1_] = nil
  end
  if _ARG_3_ then
    if not threeJunctionRots[_ARG_0_] then
      threeJunctionRots[_ARG_0_] = {}
    end
    threeJunctionRots[_ARG_0_][_ARG_1_] = _ARG_3_
    if not threeJunctionsAt[_ARG_0_] then
      threeJunctionsAt[_ARG_0_] = {}
    end
    threeJunctionsAt[_ARG_0_][_ARG_1_] = prad(_ARG_3_)
  elseif threeJunctionsAt[_ARG_0_] and not next(threeJunctionsAt[_ARG_0_]) then
    threeJunctionsAt[_ARG_0_] = nil
    if threeJunctionRots[_ARG_0_] then
      threeJunctionRots[_ARG_0_][_ARG_1_] = nil
    end
  end
end
function clearRandomMDVD()
  mineAssets = {}
  _UPVALUE1_ = {}
  _UPVALUE2_ = {}
end
function generateRandomMDVD(_ARG_0_, _ARG_1_, _ARG_2_)
  if mineAssets[_ARG_0_] and _UPVALUE1_[_ARG_0_] then
    for _FORV_6_, _FORV_7_ in pairs(_UPVALUE2_) do
      for _FORV_11_ = 1, #_FORV_7_ do
        _ARG_2_[_FORV_7_[_FORV_11_]] = _UPVALUE1_[_ARG_0_][_FORV_7_[_FORV_11_]]
        _ARG_1_[_FORV_7_[_FORV_11_]] = mineAssets[_ARG_0_][_FORV_7_[_FORV_11_]]
      end
    end
  else
    _UPVALUE1_[_ARG_0_] = {}
    mineAssets[_ARG_0_] = {}
    for _FORV_6_, _FORV_7_ in pairs(_UPVALUE2_) do
      for _FORV_13_ = 1, #_FORV_7_ do
        _ARG_2_[_FORV_7_[_FORV_13_]] = math.max(0, math.random() * wallMinimumDepth)
        _ARG_1_[_FORV_7_[_FORV_13_]] = math.max(0, wallMaximumDepth - math.random() * wallMinimumDepth)
        _UPVALUE1_[_ARG_0_][_FORV_7_[_FORV_13_]] = _ARG_2_[_FORV_7_[_FORV_13_]]
        mineAssets[_ARG_0_][_FORV_7_[_FORV_13_]] = _ARG_1_[_FORV_7_[_FORV_13_]]
      end
    end
  end
end
function processZoneDistance(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if not mineAssets[_ARG_0_] then
    mineAssets[_ARG_0_] = {}
  end
  if not mineAssets[_ARG_0_][_ARG_4_] then
    mineAssets[_ARG_0_][_ARG_4_] = {}
  end
  for _FORV_9_, _FORV_10_ in pairs(_UPVALUE1_) do
    if _UPVALUE2_[_FORV_9_][_ARG_4_] > 0 then
      if _ARG_3_[_FORV_9_] < _ARG_1_[_UPVALUE3_[_FORV_9_][5]] * (1 - _UPVALUE2_[_FORV_9_][_ARG_4_]) + _ARG_1_[_ARG_4_] * _UPVALUE2_[_FORV_9_][_ARG_4_] then
        if not mineAssets[_ARG_0_][_ARG_4_][_FORV_9_] then
          mineAssets[_ARG_0_][_ARG_4_][_FORV_9_] = math.random()
        end
      end
      for _FORV_19_ = 1, #_FORV_10_ do
        _ARG_3_[_FORV_10_[_FORV_19_]] = math.min(_ARG_2_[_FORV_9_], _ARG_1_[_UPVALUE3_[_FORV_9_][5]] * (1 - _UPVALUE2_[_FORV_9_][_ARG_4_]) + _ARG_1_[_ARG_4_] * _UPVALUE2_[_FORV_9_][_ARG_4_] + mineAssets[_ARG_0_][_ARG_4_][_FORV_9_] * wallMinimumDepth)
      end
    end
  end
end
function calculateSurfaceNormal(_ARG_0_, _ARG_1_, _ARG_2_)
  if math.sqrt(((_ARG_1_[2] - _ARG_0_[2]) * (_ARG_2_[3] - _ARG_0_[3]) - (_ARG_1_[3] - _ARG_0_[3]) * (_ARG_2_[2] - _ARG_0_[2])) * ((_ARG_1_[2] - _ARG_0_[2]) * (_ARG_2_[3] - _ARG_0_[3]) - (_ARG_1_[3] - _ARG_0_[3]) * (_ARG_2_[2] - _ARG_0_[2])) + ((_ARG_1_[3] - _ARG_0_[3]) * (_ARG_2_[1] - _ARG_0_[1]) - (_ARG_1_[1] - _ARG_0_[1]) * (_ARG_2_[3] - _ARG_0_[3])) * ((_ARG_1_[3] - _ARG_0_[3]) * (_ARG_2_[1] - _ARG_0_[1]) - (_ARG_1_[1] - _ARG_0_[1]) * (_ARG_2_[3] - _ARG_0_[3])) + ((_ARG_1_[1] - _ARG_0_[1]) * (_ARG_2_[2] - _ARG_0_[2]) - (_ARG_1_[2] - _ARG_0_[2]) * (_ARG_2_[1] - _ARG_0_[1])) * ((_ARG_1_[1] - _ARG_0_[1]) * (_ARG_2_[2] - _ARG_0_[2]) - (_ARG_1_[2] - _ARG_0_[2]) * (_ARG_2_[1] - _ARG_0_[1]))) ~= 0 then
  end
  return ((_ARG_1_[2] - _ARG_0_[2]) * (_ARG_2_[3] - _ARG_0_[3]) - (_ARG_1_[3] - _ARG_0_[3]) * (_ARG_2_[2] - _ARG_0_[2])) / math.sqrt(((_ARG_1_[2] - _ARG_0_[2]) * (_ARG_2_[3] - _ARG_0_[3]) - (_ARG_1_[3] - _ARG_0_[3]) * (_ARG_2_[2] - _ARG_0_[2])) * ((_ARG_1_[2] - _ARG_0_[2]) * (_ARG_2_[3] - _ARG_0_[3]) - (_ARG_1_[3] - _ARG_0_[3]) * (_ARG_2_[2] - _ARG_0_[2])) + ((_ARG_1_[3] - _ARG_0_[3]) * (_ARG_2_[1] - _ARG_0_[1]) - (_ARG_1_[1] - _ARG_0_[1]) * (_ARG_2_[3] - _ARG_0_[3])) * ((_ARG_1_[3] - _ARG_0_[3]) * (_ARG_2_[1] - _ARG_0_[1]) - (_ARG_1_[1] - _ARG_0_[1]) * (_ARG_2_[3] - _ARG_0_[3])) + ((_ARG_1_[1] - _ARG_0_[1]) * (_ARG_2_[2] - _ARG_0_[2]) - (_ARG_1_[2] - _ARG_0_[2]) * (_ARG_2_[1] - _ARG_0_[1])) * ((_ARG_1_[1] - _ARG_0_[1]) * (_ARG_2_[2] - _ARG_0_[2]) - (_ARG_1_[2] - _ARG_0_[2]) * (_ARG_2_[1] - _ARG_0_[1]))), ((_ARG_1_[3] - _ARG_0_[3]) * (_ARG_2_[1] - _ARG_0_[1]) - (_ARG_1_[1] - _ARG_0_[1]) * (_ARG_2_[3] - _ARG_0_[3])) / math.sqrt(((_ARG_1_[2] - _ARG_0_[2]) * (_ARG_2_[3] - _ARG_0_[3]) - (_ARG_1_[3] - _ARG_0_[3]) * (_ARG_2_[2] - _ARG_0_[2])) * ((_ARG_1_[2] - _ARG_0_[2]) * (_ARG_2_[3] - _ARG_0_[3]) - (_ARG_1_[3] - _ARG_0_[3]) * (_ARG_2_[2] - _ARG_0_[2])) + ((_ARG_1_[3] - _ARG_0_[3]) * (_ARG_2_[1] - _ARG_0_[1]) - (_ARG_1_[1] - _ARG_0_[1]) * (_ARG_2_[3] - _ARG_0_[3])) * ((_ARG_1_[3] - _ARG_0_[3]) * (_ARG_2_[1] - _ARG_0_[1]) - (_ARG_1_[1] - _ARG_0_[1]) * (_ARG_2_[3] - _ARG_0_[3])) + ((_ARG_1_[1] - _ARG_0_[1]) * (_ARG_2_[2] - _ARG_0_[2]) - (_ARG_1_[2] - _ARG_0_[2]) * (_ARG_2_[1] - _ARG_0_[1])) * ((_ARG_1_[1] - _ARG_0_[1]) * (_ARG_2_[2] - _ARG_0_[2]) - (_ARG_1_[2] - _ARG_0_[2]) * (_ARG_2_[1] - _ARG_0_[1]))), ((_ARG_1_[1] - _ARG_0_[1]) * (_ARG_2_[2] - _ARG_0_[2]) - (_ARG_1_[2] - _ARG_0_[2]) * (_ARG_2_[1] - _ARG_0_[1])) / math.sqrt(((_ARG_1_[2] - _ARG_0_[2]) * (_ARG_2_[3] - _ARG_0_[3]) - (_ARG_1_[3] - _ARG_0_[3]) * (_ARG_2_[2] - _ARG_0_[2])) * ((_ARG_1_[2] - _ARG_0_[2]) * (_ARG_2_[3] - _ARG_0_[3]) - (_ARG_1_[3] - _ARG_0_[3]) * (_ARG_2_[2] - _ARG_0_[2])) + ((_ARG_1_[3] - _ARG_0_[3]) * (_ARG_2_[1] - _ARG_0_[1]) - (_ARG_1_[1] - _ARG_0_[1]) * (_ARG_2_[3] - _ARG_0_[3])) * ((_ARG_1_[3] - _ARG_0_[3]) * (_ARG_2_[1] - _ARG_0_[1]) - (_ARG_1_[1] - _ARG_0_[1]) * (_ARG_2_[3] - _ARG_0_[3])) + ((_ARG_1_[1] - _ARG_0_[1]) * (_ARG_2_[2] - _ARG_0_[2]) - (_ARG_1_[2] - _ARG_0_[2]) * (_ARG_2_[1] - _ARG_0_[1])) * ((_ARG_1_[1] - _ARG_0_[1]) * (_ARG_2_[2] - _ARG_0_[2]) - (_ARG_1_[2] - _ARG_0_[2]) * (_ARG_2_[1] - _ARG_0_[1])))
end
function computeLineDistance(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_, _ARG_5_, _ARG_6_, _ARG_7_, _ARG_8_)
  return getDistanceBetweenPoints3D(_ARG_3_ + ((_ARG_0_ - _ARG_3_) * ((_ARG_6_ - _ARG_3_) / getDistanceBetweenPoints3D(_ARG_6_, _ARG_7_, _ARG_8_, _ARG_3_, _ARG_4_, _ARG_5_)) + (_ARG_1_ - _ARG_4_) * ((_ARG_7_ - _ARG_4_) / getDistanceBetweenPoints3D(_ARG_6_, _ARG_7_, _ARG_8_, _ARG_3_, _ARG_4_, _ARG_5_)) + (_ARG_2_ - _ARG_5_) * ((_ARG_8_ - _ARG_5_) / getDistanceBetweenPoints3D(_ARG_6_, _ARG_7_, _ARG_8_, _ARG_3_, _ARG_4_, _ARG_5_))) * ((_ARG_6_ - _ARG_3_) / getDistanceBetweenPoints3D(_ARG_6_, _ARG_7_, _ARG_8_, _ARG_3_, _ARG_4_, _ARG_5_)), _ARG_4_ + ((_ARG_0_ - _ARG_3_) * ((_ARG_6_ - _ARG_3_) / getDistanceBetweenPoints3D(_ARG_6_, _ARG_7_, _ARG_8_, _ARG_3_, _ARG_4_, _ARG_5_)) + (_ARG_1_ - _ARG_4_) * ((_ARG_7_ - _ARG_4_) / getDistanceBetweenPoints3D(_ARG_6_, _ARG_7_, _ARG_8_, _ARG_3_, _ARG_4_, _ARG_5_)) + (_ARG_2_ - _ARG_5_) * ((_ARG_8_ - _ARG_5_) / getDistanceBetweenPoints3D(_ARG_6_, _ARG_7_, _ARG_8_, _ARG_3_, _ARG_4_, _ARG_5_))) * ((_ARG_7_ - _ARG_4_) / getDistanceBetweenPoints3D(_ARG_6_, _ARG_7_, _ARG_8_, _ARG_3_, _ARG_4_, _ARG_5_)), _ARG_5_ + ((_ARG_0_ - _ARG_3_) * ((_ARG_6_ - _ARG_3_) / getDistanceBetweenPoints3D(_ARG_6_, _ARG_7_, _ARG_8_, _ARG_3_, _ARG_4_, _ARG_5_)) + (_ARG_1_ - _ARG_4_) * ((_ARG_7_ - _ARG_4_) / getDistanceBetweenPoints3D(_ARG_6_, _ARG_7_, _ARG_8_, _ARG_3_, _ARG_4_, _ARG_5_)) + (_ARG_2_ - _ARG_5_) * ((_ARG_8_ - _ARG_5_) / getDistanceBetweenPoints3D(_ARG_6_, _ARG_7_, _ARG_8_, _ARG_3_, _ARG_4_, _ARG_5_))) * ((_ARG_8_ - _ARG_5_) / getDistanceBetweenPoints3D(_ARG_6_, _ARG_7_, _ARG_8_, _ARG_3_, _ARG_4_, _ARG_5_)), _ARG_0_, _ARG_1_, _ARG_2_), _ARG_3_ + ((_ARG_0_ - _ARG_3_) * ((_ARG_6_ - _ARG_3_) / getDistanceBetweenPoints3D(_ARG_6_, _ARG_7_, _ARG_8_, _ARG_3_, _ARG_4_, _ARG_5_)) + (_ARG_1_ - _ARG_4_) * ((_ARG_7_ - _ARG_4_) / getDistanceBetweenPoints3D(_ARG_6_, _ARG_7_, _ARG_8_, _ARG_3_, _ARG_4_, _ARG_5_)) + (_ARG_2_ - _ARG_5_) * ((_ARG_8_ - _ARG_5_) / getDistanceBetweenPoints3D(_ARG_6_, _ARG_7_, _ARG_8_, _ARG_3_, _ARG_4_, _ARG_5_))) * ((_ARG_6_ - _ARG_3_) / getDistanceBetweenPoints3D(_ARG_6_, _ARG_7_, _ARG_8_, _ARG_3_, _ARG_4_, _ARG_5_)), _ARG_4_ + ((_ARG_0_ - _ARG_3_) * ((_ARG_6_ - _ARG_3_) / getDistanceBetweenPoints3D(_ARG_6_, _ARG_7_, _ARG_8_, _ARG_3_, _ARG_4_, _ARG_5_)) + (_ARG_1_ - _ARG_4_) * ((_ARG_7_ - _ARG_4_) / getDistanceBetweenPoints3D(_ARG_6_, _ARG_7_, _ARG_8_, _ARG_3_, _ARG_4_, _ARG_5_)) + (_ARG_2_ - _ARG_5_) * ((_ARG_8_ - _ARG_5_) / getDistanceBetweenPoints3D(_ARG_6_, _ARG_7_, _ARG_8_, _ARG_3_, _ARG_4_, _ARG_5_))) * ((_ARG_7_ - _ARG_4_) / getDistanceBetweenPoints3D(_ARG_6_, _ARG_7_, _ARG_8_, _ARG_3_, _ARG_4_, _ARG_5_)), _ARG_5_ + ((_ARG_0_ - _ARG_3_) * ((_ARG_6_ - _ARG_3_) / getDistanceBetweenPoints3D(_ARG_6_, _ARG_7_, _ARG_8_, _ARG_3_, _ARG_4_, _ARG_5_)) + (_ARG_1_ - _ARG_4_) * ((_ARG_7_ - _ARG_4_) / getDistanceBetweenPoints3D(_ARG_6_, _ARG_7_, _ARG_8_, _ARG_3_, _ARG_4_, _ARG_5_)) + (_ARG_2_ - _ARG_5_) * ((_ARG_8_ - _ARG_5_) / getDistanceBetweenPoints3D(_ARG_6_, _ARG_7_, _ARG_8_, _ARG_3_, _ARG_4_, _ARG_5_))) * ((_ARG_8_ - _ARG_5_) / getDistanceBetweenPoints3D(_ARG_6_, _ARG_7_, _ARG_8_, _ARG_3_, _ARG_4_, _ARG_5_))
end
function checkCoroutineTime()
  if coroutine.running() and mineAssets and getTickCount() - mineAssets > 0 and getTickCount() - _UPVALUE1_ < 4000 then
    coroutine.yield()
  end
end
function generateOpenShaftDff(_ARG_0_, _ARG_1_, _ARG_2_)
  _ARG_0_ = _ARG_1_ or mineAssets or _ARG_0_
  _UPVALUE1_[_ARG_0_] = nil
  if _UPVALUE2_[_ARG_0_] then
    removeFromDffExportQueue(_ARG_0_)
    table.insert(_UPVALUE3_, {shaftId = _ARG_0_, exportStage = 0})
    return true
  end
  if _ARG_2_ or mineAssets then
    checkCoroutineTime()
  end
  generateRandomMDVD(_ARG_0_, {}, {})
  for _FORV_9_ = 1, wallBlockCount do
    processZoneDistance(_ARG_0_, _UPVALUE4_[_ARG_0_], {}, {}, _FORV_9_)
    if _ARG_2_ or mineAssets then
      checkCoroutineTime()
    end
  end
  for _FORV_10_ = 1, wallVertexCount do
  end
  if 0 < math.min(wallMaximumDepth, ({})[_FORV_10_]) then
    for _FORV_10_ = 1, wallVertexCount do
      ({})[_FORV_10_] = math.max(0, ({})[_FORV_10_] - math.min(wallMaximumDepth, ({})[_FORV_10_]))
    end
    _UPVALUE5_[_ARG_0_] = _UPVALUE5_[_ARG_0_] + math.min(wallMaximumDepth, ({})[_FORV_10_])
    for _FORV_10_ = 1, wallBlockCount do
      _UPVALUE4_[_ARG_0_][_FORV_10_] = _UPVALUE4_[_ARG_0_][_FORV_10_] - math.min(wallMaximumDepth, ({})[_FORV_10_])
    end
  end
  if _ARG_2_ or mineAssets then
    checkCoroutineTime()
  end
  for _FORV_15_ = 1, wallVertexCount do
    ({})[_FORV_15_] = {
      0 + (unpack(_UPVALUE7_[_FORV_15_]) / wallTextureWidth - 0.5) * wallMeshWidth * _UPVALUE6_[_ARG_0_][4] + ({})[_FORV_15_] * _UPVALUE6_[_ARG_0_][3],
      0 - (unpack(_UPVALUE7_[_FORV_15_]) / wallTextureWidth - 0.5) * wallMeshWidth * _UPVALUE6_[_ARG_0_][3] + ({})[_FORV_15_] * _UPVALUE6_[_ARG_0_][4],
      0 + unpack(_UPVALUE7_[_FORV_15_]) / wallTextureHeight * wallMeshHeight,
      0,
      -(unpack(_UPVALUE7_[_FORV_15_]) / wallTextureWidth),
      -(unpack(_UPVALUE7_[_FORV_15_]) / wallTextureHeight)
    }
    if _ARG_2_ or mineAssets then
      checkCoroutineTime()
    end
  end
  for _FORV_15_ = 1, wallVertexCount, 3 do
    ({})[_FORV_15_] = {
      calculateSurfaceNormal(({})[_FORV_15_], ({})[_FORV_15_ + 1], ({})[_FORV_15_ + 2])
    }
    if _ARG_2_ or mineAssets then
      checkCoroutineTime()
    end
  end
  for _FORV_15_ in pairs(_UPVALUE8_) do
    for _FORV_22_ = 1, #_UPVALUE8_[_FORV_15_] do
      if _ARG_2_ or mineAssets then
        checkCoroutineTime()
      end
    end
    ;({})[_FORV_15_] = {
      -(0 + ({})[_UPVALUE8_[_FORV_15_][_FORV_22_]][1]) / _FOR_.sqrt((0 + ({})[_UPVALUE8_[_FORV_15_][_FORV_22_]][1]) * (0 + ({})[_UPVALUE8_[_FORV_15_][_FORV_22_]][1]) + (0 + ({})[_UPVALUE8_[_FORV_15_][_FORV_22_]][2]) * (0 + ({})[_UPVALUE8_[_FORV_15_][_FORV_22_]][2]) + (0 + ({})[_UPVALUE8_[_FORV_15_][_FORV_22_]][3]) * (0 + ({})[_UPVALUE8_[_FORV_15_][_FORV_22_]][3])),
      -(0 + ({})[_UPVALUE8_[_FORV_15_][_FORV_22_]][2]) / _FOR_.sqrt((0 + ({})[_UPVALUE8_[_FORV_15_][_FORV_22_]][1]) * (0 + ({})[_UPVALUE8_[_FORV_15_][_FORV_22_]][1]) + (0 + ({})[_UPVALUE8_[_FORV_15_][_FORV_22_]][2]) * (0 + ({})[_UPVALUE8_[_FORV_15_][_FORV_22_]][2]) + (0 + ({})[_UPVALUE8_[_FORV_15_][_FORV_22_]][3]) * (0 + ({})[_UPVALUE8_[_FORV_15_][_FORV_22_]][3])),
      -(0 + ({})[_UPVALUE8_[_FORV_15_][_FORV_22_]][3]) / _FOR_.sqrt((0 + ({})[_UPVALUE8_[_FORV_15_][_FORV_22_]][1]) * (0 + ({})[_UPVALUE8_[_FORV_15_][_FORV_22_]][1]) + (0 + ({})[_UPVALUE8_[_FORV_15_][_FORV_22_]][2]) * (0 + ({})[_UPVALUE8_[_FORV_15_][_FORV_22_]][2]) + (0 + ({})[_UPVALUE8_[_FORV_15_][_FORV_22_]][3]) * (0 + ({})[_UPVALUE8_[_FORV_15_][_FORV_22_]][3]))
    }
    if _ARG_2_ or mineAssets then
      checkCoroutineTime()
    end
  end
  _UPVALUE9_[_ARG_0_] = {
    minePosX + _UPVALUE10_[_ARG_0_][1] * 6 + (_UPVALUE5_[_ARG_0_] - 3) * _UPVALUE6_[_ARG_0_][3],
    minePosY + _UPVALUE10_[_ARG_0_][2] * 6 + (_UPVALUE5_[_ARG_0_] - 3) * _UPVALUE6_[_ARG_0_][4]
  }
  if _ARG_2_ or mineAssets then
    checkCoroutineTime()
  end
  if not _ARG_1_ then
    removeFromDffExportQueue(_ARG_0_)
    table.insert(_UPVALUE3_, {
      shaftId = _ARG_0_,
      vertexData = {},
      vertexNormals = {},
      exportStage = 0,
      exportBuffer = {},
      exportSize = 0,
      numVertices = 0,
      numTriangles = 0
    })
  end
  _UPVALUE11_[_ARG_0_] = getTickCount()
  collectgarbage()
  return true
end
function processDffExportQueue()
  if mineAssets[1] then
    mineAssets[1].exportStage = mineAssets[1].exportStage + 1
    if _UPVALUE1_[mineAssets[1].shaftId] and mineAssets[1].exportStage < 10 then
      mineAssets[1].exportStage = 10
      mineAssets[1].exportBuffer = nil
    end
    if mineAssets[1].exportStage == 1 then
      _UPVALUE1_[mineAssets[1].shaftId] = nil
      _UPVALUE2_[mineAssets[1].shaftId] = true
      for _FORV_10_ in pairs(_UPVALUE3_) do
        ({})[_FORV_10_] = 0
        checkCoroutineTime()
      end
      mineAssets[1].vertexIds = {}
      mineAssets[1].centerX = (0 + mineAssets[1].vertexData[_FORV_10_][1]) / (0 + 1)
      mineAssets[1].centerY = (0 + mineAssets[1].vertexData[_FORV_10_][2]) / (0 + 1)
      mineAssets[1].numVertices, mineAssets[1].centerZ = 0 + 1, (0 + mineAssets[1].vertexData[_FORV_10_][3]) / (0 + 1)
      mineAssets[1].numTriangles = math.floor(wallVertexCount / 3)
      mineAssets[1].exportSize = 8 + 32 * mineAssets[1].numVertices + 16 + 8 * mineAssets[1].numTriangles
    elseif mineAssets[1].exportStage == 2 then
      mineAssets[1].exportBuffer[1] = "\016\000\000\000"
      mineAssets[1].exportBuffer[2] = convertUInt32(456 + mineAssets[1].exportSize)
      mineAssets[1].exportBuffer[3] = "\255\255\003\024\001\000\000\000\f\000\000\000\255\255\003\024\001\000\000\000\000\000\000\000\000\000\000\000\014\000\000\000h\000\000\000\255\255\003\024\001\000\000\000<\000\000\000\255\255\003\024\001\000\000\000\000\000\128?\000\000\000\000\000\000\000\000\000\000\000\000\000\000\128?\000\000\000\000\000\000\000\000\000\000\000\000\000\000\128?\000\000\000\000\000\000\000\000\000\000\000\000\255\255\255\255\000\000\000\000\003\000\000\000\020\000\000\000\255\255\003\024\254\242S\002\b\000\000\000\255\255\003\024Plane\000\000\000\026\000\000\000"
      checkCoroutineTime()
      mineAssets[1].exportBuffer[4] = convertUInt32(240 + mineAssets[1].exportSize)
      mineAssets[1].exportBuffer[5] = "\255\255\003\024\001\000\000\000\004\000\000\000\255\255\003\024\001\000\000\000\015\000\000\000"
      checkCoroutineTime()
      mineAssets[1].exportBuffer[6] = convertUInt32(212 + mineAssets[1].exportSize)
      mineAssets[1].exportBuffer[7] = "\255\255\003\024\001\000\000\000"
      checkCoroutineTime()
      mineAssets[1].exportBuffer[8] = convertUInt32(16 + mineAssets[1].exportSize)
      mineAssets[1].exportBuffer[9] = "\255\255\003\024v\000\000\000"
      checkCoroutineTime()
      mineAssets[1].exportBuffer[10] = convertUInt32(mineAssets[1].numTriangles)
      mineAssets[1].exportBuffer[11] = convertUInt32(mineAssets[1].numVertices)
      mineAssets[1].exportBuffer[12] = "\001\000\000\000"
      checkCoroutineTime()
    elseif mineAssets[1].exportStage == 3 then
      for _FORV_5_ in pairs(_UPVALUE3_) do
        table.insert(mineAssets[1].exportBuffer, convertFloat32(mineAssets[1].vertexData[_FORV_5_][5]))
        table.insert(mineAssets[1].exportBuffer, convertFloat32(mineAssets[1].vertexData[_FORV_5_][6]))
        checkCoroutineTime()
      end
    elseif mineAssets[1].exportStage == 4 then
      for _FORV_5_ = 1, wallVertexCount, 3 do
        table.insert(mineAssets[1].exportBuffer, convertUInt16(mineAssets[1].vertexIds[_UPVALUE4_[_FORV_5_ + 1]]))
        table.insert(mineAssets[1].exportBuffer, convertUInt16(mineAssets[1].vertexIds[_UPVALUE4_[_FORV_5_ + 2]]))
        checkCoroutineTime()
        table.insert(mineAssets[1].exportBuffer, convertUInt16(0))
        table.insert(mineAssets[1].exportBuffer, convertUInt16(mineAssets[1].vertexIds[_UPVALUE4_[_FORV_5_]]))
        checkCoroutineTime()
      end
    elseif mineAssets[1].exportStage == 5 then
      for _FORV_6_ in pairs(_UPVALUE3_) do
        checkCoroutineTime()
      end
      table.insert(mineAssets[1].exportBuffer, convertFloat32(mineAssets[1].centerX))
      table.insert(mineAssets[1].exportBuffer, convertFloat32(mineAssets[1].centerY))
      table.insert(mineAssets[1].exportBuffer, convertFloat32(mineAssets[1].centerZ))
      table.insert(mineAssets[1].exportBuffer, convertFloat32((getDistanceBetweenPoints3D(mineAssets[1].centerX, mineAssets[1].centerY, mineAssets[1].centerZ, mineAssets[1].vertexData[_FORV_6_][1], mineAssets[1].vertexData[_FORV_6_][2], mineAssets[1].vertexData[_FORV_6_][3]))))
      table.insert(mineAssets[1].exportBuffer, "\001\000\000\000\001\000\000\000")
      checkCoroutineTime()
    elseif mineAssets[1].exportStage == 6 then
      for _FORV_5_ in pairs(_UPVALUE3_) do
        table.insert(mineAssets[1].exportBuffer, convertFloat32(mineAssets[1].vertexData[_FORV_5_][1]))
        table.insert(mineAssets[1].exportBuffer, convertFloat32(mineAssets[1].vertexData[_FORV_5_][2]))
        table.insert(mineAssets[1].exportBuffer, convertFloat32(mineAssets[1].vertexData[_FORV_5_][3]))
        checkCoroutineTime()
      end
    elseif mineAssets[1].exportStage == 7 then
      for _FORV_5_ in pairs(_UPVALUE3_) do
        table.insert(mineAssets[1].exportBuffer, convertFloat32(mineAssets[1].vertexNormals[_FORV_5_][1]))
        table.insert(mineAssets[1].exportBuffer, convertFloat32(mineAssets[1].vertexNormals[_FORV_5_][2]))
        table.insert(mineAssets[1].exportBuffer, convertFloat32(mineAssets[1].vertexNormals[_FORV_5_][3]))
        checkCoroutineTime()
      end
    elseif mineAssets[1].exportStage == 8 then
      mineAssets[1].exportBuffer[#mineAssets[1].exportBuffer + 1] = "\b\000\000\000\160\000\000\000\255\255\003\024\001\000\000\000\b\000\000\000\255\255\003\024\001\000\000\000\255\255\255\255\a\000\000\000\128\000\000\000\255\255\003\024\001\000\000\000\028\000\000\000\255\255\003\024\000\000\000\000\255\255\255\255\001\000\000\000\001\000\000\000\000\000\128?\000\000\000?\000\000\000?\006\000\000\000@\000\000\000\255\255\003\024\001\000\000\000\004\000\000\000\255\255\003\024\000\000\000\000\002\000\000\000\b\000\000\000\255\255\003\024wall\000\000\000\000\002\000\000\000\004\000\000\000\255\255\003\024\000\000\000\000\003\000\000\000\000\000\000\000\255\255\003\024\003\000\000\000\000\000\000\000\255\255\003\024\003\000\000\000\000\000\000\000\255\255\003\024\020\000\000\000(\000\000\000\255\255\003\024\001\000\000\000\016\000\000\000\255\255\003\024\000\000\000\000\000\000\000\000\004\000\000\000\000\000\000\000\003\000\000\000\000\000\000\000\255\255\003\024\003\000\000\000\000\000\000\000\255\255\003\024"
      mineAssets[1].exportBuffer = table.concat(mineAssets[1].exportBuffer)
    elseif mineAssets[1].exportStage == 9 then
      if fileCreate("cache/" .. mineAssets[1].shaftId .. ".see") then
        fileWrite(fileCreate("cache/" .. mineAssets[1].shaftId .. ".see"), mineAssets[1].exportBuffer)
        fileClose((fileCreate("cache/" .. mineAssets[1].shaftId .. ".see")))
      end
      _UPVALUE1_[mineAssets[1].shaftId] = true
    elseif mineAssets[1].exportStage == 10 then
      mineAssets[1].modelId = poolGetModel()
      if mineAssets[1].modelId then
        engineImportTXD(_UPVALUE5_, mineAssets[1].modelId)
        engineReplaceCOL(_UPVALUE6_, mineAssets[1].modelId)
      end
      checkCoroutineTime()
    elseif mineAssets[1].exportStage == 11 then
      mineAssets[1].dffData = engineLoadDFF(mineAssets[1].exportBuffer or "cache/" .. mineAssets[1].shaftId .. ".see")
      if mineAssets[1].dffData then
        engineReplaceModel(mineAssets[1].dffData, mineAssets[1].modelId)
      end
      mineAssets[1].exportBuffer = nil
    elseif mineAssets[1].exportStage == 12 then
      if not mineAssets[1].objectElement then
        if isElement((createObject(mineAssets[1].modelId, _UPVALUE7_[mineAssets[1].shaftId][1], _UPVALUE7_[mineAssets[1].shaftId][2], minePosZ))) then
          setElementInterior(createObject(mineAssets[1].modelId, _UPVALUE7_[mineAssets[1].shaftId][1], _UPVALUE7_[mineAssets[1].shaftId][2], minePosZ), 0)
          setElementDimension(createObject(mineAssets[1].modelId, _UPVALUE7_[mineAssets[1].shaftId][1], _UPVALUE7_[mineAssets[1].shaftId][2], minePosZ), currentMine)
          setElementCollisionsEnabled(createObject(mineAssets[1].modelId, _UPVALUE7_[mineAssets[1].shaftId][1], _UPVALUE7_[mineAssets[1].shaftId][2], minePosZ), false)
        end
        mineAssets[1].objectElement = createObject(mineAssets[1].modelId, _UPVALUE7_[mineAssets[1].shaftId][1], _UPVALUE7_[mineAssets[1].shaftId][2], minePosZ)
      end
    elseif mineAssets[1].exportStage == 13 then
      if isElement(_UPVALUE8_[mineAssets[1].shaftId]) then
        destroyElement(_UPVALUE8_[mineAssets[1].shaftId])
      end
      if _UPVALUE9_[mineAssets[1].shaftId] then
        poolFreeModel(_UPVALUE9_[mineAssets[1].shaftId])
      end
      if isElement(_UPVALUE10_[mineAssets[1].shaftId]) then
        destroyElement(_UPVALUE10_[mineAssets[1].shaftId])
      end
      checkCoroutineTime()
      _UPVALUE8_[mineAssets[1].shaftId] = mineAssets[1].dffData
      _UPVALUE9_[mineAssets[1].shaftId] = mineAssets[1].modelId
      _UPVALUE10_[mineAssets[1].shaftId] = mineAssets[1].objectElement
      _UPVALUE2_[mineAssets[1].shaftId] = nil
      if isElement(mineAssets[1].objectElement) then
        setElementPosition(mineAssets[1].objectElement, _UPVALUE7_[mineAssets[1].shaftId][1], _UPVALUE7_[mineAssets[1].shaftId][2], minePosZ)
        if mineAssets[1].shaftId == _UPVALUE11_ then
          setElementInterior(_UPVALUE10_[_UPVALUE11_], 0)
          setElementDimension(_UPVALUE10_[_UPVALUE11_], 0)
        end
      end
      table.remove(mineAssets, 1)
    end
  end
  collectgarbage()
end
function convertFloat32(_ARG_0_)
  if _ARG_0_ == 0 then
    return string.char(0, 0, 0, 0)
  elseif _ARG_0_ ~= _ARG_0_ then
    return string.char(255, 255, 255, 255)
  else
    if _ARG_0_ < 0 then
      _ARG_0_ = -_ARG_0_
    end
    if 0 >= math.frexp(_ARG_0_) + 127 then
    elseif 0 < 0 then
      if 0 >= 255 then
        return string.char(128 + 127, 128, 0, 0)
      elseif 0 == 1 then
      else
      end
    end
    return string.char(math.floor(math.ldexp(math.ldexp(math.frexp(_ARG_0_)) * 2 - 1, 23) + 0.5) % 256, math.floor(math.floor(math.ldexp(math.ldexp(math.frexp(_ARG_0_)) * 2 - 1, 23) + 0.5) / 256) % 256, (0 - 1) % 2 * 128 + math.floor(math.floor(math.ldexp(math.ldexp(math.frexp(_ARG_0_)) * 2 - 1, 23) + 0.5) / 65536), 128 + math.floor((0 - 1) / 2))
  end
end
function convertUInt16(_ARG_0_)
  return string.char(_ARG_0_ % 256) .. string.char(math.floor(_ARG_0_ / 256) % 256)
end
function convertUInt32(_ARG_0_)
  return string.char(_ARG_0_ % 256) .. string.char(math.floor(_ARG_0_ / 256) % 256) .. string.char(math.floor(_ARG_0_ / 65536) % 256) .. string.char(math.floor(_ARG_0_ / 16777216) % 256)
end
function calculateBase()
  if mineAssets then
    return
  end
  for _FORV_5_ = 1, wallVertexNumX do
    checkMineLoadingTime()
    for _FORV_9_ = 1, wallVertexNumY do
      table.insert(_UPVALUE1_, {
        wallTextureWidth / wallVertexNumX * _FORV_5_,
        wallTextureHeight / wallVertexNumY * (_FORV_9_ - 1),
        _FORV_5_,
        _FORV_9_
      })
      table.insert(_UPVALUE1_, {
        wallTextureWidth / wallVertexNumX * (_FORV_5_ - 1),
        wallTextureHeight / wallVertexNumY * (_FORV_9_ - 1),
        _FORV_5_,
        _FORV_9_
      })
      table.insert(_UPVALUE1_, {
        wallTextureWidth / wallVertexNumX * (_FORV_5_ - 1),
        wallTextureHeight / wallVertexNumY * _FORV_9_,
        _FORV_5_,
        _FORV_9_
      })
      table.insert(_UPVALUE1_, {
        wallTextureWidth / wallVertexNumX * _FORV_5_,
        wallTextureHeight / wallVertexNumY * (_FORV_9_ - 1),
        _FORV_5_,
        _FORV_9_
      })
      table.insert(_UPVALUE1_, {
        wallTextureWidth / wallVertexNumX * (_FORV_5_ - 1),
        wallTextureHeight / wallVertexNumY * _FORV_9_,
        _FORV_5_,
        _FORV_9_
      })
      table.insert(_UPVALUE1_, {
        wallTextureWidth / wallVertexNumX * _FORV_5_,
        wallTextureHeight / wallVertexNumY * _FORV_9_,
        _FORV_5_,
        _FORV_9_
      })
      checkMineLoadingTime()
    end
  end
  wallVertexCount = #_FOR_
  for _FORV_5_ = 1, wallVertexCount, 3 do
    checkMineLoadingTime()
    for _FORV_9_ = 0, 2 do
      _UPVALUE2_[_FORV_5_ + _FORV_9_] = _FORV_5_
    end
  end
  for _FORV_5_ = 1, wallVertexCount do
    for _FORV_11_ = 1, wallVertexCount do
      if not false or false > getDistanceBetweenPoints2D(_UPVALUE1_[_FORV_5_][1], _UPVALUE1_[_FORV_5_][2], _UPVALUE1_[_FORV_11_][1], _UPVALUE1_[_FORV_11_][2]) then
      end
      checkMineLoadingTime()
    end
    loaderText = "Bányafal előkészítése (" .. math.floor(_FORV_5_ / wallVertexCount * 100) .. "%)"
    if not _UPVALUE3_[_FORV_11_] then
      _UPVALUE3_[_FORV_11_] = {}
    end
    _UPVALUE4_[_FORV_5_] = _FORV_11_
    if not _UPVALUE5_[_FORV_11_] then
      _UPVALUE5_[_FORV_11_] = {_FORV_5_}
    else
      table.insert(_UPVALUE5_[_FORV_11_], _FORV_5_)
    end
    checkMineLoadingTime()
  end
  for _FORV_5_ = 1, wallVertexCount do
    for _FORV_11_ = #_UPVALUE3_[_UPVALUE4_[_FORV_5_]], 1, -1 do
      checkMineLoadingTime()
      if _UPVALUE3_[_UPVALUE4_[_FORV_5_]][_FORV_11_] == _UPVALUE2_[_FORV_5_] then
        table.remove(_UPVALUE3_[_UPVALUE4_[_FORV_5_]], _FORV_11_)
      end
    end
    _FOR_.insert(_UPVALUE3_[_UPVALUE4_[_FORV_5_]], _UPVALUE2_[_FORV_5_])
  end
  for _FORV_7_ in pairs(_UPVALUE5_) do
    if not _UPVALUE6_[math.ceil(_UPVALUE1_[_FORV_7_][3] / (wallVertexNumX / wallBlockNumX)) + (math.ceil(_UPVALUE1_[_FORV_7_][4] / (wallVertexNumY / wallBlockNumY)) - 1) * wallBlockNumY] then
      _UPVALUE6_[math.ceil(_UPVALUE1_[_FORV_7_][3] / (wallVertexNumX / wallBlockNumX)) + (math.ceil(_UPVALUE1_[_FORV_7_][4] / (wallVertexNumY / wallBlockNumY)) - 1) * wallBlockNumY] = {_FORV_7_}
    else
      table.insert(_UPVALUE6_[math.ceil(_UPVALUE1_[_FORV_7_][3] / (wallVertexNumX / wallBlockNumX)) + (math.ceil(_UPVALUE1_[_FORV_7_][4] / (wallVertexNumY / wallBlockNumY)) - 1) * wallBlockNumY], _FORV_7_)
    end
    _UPVALUE1_[_FORV_7_][5] = math.ceil(_UPVALUE1_[_FORV_7_][3] / (wallVertexNumX / wallBlockNumX)) + (math.ceil(_UPVALUE1_[_FORV_7_][4] / (wallVertexNumY / wallBlockNumY)) - 1) * wallBlockNumY
  end
  for _FORV_7_ = 1, wallBlockCount do
    checkMineLoadingTime()
    _UPVALUE7_[_FORV_7_] = {
      _UPVALUE6_[_FORV_7_][1],
      _UPVALUE6_[_FORV_7_][1],
      _UPVALUE6_[_FORV_7_][1],
      _UPVALUE6_[_FORV_7_][1]
    }
    for _FORV_14_ = 1, #_UPVALUE6_[_FORV_7_] do
      if _UPVALUE1_[_UPVALUE6_[_FORV_7_][_FORV_14_]][3] < _UPVALUE1_[_UPVALUE7_[_FORV_7_][1]][3] or _UPVALUE1_[_UPVALUE6_[_FORV_7_][_FORV_14_]][4] < _UPVALUE1_[_UPVALUE7_[_FORV_7_][1]][4] then
        _UPVALUE7_[_FORV_7_][1] = _UPVALUE6_[_FORV_7_][_FORV_14_]
      end
      if _UPVALUE1_[_UPVALUE6_[_FORV_7_][_FORV_14_]][3] > _UPVALUE1_[_UPVALUE7_[_FORV_7_][2]][3] or _UPVALUE1_[_UPVALUE6_[_FORV_7_][_FORV_14_]][4] < _UPVALUE1_[_UPVALUE7_[_FORV_7_][2]][4] then
        _UPVALUE7_[_FORV_7_][2] = _UPVALUE6_[_FORV_7_][_FORV_14_]
      end
      if _UPVALUE1_[_UPVALUE6_[_FORV_7_][_FORV_14_]][3] < _UPVALUE1_[_UPVALUE7_[_FORV_7_][3]][3] or _UPVALUE1_[_UPVALUE6_[_FORV_7_][_FORV_14_]][4] > _UPVALUE1_[_UPVALUE7_[_FORV_7_][3]][4] then
        _UPVALUE7_[_FORV_7_][3] = _UPVALUE6_[_FORV_7_][_FORV_14_]
      end
      if _UPVALUE1_[_UPVALUE6_[_FORV_7_][_FORV_14_]][3] > _UPVALUE1_[_UPVALUE7_[_FORV_7_][4]][3] or _UPVALUE1_[_UPVALUE6_[_FORV_7_][_FORV_14_]][4] > _UPVALUE1_[_UPVALUE7_[_FORV_7_][4]][4] then
        _UPVALUE7_[_FORV_7_][4] = _UPVALUE6_[_FORV_7_][_FORV_14_]
      end
      checkMineLoadingTime()
    end
    _UPVALUE8_[_FORV_7_] = {
      (0 + _UPVALUE1_[_UPVALUE6_[_FORV_7_][_FORV_14_]][1] / wallTextureWidth) / (0 + 1),
      (0 + _UPVALUE1_[_UPVALUE6_[_FORV_7_][_FORV_14_]][2] / wallTextureHeight) / (0 + 1)
    }
  end
  for _FORV_7_ in pairs(_UPVALUE5_) do
    _UPVALUE9_[_FORV_7_] = {}
    for _FORV_15_ = 1, wallBlockCount do
      if _FORV_15_ == _UPVALUE1_[_FORV_7_][5] then
        _UPVALUE9_[_FORV_7_][_FORV_15_] = 1
      else
        _UPVALUE9_[_FORV_7_][_FORV_15_] = 1 - math.sqrt(math.max(_UPVALUE1_[_UPVALUE7_[_FORV_15_][1]][1] / wallTextureWidth * wallMeshWidth - _UPVALUE1_[_FORV_7_][1] / wallTextureWidth * wallMeshWidth, 0, _UPVALUE1_[_FORV_7_][1] / wallTextureWidth * wallMeshWidth - _UPVALUE1_[_UPVALUE7_[_FORV_15_][4]][1] / wallTextureWidth * wallMeshWidth) * math.max(_UPVALUE1_[_UPVALUE7_[_FORV_15_][1]][1] / wallTextureWidth * wallMeshWidth - _UPVALUE1_[_FORV_7_][1] / wallTextureWidth * wallMeshWidth, 0, _UPVALUE1_[_FORV_7_][1] / wallTextureWidth * wallMeshWidth - _UPVALUE1_[_UPVALUE7_[_FORV_15_][4]][1] / wallTextureWidth * wallMeshWidth) + math.max(_UPVALUE1_[_UPVALUE7_[_FORV_15_][1]][2] / wallTextureHeight * wallMeshHeight - _UPVALUE1_[_FORV_7_][2] / wallTextureHeight * wallMeshHeight, 0, _UPVALUE1_[_FORV_7_][2] / wallTextureHeight * wallMeshHeight - _UPVALUE1_[_UPVALUE7_[_FORV_15_][4]][2] / wallTextureHeight * wallMeshHeight) * math.max(_UPVALUE1_[_UPVALUE7_[_FORV_15_][1]][2] / wallTextureHeight * wallMeshHeight - _UPVALUE1_[_FORV_7_][2] / wallTextureHeight * wallMeshHeight, 0, _UPVALUE1_[_FORV_7_][2] / wallTextureHeight * wallMeshHeight - _UPVALUE1_[_UPVALUE7_[_FORV_15_][4]][2] / wallTextureHeight * wallMeshHeight)) / 0.5
      end
      checkMineLoadingTime()
    end
    _FOR_()
  end
  loaderText = false
  mineAssets = true
end
function createSortingMachine()
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
  if isElement(mineMachineData.motorSound) then
    setSoundSpeed(mineMachineData.motorSound, math.min(1, math.min(1, mineMachineData.machineRunProgress) / 0.75) * 0.55 + 0.45 + math.max(0, mineMachineData.machineRunProgress - 1) * 1)
    setSoundVolume(mineMachineData.motorSound, math.min(1, math.min(1, mineMachineData.machineRunProgress) / 0.25) * 1.25 + math.max(0, mineMachineData.machineRunProgress - 1) * 0.35)
  end
  if isElement(mineMachineData.beltSound) then
    setSoundSpeed(mineMachineData.beltSound, math.min(1, math.min(1, mineMachineData.machineRunProgress) / 0.75) * 0.55 + 0.45)
    setSoundVolume(mineMachineData.beltSound, math.min(1, math.min(1, mineMachineData.machineRunProgress) / 0.25) * 0.6)
  end
  if isElement(mineMachineData.vibrationSound) then
    setSoundSpeed(mineMachineData.vibrationSound, math.min(1, math.min(1, mineMachineData.machineRunProgress) / 0.75) * 0.55 + 0.45)
    setSoundVolume(mineMachineData.vibrationSound, math.min(1, math.min(1, mineMachineData.machineRunProgress) / 0.25) * 1.2)
  end
  if isElement(mineMachineData.rockSound) then
    setSoundSpeed(mineMachineData.rockSound, (math.min(1, math.min(1, mineMachineData.machineRunProgress) / 0.75) * 0.55 + 0.45) * 1.75)
    setSoundVolume(mineMachineData.rockSound, math.min(1, math.min(1, mineMachineData.machineRunProgress) / 0.25) * (mineMachineData.sortingRocks and 1 or 0) * 0.25)
  end
end
function spawnSorterOre(_ARG_0_, _ARG_1_)
  if isElement((createObject(modelIds.v4_mine_ore_debris2, machinePosX, machinePosY, machinePosZ, 0, -6, 0))) then
    setElementInterior(createObject(modelIds.v4_mine_ore_debris2, machinePosX, machinePosY, machinePosZ, 0, -6, 0), 0)
    setElementDimension(createObject(modelIds.v4_mine_ore_debris2, machinePosX, machinePosY, machinePosZ, 0, -6, 0), currentMine)
  end
  table.insert(mineAssets, {
    objectElement = createObject(modelIds.v4_mine_ore_debris2, machinePosX, machinePosY, machinePosZ, 0, -6, 0),
    currentPosition = -2.849194,
    desiredPosition = 9.373499,
    animationProgress = 0
  })
  if isElement((createObject(modelIds.v4_mine_ore_debris, machinePosX, machinePosY, machinePosZ, 0, -6, 0))) then
    refreshOreShader(createObject(modelIds.v4_mine_ore_debris, machinePosX, machinePosY, machinePosZ, 0, -6, 0), _ARG_0_)
    setElementInterior(createObject(modelIds.v4_mine_ore_debris, machinePosX, machinePosY, machinePosZ, 0, -6, 0), 0)
    setElementDimension(createObject(modelIds.v4_mine_ore_debris, machinePosX, machinePosY, machinePosZ, 0, -6, 0), currentMine)
  end
  table.insert(mineAssets, {
    objectElement = createObject(modelIds.v4_mine_ore_debris, machinePosX, machinePosY, machinePosZ, 0, -6, 0),
    currentPosition = -2.849194,
    desiredPosition = oreTypes[_ARG_0_].sorterOffset,
    animationProgress = 0,
    oreType = _ARG_0_,
    oreAmount = _ARG_1_
  })
end
function checkOreBuffer(_ARG_0_, _ARG_1_)
  if oreTypes[_ARG_0_].bufferContent > 0 and not oreTypes[_ARG_0_].carriedBy and 0 < math.min(1 - oreTypes[_ARG_0_].boxContent, oreTypes[_ARG_0_].bufferContent) then
    shouldRefreshBoxContent = true
    oreTypes[_ARG_0_].bufferContent = oreTypes[_ARG_0_].bufferContent - math.min(1 - oreTypes[_ARG_0_].boxContent, oreTypes[_ARG_0_].bufferContent)
    oreTypes[_ARG_0_].boxContent = oreTypes[_ARG_0_].boxContent + math.min(1 - oreTypes[_ARG_0_].boxContent, oreTypes[_ARG_0_].bufferContent)
    if _ARG_1_ then
      oreTypes[_ARG_0_].displayedBoxContent = oreTypes[_ARG_0_].boxContent
    else
      if isElement((playSound3D("files/sounds/orepour" .. math.random(1, 2) .. ".wav", minePosX - 15.8384 - oreTypes[_ARG_0_].sorterOffset, minePosY + 7.4428 - 1.0574, minePosZ + 1.7338 - 1.6562, true))) then
        setElementInterior(playSound3D("files/sounds/orepour" .. math.random(1, 2) .. ".wav", minePosX - 15.8384 - oreTypes[_ARG_0_].sorterOffset, minePosY + 7.4428 - 1.0574, minePosZ + 1.7338 - 1.6562, true), 0)
        setElementDimension(playSound3D("files/sounds/orepour" .. math.random(1, 2) .. ".wav", minePosX - 15.8384 - oreTypes[_ARG_0_].sorterOffset, minePosY + 7.4428 - 1.0574, minePosZ + 1.7338 - 1.6562, true), currentMine)
      end
      table.insert(mineAssets, {
        playSound3D("files/sounds/orepour" .. math.random(1, 2) .. ".wav", minePosX - 15.8384 - oreTypes[_ARG_0_].sorterOffset, minePosY + 7.4428 - 1.0574, minePosZ + 1.7338 - 1.6562, true),
        getTickCount() + math.min(1 - oreTypes[_ARG_0_].boxContent, oreTypes[_ARG_0_].bufferContent) * 10000,
        0,
        minePosX - 15.8384 - oreTypes[_ARG_0_].sorterOffset,
        minePosY + 7.4428 - 1.0574,
        minePosZ + 1.7338 - 1.6562
      })
    end
    return true
  end
end
function refreshOreBoxScale(_ARG_0_)
  if oreTypes[_ARG_0_] then
    if isElement(oreTypes[_ARG_0_].boxContentElement) then
      if oreTypes[_ARG_0_].displayedBoxContent > 0.05 then
        setObjectScale(oreTypes[_ARG_0_].boxContentElement, oreTypes[_ARG_0_].carriedBy and 0.75 or 1, oreTypes[_ARG_0_].carriedBy and 0.75 or 1, (0.085 + (oreTypes[_ARG_0_].displayedBoxContent - 0.05) / 0.95 * 0.915) * (oreTypes[_ARG_0_].carriedBy and 0.75 or 1))
      elseif oreTypes[_ARG_0_].displayedBoxContent > 0 then
        setObjectScale(oreTypes[_ARG_0_].boxContentElement, oreTypes[_ARG_0_].carriedBy and 0.75 or 1, oreTypes[_ARG_0_].carriedBy and 0.75 or 1, 0.085 * oreTypes[_ARG_0_].displayedBoxContent / 0.05 * (oreTypes[_ARG_0_].carriedBy and 0.75 or 1))
      else
        setObjectScale(oreTypes[_ARG_0_].boxContentElement, oreTypes[_ARG_0_].carriedBy and 0.75 or 1, oreTypes[_ARG_0_].carriedBy and 0.75 or 1, 0)
      end
    end
  end
end
;(function(_ARG_0_, _ARG_1_, _ARG_2_)
  addEvent(_ARG_0_, true)
  addEventHandler(_ARG_0_, _ARG_1_, function(_ARG_0_, ...)
    if not loadingMineExit then
      if loadingMineEnter then
        if _ARG_0_ == loadingMineEnter then
          table.insert(mineAssets, {
            eventName = _UPVALUE1_,
            handlerFunction = _UPVALUE2_,
            handlerFunctionParams = {
              ...
            },
            sourceElement = source
          })
        end
      elseif _ARG_0_ == currentMine then
        _UPVALUE2_(_ARG_0_, ...)
      end
    end
  end)
end)("syncMineOreItemOutput", root, function(_ARG_0_, _ARG_1_)
  if oreTypes[_ARG_1_] then
    if oreTypes[_ARG_1_].ingotPosition then
    else
    end
    if isElement((playSound3D("files/sounds/furnacedonepick.wav", unpack(oreTypes[_ARG_1_].boxPosition)))) then
      setElementInterior(playSound3D("files/sounds/furnacedonepick.wav", unpack(oreTypes[_ARG_1_].boxPosition)), 0)
      setElementDimension(playSound3D("files/sounds/furnacedonepick.wav", unpack(oreTypes[_ARG_1_].boxPosition)), currentMine)
    end
    table.insert(oreTypes[_ARG_1_].itemOutput, getTickCount())
  end
end)
;(function(_ARG_0_, _ARG_1_, _ARG_2_)
  addEvent(_ARG_0_, true)
  addEventHandler(_ARG_0_, _ARG_1_, function(_ARG_0_, ...)
    if not loadingMineExit then
      if loadingMineEnter then
        if _ARG_0_ == loadingMineEnter then
          table.insert(mineAssets, {
            eventName = _UPVALUE1_,
            handlerFunction = _UPVALUE2_,
            handlerFunctionParams = {
              ...
            },
            sourceElement = source
          })
        end
      elseif _ARG_0_ == currentMine then
        _UPVALUE2_(_ARG_0_, ...)
      end
    end
  end)
end)("syncMineOreStorageRemove", root, function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  if oreTypes[_ARG_1_] then
    if oreTypes[_ARG_1_].foundryInputPosition then
    else
    end
    if isElement((playSound3D("files/sounds/orepour" .. math.random(1, 2) .. ".wav", unpack(oreTypes[_ARG_1_].boxPosition)))) then
      setElementInterior(playSound3D("files/sounds/orepour" .. math.random(1, 2) .. ".wav", unpack(oreTypes[_ARG_1_].boxPosition)), 0)
      setElementDimension(playSound3D("files/sounds/orepour" .. math.random(1, 2) .. ".wav", unpack(oreTypes[_ARG_1_].boxPosition)), currentMine)
    end
    table.insert(mineAssets, {
      playSound3D("files/sounds/orepour" .. math.random(1, 2) .. ".wav", unpack(oreTypes[_ARG_1_].boxPosition)),
      getTickCount() + _ARG_2_ * 5000,
      0,
      unpack(oreTypes[_ARG_1_].boxPosition)
    })
    if _ARG_3_ and isElement(source) then
      setPedHeadingTo(source, unpack(oreTypes[_ARG_1_].boxPosition))
      setPedAnimation(source, "mining_box_pour", "crry_prtial", -1, true, false, false, false)
    end
    oreTypes[_ARG_1_].boxContent = oreTypes[_ARG_1_].boxContent - _ARG_2_
    if 0 > oreTypes[_ARG_1_].boxContent then
      oreTypes[_ARG_1_].bufferContent = oreTypes[_ARG_1_].bufferContent + oreTypes[_ARG_1_].boxContent
      oreTypes[_ARG_1_].boxContent = 0
    end
    shouldRefreshBoxContent = true
  end
end)
;(function(_ARG_0_, _ARG_1_, _ARG_2_)
  addEvent(_ARG_0_, true)
  addEventHandler(_ARG_0_, _ARG_1_, function(_ARG_0_, ...)
    if not loadingMineExit then
      if loadingMineEnter then
        if _ARG_0_ == loadingMineEnter then
          table.insert(mineAssets, {
            eventName = _UPVALUE1_,
            handlerFunction = _UPVALUE2_,
            handlerFunctionParams = {
              ...
            },
            sourceElement = source
          })
        end
      elseif _ARG_0_ == currentMine then
        _UPVALUE2_(_ARG_0_, ...)
      end
    end
  end)
end)("syncMineFoundryStorage", root, function(_ARG_0_, _ARG_1_, _ARG_2_)
  if oreTypes[_ARG_1_] then
    oreTypes[_ARG_1_].foundryContent = _ARG_2_
  end
  shouldRefreshFoundryContent = true
end)
function syncOreBoxCarry(_ARG_0_, _ARG_1_)
  if oreTypes[_ARG_0_] then
    exports.pattach:detach(oreTypes[_ARG_0_].boxElement)
    exports.pattach:detach(oreTypes[_ARG_0_].boxContentElement)
    if oreTypes[_ARG_0_].carriedBy then
      if isElement(oreTypes[_ARG_0_].boxElement) then
        setObjectScale(oreTypes[_ARG_0_].boxElement, 1)
        setElementPosition(oreTypes[_ARG_0_].boxElement, unpack(oreTypes[_ARG_0_].boxPosition))
        setElementRotation(oreTypes[_ARG_0_].boxElement, 0, 0, 0)
        setElementInterior(oreTypes[_ARG_0_].boxElement, 0)
        setElementDimension(oreTypes[_ARG_0_].boxElement, currentMine)
      end
      if isElement(oreTypes[_ARG_0_].boxContentElement) then
        setElementPosition(oreTypes[_ARG_0_].boxContentElement, unpack(oreTypes[_ARG_0_].boxPosition))
        setElementRotation(oreTypes[_ARG_0_].boxContentElement, 0, 0, 0)
        setElementInterior(oreTypes[_ARG_0_].boxContentElement, 0)
        setElementDimension(oreTypes[_ARG_0_].boxContentElement, currentMine)
      end
      if isElement(oreTypes[_ARG_0_].carriedBy) then
        mineAssets[oreTypes[_ARG_0_].carriedBy] = nil
        setPedHeadingTo(oreTypes[_ARG_0_].carriedBy, unpack(oreTypes[_ARG_0_].boxPosition))
      end
    end
    oreTypes[_ARG_0_].carriedBy = _ARG_1_
    if oreTypes[_ARG_0_].carriedBy and oreTypes[_ARG_0_].carriedBy ~= _ARG_1_ then
      processTablet(oreTypes[_ARG_0_].carriedBy)
    end
    if _ARG_1_ then
      mineAssets[_ARG_1_] = _ARG_0_
      if isElement(oreTypes[_ARG_0_].boxElement) then
        exports.pattach:attach(oreTypes[_ARG_0_].boxElement, _ARG_1_, 24, 0.074790295543729, 0.0069286946121183, -0.13359006135468, 0, 0, 0)
        exports.pattach:setRotationQuaternion(oreTypes[_ARG_0_].boxElement, {
          0.59285355717957,
          0.79791822465736,
          0.079090005564662,
          0.0748059992177
        })
        setObjectScale(oreTypes[_ARG_0_].boxElement, 0.75)
      end
      processTablet(_ARG_1_)
      if isElement(oreTypes[_ARG_0_].boxContentElement) then
        exports.pattach:attach(oreTypes[_ARG_0_].boxContentElement, _ARG_1_, 24, 0.074790295543729, 0.0069286946121183, -0.13359006135468, 0, 0, 0)
        exports.pattach:setRotationQuaternion(oreTypes[_ARG_0_].boxContentElement, {
          0.59285355717957,
          0.79791822465736,
          0.079090005564662,
          0.0748059992177
        })
      end
      setPedAnimation(_ARG_1_, "carry", "crry_prtial", 0, true, false, false, true)
      setPedHeadingTo(_ARG_1_, unpack(oreTypes[_ARG_0_].boxPosition))
    elseif not oreTypes[_ARG_0_].instantItem then
      checkOreBuffer(_ARG_0_)
    end
    if not oreTypes[_ARG_0_].instantItem then
      refreshOreBoxScale(_ARG_0_)
    end
  end
end
;(function(_ARG_0_, _ARG_1_, _ARG_2_)
  addEvent(_ARG_0_, true)
  addEventHandler(_ARG_0_, _ARG_1_, function(_ARG_0_, ...)
    if not loadingMineExit then
      if loadingMineEnter then
        if _ARG_0_ == loadingMineEnter then
          table.insert(mineAssets, {
            eventName = _UPVALUE1_,
            handlerFunction = _UPVALUE2_,
            handlerFunctionParams = {
              ...
            },
            sourceElement = source
          })
        end
      elseif _ARG_0_ == currentMine then
        _UPVALUE2_(_ARG_0_, ...)
      end
    end
  end)
end)("syncMineOreBoxCarry", root, function(_ARG_0_, _ARG_1_)
  if mineAssets[source] then
    if isElement((playSound3D("files/sounds/boxdrop.mp3", unpack(oreTypes[mineAssets[source]].boxPosition)))) then
      setElementInterior(playSound3D("files/sounds/boxdrop.mp3", unpack(oreTypes[mineAssets[source]].boxPosition)), 0)
      setElementDimension(playSound3D("files/sounds/boxdrop.mp3", unpack(oreTypes[mineAssets[source]].boxPosition)), currentMine)
    end
    syncOreBoxCarry(mineAssets[source])
    mineAssets[source] = nil
  end
  if _ARG_1_ then
    if isElement(source) and source ~= resourceRoot then
      if isElement((playSound3D("files/sounds/boxpick.mp3", unpack(oreTypes[_ARG_1_].boxPosition)))) then
        setElementInterior(playSound3D("files/sounds/boxpick.mp3", unpack(oreTypes[_ARG_1_].boxPosition)), 0)
        setElementDimension(playSound3D("files/sounds/boxpick.mp3", unpack(oreTypes[_ARG_1_].boxPosition)), currentMine)
      end
      syncOreBoxCarry(_ARG_1_, source)
    else
      syncOreBoxCarry(_ARG_1_)
    end
  end
end)
;(function(_ARG_0_, _ARG_1_, _ARG_2_)
  addEvent(_ARG_0_, true)
  addEventHandler(_ARG_0_, _ARG_1_, function(_ARG_0_, ...)
    if not loadingMineExit then
      if loadingMineEnter then
        if _ARG_0_ == loadingMineEnter then
          table.insert(mineAssets, {
            eventName = _UPVALUE1_,
            handlerFunction = _UPVALUE2_,
            handlerFunctionParams = {
              ...
            },
            sourceElement = source
          })
        end
      elseif _ARG_0_ == currentMine then
        _UPVALUE2_(_ARG_0_, ...)
      end
    end
  end)
end)("gotMineOpenShaftBomb", root, function(_ARG_0_, _ARG_1_)
  if not openShaftBombs[_ARG_1_] then
    if isElement((createObject(modelIds.v4_mine_dynamite, getShaftBlockPosition(_ARG_1_, math.ceil(wallBlockCount / 2)) - mineAssets[_ARG_1_][3] * 0.25, getShaftBlockPosition(_ARG_1_, math.ceil(wallBlockCount / 2)) - mineAssets[_ARG_1_][4] * 0.25, getShaftBlockPosition(_ARG_1_, math.ceil(wallBlockCount / 2))))) then
      setObjectScale(createObject(modelIds.v4_mine_dynamite, getShaftBlockPosition(_ARG_1_, math.ceil(wallBlockCount / 2)) - mineAssets[_ARG_1_][3] * 0.25, getShaftBlockPosition(_ARG_1_, math.ceil(wallBlockCount / 2)) - mineAssets[_ARG_1_][4] * 0.25, getShaftBlockPosition(_ARG_1_, math.ceil(wallBlockCount / 2))), 3)
      setElementInterior(createObject(modelIds.v4_mine_dynamite, getShaftBlockPosition(_ARG_1_, math.ceil(wallBlockCount / 2)) - mineAssets[_ARG_1_][3] * 0.25, getShaftBlockPosition(_ARG_1_, math.ceil(wallBlockCount / 2)) - mineAssets[_ARG_1_][4] * 0.25, getShaftBlockPosition(_ARG_1_, math.ceil(wallBlockCount / 2))), 0)
      setElementDimension(createObject(modelIds.v4_mine_dynamite, getShaftBlockPosition(_ARG_1_, math.ceil(wallBlockCount / 2)) - mineAssets[_ARG_1_][3] * 0.25, getShaftBlockPosition(_ARG_1_, math.ceil(wallBlockCount / 2)) - mineAssets[_ARG_1_][4] * 0.25, getShaftBlockPosition(_ARG_1_, math.ceil(wallBlockCount / 2))), currentMine)
    end
    if isElement((playSound3D("files/sounds/tntfuse.mp3", getShaftBlockPosition(_ARG_1_, math.ceil(wallBlockCount / 2)) - mineAssets[_ARG_1_][3] * 0.25, getShaftBlockPosition(_ARG_1_, math.ceil(wallBlockCount / 2)) - mineAssets[_ARG_1_][4] * 0.25, getShaftBlockPosition(_ARG_1_, math.ceil(wallBlockCount / 2))))) then
      setElementInterior(playSound3D("files/sounds/tntfuse.mp3", getShaftBlockPosition(_ARG_1_, math.ceil(wallBlockCount / 2)) - mineAssets[_ARG_1_][3] * 0.25, getShaftBlockPosition(_ARG_1_, math.ceil(wallBlockCount / 2)) - mineAssets[_ARG_1_][4] * 0.25, getShaftBlockPosition(_ARG_1_, math.ceil(wallBlockCount / 2))), 0)
      setElementDimension(playSound3D("files/sounds/tntfuse.mp3", getShaftBlockPosition(_ARG_1_, math.ceil(wallBlockCount / 2)) - mineAssets[_ARG_1_][3] * 0.25, getShaftBlockPosition(_ARG_1_, math.ceil(wallBlockCount / 2)) - mineAssets[_ARG_1_][4] * 0.25, getShaftBlockPosition(_ARG_1_, math.ceil(wallBlockCount / 2))), currentMine)
    end
    openShaftBombs[_ARG_1_] = {
      createObject(modelIds.v4_mine_dynamite, getShaftBlockPosition(_ARG_1_, math.ceil(wallBlockCount / 2)) - mineAssets[_ARG_1_][3] * 0.25, getShaftBlockPosition(_ARG_1_, math.ceil(wallBlockCount / 2)) - mineAssets[_ARG_1_][4] * 0.25, getShaftBlockPosition(_ARG_1_, math.ceil(wallBlockCount / 2))),
      mineAssets[_ARG_1_][4],
      -mineAssets[_ARG_1_][3],
      0,
      getShaftBlockPosition(_ARG_1_, math.ceil(wallBlockCount / 2)) - mineAssets[_ARG_1_][3] * 0.25,
      getShaftBlockPosition(_ARG_1_, math.ceil(wallBlockCount / 2)) - mineAssets[_ARG_1_][4] * 0.25,
      getShaftBlockPosition(_ARG_1_, math.ceil(wallBlockCount / 2))
    }
  end
  if source ~= resourceRoot then
    setPedHeadingTo(source, getShaftBlockPosition(_ARG_1_, math.ceil(wallBlockCount / 2)) - mineAssets[_ARG_1_][3] * 0.25, getShaftBlockPosition(_ARG_1_, math.ceil(wallBlockCount / 2)) - mineAssets[_ARG_1_][4] * 0.25)
  end
end)
;(function(_ARG_0_, _ARG_1_, _ARG_2_)
  addEvent(_ARG_0_, true)
  addEventHandler(_ARG_0_, _ARG_1_, function(_ARG_0_, ...)
    if not loadingMineExit then
      if loadingMineEnter then
        if _ARG_0_ == loadingMineEnter then
          table.insert(mineAssets, {
            eventName = _UPVALUE1_,
            handlerFunction = _UPVALUE2_,
            handlerFunctionParams = {
              ...
            },
            sourceElement = source
          })
        end
      elseif _ARG_0_ == currentMine then
        _UPVALUE2_(_ARG_0_, ...)
      end
    end
  end)
end)("detonateMineOpenShaftBomb", root, function(_ARG_0_, _ARG_1_)
  if openShaftBombs[_ARG_1_] then
    table.insert(bombDetonations, {
      openShaftBombs[_ARG_1_][5],
      openShaftBombs[_ARG_1_][6],
      openShaftBombs[_ARG_1_][7],
      0
    })
    spawnSmokeExBg(openShaftBombs[_ARG_1_][5], openShaftBombs[_ARG_1_][6], openShaftBombs[_ARG_1_][7], true)
    detonateDamage(openShaftBombs[_ARG_1_][5], openShaftBombs[_ARG_1_][6], openShaftBombs[_ARG_1_][7])
    if isElement(openShaftBombs[_ARG_1_][1]) then
      destroyElement(openShaftBombs[_ARG_1_][1])
    end
    openShaftBombs[_ARG_1_][1] = nil
  end
  openShaftBombs[_ARG_1_] = nil
end)
;(function(_ARG_0_, _ARG_1_, _ARG_2_)
  addEvent(_ARG_0_, true)
  addEventHandler(_ARG_0_, _ARG_1_, function(_ARG_0_, ...)
    if not loadingMineExit then
      if loadingMineEnter then
        if _ARG_0_ == loadingMineEnter then
          table.insert(mineAssets, {
            eventName = _UPVALUE1_,
            handlerFunction = _UPVALUE2_,
            handlerFunctionParams = {
              ...
            },
            sourceElement = source
          })
        end
      elseif _ARG_0_ == currentMine then
        _UPVALUE2_(_ARG_0_, ...)
      end
    end
  end)
end)("gotMineShaftBomb", root, function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  if not shaftBombs[_ARG_1_] then
    shaftBombs[_ARG_1_] = {}
  end
  if not shaftBombs[_ARG_1_][_ARG_2_] then
    shaftBombs[_ARG_1_][_ARG_2_] = {}
  end
  if _ARG_3_ ~= 1 then
  end
  if not shaftBombs[_ARG_1_][_ARG_2_][_ARG_3_] then
    if isElement((createObject(modelIds.v4_mine_dynamite, minePosX + (_UPVALUE1_[_ARG_1_][1] * 6 + mineAssets[_ARG_1_][3] * (_ARG_2_ - 1) * 6) - -mineAssets[_ARG_1_][4] * 1.45 + -mineAssets[_ARG_1_][3] * 0.5, minePosY + (_UPVALUE1_[_ARG_1_][2] * 6 + mineAssets[_ARG_1_][4] * (_ARG_2_ - 1) * 6) + -mineAssets[_ARG_1_][3] * 1.45 + -mineAssets[_ARG_1_][4] * 0.5, minePosZ + 1.5, 0, 0, mineAssets[_ARG_1_][1] + 180))) then
      setObjectScale(createObject(modelIds.v4_mine_dynamite, minePosX + (_UPVALUE1_[_ARG_1_][1] * 6 + mineAssets[_ARG_1_][3] * (_ARG_2_ - 1) * 6) - -mineAssets[_ARG_1_][4] * 1.45 + -mineAssets[_ARG_1_][3] * 0.5, minePosY + (_UPVALUE1_[_ARG_1_][2] * 6 + mineAssets[_ARG_1_][4] * (_ARG_2_ - 1) * 6) + -mineAssets[_ARG_1_][3] * 1.45 + -mineAssets[_ARG_1_][4] * 0.5, minePosZ + 1.5, 0, 0, mineAssets[_ARG_1_][1] + 180), 3)
      setElementInterior(createObject(modelIds.v4_mine_dynamite, minePosX + (_UPVALUE1_[_ARG_1_][1] * 6 + mineAssets[_ARG_1_][3] * (_ARG_2_ - 1) * 6) - -mineAssets[_ARG_1_][4] * 1.45 + -mineAssets[_ARG_1_][3] * 0.5, minePosY + (_UPVALUE1_[_ARG_1_][2] * 6 + mineAssets[_ARG_1_][4] * (_ARG_2_ - 1) * 6) + -mineAssets[_ARG_1_][3] * 1.45 + -mineAssets[_ARG_1_][4] * 0.5, minePosZ + 1.5, 0, 0, mineAssets[_ARG_1_][1] + 180), 0)
      setElementDimension(createObject(modelIds.v4_mine_dynamite, minePosX + (_UPVALUE1_[_ARG_1_][1] * 6 + mineAssets[_ARG_1_][3] * (_ARG_2_ - 1) * 6) - -mineAssets[_ARG_1_][4] * 1.45 + -mineAssets[_ARG_1_][3] * 0.5, minePosY + (_UPVALUE1_[_ARG_1_][2] * 6 + mineAssets[_ARG_1_][4] * (_ARG_2_ - 1) * 6) + -mineAssets[_ARG_1_][3] * 1.45 + -mineAssets[_ARG_1_][4] * 0.5, minePosZ + 1.5, 0, 0, mineAssets[_ARG_1_][1] + 180), currentMine)
    end
    if isElement((playSound3D("files/sounds/tntfuse.mp3", minePosX + (_UPVALUE1_[_ARG_1_][1] * 6 + mineAssets[_ARG_1_][3] * (_ARG_2_ - 1) * 6) - -mineAssets[_ARG_1_][4] * 1.45 + -mineAssets[_ARG_1_][3] * 0.5, minePosY + (_UPVALUE1_[_ARG_1_][2] * 6 + mineAssets[_ARG_1_][4] * (_ARG_2_ - 1) * 6) + -mineAssets[_ARG_1_][3] * 1.45 + -mineAssets[_ARG_1_][4] * 0.5, minePosZ + 1.5))) then
      setElementInterior(playSound3D("files/sounds/tntfuse.mp3", minePosX + (_UPVALUE1_[_ARG_1_][1] * 6 + mineAssets[_ARG_1_][3] * (_ARG_2_ - 1) * 6) - -mineAssets[_ARG_1_][4] * 1.45 + -mineAssets[_ARG_1_][3] * 0.5, minePosY + (_UPVALUE1_[_ARG_1_][2] * 6 + mineAssets[_ARG_1_][4] * (_ARG_2_ - 1) * 6) + -mineAssets[_ARG_1_][3] * 1.45 + -mineAssets[_ARG_1_][4] * 0.5, minePosZ + 1.5), 0)
      setElementDimension(playSound3D("files/sounds/tntfuse.mp3", minePosX + (_UPVALUE1_[_ARG_1_][1] * 6 + mineAssets[_ARG_1_][3] * (_ARG_2_ - 1) * 6) - -mineAssets[_ARG_1_][4] * 1.45 + -mineAssets[_ARG_1_][3] * 0.5, minePosY + (_UPVALUE1_[_ARG_1_][2] * 6 + mineAssets[_ARG_1_][4] * (_ARG_2_ - 1) * 6) + -mineAssets[_ARG_1_][3] * 1.45 + -mineAssets[_ARG_1_][4] * 0.5, minePosZ + 1.5), currentMine)
    end
    shaftBombs[_ARG_1_][_ARG_2_][_ARG_3_] = {
      createObject(modelIds.v4_mine_dynamite, minePosX + (_UPVALUE1_[_ARG_1_][1] * 6 + mineAssets[_ARG_1_][3] * (_ARG_2_ - 1) * 6) - -mineAssets[_ARG_1_][4] * 1.45 + -mineAssets[_ARG_1_][3] * 0.5, minePosY + (_UPVALUE1_[_ARG_1_][2] * 6 + mineAssets[_ARG_1_][4] * (_ARG_2_ - 1) * 6) + -mineAssets[_ARG_1_][3] * 1.45 + -mineAssets[_ARG_1_][4] * 0.5, minePosZ + 1.5, 0, 0, mineAssets[_ARG_1_][1] + 180),
      -mineAssets[_ARG_1_][3],
      -mineAssets[_ARG_1_][4],
      0,
      minePosX + (_UPVALUE1_[_ARG_1_][1] * 6 + mineAssets[_ARG_1_][3] * (_ARG_2_ - 1) * 6) - -mineAssets[_ARG_1_][4] * 1.45 + -mineAssets[_ARG_1_][3] * 0.5,
      minePosY + (_UPVALUE1_[_ARG_1_][2] * 6 + mineAssets[_ARG_1_][4] * (_ARG_2_ - 1) * 6) + -mineAssets[_ARG_1_][3] * 1.45 + -mineAssets[_ARG_1_][4] * 0.5,
      minePosZ + 1.5
    }
  end
  if source ~= resourceRoot then
    setPedHeadingTo(source, minePosX + (_UPVALUE1_[_ARG_1_][1] * 6 + mineAssets[_ARG_1_][3] * (_ARG_2_ - 1) * 6) - -mineAssets[_ARG_1_][4] * 1.45 + -mineAssets[_ARG_1_][3] * 0.5, minePosY + (_UPVALUE1_[_ARG_1_][2] * 6 + mineAssets[_ARG_1_][4] * (_ARG_2_ - 1) * 6) + -mineAssets[_ARG_1_][3] * 1.45 + -mineAssets[_ARG_1_][4] * 0.5)
  end
end)
;(function(_ARG_0_, _ARG_1_, _ARG_2_)
  addEvent(_ARG_0_, true)
  addEventHandler(_ARG_0_, _ARG_1_, function(_ARG_0_, ...)
    if not loadingMineExit then
      if loadingMineEnter then
        if _ARG_0_ == loadingMineEnter then
          table.insert(mineAssets, {
            eventName = _UPVALUE1_,
            handlerFunction = _UPVALUE2_,
            handlerFunctionParams = {
              ...
            },
            sourceElement = source
          })
        end
      elseif _ARG_0_ == currentMine then
        _UPVALUE2_(_ARG_0_, ...)
      end
    end
  end)
end)("detonateMineShaftBomb", root, function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  if shaftBombs[_ARG_1_] and shaftBombs[_ARG_1_][_ARG_2_] and shaftBombs[_ARG_1_][_ARG_2_][_ARG_3_] then
    table.insert(bombDetonations, {
      (shaftBombs[_ARG_1_] and shaftBombs[_ARG_1_][_ARG_2_] and shaftBombs[_ARG_1_][_ARG_2_][_ARG_3_])[5],
      (shaftBombs[_ARG_1_] and shaftBombs[_ARG_1_][_ARG_2_] and shaftBombs[_ARG_1_][_ARG_2_][_ARG_3_])[6],
      (shaftBombs[_ARG_1_] and shaftBombs[_ARG_1_][_ARG_2_] and shaftBombs[_ARG_1_][_ARG_2_][_ARG_3_])[7],
      0
    })
    spawnSmokeExBg((shaftBombs[_ARG_1_] and shaftBombs[_ARG_1_][_ARG_2_] and shaftBombs[_ARG_1_][_ARG_2_][_ARG_3_])[5], (shaftBombs[_ARG_1_] and shaftBombs[_ARG_1_][_ARG_2_] and shaftBombs[_ARG_1_][_ARG_2_][_ARG_3_])[6], (shaftBombs[_ARG_1_] and shaftBombs[_ARG_1_][_ARG_2_] and shaftBombs[_ARG_1_][_ARG_2_][_ARG_3_])[7], true)
    detonateDamage((shaftBombs[_ARG_1_] and shaftBombs[_ARG_1_][_ARG_2_] and shaftBombs[_ARG_1_][_ARG_2_][_ARG_3_])[5], (shaftBombs[_ARG_1_] and shaftBombs[_ARG_1_][_ARG_2_] and shaftBombs[_ARG_1_][_ARG_2_][_ARG_3_])[6], (shaftBombs[_ARG_1_] and shaftBombs[_ARG_1_][_ARG_2_] and shaftBombs[_ARG_1_][_ARG_2_][_ARG_3_])[7])
    if isElement((shaftBombs[_ARG_1_] and shaftBombs[_ARG_1_][_ARG_2_] and shaftBombs[_ARG_1_][_ARG_2_][_ARG_3_])[1]) then
      destroyElement((shaftBombs[_ARG_1_] and shaftBombs[_ARG_1_][_ARG_2_] and shaftBombs[_ARG_1_][_ARG_2_][_ARG_3_])[1])
    end
    ;(shaftBombs[_ARG_1_] and shaftBombs[_ARG_1_][_ARG_2_] and shaftBombs[_ARG_1_][_ARG_2_][_ARG_3_])[1] = nil
  end
  shaftBombs[_ARG_1_][_ARG_2_][_ARG_3_] = nil
  if not next(shaftBombs[_ARG_1_][_ARG_2_]) then
    shaftBombs[_ARG_1_][_ARG_2_] = nil
    if not next(shaftBombs[_ARG_1_]) then
      shaftBombs[_ARG_1_] = nil
    end
  end
end)
;(function(_ARG_0_, _ARG_1_, _ARG_2_)
  addEvent(_ARG_0_, true)
  addEventHandler(_ARG_0_, _ARG_1_, function(_ARG_0_, ...)
    if not loadingMineExit then
      if loadingMineEnter then
        if _ARG_0_ == loadingMineEnter then
          table.insert(mineAssets, {
            eventName = _UPVALUE1_,
            handlerFunction = _UPVALUE2_,
            handlerFunctionParams = {
              ...
            },
            sourceElement = source
          })
        end
      elseif _ARG_0_ == currentMine then
        _UPVALUE2_(_ARG_0_, ...)
      end
    end
  end)
end)("gotMineThreeJunctionBomb", root, function(_ARG_0_, _ARG_1_, _ARG_2_)
  if not threeJunctionBombs[_ARG_1_] then
    threeJunctionBombs[_ARG_1_] = {}
  end
  if not threeJunctionBombs[_ARG_1_][_ARG_2_] then
    if isElement((createObject(modelIds.v4_mine_dynamite, minePosX + _ARG_1_ * 6 - psin(threeJunctionsAt[_ARG_1_][_ARG_2_]) * 1.45, minePosY + _ARG_2_ * 6 + pcos(threeJunctionsAt[_ARG_1_][_ARG_2_]) * 1.45, minePosZ + 1.5, 0, 0, math.deg(threeJunctionsAt[_ARG_1_][_ARG_2_])))) then
      setObjectScale(createObject(modelIds.v4_mine_dynamite, minePosX + _ARG_1_ * 6 - psin(threeJunctionsAt[_ARG_1_][_ARG_2_]) * 1.45, minePosY + _ARG_2_ * 6 + pcos(threeJunctionsAt[_ARG_1_][_ARG_2_]) * 1.45, minePosZ + 1.5, 0, 0, math.deg(threeJunctionsAt[_ARG_1_][_ARG_2_])), 3)
      setElementInterior(createObject(modelIds.v4_mine_dynamite, minePosX + _ARG_1_ * 6 - psin(threeJunctionsAt[_ARG_1_][_ARG_2_]) * 1.45, minePosY + _ARG_2_ * 6 + pcos(threeJunctionsAt[_ARG_1_][_ARG_2_]) * 1.45, minePosZ + 1.5, 0, 0, math.deg(threeJunctionsAt[_ARG_1_][_ARG_2_])), 0)
      setElementDimension(createObject(modelIds.v4_mine_dynamite, minePosX + _ARG_1_ * 6 - psin(threeJunctionsAt[_ARG_1_][_ARG_2_]) * 1.45, minePosY + _ARG_2_ * 6 + pcos(threeJunctionsAt[_ARG_1_][_ARG_2_]) * 1.45, minePosZ + 1.5, 0, 0, math.deg(threeJunctionsAt[_ARG_1_][_ARG_2_])), currentMine)
    end
    if isElement((playSound3D("files/sounds/tntfuse.mp3", minePosX + _ARG_1_ * 6 - psin(threeJunctionsAt[_ARG_1_][_ARG_2_]) * 1.45, minePosY + _ARG_2_ * 6 + pcos(threeJunctionsAt[_ARG_1_][_ARG_2_]) * 1.45, minePosZ + 1.5))) then
      setElementInterior(playSound3D("files/sounds/tntfuse.mp3", minePosX + _ARG_1_ * 6 - psin(threeJunctionsAt[_ARG_1_][_ARG_2_]) * 1.45, minePosY + _ARG_2_ * 6 + pcos(threeJunctionsAt[_ARG_1_][_ARG_2_]) * 1.45, minePosZ + 1.5), 0)
      setElementDimension(playSound3D("files/sounds/tntfuse.mp3", minePosX + _ARG_1_ * 6 - psin(threeJunctionsAt[_ARG_1_][_ARG_2_]) * 1.45, minePosY + _ARG_2_ * 6 + pcos(threeJunctionsAt[_ARG_1_][_ARG_2_]) * 1.45, minePosZ + 1.5), currentMine)
    end
    threeJunctionBombs[_ARG_1_][_ARG_2_] = {
      createObject(modelIds.v4_mine_dynamite, minePosX + _ARG_1_ * 6 - psin(threeJunctionsAt[_ARG_1_][_ARG_2_]) * 1.45, minePosY + _ARG_2_ * 6 + pcos(threeJunctionsAt[_ARG_1_][_ARG_2_]) * 1.45, minePosZ + 1.5, 0, 0, math.deg(threeJunctionsAt[_ARG_1_][_ARG_2_])),
      pcos(threeJunctionsAt[_ARG_1_][_ARG_2_]),
      psin(threeJunctionsAt[_ARG_1_][_ARG_2_]),
      0,
      minePosX + _ARG_1_ * 6 - psin(threeJunctionsAt[_ARG_1_][_ARG_2_]) * 1.45,
      minePosY + _ARG_2_ * 6 + pcos(threeJunctionsAt[_ARG_1_][_ARG_2_]) * 1.45,
      minePosZ + 1.5
    }
  end
  if source ~= resourceRoot then
    setPedHeadingTo(source, minePosX + _ARG_1_ * 6 - psin(threeJunctionsAt[_ARG_1_][_ARG_2_]) * 1.45, minePosY + _ARG_2_ * 6 + pcos(threeJunctionsAt[_ARG_1_][_ARG_2_]) * 1.45)
  end
end)
;(function(_ARG_0_, _ARG_1_, _ARG_2_)
  addEvent(_ARG_0_, true)
  addEventHandler(_ARG_0_, _ARG_1_, function(_ARG_0_, ...)
    if not loadingMineExit then
      if loadingMineEnter then
        if _ARG_0_ == loadingMineEnter then
          table.insert(mineAssets, {
            eventName = _UPVALUE1_,
            handlerFunction = _UPVALUE2_,
            handlerFunctionParams = {
              ...
            },
            sourceElement = source
          })
        end
      elseif _ARG_0_ == currentMine then
        _UPVALUE2_(_ARG_0_, ...)
      end
    end
  end)
end)("detonateMineThreeJunctionBomb", root, function(_ARG_0_, _ARG_1_, _ARG_2_)
  if threeJunctionBombs[_ARG_1_] and threeJunctionBombs[_ARG_1_][_ARG_2_] then
    table.insert(bombDetonations, {
      (threeJunctionBombs[_ARG_1_] and threeJunctionBombs[_ARG_1_][_ARG_2_])[5],
      (threeJunctionBombs[_ARG_1_] and threeJunctionBombs[_ARG_1_][_ARG_2_])[6],
      (threeJunctionBombs[_ARG_1_] and threeJunctionBombs[_ARG_1_][_ARG_2_])[7],
      0
    })
    spawnSmokeExBg((threeJunctionBombs[_ARG_1_] and threeJunctionBombs[_ARG_1_][_ARG_2_])[5], (threeJunctionBombs[_ARG_1_] and threeJunctionBombs[_ARG_1_][_ARG_2_])[6], (threeJunctionBombs[_ARG_1_] and threeJunctionBombs[_ARG_1_][_ARG_2_])[7], true)
    detonateDamage((threeJunctionBombs[_ARG_1_] and threeJunctionBombs[_ARG_1_][_ARG_2_])[5], (threeJunctionBombs[_ARG_1_] and threeJunctionBombs[_ARG_1_][_ARG_2_])[6], (threeJunctionBombs[_ARG_1_] and threeJunctionBombs[_ARG_1_][_ARG_2_])[7])
    if isElement((threeJunctionBombs[_ARG_1_] and threeJunctionBombs[_ARG_1_][_ARG_2_])[1]) then
      destroyElement((threeJunctionBombs[_ARG_1_] and threeJunctionBombs[_ARG_1_][_ARG_2_])[1])
    end
    ;(threeJunctionBombs[_ARG_1_] and threeJunctionBombs[_ARG_1_][_ARG_2_])[1] = nil
  end
  threeJunctionBombs[_ARG_1_][_ARG_2_] = nil
  if not next(threeJunctionBombs[_ARG_1_]) then
    threeJunctionBombs[_ARG_1_] = nil
  end
end)
function detonateDamage(_ARG_0_, _ARG_1_, _ARG_2_)
  if isElement((playSound3D("files/sounds/tnt" .. math.random(1, 5) .. ".wav", _ARG_0_, _ARG_1_, _ARG_2_))) then
    setElementInterior(playSound3D("files/sounds/tnt" .. math.random(1, 5) .. ".wav", _ARG_0_, _ARG_1_, _ARG_2_), 0)
    setElementDimension(playSound3D("files/sounds/tnt" .. math.random(1, 5) .. ".wav", _ARG_0_, _ARG_1_, _ARG_2_), currentMine)
    setSoundMaxDistance(playSound3D("files/sounds/tnt" .. math.random(1, 5) .. ".wav", _ARG_0_, _ARG_1_, _ARG_2_), 150)
    setSoundVolume(playSound3D("files/sounds/tnt" .. math.random(1, 5) .. ".wav", _ARG_0_, _ARG_1_, _ARG_2_), 2)
  end
  if 0 < (1 - getDistanceBetweenPoints2D(selfPosX, selfPosY, _ARG_0_, _ARG_1_) / 12) * 120 then
    setElementHealth(localPlayer, math.max(0, getElementHealth(localPlayer) - (1 - getDistanceBetweenPoints2D(selfPosX, selfPosY, _ARG_0_, _ARG_1_) / 12) * 120))
  end
end
;(function(_ARG_0_, _ARG_1_, _ARG_2_)
  addEvent(_ARG_0_, true)
  addEventHandler(_ARG_0_, _ARG_1_, function(_ARG_0_, ...)
    if not loadingMineExit then
      if loadingMineEnter then
        if _ARG_0_ == loadingMineEnter then
          table.insert(mineAssets, {
            eventName = _UPVALUE1_,
            handlerFunction = _UPVALUE2_,
            handlerFunctionParams = {
              ...
            },
            sourceElement = source
          })
        end
      elseif _ARG_0_ == currentMine then
        _UPVALUE2_(_ARG_0_, ...)
      end
    end
  end)
end)("syncMineFurnaceRunning", root, function(_ARG_0_, _ARG_1_, _ARG_2_)
  if not _ARG_1_ and mineFoundryData.furnaceRunning and oreTypes[mineFoundryData.furnaceRunning] then
    if isElement((playSound3D("files/sounds/machinebutton.mp3", unpack(oreTypes[mineFoundryData.furnaceRunning].foundryButtonPosition)))) then
      setElementInterior(playSound3D("files/sounds/machinebutton.mp3", unpack(oreTypes[mineFoundryData.furnaceRunning].foundryButtonPosition)), 0)
      setElementDimension(playSound3D("files/sounds/machinebutton.mp3", unpack(oreTypes[mineFoundryData.furnaceRunning].foundryButtonPosition)), currentMine)
    end
    if source ~= resourceRoot then
      setPedHeadingTo(source, unpack(oreTypes[mineFoundryData.furnaceRunning].foundryButtonPosition))
    end
  end
  mineFoundryData.furnaceRunning = _ARG_1_
  if _ARG_1_ and oreTypes[_ARG_1_] then
    if isElement((playSound3D("files/sounds/machinebutton.mp3", unpack(oreTypes[_ARG_1_].foundryButtonPosition)))) then
      setElementInterior(playSound3D("files/sounds/machinebutton.mp3", unpack(oreTypes[_ARG_1_].foundryButtonPosition)), 0)
      setElementDimension(playSound3D("files/sounds/machinebutton.mp3", unpack(oreTypes[_ARG_1_].foundryButtonPosition)), currentMine)
    end
    oreTypes[_ARG_1_].furnaceTemperature = _ARG_2_
    if source ~= resourceRoot then
      setPedHeadingTo(source, unpack(oreTypes[_ARG_1_].foundryButtonPosition))
    end
    nextSurge = getTickCount()
  end
  shouldRefreshUrmaMotoDevice = true
end)
;(function(_ARG_0_, _ARG_1_, _ARG_2_)
  addEvent(_ARG_0_, true)
  addEventHandler(_ARG_0_, _ARG_1_, function(_ARG_0_, ...)
    if not loadingMineExit then
      if loadingMineEnter then
        if _ARG_0_ == loadingMineEnter then
          table.insert(mineAssets, {
            eventName = _UPVALUE1_,
            handlerFunction = _UPVALUE2_,
            handlerFunctionParams = {
              ...
            },
            sourceElement = source
          })
        end
      elseif _ARG_0_ == currentMine then
        _UPVALUE2_(_ARG_0_, ...)
      end
    end
  end)
end)("syncMineOreMelting", root, function(_ARG_0_, _ARG_1_)
  mineFoundryData.meltProgress = 0
  setMeltingOre(_ARG_1_)
end)
function setMeltingOre(_ARG_0_)
  mineFoundryData.meltingOre = _ARG_0_
  if isElement(mineFoundryData.ingotObject) then
    destroyElement(mineFoundryData.ingotObject)
  end
  if isElement(mineFoundryData.meltObject) then
    destroyElement(mineFoundryData.meltObject)
  end
  if _ARG_0_ then
    if oreTypes[_ARG_0_] then
      mineFoundryData.ingotObject = createObject(modelIds.v4_mine_ingot, oreTypes[_ARG_0_].ingotPosition[1], oreTypes[_ARG_0_].ingotPosition[2], oreTypes[_ARG_0_].ingotPosition[3], 0, 0, 180)
      if isElement(mineFoundryData.ingotObject) then
        setElementInterior(mineFoundryData.ingotObject, 0)
        setElementDimension(mineFoundryData.ingotObject, currentMine)
      end
      mineFoundryData.meltObject = createObject(modelIds.v4_mine_flow, oreTypes[_ARG_0_].meltPosition[1], oreTypes[_ARG_0_].meltPosition[2], oreTypes[_ARG_0_].meltPosition[3], 0, 0, 180)
      if isElement(mineFoundryData.meltObject) then
        setElementInterior(mineFoundryData.meltObject, 0)
        setElementDimension(mineFoundryData.meltObject, currentMine)
      end
      setMeltingMetal(_ARG_0_)
    end
  else
    mineFoundryData.meltObject = nil
    mineFoundryData.ingotObject = nil
  end
end
;(function(_ARG_0_, _ARG_1_, _ARG_2_)
  addEvent(_ARG_0_, true)
  addEventHandler(_ARG_0_, _ARG_1_, function(_ARG_0_, ...)
    if not loadingMineExit then
      if loadingMineEnter then
        if _ARG_0_ == loadingMineEnter then
          table.insert(mineAssets, {
            eventName = _UPVALUE1_,
            handlerFunction = _UPVALUE2_,
            handlerFunctionParams = {
              ...
            },
            sourceElement = source
          })
        end
      elseif _ARG_0_ == currentMine then
        _UPVALUE2_(_ARG_0_, ...)
      end
    end
  end)
end)("gotMineJerrycan", root, function(_ARG_0_, _ARG_1_)
  processJerrycanSync(_ARG_1_)
end)
;(function(_ARG_0_, _ARG_1_, _ARG_2_)
  addEvent(_ARG_0_, true)
  addEventHandler(_ARG_0_, _ARG_1_, function(_ARG_0_, ...)
    if not loadingMineExit then
      if loadingMineEnter then
        if _ARG_0_ == loadingMineEnter then
          table.insert(mineAssets, {
            eventName = _UPVALUE1_,
            handlerFunction = _UPVALUE2_,
            handlerFunctionParams = {
              ...
            },
            sourceElement = source
          })
        end
      elseif _ARG_0_ == currentMine then
        _UPVALUE2_(_ARG_0_, ...)
      end
    end
  end)
end)("syncMineJerryContent", root, function(_ARG_0_, _ARG_1_)
  currentMineInventory.jerryContent = _ARG_1_
  if isElement(currentMineInventory.jerryCan) and isElement((playSound3D("files/sounds/jerryballon.wav", getElementPosition(currentMineInventory.jerryCan)))) then
    setElementInterior(playSound3D("files/sounds/jerryballon.wav", getElementPosition(currentMineInventory.jerryCan)), 0)
    setElementDimension(playSound3D("files/sounds/jerryballon.wav", getElementPosition(currentMineInventory.jerryCan)), currentMine)
  end
  shouldRefreshJerryContent = true
end)
;(function(_ARG_0_, _ARG_1_, _ARG_2_)
  addEvent(_ARG_0_, true)
  addEventHandler(_ARG_0_, _ARG_1_, function(_ARG_0_, ...)
    if not loadingMineExit then
      if loadingMineEnter then
        if _ARG_0_ == loadingMineEnter then
          table.insert(mineAssets, {
            eventName = _UPVALUE1_,
            handlerFunction = _UPVALUE2_,
            handlerFunctionParams = {
              ...
            },
            sourceElement = source
          })
        end
      elseif _ARG_0_ == currentMine then
        _UPVALUE2_(_ARG_0_, ...)
      end
    end
  end)
end)("syncMineLocoFuel", root, function(_ARG_0_, _ARG_1_, _ARG_2_)
  processLocoFuelSync(_ARG_1_, _ARG_2_)
end)
;(function(_ARG_0_, _ARG_1_, _ARG_2_)
  addEvent(_ARG_0_, true)
  addEventHandler(_ARG_0_, _ARG_1_, function(_ARG_0_, ...)
    if not loadingMineExit then
      if loadingMineEnter then
        if _ARG_0_ == loadingMineEnter then
          table.insert(mineAssets, {
            eventName = _UPVALUE1_,
            handlerFunction = _UPVALUE2_,
            handlerFunctionParams = {
              ...
            },
            sourceElement = source
          })
        end
      elseif _ARG_0_ == currentMine then
        _UPVALUE2_(_ARG_0_, ...)
      end
    end
  end)
end)("buildMineLight", root, function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  setStreamedLights(_ARG_1_, _ARG_2_)
  updateMineInventory("mineLamps", _ARG_3_)
end)
;(function(_ARG_0_, _ARG_1_, _ARG_2_)
  addEvent(_ARG_0_, true)
  addEventHandler(_ARG_0_, _ARG_1_, function(_ARG_0_, ...)
    if not loadingMineExit then
      if loadingMineEnter then
        if _ARG_0_ == loadingMineEnter then
          table.insert(mineAssets, {
            eventName = _UPVALUE1_,
            handlerFunction = _UPVALUE2_,
            handlerFunctionParams = {
              ...
            },
            sourceElement = source
          })
        end
      elseif _ARG_0_ == currentMine then
        _UPVALUE2_(_ARG_0_, ...)
      end
    end
  end)
end)("gotMineRentDataInside", root, function(_ARG_0_, _ARG_1_, _ARG_2_)
  if _ARG_1_ == "mineName" then
    currentMineName = _ARG_2_
    refreshMineName()
  end
end)
function refreshMineName()
  mineAssets = {}
  for _FORV_10_ = 1, #currentMineName do
    for _FORV_16_ = 1, utf8.len((utf8.upper(currentMineName[_FORV_10_]))) do
      if charsetMap[utf8.sub(utf8.upper(currentMineName[_FORV_10_]), _FORV_16_, _FORV_16_)] then
        table.insert(mineAssets, {
          minePosX - 9.1837 + -1 * 0.015 - 0 * (charsetMap[utf8.sub(utf8.upper(currentMineName[_FORV_10_]), _FORV_16_, _FORV_16_)][2] * 0.00296875 / 2),
          minePosY + 0.048 + 0 * 0.015 + -1 * (charsetMap[utf8.sub(utf8.upper(currentMineName[_FORV_10_]), _FORV_16_, _FORV_16_)][2] * 0.00296875 / 2),
          minePosZ + 2.755,
          charsetMap[utf8.sub(utf8.upper(currentMineName[_FORV_10_]), _FORV_16_, _FORV_16_)][1],
          charsetMap[utf8.sub(utf8.upper(currentMineName[_FORV_10_]), _FORV_16_, _FORV_16_)][2]
        })
      else
      end
    end
    if _FORV_10_ < #_FOR_ then
    end
  end
  for _FORV_10_ = 1, #mineAssets do
    if mineAssets[_FORV_10_] then
      mineAssets[_FORV_10_][1] = mineAssets[_FORV_10_][1] + 0 * ((0 + charsetMap[utf8.sub(utf8.upper(currentMineName[_FORV_10_]), _FORV_16_, _FORV_16_)][2] * 0.00296875 / 2 * 2 + 0.083125 + 0.083125) / 2)
      mineAssets[_FORV_10_][2] = mineAssets[_FORV_10_][2] - -1 * ((0 + charsetMap[utf8.sub(utf8.upper(currentMineName[_FORV_10_]), _FORV_16_, _FORV_16_)][2] * 0.00296875 / 2 * 2 + 0.083125 + 0.083125) / 2)
    end
  end
end
;(function(_ARG_0_, _ARG_1_, _ARG_2_)
  addEvent(_ARG_0_, true)
  addEventHandler(_ARG_0_, _ARG_1_, function(_ARG_0_, ...)
    if not loadingMineExit then
      if loadingMineEnter then
        if _ARG_0_ == loadingMineEnter then
          table.insert(mineAssets, {
            eventName = _UPVALUE1_,
            handlerFunction = _UPVALUE2_,
            handlerFunctionParams = {
              ...
            },
            sourceElement = source
          })
        end
      elseif _ARG_0_ == currentMine then
        _UPVALUE2_(_ARG_0_, ...)
      end
    end
  end)
end)("addMinePermissions", root, function(_ARG_0_, _ARG_1_, _ARG_2_)
  shouldRefreshUrmaMotoDevice = true
  currentMineWorkers[_ARG_1_] = _ARG_2_
  currentMinePermissions[_ARG_1_] = 0
  for _FORV_6_ = #currentMineWorkersList, 1, -1 do
    if currentMineWorkersList[_FORV_6_] == _ARG_1_ then
      table.remove(currentMineWorkersList, _FORV_6_)
      break
    end
  end
  _FOR_.insert(currentMineWorkersList, _ARG_1_)
end)
;(function(_ARG_0_, _ARG_1_, _ARG_2_)
  addEvent(_ARG_0_, true)
  addEventHandler(_ARG_0_, _ARG_1_, function(_ARG_0_, ...)
    if not loadingMineExit then
      if loadingMineEnter then
        if _ARG_0_ == loadingMineEnter then
          table.insert(mineAssets, {
            eventName = _UPVALUE1_,
            handlerFunction = _UPVALUE2_,
            handlerFunctionParams = {
              ...
            },
            sourceElement = source
          })
        end
      elseif _ARG_0_ == currentMine then
        _UPVALUE2_(_ARG_0_, ...)
      end
    end
  end)
end)("removeMinePermissions", root, function(_ARG_0_, _ARG_1_)
  currentMineWorkers[_ARG_1_] = nil
  currentMinePermissions[_ARG_1_] = nil
  for _FORV_5_ = #currentMineWorkersList, 1, -1 do
    if currentMineWorkersList[_FORV_5_] == _ARG_1_ then
      table.remove(currentMineWorkersList, _FORV_5_)
      break
    end
  end
  shouldRefreshUrmaMotoDevice = _FOR_
end)
;(function(_ARG_0_, _ARG_1_, _ARG_2_)
  addEvent(_ARG_0_, true)
  addEventHandler(_ARG_0_, _ARG_1_, function(_ARG_0_, ...)
    if not loadingMineExit then
      if loadingMineEnter then
        if _ARG_0_ == loadingMineEnter then
          table.insert(mineAssets, {
            eventName = _UPVALUE1_,
            handlerFunction = _UPVALUE2_,
            handlerFunctionParams = {
              ...
            },
            sourceElement = source
          })
        end
      elseif _ARG_0_ == currentMine then
        _UPVALUE2_(_ARG_0_, ...)
      end
    end
  end)
end)("updateMinePermissions", root, function(_ARG_0_, _ARG_1_)
  for _FORV_5_, _FORV_6_ in pairs(_ARG_1_) do
    if currentMineWorkers[_FORV_5_] then
      currentMinePermissions[_FORV_5_] = _FORV_6_
      shouldRefreshUrmaMotoDevice = true
    end
  end
end)
;(function(_ARG_0_, _ARG_1_, _ARG_2_)
  addEvent(_ARG_0_, true)
  addEventHandler(_ARG_0_, _ARG_1_, function(_ARG_0_, ...)
    if not loadingMineExit then
      if loadingMineEnter then
        if _ARG_0_ == loadingMineEnter then
          table.insert(mineAssets, {
            eventName = _UPVALUE1_,
            handlerFunction = _UPVALUE2_,
            handlerFunctionParams = {
              ...
            },
            sourceElement = source
          })
        end
      elseif _ARG_0_ == currentMine then
        _UPVALUE2_(_ARG_0_, ...)
      end
    end
  end)
end)("updateMineWorkerName", root, function(_ARG_0_, _ARG_1_, _ARG_2_)
  if currentMineWorkers[_ARG_1_] then
    currentMineWorkers[_ARG_1_] = _ARG_2_
    shouldRefreshUrmaMotoDevice = true
  end
end)
;(function(_ARG_0_, _ARG_1_, _ARG_2_)
  addEvent(_ARG_0_, true)
  addEventHandler(_ARG_0_, _ARG_1_, function(_ARG_0_, ...)
    if not loadingMineExit then
      if loadingMineEnter then
        if _ARG_0_ == loadingMineEnter then
          table.insert(mineAssets, {
            eventName = _UPVALUE1_,
            handlerFunction = _UPVALUE2_,
            handlerFunctionParams = {
              ...
            },
            sourceElement = source
          })
        end
      elseif _ARG_0_ == currentMine then
        _UPVALUE2_(_ARG_0_, ...)
      end
    end
  end)
end)("gotMineOrder", root, function(_ARG_0_, _ARG_1_, _ARG_2_)
  currentMineOrder = _ARG_1_
  currentMineOrdering = {}
  currentMineOrderPaid = _ARG_2_
  shouldRefreshUrmaMotoDevice = true
end)
;(function(_ARG_0_, _ARG_1_, _ARG_2_)
  addEvent(_ARG_0_, true)
  addEventHandler(_ARG_0_, _ARG_1_, function(_ARG_0_, ...)
    if not loadingMineExit then
      if loadingMineEnter then
        if _ARG_0_ == loadingMineEnter then
          table.insert(mineAssets, {
            eventName = _UPVALUE1_,
            handlerFunction = _UPVALUE2_,
            handlerFunctionParams = {
              ...
            },
            sourceElement = source
          })
        end
      elseif _ARG_0_ == currentMine then
        _UPVALUE2_(_ARG_0_, ...)
      end
    end
  end)
end)("gotMineOrderPaid", root, function(_ARG_0_, _ARG_1_)
  currentMineOrderPaid = _ARG_1_
  shouldRefreshUrmaMotoDevice = true
end)
;(function(_ARG_0_, _ARG_1_, _ARG_2_)
  addEvent(_ARG_0_, true)
  addEventHandler(_ARG_0_, _ARG_1_, function(_ARG_0_, ...)
    if not loadingMineExit then
      if loadingMineEnter then
        if _ARG_0_ == loadingMineEnter then
          table.insert(mineAssets, {
            eventName = _UPVALUE1_,
            handlerFunction = _UPVALUE2_,
            handlerFunctionParams = {
              ...
            },
            sourceElement = source
          })
        end
      elseif _ARG_0_ == currentMine then
        _UPVALUE2_(_ARG_0_, ...)
      end
    end
  end)
end)("playMineFaucetSound", root, function(_ARG_0_)
  if isElement((playSound3D("files/sounds/wash.wav", minePosX - 27.3901, minePosY + 2.8282, minePosZ + 1.1891))) then
    setElementInterior(playSound3D("files/sounds/wash.wav", minePosX - 27.3901, minePosY + 2.8282, minePosZ + 1.1891), 0)
    setElementDimension(playSound3D("files/sounds/wash.wav", minePosX - 27.3901, minePosY + 2.8282, minePosZ + 1.1891), currentMine)
  end
end)
