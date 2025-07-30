local sightexports = {
  sModloader = false,
  sWeapons = false,
  sPattach = false
}
local function sightlangProcessExports()
  for k in pairs(sightexports) do
    local res = getResourceFromName(k)
    if res and getResourceState(res) == "running" then
      sightexports[k] = exports[k]
    else
      sightexports[k] = false
    end
  end
end
sightlangProcessExports()
if triggerServerEvent then
  addEventHandler("onClientResourceStart", getRootElement(), sightlangProcessExports, true, "high+9999999999")
end
if triggerClientEvent then
  addEventHandler("onResourceStart", getRootElement(), sightlangProcessExports, true, "high+9999999999")
end
local sightlangModloaderLoaded = function()
  loadModelIds()
end
addEventHandler("modloaderLoaded", getRootElement(), sightlangModloaderLoaded)
if getElementData(localPlayer, "loggedIn") or sightexports.sModloader and sightexports.sModloader:isModloaderLoaded() then
  addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangModloaderLoaded)
end
local sightlangCondHandlState0 = false
local function sightlangCondHandl0(cond, prio)
  cond = cond and true or false
  if cond ~= sightlangCondHandlState0 then
    sightlangCondHandlState0 = cond
    if cond then
      addEventHandler("onClientPreRender", getRootElement(), preRenderLoginPreview, true, prio)
    else
      removeEventHandler("onClientPreRender", getRootElement(), preRenderLoginPreview)
    end
  end
