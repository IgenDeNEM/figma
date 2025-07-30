drmCars = {
  [404] = "farzone",
  [405] = "a8front",
  [409] = "chassis",
  [424] = "badge_rear",
  [439] = "display",
  [443] = "hook",
  [463] = "wheel_type",
  [477] = "display",
  [491] = "chassis",
  [496] = "rline",
  [502] = "display",
  [506] = "lamps",
  [508] = "interno4",
  [526] = "display",
  [533] = "display",
  [534] = "display",
  [536] = "display",
  [541] = "display",
  [542] = "CRX_seat_l",
  [547] = "lights",
  [550] = "display",
  [558] = "m3engine",
  [562] = "skyline",
  [585] = "motor",
  [587] = "display",
  [426] = "Widebody_car",
  ["audirs7"] = "rs7_body",
}
function getDrmComponents()
  return drmCars
end
addEventHandler("onClientElementStreamIn", getRootElement(), function()
  local model = getElementData(source, "vehicle.customModel") or getElementModel(source)
  if drmCars[model] then
    setVehicleComponentVisible(source, drmCars[model], false)
  end
end)
addEventHandler("onClientVehicleDataChange", getRootElement(), function(data)
  if utf8.find(data, "visibility") then
    local model = getElementData(source, "vehicle.customModel") or getElementModel(source)
    if drmCars[model] then
      setVehicleComponentVisible(source, drmCars[model], false)
    end
  end
end)
addEventHandler("onClientResourceStart", getResourceRootElement(), function()
  local vehicles = getElementsByType("vehicle", getRootElement(), true)
  for k = 1, #vehicles do
    local model = getElementData(vehicles[k], "vehicle.customModel") or getElementModel(vehicles[k])
    if drmCars[model] then
      setVehicleComponentVisible(vehicles[k], drmCars[model], false)
    end
  end
end)
function calculateVehicle(veh)
  local model = getElementData(veh, "vehicle.customModel") or getElementModel(veh)
  if drmCars[model] then
    setVehicleComponentVisible(veh, drmCars[model], false)
  end
end
