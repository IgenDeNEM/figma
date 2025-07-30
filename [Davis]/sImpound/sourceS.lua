local connection = false

addEventHandler("onDatabaseConnected", getRootElement(),
	function (db)
		connection = db
	end
)

addEventHandler("onResourceStart", getResourceRootElement(),
	function ()
		connection = exports.sConnection:getConnection()
	end
)

addEventHandler("onResourceStop", getResourceRootElement(),
	function ()
		for k, v in pairs(getElementsByType("vehicle")) do
			removeElementData(v, "carOnPacker")
			removeElementData(v, "packerRampState")
			removeElementData(v, "carRoped")
			removeElementData(v, "carPlacedOnTruck")
			removeElementData(v, "carAttached")
			removeElementData(v, "carAttached")
		end
	end
)

local rampTimer = {}

addEvent("packerRamp", true)
addEventHandler("packerRamp", getRootElement(),
	function (towTruck)
        if towTruck then
			if exports.sGroups:getPlayerPermission(client, "packerImpound") then
				if not isTimer(rampTimer[towTruck]) then
					local rx, ry, rz = getElementRotation(towTruck)
					setElementRotation(source, 0, 0, rz - 90, "default", true)
					setElementFrozen(source, true)
					setPedAnimation(source, "police", "CopTraf_Left", -1, true, false, false)
					setElementData(towTruck, "packerRampState", not getElementData(towTruck, "packerRampState"))
					rampTimer[towTruck] = setTimer(function (thePlayer)
						if isElement(thePlayer) then
							setPedAnimation(thePlayer, false)
							setElementFrozen(thePlayer, false)
						end
					end,
					slideAnimationTime + rotateAnimationTime, 1, source)
				end
			else
				outputChatBox("[color=sightred][SightMTA - Hiba]: [color=hudwhite]Nincs jogosultságod a packer használatához!", client)
			end
        end
	end
)

addEvent("packerConnectCar", true)
addEventHandler("packerConnectCar", getRootElement(),
	function (towTruck, car, rot)
		if towTruck then
			if exports.sGroups:getPlayerPermission(client, "packerImpound") then
				local rx, ry, rz = getElementRotation(towTruck)
				setElementData(towTruck, "carRoped", {car, rot == 180})
				setElementData(car, "carRopedTo", towTruck)
			else
				outputChatBox("[color=sightred][SightMTA - Hiba]: [color=hudwhite]Nincs jogosultságod a packer használatához!", client)
			end
        end
	end
)

addEvent("packerDisconnectCar", true)
addEventHandler("packerDisconnectCar", getRootElement(),
	function (towTruck)
		if towTruck then
			if exports.sGroups:getPlayerPermission(client, "packerImpound") then
				local ropedVehicle = getElementData(towTruck, "carRoped")
				if ropedVehicle[1] and getElementData(ropedVehicle[1], "carOnPacker") then
					outputChatBox("[color=sightred][SightMTA - Lefoglalás]: [color=hudwhite]Amíg a jármű a Packer-en van addig nem tudod lecsatolni!", client, 255, 255, 255, true)
					return
				end
				local rx, ry, rz = getElementRotation(towTruck)
				setElementData(ropedVehicle[1], "carOnPacker", false)

				setElementData(client, "carAttached", false)
				setElementData(towTruck, "cableHolder", client)
				setElementData(ropedVehicle[1], "carRopedTo", false)
				setElementData(towTruck, "carRoped", false)
			else
				outputChatBox("[color=sightred][SightMTA - Hiba]: [color=hudwhite]Nincs jogosultságod a packer használatához!", client)
			end
        end
	end
)

addEvent("packerAttachCar", true)
addEventHandler("packerAttachCar", getRootElement(),
	function (towTruck, car, offsets, zCorrection, rot)
		if towTruck then
			if exports.sGroups:getPlayerPermission(client, "packerImpound") then
				setElementFrozen(car, false)
				local rx, ry, rz = getElementRotation(towTruck)
				setElementData(car, "carOnPacker", {client, towTruck})
				setElementData(towTruck, "carAttached", {car, offsets, zCorrection, rot})
				triggerClientEvent("packerAttachAnimation", client, towTruck, car, offsets, zCorrection, rot)
			else
				outputChatBox("[color=sightred][SightMTA - Hiba]: [color=hudwhite]Nincs jogosultságod a packer használatához!", client)
			end
        end
	end
)

addEvent("packerDetachCar", true)
addEventHandler("packerDetachCar", getRootElement(),
	function (towTruck)
		if towTruck then
			if exports.sGroups:getPlayerPermission(client, "packerImpound") then
				local rx, ry, rz = getElementRotation(towTruck)
				local car, zCorr, rot = getElementData(towTruck, "carAttached")[1], getElementData(towTruck, "carAttached")[3], getElementData(towTruck, "carAttached")[4]
				local ropedVehicle = getElementData(towTruck, "carRoped")
				setElementData(ropedVehicle[1], "carOnPacker", false)
				setElementData(towTruck, "carAttached", false)
				triggerClientEvent("packerDetachAnimation", client, towTruck, car, zCorr, rot)
			else
				outputChatBox("[color=sightred][SightMTA - Hiba]: [color=hudwhite]Nincs jogosultságod a packer használatához!", client)
			end
        end
	end
)

