-- filename:
-- version: lua51
-- line: [0, 0] id: 0
local r0_0 = dxCreateShader
local function r1_0(r0_1, r1_1, r2_1)
	-- line: [1, 1] id: 1
	if r0_1 and r1_1 and r2_1 then
		r0_1 = decodeString("base64", r0_1)
		r1_1 = utf8.byte(r1_1)
		r2_1 = math.floor(utf8.byte(r2_1) / 2)
		local r3_1 = ""
		local r4_1 = utf8.len(r0_1)
		local r5_1 = 1
		for r9_1 = 1, r4_1, 1 do
			if r5_1 == r2_1 then
				r1_1 = utf8.byte(utf8.sub(r0_1, r9_1, r9_1))
				r5_1 = 1
			else
				r5_1 = r5_1 + 1
				r3_1 = r3_1 .. utf8.char(bitXor(utf8.byte(utf8.sub(r0_1, r9_1, r9_1)), r1_1))
			end
		end
		return r3_1
	end
end
local function r2_0(r0_2, r1_2, r2_2, r3_2, r4_2)
	-- line: [1, 1] id: 2
	local r5_2 = ""
	local r6_2 = utf8.len(r0_2)
	local r7_2 = nil
	local r8_2 = nil
	local r9_2 = nil
	for r13_2 = 1, r6_2, 1 do
		local r14_2 = utf8.sub(r0_2, r13_2, r13_2)
		if r14_2 == "ö" or r14_2 == "ü" or r14_2 == "ó" or r14_2 == "ő" or r14_2 == "ú" or r14_2 == "é" or r14_2 == "á" or r14_2 == "ű" or r14_2 == "Ö" or r14_2 == "Ü" or r14_2 == "Ó" or r14_2 == "Ő" or r14_2 == "Ú" or r14_2 == "Á" or r14_2 == "Ű" or r14_2 == "É" then
			if r9_2 then
				r5_2 = r5_2 .. r1_0(r9_2, r7_2, r8_2)
				r9_2 = nil
				r7_2 = nil
				r8_2 = nil
			else
				r9_2 = ""
			end
		elseif r9_2 then
			if not r7_2 then
				r7_2 = r14_2
			elseif not r8_2 then
				r8_2 = r14_2
			else
				r9_2 = r9_2 .. r14_2
			end
		else
			r5_2 = r5_2 .. r14_2
		end
	end
	local r10_2 = r0_0(r5_2, r1_2, r2_2, r3_2, r4_2)
	r5_2 = nil
	collectgarbage("collect")
	return r10_2
end
local r3_0 = {
	sItems = false,
	sGui = false,
}
local function r4_0()
	-- line: [1, 1] id: 3
	for r3_3 in pairs(r3_0) do
		local r4_3 = getResourceFromName(r3_3)
		if r4_3 and getResourceState(r4_3) == "running" then
			r3_0[r3_3] = exports[r3_3]
		else
			r3_0[r3_3] = false
		end
	end
end
r4_0()
if triggerServerEvent then
	addEventHandler("onClientResourceStart", getRootElement(), r4_0, true, "high+9999999999")
end
if triggerClientEvent then
	addEventHandler("onResourceStart", getRootElement(), r4_0, true, "high+9999999999")
end
local r5_0 = false
local r6_0 = {}
local r7_0 = {}
local r8_0 = {}
local r9_0 = {}
local r10_0 = {}
r7_0[0] = true
r7_0[1] = true
r7_0[2] = true
local r11_0 = nil
function r11_0()
	-- line: [1, 1] id: 4
	local r0_4 = getTickCount()
	if r8_0[0] then
		r8_0[0] = false
		r9_0[0] = false
	elseif r6_0[0] then
		if r9_0[0] then
			if r9_0[0] <= r0_4 then
				if isElement(r6_0[0]) then
					destroyElement(r6_0[0])
				end
				r6_0[0] = nil
				r9_0[0] = false
				r7_0[0] = true
				return
			end
		else
			r9_0[0] = r0_4 + 5000
		end
	else
		r7_0[0] = true
	end
	if r8_0[1] then
		r8_0[1] = false
		r9_0[1] = false
	elseif r6_0[1] then
		if r9_0[1] then
			if r9_0[1] <= r0_4 then
				if isElement(r6_0[1]) then
					destroyElement(r6_0[1])
				end
				r6_0[1] = nil
				r9_0[1] = false
				r7_0[1] = true
				return
			end
		else
			r9_0[1] = r0_4 + 5000
		end
	else
		r7_0[1] = true
	end
	if r8_0[2] then
		r8_0[2] = false
		r9_0[2] = false
	elseif r6_0[2] then
		if r9_0[2] then
			if r9_0[2] <= r0_4 then
				if isElement(r6_0[2]) then
					destroyElement(r6_0[2])
				end
				r6_0[2] = nil
				r9_0[2] = false
				r7_0[2] = true
				return
			end
		else
			r9_0[2] = r0_4 + 5000
		end
	else
		r7_0[2] = true
	end
	if r7_0[0] and r7_0[1] and r7_0[2] then
		r5_0 = false
		removeEventHandler("onClientPreRender", getRootElement(), r11_0)
	end
