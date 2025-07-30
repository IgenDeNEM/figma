function setRadialBlurState(bOn)
  if bOn then
    enableRadialBlur()
  else
    disableRadialBlur()
  end
end
function getRadialBlurState()
  return bEffectEnabled
end
