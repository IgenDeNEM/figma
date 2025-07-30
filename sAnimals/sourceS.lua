local connection = false
local loadedAnimals = {}
local spawnedAnimals = {}
local petSkinTypes = availablePets
local animalDoAction = {}

local connection = exports.sConnection:getConnection()

addEventHandler("onResourceStart", getResourceRootElement(),
	function ()
		dbQuery(loadAllAnimals, connection, "SELECT * FROM animals")
	end
)

addEventHandler("onResourceStop", getResourceRootElement(),
	function ()
		for k, v in pairs(spawnedAnimals) do
			if isElement(spawnedAnimals[k]) then
				saveAnimal(spawnedAnimals[k])
			end
		end
	end)

function loadAllAnimals(qh)
	local result = dbPoll(qh, 0)

	if result then
		for k, v in pairs(result) do
			loadedAnimals[v.animalId] = v
		end
	end
end

function loadNewAnimal(qh)
	local result, rows, animalId = dbPoll(qh, 0)

	if tonumber(animalId) then
		dbQuery(
			function (qh)
				local result = dbPoll(qh, 0)

				if result then
					loadedAnimals[result[1].animalId] = result[1]
					
				end
			end,
		connection, "SELECT * FROM animals WHERE animalId = ?", animalId)
	end

	dbFree(qh)
end

function saveAnimal(animalElement)
	local animalId = getElementData(animalElement, "animal.animalId")
	if animalId then
		loadedAnimals[animalId].health = getElementHealth(animalElement)
		loadedAnimals[animalId].hunger = getElementData(animalElement, "animal.hunger") or 100
		loadedAnimals[animalId].love = getElementData(animalElement, "animal.love") or 100
		loadedAnimals[animalId].name = getElementData(animalElement, "visibleName")

		dbExec(connection, "UPDATE animals SET health = ?, hunger = ?, love = ?, name = ? WHERE animalId = ?", loadedAnimals[animalId].health, loadedAnimals[animalId].hunger, loadedAnimals[animalId].love, loadedAnimals[animalId].name, animalId)
	end
end

addCommandHandler("nearbypets", function(sourcePlayer, sourceCommand)
	if sourcePlayer and exports.sPermission:hasPermission(sourcePlayer, "nearbypets") then
		outputChatBox("[color=sightgreen][SightMTA - Pet]: [color=hudwhite]Közelben lévő állatok:", sourcePlayer)
		for animalId, animalElement in pairs(spawnedAnimals) do
			local animalId = getElementData(animalElement, "animal.animalId")
			
			local animalPosition = {getElementPosition(animalElement)}
			local sourcePosition = {getElementPosition(sourcePlayer)}

			local distance = getDistanceBetweenPoints3D(animalPosition[1], animalPosition[2], animalPosition[3], sourcePosition[1], sourcePosition[2], sourcePosition[3])

			if distance <= 10 then
				outputChatBox("[color=sightgreen]	> [color=hudwhite]["..animalId.."] "..getElementData(animalElement, "visibleName").." ("..math.floor(distance).."m)", sourcePlayer)
			end
		end
	end
end)

addCommandHandler("renamepet", function(sourcePlayer, sourceCommand, targetAnimal, ...)
	if sourcePlayer and exports.sPermission:hasPermission(sourcePlayer, "renamepet") then
		local newAnimalName = table.concat({...}, " ")

		if not targetAnimal or (not newAnimalName or newAnimalName == "") then
			outputChatBox("[color=sightred][SightMTA - Hiba]: [color=hudwhite]/"..sourceCommand.." [Pet ID] [Név]")
			return
		end

		local foundAnimal = false
		local foundId = false
		local targetAnimal = tonumber(targetAnimal)

		for _, animalElement in pairs(spawnedAnimals) do
			local animalId = getElementData(animalElement, "animal.animalId")
			if animalId == targetAnimal then
				foundAnimal = animalElement
				foundId = animalId
				break
			end
		end

		if foundId and foundAnimal and isElement(foundAnimal) and getElementType(foundAnimal) == "ped" then
			loadedAnimals[foundId].name = newAnimalName
			setElementData(foundAnimal, "visibleName", newAnimalName)
		else
			outputChatBox("[color=sightred][SightMTA - Pet]: [color=hudwhite]Nem található állat!", sourcePlayer)
		end
	end
end)

