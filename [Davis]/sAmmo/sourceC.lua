local sightexports = {
    sGui = false,
    sItems = false,
    sModloader = false,
    sCrate = false,
    sPattach = false,
}

local function sightlangProcessExports()
    for k in pairs(sightexports) do
        local res = getResourceFromName(k)
        if res and getResourceState(res) == "running" then
            sightexports[k] = exports[k]
        else
            sightexports[k] = false
        end
    end
end

sightlangProcessExports()

if triggerServerEvent then
    addEventHandler("onClientResourceStart", getRootElement(), sightlangProcessExports, true, "high+9999999999")
end
if triggerClientEvent then
    addEventHandler("onResourceStart", getRootElement(), sightlangProcessExports, true, "high+9999999999")
end

local sightlangStatImgHand = false
local sightlangStaticImage = {}
local sightlangStaticImageToc = {}
local sightlangStaticImageUsed = {}
local sightlangStaticImageDel = {}
local processsightlangStaticImage = {}
sightlangStaticImageToc[0] = true
sightlangStaticImageToc[1] = true
sightlangStaticImageToc[2] = true
sightlangStaticImageToc[3] = true
local sightlangStatImgPre = nil

function sightlangStatImgPre()
    local now = getTickCount()
    if sightlangStaticImageUsed[0] then
        sightlangStaticImageUsed[0] = false
        sightlangStaticImageDel[0] = false
    elseif sightlangStaticImage[0] then
        if sightlangStaticImageDel[0] then
            if sightlangStaticImageDel[0] <= now then
                if isElement(sightlangStaticImage[0]) then
                    destroyElement(sightlangStaticImage[0])
                end
                sightlangStaticImage[0] = nil
                sightlangStaticImageDel[0] = false
                sightlangStaticImageToc[0] = true
                return 
            end
        else
            sightlangStaticImageDel[0] = now + 5000
        end
    else
        sightlangStaticImageToc[0] = true
    end
    if sightlangStaticImageUsed[1] then
        sightlangStaticImageUsed[1] = false
        sightlangStaticImageDel[1] = false
    elseif sightlangStaticImage[1] then
        if sightlangStaticImageDel[1] then
            if sightlangStaticImageDel[1] <= now then
                if isElement(sightlangStaticImage[1]) then
                    destroyElement(sightlangStaticImage[1])
                end
                sightlangStaticImage[1] = nil
                sightlangStaticImageDel[1] = false
                sightlangStaticImageToc[1] = true
                return 
            end
        else
            sightlangStaticImageDel[1] = now + 5000
        end
    else
        sightlangStaticImageToc[1] = true
    end
    if sightlangStaticImageUsed[2] then
        sightlangStaticImageUsed[2] = false
        sightlangStaticImageDel[2] = false
    elseif sightlangStaticImage[2] then
        if sightlangStaticImageDel[2] then
            if sightlangStaticImageDel[2] <= now then
                if isElement(sightlangStaticImage[2]) then
                    destroyElement(sightlangStaticImage[2])
                end
                sightlangStaticImage[2] = nil
                sightlangStaticImageDel[2] = false
                sightlangStaticImageToc[2] = true
                return 
            end
        else
            sightlangStaticImageDel[2] = now + 5000
        end
    else
        sightlangStaticImageToc[2] = true
    end
    if sightlangStaticImageUsed[3] then
        sightlangStaticImageUsed[3] = false
        sightlangStaticImageDel[3] = false
    elseif sightlangStaticImage[3] then
        if sightlangStaticImageDel[3] then
            if sightlangStaticImageDel[3] <= now then
                if isElement(sightlangStaticImage[3]) then
                    destroyElement(sightlangStaticImage[3])
                end
                sightlangStaticImage[3] = nil
                sightlangStaticImageDel[3] = false
                sightlangStaticImageToc[3] = true
                return 
            end
        else
            sightlangStaticImageDel[3] = now + 5000
        end
    else
        sightlangStaticImageToc[3] = true
    end
    if sightlangStaticImageToc[0] and sightlangStaticImageToc[1] and sightlangStaticImageToc[2] and sightlangStaticImageToc[3] then
        sightlangStatImgHand = false
        removeEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre)
    end
end
processsightlangStaticImage[0] = function()
    if not isElement(sightlangStaticImage[0]) then
        sightlangStaticImageToc[0] = false
        sightlangStaticImage[0] = dxCreateTexture("files/circle1.dds", "argb", true)
    end
    if not sightlangStatImgHand then
        sightlangStatImgHand = true
        addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
    end
end
processsightlangStaticImage[1] = function()
    if not isElement(sightlangStaticImage[1]) then
        sightlangStaticImageToc[1] = false
        sightlangStaticImage[1] = dxCreateTexture("files/arrow.dds", "argb", true)
    end
    if not sightlangStatImgHand then
        sightlangStatImgHand = true
        addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
    end
end
processsightlangStaticImage[2] = function()
    if not isElement(sightlangStaticImage[2]) then
        sightlangStaticImageToc[2] = false
        sightlangStaticImage[2] = dxCreateTexture("files/circle2.dds", "argb", true)
    end
    if not sightlangStatImgHand then
        sightlangStatImgHand = true
        addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
    end
end
processsightlangStaticImage[3] = function()
    if not isElement(sightlangStaticImage[3]) then
        sightlangStaticImageToc[3] = false
        sightlangStaticImage[3] = dxCreateTexture("files/circle3.dds", "argb", true)
    end
    if not sightlangStatImgHand then
        sightlangStatImgHand = true
        addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
    end
end
local sightlangWaiterState0 = false

local function sightlangProcessResWaiters()
    if not sightlangWaiterState0 then
        local res0 = getResourceFromName("sItems")
        if res0 and getResourceState(res0) == "running" then
            itemsReady()
            sightlangWaiterState0 = true
        end
    end
end

if triggerServerEvent then
    addEventHandler("onClientResourceStart", getRootElement(), sightlangProcessResWaiters)
end
if triggerClientEvent then
    addEventHandler("onResourceStart", getRootElement(), sightlangProcessResWaiters)
end

