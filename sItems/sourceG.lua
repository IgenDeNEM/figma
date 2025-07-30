defaultSettings = {
  sqlTable = "items",
  characterId = "char.ID",
  vehicleId = "vehicle.dbID",
  objectId = "object.dbID",
  inventorySlots = "inventorySlots",
  slotLimit = 50,
  width = 10,
  weightLimit = {
    player = 20,
    vehicle = 100,
    object = 50
  },
  slotBoxWidth = 36,
  slotBoxHeight = 36
}
local vehicleWeights = {
  [424] = 15,
  [585] = 50,
  [405] = 50,
  [490] = 70,
  [580] = 50,
  [596] = 50,
  [483] = 100,
  [492] = 50,
  [421] = 50,
  [551] = 50,
  [445] = 50,
  [598] = 50,
  [491] = 50,
  [522] = 5,
  [400] = 70,
  [508] = 100,
  [576] = 50,
  [554] = 70,
  [521] = 5,
  [413] = 100,
  [605] = 50,
  [495] = 70,
  [586] = 5,
  [463] = 5,
  [462] = 5,
  [470] = 100,
  [438] = 70,
  [404] = 70,
  [582] = 100,
  [579] = 70,
  [597] = 70,
  [458] = 70,
  [471] = 5,
  [468] = 5,
  [416] = 70,
  [407] = 70,
  [454] = 100,
  [473] = 30,
  [484] = 100,
  [453] = 100,
  [487] = 100,
  [497] = 100,
  [461] = 5,
  [481] = 1,
  [509] = 1,
  [510] = 1,
  [568] = 15,
  [571] = 1,
  [581] = 5,
  [583] = 5,
  [588] = 100,
  [609] = 100
}
vehicleSlots = {
  [424] = 10,
  [526] = 40,
  [533] = 40,
  [602] = 40,
  [599] = 40,
  [522] = 10,
  [508] = 60,
  [521] = 10,
  [586] = 10,
  [463] = 10,
  [462] = 10,
  [471] = 10,
  [468] = 10,
  [473] = 30,
  [461] = 10,
  [481] = 10,
  [509] = 10,
  [510] = 10,
  [568] = 10,
  [571] = 10,
  [581] = 10,
  [583] = 20
}
function calculateSafeWeightLimit(dbId)
  local data = storedSafes[dbId]
  if data then
    if data.safeType == 1 then
      return 50
    elseif data.safeType == 2 then
      return 110
    elseif data.safeType == 3 then
      return 250
    end
  end
  return defaultSettings.weightLimit.object
end
function getWeightLimit(theType, element)
  if theType == "object" then
    local dbId = getElementData(element, defaultSettings.objectId)
    if dbId and storedSafes[dbId] then
      return calculateSafeWeightLimit(dbId)
    end
  end
  return vehicleWeights[getElementModel(element)] or defaultSettings.weightLimit[theType]
end
function getSlotLimit(theType, element)
  if theType == "object" then
    local dbId = getElementData(element, defaultSettings.objectId)
    if dbId then
      local data = storedSafes[dbId]
      if data then
        if data.safeType == 1 then
          return 50
        elseif data.safeType == 2 then
          return 80
        elseif data.safeType == 3 then
          return 120
        end
      end
    end
  elseif theType == "vehicle" then
    local model = getElementModel(element)
    if vehicleSlots[model] then
      return vehicleSlots[model]
    end
  end
  return defaultSettings.slotLimit
end
