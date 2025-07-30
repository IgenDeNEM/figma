local connection = exports.sConnection:getConnection()

local companies = {}
local invoices = {}

addEventHandler("onResourceStart", resourceRoot,
    function ()
        dbQuery(loadCompanies, connection, "SELECT * FROM companies")
        dbQuery(loadInvoices, connection, "SELECT * FROM invoices")
    end
)

addEvent("requestCompanyList", true)
addEventHandler("requestCompanyList", root,
    function ()
        loadCompaniesEx(client)
    end
)

function loadCompanies(qh)
    local result = dbPoll(qh, 0)

    if result then
        for k, v in pairs(result) do
            companies[v.companyId] = {
                v.companyId,
                v.companyName,
                v.taxNumber,
                v.taxAmount,
                utfLen(v.postfix) > 0 and v.postfix or false,
                v.activity,
                v.ownerCharacterId,
                v.createdBy,
                fromJSON(v.books),
                v.prefix,
                v.created
            }
        end
    end
end

function loadInvoices(qh)
    local result = dbPoll(qh, 0)

    if result then
        for k, v in pairs(result) do
            if not invoices[v.bookId] then
                invoices[v.bookId] = {}
            end

            invoices[v.bookId][v.invoiceId] = {
                created = v.created,
                netPrice = v.netPrice,
                postfix = v.postfix,
                companyName = v.companyName,
                vatNumber = v.vatNumber,
                buyer = v.buyer,
                product = v.product,
                sellerSign = v.sellerSign,
                buyerSign = v.buyerSign
            }
        end
    end
end

addEvent("createNewCompany", true)
addEventHandler("createNewCompany", root,
    function (name, owner, activity, postfix)
        local taxNumber = math.random(10000000, 99999999) .. "-" .. math.random(1, 9) .. "-" .. math.random(10, 99)

        local words = split(name, " ")
        local prefix = ""

        for i, word in ipairs(words) do
            prefix = prefix .. string.sub(word, 1, 1)
        end

        dbQuery(createCompany, {client, {
            companyName = name,
            taxNumber = taxNumber,
            taxAmount = 0,
            ownerCharacterId = owner,
            activity = activity,
            postfix = postfix or false,
            createdBy = string.gsub(getElementData(client, "visibleName"), "_", " "),
            books = {},
            prefix = string.upper(prefix),
            created = getRealTime().timestamp
        }}, connection, "INSERT INTO companies (companyName, taxNumber, taxAmount, ownerCharacterId, activity, postfix, createdBy, books, prefix, created) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", name, taxNumber, 0, owner, activity, postfix or "", string.gsub(getElementData(client, "visibleName"), "_", " "), toJSON({}), prefix, getRealTime().timestamp)
    end
)

function createCompany(qh, client, data)
    local result, _, companyId = dbPoll(qh, 0)

    if result then
        companies[companyId] = {
            companyId,
            data.companyName,
            data.taxNumber,
            data.taxAmount,
            data.postfix,
            data.activity,
            data.ownerCharacterId,
            data.createdBy,
            data.books,
            data.prefix,
            data.created
        }

        triggerClientEvent(client, "showInfobox", client, "i", "Sikeresen létrehoztad a céget: " .. data.companyName)
        triggerClientEvent(client, "showInfobox", client, "i", "Adószám: " .. data.taxNumber)
        triggerClientEvent(client, "showInfobox", client, "i", "Nyilvántartási szám: " .. companyId)
        
        loadCompaniesEx(client)
    end
end

addEvent("requestSingleCompany", true)
addEventHandler("requestSingleCompany", root,
    function (id)
        local company = companies[id]

        if company then
            local companyOwner = company[7]

            dbQuery(requestSingleCompany, {client, company}, connection, "SELECT name FROM characters WHERE characterId = ?", companyOwner)
        end
    end
)

function requestSingleCompany(qh, client, company)
    local result = dbPoll(qh, 0)

    if result then
        local characterName = result[1].name

        triggerClientEvent(client, "loadedSingleCompany", client, {
            companyId = company[1],
            companyName = company[2],
            companyOwner = company[7],
            activity = company[6],
            postfix = company[5],
            vatNumber = company[3],
            taxAccount = company[4],
            createdBy = company[8],
            activeBooks = company[9],
            prefix = company[10],
            created = company[11]
        }, string.gsub(characterName, "_", " "))
    end
