local seexports = {
  sGui = false,
  sPattach = false,
  sMarkers = false,
  sCore = false,
  sModloader = false,
  sControls = false
}
local function sightlangProcessExports()
  for k in pairs(seexports) do
    local res = getResourceFromName(k)
    if res and getResourceState(res) == "running" then
      seexports[k] = exports[k]
    else
      seexports[k] = false
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
sightlangStaticImageToc[1] = true
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
  if sightlangStaticImageToc[0] and sightlangStaticImageToc[1] then
    sightlangStatImgHand = false
    removeEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre)
  end
end
processSightlangStaticImage[0] = function()
  if not isElement(sightlangStaticImage[0]) then
    sightlangStaticImageToc[0] = false
    sightlangStaticImage[0] = dxCreateTexture("files/white.dds", "dxt1", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processSightlangStaticImage[1] = function()
  if not isElement(sightlangStaticImage[1]) then
    sightlangStaticImageToc[1] = false
    sightlangStaticImage[1] = dxCreateTexture("files/stripe.dds", "dxt1", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
local greenToColor = false
local blueToColor = false
local blue = false
local bcg = false
local bcg2 = false
local bcg3ToColor = false
local putDownIcon = false
local grabIcon = false
local leftIcon = false
local inIcon = false
local outIcon = false
local listIcon = false
local faTicks = false
local function sightlangGuiRefreshColors()
  local res = getResourceFromName("sGui")
  if res and getResourceState(res) == "running" then
    greenToColor = seexports.sGui:getColorCodeToColor("sightgreen")
    blueToColor = seexports.sGui:getColorCodeToColor("sightblue")
    blue = seexports.sGui:getColorCode("sightblue")
    bcg = seexports.sGui:getColorCode("sightgrey1")
    bcg2 = seexports.sGui:getColorCode("sightgrey2")
    bcg3ToColor = seexports.sGui:getColorCodeToColor("sightgrey3")
    putDownIcon = seexports.sGui:getFaIconFilename("arrow-alt-down", 32)
    grabIcon = seexports.sGui:getFaIconFilename("hand-rock", 32)
    leftIcon = seexports.sGui:getFaIconFilename("arrow-from-left", 32)
    inIcon = seexports.sGui:getFaIconFilename("inbox-in", 32)
    outIcon = seexports.sGui:getFaIconFilename("inbox-out", 32)
    listIcon = seexports.sGui:getFaIconFilename("list", 32)
    faTicks = seexports.sGui:getFaTicks()
  end
end
addEventHandler("onGuiRefreshColors", getRootElement(), sightlangGuiRefreshColors)
addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangGuiRefreshColors)
addEventHandler("refreshFaTicks", getRootElement(), function()
  faTicks = seexports.sGui:getFaTicks()
end)
local sightlangModloaderLoaded = function()
  loadModels()
end
addEventHandler("modloaderLoaded", getRootElement(), sightlangModloaderLoaded)
if getElementData(localPlayer, "loggedIn") or seexports.sModloader and seexports.sModloader:isModloaderLoaded() then
  addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangModloaderLoaded)
end
local screenX, screenY = guiGetScreenSize()
local raktarZone = createColRectangle(raktarZonePos[1], raktarZonePos[2], raktarZonePos[3], raktarZonePos[4])
local stackAttachOffsets = {
  {
    0.10523593744698,
    -0.020824180281138,
    -0.16805209187564,
    {
      0.62873488399012,
      0.77272161014259,
      0.07200707971186,
      0.04907890935966
    }
  },
  {
    0.08408528998554,
    -0.019968526613278,
    -0.1479627384867,
    {
      0.62873488399012,
      0.77272161014259,
      0.07200707971186,
      0.04907890935966
    }
  },
  {
    0.026202918754287,
    -0.022155020062215,
    -0.1687409453703,
    {
      0.62266883221623,
      0.78141057805564,
      0.035271821386914,
      0.020902930542834
    }
  },
  {
    0.098967567654679,
    -0.01849262781338,
    -0.15644652124944,
    {
      0.62102671011562,
      0.77893007802402,
      0.071515917084852,
      0.049791891669039
    }
  }
}
local jobPed = createPed(16, jobNPCPos[1], jobNPCPos[2], jobNPCPos[3], jobNPCPos[4])
setElementFrozen(jobPed, true)
setElementData(jobPed, "visibleName", "Jonathan Gayeles")
setElementData(jobPed, "pedNameType", "Fuvarszervező")
local selfJobVehicle = false
local jobVehicles = {}
local jobVehicleCarts = {}
local jobVehiclesStreamed = {}
local jobVehiclesDoor = {}
local jobVehiclesDoorAnimation = {}
local jobVehiclesCargo = {}
local jobVehiclesCargoObjects = {}
local modelsLoaded = false
local models = {
  sight_urmatrans_shelf = true,
  sight_urmatrans_cart = true,
  sight_urmatrans_cart2 = true
}
for k in pairs(cargoTypes) do
  models[cargoTypes[k].model] = true
  models[cargoTypes[k].cargo] = true
end
local shelves = {}
serversideLoaded = false
for k in pairs(cargoTypes) do
  cargoTypes[k].cargoObjects = {}
  cargoTypes[k].cargoCoords = {}
  cargoTypes[k].shelfObjects = {}
end
local attachedCarts = {}
local carts = {}
local cartsCid = {}
local cartData = {}
local cartSounds = {}
local cartContents = {}
local cartContentObjects = {}
local handContent = {}
local handContentData = {}
local myCartContents = {}
local myCartFlat = true
local companyFulfilled = false
local orderFulfilled = false
local order = false
local orderCompanies = 0
local orderTime = 0
local orderPage = 1
local orderItemDone = false
local jobPrompt = false
addEvent("okUrmatransJobPrompt", false)
addEventHandler("okUrmatransJobPrompt", getRootElement(), function()
  if jobPrompt then
    seexports.sGui:deleteGuiElement(jobPrompt)
  end
  jobPrompt = nil
  triggerServerEvent("createUrmatransJob", localPlayer)
end)
addEvent("closeUrmatransJobPrompt", false)
addEventHandler("closeUrmatransJobPrompt", getRootElement(), function()
  if jobPrompt then
    seexports.sGui:deleteGuiElement(jobPrompt)
  end
  jobPrompt = nil
end)
function jobNPCClick(button, state, absoluteX, absoluteY, worldX, worldY, worldZ, clickedElement)
  if state == "down" and clickedElement == jobPed and not jobPrompt then
    local x, y, z = getElementPosition(localPlayer)
    if 2 > getDistanceBetweenPoints3D(x, y, z, jobNPCPos[1], jobNPCPos[2], jobNPCPos[3]) then
      if order then
        seexports.sGui:showInfobox("e", "Már van elvállalt munkád.")
        return
      end
      if not selfJobVehicle then
        seexports.sGui:showInfobox("e", "Nincs munkajárműved.")
        return
      end
      local pw = 340
      local ph = 120
      jobPrompt = seexports.sGui:createGuiElement("window", screenX / 2 - pw / 2, screenY / 2 - ph / 2, pw, ph)
      seexports.sGui:setWindowTitle(jobPrompt, "16/BebasNeueRegular.otf", "MiguTrans")
      local titleBarHeight = seexports.sGui:getTitleBarHeight()
      local label = seexports.sGui:createGuiElement("label", 0, titleBarHeight, pw, ph - titleBarHeight - 30 - 6 - 6, jobPrompt)
      seexports.sGui:setLabelAlignment(label, "center", "center")
      seexports.sGui:setLabelText(label, "Szeretnéd megkezdeni a munkát?")
      seexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
      local bw = (pw - 18) / 2
      local btn = seexports.sGui:createGuiElement("button", 6, ph - 30 - 6, bw, 30, jobPrompt)
      seexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
      seexports.sGui:setGuiHover(btn, "gradient", {
        "sightgreen",
        "sightgreen-second"
      }, false, true)
      seexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
      seexports.sGui:setButtonText(btn, "Igen")
      seexports.sGui:setClickEvent(btn, "okUrmatransJobPrompt")
      local btn = seexports.sGui:createGuiElement("button", pw - bw - 6, ph - 30 - 6, bw, 30, jobPrompt)
      seexports.sGui:setGuiBackground(btn, "solid", "sightred")
      seexports.sGui:setGuiHover(btn, "gradient", {
        "sightred",
        "sightred-second"
      }, false, true)
      seexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
      seexports.sGui:setButtonText(btn, "Nem")
      seexports.sGui:setClickEvent(btn, "closeUrmatransJobPrompt")
      seexports.sGui:setWindowElementMaxDistance(jobPrompt, jobPed, 3, "closeUrmatransJobPrompt")
    end
  end
end
local paper = false
local typewriterFont = false
local signFont = false
local paperX, paperY = screenX / 2 - 317, screenY / 2 - 210
local paperMoveX, paperMoveY = false, false
local dragDropHandled = false
function dragDropClick(button, state)
  if button == "left" then
    local cx, cy = getCursorPosition()
    if cx and state == "down" then
      cx = cx * screenX
      cy = cy * screenY
      if cx >= paperX and cy >= paperY and cx <= paperX + 634 and cy <= paperY + 420 then
        paperMoveX, paperMoveY = paperX - cx, paperY - cy
      end
    else
      paperMoveX, paperMoveY = false, false
    end
  end
end
function dragDropCursorMove(x, y, cx, cy)
  if paperMoveX then
    if isCursorShowing() then
      paperX = math.max(0, math.min(screenX - 634, paperMoveX + cx))
      paperY = math.max(0, math.min(screenY - 420, paperMoveY + cy))
      seexports.sGui:setGuiPosition(paper, paperX, paperY)
    else
      paperMoveX, paperMoveY = false, false
    end
  end
end
local vehHPProg = false
local vehHPBg = false
local vehHPSynced = false
local orderWindow = false
function deleteOrderWindow()
  local x, y
  if orderWindow then
    x, y = seexports.sGui:getGuiPosition(orderWindow)
    seexports.sGui:deleteGuiElement(orderWindow)
  end
  vehHPProg = false
  vehHPBg = false
  vehHPSynced = false
  orderWindow = false
  return x, y
end
function refreshVehHP()
  if vehHPProg then
    local perc = (vehHPSynced - 250) / 7.5
    seexports.sGui:guiSetTooltip(vehHPBg, math.floor(perc + 0.5) .. " %")
    seexports.sGui:setGuiSize(vehHPProg, 256 * perc / 100)
  end
end
function createOrderWindow()
  local x, y = deleteOrderWindow()
  local titleBarHeight = seexports.sGui:getTitleBarHeight()
  local pw = 300
  local ph = titleBarHeight + 20 + 4 + 12 + 4
  orderWindow = seexports.sGui:createGuiElement("window", x or screenX / 2 - pw / 2, y or screenY * 0.85 - ph, pw, ph)
  seexports.sGui:setWindowTitle(orderWindow, "16/BebasNeueRegular.otf", "MiguTrans kiszállítás")
  local label = seexports.sGui:createGuiElement("label", 4, titleBarHeight, 0, 20, orderWindow)
  seexports.sGui:setLabelAlignment(label, "left", "center")
  seexports.sGui:setLabelText(label, "Jármű állapota:")
  seexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
  vehHPBg = seexports.sGui:createGuiElement("rectangle", 4, titleBarHeight + 20 + 4, pw - 12 - 32, 12, orderWindow)
  seexports.sGui:setGuiBackground(vehHPBg, "solid", "sightgrey1")
  seexports.sGui:setGuiHover(vehHPBg, "none", false, false, true)
  seexports.sGui:setGuiHoverable(vehHPBg, true)
  vehHPProg = seexports.sGui:createGuiElement("rectangle", 0, 0, 0, 12, vehHPBg)
  seexports.sGui:setGuiBackground(vehHPProg, "solid", "sightgreen")
  local btn = seexports.sGui:createGuiElement("button", pw - 4 - 32, ph - 4 - 32, 32, 32, orderWindow)
  seexports.sGui:setGuiBackground(btn, "solid", "sightgrey1", false, true)
  seexports.sGui:setGuiHover(btn, "gradient", {"sightgrey1", "sightgrey3"}, false, true)
  seexports.sGui:setButtonIcon(btn, seexports.sGui:getFaIconFilename("copy", 24))
  seexports.sGui:setClickEvent(btn, "createUrmatransPapers")
  seexports.sGui:guiSetTooltip(btn, "Fuvarlevél")
  if isElement(selfJobVehicle) then
    vehHPSynced = getElementHealth(selfJobVehicle)
    refreshVehHP()
  end
end
function deletePapers(re)
  if not re then
    if isElement(typewriterFont) then
      destroyElement(typewriterFont)
    end
    typewriterFont = nil
    if isElement(signFont) then
      destroyElement(signFont)
    end
    signFont = nil
    if dragDropHandled then
      removeEventHandler("onClientClick", getRootElement(), dragDropClick)
      removeEventHandler("onClientCursorMove", getRootElement(), dragDropCursorMove)
      dragDropHandled = false
    end
  end
  if paper then
    seexports.sGui:deleteGuiElement(paper)
  end
  paper = nil
