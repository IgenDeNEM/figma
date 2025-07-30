function isTextureValid(model, theType, id)
  if vehPjApplyInfo[model] and vehPjApplyInfo[model][theType .. "TexIds"] then
    local texId = vehPjApplyInfo[model][theType .. "TexIds"][id]
    if texId then
      return true
    end
  end
  return false
end
function getCustomPrice(model, theType, id)
  if vehPjApplyInfo[model] and vehPjApplyInfo[model][theType .. "TexIds"] then
    local texId = vehPjApplyInfo[model][theType .. "TexIds"][id]
    if texId then
      return texturePrices[texId]
    end
  end
  return false
end
