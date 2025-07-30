local screenWidth, screenHeight = guiGetScreenSize()
local screenSource = false
local damageShader = false
local effectHandled = false
local damageSource = [[
texture screenSource;

float blurStrength = 0;
float colorFadeValue = 0;

sampler ScreenSourceSampler = sampler_state
{
    Texture = (screenSource);
	MinFilter = Linear;
    MagFilter = Linear;
    MipFilter = Linear;
    AddressU = Mirror;
    AddressV = Mirror;
};

const float2 offsets[24] = {
   -0.326212, -0.405805,
   -0.840144, -0.073580,
   -0.695914,  0.457137,
   -0.203345,  0.620716,
    0.962340, -0.194983,
    0.473434, -0.480026,
    0.519456,  0.767022,
    0.185461, -0.893124,
    0.507431,  0.064425,
    0.896420,  0.412458,
   -0.321940, -0.932615,
   -0.791559, -0.597705,
   -0.426212, -0.305805,
   -0.740144, -0.173580,
   -0.595914,  0.357137,
   -0.103345,  0.520716,
    0.762340, -0.294983,
    0.273434, -0.380026,
    0.319456,  0.667022,
    0.085461, -0.793124,
    0.407431,  0.164425,
    0.796420,  0.312458,
   -0.221940, -0.832615,
   -0.691559, -0.497705,
};

float4 BlurPixelShader(float2 texCoord : TEXCOORD) : COLOR0
{
	float4 mainColor = tex2D(ScreenSourceSampler, texCoord);

	for (int i = 0; i < 24; i++){
		mainColor += tex2D(ScreenSourceSampler, texCoord + (blurStrength / 1000) * offsets[i]);
	}
	
	mainColor /= 25;
	
	float4 bwColor = mainColor;
	float bwValue = (bwColor.r + bwColor.g + bwColor.b) / 3;
	bwColor.r = bwValue;
	bwColor.g = bwValue;
	bwColor.b = bwValue;
	
	//float4 color = (bwColor * colorFadeValue) + (mainColor * (1 - colorFadeValue));
	//color.rgb -= colorFadeValue / 16;

	mainColor.rgb += colorFadeValue;
	
	return mainColor;
}

technique BlurVH
{
    pass p0
    {
		AlphaBlendEnable = False;
        PixelShader = compile ps_2_0 BlurPixelShader();
    }
}

// Fallback
technique Fallback
{
    pass P0
    {
        // Just draw normally
    }
}
]]
function startEffect()
  if not effectHandled then
    addEventHandler("onClientPreRender", getRootElement(), preRenderFlashbang)
    if isElement(damageShader) then
      destroyElement(damageShader)
    end
    damageShader = false
    if isElement(screenSource) then
      destroyElement(screenSource)
    end
    screenSource = false
    damageShader = dxCreateShader(damageSource)
    if damageShader then
      screenSource = dxCreateScreenSource(screenWidth, screenHeight)
      if screenSource then
        dxSetShaderValue(damageShader, "screenSource", screenSource)
      end
    end
    addEventHandler("onClientRender", getRootElement(), renderFlashbang, true, "low-999999999")
  end
  effectHandled = true
end
local heartSound = false
local tinnitusSound = false
addEventHandler("onClientExplosion", getRootElement(), function(explosionX, explosionY, explosionZ, explosionType)
  if explosionType == 0 then
    local playerX, playerY, playerZ = getElementPosition(localPlayer)
    local sound = playSound3D("files/explosion1.wav", explosionX, explosionY, explosionZ)
    setSoundMaxDistance(sound, 175)
    setElementDimension(sound, getElementDimension(localPlayer))
    setElementInterior(sound, getElementInterior(localPlayer))
    local d = getDistanceBetweenPoints3D(playerX, playerY, playerZ, explosionX, explosionY, explosionZ)
    local p = 0
    if d < 10 then
      p = 1
    else
      p = 1 - (d - 10) / 30
    end
    if 0 < p then
      local cx, cy, cz = getCameraMatrix()
      local lineOfSight = isLineOfSightClear(cx, cy, cz, explosionX, explosionY, explosionZ, true, true, false, true, true)
      if lineOfSight then
        startEffect()
        blurStrength = math.max(blurStrength or 0, p)
        colorFadeValue = math.max(colorFadeValue or 0, p)
        impactSoundVolume = math.max(impactSoundVolume or 0, p)
        if isElement(heartSound) then
          destroyElement(heartSound)
        end
        if isElement(tinnitusSound) then
          destroyElement(tinnitusSound)
        end
        heartSound = playSound("files/heartbeat.ogg", true)
        tinnitusSound = playSound("files/tinnitus.ogg", false)
      end
    end
  end
  if explosionType ~= 1 and explosionType ~= 7 then
    cancelEvent()
  end
end)
function preRenderFlashbang(delta)
  local now = getTickCount()
  if blurStrength <= 0 and 0 >= colorFadeValue and 0 >= impactSoundVolume then
    if isElement(heartSound) then
      destroyElement(heartSound)
    end
    heartSound = false
    if isElement(tinnitusSound) then
      destroyElement(tinnitusSound)
    end
    tinnitusSound = false
    if isElement(damageShader) then
      destroyElement(damageShader)
    end
    damageShader = false
    if isElement(screenSource) then
      destroyElement(screenSource)
    end
    screenSource = false
    effectHandled = false
    removeEventHandler("onClientRender", getRootElement(), renderFlashbang, true, "low-999999999")
    removeEventHandler("onClientPreRender", getRootElement(), preRenderFlashbang)
  else
    blurStrength = blurStrength - 0.005 * delta / 16 * 0.25
    if blurStrength <= 0 then
      blurStrength = 0
    end
    colorFadeValue = colorFadeValue - 0.0025 * delta / 16 * 0.5
    if 0 >= colorFadeValue then
      colorFadeValue = 0
    end
    impactSoundVolume = impactSoundVolume - 0.005 * delta / 16 * 0.4
    if 0 >= impactSoundVolume then
      impactSoundVolume = 0
      if isElement(heartSound) then
        stopSound(heartSound)
      end
    end
    if isElement(heartSound) then
      setSoundVolume(heartSound, impactSoundVolume * 3)
    end
    if isElement(tinnitusSound) then
      setSoundVolume(tinnitusSound, impactSoundVolume)
    end
  end
end
function renderFlashbang()
  if isElement(damageShader) then
    dxUpdateScreenSource(screenSource, true)
    dxSetShaderValue(damageShader, "blurStrength", getEasingValue(blurStrength, "OutQuad") * 150)
    dxSetShaderValue(damageShader, "colorFadeValue", getEasingValue(blurStrength, "OutQuad"))
    dxDrawImage(0, 0, screenWidth, screenHeight, damageShader)
  end
end
