mineColShapes = {}
charsetTexture = dxCreateTexture("files/textures/charset_tbl.dds", "argb", false, "clamp")
charsetMap = {
  ["Á"] = {4, 32},
  ["R"] = {45, 36},
  ["V"] = {90, 25},
  ["Í"] = {121, 13},
  ["Z"] = {141, 35},
  ["T"] = {185, 28},
  ["Ű"] = {222, 34},
  ["Ő"] = {266, 37},
  ["Ü"] = {313, 34},
  ["K"] = {357, 33},
  ["Ö"] = {400, 37},
  ["F"] = {446, 30},
  ["Ú"] = {485, 34},
  ["Ó"] = {529, 37},
  ["G"] = {577, 45},
  ["É"] = {632, 30},
  ["P"] = {671, 33},
  ["H"] = {714, 37},
  ["E"] = {760, 30},
  ["Q"] = {799, 37},
  ["U"] = {846, 34},
  ["I"] = {887, 13},
  ["C"] = {908, 41},
  ["B"] = {960, 34},
  ["O"] = {1004, 37},
  ["W"] = {1051, 40},
  ["N"] = {1101, 36},
  ["X"] = {1147, 35},
  ["J"] = {1191, 27},
  ["M"] = {1227, 40},
  ["S"] = {1277, 33},
  ["L"] = {1319, 29},
  ["A"] = {1356, 32},
  ["Y"] = {1396, 25},
  ["D"] = {1430, 39},
  ["0"] = {1479, 35},
  ["1"] = {1522, 19},
  ["2"] = {1548, 30},
  ["3"] = {1586, 32},
  ["4"] = {1626, 26},
  ["5"] = {1660, 26},
  ["6"] = {1694, 31},
  ["7"] = {1733, 27},
  ["8"] = {1768, 30},
  ["9"] = {1806, 29},
  ["$"] = {1843, 30},
  ["+"] = {1881, 32},
  ["-"] = {1921, 26},
  ["("] = {1954, 18},
  [")"] = {1977, 16},
  ["#"] = {2000, 33},
  ["@"] = {2044, 48},
  ["&"] = {2102, 31},
  ["!"] = {2140, 17},
  ["?"] = {2163, 24},
  ["%"] = {2194, 28},
  ["\""] = {2230, 26},
  ["'"] = {2262, 14},
  [","] = {2281, 17},
  ["."] = {2304, 17}
}
addEventHandler("onModloaderLoaded", localPlayer, function()
  _UPVALUE0_()
  _UPVALUE1_()
end)
addEventHandler("onClientResourceStart", resourceRoot, function()
  _UPVALUE0_()
  _UPVALUE1_()
  prepareLobbies()
  processSpotlights()
end)
function mineEntranceStreamedIn()
  table.insert(_UPVALUE0_, _UPVALUE1_[source])
  if not _UPVALUE2_ then
    addEventHandler("onClientPreRender", root, preRenderMineEntrance)
    _UPVALUE2_ = true
  end
end
function mineEntranceStreamedOut()
  for _FORV_4_ = #_UPVALUE1_, 1, -1 do
    if _UPVALUE1_[_FORV_4_] == _UPVALUE0_[source] then
      table.remove(_UPVALUE1_, _FORV_4_)
      break
    end
  end
  if #_FOR_ <= 0 and _UPVALUE2_ then
    removeEventHandler("onClientPreRender", root, preRenderMineEntrance)
    _UPVALUE2_ = false
  end
end
function lobbyEntranceMarkerEnter(_ARG_0_, _ARG_1_)
  if _ARG_1_ and _ARG_0_ == localPlayer then
    _UPVALUE0_ = _UPVALUE1_[source]
    if _UPVALUE0_ then
      exports.see_hud:showInteriorBox(lobbyCoords[_UPVALUE0_][5] .. " bánya", "Nyomj [E] gombot a belépéshez.", false, "mine")
    end
  end
end
function lobbyEntranceMarkerLeave(_ARG_0_, _ARG_1_)
  if _ARG_0_ == localPlayer and _UPVALUE0_ then
    exports.see_hud:endInteriorBox()
    _UPVALUE0_ = false
  end
end
function lobbyExitMarkerEnter(_ARG_0_, _ARG_1_)
  if _ARG_1_ and _ARG_0_ == localPlayer then
    _UPVALUE0_ = true
    if loadedMineLobby and lobbyCoords[getLobbyFromCorridor(loadedMineLobby)] then
      exports.see_hud:showInteriorBox(lobbyCoords[getLobbyFromCorridor(loadedMineLobby)][5] .. " bánya", "Nyomj [E] gombot a kilépéshez.", false, "mine")
    end
  end
end
function lobbyExitMarkerLeave(_ARG_0_, _ARG_1_)
  if _ARG_0_ == localPlayer and _UPVALUE0_ then
    exports.see_hud:endInteriorBox()
    _UPVALUE0_ = false
  end
