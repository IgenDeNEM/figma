local defaultTankSize = 70
local defaultConsumption = 10
local defaultFuelType = {"petrol"}
local bothFuelType = {"petrol", "diesel"}
local dieselFuelType = {"diesel"}
local modelFuelTypes = {
  [611] = dieselFuelType,
  [466] = bothFuelType,
  [585] = dieselFuelType,
  [526] = bothFuelType,
  [405] = bothFuelType,
  [490] = dieselFuelType,
  [580] = bothFuelType,
  [596] = bothFuelType,
  [492] = bothFuelType,
  [421] = bothFuelType,
  [551] = bothFuelType,
  [558] = bothFuelType,
  [420] = bothFuelType,
  [445] = bothFuelType,
  [598] = bothFuelType,
  [400] = bothFuelType,
  [508] = dieselFuelType,
  [554] = bothFuelType,
  [413] = bothFuelType,
  [605] = bothFuelType,
  [495] = bothFuelType,
  [525] = dieselFuelType,
  [470] = bothFuelType,
  [500] = bothFuelType,
  [516] = bothFuelType,
  [438] = bothFuelType,
  [550] = bothFuelType,
  [507] = bothFuelType,
  [404] = bothFuelType,
  [582] = dieselFuelType,
  [579] = bothFuelType,
  [529] = dieselFuelType,
  [566] = dieselFuelType,
  [597] = dieselFuelType,
  [547] = bothFuelType,
  [418] = dieselFuelType,
  [410] = bothFuelType,
  [561] = bothFuelType,
  [589] = bothFuelType,
  [496] = bothFuelType,
  [416] = dieselFuelType,
  [407] = dieselFuelType,
  [403] = dieselFuelType,
  [407] = dieselFuelType,
  [408] = dieselFuelType,
  [414] = dieselFuelType,
  [422] = dieselFuelType,
  [423] = dieselFuelType,
  [427] = bothFuelType,
  [428] = dieselFuelType,
  [431] = dieselFuelType,
  [432] = dieselFuelType,
  [433] = dieselFuelType,
  [437] = dieselFuelType,
  [440] = bothFuelType,
  [442] = bothFuelType,
  [443] = dieselFuelType,
  [455] = dieselFuelType,
  [456] = dieselFuelType,
  [459] = bothFuelType,
  [478] = dieselFuelType,
  [482] = bothFuelType,
  [485] = bothFuelType,
  [486] = dieselFuelType,
  [498] = dieselFuelType,
  [499] = dieselFuelType,
  [504] = bothFuelType,
  [505] = dieselFuelType,
  [514] = dieselFuelType,
  [515] = dieselFuelType,
  [524] = dieselFuelType,
  [528] = dieselFuelType,
  [530] = dieselFuelType,
  [531] = dieselFuelType,
  [532] = dieselFuelType,
  [543] = bothFuelType,
  [560] = bothFuelType,
  [544] = dieselFuelType,
  [552] = dieselFuelType,
  [574] = dieselFuelType,
  [578] = dieselFuelType,
  [583] = dieselFuelType,
  [588] = dieselFuelType,
  [600] = bothFuelType,
  [601] = dieselFuelType,
  [609] = dieselFuelType,
  [458] = dieselFuelType,
  [467] = bothFuelType,
  ["model_s"] = {"electric"},
  ["model_y"] = {"electric"},
  ["leaf"] = {"electric"},
}
local modelConsumption = {
  [466] = 11,
  [424] = 19,
  [585] = 9,
  [526] = 9,
  [405] = 16,
  [490] = 18,
  [533] = 15,
  [580] = 12,
  [596] = 12,
  [602] = 16,
  [599] = 14,
  [483] = 17,
  [492] = 15,
  [421] = 16,
  [551] = 17,
  [558] = 14,
  [503] = 16,
  [420] = 12,
  [445] = 13,
  [598] = 12,
  [491] = 14,
  [549] = 14,
  [522] = 9,
  [400] = 12,
  [508] = 30,
  [494] = 35,
  [576] = 21,
  [541] = 17,
  [467] = 20,
  [517] = 22,
  [567] = 16,
  [554] = 14,
  [439] = 20,
  [603] = 21,
  [426] = 19,
  [429] = 14,
  [521] = 9,
  [555] = 24,
  [411] = 15,
  [413] = 18,
  [605] = 24,
  [495] = 22,
  [525] = 21,
  [401] = 12,
  [527] = 16,
  [535] = 26,
  [536] = 21,
  [586] = 9,
  [463] = 8,
  [565] = 8,
  [462] = 3,
  [542] = 8,
  [470] = 30,
  [500] = 15,
  [546] = 13,
  [451] = 15,
  [409] = 14,
  [534] = 19,
  [477] = 13,
  [506] = 14,
  [479] = 15,
  [516] = 18,
  [502] = 18,
  [415] = 10,
  [438] = 12,
  [550] = 11,
  [507] = 12,
  [404] = 23,
  [604] = 17,
  [582] = 13,
  [560] = 13,
  [587] = 16,
  [562] = 13,
  [475] = 20,
  [402] = 20,
  [480] = 14,
  [579] = 23,
  [529] = 6,
  [566] = 7,
  [597] = 8,
  [540] = 16,
  [419] = 14,
  [559] = 14,
  [474] = 8,
  [547] = 13,
  [418] = 9,
  [410] = 11,
  [561] = 9,
  [589] = 8,
  [458] = 7,
  [496] = 9,
  [471] = 7,
  [468] = 6,
  [416] = 14,
  [407] = 30,
  [452] = 50,
  [446] = 40,
  [454] = 80,
  [473] = 6,
  [484] = 45,
  [453] = 20,
  [487] = 35,
  [497] = 35,
  [403] = 50,
  [404] = 10,
  [407] = 30,
  [408] = 30,
  [412] = 14,
  [414] = 18,
  [422] = 13,
  [423] = 13,
  [427] = 19,
  [428] = 26,
  [431] = 50,
  [432] = 200,
  [433] = 60,
  [434] = 16,
  [436] = 12,
  [437] = 50,
  [440] = 25,
  [442] = 14,
  [443] = 30,
  [448] = 3,
  [455] = 60,
  [456] = 24,
  [457] = 1,
  [459] = 25,
  [461] = 7,
  [478] = 15,
  [482] = 24,
  [485] = 4,
  [486] = 40,
  [498] = 18,
  [499] = 17,
  [504] = 16,
  [505] = 28,
  [514] = 52,
  [515] = 56,
  [518] = 20,
  [523] = 8,
  [524] = 32,
  [528] = 21,
  [530] = 4,
  [531] = 8,
  [532] = 45,
  [543] = 14,
  [544] = 30,
  [545] = 19,
  [552] = 19,
  [568] = 20,
  [571] = 5,
  [572] = 7,
  [574] = 5,
  [575] = 19,
  [578] = 28,
  [581] = 6,
  [583] = 6,
  [588] = 18,
  [600] = 17,
  [601] = 24,
  [609] = 16
}
local modelTankSize = {
  [611] = 1000,
  [466] = 60,
  [424] = 50,
  [585] = 95,
  [526] = 50,
  [405] = 90,
  [490] = 100,
  [533] = 75,
  [580] = 60,
  [596] = 75,
  [602] = 90,
  [599] = 60,
  [483] = 50,
  [492] = 70,
  [421] = 90,
  [551] = 95,
  [558] = 70,
  [503] = 60,
  [420] = 80,
  [445] = 75,
  [598] = 75,
  [491] = 70,
  [549] = 75,
  [522] = 22,
  [400] = 80,
  [508] = 180,
  [494] = 85,
  [576] = 60,
  [541] = 70,
  [467] = 80,
  [517] = 75,
  [567] = 76,
  [554] = 90,
  [439] = 75,
  [603] = 72,
  [426] = 70,
  [429] = 70,
  [521] = 22,
  [555] = 130,
  [411] = 65,
  [413] = 140,
  [605] = 95,
  [495] = 136,
  [525] = 105,
  [401] = 50,
  [527] = 60,
  [535] = 70,
  [536] = 65,
  [586] = 30,
  [463] = 25,
  [565] = 45,
  [462] = 8,
  [542] = 41,
  [470] = 230,
  [500] = 81,
  [546] = 40,
  [451] = 80,
  [409] = 80,
  [534] = 70,
  [477] = 68,
  [506] = 71,
  [479] = 55,
  [516] = 105,
  [502] = 75,
  [415] = 45,
  [438] = 80,
  [550] = 75,
  [507] = 80,
  [404] = 100,
  [604] = 80,
  [582] = 90,
  [560] = 55,
  [587] = 73,
  [562] = 65,
  [475] = 70,
  [402] = 75,
  [480] = 65,
  [579] = 86,
  [529] = 50,
  [566] = 50,
  [597] = 50,
  [540] = 60,
  [419] = 55,
  [559] = 70,
  [474] = 40,
  [547] = 55,
  [418] = 80,
  [410] = 40,
  [561] = 55,
  [589] = 50,
  [458] = 60,
  [496] = 55,
  [471] = 15,
  [468] = 14,
  [416] = 90,
  [407] = 200,
  [452] = 300,
  [446] = 300,
  [454] = 600,
  [473] = 35,
  [484] = 300,
  [453] = 300,
  [487] = 300,
  [497] = 300,
  [403] = 800,
  [404] = 60,
  [407] = 200,
  [408] = 200,
  [412] = 70,
  [414] = 140,
  [422] = 80,
  [423] = 80,
  [427] = 90,
  [428] = 90,
  [431] = 800,
  [432] = 800,
  [433] = 800,
  [434] = 30,
  [436] = 45,
  [437] = 800,
  [440] = 90,
  [442] = 80,
  [443] = 400,
  [448] = 8,
  [455] = 800,
  [456] = 140,
  [457] = 10,
  [459] = 90,
  [461] = 20,
  [478] = 75,
  [482] = 90,
  [485] = 20,
  [486] = 120,
  [498] = 140,
  [499] = 110,
  [504] = 55,
  [505] = 130,
  [514] = 810,
  [515] = 830,
  [518] = 70,
  [523] = 25,
  [524] = 210,
  [528] = 105,
  [530] = 15,
  [531] = 25,
  [532] = 200,
  [543] = 70,
  [544] = 200,
  [545] = 55,
  [552] = 95,
  [568] = 50,
  [571] = 20,
  [572] = 20,
  [574] = 30,
  [575] = 65,
  [578] = 300,
  [581] = 20,
  [583] = 20,
  [588] = 95,
  [600] = 75,
  [601] = 120,
  [609] = 105,
  ["primo2"] = 75,
  ["dodge"] = 100,
  ["audirs7"] = 75,
}
superChargerOffsets = {
  [576] = {
    0,
    1.6246,
    0.5576
  },
  [541] = {
    0,
    1.3204,
    0.3957
  },
  [467] = {
    0,
    1.7321,
    0.6639
  },
  [517] = {
    0,
    1.7321,
    0.3037
  },
  [567] = {
    0,
    1.973,
    0.2483
  },
  [439] = {
    0,
    1.7639,
    0.5002
  },
  [603] = {
    0,
    1.7639,
    0.4282
  },
  [426] = {
    0,
    1.6958,
    0.4683
  },
  [429] = {
    0,
    1.0975,
    0.4152
  },
  [527] = {
    0,
    1.1769,
    0.4291
  },
  [535] = {
    0,
    1.4879,
    0.6426
  },
  [536] = {
    0,
    1.4879,
    0.4954
  },
  [534] = {
    0,
    1.89,
    0.3447
  },
  [475] = {
    0,
    1.5075,
    0.3793
  },
  [402] = {
    0,
    1.3719,
    0.3134
  }
}
function getAvailableFuelTypes(model)
  return modelFuelTypes[model] or defaultFuelType
