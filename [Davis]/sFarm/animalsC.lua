local seexports = {
  sGui = false,
  sChat = false,
  sModloader = false,
  sPattach = false,
  sItems = false,
  sControls = false,
  sHud = false
}
local function seelangProcessExports()
  for k in pairs(seexports) do
    local res = getResourceFromName(k)
    if res and getResourceState(res) == "running" then
      seexports[k] = exports[k]
    else
      seexports[k] = false
    end
  end
end
seelangProcessExports()
if triggerServerEvent then
  addEventHandler("onClientResourceStart", getRootElement(), seelangProcessExports, true, "high+9999999999")
end
if triggerClientEvent then
  addEventHandler("onResourceStart", getRootElement(), seelangProcessExports, true, "high+9999999999")
end
local seelangStatImgHand = false
local seelangStaticImage = {}
local seelangStaticImageToc = {}
local seelangStaticImageUsed = {}
local seelangStaticImageDel = {}
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
local seelangStatImgPre
function seelangStatImgPre()
  local now = getTickCount()
  if seelangStaticImageUsed[0] then
    seelangStaticImageUsed[0] = false
    seelangStaticImageDel[0] = false
  elseif seelangStaticImage[0] then
    if seelangStaticImageDel[0] then
      if now >= seelangStaticImageDel[0] then
        if isElement(seelangStaticImage[0]) then
          destroyElement(seelangStaticImage[0])
        end
        seelangStaticImage[0] = nil
        seelangStaticImageDel[0] = false
        seelangStaticImageToc[0] = true
        return
      end
    else
      seelangStaticImageDel[0] = now + 5000
    end
  else
    seelangStaticImageToc[0] = true
  end
  if seelangStaticImageUsed[1] then
    seelangStaticImageUsed[1] = false
    seelangStaticImageDel[1] = false
  elseif seelangStaticImage[1] then
    if seelangStaticImageDel[1] then
      if now >= seelangStaticImageDel[1] then
        if isElement(seelangStaticImage[1]) then
          destroyElement(seelangStaticImage[1])
        end
        seelangStaticImage[1] = nil
        seelangStaticImageDel[1] = false
        seelangStaticImageToc[1] = true
        return
      end
    else
      seelangStaticImageDel[1] = now + 5000
    end
  else
    seelangStaticImageToc[1] = true
  end
  if seelangStaticImageUsed[2] then
    seelangStaticImageUsed[2] = false
    seelangStaticImageDel[2] = false
  elseif seelangStaticImage[2] then
    if seelangStaticImageDel[2] then
      if now >= seelangStaticImageDel[2] then
        if isElement(seelangStaticImage[2]) then
          destroyElement(seelangStaticImage[2])
        end
        seelangStaticImage[2] = nil
        seelangStaticImageDel[2] = false
        seelangStaticImageToc[2] = true
        return
      end
    else
      seelangStaticImageDel[2] = now + 5000
    end
  else
    seelangStaticImageToc[2] = true
  end
  if seelangStaticImageUsed[3] then
    seelangStaticImageUsed[3] = false
    seelangStaticImageDel[3] = false
  elseif seelangStaticImage[3] then
    if seelangStaticImageDel[3] then
      if now >= seelangStaticImageDel[3] then
        if isElement(seelangStaticImage[3]) then
          destroyElement(seelangStaticImage[3])
        end
        seelangStaticImage[3] = nil
        seelangStaticImageDel[3] = false
        seelangStaticImageToc[3] = true
        return
      end
    else
      seelangStaticImageDel[3] = now + 5000
    end
  else
    seelangStaticImageToc[3] = true
  end
  if seelangStaticImageUsed[4] then
    seelangStaticImageUsed[4] = false
    seelangStaticImageDel[4] = false
  elseif seelangStaticImage[4] then
    if seelangStaticImageDel[4] then
      if now >= seelangStaticImageDel[4] then
        if isElement(seelangStaticImage[4]) then
          destroyElement(seelangStaticImage[4])
        end
        seelangStaticImage[4] = nil
        seelangStaticImageDel[4] = false
        seelangStaticImageToc[4] = true
        return
      end
    else
      seelangStaticImageDel[4] = now + 5000
    end
  else
    seelangStaticImageToc[4] = true
  end
  if seelangStaticImageUsed[5] then
    seelangStaticImageUsed[5] = false
    seelangStaticImageDel[5] = false
  elseif seelangStaticImage[5] then
    if seelangStaticImageDel[5] then
      if now >= seelangStaticImageDel[5] then
        if isElement(seelangStaticImage[5]) then
          destroyElement(seelangStaticImage[5])
        end
        seelangStaticImage[5] = nil
        seelangStaticImageDel[5] = false
        seelangStaticImageToc[5] = true
        return
      end
    else
      seelangStaticImageDel[5] = now + 5000
    end
  else
    seelangStaticImageToc[5] = true
  end
  if seelangStaticImageUsed[6] then
    seelangStaticImageUsed[6] = false
    seelangStaticImageDel[6] = false
  elseif seelangStaticImage[6] then
    if seelangStaticImageDel[6] then
      if now >= seelangStaticImageDel[6] then
        if isElement(seelangStaticImage[6]) then
          destroyElement(seelangStaticImage[6])
        end
        seelangStaticImage[6] = nil
        seelangStaticImageDel[6] = false
        seelangStaticImageToc[6] = true
        return
      end
    else
      seelangStaticImageDel[6] = now + 5000
    end
  else
    seelangStaticImageToc[6] = true
  end
  if seelangStaticImageUsed[7] then
    seelangStaticImageUsed[7] = false
    seelangStaticImageDel[7] = false
  elseif seelangStaticImage[7] then
    if seelangStaticImageDel[7] then
      if now >= seelangStaticImageDel[7] then
        if isElement(seelangStaticImage[7]) then
          destroyElement(seelangStaticImage[7])
        end
        seelangStaticImage[7] = nil
        seelangStaticImageDel[7] = false
        seelangStaticImageToc[7] = true
        return
      end
    else
      seelangStaticImageDel[7] = now + 5000
    end
  else
    seelangStaticImageToc[7] = true
  end
  if seelangStaticImageUsed[8] then
    seelangStaticImageUsed[8] = false
    seelangStaticImageDel[8] = false
  elseif seelangStaticImage[8] then
    if seelangStaticImageDel[8] then
      if now >= seelangStaticImageDel[8] then
        if isElement(seelangStaticImage[8]) then
          destroyElement(seelangStaticImage[8])
        end
        seelangStaticImage[8] = nil
        seelangStaticImageDel[8] = false
        seelangStaticImageToc[8] = true
        return
      end
    else
      seelangStaticImageDel[8] = now + 5000
    end
  else
    seelangStaticImageToc[8] = true
  end
  if seelangStaticImageUsed[9] then
    seelangStaticImageUsed[9] = false
    seelangStaticImageDel[9] = false
  elseif seelangStaticImage[9] then
    if seelangStaticImageDel[9] then
      if now >= seelangStaticImageDel[9] then
        if isElement(seelangStaticImage[9]) then
          destroyElement(seelangStaticImage[9])
        end
        seelangStaticImage[9] = nil
        seelangStaticImageDel[9] = false
        seelangStaticImageToc[9] = true
        return
      end
    else
      seelangStaticImageDel[9] = now + 5000
    end
  else
    seelangStaticImageToc[9] = true
  end
  if seelangStaticImageUsed[10] then
    seelangStaticImageUsed[10] = false
    seelangStaticImageDel[10] = false
  elseif seelangStaticImage[10] then
    if seelangStaticImageDel[10] then
      if now >= seelangStaticImageDel[10] then
        if isElement(seelangStaticImage[10]) then
          destroyElement(seelangStaticImage[10])
        end
        seelangStaticImage[10] = nil
        seelangStaticImageDel[10] = false
        seelangStaticImageToc[10] = true
        return
      end
    else
      seelangStaticImageDel[10] = now + 5000
    end
  else
    seelangStaticImageToc[10] = true
  end
  if seelangStaticImageToc[0] and seelangStaticImageToc[1] and seelangStaticImageToc[2] and seelangStaticImageToc[3] and seelangStaticImageToc[4] and seelangStaticImageToc[5] and seelangStaticImageToc[6] and seelangStaticImageToc[7] and seelangStaticImageToc[8] and seelangStaticImageToc[9] and seelangStaticImageToc[10] then
    seelangStatImgHand = false
    removeEventHandler("onClientPreRender", getRootElement(), seelangStatImgPre)
  end
end
processSeelangStaticImage[0] = function()
  if not isElement(seelangStaticImage[0]) then
    seelangStaticImageToc[0] = false
    seelangStaticImage[0] = dxCreateTexture("files/textures/water2.dds", "argb", true)
  end
  if not seelangStatImgHand then
    seelangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), seelangStatImgPre, true, "high+999999999")
  end
end
processSeelangStaticImage[1] = function()
  if not isElement(seelangStaticImage[1]) then
    seelangStaticImageToc[1] = false
    seelangStaticImage[1] = dxCreateTexture("files/textures/water.dds", "argb", true)
  end
  if not seelangStatImgHand then
    seelangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), seelangStatImgPre, true, "high+999999999")
  end
end
processSeelangStaticImage[2] = function()
  if not isElement(seelangStaticImage[2]) then
    seelangStaticImageToc[2] = false
    seelangStaticImage[2] = dxCreateTexture("files/arrow.dds", "argb", true)
  end
  if not seelangStatImgHand then
    seelangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), seelangStatImgPre, true, "high+999999999")
  end
end
processSeelangStaticImage[3] = function()
  if not isElement(seelangStaticImage[3]) then
    seelangStaticImageToc[3] = false
    seelangStaticImage[3] = dxCreateTexture("files/textures/land.dds", "argb", true)
  end
  if not seelangStatImgHand then
    seelangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), seelangStatImgPre, true, "high+999999999")
  end
end
processSeelangStaticImage[4] = function()
  if not isElement(seelangStaticImage[4]) then
    seelangStaticImageToc[4] = false
    seelangStaticImage[4] = dxCreateTexture("files/textures/land_wet.dds", "argb", true)
  end
  if not seelangStatImgHand then
    seelangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), seelangStatImgPre, true, "high+999999999")
  end
end
processSeelangStaticImage[5] = function()
  if not isElement(seelangStaticImage[5]) then
    seelangStaticImageToc[5] = false
    seelangStaticImage[5] = dxCreateTexture("files/textures/wetshit.dds", "argb", true)
  end
  if not seelangStatImgHand then
    seelangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), seelangStatImgPre, true, "high+999999999")
  end
end
processSeelangStaticImage[6] = function()
  if not isElement(seelangStaticImage[6]) then
    seelangStaticImageToc[6] = false
    seelangStaticImage[6] = dxCreateTexture("files/textures/hay.dds", "argb", true)
  end
  if not seelangStatImgHand then
    seelangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), seelangStatImgPre, true, "high+999999999")
  end
end
processSeelangStaticImage[7] = function()
  if not isElement(seelangStaticImage[7]) then
    seelangStaticImageToc[7] = false
    seelangStaticImage[7] = dxCreateTexture("files/textures/pisa.dds", "argb", true)
  end
  if not seelangStatImgHand then
    seelangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), seelangStatImgPre, true, "high+999999999")
  end
end
processSeelangStaticImage[8] = function()
  if not isElement(seelangStaticImage[8]) then
    seelangStaticImageToc[8] = false
    seelangStaticImage[8] = dxCreateTexture("files/textures/manure.dds", "argb", true)
  end
  if not seelangStatImgHand then
    seelangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), seelangStatImgPre, true, "high+999999999")
  end
end
processSeelangStaticImage[9] = function()
  if not isElement(seelangStaticImage[9]) then
    seelangStaticImageToc[9] = false
    seelangStaticImage[9] = dxCreateTexture("files/stripe.dds", "argb", true)
  end
  if not seelangStatImgHand then
    seelangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), seelangStatImgPre, true, "high+999999999")
  end
end
processSeelangStaticImage[10] = function()
  if not isElement(seelangStaticImage[10]) then
    seelangStaticImageToc[10] = false
    seelangStaticImage[10] = dxCreateTexture("files/w.dds", "argb", true)
  end
  if not seelangStatImgHand then
    seelangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), seelangStatImgPre, true, "high+999999999")
  end
end
local milkingFont = false
local milkingFontScale = false
local function seelangGuiRefreshColors()
  local res = getResourceFromName("sGui")
  if res and getResourceState(res) == "running" then
    milkingFont = seexports.sGui:getFont("12/Ubuntu-R.ttf")
    milkingFontScale = seexports.sGui:getFontScale("12/Ubuntu-R.ttf")
    animalsRefreshListener()
  end
end
addEventHandler("onGuiRefreshColors", getRootElement(), seelangGuiRefreshColors)
addEventHandler("onClientResourceStart", getResourceRootElement(), seelangGuiRefreshColors)
local seelangModloaderLoaded = function()
  sheepCutterLoaded()
end
addEventHandler("modloaderLoaded", getRootElement(), seelangModloaderLoaded)
if getElementData(localPlayer, "loggedIn") or seexports.sModloader and seexports.sModloader:isModloaderLoaded() then
  addEventHandler("onClientResourceStart", getResourceRootElement(), seelangModloaderLoaded)
end
local seelangCondHandlState0 = false
local function seelangCondHandl0(cond, prio)
  cond = cond and true or false
  if cond ~= seelangCondHandlState0 then
    seelangCondHandlState0 = cond
    if cond then
      addEventHandler("onClientRender", getRootElement(), renderMarkedAnimals, true, prio)
    else
      removeEventHandler("onClientRender", getRootElement(), renderMarkedAnimals)
    end
  end
end
local myRT = false
local myShader = false
local morphShader = [[
#include "files/mta-helper.fx"
 struct VSInput { float3 Position : POSITION0; float3 Normal : NORMAL0; float4 Diffuse : COLOR0; float2 TexCoord : TEXCOORD0; }; struct PSInput { float4 Position : POSITION0; float4 Diffuse : COLOR0; float2 TexCoord : TEXCOORD0; float4 Lighting: TEXCOORD6; }; float size = 1; float morph = 0; PSInput VertexShaderFunction(VSInput VS) { PSInput PS = (PSInput)0; VS.Position += VS.Normal * morph; VS.Position = VS.Position * size; VS.Position.z += size-1; PS.Position = MTACalcScreenPosition ( VS.Position ); PS.TexCoord = VS.TexCoord; ]]
local morphShaderTrailer = [[
	PS.Lighting = 0.45;
	PS.Diffuse = 0.45;
]]
local morphShaderNormal = "\tPS.Diffuse = MTACalcGTABuildingDiffuse( VS.Diffuse );\n"
local morphShader2 = [[
	return PS;
}

texture gTexture;

technique tec0
{
	pass P0
	{
		VertexShader = compile vs_2_0 VertexShaderFunction();
		Texture[0] = gTexture;
	}
}

technique fallback
{
	pass P0
	{
	}
}

]]
local postEdge = [[
//
// post_edge.fx
//

//------------------------------------------------------------------------------------------
// Variables
//------------------------------------------------------------------------------------------
float2 sRes = float2(800,600);
float blurStr = 1;
float edgeStr = 2;

// between 1 and 64
float bitDepth = 16;

// between 0 and 1
float outlStreng = 1;

//------------------------------------------------------------------------------------------
// Textures
//------------------------------------------------------------------------------------------
texture sTex0;

//------------------------------------------------------------------------------------------
// Sampler Inputs
//------------------------------------------------------------------------------------------
sampler Sampler0 = sampler_state
{
	Texture = <sTex0>;
	MinFilter = Linear;
	MagFilter = Linear;
	MipFilter = Linear;
	AddressU = Mirror;
	AddressV = Mirror;
};


//------------------------------------------------------------------------------------------
// PixelShaderFunction
//------------------------------------------------------------------------------------------
float4 PixelShaderFunction(float2 TexCoord : TEXCOORD0) : COLOR0
{
	float4 Blur = tex2D(Sampler0, TexCoord);
	float4 s1 = tex2D(Sampler0, TexCoord + blurStr * float2(-1.0f / sRes.x, -1.0f / sRes.y));
	float4 s2 = tex2D(Sampler0, TexCoord + blurStr * float2(0, -1.0f / sRes.y));
	float4 s3 = tex2D(Sampler0, TexCoord + blurStr * float2(1.0f / sRes.x, -1.0f / sRes.y));
	float4 s4 = tex2D(Sampler0, TexCoord + blurStr * float2(-1.0f / sRes.x, 0));
	float4 s5 = tex2D(Sampler0, TexCoord + blurStr * float2(-1.0f / sRes.x, 0));
	float4 s6 = tex2D(Sampler0, TexCoord + blurStr * float2(-1.0f / sRes.x, 1.0f / sRes.y));
	float4 s7 = tex2D(Sampler0, TexCoord + blurStr * float2(0, 1.0f / sRes.y));
	float4 s8 = tex2D(Sampler0, TexCoord + blurStr * float2(1.0f / sRes.x, 1.0f / sRes.y));
	  
	Blur = (Blur + s1 + s2 + s3 + s4 + s5 + s6 + s7 + s8) / 9;
  
	float4 Color = Blur;

	Color.rgb *= bitDepth;
	Color.rgb = floor(Color.rgb);
	Color.rgb /= bitDepth;

	float4 lum = float4(0.30, 0.6, 0.1, 1);
 
	float s11 = dot(tex2D(Sampler0, TexCoord + edgeStr * float2(-1.0f / sRes.x, -1.0f / sRes.y)), lum);
	float s12 = dot(tex2D(Sampler0, TexCoord + edgeStr * float2(0, -1.0f / sRes.y)), lum);
	float s13 = dot(tex2D(Sampler0, TexCoord + edgeStr * float2(1.0f / sRes.x, -1.0f / sRes.y)), lum);
 
	float s21 = dot(tex2D(Sampler0, TexCoord + edgeStr * float2(-1.0f / sRes.x, 0)), lum);
	float s23 = dot(tex2D(Sampler0, TexCoord + edgeStr * float2(-1.0f / sRes.x, 0)), lum);
 
	float s31 = dot(tex2D(Sampler0, TexCoord + edgeStr * float2(-1.0f / sRes.x, 1.0f / sRes.y)), lum);
	float s32 = dot(tex2D(Sampler0, TexCoord + edgeStr * float2(0, 1.0f / sRes.y)), lum);
	float s33 = dot(tex2D(Sampler0, TexCoord + edgeStr * float2(1.0f / sRes.x, 1.0f / sRes.y)), lum);

	float t1 = s13 + s33 + (2 * s23) - s11 - (2 * s21) - s31;
	float t2 = s31 + (2 * s32) + s33 - s11 - (2 * s12) - s13;
 
	float4 OutLine;
 
	if (((t1 * t1) + (t2 * t2)) > outlStreng/10) {
		OutLine = 1;
	} else {
		OutLine = 0;
	}

	float4 finalColor = Blur * OutLine;
	
	return finalColor;
}
 
technique edge
{
	pass Pass1
	{
		SrcBlend = SrcAlpha;
		DestBlend = One;
		PixelShader = compile ps_2_0 PixelShaderFunction();
	}
}

]]
local pedWallShader = [[
//

#include "files/mta-helper.fx"


// ped_wall_mrt.fx
//

//------------------------------------------------------------------------------------------
// Variables
//------------------------------------------------------------------------------------------
float4 sColorizePed = float4(1,1,1,1);

//------------------------------------------------------------------------------------------
// Include some common stuff
//------------------------------------------------------------------------------------------
//texture gTexture0 < string textureState="0,Texture"; >;
//float4x4 gWorld : WORLD;
//float4x4 gView : VIEW;
//float4x4 gWorldView : WORLDVIEW;
//float4x4 gProjection: PROJECTION;
//float3 gCameraDirection : CAMERADIRECTION;
//float3 gCameraPosition : CAMERAPOSITION;
//int CUSTOMFLAGS < string skipUnusedParameters = "yes"; >;

texture secondRT < string renderTarget = "yes"; >;

//------------------------------------------------------------------------------------------
// Sampler Inputs
//------------------------------------------------------------------------------------------
sampler ColorSampler = sampler_state
{
    Texture = (gTexture0);
};

//------------------------------------------------------------------------------------------
// Structure of data sent to the pixel shader ( from the vertex shader )
//------------------------------------------------------------------------------------------
struct PSInput
{
    float4 Position : POSITION0;
    float2 TexCoord : TEXCOORD0;
    float4 Diffuse : COLOR0;
};

//------------------------------------------------------------------------------------------
// Structure of color data sent to the renderer ( from the pixel shader
//------------------------------------------------------------------------------------------
struct Pixel
{
    float4 Color : COLOR0;      // Render target #0
    float4 Extra : COLOR1;      // Render target #1
};

//------------------------------------------------------------------------------------------
// PixelShaderFunction
//------------------------------------------------------------------------------------------
Pixel PixelShaderFunction(PSInput PS)
{
    Pixel output;
    float texelAlpha = tex2D(ColorSampler, PS.TexCoord.xy).a;	
    output.Color = float4(0, 0, 0, min(texelAlpha * PS.Diffuse.a, 0.006105));
    output.Extra = float4(sColorizePed.rgb, texelAlpha * sColorizePed.a);
	
    return output;
}

float size = 1;
float morph = 0;


struct VSInput
{
	float3 Position : POSITION0;
	float3 Normal : NORMAL0;
	float4 Diffuse : COLOR0;
	float2 TexCoord : TEXCOORD0;
};


PSInput VertexShaderFunction(VSInput VS)
{
	PSInput PS = (PSInput)0;

	// Do morph effect by adding surface normal to the vertex position
	VS.Position += VS.Normal * morph;
	VS.Position = VS.Position * size; 
	
	VS.Position.z += size-1;

	// Calculate screen pos of vertex
	PS.Position = MTACalcScreenPosition ( VS.Position );

	// Pass through tex coords
	//PS.TexCoord = VS.TexCoord;

	PS.Diffuse = 1;//MTACalcGTABuildingDiffuse( VS.Diffuse );


	return PS;
}


//------------------------------------------------------------------------------------------
// Techniques
//------------------------------------------------------------------------------------------
technique ped_wall_mrt
{
    pass P0
    {
        ZEnable = false;
        AlphaBlendEnable = true;
        AlphaRef = 1;
        VertexShader = compile vs_2_0 VertexShaderFunction();
        PixelShader  = compile ps_2_0 PixelShaderFunction();
    }
}

// Fallback
technique fallback
{
    pass P0
    {
        // Just draw normally
    }
}

]]
animalHoverBox = false
local bucketContentObjects = {}
local bucketList = {}
local furikWheelLastSound = {}
local furikWheelRot = {}
local furikWheels = {}
local furikManures = {}
local furikWheelList = {}
local furikCarriedBy = {}
function processFurikWheels(obj, state)
  if not furikCarriedBy[obj] or state and not isElement(furikWheels[obj] or not isElement(furikManures[obj])) then
    if isElement(furikWheels[obj]) then
      destroyElement(furikWheels[obj])
    end
    furikWheels[obj] = nil
    if isElement(furikManures[obj]) then
      destroyElement(furikManures[obj])
    end
    furikManures[obj] = nil
    furikWheels[obj] = nil
    furikManures[obj] = nil
    if isElement(obj) and state then
      if not isElement(furikWheels[obj]) then
        furikWheels[obj] = createObject(models.furik_wheel, 0, 0, 0)
        setElementCollisionsEnabled(furikWheels[obj], false)
        table.insert(furikWheelList, obj)
      end
      if not isElement(furikManures[obj]) then
        furikManures[obj] = createObject(models.furik_manure, 0, 0, 0)
        setElementCollisionsEnabled(furikManures[obj], false)
      end
    else
      for i = 1, #furikWheelList do
        if furikWheelList[i] == obj then
          table.remove(furikWheelList, i)
          break
        end
      end
    end
  end
end
local furikManureLevel = {}
local furikManureAnimation = {}
local playerBucket = {}
local localFurik = false
addEventHandler("onClientElementDataChange", getRootElement(), function(key, old, new)
  if source == getPedOccupiedVehicle(localPlayer) and data == "towCar" then
    refreshTrailerMarker(veh)
  elseif key == "currentBucket" then
    if old then
      if oldWs[source] then
        setPedWalkingStyle(source, oldWs[source])
      end
      oldWs[source] = false
      engineRestoreAnimation(source, "ped", "WALK_armed")
      engineRestoreAnimation(source, "ped", "walk_start_armed")
      engineRestoreAnimation(source, "ped", "IDLE_armed")
    end
    playerBucket[source] = new
    if new then
      engineReplaceAnimation(source, "ped", "WALK_armed", "vodor_seta", "walk_armed")
      engineReplaceAnimation(source, "ped", "walk_start_armed", "vodor_start", "walk_armed")
      engineReplaceAnimation(source, "ped", "IDLE_armed", "vodor_idle", "idle_armed")
      if not oldWs[source] then
        oldWs[source] = getPedWalkingStyle(source)
      end
      setPedWalkingStyle(source, 60)
      if source == localPlayer and isPedDucked(source) then
        setPedControlState(source, "crouch", true)
        setTimer(setPedControlState, 50, 1, source, "crouch", false)
      end
      refreshBucketContent(new[1], new[2], true, new[4])
    end
  elseif key == "manureContent" then
    furikManureAnimation[source] = {
      furikManureLevel[source] or 0,
      new,
      getTickCount()
    }
  elseif key == "currentFurik" then
    if old then
      if oldWs[source] then
        setPedWalkingStyle(source, oldWs[source])
      end
      oldWs[source] = false
      engineRestoreAnimation(source, "ped", "WALK_armed")
      engineRestoreAnimation(source, "ped", "walk_start_armed")
      engineRestoreAnimation(source, "ped", "IDLE_armed")
      furikCarriedBy[old] = nil
      if isElement(old) then
        setElementCollisionsEnabled(old, true)
      end
      if not isElement(old) or not isElementStreamedIn(old) then
        for i = 1, #furikWheelList do
          if furikWheelList[i] == old then
            table.remove(furikWheelList, i)
            break
          end
        end
      end
    end
    if source == localPlayer then
      localFurik = new
    end
    if new then
      engineReplaceAnimation(source, "ped", "WALK_armed", "furik_seta", "walk_civi")
      engineReplaceAnimation(source, "ped", "walk_start_armed", "furik_start", "walk_start")
      engineReplaceAnimation(source, "ped", "IDLE_armed", "furik_idle", "idle_armed")
      if not oldWs[source] then
        oldWs[source] = getPedWalkingStyle(source)
      end
      setPedWalkingStyle(source, 60)
      if source == localPlayer and isPedDucked(source) then
        setPedControlState(source, "crouch", true)
        setTimer(setPedControlState, 50, 1, source, "crouch", false)
      end
      setElementCollisionsEnabled(new, false)
      furikCarriedBy[new] = source
      processFurikWheels(new, true)
      for i = 1, #furikWheelList do
        if furikWheelList[i] == new then
          table.remove(furikWheelList, i)
          break
        end
      end
      table.insert(furikWheelList, new)
    end
  end
end)
function getPositionFromElementOffset(element, offX, offY, offZ)
  local m = getElementMatrix(element)
  local x = offX * m[1][1] + offY * m[2][1] + offZ * m[3][1]
  local y = offX * m[1][2] + offY * m[2][2] + offZ * m[3][2]
  local z = offX * m[1][3] + offY * m[2][3] + offZ * m[3][3]
  return x, y, z, m[4][1], m[4][2], m[4][3]
end
local trailerAnimals = {}
local animalSoundNums = {
  chicken = 8,
  cow = 7,
  goat = 3,
  pig = 6,
  sheep = 7
}
function getPositionFromMatrixOffset(m, offX, offY, offZ)
  local x = offX * m[1][1] + offY * m[2][1] + offZ * m[3][1] + m[4][1]
  local y = offX * m[1][2] + offY * m[2][2] + offZ * m[3][2] + m[4][2]
  local z = offX * m[1][3] + offY * m[2][3] + offZ * m[3][3] + m[4][3]
  return x, y, z
