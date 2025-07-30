local sightexports = {sGui = false}
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
krutonWindow = false
krutonInside = false
krutonX, krutonY, krutonZ = false, false, false
local krutonCheckerHandled = false
function openKrutonComputer(x, y, z)
  if not krutonWindow then
    krutonX, krutonY, krutonZ = x, y, z
    createKrutonScreen()
  end
end
function krutonChecker()
  local px, py, pz = getElementPosition(localPlayer)
  if getDistanceBetweenPoints3D(px, py, pz, krutonX, krutonY, krutonZ) > 3 or isPedInVehicle(localPlayer) then
    deleteKrutonScreen()
  end
end
function deleteKrutonScreen()
  deleteMechanicOrderGui()
  deleteKrutonObd()
  local x, y = false, false
  if krutonWindow then
    x, y = sightexports.sGui:getGuiPosition(krutonWindow)
    sightexports.sGui:deleteGuiElement(krutonWindow)
  end
  krutonWindow = false
  krutonInside = false
  if krutonCheckerHandled then
    removeEventHandler("onClientRender", getRootElement(), krutonChecker)
    krutonCheckerHandled = false
  end
  return x, y
end
addEvent("closeMechanicKruton", false)
addEventHandler("closeMechanicKruton", getRootElement(), deleteKrutonScreen)
function createKrutonScreen()
  local x, y = deleteKrutonScreen()
  if not krutonCheckerHandled then
    addEventHandler("onClientRender", getRootElement(), krutonChecker)
    krutonCheckerHandled = true
  end
  local titleBarHeight = sightexports.sGui:getTitleBarHeight()
  local padding = 4
  panelWidth = 1000 + padding * 2
  panelHeight = 670 + titleBarHeight + padding * 2
  krutonWindow = sightexports.sGui:createGuiElement("window", x or screenX / 2 - panelWidth / 2, y or screenY / 2 - panelHeight / 2, panelWidth, panelHeight)
  sightexports.sGui:setWindowTitle(krutonWindow, "16/BebasNeueRegular.otf", "Kruton")
  sightexports.sGui:setWindowCloseButton(krutonWindow, "closeMechanicKruton")
  krutonInside = sightexports.sGui:createGuiElement("image", padding, titleBarHeight + padding, panelWidth - padding * 2, 670, krutonWindow)
  sightexports.sGui:setImageDDS(krutonInside, ":sMechanic/files/wp.dds")
  local icon = sightexports.sGui:createGuiElement("rectangle", 12, 12, 52, 76, krutonInside)
  sightexports.sGui:setGuiBackground(icon, "solid", {
    0,
    0,
    0,
    0
  })
  sightexports.sGui:setGuiHover(icon, "none")
  sightexports.sGui:setGuiHoverable(icon, true)
  sightexports.sGui:setClickEvent(icon, "createKrutonObd")
  local logo = sightexports.sGui:createGuiElement("image", 2, 2, 48, 48, icon)
  sightexports.sGui:setImageDDS(logo, ":sMechanic/files/diag.dds")
  local label = sightexports.sGui:createGuiElement("label", 2, 50, 48, 24, icon)
  sightexports.sGui:setLabelFont(label, "9/Ubuntu-R.ttf")
  sightexports.sGui:setLabelText(label, [[
OBD
Diag 1.0]])
  sightexports.sGui:setLabelAlignment(label, "center", "center")
  if currentWorkshop then
    local icon = sightexports.sGui:createGuiElement("rectangle", 88, 12, 52, 76, krutonInside)
    sightexports.sGui:setGuiBackground(icon, "solid", {
      0,
      0,
      0,
      0
    })
    sightexports.sGui:setGuiHover(icon, "none")
    sightexports.sGui:setGuiHoverable(icon, true)
    sightexports.sGui:setClickEvent(icon, "openNixPanel")
    local logo = sightexports.sGui:createGuiElement("image", 2, 2, 48, 48, icon)
    sightexports.sGui:setImageDDS(logo, ":sMechanic/files/nix.dds")
    local label = sightexports.sGui:createGuiElement("label", 2, 50, 48, 24, icon)
    sightexports.sGui:setLabelFont(label, "9/Ubuntu-R.ttf")
    sightexports.sGui:setLabelText(label, "SightNIX\nAlkatrészek")
    sightexports.sGui:setLabelAlignment(label, "center", "center")
    local icon = sightexports.sGui:createGuiElement("rectangle", 240, 12, 52, 76, krutonInside)
    sightexports.sGui:setGuiBackground(icon, "solid", {
      0,
      0,
      0,
      0
    })
    sightexports.sGui:setGuiHover(icon, "none")
    sightexports.sGui:setGuiHoverable(icon, true)
    sightexports.sGui:setClickEvent(icon, "checkMechanicStats")
    local logo = sightexports.sGui:createGuiElement("image", 2, 2, 48, 48, icon)
    sightexports.sGui:setImageDDS(logo, ":sMechanic/files/stats.dds")
    local label = sightexports.sGui:createGuiElement("label", 2, 50, 48, 24, icon)
    sightexports.sGui:setLabelFont(label, "9/Ubuntu-R.ttf")
    sightexports.sGui:setLabelText(label, "Munka-\nteljesítmény")
    sightexports.sGui:setLabelAlignment(label, "center", "center")
    local icon = sightexports.sGui:createGuiElement("rectangle", 164, 12, 52, 76, krutonInside)
    sightexports.sGui:setGuiBackground(icon, "solid", {
      0,
      0,
      0,
      0
    })
    sightexports.sGui:setGuiHover(icon, "none")
    sightexports.sGui:setGuiHoverable(icon, true)
    sightexports.sGui:setClickEvent(icon, "createMechanicCheckout")
    local logo = sightexports.sGui:createGuiElement("image", 2, 2, 48, 48, icon)
    sightexports.sGui:setImageDDS(logo, ":sMechanic/files/checkout.dds")
    local label = sightexports.sGui:createGuiElement("label", 2, 50, 48, 24, icon)
    sightexports.sGui:setLabelFont(label, "9/Ubuntu-R.ttf")
    sightexports.sGui:setLabelText(label, "Kassza-\nzárás")
    sightexports.sGui:setLabelAlignment(label, "center", "center")
    local icon = sightexports.sGui:createGuiElement("rectangle", 316, 12, 52, 76, krutonInside)
    sightexports.sGui:setGuiBackground(icon, "solid", {
      0,
      0,
      0,
      0
    })
  end
  local bg = sightexports.sGui:createGuiElement("image", (panelWidth - padding * 2) / 2 - 128, 236, 256, 166, krutonInside)
  sightexports.sGui:setImageDDS(bg, ":sMechanic/files/kruton.dds")
  local rect = sightexports.sGui:createGuiElement("rectangle", padding, panelHeight - 32 - padding, panelWidth - padding * 2, 32, krutonWindow)
  sightexports.sGui:setGuiBackground(rect, "solid", {
    19,
    103,
    173,
    220
  })
  local logo = sightexports.sGui:createGuiElement("image", 0, 0, 32, 32, rect)
  sightexports.sGui:setImageDDS(logo, ":sMechanic/files/winlog.dds")
end
addEvent("createMechanicCheckout", false)
addEventHandler("createMechanicCheckout", getRootElement(), function()
  triggerServerEvent("createMechanicCheckout", localPlayer)
end)
addEvent("checkMechanicStats", false)
addEventHandler("checkMechanicStats", getRootElement(), function()
  triggerServerEvent("checkMechanicStats", localPlayer)
end)
addEvent("createMechanicStockReport", false)
addEventHandler("createMechanicStockReport", getRootElement(), function()
  triggerServerEvent("createMechanicStockReport", localPlayer)
end)
