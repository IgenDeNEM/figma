local playerExams = {}
local plateCount = 0
local doneExam = {}

local vehicleX, vehicleY, vehicleZ = 1062.4799804688, -1772.6009521484, 13.355380058289

addEvent("tryToStartDrivingQuestionExam", true)
addEventHandler("tryToStartDrivingQuestionExam", root,
    function ()
        local money = exports.sCore:getMoney(client)

        if money >= examPrice1 then
            exports.sCore:setMoney(client, money - examPrice1)
            setElementData(client, "char.Money", money - examPrice1)

            triggerClientEvent(client, "startDrivingQuestionExam", client)
        else
            triggerClientEvent(client, "showInfobox", client, "e", "Nincs elég pénzed a vizsga elkezdéséhez!")
        end
    end
)

addEvent("drivingQuestionExamResult", true)
addEventHandler("drivingQuestionExamResult", root,
    function (pass)
        if pass then
            local characterId = getElementData(client, "char.ID")

            doneExam[client] = true
        end
    end
)

addCommandHandler("givekresz", function(sourcePlayer, commandName, targetPlayer)
    if exports.sPermission:hasPermission(sourcePlayer, "givekresz") then
        if not targetPlayer then
            outputChatBox("[color=sightblue][SightMTA - Használat]: [color=hudwhite]/" .. commandName .. " [Játékos Név / ID]", sourcePlayer, 255, 255, 255, true)
            return
        end

        local targetPlayer, targetName = exports.sCore:findPlayer(sourcePlayer, targetPlayer)
        local adminName = getElementData(sourcePlayer, "acc.adminNick")

        if targetPlayer then
            doneExam[targetPlayer] = true

            outputChatBox("[color=sightgreen][SightMTA - Kresz]: [color=hudwhite]Sikeresen elvégezted a [color=sightblue]"..targetName.." [color=hudwhite]kresz vizsgáját, mostmár csinálhatja a gyakorlatot.", sourcePlayer)
            outputChatBox("[color=sightgreen][SightMTA - Kresz]: [color=sightblue]"..adminName.." [color=hudwhite]adott egy kresz vizsgát neked, mostmár csinálhatod a gyarkorlatot.", targetPlayer)
        end
    end
end)

addCommandHandler("givejogsi", function(sourcePlayer, commandName, targetPlayer)
    if exports.sPermission:hasPermission(sourcePlayer, "givejogsi") then
        if not targetPlayer then
            outputChatBox("[color=sightblue][SightMTA - Használat]: [color=hudwhite]/" .. commandName .. " [Játékos Név / ID]", sourcePlayer, 255, 255, 255, true)
            return
        end

        local targetPlayer, targetName = exports.sCore:findPlayer(sourcePlayer, targetPlayer)
        local adminName = getElementData(sourcePlayer, "acc.adminNick")

        if targetPlayer then
            setElementData(targetPlayer, "char.drivingLicense", 1)

            outputChatBox("[color=sightgreen][SightMTA - Kresz]: [color=hudwhite]Sikeresen elvégezted a [color=sightblue]"..targetName.." [color=hudwhite]gyakorlati vizsgáját, mostmár kiválthatja a városházán.", sourcePlayer)
            outputChatBox("[color=sightgreen][SightMTA - Kresz]: [color=sightblue]"..adminName.." [color=hudwhite]adott egy gyakorlati vizsgát neked, mostmár kiválthatja a városházán.", targetPlayer)
        end
    end
end)

addEvent("tryToStartDrivingExam", true)
addEventHandler("tryToStartDrivingExam", root,
    function (instructorId)
        local doneExam = doneExam[client]

        if doneExam then
            startDrivingExam(client, instructorId)
        else
            triggerClientEvent(client, "showInfobox", client, "e", "Még nincs sikeres KRESZ vizsgád!")
        end
    end
)

addEvent("endStudentDriverExam", true)
addEventHandler("endStudentDriverExam", root,
    function ()
        endExam(client)
    end
)

addEventHandler("onPlayerQuit", root,
    function ()
        endExam(source)
    end
)

function startDrivingExam(playerElement, instructorId)
    local money = exports.sCore:getMoney(playerElement)

    if money >= examPrice2 then
        local instructorData = instructors[instructorId]

        if instructorData then
            math.randomseed(getTickCount())
            local randomPosition = math.random(9)
            local spawnX, spawnY, spawnZ = vehicleX, vehicleY + (randomPosition * 2.95), vehicleZ
                
            exports.sCore:setMoney(playerElement, money - examPrice2)

            playerExams[playerElement] = {}
            plateCount = plateCount + 1 > 99 and 1 or plateCount + 1

            playerExams[playerElement].vehicle = createVehicle(instructorData.vehicle, spawnX, spawnY, spawnZ, 0, 0, -90, "TANULO" .. (plateCount > 9 and plateCount or "0" .. plateCount))
            setVehicleColor(playerExams[playerElement].vehicle, 255, 255, 255)
            setVehicleLocked(playerExams[playerElement].vehicle, true)
            setElementData(playerExams[playerElement].vehicle, "vehicle.currentTexture", instructorData.paintjob)
            setElementData(playerExams[playerElement].vehicle, "vehicle.fuel", 100)
            setElementData(playerExams[playerElement].vehicle, "vehicle.exam", true)
            setElementData(playerExams[playerElement].vehicle, "studentDriver", true)
            setElementData(playerExams[playerElement].vehicle, "vehicle.handbrake", true)

            playerExams[playerElement].instructor = createPed(instructorData.skin, spawnX, spawnY, spawnZ)
            setElementData(playerExams[playerElement].instructor, "visibleName", instructorData.name)
            setElementData(playerExams[playerElement].instructor, "pedNameType", "Gyakorlati oktató")
            warpPedIntoVehicle(playerExams[playerElement].instructor, playerExams[playerElement].vehicle, 1)

            playerExams[playerElement].currentTask = 1
            playerExams[playerElement].checkTimer = setTimer(checkDrivingExamTask, 100, 0, playerElement)

            triggerClientEvent(client, "showInfobox", client, "i", "Megkezdted a gyakorlati vizsgát! Az oktató kinn vár a parkolóban!")
            triggerClientEvent(client, "setCurrentVehicleExamTask", client, playerExams[playerElement].currentTask, false, false, false, playerExams[playerElement].vehicle)
        end
    else
        triggerClientEvent(playerElement, "showInfobox", playerElement, "e", "Nincs elég pénzed a gyakorlati vizsga elkezdéséhez!")
    end
