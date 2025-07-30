local connection = false
local storedBoughtClothes = {}
local storedCurrentClothes = {}
local loadedArmors = {}
local storedWeaponPositions = {}
local storedWeapons = {}

addEventHandler("onResourceStart", getRootElement(), function(res)
    local resName = getResourceName(res)

    if res == getThisResource() then
        connection = exports.sConnection:getConnection()

		for k, v in pairs(getElementsByType("player")) do
			storePlayerClothes(v)
		end
    elseif resName == "sConnection" then
        connection = exports.sConnection:getConnection()
    end
end)

function storePlayerClothes(player)
	local charID = tonumber(getElementData(player, "char.ID"))

	if charID then
		dbQuery(function(qh, player, charID)
			local result = dbPoll(qh, 0)

			if #result > 0 then
				local boughtClothes = result[1].boughtClothes
				local currentClothes = result[1].clothesPos
				local weaponPos = result[1].weaponPos

				storedBoughtClothes[player] = fromJSON(boughtClothes) or {}
				storedCurrentClothes[player] = fromJSON(currentClothes) or {}
				storedWeapons[player] = {}

				storedWeaponPositions[player] = fromJSON(weaponPos) or {}
				
				for k in pairs(storedWeaponPositions[player]) do
					if type(k) == "string" and tonumber(k) then
						storedWeaponPositions[player][tonumber(k)] = storedWeaponPositions[player][k]
						storedWeaponPositions[player][k] = nil

						if not exports.sItems:hasItem(player, tonumber(k)) then
							storedWeaponPositions[player][tonumber(k)] = nil
						end
					end
				end

				storedCurrentClothes[player][-1] = storedCurrentClothes[player]["-1"]
				storedCurrentClothes[player]["-1"] = nil
				
				for k in pairs(storedCurrentClothes[player]) do
					if type(k) == "string" and tonumber(k) then
						storedCurrentClothes[player][tonumber(k)] = storedCurrentClothes[player][k]
						storedCurrentClothes[player][k] = nil
					end
				end
				
				loadPlayerArmors(player, true, true)
				processPlayerWeaponItems(exports.sItems:getElementItems(player), player)

				triggerLatentClientEvent(player, "gotBoughtClothes", player, storedBoughtClothes[player])
				triggerLatentClientEvent(player, "gotNewClothesshopSlots", player, result[1].clothesLimit)
				
				local clothes = storedCurrentClothes[player] or {}
			
				for k in pairs(clothes) do
					local data = clothes[k]
					if data then
						triggerLatentClientEvent(player, "gotPlayerCloth", player, tonumber(k), data.model, data.bone, data.x, data.y, data.z, data.q, data.sx, data.sy, data.sz, data.armorId)
					end
				end
			end
		end, {player, charID}, connection, "SELECT boughtClothes, weaponPos, clothesPos, clothesLimit FROM characters WHERE characterId = ?", charID)
	end
end

addEvent("requestPlayerClothes", true)
addEventHandler("requestPlayerClothes", getRootElement(), function()
    local charID = tonumber(getElementData(source, "char.ID"))

    if charID then
		local clothes = storedCurrentClothes[source] or {}

		for k in pairs(clothes) do
			local data = clothes[k]
			if data then
				triggerLatentClientEvent(client, "gotPlayerCloth", source, tonumber(k), data.model, data.bone, data.x, data.y, data.z, data.q, data.sx, data.sy, data.sz, data.armorId)
			end
		end
    end
end)