end
weaponItemData = {}
local weaponDefaultsItems = {
  [34] = {
    1,
    -0.042115,
    -0.079786,
    0.263374,
    0.59777,
    0.502857,
    0.407519,
    -0.473005
  },
  [67] = {
    1,
    0.034553,
    0.08071,
    0.238122,
    -0.274664,
    -0.206833,
    0.644708,
    -0.682738
  },
  [68] = {
    3,
    0.277401,
    -0.11563,
    0.21778,
    -0.00111,
    -0.863511,
    0.017808,
    0.504013
  },
  [69] = {
    1,
    -0.031772,
    0.064487,
    0.193477,
    -0.511659,
    0.447768,
    -0.461819,
    -0.56959
  },
  [70] = {
    1,
    -0.018017,
    0.040445,
    0.182676,
    -0.491075,
    0.470467,
    -0.449894,
    -0.57888
  },
  [71] = {
    3,
    0.212163,
    -0.130371,
    0.181461,
    -0.00111,
    -0.863511,
    0.017808,
    0.504013
  },
  [74] = {
    3,
    0.28677,
    -0.174378,
    -0.208105,
    0.816856,
    0.044875,
    0.573866,
    0.03755
  },
  [75] = {
    3,
    0.368126,
    -0.323953,
    0.171121,
    0.101061,
    -0.110035,
    -0.988712,
    -0.011247
  },
  [76] = {
    1,
    0.043133,
    -0.041409,
    -0.22,
    -0.03748,
    -0.038491,
    0.712381,
    0.699734
  },
  [77] = {
    1,
    0.046792,
    -0.041286,
    -0.213322,
    0.030512,
    0.01832,
    -0.758963,
    -0.65016
  },
  [78] = {
    1,
    0.046792,
    -0.041286,
    -0.213322,
    0.019153,
    0.005062,
    -0.759167,
    -0.650594
  },
  [79] = {
    3,
    0.239473,
    -0.108281,
    -0.139614,
    0.010715,
    -0.112136,
    0.053864,
    -0.992174
  },
  [80] = {
    1,
    0.093743,
    -0.096157,
    0.184908,
    -0.035438,
    -0.037906,
    -0.681662,
    -0.729825
  },
  [81] = {
    3,
    0.392735,
    -0.116723,
    -0.241025,
    -0.029649,
    -0.109852,
    0.05838,
    -0.991789
  },
  [82] = {
    1,
    0.046405,
    -0.041177,
    -0.222678,
    -0.005613,
    -0.024821,
    -0.739819,
    -0.672324
  },
  [83] = {
    1,
    0.104308,
    -0.109084,
    0.179053,
    -0.094722,
    -0.122712,
    -0.729993,
    -0.665642
  },
  [84] = {
    1,
    0.133644,
    -0.025336,
    -0.245034,
    0.00369,
    -0.014583,
    -0.740092,
    -0.672338
  },
  [85] = {
    3,
    0.209761,
    -0.125965,
    -0.169275,
    -0.015083,
    -0.225722,
    0.011429,
    -0.974008
  },
  [86] = {
    3,
    0.16622,
    -0.172337,
    0.139549,
    -0.298718,
    0.032227,
    0.953739,
    -0.010542
  },
  [609] = {
    3,
    0.16622 + 0.1,
    -0.172337 - 0.05,
    0.139549 + 0.1,
    -0.298718 + 0.2,
    0.032227,
    0.953739,
    -0.010542
  },
  [87] = {
    3,
    0.178432,
    -0.170715,
    0.144826,
    -0.236836,
    0.073243,
    0.968784,
    0.001418
  },
  [88] = {
    3,
    0.226873,
    -0.141022,
    -0.195048,
    0.023643,
    -0.206978,
    0.027638,
    -0.977669
  },
  [93] = {
    3,
    -0.330997,
    0,
    0.232519,
    0.792518,
    0,
    -0.609848,
    0
  },
  [94] = {
    3,
    -0.359303,
    0.101688,
    0.236996,
    0.481191,
    0.518806,
    -0.498473,
    0.500819
  },
  [95] = {
    3,
    -0.26421,
    0.134996,
    0.218383,
    0.481191,
    0.518806,
    -0.498473,
    0.500819
  },
  [97] = {
    1,
    0.011614,
    -0.076509,
    0.182102,
    -0.498604,
    0.601323,
    0.475884,
    0.404153
  },
  [98] = {
    3,
    0.450293,
    -0.231582,
    0.021395,
    0.241373,
    0.008209,
    -0.970398,
    -3.29E-4
  },
  [99] = {
    3,
    0.225779,
    0.15913,
    -0.120352,
    0.078711,
    -0.071356,
    -0.711539,
    -0.694568
  },
  [102] = {
    1,
    0.026635,
    0.097775,
    0.186295,
    -0.491075,
    0.470467,
    -0.449894,
    -0.57888
  },
  [103] = {
    1,
    -0.02992,
    0.063941,
    0.204241,
    -0.511659,
    0.447768,
    -0.461819,
    -0.56959
  },
  [104] = {
    3,
    0.212163,
    -0.130371,
    0.181461,
    -0.00111,
    -0.863511,
    0.017808,
    0.504013
  },
  [107] = {
    3,
    0.031573,
    -0.194868,
    0.001223,
    0.720661,
    0,
    -0.693288,
    0
  },
  [155] = {
    1,
    0.058433,
    -0.086249,
    0.192335,
    0.020981,
    0.074858,
    0.715657,
    0.694112
  },
  [426] = {
    3,
    0.221267,
    -0.126268,
    0.18646,
    -0.00111,
    -0.863511,
    0.017808,
    0.504013
  },
  [471] = {
    1,
    0.039093,
    -0.033851,
    -0.22328,
    0.036123,
    0.03003,
    -0.665526,
    -0.744895
  },
  [475] = {
    3,
    0.225095,
    -0.118134,
    -0.192661,
    -0.005107,
    -0.206076,
    0.03371,
    -0.977942
  },
  [480] = {
    3,
    0.189283,
    -0.190255,
    0.14249,
    0.249165,
    -0.048495,
    -0.96656,
    -0.03643
  },
  [483] = {
    3,
    0.189283,
    -0.190255,
    0.14249,
    0.249165,
    -0.048495,
    -0.96656,
    -0.03643
  },
  [486] = {
    3,
    0.189283,
    -0.190255,
    0.14249,
    0.249165,
    -0.048495,
    -0.96656,
    -0.03643
  },
  [489] = {
    3,
    0.293624,
    -0.120587,
    -0.140838,
    -0.026003,
    -0.116247,
    0.026493,
    -0.992526
  },
  [492] = {
    3,
    0.240451,
    -0.130093,
    -0.158441,
    0.014809,
    -0.283557,
    0.001318,
    -0.95884
  },
  [493] = {
    1,
    0.039093,
    -0.033851,
    -0.22328,
    0.036123,
    0.03003,
    -0.665526,
    -0.744895
  },
  [500] = {
    1,
    0.039093,
    -0.033851,
    -0.22328,
    0.036123,
    0.03003,
    -0.665526,
    -0.744895
  },
  [505] = {
    3,
    0.226632,
    -0.124517,
    -0.240601,
    0.001549,
    -0.283511,
    0.005238,
    -0.958953
  },
  [507] = {
    3,
    0.189283,
    -0.190255,
    0.14249,
    0.249165,
    -0.048495,
    -0.96656,
    -0.03643
  },
  [512] = {
    3,
    0.189283,
    -0.190255,
    0.14249,
    0.249165,
    -0.048495,
    -0.96656,
    -0.03643
  },
  [517] = {
    3,
    0.224934,
    -0.183943,
    0.15799,
    0.195994,
    -0.075044,
    -0.976606,
    -0.046851
  },
  [520] = {
    3,
    0.118109,
    -0.177052,
    0.060813,
    0.344417,
    -0.05189,
    -0.936855,
    -0.031407
  },
  [527] = {
    1,
    0.104138,
    -0.053135,
    -0.212708,
    0.00496,
    -0.013019,
    -0.752132,
    -0.658865
  },
  [528] = {
    3,
    0.118109,
    -0.177052,
    0.060813,
    0.344417,
    -0.05189,
    -0.936855,
    -0.031407
  },
  [556] = {
    3,
    0.067631,
    -0.124754,
    -0.107417,
    -0.05273,
    -0.211005,
    -0.011564,
    -0.975993
  },
  [561] = {
    1,
    0.039093,
    -0.033851,
    -0.22328,
    0.032263,
    0.025348,
    -0.682244,
    -0.729972
  },
  [562] = {
    3,
    0.318925,
    -0.117981,
    -0.222808,
    -0.037041,
    -0.127942,
    0.028614,
    -0.990677
  },
  [573] = {
    1,
    -0.398654,
    0.062922,
    0.328231,
    -0.471142,
    -0.490428,
    0.57826,
    -0.450689
  },
  [574] = {
    1,
    0.00422,
    -0.113588,
    0.252658,
    0.601355,
    0.498564,
    0.404122,
    -0.475911
  },
  [575] = {
    1,
    0.039093,
    -0.033851,
    -0.22328,
    0.036123,
    0.03003,
    -0.665526,
    -0.744895
  },
  [582] = {
    1,
    -0.038659,
    -0.060369,
    0.25807,
    0.5795,
    0.523808,
    0.424091,
    -0.458206
  },
  [34] = {
    1,
    0.033964,
    0.061002,
    0.259083,
    0.454858,
    -0.41278,
    0.520485,
    0.593138
  },
  [164] = {
    3,
    0.243968,
    -0.189927,
    -0.050187,
    0.585619,
    0.027288,
    0.809804,
    -0.022881
  },
  [724] = {
    3,
    0.243968,
    -0.189927,
    -0.050187,
    0.585619,
    0.027288,
    0.809804,
    -0.022881
  },
  [725] = {
    3,
    0.243968,
    -0.189927,
    -0.050187,
    0.585619,
    0.027288,
    0.809804,
    -0.022881
  },
  [726] = {
    3,
    0.243968,
    -0.189927,
    -0.050187,
    0.585619,
    0.027288,
    0.809804,
    -0.022881
  },
  [727] = {
    3,
    0.243968,
    -0.189927,
    -0.050187,
    0.585619,
    0.027288,
    0.809804,
    -0.022881
  },
  [107] = {
    3,
    0.078515,
    -0.124258,
    -0.01337,
    0.722442,
    0,
    -0.691431,
    0
  }
}
weaponDefaults = {}
function loadModelIds()
  for model in pairs(clothesList) do
    clothesList[model].model = sightexports.sModloader:getModelId(model)
    if not clothesList[model].model then
    end
  end
  local itemIds = sightexports.sWeapons:getWeaponItemIds()
  for itemId in pairs(itemIds) do
    local modelOrig, bone, canHide = sightexports.sWeapons:getWeaponClothesshopData(itemId)
    local model = false
    if modelOrig then
      model = tonumber(modelOrig) or sightexports.sModloader:getModelId(modelOrig)
      if not model then
      end
      weaponItemData[itemId] = {
        model,
        bone,
        modelOrig,
        canHide
      }
    end
  end
  weaponDefaults = {}
  for item, dat in pairs(weaponDefaultsItems) do
    if weaponItemData[item] then
      local model = weaponItemData[item][3]
      local bone = weaponItemData[item][2]
      if model then
        if type(bone) == "table" then
          for b in pairs(bone) do
            if b == dat[1] then
              weaponDefaults[model] = dat
              break
            end
          end
        elseif tonumber(bone) == dat[1] then
          weaponDefaults[model] = dat
        end
      end
    end
  end
  initClothes()
