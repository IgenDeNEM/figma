local threateningPlayer = false
local goldrobDatas = {
    Opened = false,
    Doors = {
        BackDoor = false, -- // * gotGoldrobBackDoorOpen
        GarageDoor = false, -- // * gotGoldrobGarageOpen 
        InsideDoor = false, -- // * goldrobGotInsideDoor
        RoofDoor = false, -- // * gotGoldrobRoofDoorOpen
        SafeDoor = false, -- // * 
        canOpenSafeDoor = false, -- // goldrobDatas.Doors.canOpenSafeDoor
    },
    Teimo = {
        Objects = {},
        ArrivalPositions = {
            [1] = {624.45495605469, -1628.6354980469, 16.208955764771}, -- // * Manager
            [2] = {624.45495605469, -1628.6354980469 + (2 * 1), 16.208955764771}, -- // * Worker #1
            [3] = {624.45495605469, -1628.6354980469 + (2 * 2), 16.208955764771}, -- // * Worker #2
            [4] = {624.45495605469, -1628.6354980469 + (2 * 3), 16.208955764771}, -- // * Worker #3
            [5] = {624.45495605469, -1628.6354980469 + (2 * 4), 16.208955764771}, -- // * Worker #4
            [6] = {624.45495605469, -1628.6354980469 + (2 * 5), 16.208955764771}, -- // * Worker #5
        },
        State = false, 
    },
    Elevator = {
        Pos = "up",
        Moving = false,
        Object = nil
    }, 
    Alarm = {
        State = false,
        Muted = false,
    },
    TeimoPeds = {
        managerPosition = {574.89978027344, -1636.4979248047, 16.649925231934},
        threatenedManager = false, --Visszarakni majd resetgoldrobbnal [x]
    },
    ElementStates = { 
        Garage = {
            garageKeypad = false, --gotGoldrobGarageKeypadState goldrobDatas.ElementStates.Garage.garageKeypad
            objectElement = nil, --gotGoldrobGarageOpen
            garageAlarm = false, --gotGoldrobGarageAlamr
        },
        insideKeypad = "notinuse", 
    }, 
    Security = {
        Vehicles = {},
        Code = {},
        SecDigits = {},
        CurrentDigs = {},
        CarGPS = {},
        CarAlert = {},
        SecuriTimers = {},
        StolenCounter = {},
        timerCounter = {}
    },
    Crate = {
        Crates = {},
        GoldCrates = {},
    },
    laserDeactivated = false,
    Code = math.random(1, 9)..math.random(1, 9)..math.random(1, 9)..math.random(1, 9)
} 

local devMode = false
if devMode then
    print("DEVMODE ACTIVE")
end

local garageDatas = {
    closedPosition = {-1770.12890625, 984.75756835938, 23.5078125 + 1.8, 0, 0, 90},
    openPosition = {-1770.12890625, 984.75756835938, 23.5078125 + 1.8 - 6, 0, 0, 90}
}

local playerCrates = {}
local goldCrates = {}
local alertedRob = false

function goldrobStarted()
    if not alertedRob then
        alertedRob = true
        goldrobDatas.Doors.canOpenSafeDoor = true

        triggerClientEvent("syncGoldrobBigDoorOpen", root, false, false, goldrobDatas.Doors.canOpenSafeDoor)
        local robberPlayers = {}
        for k, v in pairs(getElementsByType("player")) do
            if isElementWithinColShape(v, bankFearCol) then
                table.insert(robberPlayers, v)
            end
        end
    
        local robbingPlayerValue = ""
        for k, v in pairs(robberPlayers) do
            if k ~= #robberPlayers then
                robbingPlayerValue = robbingPlayerValue .. getElementData(v, "visibleName"):gsub("_", " ") .. " - " .. getElementData(v, "playerID") .. " - " .. getElementData(v, "char.ID") .. "\n"
            else
                robbingPlayerValue = robbingPlayerValue .. getElementData(v, "visibleName"):gsub("_", " ") .. " - " .. getElementData(v, "playerID") .. " - " .. getElementData(v, "char.ID")
            end
        end
    
        local embedDatas = {
            username = "SightMTA - Bank [Bank rablás]",
            title = "Egy csoport éppen kirabolja az aranybankot!",
            color = "sightred",
        
            embedData = {
                embedFields = {
                    {
                        name = "Játékosok neve - [ID] - [ACC ID]",
                        value = "```"..robbingPlayerValue.."```",
                        inline = true
                    },
                    {
                        name = "Bankban tartozkodók száma",
                        value = "```"..#robberPlayers.."```",
                        inline = true,
                    },
                },
            },
        }
        exports.sAnticheat:sendEmbedMessage(embedDatas, "atm")

        resetGoldrob()
    end
end

local function getDelayUntilNextCycle()
    local rt = getRealTime()
    local currentSeconds = rt.hour * 3600 + rt.minute * 60 + rt.second
    local nextCycleHour = math.floor(rt.hour / 4) * 4 + 4
    if nextCycleHour >= 24 then
        nextCycleHour = 24
    end
    local targetSeconds = nextCycleHour * 3600
    local delaySeconds = targetSeconds - currentSeconds
    if delaySeconds < 0 then
        delaySeconds = delaySeconds + 24 * 3600
    end
    return delaySeconds * 1000
end

function resetGoldrob(instant)
    if instant then
        goldrobDatas.Alarm.State = false
        goldrobDatas.Alarm.Muted = false
        goldrobDatas.Alarm.NPCDuck = false
        goldrobDatas.Alarm.NPCFear = false
    
        goldrobDatas.Doors.BackDoor = false
        goldrobDatas.Doors.GarageDoor = false
        goldrobDatas.Doors.InsideDoor = false
        goldrobDatas.Doors.RoofDoor = false
        goldrobDatas.Doors.SafeDoor = false
        goldrobDatas.Doors.canOpenSafeDoor = false
    
        goldrobDatas.ElementStates.Garage.garageKeypad = false
        goldrobDatas.ElementStates.Garage.garageAlarm = false
        goldrobDatas.ElementStates.insideKeypad = "notinuse"
    
        goldrobDatas.laserDeactivated = false
        goldrobDatas.Opened = false
    
        for pedIndex, pedElement in pairs(goldrobDatas.TeimoPeds) do
            if pedElement and isElement(pedElement) then
                destroyElement(pedElement)
            end
        end
        goldrobDatas.TeimoPeds = {}
        goldrobDatas.TeimoPeds.managerPosition = {574.89978027344, -1636.4979248047, 16.649925231934}
    
        playerCrates = {}
        goldCrates = {}
        floorCrates = {}
        cuttedBars = 0
        playerHeating = {}
        heatedBars = {}
        loots = {}
    
        for k, v in pairs(goldrobDatas.Security.Vehicles) do
            if v and isElement(v) then
                setElementData(v, "bankrob.robbedcar", false)
                goldrobDatas.Security.Code[v] = {math.random(1, 9), math.random(1, 9), math.random(1, 9), 1}
                goldrobDatas.Security.SecDigits[v] = {0, 0, 0, 0}
                goldrobDatas.Security.CurrentDigs[v] = 1
                goldrobDatas.Security.CarGPS[v] = false
                goldrobDatas.Security.CarAlert[v] = false
                goldrobDatas.Security.StolenCounter[v] = 0
                if goldrobDatas.Security.SecuriTimers[v] and isTimer(goldrobDatas.Security.SecuriTimers[v]) then
                    killTimer(goldrobDatas.Security.SecuriTimers[v])
                end
                goldrobDatas.Security.SecuriTimers[v] = false
            end
        end
    
        triggerClientEvent("gotGoldrobBankOpen", root, goldrobDatas.Opened)
        triggerClientEvent("gotGoldrobAlarmState", root, goldrobDatas.Alarm.State, goldrobDatas.Alarm.Muted)
        triggerClientEvent("gotGoldrobNPCDuck", root, goldrobDatas.Alarm.NPCDuck)
        triggerClientEvent("gotGoldrobNPCFear", root, goldrobDatas.Alarm.NPCFear)
        triggerClientEvent("gotGoldrobBackDoorOpen", root, goldrobDatas.Doors.BackDoor)
        triggerClientEvent("gotGoldrobGarageOpen", root, goldrobDatas.Doors.GarageDoor)
        triggerClientEvent("goldrobGotInsideDoor", root, goldrobDatas.Doors.InsideDoor)
        triggerClientEvent("gotGoldrobRoofDoorOpen", root, goldrobDatas.Doors.RoofDoor)
        triggerClientEvent("gotGoldrobGarageKeypadState", root, goldrobDatas.ElementStates.Garage.garageKeypad)
        triggerClientEvent("gotGoldrobInsideKeypadState", root, goldrobDatas.ElementStates.insideKeypad)
        triggerClientEvent("syncGoldrobBigDoorOpen", root, false, false, goldrobDatas.Doors.canOpenSafeDoor)
        triggerClientEvent("goldrobSyncLaserOtherSide", root, false, goldrobDatas.laserDeactivated)
        triggerClientEvent("syncGoldrobAllBarCut", root, false)

        initGoldbank()
    else
        setTimer(function()
            local nextOpen = getDelayUntilNextCycle()

            goldrobDatas.Alarm.State = false
            goldrobDatas.Alarm.Muted = false
            goldrobDatas.Alarm.NPCDuck = false
            goldrobDatas.Alarm.NPCFear = false
        
            goldrobDatas.Doors.BackDoor = false
            goldrobDatas.Doors.GarageDoor = false
            goldrobDatas.Doors.InsideDoor = false
            goldrobDatas.Doors.RoofDoor = false
            goldrobDatas.Doors.SafeDoor = false
            goldrobDatas.Doors.canOpenSafeDoor = false
        
            goldrobDatas.ElementStates.Garage.garageKeypad = false
            goldrobDatas.ElementStates.Garage.garageAlarm = false
            goldrobDatas.ElementStates.insideKeypad = "notinuse"
        
            goldrobDatas.laserDeactivated = false
            goldrobDatas.Opened = false
            
            for pedIndex, pedElement in pairs(goldrobDatas.TeimoPeds) do
                if pedElement and isElement(pedElement) then
                    destroyElement(pedElement)
                end
            end
            goldrobDatas.TeimoPeds = {}
            goldrobDatas.TeimoPeds.managerPosition = {574.89978027344, -1636.4979248047, 16.649925231934}
        
            playerCrates = {}
            goldCrates = {}
            floorCrates = {}
            cuttedBars = 0
            playerHeating = {}
            heatedBars = {}
            loots = {}
        
            for k, v in pairs(goldrobDatas.Security.Vehicles) do
                if v and isElement(v) then
                    setElementData(v, "bankrob.robbedcar", false)
                    goldrobDatas.Security.Code[v] = {math.random(1, 9), math.random(1, 9), math.random(1, 9), 1}
                    goldrobDatas.Security.SecDigits[v] = {0, 0, 0, 0}
                    goldrobDatas.Security.CurrentDigs[v] = 1
                    goldrobDatas.Security.CarGPS[v] = false
                    goldrobDatas.Security.CarAlert[v] = false
                    goldrobDatas.Security.StolenCounter[v] = 0
                    goldrobDatas.Security.timerCounter[v] = false
                    if goldrobDatas.Security.SecuriTimers[v] and isTimer(goldrobDatas.Security.SecuriTimers[v]) then
                        killTimer(goldrobDatas.Security.SecuriTimers[v])
                    end
                    goldrobDatas.Security.SecuriTimers[v] = false
                end
            end
        
            triggerClientEvent("gotGoldrobBankOpen", root, goldrobDatas.Opened)
            triggerClientEvent("gotGoldrobAlarmState", root, goldrobDatas.Alarm.State, goldrobDatas.Alarm.Muted)
            triggerClientEvent("gotGoldrobNPCDuck", root, goldrobDatas.Alarm.NPCDuck)
            triggerClientEvent("gotGoldrobNPCFear", root, goldrobDatas.Alarm.NPCFear)
            triggerClientEvent("gotGoldrobBackDoorOpen", root, goldrobDatas.Doors.BackDoor)
            triggerClientEvent("gotGoldrobGarageOpen", root, goldrobDatas.Doors.GarageDoor)
            triggerClientEvent("goldrobGotInsideDoor", root, goldrobDatas.Doors.InsideDoor)
            triggerClientEvent("gotGoldrobRoofDoorOpen", root, goldrobDatas.Doors.RoofDoor)
            triggerClientEvent("gotGoldrobGarageKeypadState", root, goldrobDatas.ElementStates.Garage.garageKeypad)
            triggerClientEvent("gotGoldrobInsideKeypadState", root, goldrobDatas.ElementStates.insideKeypad)
            triggerClientEvent("syncGoldrobBigDoorOpen", root, false, false, goldrobDatas.Doors.canOpenSafeDoor)
            triggerClientEvent("goldrobSyncLaserOtherSide", root, false, goldrobDatas.laserDeactivated)
            triggerClientEvent("syncGoldrobAllBarCut", root, false)

            setTimer(function()
                initGoldbank()
            end, nextOpen, 1)
        end, 60000 * 60 * 2, 1)
    end
