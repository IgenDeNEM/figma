currentActiveShaftShader = false
currentActiveDepthRT = false
currentActiveNormalRT = false
addEventHandler("onClientResourceStart", resourceRoot, function()
  for _FORV_4_ = 1, #getElementsByType("player", root, true) do
    if hasElementData(getElementsByType("player", root, true)[_FORV_4_], "mineDirtyFace") then
      _UPVALUE0_[getElementsByType("player", root, true)[_FORV_4_]] = true
      if getElementsByType("player", root, true)[_FORV_4_] == localPlayer and not _UPVALUE1_ then
        addEventHandler("onClientPreRender", root, preRenderSelfDirt)
        _UPVALUE1_ = true
      end
    end
  end
  _FOR_()
end)
addEventHandler("onClientPlayerDataChange", root, function(_ARG_0_, _ARG_1_, _ARG_2_)
  if _ARG_0_ == "mineDirtyFace" and isElementStreamedIn(source) then
    if _ARG_2_ then
      streamInDirtyFace(source)
    else
      streamOutDirtyFace(source)
    end
  end
end)
addEventHandler("onClientPlayerStreamIn", root, function()
  if not _UPVALUE0_[source] and hasElementData(source, "mineDirtyFace") then
    streamInDirtyFace(source)
  end
end)
addEventHandler("onClientPlayerStreamOut", root, function()
  if _UPVALUE0_[source] then
    streamOutDirtyFace(source)
  end
end)
function isStreamedLight(_ARG_0_, _ARG_1_)
  return _UPVALUE0_[_ARG_0_] and _UPVALUE0_[_ARG_0_][_ARG_1_]
end
function setStreamedLights(_ARG_0_, _ARG_1_, _ARG_2_)
  if not _UPVALUE0_[_ARG_0_] then
    _UPVALUE0_[_ARG_0_] = {}
  end
  if not _UPVALUE0_[_ARG_0_][_ARG_1_] then
    _UPVALUE0_[_ARG_0_][_ARG_1_] = createObject(modelIds.v4_mine_lamp, minePosX + _ARG_0_ * 6, minePosY + _ARG_1_ * 6, minePosZ + (_ARG_0_ < -1 and 2 or 0))
    if isElement(_UPVALUE0_[_ARG_0_][_ARG_1_]) then
      setElementInterior(_UPVALUE0_[_ARG_0_][_ARG_1_], 0)
      setElementDimension(_UPVALUE0_[_ARG_0_][_ARG_1_], currentMine)
    end
    if not _ARG_2_ then
      if isElement((playSound3D("files/sounds/lamp.wav", minePosX + _ARG_0_ * 6, minePosY + _ARG_1_ * 6, minePosZ + (_ARG_0_ < -1 and 2 or 0)))) then
        setElementInterior(playSound3D("files/sounds/lamp.wav", minePosX + _ARG_0_ * 6, minePosY + _ARG_1_ * 6, minePosZ + (_ARG_0_ < -1 and 2 or 0)), 0)
        setElementDimension(playSound3D("files/sounds/lamp.wav", minePosX + _ARG_0_ * 6, minePosY + _ARG_1_ * 6, minePosZ + (_ARG_0_ < -1 and 2 or 0)), currentMine)
        setSoundMaxDistance(playSound3D("files/sounds/lamp.wav", minePosX + _ARG_0_ * 6, minePosY + _ARG_1_ * 6, minePosZ + (_ARG_0_ < -1 and 2 or 0)), 20)
      end
      if not _UPVALUE1_[_ARG_0_] then
        _UPVALUE1_[_ARG_0_] = {}
      end
      _UPVALUE1_[_ARG_0_][_ARG_1_] = getTickCount()
    end
  end
end
function refreshActiveShaftShader()
  if isElement(currentActiveShaftShader) then
    if isElement(currentActiveDepthRT) then
      dxSetShaderValue(currentActiveShaftShader, "DepthTexture", currentActiveDepthRT)
    end
    if isElement(currentActiveNormalRT) then
      dxSetShaderValue(currentActiveShaftShader, "NormalTexture", currentActiveNormalRT)
    end
  end
