-- filename: 
-- version: lua51
-- line: [0, 0] id: 0
local r0_0 = dxCreateShader
local function r1_0(r0_1, r1_1, r2_1)
  -- line: [1, 1] id: 1
  if r0_1 and r1_1 and r2_1 then
    r0_1 = decodeString(r0_1)
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
  sModloader = false,
  sCore = false,
  sPattach = false,
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
local r6_0 = falselocal
seelangDynImage = {}
local r7_0 = {}
local r8_0 = {}
local r9_0 = {}
local r10_0 = {}
local r11_0 = nil
function r11_0()
  -- line: [1, 1] id: 4
  local r0_4 = getTickCount()
  r6_0 = true
  local r1_4 = true
  for r5_4 in pairs(seelangDynImage) do
    r1_4 = false
    if r10_0[r5_4] and r10_0[r5_4] <= r0_4 then
      if isElement(seelangDynImage[r5_4]) then
        destroyElement(seelangDynImage[r5_4])
      end
      seelangDynImage[r5_4] = nil
      r7_0[r5_4] = nil
      r8_0[r5_4] = nil
      r10_0[r5_4] = nil
      break
    elseif not r9_0[r5_4] then
      r10_0[r5_4] = r0_4 + 5000
    end
  end
  for r5_4 in pairs(r9_0) do
    if not seelangDynImage[r5_4] and r6_0 then
      r6_0 = false
      seelangDynImage[r5_4] = dxCreateTexture(r5_4, r7_0[r5_4], r8_0[r5_4])
    end
    r9_0[r5_4] = nil
    r10_0[r5_4] = nil
    r1_4 = false
  end
  if r1_4 then
    removeEventHandler("onClientPreRender", getRootElement(), r11_0)
    r5_0 = false
  end
end
local function r12_0(r0_5, r1_5, r2_5)
  -- line: [1, 1] id: 5
  if not r5_0 then
    r5_0 = true
    addEventHandler("onClientPreRender", getRootElement(), r11_0, true, "high+999999999")
  end
  if not seelangDynImage[r0_5] then
    seelangDynImage[r0_5] = dxCreateTexture(r0_5, r1_5, r2_5)
  end
  r7_0[r0_5] = r1_5
  r9_0[r0_5] = true
  return seelangDynImage[r0_5]
end
local function r13_0()
  -- line: [1, 1] id: 6
  sparklerListener()
end
addEventHandler("modloaderLoaded", getRootElement(), r13_0)
if getElementData(localPlayer, "loggedIn") or r3_0.sModloader and r3_0.sModloader:isModloaderLoaded() then
  addEventHandler("onClientResourceStart", getResourceRootElement(), r13_0)
end
local r14_0 = false
local function r15_0(r0_7, r1_7)
  -- line: [1, 1] id: 7
  if r0_7 then
    r0_7 = true
  end
  if r0_7 ~= r14_0 then
    r14_0 = r0_7
    if r0_7 then
      addEventHandler("onClientPedsProcessed", getRootElement(), sparklerBones, true, r1_7)
    else
      removeEventHandler("onClientPedsProcessed", getRootElement(), sparklerBones)
    end
  end
end
local r16_0 = false
local function r17_0(r0_8, r1_8)
  -- line: [1, 1] id: 8
  if r0_8 then
    r0_8 = true
  end
  if r0_8 ~= r16_0 then
    r16_0 = r0_8
    if r0_8 then
      addEventHandler("onClientPreRender", getRootElement(), preRenderSparklers, true, r1_8)
    else
      removeEventHandler("onClientPreRender", getRootElement(), preRenderSparklers)
    end
  end
end
local r18_0 = false
local function r19_0(r0_9, r1_9)
  -- line: [1, 1] id: 9
  if r0_9 then
    r0_9 = true
  end
  if r0_9 ~= r18_0 then
    r18_0 = r0_9
    if r0_9 then
      addEventHandler("onClientPreRender", getRootElement(), preRenderParticles, true, r1_9)
    else
      removeEventHandler("onClientPreRender", getRootElement(), preRenderParticles)
    end
  end
end
local r20_0, r21_0 = guiGetScreenSize()
local r22_0 = 334
function sparklerListener()
  -- line: [6, 8] id: 10
  r22_0 = r3_0.sModloader:getModelId("v4_xmas_sparkler")
