local medicBags = {}
local createdMedicBags = 0

function createMedicBag(sourcePlayer, num, omsz)
	if sourcePlayer then
		local playerPosX, playerPosY, playerPosZ = getElementPosition(sourcePlayer)
		local playerInterior, playerDimension = getElementInterior(sourcePlayer), getElementDimension(sourcePlayer)
		
		createdMedicBags = createdMedicBags + 1
		
		medicBags[createdMedicBags] = {playerPosX, playerPosY, playerPosZ - 0.85, playerInterior, playerDimension, num, sourcePlayer, omsz}
		
		triggerClientEvent("gotMedicBag", sourcePlayer, createdMedicBags, playerPosX, playerPosY, playerPosZ - 0.85, playerInterior, playerDimension, num)
	end
end

local msegitDatas = {}

addCommandHandler("msegit", function(sourcePlayer, sourceCommand)
	if getElementHealth(sourcePlayer) <= 20 and getElementHealth(sourcePlayer) > 0 then
		local function getActiveMembers(groupPrefix)
			helperCount = 0
			for k, v in ipairs(getElementsByType("player")) do
				if exports.sGroups:isPlayerInGroup(v, "OMSZ") then
					helperCount = helperCount + 1
				end
			end
			return helperCount
		end
		
		local helperCount = getActiveMembers("OMSZ")
		if helperCount >= 5 then
			outputChatBox("[color=sightred][SightMTA - Hiba] Jelenleg van elérhető mentős szolgálatban!", sourcePlayer)
			return
		end
		
		if not msegitDatas[sourcePlayer] then
			msegitDatas[sourcePlayer] = {}
		end
		
		msegitDatas[sourcePlayer].bypass = true
		msegitDatas[sourcePlayer].trytick = getTickCount()
		triggerClientEvent(sourcePlayer, "startReviveMinigame", sourcePlayer, "revive", false)
	else
		exports.sGui:showInfobox(sourcePlayer, "e", "Csak animban használhatod ezt a parancsot!")
	end
end)

addEvent("deleteMedicBag", true)
addEventHandler("deleteMedicBag", root, 
function(bagId)
	if bagId then
		if medicBags[bagId][7] == client and not exports.sPermission:hasPermission(client, "vanish") then
			if medicBags[bagId][6] - 1 > 0 and medicBags[bagId][8] then
				exports.sItems:giveItem(client, 100, 1, false, 10 - medicBags[bagId][6] + 1)
			end
			medicBags[bagId] = bagId
			
			exports.sChat:localAction(client, "felvesz a földről egy esettáskát.")
			triggerClientEvent("gotMedicBag", client, medicBags[bagId])
		else
			exports.sGui:showInfobox(client, "e", "Ez az esettáska nem a tiéd!")
		end
	end
end
)

local playerFixings = {}

local boneIds = {
	[1] = true,
	[2] = true, 
	[3] = true,
	[4] = true
}

addEvent("useAdrenaline", true)
addEventHandler("useAdrenaline", root, 
function(hoveredPlayer)
	if isElement(hoveredPlayer) then
		if exports.sItems:hasItem(client, 592) then
			setElementData(hoveredPlayer, "adrenaline", true)
			exports.sGui:showInfobox(client, "s", "Sikeresen beadtad az adrenalin injekciót!")
			exports.sChat:localAction(client, "bead egy adrenalin injekciót.")
			exports.sItems:takeItem(client, "itemId", 592, 1)
		else
			exports.sGui:showInfobox(client, "e", "Nincs nálad adrenalin injekció!")
		end
	end
end
)

