local sightexports = {sGui = false, sItems = false}
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
local rtg = false
local sx, sy = 0, 0
local inside = false
local sellInput = false
animalMenuDrawn = false
function animalsInsideDestroy()
  inside = false
  animalMenuDrawn = false
  if buyingRect then
    sightexports.sGui:deleteGuiElement(buyingRect)
  end
  buyingRect = false
  if buyingWindow then
    sightexports.sGui:deleteGuiElement(buyingWindow)
    sightexports.sGui:lockHover(rtg, false)
    sightexports.sGui:lockHover(closeButton, false)
    sightexports.sGui:lockHover(helpIcon, false)
  end
  buyingWindow = false
  sellingAnimalTo = false
  selectedAnimalToBuy = false
  buyInput = false
  renameInput = false
  sellInput = false
end
local maxAnimalOffset = 0
local animalOffset = 0
selectedAnimal = 1
local sideMenu = {}
local sh = false
local scrollbar = false
local menuW = false
local buttons = {}
renameInput = false
local spawnedAnimal = false
local spawnedPetElement = false
local petDatas = {}
addEventHandler("onClientElementDataChange", getRootElement(), function(data)
  if source == spawnedPetElement or getElementType(source) == "ped" then
    local animalId = getElementData(source, "animal.animalId")
    if animalId then
      local ownerId = getElementData(source, "animal.ownerId")
      if ownerId and ownerId == charId then
        spawnedAnimal = animalId
        spawnedPetElement = source
        petDatas[data] = getElementData(source, data)
        if animalMenuDrawn then
          drawAnimal()
        end
      end
    end
  end
end)
addEventHandler("onClientElementDestroy", getRootElement(), function()
  if getElementType(source) == "ped" and getElementData(source, "animal.animalId") and getElementData(source, "animal.ownerId") == charId then
    spawnedAnimal = false
    spawnedPetElement = false
    petDatas = {}
    if animalMenuDrawn then
      drawAnimal()
    end
  end
end)
local petSpawnTick = 0
addEvent("spawnPet", true)
addEventHandler("spawnPet", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  if petSpawnTick + 5000 <= getTickCount() then
    if playerAnimals[selectedAnimal] then
      local animalId = playerAnimals[selectedAnimal].animalId
      if animalId then
        if spawnedAnimal then
          if spawnedAnimal == playerAnimals[selectedAnimal].animalId then
            triggerServerEvent("destroyAnimal", localPlayer, spawnedAnimal)
            petSpawnTick = getTickCount()
          else
            sightexports.sGui:showInfobox("e", "Másik állat lespawnolása előtt, először despawnold az aktívat!")
          end
        else
          triggerServerEvent("spawnAnimal", localPlayer, animalId)
          petSpawnTick = getTickCount()
        end
      end
    end
  else
    sightexports.sGui:showInfobox("e", "5 másodpercenként egyszer használhatod ezt a gombot.")
  end
end)
addEvent("selectAnimalClick", true)
addEventHandler("selectAnimalClick", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  if buttons[el] then
    selectedAnimal = buttons[el]
    drawAnimal()
  end
end)
addEventHandler("onClientKey", getRootElement(), function(key, por)
  if animalMenuDrawn and 0 < maxAnimalOffset then
    if key == "mouse_wheel_up" then
      if 0 < animalOffset then
        animalOffset = animalOffset - 1
        drawAnimalSideMenu()
      end
    elseif key == "mouse_wheel_down" and animalOffset < maxAnimalOffset then
      animalOffset = animalOffset + 1
      drawAnimalSideMenu()
    end
  end
end)
local h = 0
function drawAnimalSideMenu()
  if #playerAnimals + 1 > 10 then
    local sw = menuW - dashboardPadding[3] - 2
    sightexports.sGui:setGuiPosition(scrollbar, sw + 1, 1 + sh * animalOffset)
  end
  for i = 1, 10 do
    if playerAnimals[i + animalOffset] then
      if selectedAnimal == i + animalOffset then
        sightexports.sGui:setGuiBackground(sideMenu[i][1], "solid", "sightgreen")
        sightexports.sGui:setGuiHoverable(sideMenu[i][1], false)
        sightexports.sGui:setClickEvent(sideMenu[i][1], false)
      else
        sightexports.sGui:setGuiBackground(sideMenu[i][1], "solid", "sightgrey1")
        sightexports.sGui:setGuiHoverable(sideMenu[i][1], true)
        sightexports.sGui:setGuiHover(sideMenu[i][1], "gradient", {"sightgrey2", "sightgrey1"}, true)
        sightexports.sGui:setClickEvent(sideMenu[i][1], "selectAnimalClick")
      end
      sightexports.sGui:setLabelText(sideMenu[i][2], playerAnimals[i + animalOffset].name)
      sightexports.sGui:setLabelText(sideMenu[i][3], "#" .. playerAnimals[i + animalOffset].animalId)
      sightexports.sGui:setLabelText(sideMenu[i][6], "")
      sightexports.sGui:setImageDDS(sideMenu[i][5], ":sDashboard/files/dogs/" .. utf8.lower(utf8.gsub(playerAnimals[i + animalOffset].type, " ", "")) .. ".dds")
      buttons[sideMenu[i][1]] = i + animalOffset
      sightexports.sGui:setLabelText(sideMenu[i][4], "Fajta: " .. playerAnimals[i + animalOffset].type)
    elseif i + animalOffset == #playerAnimals + 1 then
      sightexports.sGui:setGuiBackground(sideMenu[i][1], "solid", "sightblue")
      sightexports.sGui:setGuiHover(sideMenu[i][1], "gradient", {
        "sightblue",
        "sightblue-second"
      }, true)
      sightexports.sGui:setGuiHoverable(sideMenu[i][1], true)
      sightexports.sGui:setClickEvent(sideMenu[i][1], "buyAnimalClick")
      sightexports.sGui:setLabelText(sideMenu[i][2], "")
      sightexports.sGui:setLabelText(sideMenu[i][3], "")
      buttons[sideMenu[i][1]] = i + animalOffset
      sightexports.sGui:setLabelText(sideMenu[i][4], "")
      sightexports.sGui:setImageFile(sideMenu[i][5], sightexports.sGui:getFaIconFilename("paw", h - 16))
      sightexports.sGui:setLabelText(sideMenu[i][6], "Háziállat vásárlás")
    end
  end