addEvent("requestPlayerWeaponClothesAll", true)
addEventHandler("requestPlayerWeaponClothesAll", getRootElement(), function(sync, server)
	local playerItems = exports.sItems:getElementItems(source)

	if playerItems then
		for k, v in pairs(playerItems) do
			if exports.sWeapons:getWeaponId(v.itemId) then
				if not storedWeaponPositions[source] or not storedWeaponPositions[source][tonumber(v.itemId)] then
					if not storedWeaponPositions[source] then
						storedWeaponPositions[source] = {}
					end

					storedWeaponPositions[source][v.itemId] = {boneId = -1}
				end
			end
		end
	end

	if storedWeaponPositions[source] then
		for k, v in pairs(storedWeaponPositions[source]) do
			if v and v.hidden then
				triggerLatentClientEvent(client, "gotPlayerWeaponCloth", source, k)
			else
				triggerLatentClientEvent(client, "gotPlayerWeaponCloth", source, k, v.boneId, v.x, v.y, v.z, v.objQ)
			end
		end
	end
end)

addEvent("finalBuyClothesShop", true)
addEventHandler("finalBuyClothesShop", getRootElement(), function(model)
    local charID = tonumber(getElementData(source, "char.ID"))

    if charID then
		local priceType = "money"
		local price = 0
		local purchaseFailed = false

		if clothesList[model].ppPrice then
			priceType = "pp"
			price = clothesList[model].ppPrice
		elseif clothesList[model].price then
			price = clothesList[model].price
		else
			price = 0
		end


		if priceType == "money" then
			if (exports.sCore:getMoney(client) - price) < 0 then
				exports.sGui:showInfobox(client, "e", "Nincs elég pénzed!")
				purchaseFailed = true
			end
		elseif priceType == "pp" then
			if (exports.sCore:getPP(client) - price) < 0 then
				exports.sGui:showInfobox(client, "e", "Nincs elég prémiumpontod!")
				purchaseFailed = true
			end
		end

		if purchaseFailed then
			triggerLatentClientEvent(client, "gotNewBoughtCloth", client, model, (storedBoughtClothes[client] and (storedBoughtClothes[client][model] or 0)) or 0)
			return
		end

        dbQuery(function(qh, source, client, charID, priceType, price)
            local result = dbPoll(qh, 0)
			
			if result[1] then
				local clothes = fromJSON(result[1].boughtClothes) or {}
				
				clothes[model] = (clothes[model] or 0) + 1

				if dbExec(connection, "UPDATE characters SET boughtClothes = ? WHERE characterId = ?", toJSON(clothes), charID) then
					if priceType == "pp" then
						exports.sCore:takePP(client, price)
					elseif priceType == "money" then
						exports.sCore:takeMoney(client, price)
					end
					triggerLatentClientEvent(client, "gotNewBoughtCloth", client, model, clothes[model])
                    exports.sGui:showInfobox(client, "s", "Sikeres vásárlás: " .. clothesList[model].name)
					storedBoughtClothes[client][model] = clothes[model]
					
					if clothesList[model].cat == "armor" then
						local armors = fromJSON(result[1].armors) or {}

						dbExec(connection, "INSERT INTO armors (characterId, model) VALUES (?,?)", charID, model)

						dbQuery(function(qh, player)
							local result = dbPoll(qh, 0)

							if #result > 0 then
								table.insert(armors, result[1].armorId)
								dbExec(connection, "UPDATE characters SET armors = ? WHERE characterId = ?", toJSON(armors, true), charID)
								loadPlayerArmors(player, true)
							end
						end, {client}, connection, "SELECT * FROM armors WHERE armorId = LAST_INSERT_ID()")
					end
				end
			end
        end, {source, client, charID, priceType, price}, connection, "SELECT boughtClothes, armors FROM characters WHERE characterId = ?", charID)
    end
end)

local armorModels = {
	[1] = "v4_armor1",
	[2] = "v4_armor2",
	[3] = "v4_armor3",
	[4] = "v4_armor4",
	[5] = "armor_pd",
}


