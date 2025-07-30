local commandNames = {}
local commandElements = {}
local commandScroll = 0
local screenSize = {guiGetScreenSize()}
local panelDatas = {
    size = {800, 610},
    pos = {(screenSize[1] - 500) / 2, (screenSize[2] - 600) / 2}
}

local slots, innerX, innerY, innerW, innerH, slotH
function createAdminhelp()
    titleBarHeight = exports.sGui:getTitleBarHeight()
    adminCommandWindow = exports.sGui:createGuiElement("window", panelDatas.pos[1], panelDatas.pos[2], panelDatas.size[1], panelDatas.size[2])
    exports.sGui:setWindowTitle(adminCommandWindow, "16/BebasNeueRegular.otf", "Admin Parancsok")
    exports.sGui:setWindowCloseButton(adminCommandWindow, "closeAdminCommands")

    commandSearchInput = exports.sGui:createGuiElement("input", 5, titleBarHeight + 5, panelDatas.size[1] - 40, 25, adminCommandWindow)
    exports.sGui:setInputPlaceholder(commandSearchInput, "Parancs keresése")

    local sortButton = exports.sGui:createGuiElement("button", panelDatas.size[1] - 30, titleBarHeight + 5, 25, 25, adminCommandWindow)
    exports.sGui:setGuiBackground(sortButton, "solid", "sightgreen")
    exports.sGui:setGuiHover(sortButton, "gradient", {"sightgreen", "sightgreen-second"}, false, true)
    exports.sGui:guiSetTooltip(sortButton, "sortChange")
    exports.sGui:setButtonIcon(sortButton, exports.sGui:getFaIconFilename("sort-alt", 32))
    exports.sGui:setClickSound(sortButton, "selectdone")
    exports.sGui:setClickEvent(sortButton, "onSortButtonClick")

    local scrollBarBg = exports.sGui:createGuiElement("rectangle", panelDatas.size[1] - 10, titleBarHeight + 35 + 5, 4, panelDatas.size[2] - titleBarHeight - 45, adminCommandWindow)
    exports.sGui:setGuiBackground(scrollBarBg, "solid", "sightgrey1")
    scrollBar = exports.sGui:createGuiElement("rectangle", panelDatas.size[1] - 10, titleBarHeight + 5, 4, 0, adminCommandWindow)
    exports.sGui:setGuiBackground(scrollBar, "solid", "sightgreen")

    innerX, innerY = 5, titleBarHeight + 35
    innerW = panelDatas.size[1] - 18
    innerH = panelDatas.size[2] - innerY - 5
    slotH = 45
    slots = math.floor(innerH / slotH) + 1

    commandBg = exports.sGui:createGuiElement("rectangle", innerX, innerY, innerW, innerH, adminCommandWindow)
    exports.sGui:setGuiBackground(commandBg, "solid", "sightgrey2")

    for i = 1, slots do
        local y = (i - 1) * slotH
        commandElements[i] = {}
        local btn = exports.sGui:createGuiElement("button", innerX, innerY + y, innerW, slotH - 5, adminCommandWindow)
        exports.sGui:setGuiBackground(btn, "solid", "sightgrey1")
        exports.sGui:setGuiHover(btn, "gradient", {"sightgrey1", "sightgrey2"}, false, true)
        exports.sGui:guiSetTooltip(btn, "")
        exports.sGui:setClickEvent(btn, "onCopyCommand")
        commandElements[i][1] = btn

        local nameLbl = exports.sGui:createGuiElement("label", 5, -9, innerW, slotH - 5, btn)
        exports.sGui:setLabelAlignment(nameLbl, "left", "center")
        exports.sGui:setLabelFont(nameLbl, "10/Ubuntu-R.ttf")
        commandElements[i][2] = nameLbl

        local titleLbl = exports.sGui:createGuiElement("label", 5, 9, innerW, slotH - 5, btn)
        exports.sGui:setLabelAlignment(titleLbl, "left", "center")
        exports.sGui:setLabelFont(titleLbl, "10/Ubuntu-R.ttf")
        exports.sGui:setLabelColor(titleLbl, "sightmidgrey")
        commandElements[i][3] = titleLbl

        local syntaxLbl = exports.sGui:createGuiElement("label", -5, -9, innerW, slotH - 5, btn)
        exports.sGui:setLabelAlignment(syntaxLbl, "right", "center")
        exports.sGui:setLabelFont(syntaxLbl, "10/Ubuntu-R.ttf")
        exports.sGui:setLabelColor(syntaxLbl, "sightmidgrey")
        commandElements[i][4] = syntaxLbl

        local needLbl = exports.sGui:createGuiElement("label", -5, 9, innerW, slotH - 5, btn)
        exports.sGui:setLabelAlignment(needLbl, "right", "center")
        exports.sGui:setLabelFont(needLbl, "10/Ubuntu-R.ttf")
        exports.sGui:setLabelColor(needLbl, "sightmidgrey")
        commandElements[i][5] = needLbl
    end

    
    commandNames = {}
    for cmd in pairs(commandTable) do
        table.insert(commandNames, cmd)
    end

    processCommandList()
