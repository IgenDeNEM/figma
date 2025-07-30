damageParts = {
    [5] = 1,
    [6] = 2,
    [7] = 3,
    [8] = 4,
}

addEvent("vehicleDamage", true)
addEventHandler("vehicleDamage", getRootElement(),
	function (loss)
        if client and client ~= source then
            return
        end
        local veh = getPedOccupiedVehicle(source)
        if veh and isElement(veh) then
            for k, v in pairs(getVehicleOccupants(veh)) do
                local hp = getElementHealth(v)
                
                if getElementData(v, "seatBelt") then
                    dmgLoss = (loss / 4)
                    setElementHealth(v, hp - (loss / 4))
                else
                    dmgLoss = (loss / 2)
                    setElementHealth(v, hp - (loss / 2))
                end
                
                if getElementHealth(v) - dmgLoss < 0 then
                    setElementData(v, "customDeath", "Autóbaleset")
                    setElementData(v, "deathReason", "Autóbaleset")
                end

                setElementHealth(v, hp - dmgLoss)
            end
        end

        local veh = getPedOccupiedVehicle(source)
        if veh then
            if getElementHealth(veh) < 700 then
                setElementData(veh, "vehradio.broken", true)
            end
        end
        if veh then
            triggerEvent("getVehicleCheckEngineLevel", veh)
            for k, v in pairs(getVehicleOccupants(getPedOccupiedVehicle(client))) do
                if loss > 140 then
                    lastDamage2 = math.random(5, 8)
                    if lastDamage2 == 5 then
                        triggerClientEvent(v, "showInfobox", v, "warning", "Megsérült a bal kezed!")
                    elseif lastDamage2 == 6 then
                        triggerClientEvent(v, "showInfobox", v, "warning", "Megsérült a jobb kezed!")
                    elseif lastDamage2 == 7 then
                        triggerClientEvent(v, "showInfobox", v, "warning", "Megsérült a bal lábad!")
                    elseif lastDamage2 == 8 then
                        triggerClientEvent(v, "showInfobox", v, "warning", "Megsérült a jobb lábad!")
                    end
                    local damages = getElementData(v, "bodyDamage") or {}
                    damages[damageParts[lastDamage2]]  = true
                    setElementData(v, "bodyDamage", damages)
                end
            end
        end
	end
)

local waterProofVehicles = {
    [472] = true,
    [473] = true,
    [493] = true,
    [595] = true,
    [484] = true,
    [430] = true,
    [453] = true,
    [452] = true,
    [446] = true,
    [454] = true,
    [460] = true,
    [447] = true,
    [539] = true,
}

addEvent("checkWaterDamage", true)
addEventHandler("checkWaterDamage", root, 
    function()
        local clientVehicle = getPedOccupiedVehicle(client)
       
        if waterProofVehicles[getElementModel(clientVehicle)] then
            return
        end

        if clientVehicle then
            setElementHealth(clientVehicle, 320)
            setElementData(clientVehicle, "vehicle.batteryCharge", 0)
            setElementData(clientVehicle, "vehicle.maxBatteryCharge", 0)

            setElementData(clientVehicle, "vehicle.engine", false)
            setElementData(clientVehicle, "vehicle.gear", "N")
            setElementData(clientVehicle, "vehicle.ignition", false)
            setVehicleEngineState(clientVehicle, false)

            setElementData(clientVehicle, "vehradio.menu", "off")
            setElementData(clientVehicle, "vehradio.state", false)
            
            setElementData(clientVehicle, "vehicle.batteryRate", 0)

            setElementData(clientVehicle, "vehicle.startTime", nil)
            setElementData(clientVehicle, "vehicle.startDistance", nil)

            exports.sGui:showInfobox(client, "w", "Mivel vízbe hajtottál, lerobbant a járműved!")
        end
    end
)

addEvent("setVehicleAnimAnimation", true)
addEventHandler("setVehicleAnimAnimation", getRootElement(),
	function()
		if client then
			setPedAnimation(client, "ped", "car_dead_lhs", -1, false, false, false)
		end
	end
)

function destroyPlayerPed(targetElement)
    if targetElement and getElementType(targetElement) == "player" then
        if deathPeds[targetPlayer] then
            x, y, z = getElementPosition(deathPeds[targetPlayer])
           int = getElementInterior(deathPeds[targetPlayer])
           dim = getElementDimension(deathPeds[targetPlayer])
           rot = getPedRotation(deathPeds[targetPlayer])
       end

       if isElement(deathPeds[targetPlayer]) then
           destroyElement(deathPeds[targetPlayer])
       end

       deathPeds[targetPlayer] = nil
    end
end

addEvent("onPlayerStartAnim", true)
addEventHandler("onPlayerStartAnim", getRootElement(),
	function()
		local veh = getPedOccupiedVehicle(client)
      	
      	if veh then
        	setPedAnimation(client, "ped", "car_dead_lhs", -1, false, false, false)
      	end	
	end
)

addEvent("useMedicPed", true)
function useMedicPed()
    local money = exports.sCore:getMoney(client)
    if money >= 5000 then
        setElementData(client, "bodyDamage", false)
        setElementData(client, "bloodDamage", false)
        setElementHealth(client, 100)
        triggerClientEvent(client, "showInfobox", client, "success", "Sikeresen meggyógyítottad magad!")
        exports.sCore:setMoney(client, money - 5000)
    else
        triggerClientEvent(client, "showInfobox", client, "error", "Nincs elég pénzed!")
    end
end
addEventHandler("useMedicPed", root, useMedicPed)