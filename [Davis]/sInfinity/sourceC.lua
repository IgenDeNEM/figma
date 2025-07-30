local infinityVehicle = {}
local processedVehicle = {}

function setCustomVehicle(vehicleElement, modelType)
    if infinityVehicle[modelType] then
        local modelId = infinityVehicle[modelType].model
        setElementModel(vehicleElement, modelId)
    end
end

function setCustomVehicleModel(modelType, modelIdentity)
    infinityVehicle[modelType] = {}
    infinityVehicle[modelType].model = modelIdentity
end

addEventHandler("onClientElementStreamIn", root, function()
    if source and getElementType(source) == "vehicle" then
        local customVehicle = getElementData(source, "vehicle.customModel") or false
        local vehicleVariant = getElementData(source, "vehicle.Variant") or false

        if customVehicle then
            if not infinityVehicle[customVehicle] then
                local modelIdentity = exports.sVehiclemods:getCustomModel(customVehicle)
                if modelIdentity then
                    infinityVehicle[customVehicle] = {}
                    infinityVehicle[customVehicle].model = modelId
                end
            end

            setCustomVehicle(source, customVehicle)
        end

        if not processedVehicle[source] then
            processedVehicle[source] = true

            if vehicleVariant and (vehicleVariant[1] and vehicleVariant[1] >= 0 and vehicleVariant[1] <= 255) and (vehicleVariant[2] and vehicleVariant[2] >= 0 and vehicleVariant[2] <= 255) then
                setVehicleVariant(source, vehicleVariant[1], vehicleVariant[2])
            end
        end
    end
end)