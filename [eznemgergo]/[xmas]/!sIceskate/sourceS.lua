
local playerPositions = {}

function checkPlayerPosition(player)
    if isElement(player) then
        local x, y, z = getElementPosition(player)
        local lastPosition = playerPositions[player]

        if lastPosition then
            if lastPosition.x == x and lastPosition.y == y and lastPosition.z == z then
                return true
            else
                playerPositions[player] = {x = x, y = y, z = z}
                return false
            end
        else
            playerPositions[player] = {x = x, y = y, z = z}
            return false
        end
    end
end

addEvent("gotSelfSkatingWalkingStyle", true)
addEventHandler("gotSelfSkatingWalkingStyle", root, 
    function(walkingStyle)


        if walkingStyle == nil then
            setPedWalkingStyle(client, exports.sDashboard:getWalkingStyle(client))
        elseif walkingStyle == false then
            if checkPlayerPosition(client) then
                setPedWalkingStyle(client, 138)
            else
                setPedWalkingStyle(client, exports.sDashboard:getWalkingStyle(client))
            end
        else
            setPedWalkingStyle(client, 138)
        end
    end
)

addEventHandler("onColShapeHit", root, 
    function(hitElement, matchingDimension)
        if hitElement and matchingDimension then
            if source == skateCol then
                setPedWalkingStyle(hitElement, 138)
                triggerClientEvent(hitElement, "gotSelfSkatingState", hitElement, 138)
            end
        end
    end
)

addEventHandler("onColShapeLeave", root, 
    function(hitElement, matchingDimension)
        if hitElement and matchingDimension then
            if source == skateCol then
                triggerClientEvent(hitElement, "gotSelfSkatingState", hitElement, false)
            end
        end
    end
)

setTimer(function()
    for _, player in ipairs(getElementsByType("player")) do
        checkPlayerPosition(player)
    end
end, 1000, 0)

addEventHandler("onPlayerQuit", root, function()
    playerPositions[source] = nil
end)