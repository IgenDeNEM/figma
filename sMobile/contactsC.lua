local sightxports = {sGui = false}
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
local contactListElements = {}
local contactListAvatars = {}
selectedContact = false
local avatarEditGui = false
local avCut1 = false
local avCut2 = false
local avShad = false
local avRect = false
local cropImage = false
local cropX, cropY, cropSize = 0, 0, 0
local currentContactPhoto = false
local cropZoomLevel = 0
function appCloses.contact_crop_photo()
  removeEventHandler("onClientClick", getRootElement(), contactCropClick)
  removeEventHandler("onClientCursorMove", getRootElement(), contactCropMove)
end
local singleFromSMS = false
local movingCrop = false
function contactCropMove(rx, ry, cx, cy)
  if movingCrop then
    cropX = movingCrop[1] - (cx - movingCrop[3]) * cropZoomLevel
    cropY = movingCrop[2] - (cy - movingCrop[4]) * cropZoomLevel
    local sx, sy = photoListData[currentContactPhoto][3], photoListData[currentContactPhoto][4]
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
function contactCropClick(button, state, cx, cy)
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
addEvent("openSMSFromContacts", false)
addEventHandler("openSMSFromContacts", getRootElement(), function()
  if selectedContact and phoneContacts[selectedContact] then
    openSMSForContact(phoneContacts[selectedContact][4])
  end
end)
addEvent("openSingleContactEx", false)
addEventHandler("openSingleContactEx", getRootElement(), function()
  switchAppScreen("contact_single", true)
end)
addEvent("deleteContactAvatar", false)
addEventHandler("deleteContactAvatar", getRootElement(), function()
  if selectedContact and phoneContacts[selectedContact] then
    if fileExists("contacts/" .. phoneContacts[selectedContact][6] .. ".dds") then
      fileDelete("contacts/" .. phoneContacts[selectedContact][6] .. ".dds")
    end
    phoneContacts[selectedContact][1] = phoneContacts[selectedContact][5] or utf8.upper(utf8.sub(phoneContacts[selectedContact][3], 1, 1))
    switchAppScreen("contact_single", true)
  end
end)
local editingContact = false
addEvent("finalDeleteContact", false)
addEventHandler("finalDeleteContact", getRootElement(), function()
  if editingContact and phoneContacts[editingContact] then
    if fileExists("contacts/" .. phoneContacts[editingContact][6] .. ".dds") then
      fileDelete("contacts/" .. phoneContacts[editingContact][6] .. ".dds")
    end
    table.remove(phoneContacts, editingContact)
    processContacts()
    saveContacts()
    switchAppScreen("contacts", true)
  end
end)
addEvent("finalCropContactPhoto", false)
addEventHandler("finalCropContactPhoto", getRootElement(), function()
  if selectedContact and phoneContacts[selectedContact] then
    if fileExists("contacts/" .. phoneContacts[selectedContact][6] .. ".dds") then
      fileDelete("contacts/" .. phoneContacts[selectedContact][6] .. ".dds")
    end
    if not phoneContacts[selectedContact][5] then
      local str = false
      if type(phoneContacts[selectedContact][1]) == "string" or type(phoneContacts[selectedContact][1]) == "table" then
        str = phoneContacts[selectedContact][1]
      end
      phoneContacts[selectedContact][5] = str or utf8.upper(utf8.sub(phoneContacts[selectedContact][3], 1, 1))
    end
    phoneContacts[selectedContact][1] = phoneContacts[selectedContact][5] or utf8.upper(utf8.sub(phoneContacts[selectedContact][3], 1, 1))
    local file = fileOpen("photos/" .. photoListData[currentContactPhoto][1] .. ".sight", true)
    if file then
      local checksum = fileRead(file, fileGetSize(file))
      fileClose(file)
      if checksum then
        checksum = teaDecode(checksum, "mk" .. photoListData[currentContactPhoto][2] .. utf8.sub(photoListData[currentContactPhoto][1], 1, 10))
        local image = fileOpen("photos/" .. photoListData[currentContactPhoto][1] .. ".dds", true)
        if image then
          local imageData = fileRead(image, fileGetSize(image))
          fileClose(image)
          if imageData then
            local calculatedSum = sha256(imageData)
            if calculatedSum == checksum then
              local texture = dxCreateTexture(imageData, "dxt3", false)
              if isElement(texture) then
                local photoRt = dxCreateRenderTarget(168, 168)
                local photoRt2 = dxCreateRenderTarget(math.floor(cropSize), math.floor(cropSize))
                if isElement(photoRt2) then
                  dxSetRenderTarget(photoRt2)
                  dxDrawImageSection(0, 0, math.floor(cropSize), math.floor(cropSize), math.floor(cropX), math.floor(cropY), math.floor(cropSize), math.floor(cropSize), texture)
                  dxSetRenderTarget(photoRt)
                  dxDrawImage(0, 0, 168, 168, photoRt2)
                  dxSetRenderTarget()
                  destroyElement(photoRt2)
                end
                destroyElement(texture)
                if isElement(photoRt) then
                  local pixels = dxGetTexturePixels(photoRt, "dds", "dxt1", false)
                  destroyElement(photoRt)
                  if pixels then
                    local convertedFile = fileCreate("contacts/" .. phoneContacts[selectedContact][6] .. ".dds")
                    sightxports.sGui:resetImageDDS("!mobile_sight/contacts/" .. phoneContacts[selectedContact][6] .. ".dds")
                    if convertedFile then
                      fileWrite(convertedFile, pixels)
                      fileClose(convertedFile)
                      phoneContacts[selectedContact][1] = "dds"
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
  switchAppScreen("contact_single")
end)
function appScreens.contact_crop_photo()
  appInside = sightxports.sGui:createGuiElement("null", 0, 0, bsx, bsy, mobileBackground)
  local rect = sightxports.sGui:createGuiElement("rectangle", 0, 0, bsx, bsy, appInside)
  sightxports.sGui:setGuiBackground(rect, "solid", {
    255,
    255,
    255
  })
  addEventHandler("onClientClick", getRootElement(), contactCropClick)
  addEventHandler("onClientCursorMove", getRootElement(), contactCropMove)
  local y = topSize
  local h = bsy - y
  local iw = 168
  local h = bsy - topSize * 1.5 - 24 - 4 - 4 - y - 4
  y = math.floor(y + h / 2 - (iw + 24 + 10 + 4) / 2)
  local x = math.floor(bsx / 2 - iw / 2)
  cropImage = sightxports.sGui:createGuiElement("image", x + 4, y + 4, iw - 8, iw - 8, appInside)
  sightxports.sGui:setImageFile(cropImage, loadedTextures["files/img/cam.png"])
  local img = sightxports.sGui:createGuiElement("image", x, y, iw, iw, appInside)
  sightxports.sGui:setImageFile(img, loadedTextures["files/img/avcut_lg.png"])
  local img = sightxports.sGui:createGuiElement("image", x - 6, y - 6, iw + 12, iw + 12, appInside)
  sightxports.sGui:setImageFile(img, loadedTextures["files/img/avshad.png"])
  sightxports.sGui:setImageColor(img, {
    255,
    255,
    255,
    100
  })
  local label = sightxports.sGui:createGuiElement("label", 0, y - 24, bsx, 24, appInside)
  sightxports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
  sightxports.sGui:setLabelAlignment(label, "center", "center")
  sightxports.sGui:setLabelColor(label, "#000000")
  sightxports.sGui:setLabelText(label, "Mozgatással kivághatod a képet.")
  local slider = sightxports.sGui:createGuiElement("slider", 8, y + iw + 4, bsx - 16, 10, appInside)
  sightxports.sGui:setSliderChangeEvent(slider, "cropZoomChangeMobileContact")
  sightxports.sGui:setSliderColor(slider, grey3, green)
  local btn = sightxports.sGui:createGuiElement("button", 8, bsy - topSize * 1.5 - 24 - 4, bsx - 16, 24, appInside)
  sightxports.sGui:setGuiBackground(btn, "solid", blue)
  sightxports.sGui:setGuiHover(btn, "none", blue, false, true)
  sightxports.sGui:setButtonTextColor(btn, "#ffffff")
  sightxports.sGui:setButtonText(btn, "Kép kivágása")
  sightxports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
  sightxports.sGui:setClickEvent(btn, "finalCropContactPhoto")
  generateBottom(true, "openGalleryForContact", true)
  bringBackFront()