local green = false
local greenToColor = false
local orange = false
local red = false
local grey1 = false
local blueHex = false
local redHex = false
local greenHex = false
local grabIcon = false
local downIcon = false
local faTicks = false
local function sightlangGuiRefreshColors()
    local res = getResourceFromName("sGui")
    if res and getResourceState(res) == "running" then
        green = sightexports.sGui:getColorCode("sightgreen")
        greenToColor = sightexports.sGui:getColorCodeToColor("sightgreen")
        orange = sightexports.sGui:getColorCode("sightorange")
        red = sightexports.sGui:getColorCode("sightred")
        grey1 = sightexports.sGui:getColorCode("sightgrey1")
        blueHex = sightexports.sGui:getColorCodeHex("sightblue")
        redHex = sightexports.sGui:getColorCodeHex("sightred")
        greenHex = sightexports.sGui:getColorCodeHex("sightgreen")
        grabIcon = sightexports.sGui:getFaIconFilename("hand-rock", 24)
        downIcon = sightexports.sGui:getFaIconFilename("arrow-alt-down", 24)
        faTicks = sightexports.sGui:getFaTicks()
    end
end
addEventHandler("onGuiRefreshColors", getRootElement(), sightlangGuiRefreshColors)
addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangGuiRefreshColors)

addEventHandler("refreshFaTicks", getRootElement(), function()
    faTicks = sightexports.sGui:getFaTicks()
end)
local function sightlangModloaderLoaded()
    modloaderLoaded()
end
addEventHandler("modloaderLoaded", getRootElement(), sightlangModloaderLoaded)
if getElementData(localPlayer, "loggedIn") or sightexports.sModloader and sightexports.sModloader:isModloaderLoaded() then
    addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangModloaderLoaded)
end

local sightlangCondHandlState1 = false
local function checkMinigameRender(cond, prio)
	cond = cond and true or false
    if cond ~= sightlangCondHandlState1 then
        sightlangCondHandlState1 = cond
        if cond then
            addEventHandler("onClientRender", getRootElement(), minigameRender, true, prio)
        else
            removeEventHandler("onClientRender", getRootElement(), minigameRender)
        end
    end
end
local sightlangCondHandlState2 = false
local function checkMinigameKey(cond, prio)
	cond = cond and true or false
    if cond ~= sightlangCondHandlState2 then
        sightlangCondHandlState2 = cond
        if cond then
            addEventHandler("onClientKey", getRootElement(), minigameKey, true, prio)
        else
            removeEventHandler("onClientKey", getRootElement(), minigameKey)
        end
    end
end
local sightlangCondHandlState3 = false
local function checkMinigamePreRender(cond, prio)
	cond = cond and true or false
    if cond ~= sightlangCondHandlState3 then
        sightlangCondHandlState3 = cond
        if cond then
            addEventHandler("onClientPreRender", getRootElement(), minigamePreRender, true, prio)
        else
            removeEventHandler("onClientPreRender", getRootElement(), minigamePreRender)
        end
    end
end
local sightlangCondHandlState4 = false
local function checkPreRenderSmallMachineAnimation(cond, prio)
	cond = cond and true or false
    if cond ~= sightlangCondHandlState4 then
        sightlangCondHandlState4 = cond
        if cond then
            addEventHandler("onClientPreRender", getRootElement(), preRenderSmallMachineAnimation, true, prio)
        else
            removeEventHandler("onClientPreRender", getRootElement(), preRenderSmallMachineAnimation)
        end
    end
end
local sightlangCondHandlState5 = false
local function checkPreRenderPressMachineAnimation(cond, prio)
	cond = cond and true or false
    if cond ~= sightlangCondHandlState5 then
        sightlangCondHandlState5 = cond
        if cond then
            addEventHandler("onClientPreRender", getRootElement(), preRenderPressMachineAnimation, true, prio)
        else
            removeEventHandler("onClientPreRender", getRootElement(), preRenderPressMachineAnimation)
        end
    end
end
local sightlangCondHandlState6 = false
local function checkClickMachines(cond, prio)
	cond = cond and true or false
    if cond ~= sightlangCondHandlState6 then
        sightlangCondHandlState6 = cond
        if cond then
            addEventHandler("onClientClick", getRootElement(), clickMachines, true, prio)
        else
            removeEventHandler("onClientClick", getRootElement(), clickMachines)
        end
    end
end
local sightlangCondHandlState7 = false
local function checkRenderMachines(cond, prio)
	cond = cond and true or false
    if cond ~= sightlangCondHandlState7 then
        sightlangCondHandlState7 = cond
        if cond then
            addEventHandler("onClientRender", getRootElement(), renderMachines, true, prio)
        else
            removeEventHandler("onClientRender", getRootElement(), renderMachines)
        end
    end
end