end
function mineEntranceMarkerEnter(_ARG_0_, _ARG_1_)
  if _ARG_1_ and _ARG_0_ == localPlayer and _UPVALUE0_ then
    _UPVALUE1_ = tonumber(getElementID(source))
    if _UPVALUE1_ then
      if _UPVALUE0_[_UPVALUE1_] then
        if _UPVALUE0_[_UPVALUE1_].rentedBy == selfCharacterId and _UPVALUE0_[_UPVALUE1_].rentUntil - getRealTime().timestamp < renewalDuration then
          if (_UPVALUE0_[_UPVALUE1_].rentUntil - getRealTime().timestamp) / 3600 < 0.5 then
          elseif "kevesebb mint fél óra" < 1 then
          elseif "kevesebb mint 1 óra" < 24 then
          elseif math.floor(math.floor("kevesebb mint 1 óra") .. " óra") - math.floor((math.floor("kevesebb mint 1 óra") .. " óra") / 24) * 24 > 0 then
          else
          end
          outputChatBox("[color=orange][SeeMTA - Bánya]: [color=white]A bánya bérlete hamarosan lejár!", 255, 255, 255, true)
          outputChatBox("  - Hátralévő idő: [color=red]" .. math.floor((math.floor("kevesebb mint 1 óra") .. " óra") / 24) .. " nap", 255, 255, 255, true)
          if _UPVALUE0_[_UPVALUE1_].rentMode == "pp" then
            outputChatBox("  - Heti bérleti díj: [color=blue]" .. formatNumber(ppRentPrice) .. " PP", 255, 255, 255, true)
            outputChatBox("  - Meghosszabbításhoz használd a [color=blue]'/rentmine pp'[color=white] parancsot.", 255, 255, 255, true)
          else
            outputChatBox("  - Heti bérleti díj: [color=green]" .. formatNumber(rentPrice) .. " $", 255, 255, 255, true)
            outputChatBox("  - Meghosszabbításhoz használd a [color=green]'/rentmine'[color=white] parancsot.", 255, 255, 255, true)
          end
          guiShowInfobox("!w", "A bánya bérlete " .. (math.floor((math.floor("kevesebb mint 1 óra") .. " óra") / 24) .. " nap") .. " múlva lejár!")
        end
        exports.see_hud:showInteriorBox("[" .. _UPVALUE1_ .. "] " .. formatMineName(_UPVALUE1_), "Nyomj [E] gombot a belépéshez.", false, "mine")
      else
        outputChatBox("[color=orange][SeeMTA - Bánya]: [color=white]Ez a bánya kiadó!", 255, 255, 255, true)
        outputChatBox("  - Heti bérleti díj: [color=green]" .. formatNumber(rentPrice) .. " $[color=white] vagy [color=blue]" .. formatNumber(ppRentPrice) .. " PP", 255, 255, 255, true)
        outputChatBox("  - Kaució: [color=green]" .. formatNumber(rentDeposit) .. " $[color=white] vagy [color=blue]" .. formatNumber(ppRentDeposit) .. " PP[color=white], mely lemondás során visszajár.", 255, 255, 255, true)
        outputChatBox("  - Bérléshez használd a [color=green]'/rentmine'[color=white] vagy [color=blue]'/rentmine pp'[color=white] parancsot.", 255, 255, 255, true)
        exports.see_hud:showInteriorBox("[" .. _UPVALUE1_ .. "] " .. formatMineName(_UPVALUE1_), "Részletek a chatboxban.", false, "mine")
      end
    end
  end
end
function mineEntranceMarkerLeave(_ARG_0_, _ARG_1_)
  if _ARG_0_ == localPlayer and _UPVALUE0_ then
    exports.see_hud:endInteriorBox()
    _UPVALUE0_ = false
  end
end
function mineExitMarkerEnter(_ARG_0_, _ARG_1_)
  if _ARG_1_ and _ARG_0_ == localPlayer and currentMine then
    exports.see_hud:showInteriorBox("[" .. currentMine .. "] " .. formatMineName(currentMine), "Nyomj [E] gombot a kilépéshez.", false, "mine")
    _UPVALUE0_ = true
  end
end
function mineExitMarkerLeave(_ARG_0_, _ARG_1_)
  if _ARG_0_ == localPlayer and _UPVALUE0_ then
    exports.see_hud:endInteriorBox()
    _UPVALUE0_ = false
  end
