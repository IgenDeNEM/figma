local skillbooks = {}
local weaponItemIds = {}

local playerNoAmmo = {}

local pickaxeItems = {
    [164] = true,
    [724] = true,
    [725] = true,
    [726] = true,
    [727] = true
}

local warningItems = {
    [188] = "vehicle", -- Karosszéria fix
    [189] = "vehicle", -- Üzemanyag kártya
    [406] = true, -- Fegyverjavító
    [190] = true, -- Fegyverjavító
    [423] = true, -- Háziállat átnevező
    [590] = true, -- Haszonállat kártya
    [591] = true, -- Respawn
    [599] = "vehicle", -- Futómű
    [600] = "vehicle", -- Nagyszervíz
    [601] = "vehicle", -- Prémium full szerviz
    [602] = "vehicle", -- Motor kisszervíz
    [603] = "vehicle", -- Akkumlátor
    [604] = "vehicle", -- Gumi
    [605] = "vehicle" -- Fék
}

local sightexports = {
    sGui = false,
    sConnection = false,
    sPermission = false,
    sChat = false,
    sWeapons = false,
    sControls = false
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

function safeCall(resourceName, fnName, ...)
    local res = getResourceFromName(resourceName)
    if res and getResourceState(res) == "running" then
        return call(res, fnName, ...)
    end
end

local blockedItems = {
    [313] = true,
}


local intToBool = {
    [1] = true,
    [0] = false
}

local connection = nil

if sightexports.sConnection then
    connection = sightexports.sConnection:getConnection()
end

addEventHandler("onDatabaseConnected", root, function(newConnection)
    connection = newConnection
end)


local queuedPhoneItems = {}

local usedItemDatas = {}

local usedSecondaryItems = {}

local usedMegaphones = {}

function usingMegaphone(playerElement)
    if usedMegaphones[playerElement] then
        return true
    else
        return false
    end
end

function isAirsoftItem(id)
	local is = false
	for k, v in pairs(airSoftItems) do
		if v == id then
			is = true
			break
		end
	end
	return is
end

local unUseFunctions = {
    ["sheepCutter"] = function(thePlayer, itemData)
        unUseClientFunctions(thePlayer, itemData)
    end,
    ["groupTablet"] = function(thePlayer, itemData)
        if getElementData(thePlayer, "usingGroupTablet") then
            setElementData(thePlayer, "usingGroupTablet", false)
            unUseClientFunctions(thePlayer, itemData, true)
        end
    end,
    ["milkaMode"] = function(thePlayer, itemData)
        unUseClientFunctions(thePlayer, itemData)
    end,
    ["metaldetector"] = function(thePlayer, itemData)
        local currentAction = getElementData(thePlayer, "rpc.action")
        if currentAction and currentAction[2] == "detektor" then
            setElementData(thePlayer, "rpc.action", false)
        end
        unUseClientFunctions(thePlayer, itemData)
    end,
    ["dragSlip"] = function(thePlayer, itemData)
        unUseClientFunctions(thePlayer, itemData)
    end,
    ["jumperCable"] = function(thePlayer, itemData)
        unUseClientFunctions(thePlayer, itemData)
    end,
    ["cinemaTicket"] = function(thePlayer, itemData)
        unUseClientFunctions(thePlayer, itemData)
    end,
    ["license"] = function(thePlayer, itemData)
        unUseClientFunctions(thePlayer, itemData)
    end,
    ["seedyno"] = function(thePlayer, itemData)
        unUseClientFunctions(thePlayer, itemData)
    end,
    ["weaponReceipt"] = function(thePlayer, itemData)
        unUseClientFunctions(thePlayer, itemData)
        playUseSound(thePlayer)
        safeCall("sChat", "localAction", thePlayer, "elrakott egy fegyvervásárlási bizonylatot.")
    end,
    ["serviceInvoice"] = function(thePlayer, itemData)
        unUseClientFunctions(thePlayer, itemData)
    end,
    ["raffle"] = function(thePlayer, itemData)
        unUseClientFunctions(thePlayer, itemData)
    end,
    ["nametag"] = function(thePlayer, itemData)
        unUseClientFunctions(thePlayer, itemData, true)
    end,
    ["obd"] = function(thePlayer, itemData)
        unUseClientFunctions(thePlayer, itemData)
    end,
    ["bagMode"] = function(thePlayer, itemData)
        unUseClientFunctions(thePlayer, itemData)
    end,
    ["taxiCheckout"] = function(thePlayer, itemData)
        unUseClientFunctions(thePlayer, itemData)
    end,
    ["invoice"] = function(thePlayer, itemData)
        unUseClientFunctions(thePlayer, itemData)
    end,
    ["wrench"] = function(thePlayer, itemData)
        setElementData(thePlayer, "wrenchState", false)
        safeCall("sChat", "localAction", thePlayer, "elrakott egy akkumulátoros csavarbehajtót.")
        unUseClientFunctions(thePlayer, itemData)
    end,
    ["trafficLicense"] = function(thePlayer, itemData)
        safeCall("sChat", "localAction", thePlayer, "elrakott egy forgalmi engedélyt.")
        triggerClientEvent(thePlayer, "gotTrafficLicenseData", thePlayer)
        unUseClientFunctions(thePlayer, itemData)
    end,
    ["invoiceBook"] = function(thePlayer, itemData)
        unUseClientFunctions(thePlayer, itemData)
    end,
    ["pickaxe"] = function(thePlayer, itemData)
        unUseClientFunctions(thePlayer, itemData)
    end,
    ["weapon"] = function(thePlayer, itemData)
        local itemId = itemData.itemId
        
        if itemId then
            local itemListEntry = newItemList[itemId]
            
            if itemListEntry then
                local customMessage = false

                if pickaxeItems[itemId] then
                    customMessage = true
                    safeCall("sChat", "localAction", thePlayer, "elrakott egy " .. itemListEntry.name .. "".. (itemData.nameTag and "-t (" .. itemData.nameTag .. ")" or "-t."))
                end

                if not customMessage then
                    if itemData.nameTag then
                        safeCall("sChat", "localAction", thePlayer, "elrakott egy fegyvert. (" .. itemListEntry.name .. " (" .. itemData.nameTag .. "))")
                    else
                        safeCall("sChat", "localAction", thePlayer, "elrakott egy fegyvert. (" .. itemListEntry.name .. ")")
                    end
                end
                
                
                if itemListEntry.name then
                    setElementData(thePlayer, "hasTaser", false)
                end
                
                unuseItem(thePlayer)
                unuseSecondaryItem(thePlayer, "ammo")
                
                
                exports.sWeapons:giveWeaponFromItems(thePlayer)
                
                enableWeaponFire(thePlayer, true)
                playUseSound(thePlayer)
            end
        end
    end,
    ["blowtorch"] = function(thePlayer, itemData)
        setElementData(thePlayer, "usingBlowTorch", false)
        safeCall("sChat", "localAction", thePlayer, "elrakott egy lángvágót.")
        unuseItem(thePlayer)
    end,
    ["migumoto"] = function(thePlayer, itemData)
        unuseItem(thePlayer)
        unUseClientFunctions(thePlayer, itemData)
        playUseSound(thePlayer)
    end,
    ["mobile"] = function(thePlayer, itemData)
        unuseItem(thePlayer)
        
        triggerClientEvent(thePlayer, "closePhone", thePlayer)
        triggerEvent("setPhoneUnUse", thePlayer)
        
        safeCall("sChat", "localAction", thePlayer, "elrakott egy telefont.")
        playUseSound(thePlayer)
    end,
    ["riotshield"] = function(thePlayer, itemData)
        unuseItem(thePlayer)
        
        setElementData(thePlayer, "shield", false)
        
        exports.sControls:toggleControl(thePlayer, {
            "jump",
            "sprint",
            "jog",
            "fire"
        }, true, "sShield")
    end,
    ["fishingRod"] = function(thePlayer, itemData)
        unuseItem(thePlayer)
        
        local mode = exports.sFishing:getPlayerFishingData(thePlayer, "mode")
        
        local currentAction = getElementData(thePlayer, "rpc.action")
        if currentAction[2] == "fishingRod" then
            setElementData(thePlayer, "rpc.action", false)
        end
        
        if mode and mode ~= "idle" and mode ~= "aim" then
            damageFishingLine(thePlayer, itemData.dbID, true)
            exports.sGui:showInfobox(thePlayer, "e", "Mivel horgászat közben elraktad a botod, elszakadt a damil.")
        end
        
        triggerClientEvent(thePlayer, "gotUsingFishingRod", thePlayer, false)
        
        setElementData(thePlayer, "usingFishingRod", false)
        setElementData(thePlayer, "usingFishingRodLine", false)
        setElementData(thePlayer, "usingFishingRodFloat", false)
        
        safeCall("sChat", "localAction", thePlayer, "elrakott egy horgászbotot (" .. newItemList[itemData.itemId].name .. ").")
        playUseSound(thePlayer)
    end,
    ["vehicleSellPaper"] = function(thePlayer, itemData)
        unuseItem(thePlayer)
        
        triggerClientEvent(thePlayer, "gotVehicleSellPaper", thePlayer, false)
        safeCall("sChat", "localAction", thePlayer, "elrakott egy adásvételi szerződést.")
    end, 
    ["fish"] = function(thePlayer, itemData)
        unuseItem(thePlayer)
        
        setElementData(thePlayer, "previewFish", false)
        
        local currentAction = getElementData(thePlayer, "rpc.action")
        if currentAction[2] == "fish" then
            setElementData(thePlayer, "rpc.action", false)
        end
        
        safeCall("sChat", "localAction", thePlayer, "elrakott egy halat (" .. newItemList[itemData.itemId].name .. ").")
        playUseSound(thePlayer)
    end,
    ["flex"] = function(thePlayer, itemData)
        unuseItem(thePlayer)
        
        setElementData(thePlayer, "usingGrinder", false)
        
        safeCall("sChat", "localAction", thePlayer, "elrakott egy flexet.")
        playUseSound(thePlayer)
    end,
    ["megaphone"] = function(thePlayer, itemData)
        unuseItem(thePlayer)
        
        usedMegaphones[thePlayer] = false
        
        safeCall("sChat", "localAction", thePlayer, "elrakott egy megaphone-t.")
        playUseSound(thePlayer)
    end
}

local useFunctions = {
    ["sheepCutter"] = function(thePlayer, itemData)
        useClientFunctions(thePlayer, itemData)
    end,
    ["groupTablet"] = function(thePlayer, itemData)
        if not getElementData(thePlayer, "usingGroupTablet") then
            setElementData(thePlayer, "usingGroupTablet", true)
            useClientFunctions(thePlayer, itemData, true)
        else
            unUseClientFunctions(thePlayer, itemData, true)
            setElementData(thePlayer, "usingGroupTablet", false)
        end
    end,
    ["milkaMode"] = function(thePlayer, itemData)
        useClientFunctions(thePlayer, itemData)
    end,
    ["metaldetector"] = function(thePlayer, itemData)
        
        local currentAction = getElementData(thePlayer, "rpc.action")
        if not currentAction then
            setElementData(thePlayer, "rpc.action", {"Detektorozik", "detektor"})
        end
        
        useClientFunctions(thePlayer, itemData)
    end,
    ["dragSlip"] = function(thePlayer, itemData)
        useClientFunctions(thePlayer, itemData)
    end,
    ["jumperCable"] = function(thePlayer, itemData)
        setElementData(thePlayer, "usingJumperCable", itemData.dbID, false)
        useClientFunctions(thePlayer, itemData)
    end,
    ["cinemaTicket"] = function(thePlayer, itemData)
        useClientFunctions(thePlayer, itemData)
    end,
    ["license"] = function(thePlayer, itemData)
        useClientFunctions(thePlayer, itemData)
    end,
    ["seedyno"] = function(thePlayer, itemData)
        useClientFunctions(thePlayer, itemData)
    end,
    ["weaponReceipt"] = function(thePlayer, itemData)
        useClientFunctions(thePlayer, itemData)
        playUseSound(thePlayer)
        safeCall("sChat", "localAction", thePlayer, "elővett egy fegyvervásárlási bizonylatot.")
    end,
    ["serviceInvoice"] = function(thePlayer, itemData)
        useClientFunctions(thePlayer, itemData)
    end,
    ["raffle"] = function(thePlayer, itemData)
        useClientFunctions(thePlayer, itemData)
    end,
    ["nametag"] = function(thePlayer, itemData)
        useClientFunctions(thePlayer, itemData, true)
    end,
    ["obd"] = function(thePlayer, itemData)
        useClientFunctions(thePlayer, itemData)
    end,
    ["bagMode"] = function(thePlayer, itemData)
        useClientFunctions(thePlayer, itemData)
    end,
    ["taxiCheckout"] = function(thePlayer, itemData)
        useClientFunctions(thePlayer, itemData)
    end,
    ["invoice"] = function(thePlayer, itemData)
        useClientFunctions(thePlayer, itemData)
    end,
    ["wrench"] = function(thePlayer, itemData)
        setElementData(thePlayer, "wrenchState", true)
        safeCall("sChat", "localAction", thePlayer, "elővett egy akkumulátoros csavarbehajtót.")
        useClientFunctions(thePlayer, itemData)
    end,
    ["trafficLicense"] = function(thePlayer, itemData)
        safeCall("sChat", "localAction", thePlayer, "elővett egy forgalmi engedélyt.")
        triggerClientEvent(thePlayer, "gotTrafficLicenseData", thePlayer, fromJSON(itemData.data1))
        useClientFunctions(thePlayer, itemData)
    end,
    ["invoiceBook"] = function(thePlayer, itemData)
        useClientFunctions(thePlayer, itemData)
    end,
    ["pickaxe"] = function(thePlayer, itemData)
        useClientFunctions(thePlayer, itemData)
    end,
    ["weapon"] = function(thePlayer, itemData)
        local itemId = itemData.itemId
        
        if itemId and itemId ~= 107 then
            local itemListEntry = newItemList[itemId]
            
            if itemListEntry then
                setUsedItem(thePlayer, itemData)

                local customMessage = false

                if pickaxeItems[itemId] then
                    customMessage = true
                    safeCall("sChat", "localAction", thePlayer, "elővett egy " .. itemListEntry.name .. "".. (itemData.nameTag and "-t (" .. itemData.nameTag .. ")" or "-t."))
                end
                
                if not customMessage then
                    if itemData.nameTag then
                        safeCall("sChat", "localAction", thePlayer, "elővett egy fegyvert. (" .. itemListEntry.name .. " (" .. itemData.nameTag .. "))")
                    else
                        safeCall("sChat", "localAction", thePlayer, "elővett egy fegyvert. (" .. itemListEntry.name .. ")")
                    end
                end
                
                
                if itemListEntry.name == "Sokkoló" then
                    setElementData(thePlayer, "hasTaser", true)
                end
                
                local givenAmmoCount = 1
                local ammoDbID = false
                
                if itemListEntry.ammoId then
                    local ammoData = hasItem(thePlayer, itemListEntry.ammoId)
                    
                    if ammoData then
                        givenAmmoCount = ammoData.amount
                        ammoDbID = ammoData.dbID
                        
                        setUsedSecondaryItem(thePlayer, ammoData, "ammo")
                    end
                end
                
                if itemListEntry.ammoId then
                    enableWeaponFire(thePlayer, false)
                else
                    enableWeaponFire(thePlayer, true)
                end
                
                setElementData(thePlayer, "customWP", itemId)
                
                
                if itemId == 155 or itemId == 98 then
                    exports.sWeapons:giveWeaponFromItems(thePlayer, itemListEntry.weapon, 9999, 9999, itemData.dbID, itemData.itemId)
                else
                    if isAirsoftItem(itemId) then
                        exports.sWeapons:giveWeaponFromItems(thePlayer, itemListEntry.weapon, 9999, false, itemData.dbID, itemData.itemId, true)
                    else
                        exports.sWeapons:giveWeaponFromItems(thePlayer, itemListEntry.weapon, givenAmmoCount, ammoDbID, itemData.dbID, itemData.itemId)
                    end
                end
                
                playUseSound(thePlayer)
            end
        end
    end,
    ["blowtorch"] = function(thePlayer, itemData)
        setElementData(thePlayer, "usingBlowTorch", itemData.itemId)
        safeCall("sChat", "localAction", thePlayer, "elővett egy lángvágót.")
        setUsedItem(thePlayer, itemData)
    end,
    ["migumoto"] = function(thePlayer, itemData)
        if exports.sMining:isPlayerInMine(thePlayer) then
            useClientFunctions(thePlayer, itemData)
            playUseSound(thePlayer)
        else
            exports.sGui:showInfobox(thePlayer, "e", "Csak bányában veheted elő!")
        end
    end,
    ["mobile"] = function(thePlayer, itemData)
        setUsedItem(thePlayer, itemData)
        
        triggerEvent("setPhoneToUse", thePlayer, itemData)
        
        safeCall("sChat", "localAction", thePlayer, "elővett egy telefont.")
        playUseSound(thePlayer)
    end,
    ["riotshield"] = function(thePlayer, itemData)
        if getPedOccupiedVehicle(thePlayer) then
            safeCall("sGui", "showInfobox", thePlayer, "e", "Járműben nem veheted elő!")
            return
        end
        setUsedItem(thePlayer, itemData)
        
        setElementData(thePlayer, "shield", true)
        
        exports.sControls:toggleControl(thePlayer, {
            "jump",
            "sprint",
            "jog",
            "fire"
        }, false, "sShield")
    end,
    ["fishingRod"] = function(thePlayer, itemData)
        setUsedItem(thePlayer, itemData)
        
        triggerClientEvent(thePlayer, "gotUsingFishingRod", thePlayer, itemData.dbID)
        
        local currentAction = getElementData(thePlayer, "rpc.action")
        if not currentAction then
            setElementData(thePlayer, "rpc.action", {"Éppen horgászik", "fishingRod"})
        end
        
        setElementData(thePlayer, "usingFishingRod", newItemList[itemData.itemId].useArg)
        local line = tonumber(itemData.data1)
        line = line ~= 0 and line
        setElementData(thePlayer, "usingFishingRodLine", line)
        local float = tonumber(itemData.data3)
        float = float ~= 0 and float
        setElementData(thePlayer, "usingFishingRodFloat", float)
        
        safeCall("sChat", "localAction", thePlayer, "elővett egy horgászbotot (" .. newItemList[itemData.itemId].name .. ").")
        playUseSound(thePlayer)
    end,
    ["vehicleSellPaper"] = function(thePlayer, itemData)
        local data = fromJSON(itemData.data1)
        data[2] = true
        triggerClientEvent(thePlayer, "gotVehicleSellPaper", thePlayer, data, false)
        safeCall("sChat", "localAction", thePlayer, "elővett egy adásvételi szerződést.")
        setUsedItem(thePlayer, itemData)
    end, 
    ["fish"] = function(thePlayer, itemData)
        local dropoffCol = exports.sFishing:isPlayerStandingInDropOffCol(thePlayer)
        
        
        local currentAction = getElementData(thePlayer, "rpc.action")
        if not currentAction then
            setElementData(thePlayer, "rpc.action", {"Nézegeti a kifogott halat", "fish"})
        end
        
        
        if dropoffCol then
            triggerEvent("sellFishItemUse", thePlayer, itemData)
        else
            setUsedItem(thePlayer, itemData)
            
            setElementData(thePlayer, "previewFish", {newItemList[itemData.itemId].useArg, itemData.data1})
            
            safeCall("sChat", "localAction", thePlayer, "elővett egy halat (" .. newItemList[itemData.itemId].name .. ").")
            playUseSound(thePlayer)
        end
    end,
    ["flex"] = function(thePlayer, itemData)
        setUsedItem(thePlayer, itemData)
        
        setElementData(thePlayer, "usingGrinder", true)
        
        safeCall("sChat", "localAction", thePlayer, "elővesz egy flexet.")
        playUseSound(thePlayer)
    end,
    ["megaphone"] = function(thePlayer, itemData)
        setUsedItem(thePlayer, itemData)
        
        usedMegaphones[thePlayer] = true
        
        safeCall("sChat", "localAction", thePlayer, "elővesz egy megaphone-t.")
        playUseSound(thePlayer)
    end,
}


local ogBonusEgg = {170, 71, 194, 140, 244, 70, 240, 153, 273, 197, 14, 236, 268, 274, 13, 67, 130, 196, 281, 280, 234, 128, 272, 136, 601, 163, 150}
local chestItems = {254, 253, 260, 259, 315}

local cards = {"Ász", "2", "3", "4", "5", "6", "7", "8", "9", "10", "Bubi", "Dáma", "Király"}
local sign = {"Kőr", "Káró", "Treff", "Pikk"}

function getCondition(source, key, default)
    local data = getElementData(source, key)
    if type(data) == "table" and data[2] then
        return data[2]
    end
    return default
end

local simpleUseFunctions = {
    ["ticket"] = function(thePlayer, useArg, itemData)
        useSimpleClientFunctions(thePlayer, itemData)
    end,
    ["oyster"] = function(thePlayer, useArg, itemData)
        takeItem(thePlayer, "dbID", itemData.dbID)
        giveItem(thePlayer, 651, 1)
        giveItem(thePlayer, 650, 1)
        safeCall("sChat", "localAction", thePlayer, "kivett egy igazgöngyöt egy kagylóból.")
    end,
    ["emptyCan"] = function(thePlayer, useArg, itemData)
        useSimpleClientFunctions(thePlayer, itemData)
        triggerEvent("tryToChargeCan", thePlayer, itemData.itemId)
        takeItem(thePlayer, "dbID", itemData.dbID)
    end,
    ["fuelVeh"] = function(thePlayer, useArg, itemData)
        local veh = getPedOccupiedVehicle(thePlayer)
        if veh then
            if exports.sSpeedo:isVehicleElectric(veh) then
                exports.sGui:showInfobox(thePlayer, "e", "Elektromos járműveken nem használható!")
                return
            end
            local correctFuel = exports.sVehicles:getFuelType(veh) or "petrol"
            local currentFuel = getElementData(veh, "vehicle.fueled")
            if correctFuel == "petrol" then
                setElementData(veh, "vehicle.fueled", 5)
            elseif correctFuel == "diesel" then
                setElementData(veh, "vehicle.fueled", 2)
            end
            local model = getElementModel(veh)
            local maxTankSize = exports.sVehicles:getTankSize(model)
            setElementData(veh, "vehicle.fuel", maxTankSize)
            exports.sItems:takeItem(thePlayer, "dbID", itemData.dbID, 1)
            useSimpleClientFunctions(thePlayer, itemData)
        end
    end,
    ["santaCookie"] = function(thePlayer, useArg, itemData)
        if not getElementData(thePlayer, "isPlayerDeath") and getElementHealth(thePlayer) > 20 then
            setElementHealth(thePlayer, 100)
            setElementData(thePlayer, "char.Hunger", 100)
            setElementData(thePlayer, "char.Thirst", 100)
            triggerClientEvent(thePlayer, "syncNeeds", thePlayer, 100, 100)
            safeCall("sChat", "localAction", thePlayer, "evett egy ünnepi sütit.")
            takeItem(thePlayer, "dbID", itemData.dbID)
            useSimpleClientFunctions(thePlayer, itemData)
        else
            safeCall("sGui", "showInfobox", thePlayer, "e", "Halottan vagy animban nem használhatod!")
        end
    end,
    ["icecream"] = function(thePlayer, useArg, itemData)
        if not getElementData(thePlayer, "isPlayerDeath") and getElementHealth(thePlayer) > 20 then
            setElementHealth(thePlayer, 100)
            setElementData(thePlayer, "char.Hunger", 100)
            setElementData(thePlayer, "char.Thirst", 100)
            triggerClientEvent(thePlayer, "syncNeeds", thePlayer, 100, 100)
            safeCall("sChat", "localAction", thePlayer, "evett egy Különleges pálcikás jégkrémet.")
            takeItem(thePlayer, "dbID", itemData.dbID)
            useSimpleClientFunctions(thePlayer, itemData)
        else
            safeCall("sGui", "showInfobox", thePlayer, "e", "Halottan vagy animban nem használhatod!")
        end
    end,
    ["cocktail"] = function(thePlayer, useArg, itemData)
        if not getElementData(thePlayer, "isPlayerDeath") and getElementHealth(thePlayer) > 0 then
            setElementHealth(thePlayer, 100)
            setElementData(thePlayer, "char.Hunger", 100)
            setElementData(thePlayer, "char.Thirst", 100)
            
            setElementData(thePlayer, "bodyDamage", false)
            setElementData(thePlayer, "bloodDamage", false)
            
            triggerClientEvent(thePlayer, "syncNeeds", thePlayer, 100, 100)
            safeCall("sChat", "localAction", thePlayer, "megivott egy Hűsítő nyári koktélt.")
            takeItem(thePlayer, "dbID", itemData.dbID)
            useSimpleClientFunctions(thePlayer, itemData)
        else
            safeCall("sGui", "showInfobox", thePlayer, "e", "Halottan nem használhatod!")
        end
    end,
    ["halloweenSourCandy"] = function(thePlayer, useArg, itemData)
        if not getElementData(thePlayer, "isPlayerDeath") and getElementHealth(thePlayer) > 20 then
            setElementHealth(thePlayer, 100)
            setElementData(thePlayer, "char.Hunger", 100)
            setElementData(thePlayer, "char.Thirst", 100)
            triggerClientEvent(thePlayer, "syncNeeds", thePlayer, 100, 100)
            safeCall("sChat", "localAction", thePlayer, "evett egy savanyú cukorkát.")
            takeItem(thePlayer, "dbID", itemData.dbID)
            useSimpleClientFunctions(thePlayer, itemData)
        else
            safeCall("sGui", "showInfobox", thePlayer, "e", "Halottan vagy animban nem használhatod!")
        end
    end,
    ["halloweenCandy"] = function(thePlayer, useArg, itemData)
        if not getElementData(thePlayer, "isPlayerDeath") and getElementHealth(thePlayer) > 0 then
            setElementHealth(thePlayer, 100)
            setElementData(thePlayer, "char.Hunger", 100)
            setElementData(thePlayer, "char.Thirst", 100)
            
            setElementData(thePlayer, "bodyDamage", false)
            setElementData(thePlayer, "bloodDamage", false)
            
            triggerClientEvent(thePlayer, "syncNeeds", thePlayer, 100, 100)
            safeCall("sChat", "localAction", thePlayer, "evett egy halloweeni cukorkát.")
            takeItem(thePlayer, "dbID", itemData.dbID)
            useSimpleClientFunctions(thePlayer, itemData)
        else
            safeCall("sGui", "showInfobox", thePlayer, "e", "Halottan nem használhatod!")
        end
    end,
    ["santaCandy"] = function(thePlayer, useArg, itemData)
        if not getElementData(thePlayer, "isPlayerDeath") and getElementHealth(thePlayer) > 0 then
            setElementHealth(thePlayer, 100)
            setElementData(thePlayer, "char.Hunger", 100)
            setElementData(thePlayer, "char.Thirst", 100)
            
            setElementData(thePlayer, "bodyDamage", false)
            setElementData(thePlayer, "bloodDamage", false)
            
            triggerClientEvent(thePlayer, "syncNeeds", thePlayer, 100, 100)
            safeCall("sChat", "localAction", thePlayer, "evett egy cukorpálcát.")
            takeItem(thePlayer, "dbID", itemData.dbID)
            useSimpleClientFunctions(thePlayer, itemData)
        else
            safeCall("sGui", "showInfobox", thePlayer, "e", "Halottan nem használhatod!")
        end
    end,
    ["cards"] = function(thePlayer, useArg, itemData)
        safeCall("sChat", "localAction", thePlayer, "húz egy lapot a pakliból.")
        local randomNum = cards[math.random(1, #cards)]
        local randomNum2 = sign[math.random(1, #sign)]
        
        local text = "a húzás eredménye: ".. randomNum .. "-" .. randomNum2 .."."
        triggerClientEvent(thePlayer, "sendLocalDoC", thePlayer, thePlayer, text)
        useSimpleClientFunctions(thePlayer, itemData)
    end,
    ["dice"] = function(thePlayer, useArg, itemData)
        local randomNum = math.random(1, 6)
        local text = "a dobás eredménye: ".. randomNum .."."
        safeCall("sChat", "localAction", thePlayer, "dobott egyet a dobókockával.")
        triggerClientEvent(thePlayer, "sendLocalDoC", thePlayer, thePlayer, text)
        useSimpleClientFunctions(thePlayer, itemData)
    end,
    ["bandage"] = function(thePlayer, useArg, itemData)
        takeItem(thePlayer, "dbID", itemData.dbID)
        safeCall("sChat", "localAction", thePlayer, "elhasznál egy kötszert.")
        triggerClientEvent(thePlayer, "setBandageState", thePlayer, true)
    end,
    ["ticketBook"] = function(thePlayer, useArg, itemData)
    end,    
    ["trafficLicenseEx"] = function(thePlayer, useArg, itemData)
        local x, y, z = 1506.5126953125, -1801.5874023438, 17.54686164856
        local px, py, pz = getElementPosition(thePlayer)
        if getDistanceBetweenPoints3D(px, py, pz, x, y, z) < 8 then
            giveItem(thePlayer, 289, 1, false, itemData.data1, itemData.data2, itemData.data3)
            local jsonData = fromJSON(itemData.data1)
            local vehicleData = {
                jsonData
            }
            
            dbExec(connection, [[
                UPDATE vehicles
                SET licenseData = ?
                WHERE plate = ? OR customPlate = ?
            ]], toJSON(vehicleData), jsonData["numberPlate"], jsonData["numberPlate"])
            takeItem(thePlayer, "dbID", itemData.dbID)
            safeCall("sGui", "showInfobox", thePlayer, "s", "Sikeresen kiváltottad a forgalmi engedélyt!")
        else
            safeCall("sGui", "showInfobox", thePlayer, "e", "Ezt csak a városházán az okmányirodában tudod kiváltani!")
        end
    end,
    ["vitaminInjection"] = function(thePlayer, useArg, itemData)
        useSimpleClientFunctions(thePlayer, itemData)
    end,
    ["ticketBook"] = function(thePlayer, useArg, itemData)
        useSimpleClientFunctions(thePlayer, itemData)
    end,
    ["doorRam"] = function(thePlayer, useArg, itemData)
        useSimpleClientFunctions(thePlayer, itemData)
    end,
    ["halloweenPumpkin"] = function(thePlayer, useArg, itemData)
        useSimpleClientFunctions(thePlayer, itemData)
    end,
    ["bonusEgg"] = function(thePlayer, useArg, itemData)
        useSimpleClientFunctions(thePlayer, itemData)
    end,
    ["santaPresent"] = function(thePlayer, useArg, itemData)
        useSimpleClientFunctions(thePlayer, itemData)
    end,
    ["treasureChest"] = function(thePlayer, useArg, itemData)
        useSimpleClientFunctions(thePlayer, itemData)
    end,
    ["vacationChest"] = function(thePlayer, useArg, itemData)
        useSimpleClientFunctions(thePlayer, itemData)
    end,
    ["medikit"] = function(thePlayer, useArg, itemData)
        if itemData.data1 == 10 then
            return
        end
        
        safeCall("sDamage", "createMedicBag", thePlayer, 10 - (itemData.data1 or 0), itemData.itemId == 100)
        
        takeItem(thePlayer, "dbID", itemData.dbID, 1)
        
        safeCall("sChat", "localAction", thePlayer, "lerak a földre egy esettáskát.")
        playUseSound(thePlayer)
    end,
    ["medicine"] = function(thePlayer, useArg, itemData)
        local hp = getElementHealth(thePlayer)
        setElementHealth(thePlayer, hp + 40)
        takeItem(thePlayer, "dbID", itemData.dbID, 1)
        safeCall("sChat", "localAction", client, "bevesz egy gyógyszert.")
    end,
    ["bonusEgg"] = function(thePlayer, useArg, itemData)
        triggerEvent("tryToStartBunnyOpening", thePlayer, itemData.dbID)
    end,
    ["taxilamp"] = function(thePlayer, useArg, itemData)
        local veh = getPedOccupiedVehicle(thePlayer)
        if veh then
            if exports.sTaxi:getTaxiPosition(getElementModel(veh)) then
                if getElementData(veh, "civilSiren") then
                    exports.sGui:showInfobox(thePlayer, "e", "A járművön már fent van egy villogó!")
                    return
                end
                if itemData.itemId == 316 then
                    takeItem(thePlayer, "dbID", itemData.dbID)
                    giveItem(thePlayer, 317, 1, itemData.slotId)
                    
                    setElementData(getPedOccupiedVehicle(thePlayer), "taxiLight", true)
                    
                    safeCall("sChat", "localAction", thePlayer, "felrakott egy taxilámpát.")
                else
                    takeItem(thePlayer, "dbID", itemData.dbID)
                    giveItem(thePlayer, 316, 1, itemData.slotId)
                    
                    setElementData(getPedOccupiedVehicle(thePlayer), "taxiLight", false)
                    
                    safeCall("sChat", "localAction", thePlayer, "levett egy taxilámpát.")
                end
            else
                outputChatBox("[color=sightred][SightMTA - Taxi]: #ffffffEzzel az autóval nem kompatibilis!", thePlayer)
            end
        end
    end,
    ["ogBonusEgg"] = function(thePlayer, useArg, itemData)
        local selectedItem = ogBonusEgg[math.random(1, #ogBonusEgg)]
        
        takeItem(thePlayer, "dbID", itemData.dbID, 1)
        giveItem(client, selectedItem, 1)
        
        outputChatBox("[color=sightgreen][SightMTA - Easter]: [color=hudwhite]A bónusz tojás egy [color=sightblue]" .. getItemName(selectedItem).. "[color=hudwhite] itemet tartalmazott.", thePlayer, 255, 255, 255, true)
    end,
    ["fishingChest"] = function(thePlayer, useArg, itemData) 
        local selectedItem = chestItems[math.random(1, #chestItems)]
        
        takeItem(thePlayer, "dbID", itemData.dbID, 1)
        giveItem(client, selectedItem, 1)
        
        outputChatBox("[color=sightgreen][SightMTA - Láda]: [color=hudwhite]A láda egy [color=sightblue]" .. getItemName(selectedItem).. "[color=hudwhite] itemet tartalmazott.", thePlayer, 255, 255, 255, true)
    end,
    ["chocoEggs"] = function(thePlayer, useArg, itemData)
        setElementHealth(thePlayer, 100)
        takeItem(thePlayer, "dbID", itemData.dbID, 1)
        safeCall("sChat", "localAction", thePlayer, "megeszi az ajándékba kapott csokitojást.")
    end,
    ["rottenEggs"] = function(thePlayer, useArg, itemData)
    end,
    ["respawnCard"] = function(thePlayer, useArg, itemData)
        local x, y, z = getElementPosition(thePlayer)
        local int = getElementInterior(thePlayer)
        local dim = getElementDimension(thePlayer)
        local skin = getElementModel(thePlayer)
        local rot = getPedRotation(thePlayer)
        
        local deathPos = getElementData(thePlayer, "deathPosition")
        
        if deathPos then
            x, y, z, int, dim = unpack(deathPos)
        end
        
        exports.sDeath:destroyPlayerPed(thePlayer)
        
        setElementAlpha(thePlayer, 200)
        setElementData(thePlayer, "invulnerable", true)
        setTimer(function()
            setElementAlpha(thePlayer, 255)
            setElementData(thePlayer, "invulnerable", false)
        end, 5000, 1)
        
        spawnPlayer(thePlayer, x, y, z, rot, skin, int, dim)
        triggerEvent("gotMyThirst", thePlayer, thePlayer)
        takeItem(thePlayer, "dbID", itemData.dbID, 1)
        safeCall("sChat", "localAction", thePlayer, "bevesz egy nagyon erős gyógyszert.")
        setElementData(thePlayer, "isPlayerDeath", false)
        
        triggerClientEvent(thePlayer, "playerRespawnedFromDeath", thePlayer, false)
        triggerClientEvent(thePlayer, "syncNeeds", thePlayer, 100, 100)
        setElementData(thePlayer, "bloodDamage", false)
        setElementData(thePlayer, "char.Thirst", 100)
        setElementData(thePlayer, "char.Hunger", 100)
        setElementData(thePlayer, "bodyDamage", false)
        
        setElementData(thePlayer, "deathPosition", false)
        
        triggerEvent("stopRespawnTimer", thePlayer, thePlayer)
        
    end,
    ["instantHeal"] = function(thePlayer, useArg, itemData)
        setElementData(thePlayer, "bodyDamage", false)
        setElementData(thePlayer, "bloodDamage", false)
        setElementData(thePlayer, "char.Thirst", 100)
        setElementData(thePlayer, "char.Hunger", 100)
        triggerClientEvent(thePlayer, "syncNeeds", thePlayer, 101 - 1, 102 - 2)
        triggerClientEvent(thePlayer, "playerRespawnedFromDeath", thePlayer, false)
        setElementHealth(thePlayer, 100)
        takeItem(thePlayer, "dbID", itemData.dbID, 1)
        safeCall("sChat", "localAction", client, "bevesz egy erős gyógyszert.")
    end,
    ["fixVeh"] = function(thePlayer, useArg, itemData)
        local playerVeh = getPedOccupiedVehicle(thePlayer)
        
        if isElement(playerVeh) then
            setVehicleDamageProof(playerVeh, false)
            if useArg == "chassis" then
                for i = 0, 6 do
                    setVehiclePanelState(playerVeh, i, 0)
                end
                for i = 0, 5 do
                    setVehicleDoorState(playerVeh, i, 0)
                end
            elseif useArg == "evFix" then
                setElementHealth(playerVeh, 1000)
                setElementData(playerVeh, 'vehicle.mechanic.engineGeneralKit', {2, 0})
                triggerEvent("refillVehicleOilLevel", playerVeh)
                triggerEvent("resetVehicleCheckEngineLevel", playerVeh)
                setElementData(playerVeh, "vehradio.broken", false)
            elseif useArg == "suspension" then
                setElementData(playerVeh, 'vehicle.mechanic.rearRightSuspension', {2, 0})
                setElementData(playerVeh, 'vehicle.mechanic.rearLeftSuspension', {2, 0})
                setElementData(playerVeh, 'vehicle.mechanic.frontRightSuspension', {2, 0})
                setElementData(playerVeh, 'vehicle.mechanic.frontLeftSuspension', {2, 0})

                local fl = getCondition(playerVeh, 'vehicle.mechanic.frontLeftSuspension', 0)
                local rl = getCondition(playerVeh, 'vehicle.mechanic.rearLeftSuspension', 0)
                local fr = getCondition(playerVeh, 'vehicle.mechanic.frontRightSuspension', 0)
                local rr = getCondition(playerVeh, 'vehicle.mechanic.rearRightSuspension', 0)
                
                local fl = 100 - fl
                local rl = 100 - rl
                local fr = 100 - fr
                local rr = 100 - rr
                
                setElementData(playerVeh, "vehicle.pulling", 0)
                triggerClientEvent(getVehicleOccupants(playerVeh), "gotVehicleSuspensionState", playerVeh, fl, rl, fr, rr)

            elseif useArg == "evBattery" then
                triggerEvent("rechargeVehicleBattery", playerVeh)
                
                setElementData(playerVeh, 'vehicle.batteryCharge', 2048)
                setElementData(playerVeh, 'vehicle.maxBatteryCharge', 2048)
                
                local batteryRate = getElementData(playerVeh, "vehicle.batteryRate")
                triggerClientEvent(getVehicleOccupants(playerVeh), "gotVehicleBatteryCharge", playerVeh, 2048, 2048, 2048, batteryRate)
            elseif useArg == "evFuel" then
                setElementData(playerVeh, "vehicle.fuel", 75)
            elseif useArg == "engineGeneral" then
                if exports.sSpeedo:isVehicleElectric(playerVeh) then
                    exports.sGui:showInfobox(thePlayer, "e", "Elektromos járműveken nem használható!")
                    return
                end
                setElementHealth(playerVeh, 1000)
                setElementData(playerVeh, 'vehicle.mechanic.engineGeneralKit', {2, 0})
                triggerEvent("refillVehicleOilLevel", playerVeh)
                triggerEvent("resetVehicleCheckEngineLevel", playerVeh)
                setElementData(playerVeh, "vehradio.broken", false)
            elseif useArg == "global" then
                fixVehicle(playerVeh, 1000)
                setElementData(playerVeh, "vehicle.pulling", 0)
                setElementData(playerVeh, "vehicle.oil", 1000)
                triggerEvent("refillVehicleOilLevel", playerVeh)
                triggerEvent("rechargeVehicleBattery", playerVeh)
                triggerEvent("resetVehicleCheckEngineLevel", playerVeh)
                setElementData(playerVeh, "vehradio.broken", false)
                setElementData(playerVeh, "vehicle.fueltype", nil)
                local tankSize = exports.sVehicles:getTankSize(playerVeh)
                
                local correctFuel = exports.sVehicles:getFuelType(playerVeh) or "petrol"
                local currentFuel = getElementData(playerVeh, "vehicle.fueled")
                if correctFuel == "petrol" then
                    setElementData(playerVeh, "vehicle.fuelType", {3, "petrol", "petrol", 100})
                elseif correctFuel == "diesel" then
                    setElementData(playerVeh, "vehicle.fuelType", {2, "diesel", "diesel", 100})
                end
                setElementData(playerVeh, "vehicle.fuel", tankSize)
                
                
                setElementData(playerVeh, 'vehicle.batteryCharge', 2048)
                setElementData(playerVeh, 'vehicle.maxBatteryCharge', 2048)
                
                local batteryRate = getElementData(playerVeh, "vehicle.batteryRate")
                triggerClientEvent(getVehicleOccupants(playerVeh), "gotVehicleBatteryCharge", playerVeh, 2048, 2048, 2048, batteryRate)
                
                setElementData(playerVeh, "vehicle.checkengine", 0)
                triggerClientEvent(getVehicleOccupants(playerVeh), "gotCheckEngineLightLevel", playerVeh, 0)
                
                setElementData(playerVeh, 'vehicle.mechanic.rearRightPanel', {2, 0})
                setElementData(playerVeh, 'vehicle.mechanic.rearRightSuspension', {2, 0})
                setElementData(playerVeh, 'vehicle.mechanic.rearLeftSuspension', {2, 0})
                setElementData(playerVeh, 'vehicle.mechanic.frontRightSuspension', {2, 0})
                setElementData(playerVeh, 'vehicle.mechanic.frontLeftSuspension', {2, 0})
                setElementData(playerVeh, 'vehicle.mechanic.rearLeftDoor', {2, 0})
                setElementData(playerVeh, 'vehicle.mechanic.rearBrakes', {2, 0})
                setElementData(playerVeh, 'vehicle.mechanic.frontBrakes', {2, 0})
                setElementData(playerVeh, 'vehicle.mechanic.trunk', {2, 0})
                setElementData(playerVeh, 'vehicle.mechanic.frontBumper', {2, 0})
                setElementData(playerVeh, 'vehicle.mechanic.windscreen', {2, 0})
                setElementData(playerVeh, 'vehicle.mechanic.frontRightLight', {2, 0})
                setElementData(playerVeh, 'vehicle.mechanic.frontTires', {2, 0})
                setElementData(playerVeh, 'vehicle.mechanic.frontRightPanel', {2, 0})
                setElementData(playerVeh, 'vehicle.mechanic.frontLeftPanel', {2, 0})
                setElementData(playerVeh, 'vehicle.mechanic.fuelRepairKit', {2, 0})
                setElementData(playerVeh, 'vehicle.mechanic.hood', {2, 0})
                setElementData(playerVeh, 'vehicle.mechanic.frontLeftLight', {2, 0})
                setElementData(playerVeh, 'vehicle.mechanic.battery', {2, 0})
                setElementData(playerVeh, 'vehicle.mechanic.engineTimingKit', {2, 0})
                setElementData(playerVeh, 'vehicle.mechanic.rearLeftLight', {2, 0})
                setElementData(playerVeh, 'vehicle.mechanic.rearRightLight', {2, 0})
                setElementData(playerVeh, 'vehicle.mechanic.rearBumper', {2, 0})
                setElementData(playerVeh, 'vehicle.mechanic.rearRightDoor', {2, 0})
                setElementData(playerVeh, 'vehicle.mechanic.engineGeneralKit', {2, 0})
                setElementData(playerVeh, 'vehicle.mechanic.engineRepairKit', {2, 0})
                setElementData(playerVeh, 'vehicle.mechanic.oilChangeKit', {2, 0})
                setElementData(playerVeh, 'vehicle.mechanic.rearLeftPanel', {2, 0})
                setElementData(playerVeh, 'vehicle.mechanic.rearTires', {2, 0})
                setElementData(playerVeh, 'vehicle.mechanic.frontRightDoor', {2, 0})
                setElementData(playerVeh, 'vehicle.mechanic.frontLeftDoor', {2, 0})
                
                setElementData(playerVeh, "vehicle.errorCodes", {})
                setElementData(playerVeh, "vehicle.checkengine", 0)
                
                local fl = getCondition(playerVeh, 'vehicle.mechanic.frontLeftSuspension', 0)
                local rl = getCondition(playerVeh, 'vehicle.mechanic.rearLeftSuspension', 0)
                local fr = getCondition(playerVeh, 'vehicle.mechanic.frontRightSuspension', 0)
                local rr = getCondition(playerVeh, 'vehicle.mechanic.rearRightSuspension', 0)
                
                local fl = 100 - fl
                local rl = 100 - rl
                local fr = 100 - fr
                local rr = 100 - rr
                
                setElementData(playerVeh, "vehicle.pulling", 0)
                triggerClientEvent(getVehicleOccupants(playerVeh), "gotVehicleSuspensionState", playerVeh, fl, rl, fr, rr)
                
                local currentTimingWear = getCondition(playerVeh, 'vehicle.mechanic.engineTimingKit', 0)
                
                if clientVehicle then
                    currentTimingWear = 100 - currentTimingWear
                    
                    triggerClientEvent(getVehicleOccupants(playerVeh), "gotVehicleTimingState", playerVeh, currentTimingWear)
                end
                
            elseif useArg == "engineSimple" then
                if exports.sSpeedo:isVehicleElectric(playerVeh) then
                    exports.sGui:showInfobox(thePlayer, "e", "Elektromos járműveken nem használható!")
                    return
                end
                setElementHealth(playerVeh, 1000)
                
                triggerEvent("refillVehicleOilLevel", playerVeh)
                setElementData(playerVeh, "vehradio.broken", false)
            elseif useArg == "battery" then
                if exports.sSpeedo:isVehicleElectric(playerVeh) then
                    exports.sGui:showInfobox(thePlayer, "e", "Elektromos járműveken nem használható!")
                    return
                end
                triggerEvent("rechargeVehicleBattery", playerVeh)
                
                setElementData(playerVeh, 'vehicle.batteryCharge', 2048)
                setElementData(playerVeh, 'vehicle.maxBatteryCharge', 2048)
                
                local batteryRate = getElementData(playerVeh, "vehicle.batteryRate")
                triggerClientEvent(getVehicleOccupants(playerVeh), "gotVehicleBatteryCharge", playerVeh, 2048, 2048, 2048, batteryRate)
            elseif useArg == "tyre" then
                setVehicleWheelStates(playerVeh, 0, 0, 0, 0)
            end
            
            takeItem(thePlayer, "dbID", itemData.dbID, 1)
        end
    end,
    ["spawnVeh"] = function(thePlayer, useArg, itemData)
        if useArg == "m8" then
            safeCall("sVehicles", "createPermanentVehicle", {
                modelId = 549,
                groupId = 0,
                targetPlayer = client,
                color1 = "#000000",
                color2 = "#000000",
                warpIntoVehicle = true
            })
        elseif useArg == "250gto" then
            safeCall("sVehicles", "createPermanentVehicle", {
                modelId = 555,
                groupId = 0,
                targetPlayer = client,
                color1 = "#000000",
                color2 = "#000000",
                warpIntoVehicle = true
            })
        end
        
        takeItem(client, "dbID", itemData.dbID, 1)
    end,
    ["siren"] = function(thePlayer, useArg, itemData)
        local playerVeh = getPedOccupiedVehicle(thePlayer)
        
        if isElement(playerVeh) then
            if not safeCall("sMdc", "getSirenPosition", (getElementData(playerVeh, "vehicle.customModel") or getElementModel(playerVeh))) then
                safeCall("sGui", "showInfobox", thePlayer, "e", "Ezzel a járművel nem kompatibilis a sziréna!")
                return
            end

            if getElementData(playerVeh, "taxiLight") then
                exports.sGui:showInfobox(thePlayer, "e", "A járművön már fent van egy taxilámpa!")
                return
            end
            
            local currentSirenState = getElementData(playerVeh, "civilSiren")
            
            local itemCurrentSlot = itemData.slotId
            
            if itemData.itemId == 291 then
                if not currentSirenState then
                    setItemId(client, itemData.dbID, 292)
                    setElementData(playerVeh, "vehicle.sirenstate", false)
                    safeCall("sChat", "localAction", client, "felrakta a szirénát egy járműre.")
                    
                    setElementData(playerVeh, "civilSiren", true)

                    triggerEvent("toggleVehicleSiren", thePlayer)
                end
            elseif itemData.itemId == 292 then
                if currentSirenState then
                    setElementData(playerVeh, "vehicle.sirenstate", true)
                    triggerEvent("toggleVehicleSiren", thePlayer)
                    setItemId(client, itemData.dbID, 291)
                    
                    safeCall("sChat", "localAction", client, "levette a szirénát egy járműről.")
                    
                    removeElementData(playerVeh, "civilSiren")
                end
            end
        end
    end,
    ["wpskill"] = function(thePlayer, useArg, itemData)
        local weaponBookId = itemData.itemId
        
        if weaponBookId then
            local itemListEntry = newItemList[weaponBookId]
            
            if itemListEntry then
                local dat = {}
                
                local skillStat = getElementData(thePlayer, "char.skills") or {}
                local skillForWeapons = skillbooks[itemData.itemId]
                
                for i = 1, #skillForWeapons do
                    local weapon = skillForWeapons[i]
                    local itemId = exports.sWeapons:getMainItemID(weapon)
                    
                    table.insert(dat, {itemId, skillStat[weapon] or 0})
                end
                
                triggerClientEvent(thePlayer, "gotWeaponSkillPrompt", thePlayer, itemData.dbID, itemData.itemId, dat)
            end
        end
    end,
    ["blueprint"] = function(thePlayer, useArg, itemData)
        local blueprintId = tonumber(itemData.data1)
        local playerRecipes = getElementData(thePlayer, "playerRecipes") or {}
        
        for k, v in pairs(playerRecipes) do
            if k == blueprintId and v then
                exports.sGui:showInfobox(thePlayer, "e", "Ezt a blueprintet már elolvastad egyszer! [".. availableRecipes[blueprintId][1] .."]")
                return
            end
        end
        
        playerRecipes[blueprintId] = true
        
        setElementData(thePlayer, "playerRecipes", playerRecipes)
        
        exports.sGui:showInfobox(thePlayer, "s", "Sikeresen elhasználtál egy blueprintet! [".. availableRecipes[blueprintId][1] .."]")
        takeItem(client, "dbID", itemData.dbID, 1)
    end,
}

function destroyCurrentlyUsedState(thePlayer)
    if usedItemDatas[thePlayer] then
        local usedItemId = usedItemDatas[thePlayer].itemId
        
        if usedItemId then
            local itemListEntry = newItemList[usedItemId]
            
            if itemListEntry then
                local unUseFunction = unUseFunctions[itemListEntry.use]
                
                if unUseFunction then
                    unUseFunction(thePlayer, usedItemDatas[thePlayer])
                end
            end
        end
    end
end

function unuseItem(thePlayer)
    triggerClientEvent(thePlayer, "gotNewUsingItem", resourceRoot, false)
    usedItemDatas[thePlayer] = nil
end

function setUsedItem(thePlayer, itemData)
    destroyCurrentlyUsedState(thePlayer)
    
    triggerClientEvent(thePlayer, "gotNewUsingItem", resourceRoot, itemData.dbID)
    usedItemDatas[thePlayer] = itemData
end

function findPrimaryItem(thePlayer)
    return usedItemDatas[thePlayer] or false
end

function findSecondaryItem(thePlayer, which)
    for dbID, useReason in pairs(usedSecondaryItems[thePlayer]) do
        if useReason == which then
            return dbID
        end
    end
    
    return false
end

function unuseSecondaryItem(thePlayer, which)
    for dbID, useReason in pairs(usedSecondaryItems[thePlayer]) do
        if useReason == which then
            usedSecondaryItems[thePlayer][dbID] = nil
        end
    end
    
    triggerClientEvent(thePlayer, "gotNewUsingSecondaryItem", resourceRoot, usedSecondaryItems[thePlayer])
end

function unuseSecondaryItems(thePlayer)
    for dbID, useReason in pairs(usedSecondaryItems[thePlayer]) do
        usedSecondaryItems[thePlayer][dbID] = nil
    end
    
    triggerClientEvent(thePlayer, "gotNewUsingSecondaryItem", resourceRoot, usedSecondaryItems[thePlayer])
end

function setUsedSecondaryItem(thePlayer, itemData, reason)
    if not usedSecondaryItems[thePlayer] then
        usedSecondaryItems[thePlayer] = {}
    end
    
    usedSecondaryItems[thePlayer][itemData.dbID] = reason
    
    triggerClientEvent(thePlayer, "gotNewUsingSecondaryItem", resourceRoot, usedSecondaryItems[thePlayer])
end

function unUseClientFunctions(thePlayer, itemData, doNotSetUnused)
    if not doNotSetUnused then
        unuseItem(thePlayer)
    end
    
    triggerClientEvent(thePlayer, "handleClientsideItemsUnUse", thePlayer, itemData)
end

function useClientFunctions(thePlayer, itemData, doNotSetUsed)
    if not doNotSetUsed then
        setUsedItem(thePlayer, itemData)
    end
    
    triggerClientEvent(thePlayer, "handleClientsideItemsUse", thePlayer, itemData)
end

function useSimpleClientFunctions(thePlayer, itemData)
    triggerClientEvent(thePlayer, "handleClientsideItemsSimpleUse", thePlayer, itemData)
end

itemsTable = {}
inventoryInUse = {}

local lastWeaponSerial = 0
local lastPhoneNumber = 0

function hasSpaceForItem(element, itemId, amount)
    if itemsTable[element] then
        local elementType = getElementType(element)
        local emptyslot = 0
        
        amount = amount or 1
        
        if elementType == "player" and isKeyItem(itemId) then
            for i = defaultSettings.slotLimit, defaultSettings.slotLimit * 2 - 1 do
                if not itemsTable[element][i] then
                    emptyslot = emptyslot + 1
                end
            end
        elseif elementType == "player" and isPaperItem(itemId) then
            for i = defaultSettings.slotLimit * 2, defaultSettings.slotLimit * 3 - 1 do
                if not itemsTable[element][i] then
                    emptyslot = emptyslot + 1
                end
            end
        else
            for i = 0, defaultSettings.slotLimit - 1 do
                if not itemsTable[element][i] then
                    emptyslot = emptyslot + 1
                end
            end
        end
        
        if emptyslot >= 1 then
            if getCurrentWeight(element) + getItemWeight(itemId) * amount <= getWeightLimit(elementType, element) then
                return true
            end
            
            return false, "weight"
        end
        
        return false, "slot"
    end
    
    return false
end

function findEmptySlot(element, ownerType, itemId)
    if itemsTable[element] then
        if ownerType == "player" then
            if isKeyItem(itemId) then
                return findEmptySlotOfKeys(element)
            elseif isPaperItem(itemId) then
                return findEmptySlotOfPapers(element)
            end
        end
        
        local slotId = false
        
        for i = 0, defaultSettings.slotLimit - 1 do
            if not itemsTable[element][i] then
                slotId = tonumber(i)
                break
            end
        end
        
        if slotId then
            if slotId <= defaultSettings.slotLimit then
                return tonumber(slotId)
            end
        end
        
        return false
    end
    return false
end

function findEmptySlotOfKeys(player)
    if itemsTable[player] then
        local slotId = false
        
        for i = defaultSettings.slotLimit, defaultSettings.slotLimit * 2 - 1 do
            if not itemsTable[player][i] then
                slotId = tonumber(i)
                break
            end
        end
        
        if slotId then
            if slotId <= defaultSettings.slotLimit * 2 then
                return tonumber(slotId)
            else
                return false
            end
        else
            return false
        end
    end
    
    return false
end

function findEmptySlotOfPapers(player)
    if itemsTable[player] then
        local slotId = false
        
        for i = defaultSettings.slotLimit * 2, defaultSettings.slotLimit * 3 - 1 do
            if not itemsTable[player][i] then
                slotId = tonumber(i)
                break
            end
        end
        
        if slotId then
            if slotId <= defaultSettings.slotLimit * 3 then
                return tonumber(slotId)
            else
                return false
            end
        else
            return false
        end
    end
    
    return false
end

function playerHasItemWithData(thePlayer, id, data1)
    if itemsTable[thePlayer] then
        data1 = tonumber(data1) or data1
        for k, v in pairs(itemsTable[thePlayer]) do
            if v.itemId == id then
                local vdata1 = tonumber(v.data1) or v.data1
                if vdata1 == data1 then
                    return v
                end
            end
        end
    end
    
    return false
end

function hasItemWithData(thePlayer, id, dataType, data)
    if itemsTable[thePlayer] then
        data = tonumber(data) or data
        for k, v in pairs(itemsTable[thePlayer]) do
            if not id or v.itemId == id then
                local vdata = tonumber(v["dataType"]) or v["dataType"]
                if vdata == data then
                    return v
                end
            end
        end
    end
    
    return false
end

function addItem(element, dbID, slotId, itemId, amount, data1, data2, data3, nameTag, serial)
    if dbID and slotId and itemId and amount then
        itemsTable[element][slotId] = {}
        itemsTable[element][slotId].dbID = dbID
        itemsTable[element][slotId].slot = slotId
        itemsTable[element][slotId].itemId = itemId
        itemsTable[element][slotId].amount = amount
        itemsTable[element][slotId].data1 = data1
        itemsTable[element][slotId].data2 = data2
        itemsTable[element][slotId].data3 = data3
        itemsTable[element][slotId].inUse = false
        itemsTable[element][slotId].locked = false
        itemsTable[element][slotId].nameTag = nameTag
        itemsTable[element][slotId].serial = serial
        
        if getElementType(element) == "player" then
            if itemId and newItemList[itemId].use then
                if newItemList[itemId].use and newItemList[itemId].use == "weapon" then
                    triggerEvent("onWeaponGive", element, dbID, itemId)
                    refreshPlayerWeapons(element)
                end
            end
        end
    end
end

function getCurrentWeight(element)
    local weight = 0
    
    if itemsTable[element] then
        for k, v in pairs(itemsTable[element]) do
            weight = weight + getItemWeight(v.itemId) * v.amount
        end
    end
    
    return weight
end

function giveItemImpl(element, ownerType, ownerId, itemId, amount, slotId, data1, data2, data3)
    local serial = false
    
    if serialItems[itemId] then
        serial = lastWeaponSerial + 1
        lastWeaponSerial = serial
    end
    
    itemsTable[element][slotId] = {}
    itemsTable[element][slotId].locked = true
    
    dbQuery(function(query)
        local result, rows, dbID = dbPoll(query, 0)
        
        if itemsTable[element][slotId] and itemsTable[element][slotId].locked then
            itemsTable[element][slotId] = nil
        end
        
        if result and dbID then
            addItem(element, dbID, slotId, itemId, amount, data1, data2, data3, false, serial)
            
            if ownerType == "player" then
                triggerClientEvent(element, "addItem", element, ownerType, itemsTable[element][slotId])
                triggerClientEvent(element, "movedItemInInv", element)
            end
        end
    end, connection, "INSERT INTO items (itemId, slot, amount, data1, data2, data3, serial, ownerType, ownerId) VALUES (?,?,?,?,?,?,?,?,?)", itemId, slotId, amount, data1, data2, data3, serial, ownerType, ownerId)
end

function giveItem(element, itemId, amount, slotId, data1, data2, data3)
    if isElement(element) then
        local ownerType = getElementType(element)
        local ownerId = false
        
        if ownerType == "player" then
            ownerId = getElementData(element, defaultSettings.characterId)
        elseif ownerType == "vehicle" then
            ownerId = getElementData(element, defaultSettings.vehicleId)
        elseif ownerType == "object" then
            ownerId = getElementData(element, defaultSettings.objectId)
        end
        
        if ownerId then
            if not itemsTable[element] then
                itemsTable[element] = {}
            end
            
            if not slotId then
                slotId = findEmptySlot(element, ownerType, itemId)
            elseif tonumber(slotId) then
                if itemsTable[element][slotId] then
                    slotId = findEmptySlot(element, ownerType, itemId)
                end
            end
            
            if tonumber(slotId) then
                if perishableItems[itemId] then
                    data3 = 0
                end
                
                --[[if itemId == 9 then -- phone
                    queuedPhoneItems[ownerId] = {element, ownerType, ownerId, itemId, amount, slotId, data1, data2, data3}
                    safeCall("sMobile", "generateNewPhone", ownerId)
                    return true
                end]]
                
                if itemId == 9 then
                    lastPhoneNumber = lastPhoneNumber + 1
                    data1 = lastPhoneNumber
                    data2 = toJSON({
                        noti = 1,
                        ringtone = 1,
                        sound = true,
                        vibration = false,
                        location = true,
                        voice = true
                    }, true)
                end
                
                giveItemImpl(element, ownerType, ownerId, itemId, amount, slotId, data1, data2, data3)
                
                return true
            end
        end
    end
    
    return false
end

addCommandHandler("giveitem", function (sourcePlayer, commandName, targetPlayer, itemId, amount, data1, data2, data3)
    if getElementData(sourcePlayer, "acc.adminLevel") >= 1 then
        itemId = tonumber(itemId)
        amount = tonumber(amount) or 1
        
        if not targetPlayer or not itemId or not amount then
            outputChatBox("[color=sightblue][SightMTA - Használat]: #ffffff/" .. commandName .. " [Játékos Név / ID] [Item ID] [Mennyiség] [ < Data 1 | Data 2 | Data 3 > ]", sourcePlayer, 255, 150, 0, true)
        else
            targetPlayer = exports.sCore:findPlayer(sourcePlayer, targetPlayer)
            
            if targetPlayer then
                local state = giveItem(targetPlayer, itemId, amount, false, data1, data2, data3)
                
                if state then
                    exports.sAdministration:showMessageForAdmins("[color=sightgreen][SightMTA - [color=sightblue]AdminNapló[color=sightgreen]] " .."[color=sightgreen]" .. getPlayerName(sourcePlayer):gsub("_", " ") .. "[color=hudwhite] lekért egy tárgyat, [color=sightgreen](" .. getItemName(itemId) .. " | "..amount.."db) [color=sightgreen]" .. getPlayerName(targetPlayer):gsub("_", " ").."[color=hudwhite] nevű játékos számára.")

                    outputChatBox("[color=sightgreen][SightMTA - Siker]: [color=hudwhite] kiválasztott tárgy sikeresen odaadásra került.", sourcePlayer, 0, 0, 0, true)
                    
                    exports.sAnticheat:sendWebhookMessage("**"..getPlayerName(sourcePlayer):gsub("_", " ").."** Lekért egy **"..getItemName(itemId).."** nevű tárgyat **"..getPlayerName(targetPlayer).."**-nak/nek. | Mennyiség: **" ..amount.. "** | Data1: **" .. tostring(data1) .. "** | Data2: **" ..tostring(data2) .. "** | Data3: **" .. tostring(data3) .. "** " ,"give")
                else
                    outputChatBox("[color=sightred][SightMTA - Hiba]: [color=hudwhite]A kiválasztott tárgy odaadása meghiúsult.", sourcePlayer, 0, 0, 0, true)
                end
            end
        end
    end
end)

function loadItems(element, loadActionbar)
    if isElement(element) then
        local ownerType = getElementType(element)
        local ownerId = false
        
        if ownerType == "player" then
            ownerId = tonumber(getElementData(element, defaultSettings.characterId))
        elseif ownerType == "vehicle" then
            ownerId = tonumber(getElementData(element, defaultSettings.vehicleId))
        elseif ownerType == "object" then
            ownerId = tonumber(getElementData(element, defaultSettings.objectId))
        end
        
        if ownerId then
            itemsTable[element] = {}
            
            return dbQuery(function(query, loadActionbar)
                local result = dbPoll(query, 0)
                
                if result then
                    local lost, restored = 0, 0
                    
                    for k, v in pairs(result) do
                        local slotId = false
                        
                        if itemsTable[element][v.slot] then
                            slotId = findEmptySlot(element, ownerType, v.itemId)
                            
                            if slotId then
                                dbExec(connection, "UPDATE items SET slot = ? WHERE dbID = ?", slotId, v.dbID)
                                restored = restored + 1
                            end
                            
                            lost = lost + 1
                        else
                            slotId = v.slot
                        end
                        
                        addItem(element, v.dbID, slotId, v.itemId, v.amount, v.data1, v.data2, v.data3, v.nameTag, v.serial)
                    end
                    
                    if lost > 0 and ownerType == "player" then
                        outputChatBox("[color=sightred][SightMTA - Inventory]: [color=sightblue]" .. lost .. " #ffffffdarab elveszett tárggyal rendelkezel.", element, 255, 255, 255, true)
                        
                        if restored > 0 then
                            outputChatBox("[color=sightred][SightMTA - Inventory]: #ffffffEbből [color=sightblue]" .. restored .. " #ffffffdarab lett visszaállítva.", element, 255, 255, 255, true)
                        end
                        
                        if lost - restored > 0 then
                            outputChatBox("[color=sightred][SightMTA - Inventory]: #ffffffNem sikerült visszaállítani [color=sightblue]" .. lost - restored .. " #ffffffdarab tárgyad, mert nincs szabad slot az inventorydban.", element, 255, 255, 255, true)
                            outputChatBox("[color=sightred][SightMTA - Inventory]: #ffffffkövetkező bejelentkezésedkor ismét megpróbáljuk.", element, 255, 255, 255, true)
                        end
                        
                        if lost == restored then
                            outputChatBox("[color=sightred][SightMTA - Inventory]: #ffffffAz összes hibás tárgyadat sikeresen visszaállítottuk. Kellemes játékot kívánunk! :).", element, 255, 255, 255, true)
                        end
                    end
                end
                
                
                
                if ownerType == "player" then
                    usedSecondaryItems[element] = usedSecondaryItems[element] or {}
                    triggerClientEvent(element, "loadItems", element, itemsTable[element], "player")
                    local targetElement = element
                    
                    if loadActionbar then
                        loadActionbarItems(targetElement)
                    end
                else
                    if isElement(inventoryInUse[element]) then
                        triggerClientEvent(inventoryInUse[element], "loadItems", inventoryInUse[element], itemsTable[element], ownerType, element, true)
                    end
                end
            end, {loadActionbar}, connection, "SELECT * FROM items WHERE ownerType = ? AND ownerId = ?", ownerType, ownerId)
        end
        
        return false
    end
    
    return false
end

function loadActionbarItems(targetPlayer)
    if isElement(targetPlayer) then
        local charId = getElementData(targetPlayer, "char.ID")
        triggerClientEvent(targetPlayer, "gotActionBar", resourceRoot, {})
        
        if type(charId) == "number" then
            dbQuery(function(qh)
                local result = dbPoll(qh, 0)
                
                if result and type(result) == "table" then
                    local actionResults = result[1]
                    
                    if actionResults then
                        local dat = fromJSON(actionResults.actionBarItems) or {}
                        
                        for k, v in pairs(dat) do
                            if type(k) == "string" then
                                dat[tonumber(k)] = v
                                dat[k] = nil
                            end
                        end
                        
                        triggerLatentClientEvent(targetPlayer, "gotActionBar", resourceRoot, dat)
                    end
                end
            end, connection, "SELECT actionBarItems FROM characters WHERE characterId = ?", charId)
        end
    end
end

function triggerItemEvent(element, event, ...)
    local sourcePlayer = element
    
    if getElementType(element) == "player" then
        if event == "movedItemInInv" then
            refreshPlayerWeapons(sourcePlayer)
        end
        triggerClientEvent(element, event, element, ...)
    else
        if isElement(inventoryInUse[element]) then
            triggerClientEvent(inventoryInUse[element], event, inventoryInUse[element], ...)
            sourcePlayer = inventoryInUse[element]
        end
    end
    
    if event == "addItem" or event == "deleteItem" or event == "updateAmount" then
        if isElement(sourcePlayer) and getElementType(element) == "player" then
            triggerClientEvent(sourcePlayer, "movedItemInInv", sourcePlayer, event == "updateAmount")
            refreshPlayerWeapons(sourcePlayer)
        end
    end
end

function refreshPlayerWeapons(element)
    if getElementType(element) == "player" then
        triggerEvent("processPlayerWeaponItems", element, itemsTable[element])
    end
end

function hasItem(element, itemId, amount)
    if itemsTable[element] then
        for k, v in pairs(itemsTable[element]) do
            if v.itemId == itemId and (not amount or v.amount == amount) then
                return v
            end
        end
    end
    
    return false
end

function hasItemEx(element, dataName, dataValue, amount, data1)
    if itemsTable[element] then
        for k, v in pairs(itemsTable[element]) do
            if v[dataName] == dataValue and (not amount or v.amount >= amount) and (not data1 or (v.data1 == data1 or tonumber(v.data1) == data1)) then
                return v
            end
        end
    end
    
    return false
end

function getItemCount(element, itemId)
    local foundAmount = 0
    
    if itemsTable[element] then
        for k, v in pairs(itemsTable[element]) do
            if v.itemId == itemId then
                foundAmount = foundAmount + v.amount
            end
        end
    end
    
    return foundAmount
end

function getItemCountEx(element, dbID)
    local foundAmount = 0
    
    if itemsTable[element] then
        for k, v in pairs(itemsTable[element]) do
            if v.dbID == dbID then
                foundAmount = v.amount
            end
        end
    end
    
    return foundAmount
end

function addItemDose(element, dbID, plus)
    if itemsTable[element] then
        for k, v in pairs(itemsTable[element]) do
            if v.dbID == dbID then
                v.data1 = tonumber(v.data1) or 0
                
                if (v.data1 + (plus or 1)) < newItemList[v.itemId].dose then
                    updateItemData1(element, dbID, v.data1 + (plus or 1))
                else
                    takeItem(element, "dbID", v.dbID)
                end
            end
        end
    end
    
    return false
end

function getItemSlotID(element, itemDBID)
    if itemsTable[element] then
        for k, v in pairs(itemsTable[element]) do
            if v.dbID == itemDBID then
                return v.slot
            end
        end
    end
    
    return false
end

function getItemData1(thePlayer, itemDBID)
    if itemsTable[thePlayer] then
        for k, v in pairs(itemsTable[thePlayer]) do
            if v.dbID == itemDBID then
                return v.data1 or 0
            end
        end
    end
end

function getItemData(thePlayer, itemDatabaseIdentity, dataType)
    if itemsTable[thePlayer] then
        for k, v in pairs(itemsTable[thePlayer]) do
            if v.dbID == itemDatabaseIdentity then
                if dataType == 1 then
                    return v.data1 or 0
                elseif dataType == 2 then
                    return v.data2 or 0
                elseif dataType == 3 then
                    return v.data3 or 0
                end
            end
        end
    end
end

function updateItemData1(thePlayer, itemDBID, newData1)
    if itemsTable[thePlayer] then
        local slot = getItemSlotID(thePlayer, itemDBID)
        
        if slot then
            itemsTable[thePlayer][slot].data1 = newData1
            dbExec(connection, "UPDATE items SET data1 = ? WHERE dbID = ?", newData1, itemsTable[thePlayer][slot].dbID)
            
            triggerClientEvent(thePlayer, "updateData1", thePlayer, "player", itemDBID, newData1)
        end
    end
end

function updateItemData2(thePlayer, itemDBID, newData2)
    if itemsTable[thePlayer] then
        local slot = getItemSlotID(thePlayer, itemDBID)
        
        if slot then
            itemsTable[thePlayer][slot].data2 = newData2
            dbExec(connection, "UPDATE items SET data2 = ? WHERE dbID = ?", newData2 or nil, itemsTable[thePlayer][slot].dbID)
            
            triggerClientEvent(thePlayer, "updateData2Ex", thePlayer, "player", itemDBID, newData2)
        end
    end
end

function setItemData2(thePlayer, itemDBID, newData2)
    if itemsTable[thePlayer] then
        local slot = getItemSlotID(thePlayer, itemDBID)
        
        if slot then
            itemsTable[thePlayer][slot].data2 = newData2
            dbExec(connection, "UPDATE items SET data2 = ? WHERE dbID = ?", newData2 or nil, itemsTable[thePlayer][slot].dbID)
        end
    end
end

function setItemId(thePlayer, itemDBID, itemId)
    if itemsTable[thePlayer] then
        local slot = getItemSlotID(thePlayer, itemDBID)
        
        if slot then
            itemsTable[thePlayer][slot].itemId = itemId
            dbExec(connection, "UPDATE items SET itemId = ? WHERE dbID = ?", itemId, itemsTable[thePlayer][slot].dbID)
            triggerClientEvent(thePlayer, "updateItemID", thePlayer, "player", itemDBID, itemId)
        end
    end
end

function updateItemData3(thePlayer, itemDBID, newData3)
    if itemsTable[thePlayer] then
        local slot = getItemSlotID(thePlayer, itemDBID)
        
        if slot then
            itemsTable[thePlayer][slot].data3 = newData3
            dbExec(connection, "UPDATE items SET data3 = ? WHERE dbID = ?", newData3, itemsTable[thePlayer][slot].dbID)
            
            triggerClientEvent(thePlayer, "updateData3Ex", thePlayer, "player", itemDBID, newData3)
        end
    end
end

function getElementItems(element)
    if isElement(element) then
        if itemsTable[element] then
            return itemsTable[element]
        end
    end
    
    return {}
end

function takeItem(element, dataType, dataValue, amount)
    if not isElement(element) then
        return
    end
    
    if not itemsTable[element] then
        return
    end
    
    local ownerType = getElementType(element)
    
    if client and client ~= element then
        return
    end
    
    local ownerId = nil
    
    if ownerType == "player" then
        ownerId = getElementData(element, defaultSettings.characterId)
    elseif ownerType == "vehicle" then
        ownerId = getElementData(element, defaultSettings.vehicleId)
    elseif ownerType == "object" then
        ownerId = getElementData(element, defaultSettings.objectId)
    end
    
    if not ownerId then
        return
    end
    
    local deleted = {}
    
    for k, v in pairs(itemsTable[element]) do
        if v[dataType] and v[dataType] == dataValue then
            if amount and v.amount - amount > 0 then
                v.amount = v.amount - amount
                
                if ownerType == "player" then
                    triggerItemEvent(element, "updateAmount", ownerType, v.dbID, v.amount)
                    if warningItems[v.itemId] then
                        
                        if warningItems[v.itemId] == "vehicle" then
                            local veh = getPedOccupiedVehicle(element)
                            local vehID = getElementData(veh, "vehicle.dbID")
                            embedDatas = {
                                username = "SightMTA - Log [Items]",
                                title = "SightMTA | sightmta.hu",
                                color = "sightblue",
                                title = "Egy játékos felhasznált egy prémium kártyát! ["..getElementData(element, "visibleName"):gsub("_", " ").."]",
                                
                                embedData = {
                                    embedFields = {
                                        {    
                                            name = "Item neve",
                                            value = "```".. getItemName(v.itemId) .. "```",
                                            inline = true
                                        },
                                        {    
                                            name = "Autó",
                                            value = "```".. vehID .. "```",
                                            inline = true
                                        },
                                    },
                                },
                            }
                        else
                            embedDatas = {
                                username = "SightMTA - Log [Items]",
                                title = "SightMTA | sightmta.hu",
                                color = "sightred",
                                title = "Egy játékos felhasznált egy prémium kártyát! ["..getElementData(element, "visibleName"):gsub("_", " ").."]",
                                
                                embedData = {
                                    embedFields = {
                                        {    
                                            name = "Item neve",
                                            value = "```".. getItemName(v.itemId) .."```",
                                            inline = true
                                        },
                                    },
                                },
                            }
                        end
                        
                        exports.sAnticheat:sendEmbedMessage(embedDatas, "premiumItem")
                    end
                end
                
                dbExec(connection, "UPDATE items SET amount = ? WHERE dbID = ?", v.amount, v.dbID)
            else
                if getElementType(element) == "player" then
                    if newItemList[v.itemId].use and newItemList[v.itemId].use == "weapon" then
                        triggerEvent("onWeaponTake", element, v.dbID, v.itemId)
                    end
                end
                
                if usedSecondaryItems[v.dbID] then
                    usedSecondaryItems[v.dbID] = nil
                end
                
                table.insert(deleted, v.dbID)
                
                if warningItems[v.itemId] then
                    local veh = getPedOccupiedVehicle(element)
                    if warningItems[v.itemId] == "vehicle" and veh then
                        local vehID = getElementData(veh, "vehicle.dbID")
                        embedDatas = {
                            username = "SightMTA - Log [Items]",
                            title = "SightMTA | sightmta.hu",
                            color = "sightblue",
                            title = "Egy játékos felhasznált egy prémium kártyát! ["..getElementData(element, "visibleName"):gsub("_", " ").."]",
                            
                            embedData = {
                                embedFields = {
                                    {    
                                        name = "Item neve",
                                        value = "```".. getItemName(v.itemId) .. "```",
                                        inline = true
                                    },
                                    {    
                                        name = "Autó",
                                        value = "```".. vehID .. "```",
                                        inline = true
                                    },
                                },
                            },
                        }
                    else
                        embedDatas = {
                            username = "SightMTA - Log [Items]",
                            title = "SightMTA | sightmta.hu",
                            color = "sightred",
                            title = "Egy játékos felhasznált egy prémium kártyát! ["..getElementData(element, "visibleName"):gsub("_", " ").."]",
                            
                            embedData = {
                                embedFields = {
                                    {    
                                        name = "Item neve",
                                        value = "```".. getItemName(v.itemId) .."```",
                                        inline = true
                                    },
                                },
                            },
                        }
                    end
                    
                    exports.sAnticheat:sendEmbedMessage(embedDatas, "premiumItem")
                end
                
                itemsTable[element][v.slot] = nil
            end
        end
    end
    
    if #deleted > 0 then
        if ownerType == "player" then
            triggerItemEvent(element, "deleteItem", ownerType, deleted)
            triggerItemEvent(element, "movedItemInInv")
        end
        
        dbExec(connection, "DELETE FROM items WHERE dbID IN (" .. table.concat(deleted, ",") .. ")")
        
        return true
    end
end

function takeItemEx(element, dataType, dataValue, amount, data1)
    if not isElement(element) then
        return
    end
    
    if not itemsTable[element] then
        return
    end
    
    local ownerType = getElementType(element)
    
    local ownerId = nil
    
    if ownerType == "player" then
        ownerId = getElementData(element, defaultSettings.characterId)
    elseif ownerType == "vehicle" then
        ownerId = getElementData(element, defaultSettings.vehicleId)
    elseif ownerType == "object" then
        ownerId = getElementData(element, defaultSettings.objectId)
    end
    
    if not ownerId then
        return
    end
    
    local deleted = {}
    
    for k, v in pairs(itemsTable[element]) do
        if v[dataType] and v[dataType] == dataValue and (not data1 or (v.data1 == data1 or tonumber(v.data1) == data1)) then
            if amount and v.amount - amount > 0 then
                v.amount = v.amount - amount
                
                if ownerType == "player" then
                    triggerItemEvent(element, "updateAmount", ownerType, v.dbID, v.amount)
                end
                
                dbExec(connection, "UPDATE items SET amount = ? WHERE dbID = ?", v.amount, v.dbID)
            else
                table.insert(deleted, v.dbID)
                itemsTable[element][v.slot] = nil
            end
        end
    end
    
    if #deleted > 0 then
        if ownerType == "player" then
            triggerItemEvent(element, "deleteItem", ownerType, deleted)
            triggerItemEvent(element, "movedItemInInv")
        end
        
        dbExec(connection, "DELETE FROM items WHERE dbID IN (" .. table.concat(deleted, ",") .. ")")
    end
end

function takeAllItems(dataType, dataValue, amount, data1)
    for elem in pairs(itemsTable) do
        if hasItemEx(elem, dataType, dataValue, amount, data1) then
            takeItemEx(elem, dataType, dataValue, amount, data1)
        end
    end
    
    if isElement(connection) then
        if not data1 then
            dbExec(connection, "DELETE FROM items WHERE " .. dataValue .. " = ?", dataValue)
        else
            dbExec(connection, "DELETE FROM items WHERE " .. dataValue .. " = ? AND data1 = ?", dataValue, data1)
        end
    end
end

function takeDutyItems(targetPlayer, groupKey)
    if itemsTable[targetPlayer] then
        local groupDuty = string.format("duty:%s", groupKey)
        
        for k, v in pairs(itemsTable[targetPlayer]) do
            if v.data3 == groupDuty then
                takeItem(targetPlayer, "dbID", v.dbID, v.amount)
            end
        end
    end
end

function checkPawnItems(player, pawnTable)
    for itemId, itemCount in pairs(pawnTable) do
        if getItemCount(player, itemId) < itemCount then
            return false, itemId, itemCount - getItemCount(player, itemId)
        end
    end
    
    for itemId, itemCount in pairs(pawnTable) do
        local itemsRemoved = 0
        for k2, v2 in pairs(itemsTable[player]) do
            if v2.itemId == itemId and itemsRemoved < itemCount then
                local amountToRemove = math.min(itemCount - itemsRemoved, v2.amount)
                itemsRemoved = itemsRemoved + amountToRemove
                return v2.dbID
            end
        end
    end
    
    return nil
end

addEvent("takePawnItems", true)
addEventHandler("takePawnItems", getRootElement(), function (player, pawnTable)
    local itemNum = 0
    local state = true
    
    for itemId, itemCount in pairs(pawnTable) do
        if getItemCount(player, itemId) < itemCount then
            state = false
            break
        else
            local itemsRemoved = 0
            for k2, v2 in pairs(itemsTable[player]) do
                if v2.itemId == itemId and itemsRemoved < itemCount then
                    local amountToRemove = math.min(itemCount - itemsRemoved, v2.amount)
                    takeItem(player, "dbID", v2.dbID, amountToRemove)
                    itemsRemoved = itemsRemoved + amountToRemove
                    
                    if itemsRemoved >= itemCount then
                        break
                    end
                end
            end
            if itemsRemoved < itemCount then
                state = false
                break
            end
        end
    end
end)

addEvent("fixSkinWeapon", true)
addEventHandler("fixSkinWeapon", getRootElement(), function (fixerItem, weapon)
    local item = hasItemEx(client, "dbID", weapon)
    if exports.sWeapons:canFixWeapon(item.itemId) then
        takeItem(client, "dbID", fixerItem)
        updateItemData1(client, weapon, 0)
        safeCall("sGui", "showInfobox", client, "s", "Sikeresen megjavítottad a fegyvert!")
    else
        safeCall("sGui", "showInfobox", client, "e", "Csak skines fegyvert tudsz megjavítani!")
    end
end)

addEvent("setWaterCanToSpecial", true)
addEventHandler("setWaterCanToSpecial", getRootElement(), function (shtg, can)
    local item = hasItemEx(client, "dbID", can)
    local amount = item.amount
    takeItem(client, "dbID", item.dbID)
    takeItem(client, "dbID", shtg)
    giveItem(client, 429, amount)
end)

function playAnimation(thePlayer, type)
    if type then
        if type == "food" then
            setPedAnimation(thePlayer, "FOOD", "eat_pizza", 4000, false, true, true, false)
        elseif type == "drink" then
            setPedAnimation(thePlayer, "VENDING", "vend_drink2_p", 1200, false, true, true, false)
        elseif type == "smoke" then
            setPedAnimation(thePlayer, "SMOKING", "M_smkstnd_loop", 4000, false, true, true, false)
        elseif type == "drug" then
            triggerEvent("playAnimpanelAnimation", thePlayer, 94)
        end
    end
end


addEvent("requestToGiveItemViaPanel", true)
addEventHandler("requestToGiveItemViaPanel", root, function(itemId)
    if client ~= source then
        exports.sAnticheat:anticheatBan(client, "AC #93 - sItems @sourceS:2127")
    end
    
    if client and client == source then
        if exports.sPermission:hasPermission(client, "giveitem") then
            if not itemId or type(itemId) ~= "number" then
                return
            end
            
            executeCommandHandler("giveitem", client, string.format("* %d 1", itemId))
        end
    end
end)

addEvent("showTheItem2", true)
addEventHandler("showTheItem2", root, function(itemData, targetPlayers)
    triggerClientEvent(targetPlayers, "showTheItem", client, itemData)
end)

addEvent("showTheItem", true)
addEventHandler("showTheItem", getRootElement(),
function (item, nearby)
    if isElement(source) and client and client == source then
        if type(item) == "table" and type(nearby) == "table" then
            triggerLatentClientEvent(nearby, "showTheItem", source, item)
        end
    end
end
)

addEvent("takeItem", true)
addEventHandler("takeItem", root, takeItem)

addEvent("playTrashSound", true)
addEventHandler("playTrashSound", root, function(modelId, trashData)
    if client ~= source then
        exports.sAnticheat:anticheatBan(client, "AC #94 - sItems @sourceS:2163")
        return
    end
    exports.sAnticheat:sendWebhookMessage("**"..getElementData(client, "visibleName"):gsub("_", " ") .. "** Kidobott egy tárgyat a szemetesbe! **[dbID:" .. trashData[1] .. " | itemId:" .. trashData[3] .. " | stackAmount:" .. trashData[4] .. "]**", "trash")
    
    if not modelId or type(modelId) ~= "number" then
        return
    end
    
    local posX, posY, posZ = getElementPosition(client)
    
    local interior = getElementInterior(client)
    
    local dimension = getElementDimension(client)
    
    triggerClientEvent(getRootElement(), "playTrashSound", client, "metal" .. math.random(1, 4) .. ".wav", posX, posY, posZ, interior, dimension)
end)

function playUseSound(client)
    local posX, posY, posZ = getElementPosition(client)
    
    local interior = getElementInterior(client)
    
    local dimension = getElementDimension(client)
    
    triggerClientEvent(getRootElement(), "playUseSound", client, math.random(1, 6), posX, posY, posZ, interior, dimension)
end

addEvent("updateData3", true)
addEventHandler("updateData3", root, function(openedElement, itemDBID, newData3)
    if not isElement(openedElement) or not itemDBID or type(itemDBID) ~= "number" or not newData3 then
        return
    end
    
    if getElementType(openedElement) == "player" and openedElement ~= client then
        return
    end
    
    if itemsTable[openedElement] then
        local slot = getItemSlotID(openedElement, itemDBID)
        
        if slot then
            if not perishableItems[itemsTable[openedElement].itemId] then
                return
            end
            
            itemsTable[openedElement][slot].data3 = newData3
            dbExec(connection, "UPDATE items SET data3 = ? WHERE dbID = ?", newData3, itemsTable[openedElement][slot].dbID)
        end
    end
end)

function placeFarmItemsToVehicle(button, state, player)
    if button == "left" and state == "down" and player and getElementType(source) == "vehicle" then
        
        local crateItems = getElementData(player, "currentCrateItems")
        
        local crate = getElementData(player, "currentCrate")
        
        if crate then
            
            farmId = getElementData(crate, "farmCreate")
        end
        
        
        if crateItems and crate and farmId then
            local veh = source
            local vehID = getElementData(veh, "vehicle.dbID")
            local error = false
            if vehID then
                loadItems(veh)
                for k, v in pairs(crateItems) do
                    local slot = findEmptySlot(veh, "vehicle", k)
                    if not slot then
                        error = true
                        break
                    end
                    giveItemImpl(veh, "vehicle", vehID, k, v, slot)
                    
                    exports.sFarm:unUseCrate(player, "", "", crate, farmId, true)
                end
            end
            if error then
                exports.sGui:showInfobox(player, "e", "A jármű csomagtartójában nincs elég hely!") 
            end
        end
    end
end
addEventHandler("onElementClicked", root, placeFarmItemsToVehicle)

addEvent("moveItem", true)
addEventHandler("moveItem", getRootElement(), function(dbID, itemId, movedSlotId, hoverSlotId, stackAmount, ownerElement, targetElement)
    if not isElement(source) or not isElement(ownerElement) or not isElement(targetElement) then
        return
    end
    
    dbID = tonumber(dbID)
    
    if not dbID then
        return
    end
    
    local ownerType = getElementType(ownerElement)
    local ownerId = false
    
    if ownerType == "player" then
        ownerId = getElementData(ownerElement, defaultSettings.characterId)
    elseif ownerType == "vehicle" then
        ownerId = getElementData(ownerElement, defaultSettings.vehicleId)
    elseif ownerType == "object" then
        ownerId = getElementData(ownerElement, defaultSettings.objectId)
    end
    
    if ownerElement == targetElement then
        local movedItem = itemsTable[ownerElement][movedSlotId]
        
        if not movedItem or dbID ~= movedItem.dbID then
            return
        end
        
        if itemsTable[ownerElement][hoverSlotId] then
            if itemsTable[ownerElement][hoverSlotId].locked then
                outputChatBox("[color=sightred][SightMTA - Inventory]: #FFFFFFEz a slot zárolva van! Kérlek várj egy kicsit.", source, 255, 255, 255, true)
            else
                outputChatBox("[color=sightred][SightMTA - Inventory]: #FFFFFFA kiválasztott slot foglalt.", source, 255, 255, 255, true)
            end
            
            triggerClientEvent(source, "failedToMoveItem", source, movedSlotId, hoverSlotId, stackAmount)
            return
        end
        
        if stackAmount >= movedItem.amount or stackAmount <= 0 then
            if ownerElement == source and targetElement == source then
                triggerClientEvent(source, "movedItemInInv", source, true)
            end
            
            if exports.sAnticheat:getStackAlerts(movedItem.itemId) then
                if movedItem.amount > exports.sAnticheat:getStackAlerts(movedItem.itemId) or movedItem.amount < 0 then
                    exports.sAnticheat:stackAlert(source, movedItem)
                end
            end
            
            itemsTable[ownerElement][hoverSlotId] = itemsTable[ownerElement][movedSlotId]
            itemsTable[ownerElement][hoverSlotId].slot = hoverSlotId
            itemsTable[ownerElement][movedSlotId] = nil
            
            dbExec(connection, "UPDATE items SET ownerType = ?, ownerId = ?, slot = ? WHERE dbID = ?", ownerType, ownerId, hoverSlotId, dbID)
        elseif stackAmount > 0 then
            movedItem.amount = movedItem.amount - stackAmount
            
            giveItem(ownerElement, itemId, stackAmount, hoverSlotId, movedItem.data1, movedItem.data2, movedItem.data3)
            
            if getElementType(ownerElement) == "vehicle" then
                setTimer(function(src)
                    triggerClientEvent(src, "loadItems", src, itemsTable[ownerElement], "vehicle", ownerElement, false)
                end, 50, 1, source)
            end
            if getElementType(ownerElement) == "object" then
                setTimer(function(src)
                    triggerClientEvent(src, "loadItems", src, itemsTable[ownerElement], "object", ownerElement, false)
                end, 50, 1, source)
            end
            
            if exports.sAnticheat:getStackAlerts(movedItem.itemId) then
                if movedItem.amount > exports.sAnticheat:getStackAlerts(movedItem.itemId) or movedItem.amount < 0 then
                    exports.sAnticheat:stackAlert(source, movedItem)
                end
            end
            
            dbExec(connection, "UPDATE items SET amount = ? WHERE dbID = ?", movedItem.amount, dbID)
        end
        
        return
    end
    
    if blockedItems[itemId] then
        outputChatBox("[color=sightred][SightMTA - Inventory]: #FFFFFFEzt az itemet nem adhatod át más játékosnak!", source, 255, 255, 255, true)
        triggerClientEvent(source, "unLockItem", source, ownerType, movedSlotId)
        return
    end
    
    local targetType = getElementType(targetElement)
    local targetId = false
    
    if targetType == "player" then
        targetId = getElementData(targetElement, defaultSettings.characterId)
    elseif targetType == "vehicle" then
        targetId = getElementData(targetElement, defaultSettings.vehicleId)
    elseif targetType == "object" then
        targetId = getElementData(targetElement, defaultSettings.objectId)
    end
    
    if targetType == "vehicle" then
        if isVehicleLocked(targetElement) then
            outputChatBox("[color=sightred][SightMTA - Inventory]: #FFFFFFA kiválasztott jármű csomagtartója zárva van.", source, 255, 255, 255, true)
            triggerClientEvent(source, "unLockItem", source, ownerType, movedSlotId)
            return
        end
    end
    
    local movedItem = itemsTable[ownerElement][movedSlotId]
    
    if not movedItem or dbID ~= movedItem.dbID then
        triggerClientEvent(source, "unLockItem", source, ownerType, movedSlotId)
        return
    end
    
    if isElement(inventoryInUse[targetElement]) then
        outputChatBox("[color=sightred][SightMTA - Inventory]: #FFFFFFNem rakhatsz tárgyat az inventoryba amíg azt valaki más használja!", source, 255, 255, 255, true)
        triggerClientEvent(source, "unLockItem", source, ownerType, movedSlotId)
        return
    end
    
    if targetType == "object" then
        if storedSafes[targetId] then
            if storedSafes[targetId].ownerGroup ~= "0" then
                if not exports.sGroups:isPlayerInGroup(source, storedSafes[targetId].ownerGroup) then
                    outputChatBox("[color=sightred][SightMTA - Inventory]: #FFFFFFA kiválasztott széfhez nincs kulcsod.", source, 255, 255, 255, true)
                    triggerClientEvent(source, "unLockItem", source, ownerType, movedSlotId)
                    return
                end
            elseif not hasItemWithData(source, 154, targetId) then
                outputChatBox("[color=sightred][SightMTA - Inventory]: #FFFFFFA kiválasztott széfhez nincs kulcsod.", source, 255, 255, 255, true)
                triggerClientEvent(source, "unLockItem", source, ownerType, movedSlotId)
                return
            end
        end
    end


    
    if targetType ~= "player" then
        if itemId == 361 then -- Pénzkazetta
            outputChatBox("[color=sightred][SightMTA - Inventory]: #FFFFFFEzt az itemet csak más játékosnak adhatod át!", source, 255, 255, 255, true)
            triggerClientEvent(source, "unLockItem", source, ownerType, movedSlotId)
            return
        end
    end
    
    if not itemsTable[targetElement] then
        itemsTable[targetElement] = {}
    end
    
    hoverSlotId = findEmptySlot(targetElement, targetType, itemId)
    
    if not hoverSlotId then
        outputChatBox("[color=sightred][SightMTA - Inventory]: #FFFFFFNincs szabad slot a kiválasztott inventoryban!", source, 255, 255, 255, true)
        triggerClientEvent(source, "unLockItem", source, ownerType, movedSlotId)
        return
    end
    
    local statement = false
    
    if stackAmount >= movedItem.amount or stackAmount <= 0 then
        statement = "move"
        stackAmount = movedItem.amount
    elseif stackAmount > 0 then
        statement = "stack"
    end



    if ownerType == "player" and targetType == "ped" and getElementData(targetElement, "sightmarket:buyerped") == getElementData(ownerElement, "char.ID") then
        local deliveryDetails = exports.sDealer:getDealDetails(ownerElement)
        if deliveryDetails then
            if deliveryDetails.itemId == itemId then
                if deliveryDetails.amount == movedItem.amount then
                    if deliveryDetails.category == "weapon" then
                        triggerEvent("gotDealStatus", ownerElement, true, tonumber(movedItem.data1))
                        triggerClientEvent(ownerElement, "unLockItem", ownerElement, ownerType, movedSlotId)
                    elseif deliveryDetails.category == "drug" then
                        if movedItem.data1 and movedItem.data1 ~= 0 then
                            exports.sGui:showInfobox(ownerElement, "e", "Ezt a drogot már megpiszkálta valaki!")
                            triggerClientEvent(ownerElement, "unLockItem", ownerElement, ownerType, movedSlotId)
                            return
                        end

                        triggerEvent("gotDealStatus", ownerElement, true)
                        triggerClientEvent(ownerElement, "unLockItem", ownerElement, ownerType, movedSlotId)
                    else
                        triggerEvent("gotDealStatus", ownerElement, true)
                        triggerClientEvent(ownerElement, "unLockItem", ownerElement, ownerType, movedSlotId)
                    end

                    takeItem(ownerElement, "dbID", dbID)
                    itemName = getItemName(itemId)
                    safeCall("sChat", "localAction", ownerElement, "átadott egy tárgyat egy ismeretlen vevőnek. (" .. (movedItem.amount .. " darab " ..itemName)..")")

                    setPedAnimation(ownerElement, "DEALER", "DEALER_DEAL", -1, false, false, false, false)
                    setPedAnimation(targetElement, "DEALER", "DEALER_DEAL", -1, false, false, false, false)
                else
                    exports.sGui:showInfobox(ownerElement, "e", "Nem eggyezik a megbeszélt mennyiséggel.")
                    triggerClientEvent(ownerElement, "unLockItem", ownerElement, ownerType, movedSlotId)
                end
            else
                triggerEvent("gotDealStatus", ownerElement, false)
                triggerClientEvent(ownerElement, "unLockItem", ownerElement, ownerType, movedSlotId)
            end
        end

        return
    end

    if getCurrentWeight(targetElement) + getItemWeight(itemId) * stackAmount > getWeightLimit(targetType, targetElement) then
        outputChatBox("[color=sightred][SightMTA - Inventory]: #FFFFFFA kiválasztott inventory nem bírja el ezt a tárgyat!", source, 255, 255, 255, true)
        triggerClientEvent(source, "unLockItem", source, ownerType, movedSlotId)
        return
    end
    
    if statement == "move" then
        itemsTable[targetElement][hoverSlotId] = itemsTable[ownerElement][movedSlotId]
        itemsTable[targetElement][hoverSlotId].slot = hoverSlotId
        itemsTable[ownerElement][movedSlotId] = nil
        
        triggerItemEvent(targetElement, "addItem", targetType, itemsTable[targetElement][hoverSlotId])
        triggerItemEvent(ownerElement, "deleteItem", ownerType, {dbID})
        
        dbExec(connection, "UPDATE items SET ownerType = ?, ownerId = ?, slot = ? WHERE dbID = ?", targetType, targetId, hoverSlotId, dbID)
    end
    
    if statement == "stack" then
        movedItem.amount = movedItem.amount - stackAmount
        
        giveItem(targetElement, itemId, stackAmount, hoverSlotId, movedItem.data1, movedItem.data2, movedItem.data3)
        triggerItemEvent(ownerElement, "updateAmount", ownerType, dbID, movedItem.amount)
        
        dbExec(connection, "UPDATE items SET amount = ? WHERE dbID = ?", movedItem.amount, dbID)
    end
    
    triggerClientEvent(source, "unLockItem", source, ownerType, movedSlotId)

    
    local itemId = movedItem.itemId
    local itemName = ""
    
    if newItemList[itemId] then
        itemName = getItemName(itemId)
        
        if itemsTable[targetElement][hoverSlotId].nameTag then
            itemName = " (" .. itemName .. " (" .. itemsTable[targetElement][hoverSlotId].nameTag .. "))"
        else
            itemName = " (" .. itemName .. ")"
        end
    end

    if ownerType == "player" and targetType == "player" then
        safeCall("sChat", "localAction", ownerElement, "átadott egy tárgyat " .. getElementData(targetElement, "visibleName"):gsub("_", " ") .. "-nak/nek." .. itemName)
        
        setPedAnimation(ownerElement, "DEALER", "DEALER_DEAL", -1, false, false, false, false)
        setPedAnimation(targetElement, "DEALER", "DEALER_DEAL", -1, false, false, false, false)
        
        return
    end

    
    if ownerType == "player" then
        if targetType == "vehicle" then
            if not getPedOccupiedVehicle(ownerElement) then
                safeCall("sChat", "localAction", ownerElement, "berakott egy tárgyat a jármű csomagtartójába." .. itemName)
                exports.sAnticheat:sendWebhookMessage("**" .. getElementData(ownerElement, "visibleName"):gsub("_", " ") .. "** berakott egy tárgyat a jármű csomagtartójába. **[dbID: " .. dbID .. " | itemId: " .. itemId .. " | stackAmount: " .. stackAmount .. " | vehId: "..getElementData(targetElement, "vehicle.dbID").."]**", "trunk")
            else
                exports.sGui:showInfobox(ownerElement, "e", "Járműben ülve nem pakolhatsz a csomagtartóba!")
            end
        end
        
        if targetType == "object" then
            safeCall("sChat", "localAction", ownerElement, "berakott egy tárgyat a széfbe." .. itemName)
            exports.sAnticheat:sendWebhookMessage("**" .. getElementData(ownerElement, "visibleName"):gsub("_", " ") .. "** berakott egy tárgyat a széfbe. **[dbID: " .. dbID .. " | itemId: " .. itemId .. " | stackAmount: " .. stackAmount .. " ]**", "safe")
        end
        
        if exports.sAnticheat:getStackAlerts(movedItem.itemId) then
            if movedItem.amount > exports.sAnticheat:getStackAlerts(movedItem.itemId) or movedItem.amount < 0 then
                exports.sAnticheat:stackAlert(source, movedItem, targetId, targetType)
            end
        end
        
        return
    end
    
    if ownerType == "vehicle" then
        safeCall("sChat", "localAction", targetElement, "kivett egy tárgyat a jármű csomagtartójából." .. itemName)
        exports.sAnticheat:sendWebhookMessage("**" .. getElementData(targetElement, "visibleName"):gsub("_", " ") .. "** kivett egy tárgyat a jármű csomagtartójából. **[dbID: " .. dbID .. " | itemId: " .. itemId .. " | stackAmount: " .. stackAmount .. " | vehId: "..getElementData(ownerElement, "vehicle.dbID").."]**", "trunk")
        
        if exports.sAnticheat:getStackAlerts(movedItem.itemId) then
            if movedItem.amount > exports.sAnticheat:getStackAlerts(movedItem.itemId) or movedItem.amount < 0 then
                exports.sAnticheat:stackAlert(targetElement, movedItem)
            end
        end
        return
    end
    
    if ownerType == "object" then
        safeCall("sChat", "localAction", targetElement, "kivett egy tárgyat a széfből." .. itemName)
        exports.sAnticheat:sendWebhookMessage("**" ..getElementData(targetElement, "visibleName"):gsub("_", " ").. "** kivett egy tárgyat egy széfből. **[dbID: " .. dbID .. " | itemId: " .. itemId .. " | stackAmount: " .. stackAmount .. " ]**", "safe")
        
        if exports.sAnticheat:getStackAlerts(movedItem.itemId) then
            if movedItem.amount > exports.sAnticheat:getStackAlerts(movedItem.itemId) or movedItem.amount < 0 then
                exports.sAnticheat:stackAlert(targetElement, movedItem)
            end
        end
        return
    end
end)

local stackingProcesses = {}

addEvent("stackItem", true)
addEventHandler("stackItem", getRootElement(), function(ownerElement, movedItemId, hoverItemId, stackAmount)
    if getElementType(ownerElement) == "player" and client ~= ownerElement then
        return
    end

    --if stackingProcesses[client] and stackingProcesses[client] + 500 > getTickCount() then
    --    exports.sGui:showInfobox(client, "e", "Ne ilyen gyorsan!")
    --    return
    --end

    if not hasItemEx(client, "dbID", movedItemId, stackAmount) then
        return
    end

    if itemsTable[ownerElement] then
        local ownerType = getElementType(client)

        for k, v in pairs(itemsTable[ownerElement]) do
            if v.dbID == hoverItemId then
                if v.amount > 0 then
                    v.amount = v.amount + stackAmount
                    
                    triggerItemEvent(client, "updateAmount", ownerType, v.dbID, v.amount)
                    
                    dbExec(connection, "UPDATE items SET amount = ? WHERE dbID = ?", v.amount, v.dbID)
                    
                    if getElementType(ownerElement) == "vehicle" then
                        setTimer(function(client)
                            triggerClientEvent(client, "loadItems", client, itemsTable[ownerElement], "vehicle", ownerElement, false)
                        end, 50, 1, client)
                    end
                    if getElementType(ownerElement) == "object" then
                        setTimer(function(client)
                            triggerClientEvent(client, "loadItems", client, itemsTable[ownerElement], "object", ownerElement, false)
                        end, 50, 1, client)
                    end
                end
            end
            
            if v.dbID == movedItemId then
                if v.amount > stackAmount and v.amount - stackAmount > 0 then
                    v.amount = v.amount - stackAmount
                    
                    triggerItemEvent(client, "updateAmount", ownerType, v.dbID, v.amount)
                    
                    dbExec(connection, "UPDATE items SET amount = ? WHERE dbID = ?", v.amount, v.dbID)
                else
                    triggerItemEvent(client, "deleteItem", ownerType, {v.dbID})
                    
                    dbExec(connection, "DELETE FROM items WHERE dbID = ?", v.dbID)
                    
                    itemsTable[ownerElement][v.slot] = nil
                end
            end
        end
    end

    stackingProcesses[client] = getTickCount()
end)

addEvent("tryToRenameItem", true)
addEventHandler("tryToRenameItem", getRootElement(), function(text, renameItemId, nameTagItemId)
    if text and renameItemId and nameTagItemId then
        local renameSlot = getItemSlotID(client, renameItemId)
        local nametagSlot = getItemSlotID(client, nameTagItemId)
        local success = 0
        
        if renameSlot then
            itemsTable[client][renameSlot].nameTag = text
            success = success + 1
        end
        
        if nametagSlot then
            itemsTable[client][nametagSlot] = nil
            success = success + 1
        end
        
        if success == 2 then
            dbExec(connection, "UPDATE items SET nameTag = ? WHERE dbID = ?", text, renameItemId)
            dbExec(connection, "DELETE FROM items WHERE dbID = ?", nameTagItemId)
            
            triggerItemEvent(client, "updateNameTag", renameItemId, text)
            triggerItemEvent(client, "deleteItem", "player", {nameTagItemId})
        else
            safeCall("sGui", "showInfobox", client, "e", "Az item átnevezése meghiúsult.")
        end
    end
end)

function getNearestPoint(player, playerX, playerY, playerZ)
    local nearestPoint = nil
    local nearestDistance = 5
    
    local openPoses = exports.sCrate:getOpenPoses()
    
    for k, pose in ipairs(openPoses) do
        if pose[6] == getElementDimension(player) then
            local distance = getDistanceBetweenPoints3D(playerX, playerY, playerZ, pose[1], pose[2], pose[3])
            if distance < nearestDistance then
                nearestPoint = k
                nearestDistance = distance
            end
        end
    end
    
    return nearestPoint
end

function isElementInRange(ele, x, y, z, range)
    if isElement(ele) and type(x) == "number" and type(y) == "number" and type(z) == "number" and type(range) == "number" then
        return getDistanceBetweenPoints3D(x, y, z, getElementPosition(ele)) <= range
    end
    return false
end

baseX, baseY, baseZ = 621.785, -11, 999.92
local playerBadges = {}

addEvent("useItem", true)
addEventHandler("useItem", getRootElement(), function(itemDBID, pos)
    local client = client or source
    if not itemDBID or type(itemDBID) ~= "number" then
        return
    end
    
    if exports.sJail:isPlayerInJail(client) then
        exports.sGui:showInfobox(client, "e", "Börtönben nem használhatsz tárgyakat!")
        return
    end
    
    local itemData = hasItemEx(client, "dbID", itemDBID)
    
    if not itemData then
        return
    end
    
    local itemId = itemData.itemId
    
    local itemListEntry = newItemList[itemId]
    if getElementData(client, "isPlayerDeath") or getElementHealth(client) < 1 then
        if itemId ~= 591 then
            triggerClientEvent(client, "showInfobox", client, "error", "Halottan csak a Respawn Kártyát használhatod!", 5000)
            return
        end
    end
    
    if itemListEntry.crateItem then
        if exports.sGroups:getPlayerPermission(client, "crateOpen") then
            if hasItem(client, 245, 1) then
                local x, y, z = getElementPosition(client)
                local openingPosition = false
                if getNearestPoint(client, x, y, z) or isElementInRange(client, baseX - 7.2321, baseY - 19.3982, baseZ + 0.4747, 6) then
                    if isElementInRange(client, baseX - 7.2321, baseY - 19.3982, baseZ + 0.4747, 6) then
                        if exports.sGarages:isGarageHasCraft(getElementDimension(client)) then
                            openingPosition = "garage_" ..getElementDimension(client)
                        end
                    else
                        openingPosition = getNearestPoint(client, x, y, z)
                    end
                    if not openingPosition then
                        triggerClientEvent(client, "showInfobox", client, "error", "Itt nem nyithatod ki!", 5000)
                        return
                    end
                    exports.sCrate:startCrateOpening(client, itemListEntry.crateItem, openingPosition, itemData.dbID)
                end
            else
                triggerClientEvent(client, "showInfobox", client, "error", "Nincs nálad flex!", 5000)
            end
        else
            triggerClientEvent(client, "showInfobox", client, "error", "Ehhez nincs jogosultságod!", 5000)
        end
    end
    
    if itemListEntry.powderItem then
        if exports.sGroups:getPlayerPermission(client, "crateOpen") then
            if hasItem(client, 34, 1) then
                local x, y, z = getElementPosition(client)
                local openingPosition = false
                rot = 90
                if getNearestPoint(client, x, y, z) or isElementInRange(client, baseX - 7.2321, baseY - 19.3982, baseZ + 0.4747, 6) then
                    if isElementInRange(client, baseX - 7.2321, baseY - 19.3982, baseZ + 0.4747, 6) then
                        if exports.sGarages:isGarageHasCraft(getElementDimension(client)) then
                            rot = 0
                            openingPosition = "garage_" ..getElementDimension(client)
                        end
                    else
                        openingPosition = getNearestPoint(client, x, y, z)
                    end
                    if not openingPosition then
                        triggerClientEvent(client, "showInfobox", client, "error", "Itt nem nyithatod ki!", 5000)
                        return
                    end
                    triggerClientEvent("clientAmmoOpeningState", client, openingPosition, rot)
                    triggerEvent("gotPlayerOpeningAmmo", client, openingPosition, rot)
                    setPedAnimation(client, "GANGS", "prtial_gngtlkE", -1, true, false, false, false)
                    takeItem(client, "dbID", itemData.dbID)
                end
            else
                triggerClientEvent(client, "showInfobox", client, "error", "Nincs nálad kalapács!", 5000)
            end
        else
            triggerClientEvent(client, "showInfobox", client, "error", "Ehhez nincs jogosultságod!", 5000)
        end
    end
    
    if itemListEntry.secondaryUse then
        if itemData.itemId == 206 then
            local badgeData = getElementData(client, "badgeData") or false
            if badgeData then
                if itemData.dbID ~= playerBadges[client] then
                    exports.sGui:showInfobox(client, "e", "Rajtad már van egy jelvény!, előbb vedd le azt!")
                    return
                end
            end
            
            itemListEntry.use = not itemListEntry.use
            if not itemListEntry.use then
                safeCall("sChat", "localAction", client, "levesz egy jelvényt.")
                
                setElementData(client, "badgeData", false)
                setElementData(client, "badgeExData", false)
                
                unuseItem(client)
                playUseSound(client)
            else
                safeCall("sChat", "localAction", client, "felvesz egy jelvényt.")
                
                playerBadges[client] = itemData.dbID
                setElementData(client, "badgeData", itemData.data1 .." # ".. itemData.data2)
                setElementData(client, "badgeExData", false)
                
                setUsedItem(client, itemData)
                playUseSound(client)
            end
        else
            if itemData.itemId == 443 then
                local badgeData = getElementData(client, "badgeData") or false
                if badgeData then
                    if itemData.dbID ~= playerBadges[client] then
                        exports.sGui:showInfobox(client, "e", "Rajtad már van egy jelvény! Előbb vedd le azt!")
                        return
                    end
                end
                
                itemListEntry.use = not itemListEntry.use
                if not itemListEntry.use then
                    safeCall("sChat", "localAction", client, "levesz egy névkitűzőt.")
                    
                    setElementData(client, "badgeData", false)
                    setElementData(client, "badgeExData", false)
                    
                    unuseItem(client)
                    playUseSound(client)
                else
                    safeCall("sChat", "localAction", client, "felvesz egy névkitűzőt.")
                    
                    playerBadges[client] = itemData.dbID
                    
                    setElementData(client, "badgeDataEx", false)
                    setElementData(client, "badgeExData", itemData.data1 .." # ".. itemData.data2)
                    
                    setUsedItem(client, itemData)
                    playUseSound(client)
                end
            end
        end
    end
    
    if itemListEntry.simpleUse then
        if itemListEntry.simpleUse == "firework" then
            local cX, cY, cZ = getElementPosition(client)
            
            triggerClientEvent("shootFirework", client, itemListEntry.useArg, math.random(1, 6), cX, cY, cZ, true)
            takeItem(client, "dbID", itemDBID, 1)
        end
        if itemListEntry.simpleUse == "fireCracker" then
            local waitTick = 60000
            local lastUsed = itemData.lastUsed or 0
            if lastUsed <= getTickCount() - waitTick then
                itemData.lastUsed = getTickCount()
                triggerClientEvent(client, "playFireworkSound", client, itemListEntry.useArg)
                takeItem(client, "dbID", itemDBID, 1)
            else
                outputChatBox("[color=sightred][SightMTA]: #FFFFFFCsak " .. waitTick / 1000 .. " másodpercenként használhatod a tárgyat!", client, 255, 255, 255, true)
            end
        end
        
        if itemListEntry.simpleUse == "hifi" then
            local useArg = itemListEntry.useArg
            
            local int = getElementInterior(client)
            local dim = getElementDimension(client)
            
            local playerPosition = pos
            playerPosition[4] = int
            playerPosition[5] = dim
            local playerRotation = {getElementRotation(client)}
            
            
            local hifiElement = createObject(useArg, playerPosition[1], playerPosition[2], playerPosition[3])
            setElementRotation(hifiElement, 0, 0, playerRotation[3] + 180)
            
            setElementDimension(hifiElement, dim)
            setElementInterior(hifiElement, int)
            
            if #hifiDatas then
                hifiCount = #hifiDatas or 0
            else
                hifiCount = 1
            end
            
            local radioId = hifiCount + 1
            setElementData(hifiElement, "radioId", radioId)
            
            table.insert(hifiDatas, {
                position = playerPosition,
                owner = getElementData(client, "char.dbID"),
                rotationZ = playerRotation[3] + 180,
                radioIdentity = radioId,
                radioItemId = itemData.itemId,
                element = hifiElement,
                modelId = useArg
            })
            
            saveRadioData()
            
            takeItem(client, "dbID", itemData.dbID, 1)
            
            safeCall("sChat", "localAction", client, "letett egy hifi berendezést a földre.")
            exports.sGui:showInfobox(client, "s", "Sikeresen leraktál egy HI-FI-t!")
        end
        
        if itemListEntry.simpleUse == "eat" or itemListEntry.simpleUse == "drink" or itemListEntry.simpleUse == "drug" then
            local tick = 5000
            
            local lastUsed = itemData.lastUsed or 0
            
            if lastUsed <= getTickCount() - tick or itemListEntry.simpleUse == "drug" then
                local currentItemuseState = tonumber(itemData.data1) or 0
                local oldCurrentItemuseState = currentItemuseState
                
                if itemListEntry.simpleUse == "eat" then
                    playAnimation(client, "food")
                    safeCall("sChat", "localAction", client, "evett valamit.")
                    
                    local amount = math.random(7, 20)
                    
                    local currentHunger = getElementData(client, "char.Hunger")
                    
                    if currentHunger + amount > 100 then
                        setElementData(client, "char.Hunger", 100)
                    else
                        setElementData(client, "char.Hunger", currentHunger + amount)
                    end
                    
                    local currentThirst = getElementData(client, "char.Thirst")
                    local currentHunger = getElementData(client, "char.Hunger")
                    
                    triggerClientEvent(client, "syncNeeds", client, currentHunger, currentThirst)
                    
                    currentItemuseState = currentItemuseState + 1
                elseif itemListEntry.simpleUse == "drink" then
                    playAnimation(client, "drink")
                    safeCall("sChat", "localAction", client, "ivott valamit.")
                    
                    local amount = math.random(7, 20)
                    
                    local currentThirst = getElementData(client, "char.Thirst")
                    
                    if currentThirst + amount > 100 then
                        setElementData(client, "char.Thirst", 100)
                    else
                        setElementData(client, "char.Thirst", currentThirst + amount)
                    end
                    local currentThirst = getElementData(client, "char.Thirst")
                    local currentHunger = getElementData(client, "char.Hunger")
                    
                    triggerClientEvent(client, "syncNeeds", client, currentHunger, currentThirst)
                    
                    currentItemuseState = currentItemuseState + 1
                elseif itemListEntry.simpleUse == "drug" then
                    local drugType = itemListEntry.useArg
                    
                    if exports.sDrugs:useDrug(client, drugType) then
                        if drugType == "weed" then
                            playAnimation(client, "smoke")
                        else
                            playAnimation(client, "drug")
                        end
                        
                        currentItemuseState = currentItemuseState + 1
                    end
                end
                
                itemData.lastUsed = getTickCount()
                
                if currentItemuseState ~= oldCurrentItemuseState then
                    if itemListEntry.dose then
                        if oldCurrentItemuseState == 0 then
                            if itemData.amount > 1 then
                                takeItem(client, "dbID", itemDBID, 1)
                                giveItem(client, itemId, 1, false, 1)
                            else
                                updateItemData1(client, itemDBID, currentItemuseState)
                            end
                            
                            if itemListEntry.simpleUse == "drug" then
                                local drugType = itemListEntry.useArg
                                
                                if drugType == "weed" then
                                    safeCall("sChat", "localAction", client, "meggyújt egy füves cigit, és beleszív.")
                                elseif drugType == "coke" then
                                    safeCall("sChat", "localAction", client, "felbont egy zacskó kokaint, és beleszív.")
                                elseif drugType == "para" then
                                    safeCall("sChat", "localAction", client, "felbont egy zacskó parazeldum port, és beleszív.")
                                elseif drugType == "speed" then
                                    safeCall("sChat", "localAction", client, "felbont egy zacskó speedet, és beleszív.")
                                end
                            end
                        elseif currentItemuseState < itemListEntry.dose then
                            if itemListEntry.simpleUse == "drug" then
                                local drugType = itemListEntry.useArg
                                
                                if drugType == "weed" then
                                    safeCall("sChat", "localAction", client, "beleszív egy füves cigibe.")
                                elseif drugType == "coke" then
                                    safeCall("sChat", "localAction", client, "felszív egy kis kokaint.")
                                elseif drugType == "para" then
                                    safeCall("sChat", "localAction", client, "felszív egy kis parazeldum port.")
                                elseif drugType == "speed" then
                                    safeCall("sChat", "localAction", client, "felszív egy kis speedet.")
                                end
                            end
                            
                            updateItemData1(client, itemDBID, currentItemuseState)
                        else
                            if itemListEntry.simpleUse == "drug" then
                                local drugType = itemListEntry.useArg
                                
                                if drugType == "weed" then
                                    safeCall("sChat", "localAction", client, "beleszív egy füves cigibe, majd eldobja a csikket.")
                                elseif drugType == "coke" then
                                    safeCall("sChat", "localAction", client, "felszív egy kis kokaint, eldobja az üres zacskót.")
                                elseif drugType == "para" then
                                    safeCall("sChat", "localAction", client, "felszív egy kis parazeldum port, eldobja az üres zacskót.")
                                elseif drugType == "speed" then
                                    safeCall("sChat", "localAction", client, "felszív egy kis speedet, eldobja az üres zacskót.")
                                end
                            end
                            
                            takeItem(client, "dbID", itemDBID, 1)
                        end
                    else
                        if itemListEntry.simpleUse == "drug" then
                            local drugType = itemListEntry.useArg
                            
                            if drugType == "ex" then
                                safeCall("sChat", "localAction", client, "bevesz egy tablettát.")
                            elseif drugType == "shroom" then
                                safeCall("sChat", "localAction", client, "megeszik egy gombát.")
                            elseif drugType == "lsd" then
                                safeCall("sChat", "localAction", client, "bevesz egy bélyeget a szájába.")
                            end
                        end
                        
                        takeItem(client, "dbID", itemDBID, 1)
                    end
                end
            else
                outputChatBox("[color=sightred][SightMTA]: #FFFFFFCsak " .. tick / 1000 .. " másodpercenként használhatod a tárgyat!", client, 255, 255, 255, true)
            end
        else
            local useFunction = simpleUseFunctions[itemListEntry.simpleUse]
            
            if useFunction then
                useFunction(client, itemListEntry.useArg, itemData)
            end
        end
    elseif itemListEntry.use then
        if usedItemDatas[client] and usedItemDatas[client].dbID == itemData.dbID then
            local unUseFunction = unUseFunctions[itemListEntry.use]
            
            if unUseFunction then
                unUseFunction(client, itemData)
            end
        else
            local useFunction = useFunctions[itemListEntry.use]
            
            if useFunction then
                useFunction(client, itemData)
            end
        end
    end
end)
local invIdentity = 0
addEvent("requestItems", true)
addEventHandler("requestItems", getRootElement(), function(element, ownerId, ownerType, nearbyPlayers)
    if isElement(element) then
        if ownerId and ownerType then
            local canOpenInv = true
            
            if ownerType == "vehicle" then
                if isVehicleLocked(element) then
                    canOpenInv = false
                end
            elseif ownerType == "object" then
                if storedSafes[ownerId] then
                    if storedSafes[ownerId].ownerGroup ~= "0" then
                        if not exports.sGroups:isPlayerInGroup(client, storedSafes[ownerId].ownerGroup) then
                            canOpenInv = false
                        end
                    elseif not hasItemWithData(client, 154, ownerId) then
                        canOpenInv = false
                    end
                end
            end
            
            if exports.sPermission:hasPermission(client, "createsafe") then
                canOpenInv = true
            end
            
            if not canOpenInv then
                outputChatBox("[color=sightred][SightMTA - Inventory]: #FFFFFFA kiválasztott inventory zárva van, esetleg nincs kulcsod hozzá.", client, 255, 255, 255, true)
                return
            end
            
            if isElement(inventoryInUse[element]) then
                outputChatBox("[color=sightred][SightMTA - Inventory]: #FFFFFFA kiválasztott inventory már használatban van!", client, 255, 255, 255, true)
                return
            end
            
            inventoryInUse[element] = client
            loadItems(element)
            
            if ownerType == "vehicle" then
                safeCall("sChat", "localAction", client, "belenézett a csomagtartóba.")
                
                if getVehicleType(element) == "Automobile" then
                    setVehicleDoorOpenRatio(element, 1, 1, 500)
                    triggerLatentClientEvent(nearbyPlayers, "toggleVehicleTrunk", client, "open", element)
                end
            elseif ownerType == "object" then
                invIdentity = ownerId
                triggerClientEvent(nearbyPlayers, "syncSafeDoor", client, ownerId, true)
                safeCall("sChat", "localAction", client, "belenézett a széfbe.")
            end
        end
    end
end)

addEvent("closeInventory", true)
addEventHandler("closeInventory", getRootElement(), function(element, nearby)
    if isElement(element) then
        if not inventoryInUse[element] or inventoryInUse[element] ~= client then
            return
        end
        
        inventoryInUse[element] = nil
        
        if getElementType(element) == "object" then
            triggerClientEvent(nearby, "syncSafeDoor", client, invIdentity, false)
            invIdentity = 0
        end
        
        if getElementType(element) == "vehicle" and getVehicleType(element) == "Automobile" then
            setVehicleDoorOpenRatio(element, 1, 0, 250)
            setTimer(triggerLatentClientEvent, 250, 1, nearby, "toggleVehicleTrunk", client, "close", element)
        end
    end
end)

function processPerishableItems()
    for element in pairs(itemsTable) do
        if isElement(element) then
            local elementType = getElementType(element)
            
            if elementType == "vehicle" or elementType == "object" or elementType == "player" then
                for k, v in pairs(itemsTable[element]) do
                    local itemId = v.itemId
                    
                    if itemId == 313 and elementType == "player" then
                        local clientMoney = exports.sCore:getMoney(element)
                        
                        if getRealTime().timestamp >= (v.data3 + 259200) then
                            takeItem(element, "dbID", v.dbID)
                            
                            exports.sCore:setMoney(element, clientMoney - (v.data2 * 1.5))
                            exports.sGui:showInfobox(element, "e", "Egy csekk befizetési határideje lejárt, ezért a +50%-a került levonásra!")
                        end
                    end
                    
                    if perishableItems[itemId] then
                        local value = (tonumber(v.data3) or 0) + 1
                        
                        if value - 1 > perishableItems[itemId] then
                            triggerEvent("updateData3", element, element, v.dbID, perishableItems[itemId])
                        end
                        
                        if value <= perishableItems[itemId] then
                            triggerEvent("updateData3", element, element, v.dbID, value)
                        elseif perishableEvent[itemId] then
                            triggerEvent(perishableEvent[itemId], element, v.dbID)
                        end
                    end
                end
            end
        else
            itemsTable[element] = nil
        end
    end
end

addCommandHandler("seeinv", function(sourcePlayer, sourceCommand, targetElement)
    if exports.sPermission:hasPermission(sourcePlayer, "bodySearchAdmin") then
        if targetElement then
            targetPlayer = exports.sCore:findPlayer(sourcePlayer, targetElement)
            
            if isElement(targetPlayer) then
                triggerClientEvent(sourcePlayer, "bodySearchGotDatas", sourcePlayer, itemsTable[targetPlayer], exports.sCore:getMoney(targetPlayer), getElementData(targetPlayer, "visibleName"):gsub("_", " "))
            else
                outputChatBox("[color=sightred][SightMTA - Hiba]: [color=hudwhite]Nem található felhasználó", sourcePlayer)
            end
        else
            outputChatBox("[color=sightblue][Használat]: [color=hudwhite]/"..sourceCommand.." [Játékos Név / ID]", sourcePlayer, 255, 255, 255, true)
        end
    end
end)

addCommandHandler("clearinv", function(sourcePlayer, sourceCommand, targetElement)
    if exports.sPermission:hasPermission(sourcePlayer, "clearinv") then
        if targetElement then
            targetPlayer = exports.sCore:findPlayer(sourcePlayer, targetElement)
            
            if isElement(targetPlayer) then
                local items = itemsTable[targetPlayer]
                for k, v in pairs(items) do
                    takeItem(targetPlayer, "dbID", v.dbID, v.amount)
                end
                outputChatBox("[color=sightblue][SightMTA]#ffffff Sikeresen elvetted az itemeit!", sourcePlayer)
            else
                outputChatBox("[color=sightred][SightMTA - Hiba]: [color=hudwhite]Nem található felhasználó", sourcePlayer)
            end
        else
            outputChatBox("[color=sightblue][Használat]: [color=hudwhite]/"..sourceCommand.." [Név / ID]", sourcePlayer, 255, 255, 255, true)
        end
    end
end)


function friskPlayer(sourcePlayer, sourceCommand, targetElement)
    if targetElement then
        targetPlayer = exports.sCore:findPlayer(sourcePlayer, targetElement)
        
        if isElement(targetPlayer) then
            
            local x, y, z = getElementPosition(sourcePlayer)
            local px, py, pz = getElementPosition(targetPlayer)
            
            if getDistanceBetweenPoints3D(x, y, z, px, py, pz) < 3 then
                
                if sourcePlayer == targetPlayer then
                    outputChatBox("[color=sightred][SightMTA - Hiba]: [color=hudwhite]Saját magadat nem motozhatod meg!", sourcePlayer)
                    return
                end
                safeCall("sChat", "localAction", sourcePlayer, "megmotozott valakit. (" .. getElementData(targetPlayer, "visibleName"):gsub("_", " ") .. ")")
                
                triggerClientEvent(sourcePlayer, "bodySearchGotDatas", sourcePlayer, itemsTable[targetPlayer], exports.sCore:getMoney(targetPlayer), getElementData(targetPlayer, "visibleName"):gsub("_", " "))
            else
                outputChatBox("[color=sightred][SightMTA - Hiba]: [color=hudwhite]A kiválasztott játékos túl messze van tőled!", sourcePlayer)
            end
        end
    else
        outputChatBox("[color=sightblue][Használat]: [color=hudwhite]/"..sourceCommand.." [Név / ID]", sourcePlayer, 255, 255, 255, true)
    end
end
addCommandHandler("motozas", friskPlayer)
addCommandHandler("motoz", friskPlayer)
addCommandHandler("megmotoz", friskPlayer)


addEvent("saveActionBar", true)
addEventHandler("saveActionBar", root, function(arrayOfDatabaseIds)
    triggerClientEvent(client, "gotActionBar", client, arrayOfDatabaseIds)
    if not arrayOfDatabaseIds or type(arrayOfDatabaseIds) ~= "table" then
        return
    end
    
    local charId = getElementData(client, "char.ID")
    
    if type(charId) == "number" then
        if isElement(connection) then
            dbExec(connection, "UPDATE characters SET actionBarItems = ? where characterId = ?", toJSON(arrayOfDatabaseIds, true), charId)
        end
    end
end)


addEventHandler("onPhoneGenerated", root, function(ownerId, phoneId)
    local queueEntry = queuedPhoneItems[ownerId]
    
    if queueEntry then
        local element, ownerType, ownerId, itemId, amount, slotId, data1, data2, data3 = unpack(queueEntry)
        
        if isElement(element) and itemId and amount and slotId then
            data1 = phoneId
            
            giveItemImpl(element, ownerType, ownerId, itemId, amount, slotId, data1, data2, data3)
        end
    end
end)

addEvent("takeActiveAmmo", true)
addEventHandler("takeActiveAmmo", root, function()
    local activeAmmoDBID = findSecondaryItem(source, "ammo")
    
    if activeAmmoDBID then
        local ammoData = hasItemEx(source, "dbID", activeAmmoDBID, 1)
        
        if ammoData then
            enableWeaponFire(source, true)
            takeItem(source, "dbID", activeAmmoDBID, 1)
        else
            enableWeaponFire(source, false)
        end
    else
        enableWeaponFire(source, false)
        destroyCurrentlyUsedState(source)
    end
end)

addEvent("takeProjectileAmmo", true)
addEventHandler("takeProjectileAmmo", root, function()
    if hasItemEx(client, "dbID", usedItemDatas[client].dbID, 1) then
        takeItem(client, "dbID", usedItemDatas[client].dbID, 1)
        destroyCurrentlyUsedState(client)
    end
    
end)

addEventHandler("onPlayerJoin", root, function()
    itemsTable[source] = {}
end)

addEventHandler("onPlayerQuit", root, function()
    if usedItemDatas[source] then
        usedItemDatas[source] = nil
    end
    
    if usedSecondaryItems[source] then
        usedSecondaryItems[source] = nil
    end
    if itemsTable[source] then
        for k, v in pairs(itemsTable[source]) do
            if v.itemId == 361 then
                takeItem(source, "dbID", v.dbID)
            end
            if v.itemId == 715 then
                takeItem(source, "dbID", v.dbID)
            end
            if v.itemId == 716 then
                takeItem(source, "dbID", v.dbID)
            end
            if v.itemId == 717 then
                takeItem(source, "dbID", v.dbID)
            end
            if v.data3 == "airsoft" then
                takeItem(source, "dbID", v.dbID)
            end
            if getElementData(source, "inDuty") then
                local groupDuty = string.format("duty:%s", getElementData(source, "inDuty"))
                
                if groupDuty then
                    for k, v in pairs(itemsTable[source]) do
                        if v.data3 == groupDuty then
                            takeItem(source, "dbID", v.dbID, v.amount)
                        end
                    end
                end
            end
        end
        
        if itemsTable[source] then
            itemsTable[source] = nil
        end
    end
end)

local radioDataFilePath = "radios.json"
hifiDatas = {}

function convertKeys(table)
    local newTable = {}
    for key, value in pairs(table) do
        local numericKey = tonumber(key)
        if numericKey then
            key = numericKey
        end
        
        if type(value) == "table" then
            newTable[key] = convertKeys(value)
        else
            newTable[key] = value
        end
    end
    return newTable
end


function processJson(jsonTable)
    return convertKeys(jsonTable)
end

function loadRadioData()
    local radioFile = fileExists(radioDataFilePath) and fileOpen(radioDataFilePath) or nil
    
    if radioFile then
        local radioData = fileRead(radioFile, fileGetSize(radioFile))
        fileClose(radioFile)
        hifiDatas = processJson(fromJSON(radioData)) or {}
    else
        hifiDatas = {}
    end
end

addEvent("pickupHifiRadio", true)
addEventHandler("pickupHifiRadio", getRootElement(), function(radioIdentity)
    if radioIdentity and validRadio(radioIdentity) then
        local radioDatas = hifiDatas[radioIdentity]
        exports.sItems:giveItem(client, getHifiItem(radioDatas.modelId), 1)
        exports.sChat:localAction(client, "felvesz egy rádiót a földről")
        exports.sItems:removeRadio(radioIdentity)
    else
        exports.sAnticheat:anticheatBan(client, "AC #95 - sItems @sourceS:3302")
    end
end)

function saveRadioData()
    local dataToSave = {}
    for _, radio in ipairs(hifiDatas) do
        table.insert(dataToSave, {
            position = radio.position,
            owner = radio.owner,
            radioIdentity = radio.radioIdentity,
            modelId = radio.modelId
        })
    end
    
    local radioFile = fileCreate(radioDataFilePath)
    if radioFile then
        fileWrite(radioFile, toJSON(dataToSave))
        fileClose(radioFile)
    end
end

function validRadio(radioId)
    for index, radio in pairs(hifiDatas) do
        if radio.radioIdentity == radioId then
            return true
        end
    end
    return false
end

function getRadioDatas(radioId, delete)
    return hifiDatas[radioId]
end

function removeRadio(radioId)
    for index, radio in pairs(hifiDatas) do
        if radio.radioIdentity == radioId then
            if isElement(radio.element) then
                destroyElement(radio.element)
            end
            hifiDatas[index] = nil
            saveRadioData()
            break
        end
    end
end

addEventHandler("onResourceStart", resourceRoot, function()
    for _, player in pairs(getElementsByType("player")) do
        itemsTable[source] = {}
        setElementData(player, "badgeData", false)
        setElementData(player, "badgeExData", false)
    end
    
    setTimer(processPerishableItems, 1000 * 60, 0)
    
    if fileExists("saves.json") then
        local jsonFile = fileOpen("saves.json")
        if jsonFile then
            local fileContent = fileRead(jsonFile, fileGetSize(jsonFile))
            
            fileClose(jsonFile)
            
            if fileContent then
                local jsonData = fromJSON(fileContent) or {}
                
                lastWeaponSerial = tonumber(jsonData.lastWeaponSerial)
                lastPhoneNumber = tonumber(jsonData.lastPhoneNumber)
            end
        end
    end
    
    loadRadioData()
    for _, radio in pairs(hifiDatas) do
        local hifiElement = createObject(radio.modelId, radio.position[1], radio.position[2], radio.position[3])
        setElementData(hifiElement, "radioId", radio.radioIdentity)
        setElementRotation(hifiElement, 0, 0, radio.rotationZ or 0)
        setElementInterior(hifiElement, (radio.position[4] or 0))
        setElementDimension(hifiElement, (radio.position[5] or 0))
        radio.element = hifiElement
    end
end)

addEventHandler("onResourceStop", getResourceRootElement(), function()
    for k, v in pairs(getElementsByType("player")) do
        takeAllWeapons(v)
    end
    
    if fileExists("saves.json") then
        fileDelete("saves.json")
    end
    
    local jsonFile = fileCreate("saves.json")
    if jsonFile then
        local jsonData = {}
        
        jsonData.lastWeaponSerial = tonumber(lastWeaponSerial or 0)
        jsonData.lastPhoneNumber = tonumber(lastPhoneNumber or 0)
        
        fileWrite(jsonFile, toJSON(jsonData, true, "tabs"))
        fileClose(jsonFile)
    end
end)

addEventHandler("onPlayerResourceStart", root, function(res)
    if res == getThisResource() then
        skillbooks = exports.sWeapons:getSkillBooks()
        weaponItemIds = exports.sWeapons:getWeaponItemIds()
        if getElementData(source, "loggedIn") and getElementData(source, "char.ID") then
            loadItems(source, true)
        end
    else
        local resName = getResourceName(res)
        
        if resName == "sWeapons" then
            skillbooks = exports.sWeapons:getSkillBooks()
            weaponItemIds = exports.sWeapons:getWeaponItemIds()
        end
    end
end)

addEventHandler("onElementDataChange", getRootElement(), function(dataName, oldValue, newValue)
    if dataName == "char.ID" then
        if type(newValue) == "number" then
            loadItems(source, true)
        end
    end
end)

function initSerials()
    
end

addEvent("requestCache", true)
addEventHandler("requestCache", getRootElement(), function()
    if isElement(source) then
        local characterId = getElementData(source, defaultSettings.characterId)
        
        if characterId then
            loadItems(source)
        end
    end
end)

factoryAmmoItems = {
    [743] = 542,
    [744] = 534,
    [745] = 538,
    [746] = 539,
    [747] = 537,
    [748] = 540,
    [749] = 541,
    [750] = 531,
}

craftAnimTimers = {}

addEvent("requestCrafting", true)
addEventHandler("requestCrafting", getRootElement(), function(selectedRecipe)
    if isElement(source) and source == client then
        if availableRecipes and availableRecipes[selectedRecipe] then
            local requiredItems = availableRecipes[selectedRecipe][2]
            
            local group = availableRecipes[selectedRecipe][4]
            
            local factory = availableRecipes[selectedRecipe][5]
            
            local finalItem = {
                itemId = availableRecipes[selectedRecipe][3][1],
                count = availableRecipes[selectedRecipe][3][2],
                minState = availableRecipes[selectedRecipe][3][3],
                maxState = availableRecipes[selectedRecipe][3][4]
            }
            
            finalItemState = availableRecipes[selectedRecipe][3][2]
            
            local permitted = true
            if group then
                if not exports.sGroups:getPlayerPermission(client, "craft:" .. finalItem.itemId) then
                    permitted = false
                end
            end
            
            local openingPosition = false

            if getElementData(client, "currentlyCrafing") or isTimer(craftAnimTimers[client]) then
                return
            end

            local x, y, z = getElementPosition(client)

            if factory and factory ~= "hydraulic" then
                if getNearestPoint(client, x, y, z) or isElementInRange(client, baseX - 7.2321, baseY - 19.3982, baseZ + 0.4747, 6) then
                    if isElementInRange(client, baseX - 7.2321, baseY - 19.3982, baseZ + 0.4747, 6) then
                        openingPosition = "garage_" ..getElementDimension(client)
                    else
                        openingPosition = getNearestPoint(client, x, y, z)
                    end
                end
                if not openingPosition then
                    permitted = false
                end
            end

            if factory and factory == "hydraulic" then
                local nearestPoint = exports.sAmmo:getNearestPressMachine(client, x, y, z)
                if nearestPoint then
                    openingPosition = nearestPoint
                end
                if not openingPosition then
                    permitted = false
                end
            end

            if openingPosition and tonumber(openingPosition) and exports.sAmmo:isPressOccupied(openingPosition) then
                permitted = false
                exports.sGui:showInfobox(client, "e", "Ez a gép foglalt!")
            end
            
            if permitted then
                for k, v in pairs(requiredItems) do
                    for _, itemId in pairs(v) do
                        if itemId then
                            if hasItem(client, itemId) then

                                local items = exports.sItems:getElementItems(client)

                                for key, value in pairs(items) do
                                    if value.itemId == itemId and not newItemList[itemId].craftDoNotTake then
                                        exports.sItems:takeItem(client, "dbID", value.dbID, 1)
                                        break
                                    end
                                end
                            else
                                permitted = false
                            end
                        end
                    end
                end
            end
            if factory and factory == "hydraulic" and permitted and openingPosition and tonumber(openingPosition) then
                triggerEvent("requestHydraulicPress", client, openingPosition, factoryAmmoItems[finalItem.itemId])
                triggerClientEvent(client, "requestCrafting", client, selectedRecipe, permitted, true)
                setElementData(client, "currentlyCrafing", true)
            else
                if permitted then
                    setPedAnimation(client, "GANGS", "prtial_gngtlkE", -1, true, false, false, false)
                    craftAnimTimers[client] = setTimer(function(client)
                        if isElement(client) then
                            setPedAnimation(client)
                            setElementData(client, "currentlyCrafing", false)
                        end
                    end, 10000, 1, client)
                    triggerClientEvent(client, "requestCrafting", client, selectedRecipe, permitted)
                end
            end
            if permitted and factory ~= "hydraulic" then

                local rand = finalItem.maxState and math.random(finalItem.minState, finalItem.maxState)
                giveItem(client, finalItem.itemId, finalItem.count, false, rand)
            end
        end
    end
end)

function enableWeaponFire(source, state)
    if state then
        if playerNoAmmo[source] then
            sightexports.sControls:toggleControl(source, {"fire", "vehicle_fire", "action"}, true, "items")
            playerNoAmmo[source] = false
        end
    else
        if not playerNoAmmo[source] then
            sightexports.sControls:toggleControl(source, {"fire", "vehicle_fire", "action"}, false, "items")
            playerNoAmmo[source] = true
        end
    end
end

addEventHandler("onPlayerWasted", getRootElement(), function()
    destroyCurrentlyUsedState(source)
    unuseSecondaryItems(source)
    
    if itemsTable[source] then
        for k, v in pairs(itemsTable[source]) do
            if v.itemId == 361 then
                takeItem(source, "dbID", v.dbID)
            end
            if v.itemId == 715 then
                takeItem(source, "dbID", v.dbID)
            end
            if v.itemId == 716 then
                takeItem(source, "dbID", v.dbID)
            end
            if v.itemId == 717 then
                takeItem(source, "dbID", v.dbID)
            end
        end
    end
end)

addEvent("useWeaponSkillBook", true)
addEventHandler("useWeaponSkillBook", getRootElement(), function(dbID)
    if client == source then
        local itemData = hasItemEx(client, "dbID", dbID)
        
        if itemData then
            local skillStat = getElementData(client, "char.skills") or {}
            local skillForWeapons = skillbooks[itemData.itemId]
            
            local update = false
            
            for i = 1, #skillForWeapons do
                local weapon = skillForWeapons[i]
                
                if (skillStat[weapon] or 0) < 100 then
                    skillStat[weapon] = 100
                    update = true
                end
            end
            
            if update then
                setElementData(client, "char.skills", skillStat)
                dbExec(connection, "UPDATE characters SET skills = ? WHERE characterId = ?", toJSON(skillStat, true), getElementData(client, "char.ID"))
                
                takeItem(client, "dbID", itemData.dbID, 1)
                exports.sChat:localAction(client, "beleolvas egy mesterkönyvbe. (" .. getItemName(itemData.itemId) .. ")")
                exports.sGui:showInfobox(client, "s", "Sikeresen elhasználtad a mesterkönyvet!")
        
            else
                exports.sGui:showInfobox(client, "e", "Ezt a mesterkönyvet te már kiolvastad egyszer!")
            end
        end
    else
        exports.sAnticheat:anticheatBan(client, "AC #96 - sItems @sourceS:3588")
    end
end)

addEvent("useFishingLine", true)
addEventHandler("useFishingLine", getRootElement(), function(lineDbID, rodDbID)
    local lineItemData = hasItemEx(client, "dbID", lineDbID)
    local rodItemData = hasItemEx(client, "dbID", rodDbID)
    
    if lineItemData and rodItemData then
        if newItemList[rodItemData.itemId].use == "fishingRod" and newItemList[lineItemData.itemId].fishingLine then
            updateItemData1(client, rodDbID, newItemList[lineItemData.itemId].fishingLine)
            updateItemData2(client, rodDbID, 0)
            takeItem(client, "dbID", lineDbID, 1)
            safeCall("sChat", "localAction", client, "felszerelt egy tekercs " .. string.lower(newItemList[lineItemData.itemId].name) .. "t a horgászbotjára (" .. newItemList[rodItemData.itemId].name .. ").")
        else
            exports.sAnticheat:anticheatBan(client, "AC #97 - sItems @sourceS:3604")
        end
    end
end)

addEvent("useFishingFloater", true)
addEventHandler("useFishingFloater", getRootElement(), function(floaterDbID, rodDbID)
    local floaterItemData = hasItemEx(client, "dbID", floaterDbID)
    local rodItemData = hasItemEx(client, "dbID", rodDbID)
    
    if floaterItemData and rodItemData then
        if newItemList[rodItemData.itemId].use == "fishingRod" and newItemList[floaterItemData.itemId].fishingFloat then
            if rodItemData.data1 then
                updateItemData3(client, rodDbID, newItemList[floaterItemData.itemId].fishingFloat)
                takeItem(client, "dbID", floaterDbID, 1)
                safeCall("sChat", "localAction", client, "felszerelt egy úszót a horgászbotjára (" .. newItemList[rodItemData.itemId].name .. ").")
            else
                exports.sGui:showInfobox(client, "e", "Előbb fel kell szerelni damillal a horgászbotod.")
            end
        else
            exports.sAnticheat:anticheatBan(client, "AC #98 - sItems @sourceS:3624")
        end
    end
end)

function damageFishingLine(client, rodDbID, tear)
    local rodItemData = hasItemEx(client, "dbID", rodDbID)
    
    if rodItemData then
        if newItemList[rodItemData.itemId].use == "fishingRod" then
            local wear = rodItemData.data2 + math.random(7, 15)
            
            if wear >= 100 then
                updateItemData1(client, rodDbID, false)
                updateItemData3(client, rodDbID, false)
                setElementData(client, "usingFishingRodLine", false)
                setElementData(client, "usingFishingRodFloat", false)
                exports.sFishing:removePlayerBait(client)
            elseif not tear then
                updateItemData2(client, rodDbID, wear)
            elseif tear then
                updateItemData3(client, rodDbID, false)
                setElementData(client, "usingFishingRodFloat", false)
                exports.sFishing:removePlayerBait(client)
            end
            
            triggerClientEvent(getRootElement(), "damageFishingLineSound", client)
        else
            exports.sAnticheat:anticheatBan(client, "AC #99 - sItems @sourceS:3652")
        end
    end
end

addEvent("damageFishingLine", true)
addEventHandler("damageFishingLine", getRootElement(), function(rodDbID, tear)
    if source == client then
        damageFishingLine(client, rodDbID, tear)
    else
        exports.sAnticheat:anticheatBan(client, "AC #100 - sItems @sourceS:3662")
    end
end)

addEvent("damageMyShield", true)
addEventHandler("damageMyShield", getRootElement(), function()
    if source == client then
        itemdbID = usedItemDatas[client].dbID
        if itemdbID then
            shieldHP = tonumber(getItemData1(client, itemdbID)) or 0
            updateItemData1(client, itemdbID, shieldHP + 10)
            if (shieldHP or 0) >= 100 then
                triggerClientEvent(getRootElement(), "onShieldDestroy", client)
                exports.sControls:toggleControl(client, {
                    "jump",
                    "sprint",
                    "jog",
                    "fire"
                }, true, "sShield")
                takeItem(client, "dbID", itemdbID, 1)
                unuseItem(client)
                setElementData(client, "shield", false)
            end
        end
    end
end)

function getLastWeaponSerial()
    return lastWeaponSerial
end

function formatSerial(itemId, serial)
    local currentWeaponSerial = tonumber(serial) or 0
    local theType = serialItems[itemId] or "-"
    if itemId == 361 then
        return theType .. currentWeaponSerial
    else
        return "W" .. currentWeaponSerial .. theType
    end
end

function addWeaponWarn(sourcePlayer, commandName, weaponSerial)
    if exports.sPermission:hasPermission(commandName) or exports.sGroups:isPlayerInGroup(sourcePlayer, "PD") or exports.sGroups:isPlayerInGroup(sourcePlayer, "NAV") or exports.sGroups:isPlayerInGroup(sourcePlayer, "NNI") or exports.sGroups:isPlayerInGroup(sourcePlayer, "TEK") then
        if not weaponSerial then
            outputChatBox("[color=sightblue][SightMTA - Használat]: [color=hudwhite]/"..commandName.." [Sorozatszám]", sourcePlayer, 255, 255, 255, true)
        else
            for k, v in ipairs(getElementsByType("player")) do
                for k2, v2 in pairs(itemsTable[v]) do
                    if v2.serial == tonumber(weaponSerial) then
                        updateItemData2(v, v2.dbID, ((v2.data2 or 0) + 1))
                    end
                end
            end
        end     
    end
end
addCommandHandler("addweaponwarn", addWeaponWarn)
addCommandHandler("addfigyu", addWeaponWarn)

addEvent("injectionPlayerSelected", true)
addEventHandler("injectionPlayerSelected", root, 
function(selectedPlayer)
    if isElement(selectedPlayer) then
        setElementHealth(selectedPlayer, 100)
        exports.sItems:takeItem(client, "itemId", 612, 1)
    end
end
)

function getItemDetails(playerElement, dbID)
    local items = exports.sItems:getElementItems(playerElement)

    if items then
        for k, v in pairs(items) do
            if v.dbID == dbID then
                return v.itemId, v.amount, tonumber(v.data1) or 0
            end
        end
    end
end

local illegalItemPrices = {
    [493] = 50000 --Glock
}

addEvent("deleteIllegalItemFromPlayer", true)
addEventHandler("deleteIllegalItemFromPlayer", root, function(playerGroup, dbId)
    if client and client == source then
        if exports.sGroups:isGroupValid(playerGroup) and exports.sGroups:isLawEnforcementGroup(playerGroup) then
            if exports.sGroups:isPlayerInGroup(client, playerGroup) then
                local itemId, itemAmount, itemHealth = getItemDetails(client, dbId)
                local itemName = getItemName(itemId)
                local basePrice = (illegalItemDropoffs[itemId] or 5000) * itemAmount
                local condition = math.max(100 - itemHealth, 10)
                if exports.sWeapons:isSkinItemId(itemId) then
                    condition = 100                    
                end

                basePrice = basePrice * (condition / 100)


                exports.sGroups:giveGroupBalance(playerGroup, basePrice)
                exports.sGroups:sendGroupMessage(client, "department", _, _, "[color=sightblue][SightMTA - Illegális tárgyak ("..exports.sGroups:getGroupName(playerGroup)..")]:[color=hudwhite] "..getElementData(client, "char.name"):gsub("_", " ").." leadott "..itemAmount.."db "..itemName..""..(not exports.sWeapons:isSkinItemId(itemId) and " ("..(100-itemHealth).."%) " or " ").."tárgyat. [color=sightgreen]("..exports.sGui:thousandsStepper(basePrice).." $)")
                outputChatBox("[color=sightblue][SightMTA - Illegális tárgyak ("..exports.sGroups:getGroupName(playerGroup)..")]: [color=hudwhite]Leadtad a következő tárgyat: "..itemAmount.."db "..itemName .. (not exports.sWeapons:isSkinItemId(itemId) and " ("..(100-itemHealth).."%) " or " "), client)
                takeItem(client, "dbID", dbId, itemAmount)
            end
        end
    else
        exports.sAnticheat:anticheatBan(client, "AC #101 - sItems @sourceS:3742")
    end
end)