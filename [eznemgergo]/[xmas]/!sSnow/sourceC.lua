local r0_0 = dxCreateShader
local function r1_0(r0_1, r1_1, r2_1)
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
  sWeather = false,
  sDynasky = false,
  sPattach = false,
  sGui = false,
  sModloader = false,
}
local function r4_0()
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
  if not isElement(r6_0[0]) then
    r7_0[0] = false
    r6_0[0] = dxCreateTexture("files/tyre.dds", "argb", true)
  end
  if not r5_0 then
    r5_0 = true
    addEventHandler("onClientPreRender", getRootElement(), r11_0, true, "high+999999999")
  end
end
r10_0[1] = function()
  if not isElement(r6_0[1]) then
    r7_0[1] = false
    r6_0[1] = dxCreateTexture("files/snow_particle.dds", "argb", true)
  end
  if not r5_0 then
    r5_0 = true
    addEventHandler("onClientPreRender", getRootElement(), r11_0, true, "high+999999999")
  end
end
r10_0[2] = function()
  if not isElement(r6_0[2]) then
    r7_0[2] = false
    r6_0[2] = dxCreateTexture("files/icevign.dds", "argb", true)
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
local function r21_0()
  -- line: [1, 1] id: 10
  if not r20_0 then
    local r0_10 = getResourceFromName("sDynasky")
    local r1_10 = getResourceFromName("sWeather")
    if r0_10 and r1_10 and getResourceState(r0_10) == "running" and getResourceState(r1_10) == "running" then
      startCheckSnow()
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
local function r22_0()
  -- line: [1, 1] id: 11
  snowmanListener()
end
addEventHandler("modloaderLoaded", getRootElement(), r22_0)
local r41_0 = nil	-- notice: implicit variable refs by block#[12]
local r42_0 = nil	-- notice: implicit variable refs by block#[12]
if getElementData(localPlayer, "loggedIn") or r3_0.sModloader and r3_0.sModloader:isModloaderLoaded() then
  addEventHandler("onClientResourceStart", getResourceRootElement(), r22_0)
end
local r23_0 = false
local function r24_0(r0_12, r1_12)
  if r0_12 then
    r0_12 = false
  else
    r0_12 = true
  end
  if r0_12 ~= r23_0 then
    r23_0 = r0_12
    if r0_12 then
      addEventHandler("onClientPreRender", getRootElement(), preRenderSnowball, true, r1_12)
    else
      removeEventHandler("onClientPreRender", getRootElement(), preRenderSnowball)
    end
  end
end

local r25_0 = false
local function r26_0(r0_13, r1_13)
  if r0_13 then
    r0_13 = false
  else
    r0_13 = true
  end
  if r0_13 ~= r25_0 then
    r25_0 = r0_13
    if r0_13 then
      addEventHandler("onClientRender", getRootElement(), renderVignette, true, r1_13)
    else
      removeEventHandler("onClientRender", getRootElement(), renderVignette)
    end
  end
end
local r27_0 = false
local function r28_0(r0_14, r1_14)
  -- line: [1, 1] id: 14
  if r0_14 then
    r0_14 = true
  else
    r_014 = true	-- block#2 is visited secondly
  end
  if r0_14 ~= r27_0 then
    r27_0 = r0_14
    if r0_14 then
      addEventHandler("onClientPreRender", getRootElement(), preRenderSnow, true, r1_14)
    else
      removeEventHandler("onClientPreRender", getRootElement(), preRenderSnow)
    end
  end
end
local r29_0 = false
local function r30_0(r0_15, r1_15)
  -- line: [1, 1] id: 15
  if r0_15 then
    r0_15 = false
  else
    r0_15 = true
  end
  if r0_15 ~= r29_0 then
    r29_0 = r0_15
    if r0_15 then
      addEventHandler("onClientPreRender", getRootElement(), preRenderParticles, true, r1_15)
    else
      removeEventHandler("onClientPreRender", getRootElement(), preRenderParticles)
    end
  end