end
bindKey("e", "up", function()
  if not isLoading() and not _UPVALUE0_ then
    if _UPVALUE1_ then
      if not isPedInVehicle(localPlayer) and _UPVALUE2_[_UPVALUE1_] then
        if _UPVALUE2_[_UPVALUE1_].isLocked then
          triggerServerEvent("tryToEnterMine", localPlayer, _UPVALUE1_)
        else
          loadingMineEnter = _UPVALUE1_
          loadingMineEnterSynced = false
          setElementDimension(mineHq, _UPVALUE1_)
          startLoader()
        end
      end
    elseif _UPVALUE3_ then
      if hasUnsyncedPermissions() then
        guiShowInfobox("e", "Várj egy kicsit!")
      elseif not isPedInVehicle(localPlayer) then
        loadingMineExit = true
        loadingMineExitSynced = false
        startLoader()
      end
    elseif _UPVALUE4_ then
      if isPedDriver(localPlayer) and not loadingMineLobbyExit then
        loadingMineLobbyExit = true
        loadingMineLobbyExitSynced = false
        startLoader()
      end
    elseif _UPVALUE5_ and isPedDriver(localPlayer) then
      openLobbySelector()
    end
  end
end)
function openLobbySelector()
  if lobbyCoords[_UPVALUE0_] then
    _UPVALUE1_ = guiCreateElement("window", (screenWidth - 300) / 2, (screenHeight - (guiGetTitleBarHeight() + 2 * 24 * lobbyCoords[_UPVALUE0_][6])) / 2, 300, guiGetTitleBarHeight() + 2 * 24 * lobbyCoords[_UPVALUE0_][6])
    if _UPVALUE1_ then
      guiSetWindowTitle(_UPVALUE1_, "16/BebasNeueRegular.otf", lobbyCoords[_UPVALUE0_][5] .. " bánya")
      guiSetWindowCloseButton(_UPVALUE1_, "closeMineLobbySelector")
    end
    for _FORV_12_ = 1, lobbyCoords[_UPVALUE0_][6] do
      if getLobbyCorridorBaseId(_UPVALUE0_) + _FORV_12_ then
        if isCorridorMarked(_UPVALUE0_, _FORV_12_) then
          guiSetImageFile(guiCreateElement("image", 8, guiGetTitleBarHeight() + (_FORV_12_ - 1) * (2 * 24) + 24 - 10, 20, 20, _UPVALUE1_), guiGetFaIconFilename("circle", 24))
          guiSetImageColor(guiCreateElement("image", 8, guiGetTitleBarHeight() + (_FORV_12_ - 1) * (2 * 24) + 24 - 10, 20, 20, _UPVALUE1_), (isCorridorMarked(_UPVALUE0_, _FORV_12_)))
        end
        if guiCreateElement("label", 8 + 28, guiGetTitleBarHeight() + (_FORV_12_ - 1) * (2 * 24), 0, 24, _UPVALUE1_) then
          guiSetLabelAlignment(guiCreateElement("label", 8 + 28, guiGetTitleBarHeight() + (_FORV_12_ - 1) * (2 * 24), 0, 24, _UPVALUE1_), "left", "center")
          guiSetLabelFont(guiCreateElement("label", 8 + 28, guiGetTitleBarHeight() + (_FORV_12_ - 1) * (2 * 24), 0, 24, _UPVALUE1_), "11/Ubuntu-R.ttf")
          guiSetLabelColor(guiCreateElement("label", 8 + 28, guiGetTitleBarHeight() + (_FORV_12_ - 1) * (2 * 24), 0, 24, _UPVALUE1_), "green")
          guiSetLabelText(guiCreateElement("label", 8 + 28, guiGetTitleBarHeight() + (_FORV_12_ - 1) * (2 * 24), 0, 24, _UPVALUE1_), _FORV_12_ .. ". járat")
        end
        if guiCreateElement("label", 8 + 28, guiGetTitleBarHeight() + (_FORV_12_ - 1) * (2 * 24) + 24, 0, 24, _UPVALUE1_) then
          guiSetLabelAlignment(guiCreateElement("label", 8 + 28, guiGetTitleBarHeight() + (_FORV_12_ - 1) * (2 * 24) + 24, 0, 24, _UPVALUE1_), "left", "center")
          guiSetLabelFont(guiCreateElement("label", 8 + 28, guiGetTitleBarHeight() + (_FORV_12_ - 1) * (2 * 24) + 24, 0, 24, _UPVALUE1_), "10/Ubuntu-L.ttf")
          guiSetLabelText(guiCreateElement("label", 8 + 28, guiGetTitleBarHeight() + (_FORV_12_ - 1) * (2 * 24) + 24, 0, 24, _UPVALUE1_), lobbyCoords[_UPVALUE0_][5] .. " bánya")
        end
        if guiCreateElement("button", 300 - 32 - 8, guiGetTitleBarHeight() + (_FORV_12_ - 1) * (2 * 24) + (2 * 24 - 32) / 2, 32, 32, _UPVALUE1_) then
          guiSetBackground(guiCreateElement("button", 300 - 32 - 8, guiGetTitleBarHeight() + (_FORV_12_ - 1) * (2 * 24) + (2 * 24 - 32) / 2, 32, 32, _UPVALUE1_), "solid", "green")
          guiSetHover(guiCreateElement("button", 300 - 32 - 8, guiGetTitleBarHeight() + (_FORV_12_ - 1) * (2 * 24) + (2 * 24 - 32) / 2, 32, 32, _UPVALUE1_), "gradient", {
            "green",
            "green-second"
          }, false, true)
          guiSetButtonFont(guiCreateElement("button", 300 - 32 - 8, guiGetTitleBarHeight() + (_FORV_12_ - 1) * (2 * 24) + (2 * 24 - 32) / 2, 32, 32, _UPVALUE1_), "14/BebasNeueBold.otf")
          guiSetButtonIcon(guiCreateElement("button", 300 - 32 - 8, guiGetTitleBarHeight() + (_FORV_12_ - 1) * (2 * 24) + (2 * 24 - 32) / 2, 32, 32, _UPVALUE1_), guiGetFaIconFilename("sign-in-alt", 32))
          guiSetClickEvent(guiCreateElement("button", 300 - 32 - 8, guiGetTitleBarHeight() + (_FORV_12_ - 1) * (2 * 24) + (2 * 24 - 32) / 2, 32, 32, _UPVALUE1_), "enterMineLobby")
          guiSetClickArgument(guiCreateElement("button", 300 - 32 - 8, guiGetTitleBarHeight() + (_FORV_12_ - 1) * (2 * 24) + (2 * 24 - 32) / 2, 32, 32, _UPVALUE1_), getLobbyCorridorBaseId(_UPVALUE0_) + _FORV_12_)
          guiSetTooltip(guiCreateElement("button", 300 - 32 - 8, guiGetTitleBarHeight() + (_FORV_12_ - 1) * (2 * 24) + (2 * 24 - 32) / 2, 32, 32, _UPVALUE1_), "Belépés")
        end
        if _FORV_12_ < lobbyCoords[_UPVALUE0_][6] then
          guiCreateElement("hr", 0, guiGetTitleBarHeight() + (_FORV_12_ - 1) * (2 * 24) + 2 * 24 - 1, 300, 2, _UPVALUE1_)
        end
      end
    end
    showCursor(true)
  end
end
function closeLobbySelector()
  if _UPVALUE0_ then
    guiDeleteElement(_UPVALUE0_)
    showCursor(false)
  end
  _UPVALUE0_ = false
