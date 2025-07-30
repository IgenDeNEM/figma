local r0_0 = dxCreateShader
local function r1_0(r0_1, r1_1, r2_1)
	if r0_1 and r1_1 and r2_1 then
		r0_1 = base64Decode(r0_1)
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
local sightexports = {
	sModloader = false,
	sGui = false,
	sItems = false,
	sControls = false,
	sHud = false,
	sMaps = false,
	sNames = false,
	sWeapons = false,
	sDamage = false,
}
local function r4_0()
	-- line: [1, 1] id: 3
	for r3_3 in pairs(sightexports) do
		local r4_3 = getResourceFromName(r3_3)
		if r4_3 and getResourceState(r4_3) == "running" then
			sightexports[r3_3] = exports[r3_3]
		else
			sightexports[r3_3] = false
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
	if r7_0[0] and r7_0[1] then
		r5_0 = false
		removeEventHandler("onClientPreRender", getRootElement(), r11_0)
	end
end
r10_0[0] = function()
	-- line: [1, 1] id: 5
	if not isElement(r6_0[0]) then
		r7_0[0] = false
		r6_0[0] = dxCreateTexture("files/logo.dds", "argb", true)
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
		r6_0[1] = dxCreateTexture("files/shad.dds", "argb", true)
	end
	if not r5_0 then
		r5_0 = true
		addEventHandler("onClientPreRender", getRootElement(), r11_0, true, "high+999999999")
	end
end
local r12_0 = false
local r13_0 = falselocal
seelangDynImage = {}
local r14_0 = {}
local r15_0 = {}
local r16_0 = {}
local r17_0 = {}
local r18_0 = nil
function r18_0()
	-- line: [1, 1] id: 7
	local r0_7 = getTickCount()
	r13_0 = true
	local r1_7 = true
	for r5_7 in pairs(seelangDynImage) do
		r1_7 = false
		if r17_0[r5_7] and r17_0[r5_7] <= r0_7 then
			if isElement(seelangDynImage[r5_7]) then
				destroyElement(seelangDynImage[r5_7])
			end
			seelangDynImage[r5_7] = nil
			r14_0[r5_7] = nil
			r15_0[r5_7] = nil
			r17_0[r5_7] = nil
			break
		elseif not r16_0[r5_7] then
			r17_0[r5_7] = r0_7 + 5000
		end
	end
	for r5_7 in pairs(r16_0) do
		if not seelangDynImage[r5_7] and r13_0 then
			r13_0 = false
			seelangDynImage[r5_7] = dxCreateTexture(r5_7, r14_0[r5_7], r15_0[r5_7])
		end
		r16_0[r5_7] = nil
		r17_0[r5_7] = nil
		r1_7 = false
	end
	if r1_7 then
		removeEventHandler("onClientPreRender", getRootElement(), r18_0)
		r12_0 = false
	end
end
local function r19_0(r0_8, r1_8, r2_8)
	-- line: [1, 1] id: 8
	if not r12_0 then
		r12_0 = true
		addEventHandler("onClientPreRender", getRootElement(), r18_0, true, "high+999999999")
	end
	if not seelangDynImage[r0_8] then
		seelangDynImage[r0_8] = dxCreateTexture(r0_8, r1_8, r2_8)
	end
	r14_0[r0_8] = r1_8
	r16_0[r0_8] = true
	return seelangDynImage[r0_8]
end
local r20_0 = false
local function r21_0()
	-- line: [1, 1] id: 9
	if not r20_0 then
		local r0_9 = getResourceFromName("sItems")
		if r0_9 and getResourceState(r0_9) == "running" then
			gotAirsoftItems()
			r20_0 = true
		end
	end
end
if triggerServerEvent then
	addEventHandler("onClientResourceStart", getRootElement(), r21_0)
end
if triggerClientEvent then
	addEventHandler("onResourceStart", getRootElement(), r21_0)
end
local r22_0 = false
local r23_0 = false
local r24_0 = false
local r25_0 = false
local r26_0 = false
local r27_0 = false
local r28_0 = false
local r29_0 = false
local r30_0 = false
local r31_0 = false
local r32_0 = false
local r33_0 = false
local r34_0 = false
local r35_0 = false
local r36_0 = false
local r37_0 = false
local r38_0 = false
local r39_0 = false
local r40_0 = false
local r41_0 = false
local r42_0 = false
local r43_0 = false
local r44_0 = false
local r45_0 = false
local r46_0 = false
local function r47_0()
	-- line: [1, 1] id: 10
	local r0_10 = getResourceFromName("sGui")
	if r0_10 and getResourceState(r0_10) == "running" then
		r22_0 = sightexports.sGui:getFont("25/BebasNeueRegular.otf")
		r23_0 = sightexports.sGui:getFontScale("25/BebasNeueRegular.otf")
		r24_0 = sightexports.sGui:getFontHeight("25/BebasNeueRegular.otf")
		r25_0 = sightexports.sGui:getFont("35/Impact.ttf")
		r26_0 = sightexports.sGui:getFontScale("35/Impact.ttf")
		r27_0 = sightexports.sGui:getFontHeight("35/Impact.ttf")
		r28_0 = sightexports.sGui:getTextWidthFont("NYEREMÉNYED", "35/Impact.ttf")
		r29_0 = sightexports.sGui:getFont("40/BebasNeueBold.otf")
		r30_0 = sightexports.sGui:getFontScale("40/BebasNeueBold.otf")
		r31_0 = sightexports.sGui:getFontHeight("40/BebasNeueBold.otf")
		r32_0 = sightexports.sGui:getFont("20/BebasNeueBold.otf")
		r33_0 = sightexports.sGui:getFontScale("20/BebasNeueBold.otf")
		r34_0 = sightexports.sGui:getFont("20/BebasNeueBold.otf")
		r35_0 = sightexports.sGui:getFontScale("20/BebasNeueBold.otf")
		r36_0 = sightexports.sGui:getTextWidthFont("100", "20/BebasNeueBold.otf")
		r37_0 = sightexports.sGui:getColorCodeToColor("sightred")
		r38_0 = sightexports.sGui:getColorCodeToColor("sightblue")
		r39_0 = sightexports.sGui:getColorCodeToColor("sightgreen")
		r40_0 = sightexports.sGui:getColorCodeToColor("sightlightgrey")
		r41_0 = sightexports.sGui:getColorCode("sightorange")
		r42_0 = sightexports.sGui:getColorCode("sightgreen")
		r43_0 = sightexports.sGui:getColorCode("sightred")
		r44_0 = sightexports.sGui:getColorCode("sightblue")
		r45_0 = sightexports.sGui:getColorCode("sightlightgrey")
		r46_0 = sightexports.sGui:getColorCode("sightyellow")
	end
end
addEventHandler("onGuiRefreshColors", getRootElement(), r47_0)
addEventHandler("onClientResourceStart", getResourceRootElement(), r47_0)
local function r48_0()
	-- line: [1, 1] id: 11
	loadModels()
end
addEventHandler("modloaderLoaded", getRootElement(), r48_0)
if getElementData(localPlayer, "loggedIn") or sightexports.sModloader and sightexports.sModloader:isModloaderLoaded() then
	addEventHandler("onClientResourceStart", getResourceRootElement(), r48_0)
end
local r49_0 = false
local function r50_0(r0_12, r1_12)
	-- line: [1, 1] id: 12
	if r0_12 then
		r0_12 = true or false
	else
		r0_12 = false
	end
	if r0_12 ~= r49_0 then
		r49_0 = r0_12
		if r0_12 then
			addEventHandler("onClientHUDRender", getRootElement(), pityuHandler, true, r1_12)
		else
			removeEventHandler("onClientHUDRender", getRootElement(), pityuHandler)
		end
	end
end
local r51_0 = false
local function r52_0(r0_13, r1_13)
	-- line: [1, 1] id: 13
	if r0_13 then
		r0_13 = true or false
	else
		r0_13 = false
	end
	if r0_13 ~= r51_0 then
		r51_0 = r0_13
		if r0_13 then
			addEventHandler("onClientRender", getRootElement(), renderAirsoftWin, true, r1_13)
		else
			removeEventHandler("onClientRender", getRootElement(), renderAirsoftWin)
		end
	end
end
local r53_0 = false
local function r54_0(r0_14, r1_14)
	-- line: [1, 1] id: 14
	if r0_14 then
		r0_14 = true or false
	else
		r0_14 = false
	end
	if r0_14 ~= r53_0 then
		r53_0 = r0_14
		if r0_14 then
			addEventHandler("onClientKey", getRootElement(), resultKey, true, r1_14)
		else
			removeEventHandler("onClientKey", getRootElement(), resultKey)
		end
	end
end
local r55_0 = false
local function r56_0(r0_15, r1_15)
	-- line: [1, 1] id: 15
	if r0_15 then
		r0_15 = true or false
	else
		r0_15 = false
	end
	if r0_15 ~= r55_0 then
		r55_0 = r0_15
		if r0_15 then
			addEventHandler("onClientKey", getRootElement(), airsoftKey, true, r1_15)
		else
			removeEventHandler("onClientKey", getRootElement(), airsoftKey)
		end
	end
end
local r57_0 = false
local function r58_0(r0_16, r1_16)
	-- line: [1, 1] id: 16
	if r0_16 then
		r0_16 = true or false
	else
		r0_16 = false
	end
	if r0_16 ~= r57_0 then
		r57_0 = r0_16
		if r0_16 then
			addEventHandler("onClientRender", getRootElement(), renderAirsoftGui, true, r1_16)
		else
			removeEventHandler("onClientRender", getRootElement(), renderAirsoftGui)
		end
	end
end
local r59_0 = false
local function r60_0(r0_17, r1_17)
	-- line: [1, 1] id: 17
	if r0_17 then
		r0_17 = true or false
	else
		r0_17 = false
	end
	if r0_17 ~= r59_0 then
		r59_0 = r0_17
		if r0_17 then
			addEventHandler("onClientPreRender", getRootElement(), preRenderAirsoftGui, true, r1_17)
		else
			removeEventHandler("onClientPreRender", getRootElement(), preRenderAirsoftGui)
		end
	end
end
local r61_0 = false
local function r62_0(r0_18, r1_18)
	-- line: [1, 1] id: 18
	if r0_18 then
		r0_18 = true or false
	else
		r0_18 = false
	end
	if r0_18 ~= r61_0 then
		r61_0 = r0_18
		if r0_18 then
			addEventHandler("onClientPreRender", getRootElement(), setRefreshScoreboard, true, r1_18)
		else
			removeEventHandler("onClientPreRender", getRootElement(), setRefreshScoreboard)
		end
	end
end
local r63_0 = false
local function r64_0(r0_19, r1_19)
	-- line: [1, 1] id: 19
	if r0_19 then
		r0_19 = true or false
	else
		r0_19 = false
	end
	if r0_19 ~= r63_0 then
		r63_0 = r0_19
		if r0_19 then
			addEventHandler("onClientHUDRender", getRootElement(), hudRenderAirsoft, true, r1_19)
		else
			removeEventHandler("onClientHUDRender", getRootElement(), hudRenderAirsoft)
		end
	end
end
local r65_0 = false
local function r66_0(r0_20, r1_20)
	-- line: [1, 1] id: 20
	if r0_20 then
		r0_20 = true or false
	else
		r0_20 = false
	end
	if r0_20 ~= r65_0 then
		r65_0 = r0_20
		if r0_20 then
			addEventHandler("onClientRender", getRootElement(), matchLoadingScreen, true, r1_20)
		else
			removeEventHandler("onClientRender", getRootElement(), matchLoadingScreen)
		end
	end
end
local r67_0 = false
local function r68_0(r0_21, r1_21)
	-- line: [1, 1] id: 21
	if r0_21 then
		r0_21 = true or false
	else
		r0_21 = false
	end
	if r0_21 ~= r67_0 then
		r67_0 = r0_21
		if r0_21 then
			addEventHandler("onClientPreRender", getRootElement(), preRenderMatchSelector, true, r1_21)
		else
			removeEventHandler("onClientPreRender", getRootElement(), preRenderMatchSelector)
		end
	end
end
local r69_0 = false
local function r70_0(r0_22, r1_22)
	-- line: [1, 1] id: 22
	if r0_22 then
		r0_22 = true or false
	else
		r0_22 = false
	end
	if r0_22 ~= r69_0 then
		r69_0 = r0_22
		if r0_22 then
			addEventHandler("onClientKey", getRootElement(), matchSelectorKey, true, r1_22)
		else
			removeEventHandler("onClientKey", getRootElement(), matchSelectorKey)
		end
	end
end
local r71_0 = false
local function r72_0(r0_23, r1_23)
	-- line: [1, 1] id: 23
	if r0_23 then
		r0_23 = true or false
	else
		r0_23 = false
	end
	if r0_23 ~= r71_0 then
		r71_0 = r0_23
		if r0_23 then
			addEventHandler("onClientKey", getRootElement(), mapSelectorKey, true, r1_23)
		else
			removeEventHandler("onClientKey", getRootElement(), mapSelectorKey)
		end
	end
end
local r73_0 = false
local function r74_0(r0_24, r1_24)
	-- line: [1, 1] id: 24
	if r0_24 then
		r0_24 = true or false
	else
		r0_24 = false
	end
	if r0_24 ~= r73_0 then
		r73_0 = r0_24
		if r0_24 then
			addEventHandler("onClientPreRender", getRootElement(), matchJoinPreRender, true, r1_24)
		else
			removeEventHandler("onClientPreRender", getRootElement(), matchJoinPreRender)
		end
	end
end
local r75_0 = false
local function r76_0(r0_25, r1_25)
	-- line: [1, 1] id: 25
	if r0_25 then
		r0_25 = true or false
	else
		r0_25 = false
	end
	if r0_25 ~= r75_0 then
		r75_0 = r0_25
		if r0_25 then
			addEventHandler("onClientKey", getRootElement(), matchJoinKey, true, r1_25)
		else
			removeEventHandler("onClientKey", getRootElement(), matchJoinKey)
		end
	end
end
local r77_0 = "ÖkHSx8OEx8eGQ5LDD8OEx8eGQ5bS1dLGB8ZAgUMSx8OEx8eGQ5CETYjNid/YHJuFic6NjcwJ2B5Ynx5YissNmIBFxEWDQ8EDgNxNiJRTVECBQMYHxZRAhoYASQfBAIUFSEQAxAcFAUUAwJRTFFUdi0xJ3ZvdGpvdCAxLCAhJjF0JzE3OzowBgB0aHQnICY9OjN5WQscFx0cCy0YCx4cDVlEWVsAHApbQllHQlkKGBQJFRwLWTpwHxwfAiMRHQAcFQJQTVADER0AHBUCLwMEEQQVUAtQJBUIBAVDMSZjfmNrJBcmOzc2MSZzanhjPnhjMDcxNiA3YxMQCi0zNjdaeiF6PDY1Oy5uego1KTMuMzU0emB6ChUJEw4TFRRqYXo8NjVJKD17aR0sMQomJjstaXNpHQwRCgYGGw15cmkvJSYoPX1pDSBGICAzNSNmfGYFCQoJFHZ9Zjt9ZjUyNDMlMmYWLz4jKmY9ZiBwHB8RBERQMx8cHwJQSlAzPzw/IkBLUBYcHxEERFA1CAQCEVBSaHIRHR4dAGNpci9pcgI7Kjc+cgI7Kjc+ATozNjcgFCc8MSZoAQcGQDg7IQYYHRxIODtBSBNIOAEQDQRIBx0cGB0cU0gOBAdsDRhMGAkUCQAtABwEDUxRTBgJFF4oRC8DAAMePw0BHAAJHkBrSzs4RT8OEygEBBkPRRMSQkUKUEsEHh8bHh9FKAQHBBlLVktEIigrJTBwbHRoZHRoZHRoZCktKmwwITwhKAUoNCwlZG5kFBd4VjwRHh4NCx1WGVRYSFZISE5JSE1RUUNYFw0MCA0MVj0ADApVNHVodTM5OjQhYX1keXVkeXVkeXUhMC0wORQ5JT00fG51JzBRJSQjP3E+JCUhJCVqcSxxJTQyOT84ICQ0cSE0NQ4mMD09DjxqGB5KEUoaCxkZSjpaShFKMC8ECwgGD0pXSgwLBhkPUUorBhpiCgMgDgcMBicMAwAOB0JfQhYQFwdZQiMOEgoDMAcEQl9CU1lUdAQ9LDE4Bzw1MDEmdGl0Nzs5JD04MXQkJwtmC2R0BD0sMThsPwQNCAkeKhkCDxgFAwJERVdMEUwRTA==ű"
local r78_0 = "Ű0fEFZcX1FEBBBDc19cX0JZSlVgVVQQDRBWXF9RRAQYARwAHgEcAB4BHAAeBRkLEFZcX1FmElRGFTQDFUZbRgAKCQcSVE5eVlZKUFZWT11GEgMeEhMUA0YVMgMeVl1GFQcLFgoDFEZ6KRsXChYfCEpaR1oJGxcKFh8IJQkOGw4fWgFaLh8CDg8IH1pHWkYJLh8CSkRBWjcTFDxaMzYuPyh6Z3oWMzQ/Oyhhehc7PRwzNi4/KHpnehYzND87KGF6FzMqHDM2Lj8oemd6FjNNIygsP3ZtDCkpPyg+PhhtcG0AJD8/Ij92bQwpKT8oPj4bbXBtACQ/PyI/dm0wdm0rISJ2FwJCViYfDhMaJR4XEhMEMAMYFQIfGRheEBoZFwJEVgMAVkxWIjMuNTk5JDJGX1ZMVjUyfX59YAISSRJUXl1TRhJbXEJHRnFdXhIPEkZXSgB2GmFTX0JeV0ACHhJHRBscQAkSVF55FhgNWRYMDQkMDToWFRYLWURZEBcJDA06FhVCWR8WC1lRHxUWGA1ZEFlEWUhCWRBZRVlyQUlSG1lZW1IJUh0HBgIHBjEdHh0AUllPUgYXCkA2WiETHwIeFwBCXlIUHh0TBkBaBwRGaD5qZjMwaD9mbWZuL2ZsZndpNRQjNWg/b29vaDR9ZikzMjYzMgUpKik0Zm17ZjIjPnRvK0c8DgIfAwodX0NPCQMADhtdRxoZQRdDTxoZQRZPQk9HBk9FT15AHD0KHEEWRkZGQR04AxhXTUxITUx7V1RXShgTBRhMXUAKfBBrWVVIVF1KCBQYXlRXWUwKEE1OFkAYFRgQURh6UFpLVQkoHwlUAlNWWg8MVANTU1QIQVoVDw4KDw45FRYVCFpRR1oOHwJIPlIpGxcKFh9wAkBcUBYcHxEEQlgFBl4IUFtQWBlQWlBBXwMiFQNeCFlcUAUGXglZWV4CS1ANUB8FBABnEhMkCAsIFUdIWkdeXEcVAhMSFQlHFAYTEhUGEwJPTwgSExcSEyQICwgVSg4JFxITJAhQPHl6ZnlwenAjEz88PyI5KjUANTRrcC1wJDUzOD45ISU1cDU0NzVwK3AgMSMjcAAxIyN6S1oBWikIGTgWHxQeWkdaKQgZOxYKEhtBWj4fCQ44Fh8UHlpHWjUUH0FaKhMCHxYpEhsyVldAEg8SUV1fQlteVxJCQW0AbQISYltKV15hWlNWV0B0R1xRRltdXBobCRJPEk8Sű"
local r79_0 = "üKvay0nJCo/f2s4CCQnJDkiMS4bLi9rdmstJyQqP39jemd7ZXpne2V6Z3tlfmJway0nJCo/azgYOy4oPnUZFAclGgIQB1VIVUdOVRMZGhQBVQYiGgcZESMcEAIlGgY4ABkBVUhVRE5VARANAQAHEFUSIRANAQAHNVAFFQkVRkFHXFtSFUFQTUFAR1BmQVRBUAgXBRlhUE1BQEdQFw4VCw4VU1laVEEBTQEVUmJaR1lRFQ9hQTYuMy0lWkEHDQ4AFVUZVUEGNwgEFkFbQTcoJDZaQQcNDgAVVRlVQQYxEw4LBAIVCA4PW0ExMy4rJFgbDBEXFmN4PjQ3OSxreD8bOTU9KjkcMSo9OywxNzZ4YngbGRUdChkcEQodGwwRFxZjeDE2LHgbDQsMVhkbEBoXEQV2aiUiJD84MXY1JDM3IjMYOSQ7Nzoldmt2dC8zJXRtdiUiJD84MXYlPT8mAzgjJTMyBjdHNSYqIjMiNTRnemdlPiI0ZXxneXxnNCYqNysiNWcEKCsoNRQmKjcrIjVnemc0Jio3KyI1GDQzJjMiZ1oheg4/Ii4vKD96Z3pyPQ4/Ii4vKD9qc2F6J2F6KS4oLzkuegwJEzQqLy56IXo8NjU7Lm56CjUpMy4zRSorZX9lFQoWDBEMCgt1fmUjKSokMXZlCyo3KCQpZX9lCwoXCAQJdX5lIykqJDF3ZREgPQYqKjchZX93VyMyLzQ4OCUzR0xXCkxXBAMFAhQDVyckPhkHAgNXDFcRGxgWA0NXJxgEHgMeGBlXTVcnOCQ+Iz44OWlZUkkPBQYIHVtJPQwRKgYGGw1JU0k9LDEqJiY7LVlSSQ8FBggdSToZDAolAA4BHQAHDklTST0sMSomQg0QBnN5Yj95YhIRCywyNzZiFCcwNic6ESojJicwBDcsITYrLSxqFBELLDI3NmIUEWtiOWISEQssMjcxRRFhYhEMERlhYnhfQURFGAEKEVddXlBFBRFGXkNdVWFeQhEMEVxEXRlXXV5QRQUZZ2IfYV5CWEVYXnQaWgwNDlhURVpEXVgTIxsGGBBdT1QSGBsVAEBUAh0RAyQbB1RJVBkBGFwDGwYYECQbB1hUEyIdEQNdSXJpGRpnGSY6ID0gJidpdGkkPCVhPyAsPhkmOmVpLhk7JiMsKj0gJidgcmkZGmcdLDEKJiY7LWl0aR9PHGEbKjcMICA9K3RvKSMgLjt8bwEgPSIuI29ybyEgPSIuIyY1KmciOiNnGRxhASA9Ii4jY29nKSMgLmkdWhFaQA4+BhsFDUBAUkkPBQYIHUkNBh05GwYNHAodSVRJDQYdQUQOKggEDBsILQAbDAodAAYHRUknehUIFxsWU0FaKilUKQofGTYTHRIOExQdWkdaCRsODwgbDh9SChUNUh4VDioIFR4PGQ5WWgkpCh8ZDxZKKzgaJT0vOGNjcWo4Lz4/OCRqGhlxajdqLCYlKz5+ahojMi8mGSIrLi84DD8kKT4jJSRiGhkDJDo/PnZWJiVfVkxWNTk6OSRGVg1WEBoZFwJCVhkDAgYDAk1WEBoZFwJWAhMOExo3GgYeF1ZLVgITDkQyXjUZSyckORgqJjsnLjlnGxhlHy4zCCQkOS9iZSpwayQ+Pzs+P2t2azgIJCckOSIxLhsuL3BrJD4/Oz4/ZSp3V11KVwQWAwIFFgMSX0ZXWlcnJFkkBxIUOx4QHwMeGRBXXVdFXkxXGAIDBwIDWRZXXUpXAxIPEhs2GzVFXVQOFVpAQUVAQRtUFQgVWFRNHVpAQUVAQRtUGRUFGwUFAwQFABwOFUdQQUBHWxVaQEFFQEEOFUgVaBwNCwAGARkdDUgYDQw3HwkEBEgTSBgJGxtIOFhIE0gsDRgcACoBCRtVRVhGWFhYWlNIKQQYAAkqBA1ZNz0cNzg7NTx5ZHktKyw8YnkYNSkxOAs8P3lkeWhieQorOhs1PDc9eWR5Cis6GDUpMThieR08Ki0bNXEUHxVRTFE+HxRKUScUAwUUCSIZEBUUA1FMURIeHAEYHRRRBwIuQy5BUScUAwUUCSIZEBUUAzcEHxIFN15YWR8eDBdnXk9SW2RfVlNSRRcKF1RYWkdeW1IXR0RoBWgHF2deT1JbZF9WU1JFcUJZVENeWFkfHgwxEUwRTBE=ö"
local r80_0 = "Ü7dF1FbWFZDAxdEVFhbBRcKF1FbWFZDAx8GGwcZBhsHGQYbBxkCHgwXUVtYVkMDF0RUWGUJVEVYRQMJCgQRUU1USVVLVElVS1RJVUtQTF5FAwkKBBFRRRYGCglVRVhFAwkKBBFRR292a3dpdmt3aXZrd2lybnxnISsoJjN1ZzQVIjRnemchKygmM3Vvf3d3a3F3d258ZzNlAB0REBcARRYxAB1VXkUWBAgVCQAXRTYECBUJABdVRVhFFgQIFQkAFzoWEQQRAEUeRWw4CRQYGR4JTFFMUB84CRRcUldMIQUCKgUAGAkeTFFMIAUCCQ0eV0whDQsqBQAYCR5MZFlEKA0KAQUWX0QpDRQiDQgQARZEWUQoDQoBBRZfRCUAABYBFxcxRFlEKQ0WFgsWX0R6Ox4eCB8JCSxaR1o3EwgIFQhBWgdBWhwWFRsOTloqEwIfFikSGx4fCDwPFBkOExUUUjRSWFtVQAYUQUIUDhRgcWx3e3tmcAQdFA4Ud3t4e2YEFE8UUlhbVUAAFF1aREFAd1tYORkEGU1cQQt9EWpYVElVXEsJFRlMTxACGV9VVlhNDRlWTE1JTE16VlVWSxkEGVBXSUxLPwgkJ3BrLSQ5a2MtJyQqP2sia3ZrenBrImt3a3hwayJgYGJrMGskPj87Pj8IJCckOVl5cmR5LTwhax1xCjg0KTU8K2l1eT81Njgta3EsL3chdXksL3cgeXJ5cTB5c3lodioLdRAGWwxcXFxOVRoAAQUAATYaGRoHVV5IVQEQDUcxXSYUGAUZEAdFWVUTGRoUAUddAANLZTNnaz49ZTJrZmtjImtha3pkOBkuOGUyYmJicGskPj87Pj8IJCckOWtgdms/LjN5D0JqESMvMi4nMHJuYiQuLSM2cGo3NGw6Ym9iaitiaGJzbTEQJzFsOmtuYjc0bDtra3lich0HBgIHBjEdHh0AUllPUgYXCkA2WiETHwIeFwBCXlIUHh0TBkBaBwRcClJZUlobUlhqSltFGTgPGUQSQ0ZKHxxEE0NDUUoXSgUfHhofHikFBgUYSkVXSlNRSgwGBQseXkoJBW4CTlNORgEbGh4bGi0BAgEcQAxOUE5eTlFOHQ0BAlxOVE5GARsaHhsaLQECARxACU5QTW19bXJtPi4iIXxtd20+LiIhfWRkdm0/KDk4PyNtZT4sOTg/LDkoZWUiODk9ODkOIiFxHgNfA1wYHwEEBTIeHV8DWFtHWFFaUR4EBQEEBTIeHR4DXwNbQV9GRFhbEh4dSlEMUW4aCw0GAAcfGwtOCwoJC04VTh4PHR1OPg8dHV9OFU49HA0sAgsACk5TTj0cDS8CHgYPMAsQdFVDRHJcVV5UEA0Qf15VCxBgWUhVXGNYUVRVQhANEFNfXUBZXFUQQENvAm8AEGBKIzIvJhkiKy4vOAw/JCk+IyUkYmNxajdqN2o=ö"
local r81_0 = "öCfYyUvLCI3YzMxLCRjfmNzeGMlLywiN3djLCBjfmMlLywiN3drcm9jc29jc29jcmp4YyVhDQ4AFVUZVUEGNg4TDQVBW0E2LjMtJVpBBw0OABVVGVVBBjcIBBZBW0E3KCQ2WkEHDQ5SMyZmKmZyNQIgPTg3MSY7PTxocgIAHRgXEQYbHRxpciY3KiYnIDdyNQY3KiYnIDdicm5CYjE2MCssJWI2Jzo2NzAnETYjNid/YHJuFic6NjcwJ2B5Ynx5YissNmIBFxEWDQ8EDgNtKj5NUU0eGR8EAwpNHgYEHTgDGB4ICT0MHwwACBkIHx5NUE1PFAgeT1ZNU1ZNGQgVGRhqGA9KGQ8JBQQOOD5KVkoZHhgDBA1KGA8EDg8YPgsYDQ8eSldKSBMPGUhRSlRRShkLBxpCLicwYgEtLi0wESMvMi4nMGJ/YjEjLzIuJzAdMTYjNidiOWIWJzo2NzAnYn9iaiUWJzpxBQQDFEFYSlEMSlECBQMEEgVRJyI4HwEEBVEKURcdHhAFRVEhHgIYBRgeH1FLUSE+IjhxJTg+P0FKURcdHhAFQ1ElFAkyHh4DFVFLUSU0KTI+PiM1QUpRDEpRAgUDBBIFUSEiOB85SUxNGUIZX1VWWE0NGWlWSlBNUFZXGQMZaXZqcG1wdncJAhlfVVZYTQsZbVxBelZWS11ZeWN5DRwBGhYWCx1pYnk/NTY4LXkRPDA+MS15Y3kNHAEaFhYLHWhieSRieQkKEDcpLC1Lax0uOT8uMxgjKi8uOQ0+JSg/IiQlYx0YAiU7Pj9rHRhiazBrGxgCJTs+P2sbGGt2a2NnNzQuCRcSE05XXEc3NEkvAg4ADxNHWkcxNEk3CBQOEw4ICUkdSFZJV1dUTFdJUlxHAQtSPTMmZnIlPSA+NgI9IXJvcj8nPno0Pj0zJmZ6BAF8Aj0hOyY7PTx8KisofnJjfGJ7fjVJHiY7JS1gcmkvJSYoPX1pPyAsPhkmOml0aSQ8JWE+JjslLRkmOmVpLh8gLD5gcmkZGmd6KhUJEw4TFRRaR1oXDxZSDBMfDSoVCVZaHSoIFRAfGQ4TFRRTQVoqKVQuHwI5FRUIHlpoVUg+O0Y8DRArBwcaDFNIGg0cHRoGSDg7U0gVSBscGh0LHEg4ARANBEgTSA4EBwkcXEgxcl5dXkMRCxFyfn1+YwEKEVddXlBFBRF0SUVDUBELEXJ+fX5jAAoRTAoRYVhJVF0RYVhBOSQtEikgJSQzBzQvIjUoLi9pERIILzE0NWEREmhhOmERKDkkLWEuNDUxNDV6YS40NTEwRUQec19cX0IQDRBWXF9RRAQYABwQABwQABwQAB4AAAYBAAUZCxBZVhhgYx54VVlXWER0VEpUBAYbE11UGwEABAEAWjEMAAYVVElUEhgbFQBAXEVYVERYVERYVEVdT1QRGAcRVBtHMjM3MjNpAj8zNSZnemcoJHxnNSIzMjUpZygyMzcyM3xnOmczIiQvKS42MiJnNyIjGDBkBQgIOwkWEEQfRBQFFxdENFREH0Q+IQoFBggBRFlEAgUIFwFfRCUIFAwFJggBCgAhCgVCIC4nYn9iNjA3J3liAy4yKiMQJyRif2JzeWIUJzA2JzoRKiMmJzBif2IhLS8yKy4nYjRwAy9CL0BQJhUCBBUIIxgRFBUCNgUeEwQZHx5YWUtQIBkIFRwjGBEUFQJQTVATHx0AGRxNKG09PhJ/En1tHSQ1KCEeJSwpKD8LOCMuOSQiI2Vkdm0wbTBtá"
local r82_0 = "ópVUBYcHxEERFADEx8cQVBNUBYcHxEERFhBXEBeQVxAXkFcQF5FWUtQFhwfMFFEBBBDU19cABANEFZcX1FEBBgBHAAeARwAHgEcAB4FGQsQVlxfUUQQQFooNT16Z3pqYXo8NjU7LnopCSo/OS82OygKNS0/KHpnemhhejw2NTsueiljNAwRDwc1CgYUMwwQLhYPF0NeQ1JYQwUPDAIXVxtXQwQ0DBEPB0NZQzQsdCY4ME9UEhgbFQBADEBUEyIdEQNUTlQiPTEjT1QSGBsVAEAMQFQTJAYbHmYDBRIPCQhcRjY0KSwjJTIvKShdRgAKCQcSVUYBJQcLAxQHIg8UAwUSDwlaNHpgehkbFx8IGx4TCB8ZDhMVFGF6MzQuehkPCQ4VFxwWGx0JemYpLigzN1lQF1RFUlZDUnlYRVpWW0QXChcVTlJEFQwXRENFXllQF0RcXkdiWUJEUjRQZFVGVVlRQFFGRxQJFBZNUUcWDxQKDxRHQEZBV0AUYmd9WkRBQBRPFFJOIiEvOnpuHiE9JzonISBudG4eAR0HGgcBAH51bigiIS86fW4AITwjLyJuNQ8Ve3pneHR5BQ4VU1laVEEHFWFQTXZaWkdRFQ8VYXBtdnp6Z3EFDhVIDlh4KywqLTsseAgLETYoLSx4I3g+NDc5LGx4CDcrMSwxNzZ4YngIFwsRDBFmKShWXUYACgkHElRGMgMeJQkJFAJGXEYyIz4lKSk0IlZdRgAKCQcSRjUWZAEHKA0DDBANCgNEXkQwITwnKys2IFVfRAIICwUQRCwBDQMMEEReRDAhPGckKCg1I1VcRxpcRzc0LgkXEhNHMQIVEwIfNA8GAwIVIRIJBBMOCAlPMTRhKA8RFBVBNzJIQRpBMTIoDxEUFUExMkFcQUkxMigPERQVSFFaQTEyTykEWDE/MCx4ZXgOC3YINysxLDE3NnYid2l2aGhrc2h2bWN4PjQ3OSxseC83KlY6MgY5JXZrdjsjOn4wOjk3ImJ+AAV4BjklPyI/OTh4Li8senZneGZ/ejFyJR0AHhZbSVIUHh0TBkZSBBsXBSIdAVJPUh8HHloFHQAeFiIdAV5SFSQbcRQGWEpRISJfIR4CGAUYHh9RTFEcBB1ZBxgUBiEeAl1RFiEDHhsUEgUYHkMtanhjExBtFyY7ACwsMSdjfmMVEG0XJjsALCwxJ3hjJS8sIjdwYw0sMS5wERxQTVAeHwIdERwZChVYHQUcWCYjXj4fAh0RHFxQWBYcHxEEQwhDWRcnaAcaBAxBQVNIDgQHCRxIDAccOBoHDB0LHEhVSAwHHEBFDysJBQ0aCSwBGkovKT4jJSRmagQlOCcrJmNxahoZZBk6LykGIy0iPiMkLWp3ajkrPj84Kz5VMH0lOiJ9MTohBSc6MSA2IXl1JgYlMDYgOTQnBToiMCd8fG51JzAhICc7ZUU1Nl5FGEUDCQoEEVFFNQwdAAk2DQQBABcjEAsGEQwKC001NiwLFRARRU4eHWdudG4NAQIBHH5uNW4oIiEvOnpuITs6Pjs6dW4nKGYeHWAGKycpJjo5GQcZSUtWXhAZVkxNSUxNGQQZSlpWVQkCGVxVSlwZVkxNSUxNGQQZSlpWNloHDRZZQ0JGQ0IYVxYcCxZFV0JDRFdCUx4HFhsWZmUYZUZTVXpfUV5CX2oEDUpASlhDUUoFHx4aHx5EC0pXSgcLEkIFHx4aHx5EC0ZKWkRaWlxbWl8zGggTQVZHRkFdE1xGR0NGRxMYE0BQXF8DGQMdAggTThNHVlBbXVpCRlYTZBQBADsTBQgIRB9EFAUXF0Q0VEQfRCABFBAMJg0FF1lJVEpUVFRWX0QlCEIyKiMALicsJgcsIyAuJ2J/YjYwNyd5YgMuMiojECckYn9ic3liETAhAC5QNT40cG1wAyIzETwgODFrcBQ1IyQSPDU+NHBtcB8+NWtwBjUiJDUoAzgxdhITBFZLVhUZGwYfGhNWAAUpRClGViATBAITDiUeFxITBDADGBUCHxkYXk9mdG8fJjcqIxwnLisqPW9ybywgIj8mIypvPzwQfRB/bx8mNyojHCcuKypSIBQnPDEmOz08entpci9yL3I=Ó"
local r83_0, r84_0 = guiGetScreenSize()
local r85_0 = false
local r86_0 = false
local r87_0 = false
local r88_0 = false
local r89_0 = false
local r90_0 = false
r91_0 = {}
local r92_0 = 0
local r93_0 = false
local r94_0 = false
local r95_0 = false
local r96_0 = {}
local r97_0 = createPed(312, 1000.8115234375, -1485.5283203125, 1999.1875, 90)
setElementFrozen(r97_0, true)
setElementData(r97_0, "invulnerable", true)
setElementData(r97_0, "visibleName", "Sam Miller")
setElementData(r97_0, "pedNameType", "Airsoft")
setElementInterior(r97_0, 1)
setElementDimension(r97_0, 1)
r96_0[r97_0] = true
local r98_0 = createPed(3, 1000.8115234375, -1489.5283203125, 1999.1875, 90)
setElementFrozen(r98_0, true)
setElementData(r98_0, "invulnerable", true)
setElementData(r98_0, "visibleName", "Joe Sean")
setElementData(r98_0, "pedNameType", "Airsoft")
setElementInterior(r98_0, 1)
setElementDimension(r98_0, 1)
r96_0[r98_0] = true
local r99_0 = false
local r100_0 = {}
local r101_0 = false
local r102_0 = false
local r103_0 = 0
local r104_0 = false
local r105_0 = false
local r106_0 = {}
local r107_0 = false
local r108_0 = false
local r109_0 = false
local r110_0 = 0
function deleteMatchJoinWindow()
	-- line: [470, 481] id: 26
	if r90_0 and r90_0.subscribed then
		triggerServerEvent("unsubscribeMatchJoinWindow", localPlayer)
	end
	r76_0(false)
	r74_0(false)
	if r88_0 and exports.sGui:isGuiElementValid(r88_0) then
		sightexports.sGui:deleteGuiElement(r88_0)
	end
	r88_0 = nil
	if r89_0 and exports.sGui:isGuiElementValid(r89_0) then
		sightexports.sGui:deleteGuiElement(r89_0)
	end
	r89_0 = nil
	r90_0 = false
