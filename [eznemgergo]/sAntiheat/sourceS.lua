local fileData = [[
local sightAnticheat = {}

local functionValidations = {
    addDebugHook = "sight-anticheatKey-eznemgergo@2025",
    removeDebugHook = "sight-anticheatKey-eznemgergo@2025",
    print = "sight-anticheatKey-eznemgergo@2025",
    outputChatBox = "sight-anticheatKey-eznemgergo@2025"
}

local originalGlobalFunctions = {}
for fnName in pairs(functionValidations) do
    originalGlobalFunctions[fnName] = _G[fnName]
end

for fnName, validKey in pairs(functionValidations) do
    local originalFn = originalGlobalFunctions[fnName]
    sightAnticheat[fnName] = function(providedKey, ...)
        if providedKey == validKey then
            return originalFn(...)
        else
            outputDebugString(
                ("Frenk - func: %s l key: %s"):format(
                    fnName, tostring(providedKey)
                )
            )
            return false
        end
    end
end

for fnName in pairs(functionValidations) do
    _G[fnName] = function(providedKey, ...)
        return sightAnticheat[fnName](providedKey, ...)
    end
end]]

local function removeSightAnticheat(resourceName)
    local resourcePath = ":".. resourceName .."/"
    local luaPath = resourcePath .."sightAnticheat.lua"
    local xmlPath = resourcePath .. "meta.xml"
    if fileExists(luaPath) then

    end
end

local function installSightAnticheat(resourceName)
    local resourcePath = ":".. resourceName .."/"
    local luaPath = ":".. resourceName .."/sightAnticheat.lua"
    if not fileExists(luaPath) then
        if resourceName and fileExists(resourcePath .. "meta.xml") then
            local xmlPath = resourcePath .. "meta.xml"
            local thisFile = fileOpen(xmlPath)
            local fileData = fileRead(thisFile, fileGetSize(thisFile))

            local newData = fileData:gsub("<meta>", '<meta>\n    <script src="sightAnticheat.lua" type="client"/>')
            fileClose(thisFile)
            fileDelete(xmlPath)

            local newFile = fileCreate(xmlPath)
            fileWrite(newFile, newData)
            fileClose(newFile)
            print("meta.xml updated.")
        end

        if resourceName then
            local newFile = fileCreate(luaPath)
            fileWrite(newFile, fileData)
            fileClose(newFile)
            print("resource updated ac.")
        end
    end
end

installSightAnticheat("sOverview")