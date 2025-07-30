local drugTypes = {}

local loadAmmoTimers = {}

local targets = {}

local playerCurrentWeapon = {}
local weaponHeats = {}
local weaponDatas = {}
local overheatedWeapons = {}

addEvent("setPhysgunTarget", true)
addEventHandler("setPhysgunTarget", getRootElement(),
	function(dat, was, x, y, z)
		if not dat then 
			setElementFrozen(targets[client], false)
		end

		targets[client] = dat
		if dat then
			triggerClientEvent(root, "setPhysgunTarget", client, {dat, was}, false, x, y, z)
		else
			triggerClientEvent(root, "setPhysgunTarget", client)
		end
	end
)

addEvent("syncCanAmmo", true)
addEventHandler("syncCanAmmo", root, 
	function(canAmmo)
	end
)

addEvent("physgunPosSync", true)
addEventHandler("physgunPosSync", getRootElement(),
	function(x, y, z)
		triggerClientEvent(root, "physgunPosSync", client, targets[client], x, y, z)

		setElementFrozen(targets[client], true)
	end
)

addEvent("physgunDistSync", true)
addEventHandler("physgunDistSync", getRootElement(),
	function(dat)
		triggerClientEvent(root, "physgunDistSync", client, targets[client], dat)
	end
)

addEvent("requestPhysgunTargets", true)
addEventHandler("requestPhysgunTargets", getRootElement(),
	function()
		triggerClientEvent(client, "gotPhysgunTargets", client, targets)
	end
)

function playerDamage(attacker, weapon, bodypart, loss)
	if attacker and isElement(attacker) and getElementData(attacker, "airsoftgun") then
		cancelEvent()
		return
	end
	if attacker and source and weapon then
		if weapon == 8 or weapon == 4 then
			local bodypart = bodypart - 2
			local bloodDamage = getElementData(source, "bloodDamage") or {0, 0, 0, 0, 0}
			bloodDamage[bodypart] = ((bloodDamage[bodypart] or 0) + (loss * 100))
			setElementData(source, "bloodDamage", bloodDamage)
		end
		local customWP = getElementData(attacker, "customWeapon")
		if customWP and customWP == "wep_vipera" then
			local damages = getElementData(source, "bodyDamage") or {}
			local bodypart = math.random(5, 8)
			local bodypart = bodypart - 4
			if not damages[bodypart] then
				damages[bodypart] = true
				setElementData(source, "bodyDamage", damages)
				local bodypart = bodypart + 4
				if bodypart == 5 then
					exports.sGui:showInfobox(source, "w", "Megsérült a bal kezed!")
				elseif bodypart == 6 then
					exports.sGui:showInfobox(source, "w", "Megsérült a jobb kezed!")
				elseif bodypart == 7 then
					exports.sGui:showInfobox(source, "w", "Megsérült a bal lábad!")
				elseif bodypart == 8 then
					exports.sGui:showInfobox(source, "w", "Megsérült a jobb lábad!")
				end
			end
		end
	end
end
addEventHandler("onPlayerDamage", root, playerDamage)

