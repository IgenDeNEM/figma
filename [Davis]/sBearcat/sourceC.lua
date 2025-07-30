local sightexports = {
	sGui = false,
    sCore = false
}

local screenX, screenY = guiGetScreenSize()

function sightlangProcessExports()
	for k in pairs(sightexports) do
		local res = getResourceFromName(k)
		if res and getResourceState(res) == "running" then
			sightexports[k] = exports[k]
		else
			sightexports[k] = false
		end
	end
    triggerServerEvent("requestBearcatPassangers", localPlayer)
end

sightlangProcessExports()
if triggerServerEvent then
	addEventHandler("onClientResourceStart", getRootElement(), sightlangProcessExports, true, "high+9999999999")
end
if triggerClientEvent then
	addEventHandler("onResourceStart", getRootElement(), sightlangProcessExports, true, "high+9999999999")
end

function sightlangGuiRefreshColors()
	local res = getResourceFromName("sGui")
	if res and getResourceState(res) == "running" then
		removeIcon = sightexports.sGui:getFaIconFilename("hand-rock", 24)
		btnCol = sightexports.sGui:getColorCodeToColor("sightgreen")
		btnBcg = sightexports.sGui:getColorCodeToColor("sightgrey1")
		faTicks = sightexports.sGui:getFaTicks()
		gradientTicks = sightexports.sGui:getGradientTick()
	end
end
addEventHandler("onGuiRefreshColors", getRootElement(), sightlangGuiRefreshColors)
addEventHandler("onClientResourceStart", resourceRoot, sightlangGuiRefreshColors)

addEventHandler("refreshFaTicks", getRootElement(), function()
	faTicks = sightexports.sGui:getFaTicks()
end)

local streamedBearcats = {}

local bearcatPassangers = {}

function onStreamIn()
    if getElementModel(source) == 528 then
        table.insert(streamedBearcats, source)
        setVehicleDamageProof(source, true)
    end
end
addEventHandler("onClientVehicleStreamIn", root, onStreamIn)

function onSpawn ( )
    for k, v in pairs(getElementsByType("vehicle", root, true)) do
        if getElementModel(v) == 528 then
            local found = false
            for key, value in pairs(streamedBearcats) do
                if value == v then
                    found = true
                end
                break
            end
            if not found then
                table.insert(streamedBearcats, v)
                setVehicleDamageProof(v, true)
            end
        end
    end
end
addEventHandler ( "onClientPlayerSpawn", getLocalPlayer(), onSpawn )

function onStreamOut()
    if getElementModel(source) == 528 then
        for k, v in pairs(streamedBearcats) do
            if v == source then
                table.remove(streamedBearcats, k)
            end
        end
    end
end
addEventHandler("onClientVehicleStreamOut", root, onStreamOut)

function onStart()
    for k, v in pairs(getElementsByType("vehicle", root, true)) do
        if getElementModel(v) == 528 then
            table.insert(streamedBearcats, v)
            setVehicleDamageProof(v, true)
        end
    end
end
addEventHandler("onClientResourceStart", resourceRoot, onStart)

local ys = 17.77777777777778

function renderIcons()

    hoveringCar = nil
    hoveringSlot = nil

    local cx, cy = getCursorPosition()
    if cx then
        cx = cx * screenX
        cy = cy * screenY
    else
        if hoveringCar then
            sightexports.sGui:setCursorType("normal")
            sightexports.sGui:showTooltip()
        end
        hoveringCar = nil
        hoveringSlot = nil
    end
    if not playerOnBearcat then
        for k, v in pairs(streamedBearcats) do
            if isElement(v) then
                local px, py, pz = getElementPosition(localPlayer)
                local vx, vy, vz = getElementPosition(v)

                if getDistanceBetweenPoints3D(px, py, pz, vx, vy, vz) < 3 and getPedOccupiedVehicle(localPlayer) == false then

                    if not bearcatPassangers[v] then
                        bearcatPassangers[v] = {}
                    end
                    if cx then
                        for i = 1, #offsets do
                            local x, y, z = getPositionFromElementOffset(v, offsets[i][1], offsets[i][2], offsets[i][3])
                            local x, y = getScreenFromWorldPosition(x, y, z, 128)
                            if x and y and not bearcatPassangers[v][i] then
                                dxDrawRectangle(x - 16, y - 32 - 3, 32, 32, btnBcg)
                                if cx and cx <= x + 16 and cx >= x - 16 and cy >= y - 32 - 3 and cy <= y - 3 then
                                    dxDrawImage(x - 12, y - 16 - 3 - 12, 24, 24, ":sGui/" .. removeIcon .. (faTicks[removeIcon] or ""), 0, 0, 0, btnCol)
                                    sightexports.sGui:showTooltip("Felkapaszkodás")
                                    hoveringCar = v
                                    hoveringSlot = i

                                    sightexports.sGui:setCursorType(hoveringCar and "link" or "normal")

                                else
                                    dxDrawImage(x - 12, y - 16 - 3 - 12, 24, 24, ":sGui/" .. removeIcon .. (faTicks[removeIcon] or ""), 0, 0, 0)
                                    if not hoveringCar then
                                        sightexports.sGui:showTooltip()
                                        sightexports.sGui:setCursorType("normal")
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end