addEventHandler("onElementDataChange", getRootElement(),
	function (data)
		if getElementType(source) == "ped" then
			local animalId = getElementData(source, "animal.animalId")
			if animalId then
				if loadedAnimals[animalId] then
					if data == "animal.hunger" or data == "animal.love" or data == "animal.ownerId" then
						loadedAnimals[animalId][data] = getElementData(source, data)
					end
				end
			end
		end
	end)


function findAnimalOwner(animalIdentity)
	for _, playerElement in pairs(getElementsByType("player")) do
		if getElementData(playerElement, "char.ID") == loadedAnimals[animalIdentity].ownerId then
			return playerElement
		end
	end
	return false
end

function findPlayerAnimals(playerElement)
	local playerAnimals = {}
	local animalCount = 1
	for animalIndex, animalData in pairs(loadedAnimals) do
		if animalData.ownerId and animalData.ownerId == getElementData(playerElement, "char.ID") then
			playerAnimals[animalCount] = animalData
			animalCount = animalCount + 1
		end
	end
	return playerAnimals
end

addEventHandler("onPedWasted", getResourceRootElement(),
	function ()
		local animalId = getElementData(source, "animal.animalId")
		if animalId then
			loadedAnimals[animalId].health = 0
			setElementHealth(spawnedAnimals[animalId], 0)
			local animalOwner = findAnimalOwner(animalId)
			local animalDatas = findPlayerAnimals(animalOwner)
			setTimer(function(animalOwner, animalDatas)
				triggerClientEvent(animalOwner, "recieveAnimals", animalOwner, animalDatas)
			end, 1000, 1, animalOwner, animalDatas)
		end
	end
)


addEventHandler("onPedDamage", root, function(healthLoss)
	local animalId = getElementData(source, "animal.animalId")
	if animalId then
		setElementHealth(spawnedAnimals[animalId], loadedAnimals[animalId].health - healthLoss)
		loadedAnimals[animalId].health = loadedAnimals[animalId].health - healthLoss
		local animalOwner = findAnimalOwner(animalId)
		local animalDatas = findPlayerAnimals(animalOwner)
		setTimer(function(animalOwner, animalDatas)
			triggerClientEvent(animalOwner, "recieveAnimals", animalOwner, animalDatas)
		end, 1000, 1, animalOwner, animalDatas)
	end
end)


local animalsToBuy = {
  {"Husky", 9000},
  {"Rottweiler", 6000},
  {"Doberman", 8000},
  {
    "Bull Terrier",
    9000
  },
  {"Boxer", 7000},
  {
    "Francia Bulldog",
    10000
  }
}

addEvent("tryToBuyPet", true)
addEventHandler("tryToBuyPet", getRootElement(),
	function (selectedAnimalToBuy, name)
		local buyPrice = animalsToBuy[selectedAnimalToBuy][2]
		local petType = selectedAnimalToBuy
		local petName = name

		if petName and petType then
			local characterId = tonumber(getElementData(source, "char.ID"))
			local accountId = tonumber(getElementData(source, "char.accID"))
			local sourcePlayer = source

			if characterId and accountId then
				dbQuery(
					function (qh, thePlayer)
						if isElement(thePlayer) then
							local result = dbPoll(qh, 0)

							if result then
								local row = result[1]
								local newPP = (exports.sCore:getPP(thePlayer)) - buyPrice

								if newPP < 0 then
									triggerClientEvent(thePlayer, "showInfobox", thePlayer, "e", "Nincs elég prémium pontod a kutya megvásárlásához!")
								else
									exports.sCore:setPP(thePlayer, newPP)

									dbExec(connection, "UPDATE accounts SET premiumPoints = ? WHERE accountId = ?", newPP, accountId)
									dbQuery(loadNewAnimal, connection, "INSERT INTO animals (ownerId, type, name) VALUES (?,?,?)", characterId, petType, petName)

									setTimer(function()
										triggerEvent("requestAnimals", thePlayer)
									end, 1000, 1)
									

									triggerClientEvent(thePlayer, "showInfobox", thePlayer, "s", "Sikeres vásárlás!")
								end
							end
						end
					end,
				{source}, connection, "SELECT premiumPoints FROM accounts WHERE accountId = ? LIMIT 1", accountId)
			end
		end
	end
)

