local screenX, screenY = guiGetScreenSize()
local sceneTarget, movieShader
local movieShaderState = false
local movieShaderData = {}
local currentMoviePreset = 1
movieShaderData[1] = {}
movieShaderData[1].Hue = 0
movieShaderData[1].Brightness = 0
movieShaderData[1].Contrast = 0
movieShaderData[1].Saturation = 1
movieShaderData[1].R = 1
movieShaderData[1].G = 1
movieShaderData[1].B = 1
movieShaderData[1].L = 1
movieShaderData[1].noise = 0
movieShaderData[2] = {}
movieShaderData[2].Hue = 0
movieShaderData[2].Brightness = 0.12
movieShaderData[2].Contrast = 0.3
movieShaderData[2].Saturation = 0.7
movieShaderData[2].R = 0.76
movieShaderData[2].G = 0.76
movieShaderData[2].B = 0.92
movieShaderData[2].L = 1.22
movieShaderData[2].noise = 0
movieShaderData[3] = {}
movieShaderData[3].Hue = 0
movieShaderData[3].Brightness = 0
movieShaderData[3].Contrast = 0.156
movieShaderData[3].Saturation = 1.2
movieShaderData[3].R = 1.28
movieShaderData[3].G = 1.1
movieShaderData[3].B = 0.98
movieShaderData[3].L = 0.74
movieShaderData[3].noise = 0
movieShaderData[4] = {}
movieShaderData[4].Hue = 3.6
movieShaderData[4].Brightness = 0.22
movieShaderData[4].Contrast = 0.6
movieShaderData[4].Saturation = 0.64
movieShaderData[4].R = 0.52
movieShaderData[4].G = 0.825
movieShaderData[4].B = 1.25
movieShaderData[4].L = 1.21
movieShaderData[4].noise = 0
movieShaderData[5] = {}
movieShaderData[5].Hue = 0
movieShaderData[5].Brightness = -0.11
movieShaderData[5].Contrast = -0.16
movieShaderData[5].Saturation = 1.08
movieShaderData[5].R = 1.28
movieShaderData[5].G = 1.22
movieShaderData[5].B = 1.06
movieShaderData[5].L = 0.94
movieShaderData[5].noise = 0
movieShaderData[6] = {}
movieShaderData[6].Hue = 0
movieShaderData[6].Brightness = -0.11
movieShaderData[6].Contrast = -0.16
movieShaderData[6].Saturation = 1.08
movieShaderData[6].R = 1
movieShaderData[6].G = 1.22
movieShaderData[6].B = 1.22
movieShaderData[6].L = 0.94
movieShaderData[6].noise = 0
movieShaderData[7] = {}
movieShaderData[7].Hue = 0
movieShaderData[7].Brightness = -0.11
movieShaderData[7].Contrast = -0.16
movieShaderData[7].Saturation = 1.08
movieShaderData[7].R = 1
movieShaderData[7].G = 1.22
movieShaderData[7].B = 1.22
movieShaderData[7].L = 0.94
movieShaderData[7].noise = 0
movieShaderData[8] = {}
movieShaderData[8].Hue = 0
movieShaderData[8].Brightness = -0.09
movieShaderData[8].Contrast = -0.04
movieShaderData[8].Saturation = 1
movieShaderData[8].R = 1.1
movieShaderData[8].G = 1.18
movieShaderData[8].B = 1.18
movieShaderData[8].L = 0.98
movieShaderData[8].noise = 0.14
movieShaderData[9] = {}
movieShaderData[9].Hue = 0
movieShaderData[9].Brightness = -0.03
movieShaderData[9].Contrast = 0.04
movieShaderData[9].Saturation = 0.28
movieShaderData[9].R = 1.56
movieShaderData[9].G = 1.24
movieShaderData[9].B = 0.68
movieShaderData[9].L = 1.14
movieShaderData[9].noise = 0.22
movieShaderData[10] = {}
movieShaderData[10].Hue = 0
movieShaderData[10].Brightness = -0.09
movieShaderData[10].Contrast = -0.06
movieShaderData[10].Saturation = 0.52
movieShaderData[10].R = 0.76
movieShaderData[10].G = 1.28
movieShaderData[10].B = 0.78
movieShaderData[10].L = 0.98
movieShaderData[10].noise = 0
movieShaderData[11] = {}
movieShaderData[11].Hue = 0
movieShaderData[11].Brightness = -0.09
movieShaderData[11].Contrast = -0.06
movieShaderData[11].Saturation = 0.52
movieShaderData[11].R = 1.32
movieShaderData[11].G = 1.28
movieShaderData[11].B = 0.78
movieShaderData[11].L = 0.98
movieShaderData[11].noise = 0
movieShaderData[12] = {}
movieShaderData[12].Hue = 0
movieShaderData[12].Brightness = -0.09
movieShaderData[12].Contrast = -0.06
movieShaderData[12].Saturation = 0.52
movieShaderData[12].R = 1.32
movieShaderData[12].G = 1.28
movieShaderData[12].B = 1.3
movieShaderData[12].L = 0.98
movieShaderData[12].noise = 0
function movieShaderRender()
  dxUpdateScreenSource(sceneTarget)
  dxDrawImage(0, 0, screenX, screenY, movieShader)
  dxSetShaderValue(movieShader, "noiseX", math.random(119898, 139898) / 10000)
  dxSetShaderValue(movieShader, "noiseY", math.random(772330, 792330) / 10000)
