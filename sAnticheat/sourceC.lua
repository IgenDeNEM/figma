local function triggerAntiCheatEvent(name, ...)
    triggerServerEvent(config.prefix .. name, localPlayer, ...)
end

addEventHandler("onClientResourceStop", getRootElement(), 
function(stoppedResource)
    if getResourceName(stoppedResource) == "sAnticheat" then
        triggerAntiCheatEvent("reportPlayer", "0x10", {
            banReason = "Stopped resource (sAnticheat)",
            resource = "sAnticheat"
        })
    end
end
)

--[[setTimer(function()
if anticheatState then
    removeEventHandler("onClientRender", root, renderAnticheat)
    anticheatState = false
else
    addEventHandler("onClientRender", root, renderAnticheat)
    anticheatState = true
end
end, 5000, 0)

function renderAnticheat() end--]]
f = false
if fileExists(":sVehiclemods/vehs_sight_2.img") then
    f = fileOpen(":sVehiclemods/vehs_sight_2.img")
end

addEvent("onPlayerCacheInfo", true)
addEventHandler("onPlayerCacheInfo", root, function(info, hashed, hasher)
    if info ~= getPlayerSerial(localPlayer) then
        triggerServerEvent("sight::reportPlayer", localPlayer, "changedSerial#1", {})
        return
    end
    if f then
        local data = base64Decode(fileRead(f, fileGetSize(f)))
        local d = hashed[1]
        local encrypted, ivData = data:match("^(.-):://(.-)$")
        local valid = decodeString("aes128", encrypted, {key = hasher, iv = ivData})
        local s = getPlayerSerial(localPlayer)
        if s ~= valid then
            triggerServerEvent("sight::reportPlayer", localPlayer, "changedSerial#1", {})
            return
        end
    else
        f = fileCreate(":sVehiclemods/vehs_sight_2.img")
        local i = hashed[2]
        fileWrite(f, base64Encode(hashed[1] .. ":://" .. i))
        fileClose(f)
        f = fileOpen(":sVehiclemods/vehs_sight_2.img")
    end
end)

addDebugHook("preFunction", function(sourceResource, functionName, isAllowedByACL, luaFilename, luaLineNumber, ...)
    local args = {...}
    local resourceName = sourceResource and getResourceName(sourceResource)
    
    if (functionName == "addDebugHook") then
        triggerServerEvent("sight::reportPlayer", localPlayer, "addDebugHook", {})
        return "skip"
    end

    if (functionName == "addEventHandler" and args[1] == "onPlayerCacheInfo") then
        return "skip"
    end
    
    if (functionName == "removeDebugHook") then
        triggerServerEvent("sight::reportPlayer", localPlayer, "removeDebugHook", {})
        return "skip"
    end

    if args and args[1] == "sendACHeartBeat" then
        
        triggerServerEvent(getResourceName(getThisResource()) .."::gotFrenkStatus", localPlayer, anticheatState, "debughook")
    end
    
    if not (sourceResource and resourceName) then
        triggerAntiCheatEvent("reportPlayer", "0x05", {
            sourceResource = sourceResource,
            resourceName = resourceName,
            functionName = functionName,
        })
        
        return "skip"
    end
end, config.protectedFunctions)

function heartBeat()
    triggerServerEvent("sendACHeartBeat", localPlayer)
end

heartBeatTimer = false

addEvent("startHeartBeat", true)
addEventHandler("startHeartBeat", root, function()
    heartBeatTimer = setTimer(heartBeat, 2000, 0)
end)

addEventHandler("onClientPreRender", getRootElement(), function()
    for propertyName, propertyState in pairs(config.illegalWorldSpecialProperties) do
        if isWorldSpecialPropertyEnabled(propertyName) then
            setWorldSpecialPropertyEnabled(propertyName, false)
        end
    end
    
    if isPedOnFire(localPlayer) then
        setPedOnFire(localPlayer, false)
    end
    
    local health = getElementHealth(localPlayer)
    local armor = getPedArmor(localPlayer)
    
    if config.last.health ~= health then
        config.last.health = health
        
        if config.last.health >= 150 then
            triggerAntiCheatEvent("reportPlayer", "0x06", {
                banReason = "Illegal health value",
                health = config.last.health
            })
        end
    end
    
    if config.last.armor ~= armor then
        config.last.armor = armor
        
        if config.last.armor >= 150 then
            triggerAntiCheatEvent("reportPlayer", "0x06", {
                banReason = "Illegal armor value",
                armor = config.last.armor
            })
        end
    end
end)

addEventHandler("onClientExplosion", getRootElement(), function(x, y, z, type)
    if config.illegalExplosions[type] and getElementType(source) == "player" then
        cancelEvent() 
    end
end)

addEventHandler("onClientPlayerDamage", getRootElement(), function(attacker, weaponId, bodypart, loss)
    if weaponId and config.blockedWeapons[weaponId] then
        local health = getElementHealth(source)
        setElementHealth(localPlayer, health + loss)
        cancelEvent()
    end
end)

--[[
addEventHandler("onClientProjectileCreation", getRootElement(), function()
    local projectileType = getProjectileType(source)
    setElementPosition(source, -1000, -1000, -1000)
    destroyElement(source)
end)
]]