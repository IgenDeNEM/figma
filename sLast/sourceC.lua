local reasonQuit = {
  unknown = "Időtúllépés",
  quit = "Kilépés",
  kicked = "Kick/Ban",
  banned = "Ban",
  ["bad connection"] = "Időtúllépés",
  ["timed out"] = "Időtúllépés"
}
addEventHandler("onClientPlayerQuit", getRootElement(), function(reason)
  if getElementData(source, "loggedIn") then
    local int, dim = getElementInterior(source), getElementDimension(source)
    local int2, dim2 = getElementInterior(localPlayer), getElementDimension(localPlayer)
    if int == int2 and dim == dim2 then
      local x, y, z = getElementPosition(localPlayer)
      local x2, y2, z2 = getElementPosition(source)
      local dist = getDistanceBetweenPoints3D(x, y, z, x2, y2, z2)
      local name = getElementData(source, "visibleName"):gsub("_", " ") or ""
      if dist <= 20 then
        outputChatBox("[color=sightred]" .. name .. " kilépett a közeledben. [" .. reasonQuit[string.lower(reason)] .. "] Távolság: " .. math.floor(dist) .. " yard", 255, 255, 255, true)
      end
    end
  end
end)
