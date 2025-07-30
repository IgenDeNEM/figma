local sightexports = {
	sVehicles = false,
	sGui = false,
	sChat = false,
	sJob_raktar = false,
	sMdc = false,
	sModloader = false,
	sHud = false,
	sDashboard = false
}

local cursorWas = {}
function setHandbrakeMode(por)
	handBrakeMode = por
	if handBrakeMode then
		local cx, cy = getCursorPosition()
		cursorWas = {cx, cy}
		showCursor(true)
		handbrakeState = isElementFrozen(currentVehicle)
		handbrakeSound = handbrakeState and 3 or 0
		handBrakeMode = handbrakeState and 1 or 0
		setCursorPosition(screenX / 2, screenY / 2 - (handbrakeState and -0.5 or 0.5) * screenY / 4)
	else
		if tonumber(cursorWas[1]) and tonumber(cursorWas[2]) then
			setCursorPosition(cursorWas[1] * screenX, cursorWas[2] * screenY)
		end
		showCursor(false)
	end
	sightexports.sGui:setCursorType(handBrakeMode and "none" or "normal")
end
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
local sightlangStatImgHand = false
local sightlangStaticImage = {}
local sightlangStaticImageToc = {}
local sightlangStaticImageUsed = {}
local sightlangStaticImageDel = {}
local processSightlangStaticImage = {}
sightlangStaticImageToc[0] = true
sightlangStaticImageToc[1] = true
sightlangStaticImageToc[2] = true
sightlangStaticImageToc[3] = true
sightlangStaticImageToc[4] = true
sightlangStaticImageToc[5] = true
sightlangStaticImageToc[6] = true
sightlangStaticImageToc[7] = true
sightlangStaticImageToc[8] = true
sightlangStaticImageToc[9] = true
sightlangStaticImageToc[10] = true
sightlangStaticImageToc[11] = true
sightlangStaticImageToc[12] = true
sightlangStaticImageToc[13] = true
sightlangStaticImageToc[14] = true
sightlangStaticImageToc[15] = true
sightlangStaticImageToc[16] = true
sightlangStaticImageToc[17] = true
sightlangStaticImageToc[18] = true
sightlangStaticImageToc[19] = true
sightlangStaticImageToc[20] = true
sightlangStaticImageToc[21] = true
sightlangStaticImageToc[22] = true
sightlangStaticImageToc[23] = true
sightlangStaticImageToc[24] = true
sightlangStaticImageToc[25] = true
sightlangStaticImageToc[26] = true
sightlangStaticImageToc[27] = true
sightlangStaticImageToc[28] = true
local sightlangStatImgPre
function sightlangStatImgPre()
	local now = getTickCount()
	if sightlangStaticImageUsed[0] then
		sightlangStaticImageUsed[0] = false
		sightlangStaticImageDel[0] = false
	elseif sightlangStaticImage[0] then
		if sightlangStaticImageDel[0] then
			if now >= sightlangStaticImageDel[0] then
				if isElement(sightlangStaticImage[0]) then
					destroyElement(sightlangStaticImage[0])
				end
				sightlangStaticImage[0] = nil
				sightlangStaticImageDel[0] = false
				sightlangStaticImageToc[0] = true
				return
			end
		else
			sightlangStaticImageDel[0] = now + 5000
		end
	else
		sightlangStaticImageToc[0] = true
	end
	if sightlangStaticImageUsed[1] then
		sightlangStaticImageUsed[1] = false
		sightlangStaticImageDel[1] = false
	elseif sightlangStaticImage[1] then
		if sightlangStaticImageDel[1] then
			if now >= sightlangStaticImageDel[1] then
				if isElement(sightlangStaticImage[1]) then
					destroyElement(sightlangStaticImage[1])
				end
				sightlangStaticImage[1] = nil
				sightlangStaticImageDel[1] = false
				sightlangStaticImageToc[1] = true
				return
			end
		else
			sightlangStaticImageDel[1] = now + 5000
		end
	else
		sightlangStaticImageToc[1] = true
	end
	if sightlangStaticImageUsed[2] then
		sightlangStaticImageUsed[2] = false
		sightlangStaticImageDel[2] = false
	elseif sightlangStaticImage[2] then
		if sightlangStaticImageDel[2] then
			if now >= sightlangStaticImageDel[2] then
				if isElement(sightlangStaticImage[2]) then
					destroyElement(sightlangStaticImage[2])
				end
				sightlangStaticImage[2] = nil
				sightlangStaticImageDel[2] = false
				sightlangStaticImageToc[2] = true
				return
			end
		else
			sightlangStaticImageDel[2] = now + 5000
		end
	else
		sightlangStaticImageToc[2] = true
	end
	if sightlangStaticImageUsed[3] then
		sightlangStaticImageUsed[3] = false
		sightlangStaticImageDel[3] = false
	elseif sightlangStaticImage[3] then
		if sightlangStaticImageDel[3] then
			if now >= sightlangStaticImageDel[3] then
				if isElement(sightlangStaticImage[3]) then
					destroyElement(sightlangStaticImage[3])
				end
				sightlangStaticImage[3] = nil
				sightlangStaticImageDel[3] = false
				sightlangStaticImageToc[3] = true
				return
			end
		else
			sightlangStaticImageDel[3] = now + 5000
		end
	else
		sightlangStaticImageToc[3] = true
	end
	if sightlangStaticImageUsed[4] then
		sightlangStaticImageUsed[4] = false
		sightlangStaticImageDel[4] = false
	elseif sightlangStaticImage[4] then
		if sightlangStaticImageDel[4] then
			if now >= sightlangStaticImageDel[4] then
				if isElement(sightlangStaticImage[4]) then
					destroyElement(sightlangStaticImage[4])
				end
				sightlangStaticImage[4] = nil
				sightlangStaticImageDel[4] = false
				sightlangStaticImageToc[4] = true
				return
			end
		else
			sightlangStaticImageDel[4] = now + 5000
		end
	else
		sightlangStaticImageToc[4] = true
	end
	if sightlangStaticImageUsed[5] then
		sightlangStaticImageUsed[5] = false
		sightlangStaticImageDel[5] = false
	elseif sightlangStaticImage[5] then
		if sightlangStaticImageDel[5] then
			if now >= sightlangStaticImageDel[5] then
				if isElement(sightlangStaticImage[5]) then
					destroyElement(sightlangStaticImage[5])
				end
				sightlangStaticImage[5] = nil
				sightlangStaticImageDel[5] = false
				sightlangStaticImageToc[5] = true
				return
			end
		else
			sightlangStaticImageDel[5] = now + 5000
		end
	else
		sightlangStaticImageToc[5] = true
	end
	if sightlangStaticImageUsed[6] then
		sightlangStaticImageUsed[6] = false
		sightlangStaticImageDel[6] = false
	elseif sightlangStaticImage[6] then
		if sightlangStaticImageDel[6] then
			if now >= sightlangStaticImageDel[6] then
				if isElement(sightlangStaticImage[6]) then
					destroyElement(sightlangStaticImage[6])
				end
				sightlangStaticImage[6] = nil
				sightlangStaticImageDel[6] = false
				sightlangStaticImageToc[6] = true
				return
			end
		else
			sightlangStaticImageDel[6] = now + 5000
		end
	else
		sightlangStaticImageToc[6] = true
	end
	if sightlangStaticImageUsed[7] then
		sightlangStaticImageUsed[7] = false
		sightlangStaticImageDel[7] = false
	elseif sightlangStaticImage[7] then
		if sightlangStaticImageDel[7] then
			if now >= sightlangStaticImageDel[7] then
				if isElement(sightlangStaticImage[7]) then
					destroyElement(sightlangStaticImage[7])
				end
				sightlangStaticImage[7] = nil
				sightlangStaticImageDel[7] = false
				sightlangStaticImageToc[7] = true
				return
			end
		else
			sightlangStaticImageDel[7] = now + 5000
		end
	else
		sightlangStaticImageToc[7] = true
	end
	if sightlangStaticImageUsed[8] then
		sightlangStaticImageUsed[8] = false
		sightlangStaticImageDel[8] = false
	elseif sightlangStaticImage[8] then
		if sightlangStaticImageDel[8] then
			if now >= sightlangStaticImageDel[8] then
				if isElement(sightlangStaticImage[8]) then
					destroyElement(sightlangStaticImage[8])
				end
				sightlangStaticImage[8] = nil
				sightlangStaticImageDel[8] = false
				sightlangStaticImageToc[8] = true
				return
			end
		else
			sightlangStaticImageDel[8] = now + 5000
		end
	else
		sightlangStaticImageToc[8] = true
	end
	if sightlangStaticImageUsed[9] then
		sightlangStaticImageUsed[9] = false
		sightlangStaticImageDel[9] = false
	elseif sightlangStaticImage[9] then
		if sightlangStaticImageDel[9] then
			if now >= sightlangStaticImageDel[9] then
				if isElement(sightlangStaticImage[9]) then
					destroyElement(sightlangStaticImage[9])
				end
				sightlangStaticImage[9] = nil
				sightlangStaticImageDel[9] = false
				sightlangStaticImageToc[9] = true
				return
			end
		else
			sightlangStaticImageDel[9] = now + 5000
		end
	else
		sightlangStaticImageToc[9] = true
	end
	if sightlangStaticImageUsed[10] then
		sightlangStaticImageUsed[10] = false
		sightlangStaticImageDel[10] = false
	elseif sightlangStaticImage[10] then
		if sightlangStaticImageDel[10] then
			if now >= sightlangStaticImageDel[10] then
				if isElement(sightlangStaticImage[10]) then
					destroyElement(sightlangStaticImage[10])
				end
				sightlangStaticImage[10] = nil
				sightlangStaticImageDel[10] = false
				sightlangStaticImageToc[10] = true
				return
			end
		else
			sightlangStaticImageDel[10] = now + 5000
		end
	else
		sightlangStaticImageToc[10] = true
	end
	if sightlangStaticImageUsed[11] then
		sightlangStaticImageUsed[11] = false
		sightlangStaticImageDel[11] = false
	elseif sightlangStaticImage[11] then
		if sightlangStaticImageDel[11] then
			if now >= sightlangStaticImageDel[11] then
				if isElement(sightlangStaticImage[11]) then
					destroyElement(sightlangStaticImage[11])
				end
				sightlangStaticImage[11] = nil
				sightlangStaticImageDel[11] = false
				sightlangStaticImageToc[11] = true
				return
			end
		else
			sightlangStaticImageDel[11] = now + 5000
		end
	else
		sightlangStaticImageToc[11] = true
	end
	if sightlangStaticImageUsed[12] then
		sightlangStaticImageUsed[12] = false
		sightlangStaticImageDel[12] = false
	elseif sightlangStaticImage[12] then
		if sightlangStaticImageDel[12] then
			if now >= sightlangStaticImageDel[12] then
				if isElement(sightlangStaticImage[12]) then
					destroyElement(sightlangStaticImage[12])
				end
				sightlangStaticImage[12] = nil
				sightlangStaticImageDel[12] = false
				sightlangStaticImageToc[12] = true
				return
			end
		else
			sightlangStaticImageDel[12] = now + 5000
		end
	else
		sightlangStaticImageToc[12] = true
	end
	if sightlangStaticImageUsed[13] then
		sightlangStaticImageUsed[13] = false
		sightlangStaticImageDel[13] = false
	elseif sightlangStaticImage[13] then
		if sightlangStaticImageDel[13] then
			if now >= sightlangStaticImageDel[13] then
				if isElement(sightlangStaticImage[13]) then
					destroyElement(sightlangStaticImage[13])
				end
				sightlangStaticImage[13] = nil
				sightlangStaticImageDel[13] = false
				sightlangStaticImageToc[13] = true
				return
			end
		else
			sightlangStaticImageDel[13] = now + 5000
		end
	else
		sightlangStaticImageToc[13] = true
	end
	if sightlangStaticImageUsed[14] then
		sightlangStaticImageUsed[14] = false
		sightlangStaticImageDel[14] = false
	elseif sightlangStaticImage[14] then
		if sightlangStaticImageDel[14] then
			if now >= sightlangStaticImageDel[14] then
				if isElement(sightlangStaticImage[14]) then
					destroyElement(sightlangStaticImage[14])
				end
				sightlangStaticImage[14] = nil
				sightlangStaticImageDel[14] = false
				sightlangStaticImageToc[14] = true
				return
			end
		else
			sightlangStaticImageDel[14] = now + 5000
		end
	else
		sightlangStaticImageToc[14] = true
	end
	if sightlangStaticImageUsed[15] then
		sightlangStaticImageUsed[15] = false
		sightlangStaticImageDel[15] = false
	elseif sightlangStaticImage[15] then
		if sightlangStaticImageDel[15] then
			if now >= sightlangStaticImageDel[15] then
				if isElement(sightlangStaticImage[15]) then
					destroyElement(sightlangStaticImage[15])
				end
				sightlangStaticImage[15] = nil
				sightlangStaticImageDel[15] = false
				sightlangStaticImageToc[15] = true
				return
			end
		else
			sightlangStaticImageDel[15] = now + 5000
		end
	else
		sightlangStaticImageToc[15] = true
	end
	if sightlangStaticImageUsed[16] then
		sightlangStaticImageUsed[16] = false
		sightlangStaticImageDel[16] = false
	elseif sightlangStaticImage[16] then
		if sightlangStaticImageDel[16] then
			if now >= sightlangStaticImageDel[16] then
				if isElement(sightlangStaticImage[16]) then
					destroyElement(sightlangStaticImage[16])
				end
				sightlangStaticImage[16] = nil
				sightlangStaticImageDel[16] = false
				sightlangStaticImageToc[16] = true
				return
			end
		else
			sightlangStaticImageDel[16] = now + 5000
		end
	else
		sightlangStaticImageToc[16] = true
	end
	if sightlangStaticImageUsed[17] then
		sightlangStaticImageUsed[17] = false
		sightlangStaticImageDel[17] = false
	elseif sightlangStaticImage[17] then
		if sightlangStaticImageDel[17] then
			if now >= sightlangStaticImageDel[17] then
				if isElement(sightlangStaticImage[17]) then
					destroyElement(sightlangStaticImage[17])
				end
				sightlangStaticImage[17] = nil
				sightlangStaticImageDel[17] = false
				sightlangStaticImageToc[17] = true
				return
			end
		else
			sightlangStaticImageDel[17] = now + 5000
		end
	else
		sightlangStaticImageToc[17] = true
	end
	if sightlangStaticImageUsed[18] then
		sightlangStaticImageUsed[18] = false
		sightlangStaticImageDel[18] = false
	elseif sightlangStaticImage[18] then
		if sightlangStaticImageDel[18] then
			if now >= sightlangStaticImageDel[18] then
				if isElement(sightlangStaticImage[18]) then
					destroyElement(sightlangStaticImage[18])
				end
				sightlangStaticImage[18] = nil
				sightlangStaticImageDel[18] = false
				sightlangStaticImageToc[18] = true
				return
			end
		else
			sightlangStaticImageDel[18] = now + 5000
		end
	else
		sightlangStaticImageToc[18] = true
	end
	if sightlangStaticImageUsed[19] then
		sightlangStaticImageUsed[19] = false
		sightlangStaticImageDel[19] = false
	elseif sightlangStaticImage[19] then
		if sightlangStaticImageDel[19] then
			if now >= sightlangStaticImageDel[19] then
				if isElement(sightlangStaticImage[19]) then
					destroyElement(sightlangStaticImage[19])
				end
				sightlangStaticImage[19] = nil
				sightlangStaticImageDel[19] = false
				sightlangStaticImageToc[19] = true
				return
			end
		else
			sightlangStaticImageDel[19] = now + 5000
		end
	else
		sightlangStaticImageToc[19] = true
	end
	if sightlangStaticImageUsed[20] then
		sightlangStaticImageUsed[20] = false
		sightlangStaticImageDel[20] = false
	elseif sightlangStaticImage[20] then
		if sightlangStaticImageDel[20] then
			if now >= sightlangStaticImageDel[20] then
				if isElement(sightlangStaticImage[20]) then
					destroyElement(sightlangStaticImage[20])
				end
				sightlangStaticImage[20] = nil
				sightlangStaticImageDel[20] = false
				sightlangStaticImageToc[20] = true
				return
			end
		else
			sightlangStaticImageDel[20] = now + 5000
		end
	else
		sightlangStaticImageToc[20] = true
	end
	if sightlangStaticImageUsed[21] then
		sightlangStaticImageUsed[21] = false
		sightlangStaticImageDel[21] = false
	elseif sightlangStaticImage[21] then
		if sightlangStaticImageDel[21] then
			if now >= sightlangStaticImageDel[21] then
				if isElement(sightlangStaticImage[21]) then
					destroyElement(sightlangStaticImage[21])
				end
				sightlangStaticImage[21] = nil
				sightlangStaticImageDel[21] = false
				sightlangStaticImageToc[21] = true
				return
			end
		else
			sightlangStaticImageDel[21] = now + 5000
		end
	else
		sightlangStaticImageToc[21] = true
	end
	if sightlangStaticImageUsed[22] then
		sightlangStaticImageUsed[22] = false
		sightlangStaticImageDel[22] = false
	elseif sightlangStaticImage[22] then
		if sightlangStaticImageDel[22] then
			if now >= sightlangStaticImageDel[22] then
				if isElement(sightlangStaticImage[22]) then
					destroyElement(sightlangStaticImage[22])
				end
				sightlangStaticImage[22] = nil
				sightlangStaticImageDel[22] = false
				sightlangStaticImageToc[22] = true
				return
			end
		else
			sightlangStaticImageDel[22] = now + 5000
		end
	else
		sightlangStaticImageToc[22] = true
	end
	if sightlangStaticImageUsed[23] then
		sightlangStaticImageUsed[23] = false
		sightlangStaticImageDel[23] = false
	elseif sightlangStaticImage[23] then
		if sightlangStaticImageDel[23] then
			if now >= sightlangStaticImageDel[23] then
				if isElement(sightlangStaticImage[23]) then
					destroyElement(sightlangStaticImage[23])
				end
				sightlangStaticImage[23] = nil
				sightlangStaticImageDel[23] = false
				sightlangStaticImageToc[23] = true
				return
			end
		else
			sightlangStaticImageDel[23] = now + 5000
		end
	else
		sightlangStaticImageToc[23] = true
	end
	if sightlangStaticImageUsed[24] then
		sightlangStaticImageUsed[24] = false
		sightlangStaticImageDel[24] = false
	elseif sightlangStaticImage[24] then
		if sightlangStaticImageDel[24] then
			if now >= sightlangStaticImageDel[24] then
				if isElement(sightlangStaticImage[24]) then
					destroyElement(sightlangStaticImage[24])
				end
				sightlangStaticImage[24] = nil
				sightlangStaticImageDel[24] = false
				sightlangStaticImageToc[24] = true
				return
			end
		else
			sightlangStaticImageDel[24] = now + 5000
		end
	else
		sightlangStaticImageToc[24] = true
	end
	if sightlangStaticImageUsed[25] then
		sightlangStaticImageUsed[25] = false
		sightlangStaticImageDel[25] = false
	elseif sightlangStaticImage[25] then
		if sightlangStaticImageDel[25] then
			if now >= sightlangStaticImageDel[25] then
				if isElement(sightlangStaticImage[25]) then
					destroyElement(sightlangStaticImage[25])
				end
				sightlangStaticImage[25] = nil
				sightlangStaticImageDel[25] = false
				sightlangStaticImageToc[25] = true
				return
			end
		else
			sightlangStaticImageDel[25] = now + 5000
		end
	else
		sightlangStaticImageToc[25] = true
	end
	if sightlangStaticImageUsed[26] then
		sightlangStaticImageUsed[26] = false
		sightlangStaticImageDel[26] = false
	elseif sightlangStaticImage[26] then
		if sightlangStaticImageDel[26] then
			if now >= sightlangStaticImageDel[26] then
				if isElement(sightlangStaticImage[26]) then
					destroyElement(sightlangStaticImage[26])
				end
				sightlangStaticImage[26] = nil
				sightlangStaticImageDel[26] = false
				sightlangStaticImageToc[26] = true
				return
			end
		else
			sightlangStaticImageDel[26] = now + 5000
		end
	else
		sightlangStaticImageToc[26] = true
	end
	if sightlangStaticImageUsed[27] then
		sightlangStaticImageUsed[27] = false
		sightlangStaticImageDel[27] = false
	elseif sightlangStaticImage[27] then
		if sightlangStaticImageDel[27] then
			if now >= sightlangStaticImageDel[27] then
				if isElement(sightlangStaticImage[27]) then
					destroyElement(sightlangStaticImage[27])
				end
				sightlangStaticImage[27] = nil
				sightlangStaticImageDel[27] = false
				sightlangStaticImageToc[27] = true
				return
			end
		else
			sightlangStaticImageDel[27] = now + 5000
		end
	else
		sightlangStaticImageToc[27] = true
	end
	if sightlangStaticImageUsed[28] then
		sightlangStaticImageUsed[28] = false
		sightlangStaticImageDel[28] = false
	elseif sightlangStaticImage[28] then
		if sightlangStaticImageDel[28] then
			if now >= sightlangStaticImageDel[28] then
				if isElement(sightlangStaticImage[28]) then
					destroyElement(sightlangStaticImage[28])
				end
				sightlangStaticImage[28] = nil
				sightlangStaticImageDel[28] = false
				sightlangStaticImageToc[28] = true
				return
			end
		else
			sightlangStaticImageDel[28] = now + 5000
		end
	else
		sightlangStaticImageToc[28] = true
	end
	if sightlangStaticImageToc[0] and sightlangStaticImageToc[1] and sightlangStaticImageToc[2] and sightlangStaticImageToc[3] and sightlangStaticImageToc[4] and sightlangStaticImageToc[5] and sightlangStaticImageToc[6] and sightlangStaticImageToc[7] and sightlangStaticImageToc[8] and sightlangStaticImageToc[9] and sightlangStaticImageToc[10] and sightlangStaticImageToc[11] and sightlangStaticImageToc[12] and sightlangStaticImageToc[13] and sightlangStaticImageToc[14] and sightlangStaticImageToc[15] and sightlangStaticImageToc[16] and sightlangStaticImageToc[17] and sightlangStaticImageToc[18] and sightlangStaticImageToc[19] and sightlangStaticImageToc[20] and sightlangStaticImageToc[21] and sightlangStaticImageToc[22] and sightlangStaticImageToc[23] and sightlangStaticImageToc[24] and sightlangStaticImageToc[25] and sightlangStaticImageToc[26] and sightlangStaticImageToc[27] and sightlangStaticImageToc[28] then
		sightlangStatImgHand = false
		removeEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre)
	end