addCommandHandler("setarmor", function(sourcePlayer, commandName, targetPlayer, value)
	if exports.sPermission:hasPermission(sourcePlayer, "sethp") then

		local value = tonumber(value)

		if not targetPlayer and (not value or value < 0) then
            outputChatBox("[color=sightblue][Használat]: #ffffff/" .. commandName .. " [Játékos Név / ID] [Armor type (1-5) (5 PD többi civil)]", sourcePlayer)
			return
        else
            targetPlayer, targetName = exports.sCore:findPlayer(sourcePlayer, targetPlayer)
		end

		local model = armorModels[value]

		local charID = tonumber(getElementData(targetPlayer, "char.ID"))

		dbQuery(function(qh, source, client, charID, priceType, price)
            local result = dbPoll(qh, 0)
			
			if result[1] then
				local clothes = fromJSON(result[1].boughtClothes) or {}
				
				clothes[model] = (clothes[model] or 0) + 1

				if dbExec(connection, "UPDATE characters SET boughtClothes = ? WHERE characterId = ?", toJSON(clothes), charID) then
					triggerLatentClientEvent(client, "gotNewBoughtCloth", client, model, clothes[model])
					storedBoughtClothes[client][model] = clothes[model]
					
					if clothesList[model].cat == "armor" then
						local armors = fromJSON(result[1].armors) or {}

						dbExec(connection, "INSERT INTO armors (characterId, model) VALUES (?,?)", charID, model)
						exports.sGui:showInfobox(source, "s", value .. " típusú armor sikeresen odaadva!")

						exports.sGui:showInfobox(client, "i", "Kaptál egy " .. value .. " típusú armort!")
						dbQuery(function(qh, player)
							local result = dbPoll(qh, 0)

							if #result > 0 then
								table.insert(armors, result[1].armorId)
								dbExec(connection, "UPDATE characters SET armors = ? WHERE characterId = ?", toJSON(armors, true), charID)
								loadPlayerArmors(player, true)
							end
						end, {client}, connection, "SELECT * FROM armors WHERE armorId = LAST_INSERT_ID()")
					end
				end
			end
        end, {sourcePlayer, targetPlayer, charID, priceType, price}, connection, "SELECT boughtClothes, armors FROM characters WHERE characterId = ?", charID)
	end
end)

addEvent("refreshPlayerCloth", true)
addEventHandler("refreshPlayerCloth", getRootElement(), function(editingSlot, editingModel, boneId, x, y, z, objQ, scaleX, scaleY, scaleZ, selectedArmorId)
	local charID = tonumber(getElementData(client, "char.ID"))

	if charID and storedCurrentClothes[client] then
		if selectedArmorId and loadedArmors[client] and loadedArmors[client][selectedArmorId] then
			local maxArmor = clothesList[editingModel].armorStrength * 25
			triggerLatentClientEvent(client, "gotMaxArmorValue", client, maxArmor)

			setPedArmor(client, maxArmor * (loadedArmors[client][selectedArmorId][2] / 100))
		end
		
		if editingSlot and editingModel then
			storedCurrentClothes[client][editingSlot] = {
				model = editingModel,
				bone = boneId,
				x = x,
				y = y,
				z = z,
				q = objQ,
				sx = scaleX,
				sy = scaleY,
				sz = scaleZ,
				armorId = selectedArmorId,
				slot = editingSlot
			}
		else
			if storedCurrentClothes[client] and storedCurrentClothes[client][editingSlot].armorId then
				setPedArmor(client, 0)
			end

			storedCurrentClothes[client][editingSlot] = nil
		end

		dbExec(connection, "UPDATE characters SET clothesPos = ? WHERE characterId = ?", toJSON(storedCurrentClothes[client]), charID)

		triggerLatentClientEvent(getRootElement(), "refreshPlayerCloth", client, editingSlot, true)
	end
end)

