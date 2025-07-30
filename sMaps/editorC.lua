local screenX, screenY = guiGetScreenSize()

local editorState = false

local guiElements = {}
local placeGuiWindow = false
local placeGuiElements = {}

local deleteMode = false
local hoverWorldObject = false
local actionHistory = {}

local mapActions = {
    {
        name = "Új map létrehozása",
        icon = "file-plus",
        event = "createNewMap"
    },
    {
        name = "Mentés",
        icon = "save",
        event = "saveMap"
    },
    {
        name = "Mentés és konvertálás",
        icon = "file-export",
        event = "saveAndConvertMap"
    },
    {
        name = "Map betöltése",
        icon = "file-import",
        event = "loadEditorMap"
    },
    {
        name = "Új objektum elhelyezése",
        icon = "plus",
        event = "placeObject"
    },
    {
        name = "SA objektum törlése",
        icon = "times",
        event = "toggleDeleteMode"
    },
    {
        name = "SA objektum törlése (manuális)",
        icon = "times",
        event = "manualObjectDelete"
    },
    {
        name = "Kilépés",
        icon = "sign-out-alt",
        event = "exitEditor"
    }
}

addEvent("toggleEditorMode", true)
addEventHandler("toggleEditorMode", root,
    function (state)
        editorState = state

        if state then
            exports.sHud:setHudEnabled(false)
            
            initEditorGui()
            addEventHandler("onClientRender", root, renderEditor)
            addEventHandler("onClientClick", root, clickEditor)
            addEventHandler("onClientKey", root, keyEditor)
        else
            for i, el in pairs(guiElements) do
                exports.sGui:deleteGuiElement(el)
            end

            for k, v in pairs(actionHistory) do
                restoreWorldModel(v.modelId, 9, v.modelX, v.modelY, v.modelZ)

                if v.modelLODId then
                    restoreWorldModel(v.modelLODId, 9, v.modelX, v.modelY, v.modelZ)
                end
            end

            actionHistory = {}

            removeEventHandler("onClientRender", root, renderEditor)
            removeEventHandler("onClientClick", root, clickEditor)
            removeEventHandler("onClientKey", root, keyEditor)

            exports.sHud:setHudEnabled(true)
            exports.sGui:showTooltip(false)
        end
    end
)

function initEditorGui()
    local actionWidth = #mapActions * 47
    local startX = (screenX - actionWidth) / 2

    for i, action in pairs(mapActions) do
        guiElements["editorAction:" .. i] = exports.sGui:createGuiElement("button", startX, screenY - 53, 42, 42)
        exports.sGui:setButtonIcon(guiElements["editorAction:" .. i], exports.sGui:getFaIconFilename(action.icon, 48, "solid"))
        exports.sGui:guiSetTooltip(guiElements["editorAction:" .. i], action.name)
        
        if action.event then
            exports.sGui:setClickEvent(guiElements["editorAction:" .. i], action.event)
        end

        startX = startX + 47
    end
end

