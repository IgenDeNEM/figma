-- filename:
-- version: lua51
-- line: [0, 0] id: 0
local seexports = {
	sGui = false,
	sTrading = false,
	sChat = false,
}
local function r1_0()
	-- line: [1, 1] id: 1
	for r3_1 in pairs(seexports) do
		local r4_1 = getResourceFromName(r3_1)
		if r4_1 and getResourceState(r4_1) == "running" then
			seexports[r3_1] = exports[r3_1]
		else
			seexports[r3_1] = false
		end
	end
end
r1_0()
if triggerServerEvent then
	addEventHandler("onClientResourceStart", getRootElement(), r1_0, true, "high+9999999999")
end
if triggerClientEvent then
	addEventHandler("onResourceStart", getRootElement(), r1_0, true, "high+9999999999")
end
local r2_0 = false
local seelangStaticImage = {}
local seelangStaticImageToc = {}
local seelangStaticImageUsed = {}
local r6_0 = {}
local processSeelangStaticImage = {}
seelangStaticImageToc[0] = true
seelangStaticImageToc[1] = true
seelangStaticImageToc[2] = true
seelangStaticImageToc[3] = true
seelangStaticImageToc[4] = true
seelangStaticImageToc[5] = true
seelangStaticImageToc[6] = true
seelangStaticImageToc[7] = true
seelangStaticImageToc[8] = true
seelangStaticImageToc[9] = true
seelangStaticImageToc[10] = true
seelangStaticImageToc[11] = true
seelangStaticImageToc[12] = true
local r8_0 = nil
function r8_0()
	-- line: [1, 1] id: 2
	local r0_2 = getTickCount()
	if seelangStaticImageUsed[0] then
		seelangStaticImageUsed[0] = false
		r6_0[0] = false
	elseif seelangStaticImage[0] then
		if r6_0[0] then
			if r6_0[0] <= r0_2 then
				if isElement(seelangStaticImage[0]) then
					destroyElement(seelangStaticImage[0])
				end
				seelangStaticImage[0] = nil
				r6_0[0] = false
				seelangStaticImageToc[0] = true
				return
			end
		else
			r6_0[0] = r0_2 + 5000
		end
	else
		seelangStaticImageToc[0] = true
	end
	if seelangStaticImageUsed[1] then
		seelangStaticImageUsed[1] = false
		r6_0[1] = false
	elseif seelangStaticImage[1] then
		if r6_0[1] then
			if r6_0[1] <= r0_2 then
				if isElement(seelangStaticImage[1]) then
					destroyElement(seelangStaticImage[1])
				end
				seelangStaticImage[1] = nil
				r6_0[1] = false
				seelangStaticImageToc[1] = true
				return
			end
		else
			r6_0[1] = r0_2 + 5000
		end
	else
		seelangStaticImageToc[1] = true
	end
	if seelangStaticImageUsed[2] then
		seelangStaticImageUsed[2] = false
		r6_0[2] = false
	elseif seelangStaticImage[2] then
		if r6_0[2] then
			if r6_0[2] <= r0_2 then
				if isElement(seelangStaticImage[2]) then
					destroyElement(seelangStaticImage[2])
				end
				seelangStaticImage[2] = nil
				r6_0[2] = false
				seelangStaticImageToc[2] = true
				return
			end
		else
			r6_0[2] = r0_2 + 5000
		end
	else
		seelangStaticImageToc[2] = true
	end
	if seelangStaticImageUsed[3] then
		seelangStaticImageUsed[3] = false
		r6_0[3] = false
	elseif seelangStaticImage[3] then
		if r6_0[3] then
			if r6_0[3] <= r0_2 then
				if isElement(seelangStaticImage[3]) then
					destroyElement(seelangStaticImage[3])
				end
				seelangStaticImage[3] = nil
				r6_0[3] = false
				seelangStaticImageToc[3] = true
				return
			end
		else
			r6_0[3] = r0_2 + 5000
		end
	else
		seelangStaticImageToc[3] = true
	end
	if seelangStaticImageUsed[4] then
		seelangStaticImageUsed[4] = false
		r6_0[4] = false
	elseif seelangStaticImage[4] then
		if r6_0[4] then
			if r6_0[4] <= r0_2 then
				if isElement(seelangStaticImage[4]) then
					destroyElement(seelangStaticImage[4])
				end
				seelangStaticImage[4] = nil
				r6_0[4] = false
				seelangStaticImageToc[4] = true
				return
			end
		else
			r6_0[4] = r0_2 + 5000
		end
	else
		seelangStaticImageToc[4] = true
	end
	if seelangStaticImageUsed[5] then
		seelangStaticImageUsed[5] = false
		r6_0[5] = false
	elseif seelangStaticImage[5] then
		if r6_0[5] then
			if r6_0[5] <= r0_2 then
				if isElement(seelangStaticImage[5]) then
					destroyElement(seelangStaticImage[5])
				end
				seelangStaticImage[5] = nil
				r6_0[5] = false
				seelangStaticImageToc[5] = true
				return
			end
		else
			r6_0[5] = r0_2 + 5000
		end
	else
		seelangStaticImageToc[5] = true
	end
	if seelangStaticImageUsed[6] then
		seelangStaticImageUsed[6] = false
		r6_0[6] = false
	elseif seelangStaticImage[6] then
		if r6_0[6] then
			if r6_0[6] <= r0_2 then
				if isElement(seelangStaticImage[6]) then
					destroyElement(seelangStaticImage[6])
				end
				seelangStaticImage[6] = nil
				r6_0[6] = false
				seelangStaticImageToc[6] = true
				return
			end
		else
			r6_0[6] = r0_2 + 5000
		end
	else
		seelangStaticImageToc[6] = true
	end
	if seelangStaticImageUsed[7] then
		seelangStaticImageUsed[7] = false
		r6_0[7] = false
	elseif seelangStaticImage[7] then
		if r6_0[7] then
			if r6_0[7] <= r0_2 then
				if isElement(seelangStaticImage[7]) then
					destroyElement(seelangStaticImage[7])
				end
				seelangStaticImage[7] = nil
				r6_0[7] = false
				seelangStaticImageToc[7] = true
				return
			end
		else
			r6_0[7] = r0_2 + 5000
		end
	else
		seelangStaticImageToc[7] = true
	end
	if seelangStaticImageUsed[8] then
		seelangStaticImageUsed[8] = false
		r6_0[8] = false
	elseif seelangStaticImage[8] then
		if r6_0[8] then
			if r6_0[8] <= r0_2 then
				if isElement(seelangStaticImage[8]) then
					destroyElement(seelangStaticImage[8])
				end
				seelangStaticImage[8] = nil
				r6_0[8] = false
				seelangStaticImageToc[8] = true
				return
			end
		else
			r6_0[8] = r0_2 + 5000
		end
	else
		seelangStaticImageToc[8] = true
	end
	if seelangStaticImageUsed[9] then
		seelangStaticImageUsed[9] = false
		r6_0[9] = false
	elseif seelangStaticImage[9] then
		if r6_0[9] then
			if r6_0[9] <= r0_2 then
				if isElement(seelangStaticImage[9]) then
					destroyElement(seelangStaticImage[9])
				end
				seelangStaticImage[9] = nil
				r6_0[9] = false
				seelangStaticImageToc[9] = true
				return
			end
		else
			r6_0[9] = r0_2 + 5000
		end
	else
		seelangStaticImageToc[9] = true
	end
	if seelangStaticImageUsed[10] then
		seelangStaticImageUsed[10] = false
		r6_0[10] = false
	elseif seelangStaticImage[10] then
		if r6_0[10] then
			if r6_0[10] <= r0_2 then
				if isElement(seelangStaticImage[10]) then
					destroyElement(seelangStaticImage[10])
				end
				seelangStaticImage[10] = nil
				r6_0[10] = false
				seelangStaticImageToc[10] = true
				return
			end
		else
			r6_0[10] = r0_2 + 5000
		end
	else
		seelangStaticImageToc[10] = true
	end
	if seelangStaticImageUsed[11] then
		seelangStaticImageUsed[11] = false
		r6_0[11] = false
	elseif seelangStaticImage[11] then
		if r6_0[11] then
			if r6_0[11] <= r0_2 then
				if isElement(seelangStaticImage[11]) then
					destroyElement(seelangStaticImage[11])
				end
				seelangStaticImage[11] = nil
				r6_0[11] = false
				seelangStaticImageToc[11] = true
				return
			end
		else
			r6_0[11] = r0_2 + 5000
		end
	else
		seelangStaticImageToc[11] = true
	end
	if seelangStaticImageUsed[12] then
		seelangStaticImageUsed[12] = false
		r6_0[12] = false
	elseif seelangStaticImage[12] then
		if r6_0[12] then
			if r6_0[12] <= r0_2 then
				if isElement(seelangStaticImage[12]) then
					destroyElement(seelangStaticImage[12])
				end
				seelangStaticImage[12] = nil
				r6_0[12] = false
				seelangStaticImageToc[12] = true
				return
			end
		else
			r6_0[12] = r0_2 + 5000
		end
	else
		seelangStaticImageToc[12] = true
	end
	if seelangStaticImageToc[0] and seelangStaticImageToc[1] and seelangStaticImageToc[2] and seelangStaticImageToc[3] and seelangStaticImageToc[4] and seelangStaticImageToc[5] and seelangStaticImageToc[6] and seelangStaticImageToc[7] and seelangStaticImageToc[8] and seelangStaticImageToc[9] and seelangStaticImageToc[10] and seelangStaticImageToc[11] and seelangStaticImageToc[12] then
		r2_0 = false
		removeEventHandler("onClientPreRender", getRootElement(), r8_0)
	end
end
processSeelangStaticImage[0] = function()
	-- line: [1, 1] id: 3
	if not isElement(seelangStaticImage[0]) then
		seelangStaticImageToc[0] = false
		seelangStaticImage[0] = dxCreateTexture("files/m1.dds", "argb", true)
	end
	if not r2_0 then
		r2_0 = true
		addEventHandler("onClientPreRender", getRootElement(), r8_0, true, "high+999999999")
	end
end
processSeelangStaticImage[1] = function()
	-- line: [1, 1] id: 4
	if not isElement(seelangStaticImage[1]) then
		seelangStaticImageToc[1] = false
		seelangStaticImage[1] = dxCreateTexture("files/m2.dds", "argb", true)
	end
	if not r2_0 then
		r2_0 = true
		addEventHandler("onClientPreRender", getRootElement(), r8_0, true, "high+999999999")
	end
end
processSeelangStaticImage[2] = function()
	-- line: [1, 1] id: 5
	if not isElement(seelangStaticImage[2]) then
		seelangStaticImageToc[2] = false
		seelangStaticImage[2] = dxCreateTexture("files/m4.dds", "argb", true)
	end
	if not r2_0 then
		r2_0 = true
		addEventHandler("onClientPreRender", getRootElement(), r8_0, true, "high+999999999")
	end
end
processSeelangStaticImage[3] = function()
	-- line: [1, 1] id: 6
	if not isElement(seelangStaticImage[3]) then
		seelangStaticImageToc[3] = false
		seelangStaticImage[3] = dxCreateTexture("files/m5.dds", "argb", true)
	end
	if not r2_0 then
		r2_0 = true
		addEventHandler("onClientPreRender", getRootElement(), r8_0, true, "high+999999999")
	end
end
processSeelangStaticImage[4] = function()
	-- line: [1, 1] id: 7
	if not isElement(seelangStaticImage[4]) then
		seelangStaticImageToc[4] = false
		seelangStaticImage[4] = dxCreateTexture("files/m6.dds", "argb", true)
	end
	if not r2_0 then
		r2_0 = true
		addEventHandler("onClientPreRender", getRootElement(), r8_0, true, "high+999999999")
	end
end
processSeelangStaticImage[5] = function()
	-- line: [1, 1] id: 8
	if not isElement(seelangStaticImage[5]) then
		seelangStaticImageToc[5] = false
		seelangStaticImage[5] = dxCreateTexture("files/clogo.dds", "argb", true)
	end
	if not r2_0 then
		r2_0 = true
		addEventHandler("onClientPreRender", getRootElement(), r8_0, true, "high+999999999")
	end
end
processSeelangStaticImage[6] = function()
	-- line: [1, 1] id: 9
	if not isElement(seelangStaticImage[6]) then
		seelangStaticImageToc[6] = false
		seelangStaticImage[6] = dxCreateTexture("files/silo.dds", "argb", true)
	end
	if not r2_0 then
		r2_0 = true
		addEventHandler("onClientPreRender", getRootElement(), r8_0, true, "high+999999999")
	end
end
processSeelangStaticImage[7] = function()
	-- line: [1, 1] id: 10
	if not isElement(seelangStaticImage[7]) then
		seelangStaticImageToc[7] = false
		seelangStaticImage[7] = dxCreateTexture("files/smelter.dds", "argb", true)
	end
	if not r2_0 then
		r2_0 = true
		addEventHandler("onClientPreRender", getRootElement(), r8_0, true, "high+999999999")
	end
end
processSeelangStaticImage[8] = function()
	-- line: [1, 1] id: 11
	if not isElement(seelangStaticImage[8]) then
		seelangStaticImageToc[8] = false
		seelangStaticImage[8] = dxCreateTexture("files/m3.dds", "argb", true)
	end
	if not r2_0 then
		r2_0 = true
		addEventHandler("onClientPreRender", getRootElement(), r8_0, true, "high+999999999")
	end
end
processSeelangStaticImage[9] = function()
	-- line: [1, 1] id: 12
	if not isElement(seelangStaticImage[9]) then
		seelangStaticImageToc[9] = false
		seelangStaticImage[9] = dxCreateTexture("files/comb.dds", "argb", true)
	end
	if not r2_0 then
		r2_0 = true
		addEventHandler("onClientPreRender", getRootElement(), r8_0, true, "high+999999999")
	end
end
processSeelangStaticImage[10] = function()
	-- line: [1, 1] id: 13
	if not isElement(seelangStaticImage[10]) then
		seelangStaticImageToc[10] = false
		seelangStaticImage[10] = dxCreateTexture("files/comf.dds", "argb", true)
	end
	if not r2_0 then
		r2_0 = true
		addEventHandler("onClientPreRender", getRootElement(), r8_0, true, "high+999999999")
	end
end
processSeelangStaticImage[11] = function()
	-- line: [1, 1] id: 14
	if not isElement(seelangStaticImage[11]) then
		seelangStaticImageToc[11] = false
		seelangStaticImage[11] = dxCreateTexture("files/tabb.dds", "argb", true)
	end
	if not r2_0 then
		r2_0 = true
		addEventHandler("onClientPreRender", getRootElement(), r8_0, true, "high+999999999")
	end
end
processSeelangStaticImage[12] = function()
	-- line: [1, 1] id: 15
	if not isElement(seelangStaticImage[12]) then
		seelangStaticImageToc[12] = false
		seelangStaticImage[12] = dxCreateTexture("files/tabf.dds", "argb", true)
	end
	if not r2_0 then
		r2_0 = true
		addEventHandler("onClientPreRender", getRootElement(), r8_0, true, "high+999999999")
	end
