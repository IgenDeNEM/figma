function coordToSync(x, y)
  return x * 1025 + y
end
biggestSync = coordToSync(1023, 1023)
function syncToCoord(s)
  local x = math.floor(s / 1025)
  local y = math.floor(s - x * 1025)
  return x, y
end
function alphaBlend(aA, aB)
  return aA + aB * (255 - aA) / 255
end
function alphaTarget(aB, aC)
  if 255 <= aB or aC <= aB then
    return 0
  else
    return (255 * aC - 255 * aB) / (255 - aB)
  end
end
textureChanger = [[
	texture gTexture;

	technique hello
	{
		pass P0
		{
			Texture[0] = gTexture;
		}
	}

]]
mapNames = {
  [561] = "remapelegybody128",
  [580] = "remap_rs_body",
  [551] = "remap_750",
  [547] = "remap",
  [560] = "remapelegybody128",
  [558] = "remap",
  [533] = "remap",
  [541] = "camaro_remap",
  [429] = "remap_gts",
  [516] = "remap_300sel72",
  [602] = "remap_quattro82",
  [567] = "remap",
  [562] = "remapelegybody",
  [445] = "remap",
  [495] = "remap",
  [507] = "remap_w220",
  [589] = "remap_body",
  [458] = "remap"
}
hideTextures = {
  [547] = {
    "rendszamtext",
    "light_plate"
  },
  [561] = {
    "rendszamtext",
    "light_plate"
  },
  [533] = {
    "light_plate"
  },
  [541] = {
    "light_plate"
  },
  [602] = {"eltuntet"},
  [445] = {
    "light_plate",
    "rendszamsicc"
  },
  [551] = {
    "rendszamtext"
  },
  [589] = {
    "rendszamtext"
  }
}
hideComponents = {
  [516] = {
    "bump_rear_dummy",
    "bump_front_dummy"
  },
  [567] = {
    "bump_front_dummy"
  },
  [589] = {
    "misc_platelight"
  }
}
for i in pairs(mapNames) do
  mapNames[i] = {
    mapNames[i],
    "#" .. utf8.sub(mapNames[i], 2)
  }
end
carHideShaderSource = [[
	#include "files/mta-helper.fx"

	float4 PixelShaderFunction() : COLOR0
	{
		return float4(0, 0, 0, 0);
	}

	technique Technique1 
	{ 
		pass Pass1 
		{
			AlphaBlendEnable = true;
			AlphaTestEnable = false;
			AlphaFunc = GreaterEqual;
			ShadeMode = Gouraud;
			ZEnable = false;
			FogEnable = false;
			SrcBlend = One;
			DestBlend = InvSrcAlpha;
			PixelShader = compile ps_2_0 PixelShaderFunction(); 
		} 
	}
]]
carHelperShader = [[

	#include "files/mta-helper.fx"

	texture secondRT < string renderTarget = "yes"; >;

	struct Pixel
	{
		float4 Color : COLOR0;
		float4 Extra : COLOR1;
	};

	bool work = false;

	Pixel PixelShaderFunction()
	{
		Pixel output;

		output.Color = 0;

		if(work)
		{
			output.Extra = float4(0, 0, 0, 1);
		}
		else
		{
			output.Extra = 0;
		}

		return output;
	}

	technique Technique1 
	{ 
		pass Pass1 
		{
			AlphaTestEnable = false;
			PixelShader = compile ps_2_0 PixelShaderFunction(); 
		} 
	}
]]
paintGunShader = [[
		#include "files/mta-helper.fx"

		struct PSInput
		{
			float4 Position : POSITION0;

			float4 Diffuse : COLOR0;

			float2 TexCoord : TEXCOORD0;

			//float4 Specular : COLOR1;
		};

		struct VSInput
		{
			float3 Position : POSITION0;
			float3 Normal : NORMAL0;
			float4 Diffuse : COLOR0;
			float2 TexCoord : TEXCOORD0;
		};

		float3 norm = float3(0.0000, -0.4398, 0.8981);
		//float3 dir = float3(0.0000, 0.8981, 0.4398);
		float3 midPoint = float3(0, 0.051138, 0.214283);

		float nlen = 1.0000038249926846;
		float rlen = 0.0415515;

		float paintLevel = 0;
		float mixSpeed = 0;

		PSInput VertexShaderFunction(VSInput VS)
		{
			//float pl = 1;

			PSInput PS = (PSInput)0;

			PS.TexCoord = VS.TexCoord;

			MTAFixUpNormal( VS.Normal );

			float3 vPoint = (VS.Position.xyz - midPoint);

			float d = length(dot(norm, vPoint))/nlen;

			if(mixSpeed > 0)
			{
				float dMix = length(cross(vPoint, norm))/rlen;
				
				float spd = mixSpeed*0.25;

				dMix = (1-spd)+spd*(dMix*dMix)*1.15;

				VS.Position.xyz -= d*norm*(1-paintLevel*dMix);
			}
			else
				VS.Position.xyz -= d*norm*(1-paintLevel);

			PS.Position = mul(float4(VS.Position, 1), gWorldViewProjection);

			PS.Diffuse = MTACalcGTABuildingDiffuse(VS.Diffuse);

			//PS.Specular.rgb = float3(1, 1, 1) * MTACalculateSpecular( gCameraDirection, gLight1Direction, MTACalcWorldNormal( VS.Normal ), 5 );

			return PS;
		}

		texture gTexture;

		technique Technique1 
		{ 
			pass Pass1 
			{
				Texture[0] = gTexture;				
				VertexShader = compile vs_2_0 VertexShaderFunction();
			} 
		}
	]]
