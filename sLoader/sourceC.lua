local sightexports = {
  sDashboard = false,
  sGui = false,
  sModloader = false,
  sVehiclemods = false,
  sGroups = false,
  sPreloader = false,
  sCore = false 
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
local sightlangStatImgHand = false
local sightlangStaticImage = {}
local sightlangStaticImageToc = {}
local sightlangStaticImageUsed = {}
local sightlangStaticImageDel = {}
local processsightlangStaticImage = {}
sightlangStaticImageToc[0] = true
sightlangStaticImageToc[1] = true
local sightlangStatImgPre
function sightlangStatImgPre()
  local now = getTickCount()
  if sightlangStaticImageUsed[0] then
    sightlangStaticImageUsed[0] = false
    sightlangStaticImageDel[0] = false
  elseif sightlangStaticImage[0] then
    if sightlangStaticImageDel[0] then
      if now >= sightlangStaticImageDel[0] then
        if isElement(sightlangStaticImage[0]) then
          destroyElement(sightlangStaticImage[0])
        end
        sightlangStaticImage[0] = nil
        sightlangStaticImageDel[0] = false
        sightlangStaticImageToc[0] = true
        return
      end
    else
      sightlangStaticImageDel[0] = now + 5000
    end
  else
    sightlangStaticImageToc[0] = true
  end
  if sightlangStaticImageUsed[1] then
    sightlangStaticImageUsed[1] = false
    sightlangStaticImageDel[1] = false
  elseif sightlangStaticImage[1] then
    if sightlangStaticImageDel[1] then
      if now >= sightlangStaticImageDel[1] then
        if isElement(sightlangStaticImage[1]) then
          destroyElement(sightlangStaticImage[1])
        end
        sightlangStaticImage[1] = nil
        sightlangStaticImageDel[1] = false
        sightlangStaticImageToc[1] = true
        return
      end
    else
      sightlangStaticImageDel[1] = now + 5000
    end
  else
    sightlangStaticImageToc[1] = true
  end
  if sightlangStaticImageToc[0] and sightlangStaticImageToc[1] then
    sightlangStatImgHand = false
    removeEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre)
  end
