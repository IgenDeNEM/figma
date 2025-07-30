developmentMode = true
resourceName = getResourceName(resource)
gamemodeRoot = getElementByID("gamemode-root")
loadedPlayers = {}
doorRammerTicks = {}
doorDamagePeriod = 1800000
playersInMine = {}
playersCurrentMine = {}
mineOrders = {}
mineOrderPaid = {}
mineOrderTransit = {}
mineTankPreRequest = {}
addEventHandler("onDatabaseConnected", gamemodeRoot, function(_ARG_0_)
  dbConnection = _ARG_0_
  if isElement(dbConnection) then
    loadMines()
  end
end)
addEventHandler("onResourceStart", resourceRoot, function()
  initLobbies()
  if not dbConnection then
    dbConnection = exports.see_database:getConnection()
  end
  initOres()
  if isElement(dbConnection) then
    loadMines()
  end
  setTimer(checkRents, 1800000, 0)
end, false)
addEventHandler("onResourceStop", resourceRoot, function()
  for _FORV_3_, _FORV_4_ in pairs(playersCurrentMine) do
    if developmentMode then
      setElementData(_FORV_3_, "wasInMine", _FORV_4_, false)
      setElementFrozen(_FORV_3_, true)
    else
      setPlayerMine(_FORV_3_, false, true)
    end
  end
  for _FORV_3_, _FORV_4_ in pairs(playersCurrentLobby) do
    if developmentMode then
      setElementData(_FORV_3_, "wasInMineLobby", _FORV_4_, false)
      setElementFrozen(_FORV_3_, true)
    else
      setPlayerLobby(_FORV_3_, false, true)
    end
  end
  doMineSaving()
end, false)
addEventHandler("onPlayerResourceStart", root, function(_ARG_0_)
  if resource == _ARG_0_ then
    table.insert(loadedPlayers, source)
    if next(_UPVALUE0_) or next(_UPVALUE1_) or next(_UPVALUE2_) then
      triggerLatentClientEvent(source, "gotMineHandItems", source, _UPVALUE0_, _UPVALUE1_, _UPVALUE2_)
    end
    if developmentMode then
      if getElementData(source, "wasInMine") then
        setPlayerMine(source, (getElementData(source, "wasInMine")))
        setTimer(setElementFrozen, 1000, 1, source, false)
        removeElementData(source, "wasInMine")
      elseif getElementData(source, "wasInMineLobby") then
        setPlayerLobby(source, (getElementData(source, "wasInMineLobby")))
        setTimer(setElementFrozen, 1000, 1, source, false)
        removeElementData(source, "wasInMineLobby")
      end
    end
  end
end)
addEventHandler("onPlayerQuit", root, function()
  _UPVALUE0_[source] = nil
  _UPVALUE1_[source] = nil
  _UPVALUE2_[source] = nil
  _UPVALUE3_[source] = nil
  resetPlayerFixOre(source)
  resetPlayerOreBox(source)
  resetPlayerJerrycan(source)
  if playersCurrentMine[source] then
    setPlayerMine(source, false, true)
  end
  if playersCurrentLobby[source] then
    setPlayerLobby(source, false, true)
  end
  for _FORV_3_ = #loadedPlayers, 1, -1 do
    if loadedPlayers[_FORV_3_] == source then
      table.remove(loadedPlayers, _FORV_3_)
      break
    end
  end
end, true, "high+1")
addEventHandler("onPlayerWasted", root, function()
  resetPlayerFixOre(source)
  resetPlayerOreBox(source)
  resetPlayerJerrycan(source)
end, true, "high+1")
function checkMinePermission(_ARG_0_, _ARG_1_, _ARG_2_)
  _ARG_2_ = _ARG_2_ or playersCurrentMine[_ARG_0_]
  if _ARG_2_ and loadedMinesData[_ARG_2_] then
    if loadedMinesData[_ARG_2_].rentedBy == getElementData(_ARG_0_, "char.ID") then
      return true
    elseif _ARG_1_ and loadedMinesData[_ARG_2_].workerPermissions[getElementData(_ARG_0_, "char.ID")] then
      return bitTest(loadedMinesData[_ARG_2_].workerPermissions[getElementData(_ARG_0_, "char.ID")], _ARG_1_)
    end
  end
  return false
end
function addMineEventHandler(_ARG_0_, _ARG_1_, _ARG_2_)
  addEvent(_ARG_0_, true)
  addEventHandler(_ARG_0_, _ARG_1_, function(...)
    if client and playersCurrentMine[client] and loadedMinesData[playersCurrentMine[client]] then
      _UPVALUE0_(playersCurrentMine[client], ...)
    end
  end)
end
function addTrailerEventHandler(_ARG_0_, _ARG_1_, _ARG_2_)
  addEvent(_ARG_0_, true)
  addEventHandler(_ARG_0_, _ARG_1_, function(...)
    if client and getPedOccupiedVehicle(client) and getPedOccupiedVehicleSeat(client) == 0 and exports.see_trailers:getAttachedTrailer((getPedOccupiedVehicle(client))) then
      _UPVALUE0_(exports.see_trailers:getAttachedTrailer((getPedOccupiedVehicle(client))), ...)
    end
  end)
