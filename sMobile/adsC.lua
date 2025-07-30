local sightxports = {
  sGui = false,
  sItems = false,
  sPermission = false
}
local function sightlangProcessExports()
  for k in pairs(sightxports) do
    local res = getResourceFromName(k)
    if res and getResourceState(res) == "running" then
      sightxports[k] = exports[k]
    else
      sightxports[k] = false
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
local sightlangStatImgHand = false
local sightlangStaticImage = {}
local sightlangStaticImageToc = {}
local sightlangStaticImageUsed = {}
local sightlangStaticImageDel = {}
local processSightlangStaticImage = {}
sightlangStaticImageToc[0] = true
local sightlangStatImgPre
function sightlangStatImgPre()
  local now = getTickCount()
  if sightlangStaticImageUsed[0] then
    sightlangStaticImageUsed[0] = false
    sightlangStaticImageDel[0] = false
  elseif sightlangStaticImage[0] then
    if sightlangStaticImageDel[0] then
      if now >= sightlangStaticImageDel[0] then
        if isElement(sightlangStaticImage[0]) then
          destroyElement(sightlangStaticImage[0])
        end
        sightlangStaticImage[0] = nil
        sightlangStaticImageDel[0] = false
        sightlangStaticImageToc[0] = true
        return
      end
    else
      sightlangStaticImageDel[0] = now + 5000
    end
  else
    sightlangStaticImageToc[0] = true
  end
  if sightlangStaticImageToc[0] then
    sightlangStatImgHand = false
    removeEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre)
  end