end
local streamedClientList = {}
streamedWeapons = {}
streamedClothes = {}
local streamOutTime = {}
selfWeaponShader = {}
selfWeaponTex = {}
playerWeaponCoords = {}
local currentWeapon = {}
streamedClothes[localPlayer] = {}
streamedWeapons[localPlayer] = {}
playerWeaponCoords[localPlayer] = {}
myClothData = {}
local storedAlpha = {}
addEventHandler("onClientPreRender", getRootElement(), function()
  for i = 1, #streamedClientList do
    local client = streamedClientList[i]
    if isElement(client) then
      local alpha = getElementAlpha(client)
      if storedAlpha[client] ~= alpha then
        storedAlpha[client] = alpha
        for item, obj in pairs(streamedWeapons[client]) do
          if isElement(obj) then
            setElementAlpha(obj, alpha)
          end
        end
        for slot, obj in pairs(streamedClothes[client]) do
          if isElement(obj) then
            setElementAlpha(obj, alpha)
          end
        end
      end
    end
  end
end)
function refreshPlayerWeapon(client, item)
  if playerWeaponCoords[client] then
    if weaponItemData[item] and playerWeaponCoords[client][item] and currentWeapon[client] ~= item then
      if not isElement(streamedWeapons[client][item]) then
        streamedWeapons[client][item] = createObject(weaponItemData[item][1], 0, 0, 0)
        setElementCollisionsEnabled(streamedWeapons[client][item], false)
      else
        setElementModel(streamedWeapons[client][item], weaponItemData[item][1])
      end
      local bone = playerWeaponCoords[client][item][1]
      if tonumber(weaponItemData[item][2]) then
        bone = weaponItemData[item][2]
      elseif not weaponItemData[item][2][bone] then
        for k in pairs(weaponItemData[item][2]) do
          bone = k
          break
        end
      end
      if client == localPlayer then
        if item == editingWeapon then
          setElementAlpha(streamedWeapons[client][item], 0)
        else
          setElementAlpha(streamedWeapons[client][item], getElementAlpha(client))
        end
      end
      sightexports.sPattach:detach(streamedWeapons[client][item])
      sightexports.sPattach:attach(streamedWeapons[client][item], client, bone, -playerWeaponCoords[client][item][4], playerWeaponCoords[client][item][3], playerWeaponCoords[client][item][2], 0, 0, 0)
      sightexports.sPattach:setRotationQuaternion(streamedWeapons[client][item], playerWeaponCoords[client][item][5])
      setElementAlpha(streamedWeapons[client][item], getElementAlpha(client))
      local shader, tex = sightexports.sWeapons:processWPSkinBack(client, item, true)
      if shader then
        engineApplyShaderToWorldTexture(shader, tex, streamedWeapons[client][item])
        if client == localPlayer then
          selfWeaponShader[item] = shader
          selfWeaponTex[item] = tex
        end
      end
    elseif item then
      sightexports.sWeapons:processWPSkinBack(client, item, false)
      if client == localPlayer then
        selfWeaponShader[item] = nil
        selfWeaponTex[item] = nil
      end
      if isElement(streamedWeapons[client][item]) then
        destroyElement(streamedWeapons[client][item])
      end
      streamedWeapons[client][item] = nil
    end
  end