addEvent("selfWeaponDamage", true)
addEventHandler("selfWeaponDamage", getRootElement(), function(attacker, wep, bodypart, loss)
	if getElementData(attacker, "airsoftgun") then
		triggerEvent("airsoftDamage", source, attacker, wep, bodypart, loss)
		return
	end
	local health = getElementHealth(client)
	local armor = getPedArmor(client)
	local calculatedLoss = loss * customWeapons[wep].damage
	local rampage, drugType = exports.sDrugs:getPlayerRampage(client)

	local attackerName = getElementData(attacker, "visibleName")

	local veh = getPedOccupiedVehicle(client)

	if veh and getElementModel(veh) == 528 then

		return
	end

	if wep == "knife" or wep == "katana" then
		local bloodDamage = getElementData(client, "bloodDamage") or {0, 0, 0, 0, 0}
		local bodypart = bodypart - 2
		bloodDamage[bodypart] = ((bloodDamage[bodypart] or 0) + (loss * 100))
		setElementData(client, "bloodDamage", bloodDamage)
	end

	if rampage > 0 then
		local rampageloss = (calculatedLoss / 50) * drugTypes[drugType].damageLoss
		exports.sDrugs:setPlayerRampage(client, drugType, rampage - (calculatedLoss / 50) * drugTypes[drugType].damageLoss)


		if (rampage - rampageloss) * 100 < 0 then
			local calcHp = (rampage - rampageloss) * 100
			setElementHealth(client, health + calcHp)
		end
	else
		if bodypart == 9 then
			setElementData(client, "customDeath", {attacker, true, exports.sItems:getItemName(getMainItemID(wep)), exports.sRadar:getZoneName(getElementPosition(client)), "Fejbelőtték"})
			setElementData(client, "deathReason", "Fegyver: " .. exports.sItems:getItemName(getMainItemID(wep)))
			setElementData(client, "canNotSpawn", true)
			setElementHealth(client, 0)
		else
			if getPedArmor(client) > 0 then
				local newArmor = armor - calculatedLoss

				if newArmor < 0 then
					setElementHealth(client, health + newArmor)
					setPedArmor(client, 0)
				else
					setPedArmor(client, newArmor)
				end

				triggerEvent("updateActiveArmorHealth", client, math.max(0, newArmor))
			else

				local bloodDamage = getElementData(client, "bloodDamage") or {0, 0, 0, 0, 0}
				local bodypart = bodypart - 2
				bloodDamage[bodypart] = ((bloodDamage[bodypart] or 0) + (loss * 100))
				setElementData(client, "bloodDamage", bloodDamage)


				local bodypart = bodypart - 2

				local damages = getElementData(client, "bodyDamage") or {}
				damages[bodypart] = true
				setElementData(client, "bodyDamage", damages)

				if bodypart == 5 then
					exports.sGui:showInfobox(client, "w", "Megsérült a bal kezed!")
				elseif bodypart == 6 then
					exports.sGui:showInfobox(client, "w", "Megsérült a jobb kezed!")
				elseif bodypart == 7 then
					exports.sGui:showInfobox(client, "w", "Megsérült a bal lábad!")
				elseif bodypart == 8 then
					exports.sGui:showInfobox(client, "w", "Megsérült a jobb lábad!")
				end

				if getElementHealth(client) - (loss * customWeapons[wep].damage) <= 0 then
					setElementData(client, "customDeath", {attacker, false, exports.sItems:getItemName(getMainItemID(wep)), exports.sRadar:getZoneName(getElementPosition(client)), "Lelőtték"})
					setElementData(client, "deathReason", "Fegyver: " .. exports.sItems:getItemName(getMainItemID(wep)))
				end

				setElementHealth(client, getElementHealth(client) - loss * customWeapons[wep].damage)
			end
		end
	end
end)

playerTaserTimers = {}

addEventHandler("onPlayerWeaponFire", getRootElement(), function(weapon, ex, ey, ez, hitElement, sx, sy, sz)
	if playerCurrentWeapon[source] and not getElementData(source, "hasTaser") then
		if playerCurrentWeapon[source] ~= "airsoft" then
			triggerEvent("takeActiveAmmo", source)
			
			local dbID = playerCurrentWeapon[source]
			if dbID then
				if not weaponHeats[dbID] then
					weaponHeats[dbID] = 0
				end
				if customWeapons[weaponDatas[dbID].weapon].heating then
					weaponHeats[dbID] = math.min(1, weaponHeats[dbID] + customWeapons[weaponDatas[dbID].weapon].heating)
				end

				local heat = weaponHeats[dbID]
				if heat >= 1 then
					
					overheatedWeapons[dbID] = true

					-- ez volt kiszedve belőle idk miért

					local randomOverheat = math.random(1, 5)
					exports.sItems:updateItemData1(source, dbID, exports.sItems:getItemData1(source, dbID) + randomOverheat)
					if exports.sItems:getItemData1(source, dbID) >= 100 then
						exports.sItems:takeItem(source, "dbID", dbID)
						giveWeaponFromItems(source)
					end
		
					exports.sItems:enableWeaponFire(source, false)
					triggerClientEvent(getRootElement(), "weaponOverheatSound", source)
				end
			end
		end
	elseif getElementData(source, "hasTaser") and playerCurrentWeapon[source] then
		local dbID = playerCurrentWeapon[source]

		if customWeapons[weaponDatas[dbID].weapon].modelName and customWeapons[weaponDatas[dbID].weapon].modelName == "wep_taser_x26" then

			triggerClientEvent(source, "gotTaserDischarge", source)

			exports.sControls:toggleControl(source, "fire", false)

			playerTaserTimers[source] = setTimer(function(client)
				if isElement(client) then
					exports.sControls:toggleControl(client, "fire", true)
				end
			end, 10000, 1, source)
		end
	end
end)

