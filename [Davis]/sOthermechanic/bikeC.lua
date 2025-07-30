local sightexports = {sGui = false, sVehiclenames = false}
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
bikeWindow = false
local checkboxes = {}
local labels = {}
local sumLabel = false
local bikeButtons = {}
function deleteBikeWindow()
  if bikeWindow then
    sightexports.sGui:deleteGuiElement(bikeWindow)
    checkboxes = {}
    labels = {}
    sumLabel = false
    bikeButtons = {}
    removeEventHandler("onClientPlayerVehicleEnter", localPlayer, createBikeWindow)
    removeEventHandler("onClientPlayerVehicleExit", localPlayer, createBikeWindow)
  end
  bikeWindow = false
end
function refreshRepairSums()
  local veh = getPedOccupiedVehicle(localPlayer)
  if getVehicleController(veh) == localPlayer and (getVehicleType(veh) == "Bike" or getVehicleType(veh) == "Quad") and getElementData(veh, "vehicle.dbID") then
    local sum = 0
    local sumTime = 0
    for i = 1, #bikeOptions do
      if sightexports.sGui:isCheckboxChecked(checkboxes[i]) then
        sumTime = sumTime + bikeOptions[i].time
        sum = sum + getItemPrice(veh, bikeOptions[i].price)
      end
    end
    local hours = math.floor(sumTime)
    local minutes = sumTime * 60 - hours * 60
    local time = ""
    if 0 < hours then
      time = hours .. " óra "
    end
    if 0 < minutes then
      time = time .. minutes .. " perc "
    elseif hours <= 0 then
      time = "0 perc "
    end
    sightexports.sGui:setLabelText(sumLabel, time .. "#ffffff/ [color=sightgreen]" .. sightexports.sGui:thousandsStepper(sum) .. " $")
  else
    deleteBikeWindow()
  end
end
addEvent("bikeRepairChanged", false)
addEventHandler("bikeRepairChanged", getRootElement(), refreshRepairSums)
addEvent("gotBikeConditions", true)
addEventHandler("gotBikeConditions", getRootElement(), function(bike, dat)
  if bikeWindow then
    local veh = getPedOccupiedVehicle(localPlayer)
    if getVehicleController(veh) == localPlayer and (getVehicleType(veh) == "Bike" or getVehicleType(veh) == "Quad") and getElementData(veh, "vehicle.dbID") and veh == bike then
      for i = 1, #bikeOptions do
        if dat[i] then
          if tonumber(dat[i]) then
            local r, g, b = getPartColor(dat[i])
            sightexports.sGui:setLabelText(labels[i], "Állapot: " .. rgbToHex(r, g, b) .. dat[i] .. " %")
          elseif bikeOptions[i].part == "oil" then
            local r, g, b = getPartColor(dat[i][1])
            sightexports.sGui:setLabelText(labels[i], "Következő olajcsere: " .. rgbToHex(r, g, b) .. dat[i][2] .. " km")
          else
            local r, g, b = getPartColor(dat[i][1])
            local r2, g2, b2 = getPartColor(dat[i][2])
            sightexports.sGui:setLabelText(labels[i], "Első: " .. rgbToHex(r, g, b) .. dat[i][1] .. " %#ffffff, Hátsó: " .. rgbToHex(r2, g2, b2) .. dat[i][2] .. " %")
          end
        end
      end
    end
  end
end)
addEvent("finalAcceptBikeRepair", true)
addEventHandler("finalAcceptBikeRepair", getRootElement(), function()
  local veh = getPedOccupiedVehicle(localPlayer)
  if getVehicleController(veh) == localPlayer and (getVehicleType(veh) == "Bike" or getVehicleType(veh) == "Quad") and getElementData(veh, "vehicle.dbID") then
    local options = {}
    local c = 0
    for i = 1, #bikeOptions do
      options[i] = sightexports.sGui:isCheckboxChecked(checkboxes[i]) or nil
      if options[i] then
        c = c + 1
      end
    end
    if c <= 0 then
      sightexports.sGui:showInfobox("e", "Legalább egy lehetőséged válassz ki!")
      return
    end
    triggerServerEvent("acceptBikeRepairOffer", localPlayer, veh, options)
    deleteBikeWindow()
  end
end)
bikeList = false
function bikeSortFunction(a, b)
  return a[3] < b[3]