end
function refreshPlayerCloth(client, slot, model, bone, x, y, z, q, sx, sy, sz, armorId)
  if streamedClothes[client] then
    if client == localPlayer then
      if bone then
        myClothData[slot] = {
          model,
          bone,
          x,
          y,
          z,
          q,
          sx,
          sy,
          sz,
          armorId
        }
      else
        myClothData[slot] = nil
      end
      if clothesListWindow then
        createClothesList()
      end
    end
    if clothesList[model] then
      if not isElement(streamedClothes[client][slot]) then
        streamedClothes[client][slot] = createObject(clothesList[model].model, 0, 0, 0)
        setElementCollisionsEnabled(streamedClothes[client][slot], false)
        if model == "v4_mining_hardhat" and exports.sMining:isPlayerInMine(client) then
          exports.sMining:setStreamedHardHat(client, streamedClothes[client][slot])
        end
      else
        setElementModel(streamedClothes[client][slot], clothesList[model].model)
        if model == "v4_mining_hardhat" and exports.sMining:isPlayerInMine(client) then
          exports.sMining:setStreamedHardHat(client, streamedClothes[client][slot])
        end
      end
      if client == localPlayer then
        if slot == editingSlot then
          setElementAlpha(streamedClothes[client][slot], 0)
        else
          setElementAlpha(streamedClothes[client][slot], getElementAlpha(client))
        end
      end
      sightexports.sPattach:detach(streamedClothes[client][slot])
      sightexports.sPattach:attach(streamedClothes[client][slot], client, bone, -z, y, x, 0, 0, 0)
      sightexports.sPattach:setRotationQuaternion(streamedClothes[client][slot], q)
      setObjectScale(streamedClothes[client][slot], sx, sy, sz)
    else
      if isElement(streamedClothes[client][slot]) then
        if model == "v4_mining_hardhat" then
          exports.sMining:setStreamedHardHat(client, false)
        end
        destroyElement(streamedClothes[client][slot])
      end
      streamedClothes[client][slot] = nil
    end
  end
