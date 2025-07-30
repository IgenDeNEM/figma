local closedReports = {}
local reports = {}
local reportMessages = {}
local reportWritingStates = {}

local function countReports()
    local fileCount = 0
    local fileName = tostring(fileCount + 1) .. ".json"


    while fileExists("closedreports/"..fileName) do
        fileCount = fileCount + 1
        fileName = tostring(fileCount + 1) .. ".json"
    end

    return fileCount
end
local nextReportID = countReports()


local function sendAdminOpenReports(admin)
    if not exports.sPermission:hasPermission(admin, "helperChat") then
        return
    end
    local openReports = {}
    local myReports = {}
    for _, report in pairs(reports) do
        if not report.assignedTo then
            table.insert(openReports, report)
        elseif report.assignedTo == admin then
            table.insert(myReports, report)
        end
    end
    setTimer(function()
        triggerClientEvent(admin, "gotAdminOpenReports", root, openReports, myReports, nil, nil, nil)
    end, 50, 1)
end

local function notifyAdmins(report, newReport, deletedReportID)
    for _, admin in ipairs(getElementsByType("player")) do
        if exports.sPermission:hasPermission(admin, "helperChat") then
            if newReport then
                triggerClientEvent(admin, "gotAdminOpenReports", root, nil, nil, nil, report, nil)
            elseif deletedReportID then
                triggerClientEvent(admin, "gotAdminOpenReports", root, nil, nil, nil, nil, deletedReportID)
            else
                sendAdminOpenReports(admin)
            end
        end
    end
end

addEvent("createReport", true)
addEventHandler("createReport", getRootElement(), function(reportTitle, selectedReportCategory, reportDescription)
    local player = client
    local reportID = countReports() + 1
    nextReportID = countReports() + 1

    local adminPlayers = {}

    for k, v in ipairs(getElementsByType("player")) do
        if (getElementData(v, "acc.adminLevel") or 0) > 0 or (getElementData(v, "acc.helperLevel") or 0) > 0 then
            table.insert(adminPlayers, v)
        end
    end

    outputChatBox("[color=sightgreen][SightMTA - Report] [color=hudwhite]Egy új report érkezett! [color=sightgreen][Report ID: ".. nextReportID .."]", adminPlayers)

    local reportDescription = reportDescription or ""
    local report = {
        id = reportID,
        player = player,
        category = selectedReportCategory,
        title = reportTitle,
        description = reportDescription,
        created = getRealTime().timestamp,
        lastEdit = getRealTime().timestamp,
        adminId = 0,
        adminName = "",
        sentBy = getElementData(player, "char.ID") or 0,
        sentName = getPlayerName(player):gsub("#%x%x%x%x%x%x", "")
    }
    reports[reportID] = report

    reportMessages[reportID] = {}
    triggerClientEvent(player, "gotPlayerReport", player, report, reportMessages[reportID])

    firstReportMessage = {
        id = 4,
        reportId = reportID,
        date = getRealTime().timestamp,
        sender = getElementData(player, "char.ID"),
        message = reportDescription,
        seen = 0
    }

    table.insert(reportMessages[reportID], firstReportMessage)
    notifyAdmins(report, true, nil)

    triggerClientEvent(client, "forceCloseDashboard", client)
end)

addEvent("getReports", true)
addEventHandler("getReports", root, function(player)
    if exports.sPermission:hasPermission(player, "helperChat") then
        sendAdminOpenReports(player)
    end
end)