end
function initMine(_ARG_0_)
  if loadedMinesData[_ARG_0_] then
    parseMine(_ARG_0_)
    if not _UPVALUE0_[_ARG_0_] then
      _UPVALUE0_[_ARG_0_] = {
        {
          0,
          0,
          2,
          0,
          rngRandomSeed(),
          0
        }
      }
    end
    if not _UPVALUE1_[_ARG_0_] then
      _UPVALUE1_[_ARG_0_] = {
        {
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
    if not _UPVALUE2_[_ARG_0_] then
      _UPVALUE2_[_ARG_0_] = {_UPVALUE3_}
    end
    if not _UPVALUE4_[_ARG_0_] then
      _UPVALUE4_[_ARG_0_] = {}
    end
    for _FORV_5_, _FORV_6_ in pairs(_UPVALUE0_[_ARG_0_]) do
      _UPVALUE4_[_ARG_0_][_FORV_5_] = rngCreate(_FORV_6_[5])
      if 0 < _FORV_6_[6] then
        rngSkip(_UPVALUE4_[_ARG_0_][_FORV_5_], _FORV_6_[6])
      end
    end
    if not _UPVALUE5_[_ARG_0_] then
      _UPVALUE5_[_ARG_0_] = {}
    end
    if not _UPVALUE6_[_ARG_0_] then
      _UPVALUE6_[_ARG_0_] = {}
    end
    if not _UPVALUE7_[_ARG_0_] then
      _UPVALUE7_[_ARG_0_] = {}
    end
    refreshMineShafts(_ARG_0_)
    if not _UPVALUE8_[_ARG_0_] then
      _UPVALUE8_[_ARG_0_] = {}
    end
    if not _UPVALUE9_[_ARG_0_] then
      _UPVALUE9_[_ARG_0_] = {}
    end
    for _FORV_5_ = 1, #_UPVALUE8_[_ARG_0_] do
      if not _UPVALUE9_[_ARG_0_][unpack(_UPVALUE8_[_ARG_0_][_FORV_5_])] then
        _UPVALUE9_[_ARG_0_][unpack(_UPVALUE8_[_ARG_0_][_FORV_5_])] = {}
      end
      _UPVALUE9_[_ARG_0_][unpack(_UPVALUE8_[_ARG_0_][_FORV_5_])][unpack(_UPVALUE8_[_ARG_0_][_FORV_5_])] = _FORV_5_
    end
    if not _FOR_[_ARG_0_] then
      _UPVALUE10_[_ARG_0_] = {}
      for _FORV_5_ in pairs(_UPVALUE1_[_ARG_0_]) do
        _UPVALUE10_[_ARG_0_][_FORV_5_] = generateShaftOres(_ARG_0_, _FORV_5_)
      end
    end
    if not _UPVALUE11_[_ARG_0_] then
      _UPVALUE11_[_ARG_0_] = {}
    end
    if not _UPVALUE12_[_ARG_0_] then
      _UPVALUE12_[_ARG_0_] = {
        {
          -4,
          0,
          0,
          0,
          true
        }
      }
    end
    if not _UPVALUE13_[_ARG_0_] then
      _UPVALUE13_[_ARG_0_] = {}
    end
    if not _UPVALUE14_[_ARG_0_] then
      _UPVALUE14_[_ARG_0_] = {}
    end
    if not _UPVALUE15_[_ARG_0_] then
      _UPVALUE15_[_ARG_0_] = {}
    end
    if not _UPVALUE16_[_ARG_0_] then
      _UPVALUE16_[_ARG_0_] = {}
    end
    if not _UPVALUE17_[_ARG_0_] then
      _UPVALUE17_[_ARG_0_] = {
        mineLamps = 0,
        railIrons = 0,
        railWoods = 0,
        subCartNum = 0,
        dieselLoco = false,
        fuelTankLevel = 0,
        fuelTankOutside = false
      }
    end
    if not _UPVALUE18_[_ARG_0_] then
      _UPVALUE18_[_ARG_0_] = {
        trackId = 1,
        routeId = -1,
        trackPosition = math.min(getMineTrainLength(_ARG_0_), 12),
        trackDirection = 1,
        fuelLevel = 100,
        jerryCarry = nil,
        jerryContent = 0
      }
    end
    if _UPVALUE17_[_ARG_0_].dieselLoco then
      _UPVALUE19_[_ARG_0_] = {}
    end
    for _FORV_6_, _FORV_7_ in pairs(_UPVALUE12_[_ARG_0_]) do
      if #_FORV_7_ == 4 then
        if not _UPVALUE14_[_ARG_0_][_FORV_7_[1]] then
          _UPVALUE14_[_ARG_0_][_FORV_7_[1]] = {}
        end
        _UPVALUE14_[_ARG_0_][_FORV_7_[1]][_FORV_7_[2]] = _FORV_6_
      else
        for _FORV_11_ = _FORV_7_[1], _FORV_7_[3], _FORV_7_[3] < _FORV_7_[1] and -1 or 1 do
          if not _UPVALUE14_[_ARG_0_][_FORV_11_] then
            _UPVALUE14_[_ARG_0_][_FORV_11_] = {}
          end
          for _FORV_15_ = _FORV_7_[2], _FORV_7_[4], _FORV_7_[4] < _FORV_7_[2] and -1 or 1 do
            _UPVALUE14_[_ARG_0_][_FORV_11_][_FORV_15_] = _FORV_6_
          end
        end
      end
    end
    for _FORV_6_, _FORV_7_ in pairs(_UPVALUE13_[_ARG_0_]) do
      if #_FORV_7_ > 4 and not _UPVALUE16_[_ARG_0_][_FORV_6_] then
        _UPVALUE16_[_ARG_0_][_FORV_6_] = 1
      end
      if _UPVALUE14_[_ARG_0_][_FORV_7_[1]] then
        _UPVALUE14_[_ARG_0_][_FORV_7_[1]][_FORV_7_[2]] = nil
      end
      if not _UPVALUE15_[_ARG_0_][_FORV_7_[1]] then
        _UPVALUE15_[_ARG_0_][_FORV_7_[1]] = {}
      end
      _UPVALUE15_[_ARG_0_][_FORV_7_[1]][_FORV_7_[2]] = _FORV_6_
    end
    if not _UPVALUE20_[_ARG_0_] then
      _UPVALUE20_[_ARG_0_] = {}
    end
    if not _UPVALUE21_[_ARG_0_] then
      _UPVALUE21_[_ARG_0_] = {}
    end
    if not _UPVALUE22_[_ARG_0_] then
      _UPVALUE22_[_ARG_0_] = {}
    end
    if not _UPVALUE23_[_ARG_0_] then
      _UPVALUE23_[_ARG_0_] = {}
    end
    if not _UPVALUE24_[_ARG_0_] then
      for _FORV_7_, _FORV_8_ in pairs(oreTypes) do
        if _FORV_8_.meltingPoint then
          ({
            furnaceRunning = false,
            furnaceTemperature = {},
            furnaceLastRefresh = {},
            meltingOre = false,
            meltProgress = 0
          }).furnaceTemperature[_FORV_7_] = 0
        end
      end
      _UPVALUE24_[_ARG_0_] = {
        furnaceRunning = false,
        furnaceTemperature = {},
        furnaceLastRefresh = {},
        meltingOre = false,
        meltProgress = 0
      }
    end
    if not _UPVALUE25_[_ARG_0_] then
      _UPVALUE25_[_ARG_0_] = {}
    end
  end
end
function resetMine(_ARG_0_, _ARG_1_)
  if loadedMinesData[_ARG_0_] then
    for _FORV_7_ = 1, #playersInMine[_ARG_0_] do
      if isElement(playersInMine[_ARG_0_][_FORV_7_]) then
        setPlayerMine(playersInMine[_ARG_0_][_FORV_7_], false)
        _UPVALUE0_[playersInMine[_ARG_0_][_FORV_7_]] = nil
        _UPVALUE1_[playersInMine[_ARG_0_][_FORV_7_]] = nil
        _UPVALUE2_[playersInMine[_ARG_0_][_FORV_7_]] = nil
        if _ARG_1_ == "expired" then
          exports.see_gui:showInfobox(playersInMine[_ARG_0_][_FORV_7_], "w", "Ki lettél teleportálva, mert lejárt a bánya bérleti ideje!")
        else
          exports.see_gui:showInfobox(playersInMine[_ARG_0_][_FORV_7_], "w", "Ki lettél teleportálva, mert a bánya bérletét lemondták!")
        end
      end
    end
    _FOR_[_ARG_0_] = nil
    if isTimer(_UPVALUE3_[_ARG_0_]) then
      killTimer(_UPVALUE3_[_ARG_0_])
    end
    _UPVALUE4_[_ARG_0_] = nil
    _UPVALUE5_[_ARG_0_] = nil
    _UPVALUE6_[_ARG_0_] = nil
    _UPVALUE7_[_ARG_0_] = nil
    _UPVALUE8_[_ARG_0_] = nil
    _UPVALUE9_[_ARG_0_] = nil
    _UPVALUE10_[_ARG_0_] = nil
    _UPVALUE11_[_ARG_0_] = nil
    _UPVALUE12_[_ARG_0_] = nil
    _UPVALUE13_[_ARG_0_] = nil
    _UPVALUE14_[_ARG_0_] = nil
    _UPVALUE15_[_ARG_0_] = nil
    _UPVALUE16_[_ARG_0_] = nil
    _UPVALUE17_[_ARG_0_] = nil
    _UPVALUE18_[_ARG_0_] = nil
    _UPVALUE19_[_ARG_0_] = nil
    _UPVALUE20_[_ARG_0_] = nil
    _UPVALUE21_[_ARG_0_] = nil
    _UPVALUE22_[_ARG_0_] = nil
    _UPVALUE23_[_ARG_0_] = nil
    _UPVALUE24_[_ARG_0_] = nil
    _UPVALUE25_[_ARG_0_] = nil
    _UPVALUE26_[_ARG_0_] = nil
    _UPVALUE27_[_ARG_0_] = nil
    _UPVALUE28_[_ARG_0_] = nil
    _UPVALUE29_[_ARG_0_] = nil
    _UPVALUE30_[_ARG_0_] = nil
    _UPVALUE31_[_ARG_0_] = nil
    mineOrders[_ARG_0_] = nil
    mineOrderPaid[_ARG_0_] = nil
    mineOrderTransit[_ARG_0_] = nil
    mineTankPreRequest[_ARG_0_] = nil
    _UPVALUE3_[_ARG_0_] = nil
    if _UPVALUE32_[_ARG_0_] then
      _UPVALUE32_[_ARG_0_] = nil
      if not next(_UPVALUE32_) then
        if isTimer(_UPVALUE33_) then
          killTimer(_UPVALUE33_)
        end
        _UPVALUE33_ = nil
      end
    end
    loadedMinesData[_ARG_0_] = nil
    if #playersInLobby[getCorridorIdFromLobbyCorridor(getLobbyFromMineId(_ARG_0_))] > 0 then
      triggerClientEvent(playersInLobby[getCorridorIdFromLobbyCorridor(getLobbyFromMineId(_ARG_0_))], "gotNewMineData", gamemodeRoot, _ARG_0_, nil)
    end
    collectgarbage()
    if isElement(dbConnection) then
      dbExec(dbConnection, "DELETE FROM mines WHERE mineId = ?", _ARG_0_)
    end
    if fileExists("data/" .. _ARG_0_ .. ".see") then
      fileDelete("data/" .. _ARG_0_ .. ".see")
    end
    return true
  end
  return false
end
function checkValidSpot(_ARG_0_, _ARG_1_, _ARG_2_)
  return (not _UPVALUE0_[_ARG_0_][_ARG_1_] or not _UPVALUE0_[_ARG_0_][_ARG_1_][_ARG_2_]) and _UPVALUE1_[_ARG_0_][_ARG_1_] and _UPVALUE1_[_ARG_0_][_ARG_1_][_ARG_2_]
end
function checkValidSpotEx(_ARG_0_, _ARG_1_, _ARG_2_)
  if checkValidSpot(_ARG_0_, _ARG_1_, _ARG_2_) and (not _UPVALUE0_[_ARG_0_][_ARG_1_] or not _UPVALUE0_[_ARG_0_][_ARG_1_][_ARG_2_]) then
    return true
  end
  return false
end
function getMineTrainLength(_ARG_0_)
  if _UPVALUE0_[_ARG_0_] then
    return (_UPVALUE0_[_ARG_0_].dieselLoco and dieselLocoLength or mineCartLength) + mineCartLength * _UPVALUE0_[_ARG_0_].subCartNum
  end
  return 0
end
function findRailAngle(_ARG_0_, _ARG_1_)
  if not _UPVALUE0_[_ARG_0_][_ARG_1_] then
    return
  elseif #_UPVALUE0_[_ARG_0_][_ARG_1_] == 4 then
    return prad(_UPVALUE0_[_ARG_0_][_ARG_1_][3])
  end
  return patan2(_UPVALUE0_[_ARG_0_][_ARG_1_][4] - _UPVALUE0_[_ARG_0_][_ARG_1_][2], _UPVALUE0_[_ARG_0_][_ARG_1_][3] - _UPVALUE0_[_ARG_0_][_ARG_1_][1])
end
function processSwitch(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  if #getNearTracks(_UPVALUE0_[_ARG_0_], _ARG_1_, _ARG_2_, _ARG_3_) == 2 then
    if (patan2(_ARG_2_ - getNearTracks(_UPVALUE0_[_ARG_0_], _ARG_1_, _ARG_2_, _ARG_3_)[1].trackY, _ARG_1_ - getNearTracks(_UPVALUE0_[_ARG_0_], _ARG_1_, _ARG_2_, _ARG_3_)[1].trackX) - patan2(_ARG_2_ - getNearTracks(_UPVALUE0_[_ARG_0_], _ARG_1_, _ARG_2_, _ARG_3_)[2].trackY, _ARG_1_ - getNearTracks(_UPVALUE0_[_ARG_0_], _ARG_1_, _ARG_2_, _ARG_3_)[2].trackX) + PI) % TWO_PI - PI > 0 then
      return {
        getNearTracks(_UPVALUE0_[_ARG_0_], _ARG_1_, _ARG_2_, _ARG_3_)[1].trackId,
        getNearTracks(_UPVALUE0_[_ARG_0_], _ARG_1_, _ARG_2_, _ARG_3_)[2].trackId
      }
    else
      return {
        getNearTracks(_UPVALUE0_[_ARG_0_], _ARG_1_, _ARG_2_, _ARG_3_)[2].trackId,
        getNearTracks(_UPVALUE0_[_ARG_0_], _ARG_1_, _ARG_2_, _ARG_3_)[1].trackId
      }
    end
  elseif #getNearTracks(_UPVALUE0_[_ARG_0_], _ARG_1_, _ARG_2_, _ARG_3_) > 2 then
    for _FORV_9_ = 1, #getNearTracks(_UPVALUE0_[_ARG_0_], _ARG_1_, _ARG_2_, _ARG_3_) do
      if getNearTracks(_UPVALUE0_[_ARG_0_], _ARG_1_, _ARG_2_, _ARG_3_)[_FORV_9_] then
        table.insert({}, {
          getNearTracks(_UPVALUE0_[_ARG_0_], _ARG_1_, _ARG_2_, _ARG_3_)[_FORV_9_].trackId,
          patan2(_ARG_2_ - getNearTracks(_UPVALUE0_[_ARG_0_], _ARG_1_, _ARG_2_, _ARG_3_)[_FORV_9_].trackY, _ARG_1_ - getNearTracks(_UPVALUE0_[_ARG_0_], _ARG_1_, _ARG_2_, _ARG_3_)[_FORV_9_].trackX)
        })
      end
    end
    _FOR_.sort({}, function(_ARG_0_, _ARG_1_)
      return _ARG_1_[2] < _ARG_0_[2]
    end)
    while ({})[1][2] % PI ~= ({})[3][2] % PI do
      table.insert({}, 1, table.remove({}, #{}))
    end
    for _FORV_9_ = 1, #{} do
      ({})[_FORV_9_] = ({})[_FORV_9_][1]
    end
    return {}
  end
end
function findFreeRailTrack(_ARG_0_)
  while true do
    if _UPVALUE0_[_ARG_0_][1] then
    end
  end
  return 1 + 1
end
function findFreeRailSwitch(_ARG_0_)
  while true do
    if _UPVALUE0_[_ARG_0_][1] then
    end
  end
  return 1 + 1
end
function resetPlayerJerrycan(_ARG_0_)
  if playersCurrentMine[_ARG_0_] and _UPVALUE0_[playersCurrentMine[_ARG_0_]].jerryCarry == _ARG_0_ then
    _UPVALUE0_[playersCurrentMine[_ARG_0_]].jerryCarry = nil
    if #playersInMine[playersCurrentMine[_ARG_0_]] > 0 then
      triggerClientEvent(playersInMine[playersCurrentMine[_ARG_0_]], "gotMineJerrycan", _ARG_0_, playersCurrentMine[_ARG_0_], false)
    end
  end
end
function resetPlayerOreBox(_ARG_0_)
  if playersCurrentMine[_ARG_0_] and _UPVALUE0_[_ARG_0_] then
    _UPVALUE1_[playersCurrentMine[_ARG_0_]][_UPVALUE0_[_ARG_0_]] = nil
    if #playersInMine[playersCurrentMine[_ARG_0_]] > 0 then
      triggerClientEvent(playersInMine[playersCurrentMine[_ARG_0_]], "syncMineOreBoxCarry", _ARG_0_, playersCurrentMine[_ARG_0_], false)
    end
    if eventName ~= "onPlayerQuit" then
      exports.see_controls:toggleControl(_ARG_0_, {
        "fire",
        "crouch",
        "aim_weapon",
        "jump",
        "jog"
      }, true, "mineOreCarry")
    end
  end
  _UPVALUE0_[_ARG_0_] = nil
end
function resetPlayerFixOre(_ARG_0_)
  if playersCurrentMine[_ARG_0_] and _UPVALUE0_[_ARG_0_] then
    if _UPVALUE1_[playersCurrentMine[_ARG_0_]][_UPVALUE0_[_ARG_0_]] then
      _UPVALUE1_[playersCurrentMine[_ARG_0_]][_UPVALUE0_[_ARG_0_]][4] = nil
      _UPVALUE1_[playersCurrentMine[_ARG_0_]][_UPVALUE0_[_ARG_0_]][5] = nil
      _UPVALUE1_[playersCurrentMine[_ARG_0_]][_UPVALUE0_[_ARG_0_]][6] = nil
      if #playersInMine[playersCurrentMine[_ARG_0_]] > 0 then
        triggerClientEvent(playersInMine[playersCurrentMine[_ARG_0_]], "syncFixOreState", resourceRoot, playersCurrentMine[_ARG_0_], _UPVALUE0_[_ARG_0_], "ground", _UPVALUE1_[playersCurrentMine[_ARG_0_]][_UPVALUE0_[_ARG_0_]][1], _UPVALUE1_[playersCurrentMine[_ARG_0_]][_UPVALUE0_[_ARG_0_]][2])
      end
    end
    if eventName ~= "onPlayerQuit" then
      exports.see_controls:toggleControl(_ARG_0_, {
        "fire",
        "crouch",
        "aim_weapon",
        "jump",
        "jog"
      }, true, "mineOreCarry")
    end
  end
  _UPVALUE0_[_ARG_0_] = nil
end
addEvent("syncMineTablet", true)
addEventHandler("syncMineTablet", root, function(_ARG_0_)
  _ARG_0_ = _ARG_0_ and true or nil
  if client then
    if _ARG_0_ and not playersCurrentMine[client] then
      return exports.see_gui:showInfobox(client, "e", "Csak bányában veheted elő!")
    end
    _UPVALUE0_[client] = _ARG_0_
    if _ARG_0_ then
      exports.see_chat:localAction(client, "elővett egy Urmamoto Tabletet.")
    else
      exports.see_chat:localAction(client, "elrakott egy Urmamoto Tabletet.")
    end
    if #loadedPlayers > 0 then
      triggerClientEvent(loadedPlayers, "syncMineTablet", client, _ARG_0_)
    end
  end
end)
addMineEventHandler("renameMine", root, function(_ARG_0_, _ARG_1_)
  if not checkMinePermission(client) then
    triggerLatentClientEvent(client, "renameMineResponse", client, false, "Ehhez nincs jogosultságod!")
  elseif #_ARG_1_ > 2 then
    triggerLatentClientEvent(client, "renameMineResponse", client, false, "A bánya neve túl hosszú!")
  elseif getCorridorIdFromLobbyCorridor(getLobbyFromMineId(_ARG_0_)) then
    if table.concat(loadedMinesData[_ARG_0_].mineName, "|") ~= table.concat(_ARG_1_, "|") then
      loadedMinesData[_ARG_0_].mineName = _ARG_1_
      if isElement(dbConnection) then
        dbExec(dbConnection, "UPDATE mines SET mineName = ? WHERE mineId = ?", table.concat(_ARG_1_, "|"), _ARG_0_)
      end
      if #playersInMine[_ARG_0_] > 0 then
        triggerClientEvent(playersInMine[_ARG_0_], "gotMineRentDataInside", client, _ARG_0_, "mineName", _ARG_1_)
      end
      if 0 < #playersInLobby[getCorridorIdFromLobbyCorridor(getLobbyFromMineId(_ARG_0_))] then
        triggerClientEvent(playersInLobby[getCorridorIdFromLobbyCorridor(getLobbyFromMineId(_ARG_0_))], "gotMineRentData", client, _ARG_0_, "mineName", (table.concat(_ARG_1_, "|")))
      end
    end
    triggerLatentClientEvent(client, "renameMineResponse", client, _ARG_1_)
  else
    triggerLatentClientEvent(client, "renameMineResponse", client)
  end
end)
addMineEventHandler("useMineFaucet", root, function(_ARG_0_)
  if hasElementData(client, "mineDirtyFace") then
    removeElementData(client, "mineDirtyFace")
    setPedHeadingTo(client, minePosX - 27.3901, minePosY + 2.8282)
    setPedAnimation(client, "int_house", "wash_up", -1, false, false, false, false)
    if #playersInMine[_ARG_0_] > 0 then
      triggerClientEvent(playersInMine[_ARG_0_], "playMineFaucetSound", client, _ARG_0_)
    end
    exports.see_chat:localAction(client, "megmosakodott.")
  end
end)
addEvent("removeMineDirtyFace", true)
addEventHandler("removeMineDirtyFace", root, function()
  if client then
    removeElementData(client, "mineDirtyFace")
  end
end)
addMineEventHandler("buildMineLight", root, function(_ARG_0_, _ARG_1_, _ARG_2_)
  if not checkMinePermission(client, permissionFlags.CONSTRUCT_LAMP) then
    exports.see_gui:showInfobox(client, "e", "Ehhez nincs jogosultságod!")
  elseif _UPVALUE0_[_ARG_0_].mineLamps < 1 then
    exports.see_gui:showInfobox(client, "e", "Nincs elég lámpa készleten!")
  elseif not _UPVALUE1_[_ARG_0_][_ARG_1_] or not _UPVALUE1_[_ARG_0_][_ARG_1_][_ARG_2_] then
    _UPVALUE0_[_ARG_0_].mineLamps = _UPVALUE0_[_ARG_0_].mineLamps - 1
    if _UPVALUE0_[_ARG_0_].mineLamps < 0 then
      _UPVALUE0_[_ARG_0_].mineLamps = 0
    end
    if not _UPVALUE1_[_ARG_0_][_ARG_1_] then
      _UPVALUE1_[_ARG_0_][_ARG_1_] = {}
    end
    _UPVALUE1_[_ARG_0_][_ARG_1_][_ARG_2_] = true
    if 0 < #playersInMine[_ARG_0_] then
      triggerClientEvent(playersInMine[_ARG_0_], "buildMineLight", client, _ARG_0_, _ARG_1_, _ARG_2_, _UPVALUE0_[_ARG_0_].mineLamps)
    end
    exports.see_chat:localAction(client, "felszerelt egy lámpát.")
  end
end)
addMineEventHandler("cancelMineOrder", root, function(_ARG_0_)
  if not checkMinePermission(client, permissionFlags.ORDER) then
    exports.see_gui:showInfobox(client, "e", "Ehhez nincs jogosultságod!")
  elseif mineOrders[_ARG_0_] then
    exports.see_gui:showInfobox(client, "s", "Lemondtad a rendelést.")
    mineOrders[_ARG_0_] = nil
    mineOrderPaid[_ARG_0_] = nil
    if #playersInMine[_ARG_0_] > 0 then
      triggerClientEvent(playersInMine[_ARG_0_], "gotMineOrder", client, _ARG_0_, mineOrders[_ARG_0_], mineOrderPaid[_ARG_0_])
    end
    triggerLatentClientEvent(client, "mineOrderResponse", client)
  end
end)
addMineEventHandler("createMineOrder", root, function(_ARG_0_, _ARG_1_)
  if not checkMinePermission(client, permissionFlags.ORDER) then
    triggerLatentClientEvent(client, "mineOrderResponse", client, false, "Ehhez nincs jogosultságod!")
  elseif _UPVALUE0_[_ARG_0_] then
    refreshOrderConstraints(_ARG_1_, _UPVALUE0_[_ARG_0_])
    if mineOrders[_ARG_0_] then
      triggerLatentClientEvent(client, "mineOrderResponse", client, false, "Már van leadva rendelés!")
    elseif next(_ARG_1_) then
      mineOrders[_ARG_0_] = _ARG_1_
      mineOrderPaid[_ARG_0_] = nil
      if #playersInMine[_ARG_0_] > 0 then
        triggerClientEvent(playersInMine[_ARG_0_], "gotMineOrder", client, _ARG_0_, mineOrders[_ARG_0_], mineOrderPaid[_ARG_0_])
      end
      triggerLatentClientEvent(client, "mineOrderResponse", client, true, "Leadtad a rendelést. Átvenni a See Mining Co. telephelyén tudod.")
    else
      triggerLatentClientEvent(client, "mineOrderResponse", client, false)
    end
  end
end)
addMineEventHandler("updateMinePermissions", root, function(_ARG_0_, _ARG_1_)
  if not checkMinePermission(client) then
    return
  elseif next(_ARG_1_) then
    for _FORV_6_, _FORV_7_ in pairs(_ARG_1_) do
      if loadedMinesData[_ARG_0_].workerPermissions[_FORV_6_] then
        loadedMinesData[_ARG_0_].workerPermissions[_FORV_6_] = _FORV_7_
      end
    end
    if #playersInMine[_ARG_0_] > 0 then
      triggerClientEvent(playersInMine[_ARG_0_], "updateMinePermissions", client, _ARG_0_, loadedMinesData[_ARG_0_].workerPermissions)
    end
  end
end)
addMineEventHandler("removeMinePermissions", root, function(_ARG_0_, _ARG_1_)
  if not checkMinePermission(client) then
    exports.see_gui:showInfobox(client, "e", "Ehhez nincs jogosultságod!")
  elseif not loadedMinesData[_ARG_0_].workerPermissions[_ARG_1_] then
    exports.see_gui:showInfobox(client, "e", "A kiválasztott játékos nem alkalmazottad!")
  else
    loadedMinesData[_ARG_0_].workerNames[_ARG_1_] = nil
    loadedMinesData[_ARG_0_].workerPermissions[_ARG_1_] = nil
    if #playersInMine[_ARG_0_] > 0 then
      triggerClientEvent(playersInMine[_ARG_0_], "removeMinePermissions", client, _ARG_0_, _ARG_1_)
    end
    for _FORV_6_ = 1, #playersInMine[_ARG_0_] do
      if getElementData(playersInMine[_ARG_0_], "char.ID") == _ARG_1_ then
        for _FORV_12_ = #loadedMinesData[_ARG_0_].workersInside, 1, -1 do
          if loadedMinesData[_ARG_0_].workersInside[_FORV_12_] == _ARG_1_ then
            table.remove(loadedMinesData[_ARG_0_].workersInside, _FORV_12_)
            break
          end
        end
        if 0 < #_FOR_[getCorridorIdFromLobbyCorridor(getLobbyFromMineId(_ARG_0_))] then
          triggerClientEvent(playersInLobby[getCorridorIdFromLobbyCorridor(getLobbyFromMineId(_ARG_0_))], "gotMineRentData", client, _ARG_0_, "workersInside", loadedMinesData[_ARG_0_].workersInside)
        end
        break
      end
    end
  end
end)
addMineEventHandler("addMinePermissions", root, function(_ARG_0_, _ARG_1_)
  if not checkMinePermission(client) then
    exports.see_gui:showInfobox(client, "e", "Ehhez nincs jogosultságod!")
  elseif not isElement(_ARG_1_) then
    exports.see_gui:showInfobox(client, "e", "A kiválasztott játékos nem található!")
  elseif _ARG_1_ == client then
    exports.see_gui:showInfobox(client, "e", "Saját magadat nem alkalmazhatod!")
  elseif not getElementData(_ARG_1_, "char.ID") then
    exports.see_gui:showInfobox(client, "e", "A kiválasztott játékos nincs bejelentkezve!")
  elseif loadedMinesData[_ARG_0_].workerPermissions[getElementData(_ARG_1_, "char.ID")] then
    exports.see_gui:showInfobox(client, "e", "A kiválasztott játékos már alkalmazottad!")
  else
    for _FORV_9_ in pairs(loadedMinesData[_ARG_0_].workerPermissions) do
      if 0 + 1 >= maxWorkers then
        return exports.see_gui:showInfobox(client, "e", "Nem alkalmazhatsz több munkást!")
      end
    end
    loadedMinesData[_ARG_0_].workerNames[getElementData(_ARG_1_, "char.ID")] = getElementData(_ARG_1_, "char.Name"):gsub("_", " ")
    loadedMinesData[_ARG_0_].workerPermissions[getElementData(_ARG_1_, "char.ID")] = 0
    if 0 < #playersInMine[_ARG_0_] then
      triggerClientEvent(playersInMine[_ARG_0_], "addMinePermissions", client, _ARG_0_, getElementData(_ARG_1_, "char.ID"), (getElementData(_ARG_1_, "char.Name"):gsub("_", " ")))
    end
    if _ARG_0_ == playersCurrentMine[_ARG_1_] then
      for _FORV_10_ = #loadedMinesData[_ARG_0_].workersInside, 1, -1 do
        if loadedMinesData[_ARG_0_].workersInside[_FORV_10_] == getElementData(_ARG_1_, "char.ID") then
          table.remove(loadedMinesData[_ARG_0_].workersInside, _FORV_10_)
          break
        end
      end
      _FOR_.insert(loadedMinesData[_ARG_0_].workersInside, (getElementData(_ARG_1_, "char.ID")))
      if 0 < #playersInLobby[getCorridorIdFromLobbyCorridor(getLobbyFromMineId(_ARG_0_))] then
        triggerClientEvent(playersInLobby[getCorridorIdFromLobbyCorridor(getLobbyFromMineId(_ARG_0_))], "gotMineRentData", client, _ARG_0_, "workersInside", loadedMinesData[_ARG_0_].workersInside)
      end
    end
  end
end)
addTrailerEventHandler("deliverMineOrder", root, function(_ARG_0_, _ARG_1_)
  if mineOrders[_ARG_1_] and playersCurrentLobby[client] and playersCurrentLobby[client] == getCorridorIdFromLobbyCorridor(getLobbyFromMineId(_ARG_1_)) then
    if (exports.see_trailers:getTrailerData(_ARG_0_) or {})[1] == _ARG_1_ and #(exports.see_trailers:getTrailerData(_ARG_0_) or {}) >= 2 then
      processTrailerData(exports.see_trailers:getTrailerData(_ARG_0_) or {})
      if isElement(client) then
        exports.see_gui:showInfobox(client, "s", "Leszállítottad a rendelést.")
      end
      exports.see_trailers:setTrailerData(_ARG_0_, nil)
    end
  end
end)
addEvent("trailerMineOrder", true)
addEventHandler("trailerMineOrder", root, function(_ARG_0_, _ARG_1_)
  if client then
    if mineOrders[_ARG_0_] then
      if not checkMinePermission(client, permissionFlags.ORDER, _ARG_0_) then
        exports.see_gui:showInfobox(client, "e", "Ehhez nincs jogosultságod!")
      elseif not mineOrderPaid[_ARG_0_] then
        exports.see_gui:showInfobox(client, "e", "A rendelés még nincs kifizetve!")
      elseif isElement(mineOrderTransit[_ARG_0_]) then
        exports.see_gui:showInfobox(client, "e", "A rendelést már átvették!")
      elseif isElement(_ARG_1_) then
        if getElementModel(_ARG_1_) ~= 611 then
          exports.see_gui:showInfobox(client, "e", "Nem megfelelő utánfutó!")
        elseif not exports.see_trailers:isTrailerEmpty(_ARG_1_) then
          exports.see_gui:showInfobox(client, "e", "Az utánfutó már foglalt!")
        else
          for _FORV_7_, _FORV_8_ in pairs(mineOrders[_ARG_0_]) do
            for _FORV_12_ = 1, _FORV_8_ do
              table.insert({_ARG_0_}, _FORV_7_)
            end
          end
          if exports.see_trailers:setTrailerData(_ARG_1_, {_ARG_0_}) then
            mineOrderTransit[_ARG_0_] = _ARG_1_
          end
          exports.see_gui:showInfobox(client, "s", "Átvetted a rendelést. Vidd a bányába!")
        end
      end
    end
    triggerLatentClientEvent(client, "gotMineListForOrders", client, getPlayerMineOrders(client))
  end
end)
addEvent("payMineOrder", true)
addEventHandler("payMineOrder", root, function(_ARG_0_)
  if client then
    if mineOrders[_ARG_0_] then
      if mineOrderPaid[_ARG_0_] then
        exports.see_gui:showInfobox(client, "e", "A rendelést már kifizették!")
      elseif not checkMinePermission(client, permissionFlags.ORDER, _ARG_0_) then
        exports.see_gui:showInfobox(client, "e", "Ehhez nincs jogosultságod!")
      else
        if getOrderPrice(mineOrders[_ARG_0_]) then
          if exports.see_core:takePremiumPoints(client, getOrderPrice(mineOrders[_ARG_0_])) then
            mineOrderPaid[_ARG_0_] = true
          end
        elseif exports.see_core:takeMoney(client, getOrderPrice(mineOrders[_ARG_0_])) then
          mineOrderPaid[_ARG_0_] = true
        end
        if not mineOrderPaid[_ARG_0_] then
          if getOrderPrice(mineOrders[_ARG_0_]) then
            exports.see_gui:showInfobox(client, "e", "Nincs elég prémium pontod a rendelés kifizetésére!")
          else
            exports.see_gui:showInfobox(client, "e", "Nincs elég pénzed a rendelés kifizetésére!")
          end
        else
          serializeMine(_ARG_0_, true)
          if #playersInMine[_ARG_0_] > 0 then
            triggerClientEvent(playersInMine[_ARG_0_], "gotMineOrderPaid", client, _ARG_0_, mineOrderPaid[_ARG_0_])
          end
          exports.see_gui:showInfobox(client, "s", "Kifizetted a rendelést. Már fel tudod rakodni.")
        end
      end
    end
    triggerLatentClientEvent(client, "gotMineListForOrders", client, getPlayerMineOrders(client))
  end
end)
addEvent("requestMineListForOrders", true)
addEventHandler("requestMineListForOrders", root, function()
  if client then
    triggerLatentClientEvent(client, "gotMineListForOrders", client, getPlayerMineOrders(client))
  end
end)
function getPlayerMineOrders(_ARG_0_)
  if getElementData(_ARG_0_, "char.ID") then
    for _FORV_6_ in pairs(mineOrders) do
      if loadedMinesData[_FORV_6_].rentedBy == getElementData(_ARG_0_, "char.ID") or loadedMinesData[_FORV_6_].workerPermissions[getElementData(_ARG_0_, "char.ID")] then
        table.insert({}, {
          mineId = _FORV_6_,
          mineName = utf8.upper(table.concat(loadedMinesData[_FORV_6_].mineName, " ")),
          totalPrice = formatNumber(getOrderPrice(mineOrders[_FORV_6_])) .. (getOrderPrice(mineOrders[_FORV_6_]) and " PP" or " $"),
          isPremium = getOrderPrice(mineOrders[_FORV_6_])
        })
      end
    end
    return {}
  end
  return false
end
function processMineOrder(_ARG_0_, _ARG_1_)
  for _FORV_7_, _FORV_8_ in pairs(_ARG_1_) do
    if _FORV_7_ == "railIrons" then
      _UPVALUE0_[_ARG_0_][_FORV_7_] = math.min(_UPVALUE0_[_ARG_0_][_FORV_7_] + railIronStack * _FORV_8_, 2 * railIronStack)
    elseif _FORV_7_ == "railWoods" then
      _UPVALUE0_[_ARG_0_][_FORV_7_] = math.min(_UPVALUE0_[_ARG_0_][_FORV_7_] + railWoodStack * _FORV_8_, 2 * railWoodStack)
    elseif _FORV_7_ == "mineLamps" then
      _UPVALUE0_[_ARG_0_][_FORV_7_] = math.min(_UPVALUE0_[_ARG_0_][_FORV_7_] + mineLampStack * _FORV_8_, 2 * mineLampStack)
    elseif _FORV_7_ == "subCartNum" then
      if _UPVALUE0_[_ARG_0_].dieselLoco then
        _UPVALUE0_[_ARG_0_].subCartNum = math.min(6, _UPVALUE0_[_ARG_0_].subCartNum + _FORV_8_)
      else
        _UPVALUE0_[_ARG_0_].subCartNum = math.min(1, _UPVALUE0_[_ARG_0_].subCartNum + _FORV_8_)
      end
    elseif _FORV_7_ == "dieselLoco" and not _UPVALUE0_[_ARG_0_].dieselLoco then
      _UPVALUE0_[_ARG_0_].dieselLoco = true
      if not _UPVALUE1_[_ARG_0_] then
        _UPVALUE1_[_ARG_0_] = {}
      end
      if _UPVALUE0_[_ARG_0_].subCartNum < 1 then
        _UPVALUE0_[_ARG_0_].subCartNum = 1
      end
    end
    if #playersInMine[_ARG_0_] > 0 then
      triggerClientEvent(playersInMine[_ARG_0_], "updateMineInventory", resourceRoot, _ARG_0_, _FORV_7_, _UPVALUE0_[_ARG_0_][_FORV_7_])
      if _FORV_7_ == "dieselLoco" then
        triggerClientEvent(playersInMine[_ARG_0_], "updateMineInventory", resourceRoot, _ARG_0_, "subCartNum", _UPVALUE0_[_ARG_0_].subCartNum)
      end
    end
  end
  if true and _UPVALUE2_[_ARG_0_] then
    if 0 > _UPVALUE2_[_ARG_0_].trackPosition - getMineTrainLength(_ARG_0_) then
      _UPVALUE2_[_ARG_0_].trackPosition = getMineTrainLength(_ARG_0_)
    end
    if #playersInMine[_ARG_0_] > 0 then
      triggerClientEvent(playersInMine[_ARG_0_], "mineRailSyncing", resourceRoot, _ARG_0_, _UPVALUE2_[_ARG_0_])
    end
  end
  if #playersInMine[_ARG_0_] > 0 then
    triggerClientEvent(playersInMine[_ARG_0_], "gotMineOrder", resourceRoot, _ARG_0_, nil, nil)
  end
  serializeMine(_ARG_0_, true)
end
function processTrailerData(_ARG_0_)
  if _ARG_0_[1] then
    if #_ARG_0_ == 1 then
      if _UPVALUE0_[_ARG_0_[1]].tankOutside then
        _UPVALUE0_[_ARG_0_[1]].tankOutside = false
        if #playersInMine[_ARG_0_[1]] > 0 then
          triggerClientEvent(playersInMine[_ARG_0_[1]], "updateMineInventory", resourceRoot, _ARG_0_[1], "tankOutside", false)
        end
      end
    elseif #_ARG_0_ >= 2 then
      mineOrderTransit[_ARG_0_[1]] = nil
      if mineOrders[_ARG_0_[1]] then
        processMineOrder(_ARG_0_[1], mineOrders[_ARG_0_[1]])
        mineOrders[_ARG_0_[1]] = nil
      end
    end
  end
end
function canRentTrailer(_ARG_0_)
  for _FORV_4_ in pairs(mineOrders) do
    if checkMinePermission(_ARG_0_, permissionFlags.ORDER, _FORV_4_) then
      return true
    end
  end
  return false
end
addTrailerEventHandler("returnMineFuelTank", root, function(_ARG_0_)
  if _UPVALUE0_[client] and playersCurrentLobby[client] and playersCurrentLobby[client] == getCorridorIdFromLobbyCorridor(getLobbyFromMineId(_UPVALUE0_[client])) then
    if (exports.see_trailers:getTrailerData(_ARG_0_) or {})[1] == _UPVALUE0_[client] and #(exports.see_trailers:getTrailerData(_ARG_0_) or {}) == 1 then
      processTrailerData(exports.see_trailers:getTrailerData(_ARG_0_) or {})
      triggerClientEvent(client, "gotMineTankPreRequest", client, false)
      _UPVALUE0_[client] = nil
      exports.see_trailers:setTrailerData(_ARG_0_, nil)
    end
  end
end)
addTrailerEventHandler("trailerMineTank", root, function(_ARG_0_, _ARG_1_)
  if playersCurrentLobby[client] and playersCurrentLobby[client] == getCorridorIdFromLobbyCorridor(getLobbyFromMineId(_ARG_1_)) and loadedMinesData[_ARG_1_] then
    if not checkMinePermission(client, permissionFlags.ORDER, _ARG_1_) then
      exports.see_gui:showInfobox(client, "e", "Ehhez nincs jogosultságod!")
    elseif _UPVALUE0_[_ARG_1_].tankOutside then
      exports.see_gui:showInfobox(client, "e", "A tartály már szállítás alatt van!")
    elseif getElementModel(_ARG_0_) ~= 611 then
      exports.see_gui:showInfobox(client, "e", "Nem megfelelő utánfutó!")
    elseif not exports.see_trailers:isTrailerEmpty(_ARG_0_) then
      exports.see_gui:showInfobox(client, "e", "Az utánfutó már foglalt!")
    elseif _UPVALUE1_[client] == _ARG_1_ and exports.see_trailers:setTrailerData(_ARG_0_, {_ARG_1_}) then
      _UPVALUE0_[_ARG_1_].tankOutside = true
      if #playersInMine[_ARG_1_] > 0 then
        triggerClientEvent(playersInMine[_ARG_1_], "updateMineInventory", resourceRoot, _ARG_1_, "tankOutside", true)
      end
      exports.see_gui:showInfobox(client, "i", "A tartályt bármely benzinkúton meg tudod tankolni. Ide hozd vissza!")
    end
  end
end)
addMineEventHandler("requestMineFuelTank", root, function(_ARG_0_)
  if not checkMinePermission(client, permissionFlags.ORDER) then
    exports.see_gui:showInfobox(client, "e", "Ehhez nincs jogosultságod!")
  elseif _UPVALUE0_[_ARG_0_].tankOutside then
    exports.see_gui:showInfobox(client, "e", "A tartály már szállítás alatt van!")
  elseif not _UPVALUE1_[client] then
    _UPVALUE1_[client] = _ARG_0_
    if #playersInMine[_ARG_0_] > 0 then
      triggerClientEvent(client, "gotMineTankPreRequest", client, _ARG_0_)
    end
    exports.see_gui:showInfobox(client, "i", "Megkezdted az üzemanyagtartály feltöltését. Állj a megjelölt helyre egy üres utánfutóval, a kék jelölést autóban ülve látod.")
  elseif _UPVALUE1_[client] == _ARG_0_ then
    _UPVALUE1_[client] = nil
    if #playersInMine[_ARG_0_] > 0 then
      triggerClientEvent(client, "gotMineTankPreRequest", client, false)
    end
    exports.see_gui:showInfobox(client, "i", "Megszakítottad az üzemanyagtartály feltöltését.")
  else
    exports.see_gui:showInfobox(client, "e", "Már egy másik bányában megkezdted az üzemanyagtartály feltöltését!")
  end
end)
addMineEventHandler("fillMineLocoTank", root, function(_ARG_0_)
  if _UPVALUE0_[_ARG_0_].dieselLoco and _UPVALUE1_[_ARG_0_].jerryCarry == client then
    if _UPVALUE1_[_ARG_0_].jerryContent <= 0 then
      exports.see_gui:showInfobox(client, "e", "A kanna üres!")
    elseif _UPVALUE1_[_ARG_0_].fuelLevel >= 100 then
      exports.see_gui:showInfobox(client, "e", "A tank tele van!")
    elseif 0 < math.min(locoTankCapacity - _UPVALUE1_[_ARG_0_].fuelLevel * locoTankCapacity / 100, _UPVALUE1_[_ARG_0_].jerryContent) then
      _UPVALUE1_[_ARG_0_].fuelLevel = _UPVALUE1_[_ARG_0_].fuelLevel + math.min(locoTankCapacity - _UPVALUE1_[_ARG_0_].fuelLevel * locoTankCapacity / 100, _UPVALUE1_[_ARG_0_].jerryContent) / locoTankCapacity * 100
      if _UPVALUE1_[_ARG_0_].fuelLevel > 100 then
        _UPVALUE1_[_ARG_0_].fuelLevel = 100
      end
      _UPVALUE1_[_ARG_0_].jerryContent = _UPVALUE1_[_ARG_0_].jerryContent - math.min(locoTankCapacity - _UPVALUE1_[_ARG_0_].fuelLevel * locoTankCapacity / 100, _UPVALUE1_[_ARG_0_].jerryContent)
      if _UPVALUE1_[_ARG_0_].jerryContent < 0 then
        _UPVALUE1_[_ARG_0_].jerryContent = 0
      end
      if 0 < #playersInMine[_ARG_0_] then
        triggerClientEvent(playersInMine[_ARG_0_], "syncMineLocoFuel", client, _ARG_0_, _UPVALUE1_[_ARG_0_].fuelLevel, math.min(locoTankCapacity - _UPVALUE1_[_ARG_0_].fuelLevel * locoTankCapacity / 100, _UPVALUE1_[_ARG_0_].jerryContent) * 1000)
        triggerClientEvent(playersInMine[_ARG_0_], "syncMineJerryContent", client, _ARG_0_, _UPVALUE1_[_ARG_0_].jerryContent)
      end
      exports.see_chat:localAction(client, "megtankolta a mozdonyt.")
    end
  end
end)
addMineEventHandler("fillMineJerrycan", root, function(_ARG_0_)
  if _UPVALUE0_[_ARG_0_].dieselLoco then
    if _UPVALUE0_[_ARG_0_].fuelTankOutside then
      return
    elseif _UPVALUE1_[_ARG_0_].jerryCarry == client then
      if _UPVALUE0_[_ARG_0_].fuelTankLevel <= 0 then
        exports.see_gui:showInfobox(client, "e", "A tartály üres!")
      elseif _UPVALUE1_[_ARG_0_].jerryContent >= jerryCanCapacity then
        exports.see_gui:showInfobox(client, "e", "A kanna tele van!")
      else
        _UPVALUE1_[_ARG_0_].jerryContent = _UPVALUE1_[_ARG_0_].jerryContent + math.min(jerryCanCapacity - _UPVALUE1_[_ARG_0_].jerryContent, _UPVALUE0_[_ARG_0_].fuelTankLevel)
        if _UPVALUE1_[_ARG_0_].jerryContent > jerryCanCapacity then
          _UPVALUE1_[_ARG_0_].jerryContent = jerryCanCapacity
        end
        _UPVALUE0_[_ARG_0_].fuelTankLevel = _UPVALUE0_[_ARG_0_].fuelTankLevel - math.min(jerryCanCapacity - _UPVALUE1_[_ARG_0_].jerryContent, _UPVALUE0_[_ARG_0_].fuelTankLevel)
        if _UPVALUE0_[_ARG_0_].fuelTankLevel < 0 then
          _UPVALUE0_[_ARG_0_].fuelTankLevel = 0
        end
        if 0 < #playersInMine[_ARG_0_] then
          triggerClientEvent(playersInMine[_ARG_0_], "updateMineInventory", client, _ARG_0_, "fuelTankLevel", _UPVALUE0_[_ARG_0_].fuelTankLevel)
          triggerClientEvent(playersInMine[_ARG_0_], "syncMineJerryContent", client, _ARG_0_, _UPVALUE1_[_ARG_0_].jerryContent)
        end
        exports.see_chat:localAction(client, "megtankolta a kannát.")
      end
    end
  end
end)
addMineEventHandler("putMineJerrycan", root, function(_ARG_0_)
  if _UPVALUE0_[_ARG_0_].dieselLoco and _UPVALUE1_[_ARG_0_].jerryCarry == client then
    _UPVALUE1_[_ARG_0_].jerryCarry = nil
    if #playersInMine[_ARG_0_] > 0 then
      triggerClientEvent(playersInMine[_ARG_0_], "gotMineJerrycan", client, _ARG_0_, false)
    end
    exports.see_chat:localAction(client, "visszatette a kannát a mozdonyra.")
  end
end)
addMineEventHandler("getMineJerrycan", root, function(_ARG_0_)
  if _UPVALUE0_[_ARG_0_].dieselLoco and not isElement(_UPVALUE1_[_ARG_0_].jerryCarry) then
    _UPVALUE1_[_ARG_0_].jerryCarry = client
    if #playersInMine[_ARG_0_] > 0 then
      triggerClientEvent(playersInMine[_ARG_0_], "gotMineJerrycan", client, _ARG_0_, _UPVALUE1_[_ARG_0_].jerryCarry)
    end
    exports.see_chat:localAction(client, "levette a kannát a mozdonyról.")
  end
end)
addMineEventHandler("takeMineIngot", root, function(_ARG_0_, _ARG_1_)
  if oreTypes[_ARG_1_].meltingPoint then
    if not checkMinePermission(client, permissionFlags.COLLECT_PRODUCT) then
      exports.see_gui:showInfobox(client, "e", "Ehhez nincs jogosultságod!")
    elseif _UPVALUE0_[_ARG_0_].meltingOre == _ARG_1_ then
      _UPVALUE0_[_ARG_0_].meltProgress = math.min(1, _UPVALUE0_[_ARG_0_].meltProgress + (getTickCount() - _UPVALUE0_[_ARG_0_].meltingStart) / meltingTime)
      _UPVALUE0_[_ARG_0_].meltingStart = getTickCount()
      if _UPVALUE0_[_ARG_0_].meltProgress < 1 then
        exports.see_gui:showInfobox(client, "e", "Előbb várd meg a fém kiöntését!")
      elseif exports.see_items:giveItem(client, oreTypes[_ARG_1_].itemId, 1) then
        _UPVALUE0_[_ARG_0_].meltingOre = false
        _UPVALUE0_[_ARG_0_].meltProgress = 0
        _UPVALUE0_[_ARG_0_].meltingStart = nil
        if 0 < #playersInMine[_ARG_0_] then
          triggerClientEvent(playersInMine[_ARG_0_], "syncMineOreMelting", client, _ARG_0_, false)
          triggerClientEvent(playersInMine[_ARG_0_], "syncMineOreItemOutput", client, _ARG_0_, _ARG_1_)
        end
        exports.see_chat:localAction(client, "kivett egy " .. oreTypes[_ARG_1_].actionName .. " az öntőformából.")
      else
        exports.see_gui:showInfobox(client, "e", "Nincs elég hely az inventorydban!")
      end
    end
  end
end)
addMineEventHandler("makeMineIngot", root, function(_ARG_0_, _ARG_1_)
  if oreTypes[_ARG_1_].meltingPoint then
    if not checkMinePermission(client, permissionFlags.USE_FOUNDRY) then
      exports.see_gui:showInfobox(client, "e", "Ehhez nincs jogosultságod!")
    elseif _UPVALUE0_[_ARG_0_].furnaceRunning ~= _ARG_1_ then
      exports.see_gui:showInfobox(client, "e", "Először kapcsold be a kohót!")
    elseif not _UPVALUE0_[_ARG_0_].meltingOre then
      _UPVALUE0_[_ARG_0_].furnaceTemperature[_ARG_1_] = math.min(1000, _UPVALUE0_[_ARG_0_].furnaceTemperature[_ARG_1_] + (_UPVALUE0_[_ARG_0_].furnaceLastRefresh[_ARG_1_] and getTickCount() - _UPVALUE0_[_ARG_0_].furnaceLastRefresh[_ARG_1_] or 0) / oreTypes[_ARG_1_].furnaceSpeed)
      _UPVALUE0_[_ARG_0_].furnaceLastRefresh[_ARG_1_] = getTickCount()
      if _UPVALUE0_[_ARG_0_].furnaceTemperature[_ARG_1_] < 1000 then
        exports.see_gui:showInfobox(client, "e", "Előbb várd meg amíg a kohó eléri a szükséges hőfokot!")
      elseif math.floor(_UPVALUE1_[_ARG_0_][_ARG_1_] or 0) < 1 then
        exports.see_gui:showInfobox(client, "e", "Nincs elég nyersanyag az öntés megkezdéséhez!")
      else
        if 0 >= (_UPVALUE1_[_ARG_0_][_ARG_1_] or 0) - math.floor(_UPVALUE1_[_ARG_0_][_ARG_1_] or 0) then
          _UPVALUE1_[_ARG_0_][_ARG_1_] = nil
        else
          _UPVALUE1_[_ARG_0_][_ARG_1_] = (_UPVALUE1_[_ARG_0_][_ARG_1_] or 0) - math.floor(_UPVALUE1_[_ARG_0_][_ARG_1_] or 0)
        end
        _UPVALUE0_[_ARG_0_].meltingOre = _ARG_1_
        _UPVALUE0_[_ARG_0_].meltProgress = 0
        _UPVALUE0_[_ARG_0_].meltingStart = getTickCount()
        if 0 < #playersInMine[_ARG_0_] then
          triggerClientEvent(playersInMine[_ARG_0_], "syncMineOreMelting", client, _ARG_0_, _ARG_1_)
          triggerClientEvent(playersInMine[_ARG_0_], "syncMineFoundryStorage", client, _ARG_0_, _ARG_1_, (_UPVALUE1_[_ARG_0_][_ARG_1_] or 0) - math.floor(_UPVALUE1_[_ARG_0_][_ARG_1_] or 0))
        end
        exports.see_chat:localAction(client, "elkezdett kiönteni egy " .. oreTypes[_ARG_1_].actionName .. ".")
      end
    end
  end
end)
addMineEventHandler("fillMineFoundry", root, function(_ARG_0_, _ARG_1_)
  if _UPVALUE0_[client] and oreTypes[_UPVALUE0_[client]] then
    if 0 < (_UPVALUE1_[_ARG_0_][_UPVALUE0_[client]] or 0) and 0 < math.min(1 - _ARG_1_, _UPVALUE1_[_ARG_0_][_UPVALUE0_[client]] or 0) then
      if 0 >= (_UPVALUE1_[_ARG_0_][_UPVALUE0_[client]] or 0) - math.min(1 - _ARG_1_, _UPVALUE1_[_ARG_0_][_UPVALUE0_[client]] or 0) then
        _UPVALUE1_[_ARG_0_][_UPVALUE0_[client]] = nil
      else
        _UPVALUE1_[_ARG_0_][_UPVALUE0_[client]] = (_UPVALUE1_[_ARG_0_][_UPVALUE0_[client]] or 0) - math.min(1 - _ARG_1_, _UPVALUE1_[_ARG_0_][_UPVALUE0_[client]] or 0)
      end
      _UPVALUE2_[_ARG_0_][_UPVALUE0_[client]] = (_UPVALUE2_[_ARG_0_][_UPVALUE0_[client]] or 0) + math.min(1 - _ARG_1_, _UPVALUE1_[_ARG_0_][_UPVALUE0_[client]] or 0) * (1 + math.random() * 3)
      if 0 < #playersInMine[_ARG_0_] then
        triggerClientEvent(playersInMine[_ARG_0_], "syncMineFoundryStorage", client, _ARG_0_, _UPVALUE0_[client], (_UPVALUE2_[_ARG_0_][_UPVALUE0_[client]] or 0) + math.min(1 - _ARG_1_, _UPVALUE1_[_ARG_0_][_UPVALUE0_[client]] or 0) * (1 + math.random() * 3))
        triggerClientEvent(playersInMine[_ARG_0_], "syncMineOreStorageRemove", client, _ARG_0_, _UPVALUE0_[client], math.min(1 - _ARG_1_, _UPVALUE1_[_ARG_0_][_UPVALUE0_[client]] or 0), true)
      end
      exports.see_chat:localAction(client, "beöntött egy adag nyersanyagot a " .. oreTypes[_UPVALUE0_[client]].ingotNamePrefix .. " " .. oreTypes[_UPVALUE0_[client]].ingotName:gsub("%L", string.lower) .. "kohóba.")
    end
  end
end)
addMineEventHandler("toggleMineFoundry", root, function(_ARG_0_, _ARG_1_)
  if oreTypes[_ARG_1_] then
    if not oreTypes[_ARG_1_].meltingPoint then
      return
    elseif not checkMinePermission(client, permissionFlags.USE_FOUNDRY) then
      exports.see_gui:showInfobox(client, "e", "Ehhez nincs jogosultságod!")
    elseif _UPVALUE0_[_ARG_0_].meltingOre then
      if _UPVALUE0_[_ARG_0_].meltProgress >= 0.9 then
        exports.see_gui:showInfobox(client, "e", "Előbb vedd ki a kihűlt fémet az öntőformából!")
      else
        exports.see_gui:showInfobox(client, "e", "Előbb várd meg a fém kiöntését!")
      end
    else
      if _UPVALUE0_[_ARG_0_].furnaceRunning then
        _UPVALUE0_[_ARG_0_].furnaceRunning = nil
        _UPVALUE0_[_ARG_0_].furnaceTemperature[_UPVALUE0_[_ARG_0_].furnaceRunning] = math.min(1000, _UPVALUE0_[_ARG_0_].furnaceTemperature[_UPVALUE0_[_ARG_0_].furnaceRunning] + (_UPVALUE0_[_ARG_0_].furnaceLastRefresh[_UPVALUE0_[_ARG_0_].furnaceRunning] and getTickCount() - _UPVALUE0_[_ARG_0_].furnaceLastRefresh[_UPVALUE0_[_ARG_0_].furnaceRunning] or 0) / oreTypes[_ARG_1_].furnaceSpeed)
        _UPVALUE0_[_ARG_0_].furnaceLastRefresh[_UPVALUE0_[_ARG_0_].furnaceRunning] = getTickCount()
        if 0 < #playersInMine[_ARG_0_] then
          triggerClientEvent(playersInMine[_ARG_0_], "syncMineFurnaceRunning", client, _ARG_0_, false, false)
        end
        if _UPVALUE0_[_ARG_0_].furnaceRunning == _ARG_1_ then
          exports.see_chat:localAction(client, "kikapcsolja " .. oreTypes[_ARG_1_].ingotNamePrefix .. " " .. oreTypes[_ARG_1_].ingotName:gsub("%L", string.lower) .. "kohót.")
        end
      end
      if _ARG_1_ ~= _UPVALUE0_[_ARG_0_].furnaceRunning then
        _UPVALUE0_[_ARG_0_].furnaceRunning = _ARG_1_
        _UPVALUE0_[_ARG_0_].furnaceTemperature[_ARG_1_] = math.max(0, _UPVALUE0_[_ARG_0_].furnaceTemperature[_ARG_1_] - (_UPVALUE0_[_ARG_0_].furnaceLastRefresh[_ARG_1_] and getTickCount() - _UPVALUE0_[_ARG_0_].furnaceLastRefresh[_ARG_1_] or 0) / (oreTypes[_ARG_1_].furnaceSpeed * 10))
        _UPVALUE0_[_ARG_0_].furnaceLastRefresh[_ARG_1_] = getTickCount()
        if 0 < #playersInMine[_ARG_0_] then
          triggerClientEvent(playersInMine[_ARG_0_], "syncMineFurnaceRunning", client, _ARG_0_, _ARG_1_, _UPVALUE0_[_ARG_0_].furnaceTemperature[_ARG_1_])
        end
        exports.see_chat:localAction(client, "bekapcsolja " .. oreTypes[_ARG_1_].ingotNamePrefix .. " " .. oreTypes[_ARG_1_].ingotName:gsub("%L", string.lower) .. "kohót.")
      end
      setPedAnimation(client, "CASINO", "SLOT_PLYR", -1, false, true, false, false)
    end
  end
end)
addMineEventHandler("putDownMineOreBox", root, function(_ARG_0_)
  if _UPVALUE0_[client] then
    _UPVALUE0_[client] = nil
    setPedAnimation(client, "CARRY", "PUTDWN", -1, false, false, false, false)
    setTimer(function(_ARG_0_)
      if isElement(_ARG_0_) then
        exports.see_controls:toggleControl(_ARG_0_, {
          "fire",
          "crouch",
          "aim_weapon",
          "jump",
          "jog"
        }, true, "mineOreCarry")
        if #playersInMine[_UPVALUE0_] > 0 then
          triggerClientEvent(playersInMine[_UPVALUE0_], "syncMineOreBoxCarry", _ARG_0_, _UPVALUE0_, false)
        end
        exports.see_chat:localAction(_ARG_0_, "berakott egy ládát a válogatógépbe.")
      end
    end, 375, 1, client)
    _UPVALUE1_[_ARG_0_][_UPVALUE0_[client]] = nil
  end
end)
addMineEventHandler("pickUpMineOreBox", root, function(_ARG_0_, _ARG_1_)
  if not checkMinePermission(client, permissionFlags.USE_FOUNDRY) then
    exports.see_gui:showInfobox(client, "e", "Ehhez nincs jogosultságod!")
  elseif _UPVALUE0_[client] or _UPVALUE1_[client] then
    return
  elseif isElement(_UPVALUE2_[_ARG_0_][_ARG_1_]) then
    return
  else
    _UPVALUE1_[client] = _ARG_1_
    setPedAnimation(client, "CARRY", "LIFTUP", -1, false, false, false, false)
    setTimer(function(_ARG_0_)
      if isElement(_ARG_0_) then
        exports.see_controls:toggleControl(_ARG_0_, {
          "fire",
          "crouch",
          "aim_weapon",
          "jump",
          "jog"
        }, false, "mineOreCarry")
        if #playersInMine[_UPVALUE0_] > 0 then
          triggerClientEvent(playersInMine[_UPVALUE0_], "syncMineOreBoxCarry", _ARG_0_, _UPVALUE0_, _UPVALUE1_)
        end
        exports.see_chat:localAction(_ARG_0_, "kivett egy ládát a válogatógépből.")
      end
    end, 625, 1, client)
    _UPVALUE2_[_ARG_0_][_ARG_1_] = client
  end
end)
addEvent("syncBagWield", true)
addEventHandler("syncBagWield", root, function(_ARG_0_)
  _ARG_0_ = _ARG_0_ and true or nil
  if client then
    _UPVALUE0_[client] = _ARG_0_
    if _ARG_0_ then
      exports.see_chat:localAction(client, "elővett egy zsákot.")
    else
      exports.see_chat:localAction(client, "elrakott egy zsákot.")
    end
    if #loadedPlayers > 0 then
      triggerClientEvent(loadedPlayers, "syncBagWield", client, _ARG_0_)
    end
  end
end)
addMineEventHandler("sackMineOre", root, function(_ARG_0_, _ARG_1_)
  if not checkMinePermission(client, permissionFlags.COLLECT_PRODUCT) then
    exports.see_gui:showInfobox(client, "e", "Ehhez nincs jogosultságod!")
  elseif _UPVALUE0_[_ARG_0_] then
    exports.see_gui:showInfobox(client, "e", "Előbb kapcsold ki a válogatógépet!")
  elseif oreTypes[_ARG_1_] and not oreTypes[_ARG_1_].instantItem and not oreTypes[_ARG_1_].meltingPoint then
    if (_UPVALUE1_[_ARG_0_][_ARG_1_] or 0) < sackOreProportion then
      exports.see_gui:showInfobox(client, "e", "Nincs elég mennyiség a zsákoláshoz!")
    elseif not exports.see_items:hasSpaceForItem(client, oreTypes[_ARG_1_].itemId, 1) then
      exports.see_gui:showInfobox(client, "e", "Nincs elég hely az inventorydban!")
    elseif not exports.see_items:takeItem(client, "itemId", 593, 1) then
      exports.see_gui:showInfobox(client, "e", "Nincs nálad zsák!")
    elseif not exports.see_items:giveItem(client, oreTypes[_ARG_1_].itemId, 1) then
      exports.see_gui:showInfobox(client, "e", "Nincs szabad hely az inventorydban!")
    else
      _UPVALUE1_[_ARG_0_][_ARG_1_] = math.max(0, (_UPVALUE1_[_ARG_0_][_ARG_1_] or 0) - sackOreProportion)
      if _UPVALUE1_[_ARG_0_][_ARG_1_] <= 0 then
        _UPVALUE1_[_ARG_0_][_ARG_1_] = nil
      end
      if 0 < #playersInMine[_ARG_0_] then
        triggerClientEvent(playersInMine[_ARG_0_], "syncMineOreItemOutput", client, _ARG_0_, _ARG_1_)
        triggerClientEvent(playersInMine[_ARG_0_], "syncMineOreStorageRemove", client, _ARG_0_, _ARG_1_, sackOreProportion, false)
      end
      exports.see_chat:localAction(client, "kivett egy zsák " .. oreTypes[_ARG_1_].actionName .. " a ládából.")
    end
  end
end)
addMineEventHandler("emptyMineCart", root, function(_ARG_0_, _ARG_1_)
  if not checkMinePermission(client, permissionFlags.USE_SORTER_MACHINE) then
    exports.see_gui:showInfobox(client, "e", "Ehhez nincs jogosultságod!")
  elseif not _UPVALUE0_[_ARG_0_] then
    exports.see_gui:showInfobox(client, "e", "Előbb kapcsold be a válogatógépet!")
  elseif next(_UPVALUE1_[_ARG_0_]) then
    return
  elseif _UPVALUE2_[_ARG_0_][_ARG_1_] then
    for _FORV_6_, _FORV_7_ in pairs(_UPVALUE3_[_ARG_0_]) do
      if _FORV_7_[4] == "cart" and _FORV_7_[5] == _ARG_1_ then
        table.insert({}, {
          _FORV_6_,
          (4 + math.random() * 5) / 100,
          _FORV_7_[6]
        })
        if not _UPVALUE4_[_ARG_0_][_FORV_7_[3]] then
          _UPVALUE4_[_ARG_0_][_FORV_7_[3]] = (4 + math.random() * 5) / 100
        else
          _UPVALUE4_[_ARG_0_][_FORV_7_[3]] = _UPVALUE4_[_ARG_0_][_FORV_7_[3]] + (4 + math.random() * 5) / 100
        end
        _UPVALUE3_[_ARG_0_][_FORV_6_] = nil
        for _FORV_14_ = #_UPVALUE5_[_ARG_0_], 1, -1 do
          if _UPVALUE5_[_ARG_0_][_FORV_14_][1] == _FORV_6_ then
            table.remove(_UPVALUE5_[_ARG_0_], _FORV_14_)
            break
          end
        end
      end
    end
    if #_UPVALUE5_[_ARG_0_] == 0 then
      _UPVALUE5_[_ARG_0_] = nil
      if not next(_UPVALUE5_) then
        if isTimer(_UPVALUE6_) then
          killTimer(_UPVALUE6_)
        end
        _UPVALUE6_ = nil
      end
    end
    _UPVALUE2_[_ARG_0_][_ARG_1_] = nil
    if #{} > 0 then
      table.sort({}, function(_ARG_0_, _ARG_1_)
        return _ARG_0_[3] > _ARG_1_[3]
      end)
      _UPVALUE1_[_ARG_0_][_ARG_1_] = client
      if 0 < #playersInMine[_ARG_0_] then
        triggerClientEvent(playersInMine[_ARG_0_], "syncOreEmptying", resourceRoot, _ARG_0_, _ARG_1_, client)
      end
      setTimer(function()
        setTimer(function()
          if #playersInMine[_UPVALUE1_] > 0 then
            triggerClientEvent(playersInMine[_UPVALUE1_], "syncFixOreState", resourceRoot, _UPVALUE1_, unpack(table.remove(_UPVALUE0_, 1)))
          end
          if #_UPVALUE0_ == 0 then
            setTimer(function()
              _UPVALUE0_[_UPVALUE1_][_UPVALUE2_] = nil
              if #playersInMine[_UPVALUE1_] > 0 then
                triggerClientEvent(playersInMine[_UPVALUE1_], "syncOreEmptying", resourceRoot, _UPVALUE1_, _UPVALUE2_, nil)
              end
            end, 500, 1)
          end
        end, 250, #_UPVALUE0_)
      end, 1000, 1)
      exports.see_chat:localAction(client, "kiöntött egy vagon követ.")
    end
  end
end)
addMineEventHandler("toggleMineSortingMachine", root, function(_ARG_0_)
  if not checkMinePermission(client, permissionFlags.USE_SORTER_MACHINE) then
    exports.see_gui:showInfobox(client, "e", "Ehhez nincs jogosultságod!")
  elseif next(_UPVALUE0_[_ARG_0_]) then
    exports.see_gui:showInfobox(client, "e", "A válogatógép jelenleg nem kapcsolható ki!")
  elseif next(_UPVALUE1_[_ARG_0_]) then
    exports.see_gui:showInfobox(client, "e", "A válogatógép nem kapcsolható be, amíg nincs minden láda a helyén!")
  else
    _UPVALUE2_[_ARG_0_] = not _UPVALUE2_[_ARG_0_]
    if _UPVALUE2_[_ARG_0_] then
      exports.see_chat:localAction(client, "bekapcsolja a válogatógépet.")
    else
      exports.see_chat:localAction(client, "kikapcsolja a válogatógépet.")
    end
    setPedHeadingTo(client, minePosX - 14.7006, minePosY + 6.7456)
    setPedAnimation(client, "CASINO", "SLOT_PLYR", -1, false, true, false, false)
    if #playersInMine[_ARG_0_] > 0 then
      triggerClientEvent(playersInMine[_ARG_0_], "syncMineSortingMachineState", client, _ARG_0_, _UPVALUE2_[_ARG_0_])
    end
  end
end)
addMineEventHandler("giveInstantOre", root, function(_ARG_0_)
  if _UPVALUE0_[client] and _UPVALUE1_[_ARG_0_][_UPVALUE0_[client]] and oreTypes[_UPVALUE1_[_ARG_0_][_UPVALUE0_[client]][3]] and oreTypes[_UPVALUE1_[_ARG_0_][_UPVALUE0_[client]][3]].instantItem then
    if exports.see_items:giveItem(client, oreTypes[_UPVALUE1_[_ARG_0_][_UPVALUE0_[client]][3]].itemId, 1) then
      exports.see_controls:toggleControl(client, {
        "fire",
        "crouch",
        "aim_weapon",
        "jump",
        "jog"
      }, true, "mineOreCarry")
      for _FORV_9_ = #_UPVALUE2_[_ARG_0_], 1, -1 do
        if _UPVALUE2_[_ARG_0_][_FORV_9_][1] == _UPVALUE0_[client] then
          table.remove(_UPVALUE2_[_ARG_0_], _FORV_9_)
          break
        end
      end
      _FOR_.see_gui:showInfobox(client, "i", "A tárgy átkerült az inventorydba.")
      if #_UPVALUE2_[_ARG_0_] == 0 then
        _UPVALUE2_[_ARG_0_] = nil
        if not next(_UPVALUE2_) then
          if isTimer(_UPVALUE3_) then
            killTimer(_UPVALUE3_)
          end
          _UPVALUE3_ = nil
        end
      end
      _UPVALUE1_[_ARG_0_][_UPVALUE0_[client]] = nil
      if 0 < #playersInMine[_ARG_0_] then
        triggerClientEvent(playersInMine[_ARG_0_], "syncFixOreState", client, _ARG_0_, _UPVALUE0_[client], "delete")
      end
      _UPVALUE0_[client] = nil
    else
      exports.see_gui:showInfobox(client, "e", "Nincs elég hely az inventorydban!")
    end
  end
end)
addMineEventHandler("putOreInMineCart", root, function(_ARG_0_, _ARG_1_)
  if _UPVALUE0_[client] and _UPVALUE1_[_ARG_0_][_UPVALUE0_[client]] and _UPVALUE2_[_ARG_0_] then
    if _ARG_1_ >= 1 and nil then
      if not _UPVALUE3_[_ARG_0_] then
        _UPVALUE3_[_ARG_0_] = {}
      end
      if not _UPVALUE3_[_ARG_0_][_ARG_1_] then
        _UPVALUE3_[_ARG_0_][_ARG_1_] = 1
      elseif _UPVALUE3_[_ARG_0_][_ARG_1_] < #oreCartOffsets then
        _UPVALUE3_[_ARG_0_][_ARG_1_] = _UPVALUE3_[_ARG_0_][_ARG_1_] + 1
      else
        return exports.see_gui:showInfobox(client, "e", "Ebbe a kocsiba nem fér több!")
      end
      _UPVALUE1_[_ARG_0_][_UPVALUE0_[client]][4] = "cart"
      _UPVALUE1_[_ARG_0_][_UPVALUE0_[client]][5] = _ARG_1_
      _UPVALUE1_[_ARG_0_][_UPVALUE0_[client]][6] = _UPVALUE3_[_ARG_0_][_ARG_1_]
      _UPVALUE0_[client] = nil
      setPedAnimation(client, "CARRY", "PUTDWN", -1, false, false, false, false)
      setTimer(function(_ARG_0_)
        if isElement(_ARG_0_) then
          exports.see_controls:toggleControl(_ARG_0_, {
            "fire",
            "crouch",
            "aim_weapon",
            "jump",
            "jog"
          }, true, "mineOreCarry")
        end
      end, 375, 1, client)
      if 0 < #playersInMine[_ARG_0_] then
        triggerClientEvent(playersInMine[_ARG_0_], "syncFixOreState", client, _ARG_0_, _UPVALUE0_[client], "cart", nil, nil, _UPVALUE1_[_ARG_0_][_UPVALUE0_[client]][5], _UPVALUE1_[_ARG_0_][_UPVALUE0_[client]][6])
      end
      exports.see_chat:localAction(client, "berakott egy követ a kocsiba.")
    end
  end
end)
addMineEventHandler("putDownMineFixOre", root, function(_ARG_0_)
  if _UPVALUE0_[client] then
    if _UPVALUE1_[_ARG_0_][_UPVALUE0_[client]] then
      _UPVALUE1_[_ARG_0_][_UPVALUE0_[client]][1] = getElementPosition(client) - math.sin((math.rad(getElementRotation(client)))) * 0.45
      _UPVALUE1_[_ARG_0_][_UPVALUE0_[client]][2] = getElementPosition(client) + math.cos((math.rad(getElementRotation(client)))) * 0.45
      _UPVALUE1_[_ARG_0_][_UPVALUE0_[client]][4] = nil
      _UPVALUE1_[_ARG_0_][_UPVALUE0_[client]][5] = nil
      _UPVALUE1_[_ARG_0_][_UPVALUE0_[client]][6] = nil
      _UPVALUE0_[client] = nil
      setPedAnimation(client, "CARRY", "PUTDWN", -1, false, false, false, false)
      setTimer(function(_ARG_0_)
        if isElement(_ARG_0_) then
          exports.see_controls:toggleControl(_ARG_0_, {
            "fire",
            "crouch",
            "aim_weapon",
            "jump",
            "jog"
          }, true, "mineOreCarry")
          if #playersInMine[_UPVALUE0_] > 0 then
            triggerClientEvent(playersInMine[_UPVALUE0_], "syncFixOreState", _ARG_0_, _UPVALUE0_, _UPVALUE1_, "ground", _UPVALUE2_[1], _UPVALUE2_[2])
          end
          exports.see_chat:localAction(_ARG_0_, "lerakott egy követ a földre.")
        end
      end, 375, 1, client)
    end
  end
end)
addMineEventHandler("pickUpMineFixOre", root, function(_ARG_0_, _ARG_1_)
  if checkMinePermission(client, permissionFlags.PICK_ORES) then
    if _UPVALUE0_[_ARG_0_][_ARG_1_] and not _UPVALUE1_[client] and not _UPVALUE2_[client] then
      if not _UPVALUE0_[_ARG_0_][_ARG_1_][4] or _UPVALUE0_[_ARG_0_][_ARG_1_][4] == "cart" then
        _UPVALUE1_[client] = _ARG_1_
        if _UPVALUE0_[_ARG_0_][_ARG_1_][4] == "cart" and _UPVALUE3_[_ARG_0_] and _UPVALUE3_[_ARG_0_][_UPVALUE0_[_ARG_0_][_ARG_1_][5]] then
          _UPVALUE3_[_ARG_0_][_UPVALUE0_[_ARG_0_][_ARG_1_][5]] = _UPVALUE3_[_ARG_0_][_UPVALUE0_[_ARG_0_][_ARG_1_][5]] - 1
          if _UPVALUE3_[_ARG_0_][_UPVALUE0_[_ARG_0_][_ARG_1_][5]] <= 0 then
            _UPVALUE3_[_ARG_0_][_UPVALUE0_[_ARG_0_][_ARG_1_][5]] = nil
          end
        end
        _UPVALUE0_[_ARG_0_][_ARG_1_][4] = "player"
        _UPVALUE0_[_ARG_0_][_ARG_1_][5] = client
        _UPVALUE0_[_ARG_0_][_ARG_1_][6] = nil
        setPedAnimation(client, "CARRY", "LIFTUP", -1, false, false, false, false)
        setTimer(function(_ARG_0_)
          if isElement(_ARG_0_) then
            setPedAnimation(_ARG_0_, "CARRY", "CRRY_PRTIAL", 0, true, true, false, true)
            if 0 < #playersInMine[_UPVALUE0_] then
              triggerClientEvent(playersInMine[_UPVALUE0_], "syncFixOreState", _ARG_0_, _UPVALUE0_, _UPVALUE1_, "player")
            end
            if _UPVALUE2_ == "cart" then
              exports.see_chat:localAction(_ARG_0_, "kivett egy követ a kocsiból.")
            else
              exports.see_chat:localAction(_ARG_0_, "felvett egy követ a földről.")
            end
            exports.see_controls:toggleControl(_ARG_0_, {
              "fire",
              "crouch",
              "aim_weapon",
              "jump",
              "jog"
            }, false, "mineOreCarry")
          end
        end, 625, 1, client)
      end
    end
  else
    exports.see_gui:showInfobox(client, "e", "Ehhez nincs jogosultságod!")
  end
end)
addMineEventHandler("exitMineLoco", root, function(_ARG_0_)
  if _UPVALUE0_[_ARG_0_][client] then
    _UPVALUE0_[_ARG_0_][client] = nil
    if #playersInMine[_ARG_0_] > 0 then
      triggerClientEvent(playersInMine[_ARG_0_], "syncMineLocoPassenger", resourceRoot, _ARG_0_, _UPVALUE0_[_ARG_0_][client])
    end
    if 0 < getElementHealth(client) then
      exports.see_chat:localAction(client, "leszállt a mozdonyról.")
    end
  end
end)
addMineEventHandler("standMineLocoPassenger", root, function(_ARG_0_, _ARG_1_)
  for _FORV_5_, _FORV_6_ in pairs(_UPVALUE0_[_ARG_0_]) do
    if _ARG_1_ == _FORV_6_ then
      return
    end
  end
  if not _UPVALUE0_[_ARG_0_][client] then
    _UPVALUE0_[_ARG_0_][client] = _ARG_1_
    if #playersInMine[_ARG_0_] > 0 then
      triggerClientEvent(playersInMine[_ARG_0_], "syncMineLocoPassenger", client, _ARG_0_, _ARG_1_)
    end
    exports.see_chat:localAction(client, "felkapaszkodott a mozdonyra.")
  end
end)
addMineEventHandler("mineRailHorn", root, function(_ARG_0_)
  for _FORV_5_ = 1, #playersInMine[_ARG_0_] do
    if playersInMine[_ARG_0_][_FORV_5_] ~= client then
      table.insert({}, playersInMine[_ARG_0_][_FORV_5_])
    end
  end
  if _FOR_ > 0 then
    triggerClientEvent({}, "mineRailHorn", client, _ARG_0_)
  end
end)
addMineEventHandler("mineRailSyncing", root, function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_, _ARG_5_, _ARG_6_, _ARG_7_)
  if _UPVALUE0_[_ARG_0_] and checkMinePermission(client, permissionFlags.USE_RAILCAR) then
    if not _ARG_7_ then
      _UPVALUE0_[_ARG_0_].currentSyncer = client
    else
      _UPVALUE0_[_ARG_0_].currentSyncer = false
    end
    _UPVALUE0_[_ARG_0_].desiredSpeed = _ARG_1_ or _UPVALUE0_[_ARG_0_].desiredSpeed or 0
    _UPVALUE0_[_ARG_0_].currentSpeed = _ARG_2_ or _UPVALUE0_[_ARG_0_].currentSpeed or 0
    _UPVALUE0_[_ARG_0_].trackPosition = _ARG_3_ or _UPVALUE0_[_ARG_0_].trackPosition
    _UPVALUE0_[_ARG_0_].trackDirection = _ARG_4_ or _UPVALUE0_[_ARG_0_].trackDirection
    _UPVALUE0_[_ARG_0_].trackId = _ARG_5_ or _UPVALUE0_[_ARG_0_].trackId
    _UPVALUE0_[_ARG_0_].routeId = _ARG_6_ or _UPVALUE0_[_ARG_0_].routeId
    if _UPVALUE1_[_ARG_0_].dieselLoco then
      if _UPVALUE0_[_ARG_0_].lastFuelUpdate then
        _UPVALUE0_[_ARG_0_].totalDistance, _UPVALUE0_[_ARG_0_].fuelLevel = _UPVALUE0_[_ARG_0_].totalDistance + math.abs(_UPVALUE0_[_ARG_0_].currentSpeed) * (getTickCount() - _UPVALUE0_[_ARG_0_].lastFuelUpdate) / 1000, math.max(0, _UPVALUE0_[_ARG_0_].fuelLevel - math.random(2, 7) * ((_UPVALUE0_[_ARG_0_].totalDistance + math.abs(_UPVALUE0_[_ARG_0_].currentSpeed) * (getTickCount() - _UPVALUE0_[_ARG_0_].lastFuelUpdate) / 1000 - _UPVALUE0_[_ARG_0_].totalDistance) / 1000) * (1 + _UPVALUE1_[_ARG_0_].subCartNum))
        _UPVALUE0_[_ARG_0_].lastFuelUpdate = getTickCount()
      else
        _UPVALUE0_[_ARG_0_].totalDistance = 0
        _UPVALUE0_[_ARG_0_].lastFuelUpdate = getTickCount()
      end
    end
    if 0 < #playersInMine[_ARG_0_] then
      triggerClientEvent(playersInMine[_ARG_0_], "mineRailSyncing", client, _ARG_0_, _UPVALUE0_[_ARG_0_])
    end
    if _UPVALUE1_[_ARG_0_].dieselLoco then
      if _UPVALUE0_[_ARG_0_].currentSyncer == client then
        if _UPVALUE0_[_ARG_0_].currentSyncer ~= _UPVALUE0_[_ARG_0_].currentSyncer then
          exports.see_chat:localAction(client, "beszállt a mozdonyba.")
        end
      elseif _UPVALUE0_[_ARG_0_].currentSyncer == client and 0 < getElementHealth(client) then
        exports.see_chat:localAction(client, "kiszállt a mozdonyból.")
      end
    end
  end
end)
addMineEventHandler("setMineRailSwitch", root, function(_ARG_0_, _ARG_1_, _ARG_2_)
  if _UPVALUE0_[_ARG_0_][_ARG_1_] then
    if checkMinePermission(client, permissionFlags.USE_SWITCHES) then
      if _UPVALUE1_[_ARG_0_][_ARG_1_] ~= _ARG_2_ then
        _UPVALUE1_[_ARG_0_][_ARG_1_] = _ARG_2_
        if #playersInMine[_ARG_0_] > 0 then
          triggerClientEvent(playersInMine[_ARG_0_], "setMineRailSwitch", client, _ARG_0_, _ARG_1_, _ARG_2_)
        end
        exports.see_chat:localAction(client, "átállította a váltót.")
      end
    else
      exports.see_gui:showInfobox(client, "e", "Ehhez nincs jogosultságod!")
    end
  end
end)
addMineEventHandler("createNewMineRailTrack", root, function(_ARG_0_, _ARG_1_, _ARG_2_)
  if _UPVALUE0_[_ARG_0_] then
    if checkMinePermission(client, permissionFlags.CONSTRUCT_RAIL) then
      if canConstructRail(_UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_) and checkValidSpotEx(_ARG_0_, _ARG_1_, _ARG_2_) then
        if #doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_]) > 0 then
          if findRailConstructionCost((doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_]))) * railIronCost > _UPVALUE4_[_ARG_0_].railIrons or findRailConstructionCost((doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_]))) * railWoodCost > _UPVALUE4_[_ARG_0_].railWoods then
            return exports.see_gui:showInfobox(client, "e", "Nincs elég anyag az építéshez!")
          end
          _UPVALUE4_[_ARG_0_].railIrons = math.max(0, _UPVALUE4_[_ARG_0_].railIrons - findRailConstructionCost((doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_]))) * railIronCost)
          _UPVALUE4_[_ARG_0_].railWoods = math.max(0, _UPVALUE4_[_ARG_0_].railWoods - findRailConstructionCost((doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_]))) * railWoodCost)
          while #doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_]) >= 1 do
            if doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][1] == "extend" then
              if _UPVALUE0_[_ARG_0_][doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2]] then
                _UPVALUE0_[_ARG_0_][doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2]][3] = _ARG_1_
                _UPVALUE0_[_ARG_0_][doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2]][4] = _ARG_2_
                _UPVALUE0_[_ARG_0_][doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2]][5] = not doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][3]
                if not _UPVALUE1_[_ARG_0_][_ARG_1_] then
                  _UPVALUE1_[_ARG_0_][_ARG_1_] = {}
                end
                _UPVALUE1_[_ARG_0_][_ARG_1_][_ARG_2_] = doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2]
                if not ({})[_ARG_1_] then
                  ({})[_ARG_1_] = {}
                end
                ;({})[_ARG_1_][_ARG_2_] = true
              end
            elseif doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][1] == "single" then
              doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][6], _UPVALUE0_[_ARG_0_][findFreeRailTrack(_ARG_0_)] = findFreeRailTrack(_ARG_0_), {
                doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2],
                doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][3],
                doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][4] % 360,
                doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][5]
              }
              if not _UPVALUE1_[_ARG_0_][doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2]] then
                _UPVALUE1_[_ARG_0_][doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2]] = {}
              end
              _UPVALUE1_[_ARG_0_][doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2]][doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][3]] = findFreeRailTrack(_ARG_0_)
              if not ({})[doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2]] then
                ({})[doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2]] = {}
              end
              ;({})[doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2]][doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][3]] = true
            elseif doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][1] == "linked" then
              doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][7], _UPVALUE0_[_ARG_0_][findFreeRailTrack(_ARG_0_)] = findFreeRailTrack(_ARG_0_), {
                doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2],
                doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][3],
                doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][4],
                doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][5],
                doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][6]
              }
              for _FORV_17_ = ({
                doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2],
                doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][3],
                doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][4],
                doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][5],
                doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][6]
              })[1], ({
                doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2],
                doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][3],
                doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][4],
                doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][5],
                doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][6]
              })[3], ({
                doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2],
                doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][3],
                doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][4],
                doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][5],
                doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][6]
              })[3] < ({
                doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2],
                doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][3],
                doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][4],
                doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][5],
                doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][6]
              })[1] and -1 or 1 do
                if not _UPVALUE1_[_ARG_0_][_FORV_17_] then
                  _UPVALUE1_[_ARG_0_][_FORV_17_] = {}
                end
                if not ({})[_FORV_17_] then
                  ({})[_FORV_17_] = {}
                end
                for _FORV_21_ = ({
                  doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2],
                  doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][3],
                  doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][4],
                  doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][5],
                  doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][6]
                })[2], ({
                  doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2],
                  doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][3],
                  doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][4],
                  doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][5],
                  doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][6]
                })[4], ({
                  doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2],
                  doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][3],
                  doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][4],
                  doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][5],
                  doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][6]
                })[4] < ({
                  doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2],
                  doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][3],
                  doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][4],
                  doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][5],
                  doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][6]
                })[2] and -1 or 1 do
                  if not ({})[_FORV_17_][_FORV_21_] then
                    ({})[_FORV_17_][_FORV_21_] = true
                  end
                  _UPVALUE1_[_ARG_0_][_FORV_17_][_FORV_21_] = findFreeRailTrack(_ARG_0_)
                end
              end
            elseif doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][1] == "split" then
              if _UPVALUE0_[_ARG_0_][doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2]] then
                if #_UPVALUE0_[_ARG_0_][doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2]] > 4 then
                  if 1 < getDistanceBetweenPoints2D(doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][3], doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][4], _UPVALUE0_[_ARG_0_][doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2]][3], _UPVALUE0_[_ARG_0_][doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2]][4]) then
                    table.insert(doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_]), 1 + 1, {
                      "linked",
                      doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][3] + pcos((findRailAngle(_ARG_0_, doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2]))),
                      doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][4] + psin((findRailAngle(_ARG_0_, doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2]))),
                      _UPVALUE0_[_ARG_0_][doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2]][3],
                      _UPVALUE0_[_ARG_0_][doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2]][4],
                      _UPVALUE0_[_ARG_0_][doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2]][5]
                    })
                    if _UPVALUE2_[_ARG_0_][_UPVALUE0_[_ARG_0_][doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2]][3] + pcos((findRailAngle(_ARG_0_, doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2])))] and _UPVALUE2_[_ARG_0_][_UPVALUE0_[_ARG_0_][doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2]][3] + pcos((findRailAngle(_ARG_0_, doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2])))][_UPVALUE0_[_ARG_0_][doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2]][4] + psin((findRailAngle(_ARG_0_, doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2])))] then
                      table.insert(doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_]), {
                        "extend-switch",
                        _UPVALUE2_[_ARG_0_][_UPVALUE0_[_ARG_0_][doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2]][3] + pcos((findRailAngle(_ARG_0_, doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2])))][_UPVALUE0_[_ARG_0_][doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2]][4] + psin((findRailAngle(_ARG_0_, doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2])))]
                      })
                    end
                  elseif 0 < getDistanceBetweenPoints2D(doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][3], doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][4], _UPVALUE0_[_ARG_0_][doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2]][3], _UPVALUE0_[_ARG_0_][doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2]][4]) then
                    table.insert(doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_]), 1 + 1, {
                      "single",
                      doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][3] + pcos((findRailAngle(_ARG_0_, doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2]))),
                      doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][4] + psin((findRailAngle(_ARG_0_, doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2]))),
                      math.deg((findRailAngle(_ARG_0_, doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2]))) % 360,
                      _UPVALUE0_[_ARG_0_][doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2]][5]
                    })
                    if _UPVALUE2_[_ARG_0_][doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][3] + pcos((findRailAngle(_ARG_0_, doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2]))) + pcos((findRailAngle(_ARG_0_, doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2])))] and _UPVALUE2_[_ARG_0_][doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][3] + pcos((findRailAngle(_ARG_0_, doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2]))) + pcos((findRailAngle(_ARG_0_, doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2])))][doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][4] + psin((findRailAngle(_ARG_0_, doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2]))) + psin((findRailAngle(_ARG_0_, doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2])))] then
                      table.insert(doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_]), {
                        "extend-switch",
                        _UPVALUE2_[_ARG_0_][doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][3] + pcos((findRailAngle(_ARG_0_, doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2]))) + pcos((findRailAngle(_ARG_0_, doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2])))][doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][4] + psin((findRailAngle(_ARG_0_, doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2]))) + psin((findRailAngle(_ARG_0_, doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2])))]
                      })
                    end
                  end
                  _UPVALUE0_[_ARG_0_][doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2]][3] = doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][3] - pcos((findRailAngle(_ARG_0_, doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2])))
                  _UPVALUE0_[_ARG_0_][doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2]][4] = doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][4] - psin((findRailAngle(_ARG_0_, doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2])))
                  _UPVALUE0_[_ARG_0_][doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2]][5] = false
                  if _UPVALUE0_[_ARG_0_][doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2]][1] == _UPVALUE0_[_ARG_0_][doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2]][3] and _UPVALUE0_[_ARG_0_][doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2]][2] == _UPVALUE0_[_ARG_0_][doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2]][4] then
                    _UPVALUE0_[_ARG_0_][doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2]][3] = math.deg((findRailAngle(_ARG_0_, doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2]))) % 360
                    _UPVALUE0_[_ARG_0_][doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2]][4] = false
                    _UPVALUE0_[_ARG_0_][doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2]][5] = nil
                  end
                end
                if _UPVALUE1_[_ARG_0_][doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][3]] then
                  _UPVALUE1_[_ARG_0_][doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][3]][doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][4]] = nil
                end
                if ({})[doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][3]] then
                  ({})[doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][3]][doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][4]] = nil
                end
              end
            elseif doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][1] == "switch" then
              doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][5], doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][4] = findFreeRailSwitch(_ARG_0_), processSwitch(_ARG_0_, doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2], doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][3], {})
              _UPVALUE5_[_ARG_0_][findFreeRailSwitch(_ARG_0_)] = {
                doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2],
                doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][3],
                unpack((processSwitch(_ARG_0_, doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2], doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][3], {})))
              }
              if 2 < #processSwitch(_ARG_0_, doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2], doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][3], {}) then
                _UPVALUE6_[_ARG_0_][findFreeRailSwitch(_ARG_0_)] = 1
              end
              if not _UPVALUE2_[_ARG_0_][doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2]] then
                _UPVALUE2_[_ARG_0_][doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2]] = {}
              end
              _UPVALUE2_[_ARG_0_][doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2]][doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][3]] = findFreeRailSwitch(_ARG_0_)
              if _UPVALUE1_[_ARG_0_][doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2]] then
                _UPVALUE1_[_ARG_0_][doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2]][doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][3]] = nil
              end
            elseif doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][1] == "extend-switch" then
              if _UPVALUE5_[_ARG_0_][doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2]] then
                for _FORV_18_ = #_UPVALUE5_[_ARG_0_][doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2]], 3, -1 do
                  table.remove(_UPVALUE5_[_ARG_0_][doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2]], _FORV_18_)
                end
                for _FORV_18_ = 1, #processSwitch(_ARG_0_, _UPVALUE5_[_ARG_0_][doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2]][1], _UPVALUE5_[_ARG_0_][doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2]][2], {}) do
                  table.insert(_UPVALUE5_[_ARG_0_][doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2]], processSwitch(_ARG_0_, _UPVALUE5_[_ARG_0_][doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2]][1], _UPVALUE5_[_ARG_0_][doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2]][2], {})[_FORV_18_])
                end
                doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][3] = processSwitch(_ARG_0_, _UPVALUE5_[_ARG_0_][doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2]][1], _UPVALUE5_[_ARG_0_][doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2]][2], {})
              end
            elseif doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][1] == "merge" then
              doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][5], doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][4] = _UPVALUE0_[_ARG_0_][doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][3]][2], _UPVALUE0_[_ARG_0_][doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][3]][1]
              for _FORV_23_ = _UPVALUE0_[_ARG_0_][doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2]][1], _UPVALUE0_[_ARG_0_][doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][3]][1], _UPVALUE0_[_ARG_0_][doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2]][1] > _UPVALUE0_[_ARG_0_][doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][3]][1] and -1 or 1 do
                if not _UPVALUE1_[_ARG_0_][_FORV_23_] then
                  _UPVALUE1_[_ARG_0_][_FORV_23_] = {}
                end
                for _FORV_27_ = _UPVALUE0_[_ARG_0_][doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2]][2], _UPVALUE0_[_ARG_0_][doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][3]][2], _UPVALUE0_[_ARG_0_][doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2]][2] > _UPVALUE0_[_ARG_0_][doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][3]][2] and -1 or 1 do
                  _UPVALUE1_[_ARG_0_][_FORV_23_][_FORV_27_] = doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2]
                end
              end
              for _FORV_23_, _FORV_24_ in pairs(_UPVALUE5_[_ARG_0_]) do
                for _FORV_29_ = 3, #_FORV_24_ do
                  if _FORV_24_[_FORV_29_] == doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][3] then
                    _FORV_24_[_FORV_29_] = doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2]
                    break
                  end
                end
                if true then
                  break
                end
              end
              _UPVALUE0_[_ARG_0_][doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2]][4], _UPVALUE0_[_ARG_0_][doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2]][3] = _UPVALUE0_[_ARG_0_][doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][3]][2], _UPVALUE0_[_ARG_0_][doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][3]][1]
              _UPVALUE0_[_ARG_0_][doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2]][5] = false
              _UPVALUE0_[_ARG_0_][doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][3]] = nil
            elseif doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][1] == "openup" and _UPVALUE0_[_ARG_0_][doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2]] then
              if #_UPVALUE0_[_ARG_0_][doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2]] == 4 then
                _UPVALUE0_[_ARG_0_][doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2]][4] = false
              else
                _UPVALUE0_[_ARG_0_][doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_])[1][2]][5] = false
              end
            end
          end
          if 0 < #playersInMine[_ARG_0_] then
            triggerClientEvent(playersInMine[_ARG_0_], "executeMineRailConstruction", client, _ARG_0_, doConstructRail(_ARG_0_, _UPVALUE1_[_ARG_0_], _UPVALUE2_[_ARG_0_], _ARG_1_, _ARG_2_, _UPVALUE3_[_ARG_0_][_ARG_1_] and _UPVALUE3_[_ARG_0_][_ARG_1_][_ARG_2_]), _ARG_1_, _ARG_2_, _UPVALUE4_[_ARG_0_].railIrons, _UPVALUE4_[_ARG_0_].railWoods)
          end
          exports.see_chat:localAction(client, "épített egy sínt.")
        end
      end
    else
      exports.see_gui:showInfobox(client, "e", "Ehhez nincs jogosultságod!")
    end
  end
