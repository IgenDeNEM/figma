local sightexports = {sHud = false, sGui = false}
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
actionBarItemSize = 52
local actionBarWidgetState = false
local actionBarWidgetPos = {0, 0}
local actionBarWidgetSize = {0, 0}
local actionBarPlusPos = {}
local actionBarOrientation = false
local actionBarItems = 0
local itemBorder = (actionBarItemSize - 36) / 2
local hoverBorder = (actionBarItemSize - 80) / 2
local useBorder = (actionBarItemSize - 66) / 2
local actionbarData = {}
local data = {}
function putOnActionBar(slotId, itemData)
  if actionBarWidgetState and slotId and 1 <= slotId and slotId <= 9 then
    if not actionbarData[slotId] then
      data[slotId] = itemData.dbID
      refreshAbData()
      triggerServerEvent("saveActionBar", localPlayer, data)
      return true
    else
      return false
    end
  else
    return false
  end
end
function removeFromActionBar(slotId)
  if actionBarWidgetState and slotId then
    if actionbarData[slotId] then
      data[slotId] = nil
      refreshAbData()
      triggerServerEvent("saveActionBar", localPlayer, data)
      return true
    else
      return false
    end
  else
    return false
  end
end
addEvent("gotActionBar", true)
addEventHandler("gotActionBar", resourceRoot, function(d)
  data = d
  refreshAbData()
end)
function refreshAbData()
  actionbarData = {}
  local itemData = {}
  local idToFind = {}
  for k = 1, 9 do
    if data[k] then
      idToFind[data[k]] = true
    end
  end
  for k, v in pairs(itemsTable.player) do
    if idToFind[v.dbID] then
      itemData[v.dbID] = k
    end
  end
  for k = 1, 9 do
    if data[k] then
      local id = data[k]
      if itemData[id] then
        actionbarData[k] = itemData[id]
      end
    end
  end
end
local currAbHover = false
local useItemHover = false
function findActionBarSlot()
  return currAbHover
end
addEventHandler("onClientClick", getRootElement(), function(button, state, absoluteX, absoluteY, worldX, worldY, worldZ, clickedElement)
  if actionBarWidgetState and getElementData(localPlayer, "loggedIn") and not sightexports.sHud:getWidgetEditMode() then
    if currAbHover then
      if state == "down" and actionbarData[currAbHover] then
        removeFromActionBar(currAbHover)
        playSound("files/sounds/moveselect.wav")
      end
    elseif useItemHover and state == "down" then
      if button == "left" then
        currentItemInUse = false
        currentItemRemainUses = false
      else
        useSpecialItem()
      end
    end
  end
end)
local kitt = false
fenyjatek = false
jutiudv = false
local urmatext = {
  "S",
  "I",
  "G",
  "H",
  "T",
  "M",
  "T",
  "A"
}
addCommandHandler("juti", function()
  jutiudv = not jutiudv
end)
addCommandHandler("kitt", function()
  kitt = not kitt
  fenyjatek = false
end)
addCommandHandler("fényjáték", function()
  fenyjatek = not fenyjatek
  kitt = false
end)
function renderActionBar()
  currAbHover = false
  local x = actionBarWidgetPos[1] + actionBarPlusPos[1]
  local y = actionBarWidgetPos[2] + actionBarPlusPos[2]
  local cx, cy = getCursorPosition()
  if cx then
    cx = cx * screenX
    cy = cy * screenY
  end
  for k = 1, actionBarItems do
    dxDrawImage(x + hoverBorder, y + hoverBorder, 80, 80, "actionbar/item.dds", 0, 0, 0, hudWhite)
    local hover = cx and cx >= x + itemBorder and cy >= y + itemBorder and cx <= x + actionBarItemSize - itemBorder and cy <= y + actionBarItemSize - itemBorder
    local itemActive = false
    local itemSecActive = false
    local currentItem = false
    local data3 = false
    local currentAmount = 1
    local dbID = false
    local itemData = false
    if actionbarData[k] then
      itemData = itemsTable.player[actionbarData[k]]
      if itemData then
        currentItem = itemData.itemId
        currentAmount = itemData.amount
        data3 = itemData.data3
        dbID = itemData.dbID
        itemActive = usingItem == dbID
        itemSecActive = usingSecondaryItems[dbID]
      end
    end
    local itemColor = false
    if hover then
      currAbHover = k
      itemColor = itemActive and hoverColor or bitReplace(hoverColor, 174, 24, 8)
    elseif itemActive then
      itemColor = useColor
    elseif itemSecActive then
      itemColor = useColor2
    elseif getKeyState(k) then
      itemColor = bitReplace(useColor, 174, 24, 8)
    end
    if kitt then
      local t = getTickCount() % (actionBarItems * 80 * 2)
      if t > actionBarItems * 80 then
        t = actionBarItems * 80 * 2 - t
      end
      local i = math.floor(t / 80) + 1
      if i == k then
        itemColor = redColor
      end
    elseif fenyjatek then
      if k > actionBarItems / 3 * 2 then
        itemColor = useColor
      elseif k > actionBarItems / 3 then
        itemColor = tocolor(255, 255, 255)
      else
        itemColor = redColor
      end
    end
    if itemColor then
      dxDrawImage(x + useBorder, y + useBorder, 66, 66, "actionbar/itemHover.dds", 0, 0, 0, itemColor)
    end
    if currentItem then
      local perishable = false
      local alpha = 255
      if perishableItems[currentItem] then
        alpha = 255 * (1 - data3 / perishableItems[currentItem])
        perishable = grayItemPictures[currentItem]
      end
      if copyableItems[currentItem] and isTheItemCopy(itemData) then
        alpha = 0
        perishable = grayItemPictures[currentItem]
      end
      if perishable then
        dxDrawImage(x + itemBorder, y + itemBorder, 36, 36, perishable)
      end
      dxDrawImage(x + itemBorder, y + itemBorder, 36, 36, getItemPic(itemData), 0, 0, 0, tocolor(255, 255, 255, alpha))
      local dose = 1
      if doseItems[itemData.itemId] then
        dose = tonumber(itemData.data1)
        if dose then
          dose = 1 - dose / doseItems[itemData.itemId]
        else
          dose = 1
        end
      end
      if dose < 1 then
        dxDrawRectangle(x + itemBorder + 3, y + itemBorder + 36 - 8 - 1, 30, 6, titlebar)
        dxDrawRectangle(x + itemBorder + 4, y + itemBorder + 36 - 8, 28 * dose, 4, useColor)
      elseif currentAmount ~= 1 then
        dxDrawText(currentAmount, 0, 0, x + actionBarItemSize - itemBorder - 1, y + actionBarItemSize - itemBorder - 1, tocolor(0, 0, 0, 174), craftFontScale * 0.8, craftFont, "right", "bottom", false, false, false, true)
        dxDrawText(currentAmount, 0, 0, x + actionBarItemSize - itemBorder - 2, y + actionBarItemSize - itemBorder - 2, hudWhite, craftFontScale * 0.8, craftFont, "right", "bottom", false, false, false, true)
      end
    end
    if jutiudv then
      local i = -1
      if actionBarItems < 9 then
        local t = getTickCount() % 4500
        i = math.floor(t / 500) + 1
      end
      dxDrawText(urmatext[(k + i) % 9 + 1], x, y, x + actionBarItemSize, y + actionBarItemSize, itemColor or hudWhite, craftFontScale * 1.5, craftFont, "center", "center", false, false, false, true)
    end
    if actionBarOrientation then
      x = x + actionBarItemSize
    else
      y = y + actionBarItemSize
    end
  end