local sellingDatas = {}

addEvent("animalSellResponse", true)
function animalSellResponse(bought)
    local data = sellingDatas[client]
    local from = data[4]
    local animalId = data[1]
    local price = data[3]
    local money = exports.sCore:getMoney(client)
    local money2 = exports.sCore:getMoney(from)
    if money >= price then
        triggerClientEvent(client, "showInfobox", client, "success", "Sikeresen megvásároltad a háziállatot!", 4000)
		exports.sGui:showInfobox(from, "s", "Sikeresen eladtad a háziállatodat "..getElementData(client, "char.name"):gsub("_", " ").."-nak "..price.." $-ért")
        exports.sCore:setMoney(client, money - price)
        exports.sCore:setMoney(from, money2 + price)
    else
        triggerClientEvent(client, "showInfobox", client, "error", "Nincs elég pénzed!", 4000)
        return
    end
    if bought then
        loadedAnimals[animalId].ownerId = getElementData(client, "char.ID")

        local characterId = getElementData(client, "char.ID")

		if isElement(client) and characterId then
			local animals = {}

			for k, v in pairs(loadedAnimals) do
				if v.ownerId == characterId then
					table.insert(animals, v)
				end
			end

			triggerClientEvent(client, "recieveAnimals", client, animals)
		end

		dbExec(connection, "UPDATE animals SET ownerId = ? WHERE animalId = ?", characterId, animalId)

        local characterId = getElementData(from, "char.ID")

		if isElement(from) and characterId then
			local animals = {}

			for k, v in pairs(loadedAnimals) do
				if v.ownerId == characterId then
					table.insert(animals, v)
				end
			end

			triggerClientEvent(from, "recieveAnimals", from, animals)
		end
    else
        triggerClientEvent(client, "endAnimalSell", client)
    end
end
addEventHandler("animalSellResponse", root, animalSellResponse)

addEvent("tryToSellPet", true)
addEventHandler("tryToSellPet", getRootElement(),
	function (animalId, target, price)
		if animalId then
            exports.sGui:showInfobox(client, "i", "Sikeresen eladásra kináltad az állatodat! ("..loadedAnimals[animalId].name..") a következő játékosnak: "..getElementData(target, "char.name"):gsub("_", " "))
			exports.sGui:showInfobox(target, "i", getElementData(client, "char.name"):gsub("_", " ").. " eladásra kínált egy állatot neked! ("..loadedAnimals[animalId].name..")")

			triggerClientEvent(target, "startAnimalSelling", client, animalId, {health = loadedAnimals[animalId].health, hunger = loadedAnimals[animalId].hunger, love = loadedAnimals[animalId].love, type = loadedAnimals[animalId].type, name = loadedAnimals[animalId].name}, price)

			sellingDatas[client] = {animalId, {health = loadedAnimals[animalId].health, hunger = loadedAnimals[animalId].hunger, love = loadedAnimals[animalId].love, type = loadedAnimals[animalId].type, name = loadedAnimals[animalId].name}, price, client, target}
			sellingDatas[target] = {animalId, {health = loadedAnimals[animalId].health, hunger = loadedAnimals[animalId].hunger, love = loadedAnimals[animalId].love, type = loadedAnimals[animalId].type, name = loadedAnimals[animalId].name}, price, client, target}
        end
    end
)

