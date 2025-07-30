local removeNoColTimers = {}

function enableVehicleNoCol(vehicle, timer)
    setElementData(vehicle, "vehicleNoCol", true)

    if isTimer(removeNoColTimers[vehicle]) then
        killTimer(removeNoColTimers[vehicle])
    end
    removeNoColTimers[vehicle] = nil

    timer = tonumber(timer)

    if timer then
        removeNoColTimers[vehicle] = setTimer(removeVehicleNoCol, timer, 1, vehicle)
    end
end

function removeVehicleNoCol(vehicle)
    if isElement(vehicle) then
        setElementData(vehicle, "vehicleNoCol", false)
    end
end