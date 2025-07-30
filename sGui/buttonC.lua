local steelangDynImgHand = false
local steelangDynImgLatCr = falselocal
steelangDynImage = {}
local steelangDynImageForm = {}
local steelangDynImageMip = {}
local steelangDynImageUsed = {}
local steelangDynImageDel = {}
local steelangDynImgPre
function steelangDynImgPre()
  local now = getTickCount()
  steelangDynImgLatCr = true
  local rem = true
  for k in pairs(steelangDynImage) do
    rem = false
    if steelangDynImageDel[k] then
      if now >= steelangDynImageDel[k] then
        if isElement(steelangDynImage[k]) then
          destroyElement(steelangDynImage[k])
        end
        steelangDynImage[k] = nil
        steelangDynImageForm[k] = nil
        steelangDynImageMip[k] = nil
        steelangDynImageDel[k] = nil
        break
      end
    elseif not steelangDynImageUsed[k] then
      steelangDynImageDel[k] = now + 5000
    end
  end
  for k in pairs(steelangDynImageUsed) do
    if not steelangDynImage[k] and steelangDynImgLatCr then
      steelangDynImgLatCr = false
      steelangDynImage[k] = dxCreateTexture(k, steelangDynImageForm[k], steelangDynImageMip[k])
    end
    steelangDynImageUsed[k] = nil
    steelangDynImageDel[k] = nil
    rem = false
  end
  if rem then
    removeEventHandler("onClientPreRender", getRootElement(), steelangDynImgPre)
    steelangDynImgHand = false
  end
end
local function dynamicImage(img, form, mip)
  if not steelangDynImgHand then
    steelangDynImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), steelangDynImgPre, true, "high+999999999")
  end
  if not steelangDynImage[img] then
    steelangDynImage[img] = dxCreateTexture(img, form, mip)
  end
  steelangDynImageForm[img] = form
  steelangDynImageUsed[img] = true
  return steelangDynImage[img]
end
function renderFunctions.button(el)
  renderBackground(el)
  local color = guiElements[el].fontColor or tocolor(255, 255, 255)
  if guiElements[el].fadeIn then
    local progress = getEasingValue(math.min(1, (now - guiElements[el].fadeIn) / guiElements[el].fadeInTime), "InOutQuad")
    color = bitReplace(color, bitExtract(color, 24, 8) * progress, 24, 8)
    guiElements[el].faded = false
    if 1 <= progress then
      guiElements[el].fadeIn = false
    end
  end
  if guiElements[el].fadeOut then
    local progress = 1 - getEasingValue(math.min(1, (now - guiElements[el].fadeOut) / guiElements[el].fadeOutTime), "InOutQuad")
    color = bitReplace(color, bitExtract(color, 24, 8) * progress, 24, 8)
    if progress <= 0 then
      guiElements[el].fadeOut = false
      guiElements[el].faded = true
    end
  end
  if guiElements[el].icon then
    local fileName = guiElements[el].icon
    if type(fileName) == "string" then
      fileName = fileName .. (faTicks[guiElements[el].icon] and faTicks[guiElements[el].icon] or "")
    end
    local is = guiElements[el].textHeight or math.min(guiElements[el].sx, guiElements[el].sy) * 0.75
    local x = guiElements[el].x + guiElements[el].sx / 2
    local sx = is
    if guiElements[el].text then
      sx = sx + guiElements[el].textWidth
    end
    x = x - sx / 2
    local y = guiElements[el].y + guiElements[el].sy / 2 - is / 2
    if guiElements[el].iconDDS then
      dxDrawImage(x, y, is, is, dynamicImage(fileName), 0, 0, 0, guiElements[el].iconColor or color)
    else
      dxDrawImage(x, y, is, is, fileName, 0, 0, 0, guiElements[el].iconColor or color)
    end
    if guiElements[el].text then
      dxDrawText(guiElements[el].text, x + is, guiElements[el].y + (guiElements[el].py or 0), 0, guiElements[el].y + guiElements[el].sy - (guiElements[el].py or 0), color, fontScales[guiElements[el].font], guiElements[el].font, "left", "center")
    end
  elseif guiElements[el].text then
    dxDrawText(guiElements[el].text, guiElements[el].x + (guiElements[el].px or 0), guiElements[el].y + (guiElements[el].py or 0), guiElements[el].x + guiElements[el].sx - (guiElements[el].px or 0), guiElements[el].y + guiElements[el].sy - (guiElements[el].py or 0), color, fontScales[guiElements[el].font], guiElements[el].font, guiElements[el].al1 or "center", guiElements[el].al2 or "center")
  end