end

addCommandHandler("resetgoldrob", function(sourcePlayer)
    if exports.sPermission:hasPermission(sourcePlayer, "resetgoldrob") then
        resetGoldrob(true)
    end
end)

addEventHandler("onResourceStart", resourceRoot, function()
    local nextOpen = getDelayUntilNextCycle()

    setTimer(function()
        local elevatorState = goldrobDatas.Elevator.Pos == "up" and true or false
    
        if goldrobDatas.Elevator.Object and isElement(goldrobDatas.Elevator.Object) then
            destroyElement(goldrobDatas.Elevator.Object)
        end
        goldrobDatas.Elevator.Object = nil

        if not goldrobDatas.Elevator.Object then
            goldrobDatas.Elevator.Object = createObject(1111, elevatorObjectPos[1], elevatorObjectPos[2], elevatorObjectPos[3] + (elevatorState and elevatorUpperZ or elevatorLowerZ))
        end

        setElementAlpha(goldrobDatas.Elevator.Object, 0)
        setElementCollisionsEnabled(goldrobDatas.Elevator.Object, false)
        triggerClientEvent("gotGoldrobElevator", root, goldrobDatas.Elevator.Object, true, goldrobDatas.Elevator.Moving)
        triggerClientEvent("gotGoldrobElevatorState", root, true, goldrobDatas.Elevator.Moving)

        local closedPosition = garageDatas.closedPosition
        if goldrobDatas.ElementStates.Garage.objectElement and isElement(goldrobDatas.ElementStates.Garage.objectElement) then
            destroyElement(goldrobDatas.ElementStates.Garage.objectElement)
        end
        goldrobDatas.ElementStates.Garage.objectElement = nil

        if not goldrobDatas.ElementStates.Garage.objectElement then
            goldrobDatas.ElementStates.Garage.objectElement = createObject(980, closedPosition[1], closedPosition[2], closedPosition[3], closedPosition[4], closedPosition[5], closedPosition[6])
        end
    end, 50, 1)


    local delaySec = nextOpen / 1000
    local h = math.floor(delaySec / 3600)
    local m = math.floor((delaySec % 3600) / 60)
    local s = math.floor(delaySec % 60)

    print("NEXT GOLDROB: [H:M:S]" .. string.format("%02d:%02d:%02d", h, m, s) .. "")

    setTimer(function()
        initGoldbank()
    --end, nextOpen, 1)
    end, 50, 1) --NOFFY
end)

addEvent("securiCarCrateClick", true)
addEventHandler("securiCarCrateClick", root, function(securiCarHover, crateIdentity, securiCarSlot, selfCrate)
    if client and client == source then
        if not playerCrates[client] then
            playerCrates[client] = 0
        end

        if not crateIdentity then
            local baseIndex = 8 * (getElementData(securiCarHover, "bankrob.vehicleid") - 1)
            triggerClientEvent("gotGoldrobCrateVehicle", client, playerCrates[client], securiCarHover)
            triggerClientEvent("gotGoldrobCrateData", client, playerCrates[client], playerCrates[client] - baseIndex)


            playerCrates[client] = false
            exports.sControls:toggleControl(client, {
                "aim_weapon",
                "sprint",
                "fire",
                "jump",
                "crouch",
                "enter_exit",
            }, true)
            setPedAnimation(client, "CARRY", "putdwn", 500, false, true, true, false)
        else
            triggerClientEvent("gotGoldrobCrateData", client, crateIdentity, client)
            playerCrates[client] = securiCarSlot + (8 * (getElementData(securiCarHover, "bankrob.vehicleid") - 1))
            exports.sGui:showInfobox(client, "i", 'A ládát az F gombbal tudod letenni a földre.')
            if goldCrates[playerCrates[client]] then
                setElementData(client, "carryingGold", true)
            else
                setElementData(client, "carryingGold", false)
            end
            setPedAnimation(client, "CARRY", "crry_prtial", 0, true, true, false, true) 
            exports.sControls:toggleControl(client, {
                "aim_weapon",
                "sprint",
                "fire",
                "jump",
                "crouch",
                "enter_exit",
            }, false)
        end
    end
end)

local floorCrates = {}

addEvent("putDownGoldCrate", true)
addEventHandler("putDownGoldCrate", root, function(x, y, z, rz)
    if playerCrates[client] and client then
        setElementData(client, "carryingGold", false)
        floorCrates[playerCrates[client]] = true
        triggerClientEvent("gotGoldrobCrateData", client, playerCrates[client], {x, y, z, rz})
        playerCrates[client] = false
        exports.sControls:toggleControl(client, {
            "aim_weapon",
            "sprint",
            "fire",
            "jump",
            "crouch",
            "enter_exit",
        }, true)
        setPedAnimation(client, "CARRY", "putdwn", 500, false, true, true, false)
    end
end)

addEvent("pickUpGoldCrate", true)
addEventHandler("pickUpGoldCrate", root, function(crateIdentity)
    print("pickup?")
    if client ~= source then
        return
    end
    if not playerCrates[client] then
        if floorCrates[crateIdentity] then
            playerCrates[client] = crateIdentity
            floorCrates[crateIdentity] = false
            if goldCrates[playerCrates[client]] then
                setElementData(client, "carryingGold", true)
            else
                setElementData(client, "carryingGold", false)
            end
            
            setPedAnimation(client, "CARRY", "liftup", -1, false, false, false, false)
            setTimer(function(playerElement)
                setPedAnimation(playerElement, "CARRY", "crry_prtial", 0, true, true, false, true) 
            end, 1000, 1, client)
            exports.sControls:toggleControl(client, {
                "aim_weapon",
                "sprint",
                "fire",
                "jump",
                "crouch",
                "enter_exit",
            }, false)
            triggerClientEvent("gotGoldrobCrateData", client, crateIdentity, client)
            exports.sGui:showInfobox(client, "i", 'A ládát az F gombbal tudod letenni a földre.')
        else
        end
    else
        exports.sGui:showInfobox(client, "e", "A te kezedben már van egy.")
    end
end)

enterTimers = {}
destroyTimers = {}

function handleVehicleResets(vehicleOccupants, vehicleElement)
    if not (destroyTimers[vehicleElement] or isTimer(destroyTimers[vehicleEleement])) then
        destroyTimers[vehicleElement] = setTimer(function()
            local targetSecuricar = tonumber(getElementData(vehicleElement, "bankrob.vehicleid"))

            if goldrobDatas.Security.Vehicles[targetSecuricar] then
                goldrobDatas.Security.Code[goldrobDatas.Security.Vehicles[targetSecuricar]]  = nil
                goldrobDatas.Security.SecDigits[goldrobDatas.Security.Vehicles[targetSecuricar]] = nil
                goldrobDatas.Security.CurrentDigs[goldrobDatas.Security.Vehicles[targetSecuricar]] = nil
                goldrobDatas.Security.CarGPS[goldrobDatas.Security.Vehicles[targetSecuricar]] = nil
                goldrobDatas.Security.CarAlert[goldrobDatas.Security.Vehicles[targetSecuricar]] = nil
                goldrobDatas.Security.StolenCounter[goldrobDatas.Security.Vehicles[targetSecuricar]] = nil
                goldrobDatas.Security.timerCounter[goldrobDatas.Security.Vehicles[targetSecuricar]] = nil
                goldrobDatas.Security.SecuriTimers[goldrobDatas.Security.Vehicles[targetSecuricar]] = nil
                destroyElement(goldrobDatas.Security.Vehicles[targetSecuricar])
            end

            --initGoldrobVehicles()
        end, (60000 * 60) * 4, 1)
        --end, 5000, 1)
    end

    if vehicleOccupants and #vehicleOccupants > 0 then
        outputChatBox("[color=sightorange][SightMTA - Figyelmeztetés] [color=hudwhite]Figyelem! A lopott pénzszállító 4 óra múlva eltűnik a hozzá kapcsolódó arannyal eggyütt.", vehicleOccupants)
    end
end

