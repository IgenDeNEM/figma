local sightexports = {sHud = false, sGui = false}
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
local processsightlangStaticImage = {}
sightlangStaticImageToc[0] = true
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
  if sightlangStaticImageToc[0] then
    sightlangStatImgHand = false
    removeEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre)
  end
end
processsightlangStaticImage[0] = function()
  if not isElement(sightlangStaticImage[0]) then
    sightlangStaticImageToc[0] = false
    sightlangStaticImage[0] = dxCreateTexture("files/bar.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
local sightlangGuiRefreshColors = function()
  local res = getResourceFromName("sGui")
  if res and getResourceState(res) == "running" then
    refreshColors()
  end
end
addEventHandler("onGuiRefreshColors", getRootElement(), sightlangGuiRefreshColors)
addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangGuiRefreshColors)
local sightlangCondHandlState0 = false
local function sightlangCondHandl0(cond, prio)
  cond = cond and true or false
  if cond ~= sightlangCondHandlState0 then
    sightlangCondHandlState0 = cond
    if cond then
      addEventHandler("onClientRender", getRootElement(), processRenderSoundQueue, true, prio)
    else
      removeEventHandler("onClientRender", getRootElement(), processRenderSoundQueue)
    end
  end
end
local screenX, screenY = guiGetScreenSize()
local screenSource = false
local screenSourceEx = false
local soundEffected = {}
local soundQueue = {}
local drugShaders = {}
drugShaders.lsd = " texture screenTexture; sampler screenSampler = sampler_state { Texture = <screenTexture>; }; texture screenTextureEx; sampler screenSamplerEx = sampler_state { Texture = <screenTextureEx>; }; float intensity = 0; float time = 0; const float3 lumCoeff = float3(0.2125, 0.7154, 0.0721); float3x3 QuaternionToMatrix(float4 quat) { float3 cross = quat.yzx * quat.zxy; float3 square= quat.xyz * quat.xyz; float3 wimag = quat.w * quat.xyz; square = square.xyz + square.yzx; float3 diag = 0.5 - square; float3 a = (cross + wimag); float3 b = (cross - wimag); return float3x3( 2.0 * float3(diag.x, b.z, a.y), 2.0 * float3(a.z, diag.y, b.x), 2.0 * float3(b.y, a.x, diag.z)); } float4 PixelShaderFunction(float4 Diffuse : COLOR0, float2 TexCoord : TEXCOORD0) : COLOR0 { TexCoord = (TexCoord - 0.5) * 2.0; TexCoord.x /= 1.0 + (abs(TexCoord.y) / (5+sin(time)*2))*intensity; TexCoord.y /= 1.0 + (abs(TexCoord.x) / (5+cos(time)*2))*intensity; TexCoord = (TexCoord / 2.0) + 0.5; TexCoord.x += sin(TexCoord.y*3.14*5+time*2.5)*0.0045*intensity; TexCoord.y += cos(TexCoord.x*3.14*5+time*2.5)*0.0045*intensity; float4 render = tex2D(screenSampler, TexCoord); float4 render2 = tex2D(screenSamplerEx, TexCoord); float3 root3 = float3(0.57735, 0.57735, 0.57735); float half_angle = 0.5 * sin(time/10); float4 rot_quat = float4( (root3 * sin(half_angle)), cos(half_angle)); float3x3 rot_Matrix = QuaternionToMatrix(rot_quat); render.rgb = lerp(render.rgb, mul(rot_Matrix, render.rgb), intensity); float ci = float(dot(render.rgb, lumCoeff)); render.rgb = lerp(ci, render.rgb, 1 + (1 + abs(cos(time)))*intensity); render = lerp(render, render2, sin(time*2)*0.25*intensity); return render; } technique Technique1 { pass Pass1 { PixelShader = compile ps_2_0 PixelShaderFunction(); } } "
drugShaders.shroom = " texture screenTexture; sampler screenSampler = sampler_state { Texture = <screenTexture>; }; texture screenTextureEx; sampler screenSamplerEx = sampler_state { Texture = <screenTextureEx>; }; float intensity = 0; float time = 0; const float3 lumCoeff = float3(0.2125, 0.7154, 0.0721); float3x3 QuaternionToMatrix(float4 quat) { float3 cross = quat.yzx * quat.zxy; float3 square= quat.xyz * quat.xyz; float3 wimag = quat.w * quat.xyz; square = square.xyz + square.yzx; float3 diag = 0.5 - square; float3 a = (cross + wimag); float3 b = (cross - wimag); return float3x3( 2.0 * float3(diag.x, b.z, a.y), 2.0 * float3(a.z, diag.y, b.x), 2.0 * float3(b.y, a.x, diag.z)); } float4 PixelShaderFunction(float4 Diffuse : COLOR0, float2 TexCoord : TEXCOORD0) : COLOR0 { TexCoord = (TexCoord - 0.5) * 2.0; TexCoord.x /= 1.0 + (abs(TexCoord.y) / (5+sin(time)*2))*intensity; TexCoord.y /= 1.0 + (abs(TexCoord.x) / (5+cos(time)*2))*intensity; TexCoord = (TexCoord / 2.0) + 0.5; TexCoord.x += sin(TexCoord.y*3.14*5+time*2.5)*0.0025*intensity; TexCoord.y += cos(TexCoord.x*3.14*5+time*2.5)*0.0025*intensity; float4 render = tex2D(screenSampler, TexCoord); float4 render2 = tex2D(screenSamplerEx, TexCoord); float3 root3 = float3(0.57735, 0.57735, 0.57735); float half_angle = 0.5 * sin(time/10); float4 rot_quat = float4( (root3 * sin(half_angle)), cos(half_angle)); float3x3 rot_Matrix = QuaternionToMatrix(rot_quat); render.rgb = lerp(render.rgb, mul(rot_Matrix, render.rgb), intensity); float ci = float(dot(render.rgb, lumCoeff)); render.rgb = lerp(ci, render.rgb, 1 + (1 + abs(cos(time)))*intensity); render = lerp(render, render2, cos(time)*0.5*intensity); return render; } technique Technique1 { pass Pass1 { PixelShader = compile ps_2_0 PixelShaderFunction(); } } "
drugShaders.coke = " float ScreenWidth; float ScreenHeight; texture screenTexture; sampler screenSampler = sampler_state { Texture = <screenTexture>; }; float intensity = 0; float time = 0; const float4 lumCoeff = float4(0.2125, 0.7154, 0.0721, 1); const float3 lumCoeffEx = float3(0.2125, 0.7154, 0.0521); float4 PixelShaderFunction(float2 TexCoord : TEXCOORD0) : COLOR0 { TexCoord = (TexCoord - 0.5) * 2.0; TexCoord.x *= 1 - pow((abs(TexCoord.y) / 3), 2)*intensity; TexCoord.y *= 1 - pow((abs(TexCoord.x) / 3), 2)*intensity; TexCoord = (TexCoord / 2.0) + 0.5; float4 render = tex2D(screenSampler, TexCoord); float4 orig = render; float s11 = dot(tex2D(screenSampler, TexCoord + float2(-1.0f / ScreenWidth, -1.0f / ScreenHeight)), lumCoeff); float s12 = dot(tex2D(screenSampler, TexCoord + float2(0, -1.0f / ScreenHeight)), lumCoeff); float s13 = dot(tex2D(screenSampler, TexCoord + float2(1.0f / ScreenWidth, -1.0f / ScreenHeight)), lumCoeff); float s21 = dot(tex2D(screenSampler, TexCoord + float2(-1.0f / ScreenWidth, 0)), lumCoeff); float s23 = dot(tex2D(screenSampler, TexCoord + float2(-1.0f / ScreenWidth, 0)), lumCoeff); float s31 = dot(tex2D(screenSampler, TexCoord + float2(-1.0f / ScreenWidth, 1.0f / ScreenHeight)), lumCoeff); float s32 = dot(tex2D(screenSampler, TexCoord + float2(0, 1.0f / ScreenHeight)), lumCoeff); float s33 = dot(tex2D(screenSampler, TexCoord + float2(1.0f / ScreenWidth, 1.0f / ScreenHeight)), lumCoeff); float t1 = s13 + s33 + (2 * s23) - s11 - (2 * s21) - s31; float t2 = s31 + (2 * s32) + s33 - s11 - (2 * s12) - s13; float OutLine; if (((t1 * t1) + (t2 * t2)) > 0.25/10) { OutLine = 0.5*intensity; } else { OutLine = 0; } render.rgb = (render.rgb - 0.5) *(OutLine + 1.0) + 0.5; render.rgb *= 1+0.25*intensity+OutLine*0.5; float ci = float(dot(render.rgb, lumCoeffEx)); render.rgb = lerp(ci, render.rgb, 1+intensity ); return render; } technique Technique1 { pass Pass1 { PixelShader = compile ps_2_0 PixelShaderFunction(); } } "
drugShaders.para = " float ScreenWidth; float ScreenHeight; texture screenTexture; sampler screenSampler = sampler_state { Texture = <screenTexture>; }; float intensity = 0; float time = 0; const float4 lumCoeff = float4(0.2125, 0.7154, 0.0721, 1); const float3 lumCoeffEx = float3(0.4125, 0.7154, 0.0721); const float3 purple = float3(0.65, 0.4, 0.75); float4 PixelShaderFunction(float2 TexCoord : TEXCOORD0) : COLOR0 { TexCoord = (TexCoord - 0.5) * 2.0; TexCoord.x *= 1 - pow((abs(TexCoord.y) / 3), 2)*intensity; TexCoord.y *= 1 - pow((abs(TexCoord.x) / 3), 2)*intensity; TexCoord = (TexCoord / 2.0) + 0.5; float4 render = tex2D(screenSampler, TexCoord); float4 orig = render; float s11 = dot(tex2D(screenSampler, TexCoord + float2(-1.0f / ScreenWidth, -1.0f / ScreenHeight)), lumCoeff); float s12 = dot(tex2D(screenSampler, TexCoord + float2(0, -1.0f / ScreenHeight)), lumCoeff); float s13 = dot(tex2D(screenSampler, TexCoord + float2(1.0f / ScreenWidth, -1.0f / ScreenHeight)), lumCoeff); float s21 = dot(tex2D(screenSampler, TexCoord + float2(-1.0f / ScreenWidth, 0)), lumCoeff); float s23 = dot(tex2D(screenSampler, TexCoord + float2(-1.0f / ScreenWidth, 0)), lumCoeff); float s31 = dot(tex2D(screenSampler, TexCoord + float2(-1.0f / ScreenWidth, 1.0f / ScreenHeight)), lumCoeff); float s32 = dot(tex2D(screenSampler, TexCoord + float2(0, 1.0f / ScreenHeight)), lumCoeff); float s33 = dot(tex2D(screenSampler, TexCoord + float2(1.0f / ScreenWidth, 1.0f / ScreenHeight)), lumCoeff); float t1 = s13 + s33 + (2 * s23) - s11 - (2 * s21) - s31; float t2 = s31 + (2 * s32) + s33 - s11 - (2 * s12) - s13; float OutLine; if (((t1 * t1) + (t2 * t2)) > 0.25/10) { OutLine = 0.5*intensity; } else { OutLine = 0; } render.rgb = (render.rgb - 0.5) *(OutLine + 1.0) + 0.5; render.rgb *= 1+purple*intensity+OutLine*0.5; float ci = float(dot(render.rgb, lumCoeffEx)); render.rgb = lerp(ci, render.rgb, 1+intensity ); return render; } technique Technique1 { pass Pass1 { PixelShader = compile ps_2_0 PixelShaderFunction(); } } "
drugShaders.speed = " float ScreenWidth; float ScreenHeight; texture screenTexture; sampler screenSampler = sampler_state { Texture = <screenTexture>; }; float intensity = 0; float time = 0; const float4 lumCoeff = float4(0.2125, 0.7154, 0.0721, 1); float4 PixelShaderFunction(float2 TexCoord : TEXCOORD0) : COLOR0 { TexCoord = (TexCoord - 0.5) * 2.0; TexCoord.x *= 1 - pow((abs(TexCoord.y) / 2.75), 2)*intensity; TexCoord.y *= 1 - pow((abs(TexCoord.x) / 2.75), 2)*intensity; TexCoord = (TexCoord / 2.0) + 0.5; float4 render = tex2D(screenSampler, TexCoord); float4 orig = render; float s11 = dot(tex2D(screenSampler, TexCoord + float2(-1.0f / ScreenWidth, -1.0f / ScreenHeight)), lumCoeff); float s12 = dot(tex2D(screenSampler, TexCoord + float2(0, -1.0f / ScreenHeight)), lumCoeff); float s13 = dot(tex2D(screenSampler, TexCoord + float2(1.0f / ScreenWidth, -1.0f / ScreenHeight)), lumCoeff); float s21 = dot(tex2D(screenSampler, TexCoord + float2(-1.0f / ScreenWidth, 0)), lumCoeff); float s23 = dot(tex2D(screenSampler, TexCoord + float2(-1.0f / ScreenWidth, 0)), lumCoeff); float s31 = dot(tex2D(screenSampler, TexCoord + float2(-1.0f / ScreenWidth, 1.0f / ScreenHeight)), lumCoeff); float s32 = dot(tex2D(screenSampler, TexCoord + float2(0, 1.0f / ScreenHeight)), lumCoeff); float s33 = dot(tex2D(screenSampler, TexCoord + float2(1.0f / ScreenWidth, 1.0f / ScreenHeight)), lumCoeff); float t1 = s13 + s33 + (2 * s23) - s11 - (2 * s21) - s31; float t2 = s31 + (2 * s32) + s33 - s11 - (2 * s12) - s13; float OutLine; if (((t1 * t1) + (t2 * t2)) > 0.1/10) { OutLine = 0.5*intensity; } else { OutLine = 0; } render.rgb = (render.rgb - 0.5) *(OutLine + 1.0) + 0.5; render.rgb *= 1+0.5*intensity+OutLine*0.5; float ci = float(dot(render.rgb, lumCoeff)); render.rgb = lerp(ci, render.rgb, 1-intensity*0.25 ); return render; } technique Technique1 { pass Pass1 { PixelShader = compile ps_2_0 PixelShaderFunction(); } } "
drugShaders.weed = " float ScreenWidth; float ScreenHeight; texture screenTexture; sampler screenSampler = sampler_state { Texture = <screenTexture>; }; texture screenTextureEx; sampler screenSamplerEx = sampler_state { Texture = <screenTextureEx>; }; float intensity = 0; float time = 0; float4 PixelShaderFunction(float2 TexCoord : TEXCOORD0) : COLOR0 { TexCoord = (TexCoord - 0.5) * 2.0; float d = 1-sqrt(TexCoord.x*TexCoord.x+TexCoord.y*TexCoord.y); TexCoord.x += sin(TexCoord.y*3.14*5+time*2.5)*0.00125*intensity; TexCoord.y += cos(TexCoord.x*3.14*5+time*2.5)*0.00125*intensity; TexCoord = (TexCoord / 2.0) + 0.5; float4 render = tex2D(screenSampler, TexCoord); float4 render2 = tex2D(screenSamplerEx, TexCoord); render = lerp(render, (render+render2)/2, intensity); render.rgb *= lerp(1, d, abs(cos(time/2))*0.5*intensity); render.r *= 1+0.15*abs(sin(time/2))*intensity; render.g *= 1+0.25*abs(sin(time/2))*intensity; return render; } technique Technique1 { pass Pass1 { PixelShader = compile ps_2_0 PixelShaderFunction(); } } "
drugShaders.ex = " float ScreenWidth; float ScreenHeight; texture screenTexture; sampler screenSampler = sampler_state { Texture = <screenTexture>; }; texture screenTextureEx; sampler screenSamplerEx = sampler_state { Texture = <screenTextureEx>; }; float intensity = 1; float time = 0; float4 PixelShaderFunction(float2 TexCoord : TEXCOORD0) : COLOR0 { TexCoord = (TexCoord - 0.5) * 2.0; float d = 1-sqrt(TexCoord.x*TexCoord.x+TexCoord.y*TexCoord.y); TexCoord.x += sin(TexCoord.y*3.14*5+time*2.5)*0.002*intensity; TexCoord.y += cos(TexCoord.x*3.14*5+time*2.5)*0.002*intensity; TexCoord = (TexCoord / 2.0) + 0.5; float4 render = tex2D(screenSampler, TexCoord); float4 render2 = tex2D(screenSamplerEx, TexCoord); render = lerp(render, (render+render2)/2, intensity); render.rgb /= lerp(1, d, abs(cos(time))*0.25*intensity); render.r *= 1+0.25*abs(sin(time/2))*intensity; render.b *= 1+0.15*abs(sin(time/2))*intensity; return render; } technique Technique1 { pass Pass1 { PixelShader = compile ps_2_0 PixelShaderFunction(); } } "
local shader = false
local currentDrug = false
function processShader()
  if isElement(screenSource) then
    destroyElement(screenSource)
  end
  screenSource = false
  if isElement(screenSourceEx) then
    destroyElement(screenSourceEx)
  end
  screenSourceEx = false
  if isElement(shader) then
    destroyElement(shader)
  end
  shader = false
  if currentDrug then
    shader = dxCreateShader(drugShaders[currentDrug])
    screenSource = dxCreateScreenSource(screenX, screenY)
    dxSetShaderValue(shader, "screenTexture", screenSource)
    dxSetShaderValue(shader, "ScreenWidth", screenX)
    dxSetShaderValue(shader, "ScreenHeight", screenY)
    dxUpdateScreenSource(screenSource, true)
    if currentDrug ~= "coke" and currentDrug ~= "speed" and currentDrug ~= "para" then
      screenSourceEx = dxCreateScreenSource(screenX, screenY)
      dxSetShaderValue(shader, "screenTextureEx", screenSourceEx)
      dxUpdateScreenSource(screenSourceEx, true)
    end
    addEventHandler("onClientRender", getRootElement(), renderDrugs, true, "low-999999999999999999")
    addEventHandler("onClientPreRender", getRootElement(), preRenderDrugs)
    addEventHandler("onClientSoundStarted", getRootElement(), drugSoundPlay)
  else
    removeEventHandler("onClientRender", getRootElement(), renderDrugs, true, "low-999999999999999999")
    removeEventHandler("onClientPreRender", getRootElement(), preRenderDrugs)
    removeEventHandler("onClientSoundStarted", getRootElement(), drugSoundPlay)
  end