end
function setButtonFont(el, font)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "button" then
      guiElements[el].font = getFont(font)
      if guiElements[el].icon then
        if guiElements[el].text then
          guiElements[el].textWidth = getTextWidthFont(guiElements[el].text, guiElements[el].font)
        end
        guiElements[el].textHeight = getFontHeight(guiElements[el].font)
      end
    else
      throwGuiError("setButtonFont: guiElement is not button")
    end
  else
    throwGuiError("setButtonFont: invalid guiElement")
  end
end
function setButtonIcon(el, file)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "button" then
      guiElements[el].icon = file
      guiElements[el].iconDDS = false
      if guiElements[el].icon and guiElements[el].font then
        if guiElements[el].text then
          guiElements[el].textWidth = getTextWidthFont(guiElements[el].text, guiElements[el].font)
        end
        guiElements[el].textHeight = getFontHeight(guiElements[el].font)
      end
    else
      throwGuiError("setButtonIcon: guiElement is not button")
    end
  else
    throwGuiError("setButtonIcon: invalid guiElement (" .. tostring(el) .. ")")
  end
end
function setButtonIconDDS(el, file)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "button" then
      guiElements[el].icon = file
      guiElements[el].iconDDS = true
      if guiElements[el].icon and guiElements[el].font then
        if guiElements[el].text then
          guiElements[el].textWidth = getTextWidthFont(guiElements[el].text, guiElements[el].font)
        end
        guiElements[el].textHeight = getFontHeight(guiElements[el].font)
      end
    else
      throwGuiError("setButtonIconDDS: guiElement is not button")
    end
  else
    throwGuiError("setButtonIconDDS: invalid guiElement (" .. tostring(el) .. ")")
  end
end
function setButtonTextPadding(el, px, py)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "button" then
      guiElements[el].px = px
      guiElements[el].py = py
    else
      throwGuiError("setButtonTextPadding: guiElement is not button")
    end
  else
    throwGuiError("setButtonTextPadding: invalid guiElement")
  end
end
function setButtonTextAlign(el, al1, al2)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "button" then
      guiElements[el].al1 = al1
      guiElements[el].al2 = al2
    else
      throwGuiError("setButtonTextAlign: guiElement is not button")
    end
  else
    throwGuiError("setButtonTextAlign: invalid guiElement")
  end
end
function setButtonTextColor(el, color)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "button" then
      setElementColorToData(el, "fontColor", color)
    else
      throwGuiError("setButtonTextColor: guiElement is not button")
    end
  else
    throwGuiError("setButtonTextColor: invalid guiElement")
  end
end
function setButtonIconColor(el, color)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "button" then
      setElementColorToData(el, "iconColor", color)
    else
      throwGuiError("setButtonIconColor: guiElement is not button")
    end
  else
    throwGuiError("setButtonIconColor: invalid guiElement")
  end
end
function setButtonText(el, text)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "button" then
      guiElements[el].text = text
      if guiElements[el].icon and guiElements[el].text then
        guiElements[el].textWidth = getTextWidthFont(guiElements[el].text, guiElements[el].font)
      end
    else
      throwGuiError("setButtonText: guiElement is not button")
    end
  else
    throwGuiError("setButtonText: invalid guiElement")
  end
end
function getButtonText(el)
  if tonumber(el) and guiElements[el] then
    if guiElements[el].type == "button" then
      return guiElements[el].text
    else
      throwGuiError("getButtonText: guiElement is not button")
    end
  else
    throwGuiError("getButtonText: invalid guiElement")
  end
end
