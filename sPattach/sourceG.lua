local isClientSide = isElement(localPlayer)
if isClientSide then
  function attach(...)
    return sPattach:attach(...)
  end
  addEvent("sPattach:attach", true)
  addEventHandler("sPattach:attach", resourceRoot, attach)
  function detach(...)
    return sPattach:detach(...)
  end
  addEvent("sPattach:detach", true)
  addEventHandler("sPattach:detach", resourceRoot, detach)
  function detachAll(...)
    return sPattach:detachAll(...)
  end
  addEvent("sPattach:detachAll", true)
  addEventHandler("sPattach:detachAll", resourceRoot, detachAll)
  function setPositionOffset(...)
    return sPattach:setPositionOffset(...)
  end
  addEvent("sPattach:setPositionOffset", true)
  addEventHandler("sPattach:setPositionOffset", resourceRoot, setPositionOffset)
  function setRotationOffset(...)
    return sPattach:setRotationOffset(...)
  end
  addEvent("sPattach:setRotationOffset", true)
  addEventHandler("sPattach:setRotationOffset", resourceRoot, setRotationOffset)
  function setRotationMatrix(...)
    return sPattach:setRotationMatrix(...)
  end
  addEvent("sPattach:setRotationMatrix", true)
  addEventHandler("sPattach:setRotationMatrix", resourceRoot, setRotationMatrix)
  function setRotationQuaternion(...)
    return sPattach:setRotationQuaternion(...)
  end
  addEvent("sPattach:setRotationQuaternion", true)
  addEventHandler("sPattach:setRotationQuaternion", resourceRoot, setRotationQuaternion)
  function disableScreenCheck(...)
    return sPattach:disableScreenCheck(...)
  end
  addEvent("sPattach:disableScreenCheck", true)
  addEventHandler("sPattach:disableScreenCheck", resourceRoot, disableScreenCheck)
  function invisibleAll(...)
    return sPattach:invisibleAll(...)
  end
  addEvent("sPattach:invisibleAll", true)
  addEventHandler("sPattach:invisibleAll", resourceRoot, invisibleAll)
  function isAttached(...)
    return sPattach:isAttached(...)
  end
  function getDetails(...)
    return sPattach:getDetails(...)
  end
  function getAttacheds(...)
    return sPattach:getAttacheds(...)
  end
else
  do
    local cache = {}
    function attach(element, ped, boneid, ox, oy, oz, rx, ry, rz)
      assert(isElement(element), "Expected element at argument 1, got " .. type(element))
      cache[element] = {
        element,
        ped,
        boneid,
        ox or 0,
        oy or 0,
        oz or 0,
        rx or 0,
        ry or 0,
        rz or 0
      }
      return triggerClientEvent("sPattach:attach", resourceRoot, element, ped, boneid, ox, oy, oz, rx, ry, rz)
    end
    function detach(element)
      assert(isElement(element), "Expected element at argument 1, got " .. type(element))
      cache[element] = nil
      return triggerClientEvent("sPattach:detach", resourceRoot, element)
    end
    function detachAll(ped)
      assert(isElement(ped), "Expected element at argument 1, got " .. type(ped))
      for element, data in pairs(cache) do
        if data[2] == ped then
          cache[element] = nil
        end
      end
      return triggerClientEvent("sPattach:detachAll", resourceRoot, ped)
    end
    function setPositionOffset(element, x, y, z)
      assert(isElement(element), "Expected element at argument 1, got " .. type(element))
      cache[element][4] = x or 0
      cache[element][5] = y or 0
      cache[element][6] = z or 0
      return triggerClientEvent("sPattach:setPositionOffset", resourceRoot, element, x, y, z)
    end
    function setRotationOffset(element, x, y, z)
      assert(isElement(element), "Expected element at argument 1, got " .. type(element))
      cache[element][7] = x or 0
      cache[element][8] = y or 0
      cache[element][9] = z or 0
      cache[element].q = nil
      return triggerClientEvent("sPattach:setRotationOffset", resourceRoot, element, x, y, z)
    end
    function setRotationQuaternion(element, q)
      assert(isElement(element), "Expected element at argument 1, got " .. type(element))
      cache[element].q = q
      return triggerClientEvent("sPattach:setRotationQuaternion", resourceRoot, element, q)
    end
    function invisibleAll(ped, bool)
      for element, data in pairs(cache) do
        if data[2] == ped then
          setElementAlpha(element, bool and 0 or 255)
        end
      end
      return true
    end
    function isAttached(element)
      assert(isElement(element), "Expected element at argument 1, got " .. type(element))
      return cache[element] and true or false
    end
    function getDetails(element)
      assert(isElement(element), "Expected element at argument 1, got " .. type(element))
      return cache[element] or false
    end
    function getAttacheds(ped)
      assert(isElement(ped), "Expected element at argument 1, got " .. type(element))
      local list = {}
      for element, data in pairs(cache) do
        if data[2] == ped then
          list[#list + 1] = element
        end
      end
      return list
    end
    function requestCache()
      if isElement(client) then
        triggerClientEvent(client, "sPattach:receiveCache", resourceRoot, cache)
      end
    end
    addEvent("sPattach:requestCache", true)
    addEventHandler("sPattach:requestCache", resourceRoot, requestCache)
    addEventHandler("onPlayerQuit", root, function()
      detachAll(source)
    end)
    addEventHandler("onElementDestroy", root, function()
      if cache[source] then
        detach(source)
      elseif getElementType(source) == "ped" then
        for element, data in pairs(cache) do
          if data[2] == source then
            cache[element] = nil
          end
        end
      end
    end)
  end
end
