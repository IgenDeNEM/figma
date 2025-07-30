local sightexports = {sGui = false, sNames = false}
local function sightlangProcessExports()
	for k in pairs(sightexports) do
		local res = getResourceFromName(k)
		if res and getResourceState(res) == "running" then
			sightexports[k] = exports[k]
		else
			sightexports[k] = false
		end
	end
end
sightlangProcessExports()
if triggerServerEvent then
	addEventHandler("onClientResourceStart", getRootElement(), sightlangProcessExports, true, "high+9999999999")
end
if triggerClientEvent then
	addEventHandler("onResourceStart", getRootElement(), sightlangProcessExports, true, "high+9999999999")
end
local signal4 = false
local signal3 = false
local signal2 = false
local signal1 = false
local function sightlangGuiRefreshColors()
	local res = getResourceFromName("sGui")
	if res and getResourceState(res) == "running" then
		signal4 = sightexports.sGui:getFaIconFilename("signal-alt", 24)
		signal3 = sightexports.sGui:getFaIconFilename("signal-alt-3", 24)
		signal2 = sightexports.sGui:getFaIconFilename("signal-alt-2", 24)
		signal1 = sightexports.sGui:getFaIconFilename("signal-alt-1", 24)
		refreshColors()
	end
end
addEventHandler("onGuiRefreshColors", getRootElement(), sightlangGuiRefreshColors)
addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangGuiRefreshColors)
local screenX, screenY = guiGetScreenSize()
local offset = 0
local maxOffset = 0
local cols = {
	0.08,
	0.12,
	0.61,
	0.82
}
local rows = 0
local rowElements = {}
local rowH = 35
local progressH = 4
local width = math.max(400, math.floor(screenX / 4 + 20))
local height = math.floor(screenY * 0.6 + 0.5)
local helperColor = {
	255,
	255,
	255
}
function refreshColors()
	local sightred = sightexports.sGui:getColorCode("sightred-second")
	local sightpurple = sightexports.sGui:getColorCode("sightpurple-second")
	helperColor[1] = (sightred[1] + sightpurple[1]) / 2
	helperColor[2] = (sightred[2] + sightpurple[2]) / 2
	helperColor[3] = (sightred[3] + sightpurple[3]) / 2
