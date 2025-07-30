currentMineOrdering = {}
function setTabletMode(_ARG_0_)
  tabletItem = _ARG_0_
  if type(tabletItem) == "number" then
    if currentMine then
      if triggerServerEvent("syncMineTablet", localPlayer, true) then
        createTablet()
        return true
      end
    else
      exports.see_gui:showInfobox("e", "Csak bányában veheted elő!")
    end
  elseif triggerServerEvent("syncMineTablet", localPlayer) then
    deleteTablet()
    return true
  end
  return false
end
addEvent("syncMineTablet", true)
addEventHandler("syncMineTablet", root, function(_ARG_0_)
  if _ARG_0_ then
    if isElement(source) and not _UPVALUE0_[source] then
      _UPVALUE0_[source] = true
      addEventHandler("onClientPlayerStreamIn", source, streamTablet)
      addEventHandler("onClientPlayerStreamOut", source, streamTablet)
      addEventHandler("onClientPlayerQuit", source, streamTablet)
    end
  elseif _UPVALUE0_[source] then
    _UPVALUE0_[source] = nil
    removeEventHandler("onClientPlayerStreamIn", source, streamTablet)
    removeEventHandler("onClientPlayerStreamOut", source, streamTablet)
    removeEventHandler("onClientPlayerQuit", source, streamTablet)
  end
  processTablet(source)
end)
addEvent("renameMineResponse", true)
addEventHandler("renameMineResponse", localPlayer, function(_ARG_0_, _ARG_1_)
  if _ARG_0_ then
    currentMineName = _ARG_0_
  end
  mineNameSyncing = false
  mineNameEdited = false
  if _ARG_1_ then
    exports.see_gui:showInfobox("e", _ARG_1_)
  end
  shouldRefreshUrmaMotoDevice = true
end)
addEvent("mineOrderResponse", true)
addEventHandler("mineOrderResponse", localPlayer, function(_ARG_0_, _ARG_1_)
  mineOrderSyncing = false
  if _ARG_1_ then
    exports.see_gui:showInfobox(_ARG_0_ and "s" or "e", _ARG_1_)
  end
  shouldRefreshUrmaMotoDevice = true
end)
function streamTablet()
  if eventName == "onClientPlayerQuit" then
    _UPVALUE0_[source] = nil
  end
  processTablet(source)
end
function processTablet(_ARG_0_, _ARG_1_)
  if not isElementStreamedIn(_ARG_0_) then
  else
  end
  if false and isPlayerFreeFromAction(_ARG_0_) and isRailCarSyncer(_ARG_0_) and false then
    if not _UPVALUE1_[_ARG_0_] then
      _UPVALUE1_[_ARG_0_] = createObject(modelIds.v4_mine_tablet, 0, 0, 0)
      if isElement(_UPVALUE1_[_ARG_0_]) then
        setElementInterior(_UPVALUE1_[_ARG_0_], 0)
        setElementDimension(_UPVALUE1_[_ARG_0_], currentMine)
      end
    end
    if isElement(_UPVALUE1_[_ARG_0_]) then
      exports.pattach:attach(_UPVALUE1_[_ARG_0_], _ARG_0_, 25, 0.10783896003808, 0.013285117814657, 0, 0, 0)
      exports.pattach:setRotationQuaternion(_UPVALUE1_[_ARG_0_], {
        0.059827387447574,
        -0.038785605657951,
        0.72739675435797,
        0.68250298333007
      })
    end
  else
    if isElement(_UPVALUE1_[_ARG_0_]) then
      destroyElement(_UPVALUE1_[_ARG_0_])
    end
    _UPVALUE1_[_ARG_0_] = nil
  end
end
function pedsProcessedTablet(_ARG_0_)
  for _FORV_4_ in pairs(_UPVALUE0_) do
    if isElement(_FORV_4_) and isElementOnScreen(_FORV_4_) then
      setElementBoneRotation(_FORV_4_, 22, 51.73919511878, -74.347910673722, -58.695642222529)
      setElementBoneRotation(_FORV_4_, 23, -50.869565217392, -78.260849662452, -9.1302705847697)
      setElementBoneRotation(_FORV_4_, 24, -142.17389314071, -35.217426134192, -24.782568890116)
      setElementBoneRotation(_FORV_4_, 25, -1.3044174857762, 10.43479256008, 16.956457055133)
      setElementBoneRotation(_FORV_4_, 26, -5.2173266203507, 15.652084350586, 0)
      _ARG_0_[_FORV_4_] = true
    end
  end
end
function createTablet()
  if currentMine then
    if not _UPVALUE0_ and not _UPVALUE1_ then
      initUrmaMotoDevice(true)
    end
    _UPVALUE0_ = true
  end
end
function deleteTablet()
  _UPVALUE0_ = false
  endTabletMoving()
  if not _UPVALUE0_ and not _UPVALUE1_ then
    initUrmaMotoDevice(false)
  end
end
function createComputer()
  if not _UPVALUE0_ and not _UPVALUE1_ then
    initUrmaMotoDevice(true)
  end
  if _UPVALUE2_ < 1 then
    playSound("files/sounds/computeron.wav")
  end
  if not _UPVALUE1_ then
    addEventHandler("onClientPreRender", root, handleComputerLoading)
    exports.see_chat:localActionC(localPlayer, "bekapcsolta a számítógépet.")
  end
  _UPVALUE1_ = true
  if not _UPVALUE3_ then
    _UPVALUE3_ = playSound("files/sounds/computerloop.wav", true)
    if isElement(_UPVALUE3_) then
      setSoundVolume(_UPVALUE3_, 0)
    end
  end
end
function deleteComputer()
  if _UPVALUE0_ then
    exports.see_chat:localActionC(localPlayer, "kikapcsolta a számítógépet.")
  end
  _UPVALUE0_ = false
  if not _UPVALUE1_ and not _UPVALUE0_ then
    initUrmaMotoDevice(false)
  end
end
function handleComputerLoading(_ARG_0_)
  if _UPVALUE0_ then
    if getDistanceBetweenPoints2D(minePosX - 32.6914, minePosY - 3.7004, selfPosX, selfPosY) > 2.5 then
      deleteComputer()
    end
    _UPVALUE1_ = math.min(1, _UPVALUE1_ + _ARG_0_ / 2000)
    if isElement(_UPVALUE2_) then
      setSoundSpeed(_UPVALUE2_, 0.5 + 0.5 * _UPVALUE1_)
      setSoundVolume(_UPVALUE2_, math.min(1, _UPVALUE1_ * 5) * 0.5)
    end
  else
    _UPVALUE1_ = _UPVALUE1_ - _ARG_0_ / 1000
    if isElement(_UPVALUE2_) then
      setSoundSpeed(_UPVALUE2_, 0.5 + 0.5 * _UPVALUE1_)
      setSoundVolume(_UPVALUE2_, math.min(1, _UPVALUE1_ * 5) * 0.5)
    end
    if _UPVALUE1_ < 0 then
      _UPVALUE1_ = 0
      if isElement(_UPVALUE2_) then
        destroyElement(_UPVALUE2_)
      end
      removeEventHandler("onClientPreRender", root, handleComputerLoading)
      _UPVALUE2_ = nil
    end
  end
end
function initUrmaMotoDevice(_ARG_0_)
  exports.see_gui:showTooltip()
  exports.see_gui:setCursorType("normal")
  if _ARG_0_ then
    _UPVALUE0_ = {
      urmamotoLogo = dxCreateTexture("files/textures/urmamoto/logo.dds", "argb", true),
      tabletBackground = dxCreateTexture("files/textures/urmamoto/tabb.dds", "argb", true),
      tabletForeground = dxCreateTexture("files/textures/urmamoto/tabf.dds", "argb", true),
      computerBackground = dxCreateTexture("files/textures/urmamoto/comb.dds", "argb", true),
      computerForeground = dxCreateTexture("files/textures/urmamoto/comf.dds", "argb", true),
      siloIcon = dxCreateTexture("files/textures/urmamoto/silo.dds", "argb", true),
      smelterIcon = dxCreateTexture("files/textures/urmamoto/smelter.dds", "argb", true)
    }
    for _FORV_4_ = 1, 12 do
      _UPVALUE0_["mapPiece" .. _FORV_4_] = dxCreateTexture("files/textures/urmamoto/m" .. _FORV_4_ .. ".dds", "argb", true)
    end
    _UPVALUE1_ = dxCreateFont("files/fonts/dos.ttf", 16)
    _UPVALUE2_ = dxCreateFont("files/fonts/dos.ttf", 16, true)
    _UPVALUE3_ = dxGetFontHeight(1, _UPVALUE1_)
    _UPVALUE4_ = dxCreateShader("files/shaders/urmamoto.fx")
    _UPVALUE5_ = dxCreateRenderTarget(_UPVALUE6_, _UPVALUE7_)
    if isElement(_UPVALUE5_) then
      dxSetShaderValue(_UPVALUE4_, "screenTexture", _UPVALUE5_)
    end
    if not _UPVALUE8_ or _UPVALUE8_ == "home" then
      setCurrentDeviceMenu("home")
    end
    addEventHandler("onClientClick", root, handleUrmaMotoDeviceClick)
    addEventHandler("onClientRender", root, handleUrmaMotoDeviceRender, true, "normal-1")
    addEventHandler("onClientRestore", root, handleUrmaMotoDeviceRestore)
    addEventHandler("onClientCharacter", root, handleUrmaMotoDeviceInput)
    addEventHandler("onClientKey", root, handleUrmaMotoDeviceKeyPress, true, "high+9999999")
    shouldRefreshUrmaMotoDevice = true
  else
    exports.see_trading:setForexSubscription(false)
    if _UPVALUE9_ then
      removeEventHandler("onForexUpdate", localPlayer, refreshForex)
      _UPVALUE9_ = false
    end
    removeEventHandler("onClientKey", root, handleUrmaMotoDeviceKeyPress)
    removeEventHandler("onClientCharacter", root, handleUrmaMotoDeviceInput)
    removeEventHandler("onClientRestore", root, handleUrmaMotoDeviceRestore)
    removeEventHandler("onClientRender", root, handleUrmaMotoDeviceRender)
    removeEventHandler("onClientClick", root, handleUrmaMotoDeviceClick)
    if isElement(_UPVALUE1_) then
      destroyElement(_UPVALUE1_)
    end
    if isElement(_UPVALUE2_) then
      destroyElement(_UPVALUE2_)
    end
    _UPVALUE1_ = nil
    _UPVALUE2_ = nil
    _UPVALUE3_ = nil
    if isElement(_UPVALUE4_) then
      destroyElement(_UPVALUE4_)
    end
    if isElement(_UPVALUE5_) then
      destroyElement(_UPVALUE5_)
    end
    _UPVALUE4_ = nil
    _UPVALUE5_ = nil
    for _FORV_4_, _FORV_5_ in pairs(_UPVALUE0_) do
      if isElement(_FORV_5_) then
        destroyElement(_FORV_5_)
      end
      _UPVALUE0_[_FORV_4_] = nil
    end
    _UPVALUE0_ = {}
  end
end
function setCurrentDeviceMenu(_ARG_0_)
  _UPVALUE0_ = _ARG_0_
  if _UPVALUE0_ == "permissions" then
    _UPVALUE1_ = false
    _UPVALUE2_ = false
    _UPVALUE3_ = false
  elseif _UPVALUE0_ == "home" then
    exports.see_trading:setForexSubscription("all")
    if not _UPVALUE4_ then
      addEventHandler("onForexUpdate", localPlayer, refreshForex)
      _UPVALUE4_ = true
    end
    refreshForex()
  else
    exports.see_trading:setForexSubscription(false)
    if _UPVALUE4_ then
      removeEventHandler("onForexUpdate", localPlayer, refreshForex)
      _UPVALUE4_ = false
    end
  end
  shouldRefreshUrmaMotoDevice = true
end
function handleUrmaMotoDeviceInput(_ARG_0_)
  if currentNameLine then
    if charsetMap[utf8.upper(_ARG_0_)] or utf8.upper(_ARG_0_) == " " then
      if utf8.len(currentMineName[currentNameLine] or "") < 16 then
        for _FORV_11_ = 1, utf8.len(currentMineName[currentNameLine] or "") do
          if charsetMap[utf8.sub(currentMineName[currentNameLine] or "", _FORV_11_, _FORV_11_)] then
          else
          end
        end
        if _FOR_[utf8.upper(_ARG_0_)] then
        else
        end
        if math.floor(_UPVALUE0_ * 3.5 / 0.44326 * 0.927294) > 0 + charsetMap[utf8.sub(currentMineName[currentNameLine] or "", _FORV_11_, _FORV_11_)][2] * (_UPVALUE0_ / 64) + 28 * (_UPVALUE0_ / 64) + _FOR_[utf8.upper(_ARG_0_)][2] * (_UPVALUE0_ / 64) + 28 * (_UPVALUE0_ / 64) then
          shouldRefreshUrmaMotoDevice = true
        end
      end
      currentMineName[currentNameLine] = (currentMineName[currentNameLine] or "") .. _ARG_0_
    end
  elseif _UPVALUE1_ and _ARG_0_ ~= "\127" then
    _ARG_0_ = utf8.upper(_ARG_0_)
    if _ARG_0_:match("%w") ~= nil or _ARG_0_ == " " or _ARG_0_ == "_" then
      _UPVALUE2_ = _UPVALUE2_ .. _ARG_0_
      shouldRefreshUrmaMotoDevice = true
    end
  end
end
function handleUrmaMotoDeviceKeyPress(_ARG_0_, _ARG_1_)
  if currentNameLine then
    cancelEvent()
    if _ARG_1_ then
      if _ARG_0_ == "backspace" then
        if utf8.len(currentMineName[currentNameLine]) <= 0 and currentNameLine > 1 then
          currentMineName[currentNameLine] = nil
          currentNameLine = currentNameLine - 1
          mineNameEdited = true
        else
          currentMineName[currentNameLine] = utf8.sub(currentMineName[currentNameLine], 1, -2)
          mineNameEdited = true
        end
        shouldRefreshUrmaMotoDevice = true
      elseif _ARG_0_ == "arrow_u" then
        if currentNameLine > 1 then
          shouldRefreshUrmaMotoDevice = true
          if utf8.len(currentMineName[currentNameLine]) <= 0 then
            currentMineName[currentNameLine] = nil
            mineNameEdited = true
          end
          currentNameLine = currentNameLine - 1
        end
      elseif _ARG_0_ == "enter" or _ARG_0_ == "arrow_d" then
        if currentNameLine < 2 then
          currentNameLine = currentNameLine + 1
          if not currentMineName[currentNameLine] then
            currentMineName[currentNameLine] = ""
            mineNameEdited = true
          end
          shouldRefreshUrmaMotoDevice = true
        else
          endMineNameEdit()
        end
      end
    end
  elseif _UPVALUE0_ then
    cancelEvent()
    if _ARG_1_ then
      if _ARG_0_ == "backspace" then
        _UPVALUE1_ = utf8.sub(_UPVALUE1_, 1, -2)
        shouldRefreshUrmaMotoDevice = true
      elseif _ARG_0_ == "enter" then
        tabletRegisterCheck()
      end
    end
  end
end
function endMineNameEdit()
  if currentNameLine then
    showCursor(false)
    for _FORV_3_ = #currentMineName, 1, -1 do
      if not currentMineName[_FORV_3_] or 1 >= utf8.len(currentMineName[_FORV_3_]) then
        table.remove(currentMineName, _FORV_3_)
      else
        break
      end
    end
    currentNameLine = _FOR_
    if mineNameEdited and currentMineOwnerId == selfCharacterId then
      triggerLatentServerEvent("renameMine", localPlayer, currentMineName)
      mineNameSyncing = true
    end
    shouldRefreshUrmaMotoDevice = true
  end
end
function endTabletMoving()
  if _UPVALUE0_ then
    _UPVALUE0_ = false
    exports.see_gui:setCursorType("normal")
  end
end
function tabletRegisterCheck()
  if utf8.len((utf8.lower(_UPVALUE0_):gsub("_", " "))) <= 0 then
    return
  end
  if tonumber((utf8.lower(_UPVALUE0_):gsub("_", " "))) then
    for _FORV_7_ = 1, #getElementsByType("player") do
      if getElementData(getElementsByType("player")[_FORV_7_], "playerID") == tonumber((utf8.lower(_UPVALUE0_):gsub("_", " "))) then
        break
      end
    end
  else
    for _FORV_6_ = 1, #getElementsByType("player") do
      if getElementData(getElementsByType("player")[_FORV_6_], "loggedIn") and getElementData(getElementsByType("player")[_FORV_6_], "visibleName") and utf8.find(utf8.lower((getElementData(getElementsByType("player")[_FORV_6_], "visibleName"))):gsub("_", " "), (utf8.lower(_UPVALUE0_):gsub("_", " "))) then
        if not getElementsByType("player")[_FORV_7_] then
        else
          return exports.see_gui:showInfobox("e", "Több játékos található ilyen névvel!")
        end
      end
    end
  end
  if not isElement(getElementsByType("player")[_FORV_6_]) then
    return exports.see_gui:showInfobox("e", "Nem található a játékos!")
  end
  if getElementsByType("player")[_FORV_6_] == localPlayer then
    return exports.see_gui:showInfobox("e", "Saját magadat nem alkalmazhatod!")
  end
  _UPVALUE2_, _UPVALUE1_ = getElementsByType("player")[_FORV_6_], false
  shouldRefreshUrmaMotoDevice = true
