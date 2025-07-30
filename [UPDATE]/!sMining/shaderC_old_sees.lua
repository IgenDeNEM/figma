-- filename:
-- version: lua51
-- line: [0, 0] id: 0
local _dxCreateShader = dxCreateShader
local function processShaderProtection(r0_1, r1_1, r2_1)
	-- line: [1, 1] id: 1
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
local function protectedCreateShader(r0_2, r1_2, r2_2, r3_2, r4_2)
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
				r5_2 = r5_2 .. processShaderProtection(r9_2, r7_2, r8_2)
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
	local r10_2 = _dxCreateShader(r5_2, r1_2, r2_2, r3_2, r4_2)
	r5_2 = nil
	collectgarbage("collect")
	return r10_2
end
local seelangStatImgHand = false
local seelangStaticImage = {}
local seelangStaticImageToc = {}
local seelangStaticImageUsed = {}
local seelangStaticImageDel = {}
local processSeelangStaticImage = {}
seelangStaticImageToc[0] = true
seelangStaticImageToc[1] = true
local seelangStatImgPre = nil
function seelangStatImgPre()
	-- line: [1, 1] id: 3
	local r0_3 = getTickCount()
	if seelangStaticImageUsed[0] then
		seelangStaticImageUsed[0] = false
		seelangStaticImageDel[0] = false
	elseif seelangStaticImage[0] then
		if seelangStaticImageDel[0] then
			if seelangStaticImageDel[0] <= r0_3 then
				if isElement(seelangStaticImage[0]) then
					destroyElement(seelangStaticImage[0])
				end
				seelangStaticImage[0] = nil
				seelangStaticImageDel[0] = false
				seelangStaticImageToc[0] = true
				return
			end
		else
			seelangStaticImageDel[0] = r0_3 + 5000
		end
	else
		seelangStaticImageToc[0] = true
	end
	if seelangStaticImageUsed[1] then
		seelangStaticImageUsed[1] = false
		seelangStaticImageDel[1] = false
	elseif seelangStaticImage[1] then
		if seelangStaticImageDel[1] then
			if seelangStaticImageDel[1] <= r0_3 then
				if isElement(seelangStaticImage[1]) then
					destroyElement(seelangStaticImage[1])
				end
				seelangStaticImage[1] = nil
				seelangStaticImageDel[1] = false
				seelangStaticImageToc[1] = true
				return
			end
		else
			seelangStaticImageDel[1] = r0_3 + 5000
		end
	else
		seelangStaticImageToc[1] = true
	end
	if seelangStaticImageToc[0] and seelangStaticImageToc[1] then
		seelangStatImgHand = false
		removeEventHandler("onClientPreRender", getRootElement(), seelangStatImgPre)
	end
end
processSeelangStaticImage[0] = function()
	-- line: [1, 1] id: 4
	if not isElement(seelangStaticImage[0]) then
		seelangStaticImageToc[0] = false
		seelangStaticImage[0] = dxCreateTexture("files/tri.dds", "argb", true)
	end
	if not seelangStatImgHand then
		seelangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), seelangStatImgPre, true, "high+999999999")
	end
end
processSeelangStaticImage[1] = function()
	-- line: [1, 1] id: 5
	if not isElement(seelangStaticImage[1]) then
		seelangStaticImageToc[1] = false
		seelangStaticImage[1] = dxCreateTexture("files/headlight.dds", "argb", true)
	end
	if not seelangStatImgHand then
		seelangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), seelangStatImgPre, true, "high+999999999")
	end
end
local r10_0 = false
local function checkPreRenderSelfDirt(r0_6, r1_6)
	-- line: [1, 1] id: 6
	if r0_6 then
		r0_6 = true
	else
		r0_6 = false
	end
	if r0_6 ~= r10_0 then
		r10_0 = r0_6
		if r0_6 then
			addEventHandler("onClientPreRender", getRootElement(), preRenderSelfDirt, true, r1_6)
		else
			removeEventHandler("onClientPreRender", getRootElement(), preRenderSelfDirt)
		end
	end
end
local r12_0 = false
local function checkProcessHardHats(r0_7, r1_7)
	-- line: [1, 1] id: 7
	if r0_7 then
		r0_7 = true
	else
		r0_7 = false
	end
	if r0_7 ~= r12_0 then
		r12_0 = r0_7
		if r0_7 then
			addEventHandler("onClientPreRender", getRootElement(), processHardHats, true, r1_7)
		else
			removeEventHandler("onClientPreRender", getRootElement(), processHardHats)
		end
	end
end
local r14_0 = false
local function checkDoProcessShaders(r0_8, r1_8)
	-- line: [1, 1] id: 8
	if r0_8 then
		r0_8 = true
	else
		r0_8 = false
	end
	if r0_8 ~= r14_0 then
		r14_0 = r0_8
		if r0_8 then
			addEventHandler("onClientPedsProcessed", getRootElement(), doProcessShaders, true, r1_8)
		else
			removeEventHandler("onClientPedsProcessed", getRootElement(), doProcessShaders)
		end
	end
end
local dirtyShader = nil
local cloudTexture = nil
local dirtyShaderSource = [[ int gLighting < string renderState="LIGHTING"; >; float4 gGlobalAmbient < string renderState="AMBIENT"; >; int gDiffuseMaterialSource < string renderState="DIFFUSEMATERIALSOURCE"; >; int gSpecularMaterialSource < string renderState="SPECULARMATERIALSOURCE"; >; int gAmbientMaterialSource < string renderState="AMBIENTMATERIALSOURCE"; >; int gEmissiveMaterialSource < string renderState="EMISSIVEMATERIALSOURCE"; >; float4 gMaterialAmbient < string materialState="Ambient"; >; float4 gMaterialDiffuse < string materialState="Diffuse"; >; float4 gMaterialSpecular < string materialState="Specular"; >; float4 gMaterialEmissive < string materialState="Emissive"; >; float gMaterialSpecPower < string materialState="Power"; >; void MTAFixUpNormal( in out float3 OutNormal ) { if ( OutNormal.x == 0 && OutNormal.y == 0 && OutNormal.z == 0 ) OutNormal = float3(0,0,1); } float4 MTACalcGTABuildingDiffuse( float4 InDiffuse ) { float4 OutDiffuse; if ( !gLighting ) { OutDiffuse = InDiffuse; } else { float4 ambient = gAmbientMaterialSource == 0 ? gMaterialAmbient : InDiffuse; float4 diffuse = gDiffuseMaterialSource == 0 ? gMaterialDiffuse : InDiffuse; float4 emissive = gEmissiveMaterialSource == 0 ? gMaterialEmissive : InDiffuse; OutDiffuse = gGlobalAmbient * saturate( ambient + emissive ); OutDiffuse.a *= diffuse.a; } return OutDiffuse; } struct PSInput { float4 Position : POSITION0; float4 Diffuse : COLOR0; float2 TexCoord : TEXCOORD0; float1 Rot : TEXCOORD1; }; struct VSInput { float3 Position : POSITION0; float3 Normal : NORMAL0; float4 Diffuse : COLOR0; float2 TexCoord : TEXCOORD0; }; float4x4 gWorldViewProjection : WORLDVIEWPROJECTION; PSInput VertexShaderFunction(VSInput VS) { PSInput PS = (PSInput)0; MTAFixUpNormal(VS.Normal); PS.Rot = atan2(VS.Normal.y, VS.Normal.x); VS.Position += VS.Normal * 0.001; PS.Position = mul(float4(VS.Position, 1), gWorldViewProjection); PS.Diffuse = MTACalcGTABuildingDiffuse(VS.Diffuse); PS.TexCoord = VS.TexCoord; return PS; } texture CloudTexture; sampler2D CloudSampler = sampler_state { Texture = (CloudTexture); }; float4 PixelShaderFunction(PSInput PS) : COLOR0 { float4 cloud = tex2D(CloudSampler, PS.TexCoord*2); float mask = 1-abs(PS.Rot-3.14/2)/3.14; return float4(0.12549019607843137, 0.10980392156862746, 0.06901960784313725, cloud.r*mask)*PS.Diffuse; } technique Technique1 { pass Pass1 { DepthBias=-0.0002; VertexShader = compile vs_2_0 VertexShaderFunction(); PixelShader = compile ps_2_0 PixelShaderFunction(); } } ]]
local greenLightShaderSource = "ÁwRVxEbGBYDRFcQBRISGQMzHhERAgQSV0pXERsYFgNEX0dbV0ZbV0dZQXpPU1BKVE9BWg==Ú" -- UNUSED
local pointLightShaderSource = [[ÉA9YSctLiA1cmExLigvNQUoJyc0MiRhfGEnLS4gYRVSSVFPWFdNQVFPWVlNQVFPVFRIS1FPVFpBB2cLCAYTVEcUCgYLCzcIDgkTIw4BARIUAkdaRwFuAgEPGl1GXkBXWEJOXkBWVkJOXkBbW0dEXFVOeB4UFxkMS1gIFxEWDDoNFBo8ER4eWEVYHhQXGTRABxwEGBQEGBQGHQ8UUlhbVUAURFtdWkBnQUZYPz14ZXhpY3g=Ű]]
local orangeLightShaderSource = [[áKOay0nJCo/eGskOSolLC4PIi0tPjgua3ZrLSckKj94Y3tlcn1na3tTfWZ/c2N9Y2Z6aHM1PzwyJ2BzPCEyPTQ2HjY/J3s1PzwyJ3M+Nj80QB0UTxRSWFtVQAAUV1tYFAkUV1tYBQ8UXVIcWVFYQBQKCRREBlhJYGkyaS8lJig9aTlpdGlhJCwlPWQ5eyVgZmF4ZDl7JWByaS8lJihRJWVxMnFscT00IyF5Mj49YH1xMj49Y31xIXhqcTI+PXFscTI+PXtuDUQCCxweRl5AWVtCTl5AWltCTh5HTkVODUQCCxweRl5AXEJOXkBab3Z6KnNheid6PzYpP3ozPHI3PzYuemRneiprc3ohejw2NTsueipoSFVIQAUNBBxFGFlBR0AYWgRFGFlBU0gOBAcJHFxIC0hVSAQNGhhxWRIeHUJdURIeHUBdUQFYSlESHh1RTFESHh1bElsdFAMBWUBdUUFXeWBie3cnfnd8dzR9OzIlJ39ne3dneWV7dyd+bHcqdyUyIyIlOXdOLSEidW4zbg==é]]
local redLightShaderSource = [[űlTTAoAAw0YX0weCQggBQsEGCgFCgoZHwlMUUwKAAMNGF9EXUBMXEJdQEw1BRsEHB8FGwIADhVTWVpUQQYVR1BRZVpcW0FxXFNTQEZQFQgVU1laVEFwQ1hBXFBAXkFcUEBeQVlaQktQFhwfEQRDUCIVFCMAHwRYFhwfEQRDUBQ2X1BQQ0VTGhZQWllXQgUWRllFGhZQWllXQgUWUl9EGhZQWllXQgUWQVlkFggANAsXSEQCCAsFEFdECgsWCQUITUQfRAIICwUQV0QCDQoFCCcLCAtSIHJvcmJpcjQ+PTMmYXI+OzU6JgY9AjsqNz4ENzFyb3IiPSFyf3IlPSBGKiIWKTV9ZiAqKScyZiJme2YqIyghMi5uKi8hLjISKRYvPiMqECMlb313Vx4RXxNXSVdGQl5XBRIDAgUZVxEeGRYbNBgbGAVMVxseEB8DIxgnHg9WMzoAMzV2eWt2Mm12MDo5NyJ2PjkhGyM1Pho/MT4idmt2Mjkifjo/MT5SJgY9AjsqNz4ENzF+cjw9ID8zPntpcjs0enI6PSUfJzE6Hjs1OiZybHJmVkhWAEZPRh1GAA8IBwolCQoJFEZNW0YCDwAAExUDTBQDAioPAQ4SIg9DJSU2MCZ4YyUqLSIvACwvLDFjbH5ja3NtdHZjaGNrc21zcWNpYydqamNEb2RsdGp1ZG5kbCBuIG1tf2QiLSolKAcrKCs2ZG55ZDQrM2wpJTxsICs3Qx8aW15QX0NjWGdeT1JbYVJUGxdTXkUeGxcHGQdRHhsXBBkCHgwXShdjEQYXFhENQwUKDQIPIAwPDBFDSEMOAhtLU09DUk4HChAXAg0ABksTDBAyHhJFXUBeVmJdQRsdAhwDGxhWW1RUR0FXGEBXVmJdW1xGdltUVEdBVwlxUQxRó]]
local spotLightShaderSource = [[üjTSgwGBQseWUoZGgUeJgMNAh4uAwwMHxkPSldKDAYFCx5ZQltGSlpEU194VFhIVk9NUVJJVklNQ1geFBcZDEtYCxUZFBQrCBcMPBEeHg0LHVhFWB5YNDc5LGtwaXR4aHZhbXR4aHZvbXFyamN4PjQ3OSxreBs5NDsLKDcscD40WFtVQAcUUF1SUkFHURgUUlhbVUAHFERbRxgUUlhbVUAHFFBdRhgUUlhjDAIXUEMUDBEPBzMMEE9DBQ8MAhdQQw0MEQ4CD0pDGEMFDwwCF1BDBQpOIC8iDSEiITxuc25+dW4oIiEvOn1uIicpJjoaIR4nNisiGCstbnNuPiFBMmFsYTYuMy0lES4yemEnLS4gNWElYXxhLSQvJjUpaS0oJik1FS4RKDk3UlthUlQeDBdeUR9TFwkXBQceF0VSQ0JFWRdRXllWW3RYW1hFDBdbXlBKIj4eJRojMi8mHC8pamV3ai5xaiwmJSs+aiIlPQc/KSIGIy0iPmp3ai5lChFNCQwCDRExCjUMHQAJMwAGSUULChcIBAlMXkUMA01FDQoSKBAGDSkxWFZZRREPEQEfAVcRGBFKEVdYX1Bdcl5dXkMRGgwRVVhXV0RCVBtCQV44THRRX1BMfFFeXk1LXQMYXlFWWVR7V1RXShgXBRgQCBYAGBMYEAgWCApYam14cng8cXF4c3hwaHZpam14cnhwPHI8cXFjeD4xNjk0Gzc0Nyp4cmV5WQkWDlEUGAFRHRYNUVQVEB4RDS0WKRABHBUvHBpVWR0QC1BVWUlXSR9OZ2Jue2B7Z3VuM248Kzo7PCBuKCcgLyINISIhPGUjLzZmfmJuf2MqJz1NOSwjLihlPSI+YW06Ij8hKR0iPmRifWN9f3hkZykkKys4PihnPiAsISFXBCc4IxM+MTEiJDJsdyp3Ő]]
function spotShaderLine(lightId, wPosition, wNormal)
	-- line: [232, 234] id: 9
	return " if(l" .. lightId .. "e) { outputColor += CalcSpot(tex.rgb, l" .. lightId .. "p, l" .. lightId .. "d, " .. wPosition .. ", " .. wNormal .. "); } "
