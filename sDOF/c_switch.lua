local forceOnIfNoDB = false
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), function()
  if isDepthBufferAccessible() or forceOnIfNoDB then
  else
  end
end)
function setDofState(aaOn)
  if aaOn then
    enableDoF()
  else
    disableDoF()
  end
end
function getDofState()
  return dEffectEnabled
end