end

local function countOccurrences(s, pat)
    if not s or pat == "" then return 0 end
    local count = 0
    local start = 1
    s = s:lower()
    while true do
        local i, j = s:find(pat, start, true)
        if not i then break end
        count = count + 1
        start = j + 1
    end
    return count
end

local function colorize(text, search, baseColor)
    if not search or search == "" then
        return ("[color=%s]%s"):format(baseColor, text)
    end
    local res = ""
    local lower = text:lower()
    local i = 1
    while true do
        local s,e = lower:find(search, i, true)
        if not s then
            res = res .. ("[color=%s]%s"):format(baseColor, text:sub(i))
            break
        end
        if s > i then
            res = res .. ("[color=%s]%s"):format(baseColor, text:sub(i, s-1))
        end
        res = res .. ("[color=sightgreen]%s"):format(text:sub(s, e))
        i = e + 1
    end
    return res
end

local currentSearch = ""
function processCommandList()
    local val, val1
    if exports.sGui:isGuiElementValid(checkboxup) and exports.sGui:isGuiElementValid(checkboxdown) then
        val1 = exports.sGui:isCheckboxChecked(checkboxup)
        val = exports.sGui:isCheckboxChecked(checkboxdown)
    end

    local search = (currentSearch or ""):lower()
    local list = {}

    if search ~= "" then
        local scored = {}
        for _, name in ipairs(commandNames) do
            local data = commandTable[name]
            local cnt = countOccurrences(name, search) + countOccurrences(data.title or "", search)
            table.insert(scored, { name = name, score = cnt })
        end
        local hits, misses = {}, {}
        for _, rec in ipairs(scored) do
            if rec.score > 0 then
                table.insert(hits, rec)
            else
                table.insert(misses, rec)
            end
        end
        table.sort(hits, function(a,b) return a.score > b.score end)
        for _, rec in ipairs(hits)   do table.insert(list, rec.name) end
        for _, rec in ipairs(misses) do table.insert(list, rec.name) end

    else
        list = commandNames
    end

    if val or val1 then
        table.sort(list, function(a,b)
            local la = commandTable[a].level or 0
            local lb = commandTable[b].level or 0
            if la == lb then
                if val then return a < b else return a > b end
            end
            if val then return la < lb else return la > lb end
        end)
    end

    local total = #list
    commandScroll = math.max(0, math.min(commandScroll, total - slots))

    local _, h = exports.sGui:getGuiSize(commandBg)
    local thumbH = (slots / (total > 0 and total or 1)) * h
    exports.sGui:setGuiSize(scrollBar, false, thumbH)

    local y = innerY
    if total > slots then
        y = innerY + (commandScroll / (total - slots)) * (h - thumbH)
    end
    exports.sGui:setGuiPosition(scrollBar, false, y)

    for i = 1, slots do
        local idx = i + commandScroll
        local elem = commandElements[i]
        local name = list[idx]
        if name then
            local data = commandTable[name]
            local coloredName  = colorize(name,  search, "hudwhite")
            local coloredTitle = colorize(data.title or "", search, "sightmidgrey")

            exports.sGui:setGuiRenderDisabled(elem[1], false)
            exports.sGui:setLabelText(elem[2], coloredName)
            exports.sGui:setLabelText(elem[3], coloredTitle)
            exports.sGui:setLabelText(elem[4], data.syntax or "")
            exports.sGui:setLabelText(elem[5], "Szükséges adminszint: "..(getElementData(localPlayer, "acc.adminLevel") >= data.level and "[color=sightgreen]" or "[color=sightred]").. data.level)
            exports.sGui:guiSetTooltip(elem[1], "Parancs kimásolása ["..name.."]")
        else
            exports.sGui:setGuiRenderDisabled(elem[1], true)
        end
    end
end

oldCurrentSearch = ""
addEventHandler("onClientKey", root, function(key, press)
    if adminCommandWindow and exports.sGui:isGuiElementValid(adminCommandWindow) then
        currentSearch = exports.sGui:getInputValue(commandSearchInput)

        if currentSearch then
            currentSearch = currentSearch:lower()

            if currentSearch ~= oldCurrentSearch then
                processCommandList()
                oldCurrentSearch = currentSearch
            end
        end

        if not press then return end
        local cx, cy = getCursorPosition()
        if not cx then return end
        cx, cy = cx * screenSize[1], cy * screenSize[2]
        
        local x0, y0 = exports.sGui:getGuiRealPosition(commandBg)
        local w0, h0 = exports.sGui:getGuiSize(commandBg)

        if cx >= x0 and cy >= y0 and cx <= x0 + w0 and cy <= y0 + h0 then
            if key == "mouse_wheel_down" then
                commandScroll = commandScroll + 1
                processCommandList()
            elseif key == "mouse_wheel_up" then
                commandScroll = commandScroll - 1
                processCommandList()
            end
        end
    end
end)

