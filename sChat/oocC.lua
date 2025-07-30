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
local widgetState = false
local widgetPos = false
local widgetSize = false
local messages = {}
local renderMessages = {}
function renderOOC()
  if not isChatVisible() then
    return
  end
  local lines = math.floor(widgetSize[2] / 15)
  local remainder = widgetSize[2] - math.floor(widgetSize[2] / 15) * 15
  local usedLines = 0
  local lastLines = {}
  for i = #renderMessages, 1, -1 do
    for k = #renderMessages[i], 1, -1 do
      if lines > usedLines then
        table.insert(lastLines, 1, renderMessages[i][k])
        usedLines = usedLines + 1
      end
    end
  end
  for i = 1, #lastLines do
    dxDrawText(lastLines[i]:gsub("#%x%x%x%x%x%x", ""), widgetPos[1] + 1 + 13, widgetPos[2] + (i - 1) * 15 + remainder / 2 + 1, widgetPos[1] + widgetSize[1] + 8, widgetPos[2] + widgetSize[2], tocolor(0, 0, 0, 255), 1, "default-bold", "left", "top", false, false, false, true)
    dxDrawText(lastLines[i], widgetPos[1] + 13, widgetPos[2] + (i - 1) * 15 + remainder / 2, widgetPos[1] + widgetSize[1] + 8, widgetPos[2] + widgetSize[2], tocolor(255, 255, 255, 255), 1, "default-bold", "left", "top", false, false, false, true)
  end
end
addEvent("hudWidgetState:oocChat", true)
addEventHandler("hudWidgetState:oocChat", getRootElement(), function(state)
  if widgetState ~= state then
    widgetState = state
    if widgetState then
      addEventHandler("onClientRender", getRootElement(), renderOOC, true, "low-999999999999999999")
    else
      removeEventHandler("onClientRender", getRootElement(), renderOOC)
    end
  end
end)
addEvent("hudWidgetPosition:oocChat", true)
addEventHandler("hudWidgetPosition:oocChat", getRootElement(), function(pos, final)
  widgetPos = pos
end)
function rebuildRenderedMessages()
  local messagesBroken = {}
  local newMessages = {}
  for i = #messages - 100, #messages do
    table.insert(newMessages, messages[i])
  end
  messages = newMessages
  for i = 1, #messages do
    local txt = messages[i][1]
    local color = messages[i][2]
    local lastBreak = 1
    local skipBreak = false
    messagesBroken[i] = {}
    if dxGetTextWidth(txt, 1, "default-bold") < widgetSize[1] then
      messagesBroken[i] = {txt}
      skipBreak = true
    end
    if not skipBreak then
      for k = 1, utf8.len(txt) do
        local char = utf8.sub(txt, k, k)
        if char == " " and dxGetTextWidth(utf8.sub(txt, lastBreak, k), 1, "default-bold") > widgetSize[1] then
          local nowText = color .. utf8.sub(txt, lastBreak, k)
          table.insert(messagesBroken[i], nowText)
          lastBreak = k
        end
      end
      if lastBreak < utf8.len(txt) then
        local nowText = utf8.sub(txt, lastBreak, utf8.len(txt))
        table.insert(messagesBroken[i], color .. nowText)
      end
    end
  end
  renderMessages = messagesBroken
end
addEvent("hudWidgetSize:oocChat", true)
addEventHandler("hudWidgetSize:oocChat", getRootElement(), function(size, final)
  widgetSize = size
  rebuildRenderedMessages()
end)
triggerEvent("requestWidgetDatas", localPlayer, "oocChat")
local timeStampEnable = false
function getOOCTimestamps()
  return timeStampEnable
end
function setOOCTimestamps(val)
  timeStampEnable = val
end
addEvent("onClientRecieveOOCMessage", true)
addEventHandler("onClientRecieveOOCMessage", getRootElement(), function(message, visibleName, spec, color)
  local player = source
  if visibleName then
    local ts = string.format("[%02d:%02d]", getRealTime().hour, getRealTime().minute)
    if timeStampEnable then
      visibleName = ts .. " " .. visibleName
    end
    if color then
      visibleName = sightexports.sGui:getColorCodeHex(color) .. visibleName
    end
    local text = visibleName .. ": (( " .. message:gsub("#%x%x%x%x%x%x", "") .. " ))"
    if spec then
      text = "[>o<] " .. text
    end
    local color = ""
    for i in string.gmatch(text, "#%x%x%x%x%x%x") do
      color = i
    end
    outputConsole(ts .. " " .. text:gsub("#%x%x%x%x%x%x", ""))
    table.insert(messages, {text, color})
    rebuildRenderedMessages()
  end
end)
function addOOCMessage(source, message, visibleName)
  if visibleName then
    local text = visibleName .. ": (( " .. message:gsub("#%x%x%x%x%x%x", "") .. " ))"
    table.insert(messages, text)
  end
end
function clearCommand(cname, arg)
  messages = {}
  renderMessages = {}
end
addCommandHandler("co", clearCommand)
addCommandHandler("clearooc", clearCommand)
