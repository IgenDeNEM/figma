function getVehicleSpeed(currentElement, forceUnit)
  if isElement(currentElement) then
    local testUnit = forceUnit or unit
    local x, y, z = getElementVelocity(currentElement)
    local speed = math.sqrt(x ^ 2 + y ^ 2 + z ^ 2)
    if testUnit == "MPH" then
      speed = speed * 116.5 * 1.1
    else
      speed = speed * 180 * 1.1
    end
    return speed
  end
  return 0
end

electricVehicles = {
  ["model_s"] = true,
  ["model_y"] = true,
  ["leaf"] = true,
}

function isVehicleElectric(vehicle)
  if type(vehicle) == "string" then
    if electricVehicles[vehicle] then
      return true
    else
      return false
    end
  else
    local model = getElementData(vehicle, "vehicle.customModel") or getElementModel(vehicle)
    if electricVehicles[model] then
      return true
    end
    return false
  end
end