end
local r9_0 = false
local r10_0 = falselocal
seelangDynImage = {}
local r11_0 = {}
local r12_0 = {}
local r13_0 = {}
local r14_0 = {}
local r15_0 = nil
function r15_0()
	-- line: [1, 1] id: 16
	local r0_16 = getTickCount()
	r10_0 = true
	local r1_16 = true
	for r5_16 in pairs(seelangDynImage) do
		r1_16 = false
		if r14_0[r5_16] and r14_0[r5_16] <= r0_16 then
			if isElement(seelangDynImage[r5_16]) then
				destroyElement(seelangDynImage[r5_16])
			end
			seelangDynImage[r5_16] = nil
			r11_0[r5_16] = nil
			r12_0[r5_16] = nil
			r14_0[r5_16] = nil
			break
		elseif not r13_0[r5_16] then
			r14_0[r5_16] = r0_16 + 5000
		end
	end
	for r5_16 in pairs(r13_0) do
		if not seelangDynImage[r5_16] and r10_0 then
			r10_0 = false
			seelangDynImage[r5_16] = dxCreateTexture(r5_16, r11_0[r5_16], r12_0[r5_16])
		end
		r13_0[r5_16] = nil
		r14_0[r5_16] = nil
		r1_16 = false
	end
	if r1_16 then
		removeEventHandler("onClientPreRender", getRootElement(), r15_0)
		r9_0 = false
	end
end
local function dynamicImage(r0_17, r1_17, r2_17)
	-- line: [1, 1] id: 17
	if not r9_0 then
		r9_0 = true
		addEventHandler("onClientPreRender", getRootElement(), r15_0, true, "high+999999999")
	end
	if not seelangDynImage[r0_17] then
		seelangDynImage[r0_17] = dxCreateTexture(r0_17, r1_17, r2_17)
	end
	r11_0[r0_17] = r1_17
	r13_0[r0_17] = true
	return seelangDynImage[r0_17]
end
local r17_0 = false
local function checkPreRenderMinePermissionChange(r0_18, r1_18)
	-- line: [1, 1] id: 18
	if r0_18 then
		r0_18 = true
	else
		r0_18 = false
	end
	if r0_18 ~= r17_0 then
		r17_0 = r0_18
		if r0_18 then
			addEventHandler("onClientPreRender", getRootElement(), preRenderMinePermissionChange, true, r1_18)
		else
			removeEventHandler("onClientPreRender", getRootElement(), preRenderMinePermissionChange)
		end
	end
end
local r19_0 = false
local function checkPreRenderComputer(r0_19, r1_19)
	-- line: [1, 1] id: 19
	if r0_19 then
		r0_19 = true or false
	else
		-- goto label_5	-- block#2 is visited secondly
	end
	if r0_19 ~= r19_0 then
		r19_0 = r0_19
		if r0_19 then
			addEventHandler("onClientPreRender", getRootElement(), preRenderComputer, true, r1_19)
		else
			removeEventHandler("onClientPreRender", getRootElement(), preRenderComputer)
		end
	end
end
local r21_0 = false
local function checkOnHomeForexUpdate(r0_20, r1_20)
	-- line: [1, 1] id: 20
	if r0_20 then
		r0_20 = true or false
	else
		-- goto label_5	-- block#2 is visited secondly
	end
	if r0_20 ~= r21_0 then
		r21_0 = r0_20
		if r0_20 then
			addEventHandler("onForexUpdate", getRootElement(), onHomeForexUpdate, true, r1_20)
		else
			removeEventHandler("onForexUpdate", getRootElement(), onHomeForexUpdate)
		end
	end
end
local r23_0 = false
local function checkMineTableKey(r0_21, r1_21)
	-- line: [1, 1] id: 21
	if r0_21 then
		r0_21 = true or false
	else
		-- goto label_5	-- block#2 is visited secondly
	end
	if r0_21 ~= r23_0 then
		r23_0 = r0_21
		if r0_21 then
			addEventHandler("onClientKey", getRootElement(), mineTableKey, true, r1_21)
		else
			removeEventHandler("onClientKey", getRootElement(), mineTableKey)
		end
	end
end
local r25_0 = false
local function checkMineTableCharacter(r0_22, r1_22)
	-- line: [1, 1] id: 22
	if r0_22 then
		r0_22 = true or false
	else
		-- goto label_5	-- block#2 is visited secondly
	end
	if r0_22 ~= r25_0 then
		r25_0 = r0_22
		if r0_22 then
			addEventHandler("onClientCharacter", getRootElement(), mineTableCharacter, true, r1_22)
		else
			removeEventHandler("onClientCharacter", getRootElement(), mineTableCharacter)
		end
	end
end
local r27_0 = false
local function checkAddWorkerKey(r0_23, r1_23)
	-- line: [1, 1] id: 23
	if r0_23 then
		r0_23 = true or false
	else
		-- goto label_5	-- block#2 is visited secondly
	end
	if r0_23 ~= r27_0 then
		r27_0 = r0_23
		if r0_23 then
			addEventHandler("onClientKey", getRootElement(), addWorkerKey, true, r1_23)
		else
			removeEventHandler("onClientKey", getRootElement(), addWorkerKey)
		end
	end
end
local r29_0 = false
local function checkAddWorkerCharacter(r0_24, r1_24)
	-- line: [1, 1] id: 24
	if r0_24 then
		r0_24 = true or false
	else
		-- goto label_5	-- block#2 is visited secondly
	end
	if r0_24 ~= r29_0 then
		r29_0 = r0_24
		if r0_24 then
			addEventHandler("onClientCharacter", getRootElement(), addWorkerCharacter, true, r1_24)
		else
			removeEventHandler("onClientCharacter", getRootElement(), addWorkerCharacter)
		end
	end
end
local r31_0 = false
local function checkRestoreTablet(r0_25, r1_25)
	-- line: [1, 1] id: 25
	if r0_25 then
		r0_25 = true or false
	else
		-- goto label_5	-- block#2 is visited secondly
	end
	if r0_25 ~= r31_0 then
		r31_0 = r0_25
		if r0_25 then
			addEventHandler("onClientRestore", getRootElement(), restoreTablet, true, r1_25)
		else
			removeEventHandler("onClientRestore", getRootElement(), restoreTablet)
		end
	end
end
local r33_0 = false
local function checkRenderTablet(r0_26, r1_26)
	-- line: [1, 1] id: 26
	if r0_26 then
		r0_26 = true or false
	else
		-- goto label_5	-- block#2 is visited secondly
	end
	if r0_26 ~= r33_0 then
		r33_0 = r0_26
		if r0_26 then
			addEventHandler("onClientRender", getRootElement(), renderTablet, true, r1_26)
		else
			removeEventHandler("onClientRender", getRootElement(), renderTablet)
		end
	end
end
local r35_0 = false
local function checkClickTablet(r0_27, r1_27)
	-- line: [1, 1] id: 27
	if r0_27 then
		r0_27 = true or false
	else
		-- goto label_5	-- block#2 is visited secondly
	end
	if r0_27 ~= r35_0 then
		r35_0 = r0_27
		if r0_27 then
			addEventHandler("onClientClick", getRootElement(), clickTablet, true, r1_27)
		else
			removeEventHandler("onClientClick", getRootElement(), clickTablet)
		end
	end
end
local crtShaderSource = [[
		texture sBaseTexture;

		sampler Samp = sampler_state
		{
				Texture = (sBaseTexture);
				AddressU = MIRROR;
				AddressV = MIRROR;
		};

		float crtOverscan = 0.1;
	float crtBend = 8;

	float2 crt(float2 coord)
	{
		// put in symmetrical coords
		coord = (coord - 0.5) * 2.0 / (crtOverscan + 1.0);

		coord *= 1.1;

		// deform coords
		coord.x *= 1.0 + pow((abs(coord.y) / crtBend), 2.0);
		coord.y *= 1.0 + pow((abs(coord.x) / crtBend), 2.0);

		// transform back to 0.0 - 1.0 space
		coord  = (coord / 2.0) + 0.5;

		return saturate(coord);
	}


		float blur = 0.00125;

		float4 PixelShaderFunction(float2 uv : TEXCOORD) : COLOR
	{
				float4 input = tex2D(Samp, crt(uv));

				float4 bv = input;

				for (float i = 1; i < 4; i++) {
						bv += tex2D(Samp, crt(float2(uv.x, uv.y + (i * blur))));
						bv += tex2D(Samp, crt(float2(uv.x, uv.y - (i * blur))));
						bv += tex2D(Samp, crt(float2(uv.x - (i * blur), uv.y)));
						bv += tex2D(Samp, crt(float2(uv.x + (i * blur), uv.y)));
				}

				bv /= 9;

				float4 outputColor =
						(float4(0, 1, 0.65, 1)*bv.r)+
						(float4(1, 0.8, 0, 1)*bv.g)+
						(float4(1, 0.25, 0, 1)*bv.b);

				outputColor +=
						float4(0.1, 0.9, 0.35, 1)*input.r*0.75+
						float4(0.65, 0.5, 0, 1)*input.g*0.75+
						float4(0.65, 0.12, 0.0, 1)*input.b*0.75;

				float b = saturate(min(1-abs(uv.x-0.5)*2, 1-abs(uv.y-0.5)*2)*10);

		//return float4(1, 0, 0, 1)*b;
		return saturate(outputColor)*b;
	}

	technique tablet
	{
		pass P0
		{
			PixelShader = compile ps_2_a PixelShaderFunction();
		}
	}
]]
local currentNameLine = false
local mineNameEdited = false
local mineNameSyncing = false
currentMineName = {}
local tabletDrawn = false
forceTabletDraw = true
local dosFont = false
local dosBoldFont = false
local dosFontHeight = false
local tabletRT = false
local tabletShader = false
local tabletState = false
local computerState = false
local tempHoverAction = false
local tempHoverActionArg = false
mineOrdering = {}
currentMineOrder = false
currentMineOrderPaid = false
mineOrderSyncing = false
function deInitTablet()
	-- line: [102, 127] id: 28
	seexports.sGui:setCursorType("normal")
	seexports.sGui:showTooltip()
	currentNameLine = false
	mineOrdering = {}
	checkClickTablet(false)
	checkRenderTablet(false)
	checkRestoreTablet(false)
	if isElement(dosFont) then
		destroyElement(dosFont)
	end
	dosFont = nil
	if isElement(dosBoldFont) then
		destroyElement(dosBoldFont)
	end
	dosBoldFont = nil
	if isElement(tabletRT) then
		destroyElement(tabletRT)
	end
	tabletRT = nil
	if isElement(tabletShader) then
		destroyElement(tabletShader)
	end
	tabletShader = nil
	checkAddWorkerCharacter(false)
	checkAddWorkerKey(false)
	checkMineTableCharacter(false)
	checkMineTableKey(false)
	dosFontHeight = false
	seexports.sTrading:setForexSubscription(false)
	checkOnHomeForexUpdate(false)
end
local currentMenu = false
local workerToFire = false
local workerToRegister = false
local workerNameToRegister = false
function setCurrentTabletMenu(menu)
	-- line: [135, 157] id: 29
	currentMenu = menu
	if currentMenu == "permissions" then
		workerToFire = false
		workerToRegister = false
		workerNameToRegister = false
	else
		checkAddWorkerCharacter(false)
		checkAddWorkerKey(false)
	end
	if currentMenu == "home" then
		seexports.sTrading:setForexSubscription("all")
		checkOnHomeForexUpdate(true)
		onHomeForexUpdate()
	else
		seexports.sTrading:setForexSubscription(false)
		checkOnHomeForexUpdate(false)
	end
	forceTabletDraw = true
end
function initTablet()
	-- line: [160, 183] id: 30
	deInitTablet()
	forceTabletDraw = true
	tempHoverAction = false
	tempHoverActionArg = false
	checkClickTablet(true)
	checkRenderTablet(true, "normal-1")
	checkRestoreTablet(true)
	dosFont = dxCreateFont("files/dos.ttf", 16)
	dosBoldFont = dxCreateFont("files/dos.ttf", 16, true)
	dosFontHeight = dxGetFontHeight(1, dosFont)
	tabletRT = dxCreateRenderTarget(800, 600)
	tabletShader = dxCreateShader(crtShaderSource)
	dxSetShaderValue(tabletShader, "sBaseTexture", tabletRT)
	if not currentMenu then
		setCurrentTabletMenu("home")
	end
end
local tabletPosX = screenX / 2
local tabletPosY = screenY / 2
local tabletZoom = 1
local tabletMoving = false
function saveTabletZoom()
	-- line: [189, 197] id: 31
	if fileExists("!mine_tablet_zoom.see") then
		fileDelete("!mine_tablet_zoom.see")
	end
	local file = fileCreate("!mine_tablet_zoom.see")
	fileWrite(file, tostring(tabletZoom))
	fileClose(file)
end
function saveTabletPos()
	-- line: [199, 207] id: 32
	if fileExists("!mine_tablet_pos.see") then
		fileDelete("!mine_tablet_pos.see")
	end
	local file = fileCreate("!mine_tablet_pos.see")
	fileWrite(file, tostring(tabletPosX) .. "," .. tostring(tabletPosY))
	fileClose(file)
end
function endTabletMoving()
	-- line: [209, 217] id: 33
	if tabletMoving then
		tabletMoving = false
		saveTabletPos()
		seexports.sGui:setCursorType("normal")
	end
end
addEventHandler("onClientResourceStart", getResourceRootElement(), function()
	-- line: [220, 244] id: 34
	if fileExists("!mine_tablet_pos.see") then
		local file = fileOpen("!mine_tablet_pos.see")
		local data = fileRead(file, fileGetSize(file))
		fileClose(file)
		tabletPosX = tonumber(split(data, ",")[1]) or screenX / 2
		tabletPosY = tonumber(split(data, ",")[2]) or screenY / 2
		tabletPosX = math.max(0, math.min(screenX, tabletPosX))
		tabletPosY = math.max(0, math.min(screenY, tabletPosY))
	end
	if fileExists("!mine_tablet_zoom.see") then
		local file = fileOpen("!mine_tablet_zoom.see")
		local data = fileRead(file, fileGetSize(file))
		fileClose(file)
		tabletZoom = math.max(0.5, math.min(1, tonumber(data) or 1))
	end
end)
function deleteTablet()
	-- line: [246, 253] id: 35
	tabletState = false
	endTabletMoving()
	if not tabletState and not computerState then
		deInitTablet()
	end
end
function deleteComputer()
	-- line: [255, 265] id: 36
	if computerState then
		seexports.sChat:localActionC(localPlayer, "kikapcsolta a számítógépet.")
	end
	computerState = false
	if not tabletState and not computerState then
		deInitTablet()
	end
end
function createTablet()
	-- line: [267, 277] id: 37
	if currentMine then
		if not tabletState and not computerState then
			initTablet()
		end
		tabletState = true
		return true
	end
end
local computerLoadingProgress = 0
local computerLoopSound = 0
function createComputer()
	-- line: [282, 302] id: 38
	if not tabletState and not computerState then
		initTablet()
	end
	if computerLoadingProgress < 1 then
		playSound("files/minesound/compon.wav")
	end
	if not computerState then
		seexports.sChat:localActionC(localPlayer, "bekapcsolta a számítógépet.")
	end
	computerState = true
	checkPreRenderComputer(true)
	if not isElement(computerLoopSound) then
		computerLoopSound = playSound("files/minesound/comploop.wav", true)
		setSoundVolume(computerLoopSound, 0)
	end
end
local mapPresetAt = {}
function setPresetMap(x, y, type, rot)
	-- line: [307, 313] id: 39
	if not mapPresetAt[x] then
		mapPresetAt[x] = {}
	end
	mapPresetAt[x][y] = {type, rot}
end
setPresetMap(-2, 0, 12, 90)
setPresetMap(-2, -2, 11, 90)
setPresetMap(-2, -1, 10, 90)
setPresetMap(-2, 1, 10, 90)
setPresetMap(-2, 2, 11, 0)
for x = 3, 5, 1 do
	setPresetMap(-x, -2, 10, 180)
	setPresetMap(-x, 2, 10, 0)
