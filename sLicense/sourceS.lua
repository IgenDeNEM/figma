local connection = exports.sConnection:getConnection()
local licenseType = {}

addEvent("licenseOfficeRequest", true)
addEventHandler("licenseOfficeRequest", getRootElement(),
	function(type)
		if type == "id" then
			triggerClientEvent(client, "licenseOfficeResponse", client, true)
			licenseType[client] = type
		elseif type == "dl" then
			local oldLicenseData = findOldIdentity(client, type)
			if getElementData(client, "char.drivingLicense") == 1 or oldLicenseData[2] then
				triggerClientEvent(client, "licenseOfficeResponse", client, true)
				licenseType[client] = type
			else
				triggerClientEvent(client, "licenseOfficeResponse", client, false)
				triggerClientEvent(client, "showInfobox", client, "e", "Nincs jogosultságod az engedély kiváltására")
			end
		elseif type == "wp" then
			local oldLicenseData = findOldIdentity(client, type)
			if exports.sItems:hasItem(client, 120) or oldLicenseData[2] then
				triggerClientEvent(client, "licenseOfficeResponse", client, true)
				licenseType[client] = type
			else
				triggerClientEvent(client, "licenseOfficeResponse", client, false)
				triggerClientEvent(client, "showInfobox", client, "e", "Nincs jogosultságod az engedély kiváltására")
			end
		elseif type == "fs" then
			triggerClientEvent(client, "licenseOfficeResponse", client, true)
			licenseType[client] = type
			local money = exports.sCore:getMoney(client)
			exports.sCore:setMoney(money - 10000)
		elseif type == "mine" then
			local money = exports.sCore:getMoney(client)
			local price = 5000
			if money >= price then
				exports.sCore:setMoney(client, money - price)
				triggerClientEvent(client, "licenseOfficeResponse", client, true)
				licenseType[client] = type
			else
				exports.sGui:showInfobox(client, "e", "Nincs elég pénzed az engedély kiváltásához!")
				triggerClientEvent(client, "licenseOfficeResponse", client, false)
			end
		end
	end
)

