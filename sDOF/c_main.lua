local orderPriority = "-2.7"
Settings = {}
Settings.var = {}
function setEffectVariables()
  local v = Settings.var
  v.blurFactor = 0.95
  v.brightBlur = true
  v.brightBlurAdd = 0.3
  v.fManualFocus = false
  v.fNearBlurCurve = 10
  v.fFarBlurCurve = 0.5
  v.fManualFocusDepth = 0.1
end
function vCardPSVer()
  local smVersion = tostring(dxGetStatus().VideoCardPSVersion)
  return smVersion
end
function isDepthBufferAccessible()
  local depthStatus = tostring(dxGetStatus().DepthBufferFormat)
  if depthStatus == "unknown" then
    depthStatus = false
  end
  return depthStatus
end
function enableDoF()
  if dEffectEnabled then
    return
  end
  myScreenSource = dxCreateScreenSource(scx, scy)
  dBlurHShader, tecName = dxCreateShader("fx/dBlurH.fx")
  dBlurVShader, tecName = dxCreateShader("fx/dBlurV.fx")
  dDepthTexShader, tecName = dxCreateShader("fx/dDepthTex.fx")
  effectParts = {
    myScreenSource,
    dBlurHShader,
    dBlurVShader,
    dDepthTexShader
  }
  bAllValid = true
  for _, part in ipairs(effectParts) do
    bAllValid = part and bAllValid
  end
  curDistSample = 0
  medianFocalDist = 0
  distSamples = {}
  setEffectVariables()
  dEffectEnabled = true
  if not bAllValid then
    disableDoF()
  else
    local v = Settings.var
    dxSetShaderValue(dDepthTexShader, "fManualFocus", v.fManualFocus)
    dxSetShaderValue(dDepthTexShader, "fNearBlurCurve", v.fNearBlurCurve)
    dxSetShaderValue(dDepthTexShader, "fFarBlurCurve", v.fFarBlurCurve)
    dxSetShaderValue(dDepthTexShader, "fManualFocusDepth", v.fManualFocusDepth)
    dxSetShaderValue(dBlurVShader, "gblurFactor", v.blurFactor)
    dxSetShaderValue(dBlurVShader, "gBrightBlur", v.brightBlur)
    dxSetShaderValue(dBlurVShader, "gBrightBlurAdd", v.brightBlurAdd)
    dxSetShaderValue(dBlurHShader, "gblurFactor", v.blurFactor)
    dxSetShaderValue(dBlurHShader, "gBrightBlur", v.brightBlur)
    dxSetShaderValue(dBlurHShader, "gBrightBlurAdd", v.brightBlurAdd)
  end
end
function disableDoF()
  if not dEffectEnabled then
    return
  end
  for _, part in ipairs(effectParts) do
    if part then
      destroyElement(part)
    end
  end
  effectParts = {}
  bAllValid = false
  RTPool.clear()
  dEffectEnabled = false
end
addEventHandler("onClientHUDRender", root, function()
  if not bAllValid or not Settings.var then
    return
  end
  local v = Settings.var
  RTPool.frameStart()
  dxUpdateScreenSource(myScreenSource, true)
  local current = myScreenSource
  if v.autoFocus then
    v.focalDepth = medianFocalDist
  end
  local depthTex = getDepthTexture(current)
  current = applyGDepthBlurH(current, depthTex)
  current = applyGDepthBlurV(current, depthTex)
  dxSetRenderTarget()
  if current then
    dxDrawImage(0, 0, scx, scy, current, 0, 0, 0, tocolor(255, 255, 255, 255))
  end
end, true, "low" .. orderPriority)
function getDepthTexture(Src)
  if not Src then
    return nil
  end
  local mx, my = dxGetMaterialSize(Src)
  local newRT = RTPool.GetUnused(mx, my)
  if not newRT then
    return nil
  end
  dxSetRenderTarget(newRT, true)
  dxSetShaderValue(dDepthTexShader, "sTexSize", mx, my)
  dxDrawImage(0, 0, mx, my, dDepthTexShader)
  return newRT
end
function applyGDepthBlurH(Src, getDepth)
  if not Src then
    return nil
  end
  local mx, my = dxGetMaterialSize(Src)
  local newRT = RTPool.GetUnused(mx, my)
  if not newRT then
    return nil
  end
  dxSetRenderTarget(newRT, true)
  dxSetShaderValue(dBlurHShader, "TEX0", Src)
  dxSetShaderValue(dBlurHShader, "TEX1", getDepth)
  dxSetShaderValue(dBlurHShader, "tex0size", mx, my)
  dxDrawImage(0, 0, mx, my, dBlurHShader)
  return newRT
end
function applyGDepthBlurV(Src, getDepth)
  if not Src then
    return nil
  end
  local mx, my = dxGetMaterialSize(Src)
  local newRT = RTPool.GetUnused(mx, my)
  if not newRT then
    return nil
  end
  dxSetRenderTarget(newRT, true)
  dxSetShaderValue(dBlurVShader, "TEX0", Src)
  dxSetShaderValue(dBlurVShader, "TEX1", getDepth)
  dxSetShaderValue(dBlurVShader, "tex0size", mx, my)
  dxDrawImage(0, 0, mx, my, dBlurVShader)
  return newRT
end
_dxDrawImage = dxDrawImage
function xdxDrawImage(posX, posY, width, height, image, ...)
  if not image then
    return false
  end
  return _dxDrawImage(posX, posY, width, height, image, ...)
end
