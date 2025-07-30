function setCarPaintState(cprlOn)
  if cprlOn then
    startCarPaintReflectLite()
  else
    stopCarPaintReflectLite()
  end
end
function getCarPaintState()
  return cprlEffectEnabled
end
