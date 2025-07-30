local seexports = {
    sGui = false
}
 
local function sightlangProcessExports()
    for k in pairs(seexports) do
        local res = getResourceFromName(k)
        if res and getResourceState(res) == "running" then
            seexports[k] = exports[k]
        else
            seexports[k] = false
        end
    end
end
 
sightlangProcessExports()
 
if triggerServerEvent then
    addEventHandler("onClientResourceStart", getRootElement(), sightlangProcessExports, true, "high+9999999999")
end
 
if triggerClientEvent then
    addEventHandler("onResourceStart", getRootElement(), sightlangProcessExports, true, "high+9999999999")
end
 
local traffipaxPrice = 100
local beltPrice = 5000
 
addEvent("speedCameraBelt", true)
addEventHandler("speedCameraBelt", root, 
    function(beltCount)
        if beltCount then
            calculatedBeltPrice = (beltCount * beltPrice)
 
            local clientMoney = exports.sCore:getMoney(client)
 
            outputChatBox("[color=sightgreen][SightMTA - Traffipax]: #ffffffA járműben [color=sightblue]"..beltCount.." #ffffffembernek [color=sightred]nem#ffffff volt bekötve az öve.", client, 255, 255, 255, true)
            outputChatBox("[color=sightgreen][SightMTA - Traffipax]: #ffffffBüntetés összege: [color=sightred]"..exports.sGui:thousandsStepper(calculatedBeltPrice).." $", client, 255, 255, 255, true)
 
            exports.sCore:setMoney(client, clientMoney - calculatedBeltPrice)
        end
    end
)
 
addEvent("speedCameraHit", true)
addEventHandler("speedCameraHit", root, 
    function(targetVeh, calculatedSpeed, isFixedCam, hashCode, targetPlateText, targetSpeed, maximumSpeed)
        local vehDriver = getVehicleController(targetVeh)
        local driverMoney = exports.sCore:getMoney(vehDriver)

        if targetSpeed < 0 or maximumSpeed > targetSpeed then
            exports.sAnticheat:anticheatBan(client, "AC #122 - sTraffipax @sourceS:52")
            return
        end
 
        if isFixedCam then
            if vehDriver == client and not getElementData(targetVeh, "vehicle.sirenstate") then
                local calculatedTraffipaxPrice = getPrice(vehDriver, targetSpeed, true)
 
                setElementData(vehDriver, "char.Money", driverMoney - calculatedTraffipaxPrice)
 
                triggerClientEvent(vehDriver, "showInfobox", vehDriver, "w", "Bemért egy traffipax! Büntetésed: "..exports.sGui:thousandsStepper(calculatedTraffipaxPrice).."$")
                outputChatBox("[color=sightgreen][SightMTA - Traffipax]: #ffffffTúllépted a megengedett sebességhatárt.", vehDriver, 255, 255, 255, true)
                outputChatBox("[color=sightgreen][SightMTA - Traffipax]: #ffffffSebességed: [color=sightred]"..targetSpeed.." km/h#ffffff, megengedett sebesség: [color=sightblue]"..maximumSpeed.." km/h#ffffff.", vehDriver, 255, 255, 255, true)
                outputChatBox("[color=sightgreen][SightMTA - Traffipax]: #ffffffBüntetés: [color=sightred]"..exports.sGui:thousandsStepper(calculatedTraffipaxPrice).." $#ffffff.", vehDriver, 255, 255, 255, true)
                exports.sCore:setMoney(vehDriver, driverMoney - calculatedTraffipaxPrice)
                triggerClientEvent(getVehicleOccupants(targetVeh), "traffipaxFlash", targetVeh, isFixedCam)
            end
        else
            local clientName = getElementData(client, "visibleName"):gsub("_", " ")
            local clientVeh = getPedOccupiedVehicle(client)
            local clientGroup = getElementData(clientVeh, "vehicle.group")

            local calculatedTraffipaxPrice = (calculatedSpeed * traffipaxPrice)

            triggerClientEvent("gotGroupMessage", client, clientGroup, "blue", "Traffipax", "[color=sightgreen]"..clientName.." #ffffffbemért egy gyorshajtót: [color=sightblue]"..targetPlateText, false)
            triggerClientEvent("gotGroupMessage", client, clientGroup, "blue", "Traffipax", "Bírság: [color=sightgreen]"..exports.sGui:thousandsStepper(calculatedTraffipaxPrice).."$ / #ffffffSebesség: [color=sightblue]"..targetSpeed.." #ffffffkm/h / Limit: [color=sightblue]"..maximumSpeed.." #ffffffkm/h", false)

            exports.sCore:setMoney(vehDriver, driverMoney - calculatedTraffipaxPrice)
            local recipientNumber = getPlayerMobile(vehDriver)
            if recipientNumber then

                local groupName = exports.sGroups:getGroupName(clientGroup)

                price = exports.sGui:thousandsStepper(calculatedTraffipaxPrice)
                local timestamp = getRealTime().timestamp
                local message = {
                    sender = 3876100107,
                    recipient = recipientNumber,
                    timestamp = timestamp,
                    msgType = 1,
                    id = 1,
                    state = 1,
                    text = "Ön " .. calculatedSpeed .. " km/h-val túllépte a megengedett sebességhatárt, melyet egy sebességmérő kamera (".. groupName ..") dokumentált! A képet csatolmányként kapja erre az értesítési számra. Büntetése: " .. price .. " $."
                }

                if not getElementData(vehDriver, "smsInbox") then
                    setElementData(vehDriver, "smsInbox", {})
                end
                local inbox = getElementData(vehDriver, "smsInbox")
                table.insert(inbox, message)
                setElementData(vehDriver, "smsInbox", inbox)
                cacheEntry = { 3876100107, timestamp, 1, message.text }
        
                triggerClientEvent(vehDriver, "gotSMSCache", vehDriver, { cacheEntry }, true, true, true)
            end
        end

        local driverWarrants = exports.sMdc:checkPlayerWarrantTraffipax(vehDriver)
        local vehicleWarrants = exports.sMdc:checkVehicleWarrantTraffipax(targetVeh)
        
        local r1, g1, b1, r2, g2, b2 = getVehicleColor(targetVeh, true)

        local colorText = RGBToHex(r1, g1, b1) .. "Szín1 " .. RGBToHex(r2, g2, b2) .. "Szín2"

        if getElementData(targetVeh, "paintjob") and getElementData(targetVeh, "paintjob") == -1 then
            colorText = "[color=sightred-second]Matrica"
        end

        if #vehicleWarrants > 0 then
            triggerClientEvent("mdcVehicleWarrantAlert", targetVeh, colorText, getElementModel(targetVeh), getVehiclePlateText(targetVeh), false, vehicleWarrants)
        elseif #driverWarrants > 0 and #vehicleWarrants > 0 then
            triggerClientEvent("mdcVehicleWarrantAlert", targetVeh, colorText, getElementModel(targetVeh), getVehiclePlateText(targetVeh), driverWarrants, vehicleWarrants)
        elseif #driverWarrants > 0 then
            triggerClientEvent("mdcVehicleWarrantAlert", targetVeh, colorText, getElementModel(targetVeh), getVehiclePlateText(targetVeh), driverWarrants, false)
        end
    end
)