function findAttachOffsets(vehicle, towedBy)
	local frRotX, frRotY, frRotZ = getElementRotation(vehicle)
	local toRotX, toRotY, toRotZ = getElementRotation(towedBy)
	local dist = 1
	return 0, -2.425, 0.3 + dist, 0, 0, frRotZ - toRotZ
end

addEventHandler("onElementDataChange", getRootElement(),
	function (dataName, oldVal)
		if dataName == "packerState" then
			local dataVal = getElementData(source, "packerState") or "up"

			if dataVal ~= "up" then
				setElementFrozen(source, true)
			else
				setElementFrozen(source, false)
			end
		end

		if dataName == "carPlacedOnTruck" then
			local dataVal = getElementData(source, "carPlacedOnTruck")


			if oldVal and not dataVal then
				detachElements(source, oldVal[1])
            end

			if dataVal then
                setElementData(dataVal[1], "vehicle.lights", 0)
                setVehicleOverrideLights(dataVal[1], 1)
                attachElements(source, dataVal[1], dataVal[2], dataVal[3], dataVal[4], dataVal[5], dataVal[6], dataVal[7])
			end
		end

		if dataName == "carAnimation" then
			local dataVal = getElementData(source, "carAnimation")

			if oldVal and not dataVal then
				setElementCollisionsEnabled(source, true)
			end

			if dataVal then
				setElementCollisionsEnabled(source, false)
			end
		end

		if dataName == "cableHolder" then
			local dataVal = getElementData(source, "cableHolder")

			if isElement(dataVal) and getElementType(dataVal) == "player" then
				setElementSyncer(source, dataVal)
			else
				setElementSyncer(source, true)
			end
		end
	end
)

addEvent("openUnImpoundPanel", true)
addEventHandler("openUnImpoundPanel", getRootElement(),
	function ()
		source = client
		if isElement(source) then
			dbQuery(
				function (qh, thePlayer)
					if isElement(thePlayer) then
						local result = dbPoll(qh, 0)
						for k, v in ipairs(getElementsByType("vehicle")) do
							if getElementData(v, "vehicle.dbID") == result.dbID then
								result.customModel = getElementData(v, "vehicle.customModel")
							end
						end
						triggerClientEvent(thePlayer, "openUnImpoundPanel", thePlayer, result or {})
					end
				end,
			{source}, connection, "SELECT dbID, modelId FROM vehicles WHERE impounded = 1 AND characterId = ?", getElementData(source, "char.ID"))
		end
	end
)

local unImpoundPrice = 5500

addEvent("tryToUnimpoundVehicle", true)
addEventHandler("tryToUnimpoundVehicle", getRootElement(),
	function (vehicleId, model)
		if vehicleId and model then
            price = calculateUnimpound(model) or 0
            money = exports.sCore:getMoney(client) or 0
			local vehicleElement = false
			for k, v in pairs(getElementsByType("vehicle")) do
				if getElementData(v, "vehicle.dbID") == vehicleId then
					if not getElementData(v, "vehicle.impounded") then
						exports.sGui:showInfobox(client, "e", "Ezt az autót már kiváltották!")
						return
					end
				end
			end

			if money >= tonumber(price) then
				dbExec(connection, "UPDATE vehicles SET impounded = 0 WHERE dbID = ?", vehicleId)
				dbQuery(
					function (qh, thePlayer)
						if isElement(thePlayer) then
							local result = dbPoll(qh, 0)
							if result then
								for k, v in ipairs(getElementsByType("vehicle")) do
									if getElementData(v, "vehicle.dbID") == vehicleId then
										veh = v
										local vehiclePosition = chooseRandomCarPosition()
                                        setElementData(v, "vehicleNoCol", true)
                                        setElementPosition(v, vehiclePosition[1], vehiclePosition[2], vehiclePosition[3])
                                        setElementRotation(v, 0, 0, vehiclePosition[4])
                                        setElementDimension(v, 0)
                                        setElementData(v, "vehicle.impounded", false)
                                        exports.sCore:setMoney(thePlayer, money - price)
										exports.sGroups:addGroupBalance("PF", thePlayer, price)
									end
								end
								
								setTimer(
									function (veh)
										if isElement(veh) then
											removeElementData(veh, "vehicleNoCol")
											setElementAlpha(veh, 255)
										end
									end,
								20000 * 6, 1, veh)

								local vehicleOwner = getElementData(veh, "vehicle.owner")
								if vehicleOwner == getElementData(thePlayer, "char.ID") then
									exports.sGui:showInfobox(thePlayer, "s", "Sikeresen kiváltottad a járművedet! Megjelöltük a térképen. (Zöld jármű ikon)")
									triggerClientEvent(thePlayer, "gotVehicleGPSMark", thePlayer, veh, true)
								else
									local ownerElement = false
									for _, playerElem in pairs(getElementsByType("player")) do
										if getElementData(playerElem, "char.ID") == vehicleOwner then
											ownerElement = playerElem
										end
									end

									outputChatBox("[color=sightgreen][SightMTA - Siker]: [color=hudwhite]Sikeresen kiváltottad egy játékos járművét!", thePlayer)

									exports.sGui:showInfobox(ownerElement, "s", "Egy adminisztrátor kiváltotta a lefoglalt járműved. (Zöld jármű ikon)")
									triggerClientEvent(ownerElement, "gotVehicleGPSMark", ownerElement, veh, true)
								end
							end
						end
					end,
				{source}, connection, "SELECT * FROM vehicles WHERE dbID = ? LIMIT 1", vehicleId)
			else
				exports.sGui:showInfobox(client, "e", "Nincs elég pénzed az autó kiváltásához!")
			end
		end
	end
)