end
local sr, sg, sb, sr2, sg2, sb2 = false, nil, nil, nil, nil, nil
local doseIntensity = 0
local currentDoseIntensity = 0
local doseSpeed = 0
resetSkyGradient()
addEvent("refreshDrugDose", true)
addEventHandler("refreshDrugDose", getRootElement(), function(drug, dose, time)
  if currentDrug ~= drug then
    currentDrug = drug
    processShader()
    if drug then
      sr = false
    else
      resetSkyGradient()
    end
    currentDoseIntensity = 0
    local sound = getElementsByType("sound")
    for i = 1, #sound do
      soundQueue[sound[i]] = true
    end
    for sound in pairs(soundEffected) do
      soundQueue[sound] = true
    end
    sightlangCondHandl0(true)
  end
  if drug and not sr and getElementDimension(localPlayer) == 0 then
    sr, sg, sb, sr2, sg2, sb2 = getSkyGradient()
  end
  doseIntensity = dose
  sightexports.sHud:staminaDrug(drug, dose)
  doseSpeed = (dose - currentDoseIntensity) / time
end)
function hue2rgb(m1, m2, h)
  if h < 0 then
    h = h + 1
  elseif 1 < h then
    h = h - 1
  end
  if 1 > h * 6 then
    return m1 + (m2 - m1) * h * 6
  elseif 1 > h * 2 then
    return m2
  elseif 2 > h * 3 then
    return m1 + (m2 - m1) * (0.6666666666666666 - h) * 6
  else
    return m1
  end