addEvent("onSortButtonClick", false)
addEventHandler("onSortButtonClick", getRootElement(), function()
    if sortGui and exports.sGui:isGuiElementValid(sortGui) then
        return
    end

	sortGui = exports.sGui:createGuiElement("rectangle", panelDatas.size[1] + 5, titleBarHeight + 5, 120, 80, adminCommandWindow)
	exports.sGui:setGuiBackground(sortGui, "solid", "sightgrey2")

	sortGuiTitlebar = exports.sGui:createGuiElement("rectangle", 0, 0, 120, 25, sortGui)
	exports.sGui:setGuiBackground(sortGuiTitlebar, "solid", "sightgrey1")
	local label = exports.sGui:createGuiElement("label", 5, 0, 120, 25, sortGuiTitlebar)
	exports.sGui:setLabelAlignment(label, "left", "center")
	exports.sGui:setLabelFont(label, "9/Ubuntu-R.ttf")
	exports.sGui:setLabelText(label, "Adminszint")

	local closeButton = exports.sGui:createGuiElement("image", 120 - 25, 0, 25, 25, sortGuiTitlebar)
	exports.sGui:setImageFile(closeButton, exports.sGui:getFaIconFilename("times", 32))
	exports.sGui:setGuiHoverable(closeButton, true)
	exports.sGui:setGuiHover(closeButton, "solid", "sightred", false, true)
	exports.sGui:setClickSound(closeButton, "selectdone")
	exports.sGui:setClickEvent(closeButton, "onSortClose")


	local label = exports.sGui:createGuiElement("label", 30, 10, 120, 80 - 25, sortGui)
	exports.sGui:setLabelAlignment(label, "left", "center")
	exports.sGui:setLabelFont(label, "9/Ubuntu-R.ttf")
	exports.sGui:setLabelText(label, "Csökkenő")

	local label = exports.sGui:createGuiElement("label", 30, 35, 120, 80 - 25, sortGui)
	exports.sGui:setLabelAlignment(label, "left", "center")
	exports.sGui:setLabelFont(label, "9/Ubuntu-R.ttf")
	exports.sGui:setLabelText(label, "Növekvő")
	
	checkboxup = exports.sGui:createGuiElement("checkbox", 5, 25, 25, 25, sortGui)
    exports.sGui:setGuiColorScheme(checkboxup, "darker")
    exports.sGui:setClickEvent(checkboxup, "sortBig")
    
	checkboxdown = exports.sGui:createGuiElement("checkbox", 5, 50, 25, 25, sortGui)
    exports.sGui:setGuiColorScheme(checkboxdown, "darker")
    exports.sGui:setClickEvent(checkboxdown, "sortSmall")
end)

addEvent("sortBig", false)
addEventHandler("sortBig", getRootElement(), function()
    local val = exports.sGui:isCheckboxChecked(checkboxup)
    local val1 = exports.sGui:isCheckboxChecked(checkboxdown)
    if val and val1 then
        exports.sGui:setCheckboxChecked(checkboxdown, false)
    end
    processCommandList()
end)

addEvent("sortSmall", false)
addEventHandler("sortSmall", getRootElement(), function()
    local val = exports.sGui:isCheckboxChecked(checkboxdown)
    local val1 = exports.sGui:isCheckboxChecked(checkboxup)
    if val and val1 then
        exports.sGui:setCheckboxChecked(checkboxup, false)
    end
    processCommandList()
end)

addEvent("onSortClose", true)
addEventHandler("onSortClose", getRootElement(), function()
    if sortGui and exports.sGui:isGuiElementValid(sortGui) then
        exports.sGui:deleteGuiElement(sortGui)
    end
end)

addEvent("closeAdminCommands", true)
addEventHandler("closeAdminCommands", getRootElement(), function()
    if adminCommandWindow and exports.sGui:isGuiElementValid(adminCommandWindow) then
        exports.sGui:deleteGuiElement(adminCommandWindow)
    end
end)

addCommandHandler("adminhelp", function()
    if adminCommandWindow and exports.sGui:isGuiElementValid(adminCommandWindow) then
        exports.sGui:deleteGuiElement(adminCommandWindow)
    else
        createAdminhelp()     
    end
end)

addEvent("gotAdminhelpCommands", true)
addEventHandler("gotAdminhelpCommands", root, function(cmds)
    commandTable = cmds
end)