end
function getPlayerMiningHat(client)
  local obj = false
  if not streamedClothes[client] then
    return nil
  end
  for slot, objectElement in pairs(streamedClothes[client]) do
    local modelName = exports.sModloader:getModelNameById(getElementModel(streamedClothes[client][slot]))
    if modelName == "v4_mining_hardhat" then
      obj = objectElement
    end
  end
  return obj
end
function getSelfClothData()
  local objs = {}
  for slot, dat in pairs(myClothData) do
    local model, bone, x, y, z, q, sx, sy, sz = unpack(dat)
    table.insert(objs, {
      clothesList[model].model,
      bone,
      -z,
      y,
      x,
      q,
      sx,
      sy,
      sz
    })
  end
  for item in pairs(streamedWeapons[localPlayer]) do
    local bone = playerWeaponCoords[localPlayer][item][1]
    if tonumber(weaponItemData[item][2]) then
      bone = weaponItemData[item][2]
    elseif not weaponItemData[item][2][bone] then
      for k in pairs(weaponItemData[item][2]) do
        bone = k
        break
      end
    end
    local shader, tex, texEl = sightexports.sWeapons:processWPSkinBack("self", item, true)
    table.insert(objs, {
      weaponItemData[item][1],
      bone,
      -playerWeaponCoords[localPlayer][item][4],
      playerWeaponCoords[localPlayer][item][3],
      playerWeaponCoords[localPlayer][item][2],
      playerWeaponCoords[localPlayer][item][5],
      1,
      1,
      1,
      shader and tex,
      shader and texEl,
      item
    })
  end
  return objs
