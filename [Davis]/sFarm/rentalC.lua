local seexports = {
  sGui = false,
  sWorkaround = false,
  sVehiclenames = false
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
local rentalPanel = false
local rentalNPC = false
rentalNPC = createPed(50, 2404.32421875, -2139.880859375, 13.553834915161, 0)
setElementData(rentalNPC, "invulnerable", true)
setElementData(rentalNPC, "visibleName", "Tóth Tibor")
setElementData(rentalNPC, "pedNameType", "Utánfutó bérlés")
setTimer(setElementFrozen, 1000, 1, rentalNPC, true)
local lastTry = 0
addEvent("confirmTrailerRental", true)
addEventHandler("confirmTrailerRental", getRootElement(), function()
  if rentalPanel then
    seexports.sGui:deleteGuiElement(rentalPanel)
  end
  rentalPanel = false
  triggerServerEvent("requestTrailerRental", getRootElement())
  lastTry = getTickCount()
end)
addEvent("confirmTrailerRentalEx", true)
addEventHandler("confirmTrailerRentalEx", getRootElement(), function()
  if rentalPanel then
    seexports.sGui:deleteGuiElement(rentalPanel)
  end
  rentalPanel = false
  triggerServerEvent("requestTrailerRental", getRootElement(), true)
  lastTry = getTickCount()
end)
addEvent("closeTrailerRentalPrompt", true)
addEventHandler("closeTrailerRentalPrompt", getRootElement(), function()
  if rentalPanel then
    seexports.sGui:deleteGuiElement(rentalPanel)
  end
  rentalPanel = false
end)
local checkCanRent = false
addEventHandler("onClientClick", getRootElement(), function(button, state, x, y, wx, wy, wz, clickedElement)
  if state == "down" and clickedElement == rentalNPC and not rentalPanel then
    if getTickCount() - lastTry < 10000 then
      seexports.sGui:showInfobox("e", "Várj egy kicsit!")
      return
    end
    local x, y, z = getElementPosition(clickedElement)
    local px, py, pz = getElementPosition(localPlayer)
    local dist = getDistanceBetweenPoints3D(x, y, z, px, py, pz)
    if not isPedInVehicle(localPlayer) and dist < 2 and not checkCanRent then
      checkCanRent = true
      triggerServerEvent("canRentTrailer", localPlayer)
      lastTry = getTickCount()
    end
  end
end, true, "high+999999999")
addEvent("canRentTrailer", true)
addEventHandler("canRentTrailer", getRootElement(), function(canRent, alreadyRented)
  checkCanRent = false
  if canRent then
    showRentalPrompt(alreadyRented)
  end
end)
function showRentalPrompt(alreadyRented)
  local titleBarHeight = seexports.sGui:getTitleBarHeight()
  local windowHeight = titleBarHeight + 35 + 5 + 30 + 5
  local windowWidth = alreadyRented and 370 or 720
  if rentalPanel then
    seexports.sGui:deleteGuiElement(rentalPanel)
  end
  local towNames = {}
  local bh = (windowWidth - 15) / 2 / 2
  if not alreadyRented then
    local towPoses = seexports.sWorkaround:getTowPoses()
    for k in pairs(towPoses) do
      table.insert(towNames, seexports.sVehiclenames:getCustomVehicleName(k))
    end
    windowHeight = windowHeight + 20 * math.ceil(#towNames / 3)
    windowHeight = windowHeight + 10 + bh + 10
  end
  rentalPanel = seexports.sGui:createGuiElement("window", screenX / 2 - windowWidth / 2, screenY / 2 - windowHeight / 2, windowWidth, windowHeight)
  seexports.sGui:setWindowTitle(rentalPanel, "16/BebasNeueRegular.otf", "SightMTA - Utánfutó bérlés")
  local label = seexports.sGui:createGuiElement("label", 0, 5 + titleBarHeight, windowWidth, 30, rentalPanel)
  seexports.sGui:setLabelAlignment(label, "center", "center")
  seexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
  if alreadyRented then
    seexports.sGui:setLabelText(label, "Biztosan szeretnéd bérelt utánfutód leadni?")
    local btn = seexports.sGui:createGuiElement("button", 5, windowHeight - 30 - 5, (windowWidth - 15) / 2, 30, rentalPanel)
    seexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
    seexports.sGui:setGuiHover(btn, "gradient", {
      "sightgreen",
      "sightgreen-second"
    }, false, true)
    seexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
    seexports.sGui:setButtonTextColor(btn, "#ffffff")
    seexports.sGui:setButtonText(btn, "Igen")
    seexports.sGui:setClickEvent(btn, "confirmTrailerRental", false)
    local btn = seexports.sGui:createGuiElement("button", 5 + (windowWidth - 15) / 2 + 5, windowHeight - 30 - 5, (windowWidth - 15) / 2, 30, rentalPanel)
    seexports.sGui:setGuiBackground(btn, "solid", "sightred")
    seexports.sGui:setGuiHover(btn, "gradient", {
      "sightred",
      "sightred-second"
    }, false, true)
    seexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
    seexports.sGui:setButtonTextColor(btn, "#ffffff")
    seexports.sGui:setButtonText(btn, "Nem")
    seexports.sGui:setClickEvent(btn, "closeTrailerRentalPrompt", false)
  else
    seexports.sGui:setLabelColor(label, "sightgreen")
    seexports.sGui:setLabelText(label, "Az alábbi járművek rendelkeznek vonóhoroggal:")
    local y = 5
    table.sort(towNames)
    for i = 1, #towNames, 3 do
      if towNames[i] then
        local label = seexports.sGui:createGuiElement("label", 0, 35 + titleBarHeight + y, windowWidth / 3, 20, rentalPanel)
        seexports.sGui:setLabelAlignment(label, "center", "center")
        seexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
        seexports.sGui:setLabelText(label, towNames[i])
      end
      if towNames[i + 1] then
        local label = seexports.sGui:createGuiElement("label", windowWidth / 3, 35 + titleBarHeight + y, windowWidth / 3, 20, rentalPanel)
        seexports.sGui:setLabelAlignment(label, "center", "center")
        seexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
        seexports.sGui:setLabelText(label, towNames[i + 1])
      end
      if towNames[i + 2] then
        local label = seexports.sGui:createGuiElement("label", windowWidth / 3 * 2, 35 + titleBarHeight + y, windowWidth / 3, 20, rentalPanel)
        seexports.sGui:setLabelAlignment(label, "center", "center")
        seexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
        seexports.sGui:setLabelText(label, towNames[i + 2])
      end
      y = y + 20
    end
    local btn = seexports.sGui:createGuiElement("button", 5, windowHeight - 30 - 5 - bh - 5, (windowWidth - 15) / 2, bh, rentalPanel)
    seexports.sGui:setGuiBackground(btn, "solid", "sightgrey3")
    seexports.sGui:setGuiHover(btn, "gradient", {"sightgrey3", "sightgrey4"}, false, true)
    seexports.sGui:setClickEvent(btn, "confirmTrailerRental", false)
    local img = seexports.sGui:createGuiElement("image", 5, windowHeight - 30 - 5 - bh - 5, (windowWidth - 15) / 2, bh, rentalPanel)
    seexports.sGui:setImageDDS(img, ":sFarm/files/tr1.dds")
    local btn = seexports.sGui:createGuiElement("button", 5 + (windowWidth - 15) / 2 + 5, windowHeight - 30 - 5 - bh - 5, (windowWidth - 15) / 2, bh, rentalPanel)
    seexports.sGui:setGuiBackground(btn, "solid", "sightgrey3")
    seexports.sGui:setGuiHover(btn, "gradient", {"sightgrey3", "sightgrey4"}, false, true)
    seexports.sGui:setClickEvent(btn, "confirmTrailerRentalEx", false)
    local img = seexports.sGui:createGuiElement("image", 5 + (windowWidth - 15) / 2 + 5, windowHeight - 30 - 5 - bh - 5, (windowWidth - 15) / 2, bh, rentalPanel)
    seexports.sGui:setImageDDS(img, ":sFarm/files/tr2.dds")
    local btn = seexports.sGui:createGuiElement("button", 5, windowHeight - 30 - 5, windowWidth - 10, 30, rentalPanel)
    seexports.sGui:setGuiBackground(btn, "solid", "sightred")
    seexports.sGui:setGuiHover(btn, "gradient", {
      "sightred",
      "sightred-second"
    }, false, true)
    seexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
    seexports.sGui:setButtonTextColor(btn, "#ffffff")
    seexports.sGui:setButtonText(btn, "Mégsem")
    seexports.sGui:setClickEvent(btn, "closeTrailerRentalPrompt", false)
  end
end
