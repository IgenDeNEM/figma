local sightexports = {
  sGui = false,
  sFuel = false,
  sSpeedo = false,
  sTuning = false
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
heliWindow = false
local menuButtons = {}
local fuelPriceLabel = false
local fuelSumLabel = false
local fuelSlider = false
local plateMode = false
local plateInput = false
local variantCheckboxes = {}
local toReset = false
local currentMenu = 1
local bcgH1 = false
local bcgH2 = false
local bcgH3 = false
local sliderH = false
local bcgS1 = false
local bcgS2 = false
local sliderS = false
local bcgL1 = false
local bcgL2 = false
local bcgL3 = false
local sliderL = false
local colorHexInput = false
local colorPickerR, colorPickerG, colorPickerB
function refreshColorPicker(refreshInput)
  local veh = getPedOccupiedVehicle(localPlayer)
  if veh and getVehicleController(veh) == localPlayer and (getVehicleType(veh) == "Helicopter" or getVehicleType(veh) == "Boat") and getElementData(veh, "vehicle.dbID") then
    toReset = veh
    local h = sightexports.sGui:getSliderValue(sliderH)
    local s = sightexports.sGui:getSliderValue(sliderS)
    local l = sightexports.sGui:getSliderValue(sliderL)
    local fR, fG, fB = convertHSLToRGB(h, s, l)
    sightexports.sGui:setGuiBackground(bcgH1, "solid", {
      convertHSLToRGB(0, 0, l)
    })
    sightexports.sGui:setImageColor(bcgH2, {
      255,
      255,
      255,
      s * 255
    })
    local r, g, b = convertHSLToRGB(0, 0, l)
    local a = math.abs(l - 0.5) / 0.5 * 255
    sightexports.sGui:setGuiBackground(bcgH3, "solid", {
      r,
      g,
      b,
      a
    })
    sightexports.sGui:setGuiBackground(bcgS1, "solid", {
      convertHSLToRGB(h, 0, l)
    })
    sightexports.sGui:setImageColor(bcgS2, {
      convertHSLToRGB(h, 1, l)
    })
    sightexports.sGui:setImageColor(bcgL3, {
      convertHSLToRGB(h, s, 0.5)
    })
    local col = {
      fR,
      fG,
      fB
    }
    colorPickerR, colorPickerG, colorPickerB = fR, fG, fB
    sightexports.sGui:setSliderColor(sliderH, {
      0,
      0,
      0,
      0
    }, col)
    sightexports.sGui:setSliderColor(sliderS, {
      0,
      0,
      0,
      0
    }, col)
    sightexports.sGui:setSliderColor(sliderL, {
      0,
      0,
      0,
      0
    }, col)
    local hex = utf8.sub(sightexports.sGui:getColorCodeHex(col), 2, 7)
    if refreshInput then
      sightexports.sGui:setInputValue(colorHexInput, hex)
    end
    local col = {
      getVehicleColor(veh, true)
    }
    if currentMenu == 5 then
      col[1], col[2], col[3] = fR, fG, fB
      setVehicleColor(veh, unpack(col))
    elseif currentMenu == 6 then
      col[4], col[5], col[6] = fR, fG, fB
      setVehicleColor(veh, unpack(col))
    end
  end
end
addEvent("heliColorPickerChanged", false)
addEventHandler("heliColorPickerChanged", getRootElement(), function()
  refreshColorPicker(true)
end)
addEvent("refreshHeliPickerInput", false)
addEventHandler("refreshHeliPickerInput", getRootElement(), function(val)
  sightexports.sGui:setInputValue(colorHexInput, utf8.upper(val))
  local r = tonumber("0x" .. val:sub(1, 2))
  local g = tonumber("0x" .. val:sub(3, 4))
  local b = tonumber("0x" .. val:sub(5, 6))
  if r and g and b then
    local h, s, l = convertRGBToHSL(r, g, b)
    sightexports.sGui:setSliderValue(sliderH, h)
    sightexports.sGui:setSliderValue(sliderS, s)
    sightexports.sGui:setSliderValue(sliderL, l)
    refreshColorPicker()
  end
end)
function deleteHeliWindow(noReset)
  if toReset and not noReset then
    triggerServerEvent("resetHelicopterFix", localPlayer, toReset)
    toReset = false
  end
  if heliWindow then
    sightexports.sGui:deleteGuiElement(heliWindow)
    menuButtons = {}
    fuelPriceLabel = false
    fuelSumLabel = false
    fuelSlider = false
    plateInput = false
    bcgH1 = false
    bcgH2 = false
    bcgH3 = false
    sliderH = false
    bcgS1 = false
    bcgS2 = false
    sliderS = false
    bcgL1 = false
    bcgL2 = false
    bcgL3 = false
    sliderL = false
    colorHexInput = false
    variantCheckboxes = {}
    removeEventHandler("onClientPlayerVehicleExit", localPlayer, deleteExitHeli)
  end
  heliWindow = false
end
function deleteExitHeli()
  deleteHeliWindow()
end
addEventHandler("onClientResourceStop", getResourceRootElement(), function()
  deleteHeliWindow()
end)
addEvent("changeHeliServiceMenu", false)
addEventHandler("changeHeliServiceMenu", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  if menuButtons[el] then
    currentMenu = menuButtons[el]
    createHeliWindow()
  end
end)
local customPlate = false
local fuelLiter = 0
function refreshHeliFuelPrice()
  if fuelPriceLabel and fuelSumLabel and fuelSlider then
    local price = sightexports.sFuel:getHeliFuelPrices()
    sightexports.sGui:setLabelText(fuelPriceLabel, "Üzemanyagár: [color=sightgreen]" .. price .. " $ / liter")
    local fuel, fuelMax = sightexports.sSpeedo:getFuel()
    if fuel and fuelMax then
      local maxAmount = fuelMax - fuel
      fuelLiter = (sightexports.sGui:getSliderValue(fuelSlider) or 0) * maxAmount
      fuelLiter = math.floor(fuelLiter * 10) / 10
      local sumPrice = math.ceil(fuelLiter * price)
      sightexports.sGui:setLabelText(fuelSumLabel, "Összesen: [color=sightblue]" .. fuelLiter .. " liter\n#ffffffVégösszeg: [color=sightgreen]" .. sightexports.sGui:thousandsStepper(sumPrice) .. " $")
    end
  end
end
addEvent("changeHeliFuelSlider", false)
addEventHandler("changeHeliFuelSlider", getRootElement(), refreshHeliFuelPrice)
addEvent("switchHeliPlateMode", false)
addEventHandler("switchHeliPlateMode", getRootElement(), function()
  plateMode = not plateMode
  createHeliWindow()
end)
addEvent("helicopterReapirShowPrompt", false)
addEventHandler("helicopterReapirShowPrompt", getRootElement(), function()
  if currentMenu == 2 then
    if fuelLiter <= 0 then
      sightexports.sGui:showInfobox("e", "0 litert nem tankolhatsz!")
      return
    end
  elseif currentMenu == 3 and plateMode then
    customPlate = sightexports.sGui:getInputValue(plateInput)
    if 0 >= utf8.len(customPlate) then
      sightexports.sGui:showInfobox("e", "Nem lehet üres a rendszám mező!")
      return
    end
  end
  deleteHeliWindow(true)
  local veh = getPedOccupiedVehicle(localPlayer)
  if veh ~= toReset and toReset then
    triggerServerEvent("resetHelicopterFix", localPlayer, toReset)
    toReset = false
  end
  if veh and getVehicleController(veh) == localPlayer and (getVehicleType(veh) == "Helicopter" or getVehicleType(veh) == "Boat") and getElementData(veh, "vehicle.dbID") then
    local titleBarHeight = sightexports.sGui:getTitleBarHeight()
    local pw = 350
    local ph = titleBarHeight + 8 + 24 + 8 + 96 + 8
    heliWindow = sightexports.sGui:createGuiElement("window", screenX / 2 - pw / 2, screenY / 2 - ph / 2, pw, ph)
    local title = ""
    if getVehicleType(veh) == "Boat" then
      title = "Hajó - "
    else
      title = "Helikopter - "
    end
    if currentMenu == 1 then
      title = title .. "Javítás"
    elseif currentMenu == 2 then
      title = title .. "Tankolás"
    elseif currentMenu == 3 then
      title = title .. "Rendszám"
    elseif currentMenu == 4 then
      title = title .. "Variáns"
    elseif currentMenu == 5 then
      title = title .. "Fényezés (#1)"
    elseif currentMenu == 6 then
      title = title .. "Fényezés (#2)"
    end
    sightexports.sGui:setWindowTitle(heliWindow, "16/BebasNeueRegular.otf", title)
    local y = titleBarHeight + 8
    local bw = (pw - 24) / 2
    local label = sightexports.sGui:createGuiElement("label", 0, y, pw, 32, heliWindow)
    sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
    sightexports.sGui:setLabelAlignment(label, "center", "center")
    sightexports.sGui:setLabelText(label, "Biztosan szeretnéd megvásárolni?")
    y = y + 32
    if currentMenu == 1 then
      local label = sightexports.sGui:createGuiElement("label", 0, y, pw, 32, heliWindow)
      sightexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
      sightexports.sGui:setLabelAlignment(label, "center", "center")
      sightexports.sGui:setLabelColor(label, "sightblue")
      sightexports.sGui:setLabelText(label, "Javítás")
      y = y + 32
      local label = sightexports.sGui:createGuiElement("label", 0, y, pw, 32, heliWindow)
      sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
      sightexports.sGui:setLabelAlignment(label, "center", "center")
      sightexports.sGui:setLabelText(label, "Fizetendő: [color=sightgreen]" .. sightexports.sGui:thousandsStepper(getItemPrice(veh, heliFixPrice)) .. " $")
      y = y + 32 + 8
    elseif currentMenu == 2 then
      local price = sightexports.sFuel:getHeliFuelPrices()
      local label = sightexports.sGui:createGuiElement("label", 0, y, pw, 32, heliWindow)
      sightexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
      sightexports.sGui:setLabelAlignment(label, "center", "center")
      sightexports.sGui:setLabelColor(label, "sightblue")
      sightexports.sGui:setLabelText(label, fuelLiter .. " liter üzemanyag (" .. price .. " $/l)")
      y = y + 32
      local sumPrice = math.ceil(fuelLiter * price)
      local label = sightexports.sGui:createGuiElement("label", 0, y, pw, 32, heliWindow)
      sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
      sightexports.sGui:setLabelAlignment(label, "center", "center")
      sightexports.sGui:setLabelText(label, "Fizetendő: [color=sightgreen]" .. sightexports.sGui:thousandsStepper(sumPrice) .. " $")
      y = y + 32 + 8
    elseif currentMenu == 3 then
      if plateMode then
        local price = sightexports.sTuning:getTuningPrice("customPlate", true)[2]
        local label = sightexports.sGui:createGuiElement("label", 0, y, pw, 32, heliWindow)
        sightexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
        sightexports.sGui:setLabelAlignment(label, "center", "center")
        sightexports.sGui:setLabelColor(label, "sightblue")
        sightexports.sGui:setLabelText(label, "Egyedi rendszám")
        y = y + 32
        local label = sightexports.sGui:createGuiElement("label", 0, y, pw, 32, heliWindow)
        sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
        sightexports.sGui:setLabelAlignment(label, "center", "center")
        sightexports.sGui:setLabelText(label, "Fizetendő: [color=sightblue]" .. sightexports.sGui:thousandsStepper(price) .. " PP")
        y = y + 32 + 8
      else
        local label = sightexports.sGui:createGuiElement("label", 0, y, pw, 32, heliWindow)
        sightexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
        sightexports.sGui:setLabelAlignment(label, "center", "center")
        sightexports.sGui:setLabelColor(label, "sightblue")
        sightexports.sGui:setLabelText(label, "Gyári rendszám")
        y = y + 32
        local label = sightexports.sGui:createGuiElement("label", 0, y, pw, 32, heliWindow)
        sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
        sightexports.sGui:setLabelAlignment(label, "center", "center")
        sightexports.sGui:setLabelText(label, "Fizetendő: [color=sightgreen]ingyenes")
        y = y + 32 + 8
      end
    elseif currentMenu == 4 then
      local price = sightexports.sTuning:getTuningPrice("variant", 1)[2]
      local label = sightexports.sGui:createGuiElement("label", 0, y, pw, 32, heliWindow)
      sightexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
      sightexports.sGui:setLabelAlignment(label, "center", "center")
      sightexports.sGui:setLabelColor(label, "sightblue")
      if selectedVariant == 0 then
        sightexports.sGui:setLabelText(label, "Variáns (nincs)")
      else
        sightexports.sGui:setLabelText(label, "Variáns (" .. selectedVariant .. ")")
      end
      y = y + 32
      local label = sightexports.sGui:createGuiElement("label", 0, y, pw, 32, heliWindow)
      sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
      sightexports.sGui:setLabelAlignment(label, "center", "center")
      sightexports.sGui:setLabelText(label, "Fizetendő: [color=sightgreen]" .. sightexports.sGui:thousandsStepper(price) .. " $")
      y = y + 32 + 8
    elseif currentMenu == 5 then
      local price = sightexports.sTuning:getTuningPrice("color", 1)[2]
      local label = sightexports.sGui:createGuiElement("label", 0, y, pw, 32, heliWindow)
      sightexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
      sightexports.sGui:setLabelAlignment(label, "center", "center")
      sightexports.sGui:setLabelColor(label, "sightblue")
      sightexports.sGui:setLabelText(label, "Fényezés - #1")
      y = y + 32
      local label = sightexports.sGui:createGuiElement("label", 0, y, pw, 32, heliWindow)
      sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
      sightexports.sGui:setLabelAlignment(label, "center", "center")
      sightexports.sGui:setLabelText(label, "Fizetendő: [color=sightgreen]" .. sightexports.sGui:thousandsStepper(price) .. " $")
      y = y + 32 + 8
    elseif currentMenu == 6 then
      local price = sightexports.sTuning:getTuningPrice("color", 1)[2]
      local label = sightexports.sGui:createGuiElement("label", 0, y, pw, 32, heliWindow)
      sightexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
      sightexports.sGui:setLabelAlignment(label, "center", "center")
      sightexports.sGui:setLabelColor(label, "sightblue")
      sightexports.sGui:setLabelText(label, "Fényezés - #2")
      y = y + 32
      local label = sightexports.sGui:createGuiElement("label", 0, y, pw, 32, heliWindow)
      sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
      sightexports.sGui:setLabelAlignment(label, "center", "center")
      sightexports.sGui:setLabelText(label, "Fizetendő: [color=sightgreen]" .. sightexports.sGui:thousandsStepper(price) .. " $")
      y = y + 32 + 8
    end
    local btn = sightexports.sGui:createGuiElement("button", 8, y, bw, 24, heliWindow)
    sightexports.sGui:setButtonFont(btn, "13/BebasNeueBold.otf")
    sightexports.sGui:setButtonTextColor(btn, "#ffffff")
    sightexports.sGui:setButtonText(btn, "Igen")
    sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
    sightexports.sGui:setGuiHover(btn, "gradient", {
      "sightgreen",
      "sightgreen-second"
    }, false, true)
    sightexports.sGui:setClickEvent(btn, "helicopterReapirPromptYes")
    local btn = sightexports.sGui:createGuiElement("button", pw / 2 + 4, y, bw, 24, heliWindow)
    sightexports.sGui:setButtonFont(btn, "13/BebasNeueBold.otf")
    sightexports.sGui:setButtonTextColor(btn, "#ffffff")
    sightexports.sGui:setButtonText(btn, "Nem")
    sightexports.sGui:setGuiBackground(btn, "solid", "sightred")
    sightexports.sGui:setGuiHover(btn, "gradient", {
      "sightred",
      "sightred-second"
    }, false, true)
    sightexports.sGui:setClickEvent(btn, "helicopterReapirPromptNo")
  end
  if heliWindow then
    addEventHandler("onClientPlayerVehicleExit", localPlayer, deleteExitHeli)
  end
end)
addEvent("helicopterReapirPromptYes", false)
addEventHandler("helicopterReapirPromptYes", getRootElement(), function()
  deleteHeliWindow(true)
  local veh = getPedOccupiedVehicle(localPlayer)
  if veh ~= toReset and toReset then
    triggerServerEvent("resetHelicopterFix", localPlayer, toReset)
    toReset = false
  end
  if veh and getVehicleController(veh) == localPlayer and (getVehicleType(veh) == "Helicopter" or getVehicleType(veh) == "Boat") and getElementData(veh, "vehicle.dbID") then
    local titleBarHeight = sightexports.sGui:getTitleBarHeight()
    local pw = 350
    local ph = titleBarHeight + 32
    heliWindow = sightexports.sGui:createGuiElement("window", screenX / 2 - pw / 2, screenY / 2 - ph / 2, pw, ph)
    local title = ""
    if getVehicleType(veh) == "Boat" then
      title = "Hajó - "
    else
      title = "Helikopter - "
    end
    if currentMenu == 1 then
      title = title .. "Javítás"
    elseif currentMenu == 2 then
      title = title .. "Tankolás"
    elseif currentMenu == 3 then
      title = title .. "Rendszám"
    elseif currentMenu == 4 then
      title = title .. "Variáns"
    elseif currentMenu == 5 then
      title = title .. "Fényezés (#1)"
    elseif currentMenu == 6 then
      title = title .. "Fényezés (#2)"
    end
    sightexports.sGui:setWindowTitle(heliWindow, "16/BebasNeueRegular.otf", title)
    local y = titleBarHeight
    local bw = (pw - 24) / 2
    local label = sightexports.sGui:createGuiElement("label", 0, y, pw, 32, heliWindow)
    sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
    sightexports.sGui:setLabelAlignment(label, "center", "center")
    sightexports.sGui:setLabelText(label, "Vásárlás folyamatban...")
    if currentMenu == 1 then
      triggerServerEvent("helicopterRepairJob", localPlayer)
    elseif currentMenu == 2 then
      triggerServerEvent("helicopterFueling", localPlayer, fuelLiter)
    elseif currentMenu == 3 then
      triggerServerEvent("buyHelicopterPlate", localPlayer, plateMode and customPlate or false)
    elseif currentMenu == 4 then
      triggerServerEvent("helicopterVariant", localPlayer, selectedVariant)
    elseif currentMenu == 5 then
      triggerServerEvent("helicopterColor", localPlayer, 1, colorPickerR, colorPickerG, colorPickerB)
    elseif currentMenu == 6 then
      triggerServerEvent("helicopterColor", localPlayer, 2, colorPickerR, colorPickerG, colorPickerB)
    end
  end
end)
addEvent("gotHeliFixResponse", true)
addEventHandler("gotHeliFixResponse", getRootElement(), function()
  if heliWindow then
    createHeliWindow()
  end
end)
addEvent("helicopterReapirPromptNo", false)
addEventHandler("helicopterReapirPromptNo", getRootElement(), function()
  createHeliWindow()
end)
addEvent("heliVariantChanged", false)
addEventHandler("heliVariantChanged", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  local veh = getPedOccupiedVehicle(localPlayer)
  if veh and getVehicleController(veh) == localPlayer and (getVehicleType(veh) == "Helicopter" or getVehicleType(veh) == "Boat") and getElementData(veh, "vehicle.dbID") then
    local val = 0
    for i = 0, 6 do
      if variantCheckboxes[i] == el then
        sightexports.sGui:setCheckboxChecked(variantCheckboxes[i], true)
        val = i
      else
        sightexports.sGui:setCheckboxChecked(variantCheckboxes[i], false)
      end
    end
    if 0 < val then
      setVehicleVariant(veh, val - 1, 255)
    else
      setVehicleVariant(veh, 255, 255)
    end
    selectedVariant = val
    toReset = veh
    triggerServerEvent("previewHelicopterVariant", localPlayer, veh, val)
  end
end)
function createHeliWindow()
  deleteHeliWindow(true)
  local veh = getPedOccupiedVehicle(localPlayer)
  if veh ~= toReset and toReset then
    triggerServerEvent("resetHelicopterFix", localPlayer, toReset)
    toReset = false
  end
  if veh and getVehicleController(veh) == localPlayer and (getVehicleType(veh) == "Helicopter" or getVehicleType(veh) == "Boat") and getElementData(veh, "vehicle.dbID") then
    local titleBarHeight = sightexports.sGui:getTitleBarHeight()
    local pw = 300
    local ph = titleBarHeight + 30
    if currentMenu == 1 then
      ph = ph + 96 + 8
    elseif currentMenu == 2 then
      ph = ph + 160 + 8
    elseif currentMenu == 3 then
      ph = ph + 8 + 24 + 8
      if plateMode then
        ph = ph + 32 + 8
      end
      ph = ph + 64 + 8
    elseif currentMenu == 4 then
      ph = ph + 168 + 64 + 8
    elseif currentMenu == 5 or currentMenu == 6 then
      ph = ph + 48 + 60 + 24 + 64
    end
    heliWindow = sightexports.sGui:createGuiElement("window", screenX / 2 - pw / 2, screenY / 2 - ph / 2, pw, ph)
    local title = ""
    if getVehicleType(veh) == "Boat" then
      title = "Hajó - "
    else
      title = "Helikopter - "
    end
    if currentMenu == 1 then
      title = title .. "Javítás"
    elseif currentMenu == 2 then
      title = title .. "Tankolás"
    elseif currentMenu == 3 then
      title = title .. "Rendszám"
    elseif currentMenu == 4 then
      title = title .. "Variáns"
    elseif currentMenu == 5 then
      title = title .. "Fényezés (#1)"
    elseif currentMenu == 6 then
      title = title .. "Fényezés (#2)"
    end
    sightexports.sGui:setWindowTitle(heliWindow, "16/BebasNeueRegular.otf", title)
    y = titleBarHeight + 30
    if currentMenu == 1 then
      local label = sightexports.sGui:createGuiElement("label", 0, y, pw, 32, heliWindow)
      sightexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
      sightexports.sGui:setLabelAlignment(label, "center", "center")
      local health = getElementHealth(veh)
      local r, g, b = getPartColor(health / 10)
      sightexports.sGui:setLabelText(label, "Állapot: " .. rgbToHex(r, g, b) .. math.floor(health / 10) .. " %")
      y = y + 32
      local label = sightexports.sGui:createGuiElement("label", 0, y, pw, 32, heliWindow)
      sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
      sightexports.sGui:setLabelAlignment(label, "center", "center")
      sightexports.sGui:setLabelText(label, "Javítás ára: [color=sightgreen]" .. sightexports.sGui:thousandsStepper(getItemPrice(veh, heliFixPrice)) .. " $")
      y = y + 32 + 8
      local btn = sightexports.sGui:createGuiElement("button", 8, y, pw - 16, 24, heliWindow)
      sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
      sightexports.sGui:setGuiHover(btn, "gradient", {
        "sightgreen",
        "sightgreen-second"
      }, false, true)
      sightexports.sGui:setButtonFont(btn, "13/BebasNeueBold.otf")
      sightexports.sGui:setButtonTextColor(btn, "#ffffff")
      sightexports.sGui:setButtonText(btn, "Javítás")
      sightexports.sGui:setClickEvent(btn, "helicopterReapirShowPrompt")
    elseif currentMenu == 2 then
      fuelPriceLabel = sightexports.sGui:createGuiElement("label", 0, y, pw, 32, heliWindow)
      sightexports.sGui:setLabelFont(fuelPriceLabel, "11/Ubuntu-R.ttf")
      sightexports.sGui:setLabelAlignment(fuelPriceLabel, "center", "center")
      y = y + 32
      fuelSlider = sightexports.sGui:createGuiElement("slider", 8, y + 16 - 8, pw - 16, 16, heliWindow)
      sightexports.sGui:setSliderChangeEvent(fuelSlider, "changeHeliFuelSlider")
      y = y + 32
      fuelSumLabel = sightexports.sGui:createGuiElement("label", 0, y, pw, 64, heliWindow)
      sightexports.sGui:setLabelFont(fuelSumLabel, "11/Ubuntu-R.ttf")
      sightexports.sGui:setLabelAlignment(fuelSumLabel, "center", "center")
      y = y + 64 + 8
      local btn = sightexports.sGui:createGuiElement("button", 8, y, pw - 16, 24, heliWindow)
      sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
      sightexports.sGui:setGuiHover(btn, "gradient", {
        "sightgreen",
        "sightgreen-second"
      }, false, true)
      sightexports.sGui:setButtonFont(btn, "13/BebasNeueBold.otf")
      sightexports.sGui:setButtonTextColor(btn, "#ffffff")
      sightexports.sGui:setButtonText(btn, "Tankolás")
      sightexports.sGui:setClickEvent(btn, "helicopterReapirShowPrompt")
      refreshHeliFuelPrice()
    elseif currentMenu == 3 then
      y = y + 8
      local bw = (pw - 24) / 2
      local btn = sightexports.sGui:createGuiElement("button", 8, y, bw, 24, heliWindow)
      sightexports.sGui:setButtonFont(btn, "13/BebasNeueBold.otf")
      sightexports.sGui:setButtonTextColor(btn, "#ffffff")
      sightexports.sGui:setButtonText(btn, "Gyári")
      if plateMode then
        sightexports.sGui:setGuiBackground(btn, "solid", "sightgrey1")
        sightexports.sGui:setGuiHover(btn, "gradient", {"sightgrey1", "sightgrey3"}, false, true)
        sightexports.sGui:setClickEvent(btn, "switchHeliPlateMode")
      else
        sightexports.sGui:setGuiHoverable(btn, false)
        sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
      end
      local btn = sightexports.sGui:createGuiElement("button", pw / 2 + 4, y, bw, 24, heliWindow)
      sightexports.sGui:setButtonFont(btn, "13/BebasNeueBold.otf")
      sightexports.sGui:setButtonTextColor(btn, "#ffffff")
      sightexports.sGui:setButtonText(btn, "Egyedi")
      if not plateMode then
        sightexports.sGui:setGuiBackground(btn, "solid", "sightgrey1")
        sightexports.sGui:setGuiHover(btn, "gradient", {"sightgrey1", "sightgrey3"}, false, true)
        sightexports.sGui:setClickEvent(btn, "switchHeliPlateMode")
      else
        sightexports.sGui:setGuiHoverable(btn, false)
        sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
      end
      y = y + 24 + 8
      if plateMode then
        plateInput = sightexports.sGui:createGuiElement("input", 8, y, pw - 16, 32, heliWindow)
        sightexports.sGui:setInputFont(plateInput, "10/Ubuntu-R.ttf")
        sightexports.sGui:setInputPlaceholder(plateInput, "Rendszám")
        sightexports.sGui:setInputValue(plateInput, getVehiclePlateText(veh))
        sightexports.sGui:setInputIcon(plateInput, "car")
        sightexports.sGui:setInputMaxLength(plateInput, 8)
        y = y + 32 + 8
        local price = sightexports.sTuning:getTuningPrice("customPlate", true)[2]
        local label = sightexports.sGui:createGuiElement("label", 0, y, pw, 32, heliWindow)
        sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
        sightexports.sGui:setLabelAlignment(label, "center", "center")
        sightexports.sGui:setLabelText(label, "Ár: [color=sightblue]" .. sightexports.sGui:thousandsStepper(price) .. " PP")
        y = y + 32 + 8
        local btn = sightexports.sGui:createGuiElement("button", 8, y, pw - 16, 24, heliWindow)
        sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
        sightexports.sGui:setGuiHover(btn, "gradient", {
          "sightgreen",
          "sightgreen-second"
        }, false, true)
        sightexports.sGui:setButtonFont(btn, "13/BebasNeueBold.otf")
        sightexports.sGui:setButtonTextColor(btn, "#ffffff")
        sightexports.sGui:setButtonText(btn, "Megvásárlás")
        sightexports.sGui:setClickEvent(btn, "helicopterReapirShowPrompt")
      else
        local label = sightexports.sGui:createGuiElement("label", 0, y, pw, 32, heliWindow)
        sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
        sightexports.sGui:setLabelAlignment(label, "center", "center")
        sightexports.sGui:setLabelText(label, "Ár: [color=sightgreen]ingyenes")
        y = y + 32 + 8
        local btn = sightexports.sGui:createGuiElement("button", 8, y, pw - 16, 24, heliWindow)
        sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
        sightexports.sGui:setGuiHover(btn, "gradient", {
          "sightgreen",
          "sightgreen-second"
        }, false, true)
        sightexports.sGui:setButtonFont(btn, "13/BebasNeueBold.otf")
        sightexports.sGui:setButtonTextColor(btn, "#ffffff")
        sightexports.sGui:setButtonText(btn, "Megvásárlás")
        sightexports.sGui:setClickEvent(btn, "helicopterReapirShowPrompt")
      end
    elseif currentMenu == 4 then
      variantCheckboxes[0] = sightexports.sGui:createGuiElement("checkbox", 8, y, 24, 24, heliWindow)
      sightexports.sGui:setGuiColorScheme(variantCheckboxes[0], "darker")
      sightexports.sGui:setClickEvent(variantCheckboxes[0], "heliVariantChanged")
      local label = sightexports.sGui:createGuiElement("label", 36, y, 0, 24, heliWindow)
      sightexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
      sightexports.sGui:setLabelAlignment(label, "left", "center")
      sightexports.sGui:setLabelText(label, "Nincs variáns")
      y = y + 24
      for i = 1, 6 do
        variantCheckboxes[i] = sightexports.sGui:createGuiElement("checkbox", 8, y, 24, 24, heliWindow)
        sightexports.sGui:setGuiColorScheme(variantCheckboxes[i], "darker")
        sightexports.sGui:setClickEvent(variantCheckboxes[i], "heliVariantChanged")
        local label = sightexports.sGui:createGuiElement("label", 36, y, 0, 24, heliWindow)
        sightexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
        sightexports.sGui:setLabelAlignment(label, "left", "center")
        sightexports.sGui:setLabelText(label, i .. ". variáns")
        y = y + 24
      end
      local var = getVehicleVariant(veh)
      if 0 <= var and var <= 6 then
        var = var + 1
      else
        var = 0
      end
      selectedVariant = var
      sightexports.sGui:setCheckboxChecked(variantCheckboxes[var], true)
      local price = sightexports.sTuning:getTuningPrice("variant", 1)[2]
      local label = sightexports.sGui:createGuiElement("label", 0, y, pw, 32, heliWindow)
      sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
      sightexports.sGui:setLabelAlignment(label, "center", "center")
      sightexports.sGui:setLabelText(label, "Ár: [color=sightgreen]" .. sightexports.sGui:thousandsStepper(price) .. " $")
      y = y + 32 + 8
      local btn = sightexports.sGui:createGuiElement("button", 8, y, pw - 16, 24, heliWindow)
      sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
      sightexports.sGui:setGuiHover(btn, "gradient", {
        "sightgreen",
        "sightgreen-second"
      }, false, true)
      sightexports.sGui:setButtonFont(btn, "13/BebasNeueBold.otf")
      sightexports.sGui:setButtonTextColor(btn, "#ffffff")
      sightexports.sGui:setButtonText(btn, "Megvásárlás")
      sightexports.sGui:setClickEvent(btn, "helicopterReapirShowPrompt")
    elseif currentMenu == 5 or currentMenu == 6 then
      local x = 0
      y = y + 8
      bcgH1 = sightexports.sGui:createGuiElement("rectangle", x + 8 + 10, y + 10 - 6, pw - 16 - 20, 12, heliWindow)
      bcgH2 = sightexports.sGui:createGuiElement("image", x + 8 + 10, y + 10 - 6, pw - 16 - 20, 12, heliWindow)
      sightexports.sGui:setImageDDS(bcgH2, ":sTuning/files/col3.dds")
      bcgH3 = sightexports.sGui:createGuiElement("rectangle", x + 8 + 10, y + 10 - 6, pw - 16 - 20, 12, heliWindow)
      sliderH = sightexports.sGui:createGuiElement("slider", x + 8, y, pw - 16, 20, heliWindow)
      sightexports.sGui:setSliderSize(sliderH, 20)
      sightexports.sGui:setSliderBorder(sliderH, {
        0,
        0,
        0
      }, 1)
      sightexports.sGui:setSliderChangeEvent(sliderH, "heliColorPickerChanged")
      y = y + 20 + 8
      bcgS1 = sightexports.sGui:createGuiElement("rectangle", x + 8 + 10, y + 10 - 6, pw - 16 - 20, 12, heliWindow)
      bcgS2 = sightexports.sGui:createGuiElement("image", x + 8 + 10, y + 10 - 6, pw - 16 - 20, 12, heliWindow)
      sightexports.sGui:setImageDDS(bcgS2, ":sTuning/files/col1.dds")
      sliderS = sightexports.sGui:createGuiElement("slider", x + 8, y, pw - 16, 20, heliWindow)
      sightexports.sGui:setSliderSize(sliderS, 20)
      sightexports.sGui:setSliderBorder(sliderS, {
        0,
        0,
        0
      }, 1)
      sightexports.sGui:setSliderChangeEvent(sliderS, "heliColorPickerChanged")
      y = y + 20 + 8
      bcgL1 = sightexports.sGui:createGuiElement("rectangle", x + 8 + 10, y + 10 - 6, (pw - 16 - 20) / 2, 12, heliWindow)
      sightexports.sGui:setGuiBackground(bcgL1, "solid", {
        0,
        0,
        0
      })
      bcgL2 = sightexports.sGui:createGuiElement("rectangle", x + 8 + 10 + (pw - 16 - 20) / 2, y + 10 - 6, (pw - 16 - 20) / 2, 12, heliWindow)
      sightexports.sGui:setGuiBackground(bcgL2, "solid", {
        255,
        255,
        255
      })
      bcgL3 = sightexports.sGui:createGuiElement("image", x + 8 + 10, y + 10 - 6, pw - 16 - 20, 12, heliWindow)
      sightexports.sGui:setImageDDS(bcgL3, ":sTuning/files/col2.dds")
      sliderL = sightexports.sGui:createGuiElement("slider", x + 8, y, pw - 16, 20, heliWindow)
      sightexports.sGui:setSliderSize(sliderL, 20)
      sightexports.sGui:setSliderBorder(sliderL, {
        0,
        0,
        0
      }, 1)
      sightexports.sGui:setSliderChangeEvent(sliderL, "heliColorPickerChanged")
      y = y + 20 + 8
      colorHexInput = sightexports.sGui:createGuiElement("input", x + pw / 2 - 50, y, 100, 24, heliWindow)
      sightexports.sGui:setInputPlaceholder(colorHexInput, "HEX színkód")
      sightexports.sGui:setInputValue(colorHexInput, "FF0000")
      sightexports.sGui:setInputFont(colorHexInput, "10/Ubuntu-R.ttf")
      sightexports.sGui:setInputIcon(colorHexInput, "hashtag")
      sightexports.sGui:setInputMaxLength(colorHexInput, 6)
      sightexports.sGui:setInputChangeEvent(colorHexInput, "refreshHeliPickerInput")
      local h, s, l = 0, 0, 1
      local col = {
        getVehicleColor(veh, true)
      }
      if currentMenu == 5 then
        h, s, l = convertRGBToHSL(col[1], col[2], col[3])
      elseif currentMenu == 6 then
        h, s, l = convertRGBToHSL(col[4], col[5], col[6])
      end
      sightexports.sGui:setSliderValue(sliderH, h)
      sightexports.sGui:setSliderValue(sliderS, s)
      sightexports.sGui:setSliderValue(sliderL, l)
      refreshColorPicker(true)
      y = y + 24 + 8
      local price = sightexports.sTuning:getTuningPrice("color", 1)[2]
      local label = sightexports.sGui:createGuiElement("label", 0, y, pw, 32, heliWindow)
      sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
      sightexports.sGui:setLabelAlignment(label, "center", "center")
      sightexports.sGui:setLabelText(label, "Ár: [color=sightgreen]" .. sightexports.sGui:thousandsStepper(price) .. " $")
      y = y + 32 + 8
      local btn = sightexports.sGui:createGuiElement("button", 8, y, pw - 16, 24, heliWindow)
      sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
      sightexports.sGui:setGuiHover(btn, "gradient", {
        "sightgreen",
        "sightgreen-second"
      }, false, true)
      sightexports.sGui:setButtonFont(btn, "13/BebasNeueBold.otf")
      sightexports.sGui:setButtonTextColor(btn, "#ffffff")
      sightexports.sGui:setButtonText(btn, "Megvásárlás")
      sightexports.sGui:setClickEvent(btn, "helicopterReapirShowPrompt")
    end
    local w = pw / 6
    local x = 0
    local btn = sightexports.sGui:createGuiElement("button", x, titleBarHeight - 1, w, 31, heliWindow)
    if currentMenu == 1 then
      sightexports.sGui:setGuiBackground(btn, "solid", "sightgrey2")
      sightexports.sGui:setGuiHoverable(btn, false)
    else
      sightexports.sGui:setGuiBackground(btn, "solid", "sightgrey1")
      sightexports.sGui:setGuiHover(btn, "gradient", {"sightgrey1", "sightgrey3"}, false, true)
      sightexports.sGui:setClickEvent(btn, "changeHeliServiceMenu")
      menuButtons[btn] = 1
    end
    sightexports.sGui:setButtonFont(btn, "13/BebasNeueRegular.otf")
    sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("wrench", 30))
    sightexports.sGui:guiSetTooltip(btn, "Javítás")
    x = x + w
    local btn = sightexports.sGui:createGuiElement("button", x, titleBarHeight - 1, w, 31, heliWindow)
    if currentMenu == 2 then
      sightexports.sGui:setGuiBackground(btn, "solid", "sightgrey2")
      sightexports.sGui:setGuiHoverable(btn, false)
    else
      sightexports.sGui:setGuiBackground(btn, "solid", "sightgrey1")
      sightexports.sGui:setGuiHover(btn, "gradient", {"sightgrey1", "sightgrey3"}, false, true)
      sightexports.sGui:setClickEvent(btn, "changeHeliServiceMenu")
      menuButtons[btn] = 2
    end
    sightexports.sGui:setButtonFont(btn, "13/BebasNeueRegular.otf")
    sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("gas-pump", 30))
    sightexports.sGui:guiSetTooltip(btn, "Tankolás")
    x = x + w
    local btn = sightexports.sGui:createGuiElement("button", x, titleBarHeight - 1, w, 31, heliWindow)
    if currentMenu == 3 then
      sightexports.sGui:setGuiBackground(btn, "solid", "sightgrey2")
      sightexports.sGui:setGuiHoverable(btn, false)
    else
      sightexports.sGui:setGuiBackground(btn, "solid", "sightgrey1")
      sightexports.sGui:setGuiHover(btn, "gradient", {"sightgrey1", "sightgrey3"}, false, true)
      sightexports.sGui:setClickEvent(btn, "changeHeliServiceMenu")
      menuButtons[btn] = 3
    end
    sightexports.sGui:setButtonFont(btn, "13/BebasNeueRegular.otf")
    sightexports.sGui:setButtonIconDDS(btn, ":sTuning/files/icons/plate.dds")
    sightexports.sGui:guiSetTooltip(btn, "Rendszám")
    x = x + w
    local btn = sightexports.sGui:createGuiElement("button", x, titleBarHeight - 1, w, 31, heliWindow)
    if currentMenu == 4 then
      sightexports.sGui:setGuiBackground(btn, "solid", "sightgrey2")
      sightexports.sGui:setGuiHoverable(btn, false)
    else
      sightexports.sGui:setGuiBackground(btn, "solid", "sightgrey1")
      sightexports.sGui:setGuiHover(btn, "gradient", {"sightgrey1", "sightgrey3"}, false, true)
      sightexports.sGui:setClickEvent(btn, "changeHeliServiceMenu")
      menuButtons[btn] = 4
    end
    sightexports.sGui:setButtonFont(btn, "13/BebasNeueRegular.otf")
    sightexports.sGui:setButtonIconDDS(btn, ":sTuning/files/icons/variant.dds")
    sightexports.sGui:guiSetTooltip(btn, "Variáns")
    x = x + w
    local btn = sightexports.sGui:createGuiElement("button", x, titleBarHeight - 1, w, 31, heliWindow)
    if currentMenu == 5 then
      sightexports.sGui:setGuiBackground(btn, "solid", "sightgrey2")
      sightexports.sGui:setGuiHoverable(btn, false)
    else
      sightexports.sGui:setGuiBackground(btn, "solid", "sightgrey1")
      sightexports.sGui:setGuiHover(btn, "gradient", {"sightgrey1", "sightgrey3"}, false, true)
      sightexports.sGui:setClickEvent(btn, "changeHeliServiceMenu")
      menuButtons[btn] = 5
    end
    sightexports.sGui:setButtonFont(btn, "13/BebasNeueRegular.otf")
    sightexports.sGui:setButtonIconDDS(btn, ":sTuning/files/icons/fenyezes.dds")
    sightexports.sGui:guiSetTooltip(btn, "Fényezés (#1)")
    x = x + w
    local btn = sightexports.sGui:createGuiElement("button", x, titleBarHeight - 1, w, 31, heliWindow)
    if currentMenu == 6 then
      sightexports.sGui:setGuiBackground(btn, "solid", "sightgrey2")
      sightexports.sGui:setGuiHoverable(btn, false)
    else
      sightexports.sGui:setGuiBackground(btn, "solid", "sightgrey1")
      sightexports.sGui:setGuiHover(btn, "gradient", {"sightgrey1", "sightgrey3"}, false, true)
      sightexports.sGui:setClickEvent(btn, "changeHeliServiceMenu")
      menuButtons[btn] = 6
    end
    sightexports.sGui:setButtonFont(btn, "13/BebasNeueRegular.otf")
    sightexports.sGui:setButtonIconDDS(btn, ":sTuning/files/icons/fenyezes.dds")
    sightexports.sGui:guiSetTooltip(btn, "Fényezés (#2)")
    x = x + w
    local model = getElementModel(veh)
  end
  if heliWindow then
    addEventHandler("onClientPlayerVehicleExit", localPlayer, deleteExitHeli)
  end
end
