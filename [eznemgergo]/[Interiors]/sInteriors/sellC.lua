local sightexports = {sGui = false}
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
local sightlangStatImgHand = false
local sightlangStaticImage = {}
local sightlangStaticImageToc = {}
local sightlangStaticImageUsed = {}
local sightlangStaticImageDel = {}
local processsightlangStaticImage = {}
sightlangStaticImageToc[0] = true
sightlangStaticImageToc[1] = true
sightlangStaticImageToc[2] = true
sightlangStaticImageToc[3] = true
sightlangStaticImageToc[4] = true
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
  if sightlangStaticImageUsed[1] then
    sightlangStaticImageUsed[1] = false
    sightlangStaticImageDel[1] = false
  elseif sightlangStaticImage[1] then
    if sightlangStaticImageDel[1] then
      if now >= sightlangStaticImageDel[1] then
        if isElement(sightlangStaticImage[1]) then
          destroyElement(sightlangStaticImage[1])
        end
        sightlangStaticImage[1] = nil
        sightlangStaticImageDel[1] = false
        sightlangStaticImageToc[1] = true
        return
      end
    else
      sightlangStaticImageDel[1] = now + 5000
    end
  else
    sightlangStaticImageToc[1] = true
  end
  if sightlangStaticImageUsed[2] then
    sightlangStaticImageUsed[2] = false
    sightlangStaticImageDel[2] = false
  elseif sightlangStaticImage[2] then
    if sightlangStaticImageDel[2] then
      if now >= sightlangStaticImageDel[2] then
        if isElement(sightlangStaticImage[2]) then
          destroyElement(sightlangStaticImage[2])
        end
        sightlangStaticImage[2] = nil
        sightlangStaticImageDel[2] = false
        sightlangStaticImageToc[2] = true
        return
      end
    else
      sightlangStaticImageDel[2] = now + 5000
    end
  else
    sightlangStaticImageToc[2] = true
  end
  if sightlangStaticImageUsed[3] then
    sightlangStaticImageUsed[3] = false
    sightlangStaticImageDel[3] = false
  elseif sightlangStaticImage[3] then
    if sightlangStaticImageDel[3] then
      if now >= sightlangStaticImageDel[3] then
        if isElement(sightlangStaticImage[3]) then
          destroyElement(sightlangStaticImage[3])
        end
        sightlangStaticImage[3] = nil
        sightlangStaticImageDel[3] = false
        sightlangStaticImageToc[3] = true
        return
      end
    else
      sightlangStaticImageDel[3] = now + 5000
    end
  else
    sightlangStaticImageToc[3] = true
  end
  if sightlangStaticImageUsed[4] then
    sightlangStaticImageUsed[4] = false
    sightlangStaticImageDel[4] = false
  elseif sightlangStaticImage[4] then
    if sightlangStaticImageDel[4] then
      if now >= sightlangStaticImageDel[4] then
        if isElement(sightlangStaticImage[4]) then
          destroyElement(sightlangStaticImage[4])
        end
        sightlangStaticImage[4] = nil
        sightlangStaticImageDel[4] = false
        sightlangStaticImageToc[4] = true
        return
      end
    else
      sightlangStaticImageDel[4] = now + 5000
    end
  else
    sightlangStaticImageToc[4] = true
  end
  if sightlangStaticImageToc[0] and sightlangStaticImageToc[1] and sightlangStaticImageToc[2] and sightlangStaticImageToc[3] and sightlangStaticImageToc[4] then
    sightlangStatImgHand = false
    removeEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre)
  end