end
function redShaderLine(lightId, wPosition, wNormal)
	-- line: [236, 238] id: 10
	return " if(lr" .. lightId .. "e) { outputColor += RedSpot(tex.rgb, lr" .. lightId .. "p, lr" .. lightId .. "d, " .. wPosition .. ", " .. wNormal .. "); } "
end
function greenShaderLine(lightId, wPosition)
	-- line: [240, 242] id: 11
	return " if(lg" .. lightId .. "e) { outputColor += pow(max(0, 1-distance(" .. wPosition .. ", lg" .. lightId .. "p)/2), 2)*tex.rgb*greenDiffuse; } "
end
function pointShaderLine(lightId, wPosition)
	-- line: [244, 246] id: 12
	return " if(lp" .. lightId .. "e) { outputColor += pow(max(0, 1-distance(" .. wPosition .. ", lp" .. lightId .. "p)/8), 2)*tex.rgb*pointDiffuse*pointSurge + max(0, 1-distance(" .. wPosition .. ", lp" .. lightId .. "p+pointBulbDiff)/0.2)*tex.rgb*smallPointDiffuse*pointSurge; } "
end
function orangeShaderLine(lightId, wPosition)
	-- line: [248, 250] id: 13
	return " if(lo" .. lightId .. "e) { float3 col = orangeDiffuse; if(lo" .. lightId .. "m >= 0) { col = orangeMelt(lo" .. lightId .. "m); } outputColor += pow(max(0, 1-distance(" .. wPosition .. ", lo" .. lightId .. "p)/lo" .. lightId .. "i.x), 2)*tex.rgb*col*lo" .. lightId .. "i.y; } "
end
function shaderLines(numSpot, numPoint, numRed, numOrange, wPosition, wNormal)
	-- line: [252, 272] id: 14
	local shaderSource = ""
	for i = 1, numSpot, 1 do
		shaderSource = shaderSource .. spotShaderLine(i, wPosition, wNormal)
	end
	for i = 1, numRed, 1 do
		shaderSource = shaderSource .. redShaderLine(i, wPosition, wNormal)
	end
	for i = 1, numPoint, 1 do
		shaderSource = shaderSource .. pointShaderLine(i, wPosition)
	end
	for i = 1, numOrange, 1 do
		shaderSource = shaderSource .. orangeShaderLine(i, wPosition)
	end
	return shaderSource
end
function doFog(wPosition)
	-- line: [274, 276] id: 15
	return "outputColor*min(1, (36-distance(gCameraPosition, " .. wPosition .. "))/15)"
end
function initLines(numSpot, numPoint, numRed, numOrange)
	-- line: [278, 328] id: 16
	local shaderSource = [[

		float4 col1 = float4(1, 0.25, 0.25, 1);
		float4 col2 = float4(0.8, 0.5, 0.1, 1);
		float4 col3 = float4(1, 0.95, 0.85, 1);

		float p1 = 0;
		float p2 = 0.75/2;
		float p3 = 0.75;

		float p2l = 0.5;
	]]
	for i = 1, numSpot, 1 do
		shaderSource = shaderSource .. "float3 l" .. i .. "p; float3 l" .. i .. "d; bool l" .. i .. "e = false;"
	end
	for i = 1, numRed, 1 do
		shaderSource = shaderSource .. "float3 lr" .. i .. "p; float3 lr" .. i .. "d; bool lr" .. i .. "e = false;"
	end
	for i = 1, numPoint, 1 do
		shaderSource = shaderSource .. "float3 lp" .. i .. "p; bool lp" .. i .. "e = false;"
	end
	for i = 1, numOrange, 1 do
		shaderSource = shaderSource .. "float3 lo" .. i .. "p; float2 lo" .. i .. "i; bool lo" .. i .. "e = false; float lo" .. i .. "m = -1;"
	end
	if numSpot > 0 then
		shaderSource = shaderSource .. spotLightShaderSource
	end
	if numRed > 0 then
		shaderSource = shaderSource .. redLightShaderSource
	end
	if numPoint > 0 then
		shaderSource = shaderSource .. pointLightShaderSource
	end
	if numOrange > 0 then
		shaderSource = shaderSource .. orangeLightShaderSource
	end
	return shaderSource
end
function compileObjShader(numSpot, numPoint, numRed, numOrange, isScrolling)
	-- line: [330, 434] id: 17
	local shaderSource = [[Ú9mGUpNS0xaTRlpanBXSUxNGUIZX1VWWE0NGWlWSlBNUFZXGQMZaXZqcG1wdncJAhlfVVZYTQtpST0MESoGBhsNSVNJPSwxKiYmOy1ZUkkPBQYIHVpJPjkGGklTST0sMSomJjstWFJJDwUGCB1tXk06IwIfAE1XTTkoNS4iIj8pX1ZNEFZNHhkfGA4ZTTs+JAMdGBlNFk0LAQIMGV5NPQIeBBkwWV9eEAoQYH9jeWR5f34ACxBWXF9RRAIQZFVIc19fQlQQChBkdWhzf39idAALEFZcX1FEAxBwPh8CHREcUEpQPj8iPTE8QEtQDUtQFhwfEQRECERQFycfAhwUUEpQJz8iPDRLUBYcHxEERAg4DBhfb1dKVFxuUV1PaEpXUl1bTFFXVhgCGG93anR8bnF9b2hqd3J9e2xxd3YDGExdQExNSl05GV5tXEFNTEtcCRkFGUpNS1BXXhlNXEFNTEtcak1YTVwEGwkVbVxBTUxLXBsCGQcCGV9VVlhhFVJBLDUgIgANAjYOEw0FMQ4SCBUIDg9JQQcNDgAVUkEoDzEOEggVCA4PQUhBGkETBBUUEw9YeDUtNHA+NDc5LGxwETYINysxLDE3NnRpcXR4Pw83KjQ8cXYgISJjeCV4PjQ3OSxreBUMGRtQMTwzBz8iPDQePyI9MTx4cDY8PzEkY3AZPh4/Ij0xPHB5cCtwIjUkJSI+cD0lPHgZPh4/Ij1WNzp6dn4wOjk3ImUuZX8xATkkOjJ/bXYrdgYFHzgmIyJ2ADMkIjMuBT43MjMkECM4NSI/OThReQcCGD8hJCVxBwJ4cSpxAQIYPyEkJXEBAnFscXkBAhg/ISQleGFqcQECfwE+IjglOD4/cWxTcz4mP3s1PzwyJ2d7BQB9AzwgOic6PD1/c2J6f3M0BDwhPzcFOjYkAyE8OTYwJzo8PXpocwNQA34ENSgTPz8iNHBtcAYDfgQ1KBM/PyI0a3AAA34HAD8jcG1wHQQREzE8Mwc/Ijw0AD8jOSRpAAYHQT86RzkGGgAdAAYHQEcREBNSSTk6Rz4nBhsESVRJJD0oKggFCj4GGwUNJwYbBAgFQT94K1Y2FwoVGRRRQ1gKHQwNChZYKCtDWAVYCxkVCBQdClgrGRUIFB0KSFhFWAsZFQgUHQonCwxCIzYnYjliFic6NjcwJ2J/YmolFic6NjcwJ3JreWI/eWI=É]] .. initLines(numSpot, numPoint, numRed, numOrange)
	if isScrolling then
		shaderSource = shaderSource .. " float scroll = 0; "
	end
	shaderSource = shaderSource .. [[É7EF1FbWFZDBBdQdFZaUkVWZ1hEXkNeWFkXDRd0dnpyZXZnWBcLEQwRFxZjeD40NzksbHgIMSA9NAswOTw9Kh4tNjssMXEeH1khIjgfAQQFUSEiWFFLUTI+PT4jQVEKUQ==é]]
	if isScrolling then
		shaderSource = shaderSource .. "float4 tex = tex2D(Sampler0, float2(PS.TexCoord.x, PS.TexCoord.y+scroll));"
	else
		shaderSource = shaderSource .. "float4 tex = tex2D(Sampler0, PS.TexCoord);"
	end
	return shaderSource .. "float3 outputColor = float3(0, 0, 0);" .. shaderLines(numSpot, numPoint, numRed, numOrange, "PS.WPos", "PS.WNorm") .. "őuLVQcQAQAHG1UTGRoUAUFdÖ" .. doFog("PS.WPos") .. [[űshX1MHFgtdElpIUw5TBxYQGx0aAgYWUycWEBsdGgIGFkJTCFMDEgAAUyMSAABCUwhTJRYBWCw9IAswOTw9KnhleDs3NSgxND14LisHawdoeA49Kiw9IAswOTw9Kh4tNjssMTc2cHFjeFUFPC0wOQY9NDEwJ3VodTY6OCU8OTB1JSYKZgpldQU8LTA5Bj00MTAnEyA7NiE8Ojt9fG5hQRxBHEE=é]]