end
local transparent = {
	255,
	255,
	255,
	0
}
local scoreboardGui = false
local playerDatas = {}
local maxPlayers = 1024
local typingState = {}
local consoleState = {}
local setPosition = false
function refreshPlayerList()
	for k = 1, rows - 1 do
		if rowElements[k] then
			if playerDatas[k + offset] then
				local font = playerDatas[k + offset][5] and "11/Ubuntu-R.ttf" or "11/Ubuntu-L.ttf"
				local textColor = playerDatas[k + offset][5] and helperColor or "#ffffff"
				if not playerDatas[k + offset][3] then
					textColor = "sightlightgrey"
				end
				if not isElement(playerDatas[k + offset][7]) then
					sightexports.sGui:setLabelText(rowElements[k][4], "kilépett a szerverről")
					sightexports.sGui:setImageColor(rowElements[k][6], transparent)
					sightexports.sGui:setLabelColor(rowElements[k][2], textColor)
					sightexports.sGui:setLabelColor(rowElements[k][3], textColor)
					sightexports.sGui:setLabelColor(rowElements[k][4], textColor)
				elseif playerDatas[k + offset][3] and not playerDatas[k + offset][4] then
					font = "11/Ubuntu-R.ttf"
					local color = "sightgreen"
					local text = "Admin " .. playerDatas[k + offset][3]
					if playerDatas[k + offset][3] == 11 then
						color = "sightred"
						text = "Tulajdonos"
					elseif playerDatas[k + offset][3] == 10 then
						color = "sightblue"
						text = "Fejlesztő"
					elseif playerDatas[k + offset][3] == 9 then
						color = "sightblue-second"
						text = "SysEngineer"
					elseif playerDatas[k + offset][3] == 8 then
						color = "sightgreen-second"
						text = "Manager"
					elseif playerDatas[k + offset][3] == 7 then
						color = "sightorange"
						text = "SzuperAdmin"
					elseif playerDatas[k + offset][3] == 6 then
						color = "sightyellow"
						text = "FőAdmin"
					end
					sightexports.sGui:setLabelColor(rowElements[k][5], color)
					sightexports.sGui:setImageColor(rowElements[k][6], transparent)
					sightexports.sGui:setLabelText(rowElements[k][4], text)
					sightexports.sGui:setLabelColor(rowElements[k][2], color)
					sightexports.sGui:setLabelColor(rowElements[k][3], color)
					sightexports.sGui:setLabelColor(rowElements[k][4], color)
				else
					sightexports.sGui:setLabelColor(rowElements[k][5], "sightgreen")
					if playerDatas[k + offset][3] then
						sightexports.sGui:setLabelText(rowElements[k][4], "Lvl " .. playerDatas[k + offset][3])
						sightexports.sGui:setImageColor(rowElements[k][6], "sightgreen")
					else
						sightexports.sGui:setLabelText(rowElements[k][4], "nincs bejelentkezve")
						sightexports.sGui:setImageColor(rowElements[k][6], transparent)
					end
					sightexports.sGui:setLabelColor(rowElements[k][2], textColor)
					sightexports.sGui:setLabelColor(rowElements[k][3], textColor)
					sightexports.sGui:setLabelColor(rowElements[k][4], textColor)
				end
				sightexports.sGui:setLabelText(rowElements[k][2], playerDatas[k + offset][1])
				sightexports.sGui:setLabelFont(rowElements[k][2], font)
				sightexports.sGui:setLabelText(rowElements[k][3], playerDatas[k + offset][2])
				sightexports.sGui:setLabelFont(rowElements[k][3], font)
				sightexports.sGui:setLabelFont(rowElements[k][4], font)
				if playerDatas[k + offset][3] then
					local afkStart = sightexports.sNames:getPlayerAfkStart(playerDatas[k + offset][7])
					if afkStart then
						local delta = math.max(0, math.floor((getTickCount() - afkStart) / 1000))
						local afkMin = math.floor(delta / 60)
						if 60 <= afkMin then
							sightexports.sGui:setLabelText(rowElements[k][5], "AFK: " .. math.floor(afkMin / 60) .. "h")
							sightexports.sGui:setLabelColor(rowElements[k][5], "sightred")
						else
							local afkSec = delta - afkMin * 60
							sightexports.sGui:setLabelText(rowElements[k][5], "AFK: " .. string.format("%02d:%02d", afkMin, afkSec))
							sightexports.sGui:setLabelColor(rowElements[k][5], 20 <= afkMin and "sightred" or 10 <= afkMin and "sightorange" or "sightlightgrey")
						end
						sightexports.sGui:setImageColor(rowElements[k][6], transparent)
					else
						local ping = playerDatas[k + offset][4]
						sightexports.sGui:setLabelText(rowElements[k][5], ping and (999 < ping and "999+" or ping .. "ms") or "on duty")
						--[[
						if not ping then
							local guiPosition = {exports.sGui:getGuiPosition(rowElements[k][5])}
							if guiPosition[1] + 15 < 360 then
								exports.sGui:setGuiPosition(rowElements[k][5], guiPosition[1] + 15, guiPosition[2])
							end
						end
						]]
						if ping then
							if 300 <= ping then
								sightexports.sGui:setLabelColor(rowElements[k][5], "sightred")
								sightexports.sGui:setImageColor(rowElements[k][6], "sightred")
								sightexports.sGui:setImageFile(rowElements[k][6], signal1)
							elseif 200 <= ping then
								sightexports.sGui:setLabelColor(rowElements[k][5], "sightorange")
								sightexports.sGui:setImageColor(rowElements[k][6], "sightorange")
								sightexports.sGui:setImageFile(rowElements[k][6], signal2)
							elseif 100 <= ping then
								sightexports.sGui:setLabelColor(rowElements[k][5], "sightyellow")
								sightexports.sGui:setImageColor(rowElements[k][6], "sightyellow")
								sightexports.sGui:setImageFile(rowElements[k][6], signal3)
							else
								sightexports.sGui:setLabelColor(rowElements[k][5], "sightgreen")
								sightexports.sGui:setImageColor(rowElements[k][6], "sightgreen")
								sightexports.sGui:setImageFile(rowElements[k][6], signal4)
							end
						end
					end
				else
					sightexports.sGui:setLabelText(rowElements[k][5], "")
				end
				sightexports.sGui:setLabelFont(rowElements[k][5], font)
			end
		else
			sightexports.sGui:setImageColor(rowElements[k][6], transparent)
			sightexports.sGui:setLabelText(rowElements[k][2], "")
			sightexports.sGui:setLabelText(rowElements[k][3], "")
			sightexports.sGui:setLabelText(rowElements[k][4], "")
			sightexports.sGui:setLabelText(rowElements[k][5], "")
		end
	end