end
function closeAirsoftMatchSelector()
	-- line: [483, 504] id: 27
	r99_0 = false
	if r93_0 then
		triggerServerEvent("closeAirsoftMatchList", localPlayer)
	end
	if r93_0 and exports.sGui:isGuiElementValid(r93_0) then
		sightexports.sGui:deleteGuiElement(r93_0)
	end
	r93_0 = nil
	if r85_0 and exports.sGui:isGuiElementValid(r85_0) then
		sightexports.sGui:deleteGuiElement(r85_0)
	end
	r85_0 = nil
	if r86_0 and exports.sGui:isGuiElementValid(r86_0) then
		sightexports.sGui:deleteGuiElement(r86_0)
	end
	r86_0 = nil
	deleteMatchJoinWindow()
	r72_0(false)
	r70_0(false)
	r87_0 = false
	r68_0(false)
	r100_0 = {}
	r101_0 = false
end
addEvent("closeAirsoftMatchSelector", false)
addEventHandler("closeAirsoftMatchSelector", getRootElement(), closeAirsoftMatchSelector)
local r111_0 = false
local r112_0 = " float4 PixelShaderFunction() : COLOR0 { return float4(0, 0, 0, 0); } technique Technique1 { pass Pass1 { PixelShader = compile ps_2_0 PixelShaderFunction(); } } "
local r113_0 = "éRVciY3KiYnIDdyITEgNzc8BjcqJicgN2lyITM/Ij43IHIhMSA3NzwBMz8iWjY/KHpneik7Nyo2PygFKS47Lj96IXoOPyIuLyg/emd6Zik5KD8/NA4/IjNHRkFWDQgTTggTVV9cUkcTWl1HVl1AWkdKEw4TAggTUFxdQEcTVV9cUkdoXEgEHQUrBw0ODkhVSA4EBwkcXEBYRlpZWl1ESFhGX1ldXERIWEZYX1pZUHxwYXlrcDY8PzEkZHAAOSg1PAM4MTQ1IhYlPjMkOT8+eDY8PzEkYnAENTBIc19fQlQQChBkdWhzf39idAAZEAoQc398f2IAEEsQZFVIc19fQlQQDRBkTDABHCcLCxYARElEVEpRTURORFZKVF9EMAEcJwsLFgBKHEROWURVRElEQzMsNGtrIiEwaxcmOwAsLDEnbTpqY2xjcGpvY3JtcXZqaXNtcmkqLTcmLTRHXUBNDxRgUUx3W1tGUBpNFB4JFAUUGRREW0McHFVWRxxgUUx3W1tGUBpKMmNqZWp5Y2Zqe2R4f2NgemR7YCMkPi8kOSM+M3FqHi8yCSUlOC5qd2piaz8OEygEBBkPS0RLWUVbQktAS1tFXlBLDQcECh9fSxkOBQ8OGUtWSx8OE3NBN1sAEAEWFh0gEh4DHxYBX1MnFgswHBwBF1pIUxUfHBIHUxAaU05TFR9PIC47ZysgO2c9KiErKj1hPSgtY28jOiIMICopKWZmdG89KiErKj1hPSgtTW1wbSEoPz1lLiRhbT8oIykoP2M/Ki9hbXxmJCM5KCM+JDk0bWR2bT8oI1k9PCt3Kz55c2R5aHIwNy08NyowLSBzaXdsYnkrPDc9PCt3O3lzZHlocjBmCBIDCBUPEh9MVF1GFAMSExQIRhQDCAIDFF1GG0YSAwUOCA8XEwNGMgMFNl5YX0dDUwcWTRZGV0VFFmZXRUUHFk0WZl9OU1plXldSU0QWCxZVWVtGX0UpIGU1Nhp3GnVlFSw9ICkWLSQhIDcDMCsmMSwqK21sfmU4ZThlŐ"
local r114_0 = false
function loadModels()
	-- line: [569, 571] id: 28
	r114_0 = sightexports.sModloader:getModelId("v4_markerlogo")
end
local r115_0 = false
local r116_0 = false
local r117_0 = {}
local r118_0 = {}
local r119_0 = {}
local r120_0 = {}
local r121_0 = false
local r122_0 = false
local r123_0 = false
local r124_0 = false
local r125_0 = false
local r126_0 = false
local r127_0 = false
local r128_0 = false
local r129_0 = 0
local r130_0 = 0
local r131_0 = false
local r132_0 = false
local r133_0 = {}
local r134_0 = {}
local r135_0 = false
local r136_0 = false
local r137_0 = false
local r138_0 = false
local r139_0 = {}
local r140_0 = {}
local r141_0 = {}
local r142_0 = false
local r143_0 = {}
local r144_0 = false
local r145_0 = false
local r146_0 = false
local r147_0 = false
local r148_0 = false
local r149_0 = false
local r150_0 = false
local r151_0 = false
local r152_0 = false
local r153_0 = false
function deleteAirsoftTeamWindow()
	-- line: [624, 631] id: 29
	if r143_0.teamIcon and r145_0 then
		sightexports.sGui:setGuiHoverable(r143_0.teamIcon, true)
	end
	if r145_0 and exports.sGui:isGuiElementValid(r145_0) then
		sightexports.sGui:deleteGuiElement(r145_0)
	end
	r145_0 = nil
	r146_0 = false
end
addEvent("deleteAirsoftTeamWindow", false)
addEventHandler("deleteAirsoftTeamWindow", getRootElement(), deleteAirsoftTeamWindow)
function createAirsoftTeamInner()
	if r146_0 and exports.sGui:isGuiElementValid(r146_0) then
		sightexports.sGui:deleteGuiElement(r146_0)
	end
	r146_0 = nil
	r146_0 = sightexports.sGui:createGuiElement("null", 0, sightexports.sGui:getTitleBarHeight(), 300, 150, r145_0)
	local r1_30 = sightexports.sGui:createGuiElement("null", 68, 31, 64, 88, r146_0)
	local r2_30 = sightexports.sGui:createGuiElement("image", 0, 0, 64, 64, r1_30)
	local r3_30 = sightexports.sGui
	local r5_30 = r2_30
	local r6_30 = sightexports.sGui
	local r8_30 = "users"
	local r9_30 = 64
	local r10_30 = r147_0.team
	if r10_30 == 1 then
		r10_30 = "solid" or "regular"
	else
		r10_30 = "regular"
	end
	r3_30:setImageFile(r5_30, r6_30:getFaIconFilename(r8_30, r9_30, r10_30))
	sightexports.sGui:setImageColor(r2_30, "sightblue")
	r3_30 = sightexports.sGui:createGuiElement("label", 0, 64, 64, 24, r1_30)
	sightexports.sGui:setLabelFont(r3_30, "15/BebasNeueBold.otf")
	sightexports.sGui:setLabelAlignment(r3_30, "center", "center")
	sightexports.sGui:setLabelColor(r3_30, "sightblue")
	local r4_30 = 0
	for r8_30 = 1, #r147_0.playerDatas, 1 do
		if r147_0.playerDatas[r8_30].team == 1 then
			r4_30 = r4_30 + 1
		end
	end
	sightexports.sGui:setLabelText(r3_30, r4_30)
	if r147_0.team ~= 1 then
		sightexports.sGui:setGuiHoverable(r2_30, true)
		sightexports.sGui:setGuiBoundingBox(r2_30, r1_30)
		sightexports.sGui:setClickEvent(r2_30, "doChangeAirsoftTeam")
	end
	r5_30 = sightexports.sGui:createGuiElement("null", 168, 31, 64, 88, r146_0)
	r6_30 = sightexports.sGui:createGuiElement("image", 0, 0, 64, 64, r5_30)
	local r7_30 = sightexports.sGui
	r9_30 = r6_30
	r10_30 = sightexports.sGui
	local r12_30 = "users"
	local r13_30 = 64
	local r14_30 = r147_0.team
	if r14_30 == 2 then
		r14_30 = "solid" or "regular"
	else
		r14_30 = "regular"
	end
	r7_30:setImageFile(r9_30, r10_30:getFaIconFilename(r12_30, r13_30, r14_30))
	sightexports.sGui:setImageColor(r6_30, "sightred")
	r7_30 = sightexports.sGui:createGuiElement("label", 0, 64, 64, 24, r5_30)
	sightexports.sGui:setLabelFont(r7_30, "15/BebasNeueBold.otf")
	sightexports.sGui:setLabelAlignment(r7_30, "center", "center")
	sightexports.sGui:setLabelColor(r7_30, "sightred")
	r8_30 = 0
	for r12_30 = 1, #r147_0.playerDatas, 1 do
		if r147_0.playerDatas[r12_30].team == 2 then
			r8_30 = r8_30 + 1
		end
	end
	sightexports.sGui:setLabelText(r7_30, r8_30)
	if r147_0.team ~= 2 then
		sightexports.sGui:setGuiHoverable(r6_30, true)
		sightexports.sGui:setGuiBoundingBox(r6_30, r5_30)
		sightexports.sGui:setClickEvent(r6_30, "doChangeAirsoftTeam")
	end
	if r105_0 then
		sightexports.sGui:guiToFront(r105_0)
	end
end
function createAirsoftTeamWindow(r0_31)
	-- line: [701, 719] id: 31
	deleteAirsoftLoadoutGui()
	deleteAirsoftTeamWindow()
	if r143_0.teamIcon then
		sightexports.sGui:setGuiHoverable(r143_0.teamIcon, false)
	end
	local r1_31 = sightexports.sGui:getTitleBarHeight()
	local r2_31 = 300
	local r3_31 = r1_31 + 150
	r145_0 = sightexports.sGui:createGuiElement("window", r83_0 / 2 - r2_31 / 2, r84_0 / 2 - r3_31 / 2, r2_31, r3_31)
	sightexports.sGui:setWindowTitle(r145_0, "16/BebasNeueRegular.otf", "Airsoft csapat")
	local r4_31 = sightexports.sGui
	local r6_31 = r145_0
	local r7_31 = nil	-- notice: implicit variable refs by block#[5]
	if r0_31 then
		r7_31 = "createAirsoftLoadoutGui"
		if not r7_31 then
			-- ::label_53::
			r7_31 = "deleteAirsoftTeamWindow"
		end
	else
		r7_31 = "deleteAirsoftTeamWindow"
	end
	r4_31:setWindowCloseButton(r6_31, r7_31)
	createAirsoftTeamInner()
end

lastTeamChange = getTickCount()

addEvent("doChangeAirsoftTeam", false)
addEventHandler("doChangeAirsoftTeam", getRootElement(), function()
	if getTickCount() - lastTeamChange > 5000 then
		-- line: [723, 731] id: 32
		local r0_32 = 1
		if r147_0.team == 1 then
			r0_32 = 2
		end
		triggerServerEvent("changeAirsoftTeam", localPlayer, r0_32)
		lastTeamChange = getTickCount()
	else
		sightexports.sGui:showInfobox("e", "Kérlek várj még a csapatváltással!")
	end
end)
addEvent("changeAirsoftTeam", false)
addEventHandler("changeAirsoftTeam", getRootElement(), function()
	-- line: [735, 737] id: 33
	createAirsoftTeamWindow()
end)
function deleteAirsoftLoadoutGui()
	-- line: [739, 753] id: 34
	if r143_0.loadoutIcon and r135_0 then
		sightexports.sGui:setGuiHoverable(r143_0.loadoutIcon, true)
	end
	if r135_0 and exports.sGui:isGuiElementValid(r135_0) then
		sightexports.sGui:deleteGuiElement(r135_0)
	end
	r135_0 = nil
	r136_0 = false
	r137_0 = false
	r138_0 = false
	r139_0 = {}
	r140_0 = {}
	r141_0 = {}
