local seexports = {sGui = false}
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
local seelangStatImgHand = false
local seelangStaticImage = {}
local seelangStaticImageToc = {}
local seelangStaticImageUsed = {}
local seelangStaticImageDel = {}
local processSeelangStaticImage = {}
seelangStaticImageToc[0] = true
local seelangStatImgPre
function seelangStatImgPre()
  local now = getTickCount()
  if seelangStaticImageUsed[0] then
    seelangStaticImageUsed[0] = false
    seelangStaticImageDel[0] = false
  elseif seelangStaticImage[0] then
    if seelangStaticImageDel[0] then
      if now >= seelangStaticImageDel[0] then
        if isElement(seelangStaticImage[0]) then
          destroyElement(seelangStaticImage[0])
        end
        seelangStaticImage[0] = nil
        seelangStaticImageDel[0] = false
        seelangStaticImageToc[0] = true
        return
      end
    else
      seelangStaticImageDel[0] = now + 5000
    end
  else
    seelangStaticImageToc[0] = true
  end
  if seelangStaticImageToc[0] then
    seelangStatImgHand = false
    removeEventHandler("onClientPreRender", getRootElement(), seelangStatImgPre)
  end
end
processSeelangStaticImage[0] = function()
  if not isElement(seelangStaticImage[0]) then
    seelangStaticImageToc[0] = false
    seelangStaticImage[0] = dxCreateTexture("files/cards/cardback.dds", "dxt1", true)
  end
  if not seelangStatImgHand then
    seelangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), seelangStatImgPre, true, "high+999999999")
  end
end
local seelangDynImgHand = false
local seelangDynImgLatCr = falselocal
seelangDynImage = {}
local seelangDynImageForm = {}
local seelangDynImageMip = {}
local seelangDynImageUsed = {}
local seelangDynImageDel = {}
local seelangDynImgPre
function seelangDynImgPre()
  local now = getTickCount()
  seelangDynImgLatCr = true
  local rem = true
  for k in pairs(seelangDynImage) do
    rem = false
    if seelangDynImageDel[k] then
      if now >= seelangDynImageDel[k] then
        if isElement(seelangDynImage[k]) then
          destroyElement(seelangDynImage[k])
        end
        seelangDynImage[k] = nil
        seelangDynImageForm[k] = nil
        seelangDynImageMip[k] = nil
        seelangDynImageDel[k] = nil
        break
      end
    elseif not seelangDynImageUsed[k] then
      seelangDynImageDel[k] = now + 5000
    end
  end
  for k in pairs(seelangDynImageUsed) do
    if not seelangDynImage[k] and seelangDynImgLatCr then
      seelangDynImgLatCr = false
      seelangDynImage[k] = dxCreateTexture(k, seelangDynImageForm[k], seelangDynImageMip[k])
    end
    seelangDynImageUsed[k] = nil
    seelangDynImageDel[k] = nil
    rem = false
  end
  if rem then
    removeEventHandler("onClientPreRender", getRootElement(), seelangDynImgPre)
    seelangDynImgHand = false
  end
end
local function dynamicImage(img, form, mip)
  if not seelangDynImgHand then
    seelangDynImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), seelangDynImgPre, true, "high+999999999")
  end
  if not seelangDynImage[img] then
    seelangDynImage[img] = dxCreateTexture(img, form, mip)
  end
  seelangDynImageForm[img] = form
  seelangDynImageUsed[img] = true
  return seelangDynImage[img]
end
local faTicks = false
local function seelangGuiRefreshColors()
  local res = getResourceFromName("sGui")
  if res and getResourceState(res) == "running" then
    faTicks = seexports.sGui:getFaTicks()
    refreshColors()
  end
end
addEventHandler("onGuiRefreshColors", getRootElement(), seelangGuiRefreshColors)
addEventHandler("onClientResourceStart", getResourceRootElement(), seelangGuiRefreshColors)
addEventHandler("refreshFaTicks", getRootElement(), function()
  faTicks = seexports.sGui:getFaTicks()
end)
local seelangCondHandlState0 = false
local function seelangCondHandl0(cond, prio)
  cond = cond and true or false
  if cond ~= seelangCondHandlState0 then
    seelangCondHandlState0 = cond
    if cond then
      addEventHandler("onClientRender", getRootElement(), renderStreamedBJ, true, prio)
    else
      removeEventHandler("onClientRender", getRootElement(), renderStreamedBJ)
    end
  end
end
local screenWidth, screenHeight = guiGetScreenSize()
local screenX, screenY = screenWidth, screenHeight
local slotCoins = 0
local hitProgress = false
function reMap(x, in_min, in_max, out_min, out_max)
  return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min
