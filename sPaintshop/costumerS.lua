local emailProcessingTimers = {}
mailCache  = {}

function getReplyStyle(id)
  if id == 4 or id == 5 then
    return "company"
  elseif id == 9 or id == 14 then
    return "casual"
  elseif id == 1 or id == 2 or id == 3 or id == 10 then
    return "formal"
  else
    return "neutral"
  end
end

function createWorkshopRating(overallRating, workshopIdentity, from, visszamondas)
    local possibleTexts = {}
    for k, v in pairs(jobRatingTexts) do
        if v[2] <= overallRating and v[3] >= overallRating then
            if visszamondas then
                if v[4] then
                    table.insert(possibleTexts, k)
                end
            else
                if not v[4] then
                    table.insert(possibleTexts, k)
                end
            end
        end
    end

    local workshopData = getWorkshopSavedData(workshopIdentity)

    mailCache[workshopIdentity] = workshopData.mails or {}
    local workshopMails = mailCache[workshopIdentity]

    local mailIdentity = (#workshopMails or 0) + 1
    workshopMails[mailIdentity] = {}

    workshopMails[mailIdentity].emailType = "rating"
    workshopMails[mailIdentity].jobRating = overallRating

    workshopMails[mailIdentity].jobRatingTextId = possibleTexts[math.random(1, #possibleTexts)]
    workshopMails[mailIdentity].lastEmailTime = getRealTimestamp()
    workshopMails[mailIdentity].from = from

    local workshopRating = workshopData.cert or {0, 0}
    workshopRating[1] = (workshopRating[1] or 0) + overallRating
    workshopRating[2] = (workshopRating[2] or 0) + 1

    triggerClientEvent(playersInWorkshop[workshopIdentity], "refreshPaintshopEmail", root, workshopIdentity, mailIdentity, workshopMails[mailIdentity], true)
    saveWorkshopData(workshopIdentity, {mails = workshopMails})
    saveWorkshopData(workshopIdentity, {cert = workshopRating})
end

function createWorkshopOffer()
    local customerType = math.random(1, 14)
    local customerStyle = getReplyStyle(customerType)
    local costumerName

    if customerStyle == "company" then
        customerName = math.random(1, #companies)
    else
        customerName = {math.random(1, #firstNames), math.random(1, #lastNames)}
    end

    local selectedVehicle = selectRandomVehicle(customerStyle == "company" and math.random(4, 5) or math.random(1, 3))

    local vehicleDetails = {
        model = selectedVehicle.vehicleID,
        color = selectedVehicle.color,
        paintMetal = math.random(1, 2) == 1,
        partNames = selectedVehicle.partNames,
        plate = math.random(100000, 999999)
    }

    local offerTitle = customerStyle == "company" and math.random(1, 2) or math.random(1, 5)

    return {
        emailType = "offer",
        customerType = customerType,
        from = customerName,

        titleId = offerTitle,
        textId = customerType,
        referrer = math.random(#emailReferrer),
        emailTime = getRealTimestamp(),

        model = vehicleDetails.model,
        paint = vehicleDetails.color,
        paintMetal = vehicleDetails.paintMetal,
        partNames = vehicleDetails.partNames,

        plate = vehicleDetails.plate,

        pictureName = selectedVehicle.pictureName,
        maskName = selectedVehicle.maskName,

        price = calculateVehiclePrice(vehicleDetails.partNames),

        serverDatas = {
            model = vehicleDetails.model,   
            paint = vehicleDetails.color,
            paintMetal = vehicleDetails.paintMetal,
            partNames = vehicleDetails.partNames,

            plate = vehicleDetails.plate,

            pictureName = selectedVehicle.pictureName,
            maskName = selectedVehicle.maskName,
        
            price = calculateVehiclePrice(vehicleDetails.partNames)
        }
    }
end

function handleWorkshopSubscribe(workshopIdentity, subState)
    if subState and workshopIdentity then
        if not emailProcessingTimers[workshopIdentity] and not isTimer(emailProcessingTimers[workshopIdentity]) then
            setTimer(function()
                processWorkshopEmails(workshopIdentity)
            end, 5000, 1)

            emailProcessingTimers[workshopIdentity] = setTimer(processWorkshopEmails, 60000, 0, workshopIdentity)        
        end
    elseif not subState then
        if emailProcessingTimers[workshopIdentity] and isTimer(emailProcessingTimers[workshopIdentity]) then
            killTimer(emailProcessingTimers[workshopIdentity])
            emailProcessingTimers[workshopIdentity] = nil
        end
    end
end

function processWorkshopEmails(workshopIdentity, forcePlayer, forceEmail, forceReply, forceTimeout)
    local workshopIdentity = tonumber(workshopIdentity)
    local workshopData = getWorkshopSavedData(workshopIdentity)


    mailCache[workshopIdentity] = workshopData.mails or {}

    if not mailCache[workshopIdentity] then
        mailCache[workshopIdentity] = workshopData.mails or {}
    end
    local workshopMails = mailCache[workshopIdentity]

    local lastMail = tonumber(workshopData.lastMail) or 0
    if (tonumber(lastMail) <= 0) or forceEmail then
        if forceEmail then
            outputChatBox("[color=sightyellow][SightMTA - Paintshop (DEV)]: [color=hudwhite]Sikeresen forceoltál egy email-t", forcePlayer)
        end

        lastMail = 30
        local newWorkshopEmail = createWorkshopOffer()
        local mailIdentity = (#workshopMails or 0) + 1
        workshopMails[mailIdentity] = {}
        workshopMails[mailIdentity] = newWorkshopEmail

        workshopMails[mailIdentity].offerTimeout = math.random(60, 120)
        triggerClientEvent(playersInWorkshop[workshopIdentity], "refreshPaintshopEmail", root, workshopIdentity, mailIdentity, workshopMails[mailIdentity], true)
    else
        updateSave = true
        lastMail = lastMail - 1
    end

    local chance = {
        [1] = 100,
        [2] = 85,
        [3] = 60,
        [4] = 25
    }

    for mailId, mailData in pairs(workshopMails) do
        if mailData then
            if (mailData.customerReplyWait or false) and not mailData.declined then
                if (mailData.customerReplyWait <= 0 or forceReply) and not mailData.offerReplyWait then
                    mailData.offerReplyTime = getRealTimestamp()
                    mailData.offerReplyRnd = math.random(1, 4)

                    local workshopData = getWorkshopSavedData(workshopIdentity)

                    local workshopRating = workshopData.cert

                    if not workshopRating then
                        workshopRating = {}
                    end

                    if not workshopRating[1] then
                        workshopRating[1] = 1
                    end

                    if not workshopRating[2] then
                        workshopRating[2] = 1
                    end

                    local overall = workshopRating[2] / workshopRating[1]

                    for i = 1, 4 do
                        chance[i] = chance[i] + (overall * 3)
                    end
                                              
                    if math.random(1, 100) <= chance[mailData.playerReplyPrice] then
                        --elfogadva
                        mailData.offerReply = true
                    else
                        --elutasitva
                        mailData.offerReply = false
                    end

                    mailData.offerReplyWait = math.random(60, 120)
                    triggerClientEvent(playersInWorkshop[workshopIdentity], "refreshPaintshopEmail", root, workshopIdentity, mailId, mailData, true)
                else
                    mailData.customerReplyWait = mailData.customerReplyWait - 1
                end
            end
            
            if (mailData.offerReplyWait or false) and not mailData.declined then
                if (mailData.offerReplyWait <= 0 or forceTimeout) then
                    mailData.offerStartTimeoutRnd = math.random(1, 4)
                    if not mailData.offerStartTimeoutTime then
                        mailData.offerStartTimeoutTime = getRealTimestamp()
                    end
                    mailData.offerReply = "timeout"
                    triggerClientEvent(playersInWorkshop[workshopIdentity], "refreshPaintshopEmail", root, workshopIdentity, mailId, mailData, false)
                else
                    mailData.offerReplyWait = mailData.offerReplyWait - 1
                end
            end
        end
    end

    saveWorkshopData(workshopIdentity, {lastMail = lastMail})
    saveWorkshopData(workshopIdentity, {mails = workshopMails})
end

addEvent("readPaintshopEmail", true)
addEventHandler("readPaintshopEmail", root, function(emailId)
    local workshopIdentity = getElementDimension(client)
    local workshopData = getWorkshopSavedData(workshopIdentity)

    mailCache[workshopIdentity] = workshopData.mails or {}

    local currentMail = mailCache[workshopIdentity][emailId]
    
    currentMail.unread = false
    triggerClientEvent(playersInWorkshop[workshopIdentity], "refreshPaintshopEmail", client, workshopIdentity, emailId, currentMail, false)
    saveWorkshopData(workshopIdentity, {mails = mailCache[workshopIdentity]})
end)

addEvent("tryToMakePaintShopOffer", true)
addEventHandler("tryToMakePaintShopOffer", root, function(emailId, priceId)
    local workshopIdentity = getElementDimension(client)
    local workshopData = getWorkshopSavedData(workshopIdentity)

    mailCache[workshopIdentity] = workshopData.mails or {}

    if not mailCache[workshopIdentity] then
        mailCache[workshopIdentity] = workshopData.mails
    end

    local workshopMails = mailCache[workshopIdentity]
    local currentMail = workshopMails[emailId]

    currentMail.unread = true
    if not priceId then
        currentMail.offerReply = priceId
        currentMail.emailType = "offer"
        currentMail.offerReplyTime = getRealTimestamp()
    else
        currentMail.playerReplyPrice = priceId

        currentMail.playerReplyTime = getRealTimestamp()
        currentMail.playerReply = {
            emailId,
            math.random(1, 2)
        }
        currentMail.customerReplyWait = math.random(15, 60)
    end

    triggerClientEvent(playersInWorkshop[workshopIdentity], "refreshPaintshopEmail", client, workshopIdentity, emailId, currentMail, false)
    saveWorkshopData(workshopIdentity, {mails = mailCache[workshopIdentity]})
end)

addEvent("tryToStartPaintshopJob", true)
addEventHandler("tryToStartPaintshopJob", root, function(emailId)
    local workshopIdentity = getElementDimension(client)

    local workshopData = getWorkshopSavedData(workshopIdentity)
    local workshopWorks = workshopData.paintshopWorks

    mailCache[workshopIdentity] = workshopData.mails or {}

    if not workshopWorks[workshopIdentity] then
        workshopWorks[workshopIdentity] = {}
    end

    local index = false

    if not workshopWorks[1] then
        index = 1
    end

    if not workshopWorks[2] then
        index = 2
    end

    if not index then
        exports.sGui:showInfobox(client, "e", "Nincs szabad hely a műhelyedben!")
        return
    end

    if not mailCache[workshopIdentity] then
        mailCache[workshopIdentity] = workshopData.mails
    end

    local workshopMails = mailCache[workshopIdentity]
    local currentMail = workshopMails[emailId]

    currentMail.emailType = "job"

    currentMail.jobStartTime = getRealTimestamp()

    currentMail.workId = index

    saveWorkshopData(workshopIdentity, {mails = mailCache[workshopIdentity]})

    local vehicleData = initalizeVehicle(workshopData, currentMail.serverDatas, currentMail.workId, workshopIdentity, currentMail.from, emailId)
    local paintshopWorks = workshopData.paintshopWorks

    triggerClientEvent(playersInWorkshop[workshopIdentity], "gotNewPaintshopWork", client, workshopIdentity, index, vehicleData)
    triggerClientEvent(playersInWorkshop[workshopIdentity], "refreshPaintshopEmail", client, workshopIdentity, emailId, currentMail, false)
end)

function initalizeVehicle(a, vehicleData, wID, workshopIdentity, from, emailId)
    local workshopData = getWorkshopSavedData(workshopIdentity)

    local vehData = vehicleData
    local vehicleData = {
        emailId = emailId,
        from = from,
        workId = wID,
        color = vehData.paint,
        transportTrailer = true,
        model = vehData.model,
        state = "transportIn",
        dryingState = false,
        metal = vehData.paintMetal,
        partNames = vehData.partNames,
        lastPercent = 0,
        sandingQuality = 0,
        primerQuality = 0,
        paintQuality = 0,
        price = vehData.price,
        dataPath = vehData.pictureName,
        plate = vehData.plate
    }

    workshopData.paintshopWorks[wID] = vehicleData
    saveWorkshopData(workshopIdentity, workshopData)
    return vehicleData
end

local vehicleColspheres = {}
local colToWork = {} 
local vehicleStates = {}

addEvent("startPaintshopDeliveryIn", true)
addEventHandler("startPaintshopDeliveryIn", root, function(workId)

    local workshopIdentity  = getElementDimension(client)

    local workshopData = getWorkshopSavedData(workshopIdentity)
    
    local works = workshopData.paintshopWorks

    local freeIndex = false
    if not works[2] then
        freeIndex = 2
    end

    if not works[1] then
        freeIndex = 1
    end

    if not freeIndex then
        if works[2] then
            if works[2].state and works[2].state == "transportIn" then
                freeIndex = 2
            end
        end
        if works[1] then
            if works[1].state and works[1].state == "transportIn" then
                freeIndex = 1
            end
        end
    end

    if freeIndex then

        local vehicleOrigin = math.random(1, #dropoffPoses)

        initalizeVehicleColsphere(vehicleOrigin, workshopIdentity, workId)
        triggerClientEvent(client, "createPaintshopTargetMarker", client, vehicleOrigin, false)
        exports.sGui:showInfobox(client, "s", "Megkezdted a jármű leszállítását! (Zöld ikon a térképen)")
    else
        exports.sGui:showInfobox(client, "e", "Nincs szabad hely a műhelyedben!")
    end
end)

function initalizeVehicleColsphere(vehicleOrigin, workshopIdentity, workId)
    if vehicleColspheres[workshopIdentity] and isElement(vehicleColspheres[workshopIdentity]) then
        destroyElement(vehicleColspheres[workshopIdentity])
    end

    local pos = dropoffPoses[vehicleOrigin]
    local col = createColSphere(pos[1], pos[2], pos[3], 2)
    setElementInterior(col, 0)
    setElementDimension(col, 0)

    colToWork[col] = {
        workshopId = workshopIdentity,
        workId     = workId
    }

    vehicleColspheres[workshopIdentity] = col
end

dropoffColsphere = {}

function initalizeDropoffColshape(dropOff, workshopIdentity)
    if dropoffColsphere[workshopIdentity] then
        return
    end

    local doorId, aisleId, insideId = getAisleFromWorkshop(workshopIdentity)
    local dropOffPos = {}
    local dim = 0

    if dropOff then
        dim = aisleId
        dropOffPos = {unpack(aisleDoors[insideId])}
    end

    local rad = math.rad(dropOffPos[4]) - math.pi / 2
    dropOffPos[1] = dropOffPos[1] + math.cos(rad) * 6.66072
    dropOffPos[2] = dropOffPos[2] + math.sin(rad) * 6.66072

    dropoffColsphere[workshopIdentity] = false

    dropoffColsphere[workshopIdentity] = createColSphere(dropOffPos[1] + lobbyX, dropOffPos[2] + lobbyY, dropOffPos[3] + 1 + lobbyZ, 2)
    setElementDimension(dropoffColsphere[workshopIdentity], dim)
end

addEventHandler("onColShapeHit", getRootElement(), function(hitElement, matchingDimension)
    if not isElement(source) then
        return
    end
    local hitDim = getElementDimension(hitElement)
    local colDim = getElementDimension(source)
    local workshopIdentity = false

    for workshopId, colElement in pairs(dropoffColsphere) do
        if colElement == source then
            workshopIdentity = workshopId
        end
    end
    if workshopIdentity then
        if getElementModel(hitElement) == 608 then
            local datas = dropoffDatas[hitElement]
            local ws = datas.workshop
            if not workshopWorks[ws] then
                workshopWorks[ws] = {}
            end

            local index = datas.workId

            for k, v in pairs(workStateFlow) do
                local fileName = "data/workstatemasks/" .. ws .. "/" ..index.."_".. v ..".sight"

                if fileExists(fileName) then
                    fileDelete(fileName)
                end
            end
            workshopWorks[ws][index] = {
                color = datas.color,
                transportTrailer = false,
                model = datas.model,
                state = "sanding",
                dryingState = false,
                metal = datas.metal,
                partNames = datas.partNames,
                lastPercent = 0,
                sandingQuality = 0,
                primerQuality = 0,
                paintQuality = 0,
                price = datas.price,
                dataPath = datas.dataPath,
                plate = datas.plate
            }

            local workshopData = getWorkshopSavedData(ws)
            workshopData.paintshopWorks[index] = workshopWorks[ws][index]

            saveWorkshopData(ws, workshopData)

            triggerClientEvent(playersInWorkshop[workshopIdentity], "gotNewPaintshopWork", hitElement, ws, index, workshopWorks[ws][index])

            local mainVeh = getVehicleTowingVehicle(hitElement)

            local occupants = getVehicleOccupants(mainVeh)
            setElementData(hitElement, "paintshopCarModel", false)
            triggerClientEvent(occupants, "createPaintshopTargetMarker", hitElement, false, false)
            destroyElement(dropoffColsphere[workshopIdentity])
            dropoffColsphere[workshopIdentity] = nil
        end
    end
end)

dropoffDatas = {}

addEventHandler("onColShapeHit", root, function(hitElement, matchingDimension)
    if getElementType(hitElement) ~= "vehicle" then return end
    if getElementModel(hitElement) ~= 608 then return end

    local mapping = colToWork[source]
    if not mapping then return end

    local workshopId = mapping.workshopId
    local workId     = mapping.workId

    local workshopData = getWorkshopSavedData(workshopId)
    local works = workshopData.paintshopWorks

    local vehJob = works[workId]
    if not vehJob then
        return
    end

    vehJob.workshop = workshopId
    vehJob.workId = workId

    setElementData(hitElement, "paintshopCarModel", vehJob.model)



    local paintjobPath = "paintjobs/"..vehJob.model.."/"..vehJob.dataPath
    local paintjobData

    if fileExists(paintjobPath) then
        local paintjobFile = fileOpen(paintjobPath, true)
        paintjobData = fileRead(paintjobFile, fileGetSize(paintjobFile))
    end

    local mainVeh = getVehicleTowingVehicle(hitElement)

    local driver = getVehicleController(mainVeh)

    setElementData(hitElement, "paintshop.currentVehicle", {
        model = vehJob.model,
        paintjobData = paintjobData, 
        state = "transportIn",
        plate = vehJob.plate
    })

    triggerClientEvent("gotAttachedPaintshopVehicle", hitElement, paintjobData, true, vehJob.plate)
    triggerClientEvent(driver, "createPaintshopTargetMarker", driver, false, workshopId)

    dropoffDatas[hitElement] = vehJob

    destroyElement(source)
    colToWork[source] = nil
    vehicleColspheres[workshopId] = nil

    local dropOff = getAisleFromWorkshop(workshopId)

    initalizeDropoffColshape(dropOff, workshopId)
end)

addCommandHandler("forceoffer", function(sourcePlayer, sourceCommand, workshopIdentity)
    if workshopIdentity then
        processWorkshopEmails(workshopIdentity, sourcePlayer, true, false)
    end
end)

addCommandHandler("forcereply", function(sourcePlayer, sourceCommand, workshopIdentity)
    if workshopIdentity then
        processWorkshopEmails(workshopIdentity, sourcePlayer, false, true)
    end
end)

addCommandHandler("forceto", function(sourcePlayer, sourceCommand, workshopIdentity)
    if workshopIdentity then
        processWorkshopEmails(workshopIdentity, sourcePlayer, false, false, true)
    end
end)

local transportOutColspeheres = {}
local onGoingTransportOuts = {}

addEvent("startPaintshopDeliveryOut", true)
addEventHandler("startPaintshopDeliveryOut", root, function(workId)
    local workshopIdentity = getElementDimension(client)
    local workshopData = getWorkshopSavedData(workshopIdentity)
    local works = workshopData.paintshopWorks
    local foundWork = false

    for mailIndex, mailData in pairs(workshopData.mails) do
        if mailData.workId == workId then
            foundWork = mailIndex
        end
    end

    onGoingTransportOuts[workshopIdentity] = {
        vehicleModel = works[workId].model,
        vehicleColor = works[workId].color,
        workId = workId,
        plate = works[workId].plate
    }

    local workMail = workshopData.mails[foundWork]
    initalizeTransportOutColshape(true, workshopIdentity)
    triggerClientEvent(client, "createPaintshopTargetMarker", client, false, workshopIdentity)
end)

function initalizeTransportOutColshape(dropOff, workshopIdentity)
    if transportOutColspeheres[workshopIdentity] then
        return
    end

    local doorId, aisleId, insideId = getAisleFromWorkshop(workshopIdentity)
    local dropOffPos = {}
    local dim = 0

    if dropOff then
        dim = aisleId
        dropOffPos = {unpack(aisleDoors[insideId])}
    end

    local rad = math.rad(dropOffPos[4]) - math.pi / 2
    dropOffPos[1] = dropOffPos[1] + math.cos(rad) * 6.66072
    dropOffPos[2] = dropOffPos[2] + math.sin(rad) * 6.66072

    transportOutColspeheres[workshopIdentity] = false

    transportOutColspeheres[workshopIdentity] = createColSphere(dropOffPos[1] + lobbyX, dropOffPos[2] + lobbyY, dropOffPos[3] + 1 + lobbyZ, 2)
    setElementDimension(transportOutColspeheres[workshopIdentity], dim)
end

addEvent("getAttachedPaintshopVehicle", true)
addEventHandler("getAttachedPaintshopVehicle", root, function()
    local trailerData = getElementData(source, "paintshop.currentVehicle")
    if trailerData then
        if trailerData.state == "transportOut" then
            triggerClientEvent(client, "gotAttachedPaintshopVehicle", source, trailerData.color, false, trailerData.plate)
        elseif trailerData.state == "transportIn" then
            --triggerClientEvent(client, "gotAttachedPaintshopVehicle", source, trailerData.paintjobData, true, trailerData.plate)
            triggerLatentClientEvent(client, "gotAttachedPaintshopVehicle", 1500000, source, trailerData.paintjobData, true, trailerData.plate)
        end
    end
end)

colToDone = {}

doneColspheres = {}

function initializeDoneWorkColshape(vehicleOrigin, workshopIdentity, workId)
    if doneColspheres[workshopIdentity] and isElement(doneColspheres[workshopIdentity]) then
        destroyElement(doneColspheres[workshopIdentity])
    end

    local pos = dropoffPoses[vehicleOrigin]
    local col = createColSphere(pos[1], pos[2], pos[3], 2)
    setElementInterior(col, 0)
    setElementDimension(col, 0)

    colToDone[col] = {
        workshopId = workshopIdentity,
        workId     = workId
    }

    doneColspheres[workshopIdentity] = col
    addEventHandler("onColShapeHit", doneColspheres[workshopIdentity], onJobDone)
end

local partPrices = {
    -- Műhelyfejlesztési pontok!
    -- 115.600 egy "kimaxolt" WorkShop
    -- 18.400 / 15.900 / 16.600 / 13.000 / 26.300 / 21.700 (kategóriánként)
    -- Max amit adhat egy autó: 10.500(x1.2) -> 10x12.600 = 126.000
    -- Minimum amit adhat egy autó: 750(x0.7) -> 525

    ["Karosszéria"]      = 2500, 
    ["Hátsó lökhárító"]  = 1000,  
    ["Első lökhárító"]   = 1000, 
    ["Motorháztető"]     = 1500,
    ["Csomagtartó"]      = 1500,
    ["Bal első ajtó"]    = 750,
    ["Jobb első ajtó"]   = 750,
    ["Bal hátsó ajtó"]   = 750,
    ["Jobb hátsó ajtó"]  = 750,
    ["Jobb oldali ajtó"] = 750,
    ["Bal oldali ajtó"]  = 750,
    ["Kasztni"]          = 2500,
}

function calculateGivenPoints(parts)
    local total = 0
    for _, name in ipairs(parts) do
        local price = partPrices[name]
        if price then
            total = total + price * math.random(0.7, 1.2)
        end
    end
    return math.floor(total)
end

function onJobDone(hitElement, matchingDimension)
    if getElementType(hitElement) ~= "vehicle" then return end
    if getElementModel(hitElement) ~= 608 then return end

    local workshopIdentity = false
    for colIndex, colElement in pairs(doneColspheres) do
        if colElement == source then
            workshopIdentity = colIndex
        end
    end

    if workshopIdentity then
        local vehicleDetail = onGoingTransportOuts[workshopIdentity]
        
        local id = vehicleDetail.workId
        local workshopData = getWorkshopSavedData(workshopIdentity)
        local works = workshopData.paintshopWorks
        local mails = workshopData.mails

        local foundWork = false
        for mailIndex, mailData in pairs(workshopData.mails) do
            if mailData.workId == id then
                foundWork = mailIndex
            end
        end

        local datas = works[id]
        if not datas then
            return
        end
        if mails[foundWork] then
            local workRating = false
            overallRating = datas.paintQuality + datas.primerQuality + datas.sandingQuality
            overallRating = overallRating / 3
            if overallRating > 5 then
                overallRating = 5
            end
        end
        
        createWorkshopRating(overallRating, workshopIdentity, mails[foundWork].from)

        local mainVeh = getVehicleTowingVehicle(hitElement)

        local vehicleController = getVehicleController(mainVeh)

        local finalMoney = tonumber(datas.price)

        if isElement(vehicleController) then
            exports.sCore:giveMoney(vehicleController, finalMoney)
            local workshopData = getWorkshopSavedData(workshopIdentity)

            local workshopPoints = workshopData.workshopPoint or 0
            local giveAmount = calculateGivenPoints(workshopData.paintshopWorks[id].partNames)

            workshopPoints = workshopPoints + giveAmount

            local occupants = getVehicleOccupants(mainVeh)
            setElementData(hitElement, "paintshopCarModel", false)
            triggerClientEvent(vehicleController, "createPaintshopTargetMarker", hitElement, false, false)

            exports.sGui:showInfobox(vehicleController, "s", "Sikeresen leszállítottad a járművet! (".. math.floor(finalMoney) .. "$)")
            exports.sGui:showInfobox(vehicleController, "s", "Ezzel a leszállítással a műhelyed kapott "..giveAmount.. " pontot, így összesen " ..workshopPoints.. " pontotok van!")

            workshopWorks[workshopIdentity][id] = nil

            workshopData.paintshopWorks[id] = nil

            saveWorkshopData(workshopIdentity, workshopData)

            triggerClientEvent(playersInWorkshop[workshopIdentity], "refreshPaintshopWorks", vehicleController, workshopIdentity, id, nil)
        end
    end
end

addEventHandler("onColShapeHit", root, function(hitElement, matchingDimension)
    if getElementType(hitElement) ~= "vehicle" then return end
    if getElementModel(hitElement) ~= 608 then return end

    local workshopIdentity = false
    for colIndex, colElement in pairs(transportOutColspeheres) do
        if colElement == source then
            workshopIdentity = colIndex
        end
    end

    if workshopIdentity then
        local vehicleDetail = onGoingTransportOuts[workshopIdentity]

        setElementData(hitElement, "paintshop.currentVehicle", {
            model = vehicleDetail.vehicleModel,
            color = vehicleDetail.vehicleColor:gsub("#", ""),
            state = "transportOut",
            plate = vehicleDetail.plate
        })

        setElementData(hitElement, "paintshopCarModel", vehicleDetail.vehicleModel)
        triggerClientEvent("gotAttachedPaintshopVehicle", hitElement, vehicleDetail.vehicleColor:gsub("#", ""), false, vehicleDetail.plate)--TODO PLATETEXT

        local mainVeh = getVehicleTowingVehicle(hitElement)
        local driver = getVehicleController(mainVeh)
        
        local vehicleOrigin = math.random(1, #dropoffPoses)
        triggerClientEvent(driver, "createPaintshopTargetMarker", root, vehicleOrigin, false)

        triggerClientEvent(playersInWorkshop[workshopIdentity], "refreshPaintshopWorks", driver, workshopIdentity, vehicleDetail.workId, nil)

        initializeDoneWorkColshape(vehicleOrigin, workshopIdentity, vehicleDetail.workId)
    end
end)

function findEmailByWorkID(workIdentity, t2)
    local emailId = false
    local workId = false
    for key, value in pairs(t2) do
        if workIdentity == value.workId then
            emailId = key
        end
    end
    return emailId, workId
end

addEvent("tryToEndPaintshopJob", true)
addEventHandler("tryToEndPaintshopJob", root, function(workIdentity)
    local workshopIdentity = getElementDimension(client)
    if workshopIdentity then
        if isWorkshopIdValid(workshopIdentity) then
            local workshopData = getWorkshopSavedData(workshopIdentity)
            local workshopWorks = workshopData.paintshopWorks
            if workshopWorks[workIdentity] then
                local currentWork = workshopWorks[workIdentity]
                local workshopMails = workshopData.mails
                local emailId = findEmailByWorkID(workIdentity, workshopMails)
                if emailId and workshopMails[emailId] then
                    local currentMail = workshopMails[emailId]
                    currentMail.emailType = "offer"
                    currentMail.offerReply = false
                    currentMail.declined = true

                    saveWorkshopData(workshopIdentity, {mails = workshopMails})

                    local workshopData = getWorkshopSavedData(workshopIdentity)

                    local paintshopWorks = workshopData.paintshopWorks

                    for k, v in pairs(paintshopWorks) do
                        if k == workIdentity then
                            local id = k

                            workshopData.paintshopWorks[id] = nil

                            saveWorkshopData(workshopIdentity, workshopData)

                            triggerClientEvent(playersInWorkshop[workshopIdentity], "refreshPaintshopWorks", client, workshopIdentity, id, nil)
                            break
                        end
                    end

                    if workshopMails[emailId] then
                        triggerClientEvent(playersInWorkshop[workshopIdentity], "refreshPaintshopEmail", client, workshopIdentity, emailId, false, false)
                        triggerClientEvent(playersInWorkshop[workshopIdentity], "refreshPaintshopEmail", client, workshopIdentity, emailId, currentMail, false)
                    end
                end
                createWorkshopRating(0, workshopIdentity, currentWork.from or {1, 1}, true)
            end
        end
    end
end)