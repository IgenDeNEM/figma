local connection = false
local interiorDatas = {}
local useableObjects = {}

local tvDatas = {}

addEventHandler("onDatabaseConnected", getRootElement(),
	function (db)
		connection = db
	end)

addEventHandler("onResourceStart", resourceRoot,
	function (startedRes)
		connection = exports.sConnection:getConnection()

		dbQuery(
			function (qh)
				local result = dbPoll(qh, 0)

				for i = 1, #result do
					local row = result[i]

					interiorDatas[row.interiorId] = row

					toggleUseableFurnitures(row.interiorId, true)
				end
			end,
		connection, "SELECT * FROM interior_datas")

		for _, playerElement in ipairs(getElementsByType("player")) do
			setElementData(playerElement, "currentCustomInterior", nil)
		end
	end)

function loadInterior(thePlayer, interiorId, editInterior, forceLoad)
	local currentInterior = getElementData(thePlayer, "currentCustomInterior") or 0

	if not forceLoad and currentInterior > 0 and currentInterior == interiorId then
		return
	end

	setElementData(thePlayer, "currentCustomInterior", interiorId)

	setElementFrozen(thePlayer, true)
	setElementInterior(thePlayer, 1)
	setElementDimension(thePlayer, interiorId)
	setCameraInterior(thePlayer, 1)

	if editInterior then
		setElementData(thePlayer, "editingInterior", interiorId)
	else
		setElementData(thePlayer, "editingInterior", false)
		setCameraTarget(thePlayer, thePlayer)
	end

	local editable = exports.sInteriors:getInteriorSize(interiorId)


	if not editable then
		return
	end

	if not interiorDatas[interiorId] then
		interiorDatas[interiorId] = {}
		interiorDatas[interiorId].interiorId = interiorId
		interiorDatas[interiorId].paidCash = 0
		interiorDatas[interiorId].interiorData = ""
		interiorDatas[interiorId].dynamicData = ""
		interiorDatas[interiorId].unlockedPP = ""
	end

	local dat = interiorDatas[interiorId]

	if dat then
		if editInterior then
			local ppThings = split(dat.unlockedPP, ",")
			local ppThingsTable = {}

			for i = 1, #ppThings do
				local model = tonumber(ppThings[i])
				ppThingsTable[model] = (ppThingsTable[model] or 0) + 1
			end

			toggleUseableFurnitures(interiorId, false)

			triggerClientEvent(thePlayer, "intiEdit:onInteriorLoaded", thePlayer, interiorId, dat.interiorData, true, editable, dat.paidCash, dat.dynamicData, ppThingsTable)
			triggerClientEvent(thePlayer, "refreshMoney", thePlayer, exports.sCore:getMoney(thePlayer))
		else
			triggerClientEvent(thePlayer, "intiEdit:onInteriorLoaded", thePlayer, interiorId, dat.interiorData, false, editable, 0, dat.dynamicData, {})
		end
	end
end

registerEvent("intiEdit:exitInterior", getRootElement(), function(exitType)
	if isElement(source) and source == client then
		if exitType and exitType == "edit" then
			local interiorId = getElementData(source, "currentCustomInterior") or 0

			if interiorId > 0 then
				setElementData(source, "editingInterior", false)
				setElementData(source, "currentCustomInterior", false)

				setCameraTarget(source, source)
				setElementFrozen(source, false)

				local x, y, z, int, dim, rz = exports.sInteriors:getInteriorOutsidePosition(interiorId)

				setElementPosition(source, x, y, z)
				setElementRotation(source, 0, 0, rz)
				setElementInterior(source, int)
				setElementDimension(source, dim)

				setElementAlpha(source, 255)

				toggleUseableFurnitures(interiorId, true)
			end
		else
			local interiorId = getElementData(source, "currentCustomInterior") or 0

			if interiorId > 0 then
				setElementData(source, "editingInterior", false)
				setElementData(source, "currentCustomInterior", false)

				setCameraTarget(source, source)
				setElementFrozen(source, false)

				local x, y, z, int, dim, rz = exports.sInteriors:getInteriorOutsidePosition(interiorId)

				setElementPosition(source, x, y, z)
				setElementRotation(source, 0, 0, rz)
				setElementInterior(source, int)
				setElementDimension(source, dim)
				setElementAlpha(source, 255)

				toggleUseableFurnitures(interiorId, true)
			end
		end
	end
end)