addEvent("buyAnimalRevive", true)
addEventHandler("buyAnimalRevive", getRootElement(),
	function (animalId)
		if animalId then
			local characterId = tonumber(getElementData(source, "char.ID"))
			local accountId = tonumber(getElementData(source, "char.accID"))

			if characterId and accountId then
				dbQuery(
					function (qh, thePlayer)
						if isElement(thePlayer) then
							local result = dbPoll(qh, 0)

							if result then
								local row = result[1]
								local newPP = row.premiumPoints - 100

								if newPP < 0 then
									triggerClientEvent(thePlayer, "showInfobox", thePlayer, "e", "Nincs elég prémium pontod a kutya felélesztéséhez!")
									triggerClientEvent(thePlayer, "buyPetReviveNoPP", thePlayer)
								else
									exports.sCore:setPP(thePlayer, newPP)

									if loadedAnimals[animalId] then
										loadedAnimals[animalId].health = 100
										loadedAnimals[animalId].hunger = 100
										loadedAnimals[animalId].love = 100

										if isElement(spawnedAnimals[animalId]) then
											setElementData(spawnedAnimals[animalId], "animal.health", 100)
											setElementData(spawnedAnimals[animalId], "animal.hunger", 100)
											setElementData(spawnedAnimals[animalId], "animal.love", 100)
										end
									end

									dbExec(connection, "UPDATE accounts SET premiumPoints = ? WHERE accountId = ?", newPP, accountId)
									dbExec(connection, "UPDATE animals SET health = 100, hunger = 100, love = 100 WHERE animalId = ?", animalId)

									if isElement(spawnedAnimals[animalId]) then
										destroyElement(spawnedAnimals[animalId])
									end
									spawnedAnimals[animalId] = nil

									if isElement(thePlayer) and characterId then
										local animals = {}
							
										for k, v in pairs(loadedAnimals) do
											if v.ownerId == characterId then
												table.insert(animals, v)
											end
										end
							
										triggerClientEvent(thePlayer, "recieveAnimals", thePlayer, animals)
									end

									triggerClientEvent(thePlayer, "showInfobox", thePlayer, "s", "Sikeresen felélesztetted a kutyád!")
								end
							end
						end
					end,
				{source}, connection, "SELECT premiumPoints FROM accounts WHERE accountId = ? LIMIT 1", accountId)
			end
		end
	end)

addEvent("requestAnimals", true)
addEventHandler("requestAnimals", getRootElement(),
	function (characterId)
		local characterId = getElementData(source, "char.ID")

		if isElement(source) and characterId then
			local animals = {}

			for k, v in pairs(loadedAnimals) do
				if v.ownerId == characterId then
					table.insert(animals, v)
				end
			end

			triggerClientEvent(source, "recieveAnimals", source, animals)
		end
	end)

function getPlayerAnimals(characterId)
	local tempTable = {}

	for k, v in pairs(loadedAnimals) do
		if v.ownerId == characterId then
			table.insert(tempTable, v)
		end
	end

	return tempTable
end

addEvent("renamePet", true)
addEventHandler("renamePet", getRootElement(),
	function (animalId, newName)
		if animalId and newName then
			if loadedAnimals[animalId] then
				local items = exports.sItems:getElementItems(source)
				local item = false

				for k, v in pairs(items) do
					if v.itemId == 423 then
						item = v
						break
					end
				end

				if item then
					exports.sItems:takeItem(source, "dbID", item.dbID)

					loadedAnimals[animalId].name = newName
					dbExec(connection, "UPDATE animals SET name = ? WHERE animalId = ?", newName, animalId)

					if isElement(spawnedAnimals[animalId]) then
						setElementData(spawnedAnimals[animalId], "visibleName", loadedAnimals[animalId].name)
					end

					triggerClientEvent(source, "showInfobox", source, "s", "Sikeresen átnevezted a petet!")

					local characterId = getElementData(source, "char.ID")

					if isElement(source) and characterId then
						local animals = {}
			
						for k, v in pairs(loadedAnimals) do
							if v.ownerId == characterId then
								table.insert(animals, v)
							end
						end
			
						triggerClientEvent(source, "recieveAnimals", source, animals)
					end
				else
					triggerClientEvent(source, "showInfobox", source, "e", "Nincs kutyaátnevező kártyád.")
				end
			end
		end
	end)

