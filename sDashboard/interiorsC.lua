local sightexports = {
  sGui = false,
  sInteriors = false,
  sFarm = false,
  sPaintshop = false,
  sMining = false
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
local rtg = false
local sx, sy = 0, 0
local inside = false
local maxIntiOffset = 0
local intiOffset = 0
local selectedInterior = 1
local buttons = {}
addEvent("selectInteriorClick", true)
addEventHandler("selectInteriorClick", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  if buttons[el] then
    selectedInterior = buttons[el]
    drawInteriors()
  end
end)
function interiorsScrollKey(key, por)
  if interiorMenuDrawn and 0 < maxIntiOffset then
    if key == "mouse_wheel_up" then
      if 0 < intiOffset then
        intiOffset = intiOffset - 1
        drawInteriorsSideMenu()
      end
    elseif key == "mouse_wheel_down" and intiOffset < maxIntiOffset then
      intiOffset = intiOffset + 1
      drawInteriorsSideMenu()
    end
  end
end
local sideMenu = {}
local sh = false
local scrollbar = false
local menuW = false
function drawInteriorsSideMenu()
  if #interiorRenderList > 10 then
    local sw = menuW - dashboardPadding[3] - 2
    sightexports.sGui:setGuiPosition(scrollbar, sw + 1, 1 + sh * intiOffset)
  end
  for i = 1, 10 do
    if interiorRenderList[i + intiOffset] then
      if selectedInterior == i + intiOffset then
        sightexports.sGui:setGuiBackground(sideMenu[i][1], "solid", "sightgreen")
        sightexports.sGui:setGuiHoverable(sideMenu[i][1], false)
        sightexports.sGui:setClickEvent(sideMenu[i][1], false)
      else
        sightexports.sGui:setGuiBackground(sideMenu[i][1], "solid", "sightgrey1")
        sightexports.sGui:setGuiHoverable(sideMenu[i][1], true)
        sightexports.sGui:setClickEvent(sideMenu[i][1], "selectInteriorClick")
      end
      if interiorRenderList[i + intiOffset].theType == "interior" then
        sightexports.sGui:setLabelText(sideMenu[i][2], interiorRenderList[i + intiOffset].data.name)
        sightexports.sGui:setLabelText(sideMenu[i][3], "#" .. interiorRenderList[i + intiOffset].data.interiorId)
        buttons[sideMenu[i][1]] = i + intiOffset
        sightexports.sGui:setLabelText(sideMenu[i][4], sightexports.sInteriors:getInteriorTypeName(interiorRenderList[i + intiOffset].data.type, selectedInterior == i + intiOffset))
      elseif interiorRenderList[i + intiOffset].theType == "farm" then
        sightexports.sGui:setLabelText(sideMenu[i][2], interiorRenderList[i + intiOffset].data.name)
        sightexports.sGui:setLabelText(sideMenu[i][3], "#" .. interiorRenderList[i + intiOffset].data.id)
        buttons[sideMenu[i][1]] = i + intiOffset
        if selectedInterior == i + intiOffset then
          sightexports.sGui:setLabelText(sideMenu[i][4], "Farm")
        else
          sightexports.sGui:setLabelText(sideMenu[i][4], "[color=sightyellow]Farm")
        end
      elseif interiorRenderList[i + intiOffset].theType == "otherRentable" then
        sightexports.sGui:setLabelText(sideMenu[i][2], interiorRenderList[i + intiOffset].data.name)
        sightexports.sGui:setLabelText(sideMenu[i][3], "#" .. interiorRenderList[i + intiOffset].data.id)
        buttons[sideMenu[i][1]] = i + intiOffset
        local intType = interiorRenderList[i + intiOffset].data.type
        local intText = "Bérelhető garázs"
        if intType then
          if intType == "workshop" then
            intText = "Fényezőműhely"
          end
        end
        local typeText = intText
        if selectedInterior == i + intiOffset then
          sightexports.sGui:setLabelText(sideMenu[i][4], typeText)
        else
          sightexports.sGui:setLabelText(sideMenu[i][4], "[color=sightpurple]" .. typeText)
        end
      elseif interiorRenderList[i + intiOffset].theType == "mine" then
        sightexports.sGui:setLabelText(sideMenu[i][2], interiorRenderList[i + intiOffset].data.name)
        sightexports.sGui:setLabelText(sideMenu[i][3], "#" .. interiorRenderList[i + intiOffset].data.id)
        buttons[sideMenu[i][1]] = i + intiOffset
        local intType = interiorRenderList[i + intiOffset].data.type
        local intText = "Bánya"
        local typeText = intText
        if selectedInterior == i + intiOffset then
          sightexports.sGui:setLabelText(sideMenu[i][4], typeText)
        else
          sightexports.sGui:setLabelText(sideMenu[i][4], "[color=sightyellow]" .. typeText)
        end
      end
    elseif sideMenu[i] then
      sightexports.sGui:setGuiBackground(sideMenu[i][1], "solid", "sightgrey1")
      sightexports.sGui:setGuiHoverable(sideMenu[i][1], false)
      sightexports.sGui:setClickEvent(sideMenu[i][1], false)
    end
  end
end
function drawInteriors()
  if buyingRect then
    sightexports.sGui:deleteGuiElement(buyingRect)
  end
  buyingRect = false
  if buyingWindow then
    sightexports.sGui:deleteGuiElement(buyingWindow)
    sightexports.sGui:lockHover(rtg, false)
    sightexports.sGui:lockHover(closeButton, false)
    sightexports.sGui:lockHover(helpIcon, false)
  end
  buyingWindow = false
  buyingInteriorSlot = false
  menuW = math.floor(sx * 0.27)
  local h = (sy - 32) / 10
  if inside then
    sightexports.sGui:deleteGuiElement(inside)
  end
  inside = sightexports.sGui:createGuiElement("null", 0, 0, sx, sy, rtg)
  local rect = sightexports.sGui:createGuiElement("rectangle", menuW, 0, sx - menuW, sy, inside)
  sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey2")
  local rect = sightexports.sGui:createGuiElement("rectangle", 0, sy - 32, menuW, 32, inside)
  sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey3")
  maxIntiOffset = 0
  if 10 < #interiorRenderList then
    maxIntiOffset = #interiorRenderList - 10
    menuW = menuW - dashboardPadding[3] - 2
    local rect = sightexports.sGui:createGuiElement("rectangle", menuW, 0, dashboardPadding[3] + 2, sy - 32, inside)
    sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey3")
    sh = (sy - 32) / (#interiorRenderList - 10 + 1)
    scrollbar = sightexports.sGui:createGuiElement("rectangle", menuW + 1, 1 + sh * intiOffset, dashboardPadding[3], sh - 2, inside)
    sightexports.sGui:setGuiBackground(scrollbar, "solid", "sightgreen")
  end
  buttons = {}
  for i = 1, 10 do
    if interiorRenderList[i + intiOffset] then
      sideMenu[i] = {}
      sideMenu[i][1] = sightexports.sGui:createGuiElement("rectangle", 0, (i - 1) * h, menuW, h, inside)
      sightexports.sGui:setGuiHover(sideMenu[i][1], "gradient", {"sightgrey2", "sightgrey1"}, false, true)
      local w = 100
      sideMenu[i][2] = sightexports.sGui:createGuiElement("label", dashboardPadding[3] * 3, dashboardPadding[3] * 3, menuW - dashboardPadding[3] * 3, h, sideMenu[i][1])
      sightexports.sGui:setLabelFont(sideMenu[i][2], "19/BebasNeueRegular.otf")
      sightexports.sGui:setLabelAlignment(sideMenu[i][2], "left", "top")
      sightexports.sGui:setLabelClip(sideMenu[i][2], true)
      sightexports.sGui:setLabelText(sideMenu[i][2], "")
      local y = dashboardPadding[3] * 3 + sightexports.sGui:getLabelFontHeight(sideMenu[i][2])
      sideMenu[i][3] = sightexports.sGui:createGuiElement("label", dashboardPadding[3] * 3, y, menuW, h, sideMenu[i][1])
      sightexports.sGui:setLabelFont(sideMenu[i][3], "11/Ubuntu-R.ttf")
      sightexports.sGui:setLabelAlignment(sideMenu[i][3], "left", "top")
      sightexports.sGui:setLabelText(sideMenu[i][3], "")
      sideMenu[i][4] = sightexports.sGui:createGuiElement("label", menuW - dashboardPadding[3] * 3 - w, y, w, h, sideMenu[i][1])
      sightexports.sGui:setLabelFont(sideMenu[i][4], "11/Ubuntu-R.ttf")
      sightexports.sGui:setLabelAlignment(sideMenu[i][4], "right", "top")
      sightexports.sGui:setLabelText(sideMenu[i][4], "")
    end
  end
  local label = sightexports.sGui:createGuiElement("label", 0, sy - 32, menuW * 0.7, 32, inside)
  sightexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
  sightexports.sGui:setLabelAlignment(label, "center", "center")
  sightexports.sGui:setLabelText(label, "Interior slotok: " .. interiorNum .. "/" .. interiorLimit)
  local btn = sightexports.sGui:createGuiElement("button", menuW * 0.7 + dashboardPadding[3], sy - 32 + dashboardPadding[3], menuW * 0.3 - dashboardPadding[3] * 2, 32 - dashboardPadding[3] * 2, inside)
  sightexports.sGui:setGuiBackground(btn, "solid", "sightblue")
  sightexports.sGui:setGuiHover(btn, "gradient", {
    "sightblue",
    "sightblue-second"
  })
  sightexports.sGui:setButtonFont(btn, "13/BebasNeueBold.otf")
  sightexports.sGui:setButtonTextColor(btn, "#ffffff")
  sightexports.sGui:setButtonText(btn, "Slot vásárlás")
  sightexports.sGui:setClickEvent(btn, "buyInteriorSlot")
  if 10 < #interiorRenderList then
    menuW = menuW + dashboardPadding[3] + 2
  end
  drawInteriorsSideMenu()
  if interiorRenderList[selectedInterior] then
    if interiorRenderList[selectedInterior].theType == "interior" then
      local label = sightexports.sGui:createGuiElement("label", menuW + dashboardPadding[3] * 4, 0, sx - menuW - dashboardPadding[3] * 8, 64, inside)
      sightexports.sGui:setLabelFont(label, "24/BebasNeueRegular.otf")
      sightexports.sGui:setLabelAlignment(label, "left", "center")
      sightexports.sGui:setLabelColor(label, "sightgreen")
      sightexports.sGui:setLabelText(label, "[" .. interiorRenderList[selectedInterior].data.interiorId .. "] " .. interiorRenderList[selectedInterior].data.name)
      local label = sightexports.sGui:createGuiElement("label", menuW + dashboardPadding[3] * 4, 64, sx - menuW - dashboardPadding[3] * 8, 128, inside)
      sightexports.sGui:setLabelFont(label, "12/Ubuntu-L.ttf")
      sightexports.sGui:setLabelAlignment(label, "left", "center")
      local intiType = sightexports.sInteriors:getInteriorTypeName(interiorRenderList[selectedInterior].data.type)
      local locked = sightexports.sGui:getColorCodeHex("sightred") .. "nem"
      if interiorRenderList[selectedInterior].data.locked then
        locked = sightexports.sGui:getColorCodeHex("sightgreen") .. "igen"
      end
      local editable = sightexports.sGui:getColorCodeHex("sightred") .. "nem"
      if interiorRenderList[selectedInterior].data.editable ~= "N" then
        editable = sightexports.sGui:getColorCodeHex("sightgreen") .. interiorRenderList[selectedInterior].data.editable
      end
      local report = "[color=sightred]nem"
      if interiorRenderList[selectedInterior].data.reportTime >= getRealTime().timestamp then
        report = "[color=sightgreen]igen"
        if interiorRenderList[selectedInterior].data.report == 2 then
          report = "[color=sightgreen]örök"
        end
      end
      sightexports.sGui:setLabelText(label, "Típus: " .. intiType .. "#ffffff\nZárva: " .. locked .. "#ffffff\nSzerkeszthető: " .. editable .. [[

#FFFFFFBejelentve: ]] .. report)
      if interiorRenderList[selectedInterior].data.type ~= "rentable" then
        local btn = sightexports.sGui:createGuiElement("button", menuW + dashboardPadding[3] * 4, 192, 256, 30, inside)
        sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
        sightexports.sGui:setGuiHover(btn, "gradient", {
          "sightgreen",
          "sightgreen-second"
        })
        sightexports.sGui:setButtonFont(btn, "13/BebasNeueBold.otf")
        sightexports.sGui:setButtonTextColor(btn, "#ffffff")
        sightexports.sGui:setButtonText(btn, "Eladás")
        sightexports.sGui:setClickEvent(btn, "startInteriorSell")
      end
      local btn = sightexports.sGui:createGuiElement("button", menuW + dashboardPadding[3] * 4, 222 + dashboardPadding[3] * 4, 256, 30, inside)
      sightexports.sGui:setGuiBackground(btn, "solid", "sightblue")
      sightexports.sGui:setGuiHover(btn, "gradient", {
        "sightblue",
        "sightblue-second"
      })
      sightexports.sGui:setButtonFont(btn, "13/BebasNeueBold.otf")
      sightexports.sGui:setButtonTextColor(btn, "#ffffff")
      sightexports.sGui:setButtonText(btn, "Megjelölés térképen")
      sightexports.sGui:setClickEvent(btn, "markIntiOnMap")
      local px, py = menuW + dashboardPadding[3] * 4, 240 + dashboardPadding[3] * 8 + dashboardPadding[3] * 4
      local pw, ph = sx - menuW - dashboardPadding[3] * 8, sy - (240 + dashboardPadding[3] * 8 + dashboardPadding[3] * 8)
      local rx, ry = unpack(interiorRenderList[selectedInterior].data.outside)
      local map = sightexports.sGui:createGuiElement("radar", px, py, pw, ph, inside)
      sightexports.sGui:setRadarCoords(map, rx, ry, 128)
      local img = sightexports.sGui:createGuiElement("image", px, py, 32, 32, inside)
      sightexports.sGui:setImageDDS(img, ":sDashboard/files/mapcorner.dds")
      sightexports.sGui:setImageColor(img, "sightgrey2")
      local img = sightexports.sGui:createGuiElement("image", px + pw, py, -32, 32, inside)
      sightexports.sGui:setImageDDS(img, ":sDashboard/files/mapcorner.dds")
      sightexports.sGui:setImageColor(img, "sightgrey2")
      local img = sightexports.sGui:createGuiElement("image", px + 32, py, pw - 64, 32, inside)
      sightexports.sGui:setImageDDS(img, ":sDashboard/files/mapside.dds")
      sightexports.sGui:setImageColor(img, "sightgrey2")
      sightexports.sGui:setImageUV(img, 0, 0, pw - 64, 32)
      local img = sightexports.sGui:createGuiElement("image", px, py + ph, 32, -32, inside)
      sightexports.sGui:setImageDDS(img, ":sDashboard/files/mapcorner.dds")
      sightexports.sGui:setImageColor(img, "sightgrey2")
      local img = sightexports.sGui:createGuiElement("image", px + pw, py + ph, -32, -32, inside)
      sightexports.sGui:setImageDDS(img, ":sDashboard/files/mapcorner.dds")
      sightexports.sGui:setImageColor(img, "sightgrey2")
      local img = sightexports.sGui:createGuiElement("image", px + 32, py + ph, pw - 64, -32, inside)
      sightexports.sGui:setImageDDS(img, ":sDashboard/files/mapside.dds")
      sightexports.sGui:setImageColor(img, "sightgrey2")
      sightexports.sGui:setImageUV(img, 0, 0, pw - 64, 32)
      local img = sightexports.sGui:createGuiElement("image", px, py + 32, 32, ph - 64, inside)
      sightexports.sGui:setImageDDS(img, ":sDashboard/files/mapside2.dds")
      sightexports.sGui:setImageColor(img, "sightgrey2")
      sightexports.sGui:setImageUV(img, 0, 0, 32, ph - 64)
      local img = sightexports.sGui:createGuiElement("image", px + pw, py + 32, -32, ph - 64, inside)
      sightexports.sGui:setImageDDS(img, ":sDashboard/files/mapside2.dds")
      sightexports.sGui:setImageColor(img, "sightgrey2")
      sightexports.sGui:setImageUV(img, 0, 0, 32, ph - 64)
      local cross = sightexports.sGui:createGuiElement("image", px + pw / 2 - 16, py + ph / 2 - 16, 32, 32, inside)
      if interiorRenderList[selectedInterior].data.type == "house" then
        sightexports.sGui:setImageFile(cross, sightexports.sGui:getFaIconFilename("home", 32, "solid", false, sightexports.sGui:getColorCodeToColor("sightgrey2"), sightexports.sGui:getColorCodeToColor("sightblue")))
      elseif interiorRenderList[selectedInterior].data.type == "business" then
        sightexports.sGui:setImageFile(cross, sightexports.sGui:getFaIconFilename("dollar-sign", 32, "solid", false, sightexports.sGui:getColorCodeToColor("sightgrey2"), sightexports.sGui:getColorCodeToColor("sightgreen")))
      elseif interiorRenderList[selectedInterior].data.type == "garage" or interiorRenderList[selectedInterior].data.type == "garage2" then
        sightexports.sGui:setImageFile(cross, sightexports.sGui:getFaIconFilename("garage", 32, "solid", false, sightexports.sGui:getColorCodeToColor("sightgrey2"), sightexports.sGui:getColorCodeToColor("sightblue-second")))
      elseif interiorRenderList[selectedInterior].data.type == "rentable" then
        sightexports.sGui:setImageFile(cross, sightexports.sGui:getFaIconFilename("hotel", 32, "solid", false, sightexports.sGui:getColorCodeToColor("sightgrey2"), sightexports.sGui:getColorCodeToColor("sightpurple")))
      elseif interiorRenderList[selectedInterior].data.type == "lift" or interiorRenderList[selectedInterior].data.type == "stairs" then
        sightexports.sGui:setImageFile(cross, sightexports.sGui:getFaIconFilename("sort-circle-up", 32, "solid", false, sightexports.sGui:getColorCodeToColor("sightgrey2"), sightexports.sGui:getColorCodeToColor("hudwhite")))
      elseif interiorRenderList[selectedInterior].data.type == "door" then
        sightexports.sGui:setImageFile(cross, sightexports.sGui:getFaIconFilename("door-closed", 32, "solid", false, sightexports.sGui:getColorCodeToColor("sightgrey2"), sightexports.sGui:getColorCodeToColor("hudwhite")))
      else
        sightexports.sGui:setImageFile(cross, sightexports.sGui:getFaIconFilename("question", 32, "solid", false, sightexports.sGui:getColorCodeToColor("sightgrey2"), sightexports.sGui:getColorCodeToColor("sightyellow")))
      end
    elseif interiorRenderList[selectedInterior].theType == "farm" then
      local label = sightexports.sGui:createGuiElement("label", menuW + dashboardPadding[3] * 4, 0, sx - menuW - dashboardPadding[3] * 8, 64, inside)
      sightexports.sGui:setLabelFont(label, "24/BebasNeueRegular.otf")
      sightexports.sGui:setLabelAlignment(label, "left", "center")
      sightexports.sGui:setLabelColor(label, "sightgreen")
      sightexports.sGui:setLabelText(label, "[" .. interiorRenderList[selectedInterior].data.id .. "] " .. interiorRenderList[selectedInterior].data.name)
      local label = sightexports.sGui:createGuiElement("label", menuW + dashboardPadding[3] * 4, 64, sx - menuW - dashboardPadding[3] * 8, 128, inside)
      sightexports.sGui:setLabelFont(label, "12/Ubuntu-L.ttf")
      sightexports.sGui:setLabelAlignment(label, "left", "center")
      local lock = "[color=sightred]nem"
      if interiorRenderList[selectedInterior].data.locked then
        lock = "[color=sightgreen]igen"
      end
      local expire = interiorRenderList[selectedInterior].data.expire
      local typeStr = "[color=sightyellow]nincs kiválasztva"
      if interiorRenderList[selectedInterior].data.type == 1 then
        typeStr = "[color=sightgreen]növénytermesztés"
      elseif interiorRenderList[selectedInterior].data.type == 2 then
        typeStr = "[color=sightgreen]állattenyésztés"
      end
      sightexports.sGui:setLabelText(label, "Típus: " .. "[color=sightyellow]farm\n#ffffffFarm típusa: " .. typeStr .. "#ffffff\nZárva: " .. lock .. "#ffffff\nLejár: [color=sightblue]" .. expire)
      local btn = sightexports.sGui:createGuiElement("button", menuW + dashboardPadding[3] * 4, 222 + dashboardPadding[3] * 4, 256, 30, inside)
      sightexports.sGui:setGuiBackground(btn, "solid", "sightblue")
      sightexports.sGui:setGuiHover(btn, "gradient", {
        "sightblue",
        "sightblue-second"
      })
      sightexports.sGui:setButtonFont(btn, "13/BebasNeueBold.otf")
      sightexports.sGui:setButtonTextColor(btn, "#ffffff")
      sightexports.sGui:setButtonText(btn, "Megjelölés térképen")
      sightexports.sGui:setClickEvent(btn, "markIntiOnMap")
      local px, py = menuW + dashboardPadding[3] * 4, 240 + dashboardPadding[3] * 8 + dashboardPadding[3] * 4
      local pw, ph = sx - menuW - dashboardPadding[3] * 8, sy - (240 + dashboardPadding[3] * 8 + dashboardPadding[3] * 8)
      local rx, ry = unpack(interiorRenderList[selectedInterior].data.pos)
      local map = sightexports.sGui:createGuiElement("radar", px, py, pw, ph, inside)
      sightexports.sGui:setRadarCoords(map, rx, ry, 128)
      local img = sightexports.sGui:createGuiElement("image", px, py, 32, 32, inside)
      sightexports.sGui:setImageDDS(img, ":sDashboard/files/mapcorner.dds")
      sightexports.sGui:setImageColor(img, "sightgrey2")
      local img = sightexports.sGui:createGuiElement("image", px + pw, py, -32, 32, inside)
      sightexports.sGui:setImageDDS(img, ":sDashboard/files/mapcorner.dds")
      sightexports.sGui:setImageColor(img, "sightgrey2")
      local img = sightexports.sGui:createGuiElement("image", px + 32, py, pw - 64, 32, inside)
      sightexports.sGui:setImageDDS(img, ":sDashboard/files/mapside.dds")
      sightexports.sGui:setImageColor(img, "sightgrey2")
      sightexports.sGui:setImageUV(img, 0, 0, pw - 64, 32)
      local img = sightexports.sGui:createGuiElement("image", px, py + ph, 32, -32, inside)
      sightexports.sGui:setImageDDS(img, ":sDashboard/files/mapcorner.dds")
      sightexports.sGui:setImageColor(img, "sightgrey2")
      local img = sightexports.sGui:createGuiElement("image", px + pw, py + ph, -32, -32, inside)
      sightexports.sGui:setImageDDS(img, ":sDashboard/files/mapcorner.dds")
      sightexports.sGui:setImageColor(img, "sightgrey2")
      local img = sightexports.sGui:createGuiElement("image", px + 32, py + ph, pw - 64, -32, inside)
      sightexports.sGui:setImageDDS(img, ":sDashboard/files/mapside.dds")
      sightexports.sGui:setImageColor(img, "sightgrey2")
      sightexports.sGui:setImageUV(img, 0, 0, pw - 64, 32)
      local img = sightexports.sGui:createGuiElement("image", px, py + 32, 32, ph - 64, inside)
      sightexports.sGui:setImageDDS(img, ":sDashboard/files/mapside2.dds")
      sightexports.sGui:setImageColor(img, "sightgrey2")
      sightexports.sGui:setImageUV(img, 0, 0, 32, ph - 64)
      local img = sightexports.sGui:createGuiElement("image", px + pw, py + 32, -32, ph - 64, inside)
      sightexports.sGui:setImageDDS(img, ":sDashboard/files/mapside2.dds")
      sightexports.sGui:setImageColor(img, "sightgrey2")
      sightexports.sGui:setImageUV(img, 0, 0, 32, ph - 64)
      local cross = sightexports.sGui:createGuiElement("image", px + pw / 2 - 16, py + ph / 2 - 16, 32, 32, inside)
      sightexports.sGui:setImageFile(cross, sightexports.sGui:getFaIconFilename("farm", 32, "solid", false, sightexports.sGui:getColorCodeToColor("sightgrey2"), sightexports.sGui:getColorCodeToColor("sightyellow")))
    elseif interiorRenderList[selectedInterior].theType == "otherRentable" then
      local label = sightexports.sGui:createGuiElement("label", menuW + dashboardPadding[3] * 4, 0, sx - menuW - dashboardPadding[3] * 8, 64, inside)
      sightexports.sGui:setLabelFont(label, "24/BebasNeueRegular.otf")
      sightexports.sGui:setLabelAlignment(label, "left", "center")
      sightexports.sGui:setLabelColor(label, "sightgreen")
      sightexports.sGui:setLabelText(label, "[" .. interiorRenderList[selectedInterior].data.id .. "] " .. interiorRenderList[selectedInterior].data.name)
      local label = sightexports.sGui:createGuiElement("label", menuW + dashboardPadding[3] * 4, 64, sx - menuW - dashboardPadding[3] * 8, 128, inside)
      sightexports.sGui:setLabelFont(label, "12/Ubuntu-L.ttf")
      sightexports.sGui:setLabelAlignment(label, "left", "center")
      local lock = "[color=sightred]nem"
      if interiorRenderList[selectedInterior].data.locked then
        lock = "[color=sightgreen]igen"
      end
      local location = "[color=sightblue]" .. interiorRenderList[selectedInterior].data.locationName
      local lock = "[color=sightred]nem"
      if interiorRenderList[selectedInterior].data.locked then
        lock = "[color=sightgreen]igen"
      end
      local typeText = "Egyéb"
      if interiorRenderList[selectedInterior].data.type == "workshop" then
        typeText = "Fényezőműhely"
      elseif interiorRenderList[selectedInterior].data.type == "garage" then
        typeText = "Bérelhető garázs"
      end
      local time = getRealTime(interiorRenderList[selectedInterior].data.rentUntil)
      local expire = string.format("%04d. %02d. %02d. %02d:%02d:%02d", time.year + 1900, time.month + 1, time.monthday, time.hour, time.minute, time.second)
      sightexports.sGui:setLabelText(label, "Típus: [color=sightpurple]" .. typeText .. [[

#FFFFFFHely: ]] .. location .. "\n#FFFFFFZárva: " .. lock .. "\n#FFFFFFLejár: [color=sightblue]" .. expire)
      local btn = sightexports.sGui:createGuiElement("button", menuW + dashboardPadding[3] * 4, 222 + dashboardPadding[3] * 4, 256, 30, inside)
      sightexports.sGui:setGuiBackground(btn, "solid", "sightblue")
      sightexports.sGui:setGuiHover(btn, "gradient", {
        "sightblue",
        "sightblue-second"
      })
      sightexports.sGui:setButtonFont(btn, "13/BebasNeueBold.otf")
      sightexports.sGui:setButtonTextColor(btn, "#ffffff")
      sightexports.sGui:setButtonText(btn, "Megjelölés térképen")
      sightexports.sGui:setClickEvent(btn, "markIntiOnMap")
      local px, py = menuW + dashboardPadding[3] * 4, 240 + dashboardPadding[3] * 8 + dashboardPadding[3] * 4
      local pw, ph = sx - menuW - dashboardPadding[3] * 8, sy - (240 + dashboardPadding[3] * 8 + dashboardPadding[3] * 8)
      local rx, ry = unpack(interiorRenderList[selectedInterior].data.pos)
      local map = sightexports.sGui:createGuiElement("radar", px, py, pw, ph, inside)
      sightexports.sGui:setRadarCoords(map, rx, ry, 128)
      local img = sightexports.sGui:createGuiElement("image", px, py, 32, 32, inside)
      sightexports.sGui:setImageDDS(img, ":sDashboard/files/mapcorner.dds")
      sightexports.sGui:setImageColor(img, "sightgrey2")
      local img = sightexports.sGui:createGuiElement("image", px + pw, py, -32, 32, inside)
      sightexports.sGui:setImageDDS(img, ":sDashboard/files/mapcorner.dds")
      sightexports.sGui:setImageColor(img, "sightgrey2")
      local img = sightexports.sGui:createGuiElement("image", px + 32, py, pw - 64, 32, inside)
      sightexports.sGui:setImageDDS(img, ":sDashboard/files/mapside.dds")
      sightexports.sGui:setImageColor(img, "sightgrey2")
      sightexports.sGui:setImageUV(img, 0, 0, pw - 64, 32)
      local img = sightexports.sGui:createGuiElement("image", px, py + ph, 32, -32, inside)
      sightexports.sGui:setImageDDS(img, ":sDashboard/files/mapcorner.dds")
      sightexports.sGui:setImageColor(img, "sightgrey2")
      local img = sightexports.sGui:createGuiElement("image", px + pw, py + ph, -32, -32, inside)
      sightexports.sGui:setImageDDS(img, ":sDashboard/files/mapcorner.dds")
      sightexports.sGui:setImageColor(img, "sightgrey2")
      local img = sightexports.sGui:createGuiElement("image", px + 32, py + ph, pw - 64, -32, inside)
      sightexports.sGui:setImageDDS(img, ":sDashboard/files/mapside.dds")
      sightexports.sGui:setImageColor(img, "sightgrey2")
      sightexports.sGui:setImageUV(img, 0, 0, pw - 64, 32)
      local img = sightexports.sGui:createGuiElement("image", px, py + 32, 32, ph - 64, inside)
      sightexports.sGui:setImageDDS(img, ":sDashboard/files/mapside2.dds")
      sightexports.sGui:setImageColor(img, "sightgrey2")
      sightexports.sGui:setImageUV(img, 0, 0, 32, ph - 64)
      local img = sightexports.sGui:createGuiElement("image", px + pw, py + 32, -32, ph - 64, inside)
      sightexports.sGui:setImageDDS(img, ":sDashboard/files/mapside2.dds")
      sightexports.sGui:setImageColor(img, "sightgrey2")
      sightexports.sGui:setImageUV(img, 0, 0, 32, ph - 64)
      local cross = sightexports.sGui:createGuiElement("image", px + pw / 2 - 16, py + ph / 2 - 16, 32, 32, inside)
      sightexports.sGui:setImageFile(cross, sightexports.sGui:getFaIconFilename("industry-alt", 32, "solid", false, sightexports.sGui:getColorCodeToColor("sightgrey2"), sightexports.sGui:getColorCodeToColor("sightpurple")))
    elseif interiorRenderList[selectedInterior].theType == "mine" then
      local label = sightexports.sGui:createGuiElement("label", menuW + dashboardPadding[3] * 4, 0, sx - menuW - dashboardPadding[3] * 8, 64, inside)
      sightexports.sGui:setLabelFont(label, "24/BebasNeueRegular.otf")
      sightexports.sGui:setLabelAlignment(label, "left", "center")
      sightexports.sGui:setLabelColor(label, "sightgreen")
      sightexports.sGui:setLabelText(label, "[" .. interiorRenderList[selectedInterior].data.id .. "] " .. interiorRenderList[selectedInterior].data.name)
      local label = sightexports.sGui:createGuiElement("label", menuW + dashboardPadding[3] * 4, 64, sx - menuW - dashboardPadding[3] * 8, 128, inside)
      sightexports.sGui:setLabelFont(label, "12/Ubuntu-L.ttf")
      sightexports.sGui:setLabelAlignment(label, "left", "center")
      local lock = "[color=sightred]nem"
      if interiorRenderList[selectedInterior].data.locked then
        lock = "[color=sightgreen]igen"
      end
      local location = "[color=sightblue]" .. interiorRenderList[selectedInterior].data.locationName
      local lock = "[color=sightred]nem"
      if interiorRenderList[selectedInterior].data.locked then
        lock = "[color=sightgreen]igen"
      end
      local typeText = "Bánya"
      local time = getRealTime(interiorRenderList[selectedInterior].data.rentUntil)
      local expire = string.format("%04d. %02d. %02d. %02d:%02d:%02d", time.year + 1900, time.month + 1, time.monthday, time.hour, time.minute, time.second)
      sightexports.sGui:setLabelText(label, "Típus: [color=sightyellow]" .. typeText .. [[

#FFFFFFHely: ]] .. location .. "\n#FFFFFFZárva: " .. lock .. "\n#FFFFFFLejár: [color=sightblue]" .. expire)
      local btn = sightexports.sGui:createGuiElement("button", menuW + dashboardPadding[3] * 4, 222 + dashboardPadding[3] * 4, 256, 30, inside)
      sightexports.sGui:setGuiBackground(btn, "solid", "sightblue")
      sightexports.sGui:setGuiHover(btn, "gradient", {
        "sightblue",
        "sightblue-second"
      })
      sightexports.sGui:setButtonFont(btn, "13/BebasNeueBold.otf")
      sightexports.sGui:setButtonTextColor(btn, "#ffffff")
      sightexports.sGui:setButtonText(btn, "Megjelölés térképen")
      sightexports.sGui:setClickEvent(btn, "markIntiOnMap")
      local px, py = menuW + dashboardPadding[3] * 4, 240 + dashboardPadding[3] * 8 + dashboardPadding[3] * 4
      local pw, ph = sx - menuW - dashboardPadding[3] * 8, sy - (240 + dashboardPadding[3] * 8 + dashboardPadding[3] * 8)
      local rx, ry = unpack(interiorRenderList[selectedInterior].data.pos)
      local map = sightexports.sGui:createGuiElement("radar", px, py, pw, ph, inside)
      sightexports.sGui:setRadarCoords(map, rx, ry, 128)
      local img = sightexports.sGui:createGuiElement("image", px, py, 32, 32, inside)
      sightexports.sGui:setImageDDS(img, ":sDashboard/files/mapcorner.dds")
      sightexports.sGui:setImageColor(img, "sightgrey2")
      local img = sightexports.sGui:createGuiElement("image", px + pw, py, -32, 32, inside)
      sightexports.sGui:setImageDDS(img, ":sDashboard/files/mapcorner.dds")
      sightexports.sGui:setImageColor(img, "sightgrey2")
      local img = sightexports.sGui:createGuiElement("image", px + 32, py, pw - 64, 32, inside)
      sightexports.sGui:setImageDDS(img, ":sDashboard/files/mapside.dds")
      sightexports.sGui:setImageColor(img, "sightgrey2")
      sightexports.sGui:setImageUV(img, 0, 0, pw - 64, 32)
      local img = sightexports.sGui:createGuiElement("image", px, py + ph, 32, -32, inside)
      sightexports.sGui:setImageDDS(img, ":sDashboard/files/mapcorner.dds")
      sightexports.sGui:setImageColor(img, "sightgrey2")
      local img = sightexports.sGui:createGuiElement("image", px + pw, py + ph, -32, -32, inside)
      sightexports.sGui:setImageDDS(img, ":sDashboard/files/mapcorner.dds")
      sightexports.sGui:setImageColor(img, "sightgrey2")
      local img = sightexports.sGui:createGuiElement("image", px + 32, py + ph, pw - 64, -32, inside)
      sightexports.sGui:setImageDDS(img, ":sDashboard/files/mapside.dds")
      sightexports.sGui:setImageColor(img, "sightgrey2")
      sightexports.sGui:setImageUV(img, 0, 0, pw - 64, 32)
      local img = sightexports.sGui:createGuiElement("image", px, py + 32, 32, ph - 64, inside)
      sightexports.sGui:setImageDDS(img, ":sDashboard/files/mapside2.dds")
      sightexports.sGui:setImageColor(img, "sightgrey2")
      sightexports.sGui:setImageUV(img, 0, 0, 32, ph - 64)
      local img = sightexports.sGui:createGuiElement("image", px + pw, py + 32, -32, ph - 64, inside)
      sightexports.sGui:setImageDDS(img, ":sDashboard/files/mapside2.dds")
      sightexports.sGui:setImageColor(img, "sightgrey2")
      sightexports.sGui:setImageUV(img, 0, 0, 32, ph - 64)
      local cross = sightexports.sGui:createGuiElement("image", px + pw / 2 - 16, py + ph / 2 - 16, 32, 32, inside)
      sightexports.sGui:setImageFile(cross, sightexports.sGui:getFaIconFilename("mountains", 32, "solid", false, sightexports.sGui:getColorCodeToColor("sightgrey2"), sightexports.sGui:getColorCodeToColor("sightyellow")))
    end
  end
end
local buyingRect = false
local buyingWindow = false
buyingInteriorSlot = false
interiorMenuDrawn = false
local playerButtons = {}
local sellInput
sellingInteriorTo = false
function interiorsInsideDestroy()
  inside = false
  interiorMenuDrawn = false
  removeEventHandler("onClientKey", getRootElement(), interiorsScrollKey)
  if buyingRect then
    sightexports.sGui:deleteGuiElement(buyingRect)
  end
  buyingRect = false
  if buyingWindow then
    sightexports.sGui:deleteGuiElement(buyingWindow)
    sightexports.sGui:lockHover(closeButton, false)
    sightexports.sGui:lockHover(helpIcon, false)
  end
  buyingWindow = false
  buyingInteriorSlot = false
end
function interiorsInsideDraw(x, y, isx, isy, i, j, irtg)
  rtg = irtg
  sx, sy = isx, isy
  intiOffset = 0
  selectedInterior = 1
  interiorMenuDrawn = true
  addEventHandler("onClientKey", getRootElement(), interiorsScrollKey)
  drawInteriors()
end
local currentAmount = 0
local buyingLabel = 0
local sellingWindow = false
addEvent("endIntiSell", true)
addEventHandler("endIntiSell", getRootElement(), function()
  if sellingWindow then
    sightexports.sGui:deleteGuiElement(sellingWindow)
    sellingWindow = false
  end
end)
addEvent("changeInteriorSlotAmount", true)
addEventHandler("changeInteriorSlotAmount", getRootElement(), function(value)
  value = tonumber(value)
  if value then
    if 1 <= value then
      currentAmount = round2(value)
    else
      currentAmount = 1
    end
  else
    currentAmount = 1
  end
  sightexports.sGui:setLabelText(buyingLabel, "Prémium egyenleged: " .. sightexports.sGui:getColorCodeHex("sightblue") .. "" .. sightexports.sGui:thousandsStepper(ppBalance) .. " PP #ffffff\nFizetendő: " .. sightexports.sGui:getColorCodeHex("sightblue") .. "" .. sightexports.sGui:thousandsStepper(currentAmount * intiSlotPrice) .. " PP")
end)
addEvent("finalSellInterior", true)
addEventHandler("finalSellInterior", getRootElement(), function()
  local interior = interiorRenderList[selectedInterior]
  local interiorDatas = interior.data
  if sellingInteriorTo and isElement(sellingInteriorTo) and interior and interiorDatas.interiorId then
    local price = tonumber(sightexports.sGui:getInputValue(sellInput))
    if 500 <= price then
      triggerEvent("gotInteriorSellPaper", localPlayer, {
        "seller",
        false,
        getElementData(localPlayer, "visibleName"):gsub("_", " "),
        getElementData(sellingInteriorTo, "visibleName"):gsub("_", " "),
        sightexports.sInteriors:getInteriorName(interiorDatas.interiorId),
        interiorDatas.interiorId,
        sightexports.sInteriors:getInteriorTypeName(interiorDatas.type, true),
        price,
        getRealTime().timestamp,
        math.floor(price * 0.025),
        sellingInteriorTo,
        price
      })
      if buyingWindow then
        sightexports.sGui:deleteGuiElement(buyingWindow)
        sightexports.sGui:lockHover(rtg, false)
        sightexports.sGui:lockHover(closeButton, false)
        sightexports.sGui:lockHover(helpIcon, false)
      end
      buyingWindow = false
      return
    else
      sightexports.sGui:showInfobox("e", "A minimum eladási összeg 500$!")
      return
    end
  end
  buyingLabel = false
  sellingInteriorTo = false
  sellInput = false
  if buyingRect then
    sightexports.sGui:deleteGuiElement(buyingRect)
  end
  buyingRect = false
  if buyingWindow then
    sightexports.sGui:deleteGuiElement(buyingWindow)
    sightexports.sGui:lockHover(rtg, false)
    sightexports.sGui:lockHover(closeButton, false)
    sightexports.sGui:lockHover(helpIcon, false)
  end
  buyingWindow = false
  buyingInteriorSlot = false
end)
addEvent("selectIntiSellPlayer", true)
addEventHandler("selectIntiSellPlayer", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  if playerButtons[el] and isElement(playerButtons[el]) then
    sellingInteriorTo = playerButtons[el]
    local titleBarHeight = sightexports.sGui:getTitleBarHeight()
    local panelWidth = 300
    local panelHeight = titleBarHeight + 5 + 70 + 32 + 5 + 64
    if buyingWindow then
      sightexports.sGui:deleteGuiElement(buyingWindow)
    end
    buyingWindow = sightexports.sGui:createGuiElement("window", screenX / 2 - panelWidth / 2, screenY / 2 - panelHeight / 2, panelWidth, panelHeight)
    sightexports.sGui:setWindowTitle(buyingWindow, "16/BebasNeueRegular.otf", "Ingatlan eladás")
    local label = sightexports.sGui:createGuiElement("label", 5, titleBarHeight, panelWidth - 10, 64, buyingWindow)
    sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
    sightexports.sGui:setLabelAlignment(label, "center", "center")
    sightexports.sGui:setLabelText(label, "Ingatlan: " .. sightexports.sGui:getColorCodeHex("sightgreen") .. interiorRenderList[selectedInterior].data.name .. " [" .. interiorRenderList[selectedInterior].data.interiorId .. "]\n#ffffffVevő: " .. sightexports.sGui:getColorCodeHex("sightgreen") .. getElementData(sellingInteriorTo, "visibleName"):gsub("_", " "))
    sellInput = sightexports.sGui:createGuiElement("input", 5, titleBarHeight + 5 + 64, panelWidth - 10, 32, buyingWindow)
    sightexports.sGui:setInputFont(sellInput, "11/Ubuntu-R.ttf")
    sightexports.sGui:setInputIcon(sellInput, "coins")
    sightexports.sGui:setInputPlaceholder(sellInput, "Eladási ár")
    sightexports.sGui:setInputMaxLength(sellInput, 20)
    sightexports.sGui:setInputNumberOnly(sellInput, true)
    local btn = sightexports.sGui:createGuiElement("button", 5, panelHeight - 70, panelWidth - 10, 30, buyingWindow)
    sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
    sightexports.sGui:setGuiHover(btn, "gradient", {
      "sightgreen",
      "sightgreen-second"
    })
    sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
    sightexports.sGui:setButtonTextColor(btn, "#ffffff")
    sightexports.sGui:setButtonText(btn, "Eladás")
    sightexports.sGui:setClickEvent(btn, "finalSellInterior", false)
    local btn = sightexports.sGui:createGuiElement("button", 5, panelHeight - 35, panelWidth - 10, 30, buyingWindow)
    sightexports.sGui:setGuiBackground(btn, "solid", "sightred")
    sightexports.sGui:setGuiHover(btn, "gradient", {
      "sightred",
      "sightred-second"
    })
    sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
    sightexports.sGui:setButtonTextColor(btn, "#ffffff")
    sightexports.sGui:setButtonText(btn, "Mégsem")
    sightexports.sGui:setClickEvent(btn, "closeIntiSlotBuy", false)
  else
    buyingLabel = false
    sellingInteriorTo = false
    sellInput = false
    if buyingRect then
      sightexports.sGui:deleteGuiElement(buyingRect)
    end
    buyingRect = false
    if buyingWindow then
      sightexports.sGui:deleteGuiElement(buyingWindow)
      sightexports.sGui:lockHover(rtg, false)
      sightexports.sGui:lockHover(closeButton, false)
      sightexports.sGui:lockHover(helpIcon, false)
    end
    buyingWindow = false
    buyingInteriorSlot = false
  end
end)
addEvent("startInteriorSell", true)
addEventHandler("startInteriorSell", getRootElement(), function()
  if interiorRenderList[selectedInterior] then
    local data = interiorRenderList[selectedInterior].data
    local rx, ry, rz = sightexports.sInteriors:getInteriorOutsidePosition(data.interiorId)
    local px, py, pz = getElementPosition(localPlayer)
    local dist = getDistanceBetweenPoints3D(rx, ry, rz, px, py, pz)
    if dist < 15 then
      local playerList = {}
      local players = getElementsByType("player", getRootElement(), true)
      for i = 1, #players do
        if players[i] ~= localPlayer then
          local px2, py2, pz2 = getElementPosition(players[i])
          local dist = getDistanceBetweenPoints3D(px2, py2, pz2, px, py, pz)
          if dist < 5 then
            table.insert(playerList, players[i])
          end
        end
      end
      if #playerList < 1 then
        sightexports.sGui:showInfobox("e", "Nincs senki a közeledben!")
      else
        if buyingRect then
          sightexports.sGui:deleteGuiElement(buyingRect)
        end
        buyingRect = false
        if buyingWindow then
          sightexports.sGui:deleteGuiElement(buyingWindow)
          sightexports.sGui:lockHover(rtg, false)
          sightexports.sGui:lockHover(closeButton, false)
          sightexports.sGui:lockHover(helpIcon, false)
        end
        buyingWindow = false
        local titleBarHeight = sightexports.sGui:getTitleBarHeight()
        local panelWidth = 250
        local panelHeight = titleBarHeight + 5 + 30 + 5 + 35 * #playerList
        sightexports.sGui:lockHover(rtg, true)
        sightexports.sGui:lockHover(closeButton, true)
        sightexports.sGui:lockHover(helpIcon, true)
        buyingRect = sightexports.sGui:createGuiElement("rectangle", 0, 0, screenX, screenY)
        sightexports.sGui:setGuiBackground(buyingRect, "solid", {
          0,
          0,
          0,
          150
        })
        sightexports.sGui:setGuiHover(buyingRect, "none")
        sightexports.sGui:setGuiHoverable(buyingRect, true)
        sightexports.sGui:disableClickTrough(buyingRect, true)
        sightexports.sGui:disableLinkCursor(buyingRect, true)
        buyingWindow = sightexports.sGui:createGuiElement("window", screenX / 2 - panelWidth / 2, screenY / 2 - panelHeight / 2, panelWidth, panelHeight)
        sightexports.sGui:setWindowTitle(buyingWindow, "16/BebasNeueRegular.otf", "Válassz játékost!")
        local y = titleBarHeight + 5
        playerButtons = {}
        for i = 1, #playerList do
          local btn = sightexports.sGui:createGuiElement("button", 5, y, panelWidth - 10, 30, buyingWindow)
          sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
          sightexports.sGui:setGuiHover(btn, "gradient", {
            "sightgreen",
            "sightgreen-second"
          })
          sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
          sightexports.sGui:setButtonTextColor(btn, "#ffffff")
          sightexports.sGui:setButtonText(btn, getElementData(playerList[i], "visibleName"):gsub("_", " "))
          sightexports.sGui:setClickEvent(btn, "selectIntiSellPlayer", false)
          playerButtons[btn] = playerList[i]
          y = y + 35
        end
        local btn = sightexports.sGui:createGuiElement("button", 5, panelHeight - 35, panelWidth - 10, 30, buyingWindow)
        sightexports.sGui:setGuiBackground(btn, "solid", "sightred")
        sightexports.sGui:setGuiHover(btn, "gradient", {
          "sightred",
          "sightred-second"
        })
        sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
        sightexports.sGui:setButtonTextColor(btn, "#ffffff")
        sightexports.sGui:setButtonText(btn, "Mégsem")
        sightexports.sGui:setClickEvent(btn, "closeIntiSlotBuy", false)
      end
    else
      sightexports.sGui:showInfobox("e", "Túl messze vagy az adott interior bejáratától!")
    end
  end
end)
addEvent("markIntiOnMap", true)
addEventHandler("markIntiOnMap", getRootElement(), function()
  if interiorRenderList[selectedInterior] then
    if interiorRenderList[selectedInterior].theType == "interior" then
      sightexports.sInteriors:markInteriorOnMap(interiorRenderList[selectedInterior].data.interiorId)
    elseif interiorRenderList[selectedInterior].theType == "farm" then
      sightexports.sFarm:markFarm(interiorRenderList[selectedInterior].data.id)
    elseif interiorRenderList[selectedInterior].theType == "otherRentable" or interiorRenderList[selectedInterior].theType == "workshop" then
      sightexports.sPaintshop:markGarageDoor(interiorRenderList[selectedInterior].data.id)
    elseif interiorRenderList[selectedInterior].theType == "mine" then
      sightexports.sMining:markMine(interiorRenderList[selectedInterior].data.id)
    end
  end
end)
addEvent("closeIntiSlotBuy", true)
addEventHandler("closeIntiSlotBuy", getRootElement(), function()
  buyingLabel = false
  sellingInteriorTo = false
  sellInput = false
  if buyingRect then
    sightexports.sGui:deleteGuiElement(buyingRect)
  end
  buyingRect = false
  if buyingWindow then
    sightexports.sGui:deleteGuiElement(buyingWindow)
    sightexports.sGui:lockHover(rtg, false)
    sightexports.sGui:lockHover(closeButton, false)
    sightexports.sGui:lockHover(helpIcon, false)
  end
  buyingWindow = false
  buyingInteriorSlot = false
end)
addEvent("finalBuyIntiSlot", true)
addEventHandler("finalBuyIntiSlot", getRootElement(), function()
  if intiSlotPrice * currentAmount > ppBalance then
    sightexports.sGui:showInfobox("e", "Nincs elég PrémiumPontod!")
  else
    triggerServerEvent("buyInteriorSlot", localPlayer, currentAmount)
    buyingLabel = false
    sellingInteriorTo = false
    sellInput = false
    if buyingRect then
      sightexports.sGui:deleteGuiElement(buyingRect)
    end
    buyingRect = false
    if buyingWindow then
      sightexports.sGui:deleteGuiElement(buyingWindow)
      sightexports.sGui:lockHover(rtg, false)
      sightexports.sGui:lockHover(closeButton, false)
      sightexports.sGui:lockHover(helpIcon, false)
    end
    buyingWindow = false
    buyingInteriorSlot = false
  end
end)
addEvent("buyInteriorSlot", true)
addEventHandler("buyInteriorSlot", getRootElement(), function()
  buyingInteriorSlot = true
  local titleBarHeight = sightexports.sGui:getTitleBarHeight()
  local h = sightexports.sGui:getFontHeight("14/BebasNeueRegular.otf")
  currentAmount = 0
  local panelWidth = 300
  local panelHeight = titleBarHeight + 5 + h * 1.5 + h * 2 + 30 + 5 + 5 + 5 + 32 + 5
  sightexports.sGui:lockHover(rtg, true)
  sightexports.sGui:lockHover(closeButton, true)
  sightexports.sGui:lockHover(helpIcon, true)
  buyingRect = sightexports.sGui:createGuiElement("rectangle", 0, 0, screenX, screenY)
  sightexports.sGui:setGuiBackground(buyingRect, "solid", {
    0,
    0,
    0,
    150
  })
  sightexports.sGui:setGuiHover(buyingRect, "none")
  sightexports.sGui:setGuiHoverable(buyingRect, true)
  sightexports.sGui:disableClickTrough(buyingRect, true)
  sightexports.sGui:disableLinkCursor(buyingRect, true)
  buyingWindow = sightexports.sGui:createGuiElement("window", screenX / 2 - panelWidth / 2, screenY / 2 - panelHeight / 2, panelWidth, panelHeight)
  sightexports.sGui:setWindowTitle(buyingWindow, "16/BebasNeueRegular.otf", "Interior slot vásárlás")
  local y = titleBarHeight + 5
  local label = sightexports.sGui:createGuiElement("label", 5, y, panelWidth - 5, h * 1.5, buyingWindow)
  sightexports.sGui:setLabelFont(label, "14/BebasNeueRegular.otf")
  sightexports.sGui:setLabelAlignment(label, "center", "center")
  sightexports.sGui:setLabelText(label, intiSlotPrice .. " PP / interior slot")
  y = y + h * 1.5 + 5
  local input = sightexports.sGui:createGuiElement("input", 32, y, panelWidth - 64, 32, buyingWindow)
  sightexports.sGui:setInputFont(input, "11/Ubuntu-R.ttf")
  sightexports.sGui:setInputIcon(input, "boxes")
  sightexports.sGui:setInputPlaceholder(input, "Mennyiség")
  sightexports.sGui:setInputMaxLength(input, 5)
  sightexports.sGui:setInputNumberOnly(input, true)
  sightexports.sGui:setInputChangeEvent(input, "changeInteriorSlotAmount")
  y = y + 32 + 5
  buyingLabel = sightexports.sGui:createGuiElement("label", 5, y, panelWidth - 5, h * 2, buyingWindow)
  sightexports.sGui:setLabelFont(buyingLabel, "11/Ubuntu-R.ttf")
  sightexports.sGui:setLabelAlignment(buyingLabel, "center", "center")
  sightexports.sGui:setLabelText(buyingLabel, "Prémium egyenleged: " .. sightexports.sGui:getColorCodeHex("sightblue") .. "" .. sightexports.sGui:thousandsStepper(ppBalance) .. " PP #ffffff\nFizetendő: " .. sightexports.sGui:getColorCodeHex("sightblue") .. "" .. sightexports.sGui:thousandsStepper(currentAmount * intiSlotPrice) .. " PP")
  local btnW = (panelWidth - 15) / 2
  local btn = sightexports.sGui:createGuiElement("button", 5, panelHeight - 35, btnW, 30, buyingWindow)
  sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
  sightexports.sGui:setGuiHover(btn, "gradient", {
    "sightgreen",
    "sightgreen-second"
  })
  sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
  sightexports.sGui:setButtonTextColor(btn, "#ffffff")
  sightexports.sGui:setButtonText(btn, "Vásárlás")
  sightexports.sGui:setClickEvent(btn, "finalBuyIntiSlot", false)
  local btn = sightexports.sGui:createGuiElement("button", 10 + btnW, panelHeight - 35, btnW, 30, buyingWindow)
  sightexports.sGui:setGuiBackground(btn, "solid", "sightred")
  sightexports.sGui:setGuiHover(btn, "gradient", {
    "sightred",
    "sightred-second"
  })
  sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
  sightexports.sGui:setButtonTextColor(btn, "#ffffff")
  sightexports.sGui:setButtonText(btn, "Mégsem")
  sightexports.sGui:setClickEvent(btn, "closeIntiSlotBuy", false)
end)