end

addEvent("editExistingCompany", true)
addEventHandler("editExistingCompany", root,
    function (id, name, owner, activity, postfix)
        local company = companies[id]

        postfix = postfix or ""

        if company then
            dbQuery(editCompany, {client, id, name, owner, activity, postfix}, connection, "UPDATE companies SET companyName = ?, ownerCharacterId = ?, activity = ?, postfix = ? WHERE companyId = ?", name, owner, activity, postfix, id)
        end
    end
)

function editCompany(qh, client, id, name, owner, activity, postfix)
    local result = dbPoll(qh, 0)

    if result then
        local company = companies[id]

        if company then
            company[2] = name
            company[7] = owner
            company[6] = activity
            company[5] = utfLen(postfix) > 0 and postfix or false

            loadCompaniesEx(client)
        end
    end

end

addEvent("requestCompanyCard", true)
addEventHandler("requestCompanyCard", root,
    function (companyId)
        local company = companies[companyId]

        if company then
            local vatNumber = company[3]
            local companyName = company[2]

            local name = getElementData(client, "char.name"):gsub("_", " ")

            exports.sItems:giveItem(client, 596, 1, false, companyId, vatNumber .. companyName, name .. " (" .. company[7] .. ")")

            triggerClientEvent(client, "showInfobox", client, "s", "Kiadásra került a vállalkozói igazolvány!")
        end
    end
)

addEvent("requestNewInvoiceBook", true)
addEventHandler("requestNewInvoiceBook", root,
    function (companyId)
        local company = companies[companyId]
    
        if company then
            local invoiceBookId = company[10] .. "-" .. company[1] .. "/" .. #company[9] + 1

            if not company[9] then
                company[9] = {}
            end

            table.insert(company[9], {
                invoiceBookId,
                getRealTime().timestamp,
                true
            })

            dbExec(connection, "UPDATE companies SET books = ? WHERE companyId = ?", toJSON(company[9]), companyId)

            dbQuery(requestSingleCompany, {client, company}, connection, "SELECT name FROM characters WHERE characterId = ?", company[7])

            exports.sItems:giveItem(client, 598, 1, false, invoiceBookId, company[2], 0)

            triggerClientEvent(client, "showInfobox", client, "s", "Kiadásra került egy új számlatömb!")
            triggerClientEvent(client, "showInfobox", client, "i", "Számlatömb sorszáma: " .. invoiceBookId)
        end
    end
)

addEvent("deleteCompanyBook", true)
addEventHandler("deleteCompanyBook", root,
    function (companyId, book)
        local company = companies[companyId]

        if company then
            local books = company[9]
            local bookIndex = false


            for k, v in pairs(books) do
                if v[1] == book then
                    bookIndex = k
                    break
                end
            end

            table.remove(books, bookIndex)

            dbExec(connection, "DELETE FROM invoices WHERE bookId = ?", "S-1/"..bookIndex)
            dbExec(connection, "UPDATE companies SET books = ? WHERE companyId = ?", toJSON(books), companyId)

            dbQuery(requestSingleCompany, {client, company}, connection, "SELECT name FROM characters WHERE characterId = ?", company[7])

            triggerClientEvent(client, "showInfobox", client, "s", "A számlatömb törlése került a könyvelésből!")
        end
    end
)

addEvent("requestInvoiceBook", true)
addEventHandler("requestInvoiceBook", root,
    function (invoiceBookId)
        local companyId = tonumber(string.match(invoiceBookId, "%-(%d+)/"))
        local company = companies[companyId]

        if company then
            local companyData = table.copy(company)
            companyData.lastInvoice = invoices[invoiceBookId] and #invoices[invoiceBookId] or 0

            triggerClientEvent(client, "gotInvoiceBookData", client, invoiceBookId, companyData, company[2], company[5], company[3])
        end
    end
)