local exceptionVehicles = {
	[592] = true, --Repülő/Helikopter
	[577] = true,
	[511] = true,
	[512] = true,
	[593] = true,
	[520] = true,
	[553] = true,
	[476] = true,
	[519] = true,
	[460] = true,
	[513] = true,
	[548] = true,
	[425] = true,
	[417] = true,
	[487] = true,
	[488] = true,
	[497] = true,
	[563] = true,
	[447] = true,
	[469] = true,
	[581] = true, --Motor/Bicikli/Quad
	[509] = true,
	[481] = true,
	[462] = true,
	[521] = true,
	[463] = true,
	[510] = true,
	[522] = true,
	[461] = true,
	[448] = true,
	[468] = true,
	[586] = true,
	[471] = true,
	[472] = true, --Hajó(?)
	[473] = true,
	[493] = true,
	[595] = true,
	[484] = true,
	[430] = true,
	[453] = true,
	[452] = true,
	[446] = true,
	[454] = true
}

addCommandHandler("lefoglal",
	function (sourcePlayer, commandName)
		if getElementData(sourcePlayer, "acc.adminLevel") >= 2 then
			local theVeh = getPedOccupiedVehicle(sourcePlayer)

			if isElement(theVeh) then
				local groupId = getElementData(theVeh, "vehicle.group") or 0

				if groupId == 0 or groupId == "0" then
					local jobVehID = getElementData(theVeh, "jobVehicleID") or 0

					if jobVehID == 0 then
						local vehicleModel = getElementModel(theVeh)

						if exports.sGroups:getPlayerPermission(sourcePlayer, "packerImpound") and not exports.sPermission:hasPermission(sourcePlayer, "impound") then
							if not exceptionVehicles[vehicleModel] then
								outputChatBox("[color=sightred][SightMTA - Hiba]: [color=hudwhite]Csak adott járműveket foglalhatsz le paranccsal!", sourcePlayer)
								return
							end
						end

						if not getElementData(theVeh, "cableAttachment") then
							removePedFromVehicle(sourcePlayer)
							impoundTheVehicle(theVeh, true)
							outputChatBox("[color=sightgreen][SightMTA - Lefoglalás]:[color=hudwhite] Sikeresen lefoglaltad a járművet.", sourcePlayer, 255, 255, 255, true)
						else
							outputChatBox("[color=sightred][SightMTA - Lefoglalás]:[color=hudwhite] Az autót éppen lefoglalják.", sourcePlayer, 255, 255, 255, true)
						end
					else
						outputChatBox("[color=sightred][SightMTA - Lefoglalás]:[color=hudwhite] Munkajárműveket nem foglalhatsz le.", sourcePlayer, 255, 255, 255, true)
					end
				else
					outputChatBox("[color=sightred][SightMTA - Lefoglalás]:[color=hudwhite] Frakciójárműveket nem foglalhatsz le.", sourcePlayer, 255, 255, 255, true)
				end
			else
				outputChatBox("[color=sightred][SightMTA - Lefoglalás]:[color=hudwhite] Nem ülsz járműben.", sourcePlayer, 255, 255, 255, true)
			end
		end
	end
)

