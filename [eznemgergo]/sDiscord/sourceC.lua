local screenSize = {guiGetScreenSize()}

local twoFactorData = {
	State = false,
	Size = {400, 160},
	Position = {(screenSize[1] - 400) / 2, (screenSize[2] - 500) / 2}
}

function initTwoFactor()
	tFactorBackground = exports.sGui:createGuiElement("window", twoFactorData.Position[1], twoFactorData.Position[2], twoFactorData.Size[1], twoFactorData.Size[2])
	exports.sGui:setWindowTitle(tFactorBackground, "16/BebasNeueRegular.otf", "SightMTA - Discord Two Factor Auth")
	exports.sGui:guiToFront(tFactorBackground)
	triggerServerEvent("getDiscordAuthentication", localPlayer, true, true)

	local titleHeight = exports.sGui:getTitleBarHeight()
	local playerName = exports.sGui:createGuiElement("label", 5, 5 + titleHeight, twoFactorData.Size[1], twoFactorData.Size[2], tFactorBackground)
	exports.sGui:setLabelAlignment(playerName, "left", "top")
	exports.sGui:setLabelText(playerName, getElementData(localPlayer, "acc.adminNick"):gsub("_", " "))
	exports.sGui:setLabelFont(playerName, "11/Ubuntu-R.ttf")
	
	stateViewer = exports.sGui:createGuiElement("label", twoFactorData.Size[1] - 150, 5 + titleHeight, 145, 20, tFactorBackground)
	exports.sGui:guiSetTooltip(stateViewer, "Kösd össze a discord fiókoddal a felhasználód a hitelesítés előtt!")
	exports.sGui:setLabelAlignment(stateViewer, "right", "top")
	exports.sGui:setLabelText(stateViewer,  "[color=sightred][Hitelesítésre vár!]")
	exports.sGui:setLabelFont(stateViewer, "11/Ubuntu-R.ttf")
	exports.sGui:setGuiHoverable(stateViewer, true)
	exports.sGui:setLabelColor(stateViewer, "sightred")
	
	connectIntro = exports.sGui:createGuiElement("label", 0, 5 + 60, twoFactorData.Size[1], twoFactorData.Size[2], tFactorBackground)
	exports.sGui:setLabelAlignment(connectIntro, "center", "top")
	exports.sGui:setLabelText(connectIntro, "Üdvözöllek [color=sightgreen]"..getElementData(localPlayer, "acc.adminNick"):gsub("_", " ").." [color=hudwhite]\nA hitelesítés megkezdéséhez másold ki a kódodat!")
	exports.sGui:setLabelFont(connectIntro, "11/Ubuntu-R.ttf")
	
	connectCode = exports.sGui:createGuiElement("label", 160, 42.5 + 60, 75, 20, tFactorBackground)
	exports.sGui:setLabelAlignment(connectCode, "center", "top")
	exports.sGui:setLabelText(connectCode, "[color=sightgreen]...")
	exports.sGui:setLabelFont(connectCode, "11/Ubuntu-R.ttf")
	exports.sGui:guiSetTooltip(connectCode, "Kimásolás")
	exports.sGui:setLabelColor(connectCode, "sightgreen")
	exports.sGui:setClickEvent(connectCode, "clipboardCode")
	exports.sGui:setGuiHoverable(connectCode, true)
	
	discordLoading = exports.sGui:createGuiElement("image", twoFactorData.Size[1] / 2 - 24, titleHeight + (twoFactorData.Size[2] - titleHeight) / 2 + 20, 40, 40, tFactorBackground)
	exports.sGui:setImageFile(discordLoading, exports.sGui:getFaIconFilename("circle-notch", 48))
	exports.sGui:setImageSpinner(discordLoading, true)
	
	triggerServerEvent("getTwoFactorAuthentication", localPlayer)
end

addEvent("initTwoFactor", true)
addEventHandler("initTwoFactor", root, function()
	initTwoFactor()
end)

