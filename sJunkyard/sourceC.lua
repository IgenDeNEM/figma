local sightexports = {sMarkers = false, sGui = false}
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
      createMarkers()
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
local mixerFont = false
local mixerFontScale = false
local green = false
local grey1 = false
local grey2 = false
local function sightlangGuiRefreshColors()
  local res = getResourceFromName("sGui")
  if res and getResourceState(res) == "running" then
    mixerFont = sightexports.sGui:getFont("12/Ubuntu-R.ttf")
    mixerFontScale = sightexports.sGui:getFontScale("12/Ubuntu-R.ttf")
    green = sightexports.sGui:getColorCode("sightgreen")
    grey1 = sightexports.sGui:getColorCode("sightgrey1")
    grey2 = sightexports.sGui:getColorCode("sightgrey2")
  end
end
addEventHandler("onGuiRefreshColors", getRootElement(), sightlangGuiRefreshColors)
addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangGuiRefreshColors)
local screenX, screenY = guiGetScreenSize()
local markersPositions = {
  {
    -1863.22265625,
    -1718.3486328125,
    21.754781723022
  },
  {
    -1850.8857421875,
    -1724.9404296875,
    22.491683959961
  },
  {
    -1685.6748046875,
    -1677.9267578125,
    0.61951911449432
  }
}
local markers = {}
function createMarkers()
  for i = 1, #markersPositions do
    markers[i] = sightexports.sMarkers:createCustomMarker(markersPositions[i][1], markersPositions[i][2], markersPositions[i][3] + 0.35, 0, 0, "sightorange", "yunk")
    sightexports.sMarkers:setCustomMarkerInterior(markers[i], "junkyard", false, 3)
  end
end
addEventHandler("onClientResourceStop", getResourceRootElement(), function()
  for i = 1, #markers do
    sightexports.sMarkers:deleteCustomMarker(markers[i])
  end
end)
addEvent("changeEnteredCustomMarker", false)
addEventHandler("changeEnteredCustomMarker", getRootElement(), function(theType, id)
  if theType == "junkyard" then
    local ownVeh = getPedOccupiedVehicle(localPlayer)
    local ownSeat = getPedOccupiedVehicleSeat(localPlayer)
    if ownVeh and ownSeat and ownSeat == 0 then
      setElementData(ownVeh, "vehicle.gear", "N")
      triggerServerEvent("onClientTryToEnterJunkyard", localPlayer)
    end
  end
end)
local junkyardWindow = false
function deleteJunkyardPanel()
  if junkyardWindow then
    sightexports.sGui:deleteGuiElement(junkyardWindow)
  end
  junkyardWindow = nil
end
addEvent("junkyardPromptResponse", false)
addEventHandler("junkyardPromptResponse", getRootElement(), function(button, state, absoluteX, absoluteY, el, yes)
  deleteJunkyardPanel()
  if yes then
    triggerServerEvent("tryToDestroyVehicle", localPlayer)
  end
end)
function createJunkyardPanel()
  local titleBarHeight = sightexports.sGui:getTitleBarHeight()
  local pw = 375
  local ph = titleBarHeight + 120
  deleteJunkyardPanel()
  junkyardWindow = sightexports.sGui:createGuiElement("window", screenX / 2 - pw / 2, screenY / 2 - ph / 2, pw, ph)
  sightexports.sGui:setWindowColors(junkyardWindow, "sightgrey2", "sightgrey1", "sightgrey3", "#ffffff")
  sightexports.sGui:setWindowTitle(junkyardWindow, "16/BebasNeueRegular.otf", "Jármű bezúzatása")
  local label = sightexports.sGui:createGuiElement("label", 0, titleBarHeight, pw, ph - 8 - 32 - 8 - titleBarHeight, junkyardWindow)
  sightexports.sGui:setLabelAlignment(label, "center", "center")
  sightexports.sGui:setLabelText(label, "Biztosan szeretnéd bezúzatni a járművedet?\n\n[color=sightred]Ez a művelet nem visszavonható.")
  sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
  local w = (pw - 24) / 2
  local btn = sightexports.sGui:createGuiElement("button", 8, ph - 8 - 32, w, 32, junkyardWindow)
  sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
  sightexports.sGui:setGuiHover(btn, "gradient", {
    "sightgreen",
    "sightgreen-second"
  }, false, true)
  sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
  sightexports.sGui:setButtonText(btn, "Igen")
  sightexports.sGui:setClickEvent(btn, "junkyardPromptResponse")
  sightexports.sGui:setClickArgument(btn, true)
  local btn = sightexports.sGui:createGuiElement("button", pw - w - 8, ph - 8 - 32, w, 32, junkyardWindow)
  sightexports.sGui:setGuiBackground(btn, "solid", "sightred")
  sightexports.sGui:setGuiHover(btn, "gradient", {
    "sightred",
    "sightred-second"
  }, false, true)
  sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
  sightexports.sGui:setButtonText(btn, "Nem")
  sightexports.sGui:setClickEvent(btn, "junkyardPromptResponse")
end
addEvent("setJunkyardPanel", true)
addEventHandler("setJunkyardPanel", getRootElement(), function(state)
  if state then
    createJunkyardPanel()
  else
    deleteJunkyardPanel()
  end
end)