addEvent("endPlayerFixingUp", true)
addEventHandler("endPlayerFixingUp", root, 
function(success, bagId)
	if success and bagId then
		local fixingPlayer = playerFixings[client]
		
		local hoveredPlayerName = getElementData(fixingPlayer[1], "visibleName"):gsub("_", " ")
		local clientName = getElementData(client, "visibleName"):gsub("_", " ")
		
		exports.sGui:showInfobox(fixingPlayer[1], "s", clientName.." sikeresen ellátta egy sérülésed.")
		exports.sGui:showInfobox(client, "s", "Sikeresen elláttad "..hoveredPlayerName.. " sérülését.")
		exports.sChat:localAction(client, "sikeresen ellátta "..hoveredPlayerName.." sérülését.")
		if fixingPlayer[3] == "bone" then
			local damages = getElementData(fixingPlayer[1], "bodyDamage") or {}
			damages[fixingPlayer[2]] = false
			setElementData(fixingPlayer[1], "bodyDamage", damages)
		elseif fixingPlayer[3] == "blood" then
			local damages = getElementData(fixingPlayer[1], "bloodDamage") or {}
			damages[fixingPlayer[2]] = 0
			setElementData(fixingPlayer[1], "bloodDamage", damages)
		elseif fixingPlayer[3] == "revive" then
			setElementHealth(fixingPlayer[1], 50)
			setElementData(fixingPlayer[1], "bodyDamage", false)
			setElementData(fixingPlayer[1], "bloodDamage", false)
		end
		
		medicBags[bagId][6] = medicBags[bagId][6] - 1
		triggerClientEvent("updateMedicBag", root, bagId, medicBags[bagId][6])
		
		playerFixings[client] = nil
	elseif success and msegitDatas[client] and msegitDatas[client].bypass then
		msegitDatas[client].bypass = false
		exports.sGui:showInfobox(client, "s", "Sikeresen elláttad a sérüléseidet!.")
		setElementHealth(client, 50)
		local damages = getElementData(client, "bodyDamage") or {}
		damages[client] = false
		setElementData(client, "bodyDamage", damages)
		setElementData(client, "bloodDamage", false)
	elseif not succes and msegitDatas[client] and msegitDatas[client].bypass then
		msegitDatas[client].bypass = false
		exports.sGui:showInfobox(client, "e", "Elrontottad a felsegítést, így meghaltál!.")
		setElementHealth(client, 0)
	end
end
)

addEvent("startPlayerFixingUp", true)
addEventHandler("startPlayerFixingUp", root, 
function(hoveredPlayer, hoveredBodypart)
	if hoveredPlayer and hoveredBodypart then
		local hoveredPlayerName = getElementData(hoveredPlayer, "visibleName"):gsub("_", " ")
		local hoveredPlayerBleeding = getElementData(hoveredPlayer, "bloodDamage") or {}
		local canStartRevive = true
		if not hoveredPlayerBleeding then
			canStartRevive = true
		end
		
		for k, v in pairs(hoveredPlayerBleeding) do
			if v and tonumber(v) and tonumber(v) > 0 then
				canStartRevive = false
			end
		end
		
		exports.sChat:localAction(client, "elkezdte ellátni "..hoveredPlayerName.." sérülését.")
		if hoveredPlayerBleeding[hoveredBodypart] and hoveredPlayerBleeding[hoveredBodypart] > 0 then
			playerFixings[client] = {hoveredPlayer, hoveredBodypart, "blood"}
			
			triggerClientEvent(client, "startReviveMinigame", client, "blood")
		elseif boneIds[hoveredBodypart] then
			playerFixings[client] = {hoveredPlayer, hoveredBodypart, "bone"}
			
			triggerClientEvent(client, "startReviveMinigame", client, "bone")
		elseif canStartRevive then
			playerFixings[client] = {hoveredPlayer, hoveredBodypart, "revive"}
			triggerClientEvent(client, "startReviveMinigame", client, "revive")
		end
	end
end
)

addEvent("examinePlayerAnimation", true)
addEventHandler("examinePlayerAnimation", root, 
function(animationTime)
	if animationTime then
		setPedAnimation(client, "bomber", "bom_plant", animationTime, true, false, false, false)
	end
end
)

addEvent("requestMedicBags", true)
addEventHandler("requestMedicBags", resourceRoot, function()
	triggerClientEvent(client, "gotMedicBags", client, medicBags)
end)