end

electricVehicles = {
  ["model_s"] = true,
  ["model_y"] = true,
  ["leaf"] = true,
}

vehicleFuelTypeCache = {}
if triggerClientEvent then
  dieselVehicles = {}
  function getFuelType(veh)
    if isElement(veh) then
      model = getElementData(veh, "vehicle.customModel") or getElementModel(veh)
    end
    if isElement(veh) then
      if electricVehicles[model] then
        vehicleFuelTypeCache[veh] = "electric"
        return "electric"
      end
    end
    if model == 611 then
      return "diesel"
    end
    if vehicleFuelTypeCache[veh] then
      return vehicleFuelTypeCache[veh]
    end
    local types = getAvailableFuelTypes(tonumber(veh) or getElementModel(veh))
    if #types == 1 or tonumber(veh) then
      if isElement(veh) then
        vehicleFuelTypeCache[veh] = types[1]
      end
      return types[1]
    else
      if isElement(veh) then
        local ft = getElementData(veh, "dieselFuel") and "diesel" or "petrol"
        return ft
      end
      if isElement(veh) then
        vehicleFuelTypeCache[veh] = dieselVehicles[veh] and "diesel" or "petrol"
      end
      return dieselVehicles[veh] and "diesel" or "petrol"
    end
  end
  if fileExists("tanksize.sight") then
    fileDelete("tanksize.sight")
  end
  local file = fileCreate("tanksize.sight")
  fileWrite(file, "-1;" .. defaultTankSize .. "\n")
  for k, v in pairs(modelTankSize) do
    fileWrite(file, k .. ";" .. v .. "\n")
  end
  fileClose(file)
  if fileExists("fueltype.sight") then
    fileDelete("fueltype.sight")
  end
  local file = fileCreate("fueltype.sight")
  if #defaultFuelType > 1 then
    fileWrite(file, "-1;both\n")
  else
    fileWrite(file, "-1;" .. defaultFuelType[1] .. "\n")
  end
  for k, v in pairs(modelFuelTypes) do
    if #v > 1 then
      fileWrite(file, k .. ";both\n")
    else
      fileWrite(file, k .. ";" .. v[1] .. "\n")
    end
  end
  fileClose(file)