end
processSightlangStaticImage[0] = function()
	if not isElement(sightlangStaticImage[0]) then
		sightlangStaticImageToc[0] = false
		sightlangStaticImage[0] = dxCreateTexture("files/light.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processSightlangStaticImage[1] = function()
	if not isElement(sightlangStaticImage[1]) then
		sightlangStaticImageToc[1] = false
		sightlangStaticImage[1] = dxCreateTexture("files/analog/belt.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processSightlangStaticImage[2] = function()
	if not isElement(sightlangStaticImage[2]) then
		sightlangStaticImageToc[2] = false
		sightlangStaticImage[2] = dxCreateTexture("files/analog/pulse.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processSightlangStaticImage[3] = function()
	if not isElement(sightlangStaticImage[3]) then
		sightlangStaticImageToc[3] = false
		sightlangStaticImage[3] = dxCreateTexture("files/analog/out.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processSightlangStaticImage[4] = function()
	if not isElement(sightlangStaticImage[4]) then
		sightlangStaticImageToc[4] = false
		sightlangStaticImage[4] = dxCreateTexture("files/analog/redline.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processSightlangStaticImage[5] = function()
	if not isElement(sightlangStaticImage[5]) then
		sightlangStaticImageToc[5] = false
		sightlangStaticImage[5] = dxCreateTexture("files/analog/section.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processSightlangStaticImage[6] = function()
	if not isElement(sightlangStaticImage[6]) then
		sightlangStaticImageToc[6] = false
		sightlangStaticImage[6] = dxCreateTexture("files/analog/indicator.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processSightlangStaticImage[7] = function()
	if not isElement(sightlangStaticImage[7]) then
		sightlangStaticImageToc[7] = false
		sightlangStaticImage[7] = dxCreateTexture("files/analog/line.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processSightlangStaticImage[8] = function()
	if not isElement(sightlangStaticImage[8]) then
		sightlangStaticImageToc[8] = false
		sightlangStaticImage[8] = dxCreateTexture("files/analog/battery.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processSightlangStaticImage[9] = function()
	if not isElement(sightlangStaticImage[9]) then
		sightlangStaticImageToc[9] = false
		sightlangStaticImage[9] = dxCreateTexture("files/analog/hold.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processSightlangStaticImage[10] = function()
	if not isElement(sightlangStaticImage[10]) then
		sightlangStaticImageToc[10] = false
		sightlangStaticImage[10] = dxCreateTexture("files/analog/abs.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processSightlangStaticImage[11] = function()
	if not isElement(sightlangStaticImage[11]) then
		sightlangStaticImageToc[11] = false
		sightlangStaticImage[11] = dxCreateTexture("files/analog/brake.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processSightlangStaticImage[12] = function()
	if not isElement(sightlangStaticImage[12]) then
		sightlangStaticImageToc[12] = false
		sightlangStaticImage[12] = dxCreateTexture("files/analog/oil.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processSightlangStaticImage[13] = function()
	if not isElement(sightlangStaticImage[13]) then
		sightlangStaticImageToc[13] = false
		sightlangStaticImage[13] = dxCreateTexture("files/right.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processSightlangStaticImage[14] = function()
	if not isElement(sightlangStaticImage[14]) then
		sightlangStaticImageToc[14] = false
		sightlangStaticImage[14] = dxCreateTexture("files/engine.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processSightlangStaticImage[15] = function()
	if not isElement(sightlangStaticImage[15]) then
		sightlangStaticImageToc[15] = false
		sightlangStaticImage[15] = dxCreateTexture("files/left.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processSightlangStaticImage[16] = function()
	if not isElement(sightlangStaticImage[16]) then
		sightlangStaticImageToc[16] = false
		sightlangStaticImage[16] = dxCreateTexture("files/hb1.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processSightlangStaticImage[17] = function()
	if not isElement(sightlangStaticImage[17]) then
		sightlangStaticImageToc[17] = false
		sightlangStaticImage[17] = dxCreateTexture("files/hb2.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processSightlangStaticImage[18] = function()
	if not isElement(sightlangStaticImage[18]) then
		sightlangStaticImageToc[18] = false
		sightlangStaticImage[18] = dxCreateTexture("files/hb3.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processSightlangStaticImage[19] = function()
	if not isElement(sightlangStaticImage[19]) then
		sightlangStaticImageToc[19] = false
		sightlangStaticImage[19] = dxCreateTexture("files/nosbase.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processSightlangStaticImage[20] = function()
	if not isElement(sightlangStaticImage[20]) then
		sightlangStaticImageToc[20] = false
		sightlangStaticImage[20] = dxCreateTexture("files/noslightning.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processSightlangStaticImage[21] = function()
	if not isElement(sightlangStaticImage[21]) then
		sightlangStaticImageToc[21] = false
		sightlangStaticImage[21] = dxCreateTexture("files/nosfill1.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processSightlangStaticImage[22] = function()
	if not isElement(sightlangStaticImage[22]) then
		sightlangStaticImageToc[22] = false
		sightlangStaticImage[22] = dxCreateTexture("files/nosfill2.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processSightlangStaticImage[23] = function()
	if not isElement(sightlangStaticImage[23]) then
		sightlangStaticImageToc[23] = false
		sightlangStaticImage[23] = dxCreateTexture("files/nosshine.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processSightlangStaticImage[24] = function()
	if not isElement(sightlangStaticImage[24]) then
		sightlangStaticImageToc[24] = false
		sightlangStaticImage[24] = dxCreateTexture("files/analog/inlight.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processSightlangStaticImage[25] = function()
	if not isElement(sightlangStaticImage[25]) then
		sightlangStaticImageToc[25] = false
		sightlangStaticImage[25] = dxCreateTexture("files/analog/inlight2.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processSightlangStaticImage[26] = function()
	if not isElement(sightlangStaticImage[26]) then
		sightlangStaticImageToc[26] = false
		sightlangStaticImage[26] = dxCreateTexture("files/belt.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end

processSightlangStaticImage[27] = function()
	if not isElement(sightlangStaticImage[27]) then
		sightlangStaticImageToc[27] = false
		sightlangStaticImage[27] = dxCreateTexture("files/brake.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end

processSightlangStaticImage[28] = function()
	if not isElement(sightlangStaticImage[28]) then
		sightlangStaticImageToc[28] = false
		sightlangStaticImage[28] = dxCreateTexture("files/abs.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end

local sightlangWaiterState0 = false
local function sightlangProcessResWaiters()
	if not sightlangWaiterState0 then
		local res0 = getResourceFromName("sVehicles")
		if res0 and getResourceState(res0) == "running" then
			vehiclesRes()
			sightlangWaiterState0 = true
		end
	end
end
if triggerServerEvent then
	addEventHandler("onClientResourceStart", getRootElement(), sightlangProcessResWaiters)
end
if triggerClientEvent then
	addEventHandler("onResourceStart", getRootElement(), sightlangProcessResWaiters)
end
local removeIcon = false
local btnCol = false
local btnBcg = false
local faTicks = false
local gradientTicks = false
local function sightlangGuiRefreshColors()
	local res = getResourceFromName("sGui")
	if res and getResourceState(res) == "running" then
		removeIcon = sightexports.sGui:getFaIconFilename("sign-out", 24)
		btnCol = sightexports.sGui:getColorCodeToColor("sightgreen")
		btnBcg = sightexports.sGui:getColorCodeToColor("sightgrey1")
		faTicks = sightexports.sGui:getFaTicks()
		gradientTicks = sightexports.sGui:getGradientTick()
		guiRefreshColors()
	end
end
addEventHandler("onGuiRefreshColors", getRootElement(), sightlangGuiRefreshColors)
addEventHandler("onClientResourceStart", resourceRoot, sightlangGuiRefreshColors)
addEventHandler("refreshFaTicks", getRootElement(), function()
	faTicks = sightexports.sGui:getFaTicks()
end)
addEventHandler("refreshGradientTick", getRootElement(), function()
	gradientTicks = sightexports.sGui:getGradientTick()
end)
local sightlangModloaderLoaded = function()
	modloaderLoaded()
end
addEventHandler("modloaderLoaded", getRootElement(), sightlangModloaderLoaded)
if getElementData(localPlayer, "loggedIn") then 
	addEventHandler("onClientResourceStart", resourceRoot, sightlangModloaderLoaded)
end
local sightlangCondHandlState3 = false
local function sightlangCondHandl3(cond, prio)
	cond = cond and true or false
	if cond ~= sightlangCondHandlState3 then
		sightlangCondHandlState3 = cond
		if cond then
			addEventHandler("onClientClick", getRootElement(), clickIcons, true, prio)
		else
			removeEventHandler("onClientClick", getRootElement(), clickIcons)
		end
	end
end
local sightlangCondHandlState2 = false
local function sightlangCondHandl2(cond, prio)
	cond = cond and true or false
	if cond ~= sightlangCondHandlState2 then
		sightlangCondHandlState2 = cond
		if cond then
			addEventHandler("onClientRender", getRootElement(), renderIcons, true, prio)
		else
			removeEventHandler("onClientRender", getRootElement(), renderIcons)
		end
	end
end
local sightlangCondHandlState1 = false
local function sightlangCondHandl1(cond, prio)
	cond = cond and true or false
	if cond ~= sightlangCondHandlState1 then
		sightlangCondHandlState1 = cond
		if cond then
			addEventHandler("onClientPreRender", getRootElement(), preRenderSpeedo, true, prio)
		else
			removeEventHandler("onClientPreRender", getRootElement(), preRenderSpeedo)
		end
	end
end
local sightlangCondHandlState0 = false
local function sightlangCondHandl0(cond, prio)
	cond = cond and true or false
	if cond ~= sightlangCondHandlState0 then
		sightlangCondHandlState0 = cond
		if cond then
			addEventHandler("onClientPreRender", getRootElement(), renderRearLights, true, prio)
		else
			removeEventHandler("onClientPreRender", getRootElement(), renderRearLights)
		end
	end
end
local screenX, screenY = guiGetScreenSize()
local autoHold = 0
local absState = false
local absLevel = false
local absValues = {
	0.75,
	0.5,
	0.25
}
local canSiren = false
local canSirenCivil = false
guiDatas = {}
local cruiseKeys = {}
cruiseKeys.toggle = "c"
cruiseKeys.increase = "num_add"
cruiseKeys.decrease = "num_sub"
cruiseKeys.mul = "num_mul"
cruiseKeys.div = "num_div"
function getCruiseKey(key)
	return cruiseKeys[key]
end
function setCruiseKey(key, value)
	cruiseKeys[key] = value
end
local spoilerKey = "num_5"
function getSpoilerKey()
	return spoilerKey
end
function setSpoilerKey(key)
	spoilerKey = key
end
local seatBeltSound = false
local seatBeltState = false
local seatBeltOccupants = {}
local blinkerSoundLength = {
	[1] = 350.34375,
	[2] = 400.395833333335,
	[3] = 350.34375,
	[4] = 350.34375,
	[5] = 316.979166666665,
	[6] = 350.34375,
	[7] = 316.989583333335,
	[8] = 316.979166666665,
	[9] = 367.041666666665,
	[10] = 350.34375,
	[11] = 417.072916666665,
	[12] = 467.135416666665,
	[13] = 350.354166666665,
	[14] = 333.65625,
	[15] = 550.65625,
}
local reverseSoundModels = {
	[508] = true,
	[554] = true,
	[413] = true,
	[495] = true,
	[525] = true,
	[470] = true,
	[582] = true,
	[418] = true,
	[416] = true,
	[407] = true,
	[403] = true,
	[407] = true,
	[408] = true,
	[414] = true,
	[422] = true,
	[423] = true,
	[427] = true,
	[428] = true,
	[431] = true,
	[432] = true,
	[433] = true,
	[437] = true,
	[440] = true,
	[443] = true,
	[455] = true,
	[456] = true,
	[459] = true,
	[482] = true,
	[486] = true,
	[498] = true,
	[499] = true,
	[505] = true,
	[514] = true,
	[515] = true,
	[524] = true,
	[528] = true,
	[530] = true,
	[531] = true,
	[532] = true,
	[544] = true,
	[552] = true,
	[574] = true,
	[578] = true,
	[588] = true,
	[601] = true,
	[609] = true
}
local reverseExcludeModels = {
	[466] = true,
	[405] = true,
	[580] = true,
	[421] = true,
	[598] = true,
	[426] = true,
	[429] = true,
	[527] = true,
	[587] = true,
	[562] = true,
	[579] = true,
	[419] = true,
	[561] = true
}
local seatBeltSoundList = {
	[466] = "files/belt/vw.mp3",
	[526] = "files/belt/audi.mp3",
	[405] = "files/belt/audi.mp3",
	[490] = "files/belt/audi.mp3",
	[533] = "files/belt/audi.mp3",
	[580] = "files/belt/audi.mp3",
	[596] = "files/belt/audi.mp3",
	[599] = "files/belt/audi.mp3",
	[492] = "files/belt/mb.mp3",
	[421] = "files/belt/bmwold.mp3",
	[551] = "files/belt/bmwold.mp3",
	[558] = "files/belt/bmwold.mp3",
	[503] = "files/belt/bmw.mp3",
	[420] = "files/belt/bmwold.mp3",
	[445] = "files/belt/bmwold.mp3",
	[598] = "files/belt/bmw.mp3",
	[549] = "files/belt/bmw.mp3",
	[400] = "files/belt/bmw.mp3",
	["primo2"] = "files/belt/bmw.mp3",
	["dodge"] = "files/belt/dodge.mp3",
	[494] = "files/belt/audi.mp3",
	["audirs7"] = "files/belt/audi.mp3",
	[541] = "files/belt/gm.mp3",
	[554] = "files/belt/gm.mp3",
	[426] = "files/belt/dodge.mp3",
	[429] = "files/belt/dodge.mp3",
	[411] = "files/belt/gm.mp3",
	[495] = "files/belt/ford.mp3",
	[525] = "files/belt/ford.mp3",
	[401] = "files/belt/ford.mp3",
	[527] = "files/belt/ford.mp3",
	[535] = "files/belt/ford.mp3",
	[536] = "files/belt/ford.mp3",
	[565] = "files/belt/toyota.mp3",
	[470] = "files/belt/gm.mp3",
	[451] = "files/belt/audi.mp3",
	[477] = "files/belt/toyota.mp3",
	[502] = "files/belt/mb.mp3",
	[415] = "files/belt/mb.mp3",
	[438] = "files/belt/mb.mp3",
	[550] = "files/belt/mb.mp3",
	[507] = "files/belt/mb.mp3",
	[404] = "files/belt/mb.mp3",
	[604] = "files/belt/mb.mp3",
	[582] = "files/belt/mb.mp3",
	[560] = "files/belt/toyota.mp3",
	[587] = "files/belt/toyota.mp3",
	[436] = "files/belt/toyota.mp3",
	[562] = "files/belt/toyota.mp3",
	[480] = "files/belt/vw.mp3",
	[579] = "files/belt/bmw.mp3",
	[529] = "files/belt/vw.mp3",
	[566] = "files/belt/vw.mp3",
	[597] = "files/belt/vw.mp3",
	[540] = "files/belt/toyota.mp3",
	[419] = "files/belt/toyota.mp3",
	[559] = "files/belt/toyota.mp3",
	[547] = "files/belt/vw.mp3",
	[418] = "files/belt/vw.mp3",
	[561] = "files/belt/vw.mp3",
	[589] = "files/belt/vw.mp3",
	[458] = "files/belt/vw.mp3",
	[496] = "files/belt/vw.mp3",
	[416] = "files/belt/mb.mp3",
	[407] = "files/belt/mb.mp3",
	[506] = "files/belt/audi.mp3",
	["model_s"] = "files/belt/tesla.mp3",
	["leaf"] = "files/belt/tesla.mp3",
	["model_y"] = "files/belt/tesla.mp3",
}
local blinkerSounds = {
	[400] = 4,
	[401] = 11,
	[402] = 9,
	[405] = 2,
	[409] = 3,
	[410] = 9,
	[411] = 3,
	[413] = 6,
	[415] = 8,
	[416] = 6,
	[418] = 2,
	[419] = 14,
	[420] = 13,
	[421] = 4,
	[424] = 3,
	[426] = 14,
	[427] = 6,
	[428] = 6,
	[429] = 14,
	[433] = 6,
	[434] = 12,
	[438] = 7,
	[439] = 9,
	[443] = 6,
	[445] = 4,
	[451] = 14,
	[458] = 2,
	[466] = 14,
	[467] = 9,
	[470] = 6,
	[474] = 9,
	[475] = 9,
	[477] = 8,
	[479] = 7,
	[480] = 2,
	[483] = 9,
	[404] = 7,
	[490] = 2,
	[491] = 4,
	[492] = 14,
	[494] = 14,
	[495] = 6,
	[496] = 2,
	[500] = 7,
	[502] = 7,
	[503] = 4,
	[506] = 14,
	[507] = 7,
	[508] = 6,
	[516] = 7,
	[517] = 9,
	[525] = 6,
	[526] = 2,
	[527] = 10,
	[528] = 6,
	[529] = 13,
	[531] = 12,
	[533] = 2,
	[534] = 9,
	[535] = 12,
	[536] = 9,
	[540] = 8,
	[541] = 14,
	[542] = 13,
	[546] = 9,
	[547] = 13,
	[549] = 4,
	[550] = 7,
	[551] = 13,
	[552] = 6,
	[554] = 6,
	[555] = 9,
	[558] = 4,
	[559] = 13,
	[560] = 14,
	[561] = 2,
	[562] = 14,
	[565] = 11,
	[566] = 2,
	[568] = 9,
	[572] = 12,
	[567] = 9,
	[575] = 9,
	[576] = 9,
	[579] = 14,
	[580] = 2,
	[582] = 6,
	[585] = 13,
	[587] = 14,
	[436] = 14,
	[588] = 12,
	[589] = 2,
	[596] = 2,
	[597] = 2,
	[598] = 4,
	[599] = 2,
	[601] = 6,
	[602] = 9,
	[603] = 9,
	[604] = 14,
	[605] = 6,
	["model_s"] = 15,
	["leaf"] = 15,
	["model_y"] = 15,
}
function getBlinkerSound(model)
	if blinkerSounds[model] then
		return blinkerSounds[model]
	end
	return 1
end
function getBlinkTime(s)
	return blinkerSoundLength[s]
end
local currentGear = 0
local currentGearChange = 0
local speedoType = "analog"
unit = "KM/H"
local analogDivision = unit == "MPH" and 20 or 30
local topSpeedRed = true
function setUnit(new)
	unit = new
	analogDivision = unit == "MPH" and 20 or 30
end
function getUnit(new)
	return unit
end
local widgetState = false
local widgetPos = {0, 0}
local widgetSize = {0, 0}
local analogSize = 256
local analogPos = {0, 0}
currentSeat = getPedOccupiedVehicleSeat(localPlayer)
currentVehicle = getPedOccupiedVehicle(localPlayer)
addEvent("updateShifter", true)
addEventHandler("updateShifter", root, function(newType)
	if newType == 1 then
		currentVehicleShifter = false
	else
		currentVehicleShifter = currentVehicleType == "Automobile"
	end
end)
function getSpeedoVeh()
	return currentVehicle
end
currentVehicleLight = false
function vehiclesRes()
	sightexports.sVehicles:updateSpeedoVehicle(currentVehicle)
	sightexports.sVehicles:updateSpeedoVehicleLight(currentVehicleLight)
end
if currentVehicle then
	currentVehicleModel = getElementData(currentVehicle, "vehicle.customModel") or getElementModel(currentVehicle)
	currentVehicleType = getVehicleType(currentVehicle)
	shifter = getElementData(currentVehicle, "haveAutomaticShifter") or false
	if shifter == 1 then
		currentVehicleShifter = false
	else
		currentVehicleShifter = currentVehicleType == "Automobile"
	end
end
currentGear = 0
local currentSpeed = 0
local currentDisplaySpeed = 0
local gearSize = 16
local gearPos = 0
local currentRpm = 0
local engine = false
local ignition = false
local calibrationStart = false
local speedoNameTexts = {
	"BMW m3 e30",
	"Next oil change: 200km",
	"Fuel: 0l / 10l",
	"Fuel consumption: 20l / 100 km"
}
local afterCalibration = false
local nosState = false
local handbrakeSound = 0
local handbrakeState = false
local fuelLiters = 80
local fuelMaxLiters = 80
local currentSelectedGear = "N"
local cruiseSpeed = false
local setCruiseSpeed = false
local syncedCruiseSpeed = false
local lastCruiseSpeedSet = 0
function isCruiseSet(key)
	if not currentVehicle then
		return
	end
	local controller = getVehicleController(currentVehicle)
	if controller == localPlayer then
		if key ~= "num_add" and key ~= "num_sub" then
			return false
		end
		return cruiseSpeed
	end
end
local cruiseSound = false
local cruiseCritical = false
local cruiseDistance = false
local cruiseVeh = false
function vehicleDimensionChange()
	if currentVehicle and currentVehicleShifter and source == currentVehicle then
		local controller = getVehicleController(currentVehicle)
		if controller == localPlayer and getVehicleEngineState(currentVehicle) and currentSelectedGear ~= "N" then
			currentSelectedGear = "N"
			setElementData(currentVehicle, "vehicle.gear", currentSelectedGear)
		end
	end
end
addEventHandler("onClientElementDimensionChange", getRootElement(), vehicleDimensionChange)
addEventHandler("onClientElementInteriorChange", getRootElement(), vehicleDimensionChange)
function setAutoHold(veh)
	if currentVehicle == veh and currentSelectedGear == "D" then
		autoHold = 1500
	end
end
addEvent("setAutoHold", true)
addEventHandler("setAutoHold", getRootElement(), function()
	setAutoHold(source)
end)
local lastBelt = 0
function isBike(veh)
	return getVehicleType(veh) == "Bike" or getVehicleType(veh) == "Quad" or getVehicleType(veh) == "BMX"
end
function isHeli(veh)
	return getVehicleType(veh) == "Helicopter" or getVehicleType(veh) == "Plane"
end
function isBoat(veh)
	return getVehicleType(veh) == "Boat"
end
local beltKey = "F5"
local downShift = "lctrl"
local upShift = "lshift"
function getBeltKey()
	return beltKey
end
function setBeltKey(val)
	beltKey = val
end
function getDownShift()
	return downShift
end
function setDownShift(val)
	downShift = val
end
function getUpShift()
	return upShift
end
function setUpShift(val)
	upShift = val
end
addEventHandler("onClientKey", getRootElement(), function(key, por)
	if not por then
		if beltKey and key == beltKey then
			if getElementData(localPlayer, "cuffed") then
				sightexports.sGui:showInfobox("e", "Meg vagy bilincselve!")
				return
			end
			if getTickCount() - lastBelt < 1500 then
				return
			end
			local veh = getPedOccupiedVehicle(localPlayer)
			if not veh then
				return
			end
			if isBike(veh) or isHeli(veh) or isBoat(veh) then
				return
			end
			lastBelt = getTickCount()
			local new
			if not getElementData(localPlayer, "seatBelt") then
				new = currentVehicle
			end
			setElementData(localPlayer, "seatBelt", new)
			sightexports.sChat:localActionC(localPlayer, (new and "becsatolta" or "kicsatolta") .. " a biztonsági övét.")
			return
		end
		if (upShift and key == upShift or downShift and key == downShift or key == cruiseKeys.toggle or key == cruiseKeys.div or key == cruiseKeys.mul or key == spoilerKey) and not isCursorShowing() and not isConsoleActive() and not isChatBoxInputActive() and not sightexports.sGui:getActiveInput() and not isChatBoxInputActive() and getElementHealth(localPlayer) > 20 and currentVehicle then
			if getElementData(localPlayer, "cuffed") then
				sightexports.sGui:showInfobox("e", "Meg vagy bilincselve!")
				return
			end
			currentSpeed = getVehicleSpeed(currentVehicle, "KMH")
			local controller = getVehicleController(currentVehicle)
			if controller == localPlayer and getVehicleEngineState(currentVehicle) then
			if sightexports.sJob_raktar:getJobVehicleDoor(currentVehicle) then
				sightexports.sGui:showInfobox("e", "Előbb zárd be az oldalajtót!")
				return
			end
			if getElementData(currentVehicle, "packerRampState") then
				sightexports.sGui:showInfobox("e", "Előbb tedd vissza a rámpát!")
				return
			end
			if sightexports.sJob_raktar:checkVehicleCart(currentVehicle) then
				sightexports.sGui:showInfobox("e", "Előbb tedd vissza a kézikocsit!")
				return
			end
			if key == cruiseKeys.div or key == cruiseKeys.mul then
				if setCruiseSpeed then
					if cruiseDistance then
						cruiseDistance = cruiseDistance + (key == cruiseKeys.div and -1 or 1)
						if cruiseDistance < 1 then
							cruiseDistance = false
						elseif 4 < cruiseDistance then
							cruiseDistance = false
						end
					else
						cruiseDistance = key == cruiseKeys.div and 4 or 1
					end
					triggerServerEvent("setVehicleCruiseDistance", localPlayer, cruiseDistance)
				end
				return
			elseif key == cruiseKeys.toggle then
				if currentSelectedGear == "D" or currentVehicleShifter == false then
					if setCruiseSpeed then
						if cruiseSpeed then
							playSound("files/tempooff.wav")
						end
						cruiseSpeed = false
						setCruiseSpeed = false
						syncedCruiseSpeed = false
						triggerServerEvent("setVehicleCruiseSpeed", localPlayer)
					else
						if 180 < currentSpeed then
							sightexports.sGui:showInfobox("e", "Tempomat maximum sebessége: 180 km/h!", false, "tempomat")
							return
						end
						if not cruiseSpeed then
							playSound("files/tempoon.wav")
						end
						if currentSpeed < 30 then
							cruiseSpeed = 30
							setCruiseSpeed = 30
							syncedCruiseSpeed = 30
						else
							cruiseSpeed = math.floor(currentSpeed)
							setCruiseSpeed = cruiseSpeed
							syncedCruiseSpeed = cruiseSpeed
						end
						cruiseDistance = false
						triggerServerEvent("setVehicleCruiseSpeed", localPlayer, cruiseSpeed)
					end
				end
				return
			elseif key == spoilerKey then
				if activeSpoilers[currentVehicleModel] or currentVehicleModel == amgOne then
					if getElementData(currentVehicle, "forceSpoiler") then
						setElementData(currentVehicle, "forceSpoiler", nil)
					else
						setElementData(currentVehicle, "forceSpoiler", true)
					end
				end
				return
			end
			if upShift and key == upShift and currentVehicleShifter then
				if cruiseSpeed then
					if cruiseSpeed then
						playSound("files/tempooff.wav")
					end
					cruiseSpeed = false
					setCruiseSpeed = false
					syncedCruiseSpeed = false
				end
				if currentSelectedGear == "N" then
					if currentSpeed < 5 or 1 <= getVehicleCurrentGear(currentVehicle) then
						currentSelectedGear = "D"
						autoHold = 0
					end
				elseif currentSelectedGear == "R" then
					currentSelectedGear = "N"
					autoHold = 0
				end
				setElementData(currentVehicle, "vehicle.gear", currentSelectedGear)
			elseif downShift and key == downShift and currentVehicleShifter then
				if cruiseSpeed then
					if cruiseSpeed then
						playSound("files/tempooff.wav")
					end
					cruiseSpeed = false
					setCruiseSpeed = false
					syncedCruiseSpeed = false
				end
				if currentSelectedGear == "N" then
					if currentSpeed < 5 or 1 > getVehicleCurrentGear(currentVehicle) then
						currentSelectedGear = "R"
						autoHold = 0
					end
				elseif currentSelectedGear == "D" then
					currentSelectedGear = "N"
					autoHold = 0
				end
				setElementData(currentVehicle, "vehicle.gear", currentSelectedGear)
			end
		end
	end
end
end)
function vehiclePlayerDataChange(dataName, oldValue, new)
	if dataName == "seatBelt" and isElementStreamedIn(source) then
		if new then
			if currentVehicle and new == currentVehicle then
				playSound("files/beltin.mp3")
				seatBeltOccupants[source] = true
			elseif isElement(new) and getPedOccupiedVehicle(source) == new then
				local x, y, z = getElementPosition(source)
				local sound = playSound3D("files/beltin.mp3", x, y, z)
				setElementDimension(sound, getElementDimension(source))
				setElementInterior(sound, getElementInterior(source))
				attachElements(sound, source)
			end
		elseif currentVehicle and oldValue == currentVehicle then
			playSound("files/beltout.mp3")
			seatBeltOccupants[source] = false
			seatBeltState = false
		elseif isElement(oldValue) and getPedOccupiedVehicle(source) == oldValue then
			local x, y, z = getElementPosition(source)
			local sound = playSound3D("files/beltout.mp3", x, y, z)
			setElementDimension(sound, getElementDimension(source))
			setElementInterior(sound, getElementInterior(source))
			attachElements(sound, source)
		end
	end
end
addEventHandler("onClientPlayerDataChange", getRootElement(), vehiclePlayerDataChange)
local reverseSounds = {}
local reverseVehicles = {}
local reverseStreamed = {}
function getPositionFromMatrixOffset(m, offX, offY, offZ)
	local x = offX * m[1][1] + offY * m[2][1] + offZ * m[3][1] + m[4][1]
	local y = offX * m[1][2] + offY * m[2][2] + offZ * m[3][2] + m[4][2]
	local z = offX * m[1][3] + offY * m[2][3] + offZ * m[3][3] + m[4][3]
	return x, y, z
end
function renderRearLights()
	local done = true
	for veh in pairs(reverseVehicles) do
		done = false
		if isElementOnScreen(veh) then
			local x, y, z = getVehicleDummyPosition(veh, "light_rear_main")
			if x + y + z ~= 0 then
				local m = getElementMatrix(veh)
				for i = -1, 1, 2 do
					local x2, y2, z2 = getPositionFromMatrixOffset(m, x * i, y - 1, z)
					local x, y, z = getPositionFromMatrixOffset(m, x * i, y - 0.05, z)
					sightlangStaticImageUsed[0] = true
					if sightlangStaticImageToc[0] then
						processSightlangStaticImage[0]()
					end
					dxDrawMaterialLine3D(x, y, z - 0.4, x, y, z + 0.4, sightlangStaticImage[0], 0.8, tocolor(255, 255, 255, 200), x2, y2, z2)
				end
			end
		end
	end
	if done then
		sightlangCondHandl0(false)
	end
end
function reverseDataChange(data, old, new)
	if data == "vehicle.gear" then
		if new == "R" then
			if reverseSoundModels[getElementModel(source)] and not isElement(reverseSounds[source]) then
				reverseSounds[source] = playSound3D("files/reverse.wav", 0, 0, 0, true)
				setSoundMaxDistance(reverseSounds[source], 50)
				setElementInterior(reverseSounds[source], getElementInterior(source))
				setElementDimension(reverseSounds[source], getElementDimension(source))
				attachElements(reverseSounds[source], source)
			end
			reverseVehicles[source] = true
			sightlangCondHandl0(true)
		else
			if isElement(reverseSounds[source]) then
				destroyElement(reverseSounds[source])
			end
			reverseSounds[source] = nil
			reverseVehicles[source] = nil
		end
	end
end
function reverseStreamOut()
	if isElement(reverseSounds[source]) then
		destroyElement(reverseSounds[source])
	end
	reverseSounds[source] = nil
	reverseVehicles[source] = nil
	reverseStreamed[source] = nil
	removeEventHandler("onClientElementDataChange", source, reverseDataChange)
	removeEventHandler("onClientElementStreamOut", source, reverseStreamOut)
	removeEventHandler("onClientElementDestroy", source, reverseStreamOut)
end
addEventHandler("onClientVehicleStreamIn", getRootElement(), function()
	local engine = getElementData(source, "vehicle.engine")
	if getVehicleType(source) == "BMX" then
		setVehicleEngineState(source, true)
	else
		local tmp = getElementHealth(source) > 250 and engine
		setVehicleEngineState(source, tmp or false)
	end
	local model = getElementModel(source)
	if (not reverseExcludeModels[model] or reverseSoundModels[model]) and not reverseStreamed[source] then
		if getElementData(source, "vehicle.gear") == "R" then
			if reverseSoundModels[model] and not isElement(reverseSounds[source]) then
				reverseSounds[source] = playSound3D("files/reverse.wav", 0, 0, 0, true)
				setSoundMaxDistance(reverseSounds[source], 50)
				setElementInterior(reverseSounds[source], getElementInterior(source))
				setElementDimension(reverseSounds[source], getElementDimension(source))
				attachElements(reverseSounds[source], source)
			end
			reverseVehicles[source] = true
			sightlangCondHandl0(true)
		end
		addEventHandler("onClientElementDataChange", source, reverseDataChange)
		addEventHandler("onClientElementStreamOut", source, reverseStreamOut)
		addEventHandler("onClientElementDestroy", source, reverseStreamOut)
		reverseStreamed[source] = true
	end
end)
local vehicles = getElementsByType("vehicle", getRootElement(), true)
for i = 1, #vehicles do
	local model = getElementModel(vehicles[i])
	if not reverseExcludeModels[model] or reverseSoundModels[model] then
		if getElementData(vehicles[i], "vehicle.gear") == "R" then
			if reverseSoundModels[model] and not isElement(reverseSounds[vehicles[i]]) then
				reverseSounds[vehicles[i]] = playSound3D("files/reverse.wav", 0, 0, 0, true)
				attachElements(reverseSounds[vehicles[i]], vehicles[i])
				setSoundMaxDistance(reverseSounds[vehicles[i]], 50)
			end
			reverseVehicles[vehicles[i]] = true
			sightlangCondHandl0(true)
		end
		addEventHandler("onClientElementDataChange", vehicles[i], reverseDataChange)
		addEventHandler("onClientElementStreamOut", vehicles[i], reverseStreamOut)
		addEventHandler("onClientElementDestroy", vehicles[i], reverseStreamOut)
		reverseStreamed[vehicles[i]] = true
	end
end
addEvent("gotVehicleLightSwitch", true)
addEventHandler("gotVehicleLightSwitch", getRootElement(), function()
	if source == currentVehicle then
		playSound("files/lightswitch.mp3")
	end
end)
addEvent("gotVehicleCruise", true)
addEventHandler("gotVehicleCruise", getRootElement(), function(new, enter)
	if currentVehicle == source then
		if not cruiseSpeed or not new then
			cruiseDistance = false
		end
		if not enter then
			if new and not cruiseSpeed then
				playSound("files/tempoon.wav")
			elseif not new and cruiseSpeed then
				playSound("files/tempooff.wav")
			end
		end
		cruiseSpeed = new
		setCruiseSpeed = new
		syncedCruiseSpeed = new
		lastCruiseSpeedSet = getTickCount()
		if isElement(cruiseSound) then
			destroyElement(cruiseSound)
		end
		cruiseSound = nil
	end
end)
addEvent("gotVehicleCruiseDistance", true)
addEventHandler("gotVehicleCruiseDistance", getRootElement(), function(new, enter)
	if currentVehicle == source then
		if isVehicleElectric(source) and getElementData(source, "gpsTarget") then
			cruiseDistance = tonumber(new) and 1 or false
		else
			cruiseDistance = new
		end
		if not new then
			if isElement(cruiseSound) then
				destroyElement(cruiseSound)
			end
			cruiseSound = nil
		end
		if cruiseSpeed and not enter then
			playSound("files/temposet.wav")
		end
	end
end)
function vehicleDataChange(dataName, oldValue, new)
	if source == currentVehicle then
		if dataName == "vehicle.ignition" then
			ignition = new
			if ignition then
				calibrationStart = getTickCount()
			end
			if not ignition then
				if isElement(seatBeltSound) then
					destroyElement(seatBeltSound)
				end
				seatBeltSound = nil
			end
		elseif dataName == "civilSiren" then
			canSirenCivil = new
		elseif dataName == "vehicle.engine" then
			engine = new
			if cruiseSpeed then
				playSound("files/tempooff.wav")
			end
			cruiseSpeed = false
			setCruiseSpeed = false
			syncedCruiseSpeed = false
		elseif dataName == "vehicle.handbrake" then
			handbrakeState = new
		elseif dataName == "vehicle.gear" then
			currentSelectedGear = new
			autoHold = 0
			playSound("files/shift.mp3")
		elseif dataName == "vehicle.pulling" then
			currentSteeringPulling = new
		elseif dataName == "civilSiren" then
			canSirenCivil = new
		end
	end
end
local vehicleEventsHandled = false
function initVeh()
	if isVehicleElectric(currentVehicle) then
		totalChargeMinus = 0
		setSpeedoType("tesla")
	end

	local vehicleModel = getElementModel(currentVehicle)
	if getElementData(currentVehicle, "vehicle.customModel") then
		vehicleModel = getElementData(currentVehicle, "vehicle.customModel")
	end

	canSiren = sightexports.sMdc:checkSirenVehicle(currentVehicle, vehicleModel)
	canSirenCivil = getElementData(currentVehicle, "civilSiren")
	if not canSiren and not canSirenCivil and getVehicleSirensOn(currentVehicle) then
		setVehicleSirensOn(currentVehicle, false)
	end
	if isElement(seatBeltSound) then
		destroyElement(seatBeltSound)
	end
	seatBeltSound = nil
	if vehicleEventsHandled ~= currentVehicle then
		if vehicleEventsHandled then
			removeEventHandler("onClientElementDataChange", vehicleEventsHandled, vehicleDataChange)
			removeEventHandler("onClientVehicleStartExit", vehicleEventsHandled, startExit)
		end
		vehicleEventsHandled = currentVehicle
		addEventHandler("onClientElementDataChange", vehicleEventsHandled, vehicleDataChange)
		addEventHandler("onClientVehicleStartExit", vehicleEventsHandled, startExit)
	end
	ignition = getElementData(currentVehicle, "vehicle.ignition")
	engine = getElementData(currentVehicle, "vehicle.engine")
	if currentVehicleType == "Helicopter" then
		if not ignition or not engine then
			setVehicleRotorState(currentVehicle, false)
		else
			if ignition or engine then
				setVehicleRotorState(currentVehicle, true, false)
			end
		end
	end
	handbrakeState = getElementData(currentVehicle, "vehicle.handbrake")
	handbrakeSound = handbrakeState and 3 or 0
	currentSelectedGear = getElementData(currentVehicle, "vehicle.gear") or "N"
	currentSteeringPulling = getElementData(currentVehicle, "vehicle.pulling") or 0
	autoHold = 0
	triggerServerEvent("getVehicleOilLevel", currentVehicle)
	triggerServerEvent("getVehicleABS", currentVehicle)
	triggerServerEvent("getVehicleFuelLevel", currentVehicle)
	triggerServerEvent("getVehicleBatteryCharge", currentVehicle)
	triggerServerEvent("getVehicleCheckEngineLevel", currentVehicle)
	triggerServerEvent("getVehicleNosLevel", currentVehicle)
	if getVehicleController(currentVehicle) == localPlayer then
		triggerServerEvent("getVehicleBrakeState", currentVehicle)
		triggerServerEvent("getVehicleTimingState", currentVehicle)
		cruiseSpeed = false
		setCruiseSpeed = false
		syncedCruiseSpeed = false
	else
		triggerServerEvent("getVehicleCruiseState", currentVehicle)
	end
	if getElementData(localPlayer, "seatBelt") then
		setElementData(localPlayer, "seatBelt", currentVehicle)
	end
	seatBeltOccupants = {}
	seatBeltState = false
	fuelMaxLiters = sightexports.sVehicles:getTankSize(currentVehicle)
	speedoNameTexts[4] = "Fuel consumption: " .. sightexports.sVehicles:getFuelConsumption(currentVehicle) .. "l / 100 km"
end
addEventHandler("onClientPlayerVehicleEnter", localPlayer, function(vehicle, seat)
	currentVehicleType = getVehicleType(vehicle)
	currentVehicleModel = getElementData(vehicle, "vehicle.customModel") or getElementModel(vehicle)

	setSpeedoType("analog")
	if isVehicleElectric(vehicle) then
		totalChargeMinus = 0
		setSpeedoType("tesla")
	end
	if currentVehicleType == "Automobile" or currentVehicleType == "Bike" or currentVehicleType == "Quad" or currentVehicleType == "Plane" or currentVehicleType == "Helicopter" or currentVehicleType == "Boat" then
		currentVehicle = vehicle
		currentVehicleLight = (signalOriginalStates[currentVehicle] and signalState[currentVehicle] and signalOriginalStates[currentVehicle][4] or getVehicleOverrideLights(currentVehicle)) == 2
		sightexports.sVehicles:updateSpeedoVehicle(currentVehicle)
		sightexports.sVehicles:updateSpeedoVehicleLight(currentVehicleLight)
		local shifter = getElementData(currentVehicle, "haveAutomaticShifter") or false
		if shifter == 1 then
			currentVehicleShifter = false
		else
			currentVehicleShifter = currentVehicleType == "Automobile"
		end
		currentSeat = seat
		currentMileage = -1
		startOdometer()
		signalRot = false
		pressTime = false
		currentEmergencyColor = false
		sightlangCondHandl1(currentVehicle)
		initVeh()
	end
end)
local speedbumpCol = false
local speedbumpModel = false
local streamedBumps = {}
local overrideControls = {}
function deInitVeh()
	autoHold = 0
	if isElement(cruiseSound) then
		destroyElement(cruiseSound)
	end
	cruiseSound = nil
	if isElement(seatBeltSound) then
		destroyElement(seatBeltSound)
	end
	seatBeltSound = nil
	if isElement(turnSignalSound) then
		destroyElement(turnSignalSound)
	end
	turnSignalSound = nil
	if vehicleEventsHandled and isElement(vehicleEventsHandled) then
		removeEventHandler("onClientElementDataChange", vehicleEventsHandled, vehicleDataChange)
		removeEventHandler("onClientVehicleStartExit", vehicleEventsHandled, startExit)
	end
	vehicleEventsHandled = false
	setHandbrakeMode(false)
	saveVehicleMileage(true)
	currentVehicle = false
	sightexports.sVehicles:updateSpeedoVehicle(currentVehicle)
	signalRot = false
	speedbumpCol = false
	for obj in pairs(streamedBumps) do
		setElementCollisionsEnabled(obj, speedbumpCol)
	end
	sightlangCondHandl1(currentVehicle)
	for c in pairs(overrideControls) do
		setAnalogControlState(c)
		overrideControls[c] = nil
	end
	if getElementData(localPlayer, "seatBelt") then
		setElementData(localPlayer, "seatBelt", nil)
	end
end
function startExit(ped, seat)
	if ped == localPlayer then
		if seat == 0 then
			setElementData(source, "vehicle.gear", "N")
		end
		deInitVeh()
		if getElementData(localPlayer, "seatBelt") then
			setElementData(localPlayer, "seatBelt", nil)
			sightexports.sChat:localActionC(localPlayer, "kicsatolta a biztonsági övét.")
		end
	end
end
local engineLightLevel = 0
addEvent("gotCheckEngineLightLevel", true)
addEventHandler("gotCheckEngineLightLevel", getRootElement(), function(level)
	if source == currentVehicle then
		engineLightLevel = level or 0
	end
end)
local oilLevel = 10000
local flSusp = 100
local rlSusp = 100
local frSusp = 100
local rrSusp = 100
addEvent("gotVehicleSuspensionState", true)
addEventHandler("gotVehicleSuspensionState", getRootElement(), function(fl, rl, fr, rr)
	if source == currentVehicle then
		flSusp = fl
		rlSusp = rl
		frSusp = fr
		rrSusp = rr
	end
end)
local frontBrakeHP = 100
local rearBrakeHP = 100
addEvent("gotVehicleBrakeState", true)
addEventHandler("gotVehicleBrakeState", getRootElement(), function(fb, rb)
	if source == currentVehicle then
		frontBrakeHP = fb
		rearBrakeHP = rb
	end
end)
local timingHP = 100
addEvent("gotVehicleTimingState", true)
addEventHandler("gotVehicleTimingState", getRootElement(), function(hp)
	if source == currentVehicle then
		timingHP = hp
	end
end)
addEvent("gotVehicleOilLevel", true)
addEventHandler("gotVehicleOilLevel", getRootElement(), function(level)
	if source == currentVehicle then
		oilLevel = level
		speedoNameTexts[2] = "Next oil change: " .. thousandsStepper(math.ceil(oilLevel * (unit == "KM/H" and 1 or 0.621371192))) .. " " .. (unit == "KM/H" and "km" or "mls")
	end
end)
addEvent("gotVehicleABS", true)
addEventHandler("gotVehicleABS", getRootElement(), function(level)
	if source == currentVehicle then
		if level == 0 then
			absLevel = false
		else
			absLevel = level
		end
	end
end)
local fuelLevel = fuelLiters / fuelMaxLiters
function getFuel()
	return fuelLiters, fuelMaxLiters
end
addEvent("gotVehicleFuelLevel", true)
addEventHandler("gotVehicleFuelLevel", getRootElement(), function(level)
	if source == currentVehicle then
		fuelLiters = level
		fuelLevel = fuelLiters / fuelMaxLiters
		speedoNameTexts[3] = "Fuel: " .. math.floor(fuelLiters + 0.5) .. "l / " .. fuelMaxLiters .. "l"
	end
end)
local starterValue = 256
local batteryCharge = 2048
addEvent("gotVehicleBatteryCharge", true)
addEventHandler("gotVehicleBatteryCharge", getRootElement(), function(level)
	if source == currentVehicle then
		batteryCharge = level
		starterValue = math.abs(sightexports.sVehicles:getBatteryValues(currentVehicle, "starter")) / 60
	end
end)
local handBrakeLevel = 0
guiDatas.miniFontRaw = "15/BebasNeueBold.otf"
guiDatas.bigFontRaw = "50/BebasNeueRegular.otf"
guiDatas.midFontRaw = false
if speedoType == "analog" then
	guiDatas.bigFontRaw = "52/BebasNeueBold.otf"
	guiDatas.midFontRaw = "20/BebasNeueBold.otf"
else
	guiDatas.bigFontRaw = "50/BebasNeueRegular.otf"
	guiDatas.miniFontRaw = "15/BebasNeueBold.otf"
end
guiDatas.nameFontRaw = "13/Ubuntu-R.ttf"
guiDatas.cruiseFontRaw = "09/Ubuntu-R.ttf"

local iconSizes = 28
function guiRefreshColors()
	local resource = getResourceFromName("sGui")
	if resource and getResourceState(resource) == "running" then
		guiDatas.greenColor = sightexports.sGui:getColorCodeToColor("sightgreen")
		guiDatas.redColor = sightexports.sGui:getColorCodeToColor("sightred")
		guiDatas.blueColor = sightexports.sGui:getColorCodeToColor("sightblue")
		guiDatas.yellowColor = sightexports.sGui:getColorCodeToColor("sightyellow")
		guiDatas.orangeColor = sightexports.sGui:getColorCodeToColor("sightorange")
		guiDatas.barColor = bitReplace(sightexports.sGui:getColorCodeToColor("sightgrey1"), 174, 24, 8)
		guiDatas.nameFont = sightexports.sGui:getFont(guiDatas.nameFontRaw)
		guiDatas.nameFontScale = sightexports.sGui:getFontScale(guiDatas.nameFontRaw)
		guiDatas.nameFontH = sightexports.sGui:getFontHeight(guiDatas.nameFontRaw)
		guiDatas.cruiseFont = sightexports.sGui:getFont(guiDatas.cruiseFontRaw)
		guiDatas.cruiseFontScale = sightexports.sGui:getFontScale(guiDatas.cruiseFontRaw)
		guiDatas.cruiseFontH = sightexports.sGui:getFontHeight(guiDatas.cruiseFontRaw)
		guiDatas.miniFont = sightexports.sGui:getFont(guiDatas.miniFontRaw)
		guiDatas.miniFontScale = sightexports.sGui:getFontScale(guiDatas.miniFontRaw)
		guiDatas.miniFontH = sightexports.sGui:getFontHeight(guiDatas.miniFontRaw)
		guiDatas.bigFont = sightexports.sGui:getFont(guiDatas.bigFontRaw)
		guiDatas.bigFontScale = sightexports.sGui:getFontScale(guiDatas.bigFontRaw)
		guiDatas.bigFontH = sightexports.sGui:getFontHeight(guiDatas.bigFontRaw)
		if guiDatas.midFontRaw then
			guiDatas.midFont = sightexports.sGui:getFont(guiDatas.midFontRaw)
			guiDatas.midFontScale = sightexports.sGui:getFontScale(guiDatas.midFontRaw)
			guiDatas.midFontH = sightexports.sGui:getFontHeight(guiDatas.midFontRaw)
		end
		guiDatas.fuelIcon = sightexports.sGui:getFaIconFilename("gas-pump", guiDatas.miniFontH)
		guiDatas.cruiseIcon = sightexports.sGui:getFaIconFilename("caret-down", 32)
		guiDatas.cruiseIcon2 = sightexports.sGui:getFaIconFilename("caret-down", 32, "regular")
		guiDatas.cruiseCarIcon = sightexports.sGui:getFaIconFilename("car-side", 32)
		guiDatas.cruiseCarIcon2 = sightexports.sGui:getFaIconFilename("car-side", 32, "regular")
		guiDatas.cruiseDistanceIcons = {
			sightexports.sGui:getFaIconFilename("signal-alt-1", 32),
			sightexports.sGui:getFaIconFilename("signal-alt-2", 32),
			sightexports.sGui:getFaIconFilename("signal-alt-3", 32),
			sightexports.sGui:getFaIconFilename("signal-alt", 32)
		}
		guiDatas.bigWidth = sightexports.sGui:getTextWidthFont("0", guiDatas.bigFontRaw)
		guiDatas.bigHeight = sightexports.sGui:getFontHeight(guiDatas.bigFontRaw)
		guiDatas.speedoColorRaw = "hudwhite"
		guiDatas.speedoColor = sightexports.sGui:getColorCodeToColor("hudwhite")
		guiDatas.brightSpeedoColor = bitReplace(guiDatas.speedoColor, 53, 24, 8)

		whiteColor = sightexports.sGui:getColorCode("hudwhite")

		guiDatas.chargingGradient = sightexports.sGui:getGradient2Filename(500, 6, sightexports.sGui:getColorCode("sightgreen"), whiteColor)
	end
end
function getSpeedoType()
	return speedoType
end
function setSpeedoType(val)
	speedoType = val
	if speedoType == "analog" then
		guiDatas.bigFontRaw = "52/BebasNeueBold.otf"
		guiDatas.midFontRaw = "20/BebasNeueBold.otf"
	else
		guiDatas.bigFontRaw = "52/BebasNeueBold.otf"
		guiDatas.miniFontRaw = "15/BebasNeueBold.otf"
	end
	guiDatas.bigFont = sightexports.sGui:getFont(guiDatas.bigFontRaw)
	guiDatas.bigFontScale = sightexports.sGui:getFontScale(guiDatas.bigFontRaw)
	guiDatas.bigFontH = sightexports.sGui:getFontHeight(guiDatas.bigFontRaw)
	if guiDatas.midFontRaw then
		guiDatas.midFont = sightexports.sGui:getFont(guiDatas.midFontRaw)
		guiDatas.midFontScale = sightexports.sGui:getFontScale(guiDatas.midFontRaw)
		guiDatas.midFontH = sightexports.sGui:getFontHeight(guiDatas.midFontRaw)
	end
	speedoHoverState = false
	unitHoverState = false
end
function getVehicleRPM(vehicle)
	local vehicleRPM = 0
	if vehicle then
		if getVehicleEngineState(vehicle) == true then
			if 0 < getVehicleCurrentGear(vehicle) then
				vehicleRPM = math.floor(getVehicleSpeed(vehicle, "KM/H") / getVehicleCurrentGear(vehicle) * 160 + 0.5)
				if vehicleRPM < 650 then
					vehicleRPM = math.random(650, 700)
				elseif 9000 <= vehicleRPM then
					vehicleRPM = math.random(9000, 9900)
				end
			else
				vehicleRPM = math.floor(getVehicleSpeed(vehicle, "KM/H") * 160 + 0.5)
				if vehicleRPM < 650 then
					vehicleRPM = math.random(650, 700)
				elseif 9000 <= vehicleRPM then
					vehicleRPM = math.random(9000, 9900)
				end
			end
		else
			vehicleRPM = 0
		end
		return tonumber(vehicleRPM)
	else
		return 0
	end
end
local lastBrake = 0
local lastBeltDistance = 0
local hbButtonState = false
local suspDebug = {
	{},
	{},
	{},
	{}
}
local playing = {}
local tmpGear = 0
local nosLevel = 0
local nosPurple = false
local nosLevelAnimation = false
local nosRefill = 1.1
local nosRefillTime = 1000
function modloaderLoaded()
	speedbumpModel = 10000
	local objects = getElementsByType("object", getRootElement(), true)
	for i = 1, #objects do
		if getElementModel(objects[i]) == speedbumpModel then
			streamedBumps[objects[i]] = true
			setElementCollisionsEnabled(objects[i], speedbumpCol)
		end
	end
end
addEventHandler("onClientObjectStreamIn", getRootElement(), function()
	if speedbumpModel and getElementModel(source) == speedbumpModel then
		streamedBumps[source] = true
		setElementCollisionsEnabled(source, speedbumpCol)
	end
end)
addEventHandler("onClientObjectStreamOut", getRootElement(), function()
	if speedbumpModel and getElementModel(source) == speedbumpModel then
		streamedBumps[source] = nil
	end
end)
function getAccelerating(gear)
	if 0 < gear then
		if overrideControls.accelerate then
			return 0 < overrideControls.accelerate
		end
		return 0 < getAnalogControlState("accelerate")
	else
		if overrideControls.brake_reverse then
			return 0 < overrideControls.brake_reverse
		end
		return 0 < getAnalogControlState("brake_reverse")
	end
end
function getBraking(gear)
	if absState then
		return 1
	end
	if 0 < gear then
		if overrideControls.brake_reverse then
			return overrideControls.brake_reverse
		end
		return getAnalogControlState("brake_reverse")
	else
		if overrideControls.accelerate then
			return overrideControls.accelerate
		end
		return getAnalogControlState("accelerate")
	end
end
function setOverrideControl(tmp, control, state)
	tmp[control] = math.max(0, state)
end
local tuningIntro = false
local tuningState = false
local pitLimiter = false
local dynoMode = false
local dynoStarted = false
local forceBrake = false
function toggleSeeDyno(state, started)
	dynoMode = state
	dynoStarted = started
end
function toggleTuningIntro(state)
	tuningIntro = state and getTickCount() or false
end
function toggleTuningState(state)
	tuningState = state
end
function togglePitLimiter(state)
	pitLimiter = state
end
function toggleForceBrake(state)
	forceBrake = state
end
addEvent("toggleForceBrake", true)
addEventHandler("toggleForceBrake", getRootElement(), toggleForceBrake)
function processControls(now, delta, hp, gear, eng)
	absState = false
	local tmp = {}
	if tuningIntro then
		local vx, vy, vz = getElementPosition(currentVehicle)
		local d = vy - 30.40625
		local dx = vx - 1.71875
		setOverrideControl(tmp, "handbrake", 0)
		if 0 < dx then
			setOverrideControl(tmp, "vehicle_right", math.min(1, dx * 25))
		else
			setOverrideControl(tmp, "vehicle_left", math.min(1, -dx * 25))
		end
		if 1000 < now - tuningIntro then
			if 0.1 < d then
				setElementRotation(currentVehicle, 0, 0, 180)
				setOverrideControl(tmp, "brake_reverse", 0)
				local desiredSpeed = 4 + d * 0.5
				if currentSpeed <= desiredSpeed - 3 then
					setOverrideControl(tmp, "accelerate", 0.5)
				elseif desiredSpeed >= currentSpeed then
					local analog = 1 - (currentSpeed - 3) / (desiredSpeed - 3)
					setOverrideControl(tmp, "accelerate", analog * 0.5)
				else
					setOverrideControl(tmp, "accelerate", 0)
				end
			else
				if 1 < currentSpeed and 0 < gear then
					setOverrideControl(tmp, "brake_reverse", 1)
				else
					setOverrideControl(tmp, "brake_reverse", 0)
				end
				setOverrideControl(tmp, "accelerate", 0)
				setElementVelocity(currentVehicle, 0, 0, 0)
			end
		end
	elseif handbrakeState then
		setOverrideControl(tmp, "accelerate", 0)
		setOverrideControl(tmp, "brake_reverse", 0)
	elseif tuningState then
		setOverrideControl(tmp, "accelerate", 0)
		setOverrideControl(tmp, "brake_reverse", 0)
	elseif dynoMode then
		setOverrideControl(tmp, "handbrake", 0)
		setOverrideControl(tmp, "accelerate", dynoStarted and 1 or 0)
		setOverrideControl(tmp, "vehicle_left", 0)
		setOverrideControl(tmp, "vehicle_right", 0)
		if dynoStarted then
			setOverrideControl(tmp, "brake_reverse", 0)
		else
			setOverrideControl(tmp, "brake_reverse", 1 < currentSpeed and 0 < gear and 1 or 0)
		end
	elseif eng and currentVehicleShifter == false then
		local playerAcceleration = getAnalogControlState("accelerate")
		local playerBrake = getAnalogControlState("brake_reverse")
		local desiredAcceleration = playerAcceleration
		if setCruiseSpeed then
			if 0 < playerBrake then
				if cruiseSpeed then
					playSound("files/tempooff.wav")
				end
				cruiseSpeed = false
				setCruiseSpeed = false
				syncedCruiseSpeed = false
				triggerServerEvent("setVehicleCruiseSpeed", localPlayer)
			else
				local delta = cruiseSpeed * 1.025 - currentSpeed
				if cruiseDistance and (delta < -10 or cruiseSpeed <= 0) and 0 < currentGear then
					playerBrake = cruiseSpeed <= 0 and 1 or math.max(0, math.min(1, -(delta + 10) / 50))
					setOverrideControl(tmp, "brake_reverse", playerBrake)
				else
					desiredAcceleration = math.max(desiredAcceleration, math.min(1, delta / 10))
					setOverrideControl(tmp, "brake_reverse", 0)
				end
			end
		end
		if currentSpeed <= 1 and 0 < playerBrake and desiredAcceleration <= 0 then
			autoHold = autoHold + delta
		elseif 1 < currentSpeed or 0 < desiredAcceleration then
			autoHold = 0
		end
		if playerAcceleration < desiredAcceleration then
			setOverrideControl(tmp, "accelerate", desiredAcceleration)
		end
		if gear == 0 then
			currentGear = -1
		end
	elseif currentVehicleShifter and eng then
		local playerAcceleration = getAnalogControlState("accelerate")
		local playerBrake = getAnalogControlState("brake_reverse")
		if currentSelectedGear == "N" then
			if 2 < currentSpeed then
				if 0 < gear then
					setOverrideControl(tmp, "accelerate", 0)
				else
					setOverrideControl(tmp, "accelerate", playerBrake)
					setOverrideControl(tmp, "brake_reverse", 0)
				end
			else
				setOverrideControl(tmp, "brake_reverse", 0)
				setOverrideControl(tmp, "accelerate", 0)
			end
		else
			local desiredAcceleration = playerAcceleration
			if setCruiseSpeed then
				if 0 < playerBrake then
					if cruiseSpeed then
						playSound("files/tempooff.wav")
					end
					cruiseSpeed = false
					setCruiseSpeed = false
					syncedCruiseSpeed = false
					triggerServerEvent("setVehicleCruiseSpeed", localPlayer)
				else
					local delta = cruiseSpeed * 1.025 - currentSpeed
					if cruiseDistance and (delta < -10 or cruiseSpeed <= 0) and 0 < currentGear then
						playerBrake = cruiseSpeed <= 0 and 1 or math.max(0, math.min(1, -(delta + 10) / 50))
						setOverrideControl(tmp, "brake_reverse", playerBrake)
					else
						desiredAcceleration = math.max(desiredAcceleration, math.min(1, delta / 10))
						setOverrideControl(tmp, "brake_reverse", 0)
					end
				end
			end
			if playerBrake <= 0 and handBrakeLevel <= 0 and autoHold < 750 then
				local desiredSpeed = 7
				if hp < 725 then
					desiredSpeed = 4 + 3 * math.max(0, (hp - 250) / 475)
				end
				if currentSpeed <= desiredSpeed - 3 then
					if not isVehicleElectric(currentVehicle) then
						desiredAcceleration = math.max(0.5, desiredAcceleration)
					end
				elseif desiredSpeed >= currentSpeed then
					local analog = 1 - (currentSpeed - 3) / (desiredSpeed - 3)
					if not isVehicleElectric(currentVehicle) then
						desiredAcceleration = math.max(analog * 0.5, desiredAcceleration)
					end
				end
			end
			if currentSelectedGear == "R" then
				if gear <= 0 then
					setOverrideControl(tmp, "accelerate", playerBrake)
				else
					setOverrideControl(tmp, "accelerate", 0)
				end
				setOverrideControl(tmp, "brake_reverse", desiredAcceleration)
			elseif currentSelectedGear == "D" then
				if currentSpeed <= 1 and 0 < playerBrake and desiredAcceleration <= 0 then
					autoHold = autoHold + delta
				elseif 1 < currentSpeed or 0 < desiredAcceleration then
					autoHold = 0
				end
				if gear <= 0 then
					if 1 < currentSpeed then
						setOverrideControl(tmp, "accelerate", math.max(desiredAcceleration, playerBrake))
					else
						setOverrideControl(tmp, "accelerate", desiredAcceleration)
					end
					setOverrideControl(tmp, "brake_reverse", 0)
				else
					if 0 < playerBrake and 1 < currentSpeed and absLevel then
						for i = 0, 3 do
							if getVehicleWheelFrictionState(currentVehicle, i) == 3 then
								setOverrideControl(tmp, "brake_reverse", math.min(absValues[absLevel] or 0.5, playerBrake))
								absState = true
								break
							end
						end
					end
					if currentSpeed <= 1 then
						setOverrideControl(tmp, "brake_reverse", 0)
					end
					if playerAcceleration < desiredAcceleration then
						setOverrideControl(tmp, "accelerate", desiredAcceleration)
					end
				end
			end
		end
	end
	if forceBrake and 0 < gear then
		setOverrideControl(tmp, "accelerate", 0)
		setOverrideControl(tmp, "brake_reverse", 1)
		if currentSpeed < 50 then
			forceBrake = false
		end
	end
	if pitLimiter and 60 <= currentSpeed then
		local cont = getAnalogControlState("accelerate")
		setOverrideControl(tmp, "accelerate", math.max(0, 1 - (currentSpeed - 60)) * cont)
	end
	if math.abs(currentSteeringPulling) >= 0.05 and not tuningIntro and not dynoMode then
		local left = getAnalogControlState("vehicle_left")
		local right = getAnalogControlState("vehicle_right")
		if left < 0 then
			right = -left
		end
		if right < 0 then
			left = -right
		end
		local pull = currentSteeringPulling * 0.5
		if pull < 0 then
			if left <= -pull and right <= 0 then
				setOverrideControl(tmp, "vehicle_left", -pull)
			end
		elseif right <= pull and left <= 0 then
			setOverrideControl(tmp, "vehicle_right", pull)
		end
	end
	for c, v in pairs(overrideControls) do
		if tmp[c] then
			overrideControls[c] = tmp[c]
			setAnalogControlState(c, v, true)
			tmp[c] = nil
		elseif (c == "vehicle_left" or c == "vehicle_right") and not tmp.vehicle_left and not tmp.vehicle_right then
			setAnalogControlState("vehicle_left")
			setAnalogControlState("vehicle_right")
			overrideControls[c] = nil
		else
			setAnalogControlState(c)
			overrideControls[c] = nil
		end
	end
	for c, v in pairs(tmp) do
		overrideControls[c] = v
		setAnalogControlState(c, v, true)
	end
end
function preRenderSpeedo(delta)
	if not canSiren and not canSirenCivil and isElement(currentVehicle) and getVehicleSirensOn(currentVehicle) then
		setVehicleSirensOn(currentVehicle, false)
	end
	if nosLevelAnimation then
		local p = (getTickCount() - nosLevelAnimation[1]) / nosLevelAnimation[4]
		if 1 < p then
			p = 1
		end
		nosLevel = nosLevelAnimation[2] + (nosLevelAnimation[3] - nosLevelAnimation[2]) * p
		if 1 <= p then
			nosRefill = 0
			nosLevelAnimation = false
		end
	elseif nosRefill < 1.1 then
		nosRefill = nosRefill + 1 * delta / nosRefillTime
		if 1.1 < nosRefill then
			nosRefill = 1.1
		end
	end
	if currentVehicle then
		local veh = getPedOccupiedVehicle(localPlayer)
		if currentVehicle ~= veh then
			deInitVeh()
			return
		end
		local tmp = (signalOriginalStates[currentVehicle] and signalState[currentVehicle] and signalOriginalStates[currentVehicle][4] or getVehicleOverrideLights(currentVehicle)) == 2
		if tmp ~= currentVehicleLight then
			currentVehicleLight = tmp
			sightexports.sVehicles:updateSpeedoVehicleLight(currentVehicleLight)
		end
		local eng = getVehicleEngineState(currentVehicle)
		if currentVehicleType == "BMX" then
			if not eng then
				setVehicleEngineState(currentVehicle, true)
				eng = true
			end
		else
			if currentVehicleType ~= "Boat" then
				local tmp = getElementHealth(currentVehicle) > 250 and engine or false
				if eng ~= tmp then
					setVehicleEngineState(currentVehicle, tmp)
					eng = tmp
				end
			end
		end

		if currentVehicleType == "Helicopter" then
			local eng = getVehicleRotorState(currentVehicle)

			local tmp = getElementHealth(currentVehicle) > 250 and engine or false
			if eng ~= tmp then
				setVehicleRotorState(currentVehicle, tmp, engine and true or false)
				eng = tmp
			end
		end
		local hp = getElementHealth(currentVehicle)
		currentSpeed = getVehicleSpeed(currentVehicle, "KMH")
		currentDisplaySpeed = getVehicleSpeed(currentVehicle)
		if currentVehicleShifter or getElementData(currentVehicle, "haveAutomaticShifter") and not isBike(currentVehicle) or not isBoat(currentVehicle) then
			local occupants = getVehicleOccupants(currentVehicle)
			local tmp = {}
			for k, client in pairs(occupants) do
				if type(seatBeltOccupants[client]) ~= "boolean" and getElementType(client) == "player" then
					seatBeltOccupants[client] = getElementData(client, "seatBelt") and true or false
				end
				tmp[client] = true
			end
			seatBeltState = true
			for client, val in pairs(seatBeltOccupants) do
				if not tmp[client] then
					seatBeltOccupants[client] = nil
				elseif not val then
					seatBeltState = false
				end
			end
			if seatBeltState then
				if isElement(seatBeltSound) then
					destroyElement(seatBeltSound)
				end
				seatBeltSound = nil
			elseif 5 < currentSpeed and ignition and seatBeltSoundList[currentVehicleModel] and not isElement(seatBeltSound) then
				seatBeltSound = playSound(seatBeltSoundList[currentVehicleModel], true)
				setSoundVolume(seatBeltSound, 0.35)
			end
			if not seatBeltState and isVehicleElectric(currentVehicle) then
				if 5 < currentSpeed and seatBeltSoundList[currentVehicleModel] and not isElement(seatBeltSound) then
					seatBeltSound = playSound(seatBeltSoundList[currentVehicleModel], true)
					setSoundVolume(seatBeltSound, 0.35)
				end
			end
		end
		local gear = getVehicleCurrentGear(currentVehicle)
		local controller = getVehicleController(currentVehicle)
		local now = getTickCount()
		if setCruiseSpeed then
			if cruiseDistance then
				local tmp = {}
				local tmpSpd = setCruiseSpeed
				cruiseVeh = false
				local matrix = getElementMatrix(currentVehicle)
				local minx, miny, minz, maxx, maxy, maxz = getElementBoundingBox(currentVehicle)
				local vx, vy, vz = matrix[2][1], matrix[2][2], matrix[2][3]
				local sx, sy, sz = matrix[1][1], matrix[1][2], matrix[1][3]
				local zx, zy, zz = matrix[3][1], matrix[3][2], matrix[3][3]
				local d = 7 + cruiseDistance * (1 + 8 * currentSpeed / 200)
				for j = -1, 2 do
					for i = -2, 2 do
						local x, y, z = matrix[4][1] + i * sx * (miny - maxy) / 5 / 2 * 0.5, matrix[4][2] + i * sy * (miny - maxy) / 5 / 2 * 0.5, matrix[4][3] + i * sz * (miny - maxy) / 5 / 2 * 0.5
						x, y, z = x + vx * maxy, y + vy * maxy, z + vz * maxy
						local x2, y2, z2 = matrix[4][1] + i * sx * (miny - maxy) / 5 / 2 * (1 + d / 40), matrix[4][2] + i * sy * (miny - maxy) / 5 / 2 * (1 + d / 40), matrix[4][3] + i * sz * (miny - maxy) / 5 / 2 * (1 + d / 40)
						x2, y2, z2 = x2 + vx * (maxy + d) + zx * j * d / 40, y2 + vy * (maxy + d) + zy * d / 40, z2 + vz * (maxy + d) + zz * j * d / 40
						local hit, hx, hy, hz, he = processLineOfSight(x, y, z, x2, y2, z2, false, true, false, false, false, false, false, false, currentVehicle)
						if hit and isElement(he) and not tmp[he] then
							tmp[he] = true
							local distance = getDistanceBetweenPoints3D(x, y, z, hx, hy, hz) / d
							local tsp = getVehicleSpeed(he, "KMH")
							if distance < 0.35 then
								tmpSpd = 0
								cruiseSpeed = 0
								if 2.5 < currentSpeed then
									if not isElement(cruiseSound) then
										cruiseSound = playSound("files/tempcritical.mp3", true)
									end
									cruiseCritical = now
								end
							elseif distance < 0.5 then
								local p = distance / 0.5
								tmpSpd = math.min(cruiseSpeed, tsp * (1 - 0.65 * (1 - p)))
							else
								local p = 1 - (distance - 0.5) / 0.5
								tmpSpd = math.min(cruiseSpeed, cruiseSpeed + (tsp - cruiseSpeed) * p)
							end
							cruiseVeh = true
						end
					end
				end
				if tmpSpd < cruiseSpeed then
					cruiseSpeed = cruiseSpeed - 100 * delta / 1000
					if tmpSpd > cruiseSpeed then
						cruiseSpeed = tmpSpd
					end
				elseif tmpSpd > cruiseSpeed then
					cruiseSpeed = cruiseSpeed + 100 * delta / 1000
					if tmpSpd < cruiseSpeed then
						cruiseSpeed = tmpSpd
					end
				end
			else
				cruiseSpeed = setCruiseSpeed
			end
			if cruiseCritical and 250 < now - cruiseCritical then
				if isElement(cruiseSound) then
					destroyElement(cruiseSound)
				end
				cruiseSound = nil
				cruiseCritical = false
			end
		end
		if controller == localPlayer then
			if setCruiseSpeed then
				if getKeyState(cruiseKeys.increase) then
					if setCruiseSpeed < 180 then
						setCruiseSpeed = setCruiseSpeed + 20 * delta / 1000
						lastCruiseSpeedSet = now
						if 180 < setCruiseSpeed then
							setCruiseSpeed = 180
						end
					end
				elseif getKeyState(cruiseKeys.decrease) and 30 < setCruiseSpeed then
					setCruiseSpeed = setCruiseSpeed - 20 * delta / 1000
					lastCruiseSpeedSet = now
					if setCruiseSpeed < 30 then
						setCruiseSpeed = 30
					end
				end
				if not cruiseDistance then
					cruiseSpeed = setCruiseSpeed
				end
				if syncedCruiseSpeed ~= setCruiseSpeed and 1000 < now - lastCruiseSpeedSet then
					lastCruiseSpeedSet = now
					syncedCruiseSpeed = setCruiseSpeed
					triggerServerEvent("setVehicleCruiseSpeed", localPlayer, setCruiseSpeed)
				end
			end
			if gear ~= tmpGear then
				tmpGear = gear
				triggerServerEvent("syncVehicleCurrentGear", localPlayer, gear)
			end
			if flSusp <= 50 or rlSusp <= 50 or frSusp <= 50 or rrSusp <= 50 then
				local x, y, z = getElementPosition(currentVehicle)
				local x1, y1, z1 = getVehicleComponentPosition(currentVehicle, "wheel_rb_dummy")
				local x2, y2, z2 = getVehicleComponentPosition(currentVehicle, "wheel_lb_dummy")
				local x3, y3, z3 = getVehicleComponentPosition(currentVehicle, "wheel_lf_dummy")
				local x4, y4, z4 = getVehicleComponentPosition(currentVehicle, "wheel_rf_dummy")
				local avg1 = (z1 + z2) / 2
				local avg2 = (z3 + z4) / 2
				local hp = rrSusp
				local sg = 0.025 + 0.035 * hp / 50
				local players = getElementsByType("player", getRootElement(), true)
				if sg <= avg1 - z1 then
					if not playing[1] then
						playing[1] = true
						local vol = math.min(0.5, math.max(0.1, 0.1 + (avg1 - z1) / sg * 0.25)) * (0.25 + 0.75 * (1 - hp / 50))
						triggerLatentServerEvent("syncVehicleKnockSound", getRootElement(), currentVehicle, players, vol, x1, y1, z1)
					end
				else
					playing[1] = false
				end
				local hp = rlSusp
				if sg <= avg1 - z2 then
					if not playing[2] then
						playing[2] = true
						local vol = math.min(0.5, math.max(0.1, 0.1 + (avg1 - z2) / sg * 0.25)) * (0.25 + 0.75 * (1 - hp / 50))
						triggerLatentServerEvent("syncVehicleKnockSound", getRootElement(), currentVehicle, players, vol, x2, y2, z2)
					end
				else
					playing[2] = false
				end
				local hp = flSusp
				if sg <= avg2 - z3 then
					if not playing[3] then
						playing[3] = true
						local vol = math.min(0.5, math.max(0.1, 0.1 + (avg2 - z3) / sg * 0.25)) * (0.25 + 0.75 * (1 - hp / 50))
						triggerLatentServerEvent("syncVehicleKnockSound", getRootElement(), currentVehicle, players, vol, x3, y3, z3)
					end
				else
					playing[3] = false
				end
				local hp = frSusp
				if sg <= avg2 - z4 then
					if not playing[4] then
						playing[4] = true
						local vol = math.min(0.5, math.max(0.1, 0.1 + (avg2 - z4) / sg * 0.25)) * (0.1 + 0.9 * hp / 50)
						triggerLatentServerEvent("syncVehicleKnockSound", getRootElement(), currentVehicle, players, vol, x4, y4, z4)
					end
				else
					playing[4] = false
				end
			end
			local accelerating = getAccelerating(gear)
			local braking = getBraking(gear) * currentSpeed * delta / 3600000
			local frontBrake = braking
			local rearBrake = braking
			processControls(now, delta, hp, gear, eng)
			if not getPedControlState(controller, "handbrake") then
				hbButtonState = false
			end
			if getPedControlState(controller, "handbrake") then
				rearBrake = 1 * currentSpeed * delta / 3600000
			end
			frontBrake = frontBrake * 1.1
			frontBrakeDistance = frontBrakeDistance + frontBrake
			rearBrakeDistance = rearBrakeDistance + rearBrake
			if (timingHP <= 35 or hp <= 600) and accelerating then
				lastBeltDistance = lastBeltDistance - currentSpeed * delta / 3600000
				if lastBeltDistance < 0 then
					triggerServerEvent("syncVehicleBeltSound", getRootElement(), currentVehicle, getElementsByType("player", getRootElement(), true))
					lastBeltDistance = math.random(60, 180) / 100
				end
			end
			if (frontBrakeHP <= 40 or rearBrakeHP <= 40) and (1.0E-4 < frontBrake or 1.0E-4 < rearBrake) and 5000 < now - lastBrake then
				lastBrake = now
				triggerServerEvent("syncVehicleBrakeNoise", getRootElement(), currentVehicle, getElementsByType("player", getRootElement(), true))
			end
		else
			if currentVehicleShifter and currentSelectedGear == "D" then
				if currentSpeed <= 1 then
					autoHold = autoHold + delta
				else
					autoHold = 0
				end
			end
			absState = false
			if 1 < currentSpeed and absLevel then
				for i = 0, 3 do
					if getVehicleWheelFrictionState(currentVehicle, i) == 3 then
						absState = true
						break
					end
				end
			end
		end
		if controller and not handbrakeState and getPedControlState(controller, "handbrake") and not hbButtonState then
			handBrakeLevel = handBrakeLevel + 10 * delta / 1000
			if 1 < handBrakeLevel then
				handBrakeLevel = 1
				if currentSpeed < 2 and controller == localPlayer then
					handbrakeState = true
					hbButtonState = true
					triggerServerEvent("setHandbrakeState", localPlayer, true)
				end
			end
		elseif handbrakeState then
			if controller == localPlayer and not hbButtonState and getPedControlState(controller, "handbrake") then
				handbrakeState = false
				hbButtonState = true
				triggerServerEvent("setHandbrakeState", localPlayer, false)
			end
			if handBrakeLevel < 1 then
				handBrakeLevel = handBrakeLevel + 10 * delta / 1000
				if 1 < handBrakeLevel then
					handBrakeLevel = 1
				end
			end
		elseif 0 < handBrakeLevel then
			handBrakeLevel = handBrakeLevel - 10 * delta / 1000
			if handBrakeLevel < 0 then
				handBrakeLevel = 0
			end
		end
		local tmp = 0
		if currentVehicleShifter then
			if currentSelectedGear == "D" then
				tmp = 1
			elseif currentSelectedGear == "R" then
				tmp = -1
			end
			if currentGear ~= tmp then
				currentGear = tmp
				currentGearChange = now
			end
			local neededPos = currentGear * gearSize
			if neededPos > gearPos then
				gearPos = gearPos + delta / 1000 * gearSize * 4
				if neededPos <= gearPos then
					gearPos = neededPos
				end
			elseif neededPos < gearPos then
				gearPos = gearPos - delta / 1000 * gearSize * 4
				if neededPos >= gearPos then
					gearPos = neededPos
				end
			end
		else
			if getVehicleEngineState(currentVehicle) then
				tmp = getVehicleCurrentGear(currentVehicle)
			end
			if currentGear ~= tmp then
				currentGear = tmp
				currentGearChange = now
			end
			local neededPos = (currentGear - 1) * gearSize
			if neededPos > gearPos then
				gearPos = gearPos + delta / 1000 * gearSize * 4
				if neededPos <= gearPos then
					gearPos = neededPos
				end
			elseif neededPos < gearPos then
				gearPos = gearPos - delta / 1000 * gearSize * 4
				if neededPos >= gearPos then
					gearPos = neededPos
				end
			end
		end
		local neededRpm = getVehicleRPM(currentVehicle)
		if neededRpm > currentRpm then
			currentRpm = currentRpm + delta / 1000 * 5000
			if neededRpm <= currentRpm then
				currentRpm = neededRpm
			end
		elseif neededRpm < currentRpm then
			currentRpm = currentRpm - delta / 1000 * 5000
			if neededRpm >= currentRpm then
				currentRpm = neededRpm
			end
		end
	end
	local tmp = 40 < currentSpeed
	if tmp ~= speedbumpCol then
		speedbumpCol = tmp
		for obj in pairs(streamedBumps) do
			setElementCollisionsEnabled(obj, speedbumpCol)
		end
	end
end
if currentVehicle then
	initVeh()
	sightlangCondHandl1(currentVehicle)
end
addEvent("syncVehicleBrakeNoise", true)
addEventHandler("syncVehicleBrakeNoise", getRootElement(), function(s)
	if isElement(source) and tonumber(s) and 1 <= s and s <= 3 then
		local x, y, z = getElementPosition(source)
		local sound = playSound3D("files/brake" .. s .. ".mp3", x, y, z)
		setSoundVolume(sound, 0.4)
		setSoundMaxDistance(sound, 60)
		local x, y, z = getVehicleComponentPosition(source, "wheel_rb_dummy")
		attachElements(sound, source, 0, y, z)
	end
end)
addEvent("syncVehicleBeltSound", true)
addEventHandler("syncVehicleBeltSound", getRootElement(), function(s)
	if isElement(source) and tonumber(s) and 1 <= s and s <= 2 then
		local x, y, z = getElementPosition(source)
		local sound = playSound3D("files/ekszij" .. s .. ".mp3", x, y, z)
		setSoundVolume(sound, 0.7)
		setSoundMaxDistance(sound, 60)
		local x, y, z = getVehicleDummyPosition(source, "engine")
		attachElements(sound, source, x, y, z)
	end
end)
function refreshSpeedoAutoGearShift(vehicle)
	if getElementData(vehicle, "haveAutomaticShifter") then
		currentVehicleShifter = false
	else
		currentVehicleShifter = getVehicleType(vehicle) == "Automobile"
	end
end
addEvent("refreshSpeedoAutoGearShift", true)
addEventHandler("refreshSpeedoAutoGearShift", root, refreshSpeedoAutoGearShift)
addEvent("syncVehicleKnockSound", true)
addEventHandler("syncVehicleKnockSound", getRootElement(), function(s, vol, x, y, z)
	vol = tonumber(vol)
	x = tonumber(x)
	y = tonumber(y)
	z = tonumber(z)
	if isElement(source) and vol and 0 < vol and vol <= 0.5 and x and y and z and tonumber(s) and 1 <= s and s <= 4 then
		local sound = playSound3D("files/futomu" .. math.random(1, 4) .. ".mp3", x, y, z)
		attachElements(sound, source, x, y, z)
		setSoundMaxDistance(sound, 50)
		setSoundVolume(sound, vol)
	end
end)
function thousandsStepper(amount)
	local formatted = amount
	while true do
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", "%1 %2")
		if k == 0 then
			break
		end
	end
	return formatted
end
speedoHoverState = false
unitHoverState = false
fuelHoverState = false
local fuelClosed = fileExists("fuelclosed.sg")
local currentNameText = 1
local changeAnimation = false
local oldNameText = 1
addEvent("gotVehicleNosLevel", true)
addEventHandler("gotVehicleNosLevel", getRootElement(), function(level, purple, anim, time, refillTime)
	nosPurple = purple
	level = level / 4
	if anim then
		nosLevelAnimation = {
			getTickCount(),
			nosLevel,
			level,
			time
		}
		nosRefillTime = refillTime - time
	end
	nosLevel = level
end)
function clickSpeedo(button, state, cx, cy)
	if state == "down" and not sightexports.sHud:getWidgetEditMode() then
		if speedoHoverState then
			oldNameText = currentNameText
			currentNameText = currentNameText + 1
			if currentNameText > #speedoNameTexts then
				currentNameText = 1
			end
			changeAnimation = getTickCount()
		elseif fuelHoverState then
			fuelHoverState = false
			fuelClosed = not fuelClosed
			if fileExists("fuelclosed.sg") then
				fileDelete("fuelclosed.sg")
			end
			if fuelClosed then
				local file = fileCreate("fuelclosed.sg")
				if file then
					fileClose(file)
				end
			end
		elseif unitHoverState then
			sightexports.sDashboard:saveValue("speedoUnit", unit == "KM/H" and "MPH" or "KM/H")
			setUnit(unit == "KM/H" and "MPH" or "KM/H")
		end
	end
end
local doors = {
	"door_lf_dummy",
	"door_rf_dummy",
	"door_lr_dummy",
	"door_rr_dummy"
}
local hoveringCar = false
local hoveringDoor = false
local hoveringBelt = false
function renderIcons()
	if not currentVehicle then
		local cx, cy = getCursorPosition()
		if cx then
			cx = cx * screenX
			cy = cy * screenY
		else
			if hoveringCar then
				sightexports.sGui:setCursorType("normal")
				sightexports.sGui:showTooltip()
			end
			hoveringCar = nil
			return
		end
		local tmp = false
		local tmpD = false
		local tmpB = false
		local vehicles = getElementsByType("vehicle", getRootElement(), true)
		local px, py, pz = getElementPosition(localPlayer)
		for i = 1, #vehicles do
			if isElement(vehicles[i]) then
				local x, y, z = getElementPosition(vehicles[i])
				if getDistanceBetweenPoints3D(px, py, pz, x, y, z) < 5 then
					local occupants = getVehicleOccupants(vehicles[i])
					if occupants then
						for j = 1, #doors do
							if occupants[j - 1] and getElementType(occupants[j - 1]) == "player" and occupants[j - 1] ~= localPlayer and (getVehicleDoorOpenRatio(vehicles[i], j + 1) > 0.25 or getVehicleDoorState(vehicles[i], j + 1) == 4 or isHeli(vehicles[i]) or isBike(vehicles[i])) then
								local x, y, z = getVehicleComponentPosition(vehicles[i], doors[j], "world")
								local maxDist = 2
								if not (x and y) or not z then
									x, y, z = getElementPosition(occupants[j - 1])
									maxDist = 3.5
								end
								if x and y and z and maxDist > getDistanceBetweenPoints3D(px, py, pz, x, y, z) then
									local x, y = getScreenFromWorldPosition(x, y, z, 128)
									if x then
										dxDrawRectangle(x - 16, y - 32 - 3, 32, 32, btnBcg)
										if cx and cx <= x + 16 and cx >= x - 16 and cy >= y - 32 - 3 and cy <= y - 3 then
											dxDrawImage(x - 12, y - 16 - 3 - 12, 24, 24, ":sGui/" .. removeIcon .. (faTicks[removeIcon] or ""), 0, 0, 0, btnCol)
											tmp = vehicles[i]
											tmpD = j
										else
											dxDrawImage(x - 12, y - 16 - 3 - 12, 24, 24, ":sGui/" .. removeIcon .. (faTicks[removeIcon] or ""))
										end
										if not isHeli(vehicles[i]) and not isBike(vehicles[i]) then
											dxDrawRectangle(x - 16, y + 3, 32, 32, btnBcg)
											local ys = 17.77777777777778
											if cx and cx <= x + 16 and cx >= x - 16 and cy >= y + 3 and cy <= y + 3 + 32 then
												sightlangStaticImageUsed[1] = true
												if sightlangStaticImageToc[1] then
													processSightlangStaticImage[1]()
												end
												dxDrawImage(x - 12, y + 3 + 16 - ys / 2, 24, ys, sightlangStaticImage[1], 0, 0, 0, btnCol)
												tmp = vehicles[i]
												tmpD = j
												tmpB = true
											else
												sightlangStaticImageUsed[1] = true
												if sightlangStaticImageToc[1] then
													processSightlangStaticImage[1]()
												end
												dxDrawImage(x - 12, y + 3 + 16 - ys / 2, 24, ys, sightlangStaticImage[1])
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
		if tmp ~= hoveringCar or tmpD ~= hoveringDoor or tmpB ~= hoveringBelt then
			hoveringCar = tmp
			hoveringDoor = tmpD
			hoveringBelt = tmpB
			sightexports.sGui:setCursorType(hoveringCar and "link" or "normal")
			if hoveringBelt then
				local occupant = getVehicleOccupant(hoveringCar, hoveringDoor - 1)
				if isElement(occupant) then
					if getElementData(occupant, "seatBelt") then
						sightexports.sGui:showTooltip("Öv kicsatolása")
					else
						sightexports.sGui:showTooltip("Öv becsatolása")
					end
				else
					sightexports.sGui:showTooltip()
				end
			elseif hoveringCar then
				sightexports.sGui:showTooltip("Kirángatás az autóból")
			else
				sightexports.sGui:showTooltip()
			end
		end
	end
end
sightlangCondHandl2(true)
function clickIcons(btn, state)
	if hoveringCar and state == "up" then
		local occupant = getVehicleOccupant(hoveringCar, hoveringDoor - 1)
		if isElement(occupant) then
			if hoveringBelt then
				if getTickCount() - lastBelt < 1500 then
					return
				end
				lastBelt = getTickCount()
				local new
				if not getElementData(occupant, "seatBelt") then
					new = hoveringCar
				end
				setElementData(occupant, "seatBelt", new)
				sightexports.sChat:localActionC(localPlayer, (new and "becsatolta" or "kicsatolta") .. " a biztonsági övét: " .. getElementData(occupant, "visibleName"):gsub("_", " ") .. ".")
				if new then
					sightexports.sGui:showTooltip("Öv kicsatolása")
				else
					sightexports.sGui:showTooltip("Öv becsatolása")
				end
			elseif getElementData(occupant, "seatBelt") then
				sightexports.sGui:showInfobox("e", "Előbb kösd ki az övét!")
			else
				if getTickCount() - lastBelt < 1500 then
					sightexports.sGui:showInfobox("e", "Várd meg amíg kikötődik az öve!")
					return
				end
				triggerServerEvent("removePlayerFromVehicle", localPlayer, hoveringCar, occupant)
			end
		end
	end
end
sightlangCondHandl3(true)
function syncCarrying(state)
	if hoveringCar then
		sightexports.sGui:setCursorType("normal")
		sightexports.sGui:showTooltip()
	end
	hoveringCar = nil
	sightlangCondHandl2(not state)
	sightlangCondHandl3(not state)
end
function isVehicleReversing(theVehicle)
    local getMatrix = getElementMatrix (theVehicle)
    local getVelocity = Vector3 (getElementVelocity(theVehicle))
    local getVectorDirection = (getVelocity.x * getMatrix[2][1]) + (getVelocity.y * getMatrix[2][2]) + (getVelocity.z * getMatrix[2][3])
    if (getVectorDirection < 0) then
        return true
    end
    return false
end
local reverseHandling = {}

local lastGearChange = getTickCount()

function calculateChargingCost(currentCharge)
    local percentToCharge = 100 - currentCharge
    if percentToCharge <= 0 then
        return 0, 0
    end
    
    local secondsToCharge = (percentToCharge / 5) * 60
    local costToCharge = (secondsToCharge / 60) * 250
    return secondsToCharge, costToCharge
end

lastElectricSave = getTickCount()

totalChargeMinus = 0

function renderSpeedo()
	if isElement(currentVehicle) then
		local hp = getElementHealth(currentVehicle)
		local mileageUnit = thousandsStepper(math.floor(currentMileage * (unit == "KM/H" and 1 or 0.621371192) + 0.5)) .. (unit == "KM/H" and " km" or " mls")
		local ticks = getTickCount()
		local cx, cy = getCursorPosition()
		if cx then
			cx = cx * screenX
			cy = cy * screenY
		end
		if getVehicleType(currentVehicle) == "Bike" or getVehicleType(currentVehicle) == "Quad" or getVehicleType(currentVehicle) == "Automobile" then
		if not reverseHandling[currentVehicle] then
				reverseHandling[currentVehicle] = {
					setReverse = false
				}
			end

			if isVehicleReversing(currentVehicle) then
				-- HA HANDLING PROBLÉMA VAN ITT KELL KERESNI
				if not reverseHandling[currentVehicle].setReverse then
					reverseHandling[currentVehicle].engineAcceleration = getVehicleHandling(currentVehicle, "engineAcceleration")
					reverseHandling[currentVehicle].maxVelocity = getVehicleHandling(currentVehicle, "maxVelocity")
					reverseHandling[currentVehicle].setReverse = true

					if getVehicleType(currentVehicle) == "Automobile" then
						setVehicleHandling(currentVehicle, "engineAcceleration", reverseHandling[currentVehicle].engineAcceleration / 1.5)
						setVehicleHandling(currentVehicle, "maxVelocity", 50)
					else
						setVehicleHandling(currentVehicle, "engineAcceleration", 5)
						setVehicleHandling(currentVehicle, "maxVelocity", 0.5)
					end
				end
			else
				if reverseHandling[currentVehicle].setReverse then
					reverseHandling[currentVehicle].setReverse = false

					setVehicleHandling(currentVehicle, "engineAcceleration", reverseHandling[currentVehicle].engineAcceleration)
					setVehicleHandling(currentVehicle, "maxVelocity", reverseHandling[currentVehicle].maxVelocity)
				end
			end
		end
		local speed = 0
		local calibrationProgress = 0
		if calibrationStart and ignition then
			local progress = (ticks - calibrationStart) / 1250
			if 1 < progress then
				progress = 2 - progress
			end
			calibrationProgress = progress
			if progress < 0 then
				calibrationStart = false
				afterCalibration = ticks
			else
				speed = progress * (10 * analogDivision)
			end
		end
		local afterCalibrationProgress = 1
		if afterCalibration then
			afterCalibrationProgress = math.min(1, (ticks - afterCalibration) / 500)
			if 1 <= afterCalibrationProgress then
				afterCalibration = false
			end
		end
		if ignition and not calibrationStart then
			speed = currentDisplaySpeed * afterCalibrationProgress
		end
		if speedoType == "tesla" then
			local x = analogPos[1] - 40
			local y = analogPos[2] + 140
			
			if lastGear and lastGear ~= currentSelectedGear then
				lastGearChange = getTickCount()
				if currentSelectedGear == "N" then
					needGap = 0
				elseif currentSelectedGear == "D" then
					needGap = 15
				elseif currentSelectedGear == "R" then
					needGap = -15
				end
			end
			if not needGap then
				needGap = 0
			end
			lastGear = currentSelectedGear
			if not xGap then
				xGap = 0
			end
			xGap = interpolateBetween(xGap, 0, 0, needGap, 0, 0, (getTickCount() - lastGearChange) / 250, "Linear")
			if getVehicleEngineState(currentVehicle) then
				dxDrawRectangle(x + 43 + xGap, y + 43, 16, 24, guiDatas.greenColor)
			end
			dxDrawText("R", x + 27, y + 43, x + 43, y + 67, -1, 0.5, guiDatas.miniFont, "center", "center")
			dxDrawText("N", x + 43, y + 43, x + 59, y + 67, -1, 0.5, guiDatas.miniFont, "center", "center")
			dxDrawText("D", x + 59, y + 43, x + 75, y + 67, -1, 0.5, guiDatas.miniFont, "center", "center")

			local km = getElementData(currentVehicle, "vehicle.distance")

			local chargingState = getElementData(currentVehicle, "vehicle.onCharging")

			if not charged and chargingState and chargingState[2] then
				charged = getTickCount()
			end

			if chargingState and chargingState[2] then
				chargingTime = "00:13"

				local elapsedClientTime = getTickCount() - charged
			
				local elapsedTime = elapsedClientTime
			
				local elapsedTimeUnits = math.floor(elapsedTime / 200)
				local minutes = math.floor(elapsedTime / 60000)
				local remainingSeconds = math.floor((elapsedTime % 60000) / 1000)
				chargingTime = string.format("%02d:%02d", minutes, remainingSeconds)
			
				local totalCost = elapsedTimeUnits * (4.3 / 5)
				chargingMoney = math.floor(totalCost)

			else
				chargingState = false
				charged = false
			end

			if not pulse then
				pulse = 0
			end
			
			local maxAmount = 75
			local amount = getElementData(currentVehicle, "vehicle.fuel")
			local amount = math.floor((amount / maxAmount) * 100)
			

			if chargingState then

				pulse = pulse + 2.5
				local p = math.min(1, math.max(0, pulse))
				dxDrawImageSection(x + 341 - 49, y + 8 + 53, 105 * math.min(1, (p - 0.5) / 0.5), 6, pulse, 0, 500 * math.min(1, (p - 0.5) / 0.5), 6, ":sGui/" .. guiDatas.chargingGradient .. "." .. gradientTicks[guiDatas.chargingGradient], 90, 0, 0, tocolor(255, 255, 255, 255 * 1))
			else
				dxDrawRectangle(x + 341, y + 8, 6, 105, tocolor(26, 27, 31, 200))
				dxDrawRectangle(x + 341, y + 8 + 105, 6, - 105 * (amount / 100))
			end

			if not chargingState then
				dxDrawText(math.floor(km) .. " km", 0, 0, x + 347, y - 31, tocolor(255, 255, 255, 53), 0.44444444444444, guiDatas.miniFont, "right", "bottom")
			end

			local customVehicleModel = getElementData(currentVehicle, "vehicle.customModel")
			local vehicleRealName = exports.sVehiclenames:getCustomVehicleName(customVehicleModel) or exports.sVehiclenames:getCustomVehicleName(vehicleModel) or getVehicleNameFromModel(vehicleModel)

			if engineLightLevel and engineLightLevel == 1 then
				local pulse = ticks % 2000 / 1000
				if 1 < pulse then
					pulse = 2 - pulse
				end
				pulse = getEasingValue(pulse, "InOutQuad")
				pulse = getEasingValue(pulse, "InOutQuad")
				local nameAlpha = 255 * (1 - pulse)
				if not chargingState then
					dxDrawText(vehicleRealName, 0, 0, x + 347, y - 10, tocolor(255, 255, 255, math.abs(nameAlpha)), guiDatas.nameFontScale * 0.9, guiDatas.nameFont, "right", "bottom")
					dxDrawText("* CHECK ENGINE *", 0, 0, x + 347, y - 10, bitReplace(guiDatas.yellowColor, 255 * pulse, 24, 8), guiDatas.nameFontScale * 0.8, guiDatas.nameFont, "right", "bottom")
				end
			elseif engineLightLevel == 2 then
				local pulse = ticks % 2000 / 1000
				if 1 < pulse then
					pulse = 2 - pulse
				end
				pulse = getEasingValue(pulse, "InOutQuad")
				local nameAlpha = 255 * (1 - pulse)
				if not chargingState then
					dxDrawText(vehicleRealName, 0, 0, x + 347, y - 10, tocolor(255, 255, 255, math.abs(nameAlpha)), guiDatas.nameFontScale * 0.9, guiDatas.nameFont, "right", "bottom")
					dxDrawText("* CHECK ENGINE *", 0, 0, x + 347, y - 10, bitReplace(guiDatas.redColor, 255 * pulse, 24, 8), guiDatas.nameFontScale * 0.8, guiDatas.nameFont, "right", "bottom")
				end
			else
				if not chargingState then
					dxDrawText(vehicleRealName, 0, 0, x + 347, y - 10, tocolor(255, 255, 255, 255), guiDatas.nameFontScale * 0.9, guiDatas.nameFont, "right", "bottom")
				end
			end

			if chargingState then
				if not chargingState[3] then
					dxDrawText("~ " .. chargingMoney .. " $", 0, 0, x + 347, y - 31, guiDatas.greenColor, 0.44444444444444, guiDatas.miniFont, "right", "bottom")
				end
				if not chargingState[3] then
					dxDrawText("Szuperöltés folyamatban: " .. chargingTime, 0, 0, x + 347, y - 10, tocolor(255, 255, 255, 255), guiDatas.nameFontScale * 0.9, guiDatas.nameFont, "right", "bottom")
				else
					dxDrawText("Töltés folyamatban: " .. chargingTime, 0, 0, x + 347, y - 10, tocolor(255, 255, 255, 255), guiDatas.nameFontScale * 0.9, guiDatas.nameFont, "right", "bottom")
				end
			end

			dxDrawText(amount .. "%", 0, y + 99, x + 335, y + 99, -1, 0.5, guiDatas.miniFont, "right", "center")

			local turnColor = (signalState[currentVehicle] == "right" or signalState[currentVehicle] == "both") and signalStage[currentVehicle] and guiDatas.greenColor or tocolor(255, 255, 255)

			if signalState[currentVehicle] == "emergency" and signalStage[currentVehicle] and currentEmergencyColor then
				turnColor = currentEmergencyColor
			end

			sightlangStaticImageUsed[13] = true

			if sightlangStaticImageToc[13] then
				processSightlangStaticImage[13]()
			end
			dxDrawImage(x + 258, y + 85, 28, 28, sightlangStaticImage[13], 0, 0, 0, turnColor)


			local turnColor = (signalState[currentVehicle] == "left" or signalState[currentVehicle] == "both") and signalStage[currentVehicle] and guiDatas.greenColor or tocolor(255, 255, 255)

			if signalState[currentVehicle] == "emergency" and not signalStage[currentVehicle] and currentEmergencyColor then
				turnColor = currentEmergencyColor
			end

			sightlangStaticImageUsed[15] = true

			if sightlangStaticImageToc[15] then
				processSightlangStaticImage[15]()
			end
			if engineLightLevel and engineLightLevel ~= 0 then
				dxDrawImage(x + 223 - 35, y + 85, 28, 28, sightlangStaticImage[15], 0, 0, 0, turnColor)
			else
				dxDrawImage(x + 223, y + 85, 28, 28, sightlangStaticImage[15], 0, 0, 0, turnColor)
			end

			if absState and handBrakeLevel == 0 then
				sightlangStaticImageUsed[28] = true
				if sightlangStaticImageToc[28] then
					processSightlangStaticImage[28]()
				end
				if not seatBeltState then
					if engineLightLevel and engineLightLevel ~= 0 then
						dxDrawImage(x + 223 - 35 - 35 - 35, y + 85, 28, 28, sightlangStaticImage[28], 0, 0, 0, guiDatas.redColor)
					else
						dxDrawImage(x + 223 - 35 - 35, y + 85, 28, 28, sightlangStaticImage[28], 0, 0, 0, guiDatas.redColor)
					end
				else
					if engineLightLevel and engineLightLevel ~= 0 then
						dxDrawImage(x + 223 - 35 - 35, y + 85, 28, 28, sightlangStaticImage[28], 0, 0, 0, guiDatas.redColor)
					else
						dxDrawImage(x + 223 - 35, y + 85, 28, 28, sightlangStaticImage[28], 0, 0, 0, guiDatas.redColor)
					end
				end
			end

			if not seatBeltState then
				sightlangStaticImageUsed[26] = true

				if sightlangStaticImageToc[26] then
					processSightlangStaticImage[26]()
				end

				local beltColor = guiDatas.brightSpeedoColor
				local p = 0
				if isElement(seatBeltSound) then
					p = getSoundPosition(seatBeltSound) / getSoundLength(seatBeltSound)
				else
					p = ticks % 2000 / 2000
				end

				p = getEasingValue(1 - p, "OutQuad")
				if engineLightLevel and engineLightLevel ~= 0 then
					dxDrawImage(x + 188 - 35, y + 85, 28, 28, sightlangStaticImage[26], 0, 0, 0, bitReplace(guiDatas.redColor, 255 * p, 24, 8))
				else
					dxDrawImage(x + 188, y + 85, 28, 28, sightlangStaticImage[26], 0, 0, 0, bitReplace(guiDatas.redColor, 255 * p, 24, 8))
				end
			end

			if 0.5 <= handBrakeLevel then

				sightlangStaticImageUsed[27] = true
				if sightlangStaticImageToc[27] then
					processSightlangStaticImage[27]()
				end
				if seatBeltState then
					if engineLightLevel and engineLightLevel ~= 0 then
						dxDrawImage(x + 188 - 35, y + 85, 28, 28, sightlangStaticImage[27], 0, 0, 0, guiDatas.redColor)
					else
						dxDrawImage(x + 188, y + 85, 28, 28, sightlangStaticImage[27], 0, 0, 0, guiDatas.redColor)
					end
				else
					if engineLightLevel and engineLightLevel ~= 0 then
						dxDrawImage(x + 188 - 35 - 35, y + 85, 28, 28, sightlangStaticImage[27], 0, 0, 0, guiDatas.redColor)
					else
						dxDrawImage(x + 188 - 35, y + 85, 28, 28, sightlangStaticImage[27], 0, 0, 0, guiDatas.redColor)
					end
				end
			end

			if engineLightLevel and engineLightLevel ~= 0 then
				sightlangStaticImageUsed[14] = true

				if sightlangStaticImageToc[14] then
					processSightlangStaticImage[14]()
				end

				if engineLightLevel == 2 then
					local x, y = x + 223, y + 85
					local pulse = ticks % 2000 / 1000
					if 1 < pulse then
						pulse = 2 - pulse
					end
					pulse = getEasingValue(pulse, "InOutQuad")
					sightlangStaticImageUsed[14] = true
					if sightlangStaticImageToc[14] then
						processSightlangStaticImage[14]()
					end
					dxDrawImage(x, y, iconSizes, iconSizes, sightlangStaticImage[14], 0, 0, 0, bitReplace(guiDatas.speedoColor, 53 - 53 * pulse, 24, 8))
					sightlangStaticImageUsed[14] = true
					if sightlangStaticImageToc[14] then
						processSightlangStaticImage[14]()
					end
					dxDrawImage(x, y, iconSizes, iconSizes, sightlangStaticImage[14], 0, 0, 0, bitReplace(guiDatas.redColor, 255 * pulse, 24, 8))


					sightlangStaticImageUsed[2] = true
					if sightlangStaticImageToc[2] then
						processSightlangStaticImage[2]()
					end

					local size = analogSize

					dxDrawImage(x - 96, y - 206, size, size, sightlangStaticImage[2], 0, 0, 0, bitReplace(guiDatas.redColor, 100, 24, 8))
				elseif engineLightLevel == 1 then
					local x, y = x + 223, y + 85
					local pulse = ticks % 2000 / 1000
					if 1 < pulse then
						pulse = 2 - pulse
					end
					pulse = getEasingValue(pulse, "InOutQuad")
					sightlangStaticImageUsed[14] = true
					if sightlangStaticImageToc[14] then
						processSightlangStaticImage[14]()
					end
					dxDrawImage(x, y, iconSizes, iconSizes, sightlangStaticImage[14], 0, 0, 0, bitReplace(guiDatas.speedoColor, 53 - 53 * pulse, 24, 8))
					sightlangStaticImageUsed[14] = true
					if sightlangStaticImageToc[14] then
						processSightlangStaticImage[14]()
					end
					dxDrawImage(x, y, iconSizes, iconSizes, sightlangStaticImage[14], 0, 0, 0, bitReplace(guiDatas.yellowColor, 255 * pulse, 24, 8))

					sightlangStaticImageUsed[2] = true
					if sightlangStaticImageToc[2] then
						processSightlangStaticImage[2]()
					end

					local size = analogSize

					dxDrawImage(x - 96, y - 206, size, size, sightlangStaticImage[2], 0, 0, 0, bitReplace(guiDatas.yellowColor, 100, 24, 8))
				end
			end

			local controller = getVehicleController(currentVehicle)
			if controller then
				local acceler = getPedAnalogControlState(controller, "accelerate") > 0 or syncedCruiseSpeed
				local brake = getPedAnalogControlState(controller, "brake_reverse") > 0
				if not acceleration and acceler and not stopped then
					acceleration = getTickCount()
					deceleration = false
				elseif not acceler and acceleration and not stopped then
					acceleration = false
					deceleration = getTickCount()
				end
				if getVehicleSpeed(currentVehicle, "KMH") == 0 and not stopped then
					deceleration = false
					stopped = getTickCount()
				elseif getVehicleSpeed(currentVehicle, "KMH") > 0 and stopped then
					stopped = false
				end

				width = width or 0

				if acceleration and not stopped then
					if width < 0 then
						width = interpolateBetween(width, width, width, 0.5, 0, 0, (getTickCount() - (acceleration or 0)) / 100, "Linear")
					else
						width = interpolateBetween(width, width, width, 1, 1, 1, (getTickCount() - (acceleration or 0)) / 3000, "Linear")
					end
				elseif deceleration and not stopped then
					if brake then
						width = interpolateBetween(width, width, width, -1, -0.1, -0.1, (getTickCount() - (deceleration or 0)) / 3000, "Linear")
					else
						width = interpolateBetween(width, width, width, -0.75, -0.1, -0.1, (getTickCount() - (deceleration or 0)) / 3000, "Linear")
					end
				elseif stopped then
					width = interpolateBetween(width, width, width, 0, 0, 0, (getTickCount() - (stopped or 0)) / 1500, "Linear")
				end
				if getVehicleEngineState(currentVehicle) then
					dxDrawRectangle(x + 27, y + 75, 308, 3, btnBcg)
					if width >= 0 then
						dxDrawRectangle(x + 88.6, y + 75, 247 * width, 3)
					else
						dxDrawRectangle(x + 88.6, y + 75, 61.6 * width, 3, guiDatas.greenColor)
					end
				end
				totalChargeMinus = totalChargeMinus + (width / 1000)
				if getPedOccupiedVehicleSeat(localPlayer) == 0 and getTickCount() - lastElectricSave > 5000 and getVehicleEngineState(currentVehicle) then
					lastElectricSave = getTickCount()
					triggerServerEvent("setElectricDatas", localPlayer, totalChargeMinus)
					totalChargeMinus = 0
				end
			end

			dxDrawText("KM/H", 0, 0, x + 235.5, y + 67, -1, guiDatas.miniFontScale, guiDatas.miniFont, "right", "bottom")
			if cruiseSpeed then
				if cruiseDistance then
					dxDrawText("AP", x + 195, 0, x + 233, y + 41, guiDatas.blueColor, guiDatas.nameFontScale * 0.7, guiDatas.nameFont, "center", "bottom")
				else
					dxDrawText("CRUISE", x + 195, 0, x + 233, y + 41, guiDatas.blueColor, guiDatas.nameFontScale * 0.7, guiDatas.nameFont, "center", "bottom")
				end
				dxDrawText(math.floor(cruiseSpeed), x + 195, 0, x + 233, y + 26, guiDatas.blueColor, guiDatas.nameFontScale, guiDatas.nameFont, "center", "bottom")
			end

			local speed = string.format("%03d", getVehicleSpeed(currentVehicle, "KMH"))
			local color1 = (speed:sub(1,1) ~= "0" or tonumber(speed) >= 100) and tocolor(255, 255, 255, 255) or tocolor(35, 39, 42, 103)
			local color2 = (speed:sub(2,2) ~= "0" or tonumber(speed) >= 10) and tocolor(255, 255, 255, 255) or tocolor(35, 39, 42, 103)
			local color3 = (speed:sub(3,3) ~= "0" or tonumber(speed) >= 1) and tocolor(255, 255, 255, 255) or tocolor(35, 39, 42, 103)
			
			dxDrawText(speed:sub(1,1), x + 274, y + 79, x + 274, y + 79, color1, guiDatas.bigFontScale, guiDatas.bigFont, "right", "bottom")
			dxDrawText(speed:sub(2,2), x + 304.5, y + 79, x + 304.5, y + 79, color2, guiDatas.bigFontScale, guiDatas.bigFont, "right", "bottom")
			dxDrawText(speed:sub(3,3), x + 335, y + 79, x + 335, y + 79, color3, guiDatas.bigFontScale, guiDatas.bigFont, "right", "bottom")
			if handBrakeMode and cy or 0 < handBrakeLevel then
				local x, y = x + 318, y - 130
				local level = handBrakeLevel
				local tmp = math.floor(level / 0.3)
				if handbrakeSound ~= tmp then
					if tmp > handbrakeSound and currentVehicleShifter then
						local sound = playSound("files/hb.mp3")
						setSoundVolume(sound, 0.175)
					end
					handbrakeSound = tmp
				end
				local tmp = 3 <= handbrakeSound
				sightlangStaticImageUsed[16] = true
				if sightlangStaticImageToc[16] then
					processSightlangStaticImage[16]()
				end
				dxDrawImage(x, y, 28, 67, sightlangStaticImage[16], 0, 0, 0, guiDatas.redColor)
				sightlangStaticImageUsed[17] = true
				if sightlangStaticImageToc[17] then
					processSightlangStaticImage[17]()
				end
				dxDrawImage(x, y, 28, 67, sightlangStaticImage[17], 0, 0, 0, guiDatas.speedoColor)
				sightlangStaticImageUsed[18] = true
				if sightlangStaticImageToc[18] then
					processSightlangStaticImage[18]()
				end
				dxDrawImage(x, y + math.floor(61 * level), 28, 67, sightlangStaticImage[18], 0, 0, 0, guiDatas.speedoColor)
			end

		elseif speedoType == "analog" then
			local size = analogSize
			local x = analogPos[1]
			local y = analogPos[2]
			local pulse = ticks % 100 / 100
			local topSpeedProgress = math.min(1, math.max(0, speed - (8 * analogDivision - analogDivision / 2)) / (analogDivision / 2))
			local bTime = signalLength[currentVehicle] or blinkTime
			if signalState[currentVehicle] == "emergency2" then
				pulse = 1 - (ticks - signalTick[currentVehicle]) % bTime / bTime
				sightlangStaticImageUsed[2] = true
				if sightlangStaticImageToc[2] then
					processSightlangStaticImage[2]()
				end
				dxDrawImage(x, y, size, size, sightlangStaticImage[2], 0, 0, 0, bitReplace(guiDatas.orangeColor, pulse * 225, 24, 8))
			elseif signalState[currentVehicle] == "emergency" and currentEmergencyColor then
				pulse = 1 - (ticks - signalTick[currentVehicle]) % bTime / bTime
				sightlangStaticImageUsed[2] = true
				if sightlangStaticImageToc[2] then
					processSightlangStaticImage[2]()
				end
				dxDrawImage(x, y, size, size, sightlangStaticImage[2], 0, 0, 0, bitReplace(currentEmergencyColor, pulse * 225, 24, 8))
			elseif 0 < topSpeedProgress then
				sightlangStaticImageUsed[2] = true
				if sightlangStaticImageToc[2] then
					processSightlangStaticImage[2]()
				end
				dxDrawImage(x, y, size, size, sightlangStaticImage[2], 0, 0, 0, bitReplace(guiDatas.redColor, topSpeedProgress * 100, 24, 8))
			elseif getVehicleSirensOn(currentVehicle) then
				pulse = ticks % (bTime * 2) / bTime
				local color = guiDatas.blueColor
				if 1 < pulse then
					pulse = pulse - 1
					color = guiDatas.redColor
				end
				sightlangStaticImageUsed[2] = true
				if sightlangStaticImageToc[2] then
					processSightlangStaticImage[2]()
				end
				dxDrawImage(x, y, size, size, sightlangStaticImage[2], 0, 0, 0, bitReplace(color, 50 + pulse * 150, 24, 8))
			elseif engine then
				if nosState then
					sightlangStaticImageUsed[2] = true
					if sightlangStaticImageToc[2] then
						processSightlangStaticImage[2]()
					end
					dxDrawImage(x, y, size, size, sightlangStaticImage[2], 0, 0, 0, bitReplace(guiDatas.blueColor, 50 + pulse * 150, 24, 8))
				elseif engineLightLevel == 2 then
					sightlangStaticImageUsed[2] = true
					if sightlangStaticImageToc[2] then
						processSightlangStaticImage[2]()
					end
					dxDrawImage(x, y, size, size, sightlangStaticImage[2], 0, 0, 0, bitReplace(guiDatas.redColor, 100, 24, 8))
				elseif engineLightLevel == 1 then
					sightlangStaticImageUsed[2] = true
					if sightlangStaticImageToc[2] then
						processSightlangStaticImage[2]()
					end
					dxDrawImage(x, y, size, size, sightlangStaticImage[2], 0, 0, 0, bitReplace(guiDatas.yellowColor, 100, 24, 8))
				end
			end
			sightlangStaticImageUsed[3] = true
			if sightlangStaticImageToc[3] then
				processSightlangStaticImage[3]()
			end
			dxDrawImage(x, y, size, size, sightlangStaticImage[3], 0, 0, 0, guiDatas.speedoColor)
			sightlangStaticImageUsed[4] = true
			if sightlangStaticImageToc[4] then
				processSightlangStaticImage[4]()
			end
			dxDrawImage(x, y, size, size, sightlangStaticImage[4], 0, 0, 0, guiDatas.redColor)
			local deg = math.min(analogDivision * 10, speed) / (10 * analogDivision) * 250
			local deg2 = math.min(200, deg)
			local deg3 = deg - deg2
			if 0 < deg3 then
				for k = deg2, deg, 8 do
					sightlangStaticImageUsed[5] = true
					if sightlangStaticImageToc[5] then
						processSightlangStaticImage[5]()
					end
					dxDrawImage(x, y, size, size, sightlangStaticImage[5], k, 0, 0, guiDatas.redColor)
				end
				sightlangStaticImageUsed[5] = true
				if sightlangStaticImageToc[5] then
					processSightlangStaticImage[5]()
				end
				dxDrawImage(x, y, size, size, sightlangStaticImage[5], deg, 0, 0, guiDatas.redColor)
			end
			local indicatorColor = guiDatas.speedoColor
			if cruiseSpeed then
				local d = math.min(1, math.abs(cruiseSpeed - currentSpeed) / 15)
				if d < 0.15 then
					indicatorColor = guiDatas.yellowColor
				else
					d = (d - 0.15) / 0.85
					indicatorColor = bitReplace(indicatorColor, bitExtract(indicatorColor, 0, 8) * d + bitExtract(guiDatas.yellowColor, 0, 8) * (1 - d), 0, 8)
					indicatorColor = bitReplace(indicatorColor, bitExtract(indicatorColor, 8, 8) * d + bitExtract(guiDatas.yellowColor, 8, 8) * (1 - d), 8, 8)
					indicatorColor = bitReplace(indicatorColor, bitExtract(indicatorColor, 16, 8) * d + bitExtract(guiDatas.yellowColor, 16, 8) * (1 - d), 16, 8)
				end
			end
			for k = 0, deg2, 8 do
				sightlangStaticImageUsed[5] = true
				if sightlangStaticImageToc[5] then
					processSightlangStaticImage[5]()
				end
				dxDrawImage(x, y, size, size, sightlangStaticImage[5], k, 0, 0, indicatorColor)
			end
			sightlangStaticImageUsed[5] = true
			if sightlangStaticImageToc[5] then
				processSightlangStaticImage[5]()
			end
			dxDrawImage(x, y, size, size, sightlangStaticImage[5], deg2, 0, 0, indicatorColor)
			sightlangStaticImageUsed[5] = true
			if sightlangStaticImageToc[5] then
				processSightlangStaticImage[5]()
			end
			dxDrawImage(x, y, size, size, sightlangStaticImage[5], 0, 0, 0, indicatorColor)
			sightlangStaticImageUsed[6] = true
			if sightlangStaticImageToc[6] then
				processSightlangStaticImage[6]()
			end
			dxDrawImage(x, y, size, size, sightlangStaticImage[6], deg, 0, 0, 0 < deg3 and guiDatas.redColor or indicatorColor)
			if setCruiseSpeed then
				if 5 <= math.abs(cruiseSpeed - setCruiseSpeed) then
					local deg = (unit == "MPH" and setCruiseSpeed * 0.6472222222222223 or setCruiseSpeed) / (10 * analogDivision) * 250 + 10
					local x, y = x + size / 2, y + size / 2
					local rad = math.rad(deg + 180)
					local cos, sin = math.cos(rad), math.sin(rad)
					local s = size * 0.35
					x = x + cos * s + sin * s
					y = y + sin * s - cos * s
					dxDrawImage(x - 16, y - 16, 32, 32, ":sGui/" .. guiDatas.cruiseIcon2 .. faTicks[guiDatas.cruiseIcon2], deg + 180 + 45, 0, 0, guiDatas.yellowColor)
				end
				local deg = (unit == "MPH" and setCruiseSpeed * 0.6472222222222223 or cruiseSpeed) / (10 * analogDivision) * 250 + 10
				local x, y = x + size / 2, y + size / 2
				local rad = math.rad(deg + 180)
				local cos, sin = math.cos(rad), math.sin(rad)
				local s = size * 0.35
				x = x + cos * s + sin * s
				y = y + sin * s - cos * s
				dxDrawImage(x - 16, y - 16, 32, 32, ":sGui/" .. guiDatas.cruiseIcon .. faTicks[guiDatas.cruiseIcon], deg + 180 + 45, 0, 0, guiDatas.yellowColor)
			end
			for k = 0, 10 do
				local ix = x + size / 2 + math.cos(math.rad(-215 + k * 25)) * size * 0.33
				local iy = y + size / 2 + math.sin(math.rad(-215 + k * 25)) * size * 0.33
				if k == 5 then
					dxDrawText(unit, ix, iy + guiDatas.miniFontH * 1, ix, iy + guiDatas.miniFontH * 1, bitReplace(guiDatas.speedoColor, 174, 24, 8), guiDatas.miniFontScale * 0.8, guiDatas.miniFont, "center", "center")
					local tmpUnitHover = false
					if cx then
						local w = dxGetTextWidth(unit, guiDatas.miniFontScale * 0.8, guiDatas.miniFont) / 2
						tmpUnitHover = cx >= ix - w and cx <= ix + w and cy >= iy + guiDatas.miniFontH - guiDatas.miniFontH * 0.5 and cy <= iy + guiDatas.miniFontH + guiDatas.miniFontH * 0.5
					end
					if unitHoverState ~= tmpUnitHover then
						unitHoverState = tmpUnitHover
						sightexports.sGui:setCursorType((speedoHoverState or unitHoverState or fuelHoverState) and "link" or "normal")
					end
					if engine then
						if setCruiseSpeed then
							if cruiseDistance then
								local col = cruiseCritical and ticks % 250 > 155 and guiDatas.redColor or guiDatas.yellowColor
								local x = ix - 51
								dxDrawImage(x, iy + guiDatas.miniFontH * 2 - 16, 32, 32, ":sGui/" .. guiDatas.cruiseCarIcon .. faTicks[guiDatas.cruiseCarIcon], 0, 0, 0, col)
								x = x + 32 + 3
								local icon = guiDatas.cruiseDistanceIcons[cruiseDistance]
								dxDrawImage(x, iy + guiDatas.miniFontH * 2 - 16, 32, 32, ":sGui/" .. icon .. faTicks[icon], 0, 0, 0, col)
								x = x + 32 + 3
								local icon = cruiseVeh and guiDatas.cruiseCarIcon or guiDatas.cruiseCarIcon2
								dxDrawImage(x, iy + guiDatas.miniFontH * 2 - 16, 32, 32, ":sGui/" .. icon .. faTicks[icon], 0, 0, 0, col)
							else
								dxDrawImage(ix - 32 - 3, iy + guiDatas.miniFontH * 2 - 16, 32, 32, ":sGui/" .. guiDatas.cruiseCarIcon .. faTicks[guiDatas.cruiseCarIcon], 0, 0, 0, guiDatas.yellowColor)
								dxDrawText("* CC *", ix + 3, iy + guiDatas.miniFontH * 2, ix + 3 + 32, iy + guiDatas.miniFontH * 2, guiDatas.yellowColor, guiDatas.miniFontScale * 0.8, guiDatas.miniFont, "center", "center")
							end
						elseif engineLightLevel == 2 then
							local pulse = ticks % 2000 / 1000
							if 1 < pulse then
								pulse = 2 - pulse
							end
							pulse = getEasingValue(pulse, "InOutQuad")
							dxDrawText("* CHECK ENGINE *", ix, iy + guiDatas.miniFontH * 2, ix, iy + guiDatas.miniFontH * 2, bitReplace(guiDatas.redColor, 255 * pulse, 24, 8), guiDatas.miniFontScale * 0.8, guiDatas.miniFont, "center", "center")
						elseif engineLightLevel == 1 then
							local pulse = ticks % 2000 / 1000
							if 1 < pulse then
								pulse = 2 - pulse
							end
							pulse = getEasingValue(pulse, "InOutQuad")
							dxDrawText("* CHECK ENGINE *", ix, iy + guiDatas.miniFontH * 2, ix, iy + guiDatas.miniFontH * 2, bitReplace(guiDatas.yellowColor, 255 * pulse, 24, 8), guiDatas.miniFontScale * 0.8, guiDatas.miniFont, "center", "center")
						elseif oilLevel < 0 then
							local pulse = ticks % 2000 / 1000
							if 1 < pulse then
								pulse = 2 - pulse
							end
							pulse = getEasingValue(pulse, "InOutQuad")
							dxDrawText("* OIL CHANGE NEEDED *", ix, iy + guiDatas.miniFontH * 2, ix, iy + guiDatas.miniFontH * 2, bitReplace(guiDatas.redColor, 255 * pulse, 24, 8), guiDatas.miniFontScale * 0.8, guiDatas.miniFont, "center", "center")
						elseif oilLevel < 100 then
							local pulse = ticks % 2000 / 1000
							if 1 < pulse then
								pulse = 2 - pulse
							end
							pulse = getEasingValue(pulse, "InOutQuad")
							dxDrawText("* OIL CHANGE IN " .. math.ceil(oilLevel * (unit == "KM/H" and 1 or 0.621371192)) .. " " .. (unit == "KM/H" and "KM" or "MLS") .. " *", ix, iy + guiDatas.miniFontH * 2, ix, iy + guiDatas.miniFontH * 2, bitReplace(guiDatas.yellowColor, 255 * pulse, 24, 8), guiDatas.miniFontScale * 0.8, guiDatas.miniFont, "center", "center")
						end
					elseif ignition then
						dxDrawText("* IGNITION ON *", ix, iy + guiDatas.miniFontH * 2, ix, iy + guiDatas.miniFontH * 2, guiDatas.yellowColor, guiDatas.miniFontScale * 0.8, guiDatas.miniFont, "center", "center")
					end
				end
				local progress = math.min(1, math.max(0, speed - (k * analogDivision - analogDivision / 2)) / (analogDivision / 2))
				if 7 < k and speed >= k * analogDivision then
					dxDrawText(k * analogDivision, ix, iy, ix, iy, guiDatas.redColor, guiDatas.miniFontScale, guiDatas.miniFont, "center", "center")
				elseif 7 < k and speed >= k * analogDivision - analogDivision / 2 then
					dxDrawText(k * analogDivision, ix, iy, ix, iy, bitReplace(guiDatas.speedoColor, 53 * (1 - progress), 24, 8), guiDatas.miniFontScale, guiDatas.miniFont, "center", "center")
					dxDrawText(k * analogDivision, ix, iy, ix, iy, bitReplace(guiDatas.redColor, 53 + 202 * progress, 24, 8), guiDatas.miniFontScale, guiDatas.miniFont, "center", "center")
				else
					dxDrawText(k * analogDivision, ix, iy, ix, iy, bitReplace(guiDatas.speedoColor, 53 + 202 * progress, 24, 8), guiDatas.miniFontScale, guiDatas.miniFont, "center", "center")
				end
			end
			sightlangStaticImageUsed[7] = true
			if sightlangStaticImageToc[7] then
				processSightlangStaticImage[7]()
			end
			dxDrawImage(x, y, size, size, sightlangStaticImage[7], 0, 0, 0, tocolor(0, 0, 0))
			x = x + size / 2 + guiDatas.bigWidth * 2
			y = y + size / 2
			local alpha = 53
			for k = 3, 1, -1 do
				local div = math.pow(10, k - 1)
				local num = math.floor(speed / div)
				speed = speed - num * div
				if 0 < num then
					alpha = 255
				end
				if topSpeedProgress <= 0 then
					dxDrawText(num, x - guiDatas.bigWidth * (k - 1), analogPos[2], x - guiDatas.bigWidth * k, analogPos[2] + size * 0.96, bitReplace(guiDatas.speedoColor, alpha, 24, 8), guiDatas.bigFontScale, guiDatas.bigFont, "center", "center")
				elseif 1 <= topSpeedProgress then
					dxDrawText(num, x - guiDatas.bigWidth * (k - 1), analogPos[2], x - guiDatas.bigWidth * k, analogPos[2] + size * 0.96, guiDatas.redColor, guiDatas.bigFontScale, guiDatas.bigFont, "center", "center")
				else
					dxDrawText(num, x - guiDatas.bigWidth * (k - 1), analogPos[2], x - guiDatas.bigWidth * k, analogPos[2] + size * 0.96, bitReplace(guiDatas.speedoColor, 255 * (1 - topSpeedProgress), 24, 8), guiDatas.bigFontScale, guiDatas.bigFont, "center", "center")
					dxDrawText(num, x - guiDatas.bigWidth * (k - 1), analogPos[2], x - guiDatas.bigWidth * k, analogPos[2] + size * 0.96, bitReplace(guiDatas.redColor, 255 * topSpeedProgress, 24, 8), guiDatas.bigFontScale, guiDatas.bigFont, "center", "center")
				end
			end
			x = x - guiDatas.bigWidth * 4
			y = analogPos[2] + size * 0.48 - guiDatas.midFontH / 2 + (guiDatas.bigFontH - guiDatas.midFontH) / 4 - 5
			dxDrawImage(x + guiDatas.bigWidth * 0.6 - 12, y - 15, 16, 16, "files/analog/led.dds", 0, 0, 0, guiDatas.brightSpeedoColor)
			if ignition and (ticks - currentGearChange < 300 or calibrationStart) then
				local progress = 1 - (ticks - currentGearChange) / 300
				if calibrationStart then
					progress = calibrationProgress
				end
				if 0 < progress then
					dxDrawImage(x + guiDatas.bigWidth * 0.6 - 12, y - 15, 16, 16, "files/analog/ledon.dds", 0, 0, 0, bitReplace(guiDatas.redColor, 255 * progress, 24, 8))
				end
			end
			if currentVehicleShifter then
				local gearNum = currentGear
				if calibrationStart then
					gearNum = math.floor(calibrationProgress * 1 + 0.5)
				end
				local gx = 0
				local gearText = "N"
				if gearNum == -1 then
					gearText = "R"
				elseif 0 < gearNum then
					gearText = "D"
				end
				dxDrawRectangle(x - gx, y + 5, gx + guiDatas.bigWidth * 0.6, guiDatas.midFontH, gearNum ~= 0 and guiDatas.yellowColor or bitReplace(guiDatas.yellowColor, 80, 24, 8))
				dxDrawText(gearText, x - gx, y + 5, x + guiDatas.bigWidth * 0.6, 0, tocolor(0, 0, 0, gearNum ~= 0 and 255 or 53), guiDatas.midFontScale, guiDatas.midFont, "center", "top")
			else
				local gearNum = currentGear
				local gx = 0
				if calibrationStart then
					gearNum = math.floor(calibrationProgress * 5 + 0.5)
				end
				local gearText = "N"
				if 0 < gearNum then
					gearText = gearNum
				elseif gearNum == 0 and getVehicleEngineState(currentVehicle) then
					gearText = "R"
				end
				dxDrawRectangle(x - gx, y + 5, gx + guiDatas.bigWidth * 0.6, guiDatas.midFontH, getVehicleEngineState(currentVehicle) and guiDatas.yellowColor or bitReplace(guiDatas.yellowColor, 80, 24, 8))
				dxDrawText(gearText, x - gx, y + 5, x + guiDatas.bigWidth * 0.6, 0, tocolor(0, 0, 0, getVehicleEngineState(currentVehicle) and 255 or 53), guiDatas.midFontScale, guiDatas.midFont, "center", "top")
			end
			local icons = 4
			x = analogPos[1] + size / 2 - guiDatas.bigWidth * (icons / 2)
			y = analogPos[2] + size * 0.78 - iconSizes * 2.05
			if ignition and calibrationStart then
				sightlangStaticImageUsed[8] = true
				if sightlangStaticImageToc[8] then
					processSightlangStaticImage[8]()
				end
				dxDrawImage(math.floor(x + guiDatas.bigWidth / 2 - 12), math.floor(y + 12 - 9), 24, 18, sightlangStaticImage[8], 0, 0, 0, 500 < ticks % 1000 and guiDatas.redColor or guiDatas.yellowColor)
				x = x + guiDatas.bigWidth
				if absLevel then
					if ticks % 1000 > 666.6666666666666 then
						sightlangStaticImageUsed[9] = true
						if sightlangStaticImageToc[9] then
							processSightlangStaticImage[9]()
						end
						dxDrawImage(math.floor(x + guiDatas.bigWidth / 2 - 12), math.floor(y + 12 - 9), 24, 18, sightlangStaticImage[9], 0, 0, 0, guiDatas.greenColor)
					elseif ticks % 1000 > 333.3333333333333 then
						sightlangStaticImageUsed[10] = true
						if sightlangStaticImageToc[10] then
							processSightlangStaticImage[10]()
						end
						dxDrawImage(math.floor(x + guiDatas.bigWidth / 2 - 12), math.floor(y + 12 - 9), 24, 18, sightlangStaticImage[10], 0, 0, 0, guiDatas.redColor)
					else
						sightlangStaticImageUsed[11] = true
						if sightlangStaticImageToc[11] then
							processSightlangStaticImage[11]()
						end
						dxDrawImage(math.floor(x + guiDatas.bigWidth / 2 - 12), math.floor(y + 12 - 9), 24, 18, sightlangStaticImage[11], 0, 0, 0, guiDatas.redColor)
					end
					x = x + guiDatas.bigWidth
				else
					if 500 < ticks % 1000 then
						sightlangStaticImageUsed[9] = true
						if sightlangStaticImageToc[9] then
							processSightlangStaticImage[9]()
						end
						dxDrawImage(math.floor(x + guiDatas.bigWidth / 2 - 12), math.floor(y + 12 - 9), 24, 18, sightlangStaticImage[9], 0, 0, 0, guiDatas.greenColor)
					else
						sightlangStaticImageUsed[11] = true
						if sightlangStaticImageToc[11] then
							processSightlangStaticImage[11]()
						end
						dxDrawImage(math.floor(x + guiDatas.bigWidth / 2 - 12), math.floor(y + 12 - 9), 24, 18, sightlangStaticImage[11], 0, 0, 0, guiDatas.redColor)
					end
					x = x + guiDatas.bigWidth
				end
				sightlangStaticImageUsed[12] = true
				if sightlangStaticImageToc[12] then
					processSightlangStaticImage[12]()
				end
				dxDrawImage(math.floor(x + guiDatas.bigWidth / 2 - 12), math.floor(y + 12 - 9), 24, 18, sightlangStaticImage[12], 0, 0, 0, 500 < ticks % 1000 and guiDatas.redColor or guiDatas.yellowColor)
				x = x + guiDatas.bigWidth
				sightlangStaticImageUsed[1] = true
				if sightlangStaticImageToc[1] then
					processSightlangStaticImage[1]()
				end
				dxDrawImage(math.floor(x + guiDatas.bigWidth / 2 - 12), math.floor(y + 12 - 9), 24, 18, sightlangStaticImage[1], 0, 0, 0, guiDatas.redColor)
			elseif ignition then
				if batteryCharge < starterValue * 2 then
					sightlangStaticImageUsed[8] = true
					if sightlangStaticImageToc[8] then
						processSightlangStaticImage[8]()
					end
					dxDrawImage(math.floor(x + guiDatas.bigWidth / 2 - 12), math.floor(y + 12 - 9), 24, 18, sightlangStaticImage[8], 0, 0, 0, guiDatas.redColor)
				elseif batteryCharge < starterValue * 6 then
					sightlangStaticImageUsed[8] = true
					if sightlangStaticImageToc[8] then
						processSightlangStaticImage[8]()
					end
					dxDrawImage(math.floor(x + guiDatas.bigWidth / 2 - 12), math.floor(y + 12 - 9), 24, 18, sightlangStaticImage[8], 0, 0, 0, guiDatas.yellowColor)
				else
					sightlangStaticImageUsed[8] = true
					if sightlangStaticImageToc[8] then
						processSightlangStaticImage[8]()
					end
					dxDrawImage(math.floor(x + guiDatas.bigWidth / 2 - 12), math.floor(y + 12 - 9), 24, 18, sightlangStaticImage[8], 0, 0, 0, guiDatas.brightSpeedoColor)
				end
				x = x + guiDatas.bigWidth
				if 750 <= autoHold then
					sightlangStaticImageUsed[9] = true
					if sightlangStaticImageToc[9] then
						processSightlangStaticImage[9]()
					end
					dxDrawImage(math.floor(x + guiDatas.bigWidth / 2 - 12), math.floor(y + 12 - 9), 24, 18, sightlangStaticImage[9], 0, 0, 0, guiDatas.greenColor)
				elseif absState then
					sightlangStaticImageUsed[10] = true
					if sightlangStaticImageToc[10] then
						processSightlangStaticImage[10]()
					end
					dxDrawImage(math.floor(x + guiDatas.bigWidth / 2 - 12), math.floor(y + 12 - 9), 24, 18, sightlangStaticImage[10], 0, 0, 0, guiDatas.redColor)
				elseif 0.5 <= handBrakeLevel then
					sightlangStaticImageUsed[11] = true
					if sightlangStaticImageToc[11] then
						processSightlangStaticImage[11]()
					end
					dxDrawImage(math.floor(x + guiDatas.bigWidth / 2 - 12), math.floor(y + 12 - 9), 24, 18, sightlangStaticImage[11], 0, 0, 0, guiDatas.redColor)
				else
					sightlangStaticImageUsed[11] = true
					if sightlangStaticImageToc[11] then
						processSightlangStaticImage[11]()
					end
					dxDrawImage(math.floor(x + guiDatas.bigWidth / 2 - 12), math.floor(y + 12 - 9), 24, 18, sightlangStaticImage[11], 0, 0, 0, guiDatas.brightSpeedoColor)
				end
				x = x + guiDatas.bigWidth
				if oilLevel < 0 then
					sightlangStaticImageUsed[12] = true
					if sightlangStaticImageToc[12] then
						processSightlangStaticImage[12]()
					end
					dxDrawImage(math.floor(x + guiDatas.bigWidth / 2 - 12), math.floor(y + 12 - 9), 24, 18, sightlangStaticImage[12], 0, 0, 0, guiDatas.redColor)
				elseif oilLevel < 100 then
					sightlangStaticImageUsed[12] = true
					if sightlangStaticImageToc[12] then
						processSightlangStaticImage[12]()
					end
					dxDrawImage(math.floor(x + guiDatas.bigWidth / 2 - 12), math.floor(y + 12 - 9), 24, 18, sightlangStaticImage[12], 0, 0, 0, guiDatas.yellowColor)
				else
					sightlangStaticImageUsed[12] = true
					if sightlangStaticImageToc[12] then
						processSightlangStaticImage[12]()
					end
					dxDrawImage(math.floor(x + guiDatas.bigWidth / 2 - 12), math.floor(y + 12 - 9), 24, 18, sightlangStaticImage[12], 0, 0, 0, guiDatas.brightSpeedoColor)
				end
				x = x + guiDatas.bigWidth
				sightlangStaticImageUsed[1] = true
				if sightlangStaticImageToc[1] then
					processSightlangStaticImage[1]()
				end
				dxDrawImage(math.floor(x + guiDatas.bigWidth / 2 - 12), math.floor(y + 12 - 9), 24, 18, sightlangStaticImage[1], 0, 0, 0, guiDatas.brightSpeedoColor)
				if not seatBeltState and not isBike(getPedOccupiedVehicle(localPlayer)) and not isBoat(getPedOccupiedVehicle(localPlayer)) then
					local beltColor = guiDatas.brightSpeedoColor
					local p = 0
					if isElement(seatBeltSound) then
						p = getSoundPosition(seatBeltSound) / getSoundLength(seatBeltSound)
					else
						p = ticks % 2000 / 2000
					end
					p = getEasingValue(1 - p, "OutQuad")
					sightlangStaticImageUsed[1] = true
					if sightlangStaticImageToc[1] then
						processSightlangStaticImage[1]()
					end
					dxDrawImage(math.floor(x + guiDatas.bigWidth / 2 - 12), math.floor(y + 12 - 9), 24, 18, sightlangStaticImage[1], 0, 0, 0, bitReplace(guiDatas.redColor, 255 * p, 24, 8))
				end
			else
				if batteryCharge < starterValue * 2 then
					sightlangStaticImageUsed[8] = true
					if sightlangStaticImageToc[8] then
						processSightlangStaticImage[8]()
					end
					dxDrawImage(math.floor(x + guiDatas.bigWidth / 2 - 12), math.floor(y + 12 - 9), 24, 18, sightlangStaticImage[8], 0, 0, 0, guiDatas.redColor)
				elseif batteryCharge < starterValue * 6 then
					sightlangStaticImageUsed[8] = true
					if sightlangStaticImageToc[8] then
						processSightlangStaticImage[8]()
					end
					dxDrawImage(math.floor(x + guiDatas.bigWidth / 2 - 12), math.floor(y + 12 - 9), 24, 18, sightlangStaticImage[8], 0, 0, 0, guiDatas.yellowColor)
				else
					sightlangStaticImageUsed[8] = true
					if sightlangStaticImageToc[8] then
						processSightlangStaticImage[8]()
					end
					dxDrawImage(math.floor(x + guiDatas.bigWidth / 2 - 12), math.floor(y + 12 - 9), 24, 18, sightlangStaticImage[8], 0, 0, 0, guiDatas.brightSpeedoColor)
				end
				x = x + guiDatas.bigWidth
				sightlangStaticImageUsed[11] = true
				if sightlangStaticImageToc[11] then
					processSightlangStaticImage[11]()
				end
				dxDrawImage(math.floor(x + guiDatas.bigWidth / 2 - 12), math.floor(y + 12 - 9), 24, 18, sightlangStaticImage[11], 0, 0, 0, guiDatas.brightSpeedoColor)
				x = x + guiDatas.bigWidth
				sightlangStaticImageUsed[12] = true
				if sightlangStaticImageToc[12] then
					processSightlangStaticImage[12]()
				end
				dxDrawImage(math.floor(x + guiDatas.bigWidth / 2 - 12), math.floor(y + 12 - 9), 24, 18, sightlangStaticImage[12], 0, 0, 0, guiDatas.brightSpeedoColor)
				x = x + guiDatas.bigWidth
				sightlangStaticImageUsed[1] = true
				if sightlangStaticImageToc[1] then
					processSightlangStaticImage[1]()
				end
				dxDrawImage(math.floor(x + guiDatas.bigWidth / 2 - 12), math.floor(y + 12 - 9), 24, 18, sightlangStaticImage[1], 0, 0, 0, guiDatas.brightSpeedoColor)
			end
			x = analogPos[1] + size / 2 - iconSizes / 2 + ((engine and 1 <= engineLightLevel or ignition and calibrationStart) and iconSizes * 1.25 or iconSizes * 1.25 / 2)
			y = analogPos[2] + size * 0.78 - iconSizes * 1
			local turnColor = (signalState[currentVehicle] == "right" or signalState[currentVehicle] == "both") and signalStage[currentVehicle] and guiDatas.greenColor or guiDatas.brightSpeedoColor
			if signalState[currentVehicle] == "emergency" and signalStage[currentVehicle] and currentEmergencyColor then
				turnColor = currentEmergencyColor
			end
			if ignition and calibrationStart then
				turnColor = 500 < ticks % 1000 and guiDatas.greenColor or guiDatas.speedoColor
			end
			sightlangStaticImageUsed[13] = true
			if sightlangStaticImageToc[13] then
				processSightlangStaticImage[13]()
			end
			dxDrawImage(x, y, iconSizes, iconSizes, sightlangStaticImage[13], 0, 0, 0, turnColor)
			if ignition and calibrationStart then
				x = x - iconSizes * 1.25
				sightlangStaticImageUsed[14] = true
				if sightlangStaticImageToc[14] then
					processSightlangStaticImage[14]()
				end
				dxDrawImage(x, y, iconSizes, iconSizes, sightlangStaticImage[14], 0, 0, 0, 500 < ticks % 1000 and guiDatas.yellowColor or guiDatas.redColor)
			elseif engine then
				if engineLightLevel == 2 then
					x = x - iconSizes * 1.25
					local pulse = ticks % 2000 / 1000
					if 1 < pulse then
						pulse = 2 - pulse
					end
					pulse = getEasingValue(pulse, "InOutQuad")
					sightlangStaticImageUsed[14] = true
					if sightlangStaticImageToc[14] then
						processSightlangStaticImage[14]()
					end
					dxDrawImage(x, y, iconSizes, iconSizes, sightlangStaticImage[14], 0, 0, 0, bitReplace(guiDatas.speedoColor, 53 - 53 * pulse, 24, 8))
					sightlangStaticImageUsed[14] = true
					if sightlangStaticImageToc[14] then
						processSightlangStaticImage[14]()
					end
					dxDrawImage(x, y, iconSizes, iconSizes, sightlangStaticImage[14], 0, 0, 0, bitReplace(guiDatas.redColor, 255 * pulse, 24, 8))
				elseif engineLightLevel == 1 then
					x = x - iconSizes * 1.25
					local pulse = ticks % 2000 / 1000
					if 1 < pulse then
						pulse = 2 - pulse
					end
					pulse = getEasingValue(pulse, "InOutQuad")
					sightlangStaticImageUsed[14] = true
					if sightlangStaticImageToc[14] then
						processSightlangStaticImage[14]()
					end
					dxDrawImage(x, y, iconSizes, iconSizes, sightlangStaticImage[14], 0, 0, 0, bitReplace(guiDatas.speedoColor, 53 - 53 * pulse, 24, 8))
					sightlangStaticImageUsed[14] = true
					if sightlangStaticImageToc[14] then
						processSightlangStaticImage[14]()
					end
					dxDrawImage(x, y, iconSizes, iconSizes, sightlangStaticImage[14], 0, 0, 0, bitReplace(guiDatas.yellowColor, 255 * pulse, 24, 8))
				end
			end
			x = x - iconSizes * 1.25
			local turnColor = (signalState[currentVehicle] == "left" or signalState[currentVehicle] == "both") and signalStage[currentVehicle] and guiDatas.greenColor or guiDatas.brightSpeedoColor
			if signalState[currentVehicle] == "emergency" and not signalStage[currentVehicle] and currentEmergencyColor then
				turnColor = currentEmergencyColor
			end
			if ignition and calibrationStart then
				turnColor = 500 < ticks % 1000 and guiDatas.greenColor or guiDatas.speedoColor
			end
			sightlangStaticImageUsed[15] = true
			if sightlangStaticImageToc[15] then
				processSightlangStaticImage[15]()
			end
			dxDrawImage(x, y, iconSizes, iconSizes, sightlangStaticImage[15], 0, 0, 0, turnColor)
			if currentMileage > 0 then
				dxDrawText(mileageUnit, analogPos[1], 0, analogPos[1] + size, analogPos[2] + size * 0.84, guiDatas.brightSpeedoColor, guiDatas.nameFontScale * 0.8, guiDatas.nameFont, "center", "bottom")
			end
			x = math.floor(analogPos[1] + size * 0.963) - 28
			y = analogPos[2] - 33
			if handBrakeMode and cy or 0 < handBrakeLevel then
				local level = handBrakeLevel
				local tmp = math.floor(level / 0.3)
				if handbrakeSound ~= tmp then
					if tmp > handbrakeSound and currentVehicleShifter then
						local sound = playSound("files/hb.mp3")
						setSoundVolume(sound, 0.175)
					end
					handbrakeSound = tmp
				end
				local tmp = 3 <= handbrakeSound
				sightlangStaticImageUsed[16] = true
				if sightlangStaticImageToc[16] then
					processSightlangStaticImage[16]()
				end
				dxDrawImage(x, y, 28, 67, sightlangStaticImage[16], 0, 0, 0, guiDatas.redColor)
				sightlangStaticImageUsed[17] = true
				if sightlangStaticImageToc[17] then
					processSightlangStaticImage[17]()
				end
				dxDrawImage(x, y, 28, 67, sightlangStaticImage[17], 0, 0, 0, guiDatas.speedoColor)
				sightlangStaticImageUsed[18] = true
				if sightlangStaticImageToc[18] then
					processSightlangStaticImage[18]()
				end
				dxDrawImage(x, y + math.floor(61 * level), 28, 67, sightlangStaticImage[18], 0, 0, 0, guiDatas.speedoColor)
			elseif ignition and (0 < nosLevel or calibrationStart) then
				local p = nosLevel * afterCalibrationProgress
				if calibrationStart then
					p = calibrationProgress
				end
				p = 1 - p
				local s = 1
				local sa = 255
				if 1 < nosRefill then
					local p = (nosRefill - 1) / 0.05
					sa = 255 * p / 2
					if 1 < p then
						p = 2 - p
					end
					s = 1 + 0.1 * p
				end
				x = x - 18 - 64 * (s - 1) * 0.5
				y = y - 30 - 128 * (s - 1) * 0.5
				sightlangStaticImageUsed[19] = true
				if sightlangStaticImageToc[19] then
					processSightlangStaticImage[19]()
				end
				dxDrawImage(x, y, 64 * s, 128 * s, sightlangStaticImage[19], 0, 0, 0, guiDatas.speedoColor)
				sightlangStaticImageUsed[20] = true
				if sightlangStaticImageToc[20] then
					processSightlangStaticImage[20]()
				end
				dxDrawImage(x, y, 64 * s, 128 * s, sightlangStaticImage[20], 0, 0, 0, guiDatas.brightSpeedoColor)
				local colorshine = false
				local color1 = false
				local color2 = false
				if nosPurple then
					colorshine = tocolor(240, 112, 194, sa)
					color1 = tocolor(228, 112, 184)
					color2 = tocolor(119, 49, 215)
				else
					colorshine = tocolor(100, 185, 250, sa)
					color1 = tocolor(82, 179, 243)
					color2 = tocolor(84, 98, 237)
				end
				local py = 45 * (1 - math.min(1, nosRefill))
				local iy = 53 + 45 * p
				local h = 45 * (1 - p) + 30
				if 0 < py then
					sightlangStaticImageUsed[21] = true
					if sightlangStaticImageToc[21] then
						processSightlangStaticImage[21]()
					end
					dxDrawImageSection(x, y + iy * s, 64 * s, py * s, 0, iy, 64, py, sightlangStaticImage[21], 0, 0, 0, tocolor(255, 255, 255, 125))
					sightlangStaticImageUsed[21] = true
					if sightlangStaticImageToc[21] then
						processSightlangStaticImage[21]()
					end
					dxDrawImageSection(x, y + iy * s, 64 * s, py * s, 0, iy, 64, py, sightlangStaticImage[21], 0, 0, 0, bitReplace(color1, 50, 24, 8))
					sightlangStaticImageUsed[22] = true
					if sightlangStaticImageToc[22] then
						processSightlangStaticImage[22]()
					end
					dxDrawImageSection(x, y + iy * s, 64 * s, py * s, 0, iy, 64, py, sightlangStaticImage[22], 0, 0, 0, bitReplace(color2, 50, 24, 8))
				else
					sightlangStaticImageUsed[23] = true
					if sightlangStaticImageToc[23] then
						processSightlangStaticImage[23]()
					end
					dxDrawImageSection(x, y + iy * s, 64 * s, h * s, 0, iy, 64, h, sightlangStaticImage[23], 0, 0, 0, colorshine)
					sightlangStaticImageUsed[23] = true
					if sightlangStaticImageToc[23] then
						processSightlangStaticImage[23]()
					end
					dxDrawImageSection(x, y + 45 * p * s, 64 * s, 53 * s, 0, 0, 64, 53, sightlangStaticImage[23], 0, 0, 0, colorshine)
				end
				sightlangStaticImageUsed[21] = true
				if sightlangStaticImageToc[21] then
					processSightlangStaticImage[21]()
				end
				dxDrawImageSection(x, y + iy * s + py * s, 64 * s, h * s - py * s, 0, iy + py, 64, h - py, sightlangStaticImage[21], 0, 0, 0, color1)
				sightlangStaticImageUsed[22] = true
				if sightlangStaticImageToc[22] then
					processSightlangStaticImage[22]()
				end
				dxDrawImageSection(x, y + iy * s + py * s, 64 * s, h * s - py * s, 0, iy + py, 64, h - py, sightlangStaticImage[22], 0, 0, 0, color2)
				sightlangStaticImageUsed[20] = true
				if sightlangStaticImageToc[20] then
					processSightlangStaticImage[20]()
				end
				dxDrawImageSection(x, y + iy * s, 64 * s, h * s, 0, iy, 64, h, sightlangStaticImage[20], 0, 0, 0, guiDatas.speedoColor)
			end
			x = analogPos[1] + size * 0.1
			y = analogPos[2] + size * 0.83
			local fuelPos = {
				0,
				0,
				0,
				0
			}
			if ignition then
				local fuel = 0
				if calibrationStart then
					fuel = math.floor(calibrationProgress * fuelMaxLiters + 0.5)
				else
					fuel = math.floor(fuelLiters * afterCalibrationProgress + 0.5)
				end
				text = fuel .. "/" .. fuelMaxLiters .. "L"
				local color = guiDatas.brightSpeedoColor
				if fuel < fuelMaxLiters * 0.1 then
					color = guiDatas.redColor
				end
				if not fuelClosed then
					fuelPos[1] = x - guiDatas.miniFontH - dxGetTextWidth(text, guiDatas.miniFontScale, guiDatas.miniFont)
				else
					fuelPos[1] = x - guiDatas.miniFontH
				end
				fuelPos[2] = x
				fuelPos[3] = y - guiDatas.miniFontH
				fuelPos[4] = y
				dxDrawImage(fuelPos[1], y - guiDatas.miniFontH, guiDatas.miniFontH, guiDatas.miniFontH, ":sGui/" .. guiDatas.fuelIcon .. faTicks[guiDatas.fuelIcon], 0, 0, 0, color)
				if not fuelClosed then
					dxDrawText(text, 0, 0, x, y, color, guiDatas.miniFontScale, guiDatas.miniFont, "right", "bottom")
				end
			end
			if currentVehicleLight then
				sightlangStaticImageUsed[24] = true
				if sightlangStaticImageToc[24] then
					processSightlangStaticImage[24]()
				end
				dxDrawImage(analogPos[1], analogPos[2], size, size, sightlangStaticImage[24], 0, 0, 0, bitReplace(guiDatas.speedoColor, 100, 24, 8))
				sightlangStaticImageUsed[25] = true
				if sightlangStaticImageToc[25] then
					processSightlangStaticImage[25]()
				end
				dxDrawImage(analogPos[1], analogPos[2], size, size, sightlangStaticImage[25], 0, 0, 0, bitReplace(guiDatas.redColor, 100, 24, 8))
			end
			local tmpFuelHover = false
			if cx and not calibrationStart and 1 <= afterCalibrationProgress then
				tmpFuelHover = cx >= fuelPos[1] and cx <= fuelPos[2] and cy >= fuelPos[3] and cy <= fuelPos[4]
			end
			if fuelHoverState ~= tmpFuelHover then
				fuelHoverState = tmpFuelHover
				sightexports.sGui:setCursorType((speedoHoverState or unitHoverState or fuelHoverState) and "link" or "normal")
				if fuelHoverState and fuelClosed then
					local fuel = math.floor(fuelLiters + 0.5)
					text = fuel .. "/" .. fuelMaxLiters .. "L"
					sightexports.sGui:showTooltip(text)
				else
					sightexports.sGui:showTooltip(false)
				end
			end
		end
	end
end

addEvent("hudWidgetState:speedo", true)
addEventHandler("hudWidgetState:speedo", getRootElement(), function(state)
	if widgetState ~= state then
		widgetState = state
		if widgetState then
			addEventHandler("onClientClick", getRootElement(), clickSpeedo)
			addEventHandler("onClientRender", getRootElement(), renderSpeedo)
		else
			removeEventHandler("onClientClick", getRootElement(), clickSpeedo)
			removeEventHandler("onClientRender", getRootElement(), renderSpeedo)
		end
	end
end)
addEvent("hudWidgetPosition:speedo", true)
addEventHandler("hudWidgetPosition:speedo", getRootElement(), function(pos, final)
	widgetPos = pos
	analogPos[1] = math.floor(widgetPos[1] + widgetSize[1] - analogSize * 0.963)
	analogPos[2] = math.floor(widgetPos[2] + widgetSize[2] - analogSize * 0.83)
end)
addEvent("hudWidgetSize:speedo", true)
addEventHandler("hudWidgetSize:speedo", getRootElement(), function(size, final)
	widgetSize = size
	analogSize = math.floor(math.min(widgetSize[1], widgetSize[2]))
	analogPos[1] = math.floor(widgetPos[1] + widgetSize[1] - analogSize * 0.963)
	analogPos[2] = math.floor(widgetPos[2] + widgetSize[2] - analogSize * 0.83)
end)
triggerEvent("requestWidgetDatas", localPlayer, "speedo")