local models = {}
local screenX, screenY = guiGetScreenSize()
local currentMachine = false
local currentAction = false
local smallMachineWindow = false
local hoveredMachine = false
function renderMachines()
    local tmpMachine = false
    local tmpAction = false
    local px, py, pz = getElementPosition(localPlayer)
    local cursorX, cursorY = getCursorPosition()
    if cursorX then
        cursorX = cursorX * screenX
        cursorY = cursorY * screenY
    end
    for machineId = 1, #pressMachines, 1 do
        local machine = pressMachines[machineId]
        if machine.streamedIn and not machine.animation and machine.item then
            local machineX = machine[1]
            local machineY = machine[2]
            local machineZ = machine[3]
            local worldX, worldY = getScreenFromWorldPosition(machineX, machineY, machineZ, 16)
            if worldX then
                local dist = getDistanceBetweenPoints3D(machineX, machineY, machineZ, px, py, pz)
                if dist < 1.75 then
                    local alpha = (1 - math.max(0, (dist - 1.25) / 0.5)) * 255
                    dxDrawRectangle(worldX - 16, worldY - 16, 32, 32, tocolor(grey1[1], grey1[2], grey1[3], alpha))
                    if cursorX and 255 <= alpha and worldX - 16 <= cursorX and worldY - 16 <= cursorY and cursorX <= worldX + 16 and cursorY <= worldY + 16 then
                        tmpMachine = machineId
                        tmpAction = "shellFromPress"
                        dxDrawImage(worldX - 12, worldY - 12, 24, 24, ":sGui/" .. downIcon .. faTicks[downIcon], 180, 0, 0, greenToColor)
                    else
                        dxDrawImage(worldX - 12, worldY - 12, 24, 24, ":sGui/" .. downIcon .. faTicks[downIcon], 180, 0, 0, tocolor(255, 255, 255, alpha))
                    end
                end
            end
        end
    end
    for machineId = 1, #smallMachines, 1 do
        local machine = smallMachines[machineId]
        if hoveredMachine == machineId then
            if machine.streamedIn then
                if getDistanceBetweenPoints3D(machine.shellCoords[1], machine.shellCoords[2], machine.shellCoords[3], px, py, pz) > 1.25 then
                    closeSmallMachineWindow()
                end
            else
                closeSmallMachineWindow()
            end
        elseif machine.streamedIn and not machine.animation then
            if machine.item then
                if machine.pressed then
                    local machineX = machine.shellCoords[1]
                    local machineY = machine.shellCoords[2]
                    local machineZ = machine.shellCoords[3]
                    local worldX, worldY = getScreenFromWorldPosition(machineX, machineY, machineZ, 16)
                    if worldX then
                        local dist = getDistanceBetweenPoints3D(machineX, machineY, machineZ, px, py, pz)
                        if dist < 1.75 then
                            local alpha = (1 - math.max(0, (dist - 1.25) / 0.5)) * 255
                            dxDrawRectangle(worldX - 16, worldY - 16, 32, 32, tocolor(grey1[1], grey1[2], grey1[3], alpha))
                            if cursorX and 255 <= alpha and worldX - 16 <= cursorX and worldY - 16 <= cursorY and cursorX <= worldX + 16 and cursorY <= worldY + 16 then
                                tmpMachine = machineId
                                tmpAction = "takeSmallMachineShell"
                                dxDrawImage(worldX - 12, worldY - 12, 24, 24, ":sGui/" .. downIcon .. faTicks[downIcon], 180, 0, 0, greenToColor)
                            else
                                dxDrawImage(worldX - 12, worldY - 12, 24, 24, ":sGui/" .. downIcon .. faTicks[downIcon], 180, 0, 0, tocolor(255, 255, 255, alpha))
                            end
                        end
                    end
                else
                    local machineX = machine.grabCoords[1]
                    local machineY = machine.grabCoords[2]
                    local machineZ = machine.grabCoords[3]
                    local worldX, worldY = getScreenFromWorldPosition(machineX, machineY, machineZ, 16)
                    if worldX then
                        local dist = getDistanceBetweenPoints3D(machineX, machineY, machineZ, px, py, pz)
                        if dist < 1.75 then
                            local alpha = (1 - math.max(0, (dist - 1.25) / 0.5)) * 255
                            dxDrawRectangle(worldX - 16, worldY - 16, 32, 32, tocolor(grey1[1], grey1[2], grey1[3], alpha))
                            if cursorX and 255 <= alpha and worldX - 16 <= cursorX and worldY - 16 <= cursorY and cursorX <= worldX + 16 and cursorY <= worldY + 16 then
                                tmpMachine = machineId
                                tmpAction = "pressSmallMachine"
                                dxDrawImage(worldX - 12, worldY - 12, 24, 24, ":sGui/" .. grabIcon .. faTicks[grabIcon], 0, 0, 0, greenToColor)
                            else
                                dxDrawImage(worldX - 12, worldY - 12, 24, 24, ":sGui/" .. grabIcon .. faTicks[grabIcon], 0, 0, 0, tocolor(255, 255, 255, alpha))
                            end
                        end
                    end
                end
            else
                local machineX = machine.shellCoords[1]
                local machineY = machine.shellCoords[2]
                local machineZ = machine.shellCoords[3]
                local worldX, worldY = getScreenFromWorldPosition(machineX, machineY, machineZ, 16)
                if worldX then
                    local dist = getDistanceBetweenPoints3D(machineX, machineY, machineZ, px, py, pz)
                    if dist < 1.75 then
                        local alpha = (1 - math.max(0, (dist - 1.25) / 0.5)) * 255
                        dxDrawRectangle(worldX - 16, worldY - 16, 32, 32, tocolor(grey1[1], grey1[2], grey1[3], alpha))
                        if cursorX and 255 <= alpha and worldX - 16 <= cursorX and worldY - 16 <= cursorY and cursorX <= worldX + 16 and cursorY <= worldY + 16 then
                            tmpMachine = machineId
                            tmpAction = "fillShell"
                            dxDrawImage(worldX - 12, worldY - 12, 24, 24, ":sGui/" .. downIcon .. faTicks[downIcon], 0, 0, 0, greenToColor)
                        else
                            dxDrawImage(worldX - 12, worldY - 12, 24, 24, ":sGui/" .. downIcon .. faTicks[downIcon], 0, 0, 0, tocolor(255, 255, 255, alpha))
                        end
                    end
                end
            end
        end
    end
    if tmpMachine ~= currentMachine or tmpAction ~= currentAction then
        if tmpMachine then
            sightexports.sGui:setCursorType("link")
            if tmpAction == "fillShell" then
                local selectedItem = smallMachines[tmpMachine].selected
                if selectedItem then
                    local text = "" .. blueHex .. "Bal kattintás: #ffffff" .. sightexports.sItems:getItemName(selectedItem) .. " legyártása\n"
                    if sightexports.sItems:playerHasItem(ammoCraft[selectedItem][3]) then
                        text = text .. greenHex
                    else
                        text = text .. redHex
                    end
                    text = text .. "   - 1 x " .. ammoCraft[selectedItem][5] .. "\n"
                    if sightexports.sItems:playerHasItemWithAmount(742, ammoCraft[selectedItem][1]) then
                        text = text .. greenHex
                    else
                        text = text .. redHex
                    end
                    sightexports.sGui:showTooltip(text .. "   - " .. ammoCraft[selectedItem][1] .. " x lőpor\n" .. blueHex .. "Jobb kattintás: #fffffftöltény kiválasztása")
                else
                    sightexports.sGui:showTooltip("Töltény kiválasztása")
                end
            elseif tmpAction == "takeSmallMachineShell" then
                sightexports.sGui:showTooltip("Töltény kivétele")
            elseif tmpAction == "pressSmallMachine" then
                sightexports.sGui:showTooltip("Töltény betöltése")
            elseif tmpAction == "shellFromPress" then
                sightexports.sGui:showTooltip(ammoCraft[pressMachines[tmpMachine].item][2] .. "db " .. ammoCraft[pressMachines[tmpMachine].item][5] .. " kivétele")
            end
        else
            sightexports.sGui:setCursorType("normal")
            sightexports.sGui:showTooltip()
        end
        currentMachine = tmpMachine
        currentAction = tmpAction
    end