addEvent("buyClothesShopSlot", true)
addEventHandler("buyClothesShopSlot", getRootElement(), function()
	local charID = tonumber(getElementData(client, "char.ID"))

	if charID then
		dbQuery(function(qh, client, charID)
			local result = dbPoll(qh, 0)

			if result[1] then
				local data = result[1]
				local slotPrice = getSlotPrice(data.clothesLimit + 1)

				if (exports.sCore:getPP(client) - slotPrice) > 0 then
					if dbExec(connection, "UPDATE characters SET clothesLimit = clothesLimit + 1 WHERE characterId = ?", charID) then
						triggerLatentClientEvent(client, "gotNewClothesshopSlots", client, data.clothesLimit + 1)
						exports.sCore:takePP(client, slotPrice)
						exports.sGui:showInfobox(client, "s", "Sikeres vásárlás!")
					end
				else
					triggerLatentClientEvent(client, "gotNewClothesshopSlots", client, data.clothesLimit)
					exports.sGui:showInfobox(client, "e", "Nincs elég prémiumpontod!")
				end
			end
		end, {client, charID}, connection, "SELECT clothesLimit FROM characters WHERE characterId = ?", charID)
	end
end)

addEventHandler("onPlayerQuit", getRootElement(), function()
	storedBoughtClothes[source] = nil
	storedCurrentClothes[source] = nil
	loadedArmors[source] = nil
	storedWeaponPositions[source] = nil
end)

addEventHandler("onElementDataChange", getRootElement(), function(dataName, oldValue, newValue)
	if dataName == "loggedIn" and newValue then
		storePlayerClothes(source)
	end
end)



addEvent("requestPlayerSingleCloth", true)
addEventHandler("requestPlayerSingleCloth", getRootElement(), function(slot)
	if storedCurrentClothes[source] then
		local value = storedCurrentClothes[source][slot]

		if value then
			triggerLatentClientEvent(client, "gotPlayerCloth", source, slot, value.model, value.bone, value.x, value.y, value.z, value.q, value.sx, value.sy, value.sz, value.armorId)
		else
			triggerLatentClientEvent(client, "gotPlayerCloth", source, slot)
		end
	end
end)

addEvent("finalDeleteClothesArmor", true)
addEventHandler("finalDeleteClothesArmor", getRootElement(), function(armorId)
	local charID = tonumber(getElementData(client, "char.ID"))

	if charID then
		if loadedArmors[client][armorId] then
			local model = loadedArmors[client][armorId][1]
			local armorDbID = loadedArmors[client][armorId][3]
			
			storedBoughtClothes[client][model] = storedBoughtClothes[client][model] - 1

			if storedBoughtClothes[client][model] <= 0 then
				storedBoughtClothes[client][model] = nil
			end

			dbExec(connection, "UPDATE characters SET boughtClothes = ? WHERE characterId = ?", toJSON(storedBoughtClothes[client]), charID)

			dbExec(connection, "DELETE FROM armors WHERE armorId = ?", armorDbID)

			dbQuery(function(qh, armorId, charID)
				local results = dbPoll(qh, 0)

				if #results > 0 then
					local result = results[1]

					for i = 1, #result.armors do
						if result.armors[i] == armorId then
							table.remove(result.armors, i)

							dbExec(connection, "UPDATE characters SET armors = ? WHERE characterId = ?", result.armors, charID)

							break
						end
					end
				end
			end, {armorId, charID}, connection, "SELECT armors FROM characters WHERE characterId = ?", charID)
		end
	end
end)

addEvent("getLoginPreviewClothes", true)
addEventHandler("getLoginPreviewClothes", getRootElement(), function(charIds)
	for i = 1, #charIds do
		local clothes = {}

		local charID = charIds[i]

		local qh = dbQuery(connection, "SELECT clothesPos FROM characters WHERE characterId = ?", charID)
		local result = dbPoll(qh, -1)

		if result[1] then
			local clothesEx = fromJSON(result[1].clothesPos)
			if clothesEx then
				for i = 1, #clothesEx do
					table.insert(clothes, {
						clothesEx[i].model,
						clothesEx[i].bone,
						clothesEx[i].x,
						clothesEx[i].y,
						clothesEx[i].z,
						clothesEx[i].q,
						clothesEx[i].sx,
						clothesEx[i].sy,
						clothesEx[i].sz
					})
				end
			end
		end

		triggerLatentClientEvent(client, "gotLoginPreviewClothes", client, charID, {clothes = clothes, weapons = {}})
	end
end)