end

function checkDrivingExamTask(playerElement)
    local examData = playerExams[playerElement]

    if examData then
        local currentTask = examData.currentTask
        local taskData = tasks[currentTask]

        if taskData then
            local taskDoneState = taskData.check(playerElement, examData.vehicle, examData)

            if taskDoneState then
                local x, y, z

                if taskData.afterTip then
                    triggerClientEvent(playerElement, "showInfobox", playerElement, "i", "Tipp: " .. taskData.afterTip)
                end

                examData.currentTask = examData.currentTask + 1

                taskData = tasks[examData.currentTask]

                if taskData then
                    if taskData.cityBlip or taskData.countryBlip then
                        local randomBlip = taskData.cityBlip and math.random(#cityPoses) or math.random(#countryPoses)

                        x, y, z = unpack(taskData.cityBlip and cityPoses[randomBlip] or countryPoses[randomBlip])

                        if taskData.cityBlip then
                            examData.cityCol = createColSphere(x, y, z, 3.5)
                        else
                            examData.countryCol = createColSphere(x, y, z, 3.5)
                        end
                    elseif taskData.getBackBlip then
                        x, y, z = unpack(getBackPos)

                        examData.getBackCol = createColSphere(x, y, z, 3.5)
                    end

                    if taskData.tip then
                        triggerClientEvent(playerElement, "showInfobox", playerElement, "i", "Tipp: " .. taskData.tip)
                    end

                    triggerClientEvent(playerElement, "setCurrentVehicleExamTask", playerElement, examData.currentTask, x, y, z, not x and examData.vehicle)
                else
                    local characterId = getElementData(playerElement, "char.ID")

                    triggerClientEvent(playerElement, "showInfobox", playerElement, "s", "Sikerült a gyakorlati vizsgád!")
                    triggerClientEvent(playerElement, "showInfobox", playerElement, "i", "Vezetői engedélyed a városházán tudod kiváltani.")
                    triggerClientEvent(playerElement, "setCurrentVehicleExamTask", playerElement, false)    

                    setElementData(playerElement, "char.drivingLicense", 1)

                    endExam(playerElement)
                end
            end
        end
    end
end

function endExam(client)
    local examData = playerExams[client]

    if examData then
        if isElement(examData.vehicle) then
            destroyElement(examData.vehicle)
        end

        if isElement(examData.instructor) then
            destroyElement(examData.instructor)
        end

        if isElement(examData.cityCol) then
            destroyElement(examData.cityCol)
        end

        if isElement(examData.countryCol) then
            destroyElement(examData.countryCol)
        end

        if isElement(examData.getBackCol) then
            destroyElement(examData.getBackCol)
        end

        if isTimer(examData.checkTimer) then
            killTimer(examData.checkTimer)
        end

        playerExams[client] = nil
    end
end

local gateX, gateY, gateZ = 1101.90283, -1736.10559, 13.57969
local secondaryGateX, secondaryGateY, secondaryGateZ = 1101.87256, -1745.06042, 13.44366
local gateRotation = 270
local gateID = 976

local offsetX = 0.00001
local offsetY = -0.01
local offsetZ = -1.4

local gate = createObject(gateID, gateX + offsetX, gateY + offsetY, gateZ + offsetZ, 0, 0, gateRotation)

local gateMoveDistance = 5
local gateMoveSpeed = 2000
local isGateOpen = false

function openGate()
    if not isGateOpen then
        local newGateX = secondaryGateX + offsetX
        local newGateY = secondaryGateY + offsetY
        local newGateZ = secondaryGateZ + offsetZ
        moveObject(gate, gateMoveSpeed, newGateX, newGateY, newGateZ)
        isGateOpen = true
    end
end

function closeGate()
    if isGateOpen then
        local originalGateX = gateX + offsetX
        local originalGateY = gateY + offsetY
        local originalGateZ = gateZ + offsetZ
        moveObject(gate, gateMoveSpeed, originalGateX, originalGateY, originalGateZ)
        isGateOpen = false
    end
end

local colShape = createColSphere(gateX + offsetX, gateY + offsetY, gateZ + offsetZ, 10)

addEventHandler("onColShapeHit", colShape, 
    function(element)
        if getElementType(element) == "vehicle" then
            if getElementData(element, "vehicle.exam") then
                openGate()
            end
        end
    end
)

addEventHandler("onColShapeLeave", colShape, 
    function(element)
        if getElementType(element) == "vehicle" then
            if getElementData(element, "vehicle.exam") then
                closeGate()
            end
        end
    end
)