end
local lastTakeTick = 0
local lastFillTick = 0
local lastShellTick = 0

function clickMachines(button, state)
    if state == "up" then
        local now = getTickCount()
        if currentAction == "fillShell" then
            if now < lastFillTick then
                return 
            end
            local selectedItem = smallMachines[currentMachine].selected
            if not selectedItem or button == "right" then
                createSmallMachineWindow()
            elseif button == "left" and sightexports.sItems:playerHasItem(ammoCraft[selectedItem][3]) and sightexports.sItems:playerHasItemWithAmount(742, ammoCraft[selectedItem][1]) then
                triggerServerEvent("fillAmmoShell", localPlayer, currentMachine, selectedItem)
                lastFillTick = now + 1000
            end
        elseif currentAction == "takeSmallMachineShell" then
            if now < lastShellTick then
                return 
            end
            triggerServerEvent("takeSmallMachineShell", localPlayer, currentMachine)
            lastShellTick = now + 1000
        else
            if now < lastTakeTick then
                return 
            end
            if currentAction == "shellFromPress" then
                triggerServerEvent("takePressMachineShell", localPlayer, currentMachine)
                lastTakeTick = now + 1000
            elseif currentAction == "pressSmallMachine" then
                triggerServerEvent("pressSmallMachine", localPlayer, currentMachine)
                lastTakeTick = now + 1000
            end
        end
    end
end

function closeSmallMachineWindow()
    if smallMachineWindow then
        sightexports.sGui:deleteGuiElement(smallMachineWindow)
    end
    smallMachineWindow = nil
    hoveredMachine = false
end
addEvent("closeSmallMachineWindow", false)
addEventHandler("closeSmallMachineWindow", getRootElement(), closeSmallMachineWindow)
addEvent("selectSmallMachineItem", false)
addEventHandler("selectSmallMachineItem", getRootElement(), function(button, _, _, _, _, itemId)
    smallMachines[hoveredMachine].selected = itemId
    closeSmallMachineWindow()
end)
function createSmallMachineWindow()
    hoveredMachine = currentMachine
    if smallMachineWindow then
        sightexports.sGui:deleteGuiElement(smallMachineWindow)
    end
    smallMachineWindow = nil
    local now2 = 256
    local titleBarHeight = sightexports.sGui:getTitleBarHeight()
    local windowWidth = 68
    local windowHeight = titleBarHeight + windowWidth * #ammoList
    smallMachineWindow = sightexports.sGui:createGuiElement("window", screenX / 2 - now2 / 2, screenY / 2 - windowHeight / 2, now2, windowHeight)
    sightexports.sGui:setWindowTitle(smallMachineWindow, "16/BebasNeueRegular.otf", "Töltény kiválasztása")
    sightexports.sGui:setWindowCloseButton(smallMachineWindow, "closeSmallMachineWindow")
    local y = titleBarHeight
    for i = 1, #ammoList, 1 do
        if i > 1 then
            sightexports.sGui:createGuiElement("hr", 8, y - 1, now2 - 16, 2, smallMachineWindow)
        end
        local ammo = ammoCraft[ammoList[i]]
        local btn = sightexports.sGui:createGuiElement("button", now2 - 32 - 8, y + windowWidth / 2 - 16, 32, 32, smallMachineWindow)
        sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
        sightexports.sGui:setGuiHover(btn, "gradient", {
            "sightgreen",
            "sightgreen-second"
        }, false, true)
        sightexports.sGui:setButtonFont(btn, "14/BebasNeueBold.otf")
        sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("check", 32))
        sightexports.sGui:setClickEvent(btn, "selectSmallMachineItem")
        sightexports.sGui:setClickArgument(btn, ammoList[i])
        y = y + 8
        local label = sightexports.sGui:createGuiElement("label", 8, y, 0, 16, smallMachineWindow)
        sightexports.sGui:setLabelAlignment(label, "left", "center")
        sightexports.sGui:setLabelFont(label, "11/Ubuntu-B.ttf")
        sightexports.sGui:setLabelText(label, ammo[4])
        y = y + 16 + 4
        local label = sightexports.sGui:createGuiElement("label", 8, y, 0, 16, smallMachineWindow)
        sightexports.sGui:setLabelAlignment(label, "left", "center")
        sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
        sightexports.sGui:setLabelText(label, "1 x " .. ammo[5])
        if sightexports.sItems:playerHasItem(ammo[3]) then
            sightexports.sGui:setLabelColor(label, "sightgreen")
        else
            sightexports.sGui:setLabelColor(label, "sightred")
        end
        y = y + 16
        local label = sightexports.sGui:createGuiElement("label", 8, y, 0, 16, smallMachineWindow)
        sightexports.sGui:setLabelAlignment(label, "left", "center")
        sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
        sightexports.sGui:setLabelText(label, ammo[1] .. " x lőpor")
        if sightexports.sItems:playerHasItemWithAmount(742, ammo[1]) then
            sightexports.sGui:setLabelColor(label, "sightgreen")
        else
            sightexports.sGui:setLabelColor(label, "sightred")
        end
        y = y + 16 + 8
    end
end

function checkRenderMachinesCanEnd()
    for i = 1, #pressMachines, 1 do
        if pressMachines[i].streamedIn then
            return 
        end
    end
    for i = 1, #smallMachines, 1 do
        if smallMachines[i].streamedIn then
            return 
        end
    end
    checkRenderMachines(false)
    checkClickMachines(false)
    if currentMachine then
        sightexports.sGui:setCursorType("normal")
        sightexports.sGui:showTooltip()
    end
    currentMachine = false
    currentAction = false
    closeSmallMachineWindow()
