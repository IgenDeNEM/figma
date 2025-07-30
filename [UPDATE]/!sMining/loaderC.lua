local seexports = {
    ["sControls"] = true,
    ["sGui"] = true,
}

local function seelangProcessExports()
    for k in pairs(seexports) do
        local res = getResourceFromName(k)

        if res and getResourceState(res) == "running" then
            seexports[k] = exports[k]
        else
            seexports[k] = false
        end
    end
end
seelangProcessExports()

if triggerServerEvent then
    addEventHandler("onClientResourceStart", getRootElement(), seelangProcessExports, true, "high+9999999999")
end

if triggerClientEvent then
    addEventHandler("onResourceStart", getRootElement(), seelangProcessExports, true, "high+9999999999")
end

local textureListEx = {}
local textureList = {
    ["files/loading/1.dds"] = "dxt1",
    ["files/loading/2.dds"] = "dxt1",
    ["files/loading/3.dds"] = "dxt1",
    ["files/loading/4.dds"] = "dxt1",
    ["files/loading/5.dds"] = "dxt1",
    ["files/loading/6.dds"] = "dxt1",
    ["files/loading/sp2.dds"] = "argb",
    ["files/loading/sp1.dds"] = "argb",
}

addEventHandler("onClientResourceStart", getRootElement(), function(startedResource)
    if startedResource == getThisResource() then
        for texture, format in pairs(textureList) do
            textureListEx[texture] = dxCreateTexture(texture, format, true)
        end
    end
end)

local loaderBackground = 1

loaderA = 0
loadingMineLobby = false
loadedMineLobby = false
loadingMineLobbyExit = false
loadingMineLobbyExitSynced = false
loadingMineEnter = false
loadingMineEnterSynced = false
loadingMineExit = false
loadingMineExitSynced = false

function preRenderLoader(delta)
    if isLoaderState() then
        loaderA = loaderA + 2 * delta / 500

        if loaderA >= 1 then
            loaderA = 8

            if loadingMineLobby and loadedMineLobby ~= loadingMineLobby then
                loadedMineLobby = loadingMineLobby
                triggerServerEvent("tryToEnterMineLobby", localPlayer, loadingMineLobby)
            elseif loadingMineEnter and loadingMineEnterSynced ~= loadingMineEnter then
                loadingMineEnterSynced = loadingMineEnter
                triggerServerEvent("tryToEnterMine", localPlayer, loadingMineEnter)
            elseif loadingMineLobbyExit and not loadingMineLobbyExitSynced then
                loadingMineLobbyExitSynced = true
                triggerServerEvent("tryToExitMineLobby", localPlayer)
            elseif loadingMineExit and not loadingMineExitSynced then
                loadingMineExitSynced = true
                triggerServerEvent("tryToExitMine", localPlayer)
            end
        end
    elseif loaderA > 0 then
        if loaderA > 1 then
            delta = math.min(delta, 100)
        end

        loaderA = loaderA - 2 * delta / 500

        if loaderA < 0 then
            loaderA = 0
            handleEvent("onClientPreRender", getRootElement(), preRenderLoader, "removeEvent")
            handleEvent("onClientRender", getRootElement(), renderLoader, "removeEvent")
            seexports.sControls:toggleAllControls(true, "mineLoader")
            setElementFrozen(localPlayer, false)
        end
    end
end

function renderLoader()
    local currentTick = getTickCount()
    local loaderAlpha = math.min(1, loaderA)
    local scaleFactor = 1.5 - loaderAlpha * 0.5
    local scaledHeight = (screenY + 2) * scaleFactor
    local scaledWidth = math.ceil(scaledHeight * 1.7777777777777777)

    if scaledWidth < screenX then
        dxDrawRectangle(0, 0, screenX / 2 - scaledWidth / 2, screenY, tocolor(0, 0, 0, 255 * loaderAlpha))
        dxDrawRectangle(screenX / 2 + scaledWidth / 2, 0, screenX / 2 - scaledWidth / 2, screenY, tocolor(0, 0, 0, 255 * loaderAlpha))
    end

    dxDrawImage(screenX / 2 - scaledWidth / 2, screenY / 2 - scaledHeight / 2, scaledWidth, scaledHeight, textureListEx["files/loading/" .. loaderBackground .. ".dds"], 0, 0, 0, tocolor(255, 255, 255, 255 * loaderAlpha))
    
    local iconSize = 90 * scaleFactor
    dxDrawImage(screenX / 2 - iconSize / 2, screenY / 2 - iconSize / 2, iconSize, iconSize, textureListEx["files/loading/sp2.dds"], 0, 0, 0, tocolor(green[1] * 0.1, green[2] * 0.1, green[3] * 0.1, 200 * loaderAlpha))
    dxDrawImage(screenX / 2 - iconSize / 2, screenY / 2 - iconSize / 2, iconSize, iconSize, textureListEx["files/loading/sp1.dds"], -currentTick / 4.75 % 360, 0, 0, tocolor(green[1], green[2], green[3], 255 * loaderAlpha))
    dxDrawText("Betöltés folyamatban...", 0, screenY / 2 + 50 + 12, screenX, screenY / 2 + 50 + 12 + 32, tocolor(255, 255, 255, 255 * loaderAlpha), loaderFontScale * scaleFactor, loaderFont, "center", "center")
    --loaderText = "..."
    if loaderText then
        dxDrawText(loaderText, 0, screenY / 2 + 50 + 12 + 32, screenX, screenY / 2 + 50 + 12 + 32 + 32, tocolor(255, 255, 255, 255 * loaderAlpha), seexports.sGui:getFontScale("16/BebasNeueRegular.otf") * scaleFactor, secondaryLoaderFont, "center", "center")
    end
end

function startLoader(forceAlpha)
    if loaderA <= 0 then
        loaderBackground = math.random(1, 6)

        if forceAlpha then
            loaderA = 8
        end
    end

    handleEvent("onClientPreRender", getRootElement(), preRenderLoader, "addEvent")
    handleEvent("onClientRender", getRootElement(), renderLoader, "addEvent", "low-9999999999")

    seexports.sControls:toggleAllControls(false, "mineLoader")
    setElementFrozen(localPlayer, true)
end
--startLoader(true)
function isLoaderState()
    return loadingMineLobby or loadingMineLobbyExit or loadingMineEnter or loadingMineExit
end

function isLoading()
    if loaderA > 0 then
        return true
    end

    return isLoaderState()
end