end
addEvent("closeMineLobbySelector", false)
addEventHandler("closeMineLobbySelector", localPlayer, function()
  closeLobbySelector()
end, false)
addEvent("enterMineLobby", false)
addEventHandler("enterMineLobby", localPlayer, function(_ARG_0_, _ARG_1_)
  if _UPVALUE0_ then
    closeLobbySelector()
    loadingMineLobby = _ARG_1_
    loadedMineLobby = false
    setElementDimension(_UPVALUE1_, _ARG_1_)
    setElementDimension(_UPVALUE2_, _ARG_1_)
    startLoader()
  end
end)
addEvent("mineLobbyEnterResponse", true)
addEventHandler("mineLobbyEnterResponse", localPlayer, function(_ARG_0_)
  loadingMineLobby = _ARG_0_
  loadedMineLobby = _ARG_0_
  if _ARG_0_ then
    setElementDimension(_UPVALUE0_, _ARG_0_)
    setElementDimension(_UPVALUE1_, _ARG_0_)
    startLoader(true)
  end
end)
addEvent("mineLobbyExitResponse", true)
addEventHandler("mineLobbyExitResponse", localPlayer, function(_ARG_0_)
  if _ARG_0_ then
    loadingMineLobbyExit = true
    loadingMineLobbyExitSynced = true
    startLoader(true)
  else
    loadingMineLobbyExit = false
    loadingMineLobbyExitSynced = false
  end
end)
addEvent("mineLobbyLoaded", true)
addEventHandler("mineLobbyLoaded", localPlayer, function(_ARG_0_, _ARG_1_, _ARG_2_)
  selfCharacterId = _ARG_2_
  loadingMineLobby = false
  loadedMineLobby = false
  loadingMineExit = false
  loadingMineExitSynced = false
  initLobby(_ARG_0_, _ARG_1_)
end)
addEvent("mineLobbyExited", true)
addEventHandler("mineLobbyExited", localPlayer, function()
  loadingMineLobbyExit = false
  loadingMineLobbyExitSynced = false
  loadedMineLobby = false
  _UPVALUE0_ = false
  unloadLobby()
end)
addEvent("mineEnterResponse", true)
addEventHandler("mineEnterResponse", root, function(_ARG_0_, _ARG_1_)
  loadingMineEnter = _ARG_0_
  loadingMineEnterSynced = _ARG_0_
  loadingMineError = false
  if _ARG_0_ then
    startLoader(true)
  elseif _ARG_1_ then
    guiShowInfobox("e", _ARG_1_)
    loadingMineError = nil
  end
end)
addEvent("mineExitResponse", true)
addEventHandler("mineExitResponse", root, function(_ARG_0_, _ARG_1_)
  if _ARG_0_ then
    loadingMineExit = true
    loadingMineExitSynced = true
    loadingMineError = false
    startLoader(true)
  else
    loadingMineExit = false
    loadingMineExitSynced = false
    loadingMineError = _ARG_1_
  end
end)
addEvent("gotMineLobbyDoorSound", true)
addEventHandler("gotMineLobbyDoorSound", root, function(_ARG_0_)
  if source == localPlayer or source == getPedOccupiedVehicle(localPlayer) then
    playSound("files/sounds/lobbydoor.mp3")
    return
  end
  if loadedMineLobby == _ARG_0_ then
    if isElement((playSound3D("files/sounds/lobbydoor.mp3", lobbyExitX, lobbyExitY, lobbyExitZ))) then
      setElementInterior(playSound3D("files/sounds/lobbydoor.mp3", lobbyExitX, lobbyExitY, lobbyExitZ), 0)
      setElementDimension(playSound3D("files/sounds/lobbydoor.mp3", lobbyExitX, lobbyExitY, lobbyExitZ), _ARG_0_)
      setSoundMaxDistance(playSound3D("files/sounds/lobbydoor.mp3", lobbyExitX, lobbyExitY, lobbyExitZ), 50)
    end
  elseif getDistanceBetweenPoints3D(lobbyCoords[getLobbyFromCorridor(_ARG_0_)][1], lobbyCoords[getLobbyFromCorridor(_ARG_0_)][2], lobbyCoords[getLobbyFromCorridor(_ARG_0_)][3], getElementPosition(localPlayer)) <= 100 and isElement((playSound3D("files/sounds/lobbydoor.mp3", lobbyCoords[getLobbyFromCorridor(_ARG_0_)][1], lobbyCoords[getLobbyFromCorridor(_ARG_0_)][2], lobbyCoords[getLobbyFromCorridor(_ARG_0_)][3]))) then
    setSoundMaxDistance(playSound3D("files/sounds/lobbydoor.mp3", lobbyCoords[getLobbyFromCorridor(_ARG_0_)][1], lobbyCoords[getLobbyFromCorridor(_ARG_0_)][2], lobbyCoords[getLobbyFromCorridor(_ARG_0_)][3]), 50)
  end
end)
function initLobby(_ARG_0_, _ARG_1_)
  unloadLobby()
  exports.see_trailers:setDisableDetach(true)
  loadedMineLobby = _ARG_0_
  _UPVALUE0_ = _ARG_1_
  setElementDimension(_UPVALUE1_, _ARG_0_)
  setElementDimension(_UPVALUE2_, _ARG_0_)
  setElementDimension(_UPVALUE3_, _ARG_0_)
  for _FORV_8_ = 1, #_UPVALUE4_ do
    if isElement(_UPVALUE4_[_FORV_8_]) then
      setElementID(_UPVALUE4_[_FORV_8_], getLobbyMineBaseId(getLobbyFromCorridor(_ARG_0_)) + _FORV_8_)
      setElementDimension(_UPVALUE4_[_FORV_8_], _ARG_0_)
    end
    refreshLobbyMarker(getLobbyMineBaseId(getLobbyFromCorridor(_ARG_0_)) + _FORV_8_)
    refreshLobbyTable(getLobbyMineBaseId(getLobbyFromCorridor(_ARG_0_)) + _FORV_8_)
  end
  _UPVALUE5_ = playSound("files/sounds/lobbyloop.mp3", true)
  if not _UPVALUE6_ then
    addEventHandler("onClientPreRender", root, preRenderLobby)
    addEventHandler("onClientRender", root, renderLobby)
    _UPVALUE6_ = true
  end
  for _FORV_8_ = 1, #mineCoords do
    if isElement((createColSphere(unpack(mineCoords[_FORV_8_], 1, 3)))) then
      setElementInterior(createColSphere(unpack(mineCoords[_FORV_8_], 1, 3)), 0)
      setElementDimension(createColSphere(unpack(mineCoords[_FORV_8_], 1, 3)), _ARG_0_)
      addEventHandler("onClientColShapeHit", createColSphere(unpack(mineCoords[_FORV_8_], 1, 3)), handleMineColShapeEnter)
      addEventHandler("onClientColShapeLeave", createColSphere(unpack(mineCoords[_FORV_8_], 1, 3)), handleMineColShapeLeave)
    end
    mineColShapes[createColSphere(unpack(mineCoords[_FORV_8_], 1, 3))] = getLobbyMineBaseId(getLobbyFromCorridor(_ARG_0_)) + _FORV_8_
  end
end
function unloadLobby()
  for _FORV_3_ in pairs(mineColShapes) do
    if isElement(_FORV_3_) then
      destroyElement(_FORV_3_)
    end
    mineColShapes[_FORV_3_] = nil
  end
  if _UPVALUE0_ then
    removeEventHandler("onClientPreRender", root, preRenderLobby)
    removeEventHandler("onClientRender", root, renderLobby)
    _UPVALUE0_ = false
  end
  loadedMineLobby = false
  _UPVALUE1_ = false
  for _FORV_3_ in pairs(_UPVALUE2_) do
    if isElement(_UPVALUE2_[_FORV_3_]) then
      destroyElement(_UPVALUE2_[_FORV_3_])
    end
    _UPVALUE2_[_FORV_3_] = nil
  end
  _UPVALUE3_ = {}
  _UPVALUE2_ = {}
  exports.see_weather:resetWeather()
  exports.see_trailers:setDisableDetach(600)
  if isElement(_UPVALUE4_) then
    destroyElement(_UPVALUE4_)
  end
  _UPVALUE4_ = nil
end
function isPedDriver(_ARG_0_)
  if getPedOccupiedVehicle(_ARG_0_) then
    if getVehicleController((getPedOccupiedVehicle(_ARG_0_))) == _ARG_0_ then
      return true
    end
    return false
  end
  return true
end
function disableBikeFall(_ARG_0_)
  if bikeFallTimer and isTimer(bikeFallTimer) then
    killTimer(bikeFallTimer)
  end
  if _ARG_0_ == false then
    setPedCanBeKnockedOffBike(localPlayer, true)
    bikeFallTimer = nil
  elseif _ARG_0_ then
    setPedCanBeKnockedOffBike(localPlayer, false)
    if type(_ARG_0_) == "number" then
      bikeFallTimer = setTimer(function()
        setPedCanBeKnockedOffBike(localPlayer, true)
        bikeFallTimer = nil
      end, _ARG_0_ or 3000, 1)
    end
  end
