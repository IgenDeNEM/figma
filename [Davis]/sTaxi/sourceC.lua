local sightexports = {
  sModloader = false,
  sGui = false,
  sGroups = false
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
sightlangStaticImageToc[5] = true
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
  if sightlangStaticImageUsed[5] then
    sightlangStaticImageUsed[5] = false
    sightlangStaticImageDel[5] = false
  elseif sightlangStaticImage[5] then
    if sightlangStaticImageDel[5] then
      if now >= sightlangStaticImageDel[5] then
        if isElement(sightlangStaticImage[5]) then
          destroyElement(sightlangStaticImage[5])
        end
        sightlangStaticImage[5] = nil
        sightlangStaticImageDel[5] = false
        sightlangStaticImageToc[5] = true
        return
      end
    else
      sightlangStaticImageDel[5] = now + 5000
    end
  else
    sightlangStaticImageToc[5] = true
  end
  if sightlangStaticImageToc[0] and sightlangStaticImageToc[1] and sightlangStaticImageToc[2] and sightlangStaticImageToc[3] and sightlangStaticImageToc[4] and sightlangStaticImageToc[5] then
    sightlangStatImgHand = false
    removeEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre)
  end
end
processsightlangStaticImage[0] = function()
  if not isElement(sightlangStaticImage[0]) then
    sightlangStaticImageToc[0] = false
    sightlangStaticImage[0] = dxCreateTexture("files/back.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[1] = function()
  if not isElement(sightlangStaticImage[1]) then
    sightlangStaticImageToc[1] = false
    sightlangStaticImage[1] = dxCreateTexture("files/btnon.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[2] = function()
  if not isElement(sightlangStaticImage[2]) then
    sightlangStaticImageToc[2] = false
    sightlangStaticImage[2] = dxCreateTexture("files/btnoff.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[3] = function()
  if not isElement(sightlangStaticImage[3]) then
    sightlangStaticImageToc[3] = false
    sightlangStaticImage[3] = dxCreateTexture("files/fore.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[4] = function()
  if not isElement(sightlangStaticImage[4]) then
    sightlangStaticImageToc[4] = false
    sightlangStaticImage[4] = dxCreateTexture("files/paper.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[5] = function()
  if not isElement(sightlangStaticImage[5]) then
    sightlangStaticImageToc[5] = false
    sightlangStaticImage[5] = dxCreateTexture("files/papgrad.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
local sightlangModloaderLoaded = function()
  loadModelIds()
end
addEventHandler("modloaderLoaded", getRootElement(), sightlangModloaderLoaded)
if getElementData(localPlayer, "loggedIn") or sightexports.sModloader and sightexports.sModloader:isModloaderLoaded() then
  addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangModloaderLoaded)
end
local sightlangCondHandlState1 = false
local function sightlangCondHandl1(cond, prio)
  cond = cond and true or false
  if cond ~= sightlangCondHandlState1 then
    sightlangCondHandlState1 = cond
    if cond then
      addEventHandler("onClientRender", getRootElement(), renderTaxiCheckout, true, prio)
    else
      removeEventHandler("onClientRender", getRootElement(), renderTaxiCheckout)
    end
  end
end
local sightlangCondHandlState0 = false
local function sightlangCondHandl0(cond, prio)
  cond = cond and true or false
  if cond ~= sightlangCondHandlState0 then
    sightlangCondHandlState0 = cond
    if cond then
      addEventHandler("onClientCursorMove", getRootElement(), taxiMeterCursorMove, true, prio)
    else
      removeEventHandler("onClientCursorMove", getRootElement(), taxiMeterCursorMove)
    end
  end
end
local screenX, screenY = guiGetScreenSize()
local currentTaxi = false
local currentTaxiController = false
local taxiOnModel = false
local taxiOffModel = false
local modelsLoaded = false
local taxiObjects = {}
local taxiLights = {}
function loadModelIds()
  modelsLoaded = true
  taxiOnModel = sightexports.sModloader:getModelId("taxilogo_on")
  taxiOffModel = sightexports.sModloader:getModelId("taxilogo_off")
  for k, v in pairs(taxiObjects) do
    if isElement(v) then
      destroyElement(v)
    end
    v = nil
  end
  taxiObjects = {}
  local vehicles = getElementsByType("vehicle", getRootElement(), true)
  for i = 1, #vehicles do
    local model = getElementModel(vehicles[i])
    if taxiOffsets[model] and getElementData(vehicles[i], "taxiLight") then
      createTaxiLights(vehicles[i], model)
    end
  end
  local veh = getPedOccupiedVehicle(localPlayer)
  if veh and taxiLights[veh] then
    initTaxiMeter(veh)
  end
end
function taxiStreamOut()
  taxiLights[source] = nil
  if isElement(taxiObjects[source]) then
    destroyElement(taxiObjects[source])
  end
  taxiObjects[source] = nil
end
addEventHandler("onClientVehicleStreamOut", getRootElement(), taxiStreamOut)
addEventHandler("onClientVehicleDestroy", getRootElement(), taxiStreamOut)
function vehicleDimensionChange()
  if taxiObjects[source] then
    setElementInterior(taxiObjects[source], getElementInterior(source))
    setElementDimension(taxiObjects[source], getElementDimension(source))
  end
end
addEventHandler("onClientElementDimensionChange", getRootElement(), vehicleDimensionChange)
addEventHandler("onClientElementInteriorChange", getRootElement(), vehicleDimensionChange)
function createTaxiLights(veh, vModel)
  taxiLights[veh] = true
  local model = not getElementData(veh, "taxiOccupied") and getElementData(veh, "vehicle.ignition")
  if isElement(taxiObjects[veh]) then
    refreshTaxiModel(veh, model)
  elseif modelsLoaded then
    vModel = vModel or getElementModel(veh)
    taxiObjects[veh] = createObject(model and taxiOnModel or taxiOffModel, 0, 0, 0)
    setElementInterior(taxiObjects[veh], getElementInterior(veh))
    setElementDimension(taxiObjects[veh], getElementDimension(veh))
    setElementCollisionsEnabled(taxiObjects[veh], false)
    attachElements(taxiObjects[veh], veh, taxiOffsets[vModel][1], taxiOffsets[vModel][2], taxiOffsets[vModel][3], taxiOffsets[vModel][4], taxiOffsets[vModel][5], taxiOffsets[vModel][6])
  end
end
function refreshTaxiModel(veh, model)
  if taxiObjects[veh] then
    setElementModel(taxiObjects[veh], model and taxiOnModel or taxiOffModel)
  end
end
addEventHandler("onClientVehicleDataChange", getRootElement(), function(data, old, new)
  if isElementStreamedIn(source) then
    if data == "taxiLight" then
      if new then
        createTaxiLights(source)
        if getPedOccupiedVehicle(localPlayer) == source then
          initTaxiMeter(source)
        end
      else
        taxiStreamOut()
      end
    elseif data == "taxiOccupied" then
      if taxiObjects[source] then
        refreshTaxiModel(source, not new and getElementData(source, "vehicle.ignition"))
      end
    elseif data == "vehicle.ignition" then
      if taxiObjects[source] then
        refreshTaxiModel(source, new and not getElementData(source, "taxiOccupied"))
      end
      if source == currentTaxi then
        currentTaxiIgnition = new
      end
    end
  end
end)
addEventHandler("onClientVehicleStreamIn", getRootElement(), function()
  local model = getElementModel(source)
  if taxiOffsets[model] and getElementData(source, "taxiLight") then
    createTaxiLights(source, model)
    if getPedOccupiedVehicle(localPlayer) == source then
      initTaxiMeter(source, true)
    end
  end
end)
function getVehicleSpeed(currentElement)
  if isElement(currentElement) then
    local x, y, z = getElementVelocity(currentElement)
    local speed = math.sqrt(x ^ 2 + y ^ 2 + z ^ 2)
    return speed * 180 * 1.1
  end
  return 0
end
local taxiX, taxiY = screenX / 2 - 270, math.floor(screenY * 0.8 - 84)
if fileExists("!taxipos.sight") then
  local file = fileOpen("!taxipos.sight")
  if file then
    local dat = fileRead(file, fileGetSize(file))
    dat = split(dat, ",")
    if tonumber(dat[1]) then
      taxiX = tonumber(dat[1])
    end
    taxiX = math.max(0, math.min(taxiX, screenX - 540))
    if tonumber(dat[2]) then
      taxiY = tonumber(dat[2])
    end
    taxiY = math.max(0, math.min(taxiY, screenY - 168))
    fileClose(file)
  end
end
local taxiFont, taxiPrinterFont
local taxiFare = false
local syncedTaxiFare = false
local taxiMinuteFare = false
local syncedTaxiMinuteFare = false
local syncedTaxiOccupants = 0
local currentTaxiOccupied = false
local currentTaxiTiming = false
local currentTaxiDistance = 0
local currentTaxiTime = 0
local syncedTaxiDistance = 0
local syncedTaxiTime = 0
local taxiPriceText = "0 $"
local processedTaxiPrice = 0
addEvent("taxiSyncOccupied", true)
addEventHandler("taxiSyncOccupied", getRootElement(), function(client, timing, dist, min, force)
  if currentTaxi == source then
    if dist and min then
      if client ~= localPlayer then
        if not currentTaxiOccupied then
          playSound("files/beep2.mp3")
        elseif currentTaxiTiming ~= timing then
          playSound("files/beep1.mp3")
        end
      end
      currentTaxiOccupied = true
      processedTaxiPrice = 0
      syncedTaxiDistance = dist
      syncedTaxiTime = min
      if client ~= localPlayer or force then
        currentTaxiTiming = timing
        currentTaxiDistance = dist
        currentTaxiTime = min
        refreshTaxiPrice()
      end
    elseif currentTaxiOccupied then
      if client ~= localPlayer then
        playSound("files/beep3.mp3")
      end
      currentTaxiOccupied = false
    end
  end
end)
addEvent("gotTaxiFares", true)
addEventHandler("gotTaxiFares", getRootElement(), function(fare, minFare)
  if currentTaxi == source then
    syncedTaxiFare = fare
    syncedTaxiMinuteFare = minFare
    taxiFare = fare
    taxiMinuteFare = minFare
  end
end)
function refreshTaxiPrice()
  local fare = syncedTaxiFare or 500
  local minFare = syncedTaxiMinuteFare or 50
  local tmp = math.min(95000, math.ceil((fare * currentTaxiDistance + minFare * currentTaxiTime / 60000) / 10) * 10)
  if tmp ~= processedTaxiPrice then
    processedTaxiPrice = tmp
    taxiPriceText = sightexports.sGui:thousandsStepper(processedTaxiPrice) .. " $"
  end
end
local taxiHover = false
local taxiMenu = false
local receiptStart = false
local receiptTimes = {
  389,
  801,
  1220,
  1609,
  2028,
  2836,
  3300,
  4468,
  4902
}
local receiptPayable = false
local receiptLabels = false
addEvent("syncTaxiReceipt", true)
addEventHandler("syncTaxiReceipt", getRootElement(), function(data, anim)
  if currentTaxi == source then
    if data then
      receiptStart = anim and getTickCount() or true
      if anim then
        playSound("files/receipt.mp3")
      end
      receiptPayable = false
      if data[1] == "receipt" then
        receiptPayable = true
        local time = getRealTime(data[3])
        local time2 = getRealTime(data[4])
        
        local min = math.floor(data[6] / 1000 / 60)
        local sec = math.floor(data[6] / 1000 - min * 60)


        receiptLabels = {
          {
            "-- NYUGTA --",
            10,
            0.65,
            "center"
          },
          {
            "Sofőr:",
            40,
            0.5,
            "left"
          },
          {
            data[2],
            55,
            0.5,
            "left"
          },
          {
            "Indulás - Érkezés:",
            75,
            0.5,
            "left"
          },
          {
            string.format("%04d. %02d. %02d. %02d:%02d:%02d", time.year + 1900, time.month + 1, time.monthday, time.hour, time.minute, time.second),
            90,
            0.45,
            "center"
          },
          {
            string.format("%04d. %02d. %02d. %02d:%02d:%02d", time2.year + 1900, time2.month + 1, time2.monthday, time2.hour, time2.minute, time2.second),
            105,
            0.45,
            "center"
          },
          {
            "Megtett km:",
            125,
            0.5,
            "left"
          },
          {
            math.floor(data[5] * 100 + 0.5) / 100,
            125,
            0.5,
            "right"
          },
          {
            "Időtartam:",
            145,
            0.5,
            "left"
          },
          {
            string.format("%02d:%02d", min, sec),
            145,
            0.5,
            "right"
          },
          {
            "Tarifa:",
            165,
            0.5,
            "left"
          },
          {
            sightexports.sGui:thousandsStepper(data[7] or 500) .. " $ / km",
            180,
            0.5,
            "left"
          },
          {
            sightexports.sGui:thousandsStepper(data[8] or 50) .. " $ / perc",
            195,
            0.5,
            "left"
          },
          {
            "FIZETENDŐ:",
            220,
            0.6,
            "right"
          },
          {
            sightexports.sGui:thousandsStepper(data[9]) .. " $",
            235,
            0.6,
            "right"
          },
          {
            "-- Nyugta " .. data[10] .. " --",
            265,
            0.4,
            "center"
          },
          {
            "-- SIGHT CITY TAXI --",
            280,
            0.4,
            "center"
          }
        }
      elseif data[1] == "checkout" then
        local time = data[4] and getRealTime(data[4])
        local time2 = getRealTime(data[5])
        local hour = math.floor(data[7] / 3600)
        local min = math.floor(data[7] / 60 - hour * 60)
        local sec = math.floor(data[7] - hour * 3600 - min * 60)
        receiptLabels = {
          {
            "-- KASSZAZÁRÁS --",
            10,
            0.55,
            "center"
          },
          {
            "Sofőr:",
            40,
            0.5,
            "left"
          },
          {
            data[2],
            55,
            0.5,
            "left"
          },
          {
            "Sofőr azonosító:",
            85,
            0.5,
            "left"
          },
          {
            data[3] .. " (kar. id.)",
            100,
            0.5,
            "left"
          },
          {
            "Elszámolt időszak:",
            130,
            0.5,
            "left"
          },
          {
            time and string.format("%04d. %02d. %02d. %02d:%02d:%02d", time.year + 1900, time.month + 1, time.monthday, time.hour, time.minute, time.second) or "----",
            145,
            0.45,
            "center"
          },
          {
            string.format("%04d. %02d. %02d. %02d:%02d:%02d", time2.year + 1900, time2.month + 1, time2.monthday, time2.hour, time2.minute, time2.second),
            160,
            0.45,
            "center"
          },
          {
            "Megtett km:",
            190,
            0.5,
            "left"
          },
          {
            math.floor(data[6] * 100 + 0.5) / 100,
            190,
            0.5,
            "right"
          },
          {
            "Időtartam:",
            210,
            0.5,
            "left"
          },
          {
            string.format("%02d:%02d:%02d", hour, min, sec),
            210,
            0.5,
            "right"
          },
          {
            "FORGALOM:",
            240,
            0.6,
            "right"
          },
          {
            sightexports.sGui:thousandsStepper(data[8]) .. " $",
            255,
            0.6,
            "right"
          },
          {
            "-- SIGHT CITY TAXI --",
            280,
            0.4,
            "center"
          }
        }
      else
        receiptLabels = {
          {
            "-- SIGHT CITY TAXI --",
            10,
            0.4,
            "center"
          }
        }
      end
    else
      if anim then
        playSound("files/paper.wav")
      end
      receiptLabels = false
      receiptStart = false
    end
  end
end)
function renderTaximeter()
  local cx, cy = getCursorPosition()
  if cx then
    cx, cy = cx * screenX, cy * screenY
  end
  local tmp = false
  local now = getTickCount()
  sightlangStaticImageUsed[0] = true
  if sightlangStaticImageToc[0] then
    processsightlangStaticImage[0]()
  end
  dxDrawImage(taxiX, taxiY, 540, 168, sightlangStaticImage[0])
  local isTaxiFont = isElement(taxiFont)
  local isTaxiPrinterFont = isElement(taxiPrinterFont)
  if currentTaxiIgnition and isTaxiFont and isTaxiPrinterFont then
    sightlangStaticImageUsed[1] = true
    if sightlangStaticImageToc[1] then
      processsightlangStaticImage[1]()
    end
    dxDrawImage(taxiX, taxiY, 540, 168, sightlangStaticImage[1])
    if currentTaxiController then
      if cx then
        local cx = cx - taxiX
        local cy = cy - taxiY
        if 115 <= cy and cy <= 133 then
          if 337 <= cx and cx <= 356 then
            tmp = "up"
          elseif 372 <= cx and cx <= 391 then
            tmp = "menu"
          elseif 398 <= cx and cx <= 417 then
            tmp = "enter"
          elseif 433 <= cx and cx <= 452 then
            tmp = "down"
          end
        end
      end
    elseif taxiMenu then
      taxiMenu = false
    end
    if taxiMenu then
      dxDrawText("Menü", taxiX + 30, taxiY + 22, taxiX + 215, 0, tocolor(240, 210, 0), 0.45, taxiFont, "center", "top")
      local y = taxiY + 22 + 25
      if currentTaxiOccupied then
        if taxiMenu == 1 then
          dxDrawText(">>", taxiX + 32, y - 2, 0, 0, tocolor(240, 210, 0), 0.45, taxiFont, "left", "top")
        end
        dxDrawText("Nyugta", taxiX + 30 + 20, y, 0, 0, tocolor(240, 210, 0), 0.45, taxiFont, "left", "top")
        dxDrawText(taxiPriceText, 0, y, taxiX + 215, 0, tocolor(240, 210, 0), 0.425, taxiFont, "right", "top")
        y = y + 20
        if taxiMenu == 2 then
          dxDrawText(">>", taxiX + 32, y - 2, 0, 0, tocolor(240, 210, 0), 0.45, taxiFont, "left", "top")
        end
        dxDrawText("Utazás törlése", taxiX + 30 + 20, y, 0, 0, tocolor(240, 210, 0), 0.45, taxiFont, "left", "top")
        y = y + 20
      else
        local fare = taxiFare or 500
        local minFare = taxiMinuteFare or 50
        if taxiMenu == 1 then
          dxDrawText(">>", taxiX + 32, y - 2, 0, 0, tocolor(240, 210, 0), 0.45, taxiFont, "left", "top")
        end
        dxDrawText("Tarifa (km)", taxiX + 30 + 20, y, 0, 0, tocolor(240, 210, 0), 0.45, taxiFont, "left", "top")
        dxDrawText(fare, 0, y, taxiX + 215, 0, tocolor(240, 210, 0), 0.425, taxiFont, "right", "top")
        y = y + 20
        if taxiMenu == 2 then
          dxDrawText(">>", taxiX + 32, y - 2, 0, 0, tocolor(240, 210, 0), 0.45, taxiFont, "left", "top")
        end
        dxDrawText("Tarifa (perc)", taxiX + 30 + 20, y, 0, 0, tocolor(240, 210, 0), 0.45, taxiFont, "left", "top")
        dxDrawText(minFare, 0, y, taxiX + 215, 0, tocolor(240, 210, 0), 0.425, taxiFont, "right", "top")
        y = y + 20
        if taxiMenu == 3 then
          dxDrawText(">>", taxiX + 32, y - 2, 0, 0, tocolor(240, 210, 0), 0.45, taxiFont, "left", "top")
        end
        dxDrawText("Kasszazárás", taxiX + 30 + 20, y, 0, 0, tocolor(240, 210, 0), 0.45, taxiFont, "left", "top")
        y = y + 20
      end
    else
      dxDrawText(currentTaxiOccupied and "FOGLALT" or "SZABAD", taxiX + 30, taxiY + 22, 0, 0, tocolor(240, 210, 0), 0.45, taxiFont, "left", "top")
      dxDrawText("TARIFA", 0, taxiY + 22, taxiX + 215, 0, tocolor(240, 210, 0), 0.45, taxiFont, "right", "top")
      if currentTaxiOccupied then
        local min = math.floor(currentTaxiTime / 1000 / 60)
        local sec = math.floor(currentTaxiTime / 1000 - min * 60)
        if currentTaxiTiming or now % 1200 >= 600 then
          dxDrawText(math.floor(currentTaxiDistance * 100 + 0.5) / 100 .. " KM\n" .. string.format("%02d:%02d", min, sec), taxiX + 30, taxiY + 42, 0, 0, tocolor(240, 210, 0), 0.425, taxiFont, "left", "top")
        end
      end
      local fare = syncedTaxiFare or 500
      local minFare = syncedTaxiMinuteFare or 50
      dxDrawText(fare .. " $ / km\n" .. minFare .. " $ / p.", 0, taxiY + 42, taxiX + 215, 0, tocolor(240, 210, 0), 0.425, taxiFont, "right", "top")
      dxDrawText("Viteldíj:", taxiX + 30, 0, 0, taxiY + 100, tocolor(240, 210, 0), 0.425, taxiFont, "left", "bottom")
      if currentTaxiOccupied then
        dxDrawText(taxiPriceText, 0, 0, taxiX + 215, taxiY + 123, tocolor(240, 210, 0), 0.75, taxiFont, "right", "bottom")
      else
        dxDrawText("---", 0, 0, taxiX + 215, taxiY + 123, tocolor(240, 210, 0), 0.75, taxiFont, "right", "bottom")
      end
    end
  else
    if not isTaxiFont or not isTaxiPrinterFont then
      while true do
        if not isTaxiFont then
          taxiFont = dxCreateFont("files/DePixelHalbfett.ttf", 25, false, "antialiased")
          break
        end
        if not isTaxiPrinterFont then
          taxiPrinterFont = dxCreateFont("files/ThermalPrinter.ttf", 18, false, "antialiased")
          break
        end
        break
      end
    end
    sightlangStaticImageUsed[2] = true
    if sightlangStaticImageToc[2] then
      processsightlangStaticImage[2]()
    end
    dxDrawImage(taxiX, taxiY, 540, 168, sightlangStaticImage[2])
  end
  sightlangStaticImageUsed[3] = true
  if sightlangStaticImageToc[3] then
    processsightlangStaticImage[3]()
  end
  dxDrawImage(taxiX, taxiY, 540, 168, sightlangStaticImage[3])
  if receiptLabels then
    local p = 1
    if receiptStart then
      if not tonumber(receiptStart) then
        if receiptPayable then
          if currentTaxiController then
            sightexports.sGui:showInfobox("i", "Kattints a nyugtára a fuvar törléséhez!")
          else
            sightexports.sGui:showInfobox("i", "Kattints a nyugtára a fuvar kifizetéséhez!")
          end
        else
          sightexports.sGui:showInfobox("i", "Kattints a nyugtára a letépéséhez!")
        end
        receiptStart = false
      else
        local d = now - receiptStart
        p = 0
        for i = 1, #receiptTimes do
          p = p + math.min(1, math.max(d - receiptTimes[i], 0) / 250) / #receiptTimes
        end
        if 1 <= p then
          p = 1
          receiptStart = false
          if receiptPayable then
            if currentTaxiController then
              sightexports.sGui:showInfobox("i", "Kattints a nyugtára a fuvar törléséhez!")
            else
              sightexports.sGui:showInfobox("i", "Kattints a nyugtára a fuvar kifizetéséhez!")
            end
          else
            sightexports.sGui:showInfobox("i", "Kattints a nyugtára a letépéséhez!")
          end
        end
      end
    elseif cx and cx >= taxiX + 394 - 89 and cy >= taxiY + 40 - 300 and cx <= taxiX + 394 + 89 and cy <= taxiY + 40 then
      tmp = "receipt"
    end
    local ps = 300 * p
    local y = taxiY + 40 - ps
    dxDrawRectangle(taxiX + 394 - 89, y, 178, ps, tocolor(255, 255, 255))
    sightlangStaticImageUsed[4] = true
    if sightlangStaticImageToc[4] then
      processsightlangStaticImage[4]()
    end
    dxDrawImageSection(taxiX + 394 - 89, y, 178, ps, 0, 0, 178, ps, sightlangStaticImage[4], 0, 0, 0, tocolor(255, 255, 255, 125))
    ps = math.min(ps, 90)
    sightlangStaticImageUsed[5] = true
    if sightlangStaticImageToc[5] then
      processsightlangStaticImage[5]()
    end
    dxDrawImageSection(taxiX + 394 - 89, taxiY + 40 - ps, 178, ps, 0, 90 - ps, 178, ps, sightlangStaticImage[5], 0, 0, 0, tocolor(255, 255, 255, 200))
    for i = 1, #receiptLabels do
      local y = y + receiptLabels[i][2]
      if y < taxiY + 40 then
        dxDrawText(receiptLabels[i][1], taxiX + 394 - 84, y, taxiX + 394 + 84, taxiY + 40, tocolor(0, 0, 0), receiptLabels[i][3], taxiPrinterFont, receiptLabels[i][4], "top", true)
      end
    end
  end
  if tmp ~= taxiHover then
    taxiHover = tmp
    sightexports.sGui:setCursorType(taxiHover and "link" or "normal")
  end
end
local lastClick = 0
local movingTaximeter = false
function taxiMeterCursorMove(rx, ry, cx, cy)
  if movingTaximeter then
    if isCursorShowing() then
      taxiX = math.max(0, math.min(screenX - 540, movingTaximeter[1] + cx - movingTaximeter[3]))
      taxiY = math.max(0, math.min(screenY - 168, movingTaximeter[2] + cy - movingTaximeter[4]))
    else
      if fileExists("!taxipos.sight") then
        fileDelete("!taxipos.sight")
      end
      if taxiX and taxiY then
        local file = fileCreate("!taxipos.sight")
        fileWrite(file, taxiX .. "," .. taxiY)
        fileClose(file)
      end
      movingTaximeter = false
      sightlangCondHandl0(false)
    end
  end
end
function clickTaximeter(btn, state, cx, cy)
  if not taxiHover then
    if state == "down" then
      if cx >= taxiX and cy >= taxiY and cx <= taxiX + 540 and cy <= taxiY + 168 then
        movingTaximeter = {
          taxiX,
          taxiY,
          cx,
          cy
        }
        sightlangCondHandl0(true)
      end
    elseif movingTaximeter then
      if fileExists("!taxipos.sight") then
        fileDelete("!taxipos.sight")
      end
      if taxiX and taxiY then
        local file = fileCreate("!taxipos.sight")
        fileWrite(file, taxiX .. "," .. taxiY)
        fileClose(file)
      end
      movingTaximeter = false
      sightlangCondHandl0(false)
    end
  elseif state == "down" then
    if receiptLabels then
      if taxiHover == "receipt" then
        if getTickCount() - lastClick < 500 then
          return
        end
        lastClick = getTickCount()
        triggerServerEvent("processTaxiReceipt", currentTaxi)
      end
    elseif currentTaxiController then
      if taxiMenu then
        if taxiHover == "menu" then
          local fare, minFare
          if taxiFare and syncedTaxiFare ~= taxiFare then
            fare = taxiFare
          end
          if taxiMinuteFare and syncedTaxiMinuteFare ~= taxiMinuteFare then
            minFare = taxiMinuteFare
          end
          if fare or minFare then
            taxiFare = syncedTaxiFare
            taxiMinuteFare = syncedTaxiMinuteFare
            triggerServerEvent("updateTaxiFares", currentTaxi, fare, minFare)
          end
          taxiMenu = false
          playSound("files/beep1.mp3")
        elseif taxiHover == "up" then
          if 1 < taxiMenu then
            taxiMenu = taxiMenu - 1
            playSound("files/beep1.mp3")
          end
        elseif taxiHover == "down" then
          if taxiMenu < (currentTaxiOccupied and 2 or 3) then
            taxiMenu = taxiMenu + 1
            playSound("files/beep1.mp3")
          end
        elseif taxiHover == "enter" then
          if currentTaxiOccupied then
            if taxiMenu == 1 then
              taxiMenu = false
              playSound("files/beep1.mp3")
              triggerServerEvent("printTaxiReceipt", currentTaxi)
            elseif taxiMenu == 2 then
              currentTaxiOccupied = false
              currentTaxiTiming = false
              triggerServerEvent("syncTaxiOccupied", currentTaxi)
              taxiMenu = false
              playSound("files/beep3.mp3")
            end
          elseif taxiMenu == 1 then
            taxiFare = (taxiFare or 500) + 100
            if 2000 < taxiFare then
              taxiFare = 500
            end
            playSound("files/beep1.mp3")
          elseif taxiMenu == 2 then
            taxiMinuteFare = (taxiMinuteFare or 50) + 10
            if 200 < taxiMinuteFare then
              taxiMinuteFare = 50
            end
            playSound("files/beep1.mp3")
          elseif taxiMenu == 3 then
            if getTickCount() - lastClick < 500 then
              return
            end
            lastClick = getTickCount()
            triggerServerEvent("printTaxiCheckout", currentTaxi)
          end
        end
      elseif taxiHover == "enter" then
        if getTickCount() - lastClick < 500 then
          return
        end
        lastClick = getTickCount()
        if not currentTaxiOccupied then
          if not sightexports.sGroups:getPlayerPermission("taximeter") then
            sightexports.sGui:showInfobox("e", "Ehhez nincs jogosultságod!")
            return
          end
          currentTaxiOccupied = true
          currentTaxiDistance = 0
          currentTaxiTime = 0
          playSound("files/beep2.mp3")
        else
          playSound("files/beep1.mp3")
        end
        syncedTaxiDistance = currentTaxiDistance
        syncedTaxiTime = currentTaxiTime
        currentTaxiTiming = not currentTaxiTiming
        processedTaxiPrice = 0
        triggerServerEvent("syncTaxiOccupied", currentTaxi, currentTaxiTiming, currentTaxiDistance, currentTaxiTime)
      elseif taxiHover == "menu" then
        if currentTaxiTiming then
          if getTickCount() - lastClick < 500 then
            return
          end
          playSound("files/beep1.mp3")
          lastClick = getTickCount()
          currentTaxiTiming = not currentTaxiTiming
          processedTaxiPrice = 0
          syncedTaxiDistance = currentTaxiDistance
          syncedTaxiTime = currentTaxiTime
          triggerServerEvent("syncTaxiOccupied", currentTaxi, currentTaxiTiming, currentTaxiDistance, currentTaxiTime)
        else
          taxiMenu = 1
          playSound("files/beep1.mp3")
        end
      end
    end
  end
end
function preRenderTaxiMeter(delta)
  if not taxiLights[currentTaxi] or getPedOccupiedVehicle(localPlayer) ~= currentTaxi or not isElement(currentTaxi) then
    currentTaxi = false
    removeEventHandler("onClientRender", getRootElement(), renderTaximeter)
    removeEventHandler("onClientClick", getRootElement(), clickTaximeter)
    removeEventHandler("onClientPreRender", getRootElement(), preRenderTaxiMeter)
    if isElement(taxiFont) then
      destroyElement(taxiFont)
    end
    taxiFont = nil
    return
  end
  currentTaxiController = getVehicleController(currentTaxi) == localPlayer
  if currentTaxiTiming then
    currentTaxiDistance = currentTaxiDistance + getVehicleSpeed(currentTaxi) * delta / 3600000
    currentTaxiTime = currentTaxiTime + delta
    if 2 < currentTaxiDistance - syncedTaxiDistance or 120000 < currentTaxiTime - syncedTaxiTime then
      syncedTaxiDistance = currentTaxiDistance
      syncedTaxiTime = currentTaxiTime
      triggerServerEvent("syncTaxiOccupied", currentTaxi, currentTaxiTiming, currentTaxiDistance, currentTaxiTime)
    end
    refreshTaxiPrice()
  end
  if currentTaxiController then
    local tmp = 0
    local occupants = getVehicleOccupants(currentTaxi)
    for i in pairs(occupants) do
      tmp = tmp + 1
    end
    if syncedTaxiOccupants ~= tmp then
      syncedTaxiOccupants = tmp
      if currentTaxiTiming then
        syncedTaxiDistance = currentTaxiDistance
        syncedTaxiTime = currentTaxiTime
        triggerServerEvent("syncTaxiOccupied", currentTaxi, currentTaxiTiming, currentTaxiDistance, currentTaxiTime)
      end
    end
  end
end
function initTaxiMeter(veh, doNotReset)
  if not (veh and taxiLights[veh]) or currentTaxi == veh then
    return
  end
  if not currentTaxi then
    addEventHandler("onClientRender", getRootElement(), renderTaximeter)
    addEventHandler("onClientClick", getRootElement(), clickTaximeter)
    addEventHandler("onClientPreRender", getRootElement(), preRenderTaxiMeter)
    if isElement(taxiFont) then
      destroyElement(taxiFont)
    end
    if isElement(taxiPrinterFont) then
      destroyElement(taxiPrinterFont)
    end
  end
  triggerServerEvent("requestTaxiFare", veh)
  currentTaxi = veh
  currentTaxiIgnition = getElementData(currentTaxi, "vehicle.ignition")
  processedTaxiFare = 0
  if not doNotReset then
    currentTaxiOccupied = false
    currentTaxiTiming = false
    currentTaxiDistance = 0
    currentTaxiTime = 0
    syncedTaxiDistance = 0
    syncedTaxiTime = 0
    receiptLabels = false
    receiptStart = false
  end
  if getVehicleController(currentTaxi) == localPlayer then
    currentTaxiController = true
    if not doNotReset then
      triggerServerEvent("syncTaxiOccupied", currentTaxi)
    end
  else
    currentTaxiController = false
  end
  refreshTaxiPrice()
  syncedTaxiOccupants = 0
  local occupants = getVehicleOccupants(currentTaxi)
  for i in pairs(occupants) do
    syncedTaxiOccupants = syncedTaxiOccupants + 1
  end
end
addEventHandler("onClientPlayerVehicleEnter", localPlayer, function(veh)
  initTaxiMeter(veh)
end)
local checkoutFont = false
local checkoutLabels = false
local checkoutFont = false
function setTaxiCheckoutData(money, data)
  if isElement(checkoutFont) then
    destroyElement(checkoutFont)
  end
  if money and data then
    local time = data[3] and getRealTime(data[3])
    local time2 = getRealTime(data[4])
    local hour = math.floor(data[6] / 3600)
    local min = math.floor(data[6] / 60 - hour * 60)
    local sec = math.floor(data[6] - hour * 3600 - min * 60)
    checkoutLabels = {
      {
        "-- KASSZAZÁRÁS --",
        10,
        0.55,
        "center"
      },
      {
        "Sofőr:",
        40,
        0.5,
        "left"
      },
      {
        data[1],
        55,
        0.5,
        "left"
      },
      {
        "Sofőr azonosító:",
        85,
        0.5,
        "left"
      },
      {
        data[2] .. " (kar. id.)",
        100,
        0.5,
        "left"
      },
      {
        "Elszámolt időszak:",
        130,
        0.5,
        "left"
      },
      {
        time and string.format("%04d. %02d. %02d. %02d:%02d:%02d", time.year + 1900, time.month + 1, time.monthday, time.hour, time.minute, time.second) or "----",
        145,
        0.45,
        "center"
      },
      {
        string.format("%04d. %02d. %02d. %02d:%02d:%02d", time2.year + 1900, time2.month + 1, time2.monthday, time2.hour, time2.minute, time2.second),
        160,
        0.45,
        "center"
      },
      {
        "Megtett km:",
        190,
        0.5,
        "left"
      },
      {
        math.floor(data[5] * 100 + 0.5) / 100,
        190,
        0.5,
        "right"
      },
      {
        "Időtartam:",
        210,
        0.5,
        "left"
      },
      {
        string.format("%02d:%02d:%02d", hour, min, sec),
        210,
        0.5,
        "right"
      },
      {
        "FORGALOM:",
        240,
        0.6,
        "right"
      },
      {
        sightexports.sGui:thousandsStepper(money) .. " $",
        255,
        0.6,
        "right"
      },
      {
        "-- SIGHT CITY TAXI --",
        280,
        0.4,
        "center"
      }
    }
    sightlangCondHandl1(true)
  else
    checkoutLabels = false
    sightlangCondHandl1(false)
  end
end
function renderTaxiCheckout()
  local ps = 300
  local x = screenX / 2
  local y = screenY / 2 - ps / 2
  dxDrawRectangle(x - 89, y, 178, ps, tocolor(255, 255, 255))
  sightlangStaticImageUsed[4] = true
  if sightlangStaticImageToc[4] then
    processsightlangStaticImage[4]()
  end
  dxDrawImageSection(x - 89, y, 178, ps, 0, 0, 178, ps, sightlangStaticImage[4], 0, 0, 0, tocolor(255, 255, 255, 125))
  local font = taxiPrinterFont
  if not isElement(font) then
    if not isElement(checkoutFont) then
      if isElement(checkoutFont) then
        destroyElement(checkoutFont)
      end
      checkoutFont = dxCreateFont("files/ThermalPrinter.ttf", 18, false, "antialiased")
    end
    font = checkoutFont
  end
  for i = 1, #checkoutLabels do
    local y = y + checkoutLabels[i][2]
    dxDrawText(checkoutLabels[i][1], x - 84, y, x + 84, 0, tocolor(0, 0, 0), checkoutLabels[i][3], font, checkoutLabels[i][4], "top")
  end
end