registerEvent("intiEdit:loadInterior", getRootElement(), function (interiorId, editInterior)
	if isElement(source) and interiorId then
		loadInterior(source, interiorId, editInterior, true)
		if editInterior then
			setElementAlpha(source, 0)
		end
	end
end)

registerEvent("unfreezeInteriorEditable", getRootElement(), function()
	setElementFrozen(client, false)
end)

registerEvent("intiEdit:saveInterior", getRootElement(), function (interiorId, interiorData, costs)
	if isElement(source) then
		if interiorId and interiorData then
			local x, y, z, int, dim, rz = exports.sInteriors:getInteriorOutsidePosition(interiorId)
			local currCosts = costs - interiorDatas[interiorId].paidCash

			if currCosts > 0 then
				exports.sCore:takeMoney(source, currCosts)
			else
				exports.sCore:giveMoney(source, currCosts)
			end

			interiorDatas[interiorId].paidCash = costs
			interiorDatas[interiorId].interiorData = interiorData

			toggleUseableFurnitures(interiorId, true)

			setElementPosition(source, x, y, z)
			setElementRotation(source, 0, 0, (rot or 0))
			setElementInterior(source, int)
			setElementDimension(source, dim)
			setElementAlpha(source, 255)


			dbExec(connection, "UPDATE interior_datas SET paidCash = ?, interiorData = ? WHERE interiorId = ?", costs, interiorData, interiorId)
		end
	end
end)

function toggleUseableFurnitures(interiorId, state)
	local dat = interiorDatas[interiorId]

	for k, v in pairs(useableObjects) do
		if (getElementData(v, "radioFurniture") or getElementData(v, "tvFurniture")) == interiorId then
			if isElement(v) then
				destroyElement(v)
			end

			useableObjects[k] = nil
		end
	end

	if dat and state then
		local furnitures = gettok(dat.interiorData, 8, ";")

		if furnitures ~= "-" and furnitures then
			local datas = split(furnitures, "/")

			for i = 1, #datas, 5 do
				local model = tonumber(datas[i])

				if hiFis[model] or useableTvs[model] then
					local obj = createObject(model, datas[i+1], datas[i+2], datas[i+3], 0, 0, datas[i+4])

					if isElement(obj) then
						setElementDoubleSided(obj, true)
						setElementInterior(obj, 1)
						setElementDimension(obj, interiorId)
						table.insert(useableObjects, obj)

						if hiFis[model] then
							setElementData(obj, "radioFurniture", interiorId)
						elseif useableTvs[model] then
							setElementData(obj, "tvFurniture", interiorId)
						end
					end
				end
			end
		end
	end
end

registerEvent("intiEdit:updateDynamicData", getRootElement(), function (interiorId, data, affected)
	if interiorId and data then
		if interiorDatas[interiorId] then
			interiorDatas[interiorId].dynamicData = data

			triggerClientEvent(affected, "intiEdit:updateDynamicData", resourceRoot, data, true)

			dbExec(connection, "UPDATE interior_datas SET dynamicData = ? WHERE interiorId = ?", data, interiorId)
		end
	end
end)

registerEvent("intiEdit:placeSafe", getRootElement(), function (dat, safeType)
	if source == client and dat and safeType then
		local interiorId = getElementData(source, "editingInterior") or 0

		if interiorId > 0 then
			local currBalance = exports.sCore:getPP(client)

			currBalance = currBalance - safePrices[safeType]

			if currBalance >= 0 then
				exports.sItems:createSafe(source, "0", {dat[2], dat[3], dat[4], dat[7], 1, interiorId, safeType:gsub("v4_safe", "")})
			else
				exports.sGui:showInfobox(source, "e", "Nincs elég prémium pontod!")
			end
		end
	end
end)

registerEvent("intiEdit:placeBilliard", getRootElement(), function (dat)
	if source == client and dat then
		local interiorId = getElementData(source, "editingInterior") or 0

		if interiorId > 0 then
			local currBalance = exports.sCore:getPP(client)

			currBalance = currBalance - prices.furnitures[2964]

			if currBalance >= 0 then

				triggerEvent("placeThePoolTable", source, {dat[3], dat[4], dat[5], dat[6], 1, interiorId})

				dbExec(connection, "UPDATE accounts SET premiumPoints = ? WHERE accountId = ?", currBalance, getElementData(source, "char.accID"))
			else
				exports.sGui:showInfobox(source, "e", "Nincs elég prémium pontod!")
			end
		end
	end
end)

