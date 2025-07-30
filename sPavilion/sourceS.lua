local pavilionRadioIndex = 53
local fishRadioIndex = 3
local clubRadioIndex = 1

local pavilionDancers = {}
local clubDancers = {}

function generatePavilionDancers()
    local availableSkins = exports.sBinco:getSkins()
    local pavilionPopularity = math.random(10, 20)

    for i = 1, pavilionPopularity do
        local skinType = math.random(1, 2) == 1 and "Férfi" or "Női"
        local skinList = availableSkins[skinType]
        local randomSkin = skinList[math.random(1, #skinList)]

        pavilionDancers[i] = {
            randomSkin, -- Skin ID
            i, -- Dancer ID
            math.random(1, #danceAnims), -- Anim index
            math.random(0, 360) -- Ped rotáció
        }
    end

    local djSkinType = math.random(1, 2) == 1 and "Férfi" or "Női"
    local djSkinList = availableSkins[djSkinType]
    local randomDjSkin = djSkinList[math.random(1, #djSkinList)]

    pavilionDancers[pavilionPopularity + 1] = {
        randomDjSkin, -- Skin ID
        -1, -- DJ
        math.random(1, #danceAnims), -- Anim index
        0 -- Ped rotáció
    }
end

local occupiedPositions = {}

function generateClubDancers()
    local availableSkins = exports.sBinco:getSkins()
    local clubPopularity = math.random(15, 20)

    for i = 1, clubPopularity do
        local skinType = math.random(1, 2) == 1 and "Férfi" or "Női"
        local skinList = availableSkins[skinType]
        local randomSkin = skinList[math.random(1, #skinList)]
        local randomPosition = math.random(1, #clubPoses)

        while occupiedPositions[randomPosition] do
            randomPosition = math.random(1, #clubPoses)
        end

        occupiedPositions[randomPosition] = true

        clubDancers[i] = {
            randomSkin, -- Skin ID
            randomPosition, -- Dancer ID
            math.random(1, #danceAnims), -- Anim index
            math.random(0, 360) -- Ped rotáció
        }
    end

    local djSkinType = math.random(1, 2) == 1 and "Férfi" or "Női"
    local djSkinList = availableSkins[djSkinType]
    local randomDjSkin = djSkinList[math.random(1, #djSkinList)]

    clubDancers[clubPopularity + 1] = {
        randomDjSkin, -- Skin ID
        -1, -- DJ
        math.random(1, #danceAnims), -- Anim index
        180 -- Ped rotáció
    }
end

generatePavilionDancers()
generateClubDancers()

addEvent("requestClubDatas", true)
addEventHandler("requestClubDatas", getRootElement(),  function()
    --Club
    triggerClientEvent(client, "gotClubDancers", client, clubDancers or {})
    triggerClientEvent(client, "gotClubRadio", client, clubRadioIndex or 1)

    --Fish
    triggerClientEvent(client, "gotFishRadio", client, fishRadioIndex or 1)

    --Pavilion
    triggerClientEvent(client, "gotPavilionDancers", client, pavilionDancers or {})
    triggerClientEvent(client, "gotPavilionRadio", client, pavilionRadioIndex or 1)
end)


local _addCommandHandler = addCommandHandler
function addCommandHandler(cmd, ...)
	if type(cmd) == "string" then
		_addCommandHandler(cmd, ...)
	else
		for k, v in ipairs(cmd) do
			_addCommandHandler(v, ...)
		end
	end
end

local commandHandlers = {
    ["pavilionradio"] = function(sourcePlayer, radioIndex) 
        pavilionRadioIndex = radioIndex
        return triggerClientEvent(root, "gotPavilionRadio", sourcePlayer, pavilionRadioIndex)
    end,
    ["clubradio"] = function(sourcePlayer, radioIndex) 
        clubRadioIndex = radioIndex
        return triggerClientEvent(root, "gotClubRadio", sourcePlayer, clubRadioIndex)
    end,
    ["fishradio"] = function(sourcePlayer, radioIndex) 
        fishRadioIndex = radioIndex
        return triggerClientEvent(root, "gotFishRadio", sourcePlayer, fishRadioIndex)
    end,
}

addCommandHandler({"pavilionradio", "clubradio", "fishradio"}, function(sourcePlayer, commandName, radioIndex)
    if exports.sPermission:hasPermission(sourcePlayer, "pavilionradio") then
        if not radioIndex or not tonumber(radioIndex) then
            outputChatBox("[color=sightblue][SightMTA - Használat]: [color=hudwhite]/" .. commandName .. " [Rádió azonosító (0 - 48)]", sourcePlayer)
            return
        end

        local radioIndex = tonumber(radioIndex)

        if radioIndex then
            if commandHandlers[commandName] then
                local selectedFunction = commandHandlers[commandName]

                if selectedFunction(sourcePlayer, radioIndex) then
                    local radioName = (commandName:gsub("radio", "")):gsub("^%l", string.upper)
                    if radioIndex >= 1 then
                        outputChatBox("[color=sightgreen][SightMTA - "..radioName.."]: [color=hudwhite]Sikeresen [color=sightyellow]átállítottad [color=hudwhite]a kiválasztott rádió csatornáját!", sourcePlayer)
                    else
                        outputChatBox("[color=sightgreen][SightMTA - "..radioName.."]: [color=hudwhite]Sikeresen [color=sightred]kikapcsoltad [color=hudwhite]a kiválasztott rádió csatornáját!", sourcePlayer)
                    end
                else
                    outputChatBox("[color=sightred][SightMTA - Hiba]: [color=hudwhite]A "..commandName:gsub("radio", " rádió").." csatornájának a lecserelése sikertelen volt!", sourcePlayer)
                end
            end
        end
    end
end)