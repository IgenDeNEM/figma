local sightexports = {sModloader = false, sGui = false}
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
    sightlangStaticImage[0] = dxCreateTexture("files/light.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
local spinnerIcon = false
local faTicks = false
local function sightlangGuiRefreshColors()
  local res = getResourceFromName("sGui")
  if res and getResourceState(res) == "running" then
    spinnerIcon = sightexports.sGui:getFaIconFilename("circle-notch", 48)
    faTicks = sightexports.sGui:getFaTicks()
  end
end
addEventHandler("onGuiRefreshColors", getRootElement(), sightlangGuiRefreshColors)
addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangGuiRefreshColors)
addEventHandler("refreshFaTicks", getRootElement(), function()
  faTicks = sightexports.sGui:getFaTicks()
end)
local shader = false
local shaderSource = [[
#include "files/mta-helper.fx"
 texture secondRT < string renderTarget = "yes"; >; struct Pixel { float4 Color : COLOR0; float4 Extra : COLOR1; float Depth : DEPTH0; }; struct VSInput { float3 Position : POSITION0; float4 Diffuse : COLOR0; float2 TexCoord : TEXCOORD0; }; struct PSInput { float4 Position : POSITION0; float4 Diffuse : COLOR0; float2 TexCoord : TEXCOORD0; float2 Depth : TEXCOORD1; float3 vp : TEXCOORD2; }; float sFov = 1; float sAspect = 1; float4x4 createViewMatrix( float3 pos, float3 fwVec, float3 upVec ) { float3 zaxis = normalize( fwVec); float3 xaxis = normalize( cross( -upVec, zaxis )); float3 yaxis = cross( xaxis, zaxis ); float4x4 viewMatrix = { float4( xaxis.x, yaxis.x, zaxis.x, 0 ), float4( xaxis.y, yaxis.y, zaxis.y, 0 ), float4( xaxis.z, yaxis.z, zaxis.z, 0 ), float4(-dot( xaxis, pos ), -dot( yaxis, pos ), -dot( zaxis, pos ), 1 ) }; return viewMatrix; } float3 ElementOffset = float3(0, 0, 0); float3 Cam = float3(1, 0, 0); float3 CamFW = float3(-1, 0, 0); float3 CamUP = float3(0, 0, 1); float2 ScrPos = float2(0, 0); float2 ScrS = float2(0, 0); float ScrScl = 1; float4x4 createProjectionMatrix(float near_plane, float far_plane, float fov_horiz, float fov_aspect) { float h, w, Q; w = 1/tan(fov_horiz * 0.5); h = w/fov_aspect; Q = far_plane/(far_plane - near_plane); float4x4 projectionMatrix = { float4(w*ScrScl, 0, 0, 0), float4(0, h*ScrScl, 0, 0), float4(ScrPos.x, ScrPos.y, Q, 1), float4(0, 0, -Q*near_plane, 0) }; return projectionMatrix; } PSInput VertexShaderFunction(VSInput VS) { PSInput PS = (PSInput)0; PS.TexCoord = VS.TexCoord; float4 wPos = mul(float4(VS.Position, 1), gWorld); wPos.xyz += ElementOffset; float4x4 sView = createViewMatrix(Cam, CamFW, CamUP); float4 vPos = mul(wPos, sView); float sFarClip = gProjection[3][2] / (1 - gProjection[2][2]); float sNearClip = gProjection[3][2] / - gProjection[2][2]; float4x4 sProjection = createProjectionMatrix(sNearClip, sFarClip, sFov, sAspect); PS.Position = mul(vPos, sProjection); PS.Diffuse = MTACalcGTABuildingDiffuse(VS.Diffuse); PS.Depth = float2(PS.Position.z, PS.Position.w); PS.vp.xy = PS.Position.xy; PS.vp.z = PS.Position.w; return PS; } sampler Sampler0 = sampler_state { Texture = (gTexture0); }; Pixel PixelShaderFunction(PSInput PS) { Pixel output; float4 tex = tex2D(Sampler0, PS.TexCoord); output.Color = 0; float2 scrCoord = (PS.vp.xy / PS.vp.z); if(scrCoord.x >= ScrPos.x-ScrS.x && scrCoord.x <= ScrPos.x+ScrS.x && scrCoord.y >= ScrPos.y-ScrS.y && scrCoord.y <= ScrPos.y+ScrS.y) { output.Extra = tex; output.Extra.rgb *= PS.Diffuse+0.35; output.Depth = (PS.Depth.x / PS.Depth.y); } else { output.Extra = 0; output.Depth = 1; } return output; } technique Technique1 { pass Pass1 { AlphaTestEnable = false; VertexShader = compile vs_2_0 VertexShaderFunction(); PixelShader = compile ps_2_0 PixelShaderFunction(); } } ]]
local rt = false
local obj = false
local previewModel = false
local lastForceRecreate = 0
local events = false
local prevX, prevY, prevS
prevD = false
function deletePrevShader()
  previewModel = false
  deletePrevObject()
  if isElement(rt) then
    destroyElement(rt)
  end
  rt = nil
  if isElement(shader) then
    destroyElement(shader)
  end
  shader = nil
  if isElement(obj) then
    destroyElement(obj)
  end
  obj = nil
end
function createPrevShader()
  deletePrevShader()
  rt = dxCreateRenderTarget(screenX, screenY, true)
  shader = dxCreateShader(shaderSource)
  if isElement(shader) then
    dxSetShaderValue(shader, "secondRT", rt)
    dxSetShaderValue(shader, "sFov", math.rad(70))
    dxSetShaderValue(shader, "sAspect", screenY / screenX)
  end