end
addEvent("deleteAirsoftLoadoutGui", false)
addEventHandler("deleteAirsoftLoadoutGui", getRootElement(), deleteAirsoftLoadoutGui)
function createAirsoftLoadoutGui()
	-- line: [757, 822] id: 35
	deleteAirsoftLoadoutGui()
	deleteAirsoftTeamWindow()
	if r143_0.loadoutIcon then
		sightexports.sGui:setGuiHoverable(r143_0.loadoutIcon, false)
	end
	local r0_35 = sightexports.sGui:getTitleBarHeight()
	local r1_35 = math.ceil(#r134_0 / 5)
	local r2_35 = 288
	local r3_35 = r0_35 + 8 + 4 + 18 + 54 * r1_35 + 32 + 8
	r135_0 = sightexports.sGui:createGuiElement("window", r83_0 / 2 - r2_35 / 2, r84_0 / 2 - r3_35 / 2, r2_35, r3_35)
	sightexports.sGui:setWindowTitle(r135_0, "16/BebasNeueRegular.otf", "Airsoft loadout")
	sightexports.sGui:setWindowCloseButton(r135_0, "deleteAirsoftLoadoutGui")
	local r4_35 = sightexports.sGui:createGuiElement("rectangle", 8, r0_35 + 8, r2_35 - 16 - 60, 4, r135_0)
	setGuiBackground(r4_35, "solid", "sightgrey1")
	r136_0 = sightexports.sGui:createGuiElement("rectangle", 0, 0, 0, 4, r4_35)
	setGuiBackground(r136_0, "solid", "sightblue")
	r137_0 = sightexports.sGui:createGuiElement("rectangle", 0, 0, 0, 4, r4_35)
	setGuiBackground(r137_0, "solid", "sightgreen")
	r138_0 = sightexports.sGui:createGuiElement("label", r2_35 - 16, 0, 0, 4, r4_35)
	sightexports.sGui:setLabelFont(r138_0, "8/Ubuntu-R.ttf")
	sightexports.sGui:setLabelAlignment(r138_0, "right", "center")
	for r8_35 = 1, 5, 1 do
		for r12_35 = 0, r1_35 - 1, 1 do
			local r13_35 = r8_35 + r12_35 * 5
			if r134_0[r13_35] then
				local r14_35 = 18 + 54 * (r8_35 - 1)
				local r15_35 = r0_35 + 8 + 4 + 18 + 54 * r12_35
				local r16_35 = sightexports.sGui:createGuiElement("image", r14_35 + 18 - 33, r15_35 + 18 - 33, 66, 66, r135_0)
				sightexports.sGui:setImageDDS(r16_35, ":sHud/files/itemHover.dds")
				sightexports.sGui:setImageColor(r16_35, "sightorange")
				local r17_35 = sightexports.sGui:createGuiElement("image", r14_35, r15_35, 36, 36, r135_0)
				sightexports.sGui:setImageFile(r17_35, ":sItems/" .. sightexports.sItems:getItemPic(r134_0[r13_35]))
				sightexports.sGui:setImageFadeHover(r17_35, true)
				sightexports.sGui:guiSetTooltip(r17_35, sightexports.sGui:getColorCodeHex("sightorange") .. sightexports.sItems:getItemName(r134_0[r13_35]) .. "\n#ffffff" .. sightexports.sItems:getItemWeight(r134_0[r13_35]) .. " kg")
				sightexports.sGui:setClickArgument(r17_35, r134_0[r13_35])
				sightexports.sGui:setHoverEvent(r17_35, "airsoftItemHover")
				sightexports.sGui:setClickEvent(r17_35, "airsoftItemClick")
				r139_0[r134_0[r13_35]] = {
					r16_35,
					r17_35
				}
			end
		end
	end
	local r5_35 = sightexports.sGui:createGuiElement("button", 8, r3_35 - 32 - 8, r2_35 - 16, 32, r135_0)
	setGuiBackground(r5_35, "solid", "sightgreen")
	sightexports.sGui:setGuiHover(r5_35, "gradient", {
		"sightgreen",
		"sightgreen-second"
	}, false, true)
	sightexports.sGui:setButtonFont(r5_35, "14/BebasNeueBold.otf")
	sightexports.sGui:setButtonText(r5_35, "Kész")
	sightexports.sGui:setClickEvent(r5_35, "airsoftSetLoadout")
	sightexports.sGui:setClickArgument(r5_35, i)
	refreshAirsoftItems()
end
addEvent("createAirsoftLoadoutGui", false)
addEventHandler("createAirsoftLoadoutGui", getRootElement(), createAirsoftLoadoutGui)
addEvent("airsoftSetLoadout", false)
addEventHandler("airsoftSetLoadout", getRootElement(), function(r0_36, r1_36, r2_36, r3_36, r4_36, r5_36)
	-- line: [828, 832] id: 36
	triggerServerEvent("airsoftSetLoadout", localPlayer, r140_0)
	deleteAirsoftLoadoutGui()
end)
addEvent("airsoftItemClick", false)
addEventHandler("airsoftItemClick", getRootElement(), function(r0_37, r1_37, r2_37, r3_37, r4_37, r5_37)
	-- line: [836, 839] id: 37
	r140_0[r5_37] = not r140_0[r5_37]
	refreshAirsoftItems()
end)
addEvent("airsoftItemHover", false)
addEventHandler("airsoftItemHover", getRootElement(), function(r0_38, r1_38, r2_38)
	-- line: [843, 860] id: 38
	r141_0[r2_38] = r1_38
	local r3_38 = sightexports.sItems:getCurrentWeight(true)
	local r4_38 = sightexports.sItems:getWeightLimit("player", localPlayer)
	for r8_38 = 1, #r134_0, 1 do
		local r9_38 = r134_0[r8_38]
		local r10_38 = sightexports.sItems:getItemWeight(r9_38)
		if r141_0[r9_38] or r140_0[r9_38] then
			r3_38 = r3_38 + r10_38
		end
	end
	sightexports.sGui:setGuiSize(r136_0, 212 * r3_38 / r4_38)
end)
function refreshAirsoftItems()
	-- line: [862, 897] id: 39
	local r0_39 = sightexports.sItems:getCurrentWeight(true)
	local r1_39 = r0_39
	local r2_39 = sightexports.sItems:getWeightLimit("player", localPlayer)
	for r6_39 = 1, #r134_0, 1 do
		local r7_39 = r134_0[r6_39]
		local r8_39 = sightexports.sItems:getItemWeight(r7_39)
		if r140_0[r7_39] then
			r0_39 = r0_39 + r8_39
			r1_39 = r1_39 + r8_39
		elseif r141_0[r7_39] then
			r1_39 = r1_39 + r8_39
		end
	end
	for r6_39 = 1, #r134_0, 1 do
		local r7_39 = r134_0[r6_39]
		local r8_39 = sightexports.sItems:getItemWeight(r7_39)
		local r9_39, r10_39 = unpack(r139_0[r7_39])
		sightexports.sGui:setGuiRenderDisabled(r9_39, not r140_0[r7_39])
		local r11_39 = r0_39 + r8_39 <= r2_39
		sightexports.sGui:setGuiHoverable(r10_39, r140_0[r7_39] or r11_39)
		local r12_39 = sightexports.sGui
		local r14_39 = r10_39
		local r15_39 = r140_0[r7_39]
		if r15_39 then
			r15_39 = 255
			if not r15_39 then
				-- ::label_87::
				if r11_39 then
					r15_39 = 150 or 50
				else
					r15_39 = 50
				end
			end
		else
			r15_39 = 50
		end
		r12_39:setImageFadeHoverBase(r14_39, r15_39)
	end
	local r3_39 = 212
	sightexports.sGui:setLabelText(r138_0, math.ceil(r0_39 * 10) / 10 .. "/" .. r2_39 .. "kg")
	sightexports.sGui:setGuiSize(r136_0, r3_39 * math.max(0, r1_39 / r2_39))
	sightexports.sGui:setGuiSize(r137_0, r3_39 * math.max(0, r0_39 / r2_39))
end
function gotAirsoftItems()
	-- line: [899, 901] id: 40
	r134_0 = sightexports.sItems:getAirsoftItems()
end
function createMapBackground(x, y, inside)
	-- line: [904, 926] id: 41
	local r3_41 = sightexports.sGui:createGuiElement("rectangle", x, y, 600, 140, inside)
	setGuiBackground(r3_41, "solid", "sightgrey1")
	sightexports.sGui:setGuiHover(r3_41, "none", false, false, true)
	sightexports.sGui:setGuiHoverable(r3_41, true)
	local r4_41 = sightexports.sGui:createGuiElement("image", 0, 0, 600, 140, r3_41)
	sightexports.sGui:setImageFadeHover(r4_41, true)
	sightexports.sGui:setImageFadeHoverBase(r4_41, 175)
	sightexports.sGui:setGuiHoverable(r4_41, true)
	sightexports.sGui:setGuiBoundingBox(r4_41, r3_41)
	sightexports.sGui:setImageUV(r4_41, 0, 0, 900, 256)
	local r5_41 = sightexports.sGui:createGuiElement("image", 0, 0, 600, 140, r3_41)
	sightexports.sGui:setImageDDS(r5_41, ":sAirsoft/files/grad.dds")
	sightexports.sGui:setImageColor(r5_41, "sightgrey1")
	sightexports.sGui:setImageFadeHover(r5_41, true)
	sightexports.sGui:setImageFadeHoverBase(r5_41, 220)
	sightexports.sGui:setGuiHoverable(r5_41, true)
	sightexports.sGui:setGuiBoundingBox(r5_41, r3_41)
	return r3_41, r4_41, r5_41
end
addEvent("airsoftMatchmakerSelectMap", false)
addEventHandler("airsoftMatchmakerSelectMap", getRootElement(), function(r0_42, r1_42, r2_42, r3_42, r4_42, r5_42)
	-- line: [931, 942] id: 42
	if not r91_0.mapScroll then
		r91_0.mapScroll = 0
	end
	r91_0.map = r5_42 + r91_0.mapScroll
	local r6_42 = airsoftMaps[r91_0.map].gamemodes
	r91_0.gm = r6_42[math.random(1, #r6_42)]
	createAirsoftMathcmakingGamemodeSelector()
end)
addEvent("airsoftMatchmakerSelectGamemode", false)
addEventHandler("airsoftMatchmakerSelectGamemode", getRootElement(), function(r0_43, r1_43, r2_43, r3_43, r4_43, r5_43)
	-- line: [946, 950] id: 43
	r91_0.gm = r5_43
	createAirsoftMatchmakingWindow()
end)
function mapSelectorKey(r0_44)
	-- line: [953, 967] id: 44
	if r0_44 == "mouse_wheel_up" and r91_0.mapScroll > 0 then
		r91_0.mapScroll = r91_0.mapScroll - 1
		refreshAirsoftMatchmakingMaps()
	elseif r0_44 == "mouse_wheel_down" and r91_0.mapScroll < #airsoftMaps - 4 then
		r91_0.mapScroll = r91_0.mapScroll + 1
		refreshAirsoftMatchmakingMaps()
	end
end
function matchSelectorKey(r0_45)
	-- line: [969, 983] id: 45
	if r0_45 == "mouse_wheel_up" and r92_0 > 0 then
		r92_0 = r92_0 - 1
		processAirsoftMatchList()
	elseif r0_45 == "mouse_wheel_down" and r92_0 < #r99_0 - #r100_0 then
		r92_0 = r92_0 + 1
		processAirsoftMatchList()
	end
end
function refreshAirsoftMatchmakingMaps()
	-- line: [985, 1038] id: 46
	if not r91_0.mapScroll then
		r91_0.mapScroll = 0
	end
	local r0_46 = r91_0.mapScroll
	local r1_46 = 584 / math.max(1, (#airsoftMaps - 4 + 1))
	sightexports.sGui:setGuiSize(r87_0.mapScroll, false, r1_46)
	
sightexports.sGui:setGuiPosition(r87_0.mapScroll, false, r1_46 * r0_46)
	local r2_46 = sightexports.sGui:getFontHeight("15/BebasNeueRegular.otf")
	local r3_46 = sightexports.sGui:getFontHeight("23/BebasNeueRegular.otf")
	for r7_46 = 1, 4, 1 do
		local r9_46 = airsoftMaps[r7_46 + r0_46]
		sightexports.sGui:setImageDDS(r87_0.maps[r7_46].img, r9_46.image, "dxt1")
		sightexports.sGui:setLabelText(r87_0.maps[r7_46].label, r9_46.name)
		for r13_46 in pairs(gameModes) do
			sightexports.sGui:setGuiRenderDisabled(r87_0.maps[r7_46].gms[r13_46][1], true, true)
		end
		local r10_46 = r3_46 + 2
		local r11_46 = 8
		for r15_46 = 1, #r9_46.gamemodes, 1 do
			local r16_46 = r9_46.gamemodes[r15_46]
			if r11_46 + r87_0.maps[r7_46].gms[r16_46][4] + 8 > 600 then
				r11_46 = 8
				r10_46 = r10_46 + r2_46 + 4
			end
			
sightexports.sGui:setGuiPosition(r87_0.maps[r7_46].gms[r16_46][1], r11_46, r10_46)
			sightexports.sGui:setGuiRenderDisabled(r87_0.maps[r7_46].gms[r16_46][1], false, true)
			if gameModes[r16_46].team then
				sightexports.sGui:setLabelText(r87_0.maps[r7_46].gms[r16_46][2], r9_46.teamSpawns[1])
				sightexports.sGui:setLabelText(r87_0.maps[r7_46].gms[r16_46][3], r9_46.teamSpawns[2])
			else
				sightexports.sGui:setLabelText(r87_0.maps[r7_46].gms[r16_46][2], r9_46.playerSpawns)
			end
			r11_46 = r11_46 + r87_0.maps[r7_46].gms[r16_46][4] + 8
		end
	end
end
function createAirsoftMathcmakingMapSelector()
	-- line: [1040, 1159] id: 47
	if r93_0 and exports.sGui:isGuiElementValid(r93_0) then
		sightexports.sGui:deleteGuiElement(r93_0)
	end
	r93_0 = nil
	if r85_0 and exports.sGui:isGuiElementValid(r85_0) then
		sightexports.sGui:deleteGuiElement(r85_0)
	end
	r85_0 = nil
	if r86_0 and exports.sGui:isGuiElementValid(r86_0) then
		sightexports.sGui:deleteGuiElement(r86_0)
	end
	r86_0 = nil
	deleteMatchJoinWindow()
	r72_0(true)
	r70_0(false)
	r87_0 = {}
	local r0_47 = sightexports.sGui:getTitleBarHeight()
	local r1_47 = r0_47 + 8 + 592
	local r2_47 = 627
	r85_0 = sightexports.sGui:createGuiElement("window", r83_0 / 2 - r2_47 / 2, r84_0 / 2 - r1_47 / 2, r2_47, r1_47)
	sightexports.sGui:setWindowTitle(r85_0, "16/BebasNeueRegular.otf", "Airsoft pálya kiválasztása")
	sightexports.sGui:setWindowCloseButton(r85_0, "createAirsoftMatchmakingWindow")
	local r3_47 = false
	local r4_47 = false
	local r5_47, r6_47, r7_47 = getElementPosition(localPlayer)
	for r11_47 in pairs(r96_0) do
		local r12_47, r13_47, r14_47 = getElementPosition(r11_47)
		local r15_47 = getDistanceBetweenPoints3D(r5_47, r6_47, r7_47, r12_47, r13_47, r14_47)
		if not r4_47 or r15_47 < r4_47 then
			r4_47 = r15_47
			r3_47 = r11_47
		end
	end
	sightexports.sGui:setWindowElementMaxDistance(r85_0, r3_47, 5, "closeAirsoftMatchSelector")
	local r8_47 = 584
	local r9_47 = sightexports.sGui:createGuiElement("rectangle", 616, r0_47 + 8, 3, r8_47, r85_0)
	setGuiBackground(r9_47, "solid", "sightgrey1")
	r87_0.mapScroll = sightexports.sGui:createGuiElement("scrollbar", 0, 0, 3, r8_47, r9_47)
	setGuiBackground(r87_0.mapScroll, "solid", "sightlightgrey")
	local r10_47 = sightexports.sGui:getFontHeight("15/BebasNeueRegular.otf")
	local r11_47 = sightexports.sGui:getTextWidthFont("888", "12/BebasNeueBold.otf") + 8
	r87_0.maps = {}
	for r15_47 = 1, 4, 1 do
		r87_0.maps[r15_47] = {}
		local r16_47, r17_47, r18_47 = createMapBackground(8, r0_47 + 8 + 148 * (r15_47 - 1), r85_0)
		sightexports.sGui:setClickEvent(r16_47, "airsoftMatchmakerSelectMap")
		sightexports.sGui:setClickArgument(r16_47, r15_47)
		r87_0.maps[r15_47].img = r17_47
		local r19_47 = sightexports.sGui:createGuiElement("label", 8, 0, 0, 0, r16_47)
		sightexports.sGui:setLabelColor(r19_47, "sightyellow")
		sightexports.sGui:setLabelFont(r19_47, "23/BebasNeueRegular.otf")
		sightexports.sGui:setLabelAlignment(r19_47, "left", "top")
		r87_0.maps[r15_47].label = r19_47
		r87_0.maps[r15_47].gms = {}
		for r23_47, r24_47 in pairs(gameModes) do
			local r25_47 = sightexports.sGui:getTextWidthFont(r24_47.name, "12/BebasNeueBold.otf") + 8
			local r26_47 = sightexports.sGui:createGuiElement("rectangle", 8, 0, r25_47, r10_47 - 2, r16_47)
			setGuiBackground(r26_47, "solid", r24_47.color)
			r87_0.maps[r15_47].gms[r23_47] = {
				r26_47
			}
			local r27_47 = sightexports.sGui:createGuiElement("label", 0, 0, r25_47, r10_47 - 2, r26_47)
			sightexports.sGui:setLabelFont(r27_47, "12/BebasNeueBold.otf")
			sightexports.sGui:setLabelAlignment(r27_47, "center", "center")
			sightexports.sGui:setLabelText(r27_47, r24_47.name)
			if r24_47.team then
				local r28_47 = sightexports.sGui:createGuiElement("rectangle", r25_47 + 8, 0, r11_47, r10_47 - 2, r26_47)
				setGuiBackground(r28_47, "solid", "sightblue")
				local r29_47 = sightexports.sGui:createGuiElement("label", 0, 0, r11_47, r10_47 - 2, r28_47)
				sightexports.sGui:setLabelFont(r29_47, "12/BebasNeueBold.otf")
				sightexports.sGui:setLabelAlignment(r29_47, "center", "center")
				r87_0.maps[r15_47].gms[r23_47][2] = r29_47
				local r30_47 = sightexports.sGui:createGuiElement("rectangle", r25_47 + 8 + r11_47, 0, r11_47, r10_47 - 2, r26_47)
				setGuiBackground(r30_47, "solid", "sightred")
				local r31_47 = sightexports.sGui:createGuiElement("label", 0, 0, r11_47, r10_47 - 2, r30_47)
				sightexports.sGui:setLabelFont(r31_47, "12/BebasNeueBold.otf")
				sightexports.sGui:setLabelAlignment(r31_47, "center", "center")
				r87_0.maps[r15_47].gms[r23_47][3] = r31_47
				r87_0.maps[r15_47].gms[r23_47][4] = r25_47 + 8 + r11_47 * 2
			else
				local r28_47 = sightexports.sGui:createGuiElement("rectangle", r25_47 + 8, 0, r11_47, r10_47 - 2, r26_47)
				setGuiBackground(r28_47, "solid", "sightgreen")
				local r29_47 = sightexports.sGui:createGuiElement("label", 0, 0, r11_47, r10_47 - 2, r28_47)
				sightexports.sGui:setLabelFont(r29_47, "12/BebasNeueBold.otf")
				sightexports.sGui:setLabelAlignment(r29_47, "center", "center")
				r87_0.maps[r15_47].gms[r23_47][2] = r29_47
				r87_0.maps[r15_47].gms[r23_47][4] = r25_47 + 8 + r11_47
			end
			sightexports.sGui:setGuiRenderDisabled(r26_47, true, true)
		end
	end
	refreshAirsoftMatchmakingMaps()
end
addEvent("createAirsoftMathcmakingMapSelector", false)
addEventHandler("createAirsoftMathcmakingMapSelector", getRootElement(), createAirsoftMathcmakingMapSelector)
function createAirsoftMathcmakingGamemodeSelector()
	-- line: [1163, 1263] id: 48
	if r93_0 and exports.sGui:isGuiElementValid(r93_0) then
		sightexports.sGui:deleteGuiElement(r93_0)
	end
	r93_0 = nil
	if r85_0 and exports.sGui:isGuiElementValid(r85_0) then
		sightexports.sGui:deleteGuiElement(r85_0)
	end
	r85_0 = nil
	if r86_0 and exports.sGui:isGuiElementValid(r86_0) then
		sightexports.sGui:deleteGuiElement(r86_0)
	end
	r86_0 = nil
	deleteMatchJoinWindow()
	r72_0(false)
	r70_0(false)
	r87_0 = {}
	local r0_48 = sightexports.sGui:getTitleBarHeight()
	if not r91_0.map or not r91_0.gm then
		r91_0.map = math.random(1, #airsoftMaps)
		local r1_48 = airsoftMaps[r91_0.map].gamemodes
		r91_0.gm = r1_48[math.random(1, #r1_48)]
	end
	local r1_48 = airsoftMaps[r91_0.map]
	local r2_48 = r0_48 + 8 + 148 * #r1_48.gamemodes
	local r3_48 = 616
	r85_0 = sightexports.sGui:createGuiElement("window", r83_0 / 2 - r3_48 / 2, r84_0 / 2 - r2_48 / 2, r3_48, r2_48)
	sightexports.sGui:setWindowTitle(r85_0, "16/BebasNeueRegular.otf", "Airsoft játékmód kiválasztása")
	sightexports.sGui:setWindowCloseButton(r85_0, "createAirsoftMathcmakingMapSelector")
	local r4_48 = false
	local r5_48 = false
	local r6_48, r7_48, r8_48 = getElementPosition(localPlayer)
	for r12_48 in pairs(r96_0) do
		local r13_48, r14_48, r15_48 = getElementPosition(r12_48)
		local r16_48 = getDistanceBetweenPoints3D(r6_48, r7_48, r8_48, r13_48, r14_48, r15_48)
		if not r5_48 or r16_48 < r5_48 then
			r5_48 = r16_48
			r4_48 = r12_48
		end
	end
	sightexports.sGui:setWindowElementMaxDistance(r85_0, r4_48, 5, "closeAirsoftMatchSelector")
	local r9_48 = sightexports.sGui:getFontHeight("15/BebasNeueRegular.otf")
	local r10_48 = sightexports.sGui:getTextWidthFont("888", "12/BebasNeueBold.otf") + 8
	for r14_48 = 1, #r1_48.gamemodes, 1 do
		local r15_48 = gameModes[r1_48.gamemodes[r14_48]]
		local r16_48, r17_48, r18_48 = createMapBackground(8, r0_48 + 8 + 148 * (r14_48 - 1), r85_0)
		sightexports.sGui:setClickEvent(r16_48, "airsoftMatchmakerSelectGamemode")
		sightexports.sGui:setClickArgument(r16_48, r1_48.gamemodes[r14_48])
		sightexports.sGui:setImageDDS(r17_48, r1_48.image, "dxt1")
		local r19_48 = sightexports.sGui:getTextWidthFont(r15_48.name, "12/BebasNeueBold.otf") + 8
		local r20_48 = sightexports.sGui:createGuiElement("label", 8, 8 + r9_48 + 8, 584, 124 - r9_48, r18_48)
		sightexports.sGui:setLabelFont(r20_48, "11/Ubuntu-R.ttf")
		sightexports.sGui:setLabelAlignment(r20_48, "left", "top")
		sightexports.sGui:setLabelWordBreak(r20_48, true)
		sightexports.sGui:setLabelText(r20_48, r15_48.description)
		local r21_48 = sightexports.sGui:createGuiElement("rectangle", 8, 8, r19_48, r9_48 - 2, r16_48)
		setGuiBackground(r21_48, "solid", r15_48.color)
		local r22_48 = sightexports.sGui:createGuiElement("label", 0, 0, r19_48, r9_48 - 2, r21_48)
		sightexports.sGui:setLabelFont(r22_48, "12/BebasNeueBold.otf")
		sightexports.sGui:setLabelAlignment(r22_48, "center", "center")
		sightexports.sGui:setLabelText(r22_48, r15_48.name)
		if r15_48.team then
			local r23_48 = sightexports.sGui:createGuiElement("rectangle", r19_48 + 8, 0, r10_48, r9_48 - 2, r21_48)
			setGuiBackground(r23_48, "solid", "sightblue")
			local r24_48 = sightexports.sGui:createGuiElement("label", 0, 0, r10_48, r9_48 - 2, r23_48)
			sightexports.sGui:setLabelFont(r24_48, "12/BebasNeueBold.otf")
			sightexports.sGui:setLabelAlignment(r24_48, "center", "center")
			sightexports.sGui:setLabelText(r24_48, r1_48.teamSpawns[1])
			local r25_48 = sightexports.sGui:createGuiElement("rectangle", r19_48 + 8 + r10_48, 0, r10_48, r9_48 - 2, r21_48)
			setGuiBackground(r25_48, "solid", "sightred")
			local r26_48 = sightexports.sGui:createGuiElement("label", 0, 0, r10_48, r9_48 - 2, r25_48)
			sightexports.sGui:setLabelFont(r26_48, "12/BebasNeueBold.otf")
			sightexports.sGui:setLabelAlignment(r26_48, "center", "center")
			sightexports.sGui:setLabelText(r26_48, r1_48.teamSpawns[2])
		else
			local r23_48 = sightexports.sGui:createGuiElement("rectangle", r19_48 + 8, 0, r10_48, r9_48 - 2, r21_48)
			setGuiBackground(r23_48, "solid", "sightgreen")
			local r24_48 = sightexports.sGui:createGuiElement("label", 0, 0, r10_48, r9_48 - 2, r23_48)
			sightexports.sGui:setLabelFont(r24_48, "12/BebasNeueBold.otf")
			sightexports.sGui:setLabelAlignment(r24_48, "center", "center")
			sightexports.sGui:setLabelText(r24_48, r1_48.playerSpawns)
		end
	end
end
function createAirsoftMatchmakingWindow()
	-- line: [1265, 1858] id: 49
	if not r91_0.map or not r91_0.gm then
		r91_0.map = math.random(1, #airsoftMaps)
		local r0_49 = airsoftMaps[r91_0.map].gamemodes
		r91_0.gm = r0_49[math.random(1, #r0_49)]
	end
	local r0_49 = airsoftMaps[r91_0.map]
	local r1_49 = gameModes[r91_0.gm]
	local r2_49 = sightexports.sGui:getTitleBarHeight()
	local r3_49 = r2_49 + 8 + 140 + 8
	local r4_49 = r1_49.team
	if r4_49 then
		r4_49 = 2 or 0
	else
		r4_49 = 0
	end
	r3_49 = r3_49 + 38 * (6 + r4_49) + 120 + 8
	r4_49 = 616
	local r5_49 = r83_0 / 2 - r4_49 / 2
	local r6_49 = r84_0 / 2 - r3_49 / 2
	if r86_0 then
		r5_49, r6_49 = sightexports.sGui:getGuiPosition(r86_0)
	end
	if r93_0 and exports.sGui:isGuiElementValid(r93_0) then
		sightexports.sGui:deleteGuiElement(r93_0)
	end
	r93_0 = nil
	if r85_0 and exports.sGui:isGuiElementValid(r85_0) then
		sightexports.sGui:deleteGuiElement(r85_0)
	end
	r85_0 = nil
	if r86_0 and exports.sGui:isGuiElementValid(r86_0) then
		sightexports.sGui:deleteGuiElement(r86_0)
	end
	r86_0 = nil
	deleteMatchJoinWindow()
	r72_0(false)
	r70_0(false)
	r87_0 = {}
	r86_0 = sightexports.sGui:createGuiElement("window", r5_49, r6_49, r4_49, r3_49)
	sightexports.sGui:setWindowTitle(r86_0, "16/BebasNeueRegular.otf", "Airsoft meccs létrehozása")
	sightexports.sGui:setWindowCloseButton(r86_0, "createMatchSelectorWindow")
	local r7_49 = false
	local r8_49 = false
	local r9_49, r10_49, r11_49 = getElementPosition(localPlayer)
	for r15_49 in pairs(r96_0) do
		local r16_49, r17_49, r18_49 = getElementPosition(r15_49)
		local r19_49 = getDistanceBetweenPoints3D(r9_49, r10_49, r11_49, r16_49, r17_49, r18_49)
		if not r8_49 or r19_49 < r8_49 then
			r8_49 = r19_49
			r7_49 = r15_49
		end
	end
	sightexports.sGui:setWindowElementMaxDistance(r86_0, r7_49, 5, "closeAirsoftMatchSelector")
	local r12_49, r13_49, r14_49 = createMapBackground(8, r2_49 + 8, r86_0)
	sightexports.sGui:setClickEvent(r12_49, "createAirsoftMathcmakingMapSelector")
	sightexports.sGui:setImageDDS(r13_49, r0_49.image, "dxt1")
	local r15_49 = sightexports.sGui:createGuiElement("label", 8, 0, 0, 0, r12_49)
	sightexports.sGui:setLabelColor(r15_49, "sightyellow")
	sightexports.sGui:setLabelFont(r15_49, "23/BebasNeueRegular.otf")
	sightexports.sGui:setLabelAlignment(r15_49, "left", "top")
	sightexports.sGui:setLabelText(r15_49, r0_49.name)
	local r16_49 = sightexports.sGui:getFontHeight("15/BebasNeueRegular.otf")
	local r17_49 = sightexports.sGui:getTextWidthFont(r1_49.name, "12/BebasNeueBold.otf") + 8
	local r18_49 = sightexports.sGui:createGuiElement("rectangle", 8, 0 + sightexports.sGui:getLabelFontHeight(r15_49) + 2, r17_49, r16_49 - 2, r12_49)
	setGuiBackground(r18_49, "solid", r1_49.color)
	local r19_49 = sightexports.sGui:createGuiElement("label", 0, 0, r17_49, r16_49 - 2, r18_49)
	sightexports.sGui:setLabelFont(r19_49, "12/BebasNeueBold.otf")
	sightexports.sGui:setLabelAlignment(r19_49, "center", "center")
	sightexports.sGui:setLabelText(r19_49, r1_49.name)
	local r20_49 = sightexports.sGui:createGuiElement("label", 8, 0, 0, 132, r12_49)
	local r21_49 = 0
	if r1_49.team then
		r21_49 = r0_49.teamSpawns[1] + r0_49.teamSpawns[2]
		sightexports.sGui:setLabelText(r20_49, "Max " .. r21_49 .. " ([color=sightblue]" .. r0_49.teamSpawns[1] .. "#ffffff v [color=sightred]" .. r0_49.teamSpawns[2] .. "#ffffff) játékos")
	else
		r21_49 = r0_49.playerSpawns
		sightexports.sGui:setLabelText(r20_49, "Max " .. r21_49 .. " játékos")
	end
	local r22_49 = sightexports.sGui:getTitleBarHeight() + 8 + 140 + 8 + 30 + 8
	sightexports.sGui:setLabelFont(r20_49, "15/BebasNeueRegular.otf")
	sightexports.sGui:setLabelAlignment(r20_49, "left", "bottom")
	local r23_49 = sightexports.sGui:createGuiElement("input", 8, r2_49 + 8 + 140 + 8, r4_49 - 16, 30, r86_0)
	sightexports.sGui:setInputPlaceholder(r23_49, "Meccs neve")
	sightexports.sGui:setInputIcon(r23_49, "tag")
	sightexports.sGui:setInputMaxLength(r23_49, 32)
	sightexports.sGui:setClickArgument(r23_49, "matchName")
	sightexports.sGui:setInputChangeEvent(r23_49, "airsoftMatchmakingInputChange")
	sightexports.sGui:setInputValue(r23_49, r91_0.matchName or "")
	local r24_49 = sightexports.sGui:createGuiElement("input", 8, r22_49, 616 - 16, 30, r86_0)
	sightexports.sGui:setInputPlaceholder(r24_49, "Nevezési díj / fő (" .. sightexports.sGui:thousandsStepper(0) .. " - " .. sightexports.sGui:thousandsStepper(1000000) .. " $)")
	sightexports.sGui:setInputIcon(r24_49, "dollar-sign")
	sightexports.sGui:setInputMaxLength(r24_49, utf8.len(tostring(1000000)))
	sightexports.sGui:setClickArgument(r24_49, "joinFee")
	sightexports.sGui:setInputChangeEvent(r24_49, "airsoftMatchmakingInputChange")
	sightexports.sGui:setInputValue(r24_49, r91_0.joinFee or "")
	sightexports.sGui:setInputNumberOnly(r24_49, true)
	local r22_49 = r22_49 + 30 + 8
	local r25_49 = sightexports.sGui:createGuiElement("label", 8, r22_49, 0, 30, r86_0)
	sightexports.sGui:setLabelFont(r25_49, "10/Ubuntu-R.ttf")
	sightexports.sGui:setLabelAlignment(r25_49, "left", "center")
	sightexports.sGui:setLabelText(r25_49, "Privát meccs:")
	local r26_49 = sightexports.sGui:createGuiElement("button", 8 + sightexports.sGui:getLabelTextWidth(r25_49) + 8, r22_49 + 4, 60, 22, r86_0)
	if (r91_0.private or "Nem") == "Nem" then
		setGuiBackground(r26_49, "solid", "sightred")
		sightexports.sGui:setGuiHoverable(r26_49, false)
	else
		setGuiBackground(r26_49, "solid", "sightgrey1")
		sightexports.sGui:setGuiHover(r26_49, "gradient", {
			"sightred",
			"sightred-second"
		}, false, true)
	end
	sightexports.sGui:setButtonFont(r26_49, "12/BebasNeueBold.otf")
	sightexports.sGui:setButtonText(r26_49, "Nem")
	sightexports.sGui:setClickEvent(r26_49, "airsoftMatchmakingButtonInput")
	sightexports.sGui:setClickArgument(r26_49, "private")
	local r27_49 = sightexports.sGui:createGuiElement("button", 8 + sightexports.sGui:getLabelTextWidth(r25_49) + 8 + 60 + 8, r22_49 + 4, 60, 22, r86_0)
	if (r91_0.private or "Nem") == "Igen" then
		setGuiBackground(r27_49, "solid", "sightgreen")
		sightexports.sGui:setGuiHoverable(r27_49, false)
	else
		setGuiBackground(r27_49, "solid", "sightgrey1")
		sightexports.sGui:setGuiHover(r27_49, "gradient", {
			"sightgreen",
			"sightgreen-second"
		}, false, true)
	end
	sightexports.sGui:setButtonFont(r27_49, "12/BebasNeueBold.otf")
	sightexports.sGui:setButtonText(r27_49, "Igen")
	sightexports.sGui:setClickEvent(r27_49, "airsoftMatchmakingButtonInput")
	sightexports.sGui:setClickArgument(r27_49, "private")
	local r28_49 = sightexports.sGui:createGuiElement("label", 8 + sightexports.sGui:getLabelTextWidth(r25_49) + 8 + 136, r22_49, 0, 30, r86_0)
	sightexports.sGui:setLabelFont(r28_49, "10/Ubuntu-LI.ttf")
	sightexports.sGui:setLabelAlignment(r28_49, "left", "center")
	sightexports.sGui:setLabelText(r28_49, "Privát meccs esetén PIN kóddal lehet csatlakozni.")
	r22_49 = r22_49 + 30 + 8
	if r1_49.team then
		local r29_49 = sightexports.sGui:createGuiElement("label", 8, r22_49, 0, 30, r86_0)
		sightexports.sGui:setLabelFont(r29_49, "10/Ubuntu-R.ttf")
		sightexports.sGui:setLabelAlignment(r29_49, "left", "center")
		sightexports.sGui:setLabelText(r29_49, "Szabad csapatválasztás:")
		local r30_49 = sightexports.sGui:createGuiElement("button", 8 + sightexports.sGui:getLabelTextWidth(r29_49) + 8, r22_49 + 4, 60, 22, r86_0)
		if (r91_0.canChangeTeam or "Igen") == "Nem" then
			setGuiBackground(r30_49, "solid", "sightred")
			sightexports.sGui:setGuiHoverable(r30_49, false)
		else
			setGuiBackground(r30_49, "solid", "sightgrey1")
			sightexports.sGui:setGuiHover(r30_49, "gradient", {
				"sightred",
				"sightred-second"
			}, false, true)
		end
		sightexports.sGui:setButtonFont(r30_49, "12/BebasNeueBold.otf")
		sightexports.sGui:setButtonText(r30_49, "Nem")
		sightexports.sGui:setClickEvent(r30_49, "airsoftMatchmakingButtonInput")
		sightexports.sGui:setClickArgument(r30_49, "canChangeTeam")
		local r31_49 = sightexports.sGui:createGuiElement("button", 8 + sightexports.sGui:getLabelTextWidth(r29_49) + 8 + 60 + 8, r22_49 + 4, 60, 22, r86_0)
		if (r91_0.canChangeTeam or "Igen") == "Igen" then
			setGuiBackground(r31_49, "solid", "sightgreen")
			sightexports.sGui:setGuiHoverable(r31_49, false)
		else
			setGuiBackground(r31_49, "solid", "sightgrey1")
			sightexports.sGui:setGuiHover(r31_49, "gradient", {
				"sightgreen",
				"sightgreen-second"
			}, false, true)
		end
		sightexports.sGui:setButtonFont(r31_49, "12/BebasNeueBold.otf")
		sightexports.sGui:setButtonText(r31_49, "Igen")
		sightexports.sGui:setClickEvent(r31_49, "airsoftMatchmakingButtonInput")
		sightexports.sGui:setClickArgument(r31_49, "canChangeTeam")
		r22_49 = r22_49 + 30 + 8
		local r32_49 = sightexports.sGui:createGuiElement("label", 8, r22_49, 0, 30, r86_0)
		sightexports.sGui:setLabelFont(r32_49, "10/Ubuntu-R.ttf")
		sightexports.sGui:setLabelAlignment(r32_49, "left", "center")
		sightexports.sGui:setLabelText(r32_49, "Friendly Fire:")
		local r33_49 = sightexports.sGui:createGuiElement("button", 8 + sightexports.sGui:getLabelTextWidth(r32_49) + 8, r22_49 + 4, 60, 22, r86_0)
		if (r91_0.friendlyFire or "Nem") == "Nem" then
			setGuiBackground(r33_49, "solid", "sightgreen")
			sightexports.sGui:setGuiHoverable(r33_49, false)
		else
			setGuiBackground(r33_49, "solid", "sightgrey1")
			sightexports.sGui:setGuiHover(r33_49, "gradient", {
				"sightgreen",
				"sightgreen-second"
			}, false, true)
		end
		sightexports.sGui:setButtonFont(r33_49, "12/BebasNeueBold.otf")
		sightexports.sGui:setButtonText(r33_49, "Nem")
		sightexports.sGui:setClickEvent(r33_49, "airsoftMatchmakingButtonInput")
		sightexports.sGui:setClickArgument(r33_49, "friendlyFire")
		local r34_49 = sightexports.sGui:createGuiElement("button", 8 + sightexports.sGui:getLabelTextWidth(r32_49) + 8 + 60 + 8, r22_49 + 4, 60, 22, r86_0)
		if (r91_0.friendlyFire or "Nem") == "Igen" then
			setGuiBackground(r34_49, "solid", "sightred")
			sightexports.sGui:setGuiHoverable(r34_49, false)
		else
			setGuiBackground(r34_49, "solid", "sightgrey1")
			sightexports.sGui:setGuiHover(r34_49, "gradient", {
				"sightred",
				"sightred-second"
			}, false, true)
		end
		sightexports.sGui:setButtonFont(r34_49, "12/BebasNeueBold.otf")
		sightexports.sGui:setButtonText(r34_49, "Igen")
		sightexports.sGui:setClickEvent(r34_49, "airsoftMatchmakingButtonInput")
		sightexports.sGui:setClickArgument(r34_49, "friendlyFire")
		r22_49 = r22_49 + 30 + 8
		local r35_49 = sightexports.sGui:createGuiElement("label", 8, r22_49, 0, 30, r86_0)
		sightexports.sGui:setLabelFont(r35_49, "10/Ubuntu-R.ttf")
		sightexports.sGui:setLabelAlignment(r35_49, "left", "center")
		sightexports.sGui:setLabelText(r35_49, "Játékos színek megjelenítése:")
		local r36_49 = sightexports.sGui:createGuiElement("button", 8 + sightexports.sGui:getLabelTextWidth(r35_49) + 8, r22_49 + 4, 60, 22, r86_0)
		if (r91_0.teamShaderMode or "Igen + Csapat falon keresztül") == "Nem" then
			setGuiBackground(r36_49, "solid", "sightred")
			sightexports.sGui:setGuiHoverable(r36_49, false)
		else
			setGuiBackground(r36_49, "solid", "sightgrey1")
			sightexports.sGui:setGuiHover(r36_49, "gradient", {
				"sightred",
				"sightred-second"
			}, false, true)
		end
		sightexports.sGui:setButtonFont(r36_49, "12/BebasNeueBold.otf")
		sightexports.sGui:setButtonText(r36_49, "Nem")
		sightexports.sGui:setClickEvent(r36_49, "airsoftMatchmakingButtonInput")
		sightexports.sGui:setClickArgument(r36_49, "teamShaderMode")
		local r37_49 = sightexports.sGui:createGuiElement("button", 8 + sightexports.sGui:getLabelTextWidth(r35_49) + 8 + 60 + 8, r22_49 + 4, 60, 22, r86_0)
		if (r91_0.teamShaderMode or "Igen + Csapat falon keresztül") == "Igen" then
			setGuiBackground(r37_49, "solid", "sightgreen")
			sightexports.sGui:setGuiHoverable(r37_49, false)
		else
			setGuiBackground(r37_49, "solid", "sightgrey1")
			sightexports.sGui:setGuiHover(r37_49, "gradient", {
				"sightgreen",
				"sightgreen-second"
			}, false, true)
		end
		sightexports.sGui:setButtonFont(r37_49, "12/BebasNeueBold.otf")
		sightexports.sGui:setButtonText(r37_49, "Igen")
		sightexports.sGui:setClickEvent(r37_49, "airsoftMatchmakingButtonInput")
		sightexports.sGui:setClickArgument(r37_49, "teamShaderMode")
		local r38_49 = sightexports.sGui:createGuiElement("button", 8 + sightexports.sGui:getLabelTextWidth(r35_49) + 8 + 136, r22_49 + 4, 200, 22, r86_0)
		if (r91_0.teamShaderMode or "Igen + Csapat falon keresztül") == "Igen + Csapat falon keresztül" then
			setGuiBackground(r38_49, "solid", "sightgreen")
			sightexports.sGui:setGuiHoverable(r38_49, false)
		else
			setGuiBackground(r38_49, "solid", "sightgrey1")
			sightexports.sGui:setGuiHover(r38_49, "gradient", {
				"sightgreen",
				"sightgreen-second"
			}, false, true)
		end
		sightexports.sGui:setButtonFont(r38_49, "12/BebasNeueBold.otf")
		sightexports.sGui:setButtonText(r38_49, "Igen + Csapat falon keresztül")
		sightexports.sGui:setClickEvent(r38_49, "airsoftMatchmakingButtonInput")
		sightexports.sGui:setClickArgument(r38_49, "teamShaderMode")
		r22_49 = r22_49 + 30 + 8
	else
		local r29_49 = sightexports.sGui:createGuiElement("label", 8, r22_49, 0, 30, r86_0)
		sightexports.sGui:setLabelFont(r29_49, "10/Ubuntu-R.ttf")
		sightexports.sGui:setLabelAlignment(r29_49, "left", "center")
		sightexports.sGui:setLabelText(r29_49, "Játékosok megjelenítése spectator módban:")
		local r30_49 = sightexports.sGui:createGuiElement("button", 8 + sightexports.sGui:getLabelTextWidth(r29_49) + 8, r22_49 + 4, 60, 22, r86_0)
		if (r91_0.individualShaderMode or "Igen") == "Nem" then
			setGuiBackground(r30_49, "solid", "sightred")
			sightexports.sGui:setGuiHoverable(r30_49, false)
		else
			setGuiBackground(r30_49, "solid", "sightgrey1")
			sightexports.sGui:setGuiHover(r30_49, "gradient", {
				"sightred",
				"sightred-second"
			}, false, true)
		end
		sightexports.sGui:setButtonFont(r30_49, "12/BebasNeueBold.otf")
		sightexports.sGui:setButtonText(r30_49, "Nem")
		sightexports.sGui:setClickEvent(r30_49, "airsoftMatchmakingButtonInput")
		sightexports.sGui:setClickArgument(r30_49, "individualShaderMode")
		local r31_49 = sightexports.sGui:createGuiElement("button", 8 + sightexports.sGui:getLabelTextWidth(r29_49) + 8 + 60 + 8, r22_49 + 4, 60, 22, r86_0)
		if (r91_0.individualShaderMode or "Igen") == "Igen" then
			setGuiBackground(r31_49, "solid", "sightgreen")
			sightexports.sGui:setGuiHoverable(r31_49, false)
		else
			setGuiBackground(r31_49, "solid", "sightgrey1")
			sightexports.sGui:setGuiHover(r31_49, "gradient", {
				"sightgreen",
				"sightgreen-second"
			}, false, true)
		end
		sightexports.sGui:setButtonFont(r31_49, "12/BebasNeueBold.otf")
		sightexports.sGui:setButtonText(r31_49, "Igen")
		sightexports.sGui:setClickEvent(r31_49, "airsoftMatchmakingButtonInput")
		sightexports.sGui:setClickArgument(r31_49, "individualShaderMode")
		r22_49 = r22_49 + 30 + 8
	end
	sightexports.sGui:createGuiElement("hr", r4_49 / 2 - 1, r22_49, 2, r3_49 - r22_49 - 8 - 76, r86_0)
	local r29_49 = sightexports.sGui:createGuiElement("label", 8, r22_49, 0, 30, r86_0)
	sightexports.sGui:setLabelFont(r29_49, "10/Ubuntu-R.ttf")
	sightexports.sGui:setLabelAlignment(r29_49, "left", "center")
	sightexports.sGui:setLabelText(r29_49, "Játékosok:")
	local r30_49 = sightexports.sGui:getLabelTextWidth(r29_49)
	local r31_49 = r91_0.maxPlayers or 0
	if r31_49 < 2 then
		r91_0.maxPlayers = 2
		r31_49 = 2
	end
	if r21_49 < r31_49 then
		r91_0.maxPlayers = r21_49
		r31_49 = r21_49
	end
	local r32_49 = sightexports.sGui:createGuiElement("label", r4_49 / 2 - 55, r22_49, 55, 30, r86_0)
	sightexports.sGui:setLabelFont(r32_49, "10/Ubuntu-R.ttf")
	sightexports.sGui:setLabelAlignment(r32_49, "center", "center")
	sightexports.sGui:setLabelText(r32_49, r31_49)
	local r33_49 = sightexports.sGui:createGuiElement("slider", 8 + r30_49 + 8, r22_49 + 8, r4_49 / 2 - 8 - r30_49 - 8 - 55, 14, r86_0)
	sightexports.sGui:setSliderChangeEvent(r33_49, "airsoftMatchmakingSliderInput")
	sightexports.sGui:setClickArgument(r33_49, {
		"maxPlayers",
		2,
		r21_49,
		r32_49,
		""
	})
	sightexports.sGui:setSliderValue(r33_49, convertRangeToSlider(r31_49, 2, r21_49))
	local r34_49 = sightexports.sGui:createGuiElement("label", r4_49 / 2 + 8, r22_49, 0, 30, r86_0)
	sightexports.sGui:setLabelFont(r34_49, "10/Ubuntu-R.ttf")
	sightexports.sGui:setLabelAlignment(r34_49, "left", "center")
	sightexports.sGui:setLabelText(r34_49, "Játékidő:")
	local r35_49 = sightexports.sGui:getLabelTextWidth(r34_49)
	local r36_49 = r91_0.playTime or -1
	local r37_49 = r1_49.time[1]
	local r38_49 = r1_49.time[2]
	if r36_49 < r37_49 then
		r91_0.playTime = r37_49
		r36_49 = r37_49
	end
	if r38_49 < r36_49 then
		r91_0.playTime = r38_49
		r36_49 = r38_49
	end
	local r39_49 = sightexports.sGui:createGuiElement("label", r4_49 - 55, r22_49, 55, 30, r86_0)
	sightexports.sGui:setLabelFont(r39_49, "10/Ubuntu-R.ttf")
	sightexports.sGui:setLabelAlignment(r39_49, "center", "center")
	sightexports.sGui:setLabelText(r39_49, r36_49 .. " p")
	local r40_49 = sightexports.sGui:createGuiElement("slider", r4_49 / 2 + 8 + r35_49 + 8, r22_49 + 8, r4_49 / 2 - 8 - r35_49 - 8 - 55, 14, r86_0)
	sightexports.sGui:setSliderChangeEvent(r40_49, "airsoftMatchmakingSliderInput")
	sightexports.sGui:setClickArgument(r40_49, {
		"playTime",
		r37_49,
		r38_49,
		r39_49,
		" p"
	})
	sightexports.sGui:setSliderValue(r40_49, convertRangeToSlider(r36_49, r37_49, r38_49))
	r22_49 = r22_49 + 30
	local r41_49 = sightexports.sGui:createGuiElement("label", 8, r22_49, 0, 30, r86_0)
	sightexports.sGui:setLabelFont(r41_49, "10/Ubuntu-R.ttf")
	sightexports.sGui:setLabelAlignment(r41_49, "left", "center")
	sightexports.sGui:setLabelText(r41_49, "Várakozás:")
	local r42_49 = sightexports.sGui:getLabelTextWidth(r41_49)
	local r43_49 = r91_0.waitTime or 10
	local r44_49 = 1
	local r45_49 = 30
	if r43_49 < r44_49 then
		r91_0.waitTime = r44_49
		r43_49 = r44_49
	end
	if r45_49 < r43_49 then
		r91_0.waitTime = r45_49
		r43_49 = r45_49
	end
	local r46_49 = sightexports.sGui:createGuiElement("label", r4_49 / 2 - 55, r22_49, 55, 30, r86_0)
	sightexports.sGui:setLabelFont(r46_49, "10/Ubuntu-R.ttf")
	sightexports.sGui:setLabelAlignment(r46_49, "center", "center")
	sightexports.sGui:setLabelText(r46_49, r43_49 .. " p")
	local r47_49 = sightexports.sGui:createGuiElement("slider", 8 + r42_49 + 8, r22_49 + 8, r4_49 / 2 - 8 - r42_49 - 8 - 55, 14, r86_0)
	sightexports.sGui:setSliderChangeEvent(r47_49, "airsoftMatchmakingSliderInput")
	sightexports.sGui:setClickArgument(r47_49, {
		"waitTime",
		r44_49,
		r45_49,
		r46_49,
		" p"
	})
	sightexports.sGui:setSliderValue(r47_49, convertRangeToSlider(r43_49, r44_49, r45_49))
	local r48_49 = sightexports.sGui:createGuiElement("label", r4_49 / 2 + 8, r22_49, 0, 30, r86_0)
	sightexports.sGui:setLabelFont(r48_49, "10/Ubuntu-R.ttf")
	sightexports.sGui:setLabelAlignment(r48_49, "left", "center")
	sightexports.sGui:setLabelText(r48_49, "Bemelegítés:")
	local r49_49 = sightexports.sGui:getLabelTextWidth(r48_49)
	local r50_49 = r91_0.startTime or 1
	local r51_49 = 0.5
	local r52_49 = 15
	if r50_49 < r51_49 then
		r91_0.startTime = r51_49
		r50_49 = r51_49
	end
	if r52_49 < r50_49 then
		r91_0.startTime = r52_49
		r50_49 = r52_49
	end
	local r53_49 = sightexports.sGui:createGuiElement("label", r4_49 - 55, r22_49, 55, 30, r86_0)
	sightexports.sGui:setLabelFont(r53_49, "10/Ubuntu-R.ttf")
	sightexports.sGui:setLabelAlignment(r53_49, "center", "center")
	sightexports.sGui:setLabelText(r53_49, r50_49 .. " p")
	local r54_49 = sightexports.sGui:createGuiElement("slider", r4_49 / 2 + 8 + r49_49 + 8, r22_49 + 8, r4_49 / 2 - 8 - r49_49 - 8 - 55, 14, r86_0)
	sightexports.sGui:setSliderChangeEvent(r54_49, "airsoftMatchmakingSliderInput")
	sightexports.sGui:setClickArgument(r54_49, {
		"startTime",
		r51_49,
		r52_49,
		r53_49,
		" p",
		0.5
	})
	sightexports.sGui:setSliderValue(r54_49, convertRangeToSlider(r50_49, r51_49, r52_49))
	r22_49 = r22_49 + 30
	local r55_49 = sightexports.sGui:createGuiElement("label", 8, r22_49, 0, 30, r86_0)
	sightexports.sGui:setLabelFont(r55_49, "10/Ubuntu-R.ttf")
	sightexports.sGui:setLabelAlignment(r55_49, "left", "center")
	sightexports.sGui:setLabelText(r55_49, "Stamina:")
	local r56_49 = sightexports.sGui:getLabelTextWidth(r55_49)
	local r57_49 = r91_0.stamina or 100
	local r58_49 = 0
	local r59_49 = 100
	if r57_49 < r58_49 then
		r91_0.stamina = r58_49
		r57_49 = r58_49
	end
	if r59_49 < r57_49 then
		r91_0.stamina = r59_49
		r57_49 = r59_49
	end
	local r60_49 = sightexports.sGui:createGuiElement("label", r4_49 / 2 - 55, r22_49, 55, 30, r86_0)
	sightexports.sGui:setLabelFont(r60_49, "10/Ubuntu-R.ttf")
	sightexports.sGui:setLabelAlignment(r60_49, "center", "center")
	local r61_49 = sightexports.sGui
	local r63_49 = r60_49
	if r57_49 <= 0 then
		r64_49 = "off" or r57_49 .. "%"
	else
		r64_49 = r57_49 .. "%"
	end
	r61_49:setLabelText(r63_49, r64_49)
	r61_49 = sightexports.sGui:createGuiElement("slider", 8 + r56_49 + 8, r22_49 + 8, r4_49 / 2 - 8 - r56_49 - 8 - 55, 14, r86_0)
	sightexports.sGui:setSliderChangeEvent(r61_49, "airsoftMatchmakingSliderInput")
	sightexports.sGui:setClickArgument(r61_49, {
		"stamina",
		r58_49,
		r59_49,
		r60_49,
		"%"
	})
	sightexports.sGui:setSliderValue(r61_49, convertRangeToSlider(r57_49, r58_49, r59_49))
	local r62_49 = sightexports.sGui:createGuiElement("label", r4_49 / 2 + 8, r22_49, 0, 30, r86_0)
	sightexports.sGui:setLabelFont(r62_49, "10/Ubuntu-R.ttf")
	sightexports.sGui:setLabelAlignment(r62_49, "left", "center")
	sightexports.sGui:setLabelText(r62_49, "Respawn loadout:")
	r63_49 = sightexports.sGui:getLabelTextWidth(r62_49)
	local r64_49 = r91_0.respawnLoadout or 10
	local r65_49 = 0
	local r66_49 = 15
	if r64_49 < r65_49 then
		r91_0.respawnLoadout = r65_49
		r64_49 = r65_49
	end
	if r66_49 < r64_49 then
		r91_0.respawnLoadout = r66_49
		r64_49 = r66_49
	end
	local r67_49 = sightexports.sGui:createGuiElement("label", r4_49 - 55, r22_49, 55, 30, r86_0)
	sightexports.sGui:setLabelFont(r67_49, "10/Ubuntu-R.ttf")
	sightexports.sGui:setLabelAlignment(r67_49, "center", "center")
	local r68_49 = sightexports.sGui
	local r70_49 = r67_49
	local r71_49 = nil	-- notice: implicit variable refs by block#[126]
	if r64_49 <= 0 then
		r71_49 = "off"
		if not r71_49 then
			-- ::label_2303::
			r71_49 = r64_49 .. " s"
		end
	else
		r71_49 = r64_49 .. " s"
	end
	r68_49:setLabelText(r70_49, r71_49)
	r68_49 = sightexports.sGui:createGuiElement("slider", r4_49 / 2 + 8 + r63_49 + 8, r22_49 + 8, r4_49 / 2 - 8 - r63_49 - 8 - 55, 14, r86_0)
	sightexports.sGui:setSliderChangeEvent(r68_49, "airsoftMatchmakingSliderInput")
	local r69_49 = sightexports.sGui
	r71_49 = r68_49
	r69_49:setClickArgument(r71_49, {
		"respawnLoadout",
		r65_49,
		r66_49,
		r67_49,
		" s"
	})
	sightexports.sGui:setSliderValue(r68_49, convertRangeToSlider(r64_49, r65_49, r66_49))
	r22_49 = r22_49 + 30
	r69_49 = sightexports.sGui:createGuiElement("label", 8, r22_49, 0, 30, r86_0)
	sightexports.sGui:setLabelFont(r69_49, "10/Ubuntu-R.ttf")
	sightexports.sGui:setLabelAlignment(r69_49, "left", "center")
	sightexports.sGui:setLabelText(r69_49, "Fejlövések:")
	r70_49 = sightexports.sGui:getLabelTextWidth(r69_49)
	r71_49 = r91_0.headshots or 100
	local r72_49 = 0
	local r73_49 = 100
	if r71_49 < r72_49 then
		r91_0.headshots = r72_49
		r71_49 = r72_49
	end
	if r73_49 < r71_49 then
		r91_0.headshots = r73_49
		r71_49 = r73_49
	end
	local r74_49 = sightexports.sGui:createGuiElement("label", r4_49 / 2 - 55, r22_49, 55, 30, r86_0)
	sightexports.sGui:setLabelFont(r74_49, "10/Ubuntu-R.ttf")
	sightexports.sGui:setLabelAlignment(r74_49, "center", "center")
	local r75_49 = sightexports.sGui
	local r77_49 = r74_49
	local r78_49 = nil	-- notice: implicit variable refs by block#[135]
	if r71_49 <= 0 then
		r78_49 = "off"
		if not r78_49 then
			-- ::label_2437::
			r78_49 = r71_49 .. "%"
		end
	else
		r78_49 = r71_49 .. "%"
	end
	r75_49:setLabelText(r77_49, r78_49)
	r75_49 = sightexports.sGui:createGuiElement("slider", 8 + r70_49 + 8, r22_49 + 8, r4_49 / 2 - 8 - r70_49 - 8 - 55, 14, r86_0)
	sightexports.sGui:setSliderChangeEvent(r75_49, "airsoftMatchmakingSliderInput")
	local r76_49 = sightexports.sGui
	r78_49 = r75_49
	r76_49:setClickArgument(r78_49, {
		"headshots",
		r72_49,
		r73_49,
		r74_49,
		"%"
	})
	sightexports.sGui:setSliderValue(r75_49, convertRangeToSlider(r71_49, r72_49, r73_49))
	r76_49 = sightexports.sGui:createGuiElement("label", r4_49 / 2 + 8, r22_49, 0, 30, r86_0)
	sightexports.sGui:setLabelFont(r76_49, "10/Ubuntu-R.ttf")
	sightexports.sGui:setLabelAlignment(r76_49, "left", "center")
	sightexports.sGui:setLabelText(r76_49, "Respawn idő:")
	r77_49 = sightexports.sGui:getLabelTextWidth(r76_49)
	r78_49 = r91_0.respawnTime or 10
	local r79_49 = 5
	local r80_49 = 30
	if r78_49 < r79_49 then
		r91_0.respawnTime = r79_49
		r78_49 = r79_49
	end
	if r80_49 < r78_49 then
		r91_0.respawnTime = r80_49
		r78_49 = r80_49
	end
	local r81_49 = sightexports.sGui:createGuiElement("label", r4_49 - 55, r22_49, 55, 30, r86_0)
	sightexports.sGui:setLabelFont(r81_49, "10/Ubuntu-R.ttf")
	sightexports.sGui:setLabelAlignment(r81_49, "center", "center")
	local r82_49 = sightexports.sGui
	local r84_49 = r81_49
	local r85_49 = nil	-- notice: implicit variable refs by block#[144]
	if r78_49 <= 0 then
		r85_49 = "off"
		if not r85_49 then
			-- ::label_2568::
			r85_49 = r78_49 .. " s"
		end
	else
		r85_49 = r78_49 .. " s"
	end
	r82_49:setLabelText(r84_49, r85_49)
	r82_49 = sightexports.sGui:createGuiElement("slider", r4_49 / 2 + 8 + r77_49 + 8, r22_49 + 8, r4_49 / 2 - 8 - r77_49 - 8 - 55, 14, r86_0)
	sightexports.sGui:setSliderChangeEvent(r82_49, "airsoftMatchmakingSliderInput")
	local r83_49 = sightexports.sGui
	r85_49 = r82_49
	r83_49:setClickArgument(r85_49, {
		"respawnTime",
		r79_49,
		r80_49,
		r81_49,
		" s"
	})
	sightexports.sGui:setSliderValue(r82_49, convertRangeToSlider(r78_49, r79_49, r80_49))
	r22_49 = r22_49 + 30 + 8
	r83_49 = sightexports.sGui:createGuiElement("label", 0, r22_49, r4_49, 30, r86_0)
	sightexports.sGui:setLabelFont(r83_49, "11/Ubuntu-R.ttf")
	sightexports.sGui:setLabelAlignment(r83_49, "center", "center")
	sightexports.sGui:setLabelText(r83_49, "A meccs szervezési díja [color=sightgreen]" .. sightexports.sGui:thousandsStepper(50000) .. " $#ffffff, ami létrehozáskor kerül levonásra.")
	r22_49 = r22_49 + 30 + 8
	r84_49 = sightexports.sGui:createGuiElement("button", r4_49 / 2 - 128, r3_49 - 32 - 8, 256, 32, r86_0)
	setGuiBackground(r84_49, "solid", "sightgreen")
	r85_49 = sightexports.sGui
	r85_49:setGuiHover(r84_49, "gradient", {
		"sightgreen",
		"sightgreen-second"
	}, false, true)
	sightexports.sGui:setButtonFont(r84_49, "14/BebasNeueBold.otf")
	sightexports.sGui:setButtonText(r84_49, " Meccs létrehozása")
	sightexports.sGui:setButtonIcon(r84_49, sightexports.sGui:getFaIconFilename("plus", 32))
	sightexports.sGui:setClickEvent(r84_49, "createAirsoftMatchFinal")
end
addEvent("createAirsoftMatchmakingWindow", false)
addEventHandler("createAirsoftMatchmakingWindow", getRootElement(), createAirsoftMatchmakingWindow)
function createMatchmakingLoader()
	-- line: [1862, 1882] id: 50
	if r93_0 and exports.sGui:isGuiElementValid(r93_0) then
		sightexports.sGui:deleteGuiElement(r93_0)
	end
	r93_0 = nil
	if r85_0 and exports.sGui:isGuiElementValid(r85_0) then
		sightexports.sGui:deleteGuiElement(r85_0)
	end
	r85_0 = nil
	if r86_0 and exports.sGui:isGuiElementValid(r86_0) then
		sightexports.sGui:deleteGuiElement(r86_0)
	end
	r86_0 = nil
	deleteMatchJoinWindow()
	r72_0(false)
	r70_0(false)
	r87_0 = false
	local r0_50 = sightexports.sGui:getTitleBarHeight()
	local r1_50 = 300
	local r2_50 = 200
	r85_0 = sightexports.sGui:createGuiElement("window", r83_0 / 2 - r1_50 / 2, r84_0 / 2 - r2_50 / 2, r1_50, r2_50)
	sightexports.sGui:setWindowTitle(r85_0, "16/BebasNeueRegular.otf", "Airsoft meccs létrehozása")
	local r3_50 = sightexports.sGui:createGuiElement("image", r1_50 / 2 - 24, r0_50 + (r2_50 - r0_50) / 2 - 24, 48, 48, r85_0)
	sightexports.sGui:setImageFile(r3_50, sightexports.sGui:getFaIconFilename("circle-notch", 48))
	sightexports.sGui:setImageSpinner(r3_50, true)
end
addEvent("createAirsoftMatchResponse", true)
addEventHandler("createAirsoftMatchResponse", getRootElement(), function(r0_51)
	-- line: [1886, 1892] id: 51
	if r0_51 then
		r91_0 = {}
	else
		createAirsoftMatchmakingWindow()
	end
end)
addEvent("createAirsoftMatchFinal", false)
addEventHandler("createAirsoftMatchFinal", getRootElement(), function()
	-- line: [1896, 1948] id: 52
	if not r91_0.matchName or utf8.len(r91_0.matchName) < 1 then
		sightexports.sGui:showInfobox("e", "A meccs nevét kötelező megadni.")
		return 
	end
	local r0_52 = tonumber(r91_0.joinFee) or 0
	if r0_52 < 0 or 1000000 < r0_52 then
		sightexports.sGui:showInfobox("e", "A nevezési díjnak " .. sightexports.sGui:thousandsStepper(0) .. " - " .. sightexports.sGui:thousandsStepper(1000000) .. " $ között kell lennie")
		return 
	end
	local r1_52 = {}
	for r5_52, r6_52 in pairs(r91_0) do
		r1_52[r5_52] = r6_52
	end
	r1_52.joinFee = r0_52
	if gameModes[r91_0.gm].team then
		if not r91_0.teamShaderMode or r91_0.teamShaderMode == "Igen + Csapat falon keresztül" then
			r1_52.shaderAllowed = true
			r1_52.wallhackAllowed = true
		elseif r91_0.teamShaderMode == "Igen" then
			r1_52.shaderAllowed = true
		end
		r1_52.teamShaderMode = nil
		r1_52.individualShaderMode = nil
		local r3_52 = r91_0.friendlyFire
		if r3_52 == "Igen" then
			r3_52 = true or nil
		else
			r3_52 = nil
		end
		r1_52.friendlyFire = r3_52
		r3_52 = r91_0.canChangeTeam or "Igen"
		if r3_52 == "Igen" then
			r3_52 = true or nil
		else
			r3_52 = nil
		end
		r1_52.canChangeTeam = r3_52
	else
		local r3_52 = r91_0.individualShaderMode or "Igen"
		if r3_52 == "Igen" then
			r3_52 = true or nil
		else
			r3_52 = nil
		end
		r1_52.shaderAllowed = r3_52
		r1_52.teamShaderMode = nil
		r1_52.individualShaderMode = nil
		r1_52.friendlyFire = nil
		r1_52.canChangeTeam = nil
	end
	local r3_52 = r91_0.private
	if r3_52 == "Igen" then
		r3_52 = true or nil
	else
		r3_52 = nil
	end
	r1_52.private = r3_52
	createMatchmakingLoader()
	triggerServerEvent("createAirsoftMatch", localPlayer, r1_52)
end)
function convertSliderToRange(r0_53, r1_53, r2_53, r3_53)
	-- line: [1950, 1952] id: 53
	return math.floor(((r1_53 + (r2_53 - r1_53) * r0_53) / r3_53 + 0.5)) * r3_53
end
function convertRangeToSlider(r0_54, r1_54, r2_54)
	-- line: [1954, 1956] id: 54
	return (r0_54 - r1_54) / (r2_54 - r1_54)
end
addEvent("airsoftMatchmakingSliderInput", false)
addEventHandler("airsoftMatchmakingSliderInput", getRootElement(), function(r0_55, r1_55, r2_55, r3_55)
	-- line: [1960, 1973] id: 55
	r1_55 = convertSliderToRange(r1_55, r3_55[2], r3_55[3], r3_55[6] or 1)
	if r1_55 <= 0 then
		sightexports.sGui:setLabelText(r3_55[4], "off")
	else
		sightexports.sGui:setLabelText(r3_55[4], sightexports.sGui:thousandsStepper(r1_55) .. r3_55[5])
	end
	sightexports.sGui:setSliderValue(r0_55, convertRangeToSlider(r1_55, r3_55[2], r3_55[3]))
	r91_0[r3_55[1]] = r1_55
end)
addEvent("airsoftMatchmakingButtonInput", false)
addEventHandler("airsoftMatchmakingButtonInput", getRootElement(), function(r0_56, r1_56, r2_56, r3_56, r4_56, r5_56)
	-- line: [1977, 1980] id: 56
	r91_0[r5_56] = sightexports.sGui:getButtonText(r4_56)
	createAirsoftMatchmakingWindow()
end)
addEvent("airsoftMatchmakingInputChange", false)
addEventHandler("airsoftMatchmakingInputChange", getRootElement(), function(r0_57, r1_57, r2_57)
	-- line: [1984, 1987] id: 57
	r91_0[r2_57] = r0_57
end)
function createMatchJoinWindow(r0_58)
	-- line: [1990, 2349] id: 58
	local r1_58 = sightexports.sGui:getTitleBarHeight()
	local r2_58 = 700
	local r3_58 = sightexports.sGui:getFontHeight("11/Ubuntu-B.ttf") + 4
	local r4_58 = nil
	local r5_58 = nil
	local r6_58 = nil
	if r0_58 then
		r4_58 = airsoftMaps[r0_58.map]
		r5_58 = gameModes[r0_58.gm]
		local r7_58 = r1_58 + 8
		local r8_58 = r5_58.team
		if r8_58 then
			r8_58 = 2 or 0
		else
			r8_58 = 0
		end
		r6_58 = r7_58 + r3_58 * (12 + r8_58) + 8 + 30 + 8
	else
		r6_58 = r1_58 + 8 + r3_58 * 14 + 8 + 30 + 8
	end
	local r7_58 = r83_0 / 2 - r2_58 / 2
	local r8_58 = r84_0 / 2 - r6_58 / 2
	if r88_0 then
		r7_58, r8_58 = sightexports.sGui:getGuiPosition(r88_0)
	end
	if r93_0 and exports.sGui:isGuiElementValid(r93_0) then
		sightexports.sGui:deleteGuiElement(r93_0)
	end
	r93_0 = nil
	if r85_0 and exports.sGui:isGuiElementValid(r85_0) then
		sightexports.sGui:deleteGuiElement(r85_0)
	end
	r85_0 = nil
	if r86_0 and exports.sGui:isGuiElementValid(r86_0) then
		sightexports.sGui:deleteGuiElement(r86_0)
	end
	r86_0 = nil
	deleteMatchJoinWindow()
	r90_0 = {}
	r88_0 = sightexports.sGui:createGuiElement("window", r83_0 / 2 - r2_58 / 2, r84_0 / 2 - r6_58 / 2, r2_58, r6_58)
	if r0_58 then
		sightexports.sGui:setWindowTitle(r88_0, "16/BebasNeueRegular.otf", "Csatlakozás a meccsre: " .. r0_58.name)
		sightexports.sGui:setWindowCloseButton(r88_0, "createMatchSelectorWindow")
		r76_0(true)
		r74_0(true)
	else
		sightexports.sGui:setWindowTitle(r88_0, "16/BebasNeueRegular.otf", "Csatlakozás a meccsre")
	end
	local r9_58 = false
	local r10_58 = false
	local r11_58, r12_58, r13_58 = getElementPosition(localPlayer)
	for r17_58 in pairs(r96_0) do
		local r18_58, r19_58, r20_58 = getElementPosition(r17_58)
		local r21_58 = getDistanceBetweenPoints3D(r11_58, r12_58, r13_58, r18_58, r19_58, r20_58)
		if not r9_58 or r21_58 < r9_58 then
			r9_58 = r21_58
			r10_58 = r17_58
		end
	end
	sightexports.sGui:setWindowElementMaxDistance(r88_0, r10_58, 5, "closeAirsoftMatchSelector")
	if r0_58 then
		r90_0.starting = r0_58.starting
		local r14_58 = r1_58 + 8
		local r15_58 = sightexports.sGui:createGuiElement("label", 8, r14_58, 0, r3_58, r88_0)
		sightexports.sGui:setLabelFont(r15_58, "11/Ubuntu-B.ttf")
		sightexports.sGui:setLabelAlignment(r15_58, "left", "center")
		sightexports.sGui:setLabelText(r15_58, "Létrehozta: ")
		local r16_58 = sightexports.sGui:createGuiElement("label", 8 + sightexports.sGui:getLabelTextWidth(r15_58), r14_58, 0, r3_58, r88_0)
		sightexports.sGui:setLabelFont(r16_58, "11/Ubuntu-R.ttf")
		sightexports.sGui:setLabelAlignment(r16_58, "left", "center")
		sightexports.sGui:setLabelText(r16_58, r0_58.createdBy)
		sightexports.sGui:setLabelColor(r16_58, "sightblue")
		r14_58 = r14_58 + r3_58
		local r17_58 = sightexports.sGui:createGuiElement("label", 8, r14_58, 0, r3_58, r88_0)
		sightexports.sGui:setLabelFont(r17_58, "11/Ubuntu-B.ttf")
		sightexports.sGui:setLabelAlignment(r17_58, "left", "center")
		sightexports.sGui:setLabelText(r17_58, "Pálya: ")
		local r18_58 = sightexports.sGui:createGuiElement("label", 8 + sightexports.sGui:getLabelTextWidth(r17_58), r14_58, 0, r3_58, r88_0)
		sightexports.sGui:setLabelFont(r18_58, "11/Ubuntu-R.ttf")
		sightexports.sGui:setLabelAlignment(r18_58, "left", "center")
		sightexports.sGui:setLabelText(r18_58, r4_58.name)
		sightexports.sGui:setLabelColor(r18_58, "sightblue")
		r14_58 = r14_58 + r3_58
		local r19_58 = sightexports.sGui:createGuiElement("label", 8, r14_58, 0, r3_58, r88_0)
		sightexports.sGui:setLabelFont(r19_58, "11/Ubuntu-B.ttf")
		sightexports.sGui:setLabelAlignment(r19_58, "left", "center")
		sightexports.sGui:setLabelText(r19_58, "Játékmód: ")
		local r20_58 = sightexports.sGui:createGuiElement("label", 8 + sightexports.sGui:getLabelTextWidth(r19_58), r14_58, 0, r3_58, r88_0)
		sightexports.sGui:setLabelFont(r20_58, "11/Ubuntu-R.ttf")
		sightexports.sGui:setLabelAlignment(r20_58, "left", "center")
		sightexports.sGui:setLabelText(r20_58, r5_58.name)
		sightexports.sGui:setLabelColor(r20_58, r5_58.color)
		r14_58 = r14_58 + r3_58
		local r21_58 = sightexports.sGui:createGuiElement("label", 8, r14_58, 0, r3_58, r88_0)
		sightexports.sGui:setLabelFont(r21_58, "11/Ubuntu-B.ttf")
		sightexports.sGui:setLabelAlignment(r21_58, "left", "center")
		sightexports.sGui:setLabelText(r21_58, "Privát meccs: ")
		local r22_58 = sightexports.sGui:createGuiElement("label", 8 + sightexports.sGui:getLabelTextWidth(r21_58), r14_58, 0, r3_58, r88_0)
		sightexports.sGui:setLabelFont(r22_58, "11/Ubuntu-R.ttf")
		sightexports.sGui:setLabelAlignment(r22_58, "left", "center")
		local r23_58 = sightexports.sGui
		local r25_58 = r22_58
		local r26_58 = r0_58.private
		if r26_58 then
			r26_58 = "igen" or "nem"
		else
			r26_58 = "nem"
		end
		r23_58:setLabelText(r25_58, r26_58)
		r23_58 = sightexports.sGui
		r25_58 = r22_58
		r26_58 = r0_58.private
		if r26_58 then
			r26_58 = "sightgreen" or "sightred"
		else
			r26_58 = "sightred"
		end
		r23_58:setLabelColor(r25_58, r26_58)
		r90_0.private = r0_58.private
		r14_58 = r14_58 + r3_58
		if r5_58.team then
			r23_58 = sightexports.sGui:createGuiElement("label", 8, r14_58, 0, r3_58, r88_0)
			sightexports.sGui:setLabelFont(r23_58, "11/Ubuntu-B.ttf")
			sightexports.sGui:setLabelAlignment(r23_58, "left", "center")
			sightexports.sGui:setLabelText(r23_58, "Szabad csapatválasztás: ")
			local r24_58 = sightexports.sGui:createGuiElement("label", 8 + sightexports.sGui:getLabelTextWidth(r23_58), r14_58, 0, r3_58, r88_0)
			sightexports.sGui:setLabelFont(r24_58, "11/Ubuntu-R.ttf")
			sightexports.sGui:setLabelAlignment(r24_58, "left", "center")
			r25_58 = sightexports.sGui
			local r27_58 = r24_58
			local r28_58 = r0_58.canChangeTeam
			if r28_58 then
				r28_58 = "igen" or "nem"
			else
				r28_58 = "nem"
			end
			r25_58:setLabelText(r27_58, r28_58)
			r25_58 = sightexports.sGui
			r27_58 = r24_58
			r28_58 = r0_58.canChangeTeam
			if r28_58 then
				r28_58 = "sightgreen" or "sightred"
			else
				r28_58 = "sightred"
			end
			r25_58:setLabelColor(r27_58, r28_58)
			r14_58 = r14_58 + r3_58
			r25_58 = sightexports.sGui:createGuiElement("label", 8, r14_58, 0, r3_58, r88_0)
			sightexports.sGui:setLabelFont(r25_58, "11/Ubuntu-B.ttf")
			sightexports.sGui:setLabelAlignment(r25_58, "left", "center")
			sightexports.sGui:setLabelText(r25_58, "Friendly Fire: ")
			r26_58 = sightexports.sGui:createGuiElement("label", 8 + sightexports.sGui:getLabelTextWidth(r25_58), r14_58, 0, r3_58, r88_0)
			sightexports.sGui:setLabelFont(r26_58, "11/Ubuntu-R.ttf")
			sightexports.sGui:setLabelAlignment(r26_58, "left", "center")
			r27_58 = sightexports.sGui
			local r29_58 = r26_58
			local r30_58 = r0_58.friendlyFire
			if r30_58 then
				r30_58 = "igen" or "nem"
			else
				r30_58 = "nem"
			end
			r27_58:setLabelText(r29_58, r30_58)
			r27_58 = sightexports.sGui
			r29_58 = r26_58
			r30_58 = r0_58.friendlyFire
			if r30_58 then
				r30_58 = "sightred" or "sightgreen"
			else
				r30_58 = "sightgreen"
			end
			r27_58:setLabelColor(r29_58, r30_58)
			r14_58 = r14_58 + r3_58
			r27_58 = sightexports.sGui:createGuiElement("label", 8, r14_58, 0, r3_58, r88_0)
			sightexports.sGui:setLabelFont(r27_58, "11/Ubuntu-B.ttf")
			sightexports.sGui:setLabelAlignment(r27_58, "left", "center")
			sightexports.sGui:setLabelText(r27_58, "Játékos színek megjelenítése: ")
			r28_58 = sightexports.sGui:createGuiElement("label", 8 + sightexports.sGui:getLabelTextWidth(r27_58), r14_58, 0, r3_58, r88_0)
			sightexports.sGui:setLabelFont(r28_58, "11/Ubuntu-R.ttf")
			sightexports.sGui:setLabelAlignment(r28_58, "left", "center")
			if r0_58.shaderAllowed then
				r29_58 = sightexports.sGui
				local r31_58 = r28_58
				local r32_58 = r0_58.wallhackAllowed
				if r32_58 then
					r32_58 = "igen + csapat" or "igen"
				else
					r32_58 = "igen"
				end
				r29_58:setLabelText(r31_58, r32_58)
			else
				sightexports.sGui:setLabelText(r28_58, "nem")
			end
			r29_58 = sightexports.sGui
			local r31_58 = r28_58
			local r32_58 = r0_58.shaderAllowed
			if r32_58 then
				r32_58 = "sightgreen" or "sightred"
			else
				r32_58 = "sightred"
			end
			r29_58:setLabelColor(r31_58, r32_58)
			r14_58 = r14_58 + r3_58
		else
			r23_58 = sightexports.sGui:createGuiElement("label", 8, r14_58, 0, r3_58, r88_0)
			sightexports.sGui:setLabelFont(r23_58, "11/Ubuntu-B.ttf")
			sightexports.sGui:setLabelAlignment(r23_58, "left", "center")
			sightexports.sGui:setLabelText(r23_58, "Játékosok megjelenítése spectator módban: ")
			local r24_58 = sightexports.sGui:createGuiElement("label", 8 + sightexports.sGui:getLabelTextWidth(r23_58), r14_58, 0, r3_58, r88_0)
			sightexports.sGui:setLabelFont(r24_58, "11/Ubuntu-R.ttf")
			sightexports.sGui:setLabelAlignment(r24_58, "left", "center")
			r25_58 = sightexports.sGui
			local r27_58 = r24_58
			local r28_58 = r0_58.shaderAllowed
			if r28_58 then
				r28_58 = "igen" or "nem"
			else
				r28_58 = "nem"
			end
			r25_58:setLabelText(r27_58, r28_58)
			r25_58 = sightexports.sGui
			r27_58 = r24_58
			r28_58 = r0_58.shaderAllowed
			if r28_58 then
				r28_58 = "sightgreen" or "sightred"
			else
				r28_58 = "sightred"
			end
			r25_58:setLabelColor(r27_58, r28_58)
			r14_58 = r14_58 + r3_58
		end
		r23_58 = sightexports.sGui:createGuiElement("label", 8, r14_58, 0, r3_58, r88_0)
		sightexports.sGui:setLabelFont(r23_58, "11/Ubuntu-B.ttf")
		sightexports.sGui:setLabelAlignment(r23_58, "left", "center")
		sightexports.sGui:setLabelText(r23_58, "Játékidő: ")
		local r24_58 = sightexports.sGui:createGuiElement("label", 8 + sightexports.sGui:getLabelTextWidth(r23_58), r14_58, 0, r3_58, r88_0)
		sightexports.sGui:setLabelFont(r24_58, "11/Ubuntu-R.ttf")
		sightexports.sGui:setLabelAlignment(r24_58, "left", "center")
		sightexports.sGui:setLabelText(r24_58, r0_58.length .. " perc")
		sightexports.sGui:setLabelColor(r24_58, "sightblue")
		r14_58 = r14_58 + r3_58
		r25_58 = sightexports.sGui:createGuiElement("label", 8, r14_58, 0, r3_58, r88_0)
		sightexports.sGui:setLabelFont(r25_58, "11/Ubuntu-B.ttf")
		sightexports.sGui:setLabelAlignment(r25_58, "left", "center")
		sightexports.sGui:setLabelText(r25_58, "Bemelegítés: ")
		r26_58 = sightexports.sGui:createGuiElement("label", 8 + sightexports.sGui:getLabelTextWidth(r25_58), r14_58, 0, r3_58, r88_0)
		sightexports.sGui:setLabelFont(r26_58, "11/Ubuntu-R.ttf")
		sightexports.sGui:setLabelAlignment(r26_58, "left", "center")
		sightexports.sGui:setLabelText(r26_58, r0_58.gameStartTime .. " másodperc")
		sightexports.sGui:setLabelColor(r26_58, "sightblue")
		r14_58 = r14_58 + r3_58
		local r27_58 = sightexports.sGui:createGuiElement("label", 8, r14_58, 0, r3_58, r88_0)
		sightexports.sGui:setLabelFont(r27_58, "11/Ubuntu-B.ttf")
		sightexports.sGui:setLabelAlignment(r27_58, "left", "center")
		sightexports.sGui:setLabelText(r27_58, "Stamina: ")
		local r28_58 = sightexports.sGui:createGuiElement("label", 8 + sightexports.sGui:getLabelTextWidth(r27_58), r14_58, 0, r3_58, r88_0)
		sightexports.sGui:setLabelFont(r28_58, "11/Ubuntu-R.ttf")
		sightexports.sGui:setLabelAlignment(r28_58, "left", "center")
		if r0_58.stamina and r0_58.stamina > 0 then
			sightexports.sGui:setLabelText(r28_58, math.floor(r0_58.staminaMul) .. "%")
			sightexports.sGui:setLabelColor(r28_58, "sightblue")
		else
			sightexports.sGui:setLabelText(r28_58, "off")
			sightexports.sGui:setLabelColor(r28_58, "sightred")
		end
		r14_58 = r14_58 + r3_58
		local r29_58 = sightexports.sGui:createGuiElement("label", 8, r14_58, 0, r3_58, r88_0)
		sightexports.sGui:setLabelFont(r29_58, "11/Ubuntu-B.ttf")
		sightexports.sGui:setLabelAlignment(r29_58, "left", "center")
		sightexports.sGui:setLabelText(r29_58, "Fejlövések: ")
		local r30_58 = sightexports.sGui:createGuiElement("label", 8 + sightexports.sGui:getLabelTextWidth(r29_58), r14_58, 0, r3_58, r88_0)
		sightexports.sGui:setLabelFont(r30_58, "11/Ubuntu-R.ttf")
		sightexports.sGui:setLabelAlignment(r30_58, "left", "center")
		if r0_58.headshotPlus and r0_58.headshotPlus > 0 then
			sightexports.sGui:setLabelText(r30_58, r0_58.headshotPlus .. "%")
			sightexports.sGui:setLabelColor(r30_58, "sightblue")
		else
			sightexports.sGui:setLabelText(r30_58, "off")
			sightexports.sGui:setLabelColor(r30_58, "sightred")
		end
		r14_58 = r14_58 + r3_58
		local r31_58 = sightexports.sGui:createGuiElement("label", 8, r14_58, 0, r3_58, r88_0)
		sightexports.sGui:setLabelFont(r31_58, "11/Ubuntu-B.ttf")
		sightexports.sGui:setLabelAlignment(r31_58, "left", "center")
		sightexports.sGui:setLabelText(r31_58, "Respawn loadout: ")
		local r32_58 = sightexports.sGui:createGuiElement("label", 8 + sightexports.sGui:getLabelTextWidth(r31_58), r14_58, 0, r3_58, r88_0)
		sightexports.sGui:setLabelFont(r32_58, "11/Ubuntu-R.ttf")
		sightexports.sGui:setLabelAlignment(r32_58, "left", "center")
		if r0_58.canChangeLoadout and r0_58.canChangeLoadout > 0 then
			sightexports.sGui:setLabelText(r32_58, r0_58.canChangeLoadout .. " másodperc")
			sightexports.sGui:setLabelColor(r32_58, "sightblue")
		else
			sightexports.sGui:setLabelText(r32_58, "off")
			sightexports.sGui:setLabelColor(r32_58, "sightred")
		end
		r14_58 = r14_58 + r3_58
		local r33_58 = sightexports.sGui:createGuiElement("label", 8, r14_58, 0, r3_58, r88_0)
		sightexports.sGui:setLabelFont(r33_58, "11/Ubuntu-B.ttf")
		sightexports.sGui:setLabelAlignment(r33_58, "left", "center")
		sightexports.sGui:setLabelText(r33_58, "Respawn idő: ")
		local r34_58 = sightexports.sGui:createGuiElement("label", 8 + sightexports.sGui:getLabelTextWidth(r33_58), r14_58, 0, r3_58, r88_0)
		sightexports.sGui:setLabelFont(r34_58, "11/Ubuntu-R.ttf")
		sightexports.sGui:setLabelAlignment(r34_58, "left", "center")
		sightexports.sGui:setLabelText(r34_58, r0_58.reSpawn .. " másodperc")
		sightexports.sGui:setLabelColor(r34_58, "sightblue")
		r14_58 = r14_58 + r3_58
		local r35_58 = sightexports.sGui:createGuiElement("label", 8, r14_58, 0, r3_58, r88_0)
		sightexports.sGui:setLabelFont(r35_58, "11/Ubuntu-B.ttf")
		sightexports.sGui:setLabelAlignment(r35_58, "left", "center")
		sightexports.sGui:setLabelText(r35_58, "Nevezési díj: ")
		local r36_58 = sightexports.sGui:createGuiElement("label", 8 + sightexports.sGui:getLabelTextWidth(r35_58), r14_58, 0, r3_58, r88_0)
		sightexports.sGui:setLabelFont(r36_58, "11/Ubuntu-R.ttf")
		sightexports.sGui:setLabelAlignment(r36_58, "left", "center")
		local r37_58 = sightexports.sGui
		local r39_58 = r36_58
		local r40_58 = r0_58.joinFee
		if r40_58 and r40_58 > 0 then
			r40_58 = sightexports.sGui:thousandsStepper(r0_58.joinFee) .. " $" or "nincs"
		else
			r40_58 = "nincs"
		end
		r37_58:setLabelText(r39_58, r40_58)
		sightexports.sGui:setLabelColor(r36_58, "sightgreen")
		r37_58 = 13
		local r38_58 = (r6_58 - r1_58 - 16) / r37_58
		r39_58 = r2_58 * 0.4
		r40_58 = sightexports.sGui:createGuiElement("button", 8, r14_58 + r3_58 + 8, r2_58 - r39_58 - 2 - 24, 30, r88_0)
		setGuiBackground(r40_58, "solid", "sightgreen")
		sightexports.sGui:setGuiHover(r40_58, "gradient", {
			"sightgreen",
			"sightgreen-second"
		}, false, true)
		sightexports.sGui:setButtonFont(r40_58, "14/BebasNeueBold.otf")
		if r0_58.joinFee then
			sightexports.sGui:setClickEvent(r40_58, "airsoftJoinMatchPrompt")
			sightexports.sGui:setClickArgument(r40_58, r0_58.joinFee)
		elseif r0_58.private then
			sightexports.sGui:setClickEvent(r40_58, "airsoftJoinMatchPinPrompt")
		else
			sightexports.sGui:setClickEvent(r40_58, "airsoftJoinMatchFinal")
		end
		r90_0.id = r0_58.id
		r90_0.map = r0_58.map
		r90_0.btn = r40_58
		r90_0.maxPlayers = r0_58.maxPlayers
		local r41_58 = sightexports.sGui:createGuiElement("rectangle", r2_58 - r39_58 - 8 - 2, r1_58 + 8, r39_58 + 2, r38_58, r88_0)
		setGuiBackground(r41_58, "solid", "sightgrey1")
		local r42_58 = sightexports.sGui:createGuiElement("label", 0, 0, r39_58, r38_58, r41_58)
		sightexports.sGui:setLabelFont(r42_58, "10/Ubuntu-R.ttf")
		sightexports.sGui:setLabelAlignment(r42_58, "center", "center")
		r90_0.playersLabel = r42_58
		local r43_58 = r38_58 * (r37_58 - 1)
		r90_0.sh = r43_58
		local r44_58 = sightexports.sGui:createGuiElement("rectangle", r39_58, r38_58, 2, r43_58, r41_58)
		setGuiBackground(r44_58, "solid", "sightgrey1")
		r90_0.scollBar = sightexports.sGui:createGuiElement("scrollbar", 0, 0, 2, r43_58, r44_58)
		setGuiBackground(r90_0.scollBar, "solid", "sightlightgrey")
		local r45_58 = sightexports.sGui:createGuiElement("rectangle", r2_58 - r39_58 - 8 - 2, r1_58 + 8 + r38_58, r39_58, r38_58 * (r37_58 - 1), r88_0)
		setGuiBackground(r45_58, "solid", "sightgrey3")
		r90_0.playerLabels = {}
		r90_0.playerDivs = {}
		r90_0.playerScroll = 0
		for r49_58 = 1, r37_58 - 1, 1 do
			local r50_58 = sightexports.sGui:createGuiElement("label", 4, r38_58 * (r49_58 - 1), r39_58 - 8, r38_58, r45_58)
			sightexports.sGui:setLabelFont(r50_58, "10/Ubuntu-L.ttf")
			sightexports.sGui:setLabelAlignment(r50_58, "left", "center")
			sightexports.sGui:setLabelClip(r50_58, true)
			r90_0.playerLabels[r49_58] = r50_58
			if r49_58 > 1 then
				local r51_58 = sightexports.sGui:createGuiElement("rectangle", 4, r38_58 * (r49_58 - 1), r39_58 - 8, 1, r45_58)
				setGuiBackground(r51_58, "solid", "sightgrey2")
				r90_0.playerDivs[r49_58] = r51_58
			end
		end
	else
		local r14_58 = sightexports.sGui:createGuiElement("image", r2_58 / 2 - 24, r1_58 + (r6_58 - r1_58) / 2 - 24, 48, 48, r88_0)
		sightexports.sGui:setImageFile(r14_58, sightexports.sGui:getFaIconFilename("circle-notch", 48))
		sightexports.sGui:setImageSpinner(r14_58, true)
	end
end
function matchJoinKey(r0_59)
	-- line: [2351, 2363] id: 59
	if r0_59 == "mouse_wheel_up" and r90_0.playerScroll > 0 then
		r90_0.playerScroll = r90_0.playerScroll - 1
		refreshMatchJoinPlayerList()
	elseif r0_59 == "mouse_wheel_down" and r90_0.playerScroll < #r90_0.playerList - #r90_0.playerLabels then
		r90_0.playerScroll = r90_0.playerScroll + 1
		refreshMatchJoinPlayerList()
	end
end
function matchJoinPreRender()
	-- line: [2365, 2380] id: 60
	local r0_60 = getRealTime().timestamp
	local r1_60 = math.max(0, r90_0.starting - getRealTime().timestamp)
	local r4_60 = string.format("%02d:%02d", math.floor(r1_60 / 60), r1_60 % 60)
	if r90_0.joinText ~= r4_60 then
		r90_0.joinText = r4_60
		sightexports.sGui:setGuiHoverable(r90_0.btn, 0 < r1_60)
		sightexports.sGui:setButtonText(r90_0.btn, "Csatlakozás (" .. r90_0.joinText .. ")")
	end
end
function refreshMatchJoinPlayerList()
	-- line: [2382, 2411] id: 61
	local r0_61 = math.max(0, #r90_0.playerList - #r90_0.playerLabels)
	if r0_61 < r90_0.playerScroll then
		r90_0.playerScroll = r0_61
	end
	local r1_61 = r90_0.sh / (r0_61 + 1)
	
	sightexports.sGui:setGuiPosition(r90_0.scollBar, false, r1_61 * r90_0.playerScroll)
	sightexports.sGui:setGuiSize(r90_0.scollBar, false, r1_61)
	sightexports.sGui:setLabelText(r90_0.playersLabel, "Játékosok (" .. #r90_0.playerList .. "/" .. r90_0.maxPlayers .. ")")
	for r5_61 = 1, #r90_0.playerLabels, 1 do
		local r6_61 = r5_61 + r90_0.playerScroll
		if r90_0.playerDivs[r5_61] then
			sightexports.sGui:setGuiRenderDisabled(r90_0.playerDivs[r5_61], not r90_0.playerList[r6_61])
		end
		if r90_0.playerList[r6_61] then
			sightexports.sGui:setGuiRenderDisabled(r90_0.playerLabels[r5_61], false)
			sightexports.sGui:setLabelText(r90_0.playerLabels[r5_61], r90_0.playerList[r6_61][2])
		else
			sightexports.sGui:setGuiRenderDisabled(r90_0.playerLabels[r5_61], true)
		end
	end
end
addEvent("gotAirsoftMatchJoinPlayerAdded", true)
addEventHandler("gotAirsoftMatchJoinPlayerAdded", getRootElement(), function(r0_62, r1_62, r2_62)
	-- line: [2415, 2427] id: 62
	if r90_0 and r90_0.id == r0_62 then
		for r6_62 = #r90_0.playerList, 1, -1 do
			if r90_0.playerList[r6_62][1] == r1_62 then
				return 
			end
		end
		table.insert(r90_0.playerList, {
			r1_62,
			r2_62
		})
		refreshMatchJoinPlayerList()
	end
end)
addEvent("gotAirsoftMatchJoinPlayerRemoved", true)
addEventHandler("gotAirsoftMatchJoinPlayerRemoved", getRootElement(), function(r0_63, r1_63)
	-- line: [2431, 2441] id: 63
	if r90_0 and r90_0.id == r0_63 then
		for r5_63 = #r90_0.playerList, 1, -1 do
			if r90_0.playerList[r5_63][1] == r1_63 then
				table.remove(r90_0.playerList, r5_63)
			end
		end
		refreshMatchJoinPlayerList()
	end
end)
addEvent("gotAirsoftMatchJoinWindowClosed", true)
addEventHandler("gotAirsoftMatchJoinWindowClosed", getRootElement(), function(r0_64)
	-- line: [2445, 2450] id: 64
	if r90_0 and r90_0.id == r0_64 then
		sightexports.sGui:showInfobox("w", "A kiválasztott meccsre már nem lehet csatlakozni.")
		createMatchSelectorWindow()
	end
end)
addEvent("gotAirsoftMatchJoinWindow", true)
addEventHandler("gotAirsoftMatchJoinWindow", getRootElement(), function(r0_65, r1_65)
	-- line: [2454, 2469] id: 65
	if r88_0 or r85_0 then
		if r0_65 then
			createMatchJoinWindow(r0_65)
			r90_0.subscribed = true
			r90_0.playerList = r1_65
			refreshMatchJoinPlayerList()
		else
			createMatchSelectorWindow()
		end
	else
		triggerServerEvent("unsubscribeMatchJoinWindow", localPlayer)
	end
end)
function createMatchSelectorWindow()
	-- line: [2471, 2621] id: 66
	if r93_0 and exports.sGui:isGuiElementValid(r93_0) then
		sightexports.sGui:deleteGuiElement(r93_0)
	end
	r93_0 = nil
	if r85_0 and exports.sGui:isGuiElementValid(r85_0) then
		sightexports.sGui:deleteGuiElement(r85_0)
	end
	r85_0 = nil
	if r86_0 and exports.sGui:isGuiElementValid(r86_0) then
		sightexports.sGui:deleteGuiElement(r86_0)
	end
	r86_0 = nil
	deleteMatchJoinWindow()
	r72_0(false)
	r70_0(true)
	r87_0 = false
	local r0_66 = sightexports.sGui:getTitleBarHeight()
	local r1_66 = r0_66 + 8 + 444 + 32 + 8
	local r2_66 = 627
	r93_0 = sightexports.sGui:createGuiElement("window", r83_0 / 2 - r2_66 / 2, r84_0 / 2 - r1_66 / 2, r2_66, r1_66)
	sightexports.sGui:setWindowTitle(r93_0, "16/BebasNeueRegular.otf", "SightMTA - Airsoft")
	sightexports.sGui:setWindowCloseButton(r93_0, "closeAirsoftMatchSelector")
	local r3_66 = false
	local r4_66 = false
	local r5_66, r6_66, r7_66 = getElementPosition(localPlayer)
	for r11_66 in pairs(r96_0) do
		local r12_66, r13_66, r14_66 = getElementPosition(r11_66)
		local r15_66 = getDistanceBetweenPoints3D(r5_66, r6_66, r7_66, r12_66, r13_66, r14_66)
		if not r3_66 or r15_66 < r3_66 then
			r3_66 = r15_66
			r4_66 = r11_66
		end
	end
	sightexports.sGui:setWindowElementMaxDistance(r93_0, r4_66, 5, "closeAirsoftMatchSelector")
	local r8_66 = 436
	r95_0 = sightexports.sGui:createGuiElement("label", 8, r0_66 + 8, 600, r8_66, r93_0)
	sightexports.sGui:setLabelFont(r95_0, "12/Ubuntu-R.ttf")
	sightexports.sGui:setLabelAlignment(r95_0, "center", "center")
	sightexports.sGui:setLabelColor(r95_0, "sightlightgrey")
	sightexports.sGui:setLabelText(r95_0, "Nincs létrehozva egy meccs sem.\n\nHozz létre egyet!")
	sightexports.sGui:setGuiRenderDisabled(r95_0, true)
	local r9_66 = sightexports.sGui:createGuiElement("rectangle", 616, r0_66 + 8, 3, r8_66, r93_0)
	setGuiBackground(r9_66, "solid", "sightgrey1")
	r94_0 = sightexports.sGui:createGuiElement("scrollbar", 0, 0, 3, r8_66, r9_66)
	setGuiBackground(r94_0, "solid", "sightlightgrey")
	local r10_66 = sightexports.sGui:getTextWidthFont("Csatlakozás", "14/BebasNeueBold.otf") + 16
	local r11_66 = sightexports.sGui:getFontHeight("23/BebasNeueRegular.otf")
	local r12_66 = sightexports.sGui:getFontHeight("15/BebasNeueRegular.otf")
	for r16_66 = 1, 3, 1 do
		r100_0[r16_66] = {}
		local r17_66, r18_66, r19_66 = createMapBackground(8, r0_66 + 8 + 148 * (r16_66 - 1), r93_0)
		r100_0[r16_66][1] = r17_66
		r100_0[r16_66][2] = r18_66
		sightexports.sGui:disableLinkCursor(r17_66, true)
		sightexports.sGui:disableLinkCursor(r18_66, true)
		sightexports.sGui:disableLinkCursor(r19_66, true)
		local r20_66 = sightexports.sGui:createGuiElement("label", 8, 0, 0, 0, r17_66)
		sightexports.sGui:setLabelColor(r20_66, "sightyellow")
		sightexports.sGui:setLabelFont(r20_66, "23/BebasNeueRegular.otf")
		sightexports.sGui:setLabelAlignment(r20_66, "left", "top")
		r100_0[r16_66][3] = r20_66
		local r21_66 = sightexports.sGui:createGuiElement("label", 8, r11_66, 0, r12_66, r17_66)
		sightexports.sGui:setLabelFont(r21_66, "15/BebasNeueRegular.otf")
		sightexports.sGui:setLabelAlignment(r21_66, "left", "center")
		r100_0[r16_66][4] = r21_66
		local r22_66 = sightexports.sGui:createGuiElement("label", 8, r11_66 + r12_66, 0, r12_66, r17_66)
		sightexports.sGui:setLabelFont(r22_66, "12/BebasNeueRegular.otf")
		sightexports.sGui:setLabelColor(r22_66, "sightlightgrey")
		sightexports.sGui:setLabelAlignment(r22_66, "left", "center")
		r100_0[r16_66][5] = r22_66
		local r23_66 = sightexports.sGui:createGuiElement("rectangle", 0, r11_66 + 2, 0, r12_66 - 2, r17_66)
		r100_0[r16_66][6] = r23_66
		local r24_66 = sightexports.sGui:createGuiElement("label", 0, 0, 0, r12_66 - 2, r23_66)
		sightexports.sGui:setLabelFont(r24_66, "12/BebasNeueBold.otf")
		sightexports.sGui:setLabelAlignment(r24_66, "center", "center")
		r100_0[r16_66][7] = r24_66
		local r25_66 = sightexports.sGui:createGuiElement("label", 0, 0, 592, 0, r17_66)
		sightexports.sGui:setLabelFont(r25_66, "23/BebasNeueRegular.otf")
		sightexports.sGui:setLabelAlignment(r25_66, "right", "top")
		r100_0[r16_66][8] = r25_66
		local r26_66 = sightexports.sGui:createGuiElement("label", 8, 0, 0, 132, r17_66)
		sightexports.sGui:setLabelFont(r26_66, "15/BebasNeueRegular.otf")
		sightexports.sGui:setLabelAlignment(r26_66, "left", "bottom")
		r100_0[r16_66][9] = r26_66
		local r27_66 = sightexports.sGui:createGuiElement("button", 600 - r10_66 - 8, 100, r10_66, 32, r17_66)
		setGuiBackground(r27_66, "solid", "sightgreen")
		sightexports.sGui:setGuiHover(r27_66, "gradient", {
			"sightgreen",
			"sightgreen-second"
		}, false, true)
		sightexports.sGui:setButtonFont(r27_66, "14/BebasNeueBold.otf")
		sightexports.sGui:setButtonText(r27_66, "Csatlakozás")
		sightexports.sGui:setClickEvent(r27_66, "airsoftJoinMatch")
		sightexports.sGui:setClickArgument(r27_66, r16_66)
		sightexports.sGui:disableClickTrough(r27_66, false)
		sightexports.sGui:setGuiRenderDisabled(r17_66, true, true)
		r100_0[r16_66][10] = r27_66
	end
	r102_0 = true
	r101_0 = sightexports.sGui:createGuiElement("image", 284, r0_66 + 8 + r8_66 / 2 - 24, 48, 48, r93_0)
	sightexports.sGui:setImageFile(r101_0, sightexports.sGui:getFaIconFilename("circle-notch", 48))
	sightexports.sGui:setImageSpinner(r101_0, true)
	processAirsoftMatchList()
	local r13_66 = sightexports.sGui:createGuiElement("button", r2_66 / 2 - 128, r1_66 - 32 - 8, 256, 32, r93_0)
	if sightexports.sGui:isGuiElementValid(r13_66) then
		setGuiBackground(r13_66, "solid", "sightgreen")
		sightexports.sGui:setGuiHover(r13_66, "gradient", {
			"sightgreen",
			"sightgreen-second"
		}, false, true)
		sightexports.sGui:setButtonFont(r13_66, "14/BebasNeueBold.otf")
		sightexports.sGui:setButtonText(r13_66, " Meccs létrehozása")
		sightexports.sGui:setButtonIcon(r13_66, sightexports.sGui:getFaIconFilename("plus", 32))
		sightexports.sGui:setClickEvent(r13_66, "createAirsoftMathcmakingMapSelector")
	end
	r68_0(true)
end
addEvent("createMatchSelectorWindow", false)
addEventHandler("createMatchSelectorWindow", getRootElement(), createMatchSelectorWindow)
function processAirsoftMatchList()
	-- line: [2626, 2688] id: 67
	if r93_0 then
		if r102_0 then
			sightexports.sGui:setGuiRenderDisabled(r101_0, false)
			sightexports.sGui:setGuiRenderDisabled(r95_0, true)
			for r3_67 = 1, #r100_0, 1 do
				sightexports.sGui:setGuiRenderDisabled(r100_0[r3_67][1], true, true)
			end
		else
			local r0_67 = math.max(0, #r99_0 - #r100_0)
			r92_0 = math.min(r92_0, r0_67)
			local r1_67 = 436 / (r0_67 + 1)
			sightexports.sGui:setGuiSize(r94_0, false, r1_67)
			
			sightexports.sGui:setGuiPosition(r94_0, 0, r92_0 * r1_67)
			sightexports.sGui:setGuiRenderDisabled(r101_0, true)
			sightexports.sGui:setGuiRenderDisabled(r95_0, 0 < #r99_0)
			for r5_67 = 1, #r100_0, 1 do
				local r6_67 = r5_67 + r92_0
				sightexports.sGui:setGuiRenderDisabled(r100_0[r5_67][1], not r99_0[r6_67], true)
				if r99_0[r6_67] then
					sightexports.sGui:setLabelText(r100_0[r5_67][3], r99_0[r6_67].name)
					sightexports.sGui:setLabelText(r100_0[r5_67][8], r99_0[r6_67].playerNum .. "/" .. r99_0[r6_67].maxPlayers)
					local r7_67 = airsoftMaps[r99_0[r6_67].map]
					local r8_67 = r7_67.name
					sightexports.sGui:setLabelText(r100_0[r5_67][4], r8_67)
					local r9_67 = gameModes[r99_0[r6_67].gm].name
					local r10_67 = sightexports.sGui:getTextWidthFont(r8_67, "15/BebasNeueRegular.otf")
					local r11_67 = sightexports.sGui:getTextWidthFont(r9_67, "12/BebasNeueBold.otf") + 8
					setGuiBackground(r100_0[r5_67][6], "solid", gameModes[r99_0[r6_67].gm].color)
					
					sightexports.sGui:setGuiPosition(r100_0[r5_67][6], 8 + r10_67 + 8)
					sightexports.sGui:setGuiSize(r100_0[r5_67][6], r11_67)
					sightexports.sGui:setGuiSize(r100_0[r5_67][7], r11_67)
					sightexports.sGui:setLabelText(r100_0[r5_67][7], r9_67)
					sightexports.sGui:setImageDDS(r100_0[r5_67][2], r7_67.image, "dxt1")
					sightexports.sGui:setLabelText(r100_0[r5_67][5], "Szervező: " .. r99_0[r6_67].createdBy)
					if r99_0[r6_67].formattedText then
						sightexports.sGui:setLabelText(r100_0[r5_67][9], "Start: " .. r99_0[r6_67].formattedText)
					end
				end
			end
		end
	end
end
addEvent("deleteAirsoftMatch", true)
addEventHandler("deleteAirsoftMatch", getRootElement(), function(r0_68)
	-- line: [2692, 2702] id: 68
	if r99_0 then
		for r4_68 = #r99_0, 1, -1 do
			if r99_0[r4_68].id == r0_68 then
				table.remove(r99_0, r4_68)
			end
		end
		processAirsoftMatchList()
	end
end)
addEvent("refreshMatchPlayerNum", true)
addEventHandler("refreshMatchPlayerNum", getRootElement(), function(r0_69, r1_69)
	-- line: [2706, 2723] id: 69
	if r99_0 then
		for r5_69 = 1, #r99_0, 1 do
			if r99_0[r5_69].id == r0_69 then
				r99_0[r5_69].playerNum = r1_69
			end
		end
		for r5_69 = 1, #r100_0, 1 do
			local r6_69 = r5_69 + r92_0
			if r99_0[r6_69] and r99_0[r6_69].id == r0_69 then
				processAirsoftMatchList()
				return 
			end
		end
	end
end)
function sortMatches(r0_70, r1_70)
	-- line: [2725, 2727] id: 70
	return r0_70.starting < r1_70.starting
end
addEvent("gotNewAirsoftMatch", true)
addEventHandler("gotNewAirsoftMatch", getRootElement(), function(r0_71)
	-- line: [2731, 2737] id: 71
	if r99_0 then
		table.insert(r99_0, r0_71)
		table.sort(r99_0, sortMatches)
		processAirsoftMatchList()
	end
end)
addEvent("gotAirsoftMatchList", true)
addEventHandler("gotAirsoftMatchList", getRootElement(), function(r0_72)
	-- line: [2741, 2747] id: 72
	if r93_0 then
		table.sort(r0_72, sortMatches)
		r99_0 = r0_72
	end
end)
function preRenderMatchSelector()
	-- line: [2749, 2789] id: 73
	if r93_0 then
		local r0_73 = not r99_0
		if r0_73 ~= r102_0 then
			r102_0 = r0_73
			processAirsoftMatchList()
		end
		if not r102_0 then
			for r4_73 = 1, #r100_0, 1 do
				local r5_73 = r4_73 + r92_0
				if r99_0[r5_73] then
					local r6_73 = math.max(0, r99_0[r5_73].starting - getRealTime().timestamp)
					local r7_73 = math.floor(r6_73 / 60)
					local r8_73 = r6_73 % 60
					local r9_73 = nil	-- notice: implicit variable refs by block#[9, 10]
					if r6_73 <= 0 then
						sightexports.sGui:setLabelText(r100_0[r4_73][9], "Folyamatban")
						r99_0[r5_73].formattedText = false
					else
						r9_73 = string.format("%02d:%02d", r7_73, r8_73)
						if r99_0[r5_73].formattedText ~= r9_73 then
							r99_0[r5_73].formattedText = r9_73
							sightexports.sGui:setLabelText(r100_0[r4_73][9], "Start: " .. r99_0[r5_73].formattedText)
						end
					end
				end
			end
		end
	end
end
addEvent("airsoftJoinMatch", false)
addEventHandler("airsoftJoinMatch", getRootElement(), function(r0_74, r1_74, r2_74, r3_74, r4_74, r5_74)
	-- line: [2793, 2798] id: 74
	if not r148_0 and r99_0[r5_74 + r92_0] then
		createMatchJoinWindow()
		triggerServerEvent("getAirsoftJoinMatchWindow", localPlayer, r99_0[r5_74 + r92_0].id)
	end
end)
addEvent("airsoftJoinMatchClosePrompt", false)
addEventHandler("airsoftJoinMatchClosePrompt", getRootElement(), function()
	-- line: [2802, 2804] id: 75
	if r89_0 and exports.sGui:isGuiElementValid(r89_0) then
		sightexports.sGui:deleteGuiElement(r89_0)
	end
	r89_0 = nil
end)
addEvent("airsoftJoinMatchPinPrompt", false)
addEventHandler("airsoftJoinMatchPinPrompt", getRootElement(), function(r0_76, r1_76, r2_76, r3_76, r4_76, r5_76)
	-- line: [2808, 2843] id: 76
	local r6_76 = sightexports.sGui:getTitleBarHeight()
	local r7_76 = r6_76 + 8 + 30 + 8 + 30 + 8
	local r8_76 = 300
	if r89_0 and exports.sGui:isGuiElementValid(r89_0) then
		sightexports.sGui:deleteGuiElement(r89_0)
	end
	r89_0 = nil
	r89_0 = sightexports.sGui:createGuiElement("window", r83_0 / 2 - r8_76 / 2, r84_0 / 2 - r7_76 / 2, r8_76, r7_76)
	sightexports.sGui:setWindowTitle(r89_0, "16/BebasNeueRegular.otf", "Csatlakozás a meccsre")
	local r9_76 = sightexports.sGui:createGuiElement("input", 8, r6_76 + 8, r8_76 - 16, 30, r89_0)
	sightexports.sGui:setInputPlaceholder(r9_76, "PIN kód")
	sightexports.sGui:setInputIcon(r9_76, "key")
	sightexports.sGui:setInputMaxLength(r9_76, 6)
	sightexports.sGui:setInputNumberOnly(r9_76, true)
	sightexports.sGui:setInputPassword(r9_76, true)
	local r10_76 = (r8_76 - 24) / 2
	local r11_76 = sightexports.sGui:createGuiElement("button", 8, r7_76 - 30 - 8, r10_76, 30, r89_0)
	setGuiBackground(r11_76, "solid", "sightgreen")
	sightexports.sGui:setGuiHover(r11_76, "gradient", {
		"sightgreen",
		"sightgreen-second"
	}, false, true)
	sightexports.sGui:setButtonFont(r11_76, "15/BebasNeueBold.otf")
	sightexports.sGui:setButtonTextColor(r11_76, "#ffffff")
	sightexports.sGui:setButtonText(r11_76, "Csatlakozás")
	sightexports.sGui:setClickEvent(r11_76, "airsoftJoinMatchFinal", true)
	sightexports.sGui:setClickArgument(r11_76, r9_76)
	local r12_76 = sightexports.sGui:createGuiElement("button", r8_76 - 8 - r10_76, r7_76 - 30 - 8, r10_76, 30, r89_0)
	setGuiBackground(r12_76, "solid", "sightred")
	sightexports.sGui:setGuiHover(r12_76, "gradient", {
		"sightred",
		"sightred-second"
	}, false, true)
	sightexports.sGui:setButtonFont(r12_76, "15/BebasNeueBold.otf")
	sightexports.sGui:setButtonTextColor(r12_76, "#ffffff")
	sightexports.sGui:setButtonText(r12_76, "Mégsem")
	sightexports.sGui:setClickEvent(r12_76, "airsoftJoinMatchClosePrompt")
end)
addEvent("airsoftJoinMatchPrompt", false)
addEventHandler("airsoftJoinMatchPrompt", getRootElement(), function(r0_77, r1_77, r2_77, r3_77, r4_77, r5_77)
	-- line: [2847, 2884] id: 77
	local r6_77 = sightexports.sGui:getTitleBarHeight()
	local r7_77 = r6_77 + 125
	local r8_77 = 300
	if r89_0 and exports.sGui:isGuiElementValid(r89_0) then
		sightexports.sGui:deleteGuiElement(r89_0)
	end
	r89_0 = nil
	r89_0 = sightexports.sGui:createGuiElement("window", r83_0 / 2 - r8_77 / 2, r84_0 / 2 - r7_77 / 2, r8_77, r7_77)
	sightexports.sGui:setWindowTitle(r89_0, "16/BebasNeueRegular.otf", "Csatlakozás a meccsre")
	local r9_77 = sightexports.sGui:createGuiElement("label", 0, 8 + r6_77, r8_77, r7_77 - 8 - r6_77 - 30 - 16, r89_0)
	sightexports.sGui:setLabelAlignment(r9_77, "center", "center")
	sightexports.sGui:setLabelFont(r9_77, "11/Ubuntu-R.ttf")
	sightexports.sGui:setLabelText(r9_77, "Nevezési díj: [color=sightgreen]" .. sightexports.sGui:thousandsStepper(r5_77) .. " $#ffffff\t\n\nBiztosan csatlakozol?")
	local r10_77 = (r8_77 - 24) / 2
	local r11_77 = sightexports.sGui:createGuiElement("button", 8, r7_77 - 30 - 8, r10_77, 30, r89_0)
	setGuiBackground(r11_77, "solid", "sightgreen")
	sightexports.sGui:setGuiHover(r11_77, "gradient", {
		"sightgreen",
		"sightgreen-second"
	}, false, true)
	sightexports.sGui:setButtonFont(r11_77, "15/BebasNeueBold.otf")
	sightexports.sGui:setButtonTextColor(r11_77, "#ffffff")
	sightexports.sGui:setButtonText(r11_77, "Igen")
	if r90_0.private then
		sightexports.sGui:setClickEvent(r11_77, "airsoftJoinMatchPinPrompt")
	else
		sightexports.sGui:setClickEvent(r11_77, "airsoftJoinMatchFinal")
	end
	local r12_77 = sightexports.sGui:createGuiElement("button", r8_77 - 8 - r10_77, r7_77 - 30 - 8, r10_77, 30, r89_0)
	setGuiBackground(r12_77, "solid", "sightred")
	sightexports.sGui:setGuiHover(r12_77, "gradient", {
		"sightred",
		"sightred-second"
	}, false, true)
	sightexports.sGui:setButtonFont(r12_77, "15/BebasNeueBold.otf")
	sightexports.sGui:setButtonTextColor(r12_77, "#ffffff")
	sightexports.sGui:setButtonText(r12_77, "Nem")
	sightexports.sGui:setClickEvent(r12_77, "airsoftJoinMatchClosePrompt")
end)
addEvent("airsoftMatchPinResponse", true)
addEventHandler("airsoftMatchPinResponse", getRootElement(), function(r0_78, r1_78)
	if r0_78 == r90_0.id and not r148_0 then
		r148_0 = getTickCount()
		r153_0 = false
		r66_0(true, "low-99999999999")
		r150_0 = r90_0.id
		r151_0 = r1_78
		r152_0 = r90_0.map
		sightexports.sControls:toggleAllControls(false, "airsoftJoinMatch")
	end
end)
addEvent("airsoftJoinMatchFinal", false)
addEventHandler("airsoftJoinMatchFinal", getRootElement(), function(r0_79, r1_79, r2_79, r3_79, r4_79, r5_79)
	-- line: [2907, 2939] id: 79
	if r5_79 then
		r5_79 = sightexports.sGui:getInputValue(r5_79)
	end
	if r89_0 and exports.sGui:isGuiElementValid(r89_0) then
		sightexports.sGui:deleteGuiElement(r89_0)
	end
	r89_0 = nil
	if r90_0.private then
		r5_79 = tonumber(r5_79)
		if not r5_79 or r5_79 < 100000 or 999999 < r5_79 then
			sightexports.sGui:showInfobox("e", "Hibás PIN kód.")
			return 
		end
		triggerServerEvent("tryAirsoftMatchPin", localPlayer, r90_0.id, r5_79)
		return 
	end
	if not r148_0 then
		r148_0 = getTickCount()
		r153_0 = false
		r66_0(true, "low-99999999999")
		r150_0 = r90_0.id
		r151_0 = false
		r152_0 = r90_0.map
		sightexports.sControls:toggleAllControls(false, "airsoftJoinMatch")
	end
end)
addEventHandler("onClientClick", getRootElement(), function(r0_80, r1_80, r2_80, r3_80, r4_80, r5_80, r6_80, r7_80)
	-- line: [2943, 2955] id: 80
	if r96_0[r7_80] and r1_80 == "down" and not r93_0 and not r85_0 and not r86_0 and not r88_0 and not r148_0 and not r147_0 then
		local r8_80, r9_80, r10_80 = getElementPosition(localPlayer)
		local r11_80, r12_80, r13_80 = getElementPosition(r7_80)
		if getDistanceBetweenPoints3D(r8_80, r9_80, r10_80, r11_80, r12_80, r13_80) < 3 then
			r99_0 = false
			triggerServerEvent("requestAirsoftMatchList", localPlayer)
			createMatchSelectorWindow()
		end
	end
end, true, "high+999999")

screenX, screenY = guiGetScreenSize()

function matchLoadingScreen()
	setInteriorSoundsEnabled(false)
	if r148_0 then
		currentTick = getTickCount()
		loaderAlpha = math.min(1, (getTickCount() - r148_0) / 500)
		scaleFactor = 1.5 - loaderAlpha * 0.5
		scaledHeight = (screenY + 2) * scaleFactor
		scaledWidth = math.ceil(scaledHeight * 1.7777777777777777)
	end
	
	if r148_0 and 1 < (getTickCount() - r148_0) / 500 then
		r148_0 = false
		triggerServerEvent("airsoftJoinMatch", localPlayer, r150_0, r152_0)
		_UPVALUE2_ = false
		r152_0 = false
	end
	if r147_0 and r147_0.mapLoaded then
		if r148_0 then
			r147_0.mapLoaded = getTickCount()
		end
		if getTickCount() - r147_0.mapLoaded - 1000 > 0 and 1 - (getTickCount() - r147_0.mapLoaded - 1000) / 500 < 0 then
			triggerServerEvent("airsoftMatchLoaded", localPlayer, r147_0.id)
			r66_0(false)
			currentTick = false
			sightexports.sControls:toggleAllControls(true, "airsoftJoinMatch")
			return
		end
	elseif _UPVALUE7_ and 1 - (getTickCount() - _UPVALUE7_) / 500 < 0 then
		r66_0(false)
		currentTick = false
		sightexports.sControls:toggleAllControls(true, "airsoftJoinMatch")
		_UPVALUE7_ = false
		return
	end
	local multipler = 1
	if currentTick and r152_0 then
		if scaledWidth < screenX then
			dxDrawRectangle(0, 0, screenX / 2 - scaledWidth / 2, screenY, tocolor(0, 0, 0, 255 * loaderAlpha))
			dxDrawRectangle(screenX / 2 + scaledWidth / 2, 0, screenX / 2 - scaledWidth / 2, screenY, tocolor(0, 0, 0, 255 * loaderAlpha))
		end
		
		dxDrawImage(screenX / 2 - scaledWidth / 2, screenY / 2 - scaledHeight / 2, scaledWidth, scaledHeight, r19_0(airsoftMaps[_UPVALUE11_ or r152_0].bigImage, "dxt1"), 0, 0, 0, tocolor(255, 255, 255, 255 * loaderAlpha))
		
		local iconSize = 90 * scaleFactor
		dxDrawImage(screenX / 2 - iconSize / 2, screenY / 2 - iconSize / 2, iconSize, iconSize, "files/sp2.dds", 0, 0, 0, tocolor(r42_0[1] * 0.1, r42_0[2] * 0.1, r42_0[3] * 0.1, 200 * loaderAlpha))
		dxDrawImage(screenX / 2 - iconSize / 2, screenY / 2 - iconSize / 2, iconSize, iconSize, "files/sp1.dds", -currentTick / 4.75 % 360, 0, 0, tocolor(r42_0[1], r42_0[2], r42_0[3], 255 * loaderAlpha))
		dxDrawText("Meccs betöltése", 0, screenY / 2 + 50 + 12, screenX, screenY / 2 + 50 + 12 + 32, tocolor(255, 255, 255, 255 * loaderAlpha), r33_0 * scaleFactor, r32_0, "center", "center")
	end
end
addEvent("airsoftMatchLeft", true)
addEventHandler("airsoftMatchLeft", getRootElement(), function()
	sightexports.sHud:setStaminaMul(1)
	deleteAirsoftGui()
	deleteAirsoftLoadoutGui()
	deleteAirsoftTeamWindow()
	setInteriorSoundsEnabled(true)
	r147_0 = false
	r66_0(false)
	r149_0 = false
	sightexports.sControls:toggleAllControls(true, "airsoftJoinMatch")
	sightexports.sMaps:processMapData("currentAirsoftGame")
	if isElement(r111_0) then
		destroyElement(r111_0)
	end
	r111_0 = nil
	if isElement(r122_0) then
		destroyElement(r122_0)
	end
	r122_0 = nil
	if isElement(r121_0) then
		destroyElement(r121_0)
	end
	r121_0 = nil
	if isElement(r123_0) then
		destroyElement(r123_0)
	end
	r123_0 = nil
	if isElement(r124_0) then
		destroyElement(r124_0)
	end
	r124_0 = nil
	if isElement(r125_0) then
		destroyElement(r125_0)
	end
	r125_0 = nil
	if isElement(r126_0) then
		destroyElement(r126_0)
	end
	r126_0 = nil
	if isElement(r127_0) then
		destroyElement(r127_0)
	end
	r127_0 = nil
	if isElement(r128_0) then
		destroyElement(r128_0)
	end
	r128_0 = nil
	if isElement(r115_0) then
		destroyElement(r115_0)
	end
	r115_0 = nil
	if isElement(r116_0) then
		destroyElement(r116_0)
	end
	r116_0 = nil
	for r3_82 = 1, #r117_0, 1 do
		if isElement(r117_0[r3_82]) then
			destroyElement(r117_0[r3_82])
		end
		r117_0[r3_82] = nil
	end
	for r3_82 = 1, #r118_0, 1 do
		if isElement(r118_0[r3_82]) then
			destroyElement(r118_0[r3_82])
		end
		r118_0[r3_82] = nil
	end
	for r3_82 = 1, #r119_0, 1 do
		if isElement(r119_0[r3_82]) then
			destroyElement(r119_0[r3_82])
		end
		r119_0[r3_82] = nil
	end
	for r3_82 = 1, #r120_0, 1 do
		if isElement(r120_0[r3_82]) then
			destroyElement(r120_0[r3_82])
		end
		r120_0[r3_82] = nil
	end
	r64_0(false)
	r66_0(false)
	r149_0 = false
	refreshPlayerColors()
end)
function pushAirsoftChatLine(r0_83)
	-- line: [3098, 3147] id: 83
	local r1_83 = r143_0
	if r1_83 then
		r1_83 = r143_0.chatScroll or 0
	else
		r1_83 = 0
	end
	if utf8.find(r0_83, "%[color%=[a-zA-Z1-9%-]*%]") then
		r0_83 = utf8.gsub(r0_83, "%[color%=([a-zA-Z1-9%-]*)%]", function(r0_84)
			-- line: [3103, 3105] id: 84
			return sightexports.sGui:getColorCodeHex(r0_84) or ""
		end)
	end
	r0_83 = split(r0_83, " ")
	local r2_83 = r0_83[1]
	local r3_83 = r83_0 / 5 - 12 - 8 - 3
	for r7_83 = 2, #r0_83, 1 do
		if r3_83 <= sightexports.sGui:getTextWidthFont(r2_83 .. " " .. r0_83[r7_83], "11/Ubuntu-R.ttf") then
			if r1_83 > 0 then
				r1_83 = r1_83 + 1
			end
			table.insert(r147_0.chatLines, 1, r2_83)
			local r9_83 = ""
			for r13_83 in utf8.gmatch(r2_83, "%#%x%x%x%x%x%x") do
				r9_83 = r13_83
			end
			r2_83 = r9_83 .. r0_83[r7_83]
		else
			r2_83 = r2_83 .. " " .. r0_83[r7_83]
		end
	end
	if utf8.len(r2_83) > 0 then
		if r1_83 > 0 then
			r1_83 = r1_83 + 1
		end
		table.insert(r147_0.chatLines, 1, r2_83)
	end
	if r1_83 > 0 then
		r143_0.chatScroll = r1_83
	end
end
function processAirsoftChatLines()
	-- line: [3149, 3164] id: 85
	for r3_85 = 1, 10, 1 do
		local r4_85 = r3_85 + r143_0.chatScroll
		if r147_0.chatLines[r4_85] then
			sightexports.sGui:setGuiRenderDisabled(r143_0.chatLabels[r3_85], false)
			sightexports.sGui:setLabelText(r143_0.chatLabels[r3_85], r147_0.chatLines[r4_85])
		else
			sightexports.sGui:setGuiRenderDisabled(r143_0.chatLabels[r3_85], true)
		end
	end
	local r0_85 = r143_0.chatH / math.max(1, (#r147_0.chatLines - 10 + 1))
	sightexports.sGui:setGuiSize(r143_0.chatScrollBar, false, r0_85)
	
	if sightexports.sGui:isGuiElementValid(r143_0.chatScrollBar) then
		sightexports.sGui:setGuiPosition(r143_0.chatScrollBar, 0, r143_0.chatH - r0_85 * (1 + r143_0.chatScroll))
	end
end
addEvent("gotAirsoftChatLine", true)
addEventHandler("gotAirsoftChatLine", getRootElement(), function(r0_86, r1_86)
	-- line: [3168, 3176] id: 86
	if r147_0 and r147_0.id == r0_86 then
		pushAirsoftChatLine(r1_86)
		if r142_0 then
			processAirsoftChatLines()
		end
	end
end)

addEvent("gotAirsoftMatchData", true)
addEventHandler("gotAirsoftMatchData", getRootElement(), function(r0_87, r1_87, r2_87, r3_87, r4_87, r5_87, r6_87, r7_87, r8_87, r9_87, r10_87, r11_87, r12_87)
	if r147_0 and r147_0.id == r0_87 then
		sightexports.sHud:setStaminaMul(r3_87)
		r147_0.gm = r2_87
		r147_0.playerDatas = r8_87
		r147_0.team = r9_87
		r147_0.length = r12_87
		r147_0.canChangeTeam = r10_87
		r147_0.gameStartTime = r4_87


		r147_0.chatLines = {}
		for r15_87 = 1, #r7_87, 1 do
			pushAirsoftChatLine(r7_87[r15_87])
		end
		setInteriorSoundsEnabled(false)
		sightexports.sMaps:processMapData("currentAirsoftGame", r1_87, r0_87)
		if isElement(r115_0) then
			destroyElement(r115_0)
		end
		r115_0 = nil
		if isElement(r116_0) then
			destroyElement(r116_0)
		end
		r116_0 = nil
		for r15_87 = 1, #r117_0, 1 do
			if isElement(r117_0[r15_87]) then
				destroyElement(r117_0[r15_87])
			end
			r117_0[r15_87] = nil
		end
		for r15_87 = 1, #r118_0, 1 do
			if isElement(r118_0[r15_87]) then
				destroyElement(r118_0[r15_87])
			end
			r118_0[r15_87] = nil
		end
		for r15_87 = 1, #r119_0, 1 do
			if isElement(r119_0[r15_87]) then
				destroyElement(r119_0[r15_87])
			end
			r119_0[r15_87] = nil
		end
		for r15_87 = 1, #r120_0, 1 do
			if isElement(r120_0[r15_87]) then
				destroyElement(r120_0[r15_87])
			end
			r120_0[r15_87] = nil
		end
		if r11_87 then
			r147_0.flags = r11_87
			r147_0.flagging = {}
			r147_0.flagVol = {}
			r147_0.flagTeam = {}
			r147_0.flagProgress = {}
			r116_0 = dxCreateRenderTarget(r83_0, r84_0)
			if isElement(r116_0) then
				r115_0 = r2_0(r80_0)
				dxSetShaderValue(r115_0, "sRes", r83_0, r84_0)
				dxSetShaderValue(r115_0, "sTex0", r116_0)
				dxSetShaderValue(r115_0, "scol1", r44_0[1] / 255, r44_0[2] / 255, r44_0[3] / 255, 0.75)
				dxSetShaderValue(r115_0, "scol2", r43_0[1] / 255, r43_0[2] / 255, r43_0[3] / 255, 0.75)
				dxSetShaderValue(r115_0, "scol0", r45_0[1] / 255, r45_0[2] / 255, r45_0[3] / 255, 0.75)
			end
			for r15_87 = 1, #r11_87, 1 do
				r147_0.flagTeam[r15_87] = 0
				r147_0.flagProgress[r15_87] = 0
				r147_0.flagVol[r15_87] = 0
				r119_0[r15_87] = createObject(r114_0, r11_87[r15_87][1], r11_87[r15_87][2], r11_87[r15_87][3])
				setElementCollisionsEnabled(r119_0[r15_87], false)
				setElementInterior(r119_0[r15_87], airsoftMaps[r147_0.mapId].interior)
				setElementDimension(r119_0[r15_87], r0_87)
				r120_0[r15_87] = playSound3D("files/flag.mp3", r11_87[r15_87][1], r11_87[r15_87][2], r11_87[r15_87][3], true)
				setElementInterior(r120_0[r15_87], airsoftMaps[r147_0.mapId].interior)
				setElementDimension(r120_0[r15_87], r0_87)
				r117_0[r15_87] = r2_0(r82_0, 0, 0, false, "object")
				dxSetShaderValue(r117_0[r15_87], "scol0", r45_0[1] / 255, r45_0[2] / 255, r45_0[3] / 255, 0.75)
				r118_0[r15_87] = r2_0(r81_0, 0, 0, true, "object")
				dxSetShaderValue(r118_0[r15_87], "secondRT", r116_0)
				engineApplyShaderToWorldTexture(r117_0[r15_87], "*", r119_0[r15_87])
				engineApplyShaderToWorldTexture(r118_0[r15_87], "*", r119_0[r15_87])
			end
		end
		if isElement(r111_0) then
			destroyElement(r111_0)
		end
		r111_0 = nil
		r111_0 = r2_0(r112_0, 0, 0, false, "all")
		engineApplyShaderToWorldTexture(r111_0, "gunshell")
		engineApplyShaderToWorldTexture(r111_0, "*smoke*")
		engineApplyShaderToWorldTexture(r111_0, "*sphere*")
		engineApplyShaderToWorldTexture(r111_0, "*blood*")
		if isElement(r121_0) then
			destroyElement(r121_0)
		end
		r121_0 = nil
		r121_0 = dxCreateScreenSource(r83_0, r84_0)
		if isElement(r122_0) then
			destroyElement(r122_0)
		end
		r122_0 = nil
		r122_0 = r2_0(r113_0)
		dxSetShaderValue(r122_0, "screenTexture", r121_0)
		r64_0(true, "low-99999999")
		if isElement(r123_0) then
			destroyElement(r123_0)
		end
		r123_0 = nil
		if isElement(r124_0) then
			destroyElement(r124_0)
		end
		r124_0 = nil
		if isElement(r125_0) then
			destroyElement(r125_0)
		end
		r125_0 = nil
		if isElement(r126_0) then
			destroyElement(r126_0)
		end
		r126_0 = nil
		if isElement(r127_0) then
			destroyElement(r127_0)
		end
		r127_0 = nil
		if r5_87 then
			if r9_87 then
				r123_0 = r2_0(r79_0, 0, 0, true, "ped")
				if r6_87 then
					r127_0 = dxCreateRenderTarget(r83_0, r84_0)
					if isElement(r127_0) then
						r124_0 = r2_0(r77_0, 0, 0, true, "ped")
						dxSetShaderValue(r124_0, "secondRT", r127_0)
						r126_0 = r2_0(r78_0)
						dxSetShaderValue(r126_0, "sRes", r83_0, r84_0)
						dxSetShaderValue(r126_0, "sTex0", r127_0)
					end
				end
				if isElement(r128_0) then
					destroyElement(r128_0)
				end
				r128_0 = nil
				r128_0 = r2_0(r79_0, 0, 0, true, "ped")
			else
				r127_0 = dxCreateRenderTarget(r83_0, r84_0)
				if isElement(r127_0) then
					r125_0 = r2_0(r77_0, 0, 0, true, "ped")
					dxSetShaderValue(r125_0, "secondRT", r127_0)
					r126_0 = r2_0(r78_0)
					dxSetShaderValue(r126_0, "sRes", r83_0, r84_0)
					dxSetShaderValue(r126_0, "sTex0", r127_0)
				end
			end
		end
		refreshTeamShaderColors()
		refreshPlayerColors()
		createAirsoftGui()
		if r10_87 then
			if source == localPlayer then
				createAirsoftTeamWindow(true)
			end
		else
			if r143_0.teamIcon then
				sightexports.sGui:setGuiHoverable(r143_0.teamIcon, false)
			end
			if source == localPlayer then
				createAirsoftLoadoutGui()
			end
		end
		r147_0.mapLoaded = getTickCount()
	end
end)
addEvent("airsoftMatchJoinFail", true)
addEventHandler("airsoftMatchJoinFail", getRootElement(), function(r0_88)
	-- line: [3343, 3351] id: 88
	setInteriorSoundsEnabled(true)
	r148_0 = false
	r153_0 = getTickCount()
	r66_0(true, "low-99999999999")
	sightexports.sControls:toggleAllControls(false, "airsoftJoinMatch")
end)
addEvent("airsoftMatchJoined", true)
addEventHandler("airsoftMatchJoined", getRootElement(), function(r0_89, r1_89, r2_89, r3_89, r4_89)
	r139_0 = {}
	r140_0 = {}
	r141_0 = {}
	deleteAirsoftResultWindow()
	setInteriorSoundsEnabled(false)
	r148_0 = false
	r153_0 = false
	closeAirsoftMatchSelector()
	r147_0 = {
		id = r0_89,
		mapId = r1_89,
		spawned = true,
		starting = r2_89,
		health = 100,
		canChangeLoadout = true,
		playerDatas = {},
		gm = r3_89,
	}
	r66_0(true, "low-99999999999")
	sightexports.sControls:toggleAllControls(false, "airsoftJoinMatch")
end)
function airsoftKey(r0_90, r1_90)
	-- line: [3379, 3422] id: 90
	if r0_90 == "mouse1" and r1_90 and (not r147_0.spawned or tonumber(r147_0.spawned)) then
		triggerServerEvent("airsoftNextSpectator", localPlayer, true)
	elseif r0_90 == "mouse2" and r1_90 and (not r147_0.spawned or tonumber(r147_0.spawned)) then
		triggerServerEvent("airsoftNextSpectator", localPlayer)
	elseif r0_90 == "mouse_wheel_up" or r0_90 == "mouse_wheel_down" then
		local r2_90, r3_90 = getCursorPosition()
		if r2_90 then
			r2_90 = r2_90 * r83_0
			r3_90 = r3_90 * r84_0
			local r4_90, r5_90 = sightexports.sGui:getGuiRealPosition(r143_0.chat)
			local r6_90, r7_90 = sightexports.sGui:getGuiSize(r143_0.chat)
			if r4_90 <= r2_90 and r5_90 <= r3_90 and r2_90 <= r4_90 + r6_90 then
				local r8_90 = r5_90 + r7_90
				if r3_90 <= r8_90 then
					if r0_90 == "mouse_wheel_up" then
						r8_90 = 1 or -1
					else
						r8_90 = -1
					end
					local r9_90 = math.max(0, math.min(r143_0.chatScroll + r8_90, #r147_0.chatLines - 10))
					if r143_0.chatScroll ~= r9_90 then
						r143_0.chatScroll = r9_90
						processAirsoftChatLines()
					end
				end
			end
		end
	end
end
function renderAirsoftGui(r0_91)
	local r1_91 = getTickCount()
	for r5_91 = 1, #r133_0, 1 do
		local r9_91, r10_91 = getScreenFromWorldPosition(r133_0[r5_91][1], r133_0[r5_91][2], r133_0[r5_91][3], r36_0)
		if r9_91 then
			local r11_91 = math.min(1, r133_0[r5_91][5] / 1000)
			if r11_91 > 0 then
				local r12_91 = 0.75 + 0.5 * r133_0[r5_91][9]
				dxDrawText(r133_0[r5_91][4], r9_91 + 1, r10_91 + 1, r9_91 + 1, r10_91 + 1, tocolor(0, 0, 0, 175 * r11_91), r35_0 * r12_91, r34_0, "center", "center")
				dxDrawText(r133_0[r5_91][4], r9_91, r10_91, r9_91, r10_91, tocolor(r133_0[r5_91][6], r133_0[r5_91][7], r133_0[r5_91][8], 255 * r11_91), r35_0 * r12_91, r34_0, "center", "center")
			end
		end
	end
	local r2_91 = false
	if r103_0 == 2 then
		r2_91 = "double"
	elseif r103_0 == 3 then
		r2_91 = "multi"
	elseif r103_0 == 4 then
		r2_91 = "ultra"
	elseif r103_0 == 5 then
		r2_91 = "fan"
	elseif r103_0 >= 6 then
		r2_91 = "unb"
	elseif r104_0 then
		r2_91 = "head"
	end
	if r2_91 then
		local r3_91 = (r1_91 - r130_0) / 4000
		local r4_91 = 0.2
		if r3_91 < 1 + r4_91 then
			local r5_91 = 0.75 + 0.25 * r3_91
			local r6_91 = 255
			if r3_91 > 1 then
				r6_91 = 255 * (1 - (r3_91 - 1) / r4_91)
			end
			dxDrawImage(r83_0 / 2 - 764 * r5_91 / 2, r84_0 * 0.15 - 218 * r5_91 / 2, 764 * r5_91, 218 * r5_91, r19_0("files/special/" .. r2_91 .. "2.dds"), 0, 0, 0, tocolor(255, 255, 255, r6_91))
			dxDrawImage(r83_0 / 2 - 382, r84_0 * 0.15 - 109, 764, 218, r19_0("files/special/" .. r2_91 .. "1.dds"), 0, 0, 0, tocolor(255, 255, 255, r6_91))
		end
	end
	if r131_0 then
		local r3_91 = math.min(1, (r1_91 - r131_0) / 540)
		local r4_91 = 1 - math.max(0, (r1_91 - r131_0 - 540) / 3200)
		if r4_91 > 0 then
			local r5_91 = r147_0.flagTeam[r132_0]
			if r5_91 == 1 then
				r5_91 = r44_0 or r43_0
			else
				r5_91 = r43_0
			end
			local r6_91 = 255 * r4_91
			local r7_91 = 300 * r3_91 * r4_91
			if r3_91 < 1 then
				r8_0[0] = true
				if r7_0[0] then
					r10_0[0]()
				end
				dxDrawImage(r83_0 / 2 - r7_91 / 2, r84_0 * 0.2 - r7_91 / 2, r7_91, r7_91, r6_0[0], 0, 0, 0, tocolor(r45_0[1], r45_0[2], r45_0[3], r6_91))
			end
			r8_0[0] = true
			if r7_0[0] then
				r10_0[0]()
			end
			dxDrawImageSection(r83_0 / 2 - r7_91 / 2, r84_0 * 0.2 + r7_91 / 2 - r7_91 * r3_91, r7_91, r7_91 * r3_91, 0, 384 * (1 - r3_91), 384, 384 * r3_91, r6_0[0], 0, 0, 0, tocolor(r5_91[1], r5_91[2], r5_91[3], r6_91))
		else
			r131_0 = false
		end
	end
end
function preRenderAirsoftGui(r0_92)
	-- line: [3503, 3815] id: 92
	for r4_92 = #r133_0, 1, -1 do
		r133_0[r4_92][3] = r133_0[r4_92][3] + 0.45 * r0_92 / 1000
		r133_0[r4_92][9] = math.min(1, r133_0[r4_92][9] + r0_92 / 200)
		r133_0[r4_92][5] = r133_0[r4_92][5] - r0_92
		if r133_0[r4_92][5] < 0 then
			table.remove(r133_0, r4_92)
		end
	end
	local r1_92 = false
	if isElement(r127_0) then
		dxSetRenderTarget(r127_0, true)
		r1_92 = true
	end
	if isElement(r116_0) then
		dxSetRenderTarget(r116_0, true)
		r1_92 = true
	end
	if r1_92 then
		dxSetRenderTarget()
	end
	setInteriorSoundsEnabled(false)
	local r2_92 = getTickCount()
	local r12_92 = nil
	if r147_0.flags then
		local r3_92, r4_92, r5_92 = getElementPosition(localPlayer)
		local r6_92 = nil
		local r7_92 = 1.5
		for r11_92 = 1, #r147_0.flags, 1 do
			r12_92 = r147_0.flagging[r11_92]
			if r12_92 then
				r147_0.flagProgress[r11_92] = math.max(0, math.min(1, r147_0.flagProgress[r11_92] + r0_92 / 5050 * r147_0.flagging[r11_92]))
				r12_92 = r147_0.flagVol
				r12_92[r11_92] = math.min(1, r147_0.flagVol[r11_92] + r0_92 / 1000)
			else
				r12_92 = r147_0.flagVol[r11_92]
				if r12_92 > 0 then
					r12_92 = r147_0.flagVol
					r12_92[r11_92] = math.max(0, r147_0.flagVol[r11_92] - r0_92 / 500)
				end
			end
			r12_92 = r147_0.flagProgress[r11_92]
			local r13_92 = r147_0.flagVol[r11_92]
			setSoundVolume(r120_0[r11_92], (0.75 + r12_92 * 0.5) * (0.5 + r13_92 * 1.5))
			setSoundMinDistance(r120_0[r11_92], 1)
			setSoundMaxDistance(r120_0[r11_92], (5 + r12_92 * 5) * (1 + r13_92 * 0.5))
			setSoundSpeed(r120_0[r11_92], 1 + r12_92 * 2)
			dxSetShaderValue(r117_0[r11_92], "prog", r12_92)
			dxSetShaderValue(r118_0[r11_92], "prog", r12_92)
			local r14_92 = r2_92 + r11_92 * 1250
			local r15_92 = math.cos(r14_92 / 1000)
			local r16_92, r17_92, r18_92 = unpack(r147_0.flags[r11_92])
			setElementPosition(r120_0[r11_92], r16_92, r17_92, r18_92 + 0.25 * r15_92)
			setElementPosition(r119_0[r11_92], r16_92, r17_92, r18_92 + 0.25 * r15_92)
			setElementRotation(r119_0[r11_92], 0, 0, r14_92 / 25)
			if (r12_92 < 1 or r147_0.flagTeam[r11_92] ~= r147_0.team) and r147_0.started and r147_0.spawned and not tonumber(r147_0.spawned) and not r147_0.ended then
				local r19_92 = getDistanceBetweenPoints3D(r3_92, r4_92, r5_92, r16_92, r17_92, r18_92)
				if r19_92 < r7_92 then
					r6_92 = r11_92
					r7_92 = r19_92
				end
			end
			if r12_92 > 0 then
				local r19_92 = 1 + 1.25 * r12_92 + r15_92 * 0.5
				local r20_92 = r147_0.flagTeam[r11_92]
				if r20_92 == 1 then
					r20_92 = r44_0 or r43_0
				else
					r20_92 = r43_0
				end
				local r21_92, r22_92, r23_92, r24_92 = processLineOfSight(r16_92, r17_92, r18_92, r16_92, r17_92, r18_92 - 2, true, false, false, true, true, false, false, false, r119_0[r11_92])
				r8_0[1] = true
				if r7_0[1] then
					r10_0[1]()
				end
				local r25_92 = dxDrawMaterialLine3D
				local r26_92 = r16_92
				local r27_92 = r17_92 - r19_92
				r25_92(r26_92, r27_92, (r24_92 or r18_92 - 1) + 0.025, r16_92, r17_92 + r19_92, (r24_92 or r18_92 - 1) + 0.025, r6_0[1], r19_92 * 2, tocolor(r20_92[1], r20_92[2], r20_92[3], 255 * math.min(1, r12_92 * 3)), r16_92, r17_92, r18_92 + 1)
			end
		end
		if r6_92 ~= r147_0.nearestFlag then
			r147_0.nearestFlag = r6_92
			sightexports.sGui:setGuiRenderDisabled(r143_0.flagLabel, not r6_92)
			if r147_0.selfFlagging then
				triggerServerEvent("airsoftFlaggingState", localPlayer)
			end
		end
		if r6_92 then
			local r8_92 = getKeyState("e")
			if r8_92 ~= r147_0.selfFlagging then
				r147_0.selfFlagging = r8_92
				local r9_92 = triggerServerEvent
				local r10_92 = "airsoftFlaggingState"
				local r11_92 = localPlayer
				if r8_92 then
					r12_92 = r6_92
				else
					r12_92 = false
				end
				r9_92(r10_92, r11_92, r12_92)
			end
		end
	end
	if r2_92 - r130_0 < 150 then
		r129_0 = math.min(1, r129_0 + r0_92 / 150)
	else
		r129_0 = math.max(0, r129_0 - r0_92 / 350)
	end
	local r3_92 = getRealTime().timestamp
	local r4_92 = false
	local r5_92 = false
	local r6_92 = "#ffffff"
	if r147_0.ended then
		r147_0.ended = math.max(0, r147_0.ended - r0_92 / 1000)
		r5_92 = string.format("%02d:%02d", math.floor(r147_0.ended / 60), r147_0.ended % 60)
		r4_92 = "Játék vége: [color=sightyellow]" .. r5_92
		r6_92 = "sightyellow"
		if r143_0.aliveCount then
			r143_0.aliveCount = false
			sightexports.sGui:setImageColor(r143_0.aliveIcon, "sightyellow")
			sightexports.sGui:setLabelColor(r143_0.aliveLabel, "sightyellow")
			sightexports.sGui:setLabelText(r143_0.aliveLabel, "1")
		end
		if r143_0.waitCount then
			sightexports.sGui:setGuiRenderDisabled(r143_0.waitLabel, true)
		end
	else
		if r147_0.gm == "lms" then
			local r7_92 = 0
			for r11_92 = 1, #r147_0.playerDatas, 1 do
				r12_92 = r147_0.playerDatas[r11_92].spawned
				if r12_92 then
					r7_92 = r7_92 + 1
				end
			end
			if r143_0.aliveCount ~= r7_92 then
				r143_0.aliveCount = r7_92
				if r143_0.started then
					r143_0.aliveRed = 0
				else
					sightexports.sGui:setImageColor(r143_0.aliveIcon, "#ffffff")
					sightexports.sGui:setLabelColor(r143_0.aliveLabel, "#ffffff")
				end
				sightexports.sGui:setLabelText(r143_0.aliveLabel, r7_92)
			end
			if r143_0.aliveRed then
				r143_0.aliveRed = r143_0.aliveRed + r0_92
				local r8_92 = math.max(0, math.min(1, r143_0.aliveRed / 1000))
				if r8_92 > 1 then
					r147_0.aliveRed = false
					sightexports.sGui:setImageColor(r143_0.aliveIcon, "#ffffff")
					sightexports.sGui:setLabelColor(r143_0.aliveLabel, "#ffffff")
				else
					local r9_92 = {
						r43_0[1] + (255 - r43_0[1]) * r8_92,
						r43_0[2] + (255 - r43_0[2]) * r8_92,
						r43_0[3] + (255 - r43_0[3]) * r8_92
					}
					sightexports.sGui:setImageColor(r143_0.aliveIcon, r9_92)
					sightexports.sGui:setLabelColor(r143_0.aliveLabel, r9_92)
				end
			end
		end
		if r147_0.started then
			if not r147_0.spawned then
				r4_92 = "[color=sightlightgrey]Kiestél a játékból"
			elseif tonumber(r147_0.spawned) then
				r147_0.spawned = math.max(0, r147_0.spawned - r0_92 / 1000)
				r4_92 = "Újraéledés: [color=sightblue]" .. math.ceil(r147_0.spawned)
			end
			if r147_0.ending then
				local r7_92 = math.max(0, r147_0.ending - r3_92)
				if r7_92 <= 20 and not isElement(r144_0) then
					r144_0 = playSound("files/10sec.mp3", true)
				end
				r5_92 = string.format("%02d:%02d", math.floor(r7_92 / 60), r7_92 % 60)
				if r7_92 <= 20 then
					r6_92 = "sightred"
				end
			else
				if not r147_0.gameStartTimestamp then
					r147_0.gameStartTimestamp = r3_92
				end
				local r7_92 = math.max(0, r147_0.gameStartTimestamp + (r147_0.length) * 60 - r3_92)
				if r7_92 <= 20 and not isElement(r144_0) then
					r144_0 = playSound("files/10sec.mp3", true)
				end
				r5_92 = string.format("%02d:%02d", math.floor(r7_92 / 60), r7_92 % 60)
				if r7_92 <= 20 then
					r6_92 = "sightred"
				elseif r7_92 <= 60 then
					r6_92 = "sightyellow"
				end
			end

			if r143_0.waitCount then
				sightexports.sGui:setGuiRenderDisabled(r143_0.waitLabel, true)
			end
		else
			local r7_92 = math.max(0, r147_0.starting + r147_0.gameStartTime - r3_92)
			if r7_92 <= 10 and not isElement(r144_0) then
				r144_0 = playSound("files/10sec.mp3", true)
			end
			r5_92 = string.format("%02d:%02d", math.floor(r7_92 / 60), r7_92 % 60)
			r4_92 = "Bemelegítés: [color=sightyellow]" .. r5_92
			r6_92 = "sightyellow"
			r7_92 = math.max(0, r7_92 - r147_0.gameStartTime)
			if r143_0.waitCount ~= r7_92 then
				r143_0.waitCount = r7_92
				local r10_92 = "A meccs hamarosan indul."
				if r7_92 > 0 then
					local r11_92 = math.floor(r7_92 / 60)
					r12_92 = r7_92 % 60
					r10_92 = "Várakozás a játékosokra: " .. string.format("%02d:%02d", r11_92, r12_92)
				end
				sightexports.sGui:setLabelText(r143_0.waitLabel, r10_92)
				sightexports.sGui:setGuiRenderDisabled(r143_0.waitLabel, false)
			end
		end
	end
	if r143_0.timerCol ~= r6_92 then
		r143_0.timerCol = r6_92
		sightexports.sGui:setLabelColor(r143_0.timerLabel, r6_92)
	end
	if r143_0.timerText ~= r5_92 then
		r143_0.timerText = r5_92
		sightexports.sGui:setLabelText(r143_0.timerLabel, r5_92 or "")
	end
	if r143_0.mainLabelText ~= r4_92 then
		r143_0.mainLabelText = r4_92
		if r4_92 then
			sightexports.sGui:setGuiRenderDisabled(r143_0.mainLabel, false)
			sightexports.sGui:setLabelText(r143_0.mainLabel, r4_92)
			sightexports.sGui:setGuiRenderDisabled(r143_0.hpLabel, true)
			sightexports.sGui:setGuiRenderDisabled(r143_0.hpBg, true)
			sightexports.sGui:setGuiRenderDisabled(r143_0.hpBar, true)
		else
			sightexports.sGui:setGuiRenderDisabled(r143_0.mainLabel, true)
			sightexports.sGui:setGuiRenderDisabled(r143_0.hpLabel, false)
			sightexports.sGui:setGuiRenderDisabled(r143_0.hpBg, false)
			sightexports.sGui:setGuiRenderDisabled(r143_0.hpBar, false)
		end
	end
	if tonumber(r147_0.canChangeLoadout) then
		r147_0.canChangeLoadout = r147_0.canChangeLoadout - r0_92 / 1000
		if r147_0.canChangeLoadout < 0 then
			r147_0.canChangeLoadout = false
			deleteAirsoftLoadoutGui()
			sightexports.sGui:setGuiRenderDisabled(r143_0.loadoutIcon, true)
			sightexports.sGui:setGuiRenderDisabled(r143_0.loadoutLabel, true)
			r143_0.loadoutText = false
		else
			local r7_92 = math.floor(r147_0.canChangeLoadout)
			if r143_0.loadoutText ~= r7_92 then
				r143_0.loadoutText = r7_92
				sightexports.sGui:setLabelText(r143_0.loadoutLabel, r7_92)
			end
		end
	end
end
function deleteAirsoftGui()
	-- line: [3817, 3840] id: 93
	if isElement(r144_0) then
		destroyElement(r144_0)
	end
	r144_0 = nil
	if r142_0 and exports.sGui:isGuiElementValid(r142_0) then
		sightexports.sGui:deleteGuiElement(r142_0)
	end
	r142_0 = nil
	if r143_0.timerBg and exports.sGui:isGuiElementValid(r143_0.timerBg) then
		sightexports.sGui:deleteGuiElement(r143_0.timerBg)
	end
	r143_0.timerBg = nil
	if r143_0.aliveBg and exports.sGui:isGuiElementValid(r143_0.aliveBg) then
		sightexports.sGui:deleteGuiElement(r143_0.aliveBg)
	end
	r143_0.aliveBg = nil
	if r143_0.waitLabel and exports.sGui:isGuiElementValid(r143_0.waitLabel) then
		sightexports.sGui:deleteGuiElement(r143_0.waitLabel)
	end
	r143_0.waitLabel = nil
	if r143_0.specLabel and exports.sGui:isGuiElementValid(r143_0.specLabel) then
		sightexports.sGui:deleteGuiElement(r143_0.specLabel)
	end
	r143_0.specLabel = nil
	if r143_0.specHP and exports.sGui:isGuiElementValid(r143_0.specHP) then
		sightexports.sGui:deleteGuiElement(r143_0.specHP)
	end
	r143_0.specHP = nil
	if r143_0.flagLabel and exports.sGui:isGuiElementValid(r143_0.flagLabel) then
		sightexports.sGui:deleteGuiElement(r143_0.flagLabel)
	end
	r143_0.flagLabel = nil
	if r143_0.team1Bg and exports.sGui:isGuiElementValid(r143_0.team1Bg) then
		sightexports.sGui:deleteGuiElement(r143_0.team1Bg)
	end
	r143_0.team1Bg = nil
	if r143_0.team2Bg and exports.sGui:isGuiElementValid(r143_0.team2Bg) then
		sightexports.sGui:deleteGuiElement(r143_0.team2Bg)
	end
	r143_0.team2Bg = nil
	r143_0 = {}
	lastKill = 0
	r103_0 = 0
	r104_0 = false
	r60_0(false)
	r58_0(false)
	r56_0(false)
end
function createAirsoftGui()
	-- line: [3843, 4035] id: 94
	deleteAirsoftGui()
	local r0_94 = r83_0 / 5
	local r1_94 = 32
	r142_0 = sightexports.sGui:createGuiElement("rectangle", r83_0 - 16 - r0_94, r84_0 - 16 - r1_94, r0_94, r1_94)
	setGuiBackground(r142_0, "solid", "sightgrey2")
	local r2_94 = sightexports.sGui:getFontHeight("11/Ubuntu-R.ttf") + 4
	local r3_94 = r2_94 * 10 + 12 + 8
	r143_0.chat = sightexports.sGui:createGuiElement("rectangle", 0, -r3_94, r0_94, r3_94, r142_0)
	setGuiBackground(r143_0.chat, "solid", "sightgrey1")
	local r4_94 = sightexports.sGui:createGuiElement("rectangle", 6, 6, r0_94 - 12, r3_94 - 12, r143_0.chat)
	setGuiBackground(r4_94, "solid", "sightgrey2")
	local r5_94 = sightexports.sGui:createGuiElement("rectangle", r0_94 - 12 - 3, 0, 3, r3_94 - 12, r4_94)
	setGuiBackground(r5_94, "solid", "sightgrey3")
	r143_0.chatH = r3_94 - 12
	r143_0.chatScrollBar = sightexports.sGui:createGuiElement("rectangle", 0, 0, 3, r143_0.chatH, r5_94)
	setGuiBackground(r143_0.chatScrollBar, "solid", "sightlightgrey")
	r143_0.chatLabels = {}
	r143_0.chatScroll = 0
	for r9_94 = 1, 10, 1 do
		r143_0.chatLabels[r9_94] = sightexports.sGui:createGuiElement("label", 4, r3_94 - 12 - 4 - r2_94 * r9_94, 0, r2_94, r4_94)
		sightexports.sGui:setLabelFont(r143_0.chatLabels[r9_94], "11/Ubuntu-R.ttf")
		sightexports.sGui:setLabelAlignment(r143_0.chatLabels[r9_94], "left", "center")
		sightexports.sGui:setLabelColor(r143_0.chatLabels[r9_94], "sightmidgrey")
	end
	processAirsoftChatLines()
	r143_0.mainLabel = sightexports.sGui:createGuiElement("label", 8, 0, 0, r1_94, r142_0)
	sightexports.sGui:setLabelFont(r143_0.mainLabel, "15/BebasNeueBold.otf")
	sightexports.sGui:setLabelAlignment(r143_0.mainLabel, "left", "center")
	r143_0.hpLabel = sightexports.sGui:createGuiElement("label", 8, 0, 0, r1_94 - 8 - 4 - 2, r142_0)
	sightexports.sGui:setLabelFont(r143_0.hpLabel, "8/Ubuntu-R.ttf")
	sightexports.sGui:setLabelAlignment(r143_0.hpLabel, "left", "bottom")
	sightexports.sGui:setLabelText(r143_0.hpLabel, "100/100")
	r143_0.hpBg = sightexports.sGui:createGuiElement("rectangle", 8, r1_94 - 8 - 4, r0_94 * 0.4, 4, r142_0)
	setGuiBackground(r143_0.hpBg, "solid", "sightgrey1")
	r143_0.hpBar = sightexports.sGui:createGuiElement("rectangle", 0, 0, r0_94 * 0.4, 4, r143_0.hpBg)
	setGuiBackground(r143_0.hpBar, "solid", "sightred")
	sightexports.sGui:setGuiRenderDisabled(r143_0.hpLabel, true)
	sightexports.sGui:setGuiRenderDisabled(r143_0.hpBg, true)
	sightexports.sGui:setGuiRenderDisabled(r143_0.hpBar, true)
	local r6_94 = sightexports.sGui:createGuiElement("image", r0_94 - 24 - 4, 4, 24, 24, r142_0)
	sightexports.sGui:setImageFile(r6_94, sightexports.sGui:getFaIconFilename("sign-out", 24))
	sightexports.sGui:setGuiHoverable(r6_94, true)
	sightexports.sGui:setGuiHover(r6_94, "solid", "sightred")
	sightexports.sGui:setClickEvent(r6_94, "leaveAirsoftGame")
	sightexports.sGui:guiSetTooltip(r6_94, "Meccs elhagyása")
	local r7_94 = r147_0.team
	if r7_94 then
		r7_94 = 3 or 2
	else
		r7_94 = 2
	end
	if r147_0.team then
		r143_0.teamIcon = sightexports.sGui:createGuiElement("image", r0_94 - 56, 4, 24, 24, r142_0)
		sightexports.sGui:setImageFile(r143_0.teamIcon, sightexports.sGui:getFaIconFilename("users", 24))
		local r8_94 = sightexports.sGui
		local r10_94 = r143_0.teamIcon
		local r11_94 = r147_0.team
		if r11_94 == 1 then
			r11_94 = "sightblue" or "sightred"
		else
			r11_94 = "sightred"
		end
		r8_94:setImageColor(r10_94, r11_94)
		sightexports.sGui:setClickEvent(r143_0.teamIcon, "changeAirsoftTeam")
		sightexports.sGui:guiSetTooltip(r143_0.teamIcon, "Csapatváltás")
	end
	r143_0.loadoutIcon = sightexports.sGui:createGuiElement("image", r0_94 - 28 * r7_94, 4, 24, 24, r142_0)
	sightexports.sGui:setImageFile(r143_0.loadoutIcon, sightexports.sGui:getFaIconFilename("backpack", 24))
	sightexports.sGui:setGuiHoverable(r143_0.loadoutIcon, true)
	sightexports.sGui:setGuiHover(r143_0.loadoutIcon, "solid", "sightorange")
	sightexports.sGui:setClickEvent(r143_0.loadoutIcon, "createAirsoftLoadoutGui")
	sightexports.sGui:guiSetTooltip(r143_0.loadoutIcon, "Loadout")
	r143_0.loadoutLabel = sightexports.sGui:createGuiElement("label", r0_94 - 28 * r7_94, 0, 0, r1_94, r142_0)
	sightexports.sGui:setLabelFont(r143_0.loadoutLabel, "13/BebasNeueRegular.otf")
	sightexports.sGui:setLabelAlignment(r143_0.loadoutLabel, "right", "center")
	local r8_94 = sightexports.sGui:getFontHeight("22/BebasNeueBold.otf") + 6
	local r9_94 = sightexports.sGui:getTextWidthFont("88:88", "22/BebasNeueBold.otf") + 12
	local r10_94 = 0
	local r11_94 = r9_94
	if r147_0.gm == "lms" or r147_0.gm == "ffa" then
		r10_94 = r8_94 + sightexports.sGui:getTextWidthFont("888.", "22/BebasNeueBold.otf") + 12
		r11_94 = r9_94 + 8 + r10_94
	end
	if r147_0.team then
		local r12_94 = sightexports.sGui:getTextWidthFont("88888", "22/BebasNeueBold.otf") + 12
		r143_0.team1Bg = sightexports.sGui:createGuiElement("rectangle", r83_0 / 2 - r9_94 / 2 - r12_94, 16, r12_94, r8_94)
		setGuiBackground(r143_0.team1Bg, "solid", "sightblue")
		r143_0.team1 = sightexports.sGui:createGuiElement("label", 0, 0, r12_94, r8_94, r143_0.team1Bg)
		sightexports.sGui:setLabelFont(r143_0.team1, "22/BebasNeueBold.otf")
		sightexports.sGui:setLabelAlignment(r143_0.team1, "center", "center")
		sightexports.sGui:setLabelText(r143_0.team1, "0")
		r143_0.team2Bg = sightexports.sGui:createGuiElement("rectangle", r83_0 / 2 + r9_94 / 2, 16, r12_94, r8_94)
		setGuiBackground(r143_0.team2Bg, "solid", "sightred")
		r143_0.team2 = sightexports.sGui:createGuiElement("label", 0, 0, r12_94, r8_94, r143_0.team2Bg)
		sightexports.sGui:setLabelFont(r143_0.team2, "22/BebasNeueBold.otf")
		sightexports.sGui:setLabelAlignment(r143_0.team2, "center", "center")
		sightexports.sGui:setLabelText(r143_0.team2, "0")
	end
	r143_0.timerBg = sightexports.sGui:createGuiElement("rectangle", r83_0 / 2 - r11_94 / 2, 16, r9_94, r8_94)
	setGuiBackground(r143_0.timerBg, "solid", "sightgrey1")
	r143_0.timerLabel = sightexports.sGui:createGuiElement("label", 0, 0, r9_94, r8_94, r143_0.timerBg)
	--sightexports.sGui:setLabelText(r143_0.timerLabel, "00:00")
	sightexports.sGui:setLabelFont(r143_0.timerLabel, "22/BebasNeueBold.otf")
	sightexports.sGui:setLabelAlignment(r143_0.timerLabel, "center", "center")
	if r147_0.gm == "lms" or r147_0.gm == "ffa" then
		r143_0.aliveBg = sightexports.sGui:createGuiElement("rectangle", r83_0 / 2 - r11_94 / 2 + r9_94 + 8, 16, r10_94, r8_94)
		setGuiBackground(r143_0.aliveBg, "solid", "sightgrey1")
		r143_0.aliveIcon = sightexports.sGui:createGuiElement("image", 4, 4, r8_94 - 8, r8_94 - 8, r143_0.aliveBg)
		sightexports.sGui:setImageFile(r143_0.aliveIcon, sightexports.sGui:getFaIconFilename("users", r8_94))
		r143_0.aliveLabel = sightexports.sGui:createGuiElement("label", r8_94 - 4, 0, r10_94 - r8_94 + 4, r8_94, r143_0.aliveBg)
		sightexports.sGui:setLabelFont(r143_0.aliveLabel, "22/BebasNeueBold.otf")
		sightexports.sGui:setLabelAlignment(r143_0.aliveLabel, "center", "center")
		sightexports.sGui:setLabelText(r143_0.aliveLabel, "-")
		sightexports.sGui:setImageColor(r143_0.aliveIcon, "sightyellow")
		sightexports.sGui:setLabelColor(r143_0.aliveLabel, "sightyellow")
		r143_0.aliveCount = true
	end
	r143_0.waitLabel = sightexports.sGui:createGuiElement("label", 0, r84_0 * 0.85, r83_0, 0)
	sightexports.sGui:setLabelFont(r143_0.waitLabel, "20/BebasNeueBold.otf")
	sightexports.sGui:setLabelAlignment(r143_0.waitLabel, "center", "top")
	sightexports.sGui:setLabelShadow(r143_0.waitLabel, "#000000ae", 1, 1)
	sightexports.sGui:setGuiRenderDisabled(r143_0.waitLabel, true)
	r143_0.specLabel = sightexports.sGui:createGuiElement("label", 0, r84_0 * 0.85, r83_0, 0)
	sightexports.sGui:setLabelFont(r143_0.specLabel, "20/BebasNeueBold.otf")
	sightexports.sGui:setLabelAlignment(r143_0.specLabel, "center", "top")
	sightexports.sGui:setLabelShadow(r143_0.specLabel, "#000000ae", 1, 1)
	sightexports.sGui:setLabelText(r143_0.specLabel, "Játékos váltáshoz használd a [Bal/Jobb egérgombokat].")
	sightexports.sGui:setGuiRenderDisabled(r143_0.specLabel, true)
	local r12_94 = sightexports.sGui:getTextWidthFont("100/100", "9/Ubuntu-R.ttf")
	r143_0.specHP = sightexports.sGui:createGuiElement("rectangle", r83_0 / 2 - r0_94 * 0.6 / 2, r84_0 * 0.85 + sightexports.sGui:getLabelFontHeight(r143_0.specLabel) + 8, r0_94 * 0.6 - r12_94 - 8, 8)
	setGuiBackground(r143_0.specHP, "solid", "sightgrey1")
	r143_0.specHPBar = sightexports.sGui:createGuiElement("rectangle", 0, 0, r0_94 * 0.6 - r12_94 - 8, 8, r143_0.specHP)
	setGuiBackground(r143_0.specHPBar, "solid", "sightred")
	r143_0.specHPLabel = sightexports.sGui:createGuiElement("label", r0_94 * 0.6 - r12_94, 0, r12_94, 8, r143_0.specHP)
	sightexports.sGui:setLabelFont(r143_0.specHPLabel, "9/Ubuntu-R.ttf")
	sightexports.sGui:setLabelAlignment(r143_0.specHPLabel, "center", "center")
	sightexports.sGui:setLabelText(r143_0.specHPLabel, "100/100")
	sightexports.sGui:setLabelShadow(r143_0.specHPLabel, "#000000ae", 1, 1)
	sightexports.sGui:setGuiRenderDisabled(r143_0.specHP, true, true)
	if r147_0.flags then
		r143_0.flagLabel = sightexports.sGui:createGuiElement("label", 0, r84_0 * 0.85, r83_0, 0)
		sightexports.sGui:setLabelFont(r143_0.flagLabel, "20/BebasNeueBold.otf")
		sightexports.sGui:setLabelAlignment(r143_0.flagLabel, "center", "top")
		sightexports.sGui:setLabelShadow(r143_0.flagLabel, "#000000ae", 1, 1)
		sightexports.sGui:setLabelText(r143_0.flagLabel, "A zászló elfogalásához tartsd lenyomva az [E] gombot.")
		sightexports.sGui:setGuiRenderDisabled(r143_0.flagLabel, true)
	end
	r60_0(true)
	r58_0(true)
	r56_0(true)
end
addEvent("leaveAirsoftGame", false)
addEventHandler("leaveAirsoftGame", getRootElement(), function()
	-- line: [4039, 4041] id: 95
	triggerServerEvent("leaveAirsoftGame", localPlayer)
end)
local r154_0 = {}
local r155_0 = {}
local r156_0 = {}
function refreshTeamShaderColors()
  -- line: [4047, 4063] id: 96
  local r0_96 = r147_0.team
  if r0_96 then
		r0_96 = r147_0.team
		if r0_96 == 1 then
		r0_96 = r44_0
		else
		r0_96 = r43_0 or r42_0
		end
	else
		r0_96 = r42_0
	end
  if isElement(r123_0) then
    dxSetShaderValue(r123_0, "sColorizePed", r0_96[1] / 255, r0_96[2] / 255, r0_96[3] / 255, 0.75)
  end
  if isElement(r126_0) then
    dxSetShaderValue(r126_0, "sColorizePed", r0_96[1] / 255, r0_96[2] / 255, r0_96[3] / 255, 1)
  end
  if r147_0.team == 1 then
    r0_96 = r43_0
  else
    r0_96 = r44_0
  end
  if isElement(r128_0) then
    dxSetShaderValue(r128_0, "sColorizePed", r0_96[1] / 255, r0_96[2] / 255, r0_96[3] / 255, 0.75)
  end
end
function refreshPlayerColors(r0_97)
  -- line: [4065, 4184] id: 97
  local r1_97 = {}
  local r2_97 = {}
  for r6_97 = 1, #r156_0, 1 do
    if isElement(r156_0[r6_97]) then
      if isElement(r123_0) then
        engineRemoveShaderFromWorldTexture(r123_0, "*", r156_0[r6_97])
      end
      if isElement(r124_0) then
        engineRemoveShaderFromWorldTexture(r124_0, "*", r156_0[r6_97])
      end
      if isElement(r125_0) then
        engineRemoveShaderFromWorldTexture(r125_0, "*", r156_0[r6_97])
      end
      if isElement(r128_0) then
        engineRemoveShaderFromWorldTexture(r128_0, "*", r156_0[r6_97])
      end
    end
  end
  r156_0 = {}
  if r147_0 then
    if r147_0.team then
      for r6_97 = 1, #r147_0.playerDatas, 1 do
        local r7_97 = r147_0.playerDatas[r6_97].client
        if r7_97 and r6_97 ~= r0_97 then
          if r147_0.playerDatas[r6_97].team == 1 then
            r2_97[r7_97] = tocolor(0, 155, 255)
          else
            r2_97[r7_97] = tocolor(255, 0, 0)
          end
        end
      end
      for r6_97 = 1, #r147_0.playerDatas, 1 do
        local r7_97 = r147_0.playerDatas[r6_97].client
        if r7_97 and r147_0.playerDatas[r6_97].spawned and r7_97 ~= localPlayer and r6_97 ~= r0_97 then
          if r147_0.playerDatas[r6_97].team == 1 then
            r1_97[r7_97] = "sightblue"
          else
            r1_97[r7_97] = "sightred"
          end
          if r147_0.playerDatas[r6_97].team == r147_0.team then
            if isElement(r123_0) then
              engineApplyShaderToWorldTexture(r123_0, "*", r7_97)
            end
            if isElement(r124_0) then
              engineApplyShaderToWorldTexture(r124_0, "*", r7_97)
            end
          elseif isElement(r128_0) then
            engineApplyShaderToWorldTexture(r128_0, "*", r7_97)
          end
          table.insert(r156_0, r7_97)
        end
      end
    else
      if not r147_0.started or r147_0.ended or not r147_0.spawned or tonumber(r147_0.spawned) then
        for r6_97 = 1, #r147_0.playerDatas, 1 do
          local r7_97 = r147_0.playerDatas[r6_97].client
          if r7_97 and r147_0.playerDatas[r6_97].spawned and r7_97 ~= localPlayer and r6_97 ~= r0_97 then
            if isElement(r125_0) then
              engineApplyShaderToWorldTexture(r125_0, "*", r7_97)
            end
            table.insert(r156_0, r7_97)
          end
        end
      end
      for r6_97 = 1, #r147_0.playerDatas, 1 do
        local r7_97 = r147_0.playerDatas[r6_97].client
        if r7_97 and r6_97 ~= r0_97 then
          r2_97[r7_97] = tocolor(60, 190, 120)
        end
      end
    end
  end
  for r6_97 in pairs(r1_97) do
    if r1_97[r6_97] ~= r154_0[r6_97] then
		if r6_97 ~= localPlayer then
      		sightexports.sNames:setAirsoftColor(r6_97, r1_97[r6_97])
		end
      r154_0[r6_97] = r1_97[r6_97]
    end
  end
  for r6_97 in pairs(r154_0) do
    if r1_97[r6_97] ~= r154_0[r6_97] then
		if r6_97 ~= localPlayer then
      		sightexports.sNames:setAirsoftColor(r6_97, r1_97[r6_97])
		end
      r154_0[r6_97] = r1_97[r6_97]
    end
  end
  for r6_97 in pairs(r2_97) do
    if r2_97[r6_97] ~= r155_0[r6_97] then
      r155_0[r6_97] = r2_97[r6_97]
    end
  end
  for r6_97 in pairs(r155_0) do
    if r2_97[r6_97] ~= r155_0[r6_97] then
      r155_0[r6_97] = r2_97[r6_97]
    end
  end
end
addEvent("gotAirsoftMapLimits", true)
addEventHandler("gotAirsoftMapLimits", getRootElement(), function(r0_98)
	-- line: [4189, 4199] id: 98
	for r4_98 = 1, #r0_98, 1 do
		airsoftMaps[r4_98].playerSpawns = r0_98[r4_98][1]
		airsoftMaps[r4_98].teamSpawns = {
			r0_98[r4_98][2],
			r0_98[r4_98][3]
		}
	end
end)
addEventHandler("onClientResourceStart", getResourceRootElement(), function()
	-- line: [4203, 4205] id: 99
	triggerServerEvent("requestAirsoftMapLimits", localPlayer)
end)
addEventHandler("onClientResourceStop", getResourceRootElement(), function()
	-- line: [4208, 4218] id: 100
	sightexports.sHud:setStaminaMul(1)
	for r3_100 in pairs(r154_0) do
		sightexports.sNames:setAirsoftColor(r3_100)
	end
	for r3_100 in pairs(r155_0) do
		--sightexports.sWeapons:setTracerColor(r3_100)
	end
end)
addEvent("syncAirsoftPlayerFullData", true)
addEventHandler("syncAirsoftPlayerFullData", getRootElement(), function(r0_101, r1_101, r2_101)
	if r147_0 and r147_0.id == r0_101 then
		r147_0.playerDatas[r1_101] = r2_101
		if r146_0 then
			createAirsoftTeamInner()
		end
		refreshTeamShaderColors()
		refreshPlayerColors()
		r62_0(true)
	end
end)
addEvent("syncAirsoftPlayerData", true)
addEventHandler("syncAirsoftPlayerData", getRootElement(), function(r0_102, r1_102, r2_102, r3_102)
	if r147_0 and r147_0.id == r0_102 and r147_0.playerDatas[r1_102] then
		if r2_102 == "client" and not r3_102 then
			refreshPlayerColors(r1_102)
		end
		r147_0.playerDatas[r1_102][r2_102] = r3_102
		if r2_102 == "team" then
			if r146_0 then
				createAirsoftTeamInner()
			end
			refreshTeamShaderColors()
			refreshPlayerColors()
		elseif r2_102 == "spawned" then
			refreshPlayerColors()
		end
		r62_0(true)
	end
end)
addEvent("syncAirsoftFlagOccupied", true)
addEventHandler("syncAirsoftFlagOccupied", getRootElement(), function(r0_103, r1_103)
	if r147_0 and r147_0.id == r0_103 and r147_0.flags then
		local r2_103 = playSound3D("files/flago.mp3", r147_0.flags[r1_103][1], r147_0.flags[r1_103][2], r147_0.flags[r1_103][3])
		setElementInterior(r2_103, airsoftMaps[r147_0.mapId].interior)
		setElementDimension(r2_103, r147_0.id)
		setSoundVolume(r2_103, 1.25)
		setSoundMaxDistance(r2_103, 1000)
		r132_0 = r1_103
		r131_0 = getTickCount()
	end
end)
addEvent("syncAirsoftFlagData", true)
addEventHandler("syncAirsoftFlagData", getRootElement(), function(matchId, flagId, r2_104, r3_104, r4_104)
	if r147_0 and r147_0.id == matchId and r147_0.flags then
		local r5_104 = r147_0[r2_104]
		r5_104[flagId] = r3_104
		if r2_104 == "flagTeam" then
			if r3_104 == 1 then
				r5_104 = r44_0
			else
				r5_104 = r43_0
			end
			dxSetShaderValue(r117_0[flagId], "scol1", r5_104[1] / 255, r5_104[2] / 255, r5_104[3] / 255, 0.75)
			if r3_104 == 1 then
				dxSetShaderValue(r118_0[flagId], "oc", 1, 1, 0, 1)
			else
				dxSetShaderValue(r118_0[flagId], "oc", 1, 0, 1, 1)
			end
		end
	end
end)
addEvent("syncAirsoftInMatchData", true)
addEventHandler("syncAirsoftInMatchData", root, function(matchId, r1_105, r2_105)
	if r147_0 and r147_0.id == matchId then
		r147_0[r1_105] = r2_105
		if r1_105 == "health" then
			sightexports.sGui:setLabelText(r143_0.hpLabel, math.floor(r2_105) .. "/100")
			sightexports.sGui:setGuiSize(r143_0.hpBar, r83_0 / 5 * 0.4 * math.max(0, r2_105 / 100))
		elseif r1_105 == "team1" then
			sightexports.sGui:setLabelText(r143_0.team1, tostring(r2_105))
		elseif r1_105 == "team2" then
			sightexports.sGui:setLabelText(r143_0.team2, tostring(r2_105))
		else
			local r6_105 = nil	-- notice: implicit variable refs by block#[13, 36]
			if r1_105 == "team" then
				if r143_0.teamIcon then
					local r3_105 = sightexports.sGui
					local r5_105 = r143_0.teamIcon
					if r2_105 == 1 then
						r6_105 = "sightblue"
						if not r6_105 then
							-- ::label_79::
							r6_105 = "sightred"
						end
					else
						r6_105 = "sightred"
					end
					r3_105:setImageColor(r5_105, r6_105)
				end
				if r146_0 then
					createAirsoftTeamInner()
				end
				r147_0.team = r2_105
				refreshTeamShaderColors()
				refreshPlayerColors()
			elseif r1_105 == "started" then
				r143_0.timerText = 30
				if r147_0.gm == "ffa" then
					r62_0(true)
				end
				if not r147_0.team then
					refreshPlayerColors()
				end
				sightexports.sWeapons:resetBulletImpacts()
				refreshTeamShaderColors()
				deleteAirsoftTeamWindow()
				if r143_0.teamIcon then
					sightexports.sGui:setGuiHoverable(r143_0.teamIcon, false)
				end
				if isElement(r144_0) then
					destroyElement(r144_0)
				end
				r144_0 = nil
				playSound("files/start.mp3")
				r147_0.started = true
			elseif r1_105 == "specHealth" then
				if tonumber(r2_105) then
					sightexports.sGui:setGuiRenderDisabled(r143_0.specHP, false, true)
					sightexports.sGui:setLabelText(r143_0.specHPLabel, math.floor(r2_105) .. "/100")
					sightexports.sGui:setGuiSize(r143_0.specHPBar, sightexports.sGui:getGuiSize(r143_0.specHP) * math.max(0, r2_105 / 100))
				else
					sightexports.sGui:setGuiRenderDisabled(r143_0.specHP, true, true)
				end
			elseif r1_105 == "spawned" then
				--sightexports.sDamage:resetDamages()
				if source == localPlayer then
					r103_0 = 0
					r104_0 = false
					sightexports.sGui:setLabelText(r143_0.hpLabel, "100/100")
					sightexports.sGui:setGuiSize(r143_0.hpBar, r83_0 / 5 * 0.4)
					local r3_105 = sightexports.sGui
					local r5_105 = r143_0.specLabel
					if r2_105 then
						r6_105 = not tonumber(r2_105)
					else
						r6_105 = false
					end
					r3_105:setGuiRenderDisabled(r5_105, r6_105)
					if r2_105 and not tonumber(r2_105) then
						sightexports.sGui:setGuiRenderDisabled(r143_0.specHP, true, true)
					end
				end
			elseif r1_105 == "ended" then
				if r147_0.gm == "ffa" then
					sightexports.sGui:setImageColor(r143_0.aliveIcon, "sightyellow")
					sightexports.sGui:setLabelColor(r143_0.aliveLabel, "sightyellow")
				end
				if not r147_0.team then
					refreshPlayerColors()
				end
				if isElement(r144_0) then
					destroyElement(r144_0)
				end
				r144_0 = nil
			elseif r1_105 == "ending" then
				r143_0.timerText = false
				r143_0.timerCol = false
			elseif r1_105 == "canChangeLoadout" then
				if not r2_105 then
					deleteAirsoftLoadoutGui()
				end
				sightexports.sGui:setGuiRenderDisabled(r143_0.loadoutIcon, not r2_105)
				sightexports.sGui:setGuiRenderDisabled(r143_0.loadoutLabel, not tonumber(r2_105))
				r143_0.loadoutText = false
			end
		end
	end
end)
function setRefreshScoreboard()
	-- line: [4393, 4488] id: 106
	r62_0(false)
	r106_0 = {}
	if r147_0 then
		local r0_106 = {}
		for r4_106 = 1, #r147_0.playerDatas, 1 do
			table.insert(r0_106, processScoreboardList(r147_0.playerDatas[r4_106]))
		end
		table.sort(r0_106, gameModes[r147_0.gm].scoreboardSort)
		if r147_0.team then
			local r1_106 = 0
			local r2_106 = 0
			local r3_106 = 0
			local r4_106 = 0
			local r5_106 = 0
			local r6_106 = 0
			for r10_106 = 1, #r147_0.playerDatas, 1 do
				if r147_0.playerDatas[r10_106].team == 1 then
					r3_106 = r3_106 + r147_0.playerDatas[r10_106].k
					r5_106 = r5_106 + r147_0.playerDatas[r10_106].d
					r1_106 = r1_106 + 1
				else
					r4_106 = r4_106 + r147_0.playerDatas[r10_106].k
					r6_106 = r6_106 + r147_0.playerDatas[r10_106].d
					r2_106 = r2_106 + 1
				end
			end
			table.insert(r106_0, {
				name = "Kék csapat (" .. r1_106 .. ")",
				team = 0.5,
				k = r3_106,
				d = r5_106,
			})
			for r10_106 = 1, #r0_106, 1 do
				if r0_106[r10_106].team == 1 then
					table.insert(r106_0, r0_106[r10_106])
				end
			end
			table.insert(r106_0, {
				name = "Piros csapat (" .. r2_106 .. ")",
				team = 1.5,
				k = r4_106,
				d = r6_106,
			})
			for r10_106 = 1, #r0_106, 1 do
				if r0_106[r10_106].team == 2 then
					table.insert(r106_0, r0_106[r10_106])
				end
			end
		else
			r106_0 = r0_106
		end
	end
	if r147_0.gm == "ffa" and r147_0.started then
		for r3_106 = 1, #r106_0, 1 do
			if r106_0[r3_106].client == localPlayer then
				sightexports.sGui:setLabelText(r143_0.aliveLabel, r3_106 .. ".")
				if r3_106 == 1 then
					sightexports.sGui:setImageColor(r143_0.aliveIcon, "#f5d46e")
					sightexports.sGui:setLabelColor(r143_0.aliveLabel, "#f5d46e")
				elseif r3_106 == 2 then
					sightexports.sGui:setImageColor(r143_0.aliveIcon, "#b8c1c5")
					sightexports.sGui:setLabelColor(r143_0.aliveLabel, "#b8c1c5")
				elseif r3_106 == 3 then
					sightexports.sGui:setImageColor(r143_0.aliveIcon, "#c1a486")
					sightexports.sGui:setLabelColor(r143_0.aliveLabel, "#c1a486")
				else
					sightexports.sGui:setImageColor(r143_0.aliveIcon, "#ffffff")
					sightexports.sGui:setLabelColor(r143_0.aliveLabel, "#ffffff")
				end
			end
		end
	end
	if r105_0 then
		local st = sightexports.sGui:isGuiElementValid(r105_0) and sightexports.sGui:isGuiRenderDisabled(r105_0)
		refreshResultList(r107_0, r106_0, r110_0, r109_0, r108_0, st)
	end
end

function refreshResultList(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_, _ARG_5_, _ARG_6_)
	_ARG_2_ = math.min(_ARG_2_, (math.max(0, #_ARG_1_ - #_ARG_0_)))
	_ARG_3_ = _ARG_3_ / (math.max(0, #_ARG_1_ - #_ARG_0_) + 1)
	
	if sightexports.sGui:isGuiElementValid(_ARG_4_) then
		sightexports.sGui:setGuiSize(_ARG_4_, false, _ARG_3_)
		sightexports.sGui:setGuiPosition(_ARG_4_, false, _ARG_3_ * _ARG_2_)
	end
	for _FORV_11_ = 1, #_ARG_0_ do
		if _ARG_1_[_FORV_11_ + _ARG_2_] then
			for _FORV_16_ = 1, #_ARG_0_[_FORV_11_] do
				--sightexports.sGui:setGuiRenderDisabled(_ARG_0_[_FORV_11_][_FORV_16_], _ARG_5_)
			end
			if _ARG_6_ and _FORV_11_ + _ARG_2_ <= 3 then
				if _FORV_11_ + _ARG_2_ == 1 then
					setGuiBackground(_ARG_0_[_FORV_11_][1], "gradient", {
						"#f5d46e",
						"sightgrey2",
						true
					})
				elseif _FORV_11_ + _ARG_2_ == 2 then
					setGuiBackground(_ARG_0_[_FORV_11_][1], "gradient", {
						"#b8c1c5",
						"sightgrey2",
						true
					})
				elseif _FORV_11_ + _ARG_2_ == 3 then
					setGuiBackground(_ARG_0_[_FORV_11_][1], "gradient", {
						"#c1a486",
						"sightgrey2",
						true
					})
				end
			elseif _ARG_1_[_FORV_11_ + _ARG_2_].team == 0.5 then
				setGuiBackground(_ARG_0_[_FORV_11_][1], "solid", "sightblue")
			elseif _ARG_1_[_FORV_11_ + _ARG_2_].team == 1.5 then
				setGuiBackground(_ARG_0_[_FORV_11_][1], "solid", "sightred")
			else
				if isElement(_ARG_1_[_FORV_11_ + _ARG_2_].client) then
					if not _ARG_1_[_FORV_11_ + _ARG_2_].spawned then
					else
					end
				else
				end
				setGuiBackground(_ARG_0_[_FORV_11_][1], "solid", "sightgrey2")
			end
			if sightexports.sGui:isGuiElementValid(_ARG_0_[_FORV_11_][2]) then
				sightexports.sGui:setLabelFont(_ARG_0_[_FORV_11_][2], _ARG_1_[_FORV_11_ + _ARG_2_].client == localPlayer and "11/Ubuntu-B.ttf" or "11/Ubuntu-L.ttf")
				sightexports.sGui:setLabelFont(_ARG_0_[_FORV_11_][3], _ARG_1_[_FORV_11_ + _ARG_2_].client == localPlayer and "11/Ubuntu-B.ttf" or "11/Ubuntu-L.ttf")
				sightexports.sGui:setLabelFont(_ARG_0_[_FORV_11_][4], _ARG_1_[_FORV_11_ + _ARG_2_].client == localPlayer and "11/Ubuntu-B.ttf" or "11/Ubuntu-L.ttf")
				sightexports.sGui:setLabelFont(_ARG_0_[_FORV_11_][5], _ARG_1_[_FORV_11_ + _ARG_2_].client == localPlayer and "11/Ubuntu-B.ttf" or "11/Ubuntu-L.ttf")
				sightexports.sGui:setLabelColor(_ARG_0_[_FORV_11_][2], "#ffffff")
				sightexports.sGui:setLabelColor(_ARG_0_[_FORV_11_][3], "#ffffff")
				sightexports.sGui:setLabelColor(_ARG_0_[_FORV_11_][4], "#ffffff")
				sightexports.sGui:setLabelColor(_ARG_0_[_FORV_11_][5], "#ffffff")
				sightexports.sGui:setLabelText(_ARG_0_[_FORV_11_][2], _ARG_1_[_FORV_11_ + _ARG_2_].name)
				sightexports.sGui:setLabelText(_ARG_0_[_FORV_11_][3], _ARG_1_[_FORV_11_ + _ARG_2_].k)
				sightexports.sGui:setLabelText(_ARG_0_[_FORV_11_][4], _ARG_1_[_FORV_11_ + _ARG_2_].d)
				sightexports.sGui:setLabelText(_ARG_0_[_FORV_11_][5], math.floor(_ARG_1_[_FORV_11_ + _ARG_2_].k / math.max(1, _ARG_1_[_FORV_11_ + _ARG_2_].d) * 100 + 0.5) / 100)
			end
			if _ARG_0_[_FORV_11_][7] then
				sightexports.sGui:setLabelText(_ARG_0_[_FORV_11_][7], _FORV_11_ + _ARG_2_ .. ".")
				sightexports.sGui:setLabelFont(_ARG_0_[_FORV_11_][7], _ARG_1_[_FORV_11_ + _ARG_2_].client == localPlayer and "11/Ubuntu-B.ttf" or "11/Ubuntu-L.ttf")
				sightexports.sGui:setLabelColor(_ARG_0_[_FORV_11_][7], "#ffffff")
			end
		else
			for _FORV_16_ = 1, #_ARG_0_[_FORV_11_] do
				--sightexports.sGui:setGuiRenderDisabled(_ARG_0_[_FORV_11_][_FORV_16_], true)
			end
		end
	end
end

function createResultList(r0_108, r1_108, r2_108, r3_108)
	-- line: [4572, 4654] id: 108
	local r4_108 = {}
	local r5_108 = math.floor(r1_108 / 35)
	local r6_108 = r1_108 / r5_108
	local r7_108 = sightexports.sGui:createGuiElement("rectangle", 0, 0, r0_108, r6_108, r2_108)
	setGuiBackground(r7_108, "solid", "sightgrey1")
	local r8_108 = r0_108 - 32
	local r9_108 = (r8_108 - 3) * 0.65
	local r10_108 = (r8_108 - 3 - r9_108) / 3
	local r11_108 = sightexports.sGui
	local r13_108 = "label"
	local r14_108 = nil	-- notice: implicit variable refs by block#[3]
	if r3_108 then
		r14_108 = 28
		if not r14_108 then
			-- ::label_38::
			r14_108 = 0
		end
	else
		r14_108 = 0
	end
	r11_108 = r11_108:createGuiElement(r13_108, 16 + r14_108, 0, r9_108, r6_108, r7_108)
	sightexports.sGui:setLabelText(r11_108, "Játékos")
	sightexports.sGui:setLabelFont(r11_108, "11/Ubuntu-R.ttf")
	sightexports.sGui:setLabelAlignment(r11_108, "left", "center")
	local r12_108 = sightexports.sGui:createGuiElement("label", 16 + r9_108, 0, r10_108, r6_108, r7_108)
	sightexports.sGui:setLabelText(r12_108, "K")
	sightexports.sGui:setLabelFont(r12_108, "11/Ubuntu-R.ttf")
	sightexports.sGui:setLabelAlignment(r12_108, "center", "center")
	r13_108 = sightexports.sGui:createGuiElement("label", 16 + r9_108 + r10_108, 0, r10_108, r6_108, r7_108)
	sightexports.sGui:setLabelText(r13_108, "D")
	sightexports.sGui:setLabelFont(r13_108, "11/Ubuntu-R.ttf")
	sightexports.sGui:setLabelAlignment(r13_108, "center", "center")
	r14_108 = sightexports.sGui:createGuiElement("label", 16 + r9_108 + r10_108 * 2, 0, r10_108, r6_108, r7_108)
	sightexports.sGui:setLabelText(r14_108, "K/D")
	sightexports.sGui:setLabelFont(r14_108, "11/Ubuntu-R.ttf")
	sightexports.sGui:setLabelAlignment(r14_108, "center", "center")
	for r18_108 = 1, r5_108 - 1, 1 do
		r4_108[r18_108] = {}
		local r19_108 = sightexports.sGui:createGuiElement("rectangle", 0, r6_108 * r18_108, r0_108, r6_108, r2_108)
		setGuiBackground(r19_108, "solid", "sightgrey2")
		r4_108[r18_108][1] = r19_108
		local r20_108 = sightexports.sGui
		local r22_108 = "label"
		local r23_108 = nil	-- notice: implicit variable refs by block#[7]
		if r3_108 then
			r23_108 = 28
			if not r23_108 then
				-- ::label_188::
				r23_108 = 0
			end
		else
			r23_108 = 0
		end
		r23_108 = 16 + r23_108
		local r24_108 = 0
		local r25_108 = nil	-- notice: implicit variable refs by block#[10]
		if r3_108 then
			r25_108 = 28
			if not r25_108 then
				-- ::label_196::
				r25_108 = 0
			end
		else
			r25_108 = 0
		end
		r20_108 = r20_108:createGuiElement(r22_108, r23_108, r24_108, r9_108 - r25_108, r6_108, r19_108)
		sightexports.sGui:setLabelAlignment(r20_108, "left", "center")
		sightexports.sGui:setLabelClip(r20_108, true)
		r4_108[r18_108][2] = r20_108
		local r21_108 = sightexports.sGui:createGuiElement("label", 16 + r9_108, 0, r10_108, r6_108, r19_108)
		sightexports.sGui:setLabelAlignment(r21_108, "center", "center")
		sightexports.sGui:setLabelClip(r21_108, true)
		r4_108[r18_108][3] = r21_108
		r22_108 = sightexports.sGui:createGuiElement("label", 16 + r9_108 + r10_108, 0, r10_108, r6_108, r19_108)
		sightexports.sGui:setLabelAlignment(r22_108, "center", "center")
		sightexports.sGui:setLabelClip(r22_108, true)
		r4_108[r18_108][4] = r22_108
		r23_108 = sightexports.sGui:createGuiElement("label", 16 + r9_108 + r10_108 * 2, 0, r10_108, r6_108, r19_108)
		sightexports.sGui:setLabelAlignment(r23_108, "center", "center")
		sightexports.sGui:setLabelClip(r23_108, true)
		r4_108[r18_108][5] = r23_108
		if r18_108 < r5_108 - 1 then
			r25_108 = sightexports.sGui:createGuiElement("hr", 0, r6_108 - 1, r0_108, 2, r19_108)
			r4_108[r18_108][6] = r25_108
		end
		if r3_108 then
			r24_108 = sightexports.sGui:createGuiElement("label", 16, 0, 20, r6_108, r19_108)
			sightexports.sGui:setLabelAlignment(r24_108, "right", "center")
			sightexports.sGui:setLabelClip(r24_108, true)
			r25_108 = r4_108[r18_108]
			r25_108[7] = r24_108
		end
	end
	return r4_108, r6_108
end
function setScoreboard(r0_109, r1_109, r2_109)
	-- line: [4656, 4686] id: 109
	if r0_109 then
		if r105_0 then
			if sightexports.sGui:isGuiElementValid(r105_0) then
				sightexports.sGui:deleteGuiElement(r105_0)
			end
		end
		r105_0 = nil
		if r147_0 then
			r105_0 = sightexports.sGui:createGuiElement("rectangle", 0, 0, r1_109, r2_109, r0_109)
			setGuiBackground(r105_0, "solid", "sightgrey2")
			local r3_109 = 0
			local r4_109 = 0
			r107_0, r3_109 = createResultList(r1_109, r2_109, r105_0)
			r109_0 = r3_109 * #r107_0
			local r5_109 = sightexports.sGui:createGuiElement("rectangle", r1_109 - 3, r3_109, 3, r109_0, r105_0)
			setGuiBackground(r5_109, "solid", "sightgrey1")
			r108_0 = sightexports.sGui:createGuiElement("rectangle", 0, 0, 3, r109_0, r5_109)
			setGuiBackground(r108_0, "solid", "sightlightgrey")
			r62_0(true)
		end
	else
		r105_0 = false
		r107_0 = false
		r106_0 = false
		r108_0 = false
		r109_0 = false
	end
end
function getCurrentMatch()
	return r147_0
end
function isInMatch()
	local r0_111 = r147_0
	if r0_111 then
		r0_111 = true or false
	else
		r0_111 = false
	end
	return r0_111
end
function hudRenderAirsoft()
	if r129_0 > 0 then
		dxSetShaderValue(r122_0, "intensity", r129_0)
		dxUpdateScreenSource(r121_0, true)
		dxDrawImage(0, 0, r83_0, r84_0, r122_0)
	end
	if isElement(r126_0) then
		dxDrawImage(0, 0, r83_0, r84_0, r126_0)
	end
	if isElement(r115_0) then
		dxDrawImage(0, 0, r83_0, r84_0, r115_0)
	end
end
addEvent("gotAirsoftDamage", true)
addEventHandler("gotAirsoftDamage", getRootElement(), function(r0_113, r1_113, r2_113, r3_113, datas)
	-- line: [4716, 4749] id: 113
	local x, y, z = getPedTargetStart(source)
	local sx, sy, sz = getPedTargetEnd(source)
	hit, x, y, z, elementHit = processLineOfSight ( x, y, z, sx, sy, sz )
	
	r0_113, r1_113, r2_113 = x, y, z

	if r0_113 then
	
		r3_113 = math.ceil(r3_113)
		local r4_113 = #r133_0 + 1
		for r8_113 = 1, #r133_0, 1 do
			if r133_0[r8_113][10] == source then
				r3_113 = r3_113 + r133_0[r8_113][4]
				r4_113 = r8_113
			end
		end
		local r5_113 = {
			255,
			255,
			255
		}
		if r3_113 > 80 then
			r5_113 = r43_0
		elseif r3_113 > 40 then
			r5_113 = r41_0
		end
		local r6_113, r7_113, r8_113, r9_113, r10_113, r11_113 = getCameraMatrix()
		local r12_113 = r9_113 - r6_113
		local r13_113 = r10_113 - r7_113
		local r14_113 = math.sqrt(r12_113 * r12_113 + r13_113 * r13_113)
		if r14_113 ~= 0 then
			r12_113 = r12_113 / r14_113
			r13_113 = r13_113 / r14_113
		end
		r133_0[r4_113] = {
			r0_113 + r13_113 * 0.25, -- x
			r1_113 - r12_113 * 0.25, -- y
			r2_113, -- z
			r3_113, -- damage
			1250, -- idk
			r5_113[1], -- color r
			r5_113[2], -- g
			r5_113[3], -- b
			0,
			source
		}
	end
end)
addEvent("gotAirsoftFrag", true)
addEventHandler("gotAirsoftFrag", getRootElement(), function(r0_114)
	-- line: [4753, 4777] id: 114
	if getTickCount() - r130_0 > 15000 then
		r103_0 = 0
	end
	r130_0 = getTickCount()
	r103_0 = r103_0 + 1
	r104_0 = r0_114
	if r103_0 == 2 then
		playSound("files/special/double.mp3")
	elseif r103_0 == 3 then
		playSound("files/special/multi.mp3")
	elseif r103_0 == 4 then
		playSound("files/special/ultra.mp3")
	elseif r103_0 == 5 then
		playSound("files/special/fan.mp3")
	elseif r103_0 >= 6 then
		playSound("files/special/unb.mp3")
	elseif r104_0 then
		playSound("files/special/head.mp3")
	else
		playSound("files/kill.mp3")
	end
end)
local r157_0 = false
local r158_0 = false
local r159_0 = false
local r160_0 = 0
local r161_0 = 0
local r162_0 = 0
local r163_0 = false
function resultKey(r0_115)
	-- line: [4792, 4806] id: 115
	if r0_115 == "mouse_wheel_up" and r162_0 > 0 then
		r162_0 = r162_0 - 1
		refreshResultList(r163_0, r158_0, r162_0, r160_0, r161_0, false, not r159_0)
	elseif r0_115 == "mouse_wheel_down" and r162_0 < #r158_0 - #r163_0 then
		r162_0 = r162_0 + 1
		refreshResultList(r163_0, r158_0, r162_0, r160_0, r161_0, false, not r159_0)
	end
end
function deleteAirsoftResultWindow()
	-- line: [4808, 4815] id: 116
	r54_0(false)
	if r157_0 and exports.sGui:isGuiElementValid(r157_0) then
		sightexports.sGui:deleteGuiElement(r157_0)
	end
	r157_0 = nil
	r158_0 = false
	r163_0 = false
end
addEvent("deleteAirsoftResultWindow", true)
addEventHandler("deleteAirsoftResultWindow", getRootElement(), deleteAirsoftResultWindow)
function createResultWindow(r0_117, r1_117)
	-- line: [4819, 4879] id: 117
	if r157_0 and exports.sGui:isGuiElementValid(r157_0) then
		sightexports.sGui:deleteGuiElement(r157_0)
	end
	r157_0 = nil
	r54_0(true)
	local r2_117 = sightexports.sGui:getTitleBarHeight()
	local r3_117 = 0
	if r0_117 and r1_117 then
		r3_117 = sightexports.sGui:getFontHeight("22/BebasNeueBold.otf") + 6 + 16
	end
	local r4_117 = math.max(400, math.floor(r83_0 / 4 + 0.5))
	local r5_117 = math.floor(r84_0 * 0.6 + 0.5) + r3_117
	r157_0 = sightexports.sGui:createGuiElement("window", r83_0 / 2 - r4_117 / 2, r84_0 / 2 - r5_117 / 2, r4_117, r5_117)
	sightexports.sGui:setWindowTitle(r157_0, "16/BebasNeueRegular.otf", "Airsoft eredmény")
	sightexports.sGui:setWindowCloseButton(r157_0, "deleteAirsoftResultWindow")
	if r159_0 then
		local r6_117 = sightexports.sGui:getFontHeight("22/BebasNeueBold.otf") + 6
		local r7_117 = sightexports.sGui:getTextWidthFont("88888", "22/BebasNeueBold.otf") + 12
		local r8_117 = sightexports.sGui:createGuiElement("rectangle", r4_117 / 2 - r7_117 - 8, r2_117 + 8, r7_117, r6_117, r157_0)
		setGuiBackground(r8_117, "solid", "sightblue")
		local r9_117 = sightexports.sGui:createGuiElement("label", 0, 0, r7_117, r6_117, r8_117)
		sightexports.sGui:setLabelFont(r9_117, "22/BebasNeueBold.otf")
		sightexports.sGui:setLabelAlignment(r9_117, "center", "center")
		sightexports.sGui:setLabelText(r9_117, r0_117)
		local r10_117 = sightexports.sGui:createGuiElement("rectangle", r4_117 / 2 + 8, r2_117 + 8, r7_117, r6_117, r157_0)
		setGuiBackground(r10_117, "solid", "sightred")
		local r11_117 = sightexports.sGui:createGuiElement("label", 0, 0, r7_117, r6_117, r10_117)
		sightexports.sGui:setLabelFont(r11_117, "22/BebasNeueBold.otf")
		sightexports.sGui:setLabelAlignment(r11_117, "center", "center")
		sightexports.sGui:setLabelText(r11_117, r1_117)
	end
	local r6_117 = sightexports.sGui:createGuiElement("null", 0, r2_117 + r3_117, r4_117, r5_117 - r2_117 - r3_117, r157_0)
	local r7_117 = 0
	r163_0, r7_117 = createResultList(r4_117, r5_117 - r2_117 - r3_117, r6_117, not r159_0)
	r162_0 = 0
	r160_0 = r7_117 * #r163_0
	local r8_117 = sightexports.sGui:createGuiElement("rectangle", r4_117 - 3, r7_117, 3, r160_0, r6_117)
	setGuiBackground(r8_117, "solid", "sightgrey1")
	r161_0 = sightexports.sGui:createGuiElement("rectangle", 0, 0, 3, r160_0, r8_117)
	setGuiBackground(r161_0, "solid", "sightlightgrey")
	refreshResultList(r163_0, r158_0, r162_0, r160_0, r161_0, false, not r159_0)
end
addEvent("gotAirsoftMatchResults", true)
addEventHandler("gotAirsoftMatchResults", getRootElement(), function(r0_118, r1_118, r2_118)
	-- line: [4883, 4942] id: 118
	if r1_118 and r2_118 then
		r159_0 = true
		r158_0 = {}
		local r3_118 = 0
		local r4_118 = 0
		local r5_118 = 0
		local r6_118 = 0
		local r7_118 = 0
		local r8_118 = 0
		for r12_118 = 1, #r0_118, 1 do
			if r0_118[r12_118].team == 1 then
				r5_118 = r5_118 + r0_118[r12_118].k
				r7_118 = r7_118 + r0_118[r12_118].d
				r3_118 = r3_118 + 1
			else
				r6_118 = r6_118 + r0_118[r12_118].k
				r8_118 = r8_118 + r0_118[r12_118].d
				r4_118 = r4_118 + 1
			end
		end
		table.insert(r158_0, {
			name = "Kék csapat (" .. r3_118 .. ")",
			team = 0.5,
			k = r5_118,
			d = r7_118,
		})
		for r12_118 = 1, #r0_118, 1 do
			if r0_118[r12_118].team == 1 then
				table.insert(r158_0, r0_118[r12_118])
			end
		end
		table.insert(r158_0, {
			name = "Piros csapat (" .. r4_118 .. ")",
			team = 1.5,
			k = r6_118,
			d = r8_118,
		})
		for r12_118 = 1, #r0_118, 1 do
			if r0_118[r12_118].team == 2 then
				table.insert(r158_0, r0_118[r12_118])
			end
		end
	else
		r159_0 = false
		r158_0 = r0_118
	end
	createResultWindow(r1_118, r2_118)
end)
local r164_0 = false
function renderAirsoftWin()
	-- line: [4946, 5025] id: 119
	local r0_119 = getTickCount()
	local r1_119 = r0_119 - r164_0.start
	local r2_119 = math.min(1, r1_119 / 500)
	local r3_119 = math.min(1, math.max(0, (r1_119 - 1000) / 250))
	local r4_119 = 1 - math.min(1, math.max(0, (r1_119 - 4000) / 500))
	r2_119 = r2_119 * (1 - math.min(1, math.max(0, (r1_119 - 6000) / 500)))
	if r164_0.faded and r2_119 < 1 and not r164_0.im3 then
		playSound("files/impact3.mp3")
		r164_0.im3 = true
	elseif r2_119 >= 1 then
		r164_0.faded = true
	end
	if r2_119 <= 0 then
		r52_0(false)
		sightexports.sControls:toggleAllControls(true, "airsoftWin")
	else
		local r5_119 = 2560
		local r6_119 = 1440
		local r7_119 = math.max(r83_0 / r5_119, r84_0 / r6_119) * (1 + 0.1 * r1_119 / 6000)
		r5_119 = r5_119 * r7_119
		r6_119 = r6_119 * r7_119
		dxDrawImage(r83_0 / 2 - r5_119 / 2, r84_0 / 2 - r6_119 / 2, r5_119, r6_119, r19_0(airsoftMaps[r164_0.map].bigImage, "dxt1"), 0, 0, 0, tocolor(255, 255, 255, 255 * r2_119))
		local r8_119 = r84_0 / 2 * r2_119 - ((r27_0 * 1.5 + r31_0 * 0.85 * r4_119 + r31_0) / 2 - r27_0 * 1.5 / 2) * r3_119
		dxDrawText("SIGHTMTA AIRSOFT", r83_0 / 2 - r28_0 * 1.5 / 2, r8_119 - r27_0 / 2, 0, r8_119 - r27_0 / 2, tocolor(r46_0[1], r46_0[2], r46_0[3], 255 * r2_119), r23_0, r22_0, "left", "bottom")
		dxDrawText("NYEREMÉNYED", 0, r8_119, r83_0, r8_119, tocolor(r46_0[1], r46_0[2], r46_0[3], 255 * r2_119), r26_0 * 1.5, r25_0, "center", "center")
		if 0 < r3_119 and not r164_0.im2 then
			playSound("files/impact2.mp3")
			r164_0.im2 = true
		end
		r8_119 = r8_119 + r27_0 * 1.5 * r3_119
		local r9_119 = math.floor(r164_0.win * (1 - r4_119) + 0.5)
		if r164_0.wm ~= r9_119 then
			r164_0.wm = r9_119
			if not r164_0.mTick then
				playSound("files/money.mp3")
				r164_0.mTick = r0_119
			end
			if r0_119 - r164_0.mTick > 30 then
				playSound("files/moneycount.mp3")
				r164_0.mTick = r0_119
			end
		end
		local r11_119 = r164_0.win - r9_119
		local r12_119 = sightexports.sGui:thousandsStepper(r164_0.money + r9_119) .. " $"
		dxDrawText(r12_119, 0, r8_119, r83_0, r8_119, tocolor(255, 255, 255, 255 * r2_119 * r3_119), r30_0, r29_0, "center", "center")
		r8_119 = r8_119 + r31_0 * 0.85 * r3_119 * r4_119
		dxDrawText(sightexports.sGui:thousandsStepper(r11_119) .. " $", 0, r8_119, r83_0 / 2 + dxGetTextWidth(r12_119, r30_0, r29_0) / 2, r8_119, tocolor(r42_0[1], r42_0[2], r42_0[3], 255 * r2_119 * r3_119 * r4_119), r30_0, r29_0, "right", "center")
	end
end
addEvent("showAirsoftWin", true)
addEventHandler("showAirsoftWin", getRootElement(), function(r0_120, r1_120, r2_120)
	-- line: [5029, 5042] id: 120
	playSound("files/impact1.mp3")
	r164_0 = {
		start = getTickCount(),
		money = r1_120,
		win = r2_120,
		map = r0_120,
		wm = 0,
	}
	r52_0(true, "low-99999999999")
	sightexports.sControls:toggleAllControls(false, "airsoftWin")
end)


local tracers = {}
local maxTracers = 30 
local tracerWidth = 1.0 
local tracerColor = {255, 220, 0, 170} 
local trailLength = 3.5 
local tracerLifetime = 250 

function createBulletTracer(startX, startY, startZ, endX, endY, endZ, r, g, b)
    local now = getTickCount()
    
    local dx, dy, dz = endX - startX, endY - startY, endZ - startZ
    local distance = math.sqrt(dx*dx + dy*dy + dz*dz)
    
    local travelSpeed = 0.3
    local travelTime = distance / travelSpeed
    
    travelTime = math.max(150, math.min(800, travelTime))
    
    local tracer = {
        startX = startX,
        startY = startY,
        startZ = startZ,
        endX = endX,
        endY = endY,
        endZ = endZ,
        distance = distance,
        startTime = now,
        travelTime = travelTime,
        endTime = now + travelTime + tracerLifetime,
		color = {r, g, b, 170}
    }
    
    table.insert(tracers, 1, tracer)
    
    while #tracers > maxTracers do
        table.remove(tracers)
    end
    
    return true
end


addEventHandler("onClientRender", root, function()
    local now = getTickCount()
    
    for i = #tracers, 1, -1 do
        local t = tracers[i]
        
        if now > t.endTime then
            table.remove(tracers, i)
        else
            local elapsed = now - t.startTime
            local progress = math.min(1.0, elapsed / t.travelTime)
            
            local tipX = t.startX + (t.endX - t.startX) * progress
            local tipY = t.startY + (t.endY - t.startY) * progress
            local tipZ = t.startZ + (t.endZ - t.startZ) * progress
            
            local dirX = (t.endX - t.startX) / t.distance
            local dirY = (t.endY - t.startY) / t.distance
            local dirZ = (t.endZ - t.startZ) / t.distance
            
            local distanceTraveled = t.distance * progress
            
            local effectiveTrailLength = math.min(trailLength, distanceTraveled)
            
            local tailX = tipX - dirX * effectiveTrailLength
            local tailY = tipY - dirY * effectiveTrailLength
            local tailZ = tipZ - dirZ * effectiveTrailLength
            
            local alpha = t.color[4]
            if progress >= 1.0 then
                local fadeProgress = 1.0 - ((now - (t.startTime + t.travelTime)) / tracerLifetime)
                alpha = alpha * math.max(0, fadeProgress)
            end
            
            dxDrawLine3D(
                tailX, tailY, tailZ,
                tipX, tipY, tipZ,
                tocolor(t.color[1], t.color[2], t.color[3], alpha),
                tracerWidth
            )
        end
    end
end)

addEventHandler("onClientPlayerWeaponFire", root, function(weapon, ammo, ammoInClip, hitX, hitY, hitZ, hitElement)

	if isInMatch() then
		local gunX, gunY, gunZ = getPedWeaponMuzzlePosition(source)
		
		if not gunX then
			local boneX, boneY, boneZ = getPedBonePosition(source, 25)
			if boneX then
				gunX, gunY, gunZ = boneX, boneY, boneZ
			else
				gunX, gunY, gunZ = getElementPosition(source)
				gunZ = gunZ + 0.5
			end
		end
		
		local targetX, targetY, targetZ
		
		if hitX and hitY and hitZ then
			targetX, targetY, targetZ = hitX, hitY, hitZ
		else
			local px, py, pz, lookX, lookY, lookZ = getCameraMatrix()
			local dist = 100
			
			local dx = lookX - px
			local dy = lookY - py
			local dz = lookZ - pz
			
			local len = math.sqrt(dx*dx + dy*dy + dz*dz)
			dx, dy, dz = dx/len, dy/len, dz/len
			
			targetX = gunX + dx * dist
			targetY = gunY + dy * dist
			targetZ = gunZ + dz * dist
		end

		color = {49, 154, 215}

		for k, v in pairs(r147_0.playerDatas) do
			if v.client == source then
				if v.team and v.team == 1 then
					color = {49, 154, 215}
				elseif v.team and v.team == 2 then
					color = {195, 22, 32}
				else
					color = {3, 252, 107}
				end
			end
		end
		
		createBulletTracer(gunX, gunY, gunZ, targetX, targetY, targetZ, color[1], color[2], color[3])
	end
end)

function setGuiBackground(el, backgroundType, color)
	if sightexports.sGui:isGuiElementValid(el) then
		sightexports.sGui:setGuiBackground(el, backgroundType, color)
	end
end