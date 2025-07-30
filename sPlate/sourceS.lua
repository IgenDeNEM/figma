local connection = exports.sConnection:getConnection()

local outTunings = {
    ["owner"] = true,
    ["numberPlate"] = true,
    ["vehicleId"] = true,
    ["model"] = true,
    ["isDiesel"] = true,
    ["expireDate"] = true,
    ["creationDate"] = true,
    ["paintjob"] = true,
}

addEvent("requestVehiclePlateSearch", true)
addEventHandler("requestVehiclePlateSearch", root, 
    function(vehicleElement, forTraffi)
        if vehicleElement then
            local vehicleWarrant = #exports.sMdc:checkVehicleWarrantTraffipax(vehicleElement) > 0 and true or false
            local ownerId = getElementData(vehicleElement, "vehicle.owner")
            local ownerWarrants = #exports.sMdc:checkWarrantFromId(ownerId) > 0 and true or false

            local vehicleWarrantReasons = exports.sMdc:checkVehicleWarrantTraffipax(vehicleElement)
            local ownerWarrantReasons = exports.sMdc:checkWarrantFromId(ownerId)

            if forTraffi then
                dbQuery(function(queryHandle, client, vehicleElement, ownerWarrants)
                    local queryResult = dbPoll(queryHandle, 0)
                    if queryResult and type(queryResult) == "table" and #queryResult > 0 then
                        local row = queryResult[1]

                        if row.licenseData then
                            local licenseData = fromJSON(row.licenseData)
                            if licenseData then
                                licenseData = unpack(licenseData)
                            end
                            if licenseData and licenseData.expireDate and licenseData.creationDate then
                                local currentTime = getRealTime().timestamp / 86400
                                local licenseDatas = {
                                    validLicense = currentTime < licenseData.expireDate and true or false,
                                    expireDate = licenseData.expireDate,
                                    creationDate = licenseData.creationDate,
                                }

                                local validCount = 0
                                local valid = licenseDatas.validLicense
                                if licenseDatas.validLicense then
                                    for k, v in pairs(licenseData) do
                                        if not outTunings[k] and exports.sTrafficlicense:isTuningValid(k, vehicleElement, v) == 1 then
                                            validCount = validCount + 1
                                        end
                                    end
                                end
                                if valid then
                                    if validCount == 0 then
                                        triggerClientEvent(client, "gotVehiclePlateSearchForTraffi", client, vehicleElement, licenseDatas.validLicense, ownerWarrants)
                                    else
                                        triggerClientEvent(client, "gotVehiclePlateSearchForTraffi", client, vehicleElement, validCount, ownerWarrants)
                                    end
                                else
                                    triggerClientEvent(client, "gotVehiclePlateSearchForTraffi", client, vehicleElement, false, ownerWarrants)
                                end
                            else
                                triggerClientEvent(client, "gotVehiclePlateSearchForTraffi", client, vehicleElement, false, ownerWarrants)
                            end
                        else
                            triggerClientEvent(client, "gotVehiclePlateSearchForTraffi", client, vehicleElement, false, ownerWarrants)
                        end
                    else
                        triggerClientEvent(client, "gotVehiclePlateSearchForTraffi", client, vehicleElement, false, ownerWarrants)
                    end
                end, {client, vehicleElement, ownerWarrants}, connection, "SELECT licenseData FROM vehicles WHERE dbID = ?", getElementData(vehicleElement, "vehicle.dbID"))
            else
                triggerClientEvent(client, "gotVehiclePlateSearch", client, vehicleElement, false, ownerWarrants, vehicleWarrant)

                if vehicleWarrantReasons or ownerWarrantReasons then
                    local r1, g1, b1, r2, g2, b2 = getVehicleColor(vehicleElement, true)

                    local colorText = RGBToHex(r1, g1, b1) .. "Szín1 " .. RGBToHex(r2, g2, b2) .. "Szín2"

                    if getElementData(vehicleElement, "paintjob") and getElementData(vehicleElement, "paintjob") == -1 then
                        colorText = "[color=sightred-second]Matrica"
                    end
                    if not ownerWarrantReasons or not ownerWarrantReasons[1] then
                        ownerWarrantReasons = false
                    end
                    if not vehicleWarrantReasons or not vehicleWarrantReasons[1] then
                        vehicleWarrantReasons = false
                    end
                    triggerClientEvent("mdcVehicleWarrantAlert", vehicleElement, colorText, getElementModel(vehicleElement), getVehiclePlateText(vehicleElement), ownerWarrantReasons, vehicleWarrantReasons)
                end

                dbQuery(function(queryHandle, client, vehicleElement, ownerWarrants, vehicleWarrant)
                    local queryResult = dbPoll(queryHandle, 0)
                    if queryResult and type(queryResult) == "table" and #queryResult > 0 then
                        local row = queryResult[1]

                        if row.licenseData then
                            local licenseData = fromJSON(row.licenseData)
                            if licenseData then
                                licenseData = unpack(licenseData)
                            end
                            if licenseData and licenseData.expireDate and licenseData.creationDate then
                                local currentTime = getRealTime().timestamp / 86400
                                local licenseDatas = {
                                    validLicense = currentTime < licenseData.expireDate and true or false,
                                    expireDate = licenseData.expireDate,
                                    creationDate = licenseData.creationDate,
                                }

                                local validCount = 0
                                local valid = licenseDatas.validLicense
                                if licenseDatas.validLicense then
                                    for k, v in pairs(licenseData) do
                                        if not outTunings[k] and exports.sTrafficlicense:isTuningValid(k, vehicleElement, v) == 1 then
                                            validCount = validCount + 1
                                        end
                                    end
                                end
                                if valid then
                                    if validCount == 0 then
                                        triggerClientEvent(client, "gotVehiclePlateSearch", client, vehicleElement, licenseDatas.validLicense, ownerWarrants, vehicleWarrant)
                                    else
                                        triggerClientEvent(client, "gotVehiclePlateSearch", client, vehicleElement, validCount, ownerWarrants, vehicleWarrant)
                                    end
                                else
                                    triggerClientEvent(client, "gotVehiclePlateSearch", client, vehicleElement, false, ownerWarrants, vehicleWarrant)
                                end
                            else
                                triggerClientEvent(client, "gotVehiclePlateSearch", client, vehicleElement, false, ownerWarrants, vehicleWarrant)
                            end
                        else
                            triggerClientEvent(client, "gotVehiclePlateSearch", client, vehicleElement, false, ownerWarrants, vehicleWarrant)
                        end
                    else
                        triggerClientEvent(client, "gotVehiclePlateSearch", client, vehicleElement, false, ownerWarrants, vehicleWarrant)
                    end
                end, {client, vehicleElement, ownerWarrants, vehicleWarrant}, connection, "SELECT licenseData FROM vehicles WHERE dbID = ?", getElementData(vehicleElement, "vehicle.dbID"))
            end
        end
    end
)

function RGBToHex(red, green, blue, alpha)
	
	-- Make sure RGB values passed to this function are correct
	if( ( red < 0 or red > 255 or green < 0 or green > 255 or blue < 0 or blue > 255 ) or ( alpha and ( alpha < 0 or alpha > 255 ) ) ) then
		return nil
	end

	-- Alpha check
	if alpha then
		return string.format("#%.2X%.2X%.2X%.2X", red, green, blue, alpha)
	else
		return string.format("#%.2X%.2X%.2X", red, green, blue)
	end

end