end)
function isPlayerInMine(_ARG_0_)
  return playersCurrentMine[_ARG_0_] ~= nil
end
function getPlayerMine(_ARG_0_)
  return playersCurrentMine[_ARG_0_]
end
function setPlayerMine(_ARG_0_, _ARG_1_, _ARG_2_)
  if playersCurrentMine[_ARG_0_] ~= _ARG_1_ then
    if playersCurrentMine[_ARG_0_] and loadedMinesData[playersCurrentMine[_ARG_0_]] then
      resetPlayerFixOre(_ARG_0_)
      resetPlayerOreBox(_ARG_0_)
      resetPlayerJerrycan(_ARG_0_)
      setPlayerLobby(_ARG_0_, getCorridorIdFromLobbyCorridor(getLobbyFromMineId(playersCurrentMine[_ARG_0_])), _ARG_2_)
      setElementPosition(_ARG_0_, unpack(mineCoords[getLobbyFromMineId(playersCurrentMine[_ARG_0_])]) - unpack(mineCoords[getLobbyFromMineId(playersCurrentMine[_ARG_0_])]) * 2, unpack(mineCoords[getLobbyFromMineId(playersCurrentMine[_ARG_0_])]) - unpack(mineCoords[getLobbyFromMineId(playersCurrentMine[_ARG_0_])]) * 2, unpack(mineCoords[getLobbyFromMineId(playersCurrentMine[_ARG_0_])]) + 1)
      setElementRotation(_ARG_0_, 0, 0, unpack(mineCoords[getLobbyFromMineId(playersCurrentMine[_ARG_0_])]) + 270, "default", true)
      if not _ARG_2_ then
        triggerClientEvent(_ARG_0_, "exitMine", _ARG_0_, playersCurrentMine[_ARG_0_])
        if eventName == "tryToExitMine" and 0 < #playersInLobby[getCorridorIdFromLobbyCorridor(getLobbyFromMineId(playersCurrentMine[_ARG_0_]))] then
          triggerClientEvent(playersInLobby[getCorridorIdFromLobbyCorridor(getLobbyFromMineId(playersCurrentMine[_ARG_0_]))], "gotMineDoorSound", _ARG_0_, playersCurrentMine[_ARG_0_], math.random(1, 4))
        end
      end
      for _FORV_20_ = #loadedMinesData[playersCurrentMine[_ARG_0_]].workersInside, 1, -1 do
        if loadedMinesData[playersCurrentMine[_ARG_0_]].workersInside[_FORV_20_] == getElementData(_ARG_0_, "char.ID") then
          table.remove(loadedMinesData[playersCurrentMine[_ARG_0_]].workersInside, _FORV_20_)
          if 0 < #playersInLobby[getCorridorIdFromLobbyCorridor(getLobbyFromMineId(playersCurrentMine[_ARG_0_]))] then
            triggerClientEvent(playersInLobby[getCorridorIdFromLobbyCorridor(getLobbyFromMineId(playersCurrentMine[_ARG_0_]))], "gotMineRentData", _ARG_0_, playersCurrentMine[_ARG_0_], "workersInside", loadedMinesData[playersCurrentMine[_ARG_0_]].workersInside)
          end
          break
        end
      end
      _FOR_[_ARG_0_] = nil
      for _FORV_20_ = #playersInMine[playersCurrentMine[_ARG_0_]], 1, -1 do
        if playersInMine[playersCurrentMine[_ARG_0_]][_FORV_20_] == _ARG_0_ then
          table.remove(playersInMine[playersCurrentMine[_ARG_0_]], _FORV_20_)
          break
        end
      end
      if #_FOR_[playersCurrentMine[_ARG_0_]] > 0 then
        triggerClientEvent(playersInMine[playersCurrentMine[_ARG_0_]], "otherPlayerExitedMine", _ARG_0_, playersCurrentMine[_ARG_0_], (getElementData(_ARG_0_, "char.ID")))
      else
        serializeMine(playersCurrentMine[_ARG_0_])
      end
    end
    if _ARG_1_ and loadedMinesData[_ARG_1_] and not playersCurrentMine[_ARG_0_] then
      playersCurrentMine[_ARG_0_] = _ARG_1_
      if not playersInMine[_ARG_1_] then
        playersInMine[_ARG_1_] = {_ARG_0_}
      else
        table.insert(playersInMine[_ARG_1_], _ARG_0_)
      end
      for _FORV_11_ = 1, #playersInMine[_ARG_1_] do
        if playersInMine[_ARG_1_][_FORV_11_] ~= _ARG_0_ then
          table.insert({}, playersInMine[_ARG_1_][_FORV_11_])
        end
      end
      if _FOR_ == "tryToEnterMine" and 0 < #playersInMine[_ARG_1_] then
        triggerClientEvent(playersInMine[_ARG_1_], "gotMineDoorSound", _ARG_0_, _ARG_1_, math.random(1, 4))
      end
      if isPedInVehicle(_ARG_0_) then
        removePedFromVehicle(_ARG_0_)
      end
      setPlayerLobby(_ARG_0_, false)
      setElementInterior(_ARG_0_, 0)
      setElementDimension(_ARG_0_, _ARG_1_)
      setElementPosition(_ARG_0_, minePosX - 34.5877, minePosY + 0.045, minePosZ + 1)
      setElementRotation(_ARG_0_, 0, 0, 270, "default", true)
      if loadedMinesData[_ARG_1_].workerNames[getElementData(_ARG_0_, "char.ID")] and loadedMinesData[_ARG_1_].workerNames[getElementData(_ARG_0_, "char.ID")] ~= getElementData(_ARG_0_, "char.Name") then
        loadedMinesData[_ARG_1_].workerNames[getElementData(_ARG_0_, "char.ID")] = getElementData(_ARG_0_, "char.Name")
        if #{} > 0 then
          triggerClientEvent({}, "updateMineWorkerName", _ARG_0_, _ARG_1_, getElementData(_ARG_0_, "char.ID"), getElementData(_ARG_0_, "char.Name"):gsub("_", " "))
        end
      end
      for _FORV_13_, _FORV_14_ in pairs(oreTypes) do
        if _FORV_14_.meltingPoint then
          if _UPVALUE18_[_ARG_1_].furnaceRunning == _FORV_13_ then
            _UPVALUE18_[_ARG_1_].furnaceTemperature[_FORV_13_] = math.min(1000, _UPVALUE18_[_ARG_1_].furnaceTemperature[_FORV_13_] + (_UPVALUE18_[_ARG_1_].furnaceLastRefresh[_FORV_13_] and getTickCount() - _UPVALUE18_[_ARG_1_].furnaceLastRefresh[_FORV_13_] or 0) / _FORV_14_.furnaceSpeed)
          else
            _UPVALUE18_[_ARG_1_].furnaceTemperature[_FORV_13_] = math.max(0, _UPVALUE18_[_ARG_1_].furnaceTemperature[_FORV_13_] - (_UPVALUE18_[_ARG_1_].furnaceLastRefresh[_FORV_13_] and getTickCount() - _UPVALUE18_[_ARG_1_].furnaceLastRefresh[_FORV_13_] or 0) / (_FORV_14_.furnaceSpeed * 10))
          end
          _UPVALUE18_[_ARG_1_].furnaceLastRefresh[_FORV_13_] = getTickCount()
        end
      end
      for _FORV_13_ in pairs(_UPVALUE18_[_ARG_1_].furnaceTemperature) do
        ({
          rentedBy = loadedMinesData[_ARG_1_].rentedBy,
          mineName = loadedMinesData[_ARG_1_].mineName,
          doorLocked = loadedMinesData[_ARG_1_].isLocked,
          workerNames = loadedMinesData[_ARG_1_].workerNames,
          workerPermissions = loadedMinesData[_ARG_1_].workerPermissions,
          shaftList = _UPVALUE0_[_ARG_1_],
          shaftDepths = _UPVALUE1_[_ARG_1_],
          shaftLengths = _UPVALUE2_[_ARG_1_],
          shaftOres = _UPVALUE3_[_ARG_1_],
          junctionList = _UPVALUE4_[_ARG_1_],
          railTracks = _UPVALUE5_[_ARG_1_],
          railSwitches = _UPVALUE6_[_ARG_1_],
          railSwitchStates = _UPVALUE7_[_ARG_1_],
          inventoryData = _UPVALUE8_[_ARG_1_],
          trainData = _UPVALUE9_[_ARG_1_],
          trainPassengers = _UPVALUE10_[_ARG_1_],
          installedLights = _UPVALUE11_[_ARG_1_],
          fixOres = _UPVALUE12_[_ARG_1_],
          sorterRunning = _UPVALUE13_[_ARG_1_],
          cartEmptying = _UPVALUE14_[_ARG_1_],
          bufferContent = _UPVALUE15_[_ARG_1_],
          foundryContent = _UPVALUE16_[_ARG_1_],
          oreBoxCarrying = _UPVALUE17_[_ARG_1_],
          furnaceRunning = false,
          furnaceTemperature = {},
          orderData = mineOrders[_ARG_1_],
          orderPaid = mineOrderPaid[_ARG_1_],
          furnaceRunning = _UPVALUE18_[_ARG_1_].furnaceRunning
        }).furnaceTemperature[_FORV_13_] = _UPVALUE18_[_ARG_1_].furnaceTemperature[_FORV_13_]
      end
      ;({
        rentedBy = loadedMinesData[_ARG_1_].rentedBy,
        mineName = loadedMinesData[_ARG_1_].mineName,
        doorLocked = loadedMinesData[_ARG_1_].isLocked,
        workerNames = loadedMinesData[_ARG_1_].workerNames,
        workerPermissions = loadedMinesData[_ARG_1_].workerPermissions,
        shaftList = _UPVALUE0_[_ARG_1_],
        shaftDepths = _UPVALUE1_[_ARG_1_],
        shaftLengths = _UPVALUE2_[_ARG_1_],
        shaftOres = _UPVALUE3_[_ARG_1_],
        junctionList = _UPVALUE4_[_ARG_1_],
        railTracks = _UPVALUE5_[_ARG_1_],
        railSwitches = _UPVALUE6_[_ARG_1_],
        railSwitchStates = _UPVALUE7_[_ARG_1_],
        inventoryData = _UPVALUE8_[_ARG_1_],
        trainData = _UPVALUE9_[_ARG_1_],
        trainPassengers = _UPVALUE10_[_ARG_1_],
        installedLights = _UPVALUE11_[_ARG_1_],
        fixOres = _UPVALUE12_[_ARG_1_],
        sorterRunning = _UPVALUE13_[_ARG_1_],
        cartEmptying = _UPVALUE14_[_ARG_1_],
        bufferContent = _UPVALUE15_[_ARG_1_],
        foundryContent = _UPVALUE16_[_ARG_1_],
        oreBoxCarrying = _UPVALUE17_[_ARG_1_],
        furnaceRunning = false,
        furnaceTemperature = {},
        orderData = mineOrders[_ARG_1_],
        orderPaid = mineOrderPaid[_ARG_1_],
        furnaceRunning = _UPVALUE18_[_ARG_1_].furnaceRunning
      }).meltingOre = _UPVALUE18_[_ARG_1_].meltingOre
      if _UPVALUE18_[_ARG_1_].meltingOre then
        _UPVALUE18_[_ARG_1_].meltProgress = math.min(1, _UPVALUE18_[_ARG_1_].meltProgress + (getTickCount() - _UPVALUE18_[_ARG_1_].meltingStart) / meltingTime)
        _UPVALUE18_[_ARG_1_].meltingStart = getTickCount()
      end
      ;({
        rentedBy = loadedMinesData[_ARG_1_].rentedBy,
        mineName = loadedMinesData[_ARG_1_].mineName,
        doorLocked = loadedMinesData[_ARG_1_].isLocked,
        workerNames = loadedMinesData[_ARG_1_].workerNames,
        workerPermissions = loadedMinesData[_ARG_1_].workerPermissions,
        shaftList = _UPVALUE0_[_ARG_1_],
        shaftDepths = _UPVALUE1_[_ARG_1_],
        shaftLengths = _UPVALUE2_[_ARG_1_],
        shaftOres = _UPVALUE3_[_ARG_1_],
        junctionList = _UPVALUE4_[_ARG_1_],
        railTracks = _UPVALUE5_[_ARG_1_],
        railSwitches = _UPVALUE6_[_ARG_1_],
        railSwitchStates = _UPVALUE7_[_ARG_1_],
        inventoryData = _UPVALUE8_[_ARG_1_],
        trainData = _UPVALUE9_[_ARG_1_],
        trainPassengers = _UPVALUE10_[_ARG_1_],
        installedLights = _UPVALUE11_[_ARG_1_],
        fixOres = _UPVALUE12_[_ARG_1_],
        sorterRunning = _UPVALUE13_[_ARG_1_],
        cartEmptying = _UPVALUE14_[_ARG_1_],
        bufferContent = _UPVALUE15_[_ARG_1_],
        foundryContent = _UPVALUE16_[_ARG_1_],
        oreBoxCarrying = _UPVALUE17_[_ARG_1_],
        furnaceRunning = false,
        furnaceTemperature = {},
        orderData = mineOrders[_ARG_1_],
        orderPaid = mineOrderPaid[_ARG_1_],
        furnaceRunning = _UPVALUE18_[_ARG_1_].furnaceRunning
      }).meltProgress = _UPVALUE18_[_ARG_1_].meltProgress
      if getElementData(_ARG_0_, "char.ID") == loadedMinesData[_ARG_1_].rentedBy or loadedMinesData[_ARG_1_].workerPermissions[getElementData(_ARG_0_, "char.ID")] then
        for _FORV_14_ = #loadedMinesData[_ARG_1_].workersInside, 1, -1 do
          if loadedMinesData[_ARG_1_].workersInside[_FORV_14_] == getElementData(_ARG_0_, "char.ID") then
            table.remove(loadedMinesData[_ARG_1_].workersInside, _FORV_14_)
            break
          end
        end
        _FOR_.insert(loadedMinesData[_ARG_1_].workersInside, (getElementData(_ARG_0_, "char.ID")))
        if 0 < #playersInLobby[getCorridorIdFromLobbyCorridor(getLobbyFromMineId(_ARG_1_))] then
          triggerClientEvent(playersInLobby[getCorridorIdFromLobbyCorridor(getLobbyFromMineId(_ARG_1_))], "gotMineRentData", _ARG_0_, _ARG_1_, "workersInside", loadedMinesData[_ARG_1_].workersInside)
        end
      end
      if #{} > 0 then
        triggerClientEvent({}, "otherPlayerEnteredMine", _ARG_0_, _ARG_1_, (getElementData(_ARG_0_, "char.ID")))
      end
    end
    return (triggerLatentClientEvent(_ARG_0_, "enteredMine", _ARG_0_, _ARG_1_, getElementData(_ARG_0_, "char.ID"), {
      rentedBy = loadedMinesData[_ARG_1_].rentedBy,
      mineName = loadedMinesData[_ARG_1_].mineName,
      doorLocked = loadedMinesData[_ARG_1_].isLocked,
      workerNames = loadedMinesData[_ARG_1_].workerNames,
      workerPermissions = loadedMinesData[_ARG_1_].workerPermissions,
      shaftList = _UPVALUE0_[_ARG_1_],
      shaftDepths = _UPVALUE1_[_ARG_1_],
      shaftLengths = _UPVALUE2_[_ARG_1_],
      shaftOres = _UPVALUE3_[_ARG_1_],
      junctionList = _UPVALUE4_[_ARG_1_],
      railTracks = _UPVALUE5_[_ARG_1_],
      railSwitches = _UPVALUE6_[_ARG_1_],
      railSwitchStates = _UPVALUE7_[_ARG_1_],
      inventoryData = _UPVALUE8_[_ARG_1_],
      trainData = _UPVALUE9_[_ARG_1_],
      trainPassengers = _UPVALUE10_[_ARG_1_],
      installedLights = _UPVALUE11_[_ARG_1_],
      fixOres = _UPVALUE12_[_ARG_1_],
      sorterRunning = _UPVALUE13_[_ARG_1_],
      cartEmptying = _UPVALUE14_[_ARG_1_],
      bufferContent = _UPVALUE15_[_ARG_1_],
      foundryContent = _UPVALUE16_[_ARG_1_],
      oreBoxCarrying = _UPVALUE17_[_ARG_1_],
      furnaceRunning = false,
      furnaceTemperature = {},
      orderData = mineOrders[_ARG_1_],
      orderPaid = mineOrderPaid[_ARG_1_],
      furnaceRunning = _UPVALUE18_[_ARG_1_].furnaceRunning
    }))
  end
  return false
