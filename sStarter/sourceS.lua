local highPriority = {
    "sPattach",
    "sWhitelist",
    "sGui",
    "sConnection",
    "sProtectedModels",
    "sModloader",
    "sPreloader",
    "sPermission",
    "sCore",
    "sAdministration",
    "sVehicles",
    "sLoader",
    "sHud",
    "sRadar",
    "sGps",
    "sDamage",
    "sTuning",
    "sSpeedo",
    "sMobile",
}
local highPriorityEx = {}

local lowPriority = {
    "sAccounts",
    "sDealer",
    "sTrading",
    "sBank",
}
local lowPriorityEx = {}

addEventHandler("onResourceStart", resourceRoot, function()
    local sortedResources = {}

    for k, v in pairs(highPriority) do
        local res = getResourceFromName(v)

        if res then
            highPriorityEx[v] = true
            table.insert(sortedResources, res)
        end
    end
    
    for k, v in pairs(lowPriority) do
        local res = getResourceFromName(v)

        if res then
            lowPriorityEx[v] = true
        end
    end

    local resources = getResources()
    for i = 1, #resources do
        local res = resources[i]
        local resName = getResourceName(res)

        if not highPriorityEx[resName] and not lowPriorityEx[resName] then
            table.insert(sortedResources, res)
        end
    end

    for k, v in pairs(lowPriority) do
        local res = getResourceFromName(v)

        if res then
            table.insert(sortedResources, res)
        end
    end
    table.insert(sortedResources, getResourceFromName("sLast"))

    for i = 1, #sortedResources do
        local res = sortedResources[i]
        local resName = getResourceName(res)
        local metaFile = xmlLoadFile(":" .. resName .. "/meta.xml")

        if metaFile then
            local dpg = xmlFindChild(metaFile, "download_priority_group", 0)
            local dpgValue = 0 - i

            if not dpg then
                dpg = xmlCreateChild(metaFile, "download_priority_group")
            end

            xmlNodeSetValue(dpg, tostring(dpgValue))
            xmlSaveFile(metaFile)
            xmlUnloadFile(metaFile)
        end
    end

    for i = 1, #sortedResources do
        local res = sortedResources[i]
        local resName = getResourceName(res)

        if utfSub(resName, 1, 1) == "s" then
            startResource(res, true)
        end
    end
    
    stopResource(getThisResource())
end)