end
-- face
function compileDirtyShader(numSpot, numPoint, numRed, numOrange)
	-- line: [436, 565] id: 18
	local shaderSource = [[úFsZjUyNDMlMmYWFQ8oNjMyZj1mICopJzJyZhYpNS8yLykoZnxmFgkVDxIPCQh2fWYgKiknMnRmEiN6AjkVFQgeWkBaLj8iOTU1KD5KQVocFhUbDklaLSoVCVpAWi4/Ijk1NSg+S0FaHBYVGw5JWi00FQhpBElTST0sMSomJjstW1JJDwUGCB1YSTsGHUlTST0sMSomJjstWlJJFFJJGh0bHAodST86IAcZHB1LazBrLSckKj94axskOCI/IiQla3FrGwQYAh8CBAV7cGstJyQqP3lrHy4zCCQkOS9rcWsfDhMIBARYChxoY3g+NDc5LGt4FjcqNTk0eGJ4FhcKFRkUaGN4JWN4PjQ3OSxsIGx4Pw83KjQ8eGJ4DxcKFBxKcWosJiUrPn4yfmotHSU4Ji4cIy89GjglIC8pPiMlJGpwah0FGAYOHAMPHRoYBQAPCR4DBQRxaj55HAENDAscWR4tHAENDAscSVlFWQoNCxAXHlkNHAENDAscKg0YDRxEW0lVLRwBDQwLHFtCWUdCWR9ZNTY4LWp5FA0YGjg1Og42KzU9CTYqMC0wNjdxeT81NjgtankQNwk2KjAtMDY3eXB5InkrPC0sKzdsTAEZAEQKAAMNGFhEJQI8Ax8FGAUDAkBdRUBMCzsDHgAIRUIUFRZXTBFMCgADDRhfTCE4LS8NAA83YFhFW1N5WEVaVlsfF1FbWFZDBBd+WXlYRVpWWxceF0wXRVJDQkVZF1pCWx9+WXlYRVpWWxsXH1FkCAsFEFccV00DMwsWCABNX0QZRBILDQBEKTAlIg0cMRQqCxYJBQhMRA0KRAsREEQCCAsFEFdEKxFDNw0sMS4iL2NqYzhjKiVja2MMNjcNLDEuIi9tO2N+fmNzY2VlYww2Nw0sMS4iL206Y35+Y3NjZWVUdBshIBo7Jjk1OHoudGlpdGR0fXQbISAaOyY5NTh0aXQyODs1IGd8ZHhkeGV9b3QpdAQHHTokISBoSD4NGhwNEDsACQwNGi4dBgscAQcGQD47IQYYHRxIPjtBSBNIODshBhgdHEg4O0hVSEA4OyEGGB1QJHlga3AdBBEWOSgFIB4/Ij0xPHgGA34ePyI9MTx5a3AAA34CPyRwbXAxJDE+YngGA34ePyI9MTx2WA9aViAlWDgZBBsXGlgOX01WJiVYJhkFHwIfGRhWS1YbAxpeEBoZFwJCXiAlWCYZBR8CHxkYWlZyQ1teUhUlHQAeFiQbFwUiAB0YFxEGGx0cW0lSIiFcJhcKMR0dABZST1IkIVwmFwoxHR0AFklSIiE1G2JlWkYVCBV4YXR2VFlWYlpHWVFlWkZcQVxaWx1jZhtlWkZcQVxaWxwbTUxPDhVlZhtie1pHWBVSb3IfBhMRMz4xBT0gPjYcPSA/Mz56BAF8HD0gPzM+e2lyIDcmJyA8cgIBaXIvciEzPyI+NyByATNFKDUpIDd1ZXhlNiQoNSkgNxo2MSQxIGU+ZREgPTEwNyBleGVtIhEgPTEwNyB1bH5lOH5lÜ]] .. initLines(numSpot, numPoint, numRed, numOrange)
	if scroll then
		shaderSource = shaderSource .. " float scroll = 0; "
	end
	return shaderSource .. [[áyxWR8VFhgNSlkeOhgUHAsYKRYKEA0QFhdZQ1k6ODQ8KzgpNiowLTA2N0JZDRwBDQwLHFk6FRYMHS0cAQ1BNDMkemEyICwxLSQzcwVhAi0uNCUSICwxLSQzYXxhMiAsMS0kMx4yNSA1JGE6YRUkOTU0MyRhfGFpAi10GwEQIBEMAAEGEV1PVAlPVBIYGxUAQFQkHQwRGCccFRARBjIBGhcAHRsaXCQnPRoEAQBUJCddVE5UNztiLi0wUkIZQg==Ü]] .. "float4 tex = tex2D(Sampler0, PS.TexCoord);" .. [[ázZWhwWFRsOTloZFhUPHlpHWg4fAkg+UjkWFQ8eKRsXChYfCFZaKilULh8CORU2WURSHAQfDRZQWllXQhZbV0VdFgsWBxtXVEUeZmUYZFlCGwUYBwIZBB8ZBRhEdXB/ZCIoKyUwcGQ2ITAhL2R5ZCIoKyUwcGx0anV2cXB9dHV9cnRzfHB3dXd3QFtXR1lGR05PR0RORUZCQU9BRUBDQVtXR1lHQU5HRk5BR0BPQ0RGREBFQltzUxAfHAYXXQFZHhIAGFpIUwcWC10BFBFTTlNbARYHFhhdARQRU1lTARYHFhhoRglBSENIQBwNEEYaDwpIQkgcDRBGCUhCSEBZSEVIGg0cDQNGCUFBU0g=Ű]] .. "float3 outputColor = float3(0, 0, 0);" .. shaderLines(numSpot, numPoint, numRed, numOrange, "PS.WPos", "PS.WNorm") .. "óL0bD4pODk+ImwqICMtOHhké" .. doFog("PS.WPos") .. [[ÓFnamYyIz5oJ299ZjtmMiMlLigvNzMjZhIjJS4oLzczI3dmPWY2JzU1ZhYnNTV3Zj1mECM0MiM+M2BbUldWQRMOE1BcXkNaX1YTRUBsAGwDE2VWQUdWS2BbUldWQXVGXVBHWlxdGxoIE2NaS1ZfYFM7Mjc2IXNuczA8PiM6PzZzIyAMYAxjcwM6KzY/ADsyNzYhFSY9MCc6PD17emhzLnMucw==é]]
end
function compileMeltShader(numSpot, numPoint, numRed, numOrange)
	-- line: [567, 695] id: 19
	local shaderSource = [[őkoSxgfGR4IH0s7OCIFGx4fSxBLDQcECh9fSzsEGAIfAgQFS1FLOyQ4Ij8iJCVbUEsNBwQKH1lLNGBRTHdbW0ZQFA4UYHFsd3t7ZnAEDxRSWFtVQAcUY2RbRxQOFGBxbHd7e2ZwBQ8UUlhbVUAHFEUSCyo3KGV/ZREAHQYKChcBd35lOH5lNjE3MCYxZRMWDCs1MDFlPmUjKSokMXZlFSo2LDEsKis2FgwWZnllf2J/eXgGDRZQWllXQgQWYlNOdVlZRFIWDBZic251eXlkcgYNFlBaWVdCBRZ4WURbRyYrZ31nCQgVCgYLd3xnOnxnISsoJjNzP3NnIBAoNSsjZ31nEAgVCwN8ZyErKCYzcz9zZyAQKEY0KiIQLyMxFjQpLCMlMi8pKGZ8ZhEJFAoCEA8DERYUCQwDBRIPCQh9ZjIjPjIzNCNmIRIjPjJRJCM0YXFtcSIlIzg/NnElNCklJCM0AiUwJTRsc2F9BTQpJSQjNHNqcW9qcTc9PjAlYnEcBRASeBkUGy8XChQcKBcLEQwRFxZQWB4UFxkMS1gxFigXCxEMERcWWFFYA1gKHQwNChZYFQ0UUB4UF3kYDU1RMBcpFgoQDRAWF1VIUFVZHi4WCxUdUFcBAANCWQRZHxUWGA1KWTQtODoYFRouFgsVHTdsAx4BDQBETAoAAw0YX0wlAiIDHgENAExFTBdMHgkYGR4CTAEZAEQlAiIDHgENAEBMRAoAAw0YdUYNRlwSIhoHGRFcTlUIVSUmPBsFAAFVIxAHARANJh0UERAHMwAbFgEcGhtdIyY8GwUAAVUjJm5HThVOPj0nAB4bGk4+PU5TTkY+PScAHhsaR15VTj49QD4BHQcaBwEATlNOAxsCRggCAQ8aWkZhNzJPMQ4SCBUIDg9NQVBITUEGNg4TDQU3CAQWMRMOCwQCFQgOD0haQTEyTzUEGSIODhMFQVxBaT86Rz0MESoGBhsNUkk5Okc+OQYaSVRJJD0oKggFCj4GGwUNOQYaAB0ABgdBPzpHOQYaAB0ABk8hZmE3NjV0bx8cYRgBID0ib3JvAhsODC4jLBggPSMrASA9Ii4jZxkcYQEgPSIuI2Z0bz0qOzpYKjZ4CAtjeCV4PjQ3OSx4NT00LHhleGhjeD40NzksbHg1PSw5NBs3NDcqY3grOTUoND0qeAs5ZwoXCwIVV0daRxQGChcLAhU4FBMGEwJHHEczAh8TEhUCR1pHTwAzAh8TEhUCV05cRxpcRw==ő]] .. initLines(numSpot, numPoint, numRed, numOrange)
	if scroll then
		shaderSource = shaderSource .. " float scroll = 0; "
	end
	return shaderSource .. [[űCxYyUvLCI3cGMkACIuJjEiEywwKjcqLC1jeWMAAg4GEQITDBAKFwoMDXhjJS8sIjd3YxMqOyYvECsiJyZ6CDwPFBkOExUUUiopMxQKDw5aKilTWkBaOTU2NShKWgFaHBYVGw5OWhkVFlpHWhcfDhsWORUWFQhBWhNxF1kcFB0FUU9MUQFCWFEKURcdHhAFUQFRTFFZHBQdBVwBQlheWUBcAUJYSlEXHR4QBUVRElFMUR0UAwFlTQYKCVdJRQYKCVZJRRVMXkUGCglFWEUGCglPBk8JABcVTVVLUVBJRVVJRRVMRU5FBk8JABcVTVVLUEl4WEhWT01UWAhRQ1gFWB0UCx1YER5QFR0UDFhGRVgISlFYA1geFBcZDFgIWEVYUBUdFAxVCEpRV1AIS1VRIWN4anE3PT4wJWVxMnFscT00IyF5Mj49YH1xMj49Y31xIXhqcTI+PXFscTI+PXsyez00IyF5YX9mZH04GAgWDA0UGEgRGBMYWxJUXUpIEAgWChQYCBYNFBhIEQMYRRhdVEtdGFFeEFVdVEwYBgUYSAkRGEMYXlRFKiQxZTVleGVtKCApMWg1dGxqbTV3aDV0bH5lIykqJDFxZSZleGUpIDc1bSYqKXZpZSYqKXRpZTVsfmVBIi4tYXxhIi4tayJrLSQzMWlwbWFxb3Z0bWExaGFqYSJrLSQzMWlxbWFxb3NtYTFoemE8YQ==Ű]] .. "float4 tex = tex2D(Sampler0, PS.TexCoord)*col;" .. "float3 outputColor = float3(0, 0, 0);" .. shaderLines(numSpot, numPoint, numRed, numOrange, "PS.WPos", "PS.WNorm") .. "ÉD2ZDYhMDE2KmQiKCslMHBsó" .. doFog("PS.WPos") .. [[ÖqJXVEFFAlfEFhKUQxRBRQSGR8YAAQUUSUUEhkfGAAEFEBRClEBdBUHB1QkFQcHRVQPVCIRBgARDCccFRARBlRJVBcbGQQdGBFUAmMQPFA8U0M1BhEXBhswCwIHBhElFg0AFwoMDUtKWEMzChsGDzBFLSQhIDdleGUmKig1LCkgZTU2GnYadWUVLD0gKRYtJCEgNwMwYw0AFwoMDUtKWEMeQx5Dó]]