addEventHandler("onVehicleEnter", resourceRoot, function(playerElement)
    local vehicleElement = source
    if getElementData(vehicleElement, "bankrob.securitycar") then
        if not isTimer(enterTimers[vehicleElement]) then
            enterTimers[vehicleElement] = setTimer(function(playerVehicle)
                local vehiclePosition = {getElementPosition(playerVehicle)}
                goldrobDatas.Security.CarAlert[playerVehicle] = true
                local trackerData = {vehiclePosition[1], vehiclePosition[2], vehiclePosition[3], goldrobDatas.Security.CarAlert[playerVehicle]}

                triggerClientEvent("gotSecuricarTrackerData", playerVehicle, playerVehicle, trackerData)
                triggerClientEvent("gotGoldrobGarageAlarm", playerVehicle, true)
                setElementData(playerVehicle, "bankrob.robbedcar", true)
                local vehicleOccupants = getVehicleOccupants(playerVehicle)
                goldrobDatas.Security.Code[playerVehicle] = false
                for playerIndex, playerElement in pairs(vehicleOccupants) do
                    triggerClientEvent(playerElement, "openSecuricarPDA", playerElement, playerVehicle, goldrobDatas.Security.Code[playerVehicle], true, getTickCount() - goldrobDatas.Security.StolenCounter[playerVehicle], goldrobDatas.Security.CarGPS[playerVehicle], goldrobDatas.Security.SecDigits[playerVehicle], goldrobDatas.Security.CurrentDigs[playerVehicle])
                end
            end, 120000, 1, vehicleElement)
        end

        local vehiclePosition = {getElementPosition(vehicleElement)}
        local trackerData = {vehiclePosition[1], vehiclePosition[2], vehiclePosition[3], goldrobDatas.Security.CarAlert[vehicleElement]}
        if goldrobDatas.Security.StolenCounter[vehicleElement] == 0 then
            goldrobDatas.Security.StolenCounter[vehicleElement] = getRealTime().timestamp
        end
        if not goldrobDatas.Security.timerCounter[vehicleElement] then
            goldrobDatas.Security.timerCounter[vehicleElement] = getRealTime().timestamp
        end

        handleVehicleResets(getVehicleOccupants(vehicleElement), vehicleElement)
        triggerClientEvent("gotSecuricarTrackerData", vehicleElement, trackerData)
        if not getElementData(vehicleElement, "bankrob.robbedcar") then
            triggerClientEvent(playerElement, "openSecuricarPDA", playerElement, vehicleElement, goldrobDatas.Security.Code[vehicleElement], getElementData(vehicleElement, "bankrob.robbedcar"), (getRealTime().timestamp - goldrobDatas.Security.StolenCounter[vehicleElement]) * 1000, 120000 - ((getRealTime().timestamp - goldrobDatas.Security.timerCounter[vehicleElement]) * 1000), goldrobDatas.Security.SecDigits[vehicleElement], goldrobDatas.Security.CurrentDigs[vehicleElement])
        else
            triggerClientEvent(playerElement, "openSecuricarPDA", playerElement, vehicleElement, goldrobDatas.Security.Code[vehicleElement], getElementData(vehicleElement, "bankrob.robbedcar"), (getRealTime().timestamp - goldrobDatas.Security.StolenCounter[vehicleElement]) * 1000, 1800000 - ((getRealTime().timestamp - goldrobDatas.Security.timerCounter[vehicleElement]) * 1000), goldrobDatas.Security.SecDigits[vehicleElement], goldrobDatas.Security.CurrentDigs[vehicleElement])
        end
    end
end)

addEvent("securiCarSetDigit", true)
addEventHandler("securiCarSetDigit", root, function(dig, number)
    local vehicleElement = getPedOccupiedVehicle(client)
    goldrobDatas.Security.SecDigits[vehicleElement][dig] = number
    triggerClientEvent("securiCarSetDigit", client, vehicleElement, dig, number)
    local finishedNumbers = 0
    for i = 1, 4 do
        if goldrobDatas.Security.SecDigits[vehicleElement][i] == goldrobDatas.Security.Code[vehicleElement][i] then
            finishedNumbers = finishedNumbers + 1
        end
    end

    if finishedNumbers == 4 then
        goldrobDatas.Security.CarGPS[vehicleElement] = 120000 * 15
        if enterTimers[vehicleElement] and isTimer(enterTimers[vehicleElement]) then
            --killTimer(goldrobDatas.Security.SecuriTimers[vehicleElement])
            killTimer(enterTimers[vehicleElement])
            enterTimers[vehicleElement] = nil
            goldrobDatas.Security.SecuriTimers[vehicleElement] = nil
            goldrobDatas.Security.timerCounter[vehicleElement] = getRealTime().timestamp
        end

        goldrobDatas.Security.SecuriTimers[vehicleElement] = setTimer(function(vehicleElement)
            local vehPosition = {getElementPosition(vehicleElement)}
            goldrobDatas.Security.CarAlert[vehicleElement] = true
            
            local trackerData = {vehPosition[1], vehPosition[2], vehPosition[3], goldrobDatas.Security.CarAlert[vehicleElement]}
            triggerClientEvent("gotSecuricarTrackerData", vehicleElement, vehicleElement, trackerData)
            triggerClientEvent("gotGoldrobGarageAlarm", vehicleElement, true)
            
            local vehicleOccupants = getVehicleOccupants(vehicleElement)
            goldrobDatas.Security.Code[vehicleElement] = false
            for _, playerElement in pairs(vehicleOccupants) do
                triggerClientEvent(playerElement, "openSecuricarPDA", playerElement, vehicleElement, goldrobDatas.Security.Code[vehicleElement], true, getTickCount() - goldrobDatas.Security.StolenCounter[vehicleElement], goldrobDatas.Security.CarGPS[vehicleElement], goldrobDatas.Security.SecDigits[vehicleElement], goldrobDatas.Security.CurrentDigs[vehicleElement])
            end
        end, goldrobDatas.Security.CarGPS[vehicleElement], 1, vehicleElement)

        setElementData(vehicleElement, "bankrob.robbedcar", true)
        local vehicleOccupants = getVehicleOccupants(vehicleElement)
        goldrobDatas.Security.Code[vehicleElement] = false
        for _, playerElement in pairs(vehicleOccupants) do

            triggerClientEvent(playerElement, "openSecuricarPDA", playerElement, vehicleElement, goldrobDatas.Security.Code[vehicleElement], false, getTickCount() - goldrobDatas.Security.StolenCounter[vehicleElement], goldrobDatas.Security.CarGPS[vehicleElement], goldrobDatas.Security.SecDigits[vehicleElement], goldrobDatas.Security.CurrentDigs[vehicleElement])
        end
    end
end)

addEvent("securiCarSetCurrentDigit", true)
addEventHandler("securiCarSetCurrentDigit", root, function(digit)
    local vehicleElement = getPedOccupiedVehicle(client)
    goldrobDatas.Security.CurrentDigs[vehicleElement] = digit
    triggerClientEvent("securiCarSetCurrentDigit", client, vehicleElement, digit)
end)

addEvent("tryToHackGoldrobGarage", true)
addEventHandler("tryToHackGoldrobGarage", root, function()
    if not goldrobDatas.ElementStates.Garage.garageKeypad or goldrobDatas.ElementStates.Garage.garageKeypad == "notinuse" then
        triggerClientEvent(client, "goldrobGarageHackStarted", client)
        goldrobDatas.ElementStates.Garage.garageKeypad = "inuse"
    elseif goldrobDatas.ElementStates.Garage.garageKeypad == "pried" then
        triggerClientEvent(client, "goldrobGarageHackStarted", client, true)
    elseif goldrobDatas.ElementStates.Garage.garageKeypad == "inuse" then
        exports.sGui:showInfobox(client, "e", "Már valaki más lecsalja!")
    end
end)

addEvent("endGoldrobGaragePry", true)
addEventHandler("endGoldrobGaragePry", root, function(priedKeypad)
    if client and client == source then
        goldrobDatas.ElementStates.Garage.garageKeypad = "notinuse"
        if not priedKeypad then
            return
        end
        goldrobDatas.ElementStates.Garage.garageKeypad = "pried"
    end
end)

addEvent("goldrobGarageHacked", true)
addEventHandler("goldrobGarageHacked", root, function(priedKeypad)
    triggerClientEvent("gotGoldrobGarageOpen", client)
    triggerClientEvent("gotGoldrobGarageKeypadState", client, "broken")
    if priedKeypad then
        local openPosition = garageDatas.openPosition
        goldrobDatas.Doors.GarageDoor = true
        triggerClientEvent("gotGoldrobGarageOpen", resourceRoot, goldrobDatas.Doors.GarageDoor)
        moveObject(goldrobDatas.ElementStates.Garage.objectElement, 5000, openPosition[1], openPosition[2], openPosition[3])
    else
        goldrobDatas.ElementStates.garageAlarm = true
        triggerClientEvent("gotGoldrobGarageAlarm", client, goldrobDatas.ElementStates.garageAlarm)
    end
end)

local vehicleCrates = {}

addCommandHandler("gotosecuricar", function(sourcePlayer, commandName, targetSecuricar)
    if exports.sPermission:hasPermission(sourcePlayer, "gotosecuricar") then
        if not (targetSecuricar or tonumber(targetSecuricar)) then
            outputChatBox("[color=sightblue][SightMTA - AranyBank]:[color=hudwhite] /"..commandName.." [Jármű azonosítója]", sourcePlayer)
            return
        end

        local targetSecuricar = tonumber(targetSecuricar)

        if goldrobDatas.Security.Vehicles[targetSecuricar] then
            local vehiclePosition = {getElementPosition(goldrobDatas.Security.Vehicles[targetSecuricar])}
        
            setElementPosition(sourcePlayer, vehiclePosition[1] + 2, vehiclePosition[2], vehiclePosition[3])
            outputChatBox("[color=sightgreen][SightMTA - Aranybank]:[color=hudwhite] Sikeresen elteleportáltál a kiválasztott SecuriCar-hoz!", sourcePlayer)
        else
            outputChatBox("[color=sightred][SightMTA - AranyBank]:[color=hudwhite] Nem létezik SecuriCar ezzel az azonosítóval!", sourcePlayer)
        end
    end
end)

addCommandHandler("deletesecuricar", function(sourcePlayer, commandName, targetSecuricar)
    if exports.sPermission:hasPermission(sourcePlayer, "deletesecuricar") then
        if not (targetSecuricar or tonumber(targetSecuricar)) then
            outputChatBox("[color=sightblue][SightMTA - AranyBank]:[color=hudwhite] /"..commandName.." [Jármű azonosítója]", sourcePlayer)
            return
        end

        local targetSecuricar = tonumber(targetSecuricar)

        if goldrobDatas.Security.Vehicles[targetSecuricar] then
            goldrobDatas.Security.Code[goldrobDatas.Security.Vehicles[targetSecuricar]]  = nil
            goldrobDatas.Security.SecDigits[goldrobDatas.Security.Vehicles[targetSecuricar]] = nil
            goldrobDatas.Security.CurrentDigs[goldrobDatas.Security.Vehicles[targetSecuricar]] = nil
            goldrobDatas.Security.CarGPS[goldrobDatas.Security.Vehicles[targetSecuricar]] = nil
            goldrobDatas.Security.CarAlert[goldrobDatas.Security.Vehicles[targetSecuricar]] = nil
            goldrobDatas.Security.StolenCounter[goldrobDatas.Security.Vehicles[targetSecuricar]] = nil
            goldrobDatas.Security.timerCounter[goldrobDatas.Security.Vehicles[targetSecuricar]] = nil
            goldrobDatas.Security.SecuriTimers[goldrobDatas.Security.Vehicles[targetSecuricar]] = nil
            destroyElement(goldrobDatas.Security.Vehicles[targetSecuricar])

            outputChatBox("[color=sightgreen][SightMTA - AranyBank]:[color=hudwhite] Sikeresen kitörölted a kiválasztott SecuriCar-t!", sourcePlayer)
        else
            outputChatBox("[color=sightred][SightMTA - AranyBank]:[color=hudwhite] Nem található SecuriCar ezzel az azonosítóval!", sourcePlayer)
        end
    end
end)