end
function convertHSLToRGB(h, s, l)
  local m2
  if l < 0.5 then
    m2 = l * (s + 1)
  else
    m2 = l + s - l * s
  end
  local m1 = l * 2 - m2
  local r = hue2rgb(m1, m2, h + 0.3333333333333333) * 255
  local g = hue2rgb(m1, m2, h) * 255
  local b = hue2rgb(m1, m2, h - 0.3333333333333333) * 255
  return math.floor(r + 0.5), math.floor(g + 0.5), math.floor(b + 0.5)
end
function preRenderDrugs(delta)
  local t = getTickCount() / 10
  dxSetShaderValue(shader, "time", t)
  if currentDoseIntensity < doseIntensity then
    currentDoseIntensity = currentDoseIntensity + doseSpeed * delta / 1000
    if currentDoseIntensity > doseIntensity then
      currentDoseIntensity = doseIntensity
    end
  elseif currentDoseIntensity > doseIntensity then
    currentDoseIntensity = currentDoseIntensity + doseSpeed * delta / 1000
    if currentDoseIntensity < doseIntensity then
      currentDoseIntensity = doseIntensity
    end
  end
  dxSetShaderValue(shader, "intensity", currentDoseIntensity)
  if sr and (currentDrug == "lsd" or currentDrug == "shroom") then
    local r, g, b = convertHSLToRGB(t % 1000 / 1000, 1, 0.5)
    local r2, g2, b2 = convertHSLToRGB(-t % 2000 / 2000, 1, 0.5)
    r = sr + (r - sr) * currentDoseIntensity
    g = sg + (g - sg) * currentDoseIntensity
    b = sb + (b - sb) * currentDoseIntensity
    r2 = sr2 + (r2 - sr2) * currentDoseIntensity
    g2 = sg2 + (g2 - sg2) * currentDoseIntensity
    b2 = sb2 + (b2 - sb2) * currentDoseIntensity
    setSkyGradient(r, g, b, r2, g2, b2)
  end