local twoFactor = false
addEvent("gotTwoFactorAuthentication", true)
addEventHandler("gotTwoFactorAuthentication", root, function(authKey, reTry)
	if discordLoading and exports.sGui:isGuiElementValid(discordLoading) then
		exports.sGui:deleteGuiElement(discordLoading)
	end

	twoFactor = authKey
	
	if reTry then
		connectIntro = exports.sGui:createGuiElement("label", 0, 5 + 60, twoFactorData.Size[1], twoFactorData.Size[2], tFactorBackground)
		exports.sGui:setLabelAlignment(connectIntro, "center", "top")
		exports.sGui:setLabelText(connectIntro, "Üdvözöllek [color=sightgreen]"..getElementData(localPlayer, "acc.adminNick"):gsub("_", " ").." [color=hudwhite]\nA hitelesítés megkezdéséhez másold ki a kódodat!")
		exports.sGui:setLabelFont(connectIntro, "11/Ubuntu-R.ttf")
		
		connectCode = exports.sGui:createGuiElement("label", 160, 42.5 + 60, 75, 20, tFactorBackground)
		exports.sGui:setLabelAlignment(connectCode, "center", "top")
		exports.sGui:setLabelText(connectCode, "[color=sightgreen]...")
		exports.sGui:setLabelFont(connectCode, "11/Ubuntu-R.ttf")
		exports.sGui:guiSetTooltip(connectCode, "Kimásolás")
		exports.sGui:setLabelColor(connectCode, "sightgreen")
		exports.sGui:setClickEvent(connectCode, "clipboardCode")
		exports.sGui:setGuiHoverable(connectCode, true)
	end

	exports.sGui:setLabelText(connectCode, "[color=sightgreen]"..authKey)
	exports.sGui:setClickArgument(connectCode, authKey)
	

	connectCheck = exports.sGui:createGuiElement("button", 5, 100 - 35 + 60, twoFactorData.Size[1] - 10, 30, tFactorBackground)
	exports.sGui:setGuiBackground(connectCheck, "solid", "sightgrey1")
	exports.sGui:setGuiHover(connectCheck, "gradient", {"sightgrey1", "sightgrey3"}, false, true)
	exports.sGui:setClickEvent(connectCheck, "twoFactorAuthentication")
	
	local connectLabel = exports.sGui:createGuiElement("label", 0, 0, twoFactorData.Size[1] - 10, 30, connectCheck)
	exports.sGui:setLabelAlignment(connectLabel, "center", "center")
	exports.sGui:setLabelText(connectLabel, "Megerősítés!")
	exports.sGui:setLabelFont(connectLabel, "11/Ubuntu-R.ttf")
end)



local lastClick = 0
addEvent("twoFactorAuthentication", false)
addEventHandler("twoFactorAuthentication", root, function()
	if lastClick + 1500 > getTickCount() then
		exports.sGui:showInfobox("e", "Várj egy kicsit!")
		return
	end
	lastClick = getTickCount()

	discordLoading = exports.sGui:createGuiElement("image", twoFactorData.Size[1] / 2 - 24, 20 + (twoFactorData.Size[2] - 20) / 2, 40, 40, tFactorBackground)
	exports.sGui:setImageFile(discordLoading, exports.sGui:getFaIconFilename("circle-notch", 48))
	exports.sGui:setImageSpinner(discordLoading, true)

	if exports.sGui:isGuiElementValid(connectIntro) then
		exports.sGui:deleteGuiElement(connectIntro)
		exports.sGui:deleteGuiElement(connectCode)
	end

	if exports.sGui:isGuiElementValid(connectCheck) then
		exports.sGui:deleteGuiElement(connectCheck)
	end
	triggerServerEvent("checkTwoFactor", localPlayer)
end)

addEvent("clipboardCode", false)
addEventHandler("clipboardCode", root, function(_, _, _, _, _, authCode)
	exports.sGui:showInfobox("i", "Sikeresen kimásoltad a kódot. [".. authCode .."]")
	setClipboard(authCode)
end)

addEvent("twoFactorResponse", true)
addEventHandler("twoFactorResponse", root, function(responseState, newKey, t)
	if responseState then
		if exports.sGui:isGuiElementValid(tFactorBackground) then
			exports.sGui:deleteGuiElement(tFactorBackground)
		end
	else
		triggerEvent("gotTwoFactorAuthentication", localPlayer, newKey, true)
	end
end)