end
addEvent("tryToEnterMine", true)
addEventHandler("tryToEnterMine", root, function(_ARG_0_)
  if client and loadedMinesData[_ARG_0_] then
    if loadedMinesData[_ARG_0_].isLocked then
      triggerClientEvent(client, "mineEnterResponse", client, false, "Az ajtó zárva van!")
      if #playersInLobby[getCorridorIdFromLobbyCorridor(getLobbyFromMineId(_ARG_0_))] > 0 then
        triggerClientEvent(playersInLobby[getCorridorIdFromLobbyCorridor(getLobbyFromMineId(_ARG_0_))], "gotMineDoorSound", client, _ARG_0_, 6)
      end
    elseif #playersInMine[_ARG_0_] >= maxWorkersInside then
      triggerClientEvent(client, "mineEnterResponse", client, false, "Egyszerre csak " .. maxWorkersInside .. " ember lehet a munkaterületen!")
    else
      setPlayerMine(client, _ARG_0_)
      if #playersInLobby[getCorridorIdFromLobbyCorridor(getLobbyFromMineId(_ARG_0_))] > 0 then
        triggerClientEvent(playersInLobby[getCorridorIdFromLobbyCorridor(getLobbyFromMineId(_ARG_0_))], "gotMineDoorSound", client, _ARG_0_, math.random(1, 4))
      end
    end
  end
end)
addEvent("tryToExitMine", true)
addEventHandler("tryToExitMine", root, function()
  if client and playersCurrentMine[client] and loadedMinesData[playersCurrentMine[client]] then
    if loadedMinesData[playersCurrentMine[client]].isLocked then
      triggerClientEvent(client, "mineExitResponse", client, false, "Az ajtó zárva van!")
      if #playersInMine[playersCurrentMine[client]] > 0 then
        triggerClientEvent(playersInMine[playersCurrentMine[client]], "gotMineDoorSound", client, playersCurrentMine[client], 6)
      end
    else
      setPlayerMine(client, false)
      if #playersInMine[playersCurrentMine[client]] > 0 then
        triggerClientEvent(playersInMine[playersCurrentMine[client]], "gotMineDoorSound", client, playersCurrentMine[client], math.random(1, 4))
      end
    end
  end
end)
addEvent("syncPickaxe", true)
addEventHandler("syncPickaxe", root, function(_ARG_0_)
  if client then
    if type(_ARG_0_) == "number" then
      if exports.see_items:findItemsByPattern(client, {
        dbID = _ARG_0_,
        itemId = 164,
        data1 = "fortune"
      }, true) then
        _UPVALUE0_[client] = "fortune"
      else
        _UPVALUE0_[client] = "default"
      end
    else
      _UPVALUE0_[client] = nil
    end
    if type(_ARG_0_) == "number" then
      exports.see_chat:localAction(client, "elővett egy csákányt.")
    else
      exports.see_chat:localAction(client, "elrakott egy csákányt.")
    end
    if #loadedPlayers > 0 then
      triggerClientEvent(loadedPlayers, "syncPickaxe", client, type(_ARG_0_) == "number")
    end
  end
end)
addMineEventHandler("syncMineAim", root, function(_ARG_0_, _ARG_1_, _ARG_2_)
  for _FORV_7_ = 1, #playersInMine[_ARG_0_] do
    if playersInMine[_ARG_0_][_FORV_7_] ~= client then
      table.insert({}, playersInMine[_ARG_0_][_FORV_7_])
    end
  end
  if _FOR_ > 0 then
    triggerClientEvent({}, "syncMineAim", client, _ARG_0_, _ARG_1_, _ARG_2_)
  end
end)
addMineEventHandler("syncMineHit", root, function(_ARG_0_, _ARG_1_)
  for _FORV_6_ = 1, #playersInMine[_ARG_0_] do
    if playersInMine[_ARG_0_][_FORV_6_] ~= client then
      table.insert({}, playersInMine[_ARG_0_][_FORV_6_])
    end
  end
  if _FOR_ > 0 then
    triggerClientEvent({}, "syncMineHit", client, _ARG_0_, _ARG_1_)
  end
end)
addMineEventHandler("handleMineHit", root, function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  if _UPVALUE0_[_ARG_0_][_ARG_1_] then
    if not checkMinePermission(client, permissionFlags.MINING) then
      exports.see_gui:showInfobox(client, "e", "Ehhez nincs jogosultságod!")
    elseif 0 < math.pow(wallMaximumDepth, 2) * math.max(0, math.min(1, _ARG_3_)) / (math.random() + 2.5) then
      if _UPVALUE0_[_ARG_0_][_ARG_1_][_ARG_2_] + math.pow(wallMaximumDepth, 2) * math.max(0, math.min(1, _ARG_3_)) / (math.random() + 2.5) * 10 > wallMaximumDepth then
      end
      if type((doHandleMineHit(_ARG_0_, _ARG_1_, _ARG_2_, math.pow(wallMaximumDepth, 2) * math.max(0, math.min(1, _ARG_3_)) / (math.random() + 2.5) * 10 - (_UPVALUE0_[_ARG_0_][_ARG_1_][_ARG_2_] + math.pow(wallMaximumDepth, 2) * math.max(0, math.min(1, _ARG_3_)) / (math.random() + 2.5) * 10 - wallMaximumDepth)))) == "table" then
        triggerClientEvent(playersInMine[_ARG_0_], "handleMineHit", client, _ARG_0_, _ARG_1_, _ARG_2_, math.pow(wallMaximumDepth, 2) * math.max(0, math.min(1, _ARG_3_)) / (math.random() + 2.5) * 10 - (_UPVALUE0_[_ARG_0_][_ARG_1_][_ARG_2_] + math.pow(wallMaximumDepth, 2) * math.max(0, math.min(1, _ARG_3_)) / (math.random() + 2.5) * 10 - wallMaximumDepth), doHandleMineHit(_ARG_0_, _ARG_1_, _ARG_2_, math.pow(wallMaximumDepth, 2) * math.max(0, math.min(1, _ARG_3_)) / (math.random() + 2.5) * 10 - (_UPVALUE0_[_ARG_0_][_ARG_1_][_ARG_2_] + math.pow(wallMaximumDepth, 2) * math.max(0, math.min(1, _ARG_3_)) / (math.random() + 2.5) * 10 - wallMaximumDepth)), math.random() > 0.5)
      end
      setElementData(client, "mineDirtyFace", true, "broadcast", "deny")
    end
  end
end)
addMineEventHandler("handleMineDetonate", root, function(_ARG_0_, _ARG_1_)
  if _UPVALUE0_[_ARG_0_][_ARG_1_] then
    if not checkMinePermission(client, permissionFlags.USE_BOMB) then
      exports.see_gui:showInfobox(client, "e", "Ehhez nincs jogosultságod!")
    elseif _UPVALUE1_[_ARG_0_] then
      exports.see_gui:showInfobox(client, "e", "Egyszerre maximum egy dinamit lehet meggyújtva a bányában!")
    elseif not exports.see_items:takeItem(client, "itemId", 720, 1) then
      exports.see_gui:showInfobox(client, "e", "Nincs nálad meglévő járathoz való dinamit!")
    else
      setPedAnimation(client, "CASINO", "SLOT_PLYR", -1, false, true, false, false)
      if #playersInMine[_ARG_0_] > 0 then
        triggerClientEvent(playersInMine[_ARG_0_], "gotMineOpenShaftBomb", client, _ARG_0_, _ARG_1_)
      end
      _UPVALUE1_[_ARG_0_] = setTimer(function(_ARG_0_)
        if not isElement(_ARG_0_) then
          _ARG_0_ = resourceRoot
        end
        if #playersInMine[_UPVALUE0_] > 0 then
          triggerClientEvent(playersInMine[_UPVALUE0_], "detonateMineOpenShaftBomb", _ARG_0_, _UPVALUE0_, _UPVALUE1_)
        end
        for _FORV_5_ = 1, wallBlockCount do
          if -_UPVALUE2_[_UPVALUE0_][_UPVALUE1_][_FORV_5_] then
            doHandleMineHit(_UPVALUE0_, _UPVALUE1_, _FORV_5_, -_UPVALUE2_[_UPVALUE0_][_UPVALUE1_][_FORV_5_], _ARG_0_)
            if #playersInMine[_UPVALUE0_] > 0 then
              triggerClientEvent(playersInMine[_UPVALUE0_], "handleMineDetonate", _ARG_0_, _UPVALUE0_, _UPVALUE1_, _FORV_5_, -_UPVALUE2_[_UPVALUE0_][_UPVALUE1_][_FORV_5_], false)
            end
          end
        end
        if #playersInMine[_UPVALUE0_] > 0 then
          triggerClientEvent(playersInMine[_UPVALUE0_], "handleMineDetonate", _ARG_0_, _UPVALUE0_, _UPVALUE1_)
        end
        for _FORV_5_ = 1, wallBlockCount do
          if _FORV_5_ == math.ceil(wallBlockCount / 2) then
          end
          if type((doHandleMineHit(_UPVALUE0_, _UPVALUE1_, _FORV_5_, 3.5 + math.random() * 1 + wallMaximumDepth / 2, _ARG_0_))) == "table" then
            if #playersInMine[_UPVALUE0_] > 0 then
              triggerClientEvent(playersInMine[_UPVALUE0_], "handleMineDetonate", _ARG_0_, _UPVALUE0_, _UPVALUE1_, _FORV_5_, 3.5 + math.random() * 1 + wallMaximumDepth / 2, (doHandleMineHit(_UPVALUE0_, _UPVALUE1_, _FORV_5_, 3.5 + math.random() * 1 + wallMaximumDepth / 2, _ARG_0_)))
            end
          else
            break
          end
        end
        if #playersInMine[_UPVALUE0_] > 0 then
          triggerClientEvent(playersInMine[_UPVALUE0_], "handleMineDetonate", _ARG_0_, _UPVALUE0_, _UPVALUE1_)
        end
        _UPVALUE3_[_UPVALUE0_] = nil
      end, detonationTime, 1, client)
      exports.see_chat:localAction(client, "felszerelt egy dinamitot.")
    end
  end
end)
addMineEventHandler("createNewMineShaft", root, function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  if _UPVALUE0_[_ARG_0_][_ARG_1_] then
    if not checkMinePermission(client, permissionFlags.USE_BOMB) then
      exports.see_gui:showInfobox(client, "e", "Ehhez nincs jogosultságod!")
    elseif _UPVALUE1_[_ARG_0_] then
      exports.see_gui:showInfobox(client, "e", "Egyszerre maximum egy dinamit lehet meggyújtva a bányában!")
    elseif not exports.see_items:takeItem(client, "itemId", 721, 1) then
      exports.see_gui:showInfobox(client, "e", "Nincs nálad új járathoz való dinamit!")
    else
      setPedAnimation(client, "CASINO", "SLOT_PLYR", -1, false, true, false, false)
      if 0 < #playersInMine[_ARG_0_] then
        triggerClientEvent(playersInMine[_ARG_0_], "gotMineShaftBomb", client, _ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_ and 1 or 0)
      end
      _UPVALUE1_[_ARG_0_] = setTimer(function(_ARG_0_)
        _UPVALUE0_[_UPVALUE1_] = nil
        if not isElement(_ARG_0_) then
          _ARG_0_ = resourceRoot
        end
        if #playersInMine[_UPVALUE1_] > 0 then
          triggerClientEvent(playersInMine[_UPVALUE1_], "detonateMineShaftBomb", _ARG_0_, _UPVALUE1_, _UPVALUE2_, _UPVALUE3_, _UPVALUE4_)
        end
        createOpenShaft(_UPVALUE1_, _UPVALUE2_, _UPVALUE3_, _UPVALUE5_)
      end, detonationTime, 1, client)
      exports.see_chat:localAction(client, "felszerelt egy dinamitot.")
    end
  end
end)
addMineEventHandler("extendMineThreeJunction", root, function(_ARG_0_, _ARG_1_, _ARG_2_)
  if _UPVALUE0_[_ARG_0_][_ARG_1_] and _UPVALUE0_[_ARG_0_][_ARG_1_][_ARG_2_] then
    if _UPVALUE1_[_ARG_0_][_UPVALUE0_[_ARG_0_][_ARG_1_] and _UPVALUE0_[_ARG_0_][_ARG_1_][_ARG_2_]] then
      if not checkMinePermission(client, permissionFlags.USE_BOMB) then
        exports.see_gui:showInfobox(client, "e", "Ehhez nincs jogosultságod!")
      elseif _UPVALUE2_[_ARG_0_] then
        exports.see_gui:showInfobox(client, "e", "Egyszerre maximum egy dinamit lehet meggyújtva a bányában!")
      elseif not exports.see_items:takeItem(client, "itemId", 721, 1) then
        exports.see_gui:showInfobox(client, "e", "Nincs nálad új járathoz való dinamit!")
      else
        setPedAnimation(client, "CASINO", "SLOT_PLYR", -1, false, true, false, false)
        if #playersInMine[_ARG_0_] > 0 then
          triggerClientEvent(playersInMine[_ARG_0_], "gotMineThreeJunctionBomb", client, _ARG_0_, _ARG_1_, _ARG_2_)
        end
        _UPVALUE2_[_ARG_0_] = setTimer(function(_ARG_0_)
          _UPVALUE0_[_UPVALUE1_] = nil
          if not isElement(_ARG_0_) then
            _ARG_0_ = resourceRoot
          end
          if #playersInMine[_UPVALUE1_] > 0 then
            triggerClientEvent(playersInMine[_UPVALUE1_], "detonateMineThreeJunctionBomb", _ARG_0_, _UPVALUE1_, _UPVALUE2_, _UPVALUE3_)
          end
          if not (_UPVALUE5_[_UPVALUE1_][_UPVALUE2_ - psin((prad(_UPVALUE4_[4])))] and _UPVALUE5_[_UPVALUE1_][_UPVALUE2_ - psin((prad(_UPVALUE4_[4])))][_UPVALUE3_ + pcos((prad(_UPVALUE4_[4])))]) then
            _UPVALUE6_[_UPVALUE1_][#_UPVALUE6_[_UPVALUE1_] + 1] = {
              _UPVALUE2_ - psin((prad(_UPVALUE4_[4]))),
              _UPVALUE3_ + pcos((prad(_UPVALUE4_[4]))),
              1,
              (_UPVALUE4_[4] + 90) % 360,
              rngRandomSeed(),
              0
            }
            _UPVALUE7_[_UPVALUE1_][#_UPVALUE6_[_UPVALUE1_] + 1] = rngCreate((rngRandomSeed()))
            _UPVALUE8_[_UPVALUE1_][#_UPVALUE6_[_UPVALUE1_] + 1] = {}
            _UPVALUE9_[_UPVALUE1_][#_UPVALUE6_[_UPVALUE1_] + 1] = 0
            for _FORV_14_ = 1, wallBlockCount do
              _UPVALUE8_[_UPVALUE1_][#_UPVALUE6_[_UPVALUE1_] + 1][_FORV_14_] = 0
            end
            if not _UPVALUE10_[_UPVALUE1_][#_UPVALUE6_[_UPVALUE1_] + 1] then
              _UPVALUE10_[_UPVALUE1_][#_UPVALUE6_[_UPVALUE1_] + 1] = generateShaftOres(_UPVALUE1_, #_UPVALUE6_[_UPVALUE1_] + 1)
            end
          else
            _UPVALUE10_[_UPVALUE1_][_UPVALUE5_[_UPVALUE1_][_UPVALUE2_ - psin((prad(_UPVALUE4_[4])))] and _UPVALUE5_[_UPVALUE1_][_UPVALUE2_ - psin((prad(_UPVALUE4_[4])))][_UPVALUE3_ + pcos((prad(_UPVALUE4_[4])))]] = nil
            _UPVALUE8_[_UPVALUE1_][_UPVALUE5_[_UPVALUE1_][_UPVALUE2_ - psin((prad(_UPVALUE4_[4])))] and _UPVALUE5_[_UPVALUE1_][_UPVALUE2_ - psin((prad(_UPVALUE4_[4])))][_UPVALUE3_ + pcos((prad(_UPVALUE4_[4])))]] = nil
            _UPVALUE9_[_UPVALUE1_][_UPVALUE5_[_UPVALUE1_][_UPVALUE2_ - psin((prad(_UPVALUE4_[4])))] and _UPVALUE5_[_UPVALUE1_][_UPVALUE2_ - psin((prad(_UPVALUE4_[4])))][_UPVALUE3_ + pcos((prad(_UPVALUE4_[4])))]] = nil
          end
          _UPVALUE4_[4] = nil
          if #playersInMine[_UPVALUE1_] > 0 then
            triggerClientEvent(playersInMine[_UPVALUE1_], "gotNewMineShaft", resourceRoot, _UPVALUE1_, _UPVALUE2_, _UPVALUE3_, _UPVALUE4_[4], false, false, true, false, #_UPVALUE6_[_UPVALUE1_] + 1, _UPVALUE4_[3], rngRandomSeed(), _UPVALUE10_[_UPVALUE1_][#_UPVALUE6_[_UPVALUE1_] + 1], _UPVALUE5_[_UPVALUE1_][_UPVALUE2_ - psin((prad(_UPVALUE4_[4])))] and _UPVALUE5_[_UPVALUE1_][_UPVALUE2_ - psin((prad(_UPVALUE4_[4])))][_UPVALUE3_ + pcos((prad(_UPVALUE4_[4])))], nil)
          end
          refreshMineShafts(_UPVALUE1_)
        end, detonationTime, 1, client)
        exports.see_chat:localAction(client, "felszerelt egy dinamitot.")
      end
    end
  end
end)
function doHandleMineHit(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  _ARG_4_ = client or _ARG_4_
  if not _UPVALUE1_[_ARG_0_][_ARG_1_] then
    return
  end
  _UPVALUE1_[_ARG_0_][_ARG_1_][_ARG_2_] = _UPVALUE1_[_ARG_0_][_ARG_1_][_ARG_2_] + _ARG_3_
  for _FORV_12_ = 1, wallBlockCount do
  end
  if math.min(_UPVALUE1_[_ARG_0_][_ARG_1_][_FORV_12_], false or _UPVALUE1_[_ARG_0_][_ARG_1_][_FORV_12_]) > 0 then
    _UPVALUE2_[_ARG_0_][_ARG_1_] = math.max(0, _UPVALUE2_[_ARG_0_][_ARG_1_] + math.min(_UPVALUE1_[_ARG_0_][_ARG_1_][_FORV_12_], false or _UPVALUE1_[_ARG_0_][_ARG_1_][_FORV_12_]))
    for _FORV_12_ = 1, wallBlockCount do
      _UPVALUE1_[_ARG_0_][_ARG_1_][_FORV_12_] = _UPVALUE1_[_ARG_0_][_ARG_1_][_FORV_12_] - math.min(_UPVALUE1_[_ARG_0_][_ARG_1_][_FORV_12_], false or _UPVALUE1_[_ARG_0_][_ARG_1_][_FORV_12_])
    end
  end
  if _ARG_3_ <= 0 then
    return
  end
  for _FORV_12_ = 1, wallBlockCount do
  end
  while _FOR_[_ARG_0_][_ARG_1_] + math.max(_UPVALUE1_[_ARG_0_][_ARG_1_][_FORV_12_], false or _UPVALUE1_[_ARG_0_][_ARG_1_][_FORV_12_]) >= _UPVALUE0_[_ARG_0_][_ARG_1_][3] * _UPVALUE3_ - wallMinimumDepth do
    if _UPVALUE5_[_ARG_0_][_UPVALUE0_[_ARG_0_][_ARG_1_][1] + (_UPVALUE0_[_ARG_0_][_ARG_1_][3] - 1) * pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))) + pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4])))] and _UPVALUE5_[_ARG_0_][_UPVALUE0_[_ARG_0_][_ARG_1_][1] + (_UPVALUE0_[_ARG_0_][_ARG_1_][3] - 1) * pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))) + pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4])))][_UPVALUE0_[_ARG_0_][_ARG_1_][2] + (_UPVALUE0_[_ARG_0_][_ARG_1_][3] - 1) * psin((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))) + psin((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4])))] then
      if _UPVALUE0_[_ARG_0_][_UPVALUE5_[_ARG_0_][_UPVALUE0_[_ARG_0_][_ARG_1_][1] + (_UPVALUE0_[_ARG_0_][_ARG_1_][3] - 1) * pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))) + pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4])))] and _UPVALUE5_[_ARG_0_][_UPVALUE0_[_ARG_0_][_ARG_1_][1] + (_UPVALUE0_[_ARG_0_][_ARG_1_][3] - 1) * pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))) + pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4])))][_UPVALUE0_[_ARG_0_][_ARG_1_][2] + (_UPVALUE0_[_ARG_0_][_ARG_1_][3] - 1) * psin((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))) + psin((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4])))]] then
        if psin((prad((_UPVALUE0_[_ARG_0_][_ARG_1_][4] - _UPVALUE0_[_ARG_0_][_UPVALUE5_[_ARG_0_][_UPVALUE0_[_ARG_0_][_ARG_1_][1] + (_UPVALUE0_[_ARG_0_][_ARG_1_][3] - 1) * pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))) + pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4])))] and _UPVALUE5_[_ARG_0_][_UPVALUE0_[_ARG_0_][_ARG_1_][1] + (_UPVALUE0_[_ARG_0_][_ARG_1_][3] - 1) * pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))) + pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4])))][_UPVALUE0_[_ARG_0_][_ARG_1_][2] + (_UPVALUE0_[_ARG_0_][_ARG_1_][3] - 1) * psin((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))) + psin((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4])))]][4]) % 360))) == 0 then
          _UPVALUE7_[_ARG_0_][_UPVALUE5_[_ARG_0_][_UPVALUE0_[_ARG_0_][_ARG_1_][1] + (_UPVALUE0_[_ARG_0_][_ARG_1_][3] - 1) * pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))) + pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4])))] and _UPVALUE5_[_ARG_0_][_UPVALUE0_[_ARG_0_][_ARG_1_][1] + (_UPVALUE0_[_ARG_0_][_ARG_1_][3] - 1) * pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))) + pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4])))][_UPVALUE0_[_ARG_0_][_ARG_1_][2] + (_UPVALUE0_[_ARG_0_][_ARG_1_][3] - 1) * psin((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))) + psin((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4])))]] = nil
          _UPVALUE1_[_ARG_0_][_UPVALUE5_[_ARG_0_][_UPVALUE0_[_ARG_0_][_ARG_1_][1] + (_UPVALUE0_[_ARG_0_][_ARG_1_][3] - 1) * pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))) + pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4])))] and _UPVALUE5_[_ARG_0_][_UPVALUE0_[_ARG_0_][_ARG_1_][1] + (_UPVALUE0_[_ARG_0_][_ARG_1_][3] - 1) * pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))) + pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4])))][_UPVALUE0_[_ARG_0_][_ARG_1_][2] + (_UPVALUE0_[_ARG_0_][_ARG_1_][3] - 1) * psin((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))) + psin((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4])))]] = nil
          _UPVALUE2_[_ARG_0_][_UPVALUE5_[_ARG_0_][_UPVALUE0_[_ARG_0_][_ARG_1_][1] + (_UPVALUE0_[_ARG_0_][_ARG_1_][3] - 1) * pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))) + pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4])))] and _UPVALUE5_[_ARG_0_][_UPVALUE0_[_ARG_0_][_ARG_1_][1] + (_UPVALUE0_[_ARG_0_][_ARG_1_][3] - 1) * pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))) + pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4])))][_UPVALUE0_[_ARG_0_][_ARG_1_][2] + (_UPVALUE0_[_ARG_0_][_ARG_1_][3] - 1) * psin((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))) + psin((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4])))]] = nil
          _UPVALUE7_[_ARG_0_][_ARG_1_] = nil
          _UPVALUE1_[_ARG_0_][_ARG_1_] = nil
          _UPVALUE2_[_ARG_0_][_ARG_1_] = nil
          refreshMineShafts(_ARG_0_)
          if 0 < #playersInMine[_ARG_0_] then
            triggerClientEvent(playersInMine[_ARG_0_], "closeMergedMineShafts", _ARG_4_, _ARG_0_, _ARG_1_, _UPVALUE5_[_ARG_0_][_UPVALUE0_[_ARG_0_][_ARG_1_][1] + (_UPVALUE0_[_ARG_0_][_ARG_1_][3] - 1) * pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))) + pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4])))] and _UPVALUE5_[_ARG_0_][_UPVALUE0_[_ARG_0_][_ARG_1_][1] + (_UPVALUE0_[_ARG_0_][_ARG_1_][3] - 1) * pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))) + pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4])))][_UPVALUE0_[_ARG_0_][_ARG_1_][2] + (_UPVALUE0_[_ARG_0_][_ARG_1_][3] - 1) * psin((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))) + psin((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4])))])
          end
          return
        elseif _UPVALUE6_[_ARG_0_][_UPVALUE0_[_ARG_0_][_ARG_1_][1] + (_UPVALUE0_[_ARG_0_][_ARG_1_][3] - 1) * pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))) + pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4])))] and _UPVALUE6_[_ARG_0_][_UPVALUE0_[_ARG_0_][_ARG_1_][1] + (_UPVALUE0_[_ARG_0_][_ARG_1_][3] - 1) * pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))) + pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4])))][_UPVALUE0_[_ARG_0_][_ARG_1_][2] + (_UPVALUE0_[_ARG_0_][_ARG_1_][3] - 1) * psin((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))) + psin((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4])))] and _UPVALUE0_[_ARG_0_][unpack(_UPVALUE6_[_ARG_0_][_UPVALUE0_[_ARG_0_][_ARG_1_][1] + (_UPVALUE0_[_ARG_0_][_ARG_1_][3] - 1) * pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))) + pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4])))] and _UPVALUE6_[_ARG_0_][_UPVALUE0_[_ARG_0_][_ARG_1_][1] + (_UPVALUE0_[_ARG_0_][_ARG_1_][3] - 1) * pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))) + pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4])))][_UPVALUE0_[_ARG_0_][_ARG_1_][2] + (_UPVALUE0_[_ARG_0_][_ARG_1_][3] - 1) * psin((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))) + psin((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4])))])] then
          createOpenShaft(_ARG_0_, unpack(_UPVALUE6_[_ARG_0_][_UPVALUE0_[_ARG_0_][_ARG_1_][1] + (_UPVALUE0_[_ARG_0_][_ARG_1_][3] - 1) * pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))) + pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4])))] and _UPVALUE6_[_ARG_0_][_UPVALUE0_[_ARG_0_][_ARG_1_][1] + (_UPVALUE0_[_ARG_0_][_ARG_1_][3] - 1) * pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))) + pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4])))][_UPVALUE0_[_ARG_0_][_ARG_1_][2] + (_UPVALUE0_[_ARG_0_][_ARG_1_][3] - 1) * psin((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))) + psin((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4])))]))
          return
        end
      end
    elseif _UPVALUE4_[_ARG_0_][_UPVALUE0_[_ARG_0_][_ARG_1_][1] + (_UPVALUE0_[_ARG_0_][_ARG_1_][3] - 1) * pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))) + pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4])))] and _UPVALUE4_[_ARG_0_][_UPVALUE0_[_ARG_0_][_ARG_1_][1] + (_UPVALUE0_[_ARG_0_][_ARG_1_][3] - 1) * pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))) + pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4])))][_UPVALUE0_[_ARG_0_][_ARG_1_][2] + (_UPVALUE0_[_ARG_0_][_ARG_1_][3] - 1) * psin((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))) + psin((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4])))] then
      if _UPVALUE8_[_ARG_0_][_UPVALUE4_[_ARG_0_][_UPVALUE0_[_ARG_0_][_ARG_1_][1] + (_UPVALUE0_[_ARG_0_][_ARG_1_][3] - 1) * pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))) + pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4])))] and _UPVALUE4_[_ARG_0_][_UPVALUE0_[_ARG_0_][_ARG_1_][1] + (_UPVALUE0_[_ARG_0_][_ARG_1_][3] - 1) * pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))) + pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4])))][_UPVALUE0_[_ARG_0_][_ARG_1_][2] + (_UPVALUE0_[_ARG_0_][_ARG_1_][3] - 1) * psin((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))) + psin((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4])))]] then
        _UPVALUE8_[_ARG_0_][_UPVALUE4_[_ARG_0_][_UPVALUE0_[_ARG_0_][_ARG_1_][1] + (_UPVALUE0_[_ARG_0_][_ARG_1_][3] - 1) * pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))) + pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4])))] and _UPVALUE4_[_ARG_0_][_UPVALUE0_[_ARG_0_][_ARG_1_][1] + (_UPVALUE0_[_ARG_0_][_ARG_1_][3] - 1) * pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))) + pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4])))][_UPVALUE0_[_ARG_0_][_ARG_1_][2] + (_UPVALUE0_[_ARG_0_][_ARG_1_][3] - 1) * psin((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))) + psin((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4])))]][4] = nil
        _UPVALUE7_[_ARG_0_][_ARG_1_] = nil
        _UPVALUE1_[_ARG_0_][_ARG_1_] = nil
        _UPVALUE2_[_ARG_0_][_ARG_1_] = nil
        refreshMineShafts(_ARG_0_)
        if 0 < #playersInMine[_ARG_0_] then
          triggerClientEvent(playersInMine[_ARG_0_], "closeMergedMineShafts", _ARG_4_, _ARG_0_, _ARG_1_, false, _UPVALUE8_[_ARG_0_][_UPVALUE4_[_ARG_0_][_UPVALUE0_[_ARG_0_][_ARG_1_][1] + (_UPVALUE0_[_ARG_0_][_ARG_1_][3] - 1) * pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))) + pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4])))] and _UPVALUE4_[_ARG_0_][_UPVALUE0_[_ARG_0_][_ARG_1_][1] + (_UPVALUE0_[_ARG_0_][_ARG_1_][3] - 1) * pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))) + pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4])))][_UPVALUE0_[_ARG_0_][_ARG_1_][2] + (_UPVALUE0_[_ARG_0_][_ARG_1_][3] - 1) * psin((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))) + psin((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4])))]][1], _UPVALUE8_[_ARG_0_][_UPVALUE4_[_ARG_0_][_UPVALUE0_[_ARG_0_][_ARG_1_][1] + (_UPVALUE0_[_ARG_0_][_ARG_1_][3] - 1) * pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))) + pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4])))] and _UPVALUE4_[_ARG_0_][_UPVALUE0_[_ARG_0_][_ARG_1_][1] + (_UPVALUE0_[_ARG_0_][_ARG_1_][3] - 1) * pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))) + pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4])))][_UPVALUE0_[_ARG_0_][_ARG_1_][2] + (_UPVALUE0_[_ARG_0_][_ARG_1_][3] - 1) * psin((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))) + psin((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4])))]][2], _UPVALUE8_[_ARG_0_][_UPVALUE4_[_ARG_0_][_UPVALUE0_[_ARG_0_][_ARG_1_][1] + (_UPVALUE0_[_ARG_0_][_ARG_1_][3] - 1) * pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))) + pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4])))] and _UPVALUE4_[_ARG_0_][_UPVALUE0_[_ARG_0_][_ARG_1_][1] + (_UPVALUE0_[_ARG_0_][_ARG_1_][3] - 1) * pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))) + pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4])))][_UPVALUE0_[_ARG_0_][_ARG_1_][2] + (_UPVALUE0_[_ARG_0_][_ARG_1_][3] - 1) * psin((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))) + psin((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4])))]][3])
        end
        return
      end
    elseif _UPVALUE6_[_ARG_0_][_UPVALUE0_[_ARG_0_][_ARG_1_][1] + (_UPVALUE0_[_ARG_0_][_ARG_1_][3] - 1) * pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))) + pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4])))] and _UPVALUE6_[_ARG_0_][_UPVALUE0_[_ARG_0_][_ARG_1_][1] + (_UPVALUE0_[_ARG_0_][_ARG_1_][3] - 1) * pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))) + pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4])))][_UPVALUE0_[_ARG_0_][_ARG_1_][2] + (_UPVALUE0_[_ARG_0_][_ARG_1_][3] - 1) * psin((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))) + psin((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4])))] then
      if _UPVALUE0_[_ARG_0_][unpack(_UPVALUE6_[_ARG_0_][_UPVALUE0_[_ARG_0_][_ARG_1_][1] + (_UPVALUE0_[_ARG_0_][_ARG_1_][3] - 1) * pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))) + pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4])))] and _UPVALUE6_[_ARG_0_][_UPVALUE0_[_ARG_0_][_ARG_1_][1] + (_UPVALUE0_[_ARG_0_][_ARG_1_][3] - 1) * pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))) + pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4])))][_UPVALUE0_[_ARG_0_][_ARG_1_][2] + (_UPVALUE0_[_ARG_0_][_ARG_1_][3] - 1) * psin((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))) + psin((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4])))])] then
        createOpenShaft(_ARG_0_, unpack(_UPVALUE6_[_ARG_0_][_UPVALUE0_[_ARG_0_][_ARG_1_][1] + (_UPVALUE0_[_ARG_0_][_ARG_1_][3] - 1) * pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))) + pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4])))] and _UPVALUE6_[_ARG_0_][_UPVALUE0_[_ARG_0_][_ARG_1_][1] + (_UPVALUE0_[_ARG_0_][_ARG_1_][3] - 1) * pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))) + pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4])))][_UPVALUE0_[_ARG_0_][_ARG_1_][2] + (_UPVALUE0_[_ARG_0_][_ARG_1_][3] - 1) * psin((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))) + psin((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4])))]))
        return
      end
    else
      if _UPVALUE0_[_ARG_0_][_ARG_1_][3] ~= _UPVALUE0_[_ARG_0_][_ARG_1_][3] + 1 then
        _UPVALUE0_[_ARG_0_][_ARG_1_][3] = _UPVALUE0_[_ARG_0_][_ARG_1_][3] + 1
        if not _UPVALUE7_[_ARG_0_][_ARG_1_] then
          _UPVALUE7_[_ARG_0_][_ARG_1_] = {}
        end
        for _FORV_26_ = 1, #generateShaftOres(_ARG_0_, _ARG_1_) do
          table.insert(_UPVALUE7_[_ARG_0_][_ARG_1_], generateShaftOres(_ARG_0_, _ARG_1_)[_FORV_26_])
        end
        if #_FOR_[_ARG_0_] > 0 then
          triggerClientEvent(playersInMine[_ARG_0_], "gotExtendedMineShaft", _ARG_4_, _ARG_0_, _ARG_1_, (generateShaftOres(_ARG_0_, _ARG_1_)))
        end
      end
      refreshMineShafts(_ARG_0_)
    end
  end
  for _FORV_16_ = #(_UPVALUE7_[_ARG_0_][_ARG_1_] or {}), 1, -1 do
    if unpack((_UPVALUE7_[_ARG_0_][_ARG_1_] or {})[_FORV_16_]) == _ARG_2_ then
      if unpack((_UPVALUE7_[_ARG_0_][_ARG_1_] or {})[_FORV_16_]) <= _FOR_[_ARG_0_][_ARG_1_] + _UPVALUE1_[_ARG_0_][_ARG_1_][_ARG_2_] then
        ({})[unpack((_UPVALUE7_[_ARG_0_][_ARG_1_] or {})[_FORV_16_])] = true
        if oreTypes[unpack((_UPVALUE7_[_ARG_0_][_ARG_1_] or {})[_FORV_16_])] then
          while true do
            if not _UPVALUE9_[_ARG_0_][0 + 1] then
              _UPVALUE9_[_ARG_0_][0 + 1] = {
                unpack((_UPVALUE7_[_ARG_0_][_ARG_1_] or {})[_FORV_16_])
              }
              if not _UPVALUE10_[_ARG_0_] then
                _UPVALUE10_[_ARG_0_] = {}
              end
              table.insert(_UPVALUE10_[_ARG_0_], {
                0 + 1,
                getTickCount()
              })
              checkFixOreTimer()
              break
            end
          end
          ;({})[unpack((_UPVALUE7_[_ARG_0_][_ARG_1_] or {})[_FORV_16_])] = {
            0 + 1,
            unpack((_UPVALUE7_[_ARG_0_][_ARG_1_] or {})[_FORV_16_])
          }
        end
        table.remove(_UPVALUE7_[_ARG_0_][_ARG_1_] or {}, _FORV_16_)
      end
    end
  end
  return {}
