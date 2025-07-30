local sightexports = {
  sSpeedo = false,
  sMarkers = false,
  sGui = false,
  sVehiclenames = false,
  sModloader = false
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
processsightlangStaticImage[0] = function()
  if not isElement(sightlangStaticImage[0]) then
    sightlangStaticImageToc[0] = false
    sightlangStaticImage[0] = dxCreateTexture("files/circle.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
local sightlangDynImgHand = false
local sightlangDynImgLatCr = falselocal
sightlangDynImage = {}
local sightlangDynImageForm = {}
local sightlangDynImageMip = {}
local sightlangDynImageUsed = {}
local sightlangDynImageDel = {}
local sightlangDynImgPre
function sightlangDynImgPre()
  local now = getTickCount()
  sightlangDynImgLatCr = true
  local rem = true
  for k in pairs(sightlangDynImage) do
    rem = false
    if sightlangDynImageDel[k] then
      if now >= sightlangDynImageDel[k] then
        if isElement(sightlangDynImage[k]) then
          destroyElement(sightlangDynImage[k])
        end
        sightlangDynImage[k] = nil
        sightlangDynImageForm[k] = nil
        sightlangDynImageMip[k] = nil
        sightlangDynImageDel[k] = nil
        break
      end
    elseif not sightlangDynImageUsed[k] then
      sightlangDynImageDel[k] = now + 5000
    end
  end
  for k in pairs(sightlangDynImageUsed) do
    if not sightlangDynImage[k] and sightlangDynImgLatCr then
      sightlangDynImgLatCr = false
      sightlangDynImage[k] = dxCreateTexture(k, sightlangDynImageForm[k], sightlangDynImageMip[k])
    end
    sightlangDynImageUsed[k] = nil
    sightlangDynImageDel[k] = nil
    rem = false
  end
  if rem then
    removeEventHandler("onClientPreRender", getRootElement(), sightlangDynImgPre)
    sightlangDynImgHand = false
  end
end
local function dynamicImage(img, form, mip)
  if not sightlangDynImgHand then
    sightlangDynImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangDynImgPre, true, "high+999999999")
  end
  if not sightlangDynImage[img] then
    sightlangDynImage[img] = dxCreateTexture(img, form, mip)
  end
  sightlangDynImageForm[img] = form
  sightlangDynImageUsed[img] = true
  return sightlangDynImage[img]
end
local sightlangWaiterState0 = false
local function sightlangProcessResWaiters()
  if not sightlangWaiterState0 then
    local res0 = getResourceFromName("sVehiclenames")
    if res0 and getResourceState(res0) == "running" then
      createInstructors()
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
local titleFont = false
local titleFontScale = false
local numberFont = false
local numberFontScale = false
local descriptionFont = false
local descriptionFontScale = false
local circleColor = false
local greenColor = false
local redColor = false
local exclamation = false
local check = false
local faTicks = false
local function sightlangGuiRefreshColors()
  local res = getResourceFromName("sGui")
  if res and getResourceState(res) == "running" then
    titleFont = sightexports.sGui:getFont("16/BebasNeueBold.otf")
    titleFontScale = sightexports.sGui:getFontScale("16/BebasNeueBold.otf")
    numberFont = sightexports.sGui:getFont("18/BebasNeueRegular.otf")
    numberFontScale = sightexports.sGui:getFontScale("18/BebasNeueRegular.otf")
    descriptionFont = sightexports.sGui:getFont("12/Ubuntu-R.ttf")
    descriptionFontScale = sightexports.sGui:getFontScale("12/Ubuntu-R.ttf")
    circleColor = sightexports.sGui:getColorCode("sightblue")
    greenColor = sightexports.sGui:getColorCode("sightgreen")
    redColor = sightexports.sGui:getColorCode("sightred")
    exclamation = sightexports.sGui:getFaIconFilename("exclamation", 24)
    check = sightexports.sGui:getFaIconFilename("check", 48)
    faTicks = sightexports.sGui:getFaTicks()
  end
end
addEventHandler("onGuiRefreshColors", getRootElement(), sightlangGuiRefreshColors)
addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangGuiRefreshColors)
addEventHandler("refreshFaTicks", getRootElement(), function()
  faTicks = sightexports.sGui:getFaTicks()
end)
local screenX, screenY = guiGetScreenSize()
local currentTask = false
local blip = false
local marker = false
local taskAnim = false
local nextTask = false
local playerVehicle = false
local lastCollision = 0
local offGround = 0
local offGroundLevel = 0
local lastFrame = 0
local speedingWarning = 0
local warningNum = 0
local maxWarnings = 8
local forceBrake = false
function endExam()
  if forceBrake then
    forceBrake = false
    sightexports.sSpeedo:toggleForceBrake(false)
  end
  if playerVehicle then
    removeEventHandler("onClientRender", getRootElement(), renderStudentDriver)
    removeEventHandler("onClientVehicleCollision", getRootElement(), studentCarCollision)
    removeEventHandler("issueTraffipaxWarning", getRootElement(), traffiIssueWarning)
  end
  playerVehicle = false
  if isElement(blip) then
    destroyElement(blip)
  end
  blip = false
  if isElement(marker) then
    destroyElement(marker)
  end
  marker = false
  sightexports.sMarkers:setMarkedVehicle(false)
