addEvent("tryToStartSantaOpening", true)
addEventHandler("tryToStartSantaOpening", getRootElement(), function(dbID)
    if exports.sItems:takeItem(source, "dbID", dbID, 1) then
        local itemId = chooseRandomItem()
        local rnd1, rnd2, rnd3, rnd4, rnd5 = 800, 100, 100, 100, 100

        triggerClientEvent(source, "startSantaOpening", source, itemId, rnd1, rnd2, rnd3, rnd4, rnd5)

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
        exports.sAnticheat:anticheatBan(client, "AC #130 - sSanta @sourceS:27")
    end
end)