end
processSightlangStaticImage[0] = function()
  if not isElement(sightlangStaticImage[0]) then
    sightlangStaticImageToc[0] = false
    sightlangStaticImage[0] = dxCreateTexture("files/img/itemgrad.dds", "dxt1", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
local sightlangCondHandlState0 = false
local function sightlangCondHandl0(cond, prio)
  cond = cond and true or false
  if cond ~= sightlangCondHandlState0 then
    sightlangCondHandlState0 = cond
    if cond then
      addEventHandler("onClientPreRender", getRootElement(), refreshCatScrollNextFrame, true, prio)
    else
      removeEventHandler("onClientPreRender", getRootElement(), refreshCatScrollNextFrame)
    end
  end
end
local favoriteAds = {}
local adButtons = {}
function appCloses.ads()
  adButtons = {}
end
local smallestAdId = false
local selectedAdCategory = 1
local selectedAd = 1
local loadedAds = {}
local requestedAds = {}
local requestedAdThumbs = {}
local requestedSinglePics = {}
local lastSinglePic = {}
lastCategoryScroll = {}
local rawAdList = {}
local subAdList = {}
local loadedAdList = {}
local ownAdIds = false
local filterOwn = false
local filterFav = false
local filterExcludeSub = {}
local loadedAdPhotos = {}
local adLoading = false
singleData = {}
local adScrollBar
local singleScroll = 0
local singleBigPic = false
local singleBigPicY = false
local singlePics = {}
local singlePicY = false
local singleTop = false
local singleTopY = false
local singleElements = {}
local singleLastY = false
local singleTop = false
local categoryScrollUp = false
local categoryScroll = 0
local categoryScrollBar = 0
local categoryScrollBarY = 0
local categoryScrollHeight = 0
local adCategoryElements = {}
local specialData = false
local specialDataClient = false
local adHighlighted = false
local tryingToPostAd = false
local newAdError = false
local newAdId = false
local adTime = 0
addEvent("selectAd", false)
addEventHandler("selectAd", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  if not adLoading and el and adButtons[el] and loadedAds[adButtons[el]] then
    adLoading = true
    selectedAd = adButtons[el]
    triggerServerEvent("loadSingleAd", localPlayer, selectedAd)
  end
end)
addEvent("openNewAd", false)
addEventHandler("openNewAd", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  if not adLoading and newAdId then
    adLoading = true
    selectedAd = newAdId
    triggerServerEvent("loadSingleAd", localPlayer, newAdId)
  end
end)
addEvent("loadedSingleAd", true)
addEventHandler("loadedSingleAd", getRootElement(), function(data, highlight, online)
  adHighlighted = highlight
  adLoading = false
  data.online = online
  singleData = data
  if mobileState then
    switchAppScreen("ad_single", true)
  end
end)
addEvent("selectAdCategory", true)
addEventHandler("selectAdCategory", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  if mobileState then
    if el and adButtons[el] then
      selectedAdCategory = adButtons[el]
    end
    adHighlighted = false
    triggerServerEvent("requestAdsForCategory", localPlayer, selectedAdCategory)
    switchAppScreen("ad_category_loading", true)
  end
end)
addEvent("selectAdCategoryEx", false)
addEventHandler("selectAdCategoryEx", getRootElement(), function()
  switchAppScreen("ad_category", true)
end)
local filterOwnCategory = {}
local filterFavCategory = {}
local filterExcludeSubCategory = {}
addEvent("loadedAdsForCategory", true)
addEventHandler("loadedAdsForCategory", getRootElement(), function(category, dataH, data, subH, sub, ownIds)
  selectedAdCategory = category
  categoryScroll = 0
  requestedAds = {}
  requestedAdThumbs = {}
  loadedAds = {}
  rawAdList = {}
  subAdList = {}
  ownAdIds = ownIds
  for i = 1, #dataH do
    table.insert(rawAdList, dataH[i])
  end
  for i = 1, #data do
    table.insert(rawAdList, data[i])
  end
  for i = 1, #subH do
    table.insert(subAdList, subH[i])
  end
  for i = 1, #sub do
    table.insert(subAdList, sub[i])
  end
  filterOwn = filterOwnCategory[selectedAdCategory]
  filterFav = filterFavCategory[selectedAdCategory]
  filterExcludeSub = filterExcludeSubCategory[selectedAdCategory] or {}
  processAdFiltering()
  if mobileState then
    switchAppScreen("ad_category", true)
  end
end)
function refreshSingleScroll()
  local iw = bsx - 16
  if singleBigPic then
    local y = singleBigPicY - singleScroll
    if y < 0 then
      local size = 512 / iw
      if y < -iw then
        sightxports.sGui:setGuiPosition(singleBigPic, false, 0)
        sightxports.sGui:setGuiSize(singleBigPic, 0, 0)
      else
        sightxports.sGui:setImageUV(singleBigPic, 0, -y * size, 512, 512 + y * size)
        sightxports.sGui:setGuiSize(singleBigPic, iw, iw + y)
        sightxports.sGui:setGuiPosition(singleBigPic, false, 0)
      end
    else
      sightxports.sGui:setImageUV(singleBigPic, 0, 0, 512, 512)
      sightxports.sGui:setGuiPosition(singleBigPic, false, y)
      sightxports.sGui:setGuiSize(singleBigPic, iw, iw)
    end
  end
  iw = (iw - 8) / 3
  local y = singlePicY - singleScroll
  if y < 0 then
    local size = 512 / iw
    if y < -iw then
      for i = 1, #singlePics do
        sightxports.sGui:setGuiPosition(singlePics[i], false, 0)
        sightxports.sGui:setGuiSize(singlePics[i], 0, 0)
      end
    else
      for i = 1, #singlePics do
        sightxports.sGui:setImageUV(singlePics[i], 0, -y * size, 512, 512 + y * size)
        sightxports.sGui:setGuiSize(singlePics[i], iw, iw + y)
        sightxports.sGui:setGuiPosition(singlePics[i], false, 0)
      end
    end
  else
    for i = 1, #singlePics do
      sightxports.sGui:setImageUV(singlePics[i], 0, 0, 512, 512)
      sightxports.sGui:setGuiPosition(singlePics[i], false, y)
      sightxports.sGui:setGuiSize(singlePics[i], iw, iw)
    end
  end
  local ty = singleTopY - topSize - singleScroll
  if ty < 0 then
    ty = 0
  end
  sightxports.sGui:setGuiPosition(singleTop, false, ty)
  if ty <= 0 then
    sightxports.sGui:setGuiBackground(singleTop, "solid", {
      255,
      255,
      255
    })
  else
    sightxports.sGui:setGuiBackground(singleTop, "solid", {
      255,
      255,
      255,
      0
    })
  end
  local hideBottom = false
  for i = 1, #singleElements do
    local hide = hideBottom
    if not hideBottom then
      local ry = singleElements[i][2] - singleScroll
      if ry > bsy - topSize * 1.5 then
        ry = bsy - topSize * 1.5
        hide = true
        hideBottom = true
      elseif ry < 0 then
        ry = 0
        hide = true
      end
      sightxports.sGui:setGuiPosition(singleElements[i][1], false, ry)
      if singleElements[i][3] then
        if ry + singleElements[i][3] < bsy - topSize * 1.5 and 0 < ry then
          sightxports.sGui:setGuiHoverable(singleElements[i][1], true)
        else
          sightxports.sGui:setGuiHoverable(singleElements[i][1], false)
        end
      end
    end
    sightxports.sGui:setGuiRenderDisabled(singleElements[i][1], hide)
  end
end
local specialAdLabels = {}
function singleScrollKey(key)
  if sightxports.sGui:getDDSPreview() then
    return
  end
  if key == "mouse_wheel_up" then
    local tmp = singleScroll
    tmp = singleScroll - 24
    if tmp < 0 then
      tmp = 0
    end
    if tmp ~= singleScroll then
      singleScroll = tmp
      refreshSingleScroll()
    end
  elseif key == "mouse_wheel_down" then
    local tmp = singleScroll
    tmp = singleScroll + 24
    local max = singleLastY - (bsy - topSize * 1.5)
    if 0 < max then
      if tmp > max then
        tmp = max
      end
      if tmp ~= singleScroll then
        singleScroll = tmp
        refreshSingleScroll()
      end
    end
  end
end
local adLabelH = false
function createTopAdLabel(y, text)
  local ry = y
  local hide = false
  if ry > bsy - topSize * 1.5 then
    ry = bsy - topSize * 1.5
    hide = true
  end
  local label = sightxports.sGui:createGuiElement("label", 8, ry, bsx, 24, appInside)
  sightxports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
  sightxports.sGui:setLabelAlignment(label, "left", "Bottom")
  sightxports.sGui:setLabelColor(label, grey2)
  sightxports.sGui:setLabelText(label, text)
  table.insert(singleElements, {label, y})
  sightxports.sGui:setGuiRenderDisabled(label, hide)
  y = y + 24
  ry = y
  hide = false
  if ry > bsy - topSize * 1.5 then
    ry = bsy - topSize * 1.5
    hide = true
  end
  if ry < 0 then
    ry = 0
    hide = true
  end
  local border = sightxports.sGui:createGuiElement("hr", 0, ry, bsx, 1, appInside)
  sightxports.sGui:setGuiHrColor(border, grey2, grey2)
  table.insert(singleElements, {border, y})
  sightxports.sGui:setGuiRenderDisabled(border, hide)
  return y + 1 + 4
end
function createAdLabel(y, text1, text2, spec, col)
  local ry = y
  local hide = false
  if ry > bsy - topSize * 1.5 then
    ry = bsy - topSize * 1.5
    hide = true
  end
  local label = sightxports.sGui:createGuiElement("label", 8, ry, bsx, adLabelH, appInside)
  sightxports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
  sightxports.sGui:setLabelAlignment(label, "left", "center")
  sightxports.sGui:setLabelColor(label, col or "#000000")
  sightxports.sGui:setLabelText(label, text1 .. " ")
  table.insert(singleElements, {label, y})
  sightxports.sGui:setGuiRenderDisabled(label, hide)
  if text2 then
    local x = 8 + sightxports.sGui:getLabelTextWidth(label)
    local label = sightxports.sGui:createGuiElement("label", x, ry, bsx - x, adLabelH, appInside)
    sightxports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
    sightxports.sGui:setLabelAlignment(label, "left", "center")
    sightxports.sGui:setLabelColor(label, "#000000")
    sightxports.sGui:setLabelText(label, text2)
    sightxports.sGui:setLabelClip(label, true)
    table.insert(singleElements, {label, y})
    sightxports.sGui:setGuiRenderDisabled(label, hide)
    if spec then
      specialAdLabels[spec] = label
    end
  end
  return y + adLabelH
end
function createAdLabelEx(y, text, plus)
  plus = tonumber(plus) or 0
  local ry = y
  local hide = false
  if ry > bsy - topSize * 1.5 then
    ry = bsy - topSize * 1.5
    hide = true
  end
  local label = sightxports.sGui:createGuiElement("label", 8 + plus, ry, bsx - 16 - plus, adLabelH, appInside)
  sightxports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
  sightxports.sGui:setLabelAlignment(label, "left", "center")
  sightxports.sGui:setLabelColor(label, "#000000")
  sightxports.sGui:setLabelText(label, text)
  sightxports.sGui:setLabelClip(label, true)
  table.insert(singleElements, {label, y})
  sightxports.sGui:setGuiRenderDisabled(label, hide)
  return y + adLabelH
end
local adNameInput = false
local adName = false
local adPriceInput = false
local adPrice = false
local adDescriptionInput = false
local adDescription = false
local adSubcat = false
local adSubcatCat = false
newAdBigPic = false
newAdPics = {}
selectingAdPhoto = false
function selectAdPhoto()
  switchAppScreen("ad_new_photo", true)
end
local cropImage = false
local cropX, cropY, cropSize = 0, 0, 0
local currentAdPhoto = false
local cropZoomLevel = 0
function appCloses.ad_crop_photo()
  removeEventHandler("onClientClick", getRootElement(), adCropClick)
  removeEventHandler("onClientCursorMove", getRootElement(), adCropMove)
end
local movingCrop = false
function adCropMove(rx, ry, cx, cy)
  if movingCrop then
    cropX = movingCrop[1] - (cx - movingCrop[3]) * cropZoomLevel
    cropY = movingCrop[2] - (cy - movingCrop[4]) * cropZoomLevel
    local sx, sy = photoListData[currentAdPhoto][3], photoListData[currentAdPhoto][4]
    if cropX < 0 then
      cropX = 0
    end
    if cropX > sx - cropSize then
      cropX = sx - cropSize
    end
    if cropY < 0 then
      cropY = 0
    end
    if cropY > sy - cropSize then
      cropY = sy - cropSize
    end
    sightxports.sGui:setImageUV(cropImage, cropX, cropY, cropSize, cropSize)
  end
end
function adCropClick(button, state, cx, cy)
  if state == "down" then
    local x, y = sightxports.sGui:getGuiRealPosition(cropImage)
    local sx, sy = sightxports.sGui:getGuiSize(cropImage)
    if cx >= x and cy >= y and cx <= x + sx and cy <= y + sy then
      movingCrop = {
        cropX,
        cropY,
        cx,
        cy
      }
    end
  elseif state == "up" then
    movingCrop = false
  end
end
function appScreens.ad_crop_photo()
  appInside = sightxports.sGui:createGuiElement("null", 0, 0, bsx, bsy, mobileBackground)
  local rect = sightxports.sGui:createGuiElement("rectangle", 0, 0, bsx, bsy, appInside)
  sightxports.sGui:setGuiBackground(rect, "solid", {
    255,
    255,
    255
  })
  addEventHandler("onClientClick", getRootElement(), adCropClick)
  addEventHandler("onClientCursorMove", getRootElement(), adCropMove)
  if selectedAdCategory and adCategories[selectedAdCategory] then
    local n = 6
    local h = math.floor((bsy - topSize * 2.5 - 32) / n)
    local ts = bsy - topSize * 2.5 - h * n
    local y = topSize
    local w = sightxports.sGui:getTextWidthFont(adCategories[selectedAdCategory][3], "11/Ubuntu-R.ttf") + 24 + 4
    local rect = sightxports.sGui:createGuiElement("rectangle", 0, 0, bsx, y + ts, appInside)
    sightxports.sGui:setGuiBackground(rect, "solid", green)
    local icon = sightxports.sGui:createGuiElement("image", bsx / 2 - w / 2, y + ts / 2 - 12, 24, 24, appInside)
    sightxports.sGui:setImageFile(icon, sightxports.sGui:getFaIconFilename(adCategories[selectedAdCategory][1], 24, adCategories[selectedAdCategory][2]))
    sightxports.sGui:setImageColor(icon, "#ffffff")
    local label = sightxports.sGui:createGuiElement("label", bsx / 2 - w / 2 + 24 + 4, y, bsx, ts, appInside)
    sightxports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
    sightxports.sGui:setLabelAlignment(label, "left", "center")
    sightxports.sGui:setLabelColor(label, "#ffffff")
    sightxports.sGui:setLabelText(label, adCategories[selectedAdCategory][3])
    y = y + ts + 4
    local iw = bsx - 16
    local h = bsy - topSize * 1.5 - 24 - 4 - 4 - y - 4
    y = y + h / 2 - (iw + 24 + 10 + 4) / 2
    cropImage = sightxports.sGui:createGuiElement("image", 8, y, iw, iw, appInside)
    sightxports.sGui:setImageFile(cropImage, loadedTextures["files/img/cam.png"])
    local label = sightxports.sGui:createGuiElement("label", 0, y - 24, bsx, 24, appInside)
    sightxports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
    sightxports.sGui:setLabelAlignment(label, "center", "center")
    sightxports.sGui:setLabelColor(label, "#000000")
    sightxports.sGui:setLabelText(label, "Mozgatással kivághatod a képet.")
    local slider = sightxports.sGui:createGuiElement("slider", 8, y + iw + 4, iw, 10, appInside)
    sightxports.sGui:setSliderChangeEvent(slider, "cropZoomChangeMobileAd")
    sightxports.sGui:setSliderColor(slider, grey3, green)
    local btn = sightxports.sGui:createGuiElement("button", 8, bsy - topSize * 1.5 - 24 - 4, bsx - 16, 24, appInside)
    sightxports.sGui:setGuiBackground(btn, "solid", blue)
    sightxports.sGui:setGuiHover(btn, "none", blue, false, true)
    sightxports.sGui:setButtonTextColor(btn, "#ffffff")
    sightxports.sGui:setButtonText(btn, "Kép kivágása")
    sightxports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
    sightxports.sGui:setClickEvent(btn, "finalCropAdPhoto")
  end
  generateBottom(true, "openGalleryForAd", true)
  bringBackFront()
end
local newAdPhotos = {}
addEventHandler("onClientResourceStart", getResourceRootElement(), function()
  if fileExists("ads/favorite.sight") then
    local file = fileOpen("ads/favorite.sight", true)
    if file then
      local data = fileRead(file, fileGetSize(file))
      fileClose(file)
      data = split(data, "\n")
      if 0 < #data then
        for k = 1, #data do
          local id = tonumber(data[k])
          if id then
            favoriteAds[id] = true
          end
        end
      end
    end
  end
end)
addEventHandler("onClientResourceStop", getResourceRootElement(), function()
  for i = 1, 4 do
    if fileExists("ads/current/" .. i .. ".dds") then
      fileDelete("ads/current/" .. i .. ".dds")
    end
    if fileExists("ads/new/" .. i .. ".dds") then
      fileDelete("ads/new/" .. i .. ".dds")
    end
    if fileExists("ads/new/" .. i .. "_t.dds") then
      fileDelete("ads/new/" .. i .. "_t.dds")
    end
    if fileExists("ads/new/" .. i .. ".sight") then
      fileDelete("ads/new/" .. i .. ".sight")
    end
    if fileExists("ads/new/" .. i .. "_t.sight") then
      fileDelete("ads/new/" .. i .. "_t.sight")
    end
    if fileExists("ads/new/" .. i .. ".sight2") then
      fileDelete("ads/new/" .. i .. ".sight2")
    end
    if fileExists("ads/new/" .. i .. "_t.sight2") then
      fileDelete("ads/new/" .. i .. "_t.sight2")
    end
  end
  if fileExists("ads/list.sight") then
    local file = fileOpen("ads/list.sight", true)
    local data = fileRead(file, fileGetSize(file))
    data = split(data, "\n")
    for i = 1, #data do
      local id = tonumber(data[i])
      if id and fileExists("ads/list/" .. id .. ".dds") then
        fileDelete("ads/list/" .. id .. ".dds")
      end
    end
    fileClose(file)
    fileDelete("ads/list.sight")
  end
end)
addEvent("deleteAdPhoto", false)
addEventHandler("deleteAdPhoto", getRootElement(), function(button, state, absoluteX, absoluteY, el, id)
  if fileExists("ads/new/" .. id .. ".dds") then
    fileDelete("ads/new/" .. id .. ".dds")
  end
  if fileExists("ads/new/" .. id .. "_t.dds") then
    fileDelete("ads/new/" .. id .. "_t.dds")
  end
  if fileExists("ads/new/" .. id .. ".sight") then
    fileDelete("ads/new/" .. id .. ".sight")
  end
  if fileExists("ads/new/" .. id .. "_t.sight") then
    fileDelete("ads/new/" .. id .. "_t.sight")
  end
  if fileExists("ads/new/" .. id .. ".sight2") then
    fileDelete("ads/new/" .. id .. ".sight2")
  end
  if fileExists("ads/new/" .. id .. "_t.sight2") then
    fileDelete("ads/new/" .. id .. "_t.sight2")
  end
  selectAdPhoto()
end)
addEvent("finalCropAdPhoto", false)
addEventHandler("finalCropAdPhoto", getRootElement(), function()
  if selectingAdPhoto and photoListData[currentAdPhoto] then
    if fileExists("ads/new/" .. selectingAdPhoto .. ".dds") then
      fileDelete("ads/new/" .. selectingAdPhoto .. ".dds")
    end
    if fileExists("ads/new/" .. selectingAdPhoto .. "_t.dds") then
      fileDelete("ads/new/" .. selectingAdPhoto .. "_t.dds")
    end
    if fileExists("ads/new/" .. selectingAdPhoto .. ".sight") then
      fileDelete("ads/new/" .. selectingAdPhoto .. ".sight")
    end
    if fileExists("ads/new/" .. selectingAdPhoto .. "_t.sight") then
      fileDelete("ads/new/" .. selectingAdPhoto .. "_t.sight")
    end
    if fileExists("ads/new/" .. selectingAdPhoto .. ".sight2") then
      fileDelete("ads/new/" .. selectingAdPhoto .. ".sight2")
    end
    if fileExists("ads/new/" .. selectingAdPhoto .. "_t.sight2") then
      fileDelete("ads/new/" .. selectingAdPhoto .. "_t.sight2")
    end
    local file = fileOpen("photos/" .. photoListData[currentAdPhoto][1] .. ".sight", true)
    if file then
      local checksum = fileRead(file, fileGetSize(file))
      fileClose(file)
      if checksum then
        checksum = teaDecode(checksum, "mk" .. photoListData[currentAdPhoto][2] .. utf8.sub(photoListData[currentAdPhoto][1], 1, 10))
        local image = fileOpen("photos/" .. photoListData[currentAdPhoto][1] .. ".dds", true)
        if image then
          local imageData = fileRead(image, fileGetSize(image))
          fileClose(image)
          if imageData then
            local calculatedSum = sha256(imageData)
            if calculatedSum == checksum then
              local texture = dxCreateTexture(imageData, "dxt3", false)
              if isElement(texture) then
                local photoRt = dxCreateRenderTarget(512, 512)
                local photoRt2 = dxCreateRenderTarget(math.floor(cropSize), math.floor(cropSize))
                local thumbRt = false
                if selectingAdPhoto == 1 then
                  thumbRt = dxCreateRenderTarget(64, 64)
                end
                if isElement(photoRt2) then
                  dxSetRenderTarget(photoRt2)
                  dxDrawImageSection(0, 0, math.floor(cropSize), math.floor(cropSize), math.floor(cropX), math.floor(cropY), math.floor(cropSize), math.floor(cropSize), texture)
                  dxSetRenderTarget(photoRt)
                  dxDrawImage(0, 0, 512, 512, photoRt2)
                  if selectingAdPhoto == 1 then
                    dxSetRenderTarget(thumbRt)
                    dxDrawImage(0, 0, 64, 64, photoRt)
                  end
                  dxSetRenderTarget()
                  destroyElement(photoRt2)
                end
                destroyElement(texture)
                if isElement(photoRt) then
                  local pixels = dxGetTexturePixels(photoRt, "dds", "dxt3", false)
                  destroyElement(photoRt)
                  if pixels then
                    local checksum = sha256(pixels)
                    local ts = getRealTime().timestamp
                    local convertedFile = fileCreate("ads/new/" .. selectingAdPhoto .. ".dds")
                    if convertedFile then
                      fileWrite(convertedFile, pixels)
                      fileClose(convertedFile)
                      sightxports.sGui:resetImageDDS(":sMobile/!mobile_sight/ads/new/" .. selectingAdPhoto .. ".dds")
                      local checksumFile = fileCreate("ads/new/" .. selectingAdPhoto .. ".sight")
                      if checksumFile then
                        fileWrite(checksumFile, teaEncode(checksum, "ad" .. ts .. selectingAdPhoto))
                        fileClose(checksumFile)
                      end
                      checksumFile = nil
                      local checksumFile2 = fileCreate("ads/new/" .. selectingAdPhoto .. ".sight2")
                      if checksumFile2 then
                        fileWrite(checksumFile2, teaEncode(ts, "ts" .. selectingAdPhoto))
                        fileClose(checksumFile2)
                      end
                      checksumFile2 = nil
                    end
                    convertedFile = nil
                  end
                  pixels = nil
                end
                if isElement(thumbRt) then
                  local pixels = dxGetTexturePixels(thumbRt, "dds", "dxt1", false)
                  destroyElement(thumbRt)
                  if pixels then
                    local checksum = sha256(pixels)
                    local ts = getRealTime().timestamp
                    local convertedFile = fileCreate("ads/new/" .. selectingAdPhoto .. "_t.dds")
                    if convertedFile then
                      fileWrite(convertedFile, pixels)
                      fileClose(convertedFile)
                      sightxports.sGui:resetImageDDS(":sMobile/!mobile_sight/ads/new/" .. selectingAdPhoto .. "_t.dds")
                      local checksumFile = fileCreate("ads/new/" .. selectingAdPhoto .. "_t.sight")
                      if checksumFile then
                        fileWrite(checksumFile, teaEncode(checksum, "ad" .. ts .. selectingAdPhoto))
                        fileClose(checksumFile)
                      end
                      checksumFile = nil
                      local checksumFile2 = fileCreate("ads/new/" .. selectingAdPhoto .. "_t.sight2")
                      if checksumFile2 then
                        fileWrite(checksumFile2, teaEncode(ts, "ts" .. selectingAdPhoto))
                        fileClose(checksumFile2)
                      end
                      checksumFile2 = nil
                    end
                    convertedFile = nil
                  end
                  pixels = nil
                end
              end
            end
            imageData = nil
            calculatedSum = nil
          end
        end
        checksum = nil
      end
    end
    collectgarbage("collect")
  end
  selectAdPhoto()
end)
addEvent("cropZoomChangeMobileAd", false)
addEventHandler("cropZoomChangeMobileAd", getRootElement(), function(el, sliderValue, final)
  local sx, sy = photoListData[currentAdPhoto][3], photoListData[currentAdPhoto][4]
  local size1 = sx < sy and sx or sy
  local size2 = 256
  local minSize = math.max(size1, size2)
  local maxSize = math.min(size1, size2)
  local tmp = math.floor(minSize + (maxSize - minSize) * sliderValue)
  cropX = cropX + (cropSize - tmp) / 2
  cropY = cropY + (cropSize - tmp) / 2
  cropSize = tmp
  if cropX < 0 then
    cropX = 0
  end
  if cropX > sx - cropSize then
    cropX = sx - cropSize
  end
  if cropY < 0 then
    cropY = 0
  end
  if cropY > sy - cropSize then
    cropY = sy - cropSize
  end
  cropZoomLevel = sx < sy and sx / 512 or sy / 512
  cropZoomLevel = cropZoomLevel + (1 - cropZoomLevel) * sliderValue
  sightxports.sGui:setImageUV(cropImage, cropX, cropY, cropSize, cropSize)
end)
function openedPhotoForAd(currentPhoto)
  currentAdPhoto = currentPhoto
  if photoListData[currentAdPhoto][1] then
    switchAppScreen("ad_crop_photo", true)
    sightxports.sGui:setImageDDS(cropImage, ":sMobile/!mobile_sight/photos/" .. photoListData[currentAdPhoto][1] .. ".dds", "dxt3", false)
    local sx, sy = photoListData[currentAdPhoto][3], photoListData[currentAdPhoto][4]
    cropX = 0
    cropY = 0
    if sx < sy then
      cropSize = sx
      cropZoomLevel = sx / 256
      cropY = math.floor(sy / 2 - cropSize / 2)
    else
      cropSize = sy
      cropZoomLevel = sy / 256
      cropX = math.floor(sx / 2 - cropSize / 2)
    end
    sightxports.sGui:setImageUV(cropImage, cropX, cropY, cropSize, cropSize)
  else
    selectAdPhoto()
  end
end
addEvent("selectAdPhotoEx", false)
addEventHandler("selectAdPhotoEx", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  selectAdPhoto()
end)
addEvent("backToSingleAd", false)
addEventHandler("backToSingleAd", getRootElement(), function()
  switchAppScreen("ad_single")
end)
addEvent("deleteAd", false)
addEventHandler("deleteAd", getRootElement(), function()
  switchAppScreen("ad_delete")
end)
addEvent("highlightAd", false)
addEventHandler("highlightAd", getRootElement(), function()
  switchAppScreen("ad_highlight")
end)
addEvent("previewAdvertisement", false)
addEventHandler("previewAdvertisement", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  singleData = {}
  singleData.image = {
    fileExists("ads/new/1.dds"),
    fileExists("ads/new/2.dds"),
    fileExists("ads/new/3.dds"),
    fileExists("ads/new/4.dds")
  }
  singleData.senderName = getElementData(localPlayer, "visibleName"):gsub("_", " ")
  singleData.phoneNumber = tonumber(currentMobileNumber) or 0
  if specialData and specialData[1] == "item" then
    singleData.specialData = {
      "item",
      specialDataClient[2],
      specialDataClient[3],
      specialDataClient[1].itemId,
      specialDataClient[1].amount,
      specialDataClient[1].nameTag,
      specialDataClient[1].serial
    }
  end
  singleData.description = adDescription
  singleData.subCategory = adSubcat
  singleData.title = adName
  singleData.price = tonumber(adPrice)
  singleData.preview = true
  singleData.category = selectedAdCategory
  switchAppScreen("ad_single")
end)
function createItemAdPhoto(itemData)
  local selectingAdPhoto = 1
  if fileExists("ads/new/" .. selectingAdPhoto .. ".dds") then
    fileDelete("ads/new/" .. selectingAdPhoto .. ".dds")
  end
  if fileExists("ads/new/" .. selectingAdPhoto .. "_t.dds") then
    fileDelete("ads/new/" .. selectingAdPhoto .. "_t.dds")
  end
  if fileExists("ads/new/" .. selectingAdPhoto .. ".sight") then
    fileDelete("ads/new/" .. selectingAdPhoto .. ".sight")
  end
  if fileExists("ads/new/" .. selectingAdPhoto .. "_t.sight") then
    fileDelete("ads/new/" .. selectingAdPhoto .. "_t.sight")
  end
  if fileExists("ads/new/" .. selectingAdPhoto .. ".sight2") then
    fileDelete("ads/new/" .. selectingAdPhoto .. ".sight2")
  end
  if fileExists("ads/new/" .. selectingAdPhoto .. "_t.sight2") then
    fileDelete("ads/new/" .. selectingAdPhoto .. "_t.sight2")
  end
  local photoRt = dxCreateRenderTarget(512, 512)
  local photoRt2 = dxCreateRenderTarget(256, 256)
  local thumbRt = dxCreateRenderTarget(64, 64)
  if isElement(photoRt) and isElement(photoRt2) and isElement(thumbRt) then
    dxSetRenderTarget(photoRt2)
    local itemId = itemData.itemId
    local sx, sy = sightxports.sItems:processTooltip(0, 0, theItemName, itemId, itemData, true, true)
    sightlangStaticImageUsed[0] = true
    if sightlangStaticImageToc[0] then
      processSightlangStaticImage[0]()
    end
    dxDrawImage(0, 0, 256, 256, sightlangStaticImage[0])
    sightxports.sItems:drawShowItem(itemData, 256, 128 - (sy + 36 + 16) / 2)
    dxSetRenderTarget(photoRt)
    dxDrawImage(0, 0, 512, 512, photoRt2)
    dxSetRenderTarget(thumbRt)
    sightlangStaticImageUsed[0] = true
    if sightlangStaticImageToc[0] then
      processSightlangStaticImage[0]()
    end
    dxDrawImage(0, 0, 64, 64, sightlangStaticImage[0])
    dxDrawImage(14, 14, 36, 36, ":sItems/files/items/" .. itemId - 1 .. ".png")
    dxSetRenderTarget()
  end
  if isElement(photoRt) then
    local pixels = dxGetTexturePixels(photoRt, "dds", "dxt3", false)
    destroyElement(photoRt)
    if pixels then
      local checksum = sha256(pixels)
      local ts = getRealTime().timestamp
      local convertedFile = fileCreate("ads/new/" .. selectingAdPhoto .. ".dds")
      if convertedFile then
        fileWrite(convertedFile, pixels)
        fileClose(convertedFile)
        sightxports.sGui:resetImageDDS(":sMobile/!mobile_sight/ads/new/" .. selectingAdPhoto .. ".dds")
        local checksumFile = fileCreate("ads/new/" .. selectingAdPhoto .. ".sight")
        if checksumFile then
          fileWrite(checksumFile, teaEncode(checksum, "ad" .. ts .. selectingAdPhoto))
          fileClose(checksumFile)
        end
        checksumFile = nil
        local checksumFile2 = fileCreate("ads/new/" .. selectingAdPhoto .. ".sight2")
        if checksumFile2 then
          fileWrite(checksumFile2, teaEncode(ts, "ts" .. selectingAdPhoto))
          fileClose(checksumFile2)
        end
        checksumFile2 = nil
      end
      convertedFile = nil
    end
    pixels = nil
  end
  if isElement(thumbRt) then
    local pixels = dxGetTexturePixels(thumbRt, "dds", "dxt1", false)
    destroyElement(thumbRt)
    if pixels then
      local checksum = sha256(pixels)
      local ts = getRealTime().timestamp
      local convertedFile = fileCreate("ads/new/" .. selectingAdPhoto .. "_t.dds")
      if convertedFile then
        fileWrite(convertedFile, pixels)
        fileClose(convertedFile)
        sightxports.sGui:resetImageDDS(":sMobile/!mobile_sight/ads/new/" .. selectingAdPhoto .. "_t.dds")
        local checksumFile = fileCreate("ads/new/" .. selectingAdPhoto .. "_t.sight")
        if checksumFile then
          fileWrite(checksumFile, teaEncode(checksum, "ad" .. ts .. selectingAdPhoto))
          fileClose(checksumFile)
        end
        checksumFile = nil
        local checksumFile2 = fileCreate("ads/new/" .. selectingAdPhoto .. "_t.sight2")
        if checksumFile2 then
          fileWrite(checksumFile2, teaEncode(ts, "ts" .. selectingAdPhoto))
          fileClose(checksumFile2)
        end
        checksumFile2 = nil
      end
      convertedFile = nil
    end
    pixels = nil
  end
  collectgarbage("collect")
end
local itemList = {}
local currentItemScroll = 0
local itemElements = {}
local itemScrollBar = false
local itemScrollBarY = 0
local itemScrollHeight = 0
function itemSort(a, b)
  if a[1] and not b[1] then
    return false
  elseif not a[1] and b[1] then
    return true
  elseif not a[1] and not b[1] then
    return true
  else
    return a[1].slot < b[1].slot
  end
end
function refreshItemScroll()
  for i = 1, 9 do
    if itemElements[i] and itemList[i + currentItemScroll] then
      local img = itemElements[i][2]
      if itemList[i + currentItemScroll][1] then
        sightxports.sGui:setImageFile(img, ":sItems/files/items/" .. itemList[i + currentItemScroll][1].itemId - 1 .. ".png")
      else
        sightxports.sGui:setImageFile(img, loadedTextures["files/img/item_x.png"])
      end
      local label = itemElements[i][3]
      sightxports.sGui:setLabelText(label, itemList[i + currentItemScroll][2])
      local label = itemElements[i][4]
      sightxports.sGui:setLabelText(label, itemList[i + currentItemScroll][3])
    end
  end
  sightxports.sGui:setGuiPosition(itemScrollBar, bsx - 9, itemScrollBarY + itemScrollHeight / math.max(1, #itemList - 9 + 1) * currentItemScroll)
end
function itemSpecialScroll(key)
  if key == "mouse_wheel_up" then
    if 0 < currentItemScroll then
      currentItemScroll = currentItemScroll - 1
      refreshItemScroll()
    end
  elseif key == "mouse_wheel_down" and currentItemScroll < #itemList - 9 then
    currentItemScroll = currentItemScroll + 1
    refreshItemScroll()
  end
end
addEvent("selectAdSpecialItem", false)
addEventHandler("selectAdSpecialItem", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  for i = 1, 9 do
    if itemElements[i][1] == el then
      if itemList[i + currentItemScroll] and itemList[i + currentItemScroll][1] then
        createItemAdPhoto(itemList[i + currentItemScroll][1])
        specialData = {
          "item",
          itemList[i + currentItemScroll][1].dbID
        }
        specialDataClient = itemList[i + currentItemScroll]
      end
      selectAdPhoto()
      break
    end
  end
end)
function appCloses.ad_new_special_items()
  removeEventHandler("onClientKey", getRootElement(), itemSpecialScroll)
end
function appScreens.ad_new_special_items()
  appInside = sightxports.sGui:createGuiElement("null", 0, 0, bsx, bsy, mobileBackground)
  local rect = sightxports.sGui:createGuiElement("rectangle", 0, 0, bsx, bsy, appInside)
  sightxports.sGui:setGuiBackground(rect, "solid", {
    255,
    255,
    255
  })
  addEventHandler("onClientKey", getRootElement(), itemSpecialScroll)
  specialData = false
  if selectedAdCategory and adCategories[selectedAdCategory] then
    local tmp = sightxports.sItems:getLocalPlayerItemsEx()
    table.insert(tmp, {
      false,
      "Nem választok",
      "Lépés átugrása"
    })
    table.sort(tmp, itemSort)
    itemList = {}
    for i = 1, #tmp do
      if tmp[i] and tmp[i][1] and tmp[i][1].itemId > 3 and tmp[i][1].itemId ~= 154 then
        table.insert(itemList, tmp[i])
      end
    end
    currentItemScroll = 0
    itemElements = {}
    local h = math.floor((bsy - topSize * 2.5 - 24) / 9)
    local h2 = bsy - topSize * 2.5 - h * 9
    local label = sightxports.sGui:createGuiElement("label", 0, topSize, bsx, h2, appInside)
    sightxports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
    sightxports.sGui:setLabelAlignment(label, "center", "center")
    sightxports.sGui:setLabelColor(label, "#000000")
    sightxports.sGui:setLabelText(label, "Válassz tárgyat a hirdetéshez:")
    local y = topSize + h2
    for i = 1, 9 do
      if itemList[i] then
        itemElements[i] = {}
        local rect = sightxports.sGui:createGuiElement("rectangle", 0, y + (i - 1) * h, bsx - 13, h, appInside)
        sightxports.sGui:setGuiBackground(rect, "solid", {
          255,
          255,
          255
        })
        sightxports.sGui:setGuiHover(rect, "none", {
          255,
          255,
          255
        }, false, true)
        sightxports.sGui:setGuiHoverable(rect, true)
        sightxports.sGui:setClickEvent(rect, "selectAdSpecialItem")
        table.insert(itemElements[i], rect)
        local border = sightxports.sGui:createGuiElement("hr", 0, 0, bsx - 13, 1, rect)
        sightxports.sGui:setGuiHrColor(border, grey2, grey2)
        local img = sightxports.sGui:createGuiElement("image", 8, h / 2 - 18, 36, 36, rect)
        if itemList[i][1] then
          sightxports.sGui:setImageFile(img, ":sItems/files/items/" .. itemList[i][1].itemId - 1 .. ".png")
        else
          sightxports.sGui:setImageFile(img, loadedTextures["files/img/item_x.png"])
        end
        table.insert(itemElements[i], img)
        local label = sightxports.sGui:createGuiElement("label", 48, h / 2 - 18, bsx - 13 - 8 - 36 - 4 - 8, 18, rect)
        sightxports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
        sightxports.sGui:setLabelAlignment(label, "left", "center")
        sightxports.sGui:setLabelColor(label, "#000000")
        sightxports.sGui:setLabelText(label, itemList[i][2])
        sightxports.sGui:setLabelClip(label, true)
        table.insert(itemElements[i], label)
        local label = sightxports.sGui:createGuiElement("label", 48, h / 2, bsx - 13 - 8 - 36 - 4 - 8, 18, rect)
        sightxports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
        sightxports.sGui:setLabelAlignment(label, "left", "center")
        sightxports.sGui:setLabelColor(label, "#000000")
        sightxports.sGui:setLabelText(label, itemList[i][3])
        sightxports.sGui:setLabelClip(label, true)
        table.insert(itemElements[i], label)
      end
    end
    itemScrollHeight = h * 9 - 4
    local rect = sightxports.sGui:createGuiElement("rectangle", bsx - 9, y, 3, itemScrollHeight, appInside)
    sightxports.sGui:setGuiBackground(rect, "solid", grey1)
    itemScrollBar = sightxports.sGui:createGuiElement("rectangle", bsx - 9, y, 3, itemScrollHeight / math.max(1, #itemList - 9 + 1), appInside)
    sightxports.sGui:setGuiBackground(itemScrollBar, "solid", grey3)
    itemScrollBarY = y
  end
  generateBottom(true, "newAdvertisementEx", true)
  bringBackFront()
end
function appScreens.ad_new_photo()
  appInside = sightxports.sGui:createGuiElement("null", 0, 0, bsx, bsy, mobileBackground)
  local rect = sightxports.sGui:createGuiElement("rectangle", 0, 0, bsx, bsy, appInside)
  sightxports.sGui:setGuiBackground(rect, "solid", {
    255,
    255,
    255
  })
  if selectedAdCategory and adCategories[selectedAdCategory] then
    local n = 6
    local h = math.floor((bsy - topSize * 2.5 - 32) / n)
    local ts = bsy - topSize * 2.5 - h * n
    local y = topSize
    local w = sightxports.sGui:getTextWidthFont(adCategories[selectedAdCategory][3], "11/Ubuntu-R.ttf") + 24 + 4
    local rect = sightxports.sGui:createGuiElement("rectangle", 0, 0, bsx, y + ts, appInside)
    sightxports.sGui:setGuiBackground(rect, "solid", green)
    local icon = sightxports.sGui:createGuiElement("image", bsx / 2 - w / 2, y + ts / 2 - 12, 24, 24, appInside)
    sightxports.sGui:setImageFile(icon, sightxports.sGui:getFaIconFilename(adCategories[selectedAdCategory][1], 24, adCategories[selectedAdCategory][2]))
    sightxports.sGui:setImageColor(icon, "#ffffff")
    local label = sightxports.sGui:createGuiElement("label", bsx / 2 - w / 2 + 24 + 4, y, bsx, ts, appInside)
    sightxports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
    sightxports.sGui:setLabelAlignment(label, "left", "center")
    sightxports.sGui:setLabelColor(label, "#ffffff")
    sightxports.sGui:setLabelText(label, adCategories[selectedAdCategory][3])
    y = y + ts + 4
    local label = sightxports.sGui:createGuiElement("label", 0, y, bsx, 32, appInside)
    sightxports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
    sightxports.sGui:setLabelAlignment(label, "center", "center")
    sightxports.sGui:setLabelColor(label, "#000000")
    sightxports.sGui:setLabelText(label, "Válassz képeket a hirdetéshez:")
    y = y + 32
    local iw = bsx - 16
    newAdBigPic = sightxports.sGui:createGuiElement("image", 8, y, iw, iw, appInside)
    if fileExists("ads/new/1.dds") then
      sightxports.sGui:setImageDDS(newAdBigPic, ":sMobile/!mobile_sight/ads/new/1.dds", "dxt3", false)
      local btn = sightxports.sGui:createGuiElement("button", 8 + iw - 32, y + iw - 32, 32, 32, appInside)
      sightxports.sGui:setButtonIcon(btn, sightxports.sGui:getFaIconFilename("trash-alt", 32))
      sightxports.sGui:setGuiBackground(btn, "solid", red)
      sightxports.sGui:setGuiHover(btn, "none", red, false, true)
      sightxports.sGui:setButtonTextColor(btn, "#ffffff")
      sightxports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
      sightxports.sGui:setClickArgument(btn, 1)
      sightxports.sGui:setClickEvent(btn, "deleteAdPhoto")
    else
      sightxports.sGui:setImageFile(newAdBigPic, loadedTextures["files/img/camplus.png"])
    end
    sightxports.sGui:setGuiHoverable(newAdBigPic, true)
    sightxports.sGui:setClickEvent(newAdBigPic, "openGalleryForAd")
    y = y + iw + 4
    newAdPics = {}
    iw = (iw - 8) / 3
    local img = sightxports.sGui:createGuiElement("image", 8, y, iw, iw, appInside)
    if fileExists("ads/new/2.dds") then
      sightxports.sGui:setImageDDS(img, ":sMobile/!mobile_sight/ads/new/2.dds", "dxt3", false)
      local btn = sightxports.sGui:createGuiElement("button", 8 + iw - 24, y + iw - 24, 24, 24, appInside)
      sightxports.sGui:setButtonIcon(btn, sightxports.sGui:getFaIconFilename("trash-alt", 24))
      sightxports.sGui:setGuiBackground(btn, "solid", red)
      sightxports.sGui:setGuiHover(btn, "none", red, false, true)
      sightxports.sGui:setButtonTextColor(btn, "#ffffff")
      sightxports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
      sightxports.sGui:setClickArgument(btn, 2)
      sightxports.sGui:setClickEvent(btn, "deleteAdPhoto")
    else
      sightxports.sGui:setImageFile(img, loadedTextures["files/img/camplus.png"])
    end
    sightxports.sGui:setGuiHoverable(img, true)
    sightxports.sGui:setClickEvent(img, "openGalleryForAd")
    table.insert(newAdPics, img)
    local img = sightxports.sGui:createGuiElement("image", 8 + iw + 4, y, iw, iw, appInside)
    if fileExists("ads/new/3.dds") then
      sightxports.sGui:setImageDDS(img, ":sMobile/!mobile_sight/ads/new/3.dds", "dxt3", false)
      local btn = sightxports.sGui:createGuiElement("button", 8 + iw * 2 + 4 - 24, y + iw - 24, 24, 24, appInside)
      sightxports.sGui:setButtonIcon(btn, sightxports.sGui:getFaIconFilename("trash-alt", 24))
      sightxports.sGui:setGuiBackground(btn, "solid", red)
      sightxports.sGui:setGuiHover(btn, "none", red, false, true)
      sightxports.sGui:setButtonTextColor(btn, "#ffffff")
      sightxports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
      sightxports.sGui:setClickArgument(btn, 3)
      sightxports.sGui:setClickEvent(btn, "deleteAdPhoto")
    else
      sightxports.sGui:setImageFile(img, loadedTextures["files/img/camplus.png"])
    end
    sightxports.sGui:setGuiHoverable(img, true)
    sightxports.sGui:setClickEvent(img, "openGalleryForAd")
    table.insert(newAdPics, img)
    local img = sightxports.sGui:createGuiElement("image", 8 + iw * 2 + 8, y, iw, iw, appInside)
    if fileExists("ads/new/4.dds") then
      sightxports.sGui:setImageDDS(img, ":sMobile/!mobile_sight/ads/new/4.dds", "dxt3", false)
      local btn = sightxports.sGui:createGuiElement("button", 8 + iw * 3 + 8 - 24, y + iw - 24, 24, 24, appInside)
      sightxports.sGui:setButtonIcon(btn, sightxports.sGui:getFaIconFilename("trash-alt", 24))
      sightxports.sGui:setGuiBackground(btn, "solid", red)
      sightxports.sGui:setGuiHover(btn, "none", red, false, true)
      sightxports.sGui:setButtonTextColor(btn, "#ffffff")
      sightxports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
      sightxports.sGui:setClickArgument(btn, 4)
      sightxports.sGui:setClickEvent(btn, "deleteAdPhoto")
    else
      sightxports.sGui:setImageFile(img, loadedTextures["files/img/camplus.png"])
    end
    sightxports.sGui:setGuiHoverable(img, true)
    sightxports.sGui:setClickEvent(img, "openGalleryForAd")
    table.insert(newAdPics, img)
    y = y + iw + 4
    local label = sightxports.sGui:createGuiElement("label", 0, y, bsx, 48, appInside)
    sightxports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
    sightxports.sGui:setLabelAlignment(label, "center", "center")
    sightxports.sGui:setLabelColor(label, "#000000")
    sightxports.sGui:setLabelText(label, "A nagy kép lesz látható\na hirdetéslistában előnézetként.")
    local btn = sightxports.sGui:createGuiElement("button", 8, bsy - topSize * 1.5 - 24 - 4, bsx - 16, 24, appInside)
    sightxports.sGui:setGuiBackground(btn, "solid", blue)
    sightxports.sGui:setGuiHover(btn, "none", blue, false, true)
    sightxports.sGui:setButtonTextColor(btn, "#ffffff")
    sightxports.sGui:setButtonText(btn, "Következő lépés")
    sightxports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
    sightxports.sGui:setClickEvent(btn, "previewAdvertisement")
  end
  generateBottom(true, "newAdSpecialBack", true)
  bringBackFront()
end
addEvent("newAdvertisement", false)
addEventHandler("newAdvertisement", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  switchAppScreen("ad_new")
end)
addEvent("newAdvertisementEx", false)
addEventHandler("newAdvertisementEx", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  switchAppScreen("ad_new")
end)
addEvent("newAdSpecialBack", false)
addEventHandler("newAdSpecialBack", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  if adCategories[selectedAdCategory][4] and appScreens["ad_new_special_" .. adCategories[selectedAdCategory][4]] then
    switchAppScreen("ad_new_special_" .. adCategories[selectedAdCategory][4], true)
  else
    switchAppScreen("ad_new", true)
  end
end)
local newAdCheckboxes = {}
local newAdScroll = 0
local newAdScrollBar = false
local newAdScrollH = false
addEvent("newAdSpecialNext", false)
addEventHandler("newAdSpecialNext", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  if not adSubcat then
    local n = #adCategories[selectedAdCategory][5]
    for i = 1, math.min(n, 7) do
      sightxports.sGui:setLabelColor(newAdCheckboxes[i][2], red)
    end
    return
  end
  adName = sightxports.sGui:getInputValue(adNameInput)
  if adName and utf8.len(adName) then
    sightxports.sGui:setInputColor(adNameInput, grey3, "#ffffff", "#000000", "#ffffff", "#000000")
    adPrice = tonumber(sightxports.sGui:getInputValue(adPriceInput))
    adDescription = sightxports.sGui:getInputValue(adDescriptionInput)
    if adCategories[selectedAdCategory][4] and appScreens["ad_new_special_" .. adCategories[selectedAdCategory][4]] then
      switchAppScreen("ad_new_special_" .. adCategories[selectedAdCategory][4], true)
    else
      switchAppScreen("ad_new_photo", true)
    end
  else
    sightxports.sGui:setInputColor(adNameInput, red, "#ffffff", "#000000", "#ffffff", "#000000")
  end
end)
function refreshNewAdScroll()
  if selectedAdCategory and adCategories[selectedAdCategory] then
    local n = #adCategories[selectedAdCategory][5]
    for i = 1, math.min(n, 7) do
      local checkbox, label = unpack(newAdCheckboxes[i])
      if adCategories[selectedAdCategory][5][i + newAdScroll] then
        sightxports.sGui:setLabelText(label, adCategories[selectedAdCategory][5][i + newAdScroll])
        sightxports.sGui:setClickArgument(checkbox, i + newAdScroll)
        sightxports.sGui:setCheckboxChecked(checkbox, adSubcat == i + newAdScroll)
      end
    end
    if newAdScrollBar then
      sightxports.sGui:setGuiPosition(newAdScrollBar, false, newAdScroll * newAdScrollH)
    end
  end
end
addEvent("clickNewAdCheckbox", false)
addEventHandler("clickNewAdCheckbox", getRootElement(), function(button, state, absoluteX, absoluteY, el, cat)
  if selectedAdCategory and adCategories[selectedAdCategory] and adCategories[selectedAdCategory][5][cat] then
    adSubcat = cat
    adSubcatCat = selectedAdCategory
    refreshNewAdScroll()
  end
end)
function newAdScrollKey(key)
  if key == "mouse_wheel_up" then
    if 0 < newAdScroll then
      newAdScroll = newAdScroll - 1
      refreshNewAdScroll()
    end
  elseif key == "mouse_wheel_down" then
    local n = #adCategories[selectedAdCategory][5]
    if newAdScroll < n - 7 then
      newAdScroll = newAdScroll + 1
      refreshNewAdScroll()
    end
  end
end
function appCloses.ad_new()
  removeEventHandler("onClientKey", getRootElement(), newAdScrollKey)
  adName = sightxports.sGui:getInputValue(adNameInput)
  adPrice = tonumber(sightxports.sGui:getInputValue(adPriceInput))
  adDescription = sightxports.sGui:getInputValue(adDescriptionInput)
  newAdCheckboxes = {}
  newAdScrollBar = false
  newAdScrollH = false
  newAdScroll = 0
end
function appScreens.ad_new()
  addEventHandler("onClientKey", getRootElement(), newAdScrollKey)
  newAdCheckboxes = {}
  newAdScrollBar = false
  newAdScrollH = false
  newAdScroll = 0
  if adSubcat and (not adCategories[selectedAdCategory][5][adSubcat] or adSubcatCat ~= selectedAdCategory) then
    adSubcat = false
    adSubcatCat = false
  end
  appInside = sightxports.sGui:createGuiElement("null", 0, 0, bsx, bsy, mobileBackground)
  local rect = sightxports.sGui:createGuiElement("rectangle", 0, 0, bsx, bsy, appInside)
  sightxports.sGui:setGuiBackground(rect, "solid", {
    255,
    255,
    255
  })
  if selectedAdCategory and adCategories[selectedAdCategory] then
    local n = 6
    local h = math.floor((bsy - topSize * 2.5 - 32) / n)
    local ts = bsy - topSize * 2.5 - h * n
    local y = topSize
    local w = sightxports.sGui:getTextWidthFont(adCategories[selectedAdCategory][3], "11/Ubuntu-R.ttf") + 24 + 4
    local rect = sightxports.sGui:createGuiElement("rectangle", 0, 0, bsx, y + ts, appInside)
    sightxports.sGui:setGuiBackground(rect, "solid", green)
    local icon = sightxports.sGui:createGuiElement("image", bsx / 2 - w / 2, y + ts / 2 - 12, 24, 24, appInside)
    sightxports.sGui:setImageFile(icon, sightxports.sGui:getFaIconFilename(adCategories[selectedAdCategory][1], 24, adCategories[selectedAdCategory][2]))
    sightxports.sGui:setImageColor(icon, "#ffffff")
    local label = sightxports.sGui:createGuiElement("label", bsx / 2 - w / 2 + 24 + 4, y, bsx, ts, appInside)
    sightxports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
    sightxports.sGui:setLabelAlignment(label, "left", "center")
    sightxports.sGui:setLabelColor(label, "#ffffff")
    sightxports.sGui:setLabelText(label, adCategories[selectedAdCategory][3])
    y = y + ts + 4
    adNameInput = sightxports.sGui:createGuiElement("input", 8, y, bsx - 16, 32, appInside)
    sightxports.sGui:setInputColor(adNameInput, grey3, "#ffffff", "#000000", "#ffffff", "#000000")
    sightxports.sGui:setInputFont(adNameInput, "11/Ubuntu-R.ttf")
    sightxports.sGui:setInputPlaceholder(adNameInput, "Hirdetés címe")
    sightxports.sGui:setInputMaxLength(adNameInput, 24)
    sightxports.sGui:setInputBorderSize(adNameInput, 0.5)
    local border = sightxports.sGui:createGuiElement("hr", 8, y + 32 - 1, bsx - 16, 1, appInside)
    sightxports.sGui:setGuiHrColor(border, grey2, grey2)
    y = y + 32 + 4
    adPriceInput = sightxports.sGui:createGuiElement("input", 8, y, bsx - 16, 32, appInside)
    sightxports.sGui:setInputColor(adPriceInput, grey3, "#ffffff", "#000000", "#ffffff", "#000000")
    sightxports.sGui:setInputFont(adPriceInput, "11/Ubuntu-R.ttf")
    sightxports.sGui:setInputPlaceholder(adPriceInput, "Ár (0 ha ingyenes)")
    sightxports.sGui:setInputMaxLength(adPriceInput, 10)
    sightxports.sGui:setInputNumberOnly(adPriceInput, true)
    sightxports.sGui:setInputBorderSize(adPriceInput, 0.5)
    local border = sightxports.sGui:createGuiElement("hr", 8, y + 32 - 1, bsx - 16, 1, appInside)
    sightxports.sGui:setGuiHrColor(border, grey2, grey2)
    y = y + 32 + 4
    adDescriptionInput = sightxports.sGui:createGuiElement("input", 8, y, bsx - 16, 160, appInside)
    sightxports.sGui:setInputColor(adDescriptionInput, grey3, "#ffffff", "#000000", "#ffffff", "#000000")
    sightxports.sGui:setInputFont(adDescriptionInput, "11/Ubuntu-R.ttf")
    sightxports.sGui:setInputPlaceholder(adDescriptionInput, "Leírás (750 karakter)")
    sightxports.sGui:setInputMaxLength(adDescriptionInput, 750)
    sightxports.sGui:setInputBorderSize(adDescriptionInput, 0.5)
    sightxports.sGui:setInputMultiline(adDescriptionInput, true)
    sightxports.sGui:setInputFontPaddingHeight(adDescriptionInput, 32)
    if adName then
      sightxports.sGui:setInputValue(adNameInput, adName)
    end
    if adPrice then
      sightxports.sGui:setInputValue(adPriceInput, adPrice)
    end
    if adDescription then
      sightxports.sGui:setInputValue(adDescriptionInput, adDescription)
    end
    local border = sightxports.sGui:createGuiElement("hr", 8, y + 160 - 1, bsx - 16, 1, appInside)
    sightxports.sGui:setGuiHrColor(border, grey2, grey2)
    y = y + 160 + 4
    local h = (bsy - y - 8 - topSize * 1.5 - 24 - 8) / 7
    local n = #adCategories[selectedAdCategory][5]
    if 7 < n then
      newAdScrollH = h * 7
      local rect = sightxports.sGui:createGuiElement("rectangle", bsx - 8 - 2, y, 2, newAdScrollH, appInside)
      sightxports.sGui:setGuiBackground(rect, "solid", grey1)
      newAdScrollH = newAdScrollH / (n - 7 + 1)
      newAdScrollBar = sightxports.sGui:createGuiElement("rectangle", 0, 0, 2, newAdScrollH, rect)
      sightxports.sGui:setGuiBackground(newAdScrollBar, "solid", grey3)
    end
    for i = 1, math.min(n, 7) do
      local bbox = sightxports.sGui:createGuiElement("rectangle", 8, y, bsx - 16, h, appInside)
      sightxports.sGui:setGuiBackground(bbox, "solid", {
        0,
        0,
        0,
        0
      })
      sightxports.sGui:setGuiHover(bbox, "none")
      sightxports.sGui:setGuiHoverable(bbox, true)
      local checkbox = sightxports.sGui:createGuiElement("checkbox", 8, y + h / 2 - 12, 24, 24, appInside)
      sightxports.sGui:setGuiColorScheme(checkbox, "darker")
      sightxports.sGui:setGuiBoundingBox(checkbox, bbox)
      sightxports.sGui:setCheckboxColor(checkbox, grey2, "#ffffff", green, "#000000")
      sightxports.sGui:setClickEvent(checkbox, "clickNewAdCheckbox")
      local label = sightxports.sGui:createGuiElement("label", 36, y, bsx - 16 - 24 - 8, h, appInside)
      sightxports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
      sightxports.sGui:setLabelAlignment(label, "left", "center")
      sightxports.sGui:setLabelColor(label, "#000000")
      sightxports.sGui:setLabelClip(label, true)
      sightxports.sGui:setGuiHoverable(label, true)
      sightxports.sGui:setGuiBoundingBox(label, bbox)
      newAdCheckboxes[i] = {checkbox, label}
      y = y + h
    end
    refreshNewAdScroll()
    local border = sightxports.sGui:createGuiElement("hr", 8, y + 4 - 1, bsx - 16, 1, appInside)
    sightxports.sGui:setGuiHrColor(border, grey2, grey2)
    local btn = sightxports.sGui:createGuiElement("button", 8, bsy - topSize * 1.5 - 24 - 4, bsx - 16, 24, appInside)
    sightxports.sGui:setGuiBackground(btn, "solid", blue)
    sightxports.sGui:setGuiHover(btn, "none", blue, false, true)
    sightxports.sGui:setButtonTextColor(btn, "#ffffff")
    sightxports.sGui:setButtonText(btn, "Következő lépés")
    sightxports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
    sightxports.sGui:setClickEvent(btn, "newAdSpecialNext")
  end
  generateBottom(true, "selectAdCategoryEx", true)
  bringBackFront()
end
local hoverCount = 0
addEvent("onAdBigPicClick", false)
addEventHandler("onAdBigPicClick", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  if not singleData.preview and lastSinglePic[1] ~= singleData.id then
    return
  end
  local file = "ads/" .. (singleData.preview and "new" or "current") .. "/1.dds"
  if singleData.image[1] and fileExists(file) then
    sightxports.sGui:setDDSPreview(":sMobile/!mobile_sight/" .. file, "dxt3", false)
  end
end)
addEvent("onSmallPicClick", false)
addEventHandler("onSmallPicClick", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  for i = 1, #singlePics do
    if el == singlePics[i] then
      if not singleData.preview and lastSinglePic[i + 1] ~= singleData.id then
        return
      end
      local file = "ads/" .. (singleData.preview and "new" or "current") .. "/" .. i + 1 .. ".dds"
      if singleData.image[i + 1] and fileExists(file) then
        sightxports.sGui:setDDSPreview(":sMobile/!mobile_sight/" .. file, "dxt3", false)
      end
      return
    end
  end
end)
addEvent("onSmallPicHover", false)
addEventHandler("onSmallPicHover", getRootElement(), function(el, state)
  if state then
    for i = 1, #singlePics do
      if el == singlePics[i] then
        local file = "ads/" .. (singleData.preview and "new" or "current") .. "/" .. i + 1 .. ".dds"
        if singleData.image[i + 1] and fileExists(file) then
          sightxports.sGui:setImageDDS(singleBigPic, ":sMobile/!mobile_sight/" .. file, "dxt3", false)
          break
        end
        sightxports.sGui:setImageFile(singleBigPic, loadedTextures["files/img/" .. (requestedSinglePics[i] and "camload" or "cam") .. ".png"])
        break
      end
    end
    hoverCount = hoverCount + 1
  else
    hoverCount = hoverCount - 1
    if hoverCount <= 0 then
      hoverCount = 0
      local file = "ads/" .. (singleData.preview and "new" or "current") .. "/1.dds"
      if singleData.image[1] and fileExists(file) then
        sightxports.sGui:setImageDDS(singleBigPic, ":sMobile/!mobile_sight/" .. file, "dxt3", false)
      else
        sightxports.sGui:setImageFile(singleBigPic, loadedTextures["files/img/" .. (requestedSinglePics[1] and "camload" or "cam") .. ".png"])
      end
    end
  end
end)
addEvent("setNewAdTime", false)
addEventHandler("setNewAdTime", getRootElement(), function(el, sliderValue, final)
  adTime = math.floor(minimumAdTime + (maximumAdTime - minimumAdTime) * sliderValue + 0.5)
  sightxports.sGui:setLabelText(specialAdLabels.adTime, adTime .. " óra")
  sightxports.sGui:setLabelText(specialAdLabels.adPrice, sightxports.sGui:thousandsStepper(adTime * adPricePerHour) .. " $")
end)
addEvent("newAdResponse", true)
addEventHandler("newAdResponse", getRootElement(), function(error, id)
  if mobileState then
    tryingToPostAd = false
    newAdError = error
    newAdId = id
    if not newAdError then
      adName = false
      adPrice = false
      adDescription = false
      adSubcat = false
      adSubcatCat = false
      specialData = false
      for i = 1, 4 do
        if fileExists("ads/new/" .. i .. ".dds") then
          fileDelete("ads/new/" .. i .. ".dds")
        end
        if fileExists("ads/new/" .. i .. "_t.dds") then
          fileDelete("ads/new/" .. i .. "_t.dds")
        end
        if fileExists("ads/new/" .. i .. ".sight") then
          fileDelete("ads/new/" .. i .. ".sight")
        end
        if fileExists("ads/new/" .. i .. "_t.sight") then
          fileDelete("ads/new/" .. i .. "_t.sight")
        end
        if fileExists("ads/new/" .. i .. ".sight2") then
          fileDelete("ads/new/" .. i .. ".sight2")
        end
        if fileExists("ads/new/" .. i .. "_t.sight2") then
          fileDelete("ads/new/" .. i .. "_t.sight2")
        end
      end
    end
    switchAppScreen("ad_new_result", true)
  end
end)
addEvent("finalNewAd", false)
addEventHandler("finalNewAd", getRootElement(), function()
  if not tryingToPostAd and selectedAdCategory and adCategories[selectedAdCategory] then
    tryingToPostAd = true
    newAdError = false
    newAdId = false
    local photoData = {}
    for i = 1, 4 do
      if fileExists("ads/new/" .. i .. ".dds") then
        local continue = true
        photoData[i] = {}
        if i == 1 then
          if fileExists("ads/new/" .. i .. "_t.dds") then
            local file = fileOpen("ads/new/" .. i .. "_t.dds", true)
            if file then
              photoData[i][4] = fileRead(file, fileGetSize(file))
              fileClose(file)
            end
            if fileExists("ads/new/" .. i .. "_t.sight") then
              local file = fileOpen("ads/new/" .. i .. "_t.sight", true)
              if file then
                photoData[i][5] = fileRead(file, fileGetSize(file))
                fileClose(file)
              end
            end
            if fileExists("ads/new/" .. i .. "_t.sight2") then
              local file = fileOpen("ads/new/" .. i .. "_t.sight2", true)
              if file then
                photoData[i][6] = fileRead(file, fileGetSize(file))
                fileClose(file)
              end
            end
          else
            continue = false
          end
        end
        if not continue then
          photoData[i] = nil
        else
          local file = fileOpen("ads/new/" .. i .. ".dds", true)
          if file then
            photoData[i][1] = fileRead(file, fileGetSize(file))
            fileClose(file)
          end
          if fileExists("ads/new/" .. i .. ".sight") then
            local file = fileOpen("ads/new/" .. i .. ".sight", true)
            if file then
              photoData[i][2] = fileRead(file, fileGetSize(file))
              fileClose(file)
            end
          end
          if fileExists("ads/new/" .. i .. ".sight2") then
            local file = fileOpen("ads/new/" .. i .. ".sight2", true)
            if file then
              photoData[i][3] = fileRead(file, fileGetSize(file))
              fileClose(file)
            end
          end
        end
      end
    end
    triggerLatentServerEvent("tryToPostAd", 500000, localPlayer, selectedAdCategory, adSubcat, adName, adPrice, adDescription, photoData, adTime, specialData)
    photoData = nil
    collectgarbage("collect")
    switchAppScreen("ad_new_trying", true)
  end
end)
function appScreens.ad_new_trying()
  appInside = sightxports.sGui:createGuiElement("null", 0, 0, bsx, bsy, mobileBackground)
  if selectedAdCategory and adCategories[selectedAdCategory] then
    local rect = sightxports.sGui:createGuiElement("rectangle", 0, 0, bsx, bsy, appInside)
    sightxports.sGui:setGuiBackground(rect, "solid", {
      255,
      255,
      255
    })
    local n = 6
    local h = math.floor((bsy - topSize * 2.5 - 32) / n)
    local ts = bsy - topSize * 2.5 - h * n
    local y = topSize
    local w = sightxports.sGui:getTextWidthFont(adCategories[selectedAdCategory][3], "11/Ubuntu-R.ttf") + 24 + 4
    local rect = sightxports.sGui:createGuiElement("rectangle", 0, 0, bsx, y + ts, appInside)
    sightxports.sGui:setGuiBackground(rect, "solid", green)
    local icon = sightxports.sGui:createGuiElement("image", bsx / 2 - w / 2, y + ts / 2 - 12, 24, 24, appInside)
    sightxports.sGui:setImageFile(icon, sightxports.sGui:getFaIconFilename(adCategories[selectedAdCategory][1], 24, adCategories[selectedAdCategory][2]))
    sightxports.sGui:setImageColor(icon, "#ffffff")
    local label = sightxports.sGui:createGuiElement("label", bsx / 2 - w / 2 + 24 + 4, y, bsx, ts, appInside)
    sightxports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
    sightxports.sGui:setLabelAlignment(label, "left", "center")
    sightxports.sGui:setLabelColor(label, "#ffffff")
    sightxports.sGui:setLabelText(label, adCategories[selectedAdCategory][3])
    y = y + ts
    local label = sightxports.sGui:createGuiElement("label", 0, y, bsx, 64, appInside)
    sightxports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
    sightxports.sGui:setLabelAlignment(label, "center", "center")
    sightxports.sGui:setLabelColor(label, "#000000")
    sightxports.sGui:setLabelText(label, "Hirdetés feladása\nfolyamatban...")
  end
  bringBackFront()
end
function appScreens.ad_new_result()
  appInside = sightxports.sGui:createGuiElement("null", 0, 0, bsx, bsy, mobileBackground)
  if selectedAdCategory and adCategories[selectedAdCategory] then
    local rect = sightxports.sGui:createGuiElement("rectangle", 0, 0, bsx, bsy, appInside)
    sightxports.sGui:setGuiBackground(rect, "solid", {
      255,
      255,
      255
    })
    local n = 6
    local h = math.floor((bsy - topSize * 2.5 - 32) / n)
    local ts = bsy - topSize * 2.5 - h * n
    local y = topSize
    local w = sightxports.sGui:getTextWidthFont(adCategories[selectedAdCategory][3], "11/Ubuntu-R.ttf") + 24 + 4
    local rect = sightxports.sGui:createGuiElement("rectangle", 0, 0, bsx, y + ts, appInside)
    sightxports.sGui:setGuiBackground(rect, "solid", green)
    local icon = sightxports.sGui:createGuiElement("image", bsx / 2 - w / 2, y + ts / 2 - 12, 24, 24, appInside)
    sightxports.sGui:setImageFile(icon, sightxports.sGui:getFaIconFilename(adCategories[selectedAdCategory][1], 24, adCategories[selectedAdCategory][2]))
    sightxports.sGui:setImageColor(icon, "#ffffff")
    local label = sightxports.sGui:createGuiElement("label", bsx / 2 - w / 2 + 24 + 4, y, bsx, ts, appInside)
    sightxports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
    sightxports.sGui:setLabelAlignment(label, "left", "center")
    sightxports.sGui:setLabelColor(label, "#ffffff")
    sightxports.sGui:setLabelText(label, adCategories[selectedAdCategory][3])
    y = y + ts
    local label = sightxports.sGui:createGuiElement("label", 0, y + 8, bsx, 128, appInside)
    sightxports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
    sightxports.sGui:setLabelAlignment(label, "center", "top")
    sightxports.sGui:setLabelColor(label, "#000000")
    if newAdError then
      sightxports.sGui:setLabelText(label, "Hirdetés feladása sikertelen!\n\n" .. newAdError)
    else
      sightxports.sGui:setLabelText(label, "Hirdetés feladása sikeres!")
      y = y + sightxports.sGui:getFontHeight("11/Ubuntu-R.ttf") + 8 + 8
      if newAdId then
        local btn = sightxports.sGui:createGuiElement("button", 8, y, bsx - 16, 24, appInside)
        sightxports.sGui:setGuiBackground(btn, "solid", green)
        sightxports.sGui:setGuiHover(btn, "none", green, false, true)
        sightxports.sGui:setButtonTextColor(btn, "#ffffff")
        sightxports.sGui:setButtonText(btn, "Hirdetés megtekintése")
        sightxports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
        sightxports.sGui:setClickEvent(btn, "openNewAd")
      end
    end
  end
  if newAdError then
    generateBottom(true, "selectAdPhotoEx", true)
  else
    generateBottom(true, "selectAdCategory", true)
  end
  bringBackFront()
end
function appScreens.ad_highlight_2()
  appInside = sightxports.sGui:createGuiElement("null", 0, 0, bsx, bsy, mobileBackground)
  local rect = sightxports.sGui:createGuiElement("rectangle", 0, 0, bsx, bsy, appInside)
  sightxports.sGui:setGuiBackground(rect, "solid", {
    255,
    255,
    255
  })
  local h = 32 + sightxports.sGui:getFontHeight("11/Ubuntu-L.ttf") * 1 + 8
  local w = bsx * 0.85
  local rect = sightxports.sGui:createGuiElement("null", bsx / 2 - w / 2, topSize + (bsy - topSize * 2.5) / 2 - h / 2, w, h, appInside)
  local label = sightxports.sGui:createGuiElement("label", 0, 0, w, h - 24 - 4 - 4, rect)
  sightxports.sGui:setLabelAlignment(label, "center", "center")
  sightxports.sGui:setLabelText(label, "Nincs elég PrémiumPontod!")
  sightxports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
  sightxports.sGui:setLabelColor(label, "#000000")
  local btn = sightxports.sGui:createGuiElement("button", w / 2 - w / 4 / 2, h - 24 - 4, w / 4, 24, rect)
  sightxports.sGui:setGuiBackground(btn, "solid", green)
  sightxports.sGui:setGuiHover(btn, "none", green, false, true)
  sightxports.sGui:setButtonTextColor(btn, "#ffffff")
  sightxports.sGui:setButtonText(btn, "Ok")
  sightxports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
  sightxports.sGui:setClickEvent(btn, "backToSingleAd")
  generateBottom(true, "backToSingleAd", true)
  bringBackFront()
end
function appScreens.ad_highlight()
  appInside = sightxports.sGui:createGuiElement("null", 0, 0, bsx, bsy, mobileBackground)
  local rect = sightxports.sGui:createGuiElement("rectangle", 0, 0, bsx, bsy, appInside)
  sightxports.sGui:setGuiBackground(rect, "solid", {
    255,
    255,
    255
  })
  local h = 32 + sightxports.sGui:getFontHeight("11/Ubuntu-L.ttf") * 7 + 8
  local w = bsx * 0.85
  local rect = sightxports.sGui:createGuiElement("null", bsx / 2 - w / 2, topSize + (bsy - topSize * 2.5) / 2 - h / 2, w, h, appInside)
  local label = sightxports.sGui:createGuiElement("label", 0, 0, w, h - 24 - 4 - 4, rect)
  sightxports.sGui:setLabelAlignment(label, "center", "center")
  sightxports.sGui:setLabelText(label, "Biztosan szeretnéd\nkiemelni a hirdetést?\n\nKiemelés ára: " .. sightxports.sGui:thousandsStepper(adHighlightPrice) .. [[
 PP
PP egyenleg: ]] .. sightxports.sGui:thousandsStepper(ppBalance) .. " PP\n\nKiemelés időtartama: " .. highlightTime .. " óra")
  sightxports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
  sightxports.sGui:setLabelColor(label, "#000000")
  local btn = sightxports.sGui:createGuiElement("button", 4, h - 24 - 4, w / 2 - 6, 24, rect)
  sightxports.sGui:setGuiBackground(btn, "solid", green)
  sightxports.sGui:setGuiHover(btn, "none", green, false, true)
  sightxports.sGui:setButtonTextColor(btn, "#ffffff")
  sightxports.sGui:setButtonText(btn, "Igen")
  sightxports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
  sightxports.sGui:setClickEvent(btn, "finalHighlightAd")
  local btn = sightxports.sGui:createGuiElement("button", w - w / 2 + 2, h - 24 - 4, w / 2 - 6, 24, rect)
  sightxports.sGui:setGuiBackground(btn, "solid", red)
  sightxports.sGui:setGuiHover(btn, "none", red, false, true)
  sightxports.sGui:setButtonTextColor(btn, "#ffffff")
  sightxports.sGui:setButtonText(btn, "Nem")
  sightxports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
  sightxports.sGui:setClickEvent(btn, "backToSingleAd")
  generateBottom(true, "backToSingleAd", true)
  bringBackFront()
end
function appScreens.ad_delete()
  appInside = sightxports.sGui:createGuiElement("null", 0, 0, bsx, bsy, mobileBackground)
  local rect = sightxports.sGui:createGuiElement("rectangle", 0, 0, bsx, bsy, appInside)
  sightxports.sGui:setGuiBackground(rect, "solid", {
    255,
    255,
    255
  })
  local h = 32 + sightxports.sGui:getFontHeight("11/Ubuntu-L.ttf") * 2 + 8
  local w = bsx * 0.8
  local rect = sightxports.sGui:createGuiElement("null", bsx / 2 - w / 2, topSize + (bsy - topSize * 2.5) / 2 - h / 2, w, h, appInside)
  local label = sightxports.sGui:createGuiElement("label", 0, 0, w, h - 24 - 4 - 4, rect)
  sightxports.sGui:setLabelAlignment(label, "center", "center")
  sightxports.sGui:setLabelText(label, "Biztosan szeretnéd\ntörölni a hirdetést?")
  sightxports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
  sightxports.sGui:setLabelColor(label, "#000000")
  local btn = sightxports.sGui:createGuiElement("button", 4, h - 24 - 4, w / 2 - 6, 24, rect)
  sightxports.sGui:setGuiBackground(btn, "solid", green)
  sightxports.sGui:setGuiHover(btn, "none", green, false, true)
  sightxports.sGui:setButtonTextColor(btn, "#ffffff")
  sightxports.sGui:setButtonText(btn, "Igen")
  sightxports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
  sightxports.sGui:setClickEvent(btn, "finalDeleteAd")
  local btn = sightxports.sGui:createGuiElement("button", w - w / 2 + 2, h - 24 - 4, w / 2 - 6, 24, rect)
  sightxports.sGui:setGuiBackground(btn, "solid", red)
  sightxports.sGui:setGuiHover(btn, "none", red, false, true)
  sightxports.sGui:setButtonTextColor(btn, "#ffffff")
  sightxports.sGui:setButtonText(btn, "Nem")
  sightxports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
  sightxports.sGui:setClickEvent(btn, "backToSingleAd")
  generateBottom(true, "backToSingleAd", true)
  bringBackFront()
end
local deletingAd = false
local highlightingAd = false
addEvent("finalDeleteAd", false)
addEventHandler("finalDeleteAd", getRootElement(), function()
  if not deletingAd then
    deletingAd = true
    triggerServerEvent("tryToDeleteAd", localPlayer, singleData.id, selectedAdCategory)
  end
end)
addEvent("finalHighlightAd", false)
addEventHandler("finalHighlightAd", getRootElement(), function()
  if not highlightingAd then
    highlightingAd = true
    triggerServerEvent("tryToHighlightAd", localPlayer, singleData.id)
  end
end)
addEvent("highlightAdNoPP", false)
addEventHandler("highlightAdNoPP", getRootElement(), function()
  highlightingAd = false
  switchAppScreen("ad_highlight_2", true)
end)
local favoriteIcon = false
addEvent("toggleMobileAdFavorite", false)
addEventHandler("toggleMobileAdFavorite", getRootElement(), function()
  if favoriteAds[singleData.id] then
    favoriteAds[singleData.id] = nil
    saveFavoriteAds()
  else
    favoriteAds[singleData.id] = true
    if fileExists("ads/favorite.sight") then
      local file = fileOpen("ads/favorite.sight")
      if file then
        fileWrite(file, singleData.id .. "\n")
        fileClose(file)
      end
    else
      saveFavoriteAds()
    end
  end
  sightxports.sGui:setImageFile(favoriteIcon, sightxports.sGui:getFaIconFilename("star", 28, favoriteAds[singleData.id] and "solid" or "regular"))
end)
function saveFavoriteAds()
  if fileExists("ads/favorite.sight") then
    fileDelete("ads/favorite.sight")
  end
  local file = fileCreate("ads/favorite.sight")
  if file then
    for k in pairs(favoriteAds) do
      if k >= smallestAdId then
        fileWrite(file, k .. "\n")
      else
        favoriteAds[k] = nil
      end
    end
    fileClose(file)
  end
end
addEvent("gotSingleAdImage", true)
addEventHandler("gotSingleAdImage", getRootElement(), function(id, i, data)
  requestedSinglePics[i] = nil
  lastSinglePic[i] = data and id or false
  if fileExists("ads/current/" .. i .. ".dds") then
    fileDelete("ads/current/" .. i .. ".dds")
  end
  if data then
    local file = fileCreate("ads/current/" .. i .. ".dds")
    if file then
      fileWrite(file, data)
      fileClose(file)
      if currentPhoneScreen == "ad_single" then
        if singleData and singleData.id == id then
          local file = "ads/current/" .. i .. ".dds"
          sightxports.sGui:resetImageDDS(":sMobile/!mobile_sight/" .. file)
          sightxports.sGui:setImageDDS(i == 1 and singleBigPic or singlePics[i - 1], ":sMobile/!mobile_sight/" .. file, "dxt3", false)
        elseif singleData and not singleData.preview and singleData.image[i] then
          requestedSinglePics[i] = true
        end
      end
    end
  end
  requestNextSingleAdImage()
end)
function requestNextSingleAdImage()
  for i in pairs(requestedSinglePics) do
    if singleData and not singleData.preview then
      if i then
        local file = "ads/current/" .. i .. ".dds"
        if lastSinglePic[i] == singleData.id then
          requestedSinglePics[i] = nil
          requestNextSingleAdImage()
          return
        end
        if fileExists(file) then
          fileDelete(file)
        end
        triggerServerEvent("requestSingleAdImage", localPlayer, singleData.id, i)
      else
        requestedSinglePics[i] = nil
        requestNextSingleAdImage()
      end
    else
      requestedSinglePics = {}
    end
  end
end
function appCloses.ad_single()
  removeEventHandler("onClientKey", getRootElement(), singleScrollKey)
  requestedSinglePics = {}
end
function appScreens.ad_single()
  local charId = getElementData(localPlayer, "char.ID")
  if not singleData.preview then
    requestedSinglePics = {}
    for i = 1, 4 do
      if singleData.image[i] and lastSinglePic[i] ~= singleData.id then
        if fileExists("ads/current/" .. i .. ".dds") then
          fileDelete("ads/current/" .. i .. ".dds")
        end
        lastSinglePic[i] = nil
      end
    end
  end
  highlightingAd = false
  hoverCount = 0
  singleScroll = 0
  appInside = sightxports.sGui:createGuiElement("null", 0, 0, bsx, bsy, mobileBackground)
  local rect = sightxports.sGui:createGuiElement("rectangle", 0, 0, bsx, bsy, appInside)
  sightxports.sGui:setGuiBackground(rect, "solid", {
    255,
    255,
    255
  })
  local y = topSize + 4
  local iw = bsx - 16
  singleBigPic = false
  if singleData.image[1] or singleData.image[2] or singleData.image[3] or singleData.image[4] then
    singleBigPic = sightxports.sGui:createGuiElement("image", 8, y, iw, iw, appInside)
    sightxports.sGui:setGuiHoverable(singleBigPic, true)
    sightxports.sGui:setGuiHover(singleBigPic, "none", false, false, true)
    sightxports.sGui:setClickEvent(singleBigPic, "onAdBigPicClick")
    sightxports.sGui:setImageUV(singleBigPic, 0, 0, 512, 512)
    local file = "ads/" .. (singleData.preview and "new" or "current") .. "/1.dds"
    if singleData.image[1] and fileExists(file) then
      sightxports.sGui:setImageDDS(singleBigPic, ":sMobile/!mobile_sight/" .. file, "dxt3", false)
    elseif not singleData.preview and singleData.image[1] then
      requestedSinglePics[1] = true
      sightxports.sGui:setImageFile(singleBigPic, loadedTextures["files/img/camload.png"])
    else
      sightxports.sGui:setImageFile(singleBigPic, loadedTextures["files/img/cam.png"])
    end
    singleBigPicY = y
    y = y + iw + 4
  end
  singleElements = {}
  singlePics = {}
  singlePicY = 0
  if singleData.image[2] or singleData.image[3] or singleData.image[4] then
    iw = (iw - 8) / 3
    local bbox = sightxports.sGui:createGuiElement("null", 8, y, iw + 2, iw, appInside)
    table.insert(singleElements, {bbox, y})
    local img = sightxports.sGui:createGuiElement("image", 8, y, iw, iw, appInside)
    local file = "ads/" .. (singleData.preview and "new" or "current") .. "/2.dds"
    if singleData.image[2] and fileExists(file) then
      sightxports.sGui:setImageDDS(img, ":sMobile/!mobile_sight/" .. file, "dxt3", false)
    elseif not singleData.preview and singleData.image[2] then
      requestedSinglePics[2] = true
      sightxports.sGui:setImageFile(img, loadedTextures["files/img/camload.png"])
    else
      sightxports.sGui:setImageFile(img, loadedTextures["files/img/cam.png"])
    end
    sightxports.sGui:setClickEvent(img, "onSmallPicClick")
    sightxports.sGui:setHoverEvent(img, "onSmallPicHover")
    sightxports.sGui:setGuiHoverable(img, true)
    sightxports.sGui:setGuiHover(img, "none", false, false, true)
    sightxports.sGui:setGuiBoundingBox(img, bbox)
    sightxports.sGui:setImageUV(img, 0, 0, 512, 512)
    table.insert(singlePics, img)
    local bbox = sightxports.sGui:createGuiElement("null", 8 + iw + 4 - 2, y, iw + 4, iw, appInside)
    table.insert(singleElements, {bbox, y})
    local img = sightxports.sGui:createGuiElement("image", 8 + iw + 4, y, iw, iw, appInside)
    local file = "ads/" .. (singleData.preview and "new" or "current") .. "/3.dds"
    if singleData.image[3] and fileExists(file) then
      sightxports.sGui:setImageDDS(img, ":sMobile/!mobile_sight/" .. file, "dxt3", false)
    elseif not singleData.preview and singleData.image[3] then
      requestedSinglePics[3] = true
      sightxports.sGui:setImageFile(img, loadedTextures["files/img/camload.png"])
    else
      sightxports.sGui:setImageFile(img, loadedTextures["files/img/cam.png"])
    end
    sightxports.sGui:setClickEvent(img, "onSmallPicClick")
    sightxports.sGui:setHoverEvent(img, "onSmallPicHover")
    sightxports.sGui:setGuiHoverable(img, true)
    sightxports.sGui:setGuiHover(img, "none", false, false, true)
    sightxports.sGui:setGuiBoundingBox(img, bbox)
    sightxports.sGui:setImageUV(img, 0, 0, 512, 512)
    table.insert(singlePics, img)
    local bbox = sightxports.sGui:createGuiElement("null", 8 + iw * 2 + 8 - 2, y, iw + 2, iw, appInside)
    table.insert(singleElements, {bbox, y})
    local img = sightxports.sGui:createGuiElement("image", 8 + iw * 2 + 8, y, iw, iw, appInside)
    local file = "ads/" .. (singleData.preview and "new" or "current") .. "/4.dds"
    if singleData.image[4] and fileExists(file) then
      sightxports.sGui:setImageDDS(img, ":sMobile/!mobile_sight/" .. file, "dxt3", false)
    elseif not singleData.preview and singleData.image[4] then
      requestedSinglePics[4] = true
      sightxports.sGui:setImageFile(img, loadedTextures["files/img/camload.png"])
    else
      sightxports.sGui:setImageFile(img, loadedTextures["files/img/cam.png"])
    end
    sightxports.sGui:setClickEvent(img, "onSmallPicClick")
    sightxports.sGui:setHoverEvent(img, "onSmallPicHover")
    sightxports.sGui:setGuiHoverable(img, true)
    sightxports.sGui:setGuiHover(img, "none", false, false, true)
    sightxports.sGui:setGuiBoundingBox(img, bbox)
    sightxports.sGui:setImageUV(img, 0, 0, 512, 512)
    table.insert(singlePics, img)
    singlePicY = y
    y = y + iw + 4
  end
  if not singleData.preview then
    requestNextSingleAdImage()
  end
  adLabelH = sightxports.sGui:getFontHeight("11/Ubuntu-R.ttf")
  singleTopY = y
  y = y + 32
  if singleData.highlight then
    y = createAdLabel(y, "Kiemelt hirdetés!")
    if singleData.highlightTime and singleData.senderCharId == charId then
      local time = getRealTime(singleData.highlightTime)
      local date = string.format("%04d. %02d. %02d. %02d:%02d:%02d", time.year + 1900, time.month + 1, time.monthday, time.hour, time.minute, time.second)
      y = createAdLabel(y, "Lejár:", date)
    end
  end
  y = createTopAdLabel(y, "Hirdetés adatai:")
  if singleData.id then
    y = createAdLabel(y, "Azonosító:", singleData.id)
  end
  if tonumber(singleData.price) then
    if 0 >= singleData.price then
      y = createAdLabel(y, "Ár:", "Ingyenes")
    else
      y = createAdLabel(y, "Ár:", sightxports.sGui:thousandsStepper(singleData.price) .. " $")
    end
  end
  y = createAdLabel(y, "Hirdető:", singleData.senderName)
  y = createAdLabel(y, "Elérhetőség:", formatPhoneNumber(singleData.phoneNumber))
  if singleData.online then
    y = createAdLabel(y, "Jelenleg elérhető!", false, false, green)
  end
  if singleData.created then
    local time = getRealTime(singleData.created)
    local date = string.format("%04d. %02d. %02d. %02d:%02d:%02d", time.year + 1900, time.month + 1, time.monthday, time.hour, time.minute, time.second)
    y = createAdLabel(y, "Feladva:", date)
  end
  if singleData.expire and singleData.senderCharId == charId then
    local time = getRealTime(singleData.expire)
    local date = string.format("%04d. %02d. %02d. %02d:%02d", time.year + 1900, time.month + 1, time.monthday, time.hour, math.floor(time.minute / 10) * 10)
    y = createAdLabel(y, "Érvényes:", date)
  end
  y = createAdLabel(y, "Kategória:", adCategories[singleData.category][3])
  y = createAdLabel(y, "Alkategória:", adCategories[singleData.category][5][singleData.subCategory])
  if singleData.specialData and singleData.specialData[1] == "item" then
    y = createTopAdLabel(y, "Tárgy:")
    y = createAdLabel(y, "Név:", singleData.specialData[2])
    local w1 = sightxports.sGui:getTextWidthFont("Leírás:", "11/Ubuntu-R.ttf")
    local w = w1 + sightxports.sGui:getTextWidthFont(" ", "11/Ubuntu-R.ttf") + sightxports.sGui:getTextWidthFont(singleData.specialData[3], "11/Ubuntu-L.ttf")
    if w + 8 > bsx - 16 then
      local description = split("Leírás: " .. singleData.specialData[3], " ")
      local text = ""
      createAdLabel(y, "Leírás:")
      local plus = w1
      for i = 2, #description do
        local w = plus + sightxports.sGui:getTextWidthFont(text .. " " .. description[i], "11/Ubuntu-L.ttf")
        if w > bsx - 16 then
          y = createAdLabelEx(y, text, plus)
          text = description[i]
          plus = 0
        else
          text = text .. " " .. description[i]
        end
      end
      y = createAdLabelEx(y, text)
    else
      y = createAdLabel(y, "Leírás:", singleData.specialData[3])
    end
    y = createAdLabel(y, "Mennyiség:", singleData.specialData[5])
    if singleData.specialData[6] then
      y = createAdLabel(y, "Névcédula:", singleData.specialData[6])
    end
    if singleData.specialData[7] and 0 < singleData.specialData[7] then
      y = createAdLabel(y, "Sorozatszám:", sightxports.sItems:formatSerial(singleData.specialData[4], singleData.specialData[7]))
    end
  end
  if singleData.description then
    y = createTopAdLabel(y, "Leírás:")
    local description = split(singleData.description, " ")
    local text = description[1]
    for i = 2, #description do
      local w = sightxports.sGui:getTextWidthFont(text .. " " .. description[i], "11/Ubuntu-L.ttf")
      if w > bsx - 16 then
        y = createAdLabelEx(y, text)
        text = description[i]
      else
        text = text .. " " .. description[i]
      end
    end
    y = createAdLabelEx(y, text)
  end
  y = y + 8
  local ry = y
  local hide = false
  if ry > bsy - topSize * 1.5 then
    ry = bsy - topSize * 1.5
    hide = true
  end
  local border = sightxports.sGui:createGuiElement("hr", 0, ry, bsx, 1, appInside)
  sightxports.sGui:setGuiHrColor(border, grey2, grey2)
  table.insert(singleElements, {border, y})
  sightxports.sGui:setGuiRenderDisabled(border, hide)
  y = y + 8
  if singleData.preview then
    adTime = minimumAdTime
    y = createAdLabel(y, "Hirdetés ideje:", minimumAdTime .. " óra", "adTime")
    y = y + 4
    ry = y
    hide = false
    if ry > bsy - topSize * 1.5 then
      ry = bsy - topSize * 1.5
      hide = true
    end
    local slider = sightxports.sGui:createGuiElement("slider", 8, ry, bsx - 16, 10, appInside)
    sightxports.sGui:setSliderChangeEvent(slider, "setNewAdTime")
    sightxports.sGui:setSliderColor(slider, grey3, green)
    table.insert(singleElements, {slider, y})
    y = y + 10 + 4
    y = createAdLabel(y, "Hirdetés ára:", sightxports.sGui:thousandsStepper(minimumAdTime * adPricePerHour) .. " $", "adPrice")
    y = y + 4
    ry = y
    hide = false
    if ry > bsy - topSize * 1.5 then
      ry = bsy - topSize * 1.5
      hide = true
    end
    local btn = sightxports.sGui:createGuiElement("button", 8, ry, bsx - 16, 24, appInside)
    sightxports.sGui:setGuiBackground(btn, "solid", green)
    sightxports.sGui:setGuiHover(btn, "none", green, false, true)
    sightxports.sGui:setButtonTextColor(btn, "#ffffff")
    sightxports.sGui:setButtonText(btn, "Hirdetés feladása")
    sightxports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
    sightxports.sGui:setClickEvent(btn, "finalNewAd")
    table.insert(singleElements, {
      btn,
      y,
      24
    })
    sightxports.sGui:setGuiRenderDisabled(btn, hide)
    sightxports.sGui:setGuiHoverable(btn, not hide)
    y = y + 24 + 4
  else
    y = y + 4
    if currentMobileNumber ~= tonumber(singleData.phoneNumber) then
      ry = y
      hide = false
      if ry > bsy - topSize * 1.5 then
        ry = bsy - topSize * 1.5
        hide = true
      end
      local btn = sightxports.sGui:createGuiElement("button", 8, ry, bsx - 16, 24, appInside)
      sightxports.sGui:setGuiBackground(btn, "solid", blue)
      sightxports.sGui:setGuiHover(btn, "none", blue, false, true)
      sightxports.sGui:setButtonTextColor(btn, "#ffffff")
      sightxports.sGui:setButtonText(btn, "Hirdető hívása")
      sightxports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
      sightxports.sGui:setClickEvent(btn, "callAd")
      table.insert(singleElements, {
        btn,
        y,
        24
      })
      sightxports.sGui:setGuiRenderDisabled(btn, hide)
      sightxports.sGui:setGuiHoverable(btn, ry + 24 < bsy - topSize * 1.5)
      y = y + 24 + 4
      ry = y
      hide = false
      if ry > bsy - topSize * 1.5 then
        ry = bsy - topSize * 1.5
        hide = true
      end
      local btn = sightxports.sGui:createGuiElement("button", 8, ry, bsx - 16, 24, appInside)
      sightxports.sGui:setGuiBackground(btn, "solid", blue)
      sightxports.sGui:setGuiHover(btn, "none", blue, false, true)
      sightxports.sGui:setButtonTextColor(btn, "#ffffff")
      sightxports.sGui:setButtonText(btn, "SMS küldése a hirdetőnek")
      sightxports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
      sightxports.sGui:setClickEvent(btn, "smsAd")
      table.insert(singleElements, {
        btn,
        y,
        24
      })
      sightxports.sGui:setGuiRenderDisabled(btn, hide)
      sightxports.sGui:setGuiHoverable(btn, ry + 24 < bsy - topSize * 1.5)
      y = y + 24 + 4
    end
    if singleData.senderCharId == charId and not singleData.highlight then
      ry = y
      hide = false
      if ry > bsy - topSize * 1.5 then
        ry = bsy - topSize * 1.5
        hide = true
      end
      local btn = sightxports.sGui:createGuiElement("button", 8, ry, bsx - 16, 24, appInside)
      sightxports.sGui:setGuiBackground(btn, "solid", green)
      sightxports.sGui:setGuiHover(btn, "none", green, false, true)
      sightxports.sGui:setButtonTextColor(btn, "#ffffff")
      sightxports.sGui:setButtonText(btn, "Hirdetés kiemelése")
      sightxports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
      sightxports.sGui:setClickEvent(btn, "highlightAd")
      table.insert(singleElements, {
        btn,
        y,
        24
      })
      sightxports.sGui:setGuiRenderDisabled(btn, hide)
      sightxports.sGui:setGuiHoverable(btn, ry + 24 < bsy - topSize * 1.5)
      y = y + 24 + 4
    end
    if singleData.senderCharId == charId or sightxports.sPermission:hasPermission(localPlayer, "deleteAds") and not getElementData(localPlayer, "urmaChat") then
      ry = y
      hide = false
      if ry > bsy - topSize * 1.5 then
        ry = bsy - topSize * 1.5
        hide = true
      end
      local btn = sightxports.sGui:createGuiElement("button", 8, ry, bsx - 16, 24, appInside)
      sightxports.sGui:setGuiBackground(btn, "solid", red)
      sightxports.sGui:setGuiHover(btn, "none", red, false, true)
      sightxports.sGui:setButtonTextColor(btn, "#ffffff")
      sightxports.sGui:setButtonText(btn, "Hirdetés törlése")
      sightxports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
      sightxports.sGui:setClickEvent(btn, "deleteAd")
      table.insert(singleElements, {
        btn,
        y,
        24
      })
      sightxports.sGui:setGuiRenderDisabled(btn, hide)
      sightxports.sGui:setGuiHoverable(btn, ry + 24 < bsy - topSize * 1.5)
      y = y + 24 + 4
    end
  end
  singleLastY = y + 8
  addEventHandler("onClientKey", getRootElement(), singleScrollKey)
  local ty = singleTopY - topSize
  if 0 > ty + topSize then
    ty = 0
  end
  singleTop = sightxports.sGui:createGuiElement("rectangle", 0, ty, bsx, 32 + topSize, appInside)
  if ty <= 0 then
    sightxports.sGui:setGuiBackground(singleTop, "solid", {
      255,
      255,
      255
    })
  else
    sightxports.sGui:setGuiBackground(singleTop, "solid", {
      255,
      255,
      255,
      0
    })
  end
  local label = sightxports.sGui:createGuiElement("label", 8, topSize, bsx - (singleData.preview and 16 or 36), 32, singleTop)
  sightxports.sGui:setLabelFont(label, "11/Ubuntu-B.ttf")
  sightxports.sGui:setLabelAlignment(label, "left", "center")
  sightxports.sGui:setLabelColor(label, "#000000")
  sightxports.sGui:setLabelText(label, singleData.title)
  sightxports.sGui:setLabelClip(label, true)
  if not singleData.preview then
    favoriteIcon = sightxports.sGui:createGuiElement("image", bsx - 4 - 32, topSize + 16 - 14, 28, 28, singleTop)
    sightxports.sGui:setImageColor(favoriteIcon, "#000000")
    sightxports.sGui:setImageFile(favoriteIcon, sightxports.sGui:getFaIconFilename("star", 28, favoriteAds[singleData.id] and "solid" or "regular"))
    sightxports.sGui:setGuiHoverable(favoriteIcon, true)
    sightxports.sGui:setClickEvent(favoriteIcon, "toggleMobileAdFavorite")
  end
  if singleData.preview then
    generateBottom(true, "selectAdPhotoEx", true)
  elseif adHighlighted then
    adHighlighted = false
    generateBottom(true, "selectAdCategory", true)
  elseif newAdId then
    newAdId = false
    generateBottom(true, "selectAdCategory", true)
  else
    generateBottom(true, "selectAdCategoryEx", true)
  end
  bringBackFront()
end
function refreshCatScrollNextFrame()
  if currentPhoneScreen == "ad_category" then
    refreshCategoryScroll()
  end
  sightlangCondHandl0(false)
end
addEvent("loadedMobileAdForList", true)
addEventHandler("loadedMobileAdForList", getRootElement(), function(id, title, shortDescription, price, highlight, hasThumb, online)
  if requestedAds[id] then
    if title then
      loadedAds[id] = {
        title,
        shortDescription,
        price,
        highlight,
        hasThumb,
        online
      }
    else
      loadedAds[id] = nil
      for i = #loadedAdList, 1, -1 do
        if loadedAdList[i] == id then
          table.remove(loadedAdList, i)
          break
        end
      end
    end
    if currentPhoneScreen == "ad_category" then
      sightlangCondHandl0(true)
    end
  end
end)
addEvent("loadedMobileAdThumb", true)
addEventHandler("loadedMobileAdThumb", getRootElement(), function(id, thumb)
  if requestedAdThumbs[id] then
    local file = false
    if fileExists("ads/list.sight") then
      file = fileOpen("ads/list.sight", true)
      fileSetPos(file, fileGetSize(file))
    else
      file = fileCreate("ads/list.sight")
    end
    if file then
      fileWrite(file, id .. "\n")
      fileClose(file)
      if fileExists("ads/list/" .. id .. ".dds") then
        fileDelete("ads/list/" .. id .. ".dds")
      end
      local file = fileCreate("ads/list/" .. id .. ".dds")
      if file then
        fileWrite(file, thumb)
        fileClose(file)
      end
      sightxports.sGui:resetImageDDS(":sMobile/!mobile_sight/ads/list/" .. id .. ".dds")
      if currentPhoneScreen == "ad_category" then
        sightlangCondHandl0(true)
      end
    end
    thumb = nil
    collectgarbage("collect")
  end
end)
function refreshCategoryScroll()
  sightxports.sGui:setGuiRenderDisabled(categoryScrollUp, categoryScroll <= 0)
  sightxports.sGui:setGuiPosition(categoryScrollBar, bsx - 9, categoryScrollBarY + categoryScrollHeight / math.max(1, #loadedAdList - 6 + 1) * categoryScroll)
  for i = 1, 6 do
    local rect = adCategoryElements[i][1]
    local id = loadedAdList[i + categoryScroll]
    sightxports.sGui:setGuiRenderDisabled(rect, not id, true)
    if loadedAds[id] then
      adButtons[rect] = id
      sightxports.sGui:setGuiHoverable(rect, true)
      local highlight = loadedAds[id][4]
      if highlight then
        sightxports.sGui:setGuiBackground(rect, "solid", "#fff4d2")
        sightxports.sGui:setGuiHover(rect, "none", "#fff4d2", false, true)
      else
        sightxports.sGui:setGuiBackground(rect, "solid", {
          255,
          255,
          255
        })
        sightxports.sGui:setGuiHover(rect, "none", {
          255,
          255,
          255
        }, false, true)
      end
      local img = adCategoryElements[i][2]
      if loadedAds[id][5] then
        if fileExists("ads/list/" .. id .. ".dds") then
          sightxports.sGui:setImageDDS(img, ":sMobile/!mobile_sight/ads/list/" .. id .. ".dds", "dxt1", false, true)
        else
          if not requestedAdThumbs[id] then
            requestedAdThumbs[id] = true
            triggerLatentServerEvent("requestMobileAdThumb", localPlayer, id)
          end
          sightxports.sGui:setImageFile(img, loadedTextures["files/img/camload.png"])
        end
      else
        sightxports.sGui:setImageFile(img, loadedTextures["files/img/cam.png"])
      end
      local label = adCategoryElements[i][3]
      if highlight then
        sightxports.sGui:setLabelColor(label, "#705914")
      else
        sightxports.sGui:setLabelColor(label, "#2a2a2a")
      end
      local w, h = sightxports.sGui:getGuiSize(img)
      h = h + 12
      local h2 = (h - 12) / 3
      sightxports.sGui:setLabelText(label, loadedAds[id][1])
      local rx = 0
      if favoriteAds[id] then
        rx = rx + h2
      end
      if loadedAds[id][6] then
        rx = rx + h2 * 0.75
      end
      sightxports.sGui:setGuiSize(label, bsx - 9 - h - 4 - rx, false)
      local label = adCategoryElements[i][4]
      local description = loadedAds[id][2]
      if description then
        sightxports.sGui:setGuiRenderDisabled(label, false)
        if highlight then
          sightxports.sGui:setLabelColor(label, "#705914")
        else
          sightxports.sGui:setLabelColor(label, "#2a2a2a")
        end
        if utf8.len(description) > 23 then
          sightxports.sGui:setLabelText(label, utf8.sub(description, 1, 20) .. "...")
        else
          sightxports.sGui:setLabelText(label, description)
        end
      else
        sightxports.sGui:setGuiRenderDisabled(label, true)
      end
      local label = adCategoryElements[i][5]
      local price = loadedAds[id][3]
      if price then
        sightxports.sGui:setGuiRenderDisabled(label, false)
        if highlight then
          sightxports.sGui:setLabelColor(label, "#705914")
        else
          sightxports.sGui:setLabelColor(label, "#2a2a2a")
        end
        if 0 < price then
          sightxports.sGui:setLabelText(label, sightxports.sGui:thousandsStepper(price) .. " $")
        else
          sightxports.sGui:setLabelText(label, "Ingyenes")
        end
      else
        sightxports.sGui:setGuiRenderDisabled(label, true)
      end
      local icon = adCategoryElements[i][6]
      if highlight then
        sightxports.sGui:setImageColor(icon, "#705914")
      else
        sightxports.sGui:setImageColor(icon, "#2a2a2a")
      end
      sightxports.sGui:setGuiRenderDisabled(icon, not favoriteAds[id])
      local online = adCategoryElements[i][7]
      if loadedAds[id][6] then
        sightxports.sGui:setGuiRenderDisabled(online, false)
        if favoriteAds[id] then
          sightxports.sGui:setGuiPosition(icon, bsx - 10 - h2 * 1.75, false)
        end
      else
        sightxports.sGui:setGuiRenderDisabled(online, true)
        if favoriteAds[id] then
          sightxports.sGui:setGuiPosition(icon, bsx - 10 - h2, false)
        end
      end
    elseif id then
      sightxports.sGui:setGuiBackground(rect, "solid", {
        220,
        220,
        220
      })
      sightxports.sGui:setGuiHoverable(rect, false)
      local img = adCategoryElements[i][2]
      sightxports.sGui:setImageFile(img, loadedTextures["files/img/camload.png"])
      local label = adCategoryElements[i][3]
      sightxports.sGui:setLabelColor(label, "#2a2a2a")
      sightxports.sGui:setLabelText(label, "Hirdetés betöltése...")
      local label = adCategoryElements[i][4]
      sightxports.sGui:setGuiRenderDisabled(label, true)
      local label = adCategoryElements[i][5]
      sightxports.sGui:setGuiRenderDisabled(label, true)
      local icon = adCategoryElements[i][6]
      sightxports.sGui:setGuiRenderDisabled(icon, true)
      local icon = adCategoryElements[i][7]
      sightxports.sGui:setGuiRenderDisabled(icon, true)
      if not requestedAds[id] then
        requestedAds[id] = true
        triggerLatentServerEvent("requestMobileAdForList", localPlayer, id)
      end
    end
  end
end
addEvent("scrollAdCurrentCategoryUp", false)
addEventHandler("scrollAdCurrentCategoryUp", getRootElement(), function()
  categoryScroll = 0
  lastCategoryScroll[selectedAdCategory] = categoryScroll
  refreshCategoryScroll()
end)
function categoryScrollKey(key)
  if key == "mouse_wheel_up" then
    if 0 < categoryScroll then
      categoryScroll = categoryScroll - 1
      lastCategoryScroll[selectedAdCategory] = categoryScroll
      refreshCategoryScroll()
    end
  elseif key == "mouse_wheel_down" and categoryScroll < #loadedAdList - 6 then
    categoryScroll = categoryScroll + 1
    lastCategoryScroll[selectedAdCategory] = categoryScroll
    refreshCategoryScroll()
  end
end
function appScreens.ad_category_loading()
  specialData = false
  appInside = sightxports.sGui:createGuiElement("null", 0, 0, bsx, bsy, mobileBackground)
  if selectedAdCategory and adCategories[selectedAdCategory] then
    local rect = sightxports.sGui:createGuiElement("rectangle", 0, 0, bsx, bsy, appInside)
    sightxports.sGui:setGuiBackground(rect, "solid", {
      255,
      255,
      255
    })
    local n = 6
    local h = math.floor((bsy - topSize * 2.5 - 32) / n)
    local ts = bsy - topSize * 2.5 - h * n
    local y = topSize
    local w = sightxports.sGui:getTextWidthFont(adCategories[selectedAdCategory][3], "11/Ubuntu-R.ttf") + 24 + 4
    local rect = sightxports.sGui:createGuiElement("rectangle", 0, 0, bsx, y + ts, appInside)
    sightxports.sGui:setGuiBackground(rect, "solid", green)
    local icon = sightxports.sGui:createGuiElement("image", bsx / 2 - w / 2, y + ts / 2 - 12, 24, 24, appInside)
    sightxports.sGui:setImageFile(icon, sightxports.sGui:getFaIconFilename(adCategories[selectedAdCategory][1], 24, adCategories[selectedAdCategory][2]))
    sightxports.sGui:setImageColor(icon, "#ffffff")
    local label = sightxports.sGui:createGuiElement("label", bsx / 2 - w / 2 + 24 + 4, y, bsx, ts, appInside)
    sightxports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
    sightxports.sGui:setLabelAlignment(label, "left", "center")
    sightxports.sGui:setLabelColor(label, "#ffffff")
    sightxports.sGui:setLabelText(label, adCategories[selectedAdCategory][3])
    y = y + ts
    local label = sightxports.sGui:createGuiElement("label", 0, y, bsx, 48, appInside)
    sightxports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
    sightxports.sGui:setLabelAlignment(label, "center", "center")
    sightxports.sGui:setLabelColor(label, "#000000")
    sightxports.sGui:setLabelText(label, "Hirdetések betöltése...")
  end
  bringBackFront()
end
addEvent("openMobileAdFiltering", false)
addEventHandler("openMobileAdFiltering", getRootElement(), function()
  switchAppScreen("ad_filtering", true)
end)
function processAdFiltering()
  loadedAdList = {}
  for i = 1, #rawAdList do
    table.insert(loadedAdList, rawAdList[i])
  end
  for i = #loadedAdList, 1, -1 do
    if filterExcludeSub[subAdList[i]] then
      table.remove(loadedAdList, i)
    end
  end
  if ownAdIds and filterOwn then
    for i = #loadedAdList, 1, -1 do
      if not ownAdIds[loadedAdList[i]] then
        table.remove(loadedAdList, i)
      end
    end
  end
  if filterFav then
    for i = #loadedAdList, 1, -1 do
      if not favoriteAds[loadedAdList[i]] then
        table.remove(loadedAdList, i)
      end
    end
  end
end
local filterOwnCheckbox = false
local filterFavCheckbox = false
local adFilterCheckboxes = false
local adFilterExcludeTmp = false
addEvent("applyMobileAdFilter", false)
addEventHandler("applyMobileAdFilter", getRootElement(), function()
  filterOwn = sightxports.sGui:isCheckboxChecked(filterOwnCheckbox)
  filterFav = sightxports.sGui:isCheckboxChecked(filterFavCheckbox)
  filterExcludeSub = adFilterExcludeTmp
  adFilterExcludeTmp = false
  filterOwnCategory[selectedAdCategory] = filterOwn
  filterFavCategory[selectedAdCategory] = filterFav
  if filterExcludeSub then
    filterExcludeSubCategory[selectedAdCategory] = {}
    for i, v in pairs(filterExcludeSub) do
      filterExcludeSubCategory[selectedAdCategory][i] = v
    end
  else
    filterExcludeSubCategory[selectedAdCategory] = false
  end
  processAdFiltering()
  lastCategoryScroll[selectedAdCategory] = 0
  switchAppScreen("ad_category", true)
end)
local filterAdScrollH = false
local filterAdScrollBar = false
local filterAdScroll = 0
function refreshAdFilterScroll()
  if selectedAdCategory and adCategories[selectedAdCategory] then
    local n = #adCategories[selectedAdCategory][5]
    for i = 1, math.min(n, 12) do
      local checkbox, label = unpack(adFilterCheckboxes[i])
      if adCategories[selectedAdCategory][5][i + filterAdScroll] then
        sightxports.sGui:setLabelText(label, adCategories[selectedAdCategory][5][i + filterAdScroll])
        sightxports.sGui:setClickArgument(checkbox, i + filterAdScroll)
        sightxports.sGui:setCheckboxChecked(checkbox, not adFilterExcludeTmp[i + filterAdScroll])
      end
    end
    if filterAdScrollBar then
      sightxports.sGui:setGuiPosition(filterAdScrollBar, false, filterAdScroll * filterAdScrollH)
    end
  end
end
addEvent("deselectAllAdFilterCategory", false)
addEventHandler("deselectAllAdFilterCategory", getRootElement(), function()
  adFilterExcludeTmp = {}
  for i = 1, #adCategories[selectedAdCategory][5] do
    adFilterExcludeTmp[i] = true
  end
  refreshAdFilterScroll()
end)
addEvent("selectAllAdFilterCategory", false)
addEventHandler("selectAllAdFilterCategory", getRootElement(), function()
  adFilterExcludeTmp = {}
  refreshAdFilterScroll()
end)
addEvent("clickAdFilterCheckbox", false)
addEventHandler("clickAdFilterCheckbox", getRootElement(), function(button, state, absoluteX, absoluteY, el, cat)
  if selectedAdCategory and adCategories[selectedAdCategory] and adCategories[selectedAdCategory][5][cat] then
    if adFilterExcludeTmp[cat] then
      adFilterExcludeTmp[cat] = nil
    else
      adFilterExcludeTmp[cat] = true
    end
    refreshAdFilterScroll()
  end
end)
function adFilterScrollKey(key)
  if key == "mouse_wheel_up" then
    if 0 < filterAdScroll then
      filterAdScroll = filterAdScroll - 1
      refreshAdFilterScroll()
    end
  elseif key == "mouse_wheel_down" then
    local n = #adCategories[selectedAdCategory][5]
    if filterAdScroll < n - 12 then
      filterAdScroll = filterAdScroll + 1
      refreshAdFilterScroll()
    end
  end
end
function appCloses.ad_filtering()
  filterOwnCheckbox = false
  filterFavCheckbox = false
  adFilterCheckboxes = false
  adFilterExcludeTmp = false
  filterAdScrollH = false
  filterAdScrollBar = false
  filterAdScroll = 0
  removeEventHandler("onClientKey", getRootElement(), adFilterScrollKey)
end
function appScreens.ad_filtering()
  appInside = sightxports.sGui:createGuiElement("null", 0, 0, bsx, bsy, mobileBackground)
  addEventHandler("onClientKey", getRootElement(), adFilterScrollKey)
  filterAdScrollH = {}
  filterAdScrollBar = false
  filterAdScroll = 0
  filterOwnCheckbox = false
  filterFavCheckbox = false
  adFilterCheckboxes = {}
  adFilterExcludeTmp = {}
  for k in pairs(filterExcludeSub) do
    adFilterExcludeTmp[k] = filterExcludeSub[k]
  end
  if selectedAdCategory and adCategories[selectedAdCategory] then
    local rect = sightxports.sGui:createGuiElement("rectangle", 0, 0, bsx, bsy, appInside)
    sightxports.sGui:setGuiBackground(rect, "solid", {
      255,
      255,
      255
    })
    local h = math.floor((bsy - topSize * 2.5 - 32) / 6)
    local ts = bsy - topSize * 2.5 - h * 6
    local y = topSize
    local w = sightxports.sGui:getTextWidthFont(adCategories[selectedAdCategory][3], "11/Ubuntu-R.ttf") + 24 + 4
    local rect = sightxports.sGui:createGuiElement("rectangle", 0, 0, bsx, y + ts, appInside)
    sightxports.sGui:setGuiBackground(rect, "solid", green)
    local icon = sightxports.sGui:createGuiElement("image", bsx / 2 - w / 2, y + ts / 2 - 12, 24, 24, appInside)
    sightxports.sGui:setImageFile(icon, sightxports.sGui:getFaIconFilename(adCategories[selectedAdCategory][1], 24, adCategories[selectedAdCategory][2]))
    sightxports.sGui:setImageColor(icon, "#ffffff")
    local label = sightxports.sGui:createGuiElement("label", bsx / 2 - w / 2 + 24 + 4, y, bsx, ts, appInside)
    sightxports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
    sightxports.sGui:setLabelAlignment(label, "left", "center")
    sightxports.sGui:setLabelColor(label, "#ffffff")
    sightxports.sGui:setLabelText(label, adCategories[selectedAdCategory][3])
    y = y + ts
    local bbox = sightxports.sGui:createGuiElement("rectangle", 8, y, bsx - 16, 24, appInside)
    sightxports.sGui:setGuiBackground(bbox, "solid", {
      0,
      0,
      0,
      0
    })
    sightxports.sGui:setGuiHover(bbox, "none")
    sightxports.sGui:setGuiHoverable(bbox, true)
    local checkbox = sightxports.sGui:createGuiElement("checkbox", 8, y, 24, 24, appInside)
    sightxports.sGui:setGuiColorScheme(checkbox, "darker")
    sightxports.sGui:setGuiBoundingBox(checkbox, bbox)
    sightxports.sGui:setCheckboxColor(checkbox, grey2, "#ffffff", green, "#000000")
    filterOwnCheckbox = checkbox
    local label = sightxports.sGui:createGuiElement("label", 36, y, bsx - 16 - 24 - 8, 24, appInside)
    sightxports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
    sightxports.sGui:setLabelAlignment(label, "left", "center")
    sightxports.sGui:setLabelColor(label, "#000000")
    sightxports.sGui:setLabelClip(label, true)
    sightxports.sGui:setGuiHoverable(label, true)
    sightxports.sGui:setGuiBoundingBox(label, bbox)
    sightxports.sGui:setLabelText(label, "Csak saját hirdetések")
    y = y + 32
    local border = sightxports.sGui:createGuiElement("hr", 8, y - 1, bsx - 16, 1, appInside)
    sightxports.sGui:setGuiHrColor(border, grey2, grey2)
    local bbox = sightxports.sGui:createGuiElement("rectangle", 8, y, bsx - 16, 32, appInside)
    sightxports.sGui:setGuiBackground(bbox, "solid", {
      0,
      0,
      0,
      0
    })
    sightxports.sGui:setGuiHover(bbox, "none")
    sightxports.sGui:setGuiHoverable(bbox, true)
    local checkbox = sightxports.sGui:createGuiElement("checkbox", 8, y + 16 - 12, 24, 24, appInside)
    sightxports.sGui:setGuiColorScheme(checkbox, "darker")
    sightxports.sGui:setGuiBoundingBox(checkbox, bbox)
    sightxports.sGui:setCheckboxColor(checkbox, grey2, "#ffffff", green, "#000000")
    filterFavCheckbox = checkbox
    local label = sightxports.sGui:createGuiElement("label", 36, y, bsx - 16 - 24 - 8, 32, appInside)
    sightxports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
    sightxports.sGui:setLabelAlignment(label, "left", "center")
    sightxports.sGui:setLabelColor(label, "#000000")
    sightxports.sGui:setLabelClip(label, true)
    sightxports.sGui:setGuiHoverable(label, true)
    sightxports.sGui:setGuiBoundingBox(label, bbox)
    sightxports.sGui:setLabelText(label, "Csak kedvenc hirdetések")
    y = y + 32 + 4
    local border = sightxports.sGui:createGuiElement("hr", 8, y - 1, bsx - 16, 1, appInside)
    sightxports.sGui:setGuiHrColor(border, grey2, grey2)
    sightxports.sGui:setCheckboxChecked(filterOwnCheckbox, filterOwn)
    sightxports.sGui:setCheckboxChecked(filterFavCheckbox, filterFav)
    local icon = sightxports.sGui:createGuiElement("image", 28, y + 12 - 10, 20, 20, appInside)
    sightxports.sGui:setImageFile(icon, sightxports.sGui:getFaIconFilename("minus-square", 20))
    sightxports.sGui:setGuiHoverable(icon, true)
    sightxports.sGui:setImageColor(icon, red)
    sightxports.sGui:setClickEvent(icon, "deselectAllAdFilterCategory")
    local icon = sightxports.sGui:createGuiElement("image", 8, y + 12 - 10, 20, 20, appInside)
    sightxports.sGui:setImageFile(icon, sightxports.sGui:getFaIconFilename("check-square", 20))
    sightxports.sGui:setGuiHoverable(icon, true)
    sightxports.sGui:setImageColor(icon, green)
    sightxports.sGui:setClickEvent(icon, "selectAllAdFilterCategory")
    y = y + 24
    local n = #adCategories[selectedAdCategory][5]
    local h = (bsy - y - 8 - topSize * 1.5 - 24 - 4) / 12
    if 12 < n then
      filterAdScrollH = h * 12
      local rect = sightxports.sGui:createGuiElement("rectangle", bsx - 8 - 2, y, 2, filterAdScrollH, appInside)
      sightxports.sGui:setGuiBackground(rect, "solid", grey1)
      filterAdScrollH = filterAdScrollH / (n - 12 + 1)
      filterAdScrollBar = sightxports.sGui:createGuiElement("rectangle", 0, 0, 2, filterAdScrollH, rect)
      sightxports.sGui:setGuiBackground(filterAdScrollBar, "solid", grey3)
    end
    for i = 1, math.min(n, 12) do
      local bbox = sightxports.sGui:createGuiElement("rectangle", 8, y, bsx - 16, h, appInside)
      sightxports.sGui:setGuiBackground(bbox, "solid", {
        0,
        0,
        0,
        0
      })
      sightxports.sGui:setGuiHover(bbox, "none")
      sightxports.sGui:setGuiHoverable(bbox, true)
      local checkbox = sightxports.sGui:createGuiElement("checkbox", 8, y + h / 2 - 12, 24, 24, appInside)
      sightxports.sGui:setGuiColorScheme(checkbox, "darker")
      sightxports.sGui:setGuiBoundingBox(checkbox, bbox)
      sightxports.sGui:setCheckboxColor(checkbox, grey2, "#ffffff", green, "#000000")
      sightxports.sGui:setClickEvent(checkbox, "clickAdFilterCheckbox")
      local label = sightxports.sGui:createGuiElement("label", 36, y, bsx - 16 - 24 - 8, h, appInside)
      sightxports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
      sightxports.sGui:setLabelAlignment(label, "left", "center")
      sightxports.sGui:setLabelColor(label, "#000000")
      sightxports.sGui:setLabelClip(label, true)
      sightxports.sGui:setGuiHoverable(label, true)
      sightxports.sGui:setGuiBoundingBox(label, bbox)
      adFilterCheckboxes[i] = {checkbox, label}
      y = y + h
    end
    refreshAdFilterScroll()
    local btn = sightxports.sGui:createGuiElement("button", 8, bsy - topSize * 1.5 - 24 - 4, bsx - 16, 24, appInside)
    sightxports.sGui:setGuiBackground(btn, "solid", blue)
    sightxports.sGui:setGuiHover(btn, "none", blue, false, true)
    sightxports.sGui:setButtonTextColor(btn, "#ffffff")
    sightxports.sGui:setButtonText(btn, "Szűrő alkalmazása")
    sightxports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
    sightxports.sGui:setClickEvent(btn, "applyMobileAdFilter")
  end
  generateBottom(true, "selectAdCategoryEx", true)
  bringBackFront()
end
function appCloses.ad_category()
  removeEventHandler("onClientKey", getRootElement(), categoryScrollKey)
end
function appScreens.ad_category()
  deletingAd = false
  addEventHandler("onClientKey", getRootElement(), categoryScrollKey)
  adButtons = {}
  appInside = sightxports.sGui:createGuiElement("null", 0, 0, bsx, bsy, mobileBackground)
  if selectedAdCategory and adCategories[selectedAdCategory] then
    local rect = sightxports.sGui:createGuiElement("rectangle", 0, 0, bsx, bsy, appInside)
    sightxports.sGui:setGuiBackground(rect, "solid", {
      255,
      255,
      255
    })
    local h = math.floor((bsy - topSize * 2.5 - 32) / 6)
    local ts = bsy - topSize * 2.5 - h * 6
    local y = topSize
    local text = adCategories[selectedAdCategory][3] .. " (" .. #loadedAdList .. ")"
    local w = sightxports.sGui:getTextWidthFont(text, "11/Ubuntu-R.ttf") + 24 + 4
    local rect = sightxports.sGui:createGuiElement("rectangle", 0, 0, bsx, y + ts, appInside)
    sightxports.sGui:setGuiBackground(rect, "solid", green)
    local icon = sightxports.sGui:createGuiElement("image", bsx / 2 - w / 2, y + ts / 2 - 12, 24, 24, appInside)
    sightxports.sGui:setImageFile(icon, sightxports.sGui:getFaIconFilename(adCategories[selectedAdCategory][1], 24, adCategories[selectedAdCategory][2]))
    sightxports.sGui:setImageColor(icon, "#ffffff")
    local label = sightxports.sGui:createGuiElement("label", bsx / 2 - w / 2 + 24 + 4, y, bsx, ts, appInside)
    sightxports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
    sightxports.sGui:setLabelAlignment(label, "left", "center")
    sightxports.sGui:setLabelColor(label, "#ffffff")
    sightxports.sGui:setLabelText(label, text)
    if adCategories[selectedAdCategory][4] ~= "own" then
      local icon = sightxports.sGui:createGuiElement("image", bsx - 24 - 8, y + ts / 2 - 12, 24, 24, appInside)
      sightxports.sGui:setImageFile(icon, sightxports.sGui:getFaIconFilename("plus", 24, "solid"))
      sightxports.sGui:setGuiHoverable(icon, true)
      sightxports.sGui:setClickEvent(icon, "newAdvertisement")
    end
    local icon = sightxports.sGui:createGuiElement("image", 8, y + ts / 2 - 12, 24, 24, appInside)
    sightxports.sGui:setImageFile(icon, sightxports.sGui:getFaIconFilename("filter", 24))
    sightxports.sGui:setGuiHoverable(icon, true)
    sightxports.sGui:setClickEvent(icon, "openMobileAdFiltering")
    y = y + ts
    local h2 = (h - 12) / 3
    adCategoryElements = {}
    categoryScroll = lastCategoryScroll[selectedAdCategory] or 0
    if categoryScroll > math.max(0, #loadedAdList - 6) then
      categoryScroll = math.max(0, #loadedAdList - 6)
    end
    for i = 1, 6 do
      adCategoryElements[i] = {}
      local rect = sightxports.sGui:createGuiElement("rectangle", 0, y + h * (i - 1), bsx - 9 - 2, h, appInside)
      sightxports.sGui:setGuiHoverable(rect, true)
      sightxports.sGui:setClickEvent(rect, "selectAd")
      table.insert(adCategoryElements[i], rect)
      local border = sightxports.sGui:createGuiElement("hr", 0, 0, bsx - (1 < i and 11 or 0), 1 < i and 1 or 2, rect)
      if 1 < i then
        sightxports.sGui:setGuiHrColor(border, grey1, grey1)
      else
        sightxports.sGui:setGuiHrColor(border, green2, green)
      end
      local img = sightxports.sGui:createGuiElement("image", 8, 6, h - 12, h - 12, rect)
      table.insert(adCategoryElements[i], img)
      local label = sightxports.sGui:createGuiElement("label", h, 6, bsx - 9 - h - 4, h2, rect)
      sightxports.sGui:setLabelFont(label, "10/Ubuntu-B.ttf")
      sightxports.sGui:setLabelAlignment(label, "left", "center")
      sightxports.sGui:setLabelClip(label, true)
      table.insert(adCategoryElements[i], label)
      local label = sightxports.sGui:createGuiElement("label", h, 6 + h2, bsx - 9 - h - 4, h2, rect)
      sightxports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
      sightxports.sGui:setLabelAlignment(label, "left", "center")
      sightxports.sGui:setLabelClip(label, true)
      table.insert(adCategoryElements[i], label)
      local label = sightxports.sGui:createGuiElement("label", h, 6 + h2 * 2, bsx - 9 - h - 4, h2, rect)
      sightxports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
      sightxports.sGui:setLabelAlignment(label, "left", "center")
      sightxports.sGui:setLabelClip(label, true)
      table.insert(adCategoryElements[i], label)
      local icon = sightxports.sGui:createGuiElement("image", 0, 2, h2, h2, rect)
      sightxports.sGui:setImageFile(icon, sightxports.sGui:getFaIconFilename("star", h2, "solid"))
      table.insert(adCategoryElements[i], icon)
      local icon = sightxports.sGui:createGuiElement("image", bsx - 10 - h2 * 0.75, 2 + h2 * 0.125, h2 * 0.75, h2 * 0.75, rect)
      sightxports.sGui:setImageFile(icon, sightxports.sGui:getFaIconFilename("circle", h2, "solid"))
      sightxports.sGui:setImageColor(icon, green)
      table.insert(adCategoryElements[i], icon)
    end
    categoryScrollHeight = h * 6 - 6
    local rect = sightxports.sGui:createGuiElement("rectangle", bsx - 9, y + 4, 3, categoryScrollHeight, appInside)
    sightxports.sGui:setGuiBackground(rect, "solid", grey1)
    categoryScrollBar = sightxports.sGui:createGuiElement("rectangle", bsx - 9, y + 4, 3, categoryScrollHeight / math.max(1, #loadedAdList - 6 + 1), appInside)
    sightxports.sGui:setGuiBackground(categoryScrollBar, "solid", grey3)
    categoryScrollBarY = y + 4
    categoryScrollUp = sightxports.sGui:createGuiElement("image", bsx - 9 - 24, y + 4 + categoryScrollHeight - 24, 24, 24, appInside)
    sightxports.sGui:setImageFile(categoryScrollUp, sightxports.sGui:getFaIconFilename("chevron-square-up", 24, "solid"))
    sightxports.sGui:setGuiHoverable(categoryScrollUp, true)
    sightxports.sGui:setImageColor(categoryScrollUp, green)
    sightxports.sGui:setClickEvent(categoryScrollUp, "scrollAdCurrentCategoryUp")
    sightxports.sGui:disableClickTrough(categoryScrollUp, true)
    refreshCategoryScroll()
  end
  generateBottom(true, "openAdsEx", true)
  bringBackFront()
end
local adCategoryBadges = {}
local adCategoryLoader = {}
local adCategoryCount = {}
local badgesLoading = false
addEvent("loadedAdCategoryBadges", true)
addEventHandler("loadedAdCategoryBadges", getRootElement(), function(data, smallest)
  badgesLoading = false
  adCategoryCount = data
  smallestAdId = smallest or 0
  for k in pairs(favoriteAds) do
    if k < smallestAdId then
      saveFavoriteAds()
      break
    end
  end
  if currentPhoneScreen == "ads" then
    for i = 1, #adCategoryBadges do
      sightxports.sGui:setLabelText(adCategoryBadges[i], adCategoryCount[i] or "")
    end
    for i = 1, #adCategoryLoader do
      if adCategoryLoader[i] then
        sightxports.sGui:deleteGuiElement(adCategoryLoader[i])
      end
      adCategoryLoader[i] = nil
    end
  end
end)
function appScreens.ads()
  if not badgesLoading then
    triggerServerEvent("requestAdCategoryBadges", localPlayer)
    badgesLoading = true
  end
  adButtons = {}
  adCategoryBadges = {}
  adCategoryLoader = {}
  appInside = sightxports.sGui:createGuiElement("null", 0, 0, bsx, bsy, mobileBackground)
  local rect = sightxports.sGui:createGuiElement("rectangle", 0, 0, bsx, bsy, appInside)
  sightxports.sGui:setGuiBackground(rect, "solid", {
    255,
    255,
    255
  })
  local label = sightxports.sGui:createGuiElement("label", 0, topSize + 16, bsx, 32, appInside)
  sightxports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
  sightxports.sGui:setLabelAlignment(label, "center", "center")
  sightxports.sGui:setLabelColor(label, "#000000")
  sightxports.sGui:setLabelText(label, "Üdvözlünk az\nSightCity Advertisementnél!")
  local label = sightxports.sGui:createGuiElement("label", 0, topSize + 16 + 32 + 8, bsx, 24, appInside)
  sightxports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
  sightxports.sGui:setLabelAlignment(label, "center", "center")
  sightxports.sGui:setLabelColor(label, "#000000")
  sightxports.sGui:setLabelText(label, "Kérjük válassz kategóriát:")
  local y = topSize + 16 + 32 + 24 + 8 + 8
  for i = 1, #adCategories do
    local btn = sightxports.sGui:createGuiElement("rectangle", 24, y, bsx - 48, 32, appInside)
    sightxports.sGui:setGuiHoverable(btn, true)
    sightxports.sGui:setGuiBackground(btn, "solid", green)
    sightxports.sGui:setGuiHover(btn, "none", green, false, true)
    sightxports.sGui:setClickEvent(btn, "selectAdCategory")
    adButtons[btn] = i
    local icon = sightxports.sGui:createGuiElement("image", 28, y + 16 - 12, 24, 24, appInside)
    sightxports.sGui:setImageFile(icon, sightxports.sGui:getFaIconFilename(adCategories[i][1], 24, adCategories[i][2]))
    local label = sightxports.sGui:createGuiElement("label", 56, y, bsx, 32, appInside)
    sightxports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
    sightxports.sGui:setLabelAlignment(label, "left", "center")
    sightxports.sGui:setLabelColor(label, "#ffffff")
    sightxports.sGui:setLabelText(label, adCategories[i][3])
    local badge = sightxports.sGui:createGuiElement("image", bsx - 24 - 50 + 4, y, 50, 32, appInside)
    sightxports.sGui:setImageFile(badge, sightxports.sGui:getFaIconFilename("square", 50))
    sightxports.sGui:setImageColor(badge, blue2)
    local label = sightxports.sGui:createGuiElement("label", bsx - 24 - 50 + 4, y, 50, 32, appInside)
    sightxports.sGui:setLabelFont(label, "9/Ubuntu-B.ttf")
    sightxports.sGui:setLabelAlignment(label, "center", "center")
    sightxports.sGui:setLabelColor(label, "#ffffff")
    sightxports.sGui:setLabelText(label, badgesLoading and "" or adCategoryCount[i] or "")
    adCategoryBadges[i] = label
    if badgesLoading then
      local loaderIcon = sightxports.sGui:createGuiElement("image", bsx - 24 - 25 + 4 - 8, y + 16 - 8, 16, 16, appInside)
      sightxports.sGui:setImageFile(loaderIcon, sightxports.sGui:getFaIconFilename("circle-notch", 16))
      sightxports.sGui:setImageSpinner(loaderIcon, true)
      table.insert(adCategoryLoader, loaderIcon)
    end
    y = y + 32 + 8
  end
  generateBottom(true, false, true)
  bringBackFront()
end