end
function preRenderPressMachineAnimation()
    local refresh = true
    local now = getTickCount()
    for i = 1, #pressMachines, 1 do
        local machine = pressMachines[i]
        if machine.animation then
            refresh = false
            local progress = now - machine.animation - 500
            local x = machine[1]
            local y = machine[2]
            local z = machine[3]
            local r = machine[4]
            local fProgress = math.max(0, progress / 6000)
            local d = 0.06562899999999999
            if fProgress > 1 then
                if isElement(machine.sheet) then
                    destroyElement(machine.sheet)
                end
                machine.sheet = nil
                fProgress = 1 - math.max(0, (progress - 6820) / 4000)
                if fProgress <= 0 then
                    fProgress = 0
                end
            end
            local animTime = 0.110454 * getEasingValue(fProgress, "InOutQuad")
            local zAnim = z + 0.0375 - animTime
            local scaleMul = math.max(0, (animTime - d) / (0.110454 - d))
            if machine.sheet then
                setObjectScale(machine.sheet, 1 + 1 * scaleMul, 1 + 0.75 * scaleMul, 1 - scaleMul)
                setElementPosition(machine.sheet, x, y, z - 0.044825 * scaleMul / 2)
            else
                local fProgress = (progress - 12000) / 1250
                for shell = 1, #machine.shells, 1 do
                    local sx = machine.shellCoords[shell][1]
                    local sy = machine.shellCoords[shell][2]
                    local time = getEasingValue(math.min(1, math.max(0, fProgress + machine.shellRandom[shell] - 0.5)), "OutQuad")
                    local ry = 90 * getEasingValue(math.max(0, math.min(1, (time - 0.25) / 0.75 * 1.5)), "InQuad")
                    local elapsed = getEasingValue(time, "OutBounce")
                    local sz = zAnim - 0.0125 - (d - 0.0125 - 0.01) * elapsed
                    if 0.4 <= elapsed and not machine.shellSound[shell] then
                        machine.shellSound[shell] = playSound3D("files/drop" .. math.random(1, 2) .. ".wav", sx, sy, sz)
                        setElementInterior(machine.shellSound[shell], machine[5])
                        setElementDimension(machine.shellSound[shell], machine[6])
                    end
                    setElementPosition(machine.shells[shell], sx, sy, sz)
                    setElementRotation(machine.shells[shell], 180, ry, machine.shellRandom[shell] * 360)
                end
                if fProgress >= 2 then
                    machine.animation = nil
                end
            end
            setElementPosition(machine.presser, x, y, zAnim)
        end
    end
    if refresh then
        checkPreRenderPressMachineAnimation(false)
    end
end

function initShellItems(machineId)
    deleteShellItems(machineId)
    local machine = pressMachines[machineId]
    local item = machine.item
    if item then
        for i = 1, ammoCraft[item][2], 1 do
            local rand = math.random()
            local x = nil
            local y = nil
            local z = nil
            local ry = nil
            if machine.animation then
                z = machine[3] - 0.25
                y = machine[2]
                x = machine[1]
                ry = 0
            else
                y = machine.shellCoords[i][2]
                x = machine.shellCoords[i][1]
                ry = 90
                z = machine[3] + 0.0375 - 0.06562899999999999 - 0.01
            end
            local r13_25 = createObject(models.v4_bulletcase, x, y, z, 180, ry, rand * 360)
            setElementInterior(r13_25, machine[5])
            setElementDimension(r13_25, machine[6])
            setElementCollisionsEnabled(r13_25, false)
            machine.shells[i] = r13_25
            machine.shellRandom[i] = rand
        end
    end
end

function deleteShellItems(machineId)
    local machine = pressMachines[machineId]
    for i = 1, #machine.shells, 1 do
        if isElement(machine.shells[i]) then
            destroyElement(machine.shells[i])
        end
        machine.shells[i] = nil
        machine.shellSound[i] = nil
    end
end

function clientPressMachineContent(machineId, item, state)
    pressMachines[machineId].item = item
    if pressMachines[machineId].streamedIn then
        if item then
            if not state then
                local machine = pressMachines[machineId]
                machine.animation = getTickCount()
                local x = machine[1]
                local y = machine[2]
                local z = machine[3]
                machine.sheet = createObject(models.v4_brass_sheet, x, y, z, 0, 0, machine[4])
                setElementInterior(machine.sheet, machine[5])
                setElementDimension(machine.sheet, machine[6])
                setElementCollisionsEnabled(machine.sheet, false)
                local sound = playSound3D("files/hydra.mp3", x, y, z)
                setSoundMaxDistance(sound, 50)
                setElementInterior(sound, machine[5])
                setElementDimension(sound, machine[6])
                checkPreRenderPressMachineAnimation(true)
            end
            initShellItems(machineId)
        else
            deleteShellItems(machineId)
        end
    end
end
addEvent("clientPressMachineContent", true)

local streamedMachines = {}
function streamInPressMachine()
    local machine = streamedMachines[source]
    if not pressMachines[machine].streamedIn then
        pressMachines[machine].streamedIn = true
        local dim = pressMachines[machine][6]
        pressMachines[machine].presser = createObject(models.v4_presser, pressMachines[machine][1], pressMachines[machine][2], pressMachines[machine][3] + 0.0375, 0, 0, pressMachines[machine][4])
        setElementInterior(pressMachines[machine].presser, pressMachines[machine][5])
        setElementDimension(pressMachines[machine].presser, dim)
        setElementCollisionsEnabled(pressMachines[machine].presser, false)
        initShellItems(machine)
        checkRenderMachines(true)
        checkClickMachines(true)
    end
end

function streamOutPressMachine()
    local machine = streamedMachines[source]
    if pressMachines[machine].streamedIn then
        pressMachines[machine].streamedIn = false
        pressMachines[machine].animation = false
        deleteShellItems(machine)
        if isElement(pressMachines[machine].sheet) then
            destroyElement(pressMachines[machine].sheet)
        end
        pressMachines[machine].sheet = nil
        if isElement(pressMachines[machine].presser) then
            destroyElement(pressMachines[machine].presser)
        end
        pressMachines[machine].presser = nil
        checkRenderMachinesCanEnd()
    end
end

