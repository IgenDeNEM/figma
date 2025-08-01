local validDrivebyWeapons = {
  [22] = true,
  [23] = true,
  [24] = true,
  [25] = true,
  [26] = true,
  [27] = true,
  [28] = true,
  [29] = true,
  [32] = true,
  [30] = true,
  [31] = true,
  [32] = true,
  [33] = true,
  [38] = true
}
function setDriverDrivebyAbility(...)
  local newTable = {
    ...
  }
  for key, weaponID in ipairs(newTable) do
    if not validDrivebyWeapons[weaponID] then
      table.remove(newTable, key)
    end
  end
  settings.driver = newTable
  lastSlot = 0
  return true
end
function setPassengerDrivebyAbility(...)
  local newTable = {
    ...
  }
  for key, weaponID in ipairs(newTable) do
    if not validDrivebyWeapons[weaponID] then
      table.remove(newTable, key)
    end
  end
  settings.passenger = newTable
  lastSlot = 0
  return true
end
function getDriverDrivebyAbility()
  return settings.driver
end
function getPassengerDrivebyAbility()
  return settings.passenger
end
function setWeaponShotDelay(weaponID, delay)
  if not validDrivebyWeapons[weaponID] then
    return false
  end
  local delay = tonumber(delay)
  if not delay then
    return false
  end
  settings.shotdelay[tostring(weaponID)] = delay
  return true
end
function getWeaponShotDelay(weaponID)
  if not validDrivebyWeapons[weaponID] then
    return false
  end
  return settings.shotdelay[tostring(weaponID)] or 0
end
function setDrivebySteeringAbility(vehicles, bikes)
  if vehicles == nil then
    return false
  end
  settings.steerCars = vehicles
  settings.steerBikes = bikes or true
end
function getDrivebySteeringAbility(dbType)
  if dbType == "car" then
    return settings.steerCars
  elseif dbType == "bike" then
    return settings.steerBikes
  else
    return false
  end
end
function setDrivebyAutoEquip(enabled)
  if type(enabled) ~= "boolean" then
    return false
  end
  settings.autoEquip = enabled
  return true
end
function getDrivebyAutoEquip()
  return settings.autoEquip
end
