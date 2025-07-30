local spectateTarget = false
local triggerTick = 0
addEventHandler("onClientElementDataChange", getRootElement(), function(dataName, oldValue)
  if dataName == "spectateTarget" and source == localPlayer then
    spectateTarget = getElementData(localPlayer, "spectateTarget")
  end
end)
addEventHandler("onClientRender", getRootElement(), function()
  if spectateTarget and isElement(spectateTarget) then
    local updateSpectate = false
    local sourceInterior = getElementInterior(localPlayer)
    local sourceDimension = getElementDimension(localPlayer)
    local targetInterior = getElementInterior(spectateTarget)
    local targetDimension = getElementDimension(spectateTarget)
    if sourceInterior ~= targetInterior then
      updateSpectate = true
    end
    if sourceDimension ~= targetDimension then
      updateSpectate = true
    end
    if updateSpectate and triggerTick + 1000 <= getTickCount() then
      triggerServerEvent("updateSpectatePosition", localPlayer, targetInterior, targetDimension)
      triggerTick = getTickCount()
    end
  end
end)