end
function handleUrmaMotoDeviceClick(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  if _UPVALUE0_ == "moveTablet" or _UPVALUE1_ then
    if _ARG_1_ == "up" then
      endTabletMoving()
    else
      _UPVALUE1_ = {_ARG_2_, _ARG_3_}
      exports.see_gui:setCursorType("move")
    end
  elseif _ARG_1_ == "up" then
    if currentNameLine then
      if _UPVALUE0_ ~= "editMineName" then
        endMineNameEdit()
      end
    elseif _UPVALUE0_ == "editMineName" then
      if not mineNameSyncing then
        showCursor(true)
        currentNameLine = #currentMineName
        shouldRefreshUrmaMotoDevice = true
      end
    elseif _UPVALUE0_ == "turnOffComputer" then
      deleteComputer()
    elseif _UPVALUE0_ == "zoomInTablet" then
      if _UPVALUE2_ < 1 then
        _UPVALUE2_ = math.min(1, _UPVALUE2_ + 1 / _UPVALUE3_)
        _UPVALUE4_ = _ARG_2_ + (_UPVALUE4_ - _ARG_2_) * (_UPVALUE5_ * _UPVALUE2_) / (_UPVALUE5_ * _UPVALUE2_)
        _UPVALUE6_ = _ARG_3_ + (_UPVALUE6_ - _ARG_3_) * (_UPVALUE5_ * _UPVALUE2_) / (_UPVALUE5_ * _UPVALUE2_)
        _UPVALUE4_ = math.max(0, math.min(screenWidth, _UPVALUE4_))
        _UPVALUE6_ = math.max(0, math.min(screenHeight, _UPVALUE6_))
      end
    elseif _UPVALUE0_ == "zoomOutTablet" then
      if _UPVALUE2_ > 0.5 then
        _UPVALUE2_ = math.max(0.5, _UPVALUE2_ - 1 / _UPVALUE3_)
        _UPVALUE4_ = _ARG_2_ + (_UPVALUE4_ - _ARG_2_) * (_UPVALUE5_ * _UPVALUE2_) / (_UPVALUE5_ * _UPVALUE2_)
        _UPVALUE6_ = _ARG_3_ + (_UPVALUE6_ - _ARG_3_) * (_UPVALUE5_ * _UPVALUE2_) / (_UPVALUE5_ * _UPVALUE2_)
        _UPVALUE4_ = math.max(0, math.min(screenWidth, _UPVALUE4_))
        _UPVALUE6_ = math.max(0, math.min(screenHeight, _UPVALUE6_))
      end
    elseif _UPVALUE0_ == "mapCenter" then
      _UPVALUE7_ = false
      shouldRefreshUrmaMotoDevice = true
    elseif _UPVALUE0_ == "requestFuelTank" then
      if checkMinePermission(permissionFlags.ORDER) then
        triggerServerEvent("requestMineFuelTank", localPlayer)
      else
        exports.see_gui:showInfobox("e", "Ehhez nincs jogosultságod!")
      end
    elseif _UPVALUE0_ == "promptNo" then
      shouldRefreshUrmaMotoDevice = true
      if _UPVALUE8_ then
        _UPVALUE8_ = false
        _UPVALUE9_ = ""
      elseif _UPVALUE10_ then
        _UPVALUE10_ = false
      end
    elseif _UPVALUE0_ == "promptYes" then
      shouldRefreshUrmaMotoDevice = true
      if _UPVALUE8_ then
        if isElement(_UPVALUE8_) then
          triggerServerEvent("addMinePermissions", localPlayer, _UPVALUE8_)
          _UPVALUE8_ = false
          _UPVALUE9_ = ""
        else
          tabletRegisterCheck()
        end
      elseif _UPVALUE10_ then
        triggerServerEvent("removeMinePermissions", localPlayer, _UPVALUE10_)
        _UPVALUE10_ = false
      end
    elseif _UPVALUE0_ == "addWorker" then
      if currentMineOwnerId == selfCharacterId and not _UPVALUE10_ then
        _UPVALUE8_ = true
        _UPVALUE9_ = ""
        shouldRefreshUrmaMotoDevice = true
      end
    elseif _UPVALUE0_ == "createOrder" then
      if checkMinePermission(permissionFlags.ORDER) then
        revalidateTabletOrder()
        triggerLatentServerEvent("createMineOrder", localPlayer, currentMineOrdering)
        mineOrderSyncing = true
        shouldRefreshUrmaMotoDevice = true
      else
        exports.see_gui:showInfobox("e", "Ehhez nincs jogosultságod!")
      end
    elseif _UPVALUE0_ == "cancelOrder" then
      if checkMinePermission(permissionFlags.ORDER) then
        triggerLatentServerEvent("cancelMineOrder", localPlayer)
        mineOrderSyncing = true
        shouldRefreshUrmaMotoDevice = true
      else
        exports.see_gui:showInfobox("e", "Ehhez nincs jogosultságod!")
      end
    elseif _UPVALUE0_ then
      if split(_UPVALUE0_, ".")[1] == "menu" then
        setCurrentDeviceMenu(split(_UPVALUE0_, ".")[2])
      elseif split(_UPVALUE0_, ".")[1] == "mapZoom" then
        if tonumber(split(_UPVALUE0_, ".")[2]) then
          _UPVALUE11_ = math.max(0.25, math.min(1.5, _UPVALUE11_ + tonumber(split(_UPVALUE0_, ".")[2]) * 0.25))
        end
        shouldRefreshUrmaMotoDevice = true
      elseif split(_UPVALUE0_, ".")[1] == "mapMove" then
        if tonumber(split(_UPVALUE0_, ".")[2]) then
          shouldRefreshUrmaMotoDevice = true
          if not _UPVALUE7_ then
            _UPVALUE7_ = {selfMineX, selfMineY}
          end
          _UPVALUE7_[tonumber(split(_UPVALUE0_, ".")[2])] = _UPVALUE7_[tonumber(split(_UPVALUE0_, ".")[2])] + tonumber(split(_UPVALUE0_, ".")[3])
        end
      elseif split(_UPVALUE0_, ".")[1] == "fireWorker" then
        if not _UPVALUE8_ then
          _UPVALUE10_ = tonumber(split(_UPVALUE0_, ".")[2])
          shouldRefreshUrmaMotoDevice = true
        end
      elseif split(_UPVALUE0_, ".")[1] == "setPermission" then
        if currentMineOwnerId == selfCharacterId and currentMinePermissions[tonumber(split(_UPVALUE0_, ".")[2])] then
          if not _UPVALUE12_[tonumber(split(_UPVALUE0_, ".")[2])] then
            _UPVALUE12_[tonumber(split(_UPVALUE0_, ".")[2])] = currentMinePermissions[tonumber(split(_UPVALUE0_, ".")[2])]
          end
          if bitTest(_UPVALUE12_[tonumber(split(_UPVALUE0_, ".")[2])], permissionFlags[permissionList[tonumber(split(_UPVALUE0_, ".")[3])]]) then
            _UPVALUE12_[tonumber(split(_UPVALUE0_, ".")[2])] = _UPVALUE12_[tonumber(split(_UPVALUE0_, ".")[2])] - permissionFlags[permissionList[tonumber(split(_UPVALUE0_, ".")[3])]]
          else
            _UPVALUE12_[tonumber(split(_UPVALUE0_, ".")[2])] = _UPVALUE12_[tonumber(split(_UPVALUE0_, ".")[2])] + permissionFlags[permissionList[tonumber(split(_UPVALUE0_, ".")[3])]]
          end
          _UPVALUE13_ = getTickCount()
          if not _UPVALUE14_ then
            addEventHandler("onClientPreRender", root, handleMinePermissionChange)
            _UPVALUE14_ = true
          end
          shouldRefreshUrmaMotoDevice = true
        end
      elseif split(_UPVALUE0_, ".")[1] == "orderPlus" then
        if not currentMineOrdering[split(_UPVALUE0_, ".")[2]] then
          currentMineOrdering[split(_UPVALUE0_, ".")[2]] = 1
        else
          currentMineOrdering[split(_UPVALUE0_, ".")[2]] = currentMineOrdering[split(_UPVALUE0_, ".")[2]] + 1
        end
        revalidateTabletOrder()
      elseif split(_UPVALUE0_, ".")[1] == "orderMinus" then
        if not currentMineOrdering[split(_UPVALUE0_, ".")[2]] then
          currentMineOrdering[split(_UPVALUE0_, ".")[2]] = 0
        else
          currentMineOrdering[split(_UPVALUE0_, ".")[2]] = currentMineOrdering[split(_UPVALUE0_, ".")[2]] - 1
        end
        revalidateTabletOrder()
      end
    end
  end
end
function revalidateTabletOrder()
  refreshOrderConstraints(currentMineOrdering, currentMineInventory)
  shouldRefreshUrmaMotoDevice = true
end
function handleMinePermissionChange()
  if getTickCount() - _UPVALUE0_ > 5000 then
    removeEventHandler("onClientPreRender", root, handleMinePermissionChange)
    if next(_UPVALUE1_) then
      triggerServerEvent("updateMinePermissions", localPlayer, _UPVALUE1_)
      if type(currentMinePermissions) == "table" then
        for _FORV_3_, _FORV_4_ in pairs(_UPVALUE1_) do
          if currentMinePermissions[_FORV_3_] then
            currentMinePermissions[_FORV_3_] = _FORV_4_
          end
        end
      end
      _UPVALUE1_ = {}
    end
    _UPVALUE2_ = false
  end
end
function hasUnsyncedPermissions()
  return next(_UPVALUE0_) ~= nil
end
function handleUrmaMotoDeviceRestore()
  shouldRefreshUrmaMotoDevice = true
end
function handleUrmaMotoDeviceRender()
  _UPVALUE0_ = false
  if _UPVALUE1_ then
    hoverComputer()
  elseif _UPVALUE2_ then
    hoverTablet()
  end
  if _UPVALUE3_ ~= _UPVALUE0_ then
    _UPVALUE3_ = _UPVALUE0_
    if _UPVALUE3_ == "moveTablet" or _UPVALUE4_ then
      exports.see_gui:showTooltip(false)
      exports.see_gui:setCursorType("move")
    elseif _UPVALUE3_ then
      exports.see_gui:setCursorType("link")
      if _UPVALUE3_ == "turnOffComputer" then
        exports.see_gui:showTooltip("Számítógép kikapcsolása")
      elseif _UPVALUE3_ == "!" then
        exports.see_gui:showTooltip("Tablet nagyítása")
      elseif _UPVALUE3_ == "zoomOutTablet" then
        exports.see_gui:showTooltip("Tablet kicsinyítése")
      elseif _UPVALUE3_:find("fireWorker") then
        exports.see_gui:showTooltip("Kirúgás")
      elseif _UPVALUE3_:find("setPermission") then
        if permissionList[tonumber(gettok(_UPVALUE3_, 3, "."))] and permissionFlags[permissionList[tonumber(gettok(_UPVALUE3_, 3, "."))]] then
          exports.see_gui:showTooltip(permissionDescriptions[permissionFlags[permissionList[tonumber(gettok(_UPVALUE3_, 3, "."))]]])
          if currentMineOwnerId ~= selfCharacterId then
            exports.see_gui:setCursorType("normal")
          end
        end
      else
        exports.see_gui:showTooltip(false)
      end
    else
      exports.see_gui:showTooltip(false)
      exports.see_gui:setCursorType("normal")
    end
  end
  if _UPVALUE5_ == "home" or _UPVALUE5_ == "map" or _UPVALUE5_ == "shop" and mineOrderSyncing then
  elseif _UPVALUE5_ == "permissions" then
  elseif _UPVALUE5_ == "ores" then
    if shouldRefreshBoxContent or shouldRefreshFoundryContent or mineFoundryData.furnaceRunning then
      shouldRefreshUrmaMotoDevice = true
    end
    if mineFoundryData.furnaceRunning or mineFoundryData.meltingOre then
    else
    end
  end
  if _UPVALUE7_ ~= true or shouldRefreshUrmaMotoDevice or true then
    _UPVALUE7_, _UPVALUE8_ = true, {}
    shouldRefreshUrmaMotoDevice = false
    drawRenderTarget(true)
  end
  if _UPVALUE1_ then
    drawComputer()
  elseif _UPVALUE2_ then
    drawTablet()
  end
end
function refreshForex()
  shouldRefreshUrmaMotoDevice = true
  _UPVALUE0_ = ""
  _UPVALUE1_ = 0
  for _FORV_3_, _FORV_4_ in pairs(oreTypes) do
    if _FORV_4_.forexIndex then
      if exports.see_trading:getPrice(_FORV_4_.forexIndex) then
        if exports.see_trading:getTrend(_FORV_4_.forexIndex) then
          _UPVALUE0_ = _UPVALUE0_ .. "#ff0000/\\#00ff00 " .. _FORV_4_.forexIndex .. " - " .. formatNumber(math.floor(exports.see_trading:getPrice(_FORV_4_.forexIndex) + 0.5)) .. " $ | "
        else
          _UPVALUE0_ = _UPVALUE0_ .. "#0000ff\\/#00ff00 " .. _FORV_4_.forexIndex .. " - " .. formatNumber(math.floor(exports.see_trading:getPrice(_FORV_4_.forexIndex) + 0.5)) .. " $ | "
        end
      else
        _UPVALUE0_ = _UPVALUE0_ .. "  #00ff00 " .. _FORV_4_.forexIndex .. " - ... | "
      end
    end
  end
  _UPVALUE1_ = dxGetTextWidth(_UPVALUE0_, 0.75, _UPVALUE2_, true)
end
function hoverComputer()
  if getCursorPosition() then
    if getCursorPosition() * screenWidth >= screenWidth / 2 - _UPVALUE1_ / 2 * _UPVALUE0_ - 140 * _UPVALUE0_ + 867 * _UPVALUE0_ and getCursorPosition() * screenWidth <= screenWidth / 2 - _UPVALUE1_ / 2 * _UPVALUE0_ - 140 * _UPVALUE0_ + 916 * _UPVALUE0_ and getCursorPosition() * screenHeight >= screenHeight / 2 - _UPVALUE2_ / 2 * _UPVALUE0_ - 214 * _UPVALUE0_ + 855 * _UPVALUE0_ and getCursorPosition() * screenHeight <= screenHeight / 2 - _UPVALUE2_ / 2 * _UPVALUE0_ - 214 * _UPVALUE0_ + 903 * _UPVALUE0_ then
      _UPVALUE3_ = "turnOffComputer"
    elseif _UPVALUE4_ * 3 >= 1 and (getCursorPosition() * screenWidth - (screenWidth / 2 - _UPVALUE1_ / 2 * _UPVALUE0_)) / _UPVALUE0_ > 0 and (getCursorPosition() * screenWidth - (screenWidth / 2 - _UPVALUE1_ / 2 * _UPVALUE0_)) / _UPVALUE0_ < _UPVALUE5_ and (getCursorPosition() * screenHeight - (screenHeight / 2 - _UPVALUE2_ / 2 * _UPVALUE0_)) / _UPVALUE0_ > 0 and (getCursorPosition() * screenHeight - (screenHeight / 2 - _UPVALUE2_ / 2 * _UPVALUE0_)) / _UPVALUE0_ < _UPVALUE6_ then
      _UPVALUE3_ = false
      for _FORV_10_, _FORV_11_ in pairs(_UPVALUE7_) do
        if (getCursorPosition() * screenWidth - (screenWidth / 2 - _UPVALUE1_ / 2 * _UPVALUE0_)) / _UPVALUE0_ >= _FORV_11_[1] and (getCursorPosition() * screenWidth - (screenWidth / 2 - _UPVALUE1_ / 2 * _UPVALUE0_)) / _UPVALUE0_ <= _FORV_11_[1] + _FORV_11_[3] and (getCursorPosition() * screenHeight - (screenHeight / 2 - _UPVALUE2_ / 2 * _UPVALUE0_)) / _UPVALUE0_ >= _FORV_11_[2] and (getCursorPosition() * screenHeight - (screenHeight / 2 - _UPVALUE2_ / 2 * _UPVALUE0_)) / _UPVALUE0_ <= _FORV_11_[2] + _FORV_11_[4] then
          _UPVALUE3_ = _FORV_10_
          break
        end
      end
      tabletHovering = true
    end
  end
end
function hoverTablet()
  if getCursorPosition() then
    if _UPVALUE6_ then
      _UPVALUE2_ = math.max(0, math.min(screenWidth, _UPVALUE2_ + (getCursorPosition() * screenWidth - _UPVALUE6_[1])))
      _UPVALUE4_ = math.max(0, math.min(screenHeight, _UPVALUE4_ + (getCursorPosition() * screenHeight - _UPVALUE6_[2])))
      _UPVALUE6_[1] = getCursorPosition() * screenWidth
      _UPVALUE6_[2] = getCursorPosition() * screenHeight
    else
      if getCursorPosition() * screenWidth >= _UPVALUE2_ - _UPVALUE3_ / 2 * (_UPVALUE0_ * _UPVALUE1_) - 200 * (_UPVALUE0_ * _UPVALUE1_) + 56 * (_UPVALUE0_ * _UPVALUE1_) and getCursorPosition() * screenWidth <= _UPVALUE2_ - _UPVALUE3_ / 2 * (_UPVALUE0_ * _UPVALUE1_) - 200 * (_UPVALUE0_ * _UPVALUE1_) + 1145 * (_UPVALUE0_ * _UPVALUE1_) and getCursorPosition() * screenHeight >= _UPVALUE4_ - _UPVALUE5_ / 2 * (_UPVALUE0_ * _UPVALUE1_) - 150 * (_UPVALUE0_ * _UPVALUE1_) + 34 * (_UPVALUE0_ * _UPVALUE1_) and getCursorPosition() * screenHeight <= _UPVALUE4_ - _UPVALUE5_ / 2 * (_UPVALUE0_ * _UPVALUE1_) - 150 * (_UPVALUE0_ * _UPVALUE1_) + 866 * (_UPVALUE0_ * _UPVALUE1_) then
        _UPVALUE7_ = "moveTablet"
      end
      if getCursorPosition() * screenWidth >= _UPVALUE2_ - _UPVALUE3_ / 2 * (_UPVALUE0_ * _UPVALUE1_) - 200 * (_UPVALUE0_ * _UPVALUE1_) + 1042 * (_UPVALUE0_ * _UPVALUE1_) and getCursorPosition() * screenWidth <= _UPVALUE2_ - _UPVALUE3_ / 2 * (_UPVALUE0_ * _UPVALUE1_) - 200 * (_UPVALUE0_ * _UPVALUE1_) + 1088 * (_UPVALUE0_ * _UPVALUE1_) then
        if getCursorPosition() * screenHeight >= _UPVALUE4_ - _UPVALUE5_ / 2 * (_UPVALUE0_ * _UPVALUE1_) - 150 * (_UPVALUE0_ * _UPVALUE1_) + 704 * (_UPVALUE0_ * _UPVALUE1_) and getCursorPosition() * screenHeight <= _UPVALUE4_ - _UPVALUE5_ / 2 * (_UPVALUE0_ * _UPVALUE1_) - 150 * (_UPVALUE0_ * _UPVALUE1_) + 750 * (_UPVALUE0_ * _UPVALUE1_) then
          _UPVALUE7_ = "zoomInTablet"
        elseif getCursorPosition() * screenHeight >= _UPVALUE4_ - _UPVALUE5_ / 2 * (_UPVALUE0_ * _UPVALUE1_) - 150 * (_UPVALUE0_ * _UPVALUE1_) + 759 * (_UPVALUE0_ * _UPVALUE1_) and getCursorPosition() * screenHeight <= _UPVALUE4_ - _UPVALUE5_ / 2 * (_UPVALUE0_ * _UPVALUE1_) - 150 * (_UPVALUE0_ * _UPVALUE1_) + 805 * (_UPVALUE0_ * _UPVALUE1_) then
          _UPVALUE7_ = "zoomOutTablet"
        end
      end
      if (getCursorPosition() * screenWidth - (_UPVALUE2_ - _UPVALUE3_ / 2 * (_UPVALUE0_ * _UPVALUE1_))) / (_UPVALUE0_ * _UPVALUE1_) > 0 and (getCursorPosition() * screenWidth - (_UPVALUE2_ - _UPVALUE3_ / 2 * (_UPVALUE0_ * _UPVALUE1_))) / (_UPVALUE0_ * _UPVALUE1_) < _UPVALUE3_ and (getCursorPosition() * screenHeight - (_UPVALUE4_ - _UPVALUE5_ / 2 * (_UPVALUE0_ * _UPVALUE1_))) / (_UPVALUE0_ * _UPVALUE1_) > 0 and (getCursorPosition() * screenHeight - (_UPVALUE4_ - _UPVALUE5_ / 2 * (_UPVALUE0_ * _UPVALUE1_))) / (_UPVALUE0_ * _UPVALUE1_) < _UPVALUE5_ then
        _UPVALUE7_ = false
        for _FORV_10_, _FORV_11_ in pairs(_UPVALUE8_) do
          if (getCursorPosition() * screenWidth - (_UPVALUE2_ - _UPVALUE3_ / 2 * (_UPVALUE0_ * _UPVALUE1_))) / (_UPVALUE0_ * _UPVALUE1_) >= _FORV_11_[1] and (getCursorPosition() * screenWidth - (_UPVALUE2_ - _UPVALUE3_ / 2 * (_UPVALUE0_ * _UPVALUE1_))) / (_UPVALUE0_ * _UPVALUE1_) <= _FORV_11_[1] + _FORV_11_[3] and (getCursorPosition() * screenHeight - (_UPVALUE4_ - _UPVALUE5_ / 2 * (_UPVALUE0_ * _UPVALUE1_))) / (_UPVALUE0_ * _UPVALUE1_) >= _FORV_11_[2] and (getCursorPosition() * screenHeight - (_UPVALUE4_ - _UPVALUE5_ / 2 * (_UPVALUE0_ * _UPVALUE1_))) / (_UPVALUE0_ * _UPVALUE1_) <= _FORV_11_[2] + _FORV_11_[4] then
            _UPVALUE7_ = _FORV_10_
            break
          end
        end
        tabletHovering = true
      end
    end
  else
    endTabletMoving()
  end
end
function drawRenderTarget(_ARG_0_)
  dxSetRenderTarget(_UPVALUE0_, true)
  if _UPVALUE1_ == "home" then
    dxDrawText(_UPVALUE3_, -_UPVALUE2_ * (math.floor(getTickCount() / 250) * 250 % 30000 / 30000), 24, 0, 48, 4294901760, 0.75, _UPVALUE4_, "left", "center", false, false, false, true)
    dxDrawText(_UPVALUE3_, -_UPVALUE2_ * (math.floor(getTickCount() / 250) * 250 % 30000 / 30000) + _UPVALUE2_, 24, 0, 48, 4294901760, 0.75, _UPVALUE4_, "left", "center", false, false, false, true)
    dxDrawImage(80, 52, 640, 160, _UPVALUE5_.urmamotoLogo, 0, 0, 0, 4294901760)
    for _FORV_6_ = 0, math.floor(_UPVALUE6_ / dxGetTextWidth("-", 0.75, _UPVALUE4_)) do
      dxDrawText("-", _FORV_6_ * dxGetTextWidth("-", 0.75, _UPVALUE4_), 234 - _UPVALUE7_, 0, 0, 4294901760, 0.75, _UPVALUE4_, "left", "top")
    end
    for _FORV_6_ = -1, math.floor((_UPVALUE8_ - 280) / _UPVALUE7_) - 1 do
      dxDrawText("|", _UPVALUE6_ / 2, 256 + _UPVALUE7_ * _FORV_6_, _UPVALUE6_ / 2, 0, 4294901760, 0.75, _UPVALUE4_, "center", "top")
    end
    dxDrawText(("Üzemanyag: %s/%s L"):format(math.floor(currentMineInventory.displayedFuelTankLevel * 10) / 10, fuelTankCapacity), 0, 256 - _UPVALUE7_, 752, 0, 4294901760, 0.75, _UPVALUE4_, "right", "top")
    dxDrawText(("Sínszál: %s/%s db"):format(math.floor(currentMineInventory.railIrons), 2 * railIronStack), 0, 256 + _UPVALUE7_, 752, 0, 4294901760, 0.75, _UPVALUE4_, "right", "top")
    dxDrawText(("Talpfa: %s/%s db"):format(math.floor(currentMineInventory.railWoods), 2 * railWoodStack), 0, 256 + _UPVALUE7_ * 2, 752, 0, 4294901760, 0.75, _UPVALUE4_, "right", "top")
    dxDrawText(("Lámpa: %s/%s db"):format(math.floor(currentMineInventory.mineLamps), 2 * mineLampStack), 0, 256, 752, 0, 4294901760, 0.75, _UPVALUE4_, "right", "top")
    if currentMineInventory.dieselLoco then
      dxDrawText(("Mozdony: %s/%s L"):format(math.floor(locoDisplayedFuel / 100 * locoTankCapacity * 10) / 10, locoTankCapacity), 0, 256 + _FOR_ * 4, 752, 0, 4294901760, 0.75, _UPVALUE4_, "right", "top")
    else
      dxDrawText(("Kocsi 1: %s%%"):format(math.floor((cartMaxSlots[1] or 0) / #oreCartOffsets * 100 + 0.5)), 0, 256 + _FOR_ * 4, 752, 0, 4294901760, 0.75, _UPVALUE4_, "right", "top")
    end
    for _FORV_7_ = currentMineInventory.dieselLoco and 1 or 2, currentMineInventory.subCartNum + (currentMineInventory.dieselLoco and 0 or 1) do
      dxDrawText(("Kocsi %s: %s%%"):format(_FORV_7_, math.floor((cartMaxSlots[_FORV_7_] or 0) / #oreCartOffsets * 100 + 0.5)), 0, 256 + _FOR_ * 4 + _UPVALUE7_, 752, 0, 4294901760, 0.75, _UPVALUE4_, "right", "top")
    end
    if currentNameLine or _UPVALUE9_ == "editMineName" then
      drawBorder(48, 256 - _FOR_, math.floor(_UPVALUE7_ * 3.5 / 0.44326 * 0.927294) + 12, _UPVALUE7_ * 3.5, 3, 4294901760)
    else
      drawBorder(48, 256 - _FOR_, math.floor(_UPVALUE7_ * 3.5 / 0.44326 * 0.927294) + 12, _UPVALUE7_ * 3.5, 2, 4294901760)
    end
    if mineNameSyncing then
      if math.floor(getTickCount() / 250) % 4 == 0 then
        dxDrawText("|", 48, 256 - _FOR_, 48 + (math.floor(_UPVALUE7_ * 3.5 / 0.44326 * 0.927294) + 12), 256 - _FOR_ + _UPVALUE7_ * 3.5, 4294901760, 1, _UPVALUE4_, "center", "center")
      elseif math.floor(getTickCount() / 250) % 4 == 1 then
        dxDrawText("/", 48, 256 - _FOR_, 48 + (math.floor(_UPVALUE7_ * 3.5 / 0.44326 * 0.927294) + 12), 256 - _FOR_ + _UPVALUE7_ * 3.5, 4294901760, 1, _UPVALUE4_, "center", "center")
      elseif math.floor(getTickCount() / 250) % 4 == 2 then
        dxDrawText("-", 48, 256 - _FOR_, 48 + (math.floor(_UPVALUE7_ * 3.5 / 0.44326 * 0.927294) + 12), 256 - _FOR_ + _UPVALUE7_ * 3.5, 4294901760, 1, _UPVALUE4_, "center", "center")
      else
        dxDrawText("\\", 48, 256 - _FOR_, 48 + (math.floor(_UPVALUE7_ * 3.5 / 0.44326 * 0.927294) + 12), 256 - _FOR_ + _UPVALUE7_ * 3.5, 4294901760, 1, _UPVALUE4_, "center", "center")
      end
    else
      for _FORV_10_ = 1, #currentMineName do
        if utf8.upper(currentMineName[_FORV_10_]) then
          for _FORV_19_ = 1, utf8.len((utf8.upper(currentMineName[_FORV_10_]))) do
            if charsetMap[utf8.sub(utf8.upper(currentMineName[_FORV_10_]), _FORV_19_, _FORV_19_)] then
            else
            end
          end
          for _FORV_20_ = 1, utf8.len((utf8.upper(currentMineName[_FORV_10_]))) do
            if charsetMap[utf8.sub(utf8.upper(currentMineName[_FORV_10_]), _FORV_20_, _FORV_20_)] then
              dxDrawImageSection(48 + _FOR_ - (0 + charsetMap[utf8.sub(utf8.upper(currentMineName[_FORV_10_]), _FORV_19_, _FORV_19_)][2] * (_UPVALUE7_ / 64) + 28 * (_UPVALUE7_ / 64)) / 2, 256 - _FOR_ + _UPVALUE7_ * 3.5 / 2 - _UPVALUE7_ * #currentMineName / 2, charsetMap[utf8.sub(utf8.upper(currentMineName[_FORV_10_]), _FORV_20_, _FORV_20_)][2] * (_UPVALUE7_ / 64), _UPVALUE7_, charsetMap[utf8.sub(utf8.upper(currentMineName[_FORV_10_]), _FORV_20_, _FORV_20_)][1], 0, charsetMap[utf8.sub(utf8.upper(currentMineName[_FORV_10_]), _FORV_20_, _FORV_20_)][2], 64, charsetTexture, 0, 0, 0, 4294901760)
            else
            end
          end
          if _FOR_ == _FORV_10_ and _ARG_0_ then
            dxDrawText("|", 48 + _FOR_ - (0 + charsetMap[utf8.sub(utf8.upper(currentMineName[_FORV_10_]), _FORV_19_, _FORV_19_)][2] * (_UPVALUE7_ / 64) + 28 * (_UPVALUE7_ / 64)) / 2 + charsetMap[utf8.sub(utf8.upper(currentMineName[_FORV_10_]), _FORV_20_, _FORV_20_)][2] * (_UPVALUE7_ / 64) + 28 * (_UPVALUE7_ / 64), 256 - _FOR_ + _UPVALUE7_ * 3.5 / 2 - _UPVALUE7_ * #currentMineName / 2, 0, 256 - _FOR_ + _UPVALUE7_ * 3.5 / 2 - _UPVALUE7_ * #currentMineName / 2, 4294901760, 1, _UPVALUE4_, "left", "top")
          end
        end
      end
      if currentMineOwnerId == selfCharacterId then
        _UPVALUE10_.editMineName = {
          48,
          256 - _FOR_,
          math.floor(_UPVALUE7_ * 3.5 / 0.44326 * 0.927294) + 12,
          _UPVALUE7_ * 3.5
        }
      end
    end
    dxDrawText("Kérlek válassz:", 48, 256 - _FOR_ + _UPVALUE7_ * 3.5 + 20, 0, 0, 4294901760, 0.75, _UPVALUE4_, "left", "top")
    for _FORV_12_ = 1, #{
      {
        "ores",
        "Nyersanyagok"
      },
      {
        "map",
        "Feltérképezés"
      },
      {
        "permissions",
        "Jogosultságok"
      },
      {"shop", "Rendelés"}
    } do
      drawButton("menu." .. ({
        {
          "ores",
          "Nyersanyagok"
        },
        {
          "map",
          "Feltérképezés"
        },
        {
          "permissions",
          "Jogosultságok"
        },
        {"shop", "Rendelés"}
      })[_FORV_12_][1], 48, 256 - _FOR_ + _UPVALUE7_ * 3.5 + 20 + _UPVALUE7_ + 6, 24, _UPVALUE7_ * 0.85 + 12, ({
        {
          "ores",
          "Nyersanyagok"
        },
        {
          "map",
          "Feltérképezés"
        },
        {
          "permissions",
          "Jogosultságok"
        },
        {"shop", "Rendelés"}
      })[_FORV_12_][2])
    end
  elseif _UPVALUE1_ == "ores" then
    for _FORV_6_, _FORV_7_ in pairs(oreTypes) do
      if not _FORV_7_.fixedBasePrice and not _FORV_7_.instantItem then
        if _FORV_7_.meltingPoint then
        else
        end
      end
    end
    for _FORV_13_, _FORV_14_ in pairs(oreTypes) do
      if not _FORV_14_.instantItem then
        if _FORV_14_.meltingPoint then
          if mineFoundryData.meltingOre == _FORV_13_ or mineFoundryData.furnaceRunning == _FORV_13_ then
            if 1 <= mineFoundryData.meltProgress then
            else
            end
          end
          if 100 <= _FORV_14_.displayedFoundryContent then
          else
          end
          dxDrawImage(400 - (80 + 32) * (0 + 1) / 2 + 16, 48 + 16 + 120 + 32, 80, 120, _UPVALUE5_.siloIcon, 0, 0, 0, 4294901760)
          dxDrawText("Kohó", (_FORV_14_.meltingPoint and 400 - (80 + 32) * (0 + 1) / 2 or 400 - (80 + 32) * (0 + 1) / 2) + (80 + 32) / 2, 48 + 16 + 120 + 32 + 120 + 16, (_FORV_14_.meltingPoint and 400 - (80 + 32) * (0 + 1) / 2 or 400 - (80 + 32) * (0 + 1) / 2) + (80 + 32) / 2, 48 + 16 + 120 + 32 + 120 + 32, 4278190335, 0.75, _UPVALUE4_, "center", "center")
          dxDrawImage(400 - (80 + 32) * (0 + 1) / 2 + 16, 48 + 16 + 120 + 32 + 120 + 32, 80, 120, _UPVALUE5_.smelterIcon, 0, 0, 0, 4278190335)
          dxDrawText(math.max(0, math.floor(math.floor(_FORV_14_.displayedFoundryContent) * 10) / 10) .. "\nrúd", 400 - (80 + 32) * (0 + 1) / 2 + 49.75, 48 + 16 + 120 + 32 + 120 + 32 + 55, 400 - (80 + 32) * (0 + 1) / 2 + 49.75, 48 + 16 + 120 + 32 + 120 + 32 + 55, 4278190335, 0.75, _UPVALUE4_, "center", "center")
          if mineFoundryData.meltingOre == _FORV_13_ or mineFoundryData.furnaceRunning == _FORV_13_ then
            if calculateFurnaceTemperature(_FORV_14_.furnaceTemperature, _FORV_14_.meltingPoint, getTickCount()) > 50 then
            else
            end
            dxDrawText(_ARG_0_ and "----" or "", 400 - (80 + 32) * (0 + 1) / 2 + 49.75, 48 + 16 + 120 + 32 + 120 + 32 + 120 + 8, 400 - (80 + 32) * (0 + 1) / 2 + 49.75, 0, 4278190335, 0.75, _UPVALUE4_, "center", "top")
          end
        else
          dxDrawImage(400 - (80 + 32) * (0 + 1) / 2 + 16, 48, 80, 120, _UPVALUE5_.siloIcon, 0, 0, 0, 4294901760)
        end
        if _FORV_14_.displayedBoxContent < _FORV_14_.boxContent then
        end
        if 100 <= _FORV_14_.bufferContent + _FORV_14_.boxContent - _FORV_14_.displayedBoxContent then
        else
        end
        dxDrawText(_FORV_14_.displayName, (_FORV_14_.meltingPoint and 400 - (80 + 32) * (0 + 1) / 2 or 400 - (80 + 32) * (0 + 1) / 2) + (80 + 32) / 2, (_FORV_14_.meltingPoint and 48 + 16 + 120 + 32 or 48) - 16, (_FORV_14_.meltingPoint and 400 - (80 + 32) * (0 + 1) / 2 or 400 - (80 + 32) * (0 + 1) / 2) + (80 + 32) / 2, _FORV_14_.meltingPoint and 48 + 16 + 120 + 32 or 48, 4294901760, 0.75, _UPVALUE4_, "center", "center")
        dxDrawText(math.max(0, math.floor(math.floor(_FORV_14_.bufferContent + _FORV_14_.boxContent - _FORV_14_.displayedBoxContent) * 10) / 10) .. [[

adag]], (_FORV_14_.meltingPoint and 400 - (80 + 32) * (0 + 1) / 2 or 400 - (80 + 32) * (0 + 1) / 2) + (80 + 32) / 2, (_FORV_14_.meltingPoint and 48 + 16 + 120 + 32 or 48) + 41.875, (_FORV_14_.meltingPoint and 400 - (80 + 32) * (0 + 1) / 2 or 400 - (80 + 32) * (0 + 1) / 2) + (80 + 32) / 2, (_FORV_14_.meltingPoint and 48 + 16 + 120 + 32 or 48) + 41.875, 4294901760, 0.75, _UPVALUE4_, "center", "center")
        dxDrawText(math.floor(_FORV_14_.displayedBoxContent * 100) .. "%", (_FORV_14_.meltingPoint and 400 - (80 + 32) * (0 + 1) / 2 or 400 - (80 + 32) * (0 + 1) / 2) + (80 + 32) / 2, 0, (_FORV_14_.meltingPoint and 400 - (80 + 32) * (0 + 1) / 2 or 400 - (80 + 32) * (0 + 1) / 2) + (80 + 32) / 2, (_FORV_14_.meltingPoint and 48 + 16 + 120 + 32 or 48) + 111.25, 4294901760, 0.75, _UPVALUE4_, "center", "bottom")
      end
    end
  elseif _UPVALUE1_ == "map" then
    if not _ARG_0_ then
      for _FORV_12_ in pairs(threeJunctionBombs) do
        for _FORV_16_ in pairs(threeJunctionBombs[_FORV_12_]) do
          setTabletBomb({}, _FORV_12_, _FORV_16_)
        end
      end
      for _FORV_12_, _FORV_13_ in pairs(openShaftBombs) do
        setTabletBomb({}, convertMineCoordinates(_FORV_13_[5], _FORV_13_[6]))
      end
      for _FORV_12_ in pairs(shaftBombs) do
        for _FORV_16_ in pairs(shaftBombs[_FORV_12_]) do
          for _FORV_20_, _FORV_21_ in pairs(shaftBombs[_FORV_12_][_FORV_16_]) do
            setTabletBomb({}, convertMineCoordinates(_FORV_21_[5], _FORV_21_[6]))
          end
        end
      end
    end
    for _FORV_15_ = -math.ceil(_UPVALUE8_ / (32 * _UPVALUE11_) / 2), math.ceil(_UPVALUE8_ / (32 * _UPVALUE11_) / 2) do
      if ({})[_FORV_15_ + (_UPVALUE12_ and _UPVALUE12_[1] or selfMineX)] then
        for _FORV_21_ = -math.ceil(_UPVALUE6_ / (32 * _UPVALUE11_) / 2), math.ceil(_UPVALUE6_ / (32 * _UPVALUE11_) / 2) do
          if ({})[_FORV_15_ + (_UPVALUE12_ and _UPVALUE12_[1] or selfMineX)][_FORV_21_ + (_UPVALUE12_ and _UPVALUE12_[2] or selfMineY)] then
            dxDrawRectangle(_UPVALUE6_ / 2 - _FORV_21_ * (32 * _UPVALUE11_) - 32 * _UPVALUE11_ / 2, _UPVALUE8_ / 2 - _FORV_15_ * (32 * _UPVALUE11_) - 32 * _UPVALUE11_ / 2, 32 * _UPVALUE11_, 32 * _UPVALUE11_, 4278190335)
          end
        end
      end
      if _FOR_[_FORV_15_ + (_UPVALUE12_ and _UPVALUE12_[1] or selfMineX)] or junctionObjects[_FORV_15_ + (_UPVALUE12_ and _UPVALUE12_[1] or selfMineX)] or _UPVALUE13_[_FORV_15_ + (_UPVALUE12_ and _UPVALUE12_[1] or selfMineX)] then
        for _FORV_21_ = -math.ceil(_UPVALUE6_ / (32 * _UPVALUE11_) / 2), math.ceil(_UPVALUE6_ / (32 * _UPVALUE11_) / 2) do
          if _UPVALUE13_[_FORV_15_ + (_UPVALUE12_ and _UPVALUE12_[1] or selfMineX)] and _UPVALUE13_[_FORV_15_ + (_UPVALUE12_ and _UPVALUE12_[1] or selfMineX)][_FORV_21_ + (_UPVALUE12_ and _UPVALUE12_[2] or selfMineY)] then
            dxDrawImage(_UPVALUE6_ / 2 - _FORV_21_ * (32 * _UPVALUE11_) - 32 * _UPVALUE11_ / 2, _UPVALUE8_ / 2 - _FORV_15_ * (32 * _UPVALUE11_) - 32 * _UPVALUE11_ / 2, 32 * _UPVALUE11_, 32 * _UPVALUE11_, _UPVALUE5_["mapPiece" .. _UPVALUE13_[_FORV_15_ + (_UPVALUE12_ and _UPVALUE12_[1] or selfMineX)][_FORV_21_ + (_UPVALUE12_ and _UPVALUE12_[2] or selfMineY)][1]], _UPVALUE13_[_FORV_15_ + (_UPVALUE12_ and _UPVALUE12_[1] or selfMineX)][_FORV_21_ + (_UPVALUE12_ and _UPVALUE12_[2] or selfMineY)][2], 0, 0, 4294901760)
          elseif tunnelObjectRots[_FORV_15_ + (_UPVALUE12_ and _UPVALUE12_[1] or selfMineX)] and tunnelObjectRots[_FORV_15_ + (_UPVALUE12_ and _UPVALUE12_[1] or selfMineX)][_FORV_21_ + (_UPVALUE12_ and _UPVALUE12_[2] or selfMineY)] then
            if openShaftsAt[_FORV_15_ + (_UPVALUE12_ and _UPVALUE12_[1] or selfMineX)] and openShaftsAt[_FORV_15_ + (_UPVALUE12_ and _UPVALUE12_[1] or selfMineX)][_FORV_21_ + (_UPVALUE12_ and _UPVALUE12_[2] or selfMineY)] then
              dxDrawImage(_UPVALUE6_ / 2 - _FORV_21_ * (32 * _UPVALUE11_) - 32 * _UPVALUE11_ / 2, _UPVALUE8_ / 2 - _FORV_15_ * (32 * _UPVALUE11_) - 32 * _UPVALUE11_ / 2, 32 * _UPVALUE11_, 32 * _UPVALUE11_, _UPVALUE5_.mapPiece4, -tunnelObjectRots[_FORV_15_ + (_UPVALUE12_ and _UPVALUE12_[1] or selfMineX)][_FORV_21_ + (_UPVALUE12_ and _UPVALUE12_[2] or selfMineY)], 0, 0, 4294901760)
            else
              dxDrawImage(_UPVALUE6_ / 2 - _FORV_21_ * (32 * _UPVALUE11_) - 32 * _UPVALUE11_ / 2, _UPVALUE8_ / 2 - _FORV_15_ * (32 * _UPVALUE11_) - 32 * _UPVALUE11_ / 2, 32 * _UPVALUE11_, 32 * _UPVALUE11_, _UPVALUE5_.mapPiece1, tunnelObjectRots[_FORV_15_ + (_UPVALUE12_ and _UPVALUE12_[1] or selfMineX)][_FORV_21_ + (_UPVALUE12_ and _UPVALUE12_[2] or selfMineY)], 0, 0, 4294901760)
            end
          elseif threeJunctionsAt[_FORV_15_ + (_UPVALUE12_ and _UPVALUE12_[1] or selfMineX)] and threeJunctionsAt[_FORV_15_ + (_UPVALUE12_ and _UPVALUE12_[1] or selfMineX)][_FORV_21_ + (_UPVALUE12_ and _UPVALUE12_[2] or selfMineY)] then
            dxDrawImage(_UPVALUE6_ / 2 - _FORV_21_ * (32 * _UPVALUE11_) - 32 * _UPVALUE11_ / 2, _UPVALUE8_ / 2 - _FORV_15_ * (32 * _UPVALUE11_) - 32 * _UPVALUE11_ / 2, 32 * _UPVALUE11_, 32 * _UPVALUE11_, _UPVALUE5_.mapPiece2, -threeJunctionRots[_FORV_15_ + (_UPVALUE12_ and _UPVALUE12_[1] or selfMineX)][_FORV_21_ + (_UPVALUE12_ and _UPVALUE12_[2] or selfMineY)] + 180, 0, 0, 4294901760)
          elseif junctionObjects[_FORV_15_ + (_UPVALUE12_ and _UPVALUE12_[1] or selfMineX)] and junctionObjects[_FORV_15_ + (_UPVALUE12_ and _UPVALUE12_[1] or selfMineX)][_FORV_21_ + (_UPVALUE12_ and _UPVALUE12_[2] or selfMineY)] then
            dxDrawImage(_UPVALUE6_ / 2 - _FORV_21_ * (32 * _UPVALUE11_) - 32 * _UPVALUE11_ / 2, _UPVALUE8_ / 2 - _FORV_15_ * (32 * _UPVALUE11_) - 32 * _UPVALUE11_ / 2, 32 * _UPVALUE11_, 32 * _UPVALUE11_, _UPVALUE5_.mapPiece3, 0, 0, 0, 4294901760)
          end
        end
      end
      if _FOR_[_FORV_15_ + (_UPVALUE12_ and _UPVALUE12_[1] or selfMineX)] or railSwitchesAt[_FORV_15_ + (_UPVALUE12_ and _UPVALUE12_[1] or selfMineX)] then
        for _FORV_21_ = -math.ceil(_UPVALUE6_ / (32 * _UPVALUE11_) / 2), math.ceil(_UPVALUE6_ / (32 * _UPVALUE11_) / 2) do
          if railsAt[_FORV_15_ + (_UPVALUE12_ and _UPVALUE12_[1] or selfMineX)] and railsAt[_FORV_15_ + (_UPVALUE12_ and _UPVALUE12_[1] or selfMineX)][_FORV_21_ + (_UPVALUE12_ and _UPVALUE12_[2] or selfMineY)] then
            if _FORV_15_ + (_UPVALUE12_ and _UPVALUE12_[1] or selfMineX) == -4 then
              dxDrawImage(_UPVALUE6_ / 2 - _FORV_21_ * (32 * _UPVALUE11_) - 32 * _UPVALUE11_ / 2, _UPVALUE8_ / 2 - _FORV_15_ * (32 * _UPVALUE11_) - 32 * _UPVALUE11_ / 2, 32 * _UPVALUE11_, 32 * _UPVALUE11_, _UPVALUE5_.mapPiece6, 0, 0, 0, 4278255360)
            elseif railEndsAt[_FORV_15_ + (_UPVALUE12_ and _UPVALUE12_[1] or selfMineX)] and railEndsAt[_FORV_15_ + (_UPVALUE12_ and _UPVALUE12_[1] or selfMineX)][_FORV_21_ + (_UPVALUE12_ and _UPVALUE12_[2] or selfMineY)] then
              dxDrawImage(_UPVALUE6_ / 2 - _FORV_21_ * (32 * _UPVALUE11_) - 32 * _UPVALUE11_ / 2, _UPVALUE8_ / 2 - _FORV_15_ * (32 * _UPVALUE11_) - 32 * _UPVALUE11_ / 2, 32 * _UPVALUE11_, 32 * _UPVALUE11_, _UPVALUE5_.mapPiece6, -railTracks[railsAt[_FORV_15_ + (_UPVALUE12_ and _UPVALUE12_[1] or selfMineX)][_FORV_21_ + (_UPVALUE12_ and _UPVALUE12_[2] or selfMineY)]].angleDeg + 180, 0, 0, 4278255360)
            else
              dxDrawImage(_UPVALUE6_ / 2 - _FORV_21_ * (32 * _UPVALUE11_) - 32 * _UPVALUE11_ / 2, _UPVALUE8_ / 2 - _FORV_15_ * (32 * _UPVALUE11_) - 32 * _UPVALUE11_ / 2, 32 * _UPVALUE11_, 32 * _UPVALUE11_, _UPVALUE5_.mapPiece5, railTracks[railsAt[_FORV_15_ + (_UPVALUE12_ and _UPVALUE12_[1] or selfMineX)][_FORV_21_ + (_UPVALUE12_ and _UPVALUE12_[2] or selfMineY)]].angleDeg, 0, 0, 4278255360)
            end
          elseif railSwitchesAt[_FORV_15_ + (_UPVALUE12_ and _UPVALUE12_[1] or selfMineX)] and railSwitchesAt[_FORV_15_ + (_UPVALUE12_ and _UPVALUE12_[1] or selfMineX)][_FORV_21_ + (_UPVALUE12_ and _UPVALUE12_[2] or selfMineY)] and railSwitches[railSwitchesAt[_FORV_15_ + (_UPVALUE12_ and _UPVALUE12_[1] or selfMineX)] and railSwitchesAt[_FORV_15_ + (_UPVALUE12_ and _UPVALUE12_[1] or selfMineX)][_FORV_21_ + (_UPVALUE12_ and _UPVALUE12_[2] or selfMineY)]] then
            dxDrawImage(_UPVALUE6_ / 2 - _FORV_21_ * (32 * _UPVALUE11_) - 32 * _UPVALUE11_ / 2, _UPVALUE8_ / 2 - _FORV_15_ * (32 * _UPVALUE11_) - 32 * _UPVALUE11_ / 2, 32 * _UPVALUE11_, 32 * _UPVALUE11_, _UPVALUE5_["mapPiece" .. #railSwitches[railSwitchesAt[_FORV_15_ + (_UPVALUE12_ and _UPVALUE12_[1] or selfMineX)] and railSwitchesAt[_FORV_15_ + (_UPVALUE12_ and _UPVALUE12_[1] or selfMineX)][_FORV_21_ + (_UPVALUE12_ and _UPVALUE12_[2] or selfMineY)]].trackIds + 5], -railSwitches[railSwitchesAt[_FORV_15_ + (_UPVALUE12_ and _UPVALUE12_[1] or selfMineX)] and railSwitchesAt[_FORV_15_ + (_UPVALUE12_ and _UPVALUE12_[1] or selfMineX)][_FORV_21_ + (_UPVALUE12_ and _UPVALUE12_[2] or selfMineY)]].angleDeg + 180, 0, 0, 4278255360)
          end
        end
      end
    end
    if _ARG_0_ then
      dxDrawRectangle(_UPVALUE6_ / 2 - (selfMineY - (_UPVALUE12_ and _UPVALUE12_[2] or selfMineY)) * (32 * _UPVALUE11_) - 32 * _UPVALUE11_ * 0.25 / 2, _UPVALUE8_ / 2 - (selfMineX - (_UPVALUE12_ and _UPVALUE12_[1] or selfMineX)) * (32 * _UPVALUE11_) - 32 * _UPVALUE11_ * 0.25 / 2, 32 * _UPVALUE11_ * 0.25, 32 * _UPVALUE11_ * 0.25, 4278190335)
      dxDrawRectangle(_UPVALUE6_ / 2 - (getRelativeFirstRailCarPosition() - (_UPVALUE12_ and _UPVALUE12_[2] or selfMineY)) * (32 * _UPVALUE11_) - 32 * _UPVALUE11_ * 0.25 / 2, _UPVALUE8_ / 2 - (getRelativeFirstRailCarPosition() - (_UPVALUE12_ and _UPVALUE12_[1] or selfMineX)) * (32 * _UPVALUE11_) - 32 * _UPVALUE11_ * 0.25 / 2, 32 * _UPVALUE11_ * 0.25, 32 * _UPVALUE11_ * 0.25, 4278255360)
      dxDrawRectangle(30, 30, 32 * _UPVALUE11_ * 0.25, 32 * _UPVALUE11_ * 0.25, 4278190335)
      dxDrawRectangle(30, 60, 32 * _UPVALUE11_ * 0.25, 32 * _UPVALUE11_ * 0.25, 4278255360)
    end
    dxDrawText("Tartózkodási helyed", 46, 30, 0, 38, 4278190335, 0.75, _UPVALUE4_, "left", "center")
    dxDrawText("Bányavonat helyzete", 46, 60, 0, 68, 4278255360, 0.75, _UPVALUE4_, "left", "center")
    drawButton("mapZoom.-1", 752 - (_UPVALUE7_ * 0.75 + 8) * 4 - 24, 552 - (_UPVALUE7_ * 0.75 + 8), _UPVALUE7_ * 0.75 + 8, _UPVALUE7_ * 0.75 + 8, "-", 0.75, true)
    drawButton("mapZoom.1", 752 - (_UPVALUE7_ * 0.75 + 8) * 4 - 24, 552 - (_UPVALUE7_ * 0.75 + 8) * 2 - 6, _UPVALUE7_ * 0.75 + 8, _UPVALUE7_ * 0.75 + 8, "+", 0.75, true)
    drawButton("mapMove.1.-1", 752 - (_UPVALUE7_ * 0.75 + 8) * 2 - 6, 552 - (_UPVALUE7_ * 0.75 + 8), _UPVALUE7_ * 0.75 + 8, _UPVALUE7_ * 0.75 + 8, "\\/", 0.75, true)
    drawButton("mapMove.2.-1", 752 - (_UPVALUE7_ * 0.75 + 8), 552 - (_UPVALUE7_ * 0.75 + 8) * 2 - 6, _UPVALUE7_ * 0.75 + 8, _UPVALUE7_ * 0.75 + 8, ">", 0.75, true)
    if _UPVALUE12_ then
      drawButton("mapCenter", 752 - (_UPVALUE7_ * 0.75 + 8) * 2 - 6, 552 - (_UPVALUE7_ * 0.75 + 8) * 2 - 6, _UPVALUE7_ * 0.75 + 8, _UPVALUE7_ * 0.75 + 8, "O", 0.75, true)
    end
    drawButton("mapMove.1.1", 752 - (_UPVALUE7_ * 0.75 + 8) * 2 - 6, 552 - (_UPVALUE7_ * 0.75 + 8) * 3 - 12, _UPVALUE7_ * 0.75 + 8, _UPVALUE7_ * 0.75 + 8, "/\\", 0.75, true)
    drawButton("mapMove.2.1", 752 - (_UPVALUE7_ * 0.75 + 8) * 3 - 12, 552 - (_UPVALUE7_ * 0.75 + 8) * 2 - 6, _UPVALUE7_ * 0.75 + 8, _UPVALUE7_ * 0.75 + 8, "<", 0.75, true)
  elseif _UPVALUE1_ == "permissions" then
    dxDrawText("Munkások:", 48, 48, 0, 48 + (_UPVALUE7_ * 0.85 + 6), 4294901760, 0.85, _UPVALUE4_, "left", "center")
    for _FORV_9_ = 0, math.floor(_UPVALUE6_ / dxGetTextWidth("-", 0.75, _UPVALUE4_)) do
      dxDrawText("-", _FORV_9_ * dxGetTextWidth("-", 0.75, _UPVALUE4_), 48 + (_UPVALUE7_ * 0.85 + 6), 0, 48 + (_UPVALUE7_ * 0.85 + 6) + _UPVALUE7_, 4294901760, 0.75, _UPVALUE4_, "left", "center")
    end
    for _FORV_11_ = 1, #currentMineWorkersList do
      if currentMineOwnerId == selfCharacterId then
        drawRedButton("fireWorker." .. currentMineWorkersList[_FORV_11_], 48, 48 + (_UPVALUE7_ * 0.85 + 6) + _FOR_ + (_UPVALUE7_ * 0.85 + 6 - (_UPVALUE7_ * 0.85 + 6 - 4)) / 2, _UPVALUE7_ * 0.85 + 6 - 4, _UPVALUE7_ * 0.85 + 6 - 4, "x", false, true)
        dxDrawText(currentMineWorkers[currentMineWorkersList[_FORV_11_]]:gsub("_", " "), 48 + (_UPVALUE7_ * 0.85 + 6 - 4) + 4, 48 + (_UPVALUE7_ * 0.85 + 6) + _FOR_, 48 + (_UPVALUE7_ * 0.85 + 6 - 4) + 4 + 250, 48 + (_UPVALUE7_ * 0.85 + 6) + _FOR_ + (_UPVALUE7_ * 0.85 + 6), 4294901760, 0.85, _UPVALUE4_, "left", "center", true)
      else
        dxDrawText(currentMineWorkers[currentMineWorkersList[_FORV_11_]]:gsub("_", " "), 48, 48 + (_UPVALUE7_ * 0.85 + 6) + _FOR_, 48 + 250, 48 + (_UPVALUE7_ * 0.85 + 6) + _FOR_ + (_UPVALUE7_ * 0.85 + 6), 4294901760, 0.85, _UPVALUE4_, "left", "center", true)
      end
      for _FORV_17_ = 1, #permissionList do
        if permissionList[_FORV_17_] then
          drawButton("setPermission." .. currentMineWorkersList[_FORV_11_] .. "." .. _FORV_17_, _UPVALUE6_ - 48 - (_UPVALUE7_ * 0.85 + 6 - 4 + 4) * (#permissionList - _FORV_17_ + 1), 48 + (_UPVALUE7_ * 0.85 + 6) + _FOR_ + (_UPVALUE7_ * 0.85 + 6 - (_UPVALUE7_ * 0.85 + 6 - 4)) / 2, _UPVALUE7_ * 0.85 + 6 - 4, _UPVALUE7_ * 0.85 + 6 - 4, bitTest(_UPVALUE14_[currentMineWorkersList[_FORV_11_]] or currentMinePermissions[currentMineWorkersList[_FORV_11_]], permissionFlags[permissionList[_FORV_17_]]) and "x" or " ", 0.85, true)
        end
      end
      if _FORV_11_ < #_FOR_ then
        for _FORV_17_ = 0, math.floor((_UPVALUE6_ - 96) / (dxGetTextWidth("-", 0.75, _UPVALUE4_) / 1.5)) do
          dxDrawText("-", 48 + _FORV_17_ * (dxGetTextWidth("-", 0.75, _UPVALUE4_) / 1.5), 48 + (_UPVALUE7_ * 0.85 + 6) + _FOR_ + (_UPVALUE7_ * 0.85 + 6) + 3, 0, 48 + (_UPVALUE7_ * 0.85 + 6) + _FOR_ + (_UPVALUE7_ * 0.85 + 6) + 3 + (_UPVALUE7_ * 0.85 + 6) / 5, 4294901760, 0.5, _UPVALUE4_, "left", "center")
        end
      else
      end
    end
    if currentMineOwnerId == selfCharacterId then
      if #currentMineWorkersList < maxWorkers then
        drawButton("addWorker", 48, 48 + (_UPVALUE7_ * 0.85 + 6) + _FOR_ + (_UPVALUE7_ * 0.85 + 6) + 3 + _FOR_ + 3 + (_UPVALUE7_ * 0.85 + 6) + 12, 24, _UPVALUE7_ * 0.85 + 6 + 6, "Munkás regisztrálása")
      end
      if _UPVALUE15_ then
        dxDrawRectangle((_UPVALUE6_ - 400) / 2, (_UPVALUE8_ - 200) / 2, 400, 200, 4278190080)
        drawBorder((_UPVALUE6_ - 400) / 2, (_UPVALUE8_ - 200) / 2, 400, 200, 2, 4294901760)
        if isElement(_UPVALUE15_) then
          dxDrawText("Biztosan szeretnéd felvenni " .. getElementData(_UPVALUE15_, "visibleName"):gsub("_", " ") .. " munkást?", (_UPVALUE6_ - 400) / 2 + 12, (_UPVALUE8_ - 200) / 2, (_UPVALUE6_ - 400) / 2 + 400 - 12, (_UPVALUE8_ - 200) / 2 + 200 - (_UPVALUE7_ * 0.85 + 12) - 12 * 2, 4294901760, 0.85, _UPVALUE4_, "center", "center", false, true)
          drawButton("promptYes", (_UPVALUE6_ - 400) / 2 + 12, (_UPVALUE8_ - 200) / 2 + 200 - (_UPVALUE7_ * 0.85 + 12) - 12, (400 - 12 * 3) / 2, _UPVALUE7_ * 0.85 + 12, "Igen", 0.85, true)
          drawButton("promptNo", (_UPVALUE6_ - 400) / 2 + 12 * 2 + (400 - 12 * 3) / 2, (_UPVALUE8_ - 200) / 2 + 200 - (_UPVALUE7_ * 0.85 + 12) - 12, (400 - 12 * 3) / 2, _UPVALUE7_ * 0.85 + 12, "Nem", 0.85, true)
        else
          dxDrawText("Játékos név/id:", (_UPVALUE6_ - 400) / 2 + 12, (_UPVALUE8_ - 200) / 2, 0, (_UPVALUE8_ - 200) / 2 + (_UPVALUE7_ * 0.85 + 12) * 2, 4294901760, 0.85, _UPVALUE4_, "left", "center")
          drawBorder((_UPVALUE6_ - 400) / 2 + 12, (_UPVALUE8_ - 200) / 2 + (_UPVALUE7_ * 0.85 + 12) * 2, 400 - 12 * 2, _UPVALUE7_ * 0.85 + 12, 2, 4294901760)
          dxDrawText(_UPVALUE16_, (_UPVALUE6_ - 400) / 2 + 12 * 1.5, (_UPVALUE8_ - 200) / 2 + (_UPVALUE7_ * 0.85 + 12) * 2, (_UPVALUE6_ - 400) / 2 + 400 - 12 * 1.5, (_UPVALUE8_ - 200) / 2 + (_UPVALUE7_ * 0.85 + 12) * 2 + (_UPVALUE7_ * 0.85 + 12), 4294901760, 0.85, _UPVALUE4_, dxGetTextWidth(_UPVALUE16_, 0.85, _UPVALUE4_) < 400 - 12 * 1.5 and "left" or "right", "center", true)
          if _ARG_0_ then
            dxDrawText("|", (_UPVALUE6_ - 400) / 2 + 12 * 1.5 + math.min(dxGetTextWidth(_UPVALUE16_, 0.85, _UPVALUE4_), 400 - 12 * 3.5), (_UPVALUE8_ - 200) / 2 + (_UPVALUE7_ * 0.85 + 12) * 2, 0, (_UPVALUE8_ - 200) / 2 + (_UPVALUE7_ * 0.85 + 12) * 2 + (_UPVALUE7_ * 0.85 + 12), 4294901760, 1, _UPVALUE4_, "left", "center")
          end
          drawButton("promptYes", (_UPVALUE6_ - 400) / 2 + 12, (_UPVALUE8_ - 200) / 2 + 200 - (_UPVALUE7_ * 0.85 + 12) - 12, (400 - 12 * 3) / 2, _UPVALUE7_ * 0.85 + 12, "Regisztráció", 0.85, true)
          drawButton("promptNo", (_UPVALUE6_ - 400) / 2 + 12 * 2 + (400 - 12 * 3) / 2, (_UPVALUE8_ - 200) / 2 + 200 - (_UPVALUE7_ * 0.85 + 12) - 12, (400 - 12 * 3) / 2, _UPVALUE7_ * 0.85 + 12, "Mégsem", 0.85, true)
        end
      elseif _UPVALUE17_ then
        if currentMineWorkers[_UPVALUE17_] then
          dxDrawRectangle((_UPVALUE6_ - 400) / 2, (_UPVALUE8_ - 200) / 2, 400, 200, 4278190080)
          drawBorder((_UPVALUE6_ - 400) / 2, (_UPVALUE8_ - 200) / 2, 400, 200, 2, 4294901760)
          dxDrawText("Biztosan szeretnéd kirúgni " .. currentMineWorkers[_UPVALUE17_] .. " munkást?", (_UPVALUE6_ - 400) / 2 + 12, (_UPVALUE8_ - 200) / 2, (_UPVALUE6_ - 400) / 2 + 400 - 12, (_UPVALUE8_ - 200) / 2 + 200 - (_UPVALUE7_ * 0.85 + 12) - 12 * 2, 4294901760, 0.85, _UPVALUE4_, "center", "center", false, true)
          drawButton("promptYes", (_UPVALUE6_ - 400) / 2 + 12, (_UPVALUE8_ - 200) / 2 + 200 - (_UPVALUE7_ * 0.85 + 12) - 12, (400 - 12 * 3) / 2, _UPVALUE7_ * 0.85 + 12, "Igen", 0.85, true)
          drawButton("promptNo", (_UPVALUE6_ - 400) / 2 + 12 * 2 + (400 - 12 * 3) / 2, (_UPVALUE8_ - 200) / 2 + 200 - (_UPVALUE7_ * 0.85 + 12) - 12, (400 - 12 * 3) / 2, _UPVALUE7_ * 0.85 + 12, "Nem", 0.85, true)
        else
          _UPVALUE17_ = false
          shouldRefreshUrmaMotoDevice = true
        end
      end
    end
  elseif _UPVALUE1_ == "shop" then
    if currentMineInventory.tankOutside then
      dxDrawText("Az üzemanyagtartály szállítás alatt", 48, 48, 0, 48 + (_UPVALUE7_ * 0.85 + 12), 4294901760, 0.9, _UPVALUE4_, "left", "center")
    else
      dxDrawText(("Üzemanyagtartály: %s/%s L"):format(math.floor(currentMineInventory.displayedFuelTankLevel * 10) / 10, fuelTankCapacity), 48, 48, 0, 48 + (_UPVALUE7_ * 0.85 + 12), 4294901760, 0.9, _UPVALUE4_, "left", "center")
      if tankPreRequest == currentMine then
        drawRedButton("requestFuelTank", 48 + (dxGetTextWidth(("Üzemanyagtartály: %s/%s L"):format(math.floor(currentMineInventory.displayedFuelTankLevel * 10) / 10, fuelTankCapacity), 0.9, _UPVALUE4_) + 12), 48, 24, _UPVALUE7_ * 0.85 + 12, "Feltöltés megszakítása")
      else
        drawButton("requestFuelTank", 48 + (dxGetTextWidth(("Üzemanyagtartály: %s/%s L"):format(math.floor(currentMineInventory.displayedFuelTankLevel * 10) / 10, fuelTankCapacity), 0.9, _UPVALUE4_) + 12), 48, 24, _UPVALUE7_ * 0.85 + 12, "Tartály feltöltése")
      end
    end
    for _FORV_8_ = 0, math.floor(_UPVALUE6_ / dxGetTextWidth("-", 0.75, _UPVALUE4_)) do
      dxDrawText("-", _FORV_8_ * dxGetTextWidth("-", 0.75, _UPVALUE4_), 48 + (_UPVALUE7_ * 0.85 + 12) + 6, 0, 48 + (_UPVALUE7_ * 0.85 + 12) + 6 + _UPVALUE7_, 4294901760, 0.75, _UPVALUE4_, "left", "center")
    end
    for _FORV_10_ = 1, #{
      {
        "Megnevezés",
        32
      },
      {"Raktár", 32},
      {"Rendelés", 40},
      {"Egységár", 48},
      {"Fizetendö", 48}
    } do
      ({
        {
          "Megnevezés",
          32
        },
        {"Raktár", 32},
        {"Rendelés", 40},
        {"Egységár", 48},
        {"Fizetendö", 48}
      })[_FORV_10_][2] = dxGetTextWidth(({
        {
          "Megnevezés",
          32
        },
        {"Raktár", 32},
        {"Rendelés", 40},
        {"Egységár", 48},
        {"Fizetendö", 48}
      })[_FORV_10_][1], 0.9, _UPVALUE4_) + ({
        {
          "Megnevezés",
          32
        },
        {"Raktár", 32},
        {"Rendelés", 40},
        {"Egységár", 48},
        {"Fizetendö", 48}
      })[_FORV_10_][2]
    end
    for _FORV_10_ = 1, #{
      {
        "Megnevezés",
        32
      },
      {"Raktár", 32},
      {"Rendelés", 40},
      {"Egységár", 48},
      {"Fizetendö", 48}
    } do
      dxDrawText(({
        {
          "Megnevezés",
          32
        },
        {"Raktár", 32},
        {"Rendelés", 40},
        {"Egységár", 48},
        {"Fizetendö", 48}
      })[_FORV_10_][1], (_FOR_ - (0 + ({
        {
          "Megnevezés",
          32
        },
        {"Raktár", 32},
        {"Rendelés", 40},
        {"Egységár", 48},
        {"Fizetendö", 48}
      })[_FORV_10_][2])) / 2, 48 + (_UPVALUE7_ * 0.85 + 12) + 6 + _FOR_ + 24, (_FOR_ - (0 + ({
        {
          "Megnevezés",
          32
        },
        {"Raktár", 32},
        {"Rendelés", 40},
        {"Egységár", 48},
        {"Fizetendö", 48}
      })[_FORV_10_][2])) / 2 + ({
        {
          "Megnevezés",
          32
        },
        {"Raktár", 32},
        {"Rendelés", 40},
        {"Egységár", 48},
        {"Fizetendö", 48}
      })[_FORV_10_][2], 48 + (_UPVALUE7_ * 0.85 + 12) + 6 + _FOR_ + 24 + _UPVALUE7_, 4294901760, 0.9, _UPVALUE4_, "center", "center")
    end
    for _FORV_10_ = 0, math.floor((0 + ({
      {
        "Megnevezés",
        32
      },
      {"Raktár", 32},
      {"Rendelés", 40},
      {"Egységár", 48},
      {"Fizetendö", 48}
    })[_FORV_10_][2]) / dxGetTextWidth("-", 0.75, _UPVALUE4_)) do
      dxDrawText("-", (_FOR_ - (0 + ({
        {
          "Megnevezés",
          32
        },
        {"Raktár", 32},
        {"Rendelés", 40},
        {"Egységár", 48},
        {"Fizetendö", 48}
      })[_FORV_10_][2])) / 2 + _FORV_10_ * dxGetTextWidth("-", 0.75, _UPVALUE4_), 48 + (_UPVALUE7_ * 0.85 + 12) + 6 + _FOR_ + 24 + _UPVALUE7_, 0, 48 + (_UPVALUE7_ * 0.85 + 12) + 6 + _FOR_ + 24 + _UPVALUE7_ + _UPVALUE7_, 4294901760, 0.75, _UPVALUE4_, "left", "center")
    end
    if mineOrderSyncing then
      if math.floor(getTickCount() / 250) % 4 == 0 then
        dxDrawText("|", 0, 48 + (_UPVALUE7_ * 0.85 + 12) + 6 + _FOR_ + 24 + _UPVALUE7_ + _FOR_ + 8, _UPVALUE6_, 0, 4294901760, 1, _UPVALUE4_, "center", "top")
      elseif math.floor(getTickCount() / 250) % 4 == 1 then
        dxDrawText("/", 0, 48 + (_UPVALUE7_ * 0.85 + 12) + 6 + _FOR_ + 24 + _UPVALUE7_ + _FOR_ + 8, _UPVALUE6_, 0, 4294901760, 1, _UPVALUE4_, "center", "top")
      elseif math.floor(getTickCount() / 250) % 4 == 2 then
        dxDrawText("-", 0, 48 + (_UPVALUE7_ * 0.85 + 12) + 6 + _FOR_ + 24 + _UPVALUE7_ + _FOR_ + 8, _UPVALUE6_, 0, 4294901760, 1, _UPVALUE4_, "center", "top")
      else
        dxDrawText("\\", 0, 48 + (_UPVALUE7_ * 0.85 + 12) + 6 + _FOR_ + 24 + _UPVALUE7_ + _FOR_ + 8, _UPVALUE6_, 0, 4294901760, 1, _UPVALUE4_, "center", "top")
      end
    else
      if not currentMineOrder then
        if currentMineOrdering.subCartNum then
          if (currentMineInventory.dieselLoco and 6 or 1) > currentMineInventory.subCartNum + (currentMineOrdering.subCartNum or 0) and (currentMineOrdering.subCartNum or 0) < #trailerOffsets.subCartNum then
            ({}).subCartNum = true
          end
        elseif not currentMineOrdering.dieselLoco then
          ({}).railIrons = math.ceil(currentMineInventory.railIrons / railIronStack) + (currentMineOrdering.railIrons or 0) < railIronStack and math.ceil(currentMineInventory.railIrons / railIronStack) + (currentMineOrdering.railIrons or 0)
          ;({}).railWoods = math.ceil(currentMineInventory.railWoods / railWoodStack) + (currentMineOrdering.railWoods or 0) < railWoodStack and math.ceil(currentMineInventory.railWoods / railWoodStack) + (currentMineOrdering.railWoods or 0)
          ;({}).mineLamps = math.ceil(currentMineInventory.mineLamps / mineLampStack) + (currentMineOrdering.mineLamps or 0) < mineLampStack and (currentMineOrdering.mineLamps or 0) < #trailerOffsets.mineLamps
          ;({}).dieselLoco = 1 > (currentMineInventory.dieselLoco and 1 or 0) + (currentMineOrdering.dieselLoco or 0) and (currentMineOrdering.dieselLoco or 0) < #trailerOffsets.dieselLoco
          ;({}).subCartNum = (currentMineInventory.dieselLoco and 6 or 1) > currentMineInventory.subCartNum + (currentMineOrdering.subCartNum or 0) and (currentMineOrdering.subCartNum or 0) < #trailerOffsets.subCartNum
          if currentMineOrdering.railIrons or currentMineOrdering.railWoods then
            ({}).mineLamps = false
            ;({}).dieselLoco = false
            ;({}).subCartNum = false
          elseif currentMineOrdering.mineLamps then
            ({}).railIrons = false
            ;({}).railWoods = false
            ;({}).dieselLoco = false
            ;({}).subCartNum = false
          end
        end
      end
      for _FORV_15_ = 1, #{
        {
          "railIrons",
          "Sínszál",
          ("%s/%s doboz"):format(math.ceil(currentMineInventory.railIrons / railIronStack), 2),
          railIronPrice
        },
        {
          "railWoods",
          "Talpfa",
          ("%s/%s doboz"):format(math.ceil(currentMineInventory.railWoods / railWoodStack), 2),
          railWoodPrice
        },
        {
          "mineLamps",
          "Lámpa",
          ("%s/%s doboz"):format(math.ceil(currentMineInventory.mineLamps / mineLampStack), 2),
          mineLampPrice
        },
        {
          "dieselLoco",
          [[
UrmaMoto
mozdony]],
          ("%s/%s"):format(currentMineInventory.dieselLoco and 1 or 0, 1),
          dieselLocoPrice,
          true
        },
        {
          "subCartNum",
          "Kocsi",
          ("%s/%s"):format(currentMineInventory.subCartNum + (currentMineInventory.dieselLoco and 0 or 1), (currentMineInventory.dieselLoco and 6 or 1) + (currentMineInventory.dieselLoco and 0 or 1)),
          subRailCarPrice
        }
      } do
        if not currentMineOrder or currentMineOrder[unpack(({
          {
            "railIrons",
            "Sínszál",
            ("%s/%s doboz"):format(math.ceil(currentMineInventory.railIrons / railIronStack), 2),
            railIronPrice
          },
          {
            "railWoods",
            "Talpfa",
            ("%s/%s doboz"):format(math.ceil(currentMineInventory.railWoods / railWoodStack), 2),
            railWoodPrice
          },
          {
            "mineLamps",
            "Lámpa",
            ("%s/%s doboz"):format(math.ceil(currentMineInventory.mineLamps / mineLampStack), 2),
            mineLampPrice
          },
          {
            "dieselLoco",
            [[
UrmaMoto
mozdony]],
            ("%s/%s"):format(currentMineInventory.dieselLoco and 1 or 0, 1),
            dieselLocoPrice,
            true
          },
          {
            "subCartNum",
            "Kocsi",
            ("%s/%s"):format(currentMineInventory.subCartNum + (currentMineInventory.dieselLoco and 0 or 1), (currentMineInventory.dieselLoco and 6 or 1) + (currentMineInventory.dieselLoco and 0 or 1)),
            subRailCarPrice
          }
        })[_FORV_15_])] then
          if currentMineOrder and currentMineOrder[unpack(({
            {
              "railIrons",
              "Sínszál",
              ("%s/%s doboz"):format(math.ceil(currentMineInventory.railIrons / railIronStack), 2),
              railIronPrice
            },
            {
              "railWoods",
              "Talpfa",
              ("%s/%s doboz"):format(math.ceil(currentMineInventory.railWoods / railWoodStack), 2),
              railWoodPrice
            },
            {
              "mineLamps",
              "Lámpa",
              ("%s/%s doboz"):format(math.ceil(currentMineInventory.mineLamps / mineLampStack), 2),
              mineLampPrice
            },
            {
              "dieselLoco",
              [[
UrmaMoto
mozdony]],
              ("%s/%s"):format(currentMineInventory.dieselLoco and 1 or 0, 1),
              dieselLocoPrice,
              true
            },
            {
              "subCartNum",
              "Kocsi",
              ("%s/%s"):format(currentMineInventory.subCartNum + (currentMineInventory.dieselLoco and 0 or 1), (currentMineInventory.dieselLoco and 6 or 1) + (currentMineInventory.dieselLoco and 0 or 1)),
              subRailCarPrice
            }
          })[_FORV_15_])] or currentMineOrdering[unpack(({
            {
              "railIrons",
              "Sínszál",
              ("%s/%s doboz"):format(math.ceil(currentMineInventory.railIrons / railIronStack), 2),
              railIronPrice
            },
            {
              "railWoods",
              "Talpfa",
              ("%s/%s doboz"):format(math.ceil(currentMineInventory.railWoods / railWoodStack), 2),
              railWoodPrice
            },
            {
              "mineLamps",
              "Lámpa",
              ("%s/%s doboz"):format(math.ceil(currentMineInventory.mineLamps / mineLampStack), 2),
              mineLampPrice
            },
            {
              "dieselLoco",
              [[
UrmaMoto
mozdony]],
              ("%s/%s"):format(currentMineInventory.dieselLoco and 1 or 0, 1),
              dieselLocoPrice,
              true
            },
            {
              "subCartNum",
              "Kocsi",
              ("%s/%s"):format(currentMineInventory.subCartNum + (currentMineInventory.dieselLoco and 0 or 1), (currentMineInventory.dieselLoco and 6 or 1) + (currentMineInventory.dieselLoco and 0 or 1)),
              subRailCarPrice
            }
          })[_FORV_15_])] or 0 then
            dxDrawText(unpack(({
              {
                "railIrons",
                "Sínszál",
                ("%s/%s doboz"):format(math.ceil(currentMineInventory.railIrons / railIronStack), 2),
                railIronPrice
              },
              {
                "railWoods",
                "Talpfa",
                ("%s/%s doboz"):format(math.ceil(currentMineInventory.railWoods / railWoodStack), 2),
                railWoodPrice
              },
              {
                "mineLamps",
                "Lámpa",
                ("%s/%s doboz"):format(math.ceil(currentMineInventory.mineLamps / mineLampStack), 2),
                mineLampPrice
              },
              {
                "dieselLoco",
                [[
UrmaMoto
mozdony]],
                ("%s/%s"):format(currentMineInventory.dieselLoco and 1 or 0, 1),
                dieselLocoPrice,
                true
              },
              {
                "subCartNum",
                "Kocsi",
                ("%s/%s"):format(currentMineInventory.subCartNum + (currentMineInventory.dieselLoco and 0 or 1), (currentMineInventory.dieselLoco and 6 or 1) + (currentMineInventory.dieselLoco and 0 or 1)),
                subRailCarPrice
              }
            })[_FORV_15_]))
            dxDrawText(unpack(({
              {
                "railIrons",
                "Sínszál",
                ("%s/%s doboz"):format(math.ceil(currentMineInventory.railIrons / railIronStack), 2),
                railIronPrice
              },
              {
                "railWoods",
                "Talpfa",
                ("%s/%s doboz"):format(math.ceil(currentMineInventory.railWoods / railWoodStack), 2),
                railWoodPrice
              },
              {
                "mineLamps",
                "Lámpa",
                ("%s/%s doboz"):format(math.ceil(currentMineInventory.mineLamps / mineLampStack), 2),
                mineLampPrice
              },
              {
                "dieselLoco",
                [[
UrmaMoto
mozdony]],
                ("%s/%s"):format(currentMineInventory.dieselLoco and 1 or 0, 1),
                dieselLocoPrice,
                true
              },
              {
                "subCartNum",
                "Kocsi",
                ("%s/%s"):format(currentMineInventory.subCartNum + (currentMineInventory.dieselLoco and 0 or 1), (currentMineInventory.dieselLoco and 6 or 1) + (currentMineInventory.dieselLoco and 0 or 1)),
                subRailCarPrice
              }
            })[_FORV_15_]))
            if 0 < (currentMineOrdering[unpack(({
              {
                "railIrons",
                "Sínszál",
                ("%s/%s doboz"):format(math.ceil(currentMineInventory.railIrons / railIronStack), 2),
                railIronPrice
              },
              {
                "railWoods",
                "Talpfa",
                ("%s/%s doboz"):format(math.ceil(currentMineInventory.railWoods / railWoodStack), 2),
                railWoodPrice
              },
              {
                "mineLamps",
                "Lámpa",
                ("%s/%s doboz"):format(math.ceil(currentMineInventory.mineLamps / mineLampStack), 2),
                mineLampPrice
              },
              {
                "dieselLoco",
                [[
UrmaMoto
mozdony]],
                ("%s/%s"):format(currentMineInventory.dieselLoco and 1 or 0, 1),
                dieselLocoPrice,
                true
              },
              {
                "subCartNum",
                "Kocsi",
                ("%s/%s"):format(currentMineInventory.subCartNum + (currentMineInventory.dieselLoco and 0 or 1), (currentMineInventory.dieselLoco and 6 or 1) + (currentMineInventory.dieselLoco and 0 or 1)),
                subRailCarPrice
              }
            })[_FORV_15_])] or 0) and not currentMineOrder then
              drawButton("orderMinus." .. unpack(({
                {
                  "railIrons",
                  "Sínszál",
                  ("%s/%s doboz"):format(math.ceil(currentMineInventory.railIrons / railIronStack), 2),
                  railIronPrice
                },
                {
                  "railWoods",
                  "Talpfa",
                  ("%s/%s doboz"):format(math.ceil(currentMineInventory.railWoods / railWoodStack), 2),
                  railWoodPrice
                },
                {
                  "mineLamps",
                  "Lámpa",
                  ("%s/%s doboz"):format(math.ceil(currentMineInventory.mineLamps / mineLampStack), 2),
                  mineLampPrice
                },
                {
                  "dieselLoco",
                  [[
UrmaMoto
mozdony]],
                  ("%s/%s"):format(currentMineInventory.dieselLoco and 1 or 0, 1),
                  dieselLocoPrice,
                  true
                },
                {
                  "subCartNum",
                  "Kocsi",
                  ("%s/%s"):format(currentMineInventory.subCartNum + (currentMineInventory.dieselLoco and 0 or 1), (currentMineInventory.dieselLoco and 6 or 1) + (currentMineInventory.dieselLoco and 0 or 1)),
                  subRailCarPrice
                }
              })[_FORV_15_]), (_FOR_ - (0 + ({
                {
                  "Megnevezés",
                  32
                },
                {"Raktár", 32},
                {"Rendelés", 40},
                {"Egységár", 48},
                {"Fizetendö", 48}
              })[_FORV_10_][2])) / 2 + ({
                {
                  "Megnevezés",
                  32
                },
                {"Raktár", 32},
                {"Rendelés", 40},
                {"Egységár", 48},
                {"Fizetendö", 48}
              })[1][2] + ({
                {
                  "Megnevezés",
                  32
                },
                {"Raktár", 32},
                {"Rendelés", 40},
                {"Egységár", 48},
                {"Fizetendö", 48}
              })[2][2] + (_UPVALUE7_ * 0.75 + 8) * 0.75, 48 + (_UPVALUE7_ * 0.85 + 12) + 6 + _FOR_ + 24 + _UPVALUE7_ + _FOR_ + 8 + (_UPVALUE7_ * (select(2, unpack(({
                {
                  "railIrons",
                  "Sínszál",
                  ("%s/%s doboz"):format(math.ceil(currentMineInventory.railIrons / railIronStack), 2),
                  railIronPrice
                },
                {
                  "railWoods",
                  "Talpfa",
                  ("%s/%s doboz"):format(math.ceil(currentMineInventory.railWoods / railWoodStack), 2),
                  railWoodPrice
                },
                {
                  "mineLamps",
                  "Lámpa",
                  ("%s/%s doboz"):format(math.ceil(currentMineInventory.mineLamps / mineLampStack), 2),
                  mineLampPrice
                },
                {
                  "dieselLoco",
                  [[
UrmaMoto
mozdony]],
                  ("%s/%s"):format(currentMineInventory.dieselLoco and 1 or 0, 1),
                  dieselLocoPrice,
                  true
                },
                {
                  "subCartNum",
                  "Kocsi",
                  ("%s/%s"):format(currentMineInventory.subCartNum + (currentMineInventory.dieselLoco and 0 or 1), (currentMineInventory.dieselLoco and 6 or 1) + (currentMineInventory.dieselLoco and 0 or 1)),
                  subRailCarPrice
                }
              })[_FORV_15_]):gsub("\n", "")) + 1) - (_UPVALUE7_ * 0.75 + 8)) / 2, _UPVALUE7_ * 0.75 + 8, _UPVALUE7_ * 0.75 + 8, "-", 0.75, true)
            end
            dxDrawText(currentMineOrder and currentMineOrder[unpack(({
              {
                "railIrons",
                "Sínszál",
                ("%s/%s doboz"):format(math.ceil(currentMineInventory.railIrons / railIronStack), 2),
                railIronPrice
              },
              {
                "railWoods",
                "Talpfa",
                ("%s/%s doboz"):format(math.ceil(currentMineInventory.railWoods / railWoodStack), 2),
                railWoodPrice
              },
              {
                "mineLamps",
                "Lámpa",
                ("%s/%s doboz"):format(math.ceil(currentMineInventory.mineLamps / mineLampStack), 2),
                mineLampPrice
              },
              {
                "dieselLoco",
                [[
UrmaMoto
mozdony]],
                ("%s/%s"):format(currentMineInventory.dieselLoco and 1 or 0, 1),
                dieselLocoPrice,
                true
              },
              {
                "subCartNum",
                "Kocsi",
                ("%s/%s"):format(currentMineInventory.subCartNum + (currentMineInventory.dieselLoco and 0 or 1), (currentMineInventory.dieselLoco and 6 or 1) + (currentMineInventory.dieselLoco and 0 or 1)),
                subRailCarPrice
              }
            })[_FORV_15_])] or currentMineOrdering[unpack(({
              {
                "railIrons",
                "Sínszál",
                ("%s/%s doboz"):format(math.ceil(currentMineInventory.railIrons / railIronStack), 2),
                railIronPrice
              },
              {
                "railWoods",
                "Talpfa",
                ("%s/%s doboz"):format(math.ceil(currentMineInventory.railWoods / railWoodStack), 2),
                railWoodPrice
              },
              {
                "mineLamps",
                "Lámpa",
                ("%s/%s doboz"):format(math.ceil(currentMineInventory.mineLamps / mineLampStack), 2),
                mineLampPrice
              },
              {
                "dieselLoco",
                [[
UrmaMoto
mozdony]],
                ("%s/%s"):format(currentMineInventory.dieselLoco and 1 or 0, 1),
                dieselLocoPrice,
                true
              },
              {
                "subCartNum",
                "Kocsi",
                ("%s/%s"):format(currentMineInventory.subCartNum + (currentMineInventory.dieselLoco and 0 or 1), (currentMineInventory.dieselLoco and 6 or 1) + (currentMineInventory.dieselLoco and 0 or 1)),
                subRailCarPrice
              }
            })[_FORV_15_])] or 0, (_FOR_ - (0 + ({
              {
                "Megnevezés",
                32
              },
              {"Raktár", 32},
              {"Rendelés", 40},
              {"Egységár", 48},
              {"Fizetendö", 48}
            })[_FORV_10_][2])) / 2 + ({
              {
                "Megnevezés",
                32
              },
              {"Raktár", 32},
              {"Rendelés", 40},
              {"Egységár", 48},
              {"Fizetendö", 48}
            })[1][2] + ({
              {
                "Megnevezés",
                32
              },
              {"Raktár", 32},
              {"Rendelés", 40},
              {"Egységár", 48},
              {"Fizetendö", 48}
            })[2][2], 48 + (_UPVALUE7_ * 0.85 + 12) + 6 + _FOR_ + 24 + _UPVALUE7_ + _FOR_ + 8, (_FOR_ - (0 + ({
              {
                "Megnevezés",
                32
              },
              {"Raktár", 32},
              {"Rendelés", 40},
              {"Egységár", 48},
              {"Fizetendö", 48}
            })[_FORV_10_][2])) / 2 + ({
              {
                "Megnevezés",
                32
              },
              {"Raktár", 32},
              {"Rendelés", 40},
              {"Egységár", 48},
              {"Fizetendö", 48}
            })[1][2] + ({
              {
                "Megnevezés",
                32
              },
              {"Raktár", 32},
              {"Rendelés", 40},
              {"Egységár", 48},
              {"Fizetendö", 48}
            })[2][2] + ({
              {
                "Megnevezés",
                32
              },
              {"Raktár", 32},
              {"Rendelés", 40},
              {"Egységár", 48},
              {"Fizetendö", 48}
            })[3][2], 48 + (_UPVALUE7_ * 0.85 + 12) + 6 + _FOR_ + 24 + _UPVALUE7_ + _FOR_ + 8 + _UPVALUE7_ * (select(2, unpack(({
              {
                "railIrons",
                "Sínszál",
                ("%s/%s doboz"):format(math.ceil(currentMineInventory.railIrons / railIronStack), 2),
                railIronPrice
              },
              {
                "railWoods",
                "Talpfa",
                ("%s/%s doboz"):format(math.ceil(currentMineInventory.railWoods / railWoodStack), 2),
                railWoodPrice
              },
              {
                "mineLamps",
                "Lámpa",
                ("%s/%s doboz"):format(math.ceil(currentMineInventory.mineLamps / mineLampStack), 2),
                mineLampPrice
              },
              {
                "dieselLoco",
                [[
UrmaMoto
mozdony]],
                ("%s/%s"):format(currentMineInventory.dieselLoco and 1 or 0, 1),
                dieselLocoPrice,
                true
              },
              {
                "subCartNum",
                "Kocsi",
                ("%s/%s"):format(currentMineInventory.subCartNum + (currentMineInventory.dieselLoco and 0 or 1), (currentMineInventory.dieselLoco and 6 or 1) + (currentMineInventory.dieselLoco and 0 or 1)),
                subRailCarPrice
              }
            })[_FORV_15_]):gsub("\n", "")) + 1), 4294901760, 0.9, _UPVALUE4_, "center", "center")
            if {} and ({})[unpack(({
              {
                "railIrons",
                "Sínszál",
                ("%s/%s doboz"):format(math.ceil(currentMineInventory.railIrons / railIronStack), 2),
                railIronPrice
              },
              {
                "railWoods",
                "Talpfa",
                ("%s/%s doboz"):format(math.ceil(currentMineInventory.railWoods / railWoodStack), 2),
                railWoodPrice
              },
              {
                "mineLamps",
                "Lámpa",
                ("%s/%s doboz"):format(math.ceil(currentMineInventory.mineLamps / mineLampStack), 2),
                mineLampPrice
              },
              {
                "dieselLoco",
                [[
UrmaMoto
mozdony]],
                ("%s/%s"):format(currentMineInventory.dieselLoco and 1 or 0, 1),
                dieselLocoPrice,
                true
              },
              {
                "subCartNum",
                "Kocsi",
                ("%s/%s"):format(currentMineInventory.subCartNum + (currentMineInventory.dieselLoco and 0 or 1), (currentMineInventory.dieselLoco and 6 or 1) + (currentMineInventory.dieselLoco and 0 or 1)),
                subRailCarPrice
              }
            })[_FORV_15_])] then
              drawButton("orderPlus." .. unpack(({
                {
                  "railIrons",
                  "Sínszál",
                  ("%s/%s doboz"):format(math.ceil(currentMineInventory.railIrons / railIronStack), 2),
                  railIronPrice
                },
                {
                  "railWoods",
                  "Talpfa",
                  ("%s/%s doboz"):format(math.ceil(currentMineInventory.railWoods / railWoodStack), 2),
                  railWoodPrice
                },
                {
                  "mineLamps",
                  "Lámpa",
                  ("%s/%s doboz"):format(math.ceil(currentMineInventory.mineLamps / mineLampStack), 2),
                  mineLampPrice
                },
                {
                  "dieselLoco",
                  [[
UrmaMoto
mozdony]],
                  ("%s/%s"):format(currentMineInventory.dieselLoco and 1 or 0, 1),
                  dieselLocoPrice,
                  true
                },
                {
                  "subCartNum",
                  "Kocsi",
                  ("%s/%s"):format(currentMineInventory.subCartNum + (currentMineInventory.dieselLoco and 0 or 1), (currentMineInventory.dieselLoco and 6 or 1) + (currentMineInventory.dieselLoco and 0 or 1)),
                  subRailCarPrice
                }
              })[_FORV_15_]), (_FOR_ - (0 + ({
                {
                  "Megnevezés",
                  32
                },
                {"Raktár", 32},
                {"Rendelés", 40},
                {"Egységár", 48},
                {"Fizetendö", 48}
              })[_FORV_10_][2])) / 2 + ({
                {
                  "Megnevezés",
                  32
                },
                {"Raktár", 32},
                {"Rendelés", 40},
                {"Egységár", 48},
                {"Fizetendö", 48}
              })[1][2] + ({
                {
                  "Megnevezés",
                  32
                },
                {"Raktár", 32},
                {"Rendelés", 40},
                {"Egységár", 48},
                {"Fizetendö", 48}
              })[2][2] + ({
                {
                  "Megnevezés",
                  32
                },
                {"Raktár", 32},
                {"Rendelés", 40},
                {"Egységár", 48},
                {"Fizetendö", 48}
              })[3][2] - (_UPVALUE7_ * 0.75 + 8) * 1.75, 48 + (_UPVALUE7_ * 0.85 + 12) + 6 + _FOR_ + 24 + _UPVALUE7_ + _FOR_ + 8 + (_UPVALUE7_ * (select(2, unpack(({
                {
                  "railIrons",
                  "Sínszál",
                  ("%s/%s doboz"):format(math.ceil(currentMineInventory.railIrons / railIronStack), 2),
                  railIronPrice
                },
                {
                  "railWoods",
                  "Talpfa",
                  ("%s/%s doboz"):format(math.ceil(currentMineInventory.railWoods / railWoodStack), 2),
                  railWoodPrice
                },
                {
                  "mineLamps",
                  "Lámpa",
                  ("%s/%s doboz"):format(math.ceil(currentMineInventory.mineLamps / mineLampStack), 2),
                  mineLampPrice
                },
                {
                  "dieselLoco",
                  [[
UrmaMoto
mozdony]],
                  ("%s/%s"):format(currentMineInventory.dieselLoco and 1 or 0, 1),
                  dieselLocoPrice,
                  true
                },
                {
                  "subCartNum",
                  "Kocsi",
                  ("%s/%s"):format(currentMineInventory.subCartNum + (currentMineInventory.dieselLoco and 0 or 1), (currentMineInventory.dieselLoco and 6 or 1) + (currentMineInventory.dieselLoco and 0 or 1)),
                  subRailCarPrice
                }
              })[_FORV_15_]):gsub("\n", "")) + 1) - (_UPVALUE7_ * 0.75 + 8)) / 2, _UPVALUE7_ * 0.75 + 8, _UPVALUE7_ * 0.75 + 8, "+", 0.75, true)
            end
            dxDrawText(formatNumber(unpack(({
              {
                "railIrons",
                "Sínszál",
                ("%s/%s doboz"):format(math.ceil(currentMineInventory.railIrons / railIronStack), 2),
                railIronPrice
              },
              {
                "railWoods",
                "Talpfa",
                ("%s/%s doboz"):format(math.ceil(currentMineInventory.railWoods / railWoodStack), 2),
                railWoodPrice
              },
              {
                "mineLamps",
                "Lámpa",
                ("%s/%s doboz"):format(math.ceil(currentMineInventory.mineLamps / mineLampStack), 2),
                mineLampPrice
              },
              {
                "dieselLoco",
                [[
UrmaMoto
mozdony]],
                ("%s/%s"):format(currentMineInventory.dieselLoco and 1 or 0, 1),
                dieselLocoPrice,
                true
              },
              {
                "subCartNum",
                "Kocsi",
                ("%s/%s"):format(currentMineInventory.subCartNum + (currentMineInventory.dieselLoco and 0 or 1), (currentMineInventory.dieselLoco and 6 or 1) + (currentMineInventory.dieselLoco and 0 or 1)),
                subRailCarPrice
              }
            })[_FORV_15_])) .. (unpack(({
              {
                "railIrons",
                "Sínszál",
                ("%s/%s doboz"):format(math.ceil(currentMineInventory.railIrons / railIronStack), 2),
                railIronPrice
              },
              {
                "railWoods",
                "Talpfa",
                ("%s/%s doboz"):format(math.ceil(currentMineInventory.railWoods / railWoodStack), 2),
                railWoodPrice
              },
              {
                "mineLamps",
                "Lámpa",
                ("%s/%s doboz"):format(math.ceil(currentMineInventory.mineLamps / mineLampStack), 2),
                mineLampPrice
              },
              {
                "dieselLoco",
                [[
UrmaMoto
mozdony]],
                ("%s/%s"):format(currentMineInventory.dieselLoco and 1 or 0, 1),
                dieselLocoPrice,
                true
              },
              {
                "subCartNum",
                "Kocsi",
                ("%s/%s"):format(currentMineInventory.subCartNum + (currentMineInventory.dieselLoco and 0 or 1), (currentMineInventory.dieselLoco and 6 or 1) + (currentMineInventory.dieselLoco and 0 or 1)),
                subRailCarPrice
              }
            })[_FORV_15_]) and " PP" or " $"), (_FOR_ - (0 + ({
              {
                "Megnevezés",
                32
              },
              {"Raktár", 32},
              {"Rendelés", 40},
              {"Egységár", 48},
              {"Fizetendö", 48}
            })[_FORV_10_][2])) / 2 + ({
              {
                "Megnevezés",
                32
              },
              {"Raktár", 32},
              {"Rendelés", 40},
              {"Egységár", 48},
              {"Fizetendö", 48}
            })[1][2] + ({
              {
                "Megnevezés",
                32
              },
              {"Raktár", 32},
              {"Rendelés", 40},
              {"Egységár", 48},
              {"Fizetendö", 48}
            })[2][2] + ({
              {
                "Megnevezés",
                32
              },
              {"Raktár", 32},
              {"Rendelés", 40},
              {"Egységár", 48},
              {"Fizetendö", 48}
            })[3][2], 48 + (_UPVALUE7_ * 0.85 + 12) + 6 + _FOR_ + 24 + _UPVALUE7_ + _FOR_ + 8, (_FOR_ - (0 + ({
              {
                "Megnevezés",
                32
              },
              {"Raktár", 32},
              {"Rendelés", 40},
              {"Egységár", 48},
              {"Fizetendö", 48}
            })[_FORV_10_][2])) / 2 + ({
              {
                "Megnevezés",
                32
              },
              {"Raktár", 32},
              {"Rendelés", 40},
              {"Egységár", 48},
              {"Fizetendö", 48}
            })[1][2] + ({
              {
                "Megnevezés",
                32
              },
              {"Raktár", 32},
              {"Rendelés", 40},
              {"Egységár", 48},
              {"Fizetendö", 48}
            })[2][2] + ({
              {
                "Megnevezés",
                32
              },
              {"Raktár", 32},
              {"Rendelés", 40},
              {"Egységár", 48},
              {"Fizetendö", 48}
            })[3][2] + ({
              {
                "Megnevezés",
                32
              },
              {"Raktár", 32},
              {"Rendelés", 40},
              {"Egységár", 48},
              {"Fizetendö", 48}
            })[4][2], 48 + (_UPVALUE7_ * 0.85 + 12) + 6 + _FOR_ + 24 + _UPVALUE7_ + _FOR_ + 8 + _UPVALUE7_ * (select(2, unpack(({
              {
                "railIrons",
                "Sínszál",
                ("%s/%s doboz"):format(math.ceil(currentMineInventory.railIrons / railIronStack), 2),
                railIronPrice
              },
              {
                "railWoods",
                "Talpfa",
                ("%s/%s doboz"):format(math.ceil(currentMineInventory.railWoods / railWoodStack), 2),
                railWoodPrice
              },
              {
                "mineLamps",
                "Lámpa",
                ("%s/%s doboz"):format(math.ceil(currentMineInventory.mineLamps / mineLampStack), 2),
                mineLampPrice
              },
              {
                "dieselLoco",
                [[
UrmaMoto
mozdony]],
                ("%s/%s"):format(currentMineInventory.dieselLoco and 1 or 0, 1),
                dieselLocoPrice,
                true
              },
              {
                "subCartNum",
                "Kocsi",
                ("%s/%s"):format(currentMineInventory.subCartNum + (currentMineInventory.dieselLoco and 0 or 1), (currentMineInventory.dieselLoco and 6 or 1) + (currentMineInventory.dieselLoco and 0 or 1)),
                subRailCarPrice
              }
            })[_FORV_15_]):gsub("\n", "")) + 1), 4294901760, 0.9, _UPVALUE4_, "center", "center")
            dxDrawText(formatNumber(unpack(({
              {
                "railIrons",
                "Sínszál",
                ("%s/%s doboz"):format(math.ceil(currentMineInventory.railIrons / railIronStack), 2),
                railIronPrice
              },
              {
                "railWoods",
                "Talpfa",
                ("%s/%s doboz"):format(math.ceil(currentMineInventory.railWoods / railWoodStack), 2),
                railWoodPrice
              },
              {
                "mineLamps",
                "Lámpa",
                ("%s/%s doboz"):format(math.ceil(currentMineInventory.mineLamps / mineLampStack), 2),
                mineLampPrice
              },
              {
                "dieselLoco",
                [[
UrmaMoto
mozdony]],
                ("%s/%s"):format(currentMineInventory.dieselLoco and 1 or 0, 1),
                dieselLocoPrice,
                true
              },
              {
                "subCartNum",
                "Kocsi",
                ("%s/%s"):format(currentMineInventory.subCartNum + (currentMineInventory.dieselLoco and 0 or 1), (currentMineInventory.dieselLoco and 6 or 1) + (currentMineInventory.dieselLoco and 0 or 1)),
                subRailCarPrice
              }
            })[_FORV_15_]) * (currentMineOrder and currentMineOrder[unpack(({
              {
                "railIrons",
                "Sínszál",
                ("%s/%s doboz"):format(math.ceil(currentMineInventory.railIrons / railIronStack), 2),
                railIronPrice
              },
              {
                "railWoods",
                "Talpfa",
                ("%s/%s doboz"):format(math.ceil(currentMineInventory.railWoods / railWoodStack), 2),
                railWoodPrice
              },
              {
                "mineLamps",
                "Lámpa",
                ("%s/%s doboz"):format(math.ceil(currentMineInventory.mineLamps / mineLampStack), 2),
                mineLampPrice
              },
              {
                "dieselLoco",
                [[
UrmaMoto
mozdony]],
                ("%s/%s"):format(currentMineInventory.dieselLoco and 1 or 0, 1),
                dieselLocoPrice,
                true
              },
              {
                "subCartNum",
                "Kocsi",
                ("%s/%s"):format(currentMineInventory.subCartNum + (currentMineInventory.dieselLoco and 0 or 1), (currentMineInventory.dieselLoco and 6 or 1) + (currentMineInventory.dieselLoco and 0 or 1)),
                subRailCarPrice
              }
            })[_FORV_15_])] or currentMineOrdering[unpack(({
              {
                "railIrons",
                "Sínszál",
                ("%s/%s doboz"):format(math.ceil(currentMineInventory.railIrons / railIronStack), 2),
                railIronPrice
              },
              {
                "railWoods",
                "Talpfa",
                ("%s/%s doboz"):format(math.ceil(currentMineInventory.railWoods / railWoodStack), 2),
                railWoodPrice
              },
              {
                "mineLamps",
                "Lámpa",
                ("%s/%s doboz"):format(math.ceil(currentMineInventory.mineLamps / mineLampStack), 2),
                mineLampPrice
              },
              {
                "dieselLoco",
                [[
UrmaMoto
mozdony]],
                ("%s/%s"):format(currentMineInventory.dieselLoco and 1 or 0, 1),
                dieselLocoPrice,
                true
              },
              {
                "subCartNum",
                "Kocsi",
                ("%s/%s"):format(currentMineInventory.subCartNum + (currentMineInventory.dieselLoco and 0 or 1), (currentMineInventory.dieselLoco and 6 or 1) + (currentMineInventory.dieselLoco and 0 or 1)),
                subRailCarPrice
              }
            })[_FORV_15_])] or 0)) .. (unpack(({
              {
                "railIrons",
                "Sínszál",
                ("%s/%s doboz"):format(math.ceil(currentMineInventory.railIrons / railIronStack), 2),
                railIronPrice
              },
              {
                "railWoods",
                "Talpfa",
                ("%s/%s doboz"):format(math.ceil(currentMineInventory.railWoods / railWoodStack), 2),
                railWoodPrice
              },
              {
                "mineLamps",
                "Lámpa",
                ("%s/%s doboz"):format(math.ceil(currentMineInventory.mineLamps / mineLampStack), 2),
                mineLampPrice
              },
              {
                "dieselLoco",
                [[
UrmaMoto
mozdony]],
                ("%s/%s"):format(currentMineInventory.dieselLoco and 1 or 0, 1),
                dieselLocoPrice,
                true
              },
              {
                "subCartNum",
                "Kocsi",
                ("%s/%s"):format(currentMineInventory.subCartNum + (currentMineInventory.dieselLoco and 0 or 1), (currentMineInventory.dieselLoco and 6 or 1) + (currentMineInventory.dieselLoco and 0 or 1)),
                subRailCarPrice
              }
            })[_FORV_15_]) and " PP" or " $"), (_FOR_ - (0 + ({
              {
                "Megnevezés",
                32
              },
              {"Raktár", 32},
              {"Rendelés", 40},
              {"Egységár", 48},
              {"Fizetendö", 48}
            })[_FORV_10_][2])) / 2 + ({
              {
                "Megnevezés",
                32
              },
              {"Raktár", 32},
              {"Rendelés", 40},
              {"Egységár", 48},
              {"Fizetendö", 48}
            })[1][2] + ({
              {
                "Megnevezés",
                32
              },
              {"Raktár", 32},
              {"Rendelés", 40},
              {"Egységár", 48},
              {"Fizetendö", 48}
            })[2][2] + ({
              {
                "Megnevezés",
                32
              },
              {"Raktár", 32},
              {"Rendelés", 40},
              {"Egységár", 48},
              {"Fizetendö", 48}
            })[3][2] + ({
              {
                "Megnevezés",
                32
              },
              {"Raktár", 32},
              {"Rendelés", 40},
              {"Egységár", 48},
              {"Fizetendö", 48}
            })[4][2], 48 + (_UPVALUE7_ * 0.85 + 12) + 6 + _FOR_ + 24 + _UPVALUE7_ + _FOR_ + 8, (_FOR_ - (0 + ({
              {
                "Megnevezés",
                32
              },
              {"Raktár", 32},
              {"Rendelés", 40},
              {"Egységár", 48},
              {"Fizetendö", 48}
            })[_FORV_10_][2])) / 2 + ({
              {
                "Megnevezés",
                32
              },
              {"Raktár", 32},
              {"Rendelés", 40},
              {"Egységár", 48},
              {"Fizetendö", 48}
            })[1][2] + ({
              {
                "Megnevezés",
                32
              },
              {"Raktár", 32},
              {"Rendelés", 40},
              {"Egységár", 48},
              {"Fizetendö", 48}
            })[2][2] + ({
              {
                "Megnevezés",
                32
              },
              {"Raktár", 32},
              {"Rendelés", 40},
              {"Egységár", 48},
              {"Fizetendö", 48}
            })[3][2] + ({
              {
                "Megnevezés",
                32
              },
              {"Raktár", 32},
              {"Rendelés", 40},
              {"Egységár", 48},
              {"Fizetendö", 48}
            })[4][2] + ({
              {
                "Megnevezés",
                32
              },
              {"Raktár", 32},
              {"Rendelés", 40},
              {"Egységár", 48},
              {"Fizetendö", 48}
            })[5][2], 48 + (_UPVALUE7_ * 0.85 + 12) + 6 + _FOR_ + 24 + _UPVALUE7_ + _FOR_ + 8 + _UPVALUE7_ * (select(2, unpack(({
              {
                "railIrons",
                "Sínszál",
                ("%s/%s doboz"):format(math.ceil(currentMineInventory.railIrons / railIronStack), 2),
                railIronPrice
              },
              {
                "railWoods",
                "Talpfa",
                ("%s/%s doboz"):format(math.ceil(currentMineInventory.railWoods / railWoodStack), 2),
                railWoodPrice
              },
              {
                "mineLamps",
                "Lámpa",
                ("%s/%s doboz"):format(math.ceil(currentMineInventory.mineLamps / mineLampStack), 2),
                mineLampPrice
              },
              {
                "dieselLoco",
                [[
UrmaMoto
mozdony]],
                ("%s/%s"):format(currentMineInventory.dieselLoco and 1 or 0, 1),
                dieselLocoPrice,
                true
              },
              {
                "subCartNum",
                "Kocsi",
                ("%s/%s"):format(currentMineInventory.subCartNum + (currentMineInventory.dieselLoco and 0 or 1), (currentMineInventory.dieselLoco and 6 or 1) + (currentMineInventory.dieselLoco and 0 or 1)),
                subRailCarPrice
              }
            })[_FORV_15_]):gsub("\n", "")) + 1), 4294901760, 0.9, _UPVALUE4_, "center", "center")
          end
        end
      end
      if currentMineOrder then
        if 0 < getOrderPrice(currentMineOrder) then
          if getOrderPrice(currentMineOrder) then
          else
          end
          dxDrawText("Végösszeg: " .. (formatNumber(getOrderPrice(currentMineOrder)) .. " $") .. (currentMineOrderPaid and " (fizetve)" or ""), 0, 48 + (_UPVALUE7_ * 0.85 + 12) + 6 + _FOR_ + 24 + _UPVALUE7_ + _FOR_ + 8 + _UPVALUE7_ * (select(2, unpack(({
            {
              "railIrons",
              "Sínszál",
              ("%s/%s doboz"):format(math.ceil(currentMineInventory.railIrons / railIronStack), 2),
              railIronPrice
            },
            {
              "railWoods",
              "Talpfa",
              ("%s/%s doboz"):format(math.ceil(currentMineInventory.railWoods / railWoodStack), 2),
              railWoodPrice
            },
            {
              "mineLamps",
              "Lámpa",
              ("%s/%s doboz"):format(math.ceil(currentMineInventory.mineLamps / mineLampStack), 2),
              mineLampPrice
            },
            {
              "dieselLoco",
              [[
UrmaMoto
mozdony]],
              ("%s/%s"):format(currentMineInventory.dieselLoco and 1 or 0, 1),
              dieselLocoPrice,
              true
            },
            {
              "subCartNum",
              "Kocsi",
              ("%s/%s"):format(currentMineInventory.subCartNum + (currentMineInventory.dieselLoco and 0 or 1), (currentMineInventory.dieselLoco and 6 or 1) + (currentMineInventory.dieselLoco and 0 or 1)),
              subRailCarPrice
            }
          })[_FORV_15_]):gsub("\n", "")) + 1) + 8 + _FOR_, _UPVALUE6_, 48 + (_UPVALUE7_ * 0.85 + 12) + 6 + _FOR_ + 24 + _UPVALUE7_ + _FOR_ + 8 + _UPVALUE7_ * (select(2, unpack(({
            {
              "railIrons",
              "Sínszál",
              ("%s/%s doboz"):format(math.ceil(currentMineInventory.railIrons / railIronStack), 2),
              railIronPrice
            },
            {
              "railWoods",
              "Talpfa",
              ("%s/%s doboz"):format(math.ceil(currentMineInventory.railWoods / railWoodStack), 2),
              railWoodPrice
            },
            {
              "mineLamps",
              "Lámpa",
              ("%s/%s doboz"):format(math.ceil(currentMineInventory.mineLamps / mineLampStack), 2),
              mineLampPrice
            },
            {
              "dieselLoco",
              [[
UrmaMoto
mozdony]],
              ("%s/%s"):format(currentMineInventory.dieselLoco and 1 or 0, 1),
              dieselLocoPrice,
              true
            },
            {
              "subCartNum",
              "Kocsi",
              ("%s/%s"):format(currentMineInventory.subCartNum + (currentMineInventory.dieselLoco and 0 or 1), (currentMineInventory.dieselLoco and 6 or 1) + (currentMineInventory.dieselLoco and 0 or 1)),
              subRailCarPrice
            }
          })[_FORV_15_]):gsub("\n", "")) + 1) + 8 + _FOR_ + _UPVALUE7_, 4294901760, 0.9, _UPVALUE4_, "center", "center")
          dxDrawText("A rendelés átvehetö a See Mining Co. telephelyén.", 0, 48 + (_UPVALUE7_ * 0.85 + 12) + 6 + _FOR_ + 24 + _UPVALUE7_ + _FOR_ + 8 + _UPVALUE7_ * (select(2, unpack(({
            {
              "railIrons",
              "Sínszál",
              ("%s/%s doboz"):format(math.ceil(currentMineInventory.railIrons / railIronStack), 2),
              railIronPrice
            },
            {
              "railWoods",
              "Talpfa",
              ("%s/%s doboz"):format(math.ceil(currentMineInventory.railWoods / railWoodStack), 2),
              railWoodPrice
            },
            {
              "mineLamps",
              "Lámpa",
              ("%s/%s doboz"):format(math.ceil(currentMineInventory.mineLamps / mineLampStack), 2),
              mineLampPrice
            },
            {
              "dieselLoco",
              [[
UrmaMoto
mozdony]],
              ("%s/%s"):format(currentMineInventory.dieselLoco and 1 or 0, 1),
              dieselLocoPrice,
              true
            },
            {
              "subCartNum",
              "Kocsi",
              ("%s/%s"):format(currentMineInventory.subCartNum + (currentMineInventory.dieselLoco and 0 or 1), (currentMineInventory.dieselLoco and 6 or 1) + (currentMineInventory.dieselLoco and 0 or 1)),
              subRailCarPrice
            }
          })[_FORV_15_]):gsub("\n", "")) + 1) + 8 + _FOR_ + _UPVALUE7_, _UPVALUE6_, 48 + (_UPVALUE7_ * 0.85 + 12) + 6 + _FOR_ + 24 + _UPVALUE7_ + _FOR_ + 8 + _UPVALUE7_ * (select(2, unpack(({
            {
              "railIrons",
              "Sínszál",
              ("%s/%s doboz"):format(math.ceil(currentMineInventory.railIrons / railIronStack), 2),
              railIronPrice
            },
            {
              "railWoods",
              "Talpfa",
              ("%s/%s doboz"):format(math.ceil(currentMineInventory.railWoods / railWoodStack), 2),
              railWoodPrice
            },
            {
              "mineLamps",
              "Lámpa",
              ("%s/%s doboz"):format(math.ceil(currentMineInventory.mineLamps / mineLampStack), 2),
              mineLampPrice
            },
            {
              "dieselLoco",
              [[
UrmaMoto
mozdony]],
              ("%s/%s"):format(currentMineInventory.dieselLoco and 1 or 0, 1),
              dieselLocoPrice,
              true
            },
            {
              "subCartNum",
              "Kocsi",
              ("%s/%s"):format(currentMineInventory.subCartNum + (currentMineInventory.dieselLoco and 0 or 1), (currentMineInventory.dieselLoco and 6 or 1) + (currentMineInventory.dieselLoco and 0 or 1)),
              subRailCarPrice
            }
          })[_FORV_15_]):gsub("\n", "")) + 1) + 8 + _FOR_ + _UPVALUE7_ + _UPVALUE7_, 4294901760, 0.9, _UPVALUE4_, "center", "center")
          if not currentMineOrderPaid then
            drawRedButton("cancelOrder", (_UPVALUE6_ - dxGetTextWidth("Rendelés lemondása", 0.85, _UPVALUE4_) + 24) / 2, 48 + (_UPVALUE7_ * 0.85 + 12) + 6 + _FOR_ + 24 + _UPVALUE7_ + _FOR_ + 8 + _UPVALUE7_ * (select(2, unpack(({
              {
                "railIrons",
                "Sínszál",
                ("%s/%s doboz"):format(math.ceil(currentMineInventory.railIrons / railIronStack), 2),
                railIronPrice
              },
              {
                "railWoods",
                "Talpfa",
                ("%s/%s doboz"):format(math.ceil(currentMineInventory.railWoods / railWoodStack), 2),
                railWoodPrice
              },
              {
                "mineLamps",
                "Lámpa",
                ("%s/%s doboz"):format(math.ceil(currentMineInventory.mineLamps / mineLampStack), 2),
                mineLampPrice
              },
              {
                "dieselLoco",
                [[
UrmaMoto
mozdony]],
                ("%s/%s"):format(currentMineInventory.dieselLoco and 1 or 0, 1),
                dieselLocoPrice,
                true
              },
              {
                "subCartNum",
                "Kocsi",
                ("%s/%s"):format(currentMineInventory.subCartNum + (currentMineInventory.dieselLoco and 0 or 1), (currentMineInventory.dieselLoco and 6 or 1) + (currentMineInventory.dieselLoco and 0 or 1)),
                subRailCarPrice
              }
            })[_FORV_15_]):gsub("\n", "")) + 1) + 8 + _FOR_ + _UPVALUE7_ + _UPVALUE7_ + 12, 24, _UPVALUE7_ * 0.85 + 12, "Rendelés lemondása")
          end
        end
      elseif 0 < getOrderPrice(currentMineOrdering) then
        if getOrderPrice(currentMineOrdering) then
        else
        end
        drawButton("createOrder", (_UPVALUE6_ - dxGetTextWidth(("Rendelés leadása (%s)"):format(formatNumber(getOrderPrice(currentMineOrdering)) .. " PP"):format(formatNumber(getOrderPrice(currentMineOrdering)) .. " $"), 0.85, _UPVALUE4_) + 24) / 2, 48 + (_UPVALUE7_ * 0.85 + 12) + 6 + _FOR_ + 24 + _UPVALUE7_ + _FOR_ + 8 + _UPVALUE7_ * (select(2, unpack(({
          {
            "railIrons",
            "Sínszál",
            ("%s/%s doboz"):format(math.ceil(currentMineInventory.railIrons / railIronStack), 2),
            railIronPrice
          },
          {
            "railWoods",
            "Talpfa",
            ("%s/%s doboz"):format(math.ceil(currentMineInventory.railWoods / railWoodStack), 2),
            railWoodPrice
          },
          {
            "mineLamps",
            "Lámpa",
            ("%s/%s doboz"):format(math.ceil(currentMineInventory.mineLamps / mineLampStack), 2),
            mineLampPrice
          },
          {
            "dieselLoco",
            [[
UrmaMoto
mozdony]],
            ("%s/%s"):format(currentMineInventory.dieselLoco and 1 or 0, 1),
            dieselLocoPrice,
            true
          },
          {
            "subCartNum",
            "Kocsi",
            ("%s/%s"):format(currentMineInventory.subCartNum + (currentMineInventory.dieselLoco and 0 or 1), (currentMineInventory.dieselLoco and 6 or 1) + (currentMineInventory.dieselLoco and 0 or 1)),
            subRailCarPrice
          }
        })[_FORV_15_]):gsub("\n", "")) + 1) + 8 + _FOR_ + _UPVALUE7_ + _UPVALUE7_ + 12, 24, _UPVALUE7_ * 0.85 + 12, (("Rendelés leadása (%s)"):format(formatNumber(getOrderPrice(currentMineOrdering)) .. " PP"):format(formatNumber(getOrderPrice(currentMineOrdering)) .. " $")))
      end
    end
  end
  if _UPVALUE1_ ~= "home" then
    drawButton("menu.home", 48, 568 - (_UPVALUE7_ * 0.85 + 12), 24, _UPVALUE7_ * 0.85 + 12, "< Vissza")
  end
  dxSetRenderTarget()
end
function drawTablet()
  dxDrawImage(_UPVALUE4_ - _UPVALUE2_ * (_UPVALUE0_ * _UPVALUE1_) / 2 - 200 * (_UPVALUE0_ * _UPVALUE1_), _UPVALUE5_ - _UPVALUE3_ * (_UPVALUE0_ * _UPVALUE1_) / 2 - 150 * (_UPVALUE0_ * _UPVALUE1_), 1200 * (_UPVALUE0_ * _UPVALUE1_), 900 * (_UPVALUE0_ * _UPVALUE1_), _UPVALUE6_.tabletBackground)
  dxDrawImage(_UPVALUE4_ - _UPVALUE2_ * (_UPVALUE0_ * _UPVALUE1_) / 2, _UPVALUE5_ - _UPVALUE3_ * (_UPVALUE0_ * _UPVALUE1_) / 2, _UPVALUE2_ * (_UPVALUE0_ * _UPVALUE1_), _UPVALUE3_ * (_UPVALUE0_ * _UPVALUE1_), _UPVALUE7_)
  dxDrawImage(_UPVALUE4_ - _UPVALUE2_ * (_UPVALUE0_ * _UPVALUE1_) / 2 - 200 * (_UPVALUE0_ * _UPVALUE1_), _UPVALUE5_ - _UPVALUE3_ * (_UPVALUE0_ * _UPVALUE1_) / 2 - 150 * (_UPVALUE0_ * _UPVALUE1_), 1200 * (_UPVALUE0_ * _UPVALUE1_), 900 * (_UPVALUE0_ * _UPVALUE1_), _UPVALUE6_.tabletForeground)
end
function drawComputer()
  dxDrawImage(screenWidth / 2 - _UPVALUE1_ / 2 * _UPVALUE0_ - 140 * _UPVALUE0_, screenHeight / 2 - _UPVALUE2_ / 2 * _UPVALUE0_ - 214 * _UPVALUE0_, 1080 * _UPVALUE0_, 1080 * _UPVALUE0_, _UPVALUE3_.computerBackground)
  if _UPVALUE6_ < 1 then
    dxDrawImage(screenWidth / 2 - _UPVALUE1_ / 2 * _UPVALUE0_ + _UPVALUE4_ * _UPVALUE0_ * (1 - math.min(1, _UPVALUE6_ * 6)) / 2, screenHeight / 2 - _UPVALUE2_ / 2 * _UPVALUE0_ + _UPVALUE5_ * _UPVALUE0_ * (1 - math.min(1, _UPVALUE6_ * 3)) / 2, _UPVALUE4_ * _UPVALUE0_ - _UPVALUE4_ * _UPVALUE0_ * (1 - math.min(1, _UPVALUE6_ * 6)), _UPVALUE5_ * _UPVALUE0_ - _UPVALUE5_ * _UPVALUE0_ * (1 - math.min(1, _UPVALUE6_ * 3)), _UPVALUE7_, 0, 0, 0, tocolor(255 * math.min(1, _UPVALUE6_ * 1.5), 255 * math.min(1, _UPVALUE6_ * 1.5), 255 * math.min(1, _UPVALUE6_ * 1.5), _UPVALUE6_))
  else
    dxDrawImage(screenWidth / 2 - _UPVALUE1_ / 2 * _UPVALUE0_, screenHeight / 2 - _UPVALUE2_ / 2 * _UPVALUE0_, _UPVALUE4_ * _UPVALUE0_, _UPVALUE5_ * _UPVALUE0_, _UPVALUE7_)
  end
  dxDrawImage(screenWidth / 2 - _UPVALUE1_ / 2 * _UPVALUE0_ - 140 * _UPVALUE0_, screenHeight / 2 - _UPVALUE2_ / 2 * _UPVALUE0_ - 214 * _UPVALUE0_, 1080 * _UPVALUE0_, 1080 * _UPVALUE0_, _UPVALUE3_.computerForeground)
end
function drawBorder(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_, _ARG_5_)
  dxDrawRectangle(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_4_, _ARG_5_)
  dxDrawRectangle(_ARG_0_, _ARG_1_ + _ARG_3_ - _ARG_4_, _ARG_2_, _ARG_4_, _ARG_5_)
  dxDrawRectangle(_ARG_0_, _ARG_1_, _ARG_4_, _ARG_3_, _ARG_5_)
  dxDrawRectangle(_ARG_0_ + _ARG_2_ - _ARG_4_, _ARG_1_, _ARG_4_, _ARG_3_, _ARG_5_)
end
function drawButton(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_, _ARG_5_, _ARG_6_, _ARG_7_)
  _ARG_6_ = _ARG_6_ or 0.85
  if not _ARG_7_ then
    _ARG_3_ = dxGetTextWidth(_ARG_5_, _ARG_6_, _UPVALUE0_) + _ARG_3_
  end
  if _ARG_0_ and _UPVALUE1_ == _ARG_0_ then
    dxDrawRectangle(_ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_, 4294901760)
    dxDrawText(_ARG_5_, _ARG_1_, _ARG_2_, _ARG_1_ + _ARG_3_, _ARG_2_ + _ARG_4_, 4278190080, _ARG_6_, _UPVALUE2_, "center", "center")
  else
    drawBorder(_ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_, 2, 4294901760)
    dxDrawText(_ARG_5_, _ARG_1_, _ARG_2_, _ARG_1_ + _ARG_3_, _ARG_2_ + _ARG_4_, 4294901760, _ARG_6_, _UPVALUE0_, "center", "center")
  end
  if _ARG_0_ then
    _UPVALUE3_[_ARG_0_] = {
      _ARG_1_,
      _ARG_2_,
      _ARG_3_,
      _ARG_4_
    }
  end
end
function drawRedButton(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_, _ARG_5_, _ARG_6_, _ARG_7_)
  _ARG_6_ = _ARG_6_ or 0.85
  if not _ARG_7_ then
    _ARG_3_ = dxGetTextWidth(_ARG_5_, _ARG_6_, _UPVALUE0_) + _ARG_3_
  end
  if _ARG_0_ and _UPVALUE1_ == _ARG_0_ then
    dxDrawRectangle(_ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_, 4278190335)
    dxDrawText(_ARG_5_, _ARG_1_, _ARG_2_, _ARG_1_ + _ARG_3_, _ARG_2_ + _ARG_4_, 4278190080, _ARG_6_, _UPVALUE2_, "center", "center")
  else
    drawBorder(_ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_, 2, 4278190335)
    dxDrawText(_ARG_5_, _ARG_1_, _ARG_2_, _ARG_1_ + _ARG_3_, _ARG_2_ + _ARG_4_, 4278190335, _ARG_6_, _UPVALUE0_, "center", "center")
  end
  if _ARG_0_ then
    _UPVALUE3_[_ARG_0_] = {
      _ARG_1_,
      _ARG_2_,
      _ARG_3_,
      _ARG_4_
    }
  end
end
function saveTabletPos()
end
function saveTabletZoom()
end
function setTabletBomb(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  if _ARG_3_ then
    if not _ARG_0_[_ARG_1_] then
      _ARG_0_[_ARG_1_] = {}
    end
    _ARG_0_[_ARG_1_][_ARG_2_] = true
  else
    for _FORV_7_ = _ARG_1_ - 2, _ARG_1_ + 2 do
      for _FORV_11_ = _ARG_2_ - 2, _ARG_2_ + 2 do
        if 2 >= getDistanceBetweenPoints2D(_ARG_1_, _ARG_2_, _FORV_7_, _FORV_11_) then
          setTabletBomb(_ARG_0_, _FORV_7_, _FORV_11_, true)
        end
      end
    end
  end
end
function setTabletPresetMap(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  if not _UPVALUE0_[_ARG_0_] then
    _UPVALUE0_[_ARG_0_] = {}
  end
  _UPVALUE0_[_ARG_0_][_ARG_1_] = {_ARG_2_, _ARG_3_}
end
setTabletPresetMap(-2, 0, 12, 90)
setTabletPresetMap(-2, -2, 11, 90)
setTabletPresetMap(-2, -1, 10, 90)
setTabletPresetMap(-2, 1, 10, 90)
setTabletPresetMap(-2, 2, 11, 0)
setTabletPresetMap(-6, 0, 12, 270)
setTabletPresetMap(-6, 2, 11, 270)
setTabletPresetMap(-6, 1, 10, 270)
setTabletPresetMap(-6, -1, 10, 270)
setTabletPresetMap(-6, -2, 11, 180)
setTabletPresetMap(-7, 0, 4, 180)
for _FORV_43_ = 3, 5 do
  setTabletPresetMap(-_FORV_43_, -2, 10, 180)
  setTabletPresetMap(-_FORV_43_, 2, 10, 0)
end