function informatePlayer(thePlayer, police)
	if isElement(thePlayer) then
		if police then
			outputChatBox("[color=sightblue][Sight City Rendőrség]:[color=hudwhite] Üdvözöljük! Tájékoztatjuk, hogy kapitányságunk elszállította és lefoglalta járművét [color=sightred]egyéb okok #ffffffmiatt.", thePlayer, 255, 255, 255, true)
			outputChatBox("[color=sightblue][Sight City Rendőrség]:[color=hudwhite] Amennyiben ki szeretné váltani járművét, úgy fáradjon el a Los Santosi kapitányságra és keresse egy kollégánkat.", thePlayer, 255, 255, 255, true)	
		else
			outputChatBox("[color=sightred][Parkolás felügyelet]:[color=hudwhite] Tájékoztatjuk, hogy járművét szervezetünk lefoglalta és elszállította [color=sightred]nem megfelelő parkolás #ffffffmiatt.", thePlayer, 255, 255, 255, true)
			outputChatBox("[color=sightred][Parkolás felügyelet]:[color=hudwhite] Amennyiben ki szeretné váltani járművét, Vegye fel velünk a kapcsolatot [color=sightblue]San Fierro-i #fffffftelephelyünkön.", thePlayer, 255, 255, 255, true)	
		end
	end
end

function onEchange(key, oValue, nValue)
    if getElementType(source) == "vehicle" and key == "carRopedTo" and not nValue and getElementModel(source) ~= 443 then
		local car = source
		for k, v in pairs(impoundColshapes) do
			if isElementWithinColShape(car, v) then
				if getPoliceColshape() == v then
					impoundTheVehicle(car, false, true)
					break
				else
					impoundTheVehicle(car)
					break
				end
			end
		end
    end
end
addEventHandler("onElementDataChange", root, onEchange)

impoundColshapes = {}

for k, v in pairs(impoundPositions) do
    local fx, fy, fw, fh, isPolice = v[3], v[4], v[3], v[4], v[5]
    impoundColshapes[k] = createColRectangle(fx, fy, 8, 8)
	setElementData(impoundColshapes[k], "goldrob.police", (v[5] or false))
end

function getPoliceColshape()
	for colIndex, colShape in pairs(impoundColshapes) do
		if colIndex == 3 then
			return colShape
		end
	end
end

function impoundTheVehicle(vehicleElement, adminCommand, policeImpound, player)
	if isElement(vehicleElement) then
		local ownerId = getElementData(vehicleElement, "vehicle.owner") or 0

		local groupId = getElementData(vehicleElement, "vehicle.group") or 0
		local jobVehID = getElementData(vehicleElement, "jobVehicleID") or 0
		if ownerId > 0 and jobVehID == 0 and (groupId == 0 or groupId == "0") then
			local impoundData = policeImpound and 2 or 1

			dbExec(connection, "UPDATE vehicles SET impounded = ? WHERE dbID = ?", impoundData, getElementData(vehicleElement, "vehicle.dbID"))
			setElementData(vehicleElement, "vehicle.impounded", impoundData)
			setElementDimension(vehicleElement, getElementData(vehicleElement, "vehicle.dbID"))
			
			if not adminCommand then
				removeElementData(vehicleElement, "carOnPacker")
				removeElementData(vehicleElement, "packerRampState")
				removeElementData(vehicleElement, "carRoped")
				removeElementData(vehicleElement, "carPlacedOnTruck")
				removeElementData(vehicleElement, "carAttached")
				removeElementData(vehicleElement, "cableHolder")
			end


			for k, v in pairs(getElementsByType("player")) do
				if ownerId == getElementData(v, "char.ID") then
					informatePlayer(v, policeImpound)
					break
				end
			end
		end
	end
end

local impoundPed = createPed(18, -2147.3022460938, -975.43133544922 - 0.5, 32.174453735352)
setElementData(impoundPed, "invulnerable", true)
setElementFrozen(impoundPed, true)
setElementData(impoundPed, "visibleName", "Lefoglalt járművek")

addEventHandler("onElementClicked", resourceRoot, function(clientButton, buttonState, playerElement)
    if clientButton == "right" and buttonState == "down" and playerElement and source == impoundPed then
        local x, y, z = getElementPosition(source)
        local px, py, pz = getElementPosition(playerElement)
        if getDistanceBetweenPoints3D(px, py, pz, x, y, z) < 3 then
            triggerClientEvent(playerElement, "impoundLoader", playerElement)
            local impounded = {}
            for k, v in pairs(getElementsByType("vehicle")) do
                if getElementData(v, "vehicle.impounded") and getElementData(v, "vehicle.impounded") == 1 and getElementData(v, "vehicle.owner") == getElementData(playerElement, "char.ID") then
                    table.insert(impounded, {model = getElementModel(v), vehicleId = getElementData(v, "vehicle.dbID"), plate = getVehiclePlateText(v), customModel = getElementData(v, "vehicle.customModel")})
                end
            end
            triggerClientEvent(playerElement, "gotImpoundedVehicleList", playerElement, impounded, impoundPed)
        end
    end
end)


