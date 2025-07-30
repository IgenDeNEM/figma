local sightexports = {
  sGui = false,
  sWeather = false,
  sControls = false
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
      addEventHandler("onClientPreRender", getRootElement(), preRenderCinemaCheck, true, prio)
    else
      removeEventHandler("onClientPreRender", getRootElement(), preRenderCinemaCheck)
    end
  end
end
local shopPeds = {
  {
    26,
    1167.71594,
    -1516.41016,
    15.79692,
    70,
    "Pénztáros"
  },
  {
    100,
    1166.27014,
    -1519.70508,
    15.79692,
    70,
    "Pénztáros"
  },
  {
    108,
    1175.32678,
    -1519.04724,
    22.83052,
    70,
    "Pénztáros"
  },
  {
    135,
    1174.07678,
    -1522.40393,
    22.83574,
    70,
    "Pénztáros"
  }
}
local shopPedEls = {}
local roomDatas = {}
local roomLights = {}
local roomQueue = {}
for i = 1, #rooms do
  roomQueue[i] = {}
end
local cinemaVolume = 1
local volumeState = true
local currentCinema = false
local browser = false
local shader = false
local shader2 = false
local rt = false
addEvent("refreshRoomLights", true)
addEventHandler("refreshRoomLights", getRootElement(), function(room, data)
  roomLights[room] = data
end)
local buyButtons = {}
local ticketShopWindow = false
local buyingTicket = false
addEventHandler("onClientClick", getRootElement(), function(button, state, absoluteX, absoluteY, worldX, worldY, worldZ, clickedElement)
  if shopPedEls[clickedElement] and state == "down" and not ticketShopWindow then
    local x, y, z = getElementPosition(clickedElement)
    local px, py, pz = getElementPosition(localPlayer)
    if getDistanceBetweenPoints2D(x, y, px, py) < 3 then
      createTicketShop()
    end
  end
end)
addEvent("gotRoomQueue", true)
addEventHandler("gotRoomQueue", getRootElement(), function(room, data)
  roomQueue[room] = data
  drawOutside()
  if ticketShopWindow then
    createTicketShop()
  end
end)
addEvent("gotRoomData", true)
addEventHandler("gotRoomData", getRootElement(), function(room, data)
  roomDatas[room] = data
  if roomDatas[room] then
    roomDatas[room][2] = getTickCount() - roomDatas[room][2] * 1000
  end
  drawOutside()
  if ticketShopWindow then
    createTicketShop()
  end
  if room == currentCinema then
    if roomDatas[currentCinema] then
      if not isElement(browser) then
        createElements()
      end
      local secs = math.floor((getTickCount() - roomDatas[currentCinema][2]) / 1000)
      loadBrowserURL(browser, "https://www.youtube.com/embed/" .. roomDatas[currentCinema][1] .. "?autoplay=true&controls=0&showinfo=0&autohide=1&start=" .. secs)
    else
      deleteElements()
    end
  end
end)
local outsideShader = false
local outsideRT = false
local outsideShader2 = false
local outsideRT2 = false
local preHandled = false
local popcornTextures = {}
function deleteOutside()
  sightlangCondHandl0(false)
  preRenderCinemaCheck()
  for i = 1, #popcornTextures do
    if isElement(popcornTextures[i]) then
      destroyElement(popcornTextures[i])
    end
  end
  popcornTextures = {}
  if isElement(outsideShader) then
    destroyElement(outsideShader)
  end
  outsideShader = false
  if isElement(outsideRT) then
    destroyElement(outsideRT)
  end
  outsideRT = false
  if isElement(outsideShader2) then
    destroyElement(outsideShader2)
  end
  outsideShader = false
  if isElement(outsideRT2) then
    destroyElement(outsideRT2)
  end
  outsideRT2 = false
  for k in pairs(shopPedEls) do
    if isElement(k) then
      destroyElement(k)
    end
  end
  shopPedEls = {}
  if preHandled then
    removeEventHandler("onClientPreRender", getRootElement(), popcornRender)
  end
  preHandled = false
end
local popcornDispensers = {
  {
    1166.8759,
    -1526.5232,
    16.3177,
    0,
    14.9,
    95,
    270,
    0.5,
    1,
    20
  },
  {
    1165.3498,
    -1530.7273,
    16.3177,
    0,
    14.9,
    95,
    270,
    0.5,
    1,
    20
  },
  {
    1174.5939,
    -1529.1396,
    23.32938,
    0,
    14.9,
    95,
    270,
    0.5,
    1,
    20
  },
  {
    1173.0464,
    -1533.3759,
    23.32938,
    0,
    14.9,
    95,
    270,
    0.5,
    1,
    20
  }
}
local popcorns = {}
function drawCorn(i, x, y, z, s)
  dxDrawMaterialLine3D(x, y, z + s, x, y, z - s, popcornTextures[i], s * 2)
end
function spawnPopcorn(x, y, z, mz, r, d, zd)
  local r = math.rad(r)
  local dat = {
    math.random(1, #popcornTextures),
    x,
    y,
    z,
    mz,
    math.random(90, 110) / 100,
    0.02 * math.random(90, 110) / 100,
    math.cos(r) * d,
    math.sin(r) * d,
    1,
    zd * math.random(90, 110) / 100
  }
  table.insert(popcorns, dat)
end
function popcornRender(delta)
  local px, py, pz = getElementPosition(localPlayer)
  local inDist = false
  for i = 1, #popcornDispensers do
    local x, y, z = popcornDispensers[i][1], popcornDispensers[i][2], popcornDispensers[i][3]
    popcornDispensers[i][4] = popcornDispensers[i][4] - delta
    local d = 2 > math.abs(z - pz) and getDistanceBetweenPoints2D(x, y, px, py) < 25
    if d then
      inDist = true
    end
    if popcornDispensers[i][4] <= 0 and d then
      popcornDispensers[i][4] = math.random(150, 800)
      local mz = popcornDispensers[i][5]
      local d = popcornDispensers[i][8]
      local zd = popcornDispensers[i][9]
      for j = 1, math.random(1, popcornDispensers[i][10]) do
        spawnPopcorn(x, y, z, mz, math.random(popcornDispensers[i][6], popcornDispensers[i][7]), d, zd)
      end
    end
  end
  if inDist then
    for i = #popcorns, 1, -1 do
      local speed = delta / 1000 * popcorns[i][6]
      if 0 < popcorns[i][10] then
        popcorns[i][10] = popcorns[i][10] - speed / 2
        if 0 > popcorns[i][10] then
          popcorns[i][10] = 0
        end
      end
      popcorns[i][4] = popcorns[i][4] - speed
      local p = 1 - popcorns[i][10]
      drawCorn(popcorns[i][1], popcorns[i][2] + popcorns[i][8] * p, popcorns[i][3] + popcorns[i][9] * p, popcorns[i][4] + math.sin(p * math.pi) * popcorns[i][11], popcorns[i][7])
      if popcorns[i][4] <= popcorns[i][5] then
        table.remove(popcorns, i)
      end
    end
  end
end
function createOutside()
  deleteOutside()
  sightlangCondHandl0(true)
  for i = 1, #shopPeds do
    local ped = createPed(shopPeds[i][1], shopPeds[i][2], shopPeds[i][3], shopPeds[i][4], shopPeds[i][5])
    setElementFrozen(ped, true)
    setElementData(ped, "invulnerable", true)
    setElementData(ped, "visibleName", shopPeds[i][6])
    setElementData(ped, "pedNameType", "Mozijegy")
    shopPedEls[ped] = i
  end
  outsideShader = dxCreateShader("files/texturechanger.fx")
  outsideRT = dxCreateRenderTarget(512, 64)
  if outsideShader then
    dxSetShaderValue(outsideShader, "gTexture", outsideRT)
    engineApplyShaderToWorldTexture(outsideShader, "cinema_signs3")
  end
  outsideShader2 = dxCreateShader("files/texturechanger.fx")
  outsideRT2 = dxCreateRenderTarget(2048, 512)
  if outsideShader then
    dxSetShaderValue(outsideShader2, "gTexture", outsideRT2)
    engineApplyShaderToWorldTexture(outsideShader2, "cinema_screen")
  end
  for i = 1, 3 do
    popcornTextures[i] = dxCreateTexture("files/pop" .. i .. ".png")
  end
  if not preHandled then
    addEventHandler("onClientPreRender", getRootElement(), popcornRender)
  end
  preHandled = true
  drawOutside()
end
function drawOutside()
  if outsideShader then
    local font = sightexports.sGui:getFont("15/BebasNeueBold.otf")
    local fontScale = sightexports.sGui:getFontScale("15/BebasNeueBold.otf")
    local font2 = sightexports.sGui:getFont("16/Ubuntu-R.ttf")
    local fontScale2 = sightexports.sGui:getFontScale("16/Ubuntu-R.ttf")
    dxSetRenderTarget(outsideRT2)
    dxDrawImage(0, 0, 2048, 512, "files/screen.dds")
    local current = getRealTime()
    local x = 0
    for room = 1, 2 do
      local y = 65
      local h = (512 - y - 8) / 10
      if roomDatas[room] and roomDatas[room][3] and roomDatas[room][5] then
        local dur = ""
        if roomDatas[room][4] then
          local min = math.floor(roomDatas[room][4] / 60 + 0.5)
          local hour = math.floor(min / 60)
          min = min - 60 * hour
          dur = " | " .. hour .. " óra " .. min .. " perc"
        end
        dxDrawText("Jelenleg: " .. roomDatas[room][3] .. dur, x + 1, y + 1, x + 1024 + 1, y + h + 1, tocolor(0, 0, 0), fontScale2 * 1.1, font2, "center", "center", false, false, false, true, false, rr)
        dxDrawText("Jelenleg: " .. roomDatas[room][3] .. dur, x, y, x + 1024, y + h, tocolor(255, 255, 255), fontScale2 * 1.1, font2, "center", "center", false, false, false, true, false, rr)
        dxDrawLine(x + 8 + 1, y + h * 1.125 + 1, x + 1024 - 16 + 1, y + h * 1.05 + 1, tocolor(0, 0, 0))
        dxDrawLine(x + 8, y + h * 1.125, x + 1024 - 16, y + h * 1.05, tocolor(255, 255, 255))
        y = y + h * 1.1
      end
      for id = 1, 10 do
        if roomQueue[room][id] and roomQueue[room][id] then
          local time = getRealTime(roomQueue[room][id][5] or roomQueue[room][id][1])
          local date = ""
          if not roomDatas[room] or roomDatas[room][1] ~= roomQueue[room][id][2] then
            local dur = ""
            if roomQueue[room][id][3] then
              local min = math.floor(roomQueue[room][id][3] / 60 + 0.5)
              local hour = math.floor(min / 60)
              min = min - 60 * hour
              dur = dur .. " | " .. hour .. " óra " .. min .. " perc"
            end
            if current.timestamp >= time.timestamp then
              dxDrawText("Jelenleg: " .. roomQueue[room][id][4] .. dur, x + 1, y + 1, x + 1024 + 1, y + h + 1, tocolor(0, 0, 0), fontScale2 * 1.1, font2, "center", "center", false, false, false, true, false, rr)
              dxDrawText("Jelenleg: " .. roomQueue[room][id][4] .. dur, x, y, x + 1024, y + h, tocolor(255, 255, 255), fontScale2 * 1.1, font2, "center", "center", false, false, false, true, false, rr)
              dxDrawLine(x + 8 + 1, y + h * 1.125 + 1, x + 1024 - 16 + 1, y + h * 1.05 + 1, tocolor(0, 0, 0))
              dxDrawLine(x + 8, y + h * 1.125, x + 1024 - 16, y + h * 1.05, tocolor(255, 255, 255))
              y = y + h * 1.1
            else
              if current.yearday == time.yearday then
                date = "Ma " .. string.format("%02d:%02d", time.hour, time.minute)
              else
                if time.yearday == current.yearday + 1 then
                  date = "Holnap"
                elseif time.weekday == 1 then
                  date = "Hétfő"
                elseif time.weekday == 2 then
                  date = "Kedd"
                elseif time.weekday == 3 then
                  date = "Szerda"
                elseif time.weekday == 4 then
                  date = "Csütörtök"
                elseif time.weekday == 5 then
                  date = "Péntek"
                elseif time.weekday == 6 then
                  date = "Szombat"
                elseif time.weekday == 0 then
                  date = "Vasárnap"
                end
                date = date .. string.format(" (%02d. %02d.) %02d:%02d", time.month + 1, time.monthday, time.hour, time.minute)
              end
              date = date .. " | "
              dxDrawText(date .. roomQueue[room][id][4] .. dur, x + 8 + 1, y + 1, 1, y + h + 1, tocolor(0, 0, 0), fontScale2, font2, "left", "center", false, false, false, true, false, rr)
              dxDrawText(date .. roomQueue[room][id][4] .. dur, x + 8, y, 0, y + h, tocolor(255, 255, 255), fontScale2, font2, "left", "center", false, false, false, true, false, rr)
              y = y + h
            end
          end
        end
      end
      x = x + 1024
    end
    dxSetRenderTarget(outsideRT)
    dxDrawImage(0, 0, 512, 64, "files/table.png")
    local h = 32
    for room = 1, 2 do
      local text = false
      if roomDatas[room] and roomDatas[room][3] and roomDatas[room][5] then
        text = utf8.upper(room .. ". terem: " .. roomDatas[room][3])
      elseif roomQueue[room] then
        local first = false
        local id = 1
        for i = 1, #roomQueue[room] do
          if roomQueue[room][i] then
            local t = roomQueue[room][i][5] or roomQueue[room][i][1]
            if not first or first > t then
              first = t
              id = i
            end
          end
        end
        if roomQueue[room][id] then
          local time = getRealTime(roomQueue[room][id][5] or roomQueue[room][id][1])
          local date = ""
          if (not roomDatas[room] or roomDatas[room][1] ~= roomQueue[room][id][2]) and time.timestamp > current.timestamp then
            if current.year == time.year and current.month == time.month and current.monthday == time.monthday then
              date = string.format("%02d:%02d", time.hour, time.minute)
            else
              date = string.format("%02d. %02d. %02d:%02d", time.month + 1, time.monthday, time.hour, time.minute)
            end
            date = date .. " | "
          end
          text = utf8.upper(room .. ". terem: " .. date .. roomQueue[room][id][4])
        end
      end
      if text then
        if utf8.len(text) > 55 then
          text = utf8.sub(text, 1, 52) .. "..."
        end
        local y = h * (room - 1)
        local w = dxGetTextWidth(text, fontScale, font) * 1.15
        local x = 256 - w / 2
        for i = 1, utf8.len(text) do
          local c = utf8.sub(text, i, i)
          local w = dxGetTextWidth(c, fontScale, font) * 1.15
          local rx = math.random(-5, 5) / 10
          local ry = math.random(-5, 5) / 10
          local rr = math.random(-5, 5) / 10
          dxDrawText(c, x + rx, y + ry, x + rx + w, y + ry + h, tocolor(0, 0, 0), fontScale, font, "center", "center", false, false, false, true, false, rr)
          x = x + w
        end
      end
    end
    dxSetRenderTarget()
  end
end
addEventHandler("onClientRestore", getRootElement(), drawOutside)
local outsideCol = createColCuboid(1078.84448, -1561.90198, 10, 106.92005, 134.82813, 30)
addEventHandler("onClientColShapeHit", outsideCol, function(el, md)
  if el == localPlayer then
    createOutside()
  end
end)
addEventHandler("onClientColShapeLeave", outsideCol, function(el, md)
  if el == localPlayer then
    deleteOutside()
  end
end)
function cinemaPreRender()
  setTime(roomLights[currentCinema] and 0 or 12, 0)
  setWeather(0)
  if browser and rt then
    dxSetRenderTarget(rt)
    dxDrawImage(-3, -4, 16, 10, browser)
    dxSetRenderTarget()
    setBrowserVolume(browser, cinemaVolume)
  end
  if not isElementWithinColShape(localPlayer, rooms[currentCinema][7]) then
    deleteCinema()
  end
end
function deleteCinema()
  if currentCinema then
    sightexports.sWeather:resetWeather()
    currentCinema = false
    removeEventHandler("onClientPreRender", getRootElement(), cinemaPreRender)
    deleteElements()
  end
end
function deleteElements()
  if isElement(browser) then
    destroyElement(browser)
  end
  browser = false
  deleteSoundGui()
  if isElement(shader) then
    destroyElement(shader)
  end
  shader = false
  if isElement(shader2) then
    destroyElement(shader2)
  end
  shader2 = false
  if isElement(rt) then
    destroyElement(rt)
  end
  rt = false
end
function createElements()
  deleteElements()
  if not volumeState then
    outputChatBox("[color=sightred][SightMTA - Mozi]: #ffffffHangerőszabályzó: /mozihang", 255, 255, 255, true)
  else
    createSoundGui()
  end
  browser = createBrowser(2037, 825, false, true)
  shader = dxCreateShader("files/texturechanger.fx")
  shader2 = dxCreateShader("files/texturechanger.fx")
  rt = dxCreateRenderTarget(10, 2, false)
  if shader then
    dxSetShaderValue(shader, "gTexture", browser)
    engineApplyShaderToWorldTexture(shader, "canvas")
  end
  if shader2 then
    dxSetShaderValue(shader2, "gTexture", rt)
    engineApplyShaderToWorldTexture(shader2, "cinema_leds")
    engineApplyShaderToWorldTexture(shader2, "cinema_lens")
  end
end
function preRenderCinemaCheck()
  if not currentCinema then
    local dim = getElementDimension(localPlayer)
    local int = getElementInterior(localPlayer)
    for i = 1, #rooms do
      if isElementWithinColShape(localPlayer, rooms[i][7]) and dim == rooms[i][5] and int == rooms[i][4] then
        deleteCinema()
        currentCinema = i
        if roomDatas[currentCinema] then
          createElements()
        end
        addEventHandler("onClientPreRender", getRootElement(), cinemaPreRender)
        triggerServerEvent("checkCinemaTicket", localPlayer, i)
        break
      end
    end
  end
end
addEventHandler("onClientElementDimensionChange", localPlayer, preRenderCinemaCheck)
addEventHandler("onClientElementInteriorChange", localPlayer, preRenderCinemaCheck)
local screenX, screenY = guiGetScreenSize()
local soundWindow = false
function deleteSoundGui()
  if soundWindow then
    sightexports.sGui:deleteGuiElement(soundWindow)
    soundWindow = false
    if isElement(browser) then
      outputChatBox("[color=sightred][SightMTA - Mozi]: #ffffffHangerőszabályzó: /mozihang", 255, 255, 255, true)
    end
  end
end
addEvent("closeCinemaSoundGui", false)
addEventHandler("closeCinemaSoundGui", getRootElement(), deleteSoundGui)
addEvent("changeCinemaSound", false)
addEventHandler("changeCinemaSound", getRootElement(), function(el, sliderValue, final)
  cinemaVolume = sliderValue
end)
function createSoundGui()
  if not soundWindow then
    local titleBarHeight = sightexports.sGui:getTitleBarHeight()
    local panelWidth = 250
    local panelHeight = titleBarHeight + 15 + 16
    soundWindow = sightexports.sGui:createGuiElement("window", screenX / 2 - panelWidth / 2, screenY - panelHeight - 72, panelWidth, panelHeight)
    sightexports.sGui:setWindowTitle(soundWindow, "16/BebasNeueRegular.otf", "Mozi hangerő")
    sightexports.sGui:setWindowCloseButton(soundWindow, "closeCinemaSoundGui")
    local slider = sightexports.sGui:createGuiElement("slider", 8, titleBarHeight + 8, panelWidth - 16, 15, soundWindow)
    sightexports.sGui:setSliderChangeEvent(slider, "changeCinemaSound")
    sightexports.sGui:setSliderValue(slider, cinemaVolume)
  end
end
addCommandHandler("mozihang", function()
  if not soundWindow and isElement(browser) then
    createSoundGui()
  end
end)
addEventHandler("onClientResourceStart", resourceRoot, function()
  for i = 1, #rooms do
    triggerServerEvent("requestRoomData", localPlayer, i)
  end
end)
addEventHandler("onClientBrowserCreated", resourceRoot, function()
  if source == browser and roomDatas[currentCinema] then
    local secs = math.floor((getTickCount() - roomDatas[currentCinema][2]) / 1000)
    loadBrowserURL(browser, "https://www.youtube.com/embed/" .. roomDatas[currentCinema][1] .. "?autoplay=true&modestbranding=1&controls=0&showinfo=0&autohide=1&start=" .. secs)
  end
end)
addEvent("buyCinemaTicket", true)
addEventHandler("buyCinemaTicket", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  if buyButtons[el] then
    local dat = buyButtons[el]
    deleteTicketShop()
    local titleBarHeight = sightexports.sGui:getTitleBarHeight()
    local w = 300
    local h = titleBarHeight + 96 + 30 + 8 + 4
    ticketShopWindow = sightexports.sGui:createGuiElement("window", screenX / 2 - w / 2, screenY / 2 - h / 2, w, h)
    sightexports.sGui:setWindowTitle(ticketShopWindow, "16/BebasNeueRegular.otf", "SightMTA - Mozijegy vásárlás")
    sightexports.sGui:setWindowCloseButton(ticketShopWindow, "openCinemaTicketGui")
    buyingTicket = dat[1]
    y = titleBarHeight + 4
    local label = sightexports.sGui:createGuiElement("label", 4, y, w, 24, ticketShopWindow)
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    sightexports.sGui:setLabelText(label, "Film: ")
    sightexports.sGui:setLabelClip(label, true)
    sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
    local tw = sightexports.sGui:getLabelTextWidth(label)
    local label = sightexports.sGui:createGuiElement("label", 4 + tw, y, w - tw - 8, 24, ticketShopWindow)
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    sightexports.sGui:setLabelText(label, dat[3])
    sightexports.sGui:setLabelClip(label, true)
    sightexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
    y = y + 24
    local label = sightexports.sGui:createGuiElement("label", 4, y, w, 24, ticketShopWindow)
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    sightexports.sGui:setLabelText(label, "Vetítés: ")
    sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
    local label = sightexports.sGui:createGuiElement("label", 4 + sightexports.sGui:getLabelTextWidth(label), y, w, 24, ticketShopWindow)
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    sightexports.sGui:setLabelText(label, dat[2])
    sightexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
    y = y + 24
    local label = sightexports.sGui:createGuiElement("label", 4, y, w, 24, ticketShopWindow)
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    sightexports.sGui:setLabelText(label, "Film hossza: ")
    sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
    local label = sightexports.sGui:createGuiElement("label", 4 + sightexports.sGui:getLabelTextWidth(label), y, w, 24, ticketShopWindow)
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    sightexports.sGui:setLabelText(label, dat[4])
    sightexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
    y = y + 24
    local label = sightexports.sGui:createGuiElement("label", 4, y, w, 24, ticketShopWindow)
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    sightexports.sGui:setLabelText(label, "Jegyár: ")
    sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
    local label = sightexports.sGui:createGuiElement("label", 4 + sightexports.sGui:getLabelTextWidth(label), y, w, 24, ticketShopWindow)
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    sightexports.sGui:setLabelText(label, sightexports.sGui:thousandsStepper(ticketPrice) .. " $")
    sightexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
    y = y + 24 + 4
    local btn = sightexports.sGui:createGuiElement("button", 4, y, w - 8, 30, ticketShopWindow)
    sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
    sightexports.sGui:setGuiHover(btn, "gradient", {
      "sightgreen",
      "sightgreen-second"
    })
    sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
    sightexports.sGui:setButtonTextColor(btn, "#ffffff")
    sightexports.sGui:setButtonText(btn, "Vásárlás")
    sightexports.sGui:setClickEvent(btn, "finalBuyMovieTicket", false)
  end
end)
function deleteTicketShop()
  if ticketShopWindow then
    sightexports.sControls:toggleAllControls(true)
    sightexports.sGui:deleteGuiElement(ticketShopWindow)
  end
  ticketShopWindow = false
  buyingTicket = false
  buyButtons = {}
end
addEvent("closeCinemaTicketGui", true)
addEventHandler("closeCinemaTicketGui", getRootElement(), deleteTicketShop)
addEvent("finalBuyMovieTicket", true)
addEventHandler("finalBuyMovieTicket", getRootElement(), function()
  if buyingTicket then
    triggerServerEvent("tryToBuyCinemaTicket", localPlayer, buyingTicket[1], buyingTicket[2], buyingTicket[3])
    deleteTicketShop()
  end
end)
function createTicketShop()
  deleteTicketShop()
  local w = 800
  local h = 600
  sightexports.sControls:toggleAllControls(false)
  ticketShopWindow = sightexports.sGui:createGuiElement("window", screenX / 2 - w / 2, screenY / 2 - h / 2, w, h)
  sightexports.sGui:setWindowTitle(ticketShopWindow, "16/BebasNeueRegular.otf", "SightMTA - Mozijegy vásárlás")
  sightexports.sGui:setWindowCloseButton(ticketShopWindow, "closeCinemaTicketGui")
  local titleBarHeight = sightexports.sGui:getTitleBarHeight()
  local x = 0
  local current = getRealTime()
  local border = sightexports.sGui:createGuiElement("hr", x + w / 2 - 1, titleBarHeight + 32 + 4, 2, h - titleBarHeight - 12 - 32, ticketShopWindow)
  sightexports.sGui:setGuiHrColor(border, "sightgrey3", "sightgrey2")
  for room = 1, 2 do
    local label = sightexports.sGui:createGuiElement("label", x, titleBarHeight, w / 2, 32, ticketShopWindow)
    sightexports.sGui:setLabelAlignment(label, "center", "center")
    sightexports.sGui:setLabelText(label, room .. ". terem:")
    sightexports.sGui:setLabelClip(label, true)
    sightexports.sGui:setLabelFont(label, "12/Ubuntu-R.ttf")
    local c = 0
    local y = titleBarHeight + 32
    local h = (h - titleBarHeight - 8 - 32) / 10
    if roomDatas[room] and roomDatas[room][3] and roomDatas[room][5] then
      c = c + 1
      if 10 < c then
        break
      end
      local dur = ""
      if roomDatas[room][4] then
        local min = math.floor(roomDatas[room][4] / 60 + 0.5)
        local hour = math.floor(min / 60)
        min = min - 60 * hour
        dur = hour .. " óra " .. min .. " perc"
      end
      local label = sightexports.sGui:createGuiElement("label", x + 8, y, w / 2 - 32 - 12 - 8, h / 2, ticketShopWindow)
      sightexports.sGui:setLabelAlignment(label, "left", "center")
      sightexports.sGui:setLabelText(label, roomDatas[room][3])
      sightexports.sGui:setLabelClip(label, true)
      sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
      local label = sightexports.sGui:createGuiElement("label", x + 8, y + h / 2, w / 2 - 32 - 12 - 8, h / 2, ticketShopWindow)
      sightexports.sGui:setLabelAlignment(label, "left", "center")
      sightexports.sGui:setLabelText(label, "Jelenleg vetítés alatt")
      sightexports.sGui:setLabelClip(label, true)
      sightexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
      local label = sightexports.sGui:createGuiElement("label", x + 8, y + h / 2, w / 2 - 32 - 12 - 8, h / 2, ticketShopWindow)
      sightexports.sGui:setLabelAlignment(label, "right", "center")
      sightexports.sGui:setLabelText(label, dur)
      sightexports.sGui:setLabelClip(label, true)
      sightexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
      local border = sightexports.sGui:createGuiElement("hr", x + 8, y - 2, w / 2 - 16, 2, ticketShopWindow)
      sightexports.sGui:setGuiHrColor(border, "sightgrey3", "sightgrey2")
      local icon = sightexports.sGui:createGuiElement("image", x + w / 2 - 32 - 8, y + h / 2 - 16, 32, 32, ticketShopWindow)
      sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("shopping-cart", 32))
      sightexports.sGui:setGuiHoverable(icon, true)
      sightexports.sGui:setGuiHover(icon, "solid", "sightgreen")
      sightexports.sGui:setClickEvent(icon, "buyCinemaTicket")
      buyButtons[icon] = {
        {
          room,
          false,
          roomDatas[room][1]
        },
        "jelenleg",
        roomDatas[room][3],
        dur
      }
      minus = 1
      y = y + h
    end
    for id = 1, 10 do
      if roomQueue[room][id] and roomQueue[room][id] then
        c = c + 1
        if 10 < c then
          break
        end
        local time = getRealTime(roomQueue[room][id][5] or roomQueue[room][id][1])
        local date = ""
        if not roomDatas[room] or roomDatas[room][1] ~= roomQueue[room][id][2] then
          if current.timestamp >= time.timestamp then
            date = "Jelenleg vetítés alatt"
          elseif current.yearday == time.yearday then
            date = "Ma " .. string.format("%02d:%02d", time.hour, time.minute)
          else
            if time.yearday == current.yearday + 1 then
              date = "Holnap"
            elseif time.weekday == 1 then
              date = "Hétfő"
            elseif time.weekday == 2 then
              date = "Kedd"
            elseif time.weekday == 3 then
              date = "Szerda"
            elseif time.weekday == 4 then
              date = "Csütörtök"
            elseif time.weekday == 5 then
              date = "Péntek"
            elseif time.weekday == 6 then
              date = "Szombat"
            elseif time.weekday == 0 then
              date = "Vasárnap"
            end
            date = date .. string.format(" (%02d. %02d.) %02d:%02d", time.month + 1, time.monthday, time.hour, time.minute)
          end
          local dur = ""
          if roomQueue[room][id][3] then
            local min = math.floor(roomQueue[room][id][3] / 60 + 0.5)
            local hour = math.floor(min / 60)
            min = min - 60 * hour
            dur = hour .. " óra " .. min .. " perc"
          end
          local label = sightexports.sGui:createGuiElement("label", x + 8, y, w / 2 - 32 - 12 - 8, h / 2, ticketShopWindow)
          sightexports.sGui:setLabelAlignment(label, "left", "center")
          sightexports.sGui:setLabelText(label, roomQueue[room][id][4])
          sightexports.sGui:setLabelClip(label, true)
          sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
          local label = sightexports.sGui:createGuiElement("label", x + 8, y + h / 2, w / 2 - 32 - 12 - 8, h / 2, ticketShopWindow)
          sightexports.sGui:setLabelAlignment(label, "left", "center")
          sightexports.sGui:setLabelText(label, date)
          sightexports.sGui:setLabelClip(label, true)
          sightexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
          local label = sightexports.sGui:createGuiElement("label", x + 8, y + h / 2, w / 2 - 32 - 12 - 8, h / 2, ticketShopWindow)
          sightexports.sGui:setLabelAlignment(label, "right", "center")
          sightexports.sGui:setLabelText(label, dur)
          sightexports.sGui:setLabelClip(label, true)
          sightexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
          local border = sightexports.sGui:createGuiElement("hr", x + 8, y - 2, w / 2 - 16, 2, ticketShopWindow)
          sightexports.sGui:setGuiHrColor(border, "sightgrey3", "sightgrey2")
          local icon = sightexports.sGui:createGuiElement("image", x + w / 2 - 32 - 8, y + h / 2 - 16, 32, 32, ticketShopWindow)
          sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("shopping-cart", 32))
          sightexports.sGui:setGuiHoverable(icon, true)
          sightexports.sGui:setGuiHover(icon, "solid", "sightgreen")
          sightexports.sGui:setClickEvent(icon, "buyCinemaTicket")
          buyButtons[icon] = {
            {
              room,
              id,
              roomQueue[room][id][2]
            },
            current.timestamp >= time.timestamp and "jelenleg" or date,
            roomQueue[room][id][4],
            dur
          }
          y = y + h
        end
      end
    end
    x = x + w / 2
  end
