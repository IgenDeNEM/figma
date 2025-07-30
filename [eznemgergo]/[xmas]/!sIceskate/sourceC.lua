-- filename: 
-- version: lua51
-- line: [0, 0] id: 0
local r0_0 = {
	sModloader = false,
	sPattach = false,
	sDashboard = false,
 }
 local function r1_0()
	-- line: [1, 1] id: 1
	for r3_1 in pairs(r0_0) do
	  local r4_1 = getResourceFromName(r3_1)
	  if r4_1 and getResourceState(r4_1) == "running" then
		 r0_0[r3_1] = exports[r3_1]
	  else
		 r0_0[r3_1] = false
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
 local r3_0 = {}
 local r4_0 = {}
 local r5_0 = {}
 local r6_0 = {}
 local r7_0 = {}
 r4_0[0] = true
 r4_0[1] = true
 r4_0[2] = true
 r4_0[3] = true
 local r8_0 = nil
 function r8_0()
	-- line: [1, 1] id: 2
	local r0_2 = getTickCount()
	if r5_0[0] then
	  r5_0[0] = false
	  r6_0[0] = false
	elseif r3_0[0] then
	  if r6_0[0] then
		 if r6_0[0] <= r0_2 then
			if isElement(r3_0[0]) then
			  destroyElement(r3_0[0])
			end
			r3_0[0] = nil
			r6_0[0] = false
			r4_0[0] = true
			return 
		 end
	  else
		 r6_0[0] = r0_2 + 5000
	  end
	else
	  r4_0[0] = true
	end
	if r5_0[1] then
	  r5_0[1] = false
	  r6_0[1] = false
	elseif r3_0[1] then
	  if r6_0[1] then
		 if r6_0[1] <= r0_2 then
			if isElement(r3_0[1]) then
			  destroyElement(r3_0[1])
			end
			r3_0[1] = nil
			r6_0[1] = false
			r4_0[1] = true
			return 
		 end
	  else
		 r6_0[1] = r0_2 + 5000
	  end
	else
	  r4_0[1] = true
	end
	if r5_0[2] then
	  r5_0[2] = false
	  r6_0[2] = false
	elseif r3_0[2] then
	  if r6_0[2] then
		 if r6_0[2] <= r0_2 then
			if isElement(r3_0[2]) then
			  destroyElement(r3_0[2])
			end
			r3_0[2] = nil
			r6_0[2] = false
			r4_0[2] = true
			return 
		 end
	  else
		 r6_0[2] = r0_2 + 5000
	  end
	else
	  r4_0[2] = true
	end
	if r5_0[3] then
	  r5_0[3] = false
	  r6_0[3] = false
	elseif r3_0[3] then
	  if r6_0[3] then
		 if r6_0[3] <= r0_2 then
			if isElement(r3_0[3]) then
			  destroyElement(r3_0[3])
			end
			r3_0[3] = nil
			r6_0[3] = false
			r4_0[3] = true
			return 
		 end
	  else
		 r6_0[3] = r0_2 + 5000
	  end
	else
	  r4_0[3] = true
	end
	if r4_0[0] and r4_0[1] and r4_0[2] and r4_0[3] then
	  r2_0 = false
	  removeEventHandler("onClientPreRender", getRootElement(), r8_0)
	end
 end
 r7_0[0] = function()
	-- line: [1, 1] id: 3
	if not isElement(r3_0[0]) then
	  r4_0[0] = false
	  r3_0[0] = dxCreateTexture("files/snow_particle.dds", "argb", true)
	end
	if not r2_0 then
	  r2_0 = true
	  addEventHandler("onClientPreRender", getRootElement(), r8_0, true, "high+999999999")
	end
 end
 r7_0[1] = function()
	-- line: [1, 1] id: 4
	if not isElement(r3_0[1]) then
	  r4_0[1] = false
	  r3_0[1] = dxCreateTexture("files/tri.dds", "argb", true)
	end
	if not r2_0 then
	  r2_0 = true
	  addEventHandler("onClientPreRender", getRootElement(), r8_0, true, "high+999999999")
	end
 end
 r7_0[2] = function()
	-- line: [1, 1] id: 5
	if not isElement(r3_0[2]) then
	  r4_0[2] = false
	  r3_0[2] = dxCreateTexture("files/headlight.dds", "argb", true)
	end
	if not r2_0 then
	  r2_0 = true
	  addEventHandler("onClientPreRender", getRootElement(), r8_0, true, "high+999999999")
	end
 end
 r7_0[3] = function()
	-- line: [1, 1] id: 6
	if not isElement(r3_0[3]) then
	  r4_0[3] = false
	  r3_0[3] = dxCreateTexture("files/light.dds", "argb", true)
	end
	if not r2_0 then
	  r2_0 = true
	  addEventHandler("onClientPreRender", getRootElement(), r8_0, true, "high+999999999")
	end
 end
 local function r9_0()
	-- line: [1, 1] id: 7
	modloaderLoaded()
 end
 addEventHandler("modloaderLoaded", getRootElement(), r9_0)
 if getElementData(localPlayer, "loggedIn") or r0_0.sModloader and r0_0.sModloader:isModloaderLoaded() then
	addEventHandler("onClientResourceStart", getResourceRootElement(), r9_0)
 end
 local r10_0 = false
 local function r11_0(r0_8, r1_8)
	-- line: [1, 1] id: 8
	if r0_8 then
	  r0_8 = true
	end
	if r0_8 ~= r10_0 then
	  r10_0 = r0_8
	  if r0_8 then
		 addEventHandler("onClientPreRender", getRootElement(), preRenderLight, true, r1_8)
	  else
		 removeEventHandler("onClientPreRender", getRootElement(), preRenderLight)
	  end
	end
 end
 local r12_0 = false
 local function r13_0(r0_9, r1_9)
	-- line: [1, 1] id: 9
	if r0_9 then
	  r0_9 = true
	end
	if r0_9 ~= r12_0 then
	  r12_0 = r0_9
	  if r0_9 then
		 addEventHandler("onClientPreRender", getRootElement(), preRenderSkating, true, r1_9)
	  else
		 removeEventHandler("onClientPreRender", getRootElement(), preRenderSkating)
	  end
	end
 end
 local r14_0 = false
 local function r15_0(r0_10, r1_10)
	-- line: [1, 1] id: 10
	if r0_10 then
	  r0_10 = true
	end
	if r0_10 ~= r14_0 then
	  r14_0 = r0_10
	  if r0_10 then
		 addEventHandler("onClientPreRender", getRootElement(), preRenderParticles, true, r1_10)
	  else
		 removeEventHandler("onClientPreRender", getRootElement(), preRenderParticles)
	  end
	end
 end
 local r16_0 = false
 local function r17_0(r0_11, r1_11)
	-- line: [1, 1] id: 11
	if r0_11 then
	  r0_11 = true
	end
	if r0_11 ~= r16_0 then
	  r16_0 = r0_11
	  if r0_11 then
		 addEventHandler("onClientPreRender", getRootElement(), preRenderOtherSkating, true, r1_11)
	  else
		 removeEventHandler("onClientPreRender", getRootElement(), preRenderOtherSkating)
	  end
	end
 end
 local r18_0 = true
 if r0_0.sDashboard then
	r18_0 = r0_0.sDashboard:getStreamerMode()
 end
 local r19_0 = {}
 function seelangSoundDestroy()
	-- line: [1, 1] id: 12
	r19_0[source] = nil
 end
 function setStreamerModeVolume(r0_13, r1_13)
	-- line: [1, 1] id: 13
	if not r0_13 then
	  return 
	end
	if not r19_0[r0_13] then
	  addEventHandler("onClientElementDestroy", r0_13, seelangSoundDestroy)
	end
	r19_0[r0_13] = r1_13
	local r2_13 = setSoundVolume
	local r3_13 = r0_13
	local r4_13 = r18_0
	if r4_13 then
	  r4_13 = 0 or r1_13
	end
	r2_13(r3_13, r4_13)
 end
 addEventHandler("streamerModeChanged", getRootElement(), function(r0_14)
	-- line: [1, 1] id: 14
	r18_0 = r0_14
	for r4_14, r5_14 in pairs(r19_0) do
	  local r6_14 = setSoundVolume
	  local r7_14 = r4_14
	  local r8_14 = nil	-- notice: implicit variable refs by block#[4]
	  if r0_14 then
		 r8_14 = 0
		 if not r8_14 then
			r8_14 = r5_14
		 end
	  end
	  r6_14(r7_14, r8_14)
	end
 end)
 local r20_0, r21_0 = guiGetScreenSize()
 local r22_0 = createColSphere(-2352.580078125, 2279.24609, 5, 250)
 local r23_0 = false
 local r24_0 = {}
 local r25_0 = {}
 local r26_0 = {}
 local r27_0 = nil
 local r28_0 = false
 local r29_0 = false
 local r30_0 = -2321.8999
 local r31_0 = 2310.8
 local r32_0 = 4.1
 local r33_0 = 150
 function deInitSkating(leaveElement, matchingDimension)
	-- line: [21, 40] id: 15
	if leaveElement == localPlayer and matchingDimension then
		if r22_0 == source then
			r28_0 = false
			r29_0 = false
			if isElement(r23_0) then
			destroyElement(r23_0)
			end
			r23_0 = nil
			r17_0(false)
			for r3_15 in pairs(r24_0) do
			if isElement(r24_0[r3_15]) then
				destroyElement(r24_0[r3_15])
			end
			r24_0[r3_15] = nil
			end
			for r3_15 in pairs(r26_0) do
			if isElement(r26_0[r3_15]) then
				destroyElement(r26_0[r3_15])
			end
			r26_0[r3_15] = nil
			end
			for r3_15 in pairs(r25_0) do
			if isElement(r25_0[r3_15]) then
				destroyElement(r25_0[r3_15])
			end
			r25_0[r3_15] = nil
			end
		end
	end
 end
 function initSkating(hitElement, matchingDimension)
	-- line: [42, 57] id: 16
	if hitElement == localPlayer and matchingDimension then
		if r22_0 == source then
			deInitSkating()
			r28_0 = {}
			r29_0 = {}
			r23_0 = playSound3D("http://listen.livestreamingservice.com:8124/", -2352.580078125, 2279.24609, 5)
			setStreamerModeVolume(r23_0, 0.4)
			setSoundMinDistance(r23_0, 60)
			setSoundMaxDistance(r23_0, 200)
			setSoundEffectEnabled(r23_0, "i3dl2reverb", true)
			if r27_0 then
			r17_0(true)
			end
		end
	end
 end
 local r34_0 = false
 local r35_0 = false
 function modloaderLoaded()
	-- line: [63, 80] id: 17
	if isElement(r34_0) then
	  destroyElement(r34_0)
	end
	r34_0 = nil
	if isElement(r35_0) then
	  destroyElement(r35_0)
	end
	r35_0 = nil
	r34_0 = createObject(r0_0.sModloader:getModelId("v4_karifa"), r30_0, r31_0, r32_0, 0, 0, r33_0)
	r35_0 = createObject(r0_0.sModloader:getModelId("v4_karifa"), r30_0, r31_0, r32_0, 0, 0, r33_0, true)
	setLowLODElement(r34_0, r35_0)
	r27_0 = r0_0.sModloader:getModelId("v4_iceskate")
	if isElementWithinColShape(localPlayer, r22_0) then
	  initSkating(initSkating)
	end
	addEventHandler("onClientColShapeHit", root, initSkating)
	addEventHandler("onClientColShapeLeave", root, deInitSkating)
 end
 local r36_0 = 255
 local r37_0 = 255
 local r38_0 = 255
 function preRenderOtherSkating(r0_18)
	-- line: [85, 238] id: 18
	preRenderTree(r0_18)
	local r1_18 = getElementsWithinColShape(skateCol, "player")
	local r2_18 = {}
	local r3_18 = {}
	local r12_18 = nil
	for r7_18 = 1, #r1_18, 1 do
	  local r8_18 = r1_18[r7_18]
	  r3_18[r8_18] = true
	  if not isElement(r25_0[r8_18]) then
		 r25_0[r8_18] = createObject(r27_0, 0, 0, 0)
		 r0_0.sPattach:attach(r25_0[r8_18], r8_18, 44, 0, 0, -0.05, -90, -90, 0)
	  end
	  if not isElement(r26_0[r8_18]) then
		 r26_0[r8_18] = createObject(r27_0, 0, 0, 0)
		 r0_0.sPattach:attach(r26_0[r8_18], r8_18, 54, 0, 0, -0.05, -90, -90, 0)
	  end
	  r2_18[r8_18] = getPedWalkingStyle(r8_18) == 138
	  if not r28_0[r8_18] then
		 r28_0[r8_18] = {}
	  end
	  if not r29_0[r8_18] then
		 r29_0[r8_18] = {}
	  end
	  local r9_18 = isElementOnScreen(r8_18)
	  if r2_18[r8_18] and r9_18 then
		 local r10_18 = getElementBoneMatrix(r8_18, 44)
		 local r11_18 = getElementBoneMatrix(r8_18, 54)
		 if r10_18 then
			r12_18 = dot(r10_18[1][1], r10_18[1][2], r10_18[1][3], 0, 0, 1)
			if r12_18 < -0.6 then
			  spawnParticle(r10_18[4][1], r10_18[4][2], r10_18[4][3], -r10_18[1][1] * 0.75, -r10_18[1][2] * 0.75, -r10_18[1][3] * 0.75, 100 + 300 * math.random(), 200, 0.05, 0.5)
			  r12_18 = #r28_0[r8_18]
			  if r12_18 > 0 then
				 r12_18 = #r28_0[r8_18][#r28_0[r8_18]]
				 if r12_18 > 1 then
					r12_18 = table.insert
					r12_18(r28_0[r8_18], {
					  4
					})
				 end
			  end
			else
			  r12_18 = #r28_0[r8_18]
			  if r12_18 > 0 then
				 r12_18 = #r28_0[r8_18][#r28_0[r8_18]]
				 if r12_18 <= 1 then
					r12_18 = playSound3D("files/bladel" .. math.random(1, 3) .. ".wav", r10_18[4][1], r10_18[4][2], r10_18[4][3])
					setSoundVolume(r12_18, 0.5)
					attachElements(r12_18, r25_0[r8_18])
				 end
			  end
			  r12_18 = table.insert
			  r12_18(r28_0[r8_18], {
				 4,
				 r10_18[4][1],
				 r10_18[4][2]
			  })
			end
		 end
		 if r11_18 then
			r12_18 = dot(r11_18[1][1], r11_18[1][2], r11_18[1][3], 0, 0, 1)
			if r12_18 < -0.6 then
			  spawnParticle(r11_18[4][1], r11_18[4][2], r11_18[4][3], -r11_18[1][1] * 0.75, -r11_18[1][2] * 0.75, -r11_18[1][3] * 0.75, 100 + 300 * math.random(), 200, 0.05, 0.5)
			  r12_18 = #r29_0[r8_18]
			  if r12_18 > 0 then
				 r12_18 = #r29_0[r8_18][#r29_0[r8_18]]
				 if r12_18 > 1 then
					r12_18 = table.insert
					r12_18(r29_0[r8_18], {
					  4
					})
				 end
			  end
			else
			  r12_18 = #r29_0[r8_18]
			  if r12_18 > 0 then
				 r12_18 = #r29_0[r8_18][#r29_0[r8_18]]
				 if r12_18 <= 1 then
					r12_18 = playSound3D("files/blader" .. math.random(1, 3) .. ".wav", r11_18[4][1], r11_18[4][2], r11_18[4][3])
					setSoundVolume(r12_18, 0.5)
					attachElements(r12_18, r26_0[r8_18])
				 end
			  end
			  r12_18 = table.insert
			  r12_18(r29_0[r8_18], {
				 4,
				 r11_18[4][1],
				 r11_18[4][2]
			  })
			end
		 end
	  else
		 if 0 < #r28_0[r8_18] and 1 < #r28_0[r8_18][#r28_0[r8_18]] then
			local r10_18 = table.insert
			local r11_18 = r28_0[r8_18]
			r12_18 = {
			  4
			}
			r10_18(r11_18, r12_18)
		 end
		 if 0 < #r29_0[r8_18] and 1 < #r29_0[r8_18][#r29_0[r8_18]] then
			local r10_18 = table.insert
			local r11_18 = r29_0[r8_18]
			r12_18 = {
			  4
			}
			r10_18(r11_18, r12_18)
		 end
	  end
	  if r2_18[r8_18] then
		 if not isElement(r24_0[r8_18]) then
			r24_0[r8_18] = playSound3D("files/blade.wav", 0, 0, 0, true)
			attachElements(r24_0[r8_18], r8_18, 0, 0, -1)
		 end
		 local r10_18 = setSoundVolume
		 local r11_18 = r24_0[r8_18]
		 if r9_18 then
			r12_18 = 0
			if not r12_18 then
			  r12_18 = 0.5
			end
		 end
		 r10_18(r11_18, r12_18)
	  end
	end
	for r7_18, r8_18 in pairs(r28_0) do
	  if #r8_18 >= 2 then
		 for r12_18 = #r8_18, 1, -1 do
			r8_18[r12_18][1] = r8_18[r12_18][1] - 1 * r0_18 / 1000
			if r8_18[r12_18][1] <= 0 then
			  table.remove(r8_18, r12_18)
			elseif r8_18[r12_18 - 1] and 1 < #r8_18[(r12_18 - 1)] and 1 < #r8_18[r12_18] then
			  dxDrawLine3D(r8_18[r12_18 - 1][2], r8_18[r12_18 - 1][3], 4, r8_18[r12_18][2], r8_18[r12_18][3], 4, tocolor(r36_0, r37_0, r38_0, 100 * math.min(1, r8_18[r12_18][1])), 0.5)
			end
		 end
	  end
	end
	for r7_18, r8_18 in pairs(r29_0) do
	  if #r8_18 >= 2 then
		 for r12_18 = #r8_18, 1, -1 do
			r8_18[r12_18][1] = r8_18[r12_18][1] - 1 * r0_18 / 1000
			if r8_18[r12_18][1] <= 0 then
			  table.remove(r8_18, r12_18)
			elseif r8_18[r12_18 - 1] and 1 < #r8_18[(r12_18 - 1)] and 1 < #r8_18[r12_18] then
			  dxDrawLine3D(r8_18[r12_18 - 1][2], r8_18[r12_18 - 1][3], 4, r8_18[r12_18][2], r8_18[r12_18][3], 4, tocolor(r36_0, r37_0, r38_0, 100 * math.min(1, r8_18[r12_18][1])), 0.5)
			end
		 end
	  end
	end
	for r7_18 in pairs(r26_0) do
	  local r8_18 = r3_18[r7_18]
	  if not r8_18 then
		 r8_18 = isElement(r26_0[r7_18])
		 if r8_18 then
			destroyElement(r26_0[r7_18])
		 end
		 r8_18 = r26_0
		 r8_18[r7_18] = nil
	  end
	end
	for r7_18 in pairs(r25_0) do
	  local r8_18 = r3_18[r7_18]
	  if not r8_18 then
		 r8_18 = isElement(r25_0[r7_18])
		 if r8_18 then
			destroyElement(r25_0[r7_18])
		 end
		 r8_18 = r25_0
		 r8_18[r7_18] = nil
	  end
	end
	for r7_18 in pairs(r24_0) do
	  local r8_18 = r2_18[r7_18]
	  if not r8_18 then
		 r8_18 = isElement(r24_0[r7_18])
		 if r8_18 then
			destroyElement(r24_0[r7_18])
		 end
		 r8_18 = r24_0
		 r8_18[r7_18] = nil
	  end
	end
 end
 local r39_0 = {}
 function spawnParticle(r0_19, r1_19, r2_19, r3_19, r4_19, r5_19, r6_19, r7_19, r8_19, r9_19)
	-- line: [242, 253] id: 19
	table.insert(r39_0, {
	  r0_19,
	  r1_19,
	  r2_19,
	  r3_19,
	  r4_19,
	  r5_19,
	  getTickCount(),
	  r6_19,
	  r36_0,
	  r37_0,
	  r38_0,
	  r7_19,
	  r8_19,
	  r9_19
	})
	r15_0(true)
 end
 function preRenderParticles(r0_20)
	-- line: [255, 323] id: 20
	local r1_20, r2_20 = getTime()
	r1_20 = math.abs((r1_20 + r2_20 / 60 - 12)) / 12
	r38_0 = 255 - r1_20 * 45
	r37_0 = 255 - r1_20 * 50
	r36_0 = 255 - r1_20 * 50
	r36_0 = r36_0 * 0.8
	local r3_20 = getTickCount()
	if #r39_0 > 0 then
	  local r4_20, r5_20, r6_20 = getWorldFromScreenPosition(r20_0 / 2, 0, 128)
	  local r7_20, r8_20, r9_20 = getWorldFromScreenPosition(r20_0 / 2, r21_0 / 2, 128)
	  r4_20 = r7_20 - r4_20
	  r5_20 = r8_20 - r5_20
	  r6_20 = r9_20 - r6_20
	  local r10_20 = math.sqrt((r4_20 * r4_20 + r5_20 * r5_20 + r6_20 * r6_20)) * 2
	  r4_20 = -r4_20 / r10_20
	  r5_20 = -r5_20 / r10_20
	  r6_20 = -r6_20 / r10_20
	  for r14_20 = #r39_0, 1, -1 do
		 local r15_20 = r39_0[r14_20]
		 if r15_20 then
			r15_20[1] = r15_20[1] + r15_20[4] * r0_20 / 1000
			r15_20[2] = r15_20[2] + r15_20[5] * r0_20 / 1000
			r15_20[3] = r15_20[3] + r15_20[6] * r0_20 / 1000
			local r16_20 = (r3_20 - r15_20[7]) / 50
			if r16_20 > 1 then
			  r16_20 = 1
			end
			if r15_20[8] < r3_20 - r15_20[7] then
			  r16_20 = 1 - (r3_20 - r15_20[7] + r15_20[8]) / 600
			  if r16_20 < 0 then
				 r16_20 = 0
				 table.remove(r39_0, r14_20)
			  end
			end
			r15_20[13] = r15_20[13] + r15_20[14] * r0_20 / 1000
			local r17_20 = math.floor(r15_20[13] * 250 % 16)
			local r18_20 = r17_20 % 4
			local r19_20 = math.floor(r17_20 / 4)
			r5_0[0] = true
			if r4_0[0] then
			  r7_0[0]()
			end
			dxDrawMaterialLine3D(r15_20[1] + r4_20 * r15_20[13], r15_20[2] + r5_20 * r15_20[13], r15_20[3] + r6_20 * r15_20[13], r15_20[1] - r4_20 * r15_20[13], r15_20[2] - r5_20 * r15_20[13], r15_20[3] - r6_20 * r15_20[13], r3_0[0], r15_20[13], tocolor(r15_20[9], r15_20[10], r15_20[11], r15_20[12] * r16_20))
		 end
	  end
	else
	  r15_0(true)
	end
 end
 local r40_0 = 0
 function preRenderSkating(r0_21)
	-- line: [327, 346] id: 21
	local r1_21 = getPedWalkingStyle(localPlayer)
	if getPedMoveState(localPlayer) == "walk" then
	  r40_0 = r40_0 + r0_21
	else
	  r40_0 = 0
	end
	local r3_21 = 250 < r40_0
	local r4_21 = nil	-- notice: implicit variable refs by block#[9]
	if r3_21 then
	  r4_21 = 138
	  if not r4_21 then
		 r4_21 = 54
	  end
	end

	if r1_21 ~= r4_21 then
	  local r6_21 = localPlayer
	  r4_21 = isElement(r24_0[r6_21])
	  if r4_21 then
		 r6_21 = localPlayer
		 destroyElement(r24_0[r6_21])
	  end
	  r24_0[localPlayer] = nil
	  r4_21 = setPedWalkingStyle
	  local r5_21 = localPlayer
	  if r3_21 then
		 r6_21 = 138 or 54
	  end
	  iprint(r6_21)
	  r4_21(r5_21, r6_21)
	  triggerServerEvent("gotSelfSkatingWalkingStyle", localPlayer, r3_21)
	end
 end
 addEvent("gotSelfSkatingState", true)
 addEventHandler("gotSelfSkatingState", getRootElement(), function(r0_22)
	-- line: [350, 357] id: 22
	r13_0(r0_22)
	if not r0_22 then
	  triggerServerEvent("gotSelfSkatingWalkingStyle", localPlayer)
	  if isElement(r24_0[localPlayer]) then
		 destroyElement(r24_0[localPlayer])
	  end
	  r24_0[localPlayer] = nil
	end
 end)
 function dot(r0_23, r1_23, r2_23, r3_23, r4_23, r5_23)
	-- line: [359, 361] id: 23
	return r0_23 * r3_23 + r1_23 * r4_23 + r2_23 * r5_23
 end
 function dxDrawLightCone(r0_24, r1_24, r2_24, r3_24, r4_24, r5_24, r6_24, r7_24)
	-- line: [363, 371] id: 24
	local r8_24 = 1
	r5_0[1] = true
	if r4_0[1] then
	  r7_0[1]()
	end
	local r9_24 = dxDrawMaterialLine3D
	local r10_24 = r0_24
	local r11_24 = r1_24
	local r12_24 = r2_24
	local r13_24 = hx or r3_24
	local r14_24 = hy or r4_24
	r9_24(r10_24, r11_24, r12_24, r13_24, r14_24, hz or r5_24, r3_0[1], r6_24 * 4 * r8_24, r7_24)
 end
 local r41_0 = -2381.5017
 local r42_0 = 2216
 local r43_0 = 15.5
 local r44_0 = createColSphere(r41_0, r42_0, r43_0, 625)
 local r45_0 = 1
 local r46_0 = 0
 local r47_0 = 0
 function preRenderLight()
	-- line: [379, 413] id: 25
	local r0_25, r1_25 = getTime()
	if r0_25 < 7 or 19 < r0_25 then
	  local r2_25, r3_25, r4_25, r5_25, r6_25, r7_25 = getCameraMatrix()
	  local r8_25 = getDistanceBetweenPoints3D(r2_25, r3_25, r4_25, r41_0, r42_0, r43_0)
	  if r8_25 > 575 then
		 r8_25 = math.max(0, 1 - (r8_25 - 575) / 25)
	  else
		 r8_25 = 1
	  end
	  cdz = r4_25 - r7_25
	  cdy = r3_25 - r6_25
	  cdx = r2_25 - r5_25
	  local r9_25 = getTickCount() / 1500
	  local r10_25 = math.cos(r9_25)
	  r46_0 = math.sin(r9_25)
	  r45_0 = r10_25
	  r10_25 = r41_0 + r45_0 * 3
	  local r11_25 = r42_0 + r46_0 * 3
	  local r12_25 = r43_0 + r47_0 * 3
	  local r13_25 = 1 - math.abs(dot(r45_0, r46_0, r47_0, cdx, cdy, cdz))
	  r5_0[2] = true
	  if r4_0[2] then
		 r7_0[2]()
	  end
	  dxDrawMaterialLine3D(r10_25, r11_25, r12_25 + 3, r10_25, r11_25, r12_25 - 3, r3_0[2], 6, tocolor(255, 242.25, 216.75, 200 * (1 - r13_25) * r8_25), r10_25 + r45_0, r11_25 + r46_0, r12_25 + r47_0)
	  dxDrawLightCone(r10_25, r11_25, r12_25, r10_25 + r45_0 * 50, r11_25 + r46_0 * 50, r12_25 + r47_0 * 50, 4.5, tocolor(255, 242.25, 216.75, 220 * r13_25 * r8_25))
	end
 end
 addEventHandler("onClientColShapeHit", root, function(hitElement, matchingDimension)
	if hitElement == localPlayer and matchingDimension then
		if r44_0 == source then
			r11_0(true)
		end
	end
 end)
 addEventHandler("onClientColShapeLeave", r44_0, function(leaveElement, matchingDimension)
	-- line: [421, 423] id: 27
	if leaveElement == localPlayer and matchingDimension then
		if r44_0 == source then
			r11_0(false)
		end
	end
 end)
 local r48_0 = {
	{
	  2.593,
	  0.3459,
	  1.7002
	},
	{
	  2.7145,
	  -0.2494,
	  1.4479
	},
	{
	  2.8262,
	  -0.7968,
	  1.9088
	},
	{
	  2.8835,
	  -1.0776,
	  1.5331
	},
	{
	  2.9428,
	  -1.3682,
	  1.9852
	},
	{
	  2.9993,
	  -1.645,
	  1.6092
	},
	{
	  3.1127,
	  -2.2004,
	  1.9127
	},
	{
	  3.2422,
	  -2.8353,
	  1.8049
	},
	{
	  3.3036,
	  -3.136,
	  2.1859
	},
	{
	  2.8648,
	  -3.4136,
	  1.8804
	},
	{
	  2.3327,
	  -3.596,
	  2.2865
	},
	{
	  2.0575,
	  -3.6903,
	  1.8878
	},
	{
	  1.7765,
	  -3.7866,
	  2.3115
	},
	{
	  1.5028,
	  -3.8804,
	  1.9142
	},
	{
	  0.9631,
	  -4.0654,
	  2.1575
	},
	{
	  0.3483,
	  -4.2762,
	  1.9882
	},
	{
	  0.0543,
	  -4.3769,
	  2.3382
	},
	{
	  -0.5238,
	  -4.5751,
	  2.026
	},
	{
	  -1.0598,
	  -4.5741,
	  2.4859
	},
	{
	  -1.3283,
	  -4.5023,
	  2.1349
	},
	{
	  -1.6102,
	  -4.4269,
	  2.6085
	},
	{
	  -1.8839,
	  -4.3537,
	  2.2608
	},
	{
	  -2.4185,
	  -4.2107,
	  2.6089
	},
	{
	  -3.0414,
	  -4.0441,
	  2.5461
	},
	{
	  -3.3298,
	  -3.967,
	  2.9513
	},
	{
	  -3.8997,
	  -3.7999,
	  2.7355
	},
	{
	  -4.1077,
	  -3.2746,
	  3.0877
	},
	{
	  -4.2135,
	  -3.0076,
	  2.6601
	},
	{
	  -4.3232,
	  -2.7308,
	  3.0549
	},
	{
	  -4.4292,
	  -2.463,
	  2.6318
	},
	{
	  -4.6387,
	  -1.9343,
	  2.8219
	},
	{
	  -4.8802,
	  -1.3244,
	  2.5905
	},
	{
	  -4.9911,
	  -1.0444,
	  2.9122
	},
	{
	  -5.2191,
	  -0.4688,
	  2.541
	},
	{
	  -5.4257,
	  0.0527,
	  2.8909
	},
	{
	  -5.5078,
	  0.3207,
	  2.4696
	},
	{
	  -5.373,
	  0.5833,
	  2.9025
	},
	{
	  -5.2415,
	  0.8393,
	  2.5131
	},
	{
	  -4.9817,
	  1.3454,
	  2.7757
	},
	{
	  -4.6822,
	  1.9288,
	  2.6304
	},
	{
	  -4.545,
	  2.1959,
	  2.9924
	},
	{
	  -4.2634,
	  2.7444,
	  2.6955
	},
	{
	  -4.0372,
	  3.2412,
	  3.1314
	},
	{
	  -3.875,
	  3.5009,
	  2.731
	},
	{
	  -3.7394,
	  3.7649,
	  3.1641
	},
	{
	  -3.6084,
	  4.0201,
	  2.7733
	},
	{
	  -3.134,
	  4.3007,
	  3.0931
	},
	{
	  -2.5572,
	  4.5823,
	  3.0145
	},
	{
	  -2.2868,
	  4.7143,
	  3.4114
	},
	{
	  -1.7388,
	  4.9819,
	  3.1857
	},
	{
	  -1.2448,
	  5.2231,
	  3.6702
	},
	{
	  -0.9853,
	  5.2731,
	  3.2988
	},
	{
	  -0.7179,
	  5.1585,
	  3.7132
	},
	{
	  -0.4488,
	  5.0431,
	  3.3082
	},
	{
	  0.075,
	  4.8184,
	  3.5414
	},
	{
	  0.6779,
	  4.5599,
	  3.3566
	},
	{
	  0.9607,
	  4.4386,
	  3.7037
	},
	{
	  1.5274,
	  4.1956,
	  3.3725
	},
	{
	  2.0411,
	  3.9752,
	  3.7671
	},
	{
	  2.3118,
	  3.8592,
	  3.366
	},
	{
	  2.5814,
	  3.7436,
	  3.7742
	},
	{
	  2.8468,
	  3.6297,
	  3.3694
	},
	{
	  3.3712,
	  3.4048,
	  3.6054
	},
	{
	  3.9722,
	  3.146,
	  3.4165
	},
	{
	  4.0613,
	  2.8535,
	  3.7825
	},
	{
	  4.2411,
	  2.2643,
	  3.4947
	},
	{
	  4.4043,
	  1.7291,
	  3.925
	},
	{
	  4.4877,
	  1.4557,
	  3.534
	},
	{
	  4.5736,
	  1.1743,
	  3.9663
	},
	{
	  4.6589,
	  0.8947,
	  3.5805
	},
	{
	  4.824,
	  0.3533,
	  3.8493
	},
	{
	  5.0145,
	  -0.2712,
	  3.7052
	},
	{
	  5.0878,
	  -0.5629,
	  4.0661
	},
	{
	  4.7806,
	  -1.0991,
	  3.7141
	},
	{
	  4.5027,
	  -1.5844,
	  4.0816
	},
	{
	  4.3584,
	  -1.8364,
	  3.663
	},
	{
	  4.2097,
	  -2.096,
	  4.0673
	},
	{
	  4.0681,
	  -2.3431,
	  3.6489
	},
	{
	  3.7851,
	  -2.8373,
	  3.8594
	},
	{
	  3.4222,
	  -3.3555,
	  3.6677
	},
	{
	  3.135,
	  -3.4631,
	  4.0501
	},
	{
	  2.5632,
	  -3.6773,
	  3.8077
	},
	{
	  2.0443,
	  -3.8717,
	  4.2792
	},
	{
	  1.7737,
	  -3.9731,
	  3.9083
	},
	{
	  1.4947,
	  -4.0775,
	  4.3711
	},
	{
	  1.2311,
	  -4.1763,
	  4.0003
	},
	{
	  0.7093,
	  -4.3718,
	  4.3103
	},
	{
	  0.1065,
	  -4.5976,
	  4.217
	},
	{
	  -0.1835,
	  -4.7063,
	  4.6042
	},
	{
	  -0.7416,
	  -4.8278,
	  4.3527
	},
	{
	  -1.2181,
	  -4.5311,
	  4.7817
	},
	{
	  -1.4633,
	  -4.3785,
	  4.394
	},
	{
	  -1.7136,
	  -4.2226,
	  4.8274
	},
	{
	  -1.9583,
	  -4.0702,
	  4.4431
	},
	{
	  -2.4371,
	  -3.7721,
	  4.7165
	},
	{
	  -2.9959,
	  -3.4242,
	  4.5728
	},
	{
	  -3.2566,
	  -3.2619,
	  4.9337
	},
	{
	  -3.7795,
	  -2.9363,
	  4.6428
	},
	{
	  -3.9118,
	  -2.4403,
	  5.1184
	},
	{
	  -4.0832,
	  -2.2258,
	  4.8034
	},
	{
	  -3.9621,
	  -1.8656,
	  5.2214
	},
	{
	  -3.987,
	  -1.5823,
	  4.8612
	},
	{
	  -4.0361,
	  -1.021,
	  5.1895
	},
	{
	  -4.0923,
	  -0.3797,
	  5.1068
	},
	{
	  -4.1235,
	  -0.0605,
	  5.4884
	},
	{
	  -4.1714,
	  0.5236,
	  5.2768
	},
	{
	  -4.2199,
	  1.077,
	  5.7621
	},
	{
	  -4.2447,
	  1.3597,
	  5.4003
	},
	{
	  -4.2705,
	  1.6544,
	  5.8637
	},
	{
	  -4.1029,
	  1.8819,
	  5.4433
	},
	{
	  -3.7586,
	  2.3353,
	  5.6425
	},
	{
	  -3.3618,
	  2.8577,
	  5.4189
	},
	{
	  -3.177,
	  3.101,
	  5.7404
	},
	{
	  -2.8053,
	  3.5904,
	  5.3772
	},
	{
	  -2.3443,
	  3.8436,
	  5.7655
	},
	{
	  -2.0629,
	  3.8968,
	  5.3693
	},
	{
	  -1.7694,
	  3.9523,
	  5.8015
	},
	{
	  -1.485,
	  4.0061,
	  5.4107
	},
	{
	  -0.9308,
	  4.1109,
	  5.6679
	},
	{
	  -0.2847,
	  4.2332,
	  5.5102
	},
	{
	  0.0127,
	  4.2894,
	  5.8652
	},
	{
	  0.617,
	  4.4037,
	  5.5629
	},
	{
	  1.0827,
	  4.211,
	  5.9734
	},
	{
	  1.2909,
	  4.0113,
	  5.5795
	},
	{
	  1.5044,
	  3.8064,
	  6.0075
	},
	{
	  1.7137,
	  3.6057,
	  5.6069
	},
	{
	  2.124,
	  3.212,
	  5.8607
	},
	{
	  2.5952,
	  2.76,
	  5.6951
	},
	{
	  2.8182,
	  2.5461,
	  6.0518
	},
	{
	  3.2614,
	  2.1209,
	  5.7452
	},
	{
	  3.6662,
	  1.7326,
	  6.1549
	},
	{
	  3.8723,
	  1.5344,
	  5.7682
	},
	{
	  3.8953,
	  1.2339,
	  6.1712
	},
	{
	  3.9172,
	  0.9474,
	  5.7622
	},
	{
	  3.9607,
	  0.3786,
	  5.9946
	},
	{
	  4.0108,
	  -0.2757,
	  5.8035
	},
	{
	  4.0343,
	  -0.5822,
	  6.1447
	},
	{
	  4.0813,
	  -1.1958,
	  5.8155
	},
	{
	  3.7736,
	  -1.6484,
	  6.198
	},
	{
	  3.594,
	  -1.8757,
	  5.7833
	},
	{
	  3.41,
	  -2.1088,
	  6.195
	},
	{
	  3.2317,
	  -2.3345,
	  5.7804
	},
	{
	  2.8804,
	  -2.7792,
	  6.0095
	},
	{
	  2.4718,
	  -3.2965,
	  5.8108
	},
	{
	  2.2383,
	  -3.4398,
	  6.1542
	},
	{
	  1.6221,
	  -3.4185,
	  5.854
	},
	{
	  1.0627,
	  -3.3991,
	  6.275
	},
	{
	  0.7744,
	  -3.3891,
	  5.8831
	},
	{
	  0.4789,
	  -3.3789,
	  6.3117
	},
	{
	  0.1881,
	  -3.3688,
	  5.9222
	},
	{
	  -0.3742,
	  -3.3494,
	  6.181
	},
	{
	  -1.0293,
	  -3.3094,
	  6.0388
	},
	{
	  -1.2943,
	  -3.1795,
	  6.4431
	},
	{
	  -1.8365,
	  -2.9137,
	  6.2425
	},
	{
	  -2.3284,
	  -2.6725,
	  6.7537
	},
	{
	  -2.5792,
	  -2.5496,
	  6.4076
	},
	{
	  -2.8413,
	  -2.4211,
	  6.8869
	},
	{
	  -3.0946,
	  -2.2969,
	  6.5377
	},
	{
	  -3.2741,
	  -1.8189,
	  6.9009
	},
	{
	  -3.3861,
	  -1.1911,
	  6.8615
	},
	{
	  -3.4382,
	  -0.8993,
	  7.2748
	},
	{
	  -3.5431,
	  -0.3112,
	  7.0843
	},
	{
	  -3.6391,
	  0.2269,
	  7.6022
	},
	{
	  -3.6883,
	  0.5032,
	  7.2629
	},
	{
	  -3.7391,
	  0.788,
	  7.7467
	},
	{
	  -3.7562,
	  1.0478,
	  7.3987
	},
	{
	  -3.2733,
	  1.3461,
	  7.67
	},
	{
	  -2.7121,
	  1.6928,
	  7.5342
	},
	{
	  -2.4573,
	  1.8501,
	  7.8986
	},
	{
	  -1.932,
	  2.1746,
	  7.6041
	},
	{
	  -1.4552,
	  2.4691,
	  8.0371
	},
	{
	  -1.1775,
	  2.4916,
	  7.6132
	},
	{
	  -0.879,
	  2.4814,
	  8.0098
	},
	{
	  -0.5926,
	  2.4715,
	  7.5785
	},
	{
	  -0.0276,
	  2.4521,
	  7.7717
	},
	{
	  0.6292,
	  2.4295,
	  7.5334
	},
	{
	  0.9374,
	  2.419,
	  7.8563
	},
	{
	  1.4926,
	  2.2592,
	  7.6891
	},
	{
	  1.9951,
	  2.0866,
	  8.2683
	},
	{
	  2.2536,
	  1.9978,
	  7.9506
	},
	{
	  2.5163,
	  1.9075,
	  8.4668
	},
	{
	  2.7572,
	  1.8094,
	  8.1422
	},
	{
	  2.7657,
	  1.2505,
	  8.256
	},
	{
	  2.7755,
	  0.6061,
	  7.9305
	},
	{
	  2.78,
	  0.3075,
	  8.2135
	},
	{
	  2.7892,
	  -0.2997,
	  7.7494
	},
	{
	  2.6897,
	  -0.828,
	  8.1018
	},
	{
	  2.5672,
	  -1.0871,
	  7.7192
	},
	{
	  2.4407,
	  -1.3547,
	  8.17
	},
	{
	  2.3187,
	  -1.6128,
	  7.7884
	},
	{
	  2.0761,
	  -2.126,
	  8.0811
	},
	{
	  1.7975,
	  -2.7154,
	  7.961
	},
	{
	  1.6171,
	  -2.9064,
	  8.3719
	},
	{
	  1.0898,
	  -3.0409,
	  8.3249
	},
	{
	  0.604,
	  -3.1649,
	  8.9757
	},
	{
	  0.358,
	  -3.2277,
	  8.6948
	},
	{
	  0.0837,
	  -3.1781,
	  9.1565
	},
	{
	  -0.1942,
	  -3.0924,
	  8.7627
	},
	{
	  -0.7369,
	  -2.9252,
	  9.023
	},
	{
	  -1.3624,
	  -2.7323,
	  8.8704
	},
	{
	  -1.6534,
	  -2.6426,
	  9.2308
	},
	{
	  -2.2414,
	  -2.4614,
	  8.927
	},
	{
	  -2.5059,
	  -2.0412,
	  9.3193
	},
	{
	  -2.5706,
	  -1.7608,
	  8.8962
	},
	{
	  -2.6619,
	  -1.5093,
	  9.3238
	},
	{
	  -2.7026,
	  -1.1881,
	  8.8846
	},
	{
	  -2.8297,
	  -0.6367,
	  9.1043
	},
	{
	  -2.8176,
	  -0.0077,
	  8.9105
	},
	{
	  -2.7208,
	  0.2866,
	  9.275
	},
	{
	  -2.5292,
	  0.8688,
	  8.9754
	},
	{
	  -2.3516,
	  1.4086,
	  9.3977
	},
	{
	  -2.2623,
	  1.6801,
	  8.9998
	},
	{
	  -2.0819,
	  1.8496,
	  9.5557
	},
	{
	  -1.8884,
	  1.9987,
	  9.2887
	},
	{
	  -1.5107,
	  2.2898,
	  9.8284
	},
	{
	  -1.065,
	  2.6123,
	  9.9726
	},
	{
	  -0.7671,
	  2.6223,
	  10.39
	},
	{
	  -0.1696,
	  2.6423,
	  10.1905
	},
	{
	  0.3818,
	  2.6608,
	  10.7138
	},
	{
	  0.6598,
	  2.6701,
	  10.3539
	},
	{
	  0.9518,
	  2.6799,
	  10.853
	},
	{
	  1.1874,
	  2.6136,
	  10.5099
	},
	{
	  1.5025,
	  2.1899,
	  10.9592
	},
	{
	  1.8614,
	  1.7073,
	  11.016
	},
	{
	  2.021,
	  1.475,
	  11.4689
	},
	{
	  2.1665,
	  0.8779,
	  11.1975
	},
	{
	  2.2997,
	  0.3317,
	  11.6471
	},
	{
	  2.3673,
	  0.0544,
	  11.2634
	},
	{
	  2.1952,
	  -0.4673,
	  11.3177
	},
	{
	  1.9088,
	  -0.9555,
	  11.5868
	},
	{
	  1.5785,
	  -1.5185,
	  11.4296
	},
	{
	  1.4233,
	  -1.7829,
	  11.8036
	},
	{
	  0.8464,
	  -1.7639,
	  11.5911
	},
	{
	  0.2963,
	  -1.711,
	  12.1072
	},
	{
	  0.0175,
	  -1.6842,
	  11.7606
	},
	{
	  -0.27,
	  -1.6565,
	  12.2455
	},
	{
	  -0.5463,
	  -1.6299,
	  11.8893
	},
	{
	  -1.0714,
	  -1.4976,
	  12.2376
	},
	{
	  -1.5576,
	  -1.0665,
	  12.1115
	},
	{
	  -1.7866,
	  -0.8635,
	  12.4913
	},
	{
	  -2.2434,
	  -0.4585,
	  12.2263
	},
	{
	  -2.0904,
	  -0.0864,
	  12.556
	},
	{
	  -1.8786,
	  0.1101,
	  12.0854
	},
	{
	  -1.6691,
	  0.3045,
	  12.4384
	},
	{
	  -1.4595,
	  0.4989,
	  11.9665
	},
	{
	  -1.0553,
	  0.8916,
	  12.2081
	},
	{
	  -0.5921,
	  1.3498,
	  12.0747
	},
	{
	  -0.3677,
	  1.5383,
	  12.4731
	},
	{
	  0.1501,
	  1.7367,
	  12.3995
	},
	{
	  0.5832,
	  1.697,
	  12.9564
	},
	{
	  0.7659,
	  1.4695,
	  12.5754
	},
	{
	  0.9475,
	  1.2434,
	  13.0097
	},
	{
	  1.1295,
	  1.0167,
	  12.6247
	},
	{
	  1.4835,
	  0.576,
	  12.9036
	},
	{
	  1.6178,
	  0.0676,
	  12.8745
	},
	{
	  1.5033,
	  -0.1733,
	  13.3713
	},
	{
	  1.2732,
	  -0.6574,
	  13.3362
	},
	{
	  0.9583,
	  -1.0199,
	  13.96
	},
	{
	  0.7137,
	  -1.1467,
	  13.6384
	},
	{
	  0.4613,
	  -1.2776,
	  14.1427
	},
	{
	  0.2188,
	  -1.4034,
	  13.8193
	},
	{
	  -0.2725,
	  -1.5876,
	  14.2133
	},
	{
	  -0.8956,
	  -1.4281,
	  14.1213
	},
	{
	  -1.1878,
	  -1.3526,
	  14.5155
	},
	{
	  -1.3966,
	  -0.8026,
	  14.3564
	},
	{
	  -1.5416,
	  -0.2998,
	  14.9023
	},
	{
	  -1.3635,
	  -0.065,
	  14.5328
	},
	{
	  -1.1773,
	  0.1804,
	  14.9964
	},
	{
	  -0.9939,
	  0.4221,
	  14.6304
	},
	{
	  -0.638,
	  0.8912,
	  14.9447
	},
	{
	  -0.2159,
	  1.1492,
	  15.1198
	},
	{
	  0.0678,
	  1.135,
	  15.5632
	},
	{
	  0.6641,
	  1.0778,
	  15.4067
	},
	{
	  0.9525,
	  0.6677,
	  15.9611
	},
	{
	  1.0771,
	  0.4192,
	  15.6325
	},
	{
	  1.1704,
	  0.1701,
	  16.1349
	},
	{
	  0.9783,
	  -0.0328,
	  15.7853
	},
	{
	  0.595,
	  -0.4376,
	  16.1478
	},
	{
	  0.0511,
	  -0.5139,
	  16.0903
	},
	{
	  -0.2357,
	  -0.4327,
	  16.4926
	},
	{
	  -0.4839,
	  -0.2656,
	  16.7945
	},
	{
	  -0.6718,
	  -0.1236,
	  16.6667
	},
	{
	  -0.7517,
	  -0.0343,
	  17.2177
	},
	{
	  -0.7475,
	  0.0959,
	  16.955
	},
	{
	  -0.6435,
	  0.2744,
	  17.5323
	},
	{
	  -0.3047,
	  0.5396,
	  17.5739
	},
	{
	  0.1794,
	  0.2272,
	  17.8884
	}
 }
 local r49_0 = {}
 for r53_0 = -10, 10, 1 do
	local r54_0 = math.rad(r53_0 * 110 / 20 + 90)
	table.insert(r49_0, {
	  -2309.7,
	  2329.6001 + math.cos(r54_0) * 7.5,
	  9.35 + math.sin(r54_0) * 6.5 - 6.5
	})
 end
 local r50_0 = math.cos(math.rad(r33_0))
 local r51_0 = math.sin(math.rad(r33_0))
 for r55_0 = 1, #r48_0, 1 do
	local r56_0 = r48_0[r55_0][1]
	local r57_0 = r48_0[r55_0][2]
	r48_0[r55_0][1] = r56_0 * r50_0 - r57_0 * r51_0
	r48_0[r55_0][2] = r56_0 * r51_0 + r57_0 * r50_0
 end
 local r52_0 = {}
 for r56_0 = 1, #r49_0, 1 do
	r52_0[-r56_0] = {
	  0,
	  0
	}
 end
 for r56_0 = 1, #r48_0, 1 do
	r52_0[r56_0] = {
	  0,
	  0
	}
 end
 local r53_0 = 0
 function renderizeLeds()
	-- line: [749, 761] id: 28
	for r3_28 = 1, #r49_0, 1 do
	  r52_0[-r3_28][1] = math.random(0, 5)
	  r52_0[-r3_28][2] = math.random(0, 3)
	end
	for r3_28 = 1, #r48_0, 1 do
	  r52_0[r3_28][1] = math.random(0, 5)
	  r52_0[r3_28][2] = math.random(0, 3)
	end
	r53_0 = 750
 end
 function renderParticle(r0_29, r1_29, r2_29, r3_29, r4_29, r5_29, r6_29, r7_29, r8_29, r9_29, r10_29, r11_29, r12_29, r13_29)
	-- line: [763, 771] id: 29
	r5_0[3] = true
	if r4_0[3] then
	  r7_0[3]()
	end
	dxDrawMaterialSectionLine3D(r3_29 + r0_29 * r6_29, r4_29 + r1_29 * r6_29, r5_29 + r2_29 * r6_29, r3_29 - r0_29 * r6_29, r4_29 - r1_29 * r6_29, r5_29 - r2_29 * r6_29, r7_29, r8_29, r9_29, r10_29, r3_0[3], r6_29, tocolor(255, 255, 255), r11_29, r12_29, r13_29)
 end
 function preRenderTree(r0_30)
	-- line: [773, 802] id: 30
	r53_0 = r53_0 - r0_30
	local r1_30, r2_30, r3_30 = getWorldFromScreenPosition(r20_0 / 2, 0, 128)
	local r4_30, r5_30, r6_30 = getWorldFromScreenPosition(r20_0 / 2, r21_0 / 2, 128)
	r1_30 = r4_30 - r1_30
	r2_30 = r5_30 - r2_30
	r3_30 = r6_30 - r3_30
	local r7_30 = math.sqrt((r1_30 * r1_30 + r2_30 * r2_30 + r3_30 * r3_30)) * 2
	r1_30 = r1_30 / r7_30
	r2_30 = r2_30 / r7_30
	r3_30 = r3_30 / r7_30
	if r53_0 < 0 then
	  renderizeLeds()
	end
	if isElementOnScreen(r34_0) then
	  for r11_30 = 1, #r48_0, 1 do
		 renderParticle(r1_30, r2_30, r3_30, r30_0 + r48_0[r11_30][1], r31_0 + r48_0[r11_30][2], r32_0 + r48_0[r11_30][3], 1, r52_0[r11_30][1] * 64, r52_0[r11_30][2] * 64, 64, 64)
	  end
	end
	for r11_30 = 1, #r49_0, 1 do
	  renderParticle(0, 0, 0.5, r49_0[r11_30][1], r49_0[r11_30][2], r49_0[r11_30][3], 1, r52_0[-r11_30][1] * 64, r52_0[-r11_30][2] * 64, 64, 64, r49_0[r11_30][1] + 1, r49_0[r11_30][2], r49_0[r11_30][3])
	end
 end
 