function getPlayerMobile(player)
    local currentNum = false
    local items = exports.sItems:getElementItems(player)
    for k, v in pairs(items) do
        if v.itemId == 9 then
            currentNum = v.data1
        end
    end
    return currentNum
end

addEvent("traffipaxSMSPicture", true)
function traffipaxSMSPicture(speed, price, filename, timestamp, checksum, checksumRaw, checksumThumb, convertedPixels, convertedThumb, sx, sy, zone, x, y)
    local recipientNumber = getPlayerMobile(source)
    if recipientNumber and speed and convertedPixels then
        imageFilename = "sms_pics/" .. 3876100107 .. "_" .. recipientNumber .. "_" .. timestamp .. ".dds"


        local file = fileCreate(":sMobile/".. imageFilename)
        if file then
            fileWrite(file, convertedPixels)
            fileClose(file)
        end
        local cData = imageFilename .. "#" .. "#" .. "asd" .. "#" .. timestamp.. "#" .. sx .. "#" .. sy .. "#" .. zone .. "#" .. x .. "#" .. y .. "#" .. "1.63" .. "#" .. "asd" .. "#" .. "camera"


        cacheEntry = {3876100107, timestamp, 2, cData, {convertedThumb, convertedThumb}}

        local message = {
            sender = 3876100107,
            recipient = recipientNumber,
            timestamp = timestamp,
            msgType = 2,
            id = 1,
            state = 1,
        }
        message.imageFilename = imageFilename
        message.metadata = cData
        if not getElementData(source, "smsInbox") then
            setElementData(source, "smsInbox", {})
        end
        local inbox = getElementData(source, "smsInbox")
        table.insert(inbox, message)
        setElementData(source, "smsInbox", inbox)
        triggerClientEvent(source, "gotSMSCache", source, { cacheEntry }, true, true, true)        
    end
end
addEventHandler("traffipaxSMSPicture", root, traffipaxSMSPicture)

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