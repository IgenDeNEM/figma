local handledSuperchargerPreRender = false
local handledSuperchargerPedProcess = false

local handledRenderNotInHand = false
local handledClickNotInHand = false

local handledRenderInHand = false
local handledClickInHand = false

local lastButtonTry = 0

local function handleSuperchargerPreRender(state, prio)
    if handledSuperchargerPreRender ~= state then
        handledSuperchargerPreRender = state
        
        if handledSuperchargerPreRender then
            addEventHandler("onClientPreRender", getRootElement(), preRenderSuperchargers, true, prio)
        else
            removeEventHandler("onClientPreRender", getRootElement(), preRenderSuperchargers)
        end
    end
end

local function handleSuperchargerPedProcess(state, prio)
  if handledSuperchargerPedProcess ~= state then
        handledSuperchargerPedProcess = state

        if handledSuperchargerPreRender then
            addEventHandler("onClientPedsProcessed", getRootElement(), pedsProcessedSuperchargers, true, prio)
        else
            removeEventHandler("onClientPedsProcessed", getRootElement(), pedsProcessedSuperchargers)
        end
    end
end

local function handleRenderNotInHand(state, prio)
    if handledRenderNotInHand ~= state then
        handledRenderNotInHand = state

        if handledRenderNotInHand then
            addEventHandler("onClientRender", getRootElement(), renderNotInHand, true, prio)
        else
            removeEventHandler("onClientRender", getRootElement(), renderNotInHand)
        end
    end
end

local function handleClickNotInHand(state, prio)
    if handledClickNotInHand ~= state then
        handledClickNotInHand = state

        if handledClickNotInHand then
            addEventHandler("onClientClick", getRootElement(), clickNotInHand, true, prio)
        else
            removeEventHandler("onClientClick", getRootElement(), clickNotInHand)
        end
    end
end

local function handleRenderInHand(state, prio)
    if handledRenderInHand ~= state then
        handledRenderInHand = state

        if handledRenderInHand then
            addEventHandler("onClientRender", getRootElement(), renderInHand, true, prio)
        else
            removeEventHandler("onClientRender", getRootElement(), renderInHand)
        end
    end
end

local function handleClickInHand(state, prio)
    if handledClickInHand ~= state then
        handledClickInHand = state

        if handledClickInHand then
            addEventHandler("onClientClick", getRootElement(), clickInHand, true, prio)
        else
            removeEventHandler("onClientClick", getRootElement(), clickInHand)
        end
    end
end

local boltIcon = false
local sightgrey1 = false
local sightgreen = false
local sightgreen2 = false
local faTicks = false

local function r11_0()
    local res = getResourceFromName("sGui")
    if res and getResourceState(res) == "running" then
        boltIcon = exports.sGui:getFaIconFilename("bolt", 64)
        sightgrey1 = exports.sGui:getColorCode("sightgrey1")
        sightgreen = exports.sGui:getColorCodeToColor("sightgreen")
        sightgreen2 = exports.sGui:getColorCode("sightgreen")
        faTicks = exports.sGui:getFaTicks()
    end
end
addEventHandler("onGuiRefreshColors", getRootElement(), r11_0)
addEventHandler("onClientResourceStart", getResourceRootElement(), r11_0)

addEventHandler("refreshFaTicks", getRootElement(), function()
    faTicks = exports.sGui:getFaTicks()
end)

local screenX, screenY = guiGetScreenSize()

local chargerObjects = {}
local pistolInHand = false

addEventHandler("onClientObjectBreak", getRootElement(), function(attacker)
    for i = 1, #superchargerList, 1 do
        local supercharger = superchargerList[i]

        if supercharger.object == source then
            cancelEvent()
        end
    end
end)