end
function preRenderMineEntrance()
  for _FORV_3_ = 1, #_UPVALUE0_ do
    if isElementOnScreen(_UPVALUE1_[_UPVALUE0_[_FORV_3_]]) then
      if _UPVALUE2_ then
        dxDrawMaterialLine3D(unpack(_UPVALUE3_[_FORV_3_]))
      end
      for _FORV_8_ = 1, #_UPVALUE5_[_UPVALUE0_[_FORV_3_]] do
        dxDrawMaterialSectionLine3D(unpack(_UPVALUE5_[_UPVALUE0_[_FORV_3_]][_FORV_8_]))
      end
    end
  end
end
function prepareLobbies()
  _UPVALUE0_ = exports.see_interiors:createCoolMarker(lobbyExitX, lobbyExitY, lobbyExitZ, "mine")
  if isElement(_UPVALUE0_) then
    setElementInterior(_UPVALUE0_, 0)
    setElementDimension(_UPVALUE0_, 1)
    addEventHandler("onClientMarkerHit", _UPVALUE0_, lobbyExitMarkerEnter)
    addEventHandler("onClientMarkerLeave", _UPVALUE0_, lobbyExitMarkerLeave)
  end
  for _FORV_3_ = 1, #lobbyCoords do
    _UPVALUE1_[_FORV_3_] = {
      lobbyCoords[_FORV_3_][7] - math.cos((math.rad(lobbyCoords[_FORV_3_][10]))) * 0.62,
      lobbyCoords[_FORV_3_][8] - math.sin((math.rad(lobbyCoords[_FORV_3_][10]))) * 0.62,
      lobbyCoords[_FORV_3_][9] + 1.0685,
      math.cos((math.rad(lobbyCoords[_FORV_3_][10]))),
      (math.sin((math.rad(lobbyCoords[_FORV_3_][10]))))
    }
    _UPVALUE2_[_FORV_3_] = {}
    for _FORV_20_ = 1, utf8.len((utf8.upper(lobbyCoords[_FORV_3_][5]))) do
      if charsetMap[utf8.sub(utf8.upper(lobbyCoords[_FORV_3_][5]), _FORV_20_, _FORV_20_)] then
        table.insert(_UPVALUE2_[_FORV_3_], {
          lobbyCoords[_FORV_3_][7] - 0.4812 * math.cos((math.rad(lobbyCoords[_FORV_3_][10]))) + math.sin((math.rad(lobbyCoords[_FORV_3_][10]))) * (charsetMap[utf8.sub(utf8.upper(lobbyCoords[_FORV_3_][5]), _FORV_20_, _FORV_20_)][2] / 64 / 2),
          lobbyCoords[_FORV_3_][8] - 0.4812 * math.sin((math.rad(lobbyCoords[_FORV_3_][10]))) - math.cos((math.rad(lobbyCoords[_FORV_3_][10]))) * (charsetMap[utf8.sub(utf8.upper(lobbyCoords[_FORV_3_][5]), _FORV_20_, _FORV_20_)][2] / 64 / 2),
          lobbyCoords[_FORV_3_][9] + 1.6449,
          -math.cos((math.rad(lobbyCoords[_FORV_3_][10]))),
          -math.sin((math.rad(lobbyCoords[_FORV_3_][10]))),
          charsetMap[utf8.sub(utf8.upper(lobbyCoords[_FORV_3_][5]), _FORV_20_, _FORV_20_)][1],
          charsetMap[utf8.sub(utf8.upper(lobbyCoords[_FORV_3_][5]), _FORV_20_, _FORV_20_)][2]
        })
      else
      end
    end
    for _FORV_20_ = 1, #_UPVALUE2_[_FORV_3_] do
      if _UPVALUE2_[_FORV_3_][_FORV_20_] then
        _UPVALUE2_[_FORV_3_][_FORV_20_][1] = _UPVALUE2_[_FORV_3_][_FORV_20_][1] - math.sin((math.rad(lobbyCoords[_FORV_3_][10]))) * ((0 + charsetMap[utf8.sub(utf8.upper(lobbyCoords[_FORV_3_][5]), _FORV_20_, _FORV_20_)][2] / 64 / 2 * 2 + 0.4375) / 2)
        _UPVALUE2_[_FORV_3_][_FORV_20_][2] = _UPVALUE2_[_FORV_3_][_FORV_20_][2] + math.cos((math.rad(lobbyCoords[_FORV_3_][10]))) * ((0 + charsetMap[utf8.sub(utf8.upper(lobbyCoords[_FORV_3_][5]), _FORV_20_, _FORV_20_)][2] / 64 / 2 * 2 + 0.4375) / 2)
      end
    end
    if isElement((_FOR_.see_interiors:createCoolMarker(lobbyCoords[_FORV_3_][1], lobbyCoords[_FORV_3_][2], lobbyCoords[_FORV_3_][3], "mine", true))) then
      addEventHandler("onClientMarkerHit", _FOR_.see_interiors:createCoolMarker(lobbyCoords[_FORV_3_][1], lobbyCoords[_FORV_3_][2], lobbyCoords[_FORV_3_][3], "mine", true), lobbyEntranceMarkerEnter)
      addEventHandler("onClientMarkerLeave", _FOR_.see_interiors:createCoolMarker(lobbyCoords[_FORV_3_][1], lobbyCoords[_FORV_3_][2], lobbyCoords[_FORV_3_][3], "mine", true), lobbyEntranceMarkerLeave)
    end
    _UPVALUE3_[_FOR_.see_interiors:createCoolMarker(lobbyCoords[_FORV_3_][1], lobbyCoords[_FORV_3_][2], lobbyCoords[_FORV_3_][3], "mine", true)] = _FORV_3_
  end
  for _FORV_3_ = 1, #mineCoords do
    if isElement((exports.see_interiors:createCoolMarker(unpack(mineCoords[_FORV_3_]) - unpack(mineCoords[_FORV_3_]) * 2, unpack(mineCoords[_FORV_3_]) - unpack(mineCoords[_FORV_3_]) * 2, unpack(mineCoords[_FORV_3_]) + 1, "mine2"))) then
      setElementInterior(exports.see_interiors:createCoolMarker(unpack(mineCoords[_FORV_3_]) - unpack(mineCoords[_FORV_3_]) * 2, unpack(mineCoords[_FORV_3_]) - unpack(mineCoords[_FORV_3_]) * 2, unpack(mineCoords[_FORV_3_]) + 1, "mine2"), 0)
      setElementDimension(exports.see_interiors:createCoolMarker(unpack(mineCoords[_FORV_3_]) - unpack(mineCoords[_FORV_3_]) * 2, unpack(mineCoords[_FORV_3_]) - unpack(mineCoords[_FORV_3_]) * 2, unpack(mineCoords[_FORV_3_]) + 1, "mine2"), 1)
      addEventHandler("onClientMarkerHit", exports.see_interiors:createCoolMarker(unpack(mineCoords[_FORV_3_]) - unpack(mineCoords[_FORV_3_]) * 2, unpack(mineCoords[_FORV_3_]) - unpack(mineCoords[_FORV_3_]) * 2, unpack(mineCoords[_FORV_3_]) + 1, "mine2"), mineEntranceMarkerEnter)
      addEventHandler("onClientMarkerLeave", exports.see_interiors:createCoolMarker(unpack(mineCoords[_FORV_3_]) - unpack(mineCoords[_FORV_3_]) * 2, unpack(mineCoords[_FORV_3_]) - unpack(mineCoords[_FORV_3_]) * 2, unpack(mineCoords[_FORV_3_]) + 1, "mine2"), mineEntranceMarkerLeave)
    end
    table.insert(_UPVALUE4_, (exports.see_interiors:createCoolMarker(unpack(mineCoords[_FORV_3_]) - unpack(mineCoords[_FORV_3_]) * 2, unpack(mineCoords[_FORV_3_]) - unpack(mineCoords[_FORV_3_]) * 2, unpack(mineCoords[_FORV_3_]) + 1, "mine2")))
  end
  mineExitMarker = _FOR_.see_interiors:createCoolMarker(minePosX - 34.5877, minePosY + 0.045, minePosZ + 1, "mine3")
  if isElement(mineExitMarker) then
    setElementInterior(mineExitMarker, 0)
    setElementDimension(mineExitMarker, 1)
    addEventHandler("onClientMarkerHit", mineExitMarker, mineExitMarkerEnter)
    addEventHandler("onClientMarkerLeave", mineExitMarker, mineExitMarkerLeave)
  end