addCommandHandler("toglaser", 
	function(sourcePlayer, commandName, laserColor)
		local laserColor = tonumber(laserColor)

		if laserColor and laserColor > 0 and laserColor < 8 then
			setElementData(sourcePlayer, "weaponLaserState", laserColor)
		else
			setElementData(sourcePlayer, "weaponLaserState", 0)
		end
	end
)

function giveWeaponFromItems(thePlayer, weapon, givenAmmoCount, ammoDbID, weaponDbID, item, airsoft)
	if weapon and weapon ~= "airsoftDeath" then
		if weapon ~= "wep_taser_x26" and isTimer(playerTaserTimers[thePlayer]) then
			exports.sControls:toggleControl(thePlayer, "fire", true)
		elseif weapon == "wep_taser_x26" and isTimer(playerTaserTimers[thePlayer]) then
			exports.sControls:toggleControl(thePlayer, "fire", false)
			local details = getTimerDetails(playerTaserTimers[thePlayer])
			killTimer(playerTaserTimers[thePlayer])
			playerTaserTimers[thePlayer] = setTimer(function(thePlayer)
				if isElement(thePlayer) then
					exports.sControls:toggleControl(thePlayer, "fire", true)
				end
			end, details, 1, thePlayer)
		end
		if getElementData(thePlayer, "cuffed") then
			outputChatBox("[color=sightred][SightMTA - Hiba] [color=sighthudwhite]Nem tudsz megbilincselve célozni!", thePlayer)
			return
		end
		
		local weaponId = getWeaponId(weapon)

		if airsoft then
			givenAmmoCount = 9999999
			exports.sItems:enableWeaponFire(thePlayer, true)
			playerCurrentWeapon[thePlayer] = "airsoft"
			setElementData(thePlayer, "airsoftgun", (exports.sItems:getItemName(item):gsub("%(.-%)", "")))
		else
			playerCurrentWeapon[thePlayer] = weaponDbID
			setTimer(function(thePlayer)
				if isElement(thePlayer) then
					setElementData(thePlayer, "airsoftgun", false)
				end
			end, 100, 1, thePlayer)
		end

		giveWeapon(thePlayer, weaponId, givenAmmoCount, true)
		
		local skillStat = getElementData(thePlayer, "char.skills") or {}
		
		if customWeapons[weapon].laser then
			exports.sGui:showInfobox(thePlayer, "i", "A fegyver lézerének ki/be kapcsolásához használd a /toglaser parancsot. Színváltáshoz: /toglaser [1-7]")
		end

		if weaponStatIds[weaponId] then
			if skillStat[weapon] then
				setPedStat(thePlayer, weaponStatIds[weaponId], math.min(999, skillStat[weapon] * 10))
			else
				setPedStat(thePlayer, weaponStatIds[weaponId], 0)
			end
		end

		if isTimer(loadAmmoTimers[thePlayer]) then
			killTimer(loadAmmoTimers[thePlayer])
		end
		
		if ammoDbID then
			reloadPedWeapon(thePlayer)
			setTimer(reloadPedWeapon, 100, 1, thePlayer)

			local reloadTime = 1500

			if weaponId == 25 or weaponId == 34 then
				reloadTime = 0
			end

			loadAmmoTimers[thePlayer] = setTimer(function(thePlayer, ammoDbID, weaponDbID)
				if not overheatedWeapons[weaponDbID] then
					exports.sItems:enableWeaponFire(thePlayer, true)
				end
				triggerClientEvent(thePlayer, "gotCurrentWeaponAmmo", thePlayer, ammoDbID, weaponDbID)

				loadAmmoTimers[thePlayer] = nil
			end, reloadTime, 1, thePlayer, ammoDbID, weaponDbID)
		end

		setControlState(thePlayer, "aim_weapon", false)

		setElementData(thePlayer, "customWeapon", weapon)

		if not weaponHeats[weaponDbID] then
			weaponHeats[weaponDbID] = 0
		end

		if not weaponDatas[weaponDbID] then
			weaponDatas[weaponDbID] = {
				weapon = weapon,
				owner = thePlayer
			}
		end

		if overheatedWeapons[weaponDbID] then
			exports.sItems:enableWeaponFire(thePlayer, false)
		end
		triggerClientEvent(thePlayer, "gotCurrentWeapon", thePlayer, weapon, item, weaponHeats[weaponDbID], overheatedWeapons[weaponDbID])
	else
		if isElement(thePlayer) then
			takeAllWeapons(thePlayer)
			setElementData(thePlayer, "customWP", false)
			setElementData(thePlayer, "customWeapon", false)
			
			playerCurrentWeapon[thePlayer] = nil

			triggerClientEvent(thePlayer, "gotCurrentWeapon", thePlayer)
			triggerClientEvent(thePlayer, "gotCurrentWeaponAmmo", thePlayer)
			exports.sWeapons:removeAmmoLoadTimer(thePlayer)
		end
		if weapon == "airsoftDeath" then
			setTimer(function(thePlayer)
				if not playerCurrentWeapon[thePlayer] then
					if isElement(thePlayer) then
						setElementData(thePlayer, "airsoftgun", false)
					end
				end
			end, 1000, 1, thePlayer)
		end
	end