local streamedSmallMachines = {}
function preRenderSmallMachineAnimation()
    local refresh = true
    local now = getTickCount()
    for i = 1, #smallMachines, 1 do
        local machine = smallMachines[i]
        if machine.animation then
            refresh = false
            local progress = now - machine.animation
            local fProgress = progress / 350
            if fProgress >= 1 then
                fProgress = math.max(0, (progress - 650) / 350)
                if fProgress >= 1 then
                    machine.animation = false
                    fProgress = 0
                else
                    fProgress = 1 - fProgress
                end
            end
            setElementRotation(machine.handle, getEasingValue(fProgress, "InOutQuad") * -45, 0, machine[4] + 180)
        end
    end
    if refresh then
        checkPreRenderSmallMachineAnimation(false)
    end
end
function createSmallShell(machine)
    if not isElement(smallMachines[machine].shell) then
        local r5_31 = smallMachines[machine][6]
        smallMachines[machine].shell = createObject(models.v4_bulletcase, smallMachines[machine].shellCoords[1], smallMachines[machine].shellCoords[2], smallMachines[machine].shellCoords[3], 0, 0, math.random() * 360)
        setElementInterior(smallMachines[machine].shell, smallMachines[machine][5])
        setElementDimension(smallMachines[machine].shell, r5_31)
        setElementCollisionsEnabled(smallMachines[machine].shell, false)
    end
end

function clientSmallMachineContent(machineId, item, isPressed, skipSoundCheck)
    isPressed = isPressed and true or false
    
    smallMachines[machineId].item = item
    
    if smallMachines[machineId].streamedIn then
        if smallMachines[machineId].item then
            createSmallShell(machineId)
        else
            if isElement(smallMachines[machineId].shell) then
                destroyElement(smallMachines[machineId].shell)
            end
            smallMachines[machineId].shell = nil
        end
        
        if not skipSoundCheck then
            if smallMachines[machineId].item == item then
                if smallMachines[machineId].pressed ~= isPressed and isPressed then
                    smallMachines[machineId].animation = getTickCount()
                    checkPreRenderSmallMachineAnimation(true)
                    local leverSound = playSound3D("files/lever" .. math.random(1, 3) .. ".mp3", smallMachines[machineId][1], smallMachines[machineId][2], smallMachines[machineId][3])
                    setElementInterior(leverSound, smallMachines[machineId][5])
                    setElementDimension(leverSound, smallMachines[machineId][6])
                end
            else
                local inoutSound = playSound3D("files/inout" .. math.random(1, 7) .. ".mp3", smallMachines[machineId].shellCoords[1], smallMachines[machineId].shellCoords[2], smallMachines[machineId].shellCoords[3])
                setElementInterior(inoutSound, smallMachines[machineId][5])
                setElementDimension(inoutSound, smallMachines[machineId][6])
            end
        end
    end
    smallMachines[machineId].pressed = isPressed
end
addEvent("clientSmallMachineContent", true)

function streamInSmallMachine()
    local machine = streamedSmallMachines[source]
    if not smallMachines[machine].streamedIn then
        smallMachines[machine].streamedIn = true
        local dim = smallMachines[machine][6]
        smallMachines[machine].handle = createObject(models.v4_bulletpress_handle, smallMachines[machine][1], smallMachines[machine][2], smallMachines[machine][3], 0, 0, smallMachines[machine][4] + 180)
        setElementInterior(smallMachines[machine].handle, smallMachines[machine][5])
        setElementDimension(smallMachines[machine].handle, dim)
        setElementCollisionsEnabled(smallMachines[machine].handle, false)
        if smallMachines[machine].item then
            createSmallShell(machine)
        end
        checkRenderMachines(true)
        checkClickMachines(true)
    end
end

function streamOutSmallMachine()
    local machine = streamedSmallMachines[source]
    if smallMachines[machine].streamedIn then
        smallMachines[machine].streamedIn = false
        smallMachines[machine].animation = false
        if isElement(smallMachines[machine].handle) then
            destroyElement(smallMachines[machine].handle)
        end
        smallMachines[machine].handle = nil
        if isElement(smallMachines[machine].shell) then
            destroyElement(smallMachines[machine].shell)
        end
        smallMachines[machine].shell = nil
        checkRenderMachinesCanEnd()
    end
end

function modloaderLoaded()
    models.hammer = sightexports.sModloader:getModelId("wep_hammer")
    models.v4_brass_sheet = sightexports.sModloader:getModelId("v4_brass_sheet")
    models.v4_presser = sightexports.sModloader:getModelId("v4_presser")
    models.v4_sheetpress = sightexports.sModloader:getModelId("v4_sheetpress")
    models.v4_bulletcase = sightexports.sModloader:getModelId("v4_bulletcase")
    models.v4_bulletpress = sightexports.sModloader:getModelId("v4_bulletpress")
    models.v4_bulletpress_handle = sightexports.sModloader:getModelId("v4_bulletpress_handle")
    for i = 1, #pressMachines, 1 do
        local x, y, z, r7_35, int, dim = unpack(pressMachines[i])
        local r = math.rad(r7_35)
        local c = math.cos(r)
        local s = math.sin(r)
        pressMachines[i].obj = createObject(models.v4_sheetpress, x, y, z, 0, 0, r7_35)
        setElementInterior(pressMachines[i].obj, int)
        setElementDimension(pressMachines[i].obj, dim)
        pressMachines[i].shells = {}
        pressMachines[i].shellRandom = {}
        pressMachines[i].shellSound = {}
        pressMachines[i].shellCoords = {}
        local mul = 0.003600000000000006
        for j = 0, 4, 1 do
            local d = 0.0513 - 0.0291 * j
            table.insert(pressMachines[i].shellCoords, {
                x + c * d - s * mul,
                y + s * d + c * mul
            })
        end
        for j = 1, 2, 1 do
            for k = -1, 1, 2 do
                local d = -0.1206 + 0.0621 * (2 + j * k)
                for l = 0, 4, 1 do
                    local d2 = 0.0513 - 0.0291 * l
                    table.insert(pressMachines[i].shellCoords, {
                        x + c * d2 - s * d,
                        y + s * d2 + c * d
                    })
                end
            end
        end
        streamedMachines[pressMachines[i].obj] = i
        addEventHandler("onClientElementStreamIn", pressMachines[i].obj, streamInPressMachine)
        addEventHandler("onClientElementStreamOut", pressMachines[i].obj, streamOutPressMachine)
    end
    for i = 1, #smallMachines, 1 do
        local x, y, z, r7_35, int, dim = unpack(smallMachines[i])
        local r = math.rad(r7_35)
        local c = math.cos(r)
        local s = math.sin(r)
        x = x + c * 0.7685 + s * 0.6631
        y = y + s * 0.7685 - c * 0.6631
        z = z + 0.3097
        smallMachines[i][1] = x
        smallMachines[i][2] = y
        smallMachines[i][3] = z
        smallMachines[i].shellCoords = {
            x - c * 0.043 - s * 0.0629,
            y - s * 0.043 + c * 0.0629,
            z + 0.2793
        }
        smallMachines[i].grabCoords = {
            x + s * 0.1285,
            y - c * 0.1285,
            z + 0.1898
        }
        smallMachines[i].obj = createObject(models.v4_bulletpress, x, y, z, 0, 0, r7_35 + 180)
        setElementInterior(smallMachines[i].obj, int)
        setElementDimension(smallMachines[i].obj, dim)
        setElementCollisionsEnabled(smallMachines[i].obj, false)
        streamedSmallMachines[smallMachines[i].obj] = i
        addEventHandler("onClientElementStreamIn", smallMachines[i].obj, streamInSmallMachine)
        addEventHandler("onClientElementStreamOut", smallMachines[i].obj, streamOutSmallMachine)
    end
    addEventHandler("clientPressMachineContent", getRootElement(), clientPressMachineContent)
    addEventHandler("clientSmallMachineContent", getRootElement(), clientSmallMachineContent)
    triggerServerEvent("requestAmmoMachineContent", localPlayer)