addCommandHandler("impounded", function(sourcePlayer, sourceCommand, targetPlayer)
	if sourcePlayer and exports.sPermission:hasPermission(sourcePlayer, "manageImpoundUnimpound") then
		if not targetPlayer then
			outputChatBox("[color=sightblue][SightMTA - Lefoglalás]:[color=hudwhite] /"..sourceCommand.." [Játékos Név / ID]", sourcePlayer)
			return
		end
		local targetPlayer, targetName = exports.sCore:findPlayer(client, targetPlayer)

		if targetPlayer then
			local targetIdentity = getElementData(targetPlayer, "char.ID")
			outputChatBox("[color=sightgreen][SightMTA - Lefoglalás]:[color=hudwhite] Sikeresen megtekintetted [color=sightgreen]"..targetName.." [color=hudwhite]lefoglalt járműveit!", sourcePlayer)
			local playerVehicles = {}
			triggerClientEvent(sourcePlayer, "impoundLoader", sourcePlayer)

			for _, vehicleElement in pairs(getElementsByType("vehicle")) do
				if getElementData(vehicleElement, "vehicle.impounded") and getElementData(vehicleElement, "vehicle.impounded") == 1 and getElementData(vehicleElement, "vehicle.owner") == getElementData(targetPlayer, "char.ID") then
					table.insert(playerVehicles, {model = getElementModel(vehicleElement), vehicleId = getElementData(vehicleElement, "vehicle.dbID"), plate = getVehiclePlateText(vehicleElement), customModel = getElementData(vehicleElement, "vehicle.customModel")})
				end
			end

			triggerClientEvent(sourcePlayer, "gotImpoundedVehicleList", sourcePlayer, playerVehicles, false, targetName)
		end
	end
end)

addCommandHandler("kivalt", function(sourcePlayer, cmd, id)
	if exports.sGroups:getPlayerPermission(sourcePlayer, "packerImpound") then
		local id = tonumber(id)
		if not id then
			outputChatBox("[color=sightblue][SightMTA - Lefoglalás][color=hudwhite] /kivalt [Autó ID]", sourcePlayer)
			return
		end

		local foundCar = false

		for k, v in pairs(getElementsByType("vehicle")) do
			if getElementData(v, "vehicle.dbID") == id and getElementData(v, "vehicle.impounded") == 2 then
				foundCar = v
				break
			end
		end

		if not foundCar then
			outputChatBox("[color=sightred][SightMTA - Lefoglalás][color=hudwhite] Ez az autó nem rendőrség által lett lefoglalva!", sourcePlayer)
			return
		end

		local vehiclePosition = chooseRandomCarPosition(true)

		setElementData(foundCar, "vehicleNoCol", true)
		setElementPosition(foundCar, vehiclePosition[1], vehiclePosition[2], vehiclePosition[3])
		setElementRotation(foundCar, 0, 0, vehiclePosition[4])
		setElementDimension(foundCar, 0)
		setElementData(foundCar, "vehicle.impounded", false)

		local affectedPlayers = {}

		for _, playerElement in ipairs(getElementsByType("player")) do
			if playerElement then
				if exports.sItems:hasItem(playerElement, 4) then
					if exports.sGroups:getPlayerPermission(playerElement, "departmentRadio") then
						table.insert(affectedPlayers, playerElement)
					end
				end
			end
		end

		local alertMessage = "[color=sightblue][SightMTA - Lefoglalás]: [color=sightgreen]" .. getElementData(sourcePlayer, "visibleName"):gsub("_", " ") .."#ffffff kiváltott egy járművet. Rendszám:[color=sightblue] " .. getVehiclePlateText(foundCar) .. " (".. id ..")"
		triggerClientEvent(affectedPlayers, "gotGroupMessage", sourcePlayer, "department", nil, nil, alertMessage)

		dbExec(connection, "UPDATE vehicles SET impounded = 0 WHERE dbID = ?", id)

	end

end)