end
local refreshTimer = false
function refreshFunction()
	for k = #playerDatas, 1, -1 do
		if playerDatas[k] then
			if isElement(playerDatas[k][7]) then
				if playerDatas[k][4] then
					playerDatas[k][4] = getPlayerPing(playerDatas[k][7])
				end
			else
				playerDatas[k][3] = nil
				playerDatas[k][7] = nil
			end
		end
	end
	maxOffset = math.max(0, #playerDatas - (rows - 1))
	offset = math.min(offset, maxOffset)
	refreshPlayerList()
end
local screenShader = false
local screenSrc = false
local shaderSource = [[
texture texture0; 
float factor; 
  
sampler Sampler0 = sampler_state 
{ 
    Texture = (texture0); 
    AddressU = MIRROR; 
    AddressV = MIRROR; 
}; 
  
struct PSInput 
{ 
  float2 TexCoord : TEXCOORD0; 
}; 
  
float4 PixelShader_Background(PSInput PS) : COLOR0 
{ 
        float4 sum = tex2D(Sampler0, PS.TexCoord); 
        for (float i = 1; i < 3; i++) { 
                sum += tex2D(Sampler0, float2(PS.TexCoord.x, PS.TexCoord.y + (i * factor))); 
                sum += tex2D(Sampler0, float2(PS.TexCoord.x, PS.TexCoord.y - (i * factor))); 
                sum += tex2D(Sampler0, float2(PS.TexCoord.x - (i * factor), PS.TexCoord.y)); 
                sum += tex2D(Sampler0, float2(PS.TexCoord.x + (i * factor), PS.TexCoord.y)); 
        } 
        sum /= 9; 
        sum.a = 1.0; 
        return sum; 
} 
  
technique complercated 
{ 
    pass P0 
    { 
        PixelShader = compile ps_2_0 PixelShader_Background(); 
    } 
} 
  
technique simple 
{ 
    pass P0 
    { 
        Texture[0] = texture0; 
    } 
} 

]]
addEventHandler("onClientKey", getRootElement(), function(key, por)

	airsoft = exports.sAirsoft:isInMatch()

	if key == "tab" then
		if scoreboardGui then
			sightexports.sGui:deleteGuiElement(scoreboardGui)
		end
		scoreboardGui = false
		if isTimer(refreshTimer) then
			killTimer(refreshTimer)
		end
		refreshTimer = false
		if isElement(screenShader) then
			destroyElement(screenShader)
		end
		screenShader = false
		if isElement(screenSrc) then
			destroyElement(screenSrc)
		end
		screenSrc = false
		if por and not sightexports.sGui:getActiveInput() then
			screenSrc = dxCreateScreenSource(screenX, screenY)
			screenShader = dxCreateShader(shaderSource)
			dxSetShaderValue(screenShader, "UVSize", screenX, screenY)
			dxSetShaderValue(screenShader, "factor", 8.0E-4)
			dxSetShaderValue(screenShader, "texture0", screenSrc)
			playerDatas = {}
			local players = getElementsByType("player")
			for k = 1, #players do
				if isElement(players[k]) then
					local playerID = getElementData(players[k], "playerID")
					if playerID then
						local name = utf8.gsub(getElementData(players[k], "visibleName") or getPlayerName(players[k]), "_", " ")
						if getElementData(players[k], "loggedIn") then
							if getElementData(players[k], "adminDuty") then
								table.insert(playerDatas, {
									playerID,
									utf8.gsub(getElementData(players[k], "acc.adminNick"), "_", " "),
									getElementData(players[k], "acc.adminLevel"),
									false,
									false,
									players[k] == localPlayer and 1 or 0,
									players[k]
								})
							elseif 0 < (getElementData(players[k], "acc.helperLevel") or 0) then
								table.insert(playerDatas, {
									playerID,
									name,
									getElementData(players[k], "char.level"),
									getPlayerPing(players[k]),
									true,
									players[k] == localPlayer and 1 or 0,
									players[k]
								})
							else
								table.insert(playerDatas, {
									playerID,
									name,
									getElementData(players[k], "char.level"),
									getPlayerPing(players[k]),
									false,
									players[k] == localPlayer and 1 or 0,
									players[k]
								})
							end
						else
							table.insert(playerDatas, {
								playerID,
								name,
								false,
								false,
								false,
								players[k] == localPlayer and 1 or 0,
								players[k]
							})
						end
					end
				end
			end
			table.sort(playerDatas, function(a, b)
				if a[6] ~= b[6] then
					return a[6] > b[6]
				end
				return a[1] < b[1]
			end)
			refreshTimer = setTimer(refreshFunction, 500, 0)
			scoreboardGui = sightexports.sGui:createGuiElement("image", 0, 0, screenX, screenY)

			sightexports.sGui:setImageFile(scoreboardGui, screenShader)
			sightexports.sGui:updateScreenSourceBefore(scoreboardGui, screenSrc, true)
			local textH = sightexports.sGui:getFontHeight("25/BebasNeueRegular.otf")
			rows = math.floor((height - textH - progressH) / rowH)
			maxOffset = math.max(0, #playerDatas - (rows - 1))
			offset = math.min(offset, maxOffset)
			height = rows * rowH + textH + progressH
			local x = screenX / 2 - width / 2
			local y = screenY / 2 - height / 2
			local label = sightexports.sGui:createGuiElement("label", x, y, width, textH, scoreboardGui)
			sightexports.sGui:setLabelText(label, "SightMTA ")
			sightexports.sGui:setLabelFont(label, "25/BebasNeueRegular.otf")
			sightexports.sGui:setLabelAlignment(label, "left", "bottom")
			sightexports.sGui:setLabelShadow(label, "#000000ae", 1, 1)
			local label = sightexports.sGui:createGuiElement("label", x + sightexports.sGui:getLabelTextWidth(label), y, width, textH, scoreboardGui)
			if airsoft then
				sightexports.sGui:setLabelText(label, "AIRSOFT")
			else
				sightexports.sGui:setLabelText(label, "SCOREBOARD")
			end
			sightexports.sGui:setLabelFont(label, "25/BebasNeueLight.otf")
			sightexports.sGui:setLabelAlignment(label, "left", "bottom")
			sightexports.sGui:setLabelShadow(label, "#000000ae", 1, 1)
			if not airsoft then
				local label = sightexports.sGui:createGuiElement("label", x, y, width, textH, scoreboardGui)
				sightexports.sGui:setLabelText(label, #playerDatas .. "/" .. maxPlayers)
				sightexports.sGui:setLabelFont(label, "20/BebasNeueLight.otf")
				sightexports.sGui:setLabelAlignment(label, "right", "bottom")
				sightexports.sGui:setLabelShadow(label, "#000000ae", 1, 1)
			end
			y = y + textH
			local topRow = sightexports.sGui:createGuiElement("rectangle", x, y, width, rowH, scoreboardGui)

			if airsoft then
				exports.sAirsoft:setScoreboard(topRow, width, height, 0, 0)

				local label = sightexports.sGui:createGuiElement("label", x, y, width, height + 35, scoreboardGui)
				sightexports.sGui:setLabelAlignment(label, "center", "bottom")
				sightexports.sGui:setLabelFont(label, "11/Ubuntu-B.ttf")
				sightexports.sGui:setLabelText(label, "A normál scoreboard megtekintéséhez tartsd lenyomva a [Shift] gombot.")
				sightexports.sGui:setLabelShadow(label, "#000000ae", 1, 1)
				rows = 0
				return
			end
			

			sightexports.sGui:setGuiBackground(topRow, "solid", "sightgrey1")
			local label = sightexports.sGui:createGuiElement("label", x, y, width * cols[1], rowH, scoreboardGui)
			sightexports.sGui:setLabelText(label, "ID")
			sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
			sightexports.sGui:setLabelAlignment(label, "right", "center")
			local label = sightexports.sGui:createGuiElement("label", x + width * cols[2], y, 0, rowH, scoreboardGui)
			sightexports.sGui:setLabelText(label, "Név")
			sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
			sightexports.sGui:setLabelAlignment(label, "left", "center")
			local label = sightexports.sGui:createGuiElement("label", x + width * cols[3], y, 0, rowH, scoreboardGui)
			sightexports.sGui:setLabelText(label, "Szint")
			sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
			sightexports.sGui:setLabelAlignment(label, "left", "center")
			local label = sightexports.sGui:createGuiElement("label", x + (width + 10) * cols[4], y, 0, rowH, scoreboardGui)
			sightexports.sGui:setLabelText(label, "Ping")
			sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
			sightexports.sGui:setLabelAlignment(label, "left", "center")
			local progressBg = sightexports.sGui:createGuiElement("rectangle", x, y + rowH, width, progressH, scoreboardGui)
			sightexports.sGui:setGuiBackground(progressBg, "solid", "sightlightgrey")
			local progress = sightexports.sGui:createGuiElement("rectangle", x, y + rowH, width * (#playerDatas / maxPlayers), progressH, scoreboardGui)
			sightexports.sGui:setGuiBackground(progress, "solid", "sightgreen")
			y = y + rowH + progressH
			for k = 1, rows - 1 do
				rowElements[k] = {}
				if playerDatas[k] and k < rows - 1 then
					rowElements[k][1] = sightexports.sGui:createGuiElement("rectangle", x, y, width, rowH - 2, scoreboardGui)
					local border = sightexports.sGui:createGuiElement("hr", x, y + rowH - 2, width, 2, scoreboardGui)
				else
					rowElements[k][1] = sightexports.sGui:createGuiElement("rectangle", x, y, width, rowH, scoreboardGui)
				end
				sightexports.sGui:setGuiBackground(rowElements[k][1], "solid", "sightgrey2")
				y = y + rowH
				if playerDatas[k] then
					local x, y = 0, 0
					sightexports.sGui:setGuiHover(rowElements[k][1], "gradient", {
						"sightgrey3",
						"sightgrey2",
						true
					}, false, true)
					sightexports.sGui:setGuiHoverable(rowElements[k][1], true)
					local font = "11/Ubuntu-L.ttf"
					rowElements[k][2] = sightexports.sGui:createGuiElement("label", x, y, width * cols[1], rowH, rowElements[k][1])
					sightexports.sGui:setLabelText(rowElements[k][2], "")
					sightexports.sGui:setLabelFont(rowElements[k][2], font)
					sightexports.sGui:setLabelAlignment(rowElements[k][2], "right", "center")
					rowElements[k][3] = sightexports.sGui:createGuiElement("label", x + width * cols[2], y, width * (cols[3] - cols[2]) - 4, rowH, rowElements[k][1])
					sightexports.sGui:setLabelText(rowElements[k][3], "")
					sightexports.sGui:setLabelFont(rowElements[k][3], font)
					sightexports.sGui:setLabelAlignment(rowElements[k][3], "left", "center")
					sightexports.sGui:setLabelClip(rowElements[k][3], true)
					rowElements[k][4] = sightexports.sGui:createGuiElement("label", x + width * cols[3], y, 0, rowH, rowElements[k][1])
					sightexports.sGui:setLabelText(rowElements[k][4], "")
					sightexports.sGui:setLabelFont(rowElements[k][4], font)
					sightexports.sGui:setLabelAlignment(rowElements[k][4], "left", "center")
					rowElements[k][5] = sightexports.sGui:createGuiElement("label", x + (width + 10) * cols[4], y, 0, rowH, rowElements[k][1])
					sightexports.sGui:setLabelText(rowElements[k][5], "")
					sightexports.sGui:setLabelFont(rowElements[k][5], font)
					sightexports.sGui:setLabelAlignment(rowElements[k][5], "left", "center")
					rowElements[k][6] = sightexports.sGui:createGuiElement("image", x + width - rowH / 2 - 12, y + rowH / 2 - 12, 24, 24, rowElements[k][1])
					sightexports.sGui:setImageFile(rowElements[k][6], signal4)
					sightexports.sGui:setImageColor(rowElements[k][6], "sightgreen")
				end
			end
			refreshPlayerList()
		end
	elseif key == "mouse_wheel_up" then
		if scoreboardGui and 0 < offset then
			offset = offset - 1
			refreshPlayerList()
		end
	elseif key == "mouse_wheel_down" and scoreboardGui and offset < maxOffset then
		offset = offset + 1
		refreshPlayerList()
	elseif key == "lshift" and por and airsoft and getKeyState("tab") then
		if airsoft then
			if scoreboardGui then
				sightexports.sGui:deleteGuiElement(scoreboardGui)
			end
			scoreboardGui = false
			if isTimer(refreshTimer) then
				killTimer(refreshTimer)
			end
			refreshTimer = false
			if isElement(screenShader) then
				destroyElement(screenShader)
			end
			screenShader = false
			if isElement(screenSrc) then
				destroyElement(screenSrc)
			end
			screenSrc = false
			if por and not sightexports.sGui:getActiveInput() then
				screenSrc = dxCreateScreenSource(screenX, screenY)
				screenShader = dxCreateShader(shaderSource)
				dxSetShaderValue(screenShader, "UVSize", screenX, screenY)
				dxSetShaderValue(screenShader, "factor", 8.0E-4)
				dxSetShaderValue(screenShader, "texture0", screenSrc)
				playerDatas = {}
				local players = getElementsByType("player")
				for k = 1, #players do
					if isElement(players[k]) then
						local playerID = getElementData(players[k], "playerID")
						if playerID then
							local name = utf8.gsub(getElementData(players[k], "visibleName") or getPlayerName(players[k]), "_", " ")
							if getElementData(players[k], "loggedIn") then
								if getElementData(players[k], "adminDuty") then
									table.insert(playerDatas, {
										playerID,
										utf8.gsub(getElementData(players[k], "acc.adminNick"), "_", " "),
										getElementData(players[k], "acc.adminLevel"),
										false,
										false,
										players[k] == localPlayer and 1 or 0,
										players[k]
									})
								elseif 0 < (getElementData(players[k], "acc.helperLevel") or 0) then
									table.insert(playerDatas, {
										playerID,
										name,
										getElementData(players[k], "char.level"),
										getPlayerPing(players[k]),
										true,
										players[k] == localPlayer and 1 or 0,
										players[k]
									})
								else
									table.insert(playerDatas, {
										playerID,
										name,
										getElementData(players[k], "char.level"),
										getPlayerPing(players[k]),
										false,
										players[k] == localPlayer and 1 or 0,
										players[k]
									})
								end
							else
								table.insert(playerDatas, {
									playerID,
									name,
									false,
									false,
									false,
									players[k] == localPlayer and 1 or 0,
									players[k]
								})
							end
						end
					end
				end
				table.sort(playerDatas, function(a, b)
					if a[6] ~= b[6] then
						return a[6] > b[6]
					end
					return a[1] < b[1]
				end)
				refreshTimer = setTimer(refreshFunction, 500, 0)
				scoreboardGui = sightexports.sGui:createGuiElement("image", 0, 0, screenX, screenY)
	
				sightexports.sGui:setImageFile(scoreboardGui, screenShader)
				sightexports.sGui:updateScreenSourceBefore(scoreboardGui, screenSrc, true)
				local textH = sightexports.sGui:getFontHeight("25/BebasNeueRegular.otf")
				rows = math.floor((height - textH - progressH) / rowH)
				maxOffset = math.max(0, #playerDatas - (rows - 1))
				offset = math.min(offset, maxOffset)
				height = rows * rowH + textH + progressH
				local x = screenX / 2 - width / 2
				local y = screenY / 2 - height / 2
				local label = sightexports.sGui:createGuiElement("label", x, y, width, textH, scoreboardGui)
				sightexports.sGui:setLabelText(label, "SightMTA ")
				sightexports.sGui:setLabelFont(label, "25/BebasNeueRegular.otf")
				sightexports.sGui:setLabelAlignment(label, "left", "bottom")
				sightexports.sGui:setLabelShadow(label, "#000000ae", 1, 1)
				local label = sightexports.sGui:createGuiElement("label", x + sightexports.sGui:getLabelTextWidth(label), y, width, textH, scoreboardGui)
				sightexports.sGui:setLabelText(label, "SCOREBOARD")
				
				sightexports.sGui:setLabelFont(label, "25/BebasNeueLight.otf")
				sightexports.sGui:setLabelAlignment(label, "left", "bottom")
				sightexports.sGui:setLabelShadow(label, "#000000ae", 1, 1)
				local label = sightexports.sGui:createGuiElement("label", x, y, width, textH, scoreboardGui)
				sightexports.sGui:setLabelText(label, #playerDatas .. "/" .. maxPlayers)
				sightexports.sGui:setLabelFont(label, "20/BebasNeueLight.otf")
				sightexports.sGui:setLabelAlignment(label, "right", "bottom")
				sightexports.sGui:setLabelShadow(label, "#000000ae", 1, 1)
				y = y + textH
				local topRow = sightexports.sGui:createGuiElement("rectangle", x, y, width, rowH, scoreboardGui)
	
				sightexports.sGui:setGuiBackground(topRow, "solid", "sightgrey1")
				local label = sightexports.sGui:createGuiElement("label", x, y, width * cols[1], rowH, scoreboardGui)
				sightexports.sGui:setLabelText(label, "ID")
				sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
				sightexports.sGui:setLabelAlignment(label, "right", "center")
				local label = sightexports.sGui:createGuiElement("label", x + width * cols[2], y, 0, rowH, scoreboardGui)
				sightexports.sGui:setLabelText(label, "Név")
				sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
				sightexports.sGui:setLabelAlignment(label, "left", "center")
				local label = sightexports.sGui:createGuiElement("label", x + width * cols[3], y, 0, rowH, scoreboardGui)
				sightexports.sGui:setLabelText(label, "Szint")
				sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
				sightexports.sGui:setLabelAlignment(label, "left", "center")
				local label = sightexports.sGui:createGuiElement("label", x + (width + 10) * cols[4], y, 0, rowH, scoreboardGui)
				sightexports.sGui:setLabelText(label, "Ping")
				sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
				sightexports.sGui:setLabelAlignment(label, "left", "center")
				local progressBg = sightexports.sGui:createGuiElement("rectangle", x, y + rowH, width, progressH, scoreboardGui)
				sightexports.sGui:setGuiBackground(progressBg, "solid", "sightlightgrey")
				local progress = sightexports.sGui:createGuiElement("rectangle", x, y + rowH, width * (#playerDatas / maxPlayers), progressH, scoreboardGui)
				sightexports.sGui:setGuiBackground(progress, "solid", "sightgreen")
				y = y + rowH + progressH
				for k = 1, rows - 1 do
					rowElements[k] = {}
					if playerDatas[k] and k < rows - 1 then
						rowElements[k][1] = sightexports.sGui:createGuiElement("rectangle", x, y, width, rowH - 2, scoreboardGui)
						local border = sightexports.sGui:createGuiElement("hr", x, y + rowH - 2, width, 2, scoreboardGui)
					else
						rowElements[k][1] = sightexports.sGui:createGuiElement("rectangle", x, y, width, rowH, scoreboardGui)
					end
					sightexports.sGui:setGuiBackground(rowElements[k][1], "solid", "sightgrey2")
					y = y + rowH
					if playerDatas[k] then
						local x, y = 0, 0
						sightexports.sGui:setGuiHover(rowElements[k][1], "gradient", {
							"sightgrey3",
							"sightgrey2",
							true
						}, false, true)
						sightexports.sGui:setGuiHoverable(rowElements[k][1], true)
						local font = "11/Ubuntu-L.ttf"
						rowElements[k][2] = sightexports.sGui:createGuiElement("label", x, y, width * cols[1], rowH, rowElements[k][1])
						sightexports.sGui:setLabelText(rowElements[k][2], "")
						sightexports.sGui:setLabelFont(rowElements[k][2], font)
						sightexports.sGui:setLabelAlignment(rowElements[k][2], "right", "center")
						rowElements[k][3] = sightexports.sGui:createGuiElement("label", x + width * cols[2], y, width * (cols[3] - cols[2]) - 4, rowH, rowElements[k][1])
						sightexports.sGui:setLabelText(rowElements[k][3], "")
						sightexports.sGui:setLabelFont(rowElements[k][3], font)
						sightexports.sGui:setLabelAlignment(rowElements[k][3], "left", "center")
						sightexports.sGui:setLabelClip(rowElements[k][3], true)
						rowElements[k][4] = sightexports.sGui:createGuiElement("label", x + width * cols[3], y, 0, rowH, rowElements[k][1])
						sightexports.sGui:setLabelText(rowElements[k][4], "")
						sightexports.sGui:setLabelFont(rowElements[k][4], font)
						sightexports.sGui:setLabelAlignment(rowElements[k][4], "left", "center")
						rowElements[k][5] = sightexports.sGui:createGuiElement("label", x + (width + 10) * cols[4], y, 0, rowH, rowElements[k][1])
						sightexports.sGui:setLabelText(rowElements[k][5], "")
						sightexports.sGui:setLabelFont(rowElements[k][5], font)
						sightexports.sGui:setLabelAlignment(rowElements[k][5], "left", "center")
						rowElements[k][6] = sightexports.sGui:createGuiElement("image", x + width - rowH / 2 - 12, y + rowH / 2 - 12, 24, 24, rowElements[k][1])
						sightexports.sGui:setImageFile(rowElements[k][6], signal4)
						sightexports.sGui:setImageColor(rowElements[k][6], "sightgreen")
					end
				end
				refreshPlayerList()
			end
		end
	elseif key == "lshift" and not por and airsoft and getKeyState("tab") then
		
		if scoreboardGui then
			sightexports.sGui:deleteGuiElement(scoreboardGui)
		end
		scoreboardGui = false
		if isTimer(refreshTimer) then
			killTimer(refreshTimer)
		end
		refreshTimer = false
		if isElement(screenShader) then
			destroyElement(screenShader)
		end
		screenShader = false
		if isElement(screenSrc) then
			destroyElement(screenSrc)
		end
		screenSrc = false
		if not sightexports.sGui:getActiveInput() then
			screenSrc = dxCreateScreenSource(screenX, screenY)
			screenShader = dxCreateShader(shaderSource)
			dxSetShaderValue(screenShader, "UVSize", screenX, screenY)
			dxSetShaderValue(screenShader, "factor", 8.0E-4)
			dxSetShaderValue(screenShader, "texture0", screenSrc)
			playerDatas = {}
			local players = getElementsByType("player")
			for k = 1, #players do
				if isElement(players[k]) then
					local playerID = getElementData(players[k], "playerID")
					if playerID then
						local name = utf8.gsub(getElementData(players[k], "visibleName") or getPlayerName(players[k]), "_", " ")
						if getElementData(players[k], "loggedIn") then
							if getElementData(players[k], "adminDuty") then
								table.insert(playerDatas, {
									playerID,
									utf8.gsub(getElementData(players[k], "acc.adminNick"), "_", " "),
									getElementData(players[k], "acc.adminLevel"),
									false,
									false,
									players[k] == localPlayer and 1 or 0,
									players[k]
								})
							elseif 0 < (getElementData(players[k], "acc.helperLevel") or 0) then
								table.insert(playerDatas, {
									playerID,
									name,
									getElementData(players[k], "char.level"),
									getPlayerPing(players[k]),
									true,
									players[k] == localPlayer and 1 or 0,
									players[k]
								})
							else
								table.insert(playerDatas, {
									playerID,
									name,
									getElementData(players[k], "char.level"),
									getPlayerPing(players[k]),
									false,
									players[k] == localPlayer and 1 or 0,
									players[k]
								})
							end
						else
							table.insert(playerDatas, {
								playerID,
								name,
								false,
								false,
								false,
								players[k] == localPlayer and 1 or 0,
								players[k]
							})
						end
					end
				end
			end
			table.sort(playerDatas, function(a, b)
				if a[6] ~= b[6] then
					return a[6] > b[6]
				end
				return a[1] < b[1]
			end)
			refreshTimer = setTimer(refreshFunction, 500, 0)
			scoreboardGui = sightexports.sGui:createGuiElement("image", 0, 0, screenX, screenY)

			sightexports.sGui:setImageFile(scoreboardGui, screenShader)
			sightexports.sGui:updateScreenSourceBefore(scoreboardGui, screenSrc, true)
			local textH = sightexports.sGui:getFontHeight("25/BebasNeueRegular.otf")
			rows = math.floor((height - textH - progressH) / rowH)
			maxOffset = math.max(0, #playerDatas - (rows - 1))
			offset = math.min(offset, maxOffset)
			height = rows * rowH + textH + progressH
			local x = screenX / 2 - width / 2
			local y = screenY / 2 - height / 2
			local label = sightexports.sGui:createGuiElement("label", x, y, width, textH, scoreboardGui)
			sightexports.sGui:setLabelText(label, "SightMTA ")
			sightexports.sGui:setLabelFont(label, "25/BebasNeueRegular.otf")
			sightexports.sGui:setLabelAlignment(label, "left", "bottom")
			sightexports.sGui:setLabelShadow(label, "#000000ae", 1, 1)
			local label = sightexports.sGui:createGuiElement("label", x + sightexports.sGui:getLabelTextWidth(label), y, width, textH, scoreboardGui)
			if airsoft then
				sightexports.sGui:setLabelText(label, "AIRSOFT")
			else
				sightexports.sGui:setLabelText(label, "SCOREBOARD")
			end
			sightexports.sGui:setLabelFont(label, "25/BebasNeueLight.otf")
			sightexports.sGui:setLabelAlignment(label, "left", "bottom")
			sightexports.sGui:setLabelShadow(label, "#000000ae", 1, 1)
			if not airsoft then
				local label = sightexports.sGui:createGuiElement("label", x, y, width, textH, scoreboardGui)
				sightexports.sGui:setLabelText(label, #playerDatas .. "/" .. maxPlayers)
				sightexports.sGui:setLabelFont(label, "20/BebasNeueLight.otf")
				sightexports.sGui:setLabelAlignment(label, "right", "bottom")
				sightexports.sGui:setLabelShadow(label, "#000000ae", 1, 1)
			end
			y = y + textH
			local topRow = sightexports.sGui:createGuiElement("rectangle", x, y, width, rowH, scoreboardGui)

			if airsoft then
				exports.sAirsoft:setScoreboard(topRow, width, height, 0, 0)

				local label = sightexports.sGui:createGuiElement("label", x, y, width, height + 35, scoreboardGui)
				sightexports.sGui:setLabelAlignment(label, "center", "bottom")
				sightexports.sGui:setLabelFont(label, "11/Ubuntu-B.ttf")
				sightexports.sGui:setLabelText(label, "A normál scoreboard megetkintéséhez tartsd lenyomva a [Shift] gombot.")
				sightexports.sGui:setLabelShadow(label, "#000000ae", 1, 1)
				rows = 0
				return
			end
			

			sightexports.sGui:setGuiBackground(topRow, "solid", "sightgrey1")
			local label = sightexports.sGui:createGuiElement("label", x, y, width * cols[1], rowH, scoreboardGui)
			sightexports.sGui:setLabelText(label, "ID")
			sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
			sightexports.sGui:setLabelAlignment(label, "right", "center")
			local label = sightexports.sGui:createGuiElement("label", x + width * cols[2], y, 0, rowH, scoreboardGui)
			sightexports.sGui:setLabelText(label, "Név")
			sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
			sightexports.sGui:setLabelAlignment(label, "left", "center")
			local label = sightexports.sGui:createGuiElement("label", x + width * cols[3], y, 0, rowH, scoreboardGui)
			sightexports.sGui:setLabelText(label, "Szint")
			sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
			sightexports.sGui:setLabelAlignment(label, "left", "center")
			local label = sightexports.sGui:createGuiElement("label", x + (width + 10) * cols[4], y, 0, rowH, scoreboardGui)
			sightexports.sGui:setLabelText(label, "Ping")
			sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
			sightexports.sGui:setLabelAlignment(label, "left", "center")
			local progressBg = sightexports.sGui:createGuiElement("rectangle", x, y + rowH, width, progressH, scoreboardGui)
			sightexports.sGui:setGuiBackground(progressBg, "solid", "sightlightgrey")
			local progress = sightexports.sGui:createGuiElement("rectangle", x, y + rowH, width * (#playerDatas / maxPlayers), progressH, scoreboardGui)
			sightexports.sGui:setGuiBackground(progress, "solid", "sightgreen")
			y = y + rowH + progressH
			for k = 1, rows - 1 do
				rowElements[k] = {}
				if playerDatas[k] and k < rows - 1 then
					rowElements[k][1] = sightexports.sGui:createGuiElement("rectangle", x, y, width, rowH - 2, scoreboardGui)
					local border = sightexports.sGui:createGuiElement("hr", x, y + rowH - 2, width, 2, scoreboardGui)
				else
					rowElements[k][1] = sightexports.sGui:createGuiElement("rectangle", x, y, width, rowH, scoreboardGui)
				end
				sightexports.sGui:setGuiBackground(rowElements[k][1], "solid", "sightgrey2")
				y = y + rowH
				if playerDatas[k] then
					local x, y = 0, 0
					sightexports.sGui:setGuiHover(rowElements[k][1], "gradient", {
						"sightgrey3",
						"sightgrey2",
						true
					}, false, true)
					sightexports.sGui:setGuiHoverable(rowElements[k][1], true)
					local font = "11/Ubuntu-L.ttf"
					rowElements[k][2] = sightexports.sGui:createGuiElement("label", x, y, width * cols[1], rowH, rowElements[k][1])
					sightexports.sGui:setLabelText(rowElements[k][2], "")
					sightexports.sGui:setLabelFont(rowElements[k][2], font)
					sightexports.sGui:setLabelAlignment(rowElements[k][2], "right", "center")
					rowElements[k][3] = sightexports.sGui:createGuiElement("label", x + width * cols[2], y, width * (cols[3] - cols[2]) - 4, rowH, rowElements[k][1])
					sightexports.sGui:setLabelText(rowElements[k][3], "")
					sightexports.sGui:setLabelFont(rowElements[k][3], font)
					sightexports.sGui:setLabelAlignment(rowElements[k][3], "left", "center")
					sightexports.sGui:setLabelClip(rowElements[k][3], true)
					rowElements[k][4] = sightexports.sGui:createGuiElement("label", x + width * cols[3], y, 0, rowH, rowElements[k][1])
					sightexports.sGui:setLabelText(rowElements[k][4], "")
					sightexports.sGui:setLabelFont(rowElements[k][4], font)
					sightexports.sGui:setLabelAlignment(rowElements[k][4], "left", "center")
					rowElements[k][5] = sightexports.sGui:createGuiElement("label", x + (width + 10) * cols[4], y, 0, rowH, rowElements[k][1])
					sightexports.sGui:setLabelText(rowElements[k][5], "")
					sightexports.sGui:setLabelFont(rowElements[k][5], font)
					sightexports.sGui:setLabelAlignment(rowElements[k][5], "left", "center")
					rowElements[k][6] = sightexports.sGui:createGuiElement("image", x + width - rowH / 2 - 12, y + rowH / 2 - 12, 24, 24, rowElements[k][1])
					sightexports.sGui:setImageFile(rowElements[k][6], signal4)
					sightexports.sGui:setImageColor(rowElements[k][6], "sightgreen")
				end
			end
			refreshPlayerList()
		end
	end
end)