end
processsightlangStaticImage[0] = function()
  if not isElement(sightlangStaticImage[0]) then
    sightlangStaticImageToc[0] = false
    sightlangStaticImage[0] = dxCreateTexture("files/spin.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[1] = function()
  if not isElement(sightlangStaticImage[1]) then
    sightlangStaticImageToc[1] = false
    sightlangStaticImage[1] = dxCreateTexture("files/vignette.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
local sightlangWaiterState0 = false
local function sightlangProcessResWaiters()
  if not sightlangWaiterState0 then
    local res0 = getResourceFromName("sPreloader")
    if res0 and getResourceState(res0) == "running" then
      waitForPreloader()
      sightlangWaiterState0 = true
    end
  end
end
if triggerServerEvent then
  addEventHandler("onClientResourceStart", getRootElement(), sightlangProcessResWaiters)
end
if triggerClientEvent then
  addEventHandler("onResourceStart", getRootElement(), sightlangProcessResWaiters)
end
local sightgrey3 = false
local sightyellow = false
local sightgreen = false
local function sightlangGuiRefreshColors()
  local res = getResourceFromName("sGui")
  if res and getResourceState(res) == "running" then
    sightgrey3 = sightexports.sGui:getColorCodeToColor("sightgrey3")
    sightyellow = sightexports.sGui:getColorCodeToColor("sightyellow")
    sightgreen = sightexports.sGui:getColorCodeToColor("sightgreen")
  end
end
addEventHandler("onGuiRefreshColors", getRootElement(), sightlangGuiRefreshColors)
addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangGuiRefreshColors)
local sightlangCondHandlState3 = false
local function sightlangCondHandl3(cond, prio)
  cond = cond and true or false
  if cond ~= sightlangCondHandlState3 then
    sightlangCondHandlState3 = cond
    if cond then
      addEventHandler("onClientRender", getRootElement(), renderFileLoader, true, prio)
    else
      removeEventHandler("onClientRender", getRootElement(), renderFileLoader)
    end
  end
end
local sightlangCondHandlState2 = false
local function sightlangCondHandl2(cond, prio)
  cond = cond and true or false
  if cond ~= sightlangCondHandlState2 then
    sightlangCondHandlState2 = cond
    if cond then
      addEventHandler("onClientLazyRender", getRootElement(), renderLoader, true, prio)
    else
      removeEventHandler("onClientLazyRender", getRootElement(), renderLoader)
    end
  end
end
local sightlangCondHandlState1 = false
local function sightlangCondHandl1(cond, prio)
  cond = cond and true or false
  if cond ~= sightlangCondHandlState1 then
    sightlangCondHandlState1 = cond
    if cond then
      addEventHandler("onClientPreRender", getRootElement(), getBasicFonts, true, prio)
    else
      removeEventHandler("onClientPreRender", getRootElement(), getBasicFonts)
    end
  end
end
local sightlangCondHandlState0 = false
local function sightlangCondHandl0(cond, prio)
  cond = cond and true or false
  if cond ~= sightlangCondHandlState0 then
    sightlangCondHandlState0 = cond
    if cond then
      addEventHandler("onClientMTAFocusChange", getRootElement(), focusChange, true, prio)
    else
      removeEventHandler("onClientMTAFocusChange", getRootElement(), focusChange)
    end
  end
end
addEvent("streamerModeChanged", false)
addEvent("onGuiRefreshColors", false)
addEvent("refreshFaTicks", false)
addEvent("refreshGradientTick", false)
addEvent("modloaderLoaded", false)
addEvent("refreshSeeringZone", false)
addEvent("onClientPlayerStreamIn", false)
addEvent("onClientPedStreamIn", false)
addEvent("onClientVehicleStreamIn", false)
addEvent("onClientObjectStreamIn", false)
addEvent("onClientPlayerStreamOut", false)
addEvent("onClientPedStreamOut", false)
addEvent("onClientVehicleStreamOut", false)
addEvent("onClientObjectStreamOut", false)
addEvent("onClientPedDestroy", false)
addEvent("onClientVehicleDestroy", false)
addEvent("onClientObjectDestroy", false)
addEvent("onClientPlayerDataChange", false)
addEvent("onClientPedDataChange", false)
addEvent("onClientVehicleDataChange", false)
addEvent("onClientObjectDataChange", false)
addEvent("onClientPlayerModelChange", false)
addEvent("onClientPedModelChange", false)
addEvent("onClientVehicleModelChange", false)
addEvent("onClientObjectModelChange", false)
addEvent("onLocalPlayerCCTVColShapeHit", false)
addEvent("onLocalPlayerCCTVColShapeLeave", false)
addEvent("requestCCTVSyncZonesClient", false)
math.randomseed(getRealTime().timestamp)
for i = 1, 100 do
  math.random()
end
local defaultColorSet = {
  hudwhite = {
    255,
    255,
    255
  },
  sightgrey1 = {
    26,
    27,
    31
  },
  sightgrey2 = {
    35,
    39,
    42
  },
  sightgrey3 = {
    51,
    53,
    61
  },
  sightgrey4 = {
    30,
    33,
    36
  },
  sightmidgrey = {
    84,
    86,
    93
  },
  sightlightgrey = {
    186,
    190,
    196
  },
  sightgreen = {
    60,
    184,
    130
  },
  ["sightgreen-second"] = {
    60,
    184,
    170
  },
  sightred = {
    243,
    90,
    90
  },
  ["sightred-second"] = {
    250,
    120,
    95
  },
  sightblue = {
    49,
    154,
    215
  },
  ["sightblue-second"] = {
    49,
    180,
    225
  },
  sightyellow = {
    243,
    214,
    90
  },
  ["sightyellow-second"] = {
    250,
    240,
    130
  },
  sightorange = {
    255,
    149,
    20
  },
  ["sightorange-second"] = {
    250,
    179,
    40
  },
  sightpurple = {
    148,
    60,
    184
  },
  ["sightpurple-second"] = {
    182,
    76,
    226
  }
}
local inFocus = true
function focusChange(state)
  inFocus = state
end
sightlangCondHandl0(true)
local minimizedTimer = setTimer(function()
  if not inFocus then
    renderLoader()
  end
end, 10, 0)
for k, v in pairs(defaultColorSet) do
  sightexports.sCore:registerChatColor(k, tocolor(v[1], v[2], v[3]))
end
local res = getResourceFromName("sLast")
local resourcesLoader = not res or getResourceState(res) ~= "running"
local extraLoader = false
local extraLoadRequested = false
local currentExtraLoad = 0
local extraLoaderDoneAnim = false
local extraLoaders = {
  {
    "Modok véglegesítése",
    "modloaderLoad"
  },
  {
    "Mapolások betöltése",
    "loadingMaps"
  },
  {
    "Vizek betöltése",
    "loadingWaters"
  },
  {
    "Interiorok betöltése",
    "loadingInteriors"
  },
--  {
--    "Placedo üzenetek betöltése",
--    "loadingPlacedo"
--  },
  {
    "Hírek betöltése",
    "loadingNews"
  },
  {
    "Széfek betöltése",
    "loadingSafes"
  },
--  {
--    "Billiárdasztalok betöltése",
--    "loadingBilliard"
--  },
  {
    "Kapuk betöltése",
    "loadingGates"
  },
  {
    "Kukák betöltése",
    "loadingTrashes"
  },
  {
    "Dashboard beállítások betöltése",
    "loadDashSettings"
  },
  {
    "Betűtípusok betöltése",
    "getBasicFonts"
  },
  {
    "Felület betöltése",
    "refreshColors"
  }
}
local extraLoaderProg = false
function extraLoaderProgress(event, prog, text)
  if extraLoaders[currentExtraLoad] and extraLoaders[currentExtraLoad][2] == event then
    extraLoaderProg = prog
    if text then
      extraLoaders[currentExtraLoad][1] = text
    end
  end
end
addEvent("extraLoaderProgress", true)
addEventHandler("extraLoaderProgress", getRootElement(), extraLoaderProgress)
addEvent("extraLoaderDone", true)
addEventHandler("extraLoaderDone", getRootElement(), function(done)
  if extraLoaders[currentExtraLoad] and extraLoaders[currentExtraLoad][2] == done then
    extraLoaderDoneAnim = true
  end
end)
addEvent("extraLoadStart:loadDashSettings", false)
addEventHandler("extraLoadStart:loadDashSettings", getRootElement(), function()
  sightexports.sDashboard:loadSettings()
end)
addEvent("extraLoadStart:modloaderLoad", false)
addEventHandler("extraLoadStart:modloaderLoad", getRootElement(), function()
  triggerEvent("modloaderLoaded", getRootElement())
end)
addEventHandler("modloaderLoaded", getRootElement(), function()
  setTimer(triggerEvent, 500, 1, "extraLoaderDone", localPlayer, "modloaderLoad")
end, true, "low-999999999")
addEvent("extraLoadStart:refreshColors", false)
addEventHandler("extraLoadStart:refreshColors", getRootElement(), function()
  if not sightexports.sDashboard:loadColorset() then
    sightexports.sGui:setRefreshColors()
  end
end)
addEvent("onGuiRefreshColors", false)
addEventHandler("onGuiRefreshColors", getRootElement(), function()
  setTimer(triggerEvent, 500, 1, "extraLoaderDone", localPlayer, "refreshColors")
end, true, "low-999999999")
local basicFontList = {
  "10/BebasNeueBold.otf",
  "10/BebasNeueLight.otf",
  "10/BebasNeueRegular.otf",
  "10/Ubuntu-B.ttf",
  "10/Ubuntu-L.ttf",
  "10/Ubuntu-R.ttf",
  "11/BebasNeueBold.otf",
  "11/BebasNeueRegular.otf",
  "11/Ubuntu-B.ttf",
  "11/Ubuntu-L.ttf",
  "11/Ubuntu-LI.ttf",
  "11/Ubuntu-R.ttf",
  "12/BebasNeueBold.otf",
  "12/BebasNeueLight.otf",
  "12/BebasNeueRegular.otf",
  "12/Ubuntu-B.ttf",
  "12/Ubuntu-L.ttf",
  "12/Ubuntu-LI.ttf",
  "12/Ubuntu-R.ttf",
  "13/BebasNeueBold.otf",
  "13/BebasNeueRegular.otf",
  "13/Ubuntu-L.ttf",
  "13/Ubuntu-R.ttf",
  "14/BebasNeueBold.otf",
  "14/BebasNeueRegular.otf",
  "14/Ubuntu-L.ttf",
  "14/Ubuntu-R.ttf",
  "15/BebasNeueBold.otf",
  "15/BebasNeueRegular.otf",
  "15/Ubuntu-L.ttf",
  "16/BebasNeueBold.otf",
  "16/BebasNeueRegular.otf",
  "16/Ubuntu-R.ttf",
  "17/BebasNeueBold.otf",
  "17/BebasNeueRegular.otf",
  "17/Ubuntu-L.ttf",
  "18/BebasNeueBold.otf",
  "18/BebasNeueRegular.otf",
  "18/Ubuntu-B.ttf",
  "19/BebasNeueBold.otf",
  "19/BebasNeueRegular.otf",
  "20/BebasNeueBold.otf",
  "20/BebasNeueLight.otf",
  "20/BebasNeueRegular.otf",
  "20/Ubuntu-R.ttf",
  "22/BebasNeueBold.otf",
  "22/BebasNeueRegular.otf",
  "23/BebasNeueRegular.otf",
  "24/BebasNeueLight.otf",
  "24/BebasNeueRegular.otf"
}
local fontsToLoad = #basicFontList
function getBasicFonts()
  if basicFontList[1] then
    sightexports.sGui:getFont(basicFontList[1])
    table.remove(basicFontList, 1)
    extraLoaderProgress("getBasicFonts", (fontsToLoad - #basicFontList) / fontsToLoad, "Betűtípusok betöltése (" .. fontsToLoad - #basicFontList .. "/" .. fontsToLoad .. ")")
  else
    sightlangCondHandl1(false)
    triggerEvent("extraLoaderDone", localPlayer, "getBasicFonts")
  end
end
addEvent("extraLoadStart:getBasicFonts", false)
addEventHandler("extraLoadStart:getBasicFonts", getRootElement(), function()
  sightlangCondHandl1(true)
end)
local fadeIn = false
local logo = dxCreateTexture("files/logo/base.dds")
local font, fontScale, fontBig, fontBigScale
local iconsToCache = {
  {
    "exclamation",
    24
  },
  {"check", 48},
  {
    "money-bill-wave",
    32
  },
  {
    "gem",
    32,
    "regular"
  },
  {
    "paper-plane",
    32
  },
  {
    "undo",
    24,
    "solid"
  },
  {
    "gavel",
    28,
    "solid"
  },
  {"save", 24},
  {"undo", 24},
  {"angle-up", 24},
  {
    "album-collection",
    48,
    "regular"
  },
  {
    "circle",
    24,
    "solid"
  },
  {"circle", 56},
  {"camera", 32},
  {"wrench", 30},
  {"gas-pump", 30},
  {"search", 48},
  {
    "circle-notch",
    32
  },
  {
    "circle-notch",
    48
  },
  {
    "circle-notch",
    64
  },
  {"snowflake", 48},
  {"sign-in", 40},
  {"info", 32},
  {"power-off", 32},
  {"sync", 24},
  {"share-alt", 24},
  {"info", 24},
  {
    "trash-alt",
    24,
    "regular"
  },
  {
    "file-image",
    24,
    "regular"
  },
  {
    "save",
    24,
    "regular"
  },
  {"tv", 24},
  {"clock", 24},
  {
    "map-marker-alt",
    32
  },
  {
    "folder-open",
    32,
    "regular"
  },
  {"ellipsis-v", 24},
  {
    "envelope",
    32,
    "regular"
  },
  {
    "envelope",
    32,
    "solid"
  },
  {
    "map-marker-alt",
    24
  },
  {"comment", 32},
  {
    "trash",
    32,
    "solid"
  },
  {
    "folder-open",
    32,
    "solid"
  },
  {
    "times",
    32,
    "solid"
  },
  {
    "circle",
    56,
    "solid"
  },
  {"phone", 28},
  {
    "plus",
    24,
    "solid"
  },
  {
    "star",
    24,
    "solid"
  },
  {
    "star",
    24,
    "regular"
  },
  {
    "star",
    28,
    "solid"
  },
  {
    "star",
    28,
    "regular"
  },
  {
    "car-mechanic",
    64,
    "solid"
  },
  {
    "car-mechanic",
    64,
    "light"
  },
  {
    "eye",
    24,
    "regular"
  },
  {
    "eye-slash",
    24,
    "regular"
  },
  {"boxes", 24},
  {"backspace", 16},
  {
    "shopping-cart",
    16,
    "regular"
  },
  {"sun", 32},
  {"snowflake", 32},
  {"comment", 30},
  {"car", 30},
  {"home", 30},
  {
    "exclamation-triangle",
    30
  },
  {"archive", 30},
  {"user-times", 30},
  {"siren", 64},
  {"siren-on", 64},
  {"slash", 64},
  {
    "slash",
    64,
    "regular"
  },
  {"waveform", 64},
  {
    "waveform",
    64,
    "light"
  },
  {"bullhorn", 64},
  {
    "bullhorn",
    64,
    "regular"
  },
  {
    "walkie-talkie",
    64
  },
  {
    "walkie-talkie",
    64,
    "regular"
  },
  {
    "exclamation-triangle",
    30,
    "solid"
  },
  {"check", 30},
  {
    "exclamation-circle",
    48,
    "solid"
  },
  {
    "info-circle",
    48,
    "solid"
  },
  {
    "question-circle",
    48,
    "solid"
  },
  {
    "times",
    24,
    "solid"
  },
  {"search", 30},
  {"tags", 28},
  {"bell", 24},
  {"hand-rock", 24},
  {"key", 24},
  {
    "shopping-cart",
    28
  },
  {"caret-up", 32},
  {"caret-down", 32},
  {"desktop", 32},
  {"lock", 32},
  {"unlock", 32},
  {"undo", 32},
  {"redo", 32},
  {"eye-slash", 32},
  {
    "chevron-circle-left",
    32
  },
  {
    "question-circle",
    32
  },
  {"user", 30},
  {"arrow-down", 32},
  {"minus", 16},
  {"plus", 16},
  {"users", 24},
  {"list", 24},
  {"minus", 24},
  {"pen", 24},
  {"home", 40},
  {"users", 40},
  {"id-badge", 40},
  {"car", 40},
  {"building", 40},
  {"pen", 32},
  {"save", 32},
  {
    "circle-notch",
    64
  },
  {"check", 24},
  {"circle", 32},
  {
    "circle",
    32,
    "regular"
  },
  {"car", 32},
  {"building", 32},
  {"user-tie", 32},
  {"box", 32},
  {"bolt", 32},
  {"user-tag", 24},
  {"user-plus", 24},
  {
    "user-shield",
    32
  },
  {"bone-break", 32},
  {"raindrops", 32},
  {"search", 32},
  {
    "circle-notch",
    32
  },
  {"heart-rate", 32},
  {"trash-alt", 32},
  {"plus", 24},
  {"copy", 24},
  {
    "circle",
    16,
    "solid"
  },
  {
    "circle",
    16,
    "regular"
  },
  {"caret-left", 16},
  {
    "caret-right",
    16
  },
  {"caret-left", 32},
  {
    "caret-right",
    32
  },
  {"caret-left", 24},
  {
    "caret-right",
    24
  },
  {"check", 32},
  {
    "lock",
    24,
    "solid"
  },
  {
    "lock-open",
    24,
    "solid"
  },
  {
    "chevron-up",
    24,
    "solid"
  },
  {
    "chevron-down",
    24,
    "solid"
  },
  {"gas-pump", 64},
  {"gas-pump", 28},
  {
    "dollar-sign",
    32
  },
  {"gem", 32},
  {
    "shopping-cart",
    32
  },
  {"fish", 32},
  {"times", 32},
  {"angle-left", 48},
  {
    "angle-right",
    48
  },
  {"radio", 48},
  {"arrow-up", 32},
  {"user", 24},
  {
    "chevron-left",
    64
  },
  {"male", 64},
  {"female", 64},
  {
    "chevron-right",
    64
  },
  {"plus", 44},
  {"hand-paper", 44},
  {
    "chevron-double-up",
    44
  },
  {
    "microphone",
    40,
    "solid"
  },
  {"phone", 32},
  {
    "ambulance",
    24,
    "solid"
  },
  {
    "ambulance",
    32,
    "solid"
  },
  {
    "ambulance",
    48,
    "solid"
  },
  {
    "car",
    24,
    "solid"
  },
  {
    "car",
    32,
    "solid"
  },
  {
    "car",
    48,
    "solid"
  },
  {
    "wrench",
    24,
    "solid"
  },
  {
    "wrench",
    32,
    "solid"
  },
  {
    "wrench",
    48,
    "solid"
  },
  {
    "taxi",
    24,
    "solid"
  },
  {
    "taxi",
    32,
    "solid"
  },
  {
    "taxi",
    48,
    "solid"
  },
  {
    "phone",
    24,
    "solid"
  },
  {
    "phone",
    32,
    "solid"
  },
  {
    "phone",
    48,
    "solid"
  },
  {"phone", 24},
  {
    "address-book",
    24
  },
  {"trash-alt", 24},
  {
    "circle",
    22,
    "regular"
  },
  {
    "chevron-left",
    22,
    "solid"
  },
  {
    "heart",
    22,
    "solid"
  },
  {
    "camera",
    22,
    "solid"
  },
  {
    "broadcast-tower",
    64,
    "solid"
  },
  {
    "times",
    36,
    "solid"
  },
  {
    "compress-alt",
    36
  },
  {"expand-alt", 36},
  {
    "eye",
    36,
    "regular"
  },
  {
    "shopping-cart",
    32,
    "solid"
  },
  {
    "cart-plus",
    32,
    "regular"
  },
  {
    "arrow-alt-left",
    30
  },
  {
    "arrow-alt-right",
    30
  },
  {"user", 64},
  {"unlock-alt", 64},
  {"search", 64},
  {"user", 64},
  {"unlock-alt", 64},
  {"unlock-alt", 64},
  {
    "envelope-open-text",
    64
  },
  {
    "envelope-open-text",
    64
  }
}
local iconsNum = false
local mist, render, wire
local logoTextures = {}
function destroyResourceLoader()
  for i = 1, #logoTextures do
    if isElement(logoTextures[i]) then
      destroyElement(logoTextures[i])
    end
    logoTextures[i] = nil
  end
end
function initResourceLoader()
  destroyResourceLoader()
  logoTextures = {
    dxCreateTexture("files/logo/0.dds"),
    dxCreateTexture("files/logo/1.dds"),
    dxCreateTexture("files/logo/2.dds"),
    dxCreateTexture("files/logo/base.dds")
  }
end
local modelLoaderShaderSource = " texture renderTexture; sampler renderSampler = sampler_state { Texture = <renderTexture>; }; texture mistTexture; sampler mistSampler = sampler_state { Texture = <mistTexture>; }; float prog = 0; float feather = 0.1; float4 PixelShaderFunction(float4 Diffuse : COLOR0, float2 TexCoord : TEXCOORD0) : COLOR0 { float4 render = tex2D(renderSampler, TexCoord); float4 mist = tex2D(mistSampler, TexCoord); if(mist.r > prog) return 0; else if(mist.r > prog-feather) return float4(render.r, render.g, render.b, render.a*(1-(mist.r - (prog-feather))/feather)); else return render; } technique Technique1 { pass Pass1 { PixelShader = compile ps_2_0 PixelShaderFunction(); } } "
local carShaderSource = " texture renderTexture; sampler renderSampler = sampler_state { Texture = <renderTexture>; }; texture wireTexture; sampler wireSampler = sampler_state { Texture = <wireTexture>; }; float prog = 0; float feather = 0.1; float4 PixelShaderFunction(float4 Diffuse : COLOR0, float2 TexCoord : TEXCOORD0) : COLOR0 { float4 render = tex2D(renderSampler, TexCoord); float4 wire = tex2D(wireSampler, TexCoord); if(TexCoord.x > prog) return wire; else if(TexCoord.x > prog-feather) { float p = (TexCoord.x - (prog-feather))/feather; return lerp(wire, render, 1-p*p); } else return render; } technique Technique1 { pass Pass1 { PixelShader = compile ps_2_0 PixelShaderFunction(); } } "
local carShaderSource = " texture renderTexture; sampler renderSampler = sampler_state { Texture = <renderTexture>; }; texture wireTexture; sampler wireSampler = sampler_state { Texture = <wireTexture>; }; float prog = 0; float feather = 0.1; float4 PixelShaderFunction(float4 Diffuse : COLOR0, float2 TexCoord : TEXCOORD0) : COLOR0 { float4 render = tex2D(renderSampler, TexCoord); float4 wire = tex2D(wireSampler, TexCoord); if(TexCoord.x > prog) return wire; else if(TexCoord.x > prog-feather) { float p = (TexCoord.x - (prog-feather))/feather; return lerp(wire, render, 1-p*p); } else return render; } technique Technique1 { pass Pass1 { PixelShader = compile ps_2_0 PixelShaderFunction(); } } "
local skinShaderSource = " texture renderTexture; sampler renderSampler = sampler_state { Texture = <renderTexture>; }; texture wireTexture; sampler wireSampler = sampler_state { Texture = <wireTexture>; }; texture cloudTexture; sampler cloudSampler = sampler_state { Texture = <cloudTexture>; }; float prog = 0; float feather = 0.1; float4 PixelShaderFunction(float4 Diffuse : COLOR0, float2 TexCoord : TEXCOORD0) : COLOR0 { float4 render = tex2D(renderSampler, TexCoord); float4 wire = tex2D(wireSampler, TexCoord); float4 cloud = tex2D(cloudSampler, TexCoord); float c = 1-cloud.r; if(c > prog) return wire; else if(c > prog-feather) { float p = (c - (prog-feather))/feather; return lerp(wire, render, 1-p*p); } else return render; } technique Technique1 { pass Pass1 { PixelShader = compile ps_2_0 PixelShaderFunction(); } } "
local modelLoader = false
local modelsToLoad = false
local modelsLoaded = false
function destroyModelLoader()
  if isElement(mist) then
    destroyElement(mist)
  end
  mist = false
  if isElement(render) then
    destroyElement(render)
  end
  render = false
  if isElement(wire) then
    destroyElement(wire)
  end
  wire = false
  if isElement(modelLoaderShader) then
    destroyElement(modelLoaderShader)
  end
  modelLoaderShader = false
  modelsToLoad = false
  modelsLoaded = false
end
function startModelLoader()
  destroyResourceLoader()
  destroyModelLoader()
  local id = math.random(1, 12)
  render = dxCreateTexture("files/models/models" .. id .. ".dds", "dxt5")
  mist = dxCreateTexture("files/models/models" .. id .. "_mist.dds", "argb")
  wire = dxCreateTexture("files/models/models" .. id .. "_wireframe.dds", "dxt5")
  modelLoaderShader = dxCreateShader(modelLoaderShaderSource)
  dxSetShaderValue(modelLoaderShader, "mistTexture", mist)
  dxSetShaderValue(modelLoaderShader, "renderTexture", render)
  dxSetShaderValue(modelLoaderShader, "prog", 0)
  modelsLoaded = false
  modelsToLoad = sightexports.sModloader:countModels("object")
  modelLoader = true
  fadeIn = true
end
local skinShader = false
local skinTextures = {}
local carShader = false
local carTextures = {}
local carLoader = false
local carImgLoaded = false
local carImgToLoad = false
function destroyCarLoader()
  for i = 1, #carTextures do
    if isElement(carTextures[i]) then
      destroyElement(carTextures[i])
    end
    carTextures[i] = nil
  end
  if isElement(carShader) then
    destroyElement(carShader)
  end
  carShader = false
  modelsToLoad = false
  modelsLoaded = false
  carImgLoaded = false
  carImgToLoad = false
end
function createCarLoader()
  destroyCarLoader()
  destroyModelLoader()
  local r = math.random(1, 3)
  carTextures = {
    dxCreateTexture("files/cars/car_render" .. r .. "_wireframe.dds", "dxt5"),
    dxCreateTexture("files/cars/car_render" .. r .. ".dds", "dxt5"),
    dxCreateTexture("files/cars/car_render" .. r .. "_lights.dds", "dxt5")
  }
  carLoader = true
  fadeIn = getTickCount()
  carShader = dxCreateShader(carShaderSource)
  dxSetShaderValue(carShader, "wireTexture", carTextures[1])
  dxSetShaderValue(carShader, "renderTexture", carTextures[2])
  dxSetShaderValue(carShader, "prog", 0)
  modelsLoaded = false
  modelsToLoad = sightexports.sModloader:countModels("vehicle")
  carImgLoaded = 0
  carImgToLoad = sightexports.sVehiclemods:getVehicleCount() + 1
end
local skinsLoaded = false
local skinsToLoad = false
function destroySkinLoader()
  for i = 1, #skinTextures do
    if isElement(skinTextures[i]) then
      destroyElement(skinTextures[i])
    end
    skinTextures[i] = nil
  end
  if isElement(skinShader) then
    destroyElement(skinShader)
  end
  skinShader = false
  modelsLoaded = false
  modelsToLoad = false
  skinsLoaded = false
  skinsToLoad = false
end
local skinLoader = false
function createSkinLoader()
  destroyCarLoader()
  destroySkinLoader()
  local id = math.random(1, 9)
  wire = dxCreateTexture("files/skins/skins" .. id .. "_wireframe.dds", "dxt5")
  render = dxCreateTexture("files/skins/skins" .. id .. ".dds", "dxt5")
  cloud = dxCreateTexture("files/skins/skins_noise.dds", "dxt1")
  skinLoader = true
  fadeIn = true
  skinShader = dxCreateShader(skinShaderSource)
  dxSetShaderValue(skinShader, "wireTexture", wire)
  dxSetShaderValue(skinShader, "renderTexture", render)
  dxSetShaderValue(skinShader, "cloudTexture", cloud)
  dxSetShaderValue(skinShader, "prog", 0)
  modelsLoaded = false
  modelsToLoad = sightexports.sModloader:countModels("skin")
  skinsLoaded = 0
  skinsToLoad = sightexports.sGroups:countGroupSkins()
end
local nextLoaderCycle = false
local nextLoaderTime = 0
local iconLoader = false
local icons = false
function destroyIconLoader()
  if isElement(icons) then
    destroyElement(icons)
  end
end
function createIconLoader()
  destroyIconLoader()
  icons = dxCreateTexture("files/icons.png")
  iconLoader = true
  fadeIn = true
end
function skinGroupLoaderCycle()
  if sightexports.sGroups:loadAGroupSkin() then
    skinsLoaded = skinsLoaded + 1
    nextLoaderCycle = skinGroupLoaderCycle
    nextLoaderTime = getTickCount() + 25
  else
    skinsLoaded = skinsToLoad
    skinLoader = getTickCount()
    nextLoaderCycle = false
  end
end
function skinLoaderCycle()
  local res = sightexports.sModloader:loadAModel("skin")
  if res == "pending" then
    nextLoaderCycle = skinLoaderCycle
    nextLoaderTime = getTickCount() + 25
  elseif res then
    modelsLoaded = modelsLoaded + 1
    nextLoaderCycle = skinLoaderCycle
    nextLoaderTime = getTickCount() + 25
  else
    nextLoaderCycle = skinGroupLoaderCycle
    nextLoaderTime = getTickCount() + 25
  end
end
function carImgLoaderCycle()
  if carImgLoaded == 0 then
    carImgLoaded = carImgLoaded + 1
    nextLoaderTime = getTickCount() + 25
  elseif sightexports.sVehiclemods:loadVehicleModel() then
    carImgLoaded = carImgLoaded + 1
    nextLoaderCycle = carImgLoaderCycle
    nextLoaderTime = getTickCount() + 50
  else
    carImgLoaded = carImgToLoad
    carLoader = getTickCount()
    nextLoaderCycle = false
  end
end
function carLoaderCycle()
  local res = sightexports.sModloader:loadAModel("vehicle")
  if res == "pending" then
    nextLoaderCycle = carLoaderCycle
    nextLoaderTime = getTickCount() + 50
  elseif res then
    modelsLoaded = modelsLoaded + 1
    nextLoaderCycle = carLoaderCycle
    nextLoaderTime = getTickCount() + 50
  else
    modelsLoaded = modelsToLoad
    nextLoaderCycle = carImgLoaderCycle
  end
end
function modelLoaderCycle()
  local res = sightexports.sModloader:loadAModel("object")
  if res == "pending" then
    nextLoaderCycle = modelLoaderCycle
    nextLoaderTime = getTickCount()
  elseif res then
    modelsLoaded = modelsLoaded + 1
    nextLoaderCycle = modelLoaderCycle
    nextLoaderTime = getTickCount()
  else
    modelsLoaded = modelsToLoad
    modelLoader = getTickCount()
    nextLoaderCycle = false
  end
end
function iconLoaderCycle()
  if 0 < #iconsToCache then
    sightexports.sGui:getFaIconFilename(iconsToCache[1][1], iconsToCache[1][2], iconsToCache[1][3])
    table.remove(iconsToCache, 1)
    nextLoaderCycle = iconLoaderCycle
    nextLoaderTime = getTickCount() + 25
  else
    iconLoader = getTickCount()
    nextLoaderCycle = false
  end
end
local loadedRes = 0
local resNum = 144
local insideFont = false
local insideFontBig = false
local fontOutside = false
function processFont(force)
  local res = getResourceFromName("sGui")
  local tmp = res and getResourceState(res) == "running"
  if fontOutside ~= tmp or force then
    fontOutside = tmp
    if fontOutside then
      if isElement(insideFont) then
        destroyElement(insideFont)
      end
      insideFont = nil
      if isElement(insideFontBig) then
        destroyElement(insideFontBig)
      end
      insideFontBig = nil
      font = sightexports.sGui:getFont("15/BebasNeueBold.otf")
      fontScale = sightexports.sGui:getFontScale("15/BebasNeueBold.otf")
      fontBig = sightexports.sGui:getFont("25/BebasNeueBold.otf")
      fontBigScale = sightexports.sGui:getFontScale("25/BebasNeueBold.otf")
      insideFont = false
      insideFontBig = false
    else
      if isElement(insideFont) then
        destroyElement(insideFont)
      end
      insideFont = nil
      if isElement(insideFontBig) then
        destroyElement(insideFontBig)
      end
      insideFontBig = nil
      font = dxCreateFont("files/BebasNeueBold.otf", 30, false, "antialiased")
      fontScale = 0.5
      fontBig = dxCreateFont("files/BebasNeueBold.otf", 50, false, "antialiased")
      fontBigScale = 0.5
      insideFont = font
      insideFontBig = fontBig
    end
  end
end
processFont(true)
initResourceLoader()
if not resourcesLoader then
  startModelLoader()
end
addEventHandler("onClientResourceStop", getRootElement(), function()
  loadedRes = loadedRes - 1
end)
function cancelChatMessage()
  cancelEvent()
end
local res = getResourceFromName("sGui")
local tmp = res and getResourceState(res) == "running"
if not tmp then
  addEventHandler("onClientChatMessage", getRootElement(), cancelChatMessage)
end
addEventHandler("onClientResourceStart", getRootElement(), function(res)
  loadedRes = loadedRes + 1
  local name = getResourceName(res)
  if name == "sLast" then
    resourcesLoader = getTickCount()
    removeEventHandler("onClientChatMessage", getRootElement(), cancelChatMessage)
    sightlangCondHandl2(false)
  elseif name == "sGui" then
    processFont(true)
  elseif name == "sLoader" then
  end
end)
local screenX, screenY = guiGetScreenSize()
function shuffleTable(t)
  local rand = math.random
  local iterations = #t
  local j
  for i = iterations, 2, -1 do
    j = rand(i)
    t[i], t[j] = t[j], t[i]
  end
  return t
end
addEventHandler("onClientResourceStop", getResourceRootElement(), function()
  destroyModelLoader()
  destroyIconLoader()
  destroyResourceLoader()
end)
local firstLoaderColors = {
  {
    60,
    184,
    130
  },
  {
    243,
    90,
    90
  },
  {
    49,
    154,
    215
  },
  {
    243,
    214,
    90
  },
  {
    255,
    149,
    20
  },
  {
    148,
    60,
    184
  },
  {
    60,
    184,
    130
  },
  {
    243,
    90,
    90
  },
  {
    49,
    154,
    215
  },
  {
    243,
    214,
    90
  },
  {
    255,
    149,
    20
  },
  {
    148,
    60,
    184
  },
  {
    60,
    184,
    130
  },
  {
    243,
    90,
    90
  },
  {
    49,
    154,
    215
  },
  {
    243,
    214,
    90
  },
  {
    255,
    149,
    20
  },
  {
    148,
    60,
    184
  },
  {
    60,
    184,
    130
  },
  {
    243,
    90,
    90
  },
  {
    49,
    154,
    215
  },
  {
    243,
    214,
    90
  },
  {
    255,
    149,
    20
  },
  {
    148,
    60,
    184
  }
}
local firstLoaderSort = {}
for i = 1, 20 do
  table.insert(firstLoaderSort, i)
end
shuffleTable(firstLoaderSort)
shuffleTable(firstLoaderColors)
local loadingFiles = 1
local loadedFiles = 1
local fileLoaderState = false
addEventHandler("onClientTransferBoxProgressChange", getRootElement(), function(d, t)
  loadedFiles = d
  loadingFiles = t
  fileLoaderState = true
  sightlangCondHandl3(true, "low-99999999999")
end)
addEventHandler("onClientTransferBoxVisibilityChange", getRootElement(), function(isVisible)
  fileLoaderState = isVisible
  sightlangCondHandl3(isVisible, "low-99999999999")
end)
function renderFileLoader()
  loadedFiles = math.max(1, loadedFiles)
  local p = loadedFiles / math.max(loadedFiles, loadingFiles)
  local w = resourcesLoader and screenX - 48 or screenX / 4
  dxDrawRectangle(screenX / 2 - w / 2, screenY - 96 - 8, w, 8, sightgrey3 or tocolor(51, 53, 61))
  dxDrawRectangle(screenX / 2 - w / 2, screenY - 96 - 8, w * p, 8, sightgreen or tocolor(60, 184, 130))
  dxDrawText("Fájlok letöltése (" .. formatBytes(loadedFiles) .. "/" .. formatBytes(math.max(loadedFiles, loadingFiles)) .. ")", screenX / 2 - w / 2, 0, 0, screenY - 96 - 8 - 14, tocolor(255, 255, 255), fontScale, font, "left", "bottom")
end
local byteSuffix = {
  "B",
  "KB",
  "MB",
  "GB",
  "TB"
}
function formatBytes(size)
  if size ~= size then
    return "0 B"
  end
  local base = math.log(size) / math.log(1024)
  local fbase = math.floor(base)
  return math.floor(math.pow(1024, base - fbase) * 100 + 0.5) / 100 .. (byteSuffix[1 + fbase] or "")
end
local endLoader = false
addEvent("receiveBanState", true)
addEventHandler("receiveBanState", getRootElement(), function()
  if endLoader then
    if getElementData(localPlayer, "loggedIn") then
      showChat(true)
      endLoader = false
      removeEventHandler("onClientRender", getRootElement(), renderLoader, true, "low-9999999999")
      sightlangCondHandl2(false)
      if isElement(logo) then
        destroyElement(logo)
      end
      logo = nil
      sightlangCondHandl0(false)
      if isTimer(minimizedTimer) then
        killTimer(minimizedTimer)
      end
      minimizedTimer = nil
    else
      endLoader = getTickCount()
    end
  end
end)
local fadedOut = false
function renderLoader()
  if isChatVisible() then
    showChat(false)
  end
  local now = getTickCount()
  local fade = 1
  if fadeIn then
    if not tonumber(fadeIn) then
      fadeIn = now
    end
    fade = (now - fadeIn) / 1000
    if 1 < fade then
      fade = 1
      fadeIn = false
    end
  end
  local p = 0
  if not endLoader then
    dxDrawRectangle(0, 0, screenX, screenY, tocolor(26, 27, 31))
  end
  local loadingText = ""
  if resourcesLoader then
    if resNum then
      p = math.min(1, loadedRes / resNum)
    end
    loadingText = "SightMTA betöltése (" .. math.floor(100 * p) .. "%)"
    local y = screenY / 2 - 272
    dxDrawImage(screenX / 2 - 256, y, 512, 512, logoTextures[4], 0, 0, 0, tocolor(51, 53, 61, 200))
    for i = 1, 3 do
      if p > (i - 1) / 3 then
        local a = math.min(1, (p - (i - 1) / 3) * 3) * 255
        dxDrawImage(screenX / 2 - 256, y, 512, 512, logoTextures[i], 0, 0, 0, tocolor(255, 255, 255, a))
      end
    end
    sightlangStaticImageUsed[0] = true
    if sightlangStaticImageToc[0] then
      processsightlangStaticImage[0]()
    end
    dxDrawImage(screenX / 2 - 16, y + 512, 32, 32, sightlangStaticImage[0], now / 5 % 360, 0, 0, tocolor(60, 184, 130))
    if tonumber(resourcesLoader) then
      fade = 1 - (now - resourcesLoader) / 1000
      if fade < 0 then
        fade = 0
        if fadedOut then
          resourcesLoader = false
          startModelLoader()
        else
          fadedOut = true
        end
      else
        fadedOut = false
      end
    end
  elseif modelLoader then
    p = (modelsLoaded or 0) / modelsToLoad
    loadingText = "Modellek betöltése (" .. math.floor(100 * p) .. "%)"
    dxSetShaderValue(modelLoaderShader, "prog", p)
    dxDrawImage(0, screenY / 2 - screenX / 2, screenX, screenX, wire)
    dxDrawImage(0, screenY / 2 - screenX / 2, screenX, screenX, modelLoaderShader)
    if tonumber(modelLoader) then
      fade = 1 - (now - modelLoader) / 1000
      if fade < 0 then
        fade = 0
        if fadedOut then
          modelLoader = false
          destroyModelLoader()
          createCarLoader()
        else
          fadedOut = true
        end
      else
        fadedOut = false
      end
    end
  elseif carLoader then
    p = ((modelsLoaded or 0) + carImgLoaded) / (modelsToLoad + carImgToLoad)
    loadingText = "Járművek betöltése (" .. math.floor(100 * p) .. "%)"
    local w = screenX
    local h = w * 0.5625
    if 0.75 < p then
      dxDrawImage(screenX / 2 - w / 2, screenY / 2 - h / 2, w, h, carTextures[2])
      dxDrawImage(screenX / 2 - w / 2, screenY / 2 - h / 2, w, h, carTextures[3], 0, 0, 0, tocolor(255, 255, 255, 255 * math.min(1, 1.35 * (p - 0.75) / 0.25)))
    else
      dxSetShaderValue(carShader, "prog", p / 0.75)
      dxDrawImage(screenX / 2 - w / 2, screenY / 2 - h / 2, w, h, carShader)
    end
    if tonumber(carLoader) then
      fade = 1 - (now - carLoader) / 1000
      if fade < 0 then
        fade = 0
        if fadedOut then
          carLoader = false
          destroyCarLoader()
          createSkinLoader()
        else
          fadedOut = true
        end
      else
        fadedOut = false
      end
    end
  elseif skinLoader then
    p = ((modelsLoaded or 0) + skinsLoaded) / (modelsToLoad + skinsToLoad)
    loadingText = "Skinek betöltése (" .. math.floor(100 * p) .. "%)"
    dxSetShaderValue(skinShader, "prog", p)
    dxDrawImage(screenX / 2 - screenY / 2, 0, screenY, screenY, skinShader)
    if tonumber(skinLoader) then
      fade = 1 - (now - skinLoader) / 1000
      if fade < 0 then
        fade = 0
        if fadedOut then
          skinLoader = false
          destroySkinLoader()
          createIconLoader()
        else
          fadedOut = true
        end
      else
        fadedOut = false
      end
    end
  elseif iconLoader then
    p = 0
    if iconsNum then
      p = 1 - #iconsToCache / iconsNum
    end
    loadingText = "Ikonok betöltése (" .. math.floor(100 * p) .. "%)"
    local h = screenX * 0.05
    local x = getTickCount() % 30000 / 30000
    dxDrawImageSection(0, screenY / 2 - h / 2, screenX, h, 3840 * x, 0, 3840, 192, icons, 0, 0, 0, tocolor(51, 53, 61))
    for j = 1, #firstLoaderSort do
      local i = firstLoaderSort[j]
      if p > (j - 1) / 20 then
        local a = math.min(1, (p - (j - 1) / 20) * 20) * 255
        dxDrawImageSection(-screenX * x + h * (i - 1), screenY / 2 - h / 2, h, h, 192 * (i - 1), 0, 192, 192, icons, 0, 0, 0, tocolor(firstLoaderColors[i][1], firstLoaderColors[i][2], firstLoaderColors[i][3], a))
        dxDrawImageSection(screenX - screenX * x + h * (i - 1), screenY / 2 - h / 2, h, h, 192 * (i - 1), 0, 192, 192, icons, 0, 0, 0, tocolor(firstLoaderColors[i][1], firstLoaderColors[i][2], firstLoaderColors[i][3], a))
      end
    end
    if tonumber(iconLoader) then
      fade = 1 - (now - iconLoader) / 1000
      if fade < 0 then
        fade = 0
        if fadedOut then
          destroyIconLoader()
          iconLoader = false
          extraLoader = true
          fadeIn = true
        else
          fadedOut = true
        end
      else
        fadedOut = false
      end
    end
  elseif extraLoader then
    local curr = math.max(1, currentExtraLoad)
    local a = 0
    if extraLoaderDoneAnim then
      if not tonumber(extraLoaderDoneAnim) then
        extraLoaderDoneAnim = now
      end
      a = (now - extraLoaderDoneAnim) / 500
      if 1 < a then
        a = 1
        extraLoadRequested = false
      else
        a = getEasingValue(a, "InOutQuad")
      end
      if extraLoaders[curr + 1] then
        local w1 = dxGetTextWidth(extraLoaders[curr][1], fontBigScale, fontBig)
        local w2 = dxGetTextWidth(extraLoaders[curr + 1][1], fontBigScale, fontBig)
        local w = w1 + (w2 - w1) * a
        sightlangStaticImageUsed[0] = true
        if sightlangStaticImageToc[0] then
          processsightlangStaticImage[0]()
        end
        dxDrawImage(screenX / 2 - 24 + w / 2 + 16, screenY / 2 - 16, 32, 32, sightlangStaticImage[0], now / 5 % 360, 0, 0, tocolor(60, 184, 130))
      else
        local w = dxGetTextWidth(extraLoaders[curr][1], fontBigScale, fontBig)
        sightlangStaticImageUsed[0] = true
        if sightlangStaticImageToc[0] then
          processsightlangStaticImage[0]()
        end
        dxDrawImage(screenX / 2 - 24 + w / 2 + 16, screenY / 2 - 16, 32, 32, sightlangStaticImage[0], now / 5 % 360, 0, 0, tocolor(60, 184, 130, 255 * (1 - a)))
      end
    elseif extraLoaders[curr] then
      local w = dxGetTextWidth(extraLoaders[curr][1], fontBigScale, fontBig)
      sightlangStaticImageUsed[0] = true
      if sightlangStaticImageToc[0] then
        processsightlangStaticImage[0]()
      end
      dxDrawImage(screenX / 2 - 24 + w / 2 + 16, screenY / 2 - 16, 32, 32, sightlangStaticImage[0], now / 5 % 360, 0, 0, tocolor(60, 184, 130))
    end
    p = math.min(1, (curr - 1 + math.max(extraLoaderProg or 0, a)) / #extraLoaders)
    local y = screenY / 2
    if extraLoaders[curr] then
      dxDrawText(extraLoaders[curr][1], -24, y - 48 * a, screenX - 24, y - 48 * a, tocolor(255, 255, 255, 255 * fade * (1 - a)), fontBigScale, fontBig, "center", "center")
    end
    local n = math.floor((screenY / 2 - 48) / 48) - 1
    for i = 1, n do
      if extraLoaders[curr + i] then
        y = y + 48
        local posP = (i - a) / n
        local pX = 0
        if i == 1 then
          pX = 24 * a
        end
        dxDrawText(extraLoaders[curr + i][1], 0 - pX, y - 48 * a, screenX - pX, y - 48 * a, tocolor(255, 255, 255, 255 * (1 - posP) * fade), fontBigScale * (1 - posP * 0.25), fontBig, "center", "center")
      end
    end
    loadingText = "Betöltés véglegesítése (" .. math.floor(100 * p) .. "%)"
    if tonumber(extraLoader) then
      fade = 1 - (now - extraLoader) / 1000
      if fade < 0 then
        fade = 0
        if fadedOut then
          extraLoader = false
          triggerServerEvent("checkPlayerBanState", localPlayer)
          endLoader = true
        else
          fadedOut = true
        end
      else
        fadedOut = false
      end
    end
  end
  if endLoader then
    local fade = 1
    local p = 0
    local x, y, s = screenX - 48 - 108, screenY - 24 - 8 - 128, 128
    if tonumber(endLoader) then
      p = (now - endLoader) / 1500
      if 1 < p then
        fade = 1 - (p - 1)
        if fade < 0 then
          fade = 0
          endLoader = false
          removeEventHandler("onClientRender", getRootElement(), renderLoader, true, "low-9999999999")
          sightlangCondHandl2(false)
          if isElement(logo) then
            destroyElement(logo)
          end
          logo = nil
          sightlangCondHandl0(false)
          if isTimer(minimizedTimer) then
            killTimer(minimizedTimer)
          end
          minimizedTimer = nil
        end
        p = 1
      else
        p = getEasingValue(p, "InOutQuad")
      end
      s = 128 + 92 * p
      x = x + (screenX / 2 - s / 2 - x) * p
      y = y + (math.floor(screenY * 0.25) - s / 2 - y) * p
    end
    dxDrawRectangle(0, screenY / 2 - screenX / 2, screenX, screenX, tocolor(26, 27, 31, 255 * fade))
    sightlangStaticImageUsed[1] = true
    if sightlangStaticImageToc[1] then
      processsightlangStaticImage[1]()
    end
    dxDrawImage(0, 0, screenX, screenY, sightlangStaticImage[1], 0, 0, 0, tocolor(255, 255, 255, 255 * fade))
    dxDrawRectangle(24, screenY - 24 - 8, screenX - 48, 8, tocolor(51, 53, 61, 255 * (1 - p)))
    if logo then
      dxDrawImage(x, y, s, s, logo, 0, 0, 0, tocolor(255, 255, 255, 255 * math.min(1, fade * 3)))
    end
  else
    if fade < 1 then
      dxDrawRectangle(0, screenY / 2 - screenX / 2, screenX, screenX, tocolor(26, 27, 31, 255 * (1 - fade)))
    end
    sightlangStaticImageUsed[1] = true
    if sightlangStaticImageToc[1] then
      processsightlangStaticImage[1]()
    end
    dxDrawImage(0, 0, screenX, screenY, sightlangStaticImage[1], 0, 0, 0, tocolor(255, 255, 255, 255))
    dxDrawRectangle(24, screenY - 24 - 8, screenX - 48, 8, tocolor(51, 53, 61))
    dxDrawRectangle(24, screenY - 24 - 8, (screenX - 48) * p, 8, tocolor(60, 184, 130, 255 * fade))
    dxDrawText(loadingText, 24, 0, 0, screenY - 24 - 8 - 14, tocolor(255, 255, 255, 255 * fade), fontScale, font, "left", "bottom")
    if not (resourcesLoader and fileLoaderState) or not (loadedFiles < loadingFiles) then
      dxDrawImage(screenX - 48 - 108, screenY - 24 - 8 - 128, 128, 128, logo)
    end
  end
  if nextLoaderCycle and nextLoaderTime and 0 < now - nextLoaderTime then
    nextLoaderCycle()
  elseif iconLoader and not iconsNum and not fadeIn then
    iconsNum = #iconsToCache
    iconLoaderCycle()
  elseif modelLoader and not modelsLoaded and not fadeIn then
    modelsLoaded = 0
    modelLoaderCycle()
  elseif carLoader and not modelsLoaded and not fadeIn then
    modelsLoaded = 0
    carLoaderCycle()
  elseif skinLoader and not modelsLoaded and not fadeIn then
    modelsLoaded = 0
    skinLoaderCycle()
  elseif extraLoader and not fadeIn and not extraLoadRequested then
    extraLoadRequested = true
    extraLoaderDoneAnim = false
    currentExtraLoad = currentExtraLoad + 1
    if not extraLoaders[currentExtraLoad] then
      extraLoader = getTickCount()
    else
      extraLoaderProg = false
      triggerEvent("extraLoadStart:" .. extraLoaders[currentExtraLoad][2], localPlayer)
    end
  end
  if resourcesLoader and loadedFiles < loadingFiles then
    renderFileLoader()
  end
end
addEventHandler("onClientRender", getRootElement(), renderLoader, true, "low-999999999")
sightlangCondHandl2(resourcesLoader and true or false)
nextLoaderCycle = false
function waitForPreloader()
  sightexports.sPreloader:endPreloader()
end