end
local rampageWidgetState = false
local rampageWidgetPos = false
local rampageWidgetSize = false
addEvent("hudWidgetState:rampage", true)
addEventHandler("hudWidgetState:rampage", getRootElement(), function(state)
  if rampageWidgetState ~= state then
    rampageWidgetState = state
  end
end)
addEvent("hudWidgetPosition:rampage", true)
addEventHandler("hudWidgetPosition:rampage", getRootElement(), function(pos, final)
  rampageWidgetPos = pos
end)
addEvent("hudWidgetSize:rampage", true)
addEventHandler("hudWidgetSize:rampage", getRootElement(), function(size, final)
  rampageWidgetSize = size
end)
local barBg = false
function refreshColors()
  barBg = sightexports.sGui:getColorCodeToColor("sightgrey1")
  for d in pairs(drugTypes) do
    drugTypes[d].col1 = sightexports.sGui:getColorCodeToColor(drugTypes[d].color1)
    drugTypes[d].col2 = sightexports.sGui:getColorCodeToColor(drugTypes[d].color2)
  end
end
triggerEvent("requestWidgetDatas", localPlayer, "rampage")
local soundDoseIntensity = 0
function renderDrugs()
  dxUpdateScreenSource(screenSource, true)
  dxDrawImage(0, 0, screenX, screenY, shader)
  if screenSourceEx then
    dxUpdateScreenSource(screenSourceEx, true)
  end
  if rampageWidgetState then
    dxDrawRectangle(rampageWidgetPos[1], rampageWidgetPos[2] + rampageWidgetSize[2] / 2 - 5, rampageWidgetSize[1], 10, barBg)
    dxDrawRectangle(rampageWidgetPos[1], rampageWidgetPos[2] + rampageWidgetSize[2] / 2 - 5, rampageWidgetSize[1] * currentDoseIntensity, 10, drugTypes[currentDrug].col1)
    sightlangStaticImageUsed[0] = true
    if sightlangStaticImageToc[0] then
      processsightlangStaticImage[0]()
    end
    dxDrawImageSection(rampageWidgetPos[1], rampageWidgetPos[2] + rampageWidgetSize[2] / 2 - 5, rampageWidgetSize[1] * currentDoseIntensity, 10, 350 * getTickCount() / 2000, 0, 350 * currentDoseIntensity, 10, sightlangStaticImage[0], 0, 0, 0, drugTypes[currentDrug].col2)
  end
  local tmp = math.floor(currentDoseIntensity * 1000) / 1000
  if tmp ~= soundDoseIntensity then
    soundDoseIntensity = tmp
    for sound in pairs(soundEffected) do
      applySoundEffectParams(sound)
    end
  end