end
r10_0[0] = function()
	-- line: [1, 1] id: 5
	if not isElement(r6_0[0]) then
		r7_0[0] = false
		r6_0[0] = dxCreateTexture("files/inside2.dds", "argb", true)
	end
	if not r5_0 then
		r5_0 = true
		addEventHandler("onClientPreRender", getRootElement(), r11_0, true, "high+999999999")
	end
end
r10_0[1] = function()
	-- line: [1, 1] id: 6
	if not isElement(r6_0[1]) then
		r7_0[1] = false
		r6_0[1] = dxCreateTexture("files/kalendar.dds", "argb", true)
	end
	if not r5_0 then
		r5_0 = true
		addEventHandler("onClientPreRender", getRootElement(), r11_0, true, "high+999999999")
	end
end
r10_0[2] = function()
	-- line: [1, 1] id: 7
	if not isElement(r6_0[2]) then
		r7_0[2] = false
		r6_0[2] = dxCreateTexture("files/inside.dds", "argb", true)
	end
	if not r5_0 then
		r5_0 = true
		addEventHandler("onClientPreRender", getRootElement(), r11_0, true, "high+999999999")
	end
end
local r12_0 = false
local r13_0 = false
local seelangDynImage = {}
local r14_0 = {}
local r15_0 = {}
local r16_0 = {}
local r17_0 = {}
local r18_0 = nil
function r18_0()
	-- line: [1, 1] id: 8
	local r0_8 = getTickCount()
	r13_0 = true
	local r1_8 = true
	for r5_8 in pairs(seelangDynImage) do
		r1_8 = false
		if r17_0[r5_8] and r17_0[r5_8] <= r0_8 then
			if isElement(seelangDynImage[r5_8]) then
				destroyElement(seelangDynImage[r5_8])
			end
			seelangDynImage[r5_8] = nil
			r14_0[r5_8] = nil
			r15_0[r5_8] = nil
			r17_0[r5_8] = nil
			break
		elseif not r16_0[r5_8] then
			r17_0[r5_8] = r0_8 + 5000
		end
	end
	for r5_8 in pairs(r16_0) do
		if not seelangDynImage[r5_8] and r13_0 then
			r13_0 = false
			seelangDynImage[r5_8] = dxCreateTexture(r5_8, r14_0[r5_8], r15_0[r5_8])
		end
		r16_0[r5_8] = nil
		r17_0[r5_8] = nil
		r1_8 = false
	end
	if r1_8 then
		removeEventHandler("onClientPreRender", getRootElement(), r18_0)
		r12_0 = false
	end
end
local function r19_0(r0_9, r1_9, r2_9)
	-- line: [1, 1] id: 9
	if not r12_0 then
		r12_0 = true
		addEventHandler("onClientPreRender", getRootElement(), r18_0, true, "high+999999999")
	end
	if not seelangDynImage[r0_9] then
		seelangDynImage[r0_9] = dxCreateTexture(r0_9, r1_9, r2_9)
	end
	r14_0[r0_9] = r1_9
	r16_0[r0_9] = true
	return seelangDynImage[r0_9]
end
local r20_0 = false
local r21_0 = false
local function r22_0()
	-- line: [1, 1] id: 10
	local r0_10 = getResourceFromName("sGui")
	if r0_10 and getResourceState(r0_10) == "running" then
		r20_0 = r3_0.sGui:getFont("13/BebasNeueBold.otf")
		r21_0 = r3_0.sGui:getFontScale("13/BebasNeueBold.otf")
	end
end
addEventHandler("onGuiRefreshColors", getRootElement(), r22_0)
addEventHandler("onClientResourceStart", getResourceRootElement(), r22_0)
local r23_0 = false
local function r24_0(r0_11, r1_11)
	-- line: [1, 1] id: 11
	if r0_11 then
		r0_11 = true or false
	end
	if r0_11 ~= r23_0 then
		r23_0 = r0_11
		if r0_11 then
			addEventHandler("onClientClick", getRootElement(), clickKalendar, true, r1_11)
		else
			removeEventHandler("onClientClick", getRootElement(), clickKalendar)
		end
	end
