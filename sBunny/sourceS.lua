local specialMoney = 25000

local specialItems = {
	[196] = true,
	[194] = true,
	[197] = true,
}

local x, y, z = 1518.1550292969, -1796.3599853516, 24.02342414856
local ped = createPed(299, x, y, z, 270)
setElementData(ped, "invulnerable", true)
setElementData(ped, "visibleName", "Easter Eggman")
setElementData(ped, "pedNameType", "Leadó")
setElementFrozen(ped, true)

local col = createColSphere(x, y, z, 3)

function colHit(hitElement, matchDim)
	if hitElement and matchDim then
		local playerItems = exports.sItems:getElementItems(hitElement)
		for k, v in pairs(playerItems) do
			if v and v.itemId and specialItems[v.itemId] then
				outputChatBox("[color=sightgreen][SightMTA - Easter] #ffffffSikeresen leadtál egy[color=sightblue] " .. exports.sItems:getItemName(v.itemId) .. "#ffffff-t és kaptál érte[color=sightgreen] 25.000$#ffffff-t.", hitElement)
				exports.sItems:takeItem(hitElement, "dbID", v.dbID)
				exports.sCore:giveMoney(hitElement, specialMoney)
			end
		end
	end
end
addEventHandler("onColShapeHit", col, colHit)

addEvent("tryToStartBunnyOpening", true)
addEventHandler("tryToStartBunnyOpening", getRootElement(),
	function(dbID)
		if exports.sItems:takeItem(source, "dbID", dbID, 1) then
			local itemId = chooseRandomItem()
			local rnd1, rnd2, rnd3, rnd4, rnd5 = 800, 100, 100, 100, 100
	
			triggerClientEvent(source, "startBunnyOpening", source, itemId, rnd1, rnd2, rnd3, rnd4, rnd5)
	
			local time = 28634 + 200
	
			local targetSpinSpeed = rnd1
			local spinAcceleration = rnd2
			local spinDeceleration = rnd3
			local spinStop = targetSpinSpeed / spinAcceleration * 1000 + rnd4
			local spinMin = rnd5
			local spinMin2 = 12.5
			local d = 384
	
			local overallTime = 1 / 3 * 1000 + (2500 * 3) + spinStop + (targetSpinSpeed - spinMin) / spinDeceleration * 1000 + (d / spinMin * 7 + d / spinMin2) / 8 * 1000
			 
			 overallTime = overallTime + 900
	
			 
	
			setTimer(function(player, itemId, dbID)
				if player then
					exports.sItems:giveItem(player, itemId, 1)
				end		
			end, overallTime, 1, source, itemId, dbID)
		else
        	exports.sAnticheat:anticheatBan(client, "AC #131 - sBunny @sourceS:67")
		end
	end
)