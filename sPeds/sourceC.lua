local sightexports = {
  sGui = false,
  sItems = false,
  sModloader = false
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
local faTicks = false
local function sightlangGuiRefreshColors()
  local res = getResourceFromName("sGui")
  if res and getResourceState(res) == "running" then
    faTicks = sightexports.sGui:getFaTicks()
    guiRefreshColors()
  end
end
addEventHandler("onGuiRefreshColors", getRootElement(), sightlangGuiRefreshColors)
addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangGuiRefreshColors)
addEventHandler("refreshFaTicks", getRootElement(), function()
  faTicks = sightexports.sGui:getFaTicks()
end)
local sightlangModloaderLoaded = function()
  modloaderListener()
end
addEventHandler("modloaderLoaded", getRootElement(), sightlangModloaderLoaded)
if getElementData(localPlayer, "loggedIn") or sightexports.sModloader and sightexports.sModloader:isModloaderLoaded() then
  addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangModloaderLoaded)
end
screenX, screenY = guiGetScreenSize()
local pedElements = {}
local pedElementsBack = {}
pedDatas = {}
if getElementData(localPlayer, "loggedIn") then
  triggerLatentServerEvent("requestPedShops", localPlayer)
end
function modloaderListener()
  triggerLatentServerEvent("requestPedShops", localPlayer)
end
local categoryIcons = {}
local transp = {
  200,
  200,
  200,
  150
}
local transp2 = {}
function guiRefreshColors()
  for i = 1, #categoryIconsRaw do
    categoryIcons[i] = sightexports.sGui:getFaIconFilename(categoryIconsRaw[i], 32)
  end
  transp2 = sightexports.sGui:getColorCode("sightred")
  transp2 = {
    transp2[1],
    transp2[2],
    transp2[3],
    150
  }
end
function processPedElement(id)
  local ped = pedElements[id]
  if ped then
    if isElement(ped) then
      destroyElement(ped)
    end
    pedElementsBack[ped] = nil
  end
  pedElements[id] = nil
  if pedDatas[id] then
    pedElements[id] = createPed(pedDatas[id].skin, pedDatas[id].posX, pedDatas[id].posY, pedDatas[id].posZ, pedDatas[id].posR)
    if not isElement(pedElements[id]) then
      pedElements[id] = createPed(1, pedDatas[id].posX, pedDatas[id].posY, pedDatas[id].posZ, pedDatas[id].posR)
    end
    setElementInterior(pedElements[id], pedDatas[id].interior)
    setElementDimension(pedElements[id], pedDatas[id].dimension)
    setElementFrozen(pedElements[id], true)
    setElementData(pedElements[id], "invulnerable", true)
    setElementData(pedElements[id], "visibleName", pedDatas[id].name)
    setElementData(pedElements[id], "pedNameType", "Bolt")
    pedElementsBack[pedElements[id]] = id
  end
end
local shopPedsInited = false

function arePedsInit()
  return shopPedsInited
end

addEvent("gotPedShops", true)
addEventHandler("gotPedShops", getRootElement(), function(dat)
  pedDatas = dat
  for id in pairs(dat) do
    processPedElement(id)
  end
  shopPedsInited = true
end)
addEvent("gotSinglePedShopData", true)
addEventHandler("gotSinglePedShopData", getRootElement(), function(id, dat)
  pedDatas[id] = dat
  processPedElement(id)
end)
local shopWindow = false
local pedCategories = {}
local pedItems = false
local canEdit = false
local allowedItems = false
local cartItems = {}
local cartItemList = {}
local cartElements = false
local cartScroll = false
local editMode = false
local catW = 0
local loaderOverlay = false
local categoryRect = false
local cartRect = false
local cartLabel = false
local cartArrow = false
local editButton = false
local warehouseButton = false
local unsavedChanges = false
local unsavedOverlay = false
local changedItems = false
local categoryDeletes = false
local categorySwaps = false
local openedShop = false
local selectedCategory = false
local itemElements = {}
local itemButtons = {}
local categoryButtons = {}
local scrollHandled = false
local editItemCategory = false
local editScroll = 0
local editingCategory = false
local editingItem = false
local editingItemList = false
local editElements = false
local editWindow = false
local editingWareItem = false
local wareElements = false
local wareItemList = false
local wareItemCategory = false
local wareScroll = 0
local pedStock = {}
local pedPrice = {}
local pedBalance = 0
function deleteShopWindow()
  showCursor(false)
  local x, y = screenX / 2, screenY / 2
  if editWindow then
    sightexports.sGui:deleteGuiElement(editWindow)
  end
  editWindow = false
  editElements = false
  wareElements = false
  if shopWindow then
    local sx, sy = sightexports.sGui:getGuiSize(shopWindow)
    x, y = sightexports.sGui:getGuiPosition(shopWindow)
    x = x + sx / 2
    y = y + sy / 2
    sightexports.sGui:deleteGuiElement(shopWindow)
  end
  if scrollHandled then
    removeEventHandler("onClientKey", getRootElement(), scrollHandler)
  end
  scrollHandled = false
  catW = 0
  categoryRect = false
  cartRect = false
  cartLabel = false
  cartArrow = false
  editButton = false
  loaderOverlay = false
  unsavedOverlay = false
  shopWindow = false
  cartElements = false
  wareItemList = false
  editingItemList = false
  warehouseButton = false
  itemElements = {}
  itemButtons = {}
  categoryButtons = {}
  return x, y
end
addEvent("closePedShop", false)
addEventHandler("closePedShop", getRootElement(), function()
  editMode = false
  canEdit = false
  deleteShopWindow()
  pedCategoryNames = {}
  pedCategoryTooltips = {}
  pedCategoryIcons = {}
  pedItems = false
  openedShop = false
  selectedCategory = false
  editingCategory = false
  editingItem = false
  cartItemList = {}
  cartItems = {}
  unsavedChanges = false
  changedItems = editMode and {} or false
  categoryDeletes = editMode and {} or false
  categorySwaps = false
  editingWareItem = false
  allowedItems = {}
  wholesalePrices = {}
  pedStock = {}
  pedPrice = {}
  editMode = false
end)
addEvent("gotPedShopItems", true)
addEventHandler("gotPedShopItems", getRootElement(), function(id, cat, dat, sel, pp, ps)
  if id == openedShop then
    if sel then
      for i = 1, #pedCategories do
        if pedCategories[i].categoryId == cat then
          selectedCategory = i
          break
        end
      end
      refreshCategoryButtons()
    end
    if cat == pedCategories[selectedCategory].categoryId then
      if pp and ps then
        if canEdit then
          for item, v in pairs(ps) do
            pedStock[item] = v
          end
          for item, v in pairs(pp) do
            pedPrice[item] = v
          end
        else
          pedStock = ps
          pedPrice = pp
        end
      end
      pedItems = dat
      refreshShopWindow()
    end
  end
end)
addEvent("gotPedShopCategories", true)
addEventHandler("gotPedShopCategories", getRootElement(), function(id, dat, mi, mj, noRefresh, refCat)
  if id == openedShop then
    pedCategories = {}
    for cat, d in pairs(dat) do
      d.categoryId = cat
      table.insert(pedCategories, d)
    end
    table.sort(pedCategories, sortCategories)
    for i = 1, #pedCategories do
      pedCategories[i].maxI = mi[pedCategories[i].categoryId] or 0
      pedCategories[i].maxJ = mj[pedCategories[i].categoryId] or 0
    end
    if refCat then
      selectedCategory = 1
      for i = 1, #pedCategories do
        if pedCategories[i].categoryId == refCat then
          selectedCategory = i
        end
      end
      createShopWindow()
      triggerLatentServerEvent("requestPedShopItems", localPlayer, openedShop, pedCategories[selectedCategory].categoryId)
      createLoaderOverlay()
    elseif tonumber(noRefresh) then
      for i = 1, #pedCategories do
        if pedCategories[i].categoryId == tonumber(noRefresh) then
          selectedCategory = i
          break
        end
      end
      refreshCategoryButtons()
      if loaderOverlay then
        sightexports.sGui:deleteGuiElement(loaderOverlay)
      end
      loaderOverlay = false
    elseif not noRefresh then
      local requestItems = false
      if pedCategories[1] then
        selectedCategory = 1
        requestItems = true
        pedItems = false
      end
      createShopWindow()
      if requestItems then
        triggerLatentServerEvent("requestPedShopItems", localPlayer, openedShop, pedCategories[selectedCategory].categoryId)
        createLoaderOverlay()
      end
    end
  end
end)
function createShopLoadWindow()
  local x, y = deleteShopWindow()
  local titleBarHeight = sightexports.sGui:getTitleBarHeight()
  local w, h = 200, 200
  showCursor(true)
  shopWindow = sightexports.sGui:createGuiElement("window", math.max(0, x - w / 2), math.max(0, y - h / 2), w, h)
  sightexports.sGui:setWindowCloseButton(shopWindow, "closePedShop")
  sightexports.sGui:setWindowElementMaxDistance(shopWindow, pedElements[openedShop], 3, "closePedShop")
  sightexports.sGui:setWindowTitle(shopWindow, "16/BebasNeueRegular.otf", getShopTitle(-32))
  local loadingIcon = sightexports.sGui:createGuiElement("image", w / 2 - 24, titleBarHeight + (h - titleBarHeight) / 2 - 24, 48, 48, shopWindow)
  sightexports.sGui:setImageFile(loadingIcon, sightexports.sGui:getFaIconFilename("circle-notch", 48))
  sightexports.sGui:setImageSpinner(loadingIcon, true)
end
addEvent("gotPedShopCanEdit", true)
addEventHandler("gotPedShopCanEdit", getRootElement(), function(id, can, allowed, wp, ps, pp)
  if id == openedShop then
    canEdit = can
    if canEdit then
      allowedItems = allowed
      wholesalePrices = wp
      pedStock = ps
      pedPrice = pp
    end
  end
end)
addEventHandler("onClientClick", getRootElement(), function(button, state, x, y, wx, wy, wz, clickedElement)
  if state == "down" and pedElementsBack[clickedElement] and not shopWindow and not editWindow and not wizardWindow then
    local x, y, z = getElementPosition(clickedElement)
    local px, py, pz = getElementPosition(localPlayer)
    if getDistanceBetweenPoints3D(x, y, z, px, py, pz) < 3 then
      openedShop = pedElementsBack[clickedElement]
      createShopLoadWindow()
      triggerLatentServerEvent("requestPedShopInit", localPlayer, openedShop)
    end
  end
end, true, "high+999999999999")
function createLoaderOverlay()
  if shopWindow and not loaderOverlay then
    local w, h = sightexports.sGui:getGuiSize(shopWindow)
    local titleBarHeight = sightexports.sGui:getTitleBarHeight()
    loaderOverlay = sightexports.sGui:createGuiElement("rectangle", 0, titleBarHeight, w, h - titleBarHeight, shopWindow)
    sightexports.sGui:setGuiBackground(loaderOverlay, "solid", {
      0,
      0,
      0,
      150
    })
    sightexports.sGui:setGuiHover(loaderOverlay, "none", false, false, true)
    sightexports.sGui:setGuiHoverable(loaderOverlay, true)
    sightexports.sGui:disableClickTrough(loaderOverlay, true)
    sightexports.sGui:disableLinkCursor(loaderOverlay, true)
    local loadingIcon = sightexports.sGui:createGuiElement("image", w / 2 - 24, (h - titleBarHeight) / 2 - 24, 48, 48, loaderOverlay)
    sightexports.sGui:setImageFile(loadingIcon, sightexports.sGui:getFaIconFilename("circle-notch", 48))
    sightexports.sGui:setImageSpinner(loadingIcon, true)
  end
end
function refreshCartLabel()
  local c = 0
  local s = 0
  for item, amount in pairs(cartItems) do
    if 1 <= amount then
      c = c + amount
    else
      cartItems[item] = nil
    end
  end
  sightexports.sGui:setLabelText(cartLabel, c .. " termék")
