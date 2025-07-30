local seexports = {
  sModloader = false,
  sMarkers = false,
  sGui = false,
  sGroups = false,
  sPermission = false,
  sItems = false
}
local function seelangProcessExports()
  for k in pairs(seexports) do
    local res = getResourceFromName(k)
    if res and getResourceState(res) == "running" then
      seexports[k] = exports[k]
    else
      seexports[k] = false
    end
  end
end
seelangProcessExports()
if triggerServerEvent then
  addEventHandler("onClientResourceStart", getRootElement(), seelangProcessExports, true, "high+9999999999")
end
if triggerClientEvent then
  addEventHandler("onResourceStart", getRootElement(), seelangProcessExports, true, "high+9999999999")
end
local seelangStatImgHand = false
local seelangStaticImage = {}
local seelangStaticImageToc = {}
local seelangStaticImageUsed = {}
local seelangStaticImageDel = {}
local processSeelangStaticImage = {}
seelangStaticImageToc[0] = true
seelangStaticImageToc[1] = true
seelangStaticImageToc[2] = true
seelangStaticImageToc[3] = true
seelangStaticImageToc[4] = true
local seelangStatImgPre
function seelangStatImgPre()
  local now = getTickCount()
  if seelangStaticImageUsed[0] then
    seelangStaticImageUsed[0] = false
    seelangStaticImageDel[0] = false
  elseif seelangStaticImage[0] then
    if seelangStaticImageDel[0] then
      if now >= seelangStaticImageDel[0] then
        if isElement(seelangStaticImage[0]) then
          destroyElement(seelangStaticImage[0])
        end
        seelangStaticImage[0] = nil
        seelangStaticImageDel[0] = false
        seelangStaticImageToc[0] = true
        return
      end
    else
      seelangStaticImageDel[0] = now + 5000
    end
  else
    seelangStaticImageToc[0] = true
  end
  if seelangStaticImageUsed[1] then
    seelangStaticImageUsed[1] = false
    seelangStaticImageDel[1] = false
  elseif seelangStaticImage[1] then
    if seelangStaticImageDel[1] then
      if now >= seelangStaticImageDel[1] then
        if isElement(seelangStaticImage[1]) then
          destroyElement(seelangStaticImage[1])
        end
        seelangStaticImage[1] = nil
        seelangStaticImageDel[1] = false
        seelangStaticImageToc[1] = true
        return
      end
    else
      seelangStaticImageDel[1] = now + 5000
    end
  else
    seelangStaticImageToc[1] = true
  end
  if seelangStaticImageUsed[2] then
    seelangStaticImageUsed[2] = false
    seelangStaticImageDel[2] = false
  elseif seelangStaticImage[2] then
    if seelangStaticImageDel[2] then
      if now >= seelangStaticImageDel[2] then
        if isElement(seelangStaticImage[2]) then
          destroyElement(seelangStaticImage[2])
        end
        seelangStaticImage[2] = nil
        seelangStaticImageDel[2] = false
        seelangStaticImageToc[2] = true
        return
      end
    else
      seelangStaticImageDel[2] = now + 5000
    end
  else
    seelangStaticImageToc[2] = true
  end
  if seelangStaticImageUsed[3] then
    seelangStaticImageUsed[3] = false
    seelangStaticImageDel[3] = false
  elseif seelangStaticImage[3] then
    if seelangStaticImageDel[3] then
      if now >= seelangStaticImageDel[3] then
        if isElement(seelangStaticImage[3]) then
          destroyElement(seelangStaticImage[3])
        end
        seelangStaticImage[3] = nil
        seelangStaticImageDel[3] = false
        seelangStaticImageToc[3] = true
        return
      end
    else
      seelangStaticImageDel[3] = now + 5000
    end
  else
    seelangStaticImageToc[3] = true
  end
  if seelangStaticImageUsed[4] then
    seelangStaticImageUsed[4] = false
    seelangStaticImageDel[4] = false
  elseif seelangStaticImage[4] then
    if seelangStaticImageDel[4] then
      if now >= seelangStaticImageDel[4] then
        if isElement(seelangStaticImage[4]) then
          destroyElement(seelangStaticImage[4])
        end
        seelangStaticImage[4] = nil
        seelangStaticImageDel[4] = false
        seelangStaticImageToc[4] = true
        return
      end
    else
      seelangStaticImageDel[4] = now + 5000
    end
  else
    seelangStaticImageToc[4] = true
  end
  if seelangStaticImageToc[0] and seelangStaticImageToc[1] and seelangStaticImageToc[2] and seelangStaticImageToc[3] and seelangStaticImageToc[4] then
    seelangStatImgHand = false
    removeEventHandler("onClientPreRender", getRootElement(), seelangStatImgPre)
  end
end
processSeelangStaticImage[0] = function()
  if not isElement(seelangStaticImage[0]) then
    seelangStaticImageToc[0] = false
    seelangStaticImage[0] = dxCreateTexture("files/textures/wet.dds", "argb", true)
  end
  if not seelangStatImgHand then
    seelangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), seelangStatImgPre, true, "high+999999999")
  end
end
processSeelangStaticImage[1] = function()
  if not isElement(seelangStaticImage[1]) then
    seelangStaticImageToc[1] = false
    seelangStaticImage[1] = dxCreateTexture("files/textures/road.dds", "argb", true)
  end
  if not seelangStatImgHand then
    seelangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), seelangStatImgPre, true, "high+999999999")
  end
end
processSeelangStaticImage[2] = function()
  if not isElement(seelangStaticImage[2]) then
    seelangStaticImageToc[2] = false
    seelangStaticImage[2] = dxCreateTexture("files/water.dds", "argb", true)
  end
  if not seelangStatImgHand then
    seelangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), seelangStatImgPre, true, "high+999999999")
  end
end
processSeelangStaticImage[3] = function()
  if not isElement(seelangStaticImage[3]) then
    seelangStaticImageToc[3] = false
    seelangStaticImage[3] = dxCreateTexture("files/glass.dds", "argb", true)
  end
  if not seelangStatImgHand then
    seelangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), seelangStatImgPre, true, "high+999999999")
  end
end
processSeelangStaticImage[4] = function()
  if not isElement(seelangStaticImage[4]) then
    seelangStaticImageToc[4] = false
    seelangStaticImage[4] = dxCreateTexture("files/tri.dds", "argb", true)
  end
  if not seelangStatImgHand then
    seelangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), seelangStatImgPre, true, "high+999999999")
  end
end
local seelangDynImgHand = false
local seelangDynImgLatCr = falselocal
seelangDynImage = {}
local seelangDynImageForm = {}
local seelangDynImageMip = {}
local seelangDynImageUsed = {}
local seelangDynImageDel = {}
local seelangDynImgPre
function seelangDynImgPre()
  local now = getTickCount()
  seelangDynImgLatCr = true
  local rem = true
  for k in pairs(seelangDynImage) do
    rem = false
    if seelangDynImageDel[k] then
      if now >= seelangDynImageDel[k] then
        if isElement(seelangDynImage[k]) then
          destroyElement(seelangDynImage[k])
        end
        seelangDynImage[k] = nil
        seelangDynImageForm[k] = nil
        seelangDynImageMip[k] = nil
        seelangDynImageDel[k] = nil
        break
      end
    elseif not seelangDynImageUsed[k] then
      seelangDynImageDel[k] = now + 5000
    end
  end
  for k in pairs(seelangDynImageUsed) do
    if not seelangDynImage[k] and seelangDynImgLatCr then
      seelangDynImgLatCr = false
      seelangDynImage[k] = dxCreateTexture(k, seelangDynImageForm[k], seelangDynImageMip[k])
    end
    seelangDynImageUsed[k] = nil
    seelangDynImageDel[k] = nil
    rem = false
  end
  if rem then
    removeEventHandler("onClientPreRender", getRootElement(), seelangDynImgPre)
    seelangDynImgHand = false
  end
end
local function dynamicImage(img, form, mip)
  if not seelangDynImgHand then
    seelangDynImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), seelangDynImgPre, true, "high+999999999")
  end
  if not seelangDynImage[img] then
    seelangDynImage[img] = dxCreateTexture(img, form, mip)
  end
  seelangDynImageForm[img] = form
  seelangDynImageUsed[img] = true
  return seelangDynImage[img]
end
local seelangWaiterState0 = false
local seelangWaiterState1 = false
local function seelangProcessResWaiters()
  if not seelangWaiterState0 then
    local res0 = getResourceFromName("sMarkers")
    if res0 and getResourceState(res0) == "running" then
      markersReady()
      createCurrentMarker()
      seelangWaiterState0 = true
    end
  end
  if not seelangWaiterState1 then
    local res0 = getResourceFromName("sItems")
    if res0 and getResourceState(res0) == "running" then
      initDealerNPCs()
      seelangWaiterState1 = true
    end
  end
end
if triggerServerEvent then
  addEventHandler("onClientResourceStart", getRootElement(), seelangProcessResWaiters)
end
if triggerClientEvent then
  addEventHandler("onResourceStart", getRootElement(), seelangProcessResWaiters)
end
local function seelangGuiRefreshColors()
  local res = getResourceFromName("sGui")
  if res and getResourceState(res) == "running" then
    blue = seexports.sGui:getColorCode("sightblue")
    yellow = seexports.sGui:getColorCode("sightyellow")
    green = seexports.sGui:getColorCode("sightgreen")
    greenHex = seexports.sGui:getColorCodeHex("sightgreen")
    red = seexports.sGui:getColorCode("sightred")
    redHex = seexports.sGui:getColorCodeHex("sightred")
    progressGrad = seexports.sGui:getGradient2Filename(screenX * 0.3, screenY * 0.05 / 4, green, red, force)
    gradientTick = seexports.sGui:getGradientTick()
  end
end
addEventHandler("onGuiRefreshColors", getRootElement(), seelangGuiRefreshColors)
addEventHandler("onClientResourceStart", getResourceRootElement(), seelangGuiRefreshColors)
addEventHandler("refreshGradientTick", getRootElement(), function()
  gradientTick = seexports.sGui:getGradientTick()
end)
local seelangModloaderLoaded = function()
  loadModels()
  refreshRTs()
end
addEventHandler("modloaderLoaded", getRootElement(), seelangModloaderLoaded)
if getElementData(localPlayer, "loggedIn") or seexports.sModloader and seexports.sModloader:isModloaderLoaded() then
  addEventHandler("onClientResourceStart", getResourceRootElement(), seelangModloaderLoaded)
end
screenX, screenY = guiGetScreenSize()
local farmMarkedOnMap = false
local farmMarkerOnMap = false
models = {
  crate = false,
  crate2 = false,
  kanna = false,
  hoe = false,
  minihoe = false,
  inti_kicsi = false,
  silicon09a_sfs = false,
  silicon09b_sfs = false,
  egg = false,
  egg_crate = false,
  milk_crate = false,
  animaldoor = false,
  bucket = false,
  bucket_csirketap = false,
  bucket_milk = false,
  bucket_pellet = false,
  bucket_water = false,
  feed_bag = false,
  chicken_feed_bag = false,
  utiltr1 = false,
  animalfarm = false,
  csirketap = false,
  valyupellet = false,
  csirke_eteto = false,
  csirke_itato = false,
  valyu = false,
  pitchfork = false,
  pitchfork_loaded = false,
  pitchfork_loaded_manure = false,
  bale = false,
  furik = false,
  furik_wheel = false,
  furik_manure = false,
  exterior_5 = false,
  exterior_10 = false,
  exterior_15 = false,
  exterior_5_LOD = false,
  exterior_10_LOD = false,
  exterior_15_LOD = false,
  ["plants/Tokok/palanta"] = false,
  ["plants/Tokok/sutotok"] = false,
  ["plants/Uborka/iborka_szar"] = false,
  ["plants/Uborka/iborka_termes"] = false,
  ["plants/Kaposzta/kaposzta"] = false,
  ["plants/Karalabe/karalabe"] = false,
  ["plants/Lilahagyma/lilahagyma_szar"] = false,
  ["plants/Lilahagyma/lilahagyma_termes"] = false,
  ["plants/Voroshagyma/voroshagyma_szar"] = false,
  ["plants/Voroshagyma/voroshagyma_termes"] = false,
  ["plants/Paprika/paprika_bokor"] = false,
  ["plants/Paprika/paprika_tv"] = false,
  ["plants/Paprika/paprika_chili"] = false,
  ["plants/Paprika/paprika_alma"] = false,
  ["plants/Petrezselyem/petrezselyem_szar"] = false,
  ["plants/Petrezselyem/petrezselyem_termes"] = false,
  ["plants/Repa/repa_szar"] = false,
  ["plants/Repa/repa_termes"] = false,
  ["plants/Retek/retek_szar"] = false,
  ["plants/Retek/retek_termes"] = false,
  ["plants/Salata/salata"] = false,
  ["plants/Dinnyek/palanta"] = false,
  ["plants/Dinnyek/gorogdinnye"] = false,
  ["plants/Dinnyek/sargadinnye"] = false,
  ["plants/parazen/szar"] = false,
  ["plants/parazen/virag"] = false,
  magic_mushroom = false,
  mak = false,
  marihuana = false,
  kokacserje = false
}
function loadModels()
  globalModels = {
    crate = 1355,
    crate2 = seexports.sModloader:getModelId("farm:crate2"),
    furik = seexports.sModloader:getModelId("farm:furik"),
    bucket = seexports.sModloader:getModelId("farm:bucket"),
    kanna = seexports.sModloader:getModelId("farm:kanna")
  }
  for k in pairs(models) do
    models[k] = globalModels[k] or seexports.sModloader:getModelId("farm:" .. k)
  end
  for k, v in pairs(farmExteriors) do
    if models["exterior_" .. v.size] then
      setElementModel(farmExteriors[k].object, models["exterior_" .. v.size])
      setElementModel(farmExteriors[k].lod, models["exterior_" .. v.size .. "_LOD"])
      setLowLODElement(farmExteriors[k].object, farmExteriors[k].lod)
    end
  end
  for k in pairs(animalTypes) do
    animalTypes[k].skin = seexports.sModloader:getModelId("farm:" .. k)
  end
end
function getCurrentLandStateString(state, color, gr, rd)
  if state == "hole" then
    return (color and greenHex or "") .. "ültetésre kész"
  elseif state == "planted" then
    return (color and greenHex or "") .. "elültetve"
  elseif state and state:find("cultivated") then
    local dat = split(state, ":")
    return "megművelt"
  else
    return (color and redHex or "") .. "műveletlen"
  end
end
local backgroundColor = false
local titlebarColor = false
local btnColors = {}
local btnFont = false
local btnFontScale = false
local titlebarFont = false
local titlebarFontScale = false
function reMap(x, in_min, in_max, out_min, out_max)
  return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min
end
local playerTools = {}
local responsiveMultipler = 1
function resp(v)
  return v * responsiveMultipler
end
function respc(v)
  return math.ceil(v * responsiveMultipler)