registerEvent("intiEdit:buyPPFurniture", getRootElement(), function (interiorId, model)
	if source == client and interiorId and model then
		local currBalance = exports.sCore:getPP(client)

		currBalance = currBalance - prices.furnitures[model]

		if currBalance >= 0 then
			exports.sCore:setPP(client, currBalance)

			interiorDatas[interiorId].unlockedPP = interiorDatas[interiorId].unlockedPP .. model .. ","

			local ppThings = split(interiorDatas[interiorId].unlockedPP, ",")
			local ppThingsTable = {}

			for i = 1, #ppThings do
				local model = tonumber(ppThings[i])
				ppThingsTable[model] = (ppThingsTable[model] or 0) + 1
			end

			triggerClientEvent(source, "intiEdit:gotPPThings", source, ppThingsTable)

			dbExec(connection, "UPDATE interior_datas SET unlockedPP = ? WHERE interiorId = ?", interiorDatas[interiorId].unlockedPP, interiorId)
			dbExec(connection, "UPDATE accounts SET premiumPoints = ? WHERE accountId = ?", currBalance, getElementData(source, "char.accID"))

			exports.sGui:showInfobox(source, "s", "Sikeres vásárlás!")
		else
			exports.sGui:showInfobox(source, "e", "Nincs elég prémium pontod!")
		end
	end
end)

registerEvent("intiEdit:requestTV", getRootElement(), function ()
	if isElement(source) then
		local interiorId = getElementDimension(source)
		if tvDatas[interiorId] then
			local streamURL = tvDatas[interiorId][1]
			local startTime = tvDatas[interiorId][2]
			if streamURL and startTime then
				triggerClientEvent(client, "intiEdit:playMovieC", source, streamURL, getRealTime().timestamp - startTime)
			end
		end
	end
end)

registerEvent("intiEdit:stopMovie", getRootElement(), function (interiorId)
	if isElement(source) and interiorId then
		local affected = {}

		for k, v in pairs(getElementsByType("player")) do
			if getElementInterior(v) == 1 and getElementDimension(v) == interiorId then
				table.insert(affected, v)
			end
		end

		tvDatas[interiorId] = nil
		triggerClientEvent(affected, "intiEdit:playMovieC", source, false, false)
	end
end)

registerEvent("intiEdit:movieTime", getRootElement(), function (interiorId, time)
	if isElement(source) and time and interiorId then
		local affected = {}

		for k, v in pairs(getElementsByType("player")) do
			if getElementInterior(v) == 1 and getElementDimension(v) == interiorId then
				table.insert(affected, v)
			end
		end

		if tvDatas[interiorId] then
			tvDatas[interiorId][2] = (tvDatas[interiorId][2]) + (time or 0)
			url = tvDatas[interiorId][1]
		end
		triggerClientEvent(affected, "intiEdit:playMovieC", source, url, time)
	end
end)

registerEvent("intiEdit:playMovie", getRootElement(), function (url, interiorId, time)
	if isElement(source) and url and interiorId then
		local url = url:gsub("&list=(.+)", "") or url
		local id = url:match("v=(.+)&") or url:match("v=(.+)#") or url:match("v=(.+)") or url:match("tu.be/(.+)#") or url:match("tu.be/(.+)?") or url:match("tu.be/(.+)")


		id = url

		if url and id then
			local affected = {}

			for k, v in pairs(getElementsByType("player")) do
				if getElementInterior(v) == 1 and getElementDimension(v) == interiorId then
					table.insert(affected, v)
				end
			end
			if id then
				tvDatas[interiorId] = {id, getRealTime().timestamp}
			end
			time = time or 0
			if time < 0 then
				time = 0
			end

			triggerClientEvent(affected, "intiEdit:playMovieC", source, id, time)
		else
			exports.sHud:showInfobox(client, "e", "Érvénytelen URL! Kérlek próbálj másikat.")
		end
	end
end)