end
function getShaderTarget()
  return movieShader
end
function getCurrentMoviePreset()
  return currentMoviePreset
end
function setCurrentMoviePreset(val)
  currentMoviePreset = val
  if movieShaderState then
    dxSetShaderValue(movieShader, "Hue", movieShaderData[currentMoviePreset].Hue)
    dxSetShaderValue(movieShader, "Brightness", movieShaderData[currentMoviePreset].Brightness)
    dxSetShaderValue(movieShader, "Contrast", movieShaderData[currentMoviePreset].Contrast)
    dxSetShaderValue(movieShader, "Saturation", movieShaderData[currentMoviePreset].Saturation)
    dxSetShaderValue(movieShader, "R", movieShaderData[currentMoviePreset].R)
    dxSetShaderValue(movieShader, "G", movieShaderData[currentMoviePreset].G)
    dxSetShaderValue(movieShader, "B", movieShaderData[currentMoviePreset].B)
    dxSetShaderValue(movieShader, "L", movieShaderData[currentMoviePreset].L)
    dxSetShaderValue(movieShader, "noise", movieShaderData[currentMoviePreset].noise)
  end
end
function getMovieShaderData(data)
  return movieShaderData[1][data]
end
function setMovieShaderData(data, val)
  movieShaderData[1][data] = val
  if movieShaderState and currentMoviePreset == 1 then
    dxSetShaderValue(movieShader, data, movieShaderData[1][data])
  end
end
function getMovieShaderState()
  return movieShaderState
end
local movieShaderSource = " texture sBaseTexture; float Hue; float Brightness; float Contrast; float Saturation; float R; float G; float B; float L; float noise; float noiseX = 12.9898; float noiseY = 78.2330; sampler Samp = sampler_state { Texture = (sBaseTexture); AddressU = MIRROR; AddressV = MIRROR; }; float3x3 QuaternionToMatrix(float4 quat) { float3 cross = quat.yzx * quat.zxy; float3 square= quat.xyz * quat.xyz; float3 wimag = quat.w * quat.xyz; square = square.xyz + square.yzx; float3 diag = 0.5 - square; float3 a = (cross + wimag); float3 b = (cross - wimag); return float3x3( 2.0 * float3(diag.x, b.z, a.y), 2.0 * float3(a.z, diag.y, b.x), 2.0 * float3(b.y, a.x, diag.z)); } const float3 lumCoeff = float3(0.2125, 0.7154, 0.0721); float rand_1_05(in float2 uv) { float2 noise = (frac(sin(dot(uv, float2(noiseX,noiseY)*2.0)) * 43758.5453)); return abs(noise.x + (noise.y)) * 0.5; } float4 PixelShaderFunction(float2 uv : TEXCOORD) : COLOR { float4 outputColor = tex2D(Samp, uv); float3 hsv; float3 intensity; float3 root3 = float3(0.57735, 0.57735, 0.57735); float half_angle = 0.5 * radians(Hue); float4 rot_quat = float4( (root3 * sin(half_angle)), cos(half_angle)); float3x3 rot_Matrix = QuaternionToMatrix(rot_quat); outputColor.rgb = mul(rot_Matrix, outputColor.rgb); outputColor.rgb = (outputColor.rgb - 0.5) *(Contrast + 1.0) + 0.5; outputColor.rgb = outputColor.rgb + Brightness; intensity = float(dot(outputColor.rgb, lumCoeff)); outputColor.rgb = lerp(intensity, outputColor.rgb, Saturation ); outputColor.rgb *= L; outputColor.rgb *= 1+rand_1_05(uv)*noise; outputColor.r *= R; outputColor.g *= G; outputColor.b *= B; return outputColor; } technique movie { pass P0 { PixelShader = compile ps_2_0 PixelShaderFunction(); } } technique fallback { pass P0 { } } "
function setMovieShaderState(state)
  if movieShaderState ~= state then
    movieShaderState = state
    if isElement(movieShader) then
      destroyElement(movieShader)
    end
    movieShader = false
    if isElement(sceneTarget) then
      destroyElement(sceneTarget)
    end
    sceneTarget = false
    if movieShaderState then
      addEventHandler("onClientHUDRender", getRootElement(), movieShaderRender)
      sceneTarget = dxCreateScreenSource(screenX, screenY)
      movieShader = dxCreateShader(movieShaderSource)
      dxSetShaderValue(movieShader, "sBaseTexture", sceneTarget)
      dxSetShaderValue(movieShader, "Hue", movieShaderData[currentMoviePreset].Hue)
      dxSetShaderValue(movieShader, "Brightness", movieShaderData[currentMoviePreset].Brightness)
      dxSetShaderValue(movieShader, "Contrast", movieShaderData[currentMoviePreset].Contrast)
      dxSetShaderValue(movieShader, "Saturation", movieShaderData[currentMoviePreset].Saturation)
      dxSetShaderValue(movieShader, "R", movieShaderData[currentMoviePreset].R)
      dxSetShaderValue(movieShader, "G", movieShaderData[currentMoviePreset].G)
      dxSetShaderValue(movieShader, "B", movieShaderData[currentMoviePreset].B)
      dxSetShaderValue(movieShader, "L", movieShaderData[currentMoviePreset].L)
      dxSetShaderValue(movieShader, "noise", movieShaderData[currentMoviePreset].noise)
      return movieShader
    else
      removeEventHandler("onClientHUDRender", getRootElement(), movieShaderRender)
    end
  end
end