addEvent("acceptAdminReport", true)
addEventHandler("acceptAdminReport", root, function(reportID)
    local admin = client
    local report = reports[reportID]
    if report then
        if report.assignedTo then
            outputChatBox("[color=sightred][SightMTA - Reports]: [color=hudwhite]Ezt a reportot már valaki elfogadta!", admin)
        else
            report.assignedTo = admin
            report.adminId = getElementData(admin, "char.ID") or 0
            report.adminName = getPlayerName(admin):gsub("#%x%x%x%x%x%x", "")

            local joinMessage = {
                sender = 0, 
                seen = 0, 
                id = -5, 
                date = getRealTime().timestamp, 
                message = getElementData(admin, "visibleName"):gsub("_"," ") .. " csatlakozott", 
                reportId = reportID
            }

            if isElement(report.player) then
                triggerClientEvent(report.player, "adminChangeOnReport", report.player, reportID, report.adminId, report.adminName)
            end

            table.insert(reportMessages[reportID], joinMessage)
            triggerClientEvent(admin, "gotAdminOpenReports", root, nil, {report}, nil, nil, nil)
            triggerClientEvent(admin, "gotMessagesForAdminReport", admin, reportID, report)

            triggerClientEvent(report.player, "newMessageForPlayer", report.player, joinMessage, reportID)
            triggerClientEvent(admin, "newMessageForAdmin", admin, joinMessage, reportID)

            notifyAdmins(report, nil, nil)
        end
    else
        outputChatBox("[color=sightred][SightMTA - Reports]: [color=hudwhite]Nem található report!", admin)
    end
end)

addEvent("getAdminReportMessages", true)
addEventHandler("getAdminReportMessages", root, function(reportID)
    local admin = client
    if not hasObjectPermissionTo(admin, "function.kickPlayer", false) then
        outputChatBox("[color=sightred][SightMTA - Reports]: [color=hudwhite]Nincs jogosultságod a reportok megtekintéséhez!", admin)
        return
    end
    local report = reports[reportID]
    if report then
        local messages = reportMessages[reportID] or {}
        triggerClientEvent(admin, "receiveAdminReportMessages", admin, reportID, report, messages)
    else
        outputChatBox("[color=sightred][SightMTA - Reports]: [color=hudwhite]Nem található report!", admin)
    end
end)

addEvent("closeAdminReport", true)
addEventHandler("closeAdminReport", root, function(reportID)
    local admin = client
    if not exports.sPermission:hasPermission(admin, "helperChat") then
        outputChatBox("[color=sightred][SightMTA - Reports]: [color=hudwhite]Nincs jogosultságod a reportok lezárásához!", admin)
        return
    end
    local report = reports[reportID]
    if report and report.assignedTo == admin then
        closedReports[reportID] = {}
        closedReports[reportID].reportMessages = reportMessages[reportID]
        closedReports[reportID].reportHandler = getElementData(report.assignedTo, "acc.adminNick"):gsub("_", " ")

        reports[reportID] = nil
        reportMessages[reportID] = nil
        reportWritingStates[reportID] = nil
        notifyAdmins(nil, nil, reportID)
        if isElement(report.player) then
            triggerClientEvent(report.player, "closeReport", report.player, reportID)
        end
    else
        outputChatBox("[color=sightred][SightMTA - Reports]: [color=hudwhite]Nem létezik a report!", client)
    end
end)

addEvent("cancelAdminReport", true)
addEventHandler("cancelAdminReport", root, function(reportID)
    local admin = client
    if not exports.sPermission:hasPermission(admin, "helperChat") then
        outputChatBox("[color=sightred][SightMTA - Reports]: [color=hudwhite]Nincs jogosultságod elutasítani a reportokat!", client)
        return
    end
    local report = reports[reportID]
    if report and report.assignedTo == admin then
        report.assignedTo = nil
        report.adminId = 0
        report.adminName = ""
        notifyAdmins(report, nil, nil)
        if isElement(report.player) then
            triggerClientEvent(report.player, "adminChangeOnReport", report.player, reportID, 0, "")
        end
    else
        outputChatBox("[color=sightred][SightMTA - Reports]: [color=hudwhite]Nem te vagy hozzárendelve ehhez a reporthoz!", client)
    end
end)