addEventHandler("onPlayerQuit", getRootElement(),
	function ()
		local characterId = getElementData(source, "char.ID")
		if characterId then
			local animalElement = getElementByID("animal_" .. characterId)
			if isElement(animalElement) then
				local animalId = getElementData(animalElement, "animal.animalId")
				if animalId then
					if spawnedAnimals[animalId] then
						if isElement(spawnedAnimals[animalId]) then
							saveAnimal(spawnedAnimals[animalId])
							destroyElement(spawnedAnimals[animalId])
						end
						spawnedAnimals[animalId] = nil
					end
				end
			end
		end
	end
)

addEvent("spawnAnimal", true)
addEventHandler("spawnAnimal", getRootElement(),
	function (animalId)
		if animalId then
			if loadedAnimals[animalId] then
				if not spawnedAnimals[animalId] then
					if loadedAnimals[animalId].health > 0 then
						local playerPosX, playerPosY, playerPosZ = getElementPosition(source)
						local playerRotX, playerRotY, playerRotZ = getElementRotation(source)

						playerPosX = playerPosX + math.cos(math.rad(playerRotZ)) * 1
						playerPosY = playerPosY + math.sin(math.rad(playerRotZ)) * 1

						spawnedAnimals[animalId] = createPed(petSkinTypes[loadedAnimals[animalId].type], playerPosX, playerPosY, playerPosZ, playerRotZ)

						if isElement(spawnedAnimals[animalId]) then
							setElementInterior(spawnedAnimals[animalId], getElementInterior(source))
							setElementDimension(spawnedAnimals[animalId], getElementDimension(source))

							setElementID(spawnedAnimals[animalId], "animal_" .. loadedAnimals[animalId].ownerId)
							setElementData(spawnedAnimals[animalId], "animal.animalId", animalId)
							setElementData(spawnedAnimals[animalId], "animal.ownerId", loadedAnimals[animalId].ownerId)

							setElementData(spawnedAnimals[animalId], "animal.hunger", loadedAnimals[animalId].hunger)
							setElementData(spawnedAnimals[animalId], "animal.love", loadedAnimals[animalId].love)

							if loadedAnimals[animalId].hunger <= 0 then
								setElementHealth(spawnedAnimals[animalId], 0)
							else
								setElementHealth(spawnedAnimals[animalId], loadedAnimals[animalId].health)
							end

							if loadedAnimals[animalId].love <= 0 then
								setElementData(spawnedAnimals[animalId], "animal.obedient", false)
							else
								setElementData(spawnedAnimals[animalId], "animal.obedient", true)
							end

							setElementData(spawnedAnimals[animalId], "visibleName", loadedAnimals[animalId].name)
							setElementData(spawnedAnimals[animalId], "pedNameType", loadedAnimals[animalId].type)
							setElementData(spawnedAnimals[animalId], "ped.isControllable", true)
						end
					else
						triggerClientEvent(source, "showInfobox", source, "e", "Halott kutyát nem tudsz lespawnolni!")
					end
				end
			end
		end
	end)

addEvent("destroyAnimal", true)
addEventHandler("destroyAnimal", getRootElement(),
	function (animalId)
		if animalId then
			if loadedAnimals[animalId] then
				if isElement(spawnedAnimals[animalId]) then
					saveAnimal(spawnedAnimals[animalId])
					destroyElement(spawnedAnimals[animalId])
				end

				spawnedAnimals[animalId] = nil
			end
		end
	end)

addEvent("animalStarvedToDeath", true)
addEventHandler("animalStarvedToDeath", getRootElement(),
	function (animalElement, animalId)
		if animalElement and animalId then
			if loadedAnimals[animalId] then
				loadedAnimals[animalId].health = 0
				setElementHealth(animalElement, 0)
			end
		end
	end)

