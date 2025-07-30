local connection = exports.sConnection:getConnection()
local loadedCoupons = {}


function loadAllCoupons(qh)
	local result = dbPoll(qh, 0)

	if result then
		for k, v in pairs(result) do
			loadedCoupons[v.couponName] = {
                couponName = v.couponName,
                couponType = v.couponType,
                couponUsage = v.couponUsage,
                couponValue = v.couponValue,
                couponUsed = fromJSON(v.couponUsed),
				couponItem = v.couponItem
            }
		end
	end
end

addEventHandler("onResourceStart", resourceRoot,
    function ()
        dbQuery(loadAllCoupons, connection, "SELECT * FROM coupons")
    end
)

local typeNames = {
	["pp"] = "PP",
	["money"] = "Pénz",
	["item"] = "Tárgy"
}

local types = {
	[1] = "pp",
	[2] = "money",
	[3] = "item"
}

addEvent("createCoupon", true)
addEventHandler("createCoupon", root, 
	function(couponName, couponMaxValue, selectedCouponType, couponValue, couponItem)
		if getElementData(client, "acc.adminLevel") >= 8 then
			loadedCoupons[couponName] = {
				couponName = couponName,
				couponType = types[selectedCouponType],
				couponUsage = couponMaxValue,
				couponValue = couponValue,
				couponUsed = {},
				couponItem = couponItem or 0
			}

			local couponName = loadedCoupons[couponName].couponName
			local couponType = loadedCoupons[couponName].couponType
			local couponUsage = loadedCoupons[couponName].couponUsage
			local couponValue = loadedCoupons[couponName].couponValue
			local couponUsed = toJSON(loadedCoupons[couponName].couponUsed)
			local couponItem = loadedCoupons[couponName].couponItem

			local sqlQuery = [[
				INSERT INTO coupons (couponName, couponType, couponUsage, couponValue, couponUsed, couponItem) 
				VALUES (?, ?, ?, ?, ?, ?)
			]]

			local success = dbExec(connection, sqlQuery, couponName, couponType, couponUsage, couponValue, couponUsed, couponItem)

			if success then
				outputChatBox("[color=sightgreen][SightMTA - Coupon]:[color=hudwhite] Sikeresen létrehoztad a kupont!", client, 255, 255, 255, true)
			else
				outputChatBox("[color=sightred][SightMTA - Coupon]:[color=hudwhite] Sikertelen kupon létrehozás!", client, 255, 255, 255, true)
			end
		else
        exports.sAnticheat:anticheatBan(client, "AC #1 - sCoupon @sourceS:73")
	end
	end
)

addCommandHandler("createcoupon",
	function (sourcePlayer, commandName)
		if getElementData(sourcePlayer, "acc.adminLevel") >= 8 then
			triggerClientEvent(sourcePlayer, "initCouponCreator", sourcePlayer)
		end
	end
)

addEvent("activateCoupon", true)
addEventHandler("activateCoupon", root, 
	function(couponCode)
		if not couponCode then
			return
		else
			if loadedCoupons[couponCode] then
				local couponDatas = loadedCoupons[couponCode]
				
				for k, v in ipairs(couponDatas.couponUsed) do
					if v == getElementData(client, "char.ID") then
						outputChatBox("[color=sightred][SightMTA - Coupon]:[color=hudwhite] Te már felhasználtad a kupont!", client, 255, 255, 255, true)
						return
					end
 				end

				if #couponDatas.couponUsed < tonumber(couponDatas.couponUsage) then
					outputChatBox("[color=sightgreen][SightMTA - Coupon]:[color=hudwhite] Felhasználtad a kupont! (Típus: [color=sightblue]" ..(couponDatas.couponType).. "[color=hudwhite]) (Mennyiség: [color=sightblue]" ..loadedCoupons[couponCode].couponValue.."[color=hudwhite])", client, 255, 255, 255, true)

					if couponDatas.couponType == "pp" then
						local userPP = exports.sCore:getPP(client)
						exports.sCore:setPP(client, (couponDatas.couponValue + userPP))

					elseif couponDatas.couponType == "money" then
						local userMoney = exports.sCore:getMoney(client)
						exports.sCore:setMoney(client, (couponDatas.couponValue + userMoney))

					elseif couponDatas.couponType == "item" then
						exports.sItems:giveItem(client, couponDatas.couponValue, couponDatas.couponItem, false)

					else
						outputChatBox("[color=sightred][SightMTA - Coupon]:[color=hudwhite] Hiba történt a kupon felhasználása során!", client, 255, 255, 255, true)
						return
					end

					table.insert(couponDatas.couponUsed, getElementData(client, "char.ID"))
					dbExec(connection, "UPDATE coupons SET couponUsed = ? WHERE couponName = ?", toJSON(couponDatas.couponUsed), couponCode)
				else
					outputChatBox("[color=sightred][SightMTA - Coupon]: [color=hudwhite]A kiválasztott kupon elfogyott!", client, 255, 255, 255, true)
				end 
			else
				outputChatBox("[color=sightred][SightMTA - Coupon]: [color=hudwhite]A keresett kóddal kupon nem található!", client, 255, 255, 255, true)
			end
		end
	end
)

addCommandHandler("couponlist", 
	function(sourcePlayer, commandName)
		if getElementData(sourcePlayer, "acc.adminLevel") >= 8 then
			outputChatBox("[color=sightgreen][SightMTA - Coupon]: [color=hudwhite]Elérhető kuponok:", sourcePlayer, 255, 255, 255, true)

			for k, v in pairs(loadedCoupons) do
				outputChatBox("  Kuponkód: [color=sightgreen]" .. v.couponName.. "[color=hudwhite] | Felhasználhatóság: [color=sightgreen]".. v.couponUsage .." | [color=hudwhite]Felhasználva: [color=sightgreen]" .. (v.couponUsage - #v.couponUsed) .. " | [color=hudwhite]Típus: [color=sightgreen]" .. typeNames[v.couponType], sourcePlayer, 255, 255, 255, true)
			end
		end
	end
)