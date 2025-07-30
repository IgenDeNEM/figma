newsTitle, newsDate, newsBadge, newsImageHash = "", "", {}, false
addEvent("extraLoadStart:loadingNews", false)
addEventHandler("extraLoadStart:loadingNews", getRootElement(), function()
  triggerEvent("extraLoaderDone", localPlayer, "loadingNews")
  triggerLatentServerEvent("requestNewsData", localPlayer)
end)
function loadedNews()
  backgroundSizes["news/latest.dds"] = nil
  local i, j = unpack(newsPosition)
  dashboardLayout[i][j].background = "news/latest.dds"
  setTimer(triggerEvent, 250, 1, "extraLoaderDone", localPlayer, "loadingNews")
end
addEvent("gotNewsImage", true)
addEventHandler("gotNewsImage", getRootElement(), function(data)
  if fileExists("news/latest.dds") then
    fileDelete("news/latest.dds")
  end
  local file = fileCreate("news/latest.dds")
  if file then
    fileWrite(file, data)
    fileClose(file)
  end
  loadedNews()
end)
addEvent("gotNewsData", true)
addEventHandler("gotNewsData", getRootElement(), function(title, date, badge, hash)
  newsTitle = title
  newsDate = date
  newsBadge = badge
  if fileExists("news/latest.dds") then
    local file = fileOpen("news/latest.dds")
    if file then
      local data = fileRead(file, fileGetSize(file))
      fileClose(file)
      if utf8.lower(sha256(data)) == utf8.lower(hash) then
        loadedNews()
      else
        loadedNews()
      end
      data = nil
      collectgarbage("collect")
    else
        loadedNews()
    end
  else
	loadedNews()
  end
end)
addEventHandler("onClientResourceStart", getResourceRootElement(), function()
  if getElementData(localPlayer, "loggedIn") then
    triggerLatentServerEvent("requestNewsData", localPlayer)
  end
end)
--[[
local storedTags = {}
local function createNewsTag(tagName, newsElement)
  local tagData = {55, 20}
  
  if storedTags[newsElement] then
    storedTags[newsElement] = storedTags[newsElement] + 1
  else
    storedTags[newsElement] = 0
  end

  local tagColor = string.match(tagName, "^c(%d+)")
  tagColor = tonumber(tagColor)
  if tagColor == 1 then
    tagColor = "sightblue"
  elseif tagColor == 2 then
    tagColor = "sightred"
  elseif tagColor == 3 then
    tagColor = "sightgreen"
  else
    tagColor = "sightgreen"
  end

  local function getTagLabel(tagName)
    return string.gsub(tagName, "^c(%d+)", "")
  end

  local tagBackground = exports.sGui:createGuiElement("rectangle", 5 + (60 * storedTags[newsElement]), 45, tagData[1], tagData[2], newsElement)
  exports.sGui:setGuiBackground(tagBackground, "solid", tagColor)

  local tagLabel = exports.sGui:createGuiElement("label", 0, 0, tagData[1], tagData[2], tagBackground)
  exports.sGui:setLabelText(tagLabel, getTagLabel(tagName) or "False")
  exports.sGui:setLabelFont(tagLabel, "11/BebasNeueRegular.otf")
  exports.sGui:setLabelColor(tagLabel, "sightgrey1")
  exports.sGui:setLabelAlignment(tagLabel, "center", "center")
end
function changelogInsideDraw(x, y, isx, isy, i, j, irtg)
  rtg = irtg
  sx, sy = isx, isy
  buttonsWidth = 0
  local fontSize = bebasSize - 10
  local buttonsHeight = exports.sGui:getFontHeight(fontSize .. "/BebasNeueRegular.otf") + dashboardPadding[3] * 4
  inside = exports.sGui:createGuiElement("null", 0, 0, sx, sy, rtg)
  
  local bcg = exports.sGui:createGuiElement("rectangle", 0, 0, sx, sy, rtg)
  exports.sGui:setGuiBackground(bcg, "solid", "sightgrey1")
  menuW = math.max(220, math.floor(sx * 0.25))
  local x = menuW + dashboardPadding[3] * 3
  local y = 0
  local rect = exports.sGui:createGuiElement("rectangle", 0, 0, menuW, sy, rtg)
  exports.sGui:setGuiBackground(rect, "solid", "sightgrey2")

  testNews = exports.sGui:createGuiElement("rectangle", 0, 0, menuW, 90, rtg)
  exports.sGui:setGuiHoverable(testNews, true)
  exports.sGui:setGuiBackground(testNews, "solid", "sightgrey1")

  local newsLabel = exports.sGui:createGuiElement("label", 5, -15, menuW, 90, testNews)
  exports.sGui:setLabelAlignment(newsLabel, "left", "center")
  exports.sGui:setLabelFont(newsLabel, "15/BebasNeueRegular.otf")
  exports.sGui:setLabelText(newsLabel, "Aranybankrablás")

  createNewsTag("c1Aranybank", testNews)
  createNewsTag("c2Hotfix", testNews)
  createNewsTag("c3Update", testNews)

  local label = exports.sGui:createGuiElement("label", 5, 0, 0, sy, inside)
  exports.sGui:setLabelFont(label, "15/BebasNeueRegular.otf")
  exports.sGui:setLabelAlignment(label, "left", "top")
  exports.sGui:setLabelText(label, "Changelogok")
  sx = sx - dashboardPadding[3] * 4
  sy = sy - dashboardPadding[3] * 4
end
]]