end
function setPrevPos(x, y, s)
  s = s or 256
  if isElement(shader) then
    dxSetShaderValue(shader, "ScrScl", s / math.min(screenX, screenY))
    dxSetShaderValue(shader, "ScrS", {
      s / screenX,
      s / screenY
    })
    dxSetShaderValue(shader, "ScrPos", {
      ((x + s / 2) / screenX - 0.5) * 2,
      -((y + s / 2) / screenY - 0.5) * 2
    })
  end
  prevX, prevY, prevS = x, y, s
end
function deletePrevObject()
  previewModel = false
  if isElement(obj) then
    setElementAlpha(obj, 0)
  end
  if isElement(shader) then
    engineRemoveShaderFromWorldTexture(shader, "*", obj)
  end
  prevX, prevY, prevS = false, false, false
  if events then
    removeEventHandler("onClientPreRender", getRootElement(), preRenderPreview)
    removeEventHandler("onClientRender", getRootElement(), renderPreview)
  end
  events = false
  prevD = false
end
function createPrevObject(model, force)
  previewModel = model
  if not isElement(shader) then
    if isElement(obj) then
      setElementAlpha(obj, 0)
    end
  else
    if not isElement(obj) then
      obj = createObject(model, 0, 0, 0)
      setElementStreamable(obj, false)
      setElementCollisionsEnabled(obj, false)
    else
      lastForceRecreate = getTickCount()
      if force then
        if isElement(obj) then
          destroyElement(obj)
        end
        obj = nil
        obj = createObject(model, 0, 0, 0)
        setElementStreamable(obj, false)
        setElementCollisionsEnabled(obj, false)
      else
        setElementModel(obj, model)
      end
    end
    setObjectScale(obj, 1)
    setElementDimension(obj, getElementDimension(localPlayer))
    setElementInterior(obj, getElementInterior(localPlayer))
    setElementRotation(obj, 0, 0, 0)
    engineApplyShaderToWorldTexture(shader, "*", obj)
    setElementAlpha(obj, 255)
    dxSetShaderValue(shader, "ScrScl", 256 / math.min(screenX, screenY))
    dxSetShaderValue(shader, "ScrS", {
      256 / screenX,
      256 / screenY
    })
    prevD = 1
  end
  if not events then
    addEventHandler("onClientPreRender", getRootElement(), preRenderPreview)
    addEventHandler("onClientRender", getRootElement(), renderPreview, true, "low-99999999")
    events = true
  end
end
local shaderReady = false
function preRenderPreview()
  if isElement(obj) and isElement(shader) then
    shaderReady = true
    local cx, cy, cz, tx, ty, tz = getCameraMatrix()
    tx = tx - cx
    ty = ty - cy
    tz = tz - cz
    local len = math.sqrt(tx * tx + ty * ty + tz * tz)
    tx = tx / len
    ty = ty / len
    tz = tz / len
    local x, y, z = cx + tx * 1, cy + ty * 1, cz + tz * 1
    setElementPosition(obj, x, y, z)
    dxSetShaderValue(shader, "ElementOffset", {
      -x,
      -y,
      -z
    })
    local r = math.rad(getTickCount() / 10)
    dxSetShaderValue(shader, "Cam", {
      math.cos(r) * prevD,
      math.sin(r) * prevD,
      0
    })
    dxSetShaderValue(shader, "CamFW", {
      -math.cos(r),
      -math.sin(r),
      0
    })
    dxSetShaderValue(shader, "CamUp", {
      0,
      0,
      1
    })
    if not prevX then
      local cx, cy = getCursorPosition()
      if cx then
        cx = cx + 136 / screenX
        cy = cy + 144 / screenY
        dxSetShaderValue(shader, "ScrPos", {
          (cx - 0.5) * 2,
          -(cy - 0.5) * 2
        })
      end
    end
  end
end
function renderPreview()
  local rx, ry, rsx, rsy = 0, 0, 0, 0
  if prevX then
    dxDrawImageSection(prevX, prevY, prevS, prevS, prevX, prevY, prevS, prevS, rt)
    rx, ry, rsx, rsy = prevX, prevY, prevS, prevS
  else
    local cx, cy = getCursorPosition()
    if cx then
      cx, cy = cx * screenX, cy * screenY
      dxDrawRectangle(cx + 8, cy + 16, 256, 256, tocolor(10, 10, 10, 200))
      sightlangStaticImageUsed[0] = true
      if sightlangStaticImageToc[0] then
        processsightlangStaticImage[0]()
      end
      dxDrawImage(cx + 8, cy + 16, 256, 256, sightlangStaticImage[0], 0, 0, 0, tocolor(60, 60, 60, 150))
      if shaderReady then
        dxDrawImageSection(cx + 8, cy + 16, 256, 256, cx + 8, cy + 16, 256, 256, rt)
      end
      rx, ry, rsx, rsy = cx + 8, cy + 16, 256, 256
    else
      deletePrevObject()
    end
  end
  if previewModel and (not (isElement(obj) and isElementOnScreen(obj)) or not isElementStreamedIn(obj)) then
    local now = getTickCount() - lastForceRecreate
    if 500 < now then
      createPrevObject(previewModel, true)
    else
      dxDrawImage(rx + rsx / 2 - 24, ry + rsy / 2 - 24, 48, 48, ":sGui/" .. spinnerIcon .. faTicks[spinnerIcon], now / 5 % 360)
    end
  end
  dxSetRenderTarget(rt, true)
  dxSetRenderTarget()
end