end
local responsiveMultipler = 1
local fontSizeMultipler = 1
local bebas3d = false
local bebas3dScale = false
local chatFont = false
local chatFontScale = false
local greenhex = false
local redhex = false
local sightgrey1 = false
local sightgrey4 = false
local sightgreen = false
local sightyellow = false
local numberFont = false
local numberFontScale = false
local sitIcon = false
local sitColor = false
local sitBgColor = false
function refreshColors()
  bebas3d = seexports.sGui:getFont("12/BebasNeueRegular.otf")
  bebas3dScale = seexports.sGui:getFontScale("12/BebasNeueRegular.otf")
  numberFont = seexports.sGui:getFont("16/BebasNeueBold.otf")
  numberFontScale = seexports.sGui:getFontScale("16/BebasNeueBold.otf")
  chatFont = seexports.sGui:getFont("10/Ubuntu-L.ttf")
  chatFontScale = seexports.sGui:getFontScale("10/Ubuntu-L.ttf")
  sightgrey1 = seexports.sGui:getColorCodeToColor("sightgrey1")
  sightgrey2 = seexports.sGui:getColorCodeToColor("sightgrey2")
  sightgreen = seexports.sGui:getColorCodeToColor("sightgreen")
  sightyellow = seexports.sGui:getColorCodeToColor("sightyellow")
  greenhex = seexports.sGui:getColorCodeHex("sightgreen")
  redhex = seexports.sGui:getColorCodeHex("sightred")
  sitIcon = seexports.sGui:getFaIconFilename("user", 24)
  sitColor = seexports.sGui:getColorCodeToColor("sightgreen")
  sitBgColor = seexports.sGui:getColorCode("sightgrey1")
end
local tableContainer = {}
local cardPositions = {
  dealer = {
    0.7,
    -0.1,
    0
  },
  dealerCard = {
    0.1,
    -0.6,
    0
  },
  playerCard = {
    0.1,
    -1.03,
    0
  }
}
local realCardPositions = {}
local tablePositions = {}
local streamedTables = {}
local animQueue = {}
function generateTables()
  for k, v in pairs(tablePositions) do
    realCardPositions[k] = {}
    for m, n in pairs(cardPositions) do
      local rx, ry = rotateAround(n[3], 0, 0.105)
      local rx2, ry2 = rotateAround(n[3], 0, -0.045)
      local addX, addY = rotateAround(v[4], n[1] + rx, n[2] + ry)
      local addX2, addY2 = rotateAround(v[4], n[1] + rx2, n[2] + ry2)
      realCardPositions[k][m] = {
        v[1] + addX,
        v[2] + addY,
        v[1] + addX2,
        v[2] + addY2,
        v[3] + 0.02
      }
    end
  end
end
local cardTextures = {}
for k, v in ipairs(cardRanks) do
  for i = 1, 4 do
    cardTextures[v .. "-" .. i] = "files/cards/" .. v .. "-" .. i .. ".dds"
  end