end
function checkFixOreTimer()
  if not _UPVALUE0_ then
    _UPVALUE0_ = setTimer(checkFixOres, 60000, 0)
  end
end
function checkFixOres()
  if next(_UPVALUE0_) then
    for _FORV_5_ in pairs(_UPVALUE0_) do
      for _FORV_9_ = #_UPVALUE0_[_FORV_5_], 1, -1 do
        if getTickCount() - unpack(_UPVALUE0_[_FORV_5_][_FORV_9_]) >= 7200000 then
          table.remove(_UPVALUE0_[_FORV_5_], _FORV_9_)
          if not ({})[_FORV_5_] then
            ({})[_FORV_5_] = {}
          end
          table.insert(({})[_FORV_5_], unpack(_UPVALUE0_[_FORV_5_][_FORV_9_]))
          if _UPVALUE1_[_FORV_5_] then
            _UPVALUE1_[_FORV_5_][unpack(_UPVALUE0_[_FORV_5_][_FORV_9_])] = nil
          end
        end
      end
      if #_FOR_[_FORV_5_] == 0 then
        _UPVALUE0_[_FORV_5_] = nil
      end
    end
    for _FORV_5_, _FORV_6_ in pairs({}) do
      if 0 < #playersInMine[_FORV_5_] then
        triggerLatentClientEvent(playersInMine[_FORV_5_], "syncFixOreDelete", resourceRoot, _FORV_5_, _FORV_6_)
      end
    end
    if not next(_UPVALUE0_) then
      if isTimer(_UPVALUE2_) then
        killTimer(_UPVALUE2_)
      end
      _UPVALUE2_ = nil
    end
  else
    if isTimer(_UPVALUE2_) then
      killTimer(_UPVALUE2_)
    end
    _UPVALUE2_ = nil
  end
