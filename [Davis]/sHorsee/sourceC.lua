local seexports = {sModloader = false, sGui = false}
local function sightlangProcessExports()
	for k in pairs(seexports) do
		local res = getResourceFromName(k)
		if res and getResourceState(res) == "running" then
			seexports[k] = exports[k]
		else
			seexports[k] = false
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
sightlangStaticImageToc[29] = true
sightlangStaticImageToc[30] = true
sightlangStaticImageToc[31] = true
sightlangStaticImageToc[32] = true
sightlangStaticImageToc[33] = true
sightlangStaticImageToc[34] = true
sightlangStaticImageToc[35] = true
sightlangStaticImageToc[36] = true
sightlangStaticImageToc[37] = true
sightlangStaticImageToc[38] = true
sightlangStaticImageToc[39] = true
sightlangStaticImageToc[40] = true
sightlangStaticImageToc[41] = true
sightlangStaticImageToc[42] = true
sightlangStaticImageToc[43] = true
sightlangStaticImageToc[44] = true
sightlangStaticImageToc[45] = true
sightlangStaticImageToc[46] = true
sightlangStaticImageToc[47] = true
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
	if sightlangStaticImageUsed[29] then
		sightlangStaticImageUsed[29] = false
		sightlangStaticImageDel[29] = false
	elseif sightlangStaticImage[29] then
		if sightlangStaticImageDel[29] then
			if now >= sightlangStaticImageDel[29] then
				if isElement(sightlangStaticImage[29]) then
					destroyElement(sightlangStaticImage[29])
				end
				sightlangStaticImage[29] = nil
				sightlangStaticImageDel[29] = false
				sightlangStaticImageToc[29] = true
				return
			end
		else
			sightlangStaticImageDel[29] = now + 5000
		end
	else
		sightlangStaticImageToc[29] = true
	end
	if sightlangStaticImageUsed[30] then
		sightlangStaticImageUsed[30] = false
		sightlangStaticImageDel[30] = false
	elseif sightlangStaticImage[30] then
		if sightlangStaticImageDel[30] then
			if now >= sightlangStaticImageDel[30] then
				if isElement(sightlangStaticImage[30]) then
					destroyElement(sightlangStaticImage[30])
				end
				sightlangStaticImage[30] = nil
				sightlangStaticImageDel[30] = false
				sightlangStaticImageToc[30] = true
				return
			end
		else
			sightlangStaticImageDel[30] = now + 5000
		end
	else
		sightlangStaticImageToc[30] = true
	end
	if sightlangStaticImageUsed[31] then
		sightlangStaticImageUsed[31] = false
		sightlangStaticImageDel[31] = false
	elseif sightlangStaticImage[31] then
		if sightlangStaticImageDel[31] then
			if now >= sightlangStaticImageDel[31] then
				if isElement(sightlangStaticImage[31]) then
					destroyElement(sightlangStaticImage[31])
				end
				sightlangStaticImage[31] = nil
				sightlangStaticImageDel[31] = false
				sightlangStaticImageToc[31] = true
				return
			end
		else
			sightlangStaticImageDel[31] = now + 5000
		end
	else
		sightlangStaticImageToc[31] = true
	end
	if sightlangStaticImageUsed[32] then
		sightlangStaticImageUsed[32] = false
		sightlangStaticImageDel[32] = false
	elseif sightlangStaticImage[32] then
		if sightlangStaticImageDel[32] then
			if now >= sightlangStaticImageDel[32] then
				if isElement(sightlangStaticImage[32]) then
					destroyElement(sightlangStaticImage[32])
				end
				sightlangStaticImage[32] = nil
				sightlangStaticImageDel[32] = false
				sightlangStaticImageToc[32] = true
				return
			end
		else
			sightlangStaticImageDel[32] = now + 5000
		end
	else
		sightlangStaticImageToc[32] = true
	end
	if sightlangStaticImageUsed[33] then
		sightlangStaticImageUsed[33] = false
		sightlangStaticImageDel[33] = false
	elseif sightlangStaticImage[33] then
		if sightlangStaticImageDel[33] then
			if now >= sightlangStaticImageDel[33] then
				if isElement(sightlangStaticImage[33]) then
					destroyElement(sightlangStaticImage[33])
				end
				sightlangStaticImage[33] = nil
				sightlangStaticImageDel[33] = false
				sightlangStaticImageToc[33] = true
				return
			end
		else
			sightlangStaticImageDel[33] = now + 5000
		end
	else
		sightlangStaticImageToc[33] = true
	end
	if sightlangStaticImageUsed[34] then
		sightlangStaticImageUsed[34] = false
		sightlangStaticImageDel[34] = false
	elseif sightlangStaticImage[34] then
		if sightlangStaticImageDel[34] then
			if now >= sightlangStaticImageDel[34] then
				if isElement(sightlangStaticImage[34]) then
					destroyElement(sightlangStaticImage[34])
				end
				sightlangStaticImage[34] = nil
				sightlangStaticImageDel[34] = false
				sightlangStaticImageToc[34] = true
				return
			end
		else
			sightlangStaticImageDel[34] = now + 5000
		end
	else
		sightlangStaticImageToc[34] = true
	end
	if sightlangStaticImageUsed[35] then
		sightlangStaticImageUsed[35] = false
		sightlangStaticImageDel[35] = false
	elseif sightlangStaticImage[35] then
		if sightlangStaticImageDel[35] then
			if now >= sightlangStaticImageDel[35] then
				if isElement(sightlangStaticImage[35]) then
					destroyElement(sightlangStaticImage[35])
				end
				sightlangStaticImage[35] = nil
				sightlangStaticImageDel[35] = false
				sightlangStaticImageToc[35] = true
				return
			end
		else
			sightlangStaticImageDel[35] = now + 5000
		end
	else
		sightlangStaticImageToc[35] = true
	end
	if sightlangStaticImageUsed[36] then
		sightlangStaticImageUsed[36] = false
		sightlangStaticImageDel[36] = false
	elseif sightlangStaticImage[36] then
		if sightlangStaticImageDel[36] then
			if now >= sightlangStaticImageDel[36] then
				if isElement(sightlangStaticImage[36]) then
					destroyElement(sightlangStaticImage[36])
				end
				sightlangStaticImage[36] = nil
				sightlangStaticImageDel[36] = false
				sightlangStaticImageToc[36] = true
				return
			end
		else
			sightlangStaticImageDel[36] = now + 5000
		end
	else
		sightlangStaticImageToc[36] = true
	end
	if sightlangStaticImageUsed[37] then
		sightlangStaticImageUsed[37] = false
		sightlangStaticImageDel[37] = false
	elseif sightlangStaticImage[37] then
		if sightlangStaticImageDel[37] then
			if now >= sightlangStaticImageDel[37] then
				if isElement(sightlangStaticImage[37]) then
					destroyElement(sightlangStaticImage[37])
				end
				sightlangStaticImage[37] = nil
				sightlangStaticImageDel[37] = false
				sightlangStaticImageToc[37] = true
				return
			end
		else
			sightlangStaticImageDel[37] = now + 5000
		end
	else
		sightlangStaticImageToc[37] = true
	end
	if sightlangStaticImageUsed[38] then
		sightlangStaticImageUsed[38] = false
		sightlangStaticImageDel[38] = false
	elseif sightlangStaticImage[38] then
		if sightlangStaticImageDel[38] then
			if now >= sightlangStaticImageDel[38] then
				if isElement(sightlangStaticImage[38]) then
					destroyElement(sightlangStaticImage[38])
				end
				sightlangStaticImage[38] = nil
				sightlangStaticImageDel[38] = false
				sightlangStaticImageToc[38] = true
				return
			end
		else
			sightlangStaticImageDel[38] = now + 5000
		end
	else
		sightlangStaticImageToc[38] = true
	end
	if sightlangStaticImageUsed[39] then
		sightlangStaticImageUsed[39] = false
		sightlangStaticImageDel[39] = false
	elseif sightlangStaticImage[39] then
		if sightlangStaticImageDel[39] then
			if now >= sightlangStaticImageDel[39] then
				if isElement(sightlangStaticImage[39]) then
					destroyElement(sightlangStaticImage[39])
				end
				sightlangStaticImage[39] = nil
				sightlangStaticImageDel[39] = false
				sightlangStaticImageToc[39] = true
				return
			end
		else
			sightlangStaticImageDel[39] = now + 5000
		end
	else
		sightlangStaticImageToc[39] = true
	end
	if sightlangStaticImageUsed[40] then
		sightlangStaticImageUsed[40] = false
		sightlangStaticImageDel[40] = false
	elseif sightlangStaticImage[40] then
		if sightlangStaticImageDel[40] then
			if now >= sightlangStaticImageDel[40] then
				if isElement(sightlangStaticImage[40]) then
					destroyElement(sightlangStaticImage[40])
				end
				sightlangStaticImage[40] = nil
				sightlangStaticImageDel[40] = false
				sightlangStaticImageToc[40] = true
				return
			end
		else
			sightlangStaticImageDel[40] = now + 5000
		end
	else
		sightlangStaticImageToc[40] = true
	end
	if sightlangStaticImageUsed[41] then
		sightlangStaticImageUsed[41] = false
		sightlangStaticImageDel[41] = false
	elseif sightlangStaticImage[41] then
		if sightlangStaticImageDel[41] then
			if now >= sightlangStaticImageDel[41] then
				if isElement(sightlangStaticImage[41]) then
					destroyElement(sightlangStaticImage[41])
				end
				sightlangStaticImage[41] = nil
				sightlangStaticImageDel[41] = false
				sightlangStaticImageToc[41] = true
				return
			end
		else
			sightlangStaticImageDel[41] = now + 5000
		end
	else
		sightlangStaticImageToc[41] = true
	end
	if sightlangStaticImageUsed[42] then
		sightlangStaticImageUsed[42] = false
		sightlangStaticImageDel[42] = false
	elseif sightlangStaticImage[42] then
		if sightlangStaticImageDel[42] then
			if now >= sightlangStaticImageDel[42] then
				if isElement(sightlangStaticImage[42]) then
					destroyElement(sightlangStaticImage[42])
				end
				sightlangStaticImage[42] = nil
				sightlangStaticImageDel[42] = false
				sightlangStaticImageToc[42] = true
				return
			end
		else
			sightlangStaticImageDel[42] = now + 5000
		end
	else
		sightlangStaticImageToc[42] = true
	end
	if sightlangStaticImageUsed[43] then
		sightlangStaticImageUsed[43] = false
		sightlangStaticImageDel[43] = false
	elseif sightlangStaticImage[43] then
		if sightlangStaticImageDel[43] then
			if now >= sightlangStaticImageDel[43] then
				if isElement(sightlangStaticImage[43]) then
					destroyElement(sightlangStaticImage[43])
				end
				sightlangStaticImage[43] = nil
				sightlangStaticImageDel[43] = false
				sightlangStaticImageToc[43] = true
				return
			end
		else
			sightlangStaticImageDel[43] = now + 5000
		end
	else
		sightlangStaticImageToc[43] = true
	end
	if sightlangStaticImageUsed[44] then
		sightlangStaticImageUsed[44] = false
		sightlangStaticImageDel[44] = false
	elseif sightlangStaticImage[44] then
		if sightlangStaticImageDel[44] then
			if now >= sightlangStaticImageDel[44] then
				if isElement(sightlangStaticImage[44]) then
					destroyElement(sightlangStaticImage[44])
				end
				sightlangStaticImage[44] = nil
				sightlangStaticImageDel[44] = false
				sightlangStaticImageToc[44] = true
				return
			end
		else
			sightlangStaticImageDel[44] = now + 5000
		end
	else
		sightlangStaticImageToc[44] = true
	end
	if sightlangStaticImageUsed[45] then
		sightlangStaticImageUsed[45] = false
		sightlangStaticImageDel[45] = false
	elseif sightlangStaticImage[45] then
		if sightlangStaticImageDel[45] then
			if now >= sightlangStaticImageDel[45] then
				if isElement(sightlangStaticImage[45]) then
					destroyElement(sightlangStaticImage[45])
				end
				sightlangStaticImage[45] = nil
				sightlangStaticImageDel[45] = false
				sightlangStaticImageToc[45] = true
				return
			end
		else
			sightlangStaticImageDel[45] = now + 5000
		end
	else
		sightlangStaticImageToc[45] = true
	end
	if sightlangStaticImageUsed[46] then
		sightlangStaticImageUsed[46] = false
		sightlangStaticImageDel[46] = false
	elseif sightlangStaticImage[46] then
		if sightlangStaticImageDel[46] then
			if now >= sightlangStaticImageDel[46] then
				if isElement(sightlangStaticImage[46]) then
					destroyElement(sightlangStaticImage[46])
				end
				sightlangStaticImage[46] = nil
				sightlangStaticImageDel[46] = false
				sightlangStaticImageToc[46] = true
				return
			end
		else
			sightlangStaticImageDel[46] = now + 5000
		end
	else
		sightlangStaticImageToc[46] = true
	end
	if sightlangStaticImageUsed[47] then
		sightlangStaticImageUsed[47] = false
		sightlangStaticImageDel[47] = false
	elseif sightlangStaticImage[47] then
		if sightlangStaticImageDel[47] then
			if now >= sightlangStaticImageDel[47] then
				if isElement(sightlangStaticImage[47]) then
					destroyElement(sightlangStaticImage[47])
				end
				sightlangStaticImage[47] = nil
				sightlangStaticImageDel[47] = false
				sightlangStaticImageToc[47] = true
				return
			end
		else
			sightlangStaticImageDel[47] = now + 5000
		end
	else
		sightlangStaticImageToc[47] = true
	end
	if sightlangStaticImageToc[0] and sightlangStaticImageToc[1] and sightlangStaticImageToc[2] and sightlangStaticImageToc[3] and sightlangStaticImageToc[4] and sightlangStaticImageToc[5] and sightlangStaticImageToc[6] and sightlangStaticImageToc[7] and sightlangStaticImageToc[8] and sightlangStaticImageToc[9] and sightlangStaticImageToc[10] and sightlangStaticImageToc[11] and sightlangStaticImageToc[12] and sightlangStaticImageToc[13] and sightlangStaticImageToc[14] and sightlangStaticImageToc[15] and sightlangStaticImageToc[16] and sightlangStaticImageToc[17] and sightlangStaticImageToc[18] and sightlangStaticImageToc[19] and sightlangStaticImageToc[20] and sightlangStaticImageToc[21] and sightlangStaticImageToc[22] and sightlangStaticImageToc[23] and sightlangStaticImageToc[24] and sightlangStaticImageToc[25] and sightlangStaticImageToc[26] and sightlangStaticImageToc[27] and sightlangStaticImageToc[28] and sightlangStaticImageToc[29] and sightlangStaticImageToc[30] and sightlangStaticImageToc[31] and sightlangStaticImageToc[32] and sightlangStaticImageToc[33] and sightlangStaticImageToc[34] and sightlangStaticImageToc[35] and sightlangStaticImageToc[36] and sightlangStaticImageToc[37] and sightlangStaticImageToc[38] and sightlangStaticImageToc[39] and sightlangStaticImageToc[40] and sightlangStaticImageToc[41] and sightlangStaticImageToc[42] and sightlangStaticImageToc[43] and sightlangStaticImageToc[44] and sightlangStaticImageToc[45] and sightlangStaticImageToc[46] and sightlangStaticImageToc[47] then
		sightlangStatImgHand = false
		removeEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre)
	end