end
local tableData = {}
local panelWidth = 400
local panelHeight = 250
local panelPosX = screenWidth / 2 - panelWidth / 2
local panelPosY = screenHeight / 2 - panelHeight / 2
local canSlide = true
local sliderInUse = false
local nowPlayingTable
local nowPlayingId = 0
local actionsAllowed = true
local tblHover = false
function renderStreamedBJ()
  local px, py, pz = getElementPosition(localPlayer)
  local tmpHover = false
  for i, v in pairs(streamedTables) do
    if animQueue[i] and animQueue[i][1] then
      local data = animQueue[i][1]
      local progress = (getTickCount() - data.tick) / 800
      local startPositions = data.startPositions
      local stopPositions = data.stopPositions
      local rx, ry, rz = interpolateBetween(startPositions[1], startPositions[2], startPositions[3], stopPositions[1], stopPositions[2], stopPositions[3], progress, "Linear")
      local rx2, ry2, rz2 = interpolateBetween(startPositions[4], startPositions[5], startPositions[6], stopPositions[4], stopPositions[5], stopPositions[6], progress, "Linear")
      seelangStaticImageUsed[0] = true
      if seelangStaticImageToc[0] then
        processSeelangStaticImage[0]()
      end
      dxDrawMaterialLine3D(rx, ry, rz, rx2, ry2, rz2, cardTextures[data.texture] and dynamicImage(cardTextures[data.texture], "dxt1") or seelangStaticImage[0], 0.1, tocolor(255, 255, 255), rx, ry, rz + 1)
      if 1 <= progress then
        if animQueue[i][1]["function"] then
          animQueue[i][1]["function"](i)
          animQueue[i][1]["function"] = nil
        end
        table.remove(animQueue[i], 1)
        if animQueue[i][1] then
          animQueue[i][1].tick = getTickCount()
        end
      end
    end
    if streamedTables[i].player.element then
      local a, b = getPedAnimation(streamedTables[i].player.element)
      if a ~= "int_office" or b ~= "off_sit_idle_loop" then
        setPedAnimation(streamedTables[i].player.element, "int_office", "off_sit_idle_loop", -1, true, false, false, false)
      end
    elseif nowPlayingId == 0 then
      local x, y, z = getElementPosition(streamedTables[i].object)
      if 4 >= getDistanceBetweenPoints3D(x, y, z, px, py, pz) then
        local rx, ry, rz = getElementRotation(streamedTables[i].object)
        rz = math.rad(rz + 90)
        local tablex, tabley = getScreenFromWorldPosition(streamedTables[i].positions[1], streamedTables[i].positions[2], streamedTables[i].positions[3], 110)
        if tablex and tabley then
          dxDrawRectangle(tablex - 84, tabley - 18, 168, 36, sightgrey1)
          dxDrawText("Min. tét/kör:", tablex - 80, tabley - 18, 0, tabley, tocolor(255, 255, 255, 255), bebas3dScale, bebas3d, "left", "center", false, false, false, true)
          dxDrawText(thousandsStepper(streamedTables[i].minEntry) .. " SSC", tablex - 80, tabley - 18, tablex + 80, tabley, sightyellow, bebas3dScale, bebas3d, "right", "center", false, false, false, true)
          dxDrawText("Max. tét/kör:", tablex - 80, tabley, 0, tabley + 18, tocolor(255, 255, 255, 255), bebas3dScale, bebas3d, "left", "center", false, false, false, true)
          dxDrawText(thousandsStepper(streamedTables[i].maxEntry) .. " SSC", tablex - 80, tabley, tablex + 80, tabley + 18, sightyellow, bebas3dScale, bebas3d, "right", "center", false, false, false, true)
        end
        local x, y = getScreenFromWorldPosition(x - 1.6 * math.cos(rz), y - 1.6 * math.sin(rz), z + 0.2, 32)
        if x then
          local cx, cy = getCursorPosition()
          if cx then
            cx = cx * screenX
            cy = cy * screenY
          end
          if cx and cx >= x - 16 and cx <= x + 16 and cy >= y - 16 and cy <= y + 16 then
            tmpHover = i
            dxDrawRectangle(x - 16, y - 16, 32, 32, tocolor(sitBgColor[1], sitBgColor[2], sitBgColor[3]))
            dxDrawImage(x - 12, y - 12, 24, 24, ":sGui/" .. sitIcon .. faTicks[sitIcon], 0, 0, 0, sitColor)
          else
            dxDrawRectangle(x - 16, y - 16, 32, 32, tocolor(sitBgColor[1], sitBgColor[2], sitBgColor[3]))
            dxDrawImage(x - 12, y - 12, 24, 24, ":sGui/" .. sitIcon .. faTicks[sitIcon], 0, 0, 0, tocolor(255, 255, 255))
          end
        end
      end
    end
    if streamedTables[i].gameState ~= 0 then
      if streamedTables[i].cards then
        local forceHide = false
        for k, v in pairs(streamedTables[i].cards) do
          local slots = 0.125 * #streamedTables[i].cards - 0.025
          local startSlot = slots / 2
          if animQueue[i] and animQueue[i][1] and animQueue[i][1].theType == "dealer" then
            local modifier1 = interpolateBetween(0, 0, 0, 1, 0, 0, (getTickCount() - animQueue[i][1].tick) / 800, "Linear")
            slots = 0.125 * (#streamedTables[i].cards + modifier1) - 0.025
            startSlot = slots / 2
          end
          local x1, y1, z1, x2, y2, z2 = realCardPositions[i].dealerCard[1], realCardPositions[i].dealerCard[2], realCardPositions[i].dealerCard[5], realCardPositions[i].dealerCard[3], realCardPositions[i].dealerCard[4], realCardPositions[i].dealerCard[5]
          local addX, addY = rotateAround(tablePositions[i][4], startSlot, 0)
          local addX2, addY2 = rotateAround(tablePositions[i][4], (k - 1) * 0.125, 0)
          if streamedTables[i].gameState == 1 then
            if k == 2 then
              forceHide = true
            else
              forceHide = false
            end
          end
          seelangStaticImageUsed[0] = true
          if seelangStaticImageToc[0] then
            processSeelangStaticImage[0]()
          end
          local texture = seelangStaticImage[0]
          if not forceHide then
            texture = dynamicImage(cardTextures[cardRanks[v[1]] .. "-" .. v[2]], "dxt1")
          end
          dxDrawMaterialLine3D(x1 - addX + addX2, y1 - addY + addY2, z1, x2 - addX + addX2, y2 - addY + addY2, z2, texture, 0.1, tocolor(255, 255, 255), x1 - addX + addX2, y1 - addY + addY2, z1 + 1)
        end
      end
      if streamedTables[i].player.cards then
        for k, v in pairs(streamedTables[i].player.cards) do
          local slots2 = 0.125 * #streamedTables[i].player.cards - 0.025
          local startSlot2 = slots2 / 2
          local x1, y1, z1, x2, y2, z2 = realCardPositions[i].playerCard[1], realCardPositions[i].playerCard[2], realCardPositions[i].playerCard[5], realCardPositions[i].playerCard[3], realCardPositions[i].playerCard[4], realCardPositions[i].playerCard[5]
          local modifier = 0
          if animQueue[i] and animQueue[i][1] and animQueue[i][1].theType == "player" then
            local modifier = interpolateBetween(0, 0, 0, 1, 0, 0, (getTickCount() - animQueue[i][1].tick) / 800, "Linear")
            slots2 = 0.125 * (#streamedTables[i].player.cards + modifier) - 0.025
            startSlot2 = slots2 / 2
          end
          local addX, addY = rotateAround(tablePositions[i][4], startSlot2, 0)
          local addX2, addY2 = rotateAround(tablePositions[i][4], (k - 1) * 0.125, 0)
          dxDrawMaterialLine3D(x1 - addX + addX2, y1 - addY + addY2, z1, x2 - addX + addX2, y2 - addY + addY2, z2, dynamicImage(cardTextures[cardRanks[v[1]] .. "-" .. v[2]], "dxt1"), 0.1, tocolor(255, 255, 255), x1 - addX + addX2, y1 - addY + addY2, z1 + 1)
        end
      end
    end
  end
  if tmpHover ~= tblHover then
    tblHover = tmpHover
    seexports.sGui:setCursorType(tblHover and "link" or "normal")
    seexports.sGui:showTooltip(tblHover and "Leülés")
  end
end
addEventHandler("onClientClick", root, function(btn, state)
  if state == "up" and tblHover then
    triggerServerEvent("tryToSitBlackJack", localPlayer, tblHover)
  end
end)
local dX, dY = screenWidth / 2, screenHeight
local blackjackChatLines = {}
local blackjackChatOffset = 0
function addBlackjackChatLine(msg)
  if utf8.find(msg, "%[color%=[a-zA-Z1-9%-]*%]") then
    msg = utf8.gsub(msg, "%[color%=([a-zA-Z1-9%-]*)%]", function(color)
      return seexports.sGui:getColorCodeHex(color) or "#ffc0cb"
    end)
  end
  table.insert(blackjackChatLines, 1, msg)
  if 50 < #blackjackChatLines then
    table.remove(blackjackChatLines, #blackjackChatLines)
  end
end
addEvent("addBlackjackChat", true)
addEventHandler("addBlackjackChat", root, function(msg)
  addBlackjackChatLine(greenhex .. "[" .. string.format("%02d", getRealTime().hour) .. ":" .. string.format("%02d", getRealTime().minute) .. "]: " .. msg)
end)
function renderBJ()
  buttons = {}
  local absoluteX, absoluteY = 0, 0
  canSlide = false
  if isCursorShowing() then
    local mouseX, mouseY = getCursorPosition()
    absoluteX = mouseX * screenWidth
    absoluteY = mouseY * screenHeight
  elseif sliderInUse then
    sliderInUse = false
  end
  if not getKeyState("mouse1") and sliderInUse then
    sliderInUse = false
  end
  if nowPlayingTable.gameState == 0 then
  else
    actionsAllowed = false
    if not animQueue[nowPlayingId] then
      actionsAllowed = true
    end
    if animQueue[nowPlayingId] and #animQueue[nowPlayingId] == 0 and not hitProgress then
      actionsAllowed = true
    end
    local panelWidth = 400
    local panelHeight = 150
    local panelPosX = 30
    local panelPosY = screenHeight - panelHeight - 30
    dxDrawRectangle(panelPosX, panelPosY, panelWidth, panelHeight, sightgrey2)
    dxDrawRectangle(panelPosX + 4, panelPosY + 4, panelWidth - 8, panelHeight - 8, sightgrey1)
    local rowHeight = (panelHeight - 16 - 8) / 7
    local size = #blackjackChatLines
    if size < 6 then
      size = 6
    end
    local scrollsize = (panelHeight - 16) / (size - 6)
    dxDrawRectangle(panelPosX + panelWidth - 4 - 8, panelPosY + panelHeight - 8 - (blackjackChatOffset + 1) * scrollsize, 4, scrollsize, sightgreen)
    for k = 1, 7 do
      if blackjackChatLines[k + blackjackChatOffset] then
        dxDrawText(blackjackChatLines[k + blackjackChatOffset], panelPosX + 8 + 4, panelPosY + 8 + 4 + rowHeight * (7 - k), 0, panelPosY + 8 + 4 + rowHeight * (7 - k + 1), sightyellow, chatFontScale, chatFont, "left", "center", false, false, false, true)
      end
    end
    local table_Cards = streamedTables[nowPlayingId].cards
    local player_Cards = streamedTables[nowPlayingId].player.cards
    if 0 < #player_Cards then
      local w = 8 + #player_Cards * 88
      local x = screenWidth / 2 - w / 2
      local y = screenHeight - 30 - 116
      dxDrawRectangle(x, y, w, 116, sightgrey1)
      local colorCode_player = greenhex
      if getValueOf(player_Cards) > 21 then
        colorCode_player = redhex
      end
      dxDrawText("Játékos: " .. colorCode_player .. getValueOf(player_Cards), 0, 0, screenX, y - 4, tocolor(255, 255, 255, 255), numberFontScale, numberFont, "center", "bottom", false, false, false, true)
      x = x + 8
      y = y + 8
      for i = 1, #player_Cards do
        local v = player_Cards[i]
        dxDrawImage(x, y, 80, 100, dynamicImage(cardTextures[cardRanks[streamedTables[nowPlayingId].player.cards[i][1]] .. "-" .. streamedTables[nowPlayingId].player.cards[i][2]], "dxt1"), 0, 0, 0, tocolor(255, 255, 255, 255))
        x = x + 88
      end
    end
    if 0 < #table_Cards then
      local w = 8 + #table_Cards * 68
      local x = screenWidth / 2 - w / 2
      local y = screenHeight - 30 - 116 - 48 - 91
      dxDrawRectangle(x, y, w, 91, sightgrey1)
      local text = "Osztó: " .. greenhex .. getValueOf({
        table_Cards[1]
      })
      if streamedTables[nowPlayingId].gameState ~= 1 then
        local colorCode_table = greenhex
        if getValueOf(table_Cards) > 21 then
          colorCode_table = redhex
        end
        text = "Osztó: " .. colorCode_table .. getValueOf(table_Cards)
      end
      dxDrawText(text, 0, 0, screenX, y - 4, tocolor(255, 255, 255, 255), numberFontScale * 0.875, numberFont, "center", "bottom", false, false, false, true)
      x = x + 8
      y = y + 8
      for i = 1, #table_Cards do
        local v = table_Cards[i]
        if i == 2 and streamedTables[nowPlayingId].gameState == 1 then
          seelangStaticImageUsed[0] = true
          if seelangStaticImageToc[0] then
            processSeelangStaticImage[0]()
          end
          dxDrawImage(x, y, 60, 75, seelangStaticImage[0], 0, 0, 0, tocolor(255, 255, 255, 255))
        else
          dxDrawImage(x, y, 60, 75, dynamicImage(cardTextures[cardRanks[streamedTables[nowPlayingId].cards[i][1]] .. "-" .. streamedTables[nowPlayingId].cards[i][2]], "dxt1"), 0, 0, 0, tocolor(255, 255, 255, 255))
        end
        x = x + 68
      end
    end
  end
  activeButton = false
  for k, v in pairs(buttons) do
    if absoluteX >= v[1] and absoluteX <= v[1] + v[3] and absoluteY >= v[2] and absoluteY <= v[2] + v[4] then
      activeButton = k
      break
    end
  end
end
addEvent("onOpenBlackjack", true)
addEventHandler("onOpenBlackjack", root, function(data)
  nowPlayingTable = data
  nowPlayingId = data.tableId
  createPayInWindow()
  addEventHandler("onClientRender", root, renderBJ)
end)
addEventHandler("onClientResourceStart", resourceRoot, function()
  if getElementData(localPlayer, "loggedIn") then
    triggerServerEvent("requestSSC", localPlayer)
  end
  setTimer(triggerServerEvent, 1000, 1, "requestBlackjackTables", localPlayer)
end)
addEvent("getBlackjackTables", true)
addEventHandler("getBlackjackTables", root, function(tables)
  tablePositions = tables
  generateTables()
end)
addEventHandler("onClientObjectStreamIn", resourceRoot, function()
  local data = getElementData(source, "blackjack.data")
  if data and data.tableId then
    local tableData = data or {}
    tableContainer[tableData.tableId] = tableData
    streamedTables[data.tableId] = data
    seelangCondHandl0(true)
  end
end)
addEventHandler("onClientObjectStreamOut", resourceRoot, function()
  local data = getElementData(source, "blackjack.data")
  if data and data.tableId then
    streamedTables[data.tableId] = nil
    for k in pairs(streamedTables) do
      return
    end
    seelangCondHandl0(false)
  end
end)
function insertDealerCard(tableId, tableData, cardId, hidden)
  local texture = cardRanks[tableData.cards[cardId][1]] .. "-" .. tableData.cards[cardId][2]
  if hidden then
    texture = nil
  end
  local stopPositions = {
    realCardPositions[tableId].dealerCard[1],
    realCardPositions[tableId].dealerCard[2],
    realCardPositions[tableId].dealerCard[5],
    realCardPositions[tableId].dealerCard[3],
    realCardPositions[tableId].dealerCard[4],
    realCardPositions[tableId].dealerCard[5]
  }
  local slots = 0.125 * (#streamedTables[tableId].cards + 1) - 0.025
  local startSlot = slots / 2
  local addX, addY = rotateAround(tablePositions[tableId][4], startSlot, 0)
  local addX2, addY2 = rotateAround(tablePositions[tableId][4], (cardId - 1) * 0.125, 0)
  if not animQueue[tableId] then
    animQueue[tableId] = {}
  end
  table.insert(animQueue[tableId], {
    theType = "dealer",
    tick = getTickCount(),
    texture = texture or nil,
    startPositions = {
      realCardPositions[tableId].dealer[1],
      realCardPositions[tableId].dealer[2],
      realCardPositions[tableId].dealer[5],
      realCardPositions[tableId].dealer[3],
      realCardPositions[tableId].dealer[4],
      realCardPositions[tableId].dealer[5]
    },
    stopPositions = {
      stopPositions[1] - addX + addX2,
      stopPositions[2] - addY + addY2,
      stopPositions[3],
      stopPositions[4] - addX + addX2,
      stopPositions[5] - addY + addY2,
      stopPositions[6]
    },
    ["function"] = function(tableId)
      table.insert(streamedTables[tableId].cards, tableContainer[tableId].cards[cardId])
    end
  })
end
function insertPlayerCard(tableId, tableData, cardId, hidden)
  local texture = cardRanks[tableData.player.cards[cardId][1]] .. "-" .. tableData.player.cards[cardId][2]
  if hidden then
    texture = nil
  end
  local stopPositions = {
    realCardPositions[tableId].playerCard[1],
    realCardPositions[tableId].playerCard[2],
    realCardPositions[tableId].playerCard[5],
    realCardPositions[tableId].playerCard[3],
    realCardPositions[tableId].playerCard[4],
    realCardPositions[tableId].playerCard[5]
  }
  if streamedTables[tableId] and streamedTables[tableId].player and streamedTables[tableId].player.cards then
    local slots = 0.125 * (#streamedTables[tableId].player.cards + 1) - 0.025
    local startSlot = slots / 2
    local addX, addY = rotateAround(tablePositions[tableId][4], startSlot, 0)
    local addX2, addY2 = rotateAround(tablePositions[tableId][4], (cardId - 1) * 0.125, 0)
    table.insert(animQueue[tableId], {
      theType = "player",
      tick = getTickCount(),
      texture = texture or nil,
      startPositions = {
        realCardPositions[tableId].dealer[1],
        realCardPositions[tableId].dealer[2],
        realCardPositions[tableId].dealer[5],
        realCardPositions[tableId].dealer[3],
        realCardPositions[tableId].dealer[4],
        realCardPositions[tableId].dealer[5]
      },
      stopPositions = {
        stopPositions[1] - addX + addX2,
        stopPositions[2] - addY + addY2,
        stopPositions[3],
        stopPositions[4] - addX + addX2,
        stopPositions[5] - addY + addY2,
        stopPositions[6]
      },
      ["function"] = function(tableId)
        table.insert(streamedTables[tableId].player.cards, tableContainer[tableId].player.cards[cardId])
      end
    })
  end
end
playerIcons = {}
addEvent("refreshSSC", true)
addEventHandler("refreshSSC", getRootElement(), function(amount)
  slotCoins = amount
end)
local payInSliderValue = 0
function refreshPayInAmount()
  payInAmount = nowPlayingTable.minEntry + math.floor(payInSliderValue * (nowPlayingTable.maxEntry - nowPlayingTable.minEntry) / 50) * 50
  seexports.sGui:setLabelText(payInLabel, "Tét: [color=sightyellow]" .. seexports.sGui:thousandsStepper(payInAmount) .. " SSC")
end
addEvent("changeBlackJackPayIn", false)
addEventHandler("changeBlackJackPayIn", getRootElement(), function(el, sliderValue, final)
  payInSliderValue = sliderValue
  refreshPayInAmount()
end)
addEvent("tryToPayInBlackJack", false)
addEventHandler("tryToPayInBlackJack", getRootElement(), function()
  if payInAmount > slotCoins then
    seexports.sGui:showInfobox("e", "Nincs elég SSC-d a befizetéshez!")
  elseif tonumber(payInAmount) < nowPlayingTable.minEntry or tonumber(payInAmount) > nowPlayingTable.maxEntry then
    addBlackjackChatLine("Hiba történt.")
  else
    triggerServerEvent("blackJackHandler", localPlayer, "pot", payInAmount)
    deletePayInWindow()
  end
end)
addEvent("exitBlackJackPayIn", false)
addEventHandler("exitBlackJackPayIn", getRootElement(), function(el, sliderValue, final)
  closeBJ()
  deletePayInWindow()
end)
local buttonPanel = false
function deleteButtonPanel()
  if buttonPanel then
    seexports.sGui:deleteGuiElement(buttonPanel)
  end
  buttonPanel = false
end
addEvent("blackJackHit", false)
addEventHandler("blackJackHit", getRootElement(), function()
  if actionsAllowed and not nowPlayingTable.suspended and #streamedTables[nowPlayingId].player.cards >= 2 then
    actionsAllowed = false
    triggerServerEvent("blackJackHandler", localPlayer, "hit")
  end
end)
addEvent("blackJackStay", false)
addEventHandler("blackJackStay", getRootElement(), function()
  if actionsAllowed and not nowPlayingTable.suspended then
    triggerServerEvent("blackJackHandler", localPlayer, "stay")
  end
end)
addEvent("blackJackDouble", false)
addEventHandler("blackJackDouble", getRootElement(), function()
  if actionsAllowed and #nowPlayingTable.player.cards == 2 then
    triggerServerEvent("blackJackHandler", localPlayer, "double")
  end
end)
function createButtonPanel()
  deletePayInWindow()
  deleteButtonPanel()
  local pw, ph = 480, 60
  buttonPanel = seexports.sGui:createGuiElement("rectangle", screenWidth - pw - 30, screenHeight - ph - 30, pw, ph)
  seexports.sGui:setGuiBackground(buttonPanel, "solid", "sightgrey1")
  local w = (pw - 8) / 3
  local btn = seexports.sGui:createGuiElement("button", 8, 8, w - 8, ph - 16, buttonPanel)
  seexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
  seexports.sGui:setGuiHover(btn, "gradient", {
    "sightgreen",
    "sightgreen-second"
  }, false, true)
  seexports.sGui:setButtonFont(btn, "16/BebasNeueBold.otf")
  seexports.sGui:setButtonIcon(btn, seexports.sGui:getFaIconFilename("plus", ph - 16))
  seexports.sGui:setButtonText(btn, "Lapkérés")
  seexports.sGui:setClickEvent(btn, "blackJackHit")
  local btn = seexports.sGui:createGuiElement("button", 8 + w, 8, w - 8, ph - 16, buttonPanel)
  seexports.sGui:setGuiBackground(btn, "solid", "sightorange")
  seexports.sGui:setGuiHover(btn, "gradient", {
    "sightorange",
    "sightorange-second"
  }, false, true)
  seexports.sGui:setButtonFont(btn, "16/BebasNeueBold.otf")
  seexports.sGui:setButtonIcon(btn, seexports.sGui:getFaIconFilename("hand-paper", ph - 16))
  seexports.sGui:setButtonText(btn, "Megállás")
  seexports.sGui:setClickEvent(btn, "blackJackStay")
  local btn = seexports.sGui:createGuiElement("button", 8 + w * 2, 8, w - 8, ph - 16, buttonPanel)
  seexports.sGui:setGuiBackground(btn, "solid", "sightblue")
  seexports.sGui:setGuiHover(btn, "gradient", {
    "sightblue",
    "sightblue-second"
  }, false, true)
  seexports.sGui:setButtonFont(btn, "16/BebasNeueBold.otf")
  seexports.sGui:setButtonIcon(btn, seexports.sGui:getFaIconFilename("chevron-double-up", ph - 16))
  seexports.sGui:setButtonText(btn, "Duplázás")
  seexports.sGui:setClickEvent(btn, "blackJackDouble")
end
function deletePayInWindow()
  if payInWindow then
    seexports.sGui:deleteGuiElement(payInWindow)
  end
  payInWindow = false
  payInLabel = false
  payInAmount = 0
end
function createPayInWindow()
  deletePayInWindow()
  deleteButtonPanel()
  local titleBarHeight = seexports.sGui:getTitleBarHeight()
  local pw, ph = 350, titleBarHeight + 32 + 15 + 8 + 24 + 8 + 24 + 8
  payInWindow = seexports.sGui:createGuiElement("window", screenX / 2 - pw / 2, screenY / 2 - ph / 2, pw, ph)
  seexports.sGui:setWindowTitle(payInWindow, "16/BebasNeueRegular.otf", "Blackjack")
  payInLabel = seexports.sGui:createGuiElement("label", 0, titleBarHeight, pw, 32, payInWindow)
  seexports.sGui:setLabelColor(payInLabel, "#ffffff")
  seexports.sGui:setLabelFont(payInLabel, "12/Ubuntu-R.ttf")
  seexports.sGui:setLabelAlignment(payInLabel, "center", "center")
  local slider = seexports.sGui:createGuiElement("slider", 8, titleBarHeight + 32, pw - 16, 15, payInWindow)
  seexports.sGui:setSliderChangeEvent(slider, "changeBlackJackPayIn")
  seexports.sGui:setSliderValue(slider, payInSliderValue)
  local btn = seexports.sGui:createGuiElement("button", 8, titleBarHeight + 32 + 15 + 8, pw - 16, 24, payInWindow)
  seexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
  seexports.sGui:setGuiHover(btn, "gradient", {
    "sightgreen",
    "sightgreen-second"
  }, false, true)
  seexports.sGui:setButtonFont(btn, "14/BebasNeueBold.otf")
  seexports.sGui:setButtonTextColor(btn, "#ffffff")
  seexports.sGui:setButtonText(btn, "Játék indítása")
  seexports.sGui:setClickEvent(btn, "tryToPayInBlackJack")
  local btn = seexports.sGui:createGuiElement("button", 8, titleBarHeight + 32 + 15 + 8 + 24 + 8, pw - 16, 24, payInWindow)
  seexports.sGui:setGuiBackground(btn, "solid", "sightred")
  seexports.sGui:setGuiHover(btn, "gradient", {
    "sightred",
    "sightred-second"
  }, false, true)
  seexports.sGui:setButtonFont(btn, "14/BebasNeueBold.otf")
  seexports.sGui:setButtonTextColor(btn, "#ffffff")
  seexports.sGui:setButtonText(btn, "Kiszállok")
  seexports.sGui:setClickEvent(btn, "exitBlackJackPayIn")
  refreshPayInAmount()
end
addEventHandler("onClientElementDataChange", root, function(data, oldValue)
  if data == "blackjack.data" and getElementType(source) == "object" then
    local tableData = getElementData(source, "blackjack.data") or {}
    local tableId = tableData.tableId
    if nowPlayingId and tableId == nowPlayingId then
      if tableData.gameState == 0 then
        createPayInWindow()
      else
        createButtonPanel()
      end
    end
    if nowPlayingTable and nowPlayingTable.tableId == tableId then
      nowPlayingTable = tableData
      if nowPlayingTable.gameState == 0 and oldValue.gameState ~= 0 then
        blackjackChatLines = {}
      end
      hitProgress = false
    end
    tableContainer[tableData.tableId] = tableData
    if streamedTables[tableData.tableId] then
      streamedTables[tableData.tableId] = getElementData(source, "blackjack.data")
      if oldValue.gameState == 0 and tableData.gameState ~= 0 then
        streamedTables[tableData.tableId].cards = {}
        streamedTables[tableData.tableId].player.cards = {}
        animQueue[tableData.tableId] = {}
        insertDealerCard(tableData.tableId, tableData, 1, false)
        setTimer(function(tableData)
          insertDealerCard(tableData.tableId, tableData, 2, true)
          insertPlayerCard(tableData.tableId, tableData, 1, false)
          setTimer(function(tableData)
            insertPlayerCard(tableData.tableId, tableData, 2, false)
          end, 2400, 1, tableData)
        end, 850, 1, tableData)
      elseif tableData.gameState ~= 0 then
        streamedTables[tableData.tableId] = getElementData(source, "blackjack.data")
        if not table_eq(oldValue.player.cards, tableData.player.cards) and #tableData.player.cards > 2 then
          streamedTables[tableData.tableId].player.cards = oldValue.player.cards
          insertPlayerCard(tableData.tableId, tableData, #tableContainer[tableData.tableId].player.cards, false)
        end
        if oldValue.cards ~= tableData.cards and oldValue.gameState ~= tableData.gameState and tableData.gameState ~= 2 then
          streamedTables[tableData.tableId].cards = oldValue.cards
          insertDealerCard(tableData.tableId, tableData, #tableContainer[tableData.tableId].cards, false)
        end
      elseif tableData.gameState == 0 and oldValue.gameState ~= 0 then
        streamedTables[tableData.tableId] = getElementData(source, "blackjack.data")
        streamedTables[tableData.tableId].cards = {}
        streamedTables[tableData.tableId].player = {}
        animQueue[tableData.tableId] = {}
      end
    end
  end
end)
function closeBJ()
  activeButton = false
  removeEventHandler("onClientRender", root, renderBJ)
  triggerServerEvent("quitBlackjack", localPlayer)
  deletePayInWindow()
  deleteButtonPanel()
  setElementFrozen(localPlayer, false)
  setPedAnimation(localPlayer)
  buttons = {}
  blackjackChatLines = {}
  nowPlayingId = 0
  canSlide = true
  sliderInUse = false
end
addEventHandler("onClientKey", getRootElement(), function(button, isPressed)
  if 0 < nowPlayingId then
    if button == "mouse_wheel_up" then
      if blackjackChatOffset < #blackjackChatLines - 7 then
        blackjackChatOffset = blackjackChatOffset + 1
      end
    elseif button == "mouse_wheel_down" and 0 < blackjackChatOffset then
      blackjackChatOffset = blackjackChatOffset - 1
    end
  end
end)
addEvent("playBlackjackSound", true)
addEventHandler("playBlackjackSound", root, function(x, y, z, int, dim, sound)
  local soundElement = playSound3D("files/sounds/" .. sound .. ".mp3", x, y, z)
  setElementInterior(soundElement, int)
  setElementDimension(soundElement, dim)
end)