end
addEvent("gotServiceBikeList", true)
addEventHandler("gotServiceBikeList", getRootElement(), function(dat)
  if inBikeMarker then
    bikeList = dat
    table.sort(bikeList, bikeSortFunction)
    createBikeWindow()
  end
end)
addEvent("pickUpBikeInSerivce", false)
addEventHandler("pickUpBikeInSerivce", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  if bikeButtons[el] then
    triggerServerEvent("pickUpBikeInSerivce", localPlayer, bikeButtons[el])
    deleteBikeWindow()
  end
end)
function createBikeWindow()
  deleteBikeWindow()
  local titleBarHeight = sightexports.sGui:getTitleBarHeight()
  local veh = getPedOccupiedVehicle(localPlayer)
  if not veh then
    if bikeList then
      if #bikeList > 0 then
        bikeButtons = {}
        local pw = 350
        local ph = titleBarHeight + 56 * (#bikeList - 1) + 48
        bikeWindow = sightexports.sGui:createGuiElement("window", screenX / 2 - pw / 2, screenY / 2 - ph / 2, pw, ph)
        sightexports.sGui:setWindowTitle(bikeWindow, "16/BebasNeueRegular.otf", "Motorkerékpár szerviz")
        local y = titleBarHeight
        for i = 1, #bikeList do
          local label = sightexports.sGui:createGuiElement("label", 8, y, pw, 24, bikeWindow)
          sightexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
          sightexports.sGui:setLabelAlignment(label, "left", "center")
          sightexports.sGui:setLabelText(label, "#" .. bikeList[i][1])
          sightexports.sGui:setLabelWordBreak(label, true)
          local label = sightexports.sGui:createGuiElement("label", 8, y + 24, 0, 24, bikeWindow)
          sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
          sightexports.sGui:setLabelAlignment(label, "left", "center")
          sightexports.sGui:setLabelText(label, sightexports.sVehiclenames:getCustomVehicleName(bikeList[i][2]))
          if 0 < bikeList[i][3] then
            local hours = math.floor(bikeList[i][3] / 60)
            local minutes = bikeList[i][3] - hours * 60
            local time = ""
            if 0 < hours then
              time = hours .. " óra"
            end
            if 0 < minutes then
              time = time .. " " .. minutes .. " perc"
            end
            local label = sightexports.sGui:createGuiElement("label", 0, y, pw - 8, 48, bikeWindow)
            sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
            sightexports.sGui:setLabelAlignment(label, "right", "center")
            sightexports.sGui:setLabelColor(label, "sightblue")
            sightexports.sGui:setLabelText(label, time)
          else
            local btn = sightexports.sGui:createGuiElement("button", pw - 8 - 75, y + 24 - 12, 75, 24, bikeWindow)
            sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
            sightexports.sGui:setGuiHover(btn, "gradient", {
              "sightgreen",
              "sightgreen-second"
            }, false, true)
            sightexports.sGui:setButtonFont(btn, "13/BebasNeueBold.otf")
            sightexports.sGui:setButtonTextColor(btn, "#ffffff")
            sightexports.sGui:setButtonText(btn, "Átvétel")
            sightexports.sGui:setClickEvent(btn, "pickUpBikeInSerivce")
            bikeButtons[btn] = bikeList[i][1]
          end
          y = y + 48
          if i < #bikeList then
            y = y + 4
            local border = sightexports.sGui:createGuiElement("hr", 8, y - 1, pw - 16, 2, bikeWindow)
            y = y + 4
          end
        end
      else
        local pw = 350
        local ph = titleBarHeight + 48
        bikeWindow = sightexports.sGui:createGuiElement("window", screenX / 2 - pw / 2, screenY / 2 - ph / 2, pw, ph)
        sightexports.sGui:setWindowTitle(bikeWindow, "16/BebasNeueRegular.otf", "Motorkerékpár szerviz")
        local label = sightexports.sGui:createGuiElement("label", 0, titleBarHeight, pw, ph - titleBarHeight, bikeWindow)
        sightexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
        sightexports.sGui:setLabelAlignment(label, "center", "center")
        sightexports.sGui:setLabelText(label, "Nincsen leadott motorkerékpárod!")
      end
    else
      local pw = 350
      local ph = titleBarHeight + 48
      bikeWindow = sightexports.sGui:createGuiElement("window", screenX / 2 - pw / 2, screenY / 2 - ph / 2, pw, ph)
      sightexports.sGui:setWindowTitle(bikeWindow, "16/BebasNeueRegular.otf", "Motorkerékpár szerviz")
      local label = sightexports.sGui:createGuiElement("label", 0, titleBarHeight, pw, ph - titleBarHeight, bikeWindow)
      sightexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
      sightexports.sGui:setLabelAlignment(label, "center", "center")
      sightexports.sGui:setLabelText(label, "Betöltés folyamatban...")
    end
  elseif getVehicleController(veh) == localPlayer and (getVehicleType(veh) == "Bike" or getVehicleType(veh) == "Quad") and getElementData(veh, "vehicle.dbID") then
    triggerServerEvent("requestBikeConditions", localPlayer)
    local pw = 350
    local ph = titleBarHeight + 56 * #bikeOptions + 24 + 32 + 8
    bikeWindow = sightexports.sGui:createGuiElement("window", screenX / 2 - pw / 2, screenY / 2 - ph / 2, pw, ph)
    sightexports.sGui:setWindowTitle(bikeWindow, "16/BebasNeueRegular.otf", "Motorkerékpár szerviz")
    checkboxes = {}
    local y = titleBarHeight
    for i = 1, #bikeOptions do
      checkboxes[i] = sightexports.sGui:createGuiElement("checkbox", 8, y, 24, 24, bikeWindow)
      sightexports.sGui:setGuiColorScheme(checkboxes[i], "darker")
      sightexports.sGui:setClickEvent(checkboxes[i], "bikeRepairChanged")
      local label = sightexports.sGui:createGuiElement("label", 36, y, 0, 24, bikeWindow)
      sightexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
      sightexports.sGui:setLabelAlignment(label, "left", "center")
      sightexports.sGui:setLabelText(label, bikeOptions[i].name)
      labels[i] = sightexports.sGui:createGuiElement("label", 8, y + 24, 0, 24, bikeWindow)
      sightexports.sGui:setLabelFont(labels[i], "11/Ubuntu-L.ttf")
      sightexports.sGui:setLabelAlignment(labels[i], "left", "center")
      local label = sightexports.sGui:createGuiElement("label", 0, y, pw - 8, 24, bikeWindow)
      sightexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
      sightexports.sGui:setLabelAlignment(label, "right", "center")
      sightexports.sGui:setLabelColor(label, "sightblue")
      local time = bikeOptions[i].time
      local hours = math.floor(time)
      local minutes = time * 60 - hours * 60
      time = ""
      if 0 < hours then
        time = hours .. " óra"
      end
      if 0 < minutes then
        if 0 < hours then
          time = time .. " "
        end
        time = time .. minutes .. " perc"
      end
      sightexports.sGui:setLabelText(label, time)
      local label = sightexports.sGui:createGuiElement("label", 0, y + 24, pw - 8, 24, bikeWindow)
      sightexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
      sightexports.sGui:setLabelAlignment(label, "right", "center")
      sightexports.sGui:setLabelColor(label, "sightgreen")
      sightexports.sGui:setLabelText(label, sightexports.sGui:thousandsStepper(getItemPrice(veh, bikeOptions[i].price)) .. " $")
      y = y + 48 + 4
      local border = sightexports.sGui:createGuiElement("hr", 8, y - 1, pw - 16, 2, bikeWindow)
      y = y + 4
    end
    local label = sightexports.sGui:createGuiElement("label", 8, y, 0, 24, bikeWindow)
    sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    sightexports.sGui:setLabelText(label, "Összesen:")
    sumLabel = sightexports.sGui:createGuiElement("label", 0, y, pw - 8, 24, bikeWindow)
    sightexports.sGui:setLabelFont(sumLabel, "11/Ubuntu-R.ttf")
    sightexports.sGui:setLabelAlignment(sumLabel, "right", "center")
    sightexports.sGui:setLabelColor(sumLabel, "sightblue")
    refreshRepairSums()
    y = y + 24
    y = y + 8
    local btn = sightexports.sGui:createGuiElement("button", 8, y, pw - 16, ph - y - 8, bikeWindow)
    sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
    sightexports.sGui:setGuiHover(btn, "gradient", {
      "sightgreen",
      "sightgreen-second"
    }, false, true)
    sightexports.sGui:setButtonFont(btn, "13/BebasNeueBold.otf")
    sightexports.sGui:setButtonTextColor(btn, "#ffffff")
    sightexports.sGui:setButtonText(btn, "Szerelés megkezdése")
    sightexports.sGui:setClickEvent(btn, "finalAcceptBikeRepair")
  end
  if bikeWindow then
    addEventHandler("onClientPlayerVehicleEnter", localPlayer, createBikeWindow)
    addEventHandler("onClientPlayerVehicleExit", localPlayer, createBikeWindow)
  end
end