end
setPresetMap(-6, 0, 12, 270)
setPresetMap(-7, 0, 4, 180)
setPresetMap(-6, 2, 11, 270)
setPresetMap(-6, 1, 10, 270)
setPresetMap(-6, -1, 10, 270)
setPresetMap(-6, -2, 11, 180)
tabletHovering = false
local hoverAction = false
local hoverActionArg = false
local mapData = {
	zoom = 1,
	mx = false,
	my = false,
}
function mineTableKey(keyName, isPressed)
	-- line: [346, 389] id: 40
	if isPressed then
		if keyName == "backspace" then
			if currentMineName[currentNameLine] then
				if utf8.len(currentMineName[currentNameLine]) <= 0 and currentNameLine > 1 then
					currentMineName[currentNameLine] = nil
					currentNameLine = currentNameLine - 1
					mineNameEdited = true
				else
					currentMineName[currentNameLine] = utf8.sub(currentMineName[currentNameLine], 1, utf8.len(currentMineName[currentNameLine]) - 1)
					mineNameEdited = true
				end
				forceTabletDraw = true
			end
		elseif keyName == "arrow_u" and currentNameLine > 1 then
			if currentNameLine and utf8.len(currentMineName[currentNameLine]) <= 0 then
				currentMineName[currentNameLine] = nil
				mineNameEdited = true
			end
			currentNameLine = currentNameLine - 1
			forceTabletDraw = true
		elseif keyName == "enter" or keyName == "arrow_d" then
			if currentNameLine < 2 then
				currentNameLine = currentNameLine + 1
				if not currentMineName[currentNameLine] then
					currentMineName[currentNameLine] = ""
					mineNameEdited = true
				end
				forceTabletDraw = true
			else
				endMineNameEdit()
			end
		end
	end
	cancelEvent()
end
function tabletRegisterNext()
	-- line: [391, 445] id: 41
	local targetName = utf8.lower(workerNameToRegister):gsub("_", " ")
	if utf8.len(targetName) <= 0 then
		return
	end
	local foundPlayer = false
	local onlinePlayers = getElementsByType("player")
	if tonumber(targetName) then
		targetName = tonumber(targetName)
		for i = 1, #onlinePlayers, 1 do
			if getElementData(onlinePlayers[i], "playerID") == targetName then
				foundPlayer = onlinePlayers[i]
			end
		end
	else
		for i = 1, #onlinePlayers, 1 do
			local playerName = getElementData(onlinePlayers[i], "visibleName")
			if playerName and utf8.find(utf8.lower(playerName):gsub("_", " "), targetName) and getElementData(onlinePlayers[i], "loggedIn") then
				if foundPlayer then
					seexports.sGui:showInfobox("e", "Több játékos található ilyen névvel!")
					return
				end
				foundPlayer = onlinePlayers[i]
			end
		end
	end
	if not foundPlayer then
		seexports.sGui:showInfobox("e", "Nem található a játékos!")
		return
	end
	if foundPlayer == localPlayer then
		seexports.sGui:showInfobox("e", "Saját magadat nem alkalmazhatod!")
		return
	end
	workerToFire = false
	workerToRegister = foundPlayer
	forceTabletDraw = true
	checkAddWorkerCharacter(false)
	checkAddWorkerKey(false)
end
function addWorkerKey(key, press)
	-- line: [447, 458] id: 42
	if press then
		if key == "backspace" then
			workerNameToRegister = utf8.sub(workerNameToRegister, 1, utf8.len(workerNameToRegister) - 1)
			forceTabletDraw = true
		elseif key == "enter" then
			tabletRegisterNext()
		end
	end
	cancelEvent()
end
function addWorkerCharacter(character)
	-- line: [460, 471] id: 43
	if character == "\127" then
		return
	end
	character = utf8.upper(character)
	if character:match("%w") ~= nil or character == " " or character == "_" then
		workerNameToRegister = workerNameToRegister .. character
		forceTabletDraw = true
	end
end

pedTablets = {}
pedTabletObjects = {}

function pedsProcessedTablet(r0_8)
  -- line: [173, 186] id: 8
  for r4_8 in pairs(pedTablets) do
    if isElement(r4_8) and isElementOnScreen(r4_8) then
      setElementBoneRotation(r4_8, 22, 51.73919511878, -74.347910673722, -58.695642222529)
      setElementBoneRotation(r4_8, 23, -50.869565217392, -78.260849662452, -9.1302705847697)
      setElementBoneRotation(r4_8, 24, -142.17389314071, -35.217426134192, -24.782568890116)
      setElementBoneRotation(r4_8, 25, -1.3044174857762, 10.43479256008, 16.956457055133)
      setElementBoneRotation(r4_8, 26, -5.2173266203507, 15.652084350586, 0)
      r0_8[r4_8] = true
    end
  end
end

function processTablet(r0_7, r1_7)
  -- line: [139, 171] id: 7
  local r2_7 = nil	-- notice: implicit variable refs by block#[5, 9]
  if r1_7 == nil then
    r2_7 = pedTablets[r0_7]
  else
    r2_7 = r1_7
  end
  if not isElementStreamedIn(r0_7) then
    r2_7 = false
  elseif r2_7 and (not isPlayerFreeFromAction(r0_7) or isRailCarSyncer(r0_7)) then
    r2_7 = false
  end
  if r2_7 then
    if not pedTabletObjects[r0_7] then
      pedTabletObjects[r0_7] = createObject(modelIds.v4_mine_tablet, 0, 0, 0)
      if isElement(pedTabletObjects[r0_7]) then
        setElementInterior(pedTabletObjects[r0_7], 0)
        setElementDimension(pedTabletObjects[r0_7], currentMine)
      end
    end
    if isElement(pedTabletObjects[r0_7]) then
      exports.pattach:attach(pedTabletObjects[r0_7], r0_7, 25, 0.10783896003808, 0.013285117814657, 0, 0, 0)
      exports.pattach:setRotationQuaternion(pedTabletObjects[r0_7], {
        0.059827387447574,
        -0.038785605657951,
        0.72739675435797,
        0.68250298333007
      })
    end
  else
    if isElement(pedTabletObjects[r0_7]) then
      destroyElement(pedTabletObjects[r0_7])
    end
    pedTabletObjects[r0_7] = nil
  end
end

function mineTableCharacter(character)
	-- line: [473, 515] id: 44
	character = utf8.upper(character)
	if charset[character] or character == " " then
		if not currentMineName[currentNameLine] then
			currentMineName[currentNameLine] = ""
		end
		if utf8.len(currentMineName[currentNameLine]) < 16 then
			local charsetScale = dosFontHeight / 64
			local maximumWidth = math.floor(dosFontHeight * 3.5 / 0.44326 * 0.927294)
			local currentWidth = 0
			for i = 1, utf8.len(currentMineName[currentNameLine]), 1 do
				local charData = charset[utf8.sub(currentMineName[currentNameLine], i, i)]
				if charData then
					currentWidth = currentWidth + charData[2] * charsetScale
				else
					currentWidth = currentWidth + 28 * charsetScale
				end
			end
			local charData = charset[character]
			if charData then
				currentWidth = currentWidth + charData[2] * charsetScale
			else
				currentWidth = currentWidth + 28 * charsetScale
			end
			if currentWidth < maximumWidth then
				currentMineName[currentNameLine] = currentMineName[currentNameLine] .. character
				forceTabletDraw = true
			end
		end
	end
end
function setTabletBomb(bombTable, bombX, bombY, singleSpot)
	-- line: [517, 533] id: 45
	if singleSpot then
		if not bombTable[bombX] then
			bombTable[bombX] = {}
		end
		bombTable[bombX][bombY] = true
	else
		for spotX = bombX - 2, bombX + 2, 1 do
			for spotY = bombY - 2, bombY + 2, 1 do
				if getDistanceBetweenPoints2D(bombX, bombY, spotX, spotY) <= 2 then
					setTabletBomb(bombTable, spotX, spotY, true)
				end
			end
		end
	end
end
local forexText = ""
local forexTextWidth = 0
function onHomeForexUpdate()
	-- line: [538, 557] id: 46
	forceTabletDraw = true
	forexText = ""
	for k, v in pairs(oreTypes) do
		if v.forex then
			local price = seexports.sTrading:getPrice(v.forex)
			if price then
				local trend = seexports.sTrading:getTrend(v.forex)
				forexText = forexText .. (trend and "#ff0000/\\" or "#0000ff\\/") .. "#00ff00 " .. v.forex .. " - " .. seexports.sGui:thousandsStepper(math.floor(price + 0.5)) .. " $ | "
			else
				forexText = forexText .. "  #00ff00 " .. v.forex .. " - ... | "
			end
		end
	end
	forexTextWidth = dxGetTextWidth(forexText, 0.75, dosFont, true)
end
lastPermissionChange = 0
local unsyncedPermissions = {}
function setMinePermission(characterId, permissionName, permissionState)
	-- line: [562, 585] id: 47
	lastPermissionChange = getTickCount()
	checkPreRenderMinePermissionChange(true)
	permissionState = permissionState and true or false
	if not unsyncedPermissions[characterId] then
		unsyncedPermissions[characterId] = {}
	end
	local permissionStateWas = currentMineWorkers[characterId][permissionName] and true or false
	if permissionStateWas ~= permissionState then
		unsyncedPermissions[characterId][permissionName] = permissionState
	else
		unsyncedPermissions[characterId][permissionName] = nil
	end
	forceTabletDraw = true
	for k in pairs(unsyncedPermissions[characterId]) do
		return
	end
	unsyncedPermissions[characterId] = nil
end
function preRenderMinePermissionChange()
	-- line: [587, 620] id: 48
	if getTickCount() - lastPermissionChange > 5000 then
		local permissionsUpdated = false
		local updatedPermissions = {}
		for characterId in pairs(unsyncedPermissions) do
			for permissionName, permissionState in pairs(unsyncedPermissions[characterId]) do
				permissionState = permissionState and true or false
				local permissionStateWas = currentMineWorkers[characterId][permissionName] and true or false
				if permissionStateWas ~= permissionState then
					if not updatedPermissions[characterId] then
						updatedPermissions[characterId] = {}
					end
					for i = 1, #permissionList, 1 do
						if permissionList[i][1] == permissionName then
							updatedPermissions[characterId][i] = permissionState
						end
					end
					permissionsUpdated = true
				end
				currentMineWorkers[characterId][permissionName] = permissionState
			end
		end
		if permissionsUpdated then
			triggerServerEvent("updatecurrentMineWorkers", localPlayer, currentMine, updatedPermissions)
		end
		checkPreRenderMinePermissionChange(false)
	end