end
function refreshActiveShaftShaderBase(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  if isElement(currentActiveShaftShader) then
    dxSetShaderValue(currentActiveShaftShader, "BasePos", _ARG_0_, _ARG_1_, minePosZ)
    dxSetShaderValue(currentActiveShaftShader, "BaseCos", _ARG_2_)
    dxSetShaderValue(currentActiveShaftShader, "BaseSin", _ARG_3_)
  end
end
function refreshOreShader(_ARG_0_, _ARG_1_)
  if oreTypes[_ARG_1_] then
    if isElement(_UPVALUE0_) then
      engineRemoveShaderFromWorldTexture(_UPVALUE0_, "*", _ARG_0_)
    end
    if isElement(oreTypes[_ARG_1_].oreShader) then
      engineApplyShaderToWorldTexture(oreTypes[_ARG_1_].oreShader, "*", _ARG_0_)
    end
  elseif isElement(_UPVALUE0_) then
    engineApplyShaderToWorldTexture(_UPVALUE0_, "*", _ARG_0_)
  end
end
function setMeltingMetal(_ARG_0_)
  if isElement(_UPVALUE0_) then
    dxSetShaderValue(_UPVALUE0_, "MetalColor", oreTypes[_ARG_0_].meltingColor)
  end
end
function loadShaders()
  loaderText = "Shaderek inicializálása"
  if not _UPVALUE0_ then
    _UPVALUE0_ = dxCreateTexture("files/textures/shaftwall.dds")
  end
  if not _UPVALUE1_ then
    _UPVALUE1_ = dxCreateTexture("files/textures/noise.dds", "argb", false, "clamp")
  end
  if not _UPVALUE2_ then
    _UPVALUE2_ = dxCreateTexture("files/textures/spotlight.dds", "argb", false, "clamp")
  end
  if not _UPVALUE3_ then
    _UPVALUE3_ = dxCreateTexture("files/textures/headlight.dds", "argb", false, "clamp")
  end
  if preprocessShader("files/shaders/melt.fx") then
    _UPVALUE4_ = dxCreateShader(preprocessShader("files/shaders/melt.fx"), 0, 40, false, "all")
    if isElement(_UPVALUE4_) then
      engineApplyShaderToWorldTexture(_UPVALUE4_, "v4_mine_ingot")
    end
    table.insert(_UPVALUE5_, _UPVALUE4_)
  end
  if preprocessShader("files/shaders/wall.fx") then
    currentActiveShaftShader = dxCreateShader(preprocessShader("files/shaders/wall.fx"), 0, 40, false, "all")
    if isElement(currentActiveShaftShader) then
      dxSetShaderValue(currentActiveShaftShader, "DirtTexture", _UPVALUE0_)
    end
    table.insert(_UPVALUE5_, currentActiveShaftShader)
  end
  if preprocessShader("files/shaders/object.fx") then
    _UPVALUE6_ = dxCreateShader(preprocessShader("files/shaders/object.fx"), 0, 40, false, "all")
    _UPVALUE7_ = dxCreateShader(preprocessShader("files/shaders/object.fx"), {CONVEYOR_BELT = true}, 0, 40, false, "all")
    for _FORV_8_ = 1, #_UPVALUE8_ do
      engineApplyShaderToWorldTexture(_UPVALUE6_, _UPVALUE8_[_FORV_8_])
    end
    engineApplyShaderToWorldTexture(_UPVALUE7_, "*_scroll")
    table.insert(_UPVALUE5_, _UPVALUE6_)
    table.insert(_UPVALUE5_, _UPVALUE7_)
  end
  if preprocessShader("files/shaders/ped.fx") then
    _UPVALUE9_ = dxCreateShader(preprocessShader("files/shaders/ped.fx"), {INSIDE_MINE = true}, 0, 40, false, "ped")
    if isElement(_UPVALUE9_) then
      processDirtyShader()
    end
    table.insert(_UPVALUE5_, _UPVALUE9_)
  end
  for _FORV_8_, _FORV_9_ in pairs(oreTypes) do
    _FORV_9_.oreTexture = dxCreateTexture("files/textures/ores/" .. _FORV_8_ .. ".dds")
    checkMineLoadingTime()
    if _FORV_9_.metallicOre then
      _FORV_9_.glitterTexture = dxCreateTexture("files/textures/ores/" .. _FORV_8_ .. "_metallic.dds")
    end
    checkMineLoadingTime()
    if _FORV_9_.metallicOre then
      _FORV_9_.oreShader = dxCreateShader(preprocessShader("files/shaders/ore.fx"), {METALLIC_ORE = true}, 0, 40, false, "object")
    else
      _FORV_9_.oreShader = dxCreateShader(preprocessShader("files/shaders/ore.fx"), 0, 40, false, "object")
    end
    checkMineLoadingTime()
    if isElement(_FORV_9_.oreShader) then
      dxSetShaderValue(_FORV_9_.oreShader, "OreTexture", _FORV_9_.oreTexture)
      if _FORV_9_.metallicOre then
        dxSetShaderValue(_FORV_9_.oreShader, "NoiseTexture", _UPVALUE1_)
        dxSetShaderValue(_FORV_9_.oreShader, "GlitterTexture", _FORV_9_.glitterTexture)
      end
      table.insert(_UPVALUE5_, _FORV_9_.oreShader)
    end
    checkMineLoadingTime()
  end
  for _FORV_8_ = 1, #_UPVALUE5_ do
    dxSetShaderValue(_UPVALUE5_[_FORV_8_], "PointSurge", _UPVALUE10_ * _UPVALUE11_)
  end
  addEventHandler("onClientPedsProcessed", root, processShaders, true, "low-100")
  collectgarbage()
end
function unloadShaders()
  removeEventHandler("onClientPedsProcessed", root, processShaders)
  for _FORV_3_ in pairs(_UPVALUE0_) do
    for _FORV_7_ in pairs(_UPVALUE0_[_FORV_3_]) do
      checkMineUnloadingTime()
      if isElement(_UPVALUE0_[_FORV_3_][_FORV_7_]) then
        destroyElement(_UPVALUE0_[_FORV_3_][_FORV_7_])
      end
      _UPVALUE0_[_FORV_3_][_FORV_7_] = nil
    end
  end
  _UPVALUE0_ = {}
  _UPVALUE1_ = {}
  _UPVALUE2_ = {}
  _UPVALUE3_ = {}
  _UPVALUE4_ = {}
  _UPVALUE5_ = {}
  _UPVALUE6_ = {}
  _UPVALUE7_ = 0
  _UPVALUE8_ = 0
  _UPVALUE9_ = 0
  _UPVALUE10_ = 0
  _UPVALUE11_ = false
  _UPVALUE12_ = false
  _UPVALUE13_ = false
  _UPVALUE14_ = false
  for _FORV_3_ = 1, #_UPVALUE15_ do
    if isElement(_UPVALUE15_[_FORV_3_]) then
      destroyElement(_UPVALUE15_[_FORV_3_])
    end
  end
  _UPVALUE15_ = _FOR_
  _UPVALUE16_ = nil
  _UPVALUE17_ = nil
  _UPVALUE18_ = nil
  _UPVALUE19_ = nil
  currentActiveShaftShader = nil
  checkMineUnloadingTime()
  for _FORV_3_, _FORV_4_ in pairs(oreTypes) do
    if isElement(_FORV_4_.oreShader) then
      destroyElement(_FORV_4_.oreShader)
    end
    _FORV_4_.oreShader = nil
    if isElement(_FORV_4_.oreTexture) then
      destroyElement(_FORV_4_.oreTexture)
    end
    _FORV_4_.oreTexture = nil
    if isElement(_FORV_4_.glitterTexture) then
      destroyElement(_FORV_4_.glitterTexture)
    end
    _FORV_4_.glitterTexture = nil
  end
  checkMineUnloadingTime()
  if isElement(_UPVALUE20_) then
    destroyElement(_UPVALUE20_)
  end
  if isElement(_UPVALUE21_) then
    destroyElement(_UPVALUE21_)
  end
  if isElement(_UPVALUE22_) then
    destroyElement(_UPVALUE22_)
  end
  if isElement(_UPVALUE23_) then
    destroyElement(_UPVALUE23_)
  end
  _UPVALUE20_ = nil
  _UPVALUE21_ = nil
  _UPVALUE22_ = nil
  _UPVALUE23_ = nil
end
function streamOutDirtyFace(_ARG_0_)
  _UPVALUE0_[_ARG_0_] = nil
  removeDirtyShader(_ARG_0_)
end
function streamInDirtyFace(_ARG_0_)
  _UPVALUE0_[_ARG_0_] = true
  if not _UPVALUE1_ then
    processDirtyShader()
  elseif isElement(_UPVALUE2_) then
    engineApplyShaderToWorldTexture(_UPVALUE2_, "*", _ARG_0_)
    if isElement(_UPVALUE3_) then
      engineRemoveShaderFromWorldTexture(_UPVALUE3_, "*", _ARG_0_)
    end
  elseif isElement(_UPVALUE4_) then
    engineApplyShaderToWorldTexture(_UPVALUE4_, "*", _ARG_0_)
  else
    processDirtyShader()
  end
  if _ARG_0_ == localPlayer and not _UPVALUE5_ then
    addEventHandler("onClientPreRender", root, preRenderSelfDirt)
    _UPVALUE5_ = true
  end
end
function processDirtyShader()
  if not next(_UPVALUE0_) then
    if isElement(_UPVALUE1_) then
      destroyElement(_UPVALUE1_)
    end
    if isElement(_UPVALUE2_) then
      destroyElement(_UPVALUE2_)
    end
    _UPVALUE1_ = nil
    _UPVALUE2_ = nil
    return
  end
  if isElement(_UPVALUE3_) then
    if isElement(_UPVALUE1_) then
      destroyElement(_UPVALUE1_)
    end
    _UPVALUE1_ = nil
  elseif not _UPVALUE1_ then
    if not _UPVALUE4_ then
      _UPVALUE4_ = preprocessShader("files/shaders/ped.fx")
    end
    _UPVALUE1_ = dxCreateShader(_UPVALUE4_, 0, 0, true, "ped")
  end
  if not _UPVALUE2_ then
    _UPVALUE2_ = dxCreateTexture("files/textures/dirtmap.dds")
  end
  if isElement(_UPVALUE2_) then
    if isElement(_UPVALUE1_) then
      dxSetShaderValue(_UPVALUE1_, "DirtMapTexture", _UPVALUE2_)
    end
    if isElement(_UPVALUE3_) then
      dxSetShaderValue(_UPVALUE3_, "DirtMapTexture", _UPVALUE2_)
    end
  end
  for _FORV_3_ in pairs(_UPVALUE0_) do
    if isElement(_UPVALUE3_) then
      engineApplyShaderToWorldTexture(_UPVALUE3_, "*", _FORV_3_)
      if isElement(_UPVALUE5_) then
        engineRemoveShaderFromWorldTexture(_UPVALUE5_, "*", _FORV_3_)
      end
      if isElement(_UPVALUE1_) then
        engineRemoveShaderFromWorldTexture(_UPVALUE1_, "*", _FORV_3_)
      end
    elseif isElement(_UPVALUE1_) then
      engineApplyShaderToWorldTexture(_UPVALUE1_, "*", _FORV_3_)
    end
  end
end
function removeDirtyShader(_ARG_0_)
  if isElement(_UPVALUE0_) then
    engineRemoveShaderFromWorldTexture(_UPVALUE0_, "*", _ARG_0_)
  end
  if isElement(_UPVALUE1_) then
    engineRemoveShaderFromWorldTexture(_UPVALUE1_, "*", _ARG_0_)
    if isElement(_UPVALUE2_) then
      engineApplyShaderToWorldTexture(_UPVALUE2_, "*", _ARG_0_)
    end
  end
  if not next(_UPVALUE3_) then
    if isElement(_UPVALUE0_) then
      destroyElement(_UPVALUE0_)
    end
    if isElement(_UPVALUE4_) then
      destroyElement(_UPVALUE4_)
    end
    _UPVALUE0_ = nil
    _UPVALUE4_ = nil
  end
end
function preRenderSelfDirt()
  if getPedSimplestTask(localPlayer) == "TASK_SIMPLE_SWIM" then
    _UPVALUE0_[localPlayer] = nil
    triggerServerEvent("removeMineDirtyFace", localPlayer)
    removeDirtyShader(localPlayer)
  end
  if not _UPVALUE0_[localPlayer] and _UPVALUE1_ then
    removeEventHandler("onClientPreRender", root, preRenderSelfDirt)
    _UPVALUE1_ = false
  end
end
function removeShaderFromObject(_ARG_0_)
  if isElement(_UPVALUE0_) then
    engineRemoveShaderFromWorldTexture(_UPVALUE0_, "*", _ARG_0_)
  end
end
function processShaders()
  if loaderAlpha < 1 then
    if nextSurge then
      _UPVALUE0_ = (mineTick - nextSurge) / 150
      if _UPVALUE0_ > 1 then
        nextSurge = false
        _UPVALUE0_ = 1
      end
      _UPVALUE0_ = 1 - math.cos(_UPVALUE0_ * math.pi / 2) * 0.75
      for _FORV_6_ = 1, #_UPVALUE1_ do
        dxSetShaderValue(_UPVALUE1_[_FORV_6_], "PointSurge", _UPVALUE0_ * _UPVALUE2_)
      end
    end
    if mineMachineData.machineRunning or mineMachineData.forceMachine then
    end
    if mineFoundryData.furnaceRunning then
    end
    if _UPVALUE2_ ~= 1 - 0.2 - 0.3 then
      _UPVALUE2_ = 1 - 0.2 - 0.3
      for _FORV_7_ = 1, #_UPVALUE1_ do
        dxSetShaderValue(_UPVALUE1_[_FORV_7_], "PointSurge", _UPVALUE0_ * _UPVALUE2_)
      end
    end
    _UPVALUE3_ = _UPVALUE3_ + mineDelta / _UPVALUE4_ * math.min(1, mineMachineData.machineRunProgress)
    if _UPVALUE3_ > 1 then
      _UPVALUE3_ = 0
    end
    if isElement(_UPVALUE5_) then
      dxSetShaderValue(_UPVALUE5_, "ConveyorBeltScroll", _UPVALUE3_)
    end
    if isElement(mineMachineData.mineMachine3) then
      setElementRotation(mineMachineData.mineMachine3, _UPVALUE3_ * 360, 0, 0)
    end
    iterateGrid(_UPVALUE6_, selfMineX - 8, selfMineY - 8, selfMineX + 8, selfMineY + 8, function(_ARG_0_, _ARG_1_, _ARG_2_)
      if _UPVALUE0_[_ARG_1_] and _UPVALUE0_[_ARG_1_][_ARG_2_] then
        if mineTick - _UPVALUE0_[_ARG_1_][_ARG_2_] > 600 then
          _UPVALUE0_[_ARG_1_][_ARG_2_] = nil
        end
        if math.random() < 0.9 then
        else
        end
      end
      if false then
        if minePosX + _ARG_1_ * 6 ~= (_UPVALUE1_[_UPVALUE2_] or {})[1] or minePosY + _ARG_2_ * 6 ~= (_UPVALUE1_[_UPVALUE2_] or {})[2] then
          (_UPVALUE1_[_UPVALUE2_] or {})[2], (_UPVALUE1_[_UPVALUE2_] or {})[1], _UPVALUE1_[_UPVALUE2_] = minePosY + _ARG_2_ * 6, minePosX + _ARG_1_ * 6, _UPVALUE1_[_UPVALUE2_] or {}
          ;(_UPVALUE1_[_UPVALUE2_] or {})[3] = (_UPVALUE1_[_UPVALUE2_] or {})[3] and true or false
          ;(_UPVALUE1_[_UPVALUE2_] or {})[4] = _ARG_1_ < -1
          ;(_UPVALUE1_[_UPVALUE2_] or {})[5] = _ARG_0_
          _UPVALUE3_ = true
        end
        _UPVALUE2_ = _UPVALUE2_ + 1
      end
    end)
    for _FORV_12_ = #_UPVALUE8_, 1, -1 do
      if _FORV_12_ >= 1 then
        if _UPVALUE8_[_FORV_12_][3] then
          _UPVALUE9_ = true
        end
        table.remove(_UPVALUE8_, _FORV_12_)
      elseif getDistanceBetweenPoints2D(selfPosX, selfPosY, _UPVALUE8_[_FORV_12_][1], _UPVALUE8_[_FORV_12_][2]) <= 48 then
        if _UPVALUE8_[_FORV_12_][4] then
          dxDrawMaterialLine3D(_UPVALUE8_[_FORV_12_][1], _UPVALUE8_[_FORV_12_][2], minePosZ + 4.25, _UPVALUE8_[_FORV_12_][1], _UPVALUE8_[_FORV_12_][2], minePosZ - 0.5, _UPVALUE11_, 6, tocolor(244.8, 224.4, 140.25, 100 * math.min(1, math.max(0, (getDistanceBetweenPoints2D(_UPVALUE8_[_FORV_12_][1], _UPVALUE8_[_FORV_12_][2], selfCamX, selfCamY) - 1) / 4)) * _UPVALUE0_))
        else
          dxDrawMaterialLine3D(_UPVALUE8_[_FORV_12_][1], _UPVALUE8_[_FORV_12_][2], minePosZ + 2.25, _UPVALUE8_[_FORV_12_][1], _UPVALUE8_[_FORV_12_][2], minePosZ - 0.5, _UPVALUE11_, 4, tocolor(244.8, 224.4, 140.25, 100 * math.min(1, math.max(0, (getDistanceBetweenPoints2D(_UPVALUE8_[_FORV_12_][1], _UPVALUE8_[_FORV_12_][2], selfCamX, selfCamY) - 1) / 4)) * _UPVALUE0_))
        end
        if isElementOnScreen(_UPVALUE8_[_FORV_12_][5]) then
          if _UPVALUE8_[_FORV_12_][4] then
            dxDrawMaterialLine3D(_UPVALUE8_[_FORV_12_][1] - computeParticleVector() * 0.6, _UPVALUE8_[_FORV_12_][2] - computeParticleVector() * 0.6, minePosZ + 4.1 - computeParticleVector() * 0.6, _UPVALUE8_[_FORV_12_][1] + computeParticleVector() * 0.6, _UPVALUE8_[_FORV_12_][2] + computeParticleVector() * 0.6, minePosZ + 4.1 + computeParticleVector() * 0.6, _UPVALUE12_, 0.6, tocolor(244.8, 224.4, 140.25, 200 * math.min(1, math.max(0, (getDistanceBetweenPoints3D(_UPVALUE8_[_FORV_12_][1], _UPVALUE8_[_FORV_12_][2], minePosZ + (_UPVALUE8_[_FORV_12_][4] and 4 or 2), selfCamX, selfCamY, selfCamZ) - 1) / 4)) * _UPVALUE0_))
          else
            dxDrawMaterialLine3D(_UPVALUE8_[_FORV_12_][1] - computeParticleVector() * 0.6, _UPVALUE8_[_FORV_12_][2] - computeParticleVector() * 0.6, minePosZ + 2.1 - computeParticleVector() * 0.6, _UPVALUE8_[_FORV_12_][1] + computeParticleVector() * 0.6, _UPVALUE8_[_FORV_12_][2] + computeParticleVector() * 0.6, minePosZ + 2.1 + computeParticleVector() * 0.6, _UPVALUE12_, 0.6, tocolor(244.8, 224.4, 140.25, 200 * math.min(1, math.max(0, (getDistanceBetweenPoints3D(_UPVALUE8_[_FORV_12_][1], _UPVALUE8_[_FORV_12_][2], minePosZ + (_UPVALUE8_[_FORV_12_][4] and 4 or 2), selfCamX, selfCamY, selfCamZ) - 1) / 4)) * _UPVALUE0_))
          end
        end
        if not _UPVALUE8_[_FORV_12_][3] then
          _UPVALUE8_[_FORV_12_][3] = true
          _UPVALUE9_ = true
        end
      elseif _UPVALUE8_[_FORV_12_][3] then
        _UPVALUE8_[_FORV_12_][3] = false
        _UPVALUE9_ = true
      end
    end
    if mineMachineData.machineRunProgress >= 0.1 then
    end
    if currentMineInventory.dieselLoco and 0 < getLocoEngineRev() and getDistanceBetweenPoints2D(getFirstRailCarPosition()) <= 60 then
      if -1 <= convertSingleMineCoordinate(getFirstRailCarPosition() + getFirstRailCarPosition() * 1.285) then
        if 1 > getLocoEngineRev() and getLocoEngineRev() <= mineTick % 200 / 200 then
        end
      end
      if 1 <= getLocoEngineRev() then
      end
    end
    for _FORV_15_ = #bombDetonations, 1, -1 do
    end
    for _FORV_15_ = #_FOR_, 1, -1 do
      table.remove(_UPVALUE13_, _FORV_15_)
    end
    if _FOR_.meltingOre then
      if 1 < mineFoundryData.meltProgress * 7.5 then
      end
      if isElement(_UPVALUE14_) then
        dxSetShaderValue(_UPVALUE14_, "MeltProgress", (getEasingValue(math.max(0, 1 - (mineFoundryData.meltProgress * 7.5 - 1) / 6), "OutQuad")))
      end
      if 0 < 0.25 + 1.25 * getEasingValue(math.max(0, 1 - (mineFoundryData.meltProgress * 7.5 - 1) / 6), "OutQuad") * getEasingValue(math.min(1, mineFoundryData.meltProgress * 7.5 / 0.3) * 0.3 + math.min(1, math.max(0, (mineFoundryData.meltProgress * 7.5 - 0.3) / 0.7)) * 0.7, "OutQuad") then
      end
    end
    if _UPVALUE10_ ~= _UPVALUE10_ - 1 + 1 - 1 then
      _UPVALUE10_ = _UPVALUE10_ - 1 + 1 - 1
      _UPVALUE9_ = true
    end
    if _UPVALUE9_ then
      refreshPointLights()
      if #_UPVALUE8_ <= _UPVALUE15_ then
        _UPVALUE9_ = false
      end
    end
    for _FORV_15_ = #_UPVALUE16_, processSpotLight(0, getFirstRailCarPosition() + getFirstRailCarPosition() * 1.285, getFirstRailCarPosition() + getFirstRailCarPosition() * 1.285, minePosZ - 5000, getFirstRailCarPosition()) + 1, -1 do
      table.remove(_UPVALUE16_, _FORV_15_)
    end
    if _UPVALUE17_ ~= #_UPVALUE16_ then
      _UPVALUE17_ = #_UPVALUE16_
      _UPVALUE18_ = false
    end
    if _UPVALUE18_ then
      refreshSpotLights()
      if #_UPVALUE16_ <= _UPVALUE15_ then
        _UPVALUE18_ = false
      end
    end
    for _FORV_15_ = #_UPVALUE19_, processRedLight(processRedLight(0, minePosX - 15.7845 + math.cos(mineTick % 750 / 750 * math.pi * 2) * 0.08, minePosY + 6.4795 + math.sin(mineTick % 750 / 750 * math.pi * 2) * 0.08, minePosZ + 2.2412, math.cos(mineTick % 750 / 750 * math.pi * 2), math.sin(mineTick % 750 / 750 * math.pi * 2), 0), getFirstRailCarPosition() + getFirstRailCarPosition() * 1.15233 - getFirstRailCarPosition() * 0.462 + math.cos(mineTick % 750 / 750 * math.pi * 2) * 0.08, getFirstRailCarPosition() + getFirstRailCarPosition() * 1.15233 + getFirstRailCarPosition() * 0.462 + math.sin(mineTick % 750 / 750 * math.pi * 2) * 0.08, minePosZ + 1.4138, math.cos(mineTick % 750 / 750 * math.pi * 2), math.sin(mineTick % 750 / 750 * math.pi * 2), 0) + 1, -1 do
      table.remove(_UPVALUE19_, _FORV_15_)
    end
    if _UPVALUE20_ ~= #_UPVALUE19_ then
      _UPVALUE20_ = #_UPVALUE19_
      _UPVALUE21_ = true
    end
    if _UPVALUE21_ then
      refreshRedLights()
      if #_UPVALUE19_ <= _UPVALUE22_ then
        _UPVALUE21_ = false
      end
    end
    for _FORV_15_ = #_UPVALUE23_, processOrangeLight(processOrangeLight(processOrangeLight(0, unpack(bombDetonations[_FORV_15_])), unpack(_UPVALUE13_[_FORV_15_])), oreTypes[mineFoundryData.meltingOre].meltPosition[1], oreTypes[mineFoundryData.meltingOre].meltPosition[2], oreTypes[mineFoundryData.meltingOre].meltPosition[3], 0.25 + 1.25 * getEasingValue(math.max(0, 1 - (mineFoundryData.meltProgress * 7.5 - 1) / 6), "OutQuad") * getEasingValue(math.min(1, mineFoundryData.meltProgress * 7.5 / 0.3) * 0.3 + math.min(1, math.max(0, (mineFoundryData.meltProgress * 7.5 - 0.3) / 0.7)) * 0.7, "OutQuad"), math.min(2, getEasingValue(math.max(0, 1 - (mineFoundryData.meltProgress * 7.5 - 1) / 6), "OutQuad") * 5) * getEasingValue(math.min(1, mineFoundryData.meltProgress * 7.5 / 0.3) * 0.3 + math.min(1, math.max(0, (mineFoundryData.meltProgress * 7.5 - 0.3) / 0.7)) * 0.7, "OutQuad"), (getEasingValue(math.max(0, 1 - (mineFoundryData.meltProgress * 7.5 - 1) / 6), "OutQuad"))) + 1, -1 do
      table.remove(_UPVALUE23_, _FORV_15_)
    end
    if _FOR_ ~= processOrangeLight(processOrangeLight(processOrangeLight(0, unpack(bombDetonations[_FORV_15_])), unpack(_UPVALUE13_[_FORV_15_])), oreTypes[mineFoundryData.meltingOre].meltPosition[1], oreTypes[mineFoundryData.meltingOre].meltPosition[2], oreTypes[mineFoundryData.meltingOre].meltPosition[3], 0.25 + 1.25 * getEasingValue(math.max(0, 1 - (mineFoundryData.meltProgress * 7.5 - 1) / 6), "OutQuad") * getEasingValue(math.min(1, mineFoundryData.meltProgress * 7.5 / 0.3) * 0.3 + math.min(1, math.max(0, (mineFoundryData.meltProgress * 7.5 - 0.3) / 0.7)) * 0.7, "OutQuad"), math.min(2, getEasingValue(math.max(0, 1 - (mineFoundryData.meltProgress * 7.5 - 1) / 6), "OutQuad") * 5) * getEasingValue(math.min(1, mineFoundryData.meltProgress * 7.5 / 0.3) * 0.3 + math.min(1, math.max(0, (mineFoundryData.meltProgress * 7.5 - 0.3) / 0.7)) * 0.7, "OutQuad"), (getEasingValue(math.max(0, 1 - (mineFoundryData.meltProgress * 7.5 - 1) / 6), "OutQuad"))) then
      _UPVALUE24_ = processOrangeLight(processOrangeLight(processOrangeLight(0, unpack(bombDetonations[_FORV_15_])), unpack(_UPVALUE13_[_FORV_15_])), oreTypes[mineFoundryData.meltingOre].meltPosition[1], oreTypes[mineFoundryData.meltingOre].meltPosition[2], oreTypes[mineFoundryData.meltingOre].meltPosition[3], 0.25 + 1.25 * getEasingValue(math.max(0, 1 - (mineFoundryData.meltProgress * 7.5 - 1) / 6), "OutQuad") * getEasingValue(math.min(1, mineFoundryData.meltProgress * 7.5 / 0.3) * 0.3 + math.min(1, math.max(0, (mineFoundryData.meltProgress * 7.5 - 0.3) / 0.7)) * 0.7, "OutQuad"), math.min(2, getEasingValue(math.max(0, 1 - (mineFoundryData.meltProgress * 7.5 - 1) / 6), "OutQuad") * 5) * getEasingValue(math.min(1, mineFoundryData.meltProgress * 7.5 / 0.3) * 0.3 + math.min(1, math.max(0, (mineFoundryData.meltProgress * 7.5 - 0.3) / 0.7)) * 0.7, "OutQuad"), (getEasingValue(math.max(0, 1 - (mineFoundryData.meltProgress * 7.5 - 1) / 6), "OutQuad")))
      _UPVALUE25_ = true
    end
    if _UPVALUE25_ then
      refreshOrangeLights()
      if #_UPVALUE23_ <= _UPVALUE26_ then
        _UPVALUE25_ = false
      end
    end
  end
end
function processSpotLight(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_, _ARG_5_, _ARG_6_)
  _ARG_0_ = _ARG_0_ + 1
  dxDrawMaterialLine3D(_ARG_1_, _ARG_2_, _ARG_3_ + 0.3, _ARG_1_, _ARG_2_, _ARG_3_ - 0.3, _UPVALUE1_, 0.6, tocolor(255, 242.25, 191.25, (1 - (1 - math.abs(_ARG_4_ * selfCamDirX + _ARG_5_ * selfCamDirY + _ARG_6_ * selfCamDirZ))) * 200), _ARG_1_ + _ARG_4_, _ARG_2_ + _ARG_5_, _ARG_3_ + _ARG_6_)
  if _UPVALUE2_(_UPVALUE0_[_ARG_0_] or {}, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_, _ARG_5_, _ARG_6_) then
    _UPVALUE3_ = true
  end
  if _UPVALUE3_ then
    _UPVALUE0_[_ARG_0_] = _UPVALUE0_[_ARG_0_] or {}
  end
  return _ARG_0_
end
function processRedLight(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_, _ARG_5_, _ARG_6_)
  _ARG_0_ = _ARG_0_ + 1
  dxDrawMaterialLine3D(_ARG_1_, _ARG_2_, _ARG_3_ + 0.3, _ARG_1_, _ARG_2_, _ARG_3_ - 0.3, _UPVALUE1_, 0.6, tocolor(255, 25, 25, (1 - (1 - math.abs(_ARG_4_ * selfCamDirX + _ARG_5_ * selfCamDirY + _ARG_6_ * selfCamDirZ))) * 200), _ARG_1_ + _ARG_4_, _ARG_2_ + _ARG_5_, _ARG_3_ + _ARG_6_)
  if _UPVALUE2_(_UPVALUE0_[_ARG_0_] or {}, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_, _ARG_5_, _ARG_6_) then
    _UPVALUE3_ = true
  end
  if _UPVALUE3_ then
    _UPVALUE0_[_ARG_0_] = _UPVALUE0_[_ARG_0_] or {}
  end
  return _ARG_0_
end
function processOrangeLight(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_, _ARG_5_, _ARG_6_)
  if getDistanceBetweenPoints2D(_ARG_1_, _ARG_2_, selfPosX, selfPosY) <= 40 + _ARG_4_ then
    _ARG_0_ = _ARG_0_ + 1
    _ARG_6_ = tonumber(_ARG_6_) or -1
    if _UPVALUE1_(_UPVALUE0_[_ARG_0_] or {}, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_, _ARG_5_, _ARG_6_) then
      _UPVALUE2_ = true
    end
    if _UPVALUE2_ then
      _UPVALUE0_[_ARG_0_] = _UPVALUE0_[_ARG_0_] or {}
    end
    return _ARG_0_
  end
end
function refreshPointLights()
  for _FORV_4_ = 1, #_UPVALUE0_ do
    if _UPVALUE0_[_FORV_4_][3] then
      table.insert({}, {
        _UPVALUE0_[_FORV_4_][1],
        _UPVALUE0_[_FORV_4_][2],
        getDistanceBetweenPoints2D(selfPosX, selfPosY, _UPVALUE0_[_FORV_4_][1], _UPVALUE0_[_FORV_4_][2]),
        _UPVALUE0_[_FORV_4_][4]
      })
    end
  end
  _FOR_.sort({}, _UPVALUE1_)
  for _FORV_4_ = 1, math.min(_UPVALUE2_, #{}) do
    for _FORV_11_ = 1, #_UPVALUE3_ do
      dxSetShaderValue(_UPVALUE3_[_FORV_11_], "PointLightPos" .. _FORV_4_, ({})[_FORV_4_][1], ({})[_FORV_4_][2], minePosZ + (({})[_FORV_4_][4] and 2 or 0))
      dxSetShaderValue(_UPVALUE3_[_FORV_11_], "PointLightState" .. _FORV_4_, true)
    end
  end
  for _FORV_4_ = _FOR_ + 1, _UPVALUE2_ do
    for _FORV_8_ = 1, #_UPVALUE3_ do
      dxSetShaderValue(_UPVALUE3_[_FORV_8_], "PointLightState" .. _FORV_4_, false)
    end
  end
end
function refreshSpotLights()
  for _FORV_3_ = 1, math.min(_UPVALUE0_, #_UPVALUE1_) do
    for _FORV_13_ = 1, #_UPVALUE2_ do
      dxSetShaderValue(_UPVALUE2_[_FORV_13_], "SpotLightPos" .. _FORV_3_, unpack(_UPVALUE1_[_FORV_3_]))
      dxSetShaderValue(_UPVALUE2_[_FORV_13_], "SpotLightDir" .. _FORV_3_, unpack(_UPVALUE1_[_FORV_3_]))
      dxSetShaderValue(_UPVALUE2_[_FORV_13_], "SpotLightState" .. _FORV_3_, true)
    end
  end
  for _FORV_3_ = #_FOR_ + 1, _UPVALUE0_ do
    for _FORV_7_ = 1, #_UPVALUE2_ do
      dxSetShaderValue(_UPVALUE2_[_FORV_7_], "SpotLightState" .. _FORV_3_, false)
    end
  end
end
function refreshRedLights()
  for _FORV_3_ = 1, math.min(_UPVALUE0_, #_UPVALUE1_) do
    for _FORV_13_ = 1, #_UPVALUE2_ do
      dxSetShaderValue(_UPVALUE2_[_FORV_13_], "RedLightPos" .. _FORV_3_, unpack(_UPVALUE1_[_FORV_3_]))
      dxSetShaderValue(_UPVALUE2_[_FORV_13_], "RedLightDir" .. _FORV_3_, unpack(_UPVALUE1_[_FORV_3_]))
      dxSetShaderValue(_UPVALUE2_[_FORV_13_], "RedLightState" .. _FORV_3_, true)
    end
  end
  for _FORV_3_ = #_FOR_ + 1, _UPVALUE0_ do
    for _FORV_7_ = 1, #_UPVALUE2_ do
      dxSetShaderValue(_UPVALUE2_[_FORV_7_], "RedLightState" .. _FORV_3_, false)
    end
  end
end
function refreshOrangeLights()
  for _FORV_4_ = 1, #_UPVALUE0_ do
    table.insert({}, {
      _UPVALUE0_[_FORV_4_][1],
      _UPVALUE0_[_FORV_4_][2],
      _UPVALUE0_[_FORV_4_][3],
      _UPVALUE0_[_FORV_4_][4],
      _UPVALUE0_[_FORV_4_][5],
      _UPVALUE0_[_FORV_4_][6],
      getDistanceBetweenPoints2D(selfPosX, selfPosY, _UPVALUE0_[_FORV_4_][1], _UPVALUE0_[_FORV_4_][2])
    })
  end
  _FOR_.sort({}, _UPVALUE1_)
  for _FORV_4_ = 1, math.min(_UPVALUE2_, #{}) do
    for _FORV_14_ = 1, #_UPVALUE3_ do
      dxSetShaderValue(_UPVALUE3_[_FORV_14_], "OrangeLightPos" .. _FORV_4_, unpack(({})[_FORV_4_]))
      dxSetShaderValue(_UPVALUE3_[_FORV_14_], "OrangeLightData" .. _FORV_4_, unpack(({})[_FORV_4_]))
      dxSetShaderValue(_UPVALUE3_[_FORV_14_], "OrangeLightProgress" .. _FORV_4_, unpack(({})[_FORV_4_]))
      dxSetShaderValue(_UPVALUE3_[_FORV_14_], "OrangeLightState" .. _FORV_4_, true)
    end
  end
  for _FORV_4_ = _FOR_ + 1, _UPVALUE2_ do
    for _FORV_8_ = 1, #_UPVALUE3_ do
      dxSetShaderValue(_UPVALUE3_[_FORV_8_], "OrangeLightState" .. _FORV_4_, false)
    end
  end
end
function addOrangeLight(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  table.insert(_UPVALUE0_, {
    _ARG_0_,
    _ARG_1_,
    _ARG_2_,
    _ARG_3_,
    _ARG_4_
  })
end
function dxDrawLightCone3D(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_, _ARG_5_, _ARG_6_, _ARG_7_)
  if processLineOfSight(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_, _ARG_5_) then
  end
  dxDrawMaterialLine3D(_ARG_0_, _ARG_1_, _ARG_2_, processLineOfSight(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_, _ARG_5_) or _ARG_3_, processLineOfSight(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_, _ARG_5_) or _ARG_4_, processLineOfSight(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_, _ARG_5_) or _ARG_5_, _UPVALUE0_, _ARG_6_ * 4 * (getDistanceBetweenPoints3D(_ARG_0_, _ARG_1_, _ARG_2_, processLineOfSight(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_, _ARG_5_)) / getDistanceBetweenPoints3D(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_, _ARG_5_)), _ARG_7_)
end
function preprocessShader(_ARG_0_)
  if fileOpen(_ARG_0_, true) then
    if fileGetContents((fileOpen(_ARG_0_, true))) then
      if fileOpen("files/shaders/lighthelper.fxh", true) then
        if fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))) then
          for _FORV_10_ = 1, #split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))), "\n") do
            if split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))), "\n")[_FORV_10_]:match(">export:(%w+)") then
              ({})[split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))), "\n")[_FORV_10_]:match(">export:(%w+)")] = true
            end
          end
          for _FORV_10_ in pairs({}) do
            if fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)) then
              if fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) then
                table.remove(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), 1)
                table.remove(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), #split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"))
              else
                outputDebugString("[Shader Preprocessor]: Failed to find end of export '" .. _FORV_10_ .. "'", 1)
              end
            else
            end
          end
        else
          outputDebugString("[Shader Preprocessor]: Failed to load helper shader", 2)
        end
        fileClose((fileOpen("files/shaders/lighthelper.fxh", true)))
      end
      for _FORV_8_, _FORV_9_ in pairs({
        maxSpotLights = _UPVALUE0_,
        maxPointLights = _UPVALUE1_,
        maxRedLights = _UPVALUE2_,
        maxOrangeLights = _UPVALUE3_,
        wallMeshWidth = wallMeshWidth,
        wallMeshHeight = wallMeshHeight,
        wallMaximumDepth = wallMaximumDepth,
        insideFarClipDistance = insideFarClipDistance
      }) do
      end
      while fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):find("::loop") do
        if fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):find("::end", (fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):find("::loop"))) then
          if #split(fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):sub(fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):find("::loop"), fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):find("::end", (fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):find("::loop"))) + 4), "\n") > 0 then
            if split(fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):sub(fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):find("::loop"), fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):find("::end", (fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):find("::loop"))) + 4), "\n")[1]:match("::loop%((%w+),%s*(%d+),%s*(%d+)%)") and split(fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):sub(fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):find("::loop"), fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):find("::end", (fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):find("::loop"))) + 4), "\n")[1]:match("::loop%((%w+),%s*(%d+),%s*(%d+)%)") and split(fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):sub(fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):find("::loop"), fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):find("::end", (fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):find("::loop"))) + 4), "\n")[1]:match("::loop%((%w+),%s*(%d+),%s*(%d+)%)") then
              table.remove(split(fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):sub(fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):find("::loop"), fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):find("::end", (fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):find("::loop"))) + 4), "\n"), 1)
              table.remove(split(fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):sub(fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):find("::loop"), fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):find("::end", (fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):find("::loop"))) + 4), "\n"), #split(fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):sub(fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):find("::loop"), fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):find("::end", (fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):find("::loop"))) + 4), "\n"))
              for _FORV_16_ = tonumber(split(fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):sub(fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):find("::loop"), fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):find("::end", (fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):find("::loop"))) + 4), "\n")[1]:match("::loop%((%w+),%s*(%d+),%s*(%d+)%)")), tonumber(split(fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):sub(fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):find("::loop"), fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):find("::end", (fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):find("::loop"))) + 4), "\n")[1]:match("::loop%((%w+),%s*(%d+),%s*(%d+)%)")) do
                if _FORV_16_ < tonumber(split(fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):sub(fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):find("::loop"), fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):find("::end", (fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):find("::loop"))) + 4), "\n")[1]:match("::loop%((%w+),%s*(%d+),%s*(%d+)%)")) then
                end
              end
            else
              outputDebugString("[Shader Preprocessor]: Failed to parse loop in " .. fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):sub(1, fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):find("::loop") - 1) .. (("" .. table.concat(split(fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):sub(fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):find("::loop"), fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):find("::end", (fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):find("::loop"))) + 4), "\n"), "\n"):gsub("%(:" .. split(fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):sub(fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):find("::loop"), fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):find("::end", (fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):find("::loop"))) + 4), "\n")[1]:match("::loop%((%w+),%s*(%d+),%s*(%d+)%)") .. ":%)", _FORV_16_)) .. "\n") .. fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):sub(fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):find("::end", (fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):find("::loop"))) + 5), 1)
            end
          else
            outputDebugString("[Shader Preprocessor]: Empty loop in " .. fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):sub(1, fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):find("::loop") - 1) .. (("" .. table.concat(split(fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):sub(fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):find("::loop"), fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):find("::end", (fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):find("::loop"))) + 4), "\n"), "\n"):gsub("%(:" .. split(fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):sub(fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):find("::loop"), fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):find("::end", (fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):find("::loop"))) + 4), "\n")[1]:match("::loop%((%w+),%s*(%d+),%s*(%d+)%)") .. ":%)", _FORV_16_)) .. "\n") .. fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):sub(fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):find("::end", (fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):find("::loop"))) + 5), 2)
          end
        else
          outputDebugString("[Shader Preprocessor]: Missing loop end in " .. fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):sub(1, fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):find("::loop") - 1) .. (("" .. table.concat(split(fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):sub(fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):find("::loop"), fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):find("::end", (fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):find("::loop"))) + 4), "\n"), "\n"):gsub("%(:" .. split(fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):sub(fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):find("::loop"), fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):find("::end", (fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):find("::loop"))) + 4), "\n")[1]:match("::loop%((%w+),%s*(%d+),%s*(%d+)%)") .. ":%)", _FORV_16_)) .. "\n") .. fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):sub(fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):find("::end", (fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):find("::loop"))) + 5), 1)
        end
      end
    end
    fileClose((fileOpen(_ARG_0_, true)))
  end
  return fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):sub(1, fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):find("::loop") - 1) .. (("" .. table.concat(split(fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):sub(fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):find("::loop"), fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):find("::end", (fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):find("::loop"))) + 4), "\n"), "\n"):gsub("%(:" .. split(fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):sub(fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):find("::loop"), fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):find("::end", (fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):find("::loop"))) + 4), "\n")[1]:match("::loop%((%w+),%s*(%d+),%s*(%d+)%)") .. ":%)", _FORV_16_)) .. "\n") .. fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):sub(fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):find("::end", (fileGetContents((fileOpen(_ARG_0_, true))):gsub(("::%s::"):format(_FORV_10_), table.concat(split(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):sub(fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)), fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find("<exportend", (fileGetContents((fileOpen("files/shaders/lighthelper.fxh", true))):find((">export:%s"):format(_FORV_10_)))) + 9), "\n"), "\n")):gsub(("::%s::"):format(_FORV_10_), ""):gsub(("::%s::"):format(_FORV_8_), _FORV_9_):find("::loop"))) + 5)
end
