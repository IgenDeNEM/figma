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
local calcButtons = {}
local calcButtonTexts = {
  {
    "\194\177",
    "CE",
    "C",
    "DEL"
  },
  {
    "7",
    "8",
    "9",
    "\195\183"
  },
  {
    "4",
    "5",
    "6",
    "\195\151"
  },
  {
    "1",
    "2",
    "3",
    "+"
  },
  {
    ".",
    "0",
    "=",
    "-"
  }
}
local calcValues = {}
local calcInputValue = ""
local calcTopLabel = false
local calcBottomLabel = false
function sumUp()
  local sum = tonumber(calcValues[1]) or 0
  for i = 2, #calcValues - 1 do
    if calcValues[i] then
      if calcValues[i] == "\195\183" then
        sum = sum / tonumber(calcValues[i + 1])
      elseif calcValues[i] == "\195\151" then
        sum = sum * tonumber(calcValues[i + 1])
      elseif calcValues[i] == "+" then
        sum = sum + tonumber(calcValues[i + 1])
      elseif calcValues[i] == "-" then
        sum = sum - tonumber(calcValues[i + 1])
      end
    end
  end
  calcValues = {sum}
end
addEvent("calcButtonEvent", false)
addEventHandler("calcButtonEvent", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  if calcButtons[el] then
    local btn = calcButtons[el]
    if tonumber(btn) then
      calcInputValue = calcInputValue .. btn
    elseif btn == "." then
      if not utf8.find(calcInputValue, "%.") then
        calcInputValue = calcInputValue .. "."
      end
    elseif btn == "CE" then
      calcInputValue = ""
    elseif btn == "DEL" then
      calcInputValue = utf8.sub(calcInputValue, 1, -2)
    elseif btn == "C" then
      calcValues = {}
      calcInputValue = ""
    elseif btn == "\194\177" then
      if tonumber(calcInputValue) then
        calcInputValue = -tonumber(calcInputValue)
      end
    elseif btn == "=" then
      if tonumber(calcInputValue) then
        table.insert(calcValues, calcInputValue)
        sumUp()
        calcInputValue = calcValues[1]
        calcValues = {}
      end
    elseif tonumber(calcInputValue) then
      table.insert(calcValues, calcInputValue)
      sumUp()
      table.insert(calcValues, btn)
      calcInputValue = ""
    elseif not tonumber(calcValues[#calcValues]) then
      calcValues[#calcValues] = btn
    end
    sightxports.sGui:setLabelText(calcTopLabel, table.concat(calcValues, " "))
    sightxports.sGui:setLabelText(calcBottomLabel, tonumber(calcInputValue) and sightxports.sGui:thousandsStepper(tonumber(calcInputValue)) or calcInputValue)
  end
end)
function calculatorKey(button, por)
  if por then
    if button == "enter" or button == "num_enter" then
      if tonumber(calcInputValue) then
        table.insert(calcValues, calcInputValue)
        sumUp()
        calcInputValue = calcValues[1]
        calcValues = {}
      end
      sightxports.sGui:setLabelText(calcTopLabel, table.concat(calcValues, " "))
      sightxports.sGui:setLabelText(calcBottomLabel, tonumber(calcInputValue) and sightxports.sGui:thousandsStepper(tonumber(calcInputValue)) or calcInputValue)
    elseif button == "backspace" then
      calcInputValue = utf8.sub(calcInputValue, 1, -2)
      sightxports.sGui:setLabelText(calcTopLabel, table.concat(calcValues, " "))
      sightxports.sGui:setLabelText(calcBottomLabel, tonumber(calcInputValue) and sightxports.sGui:thousandsStepper(tonumber(calcInputValue)) or calcInputValue)
    end
  end
  cancelEvent()
end
function calculatorCharacter(btn)
  if tonumber(btn) then
    calcInputValue = calcInputValue .. btn
  elseif btn == "." or btn == "," then
    if not utf8.find(calcInputValue, "%.") then
      calcInputValue = calcInputValue .. "."
    end
  elseif btn == "c" then
    calcInputValue = ""
  elseif btn == "d" then
    calcInputValue = utf8.sub(calcInputValue, 1, -2)
  elseif btn == "=" then
    if tonumber(calcInputValue) then
      table.insert(calcValues, calcInputValue)
      sumUp()
      calcInputValue = calcValues[1]
      calcValues = {}
    end
  elseif btn == "*" or btn == "/" or btn == "+" or btn == "-" then
    if btn == "*" then
      btn = "\195\151"
    elseif btn == "/" then
      btn = "\195\183"
    end
    if tonumber(calcInputValue) then
      table.insert(calcValues, calcInputValue)
      sumUp()
      table.insert(calcValues, btn)
      calcInputValue = ""
    elseif not tonumber(calcValues[#calcValues]) then
      calcValues[#calcValues] = btn
    end
  else
    return
  end
  sightxports.sGui:setLabelText(calcTopLabel, table.concat(calcValues, " "))
  sightxports.sGui:setLabelText(calcBottomLabel, tonumber(calcInputValue) and sightxports.sGui:thousandsStepper(tonumber(calcInputValue)) or calcInputValue)
end
function appCloses.calculator()
  removeEventHandler("onClientCharacter", getRootElement(), calculatorCharacter)
  removeEventHandler("onClientKey", getRootElement(), calculatorKey)
end
function appScreens.calculator()
  appInside = sightxports.sGui:createGuiElement("null", 0, 0, bsx, bsy, mobileBackground)
  local rect = sightxports.sGui:createGuiElement("rectangle", 0, 0, bsx, bsy, appInside)
  sightxports.sGui:setGuiBackground(rect, "solid", {
    255,
    255,
    255
  })
  local th = (bsy * 0.35 - topSize) / 2
  local sx = 4
  local sy = 5
  local w = (bsx - 8) / sx
  local h = (bsy * 0.65 - topSize * 1.5) / sy
  calcTopLabel = sightxports.sGui:createGuiElement("label", 12, topSize, bsx - 24, th - 4, appInside)
  sightxports.sGui:setLabelFont(calcTopLabel, "12/Ubuntu-L.ttf")
  sightxports.sGui:setLabelAlignment(calcTopLabel, "right", "bottom")
  sightxports.sGui:setLabelColor(calcTopLabel, "#000000")
  sightxports.sGui:setLabelClip(calcTopLabel, true)
  sightxports.sGui:setLabelText(calcTopLabel, table.concat(calcValues, " "))
  calcBottomLabel = sightxports.sGui:createGuiElement("label", 12, topSize + th + 4, bsx - 24, th - 4, appInside)
  sightxports.sGui:setLabelFont(calcBottomLabel, "17/Ubuntu-L.ttf")
  sightxports.sGui:setLabelAlignment(calcBottomLabel, "right", "top")
  sightxports.sGui:setLabelColor(calcBottomLabel, "#000000")
  sightxports.sGui:setLabelClip(calcBottomLabel, true)
  sightxports.sGui:setLabelText(calcBottomLabel, tonumber(calcInputValue) and sightxports.sGui:thousandsStepper(tonumber(calcInputValue)) or calcInputValue)
  calcButtons = {}
  local rect = sightxports.sGui:createGuiElement("rectangle", 0, bsy - h * sy - topSize * 1.5, bsx, h * sy, appInside)
  sightxports.sGui:setGuiBackground(rect, "solid", "#565656")
  for y = 1, sy do
    for x = 1, sx do
      local btn = sightxports.sGui:createGuiElement("button", (x - 1) * w + 4, bsy - h * sy + (y - 1) * h - topSize * 1.5, w, h, appInside)
      if y == 1 or x == sx then
        sightxports.sGui:setGuiBackground(btn, "solid", "#565656")
        sightxports.sGui:setGuiHover(btn, "none", "#565656", false, true)
        sightxports.sGui:setButtonTextColor(btn, "#ffffff")
      else
        sightxports.sGui:setGuiBackground(btn, "solid", "#383838")
        sightxports.sGui:setGuiHover(btn, "none", "#383838", false, true)
        sightxports.sGui:setButtonTextColor(btn, "#ffffff")
      end
      sightxports.sGui:setButtonFont(btn, "15/Ubuntu-L.ttf")
      sightxports.sGui:setButtonText(btn, calcButtonTexts[y][x])
      sightxports.sGui:setClickEvent(btn, "calcButtonEvent")
      calcButtons[btn] = calcButtonTexts[y][x]
    end
  end
  addEventHandler("onClientCharacter", getRootElement(), calculatorCharacter)
  addEventHandler("onClientKey", getRootElement(), calculatorKey)
  generateBottom(true)
  bringBackFront()
end