end
local r23_0 = {
  0.9970269609926,
  0.051387913886545,
  -0.057339230740933,
  0.0029553304854698
}
local r24_0 = {}
local r25_0 = {}
function spawnParticle(r0_11, r1_11, r2_11)
  -- line: [18, 38] id: 11
  local r3_11 = math.random() * math.pi * 2
  local r4_11 = (math.random() * 2 + 1) * 0.125
  table.insert(r25_0, {
    r0_11,
    r1_11,
    r2_11,
    (1.5 + 8 * math.random()) * 0.0075,
    math.random(0, 2),
    (1 + math.random() * 2) * 1,
    0,
    math.cos(math.pi * 1 * math.random()) * (math.random() * 0.25 + 1),
    -math.sin((math.pi * 1 * math.random())) * (math.random() * 0.25 + 1),
    0,
    (1 + math.random()) * 24,
    math.random() * 0.15 + 0.85,
    r2_11 + 0.2 + 0.35 * math.random(-1, 1),
    math.cos(r3_11) * r4_11,
    math.sin(r3_11) * r4_11
  })
  r19_0(true)
end
function preRenderParticles(r0_12)
  -- line: [40, 107] id: 12
  local r1_12 = true
  if #r25_0 > 0 then
    local r2_12, r3_12, r4_12, r5_12, r6_12, r7_12 = getCameraMatrix()
    local r8_12 = r5_12 - r2_12
    local r9_12 = r6_12 - r3_12
    local r10_12 = math.sqrt(r8_12 * r8_12 + r9_12 * r9_12)
    r8_12 = r8_12 / r10_12
    r9_12 = r9_12 / r10_12
    local r11_12, r12_12, r13_12 = getWorldFromScreenPosition(r20_0 / 2, 0, 128)
    local r14_12, r15_12, r16_12 = getWorldFromScreenPosition(r20_0 / 2, r21_0 / 2, 128)
    r11_12 = r14_12 - r11_12
    r12_12 = r15_12 - r12_12
    r13_12 = r16_12 - r13_12
    local r17_12 = math.sqrt((r11_12 * r11_12 + r12_12 * r12_12 + r13_12 * r13_12)) * 2
    r11_12 = -r11_12 / r17_12
    r12_12 = -r12_12 / r17_12
    r13_12 = -r13_12 / r17_12
    for r21_12 = #r25_0, 1, -1 do
      local r22_12, r23_12, r24_12, r25_12, r26_12, r27_12, r28_12, r29_12, r30_12, r31_12, r32_12, r33_12, r34_12, r35_12, r36_12 = unpack(r25_0[r21_12])
      r25_0[r21_12][1] = r25_0[r21_12][1] + r35_12 * r0_12 / 1000
      r25_0[r21_12][2] = r25_0[r21_12][2] + r36_12 * r0_12 / 1000
      r25_0[r21_12][3] = r25_0[r21_12][3] + r27_12 * r0_12 / 1000
      if r28_12 < 1 then
        r25_0[r21_12][7] = math.min(1, r25_0[r21_12][7] + r27_12 * 5 * r0_12 / 1000)
      end
      r25_0[r21_12][10] = r25_0[r21_12][10] + 1 * r0_12 / 1000
      r31_12 = math.cos(r31_12) / r32_12
      r22_12 = r22_12 + r29_12 * r31_12
      r23_12 = r23_12 + r30_12 * r31_12
      local r37_12 = 1
      if r34_12 < r25_0[r21_12][3] then
        r37_12 = 1 - (r25_0[r21_12][3] - r34_12) / 0.25
      end
      if r37_12 <= 0 then
        table.remove(r25_0, r21_12)
      else
        dxDrawMaterialSectionLine3D(r22_12 + r11_12 * r25_12, r23_12 + r12_12 * r25_12, r24_12 + r13_12 * r25_12, r22_12 - r11_12 * r25_12, r23_12 - r12_12 * r25_12, r24_12 - r13_12 * r25_12, 64 * r26_12, 0, 64, 64, r12_0("files/particle.dds"), r25_12, tocolor(255, 255, 255, 255 * r28_12 * r33_12 * r37_12))
      end
    end
  else
    r19_0(false)
  end