addEvent("feedAnimal", true)
addEventHandler("feedAnimal", getRootElement(),
	function (animalElement, itemId)
		if animalElement and itemId then
			local animalId = getElementData(animalElement, "animal.animalId")
			local foodItem = exports.sItems:hasItem(source, itemId)

			if itemId == 163 then
				if not foodItem then
					outputChatBox("#d75959[SightMTA - Pet]: #ffffffNincs nálad PPSnack.", source, 255, 255, 255, true)
					return
				end
			elseif itemId == 162 then
				if not foodItem then
					outputChatBox("#d75959[SightMTA - Pet]: #ffffffNincs nálad Kutya snack.", source, 255, 255, 255, true)
					return
				end
			elseif itemId == 161 then
				if not foodItem then
					outputChatBox("#d75959[SightMTA - Pet]: #ffffffNincs nálad Kutya táp.", source, 255, 255, 255, true)
					return
				end
			elseif itemId == 160 then
				if not foodItem then
					outputChatBox("#d75959[SightMTA - Pet]: #ffffffNincs nálad Jutalom falat.", source, 255, 255, 255, true)
					return
				end
			end

			exports.sItems:takeItem(source, "dbID", foodItem.dbID)

			if itemId == 163 then
				setElementHealth(animalElement, 100)
				setElementData(animalElement, "animal.hunger", 100)
				setElementData(animalElement, "animal.love", 100)
				setElementData(animalElement, "animal.obedient", true)

				loadedAnimals[animalId].hunger = 100
				loadedAnimals[animalId].love = 100
			else
				local currentHunger = getElementData(animalElement, "animal.hunger") + math.random(20, 30)
				local currentLove = getElementData(animalElement, "animal.love") + math.random(1, 5)

				if currentHunger > 100 then
					currentHunger = 100
				end

				if currentLove > 100 then
					currentLove = 100
				end

				setElementData(animalElement, "animal.hunger", currentHunger)
				setElementData(animalElement, "animal.love", currentLove)

				loadedAnimals[animalId].hunger = currentHunger
				loadedAnimals[animalId].love = currentLove
			end

			if itemId == 163 then
				outputChatBox("#7cc576[SightMTA - Pet]: #ffffffAdtál a kutyának egy #7cc576PPSnack#ffffffet.", source, 255, 255, 255, true)
				outputChatBox("#7cc576[SightMTA - Pet]: #ffffffA kutya minden szükségletét feltöltötte.", source, 255, 255, 255, true)
			elseif itemId == 162 then
				outputChatBox("#7cc576[SightMTA - Pet]: #ffffffAdtál a kutyának egy #7cc576Kutya snack#ffffffet.", source, 255, 255, 255, true)
			elseif itemId == 161 then
				outputChatBox("#7cc576[SightMTA - Pet]: #ffffffAdtál a kutyának egy #7cc576Kutya táp#ffffffot.", source, 255, 255, 255, true)
			elseif itemId == 160 then
				outputChatBox("#7cc576[SightMTA - Pet]: #ffffffAdtál a kutyának egy #7cc576Jutalom falat#ffffffot.", source, 255, 255, 255, true)
			end
		end
	end)

addEvent("setAnimationForAnimalPet", true)
addEventHandler("setAnimationForAnimalPet", getRootElement(),
	function (animalElement, state)
		if animalElement then
			if not animalDoAction[animalElement] then
				if state then
					animalDoAction[animalElement] = "caress"
					triggerClientEvent(getElementsByType("player"), "petSound", animalElement, "simogat")

					setElementFrozen(source, true)
					setPedAnimation(source, "BOMBER", "bom_plant_loop", -1, true, false)

					setTimer(
						function (thePlayer)
							if isElement(thePlayer) then
								setElementFrozen(thePlayer, false)
								setPedAnimation(thePlayer, false)
							end

							animalDoAction[animalElement] = nil
						end,
					1000 * 7, 1, source)
				else
					animalDoAction[animalElement] = nil
					setPedAnimation(animalElement, false)
				end
			elseif animalDoAction[animalElement] == "caress" then
				if state then
					outputChatBox("#d75959[SightMTA - Pet]: #ffffffNe buzeráld már szegény kutyát... Kikopik a szőre.", source, 255, 255, 255, true)
				end
			end
		end
	end)