end

function itemsReady()
    for i, v in pairs(ammoCraft) do
        ammoCraft[i][4] = sightexports.sItems:getItemName(i)
        ammoCraft[i][5] = sightexports.sItems:getItemName(v[3])
    end
end

local warAmmos = {}
local hammers = {}
function clientAmmoHammerHit(s)
    if warAmmos[source] and isElementStreamedIn(source) then
        local x, y, z = getElementPosition(warAmmos[source])
        local int = getElementInterior(warAmmos[source])
        local dim = getElementDimension(warAmmos[source])
        local sound = playSound3D("files/hit" .. s .. ".mp3", x, y, z)
        setSoundMaxDistance(sound, 50)
        setElementInterior(sound, int)
        setElementDimension(sound, dim)
    end
end
addEvent("clientAmmoHammerHit", true)
addEventHandler("clientAmmoHammerHit", getRootElement(), clientAmmoHammerHit)

addEvent("clientAmmoExplosion", true)
addEventHandler("clientAmmoExplosion", getRootElement(), function(id, s)
    clientAmmoHammerHit(s)
    local x = nil
    local y = nil
    local z = nil
    local int = nil
    local dim = nil
    if tonumber(id) then
        local openPos = sightexports.sCrate:getOpenPos(id)
        z = openPos[3]
        y = openPos[2]
        x = openPos[1]
        int = openPos[5]
        dim = openPos[6]
    else
        z = 1000.870237
        y = -30.3982
        x = 614.5529
        dim = tonumber(split(id, "_")[2])
        if dim < 0 then
            int = 2
        else
            int = 1
        end
        dim = math.abs(dim)
    end
    if int == getElementInterior(localPlayer) and dim == getElementDimension(localPlayer) then
        createExplosion(x, y, z, 2)
    end
end)

addEventHandler("onClientPlayerQuit", getRootElement(), function()
    if isElement(warAmmos[source]) then
        destroyElement(warAmmos[source])
    end
    warAmmos[source] = nil
    if isElement(hammers[source]) then
        destroyElement(hammers[source])
    end
    hammers[source] = nil
end)

addEvent("clientAmmoOpeningState", true)
addEventHandler("clientAmmoOpeningState", getRootElement(), function(id, rot)
    if isElement(warAmmos[source]) then
        destroyElement(warAmmos[source])
    end
    warAmmos[source] = nil
    if isElement(hammers[source]) then
        destroyElement(hammers[source])
    end
    hammers[source] = nil
    if id then
        local x = nil
        local y = nil
        local z = nil
        local int = nil
        local dim = nil
        if tonumber(id) then
            local openPos = sightexports.sCrate:getOpenPos(id)
            z = openPos[3]
            y = openPos[2]
            x = openPos[1]
            int = openPos[5]
            dim = openPos[6]
        else
            z = 1000.870237
            y = -30.3982
            x = 614.5529
            dim = tonumber(split(id, "_")[2])
            if dim < 0 then
                int = 2
            else
                int = 1
            end
            dim = math.abs(dim)
        end
        local r = math.rad(rot + 90)
        x = x + math.cos(r) * 0.5
        y = y + math.sin(r) * 0.5
        warAmmos[source] = createObject(1636, x, y, z + 0.1, 0, 0, rot + 90)
        setElementInterior(warAmmos[source], int)
        setElementDimension(warAmmos[source], dim)
        setElementCollisionsEnabled(warAmmos[source], false)
        hammers[source] = createObject(models.hammer, x, y, z + 0.1, 0, 0, rot + 90)
        setElementInterior(hammers[source], int)
        setElementDimension(hammers[source], dim)
        sightexports.sPattach:attach(hammers[source], source, "weapon")
    end
    if source == localPlayer then
        if id then
            state = true
        else
            state = false
        end
        setMinigameState(state)
    end
end)


local gameCompleted = false
local minigameActive = false
local fadeAlpha = 0
local pendulumTime = 0
local hammerAngle = 0
local targetAngle = 0
local hammerSpeed = 0
local hammerDirection = 1
local currentSpeed = 1
local baseSpeed = 1
local hitProgress = 0
local visualProgress = 0
local canHit = true
local hitEffects = {}

function setMinigameState(state)
    minigameActive = state
    if state then
        pendulumTime = 0
        hammerAngle = 0
        targetAngle = (math.random() * 2 - 1) * 20
        hammerSpeed = 1
        hammerDirection = 1
        currentSpeed = 1.25 * (1 + math.random() * 0.25)
        baseSpeed = currentSpeed
        gameCompleted = false
        hitProgress = 0
        visualProgress = 0
        canHit = true
        checkMinigamePreRender(true)
        checkMinigameKey(true)
        checkMinigameRender(true)
        sightexports.sGui:showInfobox("i", "A kalapácsot a [SPACE] gomb lenyomásával tudod használni, hogy kinyisd a lőszert.")
        sightexports.sGui:showInfobox("i", "Minél pontosabban találod el a zöld részt, annál gyorsabban nyílik ki.")
    end