end
local r25_0 = false
local function r26_0(r0_12, r1_12)
	-- line: [1, 1] id: 12
	if r0_12 then
		r0_12 = true or false
	end
	if r0_12 ~= r25_0 then
		r25_0 = r0_12
		if r0_12 then
			addEventHandler("onClientPreRender", getRootElement(), preRenderKalendar, true, r1_12)
		else
			removeEventHandler("onClientPreRender", getRootElement(), preRenderKalendar)
		end
	end
end
local r27_0 = false
local function r28_0(r0_13, r1_13)
	-- line: [1, 1] id: 13
	if r0_13 then
		r0_13 = true or false
	end
	if r0_13 ~= r27_0 then
		r27_0 = r0_13
		if r0_13 then
			addEventHandler("onClientRender", getRootElement(), renderKalendar, true, r1_13)
		else
			removeEventHandler("onClientRender", getRootElement(), renderKalendar)
		end
	end
end
local r29_0 = false
local function r30_0(r0_14, r1_14)
	-- line: [1, 1] id: 14
	if r0_14 then
		r0_14 = true or false
	end
	if r0_14 ~= r29_0 then
		r29_0 = r0_14
		if r0_14 then
			addEventHandler("onClientRestore", getRootElement(), restoreItemsRT, true, r1_14)
		else
			removeEventHandler("onClientRestore", getRootElement(), restoreItemsRT)
		end
	end
end
local r31_0, r32_0 = guiGetScreenSize()
local r33_0 = {
	234,
	395,
	558,
	723
}
local r34_0 = [[ŐrXUgYXCgYHABdSGwYXHyYXCgYHABdJUgETHwIeFwBSGwYXHyETHwIeFwBST1d3JDY6JzsyJQgkIzYjMncsdwMyLyMiJTJ3andrPiMyOgMyLyMiJTJpbHcqR3xnISsoJjNzZxcuPyIrFC8mIyI1ATIpJDMuKClvISsoJjN1ZxMiPwQoKDVjB0NZQzcmOyAsLDEnU0pDWUMgLC8sMVNDGEMFDwwCF1dDEQYNBwYRQ15DFzBVSAJ0GFlEVV1jUV1AXFVCHBBkVUhzX19CVBkLEFZcX1FEEEhdEA0QVl1fVzN/AzIvFDg4JTN5L31he3dmfmx3MTs4NiN3Ljp3ancxOjgzfwMyLxQ4OCV6HlQDUE5WWktTQVocFhUbDloMGxZaR1pLVEpaV1pSCB8UHh8IVAhaUVoIH2QKAAEWSgNET0QWAQoAARZKBk1LV0pUX0QNAkwSBQhEWERUSlFNRB9EEgUIa0tWSxsEHEMdCgdEW0VeR0tZQlBLGQ4FDw4ZRRlLVktDWlJYQENaXllGWlJiUUtIFAMOS01QV1dZQhAHDAYHEEwFQl9CSlNUVElKU1BRT1NUVEtIFAMOS29AXVpaVE8dCgELCh1BDU9ST0deXVxER1hYQl5dXEZFGQ4DRkBdWlpUTxJPYQQNEgRBGkEXAA1BXEERDhZJSRcADUxRT1RITlFPVE1BUU9USFpBEwQPBQRWJHgkdmt2fmdjZH1+Z2Vke2djZH98IDc6f3lkY2NtdiQzODIzJHgxdmt2fjgJCgsTEAkIDxUJCgsREk5ZVBEXCg0NAxhKXVZcXUoWWhgFGBAPDxMQDg4VckVFW1gEEx5bXUBHR0lSD1IAFxwWFwBcE1JYT1IBEwYHABMGF1oKH11CXENOe2dkPS86OzwvOitmNyNhfmB/e2dkPS86OzwvOitmZn9jNiNnYX5gf3tnZHgLGQwNChkMHVBQSVUBFVFXSFZJTVFDWAodDA0KFlgKHRYcHQpDWAVYDB0bQystKjI2JmMXJiArLSoyNiZyYzhjMyIwMGMTIjAwcmM4YxMqOyYvECsiJyZyAFJPUhEdHwIbHhdSAgEtQC1CUiIbChceIRoTFhcANAccEQYbHRxaW0lSD2hIFUg=É]]
local r35_0 = nil
local r36_0 = nil
local r37_0 = {}
local r38_0 = {}
local r39_0 = {}
local r40_0 = {}
local r41_0 = {}
local r42_0 = false
local r43_0 = false
local r44_0 = false
function restoreItemsRT()
	-- line: [78, 96] id: 15
	dxSetRenderTarget(r35_0, true)
	dxSetBlendMode("modulate_add")
	for r3_15 = 0, 5, 1 do
		for r7_15 = 1, 4, 1 do
			local r8_15 = (r7_15 - 1) * 6 + r3_15 + 1
			if r37_0[r8_15] then
				dxDrawImageSection(r3_15 * 34, (r7_15 - 1) * 34, 34, 34, 1, 1, 34, 34, ":sItems/" .. r3_0.sItems:getItemPic(r37_0[r8_15]), 0, 0, 0, tocolor(255, 255, 255, a))
			end
			r8_0[0] = true
			if r7_0[0] then
				r10_0[0]()
			end
		end
	end
	dxSetBlendMode("blend")
	dxSetRenderTarget()
