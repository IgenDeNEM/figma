local elementClasses = {}
local elementIndex = {}
DEBUG = DEBUG or nil
function new(class, ...)
  assert(type(class) == "table", "first argument provided to new is not a table")
  if DEBUG then
    for k, v in ipairs(class) do
      assert(v ~= pure_virtual, "Attempted to instanciate a class with an unimplemented pure virtual method (" .. tostring(k) .. ")")
    end
  end
  local instance = setmetatable({}, {
    __index = class,
    __super = {class},
    __newindex = class.__newindex,
    __call = class.__call,
    __len = class.__len,
    __unm = class.__unm,
    __add = class.__add,
    __sub = class.__sub,
    __mul = class.__mul,
    __div = class.__div,
    __pow = class.__pow,
    __concat = class.__concat
  })
  local callDerivedConstructor
  function callDerivedConstructor(self, instance, ...)
    for k, v in ipairs(super(self)) do
      if rawget(v, "virtual_constructor") then
        rawget(v, "virtual_constructor")(instance, ...)
      end
      local s = super(v)
      if s then
        callDerivedConstructor(s, instance, ...)
      end
    end
  end
  callDerivedConstructor(class, instance, ...)
  if rawget(class, "constructor") then
    rawget(class, "constructor")(instance, ...)
  end
  instance.constructor = false
  for k, v in ipairs(class) do
    if k:sub(1, 7) == "_change" then
      addChangeHandler(instance, k:sub(8), v)
    end
  end
  return instance
end
function enew(element, class, ...)
  if DEBUG then
    for k, v in ipairs(class) do
      assert(v ~= pure_virtual, "Attempted to instanciate a class with an unimplemented pure virtual method (" .. tostring(k) .. ")")
    end
  end
  local instance = setmetatable({element = element}, {
    __index = class,
    __super = {class},
    __newindex = class.__newindex,
    __call = class.__call,
    __len = class.__len,
    __unm = class.__unm,
    __add = class.__add,
    __sub = class.__sub,
    __mul = class.__mul,
    __div = class.__div,
    __pow = class.__pow,
    __concat = class.__concat
  })
  elementIndex[element] = instance
  local callDerivedConstructor
  function callDerivedConstructor(parentClasses, instance, ...)
    for k, v in ipairs(parentClasses) do
      if rawget(v, "virtual_constructor") then
        rawget(v, "virtual_constructor")(instance, ...)
      end
      local s = super(v)
      if s then
        callDerivedConstructor(s, instance, ...)
      end
    end
  end
  callDerivedConstructor(super(instance), element, ...)
  if rawget(class, "constructor") then
    rawget(class, "constructor")(element, ...)
  end
  element.constructor = false
  for k, v in ipairs(class) do
    if k:sub(1, 7) == "_change" then
      addChangeHandler(instance, k:sub(8), v)
    end
  end
  addEventHandler(triggerClientEvent ~= nil and "onElementDestroy" or "onClientElementDestroy", element, __removeElementIndex, false, "low-999999")
  return element
end
function registerElementClass(elementType, class)
  elementClasses[elementType] = class
end
function __removeElementIndex()
  delete(source)
end
function delete(self, ...)
  if self.destructor then
    self:destructor(...)
  end
  self.destructor = false
  local callDerivedDestructor
  function callDerivedDestructor(parentClasses, instance, ...)
    for k, v in ipairs(parentClasses) do
      if rawget(v, "virtual_destructor") then
        rawget(v, "virtual_destructor")(instance, ...)
      end
      local s = super(v)
      if s then
        callDerivedDestructor(s, instance, ...)
      end
    end
  end
  callDerivedDestructor(super(self), self, ...)
  elementIndex[self] = nil
end
function super(self)
  if isElement(self) then
    self = elementIndex[self]
  end
  local metatable = getmetatable(self)
  if metatable then
    return metatable.__super
  else
    return {}
  end
end
function instanceof(self, class, direct)
  for k, v in ipairs(super(self)) do
    if v == class then
      return true
    end
  end
  if direct then
    return false
  end
  local check = false
  for k, v in ipairs(super(self)) do
    check = instanceof(v, class, false)
  end
  return check