end
addEvent("addToCartPedShop", false)
addEventHandler("addToCartPedShop", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  local ic = math.max(1, pedCategories[selectedCategory] and pedCategories[selectedCategory].maxI or 0)
  local jc = pedCategories[selectedCategory] and pedCategories[selectedCategory].maxJ or 0
  for i = 1, ic do
    if pedItems and pedItems[i] then
      for j = 1, jc do
        local item = pedItems[i][j]
        if item and el == itemElements[i][j][9] then
          if button == "right" then
            if cartItems[item] then
              cartItems[item] = (cartItems[item] or 0) - (getKeyState("lshift") and 10 or 1)
              if cartItems[item] <= 0 then
                cartItems[item] = nil
                for k = #cartItemList, 1, -1 do
                  if cartItemList[k] == item then
                    table.remove(cartItemList, k)
                  end
                end
              end
              playSound("files/barcodescan2.mp3")
            end
          else
            local curr = cartItems[item] or 0
            if (not pedStock[item] or pedStock[item] < curr + 1) and not pedDatas[openedShop].isServer then
              sightexports.sGui:showInfobox("e", "Nincs több ebből a tárgyból készleten!")
              return
            end
            if not cartItems[item] then
              table.insert(cartItemList, item)
              cartItems[item] = curr
            end
            cartItems[item] = curr + (getKeyState("lshift") and 10 or 1)
            playSound("files/barcodescan.mp3")
          end
          refreshCartLabel()
          for ie = 1, ic do
            if pedItems[ie] then
              for je = 1, jc do
                if pedItems[ie][je] == item then
                  refreshShopItem(ie, je, ic, jc)
                end
              end
            end
          end
          break
        end
      end
    end
  end
end)
function refreshShopItem(i, j, ic, jc)
  if not ic then
    if editMode then
      ic = 3
      jc = 10
    else
      ic = math.max(1, pedCategories[selectedCategory] and pedCategories[selectedCategory].maxI or 0)
      jc = pedCategories[selectedCategory] and pedCategories[selectedCategory].maxJ or 0
    end
  end
  if i > ic or j > jc then
    sightexports.sGui:setGuiRenderDisabled(itemElements[i][j][1], true)
    sightexports.sGui:setGuiRenderDisabled(itemElements[i][j][2], true, true)
  elseif not pedItems or pedItems[i] and pedItems[i][j] then
    local item = pedItems and pedItems[i][j]
    for k = 1, #itemElements[i][j] do
      if k <= 2 then
        sightexports.sGui:setGuiRenderDisabled(itemElements[i][j][k], false)
      else
        local val = 6 <= k and k <= 8
        if not pedItems then
          val = not val
        end
        if editMode then
          if k == 9 then
            val = true
          elseif k == 10 then
            val = not changedItems[i] or changedItems[i][j] == nil
          end
        elseif pedItems and 10 <= k then
          val = not cartItems[item]
        end
        sightexports.sGui:setGuiRenderDisabled(itemElements[i][j][k], val)
      end
    end
    if pedItems then
      sightexports.sGui:setImageFile(itemElements[i][j][3], ":sItems/" .. sightexports.sItems:getItemPic(item))
      sightexports.sGui:setLabelText(itemElements[i][j][4], sightexports.sItems:getItemName(item))
      if editMode or pedStock[item] and 0 < pedStock[item] or pedDatas[openedShop].isServer then
        sightexports.sGui:setLabelText(itemElements[i][j][5], sightexports.sGui:thousandsStepper(getPedPrice(pedPrice, item)) .. " $")
        sightexports.sGui:setLabelColor(itemElements[i][j][5], "sightgreen")
        sightexports.sGui:setLabelColor(itemElements[i][j][4], "#ffffff")
        sightexports.sGui:setImageColor(itemElements[i][j][3], "#ffffff")
        if not editMode then
          sightexports.sGui:setImageColor(itemElements[i][j][9], "#ffffff")
          sightexports.sGui:setGuiHoverable(itemElements[i][j][9], true)
        end
      else
        sightexports.sGui:setLabelText(itemElements[i][j][5], "Nem elérhető")
        sightexports.sGui:setLabelColor(itemElements[i][j][5], transp2)
        sightexports.sGui:setLabelColor(itemElements[i][j][4], transp)
        sightexports.sGui:setImageColor(itemElements[i][j][3], transp)
        sightexports.sGui:setImageColor(itemElements[i][j][9], transp)
        sightexports.sGui:setGuiHoverable(itemElements[i][j][9], false)
      end
      if editMode then
        sightexports.sGui:guiSetTooltip(itemElements[i][j][2], "Készlet: " .. sightexports.sGui:getColorCodeHex("sightblue") .. (pedStock[item] and pedStock[item] or 0) .. "\n#ffffffBeszerzési ár: " .. sightexports.sGui:getColorCodeHex("sightgreen") .. sightexports.sGui:thousandsStepper(getWholesalePrice(item)) .. " $\n" .. sightexports.sGui:getColorCodeHex("sightblue") .. "Bal kattintás: #fffffftárgy cseréje\n" .. sightexports.sGui:getColorCodeHex("sightblue") .. "Jobb kattintás: #fffffftárgy törlése")
      else
        sightexports.sGui:setImageFile(itemElements[i][j][9], sightexports.sGui:getFaIconFilename(cartItems[item] and "shopping-cart" or "cart-plus", 32, cartItems[item] and "solid" or "regular"))
        if cartItems[item] then
          sightexports.sGui:setLabelText(itemElements[i][j][11], cartItems[item])
        end
      end
    end
  elseif editMode then
    sightexports.sGui:guiSetTooltip(itemElements[i][j][2], sightexports.sGui:getColorCodeHex("sightblue") .. "Bal kattintás: #fffffftárgy hozzáadása")
    for k = 1, #itemElements[i][j] do
      if k == 10 then
        sightexports.sGui:setGuiRenderDisabled(itemElements[i][j][k], not changedItems[i] or changedItems[i][j] == nil)
      else
        sightexports.sGui:setGuiRenderDisabled(itemElements[i][j][k], 2 < k and k ~= 9)
      end
    end
  else
    sightexports.sGui:setGuiRenderDisabled(itemElements[i][j][1], true)
    sightexports.sGui:setGuiRenderDisabled(itemElements[i][j][2], true, true)
  end
end
function refreshShopWindow()
  if loaderOverlay then
    sightexports.sGui:deleteGuiElement(loaderOverlay)
  end
  loaderOverlay = false
  local titleBarHeight = sightexports.sGui:getTitleBarHeight()
  local sx, sy = sightexports.sGui:getGuiSize(shopWindow)
  local x, y = sightexports.sGui:getGuiPosition(shopWindow)
  x = x + sx / 2
  y = y + sy / 2
  local ic, jc
  if editMode then
    ic = 3
    jc = 10
  else
    ic = math.max(1, pedCategories[selectedCategory] and pedCategories[selectedCategory].maxI or 0)
    jc = pedCategories[selectedCategory] and pedCategories[selectedCategory].maxJ or 0
  end
  local iw = 250
  local ih = 60
  local ch = 48
  local cats = #pedCategories
  local w = catW + iw * ic + 12 + (editMode and 98 or 0)
  local h = titleBarHeight + math.max(ih * jc + 12, ch * (cats + (editMode and 1 or 0))) + (editMode and 0 or 28)
  if categoryRect then
    sightexports.sGui:setGuiSize(categoryRect, false, h - titleBarHeight - (editMode and 0 or 28))
  end
  if cartRect then
    sightexports.sGui:setGuiPosition(cartRect, false, h - 28)
    sightexports.sGui:setGuiSize(cartRect, w, false)
  end
  if cartArrow then
    sightexports.sGui:setGuiPosition(cartArrow, w - 24, false)
  end
  if editButton then
    sightexports.sGui:setGuiPosition(editButton, w - 32 - 30 - 4, false)
  end
  if warehouseButton then
    sightexports.sGui:setGuiPosition(warehouseButton, w - 32 - 68, false)
  end
  sightexports.sGui:setGuiSize(shopWindow, w, h)
  sightexports.sGui:setGuiPosition(shopWindow, math.max(0, x - w / 2), math.max(0, y - h / 2))
  if canEdit then
    sightexports.sGui:setWindowTitle(shopWindow, "16/BebasNeueRegular.otf", getShopTitle(-100))
  else
    sightexports.sGui:setWindowTitle(shopWindow, "16/BebasNeueRegular.otf", getShopTitle(-32))
  end
  refreshCategoryButtons()
  for i = 1, 3 do
    for j = 1, 10 do
      refreshShopItem(i, j, ic, jc)
    end
  end
end
addEvent("selectPedShopCategory", false)
addEventHandler("selectPedShopCategory", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  if categoryButtons[el] and pedCategories[categoryButtons[el]] then
    if unsavedChanges then
      sightexports.sGui:showInfobox("e", "Nem válthatsz kategóriát, amíg mentetlen módosítások vannak.")
      return
    end
    selectedCategory = categoryButtons[el]
    pedItems = false
    refreshShopWindow()
    triggerLatentServerEvent("requestPedShopItems", localPlayer, openedShop, pedCategories[selectedCategory].categoryId)
    createLoaderOverlay()
  end
end)
addEvent("pedShopSaveUnsaved", false)
addEventHandler("pedShopSaveUnsaved", getRootElement(), function()
  unsavedChanges = false
  sightexports.sGui:setGuiRenderDisabled(unsavedOverlay, true, true)
  local swaps = false
  if categorySwaps then
    swaps = {}
    for i = 1, #pedCategories do
      if pedCategories[i].sort ~= i and not categoryDeletes[pedCategories[i].categoryId] then
        swaps[pedCategories[i].categoryId] = i
      end
    end
  end
  triggerLatentServerEvent("pedShopSaveUnsaved", localPlayer, openedShop, pedCategories[selectedCategory].categoryId, changedItems, swaps, categoryDeletes)
  changedItems = {}
  categoryDeletes = {}
  categorySwaps = false
  refreshShopWindow()
  refreshCategoryButtons()
  createLoaderOverlay()
end)
function sortCategories(a, b)
  return a.sort < b.sort
