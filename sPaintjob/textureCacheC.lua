local sightlangCondHandlState0 = false
local function sightlangCondHandl0(cond, prio)
  cond = cond and true or false
  if cond ~= sightlangCondHandlState0 then
    sightlangCondHandlState0 = cond
    if cond then
      addEventHandler("onClientPreRender", getRootElement(), waitAndProcessPj, true, prio)
    else
      removeEventHandler("onClientPreRender", getRootElement(), waitAndProcessPj)
    end
  end
end
local SHADER_CODE = " texture ReplacedTexture; technique TextureChange { pass P0 { Texture[0] = ReplacedTexture; } } "
local textureCache = {}
local textureCacheQueue = {}
local lastPj = 0
function waitAndProcessPj()
  local now = getTickCount()
  if now - lastPj < 500 then
    return
  end
  for i = 1, #textureCacheQueue do
    local texid = textureCacheQueue[i]
    if texid then
      local cacheEntry = textureCache[texid]
      if cacheEntry and not isElement(cacheEntry.texture) and isElement(cacheEntry.shader) then
        cacheEntry.texture = dxCreateTexture("textures/" .. textureFilePaths[texid], textureDXT[texid] or "dxt1")
        lastPj = getTickCount()
        dxSetShaderValue(cacheEntry.shader, "ReplacedTexture", cacheEntry.texture)
      end
      table.remove(textureCacheQueue, i)
      return
    else
      table.remove(textureCacheQueue, i)
      return
    end
  end
  sightlangCondHandl0(false)
end
local function createCachedTexture(texid)
  if not textureFilePaths[texid] then
    return false
  end
  local cachedTexture = {
    zeroRefTick = nil,
    refCount = 0,
    texture = false,
    shader = dxCreateShader(SHADER_CODE, 0, 0, false, "vehicle")
  }
  sightlangCondHandl0(true)
  table.insert(textureCacheQueue, texid)
  textureCache[texid] = cachedTexture
  return cachedTexture
end
local function getTextureCacheEntryFromId(texid)
  local cacheEntry = textureCache[texid]
  return cacheEntry or createCachedTexture(texid)
end
function flushTextureCache()
  for _, entry in pairs(textureCache) do
    destroyElement(entry.shader)
    destroyElement(entry.texture)
  end
  textureCache = {}
end
function applyTextureToElementTexture(element, worldTexture, texid)
  local cacheEntry = getTextureCacheEntryFromId(texid)
  engineApplyShaderToWorldTexture(cacheEntry.shader, worldTexture, element)
  engineApplyShaderToWorldTexture(cacheEntry.shader, "#" .. utf8.sub(worldTexture, 2), element)
  cacheEntry.refCount = cacheEntry.refCount + 1
  cacheEntry.zeroRefTick = nil
  return true
end
function removeTextureFromElementTexture(element, worldTexture, texid)
  local cacheEntry = getTextureCacheEntryFromId(texid)
  engineRemoveShaderFromWorldTexture(cacheEntry.shader, worldTexture, element)
  engineRemoveShaderFromWorldTexture(cacheEntry.shader, "#" .. utf8.sub(worldTexture, 2), element)
  cacheEntry.refCount = cacheEntry.refCount - 1
  if cacheEntry.refCount == 0 then
    cacheEntry.zeroRefTick = getTickCount()
  end
  return true
end
setTimer(function()
  local currTick = getTickCount()
  for texid, entry in pairs(textureCache) do
    if entry.refCount == 0 and currTick - (entry.zeroRefTick or 0) >= 20000 then
      if isElement(entry.shader) then
        destroyElement(entry.shader)
      end
      entry.shader = nil
      if isElement(entry.texture) then
        destroyElement(entry.texture)
      end
      entry.texture = nil
      textureCache[texid] = nil
    end
  end
end, 15000, 0)