end
addEvent("openCinemaTicketGui", true)
addEventHandler("openCinemaTicketGui", getRootElement(), createTicketShop)
local ticket = false
function deleteTicket()
  if ticket then
    sightexports.sGui:deleteGuiElement(ticket)
  end
  ticket = false
end
function showTicket(data, used)
  if ticket then
    deleteTicket()
  end
  local w = used and 408 or 512
  ticket = sightexports.sGui:createGuiElement("image", screenX / 2 - w / 2, screenY / 2 - 128, w, 256)
  sightexports.sGui:setImageFile(ticket, ":sCinema/files/ticket.dds")
  if used then
    sightexports.sGui:setImageUV(ticket, 0, 0, w, 256)
  end
  local label = sightexports.sGui:createGuiElement("label", 131, 122, 269, 20, ticket)
  sightexports.sGui:setLabelAlignment(label, "center", "center")
  local title = data.title
  if utf8.len(title) > 35 then
    title = utf8.sub(title, 1, 32) .. "..."
  end
  sightexports.sGui:setLabelText(label, title)
  sightexports.sGui:setLabelColor(label, "#333333")
  sightexports.sGui:setLabelClip(label, true)
  sightexports.sGui:setLabelFont(label, "12/IckyticketMono-nKpJ.ttf")
  local label = sightexports.sGui:createGuiElement("label", 168, 166, 32, 19, ticket)
  sightexports.sGui:setLabelAlignment(label, "center", "center")
  sightexports.sGui:setLabelText(label, data.room)
  sightexports.sGui:setLabelColor(label, "#333333")
  sightexports.sGui:setLabelClip(label, true)
  sightexports.sGui:setLabelFont(label, "12/IckyticketMono-nKpJ.ttf")
  local label = sightexports.sGui:createGuiElement("label", 240, 166, 34, 19, ticket)
  sightexports.sGui:setLabelAlignment(label, "center", "center")
  sightexports.sGui:setLabelText(label, data.seat)
  sightexports.sGui:setLabelColor(label, "#333333")
  sightexports.sGui:setLabelClip(label, true)
  sightexports.sGui:setLabelFont(label, "12/IckyticketMono-nKpJ.ttf")
  local time = getRealTime(data.start)
  local date = string.format("%02d/%02d %02d:%02d", time.month + 1, time.monthday, time.hour, time.minute)
  local label = sightexports.sGui:createGuiElement("label", 314, 166, 86, 19, ticket)
  sightexports.sGui:setLabelAlignment(label, "center", "center")
  sightexports.sGui:setLabelText(label, date)
  sightexports.sGui:setLabelColor(label, "#333333")
  sightexports.sGui:setLabelClip(label, true)
  sightexports.sGui:setLabelFont(label, "12/IckyticketMono-nKpJ.ttf")
  if not used then
    local time = getRealTime(data.valid)
    local date = string.format("%04d. %02d. %02d. %02d:%02d", time.year + 1900, time.month + 1, time.monthday, time.hour, time.minute)
    local label = sightexports.sGui:createGuiElement("label", 420, 44, 8, 170, ticket)
    sightexports.sGui:setLabelAlignment(label, "center", "center")
    sightexports.sGui:setLabelText(label, "Valid: " .. date)
    sightexports.sGui:setLabelColor(label, "#333333")
    sightexports.sGui:setLabelRotation(label, 270)
    sightexports.sGui:setLabelFont(label, "9/IckyticketMono-nKpJ.ttf")
  end
end
