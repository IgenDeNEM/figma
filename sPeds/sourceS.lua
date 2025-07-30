local connection = exports.sConnection:getConnection()

local peds = {}
local wp = {
    [4] = 3500,    -- Rádió
    [6] = 100,     -- Hot Dog
    [7] = 100,     -- Hamburgeer
    [8] = 100,     -- Kebab
    [9] = 7500,    -- Telefon
    [20] = 4500,   -- UV Lámpa
    [22] = 3900,   -- Akkumlátor sav
    [23] = 1500,   -- Öngyújtó benzin
    [26] = 450,    -- Szódabikarbóna
    [27] = 550,    -- Granulátom
    [29] = 4500,   -- Cigipapír (rollni)
    [34] = 3200,   -- Kalapács
    [39] = 100,    -- Ásványvíz
    [40] = 250,    -- Bor
    [42] = 100,    -- Fanta üveges
    [43] = 250,    -- Pálinka
    [44] = 250,    -- Sör
    [45] = 250,    -- Whiskey
    [46] = 250,    -- Vodka
    [68] = 3300,   -- Golf ütő
    [71] = 6700,   -- Baseball ütő
    [72] = 5000,   -- Ásó
    [73] = 9700,   -- Billiárd dákó
    [76] = 100000,      -- Colt-45 [[IDK]]
    [97] = 6700,   -- Spray kanna
    [99] = 99000,  -- Nikon D600
    [103] = 32000, -- Virágok
    [104] = 11000, -- Sétapálca
    [118] = 100000,     -- Bilincs [[IDK]]
    [119] = 100000,     -- Bilincskulcs [[IDK]]
    [126] = 100,   -- Kész szendvics
    [147] = 100,   -- Zsemle
    [148] = 2000,  -- Gyógyszer
    [149] = 1750,  -- Vitamin
    [150] = 15000, -- Hi-Fi
    [151] = 10,    -- Festék patron
    [153] = 4500,  -- Eü. doboz
    [160] = 170,   -- Jutalomfalat
    [161] = 170,   -- Kutyatáp
    [162] = 170,   -- Kutyasnack
    [164] = 5500,  -- Csákány
    [165] = 10000,      -- Kisebb petárda [[IDK]]
    [166] = 10000,      -- Nagyobb petárda [[IDK]]
    [167] = 100,   -- Magyaros Pizza
    [168] = 100,   -- Mozarella Pizza
    [169] = 100,   -- Bolognese Pizza
    [170] = 100,   -- Spaghetti Bolognese
    [171] = 100,   -- Spaghetti Carbonara
    [179] = 100,   -- Sajtos Hamburger
    [180] = 100,   -- Dupla húsos hamburger
    [181] = 100,   -- Sültkrumpli
    [186] = 100,   -- Coca Cola dobozos
    [195] = 15000, -- Hagyományos locsoló kölni
    [204] = 4400,  -- Dobókocka
    [205] = 4000,  -- Kártyapakli
    [245] = 9650,  -- Flex
    [297] = 10000,      -- Tüzijáték [[IDK]]
    [298] = 10000,      -- Tüzijáték 2 [[IDK]]
    [311] = 500,   -- Üres adásvételi
    [312] = 430,   -- Toll
    [362] = 8900,  -- Véső
    [372] = 990,   -- Kötszer 
    [373] = 7600,  -- Üres kanna
    [390] = 200,   -- Vetőmag: TV Paprika
    [391] = 200,   -- Vetőmag: Almapaprika
    [392] = 200,   -- Vetőmag: Chili
    [393] = 200,   -- Dughagyma: Vöröshagyma
    [394] = 200,   -- Dughagyma: Lilahagyma
    [395] = 200,   -- Vetőmag: Sütőtök
    [396] = 200,   -- Vetőmag: Sárgadinnye
    [397] = 200,   -- Vetőmag: Görögdinnye
    [398] = 200,   -- Vetőmag: Saláta
    [399] = 200,   -- Vetőmag: Retek
    [400] = 200,   -- Vetőmag: Sárgarépa
    [401] = 200,   -- Vetőmag: Petrezselyem
    [402] = 200,   -- Vetőmag: Karalábé
    [403] = 200,   -- Vetőmag: Káposzta
    [404] = 200,   -- Vetőmag: Uborka
    [420] = 100,   -- Monster energiaital
    [421] = 100,   -- RedBull energiaital
    [422] = 100,   -- Hell energiaital
    [430] = 770,   -- SHTG tápoldat koncentrátum
    [441] = 7450,  -- Bikakábel
    [446] = 35000, -- Fémdetektor
    [447] = 3600,  -- Lombik
    [453] = 100,   -- Bélyeg
    [470] = 15000, -- Lángvágó
    [493] = 100000,     -- Glock 19 [[IDK]]
    [534] = 100000,     -- .45 ACP [[IDK]]
    [542] = 100000,     -- 9x19mm [[IDK]]
    [586] = 1000,  -- Juhnyírógép
    [593] = 250,   -- Zsák
    [594] = 10000,      -- Tüzijáték 3
    [610] = 12500, -- Modern HI-FI
    [611] = 6500,  -- Pici HI-FI
    [614] = 15000, -- Sightrod2000
    [615] = 25000, -- Sightrod3000
    [616] = 35000, -- Sightrod4000
    [619] = 2500,  -- Bézs damil
    [620] = 4500,  -- Zöld damil
    [621] = 3500,  -- Fehér damil
    [622] = 6000,  -- Piros damil
    [626] = 1500,  -- Úszó 1
    [627] = 1500,  -- Úszó 2
    [628] = 1500,  -- Úszó 3
    [629] = 1500,  -- Úszó 4
    [630] = 500,   -- Egy doboz csali
    [719] = 15000, -- Migumoto Tablet
    [720] = 50000, -- Dinamit (Meglévő járat)
    [721] = 20000, -- Dinamit (Új járat)
}

