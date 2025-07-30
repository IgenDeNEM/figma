local cache = {}
function setCache(player, data)
  if not cache[player] then
    cache[player] = {}
  end
  cache[player][data] = getElementData(player, data)
end
function lookupCache(player, data)
  if cache[player] then
    if type(cache[player][data]) ~= "nil" then
      return cache[player][data]
    else
      setCache(player, data)
    end
  else
    setCache(player, data)
  end
  return cache[player][data]
end
addEventHandler("onClientPlayerQuit", getRootElement(), function()
  cache[source] = nil
end)
addEventHandler("onClientElementDataChange", getRootElement(), function(dataName, oldValue, newValue)
  if cache[source] and type(cache[source][dataName]) ~= "nil" then
    if type(newValue) == "nil" then
      cache[source][dataName] = false
    else
      cache[source][dataName] = newValue
    end
  end
end)