function getWorkShader(workState, primerR, primerG, primerB, paintR, paintG, paintB, metal)
  primerR = primerR / 255
  primerG = primerG / 255
  primerB = primerB / 255
  paintR = paintR / 255
  paintG = paintG / 255
  paintB = paintB / 255
  local colorLayer = 0.65
  local primerLayer = 0.275
  local baseLayer = 0.0025
  local source = [[
		#include "files/mta-helper.fx"

		texture secondRTX < string renderTarget = "yes"; >;
		texture secondRTY < string renderTarget = "yes"; >;
		texture secondRTDepth < string renderTarget = "yes"; >;

		texture reflectionTexture;

		sampler2D ReflectionSampler = sampler_state
		{
			Texture = (reflectionTexture);
			AddressU = Mirror;
			AddressV = Mirror;
			MinFilter = Linear;
			MagFilter = Linear;
			MipFilter = Linear;
		};

		const float PI = 3.14159265f;

		

		struct PSInput
		{
			float4 Position : POSITION0;
			
			float4 Diffuse : COLOR0;
			float4 Specular : COLOR1;

			float2 TexCoord : TEXCOORD0;
			float3 Normal : TEXCOORD1;
			float4 WorldPos : TEXCOORD2;
			float Depth : TEXCOORD3;
		};

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

			MTAFixUpNormal( VS.Normal );			

			//VS.Position += VS.Normal*oaShader;

			PS.Position = mul(float4(VS.Position, 1), gWorldViewProjection);
			//PS.Position = MTACalcScreenPosition(VS.Position);
			
			PS.TexCoord = VS.TexCoord;
			
			float3 WorldNormal = MTACalcWorldNormal( VS.Normal );
			PS.Diffuse = MTACalcGTAVehicleDiffuse( WorldNormal, VS.Diffuse );

			float4 worldPos = mul( float4(VS.Position.xyz,1) , gWorld );

			PS.Normal = WorldNormal;
			PS.WorldPos.xyz = worldPos.xyz;

			PS.Specular.rgb = gMaterialSpecular.rgb * MTACalculateSpecular( gCameraDirection, gLight1Direction, PS.Normal, gMaterialSpecPower ) * 1; //*1 = specularValue

			PS.Specular.a = pow( mul( VS.Normal, (float3x3)gWorld ).z ,2.5 );
			float3 h = normalize(normalize(gCameraPosition - worldPos.xyz) - normalize(gCameraDirection));
			PS.Specular.a *=  1 - saturate(pow(saturate(dot(PS.Normal,h)), 2));
			PS.Specular.a *=  saturate(1 + gCameraDirection.z);
			
			PS.Depth = abs(PS.Position.z)+0.25;

			return PS;
		}

		struct Pixel
		{
			float4 Color : COLOR0;
			float4 ExtraX : COLOR1;
			float4 ExtraY : COLOR2;
			float4 ExtraDepth : COLOR3;
		};

		bool onY = false;
		bool work = false;

		texture baseTexture; 
		sampler baseSampler = sampler_state 
		{ 
			Texture = <baseTexture>; 
		}; 
		  
		texture maskTexture; 
		sampler maskSampler = sampler_state 
		{ 
			Texture = <maskTexture>; 
		}; 

		texture metalTexture; 
		sampler metalSampler = sampler_state 
		{ 
			Texture = <metalTexture>; 
		};

		texture noiseTexture; 
		sampler noiseSampler = sampler_state 
		{ 
			Texture = <noiseTexture>; 
		};


		texture secondaryMask; 
		sampler secondarySampler = sampler_state 
		{ 
			Texture = <secondaryMask>; 
		};
	]]
  if workState == "primerDry" or workState == "paintDry" then
    source = source .. [[
			float dryRate = 0;
			bool drying = false;
		]]
  end
  source = source .. [[
		Pixel PixelShaderFunction(PSInput PS)
		{ 
			float4 base = tex2D(baseSampler, PS.TexCoord);
			float4 mask = tex2D(maskSampler, PS.TexCoord);
			float4 sec = tex2D(secondarySampler, PS.TexCoord);
			
			Pixel output;

			float spec = 1.0f;
			float reflection = 0.75f;
			float flakes = 0.0f;

	]]
  if workState == "sanding" then
    source = source .. [[
			float rate = (sec.r + sec.g + sec.b) / 3.0f;
			
			spec = spec*rate;
			reflection = reflection*rate;

			rate = (mask.r + mask.g + mask.b) / 3.0f;

			float4 metal = tex2D(metalSampler, PS.TexCoord);
			
			if(rate > ]] .. colorLayer .. [[
)
			{
				rate = 1-(rate-]] .. colorLayer .. ")/(1-" .. colorLayer .. [[
);

				spec = spec + (0.6-spec)*rate;
				reflection = reflection + (0.25-reflection)*rate;
				flakes = 1-rate;

				output.Color.r = base.r*(1 + (1.25-1)*rate);
				output.Color.g = base.g*(1 + (1.25-1)*rate);
				output.Color.b = base.b*(1 + (1.25-1)*rate);
			}
			else if(rate > ]] .. primerLayer .. [[
)
			{
				rate = 1-(rate-]] .. primerLayer .. ")/(" .. colorLayer .. "-" .. primerLayer .. [[
);

				rate = pow(rate, 2);

				//res = from + (to-from)*rate

				spec = 0.6;
				reflection = 0.25 + (0-0.25)*rate;

				output.Color.r = base.r*1.25 + (]] .. primerR .. [[
-base.r*1.25)*rate;
				output.Color.g = base.g*1.25 + (]] .. primerG .. [[
-base.g*1.25)*rate;
				output.Color.b = base.b*1.25 + (]] .. primerB .. [[
-base.b*1.25)*rate;
			}
			else if(rate > ]] .. baseLayer .. [[
)
			{
				rate = 1-(rate-]] .. baseLayer .. ")/(" .. primerLayer .. "-" .. baseLayer .. [[
);

				rate = pow(rate, 5);

				//res = from + (to-from)*rate

				spec = 0.6 + (0.4-0.6)*rate;
				reflection = 0;

				output.Color.r = ]] .. primerR .. " + (metal.r-" .. primerR .. [[
)*rate;
				output.Color.g = ]] .. primerG .. " + (metal.g-" .. primerG .. [[
)*rate;
				output.Color.b = ]] .. primerB .. " + (metal.b-" .. primerB .. [[
)*rate;
			}
			else
			{
				spec = 0.4;
				reflection = 0;
				output.Color = metal;	
			}
		]]
  elseif workState == "primer" then
    source = source .. [[
			float rate = (sec.r + sec.g + sec.b) / 3.0f;

			float4 metal = tex2D(metalSampler, PS.TexCoord);
			
			if(rate > ]] .. colorLayer .. [[
)
			{
				rate = 1-(rate-]] .. colorLayer .. ")/(1-" .. colorLayer .. [[
);

				spec = spec + (0.6-spec)*rate;
				reflection = reflection + (0.25-reflection)*rate;
				flakes = 1-rate;

				output.Color.r = base.r*(1 + (1.25-1)*rate);
				output.Color.g = base.g*(1 + (1.25-1)*rate);
				output.Color.b = base.b*(1 + (1.25-1)*rate);
			}
			else if(rate > ]] .. primerLayer .. [[
)
			{
				rate = 1-(rate-]] .. primerLayer .. ")/(" .. colorLayer .. "-" .. primerLayer .. [[
);

				rate = pow(rate, 2);

				//res = from + (to-from)*rate

				spec = 0.6;
				reflection = 0.25 + (0-0.25)*rate;

				output.Color.r = base.r*1.25 + (]] .. primerR .. [[
-base.r*1.25)*rate;
				output.Color.g = base.g*1.25 + (]] .. primerG .. [[
-base.g*1.25)*rate;
				output.Color.b = base.b*1.25 + (]] .. primerB .. [[
-base.b*1.25)*rate;
			}
			else if(rate > ]] .. baseLayer .. [[
)
			{
				rate = 1-(rate-]] .. baseLayer .. ")/(" .. primerLayer .. "-" .. baseLayer .. [[
);

				rate = pow(rate, 5/2);

				//res = from + (to-from)*rate

				spec = 0.6 + (0.4-0.6)*rate;
				reflection = 0;

				output.Color.r = ]] .. primerR .. " + (metal.r-" .. primerR .. [[
)*rate;
				output.Color.g = ]] .. primerG .. " + (metal.g-" .. primerG .. [[
)*rate;
				output.Color.b = ]] .. primerB .. " + (metal.b-" .. primerB .. [[
)*rate;
			}
			else
			{
				spec = 0.4;
				reflection = 0;
				output.Color = metal;	
			}

			rate = (mask.r + mask.g + mask.b) / 3.0f;

			spec = 0.6 + (spec - 0.6)*rate;
			reflection = 0.25 + (reflection-0.25)*rate;

			output.Color.r = ]] .. primerR .. " + (output.Color.r-" .. primerR .. [[
)*rate;
			output.Color.g = ]] .. primerG .. " + (output.Color.g-" .. primerG .. [[
)*rate;
			output.Color.b = ]] .. primerB .. " + (output.Color.b-" .. primerB .. [[
)*rate;

		]]
  elseif workState == "primerDry" then
    source = source .. [[
			float rate = (sec.r + sec.g + sec.b) / 3.0f;

			float specTarget = 0.6 + (0.4 - 0.6)*dryRate;
			float reflectionTarget = 0.25 + (0 - 0.25)*dryRate;

			spec = specTarget + (spec - specTarget)*rate;
			reflection = reflectionTarget + (reflection-reflectionTarget)*rate;
			flakes = rate;

			output.Color.r = ]] .. primerR .. " + (base.r-" .. primerR .. [[
)*rate;
			output.Color.g = ]] .. primerG .. " + (base.g-" .. primerG .. [[
)*rate;
			output.Color.b = ]] .. primerB .. " + (base.b-" .. primerB .. [[
)*rate;

			rate = (mask.r + mask.g + mask.b) / 3.0f;
		]]
  elseif workState == "break" then
    source = source .. [[
			float rate = (sec.r + sec.g + sec.b) / 3.0f;

			float specTarget = 0.4;
			float reflectionTarget = 0;

			spec = specTarget + (spec - specTarget)*rate;
			reflection = reflectionTarget + (reflection-reflectionTarget)*rate;
			flakes = rate;

			output.Color.r = ]] .. primerR .. " + (base.r-" .. primerR .. [[
)*rate;
			output.Color.g = ]] .. primerG .. " + (base.g-" .. primerG .. [[
)*rate;
			output.Color.b = ]] .. primerB .. " + (base.b-" .. primerB .. [[
)*rate;

			rate = (mask.r + mask.g + mask.b) / 3.0f;
		]]
  elseif workState == "paint" then
    source = source .. [[
			float rate = (sec.r + sec.g + sec.b) / 3.0f;

			spec = 0.4 + (spec - 0.4)*rate;
			reflection = 0 + (reflection-0)*rate;
			flakes = rate;

			output.Color.r = ]] .. primerR .. " + (base.r-" .. primerR .. [[
)*rate;
			output.Color.g = ]] .. primerG .. " + (base.g-" .. primerG .. [[
)*rate;
			output.Color.b = ]] .. primerB .. " + (base.b-" .. primerB .. [[
)*rate;

			rate = (mask.r + mask.g + mask.b) / 3.0f;

			//rate = 1-pow(1-rate, 5);

			spec = 1 + (spec - 1)*rate;
			reflection = 1 + (reflection-1)*rate;	
			flakes = 1 + (flakes-1)*rate;	

			output.Color.r = ]] .. paintR .. " + (output.Color.r-" .. paintR .. [[
)*rate;
			output.Color.g = ]] .. paintG .. " + (output.Color.g-" .. paintG .. [[
)*rate;
			output.Color.b = ]] .. paintB .. " + (output.Color.b-" .. paintB .. [[
)*rate;
		]]
  elseif workState == "paintDry" then
    source = source .. [[
			float rate = (sec.r + sec.g + sec.b) / 3.0f;

			rate = pow(rate, 5);

			float reflectionTarget = 1 + (0.75 - 1)*dryRate;

			spec = 1 + (spec - 1)*rate;
			reflection = reflectionTarget + (reflection-reflectionTarget)*rate;	
			flakes = 1;	

			output.Color.r = ]] .. paintR .. [[
;
			output.Color.g = ]] .. paintG .. [[
;
			output.Color.b = ]] .. paintB .. [[
;
		]]
  else
    source = source .. "\t\t\toutput.Color.r = " .. paintR .. [[
;
			output.Color.g = ]] .. paintG .. [[
;
			output.Color.b = ]] .. paintB .. [[
;

			flakes = 1;
		]]
  end
  source = source .. [[

			output.Color.a = 1;


			PS.Specular *= spec;


			]]
  if workState == "primerDry" or workState == "paintDry" then
    source = source .. [[
				if(drying)
				{
					PS.Specular.r *= 1;
					PS.Specular.g *= 0.5;
					PS.Specular.b *= 0;
				}

			]]
  end
  if not metal then
    source = source .. "flakes *= 0.05;"
  end
  source = source .. [[


			output.Color.rgb += PS.Specular.rgb*0.75;

			output.Color *= PS.Diffuse;

			if(reflection > 0)
			{
				float3 viewDir = normalize(PS.WorldPos.xyz - gCameraPosition);
				float3 reflectDir = normalize(reflect(viewDir, PS.Normal));
				
				float r = length( reflectDir );
				reflectDir *= 1.f/r;
				float theta = acos( reflectDir.z );
				float phi = atan2( reflectDir.y, reflectDir.x );
				phi += ( phi < 0 ) ? 2*PI : 0; 

				float4 envMap = tex2D( ReflectionSampler, float2(phi/(2*PI), theta/PI) );
				
				float lum = (envMap.r + envMap.g + envMap.b)/3;
				float adj = saturate( lum - 0.16 ); //float sCutoff = 0.16;
				adj = adj / (1.01 - 0.16); //float sCutoff = 0.16;

				envMap += 0.1; //float sAdd = 0.1;

				envMap = (envMap * adj);

				envMap = pow(envMap, 2); //float sPower = 2;

				envMap *= 1.1; //float sMul = 1.1;

				envMap.rgb = saturate( envMap.rgb );
			
				float3 refl = saturate( envMap.rgb * reflection) * (0.25+PS.Specular.a*0.75);
							
				float reflRate = (refl.r + refl.g + refl.b)/3;


			]]
  if workState == "primerDry" or workState == "paintDry" then
    source = source .. [[
					if(drying)
					{
						refl.r *= 1;
						refl.g *= 1-0.5*0.6;
						refl.b *= 1-1*0.6;
					}
				]]
  end
  source = source .. [[

				output.Color.rgb += refl;
				
				if(flakes > 0)
				{
					float4 noise = tex2D(noiseSampler, PS.TexCoord*3.5);
					float noiseRate = (noise.r + noise.g + noise.b)/3;
					noiseRate = (noiseRate*(reflRate*0.75+PS.Specular.a*0.25))*0.35*flakes;

					output.Color.rgb += noiseRate;
				}
			}

			//output.Color.rgb = reflection;

			]]
  if workState == "primerDry" or workState == "paintDry" then
    source = source .. [[
					if(drying)
					{
						output.Color.r *= 1;
						output.Color.g *= 1-0.5*0.2;
						output.Color.b *= 1-1*0.2;
					}
				]]
  end
  source = source .. [[

			if(work)
			{
				output.ExtraY = float4(
					min(1, PS.TexCoord[1]*3),
					min(1, max(0, PS.TexCoord[1]*3-1)),
					max(0, PS.TexCoord[1]*3-2),
					1
				);

				output.ExtraX = float4(
					min(1, PS.TexCoord[0]*3),
					min(1, max(0, PS.TexCoord[0]*3-1)),
					max(0, PS.TexCoord[0]*3-2),
					1
				);
	
				float depth = PS.Depth/10;

				output.ExtraDepth = float4(
					min(1, depth*3),
					min(1, max(0, depth*3-1)),
					max(0, depth*3-2),
					1
				);
			}
			else
			{
				output.ExtraY = 0;
				output.ExtraX = 0;
				output.ExtraDepth = 0;
			}

			return output; 
		} 
		  
		technique Technique1 
		{ 
			pass Pass1 
			{
				CullMode = 2;
				ZEnable = true;

				VertexShader = compile vs_2_0 VertexShaderFunction();
				PixelShader = compile ps_2_a PixelShaderFunction(); 
			} 
		}
	]]
  return source
end
function calculateCoord(pixles, x, y)
  local r, g, b, a = dxGetPixelColor(pixles, x, y)
  if r and 0 < r + g + b and 0 < a then
    return (r + g + b) / 765
  end
end