end
local r31_0, r32_0 = guiGetScreenSize()
local r33_0 = " texture ReplacedTexture; technique TextureChange { pass P0 { Texture[0] = ReplacedTexture; } } "
local r34_0 = "#define GENERATE_NORMALS\n#include \"files/mta-helper.fx\"\n texture sNoiseTexture; float sFadeStart = 10; float sFadeEnd = 80; sampler Sampler0 = sampler_state { Texture = (gTexture0); }; sampler3D SamplerNoise = sampler_state { Texture = (sNoiseTexture); MAGFILTER = LINEAR; MINFILTER = LINEAR; MIPFILTER = LINEAR; MIPMAPLODBIAS = 0.000000; }; struct VSInput { float3 Position : POSITION0; float3 Normal : NORMAL0; float4 Diffuse : COLOR0; float2 TexCoord : TEXCOORD0; }; struct PSInput { float4 Position : POSITION0; float4 Diffuse : COLOR0; float2 TexCoord : TEXCOORD0; float2 NoiseCoord : TEXCOORD1; float DistFade : TEXCOORD3; }; PSInput VertexShaderFunction(VSInput VS) { PSInput PS = (PSInput)0; MTAFixUpNormal( VS.Normal ); PS.Position = MTACalcScreenPosition ( VS.Position ); PS.TexCoord = VS.TexCoord; PS.Diffuse = MTACalcGTABuildingDiffuse( VS.Diffuse ); float DistanceFromCamera = MTACalcCameraDistance( gCameraPosition, MTACalcWorldPosition( VS.Position ) ); PS.DistFade = MTAUnlerp ( sFadeEnd, sFadeStart, DistanceFromCamera ); float3 WorldNormal = MTACalcWorldNormal( VS.Normal ); PS.DistFade *= WorldNormal.z; float3 WorldPos = MTACalcWorldPosition( VS.Position ); PS.NoiseCoord.x = WorldPos.x / 48; PS.NoiseCoord.y = WorldPos.y / 48; return PS; } float4 PixelShaderFunction(PSInput PS) : COLOR0 { float4 texel = tex2D(Sampler0, PS.TexCoord); float3 texelNoise = tex3D(SamplerNoise, float3(PS.NoiseCoord.xy,1)).rgb; float4 texelSnow = texel.g * 2 + 0.4; float distFade = saturate( PS.DistFade.x ); float amount = texelNoise.y * texelNoise.y * 3; amount *= distFade; float4 finalColor = lerp( texel, texelSnow, amount ); finalColor = finalColor * PS.Diffuse; finalColor.a = texel.a * PS.Diffuse.a; return finalColor; } technique snowground { pass P0 { VertexShader = compile vs_2_0 VertexShaderFunction(); PixelShader = compile ps_2_0 PixelShaderFunction(); } } technique fallback { pass P0 { } } "
local r35_0 = "#include \"files/mta-helper.fx\"\n texture sNoiseTexture; sampler Sampler0 = sampler_state { Texture = (gTexture0); }; sampler3D SamplerNoise = sampler_state { Texture = (sNoiseTexture); MAGFILTER = LINEAR; MINFILTER = LINEAR; MIPFILTER = LINEAR; MIPMAPLODBIAS = 0.000000; }; struct VSInput { float3 Position : POSITION0; float3 Normal : NORMAL0; float4 Diffuse : COLOR0; float2 TexCoord : TEXCOORD0; }; struct PSInput { float4 Position : POSITION0; float4 Diffuse : COLOR0; float2 TexCoord : TEXCOORD0; float2 NoiseCoord : TEXCOORD1; }; PSInput VertexShaderFunction(VSInput VS) { PSInput PS = (PSInput)0; MTAFixUpNormal( VS.Normal ); PS.Position = MTACalcScreenPosition ( VS.Position ); PS.TexCoord = VS.TexCoord; PS.Diffuse = MTACalcGTABuildingDiffuse( VS.Diffuse ); float3 WorldPos = MTACalcWorldPosition( VS.Position ); PS.NoiseCoord.x = WorldPos.x / 48; PS.NoiseCoord.y = WorldPos.y / 48; return PS; } float4 PixelShaderFunction(PSInput PS) : COLOR0 { float4 texel = tex2D(Sampler0, PS.TexCoord); float3 texelNoise = tex3D(SamplerNoise, float3(PS.NoiseCoord.xy,1)).rgb; float4 texelSnow = texel.g * 2; float amount = texelNoise.y * texelNoise.y * 3; float4 finalColor = lerp( texel, texelSnow, amount ); finalColor = finalColor * PS.Diffuse; finalColor.a = texel.a * PS.Diffuse.a; return finalColor; } technique snowtrees { pass P0 { VertexShader = compile vs_2_0 VertexShaderFunction(); PixelShader = compile ps_2_0 PixelShaderFunction(); } } technique fallback { pass P0 { } } "
local r36_0 = "ó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ó"
local r37_0 = {}
local r38_0, r39_0, r40_0 = getElementPosition(localPlayer)
r41_0 = r38_0
r42_0 = r39_0
function spawnSnow(r0_16, r1_16, r2_16, r3_16)
  -- line: [449, 465] id: 16
  local r4_16 = math.pi * 2 * math.random()
  local r5_16 = math.random() * 30
  table.insert(r37_0, {
    r41_0 + math.cos(r4_16) * r5_16 + r0_16 * 2,
    r42_0 + math.sin(r4_16) * r5_16 + r1_16 * 2,
    r3_16 + r2_16 * 2,
    (1 + math.random()) * 0.025,
    math.random(1, 4),
    (1 + math.random()) * 0.75,
    0,
    math.cos(math.pi * 2 * math.random()) * (math.random() * 0.5 + 1),
    -math.sin((math.pi * 2 * math.random())) * (math.random() * 0.5 + 1),
    0,
    (1 + math.random()) * 4,
    math.random() * 0.5 + 0.5
  })
end
local r43_0 = 1
local r44_0 = math.floor(600 * r43_0 + 0.5)
function setSnowMultiplier(r0_17)
  -- line: [470, 473] id: 17
  r43_0 = r0_17 / 100
  r44_0 = math.floor(600 * r43_0 + 0.5)
end
function getSnowMultiplier()
  -- line: [475, 477] id: 18
  return r43_0 * 100