end
function compileOreShader(numSpot, numPoint, numRed, numOrange, isMetallic)
	-- line: [697, 820] id: 20
	local shaderSource = [[ÉBjYjE2MDchNmISEQssMjc2YjliJC4tIzZ2YhItMSs2Ky0sYnhiEg0RCxYLDQxyeWIkLi0jNldldwMyLxQ4OCUzd213AxIPFBgYBRNnbHcxOzg2I2R3AAc4JHdtdwMSDxQYGAUTZmx3MTs4QSA1cmEWDy4zLGF7YRUEGQIODhMFc3phPHphMjUzNCI1YRcSCC8xNDVhOmEnLS4gNXJhES5rGAIfAgQFS1FLOyQ4Ij8iJCVbUEsNBwQKH1lLPw4TKAQEGQ9LUUs/LjMoJCQ5L1tQSw0HBHUUAUZVOxoHGBQZVU9VOzonODQ5RU5VCE5VExkaFAFBDUFVEiIaBxkRVU9VIjonOTFOVRMZTSIsOXk1eW0qGiI/ISkbJCg6HT8iJyguOSQiI213bRoCHwEJGwQIGh0fAgcIDhkEAgN2bSt2GhkXAkVWOyI3NRcaFSEZBBoSJhkFHwIfGRheVhAaGRcCRVY/GCYZBR8CHxkYVl9WDVYEE0I2NzAsYi83LmokLi0jNnZqCywSLTErNistLG5za25iJRUtMC4ma2w6Ozh5Yj9iJC4tIzZxcFA9JDEzERwTJx8CHBQ+HwIdERxYUBYcHxEEQ1A5Hj4fAh0RHFBZUAtQAhUEBQIeUB0FHFh0PRo6GwYZFRhYVFwSGBsVAEcMR10TIxsGGBBdT1QJVCQnPRoEAQBUIhEGABEMJxwVEBEGMlovNDkuMzU0cgwJEzQqLy56DAlzeiF6CgkTNCovLnoKCXpnenIKCRM0Ki8uc2phegoJdAo1bxwGGwYAAU9STwIaA0cJAwAOG1tHOTxBPwAcBhsGAAFDT15GQ08IOAAdAws5BgoYPx0ABQo1VkFcWlscDhVlZhthUE12WlpHURUIFWNmG2FQTXZaWkdRDhVlZhtiZVpGFQgVeGF0dlRZVnotFQgWHioVCRMOExUUUiwpVCoVCRMOExUUU1QCAwBBWiopVC00FQgXWkdaNy47ORsWGS0VOUtVXXdWS1RYVRFvahd3VktUWFUQAhlLXE1MS1cZaWoCGUQZTVxBTUxLXBlWS1xtXEFNTEtoDVNIGwkFGAQNGkg7CQUYBA0aWEhVSBsJBRgEDRo3GxwJHA1IE0g8DRAcHRoNSFVIQAcaDTVhUE1BQEdQHA4VSA4Vá]]
	if isMetallic then
		shaderSource = shaderSource .. [[őagQRUEGRUUEwRBBg0IFRUEE1pBFQQZFRQTBEEPDggSBFpBEgAMEQ0EE0EyAAwRDQQTUEFIdWg7KSU4JC06Fzs8KTwtaDNoHC0wPD06LWh1aGAvJCE8PC06YXNoNXNoOyklOCQtOmhGFScrNiojNHRme2Y1Jys2KiM0GTUyJzIjZj1mEiM+MjM0I2Z7Zm4oKS81I299ZgciIjRHIjQ0Emd6ZxA1Jjd8ZwYjIzUiNDQRZ3pnEDUmN3xnOnxnÓ]]
	end
	shaderSource = shaderSource .. initLines(numSpot, numPoint, numRed, numOrange) .. [[óNtbigiIS86fW4pDS8jKzwvHiE9JzonISBudG4NDwMLHA8eAR0HGgcBAHVuKCIhLzp6bh4nNisiHSYvWj4/KBwvNDkuMzU0cgoJEzQqLy56CglzemB6GRUWFQhqeiF6PDY1Oy5uei4/Inpnei4/Imgecgk7N08/Iyo9f2NvHxxhGyo3DCAgPStmdG8pIyAuO3xvIDo7Pzo7DCAjID1vcm8pIyAuO3xnf2Nvf2Nvf2ZYY3g=ü]] .. shaderLines(numSpot, numPoint, numRed, numOrange, "PS.WPos", "PS.WNorm")
	if isMetallic then
		shaderSource = shaderSource .. [[Üj6SgwGBQseSg0GAx5KV0oeDxJYLkI5CwcaBg9GNHdqZhYVaBIjPgUpKTQib2g0fWYgKiknMnVZeTc2MCN5ZHktPCFrHXEKODQpNTwra3V5CQp1WyEQDTYaGgcRX0ZcWwcSF1hFW0BOVRMZGhRvG08LCE9STx8AGEcIAwYbQ09fQVpGVE8IAwZqHkpXShoFHUINBgMeRkpbRF9DUUoEBQMQSldUdDo7Jjk1OD0uMXw6Oz0ufW90Mjg7NSBndCJmDwMRIg8URltGCAkUCwcKDxwDTjY1SDE2CRVsTEFMCy8NAQkeDTwDHwUYBQMCRVdMCgADDRhCYixif2IyLTVqJi02aiwtKzhuYjQrJzUGKzBMZWBseXxlZnl3bCM5ODw5OA8jICM+bHFsIzk1QUVAQXZaWVpHHx0EGFFSHwUbABwfHQQVHhUyVV5bRhhcGwkSŐ]]
	end
	return shaderSource .. [[üA9YTMkNTQzL2EnLS4gNXVpLjQ1MTQ1Ai4tLjNrVjs/OH5nenY7Ny5+Znp2fmRjezI/JSI3ODUzfjBXc1FdVUJRYF9DWURZX14cEGBjHmdgX0MZGR93RkJeXltXAxIPWRZeTFcKVwMSFB8ZHgYCElcjSSwqIScgODwseGkyaTkoOjppGSg6OnhpMmkfLGIQFgcaMQoDBgcQQl9CAQ0PEgsOB0IUET1RPVJEZBIhNjAhPBcsJSAhNgIxKicwLSsqbG1/ZBQtTzcqIxwnLisqPW9ybywgIj8mIypvPzwQfBB/b2o6AxIPBjkCCw4PGCwfBAkeAwUEQkNRShdKF0o=ö]]