addCommandHandler("nearbysecuricars", function(sourcePlayer, commandName)
    if exports.sPermission:hasPermission(sourcePlayer, "nearbysecuricars") then
        outputChatBox("[color=sightyellow][SightMTA - AranyBank]:[color=hudwhite] A közeledben lévő aranyszállítók:", sourcePlayer)
        local sourcePosition = {getElementPosition(sourcePlayer)}
        local nearbyVehicles = false

        for vehicleIndex, vehicleElement in pairs(goldrobDatas.Security.Vehicles) do
            local vehiclePosition = {getElementPosition(vehicleElement)}
            local dist = getDistanceBetweenPoints3D(vehiclePosition[1], vehiclePosition[2], vehiclePosition[3], sourcePosition[1], sourcePosition[2], sourcePosition[3])
            if dist <= 10 then
                nearbyVehicles = true
                outputChatBox("[color=sightyellow][SightMTA - AranyBank]:[color=hudwhite] Azonosító: [color=sightyellow]"..vehicleIndex.."[color=hudwhite] <> Távolság: [color=sightyellow]"..math.floor(dist).."m", sourcePlayer)
            end
        end
        
        if not nearbyVehicles then
            outputChatBox("[color=sightred][SightMTA - AranyBank]:[color=hudwhite] Nincs a közeledben egyetlen aranyszállító sem!", sourcePlayer)
        end
    end

end)

function initalizeSingleVehicle(vehicleIdentity)
    for k, v in pairs(securiCarPositions) do
        if k == vehicleIdentity then
            goldrobDatas.Security.Vehicles[k] = createVehicle(428, v[1], v[2], v[3], v[4], v[5], v[6])
            setElementData(goldrobDatas.Security.Vehicles[k], "bankrob.securitycar", true)
            setElementData(goldrobDatas.Security.Vehicles[k], "bankrob.robbedcar", false)
            goldrobDatas.Security.Code[goldrobDatas.Security.Vehicles[k]]  = {math.random(1, 9), math.random(1, 9), math.random(1, 9), 1}
            goldrobDatas.Security.SecDigits[goldrobDatas.Security.Vehicles[k]] = {0, 0, 0, 0}
            goldrobDatas.Security.CurrentDigs[goldrobDatas.Security.Vehicles[k]] = 1
            goldrobDatas.Security.CarGPS[goldrobDatas.Security.Vehicles[k]] = false
            goldrobDatas.Security.CarAlert[goldrobDatas.Security.Vehicles[k]] = false
            goldrobDatas.Security.StolenCounter[goldrobDatas.Security.Vehicles[k]] = 0
            goldrobDatas.Security.timerCounter[goldrobDatas.Security.Vehicles[k]] = false
            goldrobDatas.Security.SecuriTimers[goldrobDatas.Security.Vehicles[k]] = false
            setElementData(goldrobDatas.Security.Vehicles[k], "bankrob.vehicleid", k)
            setElementData(goldrobDatas.Security.Vehicles[k], "vehicle.Battery", 100)
            setElementData(goldrobDatas.Security.Vehicles[k], "vehicle.fuel", 60)
            setElementData(goldrobDatas.Security.Vehicles[k], "vehicle.engine", true)
            setElementData(goldrobDatas.Security.Vehicles[k], "vehicle.ignition", true)
            setVehicleEngineState(goldrobDatas.Security.Vehicles[k], true)
            setVehiclePlateText(goldrobDatas.Security.Vehicles[k], "BANK-00"..k)
            break
        end
    end

    local crateCount = 1
    for i = 1, 6 do
        if i == vehicleIdentity then
            for e = 1, 8 do
                goldrobDatas.Crate.Crates[crateCount] = goldrobDatas.Security.Vehicles[i]
                vehicleCrates[i] = e
                goldrobDatas.Crate.GoldCrates[crateCount] = e
                crateCount = crateCount + 1
            end
        end
    end

    setTimer(function(securiCrates, securiCrates2)
        for k, v in ipairs(getElementsByType("player")) do
            triggerClientEvent(v, "gotGoldrobCrateVehicleAll", v, securiCrates)
            triggerClientEvent(v, "gotGoldrobCrateDataAll", v, securiCrates2)
        end
    end, 50, 1, goldrobDatas.Crate.Crates, goldrobDatas.Crate.GoldCrates)
end

function initGoldrobVehicles()
    for k, v in pairs(securiCarPositions) do
        --handleVehicleResets(false, k)

        goldrobDatas.Security.Vehicles[k] = createVehicle(428, v[1], v[2], v[3], v[4], v[5], v[6])
        setElementData(goldrobDatas.Security.Vehicles[k], "bankrob.securitycar", true)
        setElementData(goldrobDatas.Security.Vehicles[k], "bankrob.robbedcar", false)
        goldrobDatas.Security.Code[goldrobDatas.Security.Vehicles[k]]  = {math.random(1, 9), math.random(1, 9), math.random(1, 9), 1}
        goldrobDatas.Security.SecDigits[goldrobDatas.Security.Vehicles[k]] = {0, 0, 0, 0}
        goldrobDatas.Security.CurrentDigs[goldrobDatas.Security.Vehicles[k]] = 1
        goldrobDatas.Security.CarGPS[goldrobDatas.Security.Vehicles[k]] = false
        goldrobDatas.Security.CarAlert[goldrobDatas.Security.Vehicles[k]] = false
        goldrobDatas.Security.StolenCounter[goldrobDatas.Security.Vehicles[k]] = 0
        goldrobDatas.Security.timerCounter[goldrobDatas.Security.Vehicles[k]] = false
        goldrobDatas.Security.SecuriTimers[goldrobDatas.Security.Vehicles[k]] = false
        setElementData(goldrobDatas.Security.Vehicles[k], "bankrob.vehicleid", k)
        setElementData(goldrobDatas.Security.Vehicles[k], "vehicle.Battery", 100)
        setElementData(goldrobDatas.Security.Vehicles[k], "vehicle.fuel", 60)
        setElementData(goldrobDatas.Security.Vehicles[k], "vehicle.engine", true)
        setElementData(goldrobDatas.Security.Vehicles[k], "vehicle.ignition", true)
        setVehicleEngineState(goldrobDatas.Security.Vehicles[k], true)
        setVehiclePlateText(goldrobDatas.Security.Vehicles[k], "BANK-00"..k)
    end

    local crateCount = 1
    for i = 1, 6 do
        for e = 1, 8 do
            goldrobDatas.Crate.Crates[crateCount] = goldrobDatas.Security.Vehicles[i]
            vehicleCrates[i] = e
            goldrobDatas.Crate.GoldCrates[crateCount] = e
            crateCount = crateCount + 1
        end
    end

    setTimer(function(securiCrates, securiCrates2)
        for k, v in ipairs(getElementsByType("player")) do
            triggerClientEvent(v, "gotGoldrobCrateVehicleAll", v, securiCrates)
            triggerClientEvent(v, "gotGoldrobCrateDataAll", v, securiCrates2)
        end
    end, 50, 1, goldrobDatas.Crate.Crates, goldrobDatas.Crate.GoldCrates)
end

addEventHandler("onResourceStart", resourceRoot, function()
    initGoldrobVehicles()
end)

function initGoldbank()
    local elevatorState = goldrobDatas.Elevator.Pos == "up" and true or false
    
    if goldrobDatas.Elevator.Object and isElement(goldrobDatas.Elevator.Object) then
        destroyElement(goldrobDatas.Elevator.Object)
    end
    goldrobDatas.Elevator.Object = nil

    if not goldrobDatas.Elevator.Object then
        goldrobDatas.Elevator.Object = createObject(1111, elevatorObjectPos[1], elevatorObjectPos[2], elevatorObjectPos[3] + (elevatorState and elevatorUpperZ or elevatorLowerZ))
    end

    setElementAlpha(goldrobDatas.Elevator.Object, 0)
    setElementCollisionsEnabled(goldrobDatas.Elevator.Object, false)
    triggerClientEvent("gotGoldrobElevator", root, goldrobDatas.Elevator.Object, elevatorState, goldrobDatas.Elevator.Moving)
    triggerClientEvent("gotGoldrobElevatorState", root, elevatorState, goldrobDatas.Elevator.Moving)

    local closedPosition = garageDatas.closedPosition
    if goldrobDatas.ElementStates.Garage.objectElement and isElement(goldrobDatas.ElementStates.Garage.objectElement) then
        destroyElement(goldrobDatas.ElementStates.Garage.objectElement)
    end
    goldrobDatas.ElementStates.Garage.objectElement = nil

    if not goldrobDatas.ElementStates.Garage.objectElement then
        goldrobDatas.ElementStates.Garage.objectElement = createObject(980, closedPosition[1], closedPosition[2], closedPosition[3], closedPosition[4], closedPosition[5], closedPosition[6])
    end

    triggerClientEvent("syncGoldrobBigDoorOpen", root, false, false, goldrobDatas.Doors.canOpenSafeDoor)
    triggerClientEvent("gotGoldrobBankOpen", root, goldrobDatas.Opened)
    triggerClientEvent("gotGoldrobAlarmState", root, goldrobDatas.Alarm.State, goldrobDatas.Alarm.Muted)

    initTeimo()
end

