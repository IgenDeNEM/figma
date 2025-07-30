local entranceCols = {}
local entranceColsEx = {}

local exitCols = {}
local exitColsEx = {}

function calculateOffset(offsetX, offsetY, cosRot, sinRot)
    local newX = offsetX * cosRot - offsetY * sinRot
    local newY = offsetX * sinRot + offsetY * cosRot
    
    return newX, newY
end

addEventHandler("onColShapeHit", resourceRoot, function(hitElement, md)
    if md then
        local elemType = getElementType(hitElement)

        if elemType == "vehicle" or elemType == "player" then
            if entranceColsEx[source] then
                local i, j = unpack(entranceColsEx[source])
                
                local col, col2 = unpack(entranceCols[i][j])
                local vehicles = getElementsWithinColShape(col, "vehicle")
                local vehicles2 = getElementsWithinColShape(col2, "vehicle")

                for i = 1, #vehicles2 do
                    local vehicle2 = vehicles2[i]

                    local found = false

                    for i = 1, #vehicles do
                        local vehicle = vehicles[i]

                        if vehicle == vehicle2 then
                            found = true
                            break
                        end
                    end

                    if not found then
                        table.insert(vehicles, vehicle2)
                    end
                end

                if #vehicles <= 0 then
                    triggerClientEvent(getRootElement(), "changeParkingEnterGateState", getRootElement(), i, j, false)
                elseif source == col then
                    triggerClientEvent(getRootElement(), "changeParkingEnterGateState", getRootElement(), i, j, true)
                end

                local syncElements = {}

                if j == 2 and source == col then
                    if getElementType(hitElement) == "vehicle" then
                        local occupants = getVehicleOccupants(hitElement)

                        for k, v in pairs(occupants) do
                            setElementDimension(v, parkingGarages[i].insideDimension)
                        end

                        exports.sNocol:enableVehicleNoCol(hitElement, 10000)
                    end
                    
                    setElementDimension(hitElement, parkingGarages[i].insideDimension)
                end
            elseif exitColsEx[source] then
                local i, j = unpack(exitColsEx[source])
                
                local col, col2 = unpack(exitCols[i][j])
                local vehicles = getElementsWithinColShape(col, "vehicle")
                local vehicles2 = getElementsWithinColShape(col2, "vehicle")

                for i = 1, #vehicles2 do
                    local vehicle2 = vehicles2[i]

                    local found = false

                    for i = 1, #vehicles do
                        local vehicle = vehicles[i]

                        if vehicle == vehicle2 then
                            found = true
                            break
                        end
                    end

                    if not found then
                        table.insert(vehicles, vehicle2)
                    end
                end

                if #vehicles <= 0 then
                    triggerClientEvent(getRootElement(), "changeParkingExitGateState", getRootElement(), i, j, false)
                elseif source == col then
                    triggerClientEvent(getRootElement(), "changeParkingExitGateState", getRootElement(), i, j, true)
                end

                local syncElements = {}

                if j == 2 and source == col then
                    if getElementType(hitElement) == "vehicle" then
                        local occupants = getVehicleOccupants(hitElement)

                        for k, v in pairs(occupants) do
                            setElementDimension(v, parkingGarages[i].outsideDimension)
                        end
                        
                        exports.sNocol:enableVehicleNoCol(hitElement, 10000)
                    end
                    
                    setElementDimension(hitElement, parkingGarages[i].outsideDimension)
                end
            end
        end
    end
end)