function initNewMapGui()
    local w, h = 345, 150
    local x, y = (screenX - w) / 2, (screenY - h) / 2

    exitGuiWindow = exports.sGui:createGuiElement("window", x, y, w, h)
    exports.sGui:setWindowTitle(exitGuiWindow, "16/BebasNeueRegular.otf", "Új map létrehozása")
    exports.sGui:setWindowCloseButton(exitGuiWindow, "closeExitGui")

    exitGuiLabel = exports.sGui:createGuiElement("label", 0, 45, w, h, exitGuiWindow)
    exports.sGui:setLabelFont(exitGuiLabel, "10/Ubuntu-R.ttf")
    exports.sGui:setLabelText(exitGuiLabel, "Biztosan szeretnél egy új mapot létrehozni?")
    exports.sGui:setLabelAlignment(exitGuiLabel, "center", "top")

    exitGuiLabel2 = exports.sGui:createGuiElement("label", 0, -45, w, h, exitGuiWindow)
    exports.sGui:setLabelFont(exitGuiLabel2, "10/Ubuntu-R.ttf")
    exports.sGui:setLabelText(exitGuiLabel2, "A nem mentett módosítások elvesznek!")
    exports.sGui:setLabelAlignment(exitGuiLabel2, "center", "bottom")
    exports.sGui:setLabelColor(exitGuiLabel2, {243, 90, 90})

    exitGuiButton = exports.sGui:createGuiElement("button", 5, h - 35, 165, 30, exitGuiWindow)
    exports.sGui:setButtonFont(exitGuiButton, "10/Ubuntu-R.ttf")
    exports.sGui:setButtonText(exitGuiButton, "Igen")
    exports.sGui:setButtonTextAlign(exitGuiButton, "center", "center")
    exports.sGui:setGuiBackground(exitGuiButton, "solid", {243, 90, 90})
    exports.sGui:setGuiHover(exitGuiButton, "solid", {250, 120, 95})
    exports.sGui:setClickEvent(exitGuiButton, "newMapFinal")
    
    exitGuiButton2 = exports.sGui:createGuiElement("button", 175, h - 35, 165, 30, exitGuiWindow)
    exports.sGui:setButtonFont(exitGuiButton2, "10/Ubuntu-R.ttf")
    exports.sGui:setButtonText(exitGuiButton2, "Nem")
    exports.sGui:setButtonTextAlign(exitGuiButton2, "center", "center")
    exports.sGui:setGuiHover(exitGuiButton2, "solid", {60, 184, 170})
    exports.sGui:setClickEvent(exitGuiButton2, "closeExitGui")
end

function initPlaceObjectGui()
    local titleBarHeight = exports.sGui:getTitleBarHeight()
    local items = 10

    local w, h = 500, titleBarHeight + 48 + 48 * items
    local x, y = (screenX - w) / 2, (screenY - h) / 2

    placeGuiWindow = exports.sGui:createGuiElement("window", x, y, w, h)
    exports.sGui:setWindowTitle(placeGuiWindow, "16/BebasNeueRegular.otf", "Új objektum elhelyezése")
    exports.sGui:setWindowCloseButton(placeGuiWindow, "closePlaceObjectGui")
end

function initExitGui()
    local w, h = 345, 150
    local x, y = (screenX - w) / 2, (screenY - h) / 2

    exitGuiWindow = exports.sGui:createGuiElement("window", x, y, w, h)
    exports.sGui:setWindowTitle(exitGuiWindow, "16/BebasNeueRegular.otf", "Kilépés")
    exports.sGui:setWindowCloseButton(exitGuiWindow, "closeExitGui")

    exitGuiLabel = exports.sGui:createGuiElement("label", 0, 45, w, h, exitGuiWindow)
    exports.sGui:setLabelFont(exitGuiLabel, "10/Ubuntu-R.ttf")
    exports.sGui:setLabelText(exitGuiLabel, "Biztosan ki szeretnél lépni a szerkesztőből?")
    exports.sGui:setLabelAlignment(exitGuiLabel, "center", "top")

    exitGuiLabel2 = exports.sGui:createGuiElement("label", 0, -45, w, h, exitGuiWindow)
    exports.sGui:setLabelFont(exitGuiLabel2, "10/Ubuntu-R.ttf")
    exports.sGui:setLabelText(exitGuiLabel2, "A nem mentett módosítások elvesznek!")
    exports.sGui:setLabelAlignment(exitGuiLabel2, "center", "bottom")
    exports.sGui:setLabelColor(exitGuiLabel2, {243, 90, 90})

    exitGuiButton = exports.sGui:createGuiElement("button", 5, h - 35, 165, 30, exitGuiWindow)
    exports.sGui:setButtonFont(exitGuiButton, "10/Ubuntu-R.ttf")
    exports.sGui:setButtonText(exitGuiButton, "Igen")
    exports.sGui:setButtonTextAlign(exitGuiButton, "center", "center")
    exports.sGui:setGuiBackground(exitGuiButton, "solid", {243, 90, 90})
    exports.sGui:setGuiHover(exitGuiButton, "solid", {250, 120, 95})
    exports.sGui:setClickEvent(exitGuiButton, "exitEditorFinal")
    
    exitGuiButton2 = exports.sGui:createGuiElement("button", 175, h - 35, 165, 30, exitGuiWindow)
    exports.sGui:setButtonFont(exitGuiButton2, "10/Ubuntu-R.ttf")
    exports.sGui:setButtonText(exitGuiButton2, "Nem")
    exports.sGui:setButtonTextAlign(exitGuiButton2, "center", "center")
    exports.sGui:setGuiHover(exitGuiButton2, "solid", {60, 184, 170})
    exports.sGui:setClickEvent(exitGuiButton2, "closeExitGui")