local function initGoldrobForPlayer(playerElement)
    if goldrobDatas.Teimo.State == false and not goldrobDatas.Teimo.Objects[1] then
        triggerClientEvent(playerElement, "gotGoldrobNPCElements", playerElement, goldrobDatas.TeimoPeds)
    end
    
    local elevatorState = goldrobDatas.Elevator.Pos == "up" and true or false
    triggerClientEvent(playerElement, "gotGoldrobElevator", playerElement, goldrobDatas.Elevator.Object, elevatorState, goldrobDatas.Elevator.Moving)
    triggerClientEvent(playerElement, "gotGoldrobElevatorState", playerElement, elevatorState, goldrobDatas.Elevator.Moving)

    triggerClientEvent(playerElement, "gotGoldrobBankOpen", playerElement, goldrobDatas.Opened)
    triggerClientEvent(playerElement, "gotGoldrobAlarmState", playerElement, goldrobDatas.Alarm.State, goldrobDatas.Alarm.Muted)


    triggerClientEvent(playerElement, "gotGoldrobRoofDoorOpen", playerElement, goldrobDatas.Doors.RoofDoor)
    triggerClientEvent(playerElement, "gotGoldrobBackDoorOpen", playerElement, goldrobDatas.Doors.BackDoor)
    triggerClientEvent(playerElement, "gotGoldrobGarageOpen", playerElement, goldrobDatas.Doors.GarageDoor)
    triggerClientEvent(playerElement, "goldrobGotInsideDoor", playerElement, goldrobDatas.Doors.InsideDoor)
    triggerClientEvent(playerElement, "gotGoldrobGarageKeypadState", playerElement, goldrobDatas.ElementStates.Garage.garageKeypad)
    triggerClientEvent(playerElement, "gotGoldrobInsideKeypadState", playerElement, goldrobDatas.Doors.insideKeypad)

    setTimer(function(playerElement, normalCrates, goldCrates)
        triggerClientEvent(playerElement, "gotGoldrobCrateVehicleAll", playerElement, normalCrates)
        triggerClientEvent(playerElement, "gotGoldrobCrateDataAll", playerElement, goldCrates)
    end, 50, 1, playerElement, goldrobDatas.Crate.Crates, goldrobDatas.Crate.GoldCrates)
end

local alertMessages = {
    ["opening"] = "Figyelem! playerName kinyitotta a Sight City Bank doorName ajtaját! doorType",
    ["closing"] = "Figyelem! playerName bezárta a Sight City Bank doorName ajtaját! doorType",
}

function alertLegalGroups(playerName, doorState, doorName, doorType)
    local currentMessage = ""
    if doorName ~= "riasztó" then
        currentMessage = ((alertMessages[doorState]:gsub("playerName", "[color=sightorange]"..playerName:gsub("_", " ").."[color=hudwhite]")):gsub("doorName", doorName)):gsub("doorType", doorType and doorType or "")
    else
        currentMessage = "Figyelem! [color=sightorange]"..playerName.."[color=hudwhite] kikapcsolta a Sight City bank riasztóját!"
    end

    lawEnforcementPlayers = {}

    for _, playerElement in pairs(getElementsByType("player")) do
        local playerGroups = exports.sGroups:getPlayerGroups(playerElement)
        local selectedGroup

        if playerGroups then
            for k, v in pairs(playerGroups) do
                if exports.sGroups:isLawEnforcementGroup(k) then
                    table.insert(lawEnforcementPlayers, playerElement)
                    break
                end
            end
        end
    end

    outputChatBox("[color=sightred][SightMTA - Security]: [color=hudwhite]"..currentMessage, lawEnforcementPlayers)
end

addEvent("goldrobMuteAlarm", true)
addEventHandler("goldrobMuteAlarm", root, function()
    if exports.sGroups:getPlayerPermission(client, "mdc") then
        goldrobDatas.Alarm.Muted = true

        alertLegalGroups(getElementData(client, "char.name"):gsub("_", " "), false, "riasztó")

        triggerClientEvent("gotGoldrobAlarmState", client, goldrobDatas.Alarm.State, goldrobDatas.Alarm.Muted)
    end
end)

addEvent("goldrobToggleBackDoor", true)
addEventHandler("goldrobToggleBackDoor", root, function()
    if exports.sGroups:getPlayerPermission(client, "mdc") then
        goldrobDatas.Doors.BackDoor = not goldrobDatas.Doors.BackDoor

        alertLegalGroups(getElementData(client, "char.name"), not goldrobDatas.Doors.BackDoor and "closing" or "opening", "hátsó")
        triggerClientEvent("gotGoldrobBackDoorOpen", client, goldrobDatas.Doors.BackDoor)
    end
end)

addEvent("goldrobToggleRoofDoor", true)
addEventHandler("goldrobToggleRoofDoor", root, function()
    if exports.sGroups:getPlayerPermission(client, "mdc") then
        goldrobDatas.Doors.RoofDoor = not goldrobDatas.Doors.RoofDoor

        alertLegalGroups(getElementData(client, "char.name"), not goldrobDatas.Doors.RoofDoor and "closing" or "opening", "bejárati", "(felső)")
        triggerClientEvent("gotGoldrobRoofDoorOpen", client, goldrobDatas.Doors.RoofDoor)
    end
end)