local vehiclePositions = {
	{-2149.2021484375, -965.23415527344, 31.597959518433}, --1
	{-2149.2021484375, -962.56811523438, 31.597959518433},
	{-2149.2021484375, -959.52056884766, 31.597959518433},
	{-2149.2021484375, -956.52923583984, 31.597959518433},
	{-2149.2021484375, -953.58050537109, 31.597959518433},
	{-2149.2021484375, -950.60156250000, 31.597959518433},
	{-2149.2021484375, -947.59100341797, 31.597959518433},
	{-2149.2021484375, -944.61206054688, 31.597959518433},
	{-2149.2021484375, -941.53430175781, 31.597959518433},
	{-2149.2021484375, -938.58880615234, 31.597959518433},
	{-2149.2021484375, -935.58782958984, 31.597959518433},
	{-2149.2021484375, -932.55535888672, 31.597959518433},
	{-2149.2021484375, -929.59039306641, 31.597959518433},
	{-2149.2021484375, -926.55059814453, 31.597959518433},
	{-2149.2021484375, -923.63671875000, 31.597959518433},
	{-2149.2021484375, -920.61968994141, 31.597959518433},
	{-2149.2021484375, -917.60144042969, 31.597959518433}, --1->17
	{-2149.2021484375, -914.49060058594, 31.597959518433},
	{-2149.2021484375, -911.56188964844, 31.597959518433},
	{-2149.2021484375, -908.49792480469, 31.597959518433},
	{-2149.2021484375, -905.40582275391, 31.597959518433}, --21
	{-2149.2021484375, -902.14727783203, 31.597959518433},
	{-2149.2021484375, -898.91778564450, 31.597959518433},
	{-2149.2021484375, -895.67932128906, 31.597959518433},
	{-2149.2021484375, -892.48742675781, 31.597959518433},
	{-2149.2021484375, -889.21734619141, 31.597959518433},
	{-2149.2021484375, -886.00964355469, 31.597959518433},
	{-2149.2021484375, -882.64654541016, 31.597959518433},
	{-2149.2021484375, -879.47753906250, 31.597959518433},
	{-2149.2021484375, -876.23211669922, 31.597959518433},
	{-2149.2021484375, -873.03613281250, 31.597959518433},
	{-2149.2021484375, -869.79180908203, 31.597959518433},
	{-2149.2021484375, -866.57843017578, 31.597959518433},
	{-2149.2021484375, -863.37591552734, 31.597959518433}, --21->34
	{-2149.2021484375, -860.37280273438, 31.597959518433},
	{-2149.2021484375, -857.39971923828, 31.597959518433},
	{-2149.2021484375, -854.25048828125, 31.597959518433},
	{-2149.2021484375, -851.00292968750, 31.597959518433}, --38
	{-2149.2021484375, -847.74224853516, 31.597959518433},
	{-2149.2021484375, -844.50512695312, 31.597959518433},
	{-2149.2021484375, -841.28472900391, 31.597959518433},
	{-2149.2021484375, -838.06591796875, 31.597959518433},
	{-2149.2021484375, -834.78814697266, 31.597959518433},
	{-2149.2021484375, -831.58367919922, 31.597959518433},
	{-2149.2021484375, -828.21978759766, 31.597959518433},
	{-2149.2021484375, -825.05157470703, 31.597959518433},
	{-2149.2021484375, -821.82843017578, 31.597959518433},
	{-2149.2021484375, -818.56250000000, 31.597959518433},
	{-2149.2021484375, -815.31610107422, 31.597959518433},
	{-2149.2021484375, -812.16351318359, 31.597959518433}, --38->50
	{-2149.2021484375, -809.10339355469, 31.597959518433},
	{-2149.2021484375, -806.17596435547, 31.597959518433},
	{-2149.2021484375, -803.09826660156, 31.597959518433}, --53
	{-2149.2021484375, -800.08319091797, 31.597959518433},
	{-2149.2021484375, -797.08636474609, 31.597959518433},
	{-2149.2021484375, -793.98400878906, 31.597959518433},
	{-2149.2021484375, -791.04559326172, 31.597959518433},
	{-2149.2021484375, -788.02233886719, 31.597959518433},
	{-2149.2021484375, -785.03289794922, 31.597959518433},
	{-2149.2021484375, -782.01177978516, 31.597959518433},
	{-2149.2021484375, -778.98565673828, 31.597959518433},
	{-2149.2021484375, -775.95715332031, 31.597959518433},
	{-2149.2021484375, -772.97393798828, 31.597959518433},
	{-2149.2021484375, -770.00311279297, 31.597959518433},
	{-2149.2021484375, -766.94012451172, 31.597959518433},
	{-2149.2021484375, -763.97955322266, 31.597959518433},
	{-2149.2021484375, -760.97631835938, 31.597959518433},
	{-2149.2021484375, -758.03979492188, 31.597959518433},
	{-2149.2021484375, -754.97729492188, 31.597959518433}, -- 53->69
	{-2134.1306152344, -965.23415527344, 31.597959518433}, -- Második oszlop 1 (mindegyikre rotx/y/z = 0/0/270)
	{-2134.1306152344, -962.56811523438, 31.597959518433},
	{-2134.1306152344, -959.52056884766, 31.597959518433},
	{-2134.1306152344, -956.52923583984, 31.597959518433},
	{-2134.1306152344, -953.58050537109, 31.597959518433},
	{-2134.1306152344, -950.60156250000, 31.597959518433},
	{-2134.1306152344, -947.59100341797, 31.597959518433},
	{-2134.1306152344, -944.61206054688, 31.597959518433},
	{-2134.1306152344, -941.53430175781, 31.597959518433},
	{-2134.1306152344, -938.58880615234, 31.597959518433},
	{-2134.1306152344, -935.58782958984, 31.597959518433},
	{-2134.1306152344, -932.55535888672, 31.597959518433},
	{-2134.1306152344, -929.59039306641, 31.597959518433},
	{-2134.1306152344, -926.55059814453, 31.597959518433},
	{-2134.1306152344, -923.63671875000, 31.597959518433},
	{-2134.1306152344, -920.61968994141, 31.597959518433},
	{-2134.1306152344, -917.60144042969, 31.597959518433}, -- Második oszlop 1->17
	{-2134.1306152344, -905.40582275391, 31.597959518433}, -- Második oszlop 21
	{-2134.1306152344, -902.14727783203, 31.597959518433},
	{-2134.1306152344, -898.91778564450, 31.597959518433},
	{-2134.1306152344, -895.67932128906, 31.597959518433},
	{-2134.1306152344, -892.48742675781, 31.597959518433},
	{-2134.1306152344, -889.21734619141, 31.597959518433},
	{-2134.1306152344, -886.00964355469, 31.597959518433},
	{-2134.1306152344, -882.64654541016, 31.597959518433},
	{-2134.1306152344, -879.47753906250, 31.597959518433},
	{-2134.1306152344, -876.23211669922, 31.597959518433},
	{-2134.1306152344, -873.03613281250, 31.597959518433},
	{-2134.1306152344, -869.79180908203, 31.597959518433},
	{-2134.1306152344, -866.57843017578, 31.597959518433},
	{-2134.1306152344, -863.37591552734, 31.597959518433}, -- Második oszlop 21->34
	{-2134.1306152344, -851.00292968750, 31.597959518433}, -- Második oszlop 38
	{-2134.1306152344, -847.74224853516, 31.597959518433},
	{-2134.1306152344, -844.50512695312, 31.597959518433},
	{-2134.1306152344, -841.28472900391, 31.597959518433},
	{-2134.1306152344, -838.06591796875, 31.597959518433},
	{-2134.1306152344, -834.78814697266, 31.597959518433},
	{-2134.1306152344, -831.58367919922, 31.597959518433},
	{-2134.1306152344, -828.21978759766, 31.597959518433},
	{-2134.1306152344, -825.05157470703, 31.597959518433},
	{-2134.1306152344, -821.82843017578, 31.597959518433},
	{-2134.1306152344, -818.56250000000, 31.597959518433},
	{-2134.1306152344, -815.31610107422, 31.597959518433},
	{-2134.1306152344, -812.16351318359, 31.597959518433}, -- Második oszlop 38->50
	{-2134.1306152344, -803.09826660156, 31.597959518433}, -- Második oszlop 53
	{-2134.1306152344, -800.08319091797, 31.597959518433},
	{-2134.1306152344, -797.08636474609, 31.597959518433},
	{-2134.1306152344, -793.98400878906, 31.597959518433},
	{-2134.1306152344, -791.04559326172, 31.597959518433},
	{-2134.1306152344, -788.02233886719, 31.597959518433},
	{-2134.1306152344, -785.03289794922, 31.597959518433},
	{-2134.1306152344, -782.01177978516, 31.597959518433},
	{-2134.1306152344, -778.98565673828, 31.597959518433},
	{-2134.1306152344, -775.95715332031, 31.597959518433},
	{-2134.1306152344, -772.97393798828, 31.597959518433},
	{-2134.1306152344, -770.00311279297, 31.597959518433},
	{-2134.1306152344, -766.94012451172, 31.597959518433},
	{-2134.1306152344, -763.97955322266, 31.597959518433},
	{-2134.1306152344, -760.97631835938, 31.597959518433},
	{-2134.1306152344, -758.03979492188, 31.597959518433},
	{-2134.1306152344, -754.97729492188, 31.597959518433}, -- Második oszlop 53->69
	{-2125.1171875000, -965.23415527344, 31.597959518433}, -- Harmadik oszlop 1 (mindegyikre rotx/y/z = 0/0/90)
	{-2125.1171875000, -962.56811523438, 31.597959518433},
	{-2125.1171875000, -959.52056884766, 31.597959518433},
	{-2125.1171875000, -956.52923583984, 31.597959518433},
	{-2125.1171875000, -953.58050537109, 31.597959518433},
	{-2125.1171875000, -950.60156250000, 31.597959518433},
	{-2125.1171875000, -947.59100341797, 31.597959518433},
	{-2125.1171875000, -944.61206054688, 31.597959518433},
	{-2125.1171875000, -941.53430175781, 31.597959518433},
	{-2125.1171875000, -938.58880615234, 31.597959518433},
	{-2125.1171875000, -935.58782958984, 31.597959518433},
	{-2125.1171875000, -932.55535888672, 31.597959518433},
	{-2125.1171875000, -929.59039306641, 31.597959518433},
	{-2125.1171875000, -926.55059814453, 31.597959518433},
	{-2125.1171875000, -923.63671875000, 31.597959518433},
	{-2125.1171875000, -920.61968994141, 31.597959518433},
	{-2125.1171875000, -917.60144042969, 31.597959518433}, -- Harmadik oszlop 1->17
	{-2125.1171875000, -905.40582275391, 31.597959518433}, -- Harmadik oszlop 21
	{-2125.1171875000, -902.14727783203, 31.597959518433},
	{-2125.1171875000, -898.91778564450, 31.597959518433},
	{-2125.1171875000, -895.67932128906, 31.597959518433},
	{-2125.1171875000, -892.48742675781, 31.597959518433},
	{-2125.1171875000, -889.21734619141, 31.597959518433},
	{-2125.1171875000, -886.00964355469, 31.597959518433},
	{-2125.1171875000, -882.64654541016, 31.597959518433},
	{-2125.1171875000, -879.47753906250, 31.597959518433},
	{-2125.1171875000, -876.23211669922, 31.597959518433},
	{-2125.1171875000, -873.03613281250, 31.597959518433},
	{-2125.1171875000, -869.79180908203, 31.597959518433},
	{-2125.1171875000, -866.57843017578, 31.597959518433},
	{-2125.1171875000, -863.37591552734, 31.597959518433}, -- Harmadik oszlop 21->34
	{-2125.1171875000, -851.00292968750, 31.597959518433}, -- Harmadik oszlop 38
	{-2125.1171875000, -847.74224853516, 31.597959518433},
	{-2125.1171875000, -844.50512695312, 31.597959518433},
	{-2125.1171875000, -841.28472900391, 31.597959518433},
	{-2125.1171875000, -838.06591796875, 31.597959518433},
	{-2125.1171875000, -834.78814697266, 31.597959518433},
	{-2125.1171875000, -831.58367919922, 31.597959518433},
	{-2125.1171875000, -828.21978759766, 31.597959518433},
	{-2125.1171875000, -825.05157470703, 31.597959518433},
	{-2125.1171875000, -821.82843017578, 31.597959518433},
	{-2125.1171875000, -818.56250000000, 31.597959518433},
	{-2125.1171875000, -815.31610107422, 31.597959518433},
	{-2125.1171875000, -812.16351318359, 31.597959518433}, -- Harmadik oszlop 38->50
	{-2125.1171875000, -803.09826660156, 31.597959518433}, -- Harmadik oszlop 53
	{-2125.1171875000, -800.08319091797, 31.597959518433},
	{-2125.1171875000, -797.08636474609, 31.597959518433},
	{-2125.1171875000, -793.98400878906, 31.597959518433},
	{-2125.1171875000, -791.04559326172, 31.597959518433},
	{-2125.1171875000, -788.02233886719, 31.597959518433},
	{-2125.1171875000, -785.03289794922, 31.597959518433},
	{-2125.1171875000, -782.01177978516, 31.597959518433},
	{-2125.1171875000, -778.98565673828, 31.597959518433},
	{-2125.1171875000, -775.95715332031, 31.597959518433},
	{-2125.1171875000, -772.97393798828, 31.597959518433},
	{-2125.1171875000, -770.00311279297, 31.597959518433},
	{-2125.1171875000, -766.94012451172, 31.597959518433},
	{-2125.1171875000, -763.97955322266, 31.597959518433},
	{-2125.1171875000, -760.97631835938, 31.597959518433},
	{-2125.1171875000, -758.03979492188, 31.597959518433},
	{-2125.1171875000, -754.97729492188, 31.597959518433} -- Harmadik oszlop 53->69

}

