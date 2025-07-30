local sightexports = {
  sPermission = false,
  sGui = false,
  sItems = false
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
addCommandHandler("nearbypeds", function(cmd)
  if sightexports.sPermission:hasPermission(localPlayer, "nearbyPeds") then
    outputChatBox("[color=sightgreen][SightMTA - Bolt]: #FFFFFFKözeledben lévő pedek:", 255, 255, 255, true)
    local px, py, pz = getElementPosition(localPlayer)
    local int = getElementInterior(localPlayer)
    local dim = getElementDimension(localPlayer)
    for id in pairs(pedDatas) do
      if pedDatas[id].interior == int and pedDatas[id].dimension == dim and getDistanceBetweenPoints3D(px, py, pz, pedDatas[id].posX, pedDatas[id].posY, pedDatas[id].posZ) <= 25 then
        outputChatBox("   [color=sightgreen]" .. pedDatas[id].name .. "#ffffff - ID: [color=sightblue]" .. id, 255, 255, 255, true)
      end
    end
  end
end)
wizardWindow = false
local wizardData = false
local wizardElements = {}
function wizardNextStep()
  if wizardData.step == 1 then
    wizardData.name = utf8.gsub(sightexports.sGui:getInputValue(wizardElements[1]) or "", " ", "_")
    wizardData.skin = sightexports.sGui:getInputValue(wizardElements[2])
    if wizardData.owner == "interior" then
      wizardData.ownerId = sightexports.sGui:getInputValue(wizardElements[5])
    elseif wizardData.owner == "group" then
      wizardData.ownerId = sightexports.sGui:getInputValue(wizardElements[7])
    elseif wizardData.owner == "char" then
      wizardData.ownerId = sightexports.sGui:getInputValue(wizardElements[9])
    end
  end
  wizardData.step = wizardData.step + 1
  if wizardData.step > 3 then
    triggerLatentServerEvent("donePedInit", localPlayer, wizardData.pedId, wizardData.name, wizardData.skin, wizardData.owner, wizardData.ownerId, wizardData.selectedItems)
    deletePedInstaller()
    wizardData = nil
  else
    createPedInstaller()
  end
end
function wizardScroll(key)
  if wizardData.wholesale then
    if not wizardData.wpEditingInput then
      if key == "mouse_wheel_up" then
        if wizardData.itemScroll > 0 then
          wizardData.itemScroll = wizardData.itemScroll - 1
          wizardRefresh()
        end
      elseif key == "mouse_wheel_down" then
        local items = predefCategories[wizardData.selectedPredefCat]
        if wizardData.itemScroll < #items - 8 then
          wizardData.itemScroll = wizardData.itemScroll + 1
          wizardRefresh()
        end
      end
    end
  elseif wizardData.step == 2 then
    if key == "mouse_wheel_up" then
      if wizardData.itemScroll > 0 then
        wizardData.itemScroll = wizardData.itemScroll - 1
        wizardRefresh()
      end
    elseif key == "mouse_wheel_down" then
      local items = predefCategories[wizardData.selectedPredefCat]
      if wizardData.itemScroll < #items - 8 then
        wizardData.itemScroll = wizardData.itemScroll + 1
        wizardRefresh()
      end
    end
  end
end
function wizardRefresh()
  if wizardData.wholesale then
    local items = predefCategories[wizardData.selectedPredefCat]
    for i = 1, 8 do
      if items[i + wizardData.itemScroll] then
        sightexports.sGui:setGuiRenderDisabled(wizardElements[(i - 1) * 3 + 1], false)
        sightexports.sGui:setGuiRenderDisabled(wizardElements[(i - 1) * 3 + 2], false)
        sightexports.sGui:setGuiRenderDisabled(wizardElements[(i - 1) * 3 + 3], false)
        sightexports.sGui:setImageFile(wizardElements[(i - 1) * 3 + 1], ":sItems/" .. sightexports.sItems:getItemPic(items[i + wizardData.itemScroll]))
        sightexports.sGui:setLabelText(wizardElements[(i - 1) * 3 + 2], sightexports.sItems:getItemName(items[i + wizardData.itemScroll]) .. " " .. sightexports.sGui:getColorCodeHex("sightlightgrey") .. items[i + wizardData.itemScroll])
        sightexports.sGui:setButtonText(wizardElements[(i - 1) * 3 + 3], sightexports.sGui:thousandsStepper(getPedPrice(wizardData.wholesale, items[i + wizardData.itemScroll])) .. " $")
      else
        sightexports.sGui:setGuiRenderDisabled(wizardElements[(i - 1) * 3 + 1], true)
        sightexports.sGui:setGuiRenderDisabled(wizardElements[(i - 1) * 3 + 2], true)
        sightexports.sGui:setGuiRenderDisabled(wizardElements[(i - 1) * 3 + 3], true)
      end
    end
    local n = 24
    local sh = wizardData.itemSH / math.max(1, #items - 8 + 1)
    sightexports.sGui:setGuiSize(wizardElements[n + 1], false, sh)
    sightexports.sGui:setGuiPosition(wizardElements[n + 1], false, sh * wizardData.itemScroll)
    for i = 1, #predefCategoryNames do
      if wizardData.selectedPredefCat == i then
        sightexports.sGui:setGuiBackground(wizardElements[n + 1 + i], "solid", "sightgreen")
        sightexports.sGui:setGuiHover(wizardElements[n + 1 + i], "gradient", {
          "sightgreen",
          "sightgreen-second"
        }, false, true)
      else
        sightexports.sGui:setGuiBackground(wizardElements[n + 1 + i], "solid", "sightgrey1")
        sightexports.sGui:setGuiHover(wizardElements[n + 1 + i], "gradient", {"sightgrey1", "sightgrey2"}, false, true)
      end
    end
  elseif wizardData.step == 1 then
    sightexports.sGui:setCheckboxChecked(wizardElements[3], wizardData.owner == "server")
    sightexports.sGui:setCheckboxChecked(wizardElements[4], wizardData.owner == "interior")
    sightexports.sGui:setGuiRenderDisabled(wizardElements[5], wizardData.owner ~= "interior")
    sightexports.sGui:setCheckboxChecked(wizardElements[6], wizardData.owner == "group")
    sightexports.sGui:setGuiRenderDisabled(wizardElements[7], wizardData.owner ~= "group")
    sightexports.sGui:setCheckboxChecked(wizardElements[8], wizardData.owner == "char")
    sightexports.sGui:setGuiRenderDisabled(wizardElements[9], wizardData.owner ~= "char")
  elseif wizardData.step == 2 then
    local items = predefCategories[wizardData.selectedPredefCat]
    for i = 1, 8 do
      if items[i + wizardData.itemScroll] then
        sightexports.sGui:setGuiRenderDisabled(wizardElements[(i - 1) * 3 + 1], false)
        sightexports.sGui:setGuiRenderDisabled(wizardElements[(i - 1) * 3 + 2], false)
        sightexports.sGui:setGuiRenderDisabled(wizardElements[(i - 1) * 3 + 3], false)
        sightexports.sGui:setImageFile(wizardElements[(i - 1) * 3 + 1], ":sItems/" .. sightexports.sItems:getItemPic(items[i + wizardData.itemScroll]))
        sightexports.sGui:setLabelText(wizardElements[(i - 1) * 3 + 2], sightexports.sItems:getItemName(items[i + wizardData.itemScroll]) .. " " .. sightexports.sGui:getColorCodeHex("sightlightgrey") .. items[i + wizardData.itemScroll])
        sightexports.sGui:setCheckboxChecked(wizardElements[(i - 1) * 3 + 3], wizardData.selectedItems[items[i + wizardData.itemScroll]])
      else
        sightexports.sGui:setGuiRenderDisabled(wizardElements[(i - 1) * 3 + 1], true)
        sightexports.sGui:setGuiRenderDisabled(wizardElements[(i - 1) * 3 + 2], true)
        sightexports.sGui:setGuiRenderDisabled(wizardElements[(i - 1) * 3 + 3], true)
      end
    end
    local n = 24
    local sh = wizardData.itemSH / math.max(1, #items - 8 + 1)
    sightexports.sGui:setGuiSize(wizardElements[n + 1], false, sh)
    sightexports.sGui:setGuiPosition(wizardElements[n + 1], false, sh * wizardData.itemScroll)
    for i = 1, #predefCategoryNames do
      if wizardData.selectedPredefCat == i then
        sightexports.sGui:setGuiBackground(wizardElements[n + 1 + i], "solid", "sightgreen")
        sightexports.sGui:setGuiHover(wizardElements[n + 1 + i], "gradient", {
          "sightgreen",
          "sightgreen-second"
        }, false, true)
      else
        sightexports.sGui:setGuiBackground(wizardElements[n + 1 + i], "solid", "sightgrey1")
        sightexports.sGui:setGuiHover(wizardElements[n + 1 + i], "gradient", {"sightgrey1", "sightgrey2"}, false, true)
      end
    end
  end
end
addEvent("pedShopWizardSaveWP", false)
addEventHandler("pedShopWizardSaveWP", getRootElement(), function()
  if wizardData.wpEditingItem then
    local val = tonumber(sightexports.sGui:getInputValue(wizardData.wpEditingInput)) or 0
    if 1 < val then
      wizardData.wholesale[wizardData.wpEditingItem] = val
    else
      sightexports.sGui:showInfobox("e", "Minimum nagyker ár: 1 $")
      return
    end
  end
  triggerLatentServerEvent("editPedShopWholesalePrice", localPlayer, wizardData.wpEditingItem, wizardData.wholesale[wizardData.wpEditingItem])
  wizardData.wpEditingItem = false
  if wizardData.wpEditingInput then
    sightexports.sGui:deleteGuiElement(wizardData.wpEditingInput)
  end
  wizardData.wpEditingInput = nil
  if wizardData.wpEditingButton then
    sightexports.sGui:deleteGuiElement(wizardData.wpEditingButton)
  end
  wizardData.wpEditingButton = nil
  wizardRefresh()
end)
addEvent("pedShopWizardEditWP", false)
addEventHandler("pedShopWizardEditWP", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  local items = predefCategories[wizardData.selectedPredefCat]
  for i = 1, 8 do
    if items[i + wizardData.itemScroll] and el == wizardElements[(i - 1) * 3 + 3] then
      wizardData.wpEditingItem = items[i + wizardData.itemScroll]
      if wizardData.wpEditingInput then
        sightexports.sGui:deleteGuiElement(wizardData.wpEditingInput)
      end
      if wizardData.wpEditingButton then
        sightexports.sGui:deleteGuiElement(wizardData.wpEditingButton)
      end
      local x, y = sightexports.sGui:getGuiPosition(el)
      local sx, sy = sightexports.sGui:getGuiSize(el)
      wizardData.wpEditingInput = sightexports.sGui:createGuiElement("input", x, y, sx - 20, sy, wizardWindow)
      sightexports.sGui:setInputPlaceholder(wizardData.wpEditingInput, "Nagyker ár")
      sightexports.sGui:setInputFont(wizardData.wpEditingInput, "10/Ubuntu-R.ttf")
      sightexports.sGui:setInputNumberOnly(wizardData.wpEditingInput, true)
      sightexports.sGui:setInputValue(wizardData.wpEditingInput, getPedPrice(wizardData.wholesale, items[i + wizardData.itemScroll]))
      sightexports.sGui:setActiveInput(wizardData.wpEditingInput)
      wizardData.wpEditingButton = sightexports.sGui:createGuiElement("button", x + sx - 20, y, 20, sy, wizardWindow)
      sightexports.sGui:setGuiBackground(wizardData.wpEditingButton, "solid", "sightgreen")
      sightexports.sGui:setGuiHover(wizardData.wpEditingButton, "gradient", {
        "sightgreen",
        "sightgreen-second"
      }, false, true)
      sightexports.sGui:setButtonFont(wizardData.wpEditingButton, "12/BebasNeueBold.otf")
      sightexports.sGui:setButtonIcon(wizardData.wpEditingButton, sightexports.sGui:getFaIconFilename("caret-right", 24))
      sightexports.sGui:setClickEvent(wizardData.wpEditingButton, "pedShopWizardSaveWP", true)
      break
    end
  end
end)
addEvent("pedShopWizardPrevStep", false)
addEventHandler("pedShopWizardPrevStep", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  wizardData.step = wizardData.step - 1
  createPedInstaller()
end)
addEvent("pedShopWizardNextStep", false)
addEventHandler("pedShopWizardNextStep", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  wizardNextStep()
end)
addEvent("pedShopWizardSelectOwner", false)
addEventHandler("pedShopWizardSelectOwner", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  if el == wizardElements[3] then
    wizardData.owner = "server"
    wizardData.ownerId = false
  elseif el == wizardElements[4] then
    wizardData.owner = "interior"
    wizardData.ownerId = sightexports.sGui:getInputValue(wizardElements[5])
  elseif el == wizardElements[6] then
    wizardData.owner = "group"
    wizardData.ownerId = sightexports.sGui:getInputValue(wizardElements[7])
  elseif el == wizardElements[8] then
    wizardData.owner = "char"
    wizardData.ownerId = sightexports.sGui:getInputValue(wizardElements[9])
  end
  wizardRefresh()
end)
function calcCategorySelected(cat)
  for cat = 1, #predefCategoryNames do
    local items = predefCategories[cat]
    local c = 0
    for i = 1, #items do
      if wizardData.selectedItems[items[i]] then
        c = c + 1
      end
    end
    local n = 24
    sightexports.sGui:setButtonText(wizardElements[n + 1 + cat], predefCategoryNames[cat] .. " (" .. c .. "/" .. #items .. ")")
  end
end
addEvent("pedShopWizardSelectItem", false)
addEventHandler("pedShopWizardSelectItem", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  local items = predefCategories[wizardData.selectedPredefCat]
  for i = 1, 8 do
    if items[i + wizardData.itemScroll] then
      if sightexports.sGui:isCheckboxChecked(wizardElements[(i - 1) * 3 + 3]) then
        wizardData.selectedItems[items[i + wizardData.itemScroll]] = true
      else
        wizardData.selectedItems[items[i + wizardData.itemScroll]] = nil
      end
    end
  end
  calcCategorySelected()
end)
addEvent("pedShopWizardDeselectAllItem", false)
addEventHandler("pedShopWizardDeselectAllItem", getRootElement(), function()
  local items = predefCategories[wizardData.selectedPredefCat]
  for j = 1, #items do
    wizardData.selectedItems[items[j]] = nil
  end
  wizardRefresh()
  calcCategorySelected()
end)
addEvent("pedShopWizardSelectAllItem", false)
addEventHandler("pedShopWizardSelectAllItem", getRootElement(), function()
  local items = predefCategories[wizardData.selectedPredefCat]
  for j = 1, #items do
    wizardData.selectedItems[items[j]] = true
  end
  wizardRefresh()
  calcCategorySelected()
end)
addEvent("pedShopWizardSelectCategory", false)
addEventHandler("pedShopWizardSelectCategory", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  local n = 24
  for i = 1, #predefCategoryNames do
    if el == wizardElements[n + 1 + i] then
      if wizardData.step == 2 then
        if wizardData.selectedPredefCat == i then
          local items = predefCategories[wizardData.selectedPredefCat]
          for j = 1, #items do
            if button == "left" then
              wizardData.selectedItems[items[j]] = true
            else
              wizardData.selectedItems[items[j]] = nil
            end
          end
          calcCategorySelected()
        else
          wizardData.itemScroll = 0
        end
      else
        wizardData.itemScroll = 0
      end
      wizardData.selectedPredefCat = i
      break
    end
  end
  wizardRefresh()
end)
function deletePedInstaller()
  showCursor(false)
  if wizardWindow then
    sightexports.sGui:deleteGuiElement(wizardWindow)
  end
  wizardWindow = false
  wizardElements = {}
  if wizardData.scrollHandled then
    wizardData.scrollHandled = nil
    removeEventHandler("onClientKey", getRootElement(), wizardScroll)
  end
end
addEvent("closePedShopWizard", false)
addEventHandler("closePedShopWizard", getRootElement(), function()
  deletePedInstaller()
  wizardData = {}
end)
function createPedInstaller()
  deletePedInstaller()
  local titleBarHeight = sightexports.sGui:getTitleBarHeight()
  local w, h = 600, titleBarHeight + 300 + 32
  showCursor(true)
  wizardWindow = sightexports.sGui:createGuiElement("window", screenX / 2 - w / 2, screenY / 2 - h / 2, w, h)
  sightexports.sGui:setWindowTitle(wizardWindow, "16/BebasNeueRegular.otf", "Bolt NPC #" .. wizardData.pedId)
  sightexports.sGui:setWindowCloseButton(wizardWindow, "closePedShopWizard")
  local img = sightexports.sGui:createGuiElement("image", 0, titleBarHeight, 164, 300, wizardWindow)
  sightexports.sGui:setImageFile(img, ":sPeds/files/wiz.png")
  local border = sightexports.sGui:createGuiElement("hr", 0, h - 32 - 1, w, 2, wizardWindow)
  local x = 170
  local y = titleBarHeight
  if wizardData.step == 1 then
    local titleLabel = sightexports.sGui:createGuiElement("label", x, y, 0, 32, wizardWindow)
    sightexports.sGui:setLabelAlignment(titleLabel, "left", "center")
    sightexports.sGui:setLabelFont(titleLabel, "15/BebasNeueBold.otf")
    sightexports.sGui:setLabelText(titleLabel, "NPC alapadatok")
    y = y + 32 + 12
    wizardElements[1] = sightexports.sGui:createGuiElement("input", x, y, w - 164 - 12, 30, wizardWindow)
    sightexports.sGui:setInputPlaceholder(wizardElements[1], "NPC neve")
    sightexports.sGui:setInputFont(wizardElements[1], "10/Ubuntu-R.ttf")
    sightexports.sGui:setInputIcon(wizardElements[1], "tag")
    sightexports.sGui:setInputMaxLength(wizardElements[1], 32)
    sightexports.sGui:setInputValue(wizardElements[1], wizardData.name or "")
    y = y + 30 + 6
    wizardElements[2] = sightexports.sGui:createGuiElement("input", x, y, w - 164 - 12, 30, wizardWindow)
    sightexports.sGui:setInputPlaceholder(wizardElements[2], "NPC skin")
    sightexports.sGui:setInputFont(wizardElements[2], "10/Ubuntu-R.ttf")
    sightexports.sGui:setInputIcon(wizardElements[2], "user-tie")
    sightexports.sGui:setInputMaxLength(wizardElements[2], 3)
    sightexports.sGui:setInputNumberOnly(wizardElements[2], true)
    sightexports.sGui:setInputValue(wizardElements[2], wizardData.skin or "")
    y = y + 30 + 6
    local titleLabel = sightexports.sGui:createGuiElement("label", x, y, 0, 36, wizardWindow)
    sightexports.sGui:setLabelAlignment(titleLabel, "left", "center")
    sightexports.sGui:setLabelFont(titleLabel, "11/Ubuntu-R.ttf")
    sightexports.sGui:setLabelText(titleLabel, "Tulajdonos:")
    y = y + 30 + 6
    wizardElements[3] = sightexports.sGui:createGuiElement("checkbox", x, y, 100, 30, wizardWindow)
    sightexports.sGui:setGuiColorScheme(wizardElements[3], "dark")
    sightexports.sGui:setCheckboxText(wizardElements[3], "Szerver")
    sightexports.sGui:setClickEvent(wizardElements[3], "pedShopWizardSelectOwner")
    y = y + 30 + 6
    wizardElements[4] = sightexports.sGui:createGuiElement("checkbox", x, y, 100, 30, wizardWindow)
    sightexports.sGui:setGuiColorScheme(wizardElements[4], "dark")
    sightexports.sGui:setCheckboxText(wizardElements[4], "Ingatlan")
    sightexports.sGui:setClickEvent(wizardElements[4], "pedShopWizardSelectOwner")
    wizardElements[5] = sightexports.sGui:createGuiElement("input", x + 100, y, w - 164 - 12 - 100, 30, wizardWindow)
    sightexports.sGui:setInputPlaceholder(wizardElements[5], "Inti ID")
    sightexports.sGui:setInputFont(wizardElements[5], "10/Ubuntu-R.ttf")
    sightexports.sGui:setInputIcon(wizardElements[5], "home")
    sightexports.sGui:setInputNumberOnly(wizardElements[5], true)
    y = y + 30 + 6
    wizardElements[6] = sightexports.sGui:createGuiElement("checkbox", x, y, 100, 30, wizardWindow)
    sightexports.sGui:setGuiColorScheme(wizardElements[6], "dark")
    sightexports.sGui:setCheckboxText(wizardElements[6], "Frakció")
    sightexports.sGui:setClickEvent(wizardElements[6], "pedShopWizardSelectOwner")
    wizardElements[7] = sightexports.sGui:createGuiElement("input", x + 100, y, w - 164 - 12 - 100, 30, wizardWindow)
    sightexports.sGui:setInputPlaceholder(wizardElements[7], "Frakció prefix")
    sightexports.sGui:setInputFont(wizardElements[7], "10/Ubuntu-R.ttf")
    sightexports.sGui:setInputIcon(wizardElements[7], "user")
    y = y + 30 + 6
    wizardElements[8] = sightexports.sGui:createGuiElement("checkbox", x, y, 100, 30, wizardWindow)
    sightexports.sGui:setGuiColorScheme(wizardElements[8], "dark")
    sightexports.sGui:setCheckboxText(wizardElements[8], "Karakter")
    sightexports.sGui:setClickEvent(wizardElements[8], "pedShopWizardSelectOwner")
    wizardElements[9] = sightexports.sGui:createGuiElement("input", x + 100, y, w - 164 - 12 - 100, 30, wizardWindow)
    sightexports.sGui:setInputPlaceholder(wizardElements[9], "Karakter ID")
    sightexports.sGui:setInputFont(wizardElements[9], "10/Ubuntu-R.ttf")
    sightexports.sGui:setInputIcon(wizardElements[9], "users")
    sightexports.sGui:setInputNumberOnly(wizardElements[9], true)
    y = y + 30 + 6
    if wizardData.owner == "server" then
      sightexports.sGui:setCheckboxChecked(wizardElements[3], true)
    elseif wizardData.owner == "interior" then
      sightexports.sGui:setCheckboxChecked(wizardElements[4], true)
      sightexports.sGui:setInputValue(wizardElements[5], wizardData.ownerId or "")
    elseif wizardData.owner == "group" then
      sightexports.sGui:setCheckboxChecked(wizardElements[6], true)
      sightexports.sGui:setInputValue(wizardElements[7], wizardData.ownerId or "")
    elseif wizardData.owner == "char" then
      sightexports.sGui:setCheckboxChecked(wizardElements[8], true)
      sightexports.sGui:setInputValue(wizardElements[9], wizardData.ownerId or "")
    end
    wizardRefresh()
  elseif wizardData.step == 2 then
    y = y + 6
    if not wizardData.scrollHandled then
      wizardData.scrollHandled = true
      addEventHandler("onClientKey", getRootElement(), wizardScroll)
    end
    local ih = (h - y - 32 - 6 - 20) / 8
    local icon = sightexports.sGui:createGuiElement("image", x + w - 164 - 18 - 40, y, 20, 20, wizardWindow)
    sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("minus-square", 20))
    sightexports.sGui:setGuiHoverable(icon, true)
    sightexports.sGui:setGuiHover(icon, "solid", "sightgreen")
    sightexports.sGui:setClickEvent(icon, "pedShopWizardDeselectAllItem")
    local icon = sightexports.sGui:createGuiElement("image", x + w - 164 - 18 - 20, y, 20, 20, wizardWindow)
    sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("check-square", 20))
    sightexports.sGui:setGuiHoverable(icon, true)
    sightexports.sGui:setGuiHover(icon, "solid", "sightgreen")
    sightexports.sGui:setClickEvent(icon, "pedShopWizardSelectAllItem")
    for i = 1, 8 do
      local rect = sightexports.sGui:createGuiElement("rectangle", x + 160 + 6, y + 20 + (i - 1) * ih, w - 164 - 160 - 18, ih, wizardWindow)
      sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey4")
      wizardElements[(i - 1) * 3 + 1] = sightexports.sGui:createGuiElement("image", x + 160 + 6 + 2, y + 20 + (i - 1) * ih + 2, ih - 4, ih - 4, wizardWindow)
      wizardElements[(i - 1) * 3 + 2] = sightexports.sGui:createGuiElement("label", x + 160 + 6 + 2 + ih, y + 20 + (i - 1) * ih, 0, ih, wizardWindow)
      sightexports.sGui:setLabelAlignment(wizardElements[(i - 1) * 3 + 2], "left", "center")
      sightexports.sGui:setLabelFont(wizardElements[(i - 1) * 3 + 2], "10/Ubuntu-R.ttf")
      wizardElements[(i - 1) * 3 + 3] = sightexports.sGui:createGuiElement("checkbox", x + w - 164 - 18 - ih / 2 - 12 - 2, y + 20 + (i - 0.5) * ih - 12, 24, 24, wizardWindow)
      sightexports.sGui:setGuiColorScheme(wizardElements[(i - 1) * 3 + 3], "dark")
      sightexports.sGui:setClickEvent(wizardElements[(i - 1) * 3 + 3], "pedShopWizardSelectItem")
      sightexports.sGui:setGuiBoundingBox(wizardElements[(i - 1) * 3 + 3], rect)
      if i < 8 then
        local border = sightexports.sGui:createGuiElement("hr", x + 160 + 6, y + 20 + i * ih - 1, w - 164 - 160 - 18, 2, wizardWindow)
      end
    end
    local n = 24
    local rect = sightexports.sGui:createGuiElement("rectangle", x + w - 164 - 12 - 2, y + 20, 2, ih * 8, wizardWindow)
    sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey3")
    wizardElements[n + 1] = sightexports.sGui:createGuiElement("rectangle", 0, 0, 2, ih * 8, rect)
    sightexports.sGui:setGuiBackground(wizardElements[n + 1], "solid", "sightmidgrey")
    wizardData.itemSH = ih * 8
    wizardData.itemScroll = 0
    local ih = (h - y - 32 - 6) / #predefCategoryNames
    wizardData.selectedPredefCat = 1
    if not wizardData.selectedItems then
      wizardData.selectedItems = {}
    end
    for i = 1, #predefCategoryNames do
      local btn = sightexports.sGui:createGuiElement("button", x, y + (i - 1) * ih, 160, ih, wizardWindow)
      sightexports.sGui:setGuiBackground(btn, "solid", "sightgrey1")
      sightexports.sGui:setGuiHover(btn, "gradient", {"sightgrey1", "sightgrey2"}, false, true)
      sightexports.sGui:setButtonFont(btn, "12/BebasNeueBold.otf")
      sightexports.sGui:setButtonText(btn, predefCategoryNames[i])
      sightexports.sGui:setClickEvent(btn, "pedShopWizardSelectCategory")
      wizardElements[n + 1 + i] = btn
    end
    calcCategorySelected()
    wizardRefresh()
  elseif wizardData.step == 3 then
    local ih = (h - y - 32 - 6) / #predefCategoryNames
    for i = 1, #predefCategoryNames do
      local items = predefCategories[i]
      local c = 0
      for j = 1, #items do
        if wizardData.selectedItems[items[j]] then
          c = c + 1
        end
      end
      local label = sightexports.sGui:createGuiElement("label", x, y + (i - 1) * ih, 170, ih, wizardWindow)
      sightexports.sGui:setLabelAlignment(label, "left", "center")
      sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
      sightexports.sGui:setLabelText(label, predefCategoryNames[i])
      local label = sightexports.sGui:createGuiElement("label", x, y + (i - 1) * ih, 170, ih, wizardWindow)
      sightexports.sGui:setLabelAlignment(label, "right", "center")
      sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
      sightexports.sGui:setLabelText(label, c .. "/" .. #items)
    end
    x = x + 170 + 6
    local label = sightexports.sGui:createGuiElement("label", x, y, 0, 24, wizardWindow)
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
    sightexports.sGui:setLabelText(label, "Név: " .. (wizardData.name or ""))
    y = y + 24
    local label = sightexports.sGui:createGuiElement("label", x, y, 0, 24, wizardWindow)
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
    sightexports.sGui:setLabelText(label, "Skin: " .. (wizardData.skin or 1))
    y = y + 24
    local label = sightexports.sGui:createGuiElement("label", x, y, 0, 24, wizardWindow)
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
    sightexports.sGui:setLabelText(label, "Tulajdonos: " .. (wizardData.owner or "server"))
    y = y + 24
    local label = sightexports.sGui:createGuiElement("label", x, y, 0, 24, wizardWindow)
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
    sightexports.sGui:setLabelText(label, "Tulajdonos ID: " .. tostring(wizardData.ownerId))
    y = y + 24
    local c = 0
    for i in pairs(wizardData.selectedItems) do
      c = c + 1
    end
    local label = sightexports.sGui:createGuiElement("label", x, y, 0, 24, wizardWindow)
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
    sightexports.sGui:setLabelText(label, "Tárgyak száma: " .. c)
  end
  if 1 < wizardData.step then
    local btn = sightexports.sGui:createGuiElement("button", w - 168, h - 32 + 4, 80, 24, wizardWindow)
    sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
    sightexports.sGui:setGuiHover(btn, "gradient", {
      "sightgreen",
      "sightgreen-second"
    }, false, true)
    sightexports.sGui:setButtonFont(btn, "12/BebasNeueBold.otf")
    sightexports.sGui:setButtonText(btn, "< Előző")
    sightexports.sGui:setClickEvent(btn, "pedShopWizardPrevStep")
  end
  local btn = sightexports.sGui:createGuiElement("button", w - 80 - 4, h - 32 + 4, 80, 24, wizardWindow)
  sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
  sightexports.sGui:setGuiHover(btn, "gradient", {
    "sightgreen",
    "sightgreen-second"
  }, false, true)
  sightexports.sGui:setButtonFont(btn, "12/BebasNeueBold.otf")
  sightexports.sGui:setButtonText(btn, wizardData.step == 3 and "Kész" or "Következő >")
  sightexports.sGui:setClickEvent(btn, "pedShopWizardNextStep")
end
function createWholesaleEditor()
  deletePedInstaller()
  local titleBarHeight = sightexports.sGui:getTitleBarHeight()
  local w, h = 600, titleBarHeight + 300
  showCursor(true)
  wizardWindow = sightexports.sGui:createGuiElement("window", screenX / 2 - w / 2, screenY / 2 - h / 2, w, h)
  sightexports.sGui:setWindowTitle(wizardWindow, "16/BebasNeueRegular.otf", "Nagyker ár")
  sightexports.sGui:setWindowCloseButton(wizardWindow, "closePedShopWizard")
  local x = 6
  local y = titleBarHeight + 6
  if not wizardData.scrollHandled then
    wizardData.scrollHandled = true
    addEventHandler("onClientKey", getRootElement(), wizardScroll)
  end
  local ih = (h - y - 6) / 8
  for i = 1, 8 do
    local rect = sightexports.sGui:createGuiElement("rectangle", x + 160 + 6, y + (i - 1) * ih, w - 160 - 18, ih, wizardWindow)
    sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey4")
    wizardElements[(i - 1) * 3 + 1] = sightexports.sGui:createGuiElement("image", x + 160 + 6 + 2, y + (i - 1) * ih + 2, ih - 4, ih - 4, wizardWindow)
    wizardElements[(i - 1) * 3 + 2] = sightexports.sGui:createGuiElement("label", x + 160 + 6 + 2 + ih, y + (i - 1) * ih, 0, ih, wizardWindow)
    sightexports.sGui:setLabelAlignment(wizardElements[(i - 1) * 3 + 2], "left", "center")
    sightexports.sGui:setLabelFont(wizardElements[(i - 1) * 3 + 2], "10/Ubuntu-R.ttf")
    wizardElements[(i - 1) * 3 + 3] = sightexports.sGui:createGuiElement("button", x + w - 12 - 2 - 150, y + (i - 1) * ih, 150, ih, wizardWindow)
    sightexports.sGui:setGuiBackground(wizardElements[(i - 1) * 3 + 3], "solid", "sightgrey1")
    sightexports.sGui:setGuiHover(wizardElements[(i - 1) * 3 + 3], "gradient", {"sightgrey1", "sightgrey2"}, false, true)
    sightexports.sGui:setButtonFont(wizardElements[(i - 1) * 3 + 3], "12/BebasNeueBold.otf")
    sightexports.sGui:setClickEvent(wizardElements[(i - 1) * 3 + 3], "pedShopWizardEditWP")
    if i < 8 then
      local border = sightexports.sGui:createGuiElement("hr", x + 160 + 6, y + i * ih - 1, w - 160 - 18, 2, wizardWindow)
    end
  end
  local n = 24
  local rect = sightexports.sGui:createGuiElement("rectangle", x + w - 12 - 2, y, 2, ih * 8, wizardWindow)
  sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey3")
  wizardElements[n + 1] = sightexports.sGui:createGuiElement("rectangle", 0, 0, 2, ih * 8, rect)
  sightexports.sGui:setGuiBackground(wizardElements[n + 1], "solid", "sightmidgrey")
  wizardData.itemSH = ih * 8
  wizardData.itemScroll = 0
  local ih = (h - y - 32 - 6) / #predefCategoryNames
  wizardData.selectedPredefCat = 1
  for i = 1, #predefCategoryNames do
    local btn = sightexports.sGui:createGuiElement("button", x, y + (i - 1) * ih, 160, ih, wizardWindow)
    sightexports.sGui:setGuiBackground(btn, "solid", "sightgrey1")
    sightexports.sGui:setGuiHover(btn, "gradient", {"sightgrey1", "sightgrey2"}, false, true)
    sightexports.sGui:setButtonFont(btn, "12/BebasNeueBold.otf")
    sightexports.sGui:setButtonText(btn, predefCategoryNames[i])
    sightexports.sGui:setClickEvent(btn, "pedShopWizardSelectCategory")
    wizardElements[n + 1 + i] = btn
  end
  wizardRefresh()
end
addEvent("gotPedShopWholesaleEditor", true)
addEventHandler("gotPedShopWholesaleEditor", getRootElement(), function(wp)
  wizardData = {}
  wizardData.wholesale = wp
  createWholesaleEditor()
end)
addEvent("startShopPedInit", true)
addEventHandler("startShopPedInit", getRootElement(), function(id, items, owner, ownerId)
  wizardData = {}
  wizardData.pedId = id
  wizardData.step = 1
  wizardData.name = pedDatas[id].name
  wizardData.skin = pedDatas[id].skin
  wizardData.owner = owner
  wizardData.ownerId = ownerId
  wizardData.selectedItems = items
  createPedInstaller()
end)