end
addEvent("hudWidgetState:actionBar", true)
addEventHandler("hudWidgetState:actionBar", getRootElement(), function(state)
  if actionBarWidgetState ~= state then
    actionBarWidgetState = state
    currAbHover = false
    if actionBarWidgetState then
      addEventHandler("onClientRender", getRootElement(), renderActionBar)
    else
      removeEventHandler("onClientRender", getRootElement(), renderActionBar)
    end
  end
end)
addEvent("hudWidgetPosition:actionBar", true)
addEventHandler("hudWidgetPosition:actionBar", getRootElement(), function(pos, final)
  actionBarWidgetPos = pos
end)
addEvent("hudWidgetSize:actionBar", true)
addEventHandler("hudWidgetSize:actionBar", getRootElement(), function(size, final)
  actionBarWidgetSize = size
  actionBarOrientation = size[1] >= size[2]
  actionBarItems = math.floor(actionBarOrientation and size[1] / actionBarItemSize or size[2] / actionBarItemSize)
  actionBarPlusPos[1] = (size[1] - (actionBarOrientation and actionBarItems or 1) * actionBarItemSize) / 2
  actionBarPlusPos[2] = (size[2] - (actionBarOrientation and 1 or actionBarItems) * actionBarItemSize) / 2
  itemBorder = (actionBarItemSize - 36) / 2
  hoverBorder = (actionBarItemSize - 80) / 2
  useBorder = (actionBarItemSize - 66) / 2
end)
local useItemWidgetState = false
local useItemWidgetPos = false
local useItemWidgetSize = false
local usePos = {}
function renderUseItem()
  if currentItemInUse then
    local x, y = usePos[1], usePos[2]
    dxDrawImage(x + hoverBorder, y + hoverBorder, 80, 80, "actionbar/item.dds", 0, 0, 0, hudWhite)
    local p = 1 - currentItemRemainUses / specialItems[currentItemInUse.itemId][2]
    dxDrawImageSection(x + useBorder, y + useBorder, 66, 66 * p, 0, 0, 66, 66 * p, "actionbar/itemHover.dds", 0, 0, 0, tocolor(80, 80, 80, 50))
    dxDrawImageSection(x + useBorder, y + useBorder + 66 * p, 66, 66 * (1 - p), 0, 66 * p, 66, 66 * (1 - p), "actionbar/itemHover.dds", 0, 0, 0, tocolor(255, 255, 255, 50))
    dxDrawImageSection(x + useBorder, y + useBorder + 66 * p, 66, 66 * (1 - p), 0, 66 * p, 66, 66 * (1 - p), "actionbar/itemHover.dds", 0, 0, 0, useColor)
    local perishable = false
    local alpha = 255
    if perishableItems[currentItemInUse.itemId] then
      alpha = 255 * (1 - currentItemInUse.data3 / perishableItems[currentItemInUse.itemId])
      perishable = grayItemPictures[currentItemInUse.itemId]
    end
    if copyableItems[currentItemInUse.itemId] and isTheItemCopy(currentItemInUse) then
      alpha = 0
      perishable = grayItemPictures[currentItem]
    end
    if perishable then
      dxDrawImage(x + itemBorder, y + itemBorder, 36, 36, perishable)
    end
    dxDrawImage(x + itemBorder, y + itemBorder, 36, 36, getItemPic(currentItemInUse), 0, 0, 0, tocolor(255, 255, 255, alpha))
    local cx, cy = getCursorPosition()
    local hoverState = false
    if cx then
      cx = cx * screenX
      cy = cy * screenY
      hoverState = x <= cx and y <= cy and cx <= x + 36 and cy <= y + 36
    end
    if hoverState ~= useItemHover then
      useItemHover = hoverState
      if useItemHover then
        sightexports.sGui:showTooltip("Bal egérgomb: tárgy eldobása\nJobb egérgomb: tárgy használata")
        sightexports.sGui:setCursorType("link")
      else
        sightexports.sGui:showTooltip(false)
        sightexports.sGui:setCursorType("normal")
      end
    end
  end
