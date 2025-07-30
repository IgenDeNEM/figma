pairAnimations = {}

addEvent("playAnimpanelAnimation", true)
addEventHandler("playAnimpanelAnimation", getRootElement(), function(anim)
    if not client then
        client = source
    end
    
    if anim then
        if animList[anim][6] then
            setElementData(client, "customAnim", anim)
        else
            setPedAnimation(client, animList[anim][3], animList[anim][4], -1, animList[anim][5], false, false, animList[anim][7])
        end
    else
        setElementData(client, "customAnim", false)
        setPedAnimation(client) 
    end
    triggerClientEvent(client, "gotCurrentAnim", client, anim)
end)

addEvent("selectPlayerPairAnimation", true)
addEventHandler("selectPlayerPairAnimation", getRootElement(), function(targetPlayer, anim)
    local targetName = getElementData(targetPlayer, "visibleName"):gsub("_", " ")
    local clientName = getElementData(client, "visibleName"):gsub("_", " ")

    exports.sGui:showInfobox(client, "s", "Sikeresen küldtél egy páros animáció kérést neki: " .. targetName .. "!")

    exports.sGui:showInfobox(targetPlayer, "i", clientName .. " páros animációt szeretne lejátszani: " .. animations[anim][1] .. ". Elfogadáshoz nyomj [E] gombot!")

    pairAnimations[targetPlayer] = {client, anim}
    pairAnimations[client] = {targetPlayer, anim}

    local function acceptPlayerAnim(player)
        if pairAnimations[player] then

            
            local animTable = pairAnimations[player]

            local animWith = animTable[1]

            local anim = animTable[2]

            setElementData(player, "customAnim", false)
            setPedAnimation(player)

            setElementData(animWith, "customAnim", false)
            setPedAnimation(animWith)

            if animList[anim][6] then
                setElementData(player, "customAnim", anim)
                setElementData(animWith, "customAnim", anim)
            else
                setPedAnimation(player, animList[anim][3], animList[anim][4], -1, animList[anim][5], false, false, animList[anim][7])
                setPedAnimation(animWith, animList[anim][3], animList[anim][4], -1, animList[anim][5], false, false, animList[anim][7])
            end

            triggerClientEvent(player, "gotCurrentAnim", player, anim)
            triggerClientEvent(animWith, "gotCurrentAnim", animWith, anim)


            unbindKey(player, "e", "down", acceptPlayerAnim)

            exports.sGui:showInfobox(animWith, "i", "Elfogadták a felkérésed.")

            pairAnimations[player] = nil
            pairAnimations[animWith] = nil
        end
    end

    bindKey(targetPlayer, "e", "down", acceptPlayerAnim)

end)