end
function bind(func, ...)
  if not func then
    if DEBUG then
      outputConsole(debug.traceback())
    end
    error("Bad function pointer @ bind. See console for more details")
  end
  local boundParams = {
    ...
  }
  return function(...)
    local params = {}
    local boundParamSize = select("#", unpack(boundParams))
    for i = 1, boundParamSize do
      params[i] = boundParams[i]
    end
    local funcParams = {
      ...
    }
    for i = 1, select("#", ...) do
      params[boundParamSize + i] = funcParams[i]
    end
    return func(unpack(params))
  end
end
function load(class, ...)
  assert(type(class) == "table", "first argument provided to load is not a table")
  local instance = setmetatable({}, {
    __index = class,
    __super = {class},
    __newindex = class.__newindex,
    __call = class.__call
  })
  if rawget(class, "load") then
    rawget(class, "load")(instance, ...)
  end
  instance.load = false
  return instance
end
function inherit(from, what)
  if not from then
    outputConsole(debug.traceback())
    return {}
  end
  if not what then
    local classt = setmetatable({}, {
      __index = _inheritIndex,
      __super = {from}
    })
    if from.onInherit then
      from.onInherit(classt)
    end
    return classt
  end
  local metatable = getmetatable(what) or {}
  local oldsuper = metatable and metatable.__super or {}
  table.insert(oldsuper, 1, from)
  metatable.__super = oldsuper
  metatable.__index = _inheritIndex
  return setmetatable(what, metatable)
end
function _inheritIndex(self, key)
  for k, v in ipairs(super(self) or {}) do
    if v[key] then
      return v[key]
    end
  end
  return nil
end
function pure_virtual()
  error("Function implementation missing")
end
function getTypeName(object)
  return table.find(_G, getmetatable(object).__index)
end
function addChangeHandler(instance, key, func)
  if isElement(instance) then
    instance = elementIndex[instance]
  end
  local metatable = getmetatable(instance) or {}
  if not metatable.__changeHandler then
    metatable.__changeHandler = {}
    metatable.__realNewindexFunction = metatable.__newindex
    if type(metatable.__index) == "table" then
      metatable.__realIndexTable = metatable.__index
    elseif type(metatable.__index) == "function" then
      metatable.__realIndexFunction = metatable.__index
    end
    metatable.__index = __changeHandlerIndex
    metatable.__newindex = __changeHandlerNewindex
  end
  if type(key) == "function" then
    if not metatable.__changeData then
      metatable.__changeData = {}
      for k, v in ipairs(instance) do
        metatable.__changeData[k] = v
        instance[k] = nil
      end
    end
    func = key
    metatable.__changeHandler = func
  else
    metatable.__changeData[key] = rawget(instance, key)
    metatable.__changeHandler[key] = func
  end
  return setmetatable(instance, metatable)
end
function __changeHandlerIndex(self, key)
  local metatable = getmetatable(self)
  if metatable.__changeData[key] then
    return metatable.__changeData[key]
  end
  return metatable.__realIndexFunction and metatable.__realIndexFunction(rawget(self, "element") or self, key) or metatable.__realIndexTable and metatable.__realIndexTable[key] or rawget(self, key)
end
function __changeHandlerNewindex(self, key, value)
  local metatable = getmetatable(self)
  if type(metatable.__changeHandler) == "table" then
    if metatable.__changeHandler[key] then
      local ret = metatable.__changeHandler[key](rawget(self, "element") or self, value)
      if ret ~= nil then
        value = ret
      end
      metatable.__changeData[key] = value
      setmetatable(self, metatable)
      return
    end
  elseif type(metatable.__changeHandler) == "function" then
    local ret = metatable.__changeHandler(rawget(self, "element") or self, key, value)
    if ret ~= nil then
      value = ret
    end
    metatable.__changeData[key] = value
    setmetatable(self, metatable)
    return
  end
  return metatable.__realNewindexFunction and metatable.__realNewindexFunction(rawget(self, "element") or self, key, value) or rawset(self, key, value)
end
if type(root) == "userdata" then
  debug.setmetatable(root, {
    __index = function(self, key)
      if elementIndex[self] then
        return elementIndex[self][key]
      elseif elementClasses[getElementType(self)] then
        enew(self, elementClasses[getElementType(self)])
        return self[key]
      end
    end,
    __newindex = function(self, key, value)
      if not elementIndex[self] then
        enew(self, elementClasses[getElementType(self)] or {})
      end
      elementIndex[self][key] = value
    end
  })
end