end
addEvent("pedShopDropUnsaved", false)
addEventHandler("pedShopDropUnsaved", getRootElement(), function()
  unsavedChanges = false
  sightexports.sGui:setGuiRenderDisabled(unsavedOverlay, true, true)
  pedItems = false
  local selId = pedCategories[selectedCategory].categoryId
  table.sort(pedCategories, sortCategories)
  for i = 1, #pedCategories do
    if pedCategories[i].categoryId == selId then
      selectedCategory = i
      break
    end
  end
  changedItems = {}
  categoryDeletes = {}
  categorySwaps = false
  triggerLatentServerEvent("requestPedShopItems", localPlayer, openedShop, pedCategories[selectedCategory].categoryId)
  refreshShopWindow()
  refreshCategoryButtons()
  createLoaderOverlay()
end)
addEvent("changePedShopItem", false)
addEventHandler("changePedShopItem", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  if itemButtons[el] and pedItems then
    local i, j = unpack(itemButtons[el])
    if not pedItems[i] then
      pedItems[i] = {}
    end
    if button == "right" then
      if not pedItems[i][j] then
        return
      end
      pedItems[i][j] = false
    else
      editingItem = {i, j}
      createItemEditor()
      return
    end
    if not changedItems[i] then
      changedItems[i] = {}
    end
    changedItems[i][j] = pedItems[i][j]
    refreshShopItem(i, j)
    unsavedChanges = true
    sightexports.sGui:setGuiRenderDisabled(unsavedOverlay, false, true)
  end
end)
addEvent("movePedShopCategoryUp", false)
addEventHandler("movePedShopCategoryUp", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  el = sightexports.sGui:getGuiParent(el)
  local i = categoryButtons[el]
  if pedCategories[i] and pedCategories[i - 1] then
    if selectedCategory == i - 1 then
      selectedCategory = i
    elseif selectedCategory == i then
      selectedCategory = i - 1
    end
    categorySwaps = true
    pedCategories[i], pedCategories[i - 1] = pedCategories[i - 1], pedCategories[i]
    refreshCategoryButtons()
    unsavedChanges = true
    sightexports.sGui:setGuiRenderDisabled(unsavedOverlay, false, true)
  end
end)
addEvent("movePedShopCategoryDown", false)
addEventHandler("movePedShopCategoryDown", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  el = sightexports.sGui:getGuiParent(el)
  local i = categoryButtons[el]
  if pedCategories[i] and pedCategories[i + 1] then
    if selectedCategory == i + 1 then
      selectedCategory = i
    elseif selectedCategory == i then
      selectedCategory = i + 1
    end
    categorySwaps = true
    pedCategories[i], pedCategories[i + 1] = pedCategories[i + 1], pedCategories[i]
    refreshCategoryButtons()
    unsavedChanges = true
    sightexports.sGui:setGuiRenderDisabled(unsavedOverlay, false, true)
  end
end)
addEvent("togglePedShopCategoryDelete", false)
addEventHandler("togglePedShopCategoryDelete", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  el = sightexports.sGui:getGuiParent(el)
  local i = categoryButtons[el]
  if pedCategories[i] then
    categoryDeletes[pedCategories[i].categoryId] = not categoryDeletes[pedCategories[i].categoryId] and true or nil
    refreshCategoryButtons()
    unsavedChanges = true
    sightexports.sGui:setGuiRenderDisabled(unsavedOverlay, false, true)
  end
end)
addEvent("createNewPedShopCategory", false)
addEventHandler("createNewPedShopCategory", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  if unsavedChanges then
    sightexports.sGui:showInfobox("e", "Nem hozhatsz létre kategóriát, amíg mentetlen módosítások vannak.")
    return
  end
  createLoaderOverlay()
  triggerLatentServerEvent("createNewPedShopCategory", localPlayer, openedShop)
end)
addEvent("editPedShopCategory", false)
addEventHandler("editPedShopCategory", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  if unsavedChanges then
    sightexports.sGui:showInfobox("e", "Nem szerkeszthetsz kategóriát, amíg mentetlen módosítások vannak.")
    return
  end
  el = sightexports.sGui:getGuiParent(el)
  local i = categoryButtons[el]
  if pedCategories[i] then
    editingCategory = i
    createCategoryEditor()
  end
end)
addEvent("closePedShopEditor", false)
addEventHandler("closePedShopEditor", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  if editWindow then
    sightexports.sGui:deleteGuiElement(editWindow)
  end
  editWindow = false
  editingCategory = false
  editingItem = false
  editingItemList = false
  createShopWindow()
end)
addEvent("changeCategoryEditIcon", false)
addEventHandler("changeCategoryEditIcon", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  for i = 1, #categoryIcons do
    if editElements[2 + i] == el then
      sightexports.sGui:setImageColor(editElements[2 + i], "sightgreen")
      sightexports.sGui:setGuiHoverable(editElements[2 + i], false)
    else
      sightexports.sGui:setImageColor(editElements[2 + i], "sightlightgrey")
      sightexports.sGui:setGuiHoverable(editElements[2 + i], true)
      sightexports.sGui:setGuiHover(editElements[2 + i], "solid", "sightgreen")
    end
  end
end)
addEvent("pedShopSaveCategory", false)
addEventHandler("pedShopSaveCategory", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  local name = sightexports.sGui:getInputValue(editElements[1])
  local tooltip = sightexports.sGui:getInputValue(editElements[2])
  local icon = 1
  if not name or 1 > utf8.len(name) then
    name = nil
  end
  if not tooltip or 1 > utf8.len(tooltip) then
    tooltip = nil
  end
  for i = 1, #categoryIcons do
    if not sightexports.sGui:getGuiHoverable(editElements[2 + i]) then
      icon = i
      break
    end
  end
  if pedCategories[editingCategory].name == name and pedCategories[editingCategory].tooltip == tooltip and pedCategories[editingCategory].icon == icon then
    createShopWindow()
  else
    createShopLoadWindow()
    triggerLatentServerEvent("editPedShopCategory", localPlayer, openedShop, pedCategories[editingCategory].categoryId, name, tooltip, icon)
  end
  editingCategory = false
end)
addEvent("selectPedShopEditItem", false)
addEventHandler("selectPedShopEditItem", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  if editingItem then
    local i, j = unpack(editingItem)
    if not pedItems[i] then
      pedItems[i] = {}
    end
    local n = #predefCategoryNames
    for k = 1, 14 do
      if editingItemList[k + editScroll] and editElements[n + (k - 1) * 4 + 1] == el then
        pedItems[i][j] = editingItemList[k + editScroll]
      end
    end
    if not changedItems[i] then
      changedItems[i] = {}
    end
    changedItems[i][j] = pedItems[i][j]
    unsavedChanges = true
    createShopWindow()
  end
end)
addEvent("togglepedShopEditMode", false)
addEventHandler("togglepedShopEditMode", getRootElement(), function()
  if loaderOverlay then
    return
  end
  if editMode and unsavedChanges then
    sightexports.sGui:showInfobox("e", "Nem léphetsz ki a szerkesztő módból, amíg mentetlen módosítások vannak.")
    return
  end
  editMode = not editMode
  cartItems = {}
  cartItemList = {}
  unsavedChanges = false
  changedItems = editMode and {} or false
  categoryDeletes = editMode and {} or false
  categorySwaps = false
  createShopLoadWindow()
  triggerLatentServerEvent("requestPedShopInit", localPlayer, openedShop)
end)
addEvent("selectPedShopItemEditCategory", false)
addEventHandler("selectPedShopItemEditCategory", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  local n = #predefCategoryNames
  for i = 1, n do
    if el == editElements[i] then
      editItemCategory = i
      editScroll = 0
      editingItemList = {}
      local items = predefCategories[editItemCategory]
      for i = 1, #items do
        if allowedItems[items[i]] then
          table.insert(editingItemList, items[i])
        end
      end
      refreshItemEditor()
      return
    end
  end
end)
function refreshItemEditor()
  local n = #predefCategoryNames
  for i = 1, n do
    if editElements[i] then
      if i == editItemCategory then
        sightexports.sGui:setGuiBackground(editElements[i], "solid", "sightgrey2")
        sightexports.sGui:setGuiHoverable(editElements[i], false)
      else
        sightexports.sGui:setGuiBackground(editElements[i], "solid", "sightgrey1")
        sightexports.sGui:setGuiHoverable(editElements[i], true)
      end
    end
  end
  for i = 1, 14 do
    if editingItemList[i + editScroll] then
      sightexports.sGui:setGuiHoverable(editElements[n + (i - 1) * 4 + 1], true)
      sightexports.sGui:setGuiRenderDisabled(editElements[n + (i - 1) * 4 + 2], false)
      sightexports.sGui:setGuiRenderDisabled(editElements[n + (i - 1) * 4 + 3], false)
      sightexports.sGui:setGuiRenderDisabled(editElements[n + (i - 1) * 4 + 4], false)
      sightexports.sGui:setImageFile(editElements[n + (i - 1) * 4 + 2], ":sItems/" .. sightexports.sItems:getItemPic(editingItemList[i + editScroll]))
      sightexports.sGui:setLabelText(editElements[n + (i - 1) * 4 + 3], sightexports.sItems:getItemName(editingItemList[i + editScroll]))
      sightexports.sGui:setLabelText(editElements[n + (i - 1) * 4 + 4], sightexports.sGui:thousandsStepper(getPedPrice(pedPrice, editingItemList[i + editScroll])) .. " $")
      local w = 278 - (52 + sightexports.sGui:getLabelTextWidth(editElements[n + (i - 1) * 4 + 4]))
      sightexports.sGui:setGuiSize(editElements[n + (i - 1) * 4 + 3], w, false)
    else
      sightexports.sGui:setGuiHoverable(editElements[n + (i - 1) * 4 + 1], false)
      sightexports.sGui:setGuiRenderDisabled(editElements[n + (i - 1) * 4 + 2], true)
      sightexports.sGui:setGuiRenderDisabled(editElements[n + (i - 1) * 4 + 3], true)
      sightexports.sGui:setGuiRenderDisabled(editElements[n + (i - 1) * 4 + 4], true)
    end
  end
  local sh = 504 / math.max(1, #editingItemList - 14 + 1)
  sightexports.sGui:setGuiSize(editElements[n + 56 + 1], false, sh)
  sightexports.sGui:setGuiPosition(editElements[n + 56 + 1], false, editScroll * sh)
end
function scrollHandler(key)
  if cartElements then
    if key == "mouse_wheel_up" then
      if 0 < cartScroll then
        cartScroll = cartScroll - 1
        refreshCartItems()
      end
    elseif key == "mouse_wheel_down" and cartScroll < #cartItemList - 10 then
      cartScroll = cartScroll + 1
      refreshCartItems()
    end
  elseif wareItemList then
    if key == "mouse_wheel_up" then
      if 0 < wareScroll then
        wareScroll = wareScroll - 1
        refreshWareItems()
      end
    elseif key == "mouse_wheel_down" and wareScroll < #wareItemList - 14 then
      wareScroll = wareScroll + 1
      refreshWareItems()
    end
  elseif editingItem then
    if key == "mouse_wheel_up" then
      if 0 < editScroll then
        editScroll = editScroll - 1
        refreshItemEditor()
      end
    elseif key == "mouse_wheel_down" and editScroll < #editingItemList - 14 then
      editScroll = editScroll + 1
      refreshItemEditor()
    end
  end
end
function refreshCartItemsFull()
  local x, y = sightexports.sGui:getGuiPosition(shopWindow)
  local sx, sy = sightexports.sGui:getGuiSize(shopWindow)
  x = x + sx / 2
  y = y + sy / 2
  local titleBarHeight = sightexports.sGui:getTitleBarHeight()
  local tw = 100
  local tw2 = 50
  local sum = 0
  for i = 1, #cartItemList do
    if cartItems[cartItemList[i]] then
      local price = getPedPrice(pedPrice, cartItemList[i])
      sum = sum + price * cartItems[cartItemList[i]]
      tw = math.max(tw, sightexports.sGui:getTextWidthFont(sightexports.sItems:getItemName(cartItemList[i]), "10/Ubuntu-R.ttf"), sightexports.sGui:getTextWidthFont(sightexports.sGui:thousandsStepper(price) .. " $ / db", "10/Ubuntu-L.ttf"))
      tw2 = math.max(tw2, sightexports.sGui:getTextWidthFont(sightexports.sGui:thousandsStepper(cartItems[cartItemList[i]] * price) .. " $", "10/Ubuntu-R.ttf"))
    end
  end
  sightexports.sGui:setLabelText(cartElements[111], "Végösszeg: " .. sightexports.sGui:getColorCodeHex("sightgreen") .. sightexports.sGui:thousandsStepper(sum) .. " $")
  local w1 = 42 + tw + 24
  local w2 = 110
  local w3 = tw2 + 22
  local w4 = 32
  local w = w1 + w2 + w3 + w4 + 12 + 2
  sightexports.sGui:setGuiPosition(shopWindow, x - w / 2, false)
  sightexports.sGui:setGuiSize(shopWindow, w, false)
  sightexports.sGui:setGuiPosition(cartElements[1], w - 30 - (titleBarHeight / 2 - 15), false)
  sightexports.sGui:setGuiSize(cartElements[2], w - 12, false)
  sightexports.sGui:setGuiSize(cartElements[3], w1, false)
  sightexports.sGui:setGuiPosition(cartElements[4], w1, false)
  sightexports.sGui:setGuiSize(cartElements[4], w2, false)
  sightexports.sGui:setGuiPosition(cartElements[5], w1 + w2, false)
  sightexports.sGui:setGuiSize(cartElements[5], w3, false)
  sightexports.sGui:setGuiPosition(cartElements[6], 6 + w1 - 1, false)
  sightexports.sGui:setGuiPosition(cartElements[7], 6 + w1 + w2 - 1, false)
  sightexports.sGui:setGuiPosition(cartElements[8], 6 + w1 + w2 + w3 - 1, false)
  for i = 1, 10 do
    sightexports.sGui:setGuiSize(cartElements[8 + (i - 1) * 10 + 1], w - 12, false)
    sightexports.sGui:setGuiSize(cartElements[8 + (i - 1) * 10 + 10], w - 12, false)
    if cartItemList[i + cartScroll] and cartItems[cartItemList[i + cartScroll]] then
      sightexports.sGui:setGuiSize(cartElements[8 + (i - 1) * 10 + 8], w - 6 - 2 - 6 - w4, false)
      sightexports.sGui:setGuiSize(cartElements[8 + (i - 1) * 10 + 6], w2, false)
      sightexports.sGui:setGuiPosition(cartElements[8 + (i - 1) * 10 + 5], 6 + w1 + 7, false)
      sightexports.sGui:setGuiPosition(cartElements[8 + (i - 1) * 10 + 6], 6 + w1, false)
      sightexports.sGui:setGuiPosition(cartElements[8 + (i - 1) * 10 + 7], 6 + w1 + w2 - 24 - 7, false)
      sightexports.sGui:setGuiPosition(cartElements[8 + (i - 1) * 10 + 9], 6 + w1 + w2 + w3 + w4 / 2 - 12, false)
    end
  end
  sightexports.sGui:setGuiPosition(cartElements[109], w - 6 - 2, false)
  sightexports.sGui:setGuiSize(cartElements[111], w, false)
  sightexports.sGui:setGuiSize(cartElements[112], w - 12, false)
  refreshCartItems()
end
function refreshCartItems()
  for i = 1, 10 do
    if cartItemList[i + cartScroll] and cartItems[cartItemList[i + cartScroll]] then
      for k = 2, 9 do
        sightexports.sGui:setGuiRenderDisabled(cartElements[8 + (i - 1) * 10 + k], false)
      end
      if cartItems[cartItemList[i + cartScroll]] <= 1 then
        sightexports.sGui:setGuiRenderDisabled(cartElements[8 + (i - 1) * 10 + 5], true)
      end
      local price = getPedPrice(pedPrice, cartItemList[i + cartScroll])
      sightexports.sGui:setImageFile(cartElements[8 + (i - 1) * 10 + 2], ":sItems/" .. sightexports.sItems:getItemPic(cartItemList[i + cartScroll]))
      sightexports.sGui:setLabelText(cartElements[8 + (i - 1) * 10 + 3], sightexports.sItems:getItemName(cartItemList[i + cartScroll]))
      sightexports.sGui:setLabelText(cartElements[8 + (i - 1) * 10 + 4], sightexports.sGui:thousandsStepper(price) .. " $ / db")
      sightexports.sGui:setLabelText(cartElements[8 + (i - 1) * 10 + 6], cartItems[cartItemList[i + cartScroll]])
      sightexports.sGui:setLabelText(cartElements[8 + (i - 1) * 10 + 8], sightexports.sGui:thousandsStepper(cartItems[cartItemList[i + cartScroll]] * price) .. " $")
    else
      for k = 2, 9 do
        sightexports.sGui:setGuiRenderDisabled(cartElements[8 + (i - 1) * 10 + k], true)
      end
    end
  end
  local sh = 380 / math.max(1, #cartItemList - 10 + 1)
  sightexports.sGui:setGuiSize(cartElements[110], false, sh)
  sightexports.sGui:setGuiPosition(cartElements[110], false, sh * cartScroll)
end
addEvent("closePedShopCart", false)
addEventHandler("closePedShopCart", getRootElement(), function()
  createShopWindow()
end)
addEvent("changePedShopCartAmount", false)
addEventHandler("changePedShopCartAmount", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  for i = 1, 10 do
    if cartItemList[i + cartScroll] and cartItemList[i + cartScroll] then
      if el == cartElements[8 + (i - 1) * 10 + 5] then
        cartItems[cartItemList[i + cartScroll]] = cartItems[cartItemList[i + cartScroll]] - (getKeyState("lshift") and 10 or 1)
        if cartItems[cartItemList[i + cartScroll]] <= 0 then
          cartItems[cartItemList[i + cartScroll]] = nil
          for k = #cartItemList, 1, -1 do
            if cartItemList[k] == cartItemList[i + cartScroll] then
              table.remove(cartItemList, k)
            end
          end
        end
        refreshCartItemsFull()
        playSound("files/barcodescan2.mp3")
        return
      elseif el == cartElements[8 + (i - 1) * 10 + 7] then
        local item = cartItemList[i + cartScroll]
        local curr = cartItems[item] or 0
        if (not pedStock[item] or pedStock[item] < curr + 1) and not pedDatas[openedShop].isServer then
          sightexports.sGui:showInfobox("e", "Nincs több ebből a tárgyból készleten!")
          return
        end
        cartItems[item] = curr + (getKeyState("lshift") and 10 or 1)
        refreshCartItemsFull()
        playSound("files/barcodescan.mp3")
        return
      end
    end
  end
end)
addEvent("removeItemFromPedShopCart", false)
addEventHandler("removeItemFromPedShopCart", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  for i = 1, 10 do
    if cartItemList[i + cartScroll] and cartItemList[i + cartScroll] and el == cartElements[8 + (i - 1) * 10 + 9] then
      cartItems[cartItemList[i + cartScroll]] = nil
      for k = #cartItemList, 1, -1 do
        if cartItemList[k] == cartItemList[i + cartScroll] then
          table.remove(cartItemList, k)
        end
      end
      refreshCartItemsFull()
      playSound("files/barcodescan2.mp3")
      return
    end
  end
end)
function createCartWindow()
  cartScroll = 0
  local x, y = deleteShopWindow()
  if not scrollHandled then
    addEventHandler("onClientKey", getRootElement(), scrollHandler)
  end
  scrollHandled = true
  cartElements = {}
  local titleBarHeight = sightexports.sGui:getTitleBarHeight()
  local h = titleBarHeight + 24 + 380 + 12 + 38 + 24
  showCursor(true)
  shopWindow = sightexports.sGui:createGuiElement("window", x, y - h / 2, 0, h)
  sightexports.sGui:setWindowTitle(shopWindow, "16/BebasNeueRegular.otf", "Kosár")
  sightexports.sGui:setWindowElementMaxDistance(shopWindow, pedElements[openedShop], 3, "closePedShop")
  local btn = sightexports.sGui:createGuiElement("image", 0, titleBarHeight / 2 - 15, 30, 30, shopWindow)
  sightexports.sGui:setImageFile(btn, sightexports.sGui:getFaIconFilename("arrow-alt-left", 30))
  sightexports.sGui:setGuiHoverable(btn, true)
  sightexports.sGui:setGuiHover(btn, "solid", "sightgreen")
  sightexports.sGui:setClickEvent(btn, "closePedShopCart")
  cartElements[1] = btn
  local rect = sightexports.sGui:createGuiElement("rectangle", 6, titleBarHeight + 6, 0, 24, shopWindow)
  sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey4")
  cartElements[2] = rect
  local label = sightexports.sGui:createGuiElement("label", 0, 0, 0, 24, rect)
  sightexports.sGui:setLabelAlignment(label, "center", "center")
  sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
  sightexports.sGui:setLabelText(label, "Termék")
  cartElements[3] = label
  local label = sightexports.sGui:createGuiElement("label", 0, 0, 0, 24, rect)
  sightexports.sGui:setLabelAlignment(label, "center", "center")
  sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
  sightexports.sGui:setLabelText(label, "Menny.")
  cartElements[4] = label
  local label = sightexports.sGui:createGuiElement("label", 0, 0, 0, 24, rect)
  sightexports.sGui:setLabelAlignment(label, "center", "center")
  sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
  sightexports.sGui:setLabelText(label, "Ár")
  cartElements[5] = label
  local border = sightexports.sGui:createGuiElement("hr", 0, titleBarHeight + 6, 2, 24, shopWindow)
  cartElements[6] = border
  local border = sightexports.sGui:createGuiElement("hr", 0, titleBarHeight + 6, 2, 24, shopWindow)
  cartElements[7] = border
  local border = sightexports.sGui:createGuiElement("hr", 0, titleBarHeight + 6, 2, 24, shopWindow)
  cartElements[8] = border
  for i = 1, 10 do
    local y = titleBarHeight + 6 + 24 + (i - 1) * 38
    cartElements[8 + (i - 1) * 10 + 1] = sightexports.sGui:createGuiElement("rectangle", 6, y, 0, 38, shopWindow)
    sightexports.sGui:setGuiBackground(cartElements[8 + (i - 1) * 10 + 1], "solid", "sightgrey4")
    cartElements[8 + (i - 1) * 10 + 2] = sightexports.sGui:createGuiElement("image", 8, y + 2, 34, 34, shopWindow)
    cartElements[8 + (i - 1) * 10 + 3] = sightexports.sGui:createGuiElement("label", 40, 0, 0, 19, cartElements[8 + (i - 1) * 10 + 2])
    sightexports.sGui:setLabelAlignment(cartElements[8 + (i - 1) * 10 + 3], "left", "center")
    sightexports.sGui:setLabelFont(cartElements[8 + (i - 1) * 10 + 3], "10/Ubuntu-R.ttf")
    cartElements[8 + (i - 1) * 10 + 4] = sightexports.sGui:createGuiElement("label", 40, 19, 0, 15, cartElements[8 + (i - 1) * 10 + 2])
    sightexports.sGui:setLabelAlignment(cartElements[8 + (i - 1) * 10 + 4], "left", "center")
    sightexports.sGui:setLabelFont(cartElements[8 + (i - 1) * 10 + 4], "9/Ubuntu-R.ttf")
    sightexports.sGui:setLabelColor(cartElements[8 + (i - 1) * 10 + 4], "sightgreen")
    cartElements[8 + (i - 1) * 10 + 5] = sightexports.sGui:createGuiElement("button", 0, y + 19 - 12, 24, 24, shopWindow)
    sightexports.sGui:setGuiBackground(cartElements[8 + (i - 1) * 10 + 5], "solid", "sightgrey3")
    sightexports.sGui:setGuiHover(cartElements[8 + (i - 1) * 10 + 5], "gradient", {"sightgrey2", "sightgrey3"}, false, true)
    sightexports.sGui:setButtonFont(cartElements[8 + (i - 1) * 10 + 5], "9/BebasNeueBold.otf")
    sightexports.sGui:setButtonIcon(cartElements[8 + (i - 1) * 10 + 5], sightexports.sGui:getFaIconFilename("minus", 24))
    sightexports.sGui:setClickEvent(cartElements[8 + (i - 1) * 10 + 5], "changePedShopCartAmount")
    sightexports.sGui:guiSetTooltip(cartElements[8 + (i - 1) * 10 + 5], "Shift + kattintás: -10db")
    cartElements[8 + (i - 1) * 10 + 6] = sightexports.sGui:createGuiElement("label", 0, y, 0, 38, shopWindow)
    sightexports.sGui:setLabelAlignment(cartElements[8 + (i - 1) * 10 + 6], "center", "center")
    sightexports.sGui:setLabelFont(cartElements[8 + (i - 1) * 10 + 6], "10/Ubuntu-R.ttf")
    cartElements[8 + (i - 1) * 10 + 7] = sightexports.sGui:createGuiElement("button", 0, y + 19 - 12, 24, 24, shopWindow)
    sightexports.sGui:setGuiBackground(cartElements[8 + (i - 1) * 10 + 7], "solid", "sightgrey3")
    sightexports.sGui:setGuiHover(cartElements[8 + (i - 1) * 10 + 7], "gradient", {"sightgrey2", "sightgrey3"}, false, true)
    sightexports.sGui:setButtonFont(cartElements[8 + (i - 1) * 10 + 7], "9/BebasNeueBold.otf")
    sightexports.sGui:setButtonIcon(cartElements[8 + (i - 1) * 10 + 7], sightexports.sGui:getFaIconFilename("plus", 24))
    sightexports.sGui:setClickEvent(cartElements[8 + (i - 1) * 10 + 7], "changePedShopCartAmount")
    sightexports.sGui:guiSetTooltip(cartElements[8 + (i - 1) * 10 + 7], "Shift + kattintás: +10db")
    cartElements[8 + (i - 1) * 10 + 8] = sightexports.sGui:createGuiElement("label", 0, y, 0, 38, shopWindow)
    sightexports.sGui:setLabelAlignment(cartElements[8 + (i - 1) * 10 + 8], "right", "center")
    sightexports.sGui:setLabelFont(cartElements[8 + (i - 1) * 10 + 8], "10/Ubuntu-R.ttf")
    sightexports.sGui:setLabelColor(cartElements[8 + (i - 1) * 10 + 8], "sightgreen")
    cartElements[8 + (i - 1) * 10 + 9] = sightexports.sGui:createGuiElement("image", 0, y + 19 - 12, 24, 24, shopWindow)
    sightexports.sGui:setImageFile(cartElements[8 + (i - 1) * 10 + 9], sightexports.sGui:getFaIconFilename("times", 24))
    sightexports.sGui:setGuiHoverable(cartElements[8 + (i - 1) * 10 + 9], true)
    sightexports.sGui:setGuiHover(cartElements[8 + (i - 1) * 10 + 9], "solid", "sightred")
    sightexports.sGui:guiSetTooltip(cartElements[8 + (i - 1) * 10 + 9], "Kivétel a kosárból")
    sightexports.sGui:setClickEvent(cartElements[8 + (i - 1) * 10 + 9], "removeItemFromPedShopCart")
    cartElements[8 + (i - 1) * 10 + 10] = sightexports.sGui:createGuiElement("hr", 6, y - 1, 0, 2, shopWindow)
  end
  cartElements[109] = sightexports.sGui:createGuiElement("rectangle", 0, titleBarHeight + 24 + 6, 2, 380, shopWindow)
  sightexports.sGui:setGuiBackground(cartElements[109], "solid", "sightgrey3")
  cartElements[110] = sightexports.sGui:createGuiElement("rectangle", 0, 0, 2, 380, cartElements[109])
  sightexports.sGui:setGuiBackground(cartElements[110], "solid", "sightmidgrey")
  cartElements[111] = sightexports.sGui:createGuiElement("label", 0, h - 38 - 22 - 6, 0, 38, shopWindow)
  sightexports.sGui:setLabelAlignment(cartElements[111], "center", "center")
  sightexports.sGui:setLabelFont(cartElements[111], "10/Ubuntu-R.ttf")
  cartElements[112] = sightexports.sGui:createGuiElement("button", 6, h - 22 - 6, 0, 22, shopWindow)
  sightexports.sGui:setGuiBackground(cartElements[112], "solid", "sightgreen")
  sightexports.sGui:setGuiHover(cartElements[112], "gradient", {
    "sightgreen",
    "sightgreen-second"
  }, false, true)
  sightexports.sGui:setButtonFont(cartElements[112], "12/BebasNeueBold.otf")
  sightexports.sGui:setButtonText(cartElements[112], "Fizetés")
  sightexports.sGui:setClickEvent(cartElements[112], "purchasePedShop")
  refreshCartItemsFull()
end
addEvent("clearPedShopCart", true)
addEventHandler("clearPedShopCart", getRootElement(), function(id, keepItems)
  if id == openedShop then
    local keep = false
    for i = #cartItemList, 1, -1 do
      local item = cartItemList[i]
      if keepItems[item] then
        cartItems[item] = keepItems[item]
        keep = true
      else
        table.remove(cartItemList, i)
        cartItems[item] = nil
      end
    end
    createShopLoadWindow()
    if keep then
      triggerLatentServerEvent("requestPedShopItemsForCart", localPlayer, openedShop, cartItemList)
    end
  end
end)
local lastPurchase = 0
addEvent("purchasePedShop", false)
addEventHandler("purchasePedShop", getRootElement(), function()
  local found = false
  for i in pairs(cartItems) do
    found = true
    break
  end
  if not found then
    sightexports.sGui:showInfobox("e", "A kosár üres!")
    return
  end
  if getTickCount() - lastPurchase < 10000 then
    sightexports.sGui:showInfobox("e", "Kérlek várj!")
    return
  end
  lastPurchase = getTickCount()
  createShopLoadWindow()
  triggerLatentServerEvent("purchasePedShop", localPlayer, openedShop, cartItems)
end)
addEvent("gotPedShopItemsForCart", true)
addEventHandler("gotPedShopItemsForCart", getRootElement(), function(id, pp, ps)
  for item, v in pairs(ps) do
    pedStock[item] = v
  end
  for item, v in pairs(pp) do
    pedPrice[item] = v
  end
  createCartWindow()
end)
addEvent("openPedShopCart", false)
addEventHandler("openPedShopCart", getRootElement(), function()
  createShopLoadWindow()
  triggerLatentServerEvent("requestPedShopItemsForCart", localPlayer, openedShop, cartItemList)
end)
function createItemEditor()
  deleteShopWindow()
  if not scrollHandled then
    addEventHandler("onClientKey", getRootElement(), scrollHandler)
  end
  scrollHandled = true
  local titleBarHeight = sightexports.sGui:getTitleBarHeight()
  local w = 450
  local h = titleBarHeight + 504 + 12
  showCursor(true)
  editWindow = sightexports.sGui:createGuiElement("window", screenX / 2 - w / 2, screenY / 2 - h / 2, w, h)
  sightexports.sGui:setWindowTitle(editWindow, "16/BebasNeueRegular.otf", "Tárgy kiválasztása")
  sightexports.sGui:setWindowCloseButton(editWindow, "closePedShopEditor")
  sightexports.sGui:setWindowElementMaxDistance(editWindow, pedElements[openedShop], 3, "closePedShop")
  editElements = {}
  local rect = sightexports.sGui:createGuiElement("rectangle", 0, titleBarHeight, 160, h - titleBarHeight, editWindow)
  sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey1")
  local n = #predefCategoryNames
  local y = titleBarHeight + 6
  for i = 1, n do
    local items = predefCategories[i]
    local found = false
    for j = 1, #items do
      if allowedItems[items[j]] then
        found = true
        break
      end
    end
    if found then
      if not editItemCategory then
        editItemCategory = i
      end
      local btn = sightexports.sGui:createGuiElement("button", 0, y, 160, 24, editWindow)
      sightexports.sGui:setGuiBackground(btn, "solid", "sightgrey1")
      sightexports.sGui:setGuiHover(btn, "gradient", {"sightgrey1", "sightgrey2"}, false, true)
      sightexports.sGui:setButtonFont(btn, "12/BebasNeueBold.otf")
      sightexports.sGui:setButtonText(btn, predefCategoryNames[i])
      sightexports.sGui:setClickEvent(btn, "selectPedShopItemEditCategory")
      editElements[i] = btn
      y = y + 24
    end
  end
  editingItemList = {}
  local items = predefCategories[editItemCategory] or {}
  for i = 1, #items do
    if allowedItems[items[i]] then
      table.insert(editingItemList, items[i])
    end
  end
  for i = 1, 14 do
    editElements[n + (i - 1) * 4 + 1] = sightexports.sGui:createGuiElement("rectangle", 166, titleBarHeight + 6 + (i - 1) * 36, w - 160 - 12, 36, editWindow)
    sightexports.sGui:setGuiBackground(editElements[n + (i - 1) * 4 + 1], "solid", "sightgrey4")
    sightexports.sGui:setGuiHover(editElements[n + (i - 1) * 4 + 1], "gradient", {"sightgrey4", "sightgrey3"}, false, true)
    sightexports.sGui:setClickEvent(editElements[n + (i - 1) * 4 + 1], "selectPedShopEditItem")
    editElements[n + (i - 1) * 4 + 2] = sightexports.sGui:createGuiElement("image", 168, titleBarHeight + 6 + (i - 1) * 36 + 2, 32, 32, editWindow)
    editElements[n + (i - 1) * 4 + 3] = sightexports.sGui:createGuiElement("label", 204, titleBarHeight + 6 + (i - 1) * 36, w - 160 - 12, 36, editWindow)
    sightexports.sGui:setLabelClip(editElements[n + (i - 1) * 4 + 3], true)
    sightexports.sGui:setLabelAlignment(editElements[n + (i - 1) * 4 + 3], "left", "center")
    sightexports.sGui:setLabelFont(editElements[n + (i - 1) * 4 + 3], "10/Ubuntu-R.ttf")
    editElements[n + (i - 1) * 4 + 4] = sightexports.sGui:createGuiElement("label", 0, titleBarHeight + 6 + (i - 1) * 36, w - 6 - 2 - 6, 36, editWindow)
    sightexports.sGui:setLabelAlignment(editElements[n + (i - 1) * 4 + 4], "right", "center")
    sightexports.sGui:setLabelFont(editElements[n + (i - 1) * 4 + 4], "10/Ubuntu-L.ttf")
    sightexports.sGui:setLabelColor(editElements[n + (i - 1) * 4 + 4], "sightgreen")
    if i < 14 then
      local border = sightexports.sGui:createGuiElement("hr", 166, titleBarHeight + 6 + i * 36 - 1, w - 160 - 12, 2, editWindow)
    end
  end
  local rect = sightexports.sGui:createGuiElement("rectangle", w - 6 - 2, titleBarHeight + 6, 2, 504, editWindow)
  sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey3")
  editElements[n + 56 + 1] = sightexports.sGui:createGuiElement("rectangle", 0, 0, 2, 504, rect)
  sightexports.sGui:setGuiBackground(editElements[n + 56 + 1], "solid", "sightmidgrey")
  refreshItemEditor()
end
function refreshWareItemsWidth()
  local w = 700
  local n = #predefCategoryNames
  local tw = 0
  local tw1 = 0
  local tw2 = 0
  local tw3 = 0
  for i = 1, #wareItemList do
    local price = getPedPrice(pedPrice, wareItemList[i + wareScroll])
    local wp = getWholesalePrice(wareItemList[i + wareScroll])
    tw = math.max(tw, sightexports.sGui:getTextWidthFont(sightexports.sGui:thousandsStepper(pedStock[wareItemList[i + wareScroll]] or 0), "10/Ubuntu-R.ttf"))
    tw1 = math.max(tw1, sightexports.sGui:getTextWidthFont(sightexports.sGui:thousandsStepper(price - wp) .. " $", "10/Ubuntu-R.ttf"))
    tw2 = math.max(tw2, sightexports.sGui:getTextWidthFont(sightexports.sGui:thousandsStepper(price) .. " $", "10/Ubuntu-R.ttf"))
    tw3 = math.max(tw3, sightexports.sGui:getTextWidthFont(sightexports.sGui:thousandsStepper(wp) .. " $", "10/Ubuntu-R.ttf"))
  end
  tw = tw + 10
  tw1 = tw1 + 10
  tw2 = tw2 + 10
  tw3 = tw3 + 10
  sightexports.sGui:setGuiPosition(wareElements[n + 1], w - 6 - 2 - 6 - tw - tw1 - tw2 - tw3 / 2 - 10, false)
  sightexports.sGui:setGuiPosition(wareElements[n + 2], w - 6 - 2 - 6 - tw - tw1 - tw2 / 2 - 10, false)
  sightexports.sGui:setGuiPosition(wareElements[n + 3], w - 6 - 2 - 6 - tw - tw1 / 2 - 10, false)
  sightexports.sGui:setGuiPosition(wareElements[n + 4], w - 6 - 2 - 6 - tw / 2 - 10, false)
  n = n + 4
  for i = 1, 14 do
    sightexports.sGui:setGuiSize(wareElements[n + (i - 1) * 7 + 3], w - 6 - 2 - 6 - tw - tw1 - tw2 - tw3 - 204, false)
    sightexports.sGui:setGuiSize(wareElements[n + (i - 1) * 7 + 4], tw3, false)
    sightexports.sGui:setGuiSize(wareElements[n + (i - 1) * 7 + 5], tw2, false)
    sightexports.sGui:setGuiSize(wareElements[n + (i - 1) * 7 + 6], tw1, false)
    sightexports.sGui:setGuiSize(wareElements[n + (i - 1) * 7 + 7], tw, false)
    sightexports.sGui:setGuiPosition(wareElements[n + (i - 1) * 7 + 4], w - 6 - 2 - 6 - tw - tw1 - tw2 - tw3, false)
    sightexports.sGui:setGuiPosition(wareElements[n + (i - 1) * 7 + 5], w - 6 - 2 - 6 - tw - tw1 - tw2, false)
    sightexports.sGui:setGuiPosition(wareElements[n + (i - 1) * 7 + 6], w - 6 - 2 - 6 - tw - tw1, false)
    sightexports.sGui:setGuiPosition(wareElements[n + (i - 1) * 7 + 7], w - 6 - 2 - 6 - tw, false)
  end
end
function refreshWareItems()
  local n = #predefCategoryNames
  for i = 1, n do
    if wareElements[i] then
      if i == wareItemCategory then
        sightexports.sGui:setGuiBackground(wareElements[i], "solid", "sightgrey2")
        sightexports.sGui:setGuiHoverable(wareElements[i], false)
      else
        sightexports.sGui:setGuiBackground(wareElements[i], "solid", "sightgrey1")
        sightexports.sGui:setGuiHoverable(wareElements[i], true)
      end
    end
  end
  n = n + 4
  for i = 1, 14 do
    if wareItemList[i + wareScroll] then
      sightexports.sGui:setGuiHoverable(wareElements[n + (i - 1) * 7 + 1], true)
      sightexports.sGui:setGuiRenderDisabled(wareElements[n + (i - 1) * 7 + 2], false)
      sightexports.sGui:setGuiRenderDisabled(wareElements[n + (i - 1) * 7 + 3], false)
      sightexports.sGui:setGuiRenderDisabled(wareElements[n + (i - 1) * 7 + 4], false)
      sightexports.sGui:setGuiRenderDisabled(wareElements[n + (i - 1) * 7 + 5], false)
      sightexports.sGui:setGuiRenderDisabled(wareElements[n + (i - 1) * 7 + 6], false)
      sightexports.sGui:setGuiRenderDisabled(wareElements[n + (i - 1) * 7 + 7], false)
      local price = getPedPrice(pedPrice, wareItemList[i + wareScroll])
      local wp = getWholesalePrice(wareItemList[i + wareScroll])
      sightexports.sGui:setImageFile(wareElements[n + (i - 1) * 7 + 2], ":sItems/" .. sightexports.sItems:getItemPic(wareItemList[i + wareScroll]))
      sightexports.sGui:setLabelText(wareElements[n + (i - 1) * 7 + 3], sightexports.sItems:getItemName(wareItemList[i + wareScroll]))
      sightexports.sGui:setLabelText(wareElements[n + (i - 1) * 7 + 4], sightexports.sGui:thousandsStepper(wp) .. " $")
      sightexports.sGui:setLabelText(wareElements[n + (i - 1) * 7 + 5], sightexports.sGui:thousandsStepper(price) .. " $")
      sightexports.sGui:setLabelText(wareElements[n + (i - 1) * 7 + 6], sightexports.sGui:thousandsStepper(price - wp) .. " $")
      sightexports.sGui:setLabelText(wareElements[n + (i - 1) * 7 + 7], sightexports.sGui:thousandsStepper(pedStock[wareItemList[i + wareScroll]] or 0))
      sightexports.sGui:setLabelColor(wareElements[n + (i - 1) * 7 + 6], 0 < price - wp and "sightgreen" or "sightred")
    else
      sightexports.sGui:setGuiHoverable(wareElements[n + (i - 1) * 7 + 1], false)
      sightexports.sGui:setGuiRenderDisabled(wareElements[n + (i - 1) * 7 + 2], true)
      sightexports.sGui:setGuiRenderDisabled(wareElements[n + (i - 1) * 7 + 3], true)
      sightexports.sGui:setGuiRenderDisabled(wareElements[n + (i - 1) * 7 + 4], true)
      sightexports.sGui:setGuiRenderDisabled(wareElements[n + (i - 1) * 7 + 5], true)
      sightexports.sGui:setGuiRenderDisabled(wareElements[n + (i - 1) * 7 + 6], true)
      sightexports.sGui:setGuiRenderDisabled(wareElements[n + (i - 1) * 7 + 7], true)
    end
  end
  local sh = 504 / math.max(1, #wareItemList - 14 + 1)
  sightexports.sGui:setGuiSize(wareElements[n + 98 + 1], false, sh)
  sightexports.sGui:setGuiPosition(wareElements[n + 98 + 1], false, wareScroll * sh)
end
addEvent("selectPedShopWareItemCategory", false)
addEventHandler("selectPedShopWareItemCategory", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  local n = #predefCategoryNames
  for i = 1, n do
    if el == wareElements[i] then
      wareItemCategory = i
      wareScroll = 0
      wareItemList = {}
      local items = predefCategories[wareItemCategory]
      for i = 1, #items do
        if allowedItems[items[i]] then
          table.insert(wareItemList, items[i])
        end
      end
      refreshWareItemsWidth()
      refreshWareItems()
      return
    end
  end
end)
addEvent("gotPedShopAllWareData", true)
addEventHandler("gotPedShopAllWareData", getRootElement(), function(id, wp, pp, ps, bal)
  if id == openedShop then
    wholesalePrices = wp
    pedStock = ps
    pedPrice = pp
    pedBalance = bal
    createWareWindow()
  end
end)
addEvent("gotPedShopSingleItemWareData", true)
addEventHandler("gotPedShopSingleItemWareData", getRootElement(), function(id, item, wp, pp, ps, back)
  if id == openedShop then
    wholesalePrices[item] = wp
    pedStock[item] = ps
    pedPrice[item] = pp
    if back then
      editingWareItem = false
      createWareWindow()
    else
      editingWareItem = item
      createWareItemWindow()
    end
  end
end)
addEvent("selectPedShopWareItem", false)
addEventHandler("selectPedShopWareItem", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  local n = #predefCategoryNames
  n = n + 4
  for k = 1, 14 do
    if wareItemList[k + wareScroll] and wareElements[n + (k - 1) * 7 + 1] == el then
      triggerLatentServerEvent("requestPedShopSingleItemWareData", localPlayer, openedShop, wareItemList[k + wareScroll])
      createShopLoadWindow()
      return
    end
  end
end)
addEvent("closePedShopWareItem", false)
addEventHandler("closePedShopWareItem", getRootElement(), function()
  createWareWindow()
end)
addEvent("refreshPedShopWarePrice", false)
addEventHandler("refreshPedShopWarePrice", getRootElement(), function()
  local price = tonumber(sightexports.sGui:getInputValue(wareElements[1])) or 1
  local wp = getWholesalePrice(editingWareItem)
  local profit = price - wp
  sightexports.sGui:setLabelText(wareElements[2], (0 <= profit and "Profit" or "Veszteség") .. ": " .. sightexports.sGui:getColorCodeHex(0 < profit and "sightgreen" or "sightred") .. sightexports.sGui:thousandsStepper(math.abs(profit)) .. " $")
end)
addEvent("refreshPedShopWareOrder", false)
addEventHandler("refreshPedShopWareOrder", getRootElement(), function()
  local order = tonumber(sightexports.sGui:getInputValue(wareElements[3])) or 0
  local wp = getWholesalePrice(editingWareItem)
  sightexports.sGui:setLabelText(wareElements[4], "Fizetendő: " .. sightexports.sGui:getColorCodeHex("sightgreen") .. sightexports.sGui:thousandsStepper(wp * order) .. " $")
end)
addEvent("pedShopSaveWareItem", false)
addEventHandler("pedShopSaveWareItem", getRootElement(), function()
  local price = tonumber(sightexports.sGui:getInputValue(wareElements[1])) or 1
  local wp = getWholesalePrice(editingWareItem)
  if price < wp then
    sightexports.sGui:showInfobox("e", "A minimum ár " .. sightexports.sGui:thousandsStepper(wp) .. " $!")
    return
  end
  local max = wp * 100000
  if price > max then
    sightexports.sGui:showInfobox("e", "A maximum ár " .. sightexports.sGui:thousandsStepper(max) .. " $!")
    return
  end
  local order = tonumber(sightexports.sGui:getInputValue(wareElements[3])) or 0
  triggerLatentServerEvent("updatePedShopWareItem", localPlayer, openedShop, editingWareItem, price, order)
  editingWareItem = false
  createShopLoadWindow()
end)
addEvent("pedShopPayOut", false)
addEventHandler("pedShopPayOut", getRootElement(), function()
  if pedBalance < 1000 then
    sightexports.sGui:showInfobox(client, "e", "A minimum kifizethető összeg 1 000 $!")
    return
  end
  createShopLoadWindow()
  triggerLatentServerEvent("pedShopPayOut", localPlayer, openedShop)
end)
function createWareItemWindow()
  deleteShopWindow()
  local titleBarHeight = sightexports.sGui:getTitleBarHeight()
  local w = 300
  local h = titleBarHeight + 42 + 72 + 60 + 120
  showCursor(true)
  editWindow = sightexports.sGui:createGuiElement("window", screenX / 2 - w / 2, screenY / 2 - h / 2, w, h)
  sightexports.sGui:setWindowTitle(editWindow, "16/BebasNeueRegular.otf", "Készlet")
  sightexports.sGui:setWindowCloseButton(editWindow, "closePedShopWareItem")
  sightexports.sGui:setWindowElementMaxDistance(editWindow, pedElements[openedShop], 3, "closePedShop")
  local wp = getWholesalePrice(editingWareItem)
  local t1 = sightexports.sItems:getItemName(editingWareItem)
  local t2 = "Beszerzési ár: " .. sightexports.sGui:thousandsStepper(wp) .. " $"
  local w1 = sightexports.sGui:getTextWidthFont(t1, "10/Ubuntu-R.ttf")
  local w2 = sightexports.sGui:getTextWidthFont(t2, "9/Ubuntu-R.ttf")
  local img = sightexports.sGui:createGuiElement("image", w / 2 - (42 + math.max(w1, w2)) / 2, titleBarHeight + 6, 36, 36, editWindow)
  sightexports.sGui:setImageFile(img, ":sItems/" .. sightexports.sItems:getItemPic(editingWareItem))
  local label = sightexports.sGui:createGuiElement("label", 42, 0, 0, 20, img)
  sightexports.sGui:setLabelAlignment(label, "left", "center")
  sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
  sightexports.sGui:setLabelText(label, t1)
  local label = sightexports.sGui:createGuiElement("label", 42, 20, 0, 16, img)
  sightexports.sGui:setLabelAlignment(label, "left", "center")
  sightexports.sGui:setLabelFont(label, "9/Ubuntu-R.ttf")
  sightexports.sGui:setLabelColor(label, "sightgreen")
  sightexports.sGui:setLabelText(label, t2)
  wareElements = {}
  local y = titleBarHeight + 6 + 36 + 6
  wareElements[1] = sightexports.sGui:createGuiElement("input", 6, y, w - 12, 30, editWindow)
  sightexports.sGui:setInputPlaceholder(wareElements[1], "Eladási ár")
  sightexports.sGui:setInputFont(wareElements[1], "10/Ubuntu-R.ttf")
  sightexports.sGui:setInputIcon(wareElements[1], "dollar-sign")
  sightexports.sGui:setInputNumberOnly(wareElements[1], true)
  sightexports.sGui:setInputValue(wareElements[1], getPedPrice(pedPrice, editingWareItem))
  sightexports.sGui:setInputChangeEvent(wareElements[1], "refreshPedShopWarePrice")
  y = y + 30 + 6
  local label = sightexports.sGui:createGuiElement("label", 0, y, w, 24, editWindow)
  sightexports.sGui:setLabelAlignment(label, "center", "center")
  sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
  sightexports.sGui:setLabelText(label, "Maximum ár: " .. sightexports.sGui:getColorCodeHex("sightgreen") .. sightexports.sGui:thousandsStepper(wp * 5) .. " $")
  y = y + 24
  wareElements[2] = sightexports.sGui:createGuiElement("label", 0, y, w, 24, editWindow)
  sightexports.sGui:setLabelAlignment(wareElements[2], "center", "center")
  sightexports.sGui:setLabelFont(wareElements[2], "10/Ubuntu-R.ttf")
  local profit = getPedPrice(pedPrice, editingWareItem) - wp
  sightexports.sGui:setLabelText(wareElements[2], (0 <= profit and "Profit" or "Veszteség") .. ": " .. sightexports.sGui:getColorCodeHex(0 < profit and "sightgreen" or "sightred") .. sightexports.sGui:thousandsStepper(math.abs(profit)) .. " $")
  y = y + 24 + 6
  local border = sightexports.sGui:createGuiElement("hr", 6, y - 1, w - 12, 2, editWindow)
  y = y + 6
  local label = sightexports.sGui:createGuiElement("label", 0, y, w, 24, editWindow)
  sightexports.sGui:setLabelAlignment(label, "center", "center")
  sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
  sightexports.sGui:setLabelText(label, "Készlet:")
  y = y + 24
  local label = sightexports.sGui:createGuiElement("label", 0, y, w, 24, editWindow)
  sightexports.sGui:setLabelAlignment(label, "center", "center")
  sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
  sightexports.sGui:setLabelText(label, pedStock[editingWareItem] or 0)
  y = y + 24 + 6
  local label = sightexports.sGui:createGuiElement("label", 6, y, 0, 30, editWindow)
  sightexports.sGui:setLabelAlignment(label, "left", "center")
  sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
  sightexports.sGui:setLabelText(label, "Készlet feltöltése:")
  local tw = sightexports.sGui:getLabelTextWidth(label) + 6
  wareElements[3] = sightexports.sGui:createGuiElement("input", 6 + tw, y, w - 12 - tw, 30, editWindow)
  sightexports.sGui:setInputPlaceholder(wareElements[3], "Darab")
  sightexports.sGui:setInputFont(wareElements[3], "10/Ubuntu-R.ttf")
  sightexports.sGui:setInputIcon(wareElements[3], "boxes")
  sightexports.sGui:setInputNumberOnly(wareElements[3], true)
  sightexports.sGui:setInputChangeEvent(wareElements[3], "refreshPedShopWareOrder")
  y = y + 30
  wareElements[4] = sightexports.sGui:createGuiElement("label", 0, y, w, 30, editWindow)
  sightexports.sGui:setLabelAlignment(wareElements[4], "center", "center")
  sightexports.sGui:setLabelFont(wareElements[4], "10/Ubuntu-R.ttf")
  sightexports.sGui:setLabelText(wareElements[4], "Fizetendő: " .. sightexports.sGui:getColorCodeHex("sightgreen") .. "0 $")
  y = y + 30
  local btn = sightexports.sGui:createGuiElement("button", 6, y + 6, w - 12, 24, editWindow)
  sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
  sightexports.sGui:setGuiHover(btn, "gradient", {
    "sightgreen",
    "sightgreen-second"
  }, false, true)
  sightexports.sGui:setButtonFont(btn, "12/BebasNeueBold.otf")
  sightexports.sGui:setButtonText(btn, "Tárgy mentése")
  sightexports.sGui:setClickEvent(btn, "pedShopSaveWareItem")
end
function createWareWindow()
  deleteShopWindow()
  if not scrollHandled then
    addEventHandler("onClientKey", getRootElement(), scrollHandler)
  end
  scrollHandled = true
  local titleBarHeight = sightexports.sGui:getTitleBarHeight()
  local w = 700
  local h = titleBarHeight + 24 + 504 + 12 + 24
  showCursor(true)
  editWindow = sightexports.sGui:createGuiElement("window", screenX / 2 - w / 2, screenY / 2 - h / 2, w, h)
  sightexports.sGui:setWindowTitle(editWindow, "16/BebasNeueRegular.otf", "Készlet")
  sightexports.sGui:setWindowCloseButton(editWindow, "closePedShopEditor")
  sightexports.sGui:setWindowElementMaxDistance(editWindow, pedElements[openedShop], 3, "closePedShop")
  local rect = sightexports.sGui:createGuiElement("rectangle", 0, h - 24, w, 24, editWindow)
  sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey4")
  local btn = sightexports.sGui:createGuiElement("button", w - 202, 2, 200, 20, rect)
  sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
  sightexports.sGui:setGuiHover(btn, "gradient", {
    "sightgreen",
    "sightgreen-second"
  }, false, true)
  sightexports.sGui:setButtonFont(btn, "12/BebasNeueBold.otf")
  sightexports.sGui:setButtonText(btn, "Egyenleg kifizetése")
  if 1000 <= pedBalance then
    sightexports.sGui:guiSetTooltip(btn, "Nyereségadó: " .. sightexports.sGui:getColorCodeHex("sightred") .. sightexports.sGui:thousandsStepper(math.floor(pedBalance * payoutTax)) .. " $")
  else
    sightexports.sGui:guiSetTooltip(btn, "Minimum kifizethető összeg: " .. sightexports.sGui:getColorCodeHex("sightgreen") .. "1 000 $")
  end
  sightexports.sGui:setClickEvent(btn, "pedShopPayOut")
  local label = sightexports.sGui:createGuiElement("label", 2, 0, 0, 24, rect)
  sightexports.sGui:setLabelAlignment(label, "left", "center")
  sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
  sightexports.sGui:setLabelText(label, "Egyenleg: " .. sightexports.sGui:getColorCodeHex("sightgreen") .. sightexports.sGui:thousandsStepper(pedBalance) .. " $")
  wareElements = {}
  local rect = sightexports.sGui:createGuiElement("rectangle", 0, titleBarHeight, 160, h - titleBarHeight - 24, editWindow)
  sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey1")
  local n = #predefCategoryNames
  local y = titleBarHeight + 6
  for i = 1, n do
    local items = predefCategories[i]
    local found = false
    for j = 1, #items do
      if allowedItems[items[j]] then
        found = true
        break
      end
    end
    if found then
      if not wareItemCategory then
        wareItemCategory = i
      end
      local btn = sightexports.sGui:createGuiElement("button", 0, y, 160, 24, editWindow)
      sightexports.sGui:setGuiBackground(btn, "solid", "sightgrey1")
      sightexports.sGui:setGuiHover(btn, "gradient", {"sightgrey1", "sightgrey2"}, false, true)
      sightexports.sGui:setButtonFont(btn, "12/BebasNeueBold.otf")
      sightexports.sGui:setButtonText(btn, predefCategoryNames[i])
      sightexports.sGui:setClickEvent(btn, "selectPedShopWareItemCategory")
      wareElements[i] = btn
      y = y + 24
    end
  end
  wareItemList = {}
  local items = predefCategories[wareItemCategory]
  for i = 1, #items do
    if allowedItems[items[i]] then
      table.insert(wareItemList, items[i])
    end
  end
  local label = sightexports.sGui:createGuiElement("label", 168, titleBarHeight, 0, 30, editWindow)
  sightexports.sGui:setLabelAlignment(label, "left", "center")
  sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
  sightexports.sGui:setLabelText(label, "Termék")
  wareElements[n + 1] = sightexports.sGui:createGuiElement("image", 0, titleBarHeight + 15 - 10, 20, 20, editWindow)
  sightexports.sGui:setImageFile(wareElements[n + 1], sightexports.sGui:getFaIconFilename("tag", 20))
  sightexports.sGui:setGuiHoverable(wareElements[n + 1], true)
  sightexports.sGui:setGuiHover(wareElements[n + 1], "solid", "sightgreen-second")
  sightexports.sGui:guiSetTooltip(wareElements[n + 1], "Beszerzési ár")
  wareElements[n + 2] = sightexports.sGui:createGuiElement("image", 0, titleBarHeight + 15 - 10, 20, 20, editWindow)
  sightexports.sGui:setImageFile(wareElements[n + 2], sightexports.sGui:getFaIconFilename("tags", 20))
  sightexports.sGui:setGuiHoverable(wareElements[n + 2], true)
  sightexports.sGui:setGuiHover(wareElements[n + 2], "solid", "sightgreen")
  sightexports.sGui:guiSetTooltip(wareElements[n + 2], "Eladási ár")
  wareElements[n + 3] = sightexports.sGui:createGuiElement("image", 0, titleBarHeight + 15 - 10, 20, 20, editWindow)
  sightexports.sGui:setImageFile(wareElements[n + 3], sightexports.sGui:getFaIconFilename("dollar-sign", 20))
  sightexports.sGui:setGuiHoverable(wareElements[n + 3], true)
  sightexports.sGui:setGuiHover(wareElements[n + 3], "solid", "sightgreen")
  sightexports.sGui:guiSetTooltip(wareElements[n + 3], "Árrés")
  wareElements[n + 4] = sightexports.sGui:createGuiElement("image", 0, titleBarHeight + 15 - 10, 20, 20, editWindow)
  sightexports.sGui:setImageFile(wareElements[n + 4], sightexports.sGui:getFaIconFilename("boxes", 20))
  sightexports.sGui:setGuiHoverable(wareElements[n + 4], true)
  sightexports.sGui:setGuiHover(wareElements[n + 4], "solid", "sightblue")
  sightexports.sGui:guiSetTooltip(wareElements[n + 4], "Készlet")
  n = n + 4
  for i = 1, 14 do
    local y = titleBarHeight + 6 + (i - 1) * 36 + 24
    wareElements[n + (i - 1) * 7 + 1] = sightexports.sGui:createGuiElement("rectangle", 166, y, w - 160 - 12, 36, editWindow)
    sightexports.sGui:setGuiBackground(wareElements[n + (i - 1) * 7 + 1], "solid", "sightgrey4")
    sightexports.sGui:setGuiHover(wareElements[n + (i - 1) * 7 + 1], "gradient", {"sightgrey4", "sightgrey3"}, false, true)
    sightexports.sGui:setClickEvent(wareElements[n + (i - 1) * 7 + 1], "selectPedShopWareItem")
    wareElements[n + (i - 1) * 7 + 2] = sightexports.sGui:createGuiElement("image", 168, y + 2, 32, 32, editWindow)
    wareElements[n + (i - 1) * 7 + 3] = sightexports.sGui:createGuiElement("label", 204, y, w - 160 - 12, 36, editWindow)
    sightexports.sGui:setLabelClip(wareElements[n + (i - 1) * 7 + 3], true)
    sightexports.sGui:setLabelAlignment(wareElements[n + (i - 1) * 7 + 3], "left", "center")
    sightexports.sGui:setLabelFont(wareElements[n + (i - 1) * 7 + 3], "10/Ubuntu-R.ttf")
    wareElements[n + (i - 1) * 7 + 4] = sightexports.sGui:createGuiElement("label", 0, y, 0, 36, editWindow)
    sightexports.sGui:setLabelAlignment(wareElements[n + (i - 1) * 7 + 4], "center", "center")
    sightexports.sGui:setLabelFont(wareElements[n + (i - 1) * 7 + 4], "10/Ubuntu-R.ttf")
    sightexports.sGui:setLabelColor(wareElements[n + (i - 1) * 7 + 4], "sightgreen-second")
    wareElements[n + (i - 1) * 7 + 5] = sightexports.sGui:createGuiElement("label", 0, y, 0, 36, editWindow)
    sightexports.sGui:setLabelAlignment(wareElements[n + (i - 1) * 7 + 5], "center", "center")
    sightexports.sGui:setLabelFont(wareElements[n + (i - 1) * 7 + 5], "10/Ubuntu-R.ttf")
    sightexports.sGui:setLabelColor(wareElements[n + (i - 1) * 7 + 5], "sightgreen")
    wareElements[n + (i - 1) * 7 + 6] = sightexports.sGui:createGuiElement("label", 0, y, 0, 36, editWindow)
    sightexports.sGui:setLabelAlignment(wareElements[n + (i - 1) * 7 + 6], "center", "center")
    sightexports.sGui:setLabelFont(wareElements[n + (i - 1) * 7 + 6], "10/Ubuntu-R.ttf")
    wareElements[n + (i - 1) * 7 + 7] = sightexports.sGui:createGuiElement("label", 0, y, 0, 36, editWindow)
    sightexports.sGui:setLabelAlignment(wareElements[n + (i - 1) * 7 + 7], "center", "center")
    sightexports.sGui:setLabelFont(wareElements[n + (i - 1) * 7 + 7], "10/Ubuntu-R.ttf")
    if i < 14 then
      local border = sightexports.sGui:createGuiElement("hr", 166, y + 36 - 1, w - 160 - 12, 2, editWindow)
    end
  end
  local rect = sightexports.sGui:createGuiElement("rectangle", w - 6 - 2, titleBarHeight + 6 + 24, 2, 504, editWindow)
  sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey3")
  wareElements[n + 98 + 1] = sightexports.sGui:createGuiElement("rectangle", 0, 0, 2, 504, rect)
  sightexports.sGui:setGuiBackground(wareElements[n + 98 + 1], "solid", "sightmidgrey")
  refreshWareItemsWidth()
  refreshWareItems()
end
addEvent("createPedShopWarehouse", false)
addEventHandler("createPedShopWarehouse", getRootElement(), function()
  if loaderOverlay then
    return
  end
  createShopLoadWindow()
  triggerLatentServerEvent("requestPedShopAllWareData", localPlayer, openedShop)
end)
function createCategoryEditor()
  deleteShopWindow()
  local titleBarHeight = sightexports.sGui:getTitleBarHeight()
  local w = 400
  local is = (w - 12) / 12
  local h = titleBarHeight + 6 + 72 + math.ceil(#categoryIcons / 12) * is + 6 + 24 + 6
  showCursor(true)
  editWindow = sightexports.sGui:createGuiElement("window", screenX / 2 - w / 2, screenY / 2 - h / 2, w, h)
  sightexports.sGui:setWindowTitle(editWindow, "16/BebasNeueRegular.otf", "Kategória szerkesztése")
  sightexports.sGui:setWindowCloseButton(editWindow, "closePedShopEditor")
  sightexports.sGui:setWindowElementMaxDistance(editWindow, pedElements[openedShop], 3, "closePedShop")
  editElements = {}
  editElements[1] = sightexports.sGui:createGuiElement("input", 6, titleBarHeight + 6, w - 12, 30, editWindow)
  sightexports.sGui:setInputPlaceholder(editElements[1], "Kategória neve")
  sightexports.sGui:setInputFont(editElements[1], "10/Ubuntu-R.ttf")
  sightexports.sGui:setInputIcon(editElements[1], "tag")
  sightexports.sGui:setInputMaxLength(editElements[1], 24)
  sightexports.sGui:setInputValue(editElements[1], pedCategories[editingCategory].name or "")
  editElements[2] = sightexports.sGui:createGuiElement("input", 6, titleBarHeight + 6 + 30 + 6, w - 12, 30, editWindow)
  sightexports.sGui:setInputPlaceholder(editElements[2], "Kategória tooltip")
  sightexports.sGui:setInputFont(editElements[2], "10/Ubuntu-R.ttf")
  sightexports.sGui:setInputIcon(editElements[2], "comment-alt-dots")
  sightexports.sGui:setInputMaxLength(editElements[2], 80)
  sightexports.sGui:setInputValue(editElements[2], pedCategories[editingCategory].tooltip or "")
  local y = titleBarHeight + 6 + 72
  for i = 1, #categoryIcons do
    editElements[2 + i] = sightexports.sGui:createGuiElement("image", 6 + (i - 1) % 12 * is, y, is, is, editWindow)
    sightexports.sGui:setImageFile(editElements[2 + i], categoryIcons[i])
    sightexports.sGui:setClickEvent(editElements[2 + i], "changeCategoryEditIcon")
    if i == (pedCategories[editingCategory].icon or 1) then
      sightexports.sGui:setImageColor(editElements[2 + i], "sightgreen")
    else
      sightexports.sGui:setImageColor(editElements[2 + i], "sightlightgrey")
      sightexports.sGui:setGuiHoverable(editElements[2 + i], true)
      sightexports.sGui:setGuiHover(editElements[2 + i], "solid", "sightgreen")
    end
    if i % 12 == 0 then
      y = y + is
    end
  end
  local btn = sightexports.sGui:createGuiElement("button", 6, y + 6, w - 12, 24, editWindow)
  sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
  sightexports.sGui:setGuiHover(btn, "gradient", {
    "sightgreen",
    "sightgreen-second"
  }, false, true)
  sightexports.sGui:setButtonFont(btn, "12/BebasNeueBold.otf")
  sightexports.sGui:setButtonText(btn, "Kategória mentése")
  sightexports.sGui:setClickEvent(btn, "pedShopSaveCategory")
end
function refreshCategoryButtons()
  for btn, i in pairs(categoryButtons) do
    if pedCategories[i] then
      if pedCategories[i].name then
        sightexports.sGui:setButtonText(btn, " " .. pedCategories[i].name)
      else
        sightexports.sGui:setButtonText(btn, nil)
      end
      sightexports.sGui:setButtonIcon(btn, categoryIcons[pedCategories[i].icon] or categoryIcons[1])
      sightexports.sGui:guiSetTooltip(btn, pedCategories[i].tooltip)
      if editMode then
        if i == selectedCategory then
          sightexports.sGui:setButtonTextColor(btn, "#ffffff")
          sightexports.sGui:setButtonIconColor(btn, "#ffffff")
          sightexports.sGui:setGuiBackground(btn, "solid", categoryDeletes[pedCategories[i].categoryId] and "sightred" or categorySwaps and "sightorange" or "sightgreen")
          sightexports.sGui:setGuiHover(btn, "none", false, false, true)
          sightexports.sGui:setClickEvent(btn, false)
        else
          sightexports.sGui:setButtonTextColor(btn, categoryDeletes[pedCategories[i].categoryId] and "sightred" or categorySwaps and "sightorange" or "#ffffff")
          sightexports.sGui:setButtonIconColor(btn, categoryDeletes[pedCategories[i].categoryId] and "sightred" or categorySwaps and "sightorange" or "#ffffff")
          sightexports.sGui:setGuiBackground(btn, "solid", "sightgrey1")
          sightexports.sGui:setGuiHover(btn, "gradient", {"sightgrey1", "sightgrey2"}, false, true)
          sightexports.sGui:setClickEvent(btn, "selectPedShopCategory")
        end
      elseif i == selectedCategory then
        sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
        sightexports.sGui:setGuiHover(btn, "none", false, false, true)
        sightexports.sGui:setClickEvent(btn, false)
      else
        sightexports.sGui:setGuiBackground(btn, "solid", "sightgrey1")
        sightexports.sGui:setGuiHover(btn, "gradient", {"sightgrey1", "sightgrey2"}, false, true)
        sightexports.sGui:setClickEvent(btn, "selectPedShopCategory")
      end
    end
  end
end
function getShopTitle(x)
  local titleBarHeight = sightexports.sGui:getTitleBarHeight()
  local height = sightexports.sGui:getFontHeight("16/BebasNeueRegular.otf")
  local fontPadding = math.floor((titleBarHeight - height) / 2)
  local text = pedDatas[openedShop].name and utf8.gsub(pedDatas[openedShop].name, "_", " ") .. " (Bolt)" or "Bolt"
  local w = sightexports.sGui:getTextWidthFont(text, "16/BebasNeueRegular.otf") + fontPadding
  local sx = sightexports.sGui:getGuiSize(shopWindow)
  if w > sx + x then
    return "Bolt"
  else
    return text
  end
end
function createShopWindow()
  local x, y = deleteShopWindow()
  local titleBarHeight = sightexports.sGui:getTitleBarHeight()
  local ic, jc
  if editMode then
    ic = 3
    jc = 10
  else
    ic = math.max(1, pedCategories[selectedCategory] and pedCategories[selectedCategory].maxI or 0)
    jc = pedCategories[selectedCategory] and pedCategories[selectedCategory].maxJ or 0
  end
  local ch = 48
  local fh = sightexports.sGui:getFontHeight("14/BebasNeueBold.otf")
  catW = editMode and fh + (ch - fh) + 12 or 0
  local cats = #pedCategories
  if 1 < cats or editMode then
    for i = 1, #pedCategories do
      local tw = pedCategories[i].name and sightexports.sGui:getTextWidthFont(" " .. pedCategories[i].name, "14/BebasNeueBold.otf") or 0
      catW = math.max(catW, fh + tw + (ch - fh) + 12)
    end
  end
  local iw = 250
  local ih = 60
  local w = catW + iw * ic + 12 + (editMode and 98 or 0)
  local h = titleBarHeight + math.max(ih * jc + 12, ch * (cats + (editMode and 1 or 0))) + (editMode and 0 or 28)
  showCursor(true)
  shopWindow = sightexports.sGui:createGuiElement("window", math.max(0, x - w / 2), math.max(0, y - h / 2), w, h)
  sightexports.sGui:setWindowCloseButton(shopWindow, "closePedShop")
  sightexports.sGui:setWindowElementMaxDistance(shopWindow, pedElements[openedShop], 3, "closePedShop")
  if canEdit then
    editButton = sightexports.sGui:createGuiElement("image", w - 32 - 30 - 4, titleBarHeight / 2 - 15, 30, 30, shopWindow)
    sightexports.sGui:setImageFile(editButton, sightexports.sGui:getFaIconFilename("pen", 30, "solid"))
    sightexports.sGui:setGuiHoverable(editButton, true)
    sightexports.sGui:setGuiHover(editButton, "solid", "sightgreen")
    sightexports.sGui:setClickEvent(editButton, "togglepedShopEditMode")
    warehouseButton = sightexports.sGui:createGuiElement("image", w - 32 - 68, titleBarHeight / 2 - 15, 30, 30, shopWindow)
    sightexports.sGui:setImageFile(warehouseButton, sightexports.sGui:getFaIconFilename("warehouse-alt", 30, "solid"))
    sightexports.sGui:setGuiHoverable(warehouseButton, true)
    sightexports.sGui:setGuiHover(warehouseButton, "solid", "sightgreen")
    sightexports.sGui:setClickEvent(warehouseButton, "createPedShopWarehouse")
    sightexports.sGui:setWindowTitle(shopWindow, "16/BebasNeueRegular.otf", getShopTitle(-100))
  else
    sightexports.sGui:setWindowTitle(shopWindow, "16/BebasNeueRegular.otf", getShopTitle(-32))
  end
  if editMode then
    unsavedOverlay = sightexports.sGui:createGuiElement("rectangle", 0, h, w, 24, shopWindow)
    sightexports.sGui:setGuiBackground(unsavedOverlay, "solid", "sightgrey4")
    local btn = sightexports.sGui:createGuiElement("button", w - 202, 2, 200, 20, unsavedOverlay)
    sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
    sightexports.sGui:setGuiHover(btn, "gradient", {
      "sightgreen",
      "sightgreen-second"
    }, false, true)
    sightexports.sGui:setButtonFont(btn, "12/BebasNeueBold.otf")
    sightexports.sGui:setButtonText(btn, "Változtatások mentése")
    sightexports.sGui:setClickEvent(btn, "pedShopSaveUnsaved")
    local btn = sightexports.sGui:createGuiElement("button", w - 404, 2, 200, 20, unsavedOverlay)
    sightexports.sGui:setGuiBackground(btn, "solid", "sightred")
    sightexports.sGui:setGuiHover(btn, "gradient", {
      "sightred",
      "sightred-second"
    }, false, true)
    sightexports.sGui:setButtonFont(btn, "12/BebasNeueBold.otf")
    sightexports.sGui:setButtonText(btn, "Változtatások elvetése")
    sightexports.sGui:setClickEvent(btn, "pedShopDropUnsaved")
    local label = sightexports.sGui:createGuiElement("label", 2, 0, 0, 24, unsavedOverlay)
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
    sightexports.sGui:setLabelColor(label, "sightorange")
    sightexports.sGui:setLabelText(label, "Mentetlen változtatások!")
    if not unsavedChanges then
      sightexports.sGui:setGuiRenderDisabled(unsavedOverlay, true, true)
    end
  else
    cartRect = sightexports.sGui:createGuiElement("rectangle", 0, h - 28, w, 28, shopWindow)
    sightexports.sGui:setGuiBackground(cartRect, "solid", "sightgrey4")
    sightexports.sGui:setGuiHover(cartRect, "gradient", {"sightgrey4", "sightgrey3"}, false, true)
    sightexports.sGui:setGuiHoverable(cartRect, true)
    sightexports.sGui:setClickEvent(cartRect, "openPedShopCart")
    cartArrow = sightexports.sGui:createGuiElement("image", w - 24, 2, 24, 24, cartRect)
    sightexports.sGui:setImageFile(cartArrow, sightexports.sGui:getFaIconFilename("angle-right", 24, "solid"))
    local label = sightexports.sGui:createGuiElement("label", 0, 0, 0, 24, cartArrow)
    sightexports.sGui:setLabelAlignment(label, "right", "center")
    sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
    sightexports.sGui:setLabelText(label, "Tovább a fizetéshez")
    local img = sightexports.sGui:createGuiElement("image", 4, 4, 20, 20, cartRect)
    sightexports.sGui:setImageFile(img, sightexports.sGui:getFaIconFilename("shopping-cart", 20, "solid"))
    cartLabel = sightexports.sGui:createGuiElement("label", 28, 0, 0, 28, cartRect)
    sightexports.sGui:setLabelAlignment(cartLabel, "left", "center")
    sightexports.sGui:setLabelFont(cartLabel, "10/Ubuntu-R.ttf")
    refreshCartLabel()
  end
  if 1 < cats or editMode then
    categoryRect = sightexports.sGui:createGuiElement("rectangle", editMode and 98 or 0, titleBarHeight, catW, 0, shopWindow)
    sightexports.sGui:setGuiBackground(categoryRect, "solid", "sightgrey1")
    for i = 1, cats do
      local btn = sightexports.sGui:createGuiElement("button", 0, (i - 1) * ch, catW, ch, categoryRect)
      sightexports.sGui:setButtonFont(btn, "14/BebasNeueBold.otf")
      sightexports.sGui:setClickEvent(btn, "selectPedShopCategory")
      if editMode then
        local img = sightexports.sGui:createGuiElement("image", -36, ch / 2 - 16, 32, 32, btn)
        sightexports.sGui:setImageFile(img, sightexports.sGui:getFaIconFilename("pen", 32, "regular"))
        sightexports.sGui:setGuiHoverable(img, true)
        sightexports.sGui:setGuiHover(img, "solid", "sightgreen")
        sightexports.sGui:setClickEvent(img, "editPedShopCategory")
        sightexports.sGui:guiSetTooltip(img, "Kategória szerkesztése")
        if 1 < cats then
          if 1 < i then
            local img = sightexports.sGui:createGuiElement("image", -36 - (ch / 2 - 6) - 4, 6, ch / 2 - 6, ch / 2 - 6, btn)
            sightexports.sGui:setImageFile(img, sightexports.sGui:getFaIconFilename("arrow-alt-up", ch / 2))
            sightexports.sGui:setGuiHoverable(img, true)
            sightexports.sGui:setGuiHover(img, "solid", "sightgreen")
            sightexports.sGui:setClickEvent(img, "movePedShopCategoryUp")
            sightexports.sGui:guiSetTooltip(img, "Kategória mozgatása")
          end
          if cats > i then
            local img = sightexports.sGui:createGuiElement("image", -36 - (ch / 2 - 6) - 4, ch / 2, ch / 2 - 6, ch / 2 - 6, btn)
            sightexports.sGui:setImageFile(img, sightexports.sGui:getFaIconFilename("arrow-alt-down", ch / 2))
            sightexports.sGui:setGuiHoverable(img, true)
            sightexports.sGui:setGuiHover(img, "solid", "sightgreen")
            sightexports.sGui:setClickEvent(img, "movePedShopCategoryDown")
            sightexports.sGui:guiSetTooltip(img, "Kategória mozgatása")
          end
          local img = sightexports.sGui:createGuiElement("image", -36 - (ch / 2 - 6) - 4 - 36, ch / 2 - 16, 32, 32, btn)
          sightexports.sGui:setImageFile(img, sightexports.sGui:getFaIconFilename("trash-alt", 32, "regular"))
          sightexports.sGui:setGuiHoverable(img, true)
          sightexports.sGui:setGuiHover(img, "solid", "sightred")
          sightexports.sGui:setClickEvent(img, "togglePedShopCategoryDelete")
          sightexports.sGui:guiSetTooltip(img, "Kategória törlése")
        end
      end
      categoryButtons[btn] = i
    end
    refreshCategoryButtons()
    if editMode and cats < 10 then
      local btn = sightexports.sGui:createGuiElement("button", 0, cats * ch, catW, ch, categoryRect)
      sightexports.sGui:setGuiBackground(btn, "solid", "sightgrey3")
      sightexports.sGui:setGuiHover(btn, "gradient", {"sightgrey2", "sightgrey3"}, false, true)
      sightexports.sGui:setButtonFont(btn, "14/BebasNeueBold.otf")
      sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("plus", 32))
      sightexports.sGui:guiSetTooltip(btn, "Új kategória létrehozása")
      sightexports.sGui:setClickEvent(btn, "createNewPedShopCategory")
    end
  end
  local x = (editMode and 98 or 0) + catW + 6
  local lw = iw - 12 - ((ih - 12) / 2 + 18 + 6) - 32 - 12
  for i = 1, 3 do
    itemElements[i] = {}
    local y = titleBarHeight + 6
    for j = 1, 10 do
      itemElements[i][j] = {}
      local rect = sightexports.sGui:createGuiElement("rectangle", x + 6 + 2, y + 6 + 2, iw - 12, ih - 12, shopWindow)
      sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey1")
      itemElements[i][j][1] = rect
      local rect = sightexports.sGui:createGuiElement("rectangle", x + 6, y + 6, iw - 12, ih - 12, shopWindow)
      sightexports.sGui:setGuiBackground(rect, "gradient", {"sightgrey4", "sightgrey2"})
      itemElements[i][j][2] = rect
      if editMode then
        sightexports.sGui:setGuiBackground(rect, "gradient", {"sightgrey4", "sightgrey2"})
        sightexports.sGui:setGuiHover(rect, "gradient", {"sightgrey2", "sightgrey3"}, false, true)
        sightexports.sGui:setGuiHoverable(rect, true)
        sightexports.sGui:setClickEvent(rect, "changePedShopItem")
        sightexports.sGui:guiSetTooltip(rect, sightexports.sGui:getColorCodeHex("sightblue") .. "Bal kattintás: #fffffftárgy cseréje\n" .. sightexports.sGui:getColorCodeHex("sightblue") .. "Jobb kattintás: #fffffftárgy törlése")
        itemButtons[rect] = {i, j}
      end
      local img = sightexports.sGui:createGuiElement("image", (ih - 12) / 2 - 18, (ih - 12) / 2 - 18, 36, 36, rect)
      itemElements[i][j][3] = img
      local label = sightexports.sGui:createGuiElement("label", 42, 0, lw, 18, img)
      sightexports.sGui:setLabelAlignment(label, "left", "center")
      sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
      sightexports.sGui:setLabelClip(label, true)
      itemElements[i][j][4] = label
      local label = sightexports.sGui:createGuiElement("label", 42, 18, 0, 18, img)
      sightexports.sGui:setLabelAlignment(label, "left", "center")
      sightexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
      sightexports.sGui:setLabelColor(label, "sightgreen")
      itemElements[i][j][5] = label
      local img = sightexports.sGui:createGuiElement("rectangle", (ih - 12) / 2 - 18, (ih - 12) / 2 - 18, 36, 36, rect)
      sightexports.sGui:setGuiBackground(img, "gradient", {"sightgrey3", "sightmidgrey"})
      itemElements[i][j][6] = img
      local label = sightexports.sGui:createGuiElement("rectangle", 42, 0, lw, 16, img)
      sightexports.sGui:setGuiBackground(label, "gradient", {"sightmidgrey", "sightgrey3"})
      itemElements[i][j][7] = label
      local label = sightexports.sGui:createGuiElement("rectangle", 42, 20, lw / 2, 16, img)
      sightexports.sGui:setGuiBackground(label, "gradient", {
        "sightgreen",
        "sightgreen-second"
      })
      itemElements[i][j][8] = label
      if editMode then
        local img = sightexports.sGui:createGuiElement("image", (iw - 12) / 2 - 16, (ih - 12) / 2 - 16, 32, 32, rect)
        sightexports.sGui:setImageFile(img, sightexports.sGui:getFaIconFilename("plus", 32))
        itemElements[i][j][9] = img
        local img = sightexports.sGui:createGuiElement("image", iw - 12 - 32 - 6, (ih - 12) / 2 - 16, 32, 32, rect)
        sightexports.sGui:setImageFile(img, sightexports.sGui:getFaIconFilename("exchange", 32))
        sightexports.sGui:setImageColor(img, "sightorange")
        itemElements[i][j][10] = img
      else
        local img = sightexports.sGui:createGuiElement("image", iw - 12 - 32 - 6, (ih - 12) / 2 - 16, 32, 32, rect)
        sightexports.sGui:setGuiHoverable(img, true)
        sightexports.sGui:setGuiHover(img, "solid", "sightgreen")
        sightexports.sGui:setClickEvent(img, "addToCartPedShop")
        sightexports.sGui:guiSetTooltip(img, "Bal kattintás: +1db\nJobb kattintás: -1db\nShift lenyomva tartva: 10db")
        itemElements[i][j][9] = img
        itemButtons[img] = {i, j}
        local img = sightexports.sGui:createGuiElement("image", 12, 14, 25, 25, img)
        sightexports.sGui:setImageFile(img, sightexports.sGui:getFaIconFilename("circle", 25))
        sightexports.sGui:setImageColor(img, "sightblue")
        itemElements[i][j][10] = img
        local label = sightexports.sGui:createGuiElement("label", 0, -1, 25, 25, img)
        sightexports.sGui:setLabelAlignment(label, "center", "center")
        sightexports.sGui:setLabelFont(label, "10/BebasNeueBold.otf")
        sightexports.sGui:setLabelText(label, "6")
        itemElements[i][j][11] = label
      end
      y = y + ih
    end
    x = x + iw
  end
  refreshShopWindow()
end