else
  function getFuelType(veh)
    if vehicleFuelTypeCache[veh] then
      return vehicleFuelTypeCache[veh]
    end
    local types = getAvailableFuelTypes(tonumber(veh) or getElementModel(veh))
    if #types == 1 or tonumber(veh) then
      if isElement(veh) then
        vehicleFuelTypeCache[veh] = types[1]
      end
      return types[1]
    else
      local ft = getElementData(veh, "dieselFuel") and "diesel" or "petrol"
      if isElement(veh) then
        vehicleFuelTypeCache[veh] = ft
      end
      return ft
    end
  end
end
vehicleFuelConsumptionCache = {}
function getFuelConsumption(veh)
  if vehicleFuelConsumptionCache[veh] then
    return vehicleFuelConsumptionCache[veh]
  end
  local model = tonumber(veh) or getElementModel(veh)
  local fc = modelConsumption[model] or defaultConsumption
  if getFuelType(veh) == "diesel" then
    fc = math.floor(fc * 0.8 * 10 + 0.5) / 10
  end
  if isElement(veh) then
    vehicleFuelConsumptionCache[veh] = fc
  end
  return fc
end
vehicleTankSizeCache = {}
function getTankSize(veh)
  if vehicleTankSizeCache[veh] then
    return vehicleTankSizeCache[veh]
  end
  local model = (isElement(veh) and getElementData(veh, "vehicle.customModel")) or tonumber(veh) or getElementModel(veh)
  local ts = modelTankSize[model] or defaultTankSize
  if isElement(veh) then
    vehicleTankSizeCache[veh] = ts
  end
  return ts
end
local batteryValues = {
  starter = -1600,
  engine = 220,
  charger = 50,
  ignition = -80,
  lights = -6,
  radio = -12
}
function getBatteryValues(veh, name)
  if name == "starter" and getFuelType(veh) == "diesel" then
    return batteryValues[name] * 1.25
  elseif name == "engine" and getFuelType(veh) == "diesel" then
    return batteryValues[name] * 1.15
  end
  return batteryValues[name]
end
function getSuperChargerOffset(model)
  return superChargerOffsets[model]
end
function destroyVehicleDataCache()
  vehicleFuelTypeCache[source] = nil
  vehicleFuelConsumptionCache[source] = nil
  vehicleTankSizeCache[source] = nil
end
addEventHandler("onClientVehicleDestroy", getRootElement(), destroyVehicleDataCache)
addEventHandler("onVehicleDestroy", getRootElement(), destroyVehicleDataCache)