end
function drawAnimal()
  if buyingRect then
    sightexports.sGui:deleteGuiElement(buyingRect)
  end
  buyingRect = false
  if buyingWindow then
    sightexports.sGui:deleteGuiElement(buyingWindow)
    sightexports.sGui:lockHover(rtg, false)
    sightexports.sGui:lockHover(closeButton, false)
    sightexports.sGui:lockHover(helpIcon, false)
  end
  buyingWindow = false
  sellingAnimalTo = false
  selectedAnimalToBuy = false
  buyInput = false
  renameInput = false
  sellInput = false
  menuW = math.floor(sx * 0.27)
  h = (sy - 32) / 10
  if inside then
    sightexports.sGui:deleteGuiElement(inside)
  end
  inside = sightexports.sGui:createGuiElement("null", 0, 0, sx, sy, rtg)
  local rect = sightexports.sGui:createGuiElement("rectangle", menuW, 0, sx - menuW, sy, inside)
  sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey2")
  local rect = sightexports.sGui:createGuiElement("rectangle", 0, sy - 32, menuW, 32, inside)
  sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey3")
  maxAnimalOffset = 0
  if 10 < #playerAnimals + 1 then
    maxAnimalOffset = #playerAnimals + 1 - 10
    menuW = menuW - dashboardPadding[3] - 2
    local rect = sightexports.sGui:createGuiElement("rectangle", menuW, 0, dashboardPadding[3] + 2, sy - 32, inside)
    sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey3")
    sh = (sy - 32) / (#playerAnimals + 1 - 10 + 1)
    scrollbar = sightexports.sGui:createGuiElement("rectangle", menuW + 1, 1 + sh * animalOffset, dashboardPadding[3], sh - 2, inside)
    sightexports.sGui:setGuiBackground(scrollbar, "solid", "sightgreen")
  end
  buttons = {}
  for i = 1, 10 do
    if playerAnimals[i + animalOffset] or i + animalOffset == #playerAnimals + 1 then
      sideMenu[i] = {}
      sideMenu[i][1] = sightexports.sGui:createGuiElement("rectangle", 0, (i - 1) * h, menuW, h, inside)
      sightexports.sGui:setGuiHover(sideMenu[i][1], "gradient", {"sightgrey2", "sightgrey1"}, true)
      sideMenu[i][2] = sightexports.sGui:createGuiElement("label", dashboardPadding[3] * 2 + (h - 8), 0, menuW - dashboardPadding[3] * 2 * 2, h / 2, sideMenu[i][1])
      sightexports.sGui:setLabelFont(sideMenu[i][2], "16/BebasNeueRegular.otf")
      sightexports.sGui:setLabelAlignment(sideMenu[i][2], "left", "center")
      sideMenu[i][3] = sightexports.sGui:createGuiElement("label", dashboardPadding[3] * 2 + (h - 8), h / 2, menuW - dashboardPadding[3] * 2 * 2, h / 2, sideMenu[i][1])
      sightexports.sGui:setLabelFont(sideMenu[i][3], "12/Ubuntu-L.ttf")
      sightexports.sGui:setLabelAlignment(sideMenu[i][3], "left", "center")
      sideMenu[i][4] = sightexports.sGui:createGuiElement("label", dashboardPadding[3] * 2, h / 2, menuW - dashboardPadding[3] * 2 * 2, h / 2, sideMenu[i][1])
      sightexports.sGui:setLabelFont(sideMenu[i][4], "12/Ubuntu-L.ttf")
      sightexports.sGui:setLabelAlignment(sideMenu[i][4], "right", "center")
      sideMenu[i][5] = sightexports.sGui:createGuiElement("image", dashboardPadding[3] * 2, 8, h - 16, h - 16, sideMenu[i][1])
      sightexports.sGui:setImageFile(sideMenu[i][5], sightexports.sGui:getFaIconFilename("paw", h - 16))
      sideMenu[i][6] = sightexports.sGui:createGuiElement("label", dashboardPadding[3] * 2 + (h - 8), 0, menuW - dashboardPadding[3] * 2 * 2, h, sideMenu[i][1])
      sightexports.sGui:setLabelFont(sideMenu[i][6], "18/BebasNeueRegular.otf")
      sightexports.sGui:setLabelAlignment(sideMenu[i][6], "left", "center")
      sightexports.sGui:setLabelText(sideMenu[i][6], "Háziállat vásárlás")
    end
  end
  local label = sightexports.sGui:createGuiElement("label", 0, sy - 32, menuW, 32, inside)
  sightexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
  sightexports.sGui:setLabelAlignment(label, "center", "center")
  sightexports.sGui:setLabelText(label, "Háziállatok: " .. #playerAnimals)
  if 10 < #playerAnimals + 1 then
    menuW = menuW + dashboardPadding[3] + 2
  end
  drawAnimalSideMenu()
  local x = menuW + dashboardPadding[3] * 4
  local y = dashboardPadding[3] * 4
  local sx = sx - menuW
  local h = sightexports.sGui:getFontHeight("12/Ubuntu-L.ttf") * 1.25
  local h1 = sightexports.sGui:getFontHeight("30/BebasNeueRegular.otf")
  local is = h1 * 1.25 + h * 2 + (h + 16 + 8) * 3 - 16
  if playerAnimals[selectedAnimal] then
    local rect = sightexports.sGui:createGuiElement("rectangle", x + sx - is - 16 - dashboardPadding[3] * 8, y, is + 16, is + 16, inside)
    sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey1")
    local img = sightexports.sGui:createGuiElement("image", x + sx - is - 16 - dashboardPadding[3] * 8 + 8, y + 8, is, is, inside)
    sightexports.sGui:setImageDDS(img, ":sDashboard/files/dogs/" .. utf8.lower(utf8.gsub(playerAnimals[selectedAnimal].type, " ", "")) .. ".dds")
    local label = sightexports.sGui:createGuiElement("label", x, y, sx, h1, inside)
    sightexports.sGui:setLabelFont(label, "30/BebasNeueRegular.otf")
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    sightexports.sGui:setLabelText(label, playerAnimals[selectedAnimal].name)
    y = y + h1 * 1.25
    local label = sightexports.sGui:createGuiElement("label", x, y, sx, h, inside)
    sightexports.sGui:setLabelFont(label, "12/Ubuntu-R.ttf")
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    sightexports.sGui:setLabelText(label, "ID: ")
    local label = sightexports.sGui:createGuiElement("label", x + sightexports.sGui:getLabelTextWidth(label), y, sx, h, inside)
    sightexports.sGui:setLabelFont(label, "12/Ubuntu-L.ttf")
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    sightexports.sGui:setLabelColor(label, "sightgreen")
    sightexports.sGui:setLabelText(label, playerAnimals[selectedAnimal].animalId)
    y = y + h
    local label = sightexports.sGui:createGuiElement("label", x, y, sx, h, inside)
    sightexports.sGui:setLabelFont(label, "12/Ubuntu-R.ttf")
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    sightexports.sGui:setLabelText(label, "Fajta: ")
    local label = sightexports.sGui:createGuiElement("label", x + sightexports.sGui:getLabelTextWidth(label), y, sx, h, inside)
    sightexports.sGui:setLabelFont(label, "12/Ubuntu-L.ttf")
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    sightexports.sGui:setLabelColor(label, "sightgreen")
    sightexports.sGui:setLabelText(label, playerAnimals[selectedAnimal].type)
    y = y + h
    local health = math.floor(playerAnimals[selectedAnimal].health + 0.5)
    local hunger = math.floor(playerAnimals[selectedAnimal].hunger + 0.5)
    local love = math.floor(playerAnimals[selectedAnimal].love + 0.5)
    if spawnedAnimal == playerAnimals[selectedAnimal].animalId then
      health = math.floor(getElementHealth(spawnedPetElement) + 0.5)
      hunger = math.floor((petDatas["animal.hunger"] or 0) + 0.5)
      love = math.floor((petDatas["animal.love"] or 0) + 0.5)
    end
    local label = sightexports.sGui:createGuiElement("label", x, y, sx, h, inside)
    sightexports.sGui:setLabelFont(label, "12/Ubuntu-R.ttf")
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    sightexports.sGui:setLabelText(label, "Életerő: ")
    local label = sightexports.sGui:createGuiElement("label", x + sightexports.sGui:getLabelTextWidth(label), y, sx, h, inside)
    sightexports.sGui:setLabelFont(label, "12/Ubuntu-L.ttf")
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    if health <= 25 then
      sightexports.sGui:setLabelColor(label, "sightred")
    elseif health <= 75 then
      sightexports.sGui:setLabelColor(label, "sightyellow")
    else
      sightexports.sGui:setLabelColor(label, "sightgreen")
    end
    if health > 100 then
      health = 100
    end
    sightexports.sGui:setLabelText(label, health .. "%")
    y = y + h
    local rect = sightexports.sGui:createGuiElement("rectangle", x, y + 4, sx * 0.4, 16, inside)
    sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey1")
    local rect = sightexports.sGui:createGuiElement("rectangle", x + 2, y + 4 + 2, sx * 0.4 - 4, 12, inside)
    sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey3")
    local rect = sightexports.sGui:createGuiElement("rectangle", x + 2, y + 4 + 2, (sx * 0.4 - 4) * (health / 100), 12, inside)
    sightexports.sGui:setGuiBackground(rect, "solid", "sightgreen")
    y = y + 16 + 8
    local label = sightexports.sGui:createGuiElement("label", x, y, sx, h, inside)
    sightexports.sGui:setLabelFont(label, "12/Ubuntu-R.ttf")
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    sightexports.sGui:setLabelText(label, "Éhség: ")
    local label = sightexports.sGui:createGuiElement("label", x + sightexports.sGui:getLabelTextWidth(label), y, sx, h, inside)
    sightexports.sGui:setLabelFont(label, "12/Ubuntu-L.ttf")
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    if hunger <= 25 then
      sightexports.sGui:setLabelColor(label, "sightred")
    elseif hunger <= 75 then
      sightexports.sGui:setLabelColor(label, "sightyellow")
    else
      sightexports.sGui:setLabelColor(label, "sightgreen")
    end
    sightexports.sGui:setLabelText(label, hunger .. "%")
    y = y + h
    local rect = sightexports.sGui:createGuiElement("rectangle", x, y + 4, sx * 0.4, 16, inside)
    sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey1")
    local rect = sightexports.sGui:createGuiElement("rectangle", x + 2, y + 4 + 2, sx * 0.4 - 4, 12, inside)
    sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey3")
    local rect = sightexports.sGui:createGuiElement("rectangle", x + 2, y + 4 + 2, (sx * 0.4 - 4) * (hunger / 100), 12, inside)
    sightexports.sGui:setGuiBackground(rect, "solid", "sightblue")
    y = y + 16 + 8
    local label = sightexports.sGui:createGuiElement("label", x, y, sx, h, inside)
    sightexports.sGui:setLabelFont(label, "12/Ubuntu-R.ttf")
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    sightexports.sGui:setLabelText(label, "Szeretet: ")
    local label = sightexports.sGui:createGuiElement("label", x + sightexports.sGui:getLabelTextWidth(label), y, sx, h, inside)
    sightexports.sGui:setLabelFont(label, "12/Ubuntu-L.ttf")
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    if love <= 25 then
      sightexports.sGui:setLabelColor(label, "sightred")
    elseif love <= 75 then
      sightexports.sGui:setLabelColor(label, "sightyellow")
    else
      sightexports.sGui:setLabelColor(label, "sightgreen")
    end
    sightexports.sGui:setLabelText(label, love .. "%")
    y = y + h
    local rect = sightexports.sGui:createGuiElement("rectangle", x, y + 4, sx * 0.4, 16, inside)
    sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey1")
    local rect = sightexports.sGui:createGuiElement("rectangle", x + 2, y + 4 + 2, sx * 0.4 - 4, 12, inside)
    sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey3")
    local rect = sightexports.sGui:createGuiElement("rectangle", x + 2, y + 4 + 2, (sx * 0.4 - 4) * (love / 100), 12, inside)
    sightexports.sGui:setGuiBackground(rect, "solid", "sightred")
    y = y + 16 + 8
    y = y + 15
    if spawnedAnimal == playerAnimals[selectedAnimal].animalId then
      local btn = sightexports.sGui:createGuiElement("button", x, y + 5, sx * 0.4, 30, inside)
      sightexports.sGui:setGuiBackground(btn, "solid", "sightred")
      sightexports.sGui:setGuiHover(btn, "gradient", {
        "sightred",
        "sightred-second"
      })
      sightexports.sGui:setButtonFont(btn, "13/BebasNeueBold.otf")
      sightexports.sGui:setButtonTextColor(btn, "#ffffff")
      sightexports.sGui:setButtonText(btn, "Despawn")
      sightexports.sGui:setClickEvent(btn, "spawnPet")
    else
      local btn = sightexports.sGui:createGuiElement("button", x, y + 5, sx * 0.4, 30, inside)
      sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
      sightexports.sGui:setGuiHover(btn, "gradient", {
        "sightgreen",
        "sightgreen-second"
      })
      sightexports.sGui:setButtonFont(btn, "13/BebasNeueBold.otf")
      sightexports.sGui:setButtonTextColor(btn, "#ffffff")
      sightexports.sGui:setButtonText(btn, "Spawn")
      sightexports.sGui:setClickEvent(btn, "spawnPet")
      y = y + 30 + 10
      local btn = sightexports.sGui:createGuiElement("button", x, y + 5, sx * 0.4, 30, inside)
      sightexports.sGui:setGuiBackground(btn, "solid", "sightblue")
      sightexports.sGui:setGuiHover(btn, "gradient", {
        "sightblue",
        "sightblue-second"
      })
      sightexports.sGui:setButtonFont(btn, "13/BebasNeueBold.otf")
      sightexports.sGui:setButtonTextColor(btn, "#ffffff")
      sightexports.sGui:setButtonText(btn, "Háziállat átnevezése")
      sightexports.sGui:setClickEvent(btn, "renamePet")
      y = y + 30 + 10
      if playerAnimals[selectedAnimal].health <= 25 then
        local btn = sightexports.sGui:createGuiElement("button", x, y + 5, sx * 0.4, 30, inside)
        sightexports.sGui:setGuiBackground(btn, "solid", "sightblue")
        sightexports.sGui:setGuiHover(btn, "gradient", {
          "sightblue",
          "sightblue-second"
        })
        sightexports.sGui:setButtonFont(btn, "13/BebasNeueBold.otf")
        sightexports.sGui:setButtonTextColor(btn, "#ffffff")
        if 0 >= playerAnimals[selectedAnimal].health then
          sightexports.sGui:setButtonText(btn, "Felélesztés")
        else
          sightexports.sGui:setButtonText(btn, "Életerő feltöltése")
        end
        sightexports.sGui:setClickEvent(btn, "revivePet")
        y = y + 30 + 10
      end
      local btn = sightexports.sGui:createGuiElement("button", x, y + 5, sx * 0.4, 30, inside)
      sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
      sightexports.sGui:setGuiHover(btn, "gradient", {
        "sightgreen",
        "sightgreen-second"
      })
      sightexports.sGui:setButtonFont(btn, "13/BebasNeueBold.otf")
      sightexports.sGui:setButtonTextColor(btn, "#ffffff")
      sightexports.sGui:setButtonText(btn, "Eladás")
      sightexports.sGui:setClickEvent(btn, "startPetSell")
    end
  end
end
function animalsInsideDraw(x, y, isx, isy, i, j, irtg)
  rtg = irtg
  sx, sy = isx, isy
  animalOffset = 0
  animalMenuDrawn = true
  drawAnimal()
end
addEvent("finalSellPet", true)
addEventHandler("finalSellPet", getRootElement(), function()
  if sellingAnimalTo and isElement(sellingAnimalTo) and playerAnimals[selectedAnimal] and playerAnimals[selectedAnimal].animalId then
    local price = tonumber(sightexports.sGui:getInputValue(sellInput))
    if 500 <= price then
      triggerServerEvent("tryToSellPet", localPlayer, playerAnimals[selectedAnimal].animalId, sellingAnimalTo, price)
    else
      sightexports.sGui:showInfobox("e", "A minimum eladási összeg 500$!")
      return
    end
  end
  if buyingRect then
    sightexports.sGui:deleteGuiElement(buyingRect)
  end
  buyingRect = false
  if buyingWindow then
    sightexports.sGui:deleteGuiElement(buyingWindow)
    sightexports.sGui:lockHover(rtg, false)
    sightexports.sGui:lockHover(closeButton, false)
    sightexports.sGui:lockHover(helpIcon, false)
  end
  buyingWindow = false
  sellingAnimalTo = false
  selectedAnimalToBuy = false
  buyInput = false
  renameInput = false
  sellInput = false
end)
addEvent("closePetPanel", true)
addEventHandler("closePetPanel", getRootElement(), function()
  if buyingRect then
    sightexports.sGui:deleteGuiElement(buyingRect)
  end
  buyingRect = false
  if buyingWindow then
    sightexports.sGui:deleteGuiElement(buyingWindow)
    sightexports.sGui:lockHover(rtg, false)
    sightexports.sGui:lockHover(closeButton, false)
    sightexports.sGui:lockHover(helpIcon, false)
  end
  buyingWindow = false
  sellingAnimalTo = false
  selectedAnimalToBuy = false
  buyInput = false
  renameInput = false
  sellInput = false
end)
local playerButtons = {}
sellingAnimalTo = false
selectedAnimalToBuy = false
buyInput = false
renameInput = false
sellInput = false
addEvent("selectAnimalSellPlayer", true)
addEventHandler("selectAnimalSellPlayer", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  if playerButtons[el] and isElement(playerButtons[el]) then
    sellingAnimalTo = playerButtons[el]
    local titleBarHeight = sightexports.sGui:getTitleBarHeight()
    local panelWidth = 300
    local panelHeight = titleBarHeight + 5 + 70 + 32 + 5 + 96
    if buyingWindow then
      sightexports.sGui:deleteGuiElement(buyingWindow)
    end
    buyingWindow = sightexports.sGui:createGuiElement("window", screenX / 2 - panelWidth / 2, screenY / 2 - panelHeight / 2, panelWidth, panelHeight)
    sightexports.sGui:setWindowTitle(buyingWindow, "16/BebasNeueRegular.otf", "Háziállat eladás")
    local label = sightexports.sGui:createGuiElement("label", 5, titleBarHeight, panelWidth - 10, 96, buyingWindow)
    sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
    sightexports.sGui:setLabelAlignment(label, "center", "center")
    sightexports.sGui:setLabelText(label, "Név: " .. sightexports.sGui:getColorCodeHex("sightgreen") .. playerAnimals[selectedAnimal].name .. "[" .. playerAnimals[selectedAnimal].animalId .. [[
]
#ffffffFajta: ]] .. sightexports.sGui:getColorCodeHex("sightgreen") .. playerAnimals[selectedAnimal].type .. "\n#ffffffVevő: " .. sightexports.sGui:getColorCodeHex("sightgreen") .. getElementData(sellingAnimalTo, "visibleName"):gsub("_", " "))
    sellInput = sightexports.sGui:createGuiElement("input", 5, titleBarHeight + 5 + 96, panelWidth - 10, 32, buyingWindow)
    sightexports.sGui:setInputFont(sellInput, "11/Ubuntu-R.ttf")
    sightexports.sGui:setInputIcon(sellInput, "coins")
    sightexports.sGui:setInputPlaceholder(sellInput, "Eladási ár")
    sightexports.sGui:setInputMaxLength(sellInput, 20)
    sightexports.sGui:setInputNumberOnly(sellInput, true)
    local btn = sightexports.sGui:createGuiElement("button", 5, panelHeight - 70, panelWidth - 10, 30, buyingWindow)
    sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
    sightexports.sGui:setGuiHover(btn, "gradient", {
      "sightgreen",
      "sightgreen-second"
    })
    sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
    sightexports.sGui:setButtonTextColor(btn, "#ffffff")
    sightexports.sGui:setButtonText(btn, "Eladás")
    sightexports.sGui:setClickEvent(btn, "finalSellPet", false)
    local btn = sightexports.sGui:createGuiElement("button", 5, panelHeight - 35, panelWidth - 10, 30, buyingWindow)
    sightexports.sGui:setGuiBackground(btn, "solid", "sightred")
    sightexports.sGui:setGuiHover(btn, "gradient", {
      "sightred",
      "sightred-second"
    })
    sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
    sightexports.sGui:setButtonTextColor(btn, "#ffffff")
    sightexports.sGui:setButtonText(btn, "Mégsem")
    sightexports.sGui:setClickEvent(btn, "closePetPanel", false)
  else
    if buyingRect then
      sightexports.sGui:deleteGuiElement(buyingRect)
    end
    buyingRect = false
    if buyingWindow then
      sightexports.sGui:deleteGuiElement(buyingWindow)
      sightexports.sGui:lockHover(rtg, false)
      sightexports.sGui:lockHover(closeButton, false)
      sightexports.sGui:lockHover(helpIcon, false)
    end
    buyingWindow = false
    sellingAnimalTo = false
    selectedAnimalToBuy = false
    buyInput = false
    renameInput = false
    sellInput = false
  end
end)
addEvent("startPetSell", true)
addEventHandler("startPetSell", getRootElement(), function()
  if playerAnimals[selectedAnimal] then
    local data = playerAnimals[selectedAnimal]
    if spawnedAnimal ~= playerAnimals[selectedAnimal].animalId then
      local px, py, pz = getElementPosition(localPlayer)
      local playerList = {}
      local players = getElementsByType("player", getRootElement(), true)
      for i = 1, #players do
        if players[i] ~= localPlayer then
          local px2, py2, pz2 = getElementPosition(players[i])
          local dist = getDistanceBetweenPoints3D(px2, py2, pz2, px, py, pz)
          if dist < 5 then
            table.insert(playerList, players[i])
          end
        end
      end
      if #playerList < 1 then
        sightexports.sGui:showInfobox("e", "Nincs senki a közeledben!")
      else
        local titleBarHeight = sightexports.sGui:getTitleBarHeight()
        local panelWidth = 250
        local panelHeight = titleBarHeight + 5 + 30 + 5 + 35 * #playerList
        sightexports.sGui:lockHover(rtg, true)
        sightexports.sGui:lockHover(closeButton, true)
        sightexports.sGui:lockHover(helpIcon, true)
        buyingRect = sightexports.sGui:createGuiElement("rectangle", 0, 0, screenX, screenY)
        sightexports.sGui:setGuiBackground(buyingRect, "solid", {
          0,
          0,
          0,
          150
        })
        buyingWindow = sightexports.sGui:createGuiElement("window", screenX / 2 - panelWidth / 2, screenY / 2 - panelHeight / 2, panelWidth, panelHeight)
        sightexports.sGui:setWindowTitle(buyingWindow, "16/BebasNeueRegular.otf", "Válassz játékost!")
        local y = titleBarHeight + 5
        playerButtons = {}
        for i = 1, #playerList do
          local btn = sightexports.sGui:createGuiElement("button", 5, y, panelWidth - 10, 30, buyingWindow)
          sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
          sightexports.sGui:setGuiHover(btn, "gradient", {
            "sightgreen",
            "sightgreen-second"
          })
          sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
          sightexports.sGui:setButtonTextColor(btn, "#ffffff")
          sightexports.sGui:setButtonText(btn, getElementData(playerList[i], "visibleName"):gsub("_", " "))
          sightexports.sGui:setClickEvent(btn, "selectAnimalSellPlayer", false)
          playerButtons[btn] = playerList[i]
          y = y + 35
        end
        local btn = sightexports.sGui:createGuiElement("button", 5, panelHeight - 35, panelWidth - 10, 30, buyingWindow)
        sightexports.sGui:setGuiBackground(btn, "solid", "sightred")
        sightexports.sGui:setGuiHover(btn, "gradient", {
          "sightred",
          "sightred-second"
        })
        sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
        sightexports.sGui:setButtonTextColor(btn, "#ffffff")
        sightexports.sGui:setButtonText(btn, "Mégsem")
        sightexports.sGui:setClickEvent(btn, "closePetPanel", false)
      end
    else
      sightexports.sGui:showInfobox("e", "Nem tudod eladni az állatot, ha le van spawnolva!")
    end
  end
end)
local selectPetButton = {}
addEvent("finalPetBuy", true)
addEventHandler("finalPetBuy", getRootElement(), function()
  if selectedAnimalToBuy and animalsToBuy[selectedAnimalToBuy] then
    if animalsToBuy[selectedAnimalToBuy][2] > ppBalance then
      sightexports.sGui:showInfobox("e", "Nincs elég PrémiumPontod!")
    else
      local name = sightexports.sGui:getInputValue(buyInput)
      if not name or utf8.len(name) < 1 then
        sightexports.sGui:showInfobox("e", "Add meg a háziallat nevét!")
        return
      end
      triggerServerEvent("tryToBuyPet", localPlayer, selectedAnimalToBuy, name)
    end
  end
  if buyingRect then
    sightexports.sGui:deleteGuiElement(buyingRect)
  end
  buyingRect = false
  if buyingWindow then
    sightexports.sGui:deleteGuiElement(buyingWindow)
    sightexports.sGui:lockHover(rtg, false)
    sightexports.sGui:lockHover(closeButton, false)
    sightexports.sGui:lockHover(helpIcon, false)
  end
  buyingWindow = false
  sellingAnimalTo = false
  selectedAnimalToBuy = false
  buyInput = false
  renameInput = false
  sellInput = false
end)
addEvent("finalRenamePet", true)
addEventHandler("finalRenamePet", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  if playerAnimals[selectedAnimal] and playerAnimals[selectedAnimal].animalId then
    local newName = sightexports.sGui:getInputValue(renameInput)
    if not newName or utf8.len(newName) < 1 then
      sightexports.sGui:showInfobox("e", "Add meg a háziallat nevét!")
      return
    end
    if playerAnimals[selectedAnimal].name ~= newName then
      triggerServerEvent("renamePet", localPlayer, playerAnimals[selectedAnimal].animalId, newName)
    else
      sightexports.sGui:showInfobox("e", "Ugyanaz nem lehet az új neve a háziállatnak, mint a régi!")
      return
    end
  end
  if buyingRect then
    sightexports.sGui:deleteGuiElement(buyingRect)
  end
  buyingRect = false
  if buyingWindow then
    sightexports.sGui:deleteGuiElement(buyingWindow)
    sightexports.sGui:lockHover(rtg, false)
    sightexports.sGui:lockHover(closeButton, false)
    sightexports.sGui:lockHover(helpIcon, false)
  end
  buyingWindow = false
  sellingAnimalTo = false
  selectedAnimalToBuy = false
  buyInput = false
  renameInput = false
  sellInput = false
end)
addEvent("renamePet", true)
addEventHandler("renamePet", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  if playerAnimals[selectedAnimal] then
    if not sightexports.sItems:playerHasItem(423) then
      sightexports.sGui:showInfobox("e", "Nincs háziallat átnevező kártyád!")
      return
    end
    selectedAnimalToBuy = selectPetButton[el]
    local titleBarHeight = sightexports.sGui:getTitleBarHeight()
    local panelWidth = 300
    local panelHeight = titleBarHeight + 5 + 70 + 32 + 5 + 60 + 16
    if buyingWindow then
      sightexports.sGui:deleteGuiElement(buyingWindow)
      sightexports.sGui:lockHover(rtg, false)
      sightexports.sGui:lockHover(closeButton, false)
      sightexports.sGui:lockHover(helpIcon, false)
    end
    sightexports.sGui:lockHover(rtg, true)
    sightexports.sGui:lockHover(closeButton, true)
    sightexports.sGui:lockHover(helpIcon, true)
    if buyingRect then
      sightexports.sGui:deleteGuiElement(buyingRect)
    end
    buyingRect = sightexports.sGui:createGuiElement("rectangle", 0, 0, screenX, screenY)
    sightexports.sGui:setGuiBackground(buyingRect, "solid", {
      0,
      0,
      0,
      150
    })
    buyingWindow = sightexports.sGui:createGuiElement("window", screenX / 2 - panelWidth / 2, screenY / 2 - panelHeight / 2, panelWidth, panelHeight)
    sightexports.sGui:setWindowTitle(buyingWindow, "16/BebasNeueRegular.otf", "Háziállat átnevezés")
    local label = sightexports.sGui:createGuiElement("label", 5, titleBarHeight, panelWidth - 10, 60, buyingWindow)
    sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
    sightexports.sGui:setLabelAlignment(label, "center", "center")
    sightexports.sGui:setLabelText(label, "Név: " .. sightexports.sGui:getColorCodeHex("sightgreen") .. "[#" .. playerAnimals[selectedAnimal].animalId .. "] " .. playerAnimals[selectedAnimal].name .. [[

#ffffffFajta: ]] .. sightexports.sGui:getColorCodeHex("sightgreen") .. playerAnimals[selectedAnimal].type)
    renameInput = sightexports.sGui:createGuiElement("input", 5, titleBarHeight + 5 + 60 + 8, panelWidth - 10, 32, buyingWindow)
    sightexports.sGui:setInputFont(renameInput, "11/Ubuntu-R.ttf")
    sightexports.sGui:setInputIcon(renameInput, "tag")
    sightexports.sGui:setInputPlaceholder(renameInput, "Új név")
    sightexports.sGui:setInputMaxLength(renameInput, 20)
    local btn = sightexports.sGui:createGuiElement("button", 5, panelHeight - 70, panelWidth - 10, 30, buyingWindow)
    sightexports.sGui:setGuiBackground(btn, "solid", "sightblue")
    sightexports.sGui:setGuiHover(btn, "gradient", {
      "sightblue",
      "sightblue-second"
    })
    sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
    sightexports.sGui:setButtonTextColor(btn, "#ffffff")
    sightexports.sGui:setButtonText(btn, "Átnevezés")
    sightexports.sGui:setClickEvent(btn, "finalRenamePet", false)
    local btn = sightexports.sGui:createGuiElement("button", 5, panelHeight - 35, panelWidth - 10, 30, buyingWindow)
    sightexports.sGui:setGuiBackground(btn, "solid", "sightred")
    sightexports.sGui:setGuiHover(btn, "gradient", {
      "sightred",
      "sightred-second"
    })
    sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
    sightexports.sGui:setButtonTextColor(btn, "#ffffff")
    sightexports.sGui:setButtonText(btn, "Mégsem")
    sightexports.sGui:setClickEvent(btn, "closePetPanel", false)
  end
end)
addEvent("finalRevive", true)
addEventHandler("finalRevive", getRootElement(), function()
  if 100 > ppBalance then
    sightexports.sGui:showInfobox("e", "Nincs elég PrémiumPontod!")
    return
  end
  if playerAnimals[selectedAnimal] and playerAnimals[selectedAnimal].animalId then
    triggerServerEvent("buyAnimalRevive", localPlayer, playerAnimals[selectedAnimal].animalId)
  end
  if buyingRect then
    sightexports.sGui:deleteGuiElement(buyingRect)
  end
  buyingRect = false
  if buyingWindow then
    sightexports.sGui:deleteGuiElement(buyingWindow)
    sightexports.sGui:lockHover(rtg, false)
    sightexports.sGui:lockHover(closeButton, false)
    sightexports.sGui:lockHover(helpIcon, false)
  end
  buyingWindow = false
  sellingAnimalTo = false
  selectedAnimalToBuy = false
  buyInput = false
  renameInput = false
  sellInput = false
end)
addEvent("revivePet", true)
addEventHandler("revivePet", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  if playerAnimals[selectedAnimal] and playerAnimals[selectedAnimal].animalId then
    local titleBarHeight = sightexports.sGui:getTitleBarHeight()
    local panelWidth = 300
    local panelHeight = titleBarHeight + 5 + 70 + 90
    if buyingRect then
      sightexports.sGui:deleteGuiElement(buyingRect)
    end
    if buyingWindow then
      sightexports.sGui:deleteGuiElement(buyingWindow)
      sightexports.sGui:lockHover(rtg, false)
      sightexports.sGui:lockHover(closeButton, false)
      sightexports.sGui:lockHover(helpIcon, false)
    end
    sightexports.sGui:lockHover(rtg, true)
    sightexports.sGui:lockHover(closeButton, true)
    sightexports.sGui:lockHover(helpIcon, true)
    buyingRect = sightexports.sGui:createGuiElement("rectangle", 0, 0, screenX, screenY)
    sightexports.sGui:setGuiBackground(buyingRect, "solid", {
      0,
      0,
      0,
      150
    })
    buyingWindow = sightexports.sGui:createGuiElement("window", screenX / 2 - panelWidth / 2, screenY / 2 - panelHeight / 2, panelWidth, panelHeight)
    sightexports.sGui:setWindowTitle(buyingWindow, "16/BebasNeueRegular.otf", "Háziállat felélesztés")
    local label = sightexports.sGui:createGuiElement("label", 5, titleBarHeight, panelWidth - 10, 90, buyingWindow)
    sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
    sightexports.sGui:setLabelAlignment(label, "center", "center")
    sightexports.sGui:setLabelText(label, "Név: " .. sightexports.sGui:getColorCodeHex("sightgreen") .. "[#" .. playerAnimals[selectedAnimal].animalId .. "] " .. playerAnimals[selectedAnimal].name .. [[

#ffffffFajta: ]] .. sightexports.sGui:getColorCodeHex("sightgreen") .. playerAnimals[selectedAnimal].type .. [[

#ffffffPP egyenleg: ]] .. sightexports.sGui:getColorCodeHex("sightblue") .. sightexports.sGui:thousandsStepper(ppBalance) .. " PP" .. "\n#ffffffÁr: " .. sightexports.sGui:getColorCodeHex("sightblue") .. "100 PP")
    local btn = sightexports.sGui:createGuiElement("button", 5, panelHeight - 70, panelWidth - 10, 30, buyingWindow)
    sightexports.sGui:setGuiBackground(btn, "solid", "sightblue")
    sightexports.sGui:setGuiHover(btn, "gradient", {
      "sightblue",
      "sightblue-second"
    })
    sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
    sightexports.sGui:setButtonTextColor(btn, "#ffffff")
    sightexports.sGui:setButtonText(btn, "Felélesztés")
    sightexports.sGui:setClickEvent(btn, "finalRevive", false)
    local btn = sightexports.sGui:createGuiElement("button", 5, panelHeight - 35, panelWidth - 10, 30, buyingWindow)
    sightexports.sGui:setGuiBackground(btn, "solid", "sightred")
    sightexports.sGui:setGuiHover(btn, "gradient", {
      "sightred",
      "sightred-second"
    })
    sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
    sightexports.sGui:setButtonTextColor(btn, "#ffffff")
    sightexports.sGui:setButtonText(btn, "Mégsem")
    sightexports.sGui:setClickEvent(btn, "closePetPanel", false)
  end
end)
addEvent("selectDogTypeBuy", true)
addEventHandler("selectDogTypeBuy", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  if selectPetButton[el] and animalsToBuy[selectPetButton[el]] then
    if animalsToBuy[selectPetButton[el]][2] > ppBalance then
      sightexports.sGui:showInfobox("e", "Nincs elég PrémiumPontod!")
      return
    end
    selectedAnimalToBuy = selectPetButton[el]
    local titleBarHeight = sightexports.sGui:getTitleBarHeight()
    local panelWidth = 300
    local panelHeight = titleBarHeight + 5 + 70 + 32 + 5 + 80 + 16
    if buyingWindow then
      sightexports.sGui:deleteGuiElement(buyingWindow)
      sightexports.sGui:lockHover(rtg, false)
      sightexports.sGui:lockHover(closeButton, false)
      sightexports.sGui:lockHover(helpIcon, false)
    end
    sightexports.sGui:lockHover(rtg, true)
    sightexports.sGui:lockHover(closeButton, true)
    sightexports.sGui:lockHover(helpIcon, true)
    buyingWindow = sightexports.sGui:createGuiElement("window", screenX / 2 - panelWidth / 2, screenY / 2 - panelHeight / 2, panelWidth, panelHeight)
    sightexports.sGui:setWindowTitle(buyingWindow, "16/BebasNeueRegular.otf", "Háziállat vásárlás")
    local label = sightexports.sGui:createGuiElement("label", 5, titleBarHeight, panelWidth - 10, 80, buyingWindow)
    sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
    sightexports.sGui:setLabelAlignment(label, "center", "center")
    sightexports.sGui:setLabelText(label, "Fajta: " .. sightexports.sGui:getColorCodeHex("sightgreen") .. animalsToBuy[selectedAnimalToBuy][1] .. [[

#ffffffPP egyenleg: ]] .. sightexports.sGui:getColorCodeHex("sightblue") .. sightexports.sGui:thousandsStepper(ppBalance) .. " PP" .. "\n#ffffffÁr: " .. sightexports.sGui:getColorCodeHex("sightblue") .. sightexports.sGui:thousandsStepper(animalsToBuy[selectedAnimalToBuy][2]) .. " PP")
    buyInput = sightexports.sGui:createGuiElement("input", 5, titleBarHeight + 5 + 80 + 8, panelWidth - 10, 32, buyingWindow)
    sightexports.sGui:setInputFont(buyInput, "11/Ubuntu-R.ttf")
    sightexports.sGui:setInputIcon(buyInput, "tag")
    sightexports.sGui:setInputPlaceholder(buyInput, "Név")
    sightexports.sGui:setInputMaxLength(buyInput, 20)
    local btn = sightexports.sGui:createGuiElement("button", 5, panelHeight - 70, panelWidth - 10, 30, buyingWindow)
    sightexports.sGui:setGuiBackground(btn, "solid", "sightblue")
    sightexports.sGui:setGuiHover(btn, "gradient", {
      "sightblue",
      "sightblue-second"
    })
    sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
    sightexports.sGui:setButtonTextColor(btn, "#ffffff")
    sightexports.sGui:setButtonText(btn, "Vásárlás")
    sightexports.sGui:setClickEvent(btn, "finalPetBuy", false)
    local btn = sightexports.sGui:createGuiElement("button", 5, panelHeight - 35, panelWidth - 10, 30, buyingWindow)
    sightexports.sGui:setGuiBackground(btn, "solid", "sightred")
    sightexports.sGui:setGuiHover(btn, "gradient", {
      "sightred",
      "sightred-second"
    })
    sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
    sightexports.sGui:setButtonTextColor(btn, "#ffffff")
    sightexports.sGui:setButtonText(btn, "Mégsem")
    sightexports.sGui:setClickEvent(btn, "closePetPanel", false)
  end
end)
addEvent("buyAnimalClick", true)
addEventHandler("buyAnimalClick", getRootElement(), function()
  local titleBarHeight = sightexports.sGui:getTitleBarHeight()
  local panelWidth = 1024
  local one = panelWidth / #animalsToBuy
  local w = one - dashboardPadding[3] * 8
  local h = sightexports.sGui:getFontHeight("14/BebasNeueBold.otf") * 1.75
  local panelHeight = titleBarHeight + one + dashboardPadding[3] * 8 + h + h
  if buyingRect then
    sightexports.sGui:deleteGuiElement(buyingRect)
  end
  if buyingWindow then
    sightexports.sGui:deleteGuiElement(buyingWindow)
    sightexports.sGui:lockHover(rtg, false)
    sightexports.sGui:lockHover(closeButton, false)
    sightexports.sGui:lockHover(helpIcon, false)
  end
  sightexports.sGui:lockHover(rtg, true)
  sightexports.sGui:lockHover(closeButton, true)
  sightexports.sGui:lockHover(helpIcon, true)
  selectPetButton = {}
  buyingRect = sightexports.sGui:createGuiElement("rectangle", 0, 0, screenX, screenY)
  sightexports.sGui:setGuiBackground(buyingRect, "solid", {
    0,
    0,
    0,
    150
  })
  buyingWindow = sightexports.sGui:createGuiElement("window", screenX / 2 - panelWidth / 2, screenY / 2 - panelHeight / 2, panelWidth, panelHeight)
  sightexports.sGui:setWindowTitle(buyingWindow, "16/BebasNeueRegular.otf", "Háziállat vásárlás")
  sightexports.sGui:setWindowCloseButton(buyingWindow, "closePetPanel")
  local label = sightexports.sGui:createGuiElement("label", 0, titleBarHeight, panelWidth, h + dashboardPadding[3] * 4, buyingWindow)
  sightexports.sGui:setLabelFont(label, "16/BebasNeueRegular.otf")
  sightexports.sGui:setLabelAlignment(label, "center", "center")
  sightexports.sGui:setLabelText(label, "PP egyenleg: " .. sightexports.sGui:getColorCodeHex("sightblue") .. sightexports.sGui:thousandsStepper(ppBalance) .. " PP")
  for i = 1, #animalsToBuy do
    local rect = sightexports.sGui:createGuiElement("rectangle", (i - 1) * one + 3 + dashboardPadding[3] * 4, titleBarHeight + h + 3 + dashboardPadding[3] * 4, w, one + h, buyingWindow)
    sightexports.sGui:setGuiBackground(rect, "solid", "#000000")
    local rect = sightexports.sGui:createGuiElement("rectangle", (i - 1) * one + dashboardPadding[3] * 4, titleBarHeight + h + dashboardPadding[3] * 4, w, one + h, buyingWindow)
    sightexports.sGui:setGuiBackground(rect, "gradient", {"sightgrey3", "sightgrey1"})
    sightexports.sGui:setGuiHoverable(rect, true)
    sightexports.sGui:setGuiHover(rect, "gradient", {"sightgrey1", "sightgrey3"}, true)
    sightexports.sGui:setClickEvent(rect, "selectDogTypeBuy", false)
    selectPetButton[rect] = i
    local img = sightexports.sGui:createGuiElement("image", 0, 0 + h, w, w, rect)
    sightexports.sGui:setImageDDS(img, ":sDashboard/files/dogs/" .. utf8.lower(utf8.gsub(animalsToBuy[i][1], " ", "")) .. ".dds")
    local label = sightexports.sGui:createGuiElement("label", 0, 0, w, h * 0.8, rect)
    sightexports.sGui:setLabelFont(label, "14/BebasNeueBold.otf")
    sightexports.sGui:setLabelAlignment(label, "center", "center")
    sightexports.sGui:setLabelText(label, animalsToBuy[i][1])
    local label = sightexports.sGui:createGuiElement("label", 0, 0 + w + h, w, one - w, rect)
    sightexports.sGui:setLabelFont(label, "13/BebasNeueRegular.otf")
    sightexports.sGui:setLabelAlignment(label, "center", "center")
    sightexports.sGui:setLabelColor(label, "sightblue")
    sightexports.sGui:setLabelText(label, sightexports.sGui:thousandsStepper(animalsToBuy[i][2]) .. " PP")
  end
end)
local sellingWindow = false
addEvent("acceptAnimalSell", true)
addEventHandler("acceptAnimalSell", getRootElement(), function()
  if sellingWindow then
    sightexports.sGui:deleteGuiElement(sellingWindow)
    sellingWindow = false
    triggerServerEvent("animalSellResponse", localPlayer, true)
  end
end)
addEvent("declineAnimalSell", true)
addEventHandler("declineAnimalSell", getRootElement(), function()
  if sellingWindow then
    sightexports.sGui:deleteGuiElement(sellingWindow)
    sellingWindow = false
    triggerServerEvent("animalSellResponse", localPlayer, false)
  end
end)
addEvent("endAnimalSell", true)
addEventHandler("endAnimalSell", getRootElement(), function()
  if sellingWindow then
    sightexports.sGui:deleteGuiElement(sellingWindow)
    sellingWindow = false
  end
end)
addEvent("startAnimalSelling", true)
addEventHandler("startAnimalSelling", getRootElement(), function(animalId, data, price)
  if isElement(source) then
    local titleBarHeight = sightexports.sGui:getTitleBarHeight()
    local panelWidth = 275
    local panelHeight = titleBarHeight + 140 + 5 + 30
    if sellingWindow then
      sightexports.sGui:deleteGuiElement(sellingWindow)
    end
    sellingWindow = sightexports.sGui:createGuiElement("window", screenX / 2 - panelWidth / 2, screenY - panelHeight - 48, panelWidth, panelHeight)
    sightexports.sGui:setWindowTitle(sellingWindow, "16/BebasNeueRegular.otf", "Háziállat eladási ajánlat")
    local health = math.floor(data.health + 0.5)
    local hunger = math.floor(data.hunger + 0.5)
    local love = math.floor(data.love + 0.5)
    if health <= 25 then
      health = sightexports.sGui:getColorCodeHex("sightred") .. health .. "%#ffffff"
    elseif health <= 75 then
      health = sightexports.sGui:getColorCodeHex("sightyellow") .. health .. "%#ffffff"
    else
      health = sightexports.sGui:getColorCodeHex("sightgreen") .. health .. "%#ffffff"
    end
    if hunger <= 25 then
      hunger = sightexports.sGui:getColorCodeHex("sightred") .. hunger .. "%#ffffff"
    elseif hunger <= 75 then
      hunger = sightexports.sGui:getColorCodeHex("sightyellow") .. hunger .. "%#ffffff"
    else
      hunger = sightexports.sGui:getColorCodeHex("sightgreen") .. hunger .. "%#ffffff"
    end
    if love <= 25 then
      love = sightexports.sGui:getColorCodeHex("sightred") .. love .. "%#ffffff"
    elseif love <= 75 then
      love = sightexports.sGui:getColorCodeHex("sightyellow") .. love .. "%#ffffff"
    else
      love = sightexports.sGui:getColorCodeHex("sightgreen") .. love .. "%#ffffff"
    end
    local label = sightexports.sGui:createGuiElement("label", 5, titleBarHeight, panelWidth - 10, 140, sellingWindow)
    sightexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    sightexports.sGui:setLabelText(label, "Név: " .. sightexports.sGui:getColorCodeHex("sightgreen") .. "[" .. animalId .. "] " .. data.name .. [[
#ffffff
Fajta: ]] .. sightexports.sGui:getColorCodeHex("sightgreen") .. data.type .. "\n#ffffffÉleterő: " .. health .. "\nÉhség: " .. hunger .. [[

Szeretet: ]] .. love .. "\nEladó: " .. sightexports.sGui:getColorCodeHex("sightgreen") .. getElementData(source, "visibleName"):gsub("_", " ") .. "\n#FFFFFFÁr: " .. sightexports.sGui:getColorCodeHex("sightgreen") .. sightexports.sGui:thousandsStepper(price) .. " $")
    local btnW = (panelWidth - 15) / 2
    local btn = sightexports.sGui:createGuiElement("button", 5, panelHeight - 35, btnW, 30, sellingWindow)
    sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
    sightexports.sGui:setGuiHover(btn, "gradient", {
      "sightgreen",
      "sightgreen-second"
    })
    sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
    sightexports.sGui:setButtonTextColor(btn, "#ffffff")
    sightexports.sGui:setButtonText(btn, "Vásárlás")
    sightexports.sGui:setClickEvent(btn, "acceptAnimalSell", false)
    local btn = sightexports.sGui:createGuiElement("button", 10 + btnW, panelHeight - 35, btnW, 30, sellingWindow)
    sightexports.sGui:setGuiBackground(btn, "solid", "sightred")
    sightexports.sGui:setGuiHover(btn, "gradient", {
      "sightred",
      "sightred-second"
    })
    sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
    sightexports.sGui:setButtonTextColor(btn, "#ffffff")
    sightexports.sGui:setButtonText(btn, "Mégsem")
    sightexports.sGui:setClickEvent(btn, "declineAnimalSell", false)
  end
end)