end
-- wall
function compileDirtShader(numSpot, numPoint, numRed, numOrange)
	-- line: [822, 923] id: 21
	return [[ÓwlVwMSDwMCBRJXEx4FA0xXBBYaBxsSBVcTHgUDJBYaBxsSBVdKVwQWGgcbEgUoBAMWAxJXDFdMGCk0ODk+KWxxbGQoJT44ZXdsMXdsOCk0ODk+KWwoKTw4JHdsPy0hPCApPmwoKTw4JB8tITxYND0qeGV4Kzk1KDQ9KgcrLDksPXgjeAw9ICwtKj14ZXhwPD0oLDBxY3glY3gsPSAsLSo9eDZpBhsECAVSSRoIBBkFDBtJBwYbBAgFOggEGQUMG0lUSRoIBBkFDBs2Gh0IHQxJEkk9DBEdHBs5XBkEGRFXVktUWFUQAhlEAhlfVVZYTQoZW1hKXGlWSgIZX1VWWE0ZW1hKXHpWSgIZX1VWWE1ZeTs4KjwKMDdieQ==Ö]] .. initLines(numSpot, numPoint, numRed, numOrange) .. [[évMVhAaGRcCRVYUFxUdMh8EVktWEBoZFwJFXkZaVkdaVkZfTVYFAnEDBBIFUSEiOB8BBAVRClEXHR4QBUVRIR4CGAUYHh9RS1EhPiI4cSU4Pj9BSlEXHR4QBUNRJRQJMh4eAxVRS1ElNCkyPj4jNUFKUQxCeWIxNjA3ITZiFBELLDI3NmI5YiQuLSM2cWISLTErNistLGJ4YjRke2d9YH17egQPFFJYW1VABhRgUUx3W1tGUBQOFGBxbHd7e2ZwZFRfRBlfRAIICwUQUBxQRAMzCxYIADINARM0FgsOAQcQDQsKRF5BYRYOEw0FFwgEFhETDgsEAhUIDg96YRESCC8xNDVhFyQzNSQ5ElA4MTQ1IhYlPjMkOT8+eAYDGT4gJSRwBgN5cCtwAAMZPiAlJHAAVQZ1aHV9BQYcOyUgIXxlbnUFBnsFOiY8ITw6O3VodTggOX0zOTp0FQBAXCInWiQbBx0AHRsaWFRFXVhUEyMbBhgQIh0RAyQGGx4RF2YSDwkIT11GNjVIMgMeJQkJFAJGW0YwNUgyAx4lCQkUAl1GFAMSRDE2KmQUF39kOWQiKCslMHdkIwclKSE2JRQrNy0wLSsqZH5kBwU2e3Nkd2Z5ZX9if3l4DRZQWllXQgIWZl9OU1plXldSU0RwQ1hVQkojJSRiGhkDJDo/PmoaGWNqcGoJBQYFGHpqMWosJiUrPn5qPi8yaUlUSR0MEVstQQ0AGx06CAQZBQwbRUk5Okc9DBEqBgYbDUBSSQ8zX1xSRxNXVkNHWxMOE0dWSwF3G1dWQ0dbYFJeQ19WQR8THmNgHVcDMi8UODglM355JWx3MTs4NiNjdzk4JTo2O3dqdyMyL2UTfzk4QjAvIy4RIy8yLicwbmJvEhFsFic6AS0tMCZreWIkLi0jNnFiLDRoSFVIBgcaBQkEARINQA4EBwkcW0AGBxoFCQRGGkJaRVlESAYHGlI/Mz58NXhgf2N+cjw9ID8zPnwweGB/Y3t7aXI0Pj0zJmFyIj0hRGR5ZCIoKyUwd2xkJiU3IRQrN2o8ZGlkFBdqECE8BysrNiBqPG54S1ZNUhoZCx07FwtYVVgcHQgMEFJIVkBNUhoZCx0rERZUWBoZC2wJPAMfQhVMQUw8P0I4CRQvAwMeCEIURl9CWUYODR8JPwUCTEdMZQEAFRENT1VLXVBPBwQWACYKFklFBwQWADUKFksfSDU2SzEAHSZIJyc6LGYxYnpmcHt6eH5oYXNoLiQnKTx7aCc9PDg9PAsnJCc6aGpXSgwGBQseWUJaRkpaRkpaQ1FKá]] .. shaderLines(numSpot, numPoint, numRed, numOrange, "pos", "nv") .. [[ŐGlZyErKCYzZyNnemcmJTRvIygzbykxa2chKygmM3RvaiUmNCIULilrZyUmNCIEKDRrZ3dubm5XbHclMiMiJTl3MTs4NiNjfw==Á]] .. doFog("pos") .. [[ÁKpYS9na3picGs2az8uKCMlIjo+LmsvIjk/Hy4zazBrOyo4OGsbe2swax0uOT8uMxgjKi8uOWt2a1g7NzUoMTQ9eC4rB2sHaHgOPSosPSALMDk8PSoeLTY7LDE3NnBxY3gIMSA9NAswOTw9KnhleDs3TCE8JSApbDw/E38TfGwcJTQpIB8kLSgpPgo5Ii84JSMiZGV3bDFsMWw=Ö]]
end
objectShader = false
insideDirtyShader = false
scrollShader = false
currentActiveShaftShader = false
local createdShaders = {}
local numStreamedSpotLights = 0
local numStreamedPointLights = 0
local numStreamedOrangeLights = 0
local numStreamedRedLights = 0
local maxSpotLights = 0
local maxPointLights = 0
local maxOrangeLights = 0
local maxRedLights = 0
local shaderBasePos = {0, 0, 9000}
local shaderBaseCos = 0
local shaderBaseSin = 0
local noiseTexture = false
function setMeltingMetal(oreType)
	-- line: [948, 950] id: 22
	dxSetShaderValue(meltShader, "metalColor", oreTypes[oreType].ingot)
end
local surgeProgress = 1
local surgeStrength = 1
nextSurge = false
local shouldRefreshSpotLights = false
local shouldRefreshPointLights = false
local shouldRefreshOrangeLights = false
local shouldRefreshRedLights = false
local machineScrollRate = 7000 / conveyorLength * 1.35
local machineScroll = 0
local machineScrollTurbo = 1
local pointLights = {}
local orangeLights = {}
local redLights = {}
local spotLights = {}
streamPointLights = {}
local pointLightStart = {}
function deleteShaders()
	-- line: [973, 1022] id: 23
	pointLightStart = {}
	for k in pairs(createdShaders) do
		if isElement(createdShaders[k]) then
			destroyElement(createdShaders[k])
		end
		createdShaders[k] = nil
		coroutine.yield()
	end
	objectShader = false
	insideDirtyShader = false
	scrollShader = false
	currentActiveShaftShader = false
	if isElement(noiseTexture) then
		destroyElement(noiseTexture)
	end
	noiseTexture = nil
	for k, v in pairs(oreTypes) do
		if isElement(v.shader) then
			destroyElement(v.shader)
		end
		v.shader = nil
		if isElement(v.texture) then
			destroyElement(v.texture)
		end
		v.texture = nil
		if isElement(v.metallicTexture) then
			destroyElement(v.metallicTexture)
		end
		v.metallicTexture = nil
		coroutine.yield()
	end
	for x in pairs(streamPointLights) do
		for y in pairs(streamPointLights[x]) do
			if isElement(streamPointLights[x][y]) then
				destroyElement(streamPointLights[x][y])
			end
			streamPointLights[x][y] = nil
			coroutine.yield()
		end
	end
	shouldRefreshSpotLights = false
	shouldRefreshPointLights = false
	shouldRefreshOrangeLights = false
	shouldRefreshRedLights = false
	streamPointLights = {}
	pointLights = {}
	orangeLights = {}
	redLights = {}
	spotLights = {}
	numStreamedSpotLights = 0
	numStreamedPointLights = 0
	numStreamedOrangeLights = 0
	numStreamedRedLights = 0
	checkDoProcessShaders(false)
	processDirtyShader()
end
function initShaders()
	-- line: [1024, 1147] id: 24
	local compiledShader = false
	for k in pairs(createdShaders) do
		if isElement(createdShaders[k]) then
			destroyElement(createdShaders[k])
		end
		createdShaders[k] = nil
		coroutine.yield()
	end
	createdShaders = {}
	maxSpotLights = 5
	maxPointLights = 40
	maxOrangeLights = 5
	maxRedLights = 2
	local r1_24 = false -- UNUSED
	if isElement(objectShader) then
		destroyElement(objectShader)
	end
	objectShader = nil
	if isElement(insideDirtyShader) then
		destroyElement(insideDirtyShader)
	end
	insideDirtyShader = nil
	compiledShader = compileDirtyShader(maxSpotLights, maxPointLights, maxRedLights, maxOrangeLights)
	coroutine.yield()
	insideDirtyShader = protectedCreateShader(compiledShader, 0, 40, false, "all")
	coroutine.yield()
	processDirtyShader()
	coroutine.yield()
	table.insert(createdShaders, insideDirtyShader)
	compiledShader = compileObjShader(maxSpotLights, maxPointLights, maxRedLights, maxOrangeLights)
	coroutine.yield()
	objectShader = protectedCreateShader(compiledShader, 0, 40, false, "all")
	coroutine.yield()
	engineApplyShaderToWorldTexture(objectShader, "*")
	table.insert(createdShaders, objectShader)
	if isElement(meltShader) then
		destroyElement(meltShader)
	end
	meltShader = nil
	compiledShader = compileMeltShader(maxSpotLights, maxPointLights, maxRedLights, maxOrangeLights)
	coroutine.yield()
	meltShader = protectedCreateShader(compiledShader, 0, 40, false, "all")
	coroutine.yield()
	engineRemoveShaderFromWorldTexture(objectShader, "v4_mine_ingot")
	engineApplyShaderToWorldTexture(meltShader, "v4_mine_ingot")
	table.insert(createdShaders, meltShader)
	compiledShader = compileObjShader(maxSpotLights, maxPointLights, maxRedLights, maxOrangeLights, true)
	coroutine.yield()
	scrollShader = protectedCreateShader(compiledShader, 0, 40, false, "all")
	coroutine.yield()
	engineRemoveShaderFromWorldTexture(objectShader, "*_scroll")
	engineApplyShaderToWorldTexture(scrollShader, "*_scroll")
	table.insert(createdShaders, scrollShader)
	if isElement(currentActiveShaftShader) then
		destroyElement(currentActiveShaftShader)
	end
	currentActiveShaftShader = nil
	compiledShader = compileDirtShader(maxSpotLights, maxPointLights, maxRedLights, maxOrangeLights)
	coroutine.yield()
	currentActiveShaftShader = protectedCreateShader(compiledShader)
	coroutine.yield()
	dxSetShaderValue(currentActiveShaftShader, "dirt", dirtTexture)
	dxSetShaderValue(currentActiveShaftShader, "basePos", shaderBasePos)
	dxSetShaderValue(currentActiveShaftShader, "baseCos", shaderBaseCos)
	dxSetShaderValue(currentActiveShaftShader, "baseSin", shaderBaseSin)
	table.insert(createdShaders, currentActiveShaftShader)
	if isElement(noiseTexture) then
		destroyElement(noiseTexture)
	end
	noiseTexture = nil
	noiseTexture = dxCreateTexture("files/noise.dds")
	coroutine.yield()
	for k, v in pairs(oreTypes) do
		if isElement(v.shader) then
			destroyElement(v.shader)
		end
		v.shader = nil
		if isElement(v.texture) then
			destroyElement(v.texture)
		end
		v.texture = nil
		if isElement(v.metallicTexture) then
			destroyElement(v.metallicTexture)
		end
		v.metallicTexture = nil
		compiledShader = compileOreShader(maxSpotLights, maxPointLights, maxRedLights, maxOrangeLights, v.metallic)
		coroutine.yield()
		v.shader = protectedCreateShader(compiledShader, 0, 40, false, "all")
		coroutine.yield()
		table.insert(createdShaders, v.shader)
		if v.metallic then
			v.metallicTexture = dxCreateTexture("files/ores/" .. k .. "_metallic.dds", "dxt1")
			coroutine.yield()
			dxSetShaderValue(v.shader, "glitter", v.metallicTexture)
			dxSetShaderValue(v.shader, "noise", noiseTexture)
		end
		v.texture = dxCreateTexture("files/ores/" .. k .. ".dds", "dxt1")
		coroutine.yield()
		dxSetShaderValue(v.shader, "oreTexture", v.texture)
	end
	checkDoProcessShaders(true, "low-99999999999")
	for i = 1, #createdShaders, 1 do
		dxSetShaderValue(createdShaders[i], "pointSurge", surgeProgress * surgeStrength)
	end
	compiledShader = false
	collectgarbage("collect")
end
function refreshActiveShaftShader()
	-- line: [1150, 1160] id: 25
	if isElement(currentActiveShaftShader) then
		if isElement(currentActiveDepthRT) then
			dxSetShaderValue(currentActiveShaftShader, "depth", currentActiveDepthRT)
		end
		if isElement(currentActiveNormalRT) then
			dxSetShaderValue(currentActiveShaftShader, "normal", currentActiveNormalRT)
		end
	end
