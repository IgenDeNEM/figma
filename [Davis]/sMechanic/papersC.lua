local sightexports = {sGui = false, sChat = false}
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
local invoiceNames = {
  frontLeftPanel = "B.E. panel",
  frontRightPanel = "J.E. panel",
  rearLeftPanel = "B.E. panel",
  rearRightPanel = "J.E. panel",
  windscreen = "Szélvédő",
  frontBumper = "Első lökhárító",
  rearBumper = "Hátsó lökhárító",
  hood = "Motorháztető",
  trunk = "Csomagtartó",
  frontLeftDoor = "B.E. ajtó",
  frontRightDoor = "J.E. ajtó",
  rearLeftDoor = "B.H. ajtó",
  rearRightDoor = "J.H. ajtó",
  frontTires = "Nyári gumi (E)",
  rearTires = "Nyári gumi (H)",
  frontWinterTires = "Téli gumi (E)",
  rearWinterTires = "Téli gumi (H)",
  frontLeftLight = "B.E. fényszóró",
  frontRightLight = "J.E. fényszóró",
  rearLeftLight = "B.H. fényszóró",
  rearRightLight = "J.H. fényszóró",
  oilChangeKit = "Olajcsere",
  engineRepairKit = "Motor javítás",
  engineGeneralKit = "Motorgenerál",
  engineTimingKit = "Vezérlés",
  battery = "Akkumulátor",
  fuelRepairKit = "Üzemanyag r.",
  frontBrakes = "Első fék",
  rearBrakes = "Hátsó fék",
  frontLeftSuspension = "B.E. felfügg.",
  frontRightSuspension = "J.E. felfügg.",
  rearLeftSuspension = "B.H. felfügg.",
  rearRightSuspension = "J.H. felfügg.",
  immaterial1 = "Műszaki vizsga",
  immaterial2 = "Futómű beállítás",
  immaterial3 = "Állapotfelmérés",
  immaterial4 = "5 liter üzemanyag",
  immaterial5 = "Rádió fejegység"
}
local serviceInvoice = false
function deleteMechanicPaper()
  if serviceInvoice then
    sightexports.sGui:deleteGuiElement(serviceInvoice)
  end
  serviceInvoice = false