end
function processSpotlights()
  if _UPVALUE0_ ~= (getTime() >= 21 or getTime() <= 8) then
    _UPVALUE0_ = getTime() >= 21 or getTime() <= 8
    if getTime() >= 21 or getTime() <= 8 then
      for _FORV_5_ = 1, #lobbyCoords do
        table.insert(_UPVALUE2_, (createSearchLight(unpack(_UPVALUE1_[_FORV_5_]) - unpack(_UPVALUE1_[_FORV_5_]) * 0.05, unpack(_UPVALUE1_[_FORV_5_]) - unpack(_UPVALUE1_[_FORV_5_]) * 0.05, unpack(_UPVALUE1_[_FORV_5_]))))
        if isElement((playSound3D("files/sounds/lobbyspotlight.mp3", unpack(_UPVALUE1_[_FORV_5_])))) then
          setSoundVolume(playSound3D("files/sounds/lobbyspotlight.mp3", unpack(_UPVALUE1_[_FORV_5_])), 2)
          setSoundMaxDistance(playSound3D("files/sounds/lobbyspotlight.mp3", unpack(_UPVALUE1_[_FORV_5_])), 40)
        end
      end
    else
      for _FORV_5_ = #_UPVALUE2_, 1, -1 do
        if isElement(_UPVALUE2_[_FORV_5_]) then
          destroyElement(_UPVALUE2_[_FORV_5_])
        end
      end
      _UPVALUE2_ = _FOR_
    end
  end