end
local r45_0 = {
  "wheel_lf_dummy",
  "wheel_lb_dummy",
  "wheel_rf_dummy",
  "wheel_rb_dummy"
}
local r46_0 = 255
local r47_0 = 255
local r48_0 = 255
function preRenderSnow(r0_19)
  -- line: [492, 713] id: 19
  -- notice: unreachable block#4
  local r1_19, r2_19 = getTime()
  r1_19 = math.abs((r1_19 + r2_19 / 60 - 12)) / 12
  r48_0 = 255 - r1_19 * 90
  r47_0 = 255 - r1_19 * 100
  r46_0 = 255 - r1_19 * 100
  r38_0, r39_0, r40_0 = getElementPosition(localPlayer)
  local r3_19, r4_19, r5_19 = getElementVelocity(localPlayer)
  local r6_19 = inSnow
  if r6_19 then
    r6_19 = r44_0
    if r6_19 > 0 then
      r6_19 = isLineOfSightClear(r38_0, r39_0, r40_0, r38_0, r39_0, r40_0 + 10, true, false, false, true, false, true, false, localPlayer)
    else
      r6_19 = false
    end
  end
  if #r37_0 > 0 then
    local r7_19, r8_19, r9_19, r10_19, r11_19, r12_19 = getCameraMatrix()
    local r13_19 = r10_19 - r7_19
    local r14_19 = r11_19 - r8_19
    local r15_19 = math.sqrt(r13_19 * r13_19 + r14_19 * r14_19)
    r42_0 = r39_0 + r14_19 / r15_19 * 30 / 4
    r41_0 = r38_0 + r13_19 / r15_19 * 30 / 4
    local r16_19, r17_19, r18_19 = getWorldFromScreenPosition(r31_0 / 2, 0, 128)
    local r19_19, r20_19, r21_19 = getWorldFromScreenPosition(r31_0 / 2, r32_0 / 2, 128)
    r16_19 = r19_19 - r16_19
    r17_19 = r20_19 - r17_19
    r18_19 = r21_19 - r18_19
    local r22_19 = math.sqrt((r16_19 * r16_19 + r17_19 * r17_19 + r18_19 * r18_19)) * 2
    r16_19 = -r16_19 / r22_19
    r17_19 = -r17_19 / r22_19
    r18_19 = -r18_19 / r22_19
    for r26_19 = #r37_0, 1, -1 do
      local r27_19, r28_19, r29_19, r30_19, r31_19, r32_19, r33_19, r34_19, r35_19, r36_19, r37_19, r38_19 = unpack(r37_0[r26_19])
      r37_0[r26_19][3] = r37_0[r26_19][3] - r32_19 * r0_19 / 1000
      if r33_19 < 1 then
        r37_0[r26_19][7] = math.min(1, r37_0[r26_19][7] + r32_19 * 2 * r0_19 / 1000)
      end
      r37_0[r26_19][10] = r37_0[r26_19][10] + 1 * r0_19 / 1000
      r36_19 = math.cos(r36_19) / r37_19
      r27_19 = r27_19 + r34_19 * r36_19
      r28_19 = r28_19 + r35_19 * r36_19
      if r37_0[r26_19][3] < r40_0 - 2.5 then
        table.remove(r37_0, r26_19)
        if r6_19 then
          spawnSnow(r3_19, r4_19, r5_19, r40_0 + 10)
        end
      elseif r40_0 + 10 < r37_0[r26_19][3] then
        table.remove(r37_0, r26_19)
        if r6_19 then
          spawnSnow(r3_19, r4_19, r5_19, r40_0 + 10 * math.random())
        end
      elseif getDistanceBetweenPoints2D(r27_19, r28_19, r41_0, r42_0) > 30 then
        table.remove(r37_0, r26_19)
        if r6_19 then
          spawnSnow(r3_19, r4_19, r5_19, r29_19)
        end
      else
        dxDrawMaterialLine3D(r27_19 + r16_19 * r30_19, r28_19 + r17_19 * r30_19, r29_19 + r18_19 * r30_19, r27_19 - r16_19 * r30_19, r28_19 - r17_19 * r30_19, r29_19 - r18_19 * r30_19, r19_0("files/" .. r31_19 .. ".dds"), r30_19, tocolor(255, 255, 255, 255 * r33_19 * r38_19))
      end
    end
  end
  if #r37_0 < r44_0 and r6_19 then
    spawnSnow(r3_19, r4_19, r5_19, r40_0 + 10 * math.random())
  elseif r44_0 < #r37_0 then
    table.remove(r37_0, math.random(1, #r37_0))
  end
  local r7_19 = getElementsByType("vehicle", getRootElement(), true)
  for r11_19 = 1, #r7_19, 1 do
    local r12_19 = r7_19[r11_19]
    if isElementOnScreen(r12_19) and getVehicleEngineState(r12_19) and getVehicleType(r12_19) == "Automobile" then
      local r14_19, r15_19 = getElementPosition(r12_19)
      if getDistanceBetweenPoints2D(r38_0, r39_0, r14_19, r15_19) < 100 then
        local r16_19, r17_19, r18_19 = getElementRotation(r12_19)
        r18_19 = math.rad(r18_19)
        local r19_19 = math.sin(r18_19) * 2 + math.random() * 2 - 1
        local r20_19 = -math.cos(r18_19) * 2 + math.random() * 2 - 1
        local r21_19 = 0.4 + math.random() * 2 - 1
        for r25_19 = 1, #r45_0, 1 do
          local r26_19 = getVehicleWheelFrictionState(r12_19, r25_19 - 1)
          if 0 < r26_19 and r26_19 ~= 3 then
            local r27_19, r28_19, r29_19 = getVehicleComponentPosition(r12_19, r45_0[r25_19], "world")
            if r27_19 then
              spawnParticle(r27_19, r28_19, r29_19 - 0.25, r19_19, r20_19, r21_19, 500, 200, 0.25, 1.5)
            end
          end
        end
      end
    end
  end
end
local r49_0 = {}
function spawnParticle(r0_20, r1_20, r2_20, r3_20, r4_20, r5_20, r6_20, r7_20, r8_20, r9_20)
  -- line: [722, 733] id: 20
  table.insert(r49_0, {
    r0_20,
    r1_20,
    r2_20,
    r3_20,
    r4_20,
    r5_20,
    getTickCount(),
    r6_20,
    r46_0,
    r47_0,
    r48_0,
    r7_20,
    r8_20,
    r9_20
  })
  r30_0(true)
end
function preRenderParticles(r0_21)
  -- line: [736, 795] id: 21
  local r1_21 = getTickCount()
  if #r49_0 > 0 then
    local r2_21, r3_21, r4_21 = getWorldFromScreenPosition(r31_0 / 2, 0, 128)
    local r5_21, r6_21, r7_21 = getWorldFromScreenPosition(r31_0 / 2, r32_0 / 2, 128)
    r2_21 = r5_21 - r2_21
    r3_21 = r6_21 - r3_21
    r4_21 = r7_21 - r4_21
    local r8_21 = math.sqrt((r2_21 * r2_21 + r3_21 * r3_21 + r4_21 * r4_21)) * 2
    r2_21 = -r2_21 / r8_21
    r3_21 = -r3_21 / r8_21
    r4_21 = -r4_21 / r8_21
    for r12_21 = #r49_0, 1, -1 do
      local r13_21 = r49_0[r12_21]
      if r13_21 then
        r13_21[1] = r13_21[1] + r13_21[4] * r0_21 / 1000
        r13_21[2] = r13_21[2] + r13_21[5] * r0_21 / 1000
        r13_21[3] = r13_21[3] + r13_21[6] * r0_21 / 1000
        local r14_21 = (r1_21 - r13_21[7]) / 50
        if r14_21 > 1 then
          r14_21 = 1
        end
        if r13_21[8] < r1_21 - r13_21[7] then
          r14_21 = 1 - (r1_21 - r13_21[7] + r13_21[8]) / 600
          if r14_21 < 0 then
            r14_21 = 0
            table.remove(r49_0, r12_21)
          end
        end
        r13_21[13] = r13_21[13] + r13_21[14] * r0_21 / 1000
        local r15_21 = math.floor(r13_21[13] * 250 % 16)
        local r16_21 = r15_21 % 4
        local r17_21 = math.floor(r15_21 / 4)
        r8_0[1] = true
        if r7_0[1] then
          r10_0[1]()
        end
        dxDrawMaterialLine3D(r13_21[1] + r2_21 * r13_21[13], r13_21[2] + r3_21 * r13_21[13], r13_21[3] + r4_21 * r13_21[13], r13_21[1] - r2_21 * r13_21[13], r13_21[2] - r3_21 * r13_21[13], r13_21[3] - r4_21 * r13_21[13], r6_0[1], r13_21[13], tocolor(r13_21[9], r13_21[10], r13_21[11], r13_21[12] * r14_21))
      end
    end
  else
    r30_0(true)
  end
end
local r50_0 = 300
local r51_0 = {
  "sm_des_bush*",
  "*tree*",
  "*ivy*",
  "*pine*",
  "veg_*",
  "*largefur*",
  "hazelbr*",
  "weeelm",
  "*branch*",
  "cypress*",
  "*bark*",
  "gen_log",
  "trunk5",
  "bchamae",
  "vegaspalm01_128",
  "planta256",
  "sm_josh_leaf",
  "kbtree4_test",
  "trunk3",
  "newtreeleaves128",
  "ashbrnch",
  "pinelo128",
  "tree19mi",
  "lod_largefurs07",
  "veg_largefurs05",
  "veg_largefurs06",
  "fuzzyplant256",
  "foliage256",
  "cypress1",
  "cypress2",
  "kuka_nagy",
  "*hedge*",
  "aamanbev96x",
  "soveny",
  "cobbles_kb_256",
  "beachwalkway",
  "pier69_ground1",
  "phoneboxmiami",
  "fence1",
  "pierplanks_128",
  "*kresz*",
  "CJ_HAY",
  "cj_hay2",
  "oakleaf1",
  "oakleaf2",
  "pinebranch2"
}
local r52_0 = {
  "sm_des_bush*",
  "*tree*",
  "*ivy*",
  "*pine*",
  "veg_*",
  "*largefur*",
  "hazelbr*",
  "weeelm",
  "*branch*",
  "cypress*",
  "*bark*",
  "gen_log",
  "trunk5",
  "bchamae",
  "vegaspalm01_128"
}
local r53_0 = {
  "planta256",
  "sm_josh_leaf",
  "kbtree4_test",
  "trunk3",
  "newtreeleaves128",
  "ashbrnch",
  "pinelo128",
  "tree19mi",
  "lod_largefurs07",
  "veg_largefurs05",
  "veg_largefurs06",
  "fuzzyplant256",
  "foliage256",
  "cypress1",
  "cypress2",
  "oakleaf1",
  "oakleaf2",
  "pinebranch2",
  "pershing_metal",
  "metatelepole1",
  "telepole2128",
  "hangingwires2",
  "telewireslong",
  "telewires_law",
  "v4_billboard_metal",
  "CJ_SLATEDWOOD",
  "CJ_GREENWOOD",
  "compfence2_LAe",
  "CJ_W_wood",
  "telepole128",
  "v4_frend",
  "bollard",
  "bollard2",
  "v4_tarp01",
  "v4_tarp02",
  "tarp_white",
  "v4_trashcan1",
  "v4_trashcan2",
  "v4_trashcan3",
  "v4_trashcan4",
  "sw_roadsign",
  "banding8_64",
  "ws_goldengate1",
  "ws_goldengate2",
  "ws_goldengate4",
  "ws_goldengate5",
  "v4_drain_decals1",
  "v4_concretecracks_alpha",
  "v4_concrete_drain",
  "v4_concrete_overlay1",
  "v4_walloverlay1",
  "aroofbit*",
  "cheerybox03",
  "CJ_GALVANISED_247",
  "247_cartreturn",
  "vgspawnroof01_128",
  "v4_seeburger_blackpanel",
  "v4_seeburger_wood",
  "pershing_wood",
  "ws_corr_2_plain_blue",
  "ws_corr_2_plain_blue2",
  "ws_corr_2_plain_red",
  "ws_corr_2_plain_white",
  "ws_corr_2_plain_black",
  "ws_corr_2_plain_rusty",
  "ws_corr_2_plain_rusty2",
  "rbs1_patesz",
  "rbs2_patesz",
  "rbs3_patesz",
  "rbs3_white_patesz",
  "rbs4_patesz",
  "rbs5_patesz",
  "rbs6_patesz",
  "rbs7_patesz",
  "rbs8_patesz",
  "rbs9_patesz",
  "rbs10",
  "ws_redwall2_top",
  "billboards2",
  "billboards22",
  "seering_track_trim",
  "seering_blacktyre",
  "seering_whitetyre",
  "seering_redtyre",
  "seering_redtyre2",
  "seering_track_trim",
  "kresz_base",
  "policetape",
  "rbs_redwhitearrows",
  "rbs_redwhitestrips",
  "sanpedock5",
  "warehousewindow_patesz",
  "LASLACMA1",
  "Was_side",
  "bbback",
  "iron",
  "billdetaily",
  "BBoardBack",
  "lasdkcrtgr1",
  "lasdkcrtgr11",
  "lasdkcrtgr111",
  "lasdkcrtgr1111",
  "lasdkcrtgr1s",
  "lasdkcrtgr1ss",
  "lasdkcrtgr1sss",
  "lasdkcrtgr1ssss",
  "desbarlas",
  "CJ_GREENMETAL",
  "bus shelter",
  "sm_Agave_1",
  "sm_Agave_2",
  "sm_minipalm1",
  "plantb256",
  "lampost_16clr"
}
local r54_0 = false
function enableGoundSnow()
  -- line: [949, 987] id: 22
  snowShader = r2_0(r34_0, 0, r50_0)
  treeShader = r2_0(r36_0, 0, r50_0)
  naughtyTreeShader = r2_0(r35_0, 0, r50_0)
  sNoiseTexture = dxCreateTexture("files/smallnoise3d.dds")
  if not snowShader or not treeShader or not naughtyTreeShader or not sNoiseTexture then
    return nil
  end
  dxSetShaderValue(treeShader, "sNoiseTexture", sNoiseTexture)
  dxSetShaderValue(naughtyTreeShader, "sNoiseTexture", sNoiseTexture)
  dxSetShaderValue(snowShader, "sNoiseTexture", sNoiseTexture)
  dxSetShaderValue(snowShader, "sFadeEnd", r50_0)
  dxSetShaderValue(snowShader, "sFadeStart", r50_0 / 2)
  for r3_22, r4_22 in ipairs(r51_0) do
    engineApplyShaderToWorldTexture(snowShader, r4_22)
  end
  for r3_22, r4_22 in ipairs(r52_0) do
    engineApplyShaderToWorldTexture(treeShader, r4_22)
  end
  for r3_22, r4_22 in ipairs(r53_0) do
    engineApplyShaderToWorldTexture(naughtyTreeShader, r4_22)
  end
  engineRemoveShaderFromWorldTexture(snowShader, "kb_ivy2_256")
  engineRemoveShaderFromWorldTexture(treeShader, "kb_ivy2_256")
  r54_0 = true
end
function disableGoundSnow()
  -- line: [989, 1000] id: 23
  if not r54_0 then
    return 
  end
  destroyElement(sNoiseTexture)
  destroyElement(treeShader)
  destroyElement(naughtyTreeShader)
  destroyElement(snowShader)
  r54_0 = false
end
local r55_0 = {
  ["files/snow/junction.dds"] = {
    "*crossing*",
    "craproad2_lae*",
    "sf_junction*"
  },
  ["files/snow/pave.dds"] = {
    "*bow_abattoir_conc2*",
    "*hoodlawn*",
    "*lasunion994*",
    "*pave*",
    "*sidelatino1_lae*",
    "*sidewalk*",
    "*sjmlahus29*",
    "Bow_Conc2_keepclear",
    "Bow_Conc2_park",
    "anwfrntbev6",
    "bathtile01_int",
    "beachwalk_law",
    "boardwalk_la",
    "brickgrey",
    "brickred2*",
    "carlot1_lan",
    "craproad5_lae*",
    "craproad6_lae*",
    "crazy paving",
    "desertgravelgrassroad",
    "fancy_slab128",
    "gb_nastybar08",
    "golf_fairway2",
    "indund_64*",
    "laroad_offroad1",
    "mono*_sfe",
    "monobloc_256128",
    "scumtiles3_lae",
    "sidewgrass*",
    "sl_flagstone1",
    "sl_galleryplaza1",
    "sl_plazatile02",
    "tardor9",
    "ws_floortiles*",
    "ws_hextile",
    "v4_seeburger_tiles"
  },
  ["files/snow/rock.dds"] = {
    "*cliff*",
    "*rock*",
    "retainwall1",
    "t0032_10_jpg"
  },
  ["files/snow/snow.dds"] = {
    "*_grass*",
    "*backalley1_lae*",
    "*backstageceiling*",
    "*conc_*",
    "*concrete*",
    "*crop*",
    "*cuntroad*",
    "*desert*",
    "*desmud*",
    "*dirt*",
    "*dualroad*",
    "*flowerbed*",
    "*forestfloor*",
    "*freewaylaw*",
    "*gravel*",
    "*greengrass*",
    "*greyground*",
    "*grifnewtex1x*",
    "*hiway_lod*",
    "*lanefreeway",
    "*lawroad*",
    "*longrd*",
    "*mounttrail*",
    "*road01lod*",
    "*roadwide*",
    "*sand*",
    "*sfngrass*",
    "*sjmlahus28*",
    "*snpdwargrn1*",
    "*soil*",
    "*stones*",
    "*trainground*",
    "*yardgrass*",
    "16ceaf9b_jpg",
    "aaa8c8ee_jpg",
    "alley256",
    "alleygroundb256",
    "aszfalt",
    "backstagefloor1_256",
    "badmarb1_lan",
    "beton_2",
    "block2",
    "bow_abattoir_floor_clean",
    "brickred",
    "carlot1",
    "carpark_128",
    "carpark_256128",
    "craproad3_lae*",
    "desgrass*",
    "desgreengrass",
    "drivetile_02",
    "dt_road2grasstype4",
    "floor_tileone_256",
    "frend",
    "fu",
    "gm_lacarpark*",
    "golf_*",
    "grass*",
    "hllblf2_lae",
    "ind_roadskank",
    "ko",
    "laroad_centre1",
    "lasjmslumwall",
    "law_gazwhitefloor",
    "law_gazwhitestep",
    "lodgrass*",
    "lodgrounds04_sfs_a",
    "lodsfsbeach*",
    "main road no crack_jpg",
    "man_cellarfloor128",
    "metpat64",
    "mudyforest256",
    "newgrnd1brn_128",
    "obhilltex1",
    "parking",
    "parking1plain",
    "parking2",
    "parking2plain",
    "plaintarmac1",
    "redbrickground256",
    "rodeo3sjm",
    "scumtiles1_lae",
    "sjmcargr",
    "sjmndukwal*",
    "sjmscorclawn",
    "sjmscorclawn3",
    "sjmsfw2",
    "sl_plazatile01",
    "sl_sfngrssdrt01",
    "stormdrain2_nt",
    "stormdrain3_nt",
    "stormdrain5_nt",
    "stormdrain7",
    "sw_gasground",
    "sw_pdground",
    "tarmacplain2_bank",
    "tarmacplain2_bank",
    "tarmacplain_bank",
    "tilered",
    "upt_conc floorclean",
    "was_scrpyd_floor_hangar",
    "was_scrpyd_ground_*",
    "ws_carpark*",
    "ws_football_lines2",
    "ws_freeway2",
    "ws_stationfloor",
    "ws_sub_pen_conc*",
    "LAcityhall_floor",
    "LAcityhall_stairs",
    "ws_rooftarmac1",
    "lodmallb_law1",
    "mall_laWLOD4",
    "sl_flagstone1_red",
    "pershing_LOD",
    "templegas_lod",
    "deli_LOD",
    "flintGasLOD",
    "roof06L256",
    "roof04L256",
    "roof11L256",
    "ws_rooftarmac1LOD",
    "roof06Llod",
    "ws_rooftarmaclod",
    "roof04Llod",
    "roof10L_lod",
    "ws_roof_lod",
    "seering_pitlane",
    "seering_track2",
    "seering_track3",
    "seering_parking",
    "v3_phouse2groundLOD",
    "CE_groundTP02",
    "CE_brewery2LOD",
    "carpark_128LOD",
    "v4_urmatrans_ls_LOD",
    "century02b_lod",
    "ground01LAw2_LOD",
    "countgrndlaw2_LOD",
    "sjmlaelodf98",
    "lodrdssplt_las2",
    "sjmlaelod94",
    "lae2ground6_lod",
    "sjmlodc1",
    "sjmlodc9",
    "lodland1ct_las",
    "lodland1_las01",
    "sjmlode1",
    "sjmlodd3",
    "sjmlodd2",
    "golfcourseLOD_sfs_a",
    "plaintarmac1_park",
    "rooftiles2",
    "sw_corrugtile",
    "shingles3",
    "des_shingles",
    "trail_wall1",
    "husruf",
    "sjmroof1",
    "hospunder_law",
    "browntin1",
    "shingles2",
    "roof01L256",
    "corrugated5_64HV",
    "woodroof01_128",
    "roof10L256",
    "sw_slate01",
    "sw_cabinroof",
    "v4_farm_glasstop",
    "compfence5_LAe",
    "rooftiles1",
    "corr_roof1",
    "GB_truckdepot04",
    "sw_newcorrug",
    "dustyconcrete",
    "genroof02_128",
    "shingles1",
    "hc_roofslates",
    "ws_rooftarmac2",
    "ws_coppersheet",
    "acrooftop1256",
    "shingles1",
    "rooftiles2",
    "pierbuild_roof1",
    "pier69_roof1",
    "rooftop_gz3",
    "rooftop_gz4",
    "ws_corr_metal1",
    "genroof01_128",
    "genroof02_128",
    "redslates64_law",
    "helipad_grey1",
    "studioroof",
    "teto_1",
    "shinglesLAh",
    "comptroof1",
    "comptroof3",
    "comptwall4",
    "comptroof4",
    "sanruf",
    "comptwall2",
    "shingles5",
    "shingles6",
    "sjmpostback",
    "sjmlahus26",
    "adet",
    "lasjmslumruf",
    "garage_roof",
    "lasjmroof",
    "v4_makvirag_roof",
    "examroof1_LAe",
    "shingles4",
    "roadcoast5_lod",
    "roadcoast6_lod",
    "lae2rdcst3_lod",
    "lae2rdcst4_lod",
    "roof06L256_gasstation",
    "concroadslab_256",
    "sl_clayroof01",
    "ws_corrugateddoor1",
    "asfnsjm96",
    "asfnsjm93",
    "asfnsjm94",
    "asfnsjm6",
    "asfnsjm91",
    "asfnsjm5",
    "asfnsjm2",
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil
  },
  ["files/snow/snowroad.dds"] = {
    "*_road_*",
    "*desmudtrail*",
    "*hiway*",
    "*roadbutt*",
    "*roadnew*",
    "*sjmloda*",
    "*sl_freew2road*",
    "*snped*",
    "*sw_farmroad*",
    "craproad1_lae*",
    "craproad7_lae*",
    "cuntroad01_law",
    "cw2_weeroad1",
    "dt_road",
    "dt_roadblend",
    "lombard_sfe",
    "sf_road*",
    "was_scrpyd_ground_track_crv",
    "ws_freeway3",
    "ws_freeway3blend",
    "vgsroad01_lod",
    "lanLODroad1",
    "freewaylaw2_lod",
    "LOD_mountainroad_SFS",
    "sfroad2_LOD",
    "roads_sfseLOD64",
    "LODlastroadbug",
    "LOD_freewayroads",
    "LOD_freewayconcrete",
    "LOD_freewaysliproads",
    "seering_track1",
    "seering_track1_dirt",
    "seering_dragtrack1",
    "seering_dragtrack2",
    "seering_finishDRAG",
    "seering_track5",
    "seering_track5fade",
    "seering_track1_LOD",
    "seering_dragstrip",
    "sf_pave6_sand",
    "CE_roadverge",
    "cuntetownroad1LOD",
    "cuntetownroad2LOD",
    "cunte_roadwideside",
    "CE_4laneverge",
    "pinkpavroadLOD",
    "lae2roadiv_lod",
    "lae2rdfuk_lod",
    "sl_laefreeway1",
    "sl_laefreeway1",
    "dirttracksgrass256",
    nil
  },
  ["files/snow/snowroad2.dds"] = {
    "*roadd*",
    "*roads_*",
    "cw2_mountroad",
    "golf_gravelpath",
    "grifnewtex1b",
    "macpath_lae",
    "roadblendcunt",
    "sproad_tarmac00112_jpg",
    "sproad_tarmac001_jpg",
    "sproad_tarmac02112_jpg",
    "tar_*",
    "countryroads",
    "roundabout_tar",
    "des_1line256",
    "des_1linetar",
    "sjmlodd92",
    "sjmlas2lod5n",
    "Was_scrpyd_road",
    "Was_scrpyd_road_patesz",
    "Was_scrpyd_road2_patesz",
    "Was_scrpyd_road3_patesz",
    nil
  },
  ["files/snow/train.dds"] = {
    "*traintrax*"
  },
  ["files/snow/tram.dds"] = {
    "*tramline*"
  },
  ["files/tyre.dds"] = {
    "particleskid"
  },
  ["files/snow/v4_xmastree_snow.dds"] = {
    "v4_christmas",
    "tree19Mi"
  },
}
local r56_0 = {
  "v4_concrete_overlay2",
  "v4_concrete_overlay1",
  "v4_dirtfade_path",
  "v4_concrete_drain",
  "soil_logo",
  "stuffdirtcol",
  "CJ_SPRUNK_DIRTY",
  "v4_soil_tank_logo",
  "v4_concretecracks_alpha",
  "v4_concrete_overlay3",
  "v4_tuningwheel_tyrewall_dirt_1",
  "boardwalk_la"
}
local r57_0 = {
  ["files/snow/junction.dds"] = "dxt1",
  ["files/snow/pave.dds"] = "dxt1",
  ["files/snow/rock.dds"] = "dxt1",
  ["files/snow/snow.dds"] = "dxt1",
  ["files/snow/snowroad.dds"] = "dxt1",
  ["files/snow/snowroad2.dds"] = "dxt1",
  ["files/snow/train.dds"] = "dxt1",
  ["files/snow/tram.dds"] = "dxt1",
  ["files/snow/v4_xmastree_snow.dds"] = "dxt3",
}
local r58_0 = {}
local r59_0 = {}
local r60_0 = false
function refreshSnowState(r0_24)
  -- line: [1421, 1460] id: 24
  if r60_0 ~= r0_24 then
    r60_0 = r0_24
    r3_0.sWeather:refreshSnowSky(r0_24)
    r3_0.sDynasky:setSnowSky(r0_24)
    if r0_24 then
      enableGoundSnow()
      for r4_24, r5_24 in pairs(r55_0) do
        local r6_24 = dxCreateTexture(r4_24, r57_0[r4_24])
        local r7_24 = r2_0(r33_0)
        dxSetShaderValue(r7_24, "ReplacedTexture", r6_24)
        table.insert(r58_0, r6_24)
        table.insert(r59_0, r7_24)
        for r11_24 = 1, #r5_24, 1 do
          engineApplyShaderToWorldTexture(r7_24, r5_24[r11_24])
        end
        for r11_24 = 1, #r56_0, 1 do
          engineRemoveShaderFromWorldTexture(r7_24, r56_0[r11_24])
        end
      end
    else
      disableGoundSnow()
      for r4_24 = 1, #r59_0, 1 do
        if isElement(r58_0[r4_24]) then
          destroyElement(r58_0[r4_24])
        end
        r58_0[r4_24] = nil
      end
      for r4_24 = 1, #r59_0, 1 do
        if isElement(r59_0[r4_24]) then
          destroyElement(r59_0[r4_24])
        end
        r59_0[r4_24] = nil
      end
    end
  end
end
local r61_0 = 0.5
function setSnowVignetteLevel(r0_25)
  -- line: [1468, 1470] id: 25
  r61_0 = r0_25 / 100
end
function getSnowVignetteLevel()
  -- line: [1472, 1474] id: 26
  return r61_0 * 100
end
function renderVignette()
  -- line: [1477, 1479] id: 27
  r8_0[2] = true
  if r7_0[2] then
    r10_0[2]()
  end
  dxDrawImage(0, 0, r31_0, r32_0, r6_0[2], 0, 0, 0, tocolor(255, 255, 255, 255 * r61_0))
end
addEventHandler("onClientElementDataChange", localPlayer, function(r0_28)
  -- line: [1483, 1487] id: 28
  if r0_28 == "loggedIn" then
    checkPlayerInSnow()
  end
end)
local r62_0 = false
function checkInSnow()
  -- line: [1491, 1500] id: 29
  if r62_0 ~= inSnow then
    r62_0 = inSnow
    refreshSnowState(inSnow)
    r28_0(inSnow)
    r26_0(inSnow, "high+9999999")
  end
end
function startCheckSnow()
  -- line: [1502, 1509] id: 30
  checkPlayerInSnow()
  addEventHandler("onClientElementDimensionChange", localPlayer, checkPlayerInSnow)
  addEventHandler("onClientElementInteriorChange", localPlayer, checkPlayerInSnow)
  addEventHandler("onClientPreRender", getRootElement(), checkInSnow)
end
local r63_0 = {}
function preRenderSnowball(r0_31)
  -- line: [1514, 1556] id: 31
  for r4_31 = #r63_0, 1, -1 do
    if r63_0[r4_31].time then
      r63_0[r4_31].time = r63_0[r4_31].time + r0_31
      if r63_0[r4_31].time >= 325 then
        r63_0[r4_31].time = nil
        r3_0.sPattach:detach(r63_0[r4_31].obj)
      end
    else
      r63_0[r4_31].x = r63_0[r4_31].x + 12 * r63_0[r4_31].vx * r0_31 / 1000
      r63_0[r4_31].y = r63_0[r4_31].y + 12 * r63_0[r4_31].vy * r0_31 / 1000
      r63_0[r4_31].zs = r63_0[r4_31].zs + 1.25 * r0_31 / 1000
      r63_0[r4_31].z = r63_0[r4_31].z - r63_0[r4_31].zs * r0_31 / 1000
      local r5_31, r6_31, r7_31, r8_31, r9_31 = processLineOfSight(r63_0[r4_31].x - r63_0[r4_31].vx * 0.075, r63_0[r4_31].y - r63_0[r4_31].vy * 0.075, r63_0[r4_31].z, r63_0[r4_31].x + r63_0[r4_31].vx * 0.075, r63_0[r4_31].y + r63_0[r4_31].vy * 0.075, r63_0[r4_31].z, true, true, true, true, true, false, false, false, r63_0[r4_31].client)
      if not r5_31 then
        r5_31, r6_31, r7_31, r8_31, r9_31 = processLineOfSight(r63_0[r4_31].x, r63_0[r4_31].y, r63_0[r4_31].z + 0.075, r63_0[r4_31].x, r63_0[r4_31].y, r63_0[r4_31].z - 0.075, true, true, true, true, true, false, false, false, r63_0[r4_31].client)
      end
      if r5_31 then
        if isElement(r63_0[r4_31].obj) then
          destroyElement(r63_0[r4_31].obj)
        end
        r63_0[r4_31].obj = nil
        table.remove(r63_0, r4_31)
        setSoundMaxDistance(playSound3D("files/h" .. math.random(1, 3) .. ".mp3", r6_31, r7_31, r8_31), 35)
        for r14_31 = 1, 20, 1 do
          spawnParticle(r6_31, r7_31, r8_31, math.random() - 0.5, math.random() - 0.5, math.random() - 0.5, 250, 200, 0.075, 0.5)
        end
      elseif r63_0[r4_31].z < r63_0[r4_31].minZ then
        if isElement(r63_0[r4_31].obj) then
          destroyElement(r63_0[r4_31].obj)
        end
        r63_0[r4_31].obj = nil
        table.remove(r63_0, r4_31)
      else
        setElementPosition(r63_0[r4_31].obj, r63_0[r4_31].x, r63_0[r4_31].y, r63_0[r4_31].z)
      end
    end
  end
end
function throwSnowball(r0_32, r1_32, r2_32, r3_32, r4_32, r5_32)
  -- line: [1558, 1579] id: 32
  setPedAnimation(r0_32, "grenade", "weapon_throw", -1, false, false, false, false)
  r24_0(true)
  local r6_32 = createObject(3003, r1_32, r2_32, r3_32)
  setElementCollisionsEnabled(r6_32, false)
  r3_0.sPattach:attach(r6_32, r0_32, 24, 0.0015199505473877, 0.047363399993282, 0.061748596201707)
  table.insert(r63_0, {
    x = r1_32 + r4_32 * 0.3,
    y = r2_32 + r4_32 * 0.3,
    z = r3_32,
    zs = -0.5,
    minZ = r3_32 - 2,
    vx = r4_32,
    vy = r5_32,
    time = 0,
    obj = r6_32,
    client = r0_32,
  })
end
local r64_0 = {
  [0] = true,
  [1] = true,
  [2] = true,
  [3] = true,
  [4] = true,
  [5] = true,
  [7] = true,
  [8] = true,
  [34] = true,
  [89] = true,
  [127] = true,
  [135] = true,
  [136] = true,
  [137] = true,
  [138] = true,
  [139] = true,
  [144] = true,
  [165] = true,
  [18] = true,
  [35] = true,
  [36] = true,
  [37] = true,
  [69] = true,
  [109] = true,
  [154] = true,
  [161] = true,
  [23] = true,
  [41] = true,
  [111] = true,
  [112] = true,
  [113] = true,
  [114] = true,
  [28] = true,
  [29] = true,
  [30] = true,
  [31] = true,
  [32] = true,
  [33] = true,
  [74] = true,
  [75] = true,
  [76] = true,
  [77] = true,
  [78] = true,
  [79] = true,
  [86] = true,
  [96] = true,
  [97] = true,
  [98] = true,
  [99] = true,
  [131] = true,
  [143] = true,
  [157] = true,
  [19] = true,
  [21] = true,
  [22] = true,
  [24] = true,
  [25] = true,
  [26] = true,
  [27] = true,
  [40] = true,
  [83] = true,
  [84] = true,
  [87] = true,
  [88] = true,
  [100] = true,
  [110] = true,
  [123] = true,
  [124] = true,
  [126] = true,
  [128] = true,
  [129] = true,
  [130] = true,
  [132] = true,
  [133] = true,
  [141] = true,
  [142] = true,
  [145] = true,
  [155] = true,
  [156] = true,
  [9] = true,
  [10] = true,
  [11] = true,
  [12] = true,
  [13] = true,
  [14] = true,
  [15] = true,
  [16] = true,
  [17] = true,
  [20] = true,
  [80] = true,
  [81] = true,
  [82] = true,
  [115] = true,
  [116] = true,
  [117] = true,
  [118] = true,
  [119] = true,
  [120] = true,
  [121] = true,
  [122] = true,
  [125] = true,
  [146] = true,
  [147] = true,
  [148] = true,
  [149] = true,
  [150] = true,
  [151] = true,
  [152] = true,
  [153] = true,
  [160] = true,
  [6] = true,
  [85] = true,
  [101] = true,
  [134] = true,
  [140] = true,
}
local r65_0 = 0
function makeSnowball()
  local r0_33 = getTickCount()
  if r0_33 - r65_0 < 10000 then
    r3_0.sGui:showInfobox("e", "Kérlek várj még.")
    return 
  end
  if getPedOccupiedVehicle(localPlayer) then
    r3_0.sGui:showInfobox("e", "Járműben nem gyúrhatsz hógolyót!")
    return 
  end
  if r60_0 then
    local r1_33, r2_33, r3_33 = getElementPosition(localPlayer)
    local r4_33, r5_33, r6_33, r7_33, r8_33, r9_33, r10_33, r11_33, r12_33 = processLineOfSight(r1_33, r2_33, r3_33, r1_33, r2_33, r3_33 - 2, true, false, false, true, true, false, false, false, localPlayer, true)
    if r4_33 and r64_0[r12_33] then
      r65_0 = r0_33
      triggerServerEvent("makeSnowball", localPlayer)
    else
      r3_0.sGui:showInfobox("e", "Itt nincs hó.")
    end
  else
    r3_0.sGui:showInfobox("e", "Itt nincs hó.")
  end
end
addEvent("makeSnowball", true)
addEventHandler("makeSnowball", getRootElement(), function()
  if isElement(source) and isElementStreamedIn(source) then
    local r0_34, r1_34, r2_34 = getElementPosition(source)
    playSound3D("files/snowbc.wav", r0_34, r1_34, r2_34)
  end
end)
addEvent("shootSnowball", true)
addEventHandler("shootSnowball", getRootElement(), function()
  if isElement(source) and isElementStreamedIn(source) then
    local r0_35, r1_35, r2_35 = getElementPosition(source)
    local r3_35, r4_35, r5_35 = getElementRotation(source)
    local r6_35 = math.rad(r5_35 + 90)
    throwSnowball(source, r0_35, r1_35, r2_35 + 0.5, math.cos(r6_35), math.sin(r6_35))
  end
end)
local r66_0 = {}
local r67_0 = {
  3092,
  3092
}
function createSnowman(r0_36, r1_36)
  r66_0[r0_36] = {
    createObject(r67_0[r1_36[7]], r1_36[1], r1_36[2], r1_36[3]),
    r1_36[7]
  }
  setElementCollisionsEnabled(r66_0[r0_36][1], false)
  setElementRotation(r66_0[r0_36][1], 0, 0, r1_36[4])
  setElementInterior(r66_0[r0_36][1], r1_36[5])
  setElementDimension(r66_0[r0_36][1], r1_36[6])
end
function snowmanListener()
  r67_0 = {
    r3_0.sModloader:getModelId("v4_snowman1"),
    r3_0.sModloader:getModelId("v4_snowman2")
  }
  for r3_37 in pairs(r66_0) do
    setElementModel(r66_0[r3_37][1], r67_0[r66_0[r3_37][2]])
  end
end
addEvent("gotSnowmans", true)
addEventHandler("gotSnowmans", getRootElement(), function(r0_38)
  for r4_38 in pairs(r0_38) do
    createSnowman(r4_38, r0_38[r4_38])
  end
  triggerEvent("extraLoaderDone", localPlayer, "loadingSnowmans")
end)
addEvent("extraLoadStart:loadingSnowmans", false)
addEventHandler("extraLoadStart:loadingSnowmans", getRootElement(), function()
  triggerLatentServerEvent("requestSnowmans", localPlayer)
end)
addEvent("placeSnowman", true)
addEventHandler("placeSnowman", getRootElement(), function(r0_40, r1_40)
  -- line: [1823, 1831] id: 40
  for r5_40 = 1, 40, 1 do
    spawnParticle(r1_40[1], r1_40[2], r1_40[3], math.random() - 0.5, math.random() - 0.5, math.random() - 0.5, 500 + math.random() * 1000, 200, 0.075, 0.5)
  end
  playSound3D("files/snowman.wav", r1_40[1], r1_40[2], r1_40[3])
  createSnowman(r0_40, r1_40)
end)
addEvent("decaySnowman", true)
addEventHandler("decaySnowman", getRootElement(), function(r0_41)
  -- line: [1835, 1851] id: 41
  if r66_0[r0_41] then
    local r1_41, r2_41, r3_41 = getElementPosition(r66_0[r0_41][1])
    local r4_41 = getElementInterior(r66_0[r0_41][1])
    local r5_41 = getElementDimension(r66_0[r0_41][1])
    if getDistanceBetweenPoints3D(r1_41, r2_41, r3_41, getElementPosition(localPlayer)) < 5 and r4_41 == getElementInterior(localPlayer) and r5_41 == getElementDimension(localPlayer) then
      for r10_41 = 1, 40, 1 do
        spawnParticle(r1_41, r2_41, r3_41, math.random() - 0.5, math.random() - 0.5, math.random() - 0.5, 500 + math.random() * 1000, 200, 0.075, 0.5)
      end
    end
    if isElement(r66_0[r0_41][1]) then
      destroyElement(r66_0[r0_41][1])
    end
    r66_0[r0_41][1] = nil
    r66_0[r0_41] = nil
  end
end)