end

function initSaveGui()
    local w, h = 245, 150
    local x, y = (screenX - w) / 2, (screenY - h) / 2

    saveGuiWindow = exports.sGui:createGuiElement("window", x, y, w, h)
    exports.sGui:setWindowTitle(saveGuiWindow, "16/BebasNeueRegular.otf", "Mentés")
    exports.sGui:setWindowCloseButton(saveGuiWindow, "closeSaveGui")

    saveGuiInput = exports.sGui:createGuiElement("input", 23, 60, 200, 30, saveGuiWindow)
    exports.sGui:setInputFont(saveGuiInput, "10/Ubuntu-R.ttf")
    exports.sGui:setInputPlaceholder(saveGuiInput, "Map neve")

    saveGuiButton = exports.sGui:createGuiElement("button", 5, h - 35, 115, 30, saveGuiWindow)
    exports.sGui:setButtonFont(saveGuiButton, "10/Ubuntu-R.ttf")
    exports.sGui:setButtonText(saveGuiButton, "Mentés")
    exports.sGui:setButtonTextAlign(saveGuiButton, "center", "center")
    exports.sGui:setGuiHover(saveGuiButton, "solid", {60, 184, 170})
    exports.sGui:setClickEvent(saveGuiButton, "saveMapFinal")
    
    saveGuiButton2 = exports.sGui:createGuiElement("button", 125, h - 35, 115, 30, saveGuiWindow)
    exports.sGui:setButtonFont(saveGuiButton2, "10/Ubuntu-R.ttf")
    exports.sGui:setButtonText(saveGuiButton2, "Mégse")
    exports.sGui:setButtonTextAlign(saveGuiButton2, "center", "center")
    exports.sGui:setGuiBackground(saveGuiButton2, "solid", {243, 90, 90})
    exports.sGui:setGuiHover(saveGuiButton2, "solid", {250, 120, 95})
    exports.sGui:setClickEvent(saveGuiButton2, "closeSaveGui")
end

function initSaveAndConvertGui()
    local w, h = 345, 150
    local x, y = (screenX - w) / 2, (screenY - h) / 2

    saveGuiWindow = exports.sGui:createGuiElement("window", x, y, w, h)
    exports.sGui:setWindowTitle(saveGuiWindow, "16/BebasNeueRegular.otf", "Mentés és konvertálás")
    exports.sGui:setWindowCloseButton(saveGuiWindow, "closeSaveGui")

    saveGuiInput = exports.sGui:createGuiElement("input", 73, 60, 200, 30, saveGuiWindow)
    exports.sGui:setInputFont(saveGuiInput, "10/Ubuntu-R.ttf")
    exports.sGui:setInputPlaceholder(saveGuiInput, "Map neve")

    saveGuiButton = exports.sGui:createGuiElement("button", 5, h - 35, 165, 30, saveGuiWindow)
    exports.sGui:setButtonFont(saveGuiButton, "10/Ubuntu-R.ttf")
    exports.sGui:setButtonText(saveGuiButton, "Mentés és konvertálás")
    exports.sGui:setButtonTextAlign(saveGuiButton, "center", "center")
    exports.sGui:setGuiHover(saveGuiButton, "solid", {60, 184, 170})
    exports.sGui:setClickEvent(saveGuiButton, "saveMapAndConvertFinal")
    
    saveGuiButton2 = exports.sGui:createGuiElement("button", 175, h - 35, 165, 30, saveGuiWindow)
    exports.sGui:setButtonFont(saveGuiButton2, "10/Ubuntu-R.ttf")
    exports.sGui:setButtonText(saveGuiButton2, "Mégse")
    exports.sGui:setButtonTextAlign(saveGuiButton2, "center", "center")
    exports.sGui:setGuiBackground(saveGuiButton2, "solid", {243, 90, 90})
    exports.sGui:setGuiHover(saveGuiButton2, "solid", {250, 120, 95})
    exports.sGui:setClickEvent(saveGuiButton2, "closeSaveAndConvertGui")