end
addEvent("urmatransDeletePaper", false)
addEventHandler("urmatransDeletePaper", getRootElement(), function()
  deletePapers()
  playSound("files/paper1.mp3")
end)
addEvent("urmatransPaperPrevPage", false)
addEventHandler("urmatransPaperPrevPage", getRootElement(), function()
  orderPage = orderPage - 1
  createPapers()
  playSound("files/paper2.mp3")
end)
addEvent("urmatransPaperNextPage", false)
addEventHandler("urmatransPaperNextPage", getRootElement(), function()
  orderPage = orderPage + 1
  createPapers()
  playSound("files/paper2.mp3")
end)
function checkDoneItem(i, num)
  local done = handContentData[localPlayer] == i and 1 or 0
  orderItemDone[i] = false
  if num <= done then
    orderItemDone[i] = true
    return true
  end
  if cartContents[localPlayer] then
    for j = 1, #cartContents[localPlayer] do
      if cartContents[localPlayer][j] == i then
        done = done + 1
        if num <= done then
          orderItemDone[i] = true
          return true
        end
      end
    end
  end
  if orderFulfilled then
    for j in pairs(orderFulfilled) do
      if orderFulfilled[j][i] then
        done = done + orderFulfilled[j][i]
      end
      if num <= done then
        orderItemDone[i] = true
        return true
      end
    end
  end
  for j = 1, #jobVehiclesCargo[selfJobVehicle] do
    if jobVehiclesCargo[selfJobVehicle][j] == i then
      done = done + 1
      if num <= done then
        orderItemDone[i] = true
        return true
      end
    end
  end
