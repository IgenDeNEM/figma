local drugTimers = {}
local drugUseDisabled = {}
local rampages = {}
local enablePlayerDrugUseTimers = {}

function useDrug(player, drugType)
    if isElement(player) then
        if not drugUseDisabled[player] then
            if not rampages[player] or rampages[player][2] == drugType then
                if not rampages[player] then
                    rampages[player] = {0.001, drugType}
                end

                if not drugTimers[player] then
                    drugTimers[player] = {}
                end

                local now = getTickCount()
                local drugTable = drugTypes[drugType]

                table.insert(drugTimers[player], {
                    drug = drugType,
                    drugTakeTick = now,
                    startTime = drugTable.startTime * 60,
                    buildTime = drugTable.buildTime * 60,
                    maxTime = drugTable.maxTime * 60,
                    downTime = drugTable.downTime * 60,

                    drugBuildPerSecond = drugTable.rampagePerItem / (drugTable.buildTime * 60),
                    drugDownPerSecond = drugTable.rampagePerItem / (drugTable.downTime * 60)
                })

                drugUseDisabled[player] = true
                enablePlayerDrugUseTimers[player] = setTimer(enablePlayerDrugUse, drugTable.takeTime * 60000, 1, player)

                return true
            else
                exports.sGui:showInfobox(player, "e", "Csak egy féle drogot fogyaszthatsz!")
            end
        else
            exports.sGui:showInfobox(player, "e", "Még nem fogyaszthatod!")
        end
    end

    return false
end

function enablePlayerDrugUse(player)
    drugUseDisabled[player] = false
end

function isPlayerDrugUseEnabled(player)
    return not drugUseDisabled[player]
end

function getPlayerRampage(player)
    local dose, type = 0, false

    if rampages[player] then
        dose, type = unpack(rampages[player])
    end

    return dose, type
end

function setPlayerRampage(player, drugType, dose)
    if isElement(player) then
        dose = math.max(0, dose)

        if dose == 0 then
            rampages[player] = nil
            drugType = false
        else
            rampages[player] = {dose, drugType}
        end

        triggerClientEvent(player, "refreshDrugDose", player, (dose == 0 and false) or drugType, dose, 0.2)
    end
end

function processDrugTimers()
    local now = getTickCount()

    for player, drugs in pairs(drugTimers) do
        local dose, drugType = 0, 0

        for i = 1, #drugs do
            local drug = drugs[i]
            
            if drug then
                if drug.startTime > 0 then
                    drug.startTime = drug.startTime - 1
                elseif drug.buildTime > 0 then
                    drug.buildTime = drug.buildTime - 1
                    if not rampages[player] then
                        rampages[player] = {0.001, drug.drug}
                    end
                    rampages[player][1] = math.min(1, rampages[player][1] + drug.drugBuildPerSecond)
                elseif drug.maxTime > 0 then
                    drug.maxTime = drug.maxTime - 1
                elseif drug.downTime > 0 then
                    drug.downTime = drug.downTime - 1
                    if not rampages[player] then
                        rampages[player] = {0, drug.drug}
                    end
                    rampages[player][1] = math.max(0, rampages[player][1] - drug.drugDownPerSecond)

                    if rampages[player][1] <= 0 then
                        rampages[player] = nil
                    end
                else
                    table.remove(drugs, i)
                end
            end

            dose, drugType = getPlayerRampage(player)
        end

        if dose <= 0 then
            drugType = false
            dose = 0
        end
        triggerClientEvent(player, "refreshDrugDose", player, drugType, dose, 1)
    end
end

function getDrugTable()
    return drugTypes
end

addCommandHandler("setdose", function(sourcePlayer, commandName, targetPlayer, drugType, dose)
    if exports.sPermission:hasPermission(sourcePlayer, "setdose") then
        if drugTypes[drugType] and tonumber(dose) then
            dose = math.min(100, math.max(0, tonumber(dose))) / 100
            targetPlayer, targetName = exports.sCore:findPlayer(sourcePlayer, targetPlayer)

            if isElement(targetPlayer) then
                drugTimers[targetPlayer] = {}

                local drugTable = drugTypes[drugType]

                table.insert(drugTimers[targetPlayer], {
                    drug = drugType,
                    
                    startTime = 0,
                    buildTime = 0,
                    maxTime = drugTable.maxTime * 60,
                    downTime = drugTable.downTime * 60,

                    drugDownPerSecond = drugTable.rampagePerItem * (drugTable.downTime / 60)
                })
                
                setPlayerRampage(targetPlayer, drugType, dose)
            end
        else
            outputChatBox("[color=sightblue][SightMTA - Használat]: [color=hudwhite]/" .. commandName .. " [Játékos Név / ID] [Típus (shroom, lsd, weed, coke, para, speed, ex)] [Dózis (0 - 100)]", sourcePlayer)
        end
    end
end)

addEventHandler("onPlayerQuit", getRootElement(), function()
    if isTimer(enablePlayerDrugUseTimers[source]) then
        killTimer(enablePlayerDrugUseTimers[source])
    end

    drugTimers[source] = nil
    drugUseDisabled[source] = nil
    rampages[source] = nil
    enablePlayerDrugUseTimers[source] = nil
end)

addEventHandler("onPlayerWasted", getRootElement(), function()
    setPlayerRampage(source, false, 0)
end)

addEventHandler("onResourceStart", getRootElement(), function(res)
    if res == getThisResource() then
        setTimer(processDrugTimers, 1000, 0)
    end
end)