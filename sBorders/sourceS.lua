function rotateAround(angle, x, y, x2, y2)
	local theta = math.rad(angle)
	local rotatedX = x * math.cos(theta) - y * math.sin(theta) + (x2 or 0)
	local rotatedY = x * math.sin(theta) + y * math.cos(theta) + (y2 or 0)
	return rotatedX, rotatedY
end

local bollards = {}
local borderOffset = 1.5
local borderOpenTime = 2000
local borderCloseTime = 1500

addEventHandler("onResourceStart", resourceRoot,
	function()
		for key, value in ipairs(borders) do
			local size = value.size
			local angle = value.pos[4]
			local posX, posY, posZ = value.pos[1], value.pos[2], value.pos[3]
			bollards[key] = {}

			for k, v in ipairs(sizes[size]) do
				local rotatedX, rotatedY = rotateAround(angle, v, 0)

				bollards[key][k] = createObject(1214, posX + rotatedX, posY + rotatedY, posZ)
				setObjectBreakable(bollards[key][k], false)
				setElementFrozen(bollards[key][k], true)
			end
		end
	end
)

addEvent("requestBorderManual", true)
addEventHandler("requestBorderManual", getRootElement(),
	function()
        for i = 1, #bollards do
		    triggerClientEvent("changeBorderManual", client, i, bollards[i].manual, bollards[i].opened, bollards[i].name)
        end
	end
)

addEvent("changeBorderManual", true)
addEventHandler("changeBorderManual", getRootElement(),
	function(i, manual, opened, name)
        if opened then
			bollards[i].forceopen = true
            toggleBorder(i)
		else
			if manual or not opened then
				bollards[i].forceopen = false
				toggleBorder(i, true)
			end
		end
        bollards[i].manual = manual
        bollards[i].opened = opened
        bollards[i].name = name
		triggerClientEvent("changeBorderManual", client, i, manual, opened, getElementData(client, "visibleName"):gsub("_", " "))
	end
)

addEvent("payBorderCrossing", true)
addEventHandler("payBorderCrossing", root,
	function(inBorderCol)
		local payState = false
		local vehicle = getPedOccupiedVehicle(client)
		local vehModel = getElementModel(vehicle)
		local vehPlate = getVehiclePlateText(vehicle)

		local warrantVeh = exports.sMdc:checkVehicleWarrantTraffipax(vehicle)
		local playerName = utf8.gsub(getElementData(client, "visibleName"), "_", " ")
		local warrantPlayer = exports.sMdc:checkPlayerWarrantTraffipax(client)

		if getElementData(client, "char.level") <= 3 then
			payState = true
		else
			local currentBalance = exports.sCore:getMoney(client) or 0
			local newBalance = currentBalance

			newBalance = newBalance - borders[inBorderCol].price

			if newBalance >= 0 then
				payState = true

				exports.sCore:setMoney(client, newBalance)
			else
				triggerClientEvent(client, "showInfobox", client, "error", "Nincs elég pénzed (" .. borders[inBorderCol].price .. " $)")
			end
		end

		if payState then
			if warrantPlayer[1] then
				triggerClientEvent(root, "borderWarrantAlert", vehicle, playerName, inBorderCol, warrantPlayer)
			end

			local colorR1, colorG1, colorB1, colorR2, colorG2, colorB2 = getVehicleColor(vehicle, true)

			if warrantVeh[1] then
				triggerClientEvent(root, "borderCrossingMessage", vehicle, vehModel, vehPlate, inBorderCol, warrantVeh, {colorR1, colorG1, colorB1}, {colorR2, colorG2, colorB2})
			else
				triggerClientEvent(root, "borderCrossingMessage", vehicle, vehModel, vehPlate, inBorderCol, false, {colorR1, colorG1, colorB1}, {colorR2, colorG2, colorB2})
			end

			triggerClientEvent(client, "closeBorderWindow", client)
			toggleBorder(inBorderCol)
		end
	end
)

function toggleBorder(id, close)
	if bollards[id] and not bollards[id].opened then
		for key, value in ipairs(bollards[id]) do
			local posX, posY, posZ = getElementPosition(value)

			moveObject(value, borderOpenTime, posX, posY, posZ - borderOffset)
			if not bollards[id].forceopen then
				setTimer(moveObject, (borderCloseTime * 2) + borderOpenTime, 1, value, borderCloseTime, posX, posY, posZ)
			end
		end
	end
	if close then
		for key, value in ipairs(bollards[id]) do
			local posX, posY, posZ = getElementPosition(value)
			if not bollards[id].forceopen then
				setTimer(moveObject, (borderCloseTime * 2) + borderOpenTime, 1, value, borderCloseTime, posX, posY, borders[id]["pos"][3])
			end
		end
	end
end