end
addEvent("cropZoomChangeMobileContact", false)
addEventHandler("cropZoomChangeMobileContact", getRootElement(), function(el, sliderValue, final)
  local sx, sy = photoListData[currentContactPhoto][3], photoListData[currentContactPhoto][4]
  local size1 = sx < sy and sx or sy
  local size2 = 84
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
  cropZoomLevel = sx < sy and sx / 168 or sy / 168
  cropZoomLevel = cropZoomLevel + (1 - cropZoomLevel) * sliderValue
  sightxports.sGui:setImageUV(cropImage, cropX, cropY, cropSize, cropSize)
end)
function openedPhotoForContacts(currentPhoto)
  currentContactPhoto = currentPhoto
  if photoListData[currentContactPhoto][1] then
    switchAppScreen("contact_crop_photo", true)
    sightxports.sGui:setImageDDS(cropImage, "!mobile_sight/photos/" .. photoListData[currentContactPhoto][1] .. ".dds", "dxt3", false, true)
    local sx, sy = photoListData[currentContactPhoto][3], photoListData[currentContactPhoto][4]
    cropX = 0
    cropY = 0
    if sx < sy then
      cropSize = sx
      cropZoomLevel = sx / 168
      cropY = math.floor(sy / 2 - cropSize / 2)
    else
      cropSize = sy
      cropZoomLevel = sy / 168
      cropX = math.floor(sx / 2 - cropSize / 2)
    end
    sightxports.sGui:setImageUV(cropImage, cropX, cropY, cropSize, cropSize)
  else
    gallerySelecting = "contacts"
    switchAppScreen("gallery")
  end
end
addEvent("toggleAvatarEditMode", false)
addEventHandler("toggleAvatarEditMode", getRootElement(), function()
  sightxports.sGui:setGuiHoverable(avRect, avatarEditGui)
  if avatarEditGui then
    sightxports.sGui:deleteGuiElement(avatarEditGui)
    avatarEditGui = false
  else
    local contact = phoneContacts[selectedContact]
    if contact then
      local x, y, sx, sy = bsx / 2 - 84 + 4, topSize + 16 + 4, 160, 160
      avatarEditGui = sightxports.sGui:createGuiElement("rectangle", x, y, sx, sy, appInside)
      sightxports.sGui:setGuiBackground(avatarEditGui, "solid", {
        0,
        0,
        0,
        150
      })
      if contact[1] == "dds" then
        local w = sx / 3
        local icon = sightxports.sGui:createGuiElement("image", w / 2 - 16, sy / 2 - 16, 32, 32, avatarEditGui)
        sightxports.sGui:setImageFile(icon, sightxports.sGui:getFaIconFilename("folder-open", 32, "solid"))
        sightxports.sGui:setImageColor(icon, "#ffffff")
        sightxports.sGui:setGuiHoverable(icon, true)
        sightxports.sGui:setClickEvent(icon, "openGalleryForContact")
        local icon = sightxports.sGui:createGuiElement("image", w + w / 2 - 16, sy / 2 - 16, 32, 32, avatarEditGui)
        sightxports.sGui:setImageFile(icon, sightxports.sGui:getFaIconFilename("trash", 32, "solid"))
        sightxports.sGui:setImageColor(icon, "#ffffff")
        sightxports.sGui:setGuiHoverable(icon, true)
        sightxports.sGui:setClickEvent(icon, "deleteContactAvatar")
        local icon = sightxports.sGui:createGuiElement("image", w * 2 + w / 2 - 16, sy / 2 - 16, 32, 32, avatarEditGui)
        sightxports.sGui:setImageFile(icon, sightxports.sGui:getFaIconFilename("times", 32, "solid"))
        sightxports.sGui:setImageColor(icon, "#ffffff")
        sightxports.sGui:setGuiHoverable(icon, true)
        sightxports.sGui:setClickEvent(icon, "toggleAvatarEditMode")
      else
        local w = sx / 2
        local icon = sightxports.sGui:createGuiElement("image", w / 2 - 16, sy / 2 - 16, 32, 32, avatarEditGui)
        sightxports.sGui:setImageFile(icon, sightxports.sGui:getFaIconFilename("folder-open", 32, "solid"))
        sightxports.sGui:setImageColor(icon, "#ffffff")
        sightxports.sGui:setGuiHoverable(icon, true)
        sightxports.sGui:setClickEvent(icon, "openGalleryForContact")
        local icon = sightxports.sGui:createGuiElement("image", w + w / 2 - 16, sy / 2 - 16, 32, 32, avatarEditGui)
        sightxports.sGui:setImageFile(icon, sightxports.sGui:getFaIconFilename("times", 32, "solid"))
        sightxports.sGui:setImageColor(icon, "#ffffff")
        sightxports.sGui:setGuiHoverable(icon, true)
        sightxports.sGui:setClickEvent(icon, "toggleAvatarEditMode")
      end
      sightxports.sGui:guiToFront(avCut1)
      sightxports.sGui:guiToFront(avCut2)
      sightxports.sGui:guiToFront(avShad)
      bringBackFront()
    end
  end
end)
addEvent("openSingleContact", false)
addEventHandler("openSingleContact", getRootElement(), function()
  switchAppScreen("contact_single")
end)
function logSort(a, b)
  return a[1] > b[1]
