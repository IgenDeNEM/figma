local sightexports = {sPermission = false}
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
local tooltipTextColor = tocolor(255, 255, 255, 255)
function showTooltip(absoluteX, absoluteY, firstText, secondText, xCenter, justCalculate)
  firstText = tostring(firstText)
  secondText = secondText and tostring(secondText)
  if firstText == secondText then
    secondText = nil
  end
  local currentHeight = 30
  local currentWidth = dxGetTextWidth(firstText, craftFontScale * 0.95, craftFont, true) + 16
  if secondText then
    currentWidth = math.max(currentWidth, dxGetTextWidth(secondText, craftFontScale * 0.95, craftFont, true) + 16)
    firstText = greenHex .. firstText .. [[

#ffffff]] .. secondText
    local sc, scLines = utf8.gsub(secondText, "\n", "")
    currentHeight = currentHeight + dxGetFontHeight(craftFontScale * 0.95, craftFont) * (scLines + 1)
  end
  if not justCalculate then
    local pg = true
    if xCenter then
      absoluteX = math.floor(absoluteX - currentWidth / 2)
      pg = false
    else
      absoluteX = absoluteX + 8
      absoluteY = absoluteY + 16
    end
    dxDrawRectangle(absoluteX, absoluteY, currentWidth, currentHeight, tocolor(0, 0, 0, 200), pg)
    dxDrawText(firstText, absoluteX, absoluteY, absoluteX + currentWidth, absoluteY + currentHeight, tooltipTextColor, craftFontScale * 0.95, craftFont, "center", "center", false, false, pg, true)
  end
  return currentWidth, currentHeight
end
local pictureState = false
local picturePath
function showBigBookPicture(path)
  if not pictureState then
    pictureState = true
    addEventHandler("onClientRender", getRootElement(), bigPic)
    picturePath = path
  else
    pictureState = false
    removeEventHandler("onClientRender", getRootElement(), bigPic)
    picturePath = nil
  end
end
addEvent("showBigBookPicture", true)
addEventHandler("showBigBookPicture", getRootElement(), showBigBookPicture)
function bigPic()
  dxDrawImage(sx / 2 - 350, sy / 2 - 250, 700, 500, picturePath)
end
wItemList, bItemListClose = nil, nil
function showItemList()
  if not sightexports.sPermission:hasPermission(localPlayer, "itemlist") then
    return
  end
  if not wItemsList then
    wItemsList = guiCreateWindow(0.15, 0.15, 0.7, 0.7, "Items List", true)
    local gridItems = guiCreateGridList(0.025, 0.1, 0.95, 0.775, true, wItemsList)
    local colID = guiGridListAddColumn(gridItems, "ID", 0.1)
    local colName = guiGridListAddColumn(gridItems, "Tárgy neve", 0.3)
    local colDesc = guiGridListAddColumn(gridItems, "Leírás", 0.3)
    local colWeight = guiGridListAddColumn(gridItems, "kiló", 0.3)
    for key, value in pairs(itemList) do
      local row = guiGridListAddRow(gridItems)
      guiGridListSetItemText(gridItems, row, colID, tostring(key), false, true)
      guiGridListSetItemText(gridItems, row, colName, value[1], false, false)
      guiGridListSetItemText(gridItems, row, colDesc, value[2], false, false)
      guiGridListSetItemText(gridItems, row, colWeight, value[10], false, false)
    end
    bItemListClose = guiCreateButton(0.025, 0.9, 0.95, 0.1, "Bezárás", true, wItemsList)
    addEventHandler("onClientGUIClick", bItemListClose, closeItemsList, false)
    showCursor(true)
  else
    guiSetVisible(wItemsList, true)
    guiBringToFront(wItemsList)
    showCursor(true)
  end
end