end
function createMechanicPaper(theType, data, page, pages, workshop, id, mechanic, customer, created, vehicleMake, vehicleModel, vehiclePlate, odometer)
  deleteMechanicPaper()
  workshop = workshops[workshop]
  serviceInvoice = sightexports.sGui:createGuiElement("null", screenX / 2 - 283, screenY / 2 - 400, 566, 800)
  if 1 < pages then
    local paper = sightexports.sGui:createGuiElement("image", -10, -32, 128, 128, serviceInvoice)
    sightexports.sGui:setImageDDS(paper, ":sMechanic/files/clip1.dds")
    sightexports.sGui:setImageColor(paper, {
      255,
      255,
      255,
      255
    })
    for i = 1, math.min(5, pages - 1) do
      local paper = sightexports.sGui:createGuiElement("image", 0, 0, 566, 800, serviceInvoice)
      sightexports.sGui:setImageDDS(paper, ":sMechanic/files/paper.dds")
      sightexports.sGui:setImageColor(paper, {
        200 + 40 / pages * i,
        200 + 40 / pages * i,
        200 + 40 / pages * i,
        255
      })
      sightexports.sGui:setImageRotation(paper, 0.75 * i)
    end
  end
  local rect = sightexports.sGui:createGuiElement("rectangle", 0, 0, 566, 800, serviceInvoice)
  sightexports.sGui:setGuiBackground(rect, "solid", "#ffffff")
  local paper = sightexports.sGui:createGuiElement("image", 0, 0, 566, 800, rect)
  sightexports.sGui:setImageDDS(paper, ":sMechanic/files/paper.dds")
  sightexports.sGui:setImageColor(paper, {
    255,
    255,
    255,
    175
  })
  local label = sightexports.sGui:createGuiElement("label", 27, 0, 512, 64, rect)
  sightexports.sGui:setLabelFont(label, "23/BebasNeueRegular.otf")
  if theType == "stock" then
    sightexports.sGui:setLabelText(label, "Készlethiány")
  elseif theType == "checkout" then
    sightexports.sGui:setLabelText(label, "Kasszazárás")
  elseif theType == "inspection" then
    sightexports.sGui:setLabelText(label, "Gépjármű műszaki állapota")
  elseif theType == "alignment" then
    sightexports.sGui:setLabelText(label, "Futómű beállítás")
  else
    sightexports.sGui:setLabelText(label, "Szerviz számla")
  end
  sightexports.sGui:setLabelColor(label, "#242424")
  sightexports.sGui:setLabelAlignment(label, "left", "center")
  for i = utf8.len(tostring(id)), 8 do
    id = "0" .. id
  end
  local label = sightexports.sGui:createGuiElement("label", 27, -12, 512, 64, rect)
  sightexports.sGui:setLabelFont(label, "17/BebasNeueRegular.otf")
  sightexports.sGui:setLabelText(label, (workshop and workshop[1] or "SCBM") .. "-" .. id)
  sightexports.sGui:setLabelColor(label, "#242424")
  sightexports.sGui:setLabelAlignment(label, "right", "center")
  local label = sightexports.sGui:createGuiElement("label", 27, 12, 512, 64, rect)
  sightexports.sGui:setLabelFont(label, "13/BebasNeueRegular.otf")
  sightexports.sGui:setLabelText(label, string.format("%04d. %02d. %02d. %02d:%02d", created.year + 1900, created.month + 1, created.monthday, created.hour, created.minute))
  sightexports.sGui:setLabelColor(label, "#242424")
  sightexports.sGui:setLabelAlignment(label, "right", "center")
  local line = sightexports.sGui:createGuiElement("rectangle", 27, 64, 512, 2, rect)
  sightexports.sGui:setGuiBackground(line, "solid", "#242424")
  local line = sightexports.sGui:createGuiElement("rectangle", 27, 64, 2, 132, rect)
  sightexports.sGui:setGuiBackground(line, "solid", "#242424")
  local line = sightexports.sGui:createGuiElement("rectangle", 282, 64, 2, 132, rect)
  sightexports.sGui:setGuiBackground(line, "solid", "#242424")
  local line = sightexports.sGui:createGuiElement("rectangle", 537, 64, 2, 132, rect)
  sightexports.sGui:setGuiBackground(line, "solid", "#242424")
  local line = sightexports.sGui:createGuiElement("rectangle", 27, 196, 512, 2, rect)
  sightexports.sGui:setGuiBackground(line, "solid", "#242424")
  local label = sightexports.sGui:createGuiElement("label", 35, 68, 566, 24, rect)
  sightexports.sGui:setLabelFont(label, "13/BebasNeueRegular.otf")
  sightexports.sGui:setLabelText(label, "Kiállító:")
  sightexports.sGui:setLabelColor(label, "#242424")
  sightexports.sGui:setLabelAlignment(label, "left", "center")
  local label = sightexports.sGui:createGuiElement("label", 35, 92, 566, 48, rect)
  sightexports.sGui:setLabelFont(label, "15/BebasNeueRegular.otf")
  if workshop then
    sightexports.sGui:setLabelText(label, workshop[2] .. "\n" .. mechanic)
  else
    sightexports.sGui:setLabelText(label, [[
Sight City
Bike Mechanic]])
  end
  sightexports.sGui:setLabelColor(label, "#242424")
  sightexports.sGui:setLabelAlignment(label, "left", "center")
  if customer then
    local label = sightexports.sGui:createGuiElement("label", 35, 144, 566, 24, rect)
    sightexports.sGui:setLabelFont(label, "13/BebasNeueRegular.otf")
    sightexports.sGui:setLabelText(label, "Ügyfél:")
    sightexports.sGui:setLabelColor(label, "#242424")
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    local label = sightexports.sGui:createGuiElement("label", 35, 168, 566, 24, rect)
    sightexports.sGui:setLabelFont(label, "13/BebasNeueRegular.otf")
    sightexports.sGui:setLabelText(label, customer)
    sightexports.sGui:setLabelColor(label, "#242424")
    sightexports.sGui:setLabelAlignment(label, "left", "center")
  end
  if theType == "stock" then
    local label = sightexports.sGui:createGuiElement("label", 291, 68, 566, 24, rect)
    sightexports.sGui:setLabelFont(label, "13/BebasNeueRegular.otf")
    sightexports.sGui:setLabelText(label, "Kiállítva:")
    sightexports.sGui:setLabelColor(label, "#242424")
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    local time = getRealTime(data[1])
    local label = sightexports.sGui:createGuiElement("label", 291, 92, 566, 24, rect)
    sightexports.sGui:setLabelFont(label, "13/BebasNeueRegular.otf")
    sightexports.sGui:setLabelText(label, string.format("%04d. %02d. %02d. %02d:%02d:%02d", time.year + 1900, time.month + 1, time.monthday, time.hour, time.minute, time.second))
    sightexports.sGui:setLabelColor(label, "#242424")
    sightexports.sGui:setLabelAlignment(label, "left", "center")
  elseif theType == "checkout" then
    local label = sightexports.sGui:createGuiElement("label", 291, 68, 566, 24, rect)
    sightexports.sGui:setLabelFont(label, "13/BebasNeueRegular.otf")
    sightexports.sGui:setLabelText(label, "Elszámolt időszak:")
    sightexports.sGui:setLabelColor(label, "#242424")
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    if data[1] > 0 then
      local time = getRealTime(data[1])
      local label = sightexports.sGui:createGuiElement("label", 291, 92, 566, 24, rect)
      sightexports.sGui:setLabelFont(label, "13/BebasNeueRegular.otf")
      sightexports.sGui:setLabelText(label, string.format("%04d. %02d. %02d. %02d:%02d:%02d", time.year + 1900, time.month + 1, time.monthday, time.hour, time.minute, time.second))
      sightexports.sGui:setLabelColor(label, "#242424")
      sightexports.sGui:setLabelAlignment(label, "left", "center")
    else
      local label = sightexports.sGui:createGuiElement("label", 291, 92, 566, 24, rect)
      sightexports.sGui:setLabelFont(label, "13/BebasNeueRegular.otf")
      sightexports.sGui:setLabelText(label, "-")
      sightexports.sGui:setLabelColor(label, "#242424")
      sightexports.sGui:setLabelAlignment(label, "left", "center")
    end
    local time = getRealTime(data[2])
    local label = sightexports.sGui:createGuiElement("label", 291, 116, 566, 24, rect)
    sightexports.sGui:setLabelFont(label, "13/BebasNeueRegular.otf")
    sightexports.sGui:setLabelText(label, string.format("%04d. %02d. %02d. %02d:%02d:%02d", time.year + 1900, time.month + 1, time.monthday, time.hour, time.minute, time.second))
    sightexports.sGui:setLabelColor(label, "#242424")
    sightexports.sGui:setLabelAlignment(label, "left", "center")
  else
    local label = sightexports.sGui:createGuiElement("label", 291, 68, 566, 24, rect)
    sightexports.sGui:setLabelFont(label, "13/BebasNeueRegular.otf")
    sightexports.sGui:setLabelText(label, "Gépjármű:")
    sightexports.sGui:setLabelColor(label, "#242424")
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    local label = sightexports.sGui:createGuiElement("label", 291, 92, 566, 48, rect)
    sightexports.sGui:setLabelFont(label, "15/BebasNeueRegular.otf")
    sightexports.sGui:setLabelText(label, vehicleMake .. "\n" .. vehicleModel)
    sightexports.sGui:setLabelColor(label, "#242424")
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    local label = sightexports.sGui:createGuiElement("label", 291, 144, 566, 24, rect)
    sightexports.sGui:setLabelFont(label, "13/BebasNeueRegular.otf")
    sightexports.sGui:setLabelText(label, "Forgalmi rendszám, rögzített km. állás:")
    sightexports.sGui:setLabelColor(label, "#242424")
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    local label = sightexports.sGui:createGuiElement("label", 291, 168, 566, 24, rect)
    sightexports.sGui:setLabelFont(label, "13/BebasNeueRegular.otf")
    sightexports.sGui:setLabelText(label, vehiclePlate .. ", " .. odometer .. " km")
    sightexports.sGui:setLabelColor(label, "#242424")
    sightexports.sGui:setLabelAlignment(label, "left", "center")
  end
  if theType == "stock" then
    local y = 228
    local h = 22
    local n = #data - 2
    local w = 56.888888888888886
    local line = sightexports.sGui:createGuiElement("rectangle", 27, y, 512, 2, rect)
    sightexports.sGui:setGuiBackground(line, "solid", "#242424")
    local line = sightexports.sGui:createGuiElement("rectangle", 27, y, 2, h * (n * 2 + 1), rect)
    sightexports.sGui:setGuiBackground(line, "solid", "#242424")
    local line = sightexports.sGui:createGuiElement("rectangle", 27 + w * 4, y, 2, h * (n * 2 + 1), rect)
    sightexports.sGui:setGuiBackground(line, "solid", "#242424")
    local line = sightexports.sGui:createGuiElement("rectangle", 27 + w * 8, y, 2, h * (n * 2 + 1), rect)
    sightexports.sGui:setGuiBackground(line, "solid", "#242424")
    local line = sightexports.sGui:createGuiElement("rectangle", 537, y, 2, h * (n * 2 + 1), rect)
    sightexports.sGui:setGuiBackground(line, "solid", "#242424")
    local label = sightexports.sGui:createGuiElement("label", 27, y, w * 4, h, rect)
    sightexports.sGui:setLabelFont(label, "13/BebasNeueRegular.otf")
    sightexports.sGui:setLabelText(label, "Alkatrész")
    sightexports.sGui:setLabelColor(label, "#242424")
    sightexports.sGui:setLabelAlignment(label, "center", "center")
    local label = sightexports.sGui:createGuiElement("label", 27 + w * 4, y, w * 4, h, rect)
    sightexports.sGui:setLabelFont(label, "13/BebasNeueRegular.otf")
    sightexports.sGui:setLabelText(label, "Jármű")
    sightexports.sGui:setLabelColor(label, "#242424")
    sightexports.sGui:setLabelAlignment(label, "center", "center")
    local label = sightexports.sGui:createGuiElement("label", 27 + w * 8, y, w, h, rect)
    sightexports.sGui:setLabelFont(label, "13/BebasNeueRegular.otf")
    sightexports.sGui:setLabelText(label, "Készlet")
    sightexports.sGui:setLabelColor(label, "#242424")
    sightexports.sGui:setLabelAlignment(label, "center", "center")
    y = y - h
    for i = 1, n do
      y = y + h * 2
      local label = sightexports.sGui:createGuiElement("label", 27, y, w * 4, h, rect)
      sightexports.sGui:setLabelFont(label, "9/Ubuntu-B.ttf")
      sightexports.sGui:setLabelText(label, data[i + 1][1])
      sightexports.sGui:setLabelColor(label, "#242424")
      sightexports.sGui:setLabelClip(label, true)
      sightexports.sGui:setLabelAlignment(label, "center", "center")
      if partBackwards[data[i + 1][1]] then
        local label = sightexports.sGui:createGuiElement("label", 27 + w * 4, y, w * 4, h, rect)
        sightexports.sGui:setLabelFont(label, "9/Ubuntu-B.ttf")
        sightexports.sGui:setLabelText(label, makeAndModel[partBackwards[data[i + 1][1]][1]][1])
        sightexports.sGui:setLabelColor(label, "#242424")
        sightexports.sGui:setLabelClip(label, true)
        sightexports.sGui:setLabelAlignment(label, "center", "center")
        local label = sightexports.sGui:createGuiElement("label", 27 + w * 4, y + h, w * 4, h, rect)
        sightexports.sGui:setLabelFont(label, "9/Ubuntu-B.ttf")
        sightexports.sGui:setLabelText(label, makeAndModel[partBackwards[data[i + 1][1]][1]][2])
        sightexports.sGui:setLabelColor(label, "#242424")
        sightexports.sGui:setLabelClip(label, true)
        sightexports.sGui:setLabelAlignment(label, "center", "center")
        local label = sightexports.sGui:createGuiElement("label", 27, y + h, w * 4, h, rect)
        sightexports.sGui:setLabelFont(label, "9/Ubuntu-B.ttf")
        sightexports.sGui:setLabelText(label, partTypes[partBackwards[data[i + 1][1]][3]].name)
        sightexports.sGui:setLabelColor(label, "#242424")
        sightexports.sGui:setLabelClip(label, true)
        sightexports.sGui:setLabelAlignment(label, "center", "center")
      end
      local label = sightexports.sGui:createGuiElement("label", 27 + w * 8, y, w, h * 2, rect)
      sightexports.sGui:setLabelFont(label, "9/Ubuntu-B.ttf")
      sightexports.sGui:setLabelText(label, data[i + 1][2])
      sightexports.sGui:setLabelColor(label, "#242424")
      sightexports.sGui:setLabelClip(label, true)
      sightexports.sGui:setLabelAlignment(label, "center", "center")
      local line = sightexports.sGui:createGuiElement("rectangle", 27, y, 512, 2, rect)
      sightexports.sGui:setGuiBackground(line, "solid", "#242424")
    end
    y = y + h * 2
    local line = sightexports.sGui:createGuiElement("rectangle", 27, y, 512, 2, rect)
    sightexports.sGui:setGuiBackground(line, "solid", "#242424")
  elseif theType == "checkout" then
    local y = 228
    local h = 22
    local n = #data - 2
    local w = 90.61946902654867
    local line = sightexports.sGui:createGuiElement("rectangle", 27, y, 512, 2, rect)
    sightexports.sGui:setGuiBackground(line, "solid", "#242424")
    local line = sightexports.sGui:createGuiElement("rectangle", 27, y, 2, h * (n + 1), rect)
    sightexports.sGui:setGuiBackground(line, "solid", "#242424")
    local line = sightexports.sGui:createGuiElement("rectangle", 27 + w * 2, y, 2, h * (n + 1), rect)
    sightexports.sGui:setGuiBackground(line, "solid", "#242424")
    local line = sightexports.sGui:createGuiElement("rectangle", 27 + w * 3, y, 2, h * (n + 1), rect)
    sightexports.sGui:setGuiBackground(line, "solid", "#242424")
    local line = sightexports.sGui:createGuiElement("rectangle", 27 + w * 4, y, 2, h * (n + 1), rect)
    sightexports.sGui:setGuiBackground(line, "solid", "#242424")
    local line = sightexports.sGui:createGuiElement("rectangle", 27 + w * 5, y, 2, h * (n + 1), rect)
    sightexports.sGui:setGuiBackground(line, "solid", "#242424")
    local line = sightexports.sGui:createGuiElement("rectangle", 537, y, 2, h * (n + 1), rect)
    sightexports.sGui:setGuiBackground(line, "solid", "#242424")
    local label = sightexports.sGui:createGuiElement("label", 27, y, w * 2, h, rect)
    sightexports.sGui:setLabelFont(label, "13/BebasNeueRegular.otf")
    sightexports.sGui:setLabelText(label, "Munkatárs")
    sightexports.sGui:setLabelColor(label, "#242424")
    sightexports.sGui:setLabelAlignment(label, "center", "center")
    local label = sightexports.sGui:createGuiElement("label", 27 + w * 2, y, w, h, rect)
    sightexports.sGui:setLabelFont(label, "13/BebasNeueRegular.otf")
    sightexports.sGui:setLabelText(label, "Bevétel")
    sightexports.sGui:setLabelColor(label, "#242424")
    sightexports.sGui:setLabelAlignment(label, "center", "center")
    local label = sightexports.sGui:createGuiElement("label", 27 + w * 3, y, w, h, rect)
    sightexports.sGui:setLabelFont(label, "13/BebasNeueRegular.otf")
    sightexports.sGui:setLabelText(label, "Anyagköltség")
    sightexports.sGui:setLabelColor(label, "#242424")
    sightexports.sGui:setLabelAlignment(label, "center", "center")
    local label = sightexports.sGui:createGuiElement("label", 27 + w * 4, y, w, h, rect)
    sightexports.sGui:setLabelFont(label, "13/BebasNeueRegular.otf")
    sightexports.sGui:setLabelText(label, "Profit")
    sightexports.sGui:setLabelColor(label, "#242424")
    sightexports.sGui:setLabelAlignment(label, "center", "center")
    local label = sightexports.sGui:createGuiElement("label", 27 + w * 5, y, w * 0.65, h, rect)
    sightexports.sGui:setLabelFont(label, "13/BebasNeueRegular.otf")
    sightexports.sGui:setLabelText(label, "Norma")
    sightexports.sGui:setLabelColor(label, "#242424")
    sightexports.sGui:setLabelAlignment(label, "center", "center")
    for i = 1, n do
      y = y + h
      local label = sightexports.sGui:createGuiElement("label", 27, y, w * 2, h, rect)
      sightexports.sGui:setLabelFont(label, "9/Ubuntu-B.ttf")
      sightexports.sGui:setLabelText(label, data[i + 2][1])
      sightexports.sGui:setLabelColor(label, "#242424")
      sightexports.sGui:setLabelClip(label, true)
      sightexports.sGui:setLabelAlignment(label, "center", "center")
      local label = sightexports.sGui:createGuiElement("label", 27 + w * 2, y, w, h, rect)
      sightexports.sGui:setLabelFont(label, "9/Ubuntu-R.ttf")
      sightexports.sGui:setLabelText(label, sightexports.sGui:thousandsStepper(data[i + 2][2]) .. " $")
      sightexports.sGui:setLabelColor(label, "#242424")
      sightexports.sGui:setLabelAlignment(label, "center", "center")
      local label = sightexports.sGui:createGuiElement("label", 27 + w * 3, y, w, h, rect)
      sightexports.sGui:setLabelFont(label, "9/Ubuntu-R.ttf")
      sightexports.sGui:setLabelText(label, sightexports.sGui:thousandsStepper(data[i + 2][3]) .. " $")
      sightexports.sGui:setLabelColor(label, "#242424")
      sightexports.sGui:setLabelAlignment(label, "center", "center")
      local label = sightexports.sGui:createGuiElement("label", 27 + w * 4, y, w, h, rect)
      sightexports.sGui:setLabelFont(label, "9/Ubuntu-B.ttf")
      sightexports.sGui:setLabelText(label, sightexports.sGui:thousandsStepper(data[i + 2][2] - data[i + 2][3]) .. " $")
      sightexports.sGui:setLabelColor(label, "#242424")
      sightexports.sGui:setLabelAlignment(label, "center", "center")
      local label = sightexports.sGui:createGuiElement("label", 27 + w * 5, y, w * 0.65, h, rect)
      sightexports.sGui:setLabelFont(label, "9/Ubuntu-R.ttf")
      sightexports.sGui:setLabelText(label, tonumber(data[i + 2][4]) and math.floor(data[i + 2][4] * 100) / 100 .. " h" or "-")
      sightexports.sGui:setLabelColor(label, "#242424")
      sightexports.sGui:setLabelAlignment(label, "center", "center")
      local line = sightexports.sGui:createGuiElement("rectangle", 27, y, 512, 2, rect)
      sightexports.sGui:setGuiBackground(line, "solid", "#242424")
    end
    y = y + h
    local line = sightexports.sGui:createGuiElement("rectangle", 27, y, 512, 2, rect)
    sightexports.sGui:setGuiBackground(line, "solid", "#242424")
  elseif theType == "invoice" then
    local y = 228
    local h = 22
    local n = #data.list + 2
    local w = 128
    local line = sightexports.sGui:createGuiElement("rectangle", 27, y, 512, 2, rect)
    sightexports.sGui:setGuiBackground(line, "solid", "#242424")
    local line = sightexports.sGui:createGuiElement("rectangle", 27, y, 2, h * (n - 1), rect)
    sightexports.sGui:setGuiBackground(line, "solid", "#242424")
    local line = sightexports.sGui:createGuiElement("rectangle", 27 + w * 2, y, 2, h * (n - 1), rect)
    sightexports.sGui:setGuiBackground(line, "solid", "#242424")
    local line = sightexports.sGui:createGuiElement("rectangle", 27 + w * 3.25, y, 2, h * (n - 1), rect)
    sightexports.sGui:setGuiBackground(line, "solid", "#242424")
    local line = sightexports.sGui:createGuiElement("rectangle", 537, y, 2, h * (n - 1), rect)
    sightexports.sGui:setGuiBackground(line, "solid", "#242424")
    local label = sightexports.sGui:createGuiElement("label", 27, y, w * 2, h, rect)
    sightexports.sGui:setLabelFont(label, "13/BebasNeueRegular.otf")
    sightexports.sGui:setLabelText(label, "Megnevezés")
    sightexports.sGui:setLabelColor(label, "#242424")
    sightexports.sGui:setLabelAlignment(label, "center", "center")
    local label = sightexports.sGui:createGuiElement("label", 27 + w * 2, y, w * 1.25, h, rect)
    sightexports.sGui:setLabelFont(label, "13/BebasNeueRegular.otf")
    sightexports.sGui:setLabelText(label, "Gyártó")
    sightexports.sGui:setLabelColor(label, "#242424")
    sightexports.sGui:setLabelAlignment(label, "center", "center")
    local label = sightexports.sGui:createGuiElement("label", 27 + w * 3.25, y, w * 0.75, h, rect)
    sightexports.sGui:setLabelFont(label, "13/BebasNeueRegular.otf")
    sightexports.sGui:setLabelText(label, "Ár")
    sightexports.sGui:setLabelColor(label, "#242424")
    sightexports.sGui:setLabelAlignment(label, "center", "center")
    for i = 1, n do
      y = y + h
      if i == n - 1 then
        if data.sum then
          local label = sightexports.sGui:createGuiElement("label", 27 + w * 3, y, w, h, rect)
          sightexports.sGui:setLabelFont(label, "10/Ubuntu-B.ttf")
          sightexports.sGui:setLabelText(label, "Munkadíj: " .. sightexports.sGui:thousandsStepper(data.sum[1]) .. " $")
          sightexports.sGui:setLabelColor(label, "#242424")
          sightexports.sGui:setLabelAlignment(label, "right", "center")
        end
      elseif n > i then
        local label = sightexports.sGui:createGuiElement("label", 35, y, w * 2, h, rect)
        sightexports.sGui:setLabelFont(label, "10/Ubuntu-B.ttf")
        sightexports.sGui:setLabelText(label, invoiceNames[data.list[i][1]] or data.list[i][1])
        sightexports.sGui:setLabelColor(label, "#242424")
        sightexports.sGui:setLabelAlignment(label, "left", "center")
        if data.list[i][2] then
          local label = sightexports.sGui:createGuiElement("label", 35 + sightexports.sGui:getLabelTextWidth(label), y, w * 2, h, rect)
          sightexports.sGui:setLabelFont(label, "9/Ubuntu-R.ttf")
          sightexports.sGui:setLabelText(label, " (" .. data.list[i][2] .. ")")
          sightexports.sGui:setLabelColor(label, "#242424")
          sightexports.sGui:setLabelAlignment(label, "left", "center")
        end
        local label = sightexports.sGui:createGuiElement("label", 27 + w * 2, y, w * 1.25, h, rect)
        sightexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
        sightexports.sGui:setLabelText(label, data.list[i][3] or "-")
        sightexports.sGui:setLabelColor(label, "#242424")
        sightexports.sGui:setLabelAlignment(label, "center", "center")
        local label = sightexports.sGui:createGuiElement("label", 27 + w * 3.25, y, w * 0.75 - 8, h, rect)
        sightexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
        sightexports.sGui:setLabelText(label, sightexports.sGui:thousandsStepper(data.list[i][4]) .. " $")
        sightexports.sGui:setLabelColor(label, "#242424")
        sightexports.sGui:setLabelAlignment(label, "right", "center")
      elseif data.sum then
        local label = sightexports.sGui:createGuiElement("label", 27 + w * 3, y, w, h, rect)
        sightexports.sGui:setLabelFont(label, "11/Ubuntu-B.ttf")
        sightexports.sGui:setLabelText(label, "Végösszeg: " .. sightexports.sGui:thousandsStepper(data.sum[2]) .. " $")
        sightexports.sGui:setLabelColor(label, "#242424")
        sightexports.sGui:setLabelAlignment(label, "right", "center")
      else
        local label = sightexports.sGui:createGuiElement("label", 27, y - h, 512, h * 2, rect)
        sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
        sightexports.sGui:setLabelText(label, "A számla a következő oldalon folytatódik.")
        sightexports.sGui:setLabelColor(label, "#242424")
        sightexports.sGui:setLabelAlignment(label, "center", "center")
      end
      if n > i then
        local line = sightexports.sGui:createGuiElement("rectangle", 27, y, 512, (i == n - 1 or i == 1) and 2 or 1, rect)
        sightexports.sGui:setGuiBackground(line, "solid", "#242424")
      end
    end
  elseif theType == "inspection" then
    local y = 228
    local h = 254
    local line = sightexports.sGui:createGuiElement("rectangle", 27, y, 512, 2, rect)
    sightexports.sGui:setGuiBackground(line, "solid", "#242424")
    local line = sightexports.sGui:createGuiElement("rectangle", 27, y, 2, h * 2, rect)
    sightexports.sGui:setGuiBackground(line, "solid", "#242424")
    local line = sightexports.sGui:createGuiElement("rectangle", 537, y, 2, h * 2, rect)
    sightexports.sGui:setGuiBackground(line, "solid", "#242424")
    local label = sightexports.sGui:createGuiElement("label", 35, y, 566, 32, rect)
    sightexports.sGui:setLabelFont(label, "15/BebasNeueRegular.otf")
    sightexports.sGui:setLabelText(label, "Futómű, fékek és gumik állapota:")
    sightexports.sGui:setLabelColor(label, "#242424")
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    local label = sightexports.sGui:createGuiElement("label", 35, y + h, 566, 32, rect)
    sightexports.sGui:setLabelFont(label, "15/BebasNeueRegular.otf")
    sightexports.sGui:setLabelText(label, "Egyéb:")
    sightexports.sGui:setLabelColor(label, "#242424")
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    local label = sightexports.sGui:createGuiElement("label", 363, y + 10 + 32, 64, 32, rect)
    sightexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
    sightexports.sGui:setLabelText(label, data[1] .. "%")
    sightexports.sGui:setLabelColor(label, "#242424")
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    local label = sightexports.sGui:createGuiElement("label", 363, y + 10 + h - 24 - 32, 64, 32, rect)
    sightexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
    sightexports.sGui:setLabelText(label, data[2] .. "%")
    sightexports.sGui:setLabelColor(label, "#242424")
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    local label = sightexports.sGui:createGuiElement("label", 139, y + 10 + 32, 64, 32, rect)
    sightexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
    sightexports.sGui:setLabelText(label, data[3] .. "%")
    sightexports.sGui:setLabelColor(label, "#242424")
    sightexports.sGui:setLabelAlignment(label, "right", "center")
    local label = sightexports.sGui:createGuiElement("label", 139, y + 10 + h - 24 - 32, 64, 32, rect)
    sightexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
    sightexports.sGui:setLabelText(label, data[4] .. "%")
    sightexports.sGui:setLabelColor(label, "#242424")
    sightexports.sGui:setLabelAlignment(label, "right", "center")
    local label = sightexports.sGui:createGuiElement("label", 363, y + 10 + 32 + 40, 64, 32, rect)
    sightexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
    sightexports.sGui:setLabelText(label, data[5] .. "%")
    sightexports.sGui:setLabelColor(label, "#242424")
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    local label = sightexports.sGui:createGuiElement("label", 363, y + 10 + h - 24 - 32 - 40, 64, 32, rect)
    sightexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
    sightexports.sGui:setLabelText(label, data[6] .. "%")
    sightexports.sGui:setLabelColor(label, "#242424")
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    local label = sightexports.sGui:createGuiElement("label", 139, y + 10 + 32 + 40, 64, 32, rect)
    sightexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
    sightexports.sGui:setLabelText(label, data[7] .. "%")
    sightexports.sGui:setLabelColor(label, "#242424")
    sightexports.sGui:setLabelAlignment(label, "right", "center")
    local label = sightexports.sGui:createGuiElement("label", 139, y + 10 + h - 24 - 32 - 40, 64, 32, rect)
    sightexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
    sightexports.sGui:setLabelText(label, data[8] .. "%")
    sightexports.sGui:setLabelColor(label, "#242424")
    sightexports.sGui:setLabelAlignment(label, "right", "center")
    local label = sightexports.sGui:createGuiElement("label", 43, y + 10 + 32, 64, 72, rect)
    sightexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
    sightexports.sGui:setLabelText(label, data[9] .. "%")
    sightexports.sGui:setLabelColor(label, "#242424")
    sightexports.sGui:setLabelAlignment(label, "right", "center")
    local label = sightexports.sGui:createGuiElement("label", 43, y + 10 + h - 24 - 32 - 40, 64, 72, rect)
    sightexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
    sightexports.sGui:setLabelText(label, data[10] .. "%")
    sightexports.sGui:setLabelColor(label, "#242424")
    sightexports.sGui:setLabelAlignment(label, "right", "center")
    local label = sightexports.sGui:createGuiElement("label", 459, y + 10 + 32, 64, 72, rect)
    sightexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
    sightexports.sGui:setLabelText(label, data[9] .. "%")
    sightexports.sGui:setLabelColor(label, "#242424")
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    local label = sightexports.sGui:createGuiElement("label", 459, y + 10 + h - 24 - 32 - 40, 64, 72, rect)
    sightexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
    sightexports.sGui:setLabelText(label, data[10] .. "%")
    sightexports.sGui:setLabelColor(label, "#242424")
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    local label = sightexports.sGui:createGuiElement("label", 0, y + 10 + 32, 566, 72, rect)
    sightexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
    sightexports.sGui:setLabelText(label, "ELSŐ")
    sightexports.sGui:setLabelColor(label, "#242424")
    sightexports.sGui:setLabelAlignment(label, "center", "center")
    local label = sightexports.sGui:createGuiElement("label", 0, y + 10 + h - 24 - 32 - 40, 566, 72, rect)
    sightexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
    sightexports.sGui:setLabelText(label, "HÁTSÓ")
    sightexports.sGui:setLabelColor(label, "#242424")
    sightexports.sGui:setLabelAlignment(label, "center", "center")
    local tread = sightexports.sGui:createGuiElement("image", 115, y + 10 + 32 + 36 - 16, 32, 32, rect)
    sightexports.sGui:setImageDDS(tread, ":sMechanic/files/tire.dds")
    local tread = sightexports.sGui:createGuiElement("image", 115, y + 10 + h - 24 - 32 - 40 + 36 - 16, 32, 32, rect)
    sightexports.sGui:setImageDDS(tread, ":sMechanic/files/tire.dds")
    local tread = sightexports.sGui:createGuiElement("image", 419, y + 10 + 32 + 36 - 16, 32, 32, rect)
    sightexports.sGui:setImageDDS(tread, ":sMechanic/files/tire.dds")
    local tread = sightexports.sGui:createGuiElement("image", 419, y + 10 + h - 24 - 32 - 40 + 36 - 16, 32, 32, rect)
    sightexports.sGui:setImageDDS(tread, ":sMechanic/files/tire.dds")
    local tread = sightexports.sGui:createGuiElement("image", 211, y + 10 + 32, 32, 32, rect)
    sightexports.sGui:setImageDDS(tread, ":sMechanic/files/brake.dds")
    local tread = sightexports.sGui:createGuiElement("image", 211, y + 10 + 32 + 40, 32, 32, rect)
    sightexports.sGui:setImageDDS(tread, ":sMechanic/files/suspension.dds")
    local tread = sightexports.sGui:createGuiElement("image", 211, y + 10 + h - 24 - 32, 32, 32, rect)
    sightexports.sGui:setImageDDS(tread, ":sMechanic/files/brake.dds")
    local tread = sightexports.sGui:createGuiElement("image", 211, y + 10 + h - 24 - 32 - 40, 32, 32, rect)
    sightexports.sGui:setImageDDS(tread, ":sMechanic/files/suspension.dds")
    local tread = sightexports.sGui:createGuiElement("image", 323, y + 10 + 32, 32, 32, rect)
    sightexports.sGui:setImageDDS(tread, ":sMechanic/files/brake.dds")
    local tread = sightexports.sGui:createGuiElement("image", 323, y + 10 + 32 + 40, 32, 32, rect)
    sightexports.sGui:setImageDDS(tread, ":sMechanic/files/suspension.dds")
    local tread = sightexports.sGui:createGuiElement("image", 323, y + 10 + h - 24 - 32, 32, 32, rect)
    sightexports.sGui:setImageDDS(tread, ":sMechanic/files/brake.dds")
    local tread = sightexports.sGui:createGuiElement("image", 323, y + 10 + h - 24 - 32 - 40, 32, 32, rect)
    sightexports.sGui:setImageDDS(tread, ":sMechanic/files/suspension.dds")
    y = y + h
    local line = sightexports.sGui:createGuiElement("rectangle", 27, y, 512, 2, rect)
    sightexports.sGui:setGuiBackground(line, "solid", "#242424")
    local label = sightexports.sGui:createGuiElement("label", 35, y + 32, 512, 32, rect)
    sightexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
    sightexports.sGui:setLabelText(label, "Károsanyag kibocsájtás " .. (data[9] and "megfelelő." or "NEM megfelelő!"))
    sightexports.sGui:setLabelColor(label, "#242424")
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    local n = 4.75
    local label = sightexports.sGui:createGuiElement("label", 35, y + 64, 496, 32 + 20 * n, rect)
    if data[12] and 1 < #data[12] then
      sightexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
      local text = {}
      for i = 1, #data[12] do
        local id = tostring(data[12][i])
        for j = utf8.len(id), 5 do
          id = "0" .. id
        end
        table.insert(text, (faultCodes[data[12][i]] and faultCodes[data[12][i]].prefix or "P") .. id .. " - " .. (faultCodes[data[12][i]] and faultCodes[data[12][i]].name or "N/A"))
      end
      sightexports.sGui:setLabelText(label, "Hibakódok:\n" .. table.concat(text, " | "))
    else
      sightexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
      sightexports.sGui:setLabelText(label, "Nem található hibakód.")
    end
    sightexports.sGui:setLabelWordBreak(label, true)
    sightexports.sGui:setLabelColor(label, "#242424")
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    local label = sightexports.sGui:createGuiElement("label", 35, y + 96 + 20 * n, 512, 24, rect)
    sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
    sightexports.sGui:setLabelText(label, "A jármű műszaki állapota " .. (data[13] and "megfelelő." or "NEM megfelelő!"))
    sightexports.sGui:setLabelColor(label, "#242424")
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    if data[15] or data[14] then
      local label = sightexports.sGui:createGuiElement("label", 35, y + 96 + 20 * n + 24, 496, 32, rect)
      sightexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
      local text = ""
      if data[14] then
        if data[13] then
          text = "Műszaki vizsgán megfelelt. Forgalmi kiváltásához szükséges adatlap mellékelve. "
        else
          text = "Műszaki vizsgán NEM felelt meg. "
        end
      end
      if data[15] then
        text = text .. "Megjegyzés: " .. data[15]
      end
      sightexports.sGui:setLabelText(label, text)
      sightexports.sGui:setLabelColor(label, "#242424")
      sightexports.sGui:setLabelWordBreak(label, true)
      sightexports.sGui:setLabelAlignment(label, "left", "center")
    end
    y = y + h
    local line = sightexports.sGui:createGuiElement("rectangle", 27, y, 512, 2, rect)
    sightexports.sGui:setGuiBackground(line, "solid", "#242424")
  elseif theType == "alignment" then
    local y = 228
    local h = 254
    local line = sightexports.sGui:createGuiElement("rectangle", 27, y, 512, 2, rect)
    sightexports.sGui:setGuiBackground(line, "solid", "#242424")
    local line = sightexports.sGui:createGuiElement("rectangle", 27, y, 2, h * 2, rect)
    sightexports.sGui:setGuiBackground(line, "solid", "#242424")
    local line = sightexports.sGui:createGuiElement("rectangle", 537, y, 2, h * 2, rect)
    sightexports.sGui:setGuiBackground(line, "solid", "#242424")
    local label = sightexports.sGui:createGuiElement("label", 35, y, 566, 32, rect)
    sightexports.sGui:setLabelFont(label, "15/BebasNeueRegular.otf")
    sightexports.sGui:setLabelText(label, "Beállítás előtt:")
    sightexports.sGui:setLabelColor(label, "#242424")
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    local label = sightexports.sGui:createGuiElement("label", 35, y + h, 566, 32, rect)
    sightexports.sGui:setLabelFont(label, "15/BebasNeueRegular.otf")
    sightexports.sGui:setLabelText(label, "Beállítás után:")
    sightexports.sGui:setLabelColor(label, "#242424")
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    for i = 1, 2 do
      local tread = sightexports.sGui:createGuiElement("image", 267, y + 24 + 32, 32, 32, rect)
      sightexports.sGui:setImageDDS(tread, ":sMechanic/files/steering.dds")
      sightexports.sGui:setImageColor(tread, {
        0,
        0,
        0,
        255
      })
      sightexports.sGui:setImageRotation(tread, data[i][1] / 100)
      local label = sightexports.sGui:createGuiElement("label", 267, y + 24 + 32 + 32, 32, 32, rect)
      sightexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
      sightexports.sGui:setLabelText(label, (1 < math.abs(data[i][1] / 100) and "\226\156\150" or "\226\156\148") .. " " .. data[i][1] / 100 .. " °")
      sightexports.sGui:setLabelColor(label, "#242424")
      sightexports.sGui:setLabelAlignment(label, "right", "center")
      local label = sightexports.sGui:createGuiElement("label", 363, y + 24, 64, 32, rect)
      sightexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
      sightexports.sGui:setLabelText(label, (1 < math.abs(data[i][2] / 100) and "\226\156\150" or "\226\156\148") .. " " .. data[i][2] / 100 .. " °")
      sightexports.sGui:setLabelColor(label, "#242424")
      sightexports.sGui:setLabelAlignment(label, "left", "center")
      local label = sightexports.sGui:createGuiElement("label", 363, y + h - 24 - 32, 64, 32, rect)
      sightexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
      sightexports.sGui:setLabelText(label, (1 < math.abs(data[i][3] / 100) and "\226\156\150" or "\226\156\148") .. " " .. data[i][3] / 100 .. " °")
      sightexports.sGui:setLabelColor(label, "#242424")
      sightexports.sGui:setLabelAlignment(label, "left", "center")
      local label = sightexports.sGui:createGuiElement("label", 139, y + 24, 64, 32, rect)
      sightexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
      sightexports.sGui:setLabelText(label, data[i][4] / 100 .. " ° " .. (1 < math.abs(data[i][4] / 100) and "\226\156\150" or "\226\156\148"))
      sightexports.sGui:setLabelColor(label, "#242424")
      sightexports.sGui:setLabelAlignment(label, "right", "center")
      local label = sightexports.sGui:createGuiElement("label", 139, y + h - 24 - 32, 64, 32, rect)
      sightexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
      sightexports.sGui:setLabelText(label, data[i][5] / 100 .. " ° " .. (1 < math.abs(data[i][5] / 100) and "\226\156\150" or "\226\156\148"))
      sightexports.sGui:setLabelColor(label, "#242424")
      sightexports.sGui:setLabelAlignment(label, "right", "center")
      local tread = sightexports.sGui:createGuiElement("image", 203, y + 24, 32, 32, rect)
      sightexports.sGui:setImageDDS(tread, ":sMechanic/files/tread.dds")
      sightexports.sGui:setImageColor(tread, {
        0,
        0,
        0,
        255
      })
      sightexports.sGui:setImageRotation(tread, data[i][4] / 100)
      local tread = sightexports.sGui:createGuiElement("image", 203, y + h - 24 - 32, 32, 32, rect)
      sightexports.sGui:setImageDDS(tread, ":sMechanic/files/tread.dds")
      sightexports.sGui:setImageColor(tread, {
        0,
        0,
        0,
        255
      })
      sightexports.sGui:setImageRotation(tread, data[i][5] / 100)
      local tread = sightexports.sGui:createGuiElement("image", 331, y + 24, 32, 32, rect)
      sightexports.sGui:setImageDDS(tread, ":sMechanic/files/tread.dds")
      sightexports.sGui:setImageColor(tread, {
        0,
        0,
        0,
        255
      })
      sightexports.sGui:setImageRotation(tread, data[i][2] / 100)
      local tread = sightexports.sGui:createGuiElement("image", 331, y + h - 24 - 32, 32, 32, rect)
      sightexports.sGui:setImageDDS(tread, ":sMechanic/files/tread.dds")
      sightexports.sGui:setImageColor(tread, {
        0,
        0,
        0,
        255
      })
      sightexports.sGui:setImageRotation(tread, data[i][3] / 100)
      y = y + h
      local line = sightexports.sGui:createGuiElement("rectangle", 27, y, 512, 2, rect)
      sightexports.sGui:setGuiBackground(line, "solid", "#242424")
    end
  end
  local label = sightexports.sGui:createGuiElement("label", 0, 736, 566, 32, rect)
  sightexports.sGui:setLabelFont(label, "12/BebasNeueRegular.otf")
  sightexports.sGui:setLabelText(label, "Készült a Kruton-9000 Workshop szoftver használatával.")
  sightexports.sGui:setLabelColor(label, "#242424")
  sightexports.sGui:setLabelAlignment(label, "center", "center")
  local label = sightexports.sGui:createGuiElement("label", 0, 768, 566, 32, rect)
  sightexports.sGui:setLabelFont(label, "10/BebasNeueRegular.otf")
  sightexports.sGui:setLabelText(label, page .. "/" .. pages)
  sightexports.sGui:setLabelColor(label, "#242424")
  sightexports.sGui:setLabelAlignment(label, "center", "center")
  if 1 < page then
    local btn = sightexports.sGui:createGuiElement("button", 201, 772, 24, 24, rect)
    sightexports.sGui:setGuiBackground(btn, "solid", "sightblue")
    sightexports.sGui:setGuiHover(btn, "gradient", {
      "sightblue",
      "sightblue-second"
    }, false, true)
    sightexports.sGui:setButtonFont(btn, "13/BebasNeueRegular.otf")
    sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("caret-left", 24))
    sightexports.sGui:setClickEvent(btn, "previousMechanicPage")
  end
  if page < pages then
    local btn = sightexports.sGui:createGuiElement("button", 341, 772, 24, 24, rect)
    sightexports.sGui:setGuiBackground(btn, "solid", "sightblue")
    sightexports.sGui:setGuiHover(btn, "gradient", {
      "sightblue",
      "sightblue-second"
    }, false, true)
    sightexports.sGui:setButtonFont(btn, "13/BebasNeueRegular.otf")
    sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("caret-right", 24))
    sightexports.sGui:setClickEvent(btn, "nextMechanicPage")
  end
  if 1 < pages then
    local paper = sightexports.sGui:createGuiElement("image", -10, -32, 128, 128, rect)
    sightexports.sGui:setImageDDS(paper, ":sMechanic/files/clip2.dds")
    sightexports.sGui:setImageColor(paper, {
      255,
      255,
      255,
      255
    })
  end