end
local currentFarmInventory = {}
local markers = {}
local farmOverrides = {}
local crateElement = false
local textureRefreshTimer = false
local currentMarker = false
currentFarmType = 1
currentFarmId = false
isOwner = false
local currentStandingFarm = false
local interiorEnterGui = false
local farmRentWindow = false
addEvent("playFarmSound", true)
addEventHandler("playFarmSound", getRootElement(), function(sound, dim, time)
  local x, y, z = getElementPosition(source)
  s = playSound3D("files/sound/" .. sound .. ".mp3", x, y, z)
  attachElements(s, source)
  setElementDimension(s, dim)
  if time and isElement(s) then
    setTimer(function(sound)
      if isElement(sound) then
        destroyElement(sound)
      end
    end, time, 1, s)
  end
end)
addEvent("updateFarmDatas", true)
addEventHandler("updateFarmDatas", getRootElement(), function(id, dat, overrides)
  farmOverrides[id] = false
  local marker = farmDetails[id].markerElement
  farmDetails[id] = dat
  farmDetails[id].markerElement = marker
  if overrides then
    farmOverrides[id] = overrides
    for k2, v2 in pairs(farmOverrides[id]) do
      farmDetails[id][k2] = v2
    end
  end
  local v = farmDetails[id]
  local k = id
  if v.rentedBy then
    seexports.sMarkers:setCustomMarkerType(farmDetails[k].markerElement, "barn")
    seexports.sMarkers:setCustomMarkerColor(farmDetails[k].markerElement, "sightyellow")
    local dat = split(v.tableText, "/")
    if 2 <= #dat and utf8.len(dat[#dat]) > 0 then
      farmExteriors[v.exteriorId[1]].names[v.exteriorId[2]] = {
        convertTableText(dat[1]),
        convertTableText(dat[#dat])
      }
    else
      farmExteriors[v.exteriorId[1]].names[v.exteriorId[2]] = {
        convertTableText(dat[1])
      }
    end
    seexports.sMarkers:setCustomMarkerText(farmDetails[k].markerElement, {
      "Farm " .. k
    })
    if farmDetails[id].policeLock then
      local locker = farmDetails[k].policeLock and farmDetails[k].policeLockBy and farmDetails[k].policeLockGroup and farmDetails[k].policeLockBy .. " (" .. farmDetails[k].policeLockGroup .. ")" or ""
      seexports.sMarkers:setCustomMarkerPolice(farmDetails[k].markerElement, farmDetails[k].policeLock, locker)
    else
      seexports.sMarkers:setCustomMarkerPolice(farmDetails[k].markerElement, false, false)
    end
  elseif farmDetails[k].markerElement then
    seexports.sMarkers:setCustomMarkerType(farmDetails[k].markerElement, "barn_rent")
    seexports.sMarkers:setCustomMarkerColor(farmDetails[k].markerElement, "sightgreen")
    farmExteriors[v.exteriorId[1]].names[v.exteriorId[2]] = nil
    seexports.sMarkers:setCustomMarkerText(farmDetails[k].markerElement, {
      "Farm " .. k,
      "Kiadó!"
    }, {"#ffffff", "sightgreen"})
    seexports.sMarkers:setCustomMarkerPolice(farmDetails[k].markerElement, false, false)
  end
  refreshTablePoses(v.exteriorId[1])
  if currentStandingFarm == id or currentStandingFarm == "exit" and currentFarmId == id then
    processFarmBox(id)
  end
end)
addEvent("gotFarmDatas", true)
addEventHandler("gotFarmDatas", getRootElement(), function(datas)
  for k = 1, #markers do
    if markers[k] then
      seexports.sMarkers:deleteCustomMarker(markers[k])
    end
  end
  markers = {}
  farmOverrides = datas
  for k, v in pairs(farmOverrides) do
    for k2, v2 in pairs(v) do
      farmDetails[k][k2] = v2
    end
  end
  for k, v in pairs(farmDetails) do
    local x, y, z = unpack(v.pos)
    local el = false
    if v.rentedBy then
      el = seexports.sMarkers:createCustomMarker(x, y, z, 0, 0, "sightyellow", "barn")
      seexports.sMarkers:setCustomMarkerInterior(el, "farmEnter", k, 1)
      local dat = split(v.tableText, "/")
      if 2 <= #dat and 0 < utf8.len(dat[#dat]) then
        farmExteriors[v.exteriorId[1]].names[v.exteriorId[2]] = {
          convertTableText(dat[1]),
          convertTableText(dat[#dat])
        }
      else
        farmExteriors[v.exteriorId[1]].names[v.exteriorId[2]] = {
          convertTableText(dat[1])
        }
      end
      refreshTablePoses(v.exteriorId[1])
      seexports.sMarkers:setCustomMarkerText(el, {
        "Farm " .. k
      })
      if v.policeLock then
        local locker = v.policeLock and v.policeLockBy and v.policeLockGroup and v.policeLockBy .. " (" .. v.policeLockGroup .. ")" or ""
        seexports.sMarkers:setCustomMarkerPolice(el, v.policeLock, locker)
      end
    else
      el = seexports.sMarkers:createCustomMarker(x, y, z, 0, 0, "sightgreen", "barn_rent")
      seexports.sMarkers:setCustomMarkerInterior(el, "farmEnter", k, 1)
      seexports.sMarkers:setCustomMarkerText(el, {
        "Farm " .. k,
        "Kiadó!"
      }, {"#ffffff", "sightgreen"})
    end
    table.insert(markers, el)
    farmDetails[k].markerElement = el
  end
end)
function markersReady()
  triggerServerEvent("getFarmDatas", localPlayer)
end
function createRentPanelLoader()
  local titleBarHeight = seexports.sGui:getTitleBarHeight()
  local pw, ph = 300, titleBarHeight + 100
  if farmRentWindow then
    pw, ph = seexports.sGui:getGuiSize(farmRentWindow)
    seexports.sGui:deleteGuiElement(farmRentWindow)
  end
  farmRentWindow = seexports.sGui:createGuiElement("window", screenX / 2 - pw / 2, screenY / 2 - ph / 2, pw, ph)
  seexports.sGui:setWindowTitle(farmRentWindow, "16/BebasNeueRegular.otf", "Kérlek várj...")
  seexports.sGui:setWindowCloseButton(farmRentWindow, "closeFarmRentPanel")
  local icon = seexports.sGui:createGuiElement("image", pw / 2 - 24, titleBarHeight + (ph - titleBarHeight) / 2 - 24, 48, 48, farmRentWindow)
  seexports.sGui:setImageFile(icon, seexports.sGui:getFaIconFilename("circle-notch", 48))
  seexports.sGui:setImageSpinner(icon, true)
end
function openFarmRentPanel()
  if farmRentWindow then
    seexports.sGui:deleteGuiElement(farmRentWindow)
  end
  farmRentWindow = false
  local id = currentStandingFarm
  if id and farmDetails[id] then
    local pw = 300
    local titleBarHeight = seexports.sGui:getTitleBarHeight()
    if farmDetails[id].rentedBy then
      if farmDetails[id].rentedBy == getElementData(localPlayer, "char.ID") then
        local pw = 300
        local ph = titleBarHeight + 100
        farmRentWindow = seexports.sGui:createGuiElement("window", screenX / 2 - pw / 2, screenY / 2 - ph / 2, pw, ph)
        seexports.sGui:setWindowTitle(farmRentWindow, "16/BebasNeueRegular.otf", "Farm " .. id)
        local label = seexports.sGui:createGuiElement("label", 0, titleBarHeight, pw, ph - 8 - 32 - 8 - titleBarHeight, farmRentWindow)
        seexports.sGui:setLabelAlignment(label, "center", "center")
        seexports.sGui:setLabelText(label, "Biztosan lemondod a bérleted?")
        seexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
        local w = (pw - 24) / 2
        local btn = seexports.sGui:createGuiElement("button", 8, ph - 8 - 32, w, 32, farmRentWindow)
        seexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
        seexports.sGui:setGuiHover(btn, "gradient", {
          "sightgreen",
          "sightgreen-second"
        }, false, true)
        seexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
        seexports.sGui:setButtonText(btn, "Igen")
        seexports.sGui:setClickEvent(btn, "unrentFarmFinal")
        local btn = seexports.sGui:createGuiElement("button", pw - w - 8, ph - 8 - 32, w, 32, farmRentWindow)
        seexports.sGui:setGuiBackground(btn, "solid", "sightred")
        seexports.sGui:setGuiHover(btn, "gradient", {
          "sightred",
          "sightred-second"
        }, false, true)
        seexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
        seexports.sGui:setButtonText(btn, "Nem")
        seexports.sGui:setClickEvent(btn, "closeFarmRentPanel")
      end
    else
      local rentPrice = farmExteriors[farmDetails[id].exteriorId[1]].price
      local ppRentPrice = farmExteriors[farmDetails[id].exteriorId[1]].pp
      local rentDeposit = 2
      local ph = titleBarHeight + 96 + 24 + 8 + 76
      farmRentWindow = seexports.sGui:createGuiElement("window", screenX / 2 - pw / 2, screenY / 2 - ph / 2, pw, ph)
      seexports.sGui:setWindowTitle(farmRentWindow, "16/BebasNeueRegular.otf", "Farm " .. id)
      seexports.sGui:setWindowCloseButton(farmRentWindow, "closeFarmRentPanel")
      local y = titleBarHeight
      local label = seexports.sGui:createGuiElement("label", 0, y, pw, 32, farmRentWindow)
      seexports.sGui:setLabelAlignment(label, "center", "center")
      seexports.sGui:setLabelText(label, seexports.sGui:thousandsStepper(rentPrice) .. " $ / hét")
      seexports.sGui:setLabelFont(label, "15/BebasNeueBold.otf")
      seexports.sGui:setLabelColor(label, "sightgreen")
      y = y + 32
      local label = seexports.sGui:createGuiElement("label", 0, y, pw, 32, farmRentWindow)
      seexports.sGui:setLabelAlignment(label, "center", "center")
      seexports.sGui:setLabelText(label, " + " .. seexports.sGui:thousandsStepper(rentPrice * rentDeposit) .. " $ egyszeri kaució")
      seexports.sGui:setLabelFont(label, "13/BebasNeueBold.otf")
      seexports.sGui:setLabelColor(label, "sightgreen")
      y = y + 32
      local label = seexports.sGui:createGuiElement("label", 0, y, pw, 24, farmRentWindow)
      seexports.sGui:setLabelAlignment(label, "center", "center")
      seexports.sGui:setLabelText(label, "vagy")
      seexports.sGui:setLabelFont(label, "13/BebasNeueRegular.otf")
      y = y + 24
      local label = seexports.sGui:createGuiElement("label", 0, y, pw, 32, farmRentWindow)
      seexports.sGui:setLabelAlignment(label, "center", "center")
      seexports.sGui:setLabelText(label, seexports.sGui:thousandsStepper(ppRentPrice) .. " PP / hét")
      seexports.sGui:setLabelFont(label, "15/BebasNeueBold.otf")
      seexports.sGui:setLabelColor(label, "sightblue")
      y = y + 32 + 8
      local bw = (pw - 16) / 2 - 4
      local btn = seexports.sGui:createGuiElement("button", 8, y, bw, 30, farmRentWindow)
      seexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
      seexports.sGui:setGuiHover(btn, "gradient", {
        "sightgreen",
        "sightgreen-second"
      }, false, true)
      seexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
      seexports.sGui:setButtonText(btn, "Bérlés ($)")
      seexports.sGui:setClickEvent(btn, "rentFarmWithCash")
      local btn = seexports.sGui:createGuiElement("button", 8 + bw + 8, y, bw, 30, farmRentWindow)
      seexports.sGui:setGuiBackground(btn, "solid", "sightblue")
      seexports.sGui:setGuiHover(btn, "gradient", {
        "sightblue",
        "sightblue-second"
      }, false, true)
      seexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
      seexports.sGui:setButtonText(btn, "Bérlés (PP)")
      seexports.sGui:setClickEvent(btn, "rentFarmWithPP")
      y = y + 30 + 8
      local btn = seexports.sGui:createGuiElement("button", 8, y, pw - 16, 30, farmRentWindow)
      seexports.sGui:setGuiBackground(btn, "solid", "sightred")
      seexports.sGui:setGuiHover(btn, "gradient", {
        "sightred",
        "sightred-second"
      }, false, true)
      seexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
      seexports.sGui:setButtonText(btn, "Mégsem")
      seexports.sGui:setClickEvent(btn, "closeFarmRentPanel")
    end
  end
end
addEvent("openFarmRentPanel", true)
addEventHandler("openFarmRentPanel", getRootElement(), openFarmRentPanel)
function closeFarmRentPanel()
  if farmRentWindow then
    seexports.sGui:deleteGuiElement(farmRentWindow)
  end
  farmRentWindow = false
end
addEvent("closeFarmRentPanel", true)
addEventHandler("closeFarmRentPanel", getRootElement(), closeFarmRentPanel)
function createIntiBox(iconIn, text, text2, color, forRent, forRentPP, farmId, manage)
  local was = false
  if interiorEnterGui then
    was = true
    seexports.sGui:deleteGuiElement(interiorEnterGui)
  end
  interiorEnterGui = false
  if farmRentWindow then
    seexports.sGui:deleteGuiElement(farmRentWindow)
  end
  farmRentWindow = false
  if iconIn then
    interiorEnterGui = seexports.sGui:createGuiElement("rectangle", screenX / 2 - 150, screenY + 64, 300, 75)
    seexports.sGui:setGuiBackground(interiorEnterGui, "solid", "sightgrey2")
    local rect = seexports.sGui:createGuiElement("rectangle", 0, 0, 75, 75, interiorEnterGui)
    seexports.sGui:setGuiBackground(rect, "solid", "sightgrey1")
    local icon = seexports.sGui:createGuiElement("image", 6, 10, 63, 59, interiorEnterGui)
    seexports.sGui:setImageDDS(icon, seexports.sMarkers:getCustomMarkerTexture(iconIn))
    seexports.sGui:setImageColor(icon, color)
    local s = 5.079365079365079
    seexports.sGui:setImageUV(icon, 0, 0, 320, 320 - 4 * s)
    local label = seexports.sGui:createGuiElement("label", 87, 4, 0, 37.5, interiorEnterGui)
    seexports.sGui:setLabelAlignment(label, "left", "center")
    seexports.sGui:setLabelText(label, text)
    seexports.sGui:setLabelFont(label, "16/BebasNeueBold.otf")
    seexports.sGui:setLabelColor(label, color)
    local label2 = seexports.sGui:createGuiElement("label", 87, 33.5, 0, 37.5, interiorEnterGui)
    seexports.sGui:setLabelAlignment(label2, "left", "center")
    seexports.sGui:setLabelText(label2, text2)
    seexports.sGui:setLabelFont(label2, "16/BebasNeueRegular.otf")
    local w = math.max(seexports.sGui:getLabelTextWidth(label), seexports.sGui:getLabelTextWidth(label2))
    w = 87 + math.max(200, w) + 12
    local yMinus = false
    if forRent then
      local label = seexports.sGui:createGuiElement("label", w / 2, -72, 0, 32, interiorEnterGui)
      seexports.sGui:setLabelAlignment(label, "center", "center")
      seexports.sGui:setLabelText(label, "Kiadó!")
      seexports.sGui:setLabelColor(label, "sightgreen")
      seexports.sGui:setLabelFont(label, "14/BebasNeueBold.otf")
      local text = " Bérlés (" .. seexports.sGui:thousandsStepper(forRent) .. " $ / hét vagy " .. seexports.sGui:thousandsStepper(forRentPP) .. " PP / hét)"
      local bw = math.ceil((28 + seexports.sGui:getTextWidthFont(text, "12/BebasNeueRegular.otf") + 4) / 2) * 2
      local btn = seexports.sGui:createGuiElement("button", w / 2 - bw / 2, -36, bw, 28, interiorEnterGui)
      seexports.sGui:setGuiBackground(btn, "solid", "sightgrey1")
      seexports.sGui:setGuiHover(btn, "gradient", {
        "sightgreen",
        "sightgreen-second"
      }, false, true)
      seexports.sGui:setButtonFont(btn, "12/BebasNeueRegular.otf")
      seexports.sGui:setButtonText(btn, text)
      seexports.sGui:setButtonIcon(btn, seexports.sGui:getFaIconFilename("tags", 28))
      seexports.sGui:setClickEvent(btn, "openFarmRentPanel")
      yMinus = 72
    elseif farmId then
      local manW = 0
      local manW2 = 0
      if manage then
        manW = math.ceil((28 + seexports.sGui:getTextWidthFont(" Meghosszabbítás", "12/BebasNeueRegular.otf") + 4) / 2) * 2 + 8
        manW2 = math.ceil((28 + seexports.sGui:getTextWidthFont(" Lemondás", "12/BebasNeueRegular.otf") + 4) / 2) * 2 + 8
      end
      local x = w / 2 - (36 + manW + manW2) / 2
      local y = -36
      if manage then
        manW = manW - 8
        manW2 = manW2 - 8
        local btn = seexports.sGui:createGuiElement("button", x, -36, manW, 28, interiorEnterGui)
        seexports.sGui:setGuiBackground(btn, "solid", "sightgrey1")
        seexports.sGui:setGuiHover(btn, "gradient", {
          "sightgreen",
          "sightgreen-second"
        }, false, true)
        seexports.sGui:setButtonFont(btn, "12/BebasNeueRegular.otf")
        seexports.sGui:setButtonText(btn, " Meghosszabbítás")
        seexports.sGui:setButtonIcon(btn, seexports.sGui:getFaIconFilename("tags", 28))
        seexports.sGui:setClickEvent(btn, "extendFarmRental")
        x = x + manW + 8
        local btn = seexports.sGui:createGuiElement("button", x, -36, manW2, 28, interiorEnterGui)
        seexports.sGui:setGuiBackground(btn, "solid", "sightgrey1")
        seexports.sGui:setGuiHover(btn, "gradient", {
          "sightgreen",
          "sightgreen-second"
        }, false, true)
        seexports.sGui:setButtonFont(btn, "12/BebasNeueRegular.otf")
        seexports.sGui:setButtonText(btn, " Lemondás")
        seexports.sGui:setButtonIcon(btn, seexports.sGui:getFaIconFilename("times", 28))
        seexports.sGui:setClickEvent(btn, "openFarmRentPanel")
        x = x + manW2 + 8
      end
      if farmId then
        local rect = seexports.sGui:createGuiElement("rectangle", x, y, 28, 28, interiorEnterGui)
        seexports.sGui:setGuiBackground(rect, "solid", "sightgrey1")
        local icon = seexports.sGui:createGuiElement("image", 2, 2, 24, 24, rect)
        seexports.sGui:setImageFile(icon, seexports.sGui:getFaIconFilename("key", 24))
        seexports.sGui:setGuiBoundingBox(icon, rect)
        seexports.sGui:setGuiHoverable(icon, true)
        seexports.sGui:setGuiHover(icon, "solid", "sightyellow")
        seexports.sGui:setClickEvent(icon, "lockUnlockFarm")
        if farmDetails[farmId].locked then
          seexports.sGui:guiSetTooltip(icon, "Farm kinyitása")
        else
          seexports.sGui:guiSetTooltip(icon, "Farm bezárása")
        end
      end
      yMinus = 36
    end
    yMinus = yMinus or 32
    local label = seexports.sGui:createGuiElement("label", w / 2, 75, 0, 32, interiorEnterGui)
    seexports.sGui:setLabelAlignment(label, "center", "center")
    seexports.sGui:setLabelText(label, "Nyomj [E] gombot a " .. (forRent and "bérléshez" or "belépéshez") .. ".")
    seexports.sGui:setLabelFont(label, "14/BebasNeueBold.otf")
    seexports.sGui:setGuiSize(interiorEnterGui, w, 75)
    if was then
      seexports.sGui:setGuiPosition(interiorEnterGui, screenX / 2 - w / 2, screenY - 128 - 64 - yMinus)
    else
      seexports.sGui:setGuiPosition(interiorEnterGui, screenX / 2 - w / 2, screenY + yMinus)
      seexports.sGui:setGuiPositionAnimated(interiorEnterGui, screenX / 2 - w / 2, screenY - 128 - 64 - yMinus, 1000, false, "OutBounce")
    end
  end
end
function processFarmBox(id)
  if farmDetails[id] then
    if currentStandingFarm == "exit" then
      createIntiBox("barn_rent", "Farm " .. id, table.concat(split(farmDetails[id].tableText, "/"), " "), "sightyellow", false, false, false, false)
    elseif farmDetails[id].rentedBy then
      createIntiBox("barn_rent", "Farm " .. id, table.concat(split(farmDetails[id].tableText, "/"), " "), "sightyellow", false, false, id, farmDetails[id].rentedBy == getElementData(localPlayer, "char.ID"))
    else
      createIntiBox("barn_rent", "Farm " .. id, "Kiadó!", "sightgreen", farmExteriors[farmDetails[id].exteriorId[1]].price, farmExteriors[farmDetails[id].exteriorId[1]].pp)
    end
  end
end
addEvent("changeEnteredCustomMarker", false)
addEventHandler("changeEnteredCustomMarker", getRootElement(), function(theType, id)
  if theType == "farmExit" and currentFarmId then
    currentStandingFarm = "exit"
    processFarmBox(currentFarmId)
  elseif theType == "farmEnter" and not currentFarmId then
    currentStandingFarm = id
    if currentStandingFarm == farmMarkedOnMap then
      if isElement(farmMarkerOnMap) then
        destroyElement(farmMarkerOnMap)
      end
      farmMarkerOnMap = nil
      farmMarkedOnMap = false
    end
    processFarmBox(id)
    if not farmDetails[id].rentedBy then
      if not getPedOccupiedVehicle(localPlayer) then
        outputChatBox("[color=sightgreen][SightMTA - Farm]: #ffffffEz a farm kiadó!", 255, 255, 255, true)
        outputChatBox(" #ffffff - Heti bérleti díj: [color=sightgreen]" .. farmExteriors[farmDetails[id].exteriorId[1]].price .. " $#ffffff vagy [color=sightblue]" .. farmExteriors[farmDetails[id].exteriorId[1]].pp .. " PP", 255, 255, 255, true)
        outputChatBox(" #ffffff - Kaució: [color=sightgreen]" .. farmExteriors[farmDetails[id].exteriorId[1]].price * 2 .. " $#ffffff vagy [color=sightblue]0 PP", 255, 255, 255, true)
        outputChatBox(" #ffffff - Bérléshez használd az [color=sightgreen][E]#ffffff gombot.", 255, 255, 255, true)
      end
    end
  else
    currentStandingFarm = false
    createIntiBox()
  end
end)
function policeLockFarm(cmd, ...)
  if currentStandingFarm and farmDetails[currentStandingFarm] and (seexports.sGroups:getPlayerPermission("interiorLock") or seexports.sPermission:hasPermission(localPlayer, "forceUnlockInterior")) then
    if farmDetails[currentStandingFarm].policeLock then
      triggerServerEvent("unlockPoliceFarm", localPlayer, currentStandingFarm)
    else
      local reason = table.concat({
        ...
      }, " ")
      if reason and utf8.len(reason) > 0 then
        if utf8.len(reason) <= 24 then
          triggerServerEvent("lockPoliceFarm", localPlayer, currentStandingFarm, reason)
        else
          seexports.sGui:showInfobox("e", "Az indok maximum 24 karakter lehet!")
        end
      else
        outputChatBox("[color=sightblue][SightMTA - Használat]: #ffffff/" .. cmd .. " [Indok]", 255, 255, 255, true)
      end
    end
  end
end
addCommandHandler("policelock", policeLockFarm)
addCommandHandler("navlock", policeLockFarm)
addCommandHandler("nnilock", policeLockFarm)
addCommandHandler("okflock", policeLockFarm)
local lastTryExtend = 0
addEvent("extendFarmRental", false)
addEventHandler("extendFarmRental", getRootElement(), function()
  if currentStandingFarm and getTickCount() - lastTryExtend > 1000 and farmDetails[currentStandingFarm].rentedBy == getElementData(localPlayer, "char.ID") then
    triggerServerEvent("renewFarm", localPlayer, currentStandingFarm)
    lastTryExtend = getTickCount()
  end
end)
addEvent("rentFarmWithCash", false)
addEventHandler("rentFarmWithCash", getRootElement(), function()
  if currentStandingFarm and getTickCount() - lastTryExtend > 1000 then
    if not farmDetails[currentStandingFarm].rentedBy then
      createRentPanelLoader()
      triggerServerEvent("rentFarm", localPlayer, currentStandingFarm, false)
      lastTryExtend = getTickCount()
    else
      seexports.sGui:showInfobox("e", "Ez a farm nem kiadó!")
    end
  end
end)
addEvent("rentFarmWithPP", false)
addEventHandler("rentFarmWithPP", getRootElement(), function()
  if currentStandingFarm and getTickCount() - lastTryExtend > 1000 then
    if not farmDetails[currentStandingFarm].rentedBy then
      createRentPanelLoader()
      triggerServerEvent("rentFarm", localPlayer, currentStandingFarm, true)
      lastTryExtend = getTickCount()
    else
      seexports.sGui:showInfobox("e", "Ez a farm nem kiadó!")
    end
  end
end)
addEvent("unrentFarmFinal", false)
addEventHandler("unrentFarmFinal", getRootElement(), function()
  if currentStandingFarm then
    if farmDetails[currentStandingFarm].rentedBy == getElementData(localPlayer, "char.ID") then
      triggerServerEvent("unRentFarm", localPlayer, currentStandingFarm)
      closeFarmRentPanel()
    else
      seexports.sGui:showInfobox("e", "Ez a farmot nem te bérled!")
    end
  else
    seexports.sGui:showInfobox("e", "Nem vagy farmnál!")
  end
end)
function createCurrentMarker()
  currentMarker = seexports.sMarkers:createCustomMarker(0, 0, 0, 123, 123, "sightyellow", "barn")
  seexports.sMarkers:setCustomMarkerInterior(currentMarker, "farmExit", 0, 1)
end
addEventHandler("onClientResourceStop", getResourceRootElement(), function()
  for k = 1, #markers do
    if markers[k] then
      seexports.sMarkers:deleteCustomMarker(markers[k])
    end
    markers[k] = nil
  end
  if currentMarker then
    seexports.sMarkers:deleteCustomMarker(currentMarker)
  end
  currentMarker = false
end)
local Roboto = false
currentSize = false
farmInteriorX, farmInteriorY, farmInteriorZ = false
farmInteriorRot = false
lx = false
ly = false
lz = false
interiorObject = false
farmRT = false
cultivatedRT = false
landData = {}
local rottenShaders = {}
local rottenShaderSource = [[
	#include "files/mta-helper.fx"


	struct VSInput
	{
		float3 Position : POSITION0;
		float3 Normal : NORMAL0;
		float4 Diffuse : COLOR0;
		float2 TexCoord : TEXCOORD0;
	};

	struct PSInput
	{
		float4 Position : POSITION0;
		float4 Diffuse : COLOR0;
		float2 TexCoord : TEXCOORD0;

		float4 Lighting: TEXCOORD6;
	};

	float progress = 0;

	PSInput VertexShaderFunction(VSInput VS)
	{
		PSInput PS = (PSInput)0;

		// Calculate screen pos of vertex
		PS.Position = MTACalcScreenPosition ( VS.Position );

		// Pass through tex coords
		PS.TexCoord = VS.TexCoord;

		PS.Diffuse = MTACalcGTABuildingDiffuse( VS.Diffuse );

		PS.Diffuse.r *= 1-(1-0.3)*progress;
		PS.Diffuse.g *= 1-(1-0.1)*progress;
		PS.Diffuse.b *= 1-(1-0.05)*progress;

		return PS;
	}

	technique tec0
	{
		pass P0
		{
			VertexShader = compile vs_2_0 VertexShaderFunction();
		}
	}
]]
function initRottenShader(x, y, val)
  if val <= 0 then
    if isElement(rottenShaders[x][y]) then
      destroyElement(rottenShaders[x][y])
    end
    rottenShaders[x][y] = nil
    rottenShaders[x][y] = nil
  else
    if not rottenShaders[x][y] then
      rottenShaders[x][y] = dxCreateShader(rottenShaderSource)
    end
    dxSetShaderValue(rottenShaders[x][y], "progress", val)
    for k = 1, #landData[x][y].objects do
      engineApplyShaderToWorldTexture(rottenShaders[x][y], "*", landData[x][y].objects[k])
    end
  end
end
function getLandTexture(x, y, wet)
  return getLandTextureFromState(landData[x][y].landState, wet)
end
function getLandTextureFromState(state, wet)
  if state then
    if state:find("cultivated") then
      state = "cultivated"
    end
    return "files/textures/land_" .. state .. (wet and "_wet" or "") .. ".dds"
  end
  return "files/textures/land" .. (wet and "_wet" or "") .. ".dds"
end
landIterpolations = {}
function isInInterpolation(x, y, theType)
  if not landIterpolations[x][y] then
    return false
  end
  return landIterpolations[x][y] and landIterpolations[x][y].theType == theType
end
farmHover = false
function drawFarmRT(redraw)
  if currentFarmType == 2 then
    drawFarmAnimalRT(redraw)
    return
  end
  if redraw then
    dxSetRenderTarget(cultivatedRT)
    for k = 0, 9 do
      dxDrawImage(k * textureSize, 0, textureSize, textureSize, dynamicImage(getLandTextureFromState(false, false)))
      dxDrawImageSection(k * textureSize, textureSize, textureSize, textureSize, 64, 64, 128, 128, dynamicImage(getLandTextureFromState(false, true)))
      dxDrawImage(k * textureSize, 0, textureSize, textureSize, dynamicImage(getLandTextureFromState("cultivated", false)), 0, 0, 0, tocolor(255, 255, 255, 25.5 * k))
      dxDrawImageSection(k * textureSize, textureSize, textureSize, textureSize, 64, 64, 128, 128, dynamicImage(getLandTextureFromState("cultivated", true)), 0, 0, 0, tocolor(255, 255, 255, 25.5 * k))
    end
  end
  dxSetRenderTarget(farmRT)
  for x = 1, farmSizeDetails[currentSize].size[1] do
    for y = 1, farmSizeDetails[currentSize].size[2] do
      if not isInInterpolation(x, y, "land") then
        if landData[x][y].landState and landData[x][y].landState ~= "cultivated:10" and landData[x][y].landState:find("cultivated") then
          local dat = tonumber(split(landData[x][y].landState, ":")[2]) or 10
          dxDrawImageSection((x - 1) * textureSize, (y - 1) * textureSize, textureSize, textureSize, textureSize * dat, 0, textureSize, textureSize, cultivatedRT)
        else
          dxDrawImage((x - 1) * textureSize, (y - 1) * textureSize, textureSize, textureSize, dynamicImage(getLandTexture(x, y)))
        end
      else
        local p = landIterpolations[x][y].progress
        if landIterpolations[x][y].from and landIterpolations[x][y].from ~= "cultivated:10" and landIterpolations[x][y].from:find("cultivated") then
          local dat = tonumber(split(landIterpolations[x][y].from, ":")[2]) or 10
          dxDrawImageSection((x - 1) * textureSize, (y - 1) * textureSize, textureSize, textureSize, textureSize * dat, 0, textureSize, textureSize, cultivatedRT)
        else
          dxDrawImage((x - 1) * textureSize, (y - 1) * textureSize, textureSize, textureSize, dynamicImage(getLandTextureFromState(landIterpolations[x][y].from, false)))
        end
        if landIterpolations[x][y].to and landIterpolations[x][y].to ~= "cultivated:10" and landIterpolations[x][y].to:find("cultivated") then
          local dat = tonumber(split(landIterpolations[x][y].to, ":")[2]) or 10
          dxDrawImageSection((x - 1) * textureSize, (y - 1) * textureSize, textureSize, textureSize, textureSize * dat, 0, textureSize, textureSize, cultivatedRT, 0, 0, 0, tocolor(255, 255, 255, 255 * p))
        else
          dxDrawImage((x - 1) * textureSize, (y - 1) * textureSize, textureSize, textureSize, dynamicImage(getLandTextureFromState(landIterpolations[x][y].to, false)), 0, 0, 0, tocolor(255, 255, 255, 255 * p))
        end
      end
    end
  end
  for x = 1, farmSizeDetails[currentSize].size[1] do
    for y = 1, farmSizeDetails[currentSize].size[2] do
      if isInInterpolation(x, y, "land") then
        local p = landIterpolations[x][y].progress
        if 0 < landData[x][y].lastWatering then
          landData[x][y].wetness = calculateWetness(landData[x][y])
        end
        seelangStaticImageUsed[0] = true
        if seelangStaticImageToc[0] then
          processSeelangStaticImage[0]()
        end
        dxDrawImage((x - 1) * textureSize - textureSize / 2, (y - 1) * textureSize - textureSize / 2, textureSize * 2, textureSize * 2, seelangStaticImage[0], 0, 0, 0, tocolor(255, 255, 255, landData[x][y].wetness))
        local a1 = landData[x][y].wetness - landData[x][y].wetness * math.pow(p, map(landData[x][y].wetness, 0, 255, 1.9, 2.5))
        local a2 = interpolateBetween(0, 0, 0, landData[x][y].wetness, 0, 0, p, "OutQuad")
        if landIterpolations[x][y].from and landIterpolations[x][y].from ~= "cultivated:10" and landIterpolations[x][y].from:find("cultivated") then
          local dat = tonumber(split(landIterpolations[x][y].from, ":")[2]) or 10
          dxDrawImageSection((x - 1) * textureSize, (y - 1) * textureSize, textureSize, textureSize, textureSize * dat, textureSize, textureSize, textureSize, cultivatedRT, 0, 0, 0, tocolor(255, 255, 255, a1))
        else
          dxDrawImageSection((x - 1) * textureSize, (y - 1) * textureSize, textureSize, textureSize, 64, 64, 128, 128, dynamicImage(getLandTextureFromState(landIterpolations[x][y].from, true)), 0, 0, 0, tocolor(255, 255, 255, a1))
        end
        if landIterpolations[x][y].to and landIterpolations[x][y].to ~= "cultivated:10" and landIterpolations[x][y].to:find("cultivated") then
          local dat = tonumber(split(landIterpolations[x][y].to, ":")[2]) or 10
          dxDrawImageSection((x - 1) * textureSize, (y - 1) * textureSize, textureSize, textureSize, textureSize * dat, textureSize, textureSize, textureSize, cultivatedRT, 0, 0, 0, tocolor(255, 255, 255, a2))
        else
          dxDrawImageSection((x - 1) * textureSize, (y - 1) * textureSize, textureSize, textureSize, 64, 64, 128, 128, dynamicImage(getLandTextureFromState(landIterpolations[x][y].to, true)), 0, 0, 0, tocolor(255, 255, 255, a2))
        end
      elseif not isInInterpolation(x, y, "wetness") then
        if 0 < landData[x][y].lastWatering then
          landData[x][y].wetness = calculateWetness(landData[x][y])
        end
        if 0 < landData[x][y].wetness then
          if landData[x][y].landState and landData[x][y].landState ~= "cultivated:10" and landData[x][y].landState:find("cultivated") then
            local dat = tonumber(split(landData[x][y].landState, ":")[2]) or 10
            seelangStaticImageUsed[0] = true
            if seelangStaticImageToc[0] then
              processSeelangStaticImage[0]()
            end
            dxDrawImage((x - 1) * textureSize - textureSize / 2, (y - 1) * textureSize - textureSize / 2, textureSize * 2, textureSize * 2, seelangStaticImage[0], 0, 0, 0, tocolor(255, 255, 255, landData[x][y].wetness))
            dxDrawImageSection((x - 1) * textureSize, (y - 1) * textureSize, textureSize, textureSize, textureSize * dat, textureSize, textureSize, textureSize, cultivatedRT, 0, 0, 0, tocolor(255, 255, 255, landData[x][y].wetness))
          else
            dxDrawImage((x - 1) * textureSize - textureSize / 2, (y - 1) * textureSize - textureSize / 2, textureSize * 2, textureSize * 2, dynamicImage(getLandTexture(x, y, true)), 0, 0, 0, tocolor(255, 255, 255, landData[x][y].wetness))
          end
        end
      else
        local a = interpolateBetween(landIterpolations[x][y].from, 0, 0, landIterpolations[x][y].to, 0, 0, landIterpolations[x][y].progress, "Linear")
        if landData[x][y].landState and landData[x][y].landState ~= "cultivated:10" and landData[x][y].landState:find("cultivated") then
          local dat = tonumber(split(landData[x][y].landState, ":")[2]) or 10
          seelangStaticImageUsed[0] = true
          if seelangStaticImageToc[0] then
            processSeelangStaticImage[0]()
          end
          dxDrawImage((x - 1) * textureSize - textureSize / 2, (y - 1) * textureSize - textureSize / 2, textureSize * 2, textureSize * 2, seelangStaticImage[0], 0, 0, 0, tocolor(255, 255, 255, a))
          dxDrawImageSection((x - 1) * textureSize, (y - 1) * textureSize, textureSize, textureSize, textureSize * dat, textureSize, textureSize, textureSize, cultivatedRT, 0, 0, 0, tocolor(255, 255, 255, a))
        else
          dxDrawImage((x - 1) * textureSize - textureSize / 2, (y - 1) * textureSize - textureSize / 2, textureSize * 2, textureSize * 2, dynamicImage(getLandTexture(x, y, true)), 0, 0, 0, tocolor(255, 255, 255, a))
        end
      end
    end
  end
  if farmHover then
    local x = farmHover[1]
    local y = farmHover[2]
    dxDrawLine((x - 1) * textureSize, (y - 1) * textureSize, (x - 1) * textureSize, y * textureSize, tocolor(green[1], green[2], green[3]), 2)
    dxDrawLine((x - 1) * textureSize, y * textureSize, x * textureSize, y * textureSize, tocolor(green[1], green[2], green[3]), 2)
    dxDrawLine(x * textureSize, y * textureSize, x * textureSize, (y - 1) * textureSize, tocolor(green[1], green[2], green[3]), 2)
    dxDrawLine(x * textureSize, (y - 1) * textureSize, (x - 1) * textureSize, (y - 1) * textureSize, tocolor(green[1], green[2], green[3]), 2)
  end
  local x = math.ceil(farmSizeDetails[currentSize].size[1] / 2)
  for y = 1, farmSizeDetails[currentSize].size[2] do
    seelangStaticImageUsed[1] = true
    if seelangStaticImageToc[1] then
      processSeelangStaticImage[1]()
    end
    dxDrawImage((x - 1) * textureSize, (y - 1) * textureSize, textureSize, textureSize, seelangStaticImage[1])
  end
  dxSetRenderTarget()
end
function initFarmRT()
  farmRT = dxCreateRenderTarget(farmSizeDetails[currentSize].size[1] * textureSize, farmSizeDetails[currentSize].size[2] * textureSize)
  cultivatedRT = dxCreateRenderTarget(10 * textureSize, 2 * textureSize)
  drawFarmRT(true)
end
currentPlayerTaskInProgress = false
local availableSeeds = {}
local selectPlantType = false
local currentSelectedPlantType = false
local forkObject = false
local hoeObject = false
local miniHoeObject = false
local currentFork = 0
local currentHoePlayer = 0
local currentMiniHoePlayer = 0
currentForkContentSize = {}
currentForkContent = {}
currentForkObject = {}
local currentHoeObject = {}
local currentMiniHoeObject = {}
oldWs = {}
addEvent("syncForkState", true)
addEventHandler("syncForkState", getRootElement(), function(farmId, state, dat, loadedState, downAnim, sync)
  if currentFarmId ~= farmId then
    if not state then
      engineRestoreAnimation(source, "ped", "WALK_armed")
      engineRestoreAnimation(source, "ped", "walk_start_armed")
      engineRestoreAnimation(source, "ped", "IDLE_armed")
      if oldWs[source] then
        setPedWalkingStyle(source, oldWs[source])
      end
      oldWs[source] = false
    end
  else
    currentFork = dat
    if state then
      engineReplaceAnimation(source, "ped", "WALK_armed", "vv_seta", "walk_armed")
      engineReplaceAnimation(source, "ped", "walk_start_armed", "vv_start", "walk_start_armed")
      engineReplaceAnimation(source, "ped", "IDLE_armed", "vv_idle", "idle_armed")
      if not oldWs[source] then
        oldWs[source] = getPedWalkingStyle(source)
      end
      setPedWalkingStyle(source, 60)
    else
      engineRestoreAnimation(source, "ped", "WALK_armed")
      engineRestoreAnimation(source, "ped", "walk_start_armed")
      engineRestoreAnimation(source, "ped", "IDLE_armed")
      if oldWs[source] then
        setPedWalkingStyle(source, oldWs[source])
      end
      oldWs[source] = false
    end
    if state then
      playerTools[source] = "fork"
      if not isElement(currentForkObject[source]) then
        currentForkObject[source] = createObject(models.pitchfork, 0, 0, 0)
        setElementDimension(currentForkObject[source], currentFarmId)
      end
      if downAnim then
        setPedAnimation(source, "vv_le", "M_smk_in", -1, false, true, false, false)
      end
      if loadedState and loadedState[2] then
        if not isElement(currentForkContent[source]) or getElementModel(currentForkContent[source]) ~= models["pitchfork_loaded" .. loadedState[1]] then
          if not sync then
            setPedAnimation(source, "vv_fel", "M_smk_in", -1, false, true, false, false)
          end
          if isElement(currentForkContent[source]) then
            destroyElement(currentForkContent[source])
          end
          currentForkContent[source] = nil
          currentForkContent[source] = createObject(models["pitchfork_loaded" .. loadedState[1]], 0, 0, 0)
          setElementDimension(currentForkContent[source], currentFarmId)
          attachElements(currentForkContent[source], currentForkObject[source], 0.002249, -0.072032, -1.13328, -10)
          setElementCollisionsEnabled(currentForkContent[source], false)
        end
        local was = 0
        if currentForkContentSize[source] then
          was = currentForkContentSize[source][2]
        end
        currentForkContentSize[source] = {
          was,
          loadedState[2],
          getTickCount(),
          3000,
          loadedState[1]
        }
      end
      processBoneAttach(currentForkObject[source], source, "pitchfork")
    else
      if isElement(currentForkObject[source]) then
        destroyElement(currentForkObject[source])
      end
      currentForkObject[source] = nil
      currentForkObject[source] = false
      if isElement(currentForkContent[source]) then
        destroyElement(currentForkContent[source])
      end
      currentForkContent[source] = nil
      currentForkContent[source] = nil
      playerTools[source] = false
      currentForkContentSize[source] = nil
    end
  end
end)
addEventHandler("onClientRender", getRootElement(), function()
  for k, v in pairs(currentForkContent) do
    if currentForkContentSize[k] then
      local progress = (getTickCount() - currentForkContentSize[k][3]) / currentForkContentSize[k][4]
      if progress < 1 then
        local s = currentForkContentSize[k][1] + (currentForkContentSize[k][2] - currentForkContentSize[k][1]) * progress
        if s < 0.1 then
          setObjectScale(v, s * 10, s, s * 10)
        else
          setObjectScale(v, 1, s, 1)
        end
      else
        local s = currentForkContentSize[k][2]
        if s <= 0 then
          if isElement(currentForkContent[k]) then
            destroyElement(currentForkContent[k])
          end
          currentForkContent[k] = nil
          currentForkContent[k] = nil
          currentForkContentSize[k] = nil
        elseif s < 0.1 then
          setObjectScale(v, s * 10, s, s * 10)
        else
          setObjectScale(v, 1, s, 1)
        end
      end
    end
  end
end)
addEvent("syncHoeState", true)
addEventHandler("syncHoeState", getRootElement(), function(farmId, state, dat)
  if currentFarmId == farmId then
    currentHoePlayer = dat
    if isElement(currentHoeObject[source]) then
      destroyElement(currentHoeObject[source])
    end
    currentHoeObject[source] = nil
    currentHoeObject[source] = false
    playerTools[source] = false
    if state then
      playerTools[source] = "hoe"
      currentHoeObject[source] = createObject(models.hoe, 0, 0, 0)
      setElementDimension(currentHoeObject[source], currentFarmId)
      processBoneAttach(currentHoeObject[source], source, "hoe")
    end
  end
end)
addEvent("syncMiniHoeState", true)
addEventHandler("syncMiniHoeState", getRootElement(), function(farmId, state, dat)
  if currentFarmId == farmId then
    currentMiniHoePlayer = dat
    if isElement(currentMiniHoeObject[source]) then
      destroyElement(currentMiniHoeObject[source])
    end
    currentMiniHoeObject[source] = nil
    currentMiniHoeObject[source] = false
    playerTools[source] = false
    if state then
      playerTools[source] = "minihoe"
      currentMiniHoeObject[source] = createObject(models.minihoe, 0, 0, 0)
      setElementDimension(currentMiniHoeObject[source], currentFarmId)
      processBoneAttach(currentMiniHoeObject[source], source, "minihoe")
    end
  end
end)
local activeButton = false
local tableRenamingText = false
local tableRenaming = false
local letters = {
  A = 1,
  B = 2,
  C = 3,
  D = 4,
  E = 5,
  F = 6,
  G = 7,
  H = 8,
  I = 9,
  J = 10,
  K = 11,
  L = 12,
  M = 13,
  N = 14,
  O = 15,
  P = 16,
  Q = 17,
  R = 18,
  S = 19,
  T = 20,
  U = 21,
  V = 22,
  W = 23,
  X = 24,
  Y = 25,
  Z = 26,
  ["Ó"] = 27,
  ["!"] = 28,
  ["Ö"] = 29,
  ["Ü"] = 30,
  ["Ó"] = 31,
  ["Ő"] = 32,
  ["Ú"] = 33,
  ["É"] = 34,
  ["Á"] = 35,
  ["Ű"] = 36,
  ["-"] = 37,
  ["0"] = 38,
  ["1"] = 39,
  ["2"] = 40,
  ["3"] = 41,
  ["4"] = 42,
  ["5"] = 43,
  ["6"] = 44,
  ["7"] = 45,
  ["8"] = 46,
  ["9"] = 47
}
local lettersNum = 47
local letterRT = dxCreateRenderTarget(letterYSize * lettersNum, letterXSize, true)
function drawLetters()
  dxSetRenderTarget(letterRT, true)
  local lts = 1.5
  local font = dxCreateFont("files/impact.ttf", lts * 14 * sizeMultipler, false, "antialiased")
  for k, v in pairs(letters) do
    dxDrawText(k, (v - 1) * letterYSize, 0, v * letterYSize, letterXSize, tocolor(255, 255, 255, 255), 1 / lts, font, "center", "center", false, false, false, false, false, 270)
  end
  if isElement(font) then
    destroyElement(font)
  end
  font = nil
  dxSetRenderTarget()
end
drawLetters()
function doneTableRenaming()
  removeEventHandler("onClientKey", getRootElement(), onClientKey)
  removeEventHandler("onClientCharacter", getRootElement(), onClientCharacter)
  triggerServerEvent("editTableText", localPlayer, table.concat(tableRenamingText, "/"))
  tableRenaming = false
  tableRenamingText = false
end
function refreshTable()
  local dat = tableRenamingText
  if 2 <= #dat and utf8.len(dat[#dat]) > 0 then
    farmExteriors[farmDetails[currentFarmId].exteriorId[1]].names[farmDetails[currentFarmId].exteriorId[2]] = {
      convertTableText(dat[1]),
      convertTableText(dat[#dat])
    }
  else
    farmExteriors[farmDetails[currentFarmId].exteriorId[1]].names[farmDetails[currentFarmId].exteriorId[2]] = {
      convertTableText(dat[1])
    }
  end
end
local addMemberText = ""
function onClientCharacterMember(character)
  if utf8.len(addMemberText) < 30 then
    addMemberText = addMemberText .. character
  end
end
function onClientKeyMember(button, press)
  if press and button == "backspace" then
    addMemberText = utf8.sub(addMemberText, 1, utf8.len(addMemberText) - 1)
  end
  cancelEvent()
end
function onClientCharacter(character)
  character = utf8.upper(character)
  if letters[character] or character == " " then
    if not tableRenamingText[tableRenaming] then
      tableRenamingText[tableRenaming] = ""
    end
    if utf8.len(tableRenamingText[tableRenaming]) < 11 then
      tableRenamingText[tableRenaming] = tableRenamingText[tableRenaming] .. character
      refreshTable()
    end
  end
end
function onClientKey(button, press)
  if press then
    if button == "backspace" then
      tableRenamingText[tableRenaming] = utf8.sub(tableRenamingText[tableRenaming], 1, utf8.len(tableRenamingText[tableRenaming]) - 1)
      refreshTable()
    end
    if button == "enter" then
      tableRenaming = tableRenaming + 1
      if 2 < tableRenaming then
        doneTableRenaming()
      end
    end
    if button == "arrow_u" or button == "arrow_d" then
      tableRenaming = tableRenaming + 1
      if 2 < tableRenaming then
        tableRenaming = 1
      end
    end
  end
  cancelEvent()
end
local permissions = {}
local permissionPanel = false
local addMemberState = false
local lastGet = 0
local ppboostPrompt = false
function onClientClick(button, state, absoluteX, absoluteY, worldX, worldY, worldZ, clickedElement)
  if clickedElement and getElementModel(clickedElement) == models.egg_crate and not currentPlayerTaskInProgress and getTickCount() - lastGet > 500 then
    local foundCrate = false
    for i = 1, #crateObjects do
      if clickedElement == crateObjects[i] then
        foundCrate = i
      end
    end
    if foundCrate then
      local x, y, z = getElementPosition(clickedElement)
      local px, py, pz = getElementPosition(localPlayer)
      local dist = getDistanceBetweenPoints3D(x, y, z, px, py, pz)
      if dist < 2 and #eggObjects[foundCrate] > 0 then
        lastGet = getTickCount()
        triggerServerEvent("getEggsFromCrate", localPlayer, currentFarmId, foundCrate)
        currentPlayerTaskInProgress = true
      end
    end
  elseif clickedElement == otherDrinker and getTickCount() - lastGet > 500 then
    local currentBucket = getElementData(localPlayer, "currentBucket")
    if state == "down" and currentBucket and currentBucket[2] and currentBucket[2][1] == "water" then
      local x, y = getElementPosition(clickedElement)
      local x2, y2 = getElementPosition(localPlayer)
      local dist = getDistanceBetweenPoints2D(x, y, x2, y2)
      if dist < 2.5 then
        lastGet = getTickCount()
        triggerServerEvent("putWaterInOther", localPlayer)
      end
    end
  elseif clickedElement == milkCrate and getTickCount() - lastGet > 500 then
    local currentBucket = getElementData(localPlayer, "currentBucket")
    if state == "down" and currentBucket and currentBucket[2] and currentBucket[2][1] == "milk" and currentBucket[2][2] > 0 then
      local x, y = getElementPosition(clickedElement)
      local x2, y2 = getElementPosition(localPlayer)
      local dist = getDistanceBetweenPoints2D(x, y, x2, y2)
      if dist < 2.5 then
        lastGet = getTickCount()
        triggerServerEvent("getMilkFromBucket", localPlayer, currentFarmId)
      end
    end
  elseif clickedElement == chickenDrinker and getTickCount() - lastGet > 500 then
    local currentBucket = getElementData(localPlayer, "currentBucket")
    if state == "down" and currentBucket and currentBucket[2] and currentBucket[2][1] == "water" then
      local x, y = getElementPosition(clickedElement)
      local x2, y2 = getElementPosition(localPlayer)
      local dist = getDistanceBetweenPoints2D(x, y, x2, y2)
      if dist < 2.5 then
        lastGet = getTickCount()
        triggerServerEvent("putWaterInChicken", localPlayer)
      end
    end
  elseif clickedElement == otherFeeder and getTickCount() - lastGet > 500 then
    local currentBucket = getElementData(localPlayer, "currentBucket")
    if state == "down" and currentBucket and currentBucket[2] and currentBucket[2][1] == "pellet" then
      local x, y = getElementPosition(clickedElement)
      local x2, y2 = getElementPosition(localPlayer)
      local dist = getDistanceBetweenPoints2D(x, y, x2, y2)
      if dist < 2.5 then
        lastGet = getTickCount()
        triggerServerEvent("putPelletInFeeder", localPlayer)
      end
    end
  elseif clickedElement and getElementModel(clickedElement) == models.feed_bag and getTickCount() - lastGet > 500 then
    local currentBucket = getElementData(localPlayer, "currentBucket")
    if state == "down" and currentBucket and (not currentBucket[2] or currentBucket[2][1] == "pellet") then
      local x, y = getElementPosition(clickedElement)
      local x2, y2 = getElementPosition(localPlayer)
      local dist = getDistanceBetweenPoints2D(x, y, x2, y2)
      if dist < 2 then
        lastGet = getTickCount()
        triggerServerEvent("getPelletToBucket", localPlayer)
      end
    end
  elseif clickedElement == chickenFeeder and getTickCount() - lastGet > 500 then
    local currentBucket = getElementData(localPlayer, "currentBucket")
    if state == "down" and currentBucket and currentBucket[2] and currentBucket[2][1] == "csirketap" then
      local x, y = getElementPosition(clickedElement)
      local x2, y2 = getElementPosition(localPlayer)
      local dist = getDistanceBetweenPoints2D(x, y, x2, y2)
      if dist < 2.5 then
        lastGet = getTickCount()
        triggerServerEvent("putChickenFoodInFeeder", localPlayer)
      end
    end
  elseif clickedElement and getElementModel(clickedElement) == models.chicken_feed_bag and getTickCount() - lastGet > 500 then
    local currentBucket = getElementData(localPlayer, "currentBucket")
    if state == "down" and currentBucket and (not currentBucket[2] or currentBucket[2][1] == "csirketap") then
      local x, y = getElementPosition(clickedElement)
      local x2, y2 = getElementPosition(localPlayer)
      local dist = getDistanceBetweenPoints2D(x, y, x2, y2)
      if dist < 2 then
        lastGet = getTickCount()
        triggerServerEvent("getChickenFoodToBucket", localPlayer)
      end
    end
  elseif clickedElement and getElementModel(clickedElement) == models.bale and getTickCount() - lastGet > 500 then
    if state == "down" and playerTools[localPlayer] == "fork" then
      local x, y = getElementPosition(clickedElement)
      local x2, y2 = getElementPosition(localPlayer)
      local dist = getDistanceBetweenPoints2D(x, y, x2, y2)
      if dist < 2 then
        lastGet = getTickCount()
        triggerServerEvent("getHayToFork", localPlayer)
      end
    end
  elseif isElement(hoeObject) and clickedElement == hoeObject and getTickCount() - lastGet > 500 then
    if state == "down" then
      local x, y = getElementPosition(hoeObject)
      local x2, y2 = getElementPosition(localPlayer)
      local dist = getDistanceBetweenPoints2D(x, y, x2, y2)
      if dist < 1.5 then
        if playerTools[localPlayer] ~= "hoe" then
          triggerServerEvent("getHoeFromInterior", localPlayer)
          lastGet = getTickCount()
        elseif playerTools[localPlayer] == "hoe" then
          triggerServerEvent("putHoeToInterior", localPlayer)
          lastGet = getTickCount()
        end
      end
    end
  elseif clickedElement == forkObject and getTickCount() - lastGet > 500 then
    if state == "down" then
      local x, y = getElementPosition(forkObject)
      local x2, y2 = getElementPosition(localPlayer)
      local dist = getDistanceBetweenPoints2D(x, y, x2, y2)
      if dist < 1.5 then
        if playerTools[localPlayer] ~= "fork" then
          triggerServerEvent("getForkFromInterior", localPlayer)
          lastGet = getTickCount()
        elseif playerTools[localPlayer] == "fork" then
          triggerServerEvent("putForkToInterior", localPlayer)
          lastGet = getTickCount()
        end
      end
    end
  elseif clickedElement == miniHoeObject and getTickCount() - lastGet > 500 then
    if state == "down" then
      local x, y = getElementPosition(miniHoeObject)
      local x2, y2 = getElementPosition(localPlayer)
      local dist = getDistanceBetweenPoints2D(x, y, x2, y2)
      if dist < 1.5 then
        if playerTools[localPlayer] ~= "minihoe" then
          triggerServerEvent("getMiniHoeFromInterior", localPlayer)
          lastGet = getTickCount()
        elseif playerTools[localPlayer] == "minihoe" then
          triggerServerEvent("putMiniHoeToInterior", localPlayer)
          lastGet = getTickCount()
        end
      end
    end
  elseif selectPlantType then
    if state == "down" then
      if currentSelectedPlantType then
        triggerServerEvent("farmTask", localPlayer, currentFarmId, selectPlantType[1], selectPlantType[2], "plant", currentSelectedPlantType)
      else
        currentPlayerTaskInProgress = false
      end
      selectPlantType = false
    end
  elseif activeButton and utf8.find(activeButton, "togglePermission") then
    if state == "down" then
      local cmd = split(activeButton, ":")
      triggerServerEvent("toggleFarmPermission", localPlayer, cmd[2], cmd[3])
    end
  elseif activeButton and utf8.find(activeButton, "removeMember") then
    if state == "down" then
      local cmd = split(activeButton, ":")
      triggerServerEvent("removeFarmPermission", localPlayer, cmd[2])
    end
  elseif activeButton == "addMember" then
    if state == "down" then
      addMemberState = not addMemberState
      if addMemberState then
        addMemberText = ""
        addEventHandler("onClientKey", getRootElement(), onClientKeyMember)
        addEventHandler("onClientCharacter", getRootElement(), onClientCharacterMember)
      else
        removeEventHandler("onClientKey", getRootElement(), onClientKeyMember)
        removeEventHandler("onClientCharacter", getRootElement(), onClientCharacterMember)
        if 1 < utf8.len(addMemberText) then
          triggerServerEvent("addFarmPermission", localPlayer, addMemberText)
        end
      end
    end
  elseif activeButton == "animalPanel" then
    if state == "down" then
      openAnimalPanel()
    end
  elseif activeButton == "permissionPanel" then
    if state == "down" then
      permissionPanel = not permissionPanel
    end
  elseif activeButton == "renameTable" then
    if state == "down" then
      if tableRenaming then
        doneTableRenaming()
      else
        tableRenamingText = split(farmDetails[currentFarmId].tableText, "/")
        if not tableRenamingText[2] then
          tableRenamingText[2] = ""
        end
        tableRenaming = 1
        addEventHandler("onClientKey", getRootElement(), onClientKey)
        addEventHandler("onClientCharacter", getRootElement(), onClientCharacter)
      end
    end
  elseif farmHover and not currentPlayerTaskInProgress and state == "down" then
    local x, y = farmHover[1], farmHover[2]
    if not checkDistanceFromLand(localPlayer, currentFarmId, x, y) then
      seexports.sGui:showInfobox("e", "Túl messze vagy!")
      return
    end
    if currentFarmType == 2 then
      if button == "left" then
        if currentForkContentSize[localPlayer] and currentForkContentSize[localPlayer][5] == "_manure" then
          if not landData[x][y].hay or landData[x][y].dirt < 255 then
            triggerServerEvent("farmTask", localPlayer, currentFarmId, x, y, "placemanure")
            currentPlayerTaskInProgress = true
          end
        elseif not landData[x][y].hay then
          triggerServerEvent("farmTask", localPlayer, currentFarmId, x, y, "placehay")
          currentPlayerTaskInProgress = true
        end
      elseif button == "right" and landData[x][y].hay and landData[x][y].dirt and 0 < landData[x][y].dirt then
        triggerServerEvent("farmTask", localPlayer, currentFarmId, x, y, "removedirt")
        currentPlayerTaskInProgress = true
      end
    else
      if button == "left" then
        if landData[x][y].landState == "cultivated:10" then
          if playerTools[localPlayer] ~= "minihoe" then
            seexports.sGui:showInfobox("e", "Nincs nálad ásó!")
          else
            triggerServerEvent("farmTask", localPlayer, currentFarmId, x, y, "dighole")
            currentPlayerTaskInProgress = true
          end
        elseif landData[x][y].landState == "hole" then
          if activeButton then
            if activeButton == "plant" then
              if landData[x][y].wetness > whenRot then
                availableSeeds = {}
                for k = 1, #plantsTable do
                  availableSeeds[plantDetails[plantsTable[k]].seeds] = seexports.sItems:playerHasItem(plantDetails[plantsTable[k]].seeds)
                end
                selectPlantType = {x, y}
                currentPlayerTaskInProgress = true
                currentSelectedPlantType = false
              else
                seexports.sGui:showInfobox("e", "Nem elég nedves a föld az ültetéshez!")
              end
            elseif activeButton == "fillHole" then
              triggerServerEvent("farmTask", localPlayer, currentFarmId, x, y, "fillHole")
              currentPlayerTaskInProgress = true
            end
          end
        elseif landData[x][y].plant then
          if activeButton == "ppboost" then
            if ppboostPrompt then
              triggerServerEvent("ppBoostFarm", localPlayer, currentFarmId, x, y)
              ppboostPrompt = false
            else
              ppboostPrompt = true
            end
          elseif activeButton == "harvest" then
            triggerServerEvent("farmTask", localPlayer, currentFarmId, x, y, "harvest")
            currentPlayerTaskInProgress = true
          end
        elseif playerTools[localPlayer] ~= "hoe" then
          seexports.sGui:showInfobox("e", "Nincs nálad kapa!")
        else
          triggerServerEvent("farmTask", localPlayer, currentFarmId, x, y, "cultivate")
          currentPlayerTaskInProgress = true
        end
      end
      if button == "right" then
        if 0 < landData[x][y].lastWatering then
          landData[x][y].wetness = calculateWetness(landData[x][y])
        end
        if playerTools[localPlayer] then
          seexports.sGui:showInfobox("e", "Előbb rakd le a szerszámokat!")
        elseif landData[x][y].wetness < math.min(whenRot * 2.75, 225) then
          triggerServerEvent("farmTask", localPlayer, currentFarmId, x, y, "water")
          currentPlayerTaskInProgress = true
        else
          seexports.sGui:showInfobox("e", "Még túl nedves a föld a locsoláshoz!")
        end
      end
    end
  end
end
addEvent("refreshFarmLandState", true)
addEventHandler("refreshFarmLandState", getRootElement(), function(x, y, new, animation, farmId)
  if farmId == currentFarmId then
    if animation then
      landIterpolations[x][y] = {
        progress = 0,
        duration = animation,
        start = getTickCount(),
        theType = "land",
        from = landData[x][y].landState,
        to = new
      }
    end
    landData[x][y].landState = new
    drawFarmRT()
  end
end)
addEvent("cleanFarmDirt", true)
addEventHandler("cleanFarmDirt", getRootElement(), function(x, y, animation, farmId)
  if farmId == currentFarmId then
    if animation then
      landIterpolations[x][y] = {
        progress = 0,
        duration = animation,
        start = getTickCount(),
        theType = "dirt",
        from = landData[x][y].dirt,
        to = 0
      }
    end
    setPedAnimation(source, "vv_fel", "M_smk_in", -1, false, true, false, false)
    landData[x][y].hay = false
    landData[x][y].dirt = 0
    drawFarmRT()
    refreshDirtEffects()
  end
end)
addEvent("setFarmDirt", true)
addEventHandler("setFarmDirt", getRootElement(), function(x, y, animation, new, farmId)
  if farmId == currentFarmId then
    if animation then
      landIterpolations[x][y] = {
        progress = 0,
        duration = animation,
        start = getTickCount(),
        theType = "dirt",
        from = landData[x][y].dirt,
        to = new,
        hay = landData[x][y].hay
      }
    end
    setPedAnimation(source, "vv_fel", "M_smk_in", -1, false, true, false, false)
    landData[x][y].hay = true
    landData[x][y].dirt = new
    drawFarmRT()
    refreshDirtEffects()
  end
end)
addEvent("refreshFarmHay", true)
addEventHandler("refreshFarmHay", getRootElement(), function(x, y, new, animation, farmId)
  if farmId == currentFarmId then
    if animation then
      landIterpolations[x][y] = {
        progress = 0,
        duration = animation,
        start = getTickCount(),
        theType = "hay",
        from = landData[x][y].hay,
        to = new
      }
    end
    setPedAnimation(source, "vv_le", "M_smk_in", -1, false, true, false, false)
    landData[x][y].hay = new
    drawFarmRT()
  end
end)
addEvent("boostPlant", true)
addEventHandler("boostPlant", getRootElement(), function(x, y, gr)
  calculatePlant(landData[x][y].plant)
  landData[x][y].plant.elasped = landData[x][y].plant.elasped / 2.5
  landData[x][y].plant.growRate = gr
  landData[x][y].plant.startTime = getTickCount() - landData[x][y].plant.elasped
  landData[x][y].plant.boosted = true
  calculatePlant(landData[x][y].plant)
end)
addEvent("plantToLand", true)
addEventHandler("plantToLand", getRootElement(), function(x, y, sr, gr, pt)
  if sr then
    landData[x][y].plant = initPlantData(pt)
    landData[x][y].plant.startTime = getTickCount()
    landData[x][y].plant.startRotten = sr
    landData[x][y].plant.growRate = gr
  else
    landData[x][y].plant = false
  end
  createPlantObject(x, y)
end)
addEvent("waterFarmLand", true)
addEventHandler("waterFarmLand", getRootElement(), function(x, y, animation, fromWetness, dryFactor)
  if animation then
    if landData[x][y].lastWatering > 0 then
      landData[x][y].wetness = calculateWetness(landData[x][y])
    else
      landData[x][y].wetness = 0
    end
    landIterpolations[x][y] = {
      progress = 0,
      duration = animation,
      start = getTickCount(),
      theType = "wetness",
      from = landData[x][y].wetness,
      to = 255
    }
  end
  landData[x][y].wetness = 255
  if landData[x][y].plant then
    calculatePlant(landData[x][y].plant)
    landData[x][y].plant.startRotten = getTickCount() - landData[x][y].plant.startTime + (landData[x][y].wetness - whenRot) / dryFactorPlanted * 60 * 1000
  end
  landData[x][y].currentDryFactor = dryFactor
  landData[x][y].fromWetness = fromWetness
  landData[x][y].lastWatering = getTickCount()
  drawFarmRT()
end)
addEvent("freeUpFromTask", true)
addEventHandler("freeUpFromTask", getRootElement(), function()
  currentPlayerTaskInProgress = false
  currentlyMilking = false
  currentlyShearing = false
end)
function createPlantObject(x, y)
  local lx, ly = getLandPosition(currentFarmId, x, y)
  if landData[x][y].objects then
    for k = 1, #landData[x][y].objects do
      if isElement(landData[x][y].objects[k]) then
        destroyElement(landData[x][y].objects[k])
      end
      landData[x][y].objects[k] = nil
    end
  end
  landData[x][y].objects = {}
  if landData[x][y].plant then
    local plantType = landData[x][y].plant.type
    for i = 1, #plantDetails[plantType].objects do
      local dat = plantDetails[plantType].objects[i]
      local offset = dat.offset
      if type(offset[1]) == "table" then
        offset = offset[math.random(#offset)]
      end
      local ox, oy = rotateAround(farmInteriorRot, offset[1], offset[2], 0, 0)
      local obj = createObject(models[dat.model], lx + ox, ly + oy, lz + offset[3], offset[4], offset[5], farmInteriorRot + offset[6])
      setElementDimension(obj, currentFarmId)
      setElementStreamable(obj, false)
      setElementDoubleSided(obj, true)
      setObjectScale(obj, 0)
      setElementCollisionsEnabled(obj, false)
      table.insert(landData[x][y].objects, obj)
    end
    initRottenShader(x, y, 0)
  end
end
function createObjects()
  for x = 1, farmSizeDetails[currentSize].size[1] do
    for y = 1, farmSizeDetails[currentSize].size[2] do
      createPlantObject(x, y)
    end
  end
end
function processObjectProgress()
  for x = 1, farmSizeDetails[currentSize].size[1] do
    for y = 1, farmSizeDetails[currentSize].size[2] do
      if landData[x][y].plant then
        calculatePlant(landData[x][y].plant)
        local plantType = landData[x][y].plant.type
        initRottenShader(x, y, landData[x][y].plant.rotten)
        local rotScale = map(landData[x][y].plant.rotten, 0, 1, 1, 0.8)
        for i = 1, #landData[x][y].objects do
          local dat = plantDetails[plantType].objects[i]
          local obj = landData[x][y].objects[i]
          local growth = math.min(landData[x][y].plant.growth, 1)
          if growth * rotScale >= dat.grow[1] then
            local scale = map(growth * rotScale, dat.grow[1], dat.grow[2], dat.scale[1], dat.scale[2])
            if dat.green then
            end
            setObjectScale(obj, scale)
          else
            setObjectScale(obj, 0)
          end
        end
      end
    end
  end
end
function wetnessColor(wetness, a)
  if wetness < whenRot * 1.25 then
    local r, g, b = interpolateBetween(197, 195, 118, 89, 142, 215, wetness / (whenRot * 1.25), "Linear")
    return tocolor(r, g, b, a)
  end
  return tocolor(89, 142, 215, a)
end
function refreshRTs()
  if farmRT then
    drawFarmRT(true)
  end
  if letterRT then
    drawLetters()
  end
end
addEventHandler("onClientRestore", getRootElement(), refreshRTs)
local water
function getPlayerFarms()
  local id = getElementData(localPlayer, "char.ID")
  local farms = {}
  for k, v in pairs(farmDetails) do
    if v.rentedBy == id then
      table.insert(farms, k)
    end
  end
  return farms
end
function getPlayerFarmsForDashboard(cid)
  if getElementData(localPlayer, "loggedIn") then
    local id = tonumber(cid) or getElementData(localPlayer, "char.ID")
    local farms = {}
    for k, v in pairs(farmDetails) do
      if v.rentedBy == id then
        local nameForDash = ""
        local dat = split(v.tableText, "/")
        if 2 <= #dat and utf8.len(dat[#dat]) > 0 then
          nameForDash = utf8.upper(dat[1]) .. " " .. utf8.upper(dat[#dat])
        else
          nameForDash = utf8.upper(dat[1])
        end
        local time = getRealTime((v.expire or getRealTime().timestamp))
        local expireStr = string.format("%04d. %02d. %02d. %02d:%02d:%02d", time.year + 1900, time.month + 1, time.monthday, time.hour, time.minute, time.second)
        farm = {
          id = k,
          type = v.type,
          expire = expireStr,
          locked = v.locked,
          pos = v.pos,
          name = nameForDash
        }
        table.insert(farms, farm)
      end
    end
    return farms
  else
    return {}
  end
end
local oldMarkId = false
function markFarm(id)
  if isElement(farmMarkerOnMap) then
    destroyElement(farmMarkerOnMap)
  end
  farmMarkerOnMap = nil
  farmMarkedOnMap = false
  if id and id ~= oldMarkId then
    local pos = farmDetails[id].pos
    local col = seexports.sGui:getColorCode("sightyellow")
    farmMarkerOnMap = createBlip(pos[1], pos[2], pos[3] + 1, 19, 2, col[1], col[2], col[3])
    farmMarkedOnMap = id
    seexports.sGui:showInfobox("s", "Sikeresen megjelölted a kiválasztott farmot a térképen!")
    oldMarkId = id
  elseif id == oldMarkId then
    oldMarkId = false
  end
end
addEventHandler("onClientPreRender", getRootElement(), function()
  local dim = getElementDimension(localPlayer)
  if currentFarmId and dim ~= currentFarmId and not playerTools[localPlayer] then
    currentFarmId = false
    triggerServerEvent("exitFarm", localPlayer, true)
  end
  if dim == 0 then
    local cx, cy, cz = getCameraMatrix()
    for i, v in pairs(farmExteriors) do
      if isElementStreamedIn(v.object) and isElementOnScreen(v.object) then
        local x, y, z = unpack(v.wateringIcon)
        seelangStaticImageUsed[2] = true
        if seelangStaticImageToc[2] then
          processSeelangStaticImage[2]()
        end
        dxDrawMaterialLine3D(x, y, z + 0.2 + 0.3, x, y, z + 0.2, seelangStaticImage[2], 0.3, tocolor(blue[1], blue[2], blue[3], 175))
        local one = 1 / v.size
        local oneLetter = xs / math.abs(v.nameLineOffset[4] - v.nameLineOffset[1])
        for k = 1, v.size do
          local text = v.names[v.size - k + 1] and v.names[v.size - k + 1][1] or kiado
          local size = (#text + 2) * oneLetter / 2
          local j = 1
          local xla, yla, zla = v.tposes[k][j][1], v.tposes[k][j][2], v.tposes[k][j][3]
          if getDistanceBetweenPoints3D(xla, yla, zla, cx, cy, cz) < 100 then
            for j = 2, #text + 1 do
              local xa, ya, za = v.tposes[k][j][1], v.tposes[k][j][2], v.tposes[k][j][3]
              if letters[text[j - 1]] then
                local xb, yb, zb = v.tposes[k][j][4], v.tposes[k][j][5], v.tposes[k][j][6]
                dxDrawMaterialSectionLine3D(xa, ya, za, xla, yla, zla, (letters[text[j - 1]] - 1) * letterYSize, 0, letterYSize, letterXSize, letterRT, ys, tocolor(20, 20, 15), xb, yb, zb)
              end
              xla, yla, zla = xa, ya, za
            end
          end
        end
        local one = 1 / v.size
        local oneLetter = xs / math.abs(v.nameLineOffset[4] - v.nameLineOffset[1])
        for k = 1, v.size do
          if v.names[v.size - k + 1] then
            local text = v.names[v.size - k + 1][2]
            if type(text) == "table" then
              local size = (#text + 2) * oneLetter / 2
              local j = 1
              local xla, yla, zla = v.tposes[k][j][7], v.tposes[k][j][8], v.tposes[k][j][9]
              if getDistanceBetweenPoints3D(xla, yla, zla, cx, cy, cz) < 100 then
                for j = 2, #text + 1 do
                  local xa, ya, za = v.tposes[k][j][7], v.tposes[k][j][8], v.tposes[k][j][9]
                  if letters[text[j - 1]] then
                    local xb, yb, zb = v.tposes[k][j][10], v.tposes[k][j][11], v.tposes[k][j][12]
                    dxDrawMaterialSectionLine3D(xa, ya, za, xla, yla, zla, (letters[text[j - 1]] - 1) * letterYSize, 0, letterYSize, letterXSize, letterRT, ys, tocolor(20, 20, 15), xb, yb, zb)
                  end
                  xla, yla, zla = xa, ya, za
                end
              end
            end
          end
        end
      end
    end
  end
end)
local glass
function onClientPreRender()
  local x, y, z = getElementPosition(interiorObject)
  z = z + 0.05
  local x2, y2 = rotateAround(farmInteriorRot, x - 2.55, y, x, y)
  local x3, y3 = rotateAround(farmInteriorRot, x - 1.275, y, x, y)
  seelangStaticImageUsed[3] = true
  if seelangStaticImageToc[3] then
    processSeelangStaticImage[3]()
  end
  dxDrawMaterialLine3D(x, y, z + 5, x2, y2, z + 3.95, seelangStaticImage[3], 17, tocolor(blue[1], blue[2], blue[3], 150), x3, y3, z + 10)
  local x2, y2 = rotateAround(farmInteriorRot, x + 2.55, y, x, y)
  local x3, y3 = rotateAround(farmInteriorRot, x + 1.275, y, x, y)
  seelangStaticImageUsed[3] = true
  if seelangStaticImageToc[3] then
    processSeelangStaticImage[3]()
  end
  dxDrawMaterialLine3D(x, y, z + 5, x2, y2, z + 3.95, seelangStaticImage[3], 17, tocolor(blue[1], blue[2], blue[3], 150), x3, y3, z + 10)
  local x, y = rotateAround(farmInteriorRot, lx, ly - farmSizeDetails[currentSize].size[2] * blockSize / 2, lx, ly)
  local x2, y2 = rotateAround(farmInteriorRot, lx, ly + farmSizeDetails[currentSize].size[2] * blockSize / 2, lx, ly)
  dxDrawMaterialLine3D(x, y, lz, x2, y2, lz, farmRT, -farmSizeDetails[currentSize].size[1] * blockSize, tocolor(255, 255, 255), lx, ly, lz + 1)
end
local oneLetterX = respc(letterYSize)
local oneLetterY = respc(letterXSize)
local guiSizes = {
  mainPanel = {
    respc(145),
    respc(119)
  },
  landPanel = {
    respc(175),
    respc(20)
  }
}
function onClientRender()
  activeButton = false
  local curx, cury, wx, wy, wz = getCursorPosition()
  if curx then
    curx = curx * screenX
    cury = cury * screenY
  end
  local cx, cy = -screenX, -screenY
  if curx then
    cx = curx
    cy = cury
  end
  if crateElement then
    local x, y, z = getElementPosition(crateElement)
    z = z + 0.12
    local x2, y2, z2 = getElementPosition(localPlayer)
    if getDistanceBetweenPoints2D(x, y, x2, y2) < 1.75 then
      local x, y = getScreenFromWorldPosition(x, y, z)
      if x and y then
        if #currentFarmInventory <= 0 then
          dxDrawRectangle(x - 50, y - 20, 100, 40, backgroundColor)
          dxDrawRectangle(x - 50, y - 20, 100, 20, titlebarColor)
          dxDrawText("Láda", x - 50, y - 20, x + 50, y, tocolor(255, 255, 255), titlebarFontScale, titlebarFont, "center", "center", false, false, false, true)
          dxDrawText("üres", x - 50, y, x + 50, y + 20, tocolor(255, 255, 255), 0.85, Roboto, "center", "center", false, false, false, true)
        else
          local h = (#currentFarmInventory + 2) * 20
          dxDrawRectangle(x - 80, y - h / 2, 160, h, backgroundColor)
          dxDrawRectangle(x - 80, y - h / 2, 160, 20, titlebarColor)
          dxDrawText("Láda", x - 50, y - h / 2, x + 50, y - h / 2 + 20, tocolor(255, 255, 255), titlebarFontScale, titlebarFont, "center", "center", false, false, false, true)
          local weight = 0
          for k = 1, #currentFarmInventory do
            weight = weight + currentFarmInventory[k][4]
            dxDrawText(currentFarmInventory[k][2], x - 75, y - h / 2 + 20 * k, x + 75, y - h / 2 + 20 * (k + 1), tocolor(255, 255, 255), 0.85, Roboto, "left", "center", false, false, false, true)
            dxDrawText(currentFarmInventory[k][3] .. " db", x - 75, y - h / 2 + 20 * k, x + 75, y - h / 2 + 20 * (k + 1), tocolor(255, 255, 255), 0.85, Roboto, "right", "center", false, false, false, true)
          end
          dxDrawText(round(weight) .. "/25 kg", x - 50, y + h / 2 - 20, x + 50, y + h / 2, tocolor(255, 255, 255), 0.85, Roboto, "center", "center", false, false, false, true)
        end
      end
    end
  end
  local x2, y2, z2 = getElementPosition(localPlayer)
  if currentFarmType == 2 then
    x, y, z = getElementPosition(forkObject)
    z = z + 0.325
    if getDistanceBetweenPoints2D(x, y, x2, y2) < 1.5 then
      local x, y = getScreenFromWorldPosition(x, y, z)
      if x and y then
        dxDrawRectangle(x - 50, y - 20, 100, 40, backgroundColor)
        dxDrawRectangle(x - 50, y - 20, 100, 20, titlebarColor)
        dxDrawText("Vasvilla", x - 50, y - 20, x + 50, y, tocolor(255, 255, 255), titlebarFontScale, titlebarFont, "center", "center", false, false, false, true)
        dxDrawText(currentFork .. " db", x - 50, y, x + 50, y + 20, tocolor(255, 255, 255), 0.85, Roboto, "center", "center", false, false, false, true)
      end
    end
  else
    x, y, z = getElementPosition(hoeObject)
    local hx, hy = getElementPosition(miniHoeObject)
    z = z + 0.325
    if getDistanceBetweenPoints2D(x, y, x2, y2) < 1.5 or getDistanceBetweenPoints2D(hx, hy, x2, y2) < 1.5 then
      local x, y = getScreenFromWorldPosition(x, y, z)
      if x and y then
        dxDrawRectangle(x - 50, y - 20, 100, 40, backgroundColor)
        dxDrawRectangle(x - 50, y - 20, 100, 20, titlebarColor)
        dxDrawText("Kapa", x - 50, y - 20, x + 50, y, tocolor(255, 255, 255), titlebarFontScale, titlebarFont, "center", "center", false, false, false, true)
        dxDrawText(currentHoePlayer .. " db", x - 50, y, x + 50, y + 20, tocolor(255, 255, 255), 0.85, Roboto, "center", "center", false, false, false, true)
      end
    end
    x, y = hx, hy
    if getDistanceBetweenPoints2D(x, y, x2, y2) < 1.5 or getDistanceBetweenPoints2D(hx, hy, x2, y2) < 1.5 then
      local x, y = getScreenFromWorldPosition(x, y, z)
      if x and y then
        dxDrawRectangle(x - 50, y - 20, 100, 40, backgroundColor)
        dxDrawRectangle(x - 50, y - 20, 100, 20, titlebarColor)
        dxDrawText("Ásó", x - 50, y - 20, x + 50, y, tocolor(255, 255, 255), titlebarFontScale, titlebarFont, "center", "center", false, false, false, true)
        dxDrawText(currentMiniHoePlayer .. " db", x - 50, y, x + 50, y + 20, tocolor(255, 255, 255), 0.85, Roboto, "center", "center", false, false, false, true)
      end
    end
  end
  if isOwner or canBuyAnimals or canSellAnimals or feedAnimalPerm then
    local ox, oy = rotateAround(farmInteriorRot, farmSizeDetails[currentSize].panelOffset[1], farmSizeDetails[currentSize].panelOffset[2], 0, 0)
    local x, y, z = farmInteriorX + ox, farmInteriorY + oy, farmInteriorZ + farmSizeDetails[currentSize].panelOffset[3]
    if getDistanceBetweenPoints2D(x, y, x2, y2) < 1.5 then
      local x, y = getScreenFromWorldPosition(x, y, z)
      if x and y and not animalPanel then
        if permissionPanel and isOwner then
          local h = guiSizes.landPanel[2] * (#permissions + 2)
          if #permissions < 1 then
            h = h + 4
          end
          dxDrawRectangle(x - guiSizes.mainPanel[1] - 4, y - h / 2 - 4, guiSizes.mainPanel[1] * 2 + 8, h + 8, backgroundColor)
          dxDrawRectangle(x - guiSizes.mainPanel[1] - 4, y - h / 2 - 4, guiSizes.mainPanel[1] * 2 + 8, guiSizes.landPanel[2] + 4, titlebarColor)
          dxDrawText("Jogosultságok", x - guiSizes.mainPanel[1] + 4, y - h / 2 - 4, 0, y - h / 2 + guiSizes.landPanel[2], tocolor(255, 255, 255), titlebarFontScale, titlebarFont, "left", "center")
          for i = 1, #permissions do
            local color = tocolor(255, 255, 255)
            if cx >= x - guiSizes.mainPanel[1] and cy >= y - h / 2 + guiSizes.landPanel[2] * i and cx <= x - guiSizes.mainPanel[1] + 20 and cy <= y - h / 2 + guiSizes.landPanel[2] * (i + 1) then
              color = tocolor(215, 89, 89)
              activeButton = "removeMember:" .. permissions[i][1]
            end
            dxDrawText("\226\156\149", x - guiSizes.mainPanel[1], y - h / 2 + guiSizes.landPanel[2] * i, x - guiSizes.mainPanel[1] + 20, y - h / 2 + guiSizes.landPanel[2] * (i + 1), color, 0.85, Roboto, "center", "center")
            dxDrawText(permissions[i][2], x - guiSizes.mainPanel[1] + 20, y - h / 2 + guiSizes.landPanel[2] * i, 0, y - h / 2 + guiSizes.landPanel[2] * (i + 1), tocolor(255, 255, 255), 0.85, Roboto, "left", "center")
            for j = 1, #permissionsByType[currentFarmType] do
              local k = permissionsByType[currentFarmType][j]
              local hover = cx >= x + guiSizes.mainPanel[1] - #permissionsByType[currentFarmType] * 20 + (j - 1) * 20 and cy >= y - h / 2 + guiSizes.landPanel[2] * i and cx <= x + guiSizes.mainPanel[1] - #permissionsByType[currentFarmType] * 20 + j * 20 and cy <= y - h / 2 + guiSizes.landPanel[2] * (i + 1)
              if hover then
                local w = dxGetTextWidth(farmPermissionGroups[k][1], 0.85, Roboto)
                local h = dxGetFontHeight(0.85, Roboto)
                dxDrawRectangle(cx + 4, cy + 4, w + 8, h + 8, tocolor(0, 0, 0, 255), true)
                dxDrawText(farmPermissionGroups[k][1], cx + 4, cy + 4, cx + w + 8 + 4, cy + h + 8 + 4, tocolor(255, 255, 255), 0.85, Roboto, "center", "center", false, false, true)
                activeButton = "togglePermission:" .. permissions[i][1] .. ":" .. k
              end
              if permissions[i][3][k] then
                local color = tocolor(255, 255, 255)
                if hover then
                  color = tocolor(green[1], green[2], green[3])
                end
                dxDrawText("\226\156\147", x + guiSizes.mainPanel[1] - #permissionsByType[currentFarmType] * 20 + (j - 1) * 20, y - h / 2 + guiSizes.landPanel[2] * i, x + guiSizes.mainPanel[1] - #permissionsByType[currentFarmType] * 20 + j * 20, y - h / 2 + guiSizes.landPanel[2] * (i + 1), color, 0.85, Roboto, "center", "center")
              else
                local color = tocolor(255, 255, 255)
                if hover then
                  color = tocolor(215, 89, 89)
                end
                dxDrawText("\226\128\149", x + guiSizes.mainPanel[1] - #permissionsByType[currentFarmType] * 20 + (j - 1) * 20, y - h / 2 + guiSizes.landPanel[2] * i, x + guiSizes.mainPanel[1] - #permissionsByType[currentFarmType] * 20 + j * 20, y - h / 2 + guiSizes.landPanel[2] * (i + 1), color, 0.85, Roboto, "center", "center")
              end
            end
          end
          if addMemberState then
            dxDrawText(addMemberText, x - guiSizes.mainPanel[1], y + h / 2 - guiSizes.landPanel[2], 0, y + h / 2, tocolor(255, 255, 255), 0.85, Roboto, "left", "center")
            if cx >= x + guiSizes.mainPanel[1] - 75 and cy >= y + h / 2 - guiSizes.landPanel[2] and cx <= x + guiSizes.mainPanel[1] and cy <= y + h / 2 then
              dxDrawRectangle(x + guiSizes.mainPanel[1] - 75, y + h / 2 - guiSizes.landPanel[2], 75, guiSizes.landPanel[2], btnColors[2])
              activeButton = "addMember"
            else
              dxDrawRectangle(x + guiSizes.mainPanel[1] - 75, y + h / 2 - guiSizes.landPanel[2], 75, guiSizes.landPanel[2], btnColors[1])
            end
            dxDrawText("Hozzáad", x + guiSizes.mainPanel[1] - 75, y + h / 2 - guiSizes.landPanel[2], x + guiSizes.mainPanel[1], y + h / 2, tocolor(255, 255, 255), btnFontScale, btnFont, "center", "center")
          else
            if cx >= x - guiSizes.mainPanel[1] and cy >= y + h / 2 - guiSizes.landPanel[2] and cx <= x - guiSizes.mainPanel[1] + 135 and cy <= y + h / 2 then
              dxDrawRectangle(x - guiSizes.mainPanel[1], y + h / 2 - guiSizes.landPanel[2], 135, guiSizes.landPanel[2], btnColors[2])
              activeButton = "addMember"
            else
              dxDrawRectangle(x - guiSizes.mainPanel[1], y + h / 2 - guiSizes.landPanel[2], 135, guiSizes.landPanel[2], btnColors[1])
            end
            dxDrawText("+ Tag hozzáadása", x - guiSizes.mainPanel[1], y + h / 2 - guiSizes.landPanel[2], x - guiSizes.mainPanel[1] + 135, y + h / 2, tocolor(255, 255, 255), btnFontScale, btnFont, "center", "center")
            if cx >= x + guiSizes.mainPanel[1] - 50 and cy >= y + h / 2 - guiSizes.landPanel[2] and cx <= x + guiSizes.mainPanel[1] and cy <= y + h / 2 then
              dxDrawRectangle(x + guiSizes.mainPanel[1] - 50, y + h / 2 - guiSizes.landPanel[2], 50, guiSizes.landPanel[2], btnColors[2])
              activeButton = "permissionPanel"
            else
              dxDrawRectangle(x + guiSizes.mainPanel[1] - 50, y + h / 2 - guiSizes.landPanel[2], 50, guiSizes.landPanel[2], btnColors[1])
            end
            dxDrawText("Kész", x + guiSizes.mainPanel[1] - 50, y + h / 2 - guiSizes.landPanel[2], x + guiSizes.mainPanel[1], y + h / 2, tocolor(255, 255, 255), btnFontScale, btnFont, "center", "center")
          end
        else
          local h = guiSizes.mainPanel[2] + 8
          if currentFarmType == 2 then
            h = h + respc(20) - 4
          else
            h = h - 8
          end
          if not isOwner then
            h = h - respc(20) * 2 - 8
          end
          dxDrawRectangle(x - guiSizes.mainPanel[1] / 2, y - guiSizes.mainPanel[2] / 2 - 4, guiSizes.mainPanel[1], h + 8, backgroundColor)
          local text = farmExteriors[farmDetails[currentFarmId].exteriorId[1]].names[farmDetails[currentFarmId].exteriorId[2]][1]
          local width = #text * oneLetterY
          local lx = x - (oneLetterX - oneLetterY) - width / 2 + oneLetterY * 0.5
          local ly = y - guiSizes.mainPanel[2] / 2
          dxDrawText("Farm tábla: ", x - guiSizes.mainPanel[1] / 2, ly, x + guiSizes.mainPanel[1] / 2, ly + respc(20), tocolor(255, 255, 255), 0.85, Roboto, "center", "center")
          ly = y - guiSizes.mainPanel[2] / 2 - (oneLetterY - oneLetterX) - oneLetterY * 0.5 + respc(15)
          for i = 1, #text do
            if letters[text[i]] then
              dxDrawImageSection(lx + (i - 1) * oneLetterY + 2, ly, oneLetterX, oneLetterY, (letters[text[i]] - 1) * letterYSize, 0, letterYSize, letterXSize, letterRT, 90, 0, 0, tocolor(255, 255, 255))
            end
          end
          if tableRenaming == 1 and getTickCount() % 1000 <= 500 then
            dxDrawLine(x + width / 2 + 1, ly - 4, x + width / 2 + 1, ly + oneLetterX * 0.5 + 2, tocolor(255, 255, 255))
          end
          local text = farmExteriors[farmDetails[currentFarmId].exteriorId[1]].names[farmDetails[currentFarmId].exteriorId[2]][2]
          local width = 0
          ly = ly + 3
          ly = ly + oneLetterY * 2
          if text then
            width = #text * oneLetterY
            lx = x - (oneLetterX - oneLetterY) - width / 2 + oneLetterY * 0.5
            for i = 1, #text do
              if letters[text[i]] then
                dxDrawImageSection(lx + (i - 1) * oneLetterY + 2, ly, oneLetterX, oneLetterY, (letters[text[i]] - 1) * letterYSize, 0, letterYSize, letterXSize, letterRT, 90, 0, 0, tocolor(255, 255, 255))
              end
            end
          end
          if tableRenaming == 2 and getTickCount() % 1000 <= 500 then
            dxDrawLine(x + width / 2 + 1, ly - 4, x + width / 2 + 1, ly + oneLetterX * 0.5 + 2, tocolor(255, 255, 255))
          end
          ly = ly + oneLetterY * 1.5 + 5
          if isOwner then
            if cx >= x - guiSizes.mainPanel[1] / 2 + 4 and cy >= ly and cx <= x + guiSizes.mainPanel[1] / 2 - 4 and cy <= ly + respc(20) then
              dxDrawRectangle(x - guiSizes.mainPanel[1] / 2 + 4, ly, guiSizes.mainPanel[1] - 8, respc(20), btnColors[2])
              activeButton = "renameTable"
            else
              dxDrawRectangle(x - guiSizes.mainPanel[1] / 2 + 4, ly, guiSizes.mainPanel[1] - 8, respc(20), btnColors[1])
            end
            if tableRenaming then
              dxDrawText("Kész", x - guiSizes.mainPanel[1] / 2, ly, x + guiSizes.mainPanel[1] / 2, ly + respc(20), tocolor(255, 255, 255), btnFontScale, btnFont, "center", "center")
            else
              dxDrawText("Szerkesztés", x - guiSizes.mainPanel[1] / 2, ly, x + guiSizes.mainPanel[1] / 2, ly + respc(20), tocolor(255, 255, 255), btnFontScale, btnFont, "center", "center")
            end
            ly = ly + respc(20) + 4
            if cx >= x - guiSizes.mainPanel[1] / 2 + 4 and cy >= ly and cx <= x + guiSizes.mainPanel[1] / 2 - 4 and cy <= ly + respc(20) then
              dxDrawRectangle(x - guiSizes.mainPanel[1] / 2 + 4, ly, guiSizes.mainPanel[1] - 8, respc(20), btnColors[2])
              activeButton = "permissionPanel"
            else
              dxDrawRectangle(x - guiSizes.mainPanel[1] / 2 + 4, ly, guiSizes.mainPanel[1] - 8, respc(20), btnColors[1])
            end
            dxDrawText("Jogosultságok", x - guiSizes.mainPanel[1] / 2, ly, x + guiSizes.mainPanel[1] / 2, ly + respc(20), tocolor(255, 255, 255), btnFontScale, btnFont, "center", "center")
            ly = ly + respc(20) + 4
          end
          if currentFarmType == 2 then
            if cx >= x - guiSizes.mainPanel[1] / 2 + 4 and cy >= ly and cx <= x + guiSizes.mainPanel[1] / 2 - 4 and cy <= ly + respc(20) then
              dxDrawRectangle(x - guiSizes.mainPanel[1] / 2 + 4, ly, guiSizes.mainPanel[1] - 8, respc(20), btnColors[6])
              activeButton = "animalPanel"
            else
              dxDrawRectangle(x - guiSizes.mainPanel[1] / 2 + 4, ly, guiSizes.mainPanel[1] - 8, respc(20), btnColors[5])
            end
            dxDrawText("Állattartás", x - guiSizes.mainPanel[1] / 2, ly, x + guiSizes.mainPanel[1] / 2, ly + respc(20), tocolor(255, 255, 255), btnFontScale, btnFont, "center", "center")
          end
        end
      end
    elseif animalPanel then
      seexports.sGui:deleteGuiElement(animalPanel)
      animalPanel = false
      animalHoverBox = false
    end
  end
  processObjectProgress()
  local olx, oly = lx, ly
  local lx, ly = rotateAround(farmInteriorRot, lx - farmSizeDetails[currentSize].size[1] * blockSize / 2, ly - farmSizeDetails[currentSize].size[2] * blockSize / 2, lx, ly)
  for x = 1, farmSizeDetails[currentSize].size[1] do
    for y = 1, farmSizeDetails[currentSize].size[2] do
      seelangStaticImageUsed[2] = true
      if seelangStaticImageToc[2] then
        processSeelangStaticImage[2]()
      end
      local iconToDraw = false
      if currentFarmType == 1 then
        if landData[x][y].wetness < whenRot * 1.35 and landData[x][y].plant and (landData[x][y].plant.rotten or 0) < 0.25 and landData[x][y].plant.growth <= rottenStart then
          iconToDraw = {
            seelangStaticImage[2],
            tocolor(50, 179, 239, 175)
          }
        end
        if iconToDraw then
          local sx, sy = getLandPosition(currentFarmId, x, y)
          local sx, sy = getScreenFromWorldPosition(sx, sy, lz + 0.25)
          if sx then
            dxDrawImage(sx - 20, sy - 20, 40, 40, iconToDraw[1], 0, 0, 0, iconToDraw[2])
          end
        end
      end
    end
  end
  local oldfh = false
  if farmHover then
    oldfh = {
      farmHover[1],
      farmHover[2]
    }
  end
  farmHover = false
  local toDraw = false
  if curx and not animalPanel then
    local cx, cy, cz = getCameraMatrix()
    local hit, x, y, z, he = processLineOfSight(cx, cy, cz, wx, wy, wz, false, false, false)
    z = lz
    if he == interiorObject or selectPlantType then
      local x, y = rotateAround(-farmInteriorRot, x, y, olx, oly)
      local lx, ly = olx - farmSizeDetails[currentSize].size[1] * blockSize / 2, oly - farmSizeDetails[currentSize].size[2] * blockSize / 2
      if selectPlantType then
        x = selectPlantType[1] - 1
        y = selectPlantType[2] - 1
      else
        x = math.floor((x - lx) / blockSize)
        y = math.floor((y - ly) / blockSize)
      end
      if currentFarmType == 2 then
        if 0 <= x and 0 <= y and x < farmSizeDetails[currentSize].size[1] and y < farmSizeDetails[currentSize].size[2] then
          farmHover = {
            x + 1,
            y + 1
          }
          toDraw = true
          local cx, cy = rotateAround(farmInteriorRot, (x + 0.5) * blockSize + olx - farmSizeDetails[currentSize].size[1] * blockSize / 2, (y + 0.5) * blockSize + oly - farmSizeDetails[currentSize].size[2] * blockSize / 2, olx, oly)
          x = x + 1
          y = y + 1
          local canClick = checkDistanceFromLand(localPlayer, currentFarmId, x, y)
          local sx, sy = getScreenFromWorldPosition(cx, cy, lz)
          if sx then
            local py = 0
            local height = guiSizes.landPanel[2] * 3
            local canPlace = false
            if canPlace then
              height = height + (guiSizes.landPanel[2] + 8) * 1
            end
            dxDrawRectangle(sx - guiSizes.landPanel[1] / 2, sy - height / 2 - 4, guiSizes.landPanel[1], height + 8, backgroundColor)
            dxDrawText("Tisztaság:", sx - guiSizes.landPanel[1] / 2, sy - height / 2 + py, sx + guiSizes.landPanel[1] / 2, sy - height / 2 + guiSizes.landPanel[2] + py, tocolor(255, 255, 255, 255), 0.85, Roboto, "center", "center")
            dxDrawRectangle(sx - guiSizes.landPanel[1] / 2 + 8, sy - height / 2 + guiSizes.landPanel[2] + 4 + py, guiSizes.landPanel[1] - 16, guiSizes.landPanel[2] - 8, titlebarColor)
            dxDrawRectangle(sx - guiSizes.landPanel[1] / 2 + 8, sy - height / 2 + guiSizes.landPanel[2] + 4 + py, (guiSizes.landPanel[1] - 16) * (1 - (landData[x][y].dirt or 0) / 255), guiSizes.landPanel[2] - 8, cleanColor(255 - (landData[x][y].dirt or 0), 255))
            if landData[x][y].hay then
              dxDrawText("Szalma: " .. greenHex .. "van", sx - guiSizes.landPanel[1] / 2, sy - height / 2 + guiSizes.landPanel[2] * 2, sx + guiSizes.landPanel[1] / 2, sy - height / 2 + guiSizes.landPanel[2] * 3, tocolor(255, 255, 255, 255), 0.85, Roboto, "center", "center", false, false, false, true)
            else
              dxDrawText("Szalma: " .. redHex .. "nincs", sx - guiSizes.landPanel[1] / 2, sy - height / 2 + guiSizes.landPanel[2] * 2, sx + guiSizes.landPanel[1] / 2, sy - height / 2 + guiSizes.landPanel[2] * 3, tocolor(255, 255, 255, 255), 0.85, Roboto, "center", "center", false, false, false, true)
            end
          end
        end
      elseif x + 1 ~= math.ceil(farmSizeDetails[currentSize].size[1] / 2) and 0 <= x and 0 <= y and x < farmSizeDetails[currentSize].size[1] and y < farmSizeDetails[currentSize].size[2] then
        farmHover = {
          x + 1,
          y + 1
        }
        toDraw = true
        if not oldfh or oldfh[1] ~= x + 1 or oldfh[2] ~= y + 1 then
          ppboostPrompt = false
        end
        local cx, cy = rotateAround(farmInteriorRot, (x + 0.5) * blockSize + olx - farmSizeDetails[currentSize].size[1] * blockSize / 2, (y + 0.5) * blockSize + oly - farmSizeDetails[currentSize].size[2] * blockSize / 2, olx, oly)
        x = x + 1
        y = y + 1
        local canClick = checkDistanceFromLand(localPlayer, currentFarmId, x, y)
        local sx, sy = getScreenFromWorldPosition(cx, cy, lz)
        if sx then
          local height = guiSizes.landPanel[2] * 3
          if landData[x][y].plant and not isInInterpolation(x, y, "land") then
            height = guiSizes.landPanel[2] * 9 + 8
          end
          if landData[x][y].landState and landData[x][y].landState ~= "cultivated:10" and landData[x][y].landState:find("cultivated") then
            height = height + guiSizes.landPanel[2]
          elseif isInInterpolation(x, y, "land") then
            height = height + guiSizes.landPanel[2]
          end
          if landData[x][y].landState == "hole" and not isInInterpolation(x, y, "land") then
            height = height + guiSizes.landPanel[2] * 2 + 4
          end
          if selectPlantType then
            height = guiSizes.landPanel[2] * (#plantsTable + 1)
          end
          dxDrawRectangle(sx - guiSizes.landPanel[1] / 2, sy - height / 2 - 4, guiSizes.landPanel[1], height + 8, backgroundColor)
          if selectPlantType then
            currentSelectedPlantType = false
            for k = 1, #plantsTable do
              local a = 100
              if availableSeeds[plantDetails[plantsTable[k]].seeds] then
                a = 255
              end
              if curx >= sx - guiSizes.landPanel[1] / 2 and cury >= sy - height / 2 + guiSizes.landPanel[2] * (k - 1) and curx <= sx + guiSizes.landPanel[1] / 2 and cury <= sy - height / 2 + guiSizes.landPanel[2] * k then
                dxDrawText(plantDetails[plantsTable[k]].displayName, sx - guiSizes.landPanel[1] / 2, sy - height / 2 + guiSizes.landPanel[2] * (k - 1), sx + guiSizes.landPanel[1] / 2, sy - height / 2 + guiSizes.landPanel[2] * k, tocolor(green[1], green[2], green[3], a), 0.85, Roboto, "center", "center")
                currentSelectedPlantType = plantsTable[k]
              else
                dxDrawText(plantDetails[plantsTable[k]].displayName, sx - guiSizes.landPanel[1] / 2, sy - height / 2 + guiSizes.landPanel[2] * (k - 1), sx + guiSizes.landPanel[1] / 2, sy - height / 2 + guiSizes.landPanel[2] * k, tocolor(255, 255, 255, a), 0.85, Roboto, "center", "center")
              end
            end
            local k = #plantsTable + 1
            if curx >= sx - guiSizes.landPanel[1] / 2 and cury >= sy - height / 2 + guiSizes.landPanel[2] * (k - 1) + 4 and curx <= sx + guiSizes.landPanel[1] / 2 and cury <= sy - height / 2 + guiSizes.landPanel[2] * k + 4 then
              dxDrawRectangle(sx - guiSizes.landPanel[1] / 2, sy - height / 2 + guiSizes.landPanel[2] * (k - 1) + 4, guiSizes.landPanel[1], guiSizes.landPanel[2], btnColors[4])
            else
              dxDrawRectangle(sx - guiSizes.landPanel[1] / 2, sy - height / 2 + guiSizes.landPanel[2] * (k - 1) + 4, guiSizes.landPanel[1], guiSizes.landPanel[2], btnColors[3])
            end
            dxDrawText("Mégsem", sx - guiSizes.landPanel[1] / 2, sy - height / 2 + guiSizes.landPanel[2] * (k - 1) + 4, sx + guiSizes.landPanel[1] / 2, sy - height / 2 + guiSizes.landPanel[2] * k + 4, tocolor(255, 255, 255, 255), btnFontScale, btnFont, "center", "center")
          else
            local py = 0
            if landData[x][y].plant and not isInInterpolation(x, y, "land") then
              py = guiSizes.landPanel[2]
            end
            dxDrawText("Nedvesség:", sx - guiSizes.landPanel[1] / 2, sy - height / 2 + py, sx + guiSizes.landPanel[1] / 2, sy - height / 2 + guiSizes.landPanel[2] + py, tocolor(255, 255, 255, 255), 0.85, Roboto, "center", "center")
            if isInInterpolation(x, y, "wetness") then
              local a = interpolateBetween(landIterpolations[x][y].from, 0, 0, landIterpolations[x][y].to, 0, 0, landIterpolations[x][y].progress, "Linear")
              dxDrawRectangle(sx - guiSizes.landPanel[1] / 2 + 8, sy - height / 2 + guiSizes.landPanel[2] + 4 + py, guiSizes.landPanel[1] - 16, guiSizes.landPanel[2] - 8, titlebarColor)
              dxDrawRectangle(sx - guiSizes.landPanel[1] / 2 + 8, sy - height / 2 + guiSizes.landPanel[2] + 4 + py, (guiSizes.landPanel[1] - 16) * a / 255, guiSizes.landPanel[2] - 8, wetnessColor(a, 255))
            else
              dxDrawRectangle(sx - guiSizes.landPanel[1] / 2 + 8, sy - height / 2 + guiSizes.landPanel[2] + 4 + py, guiSizes.landPanel[1] - 16, guiSizes.landPanel[2] - 8, titlebarColor)
              dxDrawRectangle(sx - guiSizes.landPanel[1] / 2 + 8, sy - height / 2 + guiSizes.landPanel[2] + 4 + py, (guiSizes.landPanel[1] - 16) * ((landData[x][y].wetness or 0) / 255), guiSizes.landPanel[2] - 8, wetnessColor(landData[x][y].wetness or 0, 255))
            end
            if isInInterpolation(x, y, "land") then
              if landIterpolations[x][y].from and landIterpolations[x][y].from ~= "cultivated:10" and landIterpolations[x][y].from:find("cultivated") or landIterpolations[x][y].to and landIterpolations[x][y].to ~= "cultivated:10" and landIterpolations[x][y].to:find("cultivated") then
                local from = 0
                if landIterpolations[x][y].from and landIterpolations[x][y].from ~= "cultivated:10" and landIterpolations[x][y].from:find("cultivated") then
                  from = tonumber(split(landIterpolations[x][y].from, ":")[2]) or 10
                end
                local to = 10
                if landIterpolations[x][y].to and landIterpolations[x][y].to ~= "cultivated:10" and landIterpolations[x][y].to:find("cultivated") then
                  to = tonumber(split(landIterpolations[x][y].to, ":")[2]) or 10
                end
                local a = interpolateBetween(from / 10, 0, 0, to / 10, 0, 0, landIterpolations[x][y].progress, "Linear")
                dxDrawText("Állapot: művelés alatt", sx - guiSizes.landPanel[1] / 2, sy - height / 2 + guiSizes.landPanel[2] * 2, sx + guiSizes.landPanel[1] / 2, sy - height / 2 + guiSizes.landPanel[2] * 3, tocolor(255, 255, 255, 255), 0.85, Roboto, "center", "center", false, false, false, true)
                dxDrawRectangle(sx - guiSizes.landPanel[1] / 2 + 8, sy - height / 2 + guiSizes.landPanel[2] * 3 + 4, guiSizes.landPanel[1] - 16, guiSizes.landPanel[2] - 8, titlebarColor)
                dxDrawRectangle(sx - guiSizes.landPanel[1] / 2 + 8, sy - height / 2 + guiSizes.landPanel[2] * 3 + 4, (guiSizes.landPanel[1] - 16) * a, guiSizes.landPanel[2] - 8, tocolor(green[1], green[2], green[3], 255))
              else
                dxDrawText("Állapot: művelés alatt", sx - guiSizes.landPanel[1] / 2, sy - height / 2 + guiSizes.landPanel[2] * 2, sx + guiSizes.landPanel[1] / 2, sy - height / 2 + guiSizes.landPanel[2] * 3, tocolor(255, 255, 255, 255), 0.85, Roboto, "center", "center", false, false, false, true)
                dxDrawRectangle(sx - guiSizes.landPanel[1] / 2 + 8, sy - height / 2 + guiSizes.landPanel[2] * 3 + 4, guiSizes.landPanel[1] - 16, guiSizes.landPanel[2] - 8, titlebarColor)
                dxDrawRectangle(sx - guiSizes.landPanel[1] / 2 + 8, sy - height / 2 + guiSizes.landPanel[2] * 3 + 4, (guiSizes.landPanel[1] - 16) * landIterpolations[x][y].progress, guiSizes.landPanel[2] - 8, tocolor(green[1], green[2], green[3], 255))
              end
            else
              if landData[x][y].landState == "hole" then
                dxDrawRectangle(sx - guiSizes.landPanel[1] / 2 + 4, sy - height / 2 + guiSizes.landPanel[2] * 3, guiSizes.landPanel[1] - 8, guiSizes.landPanel[2], btnColors[1])
                dxDrawRectangle(sx - guiSizes.landPanel[1] / 2 + 4, sy - height / 2 + guiSizes.landPanel[2] * 4 + 4, guiSizes.landPanel[1] - 8, guiSizes.landPanel[2], btnColors[1])
                if curx >= sx - guiSizes.landPanel[1] / 2 and curx <= sx + guiSizes.landPanel[1] / 2 then
                  if cury >= sy - height / 2 + guiSizes.landPanel[2] * 3 and cury <= sy - height / 2 + guiSizes.landPanel[2] * 4 then
                    dxDrawRectangle(sx - guiSizes.landPanel[1] / 2 + 4, sy - height / 2 + guiSizes.landPanel[2] * 3, guiSizes.landPanel[1] - 8, guiSizes.landPanel[2], btnColors[2])
                    activeButton = "fillHole"
                  end
                  if cury >= sy - height / 2 + guiSizes.landPanel[2] * 4 + 4 and cury <= sy - height / 2 + guiSizes.landPanel[2] * 5 + 4 then
                    dxDrawRectangle(sx - guiSizes.landPanel[1] / 2 + 4, sy - height / 2 + guiSizes.landPanel[2] * 4 + 4, guiSizes.landPanel[1] - 8, guiSizes.landPanel[2], btnColors[2])
                    activeButton = "plant"
                  end
                end
                dxDrawText("Lyuk betömése", sx - guiSizes.landPanel[1] / 2, sy - height / 2 + guiSizes.landPanel[2] * 3, sx + guiSizes.landPanel[1] / 2, sy - height / 2 + guiSizes.landPanel[2] * 4, tocolor(255, 255, 255, 255), btnFontScale, btnFont, "center", "center", false, false, false, true)
                dxDrawText("Növény ültetése", sx - guiSizes.landPanel[1] / 2, sy - height / 2 + guiSizes.landPanel[2] * 4 + 4, sx + guiSizes.landPanel[1] / 2, sy - height / 2 + guiSizes.landPanel[2] * 5 + 4, tocolor(255, 255, 255, 255), btnFontScale, btnFont, "center", "center", false, false, false, true)
              end
              if landData[x][y].plant and not isInInterpolation(x, y, "land") then
                dxDrawRectangle(sx - guiSizes.landPanel[1] / 2, sy - height / 2 - 4, guiSizes.landPanel[1], guiSizes.landPanel[2] + 3, tocolor(0, 0, 0, 255))
                dxDrawText(plantDetails[landData[x][y].plant.type].displayName, sx - guiSizes.landPanel[1] / 2, sy - height / 2 - 4, sx + guiSizes.landPanel[1] / 2, sy - height / 2 + guiSizes.landPanel[2] - 4 + 3, tocolor(green[1], green[2], green[3], 255), 0.85, Roboto, "center", "center")
                dxDrawText("Növekedés:", sx - guiSizes.landPanel[1] / 2, sy - height / 2 + guiSizes.landPanel[2] * 3, sx + guiSizes.landPanel[1] / 2, sy - height / 2 + guiSizes.landPanel[2] * 4, tocolor(255, 255, 255, 255), 0.85, Roboto, "center", "center", false, false, false, true)
                dxDrawRectangle(sx - guiSizes.landPanel[1] / 2 + 8, sy - height / 2 + guiSizes.landPanel[2] * 4 + 4, guiSizes.landPanel[1] - 16, guiSizes.landPanel[2] - 8, titlebarColor)
                dxDrawRectangle(sx - guiSizes.landPanel[1] / 2 + 8, sy - height / 2 + guiSizes.landPanel[2] * 4 + 4, (guiSizes.landPanel[1] - 16) * math.min(landData[x][y].plant.growth, 1), guiSizes.landPanel[2] - 8, tocolor(green[1], green[2], green[3], 255))
                dxDrawText("Állapot:", sx - guiSizes.landPanel[1] / 2, sy - height / 2 + guiSizes.landPanel[2] * 5, sx + guiSizes.landPanel[1] / 2, sy - height / 2 + guiSizes.landPanel[2] * 6, tocolor(255, 255, 255, 255), 0.85, Roboto, "center", "center", false, false, false, true)
                dxDrawRectangle(sx - guiSizes.landPanel[1] / 2 + 8, sy - height / 2 + guiSizes.landPanel[2] * 6 + 4, guiSizes.landPanel[1] - 16, guiSizes.landPanel[2] - 8, titlebarColor)
                dxDrawRectangle(sx - guiSizes.landPanel[1] / 2 + 8, sy - height / 2 + guiSizes.landPanel[2] * 6 + 4, (guiSizes.landPanel[1] - 16) * math.min(1 - landData[x][y].plant.rotten, 1), guiSizes.landPanel[2] - 8, tocolor(yellow[1], yellow[2], yellow[3], 255))
                if curx >= sx - guiSizes.landPanel[1] / 2 and curx <= sx + guiSizes.landPanel[1] / 2 and cury >= sy - height / 2 + guiSizes.landPanel[2] * 7 + 4 and cury <= sy - height / 2 + guiSizes.landPanel[2] * 8 + 4 then
                  dxDrawRectangle(sx - guiSizes.landPanel[1] / 2 + 4, sy - height / 2 + guiSizes.landPanel[2] * 7 + 4, guiSizes.landPanel[1] - 8, guiSizes.landPanel[2], btnColors[2])
                  activeButton = "harvest"
                else
                  dxDrawRectangle(sx - guiSizes.landPanel[1] / 2 + 4, sy - height / 2 + guiSizes.landPanel[2] * 7 + 4, guiSizes.landPanel[1] - 8, guiSizes.landPanel[2], btnColors[1])
                end
                local removeType = "eltávolítása"
                if 1 < landData[x][y].plant.growth and landData[x][y].plant.rotten < 0.25 then
                  removeType = "betakarítása"
                end
                dxDrawText("Növény " .. removeType, sx - guiSizes.landPanel[1] / 2, sy - height / 2 + guiSizes.landPanel[2] * 7 + 4, sx + guiSizes.landPanel[1] / 2, sy - height / 2 + guiSizes.landPanel[2] * 8 + 4, tocolor(255, 255, 255, 255), btnFontScale, btnFont, "center", "center", false, false, false, true)
                if curx >= sx - guiSizes.landPanel[1] / 2 and curx <= sx + guiSizes.landPanel[1] / 2 and cury >= sy - height / 2 + guiSizes.landPanel[2] * 8 + 8 and cury <= sy - height / 2 + guiSizes.landPanel[2] * 9 + 8 then
                  dxDrawRectangle(sx - guiSizes.landPanel[1] / 2 + 4, sy - height / 2 + guiSizes.landPanel[2] * 8 + 8, guiSizes.landPanel[1] - 8, guiSizes.landPanel[2], btnColors[2])
                  activeButton = "ppboost"
                else
                  dxDrawRectangle(sx - guiSizes.landPanel[1] / 2 + 4, sy - height / 2 + guiSizes.landPanel[2] * 8 + 8, guiSizes.landPanel[1] - 8, guiSizes.landPanel[2], btnColors[1])
                end
                if ppboostPrompt then
                  dxDrawText("Biztosan felhasználod?", sx - guiSizes.landPanel[1] / 2, sy - height / 2 + guiSizes.landPanel[2] * 8 + 8, sx + guiSizes.landPanel[1] / 2, sy - height / 2 + guiSizes.landPanel[2] * 9 + 8, tocolor(255, 255, 255, 255), btnFontScale, btnFont, "center", "center", false, false, false, true)
                else
                  dxDrawText("Prémium tápszer", sx - guiSizes.landPanel[1] / 2, sy - height / 2 + guiSizes.landPanel[2] * 8 + 8, sx + guiSizes.landPanel[1] / 2, sy - height / 2 + guiSizes.landPanel[2] * 9 + 8, tocolor(255, 255, 255, 255), btnFontScale, btnFont, "center", "center", false, false, false, true)
                end
              elseif landData[x][y].landState and landData[x][y].landState ~= "cultivated:10" and landData[x][y].landState:find("cultivated") then
                local dat = tonumber(split(landData[x][y].landState, ":")[2]) or 10
                dxDrawText("Állapot: művelés alatt", sx - guiSizes.landPanel[1] / 2, sy - height / 2 + guiSizes.landPanel[2] * 2, sx + guiSizes.landPanel[1] / 2, sy - height / 2 + guiSizes.landPanel[2] * 3, tocolor(255, 255, 255, 255), 0.85, Roboto, "center", "center", false, false, false, true)
                dxDrawRectangle(sx - guiSizes.landPanel[1] / 2 + 8, sy - height / 2 + guiSizes.landPanel[2] * 3 + 4, guiSizes.landPanel[1] - 16, guiSizes.landPanel[2] - 8, titlebarColor)
                dxDrawRectangle(sx - guiSizes.landPanel[1] / 2 + 8, sy - height / 2 + guiSizes.landPanel[2] * 3 + 4, (guiSizes.landPanel[1] - 16) * (dat / 10), guiSizes.landPanel[2] - 8, tocolor(green[1], green[2], green[3], 255))
              else
                dxDrawText("Állapot: " .. getCurrentLandStateString(landData[x][y].landState, true), sx - guiSizes.landPanel[1] / 2, sy - height / 2 + guiSizes.landPanel[2] * 2, sx + guiSizes.landPanel[1] / 2, sy - height / 2 + guiSizes.landPanel[2] * 3, tocolor(255, 255, 255, 255), 0.85, Roboto, "center", "center", false, false, false, true)
              end
            end
          end
        end
      end
    end
  end
  if oldfh and not farmHover then
    toDraw = true
  end
  for x = 1, farmSizeDetails[currentSize].size[1] do
    for y = 1, farmSizeDetails[currentSize].size[2] do
      if landIterpolations[x][y] then
        landIterpolations[x][y].progress = (getTickCount() - landIterpolations[x][y].start) / landIterpolations[x][y].duration
        if 1 < landIterpolations[x][y].progress then
          landIterpolations[x][y] = false
        end
        toDraw = true
      end
    end
  end
  if toDraw then
    drawFarmRT()
  end
end
function lockUnlockFarm()
  if currentFarmId then
    if currentStandingFarm == "exit" then
      triggerServerEvent("lockFarm", localPlayer, currentFarmId)
    end
  elseif currentStandingFarm and farmDetails[currentStandingFarm].rentedBy then
    triggerServerEvent("lockFarm", localPlayer, currentStandingFarm)
  end
end
addEvent("lockUnlockFarm", false)
addEventHandler("lockUnlockFarm", getRootElement(), lockUnlockFarm)
bindKey("K", "up", lockUnlockFarm)
function tryToBreakInFarm(itemDbId)
  if currentFarmId then
    if currentStandingFarm == "exit" then
      if not farmDetails[currentFarmId].locked then
        seexports.sGui:showInfobox("e", "Ez a farm nyitva van!")
      else
        triggerServerEvent("breakInFarm", localPlayer, currentFarmId, itemDbId)
      end
      return true
    end
  elseif currentStandingFarm then
    if not farmDetails[currentStandingFarm].locked then
      seexports.sGui:showInfobox("e", "Ez a farm nyitva van!")
    else
      triggerServerEvent("breakInFarm", localPlayer, currentStandingFarm, itemDbId)
    end
    return true
  end
  return false
end
local playerEffects = {}
addEvent("playerCanEffect", true)
addEventHandler("playerCanEffect", getRootElement(), function(time, rz, object)
  if currentFarmId and getElementDimension(source) == currentFarmId then
    local objectX, objectY, objectZ = getElementPosition(source)
    local objectX, objectY = rotateAround(rz - 90, objectX - 0.665, objectY + 0.115, objectX, objectY)
    playerEffects[source] = createEffect("petrolcan", objectX, objectY, objectZ - 0.3, 120, 0, -rz)
    setTimer(destroyElement, time, 1, playerEffects[source])
  end
end)
addEvent("playLockSoundFarm", true)
addEventHandler("playLockSoundFarm", getRootElement(), function(farmId)
  if farmId and farmDetails[farmId] then
    local x, y, z = unpack(farmDetails[farmId].pos)
    local enterSound = playSound3D(":sInteriors/files/lockunlock.mp3", x, y, z)
    local x, y, z = getInteriorMarker(farmId)
    local exitSound = playSound3D(":sInteriors/files/lockunlock.mp3", x, y, z)
    if isElement(exitSound) then
      setElementDimension(exitSound, farmId)
      setSoundVolume(exitSound, 1)
    end
  end
end)
addEvent("playRamSoundFarm", true)
addEventHandler("playRamSoundFarm", getRootElement(), function(farmId)
  if farmId and farmDetails[farmId] then
    local x, y, z = unpack(farmDetails[farmId].pos)
    local enterSound = playSound3D(":sInteriors/files/ram.mp3", x, y, z)
    if isElement(enterSound) then
      setSoundMaxDistance(enterSound, 200)
      setSoundVolume(enterSound, 1)
    end
    local x, y, z = getInteriorMarker(farmId)
    local exitSound = playSound3D(":sInteriors/files/ram.mp3", x, y, z)
    if isElement(exitSound) then
      setElementDimension(exitSound, farmId)
      setSoundMaxDistance(exitSound, 200)
      setSoundVolume(exitSound, 1)
    end
  end
end)
bindKey("E", "up", function()
  if not isPedInVehicle(localPlayer) then
    if currentFarmId then
      if currentStandingFarm == "exit" then
        if farmDetails[currentFarmId].locked then
          triggerEvent("playInteriorSound", localPlayer, "locked")
          seexports.sGui:showInfobox("e", "Ez a farm zárva van.")
        else
          if not playerTools[localPlayer] then
            triggerServerEvent("exitFarm", localPlayer)
          else
            seexports.sGui:showInfobox("e", "Előbb tedd le az eszközöket!")
          end
        end
      end
    elseif currentStandingFarm and farmDetails[currentStandingFarm] then
      if farmDetails[currentStandingFarm].rentedBy then
        if farmDetails[currentStandingFarm].locked then
          triggerEvent("playInteriorSound", localPlayer, "locked")
          seexports.sGui:showInfobox("e", "Ez a farm zárva van.")
        else
          triggerServerEvent("enterFarm", localPlayer, currentStandingFarm)
        end
      else
        openFarmRentPanel()
      end
    end
  end
end)
addEvent("syncFarmOverrideChange", true)
addEventHandler("syncFarmOverrideChange", getRootElement(), function(id, dat, val)
  farmDetails[id][dat] = val
  if dat == "locked" and (id == currentStandingFarm or id == currentFarmId and currentStandingFarm) then
    processFarmBox(id)
  elseif dat == "tableText" then
    local dat = split(val, "/")
    if 2 <= #dat and utf8.len(dat[#dat]) > 0 then
      farmExteriors[farmDetails[id].exteriorId[1]].names[farmDetails[id].exteriorId[2]] = {
        convertTableText(dat[1]),
        convertTableText(dat[#dat])
      }
    else
      farmExteriors[farmDetails[id].exteriorId[1]].names[farmDetails[id].exteriorId[2]] = {
        convertTableText(dat[1])
      }
    end
    refreshTablePoses(farmDetails[id].exteriorId[1])
    if id == currentStandingFarm or id == currentFarmId and currentStandingFarm then
      processFarmBox(id)
    end
  end
end)
addEvent("exitFarm", true)
addEventHandler("exitFarm", getRootElement(), function()
  if animalPanel then
    seexports.sGui:deleteGuiElement(animalPanel)
    animalPanel = false
  end
  deleteAnimalObjects()
  playerTools[localPlayer] = false
  for x = 1, farmSizeDetails[currentSize].size[1] do
    for y = 1, farmSizeDetails[currentSize].size[2] do
      if rottenShaders[x] then
        if isElement(rottenShaders[x][y]) then
          destroyElement(rottenShaders[x][y])
        end
        rottenShaders[x][y] = nil
      end
      if landData[x][y].objects then
        for k = 1, #landData[x][y].objects do
          if isElement(landData[x][y].objects[k]) then
            destroyElement(landData[x][y].objects[k])
          end
          landData[x][y].objects[k] = nil
        end
      end
      landData[x][y].objects = {}
    end
  end
  rottenShaders = {}
  if isElement(forkObject) then
    destroyElement(forkObject)
  end
  forkObject = nil
  forkObject = false
  if isElement(hoeObject) then
    destroyElement(hoeObject)
  end
  hoeObject = nil
  hoeObject = false
  if isElement(miniHoeObject) then
    destroyElement(miniHoeObject)
  end
  miniHoeObject = nil
  miniHoeObject = false
  for k, v in pairs(currentHoeObject) do
    if isElement(v) then
      destroyElement(v)
    end
    v = nil
  end
  for k, v in pairs(currentMiniHoeObject) do
    if isElement(v) then
      destroyElement(v)
    end
    v = nil
  end
  for k, v in pairs(currentForkObject) do
    if isElement(v) then
      destroyElement(v)
    end
    v = nil
  end
  for k, v in pairs(currentForkContent) do
    if isElement(v) then
      destroyElement(v)
    end
    v = nil
  end
  currentForkContentSize = {}
  currentForkContent = {}
  currentForkObject = {}
  currentHoeObject = {}
  currentMiniHoeObject = {}
  currentFarmInventory = {}
  currentFork = 0
  currentHoePlayer = 0
  currentMiniHoePlayer = 0
  if isElement(cultivatedRT) then
    destroyElement(cultivatedRT)
  end
  cultivatedRT = nil
  if isElement(farmRT) then
    destroyElement(farmRT)
  end
  farmRT = nil
  cultivatedRT = false
  farmRT = false
  if isElement(interiorObject) then
    destroyElement(interiorObject)
  end
  interiorObject = nil
  if isElement(Roboto) then
    destroyElement(Roboto)
  end
  Roboto = nil
  Roboto = false
  selectPlantType = false
  currentSelectedPlantType = false
  farmHover = false
  currentFarmId = false
  currentSize = false
  farmInteriorX, farmInteriorY, farmInteriorZ = false, false, false
  farmInteriorRot = false
  lx = false
  ly = false
  lz = false
  interiorObject = false
  killTimer(textureRefreshTimer)
  textureRefreshTimer = false
  removeEventHandler("onClientRender", getRootElement(), onClientRender)
  removeEventHandler("onClientClick", getRootElement(), onClientClick)
  removeEventHandler("onClientPreRender", getRootElement(), onClientPreRender)
  isOwner = false
  permissionPanel = false
  addMemberState = false
  permissions = false
end)
function canPlaceItemToCrate(clickedElement, item, amount)
  if clickedElement == crateElement then
    local weight = 0
    for k = 1, #currentFarmInventory do
      weight = weight + currentFarmInventory[k][4]
    end
    weight = weight + seexports.sItems:getItemWeight(item) * amount
    if weight < 25 then
      return true
    else
      seexports.sGui:showInfobox("e", "A kiválasztott ládába már nem fér el ez a tárgy!")
      return true
    end
  end
  return false
end
addEvent("updateFarmInventroy", true)
addEventHandler("updateFarmInventroy", getRootElement(), function(inv)
  currentFarmInventory = {}
  for k, v in pairs(inv) do
    table.insert(currentFarmInventory, {
      k,
      seexports.sItems:getItemName(k),
      v,
      seexports.sItems:getItemWeight(k) * v
    })
  end
end)
addEvent("updatePermissionData", true)
addEventHandler("updatePermissionData", getRootElement(), function(permDat)
  permissions = permDat
end)
currentAnimals = {}
animalPositions = {}
currentAnimalFood = {}
canBuyAnimals = false
canSellAnimals = false
milkingPerms = false
farmSlots = 100
addEvent("updateFarmSlots", true)
addEventHandler("updateFarmSlots", getRootElement(), function(farmId, slots)
  if farmId == currentFarmId then
    farmSlots = slots
  end
end)
feedAnimalPerm = false
addEvent("enterFarm", true)
addEventHandler("enterFarm", getRootElement(), function(farmId, pos, theType, syncData, hoe, miniHoe, playerTools, own, inv, invEl, permDat, hay, other, chick, buyperm, sellperm, bucket, bucketContent, eggCrates, milking, slots, feedPerm)
  crateElement = false
  backgroundColor = seexports.sGui:getColorCodeToColor("sightgrey2")
  titlebarColor = seexports.sGui:getColorCodeToColor("sightgrey1")
  btnColors = {
    seexports.sGui:getColorCodeToColor("sightgreen"),
    seexports.sGui:getColorCodeToColor("sightgreen-second"),
    seexports.sGui:getColorCodeToColor("sightred"),
    seexports.sGui:getColorCodeToColor("sightred-second"),
    seexports.sGui:getColorCodeToColor("sightblue"),
    seexports.sGui:getColorCodeToColor("sightblue-second")
  }
  btnFont = seexports.sGui:getFont("11/BebasNeueBold.otf")
  btnFontScale = seexports.sGui:getFontScale("11/BebasNeueBold.otf")
  titlebarFont = seexports.sGui:getFont("11/BebasNeueRegular.otf")
  titlebarFontScale = seexports.sGui:getFontScale("11/BebasNeueRegular.otf")
  farmSlots = slots
  currentFarmType = theType
  isOwner = own
  canBuyAnimals = buyperm
  canSellAnimals = sellperm
  feedAnimalPerm = feedPerm
  milkingPerms = milking
  permissionPanel = false
  addMemberState = false
  permissions = permDat
  Roboto = dxCreateFont("files/roboto.ttf", respc(13), false, "antialiased")
  currentFarmId = farmId
  if theType == 1 then
    currentSize = farmDetails[currentFarmId].size
  else
    currentSize = "animal"
  end
  local ox, oy = rotateAround(farmDetails[currentFarmId].pos[4], farmSizeDetails[currentSize].offset[1], farmSizeDetails[currentSize].offset[2], 0, 0)
  farmInteriorX, farmInteriorY, farmInteriorZ = farmDetails[currentFarmId].pos[1] + ox, farmDetails[currentFarmId].pos[2] + oy, farmDetails[currentFarmId].pos[3] + farmSizeDetails[currentSize].offset[3]
  farmInteriorRot = farmDetails[currentFarmId].pos[4] + 180
  lx = farmInteriorX + farmSizeDetails[currentSize].lineOffset[1]
  ly = farmInteriorY + farmSizeDetails[currentSize].lineOffset[2]
  lz = farmInteriorZ + farmSizeDetails[currentSize].lineOffset[3]
  interiorObject = createObject(models[farmSizeDetails[currentSize].modelid], farmInteriorX, farmInteriorY, farmInteriorZ, 0, 0, farmInteriorRot)
  setElementDimension(interiorObject, farmId)
  setElementStreamable(interiorObject, false)
  setElementDoubleSided(interiorObject, true)
  landData = {}
  initLandDataTables(landData, farmSizeDetails[currentSize].size[1], farmSizeDetails[currentSize].size[2])
  rottenShaders = {}
  initSizeTable(rottenShaders, farmSizeDetails[currentSize].size[1], farmSizeDetails[currentSize].size[2])
  landIterpolations = {}
  initSizeTable(landIterpolations, farmSizeDetails[currentSize].size[1], farmSizeDetails[currentSize].size[2])
  initFarmRT()
  addEventHandler("onClientRender", getRootElement(), onClientRender)
  addEventHandler("onClientClick", getRootElement(), onClientClick)
  addEventHandler("onClientPreRender", getRootElement(), onClientPreRender)
  textureRefreshTimer = setTimer(drawFarmRT, textureRefreshInterval, 0)
  local x, y, z = getInteriorMarker(farmId)
  seexports.sMarkers:setCustomMarkerPosition(currentMarker, x, y, z, 0, farmId)
  if theType == 2 then
    currentFork = hoe
    local ox, oy = rotateAround(farmInteriorRot, farmSizeDetails[farmDetails[farmId].size].forkOffset[1], farmSizeDetails[farmDetails[farmId].size].forkOffset[2], 0, 0)
    forkObject = createObject(models.pitchfork, farmInteriorX + ox, farmInteriorY + oy, farmInteriorZ + farmSizeDetails[farmDetails[farmId].size].forkOffset[3], farmSizeDetails[farmDetails[farmId].size].forkOffset[4], farmSizeDetails[farmDetails[farmId].size].forkOffset[5], farmDetails[farmId].pos[4] + farmSizeDetails[farmDetails[farmId].size].forkOffset[6] - 90)
    setElementDimension(forkObject, farmId)
  else
    local ox, oy = rotateAround(farmDetails[farmId].pos[4], farmSizeDetails[farmDetails[farmId].size].hoeOffset[1], farmSizeDetails[farmDetails[farmId].size].hoeOffset[2], 0, 0)
    hoeObject = createObject(models.hoe, farmDetails[farmId].pos[1] + ox, farmDetails[farmId].pos[2] + oy, farmDetails[farmId].pos[3] + farmSizeDetails[farmDetails[farmId].size].hoeOffset[3], 0, 90, farmDetails[farmId].pos[4] + farmSizeDetails[farmDetails[farmId].size].hoeOffset[4])
    setElementDimension(hoeObject, farmId)
    local ox, oy = rotateAround(farmDetails[farmId].pos[4], farmSizeDetails[farmDetails[farmId].size].miniHoeOffset[1], farmSizeDetails[farmDetails[farmId].size].miniHoeOffset[2], 0, 0)
    miniHoeObject = createObject(models.minihoe, farmDetails[farmId].pos[1] + ox, farmDetails[farmId].pos[2] + oy, farmDetails[farmId].pos[3] + farmSizeDetails[farmDetails[farmId].size].miniHoeOffset[3], 0, 90, farmDetails[farmId].pos[4] + farmSizeDetails[farmDetails[farmId].size].miniHoeOffset[4])
    setElementDimension(miniHoeObject, farmId)
    currentHoePlayer = hoe
    currentMiniHoePlayer = miniHoe
  end
  for k, v in pairs(playerTools) do
    if theType == 2 then
      if v == "fork" then
        if miniHoe[k] then
          triggerEvent("syncForkState", k, farmId, true, hoe, miniHoe[k], false, true)
        end
      end
    elseif v == "hoe" then
      triggerEvent("syncHoeState", k, farmId, true, hoe)
    elseif v == "minihoe" then
      triggerEvent("syncMiniHoeState", k, farmId, true, miniHoe)
    end
  end
  syncFarmC(syncData)
  currentFarmInventory = {}
  if theType == 2 then
    refreshBucketContent(bucket, bucketContent)
    currentAnimals = inv.animals
    currentAnimalFood = inv.food
    animalPositions = invEl
    createAnimalObjects(farmId, farmInteriorX, farmInteriorY, farmInteriorZ, farmInteriorRot, hay, other, chick, eggCrates)
    createAnimalElements()
  else
    for k, v in pairs(inv) do
      table.insert(currentFarmInventory, {
        k,
        seexports.sItems:getItemName(k),
        v,
        seexports.sItems:getItemWeight(k) * v
      })
    end
    crateElement = invEl
  end
  if not pos then
    setElementPosition(localPlayer, x, y, z)
  end
end)
function syncFarmC(data)
  for x = 1, farmSizeDetails[currentSize].size[1] do
    for y = 1, farmSizeDetails[currentSize].size[2] do
      for k = 1, #landData[x][y].objects do
        if isElement(landData[x][y].objects[k]) then
          destroyElement(landData[x][y].objects[k])
        end
        landData[x][y].objects[k] = nil
      end
    end
  end
  landData = data
  for x = 1, farmSizeDetails[currentSize].size[1] do
    for y = 1, farmSizeDetails[currentSize].size[2] do
      landData[x][y].fromWetness = landData[x][y].wetness
      landData[x][y].lastWatering = getTickCount()
      if landData[x][y].plant then
        landData[x][y].plant.startTime = getTickCount() - (landData[x][y].plant.elasped or 0)
      end
    end
  end
  createObjects()
  drawFarmRT()
end
local dealRoboto = false
function initDealerNPCs()
  local skins = {
    302,
    304,
    306,
    259,
    272,
    242,
    248,
    221,
    236,
    211,
    204,
    183,
    192,
    160,
    133,
    307,
    1,
    2
  }
  shuffleTable(skins)
  local position = {
    [380] = {
      "Felvásárló",
      skins[1],
      -2606.3999,
      2263.2,
      8.2,
      0.003
    },
    [389] = {
      "Felvásárló",
      skins[2],
      -2613.5,
      2263.3,
      8.2,
      0.003
    },
    [388] = {
      "Felvásárló",
      skins[3],
      -2610.7,
      2263.1001,
      8.2,
      0.003
    },
    [387] = {
      "Felvásárló",
      skins[4],
      -2617.6001,
      2263.3,
      8.2,
      0
    },
    [378] = {
      "Felvásárló",
      skins[5],
      -2621.2,
      2263.3,
      8.2,
      0
    },
    [379] = {
      "Felvásárló",
      skins[6],
      -2630,
      2268.3999,
      8.2,
      270.003
    },
    [375] = {
      "Felvásárló",
      skins[7],
      -2629.8,
      2264.3,
      8.2,
      270.003
    },
    [377] = {
      "Felvásárló",
      skins[8],
      -2629.3999,
      2260.3,
      8.2,
      270.003
    },
    [376] = {
      "Felvásárló",
      skins[9],
      -2628.8,
      2255.5,
      8.2,
      270.003
    },
    [386] = {
      "Felvásárló",
      skins[10],
      -2620.6001,
      2260.1001,
      8.2,
      180.003
    },
    [385] = {
      "Felvásárló",
      skins[11],
      -2617.5,
      2259.8999,
      8.2,
      178.003
    },
    [384] = {
      "Felvásárló",
      skins[12],
      -2614.1001,
      2259.8999,
      8.2,
      176.003
    },
    [383] = {
      "Felvásárló",
      skins[13],
      -2609.5,
      2260,
      8.2,
      182.003
    },
    [382] = {
      "Felvásárló",
      skins[14],
      -2606.1001,
      2260,
      8.2,
      189.753
    },
    [381] = {
      "Felvásárló",
      skins[15],
      -2607.8999,
      2248.7,
      8.2,
      13.753
    },
    [587] = {
      "Felvásárló",
      skins[16],
      -2612.2,
      2248.3,
      8.2,
      0
    },
    [588] = {
      "Felvásárló",
      skins[17],
      -2617.3,
      2248.3999,
      8.2,
      0
    },
    [585] = {
      "Felvásárló",
      skins[18],
      -2622.2,
      2249,
      8.1,
      346.003
    }
  }
  for k, v in pairs(position) do
    local dealerNPC = createPed(v[2], v[3], v[4], v[5], v[6])
    setElementFrozen(dealerNPC, true)
    setElementData(dealerNPC, "farmDealer", k)
    setElementData(dealerNPC, "invulnerable", true)
    setElementData(dealerNPC, "visibleName", v[1])
    setElementData(dealerNPC, "pedNameType", seexports.sItems:getItemName(k))
  end
end
local inDeal = false
local cameraInterpolation = {}
local minigameStarted = false
function renderDeal()
  local progress = (getTickCount() - cameraInterpolation.start) / 3000
  local x, y, z = cameraInterpolation.to[1], cameraInterpolation.to[2], cameraInterpolation.to[3]
  local x2, y2, z2 = cameraInterpolation.to[4], cameraInterpolation.to[5], cameraInterpolation.to[6]
  local a = 1
  if progress < 1 then
    x, y, z = interpolateBetween(cameraInterpolation.from[1], cameraInterpolation.from[2], cameraInterpolation.from[3], cameraInterpolation.to[1], cameraInterpolation.to[2], cameraInterpolation.to[3], progress, "InOutQuad")
    x2, y2, z2 = interpolateBetween(cameraInterpolation.from[4], cameraInterpolation.from[5], cameraInterpolation.from[6], cameraInterpolation.to[4], cameraInterpolation.to[5], cameraInterpolation.to[6], progress, "InOutQuad")
    a = interpolateBetween(0, 0, 0, 1, 0, 0, progress, "InOutQuad")
  end
  setCameraMatrix(x, y, z, x2, y2, z2)
  dxDrawRectangle(screenX / 2 - 200, screenY / 2 + 150 - 40, 400, 80, tocolor(0, 0, 0, 150 * a))
  dxDrawRectangle(screenX / 2 - 200, screenY / 2 + 150 - 40, 400, 30, tocolor(0, 0, 0, 255 * a))
  dxDrawText("Eladás: " .. inDeal[2] .. "db (" .. inDeal[4] .. "kg) " .. inDeal[3], 0, screenY / 2 + 150 - 40, screenX, screenY / 2 + 150 - 40 + 30, tocolor(green[1], green[2], green[3], 255 * a), 0.85, dealRoboto, "center", "center", false, false, false, true)
  dxDrawRectangle(screenX / 2 - 200, screenY / 2 + 150 - 40 + 100, 400, 50, tocolor(0, 0, 0, 150 * a))
  dxDrawText("Tartsd lenyomva a " .. greenHex .. "[SPACE]#ffffff gombot, majd engedd\nfel, amikor a nyíl a " .. greenHex .. "zöld#ffffff mezőbe ér.", 0, screenY / 2 + 150 - 40 + 100, screenX, screenY / 2 + 150 - 40 + 150, tocolor(255, 255, 255, 255 * a), 0.85, dealRoboto, "center", "center", false, false, false, true)
  local price = pricePerPCS[inDeal[5]]
  if minigameStarted then
    local minigameProgress = (getTickCount() - minigameStarted[1]) / minigameStarted[2]
    local w = 380 * minigameStarted[3]
    local w2 = 380 * minigameStarted[5]
    local w3 = 380 * minigameStarted[6]
    local x = screenX / 2 - 200 + 10
    local y = screenY / 2 + 150 - 10 + 25 + 5
    local cx = x + minigameProgress * 380
    local color = tocolor(215, 89, 89, 255)
    price = pricePerPCS[inDeal[5]] - minigameStarted[4]
    if cx >= x + w + w2 / 2 + w3 then
      color = tocolor(215, 89, 89, 255)
    elseif cx >= x + w + w2 / 2 then
      color = tocolor(255, 155, 0, 255)
      price = pricePerPCS[inDeal[5]]
    elseif cx >= x + w - w2 / 2 then
      color = tocolor(green[1], green[2], green[3], 255)
      price = pricePerPCS[inDeal[5]] + minigameStarted[4]
    elseif cx >= x + w - w2 / 2 - w3 then
      color = tocolor(255, 155, 0, 255)
      price = pricePerPCS[inDeal[5]]
    end
    seelangStaticImageUsed[4] = true
    if seelangStaticImageToc[4] then
      processSeelangStaticImage[4]()
    end
    dxDrawImage(cx - 7, y - 14 - 2, 14, 14, seelangStaticImage[4], 0, 0, 0, color)
    dxDrawRectangle(x, y, 380, 15, tocolor(215, 89, 89, 255))
    dxDrawRectangle(x + w - w2 / 2 - w3, y, w3, 15, tocolor(255, 155, 0, 255))
    dxDrawRectangle(x + w - w2 / 2, y, w2, 15, tocolor(green[1], green[2], green[3], 255))
    dxDrawRectangle(x + w + w2 / 2, y, w3, 15, tocolor(255, 155, 0, 255))
    if not getKeyState("space") or 1 <= minigameProgress then
      removeEventHandler("onClientRender", getRootElement(), renderDeal)
      setCameraTarget(localPlayer)
      minigameProgress = 1
      triggerServerEvent("sellFarmItem", localPlayer, inDeal[1], price)
      minigameStarted = false
      inDeal = false
    end
  elseif 1 <= progress and getKeyState("space") then
    minigameStarted = {
      getTickCount(),
      math.random(800, 1200),
      math.random(250, 750) / 1000,
      math.max(math.ceil(pricePerPCS[inDeal[5]] * 0.25), 1),
      math.random(60, 80) / 1000,
      math.random(140, 160) / 1000
    }
  end
  dxDrawRectangle(screenX / 2 - 200 + 10, screenY / 2 + 150 - 10 + 25 + 5, 380, 15, tocolor(0, 0, 0, 100 * a))
  dxDrawText(price .. "$/db", 0, screenY / 2 + 150 - 10, screenX, screenY / 2 + 150 - 10 + 25, tocolor(green[1], green[2], green[3], 255 * a), 0.85, dealRoboto, "center", "center", false, false, false, true)
end
function startFarmDeal(dbID, item, amount, npc)
  if not inDeal then
    if pricePerPCS[item] then
      seexports.sItems:toggleInventory(false)
      inDeal = {
        dbID,
        amount,
        seexports.sItems:getItemName(item),
        seexports.sItems:getItemWeight(item) * amount,
        item
      }
      addEventHandler("onClientRender", getRootElement(), renderDeal)
      cameraInterpolation.start = getTickCount()
      cameraInterpolation.from = {
        getCameraMatrix()
      }
      local x, y, z = getElementPosition(npc)
      local rx, ry, rz = getElementRotation(npc)
      local ox, oy = rotateAround(rz, -1, 1.5, 0, 0)
      cameraInterpolation.to = {
        x + ox,
        y + oy,
        z + 0.7,
        x,
        y,
        z + 0.5
      }
      dealRoboto = dxCreateFont("files/roboto.ttf", 14, false, "antialiased")
    else
      seexports.sGui:showInfobox("e", "Csak termést fogad el az NPC.")
    end
  end
end
local changingFarmType = false
local farmWindow = false
local windowHeight = 100
local windowWidth = 350
addEvent("farmTypeAnimal", true)
addEventHandler("farmTypeAnimal", getRootElement(), function()
  if farmWindow then
    seexports.sGui:deleteGuiElement(farmWindow)
  end
  farmWindow = false
  triggerServerEvent("changeFarmType", localPlayer, changingFarmType, 2)
  changingFarmType = false
end)
addEvent("farmTypePlant", true)
addEventHandler("farmTypePlant", getRootElement(), function()
  if farmWindow then
    seexports.sGui:deleteGuiElement(farmWindow)
  end
  farmWindow = false
  triggerServerEvent("changeFarmType", localPlayer, changingFarmType, 1)
  changingFarmType = false
end)
addEvent("promptFarmTypeChange", true)
addEventHandler("promptFarmTypeChange", getRootElement(), function(farmId)
  if not changingFarmType then
    changingFarmType = farmId
    if farmWindow then
      seexports.sGui:deleteGuiElement(farmWindow)
    end
    local titleBarHeight = seexports.sGui:getTitleBarHeight()
    farmWindow = seexports.sGui:createGuiElement("window", screenX / 2 - windowWidth / 2, screenY / 2 - windowHeight / 2, windowWidth, windowHeight)
    seexports.sGui:setWindowTitle(farmWindow, "16/BebasNeueRegular.otf", "SightMTA - Farm")
    local label = seexports.sGui:createGuiElement("label", 5, 15, windowWidth - 10, windowHeight - 30 - 5, farmWindow)
    seexports.sGui:setLabelAlignment(label, "center", "center")
    seexports.sGui:setLabelText(label, "Mivel szeretnél foglalkozni?")
    local btn = seexports.sGui:createGuiElement("button", 5, windowHeight - 30 - 5, (windowWidth - 15) / 2, 30, farmWindow)
    seexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
    seexports.sGui:setGuiHover(btn, "gradient", {
      "sightgreen",
      "sightgreen-second"
    }, false, true)
    seexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
    seexports.sGui:setButtonTextColor(btn, "#ffffff")
    seexports.sGui:setButtonText(btn, "Állattartás")
    seexports.sGui:setClickEvent(btn, "farmTypeAnimal", false)
    local btn = seexports.sGui:createGuiElement("button", 5 + (windowWidth - 15) / 2 + 5, windowHeight - 30 - 5, (windowWidth - 15) / 2, 30, farmWindow)
    seexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
    seexports.sGui:setGuiHover(btn, "gradient", {
      "sightgreen",
      "sightgreen-second"
    }, false, true)
    seexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
    seexports.sGui:setButtonTextColor(btn, "#ffffff")
    seexports.sGui:setButtonText(btn, "Növénytermesztés")
    seexports.sGui:setClickEvent(btn, "farmTypePlant", false)
  end
end)
addEvent("farmEnterExitSound", true)
addEventHandler("farmEnterExitSound", getRootElement(), function(x, y, z, int, dim)
  local sound = playSound3D("files/door/1.mp3", x, y, z, false)
  setElementInterior(sound, int)
  setElementDimension(sound, dim)
  setSoundMaxDistance(sound, 30)
end)