end
function createOpenShaft(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  _UPVALUE0_[_ARG_0_][#_UPVALUE0_[_ARG_0_] + 1] = {
    _UPVALUE0_[_ARG_0_][_ARG_1_][1] + (_ARG_2_ - 1) * pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))) + pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))),
    _UPVALUE0_[_ARG_0_][_ARG_1_][2] + (_ARG_2_ - 1) * psin((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))) + psin((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))),
    math.max(1, _UPVALUE0_[_ARG_0_][_ARG_1_][3] - _ARG_2_),
    _UPVALUE0_[_ARG_0_][_ARG_1_][4],
    _UPVALUE0_[_ARG_0_][_ARG_1_][5],
    _ARG_2_
  }
  _UPVALUE1_[_ARG_0_][#_UPVALUE0_[_ARG_0_] + 1] = _UPVALUE1_[_ARG_0_][_ARG_1_]
  if _ARG_4_ then
    _UPVALUE2_[_ARG_0_][#_UPVALUE0_[_ARG_0_] + 1] = {}
    _UPVALUE3_[_ARG_0_][#_UPVALUE0_[_ARG_0_] + 1] = {}
    _UPVALUE4_[_ARG_0_][#_UPVALUE0_[_ARG_0_] + 1] = 0
    for _FORV_18_ = 1, wallBlockCount do
      _UPVALUE3_[_ARG_0_][#_UPVALUE0_[_ARG_0_] + 1][_FORV_18_] = 0
    end
  else
    _UPVALUE2_[_ARG_0_][#_UPVALUE0_[_ARG_0_] + 1] = _UPVALUE2_[_ARG_0_][_ARG_1_]
    _UPVALUE3_[_ARG_0_][#_UPVALUE0_[_ARG_0_] + 1] = _UPVALUE3_[_ARG_0_][_ARG_1_]
    if _UPVALUE4_[_ARG_0_][_ARG_1_] then
      _UPVALUE4_[_ARG_0_][#_UPVALUE0_[_ARG_0_] + 1] = math.max(0, _UPVALUE4_[_ARG_0_][_ARG_1_] - _ARG_2_ * _UPVALUE5_)
    end
  end
  _UPVALUE0_[_ARG_0_][_ARG_1_][3] = _ARG_2_ - 1
  _UPVALUE2_[_ARG_0_][_ARG_1_] = nil
  _UPVALUE3_[_ARG_0_][_ARG_1_] = nil
  _UPVALUE4_[_ARG_0_][_ARG_1_] = nil
  if _UPVALUE2_[_ARG_0_][#_UPVALUE0_[_ARG_0_] + 1] then
    for _FORV_19_ = 1, #_UPVALUE2_[_ARG_0_][#_UPVALUE0_[_ARG_0_] + 1] do
      _UPVALUE2_[_ARG_0_][#_UPVALUE0_[_ARG_0_] + 1][_FORV_19_][4] = _UPVALUE2_[_ARG_0_][#_UPVALUE0_[_ARG_0_] + 1][_FORV_19_][4] - (_UPVALUE4_[_ARG_0_][_ARG_1_] - _UPVALUE4_[_ARG_0_][#_UPVALUE0_[_ARG_0_] + 1])
    end
  end
  if _FOR_ <= 0 and #_UPVALUE2_[_ARG_0_][#_UPVALUE0_[_ARG_0_] + 1] == 0 then
    _UPVALUE2_[_ARG_0_][#_UPVALUE0_[_ARG_0_] + 1] = generateShaftOres(_ARG_0_, #_UPVALUE0_[_ARG_0_] + 1)
  end
  refreshMineShafts(_ARG_0_)
  if _ARG_3_ then
  else
  end
  if not (_UPVALUE6_[_ARG_0_][_UPVALUE0_[_ARG_0_][_ARG_1_][1] + (_ARG_2_ - 1) * pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))) + psin((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4])))] and _UPVALUE6_[_ARG_0_][_UPVALUE0_[_ARG_0_][_ARG_1_][1] + (_ARG_2_ - 1) * pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))) + psin((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4])))][_UPVALUE0_[_ARG_0_][_ARG_1_][2] + (_ARG_2_ - 1) * psin((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))) - pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4])))]) then
    _UPVALUE0_[_ARG_0_][#_UPVALUE0_[_ARG_0_] + 1] = {
      _UPVALUE0_[_ARG_0_][_ARG_1_][1] + (_ARG_2_ - 1) * pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))) + psin((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))),
      _UPVALUE0_[_ARG_0_][_ARG_1_][2] + (_ARG_2_ - 1) * psin((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))) - pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))),
      1,
      (_UPVALUE0_[_ARG_0_][_ARG_1_][4] - 90) % 360,
      rngRandomSeed(),
      0
    }
    _UPVALUE1_[_ARG_0_][#_UPVALUE0_[_ARG_0_] + 1] = rngCreate((rngRandomSeed()))
    _UPVALUE3_[_ARG_0_][#_UPVALUE0_[_ARG_0_] + 1] = {}
    _UPVALUE4_[_ARG_0_][#_UPVALUE0_[_ARG_0_] + 1] = 0
    for _FORV_25_ = 1, wallBlockCount do
      _UPVALUE3_[_ARG_0_][#_UPVALUE0_[_ARG_0_] + 1][_FORV_25_] = 0
    end
    if not _FOR_[_ARG_0_][#_UPVALUE0_[_ARG_0_] + 1] then
      _UPVALUE2_[_ARG_0_][#_UPVALUE0_[_ARG_0_] + 1] = generateShaftOres(_ARG_0_, #_UPVALUE0_[_ARG_0_] + 1)
    end
  else
    _UPVALUE2_[_ARG_0_][_UPVALUE6_[_ARG_0_][_UPVALUE0_[_ARG_0_][_ARG_1_][1] + (_ARG_2_ - 1) * pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))) + psin((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4])))] and _UPVALUE6_[_ARG_0_][_UPVALUE0_[_ARG_0_][_ARG_1_][1] + (_ARG_2_ - 1) * pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))) + psin((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4])))][_UPVALUE0_[_ARG_0_][_ARG_1_][2] + (_ARG_2_ - 1) * psin((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))) - pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4])))]] = nil
    _UPVALUE3_[_ARG_0_][_UPVALUE6_[_ARG_0_][_UPVALUE0_[_ARG_0_][_ARG_1_][1] + (_ARG_2_ - 1) * pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))) + psin((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4])))] and _UPVALUE6_[_ARG_0_][_UPVALUE0_[_ARG_0_][_ARG_1_][1] + (_ARG_2_ - 1) * pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))) + psin((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4])))][_UPVALUE0_[_ARG_0_][_ARG_1_][2] + (_ARG_2_ - 1) * psin((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))) - pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4])))]] = nil
    _UPVALUE4_[_ARG_0_][_UPVALUE6_[_ARG_0_][_UPVALUE0_[_ARG_0_][_ARG_1_][1] + (_ARG_2_ - 1) * pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))) + psin((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4])))] and _UPVALUE6_[_ARG_0_][_UPVALUE0_[_ARG_0_][_ARG_1_][1] + (_ARG_2_ - 1) * pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))) + psin((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4])))][_UPVALUE0_[_ARG_0_][_ARG_1_][2] + (_ARG_2_ - 1) * psin((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))) - pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4])))]] = nil
  end
  if _ARG_3_ then
    table.insert(_UPVALUE7_[_ARG_0_], {
      _UPVALUE0_[_ARG_0_][_ARG_1_][1] + (_ARG_2_ - 1) * pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))),
      _UPVALUE0_[_ARG_0_][_ARG_1_][2] + (_ARG_2_ - 1) * psin((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))),
      math.floor(rngGetValue(_UPVALUE1_[_ARG_0_][#_UPVALUE0_[_ARG_0_] + 1]) * 5) + 1,
      (_UPVALUE0_[_ARG_0_][_ARG_1_][4] + 180) % 360
    })
  else
    table.insert(_UPVALUE7_[_ARG_0_], {
      _UPVALUE0_[_ARG_0_][_ARG_1_][1] + (_ARG_2_ - 1) * pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))),
      _UPVALUE0_[_ARG_0_][_ARG_1_][2] + (_ARG_2_ - 1) * psin((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))),
      math.floor(rngGetValue(_UPVALUE1_[_ARG_0_][#_UPVALUE0_[_ARG_0_] + 1]) * 5) + 1,
      _UPVALUE0_[_ARG_0_][_ARG_1_][4]
    })
  end
  if not _UPVALUE8_[_ARG_0_][_UPVALUE0_[_ARG_0_][_ARG_1_][1] + (_ARG_2_ - 1) * pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4])))] then
    _UPVALUE8_[_ARG_0_][_UPVALUE0_[_ARG_0_][_ARG_1_][1] + (_ARG_2_ - 1) * pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4])))] = {}
  end
  _UPVALUE8_[_ARG_0_][_UPVALUE0_[_ARG_0_][_ARG_1_][1] + (_ARG_2_ - 1) * pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4])))][_UPVALUE0_[_ARG_0_][_ARG_1_][2] + (_ARG_2_ - 1) * psin((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4])))] = #_UPVALUE7_[_ARG_0_]
  if 0 < #playersInMine[_ARG_0_] then
    triggerClientEvent(playersInMine[_ARG_0_], "gotNewMineShaft", client or resourceRoot, _ARG_0_, _UPVALUE0_[_ARG_0_][_ARG_1_][1] + (_ARG_2_ - 1) * pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))), _UPVALUE0_[_ARG_0_][_ARG_1_][2] + (_ARG_2_ - 1) * psin((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))), _UPVALUE0_[_ARG_0_][_ARG_1_][4], _ARG_1_, _ARG_2_, _ARG_3_, #_UPVALUE0_[_ARG_0_] + 1, #_UPVALUE0_[_ARG_0_] + 1, math.floor(rngGetValue(_UPVALUE1_[_ARG_0_][#_UPVALUE0_[_ARG_0_] + 1]) * 5) + 1, rngRandomSeed(), _UPVALUE2_[_ARG_0_][#_UPVALUE0_[_ARG_0_] + 1] or _UPVALUE2_[_ARG_0_][#_UPVALUE0_[_ARG_0_] + 1], _UPVALUE6_[_ARG_0_][_UPVALUE0_[_ARG_0_][_ARG_1_][1] + (_ARG_2_ - 1) * pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))) + psin((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4])))] and _UPVALUE6_[_ARG_0_][_UPVALUE0_[_ARG_0_][_ARG_1_][1] + (_ARG_2_ - 1) * pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))) + psin((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4])))][_UPVALUE0_[_ARG_0_][_ARG_1_][2] + (_ARG_2_ - 1) * psin((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))) - pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4])))], _ARG_4_)
  end
  refreshMineShafts(_ARG_0_)
  return #_UPVALUE0_[_ARG_0_] + 1