end
function appScreens.contact_single()
  appInside = sightxports.sGui:createGuiElement("null", 0, 0, bsx, bsy, mobileBackground)
  local rect = sightxports.sGui:createGuiElement("rectangle", 0, 0, bsx, bsy, appInside)
  sightxports.sGui:setGuiBackground(rect, "solid", {
    255,
    255,
    255
  })
  local contact = phoneContacts[selectedContact]
  if contact then
    local col = contact[2]
    local ry = math.floor((topSize + 16 + 168) * 0.8)
    local rect = sightxports.sGui:createGuiElement("rectangle", 0, 0, bsx, ry, appInside)
    sightxports.sGui:setGuiBackground(rect, "solid", {
      contactColors[col][1],
      contactColors[col][2],
      contactColors[col][3]
    })
    local x, y, sx, sy = bsx / 2 - 84 + 4, topSize + 16 + 4, 160, 160
    avRect = sightxports.sGui:createGuiElement("rectangle", x, y, sx, sy, appInside)
    sightxports.sGui:setGuiBackground(avRect, "solid", {
      contactColors[col][1],
      contactColors[col][2],
      contactColors[col][3]
    })
    sightxports.sGui:setGuiHover(avRect, "none", {
      contactColors[col][1],
      contactColors[col][2],
      contactColors[col][3]
    }, false, true)
    sightxports.sGui:setGuiHoverable(avRect, true)
    sightxports.sGui:setClickEvent(avRect, "toggleAvatarEditMode")
    if contact[1] == "dds" then
      local img = sightxports.sGui:createGuiElement("image", x, y, sx, sy, appInside)
      sightxports.sGui:setImageDDS(img, "!mobile_sight/contacts/" .. contact[6] .. ".dds", "dxt1", false)
    elseif type(contact[1]) == "string" then
      local label = sightxports.sGui:createGuiElement("label", x, y, sx, sy, appInside)
      sightxports.sGui:setLabelFont(label, "50/Ubuntu-R.ttf")
      sightxports.sGui:setLabelAlignment(label, "center", "center")
      sightxports.sGui:setLabelColor(label, "#ffffff")
      sightxports.sGui:setLabelText(label, contact[1])
    elseif type(contact[1]) == "table" then
      local is = math.floor(sx * 0.6)
      local icon = sightxports.sGui:createGuiElement("image", x + sx / 2 - is / 2, y + sy / 2 - is / 2, is, is, appInside)
      sightxports.sGui:setImageFile(icon, sightxports.sGui:getFaIconFilename(contact[1][1], is, contact[1][2]))
      sightxports.sGui:setImageColor(icon, "#ffffff")
    else
      local label = sightxports.sGui:createGuiElement("label", x, y, sx, sy, appInside)
      sightxports.sGui:setLabelFont(label, "50/Ubuntu-R.ttf")
      sightxports.sGui:setLabelAlignment(label, "center", "center")
      sightxports.sGui:setLabelColor(label, "#ffffff")
      sightxports.sGui:setLabelText(label, "?")
    end
    avatarEditGui = false
    avCut1 = sightxports.sGui:createGuiElement("image", bsx / 2 - 84, topSize + 16, 168, ry - (topSize + 16), appInside)
    sightxports.sGui:setImageFile(avCut1, loadedTextures["files/img/avcut_lg.png"])
    sightxports.sGui:setImageColor(avCut1, {
      contactColors[col][1],
      contactColors[col][2],
      contactColors[col][3]
    })
    sightxports.sGui:setImageUV(avCut1, 0, 0, 168, ry - (topSize + 16))
    avCut2 = sightxports.sGui:createGuiElement("image", bsx / 2 - 84, ry, 168, topSize + 16 + 168 - ry, appInside)
    sightxports.sGui:setImageFile(avCut2, loadedTextures["files/img/avcut_lg.png"])
    sightxports.sGui:setImageUV(avCut2, 0, ry - (topSize + 16), 168, topSize + 16 + 168 - ry)
    avShad = sightxports.sGui:createGuiElement("image", bsx / 2 - 84 - 6, topSize + 16 - 6, 180, 180, appInside)
    sightxports.sGui:setImageFile(avShad, loadedTextures["files/img/avshad.png"])
    sightxports.sGui:setImageColor(avShad, {
      255,
      255,
      255,
      100
    })
    local y = topSize + 16 + 168 + 6
    local label = sightxports.sGui:createGuiElement("label", 0, y, bsx, 16, appInside)
    sightxports.sGui:setLabelFont(label, "12/Ubuntu-R.ttf")
    sightxports.sGui:setLabelAlignment(label, "center", "center")
    sightxports.sGui:setLabelColor(label, "#000000")
    sightxports.sGui:setLabelText(label, contact[3])
    y = y + 16
    local label = sightxports.sGui:createGuiElement("label", 0, y, bsx, 16, appInside)
    sightxports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
    sightxports.sGui:setLabelAlignment(label, "center", "center")
    sightxports.sGui:setLabelColor(label, "#333333")
    sightxports.sGui:setLabelText(label, formatPhoneNumber(contact[4]))
    y = y + 16 + 8
    local w = contact[7] and (bsx - 60) / 2 or (bsx - 60) / 3
    local icon = sightxports.sGui:createGuiElement("image", math.floor(30 + w * 0.5 - 16), y, 32, 32, appInside)
    sightxports.sGui:setImageFile(icon, sightxports.sGui:getFaIconFilename("phone", 32))
    sightxports.sGui:setImageColor(icon, blue)
    sightxports.sGui:setGuiHoverable(icon, true)
    sightxports.sGui:setClickEvent(icon, "openDialerFromContact")
    local icon = sightxports.sGui:createGuiElement("image", math.ceil(30 + w * 1.5 - 16), y, 32, 32, appInside)
    sightxports.sGui:setImageFile(icon, sightxports.sGui:getFaIconFilename("comment", 32))
    sightxports.sGui:setImageColor(icon, yellow)
    sightxports.sGui:setGuiHoverable(icon, true)
    sightxports.sGui:setClickEvent(icon, "openSMSFromContacts")
    if not contact[7] then
      local icon = sightxports.sGui:createGuiElement("image", math.ceil(30 + w * 2.5 - 16), y, 32, 32, appInside)
      sightxports.sGui:setImageFile(icon, sightxports.sGui:getFaIconFilename("pen", 32))
      sightxports.sGui:setImageColor(icon, green)
      sightxports.sGui:setGuiHoverable(icon, true)
      sightxports.sGui:setClickEvent(icon, "editContact")
    end
    y = y + 32 + 8
    local h = math.floor((bsy - y - topSize * 1.5) / 5)
    local logData = {}
    if fileExists("sms/" .. contact[4] .. ".sight") then
      local file = fileOpen("sms/" .. contact[4] .. ".sight", true)
      if file then
        local pos = fileGetSize(file) - 1
        local c = 0
        local buffer = ""
        while 0 <= pos do
          fileSetPos(file, pos)
          local data = fileRead(file, 1)
          if data == "\n" or pos == 0 then
            if pos == 0 then
              buffer = data .. buffer
            end
            if 0 < utf8.len(buffer) then
              local dat = split(buffer, "#")
              if tonumber(dat[2]) and (tonumber(dat[3]) or 2) == 1 then
                table.insert(logData, {
                  tonumber(dat[2]),
                  "sms",
                  tonumber(dat[4]) == 1
                })
                c = c + 1
              end
            end
            if 5 <= c then
              break
            end
            buffer = ""
          else
            buffer = data .. buffer
          end
          pos = pos - 1
        end
        fileClose(file)
      end
    end
    local last = #logData
    if fileExists("callog.sight") then
      local file = fileOpen("callog.sight", true)
      if file then
        local pos = fileGetSize(file) - 1
        local buffer = ""
        while 0 <= pos do
          fileSetPos(file, pos)
          local data = fileRead(file, 1)
          if data == "\n" or pos == 0 then
            if pos == 0 then
              buffer = data .. buffer
            end
            local dat = split(buffer, "#")
            buffer = ""
            if tonumber(dat[1]) and tonumber(dat[2]) and tonumber(dat[3]) then
              if 0 < last and logData[last][1] > (tonumber(dat[2]) or 0) then
                break
              end
              if tonumber(dat[3]) == contact[4] then
                table.insert(logData, {
                  tonumber(dat[2]),
                  "call",
                  tonumber(dat[1])
                })
                if 10 <= #logData then
                  break
                end
              end
            end
          else
            buffer = data .. buffer
          end
          pos = pos - 1
        end
        fileClose(file)
      end
    end
    table.sort(logData, logSort)
    for i = 1, 5 do
      local y = bsy - topSize * 1.5 - (5 - i + 1) * h
      if logData[i] then
        local rect = sightxports.sGui:createGuiElement("rectangle", 0, y, bsx, h, appInside)
        sightxports.sGui:setGuiBackground(rect, "solid", {
          255,
          255,
          255
        })
        local border = sightxports.sGui:createGuiElement("hr", 0, -1, bsx, 1, rect)
        sightxports.sGui:setGuiHrColor(border, grey2, grey2)
        local icon = sightxports.sGui:createGuiElement("image", 10, 4, h - 8, h - 8, rect)
        sightxports.sGui:setImageFile(icon, sightxports.sGui:getFaIconFilename(logData[i][2] == "sms" and "envelope" or "phone", h - 8))
        if logData[i][2] == "sms" then
          if logData[i][3] then
            sightxports.sGui:setImageColor(icon, blue)
          else
            sightxports.sGui:setImageColor(icon, green)
          end
        elseif logData[i][3] == 2 then
          sightxports.sGui:setImageColor(icon, green)
        elseif logData[i][3] == 1 then
          sightxports.sGui:setImageColor(icon, blue)
        else
          sightxports.sGui:setImageColor(icon, red)
        end
        local label = sightxports.sGui:createGuiElement("label", 8 + h, 2, bsx, (h - 4) / 2, rect)
        sightxports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
        sightxports.sGui:setLabelAlignment(label, "left", "center")
        sightxports.sGui:setLabelColor(label, "#000000")
        if logData[i][2] == "sms" then
          if logData[i][3] then
            sightxports.sGui:setLabelText(label, "Küldött SMS")
          else
            sightxports.sGui:setLabelText(label, "Fogadott SMS")
          end
        elseif logData[i][3] == 2 then
          sightxports.sGui:setLabelText(label, "Bejövő hívás")
        elseif logData[i][3] == 1 then
          sightxports.sGui:setLabelText(label, "Kimenő hívás")
        else
          sightxports.sGui:setLabelText(label, "Nem fogadott hívás")
        end
        local label = sightxports.sGui:createGuiElement("label", 8 + h, (h - 4) / 2, bsx, (h - 4) / 2, rect)
        sightxports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
        sightxports.sGui:setLabelAlignment(label, "left", "center")
        sightxports.sGui:setLabelColor(label, "#333333")
        local time = getRealTime(logData[i][1])
        local date = string.format("%04d. %02d. %02d. %02d:%02d:%02d", time.year + 1900, time.month + 1, time.monthday, time.hour, time.minute, time.second)
        sightxports.sGui:setLabelText(label, date)
      end
    end
  end
  if singleFromSMS then
    singleFromSMS = false
    generateBottom(true, "openSMSList")
  else
    generateBottom(true, "openContacts")
  end
  bringBackFront()