addEventHandler("onColShapeLeave", resourceRoot, function(hitElement, md)
    if md then
        if entranceColsEx[source] then
            local i, j = unpack(entranceColsEx[source])

            if getElementType(hitElement) == "vehicle" then
                local col, col2 = unpack(entranceCols[i][j])
                local vehicles = getElementsWithinColShape(col, "vehicle")
                local vehicles2 = getElementsWithinColShape(col2, "vehicle")

                for i = 1, #vehicles2 do
                    local vehicle2 = vehicles2[i]

                    local found = false

                    for i = 1, #vehicles do
                        local vehicle = vehicles[i]

                        if vehicle == vehicle2 then
                            found = true
                            break
                        end
                    end

                    if not found then
                        table.insert(vehicles, vehicle2)
                    end
                end

                if #vehicles <= 0 then
                    triggerClientEvent(getRootElement(), "changeParkingEnterGateState", getRootElement(), i, j, false)
                end
            end
        elseif exitColsEx[source] then
            local i, j = unpack(exitColsEx[source])

            if getElementType(hitElement) == "vehicle" then
                local col, col2 = unpack(exitCols[i][j])
                local vehicles = getElementsWithinColShape(col, "vehicle")
                local vehicles2 = getElementsWithinColShape(col2, "vehicle")

                for i = 1, #vehicles2 do
                    local vehicle2 = vehicles2[i]

                    local found = false

                    for i = 1, #vehicles do
                        local vehicle = vehicles[i]

                        if vehicle == vehicle2 then
                            found = true
                            break
                        end
                    end

                    if not found then
                        table.insert(vehicles, vehicle2)
                    end
                end

                if #vehicles <= 0 then
                    triggerClientEvent(getRootElement(), "changeParkingExitGateState", getRootElement(), i, j, false)
                end
            end
        end
    end
end)

addEventHandler("onResourceStart", getRootElement(), function(res)
    if res == getThisResource() then
        for i = 1, #parkingGarages do
            local garage = parkingGarages[i]
            local outsideDimension = garage.outsideDimension
            local insideDimension = garage.insideDimension

            local enterBarriers = garage.enterBarriers
            local exitBarriers = garage.exitBarriers

            entranceCols[i] = {}
            exitCols[i] = {}

            for j = 1, #enterBarriers do
                local enterBarrier = enterBarriers[j]

                local rz = enterBarrier[4]

                local rad = math.rad(rz)
                local cos = math.cos(rad)
                local sin = math.sin(rad)

                local offX, offY = calculateOffset(-3, 3, cos, sin)

                local entranceCol = createColSphere(enterBarrier[1] + offX, enterBarrier[2] + offY, enterBarrier[3], 3.2)
                setElementDimension(entranceCol, outsideDimension)
                entranceColsEx[entranceCol] = {i, j}

                local offX, offY = calculateOffset(-3, -3, cos, sin)

                local entranceCol2 = createColSphere(enterBarrier[1] + offX, enterBarrier[2] + offY, enterBarrier[3], 3.2)
                if j == 2 then
                    setElementDimension(entranceCol2, insideDimension)
                else
                    setElementDimension(entranceCol2, outsideDimension)
                end
                entranceColsEx[entranceCol2] = {i, j}

                entranceCols[i][j] = {entranceCol, entranceCol2}
            end

            for j = 1, #exitBarriers do
                local exitBarrier = exitBarriers[j]

                local rz = exitBarrier[4]

                local rad = math.rad(rz)
                local cos = math.cos(rad)
                local sin = math.sin(rad)

                local offX, offY = calculateOffset(-3, 3, cos, sin)

                local exitCol = createColSphere(exitBarrier[1] + offX, exitBarrier[2] + offY, exitBarrier[3], 3.2)
                setElementDimension(exitCol, insideDimension)
                exitColsEx[exitCol] = {i, j}

                local offX, offY = calculateOffset(-3, -3, cos, sin)

                local exitCol2 = createColSphere(exitBarrier[1] + offX, exitBarrier[2] + offY, exitBarrier[3], 3.2)
                if j == 2 then
                    setElementDimension(exitCol2, outsideDimension)
                else
                    setElementDimension(exitCol2, insideDimension)
                end
                exitColsEx[exitCol2] = {i, j}

                exitCols[i][j] = {exitCol, exitCol2}
            end
        end
    end
end)