end
function refreshMineShafts(_ARG_0_)
  _UPVALUE0_[_ARG_0_] = {}
  _UPVALUE1_[_ARG_0_] = {}
  _UPVALUE2_[_ARG_0_] = {}
  for _FORV_4_ = 1, #_UPVALUE3_[_ARG_0_] do
    for _FORV_15_ = 1, _UPVALUE3_[_ARG_0_][_FORV_4_][3] do
      if not _UPVALUE0_[_ARG_0_][_UPVALUE3_[_ARG_0_][_FORV_4_][1]] then
        _UPVALUE0_[_ARG_0_][_UPVALUE3_[_ARG_0_][_FORV_4_][1]] = {}
      end
      _UPVALUE0_[_ARG_0_][_UPVALUE3_[_ARG_0_][_FORV_4_][1]][_UPVALUE3_[_ARG_0_][_FORV_4_][2]] = _FORV_4_
      if canExtendShaftAt(_UPVALUE3_[_ARG_0_][_FORV_4_][1], _UPVALUE3_[_ARG_0_][_FORV_4_][2]) then
        if not _UPVALUE2_[_ARG_0_][_UPVALUE3_[_ARG_0_][_FORV_4_][1]] then
          _UPVALUE2_[_ARG_0_][_UPVALUE3_[_ARG_0_][_FORV_4_][1]] = {}
        end
        _UPVALUE2_[_ARG_0_][_UPVALUE3_[_ARG_0_][_FORV_4_][1]][_UPVALUE3_[_ARG_0_][_FORV_4_][2]] = {_FORV_4_, _FORV_15_}
      end
    end
    if _UPVALUE4_[_ARG_0_][_FORV_4_] then
      if not _UPVALUE1_[_ARG_0_][_UPVALUE3_[_ARG_0_][_FORV_4_][1] + pcos((prad(_UPVALUE3_[_ARG_0_][_FORV_4_][4]))) - pcos((prad(_UPVALUE3_[_ARG_0_][_FORV_4_][4])))] then
        _UPVALUE1_[_ARG_0_][_UPVALUE3_[_ARG_0_][_FORV_4_][1] + pcos((prad(_UPVALUE3_[_ARG_0_][_FORV_4_][4]))) - pcos((prad(_UPVALUE3_[_ARG_0_][_FORV_4_][4])))] = {}
      end
      _UPVALUE1_[_ARG_0_][_UPVALUE3_[_ARG_0_][_FORV_4_][1] + pcos((prad(_UPVALUE3_[_ARG_0_][_FORV_4_][4]))) - pcos((prad(_UPVALUE3_[_ARG_0_][_FORV_4_][4])))][_UPVALUE3_[_ARG_0_][_FORV_4_][2] + psin((prad(_UPVALUE3_[_ARG_0_][_FORV_4_][4]))) - psin((prad(_UPVALUE3_[_ARG_0_][_FORV_4_][4])))] = _FORV_4_
    end
  end
end
function generateShaftOres(_ARG_0_, _ARG_1_)
  for _FORV_15_ = 1, wallBlockCount do
  end
  for _FORV_19_ = 1, math.floor((_UPVALUE0_[_ARG_0_][_ARG_1_][3] * _UPVALUE4_ - (_UPVALUE3_[_ARG_0_][_ARG_1_] + math.max(_UPVALUE2_[_ARG_0_][_ARG_1_][_FORV_15_], false or _UPVALUE2_[_ARG_0_][_ARG_1_][_FORV_15_]))) / wallMaximumDepth) do
    for _FORV_23_ = 1, _UPVALUE5_ do
      for _FORV_28_ = 1, _UPVALUE6_ do
        if rngGetValue(_UPVALUE1_[_ARG_0_][_ARG_1_]) > 0.9 then
          table.insert({}, {
            _UPVALUE0_[_ARG_0_][_ARG_1_][1] * _UPVALUE4_ + (_UPVALUE3_[_ARG_0_][_ARG_1_] + math.max(_UPVALUE2_[_ARG_0_][_ARG_1_][_FORV_15_], false or _UPVALUE2_[_ARG_0_][_ARG_1_][_FORV_15_]) - _UPVALUE4_ / 2) * pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))) + ((psin((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))) == 0 and _FORV_23_ - 1 or _UPVALUE5_ - _FORV_23_) * _UPVALUE7_ - _UPVALUE8_ / 2 + _UPVALUE7_ / 2) * psin((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))) + ((_FORV_19_ - 1) * wallMaximumDepth + 0.5 + (rngGetValue(_UPVALUE1_[_ARG_0_][_ARG_1_]) * 2 - 1) * 0.15) * pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))),
            _UPVALUE0_[_ARG_0_][_ARG_1_][2] * _UPVALUE4_ + (_UPVALUE3_[_ARG_0_][_ARG_1_] + math.max(_UPVALUE2_[_ARG_0_][_ARG_1_][_FORV_15_], false or _UPVALUE2_[_ARG_0_][_ARG_1_][_FORV_15_]) - _UPVALUE4_ / 2) * psin((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))) + ((psin((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))) == 0 and _FORV_23_ - 1 or _UPVALUE5_ - _FORV_23_) * _UPVALUE7_ - _UPVALUE8_ / 2 + _UPVALUE7_ / 2) * pcos((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))) + ((_FORV_19_ - 1) * wallMaximumDepth + 0.5 + (rngGetValue(_UPVALUE1_[_ARG_0_][_ARG_1_]) * 2 - 1) * 0.15) * psin((prad(_UPVALUE0_[_ARG_0_][_ARG_1_][4]))),
            wallMeshHeight / 2 + ((_FORV_28_ - 1) * _UPVALUE9_ - _UPVALUE10_ / 2 + _UPVALUE9_ / 2),
            _UPVALUE3_[_ARG_0_][_ARG_1_] + math.max(_UPVALUE2_[_ARG_0_][_ARG_1_][_FORV_15_], false or _UPVALUE2_[_ARG_0_][_ARG_1_][_FORV_15_]) + ((_FORV_19_ - 1) * wallMaximumDepth + 0.5 + (rngGetValue(_UPVALUE1_[_ARG_0_][_ARG_1_]) * 2 - 1) * 0.15),
            4 - math.floor(_FORV_23_ / 2 + 0.5) + math.floor(_FORV_28_ / 2) * 3,
            chooseRandomOre((rngGetValue(_UPVALUE1_[_ARG_0_][_ARG_1_]))),
            (math.floor(_UPVALUE3_[_ARG_0_][_ARG_1_] / _UPVALUE4_) + 1 - 1) * _UPVALUE11_ + (_FORV_19_ - 1) * _UPVALUE12_ + ((_FORV_23_ - 1) * _UPVALUE6_ + _FORV_28_)
          })
        end
      end
    end
  end
  return {}
end
function initOres()
  for _FORV_5_, _FORV_6_ in pairs(oreTypes) do
    if not _FORV_6_.fixedBasePrice then
      _UPVALUE0_ = _UPVALUE0_ + _FORV_6_.itemProbability
      if _FORV_6_.meltingPoint then
      else
      end
    end
  end
  for _FORV_5_, _FORV_6_ in pairs(oreTypes) do
    if _FORV_6_.fixedBasePrice then
      _FORV_6_.orePrice = _FORV_6_.fixedBasePrice
    elseif _FORV_6_.meltingPoint then
      _FORV_6_.orePrice = 10000 / (_FORV_6_.itemProbability / _UPVALUE0_) / 2.25 + 2500
    else
      _FORV_6_.orePrice = 10000 / (_FORV_6_.itemProbability / _UPVALUE0_) / 6
    end
    _FORV_6_.orePrice = math.floor(_FORV_6_.orePrice * globalPriceMultiplier + 0.5)
  end
  _UPVALUE1_ = _UPVALUE0_ * (25 / (0 + 1 + (0 + 1))) * 1.4
  _UPVALUE0_ = _UPVALUE0_ + _UPVALUE1_
  for _FORV_6_, _FORV_7_ in pairs(oreTypes) do
    if _FORV_7_.fixedBasePrice then
      _UPVALUE0_ = _UPVALUE0_ + _FORV_7_.itemProbability
    end
  end
end
function getOrePrice(_ARG_0_)
  for _FORV_4_, _FORV_5_ in pairs(oreTypes) do
    if _FORV_5_.forexIndex == _ARG_0_ then
      return _FORV_5_.orePrice
    end
  end
end
function chooseRandomOre(_ARG_0_)
  if _UPVALUE0_ * (_ARG_0_ or math.random()) < _UPVALUE1_ then
    return "rock"
  end
  for _FORV_6_, _FORV_7_ in pairs(oreTypes) do
    if _UPVALUE0_ * (_ARG_0_ or math.random()) <= _UPVALUE1_ + _FORV_7_.itemProbability then
      if _FORV_6_ == "chest" and not _UPVALUE2_.minerChest or _FORV_6_ == "seerconium" and not _UPVALUE2_.minerEvent then
        break
      end
      return _FORV_6_
    end
  end
  return "rock"
end
function scheduleMineSaving()
  if _UPVALUE0_ or not next(loadedMinesData) then
    return
  end
  _UPVALUE0_ = getTickCount()
  _UPVALUE1_ = coroutine.create(doMineSaving)
  _UPVALUE2_ = setTimer(function()
    if coroutine.status(_UPVALUE0_) == "suspended" then
      _UPVALUE1_ = getTickCount()
      coroutine.resume(_UPVALUE0_)
    elseif coroutine.status(_UPVALUE0_) == "dead" then
      if isTimer(_UPVALUE2_) then
        killTimer(_UPVALUE2_)
      end
      _UPVALUE0_ = nil
      _UPVALUE1_ = nil
      _UPVALUE2_ = nil
    end
  end, 1000, 0)
end
function doMineSaving()
  for _FORV_3_ in pairs(loadedMinesData) do
    serializeMine(_FORV_3_)
  end
end
function checkMineSavingTime(_ARG_0_)
  if not loadedMinesData[_ARG_0_] then
    return
  end
  if not coroutine.running() then
    return
  end
  if getTickCount() - _UPVALUE0_ <= 100 then
    return
  end
  coroutine.yield()