end
addEvent("refreshPlayerClothWeapon", true)
addEventHandler("refreshPlayerClothWeapon", getRootElement(), function(item, new)
  if streamedWeapons[source] then
    if source == localPlayer and item == editingWeapon then
      stopEditorSaving()
    else
      if new then
        if item then
          triggerLatentServerEvent("requestPlayerWeaponCloth", source, item)
        else
          if playerWeaponCoords[source] then
            for item in pairs(playerWeaponCoords[source]) do
              playerWeaponCoords[source][item] = nil
              refreshPlayerWeapon(source, item)
            end
          end
          triggerLatentServerEvent("requestPlayerWeaponClothesAll", source)
        end
      elseif item and playerWeaponCoords[source] then
        playerWeaponCoords[source][item] = nil
      end
      refreshPlayerWeapon(source, item)
    end
    if not new and source == localPlayer and weaponWindow then
      openWeaponClothesEditor()
    end
  end
end)
addEvent("refreshPlayerCloth", true)
addEventHandler("refreshPlayerCloth", getRootElement(), function(slot, new)
  if streamedClothes[source] then
    if source == localPlayer and slot == editingSlot then
      stopEditorSaving()
    elseif new then
      if slot then
        triggerLatentServerEvent("requestPlayerSingleCloth", source, slot)
      else
        for slot in pairs(streamedClothes[client]) do
          refreshPlayerCloth(source, slot, false)
        end
        triggerLatentServerEvent("requestPlayerClothes", source)
      end
    elseif slot then
      if isElement(streamedClothes[source][slot]) then
        destroyElement(streamedClothes[source][slot])
      end
      streamedClothes[source][slot] = nil
      if source == localPlayer then
        myClothData[slot] = nil
        if clothesListWindow then
          createClothesList()
        end
      end
    end
  end
end)
addEvent("gotPlayerCloth", true)
addEventHandler("gotPlayerCloth", getRootElement(), function(slot, model, bone, x, y, z, q, sx, sy, sz, armorId)
  refreshPlayerCloth(source, slot, model, bone, x, y, z, q, sx, sy, sz, armorId)
end)
addEvent("gotPlayerWeaponCloth", true)
addEventHandler("gotPlayerWeaponCloth", getRootElement(), function(item, bone, x, y, z, q)
  if playerWeaponCoords[source] and weaponItemData[item] then
    if bone then
      if bone == -1 then
        local model = weaponItemData[item][3]
        if weaponDefaults[model] then
          playerWeaponCoords[source][item] = {
            weaponDefaults[model][1],
            weaponDefaults[model][2],
            weaponDefaults[model][3],
            weaponDefaults[model][4],
            {
              weaponDefaults[model][5],
              weaponDefaults[model][6],
              weaponDefaults[model][7],
              weaponDefaults[model][8]
            }
          }
        else
          local bone = tonumber(weaponItemData[item][2]) or weaponItemData[item][2][1]
          playerWeaponCoords[source][item] = {
            bone,
            0,
            0,
            0,
            {
              1,
              0,
              0,
              0
            }
          }
        end
      else
        playerWeaponCoords[source][item] = {
          bone,
          x,
          y,
          z,
          q
        }
      end
    else
      playerWeaponCoords[source][item] = nil
    end
    refreshPlayerWeapon(source, item)
    if source == localPlayer and weaponWindow then
      openWeaponClothesEditor()
    end
  end
end)
function streamOut(client)
  if client ~= localPlayer then
    if streamedClothes[client] then
      for slot, obj in pairs(streamedClothes[client]) do
        if isElement(obj) then
          destroyElement(obj)
        end
      end
    end
    if streamedWeapons[client] then
      for item, obj in pairs(streamedWeapons[client]) do
        if isElement(obj) then
          destroyElement(obj)
        end
        sightexports.sWeapons:processWPSkinBack(client, item, false)
      end
    end
    streamedClothes[client] = nil
    streamedWeapons[client] = nil
  end
  for i = #streamedClientList, 1, -1 do
    if streamedClientList[i] == client then
      table.remove(streamedClientList, i)
    end
  end
  streamOutTime[client] = nil
  storedAlpha[client] = nil
  currentWeapon[client] = nil
  playerWeaponCoords[client] = nil