function loadAllPeds(qh)
	local result = dbPoll(qh, 0)

	if result then
		for k, v in pairs(result) do
            local pedPrice, pedStock = {}, {}

			peds[v.id] = {
                id = v.id,
                name = v.name,
                skin = v.skin,
                ownerId = v.ownerId,
                owner = v.owner,
                posX = v.posX,
                posY = v.posY,
                posZ = v.posZ,
                posR = v.posR,
                interior = v.interior,
                dimension = v.dimension,
                selectedItems = fromJSON(v.selectedItems) or {},
                categories = fromJSON(v.categories) or {},
                balance = v.balance
            }

            peds[v.id].pedPrice = {}
            peds[v.id].pedStock = {}

            for j, l in pairs(fromJSON(v.pedPrice)) do
                peds[v.id].pedPrice[tonumber(j)] = l
            end

            for j, l in pairs(fromJSON(v.pedStock)) do
                peds[v.id].pedStock[tonumber(j)] = l
            end

            if v.owner == "server" then
                peds[v.id].isServer = true
            end
		end
	end
end

addEventHandler("onResourceStart", resourceRoot,
    function ()
        if fileExists("wp.see") then
            local wpFile = fileOpen("wp.see")
            local wpData = fileRead(wpFile, fileGetSize(wpFile))

            local tempWP = fromJSON(wpData)

            for k, v in pairs(tempWP) do
                wp[tonumber(k)] = v
            end
        end

        dbQuery(loadAllPeds, connection, "SELECT * FROM peds")
    end
)

addEvent("requestPedShops", true)
addEventHandler("requestPedShops", root,
    function ()
        triggerLatentClientEvent(client, "gotPedShops", client, peds)
    end
)

addEvent("requestPedShopInit", true)
addEventHandler("requestPedShopInit", root,
    function (id)
        local pedData = peds[id]

        if pedData then
            local rawItems = pedData.selectedItems
            local rawItemCategories = pedData.categories
            local itemCategories, mi, mj, allowedItems = loadPedCategories(rawItems, rawItemCategories)
            local wpData, ppData, psData = loadPedWareData(id)
            local canEdit = canEditShop(client, id)

            triggerClientEvent(client, "gotPedShopCanEdit", client, id, canEdit, allowedItems, wpData, psData, ppData)
            triggerClientEvent(client, "gotPedShopCategories", client, id, itemCategories, mi, mj, false, false)
        end
    end
)