end
local contactLetterLabel = false
local newContactColor = false
local contactNameInput = false
local contactNumInput = false
local newContactNum = false
local newToColor = {}
addEvent("editContact", false)
addEventHandler("editContact", getRootElement(), function()
  newContactColor = false
  editingContact = selectedContact
  switchAppScreen("contact_new")
end)
addEvent("openNewContact", false)
addEventHandler("openNewContact", getRootElement(), function()
  editingContact = false
  newContactColor = math.random(#contactColors)
  switchAppScreen("contact_new")
end)
function openNewContactForDialer(num)
  newContactNum = num
  editingContact = false
  newContactColor = math.random(#contactColors)
  switchAppScreen("contact_new")
end
addEvent("openNewContactForSMS", false)
addEventHandler("openNewContactForSMS", getRootElement(), function()
  selectedContact = false
  for i = 1, #phoneContacts do
    if phoneContacts[i][4] == dottedMenuNum then
      selectedContact = i
      break
    end
  end
  singleFromSMS = true
  if selectedContact then
    switchAppScreen("contact_single")
  else
    newContactNum = dottedMenuNum
    editingContact = false
    newContactColor = math.random(#contactColors)
    switchAppScreen("contact_new")
  end
end)
addEvent("refreshNewContactLabel", false)
addEventHandler("refreshNewContactLabel", getRootElement(), function()
  if contactLetterLabel then
    local value = sightxports.sGui:getInputValue(contactNameInput) or ""
    sightxports.sGui:setLabelText(contactLetterLabel, utf8.upper(utf8.sub(value, 1, 1)))
  end
end)
local colorButtons = {}
addEvent("refreshNewContactColor", false)
addEventHandler("refreshNewContactColor", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  if colorButtons[el] then
    newContactColor = colorButtons[el]
    local col = newContactColor
    for i = 1, #newToColor do
      if i <= 2 then
        sightxports.sGui:setGuiBackground(newToColor[i], "solid", {
          contactColors[col][1],
          contactColors[col][2],
          contactColors[col][3]
        })
      else
        sightxports.sGui:setImageColor(newToColor[i], {
          contactColors[col][1],
          contactColors[col][2],
          contactColors[col][3]
        })
      end
    end
  end
end)
addEvent("finalNewContact", false)
addEventHandler("finalNewContact", getRootElement(), function()
  local success = true
  local contactName = sightxports.sGui:getInputValue(contactNameInput) or ""
  local contactNum = sightxports.sGui:getInputValue(contactNumInput) or ""
  if utf8.len(contactName) < 1 then
    sightxports.sGui:setInputColor(contactNameInput, red, "#ffffff", "#000000", "#ffffff", "#000000")
    success = false
  else
    sightxports.sGui:setInputColor(contactNameInput, grey3, "#ffffff", "#000000", "#ffffff", "#000000")
  end
  contactNum = utf8.gsub(contactNum, " ", "")
  contactNum = utf8.gsub(contactNum, "-", "")
  contactNum = utf8.gsub(contactNum, "+", "")
  contactNum = tonumber(contactNum)
  if not contactNum or contactNum < 1 or contactsReversed[contactNum] then
    sightxports.sGui:setInputColor(contactNumInput, red, "#ffffff", "#000000", "#ffffff", red)
    success = false
  else
    sightxports.sGui:setInputColor(contactNumInput, grey3, "#ffffff", "#000000", "#ffffff", "#000000")
  end
  if success then
    local id = lastContact + 1
    table.insert(phoneContacts, {
      utf8.upper(utf8.sub(contactName, 1, 1)),
      newContactColor,
      contactName,
      contactNum,
      false,
      id
    })
    processContacts()
    saveContacts()
    for i = 1, #phoneContacts do
      if phoneContacts[i][6] == id then
        selectedContact = i
        break
      end
    end
    switchAppScreen("contact_single")
  end
end)
addEvent("finalEditContact", false)
addEventHandler("finalEditContact", getRootElement(), function()
  local success = true
  local contactName = sightxports.sGui:getInputValue(contactNameInput) or ""
  local contactNum = sightxports.sGui:getInputValue(contactNumInput) or ""
  if utf8.len(contactName) < 1 then
    sightxports.sGui:setInputColor(contactNameInput, red, "#ffffff", "#000000", "#ffffff", "#000000")
    success = false
  else
    sightxports.sGui:setInputColor(contactNameInput, grey3, "#ffffff", "#000000", "#ffffff", "#000000")
  end
  contactNum = utf8.gsub(contactNum, " ", "")
  contactNum = utf8.gsub(contactNum, "-", "")
  contactNum = utf8.gsub(contactNum, "+", "")
  contactNum = tonumber(contactNum)
  if not contactNum or contactNum < 1 or contactsReversed[contactNum] and contactsReversed[contactNum] ~= editingContact then
    sightxports.sGui:setInputColor(contactNumInput, red, "#ffffff", "#000000", "#ffffff", red)
    success = false
  else
    sightxports.sGui:setInputColor(contactNumInput, grey3, "#ffffff", "#000000", "#ffffff", "#000000")
  end
  if success then
    phoneContacts[editingContact] = {
      phoneContacts[editingContact][1] == "dds" and phoneContacts[editingContact][1] or utf8.upper(utf8.sub(contactName, 1, 1)),
      newContactColor or phoneContacts[editingContact][2],
      contactName,
      contactNum,
      false,
      phoneContacts[editingContact][6]
    }
    processContacts()
    saveContacts()
    selectedContact = editingContact
    switchAppScreen("contact_single")
  end
end)
function appScreens.contact_new()
  appInside = sightxports.sGui:createGuiElement("null", 0, 0, bsx, bsy, mobileBackground)
  local rect = sightxports.sGui:createGuiElement("rectangle", 0, 0, bsx, bsy, appInside)
  sightxports.sGui:setGuiBackground(rect, "solid", {
    255,
    255,
    255
  })
  local contact = editingContact and phoneContacts[editingContact]
  local col = newContactColor or contact[2]
  local ry = math.floor((topSize + 16 + 168) * 0.8)
  local rect = sightxports.sGui:createGuiElement("rectangle", 0, 0, bsx, ry, appInside)
  sightxports.sGui:setGuiBackground(rect, "solid", {
    contactColors[col][1],
    contactColors[col][2],
    contactColors[col][3]
  })
  newToColor = {rect}
  local x, y, sx, sy = bsx / 2 - 84 + 4, topSize + 16 + 4, 160, 160
  avRect = sightxports.sGui:createGuiElement("rectangle", x, y, sx, sy, appInside)
  sightxports.sGui:setGuiBackground(avRect, "solid", {
    contactColors[col][1],
    contactColors[col][2],
    contactColors[col][3]
  })
  table.insert(newToColor, avRect)
  contactLetterLabel = false
  if not contact then
    contactLetterLabel = sightxports.sGui:createGuiElement("label", x, y, sx, sy, appInside)
    sightxports.sGui:setLabelFont(contactLetterLabel, "50/Ubuntu-R.ttf")
    sightxports.sGui:setLabelAlignment(contactLetterLabel, "center", "center")
    sightxports.sGui:setLabelColor(contactLetterLabel, "#ffffff")
    sightxports.sGui:setLabelText(contactLetterLabel, "")
  elseif contact[1] == "dds" then
    local img = sightxports.sGui:createGuiElement("image", x, y, sx, sy, appInside)
    sightxports.sGui:setImageDDS(img, "!mobile_sight/contacts/" .. contact[6] .. ".dds", "dxt1", false, true)
  elseif type(contact[1]) == "string" then
    local label = sightxports.sGui:createGuiElement("label", x, y, sx, sy, appInside)
    sightxports.sGui:setLabelFont(label, "50/Ubuntu-R.ttf")
    sightxports.sGui:setLabelAlignment(label, "center", "center")
    sightxports.sGui:setLabelColor(label, "#ffffff")
    sightxports.sGui:setLabelText(label, contact[1])
    contactLetterLabel = label
  elseif type(contact[1]) == "table" then
    local is = math.floor(sx * 0.6)
    local icon = sightxports.sGui:createGuiElement("image", x + sx / 2 - is / 2, y + sy / 2 - is / 2, is, is, appInside)
    sightxports.sGui:setImageFile(icon, sightxports.sGui:getFaIconFilename(contact[1][1], is, contact[1][2]))
    sightxports.sGui:setImageColor(icon, "#ffffff")
  else
    local label = sightxports.sGui:createGuiElement("label", x, y, sx, sy, appInside)
    sightxports.sGui:setLabelFont(label, "50/Ubuntu-R.ttf")
    sightxports.sGui:setLabelAlignment(label, "center", "center")
    sightxports.sGui:setLabelColor(label, "#ffffff")
    sightxports.sGui:setLabelText(label, "?")
    contactLetterLabel = label
  end
  local img = sightxports.sGui:createGuiElement("image", bsx / 2 - 84, topSize + 16, 168, ry - (topSize + 16), appInside)
  sightxports.sGui:setImageFile(img, loadedTextures["files/img/avcut_lg.png"])
  sightxports.sGui:setImageColor(img, {
    contactColors[col][1],
    contactColors[col][2],
    contactColors[col][3]
  })
  sightxports.sGui:setImageUV(img, 0, 0, 168, ry - (topSize + 16))
  table.insert(newToColor, img)
  local img = sightxports.sGui:createGuiElement("image", bsx / 2 - 84, ry, 168, topSize + 16 + 168 - ry, appInside)
  sightxports.sGui:setImageFile(img, loadedTextures["files/img/avcut_lg.png"])
  sightxports.sGui:setImageUV(img, 0, ry - (topSize + 16), 168, topSize + 16 + 168 - ry)
  local img = sightxports.sGui:createGuiElement("image", bsx / 2 - 84 - 6, topSize + 16 - 6, 180, 180, appInside)
  sightxports.sGui:setImageFile(img, loadedTextures["files/img/avshad.png"])
  sightxports.sGui:setImageColor(img, {
    255,
    255,
    255,
    100
  })
  local y = topSize + 16 + 168 + 6 + 8
  contactNameInput = sightxports.sGui:createGuiElement("input", 8, y, bsx - 16, 32, appInside)
  sightxports.sGui:setInputColor(contactNameInput, grey3, "#ffffff", "#000000", "#ffffff", "#000000")
  sightxports.sGui:setInputFont(contactNameInput, "11/Ubuntu-R.ttf")
  sightxports.sGui:setInputPlaceholder(contactNameInput, "Név")
  sightxports.sGui:setInputMaxLength(contactNameInput, 20)
  sightxports.sGui:setInputBorderSize(contactNameInput, 0.5)
  sightxports.sGui:setInputChangeEvent(contactNameInput, "refreshNewContactLabel")
  if contact then
    sightxports.sGui:setInputValue(contactNameInput, contact[3])
  end
  local border = sightxports.sGui:createGuiElement("hr", 8, y + 32 - 1, bsx - 16, 1, appInside)
  sightxports.sGui:setGuiHrColor(border, grey2, grey2)
  y = y + 32 + 8
  contactNumInput = sightxports.sGui:createGuiElement("input", 8, y, bsx - 16, 32, appInside)
  sightxports.sGui:setInputColor(contactNumInput, grey3, "#ffffff", "#000000", "#ffffff", "#000000")
  sightxports.sGui:setInputFont(contactNumInput, "11/Ubuntu-R.ttf")
  sightxports.sGui:setInputPlaceholder(contactNumInput, "Telefonszám")
  sightxports.sGui:setInputMaxLength(contactNumInput, 32)
  sightxports.sGui:setInputBorderSize(contactNumInput, 0.5)
  if newContactNum then
    sightxports.sGui:setInputValue(contactNumInput, formatPhoneNumber(newContactNum))
  elseif contact then
    sightxports.sGui:setInputValue(contactNumInput, formatPhoneNumber(contact[4]))
  end
  local border = sightxports.sGui:createGuiElement("hr", 8, y + 32 - 1, bsx - 16, 1, appInside)
  sightxports.sGui:setGuiHrColor(border, grey2, grey2)
  y = y + 32 + 8
  colorButtons = {}
  local xn = math.floor(#contactColors / 2)
  local xs = (bsx - 16) / xn
  local k = 0
  for i = 0, xn - 1 do
    for j = 0, 1 do
      k = k + 1
      local rect = sightxports.sGui:createGuiElement("rectangle", 8 + i * xs, y + j * xs, xs, xs, appInside)
      sightxports.sGui:setGuiBackground(rect, "solid", {
        contactColors[k][1],
        contactColors[k][2],
        contactColors[k][3]
      })
      sightxports.sGui:setGuiHover(rect, "none", {
        contactColors[k][1],
        contactColors[k][2],
        contactColors[k][3]
      }, false, true)
      sightxports.sGui:setGuiHoverable(rect, true)
      sightxports.sGui:setClickEvent(rect, "refreshNewContactColor")
      colorButtons[rect] = k
    end
  end
  if contact then
    local btn = sightxports.sGui:createGuiElement("button", 8, bsy - topSize * 1.5 - 56, bsx - 16, 24, appInside)
    sightxports.sGui:setGuiBackground(btn, "solid", green)
    sightxports.sGui:setGuiHover(btn, "none", green, false, true)
    sightxports.sGui:setButtonTextColor(btn, "#ffffff")
    sightxports.sGui:setButtonText(btn, "Névjegy szerkesztése")
    sightxports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
    sightxports.sGui:setClickEvent(btn, "finalEditContact")
    local btn = sightxports.sGui:createGuiElement("button", 8, bsy - topSize * 1.5 - 24 - 4, bsx - 16, 24, appInside)
    sightxports.sGui:setGuiBackground(btn, "solid", red)
    sightxports.sGui:setGuiHover(btn, "none", red, false, true)
    sightxports.sGui:setButtonTextColor(btn, "#ffffff")
    sightxports.sGui:setButtonText(btn, "Névjegy törlése")
    sightxports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
    sightxports.sGui:setClickEvent(btn, "finalDeleteContact")
    generateBottom(true, "openSingleContactEx")
  else
    local btn = sightxports.sGui:createGuiElement("button", 8, bsy - topSize * 1.5 - 24 - 4, bsx - 16, 24, appInside)
    sightxports.sGui:setGuiBackground(btn, "solid", green)
    sightxports.sGui:setGuiHover(btn, "none", green, false, true)
    sightxports.sGui:setButtonTextColor(btn, "#ffffff")
    sightxports.sGui:setButtonText(btn, "Névjegy létrehozása")
    sightxports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
    sightxports.sGui:setClickEvent(btn, "finalNewContact")
    if singleFromSMS then
      singleFromSMS = false
      generateBottom(true, "openSMSList")
    else
      generateBottom(true, "openContacts")
    end
  end
  bringBackFront()
end
addEvent("openContacts", false)
addEventHandler("openContacts", getRootElement(), function()
  switchAppScreen("contacts")
end)
local contactData = {}
addEvent("selectContact", false)
addEventHandler("selectContact", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  if contactData[el] and phoneContacts[contactData[el]] then
    selectedContact = contactData[el]
    switchAppScreen("contact_single")
  end
end)
local contactScroll = 0
function contactScrollKey(key)
  if key == "mouse_wheel_up" then
    if 0 < contactScroll then
      contactScroll = contactScroll - 1
      refreshContactList()
    end
  elseif key == "mouse_wheel_down" and contactScroll < math.max(0, #phoneContacts - 8) then
    contactScroll = contactScroll + 1
    refreshContactList()
  end
end
local scrollBar = false
function refreshContactList()
  local n = math.max(0, #phoneContacts - 8)
  local y = topSize
  local h = math.floor((bsy - y - topSize * 1.5 - 32 - 24) / 8)
  local ts = bsy - y - topSize * 1.5 - 24 - h * 8
  y = y + ts
  local sh = (bsy - topSize * 2.5 - ts - 24 - 8) / (n + 1)
  sightxports.sGui:setGuiPosition(scrollBar, false, topSize + ts + 4 + contactScroll * sh)
  for i = 1, #phoneContacts do
    for j = 1, #contactListAvatars[i] do
      sightxports.sGui:setGuiRenderDisabled(contactListAvatars[i][j][1], i - contactScroll < 1 or 8 < i - contactScroll)
    end
  end
  for i = 1, 8 do
    local j = i + contactScroll
    if phoneContacts[j] then
      for k = 1, #contactListAvatars[j] do
        sightxports.sGui:setGuiPosition(contactListAvatars[j][k][1], false, y + contactListAvatars[j][k][2])
      end
      sightxports.sGui:guiToFront(contactListElements[i][2])
      contactData[contactListElements[i][1]] = j
      local label = contactListElements[i][3]
      sightxports.sGui:setLabelText(label, phoneContacts[j][3])
      local label = contactListElements[i][4]
      sightxports.sGui:setLabelText(label, formatPhoneNumber(phoneContacts[j][4]))
      y = y + h
    end
  end
  bringBackFront()
end
function appCloses.contacts()
  removeEventHandler("onClientKey", getRootElement(), contactScrollKey)
end
function appScreens.contacts()
  appInside = sightxports.sGui:createGuiElement("null", 0, 0, bsx, bsy, mobileBackground)
  addEventHandler("onClientKey", getRootElement(), contactScrollKey)
  local rect = sightxports.sGui:createGuiElement("rectangle", 0, 0, bsx, bsy, appInside)
  sightxports.sGui:setGuiBackground(rect, "solid", {
    255,
    255,
    255
  })
  local y = topSize
  local h = math.floor((bsy - y - topSize * 1.5 - 32 - 24) / 8)
  local ts = bsy - y - topSize * 1.5 - 24 - h * 8
  local topRect = sightxports.sGui:createGuiElement("rectangle", 0, 0, bsx, ts + topSize, appInside)
  sightxports.sGui:setGuiBackground(topRect, "solid", blue)
  local icon = sightxports.sGui:createGuiElement("image", bsx - 24 - 8, topSize + ts / 2 - 12, 24, 24, appInside)
  sightxports.sGui:setImageFile(icon, sightxports.sGui:getFaIconFilename("plus", 24, "solid"))
  sightxports.sGui:setGuiHoverable(icon, true)
  sightxports.sGui:setClickEvent(icon, "openNewContact")
  local label = sightxports.sGui:createGuiElement("label", 8, topSize, bsx - 16, ts, appInside)
  sightxports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
  sightxports.sGui:setLabelAlignment(label, "center", "center")
  sightxports.sGui:setLabelColor(label, "#ffffff")
  sightxports.sGui:setLabelText(label, "Névjegyek")
  y = y + ts
  local w = (bsx - 8) / 3
  local btn = sightxports.sGui:createGuiElement("button", 4, bsy - topSize * 1.5 - 24, w, 24, appInside)
  sightxports.sGui:setGuiBackground(btn, "solid", blue2)
  sightxports.sGui:setGuiHover(btn, "none", blue2, false, true)
  sightxports.sGui:setButtonTextColor(btn, "#ffffff")
  sightxports.sGui:setButtonText(btn, "Névjegyek")
  sightxports.sGui:setButtonFont(btn, "9/Ubuntu-R.ttf")
  local btn = sightxports.sGui:createGuiElement("button", 4 + w, bsy - topSize * 1.5 - 24, w, 24, appInside)
  sightxports.sGui:setGuiBackground(btn, "solid", blue)
  sightxports.sGui:setGuiHover(btn, "none", blue, false, true)
  sightxports.sGui:setButtonTextColor(btn, "#ffffff")
  sightxports.sGui:setButtonText(btn, "Legutóbbi")
  sightxports.sGui:setButtonFont(btn, "9/Ubuntu-R.ttf")
  sightxports.sGui:setClickEvent(btn, "openPhoneApp")
  local btn = sightxports.sGui:createGuiElement("button", 4 + w * 2, bsy - topSize * 1.5 - 24, w, 24, appInside)
  sightxports.sGui:setGuiBackground(btn, "solid", blue)
  sightxports.sGui:setGuiHover(btn, "none", blue, false, true)
  sightxports.sGui:setButtonTextColor(btn, "#ffffff")
  sightxports.sGui:setButtonText(btn, "Tárcsázó")
  sightxports.sGui:setButtonFont(btn, "9/Ubuntu-R.ttf")
  sightxports.sGui:setClickEvent(btn, "openDialer")
  contactListElements = {}
  contactListAvatars = {}
  contactData = {}
  local n = math.max(0, #phoneContacts - 8)
  if n < contactScroll then
    contactScroll = n
  end
  for i = 1, #phoneContacts do
    if i <= 8 and phoneContacts[i] then
      contactListElements[i] = {}
      local rect = sightxports.sGui:createGuiElement("rectangle", 0, y, bsx - 12, h, appInside)
      sightxports.sGui:setGuiBackground(rect, "solid", "#ffffff")
      sightxports.sGui:setGuiHover(rect, "solid", "#ffffff", false, true)
      sightxports.sGui:setGuiHoverable(rect, true)
      sightxports.sGui:setClickEvent(rect, "selectContact")
      table.insert(contactListElements[i], rect)
      contactData[rect] = i
      local img = sightxports.sGui:createGuiElement("image", 6, y + 2, h - 4, h - 4, appInside)
      sightxports.sGui:setImageFile(img, loadedTextures["files/img/avcut_sm.png"])
      sightxports.sGui:setImageColor(img, "#ffffff")
      table.insert(contactListElements[i], img)
      local label = sightxports.sGui:createGuiElement("label", 6 + h + 2, y + 4, bsx, (h - 8) / 2, appInside)
      sightxports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
      sightxports.sGui:setLabelAlignment(label, "left", "center")
      sightxports.sGui:setLabelColor(label, "#000000")
      sightxports.sGui:setLabelText(label, phoneContacts[i][3])
      table.insert(contactListElements[i], label)
      local label = sightxports.sGui:createGuiElement("label", 6 + h + 2, y + 4 + (h - 8) / 2, bsx, (h - 8) / 2, appInside)
      sightxports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
      sightxports.sGui:setLabelAlignment(label, "left", "center")
      sightxports.sGui:setLabelColor(label, "#000000")
      sightxports.sGui:setLabelText(label, formatPhoneNumber(phoneContacts[i][4]))
      table.insert(contactListElements[i], label)
      if i < 8 then
        local border = sightxports.sGui:createGuiElement("hr", 0, y + h - 1, bsx - 12, 1, appInside)
        sightxports.sGui:setGuiHrColor(border, grey2, grey2)
        table.insert(contactListElements[i], border)
      end
      y = y + h
    end
    if phoneContacts[i] then
      contactListAvatars[i] = {}
      local y = y - h
      if phoneContacts[i][2] then
        local col = phoneContacts[i][2]
        if phoneContacts[i][1] ~= "dds" then
          local rect = sightxports.sGui:createGuiElement("rectangle", 7, y + 3, h - 6, h - 6, appInside)
          sightxports.sGui:setGuiBackground(rect, "solid", {
            contactColors[col][1],
            contactColors[col][2],
            contactColors[col][3]
          })
          sightxports.sGui:setGuiRenderDisabled(rect, 8 < i)
          table.insert(contactListAvatars[i], {rect, 3})
        end
        if phoneContacts[i][1] == "dds" then
          local img = sightxports.sGui:createGuiElement("image", 6, y + 2, h - 4, h - 4, appInside)
          sightxports.sGui:setImageDDS(img, "!mobile_sight/contacts/" .. phoneContacts[i][6] .. ".dds", "dxt1", false, true)
          sightxports.sGui:setGuiRenderDisabled(img, 8 < i)
          table.insert(contactListAvatars[i], {img, 2})
        elseif type(phoneContacts[i][1]) == "string" then
          local label = sightxports.sGui:createGuiElement("label", 6, y + 2, h - 4, h - 4, appInside)
          sightxports.sGui:setLabelFont(label, "14/Ubuntu-R.ttf")
          sightxports.sGui:setLabelAlignment(label, "center", "center")
          sightxports.sGui:setLabelColor(label, "#ffffff")
          sightxports.sGui:setLabelText(label, phoneContacts[i][1])
          sightxports.sGui:setGuiRenderDisabled(label, 8 < i)
          table.insert(contactListAvatars[i], {label, 2})
        elseif type(phoneContacts[i][1]) == "table" then
          local icon = sightxports.sGui:createGuiElement("image", 6 + (h - 4) / 2 - 12, y + 2 + (h - 4) / 2 - 12, 24, 24, appInside)
          sightxports.sGui:setImageFile(icon, sightxports.sGui:getFaIconFilename(phoneContacts[i][1][1], 24, phoneContacts[i][1][2]))
          sightxports.sGui:setImageColor(icon, "#ffffff")
          sightxports.sGui:setGuiRenderDisabled(icon, 8 < i)
          table.insert(contactListAvatars[i], {
            icon,
            (h - 4) / 2 - 12
          })
        else
          local label = sightxports.sGui:createGuiElement("label", 6, y + 2, h - 4, h - 4, appInside)
          sightxports.sGui:setLabelFont(label, "14/Ubuntu-R.ttf")
          sightxports.sGui:setLabelAlignment(label, "center", "center")
          sightxports.sGui:setLabelColor(label, "#ffffff")
          sightxports.sGui:setLabelText(label, "?")
          sightxports.sGui:setGuiRenderDisabled(label, 8 < i)
          table.insert(contactListAvatars[i], {label, 2})
        end
      end
      if i <= 8 then
        sightxports.sGui:guiToFront(contactListElements[i][2])
      end
    end
  end
  local rect = sightxports.sGui:createGuiElement("rectangle", bsx - 9, topSize + ts + 4, 3, bsy - topSize * 2.5 - ts - 24 - 8, appInside)
  sightxports.sGui:setGuiBackground(rect, "solid", grey1)
  local sh = (bsy - topSize * 2.5 - ts - 24 - 8) / (n + 1)
  scrollBar = sightxports.sGui:createGuiElement("rectangle", bsx - 9, topSize + ts + 4 + contactScroll * sh, 3, sh, appInside)
  sightxports.sGui:setGuiBackground(scrollBar, "solid", grey3)
  if 0 < contactScroll then
    refreshContactList()
  end
  generateBottom(true)
  bringBackFront()
end