end
function easeOutQuart(x)
  return 1 - math.pow(1 - x, 4)
end
local effectCache = {}
local effectTimer = {}
local _setSoundEffectParameter = setSoundEffectParameter
function setSoundEffectParameter(soundElement, Type, TypeParam, effectInt)
  effectCache[soundElement] = effectCache[soundElement] or {}
  
  if effectCache[soundElement][Type] == effectInt then
    return true
  end
  
  effectCache[soundElement][Type] = effectInt
  
  effectTimer[soundElement] = effectTimer[soundElement] or {}
  
  if isTimer(effectTimer[soundElement][Type]) then
    killTimer(effectTimer[soundElement][Type])
    effectTimer[soundElement][Type] = nil
  end
  
  effectTimer[soundElement][Type] = setTimer(function(sound, typ, typParam, effInt)
    _setSoundEffectParameter(sound, typ, typParam, effInt)
  end, 1, 1, soundElement, Type, TypeParam, effectInt)
  
  if effectTimer[soundElement][Type] then
    return true
  end
  return false
end
function applySoundEffectParams(sound)
  if currentDrug == "lsd" or currentDrug == "shroom" then
    if not setSoundEffectParameter(sound, "flanger", "wetDryMix", 50 * currentDoseIntensity) then
      return false
    end
    if not setSoundEffectParameter(sound, "chorus", "wetDryMix", 50 * currentDoseIntensity) then
      return false
    end
    if not setSoundEffectParameter(sound, "echo", "wetDryMix", 50 * currentDoseIntensity) then
      return false
    end
  elseif currentDrug == "coke" or currentDrug == "speed" or currentDrug == "para" then
    if not setSoundEffectParameter(sound, "flanger", "wetDryMix", 50 * currentDoseIntensity) then
      return false
    end
    if not setSoundEffectParameter(sound, "chorus", "wetDryMix", 50 * currentDoseIntensity) then
      return false
    end
  elseif currentDrug == "weed" then
    if not setSoundEffectParameter(sound, "echo", "wetDryMix", 50 * currentDoseIntensity) then
      return false
    end
    if not setSoundEffectParameter(sound, "reverb", "reverbMix", -96 + 96 * easeOutQuart(currentDoseIntensity)) then
      return false
    end
  elseif currentDrug == "ex" and not setSoundEffectParameter(sound, "echo", "wetDryMix", 50 * currentDoseIntensity) then
    return false
  end
  return true
