local sightexports = {
  sGui = false,
  sHud = false,
  sWeather = false,
  sCore = false,
  sPavilion = false,
  sGroups = false,
  sMarkers = false
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
local sightlangWaiterState0 = false
local function sightlangProcessResWaiters()
  if not sightlangWaiterState0 then
    local res0 = getResourceFromName("sMarkers")
    if res0 and getResourceState(res0) == "running" then
      createBincoMarkers()
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
local screenX, screenY = guiGetScreenSize()
local currentBinco = false
local wardrobeGui = false
local currentSkinCat = "Férfi"
local currentSkin = 1
local previewPed = false
local groups = false
local groupsLoading = false
local idles = {
  "shift",
  "stretch",
  "strleg",
  "time"
}
local bincoButtons = {}
function nextWardrobeIdleAnimation()
  if previewPed then
    setPedAnimation(previewPed, "playidles", idles[math.random(#idles)], -1, false, false)
  end
end
addEvent("bincoSkinSelect", false)
addEventHandler("bincoSkinSelect", getRootElement(), function(button, state, absoluteX, absoluteY, el, n)
  currentSkin = currentSkin + n
  if currentSkin < 1 then
    currentSkin = #availableSkins[currentSkinCat]
  elseif currentSkin > #availableSkins[currentSkinCat] then
    currentSkin = 1
  end
  setElementModel(previewPed, availableSkins[currentSkinCat][currentSkin])
  nextWardrobeIdleAnimation()
end)
addEvent("bincoSetCategory", false)
addEventHandler("bincoSetCategory", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  if bincoButtons[el] then
    currentSkinCat = bincoButtons[el]
    currentSkin = 1
    setElementModel(previewPed, availableSkins[currentSkinCat][currentSkin])
    nextWardrobeIdleAnimation()
    for btn, cat in pairs(bincoButtons) do
      if el == btn then
        sightexports.sGui:setImageColor(btn, "sightgreen")
        sightexports.sGui:setGuiHoverable(btn, false)
      else
        sightexports.sGui:setImageColor(btn, "#ffffff")
        sightexports.sGui:setGuiHoverable(btn, true)
      end
    end
  end
end)
function deleteBincoGui()
  bincoButtons = {}
  if wardrobeGui then
    sightexports.sGui:deleteGuiElement(wardrobeGui)
  end
  wardrobeGui = nil
end
function createBinco()
  deleteBincoGui()
  local h = 48
  local w = h * 5
  wardrobeGui = sightexports.sGui:createGuiElement("rectangle", screenX / 2 - h * 2, screenY * 0.9 - h, w, h, wardrobeGui)
  sightexports.sGui:setGuiBackground(wardrobeGui, "solid", "sightgrey1")
  local bw = 24 + sightexports.sGui:getTextWidthFont(" Vásárlás (250 $)", "11/BebasNeueBold.otf") + 4
  local bw2 = sightexports.sGui:getTextWidthFont("Mégsem", "11/BebasNeueBold.otf") + 8
  local btn = sightexports.sGui:createGuiElement("button", w / 2 - (bw + bw2 + 6) / 2, h + 6, bw, 24, wardrobeGui)
  sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
  sightexports.sGui:setGuiHover(btn, "gradient", {
    "sightgreen",
    "sightgreen-second"
  }, false, true)
  sightexports.sGui:setButtonFont(btn, "11/BebasNeueBold.otf")
  sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("shopping-cart", 24))
  sightexports.sGui:setButtonText(btn, " Vásárlás (250 $)")
  sightexports.sGui:setClickEvent(btn, "bincoGuiFinal")
  sightexports.sGui:setClickArgument(btn, true)
  local btn = sightexports.sGui:createGuiElement("button", w / 2 - (bw + bw2 + 6) / 2 + bw + 6, h + 6, bw2, 24, wardrobeGui)
  sightexports.sGui:setGuiBackground(btn, "solid", "sightred")
  sightexports.sGui:setGuiHover(btn, "gradient", {
    "sightred",
    "sightred-second"
  }, false, true)
  sightexports.sGui:setButtonFont(btn, "11/BebasNeueBold.otf")
  sightexports.sGui:setButtonText(btn, "Mégsem")
  sightexports.sGui:setClickEvent(btn, "bincoGuiFinal")
  local previousButton = sightexports.sGui:createGuiElement("image", 0, 0, h, h, wardrobeGui)
  sightexports.sGui:setImageFile(previousButton, sightexports.sGui:getFaIconFilename("chevron-left", h))
  sightexports.sGui:setGuiHoverable(previousButton, not groupsLoading)
  sightexports.sGui:setGuiHover(previousButton, "solid", "sightgreen")
  sightexports.sGui:setClickEvent(previousButton, "bincoSkinSelect")
  sightexports.sGui:setClickArgument(previousButton, -1)
  local btn = sightexports.sGui:createGuiElement("image", h, 0, h, h, wardrobeGui)
  sightexports.sGui:setImageFile(btn, sightexports.sGui:getFaIconFilename("male", h))
  sightexports.sGui:setGuiHover(btn, "solid", "sightgreen")
  sightexports.sGui:setClickEvent(btn, "bincoSetCategory")
  bincoButtons[btn] = "Férfi"
  if currentSkinCat == "Férfi" then
    sightexports.sGui:setImageColor(btn, "sightgreen")
  else
    sightexports.sGui:setGuiHoverable(btn, not groupsLoading)
  end
  sightexports.sGui:guiSetTooltip(btn, "Férfi skinek")
  local btn = sightexports.sGui:createGuiElement("image", h * 2, 0, h, h, wardrobeGui)
  sightexports.sGui:setImageFile(btn, sightexports.sGui:getFaIconFilename("female", h))
  sightexports.sGui:setGuiHover(btn, "solid", "sightgreen")
  sightexports.sGui:setClickEvent(btn, "bincoSetCategory")
  bincoButtons[btn] = "Női"
  if currentSkinCat == "Női" then
    sightexports.sGui:setImageColor(btn, "sightgreen")
  else
    sightexports.sGui:setGuiHoverable(btn, not groupsLoading)
  end
  sightexports.sGui:guiSetTooltip(btn, "Női skinek")
  if groupsLoading then
    local loaderIcon = sightexports.sGui:createGuiElement("image", h * 3 + 5, 5, h - 10, h - 10, wardrobeGui)
    sightexports.sGui:setImageFile(loaderIcon, sightexports.sGui:getFaIconFilename("circle-notch", h - 10))
    sightexports.sGui:setImageSpinner(loaderIcon, true)
  else
    local btn = sightexports.sGui:createGuiElement("image", h * 3 + 2, 2, h - 4, h - 4, wardrobeGui)
    sightexports.sGui:setImageFile(btn, sightexports.sGui:getFaIconFilename("users", h))
    sightexports.sGui:setGuiHoverable(btn, true)
    if groups then
      bincoButtons[btn] = "Frakció"
      sightexports.sGui:setClickEvent(btn, "bincoSetCategory")
      if currentSkinCat == "Frakció" then
        sightexports.sGui:setImageColor(btn, "sightgreen")
      else
      end
      sightexports.sGui:setGuiHover(btn, "solid", "sightgreen")
      sightexports.sGui:guiSetTooltip(btn, "Frakció skinek")
    else
      sightexports.sGui:setImageColor(btn, "sightmidgrey")
      sightexports.sGui:setGuiHover(btn, "solid", "sightmidgrey")
      sightexports.sGui:guiSetTooltip(btn, "Nem tudsz egy frakció skint sem felvenni")
    end
  end
  local nextButton = sightexports.sGui:createGuiElement("image", h * 4, 0, h, h, wardrobeGui)
  sightexports.sGui:setImageFile(nextButton, sightexports.sGui:getFaIconFilename("chevron-right", h))
  sightexports.sGui:setGuiHoverable(nextButton, not groupsLoading)
  sightexports.sGui:setGuiHover(nextButton, "solid", "sightgreen")
  sightexports.sGui:setClickEvent(nextButton, "bincoSkinSelect")
  sightexports.sGui:setClickArgument(nextButton, 1)
end
function deleteBinco(reCreate)
  deleteBincoGui()
  if isElement(previewPed) then
    destroyElement(previewPed)
  end
  previewPed = nil
  if currentBinco then
    if not reCreate then
      triggerServerEvent("bincoExit", localPlayer, currentBinco)
    end
    lastExit = currentBinco
    showChat(true)
    showCursor(false)
    sightexports.sHud:setHudEnabled(true, 1000)
    setCameraTarget(localPlayer)
    setElementFrozen(localPlayer, false)
    setElementInterior(localPlayer, availableShops[currentBinco][4])
    setElementDimension(localPlayer, availableShops[currentBinco][5])
    sightexports.sWeather:resetWeather()
    removeEventHandler("onClientPreRender", getRootElement(), preRenderBinco)
    currentBinco = false
  end
end
addEvent("bincoGuiFinal", true)
addEventHandler("bincoGuiFinal", getRootElement(), function(button, state, absoluteX, absoluteY, el, buy)
  if buy and sightexports.sCore:getMoney() < 250 then
    sightexports.sGui:showInfobox("e", "Nincs elég pénzed!")
    return
  end
  deleteBinco()
  if buy then
    local skin = false
    if currentSkinCat == "Frakció" then
      if groups then
        skin = groups[currentSkin]
      end
    else
      skin = availableSkins[currentSkinCat][currentSkin]
    end
    if skin then
      triggerServerEvent("bincoBuySkin", localPlayer, skin)
    end
  end
end)
function preRenderBinco()
  setTime(12, 0)
  setWeather(0)
  setCameraMatrix(258.25390625, -39.514453125, 1002.85, 256.8984375, -42.7890625, 1002.0234375)
end
function initBinco(id)
  deleteBinco(true)
  triggerServerEvent("getPlayerMoney", localPlayer)
  triggerServerEvent("bincoEnter", localPlayer, id)
  currentBinco = id
  groupsLoading = true
  local dutySkin = getElementData(localPlayer, "permGroupSkin")
  if not dutySkin then
    currentSkinCat = "Férfi"
    currentSkin = 1
    local skin = getElementModel(localPlayer)
    local found = false
    for i = 1, #availableSkins["Férfi"] do
      if availableSkins["Férfi"][i] == skin then
        currentSkinCat = "Férfi"
        currentSkin = i
        found = true
        break
      end
    end
    if not found then
      for i = 1, #availableSkins["Női"] do
        if availableSkins["Női"][i] == skin then
          currentSkinCat = "Női"
          currentSkin = i
          break
        end
      end
    end
  end
  addEventHandler("onClientPreRender", getRootElement(), preRenderBinco)
  showChat(false)
  showCursor(true)
  sightexports.sHud:setHudEnabled(false, 1000)
  setElementFrozen(localPlayer, true)
  local id = getElementData(localPlayer, "playerID")
  previewPed = createPed(availableSkins[currentSkinCat][currentSkin], 256.8984375, -42.7890625, 1002.0234375, -20)
  sightexports.sPavilion:disablePedHeadmove(previewPed)
  setElementInterior(previewPed, 14)
  setElementDimension(previewPed, id)
  setElementInterior(localPlayer, 14)
  setElementDimension(localPlayer, id)
  createBinco()
  triggerLatentServerEvent("requestGroupsForBinco", localPlayer)
end
addEvent("gotGroupSkinsForBinco", true)
addEventHandler("gotGroupSkinsForBinco", getRootElement(), function(skins)
  if wardrobeGui then
    groups = skins
    groupsLoading = false
    local dutySkin = getElementData(localPlayer, "permGroupSkin")
    local reset = false
    if skins then
      availableSkins["Frakció"] = {}
      for i = #skins, 1, -1 do
        local model = sightexports.sGroups:getGroupSkinId(skins[i][1] .. skins[i][2])
        if model then
          table.insert(availableSkins["Frakció"], 1, model)
        else
          table.remove(skins, i)
        end
      end
      if dutySkin then
        currentSkinCat = "Frakció"
        currentSkin = 1
        for i = 1, #skins do
          if skins[i][1] .. skins[i][2] == dutySkin then
            currentSkin = i
            break
          end
        end
      end
    else
      reset = dutySkin and true or false
    end
    if reset then
      currentSkinCat = "Férfi"
      currentSkin = 1
      local skin = getElementModel(localPlayer)
      local found = false
      for i = 1, #availableSkins["Férfi"] do
        if availableSkins["Férfi"][i] == skin then
          currentSkinCat = "Férfi"
          currentSkin = i
          found = true
          break
        end
      end
      if not found then
        for i = 1, #availableSkins["Női"] do
          if availableSkins["Női"][i] == skin then
            currentSkinCat = "Női"
            currentSkin = i
            break
          end
        end
      end
    end
    setElementModel(previewPed, availableSkins[currentSkinCat][currentSkin])
    nextWardrobeIdleAnimation()
    createBinco()
  end
end)
addEvent("changeEnteredCustomMarker", false)
addEventHandler("changeEnteredCustomMarker", getRootElement(), function(theType, id)
  if theType == "binco" and not currentBinco then
    if lastExit == id then
      lastExit = false
      return
    end
    lastExit = false
    initBinco(id)
  end
end)
local markers = {}
function createBincoMarkers()
  for k = 1, #markers do
    if markers[k] then
      sightexports.sMarkers:deleteCustomMarker(markers[k])
    end
    markers[k] = nil
  end
  for i = 1, #availableShops do
    markers[i] = sightexports.sMarkers:createCustomMarker(availableShops[i][1], availableShops[i][2], availableShops[i][3], availableShops[i][4], availableShops[i][5], "sightblue", "cloth")
    sightexports.sMarkers:setCustomMarkerInterior(markers[i], "binco", i, 1.5)
  end
end
addEventHandler("onClientResourceStop", getResourceRootElement(), function()
  for k = 1, #markers do
    if markers[k] then
      sightexports.sMarkers:deleteCustomMarker(markers[k])
    end
    markers[k] = nil
  end
end)