addEvent("sendReportMessage", true)
addEventHandler("sendReportMessage", root, function(reportID, message, tempID)
    local report = reports[reportID]
    if report and report.player and report.assignedTo then
        if reportMessages[reportID] then
            nextID = reportMessages[reportID][#reportMessages[reportID]].id + 6
        else
            nextID = reportMessages[reportID][#reportMessages[reportID]].id + 6
        end

        local msg = {
            id = nextID,
            reportId = reportID,
            date = getRealTime().timestamp,
            sender = getElementData(client, "char.ID") or 0,
            message = message,
            seen = 0
        }

        reportMessages[reportID] = reportMessages[reportID] or {}
        table.insert(reportMessages[reportID], msg)

        if msg.sender ~= getElementData(report.assignedTo, "char.ID") or msg.sender ~= getElementData(client, "char.ID") then
            outputChatBox("[color=sightgreen][SightMTA - Reports]: [color=hudwhite]Egy új üzeneted érkezett [color=sightgreen][Report ID:".. reportID .."]", report.assignedTo)
        end

        triggerClientEvent(report.player, "newMessageForPlayer", report.player, msg, tempID)
        triggerClientEvent(report.assignedTo, "newMessageForAdmin", report.assignedTo, msg, tempID)
    else
        outputChatBox("[color=sightred][SightMTA - Reports]: [color=hudwhite]Nem te vagy hozzárendelve ehhez a reporthoz!", client)
    end
end)

addEvent("changeWritingStatePlayer", true)
addEventHandler("changeWritingStatePlayer", root, function(reportID, state)
    local player = client
    local report = reports[reportID]
    if report and report.player == player then
        reportWritingStates[reportID] = state and (getPlayerName(player):gsub("#%x%x%x%x%x%x", "")):gsub("_", " ") or nil
        if report.assignedTo then
            triggerClientEvent(report.assignedTo, "adminWritingState", report.assignedTo, reportID, reportWritingStates[reportID])
        end
    end
end)

addEvent("changeWritingStateAdmin", true)
addEventHandler("changeWritingStateAdmin", root, function(reportID, state)
    local admin = client
    local report = reports[reportID]
    if report and report.assignedTo == admin then
        reportWritingStates[reportID] = state and getElementData(admin, "acc.adminNick"):gsub("_", " ") or nil
        if isElement(report.player) then
            triggerClientEvent(report.player, "playerWritingState", report.player, reportID, reportWritingStates[reportID])
        end
    end
end)

addEvent("processUnreadMessages", true)
addEventHandler("processUnreadMessages", root, function(data)
    local client = source
    if not data then return end
    local updates = {}
    for _, v in ipairs(data) do
        local reportID = v[1]
        local messageID = v[2]
        local report = reports[reportID]
        if report then
            local messages = reportMessages[reportID]
            if messages then
                for _, msg in ipairs(messages) do
                    local isPlayer = client == report.player
                    local isAdmin = report.assignedTo and client == report.assignedTo

                    if msg.id == messageID and msg.seen == 0 then
                        if isPlayer and msg.sender ~= report.sentBy then
                            msg.seen = getRealTime().timestamp
                            table.insert(updates, {reportID, messageID, msg.seen})
                            break
                        elseif isAdmin and msg.sender == report.sentBy then
                            msg.seen = getRealTime().timestamp
                            table.insert(updates, {reportID, messageID, msg.seen})
                            break
                        end
                    end
                end
            end
        end
    end
    if #updates > 0 then
        if client == reports[updates[1][1]].player then
            triggerClientEvent(client, "reportAdminMessageSeen", client, updates)
        elseif reports[updates[1][1]].assignedTo and client == reports[updates[1][1]].assignedTo then
            triggerClientEvent(client, "reportPlayerMessageSeen", client, updates)
        end
    end
end)

addEvent("useAdminActionButton", true)
addEventHandler("useAdminActionButton", root, function(reportID, actionIdentity)
    local admin = client
    if not exports.sPermission:hasPermission(admin, "pm") then
        outputChatBox("[color=sightred][SightMTA - Reports]: [color=hudwhite]Nem te vagy hozzárendelve ehhez a reporthoz!", client)
        return
    end
    local report = reports[reportID]
    if report then
        local player = report.player
        if isElement(player) then
            local actions = {
                [1] = function()
                    executeCommandHandler("goto", client, tostring(getElementData(report.player, "visibleName")):gsub("_", " "))
                end,
                [2] = function()
                    executeCommandHandler("spec", client, tostring(getElementData(report.player, "visibleName")):gsub("_", " "))
                end,
                [3] = function()
                    executeCommandHandler("stats", client, tostring(getElementData(report.player, "visibleName")):gsub("_", " "))
                end,
                [4] = function()
                    executeCommandHandler("eco", client, tostring(getElementData(report.player, "visibleName")):gsub("_", " "))
                end,
                [5] = function()
                    executeCommandHandler("asegit", client, tostring(getElementData(report.player, "visibleName")):gsub("_", " "))
                end,
                [6] = function()
                    executeCommandHandler("agyogyit", client, tostring(getElementData(report.player, "visibleName")):gsub("_", " "))
                end,
                [7] = function()
                    executeCommandHandler("vhspawn", client, tostring(getElementData(report.player, "visibleName")):gsub("_", " "))
                end,
                [8] = function()
                    executeCommandHandler("gethere", client, tostring(getElementData(report.player, "visibleName")):gsub("_", " "))
                end,
            }
            if actions[actionIdentity] then
                actions[actionIdentity]()
            end
        else
            outputChatBox("[color=sightred][SightMTA - Reports]: [color=hudwhite]A játékos nem online!", client)
        end
    else
        outputChatBox("[color=sightred][SightMTA - Reports]: [color=hudwhite]Nem található report!", client)
    end
end)

addEvent("sendReportRating", true)
addEventHandler("sendReportRating", root, function(reportID, rating, message)
    local player = client
    outputChatBox("[color=sightgreen][SightMTA - Reports]: [color=hudwhite]Köszönjük az értékelésed!", client)
    closedReports[reportID].rating = rating
    closedReports[reportID].ratingMessage = message or ""

    local closedReportFile = fileCreate("closedReports/" .. reportID .. ".json")
    if closedReportFile then
        fileWrite(closedReportFile, toJSON(closedReports[reportID]))
        fileClose(closedReportFile)
    end

    --outputServerLog("Player " .. getPlayerName(player) .. " rated report " .. reportID .. " with " .. rating .. " stars. Message: " .. (message))
end)

addEventHandler("onPlayerLogin", root, function()
    local player = source
    for reportID, report in pairs(reports) do
        if report.player == player then
            local messages = reportMessages[reportID] or {}
            triggerClientEvent(player, "gotPlayerReport", player, report, messages)
            break
        end
    end
end)

addEventHandler("onResourceStart", resourceRoot, function()
    for _, admin in ipairs(getElementsByType("player")) do
        if exports.sPermission:hasPermission(admin, "helperChat") then
            sendAdminOpenReports(admin)
        end
    end
    for _, player in ipairs(getElementsByType("player")) do
        for reportID, report in pairs(reports) do
            if report.player == player then
                local messages = reportMessages[reportID] or {}
                triggerClientEvent(player, "gotPlayerReport", player, report, messages)
                break
            end
        end
    end
end)

addEventHandler("onPlayerQuit", root, function()
    local player = source
    for reportID, report in pairs(reports) do
        if report.player == player then
            reports[reportID] = nil
            reportMessages[reportID] = nil
            reportWritingStates[reportID] = nil
            if report.assignedTo then
                triggerClientEvent(report.assignedTo, "adminChangeOnReport", root, reportID, 0, "")
            end
            break
        end
    end
    for reportID, report in pairs(reports) do
        if report.assignedTo == player then
            report.assignedTo = nil
            report.adminId = 0
            report.adminName = ""
            if isElement(report.player) then
                triggerClientEvent(report.player, "adminChangeOnReport", report.player, reportID, 0, "")
            end
            notifyAdmins(report, nil, nil)
        end
    end
end)