addEvent("triggerBark", true)
addEventHandler("triggerBark", getRootElement(),
	function (animalElement)
		if animalElement then
			if not animalDoAction[animalElement] then
				animalDoAction[animalElement] = "bark"
				triggerClientEvent(getElementsByType("player"), "petSound", animalElement, "ugat")

				setTimer(
					function ()
						animalDoAction[animalElement] = nil
					end,
				10000, 1)

				exports.sChat:localAction(animalElement, "(kutya) ugat")
			end
		end
	end)

addEventHandler("onPlayerVehicleEnter", getRootElement(),
	function (vehicle, seat)
		local characterId = getElementData(source, "char.ID")
		if characterId then
			local animalElement = getElementByID("animal_" .. characterId)
			if isElement(animalElement) then
				local playerX, playerY, playerZ = getElementPosition(source)
				local animalX, animalY, animalZ = getElementPosition(animalElement)

				if getDistanceBetweenPoints3D(playerX, playerY, playerZ, animalX, animalY, animalZ) <= 10 then
					local playerInterior = getElementInterior(source)
					local animalInterior = getElementInterior(animalElement)

					if playerInterior == animalInterior then
						local playerDimension = getElementDimension(source)
						local animalDimension = getElementDimension(animalElement)

						if playerDimension == animalDimension then
							local currentTask = getElementData(animalElement, "ped.task.1")
							if currentTask then
								if currentTask[1] == "walkFollowElement" and currentTask[2] == source then
									for i = 1, getVehicleMaxPassengers(vehicle) do
										if not getVehicleOccupant(vehicle, i) then
											warpPedIntoVehicle(animalElement, vehicle, i)
											exports.sChat:localAction(animalElement, "(kutya) beugrik a kocsiba.")
											break
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end)

addEventHandler("onPlayerVehicleExit", getRootElement(),
	function (vehicle, seat, jacker, forcedByScript)
		if not forcedByScript then
			local characterId = getElementData(source, "char.ID")
			if characterId then
				local animalElement = getElementByID("animal_" .. characterId)
				if isElement(animalElement) then
					if isPedInVehicle(animalElement) then
						local vehiclePosX, vehiclePosY, vehiclePosZ = getElementPosition(vehicle)
						local vehicleRotX, vehicleRotY, vehicleRotZ = getElementRotation(vehicle)

						if seat == 0 or seat == 2 then
							vehiclePosX = vehiclePosX + math.cos(math.rad(vehicleRotZ)) * -2
							vehiclePosY = vehiclePosY + math.sin(math.rad(vehicleRotZ)) * -2
						else
							vehiclePosX = vehiclePosX + math.cos(math.rad(vehicleRotZ)) * 2
							vehiclePosY = vehiclePosY + math.sin(math.rad(vehicleRotZ)) * 2
						end

						removePedFromVehicle(animalElement)

						setElementPosition(animalElement, vehiclePosX, vehiclePosY, vehiclePosZ)
						setElementInterior(animalElement, getElementInterior(source))
						setElementDimension(animalElement, getElementDimension(source))

						setPedTask(animalElement, {"walkFollowElement", source, 3})

						exports.sChat:localAction(animalElement, "(kutya) kiugrik a kocsiból.")
					end
				end
			end
		end
	end)

function clearPedTasks(pedElement)
	if isElement(pedElement) then
		local thisTask = getElementData(pedElement, "ped.thisTask")
		if thisTask then

			local lastTask = getElementData(pedElement, "ped.lastTask")
			for currentTask = thisTask, lastTask do
				removeElementData(pedElement,"ped.task." .. currentTask)
			end

			removeElementData(pedElement, "ped.thisTask")
			removeElementData(pedElement, "ped.lastTask")
			return true
		end
	else
		return false
	end
end

function setPedTask(pedElement, selectedTask)
	if isElement(pedElement) then
		clearPedTasks(pedElement)
		setElementData(pedElement, "ped.task.1", selectedTask)
		setElementData(pedElement, "ped.thisTask", 1)
		setElementData(pedElement, "ped.lastTask", 1)
		return true
	else
		return false
	end
end