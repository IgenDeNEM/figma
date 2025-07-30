local seexports = {
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

guiColorCodes = {}

guiIcons = {}

guiColors = {}

function refreshColors()
    local resource = getResourceFromName("sGui")
    if resource and getResourceState(resource) == "running" then
        greenToColor = seexports.sGui:getColorCodeToColor("sightgreen")
        blueToColor = seexports.sGui:getColorCodeToColor("sightblue")
        yellowToColor = seexports.sGui:getColorCodeToColor("sightyellow")
        redToColor = seexports.sGui:getColorCodeToColor("sightred")
        green = seexports.sGui:getColorCode("sightgreen")
        blue = seexports.sGui:getColorCode("sightblue")
        grey1 = seexports.sGui:getColorCode("sightgrey1")
        grey2 = seexports.sGui:getColorCode("sightgrey2")
        midgrey = seexports.sGui:getColorCode("sightmidgrey")
        lightgrey = seexports.sGui:getColorCode("sightlightgrey")
        orange = seexports.sGui:getColorCode("sightorange")
        yellow = seexports.sGui:getColorCode("sightyellow")
        red = seexports.sGui:getColorCode("sightred")
        constructionIcon = seexports.sGui:getFaIconFilename("construction", 24)
        digIcon = seexports.sGui:getFaIconFilename("bomb", 24)
        joyIcon = seexports.sGui:getFaIconFilename("joystick", 24)
        cancelIcon = seexports.sGui:getFaIconFilename("times", 24)
        rideIcon = seexports.sGui:getFaIconFilename("hand-rock", 24)
        bulbIcon = seexports.sGui:getFaIconFilename("lightbulb", 24)
        carryIcon = seexports.sGui:getFaIconFilename("person-carry", 24)
        downIcon = seexports.sGui:getFaIconFilename("arrow-alt-down", 24)
        emptyIcon = seexports.sGui:getFaIconFilename("share", 24)
        fillDripIcon = seexports.sGui:getFaIconFilename("fill-drip", 24)
        intoIcon = seexports.sGui:getFaIconFilename("inbox-in", 24)
        sackIcon = seexports.sGui:getFaIconFilename("sack", 24)
        idIcon = seexports.sGui:getFaIconFilename("id-card-alt", 24)
        fuelIcon = seexports.sGui:getFaIconFilename("gas-pump", 24)
        computerIcon = seexports.sGui:getFaIconFilename("computer-classic", 24)
        washIcon = seexports.sGui:getFaIconFilename("hand-sparkles", 24)
        toggleIcon = seexports.sGui:getFaIconFilename("power-off", 24)
        oreFont = seexports.sGui:getFont("10/Ubuntu-R.ttf")
        oreFontScale = seexports.sGui:getFontScale("10/Ubuntu-R.ttf")
        oreFontHeight = seexports.sGui:getFontHeight("10/Ubuntu-R.ttf")
        timerFont = seexports.sGui:getFont("14/BebasNeueBold.otf")
        timerFontScale = seexports.sGui:getFontScale("14/BebasNeueBold.otf")
        timerFontHeight = seexports.sGui:getFontHeight("14/BebasNeueBold.otf")
        timerFontWidth = seexports.sGui:getTextWidthFont("00:00", "14/BebasNeueBold.otf")
        loaderFont = seexports.sGui:getFont("20/BebasNeueBold.otf")
        secondaryLoaderFont = seexports.sGui:getFont("16/BebasNeueRegular.otf")
        loaderFontScale = seexports.sGui:getFontScale("20/BebasNeueBold.otf")
        faTicks = seexports.sGui:getFaTicks()
        guiIconTicks = seexports.sGui:getFaTicks()
        
        guiFontScales = {
            oreFont = seexports.sGui:getFontScale("10/Ubuntu-R.ttf"),
            timerFont = seexports.sGui:getFontScale("14/BebasNeueBold.otf"),
            loaderFont = seexports.sGui:getFontScale("20/BebasNeueBold.otf"),
        }
        
        guiFonts = {
            oreFont = seexports.sGui:getFont("10/Ubuntu-R.ttf"),
            timerFont = seexports.sGui:getFont("14/BebasNeueBold.otf"),
            loaderFont = seexports.sGui:getFont("20/BebasNeueBold.otf"),
        }

        guiFontHeights = {
            timerFont = seexports.sGui:getFontHeight("14/BebasNeueBold.otf"),
            oreFont = seexports.sGui:getFontHeight("10/Ubuntu-R.ttf")
        }

        guiIcons = {
            constructionIcon = seexports.sGui:getFaIconFilename("construction", 24),
            digIcon = seexports.sGui:getFaIconFilename("bomb", 24),
            joyIcon = seexports.sGui:getFaIconFilename("joystick", 24),
            cancelIcon = seexports.sGui:getFaIconFilename("times", 24),
            rideIcon = seexports.sGui:getFaIconFilename("hand-rock", 24),
            bulbIcon = seexports.sGui:getFaIconFilename("lightbulb", 24),
            carryIcon = seexports.sGui:getFaIconFilename("person-carry", 24),
            downIcon = seexports.sGui:getFaIconFilename("arrow-alt-down", 24),
            emptyIcon = seexports.sGui:getFaIconFilename("share", 24),
            fillDripIcon = seexports.sGui:getFaIconFilename("fill-drip", 24),
            intoIcon = seexports.sGui:getFaIconFilename("inbox-in", 24),
            sackIcon = seexports.sGui:getFaIconFilename("sack", 24),
            idIcon = seexports.sGui:getFaIconFilename("id-card-alt", 24),
            fuelIcon = seexports.sGui:getFaIconFilename("gas-pump", 24),
            computerIcon = seexports.sGui:getFaIconFilename("computer-classic", 24),
            washIcon = seexports.sGui:getFaIconFilename("hand-sparkles", 24),
            toggleIcon = seexports.sGui:getFaIconFilename("power-off", 24),
        }
        
    end
end
addEventHandler("onGuiRefreshColors", getRootElement(), refreshColors)
addEventHandler("onClientResourceStart", getResourceRootElement(), refreshColors)

addEventHandler("refreshFaTicks", getRootElement(), function()
    faTicks = seexports.sGui:getFaTicks()
    guiIconTicks = seexports.sGui:getFaTicks()
end)

screenX, screenY = guiGetScreenSize()