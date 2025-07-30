local sightexports = {
  sMarkers = false,
  sMobile = false,
  sItems = false,
  sGui = false,
  sInteriors = false,
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
local sightlangCondHandlState0 = false
local function sightlangCondHandl0(cond, prio)
    cond = cond and true or false
  if cond ~= sightlangCondHandlState0 then
    sightlangCondHandlState0 = cond
    if cond then
      addEventHandler("onClientPreRender", getRootElement(), processDeliveryLocks, true, prio)
    else
      removeEventHandler("onClientPreRender", getRootElement(), processDeliveryLocks)
    end
  end
end
local r4_0 = false
local r5_0 = false
local r6_0 = false
local r7_0 = false
local r8_0 = false
function getAppState()
  if r4_0 then
    return false, r4_0
  elseif r6_0 then
    return false
  else
    return true
  end
end
function getAdvertisementNum()
  if r6_0 then
    return #r6_0
  else
    return 0
  end
end
function getAdvertisementId(r0_5)
  return r6_0 and r6_0[r0_5]
end
function getAdvertisement(r0_6)
  if r5_0 then
    return r5_0[r0_6]
  end
end
function subscribeToAdvertisementList()
  if isTimer(r8_0) then
    killTimer(r8_0)
  end
  r8_0 = nil
  if not r5_0 then
    r5_0 = {}
    r6_0 = {}
    r4_0 = false
    triggerServerEvent("addDealerAdvertisementSubscription", localPlayer)
    if isTimer(r7_0) then
      killTimer(r7_0)
    end
    r7_0 = nil
    r7_0 = setTimer(processAdvertisementList, 1000, 0)
  end
end
function doUnsubscribeFinal()
  r5_0 = false
  r6_0 = false
  r4_0 = false
  if isTimer(r7_0) then
    killTimer(r7_0)
  end
  r7_0 = nil
  sightexports.sMobile:updateDealerApp()
end
addEvent("dealerAdvertisementSubscriptionFail", true)
addEventHandler("dealerAdvertisementSubscriptionFail", getRootElement(), function(r0_9)
  if r5_0 then
    doUnsubscribeFinal()
  end
  if r0_9 then
    local r1_9 = getRealTime(r0_9 + 60)
    r4_0 = "Mivel az előző megbízást nem teljesítetted, ezért ideiglenesen letiltásra kerültél a SightNion Marketről."
    r4_0 = r4_0 .. "\n\nA piactér " .. string.format("%04d. %02d. %02d. %02d:%02d", r1_9.year + 1900, r1_9.month + 1, r1_9.monthday, r1_9.hour, r1_9.minute) .. " után lesz újra elérhető számodra."
  else
    r4_0 = "Nincs jogosultságod a SightNion Market használatához!"
  end
  sightexports.sMobile:updateDealerApp()
end)
function doUnsubscribeToAdvertisementList()
  if r5_0 then
    triggerServerEvent("removeDealerAdvertisementSubscription", localPlayer)
    doUnsubscribeFinal()
  end
end
function unsubscribeToAdvertisementList()
  if isTimer(r8_0) then
    killTimer(r8_0)
  end
  r8_0 = nil
  r8_0 = setTimer(doUnsubscribeToAdvertisementList, 10000, 1)
  r4_0 = false
end
function processAdvertisementList()
  if r5_0 then
    local r0_12 = false
    for r4_12, r5_12 in pairs(r5_0) do
      local r6_12 = math.floor((r5_12.valid - getTickCount()) / 1000)
      if r5_12.remaining ~= r6_12 then
        r5_12.remaining = r6_12
        if r5_12.remaining <= 0 then
          r5_0[r4_12] = nil
          for r10_12 = #r6_0, 1, -1 do
            if r6_0[r10_12] == r4_12 then
              table.remove(r6_0, r10_12)
            end
          end
        end
        r0_12 = true
      end
    end
    if r0_12 then
      sightexports.sMobile:updateDealerScroll()
    end
  end
end
function advertisementIdsSort(r0_13, r1_13)
  local r2_13 = r5_0[r0_13]
  local r3_13 = r5_0[r1_13]
  if r2_13 and r3_13 then
    return r2_13.valid < r3_13.valid
  end
  return false
end
addEvent("sendDealerAdvertisementList", true)
addEventHandler("sendDealerAdvertisementList", root, function(r0_14, r1_14)
  r5_0 = r1_14
  r6_0 = {}
  for r5_14, r6_14 in pairs(r5_0) do
    r6_14.valid = r6_14.valid - r0_14 + getTickCount()
    r6_14.itemName = sightexports.sItems:getItemName(r6_14.itemId)
    r6_14.itemPic = sightexports.sItems:getItemPic(r6_14.itemId)
    table.insert(r6_0, r5_14)
  end
  processAdvertisementList()
  table.sort(r6_0, advertisementIdsSort)
  sightexports.sMobile:updateDealerApp()
end)
addEvent("createNewDealerAdvertisement", true)
addEventHandler("createNewDealerAdvertisement", root, function(r0_15, r1_15)
  if r5_0 then
    r5_0[r1_15.id] = r1_15
    r1_15.valid = r1_15.valid - r0_15 + getTickCount()
    r1_15.itemName = sightexports.sItems:getItemName(r1_15.itemId)
    r1_15.itemPic = sightexports.sItems:getItemPic(r1_15.itemId)
    processAdvertisementList()
    for r5_15 = #r6_0, 1, -1 do
      if r6_0[r5_15] == r1_15.id then
        return 
      end
    end
    table.insert(r6_0, r1_15.id)
    table.sort(r6_0, advertisementIdsSort)
    sightexports.sMobile:updateDealerScroll()
  end
end)
addEvent("removeDealerAdvertisement", true)
addEventHandler("removeDealerAdvertisement", root, function(r0_16)
  if r5_0 then
    r5_0[r0_16] = nil
    for r4_16 = #r6_0, 1, -1 do
      if r6_0[r4_16] == r0_16 then
        table.remove(r6_0, r4_16)
      end
    end
    sightexports.sMobile:updateDealerScroll()
  end
end)
function formatAdMessage(r0_17)
  local r1_17 = adMessages[r0_17.msg]
  if not r0_17.itemName then
    r0_17.itemName = sightexports.sItems:getItemName(r0_17.itemId)
  end
  r1_17 = string.gsub(string.gsub(r1_17, "%[név%]", r0_17.amount .. " db " .. r0_17.itemName), "%[összeg%]", sightexports.sGui:thousandsStepper(r0_17.price) .. " $")
  local r2_17 = nil
  if r0_17.wmsg then
    local r3_17 = itemCategories[r0_17.itemId]
    if r3_17 then
      r2_17 = warnMessages[r3_17][r0_17.wmsg]
    end
  end
  return r1_17, r2_17
end
function getAdMessage(r0_18)
  if r5_0[r0_18] then
    return formatAdMessage(r5_0[r0_18])
  end
  return ""
end
local currentDelivery = false
function getDelivery()
  return currentDelivery
end
function doHasDelivery()
  local r0_20 = currentDelivery
  if r0_20 then
    r0_20 = true or false
  end
  return r0_20
end
function startDelivery(r0_21)
  if r5_0 and r5_0[r0_21] and not currentDelivery then
    local r1_21 = r5_0[r0_21]
    currentDelivery = {
      trigger = r0_21,
      itemId = r1_21.itemId,
      amount = r1_21.amount,
      price = r1_21.price,
      msg = r1_21.msg,
      wmsg = r1_21.wmsg,
    }
    triggerServerEvent("tryToStartDealerDelivery", localPlayer, currentDelivery.trigger)
  end
  sightexports.sMobile:updatesightNionMarketDelivery()
end
function processDeliveryLocks(r0_23)
  if currentDelivery then
    if currentDelivery.responseLock then
      currentDelivery.responseLock = currentDelivery.responseLock - r0_23
      if currentDelivery.responseLock <= 0 then
        currentDelivery.responseLock = nil
        sightexports.sMobile:updatesightNionMarketDelivery()
      end
      return 
    end
    if currentDelivery.replyLock then
      currentDelivery.replyLock = currentDelivery.replyLock - r0_23
      if currentDelivery.replyLock <= 0 then
        currentDelivery.replyLock = nil
        sightexports.sMobile:updatesightNionMarketDelivery()
      end
      return 
    end
    if currentDelivery.coordinateLock then
      currentDelivery.coordinateLock = currentDelivery.coordinateLock - r0_23
      if currentDelivery.coordinateLock <= 0 then
        currentDelivery.coordinateLock = nil
        sightexports.sMobile:updatesightNionMarketDelivery()
      end
      return 
    end
    if currentDelivery.buyerResponseLock then
      currentDelivery.buyerResponseLock = currentDelivery.buyerResponseLock - r0_23
      if currentDelivery.buyerResponseLock <= 0 then
        currentDelivery.buyerResponseLock = nil
        sightexports.sMobile:updatesightNionMarketDelivery()
        sightexports.sGui:showInfobox("i", "A vevő megjelölve a térképeden.")
        sightexports.sGui:showInfobox("w", "Figyelj oda, mert " .. math.floor(currentDelivery.valid / 60) .. " perced van teljesíteni a megbízást!")
      end
      return 
    end
  end
  sightlangCondHandl0(false)
end
addEvent("updateDealerDelivery", true)
addEventHandler("updateDealerDelivery", getRootElement(), function(deliveryData, acceptedDelivery)
  currentDelivery = deliveryData
  if acceptedDelivery then
    local sellerResponseMessage = formatResponseMessage(currentDelivery)
    local buyerResponseMessage = formatBuyerResponseMessage(currentDelivery)
    local textLength = utf8.len(sellerResponseMessage) * 75
    currentDelivery.responseLock = textLength * (0.75 + 0.25 * math.random())
    currentDelivery.replyLock = textLength * (0.75 + 0.25 * math.random()) / 3
    currentDelivery.coordinateLock = 300 + 600 * math.random()
    currentDelivery.buyerResponseLock = utf8.len(buyerResponseMessage) * 75 * (0.75 + 0.25 * math.random())
    sightlangCondHandl0(true)
  end
  sightexports.sMobile:updatesightNionMarketDelivery()
end)