end

function renderEditor()
    local cursorScreenX, cursorScreenY, cursorX, cursorY, cursorZ = getCursorPosition()

    if cursorX then
        local cameraX, cameraY, cameraZ, cameraRX, cameraRY, cameraRZ = getCameraMatrix()
        
        local hit, hitX, hitY, hitZ, hitElement, normalX, normalY, normalZ, material, lighting, piece, modelId, modelX, modelY, modelZ, modelRX, modelRY, modelRZ, modelLODId = processLineOfSight(cameraX, cameraY, cameraZ, cursorX, cursorY, cursorZ, true, true, true, true, true, false, false, false, localPlayer, true)
    
        if not exports.sGui:getGuiHoverElement() then
            if hit and tonumber(modelId) and tonumber(modelLODId) then
                local modelName = exports.sModloader:getModelNameById(modelId) or engineGetModelNameFromID(modelId) or "ISMERETLEN NÉV"

                if modelName then
                    hoverWorldObject = {modelId, modelX, modelY, modelZ, modelLODId}
                    exports.sGui:showTooltip(modelId .. " (" .. modelName .. ") LOD: " .. modelLODId .. (deleteMode and "\nBAL KATT: TÖRLÉS\nSHIFT + BAL KATT: TÖBB TÖRLÉSE" or ""), "right", "top")
                end
            else
                hoverWorldObject = false
                exports.sGui:showTooltip(false)
            end
        end

    end

    showChat(true)
end

function clickEditor(button, state, _, _, cursorX, cursorY, cursorZ)
    if button == "left" and state == "down" then
        if not deleteMode or exports.sGui:getGuiHoverElement() then
            return
        end

        if hoverWorldObject then
            local modelId, modelX, modelY, modelZ, modelLODId = unpack(hoverWorldObject)
            removeWorldModel(modelId, 9, modelX, modelY, modelZ)

            if modelLODId then
                removeWorldModel(modelLODId, 9, modelX, modelY, modelZ)
            end

            table.insert(actionHistory, {
                type = "remove",
                modelId = modelId,
                modelX = modelX,
                modelY = modelY,
                modelZ = modelZ,
                modelLODId = modelLODId
            })

            if not getKeyState("lshift") then
                deleteMode = false
            end
        end
    end
end