end
function refreshActiveShaftShaderBasePos(baseX, baseY, baseCos, baseSin)
	-- line: [1163, 1175] id: 26
	shaderBasePos[1] = baseX
	shaderBasePos[2] = baseY
	shaderBaseCos = baseCos
	shaderBaseSin = baseSin
	if isElement(currentActiveShaftShader) then
		dxSetShaderValue(currentActiveShaftShader, "basePos", shaderBasePos)
		dxSetShaderValue(currentActiveShaftShader, "baseCos", shaderBaseCos)
		dxSetShaderValue(currentActiveShaftShader, "baseSin", shaderBaseSin)
	end
end
function setStreamedLights(spotX, spotY, justLoaded)
	-- line: [1177, 1202] id: 27
	if not streamPointLights[spotX] then
		streamPointLights[spotX] = {}
	end
	if isElement(streamPointLights[spotX][spotY]) then
		destroyElement(streamPointLights[spotX][spotY])
	end
	streamPointLights[spotX][spotY] = nil
	local lampPosX = 0 + spotX * 6
	local lampPosY = 0 + spotY * 6
	local lampPosZ = 9000 + (spotX < -1 and 2 or 0)
	streamPointLights[spotX][spotY] = createObject(modelIds.v4_mine_lamp, lampPosX, lampPosY, lampPosZ, 0, 0, 0, false)
	setElementInterior(streamPointLights[spotX][spotY], 0)
	setElementDimension(streamPointLights[spotX][spotY], currentMine)
	if not justLoaded then
		if not pointLightStart[spotX] then
			pointLightStart[spotX] = {}
		end
		pointLightStart[spotX][spotY] = getTickCount()
		local soundEffect = playSound3D("files/minesound/lamp.wav", lampPosX, lampPosY, lampPosZ)
		setElementInterior(soundEffect, 0)
		setElementDimension(soundEffect, currentMine)
		setSoundMaxDistance(soundEffect, 20)
	end
end
function removeObjShaderFromShaftCol(objectElement)
	-- line: [1205, 1209] id: 28
	if isElement(objectShader) then
		engineRemoveShaderFromWorldTexture(objectShader, "*", objectElement)
	end
end
function sortPointLights(a, b)
	-- line: [1211, 1213] id: 29
	return a[3] < b[3]
end
function sortOrangeLights(a, b)
	-- line: [1215, 1217] id: 30
	return a[7] < b[7]
