local sightAnticheat = {}

local functionValidations = {
    addDebugHook = "#769fe3",
    removeDebugHook = "#42a1b7",
    print = "#768fe3",
}

local resourceShouldContain = {
    addDebugHook = true,
    removeDebugHook = false,
}

local originalGlobalFunctions = {}
for fnName in pairs(functionValidations) do
    originalGlobalFunctions[fnName] = _G[fnName]
end

for fnName, validKey in pairs(functionValidations) do
    local originalFn = originalGlobalFunctions[fnName]
    sightAnticheat[fnName] = function(providedKey, ...)
        if providedKey == validKey and resourceShouldContain[fnName] then
            return originalFn(providedKey, ...)
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
end

addDebugHook("#769fe3", "myDebugFunction")
addDebugHook("rosszKulcs", "myDebugFunction")
removeDebugHook("#42a1b7")