local vehiclePositionsPD = {
	{1624.1541748047, -1609.7993164062, 13.242829322815, 0, -6, 180},
	{1624.1605224609, -1617.4924316406, 13.242745399475, 0, -6, 180},
	{1624.1898193359, -1626.1947021484, 13.242757797241, 0, -6, 180},
	{1624.2398681641, -1637.1654052734, 13.240382194519, 0, -6, 180},

	{1612.2233886719, -1629.2462158203, 13.252704620361,  0, -6, 0},
	{1612.1020507812, -1622.4304199219, 13.242764472961, 0, -6, 0},
	{1612.2369384766, -1614.9520263672, 13.242673873901, 0, -6, 0},
}

function chooseRandomCarPosition(pd)

	if pd then
		local position = {}
		local randompos = math.random(1, #vehiclePositionsPD)
	
		local rotation = 0
		if randompos <= 4 then
			rotation = 90
		elseif randompos >= 5 then
			rotation = 180
		end
	
		local position = {vehiclePositionsPD[randompos][1], vehiclePositionsPD[randompos][2], vehiclePositionsPD[randompos][3], rotation}
		return position
	else
		local position = {}
		local randompos = math.random(1, #vehiclePositions)
	
		local rotation = 90
		if randompos <= 69 then
			rotation = 270
		elseif randompos >= 131 then
			rotation = 271
		end
	
		local position = {vehiclePositions[randompos][1], vehiclePositions[randompos][2], vehiclePositions[randompos][3], rotation}
		return position
	end
end