local teimoSpeed = 60000 --Biciklis érkezési idő
--local teimoSpeed = 500 --Biciklis érkezési idő  --NOFFY
local teimoDelay = 200
local teimoDatas = {}
local teimoPath = {
    --Sebesseg, x, y, z (z-t lehetoleg ugyan ott tartsd)
    {1400, 621.42761230469, -1628.6630859375, 16.576417922974},
    {8110, 607.90466308594, -1628.6319580078, 16.642763137817},
    {1500, 606.57885742188, -1632.3979492188, 16.642763137817},
    {15000, 580.88238525391, -1632.3975830078, 16.642763137817},
    {1500, 581.48016357422, -1637.6441650391, 16.642763137817},
    --Innentol sorrendekben van, hogy mikor melyik jon, nyilvanvaloan az egyestol kezdodik.
}
local customPaths = {
    [1] = {
        --Sebesseg, x, y, z (z-t lehetoleg ugyan ott tartsd)
        {2500, 577.15075683594, -1638.1221923828, 16.642763137817},
        {2000, 574.68670654297, -1636.5662841797, 16.649925231934}
    },
    [2] = {
        {1000, 585.66394042969, -1638.1462402344, 16.642763137817},
        {1000, 587.76953125, -1636.4998779297, 16.642763137817},
    },
    [3] = {
        {1000, 591.19812011719, -1638.1993408203, 16.642763137817},
        {2500, 591.19812011719, -1638.1993408203, 16.642763137817},
        {200, 591.29266357422, -1636.4985351562, 16.642763137817}
    },
    [4] = {
        {1000, 585.66394042969, -1638.1462402344, 16.642763137817},
        {4000, 594.48083496094, -1638.1483154297, 16.642763137817},
        {200, 594.47613525391, -1636.4982910156, 16.642763137817},
    },
    [5] = {
        {1000, 585.66394042969, -1638.1462402344, 16.642763137817},
        {5500, 599.02227783203, -1638.1578369141, 16.642763137817},
        {200, 598.72515869141, -1636.4952392578, 16.642763137817},
    },
    [6] = {
        {1000, 585.66394042969, -1638.1462402344, 16.642763137817},
        {7000, 602.03857421875, -1638.1629638672, 16.642763137817},
        {1000, 602.02569580078, -1636.4985351562, 16.642763137817},
    },
}
--[[
local teimoSpeed = 1
local teimoDelay = 1
local teimoDatas = {}
local teimoPath = {
    {1, 621.42761230469, -1628.6630859375, 16.576417922974},
    {1, 607.90466308594, -1628.6319580078, 16.642763137817},
    {1, 606.57885742188, -1632.3979492188, 16.642763137817},
    {1, 580.88238525391, -1632.3975830078, 16.642763137817},
    {1, 581.48016357422, -1637.6441650391, 16.642763137817},
}
local customPaths = {
    [1] = {
        {1, 577.15075683594, -1638.1221923828, 16.642763137817},
        {1, 574.68670654297, -1636.5662841797, 16.649925231934}
    },
    [2] = {
        {1, 585.66394042969, -1638.1462402344, 16.642763137817},
        {1, 587.76953125, -1636.4998779297, 16.642763137817},
    },
    [3] = {
        {1, 591.19812011719, -1638.1993408203, 16.642763137817},
        {1, 591.19812011719, -1638.1993408203, 16.642763137817},
        {1, 591.29266357422, -1636.4985351562, 16.642763137817}
    },
    [4] = {
        {1, 585.66394042969, -1638.1462402344, 16.642763137817},
        {1, 594.48083496094, -1638.1483154297, 16.642763137817},
        {1, 594.47613525391, -1636.4982910156, 16.642763137817},
    },
    [5] = {
        {1, 585.66394042969, -1638.1462402344, 16.642763137817},
        {1, 599.02227783203, -1638.1578369141, 16.642763137817},
        {1, 598.72515869141, -1636.4952392578, 16.642763137817},
    },
    [6] = {
        {1, 585.66394042969, -1638.1462402344, 16.642763137817},
        {1, 602.03857421875, -1638.1629638672, 16.642763137817},
        {1, 602.02569580078, -1636.4985351562, 16.642763137817},
    },
}
]]
local function generateTeimoDatas()
    if not teimoDatas.Generated then
        teimoDatas.Skin = {}
        for i = 2, 6 do
            teimoDatas.Skin[i] = math.random(1, #clerkSkins)
        end
    
        teimoDatas.Surnames = {}
        for i = 1, 6 do
            teimoDatas.Surnames[i] = math.random(1, #surNames)
        end
    
        teimoDatas.Names = {}
        for i = 2, 6 do
            teimoDatas.Names[i] = math.random(1, #femaleNames)
        end
    
        teimoDatas.Skin[1] = math.random(1, #managerSkins)
        teimoDatas.Names[1] = math.random(1, #maleNames)
        teimoDatas.Generated = true
    end
    return teimoDatas
end

function initTeimo()
    teimoDatas = {}
    goldrobDatas.Teimo.State = false

    if goldrobDatas.Teimo.Objects[1] then
        for i = 1, 6 do
            if goldrobDatas.Teimo.Objects[i] and isElement(goldrobDatas.Teimo.Objects[i]) then
                destroyElement(goldrobDatas.Teimo.Objects[i])
            end
        end
        goldrobDatas.Teimo.Objects = {}
    end

    teimoDatas = generateTeimoDatas()
    --// * Bicikli
    for i = 1, 6 do
        if not goldrobDatas.Teimo.Objects[i] then
            goldrobDatas.Teimo.Objects[i] = createObject(1111, 625.01379394531, -1229.8624267578 + (5 * i), 18.047801971436 + 20, goldrobDatas.Teimo.ArrivalPositions[i][3])
        end
        if goldrobDatas.Teimo.Objects[i] then
            local teimoObjects = goldrobDatas.Teimo.Objects
            setElementAlpha(teimoObjects[i], 0)
            setElementRotation(goldrobDatas.Teimo.Objects[i], 0, 0, 180)
            setElementCollisionsEnabled(teimoObjects[i], false)
            moveObject(teimoObjects[i], teimoSpeed, goldrobDatas.Teimo.ArrivalPositions[i][1], goldrobDatas.Teimo.ArrivalPositions[i][2], goldrobDatas.Teimo.ArrivalPositions[i][3])
        end
    end

    triggerClientEvent(
        "gotTeimoData", root, goldrobDatas.Teimo.Objects, 
        {teimoDatas.Skin[1], teimoDatas.Skin[2], teimoDatas.Skin[3], teimoDatas.Skin[4], teimoDatas.Skin[5], teimoDatas.Skin[6]},
        {teimoDatas.Surnames[1], teimoDatas.Surnames[2], teimoDatas.Surnames[3], teimoDatas.Surnames[4], teimoDatas.Surnames[5], teimoDatas.Surnames[6]},
        {teimoDatas.Names[1], teimoDatas.Names[2], teimoDatas.Names[3], teimoDatas.Names[4], teimoDatas.Names[5], teimoDatas.Names[6]}
    )
    
    for teimoIdentity = 1, 6 do
        goldrobDatas.Teimo.State = true
        triggerClientEvent("gotTeimoBike", root, teimoIdentity, goldrobDatas.Teimo.State)
    end

    setTimer(function(teimoObjects)
        local walkSpeed = 7500

        for teimoIdentity = 1, 6 do
            local moveDelay = (teimoIdentity - 1) * teimoDelay
            triggerClientEvent("gotTeimoBike", root, teimoIdentity, false)
            moveTeimoAlongPath(teimoIdentity, 1, moveDelay)
        end
    end, teimoSpeed, 1, goldrobDatas.Teimo.Objects)
end

function moveTeimoAlongPath(teimoIdentity, pathIdentity, delayAmount, isCustom)
    local teimoObject = goldrobDatas.Teimo.Objects[teimoIdentity]
    local path = isCustom and customPaths[teimoIdentity] or teimoPath
    local pathPoint = path and path[pathIdentity]

    --[[
    iprint(
        "TEIMO IDENTITY: " .. teimoIdentity, 
        "PATH IDENTITY: " .. pathIdentity, 
        "DELAY AMOUNT: " .. delayAmount, 
        "CUSTOM: " .. tostring(isCustom)
    )
        ]]

    if teimoObject and pathPoint then
        moveObject(teimoObject, pathPoint[1] + (delayAmount or 0), pathPoint[2], pathPoint[3], pathPoint[4])
        setTimer(function()
            local nextPathIndex = pathIdentity + 1
            if path[nextPathIndex] then
                moveTeimoAlongPath(teimoIdentity, nextPathIndex, delayAmount, isCustom)
            else
                if not isCustom and customPaths[teimoIdentity] then
                    moveTeimoAlongPath(teimoIdentity, 1, delayAmount, true)
                else
                    if teimoIdentity == 6 then
                        triggerClientEvent(
                            "gotTeimoData", root, false, false, 
                            {teimoDatas.Skin[1] or 1, teimoDatas.Skin[2], teimoDatas.Skin[3], teimoDatas.Skin[4], teimoDatas.Skin[5], teimoDatas.Skin[6], 1},
                            {teimoDatas.Surnames[1] or 1, teimoDatas.Surnames[2], teimoDatas.Surnames[3], teimoDatas.Surnames[4], teimoDatas.Surnames[5], teimoDatas.Surnames[6], 1},
                            {teimoDatas.Names[1] or 1, teimoDatas.Names[2], teimoDatas.Names[3], teimoDatas.Names[4], teimoDatas.Names[5], teimoDatas.Names[6], 1}
                        )
            
                        initTeimoPeds()
            
                        triggerClientEvent("gotGoldrobNPCElements", root, goldrobDatas.TeimoPeds)

                        goldrobDatas.Opened = true
                        triggerClientEvent("gotGoldrobBankOpen", root, goldrobDatas.Opened)

                        for i = 1, 6 do
                            if goldrobDatas.Teimo.Objects[i] and isElement(goldrobDatas.Teimo.Objects[i]) then
                                destroyElement(goldrobDatas.Teimo.Objects[i])
                            end
                        end

                        goldrobDatas.Teimo.State = false
                        goldrobDatas.Opened = true
                        
                        triggerClientEvent("gotTeimoBike", root, teimoIdentity, goldrobDatas.Teimo.State)
                    end
                end
            end
        end, pathPoint[1] + (delayAmount or 0), 1)
    end
end

function initTeimoPeds()
    local teimoDatas = generateTeimoDatas()
    triggerClientEvent("gotGoldrobBankOpen", resourceRoot, goldrobDatas.Opened)
    for i = 1, #otherNpcPoses do
        if not isElement(goldrobDatas.TeimoPeds[1]) then
            goldrobDatas.TeimoPeds[1] = createPed(managerSkins[teimoDatas.Skin[1]], goldrobDatas.TeimoPeds.managerPosition[1], goldrobDatas.TeimoPeds.managerPosition[2], goldrobDatas.TeimoPeds.managerPosition[3])
            setElementData(goldrobDatas.TeimoPeds[1], "robPed", 1)
            setElementFrozen(goldrobDatas.TeimoPeds[1], true)
            setElementData(goldrobDatas.TeimoPeds[1], "invulnerable", true)
            setElementData(goldrobDatas.TeimoPeds[1], "visibleName", maleNames[teimoDatas.Names[1]] .. " " .. surNames[teimoDatas.Surnames[1]])
        end
        if not isElement(goldrobDatas.TeimoPeds[i + 1]) then
            goldrobDatas.TeimoPeds[i + 1] = createPed(clerkSkins[teimoDatas.Skin[i]], otherNpcPoses[i][1], otherNpcPoses[i][2], otherNpcPoses[i][3])
            setElementData(goldrobDatas.TeimoPeds[i + 1], "invulnerable", true)
            setElementFrozen(goldrobDatas.TeimoPeds[i + 1], true)
            setElementData(goldrobDatas.TeimoPeds[i + 1], "robPed", i + 1)
            setElementData(goldrobDatas.TeimoPeds[i + 1], "visibleName", femaleNames[teimoDatas.Names[i]] .. " " .. surNames[teimoDatas.Surnames[i]])
        end
    end
end

addEvent("goldrobReleaseInsideDoor", true)
addEventHandler("goldrobReleaseInsideDoor", root, function()
    goldrobDatas.Doors.InsideDoor = true
    --goldrobDatas.ElementStates.insideKeypad = true
    triggerClientEvent("goldrobGotInsideDoor", resourceRoot, goldrobDatas.Doors.InsideDoor)
    setTimer(function()
        goldrobDatas.Doors.InsideDoor = false
        triggerClientEvent("goldrobGotInsideDoor", resourceRoot, goldrobDatas.Doors.InsideDoor)
    end, 10000, 1)
    

end)

addEvent("goldrobBankElevator", true)
addEventHandler("goldrobBankElevator", root, function()
    local elevatorState = goldrobDatas.Elevator.Pos == "up"
    if not elevatorState then
        triggerClientEvent( "gotGoldrobElevatorState", resourceRoot, true, true)
        --triggerClientEvent("gotGoldrobElevator", resourceRoot, goldrobDatas.Elevator.Object, false, true)
        setTimer(function()
            moveObject(goldrobDatas.Elevator.Object, 10000, elevatorObjectPos[1], elevatorObjectPos[2], elevatorObjectPos[3] + 17.0910375, 0, 0, 0)
        end, 3000, 1)
        setTimer(function()
            triggerClientEvent( "gotGoldrobElevatorState", resourceRoot, true, false)
            --triggerClientEvent("gotGoldrobElevator", resourceRoot, goldrobDatas.Elevator.Object, true, false)
        end, 13000, 1)
        goldrobDatas.Elevator.Pos = "up"
    elseif elevatorState then
        triggerClientEvent( "gotGoldrobElevatorState", resourceRoot, false, true)
        --triggerClientEvent("gotGoldrobElevator", resourceRoot, goldrobDatas.Elevator.Object, true, true)
        setTimer(function()
            moveObject(goldrobDatas.Elevator.Object, 10000, elevatorObjectPos[1], elevatorObjectPos[2], elevatorObjectPos[3] - 3.3011625, 0, 0, 0)
        end, 3000, 1)
        setTimer(function()
            triggerClientEvent( "gotGoldrobElevatorState", resourceRoot, false, false)
            --triggerClientEvent("gotGoldrobElevator", resourceRoot, goldrobDatas.Elevator.Object, false, false)
        end, 13000, 1)
        goldrobDatas.Elevator.Pos = "down"
    end
end)

local targetedPeds = {}
local teimoTimers = {}

addEventHandler("onPlayerTarget", root, function(targetElement)
    if isElementWithinColShape(source, bankFearCol) then
        if not goldrobDatas.Opened then
            return
        end

        if isElement(targetElement) and getPedWeapon(source) >= 22 then
            targetedPeds[source] = getElementData(targetElement, "robPed")
            goldrobDatas.Alarm.NPCFear = true
            triggerClientEvent("gotGoldrobNPCFear", source, goldrobDatas.Alarm.NPCFear)
            triggerLatentClientEvent("gotGoldrobNPCFearLevel", source, targetedPeds[source], 1)
            triggerClientEvent("gotGoldrobNPCAim", source, targetedPeds[source], true)
            
            goldrobStarted()

            if isTimer(teimoTimers[targetedPeds[source]]) then
                killTimer(teimoTimers[targetedPeds[source]])
            end
        else
            if targetedPeds[source] then
                triggerClientEvent("gotGoldrobNPCAim", source, targetedPeds[source], false)
                targetedPeds[source] = false
                if not isTimer(teimoTimers[targetedPeds[source]]) then
                    teimoTimers[targetedPeds[source]] = setTimer(function(targetElement, playerElement)
                        if goldrobDatas.Alarm.State then
                            return
                        end
                        
                        
                        if isElement(threateningPlayer) then
                            triggerClientEvent(threateningPlayer, "gotGoldrobNPCFearMinigame", client, false)
                            exports.sGui:showInfobox(threateningPlayer, "e", "Beindult a riasztó, ezért a minigame megszakadt!")

                        end

                        goldrobDatas.Alarm.State = true
                        goldrobDatas.Alarm.NPCDuck = true
                        triggerClientEvent("gotGoldrobNPCDuck", playerElement, goldrobDatas.Alarm.NPCDuck)

                        exports.sGui:showInfobox(playerElement, "e", "Megnyomták a riasztót, mert nem figyeltél!")

                        triggerClientEvent("gotGoldrobAlarmState", playerElement, goldrobDatas.Alarm.State, goldrobDatas.Alarm.Muted)

                        goldrobStarted()
                    end, 12000, 1, targetElement, source, goldrobDatas)
                end
            end
        end
    end
end)

addEvent("goldrobStartNPCMinigame", true)
addEventHandler("goldrobStartNPCMinigame", root, function()
    if not goldrobDatas.TeimoPeds.threatenedManager then
        triggerClientEvent(client, "gotGoldrobNPCFearMinigame", client, true)
        threateningPlayer = client
    else
        exports.sGui:showInfobox(client, "e", "Már egyszer megpróbáltátok megfenyegetni!")
    end
end)

addEvent("goldrobNPCMinigameResult", true)
addEventHandler("goldrobNPCMinigameResult", root, function(minigameState)
    if minigameState then
        exports.sGui:showInfobox(client, "s", "Sikeresen megfenyegetted! A kód: "..goldrobDatas.Code)
        goldrobDatas.Alarm.NPCFear = false
        triggerClientEvent("gotGoldrobNPCFear", resourceRoot, goldrobDatas.Alarm.NPCFear)
        threateningPlayer = false
    else
        goldrobDatas.TeimoPeds.threatenedManager = true
        threateningPlayer = false
        exports.sGui:showInfobox(client, "s", "Sikeresen beindítottad a riasztót!")
        goldrobDatas.Alarm.State = true
        triggerClientEvent("gotGoldrobAlarmState", client, goldrobDatas.Alarm.State)
        setTimer(function(playerElement)
            goldrobDatas.Alarm.State = false
            goldrobDatas.Alarm.Muted = false
            goldrobDatas.Alarm.NPCDuck = false
            goldrobDatas.Alarm.NPCFear = false
            triggerClientEvent("gotGoldrobAlarmState", playerElement, goldrobDatas.Alarm.State, goldrobDatas.Alarm.Muted)
            triggerClientEvent("gotGoldrobNPCDuck", playerElement, goldrobDatas.Alarm.NPCDuck)
            triggerClientEvent("gotGoldrobNPCFear", playerElement, goldrobDatas.Alarm.NPCFear)
            for i = 1, 6 do
                triggerLatentClientEvent("gotGoldrobNPCFearLevel", playerElement, i, 1)
            end
        end, 6000 * 120, 1, client)
    end
end)

local doorCodeTries = 1
addEvent("goldrobTryDoorCode", true)
addEventHandler("goldrobTryDoorCode", root, function(doorCode)
    doorCodeTries = doorCodeTries + 1

    if doorCode == tonumber(goldrobDatas.Code) then
        goldrobDatas.Doors.InsideDoor = true
        triggerClientEvent("gotGoldrobInsideDoorTries", resourceRoot, doorCodeTries)
        triggerClientEvent("goldrobGotInsideDoor", client, goldrobDatas.Doors.InsideDoor)
        setTimer(function()
            goldrobDatas.Doors.InsideDoor = false
            triggerClientEvent("goldrobGotInsideDoor", resourceRoot, goldrobDatas.Doors.InsideDoor)
        end, 5000, 1)
    else
        triggerClientEvent("gotGoldrobInsideDoorTries", resourceRoot, doorCodeTries)
    end
end)

addEvent("goldrobStartWheelMinigame", true)
addEventHandler("goldrobStartWheelMinigame", root, function()
    triggerClientEvent(client, "startWheelMinigame", client)
end)

addEvent("updateGoldrobWheelSpeed", true)
addEventHandler("updateGoldrobWheelSpeed", root, function(wheelSpeed)
    triggerClientEvent("gotGoldrobWheelSpeed", client, wheelSpeed)
end)

addEvent("goldrobWheelPinSound", true)
addEventHandler("goldrobWheelPinSound", root, function(pinSound)
    triggerClientEvent("goldrobWheelPinSound", client, pinSound)
end)

addEvent("goldrobWheelMinigameEnd", true)
addEventHandler("goldrobWheelMinigameEnd", root, function(minigameResult)
    if not client then client = source end
    if not minigameResult then
        if goldrobDatas.Alarm.State then
            return
        end
        if isElement(threateningPlayer) then
            triggerClientEvent(threateningPlayer, "gotGoldrobNPCFearMinigame", client, false)
            exports.sGui:showInfobox(threateningPlayer, "e", "Beindult a riasztó, ezért a minigame megszakadt!")
        end
        goldrobDatas.Alarm.State = true
        return
    end

    goldrobDatas.Doors.SafeDoor = true

    laserOther = {}
    for i = 1, #laserPoses do
        laserOther[i] = math.random(1, #laserPoses)
    end

    goldbarData = {}
    for i = 1, 50 do
        goldbarData[i] = math.random(1, #goldBarPositions)
    end

    setTimer(function(playerElement)
        goldrobDatas.Doors.SafeDoor = false
        triggerClientEvent("syncGoldrobBigDoorOpen", playerElement, false, false, false)
    end, (60 * 1000) * 30, 1, client)

    triggerClientEvent("syncGoldrobBigDoorOpen", client, true, true, true)
    triggerClientEvent("syncGoldrobAllBarCut", client, false)
    triggerClientEvent("goldrobSyncLaserOtherSide", client, laserOther, false)
    triggerClientEvent("gotGoldrobGoldBarAll", client, goldbarData)
end)



local laserPosition = {563.33428955078, -1627.9504394531, 566.13385009766 + 1, -1630.4510498047, 566.13385009766 - 8, -1630.4510498047, 566.13385009766 - 8, -1630.4510498047 + 5, 566.13385009766 + 1, -1630.4510498047 + 5,}
laserCol = createColPolygon(laserPosition[1], laserPosition[2], laserPosition[3], laserPosition[4], laserPosition[5], laserPosition[6], laserPosition[7], laserPosition[8], laserPosition[9], laserPosition[10])
setColPolygonHeight(laserCol, -6, 5)

addEventHandler("onColShapeHit", laserCol, function(hitElement, dimensionMatch)
    if goldrobDatas.laserDeactivated then
        return
    end

    if not goldrobDatas.Doors.SafeDoor then
        return
    end
        
    if hitElement and dimensionMatch and not goldrobDatas.Alarm.State then
        exports.sGui:showInfobox(hitElement, "s", "Sikeresen beindítottad a risztatót!")
        
        if isElement(threateningPlayer) then
            triggerClientEvent(threateningPlayer, "gotGoldrobNPCFearMinigame", client, false)
            exports.sGui:showInfobox(threateningPlayer, "e", "Beindult a riasztó, ezért a minigame megszakadt!")
        end

        goldrobDatas.Alarm.State = true
        triggerClientEvent("gotGoldrobAlarmState", hitElement, goldrobDatas.Alarm.State, false)
        setTimer(function(playerElement)
            triggerClientEvent("gotGoldrobAlarmState", playerElement, false, false)
            triggerClientEvent("gotGoldrobNPCDuck", playerElement, false)
            triggerClientEvent("gotGoldrobNPCFear", playerElement, false)
            for i = 1, 12 do
                triggerLatentClientEvent("gotGoldrboNPCFearLevel", playerElement, i, 1)
            end
            goldrobDatas.Alarm.State = false
        end, 6000 * 120, 1, hitElement)
    end
end)

addEvent("requestGoldrobDatasAfterModel", true)
addEventHandler("requestGoldrobDatasAfterModel", getRootElement(), function()
end)

addEvent("requestGoldrobDatas", true)
addEventHandler("requestGoldrobDatas", getRootElement(), function()
    triggerClientEvent(client, "startHeartBeat", client)
    initGoldrobForPlayer(client)
end)

addEvent("goldrobTryLaserCode", true)
addEventHandler("goldrobTryLaserCode", root, function(laserCode)
    if not client then client = source end
    if laserCode == tonumber(goldrobDatas.Code) then
        goldrobDatas.laserDeactivated = true
        triggerClientEvent("goldrobSyncLaserOtherSide", client, false, goldrobDatas.laserDeactivated)
    end
end)



addEvent("tryToHackGoldrobInside", true)
addEventHandler("tryToHackGoldrobInside", getRootElement(), function()
    if client and client == source then
        if goldrobDatas.ElementStates.insideKeypad == "notinuse" then
            triggerClientEvent(client, "goldrobInsideHackStarted", client, false)
        elseif goldrobDatas.ElementStates.insideKeypad == "pried" then
            triggerClientEvent(client, "goldrobInsideHackStarted", client, true)
            goldrobDatas.ElementStates.insideKeypad = "inuse"
        elseif goldrobDatas.ElementStates.insideKeypad == "inuse" then
            exports.sGui:showInfobox(client, "e", "Már valaki próbákozik")
        elseif goldrobDatas.ElementStates.insideKeypad == "unusable" then
            exports.sGui:showInfobox(client, "e", "Ezt az ajtót már csak belülről lehet kinyitni!")
            return
        end
    end
end)

addEvent("endGoldrobInsidePry", true)
addEventHandler("endGoldrobInsidePry", root, function(state)
    if client and client == source then
        triggerClientEvent("gotGoldrobInsideKeypadState", client, true)
        goldrobDatas.ElementStates.insideKeypad = "pried"
    end
end)

local cuttedBars = 0
local playerHeating = {}
local heatedBars = {}
addEvent("syncGoldrobBarHeat", true)
addEventHandler("syncGoldrobBarHeat", root, function(heatedBar, cuttedBar, DEVCutID)
    if not client then client = source end
    if heatedBar then
        if not heatedBars[heatedBar] then
            heatedBars[heatedBar] = {}
        end
    end
    
    if heatedBar then
        triggerClientEvent("syncGoldrobBarHeat", client, heatedBar, client)
    else
        triggerClientEvent("syncGoldrobBarHeat", client, playerHeating[client], heatedBars)
    end

    if cuttedBar then
        triggerClientEvent("syncGoldrobBarCut", resourceRoot, playerHeating[client])
        playerHeating[client] = nil
        cuttedBars = cuttedBars + 1
    end
    playerHeating[client] = heatedBar

    if cuttedBar and cuttedBars == 14 then
        local doneCuts = {}
        for i = 1, cuttedBars do
            doneCuts[i] = true
        end
        triggerClientEvent("syncGoldrobAllBarCut", resourceRoot, doneCuts)
        cuttedBars = 0
    end
end)

addCommandHandler("robgoldbank", function(sourcePlayer)
    if exports.sPermission:hasPermission(sourcePlayer, "debugperm") then
        triggerEvent("goldrobWheelMinigameEnd", sourcePlayer, true)
        triggerEvent("goldrobTryLaserCode", sourcePlayer, goldrobDatas.Code)

        for i = 1, 14 do
            triggerEvent("syncGoldrobBarHeat", sourcePlayer, i, i)
        end
    end
end)

local loots = {}

addEvent("goldrobSyncVaultHit", true)
addEventHandler("goldrobSyncVaultHit", root, function(row, column, pried, final)
    triggerClientEvent("goldrobSyncVaultHit", client, row, column, pried, final)
    if final then
        if not loots[row] then
            loots[row] = {}
        end
        local randomItem = chooseRandomItem()
        loots[row][column] = randomItem
        triggerClientEvent("goldrobSyncVaultOpen", client, row, column, randomItem)
    end
end)

local goldrobMoney = {45000, 100000}

addEvent("goldrobLootVault", true)
addEventHandler("goldrobLootVault", root, function(lootRow, lootColumn)
    if loots[lootRow][lootColumn] == "money" then
        local moneyAmount = math.random(goldrobMoney[1], goldrobMoney[2])
        exports.sCore:giveMoney(client, moneyAmount)
        
        exports.sChat:localAction(client, "kivesz valamit a széfből. (" .. exports.sGui:thousandsStepper(moneyAmount) .. " $ készpénz)")
    else
        local itemWeight = exports.sItems:getItemWeight(loots[lootRow][lootColumn])
        local currentWeight = exports.sItems:getCurrentWeight(client)
        local weightLimit = exports.sItems:getWeightLimit(getElementType(client),   client)
        if itemWeight + currentWeight > weightLimit then
            exports.sGui:showInfobox(client, "e", "Nem fér el nálad ez a tárgy!")
            return
        end
        exports.sItems:giveItem(client, loots[lootRow][lootColumn], 1)
        exports.sChat:localAction(client, "kivesz valamit a széfből. (" .. exports.sItems:getItemName(loots[lootRow][lootColumn]) .. ")")
    end
    triggerClientEvent("goldrobSyncVaultLooted", client, lootRow, lootColumn)
end)

addEvent("pickUpGoldBar", true)
addEventHandler("pickUpGoldBar", root, function(goldbarIdentity)
    setElementData(client, "carryingGold", goldbarIdentity)
    if not goldCrates[playerCrates[client]] then 
        if playerCrates[client] then
            if not goldCrates[playerCrates[client]] then
                goldCrates[playerCrates[client]] = true
            end
            triggerClientEvent("gotGoldrobCrateGold", client, playerCrates[client], goldbarIdentity)
        end
    else
        exports.sGui:showInfobox(client, "e", "A te ládádban már van egy aranyrúd!")
    end
end)

addEvent("goldrobInsideHacked", true)
addEventHandler("goldrobInsideHacked", root, function(hackState)
    goldrobDatas.ElementStates.insideKeypad = "unusable"

    if hackState then
        goldrobDatas.Doors.InsideDoor = hackState
        triggerClientEvent("goldrobGotInsideDoor", client, goldrobDatas.Doors.InsideDoor)
        exports.sGui:showInfobox(client, "i", "Az ajtó csak 10 másodpercig marad nyitva, biztonsági okokból, utána bentről lehet kinyitni!")
        setTimer(function()
            goldrobDatas.Doors.InsideDoor = false
            triggerClientEvent("goldrobGotInsideDoor", resourceRoot, goldrobDatas.Doors.InsideDoor)
        end, 10000, 1)
    else
        goldrobDatas.Doors.InsideDoor = hackState
        triggerClientEvent("goldrobGotInsideDoor", client, goldrobDatas.Doors.InsideDoor)
    end
end)

addEvent("goldrobReleaseDoorPD", true)
addEventHandler("goldrobReleaseDoorPD", root, function()
    goldrobDatas.Doors.InsideDoor = true
    triggerClientEvent("goldrobGotInsideDoor", client, goldrobDatas.Doors.InsideDoor)
    setTimer(function()
        goldrobDatas.Doors.InsideDoor = false
        triggerClientEvent("goldrobGotInsideDoor", resourceRoot, goldrobDatas.Doors.InsideDoor)
    end, 10000, 1)
end)

addEvent("goldrobTakeGold", false)
addEventHandler("goldrobTakeGold", root, function(policeDepartment)
    if goldCrates[playerCrates[source]] then
        if policeDepartment then
            local lawPlayers = {}

            for playerIndex, playerElement in pairs(getElementsByType("player")) do
                local playerGroups = exports.sGroups:getPlayerGroups(playerElement)
                
                if playerGroups then
                    for k, v in pairs(playerGroups) do
                        if exports.sGroups:isLawEnforcementGroup(k) then
                            local alreadyAdded = false
                            for _, lawPlayer in ipairs(lawPlayers) do
                                if lawPlayer == playerElement then
                                    alreadyAdded = true
                                    break
                                end
                            end
                            if not alreadyAdded then
                                table.insert(lawPlayers, playerElement)
                            end
                        end
                    end
                end
            end

            for _, playerElement in pairs(lawPlayers) do
                outputChatBox("[color=sightblue][SightMTA - Aranybank]: [color=sightblue]"..getElementData(source, "char.name"):gsub("_", " ").." [color=hudwhite]leadott egy aranyládát, így jutalomban részesültél! [color=sightblue][500PP, 25.000$]", playerElement)

                exports.sCore:giveMoney(playerElement, 25000)
                exports.sCore:givePP(playerElement, 500)
            end
        end

        setElementData(source, "carryingGold", false)
        goldCrates[playerCrates[source]] = false

        triggerClientEvent("gotGoldrobCrateGold", source, playerCrates[source], nil)
    end
end)

local pedDetails = {
    {
        pedName = "Dennis Mercury",
        nameType = "Aranybank",
        pedPosition = {1606.7272949219, -1621.7241210938, 13.537803649902},
        pedRotation = {0, 0, 90},
        pedSkin = 3,
    },
}

local pedElements = {}
local goldbarColshape

addEventHandler("onResourceStart", resourceRoot, function()
    for pedIndex, pedData in pairs(pedDetails) do
        local pedPosition = pedData.pedPosition
        local pedRotation = pedData.pedRotation
        pedElements[pedIndex] = createPed(pedData.pedSkin, pedPosition[1], pedPosition[2], pedPosition[3])
        setElementRotation(pedElements[pedIndex], pedRotation[1], pedRotation[2], pedRotation[3])
        setElementData(pedElements[pedIndex], "visibleName", pedData.pedName)
        setElementData(pedElements[pedIndex], "pedNameType", pedData.nameType)
        setElementData(pedElements[pedIndex], "invulnerable", true)
        setElementFrozen(pedElements[pedIndex], true)
        if pedData.nameType == "Aranybank" then
            goldbarColshape = createColSphere(pedPosition[1], pedPosition[2], pedPosition[3], 2)
        end
    end
end)

addEventHandler("onColShapeHit", getRootElement(), function(playerElement, matchingDimension)
    if playerElement and matchingDimension and getElementType(playerElement) == "player" then
        if source == goldbarColshape then
            triggerEvent("goldrobTakeGold", playerElement, true)
        end
    end
end)

addEventHandler("onPlayerClick", root, function(playerButton, buttonState, clickedElement)
    if buttonState == "down" and clickedElement and getElementType(clickedElement) == "ped" and getElementData(clickedElement, "pedNameType") == "Aranybank" then
        local playerGroups = exports.sGroups:getPlayerGroups(source)
        if playerGroups then
            local selectedGroup = false
            for groupPrefix, groupData in pairs(playerGroups) do
                if exports.sGroups:isLawEnforcementGroup(groupPrefix) then
                    selectedGroup = groupPrefix
                    break
                end
            end

            if selectedGroup then
                local playerPosition = {getElementPosition(source)}
                local pedPosition = {getElementPosition(clickedElement)}
                local clickDistance = getDistanceBetweenPoints3D(playerPosition[1], playerPosition[2], playerPosition[3], pedPosition[1], pedPosition[2], pedPosition[3])
                if clickDistance > 3 then
                    return
                end

                local policeCol = exports.sImpound:getPoliceColshape()
                if policeCol then
                    local colVehicles = getElementsWithinColShape(policeCol, "vehicle")
                    if colVehicles then
                        local securiCarIdentity = false
                        local selectedSecuricar
                        for vehicleIndex, vehicleElement in pairs(colVehicles) do
                            if getElementData(vehicleElement, "bankrob.vehicleid") then
                                securiCarIdentity = getElementData(vehicleElement, "bankrob.vehicleid")
                                selectedSecuricar = vehicleElement
                            end
                        end

                        if securiCarIdentity then
                            for k, v in pairs(playerCrates) do
                            end
                            
                            for crateIdentity = (vehicleCrates[securiCarIdentity] - 8), 8 do
                                for playerElement, playerCrate in pairs(playerCrates) do
                                    if playerCrate == crateIdentity then
                                        triggerClientEvent("npcChatBubble", clickedElement, "say", "Hiányzik egy láda az aranyszállítóból!")
                                        return
                                    end
                                end

                                if goldCrates[crateIdentity] then
                                    triggerClientEvent("npcChatBubble", clickedElement, "say", "Add le nekem az aranyládákat előtte!")
                                    return
                                end
                            end

                            if selectedSecuricar and isElement(selectedSecuricar) and getElementType(selectedSecuricar) == "vehicle" then
                                destroyElement(selectedSecuricar)
                                triggerClientEvent("npcChatBubble", clickedElement, "say", "Gratulálok, sikerült leadnod.")
                                triggerClientEvent("npcChatBubble", clickedElement, "say", "A sikeres leadást követően a rendészeti szervezetek jutalomban részesültek. ((500PP, 50.000$))")
                            
                                local lawPlayers = {}

                                for playerIndex, playerElement in pairs(getElementsByType("player")) do
                                    local playerGroups = exports.sGroups:getPlayerGroups(playerElement)
                                    
                                    if playerGroups then
                                        for k, v in pairs(playerGroups) do
                                            if exports.sGroups:isLawEnforcementGroup(k) then
                                                local alreadyAdded = false
                                                for _, lawPlayer in ipairs(lawPlayers) do
                                                    if lawPlayer == playerElement then
                                                        alreadyAdded = true
                                                        break
                                                    end
                                                end
                                                if not alreadyAdded then
                                                    table.insert(lawPlayers, playerElement)
                                                end
                                            end
                                        end
                                    end
                                end
                    
                                for _, playerElement in pairs(lawPlayers) do
                                    outputChatBox("[color=sightblue][SightMTA - Aranybank]: [color=sightblue]"..getElementData(source, "char.name"):gsub("_", " ").." [color=hudwhite]leadta a pénzszállítót, így jutalomban részesültél! [color=sightblue][500PP, 50.000$]", playerElement)
                    
                                    exports.sCore:giveMoney(playerElement, 50000)
                                    exports.sCore:givePP(playerElement, 500)
                                end
                            end
                        end
                    else
                        outputChatBox("Nem áll pénzszállító autó a colshapeban!", source)
                    end
                end
            end
        end
    end
end)

addEvent("repairGoldrobGarage", true)
addEventHandler("repairGoldrobGarage", root, function()

    local closedPosition = garageDatas.closedPosition

    moveObject(goldrobDatas.ElementStates.Garage.objectElement, 5000, closedPosition[1], closedPosition[2], closedPosition[3])


    goldrobDatas.ElementStates.Garage.garageKeypad = false

    triggerClientEvent("gotGoldrobGarageKeypadState", client, false)

    triggerClientEvent("gotGoldrobGarageAlarm", client, false)

    triggerClientEvent("gotGoldrobGarageOpen", client, false)

    triggerClientEvent(client, "showInfobox", client, "success",
    "Megjavítottad a zárat!", 4000)

    goldrobDatas.Doors.GarageDoor = false
end)