end
addEventHandler("onClientRender", getRootElement(), renderIcons)

function onClientPedsProcessedCart()

    for k, v in pairs(streamedBearcats) do
        if bearcatPassangers[v] then
            for i = 1, #offsets do
                
                local player = bearcatPassangers[v][i]
                if player then
                    setElementBoneRotation(player, 2, 0, -0, 0)
                    setElementBoneRotation(player, 3, 0, -0, 0)
                    setElementBoneRotation(player, 22, 13.043463333793, -49.565267148225, 20.869540338931)
                    setElementBoneRotation(player, 23, -33.912973818572, -57.391204833984, 5.4732612909447E-5)
                    setElementBoneRotation(player, 32, -13.043463333793, -49.565267148225, -20.869540338931)
                    setElementBoneRotation(player, 33, -33.912973818572, -57.391204833984, 5.4732612909447E-5)
                    sightexports.sCore:updateElementRpHAnim(player)


                    local rx, ry, rz = getElementRotation(v)
                    if i == 3 or i == 4 then
                        setElementRotation(player, 360 + (ry - offsets[i][4]), 360 - (rx + offsets[i][5]), 360 - (rz + offsets[i][6]))
                    else
                        setElementRotation(player, 360 - (ry + offsets[i][4]), 360 + (rx - offsets[i][5]), 360 - (rz - offsets[i][6]))
                    end
                end
            end
        end
    end
end
addEventHandler("onClientPedsProcessed", getRootElement(), onClientPedsProcessedCart)

function clickIcons(btn, state)
	if hoveringSlot and hoveringCar and state == "up" then
        triggerServerEvent("standOnBearcat", localPlayer, hoveringCar, hoveringSlot)
    end
end
addEventHandler("onClientClick", getRootElement(), clickIcons)

addEvent("gotNewBearcatPassanger", true)
addEventHandler("gotNewBearcatPassanger", root, function(truck, slot, on)

    if source == localPlayer and on then
        playerOnBearcat = truck

        playerBearcatSlot = slot

        sightexports.sGui:showInfobox("i", "A [Backspace] gomb megnyomásával tudsz leszállni a Bearcatről.")

        sightexports.sGui:showTooltip()
        sightexports.sGui:setCursorType("normal")
    end
    if on then
        if not bearcatPassangers[truck] then
            bearcatPassangers[truck] = {}
        end
        bearcatPassangers[truck][slot] = source
    else
        if not bearcatPassangers[truck] then
            bearcatPassangers[truck] = {}
        end
        bearcatPassangers[truck][slot] = false

        if source == localPlayer then
            playerOnBearcat = false

            playerBearcatSlot = false
        end
    end
end)

function onKey(key, state)
    if key == "backspace" and playerOnBearcat and not isCursorShowing() and not isChatBoxInputActive() and state then

        local speed = getElementSpeed(playerOnBearcat, "km/h")
        if speed < 2 then
            triggerServerEvent("getOffBearcat", localPlayer, playerOnBearcat, playerBearcatSlot)

            playerBearcatSlot = false
            playerOnBearcat = false
        else
            exports.sGui:showInfobox("e", "Menet közben nem szállhatsz le!")
        end
    end
end
addEventHandler("onClientKey", root, onKey)

addEvent("gotAllBearcatPassangers", true)
addEventHandler("gotAllBearcatPassangers", root, function(passangers)
    bearcatPassangers = passangers
end)

addEventHandler("onClientElementDestroy", root, function()
	if getElementType(source) == "vehicle" and getElementModel(source) == 528 then
        for k, v in pairs(streamedBearcats) do
            if v == source then
                table.remove(streamedBearcats, k)
            end
        end
	end
end)