local armorData = {}

function loadPlayerArmors(player, send, updateArmor)
	local charID = tonumber(getElementData(player, "char.ID"))

	if charID then
		dbQuery(function(qh, player, send)
			local results = dbPoll(qh, 0)

			if results then
				loadedArmors[player] = {}
				
				for i = 1, #results do
					local result = results[i]

					table.insert(loadedArmors[player], {result.model, result.health, result.armorId})
				end

				if send then
					triggerLatentClientEvent(player, "gotLoadedArmor", player, loadedArmors[player])
				end
				
				if updateArmor then
					if storedCurrentClothes[player][-1] then
						local model = storedCurrentClothes[player][-1].model
						local selectedArmorId = storedCurrentClothes[player][-1].armorId
						local maxArmor = clothesList[model].armorStrength * 25
			
						armorData[player] = maxArmor or 0
						setPedArmor(player, maxArmor * (loadedArmors[player][selectedArmorId][2] / 100))
						triggerLatentClientEvent(player, "gotMaxArmorValue", player, maxArmor)
					end
				end
			end
		end, {player, send}, connection, "SELECT * FROM armors WHERE characterId = ?", charID)
	end
end

function hudRestart(res)
	local resname = getResourceName(res)
	if resname == "sHud" then
		for k, v in pairs(getElementsByType("player")) do
			if armorData[v] then
				triggerLatentClientEvent(v, "gotMaxArmorValue", v, armorData[v])
			end
		end
	end

end
addEventHandler("onResourceStart", root, hudRestart)

function getMaxArmor(playerElement)
	if not armorData[playerElement] then
		returnValue = 100
	else
		returnValue = armorData[playerElement]
	end
	return returnValue
end

addEvent("updateActiveArmorHealth", true)
addEventHandler("updateActiveArmorHealth", getRootElement(), function(armorHealth)
	local activeArmor = storedCurrentClothes[source][-1]

	if activeArmor then
		local model = activeArmor.model
		local maxArmor = clothesList[model].armorStrength * 25
		local newArmorHealth = (armorHealth / maxArmor) * 100

		triggerLatentClientEvent(source, "gotArmorDamage", source, activeArmor.armorId, newArmorHealth)

		dbExec(connection, "UPDATE armors SET health = ? WHERE armorId = ?", newArmorHealth, loadedArmors[source][activeArmor.armorId][3])
	end
end)

addEvent("refreshPlayerWeaponHidden", true)
addEventHandler("refreshPlayerWeaponHidden", getRootElement(), function(item)
	if client == source then
		if not storedWeaponPositions[client][item] then
			storedWeaponPositions[client][item] = {boneId = 0, x = 0, y = 0, z = 0, objQ = {0, 0, 0, 0}}
		end
		storedWeaponPositions[client][item].hidden = not storedWeaponPositions[client][item].hidden

		if storedWeaponPositions[client][item].hidden then
			triggerLatentClientEvent(getRootElement(), "gotPlayerWeaponCloth", client, item)
			exports.sChat:localAction(client, "elrejt egy fegyvert. (" .. exports.sItems:getItemName(item) .. ")")
		else
			local w = storedWeaponPositions[client][item]
			triggerLatentClientEvent(getRootElement(), "gotPlayerWeaponCloth", client, item, w.boneId, w.x, w.y, w.z, w.objQ)
		end
		local charID = tonumber(getElementData(client, "char.ID"))
		dbExec(connection, "UPDATE characters SET weaponPos = ? WHERE characterId = ?", toJSON(storedWeaponPositions[client], true), charID)
	else
        exports.sAnticheat:anticheatBan(client, "AC #63 - sClothesshop @sourceS:521")
	end
end)