addEvent("companyTaxAccountTransaction", true)
addEventHandler("companyTaxAccountTransaction", root,
    function (id, type, amount)
        local company = companies[id]

        if company then
            if type == 1 then
                local playerMoney = exports.sCore:getMoney(client)

                if playerMoney >= amount then

                    exports.sCore:takeMoney(client, amount)

                    company[4] = company[4] + amount

                    dbExec(connection, "UPDATE companies SET taxAmount = ? WHERE companyId = ?", company[4], id)

                    triggerClientEvent(client, "showInfobox", client, "s", "Sikeresen befizetted az összeget a vállalkozás adószámlájára!")
                else
                    triggerClientEvent(client, "showInfobox", client, "e", "Nincs elég pénzed a tranzakcióhoz!")
                end
            elseif type == 2 then
                company[4] = company[4] + amount

                dbExec(connection, "UPDATE companies SET taxAmount = ? WHERE companyId = ?", company[4], id)

                triggerClientEvent(client, "showInfobox", client, "s", "Sikeresen jóváírtad az összeget a vállalkozás adószámláján!")
            elseif type == 3 then
                company[4] = company[4] - amount

                dbExec(connection, "UPDATE companies SET taxAmount = ? WHERE companyId = ?", company[4], id)

                triggerClientEvent(client, "showInfobox", client, "s", "Sikeresen levontad az összeget a vállalkozás adószámlájáról!")
            end

            dbQuery(requestSingleCompany, {client, company}, connection, "SELECT name FROM characters WHERE characterId = ?", company[7])
        end
    end
)

addEvent("createInvoice", true)
addEventHandler("createInvoice", root,
    function (targetElement, currentInvoiceBook, buyer, product, netPrice)
        local companyId = tonumber(string.match(currentInvoiceBook, "%-(%d+)/"))
        
        if not invoices[currentInvoiceBook] then
            invoices[currentInvoiceBook] = {}
        end
        
        local invoicesData = invoices[currentInvoiceBook]

        local sellerName = string.gsub(getElementData(client, "visibleName"), "_", " ")
        local buyerName = string.gsub(getElementData(targetElement, "visibleName"), "_", " ")

        table.insert(invoicesData, {
            created = getRealTime().timestamp / 60 / 60 / 24,
            netPrice = netPrice,
            postfix = companies[companyId][5],
            companyName = companies[companyId][2],
            vatNumber = companies[companyId][3],
            buyer = buyer,
            product = product,
            sellerSign = sellerName,
            buyerSign = buyerName
        })

        dbExec(connection, "INSERT INTO invoices (bookId, invoiceId, created, netPrice, postfix, companyName, vatNumber, buyer, product, sellerSign, buyerSign) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", currentInvoiceBook, #invoicesData, getRealTime().timestamp / 60 / 60 / 24, netPrice, companies[companyId][5], companies[companyId][2], companies[companyId][3], buyer, product, sellerName, buyerName)

        exports.sItems:giveItem(targetElement, 597, 1, false, currentInvoiceBook .. "-" .. #invoicesData, companies[companyId][2], netPrice)

        triggerClientEvent(targetElement, "showInfobox", targetElement, "i", "Kaptál egy számlát tőle: " .. sellerName .. ". Megtalálod az irataid között.")
        triggerClientEvent(client, "createInvoiceResponse", client, currentInvoiceBook, #invoicesData)
    end
)

addEvent("requestInvoice", true)
addEventHandler("requestInvoice", root,
    function (invoiceId)
        local invoiceSplit = split(invoiceId, "-")

        local bookId = invoiceSplit[1] .. "-" .. invoiceSplit[2]
        local invoiceIdEx = tonumber(invoiceSplit[3])

        local invoiceDatas = invoices[bookId]

        if invoiceDatas then
            local invoice = invoiceDatas[invoiceIdEx]

            triggerClientEvent(client, "gotInvoiceData", client, invoiceId, invoice)
        end
    end
)

function loadCompaniesEx(element)
    local sendCompanies = {}
    local characterId = getElementData(element, "char.ID")

    for k, v in pairs(companies) do
        if exports.sGroups:getPlayerPermission(element, "listCompanies") or v[7] == characterId then
            table.insert(sendCompanies, v)
        end
    end

    triggerClientEvent(element, "loadedCompanies", element, sendCompanies)
end

function table.copy(tab, recursive)
    assert(type(tab) == "table", "Bad argument @ 'table.copy' [Expected table at argument 1, got "..(type(tab)).."]")
    local ret = {}
    for key, value in pairs(tab) do
        if (type(value) == "table") and (recursive == true) then
            ret[key] = table.copy(value)
        else
            ret[key] = value
        end
    end
    return ret
end