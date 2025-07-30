local squads = {}

addEvent("requestSquads", true)
addEventHandler("requestSquads", root,
    function ()
        triggerClientEvent(client, "refreshSquads", client, squads)
    end
)

local openTick = {}

addEvent("tryToOpenMDCInCar", true)
addEventHandler("tryToOpenMDCInCar", root,
    function ()
        local veh = getPedOccupiedVehicle(client)

        if veh then
            local canOpenMDC = exports.sGroups:getPlayerPermission(client, "mdc")

            if (openTick[client] or 0) + 5000 >= getTickCount() then
                exports.sGui:showInfobox(client, "e", "Csak 5 másodpercenként nyithatod/zárhatod be az MDC-t.")
                triggerClientEvent(client, "mdcLaunchFailed", client)
                return
            end
            openTick[client] = getTickCount()

            local vehicleGroup = getElementData(veh, "vehicle.group")
            if vehicleGroup then
                if not exports.sGroups:isLawEnforcementGroup(vehicleGroup) then
                    exports.sGui:showInfobox(client, "e", "Csak frakciójárművekben használhatod az MDC-t.")
                    triggerClientEvent(client, "mdcLaunchFailed", client)
                    canOpenMDC = false
                    return 
                end
            end

            if not sirenPositions[getElementModel(veh)] then
                exports.sGui:showInfobox(client, "e", "Ezzel a járművel nem használhatod az MDC-t.")
                triggerClientEvent(client, "mdcLaunchFailed", client)
                canOpenMDC = false
                return
            end


            if canOpenMDC then
                local squadName = ""

                if squads[veh] then
                    squadName = squads[veh][2]
                end

                triggerClientEvent(client, "launchMDC", client, veh, squadName)  
            end
        end
    end
)

addEvent("tryToOpenMDCOnFoot", true)
addEventHandler("tryToOpenMDCOnFoot", root, 
    function ()
        local canOpenMDC = exports.sGroups:getPlayerPermission(client, "mdc")

        if canOpenMDC then
            triggerClientEvent(client, "launchMDC", client) 
        end
    end
)

addEvent("changeMDCSquad", true)
addEventHandler("changeMDCSquad", root,
    function (squad, color)
        local veh = getPedOccupiedVehicle(client)

        if veh then
            local group = getElementData(veh, "vehicle.group")

            if not group then
                if not exports.sGroups:isLawEnforcementGroup(group) then
                    exports.sGui:showInfobox(client, "e", "Ez a jármű nincs rendvédelmi frakcióban!")
                    return
                end
            end

            squads[veh] = {group, squad, color}
            triggerClientEvent("refreshSquad", veh, squads[veh])
            triggerClientEvent("refreshSquads", client, squads)
        end
    end
)

addEvent("toggleMDCSquad", true)
addEventHandler("toggleMDCSquad", root,
    function (state)
        local veh = getPedOccupiedVehicle(client)
        local squadData = squads[veh]

        if squadData then
            if squadData[4] then
                squadData[4] = false
            end

            if state then
                triggerClientEvent("refreshSquad", veh, state and squadData or false)
                triggerClientEvent("refreshSquads", client, squads)
            else
                triggerClientEvent("refreshSquads", client, squads)
                triggerClientEvent("refreshSquad", veh, state and squadData or false)
            end
        end
    end
)

local backupTicks = {}

function squadBackup()
    local veh = getPedOccupiedVehicle(client)
    local squadData = squads[veh]

    if squadData then
        if (backupTicks[client] or 0) + 5000 > getTickCount() then
            exports.sGui:showInfobox(client, "e", "Csak 5 másodpercenként hívhatsz erősítést!") 
            return
        end
    
        backupTicks[client] = getTickCount()

        squadData[4] = not squadData[4]
        
        triggerClientEvent("refreshSquad", veh, squadData)
    end
end
addEvent("mdcSquadBackup", true)
addEvent("mdcSquadToggleBackup", true)
addEventHandler("mdcSquadBackup", root, squadBackup)
addEventHandler("mdcSquadToggleBackup", root, squadBackup)