addEvent("requestPedShopItems", true)
addEventHandler("requestPedShopItems", root,
    function (id, cat)
        local items, pp, ps = loadShopItems(id, cat)

        triggerClientEvent(client, "gotPedShopItems", client, id, cat, items, false, pp, ps)
    end
)

addEvent("createNewPedShopCategory", true)
addEventHandler("createNewPedShopCategory", root,
    function (id)
        local pedData = peds[id]
        local canEdit = canEditShop(client, id)
        if pedData and canEdit then
            table.insert(pedData.categories, {
                name = "Új kategória",
                tooltip = "",
                icon = 1,
                sort = #pedData.categories + 1,
                items = {}
            })

            local itemCategories, mi, mj, allowedItems = loadPedCategories(pedData.selectedItems, pedData.categories)
            local canEdit = canEditShop(client, id)
            local wpData, ppData, psData = loadPedWareData(id)

            triggerClientEvent(client, "gotPedShopCanEdit", client, id, canEdit, allowedItems, wpData, psData, ppData)
            triggerClientEvent(client, "gotPedShopCategories", client, id, itemCategories, mi, mj, false, #pedData.categories)

            dbExec(connection, "UPDATE peds SET categories = ? WHERE id = ?", toJSON(pedData.categories), id)
        end
    end
)

addEvent("editPedShopCategory", true)
addEventHandler("editPedShopCategory", root,
    function (id, cat, name, tooltip, icon)
        local pedData = peds[id]

        local canEdit = canEditShop(client, id)

        if pedData and canEdit then
            local category = pedData.categories[cat]

            if category then
                category.name = name
                category.tooltip = tooltip
                category.icon = icon

                local itemCategories, mi, mj, allowedItems = loadPedCategories(pedData.selectedItems, pedData.categories)
                local canEdit = canEditShop(client, id)
                local wpData, ppData, psData = loadPedWareData(id)

                triggerClientEvent(client, "gotPedShopCanEdit", client, id, canEdit, allowedItems, wpData, psData, ppData)
                triggerClientEvent(client, "gotPedShopCategories", client, id, itemCategories, mi, mj, false, cat)

                dbExec(connection, "UPDATE peds SET categories = ? WHERE id = ?", toJSON(pedData.categories), id)
            end
        end
    end
)

addEvent("pedShopSaveUnsaved", true)
addEventHandler("pedShopSaveUnsaved", root,
    function (id, cat, items, swaps, catdels)
        local pedData = peds[id]

        local canEdit = canEditShop(client, id)

        if pedData and canEdit then
            local category = pedData.categories[cat]

            if category then
                for columnId, column in pairs(items) do
                    if not category.items[columnId] then
                        category.items[columnId] = {}
                    end

                    for rowId, item in pairs(column) do
                        if not category.items[columnId][rowId] then
                            category.items[columnId][rowId] = {}
                        end
                        
                        category.items[columnId][rowId] = item
                    end
                end

                if swaps then
                    for categoryId, newIndex in pairs(swaps) do
                        if pedData.categories[categoryId] then
                            pedData.categories[categoryId].sort = newIndex
                        end
                    end
                end

                for k, v in pairs(catdels) do
                    if pedData.categories[k] then
                        pedData.categories[k] = nil
                    end
                end
                
                local itemCategories, mi, mj, allowedItems = loadPedCategories(pedData.selectedItems, pedData.categories)
                local canEdit = canEditShop(client, id)
                local wpData, ppData, psData = loadPedWareData(id)

                triggerClientEvent(client, "gotPedShopCanEdit", client, id, canEdit, allowedItems, wpData, psData, ppData)
                triggerClientEvent(client, "gotPedShopCategories", client, id, itemCategories, mi, mj, false, cat)

                dbExec(connection, "UPDATE peds SET categories = ? WHERE id = ?", toJSON(pedData.categories), id)
            end
        end
    end
)

addEvent("requestPedShopAllWareData", true)
addEventHandler("requestPedShopAllWareData", root,
    function (id)
        local pedData = peds[id]

        if pedData then
            local wpData, ppData, psData, bal = loadPedWareData(id)

            triggerClientEvent(client, "gotPedShopAllWareData", client, id, wpData, ppData, psData, bal)
        end
    end
)

addEvent("requestPedShopSingleItemWareData", true)
addEventHandler("requestPedShopSingleItemWareData", root,
    function (id, item)
        local pedData = peds[id]

        local canEdit = canEditShop(client, id)

        if pedData and canEdit then
            local wpData, ppData, psData = loadPedSingleWareData(id, item)

            triggerClientEvent(client, "gotPedShopSingleItemWareData", client, id, item, wpData, ppData, psData)
        end
    end
)

addEvent("updatePedShopWareItem", true)
addEventHandler("updatePedShopWareItem", root,
    function (id, item, price, order)
        local pedData = peds[id]

        local canEdit = canEditShop(client, id)

        if pedData and canEdit then
            local charMoney = exports.sCore:getMoney(client) or 0
            
            if order > 0 then
                local wholesalePrice = wp[item] or 10
                local totalAmount = wholesalePrice * order
                
                if charMoney >= totalAmount then
                    exports.sCore:setMoney(client, charMoney - totalAmount)
                
                    if not pedData.pedStock[item] then
                        pedData.pedStock[item] = 0
                    end

                    pedData.pedStock[item] = pedData.pedStock[item] + order
                else
                    local wpData, ppData, psData = loadPedSingleWareData(id, item)

                    triggerClientEvent(client, "gotPedShopSingleItemWareData", client, id, item, wpData, ppData, psData)
                    triggerClientEvent(client, "showInfobox", client, "e", "Nincs nálad elég pénz a készlet feltöltéséhez! ($" .. totalAmount .. ")")

                    return
                end
            end

            if not pedData.pedPrice[item] then
                pedData.pedPrice[item] = {}
            end

            pedData.pedPrice[item] = price

            local wpData, ppData, psData = loadPedSingleWareData(id, item)
            
            triggerClientEvent(client, "gotPedShopSingleItemWareData", client, id, item, wpData, ppData, psData, true)
            
            dbExec(connection, "UPDATE peds SET pedPrice = ?, pedStock = ? WHERE id = ?", toJSON(pedData.pedPrice), toJSON(pedData.pedStock), id)
        end
    end
)

addEvent("purchasePedShop", true)
addEventHandler("purchasePedShop", root,
    function (id, items)

        local needLicense = false

        for k, v in pairs(items) do
            if onlyWeaponLicenseItems[k] then
                needLicense = true
                break
            end
        end

        local hasValidLicense = exports.sLicense:doesPlayerHaveValidWeaponLicense(client)

        if needLicense and not hasValidLicense then
            exports.sGui:showInfobox(client, "e", "A tárgy megvásárlásához érvényes fegyverengedélyre van szükséged!")
            triggerClientEvent(client, "clearPedShopCart", client, id, items)
            return
        end

        local pedData = peds[id]
        if pedData then
            local totalAmount = 0
            local charMoney = exports.sCore:getMoney(client) or 0
            
            for k, v in pairs(items) do
                if not wp[k] then

                    return
                end
                local itemPrice = pedData.pedPrice[k] or wp[k] or 10

                totalAmount = totalAmount + (itemPrice * v)
            end

            if charMoney >= totalAmount then
                for k, v in pairs(items) do
                    local itemPrice = pedData.pedPrice[k] or wp[k] or 10

                    if pedData.owner ~= "server" then
                        if pedData.pedStock[k] < v then
                            triggerClientEvent(client, "clearPedShopCart", client, id, items)
                            triggerClientEvent(client, "showInfobox", client, "e", "Nincsen raktáron elég az adott tárgyból! (" .. exports.sItems:getItemName(k) .. ")")

                            return
                        end
                        
                        pedData.pedStock[k] = pedData.pedStock[k] - v
                        pedData.balance = pedData.balance + (itemPrice * v)
                    end


                    local itemData1 = nil
                    if k == 312 then
                        itemData1 = 0
                    end

                    if exports.sItems:isItemStackable(k) then
                        exports.sItems:giveItem(client, k, v, 1, false, itemData1)
                    else
                        for i = 1, v do
                            exports.sItems:giveItem(client, k, 1, false, itemData1)
                        end                        
                    end
                    
                    triggerClientEvent(client, "clearPedShopCart", client, id, {})

                    local pedData = peds[id]

                    if pedData then
                        local rawItems = pedData.selectedItems
                        local rawItemCategories = pedData.categories
                        local itemCategories, mi, mj, allowedItems = loadPedCategories(rawItems, rawItemCategories)
                        local canEdit = canEditShop(client, id)
                        local wpData, ppData, psData = loadPedWareData(id)

                        triggerClientEvent(client, "gotPedShopCanEdit", client, id, canEdit, allowedItems, wpData, psData, ppData)
                        triggerClientEvent(client, "gotPedShopCategories", client, id, itemCategories, mi, mj, false, false)
                    end
                end

                exports.sCore:setMoney(client, charMoney - totalAmount)

                dbExec(connection, "UPDATE peds SET balance = ? WHERE id = ?", pedData.balance, id)
                dbExec(connection, "UPDATE peds SET pedStock = ? WHERE id = ?", toJSON(pedData.pedStock), id)
            else
                triggerClientEvent(client, "clearPedShopCart", client, id, items)
                triggerClientEvent(client, "showInfobox", client, "e", "Nincs nálad elég pénz!")
            end
        end
    end
)

function donePedInit(qh, id, client, name, skin, owner, ownerId, selectedItems)
    if peds[id] then
        dbFree(qh)

        peds[id].name = name
        peds[id].skin = skin
        peds[id].owner = owner
        peds[id].ownerId = ownerId
        peds[id].selectedItems = selectedItems
        
        if owner == "server" then
            peds[id].isServer = true
        end

        for k, v in pairs(getElementsByType("player")) do                    
            triggerClientEvent(v, "gotSinglePedShopData", v, id, peds[id])
        end
    end
end

addEvent("donePedInit", true)
addEventHandler("donePedInit", root,
    function (id, name, skin, owner, ownerId, selectedItems)
        skin = tonumber(skin)

        dbQuery(donePedInit, {id, client, name, skin, owner, ownerId, selectedItems}, connection, "UPDATE peds SET name = ?, skin = ?, ownerId = ?, owner = ?, selectedItems = ? WHERE id = ?", name, skin, ownerId, owner, toJSON(selectedItems), id)
    end
)

addEvent("editPedShopWholesalePrice", true)
addEventHandler("editPedShopWholesalePrice", root,
    function (item, price)
        wp[item] = price
        
        if fileExists("wp.see") then
            fileDelete("wp.see")
        end

        local wpFile = fileCreate("wp.see")
        fileWrite(wpFile, toJSON(wp))
        fileClose(wpFile)
    end
)

addEvent("requestPedShopItemsForCart", true)
addEventHandler("requestPedShopItemsForCart", root,
    function (id, list)
        local pp, ps = {}, {}

        for k, v in pairs(list) do
            pp[v] = peds[id].pedPrice[v] or wp[v] or 10
            ps[v] = peds[id].pedStock[v] or 0
        end

        triggerClientEvent(client, "gotPedShopItemsForCart", client, id, pp, ps)
    end
)

addEvent("pedShopPayOut", true)
addEventHandler("pedShopPayOut", root,
    function (id)
        if peds[id] then
            local pedData = peds[id]

            local canEdit = canEditShop(client, id)

            if canEdit then
                local charMoney = exports.sCore:getMoney(client) or 0
                local pedBalance = pedData.balance or 0
                local payOutAmount = pedBalance - math.floor(pedBalance * payoutTax)

                if pedBalance > 0 then
                    exports.sCore:setMoney(client, charMoney + payOutAmount)
                    pedData.balance = 0

                    dbExec(connection, "UPDATE peds SET balance = ? WHERE id = ?", pedData.balance, id)

                    local wpData, ppData, psData, bal = loadPedWareData(id)

                    triggerClientEvent(client, "gotPedShopAllWareData", client, id, wpData, ppData, psData, bal)
                end
            end
        end
    end
)

function insertSinglePed(qh, sourcePlayer)
    local _, _, id = dbPoll(qh, 0)
    local x, y, z = getElementPosition(sourcePlayer)
    local _, _, r = getElementRotation(sourcePlayer)

    peds[id] = {
        id = id,
        name = "Új bolt",
        skin = 0,
        ownerId = "0",
        owner = "server",
        posX = x,
        posY = y,
        posZ = z,
        posR = r,
        interior = getElementInterior(sourcePlayer),
        dimension = getElementDimension(sourcePlayer),
        selectedItems = {},
        categories = {},
        pedPrice = {},
        pedStock = {},
        balance = 0
    }

    for k, v in pairs(getElementsByType("player")) do
        triggerClientEvent(v, "gotSinglePedShopData", v, id, peds[id])
    end
    
    triggerClientEvent(sourcePlayer, "startShopPedInit", sourcePlayer, id, {}, "server", 0)
end

addCommandHandler("createped",
    function (sourcePlayer, commandName)
        if exports.sPermission:hasPermission(sourcePlayer, commandName) then
            local x, y, z = getElementPosition(sourcePlayer)
            local _, _, r = getElementRotation(sourcePlayer)

            dbQuery(insertSinglePed, {sourcePlayer}, connection, "INSERT INTO peds (name, skin, ownerId, owner, posX, posY, posZ, posR, interior, dimension, selectedItems, categories, pedPrice, pedStock) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", "Új bolt", 0, 0, "server", x, y, z, r, getElementInterior(sourcePlayer), getElementDimension(sourcePlayer), toJSON({}), toJSON({}), toJSON({}), toJSON({}))
        end
    end
)

addCommandHandler("pedwp",
    function (sourcePlayer, commandName)
        if exports.sPermission:hasPermission(sourcePlayer, commandName) then
            triggerClientEvent(sourcePlayer, "gotPedShopWholesaleEditor", sourcePlayer, wp)
        end
    end
)

function loadPedCategories(rawItems, rawItemCategories)
    local allowedItems = {}
    local itemCategories = {}
    local mi = {}
    local mj = {}

    for k, v in pairs(rawItems) do
        allowedItems[tonumber(k)] = true
    end
    
    for k, v in pairs(rawItemCategories) do
        local items = v.items
        local category = {}

        for i, j in pairs(items) do
            table.insert(category, j)
        end

        category.sort = v.sort
        category.name = v.name
        category.tooltip = v.tooltip
        category.items = v.items
        category.mi = v.mi
        category.mj = v.mj
        category.icon = v.icon

        table.insert(itemCategories, category)
    end

    for k, v in pairs(itemCategories) do
        local items = v.items
        local miCount = 0
        local mjCount = 0

        for columnId, column in pairs(items) do
            for rowId, item in pairs(column) do
                rowId = tonumber(rowId)
                
                if item then
                    if rowId > mjCount then
                        mjCount = rowId
                    end

                    if columnId > miCount then
                        miCount = columnId
                    end
                end                
            end
        end

        mi[k] = miCount
        mj[k] = mjCount
    end

    return itemCategories, mi, mj, allowedItems
end

function loadShopItems(id, cat)
    local pedData = peds[id]
    local items = {}
    local ps = {}
    local pp = {}
    local category = pedData.categories[cat]
    local isServer = pedData.owner == "server"

    if not isServer then
        for k, v in pairs(pedData.pedStock) do
            ps[k] = v
        end
    end

    for k, v in pairs(pedData.pedPrice) do
        pp[k] = v
    end

    if category then
        for columnId, column in pairs(category.items) do
            local newColumn = {}
            
            for rowId, item in pairs(column) do
                newColumn[tonumber(rowId)] = item
            end

            items[tonumber(columnId)] = newColumn
        end
    end

    return items, pp, ps
end

function loadPedWareData(id)
    local pedData = peds[id]
    
    if pedData then
        local wPrices = {}
        local pp = {}
        local ps = {}
        local bal = pedData.balance or 0

        for k, v in pairs(pedData.pedPrice) do
            pp[k] = v
        end

        for k, v in pairs(pedData.pedStock) do
            ps[k] = v
        end

        for k, v in pairs(pedData.selectedItems) do
            k = tonumber(k)

            wPrices[k] = wp[k] or 10
        end

        return wPrices, pp, ps, bal
    end
end

function loadPedSingleWareData(id, item)
    local pedData = peds[id]
    
    if pedData then
        local wpData = wp[item] or 10
        local ppData = pedData.pedPrice[item] or 10
        local psData = pedData.pedStock[item] or 0
        
        return wpData, ppData, psData
    end
end

function canEditShop(player, id)
    local pedData = peds[id]

    if pedData then
        local charId = getElementData(player, "char.ID")
        local adminLevel = getElementData(player, "acc.adminLevel") or 0
        local ownerId = tonumber(pedData.ownerId)
        local canEdit = false

        if pedData.owner == "char" then
            if ownerId == charId then
                canEdit = true
            end
        elseif pedData.owner == "interior" then
            local isOwner = charId == exports.sInteriors:getInteriorOwner(pedData.ownerId) and true or false

            if isOwner then
                canEdit = true
            end
        elseif pedData.owner == "group" then
            local hasPermission = exports.sGroups:getPlayerPermissionInGroup(player, "editPed", pedData.ownerId)

            if hasPermission then
                canEdit = true
            end
        end

        if adminLevel >= 6 then
            canEdit = true
        end

        return canEdit
    end
end

addCommandHandler("editped",
    function (sourcePlayer, commandName, id)
        if getElementData(sourcePlayer, "acc.adminLevel") >= 8 then
            if not id then
                outputChatBox("[color=sightblue][SightMTA - Bolt]:[color=hudwhite] /" .. commandName .. " [ID]", sourcePlayer)
                
                return
            end

            id = tonumber(id)

            local pedData = peds[id]

            if pedData then
                triggerClientEvent(sourcePlayer, "startShopPedInit", sourcePlayer, id, pedData.selectedItems, pedData.owner, pedData.ownerId)
            end
        end
    end
)

function getInteriorPeds(interior, dimension)
    local interiorPeds = {}
    
    for k, v in pairs(peds) do
        if v.dimension == dimension and v.interior == interior then
            table.insert(interiorPeds, v)
        end
    end
    return interiorPeds
end

function getPedDetailsByID(id)
    if peds[id] then
        return peds[id]
    end
    return false
end

function setPedPosition(sourcePlayer, id)
    if peds[id] then
        local x, y, z = getElementPosition(sourcePlayer)
        local int, dim = getElementInterior(sourcePlayer), getElementDimension(sourcePlayer)
        peds[id].posX, peds[id].posY, peds[id].posZ, peds[id].interior, peds[id].dimension = x, y, z, int, dim

        dbExec(connection, "UPDATE peds SET posX = ?, posY = ?, posZ = ?, interior = ?, dimension = ? WHERE id = ?", x, y, z, int, dim, id)

        triggerClientEvent("gotSinglePedShopData", sourcePlayer, id, peds[id])
        return true
    end
    return false
end

function setPedRotation(sourcePlayer, id)
    if peds[id] then
        local rx, ry, rz = getElementRotation(sourcePlayer)
        peds[id].posR = rz

        dbExec(connection, "UPDATE peds SET posR = ? WHERE id = ?", r, id)

        triggerClientEvent("gotSinglePedShopData", sourcePlayer, id, peds[id])
        return true
    end
    return false
end

function deletePed(sourcePlayer, id)
    if peds[id] then
        peds[id] = nil
        
        dbExec(connection, "DELETE FROM peds WHERE id = ?", id)

        triggerClientEvent("gotSinglePedShopData", sourcePlayer, id, peds[id])
        return true
    end
    return false
end