end
function createPapers()
  deletePapers(re)
  if not dragDropHandled then
    addEventHandler("onClientClick", getRootElement(), dragDropClick)
    addEventHandler("onClientCursorMove", getRootElement(), dragDropCursorMove)
    dragDropHandled = true
  end
  if not isElement(typewriterFont) then
    typewriterFont = dxCreateFont("files/typewriter.ttf", 26, false, "antialiased")
  end
  if not isElement(signFont) then
    signFont = dxCreateFont("files/sign.ttf", 36, false, "antialiased")
  end
  local fh = dxGetFontHeight(0.5, typewriterFont)
  paper = seexports.sGui:createGuiElement("image", paperX, paperY, 634, 420)
  seexports.sGui:setImageFile(paper, ":sJob_raktar/files/" .. (orderCompanies[orderPage] and "delivery" or "list") .. ".png")
  if 1 < orderPage then
    local btn = seexports.sGui:createGuiElement("button", -16, 194, 32, 32, paper)
    seexports.sGui:setGuiBackground(btn, "solid", "sightgrey1", false, true)
    seexports.sGui:setGuiHover(btn, "gradient", {"sightgrey1", "sightgrey3"}, false, true)
    seexports.sGui:setButtonIcon(btn, seexports.sGui:getFaIconFilename("angle-left", 24))
    seexports.sGui:setClickEvent(btn, "urmatransPaperPrevPage")
    seexports.sGui:guiSetTooltip(btn, "Előző oldal")
  end
  if orderPage <= #orderCompanies then
    local btn = seexports.sGui:createGuiElement("button", 618, 194, 32, 32, paper)
    seexports.sGui:setGuiBackground(btn, "solid", "sightgrey1", false, true)
    seexports.sGui:setGuiHover(btn, "gradient", {"sightgrey1", "sightgrey3"}, false, true)
    seexports.sGui:setButtonIcon(btn, seexports.sGui:getFaIconFilename("angle-right", 24))
    seexports.sGui:setClickEvent(btn, "urmatransPaperNextPage")
    seexports.sGui:guiSetTooltip(btn, "Következő oldal")
  end
  local name = split(getElementData(localPlayer, "visibleName"), "_")
  name = utf8.sub(name[1], 1, 1) .. ". " .. name[#name]
  local label = seexports.sGui:createGuiElement("label", 56, 84, 170, 24, paper)
  seexports.sGui:setLabelAlignment(label, "center", "center")
  seexports.sGui:setLabelText(label, name)
  seexports.sGui:setLabelClip(label, true)
  seexports.sGui:setLabelFont(label, typewriterFont)
  seexports.sGui:setLabelColor(label, "#1d1d1d")
  local label = seexports.sGui:createGuiElement("label", 231, 84, 170, 24, paper)
  seexports.sGui:setLabelAlignment(label, "center", "center")
  seexports.sGui:setLabelText(label, "MB Sprinter")
  seexports.sGui:setLabelClip(label, true)
  seexports.sGui:setLabelFont(label, typewriterFont)
  seexports.sGui:setLabelColor(label, "#1d1d1d")
  local plate = ""
  if isElement(selfJobVehicle) then
    plate = getVehiclePlateText(selfJobVehicle)
    plate = table.concat(split(plate, "-"), "-")
  end
  local label = seexports.sGui:createGuiElement("label", 406, 84, 170, 24, paper)
  seexports.sGui:setLabelAlignment(label, "center", "center")
  seexports.sGui:setLabelText(label, plate)
  seexports.sGui:setLabelClip(label, true)
  seexports.sGui:setLabelFont(label, typewriterFont)
  seexports.sGui:setLabelColor(label, "#1d1d1d")
  local penC = {
    20,
    100,
    200
  }
  local comp = orderCompanies[orderPage]
  if comp then
    local label = seexports.sGui:createGuiElement("label", 56, 166, 170, 0, paper)
    seexports.sGui:setLabelAlignment(label, "center", "top")
    seexports.sGui:setLabelText(label, companies[comp].name)
    seexports.sGui:setLabelFont(label, typewriterFont)
    seexports.sGui:setLabelWordBreak(label, true)
    seexports.sGui:setLabelColor(label, "#1d1d1d")
    local y = 166
    local cargo = order[comp]
    for i, num in pairs(cargo) do
      local text = num .. " " .. cargoTypes[i].quantity .. " " .. cargoTypes[i].name
      local label = seexports.sGui:createGuiElement("label", 235, y, 0, 0, paper)
      seexports.sGui:setLabelAlignment(label, "left", "top")
      seexports.sGui:setLabelText(label, text)
      seexports.sGui:setLabelFont(label, typewriterFont)
      seexports.sGui:setLabelColor(label, "#1d1d1d")
      if orderFulfilled[comp][i] and orderFulfilled[comp][i] >= order[comp][i] then
        local tw = dxGetTextWidth(text, 0.5, typewriterFont)
        local pen = seexports.sGui:createGuiElement("image", 230, y + fh / 2 - 4 - 2, tw + 6, 8, paper)
        seexports.sGui:setImageFile(pen, ":sJob_raktar/files/penline.png")
        seexports.sGui:setImageColor(pen, penC)
        seexports.sGui:setImageUV(pen, 0, 0, tw + 6, 8)
      end
      y = y + fh - 4
    end
    local label = seexports.sGui:createGuiElement("label", 52, 0, 188, 366, paper)
    seexports.sGui:setLabelAlignment(label, "center", "bottom")
    seexports.sGui:setLabelText(label, name)
    seexports.sGui:setLabelFont(label, signFont)
    seexports.sGui:setLabelClip(label, true)
    seexports.sGui:setLabelColor(label, penC)
    if companyFulfilled[comp] then
      local label = seexports.sGui:createGuiElement("label", 350, 0, 0, 366, paper)
      seexports.sGui:setLabelAlignment(label, "center", "bottom")
      seexports.sGui:setLabelText(label, companyFulfilled[comp])
      seexports.sGui:setLabelFont(label, signFont)
      seexports.sGui:setLabelColor(label, penC)
    end
  else
    local x = 53
    local y = 128
    local w = 0
    local tmp = {}
    for i in pairs(order) do
      for j, num in pairs(order[i]) do
        tmp[j] = (tmp[j] or 0) + num
      end
    end
    for i, num in pairs(tmp) do
      if 375 < y + fh then
        x = x + w + 12
        w = 0
        y = 128
      end
      local text = num .. " " .. cargoTypes[i].quantity .. " " .. cargoTypes[i].name
      local label = seexports.sGui:createGuiElement("label", x, y, 0, 0, paper)
      seexports.sGui:setLabelAlignment(label, "left", "top")
      seexports.sGui:setLabelText(label, text)
      seexports.sGui:setLabelFont(label, typewriterFont)
      seexports.sGui:setLabelColor(label, "#1d1d1d")
      local tw = dxGetTextWidth(text, 0.5, typewriterFont)
      if jobVehiclesCargo[selfJobVehicle] and orderItemDone[i] then
        local pen = seexports.sGui:createGuiElement("image", x - 4, y + fh / 2 - 4, tw + 6, 8, paper)
        seexports.sGui:setImageFile(pen, ":sJob_raktar/files/penline.png")
        seexports.sGui:setImageColor(pen, penC)
        seexports.sGui:setImageUV(pen, 0, 0, tw + 6, 8)
      end
      w = math.max(w, tw)
      y = y + fh
    end
  end
  local label = seexports.sGui:createGuiElement("label", 53, 375, 0, 0, paper)
  seexports.sGui:setLabelAlignment(label, "left", "top")
  seexports.sGui:setLabelText(label, orderTime)
  seexports.sGui:setLabelFont(label, typewriterFont)
  seexports.sGui:setLabelColor(label, "#1d1d1d")
  local label = seexports.sGui:createGuiElement("label", 580, 375, 0, 0, paper)
  seexports.sGui:setLabelAlignment(label, "right", "top")
  seexports.sGui:setLabelText(label, orderPage .. " / " .. #orderCompanies + 1)
  seexports.sGui:setLabelFont(label, typewriterFont)
  seexports.sGui:setLabelColor(label, "#1d1d1d")
  local overlay = seexports.sGui:createGuiElement("image", 0, 0, 634, 420, paper)
  seexports.sGui:setImageFile(overlay, ":sJob_raktar/files/papover.png")
  local btn = seexports.sGui:createGuiElement("image", 578, 22, 24, 24, paper)
  seexports.sGui:setImageColor(btn, "#000000")
  seexports.sGui:setGuiHover(btn, "solid", "sightred", false, true)
  seexports.sGui:setGuiHoverable(btn, true)
  seexports.sGui:setImageFile(btn, seexports.sGui:getFaIconFilename("times", 24))
  seexports.sGui:setClickEvent(btn, "urmatransDeletePaper")
end
addEvent("createUrmatransPapers", false)
addEventHandler("createUrmatransPapers", getRootElement(), function()
  if paper then
    deletePapers()
    playSound("files/paper1.mp3")
  else
    createPapers()
    playSound("files/paper1.mp3")
  end
end)
local fulfillmentObjects = {}
local orderBlips = {}
local surNames = {
  "Bell",
  "Walsh",
  "Black",
  "Butler",
  "Thompson",
  "O'connor",
  "Marquez",
  "Morales",
  "Douglas",
  "Hendrix",
  "Chapman",
  "Adams",
  "Harper",
  "Saunders",
  "Reynolds",
  "Wong",
  "Leon",
  "Mayo",
  "Donaldson",
  "Stewart",
  "Wallace",
  "Bell",
  "Sutton",
  "Shaw",
  "Carson",
  "Ferrell",
  "Donovan",
  "Carson",
  "Mathis",
  "Riley",
  "West",
  "Stone",
  "Hughes",
  "Lawson",
  "Zamora",
  "Cotton",
  "Silva",
  "Frye",
  "Townsend",
  "Hopkins",
  "Brown",
  "Kelly",
  "Harris",
  "Harvey",
  "Sparks",
  "Gonzales",
  "Lane",
  "Meyer",
  "Vazquez",
  "Day",
  "Hayes",
  "Wilson",
  "Howard",
  "Jordan",
  "Mills",
  "Daugherty",
  "Manning",
  "Franklin",
  "Duffy"
}
local firstNames = {
  "Jess",
  "Leigh",
  "Elliot",
  "Rory",
  "Silver",
  "Emerson",
  "Kris",
  "Tyler",
  "Riley",
  "Casey",
  "Ashton",
  "Sam",
  "Taylor",
  "Ollie",
  "Christoph",
  "Brennen",
  "Cedric",
  "Otto",
  "Colten",
  "Jameson",
  "Morgan",
  "Bobby",
  "Anthony",
  "Arthur",
  "Leo",
  "Gilbert",
  "Jaycob",
  "Wade",
  "Louis",
  "Arthur",
  "Jake",
  "Declan",
  "Kian",
  "Charles",
  "Anthony",
  "Kayson",
  "Bryan",
  "Caiden",
  "Foster",
  "Moshe",
  "Arthur",
  "Zak",
  "Alex",
  "Lucas",
  "Oliver",
  "Atticus",
  "Randall",
  "Prince",
  "Royce",
  "Jalen",
  "Kayden",
  "Matthew",
  "Ryan",
  "Ollie",
  "Edward",
  "Levi",
  "Fletcher",
  "William",
  "Hassan",
  "Ernesto",
  "Amber",
  "Rosie",
  "Kayleigh",
  "Mollie",
  "Mya",
  "Jenna",
  "Brynlee",
  "Ryleigh",
  "Jillian",
  "Kylah",
  "Paige",
  "Lucy",
  "Alisha",
  "Daisy",
  "Zoe",
  "Caroline",
  "Alisha",
  "Jane",
  "Michaela",
  "Karla",
  "Holly",
  "Isabel",
  "Leah",
  "Erin",
  "Charlotte",
  "Carleigh",
  "Everly",
  "Audrianna",
  "Melanie",
  "Sky",
  "Evelyn",
  "Amelie",
  "Kayleigh",
  "Emma",
  "Abby",
  "Alyssa",
  "Miley",
  "Thalia",
  "Sasha",
  "Adley",
  "Matilda",
  "Abby",
  "Kayla",
  "Skye",
  "Paige",
  "Gisselle",
  "Angelina",
  "Iris",
  "Zahra",
  "Yareli",
  "Molly",
  "Lola",
  "Lara",
  "Amy",
  "Freya",
  "Eliana",
  "Carissa",
  "Laney",
  "Danica",
  "Clarissa"
}
addEvent("urmatransOrderFulfilled", true)
addEventHandler("urmatransOrderFulfilled", getRootElement(), function(i, id, x, y, r)
  if orderFulfilled[i] and order[i] then
    orderFulfilled[i][id] = (orderFulfilled[i][id] or 0) + 1
    local tmp = true
    for j in pairs(order[i]) do
      if not orderFulfilled[i][j] or orderFulfilled[i][j] < order[i][j] then
        tmp = false
        break
      end
    end
    if tmp then
      companyFulfilled[i] = firstNames[math.random(#firstNames)] .. " " .. surNames[math.random(#surNames)]
      if isElement(orderBlips[i]) then
        destroyElement(orderBlips[i])
        triggerServerEvent("orderFulFilled", localPlayer)
      end
      orderBlips[i] = nil
    end
    local z = companies[i].loadingBay[5]
    local rad = math.rad(r)
    x = x - math.sin(rad) * 0.75
    y = y + math.cos(rad) * 0.75
    local obj = createObject(models[cargoTypes[id].cargo], x, y, z, 0, 0, r + 90)
    setElementCollisionsEnabled(obj, false)
    table.insert(fulfillmentObjects, obj)
    if paper and orderCompanies[orderPage] == i then
      createPapers()
    end
  end
end)
function tryToPutDownHandContent()
  local px, py, pz = getElementPosition(localPlayer)
  if orderCompanies then
    for j = 1, #orderCompanies do
      local i = orderCompanies[j]
      local x, y, sx, sy, z = companies[i].loadingBay[1], companies[i].loadingBay[2], companies[i].loadingBay[3], companies[i].loadingBay[4], companies[i].loadingBay[5]
      if 2 > math.abs(pz - z) and px >= x and px <= x + sx and py >= y and py <= y + sy then
        local id = handContentData[localPlayer]
        if order[i][id] then
          if (orderFulfilled[i][id] or 0) + 1 > order[i][id] then
            seexports.sGui:showInfobox("e", cargoTypes[id].name .. " termékből már nem kell több erre a lerakóra.")
          else
            triggerServerEvent("fulfillUrmatransOrder", localPlayer, i, id)
          end
        else
          seexports.sGui:showInfobox("e", cargoTypes[id].name .. " terméket nem rendeltek.")
        end
        return
      end
    end
  end
end
function preRenderOrderGrid()
  local px, py, pz = getElementPosition(localPlayer)
  for j = 1, #orderCompanies do
    local i = orderCompanies[j]
    local x, y, sx, sy, z = companies[i].loadingBay[1], companies[i].loadingBay[2], companies[i].loadingBay[3], companies[i].loadingBay[4], companies[i].loadingBay[5]
    if getDistanceBetweenPoints3D(x, y, z, px, py, pz) < 150 then
      local col = companyFulfilled[i] and greenToColor or blueToColor
      sightlangStaticImageUsed[0] = true
      if sightlangStaticImageToc[0] then
        processSightlangStaticImage[0]()
      end
      dxDrawMaterialLine3D(x, y + 0.1, z, x, y + sy - 0.1, z, sightlangStaticImage[0], 0.2, col, x, y + sy / 2, z + 1)
      sightlangStaticImageUsed[0] = true
      if sightlangStaticImageToc[0] then
        processSightlangStaticImage[0]()
      end
      dxDrawMaterialLine3D(x + sx, y + 0.1, z, x + sx, y + sy - 0.1, z, sightlangStaticImage[0], 0.2, col, x + sx, y + sy / 2, z + 1)
      sightlangStaticImageUsed[0] = true
      if sightlangStaticImageToc[0] then
        processSightlangStaticImage[0]()
      end
      dxDrawMaterialLine3D(x - 0.1, y, z, x + sx + 0.1, y, z, sightlangStaticImage[0], 0.2, col, x + sx / 2, y, z + 1)
      sightlangStaticImageUsed[0] = true
      if sightlangStaticImageToc[0] then
        processSightlangStaticImage[0]()
      end
      dxDrawMaterialLine3D(x - 0.1, y + sy, z, x + sx + 0.1, y + sy, z, sightlangStaticImage[0], 0.2, col, x + sx / 2, y + sy, z + 1)
      sightlangStaticImageUsed[1] = true
      if sightlangStaticImageToc[1] then
        processSightlangStaticImage[1]()
      end
      dxDrawMaterialSectionLine3D(x + sx / 2, y + 0.1, z, x + sx / 2, y + sy - 0.1, z, 0, 0, sx * 2 * 64, sy * 2 * 64, sightlangStaticImage[1], sx - 0.2, col, x + sx / 2, y + sy / 2, z + 1)
    end
  end
end
addEvent("deleteUrmatransOrder", true)
addEventHandler("deleteUrmatransOrder", getRootElement(), function()
  refreshAllShelves()
  if order then
    removeEventHandler("onClientPreRender", getRootElement(), preRenderOrderGrid)
  end
  order = nil
  orderCompanies = nil
  orderFulfilled = nil
  companyFulfilled = nil
  orderItemDone = nil
  deleteOrderWindow()
  deletePapers()
  refreshMarkers()
  for i in pairs(orderBlips) do
    if isElement(orderBlips[i]) then
      destroyElement(orderBlips[i])
    end
    orderBlips[i] = nil
  end
end)
addEvent("gotUrmatransOrder", true)
addEventHandler("gotUrmatransOrder", getRootElement(), function(dat, fulfill, company)
  refreshAllShelves()
  if not order then
    addEventHandler("onClientPreRender", getRootElement(), preRenderOrderGrid)
  end
  order = dat
  orderCompanies = {}
  orderFulfilled = fulfill or {}
  companyFulfilled = company or {}
  orderItemDone = {}
  for i in pairs(companyFulfilled) do
    companyFulfilled[i] = firstNames[math.random(#firstNames)] .. " " .. surNames[math.random(#surNames)]
  end
  local time = getRealTime()
  orderTime = string.format("%04d. %02d. %02d. %02d:%02d:%02d", time.year + 1900, time.month + 1, time.monthday, time.hour, time.minute, time.second)
  orderPage = 1
  for i in pairs(orderBlips) do
    if isElement(orderBlips[i]) then
      destroyElement(orderBlips[i])
    end
    orderBlips[i] = nil
  end
  for i in pairs(order) do
    if not fulfill then
      orderFulfilled[i] = {}
    end
    table.insert(orderCompanies, i)
    orderBlips[i] = createBlip(companies[i].blip[1], companies[i].blip[2], companies[i].blip[3], 20, 2, blue[1], blue[2], blue[3])
    setElementData(orderBlips[i], "tooltipText", "Lerakó: " .. companies[i].name)
  end
  refreshMarkers()
  createOrderWindow()
end)
function processVehCart(veh)
  if jobVehiclesDoor[veh] and modelsLoaded and not cartsCid[jobVehicles[veh]] and isElementStreamedIn(veh) then
    if not isElement(jobVehicleCarts[veh]) then
      jobVehicleCarts[veh] = createObject(models.sight_urmatrans_cart2, 0, 0, 0)
      setElementCollisionsEnabled(jobVehicleCarts[veh], false)
      attachElements(jobVehicleCarts[veh], veh, 0, -2.0315, -0.3815, 0, 0, 180)
    end
  else
    if isElement(jobVehicleCarts[veh]) then
      destroyElement(jobVehicleCarts[veh])
    end
    jobVehicleCarts[veh] = nil
  end
end
function processVehContents(veh)
  local x, y, z = 0, 0, 0
  local maxL = 0
  if jobVehiclesDoor[veh] and isElementStreamedIn(veh) then
    if not jobVehiclesCargoObjects[veh] then
      jobVehiclesCargoObjects[veh] = {}
    end
    local x, y, z, lastStack, lastW, maxL = 0, 0, 0, false, 0, 0
    for i = 1, #jobVehiclesCargo[veh] do
      local dat = cargoTypes[jobVehiclesCargo[veh][i]]
      x, y, z, lastStack, lastW, maxL = processVehCargo(dat, x, y, z, lastStack, lastW, maxL)
      if x then
        if isElement(jobVehiclesCargoObjects[veh][i]) then
          setElementModel(jobVehiclesCargoObjects[veh][i], models[dat.cargo])
          setElementAttachedOffsets(jobVehiclesCargoObjects[veh][i], sprinterOffX + x + dat.length / 2, spriterOffY - y - dat.width / 2, sprinterOffZ + z - dat.height, 0, 0, 90)
        else
          jobVehiclesCargoObjects[veh][i] = createObject(models[dat.cargo], 0, 0, 0)
          setElementCollisionsEnabled(jobVehiclesCargoObjects[veh][i], false)
          attachElements(jobVehiclesCargoObjects[veh][i], veh, sprinterOffX + x + dat.length / 2, spriterOffY - y - dat.width / 2, sprinterOffZ + z - dat.height, 0, 0, 90)
        end
      else
        if isElement(jobVehiclesCargoObjects[veh][i]) then
          destroyElement(jobVehiclesCargoObjects[veh][i])
        end
        jobVehiclesCargoObjects[veh][i] = nil
      end
    end
    for i = #jobVehiclesCargo[veh] + 1, #jobVehiclesCargoObjects[veh] do
      if isElement(jobVehiclesCargoObjects[veh][i]) then
        destroyElement(jobVehiclesCargoObjects[veh][i])
      end
      jobVehiclesCargoObjects[veh][i] = nil
    end
  elseif jobVehiclesCargoObjects[veh] then
    for i = 1, #jobVehiclesCargoObjects[veh] do
      if isElement(jobVehiclesCargoObjects[veh][i]) then
        destroyElement(jobVehiclesCargoObjects[veh][i])
      end
      jobVehiclesCargoObjects[veh][i] = nil
    end
  end
end
local sprinterInventoryWindow = false
local sprinterInventoryVeh = false
addEvent("urmatransAddedToVehicle", true)
addEventHandler("urmatransAddedToVehicle", getRootElement(), function(id)
  if jobVehicles[source] then
    local to = toVehCargo(id, jobVehiclesCargo[source])
    table.insert(jobVehiclesCargo[source], to, id)
    if isElementStreamedIn(source) then
      processVehContents(source)
    end
    if sprinterInventoryVeh == source and sprinterInventoryWindow then
      createSprinterInventory(source)
    end
    if source == selfJobVehicle and paper and not orderCompanies[orderPage] then
      createPapers()
    end
  end
end)
addEvent("urmatransRemovedFromVehicle", true)
addEventHandler("urmatransRemovedFromVehicle", getRootElement(), function(id)
  if jobVehicles[source] then
    for i = #jobVehiclesCargo[source], 1, -1 do
      if jobVehiclesCargo[source][i] == id then
        table.remove(jobVehiclesCargo[source], i)
        break
      end
    end
    if isElementStreamedIn(source) then
      processVehContents(source)
    end
    if sprinterInventoryVeh == source and sprinterInventoryWindow then
      if #jobVehiclesCargo[source] <= 0 then
        deleteSprinterInventory()
      else
        createSprinterInventory(source)
      end
    end
    if source == selfJobVehicle and paper and not orderCompanies[orderPage] then
      createPapers()
    end
  end
end)
function streamedInPlayerEx(client)
  return client == localPlayer or isElementStreamedIn(client)
end
function processCartContents(client)
  if isElement(carts[client]) and cartContents[client] then
    if not cartContentObjects[client] then
      cartContentObjects[client] = {}
    end
    local y, z = 0, 0
    local lastStack = false
    local lastW = 0
    local nextRow = false
    for i = 1, #cartContents[client] do
      local dat = cargoTypes[cartContents[client][i]]
      y, z, lastStack, lastW, nextRow = processCartCargo(dat, y, z, lastStack, lastW, nextRow)
      if y then
        if isElement(cartContentObjects[client][i]) then
          setElementModel(cartContentObjects[client][i], models[dat.cargo])
          setElementAttachedOffsets(cartContentObjects[client][i], 0, -0.3987 - y - dat.width / 2, -0.9474 + z - dat.height, 0, 0, 90)
        else
          cartContentObjects[client][i] = createObject(models[dat.cargo], 0, 0, 0)
          setElementCollisionsEnabled(cartContentObjects[client][i], false)
          attachElements(cartContentObjects[client][i], carts[client], 0, -0.3987 - y - dat.width / 2, -0.9474 + z - dat.height, 0, 0, 90)
        end
      else
        if isElement(cartContentObjects[client][i]) then
          destroyElement(cartContentObjects[client][i])
        end
        cartContentObjects[client][i] = nil
      end
    end
    for i = #cartContents[client] + 1, #cartContentObjects[client] do
      if isElement(cartContentObjects[client][i]) then
        destroyElement(cartContentObjects[client][i])
      end
      cartContentObjects[client][i] = nil
    end
  else
    if cartContentObjects[client] then
      for i = 1, #cartContentObjects[client] do
        if isElement(cartContentObjects[client][i]) then
          destroyElement(cartContentObjects[client][i])
        end
        cartContentObjects[client][i] = nil
      end
    end
    cartContentObjects[client] = nil
  end
end
addEvent("urmatransAddedToCart", true)
addEventHandler("urmatransAddedToCart", getRootElement(), function(id)
  if cartContents[source] then
    local to = toCartCargo(id, cartContents[source])
    if to then
      table.insert(cartContents[source], to, id)
    else
      table.insert(cartContents[source], id)
    end
    if isElement(carts[source]) then
      processCartContents(source)
    end
    if source == localPlayer and myCartContents then
      if paper and not orderCompanies[orderPage] then
        createPapers()
      end
      for i = 1, #myCartContents do
        if myCartContents[i] == id then
          return
        end
      end
      table.insert(myCartContents, id)
    end
  end
end)
addEvent("urmatransRemovedFromCart", true)
addEventHandler("urmatransRemovedFromCart", getRootElement(), function(id)
  if cartContents[source] then
    for j = #cartContents[source], 1, -1 do
      if cartContents[source][j] == id then
        table.remove(cartContents[source], j)
        break
      end
    end
    if isElement(carts[source]) then
      processCartContents(source)
    end
    if source == localPlayer and myCartContents then
      if paper and not orderCompanies[orderPage] then
        createPapers()
      end
      for j = #cartContents[source], 1, -1 do
        if cartContents[source][j] == id then
          return
        end
      end
      for i = #myCartContents, 1, -1 do
        if myCartContents[i] == id then
          table.remove(myCartContents, i)
        end
      end
    end
  end
end)
function handleUrmacartDrop()
  if isElement(carts[localPlayer]) then
    if not myCartFlat then
      seexports.sGui:showInfobox("e", "Csak egyenes felületen helyezheted le a kézikocsit.")
      return
    end
    local x, y, z = getElementPosition(carts[localPlayer])
    local cx, cy, cz = getCameraMatrix()
    if not isLineOfSightClear(x, y, z, cx, cy, cz, true, false, false, true) then
      seexports.sGui:showInfobox("e", "Ide nem helyezheted a kézikocsit.")
      return
    end
    local rx, ry, r = getElementRotation(carts[localPlayer])
    rz = math.rad(r + 180)
    local vx, vy = math.cos(rz), math.sin(rz)
    local hit, hx, hy, hz, he, nx, ny, nz = processLineOfSight(x - vy * 0.8, y + vx * 0.8, z, x - vy * 0.8, y + vx * 0.8, z - 10, true, false, false, true)
    if hit then
      if math.abs(hz + 1.19265 - z) > 0.1 then
        seexports.sGui:showInfobox("e", "Ide nem helyezheted a kézikocsit.")
        return
      end
    else
      seexports.sGui:showInfobox("e", "Ide nem helyezheted a kézikocsit.")
      return
    end
    triggerServerEvent("putDownUrmatransCart", localPlayer, x, y, z, r)
  end
end
function getJobVehicleDoor(veh)
  return jobVehiclesDoor[veh] or jobVehiclesDoorAnimation[veh]
end
function checkVehicleCart(veh)
  return jobVehicles[veh] and cartsCid[jobVehicles[veh]]
end
local selfId = false
addEvent("gotNewUrmatransVehicle", true)
addEventHandler("gotNewUrmatransVehicle", getRootElement(), function(cid)
  jobVehicles[source] = cid
  if cid == selfId then
    selfJobVehicle = source
  end
  if isElementStreamedIn(source) then
    for i = 1, #jobVehiclesStreamed do
      if jobVehiclesStreamed[i] == source then
        return
      end
    end
    table.insert(jobVehiclesStreamed, source)
  end
  jobVehiclesDoorAnimation[source] = nil
  jobVehiclesCargo[source] = {}
  checkPreRenderSprinters()
end)
function getSelfJobVehicle()
  return isElement(selfJobVehicle) and selfJobVehicle or false
end
addEventHandler("onClientVehicleStreamIn", getRootElement(), function()
  if jobVehicles[source] then
    for i = 1, #jobVehiclesStreamed do
      if jobVehiclesStreamed[i] == source then
        return
      end
    end
    table.insert(jobVehiclesStreamed, source)
    if jobVehiclesDoor[source] then
      processVehContents(source)
      processVehCart(source)
    end
    checkPreRenderSprinters()
  end
  jobVehiclesDoorAnimation[source] = nil
end)
addEventHandler("onClientVehicleStreamOut", getRootElement(), function()
  if jobVehicles[source] then
    for i = #jobVehiclesStreamed, 1, -1 do
      if jobVehiclesStreamed[i] == source then
        table.remove(jobVehiclesStreamed, i)
      end
    end
    checkPreRenderSprinters()
  end
  if jobVehiclesCargoObjects[source] then
    for i = 1, #jobVehiclesCargoObjects[source] do
      if isElement(jobVehiclesCargoObjects[source][i]) then
        destroyElement(jobVehiclesCargoObjects[source][i])
      end
    end
  end
  if isElement(jobVehicleCarts[source]) then
    destroyElement(jobVehicleCarts[source])
  end
  jobVehicleCarts[source] = nil
  jobVehiclesCargoObjects[source] = nil
  jobVehiclesDoorAnimation[source] = nil
end)
addEventHandler("onClientVehicleDestroy", getRootElement(), function()
  if jobVehiclesCargoObjects[source] then
    for i = 1, #jobVehiclesCargoObjects[source] do
      if isElement(jobVehiclesCargoObjects[source][i]) then
        destroyElement(jobVehiclesCargoObjects[source][i])
      end
    end
  end
  if isElement(jobVehicleCarts[source]) then
    destroyElement(jobVehicleCarts[source])
  end
  jobVehicleCarts[source] = nil
  if source == selfJobVehicle then
    selfJobVehicle = false
  end
  if jobVehicles[source] then
    for i = #jobVehiclesStreamed, 1, -1 do
      if jobVehiclesStreamed[i] == source then
        table.remove(jobVehiclesStreamed, i)
      end
    end
    checkPreRenderSprinters()
  end
  if sprinterInventoryVeh == source then
    if sprinterInventoryWindow then
      seexports.sGui:deleteGuiElement(sprinterInventoryWindow)
    end
    sprinterInventoryWindow = nil
    sprinterInventoryVeh = false
  end
  jobVehiclesCargoObjects[source] = nil
  jobVehiclesDoor[source] = nil
  jobVehiclesDoorAnimation[source] = nil
  jobVehiclesCargoObjects[source] = nil
  jobVehicles[source] = nil
end)
function attachHandContent(client)
  local id = handContentData[client]
  if cargoTypes[id] then
    local stack = cargoTypes[id].stack
    local x, y, z, q = stackAttachOffsets[stack][1], stackAttachOffsets[stack][2], stackAttachOffsets[stack][3], stackAttachOffsets[stack][4]
    seexports.sPattach:attach(handContent[client], client, 24, -z, y, x, 0, 0, 0)
    seexports.sPattach:setRotationQuaternion(handContent[client], q)
  end
end
addEventHandler("onClientPlayerStreamIn", getRootElement(), function()
  if source ~= localPlayer then
    if cartData[source] then
      local x, y, z, r, attach
      if type(cartData[source]) == "table" then
        x, y, z, r = unpack(cartData[source])
      else
        x, y, z = getElementPosition(source)
        r = 0
        attach = true
      end
      carts[source] = createObject(models.sight_urmatrans_cart, x, y, z, 0, 0, r)
      setElementCollisionsEnabled(carts[source], false)
      if isElement(cartSounds[source]) then
        destroyElement(cartSounds[source])
      end
      cartSounds[source] = nil
      if attach then
        cartSounds[source] = playSound3D("files/cart.mp3", x, y, z, true)
        attachElements(cartSounds[source], carts[source])
      end
      processCartContents(source)
      if attach then
        table.insert(attachedCarts, source)
        checkCartRender()
      end
    end
    if handContentData[source] then
      local id = handContentData[source]
      handContent[source] = createObject(models[cargoTypes[id].cargo], 0, 0, 0)
      attachHandContent(source)
    end
  end
end)
addEventHandler("onClientPlayerStreamOut", getRootElement(), function()
  if source ~= localPlayer then
    if isElement(carts[source]) then
      local attached = false
      for i = #attachedCarts, 1, -1 do
        if attachedCarts[i] == source then
          table.remove(attachedCarts, i)
          attached = true
        end
      end
      checkCartRender()
      if isElement(carts[source]) then
        destroyElement(carts[source])
      end
    end
    carts[source] = nil
    if cartContentObjects[source] then
      processCartContents(source)
    end
    if isElement(cartSounds[source]) then
      destroyElement(cartSounds[source])
    end
    cartSounds[source] = nil
    if isElement(handContent[source]) then
      destroyElement(handContent[source])
    end
    handContent[source] = nil
  end
end)
addEvent("urmatransCartAttachState", true)
addEventHandler("urmatransCartAttachState", getRootElement(), function(x, y, z, r)
  if x then
    cartData[source] = {
      x,
      y,
      z,
      r
    }
  else
    cartData[source] = true
  end
  if isElement(carts[source]) then
    for i = #attachedCarts, 1, -1 do
      if attachedCarts[i] == source then
        table.remove(attachedCarts, i)
      end
    end
    if isElement(cartSounds[source]) then
      destroyElement(cartSounds[source])
    end
    cartSounds[source] = nil
    if x then
      setElementPosition(carts[source], x, y, z)
      setElementRotation(carts[source], 0, 0, r)
    else
      table.insert(attachedCarts, source)
      cartSounds[source] = playSound3D("files/cart.mp3", 0, 0, 0, true)
      attachElements(cartSounds[source], carts[source])
    end
    checkCartRender()
    if source == localPlayer then
      if x then
        seexports.sControls:toggleControl({
          "jump",
          "sprint",
          "crouch",
          "aim_weapon",
          "fire",
          "enter_exit"
        }, true)
        unbindKey("f", "up", handleUrmacartDrop)
      else
        seexports.sControls:toggleControl({
          "jump",
          "sprint",
          "crouch",
          "aim_weapon",
          "fire",
          "enter_exit"
        }, false)
        bindKey("f", "up", handleUrmacartDrop)
      end
      resetHover()
    end
  end
end)
addEvent("gotNewUrmatransCart", true)
addEventHandler("gotNewUrmatransCart", getRootElement(), function(cid)
  if isElement(source) then
    if isElement(carts[source]) then
      destroyElement(carts[source])
    end
    carts[source] = nil
    if isElement(cartSounds[source]) then
      destroyElement(cartSounds[source])
    end
    cartSounds[source] = nil
    cartData[source] = true
    cartContents[source] = {}
    cartsCid[cid] = true
    for veh, client in pairs(jobVehicles) do
      if client == cid then
        if isElementStreamedIn(veh) then
          processVehCart(veh)
        end
        break
      end
    end
    if streamedInPlayerEx(source) and modelsLoaded then
      for i = #attachedCarts, 1, -1 do
        if attachedCarts[i] == source then
          table.remove(attachedCarts, i)
        end
      end
      local x, y, z = getElementPosition(source)
      playSound3D("files/cartout.mp3", x, y, z)
      carts[source] = createObject(models.sight_urmatrans_cart, x, y, z)
      setElementCollisionsEnabled(carts[source], false)
      cartSounds[source] = playSound3D("files/cart.mp3", x, y, z, true)
      attachElements(cartSounds[source], carts[source])
      table.insert(attachedCarts, source)
      checkCartRender()
    else
      carts[source] = nil
    end
    if source == localPlayer then
      seexports.sControls:toggleControl({
        "jump",
        "sprint",
        "crouch",
        "aim_weapon",
        "fire",
        "enter_exit"
      }, false)
      bindKey("f", "up", handleUrmacartDrop)
      myCartContents = {}
      resetHover()
      checkRenderPlayerCarts()
    end
  end
end)
addEvent("deleteUrmatransCart", true)
addEventHandler("deleteUrmatransCart", getRootElement(), function(cid)
  if isElement(carts[source]) then
    destroyElement(carts[source])
  end
  carts[source] = nil
  if isElement(cartSounds[source]) then
    destroyElement(cartSounds[source])
  end
  cartSounds[source] = nil
  cartData[source] = nil
  cartContents[source] = nil
  for i = #attachedCarts, 1, -1 do
    if attachedCarts[i] == source then
      table.remove(attachedCarts, i)
    end
  end
  cartsCid[cid] = nil
  for veh, client in pairs(jobVehicles) do
    if client == cid then
      if isElementStreamedIn(veh) then
        processVehCart(veh)
      end
      break
    end
  end
  if isElement(source) then
    local x, y, z = getElementPosition(source)
    playSound3D("files/cartin.mp3", x, y, z)
  end
  if source == localPlayer then
    seexports.sControls:toggleControl({
      "jump",
      "sprint",
      "crouch",
      "aim_weapon",
      "fire",
      "enter_exit"
    }, true)
    unbindKey("f", "up", handleUrmacartDrop)
    myCartContents = nil
    resetHover()
    checkRenderPlayerCarts()
  end
  checkCartRender()
  processCartContents(source)
end)
function cross(x, y, z, x2, y2, z2)
  return y * z2 - y2 * z, z * x2 - z2 * x, x * y2 - x2 * y
end
function refreshAllShelves()
  for k = 1, #cargoTypes do
    local dat = cargoTypes[k]
    for id = 1, #dat.cargoCoords do
      if not isElement(dat.cargoObjects[id]) then
        dat.cargoObjects[id] = createObject(models[dat.cargo], dat.cargoCoords[id][1], dat.cargoCoords[id][2], dat.cargoCoords[id][3], 0, 0, dat.cargoCoords[id][4])
      end
    end
  end
  for i = 1, #fulfillmentObjects do
    if isElement(fulfillmentObjects[i]) then
      destroyElement(fulfillmentObjects[i])
    end
    fulfillmentObjects[i] = nil
  end
end
addEvent("refreshUrmatransShelves", true)
addEventHandler("refreshUrmatransShelves", getRootElement(), function(k, id, back)
  if k then
    local dat = cargoTypes[k]
    if not id then
      for id = 1, #dat.cargoCoords do
        if not isElement(dat.cargoObjects[id]) then
          dat.cargoObjects[id] = createObject(models[dat.cargo], dat.cargoCoords[id][1], dat.cargoCoords[id][2], dat.cargoCoords[id][3], 0, 0, dat.cargoCoords[id][4])
          break
        end
      end
    elseif back then
      if not isElement(dat.cargoObjects[id]) then
        dat.cargoObjects[id] = createObject(models[dat.cargo], dat.cargoCoords[id][1], dat.cargoCoords[id][2], dat.cargoCoords[id][3], 0, 0, dat.cargoCoords[id][4])
      end
    else
      if isElement(dat.cargoObjects[id]) then
        destroyElement(dat.cargoObjects[id])
      end
      dat.cargoObjects[id] = nil
    end
  else
    refreshAllShelves()
  end
end)
local markers = {}
function refreshMarkers()
  for k = 1, #markers do
    if markers[k] then
      seexports.sMarkers:deleteCustomMarker(markers[k])
    end
    markers[k] = nil
  end
  if handContentData[localPlayer] then
    local k = handContentData[localPlayer]
    local dat = cargoTypes[k]
    for i = 1, #dat.cargoPos do
      for j = 1, 2 do
        local id = (i - 1) * 2 + j
        if not isElement(dat.cargoObjects[id]) then
          local marker = seexports.sMarkers:createCustomMarker(dat.cargoCoords[id][1], dat.cargoCoords[id][2], dat.cargoCoords[id][3] + dat.height + 0.125, 0, 0, "sightblue", "arrow_sm")
          table.insert(markers, marker)
        end
      end
    end
  elseif order then
    local tmp = {}
    for i in pairs(order) do
      for j, num in pairs(order[i]) do
        tmp[j] = (tmp[j] or 0) + num
      end
    end
    for k, num in pairs(tmp) do
      if not checkDoneItem(k, num) then
        local dat = cargoTypes[k]
        for i = 1, #dat.cargoPos do
          for j = 1, 2 do
            local id = (i - 1) * 2 + j
            if isElement(dat.cargoObjects[id]) then
              local marker = seexports.sMarkers:createCustomMarker(dat.cargoCoords[id][1], dat.cargoCoords[id][2], dat.cargoCoords[id][3] + dat.height + 0.125, 0, 0, "sightgreen", "arrow_sm")
              table.insert(markers, marker)
            end
          end
        end
      end
    end
  end
end
local carMarkers = {}
local vehiclePrompt = false
addEvent("okUrmatransVehiclePrompt", false)
addEventHandler("okUrmatransVehiclePrompt", getRootElement(), function(button, state, absoluteX, absoluteY, el, id)
  if vehiclePrompt then
    seexports.sGui:deleteGuiElement(vehiclePrompt)
  end
  vehiclePrompt = nil
  triggerServerEvent("requestUrmatransJobVehicle", localPlayer, id)
end)
addEvent("closeUrmatransVehiclePrompt", false)
addEventHandler("closeUrmatransVehiclePrompt", getRootElement(), function()
  if vehiclePrompt then
    seexports.sGui:deleteGuiElement(vehiclePrompt)
  end
  vehiclePrompt = nil
end)
addEvent("changeEnteredCustomMarker", false)
addEventHandler("changeEnteredCustomMarker", getRootElement(), function(theType, id)
  if vehiclePrompt then
    seexports.sGui:deleteGuiElement(vehiclePrompt)
  end
  vehiclePrompt = nil
  if theType == "urmatransVehicle" and (not selfJobVehicle or getPedOccupiedVehicle(localPlayer) == selfJobVehicle) then
    local pw = 340
    local ph = 120
    vehiclePrompt = seexports.sGui:createGuiElement("window", screenX / 2 - pw / 2, screenY / 2 - ph / 2, pw, ph)
    seexports.sGui:setWindowTitle(vehiclePrompt, "16/BebasNeueRegular.otf", "MiguTrans munkajármű")
    local titleBarHeight = seexports.sGui:getTitleBarHeight()
    local label = seexports.sGui:createGuiElement("label", 0, titleBarHeight, pw, ph - titleBarHeight - 30 - 6 - 6, vehiclePrompt)
    seexports.sGui:setLabelAlignment(label, "center", "center")
    if selfJobVehicle then
      seexports.sGui:setLabelText(label, "Biztosan szeretnéd leadni a munkajárművet?")
    else
      seexports.sGui:setLabelText(label, "Szeretnél kérni egy munkajárművet?")
    end
    seexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
    local bw = (pw - 18) / 2
    local btn = seexports.sGui:createGuiElement("button", 6, ph - 30 - 6, bw, 30, vehiclePrompt)
    seexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
    seexports.sGui:setGuiHover(btn, "gradient", {
      "sightgreen",
      "sightgreen-second"
    }, false, true)
    seexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
    seexports.sGui:setButtonText(btn, "Igen")
    seexports.sGui:setClickEvent(btn, "okUrmatransVehiclePrompt")
    seexports.sGui:setClickArgument(btn, id)
    local btn = seexports.sGui:createGuiElement("button", pw - bw - 6, ph - 30 - 6, bw, 30, vehiclePrompt)
    seexports.sGui:setGuiBackground(btn, "solid", "sightred")
    seexports.sGui:setGuiHover(btn, "gradient", {
      "sightred",
      "sightred-second"
    }, false, true)
    seexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
    seexports.sGui:setButtonText(btn, "Nem")
    seexports.sGui:setClickEvent(btn, "closeUrmatransVehiclePrompt")
  end
end)
addEventHandler("onClientResourceStop", getResourceRootElement(), function()
  for k = 1, #carMarkers do
    if carMarkers[k] then
      seexports.sMarkers:deleteCustomMarker(carMarkers[k])
    end
  end
  for k = 1, #markers do
    if markers[k] then
      seexports.sMarkers:deleteCustomMarker(markers[k])
    end
  end
end)
addEvent("refreshUrmatransHandContent", true)
addEventHandler("refreshUrmatransHandContent", getRootElement(), function(id)
  if isElement(handContent[source]) then
    destroyElement(handContent[source])
  end
  handContent[source] = nil
  if isElement(source) then
    local x, y, z = getElementPosition(source)
    if handContentData[source] and not id then
      playSound3D("files/boxle.mp3", x, y, z)
    elseif id then
      playSound3D("files/boxfel.mp3", x, y, z)
    end
    handContentData[source] = id
    if id and streamedInPlayerEx(source) and modelsLoaded then
      handContent[source] = createObject(models[cargoTypes[id].cargo], x, y, z)
      attachHandContent(source)
    end
    if source == localPlayer then
      if id then
        bindKey("f", "up", tryToPutDownHandContent)
      else
        unbindKey("f", "up", tryToPutDownHandContent)
      end
      refreshMarkers()
      if paper and not orderCompanies[orderPage] then
        createPapers()
      end
      checkRenderPlayerHandContent()
    end
  else
    handContentData[source] = nil
  end
end)
addEvent("toggleUrmatransSprinterDoor", true)
addEventHandler("toggleUrmatransSprinterDoor", getRootElement(), function(state)
  if jobVehicles[source] then
    jobVehiclesDoor[source] = state
    if isElementStreamedIn(source) then
      jobVehiclesDoorAnimation[source] = getTickCount()
      local x, y, z = getVehicleComponentPosition(source, "oldalajto", "world")
      if x then
        playSound3D("files/sb" .. (state and "o" or "c") .. ".mp3", x, y, z)
      end
    end
    if state then
      processVehContents(source)
      processVehCart(source)
    end
  end
end)
function preRenderSprinters()
  local now = getTickCount()
  if isElement(selfJobVehicle) then
    local hp = getElementHealth(selfJobVehicle)
    if vehHPSynced ~= hp then
      vehHPSynced = hp
      refreshVehHP()
    end
  end
  for i = #jobVehiclesStreamed, 1, -1 do
    local veh = jobVehiclesStreamed[i]
    if isElement(veh) then
      if isElementOnScreen(veh) then
        if jobVehiclesDoorAnimation[veh] then
          local p = (now - jobVehiclesDoorAnimation[veh]) / 1350
          if 1 < p then
            p = 1
            jobVehiclesDoorAnimation[veh] = nil
            if not jobVehiclesDoor[veh] then
              processVehContents(veh)
              processVehCart(veh)
            end
          end
          p = getEasingValue(jobVehiclesDoor[veh] and p or 1 - p, "InOutQuad")
          setVehicleComponentPosition(veh, "oldalajto", 0.1 * math.min(1, p * 4), -1.55 * p, 0)
        elseif jobVehiclesDoor[veh] then
          setVehicleComponentPosition(veh, "oldalajto", 0.1, -1.55, 0)
        else
          setVehicleComponentPosition(veh, "oldalajto", 0, 0, 0)
        end
      end
    else
      table.remove(jobVehiclesStreamed, i)
    end
  end
end
local cartHover = false
local cargoHoverId = false
local cargoHoverCargo = false
local vehHover = false
function resetHover()
  if cartHover or cargoHoverId or cargoHoverCargo or vehHover then
    seexports.sGui:setCursorType("normal")
    seexports.sGui:showTooltip()
  end
  cartHover = false
  cargoHoverId = false
  cargoHoverCargo = false
  vehHover = false
end
function deleteSprinterInventory()
  if sprinterInventoryWindow then
    seexports.sGui:deleteGuiElement(sprinterInventoryWindow)
  end
  sprinterInventoryWindow = nil
  sprinterInventoryVeh = false
end
addEvent("deleteSprinterInventory", true)
addEventHandler("deleteSprinterInventory", getRootElement(), deleteSprinterInventory)
addEvent("urmatransInventoryDeleteCargo", false)
addEventHandler("urmatransInventoryDeleteCargo", getRootElement(), function(button, state, absoluteX, absoluteY, el, id)
  triggerServerEvent("urmatransSprinterRemoveCargo", sprinterInventoryVeh, id)
end)
addEvent("urmatransInventoryPickCargo", false)
addEventHandler("urmatransInventoryPickCargo", getRootElement(), function(button, state, absoluteX, absoluteY, el, id)
  triggerServerEvent("urmatransSprinterRemoveCargo", sprinterInventoryVeh, id, true)
end)
function createSprinterInventory(veh)
  deleteSprinterInventory()
  local dat = {}
  local n = 0
  if jobVehiclesCargo[veh] then
    for i = 1, #jobVehiclesCargo[veh] do
      local id = jobVehiclesCargo[veh][i]
      if not dat[id] then
        dat[id] = 1
        n = n + 1
      else
        dat[id] = dat[id] + 1
      end
    end
  end
  if n <= 0 then
    seexports.sGui:showInfobox("e", "A raktér üres.")
    return
  end
  sprinterInventoryVeh = veh
  local titleBarHeight = seexports.sGui:getTitleBarHeight()
  local plate = getVehiclePlateText(veh)
  plate = table.concat(split(plate, "-"), "-")
  local col = 1
  while titleBarHeight + math.ceil(n / col) * 42 > screenY * 0.5 do
    col = col + 1
  end
  local pw = 300 * col + (col - 1) * 2
  local n2 = math.ceil(n / col)
  local ph = titleBarHeight + n2 * 32 + (n2 - 1) * 10 + 8
  sprinterInventoryWindow = seexports.sGui:createGuiElement("window", screenX / 2 - pw / 2, screenY / 2 - ph / 2, pw, ph)
  seexports.sGui:setWindowTitle(sprinterInventoryWindow, "16/BebasNeueRegular.otf", "Raktér (" .. plate .. ")")
  seexports.sGui:setWindowCloseButton(sprinterInventoryWindow, "deleteSprinterInventory")
  local i = 0
  local y = titleBarHeight + 4
  local x = 4
  local j = 1
  for id, num in pairs(dat) do
    i = i + 1
    local dat = cargoTypes[id]
    local rect = seexports.sGui:createGuiElement("rectangle", x, y, 32, 32, sprinterInventoryWindow)
    seexports.sGui:setGuiBackground(rect, "solid", "sightgrey3")
    local image = seexports.sGui:createGuiElement("image", 0, 0, 32, 32, rect)
    seexports.sGui:setImageFile(image, ":sJob_raktar/files/renders/" .. dat.model .. ".png")
    local label = seexports.sGui:createGuiElement("label", x + 32 + 4, y, 0, 16, sprinterInventoryWindow)
    seexports.sGui:setLabelAlignment(label, "left", "center")
    seexports.sGui:setLabelText(label, dat.name)
    seexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
    local label = seexports.sGui:createGuiElement("label", x + 32 + 4, y + 16, 0, 16, sprinterInventoryWindow)
    seexports.sGui:setLabelAlignment(label, "left", "center")
    seexports.sGui:setLabelText(label, num .. " " .. dat.quantity)
    seexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
    local btn = seexports.sGui:createGuiElement("button", x + 300 - 32 - 8, y, 32, 32, sprinterInventoryWindow)
    seexports.sGui:setGuiBackground(btn, "solid", "sightgrey1", false, true)
    seexports.sGui:setGuiHover(btn, "gradient", {"sightgrey1", "sightgrey3"}, false, true)
    seexports.sGui:setButtonIcon(btn, seexports.sGui:getFaIconFilename("trash-alt", 24))
    seexports.sGui:setClickEvent(btn, "urmatransInventoryDeleteCargo")
    seexports.sGui:setClickArgument(btn, id)
    seexports.sGui:guiSetTooltip(btn, "Áru törlése")
    local btn = seexports.sGui:createGuiElement("button", x + 300 - 72 - 4, y, 32, 32, sprinterInventoryWindow)
    seexports.sGui:setGuiBackground(btn, "solid", "sightgrey1", false, true)
    seexports.sGui:setGuiHover(btn, "gradient", {"sightgrey1", "sightgrey3"}, false, true)
    seexports.sGui:setButtonIcon(btn, seexports.sGui:getFaIconFilename("arrow-alt-up", 24))
    seexports.sGui:setClickEvent(btn, "urmatransInventoryPickCargo")
    seexports.sGui:setClickArgument(btn, id)
    seexports.sGui:guiSetTooltip(btn, "Áru kivétele")
    y = y + 32
    if i < n2 * j then
      local border = seexports.sGui:createGuiElement("hr", x, y + 4, 292, 2, sprinterInventoryWindow)
      y = y + 8 + 2
    else
      if col > j then
        x = x + 300
        local border = seexports.sGui:createGuiElement("hr", x - 4, titleBarHeight + 4, 2, y - titleBarHeight - 4, sprinterInventoryWindow)
        x = x + 2
        y = titleBarHeight + 4
      end
      j = j + 1
    end
  end
end
local preRenderSprintersHandled = false
local hoverRenderHandled = false
local renderSprintersHandled = false
local renderPlayerCartsHandled = false
local renderPlayerHandContentHandled = false
local renderJobZoneHandled = false
local renderCartHandled = false
function checkPreRenderSprinters()
  local tmp = selfJobVehicle and true or 0 < #jobVehiclesStreamed
  if tmp ~= preRenderSprintersHandled then
    preRenderSprintersHandled = tmp
    if tmp then
      addEventHandler("onClientPreRender", getRootElement(), preRenderSprinters)
      addEventHandler("onClientRender", getRootElement(), renderSprinters, true, "normal-1")
    else
      removeEventHandler("onClientPreRender", getRootElement(), preRenderSprinters)
      removeEventHandler("onClientRender", getRootElement(), renderSprinters)
    end
    checkHoverRender()
  end
end
function checkRenderPlayerCarts()
  local tmp = carts[localPlayer] and true or false
  if tmp ~= renderPlayerCartsHandled then
    renderPlayerCartsHandled = tmp
    if tmp then
      addEventHandler("onClientRender", getRootElement(), renderPlayerCarts, true, "normal-2")
    else
      removeEventHandler("onClientRender", getRootElement(), renderPlayerCarts)
    end
    checkHoverRender()
  end
end
function checkRenderPlayerHandContent()
  local tmp = handContentData[localPlayer] and true or false
  if tmp ~= renderPlayerHandContentHandled then
    renderPlayerHandContentHandled = tmp
    if tmp then
      addEventHandler("onClientRender", getRootElement(), renderPlayerHandContent, true, "normal-3")
    else
      removeEventHandler("onClientRender", getRootElement(), renderPlayerHandContent)
    end
    checkHoverRender()
  end
end
function checkRenderJobZone()
  local tmp = isElementWithinColShape(localPlayer, raktarZone)
  if tmp ~= renderJobZoneHandled then
    renderJobZoneHandled = tmp
    if tmp then
      addEventHandler("onClientRender", getRootElement(), renderJobZone, true, "normal-4")
      addEventHandler("onClientClick", getRootElement(), jobNPCClick)
    else
      removeEventHandler("onClientRender", getRootElement(), renderJobZone)
      removeEventHandler("onClientClick", getRootElement(), jobNPCClick)
    end
    checkHoverRender()
  end
end
function checkCartRender()
  local tmp = 0 < #attachedCarts
  if tmp ~= renderCartHandled then
    renderCartHandled = tmp
    if tmp then
      addEventHandler("onClientRender", getRootElement(), onClientRenderCart)
      addEventHandler("onClientPedsProcessed", getRootElement(), onClientPedsProcessedCart)
    else
      removeEventHandler("onClientRender", getRootElement(), onClientRenderCart)
      removeEventHandler("onClientPedsProcessed", getRootElement(), onClientPedsProcessedCart)
    end
  end
end
function checkHoverRender()
  local tmp = preRenderSprintersHandled or renderSprintersHandled or renderPlayerCartsHandled or renderPlayerHandContentHandled or renderJobZoneHandled
  if tmp ~= hoverRenderHandled then
    hoverRenderHandled = tmp
    if tmp then
      addEventHandler("onClientRender", getRootElement(), renderHoverBefore, true, "high+999")
      addEventHandler("onClientRender", getRootElement(), renderHoverAfter, true, "low-999")
      addEventHandler("onClientClick", getRootElement(), urmatransHoverClick)
    else
      removeEventHandler("onClientRender", getRootElement(), renderHoverBefore)
      removeEventHandler("onClientRender", getRootElement(), renderHoverAfter)
      removeEventHandler("onClientClick", getRootElement(), urmatransHoverClick)
      resetHover()
    end
  end
end
local cx, cy = false, false
local tmpCart = false
local tmpId = false
local tmpCargo = false
local tmpVeh = false
local px, py, pz
local inVeh = false
function renderHoverBefore()
  inVeh = isPedInVehicle(localPlayer)
  if inVeh then
    if cartHover or cargoHoverId or cargoHoverCargo or vehHover then
      resetHover()
    end
    if sprinterInventoryWindow then
      deleteSprinterInventory()
    end
    return
  end
  tmpCart = false
  tmpId = false
  tmpCargo = false
  tmpVeh = false
  cx, cy = getCursorPosition()
  if cx then
    cx = cx * screenX
    cy = cy * screenY
  end
  px, py, pz = getElementPosition(localPlayer)
end
function renderHoverAfter()
  if inVeh then
    return
  end
  if cargoHoverId ~= tmpId or cargoHoverCargo ~= tmpCargo or cartHover ~= tmpCart or vehHover ~= tmpVeh then
    cartHover = tmpCart
    cargoHoverId = tmpId
    cargoHoverCargo = tmpCargo
    vehHover = tmpVeh
    seexports.sGui:setCursorType((tmpId or tmpCart or tmpVeh) and "link" or "normal")
    if tmpVeh then
      if tmpCargo then
        if handContentData[localPlayer] then
          seexports.sGui:showTooltip("Áru berakodása a furgonba")
        else
          seexports.sGui:showTooltip("Raktér")
        end
      elseif tmpCart then
        seexports.sGui:showTooltip("Kézikocsi " .. (cartData[localPlayer] and "berakása" or "kivétele"))
      else
        seexports.sGui:showTooltip("Ajtó " .. (jobVehiclesDoor[tmpVeh] and "bezárása" or "kinyitása"))
      end
    elseif tmpCart then
      if handContentData[localPlayer] then
        seexports.sGui:showTooltip("Áru felrakása a kézikocsira")
      elseif tmpCargo then
        seexports.sGui:showTooltip(cargoTypes[tmpCargo].name)
      else
        seexports.sGui:showTooltip("Kézikocsi használata")
      end
    elseif tmpId then
      if handContentData[localPlayer] then
        seexports.sGui:showTooltip("Áru visszarakása a polcra")
      else
        seexports.sGui:showTooltip(cargoTypes[tmpId].name)
      end
    else
      seexports.sGui:showTooltip()
    end
  end
end
function renderSprinters()
  if inVeh then
    return
  end
  if sprinterInventoryWindow then
    if carts[localPlayer] ~= true and not handContentData[localPlayer] and isElement(sprinterInventoryVeh) and not jobVehiclesDoorAnimation[sprinterInventoryVeh] and jobVehiclesDoor[sprinterInventoryVeh] then
      local m = getElementMatrix(sprinterInventoryVeh)
      if m then
        local wx = m[4][1] + m[1][1] * 1 - m[2][1] * 0.15 + m[3][1] * 0.275
        local wy = m[4][2] + m[1][2] * 1 - m[2][2] * 0.15 + m[3][2] * 0.275
        local wz = m[4][3] + m[1][3] * 1 - m[2][3] * 0.15 + m[3][3] * 0.275
        if getDistanceBetweenPoints3D(wx, wy, wz, px, py, pz) > 2.5 then
          deleteSprinterInventory()
        end
      else
        deleteSprinterInventory()
      end
    else
      deleteSprinterInventory()
    end
  else
    for i = #jobVehiclesStreamed, 1, -1 do
      local veh = jobVehiclesStreamed[i]
      if not jobVehiclesDoorAnimation[veh] then
        local d = getDistanceBetweenPoints3D(px, py, pz, getElementPosition(veh))
        if d <= 7.5 then
          local m = getElementMatrix(veh)
          if (not isVehicleLocked(veh) or jobVehiclesDoor[veh]) and m then
            local wx, wy, wz = getVehicleComponentPosition(veh, "oldalajto", "world")
            if wx then
              wx = wx + m[1][1] * 1 + m[2][1] * 0.375 + m[3][1] * 0.275
              wy = wy + m[1][2] * 1 + m[2][2] * 0.375 + m[3][2] * 0.275
              wz = wz + m[1][3] * 1 + m[2][3] * 0.375 + m[3][3] * 0.275
            else
              wx = m[4][1] + m[1][1] * 1 - m[2][1] * 0.15 + m[3][1] * 0.275
              wy = m[4][2] + m[1][2] * 1 - m[2][2] * 0.15 + m[3][2] * 0.275
              wz = m[4][3] + m[1][3] * 1 - m[2][3] * 0.15 + m[3][3] * 0.275
            end
            local x, y = getScreenFromWorldPosition(wx, wy, wz, 64)
            if x then
              local d = getDistanceBetweenPoints3D(wx, wy, wz, px, py, pz)
              local a = 255 * (1 - math.max(0, d - 2) / 0.5)
              if 0 < a then
                dxDrawRectangle(x - 16, y - 16, 32, 32, tocolor(bcg[1], bcg[2], bcg[3], a))
                if not tmpCart and not tmpId and 255 <= a and cx and cx >= x - 16 and cy >= y - 16 and cx <= x + 16 and cy <= y + 16 then
                  tmpVeh = veh
                  dxDrawImage(x - 16, y - 16, 32, 32, ":sGui/" .. leftIcon .. faTicks[leftIcon], jobVehiclesDoor[veh] and 0 or 180, 0, 0, greenToColor)
                else
                  dxDrawImage(x - 16, y - 16, 32, 32, ":sGui/" .. leftIcon .. faTicks[leftIcon], jobVehiclesDoor[veh] and 0 or 180, 0, 0, tocolor(255, 255, 255, a))
                end
              end
            end
          end
          if jobVehiclesDoor[veh] and m then
            local wx = m[4][1] + m[1][1] * 1 - m[2][1] * 0.15 + m[3][1] * 0.275
            local wy = m[4][2] + m[1][2] * 1 - m[2][2] * 0.15 + m[3][2] * 0.275
            local wz = m[4][3] + m[1][3] * 1 - m[2][3] * 0.15 + m[3][3] * 0.275
            local x, y = getScreenFromWorldPosition(wx, wy, wz, 64)
            if x then
              local d = getDistanceBetweenPoints3D(wx, wy, wz, px, py, pz)
              local a = 255 * (1 - math.max(0, d - 2) / 0.5)
              if 0 < a then
                if cartData[localPlayer] == true and jobVehicles[veh] == selfId then
                  dxDrawRectangle(x - 16, y - 16, 32, 32, tocolor(bcg[1], bcg[2], bcg[3], a))
                  if not tmpCart and not tmpId and not tmpVeh and 255 <= a and cx and cx >= x - 16 and cy >= y - 16 and cx <= x + 16 and cy <= y + 16 then
                    tmpVeh = veh
                    tmpCart = true
                    dxDrawImage(x - 16, y - 16, 32, 32, ":sGui/" .. inIcon .. faTicks[inIcon], 270, 0, 0, greenToColor)
                  else
                    dxDrawImage(x - 16, y - 16, 32, 32, ":sGui/" .. inIcon .. faTicks[inIcon], 270, 0, 0, tocolor(255, 255, 255, a))
                  end
                elseif handContentData[localPlayer] then
                  dxDrawRectangle(x - 16, y - 16, 32, 32, tocolor(bcg[1], bcg[2], bcg[3], a))
                  if not tmpCart and not tmpId and not tmpVeh and 255 <= a and cx and cx >= x - 16 and cy >= y - 16 and cx <= x + 16 and cy <= y + 16 then
                    tmpVeh = veh
                    tmpCargo = true
                    dxDrawImage(x - 16, y - 16, 32, 32, ":sGui/" .. putDownIcon .. faTicks[putDownIcon], 0, 0, 0, greenToColor)
                  else
                    dxDrawImage(x - 16, y - 16, 32, 32, ":sGui/" .. putDownIcon .. faTicks[putDownIcon], 0, 0, 0, tocolor(255, 255, 255, a))
                  end
                elseif jobVehicles[veh] == selfId then
                  local cartIcon = not cartData[localPlayer]
                  if cartIcon then
                    x = x - 18
                  end
                  dxDrawRectangle(x - 16, y - 16, 32, 32, tocolor(bcg[1], bcg[2], bcg[3], a))
                  if not tmpCart and not tmpId and not tmpVeh and 255 <= a and cx and cx >= x - 16 and cy >= y - 16 and cx <= x + 16 and cy <= y + 16 then
                    tmpVeh = veh
                    tmpCargo = true
                    dxDrawImage(x - 16, y - 16, 32, 32, ":sGui/" .. listIcon .. faTicks[listIcon], 0, 0, 0, greenToColor)
                  else
                    dxDrawImage(x - 16, y - 16, 32, 32, ":sGui/" .. listIcon .. faTicks[listIcon], 0, 0, 0, tocolor(255, 255, 255, a))
                  end
                  if cartIcon then
                    x = x + 32 + 4
                    dxDrawRectangle(x - 16, y - 16, 32, 32, tocolor(bcg[1], bcg[2], bcg[3], a))
                    if not tmpCart and not tmpId and not tmpVeh and 255 <= a and cx and cx >= x - 16 and cy >= y - 16 and cx <= x + 16 and cy <= y + 16 then
                      tmpVeh = veh
                      tmpCart = true
                      dxDrawImage(x - 16, y - 16, 32, 32, ":sGui/" .. outIcon .. faTicks[outIcon], 270, 0, 0, greenToColor)
                    else
                      dxDrawImage(x - 16, y - 16, 32, 32, ":sGui/" .. outIcon .. faTicks[outIcon], 270, 0, 0, tocolor(255, 255, 255, a))
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
function renderPlayerCarts()
  if inVeh then
    return
  end
  local m = getElementMatrix(carts[localPlayer])
  if handContentData[localPlayer] then
    local wx, wy, wz = m[4][1] - m[2][1] * 1.0416 - m[3][1] * 0.5, m[4][2] - m[2][2] * 1.0416 - m[3][2] * 0.5, m[4][3] - m[2][3] * 1.0416 - m[3][3] * 0.5
    local x, y = getScreenFromWorldPosition(wx, wy, wz, 64)
    if x then
      local d = getDistanceBetweenPoints3D(wx, wy, wz, px, py, pz)
      local a = 255 * (1 - math.max(0, d - 2) / 0.5)
      if 0 < a then
        dxDrawRectangle(x - 16, y - 16, 32, 32, tocolor(bcg[1], bcg[2], bcg[3], a))
        if 255 <= a and cx and cx >= x - 16 and cy >= y - 16 and cx <= x + 16 and cy <= y + 16 then
          tmpCart = true
          dxDrawImage(x - 16, y - 16, 32, 32, ":sGui/" .. putDownIcon .. faTicks[putDownIcon], 0, 0, 0, greenToColor)
        else
          dxDrawImage(x - 16, y - 16, 32, 32, ":sGui/" .. putDownIcon .. faTicks[putDownIcon], 0, 0, 0, tocolor(255, 255, 255, a))
        end
      end
    end
  elseif cartData[localPlayer] ~= true then
    local wx, wy, wz = m[4][1] - m[2][1] * 1.0416 - m[3][1] * 0.5, m[4][2] - m[2][2] * 1.0416 - m[3][2] * 0.5, m[4][3] - m[2][3] * 1.0416 - m[3][3] * 0.5
    local sx, sy = getScreenFromWorldPosition(wx, wy, wz, 64)
    if sx then
      local d = getDistanceBetweenPoints3D(wx, wy, wz, px, py, pz)
      local a = 255 * (1 - math.max(0, d - 2) / 0.5)
      if 0 < a then
        local n = #myCartContents
        local w = math.min(n, 4)
        local h = math.ceil(n / 4)
        x = sx - 60 * (w - 1) / 2
        y = sy - 60 * (h - 1) / 2
        for i = 1, n do
          local dat = cargoTypes[myCartContents[i]]
          dxDrawRectangle(x - 25 - 2, y - 25 - 2, 54, 54, tocolor(bcg[1], bcg[2], bcg[3], a))
          if 255 <= a and cx and cx >= x - 25 - 2 and cy >= y - 25 - 2 and cx <= x + 25 + 2 and cy <= y + 25 + 2 then
            dxDrawRectangle(x - 25, y - 25, 50, 50, bcg3ToColor)
            tmpCart = true
            tmpCargo = myCartContents[i]
          else
            dxDrawRectangle(x - 25, y - 25, 50, 50, tocolor(bcg2[1], bcg2[2], bcg2[3], a))
          end
          dxDrawImage(x - 25, y - 25, 50, 50, "files/renders/" .. dat.model .. ".png", 0, 0, 0, tocolor(255, 255, 255, a))
          if i % 4 == 0 then
            y = y + 60
            if i == (h - 1) * 4 then
              x = sx - 60 * (n - (h - 1) * 4 - 1) / 2
            else
              x = sx - 60 * (w - 1) / 2
            end
          else
            x = x + 60
          end
        end
      end
    end
    local wx, wy, wz = cartData[localPlayer][1], cartData[localPlayer][2], cartData[localPlayer][3]
    local x, y = getScreenFromWorldPosition(wx, wy, wz, 64)
    if x then
      local d = getDistanceBetweenPoints3D(wx, wy, wz, px, py, pz)
      local a = 255 * (1 - math.max(0, d - 2) / 0.5)
      if 0 < a then
        dxDrawRectangle(x - 16, y - 16, 32, 32, tocolor(bcg[1], bcg[2], bcg[3], a))
        if not tmpCart and not tmpId and 255 <= a and cx and cx >= x - 16 and cy >= y - 16 and cx <= x + 16 and cy <= y + 16 then
          tmpCart = true
          dxDrawImage(x - 16, y - 16, 32, 32, ":sGui/" .. grabIcon .. faTicks[grabIcon], 0, 0, 0, greenToColor)
        else
          dxDrawImage(x - 16, y - 16, 32, 32, ":sGui/" .. grabIcon .. faTicks[grabIcon], 0, 0, 0, tocolor(255, 255, 255, a))
        end
      end
    end
  end
end
function renderPlayerHandContent()
  if inVeh then
    return
  end
  local dat = cargoTypes[handContentData[localPlayer]]
  if not dat.cargoCoords then
    dat.cargoCoords = {}
  end
  for id = 1, #dat.cargoCoords do
    if not isElement(dat.cargoObjects[id]) then
      local wx, wy, wz = dat.cargoCoords[id][1], dat.cargoCoords[id][2], dat.cargoCoords[id][3] + dat.height / 2
      local x, y = getScreenFromWorldPosition(wx, wy, wz, 64)
      if x then
        local d = getDistanceBetweenPoints3D(wx, wy, wz, px, py, pz)
        local a = 255 * (1 - math.max(0, d - 2) / 0.5)
        if 0 < a then
          dxDrawRectangle(x - 16, y - 16, 32, 32, tocolor(bcg[1], bcg[2], bcg[3], a))
          if not tmpCart and 255 <= a and cx and cx >= x - 16 and cy >= y - 16 and cx <= x + 16 and cy <= y + 16 then
            tmpId = true
            tmpCargo = id
            dxDrawImage(x - 16, y - 16, 32, 32, ":sGui/" .. putDownIcon .. faTicks[putDownIcon], 0, 0, 0, greenToColor)
          else
            dxDrawImage(x - 16, y - 16, 32, 32, ":sGui/" .. putDownIcon .. faTicks[putDownIcon], 0, 0, 0, tocolor(255, 255, 255, a))
          end
        end
      end
    end
  end
end
function renderJobZone()
  if inVeh then
    return
  end
  if not handContentData[localPlayer] and cartData[localPlayer] ~= true then
    for k = 1, #cargoTypes do
      local dat = cargoTypes[k]
      for id = 1, #dat.cargoCoords do
        if isElement(dat.cargoObjects[id]) then
          local wx, wy, wz = dat.cargoCoords[id][1], dat.cargoCoords[id][2], dat.cargoCoords[id][3] + dat.height / 2
          local x, y = getScreenFromWorldPosition(wx, wy, wz, 64)
          if x then
            local d = getDistanceBetweenPoints3D(wx, wy, wz, px, py, pz)
            local a = 255 * (1 - math.max(0, d - 2) / 0.5)
            if 0 < a then
              dxDrawRectangle(x - 25 - 2, y - 25 - 2, 54, 54, tocolor(bcg[1], bcg[2], bcg[3], a))
              if 255 <= a and cx and cx >= x - 25 - 2 and cy >= y - 25 - 2 and cx <= x + 25 + 2 and cy <= y + 25 + 2 then
                dxDrawRectangle(x - 25, y - 25, 50, 50, bcg3ToColor)
                tmpId = k
                tmpCargo = id
              else
                dxDrawRectangle(x - 25, y - 25, 50, 50, tocolor(bcg2[1], bcg2[2], bcg2[3], a))
              end
              dxDrawImage(x - 25, y - 25, 50, 50, "files/renders/" .. dat.model .. ".png", 0, 0, 0, tocolor(255, 255, 255, a))
            end
          end
        end
      end
    end
  end
end
local lastTrigger = 0
function urmatransHoverClick(btn, state)
  if inVeh then
    return
  end
  if state == "down" then
    if vehHover then
      local now = getTickCount()
      if now - lastTrigger < 500 then
        seexports.sGui:showInfobox("e", "Várj egy kicsit!")
        return
      end
      if cargoHoverCargo then
        if handContentData[localPlayer] then
          if not handContentData[localPlayer] or not checkVehCargo(handContentData[localPlayer], jobVehiclesCargo[vehHover]) then
            seexports.sGui:showInfobox(client, "e", "Ez az áru már nem fér be ebbe a furgonba.")
            return
          end
          triggerServerEvent("urmatransPutCargoInVehicle", vehHover)
        else
          createSprinterInventory(vehHover)
        end
      elseif cartHover then
        if jobVehicles[vehHover] == selfId then
          triggerServerEvent("toggleUrmatransCart", localPlayer)
        end
      else
        triggerServerEvent("toggleUrmatransSprinterDoor", vehHover)
      end
      lastTrigger = now
    elseif cartHover then
      local now = getTickCount()
      if now - lastTrigger < 500 then
        seexports.sGui:showInfobox("e", "Várj egy kicsit!")
        return
      end
      if handContentData[localPlayer] then
        if not cartContents[localPlayer] or not checkCartCargo(handContentData[localPlayer], cartContents[localPlayer]) then
          seexports.sGui:showInfobox("e", "Ez az áru már nem fér fel erre a kézikocsira.")
          return
        end
        triggerServerEvent("putUrmatransCargoToCart", localPlayer)
      elseif cargoHoverCargo then
        triggerServerEvent("removeUrmatransCargoFromCart", localPlayer, cargoHoverCargo)
      else
        triggerServerEvent("pickUpUrmatransCart", localPlayer, cargoHoverCargo)
      end
      lastTrigger = now
    elseif cargoHoverId then
      local now = getTickCount()
      if now - lastTrigger < 500 then
        seexports.sGui:showInfobox("e", "Várj egy kicsit!")
        return
      end
      if handContentData[localPlayer] then
        triggerServerEvent("putBackUrmatransCargo", localPlayer, cargoHoverCargo)
      else
        triggerServerEvent("pickUpUrmatransCargo", localPlayer, cargoHoverId, cargoHoverCargo)
      end
      lastTrigger = now
    end
  end
end
function onClientRenderCart()
  myCartFlat = true
  for i = #attachedCarts, 1, -1 do
    local client = attachedCarts[i]
    local cart = carts[client]
    if isElement(client) and isElement(cart) then
      if isElement(cartSounds[client]) then
        local vx, vy = getElementVelocity(client)
        local spd = math.min(1, math.sqrt(vx * vx + vy * vy) / 0.04)
        setSoundVolume(cartSounds[client], math.pow(spd, 2.5))
        setSoundSpeed(cartSounds[client], math.pow(spd, 0.3))
      end
      if client == localPlayer or isElementOnScreen(client) or isElementOnScreen(cart) then
        local px, py, pz = getElementPosition(client)
        local x, y, z = getElementBonePosition(client, 25)
        if x then
          local x2, y2, z2 = getElementBonePosition(client, 35)
          if x2 then
            x = (x + x2) / 2
            y = (y + y2) / 2
            z = (z + z2) / 2
            local rx, ry, r = getElementRotation(client)
            rz = math.rad(r)
            local vx, vy = math.cos(rz), math.sin(rz)
            local hit, hx, hy, hz, he, nx, ny, nz = processLineOfSight(x - vy * 0.8, y + vx * 0.8, z, x - vy * 0.8, y + vx * 0.8, z - 10, true, false, false, true)
            if hit then
              local val = nx + ny + nz
              if 0.99 <= val and val <= 1.01 or val < 0 then
                local gz = getGroundPosition(px, py, pz)
                setElementPosition(cart, x, y, gz + 1.19265)
                setElementRotation(cart, 0, 0, r + 180)
              else
                if client == localPlayer then
                  myCartFlat = false
                end
                local fx, fy, fz = cross(vx, vy, 0, nx, ny, nz)
                local lx, ly, lz = cross(vy, -vx, 0, nx, ny, nz)
                local gz = getGroundPosition(x, y, z)
                setElementMatrix(cart, {
                  {
                    lx,
                    ly,
                    lz,
                    0
                  },
                  {
                    fx,
                    fy,
                    fz,
                    0
                  },
                  {
                    nx,
                    ny,
                    nz,
                    0
                  },
                  {
                    x,
                    y,
                    gz + 1.19265,
                    0
                  }
                })
              end
            else
              setElementPosition(cart, px, py, pz)
            end
          else
            setElementPosition(cart, px, py, pz)
          end
        else
          setElementPosition(cart, px, py, pz)
        end
      else
        local px, py, pz = getElementPosition(client)
        setElementPosition(cart, px, py, pz)
      end
    else
      table.remove(attachedCarts, i)
      checkCartRender()
    end
  end
end
function onClientPedsProcessedCart()
  for i = #attachedCarts, 1, -1 do
    local client = attachedCarts[i]
    local cart = carts[client]
    if isElement(client) and isElement(cart) and (client == localPlayer or isElementOnScreen(client) or isElementOnScreen(cart)) then
      setElementBoneRotation(client, 2, 0, 10, 0)
      setElementBoneRotation(client, 3, 0, 10, 0)
      setElementBoneRotation(client, 22, 13.043463333793, -49.565267148225, -20.869540338931)
      setElementBoneRotation(client, 23, -33.912973818572, -57.391204833984, 5.4732612909447E-5)
      setElementBoneRotation(client, 32, -13.043463333793, -49.565267148225, 20.869540338931)
      setElementBoneRotation(client, 33, -33.912973818572, -57.391204833984, 5.4732612909447E-5)
      seexports.sCore:updateElementRpHAnim(client)
    end
  end
end
local firstLoad = true
local shelfRT1 = {}
local shelfRT2 = {}
local shelfShader1 = {}
local shelfShader2 = {}
local textureChanger = [[
    texture gTexture;

    technique hello
    {
        pass P0
        {
            Texture[0] = gTexture;
        }
    }

]]
addEventHandler("onClientPlayerSpawn", localPlayer, function()
  checkRenderJobZone()
  processShelfSign()
end)
addEventHandler("onClientColShapeHit", raktarZone, function(md)
  checkRenderJobZone()
  if md then
    processShelfSign()
  end
end)
addEventHandler("onClientColShapeLeave", raktarZone, function(md)
  for i = 1, #shelfPoses do
    if isElement(shelfRT1[i]) then
      destroyElement(shelfRT1[i])
    end
    shelfRT1[i] = nil
    if isElement(shelfShader1[i]) then
      destroyElement(shelfShader1[i])
    end
    shelfShader1[i] = nil
    if isElement(shelfRT2[i]) then
      destroyElement(shelfRT2[i])
    end
    shelfRT2[i] = nil
    if isElement(shelfShader2[i]) then
      destroyElement(shelfShader2[i])
    end
    shelfShader2[i] = nil
  end
  checkRenderJobZone()
end)
function processShelfSign()
  if modelsLoaded and serversideLoaded and renderJobZoneHandled then
    local sign = dxCreateTexture("files/sign.dds", "dxt1")
    local j = 1
    local font = seexports.sGui:getFont("20/Ubuntu-R.ttf")
    local fontScale = seexports.sGui:getFontScale("20/Ubuntu-R.ttf")
    local font2 = seexports.sGui:getFont("15/BebasNeueRegular.otf")
    local font2Scale = seexports.sGui:getFontScale("15/BebasNeueRegular.otf") * 1.125
    local font2Height = seexports.sGui:getFontHeight("15/BebasNeueRegular.otf") * 1.125
    local shelfY = {}
    for i = 1, #shelfPoses do
      if not isElement(shelfRT1[i]) then
        shelfRT1[i] = dxCreateRenderTarget(256, 128, true)
        shelfShader1[i] = dxCreateShader(textureChanger)
        dxSetShaderValue(shelfShader1[i], "gTexture", shelfRT1[i])
        engineApplyShaderToWorldTexture(shelfShader1[i], "urmatrans_cargosign1", shelves[i])
      end
      if not isElement(shelfRT2[i]) then
        shelfRT2[i] = dxCreateRenderTarget(256, 128, true)
        shelfShader2[i] = dxCreateShader(textureChanger)
        dxSetShaderValue(shelfShader2[i], "gTexture", shelfRT2[i])
        engineApplyShaderToWorldTexture(shelfShader2[i], "urmatrans_cargosign2", shelves[i])
      end
      dxSetRenderTarget(shelfRT1[i])
      dxDrawImage(0, 0, 256, 128, sign)
      dxDrawText(j, 0, 0, 103, 128, tocolor(0, 0, 0), fontScale * 2, font, "center", "center")
      j = j + 1
      dxSetRenderTarget(shelfRT2[i])
      dxDrawImage(0, 0, 256, 128, sign)
      dxDrawText(j, 0, 0, 103, 128, tocolor(0, 0, 0), fontScale * 2, font, "center", "center")
      j = j + 1
    end
    if isElement(sign) then
      destroyElement(sign)
    end
    sign = nil
    for k in pairs(cargoTypes) do
      local id = math.ceil(cargoTypes[k].shelf / 2)
      if not shelfY[id] then
        shelfY[id] = 9
      end
      local i = math.ceil(id / 2)
      dxSetRenderTarget(id % 2 == 0 and shelfRT2[i] or shelfRT1[i])
      dxDrawText(cargoTypes[k].name, 105, shelfY[id], 245, 118, tocolor(0, 0, 0), font2Scale, font2, "left", "top", true)
      shelfY[id] = shelfY[id] + font2Height
    end
    dxSetRenderTarget()
  end
end
addEventHandler("onClientRestore", getRootElement(), processShelfSign)
local shelvesLoaded = false
function processCargoShelves()
  processShelfSign()
  if modelsLoaded and serversideLoaded and shelvesLoaded then
    for k = 1, #cargoTypes do
      local shelf = cargoTypes[k].shelf * 2
      local id = math.ceil(shelf / 8)
      local offset = (shelf - 1) % 8 + 1
      local x, y, z = shelfPoses[id][1], shelfPoses[id][2], shelfPoses[id][3]
      for i = 0, 1 do
        local x = x + shelfOffsetsBig[offset - i][1]
        local y = y + shelfOffsetsBig[offset - i][2]
        local z = z + shelfOffsetsBig[offset - i][3]
        if isElement(cargoTypes[k].shelfObjects[i]) then
          destroyElement(cargoTypes[k].shelfObjects[i])
        end
        cargoTypes[k].shelfObjects[i] = createObject(models[cargoTypes[k].model], x, y, z, 0, 0, 5 <= offset and 180 or 0)
      end
      local offset2 = 5 <= offset and offset - 1 or offset
      for i = 1, #cargoTypes[k].cargoPos do
        for j = 1, 2 do
          local id = (i - 1) * 2 + j
          local x, y, z = x + shelfOffsetsBig[offset2][1] + (cargoTypes[k].cargoPos[i][1] + (j - 1) * 4.9543) * (5 <= offset and -1 or 1), y + shelfOffsetsBig[offset2][2] + cargoTypes[k].cargoPos[i][2] * (5 <= offset and -1 or 1), z + shelfOffsetsBig[offset2][3] + cargoTypes[k].cargoPos[i][3]
          if isElement(cargoTypes[k].cargoObjects[id]) then
            destroyElement(cargoTypes[k].cargoObjects[id])
          end
          cargoTypes[k].cargoObjects[id] = createObject(models[cargoTypes[k].cargo], x, y, z, 0, 0, cargoTypes[k].cargoPos[i][4])
          cargoTypes[k].cargoCoords[id] = {
            x,
            y,
            z,
            cargoTypes[k].cargoPos[i][4]
          }
        end
      end
    end
    firstLoad = false
  end
end
function gotUrmatransShelves(shelfIds)
  for i = 1, #shelfIds do
    cargoTypes[shelfIds[i]].shelf = i
  end
  shelvesLoaded = true
  processCargoShelves()
end
addEvent("gotUrmatransShelves", true)
addEventHandler("gotUrmatransShelves", getRootElement(), gotUrmatransShelves)
addEventHandler("onClientElementDataChange", localPlayer, function(data)
  if data == "char.ID" then
    selfId = getElementData(localPlayer, "char.ID")
    selfJobVehicle = false
    for veh, cid in pairs(jobVehicles) do
      if cid == selfId then
        selfJobVehicle = veh
      end
    end
    checkPreRenderSprinters()
  end
end)
addEvent("gotUrmatransData", true)
addEventHandler("gotUrmatransData", getRootElement(), function(shelfIds, cart, content, hand, vehs, vehdoor, cargo)
  serversideLoaded = true
  for client in pairs(cartContentObjects) do
    if cartContentObjects[client] then
      for i = 1, #cartContentObjects[client] do
        if isElement(cartContentObjects[client][i]) then
          destroyElement(cartContentObjects[client][i])
        end
        cartContentObjects[client][i] = nil
      end
    end
  end
  for k in pairs(carts) do
    if isElement(carts[k]) then
      destroyElement(carts[k])
    end
    carts[k] = nil
  end
  for k in pairs(cartSounds) do
    if isElement(cartSounds[k]) then
      destroyElement(cartSounds[k])
    end
    cartSounds[k] = nil
  end
  cartData = cart
  cartContents = content
  attachedCarts = {}
  for client in pairs(cartData) do
    if streamedInPlayerEx(client) then
      local x, y, z, r, attach
      if type(cartData[client]) == "table" then
        x, y, z, r = unpack(cartData[client])
      else
        x, y, z = getElementPosition(client)
        r = 0
        attach = true
      end
      carts[client] = createObject(models.sight_urmatrans_cart, x, y, z, 0, 0, r)
      setElementCollisionsEnabled(carts[client], false)
      cartSounds[client] = playSound3D("files/cart.mp3", x, y, z, true)
      attachElements(cartSounds[client], carts[client])
      processCartContents(client)
      if attach then
        table.insert(attachedCarts, client)
      end
    end
  end
  for client in pairs(handContent) do
    if isElement(handContent[client]) then
      destroyElement(handContent[client])
    end
    handContent[client] = nil
  end
  handContentData = hand
  for client in pairs(handContentData) do
    if streamedInPlayerEx(client) then
      local id = handContentData[source]
      handContent[source] = createObject(models[cargoTypes[id].cargo], 0, 0, 0)
      attachHandContent(source)
    end
  end
  jobVehicles = vehs
  jobVehiclesDoor = vehdoor
  jobVehiclesDoorAnimation = {}
  selfJobVehicle = false
  jobVehiclesStreamed = {}
  selfId = getElementData(localPlayer, "char.ID")
  for cid, veh in pairs(jobVehicles) do
    if isElementStreamedIn(veh) then
      table.insert(jobVehiclesStreamed, veh)
    end
    if cid == selfId then
      selfJobVehicle = veh
    end
    jobVehiclesCargo[veh] = cargo[veh] or {}
    if isElementStreamedIn(veh) then
      processVehContents(veh)
      processVehCart(veh)
    end
  end
  checkPreRenderSprinters()
  checkRenderPlayerCarts()
  checkRenderPlayerHandContent()
  checkRenderJobZone()
  checkCartRender()
  gotUrmatransShelves(shelfIds)
end)
function loadModels()
  for k = 1, #carMarkers do
    if carMarkers[k] then
      seexports.sMarkers:deleteCustomMarker(carMarkers[k])
    end
  end
  local marker = seexports.sMarkers:createCustomMarker(carMarkersPos[1][1], carMarkersPos[1][2], carMarkersPos[1][3], 0, 0, "sightblue", "car")
  seexports.sMarkers:setCustomMarkerInterior(marker, "urmatransVehicle", 1, 3)
  table.insert(carMarkers, marker)
  local marker = seexports.sMarkers:createCustomMarker(carMarkersPos[2][1], carMarkersPos[2][2], carMarkersPos[2][3], 0, 0, "sightblue", "car")
  seexports.sMarkers:setCustomMarkerInterior(marker, "urmatransVehicle", 2, 3)
  table.insert(carMarkers, marker)
  local marker = seexports.sMarkers:createCustomMarker(carMarkersPos[3][1], carMarkersPos[3][2], carMarkersPos[3][3], 0, 0, "sightblue", "car")
  seexports.sMarkers:setCustomMarkerInterior(marker, "urmatransVehicle", 3, 3)
  table.insert(carMarkers, marker)
  for k in pairs(models) do
    models[k] = seexports.sModloader:getModelId(k)
  end
  modelsLoaded = true
  for i = 1, #shelves do
    if isElement(shelves[i]) then
      destroyElement(shelves[i])
    end
    shelves[i] = nil
  end
  for i = 1, #shelfPoses do
    shelves[i] = createObject(models.sight_urmatrans_shelf, shelfPoses[i][1], shelfPoses[i][2], shelfPoses[i][3], 0, 0, 0)
  end
  if serversideLoaded then
    processCargoShelves()
  else
    triggerServerEvent("requestUrmatransData", localPlayer)
  end
end

addEvent("onClientVehicleStartEnter", true)
function startEnter(ped)
for i = #attachedCarts, 1, -1 do
  if attachedCarts[i] == ped then
    cancelEvent()
  end
end
if isElement(handContent[ped]) then
  cancelEvent()
end
end
addEventHandler("onClientVehicleStartEnter", root, startEnter)