end
local currentPage = 1
local invoiceId = false
local result = false
addEvent("gotServiceInvoice", true)
addEventHandler("gotServiceInvoice", getRootElement(), function(res)
  if res.id == invoiceId then
    result = res
    local paperData = result.paperData
    playSound("files/paper" .. math.random(1, 2) .. ".mp3")
    if currentPage > #paperData then
      currentPage = #paperData
    end
    local data = paperData[currentPage]
    createMechanicPaper(data[1], data[2], currentPage, #paperData, result.workshop, result.id, result.mechanic, result.customer, getRealTime(result.created), result.vehicleMake, result.vehicleModel, result.vehiclePlate, sightexports.sGui:thousandsStepper(result.vehicleOdometer))
  end
end)
addEvent("previousMechanicPage", false)
addEventHandler("previousMechanicPage", getRootElement(), function(res)
  if 1 < currentPage then
    playSound("files/paper" .. math.random(1, 2) .. ".mp3")
    currentPage = currentPage - 1
    local data = result.paperData[currentPage]
    createMechanicPaper(data[1], data[2], currentPage, #result.paperData, result.workshop, result.id, result.mechanic, result.customer, getRealTime(result.created), result.vehicleMake, result.vehicleModel, result.vehiclePlate, sightexports.sGui:thousandsStepper(result.vehicleOdometer))
  end
end)
addEvent("nextMechanicPage", false)
addEventHandler("nextMechanicPage", getRootElement(), function(res)
  if currentPage < #result.paperData then
    playSound("files/paper" .. math.random(1, 2) .. ".mp3")
    currentPage = currentPage + 1
    local data = result.paperData[currentPage]
    createMechanicPaper(data[1], data[2], currentPage, #result.paperData, result.workshop, result.id, result.mechanic, result.customer, getRealTime(result.created), result.vehicleMake, result.vehicleModel, result.vehiclePlate, sightexports.sGui:thousandsStepper(result.vehicleOdometer))
  end
end)
function closeServiceInvoice()
  if invoiceId then
    playSound("files/paper" .. math.random(1, 2) .. ".mp3")
    invoiceId = false
    result = false
    deleteMechanicPaper()
    sightexports.sChat:localActionC(localPlayer, "elrakott egy szerviz számlát.")
  end
end
function openServiceInvoice(id)
  id = tonumber(id)
  if invoiceId ~= id then
    deleteMechanicPaper()
    serviceInvoice = sightexports.sGui:createGuiElement("image", screenX / 2 - 32, screenY / 2 - 32, 64, 64, appInside)
    sightexports.sGui:setImageFile(serviceInvoice, sightexports.sGui:getFaIconFilename("circle-notch", 64))
    sightexports.sGui:setImageSpinner(serviceInvoice, true)
    invoiceId = id
    currentPage = 1
    result = false
    triggerServerEvent("requestServiceInvoice", localPlayer, id)
    sightexports.sChat:localActionC(localPlayer, "elővett egy szerviz számlát.")
  end
end