function keyEditor(button, state)
    if state then
        if getKeyState("lctrl") then
            if button == "z" then
                local lastAction = actionHistory[#actionHistory]

                if lastAction then
                    restoreWorldModel(lastAction.modelId, 9, lastAction.modelX, lastAction.modelY, lastAction.modelZ)

                    if lastAction.modelLODId then
                        restoreWorldModel(lastAction.modelLODId, 9, lastAction.modelX, lastAction.modelY, lastAction.modelZ)
                    end

                    table.remove(actionHistory, #actionHistory)
                end
            end
        end
    end
end

addEvent("createNewMap", false)
addEventHandler("createNewMap", root,
    function ()
        initNewMapGui()
    end
)

addEvent("newMapFinal", false)
addEventHandler("newMapFinal", root,
    function ()
        exports.sGui:deleteGuiElement(exitGuiWindow)

        for k, v in pairs(actionHistory) do
            restoreWorldModel(v.modelId, 9, v.modelX, v.modelY, v.modelZ)

            if v.modelLODId then
                restoreWorldModel(v.modelLODId, 9, v.modelX, v.modelY, v.modelZ)
            end
        end

        actionHistory = {}

        outputChatBox("[color=sightblue][SightMTA - Map]: #ffffffÚj mapot kezdtél.")
    end
)

addEvent("closeNewMapGui", false)
addEventHandler("closeNewMapGui", root,
    function ()
        exports.sGui:deleteGuiElement(exitGuiWindow)
    end
)

addEvent("placeObject", false)
addEventHandler("placeObject", root,
    function ()
        initPlaceObjectGui()
    end
)

addEvent("toggleDeleteMode", false)
addEventHandler("toggleDeleteMode", root,
    function ()
        deleteMode = not deleteMode
    end
)

addEvent("exitEditor", false)
addEventHandler("exitEditor", root,
    function ()
        initExitGui()
    end
)

addEvent("closeExitGui", false)
addEventHandler("closeExitGui", root,
    function ()
        exports.sGui:deleteGuiElement(exitGuiWindow)
    end
)

addEvent("closePlaceObjectGui", false)
addEventHandler("closePlaceObjectGui", root,
    function ()
        exports.sGui:deleteGuiElement(placeGuiWindow)
    end
)

addEvent("exitEditorFinal", false)
addEventHandler("exitEditorFinal", root,
    function ()
        exports.sGui:deleteGuiElement(exitGuiWindow)

        triggerServerEvent("toggleEditorMode", localPlayer)
    end
)

addEvent("saveMap", false)
addEventHandler("saveMap", root,
    function ()
        initSaveGui()
    end
)

addEvent("saveAndConvertMap", false)
addEventHandler("saveAndConvertMap", root,
    function ()
        initSaveAndConvertGui()
    end
)

addEvent("closeSaveGui", false)
addEventHandler("closeSaveGui", root,
    function ()
        exports.sGui:deleteGuiElement(saveGuiWindow)
    end
)

addEvent("closeSaveAndConvertGui", false)
addEventHandler("closeSaveAndConvertGui", root,
    function ()
        exports.sGui:deleteGuiElement(saveGuiWindow)
    end
)

addEvent("saveMapFinal", false)
addEventHandler("saveMapFinal", root,
    function ()
        local mapName = exports.sGui:getInputValue(saveGuiInput)
        local mapData = {
            objects = {},
            removes = {}
        }

        exports.sGui:deleteGuiElement(saveGuiWindow)

        for k, v in pairs(actionHistory) do
            if v.type == "remove" then
                table.insert(mapData.removes, {
                    id = v.modelId,
                    radius = 9,
                    x = v.modelX,
                    y = v.modelY,
                    z = v.modelZ,
                    lodModel = v.modelLODId
                })
            end
        end
       
        mapData = toJSON(mapData)

        local file = fileCreate("map-editor/" .. string.gsub(mapName, " ", "_") .. ".map")

        if file then
            fileWrite(file, mapData)
            fileClose(file)

            outputChatBox("[color=sightblue][SightMTA - Map]: #ffffffA map elmentésre került. (:sMaps/map-editor/" .. string.gsub(mapName, " ", "_") .. ".map)")
        end
    end
)

addEvent("saveMapAndConvertFinal", false)
addEventHandler("saveMapAndConvertFinal", root,
    function ()
        local mapName = exports.sGui:getInputValue(saveGuiInput)
        local mapData = {
            objects = {},
            removes = {}
        }

        exports.sGui:deleteGuiElement(saveGuiWindow)

        for k, v in pairs(actionHistory) do
            if v.type == "remove" then
                table.insert(mapData.removes, {
                    id = v.modelId,
                    radius = 9,
                    x = v.modelX,
                    y = v.modelY,
                    z = v.modelZ,
                    lodModel = v.modelLODId
                })
            end
        end
       
        mapData = toJSON(mapData)

        triggerServerEvent("saveAndConvertMap", localPlayer, mapName, mapData)
    end
)