end
setTimer(function()
  local now = getTickCount()
  for client, t in pairs(streamOutTime) do
    if 15000 < now - t then
      streamOut(client)
    end
  end
end, 5000, 0)
local clothesInitDone = false
function initClothes()
  local players = getElementsByType("player", getRootElement(), true)
  for i = 1, #players do
    if not streamedClothes[players[i]] then
      streamedClothes[players[i]] = {}
    end
    if not streamedWeapons[players[i]] then
      streamedWeapons[players[i]] = {}
    end
    if not playerWeaponCoords[players[i]] then
      playerWeaponCoords[players[i]] = {}
    end
    currentWeapon[players[i]] = getElementData(players[i], "customWP") or getElementData(players[i], "normalWP")
    streamOutTime[players[i]] = nil
    triggerLatentServerEvent("requestPlayerWeaponClothesAll", players[i])
    triggerLatentServerEvent("requestPlayerClothes", players[i])
    table.insert(streamedClientList, players[i])
  end
  clothesInitDone = true
end
addEventHandler("onClientElementDataChange", getRootElement(), function(data, old, new)
  if (data == "customWP" or data == "normalWP") and streamedWeapons[source] then
    local old = currentWeapon[source]
    currentWeapon[source] = getElementData(source, "customWP") or getElementData(source, "normalWP")
    if old then
      refreshPlayerWeapon(source, old)
    end
    if currentWeapon[source] then
      refreshPlayerWeapon(source, currentWeapon[source])
    end
  end
end)
addEventHandler("onClientElementStreamIn", getRootElement(), function()
  if clothesInitDone and source ~= localPlayer then
    currentWeapon[source] = getElementData(source, "customWP") or getElementData(source, "normalWP")
    streamOutTime[source] = nil
    if getElementType(source) == "player" and not streamedClothes[source] then
      streamedClothes[source] = {}
      streamedWeapons[source] = {}
      playerWeaponCoords[source] = {}
      triggerLatentServerEvent("requestPlayerWeaponClothesAll", source)
      triggerLatentServerEvent("requestPlayerClothes", source)
      table.insert(streamedClientList, source)
    end
  end
end)
addEventHandler("onClientElementStreamOut", getRootElement(), function()
  if streamedClothes[source] and source ~= localPlayer then
    streamOutTime[source] = getTickCount()
  end
end)
addEventHandler("onClientPlayerQuit", getRootElement(), function()
  streamOut(source)
end)
local loginPeds = {}
local loginPedAlpha = {}
local loginPedObjs = {}
local loginPedItems = {}
function preRenderLoginPreview()
  for cid, ped in pairs(loginPeds) do
    if isElement(ped) then
      local a = getElementAlpha(ped)
      if loginPedAlpha[ped] ~= a then
        loginPedAlpha[ped] = a
        if loginPedObjs[ped] then
          for i = 1, #loginPedObjs[ped] do
            setElementAlpha(loginPedObjs[ped][i], a)
          end
        end
      end
    else
      loginPeds[cid] = nil
    end
  end
  for cid, ped in pairs(loginPeds) do
    return
  end
  sightlangCondHandl0(false)
end
function doLoginClothesPreview(peds)
  local charIds = {}
  for cid, ped in pairs(peds) do
    if loginPeds[cid] then
      if loginPedObjs[loginPeds[cid]] then
        for i = 1, #loginPedObjs[loginPeds[cid]] do
          if isElement(loginPedObjs[loginPeds[cid]][i]) then
            destroyElement(loginPedObjs[loginPeds[cid]][i])
          end
        end
      end
      loginPedObjs[loginPeds[cid]] = nil
      if loginPedItems[loginPeds[cid]] then
        for i = 1, #loginPedItems[loginPeds[cid]] do
          sightexports.sWeapons:processWPSkinBack("login", loginPedItems[loginPeds[cid]][i], false)
        end
      end
      loginPedItems[loginPeds[cid]] = nil
    end
    loginPedAlpha[ped] = false
    loginPeds[cid] = ped
    table.insert(charIds, cid)
    addEventHandler("onClientElementDestroy", ped, destroyLoginPeds)
  end
  sightlangCondHandl0(true)
  triggerServerEvent("getLoginPreviewClothes", localPlayer, charIds)