end
function serializeMine(_ARG_0_, _ARG_1_)
  if loadedMinesData[_ARG_0_] then
    if (_UPVALUE0_[_ARG_0_] and getTickCount() - _UPVALUE0_[_ARG_0_] or math.huge) > (_ARG_1_ and 0 or 60000) and fileCreate("data/" .. _ARG_0_ .. ".see") then
      _UPVALUE0_[_ARG_0_] = getTickCount()
      if next(_UPVALUE1_[_ARG_0_]) then
        fileWrite(fileCreate("data/" .. _ARG_0_ .. ".see"), "#SHAFTS\n")
        for _FORV_8_, _FORV_9_ in ipairs(_UPVALUE1_[_ARG_0_]) do
          fileWrite(fileCreate("data/" .. _ARG_0_ .. ".see"), table.concat(_FORV_9_, " ") .. "\n")
        end
        checkMineSavingTime(_ARG_0_)
      end
      if next(_UPVALUE2_[_ARG_0_]) then
        fileWrite(fileCreate("data/" .. _ARG_0_ .. ".see"), "#DEPTHS\n")
        for _FORV_8_, _FORV_9_ in pairs(_UPVALUE2_[_ARG_0_]) do
          fileWrite(fileCreate("data/" .. _ARG_0_ .. ".see"), _FORV_8_ .. " " .. table.concat(_FORV_9_, " ") .. "\n")
        end
        checkMineSavingTime(_ARG_0_)
      end
      if next(_UPVALUE3_[_ARG_0_]) then
        fileWrite(fileCreate("data/" .. _ARG_0_ .. ".see"), "#LENGTHS\n")
        for _FORV_8_, _FORV_9_ in pairs(_UPVALUE3_[_ARG_0_]) do
          fileWrite(fileCreate("data/" .. _ARG_0_ .. ".see"), table.concat({_FORV_8_, _FORV_9_}, " ") .. "\n")
        end
        checkMineSavingTime(_ARG_0_)
      end
      if next(_UPVALUE4_[_ARG_0_]) then
        fileWrite(fileCreate("data/" .. _ARG_0_ .. ".see"), "#JUNCTIONS\n")
        for _FORV_8_, _FORV_9_ in ipairs(_UPVALUE4_[_ARG_0_]) do
          fileWrite(fileCreate("data/" .. _ARG_0_ .. ".see"), table.concat(_FORV_9_, " ") .. "\n")
        end
        checkMineSavingTime(_ARG_0_)
      end
      if next(_UPVALUE2_[_ARG_0_]) and next(_UPVALUE5_[_ARG_0_]) then
        fileWrite(fileCreate("data/" .. _ARG_0_ .. ".see"), "#ORES\n")
        for _FORV_8_ in pairs(_UPVALUE2_[_ARG_0_]) do
          if _UPVALUE5_[_ARG_0_][_FORV_8_] then
            for _FORV_12_, _FORV_13_ in ipairs(_UPVALUE5_[_ARG_0_][_FORV_8_]) do
              fileWrite(fileCreate("data/" .. _ARG_0_ .. ".see"), _FORV_8_ .. " " .. table.concat(_FORV_13_, " ") .. "\n")
            end
          end
        end
        checkMineSavingTime(_ARG_0_)
      end
      if next(_UPVALUE6_[_ARG_0_]) then
        fileWrite(fileCreate("data/" .. _ARG_0_ .. ".see"), "#FIXORES\n")
        for _FORV_8_, _FORV_9_ in pairs(_UPVALUE6_[_ARG_0_]) do
          if _FORV_9_[4] == "player" then
            fileWrite(fileCreate("data/" .. _ARG_0_ .. ".see"), table.concat({
              _FORV_9_[1],
              _FORV_9_[2],
              _FORV_9_[3]
            }, " ") .. "\n")
          else
            fileWrite(fileCreate("data/" .. _ARG_0_ .. ".see"), table.concat(_FORV_9_, " ") .. "\n")
          end
        end
        checkMineSavingTime(_ARG_0_)
      end
      if next(_UPVALUE7_[_ARG_0_]) then
        fileWrite(fileCreate("data/" .. _ARG_0_ .. ".see"), "#RAILS\n")
        for _FORV_8_, _FORV_9_ in ipairs(_UPVALUE7_[_ARG_0_]) do
          if #_FORV_9_ == 5 then
            fileWrite(fileCreate("data/" .. _ARG_0_ .. ".see"), table.concat({
              _FORV_9_[1],
              _FORV_9_[2],
              _FORV_9_[3],
              _FORV_9_[4],
              _FORV_9_[5] and 1 or 0
            }, " ") .. "\n")
          else
            fileWrite(fileCreate("data/" .. _ARG_0_ .. ".see"), table.concat({
              _FORV_9_[1],
              _FORV_9_[2],
              _FORV_9_[3],
              _FORV_9_[4] and 1 or 0
            }, " ") .. "\n")
          end
        end
        checkMineSavingTime(_ARG_0_)
      end
      if next(_UPVALUE8_[_ARG_0_]) then
        fileWrite(fileCreate("data/" .. _ARG_0_ .. ".see"), "#RAILSWITCHES\n")
        for _FORV_8_, _FORV_9_ in ipairs(_UPVALUE8_[_ARG_0_]) do
          fileWrite(fileCreate("data/" .. _ARG_0_ .. ".see"), table.concat(_FORV_9_, " ") .. "\n")
        end
        checkMineSavingTime(_ARG_0_)
      end
      if next(_UPVALUE9_[_ARG_0_]) then
        fileWrite(fileCreate("data/" .. _ARG_0_ .. ".see"), "#RAILSWITCHSTATES\n")
        for _FORV_8_, _FORV_9_ in pairs(_UPVALUE9_[_ARG_0_]) do
          fileWrite(fileCreate("data/" .. _ARG_0_ .. ".see"), table.concat({_FORV_8_, _FORV_9_}, " ") .. "\n")
        end
        checkMineSavingTime(_ARG_0_)
      end
      if _UPVALUE10_[_ARG_0_] then
        fileWrite(fileCreate("data/" .. _ARG_0_ .. ".see"), "#TRAIN\n")
        fileWrite(fileCreate("data/" .. _ARG_0_ .. ".see"), table.concat({
          _UPVALUE10_[_ARG_0_].trackId or 1,
          _UPVALUE10_[_ARG_0_].routeId or -1,
          _UPVALUE10_[_ARG_0_].trackPosition or 0,
          _UPVALUE10_[_ARG_0_].trackDirection or 1,
          _UPVALUE10_[_ARG_0_].fuelLevel or 0,
          _UPVALUE10_[_ARG_0_].jerryContent or 0
        }, " ") .. "\n")
        checkMineSavingTime(_ARG_0_)
      end
      if _UPVALUE11_[_ARG_0_] then
        fileWrite(fileCreate("data/" .. _ARG_0_ .. ".see"), "#INVENTORY\n")
        fileWrite(fileCreate("data/" .. _ARG_0_ .. ".see"), table.concat({
          _UPVALUE11_[_ARG_0_].railIrons or 0,
          _UPVALUE11_[_ARG_0_].railWoods or 0,
          _UPVALUE11_[_ARG_0_].mineLamps or 0,
          _UPVALUE11_[_ARG_0_].subCartNum or 0,
          _UPVALUE11_[_ARG_0_].dieselLoco and 1 or 0,
          _UPVALUE11_[_ARG_0_].fuelTankLevel or 0
        }, " ") .. "\n")
        checkMineSavingTime(_ARG_0_)
      end
      if next(_UPVALUE12_[_ARG_0_]) then
        fileWrite(fileCreate("data/" .. _ARG_0_ .. ".see"), "#BUFFER\n")
        for _FORV_10_, _FORV_11_ in pairs(_UPVALUE12_[_ARG_0_]) do
          fileWrite(fileCreate("data/" .. _ARG_0_ .. ".see"), table.concat({_FORV_10_, _FORV_11_}, " ") .. "\n")
        end
        checkMineSavingTime(_ARG_0_)
      end
      if next(_UPVALUE13_[_ARG_0_]) then
        fileWrite(fileCreate("data/" .. _ARG_0_ .. ".see"), "#FOUNDRY\n")
        for _FORV_10_, _FORV_11_ in pairs(_UPVALUE13_[_ARG_0_]) do
          fileWrite(fileCreate("data/" .. _ARG_0_ .. ".see"), table.concat({_FORV_10_, _FORV_11_}, " ") .. "\n")
        end
        checkMineSavingTime(_ARG_0_)
      end
      if next(_UPVALUE14_[_ARG_0_]) then
        fileWrite(fileCreate("data/" .. _ARG_0_ .. ".see"), "#LIGHTS\n")
        for _FORV_10_ in pairs(_UPVALUE14_[_ARG_0_]) do
          for _FORV_14_ in pairs(_UPVALUE14_[_ARG_0_][_FORV_10_]) do
            fileWrite(fileCreate("data/" .. _ARG_0_ .. ".see"), table.concat({_FORV_10_, _FORV_14_}, " ") .. "\n")
          end
        end
        checkMineSavingTime(_ARG_0_)
      end
      if mineOrders[_ARG_0_] then
        fileWrite(fileCreate("data/" .. _ARG_0_ .. ".see"), "#ORDER\n")
        for _FORV_11_, _FORV_12_ in pairs(mineOrders[_ARG_0_]) do
          fileWrite(fileCreate("data/" .. _ARG_0_ .. ".see"), table.concat({_FORV_11_, _FORV_12_}, " ") .. "\n")
        end
        if mineOrderPaid[_ARG_0_] then
          fileWrite(fileCreate("data/" .. _ARG_0_ .. ".see"), "paid\n")
        end
        checkMineSavingTime(_ARG_0_)
      end
      if loadedMinesData[_ARG_0_] and next(loadedMinesData[_ARG_0_].workerPermissions) then
        fileWrite(fileCreate("data/" .. _ARG_0_ .. ".see"), "#PERMISSIONS\n")
        for _FORV_12_, _FORV_13_ in pairs(loadedMinesData[_ARG_0_].workerNames) do
          fileWrite(fileCreate("data/" .. _ARG_0_ .. ".see"), table.concat({
            _FORV_12_,
            _FORV_13_:gsub(" ", "_"),
            loadedMinesData[_ARG_0_].workerPermissions[_FORV_12_] or 0
          }, " ") .. "\n")
        end
        checkMineSavingTime(_ARG_0_)
      end
      fileClose((fileCreate("data/" .. _ARG_0_ .. ".see")))
      if not loadedMinesData[_ARG_0_] then
        fileDelete("data/" .. _ARG_0_ .. ".see")
      end
      return true
    end
  end
  return false
end
function parseMine(_ARG_0_)
  if not fileExists("data/" .. _ARG_0_ .. ".see") then
    return false
  end
  if fileOpen("data/" .. _ARG_0_ .. ".see", true) then
    if fileGetContents(fileOpen("data/" .. _ARG_0_ .. ".see", true), false) then
      for _FORV_9_, _FORV_10_ in ipairs(split(fileGetContents(fileOpen("data/" .. _ARG_0_ .. ".see", true), false), "\n")) do
        if string.sub(_FORV_10_, 1, 1) == "#" then
        elseif _FORV_10_ == "#SHAFTS" then
          if not _UPVALUE0_[_ARG_0_] then
            _UPVALUE0_[_ARG_0_] = {}
          end
          for _FORV_15_ = 1, #split(_FORV_10_, " ") do
            split(_FORV_10_, " ")[_FORV_15_] = tonumber(split(_FORV_10_, " ")[_FORV_15_])
          end
          _FOR_.insert(_UPVALUE0_[_ARG_0_], (split(_FORV_10_, " ")))
        elseif _FORV_10_ == "#DEPTHS" then
          if not _UPVALUE1_[_ARG_0_] then
            _UPVALUE1_[_ARG_0_] = {}
          end
          if not _UPVALUE1_[_ARG_0_][tonumber(split(_FORV_10_, " ")[1])] then
            _UPVALUE1_[_ARG_0_][tonumber(split(_FORV_10_, " ")[1])] = {}
          end
          for _FORV_16_ = 1, wallBlockCount do
            _UPVALUE1_[_ARG_0_][tonumber(split(_FORV_10_, " ")[1])][_FORV_16_] = tonumber(split(_FORV_10_, " ")[1 + _FORV_16_])
          end
        elseif _FORV_10_ == "#LENGTHS" then
          if not _UPVALUE2_[_ARG_0_] then
            _UPVALUE2_[_ARG_0_] = {}
          end
          _UPVALUE2_[_ARG_0_][tonumber(split(_FORV_10_, " ")[1])] = tonumber(split(_FORV_10_, " ")[2])
        elseif _FORV_10_ == "#JUNCTIONS" then
          if not _UPVALUE3_[_ARG_0_] then
            _UPVALUE3_[_ARG_0_] = {}
          end
          for _FORV_15_ = 1, #split(_FORV_10_, " ") do
            split(_FORV_10_, " ")[_FORV_15_] = tonumber(split(_FORV_10_, " ")[_FORV_15_])
          end
          _FOR_.insert(_UPVALUE3_[_ARG_0_], (split(_FORV_10_, " ")))
        elseif _FORV_10_ == "#ORES" then
          if not _UPVALUE4_[_ARG_0_] then
            _UPVALUE4_[_ARG_0_] = {}
          end
          if not _UPVALUE4_[_ARG_0_][tonumber(table.remove(split(_FORV_10_, " "), 1))] then
            _UPVALUE4_[_ARG_0_][tonumber(table.remove(split(_FORV_10_, " "), 1))] = {}
          end
          for _FORV_16_ = 1, #split(_FORV_10_, " ") do
            split(_FORV_10_, " ")[_FORV_16_] = tonumber(split(_FORV_10_, " ")[_FORV_16_]) or split(_FORV_10_, " ")[_FORV_16_]
          end
          _FOR_.insert(_UPVALUE4_[_ARG_0_][tonumber(table.remove(split(_FORV_10_, " "), 1))], (split(_FORV_10_, " ")))
        elseif _FORV_10_ == "#FIXORES" then
          if not _UPVALUE5_[_ARG_0_] then
            _UPVALUE5_[_ARG_0_] = {}
          end
          table.insert(_UPVALUE5_[_ARG_0_], {
            unpack(split(_FORV_10_, " ")) and tonumber(unpack(split(_FORV_10_, " "))),
            unpack(split(_FORV_10_, " ")) and tonumber(unpack(split(_FORV_10_, " "))),
            unpack(split(_FORV_10_, " "))
          })
          if not _UPVALUE6_[_ARG_0_] then
            _UPVALUE6_[_ARG_0_] = {}
          end
          table.insert(_UPVALUE6_[_ARG_0_], {
            #_UPVALUE5_[_ARG_0_],
            getTickCount()
          })
          if unpack(split(_FORV_10_, " ")) == "cart" then
            if not _UPVALUE7_[_ARG_0_] then
              _UPVALUE7_[_ARG_0_] = {}
            end
            if not _UPVALUE7_[_ARG_0_][unpack(split(_FORV_10_, " ")) and tonumber(unpack(split(_FORV_10_, " ")))] then
              _UPVALUE7_[_ARG_0_][unpack(split(_FORV_10_, " ")) and tonumber(unpack(split(_FORV_10_, " ")))] = 1
            else
              _UPVALUE7_[_ARG_0_][unpack(split(_FORV_10_, " ")) and tonumber(unpack(split(_FORV_10_, " ")))] = _UPVALUE7_[_ARG_0_][unpack(split(_FORV_10_, " ")) and tonumber(unpack(split(_FORV_10_, " ")))] + 1
            end
          end
          checkFixOreTimer()
        elseif _FORV_10_ == "#RAILS" then
          if not _UPVALUE8_[_ARG_0_] then
            _UPVALUE8_[_ARG_0_] = {}
          end
          for _FORV_15_ = 1, #split(_FORV_10_, " ") do
            split(_FORV_10_, " ")[_FORV_15_] = tonumber(split(_FORV_10_, " ")[_FORV_15_])
            if _FORV_15_ == #split(_FORV_10_, " ") then
              split(_FORV_10_, " ")[_FORV_15_] = split(_FORV_10_, " ")[_FORV_15_] == 1
            end
          end
          _FOR_.insert(_UPVALUE8_[_ARG_0_], (split(_FORV_10_, " ")))
        elseif _FORV_10_ == "#RAILSWITCHES" then
          if not _UPVALUE9_[_ARG_0_] then
            _UPVALUE9_[_ARG_0_] = {}
          end
          for _FORV_15_ = 1, #split(_FORV_10_, " ") do
            split(_FORV_10_, " ")[_FORV_15_] = tonumber(split(_FORV_10_, " ")[_FORV_15_])
          end
          _FOR_.insert(_UPVALUE9_[_ARG_0_], (split(_FORV_10_, " ")))
        elseif _FORV_10_ == "#RAILSWITCHSTATES" then
          if not _UPVALUE10_[_ARG_0_] then
            _UPVALUE10_[_ARG_0_] = {}
          end
          _UPVALUE10_[_ARG_0_][tonumber(split(_FORV_10_, " ")[1])] = tonumber(split(_FORV_10_, " ")[2])
        elseif _FORV_10_ == "#TRAIN" then
          _UPVALUE11_[_ARG_0_] = {
            trackId = tonumber(split(_FORV_10_, " ")[1]) or 1,
            routeId = tonumber(split(_FORV_10_, " ")[2]) or -1,
            trackPosition = tonumber(split(_FORV_10_, " ")[3]) or 0,
            trackDirection = tonumber(split(_FORV_10_, " ")[4]) or 1,
            fuelLevel = tonumber(split(_FORV_10_, " ")[5]) or 0,
            jerryContent = tonumber(split(_FORV_10_, " ")[6]) or 0
          }
        elseif _FORV_10_ == "#INVENTORY" then
          _UPVALUE12_[_ARG_0_] = {
            railIrons = tonumber(split(_FORV_10_, " ")[1]),
            railWoods = tonumber(split(_FORV_10_, " ")[2]),
            mineLamps = tonumber(split(_FORV_10_, " ")[3]),
            subCartNum = tonumber(split(_FORV_10_, " ")[4]),
            dieselLoco = split(_FORV_10_, " ")[5] == "1",
            fuelTankLevel = tonumber(split(_FORV_10_, " ")[6]) or 0
          }
        elseif _FORV_10_ == "#BUFFER" then
          if not _UPVALUE13_[_ARG_0_] then
            _UPVALUE13_[_ARG_0_] = {}
          end
          _UPVALUE13_[_ARG_0_][split(_FORV_10_, " ")[1]] = tonumber(split(_FORV_10_, " ")[2])
        elseif _FORV_10_ == "#FOUNDRY" then
          if not _UPVALUE14_[_ARG_0_] then
            _UPVALUE14_[_ARG_0_] = {}
          end
          _UPVALUE14_[_ARG_0_][split(_FORV_10_, " ")[1]] = tonumber(split(_FORV_10_, " ")[2])
        elseif _FORV_10_ == "#LIGHTS" then
          if not _UPVALUE15_[_ARG_0_] then
            _UPVALUE15_[_ARG_0_] = {}
          end
          if not _UPVALUE15_[_ARG_0_][tonumber(split(_FORV_10_, " ")[1])] then
            _UPVALUE15_[_ARG_0_][tonumber(split(_FORV_10_, " ")[1])] = {}
          end
          _UPVALUE15_[_ARG_0_][tonumber(split(_FORV_10_, " ")[1])][tonumber(split(_FORV_10_, " ")[2])] = true
        elseif _FORV_10_ == "#PERMISSIONS" then
          if not loadedMinesData[_ARG_0_].workerNames then
            loadedMinesData[_ARG_0_].workerNames = {}
          end
          if not loadedMinesData[_ARG_0_].workerPermissions then
            loadedMinesData[_ARG_0_].workerPermissions = {}
          end
          loadedMinesData[_ARG_0_].workerNames[tonumber(split(_FORV_10_, " ")[1])] = split(_FORV_10_, " ")[2]
          loadedMinesData[_ARG_0_].workerPermissions[tonumber(split(_FORV_10_, " ")[1])] = tonumber(split(_FORV_10_, " ")[3])
        elseif _FORV_10_ == "#ORDER" then
          if not mineOrders[_ARG_0_] then
            mineOrders[_ARG_0_] = {}
          end
          if split(_FORV_10_, " ")[1] == "paid" then
            mineOrderPaid[_ARG_0_] = true
          else
            mineOrders[_ARG_0_][split(_FORV_10_, " ")[1]] = tonumber(split(_FORV_10_, " ")[2])
          end
        end
      end
    end
    fileClose((fileOpen("data/" .. _ARG_0_ .. ".see", true)))
    collectgarbage()
    return true
  end
  return false
end
addCommandHandler("setmineinventory", function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  if exports.see_permission:hasPermission(_ARG_0_, _ARG_1_) then
    if not playersCurrentMine[_ARG_0_] then
      exports.see_gui:showInfobox(_ARG_0_, "e", "Nem vagy bányában!")
    elseif loadedMinesData[playersCurrentMine[_ARG_0_]] then
      if _ARG_2_ ~= "railIrons" and _ARG_2_ ~= "railWoods" and _ARG_2_ ~= "mineLamps" then
        outputChatBox("[color=orange][Használat]: [color=white]/" .. _ARG_1_ .. " [railIrons | railWoods | mineLamps] [Mennyiség]", _ARG_0_, 255, 255, 255, true)
      else
        if _ARG_2_ == "railIrons" then
        elseif _ARG_2_ == "railWoods" then
        elseif _ARG_2_ == "mineLamps" then
        end
        _UPVALUE0_[playersCurrentMine[_ARG_0_]][_ARG_2_] = math.min(math.min(math.min(math.max(0, math.floor(tonumber(_ARG_3_) or 0)), 2 * railIronStack), 2 * railWoodStack), 2 * mineLampStack)
        if 0 < #playersInMine[playersCurrentMine[_ARG_0_]] then
          triggerClientEvent(playersInMine[playersCurrentMine[_ARG_0_]], "updateMineInventory", _ARG_0_, playersCurrentMine[_ARG_0_], _ARG_2_, (math.min(math.min(math.min(math.max(0, math.floor(tonumber(_ARG_3_) or 0)), 2 * railIronStack), 2 * railWoodStack), 2 * mineLampStack)))
        end
        exports.see_gui:showInfobox(_ARG_0_, "s", "A kiválasztott tétel sikeresen módosítva.")
      end
    end
  end
end)
addCommandHandler("setminefueltank", function(_ARG_0_, _ARG_1_, _ARG_2_)
  if exports.see_permission:hasPermission(_ARG_0_, _ARG_1_) then
    if not playersCurrentMine[_ARG_0_] then
      exports.see_gui:showInfobox(_ARG_0_, "e", "Nem vagy bányában!")
    elseif loadedMinesData[playersCurrentMine[_ARG_0_]] then
      _ARG_2_ = tonumber(_ARG_2_)
      if not _ARG_2_ then
        outputChatBox("[color=orange][Használat]: [color=white]/" .. _ARG_1_ .. " [Liter]", _ARG_0_, 255, 255, 255, true)
      else
        _UPVALUE0_[playersCurrentMine[_ARG_0_]].fuelTankLevel = _ARG_2_
        if _UPVALUE0_[playersCurrentMine[_ARG_0_]].fuelTankLevel < 0 then
          _UPVALUE0_[playersCurrentMine[_ARG_0_]].fuelTankLevel = 0
        elseif _UPVALUE0_[playersCurrentMine[_ARG_0_]].fuelTankLevel > fuelTankCapacity then
          _UPVALUE0_[playersCurrentMine[_ARG_0_]].fuelTankLevel = fuelTankCapacity
        end
        if 0 < #playersInMine[playersCurrentMine[_ARG_0_]] then
          triggerClientEvent(playersInMine[playersCurrentMine[_ARG_0_]], "updateMineInventory", _ARG_0_, playersCurrentMine[_ARG_0_], "fuelTankLevel", _UPVALUE0_[playersCurrentMine[_ARG_0_]].fuelTankLevel)
        end
        exports.see_gui:showInfobox(_ARG_0_, "s", "Az üzemanyagtartály szintje sikeresen módosítva.")
      end
    end
  end
end)
addCommandHandler("mineevent", function(_ARG_0_, _ARG_1_, _ARG_2_)
  if exports.see_permission:hasPermission(_ARG_0_, "mineevent") then
    _ARG_2_ = tonumber(_ARG_2_)
    if not _ARG_2_ or _ARG_2_ < 0 or _ARG_2_ > 2 then
      outputChatBox("[color=orange][Használat]: [color=white]/" .. _ARG_1_ .. " [0: Nincs | 1: Miner Event | 2: Miner Chest Event]", _ARG_0_, 255, 255, 255, true)
    else
      _UPVALUE0_.minerEvent = _ARG_2_ == 1
      _UPVALUE0_.minerChest = _ARG_2_ == 2
      if not _UPVALUE0_.minerEvent and _UPVALUE0_.minerEvent then
        outputChatBox("[color=blue][SeeMTA - Bánya]: [color=white]Miner Event [color=red]deaktiválva.", _ARG_0_, 255, 255, 255, true)
      elseif not _UPVALUE0_.minerChest and _UPVALUE0_.minerChest then
        outputChatBox("[color=blue][SeeMTA - Bánya]: [color=white]Miner Chest Event [color=red]deaktiválva.", _ARG_0_, 255, 255, 255, true)
      end
      if _UPVALUE0_.minerEvent then
        outputChatBox("[color=blue][SeeMTA - Bánya]: [color=white]Miner Event [color=green]aktiválva.", _ARG_0_, 255, 255, 255, true)
      elseif _UPVALUE0_.minerChest then
        outputChatBox("[color=blue][SeeMTA - Bánya]: [color=white]Miner Chest Event [color=green]aktiválva.", _ARG_0_, 255, 255, 255, true)
      end
    end
  end
end)
addCommandHandler("forcesavemine", function(_ARG_0_, _ARG_1_, _ARG_2_)
  if exports.see_permission:hasPermission(_ARG_0_, _ARG_1_) then
    _ARG_2_ = tonumber(_ARG_2_) or playersCurrentMine[_ARG_0_]
    if not _ARG_2_ then
      outputChatBox("[color=orange][Használat]: [color=white]/" .. _ARG_1_ .. " [ID]", _ARG_0_, 255, 255, 255, true)
    elseif not loadedMinesData[_ARG_2_] then
      outputChatBox("[color=red][SeeMTA]: [color=white]A kiválasztott bánya nem található!", _ARG_0_, 255, 255, 255, true)
    elseif serializeMine(_ARG_2_, true) then
      outputChatBox("[color=green][SeeMTA]: [color=white]A kiválasztott bánya sikeresen mentésre került.", _ARG_0_, 255, 255, 255, true)
    else
      outputChatBox("[color=red][SeeMTA]: [color=white]A bánya mentése meghiúsult!", _ARG_0_, 255, 255, 255, true)
    end
  end
end)
addCommandHandler("scheduleminesaving", function(_ARG_0_, _ARG_1_, _ARG_2_)
  if exports.see_permission:hasPermission(_ARG_0_, "forcesavemine") then
    scheduleMineSaving()
  end
end)