end
addEvent("setCurrentVehicleExamTask", true)
addEventHandler("setCurrentVehicleExamTask", getRootElement(), function(task, x, y, z, veh)
  if task then
    if not playerVehicle and isElement(veh) then
      playerVehicle = veh
      currentTask = false
      if forceBrake then
        forceBrake = false
        sightexports.sSpeedo:toggleForceBrake(false)
      end
      addEventHandler("onClientRender", getRootElement(), renderStudentDriver)
      addEventHandler("onClientVehicleCollision", veh, studentCarCollision)
      addEventHandler("issueTraffipaxWarning", getRootElement(), traffiIssueWarning)
      offGround = 0
      offGroundLevel = 0
      speedingWarning = 0
      warningNum = 0
      lastCollision = 0
    elseif isElement(veh) and veh ~= playerVehicle then
      endExam()
      triggerServerEvent("endStudentDriverExam", localPlayer)
    end
    if taskAnim then
      local p = (getTickCount() - taskAnim) / 1000
      if 1 < p then
        currentTask = task
      end
      nextTask = task
    else
      nextTask = task
      taskAnim = getTickCount()
      if 1 < nextTask then
        playSound("files/pipa.wav")
      end
    end
    if isElement(blip) then
      destroyElement(blip)
    end
    if isElement(marker) then
      destroyElement(marker)
    end
    sightexports.sMarkers:setMarkedVehicle(false)
    if isElement(veh) then
      local r, g, b = unpack(sightexports.sGui:getColorCode("sightblue"))
      blip = createBlipAttachedTo(veh, 1, 2, r, g, b)
      sightexports.sMarkers:setMarkedVehicle(veh, "sightblue")
    elseif x then
      local r, g, b = unpack(sightexports.sGui:getColorCode("sightblue"))
      blip = createBlip(x, y, z, 0, 2, r, g, b)
      marker = createMarker(x, y, z, "checkpoint", 4, r, g, b)
      setElementData(blip, "tooltipText", "Vezess ide!")
    else
      blip = false
      marker = false
    end
  elseif playerVehicle then
    endExam()
  end
end)
function dxDrawTextEx(t, x, y, x2, y2, c, fs, f, a1, a2)
  dxDrawText(t, x + 1, y + 1, x2 + 1, y2 + 1, tocolor(0, 0, 0, 175), fs, f, a1, a2, true)
  dxDrawText(t, x, y, x2, y2, c, fs, f, a1, a2, true)
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
function studentCarCollision(collider, damageImpulseMag)
  if 200 < damageImpulseMag then
    endExam()
    sightexports.sGui:showInfobox("e", "Megbuktál, mivel összetörted az autót!")
    triggerServerEvent("endStudentDriverExam", localPlayer)
  elseif 30 < damageImpulseMag and getTickCount() - lastCollision > 2000 then
    lastCollision = getTickCount()
    warningNum = warningNum + 1
  end
end
local lastTraffiHit = 0
function traffiIssueWarning()
  if isElement(playerVehicle) then
    lastTraffiHit = getTickCount()
    warningNum = warningNum + 1
    sightexports.sGui:showInfobox("w", "Bemért egy traffipax, így figyelmeztetésben részesültél!")
  end