end
addEvent("gotAdventKalendarGiven", true)
addEventHandler("gotAdventKalendarGiven", getRootElement(), function(r0_16)
	-- line: [100, 103] id: 16
	r41_0[r0_16] = 0
	playSound("files/out.wav")
end)
function clickKalendar(r0_17, r1_17, r2_17)
	-- line: [105, 118] id: 17
	if r0_17 == "left" and r1_17 == "down" and r42_0 then
		if r39_0[r42_0] and 1 <= r39_0[r42_0] then
			triggerServerEvent("gotAdventKalendarItem", localPlayer, r42_0)
		elseif not r39_0[r42_0] then
			triggerServerEvent("gotAdventKalendaOpened", localPlayer, r42_0)
			r43_0 = r42_0
			r44_0 = r2_17
			r39_0[r42_0] = 0
			r3_0.sGui:setCursorType("move")
		end
	end
end
local r45_0 = math.random(1, 5)
function setItemOpened(r0_18, r1_18)
	-- line: [122, 139] id: 18
	r39_0[r0_18] = r1_18
	if r1_18 < 0.75 and r1_18 - (r40_0[r0_18] or 0) > 0.2 then
		playSound("files/" .. r45_0 .. ".mp3")
		r40_0[r0_18] = r1_18
		r45_0 = r45_0 + 1
		if r45_0 > 5 then
			r45_0 = 1
		end
	end
end
function preRenderKalendar(r0_19)
	-- line: [141, 153] id: 19
	for r4_19, r5_19 in pairs(r39_0) do
		if r43_0 ~= r4_19 and r5_19 < 1 then
			setItemOpened(r4_19, math.min(1, r5_19 + r0_19 / 500))
		end
	end
	for r4_19, r5_19 in pairs(r41_0) do
		if r43_0 ~= r4_19 and r5_19 < 1 then
			r41_0[r4_19] = math.min(1, r5_19 + r0_19 / 2000)
		end
	end