end
function refreshShaderPointLights()
	-- line: [1220, 1251] id: 31
	local sortedPointLights = {}
	for i = 1, #pointLights, 1 do
		local pointLightData = pointLights[i]
		if pointLightData[3] then
			table.insert(sortedPointLights, {
				pointLightData[1],
				pointLightData[2],
				getDistanceBetweenPoints2D(selfPosX, selfPosY, pointLightData[1], pointLightData[2]),
				pointLightData[4]
			})
		end
	end
	table.sort(sortedPointLights, sortPointLights)
	for i = 1, math.min(maxPointLights, #sortedPointLights), 1 do
		for j = 1, #createdShaders, 1 do
			dxSetShaderValue(createdShaders[j], "lp" .. i .. "p", sortedPointLights[i][1], sortedPointLights[i][2], 9000 + (sortedPointLights[i][4] and 2 or 0))
			dxSetShaderValue(createdShaders[j], "lp" .. i .. "e", true)
		end
	end
	for i = #sortedPointLights + 1, maxPointLights, 1 do
		for j = 1, #createdShaders, 1 do
			dxSetShaderValue(createdShaders[j], "lp" .. i .. "e", false)
		end
	end
end
function refreshShaderOrangeLights()
	-- line: [1255, 1282] id: 32
	local sortedOrangeLights = {}
	for i = 1, #orangeLights, 1 do
		local orangeLightData = orangeLights[i]
		table.insert(sortedOrangeLights, {
			orangeLightData[1],
			orangeLightData[2],
			orangeLightData[3],
			orangeLightData[4],
			orangeLightData[5],
			orangeLightData[6],
			getDistanceBetweenPoints2D(selfPosX, selfPosY, orangeLightData[1], orangeLightData[2])
		})
	end
	table.sort(sortedOrangeLights, sortOrangeLights)
	for i = 1, math.min(maxOrangeLights, #sortedOrangeLights), 1 do
		for j = 1, #createdShaders, 1 do
			dxSetShaderValue(createdShaders[j], "lo" .. i .. "p", sortedOrangeLights[i][1], sortedOrangeLights[i][2], sortedOrangeLights[i][3])
			dxSetShaderValue(createdShaders[j], "lo" .. i .. "i", sortedOrangeLights[i][4], sortedOrangeLights[i][5])
			dxSetShaderValue(createdShaders[j], "lo" .. i .. "m", sortedOrangeLights[i][6])
			dxSetShaderValue(createdShaders[j], "lo" .. i .. "e", true)
		end
	end
	for i = #sortedOrangeLights + 1, maxOrangeLights, 1 do
		for j = 1, #createdShaders, 1 do
			dxSetShaderValue(createdShaders[j], "lo" .. i .. "e", false)
		end
	end
end
function refreshShaderSpot()
	-- line: [1284, 1304] id: 33
	for i = 1, math.min(maxSpotLights, #spotLights), 1 do
		for j = 1, #createdShaders, 1 do
			dxSetShaderValue(createdShaders[j], "l" .. i .. "p", spotLights[i][1], spotLights[i][2], spotLights[i][3])
			dxSetShaderValue(createdShaders[j], "l" .. i .. "d", spotLights[i][4], spotLights[i][5], spotLights[i][6])
			dxSetShaderValue(createdShaders[j], "l" .. i .. "e", true)
		end
	end
	for i = #spotLights + 1, maxSpotLights, 1 do
		for j = 1, #createdShaders, 1 do
			dxSetShaderValue(createdShaders[j], "l" .. i .. "e", false)
		end
	end
end
function refreshRedShader()
	-- line: [1306, 1320] id: 34
	for i = 1, math.min(maxRedLights, #redLights), 1 do
		for j = 1, #createdShaders, 1 do
			dxSetShaderValue(createdShaders[j], "lr" .. i .. "p", redLights[i][1], redLights[i][2], redLights[i][3])
			dxSetShaderValue(createdShaders[j], "lr" .. i .. "d", redLights[i][4], redLights[i][5], redLights[i][6])
			dxSetShaderValue(createdShaders[j], "lr" .. i .. "e", true)
		end
	end
	for i = #redLights + 1, maxRedLights, 1 do
		for j = 1, #createdShaders, 1 do
			dxSetShaderValue(createdShaders[j], "lr" .. i .. "e", false)
		end
	end
end
function dxDrawLightCone(sourceX, sourceY, sourceZ, targetX, targetY, targetZ, coneSize, coneColor)
	-- line: [1322, 1339] id: 35
	local rayHit, surfaceX, surfaceY, surfaceZ = processLineOfSight(sourceX, sourceY, sourceZ, targetX, targetY, targetZ)
	local coneScale = 1
	if rayHit then
		coneScale = getDistanceBetweenPoints3D(sourceX, sourceY, sourceZ, surfaceX, surfaceY, surfaceZ) / getDistanceBetweenPoints3D(sourceX, sourceY, sourceZ, targetX, targetY, targetZ)
	end
	seelangStaticImageUsed[0] = true
	if seelangStaticImageToc[0] then
		processSeelangStaticImage[0]()
	end
	dxDrawMaterialLine3D(sourceX, sourceY, sourceZ, surfaceX or targetX, surfaceY or targetY, surfaceZ or targetZ, seelangStaticImage[0], coneSize * 4 * coneScale, coneColor)
end
local streamedHardHats = {}
local r52_0 = false -- UNUSED
function processHardHats()
	-- line: [1345, 1366] id: 36
	local haveHardHats = true
	for playerElement, objectElement in pairs(streamedHardHats) do
		haveHardHats = false
		if not isElement(playerElement) or not isElement(objectElement) or getElementModel(objectElement) ~= modelIds.v4_mining_hardhat then
			streamedHardHats[playerElement] = nil
		end
	end
	if haveHardHats then
		checkProcessHardHats(false)
	end
end
function setStreamedHardHat(playerElement, objectElement)
	-- line: [1368, 1372] id: 37
	streamedHardHats[playerElement] = objectElement
	checkProcessHardHats(true)
end
function processOrange(lightCounter, lightPosX, lightPosY, lightPosZ, lightRadius, lightBrightness, meltProgress)
	-- line: [1375, 1417] id: 38
	if getDistanceBetweenPoints2D(lightPosX, lightPosY, selfPosX, selfPosY) <= 40 + lightRadius then
		lightCounter = lightCounter + 1
		meltProgress = tonumber(meltProgress) or -1
		if not orangeLights[lightCounter] then
			orangeLights[lightCounter] = {}
		end
		if orangeLights[lightCounter][1] ~= lightPosX then
			orangeLights[lightCounter][1] = lightPosX
			shouldRefreshOrangeLights = true
		end
		if orangeLights[lightCounter][2] ~= lightPosY then
			orangeLights[lightCounter][2] = lightPosY
			shouldRefreshOrangeLights = true
		end
		if orangeLights[lightCounter][3] ~= lightPosZ then
			orangeLights[lightCounter][3] = lightPosZ
			shouldRefreshOrangeLights = true
		end
		if orangeLights[lightCounter][4] ~= lightRadius then
			orangeLights[lightCounter][4] = lightRadius
			shouldRefreshOrangeLights = true
		end
		if orangeLights[lightCounter][5] ~= lightBrightness then
			orangeLights[lightCounter][5] = lightBrightness
			shouldRefreshOrangeLights = true
		end
		if orangeLights[lightCounter][6] ~= meltProgress then
			orangeLights[lightCounter][6] = meltProgress
			shouldRefreshOrangeLights = true
		end
	end
	return lightCounter
end
local additionalOranges = {}
function addAdditionalOrange(lightPosX, lightPosY, lightPosZ, r3_39, r4_39)
	-- line: [1421, 1423] id: 39
	table.insert(additionalOranges, {
		lightPosX,
		lightPosY,
		lightPosZ,
		r3_39,
		r4_39
	})
end
function doProcessShaders()
	-- line: [1425, 1905] id: 40
	if loaderA >= 1 then
		return
	end
	local currentTick = getTickCount()
	if nextSurge then
		local currentProgress = (currentTick - nextSurge) / 150
		if currentProgress > 1 then
			nextSurge = false
			currentProgress = 1
		end
		surgeProgress = 1 - math.cos(currentProgress * math.pi / 2) * 0.75
		for i = 1, #createdShaders, 1 do
			dxSetShaderValue(createdShaders[i], "pointSurge", surgeProgress * surgeStrength)
		end
	end
	local strengthScalar = 1 - ((mineMachineData.machineRunning or mineMachineData.forceMachine) and 0.2 or 0)
	strengthScalar = strengthScalar - (mineMachineData.furnaceRunning and 0.2 or 0)
	if strengthScalar ~= surgeStrength then
		surgeStrength = strengthScalar
		for i = 1, #createdShaders, 1 do
			dxSetShaderValue(createdShaders[i], "pointSurge", surgeProgress * surgeStrength)
		end
	end
	machineScroll = (machineScroll + mineDelta / machineScrollRate * machineScrollTurbo * math.min(1, mineMachineData.machineRunProgress)) % 1
	dxSetShaderValue(scrollShader, "scroll", machineScroll)
	setElementRotation(mineMachineData.mineMachine3, machineScroll * 360, 0, 0)
	local spotLightCounter = 0
	local streamRange = 8
	local pointLightCounter = 1
	for coordX = minePosX - streamRange, minePosX + streamRange, 1 do
		if streamPointLights[coordX] then
			for coordY = minePosY - streamRange, minePosY + streamRange, 1 do
				if streamPointLights[coordX][coordY] then
					local lightState = true
					if pointLightStart[coordX] and pointLightStart[coordX][coordY] then
						if currentTick - pointLightStart[coordX][coordY] > 600 then
							pointLightStart[coordX][coordY] = nil
						end
						if math.random() < 0.9 then
							lightState = 150 < currentTick % 250
						else
							lightState = false
						end
					end
					if lightState then
						if not pointLights[pointLightCounter] then
							pointLights[pointLightCounter] = {}
						end
						local lightPosX = 0 + coordX * 6
						local lightPosY = 0 + coordY * 6
						if lightPosX ~= pointLights[pointLightCounter][1] or lightPosY ~= pointLights[pointLightCounter][2] then
							pointLights[pointLightCounter][1] = lightPosX
							pointLights[pointLightCounter][2] = lightPosY
							pointLights[pointLightCounter][3] = pointLights[pointLightCounter][3] and true or false
							pointLights[pointLightCounter][4] = coordX < -1
							shouldRefreshPointLights = true
						end
						pointLightCounter = pointLightCounter + 1
					end
				end
			end
		end
	end
	local numPointLights = numStreamedPointLights
	for i = #pointLights, 1, -1 do
		if pointLightCounter <= i then
			if pointLights[i][3] then
				shouldRefreshPointLights = true
				numPointLights = numPointLights - 1
			end
			table.remove(pointLights, i)
		elseif getDistanceBetweenPoints2D(selfPosX, selfPosY, pointLights[i][1], pointLights[i][2]) <= 48 then
			local distanceFactor = math.max(0, (getDistanceBetweenPoints2D(pointLights[i][1], pointLights[i][2], selfCamX, selfCamY) - 1) / 4)
			local lightOffsetZ = pointLights[i][4] and 2 or 0
			seelangStaticImageUsed[0] = true
			if seelangStaticImageToc[0] then
				processSeelangStaticImage[0]()
			end
			dxDrawMaterialLine3D(pointLights[i][1], pointLights[i][2], 9002.25 + lightOffsetZ, pointLights[i][1], pointLights[i][2], 8999.5, seelangStaticImage[0], 4 + lightOffsetZ, tocolor(244.79999999999998, 224.4, 140.25, 100 * math.min(1, distanceFactor) * surgeProgress))
			if not pointLights[i][3] then
				pointLights[i][3] = true
				shouldRefreshPointLights = true
				numPointLights = numPointLights + 1
			end
		elseif pointLights[i][3] then
			pointLights[i][3] = false
			shouldRefreshPointLights = true
			numPointLights = numPointLights - 1
		end
	end
	for remotePlayer, objectElement in pairs(streamedHardHats) do
		if (not isDieselLoco or railSyncedBy ~= remotePlayer and not isRailPassenger[remotePlayer]) and isElement(objectElement) then
			local objectMatrix = getElementMatrix(objectElement)
			local objectPosX = objectMatrix[4][1]
			local objectPosY = objectMatrix[4][2]
			local objectPosZ = objectMatrix[4][3]
			if objectPosX and -1 <= convertSingleMineCoordinate(objectPosX) and getDistanceBetweenPoints2D(objectPosX, objectPosY, selfPosX, selfPosY) < 60 then
				local objectScaleX, objectScaleY, objectScaleZ = getObjectScale(objectElement)
				objectPosX = objectPosX + 0.1 * objectMatrix[2][1] * objectScaleY + 0.0398 * objectMatrix[3][1] * objectScaleZ
				objectPosY = objectPosY + 0.1 * objectMatrix[2][2] * objectScaleY + 0.0398 * objectMatrix[3][2] * objectScaleZ
				objectPosZ = objectPosZ + 0.1 * objectMatrix[2][3] * objectScaleY + 0.0398 * objectMatrix[3][3] * objectScaleZ
				spotLightCounter = spotLightCounter + 1
				local objectVecX = objectMatrix[2][1]
				local objectVecY = objectMatrix[2][2]
				local objectVecZ = objectMatrix[2][3]
				if not spotLights[spotLightCounter] then
					spotLights[spotLightCounter] = {}
				end
				if spotLights[spotLightCounter][1] ~= objectPosX then
					spotLights[spotLightCounter][1] = objectPosX
					shouldRefreshSpotLights = true
				end
				if spotLights[spotLightCounter][2] ~= objectPosY then
					spotLights[spotLightCounter][2] = objectPosY
					shouldRefreshSpotLights = true
				end
				if spotLights[spotLightCounter][3] ~= objectPosZ then
					spotLights[spotLightCounter][3] = objectPosZ
					shouldRefreshSpotLights = true
				end
				if spotLights[spotLightCounter][4] ~= objectVecX then
					spotLights[spotLightCounter][4] = objectVecX
					shouldRefreshSpotLights = true
				end
				if spotLights[spotLightCounter][5] ~= objectVecY then
					spotLights[spotLightCounter][5] = objectVecY
					shouldRefreshSpotLights = true
				end
				if spotLights[spotLightCounter][6] ~= objectVecZ then
					spotLights[spotLightCounter][6] = objectVecZ
					shouldRefreshSpotLights = true
				end
				local lightAlpha = 1 - math.abs(dot(objectVecX, objectVecY, objectVecZ, selfCamDirX, selfCamDirY, selfCamDirZ))
				seelangStaticImageUsed[1] = true
				if seelangStaticImageToc[1] then
					processSeelangStaticImage[1]()
				end
				dxDrawMaterialLine3D(objectPosX, objectPosY, objectPosZ + 0.15, objectPosX, objectPosY, objectPosZ - 0.15, seelangStaticImage[1], 0.3, tocolor(255, 242.25, 191.25, 200 * (1 - lightAlpha)), objectPosX + objectVecX, objectPosY + objectVecY, objectPosZ + objectVecZ)
				dxDrawLightCone(objectPosX, objectPosY, objectPosZ, objectPosX + objectVecX * 20, objectPosY + objectVecY * 20, objectPosZ + objectVecZ * 20, 5.5, tocolor(255, 242.25, 191.25, 220 * lightAlpha))
			end
		end
	end
	local redLightCounter = 0
	if mineMachineData.machineRunProgress >= 0.1 then
		redLightCounter = redLightCounter + 1
		local lightAngle = currentTick % 750 / 750 * math.pi * 2
		local lightDirX = math.cos(lightAngle)
		local lightDirY = math.sin(lightAngle)
		local lightDirZ = 0
		local lightPosX = -15.7845 + lightDirX * 0.08
		local lightPosY = 6.4795 + lightDirY * 0.08
		local lightPosZ = 9002.2412
		local lightAlpha = 1 - math.abs(dot(lightDirX, lightDirY, lightDirZ, selfCamDirX, selfCamDirY, selfCamDirZ))
		seelangStaticImageUsed[1] = true
		if seelangStaticImageToc[1] then
			processSeelangStaticImage[1]()
		end
		dxDrawMaterialLine3D(lightPosX, lightPosY, lightPosZ + 0.3, lightPosX, lightPosY, lightPosZ - 0.3, seelangStaticImage[1], 0.6, tocolor(255, 25, 25, 200 * (1 - lightAlpha)), lightPosX + lightDirX, lightPosY + lightDirY, lightPosZ + lightDirZ)
		dxDrawLightCone(lightPosX, lightPosY, lightPosZ, lightPosX + lightDirX * 15, lightPosY + lightDirY * 15, lightPosZ + lightDirZ * 15, 3.5, tocolor(255, 25, 25, 255 * lightAlpha))
		if not redLights[redLightCounter] then
			redLights[redLightCounter] = {}
		end
		if redLights[redLightCounter][1] ~= lightPosX then
			redLights[redLightCounter][1] = lightPosX
			shouldRefreshRedLights = true
		end
		if redLights[redLightCounter][2] ~= lightPosY then
			redLights[redLightCounter][2] = lightPosY
			shouldRefreshRedLights = true
		end
		if redLights[redLightCounter][3] ~= lightPosZ then
			redLights[redLightCounter][3] = lightPosZ
			shouldRefreshRedLights = true
		end
		if redLights[redLightCounter][4] ~= lightDirX then
			redLights[redLightCounter][4] = lightDirX
			shouldRefreshRedLights = true
		end
		if redLights[redLightCounter][5] ~= lightDirY then
			redLights[redLightCounter][5] = lightDirY
			shouldRefreshRedLights = true
		end
		if redLights[redLightCounter][6] ~= lightDirZ then
			redLights[redLightCounter][6] = lightDirZ
			shouldRefreshRedLights = true
		end
	end
	if isDieselLoco and 0 < trainEngineRev and getDistanceBetweenPoints2D(selfPosX, selfPosY, railX, railY) <= 60 then
		local lightPosX = railX + railCos * 1.285
		local lightPosY = railY + railSin * 1.285
		local lightPosZ = 9000.7646
		local lightDirX = railCos
		local lightDirY = railSin
		local lightDirZ = 0
		if convertSingleMineCoordinate(lightPosX) >= -1 then
			spotLightCounter = spotLightCounter + 1
			if not spotLights[spotLightCounter] then
				spotLights[spotLightCounter] = {}
			end
			if trainEngineRev < 1 and trainEngineRev <= currentTick % 200 / 200 then
				lightPosZ = 4000
			end
			spotLights[spotLightCounter][1] = lightPosX
			spotLights[spotLightCounter][2] = lightPosY
			spotLights[spotLightCounter][3] = lightPosZ
			spotLights[spotLightCounter][4] = lightDirX
			spotLights[spotLightCounter][5] = lightDirY
			spotLights[spotLightCounter][6] = lightDirZ
			shouldRefreshSpotLights = true
			local lightAlpha = 1 - math.abs(dot(lightDirX, lightDirY, lightDirZ, selfCamDirX, selfCamDirY, selfCamDirZ))
			seelangStaticImageUsed[1] = true
			if seelangStaticImageToc[1] then
				processSeelangStaticImage[1]()
			end
			dxDrawMaterialLine3D(lightPosX, lightPosY, lightPosZ + 0.15, lightPosX, lightPosY, lightPosZ - 0.15, seelangStaticImage[1], 0.3, tocolor(255, 242.25, 191.25, 200 * (1 - lightAlpha)), lightPosX + lightDirX, lightPosY + lightDirY, lightPosZ + lightDirZ)
			dxDrawLightCone(lightPosX, lightPosY, lightPosZ, lightPosX + lightDirX * 20, lightPosY + lightDirY * 20, lightPosZ + lightDirZ * 20, 5.5, tocolor(255, 242.25, 191.25, 220 * lightAlpha))
		end
		if trainEngineRev >= 1 then
			redLightCounter = redLightCounter + 1
			local lightAngle = currentTick % 750 / 750 * math.pi * 2
			local lightDirX = math.cos(lightAngle)
			local lightDirY = math.sin(lightAngle)
			local lightDirZ = 0
			local lightPosX = railX + railCos * 1.1523 - railSin * 0.462 + lightDirX * 0.08
			local lightPosY = railY + railSin * 1.15233 + railCos * 0.462 + lightDirY * 0.08
			local lightPosZ = 9001.4138
			local lightAlpha = 1 - math.abs(dot(lightDirX, lightDirY, lightDirZ, selfCamDirX, selfCamDirY, selfCamDirZ))
			seelangStaticImageUsed[1] = true
			if seelangStaticImageToc[1] then
				processSeelangStaticImage[1]()
			end
			dxDrawMaterialLine3D(lightPosX, lightPosY, lightPosZ + 0.3, lightPosX, lightPosY, lightPosZ - 0.3, seelangStaticImage[1], 0.6, tocolor(255, 25, 25, 200 * (1 - lightAlpha)), lightPosX + lightDirX, lightPosY + lightDirY, lightPosZ + lightDirZ)
			dxDrawLightCone(lightPosX, lightPosY, lightPosZ, lightPosX + lightDirX * 15, lightPosY + lightDirY * 15, lightPosZ + lightDirZ * 15, 3.5, tocolor(255, 25, 25, 255 * lightAlpha))
			if not redLights[redLightCounter] then
				redLights[redLightCounter] = {}
			end
			if redLights[redLightCounter][1] ~= lightPosX then
				redLights[redLightCounter][1] = lightPosX
				shouldRefreshRedLights = true
			end
			if redLights[redLightCounter][2] ~= lightPosY then
				redLights[redLightCounter][2] = lightPosY
				shouldRefreshRedLights = true
			end
			if redLights[redLightCounter][3] ~= lightPosZ then
				redLights[redLightCounter][3] = lightPosZ
				shouldRefreshRedLights = true
			end
			if redLights[redLightCounter][4] ~= lightDirX then
				redLights[redLightCounter][4] = lightDirX
				shouldRefreshRedLights = true
			end
			if redLights[redLightCounter][5] ~= lightDirY then
				redLights[redLightCounter][5] = lightDirY
				shouldRefreshRedLights = true
			end
			if redLights[redLightCounter][6] ~= lightDirZ then
				redLights[redLightCounter][6] = lightDirZ
				shouldRefreshRedLights = true
			end
		end
	end
	for i = #spotLights, spotLightCounter + 1, -1 do
		table.remove(spotLights, i)
	end
	for i = #redLights, redLightCounter + 1, -1 do
		table.remove(redLights, i)
	end
	local orangeLightCounter = 0
	for i = #bombDetonations, 1, -1 do
		local lightPosX, lightPosY, lightPosZ, r15_40 = unpack(bombDetonations[i])
		r15_40 = getEasingValue(1 - r15_40, "InQuad")
		orangeLightCounter = processOrange(orangeLightCounter, lightPosX, lightPosY, lightPosZ, 35 - 30 * r15_40, 10 * r15_40)
	end
	for i = #additionalOranges, 1, -1 do
		orangeLightCounter = processOrange(orangeLightCounter, unpack(additionalOranges[i]))
		table.remove(additionalOranges, i)
	end
	if mineMachineData.meltingOre then
		local meltProgress = 1
		if mineMachineData.meltProgress > 1 then
			meltProgress = getEasingValue(math.max(0, 1 - (mineMachineData.meltProgress - 1) / 6), "OutQuad")
		end
		dxSetShaderValue(meltShader, "melt", meltProgress)
		local lightPosX, lightPosY, lightPosZ = unpack(oreTypes[mineMachineData.meltingOre].meltLight)
		local r14_40 = getEasingValue(math.min(1, mineMachineData.meltProgress / 0.3) * 0.3 + math.min(1, math.max(0, (mineMachineData.meltProgress - 0.3) / 0.7)) * 0.7, "OutQuad")
		local r15_40 = 0.25 + 1.25 * meltProgress * r14_40
		local r16_40 = math.min(2, meltProgress * 5) * r14_40
		if r16_40 > 0 then
			orangeLightCounter = processOrange(orangeLightCounter, lightPosX, lightPosY, lightPosZ, r15_40, r16_40, meltProgress)
		end
	end
	for i = #orangeLights, orangeLightCounter + 1, -1 do
		table.remove(orangeLights, i)
	end
	if numStreamedOrangeLights ~= orangeLightCounter then
		numStreamedOrangeLights = orangeLightCounter
		shouldRefreshOrangeLights = true
	end
	if numStreamedPointLights ~= numPointLights then
		numStreamedPointLights = numPointLights
		shouldRefreshPointLights = true
	end
	if numStreamedSpotLights ~= #spotLights then
		numStreamedSpotLights = #spotLights
		shouldRefreshSpotLights = false
	end
	if numStreamedRedLights ~= #redLights then
		numStreamedRedLights = #redLights
		shouldRefreshRedLights = true
	end
	if shouldRefreshPointLights then
		refreshShaderPointLights()
		if #pointLights <= maxPointLights then
			shouldRefreshPointLights = false
		end
	end
	if shouldRefreshOrangeLights then
		refreshShaderOrangeLights()
		if #orangeLights <= maxOrangeLights then
			shouldRefreshOrangeLights = false
		end
	end
	if shouldRefreshSpotLights then
		refreshShaderSpot()
		if #spotLights <= maxSpotLights then
			shouldRefreshSpotLights = false
		end
	end
	if shouldRefreshRedLights then
		refreshRedShader()
		if #redLights <= maxRedLights then
			shouldRefreshRedLights = false
		end
	end
	if doCollect then
		collectgarbage("collect")
	end
end
local dirtyFaces = {}
function removeDirtyShader(sourceElement)
	-- line: [1909, 1928] id: 41
	if isElement(dirtyShader) then
		engineRemoveShaderFromWorldTexture(dirtyShader, "*", sourceElement)
	end
	if isElement(insideDirtyShader) then
		engineRemoveShaderFromWorldTexture(insideDirtyShader, "*", sourceElement)
		if isElement(objectShader) then
			engineApplyShaderToWorldTexture(objectShader, "*", sourceElement)
		end
	end
	for playerElement in pairs(dirtyFaces) do
		return
	end
	if isElement(dirtyShader) then
		destroyElement(dirtyShader)
	end
	dirtyShader = nil
	if isElement(cloudTexture) then
		destroyElement(cloudTexture)
	end
	cloudTexture = nil
end
function processDirtyShader()
	-- line: [1930, 1980] id: 42
	local haveDirtyFaces = false
	for playerElement in pairs(dirtyFaces) do
		haveDirtyFaces = true
		break
	end
	if not haveDirtyFaces then
		if isElement(dirtyShader) then
			destroyElement(dirtyShader)
		end
		dirtyShader = nil
		if isElement(cloudTexture) then
			destroyElement(cloudTexture)
		end
		cloudTexture = nil
		return
	end
	if isElement(insideDirtyShader) then
		if isElement(dirtyShader) then
			destroyElement(dirtyShader)
		end
		dirtyShader = nil
	elseif not isElement(dirtyShader) then
		dirtyShader = protectedCreateShader(dirtyShaderSource, 0, 0, true, "ped")
	end
	if not isElement(cloudTexture) then
		cloudTexture = dxCreateTexture("files/cloud.dds")
	end
	if isElement(cloudTexture) then
		if isElement(dirtyShader) then
			dxSetShaderValue(dirtyShader, "CloudTexture", cloudTexture)
		end
		if isElement(insideDirtyShader) then
			dxSetShaderValue(insideDirtyShader, "CloudTexture", cloudTexture)
		end
	end
	for playerElement in pairs(dirtyFaces) do
		if isElement(insideDirtyShader) then
			engineApplyShaderToWorldTexture(insideDirtyShader, "*", playerElement)
			if isElement(objectShader) then
				engineRemoveShaderFromWorldTexture(objectShader, "*", playerElement)
			end
			if isElement(dirtyShader) then
				engineRemoveShaderFromWorldTexture(dirtyShader, "*", playerElement)
			end
		elseif isElement(dirtyShader) then
			engineApplyShaderToWorldTexture(dirtyShader, "*", playerElement)
		end
	end
end
addEventHandler("onClientResourceStart", getRootElement(), function()
	-- line: [1983, 1997] id: 43
	local streamedPlayers = getElementsByType("player", getRootElement(), true)
	for i = 1, #streamedPlayers, 1 do
		if getElementData(streamedPlayers[i], "mineDirtyFace") then
			dirtyFaces[streamedPlayers[i]] = true
			if streamedPlayers[i] == localPlayer then
				checkPreRenderSelfDirt(true)
			end
		end
	end
	processDirtyShader()
end)
addEventHandler("onClientPlayerStreamIn", getRootElement(), function()
	-- line: [2000, 2022] id: 44
	if not dirtyFaces[source] and getElementData(source, "mineDirtyFace") then
		dirtyFaces[source] = true
		if not isElement(cloudTexture) then
			processDirtyShader()
		elseif isElement(insideDirtyShader) then
			engineApplyShaderToWorldTexture(insideDirtyShader, "*", source)
			if isElement(objectShader) then
				engineRemoveShaderFromWorldTexture(objectShader, "*", source)
			end
		elseif isElement(dirtyShader) then
			engineApplyShaderToWorldTexture(dirtyShader, "*", source)
		else
			processDirtyShader()
		end
		if source == localPlayer then
			checkPreRenderSelfDirt(true)
		end
	end
end)
addEventHandler("onClientPlayerDataChange", getRootElement(), function(dataName, oldData, newData)
	-- line: [2025, 2052] id: 45
	if dataName == "mineDirtyFace" and isElementStreamedIn(source) then
		if newData then
			dirtyFaces[source] = true
			if not isElement(cloudTexture) then
				processDirtyShader()
			elseif isElement(insideDirtyShader) then
				engineApplyShaderToWorldTexture(insideDirtyShader, "*", source)
				if isElement(objectShader) then
					engineRemoveShaderFromWorldTexture(objectShader, "*", source)
				end
			elseif isElement(dirtyShader) then
				engineApplyShaderToWorldTexture(dirtyShader, "*", source)
			else
				processDirtyShader()
			end
			if source == localPlayer then
				checkPreRenderSelfDirt(true)
			end
		else
			dirtyFaces[source] = nil
			removeDirtyShader(source)
		end
	end
end)
addEventHandler("onClientPlayerStreamOut", getRootElement(), function()
	if dirtyFaces[source] then
		dirtyFaces[source] = nil
		removeDirtyShader(source)
	end
end)
function preRenderSelfDirt()
	if getPedSimplestTask(localPlayer) == "TASK_SIMPLE_SWIM" then
		dirtyFaces[localPlayer] = nil
		removeDirtyShader(localPlayer)
		triggerServerEvent("removeDirtyFace", localPlayer)
	end
	if not dirtyFaces[localPlayer] then
		checkPreRenderSelfDirt(false)
	end
end
