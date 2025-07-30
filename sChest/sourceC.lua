local sightexports = {sItems = false, sModloader = false}
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
  if sightlangStaticImageToc[0] and sightlangStaticImageToc[1] and sightlangStaticImageToc[2] and sightlangStaticImageToc[3] and sightlangStaticImageToc[4] and sightlangStaticImageToc[5] and sightlangStaticImageToc[6] and sightlangStaticImageToc[7] and sightlangStaticImageToc[8] and sightlangStaticImageToc[9] and sightlangStaticImageToc[10] and sightlangStaticImageToc[11] and sightlangStaticImageToc[12] then
    sightlangStatImgHand = false
    removeEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre)
  end
end
processsightlangStaticImage[0] = function()
  if not isElement(sightlangStaticImage[0]) then
    sightlangStaticImageToc[0] = false
    sightlangStaticImage[0] = dxCreateTexture("files/shad.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[1] = function()
  if not isElement(sightlangStaticImage[1]) then
    sightlangStaticImageToc[1] = false
    sightlangStaticImage[1] = dxCreateTexture("files/shine.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[2] = function()
  if not isElement(sightlangStaticImage[2]) then
    sightlangStaticImageToc[2] = false
    sightlangStaticImage[2] = dxCreateTexture("files/shine2.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[3] = function()
  if not isElement(sightlangStaticImage[3]) then
    sightlangStaticImageToc[3] = false
    sightlangStaticImage[3] = dxCreateTexture("files/bogyesz.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[4] = function()
  if not isElement(sightlangStaticImage[4]) then
    sightlangStaticImageToc[4] = false
    sightlangStaticImage[4] = dxCreateTexture("files/logof.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[5] = function()
  if not isElement(sightlangStaticImage[5]) then
    sightlangStaticImageToc[5] = false
    sightlangStaticImage[5] = dxCreateTexture("files/logo.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[6] = function()
  if not isElement(sightlangStaticImage[6]) then
    sightlangStaticImageToc[6] = false
    sightlangStaticImage[6] = dxCreateTexture("files/csilla.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[7] = function()
  if not isElement(sightlangStaticImage[7]) then
    sightlangStaticImageToc[7] = false
    sightlangStaticImage[7] = dxCreateTexture("files/itemHover.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[8] = function()
  if not isElement(sightlangStaticImage[8]) then
    sightlangStaticImageToc[8] = false
    sightlangStaticImage[8] = dxCreateTexture("files/win.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[9] = function()
  if not isElement(sightlangStaticImage[9]) then
    sightlangStaticImageToc[9] = false
    sightlangStaticImage[9] = dxCreateTexture("files/item.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[10] = function()
  if not isElement(sightlangStaticImage[10]) then
    sightlangStaticImageToc[10] = false
    sightlangStaticImage[10] = dxCreateTexture("files/iname.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[11] = function()
  if not isElement(sightlangStaticImage[11]) then
    sightlangStaticImageToc[11] = false
    sightlangStaticImage[11] = dxCreateTexture("files/logos.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[12] = function()
  if not isElement(sightlangStaticImage[12]) then
    sightlangStaticImageToc[12] = false
    sightlangStaticImage[12] = dxCreateTexture("files/items.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
local sightlangCondHandlState2 = false
local function sightlangCondHandl2(cond, prio)
  cond = cond and true or false
  if cond ~= sightlangCondHandlState2 then
    sightlangCondHandlState2 = cond
    if cond then
      addEventHandler("onClientPreRender", getRootElement(), preRenderChest, true, prio)
    else
      removeEventHandler("onClientPreRender", getRootElement(), preRenderChest)
    end
  end
end
local sightlangCondHandlState1 = false
local function sightlangCondHandl1(cond, prio)
  cond = cond and true or false
  if cond ~= sightlangCondHandlState1 then
    sightlangCondHandlState1 = cond
    if cond then
      addEventHandler("onClientPreRender", getRootElement(), preRenderBogyesz, true, prio)
    else
      removeEventHandler("onClientPreRender", getRootElement(), preRenderBogyesz)
    end
  end
end
local sightlangCondHandlState0 = false
local function sightlangCondHandl0(cond, prio)
  cond = cond and true or false
  if cond ~= sightlangCondHandlState0 then
    sightlangCondHandlState0 = cond
    if cond then
      addEventHandler("onClientRender", getRootElement(), renderChest, true, prio)
    else
      removeEventHandler("onClientRender", getRootElement(), renderChest)
    end
  end
end
local screenX, screenY = guiGetScreenSize()
local objectPreviewSource = " float3 sElementOffset = float3(0,0,0); float3 sWorldOffset = float3(0,0,0); float3 sCameraPosition = float3(0,0,0); float3 sCameraForward = float3(0,0,0); float3 sCameraUp = float3(0,0,0); float sFov = 1; float sAspect = 1; float2 sMoveObject2D = float2(0,0); float2 sScaleObject2D = float2(1,1); float2 sRealScale2D = float2(1,1); float sAlphaMult = 1; float sProjZMult = 2; float4 sColorFilter1 = float4(0,0,0,0); float4 sColorFilter2 = float4(0,0,0,0); texture gTexture0 < string textureState=\"0,Texture\"; >; float4x4 gWorld : WORLD; float4x4 gProjection : PROJECTION; texture secondRT < string renderTarget = \"yes\"; >; int gLighting < string renderState=\"LIGHTING\"; >; float4 gGlobalAmbient < string renderState=\"AMBIENT\"; >; int gAmbientMaterialSource < string renderState=\"AMBIENTMATERIALSOURCE\"; >; int gDiffuseMaterialSource < string renderState=\"DIFFUSEMATERIALSOURCE\"; >; int gEmissiveMaterialSource < string renderState=\"EMISSIVEMATERIALSOURCE\"; >; float4 gMaterialAmbient < string materialState=\"Ambient\"; >; float4 gMaterialDiffuse < string materialState=\"Diffuse\"; >; float4 gMaterialSpecular < string materialState=\"Specular\"; >; float4 gMaterialEmissive < string materialState=\"Emissive\"; >; int CUSTOMFLAGS <string createNormals = \"yes\"; string skipUnusedParameters = \"yes\"; >; float4 gTextureFactor < string renderState=\"TEXTUREFACTOR\"; >; sampler Sampler0 = sampler_state { Texture = (gTexture0); }; struct VSInput { float3 Position : POSITION0; float4 Diffuse : COLOR0; float2 TexCoord0 : TEXCOORD0; }; struct PSInput { float4 Position : POSITION0; float4 Diffuse : COLOR0; float2 TexCoord0 : TEXCOORD0; float4 vPosition : TEXCOORD1; float2 Depth : TEXCOORD2; }; float4x4 createViewMatrix( float3 pos, float3 fwVec, float3 upVec ) { float3 zaxis = normalize( fwVec); float3 xaxis = normalize( cross( -upVec, zaxis )); float3 yaxis = cross( xaxis, zaxis ); float4x4 viewMatrix = { float4( xaxis.x, yaxis.x, zaxis.x, 0 ), float4( xaxis.y, yaxis.y, zaxis.y, 0 ), float4( xaxis.z, yaxis.z, zaxis.z, 0 ), float4(-dot( xaxis, pos ), -dot( yaxis, pos ), -dot( zaxis, pos ), 1 ) }; return viewMatrix; } float4x4 createProjectionMatrix(float near_plane, float far_plane, float fov_horiz, float fov_aspect, float2 ss_mov, float2 ss_scale) { float h, w, Q; w = 1/tan(fov_horiz * 0.5); h = w/fov_aspect; Q = far_plane/(far_plane - near_plane); float4x4 projectionMatrix = { float4(w * ss_scale.x, 0, 0, 0), float4(0, h * ss_scale.y, 0, 0), float4(ss_mov.x, ss_mov.y, Q, 1), float4(0, 0, -Q*near_plane, 0) }; return projectionMatrix; } float4 MTACalcGTABuildingDiffuse( float4 InDiffuse ) { float4 OutDiffuse; if ( !gLighting ) { OutDiffuse = InDiffuse; } else { float4 ambient = gAmbientMaterialSource == 0 ? gMaterialAmbient : InDiffuse; float4 diffuse = gDiffuseMaterialSource == 0 ? gMaterialDiffuse : InDiffuse; float4 emissive = gEmissiveMaterialSource == 0 ? gMaterialEmissive : InDiffuse; OutDiffuse = gGlobalAmbient * saturate( ambient + emissive ); OutDiffuse.a *= diffuse.a; } return OutDiffuse; } PSInput VertexShaderFunction(VSInput VS) { PSInput PS = (PSInput)0; float4 wPos = mul(float4(VS.Position, 1), gWorld); wPos.xyz += sWorldOffset; float4x4 sView = createViewMatrix(sCameraPosition, sCameraForward, sCameraUp); float4 vPos = mul(wPos, sView); vPos.xzy += sElementOffset; float sFarClip = gProjection[3][2] / (1 - gProjection[2][2]); float sNearClip = gProjection[3][2] / - gProjection[2][2]; float4x4 sProjection = createProjectionMatrix(sNearClip, sFarClip, sFov, sAspect, sMoveObject2D, sScaleObject2D); float4x4 tProjection = createProjectionMatrix(sNearClip, sFarClip, sFov, sAspect, float2(0,0), sScaleObject2D / sRealScale2D); PS.Position = mul(vPos, sProjection); PS.vPosition = mul(vPos, tProjection); PS.Depth = float2(PS.Position.z, PS.Position.w); PS.TexCoord0 = VS.TexCoord0; float Diffa = MTACalcGTABuildingDiffuse(VS.Diffuse).a; PS.Diffuse = float4(0.35, 0.35, 0.3, Diffa); return PS; } struct Pixel { float4 Color : COLOR0; float4 Extra : COLOR1; float Depth : DEPTH0; }; float rM = 3; float gM = 3; float bM = 3; Pixel PixelShaderFunction(PSInput PS) { Pixel output; float4 texel = tex2D(Sampler0, PS.TexCoord0); output.Color = float4(0, 0, 0, min(min(texel.a * PS.Diffuse.a, 0.006105), sAlphaMult)); float4 finalColor = texel * PS.Diffuse; float2 scrCoord =(PS.vPosition.xy / PS.vPosition.w) * float2(0.5, -0.5) + 0.5; output.Depth = ((PS.Depth.x * 0.00625 * sProjZMult) / PS.Depth.y); if ((scrCoord.x > 1) || (scrCoord.x < 0) || (scrCoord.y > 1) || (scrCoord.y < 0)) { output.Depth = 1; output.Color = 0; } output.Extra = saturate(finalColor); output.Extra.rgb += output.Extra.rgb * sColorFilter1.rgb * sColorFilter1.a; output.Extra.rgb += output.Extra.rgb * sColorFilter2.rgb * sColorFilter2.a; output.Extra.r *= rM; output.Extra.g *= gM; output.Extra.b *= bM; output.Extra.a *= sAlphaMult; return output; } technique fx_pre_object_MRT { pass P0 { FogEnable = false; AlphaBlendEnable = true; AlphaRef = 1; SeparateAlphaBlendEnable = true; SrcBlendAlpha = SrcAlpha; DestBlendAlpha = One; VertexShader = compile vs_3_0 VertexShaderFunction(); PixelShader = compile ps_3_0 PixelShaderFunction(); } } technique fallback { pass P0 { } } "
function createElementMatrix(rx, ry, rz)
  local rx, ry, rz = math.rad(rx), math.rad(ry), math.rad(rz)
  return {
    {
      math.cos(rz) * math.cos(ry) - math.sin(rz) * math.sin(rx) * math.sin(ry),
      math.cos(ry) * math.sin(rz) + math.cos(rz) * math.sin(rx) * math.sin(ry),
      -math.cos(rx) * math.sin(ry),
      0
    },
    {
      -math.cos(rx) * math.sin(rz),
      math.cos(rz) * math.cos(rx),
      math.sin(rx),
      0
    },
    {
      math.cos(rz) * math.sin(ry) + math.cos(ry) * math.sin(rz) * math.sin(rx),
      math.sin(rz) * math.sin(ry) - math.cos(rz) * math.cos(ry) * math.sin(rx),
      math.cos(rx) * math.cos(ry),
      0
    },
    {
      0,
      0,
      0,
      1
    }
  }
end
function getEulerAnglesFromMatrix(mat)
  local nz1, nz2, nz3
  nz3 = math.sqrt(mat[2][1] * mat[2][1] + mat[2][2] * mat[2][2])
  nz1 = -mat[2][1] * mat[2][3] / nz3
  nz2 = -mat[2][2] * mat[2][3] / nz3
  local vx = nz1 * mat[1][1] + nz2 * mat[1][2] + nz3 * mat[1][3]
  local vz = nz1 * mat[3][1] + nz2 * mat[3][2] + nz3 * mat[3][3]
  return math.deg(math.asin(mat[2][3])), -math.deg(math.atan2(vx, vz)), -math.deg(math.atan2(mat[2][1], mat[2][2]))
end
function getPositionFromMatrixOffset(mat, x, y, z)
  return x * mat[1][1] + y * mat[2][1] + z * mat[3][1] + mat[4][1], x * mat[1][2] + y * mat[2][2] + z * mat[3][2] + mat[4][2], x * mat[1][3] + y * mat[2][3] + z * mat[3][3] + mat[4][3]
end
function getPositionFromMatrixOffsetEx(mat, x, y, z)
  return x * mat[1][1] + y * mat[2][1] + z * mat[3][1], x * mat[1][2] + y * mat[2][2] + z * mat[3][2], x * mat[1][3] + y * mat[2][3] + z * mat[3][3]
end
function matrixMultiply(mat1, mat2)
  local matOut = {}
  for i = 1, #mat1 do
    matOut[i] = {}
    for j = 1, #mat2[1] do
      local num = mat1[i][1] * mat2[1][j]
      for n = 2, #mat1[1] do
        num = num + mat1[i][n] * mat2[n][j]
      end
      matOut[i][j] = num
    end
  end
  return matOut
end
local chestItem = false
local objects = {}
local objectOffset = {
  {
    -0.21,
    0,
    0.0503
  },
  {
    0.2189,
    0,
    0.0168
  }
}
local csillaOffsets = {
  {106, 26},
  {133, 41},
  {252, 27},
  {259, 66},
  {394, 28},
  {449, 27}
}
local itemFont = false
local chestRt = false
local objectShader = false
local insideShader = false
function convertItemName(name)
  return utf8.lower(utf8.gsub(utf8.gsub(name, "ű", "ü"), "ő", "ö"))
end
local chestStart = getTickCount() + 1000
local chestFade = 0
local finalRot = 0
local finalLight = 0
local finalLight2 = 0
local itemShow = {}
local itemPics = {}
local itemIds = {}
function shuffleTable(t)
  local rand = math.random
  local iterations = #t
  local j
  for i = iterations, 2, -1 do
    j = rand(i)
    t[i], t[j] = t[j], t[i]
  end
  return t
end
local itemVelocity = 0
local itemRot = 0
local itemFrame = 0
local itemSound = false
local itemName = false
local itemNameNext = false
local itemGold = false
local itemGoldNext = false
local bogyeszList = {}
local nextBogyesz = 0
local itemShowoff = 0
local endWait = 8000
local minigameEnd = 1
local fadeOut = 1
local winItemPlace = 40 + math.random() * 40
local winItemId = false
local winItemPos = false
local winItemPics = false
local winItemName = false
local csillaIndex = 1
local csillaP = 0
local nextCsilla = 0
local csillaSpd = 0
local musicSound = false
local music2Sound = false
function preRenderBogyesz(delta)
  for i = #bogyeszList, 1, -1 do
    bogyeszList[i][1] = bogyeszList[i][1] + bogyeszList[i][3] * delta / 1000
    bogyeszList[i][2] = bogyeszList[i][2] + bogyeszList[i][4] * delta / 1000
    bogyeszList[i][5] = bogyeszList[i][5] + delta / 1000 * bogyeszList[i][6]
    if bogyeszList[i][7] > 0 then
      bogyeszList[i][7] = bogyeszList[i][7] - delta / 1000
      if bogyeszList[i][7] < 0 then
        table.remove(bogyeszList, i)
      end
    end
  end
end
function preRenderChest(delta)
  dxSetRenderTarget(chestRt, true)
  dxSetRenderTarget()
  local p = (getTickCount() - chestStart) / 1000
  local fall = 1
  local descend = 1
  chestFade = 0
  local rotOff = {}
  local posOff = {}
  for i = 2, 3 do
    rotOff[i] = {
      0,
      0,
      0
    }
    posOff[i] = {
      0,
      0,
      0
    }
  end
  finalRot = 0
  finalLight = 0
  if 0 < p then
    while true do
      if p <= 2 then
        if p < 0.5 then
          chestFade = 255 * getEasingValue(p / 0.5, "OutQuad")
        else
          chestFade = 255
        end
        descend = 1 - getEasingValue(p / 2, "OutBounce")
        if 1 < p and p < 1.75 then
          fall = 1 - getEasingValue((p - 1) / 0.75, "InQuad")
        elseif 1.75 <= p then
          fall = 0
        end
        rotOff[3][1] = -75 * descend
        break
      end
      fall = 0
      descend = 0
      chestFade = 255
      p = p - 2
      if 0 < p and p <= 2 then
        rotOff[3][1] = getEasingValue(math.min(p, 1), "InBack", 0.3, 1, 3) * 90
        posOff[3][2] = getEasingValue(math.max(0, math.min((p - 0.75) / 1.25, 1)), "OutBack", 0.3, 1, 1.25) * 0.25
        posOff[3][3] = -getEasingValue(math.max(0, math.min((p - 0.75) / 1.25, 1)), "InQuad", 0.3, 1, 1.25) * 2
        break
      end
      posOff[3][3] = 2
      p = p - 2
      if 0 < p and p <= 3 then
        finalRot = getEasingValue(p / 3, "InOutQuad")
        rotOff[2][2] = getEasingValue(p / 3, "InOutQuad") * -60
        break
      end
      finalRot = 1
      rotOff[2][2] = -60
      p = p - 3
      if 0 < p and p <= 2 then
        finalLight = getEasingValue(p / 2, "InOutQuad")
        break
      end
      finalLight = 1
      p = p - 1
      break
    end
  end
  csillaP = csillaP + delta / 1000 * csillaSpd
  if csillaP >= nextCsilla then
    csillaIndex = math.random(1, #csillaOffsets)
    csillaP = 0
    nextCsilla = 1 + math.random() * 2
    csillaSpd = 0.8 + 0.5 * math.random()
  end
  finalLight2 = finalLight * (0.8 + 0.2 * math.sin(getTickCount() % 5000 / 5000 * 2 * math.pi))
  if chestItem == 751 then
    dxSetShaderValue(insideShader, "rM", 2 + 1 * finalLight2 * minigameEnd)
    dxSetShaderValue(insideShader, "gM", 3 + 2.5 * finalLight2 * minigameEnd)
    dxSetShaderValue(insideShader, "bM", 2.5 + 1.5 * finalLight2 * minigameEnd)
  else
    dxSetShaderValue(insideShader, "rM", 3 + 6 * finalLight2 * minigameEnd)
    dxSetShaderValue(insideShader, "gM", 3 + 5.176470588235294 * finalLight2 * minigameEnd)
    dxSetShaderValue(insideShader, "bM", 3 + 2.9411764705882355 * finalLight2 * minigameEnd)
  end
  if 0.5 <= finalLight then
    nextBogyesz = nextBogyesz - delta
    if nextBogyesz <= 0 and 0 < minigameEnd then
      nextBogyesz = math.random() * 200 + 100
      for i = 1, math.random(1, 3) do
        local deg = -math.random() * math.pi / 2 - math.pi / 4
        local cos = math.cos(deg)
        local sin = math.sin(deg)
        local spd = 0.5 + 1 * math.random()
        table.insert(bogyeszList, {
          screenX / 2,
          screenY / 2 - 60 - 76 * itemShowoff,
          cos * 50 * spd,
          sin * 50 * spd,
          0,
          spd / 2,
          2 + math.random() * 5,
          0.5 < math.random(),
          math.random(0, 7) * 16
        })
      end
    end
    local done = true
    for i = 1, #itemShow do
      if itemShow[i] < 1 then
        done = false
        local new = itemShow[i] + delta / 1000 * 2.5
        if itemShow[i] <= 0 and 0 < new then
          local v = getEasingValue(1 - math.abs((i - 5) / 5), "OutQuad")
          if 0 < v then
            local sound = playSound("files/Whoo" .. math.random(1, 4) .. ".wav")
            setSoundVolume(sound, v)
            setSoundPan(sound, (i - 5) / 10)
          end
        end
        itemShow[i] = new
        if 1 < itemShow[i] then
          itemShow[i] = 1
        end
      end
    end
    if done then
      if itemVelocity < 1 then
        itemVelocity = itemVelocity + delta / 1000 * 0.25
        if 1 < itemVelocity then
          itemVelocity = 1
        end
      end
      if itemFrame < 1 then
        itemFrame = itemFrame + delta / 1000 * 2
        if 1 < itemFrame then
          itemFrame = 1
        end
        if chestItem == 653 then
          notaSound = "f"
        elseif chestItem == 751 then
          notaSound = "s"
        else
          notaSound = ""
        end
        if not isElement(musicSound) then
          musicSound = playSound("files/nota" .. notaSound .. ".wav", true)
        end
        if not isElement(music2Sound) then
          music2Sound = playSound("files/nota" .. notaSound .. "2.wav", true)
        end
      end
      local isp = math.min(1, 2 * itemShowoff)
      if isElement(musicSound) then
        setSoundVolume(musicSound, 0.65 * itemFrame * minigameEnd * (1 - isp))
      end
      if isElement(music2Sound) then
        setSoundVolume(music2Sound, 0.75 * isp * minigameEnd)
      end
    end
    local spd = itemVelocity * 7.5
    spd = math.min(spd, math.max(0.2, (winItemPos or 0) * 0.5, (winItemPlace + 5) * 0.5))
    spd = spd * delta / 1000
    if winItemPos and 0 < winItemPos then
      winItemPos = winItemPos - spd
      if winItemPos <= 0 then
        spd = math.max(spd + winItemPos, 1 - itemRot)
        winItemPos = 0
      end
    end
    itemRot = itemRot + spd
    winItemPlace = winItemPlace - spd
    while 1 < itemRot and (winItemPos or 1) > 0 do
      itemRot = itemRot - 1
      local item = chooseFakeItem(chestItem)
      if itemRot <= 1 and winItemPlace <= 0 and not winItemPos then
        winItemPos = 1 - itemRot + 4
        item = winItemId
      end
      table.remove(itemPics, 1)
      table.remove(itemIds, 1)
      table.insert(itemPics, ":sItems/" .. sightexports.sItems:getItemPic(item))
      table.insert(itemIds, item)
      itemSound = false
      itemName = itemNameNext
      itemNameNext = convertItemName(sightexports.sItems:getItemName(itemIds[6]))
      itemGold = itemGoldNext
      itemGoldNext = goldItems[itemIds[6]]
    end
    if 0.5 <= itemRot and not itemSound then
      itemSound = true
      if chestItem == 653 then
        spinSound = "f"
      elseif chestItem == 751 then
        spinSound = "s"
      else
        spinSound = ""
      end
      playSound("files/spin" .. spinSound .. ".wav")
    end
    if winItemPos and winItemPos <= 0 then
      itemRot = 1
      if itemShowoff < 1 then
        local new = itemShowoff + delta / 1000 * 0.65
        if itemShowoff <= 0 and 0 < new then
          if chestItem == 653 then
            winSound = "f"
          elseif chestItem == 751 then
            winSound = "m"
          else
            winSound = ""
          end
          playSound("files/waawin" .. winSound .. ".wav")
        end
        itemShowoff = new
        if 1 < itemShowoff then
          itemShowoff = 1
        end
      else
        endWait = endWait - delta
        if endWait <= 0 then
          local new = minigameEnd - delta / 1000 * 1.5
          if 1 <= minigameEnd and new < 1 then
            playSound("files/end.wav")
          end
          minigameEnd = new
          rotOff[2][2] = getEasingValue(minigameEnd, "InOutQuad") * -60
          if minigameEnd < 0 then
            minigameEnd = 0
            fadeOut = fadeOut - delta / 1000
            if fadeOut < 0 then
              fadeOut = 0
            end
          end
        end
      end
    end
  end
  local mainRX, mainRY, mainRZ = 20 * fall, 20 * fall + 30 * finalRot * minigameEnd, 270
  local offX, offY, offZ = 0, 1.5 - 0.1 * fall, 0.15 * finalRot * minigameEnd
  local x, y = screenX / 2 - 256, screenY / 2 - 256 - screenY * 0.75 * descend
  local sx, sy = 512, 512
  local psx, psy = sx / screenX / 2, sy / screenY / 2
  local ppx, ppy = x / screenX + psx - 0.5, -(y / screenY + psy - 0.5)
  ppx, ppy = 2 * ppx, 2 * ppy
  dxSetShaderValue(objectShader, "sMoveObject2D", ppx, ppy)
  dxSetShaderValue(objectShader, "sScaleObject2D", 2 * math.min(psx, psy), 2 * math.min(psx, psy))
  dxSetShaderValue(objectShader, "sRealScale2D", 2 * psx, 2 * psy)
  dxSetShaderValue(insideShader, "sMoveObject2D", ppx, ppy)
  dxSetShaderValue(insideShader, "sScaleObject2D", 2 * math.min(psx, psy), 2 * math.min(psx, psy))
  dxSetShaderValue(insideShader, "sRealScale2D", 2 * psx, 2 * psy)
  local cameraMatrix = getElementMatrix(getCamera())
  local transformMatrix = createElementMatrix(mainRX, mainRY, mainRZ)
  local multipliedMatrix = matrixMultiply(transformMatrix, cameraMatrix)
  local rotX, rotY, rotZ = getEulerAnglesFromMatrix(multipliedMatrix)
  local dim = getElementDimension(localPlayer)
  local int = getElementInterior(localPlayer)
  local posX, posY, posZ = getPositionFromMatrixOffset(cameraMatrix, offX, offY, offZ)
  setElementPosition(objects[1], posX, posY, posZ, false)
  setElementRotation(objects[1], rotX, rotY, rotZ, "ZXY")
  for i = 1, #objects do
    setElementDimension(objects[i], dim)
    setElementInterior(objects[i], int)
    if 1 < i then
      local x, y, z = getPositionFromMatrixOffsetEx(multipliedMatrix, objectOffset[i - 1][1] + posOff[i][1], objectOffset[i - 1][2] + posOff[i][2], objectOffset[i - 1][3] + posOff[i][3])
      setElementPosition(objects[i], posX + x, posY + y, posZ + z, false)
      setElementRotation(objects[i], rotX + rotOff[i][1], rotY + rotOff[i][2], rotZ + rotOff[i][3], "ZXY")
    end
  end
  dxSetShaderValue(objectShader, "sCameraPosition", cameraMatrix[4])
  dxSetShaderValue(objectShader, "sCameraForward", cameraMatrix[2])
  dxSetShaderValue(objectShader, "sCameraUp", cameraMatrix[3])
  dxSetShaderValue(insideShader, "sCameraPosition", cameraMatrix[4])
  dxSetShaderValue(insideShader, "sCameraForward", cameraMatrix[2])
  dxSetShaderValue(insideShader, "sCameraUp", cameraMatrix[3])
  if fadeOut <= 0 then
    deleteChestMinigame()
  end
end
function renderChest()
  local fOut = 0 < fadeOut
  if fOut then
    local sl = 1 - itemShowoff
    sightlangStaticImageUsed[0] = true
    if sightlangStaticImageToc[0] then
      processsightlangStaticImage[0]()
    end
    if chestItem == 751 then
      dxDrawImage(screenX / 2 - 256, screenY / 2 - 55, 512, 128, sightlangStaticImage[0], 0, 0, 0, tocolor(255, 255, 255, 255 * sl * finalLight))
    else
      dxDrawImage(screenX / 2 - 256, screenY / 2, 512, 128, sightlangStaticImage[0], 0, 0, 0, tocolor(255, 255, 255, 255 * sl * finalLight))
    end
    dxDrawImage(0, 0, screenX, screenY, chestRt, 0, 0, 0, tocolor(255, 255, 255, chestFade * fadeOut))
    sightlangStaticImageUsed[1] = true
    if sightlangStaticImageToc[1] then
      processsightlangStaticImage[1]()
    end
    dxDrawImage(screenX / 2 - 256, screenY / 2 - 256, 512, 256, sightlangStaticImage[1], 0, 0, 0, tocolor(255, 255, 255, 255 * sl * finalLight2))
    local sx = 512 * (0.5 + 0.5 * finalLight2) * finalLight
    local sy = 256 * finalLight
    sightlangStaticImageUsed[2] = true
    if sightlangStaticImageToc[2] then
      processsightlangStaticImage[2]()
    end
    dxDrawImage(screenX / 2 - sx / 2, screenY / 2 - sy - 48 * (1 - finalLight), sx, sy, sightlangStaticImage[2], 0, 0, 0, tocolor(255, 255, 255, 255 * sl * math.pow(finalLight, 2)))
  end
  for i = 1, #bogyeszList do
    if bogyeszList[i][8] then
      local p = bogyeszList[i][5]
      local x, y = bogyeszList[i][1] + math.cos(p * math.pi) * 16, bogyeszList[i][2] + math.sin(p * math.pi) * 16
      local a = math.min(1, math.min(p, bogyeszList[i][7]))
      sightlangStaticImageUsed[3] = true
      if sightlangStaticImageToc[3] then
        processsightlangStaticImage[3]()
      end
      if chestItem == 751 then
        dxDrawImageSection(x - 8, y - 8, 16, 16, bogyeszList[i][9], 0, 16, 16, sightlangStaticImage[3], 0, 0, 0, tocolor(78, 205, 196, 255 * a))
      else
        dxDrawImageSection(x - 8, y - 8, 16, 16, bogyeszList[i][9], 0, 16, 16, sightlangStaticImage[3], 0, 0, 0, tocolor(255, 198, 0, 255 * a))
      end
    end
  end
  if fOut then
    local lx, ly = screenX / 2 - 234.5, screenY / 2 - 256 - 100 + 50 * (1 - minigameEnd)
    local la = 255 * fadeOut * finalLight
    if chestItem == 653 then
      sightlangStaticImageUsed[4] = true
      if sightlangStaticImageToc[4] then
        processsightlangStaticImage[4]()
      end
      dxDrawImage(lx, ly, 469, 200, sightlangStaticImage[4], 0, 0, 0, tocolor(255, 255, 255, la))
    elseif chestItem == 751 then
      sightlangStaticImageUsed[11] = true
      if sightlangStaticImageToc[11] then
        processsightlangStaticImage[11]()
      end
      dxDrawImage(lx, ly, 469, 200, sightlangStaticImage[11], 0, 0, 0, tocolor(255, 255, 255, la))
    else
      sightlangStaticImageUsed[5] = true
      if sightlangStaticImageToc[5] then
        processsightlangStaticImage[5]()
      end
      dxDrawImage(lx, ly, 469, 200, sightlangStaticImage[5], 0, 0, 0, tocolor(255, 255, 255, la))
    end
    if 0 < csillaP and csillaP < 1 and chestItem ~= 653 then
      local a = csillaP * 2
      if 1 < a then
        a = getEasingValue(2 - a, "OutQuad")
      else
        a = getEasingValue(a, "InQuad")
      end
      local x, y = csillaOffsets[csillaIndex][1], csillaOffsets[csillaIndex][2]
      sightlangStaticImageUsed[6] = true
      if sightlangStaticImageToc[6] then
        processsightlangStaticImage[6]()
      end
      dxDrawImage(lx + x - 64, ly + y - 64, 128, 128, sightlangStaticImage[6], 90 * csillaP, 0, 0, tocolor(255, 255, 255, la * a))
    end
    if 1 <= finalRot then
      local p = itemRot
      local k = 0
      for i = -4, 5 do
        k = k + 1
        if itemShowoff <= 0 or i ~= 1 then
          local show = itemShow[k] * (1 - itemShowoff)
          if 0 < show then
            if show < 1 then
              show = getEasingValue(show, "InOutQuad")
            end
            local j = i - p
            local rx = -50 * j * show
            local ry = (64 + 40 * math.cos(j / 5 * math.pi / 2)) * show
            local p = 1 - math.abs(j / 5)
            local x, y = screenX / 2 - rx, screenY / 2 - 32 - ry
            dxDrawImage(x - 18, y - 18, 36, 36, itemPics[k], 0, 0, 0, tocolor(255, 255, 255, 255 * show * p))
            if goldItems[itemIds[k]] then
              sightlangStaticImageUsed[7] = true
              if sightlangStaticImageToc[7] then
                processsightlangStaticImage[7]()
              end
              dxDrawImage(x - 33, y - 33, 66, 66, sightlangStaticImage[7], 0, 0, 0, tocolor(chestItem == 653 and 40 or chestItem == 751 and 250 or 240, chestItem == 653 and 240 or chestItem == 751 and 179 or 40, chestItem == 653 and 186 or chestItem == 751 and 40 or 155, 255 * show * p))
            end
          end
        end
      end
    end
    if 0 < itemShowoff then
      local p = getEasingValue(itemShowoff, "InQuad")
      local x, y = screenX / 2, screenY / 2 - 32 - 104 * minigameEnd
      local r = goldItems[winItemId] and (chestItem == 653 and 40 or chestItem == 751 and 250 or 240) or 240
      local g = goldItems[winItemId] and (chestItem == 653 and 240 or chestItem == 751 and 179 or 40) or 200
      local b = goldItems[winItemId] and (chestItem == 653 and 186 or chestItem == 751 and 40 or 155) or 80
      sightlangStaticImageUsed[8] = true
      if sightlangStaticImageToc[8] then
        processsightlangStaticImage[8]()
      end
      dxDrawImage(x - 200, y - 200, 400, 400, sightlangStaticImage[8], getTickCount() / 30, 0, 0, tocolor(r, g, b, 255 * p * minigameEnd))
      local s = 1 + 0.2 * p
      dxDrawImage(x - 36 * s / 2, y - 36 * s / 2, 36 * s, 36 * s, winItemPics, 0, 0, 0, tocolor(255, 255, 255, 255 * minigameEnd))
      if goldItems[winItemId] then
        sightlangStaticImageUsed[7] = true
        if sightlangStaticImageToc[7] then
          processsightlangStaticImage[7]()
        end
        dxDrawImage(x - 66 * s / 2, y - 66 * s / 2, 66 * s, 66 * s, sightlangStaticImage[7], 0, 0, 0, tocolor(chestItem == 653 and 40 or chestItem == 751 and 250 or 240, chestItem == 653 and 240 or chestItem == 751 and 179 or 40, chestItem == 653 and 186 or chestItem == 751 and 40 or 155, 255 * minigameEnd))
      end
    end
    if chestItem ~= 751 then
      sightlangStaticImageUsed[9] = true
      if sightlangStaticImageToc[9] then
        processsightlangStaticImage[9]()
      end
      dxDrawImage(screenX / 2 - 32, screenY / 2 - 32 - 104 - 32, 64, 64, sightlangStaticImage[9], 0, 0, 0, tocolor(255, 255, 255, 255 * itemFrame * math.max(0, 1 - itemShowoff * 3)))
    else
      sightlangStaticImageUsed[12] = true
      if sightlangStaticImageToc[12] then
        processsightlangStaticImage[12]()
      end
      dxDrawImage(screenX / 2 - 32, screenY / 2 - 32 - 104 - 32, 64, 64, sightlangStaticImage[12], 0, 0, 0, tocolor(255, 255, 255, 255 * itemFrame * math.max(0, 1 - itemShowoff * 3)))
    end
    local y = screenY / 2 + 128 - 34
    local p = itemRot * 2
    if 0 < itemShowoff then
      y = y - 170 * getEasingValue(itemShowoff, "InOutQuad") + 104 * (1 - minigameEnd)
      local r = goldItems[winItemId] and (chestItem == 653 and 40 or chestItem == 751 and 250 or 240) or 240
      local g = goldItems[winItemId] and (chestItem == 653 and 240 or chestItem == 751 and 179 or 40) or 200
      local b = goldItems[winItemId] and (chestItem == 653 and 186 or chestItem == 751 and 40 or 155) or 80
      sightlangStaticImageUsed[10] = true
      if sightlangStaticImageToc[10] then
        processsightlangStaticImage[10]()
      end
      dxDrawImage(screenX / 2 - 250, y, 500, 34, sightlangStaticImage[10], 0, 0, 0, tocolor(255, 255, 255, 255 * itemFrame * minigameEnd))
      dxDrawText(winItemName, 0, y, screenX, y + 34, tocolor(r, g, b, 255 * minigameEnd), 0.5, itemFont, "center", "center")
    elseif 1 < p then
      p = 1 - getEasingValue(2 - p, "InQuad")
      local r = itemGoldNext and (chestItem == 653 and 40 or chestItem == 751 and 250 or 240) or 240
      local g = itemGoldNext and (chestItem == 653 and 240 or chestItem == 751 and 179 or 40) or 200
      local b = itemGoldNext and (chestItem == 653 and 186 or chestItem == 751 and 40 or 155) or 80
      if not itemGoldNext and chestItem == 751 then
        r, g, b = 78, 205, 196
      end
      sightlangStaticImageUsed[10] = true
      if sightlangStaticImageToc[10] then
        processsightlangStaticImage[10]()
      end
      dxDrawImage(screenX / 2 - 250, y, 500, 34, sightlangStaticImage[10], 0, 0, 0, tocolor(255, 255, 255, 255 * itemFrame * minigameEnd))
      dxDrawText(itemNameNext, 0, y, screenX, y + 34, tocolor(r, g, b, 255 * itemFrame * p), 0.5, itemFont, "center", "center")
    else
      local r = itemGold and (chestItem == 653 and 40 or chestItem == 751 and 250 or 240) or 240
      local g = itemGold and (chestItem == 653 and 240 or chestItem == 751 and 179 or 40) or 200
      local b = itemGold and (chestItem == 653 and 186 or chestItem == 751 and 40 or 155) or 80
      if not itemGold and chestItem == 751 then
        r, g, b = 78, 205, 196
      end
      p = 1 - getEasingValue(p, "InQuad")
      sightlangStaticImageUsed[10] = true
      if sightlangStaticImageToc[10] then
        processsightlangStaticImage[10]()
      end
      dxDrawImage(screenX / 2 - 250, y, 500, 34, sightlangStaticImage[10], 0, 0, 0, tocolor(255, 255, 255, 255 * itemFrame * minigameEnd))
      dxDrawText(itemName, 0, y, screenX, y + 34, tocolor(r, g, b, 255 * itemFrame * p), 0.5, itemFont, "center", "center")
    end
  end
  for i = 1, #bogyeszList do
    if not bogyeszList[i][8] then
      local p = bogyeszList[i][5]
      local x, y = bogyeszList[i][1] + math.cos(p * math.pi) * 16, bogyeszList[i][2] + math.sin(p * math.pi) * 16
      local a = math.min(1, math.min(p, bogyeszList[i][7]))
      sightlangStaticImageUsed[3] = true
      if sightlangStaticImageToc[3] then
        processsightlangStaticImage[3]()
      end
      if chestItem == 751 then
        dxDrawImageSection(x - 8, y - 8, 16, 16, bogyeszList[i][9], 0, 16, 16, sightlangStaticImage[3], 0, 0, 0, tocolor(78, 205, 196, 255 * a))
      else
        dxDrawImageSection(x - 8, y - 8, 16, 16, bogyeszList[i][9], 0, 16, 16, sightlangStaticImage[3], 0, 0, 0, tocolor(255, 198, 0, 255 * a))
      end
    end
  end
  if not fOut and #bogyeszList <= 0 then
    sightlangCondHandl0(false)
    sightlangCondHandl1(false)
  end
end
function deleteChestMinigame()
  chestItem = false
  for i = 1, #objects do
    setElementPosition(objects[i], 0, 0, 0)
    if isElement(objects[i]) then
      destroyElement(objects[i])
    end
    objects[i] = nil
  end
  if isElement(itemFont) then
    destroyElement(itemFont)
  end
  itemFont = nil
  if isElement(chestRt) then
    destroyElement(chestRt)
  end
  chestRt = nil
  if isElement(objectShader) then
    destroyElement(objectShader)
  end
  objectShader = nil
  if isElement(insideShader) then
    destroyElement(insideShader)
  end
  insideShader = nil
  if isElement(musicSound) then
    destroyElement(musicSound)
  end
  musicSound = nil
  if isElement(music2Sound) then
    destroyElement(music2Sound)
  end
  music2Sound = nil
  itemShow = {}
  itemPics = {}
  itemIds = {}
  sightlangCondHandl2(false)
end
addEvent("createChestMinigame", true)
addEventHandler("createChestMinigame", getRootElement(), function(item, itemPlace, winItem)
  deleteChestMinigame()
  chestItem = item
  table.insert(objects, createObject(sightexports.sModloader:getModelId(chestModel[item]), 0, 0, 0))
  table.insert(objects, createObject(sightexports.sModloader:getModelId(chestModel[item] .. "_top"), 0, 0, 0))
  table.insert(objects, createObject(sightexports.sModloader:getModelId(chestModel[item] .. "_lock"), 0, 0, 0))
  itemFont = dxCreateFont("files/fiddlerscove.ttf", 26, false, "antialiased")
  chestRt = dxCreateRenderTarget(screenX, screenY, true)
  objectShader = dxCreateShader(objectPreviewSource, 0, 0, false, "all")
  insideShader = dxCreateShader(objectPreviewSource, 0, 0, false, "all")
  dxSetShaderValue(objectShader, "sFov", 70)
  dxSetShaderValue(objectShader, "sAspect", screenY / screenX)
  dxSetShaderValue(objectShader, "secondRT", chestRt)
  dxSetShaderValue(insideShader, "sFov", 70)
  dxSetShaderValue(insideShader, "sAspect", screenY / screenX)
  dxSetShaderValue(insideShader, "secondRT", chestRt)
  for i = 1, #objects do
    engineApplyShaderToWorldTexture(objectShader, "*", objects[i])
    engineRemoveShaderFromWorldTexture(objectShader, "*inside", objects[i])
    engineApplyShaderToWorldTexture(insideShader, "*inside", objects[i])
    setElementCollisionsEnabled(objects[i], false)
  end
  chestStart = getTickCount()
  chestFade = 0
  finalRot = 0
  finalLight = 0
  finalLight2 = 0
  for i = 1, 10 do
    itemShow[i] = -(i - 1) * 0.5
    local item = chooseFakeItem(chestItem)
    itemPics[i] = ":sItems/" .. sightexports.sItems:getItemPic(item)
    itemIds[i] = item
  end
  shuffleTable(itemShow)
  itemVelocity = 0
  itemRot = 0
  itemFrame = 0
  itemSound = false
  itemName = convertItemName(sightexports.sItems:getItemName(itemIds[5]))
  itemNameNext = convertItemName(sightexports.sItems:getItemName(itemIds[6]))
  itemGold = goldItems[itemIds[5]]
  itemGoldNext = goldItems[itemIds[6]]
  nextBogyesz = 0
  itemShowoff = 0
  endWait = 8000
  minigameEnd = 1
  fadeOut = 1
  winItemPlace = itemPlace
  winItemId = winItem
  winItemPos = false
  winItemPics = ":sItems/" .. sightexports.sItems:getItemPic(winItemId)
  winItemName = convertItemName(sightexports.sItems:getItemName(winItemId))
  sightlangCondHandl2(true)
  sightlangCondHandl1(true)
  sightlangCondHandl0(true)
  playSound("files/boxfall.wav")
end)
function openChest(itemId, dbID)
  if chestItem then
    return
  end
  if not chestData[itemId] then
    return
  end
  triggerServerEvent("tryToStartTreasureOpening", localPlayer, itemId, dbID)
end