end
local r26_0 = "ő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ö"
function preRenderSparklers(r0_13)
  -- line: [250, 288] id: 13
  local r1_13 = true
  for r5_13, r6_13 in pairs(r24_0) do
    r1_13 = false
    r6_13[2] = r6_13[2] + r0_13 / 18000
    local r7_13 = 1 - r6_13[2]
    dxSetShaderValue(r6_13[5], "p", r7_13)
    if r6_13[2] >= 1.125 then
      if isElement(r6_13[1]) then
        destroyElement(r6_13[1])
      end
      r6_13[1] = nil
      if isElement(r6_13[5]) then
        destroyElement(r6_13[5])
      end
      r6_13[5] = nil
      r24_0[r5_13] = nil
    elseif r6_13[2] < 1 then
      local r8_13 = getElementMatrix(r6_13[1])
      local r9_13 = 0.471522003704125 * r7_13 - 0.025
      local r10_13 = r8_13[4][1] + r8_13[3][1] * r9_13
      local r11_13 = r8_13[4][2] + r8_13[3][2] * r9_13
      local r12_13 = r8_13[4][3] + r8_13[3][3] * r9_13
      for r16_13 = 1, 1 + 10 * math.random(), 1 do
        spawnParticle(r10_13, r11_13, r12_13)
      end
      if isElement(r6_13[4]) then
        setElementPosition(r6_13[4], r10_13, r11_13, r12_13)
        setElementInterior(r6_13[4], getElementInterior(r5_13))
        setElementDimension(r6_13[4], getElementDimension(r5_13))
      end
    end
  end
  if r1_13 then
    r17_0(false)
    r15_0(false)
  end
end
function sparklerBones()
  -- line: [290, 310] id: 14
  for r3_14, r4_14 in pairs(r24_0) do
    canEnd = false
    if isElementOnScreen(r3_14) then
      setElementBoneRotation(r3_14, 22, 51.73919511878, -74.347910673722, -58.695642222529)
      setElementBoneRotation(r3_14, 23, -50.869565217392, -78.260849662452, -9.1302705847697)
      setElementBoneRotation(r3_14, 24, -142.17389314071, -35.217426134192, -24.782568890116)
      setElementBoneRotation(r3_14, 25, -1.3044174857762, 10.43479256008, 16.956457055133)
      setElementBoneRotation(r3_14, 26, -5.2173266203507, 15.652084350586, 0)
      r3_0.sCore:updateElementRpHAnim(r3_14)
      if isElement(r24_0[r3_14][1]) then
        setElementInterior(r24_0[r3_14][1], getElementInterior(r3_14))
        setElementDimension(r24_0[r3_14][1], getElementDimension(r3_14))
      end
    end
  end
end
addEventHandler("onClientPlayerQuit", getRootElement(), function()
  -- line: [313, 321] id: 15
  if r24_0[source] then
    if isElement(r24_0[source][1]) then
      destroyElement(r24_0[source][1])
    end
    r24_0[source][1] = nil
    if isElement(r24_0[source][4]) then
      destroyElement(r24_0[source][4])
    end
    r24_0[source][4] = nil
    if isElement(r24_0[source][5]) then
      destroyElement(r24_0[source][5])
    end
    r24_0[source][5] = nil
  end
  r24_0[source] = nil
end)
addEvent("useSparkler", true)
addEventHandler("useSparkler", getRootElement(), function()
  -- line: [325, 356] id: 16
  iprint(r22_0)
  if isElementStreamedIn(source) and r22_0 then
    if r24_0[source] then
      if isElement(r24_0[source][1]) then
        destroyElement(r24_0[source][1])
      end
      r24_0[source][1] = nil
      if isElement(r24_0[source][4]) then
        destroyElement(r24_0[source][4])
      end
      r24_0[source][4] = nil
      if isElement(r24_0[source][5]) then
        destroyElement(r24_0[source][5])
      end
      r24_0[source][5] = nil
    end
    local r0_16 = playSound3D("files/sparkler.mp3", 0, 0, 0)
    setSoundMaxDistance(r0_16, 50)
    setSoundVolume(r0_16, 1.5)
    local r1_16 = createObject(r22_0, 0, 0, 0)
    local r2_16 = r2_0(r26_0)
    engineApplyShaderToWorldTexture(r2_16, "*", r1_16)
    r24_0[source] = {
      r1_16,
      0,
      math.random(0, 30),
      r0_16,
      r2_16
    }
    r3_0.sPattach:attach(r24_0[source][1], source, 25, -0.066795478476803, 0.026569262199524, 0.0344720633296, 0, 0, 0)
    r3_0.sPattach:disableScreenCheck(r24_0[source][1], true)
    r3_0.sPattach:setRotationQuaternion(r24_0[source][1], r23_0)
    setObjectScale(r24_0[source][1], 1, 1, 1.8860880148165)
    r17_0(true)
    r15_0(true)
  end
end)