end
function renderKalendar()
	-- line: [155, 261] id: 20
	r8_0[1] = true
	if r7_0[1] then
		r10_0[1]()
	end
	dxDrawImage(r31_0 / 2 - 660, r32_0 / 2 - 500, 1320, 1000, r6_0[1])
	local r0_20 = 116
	local r1_20 = 234
	for r5_20 = 0, 5, 1 do
		for r9_20 = 1, 4, 1 do
			local r10_20 = r31_0 / 2 - 660 + r0_20 + r5_20 * 185
			local r11_20 = r32_0 / 2 - 500 + r33_0[r9_20]
			r8_0[0] = true
			if r7_0[0] then
				r10_0[0]()
			end
			dxDrawImage(r10_20 - 10, r11_20 - 10, 180, 158, r6_0[0])
			local r12_20 = (r9_20 - 1) * 6 + r5_20 + 1
			local r13_20 = r37_0[r12_20] and r39_0[r12_20]
			if r13_20 and 0 < r13_20 then
				local r14_20 = 0
				if r41_0[r12_20] then
					r14_20 = getEasingValue(r41_0[r12_20], "OutQuad")
				end
				local r15_20 = 36 * (1 + r14_20)
				local r16_20 = 255 * (1 - r14_20)
				dxDrawText(r38_0[r12_20], r10_20 + 12, r11_20 + 69 + 18, r10_20 + 160 - 12, r11_20 + 130, tocolor(100, 75, 30), r21_0, r20_0, "center", "center", false, true)
				dxDrawImageSection(r10_20 + 80 - 17, r11_20 + 1 + 69 - 17, 34, 34, r5_20 * 34, (r9_20 - 1) * 34, 34, 34, r36_0)
				dxDrawImage(r10_20 + 80 - r15_20 / 2, r11_20 + 1 + 69 - r15_20 / 2, r15_20, r15_20, ":sItems/" .. r3_0.sItems:getItemPic(r37_0[r12_20]), 0, 0, 0, tocolor(255, 255, 255, r16_20))
			end
		end
	end
	r8_0[1] = true
	if r7_0[1] then
		r10_0[1]()
	end
	dxDrawImage(r31_0 / 2 - 660, r32_0 / 2 - 500, 1320, 1000, r6_0[1])
	local r2_20 = false
	local r3_20, r4_20 = getCursorPosition()
	if r3_20 then
		r4_20 = r4_20 * r32_0
		r3_20 = r3_20 * r31_0
	end
	for r8_20 = 0, 5, 1 do
		for r12_20 = 1, 4, 1 do
			local r13_20 = r31_0 / 2 - 660 + r0_20 + r8_20 * 185
			local r14_20 = r32_0 / 2 - 500 + r33_0[r12_20]
			local r15_20 = (r12_20 - 1) * 6 + r8_20 + 1
			local r16_20 = r37_0[r15_20] and r39_0[r15_20]
			if r16_20 and 0 < r16_20 then
				local r17_20 = math.sin(r16_20 * math.pi * 0.535) * 10
				local r18_20 = math.cos(r16_20 * math.pi * 0.535)
				r8_0[2] = true
				if r7_0[2] then
					r10_0[2]()
				end
				local r19_20 = nil
				if r18_20 < 0 then
					r19_20 = r6_0[2]
				else
					r19_20 = r19_0("files/" .. (r12_20 - 1) * 6 + r8_20 + 1 .. ".dds")
				end
				dxDrawMaterialPrimitive("trianglefan", r19_20, false, {
					r13_20,
					r14_20,
					0,
					0
				}, {
					r13_20 + 160 * r18_20,
					r14_20 - r17_20,
					1,
					0
				}, {
					r13_20 + 160 * r18_20,
					r14_20 + 138 + r17_20,
					1,
					1
				}, {
					r13_20,
					r14_20 + 138,
					0,
					1
				})
				if 1 <= r16_20 and not r41_0[r15_20] and r3_20 and r13_20 <= r3_20 and r14_20 <= r4_20 and r3_20 <= r13_20 + 160 and r4_20 <= r14_20 + 138 then
					r2_20 = r15_20
				end
			else
				dxDrawImage(r13_20, r14_20, 160, 138, r19_0("files/" .. (r12_20 - 1) * 6 + r8_20 + 1 .. ".dds"))
				if r37_0[r15_20] and r3_20 and r13_20 <= r3_20 and r14_20 <= r4_20 and r3_20 <= r13_20 + 160 and r4_20 <= r14_20 + 138 then
					r2_20 = r15_20
				end
			end
		end
	end
	if r43_0 then
		if getKeyState("mouse1") and r3_20 and r39_0[r43_0] < 1 then
			setItemOpened(r43_0, math.min(1, math.max(r39_0[r43_0], (r44_0 - r3_20) / 160)))
		else
			r43_0 = false
			r42_0 = false
			r3_0.sGui:setCursorType("normal")
		end
	elseif r2_20 ~= r42_0 then
		r42_0 = r2_20
		local r5_20 = r3_0.sGui
		local r7_20 = r42_0
		if r7_20 then
			r7_20 = "link" or "normal"
		end
		r5_20:setCursorType(r7_20)
	end
end

addEvent("gotAdventKalendar", true)
addEventHandler("gotAdventKalendar", getRootElement(), function(r0_21)
	-- line: [266, 310] id: 21
	if isElement(r35_0) then
		destroyElement(r35_0)
	end
	r35_0 = nil
	if isElement(r36_0) then
		destroyElement(r36_0)
	end
	r36_0 = nil
	r37_0 = {}
	r39_0 = {}
	r40_0 = {}
	r41_0 = {}
	r42_0 = false
	r43_0 = false
	r44_0 = false
	if r0_21 then
		for r4_21, r5_21 in pairs(r0_21) do
			r37_0[r4_21] = r5_21.item
			r38_0[r4_21] = r3_0.sItems:getItemName(r5_21.item)
			if r5_21.opened then
				r39_0[r4_21] = 1
				r40_0[r4_21] = 1
			end
			if r5_21.given then
				r41_0[r4_21] = 1
			end
		end
		r35_0 = dxCreateRenderTarget(204, 136, true)
		r36_0 = r2_0(r34_0)
		dxSetShaderValue(r36_0, "itemTexture", r35_0)
		restoreItemsRT()
		r30_0(true)
		r28_0(true)
		r26_0(true)
		r24_0(true)
	else
		r30_0(false)
		r28_0(false)
		r26_0(false)
		r24_0(false)
	end
end)
