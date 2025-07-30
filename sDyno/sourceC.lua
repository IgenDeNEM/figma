local sightexports = {
  sControls = false,
  sSpeedo = false,
  sGui = false,
  sVehiclenames = false,
  sModloader = false,
  sMarkers = false
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
  if sightlangStaticImageToc[0] and sightlangStaticImageToc[1] and sightlangStaticImageToc[2] and sightlangStaticImageToc[3] then
    sightlangStatImgHand = false
    removeEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre)
  end
end
processsightlangStaticImage[0] = function()
  if not isElement(sightlangStaticImage[0]) then
    sightlangStaticImageToc[0] = false
    sightlangStaticImage[0] = dxCreateTexture("files/kruton.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[1] = function()
  if not isElement(sightlangStaticImage[1]) then
    sightlangStaticImageToc[1] = false
    sightlangStaticImage[1] = dxCreateTexture("files/screen.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[2] = function()
  if not isElement(sightlangStaticImage[2]) then
    sightlangStaticImageToc[2] = false
    sightlangStaticImage[2] = dxCreateTexture("files/dynologo.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[3] = function()
  if not isElement(sightlangStaticImage[3]) then
    sightlangStaticImageToc[3] = false
    sightlangStaticImage[3] = dxCreateTexture("files/dynologo2.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
local sightlangWaiterState0 = false
local function sightlangProcessResWaiters()
  if not sightlangWaiterState0 then
    local res0 = getResourceFromName("sMarkers")
    if res0 and getResourceState(res0) == "running" then
      markersReady()
      sightlangWaiterState0 = true
    end
  end
end
if triggerServerEvent then
  addEventHandler("onClientResourceStart", getRootElement(), sightlangProcessResWaiters)
end
if triggerClientEvent then
  addEventHandler("onResourceStart", getRootElement(), sightlangProcessResWaiters)
end
function getVehicleSpeed(currentElement, forceUnit)
  if isElement(currentElement) then
    local testUnit = forceUnit or unit
    local x, y, z = getElementVelocity(currentElement)
    local speed = math.sqrt(x ^ 2 + y ^ 2 + z ^ 2)
    if testUnit == "MPH" then
      speed = speed * 116.5 * 1.1
    else
      speed = speed * 180 * 1.1
    end
    return speed
  end
  return 0
end
local screenShader = false
local screenRT = false
local screenShader2 = false
local screenRT2 = false
local skidShader = false
local transTexture = false
local veh = false
local obj = false
local pad = false
local ventRot = 0
local vent1 = false
local vent2 = false
local fan1 = false
local fan2 = false
local rollers = {}
local rearCarrige = false
local dynoCreated = 0
local lastMaxSpeed = getTickCount()
local maxSpeed = 0
local lastMaxSpeedVal = 0
local lastMeasure = false
local started = false
local lastNull100 = false
local lastNull200 = false
local lastQuarter = false
local lastVmax = false
local null100 = false
local null200 = false
local quarter = false
local vmax = false
local lastQuarterSpeed = false
local quarterSpeed = false
local vmaxReached = false
local distance = 0
local brake = false
local brakeStarted = false
local linesAcceleration = {}
local lastLinesAcceleration = {}
local screenX, screenY = guiGetScreenSize()
local dynoWindow = false
local titleBarHeight = false
local panelWidth = false
local panelHeight = false
local vehMake = false
local vehModel = false
local font = false
local fontScale = false
local font2 = false
local font2Scale = false
local exiting = false
local ped = false
function deleteDynoPad()
  if isElement(screenShader) then
    destroyElement(screenShader)
  end
  screenShader = nil
  if isElement(screenRT) then
    destroyElement(screenRT)
  end
  screenRT = nil
  if isElement(screenShader2) then
    destroyElement(screenShader2)
  end
  screenShader2 = nil
  if isElement(transTexture) then
    destroyElement(transTexture)
  end
  transTexture = nil
  if isElement(skidShader) then
    destroyElement(skidShader)
  end
  skidShader = nil
  if isElement(screenRT2) then
    destroyElement(screenRT2)
  end
  screenRT2 = nil
  if isElement(fan1) then
    destroyElement(fan1)
  end
  fan1 = nil
  if isElement(fan2) then
    destroyElement(fan2)
  end
  fan2 = nil
  if isElement(ped) then
    destroyElement(ped)
  end
  ped = nil
  if isElement(obj) then
    destroyElement(obj)
  end
  obj = nil
  if isElement(pad) then
    destroyElement(pad)
  end
  pad = nil
  if isElement(vent1) then
    destroyElement(vent1)
  end
  vent1 = nil
  if isElement(vent2) then
    destroyElement(vent2)
  end
  vent2 = nil
  if isElement(rollers[1]) then
    destroyElement(rollers[1])
  end
  rollers[1] = nil
  if isElement(rollers[2]) then
    destroyElement(rollers[2])
  end
  rollers[2] = nil
  if isElement(rollers[3]) then
    destroyElement(rollers[3])
  end
  rollers[3] = nil
  if isElement(rollers[4]) then
    destroyElement(rollers[4])
  end
  rollers[4] = nil
  if isElement(rearCarrige) then
    destroyElement(rearCarrige)
  end
  rearCarrige = nil
  lastMaxSpeed = getTickCount()
  maxSpeed = 0
  lastMaxSpeedVal = 0
  lastMeasure = false
  started = false
  lastNull100 = false
  lastNull200 = false
  lastQuarter = false
  lastVmax = false
  null100 = false
  null200 = false
  quarter = false
  vmax = false
  lastQuarterSpeed = false
  quarterSpeed = false
  vmaxReached = false
  distance = 0
  brake = false
  brakeStarted = false
  linesAcceleration = {}
  lastLinesAcceleration = {}
  if dynoCreated then
    removeEventHandler("onClientRender", getRootElement(), renderDyno, true, "low-9999999999")
    removeEventHandler("onClientPreRender", getRootElement(), preRenderDyno)
    sightexports.sControls:toggleControl("enter_exit", true)
    sightexports.sControls:toggleControl("enter_passenger", true)
  end
  sightexports.sSpeedo:toggleSeeDyno(false)
  setCameraTarget(localPlayer)
  dynoCreated = false
  if dynoWindow then
    sightexports.sGui:deleteGuiElement(dynoWindow)
  end
  dynoWindow = false
end
addEvent("endDynoMode", true)
addEventHandler("endDynoMode", getRootElement(), deleteDynoPad)
addEventHandler("onClientResourceStop", getResourceRootElement(), deleteDynoPad)
function createDynoPad()
  deleteDynoPad()
  if veh then
    vehMake = sightexports.sVehiclenames:getCustomVehicleManufacturer(getElementModel(veh))
    modelId = getElementModel(veh)
    if getElementData(veh, "vehicle.customModel") then
      modelId = getElementData(veh, "vehicle.customModel")
    end
    vehModel = sightexports.sVehiclenames:getCustomVehicleName(modelId)
    vehModel = utf8.gsub(vehModel, vehMake .. " ", "")
    lastMaxSpeed = getTickCount()
    maxSpeed = 0
    lastMaxSpeedVal = 0
    lastMeasure = false
    started = false
    lastNull100 = false
    lastNull200 = false
    lastQuarter = false
    lastVmax = false
    null100 = false
    null200 = false
    quarter = false
    vmax = false
    lastQuarterSpeed = false
    quarterSpeed = false
    vmaxReached = false
    distance = 0
    brake = false
    brakeStarted = false
    linesAcceleration = {}
    lastLinesAcceleration = {}
    exiting = false
    dynoCreated = getTickCount()
    sightexports.sControls:toggleControl("enter_exit", false)
    sightexports.sControls:toggleControl("enter_passenger", false)
    addEventHandler("onClientRender", getRootElement(), renderDyno, true, "low-9999999999")
    addEventHandler("onClientPreRender", getRootElement(), preRenderDyno)
    sightexports.sSpeedo:toggleSeeDyno(true, false)
    local dim = getElementDimension(localPlayer)
    screenShader = dxCreateShader("files/texturechanger.fx")
    screenRT = dxCreateRenderTarget(1280, 1440)
    dxSetShaderValue(screenShader, "gTexture", screenRT)
    engineApplyShaderToWorldTexture(screenShader, "dyno_screens")
    screenShader2 = dxCreateShader("files/texturechanger.fx")
    screenRT2 = dxCreateRenderTarget(256, 256)
    dxSetShaderValue(screenShader2, "gTexture", screenRT2)
    engineApplyShaderToWorldTexture(screenShader2, "auto_tune3")
    transTexture = dxCreateTexture("files/trans.dds")
    skidShader = dxCreateShader("files/texturechanger.fx")
    dxSetShaderValue(skidShader, "gTexture", transTexture)
    engineApplyShaderToWorldTexture(skidShader, "particleskid")
    obj = createObject(3095, 0, 0, 2998)
    setElementDimension(obj, dim)
    pad = createObject(sightexports.sModloader:getModelId("dyno_pad"), 0, 0, 2998)
    setElementDoubleSided(pad, true)
    setElementDimension(pad, dim)
    ped = createPed(50, 0, 0, 0)
    setElementDimension(ped, dim)
    ventRot = 0
    vent1 = createObject(sightexports.sModloader:getModelId("dyno_fan"), 0, 0, 0)
    setElementCollisionsEnabled(vent1, false)
    setElementDimension(vent1, dim)
    vent2 = createObject(sightexports.sModloader:getModelId("dyno_fan"), 0, 0, 0)
    setElementCollisionsEnabled(vent2, false)
    setElementDimension(vent2, dim)
    fan1 = playSound3D("files/fan1.mp3", 0, 0, 0, true)
    setElementDimension(fan1, dim)
    setSoundMaxDistance(fan1, 60)
    fan2 = playSound3D("files/fan2.mp3", 0, 0, 0, true)
    setElementDimension(fan2, dim)
    setSoundMaxDistance(fan2, 60)
    rollers = {}
    rollers[1] = createObject(sightexports.sModloader:getModelId("dyno_roller"), 0, 0, 0)
    setElementCollisionsEnabled(rollers[1], false)
    setElementDimension(rollers[1], dim)
    rollers[2] = createObject(sightexports.sModloader:getModelId("dyno_roller"), 0, 0, 0)
    setElementCollisionsEnabled(rollers[2], false)
    setElementDimension(rollers[2], dim)
    rollers[3] = createObject(sightexports.sModloader:getModelId("dyno_roller"), 0, 0, 0)
    setElementCollisionsEnabled(rollers[3], false)
    setElementDimension(rollers[3], dim)
    rollers[4] = createObject(sightexports.sModloader:getModelId("dyno_roller"), 0, 0, 0)
    setElementCollisionsEnabled(rollers[4], false)
    setElementDimension(rollers[4], dim)
    rearCarrige = createObject(sightexports.sModloader:getModelId("dyno_rear"), 0, 0, 0)
    setElementDimension(rearCarrige, dim)
    setElementCollisionsEnabled(rearCarrige, false)
    setElementAlpha(obj, 0)
    minX, minY, minZ, maxX, maxY, maxZ = getElementBoundingBox(veh)
    if getVehicleController(veh) == localPlayer then
      setElementRotation(veh, 0, 0, 0)
      setElementPosition(veh, 0, 0, 2998 - minZ + getVehicleModelWheelSize(getElementModel(veh), "front_axle"))
    end
    setElementCollidableWith(localPlayer, obj, false)
    setElementCollidableWith(veh, pad, false)
    createDynoWindow()
  end
end
addEvent("startDynoMode", true)
addEventHandler("startDynoMode", getRootElement(), function(v)
  veh = v
  if v == getPedOccupiedVehicle(localPlayer) then
    createDynoPad()
  end
end)
addEvent("exitFromDynoPad", false)
addEventHandler("exitFromDynoPad", getRootElement(), function(v)
  if not exiting then
    triggerServerEvent("exitFromDynoPad", localPlayer)
    exiting = true
  end
end)
local lastPrint = 0
function linesSort(a, b)
  return a[2] < b[2]
end
addEvent("printDynoResults", false)
addEventHandler("printDynoResults", getRootElement(), function(v)
  if linesAcceleration and 1 <= #linesAcceleration and not started then
    if getTickCount() - lastPrint < 15000 then
      sightexports.sGui:showInfobox("e", "Kérlek várj még a nyomtatással!")
      return
    end
    lastPrint = getTickCount()
    local lines = {}
    local t = 0
    local last = 500
    table.insert(lines, {
      linesAcceleration[1][1],
      linesAcceleration[1][2]
    })
    for i = 2, #linesAcceleration do
      t = t + linesAcceleration[i][2]
      last = last - linesAcceleration[i][2]
      if last <= 0 or i == #linesAcceleration then
        table.insert(lines, {
          linesAcceleration[i][1],
          t
        })
        last = 500
      end
    end
    if null100 then
      table.insert(lines, {100, null100})
    end
    if null200 then
      table.insert(lines, {200, null200})
    end
    if vmax then
      table.insert(lines, {maxSpeed, vmax})
    end
    if quarter and quarterSpeed and quarter < vmax then
      table.insert(lines, {quarterSpeed, quarter})
    end
    table.sort(lines, linesSort)
    triggerServerEvent("printDynoTicket", localPlayer, lines, null100, null200, quarter, quarterSpeed, vmax, brake, maxSpeed)
  end
end)
function createDynoWindow()
  font = sightexports.sGui:getFont("9/Ubuntu-R.ttf")
  fontScale = sightexports.sGui:getFontScale("9/Ubuntu-R.ttf")
  font2 = sightexports.sGui:getFont("30/Ubuntu-R.ttf")
  font2Scale = sightexports.sGui:getFontScale("30/Ubuntu-R.ttf")
  titleBarHeight = sightexports.sGui:getTitleBarHeight()
  panelWidth = 900
  panelHeight = 550
  if getVehicleController(veh) == localPlayer then
    panelHeight = panelHeight + 30 + 16
  end
  local x, y = screenX / 2 - panelWidth / 2, screenY / 2 - panelHeight / 2
  if dynoWindow then
    x, y = sightexports.sGui:getGuiPosition(dynoWindow)
    sightexports.sGui:deleteGuiElement(dynoWindow)
  end
  dynoWindow = sightexports.sGui:createGuiElement("window", x, y, panelWidth, panelHeight)
  local grey2 = sightexports.sGui:getColorCode("sightgrey2")
  sightexports.sGui:setWindowColors(dynoWindow, {
    grey2[1],
    grey2[2],
    grey2[3],
    150
  }, "sightgrey1", "sightgrey3", "#ffffff")
  sightexports.sGui:setWindowTitle(dynoWindow, "16/BebasNeueRegular.otf", "SightDyno")
  if getVehicleController(veh) == localPlayer then
    local btn = sightexports.sGui:createGuiElement("button", 8, panelHeight - 30 - 8, 170, 30, dynoWindow)
    if started then
      sightexports.sGui:setGuiBackground(btn, "solid", "sightred")
      sightexports.sGui:setGuiHover(btn, "gradient", {
        "sightred",
        "sightred-second"
      })
      sightexports.sGui:setButtonText(btn, "Mérés leállítása")
      sightexports.sGui:setClickEvent(btn, "stopDynoMeter")
    else
      sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
      sightexports.sGui:setGuiHover(btn, "gradient", {
        "sightgreen",
        "sightgreen-second"
      })
      sightexports.sGui:setButtonText(btn, "Mérés indítása (500$)")
      sightexports.sGui:setClickEvent(btn, "startDynoMeter")
      if linesAcceleration and 1 <= #linesAcceleration then
        local btn = sightexports.sGui:createGuiElement("button", 186, panelHeight - 30 - 8, 170, 30, dynoWindow)
        sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
        sightexports.sGui:setGuiHover(btn, "gradient", {
          "sightgreen",
          "sightgreen-second"
        })
        sightexports.sGui:setButtonText(btn, "Eredmény nyomtatása")
        sightexports.sGui:setClickEvent(btn, "printDynoResults")
        sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
        sightexports.sGui:setButtonTextColor(btn, "#ffffff")
      end
    end
    sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
    sightexports.sGui:setButtonTextColor(btn, "#ffffff")
    local btn = sightexports.sGui:createGuiElement("button", panelWidth - 128 - 8, panelHeight - 30 - 8, 128, 30, dynoWindow)
    sightexports.sGui:setGuiBackground(btn, "solid", "sightred")
    sightexports.sGui:setGuiHover(btn, "gradient", {
      "sightred",
      "sightred-second"
    })
    sightexports.sGui:setButtonText(btn, "Kilépés")
    sightexports.sGui:setClickEvent(btn, "exitFromDynoPad")
    sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
    sightexports.sGui:setButtonTextColor(btn, "#ffffff")
  end
end
function startDyno()
  lastLinesAcceleration = {}
  for i = 1, #linesAcceleration do
    table.insert(lastLinesAcceleration, linesAcceleration[i])
  end
  linesAcceleration = {}
  lastNull100 = null100
  lastNull200 = null200
  lastQuarter = quarter
  lastVmax = vmax
  lastMaxSpeedVal = maxSpeed
  lastQuarterSpeed = quarterSpeed
  started = getTickCount()
  lastMeasure = getTickCount()
  lastMaxSpeed = getTickCount()
  setElementData(veh, "vehicle.gear", "D")
  maxSpeed = 0
  null100 = false
  null200 = false
  quarter = false
  quarterSpeed = false
  vmax = false
  vmaxReached = false
  brake = false
  brakeStarted = false
  distance = 0
  createDynoWindow()
  sightexports.sSpeedo:toggleSeeDyno(true, true)
end
addEvent("canStartDynoMeter", true)
addEventHandler("canStartDynoMeter", getRootElement(), function()
  startDyno()
end)
addEvent("startDynoMeter", false)
addEventHandler("startDynoMeter", getRootElement(), function()
  if getTickCount() - dynoCreated > 2000 then
    if getVehicleSpeed(veh) < 1 then
      triggerServerEvent("startDynoMeter", localPlayer)
    else
      sightexports.sGui:showInfobox("e", "Várd meg, hogy kiguruljon az autó!")
    end
  else
    sightexports.sGui:showInfobox("e", "Várj pár másodpercet!")
  end
end)
function endDyno()
  started = false
  setElementData(veh, "vehicle.gear", "N")
  createDynoWindow()
  sightexports.sSpeedo:toggleSeeDyno(true, false)
end
addEvent("stopDynoMeter", false)
addEventHandler("stopDynoMeter", getRootElement(), function()
  vmaxReached = getTickCount()
  vmax = getTickCount() - started
  endDyno()
end)
function renderDyno()
  if lastMeasure then
    local now = vmaxReached or getTickCount()
    local delta = now - lastMeasure + 100
    if vmaxReached then
      delta = math.ceil(delta / 200) * 200
    end
    local lastTimeMax = 0
    local x = 0
    local w = panelWidth - 64
    local ox = x
    for i = 2, #lastLinesAcceleration do
      local w1 = lastLinesAcceleration[i][2] * (w / delta)
      if x > w then
        break
      else
        lastTimeMax = math.max(lastTimeMax, lastLinesAcceleration[i][1])
      end
      x = x + w1
    end
    local shownSpeed = math.max(100, math.max(lastTimeMax, maxSpeed) + 10)
    if vmaxReached then
      shownSpeed = math.floor(shownSpeed / 10) * 10
    end
    dxSetRenderTarget(screenRT2, true)
    sightlangStaticImageUsed[0] = true
    if sightlangStaticImageToc[0] then
      processsightlangStaticImage[0]()
    end
    dxDrawImage(0, 0, 256, 256, sightlangStaticImage[0])
    dxDrawRectangle(30, 34, 196, 158, tocolor(70, 68, 69, 255))
    local w = 196 / delta
    local x = 30
    local y = 34
    local h = 158
    local ly = y + h
    local ow = 196
    ox = x
    for i = 2, #lastLinesAcceleration do
      local w1 = lastLinesAcceleration[i][2] * w
      local y1 = y + h - lastLinesAcceleration[i][1] / shownSpeed * h
      if x > ox + ow then
        break
      else
        dxDrawLine(x, ly, x + w1, y1, tocolor(255, 0, 0, 100), 2)
      end
      ly = y1
      x = x + w1
    end
    local x = 30
    local y = 34
    local h = 158
    local ly = y + h
    for i = 2, #linesAcceleration do
      local w1 = linesAcceleration[i][2] * w
      local y1 = y + h - linesAcceleration[i][1] / shownSpeed * h
      dxDrawLine(x, ly, x + w1, y1, tocolor(255, 0, 0), 3)
      ly = y1
      x = x + w1
    end
    dxSetRenderTarget(screenRT, true)
    local speed = getVehicleSpeed(veh)
    sightlangStaticImageUsed[1] = true
    if sightlangStaticImageToc[1] then
      processsightlangStaticImage[1]()
    end
    dxDrawImage(0, 0, 1280, 720, sightlangStaticImage[1])
    sightlangStaticImageUsed[1] = true
    if sightlangStaticImageToc[1] then
      processsightlangStaticImage[1]()
    end
    dxDrawImage(0, 720, 1280, 720, sightlangStaticImage[1])
    sightlangStaticImageUsed[2] = true
    if sightlangStaticImageToc[2] then
      processsightlangStaticImage[2]()
    end
    dxDrawImage(384, 32, 512, 256, sightlangStaticImage[2], 0, 0, 0, tocolor(255, 255, 255, 255))
    dxDrawText(string.format("%.1f", speed) .. " km/h", 0, 288, 1280, 384, tocolor(255, 255, 255), font2Scale * 1.75, font2, "center", "center")
    dxDrawText(string.format("%.3f", (now - lastMeasure) / 1000) .. " sec", 0, 384, 1280, 480, tocolor(255, 255, 255), font2Scale * 1.75, font2, "center", "center")
    dxDrawText(vehMake, 0, 480, 1280, 576, tocolor(255, 255, 255), font2Scale * 1.75, font2, "center", "center")
    dxDrawText(vehModel, 0, 576, 1280, 672, tocolor(255, 255, 255), font2Scale * 1.75, font2, "center", "center")
    sightlangStaticImageUsed[2] = true
    if sightlangStaticImageToc[2] then
      processsightlangStaticImage[2]()
    end
    dxDrawImage(384, 752, 512, 256, sightlangStaticImage[2], 0, 0, 0, tocolor(255, 255, 255, 255))
    local y = 1008
    dxDrawText("0-100: " .. (null100 and string.format("%.3f", null100 / 1000) or "N/A") .. " sec", 0, y, 1280, y + 80, tocolor(255, 255, 255), font2Scale * 1.45, font2, "center", "center")
    y = y + 80
    dxDrawText("0-200: " .. (null200 and string.format("%.3f", null200 / 1000) or "N/A") .. " sec", 0, y, 1280, y + 80, tocolor(255, 255, 255), font2Scale * 1.45, font2, "center", "center")
    y = y + 80
    dxDrawText("1/4 mi: " .. (quarter and string.format("%.3f", quarter / 1000) or "N/A") .. " sec", 0, y, 1280, y + 80, tocolor(255, 255, 255), font2Scale * 1.45, font2, "center", "center")
    y = y + 80
    dxDrawText("vmax: " .. (vmax and string.format("%.3f", vmax / 1000) or "N/A") .. " sec (" .. string.format("%.1f", maxSpeed) .. " km/h)", 0, y, 1280, y + 80, tocolor(255, 255, 255), font2Scale * 1.45, font2, "center", "center")
    y = y + 80
    dxDrawText("vmax-0: " .. (brake and string.format("%.3f", brake / 1000) or "N/A") .. " sec", 0, y, 1280, y + 80, tocolor(255, 255, 255), font2Scale * 1.45, font2, "center", "center")
    dxSetRenderTarget()
    local x = 0
    local w, h = panelWidth - 64, panelHeight - 64 - titleBarHeight
    if getVehicleController(veh) == localPlayer then
      h = h - 30 - 16
    end
    local x, y = sightexports.sGui:getGuiPosition(dynoWindow)
    x = x + 24
    y = y + titleBarHeight + 24
    sightlangStaticImageUsed[2] = true
    if sightlangStaticImageToc[2] then
      processsightlangStaticImage[2]()
    end
    dxDrawImage(x + w / 2 - 250, y + h / 2 - 125, 500, 250, sightlangStaticImage[2], 0, 0, 0, tocolor(255, 255, 255, 150))
    local ox = x
    for i = 0, shownSpeed, 10 do
      dxDrawLine(x, y + h - i * (h / shownSpeed), x + w, y + h - i * (h / shownSpeed), tocolor(110, 110, 110, 150), i % 50 == 0 and 2 or 1)
      dxDrawText(i, x + w + 10, y + h - i * (h / shownSpeed), x + w + 10, y + h - i * (h / shownSpeed), tocolor(255, 255, 255), fontScale, font, "left", "center")
    end
    local ow = w
    w = w / delta
    for i = 0, math.floor(delta / 1000 * 5) do
      dxDrawLine(x, y, x, y + h, tocolor(110, 110, 110, 150), i % 5 == 0 and 2 or 1)
      if i % 5 == 0 then
        dxDrawText(i * 1 / 5, x, y + h, x, y + h, tocolor(255, 255, 255), fontScale, font, "center", "top")
      end
      x = x + w * 200
    end
    x = ox
    local ly = y + h
    for i = 2, #lastLinesAcceleration do
      local w1 = lastLinesAcceleration[i][2] * w
      local y1 = y + h - lastLinesAcceleration[i][1] / shownSpeed * h
      if x > ox + ow then
        break
      else
        dxDrawLine(x, ly, x + w1, y1, tocolor(255, 0, 0, 100), 2)
      end
      ly = y1
      x = x + w1
    end
    ly = y + h
    x = ox
    for i = 2, #linesAcceleration do
      local w1 = linesAcceleration[i][2] * w
      local y1 = y + h - linesAcceleration[i][1] / shownSpeed * h
      dxDrawLine(x, ly, x + w1, y1, tocolor(255, 0, 0), 3)
      ly = y1
      x = x + w1
    end
    if lastNull100 and delta > lastNull100 then
      local x = ox + lastNull100 * w
      local y1 = y + h - 100 / shownSpeed * h
      dxDrawLine(x, y1, x, y + h, tocolor(255, 125, 0, 120), 1)
      dxDrawRectangle(x - 4, y1 - 4, 8, 8, tocolor(255, 125, 0, 120))
      dxDrawText("0-100", x, y1 - 4, x, y1 - 4, tocolor(255, 255, 255, 120), fontScale, font, "center", "bottom")
    end
    if lastNull200 and delta > lastNull200 then
      local x = ox + lastNull200 * w
      local y1 = y + h - 200 / shownSpeed * h
      dxDrawLine(x, y1, x, y + h, tocolor(255, 125, 0, 120), 1)
      dxDrawRectangle(x - 4, y1 - 4, 8, 8, tocolor(255, 125, 0, 120))
      dxDrawText("0-200", x, y1 - 4, x, y1 - 4, tocolor(255, 255, 255, 120), fontScale, font, "center", "bottom")
    end
    if lastVmax and delta > lastVmax then
      local x = ox + lastVmax * w
      local y1 = y + h - lastMaxSpeedVal / shownSpeed * h
      dxDrawLine(x, y1, x, y + h, tocolor(255, 125, 0, 120), 1)
      dxDrawRectangle(x - 4, y1 - 4, 8, 8, tocolor(255, 125, 0, 120))
      dxDrawText([[
vmax
(]] .. string.format("%.1f", lastMaxSpeedVal) .. ")", x, y1 - 4, x, y1 - 4, tocolor(255, 255, 255, 120), fontScale, font, "center", "bottom")
    end
    if lastQuarter and lastQuarterSpeed and delta >= lastQuarter then
      local x = ox + lastQuarter * w
      local y1 = y + h - lastQuarterSpeed / shownSpeed * h
      dxDrawLine(x, y1, x, y + h, tocolor(255, 125, 0, 120), 1)
      dxDrawRectangle(x - 4, y1 - 4, 8, 8, tocolor(255, 125, 0, 120))
      dxDrawText("1/4 mi", x, y1 - 4, x, y1 - 4, tocolor(255, 255, 255, 120), fontScale, font, "center", "bottom")
    end
    if null100 then
      local x = ox + null100 * w
      local y1 = y + h - 100 / shownSpeed * h
      dxDrawLine(x, y1, x, y + h + 16, tocolor(255, 125, 0), 1)
      dxDrawRectangle(x - 4, y1 - 4, 8, 8, tocolor(255, 125, 0))
      dxDrawText("0-100", x, y1 - 4, x, y1 - 4, tocolor(255, 255, 255), fontScale, font, "center", "bottom")
      dxDrawText(null100 / 1000 .. " s", x, y + h + 16, x, y + h + 16, tocolor(255, 255, 255), fontScale, font, "center", "top")
    end
    if null200 then
      local x = ox + null200 * w
      local y1 = y + h - 200 / shownSpeed * h
      dxDrawLine(x, y1, x, y + h + 16, tocolor(255, 125, 0), 1)
      dxDrawRectangle(x - 4, y1 - 4, 8, 8, tocolor(255, 125, 0))
      dxDrawText("0-200", x, y1 - 4, x, y1 - 4, tocolor(255, 255, 255), fontScale, font, "center", "bottom")
      dxDrawText(null200 / 1000 .. " s", x, y + h + 16, x, y + h + 16, tocolor(255, 255, 255), fontScale, font, "center", "top")
    end
    if vmax then
      local x = ox + vmax * w
      local y1 = y + h - maxSpeed / shownSpeed * h
      dxDrawLine(x, y1, x, y + h + 16, tocolor(255, 125, 0), 1)
      dxDrawRectangle(x - 4, y1 - 4, 8, 8, tocolor(255, 125, 0))
      dxDrawText([[
vmax
(]] .. string.format("%.1f", maxSpeed) .. ")", x, y1 - 4, x, y1 - 4, tocolor(255, 255, 255), fontScale, font, "center", "bottom")
      dxDrawText(vmax / 1000 .. " s", x, y + h + 16, x, y + h + 16, tocolor(255, 255, 255), fontScale, font, "center", "top")
    end
    if quarter and quarterSpeed and delta >= quarter then
      local x = ox + quarter * w
      local y1 = y + h - quarterSpeed / shownSpeed * h
      dxDrawLine(x, y1, x, y + h + 16, tocolor(255, 125, 0), 1)
      dxDrawRectangle(x - 4, y1 - 4, 8, 8, tocolor(255, 125, 0))
      dxDrawText("1/4 mi", x, y1 - 4, x, y1 - 4, tocolor(255, 255, 255), fontScale, font, "center", "bottom")
      dxDrawText(quarter / 1000 .. " s", x, y + h + 16, x, y + h + 16, tocolor(255, 255, 255), fontScale, font, "center", "top")
    end
  else
    dxSetRenderTarget(screenRT2, true)
    sightlangStaticImageUsed[0] = true
    if sightlangStaticImageToc[0] then
      processsightlangStaticImage[0]()
    end
    dxDrawImage(0, 0, 256, 256, sightlangStaticImage[0])
    dxSetRenderTarget(screenRT, true)
    sightlangStaticImageUsed[1] = true
    if sightlangStaticImageToc[1] then
      processsightlangStaticImage[1]()
    end
    dxDrawImage(0, 0, 1280, 720, sightlangStaticImage[1])
    sightlangStaticImageUsed[1] = true
    if sightlangStaticImageToc[1] then
      processsightlangStaticImage[1]()
    end
    dxDrawImage(0, 720, 1280, 720, sightlangStaticImage[1])
    sightlangStaticImageUsed[2] = true
    if sightlangStaticImageToc[2] then
      processsightlangStaticImage[2]()
    end
    dxDrawImage(384, 232, 512, 256, sightlangStaticImage[2], 0, 0, 0, tocolor(255, 255, 255, 255))
    sightlangStaticImageUsed[2] = true
    if sightlangStaticImageToc[2] then
      processsightlangStaticImage[2]()
    end
    dxDrawImage(384, 952, 512, 256, sightlangStaticImage[2], 0, 0, 0, tocolor(255, 255, 255, 255))
    dxSetRenderTarget()
  end
end
local camSet = false
function preRenderDyno(delta)
  if not isElement(veh) or getPedOccupiedVehicle(localPlayer) ~= veh then
    deleteDynoPad()
  else
    local now = getTickCount()
    local speed = getVehicleSpeed(veh)
    if speed < 1 and brakeStarted then
      brake = now - brakeStarted
      brakeStarted = false
      dynoCreated = getTickCount()
      if getVehicleController(veh) == localPlayer then
        minX, minY, minZ, maxX, maxY, maxZ = getElementBoundingBox(veh)
        setElementRotation(veh, 0, 0, 0)
        setElementPosition(veh, 0, 0, 2998 - minZ + getVehicleModelWheelSize(getElementModel(veh), "front_axle"))
      end
    end
    local x, y, z = getElementPosition(veh)
    setElementPosition(obj, x, y, 2998)
    local rx, ry, rz = getElementRotation(veh)
    setElementRotation(veh, rx, ry, 0)
    local frontRX, frontRY, frontRZ = getVehicleComponentRotation(veh, "wheel_rf_dummy")
    local rearRX, rearRY, rearRZ = getVehicleComponentRotation(veh, "wheel_rb_dummy")
    local frontX, frontY, frontZ = getVehicleComponentPosition(veh, "wheel_rf_dummy", "world")
    local rearX, rearY, rearZ = getVehicleComponentPosition(veh, "wheel_rb_dummy", "world")
    local rearX2, rearY2, rearZ2 = getVehicleComponentPosition(veh, "wheel_lb_dummy", "world")
    local px, py, pz = x, frontY - 2.285225, frontZ + 1.53844 - getVehicleModelWheelSize(getElementModel(veh), "front_axle") / 2
    setElementRotation(ped, 0, 0, -50)
    setElementPosition(ped, px - 2.92056, py + 3.33609, pz - 0.541911)
    local cx = (rearX + rearX2) / 2
    local cy = (rearY + rearY2) / 2
    local cz = (rearZ + rearZ2) / 2 - getVehicleModelWheelSize(getElementModel(veh), "rear_axle") / 4
    dxDrawLine3D(cx, cy, cz, px + 2.80066, py - 5.08741, pz - 1.39527, tocolor(0, 0, 0, 255), 2)
    dxDrawLine3D(cx, cy, cz, px - 2.79957, py - 5.08741, pz - 1.39527, tocolor(0, 0, 0, 255), 2)
    setElementPosition(pad, px, py, pz)
    setElementPosition(rearCarrige, px + 0.413383, rearY, pz - 1.53844)
    setElementPosition(rollers[1], px, py + 2.51138, pz - 1.63878)
    setElementPosition(rollers[2], px, py + 2.05907, pz - 1.63878)
    setElementRotation(rollers[1], -frontRX, 0, 0)
    setElementRotation(rollers[2], -frontRX, 0, 0)
    setElementPosition(rollers[3], px, rearY + 0.225779, pz - 1.63878)
    setElementPosition(rollers[4], px, rearY - 0.225278, pz - 1.63878)
    setElementRotation(rollers[3], -rearRX, 0, 0)
    setElementRotation(rollers[4], -rearRX, 0, 0)
    setElementPosition(vent1, px - 0.39707, py + 4.52582, pz - 1.06099)
    setElementPosition(vent2, px + 0.39707, py + 4.52582, pz - 1.06099)
    setElementPosition(fan1, px, py + 4.52582, pz - 1.06099)
    setElementPosition(fan2, px, py + 4.52582, pz - 1.06099)
    setSoundVolume(fan1, 0.5 + 0.3 * (math.min(150, speed) / 150))
    setSoundVolume(fan2, 0.8 * (math.min(150, speed) / 150))
    setSoundSpeed(fan1, 0.75 + 0.5 * (math.min(150, speed) / 150))
    setSoundSpeed(fan2, 0.75 + 0.5 * (math.min(150, speed) / 150))
    ventRot = (ventRot + (400 + math.min(200, speed) * 2) * delta / 1000) % 360
    setElementRotation(vent1, 0, ventRot, 0)
    setElementRotation(vent2, 0, ventRot, 0)
    local controller = getVehicleController(veh)
    if 1 < speed and not started and not brakeStarted and controller ~= localPlayer and getTickCount() - dynoCreated > 2000 then
      startDyno()
    end
    if 3 < speed and started or camSet then
      setCameraMatrix(px - 2.5, py - 6, pz + 0.5, px, py + 1, pz)
      camSet = true
    end
    if speed < 3 and camSet then
      setCameraTarget(localPlayer)
      camSet = false
    end
    if started and not vmax then
      table.insert(linesAcceleration, {
        math.max(maxSpeed, speed),
        delta
      })
    end
    if started then
      distance = distance + speed / 3600 * delta / 1000
      if speed > maxSpeed then
        lastMaxSpeed = now
        maxSpeed = speed
      end
      if 100 <= speed and not null100 then
        null100 = now - started
      end
      if 200 <= speed and not null200 then
        null200 = now - started
      end
      if 0.402336 <= distance and not quarter then
        quarter = now - started
        quarterSpeed = speed
      end
      if 100 < now - lastMaxSpeed then
        if not vmax then
          vmaxReached = now
          vmax = now - started
        end
        if quarter or speed < 1 then
          brakeStarted = now
          endDyno()
        end
      end
    end
  end
end
local ticketFont = false
local ticketFontScale = false
local ticketLines = false
local ticketNull100 = false
local ticketNull200 = false
local ticketQuarter = false
local ticketQuarterSpeed = false
local ticketVmax = false
local ticketBrake = false
local ticketMaxSpeed = false
local ticketDate = false
local ticketMake = false
local ticketModel = false
local ticketPlate = false
function closeDynoTicket()
  ticketLines = false
  removeEventHandler("onClientRender", getRootElement(), renderDynoTicket)
end
function openDynoTicket(input)
  if ticketLines then
    closeDynoTicket()
  end
  ticketFont = sightexports.sGui:getFont("13/IckyticketMono-nKpJ.ttf")
  ticketFontScale = sightexports.sGui:getFontScale("13/IckyticketMono-nKpJ.ttf")
  ticketLines = input.lines
  ticketNull100 = input.null100
  ticketNull200 = input.null200
  ticketQuarter = input.quarter
  ticketQuarterSpeed = input.quarterSpeed
  ticketVmax = input.vmax
  ticketBrake = input.brake
  ticketMaxSpeed = input.maxSpeed
  local time = getRealTime(input.date)
  ticketDate = string.format("%04d. %02d. %02d. %02d:%02d:%02d", time.year + 1900, time.month + 1, time.monthday, time.hour, time.minute, time.second)
  ticketMake = input.make
  ticketModel = input.model
  ticketPlate = input.plate
  addEventHandler("onClientRender", getRootElement(), renderDynoTicket)
end
function renderDynoTicket()
  local w = 300
  local h = 525
  local x, y = screenX / 2 - w / 2, screenY / 2 - h / 2
  dxDrawRectangle(x, y, w, h, tocolor(240, 240, 240, 255))
  sightlangStaticImageUsed[3] = true
  if sightlangStaticImageToc[3] then
    processsightlangStaticImage[3]()
  end
  dxDrawImage(x, y, w, w / 4, sightlangStaticImage[3])
  y = y + math.ceil(w / 4)
  dxDrawText(ticketDate, x, y, x + w, y + 20, tocolor(0, 0, 0), ticketFontScale, ticketFont, "center", "center")
  y = y + 20
  dxDrawText(ticketMake, x, y, x + w, y + 20, tocolor(0, 0, 0), ticketFontScale, ticketFont, "center", "center")
  y = y + 20
  dxDrawText(ticketModel, x, y, x + w, y + 20, tocolor(0, 0, 0), ticketFontScale, ticketFont, "center", "center")
  y = y + 20
  dxDrawText(ticketPlate, x, y, x + w, y + 20, tocolor(0, 0, 0), ticketFontScale, ticketFont, "center", "center")
  y = y + 20
  y = y + 35
  local delta = ticketLines[#ticketLines][2]
  local speed = ticketLines[#ticketLines][1]
  speed = math.ceil(speed / 20) * 20
  delta = math.ceil(delta / 200) * 200
  local h = 175
  local xl = x + 10
  local yl = y + h
  local wl = (w - 40) / delta
  for i = 0, speed, 20 do
    dxDrawLine(xl, y + h - i * (h / speed), xl + w - 40, y + h - i * (h / speed), tocolor(0, 0, 0, 75), i % 50 == 0 and 2 or 1)
    dxDrawText(i, xl + w - 40 + 5, y + h - i * (h / speed), xl + w - 40 + 5, y + h - i * (h / speed), tocolor(0, 0, 0), ticketFontScale * 0.75, ticketFont, "left", "center")
  end
  for i = 0, math.floor(delta / 1000 * 5) do
    dxDrawLine(xl, y, xl, y + h, tocolor(0, 0, 0, 75), i % 5 == 0 and 2 or 1)
    if i % 5 == 0 and math.floor(i) % 2 == 0 then
      dxDrawText(i * 1 / 5, xl, y + h, xl, y + h, tocolor(0, 0, 0), ticketFontScale * 0.75, ticketFont, "center", "top")
    end
    xl = xl + wl * 200
  end
  xl = x + 10
  yl = y + h
  for i = 1, #ticketLines do
    local w1 = wl * (ticketLines[i][2] - (1 < i and ticketLines[i - 1][2] or 0))
    local y1 = y + h - h * ticketLines[i][1] / speed
    dxDrawLine(xl, yl, xl + w1, y1, tocolor(0, 0, 0, 255), 2)
    xl = xl + w1
    yl = y1
  end
  xl = x + 10
  yl = y + h
  if ticketNull100 then
    dxDrawLine(xl + wl * ticketNull100, y + h - h * 100 / speed, xl + wl * ticketNull100, y + h + 15, tocolor(0, 0, 0, 255), 2)
    dxDrawText(string.format("%.1f", ticketNull100 / 1000), xl + wl * ticketNull100, y + h + 15, xl + wl * ticketNull100, 0, tocolor(0, 0, 0), ticketFontScale * 0.75, ticketFont, "center", "top")
    dxDrawRectangle(xl + wl * ticketNull100 - 3, y + h - h * 100 / speed - 3, 6, 6, tocolor(0, 0, 0))
    dxDrawText("0-100", xl + wl * ticketNull100 - 3, 0, xl + wl * ticketNull100 - 3, y + h - h * 100 / speed - 3, tocolor(0, 0, 0), ticketFontScale * 0.75, ticketFont, "center", "bottom")
  end
  if ticketNull200 then
    dxDrawLine(xl + wl * ticketNull200, y + h - h * 200 / speed, xl + wl * ticketNull200, y + h + 15, tocolor(0, 0, 0, 255), 2)
    dxDrawText(string.format("%.1f", ticketNull200 / 1000), xl + wl * ticketNull200, y + h + 15, xl + wl * ticketNull200, 0, tocolor(0, 0, 0), ticketFontScale * 0.75, ticketFont, "center", "top")
    dxDrawRectangle(xl + wl * ticketNull200 - 3, y + h - h * 200 / speed - 3, 6, 6, tocolor(0, 0, 0))
    dxDrawText("0-200", xl + wl * ticketNull200 - 3, 0, xl + wl * ticketNull200 - 3, y + h - h * 200 / speed - 3, tocolor(0, 0, 0), ticketFontScale * 0.75, ticketFont, "center", "bottom")
  end
  if ticketQuarter and ticketQuarter < ticketVmax then
    dxDrawLine(xl + wl * ticketQuarter, y + h - h * ticketQuarterSpeed / speed, xl + wl * ticketQuarter, y + h + 15, tocolor(0, 0, 0, 255), 2)
    dxDrawText(string.format("%.1f", ticketQuarter / 1000), xl + wl * ticketQuarter, y + h + 15, xl + wl * ticketQuarter, 0, tocolor(0, 0, 0), ticketFontScale * 0.75, ticketFont, "center", "top")
    dxDrawRectangle(xl + wl * ticketQuarter - 3, y + h - h * ticketQuarterSpeed / speed - 3, 6, 6, tocolor(0, 0, 0))
    dxDrawText("1/4 mi", xl + wl * ticketQuarter - 3, 0, xl + wl * ticketQuarter - 3, y + h - h * ticketQuarterSpeed / speed - 3, tocolor(0, 0, 0), ticketFontScale * 0.75, ticketFont, "center", "bottom")
  end
  if ticketVmax then
    dxDrawLine(xl + wl * ticketVmax, y + h - h * ticketMaxSpeed / speed, xl + wl * ticketVmax, y + h + 15, tocolor(0, 0, 0, 255), 2)
    dxDrawText(string.format("%.1f", ticketVmax / 1000), xl + wl * ticketVmax, y + h + 15, xl + wl * ticketVmax, 0, tocolor(0, 0, 0), ticketFontScale * 0.75, ticketFont, "center", "top")
    dxDrawRectangle(xl + wl * ticketVmax - 3, y + h - h * ticketMaxSpeed / speed - 3, 6, 6, tocolor(0, 0, 0))
    dxDrawText([[
vmax
(]] .. string.format("%.1f", ticketMaxSpeed) .. ")", xl + wl * ticketVmax - 3, 0, xl + wl * ticketVmax - 3, y + h - h * ticketMaxSpeed / speed - 3, tocolor(0, 0, 0), ticketFontScale * 0.75, ticketFont, "center", "bottom")
  end
  x = x + 10
  y = y + h + 50
  dxDrawText("0-100: " .. (ticketNull100 and string.format("%.3f", ticketNull100 / 1000) .. " sec" or "N/A"), x, y, x + w, y + 20, tocolor(0, 0, 0), ticketFontScale, ticketFont, "left", "center")
  y = y + 20
  dxDrawText("0-200: " .. (ticketNull200 and string.format("%.3f", ticketNull200 / 1000) .. " sec" or "N/A"), x, y, x + w, y + 20, tocolor(0, 0, 0), ticketFontScale, ticketFont, "left", "center")
  y = y + 20
  dxDrawText("1/4 mi: " .. (ticketQuarter and string.format("%.3f", ticketQuarter / 1000) .. " sec" or "N/A"), x, y, x + w, y + 20, tocolor(0, 0, 0), ticketFontScale, ticketFont, "left", "center")
  y = y + 20
  dxDrawText("vmax: " .. (ticketVmax and string.format("%.3f", ticketVmax / 1000) .. " sec" or "N/A") .. " (" .. string.format("%.1f", ticketMaxSpeed) .. " km/h)", x, y, x + w, y + 20, tocolor(0, 0, 0), ticketFontScale, ticketFont, "left", "center")
  y = y + 20
  dxDrawText("vmax-0: " .. (ticketBrake and string.format("%.3f", ticketBrake / 1000) .. " sec" or "N/A"), x, y, x + w, y + 20, tocolor(0, 0, 0), ticketFontScale, ticketFont, "left", "center")
  y = y + 20
end
local markers = {}
function markersReady()
  for i, v in pairs(markers) do
    sightexports.sMarkers:deleteCustomMarker(v)
  end
  markers = {}
  for i = 1, #pads do
    local x, y, z = pads[i][1], pads[i][2], pads[i][3]
    markers[i] = sightexports.sMarkers:createCustomMarker(x, y, z, 0, 0, "#ffffff", "seedyno")
  end
end
addEventHandler("onClientResourceStop", getResourceRootElement(), function()
  for i, v in pairs(markers) do
    sightexports.sMarkers:deleteCustomMarker(v)
  end
end)