end
addEventHandler("gotTimeChange", gamemodeRoot, processSpotlights)
addCommandHandler("rentmine", function(_ARG_0_, _ARG_1_)
  if loadedMineLobby then
    if _UPVALUE0_ then
      if _UPVALUE1_[_UPVALUE0_] then
        if _UPVALUE1_[_UPVALUE0_].rentedBy ~= selfCharacterId then
          guiShowInfobox("e", "Csak a saját bányád bérletét hosszabbíthatod meg!")
          return
        elseif _UPVALUE1_[_UPVALUE0_].rentMode == "pp" and not (utf8.lower(_ARG_1_ or "") == "pp") then
          guiShowInfobox("e", "Mivel PP-vel bérelted a bányát, csak azzal hosszabbíthatod meg! (/rentmine pp)")
          return
        else
        end
      end
      if _UPVALUE2_ + 5000 <= getTickCount() then
        triggerServerEvent("rentMine", localPlayer, _UPVALUE0_, utf8.lower(_ARG_1_ or "") == "pp" and false)
        _UPVALUE2_ = getTickCount()
      else
        guiShowInfobox("e", "Várj egy kicsit!")
      end
    else
      guiShowInfobox("e", "Csak bánya bejáratánál használhatod a parancsot!")
    end
  else
    guiShowInfobox("e", "Csak bánya bejáratánál használhatod a parancsot!")
  end
end)
addCommandHandler("unrentmine", function()
  if loadedMineLobby then
    if _UPVALUE0_ then
      if _UPVALUE1_[_UPVALUE0_] then
        if _UPVALUE1_[_UPVALUE0_].rentedBy == selfCharacterId then
          if _UPVALUE2_ + 1000 <= getTickCount() then
            triggerServerEvent("unrentMine", localPlayer, _UPVALUE0_)
            _UPVALUE2_ = getTickCount()
          else
            guiShowInfobox("e", "Várj egy kicsit!")
          end
        else
          guiShowInfobox("e", "Csak a saját bányád mondhatod le!")
        end
      end
    else
      guiShowInfobox("e", "Csak bánya bejáratánál használhatod a parancsot!")
    end
  else
    guiShowInfobox("e", "Csak bánya bejáratánál használhatod a parancsot!")
  end
end)
addEvent("gotNewMineData", true)
addEventHandler("gotNewMineData", root, function(_ARG_0_, _ARG_1_)
  if _UPVALUE0_ and loadedMineLobby == getCorridorIdFromLobbyCorridor(getLobbyFromMineId(_ARG_0_)) then
    _UPVALUE0_[_ARG_0_] = _ARG_1_
    refreshLobbyMarker(_ARG_0_)
    refreshLobbyTable(_ARG_0_)
    if _ARG_0_ == _UPVALUE1_ then
      if _ARG_1_ then
        exports.see_hud:showInteriorBox("[" .. _ARG_0_ .. "] " .. formatMineName(_ARG_0_), "Nyomj [E] gombot a belépéshez.", false, "mine")
      elseif _UPVALUE1_ then
        exports.see_hud:endInteriorBox()
        _UPVALUE1_ = false
      end
    end
  end
end)
addEvent("gotMineRentData", true)
addEventHandler("gotMineRentData", root, function(_ARG_0_, _ARG_1_, _ARG_2_)
  if _UPVALUE0_ and _UPVALUE0_[_ARG_0_] then
    _UPVALUE0_[_ARG_0_][_ARG_1_] = _ARG_2_
    if _ARG_1_ == "mineName" or _ARG_1_ == "workersInside" then
      refreshLobbyTable(_ARG_0_)
    end
  end
end)
bindKey("k", "up", function()
  if getTickCount() - _UPVALUE0_ >= 1000 and not isLoading() and not _UPVALUE1_ and not isPedInVehicle(localPlayer) then
    if _UPVALUE2_ then
      if _UPVALUE3_[_UPVALUE2_] then
        triggerServerEvent("lockUnlockMine", localPlayer, _UPVALUE2_)
        _UPVALUE0_ = getTickCount()
      end
    elseif _UPVALUE4_ then
      triggerServerEvent("lockUnlockMine", localPlayer)
      _UPVALUE0_ = getTickCount()
    end
  end
end)
addEvent("gotMineDoorLocked", true)
addEventHandler("gotMineDoorLocked", root, function(_ARG_0_, _ARG_1_)
  if currentMine == _ARG_0_ then
    currentMineLocked = _ARG_1_
    triggerEvent("gotMineDoorSound", source, _ARG_0_, 5)
  elseif loadedMineLobby and _UPVALUE0_[_ARG_0_] then
    _UPVALUE0_[_ARG_0_].isLocked = _ARG_1_
    triggerEvent("gotMineDoorSound", source, _ARG_0_, 5)
  end
end)
addEvent("gotMineDoorSound", true)
addEventHandler("gotMineDoorSound", root, function(_ARG_0_, _ARG_1_)
  if source == localPlayer then
    if _ARG_1_ == 5 then
      playSound("files/sounds/minelockunlock.mp3")
    elseif _ARG_1_ == 6 then
      playSound("files/sounds/minelocked.mp3")
    elseif _ARG_1_ >= 1 and _ARG_1_ <= 4 then
      playSound("files/sounds/minedoor" .. _ARG_1_ .. ".mp3")
    end
  else
    if currentMine == _ARG_0_ then
    elseif loadedMineLobby and loadedMineLobby == getCorridorIdFromLobbyCorridor(getLobbyFromMineId(_ARG_0_)) then
    end
    if lobbyPosX + unpack(mineCoords[getLobbyFromMineId(_ARG_0_)]) - 2 * unpack(mineCoords[getLobbyFromMineId(_ARG_0_)]) and lobbyPosY + unpack(mineCoords[getLobbyFromMineId(_ARG_0_)]) - 2 * unpack(mineCoords[getLobbyFromMineId(_ARG_0_)]) and lobbyPosZ + unpack(mineCoords[getLobbyFromMineId(_ARG_0_)]) + 1 then
      if _ARG_1_ == 5 then
      elseif _ARG_1_ == 6 then
      elseif _ARG_1_ >= 1 and _ARG_1_ <= 4 then
      end
      if isElement((playSound3D("files/sounds/minedoor" .. _ARG_1_ .. ".mp3", lobbyPosX + unpack(mineCoords[getLobbyFromMineId(_ARG_0_)]) - 2 * unpack(mineCoords[getLobbyFromMineId(_ARG_0_)]), lobbyPosY + unpack(mineCoords[getLobbyFromMineId(_ARG_0_)]) - 2 * unpack(mineCoords[getLobbyFromMineId(_ARG_0_)]), lobbyPosZ + unpack(mineCoords[getLobbyFromMineId(_ARG_0_)]) + 1))) then
        if currentMine == _ARG_0_ then
          setElementInterior(playSound3D("files/sounds/minedoor" .. _ARG_1_ .. ".mp3", lobbyPosX + unpack(mineCoords[getLobbyFromMineId(_ARG_0_)]) - 2 * unpack(mineCoords[getLobbyFromMineId(_ARG_0_)]), lobbyPosY + unpack(mineCoords[getLobbyFromMineId(_ARG_0_)]) - 2 * unpack(mineCoords[getLobbyFromMineId(_ARG_0_)]), lobbyPosZ + unpack(mineCoords[getLobbyFromMineId(_ARG_0_)]) + 1), 0)
          setElementDimension(playSound3D("files/sounds/minedoor" .. _ARG_1_ .. ".mp3", lobbyPosX + unpack(mineCoords[getLobbyFromMineId(_ARG_0_)]) - 2 * unpack(mineCoords[getLobbyFromMineId(_ARG_0_)]), lobbyPosY + unpack(mineCoords[getLobbyFromMineId(_ARG_0_)]) - 2 * unpack(mineCoords[getLobbyFromMineId(_ARG_0_)]), lobbyPosZ + unpack(mineCoords[getLobbyFromMineId(_ARG_0_)]) + 1), currentMine)
        elseif loadedMineLobby == getCorridorIdFromLobbyCorridor(getLobbyFromMineId(_ARG_0_)) then
          setElementInterior(playSound3D("files/sounds/minedoor" .. _ARG_1_ .. ".mp3", lobbyPosX + unpack(mineCoords[getLobbyFromMineId(_ARG_0_)]) - 2 * unpack(mineCoords[getLobbyFromMineId(_ARG_0_)]), lobbyPosY + unpack(mineCoords[getLobbyFromMineId(_ARG_0_)]) - 2 * unpack(mineCoords[getLobbyFromMineId(_ARG_0_)]), lobbyPosZ + unpack(mineCoords[getLobbyFromMineId(_ARG_0_)]) + 1), 0)
          setElementDimension(playSound3D("files/sounds/minedoor" .. _ARG_1_ .. ".mp3", lobbyPosX + unpack(mineCoords[getLobbyFromMineId(_ARG_0_)]) - 2 * unpack(mineCoords[getLobbyFromMineId(_ARG_0_)]), lobbyPosY + unpack(mineCoords[getLobbyFromMineId(_ARG_0_)]) - 2 * unpack(mineCoords[getLobbyFromMineId(_ARG_0_)]), lobbyPosZ + unpack(mineCoords[getLobbyFromMineId(_ARG_0_)]) + 1), loadedMineLobby)
        end
      end
    end
  end
end)
function refreshLobbyMarker(_ARG_0_)
  if _UPVALUE0_[_ARG_0_] then
    if isElement(_UPVALUE1_[getLobbyFromMineId(_ARG_0_)]) then
      exports.see_interiors:setCoolMarkerType(_UPVALUE1_[getLobbyFromMineId(_ARG_0_)], "mine3")
    end
  elseif isElement(_UPVALUE1_[getLobbyFromMineId(_ARG_0_)]) then
    exports.see_interiors:setCoolMarkerType(_UPVALUE1_[getLobbyFromMineId(_ARG_0_)], "mine2")
  end