rpcData = {}
local connectData = {
	State = false,
	Size = {350, 270},
	Position = {(screenSize[1] - 350) / 2, (screenSize[2] - 150) / 2}
}
local connectionTime = 0

function initDiscord()
	discordBackground = exports.sGui:createGuiElement("window", connectData.Position[1], connectData.Position[2], connectData.Size[1], connectData.Size[2])
	exports.sGui:setWindowTitle(discordBackground, "16/BebasNeueRegular.otf", "SightMTA - Discord Connect")
	exports.sGui:setWindowCloseButton(discordBackground, "closeDiscord")
	
	triggerServerEvent("getDiscordAuthentication", localPlayer, true)

	local titleHeight = exports.sGui:getTitleBarHeight()
	local playerName = exports.sGui:createGuiElement("label", 5, 5 + titleHeight, connectData.Size[1], connectData.Size[2], discordBackground)
	exports.sGui:setLabelAlignment(playerName, "left", "top")
	exports.sGui:setLabelText(playerName, getElementData(localPlayer, "char.name"):gsub("_", " "))
	exports.sGui:setLabelFont(playerName, "11/Ubuntu-R.ttf")
	

	connectState = exports.sGui:createGuiElement("label", connectData.Size[1] - 150, 5 + titleHeight, 145, 20, discordBackground)
	exports.sGui:guiSetTooltip(connectState, "A csatlakozás elindításához kattints a szövegre!")
	exports.sGui:setClickEvent(connectState, "startDiscordConnect")
	exports.sGui:setLabelAlignment(connectState, "right", "top")
	exports.sGui:setLabelText(connectState, "[color=sightred][Összekötésre vár!]")
	exports.sGui:setLabelFont(connectState, "11/Ubuntu-R.ttf")
	exports.sGui:setGuiHoverable(connectState, true)
	exports.sGui:setLabelColor(connectState, discordState and "sightgreen" or "sightred")
	
	local rpcSize = {270, 200}
	
	local rpcImage = exports.sGui:createGuiElement("image", 5, titleHeight + 30, 270, 196, discordBackground)
	exports.sGui:setImageFile(rpcImage, ":sDiscord/assets/sight_discord.png")
	exports.sGui:setImageColor(rpcImage, "#ffffff")
	
	rpcName = exports.sGui:createGuiElement("label", 78, 48 + 1, 270, 200, rpcImage)
	exports.sGui:setLabelAlignment(rpcName, "left", "top")
	exports.sGui:setLabelText(rpcName, "#9497ae" .. getElementData(localPlayer, "visibleName"):gsub("_", " ") .. " ("..getElementData(localPlayer, "playerID")..")")
	exports.sgui:setLabelFont(rpcName, "9.5/GG-Semibold.ttf")
	
	rpcPlayers = exports.sGui:createGuiElement("label", 78, 63, rpcSize[1], rpcSize[2], rpcImage)
	exports.sGui:setLabelAlignment(rpcPlayers, "left", "top")
	exports.sGui:setLabelText(rpcPlayers, "#9497ae" .. #getElementsByType("player") .. " / 1024")
	exports.sgui:setLabelFont(rpcPlayers, "9.5/GG-Semibold.ttf")

	rpcOnline = exports.sGui:createGuiElement("label", 93, 86.5, rpcSize[1], rpcSize[2], rpcImage)
	exports.sGui:setLabelAlignment(rpcOnline, "left", "top")
	exports.sGui:setLabelText(rpcOnline, "#58c09d12:34")
	exports.sgui:setLabelFont(rpcOnline, "8.5/GG-Bold.ttf")

	rpcVisibleName = exports.sGui:createGuiElement("checkbox", rpcSize[1] + 5, titleHeight + 30, 25, "normal", discordBackground)
	exports.sGui:setCheckboxColor(rpcVisibleName, "sightmidgrey", "sightgrey2", "sightgreen", "sightmidgrey")
	local nameState = rpcData.rpcName
	if nameState ~= false then
		nameState = true
	end
	exports.sGui:setCheckboxChecked(rpcVisibleName, nameState)
	exports.sGui:guiSetTooltip(rpcVisibleName, "Játékosnév kijelzése")
	exports.sGui:setClickEvent(rpcVisibleName, "showName")
	
	rpcIdentity = exports.sGui:createGuiElement("checkbox", rpcSize[1] + 5, titleHeight + 55, 25, "normal", discordBackground)
	exports.sGui:setCheckboxColor(rpcIdentity, "sightmidgrey", "sightgrey2", "sightgreen", "sightmidgrey")
	local identityState = rpcData.rpcIdentity
	if identityState ~= false then
		identityState = true
	end
	exports.sGui:setCheckboxChecked(rpcIdentity, identityState)
	exports.sGui:guiSetTooltip(rpcIdentity, "ID kijelzése")
	exports.sGui:setClickEvent(rpcIdentity, "showIdentity")
	
	rpcPosition = exports.sGui:createGuiElement("checkbox", rpcSize[1] + 5, titleHeight + 80, 25, "normal", discordBackground)
	exports.sGui:setCheckboxColor(rpcPosition, "sightmidgrey", "sightgrey2", "sightgreen", "sightmidgrey")
	local positionState = rpcData.rpcPosition
	if positionState and positionState ~= false then
		positionState = true
	end
	rpcData.rpcPosition = positionState
	exports.sGui:setCheckboxChecked(rpcPosition, positionState)
	exports.sGui:guiSetTooltip(rpcPosition, "Pozíció kijelzése")
	exports.sGui:setClickEvent(rpcPosition, "showIdentity")


	rpcAction = exports.sGui:createGuiElement("checkbox", rpcSize[1] + 5, titleHeight + 105, 25, "normal", discordBackground)
	exports.sGui:setCheckboxColor(rpcAction, "sightmidgrey", "sightgrey2", "sightgreen", "sightmidgrey")
	local actionState = rpcData.rpcAction
	if actionState and actionState ~= false then
		actionState = true
	end
	exports.sGui:setCheckboxChecked(rpcAction, positionState)
	exports.sGui:guiSetTooltip(rpcAction, "Tevékenység kijelzése")
	exports.sGui:setClickEvent(rpcAction, "showIdentity")

	rpcData.rpcAction = rpcAction

	if getElementData(localPlayer, "acc.adminLevel") >= 1 then
		rpcAdminlevel = exports.sGui:createGuiElement("checkbox", rpcSize[1] + 5, titleHeight + 105 + 25, 25, "normal", discordBackground)
		exports.sGui:setCheckboxColor(rpcAdminlevel, "sightmidgrey", "sightgrey2", "sightgreen", "sightmidgrey")
		local adminLevel = rpcData.rpcALevel
		if adminLevel ~= false then
			adminLevel = true
		end
		exports.sGui:setCheckboxChecked(rpcAdminlevel, adminLevel)
		exports.sGui:guiSetTooltip(rpcAdminlevel, "Adminszint kijelzése")
		exports.sGui:setClickEvent(rpcAdminlevel, "adminLevel")
		
		rpcAdminPrev = exports.sGui:createGuiElement("checkbox", rpcSize[1] + 5, titleHeight + 130 + 25, 25, "normal", discordBackground)
		exports.sGui:setCheckboxColor(rpcAdminPrev, "sightmidgrey", "sightgrey2", "sightgreen", "sightmidgrey")
		exports.sGui:setCheckboxChecked(rpcAdminPrev, false)
		exports.sGui:guiSetTooltip(rpcAdminPrev, "Admin előnézet")
		exports.sGui:setClickEvent(rpcAdminPrev, "adminPreview")
	end
	
	local saveButton = exports.sGui:createGuiElement("button", rpcSize[1] + 50, titleHeight + 30, 25, 25, discordBackground)
	exports.sGui:setGuiBackground(saveButton, "solid", "sightgrey3")
	exports.sGui:setGuiHover(saveButton, "gradient", {
		"sightgreen",
		"sightgreen-second"
	}, false, true)
	exports.sGui:setButtonFont(saveButton, "14/BebasNeueBold.otf")
	exports.sGui:setButtonIcon(saveButton, exports.sGui:getFaIconFilename("save", 25))
	exports.sGui:guiSetTooltip(saveButton, "Mentés")
	exports.sGui:setClickEvent(saveButton, "saveRPCSetting")

	local discordLink = exports.sGui:createGuiElement("button", rpcSize[1] + 50, titleHeight + 90, 25, 25, discordBackground)
	exports.sGui:setGuiBackground(discordLink, "solid", "sightgrey3")
	exports.sGui:setGuiHover(discordLink, "gradient", {
		"sightgreen",
		"sightgreen-second"
	}, false, true)
	exports.sGui:setButtonFont(discordLink, "14/BebasNeueBold.otf")
	exports.sGui:setButtonIcon(discordLink, exports.sGui:getFaIconFilename("discord", 25, "brands"))
	exports.sGui:guiSetTooltip(discordLink, "Discord Szerver")
	exports.sGui:setClickEvent(discordLink, "clipboardDiscordlink")
	
	local refreshButton = exports.sGui:createGuiElement("button", rpcSize[1] + 50, titleHeight + 30 + 30, 25, 25, discordBackground)
	exports.sGui:setGuiBackground(refreshButton, "solid", "sightgrey3")
	exports.sGui:setGuiHover(refreshButton, "gradient", {
		"sightgreen",
		"sightgreen-second"
	}, false, true)
	exports.sGui:setButtonFont(refreshButton, "14/BebasNeueBold.otf")
	exports.sGui:setButtonIcon(refreshButton, exports.sGui:getFaIconFilename("sync", 25))
	exports.sGui:guiSetTooltip(refreshButton, "Frissítés")
	exports.sGui:setClickEvent(refreshButton, "refreshRPC")
	updateRpcSetting()
end
addEvent("clipboardDiscordlink", false)
addEventHandler("clipboardDiscordlink", root, function()
	setClipboard("discord.gg/sightmta")
	exports.sGui:showInfobox("s", "Sikeresen kimásoltad a vágólapra a discord szerverünket! [discord.gg/sightmta]")
end)

function startConnectPhase()
	connectBackground = exports.sGui:createGuiElement("rectangle", 0, connectData.Size[2] + 5, connectData.Size[1], 0, discordBackground)
	exports.sGui:setGuiBackground(connectBackground, "solid", "sightgrey2")
	exports.sGui:setGuiSizeAnimated(connectBackground, connectData.Size[1], 100, "none", "Linear")
	setTimer(function()
		connectIntro = exports.sGui:createGuiElement("label", 5, 5, connectData.Size[1], connectData.Size[2], connectBackground)
		exports.sGui:setLabelAlignment(connectIntro, "left", "top")
		exports.sGui:setLabelText(connectIntro, "Üdvözöllek [color=sightgreen]"..getElementData(localPlayer, "visibleName"):gsub("_", " ").." [color=hudwhite]\nAz összekötés megkezdéséhez másold ki a kódodat!")
		exports.sGui:setLabelFont(connectIntro, "11/Ubuntu-R.ttf")
		
		connectCode = exports.sGui:createGuiElement("label", 160, 42.5, 75, 20, connectBackground)
		exports.sGui:setLabelAlignment(connectCode, "center", "top")
		exports.sGui:setLabelText(connectCode, "[color=sightgreen]...")
		exports.sGui:setLabelFont(connectCode, "11/Ubuntu-R.ttf")
		exports.sGui:guiSetTooltip(connectCode, "Kimásolás")
		exports.sGui:setLabelColor(connectCode, "sightgreen")
		exports.sGui:setClickEvent(connectCode, "clipboardCode")
		exports.sGui:setGuiHoverable(connectCode, true)
		triggerServerEvent("getDiscordAuthentication", localPlayer, false)
		
		connectCheck = exports.sGui:createGuiElement("button", 5, 100 - 35, connectData.Size[1] - 10, 30, connectBackground)
		exports.sGui:setGuiBackground(connectCheck, "solid", "sightgrey1")
		exports.sGui:setGuiHover(connectCheck, "gradient", {"sightgrey1", "sightgrey3"}, false, true)
		exports.sGui:setClickEvent(connectCheck, "tryDiscord")
		
		connectLabel = exports.sGui:createGuiElement("label", 0, 0, connectData.Size[1] - 10, 30, connectCheck)
		exports.sGui:setLabelAlignment(connectLabel, "center", "center")
		exports.sGui:setLabelText(connectLabel, "Megerősítés!")
		exports.sGui:setLabelFont(connectLabel, "11/Ubuntu-R.ttf")
	end, 1000, 1)
end

local tryState = false
addEvent("tryDiscord", true)
addEventHandler("tryDiscord", root, function()
	triggerServerEvent("getDiscordAuthentication", localPlayer, true)
	tryState = true
end)

addEvent("gotDiscordAuthentication", true)
addEventHandler("gotDiscordAuthentication", root, function(authCode, stateDetails, twoFactor)
	if authCode then
		exports.sGui:setLabelText(connectCode, "[color=sightgreen]" .. authCode)
		exports.sGui:setClickArgument(connectCode, authCode)
	end



	if stateDetails and stateDetails.success then
		if tryState then
			tryState = false
			if exports.sGui:isGuiElementValid(connectIntro) then
				exports.sGui:deleteGuiElement(connectIntro)
			end
			if exports.sGui:isGuiElementValid(connectCode) then
				exports.sGui:deleteGuiElement(connectCode)
			end
			if exports.sGui:isGuiElementValid(connectCheck) then
				exports.sGui:deleteGuiElement(connectCheck)
			end
			if exports.sGui:isGuiElementValid(connectLabel) then
				exports.sGui:deleteGuiElement(connectLabel)
			end

			exports.sGui:setGuiSizeAnimated(connectBackground, connectData.Size[1], 0, "none", "Linear")
		end


		if twoFactor then
			exports.sGui:setLabelText(stateViewer, "[color=sightgreen][Összekötve]")
			exports.sGui:guiSetTooltip(stateViewer, "Sikeresen csatlakoztattad a fiókod! ["..stateDetails.discordName.."]")
			exports.sGui:setClickEvent(stateViewer, false)	
			exports.sGui:setLabelColor(stateViewer, "sightgreen")
		else
			exports.sGui:setLabelText(connectState, "[color=sightgreen][Összekötve]")
			exports.sGui:setClickEvent(connectState, false)	
			exports.sGui:guiSetTooltip(connectState, "A fiókod már csatlakoztatva van! ["..stateDetails.discordName.."]")
			exports.sGui:setLabelColor(connectState, "sightgreen")
		end
	end
end)

startedDiscordConnection = false
addEvent("startDiscordConnect", false)
addEventHandler("startDiscordConnect", root, function()
	if not startedDiscordConnection then
		startedDiscordConnection = true
		startConnectPhase()
	end
end)

addEvent("saveRPCSetting", false)
addEventHandler("saveRPCSetting", getRootElement(), function()
	local saveTable = {
		rpcALevel = exports.sGui:isCheckboxChecked(rpcAdminlevel),
		rpcName = exports.sGui:isCheckboxChecked(rpcVisibleName),
		rpcIdentity = exports.sGui:isCheckboxChecked(rpcIdentity),
		rpcPosition = exports.sGui:isCheckboxChecked(rpcPosition),
		rpcAction = exports.sGui:isCheckboxChecked(rpcAction),
	}

	rpcData = {
		rpcALevel = exports.sGui:isCheckboxChecked(rpcAdminlevel),
		rpcName = exports.sGui:isCheckboxChecked(rpcVisibleName),
		rpcIdentity = exports.sGui:isCheckboxChecked(rpcIdentity),
		rpcPosition = exports.sGui:isCheckboxChecked(rpcPosition),
		rpcAction = exports.sGui:isCheckboxChecked(rpcAction),
	}

	exports.sGui:showInfobox("i", "Mentetted a beállításaidat.")
	if fileExists("rpcsettings.sight") then
		fileDelete("rpcsettings.sight")
	end
	local saveFile = fileCreate("rpcsettings.sight")
	if saveFile then
		fileWrite(saveFile, toJSON(saveTable))
		fileClose(saveFile)
	end
end)

addEventHandler("onClientResourceStart", resourceRoot, function()
	connectionTime = getTickCount()

	if fileExists("rpcsettings.sight") then
		rpcFile = fileOpen("rpcsettings.sight", true)
		if rpcFile then
			fileContent = fileRead(rpcFile, fileGetSize(rpcFile))
			if fileContent then
				rpcData = fromJSON(fileContent)
				fileClose(rpcFile)
				startTime = getRealTime().timestamp
			end
		end
	end
end)

function updateRpcSetting()
    local isAdminPreviewChecked = exports.sGui:isCheckboxChecked(rpcAdminPrev)
    local isAdminLevelChecked = exports.sGui:isCheckboxChecked(rpcAdminlevel)
    local isNameChecked = exports.sGui:isCheckboxChecked(rpcVisibleName)
    local isIdentityChecked = exports.sGui:isCheckboxChecked(rpcIdentity)
    local isShowPositionChecked = exports.sGui:isCheckboxChecked(rpcPosition)
	local isActionChecked = exports.sGui:isCheckboxChecked(rpcAction)

    local displayName = ""
    local playerName = getElementData(localPlayer, "visibleName"):gsub("_", " ") or "Ismeretlen"
    local adminName = getElementData(localPlayer, "acc.adminNick"):gsub("_", " ") or "Admin"
    local playerID = getElementData(localPlayer, "playerID") or "N/A"
	local adminTitle = exports.sAdministration:getPlayerAdminTitleLOG(localPlayer) or "NIL"

    if isAdminPreviewChecked then
        if isNameChecked then
            displayName = adminName
        else
            displayName = "Rejtett"
        end

        if isAdminLevelChecked then
            displayName = "[" .. adminTitle .. "] " .. displayName
        end
    else
        if isNameChecked then
            displayName = playerName
		else
            displayName = "Rejtett"
        end
    end

    if isIdentityChecked then
        displayName = displayName .. " (" .. playerID .. ")"
    end

	local x, y, z = getElementPosition(localPlayer)

	playerPosition = getZoneName(x, y, z)

    if isShowPositionChecked then
        displayName = displayName .. " - " .. playerPosition
    end

	local actionText = "Játékosok ("..#getElementsByType("player").."/1024)"

	if isActionChecked then
		local randomActions = {
			"Dudorászik",
			"Kavicsokat rugdos",
			"Nézelődik",
			"Tétlenül áldogál",
			"Sóhajtozik",
			"Cipőjét nézegeti",
			"Kémleli az eget",
		}
		local currentAction = getElementData(localPlayer, "rpc.action") and getElementData(localPlayer, "rpc.action")[1] or randomActions[math.random(1, #randomActions)]
		actionText = string.format("%s (%d/%d)", currentAction, #getElementsByType("player"), 1024)
	end

    exports.sGui:setLabelText(rpcName, "#9497ae" .. displayName)
	exports.sGui:setLabelText(rpcPlayers, "#9497ae" .. actionText)
end

addEvent("adminPreview", false)
addEventHandler("adminPreview", root, function()
    updateRpcSetting()
end)

addEvent("adminLevel", false)
addEventHandler("adminLevel", root, function()
    updateRpcSetting()
    local state = exports.sGui:isCheckboxChecked(rpcAdminlevel) and "bekapcsoltad" or "kikapcsoltad"
    outputChatBox("[color=sightgreen][SightMTA - Discord]: [color=hudwhite]Sikeresen " .. state .. " az adminszint kijelzést!")
end)

addEvent("showName", false)
addEventHandler("showName", root, function()
    updateRpcSetting()
end)

addEvent("showIdentity", false)
addEventHandler("showIdentity", root, function()
    updateRpcSetting()
end)

addEvent("showPosition", false)
addEventHandler("showPosition", root, function()
    updateRpcSetting()
end)

local discordApplication
local playerDatas = {
    [localPlayer] = {
        loggedIn = true,
        adminDuty = true,
        ["acc.adminNick"] = true,
        visibleName = true,
        playerID = true,
    },
}

local gottenDatas = {}
local richPresenceTimer = nil

dcID = "1303863928585060392"

function setRichPresenceDetails()
	if not discordApplication then
		discordApplication = setDiscordApplicationID(dcID)
	end

    local playerData = gottenDatas[localPlayer]
    if not playerData or not playerData.loggedIn then
		setDiscordRichPresenceState("Éppen csatlakozik... ("..#getElementsByType("player").."/1024)")
        return
    end

    local displayName = "Rejtett"
    local adminTitle = exports.sAdministration:getPlayerAdminTitleLOG(localPlayer)
    local adminNick = playerData["acc.adminNick"] or "Admin"
    local visibleName = playerData.visibleName:gsub("_", " ") or "Ismeretlen"
    local playerID = playerData.playerID or "N/A"

    local showAdminLevel = rpcData.rpcALevel ~= false
    local showIdentity = rpcData.rpcIdentity ~= false
    local showName = rpcData.rpcName ~= false

    if exports.sAdministration:isPlayerInAdminDuty(localPlayer) then
        if showAdminLevel then
            displayName = string.format("[%s] %s", adminTitle, adminNick)
        else
            displayName = adminNick
        end
    else
        if showName then
            displayName = visibleName
        end
    end

    if showIdentity then
        displayName = string.format("%s (%s)", displayName, playerID)
    end

	local showPosition = rpcData.rpcPosition

	local x, y, z = getElementPosition(localPlayer)

	local zone = getZoneName(x, y, z)

	if showPosition then
		displayName = displayName .. " - " .. zone
	end

	local actionText = "Játékosok ("..#getElementsByType("player").."/1024)"

	if rpcData.rpcAction then
		local randomActions = {
			"Dudorászik",
			"Kavicsokat rugdos",
			"Nézelődik",
			"Tétlenül áldogál",
			"Sóhajtozik",
			"Cipőjét nézegeti",
			"Kémleli az eget",
		}
		local currentAction = getElementData(localPlayer, "rpc.action") and getElementData(localPlayer, "rpc.action")[1] or randomActions[math.random(1, #randomActions)]
		actionText = string.format("%s (%d/%d)", currentAction, #getElementsByType("player"), 1024)
	end


	setDiscordRichPresenceButton(1, "Csatlakozás", "mtasa://185.221.21.67:22051/")
	setDiscordRichPresenceButton(2, "Discord", "https://discord.gg/sightmta")

	setDiscordRichPresenceAsset("sight1024", "SightMTA")
    setDiscordRichPresenceDetails(displayName)
	setDiscordRichPresenceState(actionText)
end

addEventHandler("onClientResourceStart", resourceRoot, function()
	for sourceElement, dataKeys in pairs(playerDatas) do
		gottenDatas[sourceElement] = {}
		for keyValue in pairs(dataKeys) do
			gottenDatas[sourceElement][keyValue] = getElementData(sourceElement, keyValue)
		end
	end
	
	resetDiscordRichPresenceData()
	discordApplication = setDiscordApplicationID(dcID)

	if discordApplication then
		setDiscordRichPresenceDetails("SightMTA")
		setDiscordRichPresenceAsset("sight1024", "SightMTA")
		setDiscordRichPresenceButton(1, "Csatlakozás", "mtasa://185.221.21.67:22051/")
		setDiscordRichPresenceButton(2, "Discord", "https://discord.gg/sightmta")
		--setDiscordRichPresenceStartTime(200)
		setDiscordRichPresenceStartTime(1)
		setRichPresenceDetails()
		richPresenceTimer = setTimer(setRichPresenceDetails, 1000, 0)
	end
end)

addEventHandler("onClientElementDataChange", root, function(dataKey, oldValue, newValue)
    if gottenDatas[source] then
        gottenDatas[source][dataKey] = newValue
    end
end)


function renderClock()
	local now = getTickCount()
	local secs = math.max(0, math.floor((now - connectionTime) / 1000))
	local min = math.floor(secs / 60)
	secs = secs - min * 60
	local clock = string.format("%s%02d:%02d", "#58c09d", min, secs)
	exports.sGui:setLabelText(rpcOnline, clock)
end

addCommandHandler("discord", function()
	connectData.State = not connectData.State
	if connectData.State then
		initDiscord()
		addEventHandler("onClientRender", root, renderClock)
	else
		closeDiscord()
	end
end)

function closeDiscord()
	removeEventHandler("onClientRender", root, renderClock)
	if exports.sGui:isGuiElementValid(discordBackground) then
		exports.sGui:deleteGuiElement(discordBackground)
	end
end
addEvent("closeDiscord", false)
addEventHandler("closeDiscord", root, closeDiscord)