end
function drawRenderTarget(blinkState)
	-- line: [622, 1391] id: 49
	dxSetRenderTarget(tabletRT, true)
	if currentMenu == "home" then
		local forexLineSlide = -forexTextWidth * math.floor(getTickCount() / 250) * 250 % 30000 / 30000
		dxDrawText(forexText, forexLineSlide, 24, 0, 48, tocolor(255, 0, 0), 0.75, dosFont, "left", "center", false, false, false, true)
		dxDrawText(forexText, forexLineSlide + forexTextWidth, 24, 0, 48, tocolor(255, 0, 0), 0.75, dosFont, "left", "center", false, false, false, true)
		local hyphenWidth = dxGetTextWidth("-", 0.75, dosFont)
		for i = 0, math.floor(800 / hyphenWidth), 1 do
			dxDrawText("-", i * hyphenWidth, 48, 0, 0, tocolor(0, 255, 0), 0.75, dosFont, "left", "top")
		end
		seelangStaticImageUsed[5] = true
		if seelangStaticImageToc[5] then
			processSeelangStaticImage[5]()
		end
		dxDrawImage(80, 52, 640, 160, seelangStaticImage[5], 0, 0, 0, tocolor(255, 0, 0))
		local hyphenWidth = dxGetTextWidth("-", 0.75, dosFont)
		for i = 0, math.floor(800 / hyphenWidth), 1 do
			dxDrawText("-", i * hyphenWidth, 234 - dosFontHeight, 0, 0, tocolor(255, 0, 0), 0.75, dosFont, "left", "top")
		end
		local drawPosY = 268
		for i = -1, math.floor((600 - drawPosY + 12) / dosFontHeight) - 1, 1 do
			dxDrawText("|", 400, drawPosY - 12 + dosFontHeight * i, 400, 0, tocolor(255, 0, 0), 0.75, dosFont, "center", "top")
		end
		dxDrawText("Üzemanyag: " .. math.floor(currentMineInventory.displayedFuelTankLevel * 10) / 10 .. "/1000 L", 0, drawPosY - 12 - dosFontHeight, 752, 0, tocolor(255, 0, 0), 0.75, dosFont, "right", "top")
		dxDrawText("Sínszál: " .. math.floor(currentMineInventory.railIrons) .. "/100 db", 0, drawPosY - 12 + dosFontHeight, 752, 0, tocolor(255, 0, 0), 0.75, dosFont, "right", "top")
		dxDrawText("Talpfa: " .. math.floor(currentMineInventory.railWoods) .. "/250 db", 0, drawPosY - 12 + dosFontHeight * 2, 752, 0, tocolor(255, 0, 0), 0.75, dosFont, "right", "top")
		dxDrawText("Lámpa: " .. math.floor(currentMineInventory.mineLamps) .. "/40 db", 0, drawPosY - 12, 752, 0, tocolor(255, 0, 0), 0.75, dosFont, "right", "top")
		local drawPosY = drawPosY - 12 + dosFontHeight * 4
		if currentMineInventory.dieselLoco then
			dxDrawText("Mozdony: " .. math.floor(locoDisplayedFuel / 100 * 40 * 10) / 10 .. "/40 L", 0, drawPosY, 752, 0, tocolor(255, 0, 0), 0.75, dosFont, "right", "top")
		else
			dxDrawText("Kocsi 1: " .. math.floor((cartMaxSlots[1] or 0) / #oreCartOffsets * 100 + 0.5) .. "%", 0, drawPosY, 752, 0, tocolor(255, 0, 0), 0.75, dosFont, "right", "top")
		end
		for i = 1, currentMineInventory.subCartNum, 1 do
			local id = i + (currentMineInventory.dieselLoco and 0 or 1)
			dxDrawText("Kocsi " .. id .. ": " .. math.floor((cartMaxSlots[id] or 0) / #oreCartOffsets * 100 + 0.5) .. "%", 0, drawPosY + dosFontHeight, 752, 0, tocolor(255, 0, 0), 0.75, dosFont, "right", "top")
      drawPosY = drawPosY + dosFontHeight
		end
		drawPosY = 256 - dosFontHeight
		local nameBoxSizeY = dosFontHeight * 3.5
		local nameBoxSizeX = math.floor(nameBoxSizeY / 0.44326 * 0.927294) + 12
		if currentNameLine or hoverAction == "editMineName" then
			drawBorder(48, drawPosY, nameBoxSizeX, nameBoxSizeY, 3, tocolor(255, 0, 0))
		else
			drawBorder(48, drawPosY, nameBoxSizeX, nameBoxSizeY, 2, tocolor(255, 0, 0))
		end
		local linePosY = drawPosY + nameBoxSizeY / 2 - dosFontHeight * #currentMineName / 2
		if mineNameSyncing then
			local spinnerState = math.floor(getTickCount() / 250) % 4
			if spinnerState == 0 then
				dxDrawText("|", 48, drawPosY, 48 + nameBoxSizeX, drawPosY + nameBoxSizeY, tocolor(255, 0, 0), 1, dosFont, "center", "center")
			elseif spinnerState == 1 then
				dxDrawText("/", 48, drawPosY, 48 + nameBoxSizeX, drawPosY + nameBoxSizeY, tocolor(255, 0, 0), 1, dosFont, "center", "center")
			elseif spinnerState == 2 then
				dxDrawText("-", 48, drawPosY, 48 + nameBoxSizeX, drawPosY + nameBoxSizeY, tocolor(255, 0, 0), 1, dosFont, "center", "center")
			else
				dxDrawText("\\", 48, drawPosY, 48 + nameBoxSizeX, drawPosY + nameBoxSizeY, tocolor(255, 0, 0), 1, dosFont, "center", "center")
			end
		else
			for i = 1, #currentMineName, 1 do
				local currentWidth = 0
				local charsetScale = dosFontHeight / 64
				if currentMineName[i] then
					for j = 1, utf8.len(currentMineName[i]), 1 do
						local charData = charset[utf8.sub(currentMineName[i], j, j)]
						if charData then
							currentWidth = currentWidth + charData[2] * charsetScale
						else
							currentWidth = currentWidth + 28 * charsetScale
						end
					end
				end
				local linePosX = 48 + nameBoxSizeX / 2 - currentWidth / 2
				if currentMineName[i] then
					for j = 1, utf8.len(currentMineName[i]), 1 do
						local charData = charset[utf8.sub(currentMineName[i], j, j)]
						if charData then
							dxDrawImageSection(linePosX, linePosY, charData[2] * charsetScale, dosFontHeight, charData[1], 0, charData[2], 64, getTableTex(), 0, 0, 0, tocolor(255, 0, 0))
							linePosX = linePosX + charData[2] * charsetScale
						else
							linePosX = linePosX + 28 * charsetScale
						end
					end
				end
				if currentNameLine == i and blinkState then
					dxDrawText("|", linePosX, linePosY, 0, linePosY, tocolor(255, 0, 0), 1, dosFont, "left", "top")
				end
				linePosY = linePosY + dosFontHeight
			end
		end
		drawPosY = drawPosY + nameBoxSizeY + 20
		dxDrawText("Kérlek válassz:", 48, drawPosY, 0, 0, tocolor(255, 0, 0), 0.75, dosFont, "left", "top")
		drawPosY = drawPosY + dosFontHeight + 6
		local buttonHeight = dosFontHeight * 0.85 + 12
		drawButton("menu", "ores", 48, drawPosY, dxGetTextWidth("Nyersanyagok", 0.85, dosFont) + 24, buttonHeight, "Nyersanyagok", 0.85)
		drawPosY = drawPosY + buttonHeight + 12
		drawButton("menu", "map", 48, drawPosY, dxGetTextWidth("Feltérképezés", 0.85, dosFont) + 24, buttonHeight, "Feltérképezés", 0.85)
		drawPosY = drawPosY + buttonHeight + 12
		drawButton("menu", "permissions", 48, drawPosY, dxGetTextWidth("Jogosultságok", 0.85, dosFont) + 24, buttonHeight, "Jogosultságok", 0.85)
		drawPosY = drawPosY + buttonHeight + 12
		drawButton("menu", "shop", 48, drawPosY, dxGetTextWidth("Rendelés", 0.85, dosFont) + 24, buttonHeight, "Rendelés", 0.85)
		drawPosY = drawPosY + buttonHeight + 12
	elseif currentMenu == "ores" then

		local normalOreCount = 0
		local foundryCount = 0
		for k, v in pairs(oreTypes) do
			if not v.fixedBasePrice and not v.instantItem then
				if v.meltingPoint then
					foundryCount = foundryCount + 1
				else
					normalOreCount = normalOreCount + 1
				end
			end
		end

		local iconWidth = 80
		local iconHeight = 120
		local normalX = 400 - (iconWidth + 32) * normalOreCount / 2
		local normalY = 48
		local foundryX = 400 - (iconWidth + 32) * foundryCount / 2
		local foundryY = normalY + 16 + iconHeight + 32
		for k, v in pairs(oreTypes) do
			if not v.instantItem then
				local labelX = 0
				local labelY = 0
				if v.meltingPoint then
					labelX = foundryX + (iconWidth + 32) / 2
					labelY = foundryY
					seelangStaticImageUsed[6] = true
					if seelangStaticImageToc[6] then
						processSeelangStaticImage[6]()
					end
					seelangStaticImageUsed[6] = true
					if seelangStaticImageToc[6] then
						processSeelangStaticImage[6]()
					end
					dxDrawImage(foundryX + 16, foundryY, iconWidth, iconHeight, seelangStaticImage[6], 0, 0, 0, tocolor(255, 0, 0))
					local foundryColor = tocolor(0, 255, 0)
					if mineFoundryData.meltingOre == k or mineFoundryData.furnaceRunning == k then
						if mineFoundryData.meltProgress >= 7.5 then
							foundryColor = blinkState and tocolor(0, 0, 255) or tocolor(0, 255, 0)
						else
							foundryColor = tocolor(0, 0, 255)
						end
					end
					dxDrawText("Kohó", labelX, foundryY + iconHeight + 16, labelX, foundryY + iconHeight + 16 + 16, foundryColor, 0.75, dosFont, "center", "center")
					seelangStaticImageUsed[7] = true
					if seelangStaticImageToc[7] then
						processSeelangStaticImage[7]()
					end
					dxDrawImage(foundryX + 16, foundryY + iconHeight + 16 + 16, iconWidth, iconHeight, seelangStaticImage[7], 0, 0, 0, foundryColor)
					local displayedFoundryContent = v.displayedFoundryContent
					if displayedFoundryContent >= 100 then
						displayedFoundryContent = math.floor(displayedFoundryContent)
					else
						displayedFoundryContent = math.floor(displayedFoundryContent * 10) / 10
					end
					dxDrawText(math.max(0, displayedFoundryContent) .. "\nrúd", foundryX + 49.75, foundryY + iconHeight + 16 + 16 + 55, foundryX + 49.75, foundryY + iconHeight + 16 + 16 + 55, foundryColor, 0.75, dosFont, "center", "center")
					if mineFoundryData.meltingOre == k or mineFoundryData.furnaceRunning == k then
						local furnaceTemperature = getEasingValue(v.furnaceTemperature / 1000, "InOutQuad") * v.meltingPoint + 7.5 * math.sin(getTickCount() % 30000 / 30000 * math.pi * 2)
						if furnaceTemperature > 50 then
							furnaceTemperature = math.floor(furnaceTemperature) .. " C"
						else
							furnaceTemperature = blinkState and "----" or ""
						end
						dxDrawText(furnaceTemperature, foundryX + 49.75, foundryY + iconHeight + 16 + 16 + iconHeight + 8, foundryX + 49.75, 0, foundryColor, 0.75, dosFont, "center", "top")
					end
					foundryX = foundryX + iconWidth + 32
				else
					labelX = normalX + (iconWidth + 32) / 2
					labelY = normalY
					seelangStaticImageUsed[6] = true
					if seelangStaticImageToc[6] then
						processSeelangStaticImage[6]()
					end
					dxDrawImage(normalX + 16, normalY, iconWidth, iconHeight, seelangStaticImage[6], 0, 0, 0, tocolor(255, 0, 0))
					normalX = normalX + iconWidth + 32
				end
				dxDrawText(v.displayName, labelX, labelY - 16, labelX, labelY, tocolor(255, 0, 0), 0.75, dosFont, "center", "center")
				local pufferContent = v.bufferContent
				if v.displayedBoxContent < v.boxContent then
					pufferContent = pufferContent + v.boxContent - v.displayedBoxContent
				end
				if pufferContent >= 100 then
					pufferContent = math.floor(pufferContent)
				else
					pufferContent = math.floor(pufferContent * 10) / 10
				end
				dxDrawText(math.max(0, pufferContent) .. "\nadag", labelX, labelY + 41.875, labelX, labelY + 41.875, tocolor(255, 0, 0), 0.75, dosFont, "center", "center")
				dxDrawText(math.floor(v.displayedBoxContent * 100) .. "%", labelX, 0, labelX, labelY + 111.25, tocolor(255, 0, 0), 0.75, dosFont, "center", "bottom")
			end
		end
	elseif currentMenu == "shop" then
		local lineY = 48
		local lineHeight = dosFontHeight * 0.85 + 12
		if currentMineInventory.tankOutside then
			dxDrawText("Az üzemanyagtartály szállítás alatt", 48, lineY, 0, lineY + lineHeight, tocolor(255, 0, 0), 0.9, dosFont, "left", "center")
		else
			local r3_49 = "Üzemanyagtartály: " .. math.floor(currentMineInventory.displayedFuelTankLevel * 10) / 10 .. "/1000 L"
			local r4_49 = dxGetTextWidth(r3_49, 0.9, dosFont) + 12
			dxDrawText(r3_49, 48, lineY, 0, lineY + lineHeight, tocolor(255, 0, 0), 0.9, dosFont, "left", "center")
			if tankPreRequest == currentMine then
				drawButton("requestMineFuelTank", false, 48 + r4_49, lineY, dxGetTextWidth("Feltöltés megszakítása", 0.85, dosFont) + 24, lineHeight, "Feltöltés megszakítása", 0.85)
			else
				drawButton("requestMineFuelTank", false, 48 + r4_49, lineY, dxGetTextWidth("Tartály feltöltése", 0.85, dosFont) + 24, lineHeight, "Tartály feltöltése", 0.85)
			end
			lineY = lineY + lineHeight + 6
		end
		local hyphenWidth = dxGetTextWidth("-", 0.75, dosFont)
		for i = 0, math.floor(800 / hyphenWidth), 1 do
			dxDrawText("-", i * hyphenWidth, lineY, 0, lineY + dosFontHeight, tocolor(255, 0, 0), 0.75, dosFont, "left", "center")
		end
		lineY = lineY + dosFontHeight + 24
		local w1 = dxGetTextWidth("Megnevezés", 0.9, dosFont) + 32
		local w2 = dxGetTextWidth("Raktár", 0.9, dosFont) + 32
		local w3 = dxGetTextWidth("Rendelés", 0.9, dosFont) + 40
		local w4 = dxGetTextWidth("Egységár", 0.9, dosFont) + 48
		local lineX = 400 - (w1 + w2 + w3 + w4 * 2) / 2
		dxDrawText("Megnevezés", lineX, lineY, lineX + w1, lineY + dosFontHeight, tocolor(255, 0, 0), 0.9, dosBoldFont, "center", "center")
		dxDrawText("Raktár", lineX + w1, lineY, lineX + w1 + w2, lineY + dosFontHeight, tocolor(255, 0, 0), 0.9, dosBoldFont, "center", "center")
		dxDrawText("Rendelés", lineX + w1 + w2, lineY, lineX + w1 + w2 + w3, lineY + dosFontHeight, tocolor(255, 0, 0), 0.9, dosBoldFont, "center", "center")
		dxDrawText("Egységár", lineX + w1 + w2 + w3, lineY, lineX + w1 + w2 + w3 + w4, lineY + dosFontHeight, tocolor(255, 0, 0), 0.9, dosBoldFont, "center", "center")
		dxDrawText("Fizetendő", lineX + w1 + w2 + w3 + w4, lineY, lineX + w1 + w2 + w3 + w4 * 2, lineY + dosFontHeight, tocolor(255, 0, 0), 0.9, dosBoldFont, "center", "center")
		lineY = lineY + dosFontHeight
		local hyphenWidth = dxGetTextWidth("-", 0.75, dosFont)
		for i = 0, math.floor((w1 + w2 + w3 + w4 * 2) / hyphenWidth), 1 do
			dxDrawText("-", lineX + i * hyphenWidth, lineY, 0, lineY + dosFontHeight, tocolor(255, 0, 0), 0.75, dosFont, "left", "center")
		end
		if mineOrderSyncing then
			lineY = lineY + dosFontHeight
			local r10_49 = math.floor(getTickCount() / 250) % 4
			if r10_49 == 0 then
				dxDrawText("|", 0, lineY, 800, 0, tocolor(255, 0, 0), 1, dosFont, "center", "top")
			elseif r10_49 == 1 then
				dxDrawText("/", 0, lineY, 800, 0, tocolor(255, 0, 0), 1, dosFont, "center", "top")
			elseif r10_49 == 2 then
				dxDrawText("-", 0, lineY, 800, 0, tocolor(255, 0, 0), 1, dosFont, "center", "top")
			else
				dxDrawText("\\", 0, lineY, 800, 0, tocolor(255, 0, 0), 1, dosFont, "center", "top")
			end
		else
			local maxSubCart = currentMineInventory.dieselLoco and 6 or 1
			local canOrder = false 
			if mineOrdering.subCart then
				canOrder = {
					subCart = currentMineInventory.subCartNum + (mineOrdering.subCart or 0) < maxSubCart and (mineOrdering.subCart or 0) < #trailerOffsets.subCart
				}
			elseif not mineOrdering.dieselEngine and not currentMineOrder then
				canOrder = {
					railIron = math.ceil(currentMineInventory.railIrons / 50) + (mineOrdering.railIrons or 0) < 2 and (mineOrdering.railIrons or 0) < #trailerOffsets.railIrons - (mineOrdering.railWoods or 0),
					railWood = math.ceil(currentMineInventory.railWoods / 125) + (mineOrdering.railWoods or 0) < 2 and (mineOrdering.railWoods or 0) < #trailerOffsets.railWoods - (mineOrdering.railIrons or 0),
					mineLamps = math.ceil(currentMineInventory.mineLamps / 20) + (mineOrdering.mineLamps or 0) < 2 and (mineOrdering.mineLamps or 0) < #trailerOffsets.mineLamps,
					dieselEngine = (currentMineInventory.dieselLoco and 1 or 0) + (mineOrdering.dieselEngine or 0) < 1 and (mineOrdering.dieselEngine or 0) < #trailerOffsets.dieselEngine,
					subCart = currentMineInventory.subCartNum + (mineOrdering.subCart or 0) < maxSubCart and (mineOrdering.subCart or 0) < #trailerOffsets.subCart,
				}
				if mineOrdering.railIrons or mineOrdering.railWoods then
					canOrder.mineLamps = false
					canOrder.dieselEngine = false
					canOrder.subCart = false
				elseif mineOrdering.mineLamps then
					canOrder.railIron = false
					canOrder.railWood = false
					canOrder.dieselEngine = false
					canOrder.subCart = false
				end
			end
			local r12_49 = dosFontHeight * 0.75 + 8
			lineY = lineY + dosFontHeight + 8
			if not currentMineOrder or currentMineOrder.railIron then
				local r13_49 = currentMineOrder and currentMineOrder.railIron or mineOrdering.railIrons or 0
				dxDrawText("Sínszál", lineX, lineY, lineX + w1, lineY + dosFontHeight, tocolor(255, 0, 0), 0.9, dosFont, "center", "center")
				dxDrawText(math.ceil(currentMineInventory.railIrons / 50) .. "/2 doboz", lineX + w1, lineY, lineX + w1 + w2, lineY + dosFontHeight, tocolor(255, 0, 0), 0.9, dosFont, "center", "center")
				dxDrawText(r13_49, lineX + w1 + w2, lineY, lineX + w1 + w2 + w3, lineY + dosFontHeight, tocolor(255, 0, 0), 0.9, dosFont, "center", "center")
				dxDrawText(seexports.sGui:thousandsStepper(railIronPrice) .. " $", lineX + w1 + w2 + w3, lineY, lineX + w1 + w2 + w3 + w4, lineY + dosFontHeight, tocolor(255, 0, 0), 0.9, dosFont, "center", "center")
				dxDrawText(seexports.sGui:thousandsStepper(railIronPrice * r13_49) .. " $", lineX + w1 + w2 + w3 + w4, lineY, lineX + w1 + w2 + w3 + w4 * 2, lineY + dosFontHeight, tocolor(255, 0, 0), 0.9, dosFont, "center", "center")
				if 0 < (mineOrdering.railIrons or 0) and not currentMineOrder then
					drawButton("orderMinus", "railIrons", lineX + w1 + w2 + w3 / 2 - r12_49 * 1.75, lineY + dosFontHeight / 2 - r12_49 / 2, r12_49, r12_49, "-", 0.75)
				end
				if canOrder and canOrder.railIron then
					drawButton("orderPlus", "railIrons", lineX + w1 + w2 + w3 / 2 + r12_49 * 0.75, lineY + dosFontHeight / 2 - r12_49 / 2, r12_49, r12_49, "+", 0.75)
				end
				lineY = lineY + dosFontHeight + 8
			end
			if not currentMineOrder or currentMineOrder.railWood then
				local r13_49 = currentMineOrder and currentMineOrder.railWood or mineOrdering.railWoods or 0
				dxDrawText("Talpfa", lineX, lineY, lineX + w1, lineY + dosFontHeight, tocolor(255, 0, 0), 0.9, dosFont, "center", "center")
				dxDrawText(math.ceil(currentMineInventory.railWoods / 125) .. "/2 doboz", lineX + w1, lineY, lineX + w1 + w2, lineY + dosFontHeight, tocolor(255, 0, 0), 0.9, dosFont, "center", "center")
				dxDrawText(r13_49, lineX + w1 + w2, lineY, lineX + w1 + w2 + w3, lineY + dosFontHeight, tocolor(255, 0, 0), 0.9, dosFont, "center", "center")
				dxDrawText(seexports.sGui:thousandsStepper(railWoodPrice) .. " $", lineX + w1 + w2 + w3, lineY, lineX + w1 + w2 + w3 + w4, lineY + dosFontHeight, tocolor(255, 0, 0), 0.9, dosFont, "center", "center")
				dxDrawText(seexports.sGui:thousandsStepper(railWoodPrice * r13_49) .. " $", lineX + w1 + w2 + w3 + w4, lineY, lineX + w1 + w2 + w3 + w4 * 2, lineY + dosFontHeight, tocolor(255, 0, 0), 0.9, dosFont, "center", "center")
				if 0 < (mineOrdering.railWoods or 0) and not currentMineOrder then
					drawButton("orderMinus", "railWoods", lineX + w1 + w2 + w3 / 2 - r12_49 * 1.75, lineY + dosFontHeight / 2 - r12_49 / 2, r12_49, r12_49, "-", 0.75)
				end
				if canOrder and canOrder.railWood then
					drawButton("orderPlus", "railWoods", lineX + w1 + w2 + w3 / 2 + r12_49 * 0.75, lineY + dosFontHeight / 2 - r12_49 / 2, r12_49, r12_49, "+", 0.75)
				end
				lineY = lineY + dosFontHeight + 8
			end
			if not currentMineOrder or currentMineOrder.mineLamps then
				local r13_49 = currentMineOrder and currentMineOrder.mineLamps or mineOrdering.mineLamps or 0
				dxDrawText("Lámpa", lineX, lineY, lineX + w1, lineY + dosFontHeight, tocolor(255, 0, 0), 0.9, dosFont, "center", "center")
				dxDrawText(math.ceil(currentMineInventory.mineLamps / 20) .. "/2 doboz", lineX + w1, lineY, lineX + w1 + w2, lineY + dosFontHeight, tocolor(255, 0, 0), 0.9, dosFont, "center", "center")
				dxDrawText(r13_49, lineX + w1 + w2, lineY, lineX + w1 + w2 + w3, lineY + dosFontHeight, tocolor(255, 0, 0), 0.9, dosFont, "center", "center")
				dxDrawText(seexports.sGui:thousandsStepper(mineLampPrice) .. " $", lineX + w1 + w2 + w3, lineY, lineX + w1 + w2 + w3 + w4, lineY + dosFontHeight, tocolor(255, 0, 0), 0.9, dosFont, "center", "center")
				dxDrawText(seexports.sGui:thousandsStepper(mineLampPrice * r13_49) .. " $", lineX + w1 + w2 + w3 + w4, lineY, lineX + w1 + w2 + w3 + w4 * 2, lineY + dosFontHeight, tocolor(255, 0, 0), 0.9, dosFont, "center", "center")
				if 0 < (mineOrdering.mineLamps or 0) and not currentMineOrder then
					drawButton("orderMinus", "mineLamps", lineX + w1 + w2 + w3 / 2 - r12_49 * 1.75, lineY + dosFontHeight / 2 - r12_49 / 2, r12_49, r12_49, "-", 0.75)
				end
				if canOrder and canOrder.mineLamps then
					drawButton("orderPlus", "mineLamps", lineX + w1 + w2 + w3 / 2 + r12_49 * 0.75, lineY + dosFontHeight / 2 - r12_49 / 2, r12_49, r12_49, "+", 0.75)
				end
				lineY = lineY + dosFontHeight + 8
			end
			if not currentMineOrder or currentMineOrder.dieselEngine then
				local r13_49 = currentMineOrder and currentMineOrder.dieselEngine or mineOrdering.dieselEngine or 0
				dxDrawText("UrmaMoto\nmozdony", lineX, lineY, lineX + w1, lineY + dosFontHeight * 2, tocolor(255, 0, 0), 0.9, dosFont, "center", "center")
				dxDrawText((currentMineInventory.dieselLoco and 1 or 0) .. "/1", lineX + w1, lineY, lineX + w1 + w2, lineY + dosFontHeight * 2, tocolor(255, 0, 0), 0.9, dosFont, "center", "center")
				dxDrawText(r13_49, lineX + w1 + w2, lineY, lineX + w1 + w2 + w3, lineY + dosFontHeight * 2, tocolor(255, 0, 0), 0.9, dosFont, "center", "center")
				dxDrawText(seexports.sGui:thousandsStepper(dieselLocoPrice) .. " PP", lineX + w1 + w2 + w3, lineY, lineX + w1 + w2 + w3 + w4, lineY + dosFontHeight * 2, tocolor(255, 0, 0), 0.9, dosFont, "center", "center")
				dxDrawText(seexports.sGui:thousandsStepper(dieselLocoPrice * r13_49) .. " PP", lineX + w1 + w2 + w3 + w4, lineY, lineX + w1 + w2 + w3 + w4 * 2, lineY + dosFontHeight * 2, tocolor(255, 0, 0), 0.9, dosFont, "center", "center")
				if 0 < (mineOrdering.dieselEngine or 0) and not currentMineOrder then
					drawButton("orderMinus", "dieselEngine", lineX + w1 + w2 + w3 / 2 - r12_49 * 1.75, lineY + dosFontHeight - r12_49 / 2, r12_49, r12_49, "-", 0.75)
				end
				if canOrder and canOrder.dieselEngine then
					drawButton("orderPlus", "dieselEngine", lineX + w1 + w2 + w3 / 2 + r12_49 * 0.75, lineY + dosFontHeight - r12_49 / 2, r12_49, r12_49, "+", 0.75)
				end
				lineY = lineY + dosFontHeight * 2 + 8
			end
			if not currentMineOrder or currentMineOrder.subCart then
				local r13_49 = currentMineOrder and currentMineOrder.subCart or mineOrdering.subCart or 0
				dxDrawText("Kocsi", lineX, lineY, lineX + w1, lineY + dosFontHeight, tocolor(255, 0, 0), 0.9, dosFont, "center", "center")
				dxDrawText(currentMineInventory.subCartNum + (currentMineInventory.dieselLoco and 0 or 1) .. "/" .. maxSubCart + (currentMineInventory.dieselLoco and 0 or 1), lineX + w1, lineY, lineX + w1 + w2, lineY + dosFontHeight, tocolor(255, 0, 0), 0.9, dosFont, "center", "center")
				dxDrawText(r13_49, lineX + w1 + w2, lineY, lineX + w1 + w2 + w3, lineY + dosFontHeight, tocolor(255, 0, 0), 0.9, dosFont, "center", "center")
				dxDrawText(seexports.sGui:thousandsStepper(subRailCarPrice) .. " $", lineX + w1 + w2 + w3, lineY, lineX + w1 + w2 + w3 + w4, lineY + dosFontHeight, tocolor(255, 0, 0), 0.9, dosFont, "center", "center")
				dxDrawText(seexports.sGui:thousandsStepper(subRailCarPrice * r13_49) .. " $", lineX + w1 + w2 + w3 + w4, lineY, lineX + w1 + w2 + w3 + w4 * 2, lineY + dosFontHeight, tocolor(255, 0, 0), 0.9, dosFont, "center", "center")
				if 0 < (mineOrdering.subCart or 0) and not currentMineOrder then
					drawButton("orderMinus", "subCart", lineX + w1 + w2 + w3 / 2 - r12_49 * 1.75, lineY + dosFontHeight / 2 - r12_49 / 2, r12_49, r12_49, "-", 0.75)
				end
				if canOrder and canOrder.subCart then
					drawButton("orderPlus", "subCart", lineX + w1 + w2 + w3 / 2 + r12_49 * 0.75, lineY + dosFontHeight / 2 - r12_49 / 2, r12_49, r12_49, "+", 0.75)
				end
				lineY = lineY + dosFontHeight + 8
			end
			lineY = lineY + 16
			local r13_49 = ""
			if currentMineOrder then
				local r14_49 = nil
				local r15_49 = nil
				r14_49, r15_49, r13_49 = getOrderPrice(currentMineOrder)
				dxDrawText("Végösszeg: " .. r13_49 .. (currentMineOrderPaid and " (fizetve)" or ""), 0, lineY, 800, lineY + dosFontHeight, tocolor(255, 0, 0), 0.9, dosFont, "center", "center")
				lineY = lineY + dosFontHeight
				dxDrawText("A rendelés átvehetö a See Mining Co. telephelyén.", 0, lineY, 800, lineY + dosFontHeight, tocolor(255, 0, 0), 0.9, dosFont, "center", "center")
				lineY = lineY + dosFontHeight + 12
				if not currentMineOrderPaid then
					r17_49 = dxGetTextWidth("Rendelés lemondása", 0.85, dosFont) + 24
					drawButton("cancelMineOrder", false, 400 - r17_49 / 2, lineY, r17_49, dosFontHeight * 0.85 + 12, "Rendelés lemondása", 0.85)
				end
			else
				local r14_49 = nil
				local r15_49 = nil
				r14_49, r15_49, r13_49 = getOrderPrice(mineOrdering)
				if r14_49 > 0 then
					local r17_49 = dxGetTextWidth(("Rendelés leadása (" .. r13_49 .. ")"), 0.85, dosFont) + 24
					drawButton("createMineOrder", false, 400 - r17_49 / 2, lineY, r17_49, dosFontHeight * 0.85 + 12, "Rendelés leadása (" .. r13_49 .. ")", 0.85)
				end
			end
		end
	elseif currentMenu == "permissions" then
		local linePosY = 48
		local lineHeight = dosFontHeight * 0.85 + 6
		dxDrawText("Munkások:", 48, linePosY, 0, linePosY + lineHeight, tocolor(255, 0, 0), 0.85, dosFont, "left", "center")
		linePosY = linePosY + lineHeight
		local r3_49 = dxGetTextWidth("-", 0.75, dosFont)
		for r7_49 = 0, math.floor(800 / r3_49), 1 do
			dxDrawText("-", r7_49 * r3_49, linePosY, 0, linePosY + dosFontHeight, tocolor(255, 0, 0), 0.75, dosFont, "left", "center")
		end
		linePosY = linePosY + dosFontHeight
		local r4_49 = dxGetTextWidth("-", 0.5, dosFont)
		local r5_49 = 250
		local r6_49 = #currentMineWorkersList
		for i = 1, r6_49, 1 do
			local characterId = currentMineWorkersList[i]
			iprint(characterId, i)
			if checkMinePermission("managePermissions") then
				drawRedButton("fire", i, 48, linePosY + 2, lineHeight - 4, lineHeight - 4, "x", 0.85)
				dxDrawText(currentMineWorkers[characterId], 48 + lineHeight + 4, linePosY, 48 + r5_49 + lineHeight + 4, linePosY + lineHeight, tocolor(255, 0, 0), 0.85, dosFont, "left", "center", true)
			else
				dxDrawText(currentMineWorkers[characterId], 48, linePosY, 48 + r5_49 + lineHeight + 4, linePosY + lineHeight, tocolor(255, 0, 0), 0.85, dosFont, "left", "center", true)
			end
			for j = 1, #permissionList, 1 do
				local permissionName = permissionList[j][1]
				local permissionState = currentMineWorkers[characterId][permissionName]
				if unsyncedPermissions[characterId] and (unsyncedPermissions[characterId][permissionName] or unsyncedPermissions[characterId][permissionName] == false) then
					permissionState = unsyncedPermissions[characterId][permissionName]
				end
				drawButton("permission", (i - 1) * #permissionList + j - 1, 48 + r5_49 + 12 + (lineHeight + 4) * j, linePosY + 2, lineHeight - 4, lineHeight - 4, permissionState and "x" or " ", 0.85)
			end
			if i < r6_49 then
				linePosY = linePosY + lineHeight + 3
				for r15_49 = 0, math.floor(704 / r4_49), 1 do
					dxDrawText("-", 48 + r15_49 * r4_49, linePosY, 0, linePosY + lineHeight / 5, tocolor(255, 0, 0), 0.5, dosFont, "left", "center")
				end
				linePosY = linePosY + lineHeight / 5 + 3
			else
				linePosY = linePosY + lineHeight + 12
			end
		end
		if r6_49 < 10 and checkMinePermission("managePermissions") then
			drawButton("addWorker", false, 48, linePosY, dxGetTextWidth("Munkás regisztrálása", 0.85, dosFont) + 24, dosFontHeight * 0.85 + 12, "Munkás regisztrálása", 0.85)
		end
		if workerToRegister then
			dxDrawRectangle(200, 200, 400, 200, tocolor(0, 0, 0))
			drawBorder(200, 200, 400, 200, 2, tocolor(255, 0, 0))
			local r7_49 = 182
			local r8_49 = dosFontHeight * 0.85 + 12
			if isElement(workerToRegister) then
				dxDrawText("Biztosan szeretnéd felvenni " .. getElementData(workerToRegister, "visibleName"):gsub("_", " ") .. " munkást?", 200, 200, 600, 400 - r8_49 - 24, tocolor(255, 0, 0), 0.85, dosFont, "center", "center", false, true)
				drawButton("registerYes", false, 212, 388 - r8_49, r7_49, r8_49, "Igen", 0.85)
				drawButton("promptNo", false, 600 - r7_49 - 12, 388 - r8_49, r7_49, r8_49, "Nem", 0.85)
			else
				local r9_49 = 212
				local r10_49 = 388 - r8_49 * 2 - 24
				dxDrawText("Játékos név/id:", r9_49, 200, 0, 400 - r8_49 * 2 - 36, tocolor(255, 0, 0), 0.85, dosFont, "left", "center")
				drawBorder(r9_49, r10_49, 388, r8_49, 2, tocolor(255, 0, 0))
				local r11_49 = dxGetTextWidth(workerNameToRegister, 0.85, dosFont)
				dxDrawText(workerNameToRegister, r9_49 + 6, r10_49, r9_49 + 400 - 12 - 6, r10_49 + r8_49, tocolor(255, 0, 0), 0.85, dosFont, r11_49 < 382 and "left" or "right", "center", true)
				if blinkState then
					dxDrawText("|", r9_49 + 6 + r11_49, r10_49, 0, r10_49 + r8_49, tocolor(255, 0, 0), 1, dosFont, "left", "center")
				end
				drawButton("registerNext", false, 212, 388 - r8_49, r7_49, r8_49, "Regisztráció", 0.85)
				drawButton("promptNo", false, 600 - r7_49 - 12, 388 - r8_49, r7_49, r8_49, "Mégsem", 0.85)
			end
		elseif workerToFire then
			dxDrawRectangle(200, 200, 400, 200, tocolor(0, 0, 0))
			drawBorder(200, 200, 400, 200, 2, tocolor(255, 0, 0))
			local r7_49 = 182
			local r8_49 = dosFontHeight * 0.85 + 12
			local r9_49 = permissionList[workerToFire]
			if r9_49 and currentMineWorkers[r9_49] then
				dxDrawText("Biztosan szeretnéd kirúgni " .. currentMineWorkers[r9_49] .. " munkást?", 200, 200, 600, 400 - r8_49 - 24, tocolor(255, 0, 0), 0.85, dosFont, "center", "center", false, true)
			end
			drawButton("fireYes", false, 212, 388 - r8_49, r7_49, r8_49, "Igen", 0.85)
			drawButton("promptNo", false, 600 - r7_49 - 12, 388 - r8_49, r7_49, r8_49, "Nem", 0.85)
		end
	elseif currentMenu == "map" then
		local bombSpots = {}
		if not blinkState then
			for x in pairs(threeJunctionBombs) do
				for y in pairs(threeJunctionBombs[x]) do
					setTabletBomb(bombSpots, x, y)
				end
			end
			for r5_49, r6_49 in pairs(openShaftBombs) do
				setTabletBomb(bombSpots, convertMineCoordinates(r6_49[5], r6_49[6]))
			end
			for r5_49, r6_49 in pairs(shaftBombs) do
				for r10_49, r11_49 in pairs(r6_49) do
					for r15_49, r16_49 in pairs(r11_49) do
						setTabletBomb(bombSpots, convertMineCoordinates(r16_49[5], r16_49[6]))
					end
				end
			end
		end
		local mapMoveX = mapData.mx or selfMineX
		local mapMoveY = mapData.my or selfMineY
		local mapPosX = 400
		local mapPosY = 300
		local mapItemSize = 32 * mapData.zoom
		local mapRangeY = math.ceil(600 / mapItemSize / 2)
		local mapRangeX = math.ceil(800 / mapItemSize / 2)
		for deltaY = -mapRangeY, mapRangeY, 1 do
			local spotX = deltaY + mapMoveX
			if bombSpots[spotX] then
				for deltaX = -mapRangeX, mapRangeX, 1 do
					if bombSpots[spotX][deltaX + mapMoveY] then
						dxDrawRectangle(mapPosX - deltaX * mapItemSize - mapItemSize / 2, mapPosY - deltaY * mapItemSize - mapItemSize / 2, mapItemSize, mapItemSize, tocolor(0, 0, 255))
					end
				end
			end
			if tunnelObjectRots[spotX] or junctionObjects[spotX] or mapPresetAt[spotX] then
				for deltaX = -mapRangeX, mapRangeX, 1 do
					local spotY = deltaX + mapMoveY
					if mapPresetAt[spotX] and mapPresetAt[spotX][spotY] then
						dxDrawImage(mapPosX - deltaX * mapItemSize - mapItemSize / 2, mapPosY - deltaY * mapItemSize - mapItemSize / 2, mapItemSize, mapItemSize, dynamicImage("files/m" .. mapPresetAt[spotX][spotY][1] .. ".dds"), mapPresetAt[spotX][spotY][2], 0, 0, tocolor(255, 0, 0))
					elseif tunnelObjectRots[spotX] and tunnelObjectRots[spotX][spotY] then
						if openShaftsAt[spotX] and openShaftsAt[spotX][spotY] then
							seelangStaticImageUsed[2] = true
							if seelangStaticImageToc[2] then
								processSeelangStaticImage[2]()
							end
							dxDrawImage(mapPosX - deltaX * mapItemSize - mapItemSize / 2, mapPosY - deltaY * mapItemSize - mapItemSize / 2, mapItemSize, mapItemSize, seelangStaticImage[2], -tunnelObjectRots[spotX][spotY], 0, 0, tocolor(255, 0, 0))
						else
							seelangStaticImageUsed[0] = true
							if seelangStaticImageToc[0] then
								processSeelangStaticImage[0]()
							end
							dxDrawImage(mapPosX - deltaX * mapItemSize - mapItemSize / 2, mapPosY - deltaY * mapItemSize - mapItemSize / 2, mapItemSize, mapItemSize, seelangStaticImage[0], tunnelObjectRots[spotX][spotY], 0, 0, tocolor(255, 0, 0))
						end
					elseif threeJunctionsAt[spotX] and threeJunctionsAt[spotX][spotY] then
						seelangStaticImageUsed[1] = true
						if seelangStaticImageToc[1] then
							processSeelangStaticImage[1]()
						end
						dxDrawImage(mapPosX - deltaX * mapItemSize - mapItemSize / 2, mapPosY - deltaY * mapItemSize - mapItemSize / 2, mapItemSize, mapItemSize, seelangStaticImage[1], -threeJunctionRots[spotX][spotY] + 180, 0, 0, tocolor(255, 0, 0))
					elseif junctionObjects[spotX] and junctionObjects[spotX][spotY] then
						seelangStaticImageUsed[8] = true
						if seelangStaticImageToc[8] then
							processSeelangStaticImage[8]()
						end
						dxDrawImage(mapPosX - deltaX * mapItemSize - mapItemSize / 2, mapPosY - deltaY * mapItemSize - mapItemSize / 2, mapItemSize, mapItemSize, seelangStaticImage[8], 0, 0, 0, tocolor(255, 0, 0))
					end
				end
			end
			if railsAt[spotX] or railSwitchesAt[spotX] then
				for deltaX = -mapRangeX, mapRangeX, 1 do
					local spotY = deltaX + mapMoveY
					local railId = railsAt[spotX] and railsAt[spotX][spotY]
					if railId then
						local railDeg = railTracks[railId][6]
						if spotX == -4 then
							seelangStaticImageUsed[4] = true
							if seelangStaticImageToc[4] then
								processSeelangStaticImage[4]()
							end
							dxDrawImage(mapPosX - deltaX * mapItemSize - mapItemSize / 2, mapPosY - deltaY * mapItemSize - mapItemSize / 2, mapItemSize, mapItemSize, seelangStaticImage[4], 0, 0, 0, tocolor(0, 255, 0))
						else
							if railEndsAt[spotX] then
								if railEndsAt[spotX][spotY] then
									seelangStaticImageUsed[4] = true
									if seelangStaticImageToc[4] then
										processSeelangStaticImage[4]()
									end
									dxDrawImage(mapPosX - deltaX * mapItemSize - mapItemSize / 2, mapPosY - deltaY * mapItemSize - mapItemSize / 2, mapItemSize, mapItemSize, seelangStaticImage[4], -railTracks[railId].angleDeg + 180, 0, 0, tocolor(0, 255, 0))
								end
							else
								seelangStaticImageUsed[3] = true
								if seelangStaticImageToc[3] then
									processSeelangStaticImage[3]()
								end
								dxDrawImage(mapPosX - deltaX * mapItemSize - mapItemSize / 2, mapPosY - deltaY * mapItemSize - mapItemSize / 2, mapItemSize, mapItemSize, seelangStaticImage[3], railTracks[railId].angleDeg, 0, 0, tocolor(0, 255, 0))
							end
						end
					else
						local switchId = railSwitchesAt[spotX] and railSwitchesAt[spotX][spotY]
						if switchId then
							dxDrawImage(mapPosX - deltaX * mapItemSize - mapItemSize / 2, mapPosY - deltaY * mapItemSize - mapItemSize / 2, mapItemSize, mapItemSize, dynamicImage("files/m" .. #railSwitches[switchId].trackIds + 5 .. ".dds"), -railSwitches[switchId].angleDeg + 180, 0, 0, tocolor(0, 255, 0))
						end
					end
				end
			end
		end
		local r9_49 = mapItemSize * 0.25
		if blinkState then
			dxDrawRectangle(mapPosX - (selfMineY - mapMoveY) * mapItemSize - r9_49 / 2, mapPosY - (selfMineX - mapMoveX) * mapItemSize - r9_49 / 2, r9_49, r9_49, tocolor(0, 0, 255))
			local r10_49, r11_49 = getRelativeFirstRailCarPosition()
			dxDrawRectangle(mapPosX - (r11_49 - mapMoveY) * mapItemSize - r9_49 / 2, mapPosY - (r10_49 - mapMoveX) * mapItemSize - r9_49 / 2, r9_49, r9_49, tocolor(0, 255, 0))
			dxDrawRectangle(30, 30, r9_49, r9_49, tocolor(0, 0, 255))
			dxDrawRectangle(30, 60, r9_49, r9_49, tocolor(0, 255, 0))
		end
		r9_49 = 8
		dxDrawText("Tartózkodási helyed", 30 + r9_49 * 2, 30, 0, 30 + r9_49, tocolor(0, 0, 255), 0.75, dosFont, "left", "center")
		dxDrawText("Bányavonat helyzete", 30 + r9_49 * 2, 60, 0, 60 + r9_49, tocolor(0, 255, 0), 0.75, dosFont, "left", "center")
		local r10_49 = dosFontHeight * 0.75 + 8
		drawButton("mapZoom", -0.25, 752 - r10_49 * 4 - 24, 552 - r10_49, r10_49, r10_49, "-", 0.75)
		drawButton("mapZoom", 0.25, 752 - r10_49 * 4 - 24, 552 - r10_49 * 2 - 6, r10_49, r10_49, "+", 0.75)
		drawButton("mapMoveY", -1, 752 - r10_49, 552 - r10_49 * 2 - 6, r10_49, r10_49, ">", 0.75)
		drawButton("mapMoveX", -1, 752 - r10_49 * 2 - 6, 552 - r10_49, r10_49, r10_49, "\\/", 0.75)
		if mapData.mx or mapData.my then
			drawButton("mapCenter", 0, 752 - r10_49 * 2 - 6, 552 - r10_49 * 2 - 6, r10_49, r10_49, "O", 0.75)
		end
		drawButton("mapMoveX", 1, 752 - r10_49 * 2 - 6, 552 - r10_49 * 3 - 12, r10_49, r10_49, "/\\", 0.75)
		drawButton("mapMoveY", 1, 752 - r10_49 * 3 - 12, 552 - r10_49 * 2 - 6, r10_49, r10_49, "<", 0.75)
	end
	if currentMenu ~= "home" then
		local r1_49 = dosFontHeight * 0.85 + 12
		drawButton("menu", "home", 48, 568 - r1_49, dxGetTextWidth("< Vissza", 0.85, dosFont) + 24, r1_49, "< Vissza", 0.85)
	end
	dxSetRenderTarget()
end
function drawBorder(drawX, drawY, sizeX, sizeY, borderSize, borderColor)
	-- line: [1393, 1398] id: 50
	dxDrawRectangle(drawX, drawY, sizeX, borderSize, borderColor)
	dxDrawRectangle(drawX, drawY + sizeY - borderSize, sizeX, borderSize, borderColor)
	dxDrawRectangle(drawX, drawY, borderSize, sizeY, borderColor)
	dxDrawRectangle(drawX + sizeX - borderSize, drawY, borderSize, sizeY, borderColor)
end
function drawButton(actionType, actionArg, drawX, drawY, sizeX, sizeY, captionText, captionScale, cursorX, cursorY, fallbackX, fallbackY)
	-- line: [1400, 1416] id: 51
	if cursorX then
		if drawX <= cursorX and cursorX <= drawX + sizeX and drawY <= cursorY and cursorY <= drawY + sizeY then
			return actionType, actionArg
		end
		return fallbackX, fallbackY
	elseif hoverAction == actionType and hoverActionArg == actionArg then
		dxDrawRectangle(drawX, drawY, sizeX, sizeY, tocolor(255, 0, 0))
		dxDrawText(captionText, drawX, drawY, drawX + sizeX, drawY + sizeY, tocolor(0, 0, 0), captionScale, dosBoldFont, "center", "center")
	else
		drawBorder(drawX, drawY, sizeX, sizeY, 2, tocolor(255, 0, 0))
		dxDrawText(captionText, drawX, drawY, drawX + sizeX, drawY + sizeY, tocolor(255, 0, 0), captionScale, dosFont, "center", "center")
	end
end
function drawRedButton(actionType, actionArg, drawX, drawY, sizeX, sizeY, captionText, captionScale, cursorX, cursorY, fallbackX, fallbackY)
	-- line: [1418, 1434] id: 52
	if cursorX then
		if drawX <= cursorX and cursorX <= drawX + sizeX and drawY <= cursorY and cursorY <= drawY + sizeY then
			return actionType, actionArg
		end
		return fallbackX, fallbackY
	elseif hoverAction == actionType and hoverActionArg == actionArg then
		dxDrawRectangle(drawX, drawY, sizeX, sizeY, tocolor(0, 0, 255))
		dxDrawText(captionText, drawX, drawY, drawX + sizeX, drawY + sizeY, tocolor(0, 0, 0), captionScale, dosBoldFont, "center", "center")
	else
		drawBorder(drawX, drawY, sizeX, sizeY, 2, tocolor(0, 0, 255))
		dxDrawText(captionText, drawX, drawY, drawX + sizeX, drawY + sizeY, tocolor(0, 0, 255), captionScale, dosFont, "center", "center")
	end
end
function doTabletHover(cx, cy)
	-- line: [1437, 1705] id: 53
	local r2_53 = false
	local r3_53 = false
	if currentMenu == "home" then
		local r4_53 = 256 - dosFontHeight
		local r5_53 = dosFontHeight * 3.5
		local r6_53 = math.floor(r5_53 / 0.44326 * 0.927294) + 12
		if not mineNameSyncing and checkMinePermission("renameMine") and 48 <= cx and cx <= 48 + r6_53 and r4_53 <= cy and cy <= r4_53 + r5_53 then
			r3_53 = false
			r2_53 = "editMineName"
		end
		r4_53 = r4_53 + r5_53 + 20 + dosFontHeight + 6
		local r7_53 = dosFontHeight * 0.85 + 12
		r2_53, r3_53 = drawButton("menu", "ores", 48, r4_53, dxGetTextWidth("Nyersanyagok", 0.85, dosFont) + 24, r7_53, "Nyersanyagok", 0.85, cx, cy, r2_53, r3_53)
		r4_53 = r4_53 + r7_53 + 12
		r2_53, r3_53 = drawButton("menu", "map", 48, r4_53, dxGetTextWidth("Feltérképezés", 0.85, dosFont) + 24, r7_53, "Feltérképezés", 0.85, cx, cy, r2_53, r3_53)
		r4_53 = r4_53 + r7_53 + 12
		r2_53, r3_53 = drawButton("menu", "permissions", 48, r4_53, dxGetTextWidth("Jogosultságok", 0.85, dosFont) + 24, r7_53, "Jogosultságok", 0.85, cx, cy, r2_53, r3_53)
		r4_53 = r4_53 + r7_53 + 12
		r2_53, r3_53 = drawButton("menu", "shop", 48, r4_53, dxGetTextWidth("Rendelés", 0.85, dosFont) + 24, r7_53, "Rendelés", 0.85, cx, cy, r2_53, r3_53)
		r4_53 = r4_53 + r7_53 + 12
	elseif currentMenu == "shop" then
		local r4_53 = 48
		local r5_53 = dosFontHeight * 0.85 + 12
		if not currentMineInventory.tankOutside then
			local r7_53 = dxGetTextWidth(("Üzemanyagtartály: " .. math.floor(currentMineInventory.displayedFuelTankLevel * 10) / 10 .. "/1000 L"), 0.9, dosFont) + 12
			if tankPreRequest == currentMine then
				r2_53, r3_53 = drawButton("requestMineFuelTank", false, 48 + r7_53, r4_53, dxGetTextWidth("Feltöltés megszakítása", 0.85, dosFont) + 24, r5_53, "Feltöltés megszakítása", 0.85, cx, cy, r2_53, r3_53)
			else
				r2_53, r3_53 = drawButton("requestMineFuelTank", false, 48 + r7_53, r4_53, dxGetTextWidth("Tartály feltöltése", 0.85, dosFont) + 24, r5_53, "Tartály feltöltése", 0.85, cx, cy, r2_53, r3_53)
			end
		end
		if not mineOrderSyncing then
			local r6_53 = dxGetTextWidth("Megnevezés", 0.9, dosFont) + 32
			local r7_53 = dxGetTextWidth("Raktár", 0.9, dosFont) + 32
			local r8_53 = dxGetTextWidth("Rendelés", 0.9, dosFont) + 40
			local r10_53 = 400 - (r6_53 + r7_53 + r8_53 + (dxGetTextWidth("Egységár", 0.9, dosFont) + 48) * 2) / 2
			r4_53 = r4_53 + r5_53 + 6 + dosFontHeight + 24 + dosFontHeight
			local r11_53 = currentMineInventory.dieselLoco
			if r11_53 then
				r11_53 = 6 or 1
			else
				r11_53 = 1
			end
			local r12_53 = false
			if mineOrdering.subCart then
				local r13_53 = {}
				local r14_53 = currentMineInventory.subCartNum + (mineOrdering.subCart or 0)
				if r14_53 < r11_53 then
					r14_53 = mineOrdering.subCart or 0
					r14_53 = r14_53 < #trailerOffsets.subCart
				else
					-- goto label_289	-- block#25 is visited secondly
				end
				r13_53.subCart = r14_53
				r12_53 = r13_53
			elseif not mineOrdering.dieselEngine and not currentMineOrder then
				local r13_53 = {}
				local r14_53 = math.ceil(currentMineInventory.railIrons / 50) + (mineOrdering.railIrons or 0)
				if r14_53 < 2 then
					r14_53 = mineOrdering.railIrons or 0
					r14_53 = r14_53 < #trailerOffsets.railIrons - (mineOrdering.railWoods or 0)
				else
					-- goto label_332	-- block#38 is visited secondly
				end
				r13_53.railIron = r14_53
				r14_53 = math.ceil(currentMineInventory.railWoods / 125) + (mineOrdering.railWoods or 0)
				if r14_53 < 2 then
					r14_53 = mineOrdering.railWoods or 0
					r14_53 = r14_53 < #trailerOffsets.railWoods - (mineOrdering.railIrons or 0)
				else
					-- goto label_365	-- block#48 is visited secondly
				end
				r13_53.railWood = r14_53
				r14_53 = math.ceil(currentMineInventory.mineLamps / 20) + (mineOrdering.mineLamps or 0)
				if r14_53 < 2 then
					r14_53 = mineOrdering.mineLamps or 0
					r14_53 = r14_53 < #trailerOffsets.mineLamps
				else
					-- goto label_392	-- block#56 is visited secondly
				end
				r13_53.mineLamps = r14_53
				r14_53 = currentMineInventory.dieselLoco
				if r14_53 then
					r14_53 = 1 or 0
				else
					r14_53 = 0
				end
				r14_53 = r14_53 + (mineOrdering.dieselEngine or 0)
				if r14_53 < 1 then
					r14_53 = mineOrdering.dieselEngine or 0
					r14_53 = r14_53 < #trailerOffsets.dieselEngine
				else
					-- goto label_420	-- block#67 is visited secondly
				end
				r13_53.dieselEngine = r14_53
				r14_53 = currentMineInventory.subCartNum + (mineOrdering.subCart or 0)
				if r14_53 < r11_53 then
					r14_53 = mineOrdering.subCart or 0
					r14_53 = r14_53 < #trailerOffsets.subCart
				else
					-- goto label_442	-- block#75 is visited secondly
				end
				r13_53.subCart = r14_53
				r12_53 = r13_53
				if mineOrdering.railIrons or mineOrdering.railWoods then
					r12_53.mineLamps = false
					r12_53.dieselEngine = false
					r12_53.subCart = false
				elseif mineOrdering.mineLamps then
					r12_53.railIron = false
					r12_53.railWood = false
					r12_53.dieselEngine = false
					r12_53.subCart = false
				end
			end
			local r13_53 = dosFontHeight * 0.75 + 8
			r4_53 = r4_53 + dosFontHeight + 8
			if not currentMineOrder or currentMineOrder.railIron then
				if (mineOrdering.railIrons or 0) > 0 then
					r2_53, r3_53 = drawButton("orderMinus", "railIrons", r10_53 + r6_53 + r7_53 + r8_53 / 2 - r13_53 * 1.75, r4_53 + dosFontHeight / 2 - r13_53 / 2, r13_53, r13_53, "-", 0.75, cx, cy, r2_53, r3_53)
				end
				if r12_53 and r12_53.railIron then
					r2_53, r3_53 = drawButton("orderPlus", "railIrons", r10_53 + r6_53 + r7_53 + r8_53 / 2 + r13_53 * 0.75, r4_53 + dosFontHeight / 2 - r13_53 / 2, r13_53, r13_53, "+", 0.75, cx, cy, r2_53, r3_53)
				end
				r4_53 = r4_53 + dosFontHeight + 8
			end
			if not currentMineOrder or currentMineOrder.railWood then
				if (mineOrdering.railWoods or 0) > 0 then
					r2_53, r3_53 = drawButton("orderMinus", "railWoods", r10_53 + r6_53 + r7_53 + r8_53 / 2 - r13_53 * 1.75, r4_53 + dosFontHeight / 2 - r13_53 / 2, r13_53, r13_53, "-", 0.75, cx, cy, r2_53, r3_53)
				end
				if r12_53 and r12_53.railWood then
					r2_53, r3_53 = drawButton("orderPlus", "railWoods", r10_53 + r6_53 + r7_53 + r8_53 / 2 + r13_53 * 0.75, r4_53 + dosFontHeight / 2 - r13_53 / 2, r13_53, r13_53, "+", 0.75, cx, cy, r2_53, r3_53)
				end
				r4_53 = r4_53 + dosFontHeight + 8
			end
			if not currentMineOrder or currentMineOrder.mineLamps then
				if (mineOrdering.mineLamps or 0) > 0 then
					r2_53, r3_53 = drawButton("orderMinus", "mineLamps", r10_53 + r6_53 + r7_53 + r8_53 / 2 - r13_53 * 1.75, r4_53 + dosFontHeight / 2 - r13_53 / 2, r13_53, r13_53, "-", 0.75, cx, cy, r2_53, r3_53)
				end
				if r12_53 and r12_53.mineLamps then
					r2_53, r3_53 = drawButton("orderPlus", "mineLamps", r10_53 + r6_53 + r7_53 + r8_53 / 2 + r13_53 * 0.75, r4_53 + dosFontHeight / 2 - r13_53 / 2, r13_53, r13_53, "+", 0.75, cx, cy, r2_53, r3_53)
				end
				r4_53 = r4_53 + dosFontHeight + 8
			end
			if not currentMineOrder or currentMineOrder.dieselEngine then
				if (mineOrdering.dieselEngine or 0) > 0 then
					r2_53, r3_53 = drawButton("orderMinus", "dieselEngine", r10_53 + r6_53 + r7_53 + r8_53 / 2 - r13_53 * 1.75, r4_53 + dosFontHeight - r13_53 / 2, r13_53, r13_53, "-", 0.75, cx, cy, r2_53, r3_53)
				end
				if r12_53 and r12_53.dieselEngine then
					r2_53, r3_53 = drawButton("orderPlus", "dieselEngine", r10_53 + r6_53 + r7_53 + r8_53 / 2 + r13_53 * 0.75, r4_53 + dosFontHeight - r13_53 / 2, r13_53, r13_53, "+", 0.75, cx, cy, r2_53, r3_53)
				end
				r4_53 = r4_53 + dosFontHeight * 2 + 8
			end
			if not currentMineOrder or currentMineOrder.subCart then
				if (mineOrdering.subCart or 0) > 0 then
					r2_53, r3_53 = drawButton("orderMinus", "subCart", r10_53 + r6_53 + r7_53 + r8_53 / 2 - r13_53 * 1.75, r4_53 + dosFontHeight / 2 - r13_53 / 2, r13_53, r13_53, "-", 0.75, cx, cy, r2_53, r3_53)
				end
				if r12_53 and r12_53.subCart then
					r2_53, r3_53 = drawButton("orderPlus", "subCart", r10_53 + r6_53 + r7_53 + r8_53 / 2 + r13_53 * 0.75, r4_53 + dosFontHeight / 2 - r13_53 / 2, r13_53, r13_53, "+", 0.75, cx, cy, r2_53, r3_53)
				end
				r4_53 = r4_53 + dosFontHeight + 8
			end
			r4_53 = r4_53 + 16
			if currentMineOrder then
				r4_53 = r4_53 + dosFontHeight + dosFontHeight + 12
				if not currentMineOrderPaid then
					local r15_53 = dxGetTextWidth("Rendelés lemondása", 0.85, dosFont) + 24
					r2_53, r3_53 = drawButton("cancelMineOrder", false, 400 - r15_53 / 2, r4_53, r15_53, dosFontHeight * 0.85 + 12, "Rendelés lemondása", 0.85, cx, cy, r2_53, r3_53)
				end
			else
				local r14_53, r15_53, r16_53 = getOrderPrice(mineOrdering)
				if r14_53 > 0 then
					local r18_53 = dxGetTextWidth(("Rendelés leadása (" .. r16_53 .. ")"), 0.85, dosFont) + 24
					r2_53, r3_53 = drawButton("createMineOrder", false, 400 - r18_53 / 2, r4_53, r18_53, dosFontHeight * 0.85 + 12, "Rendelés leadása (" .. r16_53 .. ")", 0.85, cx, cy, r2_53, r3_53)
				end
			end
		end
	elseif currentMenu == "permissions" then
		if workerToRegister then
			local r4_53 = 182
			local r5_53 = dosFontHeight * 0.85 + 12
			if isElement(workerToRegister) then
				r2_53, r3_53 = drawButton("registerYes", false, 212, 388 - r5_53, r4_53, r5_53, "Igen", 0.85, cx, cy, r2_53, r3_53)
			else
				r2_53, r3_53 = drawButton("registerNext", false, 212, 388 - r5_53, r4_53, r5_53, "Regisztráció", 0.85, cx, cy, r2_53, r3_53)
			end
			r2_53, r3_53 = drawButton("promptNo", false, 600 - r4_53 - 12, 388 - r5_53, r4_53, r5_53, "Mégsem", 0.85, cx, cy, r2_53, r3_53)
		elseif workerToFire then
			local r4_53 = 182
			local r5_53 = dosFontHeight * 0.85 + 12
			r2_53, r3_53 = drawButton("fireYes", false, 212, 388 - r5_53, r4_53, r5_53, "Igen", 0.85, cx, cy, r2_53, r3_53)
			r2_53, r3_53 = drawButton("promptNo", false, 600 - r4_53 - 12, 388 - r5_53, r4_53, r5_53, "Nem", 0.85, cx, cy, r2_53, r3_53)
		else
			local r5_53 = dosFontHeight * 0.85 + 6
			local r4_53 = 48 + r5_53 + dosFontHeight
			local r6_53 = 250
			local r7_53 = #currentMineWorkersList
			for r11_53 = 1, r7_53, 1 do
				if checkMinePermission("managePermissions") then
					r2_53, r3_53 = drawRedButton("fire", r11_53, 48, r4_53 + 2, r5_53 - 4, r5_53 - 4, "x", 0.85, cx, cy, r2_53, r3_53)
				end
				for r15_53 = 1, #permissionList, 1 do
					r2_53, r3_53 = drawButton("permission", (r11_53 - 1) * #permissionList + r15_53 - 1, 48 + r6_53 + 12 + (r5_53 + 4) * r15_53, r4_53 + 2, r5_53 - 4, r5_53 - 4, " ", 0.85, cx, cy, r2_53, r3_53)
				end
				if r11_53 < r7_53 then
					r4_53 = r4_53 + r5_53 + 3 + r5_53 / 5 + 3
				else
					r4_53 = r4_53 + r5_53 + 12
				end
			end
			if r7_53 < 10 and checkMinePermission("managePermissions") then
				r2_53, r3_53 = drawButton("addWorker", false, 48, r4_53, dxGetTextWidth("Munkás regisztrálása", 0.85, dosFont) + 24, dosFontHeight * 0.85 + 12, "Munkás regisztrálása", 0.85, cx, cy, r2_53, r3_53)
			end
		end
	elseif currentMenu == "map" then
		local r4_53 = dosFontHeight * 0.75 + 8
		r2_53, r3_53 = drawButton("mapZoom", -0.25, 752 - r4_53 * 4 - 24, 552 - r4_53, r4_53, r4_53, "-", 0.75, cx, cy, r2_53, r3_53)
		r2_53, r3_53 = drawButton("mapZoom", 0.25, 752 - r4_53 * 4 - 24, 552 - r4_53 * 2 - 6, r4_53, r4_53, "+", 0.75, cx, cy, r2_53, r3_53)
		r2_53, r3_53 = drawButton("mapMoveY", -1, 752 - r4_53, 552 - r4_53 * 2 - 6, r4_53, r4_53, ">", 0.75, cx, cy, r2_53, r3_53)
		r2_53, r3_53 = drawButton("mapMoveX", -1, 752 - r4_53 * 2 - 6, 552 - r4_53, r4_53, r4_53, "\\/", 0.75, cx, cy, r2_53, r3_53)
		if mapData.mx or mapData.my then
			r2_53, r3_53 = drawButton("mapCenter", 0, 752 - r4_53 * 2 - 6, 552 - r4_53 * 2 - 6, r4_53, r4_53, "O", 0.75, cx, cy, r2_53, r3_53)
		end
		r2_53, r3_53 = drawButton("mapMoveX", 1, 752 - r4_53 * 2 - 6, 552 - r4_53 * 3 - 12, r4_53, r4_53, "/\\", 0.75, cx, cy, r2_53, r3_53)
		r2_53, r3_53 = drawButton("mapMoveY", 1, 752 - r4_53 * 3 - 12, 552 - r4_53 * 2 - 6, r4_53, r4_53, "<", 0.75, cx, cy, r2_53, r3_53)
	end
	if currentMenu ~= "home" then
		local r4_53 = dosFontHeight * 0.85 + 12
		r2_53, r3_53 = drawButton("menu", "home", 48, 568 - r4_53, dxGetTextWidth("< Vissza", 0.85, dosFont) + 24, r4_53, "< Vissza", 0.85, cx, cy, r2_53, r3_53)
	end
	return r2_53, r3_53
end
addEvent("renameMineResponse", true)
addEventHandler("renameMineResponse", getRootElement(), function(newName)
	-- line: [1709, 1713] id: 54
	mineNameSyncing = false
	currentMineName = newName
	forceTabletDraw = true
end)
addEvent("mineOrderResponse", true)
addEventHandler("mineOrderResponse", getRootElement(), function(r0_55)
	-- line: [1717, 1720] id: 55
	mineOrderSyncing = false
	forceTabletDraw = true
end)
function endMineNameEdit()
	-- line: [1722, 1744] id: 56
	showCursor(false)
	for i = #currentMineName, 1, -1 do
		if not currentMineName[i] or utf8.len(currentMineName[i]) <= 1 then
			table.remove(currentMineName, i)
		else
			break
		end
	end
	currentNameLine = false
	if mineNameEdited then
		mineNameSyncing = true
		triggerServerEvent("renameMine", localPlayer, currentMineName)
	end
	checkMineTableCharacter(false)
	checkMineTableKey(false)
	forceTabletDraw = true
end
function revalidateTabletOrder()
	-- line: [1746, 1749] id: 57
	refreshOrderConstraints(mineOrdering, currentMineInventory)
	forceTabletDraw = true
end
function clickTablet(button, state, absX, absY)
	-- line: [1751, 1931] id: 58
	if hoverAction == "moveTablet" or tabletMoving then
		if state == "up" then
			endTabletMoving()
		else
			tabletMoving = {absX, absY}
			seexports.sGui:setCursorType("move")
		end
	elseif state == "up" then
		if currentNameLine then
			if hoverAction ~= "editMineName" then
				endMineNameEdit()
			end
			return
		end
		if hoverAction == "mapMoveX" then
			mapData.mx = (mapData.mx or selfMineX) + hoverActionArg
			forceTabletDraw = true
		elseif hoverAction == "mapMoveY" then
			mapData.my = (mapData.my or selfMineY) + hoverActionArg
			forceTabletDraw = true
		elseif tempHoverAction == "permission" then
			if checkMinePermission("managePermissions") then
				local characterId = currentMineWorkersList[math.floor(hoverActionArg / #permissionList) + 1]
				local permissionName = permissionList[hoverActionArg % #permissionList + 1][1]
				local permissionState = currentMineWorkers[characterId][permissionName]
				iprint(permissionName, permissionState)
				if unsyncedPermissions[characterId] and (unsyncedPermissions[characterId][permissionName] or unsyncedPermissions[characterId][permissionName] == false) then
					permissionState = unsyncedPermissions[characterId][permissionName]
				end
				setMinePermission(characterId, permissionName, not permissionState)
			end
		elseif hoverAction == "cancelMineOrder" then
			if not checkMinePermission("order") then
				seexports.sGui:showInfobox("e", "Nincs jogosultságod ehhez!")
				return
			end
			triggerServerEvent("cancelMineOrder", localPlayer, mineOrdering)
			mineOrderSyncing = true
			forceTabletDraw = true
		elseif hoverAction == "createMineOrder" then
			if not checkMinePermission("order") then
				seexports.sGui:showInfobox("e", "Nincs jogosultságod ehhez!")
				return
			end
			revalidateTabletOrder()
			triggerServerEvent("createMineOrder", localPlayer, mineOrdering)
			mineOrderSyncing = true
			forceTabletDraw = true
		elseif hoverAction == "mapCenter" then
			mapData.mx = false
			mapData.my = false
			forceTabletDraw = true
		elseif hoverAction == "requestMineFuelTank" then
			if not checkMinePermission("order") then
				seexports.sGui:showInfobox("e", "Nincs jogosultságod ehhez!")
				return
			end
			triggerServerEvent("requestMineFuelTank", localPlayer)
		elseif hoverAction == "orderPlus" then
			mineOrdering[hoverActionArg] = (mineOrdering[hoverActionArg] or 0) + 1
			revalidateTabletOrder()
		elseif hoverAction == "orderMinus" then
			mineOrdering[hoverActionArg] = (mineOrdering[hoverActionArg] or 0) - 1
			revalidateTabletOrder()
		elseif hoverAction == "editMineName" then
			if mineNameSyncing then
				return
			end
			showCursor(true)
			currentNameLine = #currentMineName
			checkMineTableCharacter(true)
			checkMineTableKey(true, "high+9999999")
			forceTabletDraw = true
		elseif hoverAction == "mapZoom" then
			mapData.zoom = math.max(0.25, math.min(1.5, mapData.zoom + hoverActionArg))
			forceTabletDraw = true
		elseif hoverAction == "menu" then
			setCurrentTabletMenu(hoverActionArg)
		elseif hoverAction == "registerNext" then
			tabletRegisterNext()
		elseif hoverAction == "registerYes" then
			if isElement(workerToRegister) then
				triggerServerEvent("addcurrentMineWorkers", localPlayer, currentMine, workerToRegister)
			end
			workerToFire = false
			workerToRegister = false
			forceTabletDraw = true
		elseif hoverAction == "fireYes" then
			if permissionList[workerToFire] then
				triggerServerEvent("removeFromcurrentMineWorkers", localPlayer, currentMine, permissionList[workerToFire])
			end
			workerToFire = false
			workerToRegister = false
			forceTabletDraw = true
		elseif hoverAction == "promptNo" then
			workerToFire = false
			workerToRegister = false
			forceTabletDraw = true
			checkAddWorkerCharacter(false)
			checkAddWorkerKey(false)
		elseif hoverAction == "fire" then
			workerToFire = hoverActionArg
			workerToRegister = false
			forceTabletDraw = true
		elseif hoverAction == "addWorker" then
			workerNameToRegister = ""
			workerToFire = false
			workerToRegister = true
			forceTabletDraw = true
			checkAddWorkerCharacter(true)
			checkAddWorkerKey(true)
		elseif hoverAction == "turnOffComputer" then
			deleteComputer()
		elseif hoverAction == "zoomInTablet" and tabletZoom < 1 then
			local scaleFactorWas = math.min(1, screenY / 1000) * tabletZoom
			tabletZoom = math.min(1, tabletZoom + 0.125)
			local scaleFactor = math.min(1, screenY / 1000) * tabletZoom
			saveTabletZoom()
			tabletPosX = absX + (tabletPosX - absX) * scaleFactor / scaleFactorWas
			tabletPosY = absY + (tabletPosY - absY) * scaleFactor / scaleFactorWas
			tabletPosX = math.max(0, math.min(screenX, tabletPosX))
			tabletPosY = math.max(0, math.min(screenY, tabletPosY))
			saveTabletPos()
		elseif hoverAction == "zoomOutTablet" and 0.5 < tabletZoom then
			local scaleFactorWas = math.min(1, screenY / 1000) * tabletZoom
			tabletZoom = math.max(0.5, tabletZoom - 0.125)
			local scaleFactor = math.min(1, screenY / 1000) * tabletZoom
			saveTabletZoom()
			tabletPosX = absX + (tabletPosX - absX) * scaleFactor / scaleFactorWas
			tabletPosY = absY + (tabletPosY - absY) * scaleFactor / scaleFactorWas
			tabletPosX = math.max(0, math.min(screenX, tabletPosX))
			tabletPosY = math.max(0, math.min(screenY, tabletPosY))
			saveTabletPos()
		end
	end
end
function restoreTablet()
	-- line: [1933, 1935] id: 59
	forceTabletDraw = true
end
function drawComputer()
	-- line: [1937, 1958] id: 60
	local scaleMul = math.min(1, screenY / 1000)
	local basePosX = screenX / 2 - 400 * scaleMul
	local basePosY = screenY / 2 + -326 * scaleMul
	seelangStaticImageUsed[9] = true
	if seelangStaticImageToc[9] then
		processSeelangStaticImage[9]()
	end
	dxDrawImage(basePosX - 140 * scaleMul, basePosY - 214 * scaleMul, 1080 * scaleMul, 1080 * scaleMul, seelangStaticImage[9])
	local baseWidth = 800 * scaleMul
	local baseHeight = 600 * scaleMul
	if computerLoadingProgress < 1 then
		local scaledWidth = baseWidth * (1 - math.min(1, computerLoadingProgress * 6))
		local scaledHeight = baseHeight * (1 - math.min(1, computerLoadingProgress * 3))
		local alphaProgress = math.min(1, computerLoadingProgress * 1.5)
		dxDrawImage(basePosX + scaledWidth / 2, basePosY + scaledHeight / 2, baseWidth - scaledWidth, baseHeight - scaledHeight, tabletShader, 0, 0, 0, tocolor(255 * alphaProgress, 255 * alphaProgress, 255 * alphaProgress, computerLoadingProgress))
	else
		dxDrawImage(basePosX, basePosY, baseWidth, baseHeight, tabletShader)
	end
	seelangStaticImageUsed[10] = true
	if seelangStaticImageToc[10] then
		processSeelangStaticImage[10]()
	end
	dxDrawImage(basePosX - 140 * scaleMul, basePosY - 214 * scaleMul, 1080 * scaleMul, 1080 * scaleMul, seelangStaticImage[10])
end
function hoverComputer()
	-- line: [1960, 1988] id: 61
	local scaleMul = math.min(1, screenY / 1000)
	local basePosX = screenX / 2 - 400 * scaleMul
	local basePosY = screenY / 2 + -326 * scaleMul
	local cx, cy = getCursorPosition()
	if cx then
		cx = cx * screenX
		cy = cy * screenY
		local closePosX = basePosX - 140 * scaleMul
		local closePosY = basePosY - 214 * scaleMul
		if closePosX + 867 * scaleMul <= cx and cx <= closePosX + 916 * scaleMul and closePosY + 855 * scaleMul <= cy and cy <= closePosY + 903 * scaleMul then
			tempHoverActionArg = false
			tempHoverAction = "turnOffComputer"
		elseif computerLoadingProgress * 3 >= 1 then
			cx = (cx - basePosX) / scaleMul
			cy = (cy - basePosY) / scaleMul
			if 0 < cx and cx < 800 and 0 < cy and cy < 600 then
				tabletHovering = true
				tempHoverAction, tempHoverActionArg = doTabletHover(cx, cy)
			end
		end
	end
end
function drawTablet()
	-- line: [1990, 1997] id: 62
	local zoomP = math.min(1, screenY / 1000) * tabletZoom
	local baseX = tabletPosX - 400 * zoomP
	local baseY = tabletPosY - 300 * zoomP
	seelangStaticImageUsed[11] = true
	if seelangStaticImageToc[11] then
		processSeelangStaticImage[11]()
	end
	dxDrawImage(baseX - 200 * zoomP, baseY - 150 * zoomP, 1200 * zoomP, 900 * zoomP, seelangStaticImage[11])
	dxDrawImage(baseX, baseY, 800 * zoomP, 600 * zoomP, tabletShader)
	seelangStaticImageUsed[12] = true
	if seelangStaticImageToc[12] then
		processSeelangStaticImage[12]()
	end
	dxDrawImage(baseX - 200 * zoomP, baseY - 150 * zoomP, 1200 * zoomP, 900 * zoomP, seelangStaticImage[12])
end
function hoverTablet()
	-- line: [1999, 2045] id: 63
	local zoomP = math.min(1, screenY / 1000) * tabletZoom
	local baseX = tabletPosX - 400 * zoomP
	local baseY = tabletPosY - 300 * zoomP
	local cursorX, cursorY = getCursorPosition()
	if cursorX then
		cursorX = cursorX * screenX
		cursorY = cursorY * screenY
		if tabletMoving then
			tabletPosX = math.max(0, math.min(screenX, tabletPosX + cursorX - tabletMoving[1]))
			tabletPosY = math.max(0, math.min(screenY, tabletPosY + cursorY - tabletMoving[2]))
			tabletMoving[1] = cursorX
			tabletMoving[2] = cursorY
		else
			local moveX = baseX - 200 * zoomP
			local moveY = baseY - 150 * zoomP
			if moveX + 56 * zoomP <= cursorX and cursorX <= moveX + 1145 * zoomP and moveY + 34 * zoomP <= cursorY and cursorY <= moveY + 866 * zoomP then
				tempHoverAction = "moveTablet"
			end
			if moveX + 1042 * zoomP <= cursorX and cursorX <= moveX + 1088 * zoomP then
				if moveY + 704 * zoomP <= cursorY and cursorY <= moveY + 750 * zoomP then
					tempHoverAction = "zoomInTablet"
				elseif moveY + 759 * zoomP <= cursorY and cursorY <= moveY + 805 * zoomP then
					tempHoverAction = "zoomOutTablet"
				end
			end
			cursorX = (cursorX - baseX) / zoomP
			cursorY = (cursorY - baseY) / zoomP
			if 0 < cursorX and cursorX < 800 and 0 < cursorY and cursorY < 600 then
				tabletHovering = true
				tempHoverAction, tempHoverActionArg = doTabletHover(cursorX, cursorY)
			end
		end
	else
		endTabletMoving()
	end
end
function preRenderComputer(r0_64)
	-- line: [2047, 2072] id: 64
	if computerState then
		if getDistanceBetweenPoints2D(-32.6914, -3.7004, selfPosX, selfPosY) > 2.5 then
			deleteComputer()
		end
		computerLoadingProgress = math.min(1, computerLoadingProgress + r0_64 / 2000)
		setSoundVolume(computerLoopSound, math.min(1, computerLoadingProgress * 5) * 0.5)
		setSoundSpeed(computerLoopSound, 0.5 + 0.5 * computerLoadingProgress)
	else
		computerLoadingProgress = computerLoadingProgress - r0_64 / 1000
		setSoundVolume(computerLoopSound, math.min(1, computerLoadingProgress * 5) * 0.5)
		setSoundSpeed(computerLoopSound, 0.5 + 0.5 * computerLoadingProgress)
		if computerLoadingProgress < 0 then
			computerLoadingProgress = 0
			if isElement(computerLoopSound) then
				destroyElement(computerLoopSound)
			end
			computerLoopSound = nil
			checkPreRenderComputer(false)
		end
	end
end
function renderTablet()
	-- line: [2074, 2156] id: 65
	local hoverRefresh = false
	tempHoverAction = false
	tempHoverActionArg = false
	if computerState then
		hoverComputer()
	elseif tabletState then
		hoverTablet()
	end
	if tempHoverAction ~= hoverAction or tempHoverActionArg ~= hoverActionArg then
		hoverRefresh = true
		hoverAction = tempHoverAction
		hoverActionArg = tempHoverActionArg
		if tempHoverAction == "moveTablet" or tabletMoving then
			seexports.sGui:setCursorType("move")
			seexports.sGui:showTooltip()
		else
			seexports.sGui:setCursorType(tempHoverAction and "link" or "normal")
			if tempHoverAction == "turnOffComputer" then
				seexports.sGui:showTooltip("Számítógép kikapcsolása")
			elseif tempHoverAction == "zoomInTablet" then
				seexports.sGui:showTooltip("Tablet nagyítása")
			elseif tempHoverAction == "zoomOutTablet" then
				seexports.sGui:showTooltip("Tablet kicsinyítése")
			elseif tempHoverAction == "fire" then
				seexports.sGui:showTooltip("Kirúgás")
			elseif tempHoverAction == "permission" then
				seexports.sGui:showTooltip(permissionList[hoverActionArg % #permissionList + 1][2])
			else
				seexports.sGui:showTooltip()
			end
		end
	end
	local shouldDrawTablet = false
	if currentMenu == "map" or currentMenu == "home" or currentMenu == "shop" and mineOrderSyncing then
		shouldDrawTablet = 250 < getTickCount() % 500
	elseif currentMenu == "permissions" and workerToRegister and not isElement(workerToRegister) then
		shouldDrawTablet = 250 < getTickCount() % 500
	elseif currentMenu == "ores" then
		if mineBoxContentRefresh or mineFoundryContentRefresh or mineFoundryData.furnaceRunning then
			forceTabletDraw = true
		end
		if mineFoundryData.furnaceRunning or mineFoundryData.meltingOre then
			shouldDrawTablet = 250 < getTickCount() % 500
		else
			shouldDrawTablet = true
		end
	end
	if tabletDrawn ~= shouldDrawTablet or forceTabletDraw or hoverRefresh then
		tabletDrawn = shouldDrawTablet
		forceTabletDraw = false
		drawRenderTarget(shouldDrawTablet)
	end
	if computerState then
		drawComputer()
	elseif tabletState then
		drawTablet()
	end
	seelangStaticImageUsed[11] = true
	if seelangStaticImageToc[11] then
		processSeelangStaticImage[11]()
	end
	seelangStaticImageUsed[12] = true
	if seelangStaticImageToc[12] then
		processSeelangStaticImage[12]()
	end
end