end

function manageWeaponHeats()
	for dbID, heat in pairs(weaponHeats) do
		local weaponDatas = weaponDatas[dbID]

		if heat > 0 then
			local cooling = customWeapons[weaponDatas.weapon].cooling / 10

			weaponHeats[dbID] = math.max(0, heat - cooling)

			if weaponHeats[dbID] <= 0 then
				if overheatedWeapons[dbID] then
					overheatedWeapons[dbID] = nil
					if weaponDatas.owner and isElement(weaponDatas.owner) then
						exports.sItems:enableWeaponFire(weaponDatas.owner, true)
						triggerClientEvent(getRootElement(), "weaponCooldownSound", weaponDatas.owner)
					end
				end
			end
		end
	end
end

function removeAmmoLoadTimer(thePlayer)
	if isTimer(loadAmmoTimers[thePlayer]) then
		killTimer(loadAmmoTimers[thePlayer])
	end

	loadAmmoTimers[thePlayer] = nil
end

addCommandHandler("reloadmyweapon", function(sourcePlayer)
	reloadPedWeapon(sourcePlayer)
end)

addEventHandler("onResourceStart", getRootElement(), function(res)
	if res == getThisResource() then
		for weaponID in pairs(weaponStatIds) do
			for _, weaponSkill in pairs({"poor", "std", "pro"}) do
				if setWeaponPropertyFlag(weaponID, weaponSkill, "0x000800", false) then
					setWeaponProperty(weaponID, weaponSkill, "maximum_clip_ammo", math.floor(getOriginalWeaponProperty(weaponID, weaponSkill, "maximum_clip_ammo") / 2))
				end
			end
		end

		drugTypes = exports.sDrugs:getDrugTable()
		setTimer(manageWeaponHeats, 100, 0)
	else
		local resName = getResourceName(res)

		if resName == "sDrugs" then
			drugTypes = exports.sDrugs:getDrugTable()
		end
	end
end)

function setWeaponPropertyFlag( weapon, skill, flagBit, bSet )
    local bIsSet = bitAnd( getWeaponProperty(weapon, skill, "flags"), flagBit ) ~= 0
    if bIsSet ~= bSet then
        setWeaponProperty(weapon, skill, "flags", flagBit)
		return true
    end
	return false
end

addEvent("gotTazedPlayer", true)
addEventHandler("gotTazedPlayer", root, function(tazedElement)
	setTimer(function(tazedElement)
		setElementData(tazedElement, "tazed", false)

		setPedAnimation(tazedElement)
        toggleAllControls(tazedElement, true) 
	end, 20000, 1, tazedElement)
	setElementData(tazedElement, "tazed", true)
	triggerClientEvent(client, "gotTaserDischarge", client)
	triggerClientEvent("gotTazerEffect", client, tazedElement, 20000)

	setPedAnimation(tazedElement, "ped", "FLOOR_hit_f", -1, false)
    setElementData(tazedElement, "tazed", true)
    toggleAllControls(tazedElement, false)

	outputChatBox("[color=sightblue][SightMTA]#ffffff Lesokkoltál egy játékost! [color=sightblue](".. getElementData(tazedElement, "visibleName"):gsub("_", " ") ..").", client)
	outputChatBox("[color=sightred][SightMTA][color=sightblue] ".. getElementData(client, "visibleName"):gsub("_", " ") .."#ffffff lesokkolt téged.", tazedElement)

	exports.sControls:toggleControl(client, "fire", false)

	playerTaserTimers[client] = setTimer(function(client)
		if isElement(client) then
			exports.sControls:toggleControl(client, "fire", true)
		end
	end, 10000, 1, client)
end)