end
function applySoundEffect(sound)
  if currentDrug == "lsd" or currentDrug == "shroom" then
    if not setSoundEffectEnabled(sound, "flanger", true) then
      return false
    end
    if not setSoundEffectEnabled(sound, "chorus", true) then
      return false
    end
    if not setSoundEffectEnabled(sound, "echo", true) then
      return false
    end
    if not setSoundEffectEnabled(sound, "reverb", false) then
      return false
    end
    if not applySoundEffectParams(sound) then
      return false
    end
    if not soundEffected[sound] then
      addEventHandler("onClientElementDestroy", sound, removeSoundEffectVar)
    end
    soundEffected[sound] = true
  elseif currentDrug == "coke" or currentDrug == "speed" or currentDrug == "para" then
    if not setSoundEffectEnabled(sound, "flanger", true) then
      return false
    end
    if not setSoundEffectEnabled(sound, "chorus", true) then
      return false
    end
    if not setSoundEffectEnabled(sound, "echo", false) then
      return false
    end
    if not setSoundEffectEnabled(sound, "reverb", false) then
      return false
    end
    if not applySoundEffectParams(sound) then
      return false
    end
    if not soundEffected[sound] then
      addEventHandler("onClientElementDestroy", sound, removeSoundEffectVar)
    end
    soundEffected[sound] = true
  elseif currentDrug == "weed" then
    if not setSoundEffectEnabled(sound, "echo", true) then
      return false
    end
    if not setSoundEffectEnabled(sound, "reverb", true) then
      return false
    end
    if not setSoundEffectEnabled(sound, "flanger", false) then
      return false
    end
    if not setSoundEffectEnabled(sound, "chorus", false) then
      return false
    end
    if not applySoundEffectParams(sound) then
      return false
    end
    if not soundEffected[sound] then
      addEventHandler("onClientElementDestroy", sound, removeSoundEffectVar)
    end
    soundEffected[sound] = true
  elseif currentDrug == "ex" then
    if not setSoundEffectEnabled(sound, "echo", true) then
      return false
    end
    if not setSoundEffectEnabled(sound, "flanger", false) then
      return false
    end
    if not setSoundEffectEnabled(sound, "chorus", false) then
      return false
    end
    if not setSoundEffectEnabled(sound, "reverb", false) then
      return false
    end
    if not applySoundEffectParams(sound) then
      return false
    end
    if not soundEffected[sound] then
      addEventHandler("onClientElementDestroy", sound, removeSoundEffectVar)
    end
    soundEffected[sound] = true
  else
    if not setSoundEffectEnabled(sound, "flanger", false) then
      return false
    end
    if not setSoundEffectEnabled(sound, "chorus", false) then
      return false
    end
    if not setSoundEffectEnabled(sound, "echo", false) then
      return false
    end
    if not setSoundEffectEnabled(sound, "reverb", false) then
      return false
    end
    if soundEffected[sound] then
      removeEventHandler("onClientElementDestroy", sound, removeSoundEffectVar)
    end
    soundEffected[sound] = nil
  end
  return true
end
function removeSoundEffectVar()
  soundEffected[source] = nil
end
function processRenderSoundQueue()
  for sound in pairs(soundQueue) do
    if isElement(sound) then
      if applySoundEffect(sound) then
        soundQueue[sound] = nil
      end
    else
      soundQueue[sound] = nil
    end
  end
  for i in pairs(soundQueue) do
    return
  end
  sightlangCondHandl0(false)
end
function drugSoundPlay()
  soundQueue[source] = true
  sightlangCondHandl0(true)
end