end
addEventHandler("onClientPedsProcessed", getRootElement(), function()
  for i = 1, #bucketList do
    local obj = bucketList[i]
    if isElement(obj) and isElement(bucketContentObjects[obj]) and isElementStreamedIn(obj) and isElementOnScreen(obj) then
      setElementDimension(bucketContentObjects[obj], getElementDimension(obj))
      if bucketContents[obj][5] then
        local p = (getTickCount() - bucketContents[obj][5]) / bucketContents[obj][6]
        if 1 < p then
          p = 1
          bucketContents[obj][5] = false
        end
        bucketContents[obj][2] = bucketContents[obj][3] + (bucketContents[obj][4] - bucketContents[obj][3]) * p
      end
      local p = bucketContents[obj][2]
      local m = getElementMatrix(obj)
      local x, y, z = getPositionFromMatrixOffset(m, 0, 0, -0.35 * (1 - p) * 0.8)
      m[4][1] = x
      m[4][2] = y
      m[4][3] = z
      setElementMatrix(bucketContentObjects[obj], m)
      setObjectScale(bucketContentObjects[obj], 0.82 + 0.18 * p, 0.82 + 0.18 * p, 1)
    end
  end
end, true, "low-99999999999")
addEventHandler("onClientPreRender", getRootElement(), function()
  local vehRots = {}
  for i = #trailerAnimals, 1, -1 do
    if trailerAnimals[i] then
      local veh = trailerAnimals[i][1]
      if isElement(veh) and isElementStreamedIn(veh) then
        local rot = vehRots[veh]
        if not rot then
          rot = {
            getElementRotation(veh)
          }
          vehRots[veh] = rot
        end
        if getTickCount() - trailerAnimals[i][4] > 0 then
          local animalType = trailerAnimals[i][5]
          trailerAnimals[i][4] = getTickCount() + math.random(5000, 15000)
          local id = math.random(1, animalSoundNums[animalType])
          local x, y, z = getElementPosition(trailerAnimals[i][2])
          local sound = playSound3D("files/sound/" .. animalType .. id .. ".mp3", x, y, z)
          setElementDimension(sound, getElementDimension(trailerAnimals[i][2]))
          attachElements(sound, trailerAnimals[i][2])
        end
        setElementRotation(trailerAnimals[i][2], rot[1], rot[2], rot[3] + trailerAnimals[i][3], "default", true)
      else
        table.remove(trailerAnimals, i)
      end
    else
      table.remove(trailerAnimals, i)
    end
  end
  for i = 1, #furikWheelList do
    local obj = furikWheelList[i]
    if isElement(obj) and isElement(furikWheels[obj]) and isElement(furikManures[obj]) then
      local dim = 0
      local velo = 0
      local fx, fy, fz = getElementPosition(obj)
      if furikCarriedBy[obj] then
        if isElement(furikCarriedBy[obj]) then
          if isElementStreamedIn(furikCarriedBy[obj]) then
            local x, y, z, px, py, pz = getPositionFromElementOffset(furikCarriedBy[obj], 0, 1, 0)
            local bx, by, bz = getPedBonePosition(furikCarriedBy[obj], 25)
            local bx2, by2, bz2 = getPedBonePosition(furikCarriedBy[obj], 35)
            if bx and bx2 then
              px = (bx + bx2) / 2
              py = (by + by2) / 2
              pz = (bz + bz2) / 2
            end
            local rx, ry, rz = getElementRotation(furikCarriedBy[obj])
            local gz = getGroundPosition(px, py, pz) + 0.210867
            local gz2 = gz - pz
            local r = math.sqrt(3.997220890016)
            local poz = math.sqrt(r * r - gz2 * gz2)
            local ofx, ofy, ofz = fx, fy, fz
            fx, fy, fz = px + x * poz, py + y * poz, gz
            local velocity = math.sqrt(math.pow(fx - ofx, 2) + math.pow(fy - ofy, 2) + math.pow(fz - ofz, 2))
            local k = 0.421734 * math.pi
            velo = 360 * velocity / k
            local ax, ay = 1.97462, -0.313204
            len = math.sqrt(ax * ax + ay * ay)
            ax = ax / len
            ay = ay / len
            local bx, by = poz, gz2
            len = math.sqrt(bx * bx + by * by)
            bx = bx / len
            by = by / len
            local rot = math.deg(math.atan2(by, bx) - math.atan2(ay, ax))
            setElementPosition(obj, fx, fy, fz)
            setElementRotation(obj, rot, 0, rz)
            dim = getElementDimension(furikCarriedBy[obj])
            setElementDimension(obj, dim)
          else
            fx, fy, fz = getElementPosition(furikCarriedBy[obj])
            dim = getElementDimension(furikCarriedBy[obj])
            setElementPosition(obj, fx, fy, fz)
            setElementDimension(obj, dim)
          end
        else
          furikCarriedBy[obj] = nil
          dim = getElementDimension(obj)
        end
      else
        dim = getElementDimension(obj)
      end
      if furikManureAnimation[obj] then
        local t = (getTickCount() - furikManureAnimation[obj][3]) / 2500
        if 1 < t then
          furikManureLevel[obj] = furikManureAnimation[obj][2]
          furikManureAnimation[obj] = false
        else
          furikManureLevel[obj] = furikManureAnimation[obj][1] + (furikManureAnimation[obj][2] - furikManureAnimation[obj][1]) * t
        end
      end
      local p = furikManureLevel[obj] or 0
      setElementDimension(furikManures[obj], dim)
      setObjectScale(furikManures[obj], 0.675 + 0.325 * math.min(1, p * 1.25), 0.675 + 0.325 * math.min(1, p * 1.25), p)
      attachElements(furikManures[obj], obj, 0.001402, -0.638637, 0.029615 - 0.0125 * (1 - p))
      setElementDimension(furikWheels[obj], dim)
      local rx2, ry2, rz = getElementRotation(obj)
      local rx, ry, rz2 = getElementRotation(furikWheels[obj])
      setElementPosition(furikWheels[obj], fx, fy, fz)
      setElementRotation(furikWheels[obj], rx - velo, 0, rz)
      furikWheelRot[obj] = (furikWheelRot[obj] or 0) + velo
      if 360 < furikWheelRot[obj] and getTickCount() - (furikWheelLastSound[obj] or 0) > 800 then
        furikWheelLastSound[obj] = getTickCount()
        furikWheelRot[obj] = math.random(-3000, 3000) / 100
        local sound = playSound3D("files/sound/wheel" .. math.random(1, 3) .. ".mp3", fx, fy, fy)
        setElementDimension(sound, dim)
        attachElements(sound, furikWheels[obj])
      end
    end
  end
end)
addEventHandler("onClientRender", getRootElement(), function()
  for i = 1, #furikWheelList do
    local obj = furikWheelList[i]
    if isElement(obj) and isElement(furikWheels[obj]) and isElement(furikManures[obj]) then
      local dim = 0
      local velo = 0
      local fx, fy, fz = getElementPosition(obj)
      if furikCarriedBy[obj] == localPlayer and not currentFarmId and 0 < (furikManureLevel[obj] or 0) then
        for k = 1, #trashPositions do
          if trashPositions[k] and getDistanceBetweenPoints2D(fx, fy, trashPositions[k][1], trashPositions[k][2]) <= 3 then
            local text = "A trágya ürítéséhez nyomj [F] gombot."
            for bx = -1, 1, 2 do
              for by = -1, 1, 2 do
                dxDrawText(text, bx, screenY * 0.8 + by, screenX + bx, screenY + by, tocolor(0, 0, 0, 255), milkingFontScale, milkingFont, "center", "center")
              end
            end
            dxDrawText(text, 0, screenY * 0.8, screenX, screenY, tocolor(255, 255, 255, 255), milkingFontScale, milkingFont, "center", "center")
            break
          end
        end
      end
      local p = furikManureLevel[obj] or 0
      if 0 < p and not furikCarriedBy[obj] then
        local x, y = getElementPosition(furikManures[obj])
        local sx, sy = getScreenFromWorldPosition(x, y, fz + 0.5, 256)
        if sx and sy then
          dxDrawRectangle(sx - 70 - 2, sy - 6 - 2, 144, 16, tocolor(0, 0, 0, 150))
          dxDrawRectangle(sx - 70, sy - 6, 140, 12, tocolor(green[1], green[2], green[3], 150))
          dxDrawRectangle(sx - 70, sy - 6, 140 * p, 12, tocolor(green[1], green[2], green[3]))
        end
      end
    end
  end
end)
addEventHandler("onClientElementStreamIn", getRootElement(), function()
  if getElementModel(source) == 611 then
    refreshTrailerData(source)
  elseif getElementModel(source) == models.bucket then
    table.insert(bucketList, source)
  elseif getElementModel(source) == models.furik then
    processFurikWheels(source, true)
  end
end)
addEventHandler("onClientElementStreamOut", getRootElement(), function()
  if getElementModel(source) == 611 then
    refreshTrailerData(source)
  elseif getElementModel(source) == models.bucket then
    for i = 1, #bucketList do
      if bucketList[i] == source then
        table.remove(bucketList, i)
        break
      end
    end
  elseif getElementModel(source) == models.furik then
    processFurikWheels(source, false)
  end
end)
local trailerObjs = {}
local trailerShaders = {}
local trailerWoolShaders = {}
local trailerContents = {}
addEventHandler("onClientElementDestory", getRootElement(), function()
  if getElementModel(source) == 611 then
    refreshTrailerData(source)
    trailerContents[source] = nil
  elseif getElementModel(source) == models.bucket then
    for i = 1, #bucketList do
      if bucketList[i] == source then
        table.remove(bucketList, i)
        break
      end
    end
  elseif getElementModel(source) == models.furik then
    furikCarriedBy[source] = nil
    processFurikWheels(source, false)
  end
end)
addEventHandler("onClientResourceStart", getResourceRootElement(), function()
  engineLoadIFP("files/animations/furik_boritas.ifp", "furik_boritas")
  engineLoadIFP("files/animations/furik_idle.ifp", "furik_idle")
  engineLoadIFP("files/animations/furik_seta.ifp", "furik_seta")
  engineLoadIFP("files/animations/furik_start.ifp", "furik_start")
  engineLoadIFP("files/animations/vodor_idle.ifp", "vodor_idle")
  engineLoadIFP("files/animations/vodor_seta.ifp", "vodor_seta")
  engineLoadIFP("files/animations/vodor_start.ifp", "vodor_start")
  engineLoadIFP("files/animations/vodor_urites.ifp", "vodor_urites")
  engineLoadIFP("files/animations/vv_fel.ifp", "vv_fel")
  engineLoadIFP("files/animations/vv_idle.ifp", "vv_idle")
  engineLoadIFP("files/animations/vv_le.ifp", "vv_le")
  engineLoadIFP("files/animations/vv_seta.ifp", "vv_seta")
  engineLoadIFP("files/animations/vv_start.ifp", "vv_start")
  triggerServerEvent("getTrailerContents", localPlayer)
end)
function cleanColor(clean, a)
  if clean < whenTooDirty * 1.25 then
    local r, g, b = interpolateBetween(yellow[1], yellow[2], yellow[3], green[1], green[2], green[3], clean / (whenTooDirty * 1.25), "Linear")
    return tocolor(r, g, b, a)
  end
  return tocolor(green[1], green[2], green[3], a)