end
processSightlangStaticImage[0] = function()
	if not isElement(sightlangStaticImage[0]) then
		sightlangStaticImageToc[0] = false
		sightlangStaticImage[0] = dxCreateTexture("files/matrix.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processSightlangStaticImage[1] = function()
	if not isElement(sightlangStaticImage[1]) then
		sightlangStaticImageToc[1] = false
		sightlangStaticImage[1] = dxCreateTexture("files/gradled.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processSightlangStaticImage[2] = function()
	if not isElement(sightlangStaticImage[2]) then
		sightlangStaticImageToc[2] = false
		sightlangStaticImage[2] = dxCreateTexture("files/matrix3.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processSightlangStaticImage[3] = function()
	if not isElement(sightlangStaticImage[3]) then
		sightlangStaticImageToc[3] = false
		sightlangStaticImage[3] = dxCreateTexture("files/matrix2.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processSightlangStaticImage[4] = function()
	if not isElement(sightlangStaticImage[4]) then
		sightlangStaticImageToc[4] = false
		sightlangStaticImage[4] = dxCreateTexture("files/matrix1.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processSightlangStaticImage[5] = function()
	if not isElement(sightlangStaticImage[5]) then
		sightlangStaticImageToc[5] = false
		sightlangStaticImage[5] = dxCreateTexture("files/logoscreen.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processSightlangStaticImage[6] = function()
	if not isElement(sightlangStaticImage[6]) then
		sightlangStaticImageToc[6] = false
		sightlangStaticImage[6] = dxCreateTexture("files/cupbg.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processSightlangStaticImage[7] = function()
	if not isElement(sightlangStaticImage[7]) then
		sightlangStaticImageToc[7] = false
		sightlangStaticImage[7] = dxCreateTexture("files/cdin.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processSightlangStaticImage[8] = function()
	if not isElement(sightlangStaticImage[8]) then
		sightlangStaticImageToc[8] = false
		sightlangStaticImage[8] = dxCreateTexture("files/cdarc.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processSightlangStaticImage[9] = function()
	if not isElement(sightlangStaticImage[9]) then
		sightlangStaticImageToc[9] = false
		sightlangStaticImage[9] = dxCreateTexture("files/livebg.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processSightlangStaticImage[10] = function()
	if not isElement(sightlangStaticImage[10]) then
		sightlangStaticImageToc[10] = false
		sightlangStaticImage[10] = dxCreateTexture("files/horses/bg.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processSightlangStaticImage[11] = function()
	if not isElement(sightlangStaticImage[11]) then
		sightlangStaticImageToc[11] = false
		sightlangStaticImage[11] = dxCreateTexture("files/horsebox.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processSightlangStaticImage[12] = function()
	if not isElement(sightlangStaticImage[12]) then
		sightlangStaticImageToc[12] = false
		sightlangStaticImage[12] = dxCreateTexture("files/smallbox.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processSightlangStaticImage[13] = function()
	if not isElement(sightlangStaticImage[13]) then
		sightlangStaticImageToc[13] = false
		sightlangStaticImage[13] = dxCreateTexture("files/winner.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processSightlangStaticImage[14] = function()
	if not isElement(sightlangStaticImage[14]) then
		sightlangStaticImageToc[14] = false
		sightlangStaticImage[14] = dxCreateTexture("files/podiumbg.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processSightlangStaticImage[15] = function()
	if not isElement(sightlangStaticImage[15]) then
		sightlangStaticImageToc[15] = false
		sightlangStaticImage[15] = dxCreateTexture("files/podium.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processSightlangStaticImage[16] = function()
	if not isElement(sightlangStaticImage[16]) then
		sightlangStaticImageToc[16] = false
		sightlangStaticImage[16] = dxCreateTexture("files/progbox2.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processSightlangStaticImage[17] = function()
	if not isElement(sightlangStaticImage[17]) then
		sightlangStaticImageToc[17] = false
		sightlangStaticImage[17] = dxCreateTexture("files/progbox.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processSightlangStaticImage[18] = function()
	if not isElement(sightlangStaticImage[18]) then
		sightlangStaticImageToc[18] = false
		sightlangStaticImage[18] = dxCreateTexture("files/live.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processSightlangStaticImage[19] = function()
	if not isElement(sightlangStaticImage[19]) then
		sightlangStaticImageToc[19] = false
		sightlangStaticImage[19] = dxCreateTexture("files/mini/el.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processSightlangStaticImage[20] = function()
	if not isElement(sightlangStaticImage[20]) then
		sightlangStaticImageToc[20] = false
		sightlangStaticImage[20] = dxCreateTexture("files/outline.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processSightlangStaticImage[21] = function()
	if not isElement(sightlangStaticImage[21]) then
		sightlangStaticImageToc[21] = false
		sightlangStaticImage[21] = dxCreateTexture("files/outline2.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processSightlangStaticImage[22] = function()
	if not isElement(sightlangStaticImage[22]) then
		sightlangStaticImageToc[22] = false
		sightlangStaticImage[22] = dxCreateTexture("files/mini/a.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processSightlangStaticImage[23] = function()
	if not isElement(sightlangStaticImage[23]) then
		sightlangStaticImageToc[23] = false
		sightlangStaticImage[23] = dxCreateTexture("files/wave.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processSightlangStaticImage[24] = function()
	if not isElement(sightlangStaticImage[24]) then
		sightlangStaticImageToc[24] = false
		sightlangStaticImage[24] = dxCreateTexture("files/top.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processSightlangStaticImage[25] = function()
	if not isElement(sightlangStaticImage[25]) then
		sightlangStaticImageToc[25] = false
		sightlangStaticImage[25] = dxCreateTexture("files/bottom.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processSightlangStaticImage[26] = function()
	if not isElement(sightlangStaticImage[26]) then
		sightlangStaticImageToc[26] = false
		sightlangStaticImage[26] = dxCreateTexture("files/head.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processSightlangStaticImage[27] = function()
	if not isElement(sightlangStaticImage[27]) then
		sightlangStaticImageToc[27] = false
		sightlangStaticImage[27] = dxCreateTexture("files/cup.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processSightlangStaticImage[28] = function()
	if not isElement(sightlangStaticImage[28]) then
		sightlangStaticImageToc[28] = false
		sightlangStaticImage[28] = dxCreateTexture("files/smallbox3.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processSightlangStaticImage[29] = function()
	if not isElement(sightlangStaticImage[29]) then
		sightlangStaticImageToc[29] = false
		sightlangStaticImage[29] = dxCreateTexture("files/help1.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processSightlangStaticImage[30] = function()
	if not isElement(sightlangStaticImage[30]) then
		sightlangStaticImageToc[30] = false
		sightlangStaticImage[30] = dxCreateTexture("files/help2.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processSightlangStaticImage[31] = function()
	if not isElement(sightlangStaticImage[31]) then
		sightlangStaticImageToc[31] = false
		sightlangStaticImage[31] = dxCreateTexture("files/horseside.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processSightlangStaticImage[32] = function()
	if not isElement(sightlangStaticImage[32]) then
		sightlangStaticImageToc[32] = false
		sightlangStaticImage[32] = dxCreateTexture("files/smallbox2.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processSightlangStaticImage[33] = function()
	if not isElement(sightlangStaticImage[33]) then
		sightlangStaticImageToc[33] = false
		sightlangStaticImage[33] = dxCreateTexture("files/horsebox2.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processSightlangStaticImage[34] = function()
	if not isElement(sightlangStaticImage[34]) then
		sightlangStaticImageToc[34] = false
		sightlangStaticImage[34] = dxCreateTexture("files/horsebox3.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processSightlangStaticImage[35] = function()
	if not isElement(sightlangStaticImage[35]) then
		sightlangStaticImageToc[35] = false
		sightlangStaticImage[35] = dxCreateTexture("files/stairside2.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processSightlangStaticImage[36] = function()
	if not isElement(sightlangStaticImage[36]) then
		sightlangStaticImageToc[36] = false
		sightlangStaticImage[36] = dxCreateTexture("files/stairside1.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processSightlangStaticImage[37] = function()
	if not isElement(sightlangStaticImage[37]) then
		sightlangStaticImageToc[37] = false
		sightlangStaticImage[37] = dxCreateTexture("files/stairsided.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processSightlangStaticImage[38] = function()
	if not isElement(sightlangStaticImage[38]) then
		sightlangStaticImageToc[38] = false
		sightlangStaticImage[38] = dxCreateTexture("files/stairsidel.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processSightlangStaticImage[39] = function()
	if not isElement(sightlangStaticImage[39]) then
		sightlangStaticImageToc[39] = false
		sightlangStaticImage[39] = dxCreateTexture("files/stairsidea.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processSightlangStaticImage[40] = function()
	if not isElement(sightlangStaticImage[40]) then
		sightlangStaticImageToc[40] = false
		sightlangStaticImage[40] = dxCreateTexture("files/stair.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processSightlangStaticImage[41] = function()
	if not isElement(sightlangStaticImage[41]) then
		sightlangStaticImageToc[41] = false
		sightlangStaticImage[41] = dxCreateTexture("files/coin/shine.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processSightlangStaticImage[42] = function()
	if not isElement(sightlangStaticImage[42]) then
		sightlangStaticImageToc[42] = false
		sightlangStaticImage[42] = dxCreateTexture("files/coin/glow.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processSightlangStaticImage[43] = function()
	if not isElement(sightlangStaticImage[43]) then
		sightlangStaticImageToc[43] = false
		sightlangStaticImage[43] = dxCreateTexture("files/win1.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processSightlangStaticImage[44] = function()
	if not isElement(sightlangStaticImage[44]) then
		sightlangStaticImageToc[44] = false
		sightlangStaticImage[44] = dxCreateTexture("files/win2.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processSightlangStaticImage[45] = function()
	if not isElement(sightlangStaticImage[45]) then
		sightlangStaticImageToc[45] = false
		sightlangStaticImage[45] = dxCreateTexture("files/win3.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processSightlangStaticImage[46] = function()
	if not isElement(sightlangStaticImage[46]) then
		sightlangStaticImageToc[46] = false
		sightlangStaticImage[46] = dxCreateTexture("files/win4.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processSightlangStaticImage[47] = function()
	if not isElement(sightlangStaticImage[47]) then
		sightlangStaticImageToc[47] = false
		sightlangStaticImage[47] = dxCreateTexture("files/light.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
local sightlangDynImgHand = false
local sightlangDynImgLatCr = falselocal
sightlangDynImage = {}
local sightlangDynImageForm = {}
local sightlangDynImageMip = {}
local sightlangDynImageUsed = {}
local sightlangDynImageDel = {}
local sightlangDynImgPre
function sightlangDynImgPre()
	local now = getTickCount()
	sightlangDynImgLatCr = true
	local rem = true
	for k in pairs(sightlangDynImage) do
		rem = false
		if sightlangDynImageDel[k] then
			if now >= sightlangDynImageDel[k] then
				if isElement(sightlangDynImage[k]) then
					destroyElement(sightlangDynImage[k])
				end
				sightlangDynImage[k] = nil
				sightlangDynImageForm[k] = nil
				sightlangDynImageMip[k] = nil
				sightlangDynImageDel[k] = nil
				break
			end
		elseif not sightlangDynImageUsed[k] then
			sightlangDynImageDel[k] = now + 5000
		end
	end
	for k in pairs(sightlangDynImageUsed) do
		if not sightlangDynImage[k] and sightlangDynImgLatCr then
			sightlangDynImgLatCr = false
			sightlangDynImage[k] = dxCreateTexture(k, sightlangDynImageForm[k], sightlangDynImageMip[k])
		end
		sightlangDynImageUsed[k] = nil
		sightlangDynImageDel[k] = nil
		rem = false
	end
	if rem then
		removeEventHandler("onClientPreRender", getRootElement(), sightlangDynImgPre)
		sightlangDynImgHand = false
	end
end
local function dynamicImage(img, form, mip)
	if not sightlangDynImgHand then
		sightlangDynImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangDynImgPre, true, "high+999999999")
	end
	if not sightlangDynImage[img] then
		sightlangDynImage[img] = dxCreateTexture(img, form, mip)
	end
	sightlangDynImageForm[img] = form
	sightlangDynImageUsed[img] = true
	return sightlangDynImage[img]
end
local faTicks = false
local function sightlangGuiRefreshColors()
	local res = getResourceFromName("sGui")
	if res and getResourceState(res) == "running" then
		faTicks = seexports.sGui:getFaTicks()
		refreshColors()
	end
end
addEventHandler("onGuiRefreshColors", getRootElement(), sightlangGuiRefreshColors)
addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangGuiRefreshColors)
addEventHandler("refreshFaTicks", getRootElement(), function()
	faTicks = seexports.sGui:getFaTicks()
end)
local sightlangModloaderLoaded = function()
	
	loadModelIds()

	triggerServerEvent("requestHorseeTables", localPlayer)

	if getElementData(localPlayer, "loggedIn") then
		triggerServerEvent("requestSSC", localPlayer)
	end
	prepareCircleMath()
	prepareHorseTables()
end
addEventHandler("modloaderLoaded", getRootElement(), sightlangModloaderLoaded)
if getElementData(localPlayer, "loggedIn") or seexports.sModloader and seexports.sModloader:isModloaderLoaded() then
	addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangModloaderLoaded)
end
local objectmodloader = {}
function loadModelIds()
	objectmodloader = {
		fortunecup_base = seexports.sModloader:getModelId("fortunecup_base"),
		fortunecup_alpha = seexports.sModloader:getModelId("fortunecup_alpha"),
		fortunecup_horse1 = seexports.sModloader:getModelId("fortunecup_horse1"),
		fortunecup_horse2 = seexports.sModloader:getModelId("fortunecup_horse2"),
		fortunecup_horse3 = seexports.sModloader:getModelId("fortunecup_horse3"),
		fortunecup_horse4 = seexports.sModloader:getModelId("fortunecup_horse4"),
		fortunecup_horse5 = seexports.sModloader:getModelId("fortunecup_horse5"),
		fortunecup_horse6 = seexports.sModloader:getModelId("fortunecup_horse6"),
		fortunecup_horse_legsF_1 = seexports.sModloader:getModelId("fortunecup_horse_legsF_1"),
		fortunecup_horse_legsR_1 = seexports.sModloader:getModelId("fortunecup_horse_legsR_1"),
		fortunecup_horse_legsF_2 = seexports.sModloader:getModelId("fortunecup_horse_legsF_2"),
		fortunecup_horse_legsR_2 = seexports.sModloader:getModelId("fortunecup_horse_legsR_2"),
		fortunecup_horse_legsF_3 = seexports.sModloader:getModelId("fortunecup_horse_legsF_3"),
		fortunecup_horse_legsR_3 = seexports.sModloader:getModelId("fortunecup_horse_legsR_3"),
		fortunecup_horse_legsF_4 = seexports.sModloader:getModelId("fortunecup_horse_legsF_4"),
		fortunecup_horse_legsR_4 = seexports.sModloader:getModelId("fortunecup_horse_legsR_4"),
		fortunecup_finish = seexports.sModloader:getModelId("fortunecup_finish"),
		fortunecup_start = seexports.sModloader:getModelId("fortunecup_start")
	}
end
local screenX, screenY = guiGetScreenSize()
local numberFont, numberFontScale, numberExFont, numberExFontScale, cupFont, cupFontScale, cupFontZeroSize, helpFont, helpFontScale
local hexColors = {}
local bigX, bigY, smallX, smallY, bigWindow, smallWindow
local titleBarHeight = 0
local bigPreview = false
local betButtons = {}
local sideButtons = {}
for i = 1, horseNum do
	sideButtons[i] = {}
end
local guiButtons = {}
local coinButtons = {}
local guiHovers = {}
local sitIcon = false
local sitColor = false
function refreshColors()
	numberFont = seexports.sGui:getFont("10/Impact.ttf")
	numberFontScale = seexports.sGui:getFontScale("10/Impact.ttf")
	numberExFont = seexports.sGui:getFont("15/Impact.ttf")
	numberExFontScale = seexports.sGui:getFontScale("15/Impact.ttf")
	cupFont = seexports.sGui:getFont("17/BebasNeueBold.otf")
	cupFontScale = seexports.sGui:getFontScale("17/BebasNeueBold.otf")
	cupFontZeroSize = seexports.sGui:getTextWidthFont("0", "17/BebasNeueBold.otf")
	helpFont = seexports.sGui:getFont("12/BebasNeueRegular.otf")
	helpFontScale = seexports.sGui:getFontScale("12/BebasNeueRegular.otf")
	sitIcon = seexports.sGui:getFaIconFilename("user", 24)
	sitColor = seexports.sGui:getColorCodeToColor("sightgreen")
	sitBgColor = seexports.sGui:getColorCode("sightgrey1")
	faTicks = seexports.sGui:getFaTicks()
	hexColors.sightgreen = seexports.sGui:getColorCodeHex("sightgreen")
	hexColors.sightred = seexports.sGui:getColorCodeHex("sightred")
	hexColors.sightblue = seexports.sGui:getColorCodeHex("sightblue")
	for i = 1, #horseColors do
		horseColors[i][5] = seexports.sGui:getColorCodeHex(horseColors[i])
		horseColors[i][4] = tocolor(horseColors[i][1], horseColors[i][2], horseColors[i][3])
	end
end
function formatBetText(num)
	if 100000 <= num then
		return math.floor(num / 1000) .. "K"
	elseif 10000 <= num then
		return math.floor(num / 1000 * 10) / 10 .. "K"
	end
	return num
end
local currentCoin = 1
local myBets = 0
local myWin = 0
local myBetsFormatted = 0
local myWinFormatted = 0
local myWinFormattedEx = 0
local lastBet = {}
local lastSideBet = {}
local betsFormat = {}
local sideBetsFormat = {}
for i = 1, horseNum do
	sideBetsFormat[i] = {}
	lastSideBet[i] = {}
end
local balance = 0
local balanceText = false
local balanceNew = 0
local balanceSpeed = 0
function convertBalanceText()
	if not balanceText then
		balanceText = {}
	end
	local i = 0
	while true do
		i = i + 1
		local p = math.pow(10, i - 1)
		local n = math.floor(balance / p)
		if 0 < n or i == 1 then
			balanceText[i] = n % 10
		else
			balanceText[i] = nil
			if i >= #balanceText then
				break
			end
		end
	end
end
local myTable = false
local mySeat = false
addEvent("refreshSSC", true)
addEventHandler("refreshSSC", getRootElement(), function(amount)
	balanceNew = math.max(0, tonumber(amount) or 0)
	if not myTable or not balanceText then
		balance = balanceNew
		convertBalanceText()
	elseif balance > balanceNew then
		balanceSpeed = math.abs(balance - balanceNew) / betWait
	else
		balanceSpeed = math.abs(balance - balanceNew) / 1000
	end
end)
local textureChanger = [[
	texture gTexture;

	technique hello
	{
		pass P0
		{
			Texture[0] = gTexture;
		}
	}

]]
local longLength = 2.4
local circleRadius = 0.137431
local centerRadius = 0.237987
local tableHeight = 0.9
local midRadius = 0
local progressLength = 0
local circleCircum = {}
local circleProg = {}
local longProg = {}
local oneProg = {}
local preDist = {}
local preProg = {}
function prepareCircleMath()
	midRadius = (centerRadius + circleRadius * (1 + horseNum) / 2) * math.pi
	progressLength = longLength * 3 + midRadius * 2
	for i = 1, horseNum do
		circleCircum[i] = centerRadius + circleRadius * i
		local circum = circleCircum[i] * math.pi
		local sum = (circum + longLength) * 2 + longLength
		circleProg[i] = circum / sum
		longProg[i] = longLength / sum
		oneProg[i] = (longProg[i] + circleProg[i]) * 2
		preDist[i] = {
			longLength,
			longLength + midRadius,
			longLength * 2 + midRadius,
			longLength * 2 + midRadius * 2
		}
		preProg[i] = {
			-longProg[i],
			-longProg[i] - circleProg[i],
			-longProg[i] * 2 - circleProg[i]
		}
	end
end
local horseTables = {}
local horseLegmodloader = {
	1,
	2,
	3,
	4,
	1,
	4
}
function playTableSound(sound, tbl)
	local x, y, z = unpack(tbl.pos)
	local el = playSound3D("files/sound/" .. sound .. ".mp3", x, y, z + tableHeight)
	setElementInterior(el, tbl.int)
	setElementDimension(el, tbl.dim)
	setSoundVolume(el, sound == "horn" and 1 or 0.75)
	setSoundMaxDistance(el, 14)
	return el
end
function playSeatSound(sound, tbl, seat)
	local el = false
	local file = sound
	if sound == "ssccollect" then
		file = file .. math.random(1, 3)
	end
	if tbl.id == myTable and seat == mySeat then
		el = playSound("files/sound/" .. file .. ".mp3")
	else
		local scr = tbl.scr[seat]
		local x, y, z = scr[1], scr[2], scr[3]
		el = playSound3D("files/sound/" .. file .. ".mp3", x, y, z)
		setElementDimension(el, tbl.dim)
		setElementInterior(el, tbl.int)
		if sound == "ssc1" or sound == "ssc2" or sound == "sscfade" or sound == "ssccollect" then
			setSoundVolume(el, 0.75)
			setSoundMinDistance(el, 1.35)
			setSoundMaxDistance(el, 14)
		end
	end
	return el
end
local winTexture = false
local coinTextures = {}
local coinS = 0.0215764609375
local fullY = 0.29590574999999997
function processScreenCoins(tbl)
	tbl.scrFull = {}
	tbl.scrCoins = {}
	tbl.scrSideCoins = {}
	local xr = 7.70587890625E-4
	local yr = 7.638802083333333E-4
	local h = 550 / horseNum * yr
	local cx1 = (-(128 * (2.15 + 0.85 * (horseNum - 1) + 1)) / 2 + 134.4 + 42 + 39.5) * xr
	local cx2 = (-(128 * (2.15 + 0.85 * (horseNum - 1) + 1)) / 2 + 273.05 + 15 + 49) * xr
	local w2 = 108.8 * xr
	for seat = 1, seats do
		local x, y, z, nx, ny, nz, tx, ty, tz, lx, ly, lz = tbl.scr[seat][1], tbl.scr[seat][2], tbl.scr[seat][3], tbl.scr[seat][4], tbl.scr[seat][5], tbl.scr[seat][6], tbl.scr[seat][7], tbl.scr[seat][8], tbl.scr[seat][9], tbl.scr[seat][10], tbl.scr[seat][11], tbl.scr[seat][12]
		tbl.scrFull[seat] = {
			x - tx * fullY,
			y - ty * fullY,
			z - tz * fullY,
			x + tx * fullY,
			y + ty * fullY,
			z + tz * fullY,
			x + nx,
			y + ny,
			z + nz
		}
		tbl.scrCoins[seat] = {}
		tbl.scrSideCoins[seat] = {}
		local cy1 = -264 * yr + h / 2
		for i = 1, horseNum do
			local cx = x + lx * cx1 + tx * cy1
			local cy = y + ly * cx1 + ty * cy1
			local cz = z + lz * cx1 + tz * cy1
			tbl.scrCoins[seat][i] = {
				cx - tx * coinS,
				cy - ty * coinS,
				cz - tz * coinS,
				cx + tx * coinS,
				cy + ty * coinS,
				cz + tz * coinS,
				cx + nx,
				cy + ny,
				cz + nz
			}
			tbl.scrSideCoins[seat][i] = {}
			for j = 1, i - 1 do
				local cx = x + lx * (cx2 + (j - 1) * w2) + tx * cy1
				local cy = y + ly * (cx2 + (j - 1) * w2) + ty * cy1
				local cz = z + lz * (cx2 + (j - 1) * w2) + tz * cy1
				tbl.scrSideCoins[seat][i][j] = {
					cx - tx * coinS,
					cy - ty * coinS,
					cz - tz * coinS,
					cx + tx * coinS,
					cy + ty * coinS,
					cz + tz * coinS,
					cx + nx,
					cy + ny,
					cz + nz
				}
			end
			cy1 = cy1 + h
		end
	end
end
local screens = {
	{
		-1.7831,
		2.0716,
		1.0863,
		-0.3027,
		0,
		0.9531,
		-0.953088,
		0,
		-0.302692,
		0,
		-1,
		0
	},
	{
		-1.7831,
		0.6905,
		1.0863,
		-0.3027,
		0,
		0.9531,
		-0.953088,
		0,
		-0.302692,
		0,
		-1,
		0
	},
	{
		-1.7831,
		-0.6905,
		1.0863,
		-0.3027,
		0,
		0.9531,
		-0.953088,
		0,
		-0.302692,
		0,
		-1,
		0
	},
	{
		-1.7831,
		-2.0716,
		1.0863,
		-0.3027,
		0,
		0.9531,
		-0.953088,
		0,
		-0.302692,
		0,
		-1,
		0
	},
	{
		-0.6905,
		-3.1066,
		1.0863,
		0,
		-0.3027,
		0.9531,
		0,
		-0.953088,
		-0.302692,
		1,
		0,
		0
	},
	{
		0.6905,
		-3.1066,
		1.0863,
		0,
		-0.3027,
		0.9531,
		0,
		-0.953088,
		-0.302692,
		1,
		0,
		0
	},
	{
		1.7992,
		-2.0716,
		1.0863,
		0.3027,
		0,
		0.9531,
		0.953088,
		0,
		-0.302692,
		0,
		1,
		0
	},
	{
		1.7992,
		-0.6905,
		1.0863,
		0.3027,
		0,
		0.9531,
		0.953088,
		0,
		-0.302692,
		0,
		1,
		0
	},
	{
		1.7992,
		0.6905,
		1.0863,
		0.3027,
		0,
		0.9531,
		0.953088,
		0,
		-0.302692,
		0,
		1,
		0
	},
	{
		1.7992,
		2.0716,
		1.0863,
		0.3027,
		0,
		0.9531,
		0.953088,
		0,
		-0.302692,
		0,
		1,
		0
	}
}
function prepareHorseTables()
	for i = 1, #tableList do
		local x, y, z, rz, int, dim = unpack(tableList[i])
		local tbl = {}
		tbl.id = i
		tbl.pos = {
			x,
			y,
			z,
			rz
		}
		tbl.int = int
		tbl.dim = dim
		tbl.rad = math.rad(rz)
		tbl.cos = math.cos(tbl.rad)
		tbl.sin = math.sin(tbl.rad)
		tbl.history = {}
		tbl.players = {}
		tbl.seats = {}
		for i = 1, #horseSeats do
			tbl.seats[i] = {
				x + tbl.cos * horseSeats[i][1] - tbl.sin * horseSeats[i][2],
				y + tbl.sin * horseSeats[i][1] + tbl.cos * horseSeats[i][2],
				z + horseSeats[i][3],
				horseSeats[i][4] + rz
			}
		end
		tbl.llsin = tbl.sin * longLength
		tbl.llcos = tbl.cos * longLength
		tbl.circleCos = {}
		tbl.circleSin = {}
		for j = 1, horseNum do
			tbl.circleCos[j] = tbl.cos * circleCircum[j]
			tbl.circleSin[j] = tbl.sin * circleCircum[j]
		end
		tbl.betCoins = {}
		for seat = 1, seats do
			tbl.betCoins[seat] = {}
		end
		tbl.sideCoins = {}
		for seat = 1, seats do
			tbl.sideCoins[seat] = {}
			for i = 1, horseNum do
				tbl.sideCoins[seat][i] = {}
			end
		end
		tbl.scr = {}
		for i = 1, #screens do
			tbl.scr[i] = {
				x + tbl.cos * screens[i][1] - tbl.sin * screens[i][2],
				y + tbl.sin * screens[i][1] + tbl.cos * screens[i][2],
				z + screens[i][3],
				tbl.cos * screens[i][4] - tbl.sin * screens[i][5],
				tbl.sin * screens[i][4] + tbl.cos * screens[i][5],
				screens[i][6],
				tbl.cos * screens[i][7] - tbl.sin * screens[i][8],
				tbl.sin * screens[i][7] + tbl.cos * screens[i][8],
				screens[i][9],
				tbl.cos * screens[i][10] - tbl.sin * screens[i][11],
				tbl.sin * screens[i][10] + tbl.cos * screens[i][11],
				screens[i][12]
			}
			tbl.scr[i][1] = tbl.scr[i][1] + tbl.scr[i][4] * 0.01 * 0.75
			tbl.scr[i][2] = tbl.scr[i][2] + tbl.scr[i][5] * 0.01 * 0.75
			tbl.scr[i][3] = tbl.scr[i][3] + tbl.scr[i][6] * 0.01 * 0.75
		end
		processScreenCoins(tbl)
		horseTables[i] = tbl
	end
end
local streamedInTables = {}
local tableEventsHandled = false
function streamOutTable(tbl)
	if tbl.streamed and myTable ~= tbl.id then
		tbl.streamed = false
		for i = #streamedInTables, 1, -1 do
			if streamedInTables[i] and streamedInTables[i] == tbl then
				table.remove(streamedInTables, i)
			end
		end
		if isElement(tbl.obj) then
			destroyElement(tbl.obj)
		end
		tbl.obj = false
		if isElement(tbl.alpha) then
			destroyElement(tbl.alpha)
		end
		tbl.alpha = false
		if isElement(tbl.flag1) then
			destroyElement(tbl.flag1)
		end
		tbl.flag1 = false
		if isElement(tbl.flag2) then
			destroyElement(tbl.flag2)
		end
		tbl.flag2 = false
		if isElement(tbl.miniRt) then
			destroyElement(tbl.miniRt)
		end
		tbl.miniRt = false
		if isElement(tbl.bigRt) then
			destroyElement(tbl.bigRt)
		end
		tbl.bigRt = false
		if isElement(tbl.ledRt) then
			destroyElement(tbl.ledRt)
		end
		tbl.ledRt = false
		if isElement(tbl.miniShader) then
			destroyElement(tbl.miniShader)
		end
		tbl.miniShader = false
		if isElement(tbl.bigShader) then
			destroyElement(tbl.bigShader)
		end
		tbl.bigShader = false
		if isElement(tbl.ledShader) then
			destroyElement(tbl.ledShader)
		end
		tbl.ledShader = false
		if isElement(tbl.crowdSound) then
			destroyElement(tbl.crowdSound)
		end
		tbl.crowdSound = false
		if isElement(tbl.themeSound) then
			destroyElement(tbl.themeSound)
		end
		tbl.themeSound = false
		tbl.newAnimation = nil
		tbl.newAnimationDelta = nil
		tbl.oldCupName = nil
		tbl.oldBg = nil
		tbl.oldOdds = nil
		tbl.oldNames = nil
		tbl.oldSideOdds = nil
		tbl.endStarted = nil
		tbl.matchDelta = nil
		tbl.matchGoHomeP = nil
		tbl.matchStart = nil
		tbl.matchTime = nil
		tbl.winCount = nil
		tbl.loseCount = nil
		tbl.speed = nil
		tbl.endPos = nil
		tbl.countdown = nil
		tbl.countdownTime = nil
		tbl.finishFlag = nil
		for i = 1, horseNum do
			if isElement(tbl.horses[i].obj) then
				destroyElement(tbl.horses[i].obj)
			end
			tbl.horses[i].obj = false
			if isElement(tbl.horses[i].legF) then
				destroyElement(tbl.horses[i].legF)
			end
			tbl.horses[i].legF = false
			if isElement(tbl.horses[i].legR) then
				destroyElement(tbl.horses[i].legR)
			end
			tbl.horses[i].legR = false
			if isElement(tbl.horses[i].sound) then
				destroyElement(tbl.horses[i].sound)
			end
			tbl.horses[i].sound = false
		end
		for seat = 1, seats do
			if isElement(tbl.players[seat]) then
				detachElements(tbl.players[seat], tbl.obj)
				setPedAnimation(tbl.players[seat])
			end
		end
		tbl.players = {}
		if #streamedInTables <= 0 then
			for i = minCoinOverall, #coinValues do
				if isElement(coinTextures[i]) then
					destroyElement(coinTextures[i])
				end
				coinTextures[i] = false
			end
			if isElement(winTexture) then
				destroyElement(winTexture)
			end
			winTexture = false
		end
		if #streamedInTables <= 0 and tableEventsHandled then
			removeEventHandler("onClientRender", getRootElement(), renderHorseeTables)
			removeEventHandler("onClientPreRender", getRootElement(), preRenderHorseeTables)
			removeEventHandler("onClientRestore", getRootElement(), restoreHorseeTables)
			removeEventHandler("onClientRender", getRootElement(), renderSeatIcons)
			removeEventHandler("onClientClick", getRootElement(), clickSeatIcons)
			tableEventsHandled = false
		end
	end
end
function streamInTable(tbl)
	if not tbl.streamed then
		tbl.streamed = true
		table.insert(streamedInTables, tbl)
		local x, y, z, rz = unpack(tbl.pos)
		tbl.obj = createObject(objectmodloader.fortunecup_base, x, y, z, 0, 0, rz)
		setElementDimension(tbl.obj, tbl.dim)
		setElementInterior(tbl.obj, tbl.int)
		tbl.alpha = createObject(objectmodloader.fortunecup_alpha, x, y, z, 0, 0, rz)
		setElementDimension(tbl.alpha, tbl.dim)
		setElementInterior(tbl.alpha, tbl.int)
		tbl.flag1 = createObject(objectmodloader.fortunecup_start, x + tbl.sin * 1.2, y - tbl.cos * 1.2, z + 0.9177, 0, 0, 90 + rz)
		setElementDimension(tbl.flag1, tbl.dim)
		setElementInterior(tbl.flag1, tbl.int)
		setElementCollisionsEnabled(tbl.flag1, false)
		setElementDoubleSided(tbl.flag1, true)
		tbl.flag2 = createObject(objectmodloader.fortunecup_finish, x - tbl.sin * 1.2, y + tbl.cos * 1.2, z + 0.9177, 0, 0, rz)
		setElementDimension(tbl.flag2, tbl.dim)
		setElementInterior(tbl.flag2, tbl.int)
		setElementCollisionsEnabled(tbl.flag2, false)
		setElementDoubleSided(tbl.flag2, true)
		tbl.miniRt = dxCreateRenderTarget(170, 129)
		tbl.miniShader = dxCreateShader(textureChanger)
		dxSetShaderValue(tbl.miniShader, "gTexture", tbl.miniRt)
		engineApplyShaderToWorldTexture(tbl.miniShader, "fortunecup_screens", tbl.obj)
		tbl.bigRt = dxCreateRenderTarget(342, 256)
		tbl.bigShader = dxCreateShader(textureChanger)
		dxSetShaderValue(tbl.bigShader, "gTexture", tbl.bigRt)
		engineApplyShaderToWorldTexture(tbl.bigShader, "fortunecup_mainscreen", tbl.obj)
		tbl.ledRt = dxCreateRenderTarget(172, 127)
		tbl.ledShader = dxCreateShader(textureChanger)
		dxSetShaderValue(tbl.ledShader, "gTexture", tbl.ledRt)
		engineApplyShaderToWorldTexture(tbl.ledShader, "fortunecup_leds", tbl.obj)
		engineApplyShaderToWorldTexture(tbl.ledShader, "fortunecup_leds", tbl.flag1)
		engineApplyShaderToWorldTexture(tbl.ledShader, "fortunecup_leds", tbl.flag2)
		tbl.horses = {}
		for i = 1, horseNum do
			local horse = {}
			local hx, hy = x, y
			hx = hx + tbl.cos * (centerRadius + circleRadius * i)
			hy = hy + tbl.sin * (centerRadius + circleRadius * i)
			hx = hx - tbl.sin * longLength * -0.5
			hy = hy + tbl.cos * longLength * -0.5
			horse.obj = createObject(objectmodloader["fortunecup_horse" .. i], hx, hy, z + tableHeight, 0, 0, rz)
			setElementDimension(horse.obj, tbl.dim)
			setElementInterior(horse.obj, tbl.int)
			setElementCollisionsEnabled(horse.obj, false)
			horse.legF = createObject(objectmodloader["fortunecup_horse_legsF_" .. horseLegmodloader[i]], x, y, z, 0, 0, rz)
			setElementDimension(horse.legF, tbl.dim)
			setElementInterior(horse.legF, tbl.int)
			setElementCollisionsEnabled(horse.legF, false)
			horse.legR = createObject(objectmodloader["fortunecup_horse_legsR_" .. horseLegmodloader[i]], x, y, z, 0, 0, rz)
			setElementDimension(horse.legR, tbl.dim)
			setElementInterior(horse.legR, tbl.int)
			setElementCollisionsEnabled(horse.legR, false)
			attachElements(horse.legF, horse.obj, 0, 0.0486, 0.0906)
			attachElements(horse.legR, horse.obj, 0, -0.0504, 0.0959)
			tbl.horses[i] = horse
		end
		tbl.refreshMiniScreen = true
		tbl.refreshBigScreen = true
		for i = minCoinOverall, #coinValues do
			if not isElement(coinTextures[i]) then
				coinTextures[i] = dxCreateTexture("files/coin/s" .. i .. ".dds")
			end
		end
		if not isElement(winTexture) then
			winTexture = dxCreateTexture("files/win3d.dds")
		end
		if not tableEventsHandled then
			addEventHandler("onClientRender", getRootElement(), renderHorseeTables)
			addEventHandler("onClientPreRender", getRootElement(), preRenderHorseeTables)
			addEventHandler("onClientRestore", getRootElement(), restoreHorseeTables)
			addEventHandler("onClientRender", getRootElement(), renderSeatIcons)
			addEventHandler("onClientClick", getRootElement(), clickSeatIcons)
			tableEventsHandled = true
		end
	end
end
function restoreHorseeTables()
	for i = 1, #streamedInTables do
		local tbl = horseTables[i]
		tbl.refreshMiniScreen = true
		tbl.refreshBigScreen = true
	end
end
function resetHorses(tbl)
	local x, y, z, rz = unpack(tbl.pos)
	for i = 1, horseNum do
		local hx, hy = x, y
		hx = hx + tbl.cos * (centerRadius + circleRadius * i)
		hy = hy + tbl.sin * (centerRadius + circleRadius * i)
		hx = hx - tbl.sin * longLength * -0.5
		hy = hy + tbl.cos * longLength * -0.5
		setElementPosition(tbl.horses[i].obj, hx, hy, z + tableHeight)
		setElementRotation(tbl.horses[i].obj, 0, 0, rz)
	end
	setElementRotation(tbl.flag1, 0, 0, 90 + rz)
	setElementRotation(tbl.flag2, 0, 0, rz)
end
function playWinLoseSounds(tbl)
	for i = 1, seats do
		if tbl.winCount[i] then
			for j = 1, tbl.winCount[i] do
				setTimer(playSeatSound, 4500 + 2500 * (j - 1), 1, "sscfade", tbl, i)
			end
		end
		if tbl.loseCount[i] then
			for j = 1, tbl.loseCount[i] do
				setTimer(playSeatSound, 1000 + 125 * (j - 1), 1, "ssccollect", tbl, i)
			end
		end
	end
end
addEvent("newHorseeMatch", true)
addEventHandler("newHorseeMatch", getRootElement(), function(id, odds, sideOdds, names, cupName, bg, theme)
	local tbl = horseTables[id]
	if tbl and tbl.streamed then
		local now = getTickCount()
		if id == myTable then
			myBets = 0
			myBetsFormatted = 0
			myWin = 0
			if tbl.bets[mySeat][tbl.winner] then
				myWin = myWin + math.floor(tbl.bets[mySeat][tbl.winner] * tbl.odds[tbl.winner])
			end
			if tbl.sideBets[mySeat][tbl.quinellaA][tbl.quinellaB] then
				myWin = myWin + math.floor(tbl.sideBets[mySeat][tbl.quinellaA][tbl.quinellaB] * tbl.sideOdds[tbl.quinellaA][tbl.quinellaB])
			end
			myWinFormatted = formatBetText(myWin)
			myWinFormattedEx = seexports.sGui:thousandsStepper(myWin)
		end
		playTableSound("fade", tbl)
		setTimer(playTableSound, 150, 20, "fade", tbl)
		table.insert(tbl.history, {
			tbl.cupName,
			tbl.winner,
			tbl.runnerUp,
			tbl.names[tbl.winner],
			tbl.names[tbl.runnerUp],
			tbl.odds[tbl.winner],
			tbl.sideOdds[tbl.quinellaA][tbl.quinellaB]
		})
		while 20 < #tbl.history do
			table.remove(tbl.history, 1)
		end
		tbl.place = nil
		tbl.livebg = false
		tbl.live = false
		tbl.liveY = false
		tbl.newAnimation = now
		tbl.newAnimationDelta = 0
		tbl.oldCupName = tbl.cupName
		tbl.cupName = cupName
		tbl.oldBg = tbl.bg
		tbl.bg = bg
		tbl.theme = theme
		tbl.oldOdds = {}
		tbl.oldNames = {}
		tbl.oldSideOdds = {}
		for i = 1, horseNum do
			tbl.oldOdds[i] = tbl.odds[i]
			tbl.odds[i] = floorOdds(odds[i])
			tbl.oldNames[i] = tbl.names[i]
			tbl.names[i] = names[i]
			tbl.oldSideOdds[i] = {}
			for j = 1, i - 1 do
				tbl.oldSideOdds[i][j] = tbl.sideOdds[i][j]
				tbl.sideOdds[i][j] = floorOdds(sideOdds[i][j])
			end
		end
		tbl.betting = true
		tbl.endStarted = nil
		tbl.matchDelta = nil
		tbl.matchGoHomeP = nil
		tbl.matchStart = nil
		tbl.matchTime = nil
		tbl.winCount = nil
		tbl.loseCount = nil
		tbl.speed = nil
		tbl.endPos = nil
		tbl.countdown = nil
		tbl.countdownTime = nil
		tbl.finishFlag = nil
		if isElement(tbl.crowdSound) then
			destroyElement(tbl.crowdSound)
		end
		tbl.crowdSound = false
		if isElement(tbl.themeSound) then
			destroyElement(tbl.themeSound)
		end
		tbl.themeSound = false
		if not tbl.resetted then
			resetHorses(tbl)
		end
		tbl.refreshMiniScreen = true
		tbl.refreshBigScreen = true
		for i = 1, horseNum do
			if isElement(tbl.horses[i].sound) then
				destroyElement(tbl.horses[i].sound)
			end
			tbl.horses[i].sound = false
		end
		if id == myTable then
			lastBet = {}
			betsFormat = {}
			for seat = 1, seats do
				tbl.bets[seat] = {}
				tbl.betCoins[seat] = {}
			end
			for i = 1, horseNum do
				sideBetsFormat[i] = {}
				lastSideBet[i] = {}
				for seat = 1, seats do
					tbl.sideBets[seat][i] = {}
					tbl.sideCoins[seat][i] = {}
				end
			end
			if bigWindow then
				refreshHistoryTooltip()
			end
		end
	end
end)
addEvent("startHorseeMatch", true)
addEventHandler("startHorseeMatch", getRootElement(), function(id, time, speed, finishTime, endPos, place, winCount, loseCount)
	local tbl = horseTables[id]
	if tbl and tbl.streamed then
		local now = getTickCount()
		playTableSound("horn", tbl)
		myWin = 0
		myWinFormatted = 0
		myWinFormattedEx = 0
		tbl.endStarted = false
		tbl.betting = false
		tbl.matchDelta = 0
		tbl.matchGoHomeP = 0
		tbl.livebg = 0
		tbl.live = {}
		tbl.liveY = {}
		tbl.matchStart = now + 8000
		tbl.matchTime = time
		tbl.resetted = false
		tbl.speed = speed
		tbl.finishTime = finishTime
		tbl.endPos = endPos
		tbl.place = place
		tbl.winner = tbl.place[1]
		tbl.runnerUp = tbl.place[2]
		tbl.quinellaA = math.max(tbl.place[1], tbl.place[2])
		tbl.quinellaB = math.min(tbl.place[1], tbl.place[2])
		tbl.winCount = winCount
		tbl.loseCount = loseCount
		tbl.firstFinish = false
		tbl.cheered = false
		local x, y, z = unpack(tbl.pos)
		if isElement(tbl.crowdSound) then
			destroyElement(tbl.crowdSound)
		end
		tbl.crowdSound = playSound3D("files/sound/crowd.mp3", x, y, z + tableHeight, true)
		setElementInterior(tbl.crowdSound, tbl.int)
		setElementDimension(tbl.crowdSound, tbl.dim)
		setSoundMaxDistance(tbl.crowdSound, 14)
		setSoundVolume(tbl.crowdSound, 0)
		if isElement(tbl.themeSound) then
			destroyElement(tbl.themeSound)
		end
		tbl.themeSound = false
		tbl.finishFlag = false
		for i = 1, horseNum do
			tbl.horses[i].pos = false
			tbl.horses[i].velocity = 0
			tbl.horses[i].finished = tbl.matchStart + tbl.finishTime[i] * 1000
			tbl.horses[i].ended = false
			tbl.horses[i].canFinish = false
			if isElement(tbl.horses[i].sound) then
				destroyElement(tbl.horses[i].sound)
			end
			tbl.horses[i].sound = playSound3D("files/sound/galop.mp3", x, y, z, true)
			setElementDimension(tbl.horses[i].sound, tbl.dim)
			setElementInterior(tbl.horses[i].sound, tbl.int)
			attachElements(tbl.horses[i].sound, tbl.horses[i].obj)
			setSoundMinDistance(tbl.horses[i].sound, 1.35)
			setSoundMaxDistance(tbl.horses[i].sound, 14)
			setSoundVolume(tbl.horses[i].sound, 0)
			setSoundPosition(tbl.horses[i].sound, math.random() * 13)
			if not tbl.firstFinish or tbl.horses[i].finished < tbl.firstFinish then
				tbl.firstFinish = tbl.horses[i].finished
			end
			tbl.horses[tbl.place[i]].place = i
		end
		tbl.firstFinish = tbl.firstFinish - 100
		if id == myTable and bigWindow then
			createWindow(false)
		end
		tbl.refreshMiniScreen = true
	end
end)
addEvent("gotNewHorseeBet", true)
addEventHandler("gotNewHorseeBet", getRootElement(), function(id, seat, i, j, bet)
	local tbl = horseTables[id]
	if tbl and tbl.streamed then
		local now = getTickCount()
		if j then
			if bet then
				for coin = #coinValues, minCoinSide, -1 do
					if bet >= coinValues[coin] then
						tbl.sideCoins[seat][i][j] = coin
						break
					end
				end
				if bet > (tbl.sideBets[seat][i][j] or 0) then
					playSeatSound("ssc1", tbl, seat)
				else
					playSeatSound("ssc2", tbl, seat)
				end
			else
				tbl.sideCoins[seat][i][j] = nil
				playSeatSound("ssc2", tbl, seat)
			end
			if id == myTable and seat == mySeat then
				myBets = myBets - (tbl.sideBets[seat][i][j] or 0) + (bet or 0)
				myBetsFormatted = formatBetText(myBets)
				if bet then
					sideBetsFormat[i][j] = formatBetText(bet)
				else
					sideBetsFormat[i][j] = nil
				end
				lastSideBet[i][j] = now
				tbl.sideBets[seat][i][j] = bet
				processSideOddsTooltip(i, j)
			else
				tbl.sideBets[seat][i][j] = bet
			end
		else
			if bet then
				for coin = #coinValues, minCoin, -1 do
					if bet >= coinValues[coin] then
						tbl.betCoins[seat][i] = coin
						break
					end
				end
				if bet > (tbl.bets[seat][i] or 0) then
					playSeatSound("ssc1", tbl, seat)
				else
					playSeatSound("ssc2", tbl, seat)
				end
			else
				tbl.betCoins[seat][i] = nil
				playSeatSound("ssc2", tbl, seat)
			end
			if id == myTable and seat == mySeat then
				myBets = myBets - (tbl.bets[seat][i] or 0) + (bet or 0)
				myBetsFormatted = formatBetText(myBets)
				if bet then
					betsFormat[i] = formatBetText(bet)
				else
					betsFormat[i] = nil
				end
				lastBet[i] = now
				tbl.bets[seat][i] = bet
				processOddsTooltip(i)
			else
				tbl.bets[seat][i] = bet
			end
		end
		if not tbl.countdown then
			tbl.countdown = now
			tbl.countdownTime = false
		end
	end
end)
addEvent("streamOutHorsee", true)
addEventHandler("streamOutHorsee", getRootElement(), function(dim)
	for i = 1, #tablesPerDimension[dim] do
		streamOutTable(horseTables[tablesPerDimension[dim][i]])
	end
end)
addEvent("gotHorseeTableData", true)
addEventHandler("gotHorseeTableData", getRootElement(), function(id, data, cd, start)
	local tbl = horseTables[id]
	local now = getTickCount()
	tbl.countdown = cd and now - cd or false
	for key, value in pairs(data) do
		if key == "odds" then
			for i = 1, horseNum do
				value[i] = floorOdds(value[i])
			end
		elseif key == "sideOdds" then
			for i = 1, horseNum do
				for j = 1, i - 1 do
					value[i][j] = floorOdds(value[i][j])
				end
			end
		elseif key == "bets" then
			for seat = 1, seats do
				for i = 1, horseNum do
					if value[seat][i] then
						for coin = #coinValues, minCoin, -1 do
							if coinValues[coin] <= value[seat][i] then
								tbl.betCoins[seat][i] = coin
								break
							end
						end
					else
						tbl.betCoins[seat][i] = nil
					end
				end
			end
		elseif key == "sideBets" then
			for seat = 1, seats do
				for i = 1, horseNum do
					for j = 1, i - 1 do
						if value[seat][i][j] then
							for coin = #coinValues, minCoin, -1 do
								if coinValues[coin] <= value[seat][i][j] then
									tbl.sideCoins[seat][i][j] = coin
									break
								end
							end
						else
							tbl.sideCoins[seat][i][j] = nil
						end
					end
				end
			end
		end
		tbl[key] = value
	end
	streamInTable(tbl)
	for seat = 1, seats do
		if isElement(tbl.players[seat]) then
			attachElements(tbl.players[seat], tbl.obj, horseSeats[seat][1], horseSeats[seat][2], horseSeats[seat][3], 0, 0, horseSeats[seat][4])
			setPedAnimation(tbl.players[seat], "int_office", "off_sit_idle_loop", -1, true, false, false, false)
		end
	end
	if start then
		local x, y, z, rz = unpack(tbl.pos)
		tbl.matchStart = now + 8000 - start
		tbl.endStarted = false
		tbl.betting = false
		tbl.matchDelta = 0
		tbl.matchGoHomeP = 0
		tbl.livebg = 0
		tbl.live = {}
		tbl.liveY = {}
		tbl.resetted = false
		tbl.winner = tbl.place[1]
		tbl.runnerUp = tbl.place[2]
		tbl.quinellaA = math.max(tbl.place[1], tbl.place[2])
		tbl.quinellaB = math.min(tbl.place[1], tbl.place[2])
		if isElement(tbl.crowdSound) then
			destroyElement(tbl.crowdSound)
		end
		tbl.crowdSound = playSound3D("files/sound/crowd.mp3", x, y, z + tableHeight, true)
		setElementInterior(tbl.crowdSound, tbl.int)
		setElementDimension(tbl.crowdSound, tbl.dim)
		setSoundMaxDistance(tbl.crowdSound, 14)
		setSoundVolume(tbl.crowdSound, 0)
		if isElement(tbl.themeSound) then
			destroyElement(tbl.themeSound)
		end
		tbl.themeSound = false
		tbl.finishFlag = false
		for i = 1, horseNum do
			tbl.horses[tbl.place[i]].place = i
		end
		for i = 1, horseNum do
			tbl.horses[i].pos = false
			tbl.horses[i].velocity = 0
			tbl.horses[i].finished = tbl.matchStart + tbl.finishTime[i] * 1000
			tbl.horses[i].ended = false
			tbl.horses[i].canFinish = false
			if isElement(tbl.horses[i].sound) then
				destroyElement(tbl.horses[i].sound)
			end
			tbl.horses[i].sound = playSound3D("files/sound/galop.mp3", x, y, z, true)
			setElementDimension(tbl.horses[i].sound, tbl.dim)
			setElementInterior(tbl.horses[i].sound, tbl.int)
			attachElements(tbl.horses[i].sound, tbl.horses[i].obj)
			setSoundMinDistance(tbl.horses[i].sound, 1.35)
			setSoundMaxDistance(tbl.horses[i].sound, 14)
			setSoundVolume(tbl.horses[i].sound, 0)
			setSoundPosition(tbl.horses[i].sound, math.random() * 13)
			if now >= tbl.horses[i].finished then
				tbl.live[i] = {
					i,
					(horseNum - tbl.horses[i].place + 1) * 10
				}
			else
				tbl.live[i] = {i, 0}
			end
			table.sort(tbl.live, sortByPlace)
			if not tbl.firstFinish or tbl.horses[i].finished < tbl.firstFinish then
				tbl.firstFinish = tbl.horses[i].finished
			end
		end
		tbl.firstFinish = tbl.firstFinish - 100
		if now >= tbl.firstFinish then
			tbl.cheered = false
		end
		tbl.matchDelta = now - tbl.matchStart
		tbl.matchGoHomeP = math.min(1, (tbl.matchDelta - tbl.matchTime) / (goHomeTime * 1000))
		if 0 <= tbl.matchGoHomeP and not tbl.endStarted then
			tbl.refreshMiniScreen = true
			tbl.endStarted = true
			tbl.themeSound = playSound3D("files/sound/horsetheme" .. tbl.theme .. ".mp3", x, y, z + tableHeight, true)
			setElementInterior(tbl.themeSound, tbl.int)
			setElementDimension(tbl.themeSound, tbl.dim)
			setSoundMaxDistance(tbl.themeSound, 14)
			setSoundPosition(tbl.themeSound, (tbl.matchDelta - tbl.matchTime) / 1000)
		end
	end
end)
function drawLedRT(tbl)
	dxSetRenderTarget(tbl.ledRt, true)
	dxSetBlendMode("modulate_add")
	local now = getTickCount()
	sightlangStaticImageUsed[0] = true
	if sightlangStaticImageToc[0] then
		processSightlangStaticImage[0]()
	end
	dxDrawImage(0, 20, 172, 90, sightlangStaticImage[0])
	if tbl.betting then
		if tbl.countdownTime and tbl.countdownTime <= 10 then
			dxDrawRectangle(0, 0, 172, 20, tocolor(0, 163, 229, 50))
			dxDrawRectangle(0, 110, 172, 170, tocolor(0, 163, 229, 50))
			if 0 < tbl.countdownTime then
				local delta = now - tbl.countdown
				local a = 1 - delta % 1000 / 1000
				dxDrawRectangle(0, 0, 172, 20, tocolor(221, 97, 90, 255 * a))
				dxDrawRectangle(0, 110, 172, 170, tocolor(221, 97, 90, 255 * a))
			end
		else
			local a = 1
			local w = 14.333333333333334
			dxDrawRectangle(0, 0, 172, 20, tocolor(0, 163, 229, 50))
			sightlangStaticImageUsed[1] = true
			if sightlangStaticImageToc[1] then
				processSightlangStaticImage[1]()
			end
			dxDrawImageSection(0, 0, 172, 20, 170 * (now / 3900 - 0.1), 0, 170, 10, sightlangStaticImage[1], 0, 0, 0, tocolor(0, 163, 229, 255 * a))
			for i = 1, seats + 2 do
				local p = math.max(0, 1 - (now - 325 * i) % 3900 / 1100) * a
				if 0.5 < p then
					p = (1 - p) * 2
				else
					p = p * 2
				end
				local a = 205 * p
				dxDrawRectangle((i - 1) * w, 110, w, 17, tocolor(0, 163, 229, 50 + a))
			end
		end
	else
		local a = 1
		local ended = false
		if 0 > tbl.matchDelta then
			a = (tbl.matchDelta + 8000) / 3000
			if 1 < a then
				a = 1
			end
		else
			local ef = 1 - goHomeEndFade
			if ef < tbl.matchGoHomeP then
				a = math.max(0, 1 - (tbl.matchGoHomeP - ef) / goHomeEndFade)
			end
			ended = tbl.matchGoHomeP and 0 < tbl.matchGoHomeP
		end
		local w = 14.333333333333334
		if ended then
			local p = 1 - now % 800 / 800
			local p2 = now % 1600 / 1600
			dxDrawRectangle(0, 0, 172, 20, tocolor(0, 163, 229, 50 + 205 * p))
			dxDrawRectangle(seats * w, 110, w * 2, 170, tocolor(0, 163, 229, 50 + 205 * p))
			dxDrawRectangle(0, 110, seats * w, 170, tocolor(0, 163, 229, 50))
			for i = 1, seats do
				if tbl.winCount[i] then
					dxDrawRectangle((i - 1) * w, 110, w, 17, tocolor(92, 161, 106, 50 + 205 * p))
					sightlangStaticImageUsed[2] = true
					if sightlangStaticImageToc[2] then
						processSightlangStaticImage[2]()
					end
					dxDrawImageSection(math.floor((i - 1) / 5) * 86, 20 + (i - 1) % 5 * 18, 86, 18, 0, 18 * p, 86, 18, sightlangStaticImage[2])
				elseif tbl.loseCount[i] then
					dxDrawRectangle((i - 1) * w, 110, w, 17, tocolor(221, 97, 90, 50 + 205 * p))
					sightlangStaticImageUsed[3] = true
					if sightlangStaticImageToc[3] then
						processSightlangStaticImage[3]()
					end
					dxDrawImageSection(math.floor((i - 1) / 5) * 86, 20 + (i - 1) % 5 * 18, 86, 18, 0, 18 * p, 86, 18, sightlangStaticImage[3])
				end
			end
		else
			local p = now % 3000 / 3000
			sightlangStaticImageUsed[4] = true
			if sightlangStaticImageToc[4] then
				processSightlangStaticImage[4]()
			end
			dxDrawImageSection(0, 20, 172, 90, 172 * p, 0, 172, 90, sightlangStaticImage[4], 0, 0, 0, tocolor(255, 255, 255, 255 * a))
			if 0.5 < p then
				p = 1 - p
			end
			p = p * 2
			p = getEasingValue(p, "InOutQuad")
			for i = 1, seats do
				local a = 205 * (i % 2 == 1 and p or 1 - p) * a
				dxDrawRectangle((i - 1) * w, 110, w, 17, tocolor(0, 163, 229, 50 + a))
			end
			dxDrawRectangle(seats * w, 110, w * 2, 17, tocolor(0, 163, 229, 50 + 205 * p * a))
			dxDrawRectangle(0, 0, 172, 10, tocolor(0, 163, 229, 50 + 205 * p * a))
			dxDrawRectangle(0, 10, 172, 10, tocolor(0, 163, 229, 50 + 205 * (1 - p) * a))
		end
	end
	dxSetBlendMode("blend")
	dxSetRenderTarget()
end
function drawBigScreen(tbl)
	dxSetRenderTarget(tbl.bigRt, true)
	dxSetBlendMode("modulate_add")
	dxDrawRectangle(0, 0, 342, 256, tocolor(0, 0, 0))
	local newA = 255
	if tbl.newAnimationDelta and tbl.oldBg then
		newA = 255 * math.min(1, tbl.newAnimationDelta / 1000)
		dxDrawImage(0, 0, 342, 256, dynamicImage("files/bg/" .. tbl.bg .. ".dds"))
		dxDrawImage(0, 0, 342, 256, dynamicImage("files/bg/" .. tbl.oldBg .. ".dds"), 0, 0, 0, tocolor(255, 255, 255, 255 - newA))
	else
		dxDrawImage(0, 0, 342, 256, dynamicImage("files/bg/" .. (tbl.bg or 1) .. ".dds"))
	end
	local ih = 48
	local h = 256 / horseNum
	if tbl.betting then
		sightlangStaticImageUsed[5] = true
		if sightlangStaticImageToc[5] then
			processSightlangStaticImage[5]()
		end
		dxDrawImage(0, -80, 342, 256, sightlangStaticImage[5])
		local y = h * 3.8499999999999996 - ih / 2
		sightlangStaticImageUsed[6] = true
		if sightlangStaticImageToc[6] then
			processSightlangStaticImage[6]()
		end
		dxDrawImage(0, (48 + y + ih / 2) / 2 - 16, 342, 32, sightlangStaticImage[6], 0, 0, 0, tocolor(255, 255, 255, newA))
		dxDrawText(cupNames[tbl.cupName], 0, 48, 342, y + ih / 2, tocolor(230, 180, 0, newA), cupFontScale, cupFont, "center", "center")
		if tbl.countdownTime then
			if 0 >= tbl.countdownTime then
				sightlangStaticImageUsed[6] = true
				if sightlangStaticImageToc[6] then
					processSightlangStaticImage[6]()
				end
				dxDrawImage(0, 176, 342, 24, sightlangStaticImage[6], 0, 0, 0, tocolor(255, 255, 255, 255))
				dxDrawText("Köszönöm, nincs több tét!", 0, 188, 342, 188, tocolor(255, 255, 255, 255), cupFontScale * 0.75, cupFont, "center", "center")
			else
				sightlangStaticImageUsed[7] = true
				if sightlangStaticImageToc[7] then
					processSightlangStaticImage[7]()
				end
				dxDrawImage(131, 148, 80, 80, sightlangStaticImage[7], 0, 0, 0, tocolor(90, 90, 90, 200))
				dxDrawText(tbl.countdownTime .. "s", 0, 148, 342, 228, tocolor(245, 95, 95), cupFontScale * 1.25, cupFont, "center", "center")
				for i = 1, 60 do
					local c = tocolor(180, 180, 180)
					if i <= tbl.countdownTime then
						c = tocolor(245, 95, 95)
					end
					sightlangStaticImageUsed[8] = true
					if sightlangStaticImageToc[8] then
						processSightlangStaticImage[8]()
					end
					dxDrawImage(131, 148, 80, 80, sightlangStaticImage[8], 6 * i, 0, 0, c)
				end
			end
		else
			sightlangStaticImageUsed[6] = true
			if sightlangStaticImageToc[6] then
				processSightlangStaticImage[6]()
			end
			dxDrawImage(0, 176, 342, 24, sightlangStaticImage[6], 0, 0, 0, tocolor(255, 255, 255, newA))
			dxDrawText("Kérem tegyék meg tétjeiket!", 0, 188, 342, 188, tocolor(255, 255, 255, newA), cupFontScale * 0.75, cupFont, "center", "center")
		end
	else
		local p = (tbl.matchDelta + 8000) / 3000
		local ended = 0 < tbl.matchGoHomeP
		if 1 < p then
			if ended then
				p = 1 - math.min(1, math.max(0, tbl.matchGoHomeP / (goHomeEndFade * 2)))
				if p < 1 then
					p = getEasingValue(p, "InOutQuad")
				end
			else
				p = 1
			end
			if 0 < p then
				sightlangStaticImageUsed[9] = true
				if sightlangStaticImageToc[9] then
					processSightlangStaticImage[9]()
				end
				dxDrawImageSection(0, 0, 342, 256, 342 * tbl.livebg, 0, 342, 256, sightlangStaticImage[9], 0, 0, 0, tocolor(255, 255, 255, 255 * p))
			end
		else
			p = getEasingValue(p, "InOutQuad")
			sightlangStaticImageUsed[9] = true
			if sightlangStaticImageToc[9] then
				processSightlangStaticImage[9]()
			end
			dxDrawImage(0, 0, 342, 256, sightlangStaticImage[9], 0, 0, 0, tocolor(255, 255, 255, 255 * p))
			local y = h * 3.8499999999999996 - ih / 2
			sightlangStaticImageUsed[6] = true
			if sightlangStaticImageToc[6] then
				processSightlangStaticImage[6]()
			end
			dxDrawImage(0, (48 + y + ih / 2) / 2 - 16, 342, 32, sightlangStaticImage[6], 0, 0, 0, tocolor(255, 255, 255, 255 * (1 - p)))
			dxDrawText(cupNames[tbl.cupName], 0, 48, 342, y + ih / 2, tocolor(230, 180, 0, 255 * (1 - p)), cupFontScale, cupFont, "center", "center")
			sightlangStaticImageUsed[6] = true
			if sightlangStaticImageToc[6] then
				processSightlangStaticImage[6]()
			end
			dxDrawImage(0, 176, 342, 24, sightlangStaticImage[6], 0, 0, 0, tocolor(255, 255, 255, 255 * (1 - p)))
			dxDrawText("Köszönöm, nincs több tét!", 0, 188, 342, 188, tocolor(255, 255, 255, 255 * (1 - p)), cupFontScale * 0.75, cupFont, "center", "center")
		end
		sightlangStaticImageUsed[5] = true
		if sightlangStaticImageToc[5] then
			processSightlangStaticImage[5]()
		end
		dxDrawImage(0, -80 * (1 - p), 342, 256, sightlangStaticImage[5], 0, 0, 0, tocolor(255, 255, 255, 255 - 130 * p))
		if ended then
			local ea = 255
			local wh = tocolor(255, 255, 255)
			local ef = 1 - goHomeEndFade
			if ef < tbl.matchGoHomeP then
				ea = math.max(0, (1 - (tbl.matchGoHomeP - ef) / goHomeEndFade) * 255)
				wh = tocolor(255, 255, 255, ea)
			end
			p2 = math.min(1, math.max(0, (tbl.matchGoHomeP - goHomeEndFade * 2) / (goHomeEndFade * 4)))
			if 1 > p2 then
				p2 = getEasingValue(p2, "OutQuad")
			end
			if 0 < p2 then
				local y = h * (4.35 + (1 - p2)) - ih / 2
				local a = math.min(1, p2 * 3)
				sightlangStaticImageUsed[6] = true
				if sightlangStaticImageToc[6] then
					processSightlangStaticImage[6]()
				end
				dxDrawImage(0, (48 + y + ih / 2) / 2 - 16, 342, 32, sightlangStaticImage[6], 0, 0, 0, tocolor(255, 255, 255, ea * a))
				dxDrawText((cupNames[tbl.cupName] or "false"), 0, 48, 342, y + ih / 2, tocolor(230, 180, 0, ea * a), cupFontScale, cupFont, "center", "center")
			end
			for i = 3, 1, -1 do
				local horse = tbl.live[i][1]
				local x = 135
				if i == 2 then
					x = x - 97.2 * (1 - p)
				elseif i == 3 then
					x = x + 97.2 * (1 - p)
				end
				local y = h * (5 + (i - 0.5 - 5) * p)
				if 0 < p2 then
					y = y - h * ((3 - i) * 0.3 + 0.3) * p2
				end
				sightlangStaticImageUsed[10] = true
				if sightlangStaticImageToc[10] then
					processSightlangStaticImage[10]()
				end
				dxDrawImage(x, y - 24, 72, 48, sightlangStaticImage[10], 0, 0, 0, wh)
				sightlangStaticImageUsed[11] = true
				if sightlangStaticImageToc[11] then
					processSightlangStaticImage[11]()
				end
				dxDrawImage(x, y - 24, 72, 48, sightlangStaticImage[11], 0, 0, 0, wh)
				dxDrawImage(x, y - 24, 72, 48, dynamicImage("files/horses/" .. horse .. ".dds"), 0, 0, 0, wh)
				local bx = x + 7
				local by = y - 7
				sightlangStaticImageUsed[12] = true
				if sightlangStaticImageToc[12] then
					processSightlangStaticImage[12]()
				end
				dxDrawImage(bx, by - 24, 72, 48, sightlangStaticImage[12], 0, 0, 0, tocolor(horseColors[horse][1], horseColors[horse][2], horseColors[horse][3], ea))
				dxDrawText(horse, bx + 7.92, by - 24 + 23.04, bx + 23.04, by - 24 + 37.92, tocolor(26, 27, 31, ea), numberFontScale * 0.9, numberFont, "center", "center")
				if i == 1 then
					sightlangStaticImageUsed[13] = true
					if sightlangStaticImageToc[13] then
						processSightlangStaticImage[13]()
					end
					dxDrawImage(x, y - 24, 72, 48, sightlangStaticImage[13], 0, 0, 0, tocolor(255, 200, 0, ea))
					if 0 < p2 then
						sightlangStaticImageUsed[14] = true
						if sightlangStaticImageToc[14] then
							processSightlangStaticImage[14]()
						end
						dxDrawImage(x, y + 20 + 20 * (1 - p2), 72, 90, sightlangStaticImage[14], 0, 0, 0, tocolor(191.25, 150, 0, ea))
					end
				elseif i == 2 then
					sightlangStaticImageUsed[13] = true
					if sightlangStaticImageToc[13] then
						processSightlangStaticImage[13]()
					end
					dxDrawImage(x, y - 24, 72, 48, sightlangStaticImage[13], 0, 0, 0, tocolor(255, 255, 255, ea))
					if 0 < p2 then
						sightlangStaticImageUsed[14] = true
						if sightlangStaticImageToc[14] then
							processSightlangStaticImage[14]()
						end
						dxDrawImage(x, y + 20 + 20 * (1 - p2), 72, 90, sightlangStaticImage[14], 0, 0, 0, tocolor(191.25, 191.25, 191.25, ea))
					end
				elseif i == 3 then
					sightlangStaticImageUsed[13] = true
					if sightlangStaticImageToc[13] then
						processSightlangStaticImage[13]()
					end
					dxDrawImage(x, y - 24, 72, 48, sightlangStaticImage[13], 0, 0, 0, tocolor(220, 128, 60, ea))
					if 0 < p2 then
						sightlangStaticImageUsed[14] = true
						if sightlangStaticImageToc[14] then
							processSightlangStaticImage[14]()
						end
						dxDrawImage(x, y + 20 + 20 * (1 - p2), 72, 90, sightlangStaticImage[14], 0, 0, 0, tocolor(165, 96, 45, ea))
					end
				end
				if 0 < p2 then
					sightlangStaticImageUsed[15] = true
					if sightlangStaticImageToc[15] then
						processSightlangStaticImage[15]()
					end
					dxDrawImage(x, y + 20 + 20 * (1 - p2), 72, 90, sightlangStaticImage[15], 0, 0, 0, tocolor(255, 255, 255, ea))
				end
			end
			if 0 < p then
				for i = 4, horseNum do
					local horse = tbl.live[i][1]
					local x = 135
					local y = h * (i - 0.5 + 3 * (1 - p))
					sightlangStaticImageUsed[10] = true
					if sightlangStaticImageToc[10] then
						processSightlangStaticImage[10]()
					end
					dxDrawImage(x, y - 24, 72, 48, sightlangStaticImage[10])
					sightlangStaticImageUsed[11] = true
					if sightlangStaticImageToc[11] then
						processSightlangStaticImage[11]()
					end
					dxDrawImage(x, y - 24, 72, 48, sightlangStaticImage[11])
					dxDrawImage(x, y - 24, 72, 48, dynamicImage("files/horses/" .. horse .. ".dds"))
					sightlangStaticImageUsed[12] = true
					if sightlangStaticImageToc[12] then
						processSightlangStaticImage[12]()
					end
					dxDrawImage(x, y - 24, 72, 48, sightlangStaticImage[12], 0, 0, 0, horseColors[horse][4])
					dxDrawText(horse, x + 7.92, y - 24 + 23.04, x + 23.04, y - 24 + 37.92, tocolor(26, 27, 31), numberFontScale * 0.9, numberFont, "center", "center")
				end
			end
		else
			for i = #tbl.live, 1, -1 do
				local horse = tbl.live[i][1]
				local w = 270
				local x = 0
				local y = h * (tbl.liveY[horse] - 0.5)
				local now = getTickCount()
				local finished = now - tbl.horses[horse].finished
				local ep = 0
				if 0 <= finished then
					ep = finished / 1000
					if ep < 1 then
						ep = getEasingValue(ep, "OutQuad")
					else
						ep = 1
					end
					x = w + -135 * ep
					sightlangStaticImageUsed[16] = true
					if sightlangStaticImageToc[16] then
						processSightlangStaticImage[16]()
					end
					dxDrawImageSection(0, y - 24, x + 24, 48, 0, 0, 2.6666666666666665 * (x + 24), 128, sightlangStaticImage[16], 0, 0, 0, tocolor(horseColors[horse][1], horseColors[horse][2], horseColors[horse][3], 255 * (1 - ep)))
					sightlangStaticImageUsed[17] = true
					if sightlangStaticImageToc[17] then
						processSightlangStaticImage[17]()
					end
					dxDrawImageSection(0, y - 24, x + 24, 48, 0, 0, 2.6666666666666665 * (x + 24), 128, sightlangStaticImage[17], 0, 0, 0, tocolor(255, 255, 255, 255 * (1 - ep)))
				elseif p < 1 then
					x = -72 * (1 - p)
				else
					x = w * math.min(1, tbl.live[i][2])
					sightlangStaticImageUsed[16] = true
					if sightlangStaticImageToc[16] then
						processSightlangStaticImage[16]()
					end
					dxDrawImageSection(0, y - 24, x + 24, 48, 0, 0, 2.6666666666666665 * (x + 24), 128, sightlangStaticImage[16], 0, 0, 0, horseColors[horse][4])
					sightlangStaticImageUsed[17] = true
					if sightlangStaticImageToc[17] then
						processSightlangStaticImage[17]()
					end
					dxDrawImageSection(0, y - 24, x + 24, 48, 0, 0, 2.6666666666666665 * (x + 24), 128, sightlangStaticImage[17])
				end
				sightlangStaticImageUsed[10] = true
				if sightlangStaticImageToc[10] then
					processSightlangStaticImage[10]()
				end
				dxDrawImage(x, y - 24, 72, 48, sightlangStaticImage[10])
				sightlangStaticImageUsed[11] = true
				if sightlangStaticImageToc[11] then
					processSightlangStaticImage[11]()
				end
				dxDrawImage(x, y - 24, 72, 48, sightlangStaticImage[11])
				dxDrawImage(x, y - 24, 72, 48, dynamicImage("files/horses/" .. horse .. ".dds"))
				if i <= 3 then
					local bx = x + 7 * ep
					local by = y - 7 * ep
					sightlangStaticImageUsed[12] = true
					if sightlangStaticImageToc[12] then
						processSightlangStaticImage[12]()
					end
					dxDrawImage(bx, by - 24, 72, 48, sightlangStaticImage[12], 0, 0, 0, horseColors[horse][4])
					dxDrawText(horse, bx + 7.92, by - 24 + 23.04, bx + 23.04, by - 24 + 37.92, tocolor(26, 27, 31), numberFontScale * 0.9, numberFont, "center", "center")
					if 0 < ep then
						if i == 1 then
							sightlangStaticImageUsed[13] = true
							if sightlangStaticImageToc[13] then
								processSightlangStaticImage[13]()
							end
							dxDrawImage(x, y - 24, 72, 48, sightlangStaticImage[13], 0, 0, 0, tocolor(255, 200, 0, 255 * ep))
						elseif i == 2 then
							sightlangStaticImageUsed[13] = true
							if sightlangStaticImageToc[13] then
								processSightlangStaticImage[13]()
							end
							dxDrawImage(x, y - 24, 72, 48, sightlangStaticImage[13], 0, 0, 0, tocolor(255, 255, 255, 255 * ep))
						elseif i == 3 then
							sightlangStaticImageUsed[13] = true
							if sightlangStaticImageToc[13] then
								processSightlangStaticImage[13]()
							end
							dxDrawImage(x, y - 24, 72, 48, sightlangStaticImage[13], 0, 0, 0, tocolor(220, 128, 60, 255 * ep))
						end
					end
				else
					sightlangStaticImageUsed[12] = true
					if sightlangStaticImageToc[12] then
						processSightlangStaticImage[12]()
					end
					dxDrawImage(x, y - 24, 72, 48, sightlangStaticImage[12], 0, 0, 0, horseColors[horse][4])
					dxDrawText(horse, x + 7.92, y - 24 + 23.04, x + 23.04, y - 24 + 37.92, tocolor(26, 27, 31), numberFontScale * 0.9, numberFont, "center", "center")
				end
			end
		end
	end
	dxSetRenderTarget(tbl.miniRt)
	dxSetBlendMode("modulate_add")
	local r = 0.166015625
	dxDrawImage(680 * r, 120 * r, 328 * r, 246 * r, tbl.bigRt)
	sightlangStaticImageUsed[18] = true
	if sightlangStaticImageToc[18] then
		processSightlangStaticImage[18]()
	end
	dxDrawImage(678 * r, 118 * r, 332 * r, 250 * r, sightlangStaticImage[18])
	dxSetBlendMode("blend")
	dxSetRenderTarget()
end
function drawMiniScreen(tbl)
	dxSetRenderTarget(tbl.miniRt, true)
	dxSetBlendMode("modulate_add")
	local r = 0.166015625
	dxDrawRectangle(0, 0, 170, 129, tocolor(0, 0, 0))
	if tbl.matchGoHomeP and 0 <= tbl.matchGoHomeP then
		dxDrawImage(6 * r, 6 * r, 170 - 12 * r, 129 - 12 * r, dynamicImage("files/bg/" .. (tbl.bg or 1) .. ".dds"))
		sightlangStaticImageUsed[19] = true
		if sightlangStaticImageToc[19] then
			processSightlangStaticImage[19]()
		end
		dxDrawImage(0, 0, 170, 129, sightlangStaticImage[19])
		for i = 1, 6 do
			dxDrawImage(0, 0, 170, 129, dynamicImage("files/mini/h" .. i .. ".dds"), 0, 0, 0, tocolor(255, 255, 255, 125))
			if tbl.winner == i then
				dxDrawImage(0, 0, 170, 129, dynamicImage("files/mini/h" .. i .. "2.dds"), 0, 0, 0, tocolor(255, 255, 255, 255))
			end
			for j = 1, i - 1 do
				local a = tbl.quinellaA == i and tbl.quinellaB == j and 130 or 0
				dxDrawImage(0, 0, 170, 129, dynamicImage("files/mini/q" .. j .. i .. ".dds"), 0, 0, 0, tocolor(255, 255, 255, 125 + a))
			end
		end
		local h = 550 / horseNum * r
		local x = (512 - 128 * (2.15 + 0.85 * (horseNum - 1) + 1) / 2) * r
		sightlangStaticImageUsed[20] = true
		if sightlangStaticImageToc[20] then
			processSightlangStaticImage[20]()
		end
		dxDrawImage(x, 130 * r + h * (tbl.winner - 0.5) - 64 * r, 272 * r, 128 * r, sightlangStaticImage[20], 0, 0, 0, tocolor(255, 255, 255, 255))
		sightlangStaticImageUsed[21] = true
		if sightlangStaticImageToc[21] then
			processSightlangStaticImage[21]()
		end
		dxDrawImage(x + (275.2 + (tbl.quinellaB - 1) * 128 * 0.85) * r, 130 * r + h * (tbl.quinellaA - 0.5) - 64 * r, 128 * r, 128 * r, sightlangStaticImage[21], 0, 0, 0, tocolor(255, 255, 255, 255))
	elseif tbl.newAnimationDelta then
		local newAnimDelta = tbl.newAnimationDelta
		local a = 1 - math.min(1, newAnimDelta / 1000)
		dxDrawImage(6 * r, 6 * r, 170 - 12 * r, 129 - 12 * r, dynamicImage("files/bg/" .. (tbl.bg or 1) .. ".dds"))
		if tbl.oldBg then
			dxDrawImage(6 * r, 6 * r, 170 - 12 * r, 129 - 12 * r, dynamicImage("files/bg/" .. tbl.oldBg .. ".dds"), 0, 0, 0, tocolor(255, 255, 255, 255 * a))
		end
		sightlangStaticImageUsed[19] = true
		if sightlangStaticImageToc[19] then
			processSightlangStaticImage[19]()
		end
		dxDrawImage(0, 0, 170, 129, sightlangStaticImage[19], 0, 0, 0)
		for i = 1, 6 do
			local p = math.min(1, math.max(0, newAnimDelta / 190))
			newAnimDelta = newAnimDelta - 150
			dxDrawImage(0, 0, 170, 129, dynamicImage("files/mini/h" .. i .. ".dds"), 0, 0, 0, tocolor(255, 255, 255, 125 + 130 * p))
			for j = 1, i - 1 do
				local p = math.min(1, math.max(0, newAnimDelta / 190))
				newAnimDelta = newAnimDelta - 150
				dxDrawImage(0, 0, 170, 129, dynamicImage("files/mini/q" .. j .. i .. ".dds"), 0, 0, 0, tocolor(255, 255, 255, 125 + 130 * p))
			end
		end
	else
		dxDrawImage(6 * r, 6 * r, 170 - 12 * r, 129 - 12 * r, dynamicImage("files/bg/" .. (tbl.bg or 1) .. ".dds"))
		sightlangStaticImageUsed[19] = true
		if sightlangStaticImageToc[19] then
			processSightlangStaticImage[19]()
		end
		dxDrawImage(0, 0, 170, 129, sightlangStaticImage[19])
		sightlangStaticImageUsed[22] = true
		if sightlangStaticImageToc[22] then
			processSightlangStaticImage[22]()
		end
		dxDrawImage(0, 0, 170, 129, sightlangStaticImage[22])
	end
	if tbl.betting then
		if tbl.countdownTime then
			if 0 < tbl.countdownTime then
				dxDrawText(tbl.countdownTime .. "s", 0, 64 * r, 1008 * r, 104 * r, tocolor(245, 95, 95), 1.425 * r * cupFontScale, cupFont, "right", "center")
				dxDrawText("Kérem tegyék meg tétjeiket!", 680 * r, 64 * r, 992 * r, 104 * r, tocolor(255, 255, 255), 1.175 * r * helpFontScale, helpFont, "center", "center")
			else
				dxDrawText("Köszönöm, nincs több tét!", 680 * r, 64 * r, 992 * r, 104 * r, tocolor(255, 255, 255), 1.175 * r * helpFontScale, helpFont, "center", "center")
			end
		else
			dxDrawText("Kérem tegyék meg tétjeiket!", 680 * r, 64 * r, 992 * r, 104 * r, tocolor(255, 255, 255), 1.175 * r * helpFontScale, helpFont, "center", "center")
		end
	elseif tbl.matchGoHomeP and 0 < tbl.matchGoHomeP then
		dxDrawText("Játék vége, eredményhirdetés", 680 * r, 64 * r, 992 * r, 104 * r, tocolor(255, 255, 255), 1.175 * r * helpFontScale, helpFont, "center", "center")
	else
		dxDrawText("Sok szerencsét!", 680 * r, 64 * r, 992 * r, 104 * r, tocolor(255, 255, 255), 1.175 * r * helpFontScale, helpFont, "center", "center")
	end
	if tbl.countdownTime and tbl.countdownTime <= 10 and 0 < tbl.countdownTime then
		sightlangStaticImageUsed[23] = true
		if sightlangStaticImageToc[23] then
			processSightlangStaticImage[23]()
		end
		dxDrawImage(6 * r, 6 * r, 1012 * r, 756 * r, sightlangStaticImage[23], 0, 0, 0, tocolor(245, 95, 95, 125))
	end
	dxDrawImage(680 * r, 120 * r, 328 * r, 246 * r, tbl.bigRt)
	sightlangStaticImageUsed[18] = true
	if sightlangStaticImageToc[18] then
		processSightlangStaticImage[18]()
	end
	dxDrawImage(678 * r, 118 * r, 332 * r, 250 * r, sightlangStaticImage[18])
	dxSetBlendMode("blend")
	dxSetRenderTarget()
end
local historyButtons = {}
function deleteWindow()
	if bigWindow then
		seexports.sGui:deleteGuiElement(bigWindow)
	end
	bigWindow = false
	if smallWindow then
		smallX, smallY = seexports.sGui:getGuiPosition(smallWindow)
		seexports.sGui:deleteGuiElement(smallWindow)
	end
	smallWindow = false
	bigPreview = false
	guiButtons = {}
	coinButtons = {}
	guiHovers = {}
	betButtons = {}
	historyButtons = {}
	for i = 1, horseNum do
		sideButtons[i] = {}
	end
end
function processOddsTooltip(i)
	local tbl = horseTables[myTable]
	if bigWindow then
		local text = false
		if not tbl.newAnimationDelta and (not tbl.matchGoHomeP or tbl.matchGoHomeP < 0) then
			text = "Győztes: " .. horseColors[i][5] .. i .. "#ffffff (" .. (tbl.odds[i] or 1) .. "x)\n"
			if tbl.bets[mySeat][i] and tbl.bets[mySeat][i] > 0 then
				text = text .. "Tét: " .. hexColors.sightgreen .. seexports.sGui:thousandsStepper(tbl.bets[mySeat][i]) .. " SSC"
			elseif tbl.betting and (not tbl.countdownTime or 0 < tbl.countdownTime) then
				text = text .. "Minimum tét: " .. hexColors.sightgreen .. seexports.sGui:thousandsStepper(minBet) .. " SSC"
			end
			if tbl.betting and (not tbl.countdownTime or 0 < tbl.countdownTime) then
				text = text .. "\n" .. hexColors.sightgreen .. "+" .. coinValues[currentCoin] .. " SSC#ffffff - " .. hexColors.sightblue .. "Bal egérgomb\n" .. hexColors.sightred .. "-" .. coinValues[currentCoin] .. " SSC#ffffff - " .. hexColors.sightblue .. "Jobb egérgomb"
			end
			seexports.sGui:setGuiHoverable(betButtons[i], true)
		else
			seexports.sGui:setGuiHoverable(betButtons[i], false)
		end
		seexports.sGui:guiSetTooltip(betButtons[i], text)
	end
end
function processSideOddsTooltip(i, j)
	local tbl = horseTables[myTable]
	if bigWindow then
		local text = false
		if not tbl.newAnimationDelta and (not tbl.matchGoHomeP or tbl.matchGoHomeP < 0) then
			text = "Quinella: " .. horseColors[j][5] .. j .. "#ffffff - " .. horseColors[i][5] .. i .. "#ffffff (" .. (tbl.sideOdds[i][j] or 1) .. "x)\n"
			if tbl.sideBets[mySeat][i][j] and tbl.sideBets[mySeat][i][j] > 0 then
				text = text .. "Tét: " .. hexColors.sightgreen .. seexports.sGui:thousandsStepper(tbl.sideBets[mySeat][i][j]) .. " SSC"
			elseif tbl.betting and (not tbl.countdownTime or 0 < tbl.countdownTime) then
				text = text .. "Minimum tét: " .. hexColors.sightgreen .. seexports.sGui:thousandsStepper(minBetSide) .. " SSC"
			end
			if tbl.betting and (not tbl.countdownTime or 0 < tbl.countdownTime) then
				text = text .. "\n" .. hexColors.sightgreen .. "+" .. coinValues[currentCoin] .. " SSC#ffffff - " .. hexColors.sightblue .. "Bal egérgomb\n" .. hexColors.sightred .. "-" .. coinValues[currentCoin] .. " SSC#ffffff - " .. hexColors.sightblue .. "Jobb egérgomb"
			end
			seexports.sGui:setGuiHoverable(sideButtons[i][j], true)
		else
			seexports.sGui:setGuiHoverable(sideButtons[i][j], false)
		end
		seexports.sGui:guiSetTooltip(sideButtons[i][j], text)
	end
end
function refreshHistoryTooltip()
	local tbl = horseTables[myTable]
	local c = 1
	for i = #tbl.history, 1, -1 do
		local w = tbl.history[i][2]
		local r = tbl.history[i][3]
		local text = "#e2b40b" .. cupNames[tbl.history[i][1]] .. "\n"
		text = text .. "#ffffffElső helyezett: " .. horseColors[w][5] .. w .. "#ffffff (" .. horseNames[tbl.history[i][4]] .. "), " .. floorOdds(tbl.history[i][6]) .. "x\n"
		text = text .. "Második helyezett:  " .. horseColors[r][5] .. r .. "#ffffff (" .. horseNames[tbl.history[i][5]] .. ")\n"
		local a = math.max(w, r)
		local b = math.min(w, r)
		text = text .. "Quinella: " .. horseColors[b][5] .. b .. "#ffffff - " .. horseColors[a][5] .. a .. "#ffffff, " .. floorOdds(tbl.history[i][7]) .. "x"
		seexports.sGui:guiSetTooltip(historyButtons[c], text)
		seexports.sGui:setGuiHoverable(historyButtons[c], true)
		c = c + 1
	end
end
function createWindow(big)
	deleteWindow()
	titleBarHeight = seexports.sGui:getTitleBarHeight()
	local pw, ph, x, y
	if big then
		pw, ph = 1024, titleBarHeight
		x, y = bigX or screenX / 2 - pw / 2, bigY or screenY / 2 - (768 + titleBarHeight) / 2
		if not bigX then
			bigX, bigY = x, y
		end
	else
		pw, ph = 332, 250 + titleBarHeight
		x, y = smallX or screenX / 2 - pw / 2, smallY or math.floor(screenY * 0.75) - ph / 2
	end
	local window = seexports.sGui:createGuiElement("window", x, y, pw, ph)
	seexports.sGui:setWindowTitle(window, "16/BebasNeueRegular.otf", "Horsee")
	if big then
		seexports.sGui:setWindowCloseButton(window, "tryToExitHorsee")
		seexports.sGui:setWindowMoveEvent(window, "moveHorseeWindow")
		local image = seexports.sGui:createGuiElement("image", pw - titleBarHeight * 2, 0, titleBarHeight, titleBarHeight, window)
		seexports.sGui:setImageFile(image, seexports.sGui:getFaIconFilename("compress-alt", titleBarHeight))
		seexports.sGui:setGuiHoverable(image, true)
		seexports.sGui:setGuiHover(image, "solid", "sightgreen")
		seexports.sGui:setClickEvent(image, "toggleHorseeWindow")
		bigWindow = window
		local w = 50.6
		local x = w / 2 - 9
		local y = titleBarHeight + 6 + 29 - 14 - 9
		for i = 1, 20 do
			local btn = seexports.sGui:createGuiElement("rectangle", x, y, 18, 47, window)
			seexports.sGui:setGuiHover(btn, "none", false, false, true)
			historyButtons[i] = btn
			x = x + w
		end
		refreshHistoryTooltip()
		local x = 512 - 128 * (2.15 + 0.85 * (horseNum - 1) + 1) / 2
		local y = titleBarHeight + 120
		local h = 550 / horseNum
		local w3 = 275.2
		local w4 = 108.8
		local transp = {
			0,
			0,
			0,
			0
		}
		for i = 1, horseNum do
			local btn = seexports.sGui:createGuiElement("rectangle", x + 134 + 42, y + h / 2 - 39, 77, 78, window)
			seexports.sGui:setGuiHover(btn, "none", false, false, true)
			seexports.sGui:setGuiHoverable(btn, true)
			seexports.sGui:setHoverEvent(btn, "horseeBetHover")
			seexports.sGui:setClickEvent(btn, "horseePlaceBet")
			guiButtons[btn] = i
			betButtons[i] = btn
			processOddsTooltip(i)
			for j = 1, i - 1 do
				local btn = seexports.sGui:createGuiElement("rectangle", x + w3 + (j - 1) * w4 + 15, y + h / 2 - 39, 98, 78, window)
				seexports.sGui:setGuiHover(btn, "none", false, false, true)
				seexports.sGui:setGuiHoverable(btn, true)
				seexports.sGui:setHoverEvent(btn, "horseeBetHover")
				seexports.sGui:setClickEvent(btn, "horseePlaceBet")
				guiButtons[btn] = i * 10 + j
				sideButtons[i][j] = btn
				processSideOddsTooltip(i, j)
			end
			y = y + h
		end
		local x = 512 - 64 * #coinValues / 2
		local y = titleBarHeight + 698
		for i = 1, #coinValues do
			local btn = seexports.sGui:createGuiElement("rectangle", x + 6, y + 6, 52, 52, window)
			seexports.sGui:setGuiHover(btn, "none", false, false, true)
			seexports.sGui:setGuiHoverable(btn, true)
			seexports.sGui:setClickEvent(btn, "changeHorseeCoin")
			coinButtons[btn] = i
			x = x + 64
		end
	else
		local image = seexports.sGui:createGuiElement("image", pw - titleBarHeight, 0, titleBarHeight, titleBarHeight, window)
		seexports.sGui:setImageFile(image, seexports.sGui:getFaIconFilename("expand-alt", titleBarHeight))
		seexports.sGui:setGuiHoverable(image, true)
		seexports.sGui:setGuiHover(image, "solid", "sightgreen")
		seexports.sGui:setClickEvent(image, "toggleHorseeWindow")
		local image = seexports.sGui:createGuiElement("image", pw - titleBarHeight * 2, 0, titleBarHeight, titleBarHeight, window)
		seexports.sGui:setImageFile(image, seexports.sGui:getFaIconFilename("eye", titleBarHeight, "regular"))
		seexports.sGui:setGuiHoverable(image, true)
		seexports.sGui:setGuiHover(image, "solid", "sightgreen")
		seexports.sGui:setHoverEvent(image, "horseeBigPreview")
		local image = seexports.sGui:createGuiElement("image", 2, titleBarHeight + 2, 328, 246, window)
		seexports.sGui:setImageFile(image, horseTables[myTable].bigRt)
		local image = seexports.sGui:createGuiElement("image", 0, titleBarHeight, 332, 250, window)
		seexports.sGui:setImageDDS(image, ":sHorsee/files/live.dds")
		smallWindow = window
	end
end
addEvent("changeHorseeCoin", false)
addEventHandler("changeHorseeCoin", getRootElement(), function(button, state, absX, absY, el)
	if coinButtons[el] and currentCoin ~= coinButtons[el] then
		currentCoin = coinButtons[el]
		playSound("files/sound/sscswitch" .. math.random(1, 3) .. ".mp3")
	end
end)
addEvent("tryToExitHorsee", false)
addEventHandler("tryToExitHorsee", getRootElement(), function()
	local tbl = horseTables[myTable]
	for i = 1, horseNum do
		if tbl.bets[mySeat][i] and tbl.bets[mySeat][i] > 0 then
			seexports.sGui:showInfobox("e", "Amíg érvényes téted van az asztalon, nem állhatsz fel!")
			return
		end
		for j = 1, i - 1 do
			if tbl.sideBets[mySeat][i][j] and tbl.sideBets[mySeat][i][j] > 0 then
				seexports.sGui:showInfobox("e", "Amíg érvényes téted van az asztalon, nem állhatsz fel!")
				return
			end
		end
	end
	triggerServerEvent("tryToExitHorsee", localPlayer)
end)
local lastBetTry = {}
addEvent("horseePlaceBet", false)
addEventHandler("horseePlaceBet", getRootElement(), function(button, state, absX, absY, el)
	if guiButtons[el] then
		local tbl = horseTables[myTable]
		if (not tbl.countdownTime or tbl.countdownTime > 0) and not tbl.newAnimationDelta then
			local amount = coinValues[currentCoin]
			local i = guiButtons[el]
			local j
			local now = getTickCount()
			if now - (lastBetTry[i] or 0) < betWait then
				return
			end
			if 10 < i then
				j = i % 10
				i = math.floor(i / 10)
			end
			if j then
				if now - (lastSideBet[i][j] or 0) < betWait then
					return
				end
			elseif now - (lastBet[i] or 0) < betWait then
				return
			end
			if button == "right" then
				if j then
					if not tbl.sideBets[i][j] then
						return
					end
				elseif not tbl.bets[i] then
					return
				end
				amount = -amount
			end
			if amount < 0 or amount <= (balanceNew or balance) then
				lastBetTry[guiButtons[el]] = now
				triggerServerEvent("horseePlaceBet", localPlayer, i, j, amount)
			end
		end
	end
end)
addEvent("moveHorseeWindow", false)
addEventHandler("moveHorseeWindow", getRootElement(), function(el, x, y)
	bigX, bigY = x, y
end)
addEvent("horseeBetHover", false)
addEventHandler("horseeBetHover", getRootElement(), function(el, state)
	guiHovers[guiButtons[el]] = state
end)
addEvent("horseeBigPreview", false)
addEventHandler("horseeBigPreview", getRootElement(), function(el, state)
	bigPreview = state
end)
addEvent("toggleHorseeWindow", false)
addEventHandler("toggleHorseeWindow", getRootElement(), function(el, state)
	if bigWindow then
		createWindow(false)
	else
		createWindow(true)
	end
end)
function sortByPlace(a, b)
	if a[2] == b[2] then
		return a[1] < b[1]
	else
		return a[2] > b[2]
	end
end
function drawBetScreen(ix, iy, tbl)
	local x = ix
	local y = iy
	dxDrawRectangle(x, y, 1024, 768, tocolor(0, 0, 0))
	if tbl.newAnimationDelta and tbl.oldBg then
		local a = 1 - math.min(1, tbl.newAnimationDelta / 1000)
		dxDrawImage(x + 6, y + 6, 1012, 756, dynamicImage("files/bg/" .. tbl.bg .. ".dds"), 0, 0, 0, tocolor(255, 255, 255, 255))
		dxDrawImage(x + 6, y + 6, 1012, 756, dynamicImage("files/bg/" .. tbl.oldBg .. ".dds"), 0, 0, 0, tocolor(255, 255, 255, 255 * a))
	else
		dxDrawImage(x + 6, y + 6, 1012, 756, dynamicImage("files/bg/" .. (tbl.bg or 1) .. ".dds"), 0, 0, 0, tocolor(255, 255, 255, 255))
	end
	dxDrawImage(x + 680, y + 120, 328, 246, tbl.bigRt)
	sightlangStaticImageUsed[18] = true
	if sightlangStaticImageToc[18] then
		processSightlangStaticImage[18]()
	end
	dxDrawImage(x + 680 - 2, y + 120 - 2, 332, 250, sightlangStaticImage[18])
	sightlangStaticImageUsed[24] = true
	if sightlangStaticImageToc[24] then
		processSightlangStaticImage[24]()
	end
	dxDrawImage(x, y, 1024, 64, sightlangStaticImage[24])
	dxDrawRectangle(x, y + 714, 1024, 48, tocolor(0, 0, 0))
	sightlangStaticImageUsed[25] = true
	if sightlangStaticImageToc[25] then
		processSightlangStaticImage[25]()
	end
	dxDrawImage(x + 6, y + 714, 1012, 48, sightlangStaticImage[25])
	sightlangStaticImageUsed[26] = true
	if sightlangStaticImageToc[26] then
		processSightlangStaticImage[26]()
	end
	dxDrawImage(x, y + 64, 1024, 40, sightlangStaticImage[26])
	sightlangStaticImageUsed[27] = true
	if sightlangStaticImageToc[27] then
		processSightlangStaticImage[27]()
	end
	dxDrawImage(x + 6, y + 64, 40, 40, sightlangStaticImage[27])
	if tbl.newAnimationDelta and tbl.oldBg then
		local a = math.min(1, tbl.newAnimationDelta / 500)
		dxDrawText(cupNames[tbl.oldCupName], x + 46, y + 64, 0, y + 104, tocolor(230, 180, 0), cupFontScale * (1 - a), cupFont, "left", "center")
		dxDrawText(cupNames[tbl.cupName], x + 46, y + 64, 0, y + 104, tocolor(230, 180, 0), cupFontScale * a, cupFont, "left", "center")
	else
		dxDrawText(cupNames[tbl.cupName], x + 46, y + 64, 0, y + 104, tocolor(230, 180, 0), cupFontScale, cupFont, "left", "center")
	end
	local w = 50.6
	x = ix + w / 2 - 9
	y = iy + 6 + 29 - 12 - 9
	local a = 255
	for i = #tbl.history, 1, -1 do
		local wn = tbl.history[i][2]
		local r = tbl.history[i][3]
		sightlangStaticImageUsed[28] = true
		if sightlangStaticImageToc[28] then
			processSightlangStaticImage[28]()
		end
		dxDrawImage(x, y, 18, 18, sightlangStaticImage[28], 0, 0, 0, tocolor(horseColors[wn][1], horseColors[wn][2], horseColors[wn][3], a))
		sightlangStaticImageUsed[28] = true
		if sightlangStaticImageToc[28] then
			processSightlangStaticImage[28]()
		end
		dxDrawImage(x, y + 24, 18, 18, sightlangStaticImage[28], 0, 0, 0, tocolor(horseColors[r][1], horseColors[r][2], horseColors[r][3], a))
		dxDrawText(wn, x, y, x + 18, y + 18, tocolor(26, 27, 31, a), numberFontScale, numberFont, "center", "center")
		dxDrawText(r, x, y + 24, x + 18, y + 24 + 18, tocolor(26, 27, 31, a), numberFontScale, numberFont, "center", "center")
		x = x + w
		if 90 < a then
			a = a - 40
		end
	end
	x = ix
	y = iy
	local w = 338
	local now = getTickCount()
	if tbl.betting then
		if tbl.countdownTime then
			if 0 < tbl.countdownTime then
				local p = math.max(0, 1 - (now - tbl.countdown) / (countdownTime * 1000))
				dxDrawRectangle(x + 680, y + 101, w, 3, tocolor(180, 180, 180))
				dxDrawRectangle(x + 680 + w * (1 - p), y + 101, w * p, 3, tocolor(245, 95, 95))
				dxDrawText(tbl.countdownTime .. "s", 0, y + 64, x + 1008, y + 101, tocolor(245, 95, 95), 1.425 * cupFontScale, cupFont, "right", "center")
				dxDrawText("Kérem tegyék meg tétjeiket!", x + 680, y + 64, x + 1008 - 16, y + 101, tocolor(255, 255, 255), 1.175 * helpFontScale, helpFont, "center", "center")
			else
				dxDrawText("Köszönöm, nincs több tét!", x + 680, y + 64, x + 1008, y + 101, tocolor(255, 255, 255), 1.175 * helpFontScale, helpFont, "center", "center")
			end
		else
			dxDrawText("Kérem tegyék meg tétjeiket!", x + 680, y + 64, x + 1008, y + 104, tocolor(255, 255, 255), 1.175 * helpFontScale, helpFont, "center", "center")
		end
	elseif tbl.matchGoHomeP and 0 < tbl.matchGoHomeP then
		dxDrawText("Játék vége, eredményhirdetés", x + 680, y + 64, x + 1008, y + 104, tocolor(255, 255, 255), 1.175 * helpFontScale, helpFont, "center", "center")
	else
		dxDrawText("Sok szerencsét!", x + 680, y + 64, x + 1008, y + 104, tocolor(255, 255, 255), 1.175 * helpFontScale, helpFont, "center", "center")
	end
	local x = x + 512 - 128 * (2.15 + 0.85 * (horseNum - 1) + 1) / 2
	local y = y + 120
	local h = 550 / horseNum
	sightlangStaticImageUsed[29] = true
	if sightlangStaticImageToc[29] then
		processSightlangStaticImage[29]()
	end
	dxDrawImage(x + 134.144 - 128, y + h * (horseNum - 0.5) - 64 + 8, 256, 128, sightlangStaticImage[29])
	sightlangStaticImageUsed[30] = true
	if sightlangStaticImageToc[30] then
		processSightlangStaticImage[30]()
	end
	dxDrawImage(x + 281.6, y + h * (horseNum - 0.5) - 64 + 8, 660, 128, sightlangStaticImage[30])
	dxDrawText("Tippeld meg, melyik ló ér be elsőként.", x + 134.144 - 128, 0, x + 134.144 + 128, y + h * (horseNum - 0.5) + 64, tocolor(255, 255, 255), helpFontScale, helpFont, "center", "bottom")
	dxDrawText("Quinella - Olyan fogadás, melyben az első kettő befutót kell megtippelni. A sorrend nem számít.", x + 281.6, 0, x + 281.6 + 660, y + h * (horseNum - 0.5) + 64, tocolor(255, 255, 255), helpFontScale, helpFont, "center", "bottom")
	local w1 = 134.4
	local w2 = 192
	local w3 = 275.2
	local w4 = 108.8
	local newAnimDelta = false
	if tbl.newAnimationDelta then
		newAnimDelta = tbl.newAnimationDelta
	end
	local gp = false
	if tbl.matchGoHomeP and 0 < tbl.matchGoHomeP then
		gp = 1
		local p = tbl.matchGoHomeP
		local ef = 1 - goHomeEndFade
		if p > ef then
			gp = 1 - (p - ef) / goHomeEndFade
		end
	end
	for i = 1, horseNum do
		local p = false
		local hc = false
		local wh = false
		if newAnimDelta then
			p = math.min(1, math.max(0, newAnimDelta / 190))
			newAnimDelta = newAnimDelta - 150
		end
		if p or gp then
			local a = 0
			if gp then
				if tbl.winner == i then
					a = gp
				end
			else
				a = p
			end
			wh = tocolor(255, 255, 255, 125 + 130 * a)
			hc = tocolor(horseColors[i][1], horseColors[i][2], horseColors[i][3], 125 + 130 * a)
			sightlangStaticImageUsed[31] = true
			if sightlangStaticImageToc[31] then
				processSightlangStaticImage[31]()
			end
			dxDrawImage(x + 134, y + h / 2 - 64, 128, 128, sightlangStaticImage[31], 0, 0, 0, wh)
			sightlangStaticImageUsed[32] = true
			if sightlangStaticImageToc[32] then
				processSightlangStaticImage[32]()
			end
			dxDrawImage(x + w1, y + h / 2 - 64, 128, 128, sightlangStaticImage[32], 0, 0, 0, hc)
			dxDrawText(i, x + w1 + 48, y + h / 2 - 64 + 34, x + w1 + 48 + 32, y + h / 2 - 64 + 34 + 32, tocolor(26, 27, 31, 125 + 130 * a), numberExFontScale, numberExFont, "center", "center")
			if p then
				dxDrawText(tbl.oldOdds[i] .. "x", x + w1 + 48, 0, 0, y + h / 2 - 64 + 99, wh, cupFontScale * (1 - p), cupFont, "left", "bottom")
				dxDrawText(tbl.odds[i] .. "x", x + w1 + 48, 0, 0, y + h / 2 - 64 + 99, wh, cupFontScale * p, cupFont, "left", "bottom")
			else
				dxDrawText(tbl.odds[i] .. "x", x + w1 + 48, 0, 0, y + h / 2 - 64 + 99, wh, cupFontScale, cupFont, "left", "bottom")
			end
			sightlangStaticImageUsed[33] = true
			if sightlangStaticImageToc[33] then
				processSightlangStaticImage[33]()
			end
			dxDrawImage(x, y + h / 2 - 64, w2, 128, sightlangStaticImage[33], 0, 0, 0, hc)
			sightlangStaticImageUsed[11] = true
			if sightlangStaticImageToc[11] then
				processSightlangStaticImage[11]()
			end
			dxDrawImage(x, y + h / 2 - 64, w2, 128, sightlangStaticImage[11], 0, 0, 0, wh)
			dxDrawImage(x, y + h / 2 - 64, w2, 128, dynamicImage("files/horses/" .. i .. ".dds"), 0, 0, 0, wh)
			sightlangStaticImageUsed[34] = true
			if sightlangStaticImageToc[34] then
				processSightlangStaticImage[34]()
			end
			dxDrawImage(x, y + h / 2 - 64, w2, 128, sightlangStaticImage[34], 0, 0, 0, wh)
			if p then
				dxDrawText(horseNames[tbl.oldNames[i]], x + 22, y + h / 2 - 64 + 85, 0, y + h / 2 - 64 + 105, wh, 0.85 * helpFontScale * (1 - p), helpFont, "left", "center")
				dxDrawText(horseNames[tbl.names[i]], x + 22, y + h / 2 - 64 + 85, 0, y + h / 2 - 64 + 105, wh, 0.85 * helpFontScale * p, helpFont, "left", "center")
			else
				dxDrawText(horseNames[tbl.names[i]], x + 22, y + h / 2 - 64 + 85, 0, y + h / 2 - 64 + 105, wh, 0.85 * helpFontScale, helpFont, "left", "center")
			end
		else
			sightlangStaticImageUsed[31] = true
			if sightlangStaticImageToc[31] then
				processSightlangStaticImage[31]()
			end
			dxDrawImage(x + 134, y + h / 2 - 64, 128, 128, sightlangStaticImage[31])
			sightlangStaticImageUsed[32] = true
			if sightlangStaticImageToc[32] then
				processSightlangStaticImage[32]()
			end
			dxDrawImage(x + w1, y + h / 2 - 64, 128, 128, sightlangStaticImage[32], 0, 0, 0, horseColors[i][4])
			dxDrawText(i, x + w1 + 48, y + h / 2 - 64 + 34, x + w1 + 48 + 32, y + h / 2 - 64 + 34 + 32, tocolor(26, 27, 31), numberExFontScale, numberExFont, "center", "center")
			dxDrawText(tbl.odds[i] .. "x", x + w1 + 48, 0, 0, y + h / 2 - 64 + 99, tocolor(255, 255, 255), cupFontScale, cupFont, "left", "bottom")
			sightlangStaticImageUsed[33] = true
			if sightlangStaticImageToc[33] then
				processSightlangStaticImage[33]()
			end
			dxDrawImage(x, y + h / 2 - 64, w2, 128, sightlangStaticImage[33], 0, 0, 0, horseColors[i][4])
			sightlangStaticImageUsed[11] = true
			if sightlangStaticImageToc[11] then
				processSightlangStaticImage[11]()
			end
			dxDrawImage(x, y + h / 2 - 64, w2, 128, sightlangStaticImage[11])
			dxDrawImage(x, y + h / 2 - 64, w2, 128, dynamicImage("files/horses/" .. i .. ".dds"))
			sightlangStaticImageUsed[34] = true
			if sightlangStaticImageToc[34] then
				processSightlangStaticImage[34]()
			end
			dxDrawImage(x, y + h / 2 - 64, w2, 128, sightlangStaticImage[34])
			dxDrawText(horseNames[tbl.names[i]], x + 22, y + h / 2 - 64 + 85, 0, y + h / 2 - 64 + 105, tocolor(255, 255, 255), 0.85 * helpFontScale, helpFont, "left", "center")
		end
		for j = 1, i do
			if j == i then
				if gp then
					local wh = tocolor(255, 255, 255, 125)
					sightlangStaticImageUsed[35] = true
					if sightlangStaticImageToc[35] then
						processSightlangStaticImage[35]()
					end
					dxDrawImage(x + w3 + (j - 1) * w4, y + h / 2 - 64, 128, 128, sightlangStaticImage[35], 0, 0, 0, tocolor(horseColors[i][1], horseColors[i][2], horseColors[i][3], 125))
					sightlangStaticImageUsed[36] = true
					if sightlangStaticImageToc[36] then
						processSightlangStaticImage[36]()
					end
					dxDrawImage(x + w3 + (j - 1) * w4, y + h / 2 - 64, 128, 128, sightlangStaticImage[36], 0, 0, 0, wh)
					if i == 1 then
						sightlangStaticImageUsed[37] = true
						if sightlangStaticImageToc[37] then
							processSightlangStaticImage[37]()
						end
						dxDrawImage(x + w3 + (j - 1) * w4, y + h / 2 - 64, 128, 128, sightlangStaticImage[37], 0, 0, 0, wh)
					elseif i == horseNum then
						sightlangStaticImageUsed[38] = true
						if sightlangStaticImageToc[38] then
							processSightlangStaticImage[38]()
						end
						dxDrawImage(x + w3 + (j - 1) * w4, y + h / 2 - 64, 128, 128, sightlangStaticImage[38], 0, 0, 0, wh)
					else
						sightlangStaticImageUsed[39] = true
						if sightlangStaticImageToc[39] then
							processSightlangStaticImage[39]()
						end
						dxDrawImage(x + w3 + (j - 1) * w4, y + h / 2 - 64, 128, 128, sightlangStaticImage[39], 0, 0, 0, wh)
					end
					dxDrawText(i, x + w3 + (j - 1) * w4, y + h / 2 - 64, x + w3 + (j - 1) * w4 + 128, y + h / 2 + 64, tocolor(26, 27, 31, 125), numberExFontScale, numberExFont, "center", "center")
				elseif p then
					sightlangStaticImageUsed[35] = true
					if sightlangStaticImageToc[35] then
						processSightlangStaticImage[35]()
					end
					dxDrawImage(x + w3 + (j - 1) * w4, y + h / 2 - 64, 128, 128, sightlangStaticImage[35], 0, 0, 0, hc)
					sightlangStaticImageUsed[36] = true
					if sightlangStaticImageToc[36] then
						processSightlangStaticImage[36]()
					end
					dxDrawImage(x + w3 + (j - 1) * w4, y + h / 2 - 64, 128, 128, sightlangStaticImage[36], 0, 0, 0, wh)
					if i == 1 then
						sightlangStaticImageUsed[37] = true
						if sightlangStaticImageToc[37] then
							processSightlangStaticImage[37]()
						end
						dxDrawImage(x + w3 + (j - 1) * w4, y + h / 2 - 64, 128, 128, sightlangStaticImage[37], 0, 0, 0, wh)
					elseif i == horseNum then
						sightlangStaticImageUsed[38] = true
						if sightlangStaticImageToc[38] then
							processSightlangStaticImage[38]()
						end
						dxDrawImage(x + w3 + (j - 1) * w4, y + h / 2 - 64, 128, 128, sightlangStaticImage[38], 0, 0, 0, wh)
					else
						sightlangStaticImageUsed[39] = true
						if sightlangStaticImageToc[39] then
							processSightlangStaticImage[39]()
						end
						dxDrawImage(x + w3 + (j - 1) * w4, y + h / 2 - 64, 128, 128, sightlangStaticImage[39], 0, 0, 0, wh)
					end
					dxDrawText(i, x + w3 + (j - 1) * w4, y + h / 2 - 64, x + w3 + (j - 1) * w4 + 128, y + h / 2 + 64, tocolor(26, 27, 31, 125 + 130 * p), numberExFontScale, numberExFont, "center", "center")
				else
					sightlangStaticImageUsed[35] = true
					if sightlangStaticImageToc[35] then
						processSightlangStaticImage[35]()
					end
					dxDrawImage(x + w3 + (j - 1) * w4, y + h / 2 - 64, 128, 128, sightlangStaticImage[35], 0, 0, 0, horseColors[i][4])
					sightlangStaticImageUsed[36] = true
					if sightlangStaticImageToc[36] then
						processSightlangStaticImage[36]()
					end
					dxDrawImage(x + w3 + (j - 1) * w4, y + h / 2 - 64, 128, 128, sightlangStaticImage[36])
					if i == 1 then
						sightlangStaticImageUsed[37] = true
						if sightlangStaticImageToc[37] then
							processSightlangStaticImage[37]()
						end
						dxDrawImage(x + w3 + (j - 1) * w4, y + h / 2 - 64, 128, 128, sightlangStaticImage[37])
					elseif i == horseNum then
						sightlangStaticImageUsed[38] = true
						if sightlangStaticImageToc[38] then
							processSightlangStaticImage[38]()
						end
						dxDrawImage(x + w3 + (j - 1) * w4, y + h / 2 - 64, 128, 128, sightlangStaticImage[38])
					else
						sightlangStaticImageUsed[39] = true
						if sightlangStaticImageToc[39] then
							processSightlangStaticImage[39]()
						end
						dxDrawImage(x + w3 + (j - 1) * w4, y + h / 2 - 64, 128, 128, sightlangStaticImage[39])
					end
					dxDrawText(i, x + w3 + (j - 1) * w4, y + h / 2 - 64, x + w3 + (j - 1) * w4 + 128, y + h / 2 + 64, tocolor(26, 27, 31), numberExFontScale, numberExFont, "center", "center")
				end
			elseif newAnimDelta or gp then
				local p = 1
				local a = 0
				if gp then
					if i == tbl.quinellaA and j == tbl.quinellaB then
						a = gp
					end
				else
					p = math.min(1, math.max(0, newAnimDelta / 190))
					a = p
				end
				local wh = tocolor(255, 255, 255, 125 + 130 * a)
				sightlangStaticImageUsed[40] = true
				if sightlangStaticImageToc[40] then
					processSightlangStaticImage[40]()
				end
				dxDrawImage(x + w3 + (j - 1) * w4, y + h / 2 - 64, 128, 128, sightlangStaticImage[40], 0, 0, 0, wh)
				sightlangStaticImageUsed[28] = true
				if sightlangStaticImageToc[28] then
					processSightlangStaticImage[28]()
				end
				dxDrawImage(x + w3 + (j - 1) * w4 + 21, y + h / 2 - 64 + 31, 24, 24, sightlangStaticImage[28], 0, 0, 0, tocolor(horseColors[j][1], horseColors[j][2], horseColors[j][3], 125 + 130 * a))
				sightlangStaticImageUsed[28] = true
				if sightlangStaticImageToc[28] then
					processSightlangStaticImage[28]()
				end
				dxDrawImage(x + w3 + (j - 1) * w4 + 21 + 24 + 2, y + h / 2 - 64 + 31, 24, 24, sightlangStaticImage[28], 0, 0, 0, tocolor(horseColors[i][1], horseColors[i][2], horseColors[i][3], 125 + 130 * a))
				dxDrawText(j, x + w3 + (j - 1) * w4 + 21, y + h / 2 - 64 + 31, x + w3 + (j - 1) * w4 + 21 + 24, y + h / 2 - 64 + 31 + 24, tocolor(26, 27, 31, 125 + 130 * a), numberFontScale, numberFont, "center", "center")
				dxDrawText(i, x + w3 + (j - 1) * w4 + 21 + 24 + 2, y + h / 2 - 64 + 31, x + w3 + (j - 1) * w4 + 21 + 24 + 2 + 24, y + h / 2 - 64 + 31 + 24, tocolor(26, 27, 31, 125 + 130 * a), numberFontScale, numberFont, "center", "center")
				if p < 1 then
					dxDrawText(tbl.oldSideOdds[i][j] .. "x", x + w3 + (j - 1) * w4 + 21, 0, 0, y + h / 2 - 64 + 99, wh, cupFontScale * (1 - p), cupFont, "left", "bottom")
				end
				dxDrawText(tbl.sideOdds[i][j] .. "x", x + w3 + (j - 1) * w4 + 21, 0, 0, y + h / 2 - 64 + 99, wh, cupFontScale * p, cupFont, "left", "bottom")
				if newAnimDelta then
					newAnimDelta = newAnimDelta - 150
				end
			else
				sightlangStaticImageUsed[40] = true
				if sightlangStaticImageToc[40] then
					processSightlangStaticImage[40]()
				end
				dxDrawImage(x + w3 + (j - 1) * w4, y + h / 2 - 64, 128, 128, sightlangStaticImage[40])
				sightlangStaticImageUsed[28] = true
				if sightlangStaticImageToc[28] then
					processSightlangStaticImage[28]()
				end
				dxDrawImage(x + w3 + (j - 1) * w4 + 21, y + h / 2 - 64 + 31, 24, 24, sightlangStaticImage[28], 0, 0, 0, horseColors[j][4])
				sightlangStaticImageUsed[28] = true
				if sightlangStaticImageToc[28] then
					processSightlangStaticImage[28]()
				end
				dxDrawImage(x + w3 + (j - 1) * w4 + 21 + 24 + 2, y + h / 2 - 64 + 31, 24, 24, sightlangStaticImage[28], 0, 0, 0, horseColors[i][4])
				dxDrawText(j, x + w3 + (j - 1) * w4 + 21, y + h / 2 - 64 + 31, x + w3 + (j - 1) * w4 + 21 + 24, y + h / 2 - 64 + 31 + 24, tocolor(26, 27, 31), numberFontScale, numberFont, "center", "center")
				dxDrawText(i, x + w3 + (j - 1) * w4 + 21 + 24 + 2, y + h / 2 - 64 + 31, x + w3 + (j - 1) * w4 + 21 + 24 + 2 + 24, y + h / 2 - 64 + 31 + 24, tocolor(26, 27, 31), numberFontScale, numberFont, "center", "center")
				dxDrawText(tbl.sideOdds[i][j] .. "x", x + w3 + (j - 1) * w4 + 21, 0, 0, y + h / 2 - 64 + 99, tocolor(255, 255, 255), cupFontScale, cupFont, "left", "bottom")
			end
		end
		y = y + h
	end
	if gp then
		sightlangStaticImageUsed[20] = true
		if sightlangStaticImageToc[20] then
			processSightlangStaticImage[20]()
		end
		dxDrawImage(x, iy + 120 + h * (tbl.winner - 0.5) - 64, 272, 128, sightlangStaticImage[20], 0, 0, 0, tocolor(255, 255, 255, 255 * gp))
		sightlangStaticImageUsed[21] = true
		if sightlangStaticImageToc[21] then
			processSightlangStaticImage[21]()
		end
		dxDrawImage(x + w3 + (tbl.quinellaB - 1) * w4, iy + 120 + h * (tbl.quinellaA - 0.5) - 64, 128, 128, sightlangStaticImage[21], 0, 0, 0, tocolor(255, 255, 255, 255 * gp))
	end
	y = iy + 120
	local cursor = isCursorShowing()
	local ct = 0
	local ct2 = 0
	if gp then
		ct = tbl.matchDelta - tbl.matchTime - 1000
		ct2 = tbl.matchDelta - tbl.matchTime - 4500
	end
	local winTmp = false
	for i = 1, horseNum do
		if betsFormat[i] then
			local cx = x + 134 + 42 + 38.5
			local cy = y + h / 2
			local a = 255
			if gp then
				if tbl.winner == i then
					local p = math.min(1, math.max(0, ct2 / 2000))
					cx, cy, a = interpolateBetween(cx, cy, 255, ix + 512, iy + 28 + 8, 0, p, "OutQuad")
					p = math.min(1, math.max(0, (p - 0.175) / 0.5))
					winTmp = (winTmp or 0) + math.floor(tbl.bets[mySeat][i] * tbl.odds[i] * p)
					ct2 = ct2 - 2500
				else
					cx, cy, a = interpolateBetween(cx, cy, 125, ix + 1024 - 28, iy + 384, 0, math.min(1, math.max(0, ct / 1500)), "OutQuad")
					ct = ct - 125
				end
			elseif guiHovers[i] and cursor then
				local delta = now - lastBet[i]
				if delta < betWait then
					a = 255 - 130 * getEasingValue(delta / betWait, "InQuad")
				else
					a = 125
				end
			end
			dxDrawImage(cx - 28, cy - 28, 56, 56, dynamicImage("files/coin/" .. tbl.betCoins[mySeat][i] .. ".dds"), 0, 0, 0, tocolor(255, 255, 255, a))
			dxDrawText(betsFormat[i], cx, cy - 1, cx, cy - 1, tocolor(0, 0, 0, a), helpFontScale * 0.875, helpFont, "center", "center")
			sightlangStaticImageUsed[41] = true
			if sightlangStaticImageToc[41] then
				processSightlangStaticImage[41]()
			end
			dxDrawImage(cx - 28, cy - 28, 56, 56, sightlangStaticImage[41], 0, 0, 0, tocolor(255, 255, 255, a))
		end
		for j = 1, i - 1 do
			if sideBetsFormat[i][j] then
				local cx = x + w3 + (j - 1) * w4 + 15 + 49
				local cy = y + h / 2
				local a = 255
				if gp then
					if tbl.quinellaA == i and tbl.quinellaB == j then
						local p = math.min(1, math.max(0, ct2 / 2000))
						cx, cy, a = interpolateBetween(cx, cy, 255, ix + 512, iy + 28 + 8, 0, p, "OutQuad")
						p = math.min(1, math.max(0, (p - 0.175) / 0.5))
						winTmp = (winTmp or 0) + math.floor(tbl.sideBets[mySeat][i][j] * tbl.sideOdds[i][j] * p)
					else
						cx, cy, a = interpolateBetween(cx, cy, 125, ix + 1024 - 28, iy + 384, 0, math.min(1, math.max(0, ct / 1500)), "OutQuad")
						ct = ct - 125
					end
				elseif guiHovers[i * 10 + j] then
					local delta = now - lastSideBet[i][j]
					if delta < betWait then
						a = 255 - 130 * getEasingValue(delta / betWait, "InQuad")
					else
						a = 125
					end
				end
				dxDrawImage(cx - 28, cy - 28, 56, 56, dynamicImage("files/coin/" .. tbl.sideCoins[mySeat][i][j] .. ".dds"), 0, 0, 0, tocolor(255, 255, 255, a))
				dxDrawText(sideBetsFormat[i][j], cx, cy - 1, cx, cy - 1, tocolor(0, 0, 0, a), helpFontScale * 0.875, helpFont, "center", "center")
				sightlangStaticImageUsed[41] = true
				if sightlangStaticImageToc[41] then
					processSightlangStaticImage[41]()
				end
				dxDrawImage(cx - 28, cy - 28, 56, 56, sightlangStaticImage[41], 0, 0, 0, tocolor(255, 255, 255, a))
			end
		end
		y = y + h
	end
	if winTmp and myWin ~= winTmp then
		myWin = winTmp
		myWinFormatted = formatBetText(myWin)
		myWinFormattedEx = seexports.sGui:thousandsStepper(myWin)
	end
	local x = ix + 512 - 64 * #coinValues / 2
	local y = iy + 698
	for i = 1, #coinValues do
		local curr = i == currentCoin
		local s = curr and 1 or 0.9
		if curr then
			sightlangStaticImageUsed[42] = true
			if sightlangStaticImageToc[42] then
				processSightlangStaticImage[42]()
			end
			dxDrawImage(x + 64 * (1 - s) / 2, y + 64 * (1 - s) / 2, 64 * s, 64 * s, sightlangStaticImage[42])
		end
		dxDrawImage(x + 64 * (1 - s) / 2, y + 64 * (1 - s) / 2, 64 * s, 64 * s, dynamicImage("files/coin/" .. i .. ".dds"))
		dxDrawText(coinValues[i], x, y, x + 64, y + 60.8, tocolor(0, 0, 0), helpFontScale * s, helpFont, "center", "center")
		sightlangStaticImageUsed[41] = true
		if sightlangStaticImageToc[41] then
			processSightlangStaticImage[41]()
		end
		dxDrawImage(x + 64 * (1 - s) / 2, y + 64 * (1 - s) / 2, 64 * s, 64 * s, sightlangStaticImage[41], 0, 0, 0, tocolor(255, 255, 255, curr and 255 or 175))
		x = x + 64
	end
	local nx = ix + 6 + 230 - 8
	local y = iy + 762
	local fw = cupFontZeroSize * 1.15
	dxDrawText(" SSC", nx - fw * 3, y - 48, nx, y, tocolor(255, 255, 255), cupFontScale * 1.15, cupFont, "center", "center")
	nx = nx - fw * 3
	for i = 1, #balanceText do
		if balanceText[i] then
			dxDrawText(balanceText[i], nx - fw, y - 48, nx, y, tocolor(255, 255, 255), cupFontScale * 1.15, cupFont, "center", "center")
		end
		nx = nx - fw * (i % 3 == 0 and 1.5 or 1)
	end
	dxDrawText(myBetsFormatted, 0, y - 48, ix + 6 + 870 - 8, y, tocolor(255, 255, 255), cupFontScale * 1.15, cupFont, "right", "center")
	dxDrawText(myWinFormatted, 0, y - 48, ix + 6 + 972 - 8, y, tocolor(255, 255, 255), cupFontScale * 1.15, cupFont, "right", "center")
	if gp and tbl.winCount[mySeat] and tbl.winCount[mySeat] > 0 then
		local p = tbl.matchGoHomeP
		local x, y = ix, iy
		sightlangStaticImageUsed[23] = true
		if sightlangStaticImageToc[23] then
			processSightlangStaticImage[23]()
		end
		dxDrawImageSection(x + 6, y + 6, 1012, 756, 0, -756 * p * 5, 1012, 756, sightlangStaticImage[23], 0, 0, 0, tocolor(243, 210, 74, 75 * gp))
		sightlangStaticImageUsed[43] = true
		if sightlangStaticImageToc[43] then
			processSightlangStaticImage[43]()
		end
		dxDrawImage(x, y, 1024, 146, sightlangStaticImage[43], 0, 0, 0, tocolor(255, 255, 255, 255 * gp))
		sightlangStaticImageUsed[44] = true
		if sightlangStaticImageToc[44] then
			processSightlangStaticImage[44]()
		end
		dxDrawImage(x + 80 * p, y, 1024, 146, sightlangStaticImage[44], 0, 0, 0, tocolor(255, 255, 255, 255 * gp))
		sightlangStaticImageUsed[45] = true
		if sightlangStaticImageToc[45] then
			processSightlangStaticImage[45]()
		end
		dxDrawImage(x, y, 1024, 146, sightlangStaticImage[45], 0, 0, 0, tocolor(255, 255, 255, 255 * gp))
		sightlangStaticImageUsed[46] = true
		if sightlangStaticImageToc[46] then
			processSightlangStaticImage[46]()
		end
		dxDrawImage(x - 100 * p, y, 1024, 146, sightlangStaticImage[46], 0, 0, 0, tocolor(255, 255, 255, 220 * gp))
		if 0 < myWin then
			local text = tostring(myWinFormattedEx)
			local text2 = myWinFormattedEx .. " SSC"
			local n = utf8.len(text) + 4
			local w = 12
			local x = x + 512 + w * n / 2
			for i = 1, n do
				local d = 1 - (i - n * p * 8) % n / n
				if 0.5 < d then
					d = (1 - d) * 2
				else
					d = d * 2
				end
				d = 0.85 + getEasingValue(d, "InQuad") * 0.15
				dxDrawText(utf8.sub(text2, -i, -i), x - w + 1, y + 110 + 1, x + 1, 1, tocolor(96, 58, 14, 255 * gp), cupFontScale * 1.25, cupFont, "center", "top")
				dxDrawText(utf8.sub(text2, -i, -i), x - w, y + 110, x, 0, tocolor(243 * d, 210 * d, 74 * d, 255 * gp), cupFontScale * 1.25, cupFont, "center", "top")
				x = x - w
			end
		end
	elseif tbl.countdownTime and tbl.countdownTime <= 10 then
		local delta = now - tbl.countdown
		local a = 1 - delta % 1000 / 1000
		if delta < countdownTime * 1000 then
			sightlangStaticImageUsed[23] = true
			if sightlangStaticImageToc[23] then
				processSightlangStaticImage[23]()
			end
			dxDrawImageSection(ix + 6, iy + 6, 1012, 756, 0, -378 - 756 * delta / 1000, 1012, 756, sightlangStaticImage[23], 0, 0, 0, tocolor(245, 95, 95, 125 * a))
		end
	end
	sightlangStaticImageUsed[47] = true
	if sightlangStaticImageToc[47] then
		processSightlangStaticImage[47]()
	end
	dxDrawImage(ix + 6, iy + 6, 1012, 756, sightlangStaticImage[47], 0, 0, 0, tocolor(255, 255, 255, 100))
end
local tblHover = false
local seatHover = false
function renderSeatIcons()
	local cx, cy = getCursorPosition()
	if cx then
		cx = cx * screenX
		cy = cy * screenY
	end
	local tmpTbl = false
	local tmpSeat = false
	local px, py, pz = getElementPosition(localPlayer)
	for k = 1, #streamedInTables do
		local tbl = streamedInTables[k]
		if tbl.onScreen then
			for i = 1, seats do
				if not tbl.players[i] then
					local x, y, z = tbl.seats[i][1], tbl.seats[i][2], tbl.seats[i][3]
					local d = getDistanceBetweenPoints3D(px, py, pz, x, y, z)
					if d < 10 then
						local x, y = getScreenFromWorldPosition(x, y, z, 32)
						if x then
							local a = 255 - d / 10 * 255
							if d < 1.5 and cx and cx >= x - 16 and cx <= x + 16 and cy >= y - 16 and cy <= y + 16 then
								tmpTbl = tbl.id
								tmpSeat = i
								dxDrawRectangle(x - 16, y - 16, 32, 32, tocolor(sitBgColor[1], sitBgColor[2], sitBgColor[3]))
								dxDrawImage(x - 12, y - 12, 24, 24, ":sGui/" .. sitIcon .. faTicks[sitIcon], 0, 0, 0, sitColor)
							else
								dxDrawRectangle(x - 16, y - 16, 32, 32, tocolor(sitBgColor[1], sitBgColor[2], sitBgColor[3], a))
								dxDrawImage(x - 12, y - 12, 24, 24, ":sGui/" .. sitIcon .. faTicks[sitIcon], 0, 0, 0, tocolor(255, 255, 255, a))
							end
						end
					end
				end
			end
		end
	end
	if tblHover ~= tmpTbl or seatHover ~= tmpSeat then
		tblHover = tmpTbl
		seatHover = tmpSeat
		seexports.sGui:setCursorType(tblHover and "link" or "normal")
		seexports.sGui:showTooltip(tblHover and "Leülés")
	end
end
function clickSeatIcons(btn, state)
	if state == "up" and tblHover and not myTable then
		triggerServerEvent("tryToSitDownHorsee", localPlayer, tblHover, seatHover)
	end
end
addEvent("gotHorseePlayer", true)
addEventHandler("gotHorseePlayer", getRootElement(), function(id, seat, player)
	local tbl = horseTables[id]
	if tbl and tbl.streamed then
		if isElement(player) then
			attachElements(player, tbl.obj, horseSeats[seat][1], horseSeats[seat][2], horseSeats[seat][3], 0, 0, horseSeats[seat][4])
			setPedAnimation(player, "int_office", "off_sit_idle_loop", -1, true, false, false, false)
			playSeatSound("sit", tbl, seat)
		elseif isElement(tbl.players[seat]) then
			detachElements(tbl.players[seat], tbl.obj)
			setPedAnimation(tbl.players[seat])
			playSeatSound("stand", tbl, seat)
		end
		tbl.players[seat] = player
		if player == localPlayer then
			myTable = id
			mySeat = seat
			myBet = 0
			myBetFormatted = 0
			myWin = 0
			myWinFormatted = 0
			myWinFormattedEx = 0
			createWindow(true)
			seexports.sGui:setCursorType("normal")
			seexports.sGui:showTooltip()
			removeEventHandler("onClientRender", getRootElement(), renderSeatIcons)
			removeEventHandler("onClientClick", getRootElement(), clickSeatIcons)
			addEventHandler("onClientRender", getRootElement(), renderInTable)
			addEventHandler("onClientPreRender", getRootElement(), preRenderInTable)
		elseif id == myTable and seat == mySeat then
			deleteWindow()
			myTable = false
			mySeat = false
			addEventHandler("onClientRender", getRootElement(), renderSeatIcons)
			addEventHandler("onClientClick", getRootElement(), clickSeatIcons)
			removeEventHandler("onClientRender", getRootElement(), renderInTable)
			removeEventHandler("onClientPreRender", getRootElement(), preRenderInTable)
		end
	end
end)
function renderInTable()
	if bigWindow then
		drawBetScreen(bigX, bigY + titleBarHeight, horseTables[myTable])
	elseif bigPreview and isCursorShowing() then
		drawBetScreen(screenX / 2 - 512, screenY / 2 - 384, horseTables[myTable])
	end
end
function preRenderInTable(delta)
	if balanceSpeed then
		if balance > balanceNew then
			balance = balance - balanceSpeed * delta
			if balance < balanceNew then
				balance = balanceNew
				balanceSpeed = false
			end
			convertBalanceText()
		end
		if balance < balanceNew then
			balance = balance + balanceSpeed * delta
			if balance > balanceNew then
				balance = balanceNew
				balanceSpeed = false
			end
			convertBalanceText()
		end
	end
end
function renderHorseeTables()
	for k = 1, #streamedInTables do
		local tbl = streamedInTables[k]
		if tbl.onScreen then
			local ended = tbl.matchGoHomeP and tbl.matchGoHomeP > 0
			for seat = 1, seats do
				for i = 1, horseNum do
					if tbl.betCoins[seat][i] then
						local el = tbl.scrCoins[seat][i]
						local a = 255
						if ended then
							a = tbl.winner == i and 255 or 125
						end
						dxDrawMaterialLine3D(el[1], el[2], el[3], el[4], el[5], el[6], coinTextures[tbl.betCoins[seat][i]], coinS * 2, tocolor(255, 255, 255, a), el[7], el[8], el[9])
					end
					for j = 1, i - 1 do
						if tbl.sideCoins[seat][i][j] then
							local el = tbl.scrSideCoins[seat][i][j]
							local a = 255
							if ended then
								a = tbl.quinellaA == i and tbl.quinellaB == j and 255 or 125
							end
							dxDrawMaterialLine3D(el[1], el[2], el[3], el[4], el[5], el[6], coinTextures[tbl.sideCoins[seat][i][j]], coinS * 2, tocolor(255, 255, 255, a), el[7], el[8], el[9])
						end
					end
				end
				if ended and tbl.winCount[seat] then
					local el = tbl.scrFull[seat]
					dxDrawMaterialLine3D(el[1], el[2], el[3], el[4], el[5], el[6], winTexture, 0.789082, tocolor(255, 255, 255), el[7], el[8], el[9])
				end
			end
		end
	end
end
function moveHorse(tbl, x, y, z, rz, rzR, j, p)
	local hx, hy = x, y
	local hrz = rz
	local d = 0
	local mp = p % oneProg[j] / oneProg[j]
	mp = mp * 20 * math.pi * 2
	mp2 = math.cos(mp - math.pi) / 2 + 0.5
	mp = math.sin(mp)
	if p < longProg[j] then
		p = p / longProg[j]
		hx = hx + tbl.circleCos[j]
		hy = hy + tbl.circleSin[j]
		hx = hx - tbl.llsin * (-0.5 + p)
		hy = hy + tbl.llcos * (-0.5 + p)
		d = longLength * p
	elseif p + preProg[j][1] < circleProg[j] then
		p = (p + preProg[j][1]) / circleProg[j]
		hrz = hrz + 180 * p
		hx = hx + math.cos(rzR + p * math.pi) * circleCircum[j]
		hy = hy + math.sin(rzR + p * math.pi) * circleCircum[j]
		hx = hx - tbl.llsin * 0.5
		hy = hy + tbl.llcos * 0.5
		d = preDist[j][1] + midRadius * p
	elseif p + preProg[j][2] < longProg[j] then
		p = (p + preProg[j][2]) / longProg[j]
		hrz = hrz + 180
		hx = hx - tbl.circleCos[j]
		hy = hy - tbl.circleSin[j]
		hx = hx + tbl.llsin * (-0.5 + p)
		hy = hy - tbl.llcos * (-0.5 + p)
		d = preDist[j][2] + longLength * p
	elseif p + preProg[j][3] < circleProg[j] then
		p = (p + preProg[j][3]) / circleProg[j]
		hrz = hrz + 180 * (1 + p)
		hx = hx + math.cos(rzR + (1 + p) * math.pi) * circleCircum[j]
		hy = hy + math.sin(rzR + (1 + p) * math.pi) * circleCircum[j]
		hx = hx - tbl.llsin * -0.5
		hy = hy + tbl.llcos * -0.5
		d = preDist[j][3] + midRadius * p
	else
		p = (p - longProg[j] * 2 - circleProg[j] * 2) / longProg[j]
		hx = hx + tbl.cos * circleCircum[j]
		hy = hy + tbl.sin * circleCircum[j]
		hx = hx - tbl.llsin * (-0.5 + p)
		hy = hy + tbl.llcos * (-0.5 + p)
		d = preDist[j][4] + longLength * p
	end
	local horse = tbl.horses[j]
	setElementPosition(horse.obj, hx, hy, z + tableHeight + 0.005 * mp)
	setElementRotation(horse.obj, 5 * mp, 0, hrz)
	setElementAttachedOffsets(horse.legF, 0, 0.0486, 0.0906, 20 * mp)
	setElementAttachedOffsets(horse.legR, 0, -0.0504, 0.0959, -30 * mp2)
	return d
end



function preRenderHorseeTables(delta)
	local now = getTickCount()
	local px, py, pz = getElementPosition(localPlayer)
	for k = 1, #streamedInTables do
		local tbl = streamedInTables[k]
		if horseTables[1].debugonscreen then
			onScreen = false
		end
		local x, y, z, rz = unpack(tbl.pos)
		local onScreen = tbl.id == myTable or isElement(tbl.obj) and isElementOnScreen(tbl.obj) and pz - z < 5
		local rzR = tbl.rad
		if tbl.onScreen ~= onScreen then
			tbl.onScreen = onScreen
			if tbl.betting then
				setElementRotation(tbl.flag1, 0, 0, 90 + rz)
				setElementRotation(tbl.flag2, 0, 0, rz)
			else
				setElementRotation(tbl.flag1, 0, 0, 180 + rz)
				setElementRotation(tbl.flag2, 0, 0, (tbl.finishFlag and 90 or 0) + rz)
			end
			if tbl.liveY then
				tbl.liveY = {}
			end
		end
		if tbl.betting then
			if tbl.newAnimation then
				tbl.refreshMiniScreen = true
				local delta = now - tbl.newAnimation
				if tbl.oldBg then
					if delta > 1000 then
						tbl.oldBg = nil
					end
					tbl.refreshBigScreen = true
				end
				if delta > 3200 then
					tbl.newAnimation = nil
					tbl.newAnimationDelta = nil
					tbl.oldCupName = nil
					tbl.oldBg = nil
					tbl.oldOdds = nil
					tbl.oldNames = nil
					tbl.oldSideOdds = nil
					tbl.refreshMiniScreen = true
					if tbl.id == myTable and bigWindow then
						for i = 1, horseNum do
							processOddsTooltip(i)
							for j = 1, i - 1 do
								processSideOddsTooltip(i, j)
							end
						end
					end
				else
					tbl.newAnimationDelta = delta
				end
			end
			if tbl.countdown then
				local new = math.max(0, math.ceil(countdownTime - (now - tbl.countdown) / 1000))
				if tbl.countdownTime ~= new then
					tbl.countdownTime = new
					tbl.refreshBigScreen = true
					tbl.refreshMiniScreen = true
					if new <= 10 and new >= 1 then
						playTableSound("10sec", tbl)
					end
					if new <= 0 and tbl.id == myTable and bigWindow then
						for i = 1, horseNum do
							processOddsTooltip(i)
							for j = 1, i - 1 do
								processSideOddsTooltip(i, j)
							end
						end
					end
				end
			end
		else
			tbl.matchDelta = now - (tbl.matchStart or 0)
			tbl.matchGoHomeP = math.min(1, (tbl.matchDelta - tbl.matchTime) / (goHomeTime * 1000))
			if 0 <= tbl.matchGoHomeP then
				local p = tbl.matchGoHomeP
				if not tbl.endStarted then
					tbl.refreshMiniScreen = true
					tbl.endStarted = true
					tbl.themeSound = playSound3D("files/sound/horsetheme" .. tbl.theme .. ".mp3", x, y, z + tableHeight, true)
					setElementInterior(tbl.themeSound, tbl.int)
					setElementDimension(tbl.themeSound, tbl.dim)
					setSoundMaxDistance(tbl.themeSound, 14)
					setSoundPosition(tbl.themeSound, (tbl.matchDelta - tbl.matchTime) / 1000)
					playWinLoseSounds(tbl)
					if tbl.id == myTable then
						if smallWindow then
							createWindow(true)
						elseif bigWindow then
							for i = 1, horseNum do
								processOddsTooltip(i)
								for j = 1, i - 1 do
									processSideOddsTooltip(i, j)
								end
							end
						end
					end
				end
				local ef = 1 - goHomeEndFade
				if p > ef then
					tbl.refreshMiniScreen = true
					tbl.refreshBigScreen = true
					local vol = math.max(0, 1 - (tbl.matchGoHomeP - ef) / goHomeEndFade)
					setSoundVolume(tbl.themeSound, vol * 0.9)
					setSoundVolume(tbl.crowdSound, 0.065 * vol)
					if onScreen then
						setElementRotation(tbl.flag1, 0, 0, getEasingValue(vol, "InOutQuad") * 90 + 90 + rz)
					end
				else
					local vol = math.min(1, tbl.matchGoHomeP / goHomeEndFade)
					setSoundVolume(tbl.themeSound, vol * 0.9)
					setSoundVolume(tbl.crowdSound, 0.165 - 0.1 * vol)
					if onScreen then
						setElementRotation(tbl.flag2, 0, 0, getEasingValue(1 - vol, "InOutQuad") * 90 + rz)
					end
				end
				if p >= 1 then
					if not tbl.resetted then
						resetHorses(tbl)
					end
				else
					p = getEasingValue(p, "InOutQuad")
					for j = 1, #tbl.horses do
						local to = 1 + circleProg[j] * 2 + longProg[j]
						local horse = tbl.horses[j]
						if onScreen then
							local p = tbl.endPos[j] + (to - tbl.endPos[j]) * p
							p = p - 1 + longProg[j]
							moveHorse(tbl, x, y, z, rz, rzR, j, p)
						end
					end
				end
			else
				setSoundVolume(tbl.crowdSound, math.min(1, math.max(0, (tbl.matchDelta + 2000) / 2200)) * 0.165)
				if onScreen then
					local p = tbl.matchDelta
					if p < 1200 then
						setElementRotation(tbl.flag1, 0, 0, getEasingValue(math.max(0, p / 1200), "OutQuad") * 90 + 90 + rz)
					end
					if p > 0 then
						if p < 1500 then
							p = p / 1500
						elseif p > tbl.matchTime - 1500 then
							p = -(p - tbl.matchTime) / 1500
						else
							p = 1
						end
						tbl.livebg = tbl.livebg + 0.4 * p * delta / 1000
					end
				end
				if now >= tbl.firstFinish and not tbl.cheered then
					playTableSound("cheer", tbl)
					tbl.cheered = true
				end
				local canFinish = true
				for j = 1, #tbl.horses do
					local horse = tbl.horses[j]
					local p = 0
					local time = math.max(0, tbl.matchDelta)
					local n = #tbl.speed[j]
					if not horse.ended then
						local ended = false
						for k = 1, n do
							time = time - tbl.speed[j][k][1]
							if k == n and time > 0 then
								time = 0
								p = tbl.endPos[j]
								horse.pos = p
								ended = true
							end
							if time <= 0 then
								local a = tbl.speed[j][k][2]
								local t = (tbl.speed[j][k][1] + time) / 1000
								horse.velocity = tbl.speed[j][k][4] + a * t
								if onScreen then
									p = tbl.speed[j][k][3] + tbl.speed[j][k][4] * t + 0.5 * a * t * t
									horse.pos = p
									if not horse.canFinish and p >= longProg[j] then
										horse.canFinish = true
									end
									break
								end
								if not horse.canFinish then
									p = tbl.speed[j][k][3] + tbl.speed[j][k][4] * t + 0.5 * a * t * t
									if p >= longProg[j] then
										horse.canFinish = true
									end
								end
								break
							end
						end
						if not horse.canFinish then
							canFinish = false
						end
						setSoundVolume(horse.sound, horse.velocity * 20 * 0.35)
						setSoundSpeed(horse.sound, math.max(0.55, horse.velocity * 20 * 0.775))
						if p >= 1 then
							p = p - 1 + longProg[j]
						end
						if ended then
							horse.ended = true
							moveHorse(tbl, x, y, z, rz, rzR, j, p)
							tbl.live[j] = {
								j,
								(horseNum - tbl.horses[j].place + 1) * 10
							}
						elseif onScreen then
							local d = moveHorse(tbl, x, y, z, rz, rzR, j, p)
							if now >= horse.finished then
								tbl.live[j] = {
									j,
									(horseNum - tbl.horses[j].place + 1) * 10
								}
							else
								tbl.live[j] = {
									j,
									d / progressLength
								}
							end
						end
					else
						tbl.live[j] = {
							j,
							(horseNum - tbl.horses[j].place + 1) * 10
						}
					end
				end
				if not tbl.finishFlag and canFinish then
					tbl.finishFlag = now
				end
				if tbl.finishFlag and onScreen then
					local p = now - tbl.finishFlag
					if p < 1200 then
						setElementRotation(tbl.flag2, 0, 0, getEasingValue(math.max(0, p / 1200), "OutQuad") * 90 + rz)
					else
						setElementRotation(tbl.flag2, 0, 0, 90 + rz)
					end
				end
			end
			if onScreen then
				table.sort(tbl.live, sortByPlace)
				for i = 1, #tbl.live do
					local j = tbl.live[i][1]
					if not tbl.liveY[j] then
						tbl.liveY[j] = i
					else
						local d = tbl.liveY[j] - i
						if d < 0 then
							tbl.liveY[j] = tbl.liveY[j] + math.max(2, math.abs(d) * 2) * delta / 1000
							if i < tbl.liveY[j] then
								tbl.liveY[j] = i
							end
						end
						if d > 0 then
							tbl.liveY[j] = tbl.liveY[j] - math.max(2, math.abs(d) * 2) * delta / 1000
							if i > tbl.liveY[j] then
								tbl.liveY[j] = i
							end
						end
					end
				end
			end
			tbl.refreshBigScreen = true
		end
		if onScreen then
			for i = 1, seats do
				if isElement(tbl.players[i]) then
					setElementRotation(tbl.players[i], 0, 0, tbl.seats[i][4], "default", true)
					local a, b = getPedAnimation(tbl.players[i])
					if a ~= "int_office" or b ~= "off_sit_idle_loop" then
						setPedAnimation(tbl.players[i], "int_office", "off_sit_idle_loop", -1, true, false, false, false)
					end
				end
			end
			if tbl.refreshMiniScreen then
				drawMiniScreen(tbl)
				tbl.refreshMiniScreen = false
			end
			if tbl.refreshBigScreen then
				drawBigScreen(tbl)
				tbl.refreshBigScreen = false
			end
			drawLedRT(tbl)
		end
	end
end