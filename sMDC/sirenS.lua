local dbConnection = exports.sConnection:getConnection()

addEvent("vehicleSirenHorn", true)
function vehicleSirenHorn(players)
    triggerClientEvent(players, "vehicleSirenHorn", client)
end
addEventHandler("vehicleSirenHorn", root, vehicleSirenHorn)

local vehicleLights = {}

local coronaMarkers = {}

addEvent("requestCoronaSirens", true)
addEventHandler("requestCoronaSirens", root, function()
	triggerClientEvent(client, "gotCoronaSirens", client, coronaMarkers)
end)

addEvent("toggleVehicleSiren", true)
addEventHandler("toggleVehicleSiren", root, function()
	client = client or source
	local sourceVehicle = getPedOccupiedVehicle(client)
	
	local vehicleModel = getElementModel(sourceVehicle)
	if getElementData(sourceVehicle, "vehicle.customModel") then
		vehicleModel = getElementData(sourceVehicle, "vehicle.customModel")
	end

	setElementData(sourceVehicle, "vehicle.sirenstate", not (getElementData(sourceVehicle, "vehicle.sirenstate") or false))
	local sirenState = getElementData(sourceVehicle, "vehicle.sirenstate") or false

	local civilSiren = getElementData(sourceVehicle, "civilSiren") or false
	vehicleLights[sourceVehicle] = getVehicleSirens(sourceVehicle) or {}
	if sirenState then
		if civilSiren then
			if not vehicleLights[sourceVehicle] or #vehicleLights[sourceVehicle] == 0 and sirenPositions[vehicleModel] then
				addVehicleSirens(sourceVehicle, 1, 2, true, false, false, true)
				setVehicleSirens(sourceVehicle, 1, sirenPositions[vehicleModel][1], sirenPositions[vehicleModel][2], sirenPositions[vehicleModel][3] + 0.1, 0, 0, 255)
			end
			if sirenPositions[vehicleModel] then
				setVehicleSirensOn(sourceVehicle, sirenState)
			end
		else
			if sirenVehicles[vehicleModel].coronaSiren then

				local variant = {getVehicleVariant(sourceVehicle)}
				local variantIndex = variant[1]

				local x, y, z = getElementPosition(sourceVehicle)

				if sirenVehicles[vehicleModel].sirens[variantIndex] then
					for sirenIdentity, sirenData in pairs(sirenVehicles[vehicleModel].sirens[variantIndex]) do
						table.insert(coronaMarkers, {sourceVehicle, sirenData[1], sirenData[2], sirenData[3], sirenData[4], sirenData[5], sirenData[6]})
					end
					setVehicleSirensOn(sourceVehicle, sirenState)
					triggerClientEvent(root, "gotCoronaSirens", root, coronaMarkers)
				end
			else
				if sirenVehicles[vehicleModel].sirens then
					addVehicleSirens(sourceVehicle, #sirenVehicles[vehicleModel].sirens, 2, true, true, false, true)

					for sirenIdentity, sirenData in pairs(sirenVehicles[vehicleModel].sirens) do
						if type(sirenData[1]) == "table" then
							for k, v in pairs(sirenData) do
								setVehicleSirens(sourceVehicle, sirenIdentity, v[1], v[2], v[3], v[4], v[5], v[6])
							end
						else
							setVehicleSirens(sourceVehicle, sirenIdentity, sirenData[1], sirenData[2], sirenData[3], sirenData[4], sirenData[5], sirenData[6])
						end
					end
					setVehicleSirensOn(sourceVehicle, sirenState)
				end
			end
		end
	else
		for k, v in pairs(coronaMarkers) do
			if v[1] == sourceVehicle then
				coronaMarkers[k] = nil
			end
		end
		triggerClientEvent(root, "disableCoronaSirens", root, sourceVehicle)
		setVehicleSirensOn(sourceVehicle, sirenState)
	end	
end)

function onDestroy()
	if getElementType(source) == "vehicle" then
		for k, v in pairs(coronaMarkers) do
			if v[1] == source then
				coronaMarkers[k] = nil
			end
		end
		triggerClientEvent(root, "disableCoronaSirens", root, source)
	end
end
addEventHandler("onElementDestroy", root, onDestroy)

local savedHeadlights = {}
local emergency2Vehicles = {
	[525] = true,
	[443] = true,
	[552] = true,
	[574] = true
}

addEvent("turnEmergencyLights", true)
addEventHandler("turnEmergencyLights", root, function()
	if client ~= source then
        exports.sAnticheat:anticheatBan(client, "AC #75 - sMDC @sirenS:99")
		return
	end
	local sourceVehicle = getPedOccupiedVehicle(source)
	
	local allowedEmergency = false
	local civilSiren = getElementData(sourceVehicle, "civilSiren") or false
	local vehicleGroup = getElementData(sourceVehicle, "vehicle.group")
	local vehicleModel = getElementModel(sourceVehicle)

	if vehicleGroup then
		if exports.sGroups:isLawEnforcementGroup(vehicleGroup) or vehicleGroup == "OMSZ" or vehicleGroup == "OKF" then
			allowedEmergency = true
		end
	end

	if allowedEmergency or civilSiren or emergency2Vehicles[vehicleModel] then
		local emergencyState = (getElementData(sourceVehicle, "signalState") == "emergency" or getElementData(sourceVehicle, "signalState") == "emergency2") and true or false

		setElementData(sourceVehicle, "signalState", emergencyState and false or ((emergency2Vehicles[vehicleModel] or false) and "emergency2" or "emergency"))
	end
end)

addCommandHandler("asiren", function(sourcePlayer, commandName, sirenType)
	if exports.sPermission:hasPermission(sourcePlayer, "asiren") then
		local vehicleElement = getPedOccupiedVehicle(sourcePlayer)
		local sirenType = tonumber(sirenType)
		if not sirenType or sirenType > 2 then
			outputChatBox("[color=sightblue][SightMTA - Használat]: [color=hudwhite]/asiren [Sziréna típusa]", sourcePlayer)
			outputChatBox("[color=sightblue][SightMTA - Használat]: [color=hudwhite]Sziréna típusok: [1] - Fényhíd, [2] - Villogó", sourcePlayer)
			return
		end
		if vehicleElement then
			local vehicleModel = getElementModel(vehicleElement)
			if getElementData(vehicleElement, "vehicle.customModel") then
				vehicleModel = getElementData(vehicleElement, "vehicle.customModel")
			end
			local vehicleGroup = getElementData(vehicleElement, "vehicle.group")
			if vehicleGroup then
				if exports.sGroups:isLawEnforcementGroup(vehicleGroup) then
					if sirenVehicles[vehicleModel] and sirenVehicles[vehicleModel].variant then
						if sirenType == 1 and sirenVehicles[vehicleModel].variant[1] then
							outputChatBox("[color=sightblue][SightMTA][color=hudwhite] Sikeresen felhelyezted a fényhidat a járműre ["..getElementData(vehicleElement, "vehicle.dbID").."]", sourcePlayer)
							setVehicleVariant(vehicleElement, sirenVehicles[vehicleModel].variant[1], 255)
							local vehicleQuery = "UPDATE vehicles SET variant = ? WHERE dbID = ?"
							dbExec(dbConnection, vehicleQuery, toJSON({sirenVehicles[vehicleModel].variant[1], 255}), getElementData(vehicleElement, "vehicle.dbID"))
						elseif sirenType == 2 and sirenVehicles[vehicleModel].variant[2] then
							outputChatBox("[color=sightblue][SightMTA][color=hudwhite] Sikeresen felhelyezted a villogót a járműre ["..getElementData(vehicleElement, "vehicle.dbID").."]", sourcePlayer)
							setVehicleVariant(vehicleElement, sirenVehicles[vehicleModel].variant[2], 255)
							local vehicleQuery = "UPDATE vehicles SET variant = ? WHERE dbID = ?"
							dbExec(dbConnection, vehicleQuery, toJSON({sirenVehicles[vehicleModel].variant[2], 255}), getElementData(vehicleElement, "vehicle.dbID"))
						else
							outputChatBox("[color=sightred][SightMTA - Hiba]:[color=hudwhite] Erre a járműre nincs kompatibilis "..sirenType == 1 and "fényhíd" or "villogó", sourcePlayer)
						end
					else
						outputChatBox("[color=sightred][SightMTA - Hiba]:[color=hudwhite] Ez a jármű nem kompatibilis fényhíddal/villogóval", sourcePlayer)
					end
				else
					exports.sGui:showInfobox(sourcePlayer, "e", "Csak rendvédelmi járművekre rakhatsz villogót!")
				end
			else
				exports.sGui:showInfobox(sourcePlayer, "e", "Csak rendvédelmi járművekre rakhatsz villogót!")
			end
		end
	end
end)