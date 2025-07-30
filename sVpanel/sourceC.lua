local sightexports = {sGui = false, sPermission = false}
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
local screenX, screenY = guiGetScreenSize()
local panelState = false
local titleBarHeight = 0
local h = 32
local w = 168
local tuningButtons = {}
local tuningNames = {
  "Gyári",
  "Profi",
  "Verseny",
  "Venom"
}
addEvent("gotVenomValues", true)
addEventHandler("gotVenomValues", getRootElement(), function(veh, tmp)
  if isElement(veh) and getPedOccupiedVehicle(localPlayer) == veh and panelState then
    for i = 1, #tuningValues do
      for j = 0, 3 do
        local col = 3 <= j and "sightblue" or "sightgreen"
        local btn = tuningButtons[i][j]
        if j == tmp[tuningValues[i][1]] then
          sightexports.sGui:setGuiBackground(btn, "solid", col)
          sightexports.sGui:setGuiHover(btn, "none", false, false, true)
        else
          sightexports.sGui:setGuiBackground(btn, "solid", "sightgrey3")
          sightexports.sGui:setGuiHover(btn, "gradient", {
            col,
            col .. "-second"
          }, false, true)
          sightexports.sGui:setClickEvent(btn, "setNewVenomValue")
        end
      end
    end
  end
end)
addEvent("setNewVenomValue", true)
addEventHandler("setNewVenomValue", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  for i = 1, #tuningValues do
    for j = 0, 3 do
      local btn = tuningButtons[i][j]
      if btn == el then
        triggerServerEvent("setVenomValue", localPlayer, getPedOccupiedVehicle(localPlayer), tuningValues[i][1], j)
        return
      end
    end
  end
end)
addEvent("setFactoryTuning", true)
addEventHandler("setFactoryTuning", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  for i = 1, #tuningValues do
    triggerServerEvent("setVenomValue", localPlayer, getPedOccupiedVehicle(localPlayer), tuningValues[i][1], 0)
  end
end)
addEvent("setFullTuning", true)
addEventHandler("setFullTuning", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  for i = 1, #tuningValues do
    triggerServerEvent("setVenomValue", localPlayer, getPedOccupiedVehicle(localPlayer), tuningValues[i][1], 3)
  end
end)
addEvent("closeVPanel", true)
addEventHandler("closeVPanel", getRootElement(), function()
  sightexports.sGui:deleteGuiElement(window)
  panelState = false
end)
function createVpanel(state)
  if state then
    triggerServerEvent("requestVenomValues", localPlayer, getPedOccupiedVehicle(localPlayer))
    titleBarHeight = sightexports.sGui:getTitleBarHeight()
    local ph = titleBarHeight + h * #tuningValues + h
    window = sightexports.sGui:createGuiElement("window", screenX / 4 * 3 - w / 2, screenY / 2 - ph / 2, w, ph)
    sightexports.sGui:setWindowTitle(window, "16/BebasNeueRegular.otf", "vPanel")
    sightexports.sGui:setWindowCloseButton(window, "closeVPanel")
    tuningButtons = {}
    for i = 1, #tuningValues do
      tuningButtons[i] = {}
      local y = titleBarHeight + i * h - h / 2 - 12
      local x = 8
      local icon = sightexports.sGui:createGuiElement("image", x, y, 24, 24, window)
      sightexports.sGui:setImageDDS(icon, ":sVpanel/files/" .. tuningValues[i][2] .. ".dds")
      sightexports.sGui:guiSetTooltip(icon, tuningValues[i][1])
      sightexports.sGui:setGuiHoverable(icon, true)
      for j = 0, 3 do
        x = x + 24 + 8
        local btn = sightexports.sGui:createGuiElement("button", x, y, 24, 24, window)
        local col = 3 <= j and "sightblue" or "sightgreen"
        if j == 0 then
          sightexports.sGui:setGuiBackground(btn, "solid", col)
          sightexports.sGui:setGuiHover(btn, "none", false, false, true)
        else
          sightexports.sGui:setGuiBackground(btn, "solid", "sightgrey3")
          sightexports.sGui:setGuiHover(btn, "gradient", {
            col,
            col .. "-second"
          }, false, true)
          sightexports.sGui:setClickEvent(btn, "setNewVenomValue")
        end
        if tuningValues[i][1] == "ecu" and j == 4 then
          sightexports.sGui:guiSetTooltip(btn, tuningNames[j + 1] .. "+CustomECU")
        elseif tuningValues[i][1] == "turbo" and j == 4 then
          sightexports.sGui:guiSetTooltip(btn, tuningNames[j + 1] .. "+SC")
        else
          sightexports.sGui:guiSetTooltip(btn, tuningNames[j + 1])
        end
        sightexports.sGui:setButtonFont(btn, "11/BebasNeueBold.otf")
        sightexports.sGui:setButtonText(btn, j)
        tuningButtons[i][j] = btn
      end
    end
    local x = 8
    local y = titleBarHeight + #tuningValues * h + h / 2 - 12
    local btn = sightexports.sGui:createGuiElement("button", x, y, 60, 24, window)
    sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
    sightexports.sGui:setGuiHover(btn, "gradient", {
      "sightgreen",
      "sightgreen-second"
    }, false, true)
    sightexports.sGui:setClickEvent(btn, "setFactoryTuning")
    sightexports.sGui:setButtonFont(btn, "11/BebasNeueBold.otf")
    sightexports.sGui:setButtonText(btn, "Gyári")
    x = x + 60 + 10
    local btn = sightexports.sGui:createGuiElement("button", x, y, 60, 24, window)
    sightexports.sGui:setGuiBackground(btn, "solid", "sightblue")
    sightexports.sGui:setGuiHover(btn, "gradient", {
      "sightblue",
      "sightblue-second"
    }, false, true)
    sightexports.sGui:setClickEvent(btn, "setFullTuning")
    sightexports.sGui:setButtonFont(btn, "11/BebasNeueBold.otf")
    sightexports.sGui:setButtonText(btn, "Full")
  else
    panelState = false
    sightexports.sGui:deleteGuiElement(window)
  end
end
function toggleVPanel()
  local veh = getPedOccupiedVehicle(localPlayer)
  if veh and sightexports.sPermission:hasPermission(localPlayer, "canUseVpanel") then
    if panelState == false then
      panelState = true
      createVpanel(true)
    else
      panelState = false
      createVpanel(false)
    end
  end
end
addCommandHandler("vpanel", toggleVPanel)