addEvent("refreshPlayerWeapon", true)
addEventHandler("refreshPlayerWeapon", getRootElement(), function(item, boneId, x, y, z, objQ)
	if client == source then
		local charID = tonumber(getElementData(client, "char.ID"))

		if not storedWeaponPositions[client][item] then
			storedWeaponPositions[client][item] = {}
		end

		if charID and storedWeaponPositions[client] and storedWeaponPositions[client][item] then
			storedWeaponPositions[client][item].boneId = boneId
			storedWeaponPositions[client][item].x = x
			storedWeaponPositions[client][item].y = y
			storedWeaponPositions[client][item].z = z
			storedWeaponPositions[client][item].objQ = objQ

			dbExec(connection, "UPDATE characters SET weaponPos = ? WHERE characterId = ?", toJSON(storedWeaponPositions[client], true), charID)
			
			triggerLatentClientEvent(getRootElement(), "refreshPlayerClothWeapon", source, item, true)
		end
	else
        exports.sAnticheat:anticheatBan(client, "AC #64 - sClothesshop @sourceS:546")
	end
end)

addEvent("requestPlayerWeaponCloth", true)
addEventHandler("requestPlayerWeaponCloth", getRootElement(), function(item)
	if storedWeaponPositions[source] then
		local w = storedWeaponPositions[source][item]
		if w then
			if w.hidden then
				triggerLatentClientEvent(getRootElement(), "gotPlayerWeaponCloth", source, item)
			else
				triggerLatentClientEvent(getRootElement(), "gotPlayerWeaponCloth", source, item, w.boneId, w.x, w.y, w.z, w.objQ)
			end
		else
			triggerLatentClientEvent(getRootElement(), "gotPlayerWeaponCloth", source, item)
		end
	end
end)

function processPlayerWeaponItems(items, player, vanish, fromVanish)
	local source = source or player
	local weaponItems = {}
	
	for k, v in pairs(items) do
		if exports.sWeapons:getWeaponId(v.itemId) then
			weaponItems[v.itemId] = true

			if storedWeaponPositions[source] then
				local w = storedWeaponPositions[source][v.itemId]
				if not storedWeapons[source][v.itemId] then
					if w then
						if w and w.hidden or vanish then
							triggerLatentClientEvent(getRootElement(), "gotPlayerWeaponCloth", source, v.itemId)
						else
							if w and w.hidden or vanish then
								triggerLatentClientEvent(getRootElement(), "gotPlayerWeaponCloth", source, v.itemId)
							else
								triggerLatentClientEvent(getRootElement(), "gotPlayerWeaponCloth", source, v.itemId, w.boneId, w.x, w.y, w.z, w.objQ)
							end
						end
					else
						if w and w.hidden or vanish then
							triggerLatentClientEvent(getRootElement(), "gotPlayerWeaponCloth", source, v.itemId)
						else
							triggerLatentClientEvent(getRootElement(), "gotPlayerWeaponCloth", source, v.itemId, -1)
						end
					end

					storedWeapons[source][v.itemId] = true
				end
			end
		end
	end

	if vanish then
		for k, v in pairs(items) do
			if exports.sWeapons:getWeaponId(v.itemId) then
				triggerLatentClientEvent(getRootElement(), "gotPlayerWeaponCloth", source, v.itemId)
			end
		end
	end

	if storedWeapons[source] then
		for k in pairs(storedWeapons[source]) do
			if not weaponItems[k] then
				triggerLatentClientEvent(getRootElement(), "gotPlayerWeaponCloth", source, k)
				storedWeapons[source][k] = false
			end
		end
	end
end

addEvent("processPlayerWeaponItems", true)
addEventHandler("processPlayerWeaponItems", getRootElement(), function(items)
	processPlayerWeaponItems(items)
end)