end
addEvent("issueTraffipaxWarning", true)
function renderStudentDriver()
  if isElement(playerVehicle) then
    local now = getTickCount()
    local delta = now - lastFrame
    lastFrame = now
    if tasks[currentTask] or nextTask then
      local w1, w2 = 0, 0
      local padd = 0
      if tasks[currentTask] then
        padd = 12
        w1 = dxGetTextWidth(tasks[currentTask].task, titleFontScale, titleFont)
        w2 = dxGetTextWidth(tasks[currentTask].description, descriptionFontScale, descriptionFont)
      end
      local p = 1
      if taskAnim then
        p = (now - taskAnim) / 1000
        if 1.5 < p then
          p = 2.5 - p
        elseif 1 < p then
          p = 1
          currentTask = nextTask
        end
        if p < 0 then
          p = 0
          taskAnim = false
        end
        p = 1 - getEasingValue(p, "InOutQuad")
      end
      local w = 64 + (padd + math.max(w1, w2)) * p
      local x, y = screenX / 2 - w / 2, screenY - 128 - 64
      sightlangStaticImageUsed[0] = true
      if sightlangStaticImageToc[0] then
        processsightlangStaticImage[0]()
      end
      dxDrawImage(x, y, 64, 64, sightlangStaticImage[0], 0, 0, 0, tocolor(circleColor[1], circleColor[2], circleColor[3], 200))
      dxDrawText((currentTask or nextTask) .. "/" .. #tasks, x, y, x + 64, y + 64, tocolor(255, 255, 255), numberFontScale, numberFont, "center", "center")
      if p < 1 and 1 < nextTask then
        sightlangStaticImageUsed[0] = true
        if sightlangStaticImageToc[0] then
          processsightlangStaticImage[0]()
        end
        dxDrawImage(x, y, 64, 64, sightlangStaticImage[0], 0, 0, 0, tocolor(greenColor[1], greenColor[2], greenColor[3], 255 * (1 - p)))
        dxDrawImage(x + 32 - 24, y + 32 - 24, 48, 48, ":sGui/" .. check .. faTicks[check], 0, 0, 0, tocolor(255, 255, 255, 255 * (1 - p)))
      end
      if tasks[currentTask] then
        dxDrawTextEx(tasks[currentTask].task, x + 64 + 12, y, x + w, y + 32, tocolor(255, 255, 255), titleFontScale, titleFont, "left", "center")
        dxDrawTextEx(tasks[currentTask].description, x + 64 + 12, y + 32, x + w, y + 64, tocolor(255, 255, 255), descriptionFontScale, descriptionFont, "left", "center")
      end
    end
    local warnings = {}
    if warningNum >= maxWarnings then
      endExam()
      sightexports.sGui:showInfobox("e", "Megbuktál!")
      triggerServerEvent("endStudentDriverExam", localPlayer)
    else
      local speed = getVehicleSpeed(playerVehicle)
      if 0 < warningNum then
        table.insert(warnings, "Figyelmeztetések: " .. warningNum .. "/" .. maxWarnings)
      end
      if getTickCount() - lastCollision < 5000 then
        table.insert(warnings, "Koccanás")
      end
      if getTickCount() - lastTraffiHit < 5000 then
        table.insert(warnings, "Traffipax")
      end
      if speedingWarning < 0 then
        if speed < 50 then
          speedingWarning = 0
          if forceBrake then
            forceBrake = false
            sightexports.sSpeedo:toggleForceBrake(false)
          end
        else
          if not forceBrake then
            forceBrake = true
            sightexports.sSpeedo:toggleForceBrake(true)
          end
          table.insert(warnings, "Gyorshajtás (oktató beavatkozott)")
        end
      end
      if 130 < speed and 0 <= speedingWarning then
        table.insert(warnings, "Gyorshajtás")
        speedingWarning = speedingWarning + delta * (1 + (speed - 130) / 75)
        if 2500 < speedingWarning then
          speedingWarning = -1
          warningNum = warningNum + 1
        end
      elseif 0 < speedingWarning then
        speedingWarning = speedingWarning - delta
        if speedingWarning < 0 then
          speedingWarning = 0
        end
      end
      local x, y, z = getElementPosition(playerVehicle)
      local hit, hx, hy, hz, he, nx, ny, nz, mat = processLineOfSight(x, y, z, x, y, z - 10, true, false, false, true, false)
      if mat and 3 < mat then
        table.insert(warnings, "Úttest elhagyása")
        if 0 <= offGroundLevel then
          offGroundLevel = offGroundLevel + delta
        end
        if 250 < offGroundLevel then
          warningNum = warningNum + 1
          offGroundLevel = -1
        end
        offGround = now
      elseif now - offGround < 1000 then
        table.insert(warnings, "Úttest elhagyása")
        offGroundLevel = 0
      end
      if 1 <= #warnings then
        local warningText = table.concat(warnings, ", ")
        local w = 44 + dxGetTextWidth(warningText, titleFontScale, titleFont)
        local x, y = screenX / 2 - w / 2, screenY - 128 - 64 - 48
        sightlangStaticImageUsed[0] = true
        if sightlangStaticImageToc[0] then
          processsightlangStaticImage[0]()
        end
        dxDrawImage(x, y, 32, 32, sightlangStaticImage[0], 0, 0, 0, tocolor(redColor[1], redColor[2], redColor[3], 200))
        dxDrawImage(x + 16 - 12, y + 16 - 12, 24, 24, ":sGui/" .. exclamation .. faTicks[exclamation], 0, 0, 0, tocolor(255, 255, 255, 255))
        dxDrawTextEx(warningText, x + 32 + 12, y, x + w, y + 32, tocolor(255, 255, 255), titleFontScale, titleFont, "left", "center")
      end
    end
  end
end
function shuffleTable(t)
  local rand = math.random
  local iterations = #t
  local j
  for i = iterations, 2, -1 do
    j = rand(i)
    t[i], t[j] = t[j], t[i]
  end
  return t
end
local questionWindow = false
local questionFont = "15/BebasNeueBold.otf"
local answerFont = "14/BebasNeueRegular.otf"
local answerButtons = {}
local pad = 8
local currentQuestion = false
local questionCount = false
local questionNum = 20
local passedQuestions = false
addEvent("nextDrivingStudentQuestion", false)
addEventHandler("nextDrivingStudentQuestion", getRootElement(), function()
  nextQuestion()
end)
addEvent("closeDrivingQuestionExamResult", false)
addEventHandler("closeDrivingQuestionExamResult", getRootElement(), function()
  if questionWindow then
    sightexports.sGui:deleteGuiElement(questionWindow)
  end
  questionWindow = false
  if currentQuestion then
    removeEventHandler("onClientElementDimensionChange", localPlayer, forceEndQuestionExam)
  end
  currentQuestion = false
  questionCount = false
  passedQuestions = false
end)
local instructorId = false
addEvent("tryToStartDrivingExam", false)
addEventHandler("tryToStartDrivingExam", getRootElement(), function()
  if instructorId then
    triggerServerEvent("tryToStartDrivingExam", localPlayer, instructorId)
    if questionWindow then
      sightexports.sGui:deleteGuiElement(questionWindow)
    end
    questionWindow = false
    currentQuestion = false
    questionCount = false
    passedQuestions = false
  end
end)
addEvent("tryToStartDrivingQuestionExam", false)
addEventHandler("tryToStartDrivingQuestionExam", getRootElement(), function()
  triggerServerEvent("tryToStartDrivingQuestionExam", localPlayer)
  if questionWindow then
    sightexports.sGui:deleteGuiElement(questionWindow)
  end
  questionWindow = false
  if currentQuestion then
    removeEventHandler("onClientElementDimensionChange", localPlayer, forceEndQuestionExam)
  end
  currentQuestion = false
  questionCount = false
  passedQuestions = false
end)
function createExamResult()
  if questionWindow then
    sightexports.sGui:deleteGuiElement(questionWindow)
  end
  local titleBarHeight = sightexports.sGui:getTitleBarHeight()
  local pw, ph = 400, titleBarHeight + 48 + 160
  questionWindow = sightexports.sGui:createGuiElement("window", screenX / 2 - pw / 2, screenY / 2 - ph / 2, pw, ph)
  sightexports.sGui:setWindowTitle(questionWindow, "16/BebasNeueRegular.otf", "Kresz vizsga")
  sightexports.sGui:setWindowCloseButton(questionWindow, "closeDrivingQuestionExamResult")
  local label = sightexports.sGui:createGuiElement("label", 0, titleBarHeight, pw, 48, questionWindow)
  sightexports.sGui:setLabelAlignment(label, "center", "center")
  sightexports.sGui:setLabelFont(label, questionFont)
  local label2 = sightexports.sGui:createGuiElement("label", 0, titleBarHeight + 48, pw, 160, questionWindow)
  sightexports.sGui:setLabelAlignment(label2, "center", "center")
  sightexports.sGui:setLabelFont(label2, answerFont)
  if 0.85 <= passedQuestions / questionNum then
    sightexports.sGui:setLabelColor(label, "sightgreen")
    sightexports.sGui:setLabelText(label, "Gratulálunk!")
    sightexports.sGui:setLabelText(label2, "Sikerült a KRESZ vizsgád!\n\nEredményed: [color=sightgreen]" .. passedQuestions .. "/" .. questionNum .. " (" .. math.floor(passedQuestions / questionNum * 100) .. "%)\n\n#ffffffMegkezdheted a gyakorlati vizsgát az oktatónál.")
    playSound("files/pipa.wav")
  else
    sightexports.sGui:setLabelColor(label, "sightred")
    sightexports.sGui:setLabelText(label, "Megbuktál!")
    sightexports.sGui:setLabelText(label2, "Nem sikerült a KRESZ vizsgád!\n\nEredményed: [color=sightred]" .. passedQuestions .. "/" .. questionNum .. " (" .. math.floor(passedQuestions / questionNum * 100) .. "%), 85% elérése szükséges\n\n#ffffffÚjrapróbálhatod a vizsgát az elméleti oktatónál.")
    playSound("files/error.wav")
  end
end
addEvent("clickDrivingStudentQuestionAnswer", false)
addEventHandler("clickDrivingStudentQuestionAnswer", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  for btn, correct in pairs(answerButtons) do
    local col = correct and "sightgreen" or "sightred"
    sightexports.sGui:setGuiBackground(btn, "solid", col)
    sightexports.sGui:setGuiHoverable(btn, false)
    sightexports.sGui:setClickEvent(btn, false)
    if el ~= btn then
      sightexports.sGui:setGuiBackgroundAlpha(btn, 0.25)
      sightexports.sGui:setButtonTextColor(btn, "sightlightgrey")
    end
  end
  if answerButtons[el] then
    passedQuestions = passedQuestions + 1
    playSound("files/pipa.wav")
  else
    playSound("files/error.wav")
  end
  local pw, ph = sightexports.sGui:getGuiSize(questionWindow)
  sightexports.sGui:setGuiSize(questionWindow, false, ph + pad + 30 + pad)
  local border = sightexports.sGui:createGuiElement("hr", pad, ph - 1, pw - pad * 2, 2, questionWindow)
  if questionCount < questionNum then
    local btn = sightexports.sGui:createGuiElement("button", pad, ph + pad, pw - pad * 2, 30, questionWindow)
    sightexports.sGui:setGuiBackground(btn, "solid", "sightblue")
    sightexports.sGui:setGuiHover(btn, "gradient", {
      "sightblue",
      "sightblue-second"
    }, false, true)
    sightexports.sGui:setButtonFont(btn, answerFont)
    sightexports.sGui:setButtonTextColor(btn, "#ffffff")
    sightexports.sGui:setButtonText(btn, "Következő kérdés")
    sightexports.sGui:setClickEvent(btn, "nextDrivingStudentQuestion")
  else
    local btn = sightexports.sGui:createGuiElement("button", pad, ph + pad, pw - pad * 2, 30, questionWindow)
    sightexports.sGui:setGuiBackground(btn, "solid", "sightblue")
    sightexports.sGui:setGuiHover(btn, "gradient", {
      "sightblue",
      "sightblue-second"
    }, false, true)
    sightexports.sGui:setButtonFont(btn, answerFont)
    sightexports.sGui:setButtonTextColor(btn, "#ffffff")
    sightexports.sGui:setButtonText(btn, "Vizsga befejezése")
    sightexports.sGui:setClickEvent(btn, "nextDrivingStudentQuestion")
  end
end)
function createQuestion(data)
  if questionWindow then
    sightexports.sGui:deleteGuiElement(questionWindow)
  end
  local titleBarHeight = sightexports.sGui:getTitleBarHeight()
  local correctAnswer = data.answers[1]
  data.answers = shuffleTable(data.answers)
  local pw = 350
  for i = 1, #data.answers do
    local aw = sightexports.sGui:getTextWidthFont(data.answers[i], answerFont) + pad * 2 * 3
    pw = math.max(pw, aw)
  end
  local ph = titleBarHeight + pad * 2 + (30 + pad) * #data.answers + pad
  local dat = split(data.question, " ")
  data.question = {}
  local iw, ih = 0, 0
  if data.image then
    local mat = dynamicImage("files/" .. data.image)
    local sx, sy = dxGetMaterialSize(mat)
    ih = (30 + pad) * #data.answers
    iw = (ih - pad) * (sx / sy) + pad
    pw = pw + iw
  end
  local q = ""
  for i = 1, #dat do
    if sightexports.sGui:getTextWidthFont(q .. " " .. dat[i], questionFont) > pw - pad * 2 then
      table.insert(data.question, q)
      q = dat[i]
    else
      q = q .. " " .. dat[i]
    end
  end
  table.insert(data.question, q)
  local h = sightexports.sGui:getFontHeight(questionFont)
  ph = ph + h * #data.question
  questionWindow = sightexports.sGui:createGuiElement("window", screenX / 2 - pw / 2, screenY / 2 - ph / 2, pw, ph)
  sightexports.sGui:setWindowTitle(questionWindow, "16/BebasNeueRegular.otf", "Kresz vizsga - Kérdés " .. questionCount .. "/" .. questionNum)
  if data.image then
    local image = sightexports.sGui:createGuiElement("image", pw - iw, titleBarHeight + pad + h * #data.question + pad * 2, iw - pad, ih - pad, questionWindow)
    sightexports.sGui:setImageDDS(image, ":sStudentdriver/files/" .. data.image)
  end
  local y = titleBarHeight + pad
  for i = 1, #data.question do
    local label = sightexports.sGui:createGuiElement("label", 0, y, pw, h, questionWindow)
    sightexports.sGui:setLabelAlignment(label, "center", "center")
    sightexports.sGui:setLabelText(label, data.question[i])
    sightexports.sGui:setLabelFont(label, questionFont)
    y = y + h
  end
  answerButtons = {}
  y = y + pad * 2
  for i = 1, #data.answers do
    local btn = sightexports.sGui:createGuiElement("button", pad, y, pw - pad * 2 - iw, 30, questionWindow)
    sightexports.sGui:setGuiBackground(btn, "solid", "sightblue")
    sightexports.sGui:setGuiHover(btn, "gradient", {
      "sightblue",
      "sightblue-second"
    }, false, true)
    sightexports.sGui:setButtonFont(btn, answerFont)
    sightexports.sGui:setButtonTextColor(btn, "#ffffff")
    sightexports.sGui:setButtonText(btn, data.answers[i])
    sightexports.sGui:setClickEvent(btn, "clickDrivingStudentQuestionAnswer")
    answerButtons[btn] = data.answers[i] == correctAnswer
    y = y + 30 + pad
  end
end
local questions = {
  {
    question = "Mit jelent az elsőbbség fogalma?",
    answers = {
      "Továbbhaladási jogot a közlekedés más résztvevőjével szemben",
      "Továbbhaladási lehetőséget",
      "A továbbhaladás akadálytalanságát",
      "A közúti járművek hierarchiájában elfoglalt helyet"
    }
  },
  {
    question = "Az alábbiak közül mi minősül úttestnek?",
    answers = {
      "Az útnak a közúti járművek közlekedésére szolgáló része",
      "Az útnak az a része, amely szilárd útburkolattal van ellátva",
      "Az útnak a kátyúmentes része"
    }
  },
  {
    question = "Szabad-e a közlekedés hatósági ellenőrzését megakadályozni?",
    answers = {
      "Nem",
      "Nem, csak befolyásolni szabad",
      "Nem, csak megzavarni szabad",
      "Igen, ha nem értünk egyet az ellenőrzéssel"
    }
  },
  {
    question = "Vezethet-e a járművet az, akit a jármű vezetésétől eltiltottak?",
    answers = {
      "Nem",
      "Igen, ha a vezetői engedélyt a rendőr nem vette el",
      "Igen, amíg a vezetői engedélyt nem kell leadnia",
      "Igen, de csak a saját járművét",
      "Igen, de csak San Fierro területén"
    }
  },
  {
    question = "Aki a közúti közlekedésben részt vesz, ...",
    answers = {
      "köteles a közúti jelzések rendelkezéseinek eleget tenni",
      "annak célszerű a közúti jelzések rendelkezéseinek eleget tenni",
      "saját belátása szerint dönthet a közúti jelzések rendelkezéseiről"
    }
  },
  {
    question = "Szabad-e olyan járművel részt venni a közlekedésben, amely nem rendelkezik a érvényes forgalmi engedéllyel?",
    answers = {
      "Nem",
      "Csak ideiglenesen, amíg a hiányt pótolják",
      "Igen, de csak motorkerékpárral",
      "Igen, de csak Angel Pine területén"
    }
  },
  {
    question = "Köteles-e a járművezető a rendvédelem utasításainak eleget tenni?",
    answers = {
      "Igen",
      "Nem",
      "Csak akkor, ha Őrmester is van a helyszínen"
    }
  },
  {
    question = "Mi a járművezető kötelessége, ha a rendőr jelzései ellentétesek valamely közúti jelzéssel?",
    answers = {
      "A rendőr jelzései szerint köteles eljárni",
      "Az egyéb közúti jelzés szerint köteles eljárni",
      "Csakis a vezérezredes utasításai szerint köteles eljárni"
    }
  },
  {
    question = "Mit jelent a fényjelző készülék ábrázolt fényjelzése?",
    image = "1.dds",
    answers = {
      "Szabad utat jelez, a vonatkozó szabályok betartásával tovább szabad haladni",
      "Csak egyenesen szabad továbbhaladni",
      "Piros fényjelzés következik"
    }
  },
  {
    question = "Az alábbiak közül mire kötelezi ez a jelzőtábla?",
    image = "2.dds",
    answers = {
      "Megállással történő elsőbbségadásra",
      "Megállás nélküli elsőbbségadásra",
      "Az autó motorjának leállítására"
    }
  },
  {
    question = "Mire kötelezi ez a jelzőtábla?",
    image = "3.dds",
    answers = {
      "Elsőbbséget kell adnia a keresztező (betorkolló) úton érkező járművek részére",
      "Elsőbbséget kell adnia a figyelmeztető jelzést használó járművek részére",
      "Kötelező megállásra"
    }
  },
  {
    question = "Mi a jelzőtábla jelentése?",
    image = "4.dds",
    answers = {
      "'Kötelező haladási irány'",
      "'Egyirányú forgalmú út'",
      "'Terelőút'"
    }
  },
  {
    question = "Mi a jelzőtábla jelentése?",
    image = "5.dds",
    answers = {
      "'Kijelölt gyalogos-átkelőhely'",
      "'Mozgólépcső'",
      "'Gyalogos alul- vagy felüljáró'"
    }
  },
  {
    question = "Mi a jelzőtábla jelentése?",
    image = "6.dds",
    answers = {
      "'Autóbusz-megállóhely'",
      "'Trolibusz-megállóhely'",
      "'Villamos-megállóhely'"
    }
  },
  {
    question = "Folytathatja-e az útját, ha az ábrán látható, félig leengedett sorompórúd alatt még átfér a járművével?",
    image = "7.dds",
    answers = {
      "Nem",
      "Igen, ha nem érkezik vasúti jármű",
      "Igen, de csak ha a járműve venom tuninggal rendelkezik",
      "Igen, de csak nappal",
      "Igen, de csak San Fierro területén"
    }
  },
  {
    question = "Az úttest széléről elinduló jármű vezetője ...",
    answers = {
      "köteles az úttesten haladók részére elsőbbséget adni",
      "köteles az úttesten haladók zavarásától tartózkodni",
      "csak padlógázzal indulhat el"
    }
  },
  {
    question = "Köteles-e irányjelzéssel jelezni az úttest széléről történő történő elindulást?",
    answers = {
      "Igen, minden esetben",
      "Nem"
    }
  },
  {
    question = "Az 'A' jelű jármű vezetője köteles-e lehetővé tenni a 'B' jelű autóbusz buszmegállóból történő elindulását lakott területen kívül?",
    image = "8.dds",
    answers = {
      "Nem",
      "Igen",
      "Igen, de csak akkor, ha ez hirtelen fékezés nélkül megtehető",
      "Igen, de csak akkor, ha a 'B' jelű busz turistabusz",
      "Igen, kivéve ha a buszvezető hangjelzést ad"
    }
  },
  {
    question = "Lakott területen ezt a közúti jelzőtáblát látja. Mekkora sebességgel szabad közlekednie?",
    image = "9.dds",
    answers = {
      "Legfeljebb 80 km/h sebességgel",
      "Legfeljebb 50 km/h sebességgel",
      "Legfeljebb 30 km/h sebességgel"
    }
  },
  {
    question = "Egyéb jelzés hiányában mekkora sebességgel szabad közlekedni személygépkocsival lakott területen kívüli főútvonalon?",
    answers = {
      "Legfeljebb 90 km/h sebességgel",
      "Legfeljebb 100 km/h sebességgel",
      "Legfeljebb 110 km/h sebességgel"
    }
  },
  {
    question = "Egyéb jelzés hiányában mekkora sebességgel szabad közlekedni személygépkocsival autópályán?",
    answers = {
      "Legfeljebb 130 km/h sebességgel",
      "Legfeljebb 110 km/h sebességgel",
      "Legfeljebb 150 km/h sebességgel"
    }
  },
  {
    question = "Az alábbiakban felsorolt esetek közül kinek köteles Ön elsőbbséget adni, ha egy egyenrangú útkereszteződéshez érve járművével balra kanyarodik?",
    answers = {
      "A szemből érkező, egyenesen továbbhaladó jármű részére",
      "Senkinek sem",
      "BMW típusú személygépjárműveknek"
    }
  },
  {
    question = "A képen látható helyen melyik jármű haladhat tovább elsőként?",
    image = "10.dds",
    answers = {
      "A '2'-es jelű személygépkocsi",
      "Az '1'-es jelű személygépkocsi",
      "Kölcsönös megegyezés alapján haladhatnak tovább",
      "Amelyik gyorsabb",
      "Amelyik venom tuninggal felszerelt"
    }
  },
  {
    question = "Szabad-e vasúti átjáróban járművel megfordulni?",
    answers = {"Nem", "Igen"}
  },
  {
    question = "Szabad-e előzni, ha az előzés a szembejövő forgalmat zavarja?",
    answers = {"Nem", "Igen"}
  },
  {
    question = "Szabad-e előzni, ha az előzni kívánó jármű előzését már egy másik jármű megkezdte?",
    answers = {"Nem", "Igen"}
  },
  {
    question = "Szabad-e előzni, ha a megelőzni kívánt jármű előzési szándékot jelzett?",
    answers = {"Nem", "Igen"}
  },
  {
    question = "Szabad-e előzni be nem látható útkanyarulatban?",
    answers = {
      "Általában nem",
      "Igen"
    }
  },
  {
    question = "Az alábbi helyzetben melyik jármű haladhat tovább másodikként?",
    image = "11.dds",
    answers = {
      "Az '1'-es jelű jármű",
      "Az '2'-es jelű jármű",
      "Amelyikük hangjelzést ad",
      "Amelyik gyorsabb",
      "Amelyik több venom tuninggal felszerelt"
    }
  },
  {
    question = "Elszállíthatják-e azt a személygépkocsit, amely a képen látható táblával jelölt helyen, jogosulatlanul várakozik?",
    image = "12.dds",
    answers = {
      "Igen",
      "Nem",
      "Csak nappal"
    }
  },
  {
    question = "Köteles-e járművével azonnal megállni, ha a közlekedés során érintett egy közúti balesetben?",
    answers = {"Igen", "Nem"}
  },
  {
    question = "Utazhat-e emelve vontatott személygépkocsiban utasként?",
    answers = {"Nem", "Igen"}
  },
  {
    question = "Hogyan szabad közlekedni, ha személygépkocsit vontat?",
    answers = {
      "Fokozott óvatossággal, csökkentett sebességgel",
      "Bárhogy",
      "Lehetőleg minél nagyobb sebességgel",
      "Attól függ, hogy a vontató fel van-e szerelve venom tuninggal"
    }
  },
  {
    question = "Az ábrán látható útkereszteződésben melyik jármű haladhat tovább elsőként?",
    image = "13.dds",
    answers = {
      "A '2'-es jelű",
      "Az '1'-es jelű",
      "A '3'-as jelű",
      "Kölcsönös megegyezés alapján",
      "Amelyik gyorsabb"
    }
  },
  {
    question = "Az ábrán látható útkereszteződésben melyik jármű haladhat tovább elsőként?",
    image = "14.dds",
    answers = {
      "A '2'-es jelű", 
      "Az '1'-es jelű",
      "A '3'-as jelű",
      "Kölcsönös megegyezés alapján",
      "Amelyik gyorsabb"
    }
  },
  {
    question = "Az ábrán látható útkereszteződésben melyik jármű haladhat tovább elsőként?",
    image = "15.dds",
    answers = {
      "A '2'-es jelű",
      "Az '1'-es jelű",
      "A '3'-as jelű",
      "Kölcsönös megegyezés alapján",
      "Amelyik gyorsabb"
    }
  },
  {
    question = "Az ábrán látható útkereszteződésben melyik jármű haladhat tovább elsőként?",
    image = "16.dds",
    answers = {
      "Az '1'-es jelű",
      "A '2'-es jelű",
      "A '3'-as jelű",
      "Kölcsönös megegyezés alapján",
      "Amelyik gyorsabb"
    }
  },
  {
    question = "Az ábrán látható útkereszteződésben melyik jármű haladhat tovább elsőként?",
    image = "17.dds",
    answers = {
      "Az '1'-es jelű",
      "Az ön járműve",
      "Kölcsönös megegyezés alapján",
      "Amelyik gyorsabb"
    }
  },
  {
    question = "Az ábrán látható útkereszteződésben melyik jármű haladhat tovább elsőként?",
    image = "18.dds",
    answers = {
      "A '2'-es jelű",
      "Az ön járműve",
      "Kölcsönös megegyezés alapján",
      "Amelyik gyorsabb",
      "Az '1'-es jelű"
    }
  },
  {
    question = "Szabad-e menet közben a kéziféket használni?",
    answers = {
      "Nem, csak megálláskor szabad használni",
      "Csakis driftre épített autóban",
      "Igen"
    }
  },
  {
    question = "Mit jelent, ha a képen látható visszajelző lámpa pirosan világít?",
    image = "20.dds",
    answers = {
      "A kézifék behúzott állapotára figyelmeztet",
      "Túl alacsony valamelyik gumiabroncs levegőnyomása",
      "Túl magas valamelyik gumiabroncs levegőnyomása"
    }
  },
  {
    question = "Mit jelent a képen látható visszajelző lámpa pirosan világít?",
    image = "21.dds",
    answers = {
      "A jármű akkumulátorfeszültsége alacsony",
      "A rádió túl halk",
      "Az akkumulátor fel van töltve"
    }
  },
  {
    question = "Mit jelent a képen látható visszajelző lámpa pirosan világít?",
    image = "19.dds",
    answers = {
      "A jármű üzemanyagszintje alacsony",
      "A járműbe olcsó üzemanyag lett tankolva",
      "A jármű üzemanyaga fel lett vizezve"
    }
  },
  {
    question = "Milyen fokozatokat, illetve programokat jelölnek a sebességváltó 'P', 'R', 'N', 'D' állásai?",
    answers = {
      "'P' - parkolás, 'R' - hátramenet, 'N' - üres fokozat, 'D' - előremenet",
      "'P' - parkolás, 'R' - rakéta, 'N' - normál, 'D' - távolsági",
      "'P' - terepfokozat, 'R' - versenyfokozat, 'N' - normál, 'D' - domb fokozat"
    }
  },
  {
    question = "Szabad-e akadályozni az előzés végrehajtását?",
    answers = {
      "Nem",
      "Igen, balra húzódással",
      "Igen, a sebesség fokozásával"
    }
  },
  {
    question = "Szabad-e autópályán járművel megfordulni?",
    answers = {
      "Nem",
      "Igen, lassú forgalom esetén",
      "Kizárólag kézifék segítségével"
    }
  },
  {
    question = "Hogyan szabad megközelíteni a vasúti átjárót?",
    answers = {
      "Fokozott óvatossággal",
      "Minél gyorsabban, hogy átérjünk a vonat előtt"
    }
  },
  {
    question = "Mi a járművezető teendője vasúti átjáró előtt, ha bármely irányból vasúti jármű közeledik?",
    answers = {
      "Meg kell állnia",
      "Gyorsan át kell haladnia",
      "Hangjelzést kell adnia a vasúti jármű vezetője számára"
    }
  },
  {
    question = "Mi a járművezető teendője vasúti átjáró előtt, ha a fénysorompó villogó piros jelzést ad?",
    answers = {
      "Meg kell állnia",
      "Gyorsan át kell haladnia",
      "Ha nem közeledik vasúti jármű, kellő körültekintés után áthaladhat"
    }
  },
  {
    question = "Kell-e a megállást - ide nem értve a forgalmi okból történő megállást - irányjelzéssel jelezni?",
    answers = {
      "Igen",
      "Nem",
      "Csak akkor, ha rendőr van a közelben"
    }
  },
  {
    question = "Hogyan kell elsőbbséget adni a megkülönböztető jelzéseit használó gépjármű részére?",
    answers = {
      "Félrehúzódással, szükség esetén megállással",
      "Nem kell elsőbbséget adni",
      "Gyorsítással"
    }
  },
  {
    question = "A járművezetés tanulása során a tanulónak kötelező-e bekapcsolnia a biztonsági övet?",
    answers = {
      "Igen",
      "Nem",
      "Csak lakott területen kívül"
    }
  },
  {
    question = "Ki kell-e világítani éjszaka és korlátozott látási viszonyok között a vontatott személygépkocsit?",
    answers = {
      "Igen, lehetőség szerint",
      "Nem"
    }
  },
  {
    question = "Általában mik a balesetek kialakulásának főbb okai?",
    answers = {
      "Gyorshajtás, elsőbbség meg nem adása, kanyarodási szabály megszegése",
      "Túlzott előzékenység",
      "Túlzott venom tuning felszereltség"
    }
  }
}
function nextQuestion()
  if questionCount < questionNum then
    currentQuestion = currentQuestion + 1
    questionCount = questionCount + 1
    local answers = {}
    if 10 <= questionCount and not questions[currentQuestion].image then
      for i = currentQuestion + 1, #questions do
        if questions[i].image then
          currentQuestion = i
          break
        end
      end
    end
    for i = 1, #questions[currentQuestion].answers do
      table.insert(answers, questions[currentQuestion].answers[i])
    end
    createQuestion({
      question = questions[currentQuestion].question,
      image = questions[currentQuestion].image,
      answers = answers
    })
  else
    triggerServerEvent("drivingQuestionExamResult", localPlayer, 0.85 <= passedQuestions / questionNum)
    if currentQuestion then
      removeEventHandler("onClientElementDimensionChange", localPlayer, forceEndQuestionExam)
    end
    currentQuestion = false
    createExamResult()
  end
end
function forceEndQuestionExam()
  triggerServerEvent("drivingQuestionExamResult", localPlayer, false)
  if questionWindow then
    sightexports.sGui:deleteGuiElement(questionWindow)
  end
  questionWindow = false
  if currentQuestion then
    removeEventHandler("onClientElementDimensionChange", localPlayer, forceEndQuestionExam)
  end
  currentQuestion = false
  questionCount = false
  passedQuestions = false
end
addEvent("startDrivingQuestionExam", true)
addEventHandler("startDrivingQuestionExam", getRootElement(), function()
  if not currentQuestion then
    addEventHandler("onClientElementDimensionChange", localPlayer, forceEndQuestionExam)
  end
  currentQuestion = 0
  questionCount = 0
  passedQuestions = 0
  shuffleTable(questions)
  nextQuestion()
end)
local testPeds = {}
local instructorPeds = {}
function createInstructors()
  local ped = createPed(133, 1490.71484375, 1308.9609375, 1093.2890625, 180)
  testPeds[ped] = true
  setElementInterior(ped, 3)
  setElementDimension(ped, 78)
  setElementData(ped, "visibleName", "Instructor Tiborius")
  setElementData(ped, "invulnerable", true)
  setElementData(ped, "pedNameType", "Elméleti oktató - KRESZ vizsga")
  setPedAnimation(ped, "COP_AMBIENT", "Coplook_think", -1, true, false, false)
  local ped = createPed(59, 1489.033203125, 1305.599609375, 1093.2963867188, 270)
  testPeds[ped] = true
  setElementInterior(ped, 3)
  setElementDimension(ped, 78)
  setElementData(ped, "visibleName", "Drive Richard")
  setElementData(ped, "invulnerable", true)
  setElementData(ped, "pedNameType", "Elméleti oktató - KRESZ vizsga")
  setPedAnimation(ped, "COP_AMBIENT", "Coplook_loop", -1, true, false, false)
  for i = 1, #instructors do
    local ped = createPed(instructors[i].skin, instructors[i].pos[1], instructors[i].pos[2], instructors[i].pos[3], instructors[i].pos[4])
    setElementInterior(ped, instructors[i].pos[5])
    setElementDimension(ped, instructors[i].pos[6])
    instructorPeds[ped] = i
    setElementData(ped, "visibleName", instructors[i].name)
    setElementData(ped, "invulnerable", true)
    setElementData(ped, "pedNameType", "Oktató - " .. sightexports.sVehiclenames:getCustomVehicleName(instructors[i].vehicle))
    setPedAnimation(ped, instructors[i].anim[1], instructors[i].anim[2], -1, true, false, false)
  end
end
addEventHandler("onClientClick", getRootElement(), function(button, state, absoluteX, absoluteY, worldX, worldY, worldZ, clickedElement)
  if state == "down" and not questionWindow and not currentQuestion and not playerVehicle then
    if instructorPeds[clickedElement] then
      instructorId = instructorPeds[clickedElement]
      local titleBarHeight = sightexports.sGui:getTitleBarHeight()
      local pw, ph = 400, titleBarHeight + 64 + pad + 30 + pad
      questionWindow = sightexports.sGui:createGuiElement("window", screenX / 2 - pw / 2, screenY / 2 - ph / 2, pw, ph)
      sightexports.sGui:setWindowTitle(questionWindow, "16/BebasNeueRegular.otf", "Gyakorlati vizsga")
      local label = sightexports.sGui:createGuiElement("label", 0, titleBarHeight, pw, 32, questionWindow)
      sightexports.sGui:setLabelAlignment(label, "center", "center")
      sightexports.sGui:setLabelFont(label, questionFont)
      local label2 = sightexports.sGui:createGuiElement("label", 0, titleBarHeight + 32, pw, 32, questionWindow)
      sightexports.sGui:setLabelAlignment(label2, "center", "center")
      sightexports.sGui:setLabelFont(label2, answerFont)
      sightexports.sGui:setLabelText(label, "Biztosan szeretnéd elkezdeni a vizsgát?")
      sightexports.sGui:setLabelText(label2, "A vizsga ára: [color=sightgreen]" .. sightexports.sGui:thousandsStepper(examPrice2) .. " $")
      local btn = sightexports.sGui:createGuiElement("button", pad, ph - 30 - pad, (pw - pad * 3) / 2, 30, questionWindow)
      sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
      sightexports.sGui:setGuiHover(btn, "gradient", {
        "sightgreen",
        "sightgreen-second"
      }, false, true)
      sightexports.sGui:setButtonFont(btn, answerFont)
      sightexports.sGui:setButtonTextColor(btn, "#ffffff")
      sightexports.sGui:setButtonText(btn, "Igen")
      sightexports.sGui:setClickEvent(btn, "tryToStartDrivingExam")
      local btn = sightexports.sGui:createGuiElement("button", (pw - pad * 3) / 2 + pad * 2, ph - 30 - pad, (pw - pad * 3) / 2, 30, questionWindow)
      sightexports.sGui:setGuiBackground(btn, "solid", "sightred")
      sightexports.sGui:setGuiHover(btn, "gradient", {
        "sightred",
        "sightred-second"
      }, false, true)
      sightexports.sGui:setButtonFont(btn, answerFont)
      sightexports.sGui:setButtonTextColor(btn, "#ffffff")
      sightexports.sGui:setButtonText(btn, "Nem")
      sightexports.sGui:setClickEvent(btn, "closeDrivingQuestionExamResult")
    elseif testPeds[clickedElement] then
      local titleBarHeight = sightexports.sGui:getTitleBarHeight()
      local pw, ph = 400, titleBarHeight + 64 + pad + 30 + pad
      questionWindow = sightexports.sGui:createGuiElement("window", screenX / 2 - pw / 2, screenY / 2 - ph / 2, pw, ph)
      sightexports.sGui:setWindowTitle(questionWindow, "16/BebasNeueRegular.otf", "Kresz vizsga")
      local label = sightexports.sGui:createGuiElement("label", 0, titleBarHeight, pw, 32, questionWindow)
      sightexports.sGui:setLabelAlignment(label, "center", "center")
      sightexports.sGui:setLabelFont(label, questionFont)
      local label2 = sightexports.sGui:createGuiElement("label", 0, titleBarHeight + 32, pw, 32, questionWindow)
      sightexports.sGui:setLabelAlignment(label2, "center", "center")
      sightexports.sGui:setLabelFont(label2, answerFont)
      sightexports.sGui:setLabelText(label, "Biztosan szeretnéd elkezdeni a vizsgát?")
      sightexports.sGui:setLabelText(label2, "A vizsga ára: [color=sightgreen]" .. sightexports.sGui:thousandsStepper(examPrice1) .. " $")
      local btn = sightexports.sGui:createGuiElement("button", pad, ph - 30 - pad, (pw - pad * 3) / 2, 30, questionWindow)
      sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
      sightexports.sGui:setGuiHover(btn, "gradient", {
        "sightgreen",
        "sightgreen-second"
      }, false, true)
      sightexports.sGui:setButtonFont(btn, answerFont)
      sightexports.sGui:setButtonTextColor(btn, "#ffffff")
      sightexports.sGui:setButtonText(btn, "Igen")
      sightexports.sGui:setClickEvent(btn, "tryToStartDrivingQuestionExam")
      local btn = sightexports.sGui:createGuiElement("button", (pw - pad * 3) / 2 + pad * 2, ph - 30 - pad, (pw - pad * 3) / 2, 30, questionWindow)
      sightexports.sGui:setGuiBackground(btn, "solid", "sightred")
      sightexports.sGui:setGuiHover(btn, "gradient", {
        "sightred",
        "sightred-second"
      }, false, true)
      sightexports.sGui:setButtonFont(btn, answerFont)
      sightexports.sGui:setButtonTextColor(btn, "#ffffff")
      sightexports.sGui:setButtonText(btn, "Nem")
      sightexports.sGui:setClickEvent(btn, "closeDrivingQuestionExamResult")
    end
  end
end, true, "high+9999999")
local signPoses = {
  [458] = {
    0,
    -1.5,
    0.9
  },
  [561] = {
    0,
    -1.15,
    0.865
  },
  [550] = {
    0,
    -0.8,
    0.585
  }
}
local driverSigns = {}
addEventHandler("onClientElementDestroy", getRootElement(), function()
  if isElement(driverSigns[source]) then
    destroyElement(driverSigns[source])
  end
  driverSigns[source] = nil
end)
addEventHandler("onClientElementDataChange", getRootElement(), function(data)
  if data == "studentDriver" then
    local model = getElementModel(source)
    if signPoses[model] then
      if isElement(driverSigns[source]) then
        destroyElement(driverSigns[source])
      end
      driverSigns[source] = createObject(sightexports.sModloader:getModelId("student_sign"), 0, 0, 0)
      setElementCollisionsEnabled(driverSigns[source], false)
      attachElements(driverSigns[source], source, signPoses[model][1], signPoses[model][2], signPoses[model][3])
    end
  end
end)
local vehs = getElementsByType("vehicle")
for i = 1, #vehs do
  if getElementData(vehs[i], "studentDriver") then
    local model = getElementModel(vehs[i])
    if signPoses[model] then
      if isElement(driverSigns[vehs[i]]) then
        destroyElement(driverSigns[vehs[i]])
      end
      driverSigns[vehs[i]] = createObject(sightexports.sModloader:getModelId("student_sign"), 0, 0, 0)
      setElementCollisionsEnabled(driverSigns[vehs[i]], false)
      attachElements(driverSigns[vehs[i]], vehs[i], signPoses[model][1], signPoses[model][2], signPoses[model][3])
    end
  end
end
