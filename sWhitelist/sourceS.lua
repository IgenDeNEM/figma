local enabledSerials = {}

local allowedSerials = {
-- videoinfo1
}

function addPlayerWhitelist(serial, name)
    if serial then
        if not enabledSerials[serial] then
            enabledSerials[serial] = name
        end
    end
end

function removePlayerWhitelist(serial)
    if serial then
        if enabledSerials[serial] then
            enabledSerials[serial] = nil
        end
    end
end

function saveWhitelist()
    if fileExists("serials.save") then
        fileDelete("serials.save")
    end

    local file = fileCreate("serials.save")
    local data = toJSON(enabledSerials)

    fileWrite(file, data)
    fileClose(file)
end

function loadWhitelist()
    if fileExists("serials.save") then
        local file = fileOpen("serials.save")
        local size = fileGetSize(file)
        local data = fileRead(file, size)
        data = fromJSON(data)

        for serial, name in pairs(data) do
            enabledSerials[serial] = name
        end

        fileClose(file)
    end
end

addEventHandler("onPlayerConnect", getRootElement(), function(_, ip, _, serial)
    if allowedSerials[serial] then
        for key, player in pairs(getElementsByType("player")) do
            local adminLevel = getElementData(player, "acc.adminLevel") or 0

            if adminLevel >= 6 then
                outputChatBox("[color=sightgreen][SightMTA]: [color=sightblue]" .. (enabledSerials[serial] or "Ismeretlen") .. " [color=hudwhite]csatlakozott a szerverre.", player, 255, 255, 255, true)
            end
        end
    else
        cancelEvent(true, "[MTA:SA - Whitelist] You are unable to connect while the whitelist is on.")
    end
end)


addEventHandler("onResourceStart", resourceRoot, function()
    loadWhitelist()

    for key, player in pairs(getElementsByType("player")) do
        if enabledSerials[getPlayerSerial(player)] or allowedSerials[getPlayerSerial(player)] then
            outputChatBox("[color=sightgreen][SightMTA - Whitelist]: [color=hudwhite]A WhiteList [color=sightgreen]sikeresen[color=hudwhite] elindult. Jó játékot [color=sightblue]" .. (enabledSerials[getPlayerSerial(player)] or "Ismeretlen") .. "[color=hudwhite]!", player, 255, 255, 255, true)
        else
            kickPlayer(player, "[MTA:SA - Whitelist] You are unable to connect while the WhiteList is on.")
            --kickPlayer(player, "SightMTA - Nem szerepelsz az engedélyezett játékosok listáján.")
        end
    end
end)

addEventHandler("onResourceStop", resourceRoot, function()
    saveWhitelist()
end)

addCommandHandler("addwhitelist", function(client, commandName, serial, name)
    if exports.sPermission:hasPermission(client, "addwhitelist") then
        if serial and name then
            enabledSerials[serial] = name
            outputChatBox("[color=sightgreen][SightMTA - Whitelist]: [color=hudwhite]Sikeresen hozzáadtad a kiválasztott serialt.", client, 255, 255, 255, true)
        else
            outputChatBox("[color=sightblue][SightMTA - Whitelist]: [color=hudwhite]/" .. commandName .. " [Serial] [Név]", client, 255, 255, 255, true)
        end
    end
end)

addCommandHandler("removewhitelist", function(client, commandName, serial)
    if exports.sPermission:hasPermission(client, "removewhitelist") then
        if serial then
            enabledSerials[serial] = nil
            outputChatBox("[color=sightgreen][SightMTA - Whitelist]: [color=hudwhite]Sikeresen eltávolítottad a kiválasztott serialt.", client, 255, 255, 255, true)
        else
            outputChatBox("[color=sightblue][SightMTA - Whitelist]: [color=hudwhite]/" .. commandName .. " [Serial]", client, 255, 255, 255, true)
        end
    end
end)