addEvent("gotWallCharger", true)
addEventHandler("gotWallCharger", getRootElement(), function(dim)
    if dim then
        if supercharger and isElement(supercharger.object) then
            return
        end
        local supercharger = superchargerList[#superchargerList]

        supercharger.object = createObject(wallChargerModelID, supercharger.pos[1], supercharger.pos[2], supercharger.pos[3], 0, 0, supercharger.pos[4])
        supercharger.dimension = dim
        setElementDimension(supercharger.object, dim or 0)
        setElementInterior(supercharger.object, 1)
        chargerObjects[supercharger.object] = #superchargerList

        local x = supercharger.pos[1]
        local y = supercharger.pos[2]
        local z = supercharger.pos[3]

        local cosAngle, sinAngle = supercharger.cos, supercharger.sin

        supercharger.pistolPos = {
            x + 0.03 + cosAngle * 0.4691 - sinAngle * 0.04,
            y - 0.06 + sinAngle * 0.4691 + cosAngle * 0.04,
            z - 0.1208
        }

        supercharger.cablePos = {
            x + cosAngle * 0.3818 + sinAngle * 0.045,
            y - 0.4 + sinAngle * 0.3818 - cosAngle * 0.045,
            z - 0.2433
        }
        supercharger.pistol = createObject(
            pistolModelID,
            supercharger.pistolPos[1],
            supercharger.pistolPos[2],
            supercharger.pistolPos[3],
            0, -50, supercharger.pos[4]
        )

        setElementCollisionsEnabled(supercharger.pistol, false)
        setElementDimension(supercharger.pistol, dim or 0)
        setElementInterior(supercharger.pistol, 1)

        local cableStartX, cableStartY, cableStartZ = supercharger.cablePos[1], supercharger.cablePos[2], supercharger.cablePos[3]
        local cableDiffX = supercharger.pistolPos[1] - cableStartX
        local cableDiffY = supercharger.pistolPos[2] - cableStartY
        local cableDiffZ = supercharger.pistolPos[3] - cableStartZ

        supercharger.defaultCable = {}
        for segment = 1, 20 do
            local segmentX, segmentY, segmentZ = findCablePos(
                cableStartX, cableStartY, cableStartZ,
                cableDiffX, cableDiffY, cableDiffZ,
                1, segment
            )
            table.insert(supercharger.defaultCable, { segmentX, segmentY, segmentZ })
        end


        addEventHandler("onClientElementStreamIn", supercharger.object, superchargerStreamIn)
        addEventHandler("onClientElementStreamOut", supercharger.object, superchargerStreamOut)
    else
        local chargerObject = #superchargerList
        if chargerObject then
            for i = #streamedChargers, 1, -1 do
                if streamedChargers[i] == chargerObject then
                    table.remove(streamedChargers, i)
                end
            end
    
            handleRenderNotInHand(#streamedChargers > 0 and not pistolInHand)
            handleClickNotInHand(#streamedChargers > 0 and not pistolInHand)
    
            if hoveredCharger or hoveredElement then
                exports.sGui:setCursorType("normal")
                exports.sGui:showTooltip(false)
            end
    
            hoveredCharger = false
            hoveredElement = false

            if isElement(superchargerList[chargerObject].object) then
                destroyElement(superchargerList[chargerObject].object)
            end

            if isElement(superchargerList[chargerObject].pistol) then
                destroyElement(superchargerList[chargerObject].pistol)
            end

            if isElement(superchargerList[chargerObject].sound) then
                destroyElement(superchargerList[chargerObject].sound)
            end
    
            superchargerList[chargerObject].streamedIn = false
            superchargerList[chargerObject].soundP = false
            superchargerList[chargerObject].object = false
    
            if isElement(superchargerList[chargerObject].sound) then
                destroyElement(superchargerList[chargerObject].sound)
            end

            superchargerList[chargerObject].sound = nil
    
            if isElement(chargerShader) then
                engineRemoveShaderFromWorldTexture(chargerShader, "v4_plugsee_led", superchargerList[chargerObject].object)
            end
        end
    end
end)

chargerModelID = exports.sModloader:getModelId("v4_plugsee_charger")
wallChargerModelID = exports.sModloader:getModelId("v4_plugsee_wallcharger")
pistolModelID = exports.sModloader:getModelId("v4_plugsee_pistol")

addEventHandler("onClientResourceStart", getRootElement(), function(startedResource)
    if startedResource == getThisResource() then

        for i = 1, #superchargerList - 1, 1 do
            local supercharger = superchargerList[i]

            supercharger.object = createObject(chargerModelID, supercharger.pos[1], supercharger.pos[2], supercharger.pos[3], 0, 0, supercharger.pos[4])
            setElementDimension(supercharger.object, supercharger.dimension or 0)
            chargerObjects[supercharger.object] = i

            local x = supercharger.pos[1]
            local y = supercharger.pos[2]
            local z = supercharger.pos[3]

            local cosAngle, sinAngle = supercharger.cos, supercharger.sin

            supercharger.pistolPos = {
                x + cosAngle * 0.4691 - sinAngle * 0.04,
                y + sinAngle * 0.469 + cosAngle * 0.04,
                z + 1.0088
            }
        
            supercharger.cablePos = {
                x + cosAngle * 0.3818 + sinAngle * 0.045,
                y + sinAngle * 0.3818 - cosAngle * 0.045,
                z + 1.7433
            }
            supercharger.pistol = createObject(
                pistolModelID,
                supercharger.pistolPos[1],
                supercharger.pistolPos[2],
                supercharger.pistolPos[3],
                0, -10, supercharger.pos[4]
            )

            setElementCollisionsEnabled(supercharger.pistol, false)
            setElementDimension(supercharger.pistol, supercharger.dimension or 0)
        
            local cableStartX, cableStartY, cableStartZ = supercharger.cablePos[1], supercharger.cablePos[2], supercharger.cablePos[3]
            local cableDiffX = supercharger.pistolPos[1] - cableStartX
            local cableDiffY = supercharger.pistolPos[2] - cableStartY
            local cableDiffZ = supercharger.pistolPos[3] - cableStartZ
        
            supercharger.defaultCable = {}
            for segment = 1, 20 do
                local segmentX, segmentY, segmentZ = findCablePos(
                    cableStartX, cableStartY, cableStartZ,
                    cableDiffX, cableDiffY, cableDiffZ,
                    1, segment
                )
                table.insert(supercharger.defaultCable, { segmentX, segmentY, segmentZ })
            end


            addEventHandler("onClientElementStreamIn", supercharger.object, superchargerStreamIn)
            addEventHandler("onClientElementStreamOut", supercharger.object, superchargerStreamOut)
        end
  
        triggerServerEvent("requestSuperchargerSync", localPlayer)
    end
end)

function findCablePos(startX, startY, startZ, directionX, directionY, directionZ, distanceFactor, distance)
    local scaledDistance = distance / 20 * distanceFactor
    local newX = startX + directionX * scaledDistance
    local newY = startY + directionY * scaledDistance
    local newZ = startZ + directionZ * scaledDistance - math.sin(scaledDistance * math.pi)
    
    return newX, newY, newZ
end

streamedChargers = {}
local streamedVehicleChargingPorts = {}

local chargerRenderTarget = false
local chargerShader = false
local chargerShaderRaw = " texture gTexture; technique hello { pass P0 { Texture[0] = gTexture; } } "

local hoveredCharger = false
local hoveredElement = false

addEventHandler("onClientElementStreamOut", getRootElement(), function()
    if getElementType(source) == "vehicle" then
        if streamedVehicleChargingPorts[source] then
            setVehicleComponentRotation(source, "chargingport", 0, 0, 0)
        end

        streamedVehicleChargingPorts[source] = nil
    end
end)

addEventHandler("onClientElementDestroy", getRootElement(), function()
    if getElementType(source) == "vehicle" then
        streamedVehicleChargingPorts[source] = nil
    end
end)

function superchargerStreamIn()
    local chargerObject = chargerObjects[source]

    if chargerObject then
        handleSuperchargerPreRender(true)
        handleSuperchargerPedProcess(true, "low-99999999999")
        handleRenderNotInHand(not pistolInHand)
        handleClickNotInHand(not pistolInHand)

        if not isElement(chargerRenderTarget) then
            chargerRenderTarget = dxCreateRenderTarget(1, 1)

            if isElement(chargerShader) then
                dxSetShaderValue(chargerShader, "gTexture", chargerRenderTarget)
            end
        end

        if not isElement(chargerShader) then
            chargerShader = processText(chargerShaderRaw)
            dxSetShaderValue(chargerShader, "gTexture", chargerRenderTarget)
        end

        for i = 1, #streamedChargers, 1 do
            if streamedChargers[i] == chargerObject then
                return 
            end
        end

        table.insert(streamedChargers, chargerObject)
        superchargerList[chargerObject].streamedIn = true

        if superchargerList[chargerObject].pistolInVehicle then
            engineApplyShaderToWorldTexture(chargerShader, "v4_plugsee_led", superchargerList[chargerObject].object)
        end
    end
end

function superchargerStreamOut()
    local chargerObject = chargerObjects[source]

    if chargerObject then
        for i = #streamedChargers, 1, -1 do
            if streamedChargers[i] == chargerObject then
                table.remove(streamedChargers, i)
            end
        end

        handleRenderNotInHand(#streamedChargers > 0 and not pistolInHand)
        handleClickNotInHand(#streamedChargers > 0 and not pistolInHand)

        if hoveredCharger or hoveredElement then
            exports.sGui:setCursorType("normal")
            exports.sGui:showTooltip(false)
        end

        hoveredCharger = false
        hoveredElement = false

        superchargerList[chargerObject].streamedIn = false
        superchargerList[chargerObject].soundP = false

        if isElement(superchargerList[chargerObject].sound) then
            destroyElement(superchargerList[chargerObject].sound)
        end
        superchargerList[chargerObject].sound = nil

        if isElement(chargerShader) then
            engineRemoveShaderFromWorldTexture(chargerShader, "v4_plugsee_led", superchargerList[chargerObject].object)
        end
    end
end

function preRenderSuperchargers(delta)
    dxSetRenderTarget(chargerRenderTarget)
    local dynamicAlpha = (math.cos(getTickCount() / 250) / 2 + 0.5) * 255
    dxDrawRectangle(0, 0, 1, 1, tocolor(10, 30, 20))
    dxDrawRectangle(0, 0, 1, 1, tocolor(60, 184, 130, dynamicAlpha))
    dxSetRenderTarget()

    local renderStreamedChargers = #streamedChargers <= 0
    local vehicles = getElementsByType("vehicle", getRootElement(), true)
    local chargingVehicles = {}

    for i = 1, #streamedChargers, 1 do
        local streamedCharger = streamedChargers[i]
    
        if streamedCharger then
            local charger = superchargerList[streamedCharger]

            if charger.pistolInVehicle then
                chargingVehicles[charger.pistolInVehicle] = true

                if not charger.soundP then
                    if isElement(charger.sound) then
                      destroyElement(charger.sound)
                    end
                    charger.sound = nil
                    charger.soundP = 0
                    charger.sound = playSound3D("sounds/charger.mp3", charger.pos[1], charger.pos[2], charger.pos[3], true)
                    setElementDimension(charger.sound, charger.dimension or 0)
                    setElementInterior(charger.sound, charger.interior or 0)
                end
                charger.soundP = math.min(1, charger.soundP + delta / 3000)
            else
                if charger.pistolInHand then
                    local vehiclesInCol = getElementsWithinColShape(charger.vehicleCol, "vehicle")

                    for j = 1, #vehiclesInCol, 1 do
                        local vehicle = vehiclesInCol[j]
                        local vehicleModel = getElementData(vehicle, "vehicle.customModel") or getElementModel(vehicle)

                        if chargingPortRotation[vehicleModel] then
                            chargingVehicles[vehicle] = true
                        end
                    end
                end

                if charger.soundP then
                    charger.soundP = math.max(0, charger.soundP - delta / 5000)

                    if charger.soundP <= 0 then
                        charger.soundP = nil

                        if isElement(charger.sound) then
                            destroyElement(charger.sound)
                        end

                        charger.sound = nil
                    end
                end
            end

            if charger.soundP then
                setSoundVolume(charger.sound, math.min(1, charger.soundP * 3))
                setSoundSpeed(charger.sound, 0.5 + charger.soundP * 0.5)
            end
        end
    end

    for vehicleElement in pairs(streamedVehicleChargingPorts) do
        local vehicleModel = getElementData(vehicleElement, "vehicle.customModel") or getElementModel(vehicleElement)
        local chargingPortRot = chargingPortRotation[vehicleModel]

        if chargingPortRot then
            local easingValue = getEasingValue(streamedVehicleChargingPorts[vehicleElement], "InOutQuad")
            setVehicleComponentRotation(vehicleElement, "chargingport", chargingPortRot[1] * easingValue, chargingPortRot[2] * easingValue, chargingPortRot[3] * easingValue)
        end

        if chargingVehicles[vehicleElement] then
            streamedVehicleChargingPorts[vehicleElement] = math.min(1, streamedVehicleChargingPorts[vehicleElement] + 1 * delta / 800)
            chargingVehicles[vehicleElement] = nil
        else
            if streamedVehicleChargingPorts[vehicleElement] >= 1 then
                local chargingPortOffset = chargingPortOffset[vehicleModel]

                if not chargingPortOffset then
                    chargingPortOffset = {0, 0, 0}
                end

                local sound = playSound3D("sounds/plug.mp3", 0, 0, 0)
                setElementDimension(sound, getElementDimension(vehicleElement))
                setElementInterior(sound, getElementInterior(vehicleElement))
                attachElements(sound, vehicleElement, chargingPortOffset[1], chargingPortOffset[2], chargingPortOffset[3])
            end

            streamedVehicleChargingPorts[vehicleElement] = math.max(0, streamedVehicleChargingPorts[vehicleElement] - 1 * delta / 800)
            if streamedVehicleChargingPorts[vehicleElement] <= 0 then
                streamedVehicleChargingPorts[vehicleElement] = nil
            end
        end

        renderStreamedChargers = false
    end

    for vehicleElement in pairs(chargingVehicles) do
        if isElement(vehicleElement) then
            local vehicleModel = getElementData(vehicleElement, "vehicle.customModel") or getElementModel(vehicleElement)
            local chargingOffset = chargingPortOffset[vehicleModel]

            if not chargingOffset then
                chargingOffset = {0, 0, 0}
            end

            local sound = playSound3D("sounds/plug.mp3", 0, 0, 0)
            setElementDimension(sound, getElementDimension(vehicleElement))
            setElementInterior(sound, getElementInterior(vehicleElement))
            attachElements(sound, vehicleElement, chargingOffset[1], chargingOffset[2], chargingOffset[3])
            streamedVehicleChargingPorts[vehicleElement] = 0
            renderStreamedChargers = false
        end
    end

    if renderStreamedChargers then
        handleSuperchargerPreRender(false)
        handleSuperchargerPedProcess(false, "low-99999999999")

        if isElement(chargerRenderTarget) then
            destroyElement(chargerRenderTarget)
        end
        chargerRenderTarget = nil

        if isElement(chargerShader) then
            destroyElement(chargerShader)
        end
        chargerShader = nil
    end
end

function pedsProcessedSuperchargers()
    for index = 1, #streamedChargers do
        local supercharger = superchargerList[streamedChargers[index]]

        if supercharger.pistolInHand or supercharger.pistolInVehicle then
            local cablePosX, cablePosY, cablePosZ = unpack(supercharger.cablePos)
            local pistolPosX, pistolPosY, pistolPosZ = getElementPosition(supercharger.pistol)

            local deltaX = pistolPosX - cablePosX
            local deltaY = pistolPosY - cablePosY
            local deltaZ = pistolPosZ - cablePosZ

            local currentX, currentY, currentZ = cablePosX, cablePosY, cablePosZ

            for segment = 1, 20 do
                local cableX, cableY, cableZ = findCablePos(cablePosX, cablePosY, cablePosZ, deltaX, deltaY, deltaZ, 1, segment)
                dxDrawLine3D(currentX, currentY, currentZ, cableX, cableY, cableZ, tocolor(0, 0, 0, 255), 2)
                currentX, currentY, currentZ = cableX, cableY, cableZ
            end
        else
            local cablePosX, cablePosY, cablePosZ = unpack(supercharger.cablePos)
            
            for i = 1, #supercharger.defaultCable do
                local defaultCableX, defaultCableY, defaultCableZ = unpack(supercharger.defaultCable[i])
                dxDrawLine3D(cablePosX, cablePosY, cablePosZ, defaultCableX, defaultCableY, defaultCableZ, tocolor(0, 0, 0, 255), 2)
                cablePosX, cablePosY, cablePosZ = defaultCableX, defaultCableY, defaultCableZ
            end
        end
    end
end

function renderNotInHand()
    local px, py, pz = getElementPosition(localPlayer)
    local cursorX, cursorY = getCursorPosition()

    if cursorX then
        cursorX = cursorX * screenX
        cursorY = cursorY * screenY
    end

    local tempHover = false
    local pedVeh = getPedOccupiedVehicle(localPlayer)

    if pedVeh then
        local vehicleModel = getElementData(pedVeh, "vehicle.customModel") or getElementModel(pedVeh)

        if chargingPortOffset[vehicleModel] then
            for i = 1, #streamedChargers, 1 do
                if isElementWithinColShape(pedVeh, superchargerList[streamedChargers[i]].vehicleCol) then
                    local charingPosX, charingPosY, charingPosZ = getChargingPortPosition(pedVeh)
                    local x, y = getScreenFromWorldPosition(charingPosX, charingPosY, charingPosZ, 32)

                    if x then
                        local alpha = getTickCount() % 1600 / 800

                        if alpha > 1 then
                            alpha = 2 - alpha
                        end
                        alpha = getEasingValue(alpha, "InOutQuad") * 255

                        for j = -1, 1, 2 do
                            for k = -1, 1, 2 do
                                dxDrawImage(x - 16 + j, y - 16 + k, 32, 32, ":sGui/" .. boltIcon .. faTicks[boltIcon], 0, 0, 0, tocolor(0, 0, 0, alpha))
                            end
                        end

                        dxDrawImage(x - 16, y - 16, 32, 32, ":sGui/" .. boltIcon .. faTicks[boltIcon], 0, 0, 0, tocolor(sightgreen2[1], sightgreen2[2], sightgreen2[3], alpha))
                    end
                end
            end
        end
    else
        for i = 1, #streamedChargers, 1 do
            local streamedCharger = streamedChargers[i]

            if streamedCharger then
                local charger = superchargerList[streamedCharger]

                if charger then
                    if charger.pistolInVehicle then
                        x, y, z = getElementPosition(charger.pistol)
                    elseif not charger.pistolInHand then
                        x = charger.pistolPos[1]
                        y = charger.pistolPos[2]
                        z = charger.pistolPos[3] + 0.25
                    end
                    if getElementInterior(localPlayer) == 1 and not charger.pistolInVehicle then
                        y = y - 0.14
                        z = z - 0.1
                    end

                    if x then
                        local distance = getDistanceBetweenPoints3D(x, y, z, px, py, pz)

                        if distance < 1.25 then
                            local x, y = getScreenFromWorldPosition(x, y, z, 32)

                            if x then
                                local alpha = (1 - math.max(0, (distance - 1) / 0.25)) * 255
                                dxDrawRectangle(x - 16, y - 16, 32, 32, tocolor(sightgrey1[1], sightgrey1[2], sightgrey1[3], alpha))

                                if cursorX and 255 <= alpha and x - 16 <= cursorX and y - 16 <= cursorY and cursorX <= x + 16 and cursorY <= y + 16 then
                                    tempHover = streamedCharger
                                    dxDrawImage(x - 12, y - 12, 24, 24, ":sGui/" .. boltIcon .. faTicks[boltIcon], 0, 0, 0, tocolor(sightgreen2[1], sightgreen2[2], sightgreen2[3], alpha))
                                else
                                    dxDrawImage(x - 12, y - 12, 24, 24, ":sGui/" .. boltIcon .. faTicks[boltIcon], 0, 0, 0, tocolor(255, 255, 255, alpha))
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    if tempHover ~= hoveredCharger then
        hoveredCharger = tempHover

        if hoveredCharger then
            exports.sGui:setCursorType("link")
            exports.sGui:showTooltip("Töltőfej felvétele")
        else
            exports.sGui:setCursorType("normal")
            exports.sGui:showTooltip(false)
        end
    end
end

function clickNotInHand(button, state)
    if state == "down" and hoveredCharger and button == "left" then
        if getTickCount() - lastButtonTry < 500 then
            return
        end
        triggerServerEvent("trySuperchargerPistolInHand", localPlayer, hoveredCharger)
        lastButtonTry = getTickCount()
    end
end

function getChargingPortPosition(vehicle)
    local chargingPortX, chargingPortY, chargingPortZ = getVehicleComponentPosition(vehicle, "chargingport", "world")
    
    if not chargingPortX then
        local vehicleMatrix = getElementMatrix(vehicle)
        
        if not vehicleMatrix then
            return getElementPosition(vehicle)
        end
        
        local vehicleModel = getElementData(vehicle, "vehicle.customModel") or getElementModel(vehicle)
        
        if chargingPortOffset[vehicleModel] then
            local offset = chargingPortOffset[vehicleModel]
            chargingPortX = vehicleMatrix[4][1] + offset[1] * vehicleMatrix[1][1] + offset[2] * vehicleMatrix[2][1] + offset[3] * vehicleMatrix[3][1]
            chargingPortY = vehicleMatrix[4][2] + offset[1] * vehicleMatrix[1][2] + offset[2] * vehicleMatrix[2][2] + offset[3] * vehicleMatrix[3][2]
            chargingPortZ = vehicleMatrix[4][3] + offset[1] * vehicleMatrix[1][3] + offset[2] * vehicleMatrix[2][3] + offset[3] * vehicleMatrix[3][3]
        else
            chargingPortX = vehicleMatrix[4][1]
            chargingPortY = vehicleMatrix[4][2]
            chargingPortZ = vehicleMatrix[4][3]
        end
    end
    
    return chargingPortX, chargingPortY, chargingPortZ
end

addEvent("syncSuperchargerUser", true)
addEventHandler("syncSuperchargerUser", getRootElement(), function(charger, target)
    local supercharger = superchargerList[charger]

    if pistolInHand == charger then
        pistolInHand = false

        handleRenderInHand(false)
        handleClickInHand(false)
        handleClickNotInHand(0 < #streamedChargers)
        handleRenderNotInHand(0 < #streamedChargers)

        if hoveredCharger or hoveredElement then
            exports.sGui:setCursorType("normal")
            exports.sGui:showTooltip(false)
        end

        hoveredCharger = false
        hoveredElement = false
    end

    detachElements(supercharger.pistol)
    exports.sPattach:detach(supercharger.pistol)

    local pistolInVehicle = supercharger.pistolInVehicle
    supercharger.pistolInHand = false
    supercharger.pistolInVehicle = false

    if supercharger.streamedIn then
        engineRemoveShaderFromWorldTexture(chargerShader, "v4_plugsee_led", supercharger.object)
    end

    if isElement(target) then
        if target == localPlayer then
            pistolInHand = charger

            handleRenderInHand(true)
            handleClickInHand(true)
            handleClickNotInHand(false)
            handleRenderNotInHand(false)

            if hoveredCharger or hoveredElement then
                exports.sGui:setCursorType("normal")
                exports.sGui:showTooltip(false)
            end
    
            hoveredCharger = false
            hoveredElement = false
        end

        if getElementType(target) == "player" then
            exports.sPattach:attach(supercharger.pistol, target, "right-hand", 0.1, 0.05, 0, 0, 0, 110)
            exports.sPattach:disableScreenCheck(supercharger.pistol, true)
            supercharger.pistolInHand = target

            if supercharger.streamedIn then
                local pistolPosX = supercharger.pistolPos[1]
                local pistolPosY = supercharger.pistolPos[2]
                local pistolPosZ = supercharger.pistolPos[3]

                if pistolInVehicle then
                    if isElement(pistolInVehicle) then
                        pistolPosX, pistolPosY, pistolPosZ = getChargingPortPosition(pistolInVehicle)
                    end

                    local sound = playSound3D("sounds/plugout.mp3", pistolPosX, pistolPosY, pistolPosZ)
                    setElementInterior(sound, supercharger.interior or 0)
                    setElementDimension(sound, supercharger.dimension or 0)
                else
                    local sound = playSound3D("sounds/pickup.mp3", pistolPosX, pistolPosY, pistolPosZ)
                    setElementInterior(sound, supercharger.interior or 0)
                    setElementDimension(sound, supercharger.dimension or 0)
                end
            end
        elseif getElementType(target) == "vehicle" then
            if supercharger.streamedIn then
                engineApplyShaderToWorldTexture(chargerShader, "v4_plugsee_led", supercharger.object)
            end

            local chargingPortX, chargingPortY, chargingPortZ = 0, 0, 0
            local chargingRotY, chargingRotZ = 0, 0

            local vehicleModel = getElementData(target, "vehicle.customModel") or getElementModel(target)
            if chargingPortOffset[vehicleModel] then
                chargingPortX, chargingPortY, chargingPortZ, chargingRotY, chargingRotZ = unpack(chargingPortOffset[vehicleModel])
            end

            attachElements(supercharger.pistol, target, chargingPortX, chargingPortY, chargingPortZ, 0, chargingRotY, chargingRotZ)
            supercharger.pistolInVehicle = target

            if supercharger.streamedIn then
                local soundPosX, soundPosY, soundPosZ = getChargingPortPosition(supercharger.pistolInVehicle)
                local sound = playSound3D("sounds/plugin.mp3", soundPosX, soundPosY, soundPosZ)
                setElementInterior(sound, supercharger.interior or 0)
                setElementDimension(sound, supercharger.dimension or 0)
            end
        end
    else
        setElementPosition(supercharger.pistol, supercharger.pistolPos[1], supercharger.pistolPos[2], supercharger.pistolPos[3])
        if charger == #superchargerList then
            setElementRotation(supercharger.pistol, 0, -50, supercharger.pos[4])
        else
            setElementRotation(supercharger.pistol, 0, -10, supercharger.pos[4])
        end

        if supercharger.streamedIn then
            local sound = playSound3D("sounds/pickup.mp3", supercharger.pistolPos[1], supercharger.pistolPos[2], supercharger.pistolPos[3])
            setElementInterior(sound, supercharger.interior or 0)
            setElementDimension(sound, supercharger.dimension or 0)
        end
    end
end)

function renderInHand()
    local px, py, pz = getElementPosition(localPlayer)
    local cursorX, cursorY = getCursorPosition()

    if cursorX then
        cursorX = cursorX * screenX
        cursorY = cursorY * screenY
    end

    local tempHover = false

    local charger = superchargerList[pistolInHand]
    local pistolPosX = charger.pistolPos[1]
    local pistolPosY = charger.pistolPos[2]
    local pistolPosZ = charger.pistolPos[3] + 0.25

    local distance = getDistanceBetweenPoints3D(pistolPosX, pistolPosY, pistolPosZ, px, py, pz)

    if distance < 1.25 then

        if getElementInterior(localPlayer) == 1 and not charger.pistolInVehicle then
            pistolPosY = pistolPosY - 0.14
            pistolPosZ = pistolPosZ - 0.1
        end

        local x, y = getScreenFromWorldPosition(pistolPosX, pistolPosY, pistolPosZ, 32)

        if x then
            local alpha = (1 - math.max(0, (distance - 1) / 0.25)) * 255
            dxDrawRectangle(x - 16, y - 16, 32, 32, tocolor(sightgrey1[1], sightgrey1[2], sightgrey1[3], alpha))

            if cursorX and 255 <= alpha and x - 16 <= cursorX and y - 16 <= cursorY and cursorX <= x + 16 and cursorY <= y + 16 then
                tempHover = true
                dxDrawImage(x - 12, y - 12, 24, 24, ":sGui/" .. boltIcon .. faTicks[boltIcon], 0, 0, 0, tocolor(sightgreen2[1], sightgreen2[2], sightgreen2[3], alpha))
            else
                dxDrawImage(x - 12, y - 12, 24, 24, ":sGui/" .. boltIcon .. faTicks[boltIcon], 0, 0, 0, tocolor(255, 255, 255, alpha))
            end
        end
    end

    local chargeVehicles = getElementsWithinColShape(charger.vehicleCol, "vehicle")

    for i = 1, #chargeVehicles, 1 do
        local vehicle = chargeVehicles[i]

        if streamedVehicleChargingPorts[vehicle] and 1 <= streamedVehicleChargingPorts[vehicle] then
            local chargingPosX, chargingPosY, chargingPosZ = getChargingPortPosition(vehicle)
            local distance = getDistanceBetweenPoints3D(px, py, pz, chargingPosX, chargingPosY, chargingPosZ)

            if distance < 1.25 then
                local x, y = getScreenFromWorldPosition(chargingPosX, chargingPosY, chargingPosZ, 32)

                if x then
                    local alpha = (1 - math.max(0, (distance - 1) / 0.25)) * 255
                    dxDrawRectangle(x - 16, y - 16, 32, 32, tocolor(sightgrey1[1], sightgrey1[2], sightgrey1[3], alpha))
        
                    if cursorX and 255 <= alpha and x - 16 <= cursorX and y - 16 <= cursorY and cursorX <= x + 16 and cursorY <= y + 16 then
                        tempHover = vehicle
                        dxDrawImage(x - 12, y - 12, 24, 24, ":sGui/" .. boltIcon .. faTicks[boltIcon], 0, 0, 0, tocolor(sightgreen2[1], sightgreen2[2], sightgreen2[3], alpha))
                    else
                        dxDrawImage(x - 12, y - 12, 24, 24, ":sGui/" .. boltIcon .. faTicks[boltIcon], 0, 0, 0, tocolor(255, 255, 255, alpha))
                    end
                end
            end
        end
    end

    if tempHover ~= hoverElement then
        hoveredElement = tempHover

        if tempHover then
            cursorType = "link"
        else
            cursorType = "normal"
        end
        exports.sGui:setCursorType(cursorType)

        if isElement(tempHover) then
            exports.sGui:showTooltip("Töltőfej bedugása\nTöltési díj: " .. exports.sGui:thousandsStepper(charger.chargingPrice) .. " $/perc")
        elseif tempHover then
            exports.sGui:showTooltip("Töltőfej visszahelyezése")
        else
            exports.sGui:showTooltip(false)
        end
    end

    if isPedInVehicle(localPlayer) or 3 < distance then
        triggerServerEvent("trySuperchargerPistolInHand", localPlayer)
        handleRenderInHand(false)
    end
end

function clickInHand(button, state)
    if state == "down" and button == "left" then
        if getTickCount() - lastButtonTry < 500 then
            return
        end
        if isElement(hoveredElement) then
            triggerServerEvent("putSuperchargerPistolInVehicle", localPlayer, hoveredElement)
        elseif hoveredElement then
            triggerServerEvent("trySuperchargerPistolInHand", localPlayer)
        end

        lastButtonTry = getTickCount()
    end
end

local bebasBold = exports.sGui:getFont("14/BebasNeueBold.otf")
local bebasRegular = exports.sGui:getFont("12/BebasNeueBold.otf")
local bebasBig = exports.sGui:getFont("50/BebasNeueRegular.otf")

function renderSpeedo()
    dxDrawRectangle(x + 43, y + 43, 16, 24, sightgreen)
    dxDrawText("R", x + 27, y + 43, x + 43, y + 67, -1, 0.5, bebasBold, "center", "center")
    dxDrawText("N", x + 43, y + 43, x + 59, y + 67, -1, 0.5, bebasBold, "center", "center")
    dxDrawText("D", x + 59, y + 43, x + 75, y + 67, -1, 0.5, bebasBold, "center", "center")
    dxDrawRectangle(x + 341, y + 8, 6, 105)
    dxDrawRectangle(x + 341, y + 8, 6, 105, -1)
    dxDrawText("0 km", 0, 0, x + 347, y + -80.22222328186, tocolor(255, 255, 255, 53), 0.44444444444444, bebasRegular, "right", "bottom")
    dxDrawText("Tesla Model Y", 0, 0, x + 347, y + -58, tocolor(255, 255, 255, 255), 0.55555555555556, bebasRegular, "right", "bottom")
    dxDrawText("98%", 0, y + 99, x + 335, y + 99, -1, 0.5, bebasRegular, "right", "center")
    dxDrawImage(x + 258, y + 85, 28, 28, "files/right.dds", 0, 0, 0, tocolor(255, 255, 255, 53))
    dxDrawImage(x + 223, y + 85, 28, 28, "files/left.dds", 0, 0, 0, tocolor(255, 255, 255, 53))
    dxDrawImage(x + 188, y + 85, 28, 28, "files/belt.dds", 0, 0, 0, tocolor(255, 255, 255, 53))
    dxDrawImage(x + 153, y + 85, 28, 28, "files/engine.dds", 0, 0, 0, tocolor(255, 255, 255, 53))
    dxDrawRectangle(x + 27, y + 75, 308, 3)
    dxDrawRectangle(x + 88.6, y + 75, 0, 3)
    dxDrawText("KM/H", 0, 0, x + 235.5, y + 67, -1, 0.5, bebasBold, "right", "bottom")
    dxDrawText(0, 0, 0, x + 274, y + 79, tocolor(255, 255, 255, 53), 0.5, bebasBig, "right", "bottom")
    dxDrawText(0, 0, 0, x + 304.5, y + 79, tocolor(255, 255, 255, 53), 0.5, bebasBig, "right", "bottom")
    dxDrawText(0, 0, 0, x + 335, y + 79, tocolor(255, 255, 255, 53), 0.5, bebasBig, "right", "bottom")
    
end

function fromcolor(color)
    local r = bitExtract(color, 16, 8)
    local g = bitExtract(color, 8, 8)
    local b = bitExtract(color, 0, 8)
    local a = bitExtract(color, 24, 8)
    return r, g, b, a
end