end
chickenFeeder = false
chickenDrinker = false
otherFeeder = false
otherDrinker = false
animalDoor = false
animalDoor2 = false
chickenFood = false
otherFood = false
local movementHandled = false
local otherFoods = {}
local otherFoodAnimation = false
local otherFoodFeederAnimation = false
local chickenFoods = {}
local chickenFoodAnimation = false
local chickenFoodFeederAnimation = false
local chickenWaterAnimation = false
local otherWaterAnimation = false
local bales = {}
local baleAnimation = false
local baleWas = 0
local otherFoodWas = 0
local chickenFoodWas = 0
addEvent("bucketMilkAnim", true)
addEventHandler("bucketMilkAnim", getRootElement(), function(farmId)
  if isElement(source) and farmId == currentFarmId then
    setPedAnimation(source, "vodor_urites", "idle_armed", -1, false, true, false, false, 250, false)
  end
end)
addEvent("furikUritAnim", true)
addEventHandler("furikUritAnim", getRootElement(), function(chickenWater)
  if isElement(source) then
    setPedAnimation(source, "furik_boritas", "idle_armed", -1, false, true, false, false, 250, false)
  end
end)
addEvent("syncChickenWater", true)
addEventHandler("syncChickenWater", getRootElement(), function(chickenWater, farmId)
  if farmId == currentFarmId then
    if isElement(source) then
      setPedAnimation(source, "vodor_urites", "idle_armed", -1, false, true, false, false, 250, false)
    end
    chickenWaterAnimation = {
      tonumber(currentAnimalFood.chickenWater),
      chickenWater,
      getTickCount()
    }
  end
end)
addEvent("syncOtherWater", true)
addEventHandler("syncOtherWater", getRootElement(), function(otherWater, farmId)
  if farmId == currentFarmId then
    if isElement(source) then
      setPedAnimation(source, "vodor_urites", "idle_armed", -1, false, true, false, false, 250, false)
    end
    otherWaterAnimation = {
      tonumber(currentAnimalFood.otherWater),
      otherWater,
      getTickCount()
    }
  end
end)
addEvent("syncOtherFoodAmount", true)
addEventHandler("syncOtherFoodAmount", getRootElement(), function(otherFood, farmId)
  if farmId == currentFarmId then
    if isElement(source) and otherFood > otherFoodWas then
      setPedAnimation(source, "vodor_urites", "idle_armed", -1, false, true, false, false, 250, false)
    end
    otherFoodAnimation = {
      otherFoodWas,
      otherFood,
      getTickCount()
    }
  end
end)
addEvent("syncOtherFoodFeeder", true)
addEventHandler("syncOtherFoodFeeder", getRootElement(), function(otherFood, farmId)
  if farmId == currentFarmId then
    if isElement(source) then
      setPedAnimation(source, "vodor_urites", "idle_armed", -1, false, true, false, false, 250, false)
    end
    otherFoodFeederAnimation = {
      tonumber(currentAnimalFood.otherFood),
      otherFood,
      getTickCount()
    }
  end
end)
addEvent("syncChickenFoodAmount", true)
addEventHandler("syncChickenFoodAmount", getRootElement(), function(chickenFood, farmId)
  if farmId == currentFarmId then
    if isElement(source) and chickenFood > chickenFoodWas then
      setPedAnimation(source, "vodor_urites", "idle_armed", -1, false, true, false, false, 250, false)
    end
    chickenFoodAnimation = {
      chickenFoodWas,
      chickenFood,
      getTickCount()
    }
  end
end)
addEvent("syncChickenFoodFeeder", true)
addEventHandler("syncChickenFoodFeeder", getRootElement(), function(chickenFood, farmId)
  if farmId == currentFarmId then
    if isElement(source) then
      setPedAnimation(source, "vodor_urites", "idle_armed", -1, false, true, false, false, 250, false)
    end
    chickenFoodFeederAnimation = {
      tonumber(currentAnimalFood.chickenFood),
      chickenFood,
      getTickCount()
    }
  end
end)
addEvent("syncHayAmount", true)
addEventHandler("syncHayAmount", getRootElement(), function(hay, farmId)
  if farmId == currentFarmId then
    baleAnimation = {
      baleWas,
      hay,
      getTickCount()
    }
  end
end)
crateObjects = {}
eggObjects = {}
addEvent("updateEggCrates", true)
addEventHandler("updateEggCrates", getRootElement(), function(i, num, farmId)
  if farmId == currentFarmId then
    for j = 1, #eggObjects[i] do
      if isElement(eggObjects[i][j]) then
        destroyElement(eggObjects[i][j])
      end
      eggObjects[i][j] = nil
    end
    eggObjects[i] = {}
    for j = 1, math.min(num, #eggCratePositions[i]) do
      local rx, ry = rotateAround(rz, eggCratePositions[i][j][1], eggCratePositions[i][j][2], 0, 0)
      local obj = createObject(models.egg, x + rx, y + ry, z + eggCratePositions[i][j][3], eggCratePositions[i][j][4], eggCratePositions[i][j][5], rz + eggCratePositions[i][j][6])
      setElementDimension(obj, farmId)
      setElementCollisionsEnabled(obj, false)
      table.insert(eggObjects[i], obj)
    end
  end
end)
function deleteAnimalObjects()
  otherFoodAnimation = false
  otherFoodFeederAnimation = false
  chickenFoodAnimation = false
  chickenFoodFeederAnimation = false
  baleAnimation = false
  for i = 1, #bales do
    if isElement(bales[i]) then
      destroyElement(bales[i])
    end
    bales[i] = nil
  end
  for i = 1, #chickenFoods do
    if isElement(chickenFoods[i]) then
      destroyElement(chickenFoods[i])
    end
    chickenFoods[i] = nil
  end
  for i = 1, #otherFoods do
    if isElement(otherFoods[i]) then
      destroyElement(otherFoods[i])
    end
    otherFoods[i] = nil
  end
  bales = {}
  if isElement(myRT) then
    destroyElement(myRT)
  end
  myRT = nil
  myRT = false
  if isElement(myShader) then
    destroyElement(myShader)
  end
  myShader = nil
  myShader = false
  if isElement(milkCrate) then
    destroyElement(milkCrate)
  end
  milkCrate = nil
  milkCrate = false
  if isElement(chickenFood) then
    destroyElement(chickenFood)
  end
  chickenFood = nil
  chickenFood = false
  if isElement(otherFood) then
    destroyElement(otherFood)
  end
  otherFood = nil
  otherFood = false
  if isElement(chickenFeeder) then
    destroyElement(chickenFeeder)
  end
  chickenFeeder = nil
  chickenFeeder = false
  if isElement(chickenDrinker) then
    destroyElement(chickenDrinker)
  end
  chickenDrinker = nil
  chickenDrinker = false
  if isElement(otherFeeder) then
    destroyElement(otherFeeder)
  end
  otherFeeder = nil
  otherFeeder = false
  if isElement(animalDoor) then
    destroyElement(animalDoor)
  end
  animalDoor = nil
  animalDoor = false
  if isElement(animalDoor2) then
    destroyElement(animalDoor2)
  end
  animalDoor2 = nil
  animalDoor2 = false
  if isElement(otherDrinker) then
    destroyElement(otherDrinker)
  end
  otherDrinker = nil
  otherDrinker = false
  for j = 1, 4 do
    if eggObjects[j] then
      for i = 1, #eggObjects[j] do
        if isElement(eggObjects[j][i]) then
          destroyElement(eggObjects[j][i])
        end
        eggObjects[j][i] = nil
      end
    end
  end
  eggObjects = {}
  for i = 1, #crateObjects do
    if isElement(crateObjects[i]) then
      destroyElement(crateObjects[i])
    end
    crateObjects[i] = nil
  end
  crateObjects = {}
  for i = 1, #currentAnimals do
    if isElement(currentAnimals[i].element) then
      destroyElement(currentAnimals[i].element)
    end
    currentAnimals[i].element = nil
    currentAnimals[i].element = false
    if isElement(currentAnimals[i].effect) then
      destroyElement(currentAnimals[i].effect)
    end
    currentAnimals[i].effect = nil
    currentAnimals[i].effect = false
    if isElement(currentAnimals[i].effectSound) then
      destroyElement(currentAnimals[i].effectSound)
    end
    currentAnimals[i].effectSound = nil
    currentAnimals[i].effectSound = false
    if isElement(currentAnimals[i].animalSound) then
      destroyElement(currentAnimals[i].animalSound)
    end
    currentAnimals[i].animalSound = nil
    currentAnimals[i].animalSound = false
    if isElement(currentAnimals[i].shader) then
      destroyElement(currentAnimals[i].shader)
    end
    currentAnimals[i].shader = nil
    currentAnimals[i].shader = false
  end
  if movementHandled then
    removeEventHandler("onClientPreRender", getRootElement(), renderAnimalMovement)
    removeEventHandler("onClientRender", getRootElement(), renderFurik)
    movementHandled = false
  end
end
local drinkerPosX, drinkerPosY, drinkerPosX2, drinkerPosY2, chickenDrinkerX, chickenDrinkerY
function refreshBucketContent(bucket, content, animate, time)
  local currentModel = bucketContents[bucket] and bucketContents[bucket][1] or false
  local newModel = false
  if animate then
    if not content and bucketContents[bucket] then
      content = {
        bucketContents[bucket][1],
        0
      }
    end
    newModel = content and content[1] or false
    if content and (not bucketContents[content] or content[2] ~= bucketContents[bucket][2]) then
      bucketContents[bucket] = {
        content[1],
        content[2],
        bucketContents[bucket] and bucketContents[bucket][2] or 0,
        content[2],
        getTickCount(),
        time or 3000
      }
    else
      bucketContents[bucket] = content
    end
  else
    bucketContents[bucket] = content
    newModel = content and content[1] or false
  end
  if currentModel ~= newModel then
    if isElement(bucketContentObjects[bucket]) then
      destroyElement(bucketContentObjects[bucket])
    end
    bucketContentObjects[bucket] = nil
    if newModel then
      bucketContentObjects[bucket] = createObject(models["bucket_" .. newModel], 0, 0, 0)
      setElementCollisionsEnabled(bucketContentObjects[bucket], false)
    end
  end
end
local animalDoorRot = 0
local otherFoodPos = {}
local chickenFoodPos = {}
milkCrate = false
addEventHandler("onClientRender", getRootElement(), function()
  if myShader then
    dxDrawImage(0, 0, screenX, screenY, myShader)
  end
end, true, "low-9999999999999999")
addEventHandler("onClientPreRender", getRootElement(), function()
  if myShader then
    dxSetRenderTarget(myRT, true)
    dxSetRenderTarget()
  end
end, true, "high")
local milkaMode = false
function createAnimalObjects(farmId, x, y, z, rz, hay, other, chick, crates)
  deleteAnimalObjects()
  milkaMode = false
  myRT = dxCreateRenderTarget(screenX, screenY, true)
  myShader = dxCreateShader(postEdge)
  dxSetShaderValue(myShader, "sTex0", myRT)
  dxSetShaderValue(myShader, "sRes", screenX, screenY)
  milkingFont = seexports.sGui:getFont("12/Ubuntu-R.ttf")
  milkingFontScale = seexports.sGui:getFontScale("12/Ubuntu-R.ttf")
  baleWas = hay
  chickenFoodWas = chick
  otherFoodWas = other
  baleAnimation = false
  for i = 1, 4 do
    local rx, ry = rotateAround(rz, animalCratePositions[i][1], animalCratePositions[i][2], 0, 0)
    local obj = createObject(models.egg_crate, x + rx, y + ry, z + animalCratePositions[i][3], animalCratePositions[i][4], animalCratePositions[i][5], rz + animalCratePositions[i][6])
    setElementDimension(obj, farmId)
    table.insert(crateObjects, obj)
    eggObjects[i] = {}
    if crates[i] then
      for j = 1, math.min(crates[i], #eggCratePositions[i]) do
        local rx, ry = rotateAround(rz, eggCratePositions[i][j][1], eggCratePositions[i][j][2], 0, 0)
        local obj = createObject(models.egg, x + rx, y + ry, z + eggCratePositions[i][j][3], eggCratePositions[i][j][4], eggCratePositions[i][j][5], rz + eggCratePositions[i][j][6])
        setElementDimension(obj, farmId)
        setElementCollisionsEnabled(obj, false)
        table.insert(eggObjects[i], obj)
      end
    end
  end
  local rx, ry = rotateAround(rz, -1.9, -7.5, 0, 0)
  local rx2, ry2 = rotateAround(rz, -1.9, -7, 0, 0)
  for i = 1, foodBagNum do
    local r = math.random(-50, 50) / 10
    if i % 2 == 1 then
      chickenFoods[i] = createObject(models.chicken_feed_bag, x + rx2, y + ry2, z + 0.989145 + math.floor((i - 1) / 2) * 0.25, 0, 0, rz + 180 + r)
    else
      chickenFoods[i] = createObject(models.chicken_feed_bag, x + rx, y + ry, z + 0.989145 + math.floor((i - 1) / 2) * 0.25, 0, 0, rz + 180 + r)
    end
    setElementDimension(chickenFoods[i], farmId)
    setElementStreamable(chickenFoods[i], false)
    setElementDoubleSided(chickenFoods[i], true)
    local scale = math.min(1, math.max(0, chick - (i - 1)))
    if 1 < i then
      setElementCollisionsEnabled(chickenFoods[i], 0 < scale)
    end
    setElementAlpha(chickenFoods[i], scale <= 0 and 0 or 255)
    setObjectScale(chickenFoods[i], 1, 1, scale)
  end
  local rx, ry = rotateAround(rz, 1.9, -7.5, 0, 0)
  local rx2, ry2 = rotateAround(rz, 1.9, -7, 0, 0)
  for i = 1, foodBagNum do
    local r = math.random(-50, 50) / 10
    if i % 2 == 1 then
      otherFoods[i] = createObject(models.feed_bag, x + rx2, y + ry2, z + 0.989145 + math.floor((i - 1) / 2) * 0.25, 0, 0, rz + r)
    else
      otherFoods[i] = createObject(models.feed_bag, x + rx, y + ry, z + 0.989145 + math.floor((i - 1) / 2) * 0.25, 0, 0, rz + r)
    end
    setElementDimension(otherFoods[i], farmId)
    setElementStreamable(otherFoods[i], false)
    setElementDoubleSided(otherFoods[i], true)
    local scale = math.min(1, math.max(0, other - (i - 1)))
    if 1 < i then
      setElementCollisionsEnabled(otherFoods[i], 0 < scale)
    end
    setElementAlpha(otherFoods[i], scale <= 0 and 0 or 255)
    setObjectScale(otherFoods[i], 1, 1, scale)
  end
  local rx, ry = rotateAround(rz, 2.03235, -6.05, 0, 0)
  local zp = 0
  for i = 1, baleNum do
    local r = math.random(-50, 50) / 10
    bales[i] = createObject(models.bale, x + rx, y + ry, z + 0.989145 + (i - 1) * 0.456451, 0, 0, rz + r)
    setElementDimension(bales[i], farmId)
    setElementStreamable(bales[i], false)
    setElementDoubleSided(bales[i], true)
    local scale = math.min(1, math.max(0, hay - (i - 1)))
    if 1 < i then
      setElementCollisionsEnabled(bales[i], 0 < scale)
    end
    setElementAlpha(bales[i], scale <= 0 and 0 or 255)
    setObjectScale(bales[i], 1, 1, scale)
  end
  local rx, ry = rotateAround(rz, -2.06153, -6.36815, 0, 0)
  milkCrate = createObject(models.milk_crate, x + rx, y + ry, z + 1.16073, 0, 0, rz - 5.58)
  setElementDimension(milkCrate, farmId)
  setElementStreamable(milkCrate, false)
  setElementDoubleSided(milkCrate, true)
  local rx, ry = rotateAround(rz, -2.24348, -5.06495, 0, 0)
  animalDoor2 = createObject(models.animaldoor, x + rx, y + ry, z + 1, 0, 0, rz)
  setElementDimension(animalDoor2, farmId)
  setElementStreamable(animalDoor2, false)
  setElementDoubleSided(animalDoor2, true)
  setElementCollisionsEnabled(animalDoor2, false)
  animalDoor = createObject(1502, x + rx, y + ry, z - 0.5, 0, 0, rz)
  setElementDimension(animalDoor, farmId)
  setElementStreamable(animalDoor, false)
  setElementDoubleSided(animalDoor, true)
  setElementAlpha(animalDoor, 0)
  animalDoorRot = rz
  attachElements(animalDoor2, animalDoor, 0, 0, 1.5)
  local rx, ry = rotateAround(rz, -0.721985, 4.73756, 0, 0)
  chickenFeeder = createObject(models.csirke_eteto, x + rx, y + ry, z + 0.9, 0, 0, rz)
  setElementDimension(chickenFeeder, farmId)
  setElementStreamable(chickenFeeder, false)
  setElementDoubleSided(chickenFeeder, true)
  local progress = currentAnimalFood.chickenFood / 255
  chickenFood = createObject(models.csirketap, x + rx, y + ry, z + 0.9 + 0.035 * (1 - progress), 0, 0, rz)
  setElementDimension(chickenFood, farmId)
  setElementStreamable(chickenFood, false)
  setElementDoubleSided(chickenFood, true)
  setElementCollisionsEnabled(chickenFood, false)
  chickenFoodPos = {
    x + rx,
    y + ry,
    z + 0.9
  }
  setObjectScale(chickenFood, 1, math.max(0, math.min(1, (progress - 0.15) * 1.15)), progress)
  local rx, ry = rotateAround(rz, 1.27096, 4.18636, 0, 0)
  chickenDrinker = createObject(models.csirke_itato, x + rx, y + ry, z + 0.925, 0, 0, rz)
  setElementDimension(chickenDrinker, farmId)
  setElementStreamable(chickenDrinker, false)
  setElementDoubleSided(chickenDrinker, true)
  local rx2, ry2 = rotateAround(rz - 55, 0.5, 0, 0, 0)
  chickenDrinkerX, chickenDrinkerY = rx2, ry2
  local rx, ry = rotateAround(rz, 2.18247, 1.66311, 0, 0)
  otherDrinker = createObject(models.valyu, x + rx, y + ry, z + 0.9, 0, 0, rz + 90)
  setElementDimension(otherDrinker, farmId)
  setElementStreamable(otherDrinker, false)
  setElementDoubleSided(otherDrinker, true)
  local rx2, ry2 = rotateAround(rz, 0, -1.125, 0, 0)
  drinkerPosX, drinkerPosY = x + rx + rx2, y + ry + ry2
  drinkerPosX2, drinkerPosY2 = x + rx - rx2, y + ry - ry2
  local rx, ry = rotateAround(rz, 2.18247, -1.72312, 0, 0)
  otherFeeder = createObject(models.valyu, x + rx, y + ry, z + 0.9, 0, 0, rz + 90)
  setElementDimension(otherFeeder, farmId)
  setElementStreamable(otherFeeder, false)
  setElementDoubleSided(otherFeeder, true)
  local progress = currentAnimalFood.otherFood / 255
  otherFood = createObject(models.valyupellet, x + rx, y + ry, z + 0.9 + 0.035 * (1 - progress), 0, 0, rz)
  setElementDimension(otherFood, farmId)
  setElementStreamable(otherFood, false)
  setElementDoubleSided(otherFood, true)
  setElementCollisionsEnabled(otherFood, false)
  otherFoodPos = {
    x + rx,
    y + ry,
    z + 0.9
  }
  setObjectScale(otherFood, math.max(0, math.min(1, (progress - 0.15) * 1.15)), 1, progress)
end
local waterTexture, water2Texture
currentlyMilking = false
currentlyShearing = false
local lastMilking = 0
function toggleMilkaMode(state)
  milkaMode = state
end
local creaked = 0
local landEffects = {}
local landEffectPoses = {
  {1, 6},
  {3, 7},
  {3, 1}
}
local landEffectTick = {}
local landEffectVolume = {}
local landEffectSound = {}
local landEffectPos = {}
local sheepCutterMode = false
local sheepCutterObjects = {}
function toggleSheepCutter(state)
  sheepCutterMode = state
  if state then
    seexports.sChat:localActionC(localPlayer, "elővesz egy juhnyírógépet.")
  else
    seexports.sChat:localActionC(localPlayer, "elrak egy juhnyírógépet.")
  end
  setElementData(localPlayer, "sheepCutter", state)
end
local cutterQ = {
  0.642387,
  -0.490951,
  0.499908,
  0.310481
}
local cutterModel = false
function sheepCutterLoaded()
  cutterModel = seexports.sModloader:getModelId("farm:v4_sheep_shearer")
end
function processSheepCutter(client)
  if cutterModel then
    if isElement(sheepCutterObjects[client]) then
      destroyElement(sheepCutterObjects[client])
    end
    sheepCutterObjects[client] = nil
    if isElementStreamedIn(client) and getElementData(client, "sheepCutter") then
      sheepCutterObjects[client] = createObject(cutterModel, 0, 0, 0, 0, 0, 0)
      setElementDimension(sheepCutterObjects[client], getElementDimension(client))
      setElementInterior(sheepCutterObjects[client], getElementInterior(client))
      seexports.sPattach:attach(sheepCutterObjects[client], client, 25, 0.028135, 0.032109, 0.045873, 0, 0, 0)
      seexports.sPattach:setRotationQuaternion(sheepCutterObjects[client], cutterQ)
    end
  end
end
addEventHandler("onClientPlayerDataChange", getRootElement(), function(dataName, oldValue, newValue)
  if dataName == "sheepCutter" then
    processSheepCutter(source)
  end
end)
addEventHandler("onClientElementStreamIn", getRootElement(), function()
  processSheepCutter(source)
end)
addEventHandler("onClientElementStreamOut", getRootElement(), function()
  processSheepCutter(source)
end)
addEventHandler("onClientPlayerQuit", getRootElement(), function()
  processSheepCutter(source)
end)
local milkingTmp = false
local shearingTmp = false
function renderAnimalMovement(delta)
  if movementHandled then
    if animalDoorRot then
      local rx, ry, rz = getElementRotation(animalDoor2)
      local a = animalDoorRot - rz
      a = math.abs((a + 180) % 360 - 180)
      if 10 < a then
        local delta = getTickCount() - creaked
        if 1000 < delta then
          local x, y, z = getElementPosition(animalDoor)
          local sound = playSound3D("files/sound/creak" .. math.random(1, 3) .. ".mp3", x, y, z)
          setElementDimension(sound, currentFarmId)
          creaked = getTickCount()
          animalDoorRot = rz
        else
          animalDoorRot = rz
        end
      end
    end
    if chickenFoodFeederAnimation then
      local progress = (getTickCount() - chickenFoodFeederAnimation[3]) / 6500
      if 1 < progress then
        progress = 1
        currentAnimalFood.chickenFood = chickenFoodFeederAnimation[2]
        chickenFoodFeederAnimation = false
      else
        currentAnimalFood.chickenFood = chickenFoodFeederAnimation[1] + (chickenFoodFeederAnimation[2] - chickenFoodFeederAnimation[1]) * progress
      end
      progress = currentAnimalFood.chickenFood / 255
      setElementPosition(chickenFood, chickenFoodPos[1], chickenFoodPos[2], chickenFoodPos[3] + 0.035 * (1 - progress))
      setObjectScale(chickenFood, 1, math.max(0, math.min(1, (progress - 0.15) * 1.15)), progress)
    end
    if chickenFoodAnimation then
      local progress = (getTickCount() - chickenFoodAnimation[3]) / 3000
      if 1 < progress then
        progress = 1
        chickenFoodWas = chickenFoodAnimation[2]
        for i = 1, foodBagNum do
          local scale = math.min(1, math.max(0, chickenFoodWas - (i - 1)))
          setElementAlpha(chickenFoods[i], scale <= 0 and 0 or 255)
          if 1 < i then
            setElementCollisionsEnabled(chickenFoods[i], 0 < scale)
          end
          setObjectScale(chickenFoods[i], 1, 1, scale)
        end
        chickenFoodAnimation = false
      else
        chickenFoodWas = chickenFoodAnimation[1] + (chickenFoodAnimation[2] - chickenFoodAnimation[1]) * progress
        for i = 1, foodBagNum do
          local scale = math.min(1, math.max(0, chickenFoodWas - (i - 1)))
          setElementAlpha(chickenFoods[i], scale <= 0 and 0 or 255)
          if 1 < i then
            setElementCollisionsEnabled(chickenFoods[i], 0 < scale)
          end
          setObjectScale(chickenFoods[i], 1, 1, scale)
        end
      end
    end
    if otherFoodFeederAnimation then
      local progress = (getTickCount() - otherFoodFeederAnimation[3]) / 6500
      if 1 < progress then
        progress = 1
        currentAnimalFood.otherFood = otherFoodFeederAnimation[2]
        otherFoodFeederAnimation = false
      else
        currentAnimalFood.otherFood = otherFoodFeederAnimation[1] + (otherFoodFeederAnimation[2] - otherFoodFeederAnimation[1]) * progress
      end
      progress = currentAnimalFood.otherFood / 255
      setElementPosition(otherFood, otherFoodPos[1], otherFoodPos[2], otherFoodPos[3] + 0.035 * (1 - progress))
      setObjectScale(otherFood, math.max(0, math.min(1, (progress - 0.15) * 1.15)), 1, progress)
    end
    if otherFoodAnimation then
      local progress = (getTickCount() - otherFoodAnimation[3]) / 3000
      if 1 < progress then
        progress = 1
        otherFoodWas = otherFoodAnimation[2]
        for i = 1, foodBagNum do
          local scale = math.min(1, math.max(0, otherFoodWas - (i - 1)))
          setElementAlpha(otherFoods[i], scale <= 0 and 0 or 255)
          if 1 < i then
            setElementCollisionsEnabled(otherFoods[i], 0 < scale)
          end
          setObjectScale(otherFoods[i], 1, 1, scale)
        end
        otherFoodAnimation = false
      else
        otherFoodWas = otherFoodAnimation[1] + (otherFoodAnimation[2] - otherFoodAnimation[1]) * progress
        for i = 1, foodBagNum do
          local scale = math.min(1, math.max(0, otherFoodWas - (i - 1)))
          setElementAlpha(otherFoods[i], scale <= 0 and 0 or 255)
          if 1 < i then
            setElementCollisionsEnabled(otherFoods[i], 0 < scale)
          end
          setObjectScale(otherFoods[i], 1, 1, scale)
        end
      end
    end
    if baleAnimation then
      local progress = (getTickCount() - baleAnimation[3]) / 3000
      if 1 < progress then
        progress = 1
        baleWas = baleAnimation[2]
        for i = 1, baleNum do
          local scale = math.min(1, math.max(0, baleWas - (i - 1)))
          setElementAlpha(bales[i], scale <= 0 and 0 or 255)
          if 1 < i then
            setElementCollisionsEnabled(bales[i], 0 < scale)
          end
          setObjectScale(bales[i], 1, 1, scale)
        end
        baleAnimation = false
      else
        baleWas = baleAnimation[1] + (baleAnimation[2] - baleAnimation[1]) * progress
        for i = 1, baleNum do
          local scale = math.min(1, math.max(0, baleWas - (i - 1)))
          setElementAlpha(bales[i], scale <= 0 and 0 or 255)
          if 1 < i then
            setElementCollisionsEnabled(bales[i], 0 < scale)
          end
          setObjectScale(bales[i], 1, 1, scale)
        end
      end
    end
    if chickenWaterAnimation then
      local progress = (getTickCount() - chickenWaterAnimation[3]) / 5500
      if 1 < progress then
        progress = 1
        currentAnimalFood.chickenWater = chickenWaterAnimation[2]
        chickenWaterAnimation = false
      else
        currentAnimalFood.chickenWater = chickenWaterAnimation[1] + (chickenWaterAnimation[2] - chickenWaterAnimation[1]) * progress
      end
    end
    if otherWaterAnimation then
      local progress = (getTickCount() - otherWaterAnimation[3]) / 5500
      if 1 < progress then
        progress = 1
        currentAnimalFood.otherWater = otherWaterAnimation[2]
        otherWaterAnimation = false
      else
        currentAnimalFood.otherWater = otherWaterAnimation[1] + (otherWaterAnimation[2] - otherWaterAnimation[1]) * progress
      end
    end
    local progress = currentAnimalFood.chickenWater / 255
    local size = 0.375 + 0.2 * progress
    local x, y, z = getElementPosition(chickenDrinker)
    seelangStaticImageUsed[0] = true
    if seelangStaticImageToc[0] then
      processSeelangStaticImage[0]()
    end
    dxDrawMaterialLine3D(x - chickenDrinkerX * size, y - chickenDrinkerY * size, z - 0.05 + 0.17 * progress, x + chickenDrinkerX * size, y + chickenDrinkerY * size, z - 0.05 + 0.17 * progress, seelangStaticImage[0], 1 * size, tocolor(255, 255, 255, 150), x, y, z + 5)
    local x, y, z = getElementPosition(otherDrinker)
    local progress = currentAnimalFood.otherWater / 255
    z = z + 0.035 + 0.14 * progress
    local w = 0.15 + progress * 0.85
    seelangStaticImageUsed[1] = true
    if seelangStaticImageToc[1] then
      processSeelangStaticImage[1]()
    end
    dxDrawMaterialSectionLine3D(drinkerPosX, drinkerPosY, z, drinkerPosX2, drinkerPosY2, z, 0, 0, 256 * w, 1643.52, seelangStaticImage[1], 0.35 * w, tocolor(255, 255, 255, 150), x, y, z + 5)
    local olx, oly = lx, ly
    local lx, ly = olx - farmSizeDetails[currentSize].size[1] * blockSize / 2, oly - farmSizeDetails[currentSize].size[2] * blockSize / 2
    local px, py, pz = getElementPosition(localPlayer)
    local milkingDist = 1.5
    milkingTmp = false
    local shearingDist = 1.5
    shearingTmp = false
    for i = 1, #landEffects do
      if getTickCount() - landEffectTick[i] > 0 then
        landEffectTick[i] = getTickCount() + math.random(12000, 30000)
        if isElement(landEffectSound[i]) then
          destroyElement(landEffectSound[i])
        end
        landEffectSound[i] = playSound3D("files/sound/fly.mp3", landEffectPos[i][1], landEffectPos[i][2], landEffectPos[i][3])
        setElementDimension(landEffectSound[i], currentFarmId)
        setSoundVolume(landEffectSound[i], landEffectVolume[i])
      end
    end
    for i = 1, #currentAnimals do
      if isElement(currentAnimals[i].element) then
        local x, y, z = getElementPosition(currentAnimals[i].element)
        if milkingPerms and milkaMode then
          if currentAnimals[i].type == "cow" and 1 < currentAnimals[i].variation then
            local dist = getDistanceBetweenPoints3D(x, y, z, px, py, pz)
            if milkingDist > dist then
              milkingTmp = i
              milkingDist = dist
            end
          end
        elseif milkingPerms and playerBucket[localPlayer] and (not playerBucket[localPlayer][2] or 0 >= playerBucket[localPlayer][2][2] or playerBucket[localPlayer][2][1] == "milk") and 1 > (playerBucket[localPlayer][2] and playerBucket[localPlayer][2][2] or 0) then
          if not currentlyMilking and animalTypes[currentAnimals[i].type].milking then
            local dist = getDistanceBetweenPoints3D(x, y, z, px, py, pz)
            if milkingDist > dist then
              milkingTmp = i
              milkingDist = dist
            end
          end
        elseif milkingPerms and sheepCutterMode and not currentlyShearing and animalTypes[currentAnimals[i].type].shearing then
          local dist = getDistanceBetweenPoints3D(x, y, z, px, py, pz)
          if shearingDist > dist then
            shearingTmp = i
            shearingDist = dist
          end
        end
        if 0 < getTickCount() - currentAnimals[i].animalSoundTick then
          currentAnimals[i].animalSoundTick = getTickCount() + math.random(5000, 25000)
          local id = math.random(1, animalSoundNums[currentAnimals[i].type])
          currentAnimals[i].animalSound = playSound3D("files/sound/" .. currentAnimals[i].type .. id .. ".mp3", x, y, z)
          setElementDimension(currentAnimals[i].animalSound, currentFarmId)
          local spd = 1 + 0.2 * (1 - currentAnimals[i].growth)
          setSoundSpeed(currentAnimals[i].animalSound, spd)
          attachElements(currentAnimals[i].animalSound, currentAnimals[i].element)
        end
        if isElement(currentAnimals[i].effect) then
          setElementPosition(currentAnimals[i].effect, x, y, z)
          if 0 < (getTickCount() - currentAnimals[i].effectSoundTick or 0) then
            currentAnimals[i].effectSoundTick = getTickCount() + math.random(12000, 60000)
            if isElement(currentAnimals[i].effectSound) then
              destroyElement(currentAnimals[i].effectSound)
            end
            currentAnimals[i].effectSound = playSound3D("files/sound/fly.mp3", x, y, z)
            setElementDimension(currentAnimals[i].effectSound, currentFarmId)
            setSoundVolume(currentAnimals[i].effectSound, currentAnimals[i].effectSoundVolume)
            attachElements(currentAnimals[i].effectSound, currentAnimals[i].element)
          end
        end
        if currentlyMilking ~= i and currentlyShearing ~= i then
          local x, y = 1, 1
          local speed = 1
          if animalPositions[i] then
            x = animalPositions[i][1]
            y = animalPositions[i][2]
            speed = animalPositions[i][3]
          end
          if 0 >= animalPositions[i][5] then
            local x, y = rotateAround(farmInteriorRot, x * blockSize, y * blockSize, 0, 0)
            x, y = farmInteriorX + x, farmInteriorY + y
            local px, py = getElementPosition(currentAnimals[i].element)
            local dist = getDistanceBetweenPoints2D(x, y, px, py)
            if getTickCount() - movementHandled > 3000 then
              setPedAnalogControlState(currentAnimals[i].element, "forwards", 0.5 < dist and speed or 0)
              if 0.5 < dist then
                setPedControlState(currentAnimals[i].element, "walk", true)
                setPedCameraRotation(currentAnimals[i].element, math.deg(math.atan2(x - px, y - py)))
              end
            else
              setPedAnalogControlState(currentAnimals[i].element, "forwards", 0)
            end
          else
            animalPositions[i][5] = animalPositions[i][5] - delta
          end
        else
          setPedAnalogControlState(currentAnimals[i].element, "forwards", 0)
        end
      end
    end
  end
end
function renderFurik()
  local tmp = false
  if animalHoverBox then
    local cx, cy, wx, wy, wz = getCursorPosition()
    if cx then
      cx = cx * screenX
      cy = cy * screenY
      local px, py = seexports.sGui:getGuiPosition(animalPanel)
      for i = 1, #animalHoverBox do
        local x, y = px + animalHoverBox[i][2], py + animalHoverBox[i][3]
        local sx, sy = animalHoverBox[i][4], animalHoverBox[i][5]
        if cx >= x and cy >= y and cx <= x + sx and cy <= y + sy then
          tmp = animalHoverBox[i][1]
        end
      end
    end
  elseif localFurik and (furikManureLevel[localFurik] or 0) <= 0 then
    local fx, fy = getElementPosition(localFurik)
    if 1 >= getDistanceBetweenPoints2D(fx, fy, furikBasePoses[currentFarmId][1], furikBasePoses[currentFarmId][2]) then
      local text = "Visszateheted a talicskát az [F] gomb használatával."
      for bx = -1, 1, 2 do
        for by = -1, 1, 2 do
          dxDrawText(text, bx, screenY * 0.8 + by, screenX + bx, screenY + by, tocolor(0, 0, 0, 255), milkingFontScale, milkingFont, "center", "center")
        end
      end
      dxDrawText(text, 0, screenY * 0.8, screenX, screenY, tocolor(255, 255, 255, 255), milkingFontScale, milkingFont, "center", "center")
    end
  elseif shearingTmp then
    local text = "A nyírás megkezdéséhez nyomj [E] gombot."
    if 1 > (currentAnimals[shearingTmp].wool or 0) then
      text = "Ezt a bárányt még nem tudod megnyírni."
    end
    for bx = -1, 1, 2 do
      for by = -1, 1, 2 do
        dxDrawText(text, bx, screenY * 0.8 + by, screenX + bx, screenY + by, tocolor(0, 0, 0, 255), milkingFontScale, milkingFont, "center", "center")
      end
    end
    tmp = shearingTmp
    dxDrawText(text, 0, screenY * 0.8, screenX, screenY, tocolor(255, 255, 255, 255), milkingFontScale, milkingFont, "center", "center")
    if getKeyState("e") and getTickCount() - lastMilking > 3000 then
      lastMilking = getTickCount()
      currentlyShearing = shearingTmp
      triggerServerEvent("startShearing", getRootElement(), currentFarmId, shearingTmp)
    end
  elseif milkingTmp then
    local text = "A fejés megkezdéséhez nyomj [E] gombot."
    if 1 > (currentAnimals[milkingTmp].milk or 0) then
      text = "Ezt a tehenet még nem tudod megfejni."
    end
    if milkaMode then
      text = "Etetéshez nyomj [E] gombot."
    end
    for bx = -1, 1, 2 do
      for by = -1, 1, 2 do
        dxDrawText(text, bx, screenY * 0.8 + by, screenX + bx, screenY + by, tocolor(0, 0, 0, 255), milkingFontScale, milkingFont, "center", "center")
      end
    end
    tmp = milkingTmp
    dxDrawText(text, 0, screenY * 0.8, screenX, screenY, tocolor(255, 255, 255, 255), milkingFontScale, milkingFont, "center", "center")
    if getKeyState("e") and getTickCount() - lastMilking > 3000 then
      lastMilking = getTickCount()
      if milkaMode then
        milkaMode = false
        triggerServerEvent("makeMilkaCow", getRootElement(), currentFarmId, milkingTmp)
      else
        currentlyMilking = milkingTmp
        triggerServerEvent("startMilking", getRootElement(), currentFarmId, milkingTmp)
      end
    end
  end
  refreshWallShader(tmp)
end
addEvent("updateCowMilk", true)
addEventHandler("updateCowMilk", getRootElement(), function(cowId, milk, farmId)
  if farmId == currentFarmId then
    currentAnimals[cowId].milk = milk
  end
end)
local pjPasswords = {
  ["chicken/1"] = "YtppfNwWCV",
  ["chicken/2"] = "WW3DHh5rde",
  ["chicken/3"] = "LNamxhBRpy",
  ["chicken/4"] = "WbgShjenTA",
  ["chicken/5"] = "AbIoAtULMX",
  ["chicken/6"] = "ntdtf9QD5B",
  ["cow/1"] = "tnSezJTg8a",
  ["cow/2"] = "9UX3IRxGU4",
  ["cow/3"] = "wccaMePK6E",
  ["cow/4"] = "us0kw7is8z",
  ["cow/5"] = "Xm8JAZfK1k",
  ["goat/1"] = "COWLZTYlkm",
  ["goat/2"] = "lmnLwrBjwC",
  ["goat/3"] = "ipYZ7qfWYF",
  ["pig/1"] = "Gy3GXeDDYV",
  ["pig/2"] = "7StZuKiJrc",
  ["pig/3"] = "U2FI8IIfRv",
  ["pig/4"] = "9tpg2zE46L"
}
function teaDecodeBinary(data, key)
  return base64Decode(teaDecode(data, key))
end
function loadProtectedTexture(name, compression)
  if pjPasswords[name] then
    if fileExists("files/" .. name .. ".see") then
      local hFile = fileOpen("files/" .. name .. ".see", true)
      if hFile then
        local buffer = ""
        collectgarbage("collect")
        buffer = fileRead(hFile, fileGetSize(hFile))
        fileClose(hFile)
        collectgarbage("collect")
        buffer = teaDecodeBinary(buffer, pjPasswords[name])
        collectgarbage("collect")
        local text = dxCreateTexture(buffer, compression)
        buffer = nil
        collectgarbage("collect")
        return text
      else
      end
    else
    end
    collectgarbage("collect")
    return false
  else
    return dxCreateTexture("files/" .. name .. ".dds", compression)
  end
end
local textures = {
  pig = {
    loadProtectedTexture("pig/1", "dxt1"),
    loadProtectedTexture("pig/2", "dxt1"),
    loadProtectedTexture("pig/3", "dxt1"),
    loadProtectedTexture("pig/4", "dxt1")
  },
  goat = {
    loadProtectedTexture("goat/1", "dxt1"),
    loadProtectedTexture("goat/2", "dxt1"),
    loadProtectedTexture("goat/3", "dxt1")
  },
  chicken = {
    loadProtectedTexture("chicken/1", "dxt1"),
    loadProtectedTexture("chicken/2", "dxt1"),
    loadProtectedTexture("chicken/3", "dxt1"),
    loadProtectedTexture("chicken/4", "dxt1"),
    loadProtectedTexture("chicken/5", "dxt1"),
    loadProtectedTexture("chicken/6", "dxt1")
  },
  cow = {
    loadProtectedTexture("cow/1", "dxt1"),
    loadProtectedTexture("cow/2", "dxt1"),
    loadProtectedTexture("cow/3", "dxt1"),
    loadProtectedTexture("cow/4", "dxt1"),
    loadProtectedTexture("cow/5", "dxt1")
  },
  sheep = {
    dxCreateTexture("files/sheep/1.dds", "dxt1"),
    dxCreateTexture("files/sheep/2.dds", "dxt1"),
    dxCreateTexture("files/sheep/3.dds", "dxt1"),
    dxCreateTexture("files/sheep/4.dds", "dxt1"),
    dxCreateTexture("files/sheep/1w.dds", "dxt1"),
    dxCreateTexture("files/sheep/2w.dds", "dxt1"),
    dxCreateTexture("files/sheep/3w.dds", "dxt1"),
    dxCreateTexture("files/sheep/4w.dds", "dxt1")
  }
}
local sheepShader = [[
	#include "files/mta-helper.fx"

	struct VSInput
	{
		float3 Position : POSITION0;
		float3 Normal : NORMAL0;
		float4 Diffuse : COLOR0;
		float2 TexCoord : TEXCOORD0;
	};

	struct PSInput
	{
		float4 Position : POSITION0;
		float4 Diffuse : COLOR0;
		float2 TexCoord : TEXCOORD0;
	};

	float size = 1;
	float morph = 0;
	float wool = 0;

	PSInput VertexShaderFunction(VSInput VS)
	{
		PSInput PS = (PSInput)0;

		// Do morph effect by adding surface normal to the vertex position
		VS.Position += VS.Normal * morph;
		VS.Position -= VS.Normal * (1-wool) * 0.04;
		VS.Position = VS.Position * size; 
		
		VS.Position.z += size-1;

		// Calculate screen pos of vertex
		PS.Position = MTACalcScreenPosition ( VS.Position );

		// Pass through tex coords
		PS.TexCoord = VS.TexCoord;
]]
local sheepShaderTrailer = [[
	
	PS.Diffuse = 0.45;
]]
local sheepShaderNormal = "\tPS.Diffuse = MTACalcGTABuildingDiffuse( VS.Diffuse );\n"
local sheepShader2 = [[
		//PS.Diffuse.r *= 0;

		return PS;
	}

	texture woolText;
	sampler Sampler0 = sampler_state
	{
		Texture = (woolText);
	};

	texture woolNoiseTexture;

	sampler SamplerNoise= sampler_state
	{
		Texture = (woolNoiseTexture);
	};

	texture skinTexture;

	sampler SamplerSkin = sampler_state
	{
		Texture = (skinTexture);
	};


	float4 PixelShaderFunction(PSInput PS) : COLOR0
	{
		float4 texel = tex2D(Sampler0, PS.TexCoord);
		float noise = tex2D(SamplerNoise, PS.TexCoord).r;
		float4 skin = tex2D(SamplerSkin, PS.TexCoord);

		if(wool < 1)
			return lerp(texel, skin, noise*pow(1-wool, 2.25)) * PS.Diffuse;
		else
			return texel * PS.Diffuse;
	}


	//texture gTexture;

	technique tec0
	{
		pass P0
		{
			VertexShader = compile vs_2_0 VertexShaderFunction();
			PixelShader = compile ps_2_0 PixelShaderFunction();
			//Texture[0] = gTexture;
		}
	}

	technique fallback
	{
		pass P0
		{
		}
	}

]]
local sheepSkin = dxCreateTexture("files/sheepskin.dds", "dxt1")
local sheepSkin2 = dxCreateTexture("files/sheepskin2.dds", "dxt1")
addEvent("updateSheepWool", true)
addEventHandler("updateSheepWool", getRootElement(), function(i, wool, farmId)
  if farmId == currentFarmId then
    if (wool or 1) < (currentAnimals[i].wool or 1) and isElement(currentAnimals[i].element) then
      local x, y, z = getElementPosition(currentAnimals[i].element)
      local sound = playSound3D("files/sound/farmrazor.mp3", x, y, z)
      setElementDimension(sound, currentFarmId)
    end
    currentAnimals[i].wool = wool
    if isElement(currentAnimals[i].sheepShader) then
      dxSetShaderValue(currentAnimals[i].sheepShader, "wool", currentAnimals[i].wool or 1)
    else
      currentAnimals[i].sheepShader = dxCreateShader(sheepShader .. sheepShaderNormal .. sheepShader2, 0, 0, false, "ped")
      engineRemoveShaderFromWorldTexture(currentAnimals[i].shader, "v4_sheep_wool", currentAnimals[i].element)
      engineApplyShaderToWorldTexture(currentAnimals[i].sheepShader, "v4_sheep_wool", currentAnimals[i].element)
      dxSetShaderValue(currentAnimals[i].sheepShader, "woolNoiseTexture", sheepSkin)
      dxSetShaderValue(currentAnimals[i].sheepShader, "skinTexture", sheepSkin2)
      dxSetShaderValue(currentAnimals[i].sheepShader, "woolText", textures[currentAnimals[i].type][currentAnimals[i].variation + #textures[currentAnimals[i].type] / 2])
      dxSetShaderValue(currentAnimals[i].sheepShader, "size", currentAnimals[i].shaderSize)
      dxSetShaderValue(currentAnimals[i].sheepShader, "morph", currentAnimals[i].shaderMorph)
      dxSetShaderValue(currentAnimals[i].sheepShader, "wool", currentAnimals[i].wool or 1)
    end
  end
end)
addEvent("updateFarmAnimalPositions", true)
addEventHandler("updateFarmAnimalPositions", getRootElement(), function(positions, farmId)
  if farmId == currentFarmId then
    animalPositions = positions
  end
end)
function refreshDirtEffects()
  local dirt = 0
  local c = 0
  for x = 1, farmSizeDetails[currentSize].size[1] do
    for y = 1, farmSizeDetails[currentSize].size[2] do
      local d = landData[x][y].dirt or 0
      dirt = dirt + d
      c = c + 1
    end
  end
  dirt = dirt / c / 255
  if 0.5 < dirt then
    for i = 1, #landEffectPoses do
      if not isElement(landEffects[i]) then
        local x, y = landEffectPoses[i][1], landEffectPoses[i][2]
        local cx, cy = rotateAround(farmInteriorRot, (x + 0.5) * blockSize + lx - farmSizeDetails[currentSize].size[1] * blockSize / 2, (y + 0.5) * blockSize + ly - farmSizeDetails[currentSize].size[2] * blockSize / 2, lx, ly)
        landEffectPos[i] = {
          cx,
          cy,
          lz
        }
        landEffects[i] = createEffect("insects", cx, cy, lz)
        setEffectDensity(landEffects[i], math.min(2, math.max(0, (dirt - 0.5) / 0.5 * 2 * math.random(50, 110) / 100)))
        landEffectVolume[i] = 0.1 + (dirt - 0.5) / 0.5 * 0.4 * math.random(50, 110) / 100
        landEffectTick[i] = getTickCount() + math.random(0, 10000)
      end
    end
  else
    for i = 1, #landEffects do
      if isElement(landEffects[i]) then
        destroyElement(landEffects[i])
      end
      landEffects[i] = nil
    end
    landEffects = {}
  end
  for i = 1, #currentAnimals do
    if isElement(currentAnimals[i].effect) then
      if dirt <= 0.5 then
        if isElement(currentAnimals[i].effect) then
          destroyElement(currentAnimals[i].effect)
        end
        currentAnimals[i].effect = nil
        currentAnimals[i].effect = false
      end
    elseif 0.5 < dirt then
      currentAnimals[i].effect = createEffect("insects", 0, 0, 0)
    end
    if 0.5 < dirt then
      setEffectDensity(currentAnimals[i].effect, math.min(2, math.max(0, (dirt - 0.5) / 0.5 * 2 * math.random(50, 110) / 100)))
      currentAnimals[i].effectSoundVolume = 0.1 + (dirt - 0.5) / 0.5 * 0.4 * math.random(50, 110) / 100
    end
  end
end
local markedAnimals = {}
function renderMarkedAnimals()
  for animal in pairs(markedAnimals) do
    if isElement(animal) then
      local x, y, z = getElementPosition(animal)
      local p = (getTickCount() - 75) / 1500 % 2
      if 1 < p then
        p = 1 - (p - 1)
      end
      local z = interpolateBetween(z - 0.125, 0, 0, z + 0.125, 0, 0, p, "InOutQuad")
      local sx, sy = getScreenFromWorldPosition(x, y, z, 60)
      if sx and sy then
        local sizeX = 60
        local sizeY = 48
        seelangStaticImageUsed[2] = true
        if seelangStaticImageToc[2] then
          processSeelangStaticImage[2]()
        end
        dxDrawImage(sx - sizeX / 2, sy - sizeY / 2, sizeX, sizeY, seelangStaticImage[2], 0, 0, 0, tocolor(green[1], green[2], green[3]))
      end
    end
  end
end
local currentWallShader = false
function refreshWallShader(animal)
  if currentWallShader ~= animal then
    currentWallShader = animal
    for i = 1, #currentAnimals do
      wallShaderState(i, i == currentWallShader)
    end
  end
end
function wallShaderState(i, state)
  if state then
    if isElement(currentAnimals[i].element) then
      markedAnimals[currentAnimals[i].element] = true
      seelangCondHandl0(true)
    end
  else
    markedAnimals[currentAnimals[i].element] = nil
    local count = 0
    for animal in pairs(markedAnimals) do
      count = count + 1
    end
    seelangCondHandl0(0 < count)
  end
end
addEvent("refreshCowVariation", true)
addEventHandler("refreshCowVariation", getRootElement(), function(farmId, i, var)
  if farmId == currentFarmId and currentAnimals[i] then
    currentAnimals[i].variation = var
    dxSetShaderValue(currentAnimals[i].shader, "gTexture", textures[currentAnimals[i].type][currentAnimals[i].variation])
  end
end)
function createAnimalElements()
  if not movementHandled then
    movementHandled = getTickCount()
    addEventHandler("onClientPreRender", getRootElement(), renderAnimalMovement)
    addEventHandler("onClientRender", getRootElement(), renderFurik)
  end
  refreshDirtEffects()
  for i = 1, #currentAnimals do
    if not currentAnimals[i].forSale then
      local x, y = 2, 2
      if animalPositions[i] then
        x = animalPositions[i][1]
        y = animalPositions[i][2]
      end
      local x, y = rotateAround(farmInteriorRot, x * blockSize, y * blockSize, 0, 0)
      x, y = farmInteriorX + x, farmInteriorY + y
      currentAnimals[i].element = createPed(animalTypes[currentAnimals[i].type].skin, x, y, farmInteriorZ + 1.5, math.random(360))
      setElementDimension(currentAnimals[i].element, currentFarmId)
      setElementCollidableWith(currentAnimals[i].element, localPlayer, false)
      setElementData(currentAnimals[i].element, "invulnerable", true)
      currentAnimals[i].animalSoundTick = getTickCount() + math.random(5000)
      currentAnimals[i].shader = dxCreateShader(morphShader .. morphShaderNormal .. morphShader2, 0, 0, false, "ped")
      engineApplyShaderToWorldTexture(currentAnimals[i].shader, "*", currentAnimals[i].element)
      if currentAnimals[i].type == "sheep" and 1 > (currentAnimals[i].wool or 1) then
        currentAnimals[i].sheepShader = dxCreateShader(sheepShader .. sheepShaderNormal .. sheepShader2, 0, 0, false, "ped")
        engineRemoveShaderFromWorldTexture(currentAnimals[i].shader, "v4_sheep_wool", currentAnimals[i].element)
        engineApplyShaderToWorldTexture(currentAnimals[i].sheepShader, "v4_sheep_wool", currentAnimals[i].element)
        dxSetShaderValue(currentAnimals[i].sheepShader, "woolNoiseTexture", sheepSkin)
        dxSetShaderValue(currentAnimals[i].sheepShader, "skinTexture", sheepSkin2)
        dxSetShaderValue(currentAnimals[i].sheepShader, "woolText", textures[currentAnimals[i].type][currentAnimals[i].variation + #textures[currentAnimals[i].type] / 2])
      end
      currentAnimals[i].shaderSize = animalTypes[currentAnimals[i].type].size[1] + (animalTypes[currentAnimals[i].type].size[2] - animalTypes[currentAnimals[i].type].size[1]) * currentAnimals[i].growth
      currentAnimals[i].shaderMorph = animalTypes[currentAnimals[i].type].morph[1] + (animalTypes[currentAnimals[i].type].morph[2] - animalTypes[currentAnimals[i].type].morph[1]) * currentAnimals[i].fat
      dxSetShaderValue(currentAnimals[i].shader, "size", currentAnimals[i].shaderSize)
      dxSetShaderValue(currentAnimals[i].shader, "morph", currentAnimals[i].shaderMorph)
      dxSetShaderValue(currentAnimals[i].shader, "gTexture", textures[currentAnimals[i].type][currentAnimals[i].variation])
      if isElement(currentAnimals[i].sheepShader) then
        dxSetShaderValue(currentAnimals[i].sheepShader, "size", currentAnimals[i].shaderSize)
        dxSetShaderValue(currentAnimals[i].sheepShader, "morph", currentAnimals[i].shaderMorph)
        dxSetShaderValue(currentAnimals[i].sheepShader, "wool", currentAnimals[i].wool)
      end
    end
  end
  for i = 1, #currentAnimals do
    for j = i, #currentAnimals do
      if isElement(currentAnimals[i].element) and isElement(currentAnimals[j].element) then
        setElementCollidableWith(currentAnimals[i].element, currentAnimals[j].element, false)
      end
    end
  end
end
function drawFarmAnimalRT(redraw)
  dxSetRenderTarget(farmRT)
  for x = 1, farmSizeDetails[currentSize].size[1] do
    for y = 1, farmSizeDetails[currentSize].size[2] do
      seelangStaticImageUsed[3] = true
      if seelangStaticImageToc[3] then
        processSeelangStaticImage[3]()
      end
      dxDrawImage((x - 1) * textureSize, (y - 1) * textureSize, textureSize, textureSize, seelangStaticImage[3])
    end
  end
  for x = 1, farmSizeDetails[currentSize].size[1] do
    for y = 1, farmSizeDetails[currentSize].size[2] do
      local dirt = landData[x][y].dirt or 0
      if isInInterpolation(x, y, "dirt") then
        dirt = interpolateBetween(landIterpolations[x][y].from or 0, 0, 0, landIterpolations[x][y].to or 0, 0, 0, landIterpolations[x][y].progress, "Linear")
      end
      dirt = dirt / 255
      local wetness = dirt * 40 - 20
      if 0 < wetness then
        seelangStaticImageUsed[4] = true
        if seelangStaticImageToc[4] then
          processSeelangStaticImage[4]()
        end
        dxDrawImage((x - 1) * textureSize - textureSize / 2, (y - 1) * textureSize - textureSize / 2, textureSize * 2, textureSize * 2, seelangStaticImage[4], 0, 0, 0, tocolor(255, 255, 255, wetness))
      end
      if 0.5 < dirt then
        local r = x * y * 90
        seelangStaticImageUsed[5] = true
        if seelangStaticImageToc[5] then
          processSeelangStaticImage[5]()
        end
        dxDrawImage((x - 1) * textureSize, (y - 1) * textureSize, textureSize, textureSize, seelangStaticImage[5], r, 0, 0, tocolor(255, 255, 255, (dirt - 0.5) * 2 * 255))
      end
    end
  end
  local dirtAvg = 0
  local dirtC = 0
  for x = 1, farmSizeDetails[currentSize].size[1] do
    for y = 1, farmSizeDetails[currentSize].size[2] do
      local r = x * y * 90
      local dirt = landData[x][y].dirt
      local dirtInterpolation = isInInterpolation(x, y, "dirt")
      if dirtInterpolation then
        local a = interpolateBetween(landIterpolations[x][y].from or 0, 0, 0, landIterpolations[x][y].to or 0, 0, 0, landIterpolations[x][y].progress, "Linear")
        dirt = a
      end
      if dirt then
        dirtAvg = dirtAvg + dirt
      end
      dirtC = dirtC + 1
      if landData[x][y].hay or dirtInterpolation then
        if isInInterpolation(x, y, "hay") or dirtInterpolation then
          local a = 0
          if dirtInterpolation then
            a = interpolateBetween(landIterpolations[x][y].to == 0 and 255 or landIterpolations[x][y].hay and 255 or 0, 0, 0, landIterpolations[x][y].to == 0 and 0 or 255, 0, 0, math.min(1, 1.5 * landIterpolations[x][y].progress), "Linear")
          else
            a = interpolateBetween(landIterpolations[x][y].from and 255 or 0, 0, 0, landIterpolations[x][y].to and 255 or 0, 0, 0, landIterpolations[x][y].progress, "Linear")
          end
          a = a * 3
          seelangStaticImageUsed[6] = true
          if seelangStaticImageToc[6] then
            processSeelangStaticImage[6]()
          end
          dxDrawImage((x - 1) * textureSize, (y - 1) * textureSize, textureSize, textureSize, seelangStaticImage[6], r + 0, 0, 0, tocolor(255, 255, 255, math.min(255, a)))
          a = a - 255
          if 0 < a then
            seelangStaticImageUsed[6] = true
            if seelangStaticImageToc[6] then
              processSeelangStaticImage[6]()
            end
            dxDrawImage((x - 1) * textureSize, (y - 1) * textureSize, textureSize, textureSize, seelangStaticImage[6], r + 180, 0, 0, tocolor(255, 255, 255, math.min(255, a)))
            a = a - 255
            if 0 < a then
              seelangStaticImageUsed[6] = true
              if seelangStaticImageToc[6] then
                processSeelangStaticImage[6]()
              end
              dxDrawImage((x - 1) * textureSize, (y - 1) * textureSize, textureSize, textureSize, seelangStaticImage[6], r + 90, 0, 0, tocolor(255, 255, 255, math.min(255, a)))
            end
          end
        else
          seelangStaticImageUsed[6] = true
          if seelangStaticImageToc[6] then
            processSeelangStaticImage[6]()
          end
          dxDrawImage((x - 1) * textureSize, (y - 1) * textureSize, textureSize, textureSize, seelangStaticImage[6], r)
          seelangStaticImageUsed[6] = true
          if seelangStaticImageToc[6] then
            processSeelangStaticImage[6]()
          end
          dxDrawImage((x - 1) * textureSize, (y - 1) * textureSize, textureSize, textureSize, seelangStaticImage[6], r + 180)
          seelangStaticImageUsed[6] = true
          if seelangStaticImageToc[6] then
            processSeelangStaticImage[6]()
          end
          dxDrawImage((x - 1) * textureSize, (y - 1) * textureSize, textureSize, textureSize, seelangStaticImage[6], r + 90)
        end
      end
    end
  end
  dirtAvg = dirtAvg / dirtC / 255
  if 0.65 < dirtAvg then
    local a = (dirtAvg - 0.65) / 0.35 * 255
    seelangStaticImageUsed[7] = true
    if seelangStaticImageToc[7] then
      processSeelangStaticImage[7]()
    end
    dxDrawImage(0 * textureSize, 0 * textureSize, textureSize * 2 * 3, textureSize * 2 * 1, seelangStaticImage[7], 5, 0, 0, tocolor(255, 255, 255, a))
    seelangStaticImageUsed[7] = true
    if seelangStaticImageToc[7] then
      processSeelangStaticImage[7]()
    end
    dxDrawImage(-0.5 * textureSize, 5 * textureSize, textureSize * 2 * 3, textureSize * 2 * 1.5, seelangStaticImage[7], 85, 0, 0, tocolor(255, 255, 255, a))
    seelangStaticImageUsed[7] = true
    if seelangStaticImageToc[7] then
      processSeelangStaticImage[7]()
    end
    dxDrawImage(-1 * textureSize, 5 * textureSize, textureSize * 3, textureSize * 1, seelangStaticImage[7], 250, 0, 0, tocolor(255, 255, 255, a))
  end
  for x = 1, farmSizeDetails[currentSize].size[1] do
    for y = 1, farmSizeDetails[currentSize].size[2] do
      local r = x * y * 90
      local dirt = landData[x][y].dirt or 0
      if isInInterpolation(x, y, "dirt") then
        dirt = interpolateBetween(landIterpolations[x][y].from or 0, 0, 0, landIterpolations[x][y].to or 0, 0, 0, landIterpolations[x][y].progress, "Linear")
      end
      if 0 < dirt then
        local a = dirt * 2
        seelangStaticImageUsed[8] = true
        if seelangStaticImageToc[8] then
          processSeelangStaticImage[8]()
        end
        dxDrawImage((x - 1) * textureSize, (y - 1) * textureSize, textureSize, textureSize, seelangStaticImage[8], r + 0, 0, 0, tocolor(255, 255, 255, math.min(255, a)))
        if 127.5 < dirt then
          a = a - 255
          seelangStaticImageUsed[8] = true
          if seelangStaticImageToc[8] then
            processSeelangStaticImage[8]()
          end
          dxDrawImage((x - 1) * textureSize, (y - 1) * textureSize, textureSize, textureSize, seelangStaticImage[8], r + 90, 0, 0, tocolor(255, 255, 255, math.min(255, a)))
        end
      end
    end
  end
  if farmHover then
    local x = farmHover[1]
    local y = farmHover[2]
    dxDrawLine((x - 1) * textureSize, (y - 1) * textureSize, (x - 1) * textureSize, y * textureSize, tocolor(green[1], green[2], green[3]), 2)
    dxDrawLine((x - 1) * textureSize, y * textureSize, x * textureSize, y * textureSize, tocolor(green[1], green[2], green[3]), 2)
    dxDrawLine(x * textureSize, y * textureSize, x * textureSize, (y - 1) * textureSize, tocolor(green[1], green[2], green[3]), 2)
    dxDrawLine(x * textureSize, (y - 1) * textureSize, (x - 1) * textureSize, (y - 1) * textureSize, tocolor(green[1], green[2], green[3]), 2)
  end
  dxSetRenderTarget()
end
animalPanel = false
local checkingOrder = false
local loadingOrder = false
local loadingOrderCol = false
local loadingOrderType = false
addEvent("closeAnimalPanel", true)
addEventHandler("closeAnimalPanel", getRootElement(), function()
  loadingOrder = false
  loadingOrderCol = false
  if animalPanel then
    seexports.sGui:deleteGuiElement(animalPanel)
  end
  animalPanel = false
  animalHoverBox = false
end)
local buyAmountLabel = false
local buyPriceLabel = false
local buyAmount = 1
addEvent("hayBuySliderChange", true)
addEventHandler("hayBuySliderChange", getRootElement(), function(el, sliderValue)
  buyAmount = math.floor(1 + (baleNum - math.ceil(baleWas) - 1) * sliderValue + 0.5)
  seexports.sGui:setLabelText(buyAmountLabel, "Vásárolni kívánt mennyiség: " .. seexports.sGui:getColorCodeHex("sightgreen") .. buyAmount .. " bála")
  seexports.sGui:setLabelText(buyPriceLabel, "Fizetendő: " .. seexports.sGui:getColorCodeHex("sightgreen") .. seexports.sGui:thousandsStepper(balePrice * buyAmount) .. " $")
end)
addEvent("confirmHayBuy", true)
addEventHandler("confirmHayBuy", getRootElement(), function()
  if not checkingOrder then
    checkingOrder = true
    triggerServerEvent("finalBuyHay", localPlayer, currentFarmId, buyAmount)
  end
end)
addEvent("buyHayPanel", true)
addEventHandler("buyHayPanel", getRootElement(), function()
  if math.ceil(baleWas) >= baleNum then
    seexports.sGui:showInfobox("e", "Nem fér el több szalma a farmodban.")
    return
  end
  local titleBarHeight = seexports.sGui:getTitleBarHeight()
  local windowHeight = titleBarHeight + 35 + 5 + 75 + 14 + 5 + 2 + 10
  local windowWidth = 350
  if animalPanel then
    seexports.sGui:deleteGuiElement(animalPanel)
  end
  animalPanel = seexports.sGui:createGuiElement("window", screenX / 2 - windowWidth / 2, screenY / 2 - windowHeight / 2, windowWidth, windowHeight)
  seexports.sGui:setWindowTitle(animalPanel, "16/BebasNeueRegular.otf", "SightMTA - Szalma vásárlás")
  local y = 5 + titleBarHeight
  local label = seexports.sGui:createGuiElement("label", 0, y, windowWidth, 20, animalPanel)
  seexports.sGui:setLabelAlignment(label, "center", "center")
  seexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
  seexports.sGui:setLabelText(label, "Szalma a farmodban: " .. seexports.sGui:getColorCodeHex("sightgreen") .. math.ceil(baleWas) .. " bála")
  y = y + 20 + 5
  buyAmount = 1
  local border = seexports.sGui:createGuiElement("hr", 5, y + 5 - 1, windowWidth - 10, 2, animalPanel)
  y = y + 2 + 10
  buyAmountLabel = seexports.sGui:createGuiElement("label", 0, y, windowWidth, 20, animalPanel)
  seexports.sGui:setLabelAlignment(buyAmountLabel, "center", "center")
  seexports.sGui:setLabelFont(buyAmountLabel, "11/Ubuntu-L.ttf")
  seexports.sGui:setLabelText(buyAmountLabel, "Vásárolni kívánt mennyiség: " .. seexports.sGui:getColorCodeHex("sightgreen") .. buyAmount .. " bála")
  y = y + 20 + 5
  local slider = seexports.sGui:createGuiElement("slider", 16, y, windowWidth - 32, 14, animalPanel)
  seexports.sGui:setSliderChangeEvent(slider, "hayBuySliderChange")
  y = y + 14 + 5
  buyPriceLabel = seexports.sGui:createGuiElement("label", 0, y, windowWidth, 20, animalPanel)
  seexports.sGui:setLabelAlignment(buyPriceLabel, "center", "center")
  seexports.sGui:setLabelFont(buyPriceLabel, "11/Ubuntu-L.ttf")
  seexports.sGui:setLabelText(buyPriceLabel, "Fizetendő: " .. seexports.sGui:getColorCodeHex("sightgreen") .. seexports.sGui:thousandsStepper(balePrice * buyAmount) .. " $")
  local btn = seexports.sGui:createGuiElement("button", 5, windowHeight - 30 - 5, (windowWidth - 15) / 2, 30, animalPanel)
  seexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
  seexports.sGui:setGuiHover(btn, "gradient", {
    "sightgreen",
    "sightgreen-second"
  }, false, true)
  seexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
  seexports.sGui:setButtonTextColor(btn, "#ffffff")
  seexports.sGui:setButtonText(btn, "Megrendelés")
  seexports.sGui:setClickEvent(btn, "confirmHayBuy", false)
  local btn = seexports.sGui:createGuiElement("button", 5 + (windowWidth - 15) / 2 + 5, windowHeight - 30 - 5, (windowWidth - 15) / 2, 30, animalPanel)
  seexports.sGui:setGuiBackground(btn, "solid", "sightred")
  seexports.sGui:setGuiHover(btn, "gradient", {
    "sightred",
    "sightred-second"
  }, false, true)
  seexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
  seexports.sGui:setButtonTextColor(btn, "#ffffff")
  seexports.sGui:setButtonText(btn, "Mégsem")
  seexports.sGui:setClickEvent(btn, "openShopPanel", false)
end)
addEvent("otherFoodSliderChange", true)
addEventHandler("otherFoodSliderChange", getRootElement(), function(el, sliderValue)
  buyAmount = math.floor(1 + (foodBagNum - math.ceil(otherFoodWas) - 1) * sliderValue + 0.5)
  seexports.sGui:setLabelText(buyAmountLabel, "Vásárolni kívánt mennyiség: " .. seexports.sGui:getColorCodeHex("sightgreen") .. buyAmount .. " zsák")
  seexports.sGui:setLabelText(buyPriceLabel, "Fizetendő: " .. seexports.sGui:getColorCodeHex("sightgreen") .. seexports.sGui:thousandsStepper(otherFoodPrice * buyAmount) .. " $")
end)
addEvent("confirmOtherFoodBuy", true)
addEventHandler("confirmOtherFoodBuy", getRootElement(), function()
  if not checkingOrder then
    checkingOrder = true
    triggerServerEvent("finalOtherFoodBuy", localPlayer, currentFarmId, buyAmount)
  end
end)
addEvent("buyOtherFoodPanel", true)
addEventHandler("buyOtherFoodPanel", getRootElement(), function()
  if math.ceil(otherFoodWas) >= foodBagNum then
    seexports.sGui:showInfobox("e", "Nem fér el több táp a farmodban.")
    return
  end
  local titleBarHeight = seexports.sGui:getTitleBarHeight()
  local windowHeight = titleBarHeight + 35 + 5 + 75 + 14 + 5 + 2 + 10
  local windowWidth = 350
  if animalPanel then
    seexports.sGui:deleteGuiElement(animalPanel)
  end
  animalPanel = seexports.sGui:createGuiElement("window", screenX / 2 - windowWidth / 2, screenY / 2 - windowHeight / 2, windowWidth, windowHeight)
  seexports.sGui:setWindowTitle(animalPanel, "16/BebasNeueRegular.otf", "SightMTA - Szalma vásárlás")
  local y = 5 + titleBarHeight
  local label = seexports.sGui:createGuiElement("label", 0, y, windowWidth, 20, animalPanel)
  seexports.sGui:setLabelAlignment(label, "center", "center")
  seexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
  seexports.sGui:setLabelText(label, "Pellet táp a farmodban: " .. seexports.sGui:getColorCodeHex("sightgreen") .. math.ceil(otherFoodWas) .. " zsák")
  y = y + 20 + 5
  buyAmount = 1
  local border = seexports.sGui:createGuiElement("hr", 5, y + 5 - 1, windowWidth - 10, 2, animalPanel)
  y = y + 2 + 10
  buyAmountLabel = seexports.sGui:createGuiElement("label", 0, y, windowWidth, 20, animalPanel)
  seexports.sGui:setLabelAlignment(buyAmountLabel, "center", "center")
  seexports.sGui:setLabelFont(buyAmountLabel, "11/Ubuntu-L.ttf")
  seexports.sGui:setLabelText(buyAmountLabel, "Vásárolni kívánt mennyiség: " .. seexports.sGui:getColorCodeHex("sightgreen") .. buyAmount .. " zsák")
  y = y + 20 + 5
  local slider = seexports.sGui:createGuiElement("slider", 16, y, windowWidth - 32, 14, animalPanel)
  seexports.sGui:setSliderChangeEvent(slider, "otherFoodSliderChange")
  y = y + 14 + 5
  buyPriceLabel = seexports.sGui:createGuiElement("label", 0, y, windowWidth, 20, animalPanel)
  seexports.sGui:setLabelAlignment(buyPriceLabel, "center", "center")
  seexports.sGui:setLabelFont(buyPriceLabel, "11/Ubuntu-L.ttf")
  seexports.sGui:setLabelText(buyPriceLabel, "Fizetendő: " .. seexports.sGui:getColorCodeHex("sightgreen") .. seexports.sGui:thousandsStepper(otherFoodPrice * buyAmount) .. " $")
  local btn = seexports.sGui:createGuiElement("button", 5, windowHeight - 30 - 5, (windowWidth - 15) / 2, 30, animalPanel)
  seexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
  seexports.sGui:setGuiHover(btn, "gradient", {
    "sightgreen",
    "sightgreen-second"
  }, false, true)
  seexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
  seexports.sGui:setButtonTextColor(btn, "#ffffff")
  seexports.sGui:setButtonText(btn, "Megrendelés")
  seexports.sGui:setClickEvent(btn, "confirmOtherFoodBuy", false)
  local btn = seexports.sGui:createGuiElement("button", 5 + (windowWidth - 15) / 2 + 5, windowHeight - 30 - 5, (windowWidth - 15) / 2, 30, animalPanel)
  seexports.sGui:setGuiBackground(btn, "solid", "sightred")
  seexports.sGui:setGuiHover(btn, "gradient", {
    "sightred",
    "sightred-second"
  }, false, true)
  seexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
  seexports.sGui:setButtonTextColor(btn, "#ffffff")
  seexports.sGui:setButtonText(btn, "Mégsem")
  seexports.sGui:setClickEvent(btn, "openShopPanel", false)
end)
addEvent("chickenFoodSliderChange", true)
addEventHandler("chickenFoodSliderChange", getRootElement(), function(el, sliderValue)
  buyAmount = math.floor(1 + (foodBagNum - math.ceil(chickenFoodWas) - 1) * sliderValue + 0.5)
  seexports.sGui:setLabelText(buyAmountLabel, "Vásárolni kívánt mennyiség: " .. seexports.sGui:getColorCodeHex("sightgreen") .. buyAmount .. " zsák")
  seexports.sGui:setLabelText(buyPriceLabel, "Fizetendő: " .. seexports.sGui:getColorCodeHex("sightgreen") .. seexports.sGui:thousandsStepper(chickenFoodPrice * buyAmount) .. " $")
end)
addEvent("confirmChickenFoodBuy", true)
addEventHandler("confirmChickenFoodBuy", getRootElement(), function()
  if not checkingOrder then
    checkingOrder = true
    triggerServerEvent("finalChickenFoodBuy", localPlayer, currentFarmId, buyAmount)
  end
end)
addEvent("buyChickenFoodPanel", true)
addEventHandler("buyChickenFoodPanel", getRootElement(), function()
  if math.ceil(chickenFoodWas) >= foodBagNum then
    seexports.sGui:showInfobox("e", "Nem fér el több táp a farmodban.")
    return
  end
  local titleBarHeight = seexports.sGui:getTitleBarHeight()
  local windowHeight = titleBarHeight + 35 + 5 + 75 + 14 + 5 + 2 + 10
  local windowWidth = 350
  if animalPanel then
    seexports.sGui:deleteGuiElement(animalPanel)
  end
  animalPanel = seexports.sGui:createGuiElement("window", screenX / 2 - windowWidth / 2, screenY / 2 - windowHeight / 2, windowWidth, windowHeight)
  seexports.sGui:setWindowTitle(animalPanel, "16/BebasNeueRegular.otf", "SightMTA - Szalma vásárlás")
  local y = 5 + titleBarHeight
  local label = seexports.sGui:createGuiElement("label", 0, y, windowWidth, 20, animalPanel)
  seexports.sGui:setLabelAlignment(label, "center", "center")
  seexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
  seexports.sGui:setLabelText(label, "Csirketáp a farmodban: " .. seexports.sGui:getColorCodeHex("sightgreen") .. math.ceil(chickenFoodWas) .. " zsák")
  y = y + 20 + 5
  buyAmount = 1
  local border = seexports.sGui:createGuiElement("hr", 5, y + 5 - 1, windowWidth - 10, 2, animalPanel)
  y = y + 2 + 10
  buyAmountLabel = seexports.sGui:createGuiElement("label", 0, y, windowWidth, 20, animalPanel)
  seexports.sGui:setLabelAlignment(buyAmountLabel, "center", "center")
  seexports.sGui:setLabelFont(buyAmountLabel, "11/Ubuntu-L.ttf")
  seexports.sGui:setLabelText(buyAmountLabel, "Vásárolni kívánt mennyiség: " .. seexports.sGui:getColorCodeHex("sightgreen") .. buyAmount .. " zsák")
  y = y + 20 + 5
  local slider = seexports.sGui:createGuiElement("slider", 16, y, windowWidth - 32, 14, animalPanel)
  seexports.sGui:setSliderChangeEvent(slider, "chickenFoodSliderChange")
  y = y + 14 + 5
  buyPriceLabel = seexports.sGui:createGuiElement("label", 0, y, windowWidth, 20, animalPanel)
  seexports.sGui:setLabelAlignment(buyPriceLabel, "center", "center")
  seexports.sGui:setLabelFont(buyPriceLabel, "11/Ubuntu-L.ttf")
  seexports.sGui:setLabelText(buyPriceLabel, "Fizetendő: " .. seexports.sGui:getColorCodeHex("sightgreen") .. seexports.sGui:thousandsStepper(chickenFoodPrice * buyAmount) .. " $")
  local btn = seexports.sGui:createGuiElement("button", 5, windowHeight - 30 - 5, (windowWidth - 15) / 2, 30, animalPanel)
  seexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
  seexports.sGui:setGuiHover(btn, "gradient", {
    "sightgreen",
    "sightgreen-second"
  }, false, true)
  seexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
  seexports.sGui:setButtonTextColor(btn, "#ffffff")
  seexports.sGui:setButtonText(btn, "Megrendelés")
  seexports.sGui:setClickEvent(btn, "confirmChickenFoodBuy", false)
  local btn = seexports.sGui:createGuiElement("button", 5 + (windowWidth - 15) / 2 + 5, windowHeight - 30 - 5, (windowWidth - 15) / 2, 30, animalPanel)
  seexports.sGui:setGuiBackground(btn, "solid", "sightred")
  seexports.sGui:setGuiHover(btn, "gradient", {
    "sightred",
    "sightred-second"
  }, false, true)
  seexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
  seexports.sGui:setButtonTextColor(btn, "#ffffff")
  seexports.sGui:setButtonText(btn, "Mégsem")
  seexports.sGui:setClickEvent(btn, "openShopPanel", false)
end)
addEvent("openShopPanelEx", true)
addEventHandler("openShopPanelEx", getRootElement(), function()
  if not checkingOrder then
    checkingOrder = true
    triggerServerEvent("requestAnimalOrder", localPlayer, currentFarmId)
  end
end)
addEvent("confirmOrderCancel", true)
addEventHandler("confirmOrderCancel", getRootElement(), function()
  if not checkingOrder then
    checkingOrder = true
    triggerServerEvent("cancelOrder", localPlayer, currentFarmId)
  end
end)
addEvent("cancelOrder", true)
addEventHandler("cancelOrder", getRootElement(), function()
  local titleBarHeight = seexports.sGui:getTitleBarHeight()
  local windowHeight = titleBarHeight + 35 + 5 + 20 + 5
  local windowWidth = 350
  if animalPanel then
    seexports.sGui:deleteGuiElement(animalPanel)
  end
  animalPanel = seexports.sGui:createGuiElement("window", screenX / 2 - windowWidth / 2, screenY / 2 - windowHeight / 2, windowWidth, windowHeight)
  seexports.sGui:setWindowTitle(animalPanel, "16/BebasNeueRegular.otf", "SightMTA - Rendelés lemondás")
  local label = seexports.sGui:createGuiElement("label", 0, 5 + titleBarHeight, windowWidth, 20, animalPanel)
  seexports.sGui:setLabelAlignment(label, "center", "center")
  seexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
  seexports.sGui:setLabelText(label, "Biztosan szeretnéd lemondani a rendelést?")
  local btn = seexports.sGui:createGuiElement("button", 5, windowHeight - 30 - 5, (windowWidth - 15) / 2, 30, animalPanel)
  seexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
  seexports.sGui:setGuiHover(btn, "gradient", {
    "sightgreen",
    "sightgreen-second"
  }, false, true)
  seexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
  seexports.sGui:setButtonTextColor(btn, "#ffffff")
  seexports.sGui:setButtonText(btn, "Igen")
  seexports.sGui:setClickEvent(btn, "confirmOrderCancel", false)
  local btn = seexports.sGui:createGuiElement("button", 5 + (windowWidth - 15) / 2 + 5, windowHeight - 30 - 5, (windowWidth - 15) / 2, 30, animalPanel)
  seexports.sGui:setGuiBackground(btn, "solid", "sightred")
  seexports.sGui:setGuiHover(btn, "gradient", {
    "sightred",
    "sightred-second"
  }, false, true)
  seexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
  seexports.sGui:setButtonTextColor(btn, "#ffffff")
  seexports.sGui:setButtonText(btn, "Nem")
  seexports.sGui:setClickEvent(btn, "openShopPanelEx", false)
end)
local animalTypeButtons = {}
local animalButtons = {}
local animalOffers = {}
local animalOrderNums = 10
function refreshAnimalOffers(force)
  for k, v in pairs(animalTypes) do
    if not animalOffers[k] then
      animalOffers[k] = {}
    end
    for i = 1, animalOrderNums do
      if not animalOffers[k][i] or animalOffers[k][i][4] or force then
        animalOffers[k][i] = {
          math.random(10) / 100,
          math.random(100) / 100,
          math.random(v.variations[1], v.variations[2]),
          false
        }
        local perc = -10 + (10 * animalOffers[k][i][2] + 25 * (animalOffers[k][i][1] / 0.1))
        perc = perc / 100
        animalOffers[k][i][5] = math.floor(animalTypes[k].basePrice * (1 + perc))
      end
    end
  end
end
local lastRefresh = 60
setTimer(function()
  lastRefresh = lastRefresh - 1
  if lastRefresh <= 0 and not animalPanel then
    refreshAnimalOffers(true)
    lastRefresh = 60
  end
end, 60000, 0)
refreshAnimalOffers()
local selectedAnimalToBuy = false
addEvent("confirmAnimalBuy", true)
addEventHandler("confirmAnimalBuy", getRootElement(), function()
  local order = {}
  for i = 1, animalOrderNums do
    if animalOffers[selectedAnimalToBuy][i][4] then
      table.insert(order, {
        animalOffers[selectedAnimalToBuy][i][1],
        animalOffers[selectedAnimalToBuy][i][2],
        animalOffers[selectedAnimalToBuy][i][3],
        animalOffers[selectedAnimalToBuy][i][5],
      })
    end
  end
  if 0 < #order and not checkingOrder then
    checkingOrder = true
    triggerServerEvent("finalOrderAnimals", getRootElement(), currentFarmId, selectedAnimalToBuy, order)
  end
end)
local animalOffset = 0
local animalsScrollNum = 0
function scrollHandler(key, por)
  if key == "mouse_wheel_up" then
    if 0 < animalOffset then
      animalOffset = animalOffset - 1
      openAnimalList()
    end
  elseif key == "mouse_wheel_down" and animalOffset < animalsScrollNum then
    animalOffset = animalOffset + 1
    openAnimalList()
  end
end
local scrollHandled = false
local farmAnimalSellMode = false
local sellingAnimalType = false
local animalsToSell = {}
local sellAnimalButtons = {}
addEvent("farmAnimalSellMode", true)
addEventHandler("farmAnimalSellMode", getRootElement(), function()
  if farmAnimalSellMode then
    farmAnimalSellMode = false
    openAnimalList()
  else
    triggerServerEvent("checkCanSellAnimal", localPlayer, currentFarmId)
  end
end)
addEvent("gotAllowForAnimalSell", true)
addEventHandler("gotAllowForAnimalSell", getRootElement(), function()
  farmAnimalSellMode = true
  sellingAnimalType = false
  animalsToSell = {}
  openAnimalList()
end)
addEvent("sellAnimalButton", true)
addEventHandler("sellAnimalButton", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  if sellAnimalButtons[el] then
    animalsToSell[sellAnimalButtons[el]] = not animalsToSell[sellAnimalButtons[el]]
    local tmp = false
    for k, v in pairs(animalsToSell) do
      if v then
        tmp = currentAnimals[k].type
      end
    end
    sellingAnimalType = tmp
    openAnimalList()
  end
end)
addEvent("finalFarmAnimalSell", true)
addEventHandler("finalFarmAnimalSell", getRootElement(), function()
  animalHoverBox = false
  if not checkingOrder then
    checkingOrder = true
    local c = 0
    for k, v in pairs(animalsToSell) do
      if v then
        c = c + 1
      end
    end
    if 0 < c then
      triggerServerEvent("finalSellAnimals", localPlayer, currentFarmId, animalsToSell)
      farmAnimalSellMode = false
      animalsToSell = {}
      sellingAnimalType = false
    end
  end
end)
local statsCardIds = {}
local selectedStatAnimal = false
function showStatPrompt()
  local titleBarHeight = seexports.sGui:getTitleBarHeight()
  local windowHeight = titleBarHeight + 35 + 5 + 20 + 5
  local windowWidth = 350
  if animalPanel then
    seexports.sGui:deleteGuiElement(animalPanel)
  end
  animalPanel = seexports.sGui:createGuiElement("window", screenX / 2 - windowWidth / 2, screenY / 2 - windowHeight / 2, windowWidth, windowHeight)
  seexports.sGui:setWindowTitle(animalPanel, "16/BebasNeueRegular.otf", "SightMTA - Stats kártya")
  local label = seexports.sGui:createGuiElement("label", 0, 5 + titleBarHeight, windowWidth, 20, animalPanel)
  seexports.sGui:setLabelAlignment(label, "center", "center")
  seexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
  seexports.sGui:setLabelText(label, "Biztosan szeretnéd felhasználni a kártyád?")
  local btn = seexports.sGui:createGuiElement("button", 5, windowHeight - 30 - 5, (windowWidth - 15) / 2, 30, animalPanel)
  seexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
  seexports.sGui:setGuiHover(btn, "gradient", {
    "sightgreen",
    "sightgreen-second"
  }, false, true)
  seexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
  seexports.sGui:setButtonTextColor(btn, "#ffffff")
  seexports.sGui:setButtonText(btn, "Igen")
  seexports.sGui:setClickEvent(btn, "finalUseStatsCard", false)
  local btn = seexports.sGui:createGuiElement("button", 5 + (windowWidth - 15) / 2 + 5, windowHeight - 30 - 5, (windowWidth - 15) / 2, 30, animalPanel)
  seexports.sGui:setGuiBackground(btn, "solid", "sightred")
  seexports.sGui:setGuiHover(btn, "gradient", {
    "sightred",
    "sightred-second"
  }, false, true)
  seexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
  seexports.sGui:setButtonTextColor(btn, "#ffffff")
  seexports.sGui:setButtonText(btn, "Nem")
  seexports.sGui:setClickEvent(btn, "openAnimalList", false)
end
addEvent("resetToolsPrompt", true)
addEventHandler("resetToolsPrompt", getRootElement(), function()
  local titleBarHeight = seexports.sGui:getTitleBarHeight()
  local windowHeight = titleBarHeight + 35 + 5 + 40 + 5
  local windowWidth = 300
  if animalPanel then
    seexports.sGui:deleteGuiElement(animalPanel)
  end
  animalPanel = seexports.sGui:createGuiElement("window", screenX / 2 - windowWidth / 2, screenY / 2 - windowHeight / 2, windowWidth, windowHeight)
  seexports.sGui:setWindowTitle(animalPanel, "16/BebasNeueRegular.otf", "SightMTA - Eszközök visszaállítása")
  local label = seexports.sGui:createGuiElement("label", 0, 5 + titleBarHeight, windowWidth, 40, animalPanel)
  seexports.sGui:setLabelAlignment(label, "center", "center")
  seexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
  seexports.sGui:setLabelText(label, "Biztosan szeretnéd visszaállítani a\nvödröt és talicskát az eredeti helyére?")
  local btn = seexports.sGui:createGuiElement("button", 5, windowHeight - 30 - 5, (windowWidth - 15) / 2, 30, animalPanel)
  seexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
  seexports.sGui:setGuiHover(btn, "gradient", {
    "sightgreen",
    "sightgreen-second"
  }, false, true)
  seexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
  seexports.sGui:setButtonTextColor(btn, "#ffffff")
  seexports.sGui:setButtonText(btn, "Igen")
  seexports.sGui:setClickEvent(btn, "finalResetTools", false)
  local btn = seexports.sGui:createGuiElement("button", 5 + (windowWidth - 15) / 2 + 5, windowHeight - 30 - 5, (windowWidth - 15) / 2, 30, animalPanel)
  seexports.sGui:setGuiBackground(btn, "solid", "sightred")
  seexports.sGui:setGuiHover(btn, "gradient", {
    "sightred",
    "sightred-second"
  }, false, true)
  seexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
  seexports.sGui:setButtonTextColor(btn, "#ffffff")
  seexports.sGui:setButtonText(btn, "Nem")
  seexports.sGui:setClickEvent(btn, "openAnimalPanel", false)
end)
addEvent("finalResetTools", true)
addEventHandler("finalResetTools", getRootElement(), function()
  triggerServerEvent("tryToResetTools", localPlayer, currentFarmId)
  openAnimalPanel()
end)
addEvent("finalUseStatsCard", true)
addEventHandler("finalUseStatsCard", getRootElement(), function()
  if selectedStatAnimal then
    triggerServerEvent("tryToUseStatsCard", localPlayer, currentFarmId, selectedStatAnimal)
    selectedStatAnimal = false
  end
  openAnimalList()
end)
addEvent("useStatsCard", true)
addEventHandler("useStatsCard", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  if statsCardIds[el] and not selectedStatAnimal then
    selectedStatAnimal = statsCardIds[el]
    showStatPrompt()
  end
end)
addEvent("fullStatAnimal", true)
addEventHandler("fullStatAnimal", getRootElement(), function(farmId, i)
  if farmId == currentFarmId and currentAnimals[i] then
    currentAnimals[i].health = 1
    currentAnimals[i].fat = 1
    currentAnimals[i].mood = 1
    currentAnimals[i].moodMinus = 0
    currentAnimals[i].shaderMorph = animalTypes[currentAnimals[i].type].morph[1] + (animalTypes[currentAnimals[i].type].morph[2] - animalTypes[currentAnimals[i].type].morph[1]) * currentAnimals[i].fat
    dxSetShaderValue(currentAnimals[i].shader, "morph", currentAnimals[i].shaderMorph)
    if isElement(currentAnimals[i].sheepShader) then
      dxSetShaderValue(currentAnimals[i].sheepShader, "morph", currentAnimals[i].shaderMorph)
    end
    if source == localPlayer then
      openAnimalList()
    end
  end
end)
function openAnimalList()
  local titleBarHeight = seexports.sGui:getTitleBarHeight()
  if animalPanel then
    seexports.sGui:deleteGuiElement(animalPanel)
  end
  sellAnimalButtons = {}
  statsCardIds = {}
  animalHoverBox = {}
  checkingOrder = false
  selectedStatAnimal = false
  if #currentAnimals > 0 then
    local playerHasCard = seexports.sItems:playerHasItem(590)
    if not scrollHandled then
      scrollHandled = true
      addEventHandler("onClientKey", getRootElement(), scrollHandler)
    end
    local animalsTmp = {}
    local prices = {}
    local animalSellSum = 0
    for i = 1, #currentAnimals do
      if 1 <= currentAnimals[i].growth then
        local sellPrice = animalTypes[currentAnimals[i].type].sellPrice
        local life = math.min(1, currentAnimals[i].life / animalTypes[currentAnimals[i].type].lifeExpectancy)
        local tmp = currentAnimals[i].fat * 2 + currentAnimals[i].health * 5 + currentAnimals[i].mood * 0.5 + math.max(0, 1 - currentAnimals[i].moodMinus) * 3
        tmp = tmp / 10.5
        if 0.65 < life then
          life = (life - 0.65) / 0.35
          life = 1 - life
          tmp = tmp * life
        end
        tmp = math.floor(sellPrice * (tmp * 0.8 + 0.2))
        prices[i] = tmp
        if animalsToSell[i] then
          animalSellSum = animalSellSum + prices[i]
        end
      end
    end
    if farmAnimalSellMode and sellingAnimalType then
      for i = 1, #currentAnimals do
        if currentAnimals[i].type == sellingAnimalType then
          table.insert(animalsTmp, {
            i,
            currentAnimals[i]
          })
        end
      end
    else
      for i = 1, #currentAnimals do
        table.insert(animalsTmp, {
          i,
          currentAnimals[i]
        })
      end
    end
    local num = math.min(5, #animalsTmp)
    animalsScrollNum = #animalsTmp - num
    if animalOffset + num > #animalsTmp then
      animalOffset = #animalsTmp - num
    end
    local btnNum = 2
    if farmAnimalSellMode then
      btnNum = 3
    end
    local windowHeight = titleBarHeight + 70 * num + 35 * btnNum + 5
    local windowWidth = 400
    if farmAnimalSellMode then
      windowWidth = 450
      windowHeight = windowHeight + 40 + 5
    elseif playerHasCard then
      windowWidth = 450
    end
    if not canSellAnimals then
      windowHeight = windowHeight - 30 + 5
    end
    animalPanel = seexports.sGui:createGuiElement("window", screenX / 2 - windowWidth / 2, screenY / 2 - windowHeight / 2, windowWidth, windowHeight)
    if farmAnimalSellMode then
      seexports.sGui:setWindowTitle(animalPanel, "16/BebasNeueRegular.otf", "SightMTA - Állatok eladása")
    else
      seexports.sGui:setWindowTitle(animalPanel, "16/BebasNeueRegular.otf", "SightMTA - Állatok")
    end
    local y = titleBarHeight + 5
    local trailerP = 0
    local trailerPNew = 0
    if farmAnimalSellMode then
      local label = seexports.sGui:createGuiElement("label", 0, y, windowWidth, 24, animalPanel)
      seexports.sGui:setLabelAlignment(label, "center", "center")
      seexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
      seexports.sGui:setLabelText(label, "Utánfutó férőhely:")
      local rect = seexports.sGui:createGuiElement("rectangle", 5, y + 24 + 5, windowWidth - 10, 11, animalPanel)
      seexports.sGui:setGuiBackground(rect, "solid", "sightgrey1")
      if sellingAnimalType then
        local c = 0
        for k, v in pairs(animalsToSell) do
          if v then
            c = c + 1
          end
        end
        trailerP = math.min(1, c / #animalTrailerPoses[sellingAnimalType][1])
        trailerPNew = (c + 1) / #animalTrailerPoses[sellingAnimalType][1]
      end
      local rect = seexports.sGui:createGuiElement("rectangle", 5, y + 24 + 5, (windowWidth - 10) * trailerP, 11, animalPanel)
      seexports.sGui:setGuiBackground(rect, "solid", "sightgreen")
      y = y + 40 + 5
    end
    local tw = 0
    local labels = {
      "Növekedés:",
      "Egészség:",
      "Súly:",
      "Hangulat:",
      "Kor:",
      "Minőség:"
    }
    for i = 1, #labels do
      local tmp = seexports.sGui:getTextWidthFont(labels[i], "11/Ubuntu-L.ttf")
      if tw < tmp then
        tw = tmp
      end
    end
    local sw = 0
    local sh = windowHeight - 35 * btnNum - y - 5 - 5
    if num < #animalsTmp then
      sw = 10
      local rect = seexports.sGui:createGuiElement("rectangle", windowWidth - 10, y, 5, sh, animalPanel)
      seexports.sGui:setGuiBackground(rect, "solid", "sightgrey1")
      sh = sh / (#animalsTmp - num + 1)
      local rect = seexports.sGui:createGuiElement("rectangle", windowWidth - 10, y + animalOffset * sh, 5, sh, animalPanel)
      seexports.sGui:setGuiBackground(rect, "solid", "sightgreen")
    end
    local w = (windowWidth - 5 - 60 - sw) / 2
    if farmAnimalSellMode then
      w = w - 38
    elseif playerHasCard then
      w = w - 25
    end
    local pw = w - tw - 5
    for i = 1, num do
      local id = animalsTmp[i + animalOffset][1]
      local animal = animalsTmp[i + animalOffset][2]
      if animal then
        local box = seexports.sGui:createGuiElement("rectangle", 5, y, windowWidth - 10 - sw, 70, animalPanel)
        seexports.sGui:setGuiBackground(box, "solid", "sightgrey2")
        seexports.sGui:setGuiHoverable(box, true)
        seexports.sGui:setGuiHover(box, "gradient", {"sightgrey1", "sightgrey2"}, false, true)
        table.insert(animalHoverBox, {
          id,
          5,
          y,
          windowWidth - 10 - sw,
          70
        })
        if 1 < i or farmAnimalSellMode then
          local border = seexports.sGui:createGuiElement("hr", 5, y - 1, windowWidth - 10 - sw, 2, animalPanel)
        end
        y = y + 5
        if farmAnimalSellMode then
          local price = prices[id]
          if (trailerPNew <= 1 or animalsToSell[id]) and 1 <= animal.growth then
            local label = seexports.sGui:createGuiElement("label", w * 2 + 60, y, 76, 30, animalPanel)
            seexports.sGui:setLabelAlignment(label, "center", "center")
            seexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
            seexports.sGui:setLabelText(label, seexports.sGui:thousandsStepper(price) .. " $")
            local btn = seexports.sGui:createGuiElement("button", w * 2 + 60 + 10, y + 30 + 5, 56, 20, animalPanel)
            if animalsToSell[id] then
              seexports.sGui:setGuiBackground(btn, "solid", "sightred")
              seexports.sGui:setGuiHover(btn, "gradient", {
                "sightred",
                "sightred-second"
              }, false, true)
              seexports.sGui:setButtonText(btn, "Mégsem")
            else
              seexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
              seexports.sGui:setGuiHover(btn, "gradient", {
                "sightgreen",
                "sightgreen-second"
              }, false, true)
              seexports.sGui:setButtonText(btn, "Eladás")
            end
            seexports.sGui:setButtonFont(btn, "12/BebasNeueBold.otf")
            seexports.sGui:setButtonTextColor(btn, "#ffffff")
            seexports.sGui:setClickEvent(btn, "sellAnimalButton", false)
            sellAnimalButtons[btn] = id
          elseif 1 > animal.growth then
            local label = seexports.sGui:createGuiElement("label", w * 2 + 60, y, 76, 60, animalPanel)
            seexports.sGui:setLabelAlignment(label, "center", "center")
            seexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
            seexports.sGui:setLabelText(label, "Túl\nkicsi!")
          else
            local label = seexports.sGui:createGuiElement("label", w * 2 + 60, y, 76, 60, animalPanel)
            seexports.sGui:setLabelAlignment(label, "center", "center")
            seexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
            seexports.sGui:setLabelText(label, seexports.sGui:thousandsStepper(price) .. " $")
          end
        elseif playerHasCard then
          local rect = seexports.sGui:createGuiElement("rectangle", w * 2 + 60 + 25 - 18, y + 30 - 18, 36, 36, animalPanel)
          seexports.sGui:setGuiBackground(rect, "solid", "sightgrey2")
          seexports.sGui:setGuiHover(rect, "gradient", {
            "sightgreen",
            "sightgreen-second"
          }, false, true, false, true)
          seexports.sGui:setGuiHoverable(rect, true)
          seexports.sGui:guiSetTooltip(rect, "Haszonállat stats kártya felhasználása")
          seexports.sGui:setClickEvent(rect, "useStatsCard", false)
          statsCardIds[rect] = id
          local item = seexports.sGui:createGuiElement("image", w * 2 + 60 + 25 - 18, y + 30 - 18, 36, 36, animalPanel)
          seexports.sGui:setImageFile(item, ":sItems/files/items/589.png")
        end
        local item = seexports.sGui:createGuiElement("image", 5, y + 5, 50, 50, animalPanel)
        seexports.sGui:setImageDDS(item, ":sFarm/files/" .. animal.type .. "/prev" .. animal.variation .. ".dds")
        local label = seexports.sGui:createGuiElement("label", 60, y, tw, 20, animalPanel)
        seexports.sGui:setLabelAlignment(label, "left", "center")
        seexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
        seexports.sGui:setLabelText(label, labels[1])
        local rect = seexports.sGui:createGuiElement("rectangle", 60 + tw, y + 5, pw, 10, animalPanel)
        seexports.sGui:setGuiBackground(rect, "solid", "sightgrey1")
        seexports.sGui:guiSetTooltip(rect, math.floor(animal.growth * 100 * 10) / 10 .. " %")
        seexports.sGui:setGuiHoverable(rect, true)
        seexports.sGui:setGuiHover(rect, "solid", "sightgrey1", false, true, false, true)
        local rect = seexports.sGui:createGuiElement("rectangle", 60 + tw, y + 5, pw * animal.growth, 10, animalPanel)
        seexports.sGui:setGuiBackground(rect, "solid", "sightgreen")
        local label = seexports.sGui:createGuiElement("label", 60 + w + 5, y, tw, 20, animalPanel)
        seexports.sGui:setLabelAlignment(label, "left", "center")
        seexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
        seexports.sGui:setLabelText(label, labels[2])
        local rect = seexports.sGui:createGuiElement("rectangle", 60 + w + 5 + tw, y + 5, pw, 10, animalPanel)
        seexports.sGui:setGuiBackground(rect, "solid", "sightgrey1")
        seexports.sGui:guiSetTooltip(rect, math.floor(animal.health * 100 * 10) / 10 .. " %")
        seexports.sGui:setGuiHoverable(rect, true)
        seexports.sGui:setGuiHover(rect, "solid", "sightgrey1", false, true, false, true)
        local rect = seexports.sGui:createGuiElement("rectangle", 60 + w + 5 + tw, y + 5, pw * animal.health, 10, animalPanel)
        if animal.health < 0.25 then
          seexports.sGui:setGuiBackground(rect, "solid", "sightred")
        elseif animal.health < 0.5 then
          seexports.sGui:setGuiBackground(rect, "solid", "sightorange")
        elseif animal.health < 0.75 then
          seexports.sGui:setGuiBackground(rect, "solid", "sightyellow")
        else
          seexports.sGui:setGuiBackground(rect, "solid", "sightgreen")
        end
        y = y + 20
        local label = seexports.sGui:createGuiElement("label", 60, y, tw, 20, animalPanel)
        seexports.sGui:setLabelAlignment(label, "left", "center")
        seexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
        seexports.sGui:setLabelText(label, labels[3])
        local rect = seexports.sGui:createGuiElement("rectangle", 60 + tw, y + 5, pw, 10, animalPanel)
        seexports.sGui:setGuiBackground(rect, "solid", "sightgrey1")
        seexports.sGui:guiSetTooltip(rect, math.floor(animal.fat * 100 * 10) / 10 .. " %")
        seexports.sGui:setGuiHoverable(rect, true)
        seexports.sGui:setGuiHover(rect, "solid", "sightgrey1", false, true, false, true)
        local rect = seexports.sGui:createGuiElement("rectangle", 60 + tw, y + 5, pw * animal.fat, 10, animalPanel)
        seexports.sGui:setGuiBackground(rect, "solid", "sightgreen")
        local label = seexports.sGui:createGuiElement("label", 60 + w + 5, y, tw, 20, animalPanel)
        seexports.sGui:setLabelAlignment(label, "left", "center")
        seexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
        seexports.sGui:setLabelText(label, labels[4])
        local rect = seexports.sGui:createGuiElement("rectangle", 60 + w + 5 + tw, y + 5, pw, 10, animalPanel)
        seexports.sGui:setGuiBackground(rect, "solid", "sightgrey1")
        seexports.sGui:guiSetTooltip(rect, math.floor(animal.mood * 100 * 10) / 10 .. " %")
        seexports.sGui:setGuiHoverable(rect, true)
        seexports.sGui:setGuiHover(rect, "solid", "sightgrey1", false, true, false, true)
        local rect = seexports.sGui:createGuiElement("rectangle", 60 + w + 5 + tw, y + 5, pw * animal.mood, 10, animalPanel)
        if animal.mood < 0.25 then
          seexports.sGui:setGuiBackground(rect, "solid", "sightred")
        elseif animal.mood < 0.5 then
          seexports.sGui:setGuiBackground(rect, "solid", "sightorange")
        elseif animal.mood < 0.75 then
          seexports.sGui:setGuiBackground(rect, "solid", "sightyellow")
        else
          seexports.sGui:setGuiBackground(rect, "solid", "sightgreen")
        end
        y = y + 20
        local label = seexports.sGui:createGuiElement("label", 60, y, tw, 20, animalPanel)
        seexports.sGui:setLabelAlignment(label, "left", "center")
        seexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
        seexports.sGui:setLabelText(label, labels[5])
        local prog = math.min(1, animal.life / animalTypes[animal.type].lifeExpectancy)
        local rect = seexports.sGui:createGuiElement("rectangle", 60 + tw, y + 5, pw, 10, animalPanel)
        seexports.sGui:setGuiBackground(rect, "solid", "sightgrey1")
        seexports.sGui:guiSetTooltip(rect, math.floor(prog * 100 * 10) / 10 .. " %")
        seexports.sGui:setGuiHoverable(rect, true)
        seexports.sGui:setGuiHover(rect, "solid", "sightgrey1", false, true, false, true)
        local rect = seexports.sGui:createGuiElement("rectangle", 60 + tw, y + 5, pw * prog, 10, animalPanel)
        if 0.7 < prog then
          seexports.sGui:setGuiBackground(rect, "solid", "sightred")
        elseif 0.6 < prog then
          seexports.sGui:setGuiBackground(rect, "solid", "sightyellow")
        else
          seexports.sGui:setGuiBackground(rect, "solid", "sightgreen")
        end
        local mood = math.min(1, math.max(0, 1 - animal.moodMinus))
        local label = seexports.sGui:createGuiElement("label", 60 + w + 5, y, tw, 20, animalPanel)
        seexports.sGui:setLabelAlignment(label, "left", "center")
        seexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
        seexports.sGui:setLabelText(label, labels[6])
        local rect = seexports.sGui:createGuiElement("rectangle", 60 + w + 5 + tw, y + 5, pw, 10, animalPanel)
        seexports.sGui:setGuiBackground(rect, "solid", "sightgrey1")
        seexports.sGui:guiSetTooltip(rect, math.floor(mood * 100 * 10) / 10 .. " %")
        seexports.sGui:setGuiHoverable(rect, true)
        seexports.sGui:setGuiHover(rect, "solid", "sightgrey1", false, true, false, true)
        local rect = seexports.sGui:createGuiElement("rectangle", 60 + w + 5 + tw, y + 5, pw * mood, 10, animalPanel)
        if mood < 0.25 then
          seexports.sGui:setGuiBackground(rect, "solid", "sightred")
        elseif mood < 0.5 then
          seexports.sGui:setGuiBackground(rect, "solid", "sightorange")
        elseif mood < 0.75 then
          seexports.sGui:setGuiBackground(rect, "solid", "sightyellow")
        else
          seexports.sGui:setGuiBackground(rect, "solid", "sightgreen")
        end
        y = y + 20 + 5
      end
    end
    if farmAnimalSellMode then
      local label = seexports.sGui:createGuiElement("label", 0, windowHeight - 105, windowWidth, 30, animalPanel)
      seexports.sGui:setLabelAlignment(label, "center", "center")
      seexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
      seexports.sGui:setLabelText(label, "Összesen: kb. " .. seexports.sGui:getColorCodeHex("sightgreen") .. seexports.sGui:thousandsStepper(animalSellSum) .. " $")
    end
    if canSellAnimals then
      local btn = seexports.sGui:createGuiElement("button", 5, windowHeight - 70, windowWidth - 10, 30, animalPanel)
      seexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
      seexports.sGui:setButtonTextColor(btn, "#ffffff")
      if farmAnimalSellMode then
        seexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
        seexports.sGui:setGuiHover(btn, "gradient", {
          "sightgreen",
          "sightgreen-second"
        }, false, true)
        seexports.sGui:setButtonText(btn, "Eladás")
        seexports.sGui:setClickEvent(btn, "finalFarmAnimalSell", false)
      else
        seexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
        seexports.sGui:setGuiHover(btn, "gradient", {
          "sightgreen",
          "sightgreen-second"
        }, false, true)
        seexports.sGui:setButtonText(btn, "Állatok eladása")
        seexports.sGui:setClickEvent(btn, "farmAnimalSellMode", false)
      end
    end
    local btn = seexports.sGui:createGuiElement("button", 5, windowHeight - 30 - 5, windowWidth - 10, 30, animalPanel)
    seexports.sGui:setGuiBackground(btn, "solid", "sightred")
    seexports.sGui:setGuiHover(btn, "gradient", {
      "sightred",
      "sightred-second"
    }, false, true)
    seexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
    seexports.sGui:setButtonTextColor(btn, "#ffffff")
    seexports.sGui:setButtonText(btn, "Bezárás")
    if farmAnimalSellMode then
      seexports.sGui:setClickEvent(btn, "farmAnimalSellMode", false)
    else
      seexports.sGui:setClickEvent(btn, "openAnimalPanel", false)
    end
  else
    local windowHeight = titleBarHeight + 48 + 30 + 5
    local windowWidth = 250
    animalPanel = seexports.sGui:createGuiElement("window", screenX / 2 - windowWidth / 2, screenY / 2 - windowHeight / 2, windowWidth, windowHeight)
    seexports.sGui:setWindowTitle(animalPanel, "16/BebasNeueRegular.otf", "SightMTA - Állatok")
    local label = seexports.sGui:createGuiElement("label", 0, titleBarHeight, windowWidth, 48, animalPanel)
    seexports.sGui:setLabelAlignment(label, "center", "center")
    seexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
    seexports.sGui:setLabelText(label, "Nincs egyetlen állatod sem!")
    local btn = seexports.sGui:createGuiElement("button", 5, windowHeight - 30 - 5, windowWidth - 10, 30, animalPanel)
    seexports.sGui:setGuiBackground(btn, "solid", "sightred")
    seexports.sGui:setGuiHover(btn, "gradient", {
      "sightred",
      "sightred-second"
    }, false, true)
    seexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
    seexports.sGui:setButtonTextColor(btn, "#ffffff")
    seexports.sGui:setButtonText(btn, "Bezárás")
    seexports.sGui:setClickEvent(btn, "openAnimalPanel", false)
  end
end
addEvent("openAnimalList", true)
addEventHandler("openAnimalList", getRootElement(), openAnimalList)
function animalBuyPanelRefresh()
  animalButtons = {}
  local titleBarHeight = seexports.sGui:getTitleBarHeight()
  if animalPanel then
    seexports.sGui:deleteGuiElement(animalPanel)
  end
  local windowHeight = titleBarHeight + 53 * animalOrderNums + 32 + 5 + 35 + 5 + 90 + 5 + 5
  local windowWidth = 450
  animalPanel = seexports.sGui:createGuiElement("window", screenX / 2 - windowWidth / 2, screenY / 2 - windowHeight / 2, windowWidth, windowHeight)
  seexports.sGui:setWindowTitle(animalPanel, "16/BebasNeueRegular.otf", "SightMTA - Mezőgazdasági nagyker")
  local y = titleBarHeight + 5
  local label = seexports.sGui:createGuiElement("label", 0, y, windowWidth, 24, animalPanel)
  seexports.sGui:setLabelAlignment(label, "center", "center")
  seexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
  seexports.sGui:setLabelText(label, "Farm férőhely:")
  local c = 0
  for i = 1, animalOrderNums do
    if animalOffers[selectedAnimalToBuy][i][4] then
      c = c + 1
    end
  end
  local currentSize = animalTypes[selectedAnimalToBuy].farmSlot
  local currentCount = 0
  for i = 1, #currentAnimals do
    currentCount = currentCount + animalTypes[currentAnimals[i].type].farmSlot
  end
  local pCurr = currentCount / farmSlots
  local pNew = pCurr + c * currentSize / farmSlots
  local rect = seexports.sGui:createGuiElement("rectangle", 5, y + 24 + 5, windowWidth - 10, 11, animalPanel)
  seexports.sGui:setGuiBackground(rect, "solid", "sightgrey1")
  seexports.sGui:guiSetTooltip(rect, currentCount + c * currentSize .. "/" .. farmSlots)
  seexports.sGui:setGuiHoverable(rect, true)
  seexports.sGui:setGuiHover(rect, "solid", "sightgrey1", false, true, false, true)
  local rect = seexports.sGui:createGuiElement("rectangle", 5, y + 24 + 5, (windowWidth - 10) * pNew, 11, animalPanel)
  if 1 < pNew + currentSize / 100 then
    seexports.sGui:setGuiBackground(rect, "solid", "sightred-second")
  else
    seexports.sGui:setGuiBackground(rect, "solid", "sightblue")
  end
  local rect = seexports.sGui:createGuiElement("rectangle", 5, y + 24 + 5, (windowWidth - 10) * pCurr, 11, animalPanel)
  if 1 < pNew + currentSize / 100 then
    seexports.sGui:setGuiBackground(rect, "solid", "sightred")
  else
    seexports.sGui:setGuiBackground(rect, "solid", "sightgreen")
  end
  y = y + 40 + 5
  local label = seexports.sGui:createGuiElement("label", 0, y, windowWidth, 24, animalPanel)
  seexports.sGui:setLabelAlignment(label, "center", "center")
  seexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
  seexports.sGui:setLabelText(label, "Utánfutó férőhely:")
  local rect = seexports.sGui:createGuiElement("rectangle", 5, y + 24 + 5, windowWidth - 10, 11, animalPanel)
  seexports.sGui:setGuiBackground(rect, "solid", "sightgrey1")
  local pTrailer = 0
  local pTrailerNew = 0
  if selectedAnimalToBuy and 0 < c then
    seexports.sGui:guiSetTooltip(rect, c .. "/" .. #animalTrailerPoses[selectedAnimalToBuy][0])
    seexports.sGui:setGuiHoverable(rect, true)
    seexports.sGui:setGuiHover(rect, "solid", "sightgrey1", false, true, false, true)
    pTrailer = c / #animalTrailerPoses[selectedAnimalToBuy][0]
    pTrailerNew = (c + 1) / #animalTrailerPoses[selectedAnimalToBuy][0]
    local rect = seexports.sGui:createGuiElement("rectangle", 5, y + 24 + 5, (windowWidth - 10) * pTrailer, 11, animalPanel)
    if 1 < pTrailerNew then
      seexports.sGui:setGuiBackground(rect, "solid", "sightred")
    else
      seexports.sGui:setGuiBackground(rect, "solid", "sightgreen")
    end
  end
  y = y + 40 + 5 + 5
  local pbw = false
  local w = false
  local priceSum = 0
  for i = 1, animalOrderNums do
    local border = seexports.sGui:createGuiElement("hr", 5, y - 1, windowWidth - 10, 2, animalPanel)
    local item = seexports.sGui:createGuiElement("image", 5, y + 5, 43, 43, animalPanel)
    seexports.sGui:setImageDDS(item, ":sFarm/files/" .. selectedAnimalToBuy .. "/prev" .. animalOffers[selectedAnimalToBuy][i][3] .. ".dds")
    local label = seexports.sGui:createGuiElement("label", 53, y + 5, windowWidth, 21.5, animalPanel)
    seexports.sGui:setLabelAlignment(label, "left", "center")
    seexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
    seexports.sGui:setLabelText(label, "Növekedés:")
    if not pbw then
      w = seexports.sGui:getLabelTextWidth(label)
    end
    local label = seexports.sGui:createGuiElement("label", 53, y + 5 + 21.5, windowWidth, 21.5, animalPanel)
    seexports.sGui:setLabelAlignment(label, "left", "center")
    seexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
    seexports.sGui:setLabelText(label, "Súly:")
    if not pbw then
      local w2 = seexports.sGui:getLabelTextWidth(label)
      w = math.max(w, w2)
      pbw = windowWidth - 10 - 48 - w - 5 - 100 - 5 - 75
    end
    local rect = seexports.sGui:createGuiElement("rectangle", 53 + w + 5, y + 5 + 5, pbw, 11.5, animalPanel)
    seexports.sGui:setGuiBackground(rect, "solid", "sightgrey1")
    seexports.sGui:guiSetTooltip(rect, math.floor(100 * animalOffers[selectedAnimalToBuy][i][1]) .. "%")
    seexports.sGui:setGuiHoverable(rect, true)
    seexports.sGui:setGuiHover(rect, "solid", "sightgrey1", false, true, false, true)
    local rect = seexports.sGui:createGuiElement("rectangle", 53 + w + 5, y + 5 + 5, pbw * animalOffers[selectedAnimalToBuy][i][1], 11.5, animalPanel)
    seexports.sGui:setGuiBackground(rect, "solid", "sightgreen")
    local rect = seexports.sGui:createGuiElement("rectangle", 53 + w + 5, y + 5 + 21.5 + 5, pbw, 11.5, animalPanel)
    seexports.sGui:setGuiBackground(rect, "solid", "sightgrey1")
    seexports.sGui:guiSetTooltip(rect, math.floor(100 * animalOffers[selectedAnimalToBuy][i][2]) .. "%")
    seexports.sGui:setGuiHoverable(rect, true)
    seexports.sGui:setGuiHover(rect, "solid", "sightgrey1", false, true, false, true)
    local rect = seexports.sGui:createGuiElement("rectangle", 53 + w + 5, y + 5 + 21.5 + 5, pbw * animalOffers[selectedAnimalToBuy][i][2], 11.5, animalPanel)
    seexports.sGui:setGuiBackground(rect, "solid", "sightgreen")
    local label = seexports.sGui:createGuiElement("label", windowWidth - 5 - 100 - 75, y + 5, 75, 43, animalPanel)
    seexports.sGui:setLabelAlignment(label, "center", "center")
    seexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
    seexports.sGui:setLabelText(label, seexports.sGui:thousandsStepper(animalOffers[selectedAnimalToBuy][i][5]) .. " $")
    if 1 >= pNew + currentSize / 100 and pTrailerNew <= 1 or animalOffers[selectedAnimalToBuy][i][4] then
      local btn = seexports.sGui:createGuiElement("button", windowWidth - 5 - 100, y + 5 + 21.5 - 15, 100, 30, animalPanel)
      seexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
      seexports.sGui:setButtonTextColor(btn, "#ffffff")
      seexports.sGui:setClickEvent(btn, "selectFarmAnimal", false)
      if animalOffers[selectedAnimalToBuy][i][4] then
        seexports.sGui:setGuiBackground(btn, "solid", "sightred")
        seexports.sGui:setGuiHover(btn, "gradient", {
          "sightred",
          "sightred-second"
        }, false, true)
        seexports.sGui:setButtonText(btn, "Eltávolítás")
        priceSum = priceSum + animalOffers[selectedAnimalToBuy][i][5]
      else
        seexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
        seexports.sGui:setGuiHover(btn, "gradient", {
          "sightgreen",
          "sightgreen-second"
        }, false, true)
        seexports.sGui:setButtonText(btn, "Kiválasztás")
      end
      animalButtons[btn] = i
    else
      local btn = seexports.sGui:createGuiElement("label", windowWidth - 5 - 100, y + 5 + 21.5 - 15, 100, 30, animalPanel)
      seexports.sGui:setLabelAlignment(btn, "center", "center")
      seexports.sGui:setLabelFont(btn, "11/Ubuntu-L.ttf")
      seexports.sGui:setLabelText(btn, "Nincs hely!")
    end
    y = y + 48 + 5
  end
  local border = seexports.sGui:createGuiElement("hr", 5, y - 1, windowWidth - 10, 2, animalPanel)
  local label = seexports.sGui:createGuiElement("label", 0, y + 5, windowWidth, 27, animalPanel)
  seexports.sGui:setLabelAlignment(label, "center", "center")
  seexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
  seexports.sGui:setLabelText(label, "Összesen: " .. seexports.sGui:getColorCodeHex("sightgreen") .. seexports.sGui:thousandsStepper(priceSum) .. " $")
  if 0 < c then
    local btn = seexports.sGui:createGuiElement("button", 5, windowHeight - 30 - 5, (windowWidth - 15) / 2, 30, animalPanel)
    seexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
    seexports.sGui:setGuiHover(btn, "gradient", {
      "sightgreen",
      "sightgreen-second"
    }, false, true)
    seexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
    seexports.sGui:setButtonTextColor(btn, "#ffffff")
    seexports.sGui:setButtonText(btn, "Megrendelés")
    seexports.sGui:setClickEvent(btn, "confirmAnimalBuy", false)
    local btn = seexports.sGui:createGuiElement("button", 5 + (windowWidth - 15) / 2 + 5, windowHeight - 30 - 5, (windowWidth - 15) / 2, 30, animalPanel)
    seexports.sGui:setGuiBackground(btn, "solid", "sightred")
    seexports.sGui:setGuiHover(btn, "gradient", {
      "sightred",
      "sightred-second"
    }, false, true)
    seexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
    seexports.sGui:setButtonTextColor(btn, "#ffffff")
    seexports.sGui:setButtonText(btn, "Bezárás")
    seexports.sGui:setClickEvent(btn, "selectFarmAnimalPanel", false)
  else
    local btn = seexports.sGui:createGuiElement("button", 5, windowHeight - 30 - 5, windowWidth - 10, 30, animalPanel)
    seexports.sGui:setGuiBackground(btn, "solid", "sightred")
    seexports.sGui:setGuiHover(btn, "gradient", {
      "sightred",
      "sightred-second"
    }, false, true)
    seexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
    seexports.sGui:setButtonTextColor(btn, "#ffffff")
    seexports.sGui:setButtonText(btn, "Bezárás")
    seexports.sGui:setClickEvent(btn, "selectFarmAnimalPanel", false)
  end
end
addEvent("selectFarmAnimal", true)
addEventHandler("selectFarmAnimal", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  animalOffers[selectedAnimalToBuy][animalButtons[el]][4] = not animalOffers[selectedAnimalToBuy][animalButtons[el]][4]
  animalBuyPanelRefresh()
end)
addEvent("buyFarmAnimalPanel", true)
addEventHandler("buyFarmAnimalPanel", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  selectedAnimalToBuy = animalTypeButtons[el]
  for i = 1, animalOrderNums do
    animalOffers[selectedAnimalToBuy][i][4] = false
  end
  animalBuyPanelRefresh()
end)
addEvent("selectFarmAnimalPanel", true)
addEventHandler("selectFarmAnimalPanel", getRootElement(), function()
  local titleBarHeight = seexports.sGui:getTitleBarHeight()
  if animalPanel then
    seexports.sGui:deleteGuiElement(animalPanel)
  end
  local windowHeight = titleBarHeight + 35 + 5
  local windowWidth = 300
  animalPanel = seexports.sGui:createGuiElement("window", screenX / 2 - windowWidth / 2, screenY / 2 - windowHeight / 2, windowWidth, windowHeight)
  seexports.sGui:setWindowTitle(animalPanel, "16/BebasNeueRegular.otf", "SightMTA - Mezőgazdasági nagyker")
  local y = titleBarHeight + 5
  local c = 1
  for k, v in pairs(animalTypes) do
    local btn = seexports.sGui:createGuiElement("button", 5, y, windowWidth - 10, 30, animalPanel)
    seexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
    seexports.sGui:setGuiHover(btn, "gradient", {
      "sightgreen",
      "sightgreen-second"
    }, false, true)
    seexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
    seexports.sGui:setButtonTextColor(btn, "#ffffff")
    seexports.sGui:setButtonText(btn, v.name)
    seexports.sGui:setClickEvent(btn, "buyFarmAnimalPanel", false)
    animalTypeButtons[btn] = k
    c = c + 1
    y = y + 30 + 5
  end
  windowHeight = titleBarHeight + 35 * c + 5
  seexports.sGui:setGuiPosition(animalPanel, screenX / 2 - windowWidth / 2, screenY / 2 - windowHeight / 2)
  seexports.sGui:setGuiSize(animalPanel, windowWidth, windowHeight)
  local btn = seexports.sGui:createGuiElement("button", 5, windowHeight - 30 - 5, windowWidth - 10, 30, animalPanel)
  seexports.sGui:setGuiBackground(btn, "solid", "sightred")
  seexports.sGui:setGuiHover(btn, "gradient", {
    "sightred",
    "sightred-second"
  }, false, true)
  seexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
  seexports.sGui:setButtonTextColor(btn, "#ffffff")
  seexports.sGui:setButtonText(btn, "Bezárás")
  seexports.sGui:setClickEvent(btn, "openShopPanel", false)
end)
addEvent("openShopPanel", true)
addEventHandler("openShopPanel", getRootElement(), function(order)
  checkingOrder = false
  local titleBarHeight = seexports.sGui:getTitleBarHeight()
  if animalPanel then
    seexports.sGui:deleteGuiElement(animalPanel)
  end
  local windowHeight, windowWidth = 0, 0
  if type(order) == "table" then
    windowHeight = titleBarHeight + 70 + 5 + 48
    windowWidth = 300
    animalPanel = seexports.sGui:createGuiElement("window", screenX / 2 - windowWidth / 2, screenY / 2 - windowHeight / 2, windowWidth, windowHeight)
    if order[1] == "sellAnimal" then
      seexports.sGui:setWindowTitle(animalPanel, "16/BebasNeueRegular.otf", "SightMTA - Vágóhíd")
    else
      seexports.sGui:setWindowTitle(animalPanel, "16/BebasNeueRegular.otf", "SightMTA - Mezőgazdasági nagyker")
    end
    local label = seexports.sGui:createGuiElement("label", 0, titleBarHeight, windowWidth, 48, animalPanel)
    seexports.sGui:setLabelAlignment(label, "center", "center")
    seexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
    seexports.sGui:setLabelText(label, "Jelenleg rendelés van folyamatban...")
    if order[1] == "hay" then
      seexports.sGui:setLabelText(label, "Jelenlegi rendelés: " .. seexports.sGui:getColorCodeHex("sightgreen") .. "szalma\n#ffffffMennyiség:" .. seexports.sGui:getColorCodeHex("sightgreen") .. " " .. order[2] .. " bála")
    elseif order[1] == "otherFood" then
      seexports.sGui:setLabelText(label, "Jelenlegi rendelés: " .. seexports.sGui:getColorCodeHex("sightgreen") .. "pellet táp\n#ffffffMennyiség:" .. seexports.sGui:getColorCodeHex("sightgreen") .. " " .. order[2] .. " zsák")
    elseif order[1] == "chickenFood" then
      seexports.sGui:setLabelText(label, "Jelenlegi rendelés: " .. seexports.sGui:getColorCodeHex("sightgreen") .. "csirketáp\n#ffffffMennyiség:" .. seexports.sGui:getColorCodeHex("sightgreen") .. " " .. order[2] .. " zsák")
    elseif order[1] == "sellAnimal" then
      seexports.sGui:setLabelText(label, "Jelenleg " .. seexports.sGui:getColorCodeHex("sightgreen") .. order[2][2] .. " db " .. utf8.lower(animalTypes[order[2][1]].name) .. "#ffffff eladása\nfolyamatban.")
    elseif order[1] == "animal" then
      refreshAnimalOffers()
      seexports.sGui:setLabelText(label, "Jelenlegi rendelés: " .. seexports.sGui:getColorCodeHex("sightgreen") .. animalTypes[order[2][1]].name .. [[

#ffffff]] .. seexports.sGui:getColorCodeHex("sightgreen") .. " " .. #order[2][2] .. " db")
    end
    if order[3] then
      local label = seexports.sGui:createGuiElement("label", 0, titleBarHeight + 48 + 5, windowWidth, 30, animalPanel)
      seexports.sGui:setLabelAlignment(label, "center", "center")
      seexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
      seexports.sGui:setLabelText(label, "Kiszállítás alatt!")
      seexports.sGui:setLabelColor(label, "sightgreen")
    else
      local btn = seexports.sGui:createGuiElement("button", 5, titleBarHeight + 48 + 5, windowWidth - 10, 30, animalPanel)
      seexports.sGui:setGuiBackground(btn, "solid", "sightred")
      seexports.sGui:setGuiHover(btn, "gradient", {
        "sightred",
        "sightred-second"
      }, false, true)
      seexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
      seexports.sGui:setButtonTextColor(btn, "#ffffff")
      if order[1] == "sellAnimal" then
        seexports.sGui:setButtonText(btn, "Mégsem adom el")
      else
        seexports.sGui:setButtonText(btn, "Rendelés lemondása")
      end
      seexports.sGui:setClickEvent(btn, "cancelOrder", false)
    end
  else
    windowHeight = titleBarHeight + 175 + 5
    windowWidth = 300
    animalPanel = seexports.sGui:createGuiElement("window", screenX / 2 - windowWidth / 2, screenY / 2 - windowHeight / 2, windowWidth, windowHeight)
    seexports.sGui:setWindowTitle(animalPanel, "16/BebasNeueRegular.otf", "SightMTA - Mezőgazdasági nagyker")
    local y = titleBarHeight + 5
    local btn = seexports.sGui:createGuiElement("button", 5, y, windowWidth - 10, 30, animalPanel)
    seexports.sGui:setGuiBackground(btn, "solid", "sightblue")
    seexports.sGui:setGuiHover(btn, "gradient", {
      "sightblue",
      "sightblue-second"
    }, false, true)
    seexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
    seexports.sGui:setButtonTextColor(btn, "#ffffff")
    seexports.sGui:setButtonText(btn, "Állatok")
    seexports.sGui:setClickEvent(btn, "selectFarmAnimalPanel", false)
    y = y + 30 + 5
    local btn = seexports.sGui:createGuiElement("button", 5, y, windowWidth - 10, 30, animalPanel)
    seexports.sGui:setGuiBackground(btn, "solid", "sightyellow")
    seexports.sGui:setGuiHover(btn, "gradient", {
      "sightyellow",
      "sightyellow-second"
    }, false, true)
    seexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
    seexports.sGui:setButtonTextColor(btn, "#ffffff")
    seexports.sGui:setButtonText(btn, "Szalma")
    seexports.sGui:setClickEvent(btn, "buyHayPanel", false)
    y = y + 30 + 5
    local btn = seexports.sGui:createGuiElement("button", 5, y, windowWidth - 10, 30, animalPanel)
    seexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
    seexports.sGui:setGuiHover(btn, "gradient", {
      "sightgreen",
      "sightgreen-second"
    }, false, true)
    seexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
    seexports.sGui:setButtonTextColor(btn, "#ffffff")
    seexports.sGui:setButtonText(btn, "Pellet táp")
    seexports.sGui:setClickEvent(btn, "buyOtherFoodPanel", false)
    y = y + 30 + 5
    local btn = seexports.sGui:createGuiElement("button", 5, y, windowWidth - 10, 30, animalPanel)
    seexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
    seexports.sGui:setGuiHover(btn, "gradient", {
      "sightgreen",
      "sightgreen-second"
    }, false, true)
    seexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
    seexports.sGui:setButtonTextColor(btn, "#ffffff")
    seexports.sGui:setButtonText(btn, "Csirketáp")
    seexports.sGui:setClickEvent(btn, "buyChickenFoodPanel", false)
  end
  local btn = seexports.sGui:createGuiElement("button", 5, windowHeight - 30 - 5, windowWidth - 10, 30, animalPanel)
  seexports.sGui:setGuiBackground(btn, "solid", "sightred")
  seexports.sGui:setGuiHover(btn, "gradient", {
    "sightred",
    "sightred-second"
  }, false, true)
  seexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
  seexports.sGui:setButtonTextColor(btn, "#ffffff")
  seexports.sGui:setButtonText(btn, "Bezárás")
  seexports.sGui:setClickEvent(btn, "openAnimalPanel", false)
end)
addEvent("openStatsPage", true)
addEventHandler("openStatsPage", getRootElement(), function()
  local titleBarHeight = seexports.sGui:getTitleBarHeight()
  local windowHeight = titleBarHeight + 135 + 5 + 30 + 5 + 30
  local windowWidth = 500
  if animalPanel then
    seexports.sGui:deleteGuiElement(animalPanel)
  end
  animalPanel = seexports.sGui:createGuiElement("window", screenX / 2 - windowWidth / 2, screenY / 2 - windowHeight / 2, windowWidth, windowHeight)
  seexports.sGui:setWindowTitle(animalPanel, "16/BebasNeueRegular.otf", "SightMTA - Farm állapot")
  local y = titleBarHeight + 5
  local label = seexports.sGui:createGuiElement("label", 0, y, windowWidth / 2, 24, animalPanel)
  seexports.sGui:setLabelAlignment(label, "center", "center")
  seexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
  seexports.sGui:setLabelText(label, "Itató:")
  local prog = currentAnimalFood.otherWater / 255
  local rect = seexports.sGui:createGuiElement("rectangle", 10, y + 24 + 5, windowWidth / 2 - 15, 11, animalPanel)
  seexports.sGui:setGuiBackground(rect, "solid", "sightgrey1")
  if currentAnimalFood.hourlyWater and 0 < currentAnimalFood.hourlyWater then
    local hour = currentAnimalFood.otherWater / currentAnimalFood.hourlyWater
    if hour < 1 then
      seexports.sGui:guiSetTooltip(rect, "Kb. " .. math.floor(hour * 60 + 0.5) .. " percre elegendő")
    else
      seexports.sGui:guiSetTooltip(rect, "Kb. " .. math.floor(hour + 0.5) .. " órára elegendő")
    end
    seexports.sGui:setGuiHoverable(rect, true)
    seexports.sGui:setGuiHover(rect, "solid", "sightgrey1", false, true, false, true)
  end
  local rect = seexports.sGui:createGuiElement("rectangle", 10, y + 24 + 5, (windowWidth / 2 - 15) * prog, 11, animalPanel)
  seexports.sGui:setGuiBackground(rect, "solid", "sightblue")
  local label = seexports.sGui:createGuiElement("label", windowWidth / 2, y, windowWidth / 2, 24, animalPanel)
  seexports.sGui:setLabelAlignment(label, "center", "center")
  seexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
  seexports.sGui:setLabelText(label, "Etető:")
  local prog = currentAnimalFood.otherFood / 255
  local rect = seexports.sGui:createGuiElement("rectangle", windowWidth / 2 + 5, y + 24 + 5, windowWidth / 2 - 15, 11, animalPanel)
  seexports.sGui:setGuiBackground(rect, "solid", "sightgrey1")
  if currentAnimalFood.hourlyFood and 0 < currentAnimalFood.hourlyFood then
    local hour = currentAnimalFood.otherFood / currentAnimalFood.hourlyFood
    if hour < 1 then
      seexports.sGui:guiSetTooltip(rect, "Kb. " .. math.floor(hour * 60) .. " percre elegendő")
    else
      seexports.sGui:guiSetTooltip(rect, "Kb. " .. math.floor(hour) .. " órára elegendő")
    end
    seexports.sGui:setGuiHoverable(rect, true)
    seexports.sGui:setGuiHover(rect, "solid", "sightgrey1", false, true, false, true)
  end
  local rect = seexports.sGui:createGuiElement("rectangle", windowWidth / 2 + 5, y + 24 + 5, (windowWidth / 2 - 15) * prog, 11, animalPanel)
  seexports.sGui:setGuiBackground(rect, "solid", "sightyellow")
  y = y + 40 + 5
  local border = seexports.sGui:createGuiElement("hr", 5, y + 5 - 1, windowWidth - 10, 2, animalPanel)
  y = y + 10
  local label = seexports.sGui:createGuiElement("label", 0, y, windowWidth / 2, 24, animalPanel)
  seexports.sGui:setLabelAlignment(label, "center", "center")
  seexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
  seexports.sGui:setLabelText(label, "Csirke itató:")
  local prog = currentAnimalFood.chickenWater / 255
  local rect = seexports.sGui:createGuiElement("rectangle", 10, y + 24 + 5, windowWidth / 2 - 15, 11, animalPanel)
  seexports.sGui:setGuiBackground(rect, "solid", "sightgrey1")
  if currentAnimalFood.hourlyWaterChick and 0 < currentAnimalFood.hourlyWaterChick then
    local hour = currentAnimalFood.chickenWater / currentAnimalFood.hourlyWaterChick
    if hour < 1 then
      seexports.sGui:guiSetTooltip(rect, "Kb. " .. math.floor(hour * 60) .. " percre elegendő")
    else
      seexports.sGui:guiSetTooltip(rect, "Kb. " .. math.floor(hour) .. " órára elegendő")
    end
    seexports.sGui:setGuiHoverable(rect, true)
    seexports.sGui:setGuiHover(rect, "solid", "sightgrey1", false, true, false, true)
  end
  local rect = seexports.sGui:createGuiElement("rectangle", 10, y + 24 + 5, (windowWidth / 2 - 15) * prog, 11, animalPanel)
  seexports.sGui:setGuiBackground(rect, "solid", "sightblue")
  local label = seexports.sGui:createGuiElement("label", windowWidth / 2, y, windowWidth / 2, 24, animalPanel)
  seexports.sGui:setLabelAlignment(label, "center", "center")
  seexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
  seexports.sGui:setLabelText(label, "Csirke etető:")
  local prog = currentAnimalFood.chickenFood / 255
  local rect = seexports.sGui:createGuiElement("rectangle", windowWidth / 2 + 5, y + 24 + 5, windowWidth / 2 - 15, 11, animalPanel)
  seexports.sGui:setGuiBackground(rect, "solid", "sightgrey1")
  if currentAnimalFood.hourlyFoodChick and 0 < currentAnimalFood.hourlyFoodChick then
    local hour = currentAnimalFood.chickenFood / currentAnimalFood.hourlyFoodChick
    if hour < 1 then
      seexports.sGui:guiSetTooltip(rect, "Kb. " .. math.floor(hour * 60) .. " percre elegendő")
    else
      seexports.sGui:guiSetTooltip(rect, "Kb. " .. math.floor(hour) .. " órára elegendő")
    end
    seexports.sGui:setGuiHoverable(rect, true)
    seexports.sGui:setGuiHover(rect, "solid", "sightgrey1", false, true, false, true)
  end
  local rect = seexports.sGui:createGuiElement("rectangle", windowWidth / 2 + 5, y + 24 + 5, (windowWidth / 2 - 15) * prog, 11, animalPanel)
  seexports.sGui:setGuiBackground(rect, "solid", "sightyellow")
  y = y + 40 + 5
  local border = seexports.sGui:createGuiElement("hr", 5, y + 5 - 1, windowWidth - 10, 2, animalPanel)
  y = y + 10
  local dirt = 0
  local c = 0
  for x = 1, farmSizeDetails[currentSize].size[1] do
    for y = 1, farmSizeDetails[currentSize].size[2] do
      local d = landData[x][y].dirt or 0
      dirt = dirt + d
      c = c + 1
    end
  end
  dirt = 1 - dirt / c / 255
  local label = seexports.sGui:createGuiElement("label", 0, y, windowWidth, 24, animalPanel)
  seexports.sGui:setLabelAlignment(label, "center", "center")
  seexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
  seexports.sGui:setLabelText(label, "Tisztaság:")
  local rect = seexports.sGui:createGuiElement("rectangle", 10, y + 24 + 5, windowWidth - 20, 11, animalPanel)
  seexports.sGui:setGuiBackground(rect, "solid", "sightgrey1")
  seexports.sGui:guiSetTooltip(rect, math.floor(dirt * 100 + 0.5) .. " %")
  seexports.sGui:setGuiHoverable(rect, true)
  seexports.sGui:setGuiHover(rect, "solid", "sightgrey1", false, true, false, true)
  local rect = seexports.sGui:createGuiElement("rectangle", 10, y + 24 + 5, (windowWidth - 20) * dirt, 11, animalPanel)
  if dirt < 0.5 then
    seexports.sGui:setGuiBackground(rect, "solid", "sightred")
  elseif dirt < 0.65 then
    seexports.sGui:setGuiBackground(rect, "solid", "sightyellow")
  else
    seexports.sGui:setGuiBackground(rect, "solid", "sightgreen")
  end
  y = y + 40 + 5
  local border = seexports.sGui:createGuiElement("hr", 5, y + 5 - 1, windowWidth - 10, 2, animalPanel)
  y = y + 10
  local btn = seexports.sGui:createGuiElement("button", 5, windowHeight - 30 - 5, windowWidth - 10, 30, animalPanel)
  seexports.sGui:setGuiBackground(btn, "solid", "sightred")
  seexports.sGui:setGuiHover(btn, "gradient", {
    "sightred",
    "sightred-second"
  }, false, true)
  seexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
  seexports.sGui:setButtonTextColor(btn, "#ffffff")
  seexports.sGui:setButtonText(btn, "Bezárás")
  seexports.sGui:setClickEvent(btn, "openAnimalPanel", false)
end)
function openAnimalPanel()
  animalHoverBox = false
  if scrollHandled then
    scrollHandled = false
    removeEventHandler("onClientKey", getRootElement(), scrollHandler)
  end
  local titleBarHeight = seexports.sGui:getTitleBarHeight()
  local btns = canBuyAnimals and 4 or 3
  if isOwner then
    btns = btns + 1
  end
  local windowHeight = titleBarHeight + 35 * btns + 5
  local windowWidth = 250
  if animalPanel then
    seexports.sGui:deleteGuiElement(animalPanel)
  end
  farmAnimalSellMode = false
  animalPanel = seexports.sGui:createGuiElement("window", screenX / 2 - windowWidth / 2, screenY / 2 - windowHeight / 2, windowWidth, windowHeight)
  seexports.sGui:setWindowTitle(animalPanel, "16/BebasNeueRegular.otf", "SightMTA - Állattartás")
  local y = titleBarHeight + 5
  local btn = seexports.sGui:createGuiElement("button", 5, y, windowWidth - 10, 30, animalPanel)
  seexports.sGui:setGuiBackground(btn, "solid", "sightblue")
  seexports.sGui:setGuiHover(btn, "gradient", {
    "sightblue",
    "sightblue-second"
  }, false, true)
  seexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
  seexports.sGui:setButtonTextColor(btn, "#ffffff")
  seexports.sGui:setButtonText(btn, "Állatok")
  seexports.sGui:setClickEvent(btn, "openAnimalList", false)
  y = y + 30 + 5
  local btn = seexports.sGui:createGuiElement("button", 5, y, windowWidth - 10, 30, animalPanel)
  seexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
  seexports.sGui:setGuiHover(btn, "gradient", {
    "sightgreen",
    "sightgreen-second"
  }, false, true)
  seexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
  seexports.sGui:setButtonTextColor(btn, "#ffffff")
  seexports.sGui:setButtonText(btn, "Farm állapot")
  seexports.sGui:setClickEvent(btn, "openStatsPage", false)
  if isOwner then
    y = y + 30 + 5
    local btn = seexports.sGui:createGuiElement("button", 5, y, windowWidth - 10, 30, animalPanel)
    seexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
    seexports.sGui:setGuiHover(btn, "gradient", {
      "sightgreen",
      "sightgreen-second"
    }, false, true)
    seexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
    seexports.sGui:setButtonTextColor(btn, "#ffffff")
    seexports.sGui:setButtonText(btn, "Eszközök visszaállítása")
    seexports.sGui:setClickEvent(btn, "resetToolsPrompt", false)
  end
  if canBuyAnimals then
    y = y + 30 + 5
    local btn = seexports.sGui:createGuiElement("button", 5, y, windowWidth - 10, 30, animalPanel)
    seexports.sGui:setGuiBackground(btn, "solid", "sightorange")
    seexports.sGui:setGuiHover(btn, "gradient", {
      "sightorange",
      "sightorange-second"
    }, false, true)
    seexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
    seexports.sGui:setButtonTextColor(btn, "#ffffff")
    seexports.sGui:setButtonText(btn, "Mezőgazdasági nagyker")
    seexports.sGui:setClickEvent(btn, "openShopPanelEx", false)
  end
  local btn = seexports.sGui:createGuiElement("button", 5, windowHeight - 30 - 5, windowWidth - 10, 30, animalPanel)
  seexports.sGui:setGuiBackground(btn, "solid", "sightred")
  seexports.sGui:setGuiHover(btn, "gradient", {
    "sightred",
    "sightred-second"
  }, false, true)
  seexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
  seexports.sGui:setButtonTextColor(btn, "#ffffff")
  seexports.sGui:setButtonText(btn, "Bezárás")
  seexports.sGui:setClickEvent(btn, "closeAnimalPanel", false)
end
addEvent("openAnimalPanel", true)
addEventHandler("openAnimalPanel", getRootElement(), openAnimalPanel)
local stripe, whiteText
function renderLoadPoint()
  local b = 0.075
  for i = 1, #shopLoadPos do
    local w = shopLoadPos[i][3] - shopLoadPos[i][1]
    local x = shopLoadPos[i][1] + w / 2
    local y1 = shopLoadPos[i][2]
    local y2 = shopLoadPos[i][4]
    local h = y2 - y1
    local yc = y1 + h / 2
    local z = shopLoadPos[i][5]
    if loadingOrder and loadingOrderCol == i then
      local c = tocolor(215, 89, 89)
      local els = getElementsWithinColShape(shopLoadCol[i], "vehicle")
      for j = 1, #els do
        if getElementModel(els[j]) == 611 then
          c = tocolor(green[1], green[2], green[3])
          break
        end
      end
      seelangStaticImageUsed[9] = true
      if seelangStaticImageToc[9] then
        processSeelangStaticImage[9]()
      end
      dxDrawMaterialSectionLine3D(x, y1 + b * 2, z, x, y2 - b * 2, z, 0, 0, 64 * (w - b * 4) * 1.5, 64 * (h - b * 4) * 1.5, seelangStaticImage[9], w - b * 4, c, x, yc, z + 1)
      seelangStaticImageUsed[10] = true
      if seelangStaticImageToc[10] then
        processSeelangStaticImage[10]()
      end
      dxDrawMaterialLine3D(shopLoadPos[i][1], y1 + b, z, shopLoadPos[i][3], y1 + b, z, seelangStaticImage[10], b * 2, c, shopLoadPos[i][1] + w / 2, y1 + b, z + 1)
      seelangStaticImageUsed[10] = true
      if seelangStaticImageToc[10] then
        processSeelangStaticImage[10]()
      end
      dxDrawMaterialLine3D(shopLoadPos[i][1], y2 - b, z, shopLoadPos[i][3], y2 - b, z, seelangStaticImage[10], b * 2, c, shopLoadPos[i][1] + w / 2, y2 - b, z + 1)
      seelangStaticImageUsed[10] = true
      if seelangStaticImageToc[10] then
        processSeelangStaticImage[10]()
      end
      dxDrawMaterialLine3D(shopLoadPos[i][1] + b, y1, z, shopLoadPos[i][1] + b, y2, z, seelangStaticImage[10], b * 2, c, shopLoadPos[i][1] + b, y1 + h / 2, z + 1)
      seelangStaticImageUsed[10] = true
      if seelangStaticImageToc[10] then
        processSeelangStaticImage[10]()
      end
      dxDrawMaterialLine3D(shopLoadPos[i][3] - b, y1, z, shopLoadPos[i][3] - b, y2, z, seelangStaticImage[10], b * 2, c, shopLoadPos[i][3] - b, y1 + h / 2, z + 1)
    else
      local c = tocolor(255, 255, 255)
      seelangStaticImageUsed[9] = true
      if seelangStaticImageToc[9] then
        processSeelangStaticImage[9]()
      end
      dxDrawMaterialSectionLine3D(x, y1 + b * 2, z, x, y2 - b * 2, z, 0, 0, 64 * (w - b * 4) * 1.5, 64 * (h - b * 4) * 1.5, seelangStaticImage[9], w - b * 4, c, x, yc, z + 1)
      seelangStaticImageUsed[10] = true
      if seelangStaticImageToc[10] then
        processSeelangStaticImage[10]()
      end
      dxDrawMaterialLine3D(shopLoadPos[i][1], y1 + b, z, shopLoadPos[i][3], y1 + b, z, seelangStaticImage[10], b * 2, c, shopLoadPos[i][1] + w / 2, y1 + b, z + 1)
      seelangStaticImageUsed[10] = true
      if seelangStaticImageToc[10] then
        processSeelangStaticImage[10]()
      end
      dxDrawMaterialLine3D(shopLoadPos[i][1], y2 - b, z, shopLoadPos[i][3], y2 - b, z, seelangStaticImage[10], b * 2, c, shopLoadPos[i][1] + w / 2, y2 - b, z + 1)
      seelangStaticImageUsed[10] = true
      if seelangStaticImageToc[10] then
        processSeelangStaticImage[10]()
      end
      dxDrawMaterialLine3D(shopLoadPos[i][1] + b, y1, z, shopLoadPos[i][1] + b, y2, z, seelangStaticImage[10], b * 2, c, shopLoadPos[i][1] + b, y1 + h / 2, z + 1)
      seelangStaticImageUsed[10] = true
      if seelangStaticImageToc[10] then
        processSeelangStaticImage[10]()
      end
      dxDrawMaterialLine3D(shopLoadPos[i][3] - b, y1, z, shopLoadPos[i][3] - b, y2, z, seelangStaticImage[10], b * 2, c, shopLoadPos[i][3] - b, y1 + h / 2, z + 1)
    end
  end
end
addEventHandler("onClientPreRender", getRootElement(), renderLoadPoint)
local orderButtons = {}
addEvent("selectOrderPickup", true)
addEventHandler("selectOrderPickup", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  if orderButtons[el] and not loadingOrder then
    seexports.sGui:showInfobox("i", "Állj a négyzetre az utánfutóval, majd gyere vissza ide a felrakodás megkezdéséhez!")
    if animalPanel then
      seexports.sGui:deleteGuiElement(animalPanel)
    end
    animalPanel = false
    loadingOrder = orderButtons[el][1]
    loadingOrderType = orderButtons[el][2]
  end
end)
addEvent("refreshTrailerContents", true)
addEventHandler("refreshTrailerContents", getRootElement(), function(data)
  for i = 1, #data do
    if data[i] then
      trailerContents[data[i][1]] = data[i][2]
      refreshTrailerData(data[i][1])
    end
  end
end)
function refreshTrailerData(veh)
  if trailerObjs[veh] then
    for i = 1, #trailerObjs[veh] do
      if isElement(trailerObjs[veh][i]) then
        destroyElement(trailerObjs[veh][i])
      end
      trailerObjs[veh][i] = nil
      if isElement(trailerShaders[veh][i]) then
        destroyElement(trailerShaders[veh][i])
      end
      trailerShaders[veh][i] = nil
      if isElement(trailerWoolShaders[veh][i]) then
        destroyElement(trailerWoolShaders[veh][i])
      end
      trailerWoolShaders[veh][i] = nil
    end
  end
  trailerObjs[veh] = {}
  trailerShaders[veh] = {}
  trailerWoolShaders[veh] = {}
  if getPedOccupiedVehicle(localPlayer) and getElementData(getPedOccupiedVehicle(localPlayer), "towCar") == veh then
    refreshTrailerMarker(getPedOccupiedVehicle(localPlayer))
  end
  for k = #trailerAnimals, 1, -1 do
    if trailerAnimals[k][1] == veh then
      table.remove(trailerAnimals, k)
    end
  end
  if isElement(veh) and isElementStreamedIn(veh) and trailerContents[veh] then
    if trailerContents[veh][1] == "animal" and trailerContents[veh][2] and animalTypes[trailerContents[veh][2][1]] and trailerContents[veh][2][2] and type(trailerContents[veh][2][2] == "table") then
      for i = 1, #trailerContents[veh][2][2] do
        local pos = animalTrailerPoses[trailerContents[veh][2][1]][math.floor(trailerContents[veh][2][2][i][1] + 0.5)][i]
        if pos and animalTypes[trailerContents[veh][2][1]].skin then
          trailerObjs[veh][i] = createPed(animalTypes[trailerContents[veh][2][1]].skin, 0, 0, 0)
          setElementCollisionsEnabled(trailerObjs[veh][i], false)
          setElementData(trailerObjs[veh][i], "invulnerable", true)
          attachElements(trailerObjs[veh][i], veh, pos[1], pos[2], pos[3])
          trailerShaders[veh][i] = dxCreateShader(morphShader .. morphShaderTrailer .. morphShader2, 0, 0, false, "ped")
          engineApplyShaderToWorldTexture(trailerShaders[veh][i], "*", trailerObjs[veh][i])
          if trailerContents[veh][2][1] == "sheep" and 1 > (trailerContents[veh][2][2][i][4] or 1) then
            trailerWoolShaders[veh][i] = dxCreateShader(sheepShader .. sheepShaderTrailer .. sheepShader2, 0, 0, false, "ped")
            dxSetShaderValue(trailerWoolShaders[veh][i], "woolNoiseTexture", sheepSkin)
            dxSetShaderValue(trailerWoolShaders[veh][i], "skinTexture", sheepSkin2)
            dxSetShaderValue(trailerWoolShaders[veh][i], "woolText", textures[trailerContents[veh][2][1]][trailerContents[veh][2][2][i][3] + #textures[trailerContents[veh][2][1]] / 2])
            engineRemoveShaderFromWorldTexture(trailerShaders[veh][i], "v4_sheep_wool", trailerObjs[veh][i])
            engineApplyShaderToWorldTexture(trailerWoolShaders[veh][i], "v4_sheep_wool", trailerObjs[veh][i])
          end
          local size = animalTypes[trailerContents[veh][2][1]].size[1] + (animalTypes[trailerContents[veh][2][1]].size[2] - animalTypes[trailerContents[veh][2][1]].size[1]) * trailerContents[veh][2][2][i][1]
          local morph = animalTypes[trailerContents[veh][2][1]].morph[1] + (animalTypes[trailerContents[veh][2][1]].morph[2] - animalTypes[trailerContents[veh][2][1]].morph[1]) * trailerContents[veh][2][2][i][2]
          dxSetShaderValue(trailerShaders[veh][i], "size", size)
          dxSetShaderValue(trailerShaders[veh][i], "morph", morph)
          dxSetShaderValue(trailerShaders[veh][i], "gTexture", textures[trailerContents[veh][2][1]][trailerContents[veh][2][2][i][3]])
          if isElement(trailerWoolShaders[veh][i]) then
            dxSetShaderValue(trailerWoolShaders[veh][i], "size", size)
            dxSetShaderValue(trailerWoolShaders[veh][i], "morph", morph)
            dxSetShaderValue(trailerWoolShaders[veh][i], "wool", trailerContents[veh][2][2][i][4])
          end
          table.insert(trailerAnimals, {
            veh,
            trailerObjs[veh][i],
            pos[4],
            0,
            trailerContents[veh][2][1]
          })
        end
      end
    elseif (trailerContents[veh][1] == "otherFood" or trailerContents[veh][1] == "chickenFood") and tonumber(trailerContents[veh][2]) then
      for i = 1, trailerContents[veh][2] do
        trailerObjs[veh][i] = createObject(trailerContents[veh][1] == "otherFood" and models.feed_bag or models.chicken_feed_bag, 0, 0, 0)
        setElementCollisionsEnabled(trailerObjs[veh][i], false)
        attachElements(trailerObjs[veh][i], veh, 0, 1.125 - 0.5 * ((i - 1) % 4), 0.125 + math.floor((i - 1) / 4) * 0.25)
      end
    elseif trailerContents[veh][1] == "hay" and tonumber(trailerContents[veh][2]) then
      local y = 0
      local z = 0
      for i = 1, trailerContents[veh][2] do
        trailerObjs[veh][i] = createObject(models.bale, 0, 0, 0)
        setElementCollisionsEnabled(trailerObjs[veh][i], false)
        attachElements(trailerObjs[veh][i], veh, 0, 1 - 0.65 * y, 0.456451 * z, 0, 0, 90)
        y = y + 1
        if i == 3 then
          y = 0.5
          z = 1
        end
      end
    end
  end
end
local unloadMarker = false
local unloadBlip = false
function refreshTrailerMarker(veh)
  if isElement(unloadMarker) then
    destroyElement(unloadMarker)
  end
  unloadMarker = nil
  unloadMarker = false
  if isElement(unloadBlip) then
    destroyElement(unloadBlip)
  end
  unloadBlip = nil
  unloadBlip = false
  if isElement(veh) then
    local trailer = getElementData(veh, "towCar")
    if trailer and trailerContents[trailer] and trailerContents[trailer][3] and not trailerContents[trailer][4] then
      local pos = farmDetails[trailerContents[trailer][3]].loadpos
      unloadMarker = createMarker(pos[1], pos[2], pos[3] - 1.5, "cylinder", 2.5, green[1], green[2], green[3], 225)
      unloadBlip = createBlip(pos[1], pos[2], pos[3], 19, 2, green[1], green[2], green[3])
      setElementData(unloadBlip, "tooltipText", "Farm")
    end
  end
end
addEventHandler("onClientVehicleEnter", getRootElement(), function(player)
  if player == localPlayer then
    refreshTrailerMarker(source)
  end
end)
addEventHandler("onClientVehicleExit", getRootElement(), function(player)
  if player == localPlayer then
    refreshTrailerMarker(false)
  end
end)
addEvent("confirmOrderPickup", true)
addEventHandler("confirmOrderPickup", getRootElement(), function()
  if loadingOrder then
    local trailer = false
    local els = getElementsWithinColShape(shopLoadCol[loadingOrderCol], "vehicle")
    for i = 1, #els do
      if getElementModel(els[i]) == 611 then
        trailer = els[i]
        break
      end
    end
    if trailer then
      if trailerContents[trailer] and loadingOrderType ~= "sellAnimal" then
        seexports.sGui:showInfobox("e", "Az utánfutó már meg van rakodva!")
      else
        if loadingOrderType == "sellAnimal" and trailerContents[trailer][1] ~= "animal" then
          seexports.sGui:showInfobox("e", "Nem megfelelő az utánfutó!")
          return
        end
        if animalPanel then
          seexports.sGui:deleteGuiElement(animalPanel)
        end
        animalPanel = false
        triggerServerEvent("loadUpOrder", localPlayer, loadingOrder, trailer, loadingOrderCol)
        loadingOrder = false
        loadingOrderCol = false
      end
    else
      seexports.sGui:showInfobox("e", "Nincs utánfutó a négyzetben!")
    end
  end
end)
addEvent("orderNPCGot", true)
addEventHandler("orderNPCGot", getRootElement(), function(orders)
  checkingOrder = false
  if #orders < 1 then
    seexports.sGui:showInfobox("e", "Nincs aktív rendelésed!")
  else
    local titleBarHeight = seexports.sGui:getTitleBarHeight()
    local btns = canBuyAnimals and 3 or 2
    local windowHeight = titleBarHeight + 30 + 5 + 5 + 53 * #orders + 24 + 5
    local windowWidth = 350
    if animalPanel then
      seexports.sGui:deleteGuiElement(animalPanel)
    end
    animalPanel = seexports.sGui:createGuiElement("window", screenX / 2 - windowWidth / 2, screenY / 2 - windowHeight / 2, windowWidth, windowHeight)
    if shopLoadPos[loadingOrderCol][11] then
      seexports.sGui:setWindowTitle(animalPanel, "16/BebasNeueRegular.otf", "SightMTA - Mezőgazdasági nagyker")
    else
      seexports.sGui:setWindowTitle(animalPanel, "16/BebasNeueRegular.otf", "SightMTA - Vágóhíd")
    end
    local y = titleBarHeight + 5
    local label = seexports.sGui:createGuiElement("label", 0, y, windowWidth, 24, animalPanel)
    seexports.sGui:setLabelAlignment(label, "center", "center")
    seexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
    if shopLoadPos[loadingOrderCol][11] then
      seexports.sGui:setLabelText(label, "Átvehető rendelések:")
    else
      seexports.sGui:setLabelText(label, "Leadható állatok:")
    end
    y = y + 24 + 5
    for i = 1, #orders do
      local border = seexports.sGui:createGuiElement("hr", 5, y - 1, windowWidth - 10, 2, animalPanel)
      local label = seexports.sGui:createGuiElement("label", 5, y, windowWidth, 48, animalPanel)
      seexports.sGui:setLabelAlignment(label, "left", "center")
      seexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
      seexports.sGui:setLabelText(label, "#" .. orders[i][1] .. " " .. orders[i][2])
      if orders[i][3] == "hay" then
        seexports.sGui:setLabelText(label, "#" .. orders[i][1] .. " " .. utf8.gsub(orders[i][2], "/", " ") .. "\n" .. seexports.sGui:getColorCodeHex("sightgreen") .. "Szalma (" .. orders[i][4] .. " bála) - " .. seexports.sGui:thousandsStepper(orders[i][4] * balePrice) .. " $")
      elseif orders[i][3] == "otherFood" then
        seexports.sGui:setLabelText(label, "#" .. orders[i][1] .. " " .. utf8.gsub(orders[i][2], "/", " ") .. "\n" .. seexports.sGui:getColorCodeHex("sightgreen") .. "Pellet táp (" .. orders[i][4] .. " zsák) - " .. seexports.sGui:thousandsStepper(orders[i][4] * otherFoodPrice) .. " $")
      elseif orders[i][3] == "chickenFood" then
        seexports.sGui:setLabelText(label, "#" .. orders[i][1] .. " " .. utf8.gsub(orders[i][2], "/", " ") .. "\n" .. seexports.sGui:getColorCodeHex("sightgreen") .. "Csirketáp (" .. orders[i][4] .. " zsák) - " .. seexports.sGui:thousandsStepper(orders[i][4] * chickenFoodPrice) .. " $")
      elseif orders[i][3] == "sellAnimal" then
        seexports.sGui:setLabelText(label, "#" .. orders[i][1] .. " " .. utf8.gsub(orders[i][2], "/", " ") .. "\n" .. seexports.sGui:getColorCodeHex("sightgreen") .. orders[i][4][2] .. " db " .. utf8.lower(animalTypes[orders[i][4][1]].name))
      elseif orders[i][3] == "animal" then
        local price = 0
        for j = 1, #orders[i][4][2] do
          if 0 > orders[i][4][2][j][1] then
            orders[i][4][2][j][1] = 0
          end
          if orders[i][4][2][j][1] > 0.1 then
            orders[i][4][2][j][1] = 0.1
          end
          if 0 > orders[i][4][2][j][2] then
            orders[i][4][2][j][1] = 0
          end
          if 1 < orders[i][4][2][j][2] then
            orders[i][4][2][j][1] = 1
          end
          local perc = -10 + (10 * orders[i][4][2][j][2] + 25 * (orders[i][4][2][j][1] / 0.1))
          perc = perc / 100
          price = price + math.floor(animalTypes[orders[i][4][1]].basePrice * (1 + perc))
        end
        if price < 1 then
          price = 1
        end
        seexports.sGui:setLabelText(label, "#" .. orders[i][1] .. " " .. utf8.gsub(orders[i][2], "/", " ") .. "\n" .. seexports.sGui:getColorCodeHex("sightgreen") .. animalTypes[orders[i][4][1]].name .. " (" .. #orders[i][4][2] .. " db)" .. " - " .. seexports.sGui:thousandsStepper(price) .. " $")
      end
      local btn = seexports.sGui:createGuiElement("button", windowWidth - 80 - 5, y + 24 - 15, 80, 30, animalPanel)
      seexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
      seexports.sGui:setGuiHover(btn, "gradient", {
        "sightgreen",
        "sightgreen-second"
      }, false, true)
      seexports.sGui:setButtonFont(btn, "13/BebasNeueBold.otf")
      seexports.sGui:setButtonTextColor(btn, "#ffffff")
      seexports.sGui:setButtonText(btn, "Kiválasztás")
      seexports.sGui:setClickEvent(btn, "selectOrderPickup", false)
      orderButtons[btn] = {
        orders[i][1],
        orders[i][3]
      }
      y = y + 48 + 5
    end
    local btn = seexports.sGui:createGuiElement("button", 5, windowHeight - 30 - 5, windowWidth - 10, 30, animalPanel)
    seexports.sGui:setGuiBackground(btn, "solid", "sightred")
    seexports.sGui:setGuiHover(btn, "gradient", {
      "sightred",
      "sightred-second"
    }, false, true)
    seexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
    seexports.sGui:setButtonTextColor(btn, "#ffffff")
    seexports.sGui:setButtonText(btn, "Bezárás")
    seexports.sGui:setClickEvent(btn, "closeAnimalPanel", false)
  end
end)
orderNPC = {}
for i = 1, #shopLoadPos do
  orderNPC[i] = createPed(shopLoadPos[i][6], shopLoadPos[i][7], shopLoadPos[i][8], shopLoadPos[i][9], shopLoadPos[i][10])
  setElementData(orderNPC[i], "invulnerable", true)
  setElementData(orderNPC[i], "visibleName", shopLoadPos[i][12])
  setElementData(orderNPC[i], "pedNameType", shopLoadPos[i][13])
  setTimer(setElementFrozen, 1000, 1, orderNPC[i], true)
end
addEventHandler("onClientClick", getRootElement(), function(button, state, x, y, wx, wy, wz, clickedElement)
  if state == "down" and not animalPanel and clickedElement and getElementType(clickedElement) == "ped" then
    local x, y, z = getElementPosition(clickedElement)
    local px, py, pz = getElementPosition(localPlayer)
    local dist = getDistanceBetweenPoints3D(x, y, z, px, py, pz)
    if not isPedInVehicle(localPlayer) and dist < 2.5 then
      if loadingOrder and loadingOrderCol and clickedElement == orderNPC[loadingOrderCol] then
        local trailer = false
        local els = getElementsWithinColShape(shopLoadCol[loadingOrderCol], "vehicle")
        for i = 1, #els do
          if getElementModel(els[i]) == 611 then
            trailer = els[i]
            break
          end
        end
        if trailer then
          if trailerContents[trailer] and loadingOrderType ~= "sellAnimal" then
            seexports.sGui:showInfobox("e", "Az utánfutó már meg van rakodva!")
          else
            if loadingOrderType == "sellAnimal" and trailerContents[trailer][1] ~= "animal" then
              seexports.sGui:showInfobox("e", "Nem megfelelő az utánfutó!")
              return
            end
            local titleBarHeight = seexports.sGui:getTitleBarHeight()
            local windowHeight = titleBarHeight + 35 + 5 + 20 + 5
            local windowWidth = 350
            if animalPanel then
              seexports.sGui:deleteGuiElement(animalPanel)
            end
            animalPanel = seexports.sGui:createGuiElement("window", screenX / 2 - windowWidth / 2, screenY / 2 - windowHeight / 2, windowWidth, windowHeight)
            if shopLoadPos[loadingOrderCol][11] then
              seexports.sGui:setWindowTitle(animalPanel, "16/BebasNeueRegular.otf", "SightMTA - Mezőgazdasági nagyker")
            else
              seexports.sGui:setWindowTitle(animalPanel, "16/BebasNeueRegular.otf", "SightMTA - Vágóhíd")
            end
            local label = seexports.sGui:createGuiElement("label", 0, 5 + titleBarHeight, windowWidth, 20, animalPanel)
            seexports.sGui:setLabelAlignment(label, "center", "center")
            seexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
            if shopLoadPos[loadingOrderCol][11] then
              seexports.sGui:setLabelText(label, "Felrakodás a következő utánfutóra: " .. seexports.sGui:getColorCodeHex("sightgreen") .. table.concat(split(getVehiclePlateText(trailer), "-"), "-"))
            else
              seexports.sGui:setLabelText(label, "Lerakodás a következő utánfutóról: " .. seexports.sGui:getColorCodeHex("sightgreen") .. table.concat(split(getVehiclePlateText(trailer), "-"), "-"))
            end
            local btn = seexports.sGui:createGuiElement("button", 5, windowHeight - 30 - 5, (windowWidth - 15) / 2, 30, animalPanel)
            seexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
            seexports.sGui:setGuiHover(btn, "gradient", {
              "sightgreen",
              "sightgreen-second"
            }, false, true)
            seexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
            seexports.sGui:setButtonTextColor(btn, "#ffffff")
            seexports.sGui:setButtonText(btn, "Igen")
            seexports.sGui:setClickEvent(btn, "confirmOrderPickup", false)
            local btn = seexports.sGui:createGuiElement("button", 5 + (windowWidth - 15) / 2 + 5, windowHeight - 30 - 5, (windowWidth - 15) / 2, 30, animalPanel)
            seexports.sGui:setGuiBackground(btn, "solid", "sightred")
            seexports.sGui:setGuiHover(btn, "gradient", {
              "sightred",
              "sightred-second"
            }, false, true)
            seexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
            seexports.sGui:setButtonTextColor(btn, "#ffffff")
            seexports.sGui:setButtonText(btn, "Nem")
            seexports.sGui:setClickEvent(btn, "closeAnimalPanel", false)
          end
        else
          seexports.sGui:showInfobox("e", "Nincs utánfutó a négyzetben!")
        end
      elseif not checkingOrder and not animalPanel and not isPedInVehicle(localPlayer) then
        local found = false
        if clickedElement then
          for i = 1, #shopLoadPos do
            if clickedElement == orderNPC[i] then
              found = i
              break
            end
          end
        end
        if found then
          loadingOrderCol = found
          local x, y, z = getElementPosition(orderNPC[loadingOrderCol])
          local px, py, pz = getElementPosition(localPlayer)
          if getDistanceBetweenPoints3D(x, y, z, px, py, pz) < 2.5 then
            checkingOrder = true
            triggerServerEvent("checkOrderNpc", localPlayer, shopLoadPos[found][11])
          end
        end
      end
    end
  end
end, true, "high+9999999999")
local subtitleFont, subtitleFontScale, subtitleFont2, subtitleFontScale2
function animalsRefreshListener()
  subtitleFont = seexports.sGui:getFont("14/Ubuntu-R.ttf")
  subtitleFontScale = seexports.sGui:getFontScale("14/Ubuntu-R.ttf")
  subtitleFont2 = seexports.sGui:getFont("14/Ubuntu-L.ttf")
  subtitleFontScale2 = seexports.sGui:getFontScale("14/Ubuntu-L.ttf")
end
local sentences = {
  {
    {
      "Szevasz komám, na látom hoztál nekem valamit? Nézzük meg a jószágokat!",
      "Szevasz komám, na látom hoztál nekem valamit? Nézzük meg a jószágot!"
    },
    {
      "Adjon Isten! Na látom ott a jószágokat a futón! Akkor megnézem és mehet az alkudozás.",
      "Adjon Isten! Na látom ott a jószágot a futón! Akkor megnézem és mehet az alkudozás."
    },
    {
      "Szervusz barát! Épp a szünetem töltöm, szóval gyorsan nézzük meg ezeket, oszt' csapjunk kézbe!",
      "Szervusz barát! Épp a szünetem töltöm, szóval gyorsan nézzük meg eztet', oszt' csapjunk kézbe!"
    }
  },
  {
    "Há' ja... Szép szép, kár tagadni, tényleg kíváló minőségű az áru, oszt mennyit kérsz érte?!",
    "Nagyon szépet hoztál, de az ára is ilyen szép legyen Kapitány! Mennyiér' adod?!"
  },
  {
    "Há' mit mondjak, láttam már szebbet is, de nem rossz... Mennyit kérsz érte?!",
    "Nem rossz ez Te!... Mit kérsz érte? Csapjunk kézbe!"
  },
  {
    "Há' nem vagyok elesve tőle, de ha jó pénzt mondasz, akkó' jó lehet!",
    "Azé' nem borzalmas ez, mondjad Kapitány mi a pénz, amit akarsz ezért?"
  },
  {
    "Híha' hát azé' van itt baj, de ha jó olcsón adod, lehet róla szó! Mit kérsz érte?!",
    "Te se az év állattenyésztője vagy aztat' látom, de mi pénzt kérsz te ezért?!"
  },
  {
    {
      "Szűzmária! Megváltás nekik, hogy idehoztad! Mit akarsz te ezért?!",
      "Szűzmária! Megváltás néki, hogy idehoztad! Mit akarsz te ezért?!"
    },
    "Óóóó hát ezért neked kéne fizetni, hogy átvegyem! Mit akarsz te ezért?!",
    "Mondjuk ki, ez szar! Mit szeretnél te ezért egyáltalán?!",
    "Ingyen is drága lenne, borzalmas, de mit szeretnél te ezért?!"
  },
  {
    "Te jó ég, összesen nem láttam még ennyi pénzt Kapitány! Beszéljük újra!",
    "Na jó ne bohóckodjunk nincs erre időm, komolyan mennyit akarsz te ezért?!",
    "Ne sértegess kapitány, szerinted nekem akkor mi marad rajta?!",
    "Na akkor nagy lendülettel fordulj is meg, vagy mondj egy jobb összeget!",
    "MENNYI??!!!! Ha még egy ilyen utánfutónyit hoznál SE!!!"
  },
  {
    "Na jólvan, szerencséd, hogy jól megy a bolt, itt a pénz, kezet rá!",
    "Legyen Kapitány, itt a pénzed, a fiúk lepakolnak gyorsan. Öröm volt!",
    "Ejjj de határozott valaki. Jólvan Kapitány, gyere máskor is, pakoljuk is le!",
    "Te nem egy tenyésztő, hanem egy rabló vagy! Itt a pénzed, legközelebb olcsóbban add!",
    "Na csapj bele akkó', itt a lóvé oszt legközelebb már jobb árat mondjá' nekem!"
  }
}
local talkAnims = {
  {
    "GANGS",
    "prtial_gngtlkA"
  },
  {
    "GANGS",
    "prtial_gngtlkB"
  },
  {
    "GANGS",
    "prtial_gngtlkC"
  },
  {
    "GANGS",
    "prtial_gngtlkD"
  },
  {
    "GANGS",
    "prtial_gngtlkE"
  },
  {
    "GANGS",
    "prtial_gngtlkF"
  },
  {
    "GANGS",
    "prtial_gngtlkG"
  },
  {
    "GANGS",
    "prtial_gngtlkH"
  }
}
local textStart = false
local sellingMinigame = false
local firstMinigame = true
local minigameEnded = false
local minigameStarted = false
local minigameProgress = 0
local minigameHigh = 1.25
local minigameStage = 0
local randomSentence = false
local basePrice = 1000
local quality = 100
local minigameRandomFactor = math.random(80, 120) / 100
local camStart = {}
local animPlayed = false
local animalCount = 0
addEvent("startAnimalSelling2", true)
addEventHandler("startAnimalSelling2", getRootElement(), function(farmId, price, q, col, count)
  if not sellingMinigame then
    animalCount = count
    loadingOrderCol = col
    animPlayed = false
    camStart = {
      getCameraMatrix()
    }
    minigameRandomFactor = math.random(80, 120) / 100
    progressGrad = seexports.sGui:getGradient2Filename(screenX * 0.3, screenY * 0.05 / 4, green, red, force)
    firstMinigame = true
    minigameEnded = false
    minigameStarted = false
    minigameProgress = 0
    minigameHigh = 1.25
    minigameStage = 0
    randomSentence = false
    textStart = getTickCount()
    sellingMinigame = farmId
    basePrice = price
    addEventHandler("onClientRender", getRootElement(), renderSellMinigame)
    seexports.sControls:toggleAllControls(false)
    quality = q * 100
    seexports.sHud:setHudEnabled(false, 1000)
  end
end)
function renderSellMinigame()
  local p = (getTickCount() - textStart) / (randomSentence and utf8.len(randomSentence) * 40 or 2000)
  local s = 0.1
  if 1 < minigameStage or 1 <= p then
    setCameraMatrix(-5.7367310523987, -244.67437744141, 6.2894835472107, -50.089504241943, -333.90911865234, -2.0767259597778)
  end
  if minigameStage == 0 then
    s = 0.1 * math.min(1, p)
    if p < 1 then
      local x, y, z = interpolateBetween(camStart[1], camStart[2], camStart[3], -5.7367310523987, -244.67437744141, 6.2894835472107, p, "InOutQuad")
      local x2, y2, z2 = interpolateBetween(camStart[4], camStart[5], camStart[6], -50.089504241943, -333.90911865234, -2.0767259597778, p, "InOutQuad")
      setCameraMatrix(x, y, z, x2, y2, z2)
    end
    if 1.5 <= p then
      local rnd = math.random(1, #talkAnims)
      setPedAnimation(orderNPC[loadingOrderCol], talkAnims[rnd][1], talkAnims[rnd][2], -1, true)
      randomSentence = sentences[1][math.random(1, #sentences[1])]
      if type(randomSentence) == "table" then
        randomSentence = randomSentence[1 < animalCount and 1 or 2]
      end
      minigameStage = 1
      textStart = getTickCount()
      p = 0
    end
  elseif minigameStage == 1 then
    if 2 < p and not animPlayed then
      animPlayed = true
      setPedAnimation(orderNPC[loadingOrderCol], "COP_AMBIENT", "Coplook_think", -1, true)
    end
    if 4 < p then
      local x, y, z = interpolateBetween(-7.5037579536438, -244.80618286133, 9.124927520752, -5.7367310523987, -244.67437744141, 6.2894835472107, p - 4, "InOutQuad")
      local x2, y2, z2 = interpolateBetween(45.548347473145, -305.07049560547, -50.487884521484, -50.089504241943, -333.90911865234, -2.0767259597778, p - 4, "InOutQuad")
      setCameraMatrix(x, y, z, x2, y2, z2)
    elseif 2 < p and p < 3 then
      local x, y, z = interpolateBetween(-5.7367310523987, -244.67437744141, 6.2894835472107, -7.5037579536438, -244.80618286133, 9.124927520752, p - 2, "InOutQuad")
      local x2, y2, z2 = interpolateBetween(-50.089504241943, -333.90911865234, -2.0767259597778, 45.548347473145, -305.07049560547, -50.487884521484, p - 2, "InOutQuad")
      setCameraMatrix(x, y, z, x2, y2, z2)
    elseif 2 < p then
      setCameraMatrix(-7.5037579536438, -244.80618286133, 9.124927520752, 45.548347473145, -305.07049560547, -50.487884521484)
    end
  elseif minigameStage == 6 then
    s = 0.1 * (1 - math.min(1, p))
    if 1 <= p then
      removeEventHandler("onClientRender", getRootElement(), renderSellMinigame)
      local mgp = getEasingValue(getEasingValue(minigameProgress, "InOutQuad"), "InOutQuad")
      local gameProg = 0.5 < mgp and 2 - mgp * 2 or mgp * 2
      local low = firstMinigame and 0.75 or 0.65
      triggerServerEvent("animalSellMinigameEnded", localPlayer, sellingMinigame, low + (minigameHigh - low) * gameProg)
      sellingMinigame = false
      seexports.sControls:toggleAllControls(true)
      seexports.sHud:setHudEnabled(true, 1000)
      setCameraTarget(localPlayer)
      loadingOrderCol = false
    end
  end
  dxDrawRectangle(0, 0, screenX, screenY * s, tocolor(0, 0, 0))
  dxDrawRectangle(0, screenY * (1 - s), screenX, screenY * s, tocolor(0, 0, 0))
  local t1 = "Mészáros Gyuri bá' mondja: "
  local t2 = ""
  if minigameStage == 1 then
    t2 = randomSentence
    if 5 < p then
      textStart = getTickCount()
      local block = 2
      if quality < 30 then
        block = 6
      elseif quality < 50 then
        block = 5
      elseif quality < 70 then
        block = 4
      elseif quality < 90 then
        block = 3
      end
      if quality < 70 then
        setPedAnimation(orderNPC[loadingOrderCol], "COP_AMBIENT", "Coplook_shake", -1, true)
      else
        local rnd = math.random(1, #talkAnims)
        setPedAnimation(orderNPC[loadingOrderCol], talkAnims[rnd][1], talkAnims[rnd][2], -1, true)
      end
      randomSentence = sentences[block][math.random(1, #sentences[block])]
      if type(randomSentence) == "table" then
        randomSentence = randomSentence[1 < animalCount and 1 or 2]
      end
      minigameStage = 2
    end
  elseif minigameStage == 2 then
    t2 = randomSentence
    if 2 < p then
      setPedAnimation(orderNPC[loadingOrderCol], "COP_AMBIENT", "Coplook_think", -1, true)
      minigameStage = 3
      minigameStarted = false
      minigameEnded = false
      minigameProgress = 0
      firstMinigame = true
    end
  elseif minigameStage == 4 then
    t2 = randomSentence
    if 2 < p then
      minigameStage = 3
      minigameStarted = false
      minigameEnded = false
      minigameProgress = 0
    end
  elseif minigameStage == 5 then
    t2 = randomSentence
    if 1 < p and not animPlayed then
      animPlayed = true
      setPedAnimation(orderNPC[loadingOrderCol], "DEALER", "shop_pay", -1, false)
    end
    if 2 < p then
      textStart = getTickCount()
      minigameStage = 6
      randomSentence = false
    end
  else
    t2 = ""
  end
  if minigameStage == 3 then
    local w = screenX * 0.3
    local h = screenY * 0.05 / 4
    local x = screenX / 2 - w / 2
    local y = screenY * 0.925 + h / 2
    dxDrawImage(x, y, w, h, ":sGui/" .. progressGrad .. "." .. gradientTick[progressGrad])
    if minigameStarted then
      minigameProgress = (getTickCount() - minigameStarted) / ((firstMinigame and 2000 or 1750) * minigameRandomFactor)
      if 1 < minigameProgress then
        minigameStarted = false
        minigameProgress = 1
        minigameEnded = getTickCount()
      end
    end
    if getKeyState("space") then
      if not minigameEnded and not minigameStarted then
        minigameStarted = getTickCount()
      end
    elseif minigameStarted then
      minigameStarted = false
      minigameEnded = getTickCount()
    end
    local mgp = getEasingValue(getEasingValue(minigameProgress, "InOutQuad"), "InOutQuad")
    local gameProg = 0.5 < mgp and 2 - mgp * 2 or mgp * 2
    local low = firstMinigame and 0.75 or 0.65
    local price = math.floor(basePrice * (low + (minigameHigh - low) * gameProg))
    local r, g, b = interpolateBetween(red[1], red[2], red[3], green[1], green[2], green[3], gameProg, "Linear")
    local rw = 10
    dxDrawRectangle(x + w * mgp - rw / 2 - 2, y - 2, rw + 4, h + 4, tocolor(0, 0, 0))
    dxDrawRectangle(x + w * mgp - rw / 2 - 1, y - 1, rw + 2, h + 2, tocolor(r, g, b))
    dxDrawText(seexports.sGui:thousandsStepper(price) .. " $", x + w * mgp, 0, x + w * mgp, y - 4, tocolor(r, g, b, 255), subtitleFontScale2 * 0.75, subtitleFont2, "center", "bottom")
    if minigameEnded then
      local p = (getTickCount() - minigameEnded) / 2500
      if 1 < p then
        local rnd = math.random(10000) / 100
        local check = 75 * gameProg + 20
        if firstMinigame and rnd < check then
          setPedAnimation(orderNPC[loadingOrderCol], "COP_AMBIENT", "Coplook_shake", -1, true)
          minigameRandomFactor = math.random(80, 120) / 100
          randomSentence = sentences[7][math.random(1, #sentences[7])]
          if type(randomSentence) == "table" then
            randomSentence = randomSentence[1 < animalCount and 1 or 2]
          end
          minigameStage = 4
          textStart = getTickCount()
          minigameHigh = low + (minigameHigh - low) * gameProg
        else
          local rnd = math.random(1, #talkAnims)
          setPedAnimation(orderNPC[loadingOrderCol], talkAnims[rnd][1], talkAnims[rnd][2], -1, true)
          animPlayed = false
          randomSentence = sentences[8][math.random(1, #sentences[8])]
          if type(randomSentence) == "table" then
            randomSentence = randomSentence[1 < animalCount and 1 or 2]
          end
          minigameStage = 5
          textStart = getTickCount()
        end
        firstMinigame = false
      end
    end
    if mgp <= 0 then
      dxDrawText(seexports.sGui:thousandsStepper(math.floor(basePrice * minigameHigh)) .. " $", x + w * 0.5, 0, x + w * 0.5, y - 4, tocolor(green[1], green[2], green[3], 200), subtitleFontScale2 * 0.75, subtitleFont2, "center", "bottom")
      dxDrawText(seexports.sGui:thousandsStepper(math.floor(basePrice * low)) .. " $", x + w * 1, 0, x + w * 1, y - 4, tocolor(red[1], red[2], red[3], 200), subtitleFontScale2 * 0.75, subtitleFont2, "center", "bottom")
    end
    dxDrawText("Az alkuhoz tartsd lenyomva a SPACE gombot, majd engedd fel.", 0, screenY * 0.95, screenX, screenY, tocolor(255, 255, 255, 255), subtitleFontScale, subtitleFont, "center", "center")
  elseif minigameStage < 6 and 0 < minigameStage then
    if 2 < p then
      dxDrawText(utf8.sub("\226\128\162\226\128\162\226\128\162", 1, 3 * (p * 2 % 1)), 0, screenY * 0.9, screenX, screenY, tocolor(255, 255, 255, 255), subtitleFontScale, subtitleFont, "center", "center")
    else
      local w1 = seexports.sGui:getTextWidthFont(t1, "14/Ubuntu-R.ttf")
      local w2 = seexports.sGui:getTextWidthFont(t2, "14/Ubuntu-L.ttf")
      local w = w1 + w2
      dxDrawText(t1, screenX / 2 - w / 2, screenY * 0.9, 0, screenY, tocolor(255, 255, 255, 255), subtitleFontScale, subtitleFont, "left", "center")
      dxDrawText(utf8.sub(t2, 1, utf8.len(t2) * p), screenX / 2 - w / 2 + w1, screenY * 0.9, 0, screenY, tocolor(255, 255, 255, 255), subtitleFontScale2, subtitleFont2, "left", "center")
    end
  end
end