end
addEvent("hudWidgetState:useItem", true)
addEventHandler("hudWidgetState:useItem", getRootElement(), function(state)
  if useItemWidgetState ~= state then
    useItemWidgetState = state
    useItemHover = false
    if useItemWidgetState then
      addEventHandler("onClientRender", getRootElement(), renderUseItem)
    else
      removeEventHandler("onClientRender", getRootElement(), renderUseItem)
    end
  end
end)
addEvent("hudWidgetPosition:useItem", true)
addEventHandler("hudWidgetPosition:useItem", getRootElement(), function(pos, final)
  useItemWidgetPos = pos
  if useItemWidgetSize then
    usePos[1] = useItemWidgetPos[1] + useItemWidgetSize[1] / 2 - actionBarItemSize / 2
    usePos[2] = useItemWidgetPos[2] + useItemWidgetSize[2] / 2 - actionBarItemSize / 2
  end
end)
addEvent("hudWidgetSize:useItem", true)
addEventHandler("hudWidgetSize:useItem", getRootElement(), function(size, final)
  useItemWidgetSize = size
  if useItemWidgetPos then
    usePos[1] = useItemWidgetPos[1] + useItemWidgetSize[1] / 2 - actionBarItemSize / 2
    usePos[2] = useItemWidgetPos[2] + useItemWidgetSize[2] / 2 - actionBarItemSize / 2
  end
end)
function isPointOnActionBar(absoluteX, absoluteY)
  if actionBarWidgetState then
    local x = actionBarWidgetPos[1] + actionBarPlusPos[1]
    local y = actionBarWidgetPos[2] + actionBarPlusPos[2]
    local w = actionBarItemSize
    local h = actionBarItemSize
    if actionBarOrientation then
      w = actionBarItemSize * actionBarItems
    else
      h = actionBarItemSize * actionBarItems
    end
    if absoluteX >= x and absoluteX <= x + w and absoluteY >= y and absoluteY <= y + h then
      return true
    end
  end
  return false
end
triggerEvent("requestWidgetDatas", localPlayer, "actionBar")
triggerEvent("requestWidgetDatas", localPlayer, "useItem")
bindKey("1", "down", function()
  useActionSlot(1)
end)
bindKey("2", "down", function()
  useActionSlot(2)
end)
bindKey("3", "down", function()
  useActionSlot(3)
end)
bindKey("4", "down", function()
  useActionSlot(4)
end)
bindKey("5", "down", function()
  useActionSlot(5)
end)
bindKey("6", "down", function()
  useActionSlot(6)
end)
bindKey("7", "down", function()
  useActionSlot(7)
end)
bindKey("8", "down", function()
  useActionSlot(8)
end)
bindKey("9", "down", function()
  useActionSlot(9)
end)
function useActionSlot(slotId)
  if getElementData(localPlayer, "goldrob.holdingGoldBox") then
    return outputChatBox("#7cc576[SightMTA]: #ffffffBiztonsági ládával a kezedben nem használhatod.", 0, 255, 255, true)
  end
  if not haveMoving and actionBarWidgetState and slotId and slotId <= actionBarItems and actionbarData[slotId] and not guiGetInputEnabled() then
    local databaseId = tonumber(data[slotId])
    if databaseId then
      useItem(databaseId)
    end
  end
end