end
processsightlangStaticImage[0] = function()
  if not isElement(sightlangStaticImage[0]) then
    sightlangStaticImageToc[0] = false
    sightlangStaticImage[0] = dxCreateTexture("files/adasveteli.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[1] = function()
  if not isElement(sightlangStaticImage[1]) then
    sightlangStaticImageToc[1] = false
    sightlangStaticImage[1] = dxCreateTexture("files/adasv.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[2] = function()
  if not isElement(sightlangStaticImage[2]) then
    sightlangStaticImageToc[2] = false
    sightlangStaticImage[2] = dxCreateTexture("files/adase.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[3] = function()
  if not isElement(sightlangStaticImage[3]) then
    sightlangStaticImageToc[3] = false
    sightlangStaticImage[3] = dxCreateTexture("files/adas2.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[4] = function()
  if not isElement(sightlangStaticImage[4]) then
    sightlangStaticImageToc[4] = false
    sightlangStaticImage[4] = dxCreateTexture("files/adas3.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
local h = math.floor(screenY * 0.85 / 2) * 2
local w = math.floor(h * 0.7463 / 2) * 2
local s = h / 946
local x, y = screenX / 2 - w / 2, screenY / 2 - h / 2
local sellPaper = false
local sellButtons = false
local sellPaperSigned = false
local font = false
local font2 = false
function renderSellPaper()
  local penc = tocolor(57, 70, 126, 255)
  if sellPaper[2] then
    sightlangStaticImageUsed[0] = true
    if sightlangStaticImageToc[0] then
      processsightlangStaticImage[0]()
    end
    dxDrawImage(x, y, w, h, sightlangStaticImage[0])
    if sellPaper[1] == "buyer" then
      sightlangStaticImageUsed[1] = true
      if sightlangStaticImageToc[1] then
        processsightlangStaticImage[1]()
      end
      dxDrawImage(x, y, w, h, sightlangStaticImage[1])
    else
      sightlangStaticImageUsed[2] = true
      if sightlangStaticImageToc[2] then
        processsightlangStaticImage[2]()
      end
      dxDrawImage(x, y, w, h, sightlangStaticImage[2])
      penc = tocolor(25, 19, 33, 225)
    end
  else
    sightlangStaticImageUsed[3] = true
    if sightlangStaticImageToc[3] then
      processsightlangStaticImage[3]()
    end
    dxDrawImage(x, y, w, h, sightlangStaticImage[3])
    sightlangStaticImageUsed[0] = true
    if sightlangStaticImageToc[0] then
      processsightlangStaticImage[0]()
    end
    dxDrawImage(x, y, w, h, sightlangStaticImage[0])
    sightlangStaticImageUsed[4] = true
    if sightlangStaticImageToc[4] then
      processsightlangStaticImage[4]()
    end
    dxDrawImage(x, y, w, h, sightlangStaticImage[4])
    sightlangStaticImageUsed[1] = true
    if sightlangStaticImageToc[1] then
      processsightlangStaticImage[1]()
    end
    dxDrawImage(x, y, w, h, sightlangStaticImage[1])
  end
  dxDrawText(sellPaper[3], x + w * 0.376, 0, x + w * 0.717, y + h * 0.163, penc, s, font2, "center", "bottom")
  dxDrawText(sellPaper[4], x + w * 0.3, 0, x + w * 0.645, y + h * 0.189, penc, s, font2, "center", "bottom")
  dxDrawText(sellPaper[5], x + w * 0.266, 0, x + w * 0.9, y + h * 0.315, penc, s, font2, "center", "bottom")
  dxDrawText(sellPaper[6], x + w * 0.266, 0, x + w * 0.53, y + h * 0.365, penc, s, font2, "center", "bottom")
  dxDrawText(sellPaper[7], x + w * 0.604, 0, x + w * 0.9, y + h * 0.365, penc, s, font2, "center", "bottom")
  dxDrawText(sellPaper[8] .. " $", x + w * 0.364, 0, x + w * 0.599, y + h * 0.485, penc, s, font2, "center", "bottom")
  dxDrawText(sellPaper[9], x + w * 0.317, 0, x + w * 0.599, y + h * 0.535, penc, s, font2, "center", "bottom")
  dxDrawText(sellPaper[10] .. " $", x + w * 0.49, 0, x + w * 0.602, y + h * 0.72, penc, s * 0.8, font2, "center", "bottom")
  if sellPaper[2] then
    dxDrawText(sellPaper[3], x + w * 0.107, 0, x + w * 0.417, y + h * 0.897, penc, s, font, "center", "bottom")
    dxDrawText(sellPaper[4], x + w * 0.572, 0, x + w * 0.883, y + h * 0.897, penc, s, font, "center", "bottom")
  elseif sellPaper[1] == "buyer" then
    dxDrawText(sellPaper[3], x + w * 0.107, 0, x + w * 0.417, y + h * 0.897, penc, s, font, "center", "bottom")
    if sellPaperSigned then
      local p = (getTickCount() - sellPaperSigned) / 3580
      local tw = dxGetTextWidth(sellPaper[4], s, font)
      dxDrawText(sellPaper[4], x + w * 0.7275 - tw / 2, 0, x + w * 0.7275 - tw / 2 + tw * p, y + h * 0.897, penc, s, font, "left", "bottom", true)
      if 1.25 <= p then
        if sellPaper[1] == "seller" then
          triggerEvent("closeIntiSlotBuy", localPlayer)
        end
        deleteSellPaper()
      end
    end
  elseif sellPaperSigned then
    local p = (getTickCount() - sellPaperSigned) / 3580
    local tw = dxGetTextWidth(sellPaper[3], s, font)
    dxDrawText(sellPaper[3], x + w * 0.262 - tw / 2, 0, x + w * 0.262 - tw / 2 + tw * p, y + h * 0.897, penc, s, font, "left", "bottom", true)
    if 1.25 <= p then
      if sellPaper[1] == "seller" then
        triggerEvent("closeIntiSlotBuy", localPlayer)
      end
      deleteSellPaper()
    end
  end
end
function deleteSellPaper()
  if sellButtons then
    sightexports.sGui:deleteGuiElement(sellButtons)
  end
  sellButtons = false
  if sellPaper then
    removeEventHandler("onClientRender", getRootElement(), renderSellPaper)
  end
  sellPaper = false
  if isElement(font) then
    destroyElement(font)
  end
  font = nil
  if isElement(font2) then
    destroyElement(font2)
  end
  font2 = nil
  sellPaperSigned = false
end
local sellButtonPressed = false
addEvent("cancelInteriorSellPaper", false)
addEventHandler("cancelInteriorSellPaper", getRootElement(), function()
  if sellPaper and sellPaper[1] == "buyer" then
    triggerServerEvent("intiSellResponse", localPlayer, false)
  elseif sellPaper and sellPaper[1] == "seller" then
    triggerEvent("closeIntiSlotBuy", localPlayer)
  end
  deleteSellPaper()
end)
addEvent("acceptInteriorSellPaper", false)
addEventHandler("acceptInteriorSellPaper", getRootElement(), function()
  if not sellButtonPressed then
    if sellPaper and sellPaper[1] == "buyer" then
      triggerServerEvent("intiSellResponse", localPlayer, true)
    elseif sellPaper and sellPaper[1] == "seller" then
      triggerServerEvent("tryToSellInterior", localPlayer, sellPaper[6], sellPaper[11], sellPaper[12])
    end
    sellButtonPressed = true
  end
end)
addEvent("inteirorSellAcceptResponse", true)
addEventHandler("inteirorSellAcceptResponse", getRootElement(), function(response)
  if response then
    sellPaperSigned = getTickCount()
    playSound("files/sign.mp3")
    if sellButtons then
      sightexports.sGui:deleteGuiElement(sellButtons)
    end
    sellButtons = false
  else
    sellButtonPressed = false
  end
end)
addEvent("gotInteriorSellPaper", true)
addEventHandler("gotInteriorSellPaper", getRootElement(), function(paper)
  if paper and not sellPaperSigned then
    if sellPaper and not sellPaper[2] and paper[2] then
      return
    end
    playSound("files/paper.mp3")
    if not sellPaper then
      font = dxCreateFont("files/lunabar.ttf", 17, false, "antialiased")
      font2 = dxCreateFont("files/hand.otf", 14, false, "antialiased")
      addEventHandler("onClientRender", getRootElement(), renderSellPaper, true, "low-999999999999")
    end
    sellButtonPressed = false
    sellPaperSigned = false
    sellPaper = paper
    sellPaper[8] = sightexports.sGui:thousandsStepper(tonumber(sellPaper[8]) or 0)
    sellPaper[10] = sightexports.sGui:thousandsStepper(tonumber(sellPaper[10]) or 0)
    local time = getRealTime(sellPaper[9])
    sellPaper[9] = string.format("%04d. %02d. %02d. %02d:%02d", time.year + 1900, time.month + 1, time.monthday, time.hour, time.minute)
    if sellButtons then
      sightexports.sGui:deleteGuiElement(sellButtons)
    end
    sellButtons = false
    if not sellPaper[2] then
      sellButtons = sightexports.sGui:createGuiElement("null", x + w / 2 - 154, y + h * 0.96, 308, 24)
      local btn = sightexports.sGui:createGuiElement("button", 0, 0, 150, 24, sellButtons)
      sightexports.sGui:setGuiBackground(btn, "solid", "sightred")
      sightexports.sGui:setGuiHover(btn, "gradient", {
        "sightred",
        "sightred-second"
      }, false, true)
      sightexports.sGui:setButtonFont(btn, "13/BebasNeueBold.otf")
      sightexports.sGui:setButtonTextColor(btn, "#ffffff")
      sightexports.sGui:setButtonText(btn, "Mégsem")
      sightexports.sGui:setClickEvent(btn, "cancelInteriorSellPaper")
      local btn = sightexports.sGui:createGuiElement("button", 158, 0, 150, 24, sellButtons)
      sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
      sightexports.sGui:setGuiHover(btn, "gradient", {
        "sightgreen",
        "sightgreen-second"
      }, false, true)
      sightexports.sGui:setButtonFont(btn, "13/BebasNeueBold.otf")
      sightexports.sGui:setButtonTextColor(btn, "#ffffff")
      sightexports.sGui:setButtonText(btn, "Szerződés aláírása")
      sightexports.sGui:setClickEvent(btn, "acceptInteriorSellPaper")
    end
  else
    deleteSellPaper()
  end
end)