end
function destroyLoginPeds()
  if loginPedObjs[source] then
    for i = 1, #loginPedObjs[source] do
      if isElement(loginPedObjs[source][i]) then
        destroyElement(loginPedObjs[source][i])
      end
    end
  end
  loginPedObjs[source] = nil
  if loginPedItems[source] then
    for i = 1, #loginPedItems[source] do
      sightexports.sWeapons:processWPSkinBack("login", loginPedItems[source][i], false)
    end
  end
  loginPedItems[source] = nil
  loginPedAlpha[source] = nil
  for cid, ped in pairs(loginPeds) do
    if ped == source then
      loginPeds[cid] = nil
    end
  end
end
addEvent("gotLoginPreviewClothes", true)
addEventHandler("gotLoginPreviewClothes", getRootElement(), function(cid, result)
  if isElement(loginPeds[cid]) then
    if loginPedObjs[loginPeds[cid]] then
      for i = 1, #loginPedObjs[loginPeds[cid]] do
        if isElement(loginPedObjs[loginPeds[cid]][i]) then
          destroyElement(loginPedObjs[loginPeds[cid]][i])
        end
      end
    end
    if loginPedItems[loginPeds[cid]] then
      for i = 1, #loginPedItems[loginPeds[cid]] do
        sightexports.sWeapons:processWPSkinBack("login", loginPedItems[loginPeds[cid]][i], false)
      end
    end
    loginPedObjs[loginPeds[cid]] = {}
    loginPedItems[loginPeds[cid]] = {}
    for i = 1, #result.clothes do
      local model, bone, x, y, z, q, sx, sy, sz = unpack(result.clothes[i])
      if clothesList[model] then
        local obj = createObject(clothesList[model].model, 0, 0, 0, 0, 0, 0)
        setElementInterior(obj, getElementInterior(loginPeds[cid]))
        setElementDimension(obj, getElementDimension(loginPeds[cid]))
        sightexports.sPattach:detach(obj)
        sightexports.sPattach:attach(obj, loginPeds[cid], bone, -z, y, x, 0, 0, 0)
        sightexports.sPattach:setRotationQuaternion(obj, q)
        setObjectScale(obj, sx, sy, sz)
        table.insert(loginPedObjs[loginPeds[cid]], obj)
        setElementAlpha(obj, 0)
      end
    end
    for i = 1, #result.weapons do
      local item, bone, x, y, z, q = unpack(result.weapons[i])
      if weaponItemData[item] then
        local model = weaponItemData[item][3]
        if not bone and weaponDefaults[model] then
          local q1, q2, q3, q4
          bone, x, y, z, q1, q2, q3, q4 = weaponDefaults[model][1], weaponDefaults[model][2], weaponDefaults[model][3], weaponDefaults[model][4], weaponDefaults[model][5], weaponDefaults[model][6], weaponDefaults[model][7], weaponDefaults[model][8]
          q = {
            q1,
            q2,
            q3,
            q4
          }
        end
        if tonumber(weaponItemData[item][2]) then
          bone = weaponItemData[item][2]
        elseif not weaponItemData[item][2][bone] then
          for k in pairs(weaponItemData[item][2]) do
            bone = k
            break
          end
        end
        if bone and x then
          model = weaponItemData[item][1]
          local obj = createObject(model, 0, 0, 0, 0, 0, 0)
          setElementInterior(obj, getElementInterior(loginPeds[cid]))
          setElementDimension(obj, getElementDimension(loginPeds[cid]))
          sightexports.sPattach:detach(obj)
          sightexports.sPattach:attach(obj, loginPeds[cid], bone, -z, y, x, 0, 0, 0)
          sightexports.sPattach:setRotationQuaternion(obj, q)
          local shader, tex = sightexports.sWeapons:processWPSkinBack("login", item, true)
          if shader then
            engineApplyShaderToWorldTexture(shader, tex, obj)
          end
          table.insert(loginPedItems[loginPeds[cid]], item)
          table.insert(loginPedObjs[loginPeds[cid]], obj)
          setElementAlpha(obj, 0)
        end
      end
    end
    sightlangCondHandl0(true)
    loginPedAlpha[loginPeds[cid]] = false
  end
end)