end
function refreshLobbyTable(_ARG_0_)
  if _UPVALUE0_[_ARG_0_] then
    if math.min(maxWorkersInside, #_UPVALUE0_[_ARG_0_].workersInside) <= 0 then
    end
    if isElement(_UPVALUE1_[_ARG_0_]) then
      setElementModel(_UPVALUE1_[_ARG_0_], modelIds["v4_mine_table" .. math.min(maxWorkersInside, #_UPVALUE0_[_ARG_0_].workersInside)])
    else
      _UPVALUE1_[_ARG_0_] = createObject(modelIds["v4_mine_table" .. math.min(maxWorkersInside, #_UPVALUE0_[_ARG_0_].workersInside)], mineCoords[getLobbyFromMineId(_ARG_0_)][7], mineCoords[getLobbyFromMineId(_ARG_0_)][8], mineCoords[getLobbyFromMineId(_ARG_0_)][9], 0, 0, mineCoords[getLobbyFromMineId(_ARG_0_)][10])
      if isElement(_UPVALUE1_[_ARG_0_]) then
        setElementInterior(_UPVALUE1_[_ARG_0_], 0)
        setElementDimension(_UPVALUE1_[_ARG_0_], loadedMineLobby)
      end
    end
    _UPVALUE2_[_ARG_0_] = {}
    for _FORV_16_ = 1, 2 do
      if _UPVALUE0_[_ARG_0_].mineName[_FORV_16_] then
        for _FORV_26_ = 1, utf8.len((utf8.upper(_UPVALUE0_[_ARG_0_].mineName[_FORV_16_]))) do
          if charsetMap[utf8.sub(utf8.upper(_UPVALUE0_[_ARG_0_].mineName[_FORV_16_]), _FORV_26_, _FORV_26_)] then
            table.insert(_UPVALUE2_[_ARG_0_], {
              mineCoords[getLobbyFromMineId(_ARG_0_)][7] + mineCoords[getLobbyFromMineId(_ARG_0_)][11] * 0.05 - mineCoords[getLobbyFromMineId(_ARG_0_)][12] * (charsetMap[utf8.sub(utf8.upper(_UPVALUE0_[_ARG_0_].mineName[_FORV_16_]), _FORV_26_, _FORV_26_)][2] / 512 / 2),
              mineCoords[getLobbyFromMineId(_ARG_0_)][8] + mineCoords[getLobbyFromMineId(_ARG_0_)][12] * 0.05 + mineCoords[getLobbyFromMineId(_ARG_0_)][11] * (charsetMap[utf8.sub(utf8.upper(_UPVALUE0_[_ARG_0_].mineName[_FORV_16_]), _FORV_26_, _FORV_26_)][2] / 512 / 2),
              mineCoords[getLobbyFromMineId(_ARG_0_)][9] - (1 < #_UPVALUE0_[_ARG_0_].mineName and (_FORV_16_ - 1.5) * 0.125 or 0),
              mineCoords[getLobbyFromMineId(_ARG_0_)][11],
              mineCoords[getLobbyFromMineId(_ARG_0_)][12],
              charsetMap[utf8.sub(utf8.upper(_UPVALUE0_[_ARG_0_].mineName[_FORV_16_]), _FORV_26_, _FORV_26_)][1],
              charsetMap[utf8.sub(utf8.upper(_UPVALUE0_[_ARG_0_].mineName[_FORV_16_]), _FORV_26_, _FORV_26_)][2]
            })
          else
          end
        end
        for _FORV_26_ = 1, #_UPVALUE2_[_ARG_0_] do
          if _UPVALUE2_[_ARG_0_][_FORV_26_] then
            _UPVALUE2_[_ARG_0_][_FORV_26_][1] = _UPVALUE2_[_ARG_0_][_FORV_26_][1] + mineCoords[getLobbyFromMineId(_ARG_0_)][12] * ((0 + charsetMap[utf8.sub(utf8.upper(_UPVALUE0_[_ARG_0_].mineName[_FORV_16_]), _FORV_26_, _FORV_26_)][2] / 512 / 2 * 2 + 0.0546875) / 2)
            _UPVALUE2_[_ARG_0_][_FORV_26_][2] = _UPVALUE2_[_ARG_0_][_FORV_26_][2] - mineCoords[getLobbyFromMineId(_ARG_0_)][11] * ((0 + charsetMap[utf8.sub(utf8.upper(_UPVALUE0_[_ARG_0_].mineName[_FORV_16_]), _FORV_26_, _FORV_26_)][2] / 512 / 2 * 2 + 0.0546875) / 2)
          end
        end
      end
    end
  else
    _UPVALUE2_[_ARG_0_] = nil
    if isElement(_UPVALUE1_[_ARG_0_]) then
      destroyElement(_UPVALUE1_[_ARG_0_])
    end
    _UPVALUE1_[_ARG_0_] = nil
  end
end
function preRenderLobby(_ARG_0_)
  setTime(12, 0)
  setWeather(1)
  setSkyGradient(0, 0, 0, 0, 0, 0)
  for _FORV_4_ in pairs(_UPVALUE0_) do
    if isElementOnScreen(_UPVALUE1_[_FORV_4_]) then
      for _FORV_10_ = 1, #_UPVALUE0_[_FORV_4_] do
        dxDrawMaterialSectionLine3D(unpack(_UPVALUE0_[_FORV_4_][_FORV_10_]))
      end
    end
  end
end
function renderLobby()
end
