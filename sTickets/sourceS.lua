local dbConnection = exports.sConnection:getConnection()
local loadedTickets = {}

function loadAllTickets(qh)
	local result = dbPoll(qh, 0)

	if result then
		for k, v in pairs(result) do
			loadedTickets[v.dbID] = {
                id = v.dbID,
                money = tostring(v.money),
                reason = v.reason,
                offenderId = v.offenderId,
                offenderName = v.offenderName,
                ticketDate = v.ticketDate,
                ticketBy = v.ticketBy,
                ticketPlace = v.ticketPlace,
                ticketGroup = v.ticketGroup
            }
		end
	end
end

addEvent("tryToPayTicket", true)
addEventHandler("tryToPayTicket", root, 
    function(ticketId)
        if loadedTickets[ticketId] then
            local clientMoney = exports.sCore:getMoney(client)
            local ticketData = loadedTickets[ticketId]
            local playerItems = exports.sItems:getElementItems(client)

            if clientMoney >= tonumber(ticketData.money) then
                for k, v in pairs(playerItems) do
                    if v.itemId == 313 and tonumber(v.data1) == ticketId then
                        exports.sCore:setMoney(client, clientMoney - tonumber(ticketData.money))
                        exports.sItems:takeItem(client, "dbID", v.dbID)
                        exports.sGui:showInfobox(client, "s", "Sikeresen befizettél egy csekket! ["..ticketData.money.. " - ID: "..tostring(ticketId).."]")
                        exports.sGroups:addGroupBalance(ticketData.ticketGroup, client, tonumber(ticketData.money))
                    end
                end
            end
        else
            exports.sAnticheat:anticheatBan(client, "AC #7 - sTickets @sourceS:42")
        end
    end
)

addEventHandler("onResourceStart", resourceRoot,
    function ()
        dbQuery(loadAllTickets, dbConnection, "SELECT * FROM tickets")
    end
)

addEvent("requestTicket", true)
addEventHandler("requestTicket", root, 
    function(ticketId)
        if loadedTickets[ticketId] then
            triggerClientEvent(client, "gotTicket", client, loadedTickets[ticketId])
        end
    end
)

function createTicket(qh, ticketTable, offenderElement)
    local ticketMoney = ticketTable["money"]
    local ticketDate = ticketTable["ticketDate"]

    local result, affectedRows, lastInsertId = dbPoll(qh, -1)

    loadedTickets[lastInsertId] = {
        id = lastInsertId,
        money = ticketTable["money"],
        reason = ticketTable["reason"],
        offenderId = ticketTable["offenderId"],
        offenderName = ticketTable["offenderName"],
        ticketDate = ticketTable["ticketDate"],
        ticketBy = ticketTable["ticketBy"],
        ticketPlace = ticketTable["ticketPlace"],
        ticketGroup = ticketTable["ticketGroup"]
    }

    
    exports.sItems:giveItem(offenderElement, 313, 1, false, lastInsertId, ticketMoney, ticketDate + (86400 * 3))

    triggerClientEvent(offenderElement, "gotTicket", offenderElement, loadedTickets[lastInsertId])
end

addEvent("createTicket", true)
addEventHandler("createTicket", root, 
    function(ticketGroup, editingOffender, ticketMoney, ticketReason)
        if exports.sGroups:isPlayerInGroup(client, ticketGroup) and ticketGroups[ticketGroup] and ticketMoney > 0 then
            if ticketMoney <= maxMoney then
                local cX, cY, cZ = getElementPosition(client)

                local ticketDatas = {
                    money = ticketMoney,
                    reason = ticketReason,
                    ticketGroup = ticketGroup,
                    offenderId = getElementData(editingOffender, "char.ID"),
                    offenderName = getElementData(editingOffender, "char.name"),
                    ticketDate = getRealTime().timestamp,
                    ticketBy = getElementData(client, "char.name"),
                    ticketPlace = getZoneName(cX, cY, cZ) or "N/A"
                }

                local columnNames = {}
                local valueMarks = {}
                local parameters = {}

                for k, v in pairs(ticketDatas) do
                    table.insert(columnNames, k)
                    table.insert(valueMarks, "?")
                    table.insert(parameters, v)
                end

                triggerClientEvent("gotGroupMessage", client, ticketGroup, "blue", "Ticket", "[color=sightgreen]" .. getElementData(client, "char.name"):gsub("_", " ") .. " [color=hudwhite]számlát álított ki: [color=sightblue]" .. getElementData(editingOffender, "char.name"):gsub("_", " ") .. "[color=hudwhite], [color=sightgreen]" .. exports.sGui:thousandsStepper(ticketMoney).. "$ [color=hudwhite] Indok: " ..ticketReason)

                exports.sGui:showInfobox(client, "s", "Sikeresen kiállítottál egy csekket!")

                local insertQuery = dbQuery(createTicket, {ticketDatas, editingOffender}, dbConnection, "INSERT INTO tickets (" .. table.concat(columnNames, ",") .. ") VALUES (" .. table.concat(valueMarks, ",") .. ")", unpack(parameters))

                local columnNames = {}
                local valueMarks = {}
                local parameters = {}
    
                local warrantRecordDatas = {
                    recordType = "ticket",
                    punishedName = getElementData(editingOffender, "char.name"),
                    recordBy = getElementData(client, "char.name"),
                    description = ticketReason,
                    recordTime = getRealTime().timestamp,
                    recordPunishment = ""
                }
    
                for k, v in pairs(warrantRecordDatas) do
                    table.insert(columnNames, k)
                    table.insert(valueMarks, "?")
                    table.insert(parameters, v)
                end
    
                dbExec(dbConnection, "INSERT INTO mdc_records (" .. table.concat(columnNames, ",") .. ") VALUES (" .. table.concat(valueMarks, ",") .. ")", unpack(parameters))
            end
        else
            exports.sAnticheat:anticheatBan(client, "AC #6 - sTickets @sourceS:119")
        end
    end
)