function randomCharset(length)
    local charset = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    local result = ""
    for i = 1, length do
        local randomIndex = math.random(1, #charset)
        result = result .. charset:sub(randomIndex, randomIndex)
    end
    return result
end

addEvent("sendLicensePhoto", true)
addEventHandler("sendLicensePhoto", getRootElement(),
	function(pixels)
		triggerClientEvent(client, "endLicensePhotoMode", client)

		processDocumentData(client, licenseType[client], pixels)

		licenseType[client] = nil
	end
)

function processJson(jsonTable)
    local function convertKeys(table)
        local newTable = {}
        for key, value in pairs(table) do
            local numericKey = tonumber(key)
            if numericKey then
                key = numericKey
            end

            if type(value) == "table" then
                newTable[key] = convertKeys(value)
            else
                newTable[key] = value
            end
        end
        return newTable
    end

    return convertKeys(jsonTable)
end

addEvent("loadLicenseData", true)
addEventHandler("loadLicenseData", root, 
	function(licenseId)
		local clientItems = exports.sItems:getElementItems(client)
		local licenseData = {}
		local foundData = {}

		for licenseIdentity, licenseData in pairs(clientItems) do
			if licenseData then
				if licenseData.data3 then
					local itemData = fromJSON(licenseData.data3)
					if itemData then
						if itemData.id == licenseId then
							foundData = {
								licenseData.data1,
								itemData
							}
							break
						end
					end
				end
			end
		end

		triggerClientEvent(client, "gotLicenseData", client, foundData[1], foundData[2])
	end
)

function findOldIdentity(playerElement, licenseType)
	local clientItems = exports.sItems:getElementItems(client)
	local licenseData = {}
	local foundData = {}

	for licenseIdentity, licenseData in pairs(clientItems) do
		if licenseData then
			if licenseData.data3 then
				local itemData = fromJSON(licenseData.data3)
				if itemData then
					if itemData.name == getElementData(playerElement, "char.name"):gsub("_", " ") and itemData.licenseType == licenseType then
						foundData = {licenseData.dbID, itemData.id}
						break
					end
				end
			end
		end
	end

	return foundData
end

function processDocumentData(element, type, data1)
	local currentTime = getRealTime().timestamp
	local randomId = math.random(100000, 999999)..""..randomCharset(2)
	local licenseIdentity = randomId



	if type == "id" then
		local expireTime = currentTime + 2678400

		local data2 = getElementData(element, "char.name"):gsub("_", " ")
		local oldLicenseData = findOldIdentity(element, type)

		if oldLicenseData[2] then
			licenseIdentity = oldLicenseData[2]
			exports.sItems:takeItem(element, "dbID", oldLicenseData[1], 1)
			exports.sGui:showInfobox(element, "s", "Sikeresen megújítottad a személyazonosító igazolványt!")
		else
			exports.sGui:showInfobox(element, "s", "Sikeresen kiváltottad a személyazonosító igazolványt!")
		end

		local data3 = toJSON({
			name = getElementData(element, "char.name"):gsub("_", " "),
			created = currentTime / 24 / 60 / 60,
			expire = expireTime / 24 / 60 / 60,
			licenseType = type,
			id = licenseIdentity
		})	
		
		local columnNames = {}
		local valueMarks = {}
		local parameters = {}

		local licenseDatas = {
			licenseType = "id",
			id = licenseIdentity,
			created = currentTime / 24 / 60 / 60,
			expire = expireTime / 24 / 60 / 60,
			photo = data1,
			name = getElementData(element, "char.name"):gsub("_", " "),
			charId = getElementData(element, "char.ID")
		}

		for k, v in pairs(licenseDatas) do
			table.insert(columnNames, k)
			table.insert(valueMarks, "?")
			table.insert(parameters, v)
		end

		dbExec(connection, "INSERT INTO licenses (" .. table.concat(columnNames, ",") .. ") VALUES (" .. table.concat(valueMarks, ",") .. ")", unpack(parameters))

		exports.sItems:giveItem(element, 207, 1, false, data1, data2, data3)
	elseif type == "dl" then
		local oldLicenseData = findOldIdentity(element, type)
		if getElementData(element, "char.drivingLicense") == 1 or oldLicenseData[2] then
			if oldLicenseData[2] then
				licenseIdentity = oldLicenseData[2]
				exports.sItems:takeItem(element, "dbID", oldLicenseData[1], 1)
				exports.sGui:showInfobox(element, "s", "Sikeresen megújítottad a vezetői engedélyt!")
			else
				exports.sGui:showInfobox(element, "s", "Sikeresen kiváltottad a vezetői engedélyt!")
			end

			local expireTime = currentTime + 2678400

			local data2 = getElementData(element, "char.name"):gsub("_", " ")

			local data3 = toJSON({
				name = getElementData(element, "char.name"):gsub("_", " "),
				created = currentTime / 24 / 60 / 60,
				expire = expireTime / 24 / 60 / 60,
				licenseType = type,
				id = licenseIdentity
			})	

			local columnNames = {}
			local valueMarks = {}
			local parameters = {}
	
			local licenseDatas = {
				licenseType = "dl",
				id = licenseIdentity,
				created = currentTime / 24 / 60 / 60,
				expire = expireTime / 24 / 60 / 60,
				photo = data1,
				name = getElementData(element, "char.name"):gsub("_", " "),
				charId = getElementData(element, "char.ID")
			}
	
			for k, v in pairs(licenseDatas) do
				table.insert(columnNames, k)
				table.insert(valueMarks, "?")
				table.insert(parameters, v)
			end
	
			dbExec(connection, "INSERT INTO licenses (" .. table.concat(columnNames, ",") .. ") VALUES (" .. table.concat(valueMarks, ",") .. ")", unpack(parameters))

			exports.sItems:giveItem(element, 208, 1, false, data1, data2, data3)
		end
	elseif type == "fs" then
		local expireTime = currentTime + 2678400

		local oldLicenseData = findOldIdentity(element, type)
		if oldLicenseData[2] then
			licenseIdentity = oldLicenseData[2]
			exports.sItems:takeItem(element, "dbID", oldLicenseData[1], 1)
			exports.sGui:showInfobox(element, "s", "Sikeresen megújítottad a horgász engedélyt!")
		else
			exports.sGui:showInfobox(element, "s", "Sikeresen kiváltottad a horgász engedélyt!")
		end

		local data2 = getElementData(element, "char.name"):gsub("_", " ")

		local data3 = toJSON({
			name = getElementData(element, "char.name"):gsub("_", " "),
			created = currentTime / 24 / 60 / 60,
			expire = expireTime / 24 / 60 / 60,
			licenseType = type,
			id = licenseIdentity
		})	

		local columnNames = {}
		local valueMarks = {}
		local parameters = {}

		local licenseDatas = {
			licenseType = "fs",
			id = licenseIdentity,
			created = currentTime / 24 / 60 / 60,
			expire = expireTime / 24 / 60 / 60,
			photo = data1,
			name = getElementData(element, "char.name"):gsub("_", " "),
			charId = getElementData(element, "char.ID")
		}

		for k, v in pairs(licenseDatas) do
			table.insert(columnNames, k)
			table.insert(valueMarks, "?")
			table.insert(parameters, v)
		end

		dbExec(connection, "INSERT INTO licenses (" .. table.concat(columnNames, ",") .. ") VALUES (" .. table.concat(valueMarks, ",") .. ")", unpack(parameters))

		exports.sItems:giveItem(element, 310, 1, false, data1, data2, data3)
	elseif type == "wp" then

		local oldLicenseData = findOldIdentity(element, type)
		if oldLicenseData[2] then
			licenseIdentity = oldLicenseData[2]
			exports.sItems:takeItem(element, "dbID", oldLicenseData[1], 1)
			exports.sGui:showInfobox(element, "s", "Sikeresen megújítottad a fegyver engedélyt!")
		else
			exports.sGui:showInfobox(element, "s", "Sikeresen kiváltottad a fegyver engedélyt!")
		end

		local expireTime = currentTime + 2678400

		local data2 = getElementData(element, "char.name"):gsub("_", " ")

		local data3 = toJSON({
			name = getElementData(element, "char.name"):gsub("_", " "),
			created = currentTime / 24 / 60 / 60,
			expire = expireTime / 24 / 60 / 60,
			licenseType = type,
			id = licenseIdentity
		})	
		
		local columnNames = {}
		local valueMarks = {}
		local parameters = {}

		local licenseDatas = {
			licenseType = "wp",
			id = licenseIdentity,
			created = currentTime / 24 / 60 / 60,
			expire = expireTime / 24 / 60 / 60,
			photo = data1,
			name = getElementData(element, "char.name"):gsub("_", " "),
			charId = getElementData(element, "char.ID")
		}

		for k, v in pairs(licenseDatas) do
			table.insert(columnNames, k)
			table.insert(valueMarks, "?")
			table.insert(parameters, v)
		end

		dbExec(connection, "INSERT INTO licenses (" .. table.concat(columnNames, ",") .. ") VALUES (" .. table.concat(valueMarks, ",") .. ")", unpack(parameters))

		exports.sItems:giveItem(element, 308, 1, false, data1, data2, data3)
		exports.sItems:takeItem(element, "itemId", 120)
	elseif type == "mine" then
		local oldLicenseData = findOldIdentity(element, type)
		if oldLicenseData[2] then
			licenseIdentity = oldLicenseData[2]
			exports.sItems:takeItem(element, "dbID", oldLicenseData[1], 1)
			exports.sGui:showInfobox(element, "s", "Sikeresen megújítottad a bányász engedélyt!")
		else
			exports.sGui:showInfobox(element, "s", "Sikeresen kiváltottad a bányász engedélyt!")
		end

		local expireTime = currentTime + 2678400

		local data2 = getElementData(element, "char.name"):gsub("_", " ")

		local data3 = toJSON({
			name = getElementData(element, "char.name"):gsub("_", " "),
			created = currentTime / 24 / 60 / 60,
			expire = expireTime / 24 / 60 / 60,
			licenseType = type,
			id = licenseIdentity
		})	
		
		local columnNames = {}
		local valueMarks = {}
		local parameters = {}

		local characterId = getElementData(element, "char.ID")
		local picPath = "licensePhotos/"..characterId..".png"
		local file = fileCreate(picPath)
		fileWrite(file, data1)
		fileClose(file)

		local licenseDatas = {
			licenseType = "mine",
			id = licenseIdentity,
			created = currentTime / 24 / 60 / 60,
			expire = expireTime / 24 / 60 / 60,
			photo = data1,
			name = getElementData(element, "char.name"):gsub("_", " "),
			charId = getElementData(element, "char.ID")
		}

		for k, v in pairs(licenseDatas) do
			table.insert(columnNames, k)
			table.insert(valueMarks, "?")
			table.insert(parameters, v)
		end

		dbExec(connection, "INSERT INTO licenses (" .. table.concat(columnNames, ",") .. ") VALUES (" .. table.concat(valueMarks, ",") .. ")", unpack(parameters))

		exports.sItems:giveItem(element, 718, 1, false, data1, data2, data3)
	end

	triggerClientEvent(element, "showInfobox", element, "i", "Új okmányod sorszáma: "..licenseIdentity)
end

addEvent("requestPicForMine", true)
addEventHandler("requestPicForMine", root, function(id)
	if client and client == source then
		local charId = getElementData(client, "char.ID")
		local filePath = "licensePhotos"..charId..".sight"
		local buffer = {}

		if fileExists(filePath) then
			local minePictureFile = fileOpen(filePath, true)

			while not fileIsEOF( minePictureFile ) do
				buffer[#buffer + 1] = fileRead(minePictureFile, 1024)
			end
		
			fileClose(minePictureFile)
		end

		triggerClientEvent(client, "gotPicForMine", client, id, table.concat(buffer))
	end
end)

function doesPlayerHaveValidWeaponLicense(player)
	local charID = getElementData(player, "char.ID")
	if not charID then return false end

	local date = getRealTime().timestamp / 24 / 60 / 60
	local qh = dbQuery(connection, "SELECT expire, revoked FROM licenses WHERE charId = ? AND licenseType = ?", charID, "wp", 0)
	local result = dbPoll(qh, -1)

	if result and #result > 0 then
		for _, v in ipairs(result) do
			if v.expire >= date and v.revoked == 0 then
				return true
			end
		end
	end
	return false
end