end

function minigamePreRender(deltaTime)
    if not minigameActive or visualProgress >= 1 or gameCompleted then
        if fadeAlpha > 0 then
            fadeAlpha = math.max(0, fadeAlpha - deltaTime / 1000)
        end
        if fadeAlpha <= 0 then
            checkMinigamePreRender(false)
            checkMinigameKey(false)
            checkMinigameRender(false)
        end
    elseif fadeAlpha < 1 then
        fadeAlpha = math.min(1, fadeAlpha + deltaTime / 500)
    end
    
    if visualProgress < hitProgress then
        visualProgress = math.min(hitProgress, visualProgress + deltaTime / 500 / 6)
    end

    for i = #hitEffects, 1, -1 do
        hitEffects[i][7] = hitEffects[i][7] + deltaTime / 500
        if hitEffects[i][7] >= 1 then
            table.remove(hitEffects, i)
        end
    end

    if minigameActive and not gameCompleted then
        pendulumTime = pendulumTime + deltaTime / 2000 * currentSpeed
        if pendulumTime >= 1 then
            pendulumTime = pendulumTime % 1
            hammerDirection = hammerDirection * -1
            currentSpeed = baseSpeed
            canHit = true
        end
        
        hammerAngle = math.cos(pendulumTime * math.pi) * 80 * hammerDirection
    
        local distance = math.abs(hammerAngle - targetAngle)
        if distance > 180 then
            distance = 360 - distance
        end
        hammerSpeed = math.max(0, math.min(1, (25 - distance) / 25))
        hammerSpeed = math.pow(hammerSpeed, 0.75)
    end
end

function getArrowColor(accuracy)
    local r, g, b
    
    if accuracy <= 0.5 then
        local t = accuracy * 2
        r = red[1] + (orange[1] - red[1]) * t
        g = red[2] + (orange[2] - red[2]) * t
        b = red[3] + (orange[3] - red[3]) * t
    else
        local t = (accuracy - 0.5) * 2
        r = orange[1] + (green[1] - orange[1]) * t
        g = orange[2] + (green[2] - orange[2]) * t
        b = orange[3] + (green[3] - orange[3]) * t
    end
    
    return r, g, b
end

function minigameKey(key, state)
    if key == "space" and state and fadeAlpha >= 1 and canHit and hitProgress < 1 and minigameActive then
        canHit = false
        local r = math.rad(hammerAngle)
        local c = math.cos(r)
        local s = math.sin(r)
        local r, g, b = getArrowColor(hammerSpeed)
        
        table.insert(hitEffects, {
            hammerAngle,
            -s,
            c,
            r,
            g,
            b,
            0
        })
        
        baseSpeed = currentSpeed + 0.05 * (1 + math.random() * 0.25)
        
        if hammerSpeed <= 0.70 then
            gameCompleted = true
            triggerServerEvent("ammoOpeningResult", localPlayer)
        else
            triggerServerEvent("clientAmmoHammerHit", localPlayer)
            local progressIncrease = hammerSpeed / 4
            hitProgress = math.min(1, hitProgress + progressIncrease)
            
            
            if hitProgress >= 1 then
                gameCompleted = true
                triggerServerEvent("ammoOpeningResult", localPlayer, true)
            end
        end
    end
end

function minigameRender()
    if not minigameActive and fadeAlpha <= 0 then
        return
    end
    
    sightlangStaticImageUsed[0] = true
    if sightlangStaticImageToc[0] then
        processsightlangStaticImage[0]()
    end
    dxDrawImage(screenX / 2 - 256, screenY / 2 - 256, 512, 256, sightlangStaticImage[0], 0, 0, 0, tocolor(red[1], red[2], red[3], 255 * fadeAlpha))
    
    for i = 1, #hitEffects do
        local rot, x, y, r, g, b, time = unpack(hitEffects[i])
        local a = 255 - math.pow(time, 4) * 255
        local distance = 34 + time * 128
        x = x * distance
        y = y * distance
        
        sightlangStaticImageUsed[1] = true
        if sightlangStaticImageToc[1] then
            processsightlangStaticImage[1]()
        end
        dxDrawImage(screenX / 2 - 256 + x, screenY / 2 - 256 + y, 512, 256, sightlangStaticImage[1], rot, 0, 128, tocolor(r, g, b, a * fadeAlpha))
    end
    
    sightlangStaticImageUsed[2] = true
    if sightlangStaticImageToc[2] then
        processsightlangStaticImage[2]()
    end
    dxDrawImage(screenX / 2 - 256, screenY / 2 - 256, 512, 256, sightlangStaticImage[2], targetAngle, 0, 128, tocolor(orange[1], orange[2], orange[3], 255 * fadeAlpha))
    
    sightlangStaticImageUsed[3] = true
    if sightlangStaticImageToc[3] then
        processsightlangStaticImage[3]()
    end
    dxDrawImage(screenX / 2 - 256, screenY / 2 - 256, 512, 256, sightlangStaticImage[3], targetAngle, 0, 128, tocolor(green[1], green[2], green[3], 255 * fadeAlpha))
    
    local r, g, b = getArrowColor(hammerSpeed)
    sightlangStaticImageUsed[1] = true
    if sightlangStaticImageToc[1] then
        processsightlangStaticImage[1]()
    end
    dxDrawImage(screenX / 2 - 256, screenY / 2 - 256, 512, 256, sightlangStaticImage[1], hammerAngle, 0, 128, tocolor(r, g, b, 255 * fadeAlpha))
    
    dxDrawRectangle(screenX / 2 - 150, screenY / 2 - 24, 300, 12, tocolor(grey1[1], grey1[2], grey1[3], 255 * fadeAlpha))
    dxDrawRectangle(screenX / 2 - 150, screenY / 2 - 24, 300 * visualProgress, 12, tocolor(green[1], green[2], green[3], 255 * fadeAlpha))
end