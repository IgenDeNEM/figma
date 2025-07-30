local sightexports = {
	sGui = false,
	sGroups = false,
	sReports = false,
	sPermission = false,
	sCore = false,
	sWeapons = false,
	sClothesshop = false,
	sPattach = false,
	sFarm = false,
	sPaintshop = false,
	sHud = false,
	sRadar = false,
	sDeath = false,
	sItems = false
}
local latestNews = {
    newsTitle = "Aranybank",
    newsDate = "2025.02.15",
    newsBadge = {
        [1] = {"Hotfix", "sightblue"},
        [2] = {"Update", "sightgreen"},
        [3] = {"Aranybankrablás", "sightyellow"},
    }
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
local sightlangGuiRefreshColors = function()
	local res = getResourceFromName("sGui")
	if res and getResourceState(res) == "running" then
		createGuiCache()
	end
end
addEventHandler("onGuiRefreshColors", getRootElement(), sightlangGuiRefreshColors)
addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangGuiRefreshColors)
local sightlangCondHandlState0 = false
local function sightlangCondHandl0(cond, prio)
	cond = cond and true or false
	if cond ~= sightlangCondHandlState0 then
		sightlangCondHandlState0 = cond
		if cond then
			addEventHandler("onClientPreRender", getRootElement(), renderCharSet, true, prio)
		else
			removeEventHandler("onClientPreRender", getRootElement(), renderCharSet)
		end
	end
end
farms = {}
otherRentables = {}
interiorRenderList = {}
function createElementMatrix(rx, ry, rz)
	local rx, ry, rz = math.rad(rx), math.rad(ry), math.rad(rz)
	return {
		{
			math.cos(rz) * math.cos(ry) - math.sin(rz) * math.sin(rx) * math.sin(ry),
			math.cos(ry) * math.sin(rz) + math.cos(rz) * math.sin(rx) * math.sin(ry),
			-math.cos(rx) * math.sin(ry),
			0
		},
		{
			-math.cos(rx) * math.sin(rz),
			math.cos(rz) * math.cos(rx),
			math.sin(rx),
			0
		},
		{
			math.cos(rz) * math.sin(ry) + math.cos(ry) * math.sin(rz) * math.sin(rx),
			math.sin(rz) * math.sin(ry) - math.cos(rz) * math.cos(ry) * math.sin(rx),
			math.cos(rx) * math.cos(ry),
			0
		},
		{
			0,
			0,
			0,
			1
		}
	}
end
function getEulerAnglesFromMatrix(mat)
	local nz1, nz2, nz3
	nz3 = math.sqrt(mat[2][1] * mat[2][1] + mat[2][2] * mat[2][2])
	nz1 = -mat[2][1] * mat[2][3] / nz3
	nz2 = -mat[2][2] * mat[2][3] / nz3
	local vx = nz1 * mat[1][1] + nz2 * mat[1][2] + nz3 * mat[1][3]
	local vz = nz1 * mat[3][1] + nz2 * mat[3][2] + nz3 * mat[3][3]
	return math.deg(math.asin(mat[2][3])), -math.deg(math.atan2(vx, vz)), -math.deg(math.atan2(mat[2][1], mat[2][2]))
end
function getPositionFromMatrixOffset(mat, x, y, z)
	return x * mat[1][1] + y * mat[2][1] + z * mat[3][1] + mat[4][1], x * mat[1][2] + y * mat[2][2] + z * mat[3][2] + mat[4][2], x * mat[1][3] + y * mat[2][3] + z * mat[3][3] + mat[4][3]
end
function matrixMultiply(mat1, mat2)
	local matOut = {}
	for i = 1, #mat1 do
		matOut[i] = {}
		for j = 1, #mat2[1] do
			local num = mat1[i][1] * mat2[1][j]
			for n = 2, #mat1[1] do
				num = num + mat1[i][n] * mat2[n][j]
			end
			matOut[i][j] = num
		end
	end
	return matOut
end
screenX, screenY = guiGetScreenSize()
dashboardGridSize = {6, 4}
dashboardPadding = {
	screenX <= 1366 and math.floor(screenX * 0.075) or math.floor(screenX * 0.15),
	math.floor(screenY * 0.15),
	screenX <= 1366 and (screenX <= 1024 and 2 or 3) or 4
}
oneSize = {
	math.floor((screenX - dashboardPadding[1] * 2) / dashboardGridSize[1] / 10 + 0.5) * 10,
	math.floor((screenY - dashboardPadding[2] * 2) / dashboardGridSize[2] / 10 + 0.5) * 10
}
dashSize = {
	oneSize[1] * dashboardGridSize[1],
	oneSize[2] * dashboardGridSize[2]
}
dashboardPos = {
	screenX / 2 - dashSize[1] / 2,
	screenY / 2 - dashSize[2] / 2
}
imageSizes = screenX <= 1300 and 128 or screenX <= 1600 and 196 or 256
bebasSize = math.floor(screenX / 64)
dashboardGui = false
local screenShader = false
screenSrc = false
local expandTime = 750
local curtainTime = 350
dashboardLayout = {}
for i = 1, dashboardGridSize[1] do
	dashboardLayout[i] = {}
end
backgroundSizes = {}
local charDatas = {}
function drawAccountInfo(x, y, sx, sy, rtg, i, j)
	for k = 1, #charDatas do
		local label = sightexports.sGui:createGuiElement("label", x, y, sx, sy, rtg)
		sightexports.sGui:setLabelFont(label, "12/Ubuntu-R.ttf")
		sightexports.sGui:setLabelAlignment(label, "left", "top")
		sightexports.sGui:setLabelText(label, charDatas[k][1])
		table.insert(dashboardLayout[i][j].labels, label)
		local label = sightexports.sGui:createGuiElement("label", x + sightexports.sGui:getLabelTextWidth(label), y, sx, sy, rtg)
		sightexports.sGui:setLabelFont(label, "12/Ubuntu-L.ttf")
		sightexports.sGui:setLabelAlignment(label, "left", "top")
		sightexports.sGui:setLabelText(label, charDatas[k][2])
		table.insert(dashboardLayout[i][j].labels, label)
		y = y + sightexports.sGui:getLabelFontHeight(label)
	end
end
function getDiscordInvitation()
	sightexports.sGui:showInfobox("i", "A hír további olvasásához csatlakozz a discord szerverünkre!")
	return false
end
function checkIfGroupsAvailable()
	local myGroups = sightexports.sGroups:getPlayerGroupMembership()
	local count = 0
	for k in pairs(myGroups) do
		count = count + 1
		break
	end
	local retVal = 0 < count
	if not retVal then
		sightexports.sGui:showInfobox("e", "Nem vagy egy frakció tagja sem!")
	end
	return retVal
end
ppBalance = 0
ppLabelElement = false
ppLabelElement2 = false
function drawPremiumInfo(x, y, sx, sy, rtg, i, j)
	local label = sightexports.sGui:createGuiElement("label", x, y, sx, sy, rtg)
	sightexports.sGui:setLabelFont(label, "12/Ubuntu-L.ttf")
	sightexports.sGui:setLabelAlignment(label, "right", "bottom")
	sightexports.sGui:setLabelColor(label, "sightblue")
	sightexports.sGui:setLabelText(label, sightexports.sGui:thousandsStepper(ppBalance) .. " PP")
	ppLabelElement = label
	table.insert(dashboardLayout[i][j].labels, label)
	local label = sightexports.sGui:createGuiElement("label", x, y, sx - sightexports.sGui:getLabelTextWidth(label), sy, rtg)
	sightexports.sGui:setLabelFont(label, "12/Ubuntu-R.ttf")
	sightexports.sGui:setLabelAlignment(label, "right", "bottom")
	sightexports.sGui:setLabelText(label, "Egyenleg: ")
	ppLabelElement2 = label
	table.insert(dashboardLayout[i][j].labels, label)
end
--[[
local latestNews = {
    newsTitle = "Aranybank",
    newsDate = "2025.02.15",
    newsBadge = {
        [1] = {"Hotfix", "sightblue"},
        [3] = {"Update", "sightgreen"},
        [4] = {"Aranybankrablás", "sightyellow"},
    }
}
	]]
function drawChangelogInfo(x, y, sx, sy, rtg, i, j)
	local fh = sightexports.sGui:getFontHeight("12/Ubuntu-B.ttf")
	local fh2 = sightexports.sGui:getFontHeight("10/Ubuntu-R.ttf")
	local bh = 0
	local by = 0
	if 0 < #latestNews.newsBadge then
		bh = sightexports.sGui:getFontHeight("10/Ubuntu-R.ttf") + 8
		by = -bh - 5
	end
	local bx = x + sx
	for k = #latestNews.newsBadge, 1, -1 do
		local w = sightexports.sGui:getTextWidthFont(latestNews.newsBadge[k][1], "10/Ubuntu-R.ttf") + 8
		bx = bx - w - 4
		if bx < 0 then
			bx = x + sx - w - 4
			by = by - bh - 5
		end
		local rect = sightexports.sGui:createGuiElement("rectangle", bx + 4, y + sy + by + 5, w, bh, rtg)
		sightexports.sGui:setGuiBackground(rect, "solid", latestNews.newsBadge[k][2])
		table.insert(dashboardLayout[i][j].labels, rect)
		local label = sightexports.sGui:createGuiElement("label", bx + 4, y + sy + by + 5, w, bh, rtg)
		sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
		sightexports.sGui:setLabelAlignment(label, "center", "center")
		sightexports.sGui:setLabelColor(label, "#000000")
		sightexports.sGui:setLabelText(label, latestNews.newsBadge[k][1])
		table.insert(dashboardLayout[i][j].labels, label)
	end
	local label = sightexports.sGui:createGuiElement("label", x, y + sy + by - fh2 - fh * 4, sx, fh * 4, rtg)
	sightexports.sGui:setLabelFont(label, "12/Ubuntu-B.ttf")
	sightexports.sGui:setLabelAlignment(label, "right", "bottom")
	sightexports.sGui:setLabelText(label, latestNews.newsTitle)
	sightexports.sGui:setLabelWordBreak(label, true)
	sightexports.sGui:setLabelShadow(label, "#000000ae", 1, 1)
	table.insert(dashboardLayout[i][j].labels, label)
	local label = sightexports.sGui:createGuiElement("label", x, y + sy + by - fh2, sx, fh2, rtg)
	sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
	sightexports.sGui:setLabelAlignment(label, "right", "center")
	sightexports.sGui:setLabelText(label, latestNews.newsDate)
	sightexports.sGui:setLabelShadow(label, "#000000ae", 1, 1)
	table.insert(dashboardLayout[i][j].labels, label)
end
vehicleLimitLabel = false
function drawVehiclesInfo(x, y, sx, sy, rtg, i, j)
	local label = sightexports.sGui:createGuiElement("label", x, y, sx, sy, rtg)
	sightexports.sGui:setLabelFont(label, bebasSize .. "/BebasNeueBold.otf")
	sightexports.sGui:setLabelAlignment(label, "left", "top")
	sightexports.sGui:setLabelText(label, "SLOTOK: ")
	table.insert(dashboardLayout[i][j].labels, label)
	local label = sightexports.sGui:createGuiElement("label", x + sightexports.sGui:getLabelTextWidth(label), y, sx, sy, rtg)
	sightexports.sGui:setLabelFont(label, bebasSize .. "/BebasNeueLight.otf")
	sightexports.sGui:setLabelAlignment(label, "left", "top")
	sightexports.sGui:setLabelText(label, vehLimit)
	vehicleLimitLabel = label
	table.insert(dashboardLayout[i][j].labels, label)
end
local farmNum = 0
local rentableNum = 0
local farmNumLabel = false
local rentableNumLabel = false
local intiLimitLabel = false
local ownInteriorLabel = false
function drawInteriorsInfo(x, y, sx, sy, rtg, i, j)
	local label = sightexports.sGui:createGuiElement("label", x, y, sx, sy, rtg)
	sightexports.sGui:setLabelFont(label, bebasSize .. "/BebasNeueBold.otf")
	sightexports.sGui:setLabelAlignment(label, "left", "top")
	sightexports.sGui:setLabelText(label, "SAJÁT TULAJDON: ")
	table.insert(dashboardLayout[i][j].labels, label)
	local label = sightexports.sGui:createGuiElement("label", x + sightexports.sGui:getLabelTextWidth(label), y, sx, sy, rtg)
	sightexports.sGui:setLabelFont(label, bebasSize .. "/BebasNeueLight.otf")
	sightexports.sGui:setLabelAlignment(label, "left", "top")
	sightexports.sGui:setLabelText(label, interiorLimit)
	ownInteriorLabel = label
	table.insert(dashboardLayout[i][j].labels, label)
	y = y + sightexports.sGui:getLabelFontHeight(label)
	local label = sightexports.sGui:createGuiElement("label", x, y, sx, sy, rtg)
	sightexports.sGui:setLabelFont(label, bebasSize .. "/BebasNeueBold.otf")
	sightexports.sGui:setLabelAlignment(label, "left", "top")
	sightexports.sGui:setLabelText(label, "BÉRLEMÉNYEK: ")
	table.insert(dashboardLayout[i][j].labels, label)
	local label = sightexports.sGui:createGuiElement("label", x + sightexports.sGui:getLabelTextWidth(label), y, sx, sy, rtg)
	sightexports.sGui:setLabelFont(label, bebasSize .. "/BebasNeueLight.otf")
	sightexports.sGui:setLabelAlignment(label, "left", "top")
	sightexports.sGui:setLabelText(label, rentableNum)
	rentableNumLabel = label
	table.insert(dashboardLayout[i][j].labels, label)
	y = y + sightexports.sGui:getLabelFontHeight(label)
	local label = sightexports.sGui:createGuiElement("label", x, y, sx, sy, rtg)
	sightexports.sGui:setLabelFont(label, bebasSize .. "/BebasNeueBold.otf")
	sightexports.sGui:setLabelAlignment(label, "left", "top")
	sightexports.sGui:setLabelText(label, "SLOTOK: ")
	table.insert(dashboardLayout[i][j].labels, label)
	local label = sightexports.sGui:createGuiElement("label", x + sightexports.sGui:getLabelTextWidth(label), y, sx, sy, rtg)
	sightexports.sGui:setLabelFont(label, bebasSize .. "/BebasNeueLight.otf")
	sightexports.sGui:setLabelAlignment(label, "left", "top")
	sightexports.sGui:setLabelText(label, farmNum)
	intiLimitLabel = label
	table.insert(dashboardLayout[i][j].labels, label)
end
adminList = {}
local adminRtg = false
local adminSize = {0, 0}
local adminPos = {0, 0}
local adminInside = false
local reportMode = false
function drawSideReport(x, y, sx, sy, btn)
	local w = sx / 3
	local label = sightexports.sGui:createGuiElement("label", x + dashboardPadding[3] * 4, y + dashboardPadding[3] * 4, w, 32, adminInside)
	sightexports.sGui:setLabelFont(label, "18/BebasNeueRegular.otf")
	sightexports.sGui:setLabelAlignment(label, "left", "center")
	sightexports.sGui:setLabelText(label, "Report rendszer")
	y = y + 4
	local label = sightexports.sGui:createGuiElement("label", x + dashboardPadding[3] * 4, y + dashboardPadding[3] * 6 + 32, w - dashboardPadding[3] * 8, sy, adminInside)
	sightexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
	sightexports.sGui:setLabelAlignment(label, "left", "top")
	sightexports.sGui:setLabelWordBreak(label, true)
	sightexports.sGui:setLabelText(label, "Ha bármilyen problémába ütköznél, esetleg kérdésed lenne, itt, a Report rendszeren keresztül tudsz segítséget kérni.\n\nHasználd a Report létrehozása gombot ahhoz, hogy üzenetet - bejelentést küldj az adminisztrátor csapat felé.\n\nA bejelentésed kategóriáját válaszd ki megfelelően, minél egyszerűbben és lényegre törően fogalmazd meg a kérdésed/problémád.\n\nA bejelentés megírását követően, az online Adminisztrátor csapat fogja kezelni az ügyed, és ha bárki fogadja azt, értesülni fogsz róla. Ezután az üzenetváltó ablakban fogsz tudni kommunikálni.")
	if btn then
		local btn = sightexports.sGui:createGuiElement("button", x + dashboardPadding[3] * 4, y + sy - dashboardPadding[3] - 30, w - dashboardPadding[3] * 8, 30, adminInside)
		sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
		sightexports.sGui:setGuiHover(btn, "gradient", {
			"sightgreen",
			"sightgreen-second"
		})
		sightexports.sGui:setButtonFont(btn, "13/BebasNeueBold.otf")
		sightexports.sGui:setButtonTextColor(btn, "#ffffff")
		sightexports.sGui:setButtonText(btn, "Report létrehozása")
		sightexports.sGui:setClickEvent(btn, "openReportGui")
	end
end
local reportCategoryButtons = {}
local selectedReportCategory = false
addEvent("selectReportCategory", false)
addEventHandler("selectReportCategory", getRootElement(), function(button, state, absoluteX, absoluteY, el)
	selectedReportCategory = reportCategoryButtons[el]
	for k in pairs(reportCategoryButtons) do
		if k == el then
			sightexports.sGui:setGuiBackground(k, "solid", "sightgreen")
			sightexports.sGui:setGuiHover(k, "gradient", {
				"sightgreen",
				"sightgreen-second"
			}, true)
		else
			sightexports.sGui:setGuiBackground(k, "solid", "sightgrey3")
			sightexports.sGui:setGuiHover(k, "gradient", {"sightgrey3", "sightgrey2"}, true)
		end
	end
end)
local reportTitleInput = false
local reportDescriptionInput = false
addEvent("closeReportGui", false)
addEventHandler("closeReportGui", getRootElement(), function()
	reportMode = false
	if adminInside then
		sightexports.sGui:deleteGuiElement(adminInside)
	end
	drawAdminList()
end)
addEvent("sendAdminReport", false)
addEventHandler("sendAdminReport", getRootElement(), function()
	local reportTitle = sightexports.sGui:getInputValue(reportTitleInput)
	local reportDescription = sightexports.sGui:getInputValue(reportDescriptionInput)
	if not selectedReportCategory then
		sightexports.sGui:showInfobox("e", "Válassz kategóriát!")
	elseif not reportTitle or utf8.len(reportTitle) < 1 then
		sightexports.sGui:showInfobox("e", "Add meg a bejelentés címét!")
	elseif not reportTitle or utf8.len(reportDescription) < 1 then
		sightexports.sGui:showInfobox("e", "Add meg a bejelentés leírását!")
	else
		reportMode = false
		if adminInside then
			sightexports.sGui:deleteGuiElement(adminInside)
		end
		drawAdminList()
		triggerServerEvent("createReport", localPlayer, reportTitle, selectedReportCategory, reportDescription)
	end
end)
addEvent("openReportGui", false)
addEventHandler("openReportGui", getRootElement(), function()
	reportMode = true
	if adminInside then
		sightexports.sGui:deleteGuiElement(adminInside)
	end
	local x, y = adminPos[1], adminPos[2]
	local sx, sy = adminSize[1], adminSize[2]
	adminInside = sightexports.sGui:createGuiElement("null", x, y, sx, sy, adminRtg)
	x, y = 0, 0
	drawSideReport(x, y, sx, sy)
	local n = 20
	local h = math.floor(sy / n)
	local border = sightexports.sGui:createGuiElement("hr", x + sx / 3 - 1, y + dashboardPadding[3] * 4, 2, h * n, adminInside)
	sightexports.sGui:setGuiHrColor(border, "sightgrey3", "sightgrey2")
	local w = sx / 3
	local x = w + dashboardPadding[3] * 4
	local label = sightexports.sGui:createGuiElement("label", x, y + dashboardPadding[3] * 4, w, 32, adminInside)
	sightexports.sGui:setLabelFont(label, "18/BebasNeueRegular.otf")
	sightexports.sGui:setLabelAlignment(label, "left", "center")
	sightexports.sGui:setLabelText(label, "Report létrehozása")
	local y = y + 32 + dashboardPadding[3] * 8
	local label = sightexports.sGui:createGuiElement("label", x, y, 2 * w, 24, adminInside)
	sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
	sightexports.sGui:setLabelAlignment(label, "left", "top")
	sightexports.sGui:setLabelWordBreak(label, true)
	sightexports.sGui:setLabelText(label, "Cím:")
	y = y + 24 + dashboardPadding[3]
	reportTitleInput = sightexports.sGui:createGuiElement("input", x, y, w - dashboardPadding[3] * 8, 32, adminInside)
	sightexports.sGui:setInputPlaceholder(reportTitleInput, "Bejelentés rövid címe")
	sightexports.sGui:setInputFont(reportTitleInput, "10/Ubuntu-R.ttf")
	sightexports.sGui:setInputIcon(reportTitleInput, "pen")
	sightexports.sGui:setInputMaxLength(reportTitleInput, 32)
	y = y + 32 + dashboardPadding[3] * 2
	local label = sightexports.sGui:createGuiElement("label", x, y, 2 * w, 24, adminInside)
	sightexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
	sightexports.sGui:setLabelAlignment(label, "left", "top")
	sightexports.sGui:setLabelWordBreak(label, true)
	sightexports.sGui:setLabelText(label, "Fogalmazd meg a problémád pár szóban, ez alapján az adminok könnyebben tudják kezelni az ügyeket.")
	sightexports.sGui:setLabelColor(label, {
		220,
		220,
		220
	})
	y = y + 24 + dashboardPadding[3] * 4
	local label = sightexports.sGui:createGuiElement("label", x, y, 2 * w, 24, adminInside)
	sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
	sightexports.sGui:setLabelAlignment(label, "left", "top")
	sightexports.sGui:setLabelWordBreak(label, true)
	sightexports.sGui:setLabelText(label, "Kategória:")
	y = y + 24 + dashboardPadding[3]
	local categories = sightexports.sReports:getReportCategories()
	selectedReportCategory = false
	reportCategoryButtons = {}
	local w = 0
	for i = 1, #categories do
		local btnW = sightexports.sGui:getTextWidthFont(categories[i], "11/BebasNeueRegular.otf") + 20
		local btn = sightexports.sGui:createGuiElement("button", x + w, y, btnW - dashboardPadding[3], 24, adminInside)
		sightexports.sGui:setGuiBackground(btn, "solid", "sightgrey3")
		sightexports.sGui:setGuiHover(btn, "gradient", {"sightgrey3", "sightgrey2"}, true)
		sightexports.sGui:setButtonFont(btn, "11/BebasNeueRegular.otf")
		sightexports.sGui:setButtonTextColor(btn, "#ffffff")
		sightexports.sGui:setButtonText(btn, categories[i])
		sightexports.sGui:setClickEvent(btn, "selectReportCategory")
		w = w + btnW
		reportCategoryButtons[btn] = categories[i]
	end
	y = y + 24 + dashboardPadding[3] * 4
	local label = sightexports.sGui:createGuiElement("label", x, y, 2 * w, 24, adminInside)
	sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
	sightexports.sGui:setLabelAlignment(label, "left", "top")
	sightexports.sGui:setLabelWordBreak(label, true)
	sightexports.sGui:setLabelText(label, "Hosszabb leírás:")
	y = y + 24 + dashboardPadding[3]
	local w = w + dashboardPadding[3] * 10
	reportDescriptionInput = sightexports.sGui:createGuiElement("input", x, y, w, 256, adminInside)
	sightexports.sGui:setInputFont(reportDescriptionInput, "10/Ubuntu-R.ttf")
	sightexports.sGui:setInputPlaceholder(reportDescriptionInput, "Leírás")
	sightexports.sGui:setInputMaxLength(reportDescriptionInput, 750)
	sightexports.sGui:setInputMultiline(reportDescriptionInput, true)
	sightexports.sGui:setInputFontPaddingHeight(reportDescriptionInput, 32)
	y = y + 256 + dashboardPadding[3] * 4
	local btn = sightexports.sGui:createGuiElement("button", x, y, (w - dashboardPadding[3] * 4) / 2, 30, adminInside)
	sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
	sightexports.sGui:setGuiHover(btn, "gradient", {
		"sightgreen",
		"sightgreen-second"
	})
	sightexports.sGui:setButtonFont(btn, "13/BebasNeueBold.otf")
	sightexports.sGui:setButtonTextColor(btn, "#ffffff")
	sightexports.sGui:setButtonText(btn, "Elküldés")
	sightexports.sGui:setClickEvent(btn, "sendAdminReport")
	local btn = sightexports.sGui:createGuiElement("button", x + (w - dashboardPadding[3] * 4) / 2 + dashboardPadding[3] * 4, y, (w - dashboardPadding[3] * 4) / 2, 30, adminInside)
	sightexports.sGui:setGuiBackground(btn, "solid", "sightred")
	sightexports.sGui:setGuiHover(btn, "gradient", {
		"sightred",
		"sightred-second"
	})
	sightexports.sGui:setButtonFont(btn, "13/BebasNeueBold.otf")
	sightexports.sGui:setButtonTextColor(btn, "#ffffff")
	sightexports.sGui:setButtonText(btn, "Mégsem")
	sightexports.sGui:setClickEvent(btn, "closeReportGui")
end)
function drawAdminList()
	local x, y = adminPos[1], adminPos[2]
	local sx, sy = adminSize[1], adminSize[2]
	adminInside = sightexports.sGui:createGuiElement("null", x, y, sx, sy, adminRtg)
	local rtg = adminInside
	local n = 20
	local w = sx / 3
	local sy = sy - dashboardPadding[3] * 4
	local h = math.floor(sy / n)
	local canSeeId = sightexports.sPermission:hasPermission(localPlayer, "canSeeAdminId")
	local fh = sightexports.sGui:getFontHeight("14/BebasNeueRegular.otf")
	local id = 1
	for i = 0, n - 1 do
		for j = 1, 2 do
			local bbox = sightexports.sGui:createGuiElement("null", x + j * w + dashboardPadding[3] * 4, y + dashboardPadding[3] * 4 + i * h, w - dashboardPadding[3] * 8, h, rtg)
			if i == 0 then
				local bcg = sightexports.sGui:createGuiElement("rectangle", x + j * w + dashboardPadding[3] * 4, y + dashboardPadding[3] * 4 + i * h, w - dashboardPadding[3] * 8, h, rtg)
				sightexports.sGui:setGuiBackground(bcg, "solid", "sightgrey2")
				local label = sightexports.sGui:createGuiElement("label", x + j * w + dashboardPadding[3] * 4 + w * 0.075, y + dashboardPadding[3] * 4 + i * h, w - dashboardPadding[3] * 8, h, rtg)
				sightexports.sGui:setLabelFont(label, "14/BebasNeueBold.otf")
				sightexports.sGui:setLabelAlignment(label, "left", "center")
				sightexports.sGui:setLabelText(label, "Név")
				local label = sightexports.sGui:createGuiElement("label", x + j * w + dashboardPadding[3] * 4 + 4, y + dashboardPadding[3] * 4 + i * h, w * 0.05, h, rtg)
				sightexports.sGui:setLabelFont(label, "14/BebasNeueBold.otf")
				sightexports.sGui:setLabelAlignment(label, "center", "center")
				sightexports.sGui:setLabelText(label, "ID")
				local label = sightexports.sGui:createGuiElement("label", x + j * w + dashboardPadding[3] * 4, y + dashboardPadding[3] * 4 + i * h, w - dashboardPadding[3] * 8 - 8, h, rtg)
				sightexports.sGui:setLabelFont(label, "14/BebasNeueBold.otf")
				sightexports.sGui:setLabelAlignment(label, "right", "center")
				sightexports.sGui:setLabelText(label, "Adminszint")
			else
				if adminList[id] then
					local col = "sightgreen"
					local text = "Admin " .. adminList[id][1]
					if adminList[id][1] == 11 then -- Tulaj
						col = "sightred"
						text = "Tulajdonos"
					elseif adminList[id][1] == 10 then -- Fejlesztő
						col = "sightblue"
						text = "Fejlesztő"
					elseif adminList[id][1] == 9 then -- Rendszergazda
						col = "sightblue-second"
						text = "SysEngineer"
					elseif adminList[id][1] == 8 then -- Manager
						col = "sightgreen-second"
						text = "Manager"
					elseif adminList[id][1] == 7 then
						col = "sightorange"
						text = "SzuperAdmin"
					elseif adminList[id][1] == 6 then
						col = "sightyellow"
						text = "FőAdmin"
					elseif adminList[id][1] == -1 then
						col = helperColor
						text = "IDG AS"
					elseif adminList[id][1] == -2 then
						col = helperColor
						text = "SGH AS"
					end
					local label = sightexports.sGui:createGuiElement("label", x + j * w + dashboardPadding[3] * 4 + w * 0.075, y + dashboardPadding[3] * 4 + i * h, w * -dashboardPadding[3] * 8, h, rtg)
					sightexports.sGui:setLabelFont(label, "14/BebasNeueRegular.otf")
					sightexports.sGui:setLabelAlignment(label, "left", "center")
					if adminList[id][4] then
						sightexports.sGui:setLabelColor(label, col)
						sightexports.sGui:setGuiHoverable(label, true)
						sightexports.sGui:setGuiBoundingBox(label, bbox)
						sightexports.sGui:guiSetTooltip(label, "Szolgálatban. Segítségkérésre használd a 'Report létrehozása' gombot!")
						sightexports.sGui:setLabelText(label, adminList[id][3])
						local label = sightexports.sGui:createGuiElement("label", x + j * w + dashboardPadding[3] * 4 + 4, y + dashboardPadding[3] * 4 + i * h, w * 0.05, h, rtg)
						sightexports.sGui:setLabelFont(label, "14/BebasNeueRegular.otf")
						sightexports.sGui:setLabelAlignment(label, "center", "center")
						sightexports.sGui:setLabelText(label, adminList[id][2])
						sightexports.sGui:setLabelColor(label, col)
						sightexports.sGui:setGuiHoverable(label, true)
						sightexports.sGui:setGuiBoundingBox(label, bbox)
						sightexports.sGui:guiSetTooltip(label, "Szolgálatban. Segítségkérésre használd a 'Report létrehozása' gombot!")
					else
						sightexports.sGui:setLabelText(label, adminList[id][3])
						sightexports.sGui:setLabelColor(label, "sightlightgrey")
						local icon = sightexports.sGui:createGuiElement("image", x + j * w + dashboardPadding[3] * 4 + 4 + w * 0.05 / 2 - fh / 2, y + dashboardPadding[3] * 4 + i * h + h / 2 - fh / 2, fh, fh, rtg)
						sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("eye-slash", fh))
						if canSeeId then
							sightexports.sGui:setGuiHoverable(icon, true)
							sightexports.sGui:setGuiHover(icon, "solid", "sightgreen")
							sightexports.sGui:guiSetTooltip(icon, "ID: " .. adminList[id][2])
						end
					end
					local label = sightexports.sGui:createGuiElement("label", x + j * w + dashboardPadding[3] * 4, y + dashboardPadding[3] * 4 + i * h, w - dashboardPadding[3] * 8 - 8, h, rtg)
					sightexports.sGui:setLabelFont(label, "14/BebasNeueRegular.otf")
					sightexports.sGui:setLabelAlignment(label, "right", "center")
					sightexports.sGui:setLabelText(label, text)
					if adminList[id][4] then
						sightexports.sGui:setLabelColor(label, col)
						sightexports.sGui:guiSetTooltip(label, "Szolgálatban. Segítségkérésre használd a 'Report létrehozása' gombot!")
						sightexports.sGui:setGuiHoverable(label, true)
						sightexports.sGui:setGuiBoundingBox(label, bbox)
					else
						sightexports.sGui:setLabelColor(label, "sightlightgrey")
					end
				end
				id = id + 1
			end
			if i < n - 1 then
				local border = sightexports.sGui:createGuiElement("hr", x + j * w + dashboardPadding[3] * 4, y + dashboardPadding[3] * 4 + (i + 1) * h - 1, w - dashboardPadding[3] * 8, 2, rtg)
				sightexports.sGui:setGuiHrColor(border, "sightgrey3", "sightgrey2")
			end
		end
	end
	local border = sightexports.sGui:createGuiElement("hr", x + sx / 3 - 1, y + dashboardPadding[3] * 4, 2, h * n, rtg)
	sightexports.sGui:setGuiHrColor(border, "sightgrey3", "sightgrey2")
	local border = sightexports.sGui:createGuiElement("hr", x + sx / 3 * 2 - 1, y + dashboardPadding[3] * 4, 2, h * n, rtg)
	sightexports.sGui:setGuiHrColor(border, "sightgrey3", "sightgrey2")
	drawSideReport(x, y, sx, sy, true)
end
function adminInsideDestroy()
	reportMode = false
end
function drawAdminInside(x, y, sx, sy, i, j, rtg)
	adminRtg = rtg
	adminPos = {x, y}
	adminSize = {sx, sy}
	drawAdminList()
end
function adminSort(a, b)
	if (a[4] and 1 or 0) ~= (b[4] and 1 or 0) then
		return (a[4] and 1 or 0) > (b[4] and 1 or 0)
	end
	if a[1] ~= b[1] then
		return a[1] < b[1]
	end
	if a[2] ~= b[2] then
		return a[2] < b[2]
	end
end
function drawAdminsInfo(x, y, sx, sy, rtg, i, j)
	sy = sy + y - dashboardPadding[3] * 2
	y = dashboardPadding[3] * 2
	local dutyNum = 0
	local adminNum = 0
	local asNum = 0
	adminList = {}
	local players = getElementsByType("player")
	for i = 1, #players do
		if players[i] and getElementData(players[i], "loggedIn") then
			local level = getElementData(players[i], "acc.adminLevel") or 0
			if 1 <= level and not getElementData(players[i], "hideOnline") then
				local duty = getElementData(players[i], "adminDuty")
				if level <= 7 then
					adminNum = adminNum + 1
					if duty then
						dutyNum = dutyNum + 1
					end
				end
				table.insert(adminList, {
					level,
					getElementData(players[i], "playerID"),
					getElementData(players[i], "acc.adminNick"),
					duty
				})
			end
			level = getElementData(players[i], "acc.helperLevel") or 0
			if 0 < level then
				asNum = asNum + 1
				table.insert(adminList, {
					-level,
					getElementData(players[i], "playerID"),
					getElementData(players[i], "visibleName"):gsub("_", " "),
					true
				})
			end
		end
	end
	table.sort(adminList, adminSort)
	local fs = math.floor(bebasSize * 0.75 + 0.5)
	local fh = sightexports.sGui:getFontHeight(fs .. "/BebasNeueBold.otf")
	local w = sightexports.sGui:getTextWidthFont(dutyNum, fs .. "/BebasNeueBold.otf") + sightexports.sGui:getTextWidthFont(" ADMINDUTY", fs .. "/BebasNeueLight.otf")
	local label = sightexports.sGui:createGuiElement("label", x + sx / 2 - w / 2, y + fh * 1.25, sx, sy, rtg)
	sightexports.sGui:setLabelFont(label, fs .. "/BebasNeueBold.otf")
	sightexports.sGui:setLabelAlignment(label, "left", "top")
	sightexports.sGui:setLabelText(label, dutyNum)
	sightexports.sGui:setLabelColor(label, "sightgreen")
	table.insert(dashboardLayout[i][j].labels, label)
	local label = sightexports.sGui:createGuiElement("label", x + sx / 2 - w / 2 + sightexports.sGui:getLabelTextWidth(label), y + fh * 1.25, sx, sy, rtg)
	sightexports.sGui:setLabelFont(label, fs .. "/BebasNeueLight.otf")
	sightexports.sGui:setLabelAlignment(label, "left", "top")
	sightexports.sGui:setLabelText(label, " ADMINDUTY")
	table.insert(dashboardLayout[i][j].labels, label)
	local w = sightexports.sGui:getTextWidthFont(asNum, fs .. "/BebasNeueBold.otf") + sightexports.sGui:getTextWidthFont(" ADMINSEGÉD", fs .. "/BebasNeueLight.otf")
	local label = sightexports.sGui:createGuiElement("label", x + sx / 2 - w / 2, y + fh * 2.25, sx, sy, rtg)
	sightexports.sGui:setLabelFont(label, fs .. "/BebasNeueBold.otf")
	sightexports.sGui:setLabelAlignment(label, "left", "top")
	sightexports.sGui:setLabelText(label, asNum)
	sightexports.sGui:setLabelColor(label, helperColor)
	table.insert(dashboardLayout[i][j].labels, label)
	local label = sightexports.sGui:createGuiElement("label", x + sx / 2 - w / 2 + sightexports.sGui:getLabelTextWidth(label), y + fh * 2.25, sx, sy, rtg)
	sightexports.sGui:setLabelFont(label, fs .. "/BebasNeueLight.otf")
	sightexports.sGui:setLabelAlignment(label, "left", "top")
	sightexports.sGui:setLabelText(label, " ADMINSEGÉD")
	table.insert(dashboardLayout[i][j].labels, label)
	local label = sightexports.sGui:createGuiElement("label", x, y, sx, sy, rtg)
	sightexports.sGui:setLabelFont(label, "12/Ubuntu-L.ttf")
	sightexports.sGui:setLabelAlignment(label, "right", "bottom")
	sightexports.sGui:setLabelText(label, adminNum)
	table.insert(dashboardLayout[i][j].labels, label)
	local label = sightexports.sGui:createGuiElement("label", x, y, sx - sightexports.sGui:getLabelTextWidth(label), sy, rtg)
	sightexports.sGui:setLabelFont(label, "12/Ubuntu-R.ttf")
	sightexports.sGui:setLabelAlignment(label, "right", "bottom")
	sightexports.sGui:setLabelText(label, "Online adminisztrátorok: ")
	table.insert(dashboardLayout[i][j].labels, label)
end
local charSetObjs = {}
local charSetPed = false
local charPedSrc = false
local charPedShad = false
local charObjShads = {}
local charPedItems = {}
function charInfoInsideDraw(x, y, sx, sy, i, j, rtg)
	money = sightexports.sCore:getMoney()
	local img = sightexports.sGui:createGuiElement("image", x, y, sx / 2, sy, rtg)
	sightexports.sGui:setImageFile(img, charPedSrc)
	local shadX, shadY = sightexports.sGui:getGuiRealPosition(img)
	local shadSx, shadSy = sightexports.sGui:getGuiSize(img)
	sightexports.sGui:setImageUV(img, shadX, shadY, shadSx, shadSy)
	sightexports.sGui:setImageShadow(img, 5, 2, -2, {
		0,
		0,
		0,
		89.25
	})
	local psx, psy = shadSx / screenX / 2, shadSy / screenY / 2
	local ppx, ppy = shadX / screenX + psx - 0.5, -(shadY / screenY + psy - 0.5)
	ppx, ppy = 2 * ppx, 2 * ppy
	dxSetShaderValue(charPedShad, "sMoveObject2D", ppx, ppy)
	dxSetShaderValue(charPedShad, "sScaleObject2D", 2 * math.min(psx, psy), 2 * math.min(psx, psy))
	dxSetShaderValue(charPedShad, "sRealScale2D", 2 * psx, 2 * psy)
	for i = 1, #charObjShads do
		dxSetShaderValue(charObjShads[i], "sMoveObject2D", ppx, ppy)
		dxSetShaderValue(charObjShads[i], "sScaleObject2D", 2 * math.min(psx, psy), 2 * math.min(psx, psy))
		dxSetShaderValue(charObjShads[i], "sRealScale2D", 2 * psx, 2 * psy)
	end
	local h = sightexports.sGui:getFontHeight("12/Ubuntu-R.ttf") * 1.25
	local oh = h * 15
	x = math.floor(sx / 2)
	y = dashboardPadding[3] * 8
	local border = sightexports.sGui:createGuiElement("hr", x - 1, sy / 2 - oh / 2, 2, oh, rtg)
	sightexports.sGui:setGuiHrColor(border, "sightgrey3", "sightgrey2")
	y = sy / 2 - oh / 2
	x = x + dashboardPadding[3] * 4
	local label = sightexports.sGui:createGuiElement("label", x, y, sx, h * 2, rtg)
	sightexports.sGui:setLabelFont(label, "22/BebasNeueBold.otf")
	sightexports.sGui:setLabelAlignment(label, "left", "center")
	sightexports.sGui:setLabelText(label, getElementData(localPlayer, "visibleName"):gsub("_", " "))
	sightexports.sGui:setLabelColor(label, "sightgreen")
	y = y + h * 2
	local label = sightexports.sGui:createGuiElement("label", x, y, sx, h, rtg)
	sightexports.sGui:setLabelFont(label, "12/Ubuntu-R.ttf")
	sightexports.sGui:setLabelAlignment(label, "left", "center")
	sightexports.sGui:setLabelText(label, "Account ID: ")
	local w = sightexports.sGui:getLabelTextWidth(label)
	local label = sightexports.sGui:createGuiElement("label", x + w, y, sx, h, rtg)
	sightexports.sGui:setLabelFont(label, "12/Ubuntu-L.ttf")
	sightexports.sGui:setLabelAlignment(label, "left", "center")
	sightexports.sGui:setLabelText(label, getElementData(localPlayer, "char.accID"))
	sightexports.sGui:setLabelColor(label, "sightgreen")
	y = y + h
	local label = sightexports.sGui:createGuiElement("label", x, y, sx, h, rtg)
	sightexports.sGui:setLabelFont(label, "12/Ubuntu-R.ttf")
	sightexports.sGui:setLabelAlignment(label, "left", "center")
	sightexports.sGui:setLabelText(label, "Karakter ID: ")
	local w = sightexports.sGui:getLabelTextWidth(label)
	local label = sightexports.sGui:createGuiElement("label", x + w, y, sx, h, rtg)
	sightexports.sGui:setLabelFont(label, "12/Ubuntu-L.ttf")
	sightexports.sGui:setLabelAlignment(label, "left", "center")
	sightexports.sGui:setLabelText(label, getElementData(localPlayer, "char.ID"))
	sightexports.sGui:setLabelColor(label, "sightgreen")
	y = y + h
	local label = sightexports.sGui:createGuiElement("label", x, y, sx, h, rtg)
	sightexports.sGui:setLabelFont(label, "12/Ubuntu-R.ttf")
	sightexports.sGui:setLabelAlignment(label, "left", "center")
	sightexports.sGui:setLabelText(label, "Játszott percek: ")
	local w = sightexports.sGui:getLabelTextWidth(label)
	local label = sightexports.sGui:createGuiElement("label", x + w, y, sx, h, rtg)
	sightexports.sGui:setLabelFont(label, "12/Ubuntu-L.ttf")
	sightexports.sGui:setLabelAlignment(label, "left", "center")
	sightexports.sGui:setLabelText(label, sightexports.sGui:thousandsStepper(playedMinutes) .. " (" .. sightexports.sGui:thousandsStepper(math.floor(playedMinutes / 60)) .. " óra)")
	sightexports.sGui:setLabelColor(label, "sightgreen")
	y = y + h
	local label = sightexports.sGui:createGuiElement("label", x, y, sx, h, rtg)
	sightexports.sGui:setLabelFont(label, "12/Ubuntu-R.ttf")
	sightexports.sGui:setLabelAlignment(label, "left", "center")
	sightexports.sGui:setLabelText(label, "Szint: ")
	local w = sightexports.sGui:getLabelTextWidth(label)
	local label = sightexports.sGui:createGuiElement("label", x + w, y, sx, h, rtg)
	sightexports.sGui:setLabelFont(label, "12/Ubuntu-L.ttf")
	sightexports.sGui:setLabelAlignment(label, "left", "center")
	sightexports.sGui:setLabelText(label, "LVL " .. sightexports.sCore:getLevel(playedMinutes))
	sightexports.sGui:setLabelColor(label, "sightgreen")
	y = y + h
	local label = sightexports.sGui:createGuiElement("label", x, y, sx, h, rtg)
	sightexports.sGui:setLabelFont(label, "12/Ubuntu-R.ttf")
	sightexports.sGui:setLabelAlignment(label, "left", "center")
	sightexports.sGui:setLabelText(label, "Járművek száma: ")
	local w = sightexports.sGui:getLabelTextWidth(label)
	local label = sightexports.sGui:createGuiElement("label", x + w, y, sx, h, rtg)
	sightexports.sGui:setLabelFont(label, "12/Ubuntu-L.ttf")
	sightexports.sGui:setLabelAlignment(label, "left", "center")
	sightexports.sGui:setLabelText(label, vehicleNum .. " db")
	sightexports.sGui:setLabelColor(label, "sightgreen")
	y = y + h
	local label = sightexports.sGui:createGuiElement("label", x, y, sx, h, rtg)
	sightexports.sGui:setLabelFont(label, "12/Ubuntu-R.ttf")
	sightexports.sGui:setLabelAlignment(label, "left", "center")
	sightexports.sGui:setLabelText(label, "Interiorok száma: ")
	local w = sightexports.sGui:getLabelTextWidth(label)
	local label = sightexports.sGui:createGuiElement("label", x + w, y, sx, h, rtg)
	sightexports.sGui:setLabelFont(label, "12/Ubuntu-L.ttf")
	sightexports.sGui:setLabelAlignment(label, "left", "center")
	sightexports.sGui:setLabelText(label, interiorNum .. " db")
	sightexports.sGui:setLabelColor(label, "sightgreen")
	y = y + h
	local label = sightexports.sGui:createGuiElement("label", x, y, sx, h, rtg)
	sightexports.sGui:setLabelFont(label, "12/Ubuntu-R.ttf")
	sightexports.sGui:setLabelAlignment(label, "left", "center")
	sightexports.sGui:setLabelText(label, "Készpénz: ")
	local w = sightexports.sGui:getLabelTextWidth(label)
	local label = sightexports.sGui:createGuiElement("label", x + w, y, sx, h, rtg)
	sightexports.sGui:setLabelFont(label, "12/Ubuntu-L.ttf")
	sightexports.sGui:setLabelAlignment(label, "left", "center")
	sightexports.sGui:setLabelText(label, sightexports.sGui:thousandsStepper(money) .. " $")
	sightexports.sGui:setLabelColor(label, money < 0 and "sightred" or "sightgreen")
	y = y + h
	local label = sightexports.sGui:createGuiElement("label", x, y, sx, h, rtg)
	sightexports.sGui:setLabelFont(label, "12/Ubuntu-R.ttf")
	sightexports.sGui:setLabelAlignment(label, "left", "center")
	sightexports.sGui:setLabelText(label, "Banki egyenleg: ")
	local w = sightexports.sGui:getLabelTextWidth(label)
	local bankMoney = sightexports.sCore:getBankMoney()
	local label = sightexports.sGui:createGuiElement("label", x + w, y, sx, h, rtg)
	sightexports.sGui:setLabelFont(label, "12/Ubuntu-L.ttf")
	sightexports.sGui:setLabelAlignment(label, "left", "center")
	sightexports.sGui:setLabelText(label, sightexports.sGui:thousandsStepper(bankMoney) .. " $")
	sightexports.sGui:setLabelColor(label, bankMoney < 0 and "sightred" or "sightgreen")
	y = y + h
end
local screenSize = {guiGetScreenSize()}
local inviteData = {
	State = false,
	Size = {250, 157},
	Position = {(screenSize[1] - 260) / 2, (screenSize[2] - 80) / 2}
}
function deleteCharRenderer()
	if isElement(charSetPed) then
		destroyElement(charSetPed)
	end
	charSetPed = nil
	if isElement(charPedSrc) then
		destroyElement(charPedSrc)
	end
	charPedSrc = nil
	if isElement(charPedShad) then
		destroyElement(charPedShad)
	end
	charPedShad = nil
	for i = 1, #charSetObjs do
		if isElement(charSetObjs[i]) then
			destroyElement(charSetObjs[i])
		end
		charSetObjs[i] = nil
	end
	for i = 1, #charObjShads do
		if isElement(charObjShads[i]) then
			destroyElement(charObjShads[i])
		end
		charObjShads[i] = nil
	end
	for i = 1, #charPedItems do
		charPedItems[i] = nil
	end
	sightlangCondHandl0(false)
end
local pedPreviewSource = " float3 sElementOffset = float3(0,0,0); float3 sWorldOffset = float3(0,0,0); float3 sCameraPosition = float3(0,0,0); float3 sCameraForward = float3(0,0,0); float3 sCameraUp = float3(0,0,0); float sFov = 1; float sAspect = 1; float2 sMoveObject2D = float2(0,0); float2 sScaleObject2D = float2(1,1); float2 sRealScale2D = float2(1,1); float sAlphaMult = 1; float sProjZMult = 2; float4 sColorFilter1 = float4(0,0,0,0); float4 sColorFilter2 = float4(0,0,0,0); texture gTexture0 < string textureState=\"0,Texture\"; >; float4x4 gProjection : PROJECTION; float4x4 gWorld : WORLD; float4x4 gWorldView : WORLDVIEW; texture secondRT < string renderTarget = \"yes\"; >; int gLighting < string renderState=\"LIGHTING\"; >; float4 gGlobalAmbient < string renderState=\"AMBIENT\"; >; int gAmbientMaterialSource < string renderState=\"AMBIENTMATERIALSOURCE\"; >; int gDiffuseMaterialSource < string renderState=\"DIFFUSEMATERIALSOURCE\"; >; int gEmissiveMaterialSource < string renderState=\"EMISSIVEMATERIALSOURCE\"; >; float4 gMaterialAmbient < string materialState=\"Ambient\"; >; float4 gMaterialDiffuse < string materialState=\"Diffuse\"; >; float4 gMaterialSpecular < string materialState=\"Specular\"; >; float4 gMaterialEmissive < string materialState=\"Emissive\"; >; int CUSTOMFLAGS <string createNormals = \"yes\"; string skipUnusedParameters = \"yes\"; >; float4 gTextureFactor < string renderState=\"TEXTUREFACTOR\"; >; sampler Sampler0 = sampler_state { Texture = (gTexture0); }; struct VSInput { float3 Position : POSITION0; float3 Normal : NORMAL0; float4 Diffuse : COLOR0; float2 TexCoord0 : TEXCOORD0; }; struct PSInput { float4 Position : POSITION0; float4 Diffuse : COLOR0; float2 TexCoord0 : TEXCOORD0; float3 Normal : TEXCOORD1; float4 vPosition : TEXCOORD2; float2 Depth : TEXCOORD3; }; float4x4 createViewMatrix( float3 pos, float3 fwVec, float3 upVec ) { float3 zaxis = normalize( fwVec); float3 xaxis = normalize( cross( -upVec, zaxis )); float3 yaxis = cross( xaxis, zaxis ); float4x4 viewMatrix = { float4( xaxis.x, yaxis.x, zaxis.x, 0 ), float4( xaxis.y, yaxis.y, zaxis.y, 0 ), float4( xaxis.z, yaxis.z, zaxis.z, 0 ), float4(-dot( xaxis, pos ), -dot( yaxis, pos ), -dot( zaxis, pos ), 1 ) }; return viewMatrix; } float4x4 createProjectionMatrix(float near_plane, float far_plane, float fov_horiz, float fov_aspect, float2 ss_mov, float2 ss_scale) { float h, w, Q; w = 1/tan(fov_horiz * 0.5); h = w/fov_aspect; Q = far_plane/(far_plane - near_plane); float4x4 projectionMatrix = { float4(w * ss_scale.x, 0, 0, 0), float4(0, h * ss_scale.y, 0, 0), float4(ss_mov.x, ss_mov.y, Q, 1), float4(0, 0, -Q*near_plane, 0) }; return projectionMatrix; } float4 MTACalcGTABuildingDiffuse( float4 InDiffuse ) { float4 OutDiffuse; if ( !gLighting ) { OutDiffuse = InDiffuse; } else { float4 ambient = gAmbientMaterialSource == 0 ? gMaterialAmbient : InDiffuse; float4 diffuse = gDiffuseMaterialSource == 0 ? gMaterialDiffuse : InDiffuse; float4 emissive = gEmissiveMaterialSource == 0 ? gMaterialEmissive : InDiffuse; OutDiffuse = gGlobalAmbient * saturate( ambient + emissive ); OutDiffuse.a *= diffuse.a; } return OutDiffuse; } PSInput VertexShaderFunction(VSInput VS) { PSInput PS = (PSInput)0; if (VS.Normal.x == 0 && VS.Normal.y == 0 && VS.Normal.z == 0) VS.Normal = float3(0,0,1); VS.Position.xyz += normalize(VS.Normal) * 0.000f; float4 wPos = mul(float4(VS.Position, 1), gWorld); wPos.xyz += sWorldOffset; float4x4 sView = createViewMatrix(sCameraPosition, sCameraForward, sCameraUp); float4 vPos = mul(wPos, sView); vPos.xzy += sElementOffset; float sFarClip = gProjection[3][2] / (1 - gProjection[2][2]); float sNearClip = gProjection[3][2] / - gProjection[2][2]; float4x4 sProjection = createProjectionMatrix(sNearClip, sFarClip, sFov, sAspect, sMoveObject2D, sScaleObject2D); float4x4 tProjection = createProjectionMatrix(sNearClip, sFarClip, sFov, sAspect, float2(0,0), sScaleObject2D / sRealScale2D); PS.Position = mul(vPos, sProjection); PS.vPosition = mul(vPos, tProjection); PS.Depth = float2(PS.Position.z, PS.Position.w); PS.TexCoord0 = VS.TexCoord0; float4x4 sWorldView = mul(gWorld, sView); PS.Normal = mul(VS.Normal.xyz, (float3x3)sWorldView); float Diffa = MTACalcGTABuildingDiffuse(VS.Diffuse).a; PS.Diffuse = float4(0.35, 0.35, 0.3, Diffa); return PS; } struct Pixel { float4 Color : COLOR0; float4 Extra : COLOR1; float Depth : DEPTH0; }; Pixel PixelShaderFunction(PSInput PS) { Pixel output; float4 texel = tex2D(Sampler0, PS.TexCoord0); output.Color = float4(0, 0, 0, min(min(texel.a * PS.Diffuse.a, 0.006105), sAlphaMult)); float4 finalColor = texel * PS.Diffuse; float2 scrCoord =(PS.vPosition.xy / PS.vPosition.w) * float2(0.5, -0.5) + 0.5; output.Depth = ((PS.Depth.x * 0.00625 * sProjZMult) / PS.Depth.y); if ((scrCoord.x > 1) || (scrCoord.x < 0) || (scrCoord.y > 1) || (scrCoord.y < 0)) { output.Depth = 1; output.Color = 0; } output.Extra = saturate(finalColor); output.Extra.rgb += output.Extra.rgb * sColorFilter1.rgb * sColorFilter1.a; output.Extra.rgb += output.Extra.rgb * sColorFilter2.rgb * sColorFilter2.a; output.Extra.rgb *= 1.65; output.Extra.a *= sAlphaMult; return output; } technique fx_pre_ped_MRT { pass P0 { FogEnable = false; AlphaBlendEnable = true; AlphaRef = 1; SeparateAlphaBlendEnable = true; SrcBlendAlpha = SrcAlpha; DestBlendAlpha = One; VertexShader = compile vs_2_0 VertexShaderFunction(); PixelShader = compile ps_2_0 PixelShaderFunction(); } } technique fallback { pass P0 { } } "
	function getObjectPreviewSource(tex)
		return " float3 sElementOffset = float3(0,0,0); float3 sWorldOffset = float3(0,0,0); float3 sCameraPosition = float3(0,0,0); float3 sCameraForward = float3(0,0,0); float3 sCameraUp = float3(0,0,0); float sFov = 1; float sAspect = 1; float2 sMoveObject2D = float2(0,0); float2 sScaleObject2D = float2(1,1); float2 sRealScale2D = float2(1,1); float sAlphaMult = 1; float sProjZMult = 2; float4 sColorFilter1 = float4(0,0,0,0); float4 sColorFilter2 = float4(0,0,0,0); texture gTexture0 < string textureState=\"0,Texture\"; >; float4x4 gWorld : WORLD; float4x4 gProjection : PROJECTION; texture secondRT < string renderTarget = \"yes\"; >; int gLighting < string renderState=\"LIGHTING\"; >; float4 gGlobalAmbient < string renderState=\"AMBIENT\"; >; int gAmbientMaterialSource < string renderState=\"AMBIENTMATERIALSOURCE\"; >; int gDiffuseMaterialSource < string renderState=\"DIFFUSEMATERIALSOURCE\"; >; int gEmissiveMaterialSource < string renderState=\"EMISSIVEMATERIALSOURCE\"; >; float4 gMaterialAmbient < string materialState=\"Ambient\"; >; float4 gMaterialDiffuse < string materialState=\"Diffuse\"; >; float4 gMaterialSpecular < string materialState=\"Specular\"; >; float4 gMaterialEmissive < string materialState=\"Emissive\"; >; int CUSTOMFLAGS <string createNormals = \"yes\"; string skipUnusedParameters = \"yes\"; >; float4 gTextureFactor < string renderState=\"TEXTUREFACTOR\"; >; " .. (tex and " texture TexInput; sampler Sampler0 = sampler_state { Texture = (TexInput); }; " or " sampler Sampler0 = sampler_state { Texture = (gTexture0); }; ") .. " struct VSInput { float3 Position : POSITION0; float4 Diffuse : COLOR0; float2 TexCoord0 : TEXCOORD0; }; struct PSInput { float4 Position : POSITION0; float4 Diffuse : COLOR0; float2 TexCoord0 : TEXCOORD0; float4 vPosition : TEXCOORD1; float2 Depth : TEXCOORD2; }; float4x4 createViewMatrix( float3 pos, float3 fwVec, float3 upVec ) { float3 zaxis = normalize( fwVec); float3 xaxis = normalize( cross( -upVec, zaxis )); float3 yaxis = cross( xaxis, zaxis ); float4x4 viewMatrix = { float4( xaxis.x, yaxis.x, zaxis.x, 0 ), float4( xaxis.y, yaxis.y, zaxis.y, 0 ), float4( xaxis.z, yaxis.z, zaxis.z, 0 ), float4(-dot( xaxis, pos ), -dot( yaxis, pos ), -dot( zaxis, pos ), 1 ) }; return viewMatrix; } float4x4 createProjectionMatrix(float near_plane, float far_plane, float fov_horiz, float fov_aspect, float2 ss_mov, float2 ss_scale) { float h, w, Q; w = 1/tan(fov_horiz * 0.5); h = w/fov_aspect; Q = far_plane/(far_plane - near_plane); float4x4 projectionMatrix = { float4(w * ss_scale.x, 0, 0, 0), float4(0, h * ss_scale.y, 0, 0), float4(ss_mov.x, ss_mov.y, Q, 1), float4(0, 0, -Q*near_plane, 0) }; return projectionMatrix; } float4 MTACalcGTABuildingDiffuse( float4 InDiffuse ) { float4 OutDiffuse; if ( !gLighting ) { OutDiffuse = InDiffuse; } else { float4 ambient = gAmbientMaterialSource == 0 ? gMaterialAmbient : InDiffuse; float4 diffuse = gDiffuseMaterialSource == 0 ? gMaterialDiffuse : InDiffuse; float4 emissive = gEmissiveMaterialSource == 0 ? gMaterialEmissive : InDiffuse; OutDiffuse = gGlobalAmbient * saturate( ambient + emissive ); OutDiffuse.a *= diffuse.a; } return OutDiffuse; } PSInput VertexShaderFunction(VSInput VS) { PSInput PS = (PSInput)0; float4 wPos = mul(float4(VS.Position, 1), gWorld); wPos.xyz += sWorldOffset; float4x4 sView = createViewMatrix(sCameraPosition, sCameraForward, sCameraUp); float4 vPos = mul(wPos, sView); vPos.xzy += sElementOffset; float sFarClip = gProjection[3][2] / (1 - gProjection[2][2]); float sNearClip = gProjection[3][2] / - gProjection[2][2]; float4x4 sProjection = createProjectionMatrix(sNearClip, sFarClip, sFov, sAspect, sMoveObject2D, sScaleObject2D); float4x4 tProjection = createProjectionMatrix(sNearClip, sFarClip, sFov, sAspect, float2(0,0), sScaleObject2D / sRealScale2D); PS.Position = mul(vPos, sProjection); PS.vPosition = mul(vPos, tProjection); PS.Depth = float2(PS.Position.z, PS.Position.w); PS.TexCoord0 = VS.TexCoord0; float Diffa = MTACalcGTABuildingDiffuse(VS.Diffuse).a; PS.Diffuse = float4(0.35, 0.35, 0.3, Diffa); return PS; } struct Pixel { float4 Color : COLOR0; float4 Extra : COLOR1; float Depth : DEPTH0; }; Pixel PixelShaderFunction(PSInput PS) { Pixel output; float4 texel = tex2D(Sampler0, PS.TexCoord0); output.Color = float4(0, 0, 0, min(min(texel.a * PS.Diffuse.a, 0.006105), sAlphaMult)); float4 finalColor = texel * PS.Diffuse; float2 scrCoord =(PS.vPosition.xy / PS.vPosition.w) * float2(0.5, -0.5) + 0.5; output.Depth = ((PS.Depth.x * 0.00625 * sProjZMult) / PS.Depth.y); if ((scrCoord.x > 1) || (scrCoord.x < 0) || (scrCoord.y > 1) || (scrCoord.y < 0)) { output.Depth = 1; output.Color = 0; } output.Extra = saturate(finalColor); output.Extra.rgb += output.Extra.rgb * sColorFilter1.rgb * sColorFilter1.a; output.Extra.rgb += output.Extra.rgb * sColorFilter2.rgb * sColorFilter2.a; output.Extra.rgb *= 1.65; output.Extra.a *= sAlphaMult; return output; } technique fx_pre_object_MRT { pass P0 { FogEnable = false; AlphaBlendEnable = true; AlphaRef = 1; SeparateAlphaBlendEnable = true; SrcBlendAlpha = SrcAlpha; DestBlendAlpha = One; VertexShader = compile vs_2_0 VertexShaderFunction(); PixelShader = compile ps_2_0 PixelShaderFunction(); } } technique fallback { pass P0 { } } "
		end
		local anims = {
			{
				"DEALER",
				"DEALER_IDLE"
			},
			{"GANGS", "leanIDLE"},
			{
				"COP_AMBIENT",
				"Coplook_think"
			},
			{
				"COP_AMBIENT",
				"Coplook_shake"
			},
			{
				"GANGS",
				"prtial_gngtlkA"
			},
			{
				"GANGS",
				"prtial_gngtlkB"
			},
			{"DANCING", "DAN_Loop_A"},
			{"DANCING", "dnce_M_b"},
			{
				"COP_AMBIENT",
				"Coplook_watch"
			}
		}
		function startCharRender()
			if isElement(charSetPed) then
				destroyElement(charSetPed)
			end
			charSetPed = nil
			if isElement(charPedSrc) then
				destroyElement(charPedSrc)
			end
			charPedSrc = nil
			if isElement(charPedShad) then
				destroyElement(charPedShad)
			end
			charPedShad = nil
			for i = 1, #charSetObjs do
				if isElement(charSetObjs[i]) then
					destroyElement(charSetObjs[i])
				end
				charSetObjs[i] = nil
			end
			for i = 1, #charObjShads do
				if isElement(charObjShads[i]) then
					destroyElement(charObjShads[i])
				end
				charObjShads[i] = nil
			end
			for i = 1, #charPedItems do
				charPedItems[i] = nil
			end
			collectgarbage()
			charSetPed = createPed(getElementModel(localPlayer), 0, 0, 11, 15 - math.random(-100, 100) / 10)
			local anim = math.random(1, #anims)
			charPedSrc = dxCreateRenderTarget(screenX, screenY, true)
			if charPedSrc then
			end
			charPedShad = dxCreateShader(pedPreviewSource, 0, 0, false, "all")
			charObjShads[1] = dxCreateShader(getObjectPreviewSource(), 0, 0, false, "all")
			dxSetShaderValue(charPedShad, "sFov", 70)
			dxSetShaderValue(charPedShad, "sAspect", screenY / screenX)
			dxSetShaderValue(charPedShad, "secondRT", charPedSrc)
			setPedAnimation(charSetPed, anims[anim][1], anims[anim][2], -1, true, false)
			sightlangCondHandl0(true)
			engineApplyShaderToWorldTexture(charPedShad, "*", charSetPed)
			setElementCollisionsEnabled(charSetPed, false)
			local objs = sightexports.sClothesshop:getSelfClothData()
			for i = 1, #objs do
				local model, bone, x, y, z, q, sx, sy, sz, tex, texEl, item = unpack(objs[i])
				local obj = createObject(model, 0, 0, 0, 0, 0, 0)
				table.insert(charSetObjs, obj)
				setElementCollisionsEnabled(obj, false)
				engineApplyShaderToWorldTexture(charObjShads[1], "*", obj)
				if isElement(texEl) then
					local j = #charObjShads + 1
					charObjShads[j] = dxCreateShader(getObjectPreviewSource(true), 0, 0, false, "all")
					dxSetShaderValue(charObjShads[j], "TexInput", texEl)
					engineRemoveShaderFromWorldTexture(charObjShads[1], tex, obj)
					engineApplyShaderToWorldTexture(charObjShads[j], tex, obj)
				end
				if item then
					table.insert(charPedItems, item)
				end
				sightexports.sPattach:detach(obj)
				sightexports.sPattach:attach(obj, charSetPed, bone, x, y, z, 0, 0, 0)
				sightexports.sPattach:setRotationQuaternion(obj, q)
				setObjectScale(obj, sx, sy, sz)
			end
			for i = 1, #charObjShads do
				dxSetShaderValue(charObjShads[i], "sFov", 70)
				dxSetShaderValue(charObjShads[i], "sAspect", screenY / screenX)
				dxSetShaderValue(charObjShads[i], "secondRT", charPedSrc)
			end
			local x, y = screenX / 2, screenY / 2
			local sx, sy = 10, 10
			local psx, psy = sx / screenX / 2, sy / screenY / 2
			local ppx, ppy = x / screenX + psx - 0.5, -(y / screenY + psy - 0.5)
			ppx, ppy = 2 * ppx, 2 * ppy
			dxSetShaderValue(charPedShad, "sMoveObject2D", ppx, ppy)
			dxSetShaderValue(charPedShad, "sScaleObject2D", 2 * math.min(psx, psy), 2 * math.min(psx, psy))
			dxSetShaderValue(charPedShad, "sRealScale2D", 2 * psx, 2 * psy)
			for i = 1, #charObjShads do
				dxSetShaderValue(charObjShads[i], "sMoveObject2D", ppx, ppy)
				dxSetShaderValue(charObjShads[i], "sScaleObject2D", 2 * math.min(psx, psy), 2 * math.min(psx, psy))
				dxSetShaderValue(charObjShads[i], "sRealScale2D", 2 * psx, 2 * psy)
			end
		end
		function renderCharSet()
			setElementInterior(charSetPed, getElementInterior(localPlayer))
			setElementDimension(charSetPed, getElementDimension(localPlayer))
			dxSetRenderTarget(charPedSrc, true)
			dxSetRenderTarget()
			local cameraMatrix = getElementMatrix(getCamera())
			local transformMatrix = createElementMatrix(0, 0, 180)
			local posX, posY, posZ = getPositionFromMatrixOffset(cameraMatrix, 0, 2.5, 0)
			local multipliedMatrix = matrixMultiply(transformMatrix, cameraMatrix)
			local rotX, rotY, rotZ = getEulerAnglesFromMatrix(multipliedMatrix)
			setElementPosition(charSetPed, posX, posY, posZ, false)
			setElementRotation(charSetPed, rotX, rotY, rotZ, "ZXY")
			dxSetShaderValue(charPedShad, "sCameraPosition", cameraMatrix[4])
			dxSetShaderValue(charPedShad, "sCameraForward", cameraMatrix[2])
			dxSetShaderValue(charPedShad, "sCameraUp", cameraMatrix[3])
			for i = 1, #charObjShads do
				dxSetShaderValue(charObjShads[i], "sCameraPosition", cameraMatrix[4])
				dxSetShaderValue(charObjShads[i], "sCameraForward", cameraMatrix[2])
				dxSetShaderValue(charObjShads[i], "sCameraUp", cameraMatrix[3])
			end
		end
		dashboardLayout[1][1] = {
			name = "accountInfo",
			name = "accountInfo",
			xSize = 2,
			ySize = 1,
			background = "green",
			topLabels = {
				"Üdvözlünk ",
				"username!"
			},
			drawFunction = drawAccountInfo,
			insideDraw = charInfoInsideDraw,
			beforeExpand = startCharRender,
			insideDestroy = deleteCharRenderer
		}
		ppShopPos = {1, 2}
		dashboardLayout[1][2] = {
			name = "Prémium shop",
			xSize = 2,
			ySize = 1,
			topLabels = {"Prémium ", "shop"},
			cornerBcg = "files/pp_bcg.dds",
			centerBcg = "files/pp_bcg_center.dds",
			centerBcgColor = "sightblue",
			ppShop = true,
			drawFunction = drawPremiumInfo,
			insideDraw = ppInsideDraw,
			insideDestroy = ppInsideDestroy
		}
		dashboardLayout[1][3] = {
			name = "Beállítások",
			xSize = 1,
			ySize = 1,
			topLabels = {
				"Beállítások"
			},
			cornerBcg = "files/settings_bcg.dds",
			insideDraw = settingsInsideDraw,
			insideDestroy = settingsInsideDestroy
		}
		newsPosition = {1, 4}
		dashboardLayout[1][4] = {
			name = "Changelog",
			xSize = 2,
			ySize = 1,
			background = "news/def.dds",
			topLabels = {"Changelog"},
			drawFunction = drawChangelogInfo,
			checkFunction = getDiscordInvitation
		}
		groupsPos = {2, 3}
		dashboardLayout[2][3] = {
			name = "Frakciók",
			xSize = 1,
			ySize = 1,
			topLabels = {"Frakciók"},
			cornerBcg = "files/groups_bcg.dds",
			insideDraw = groupsInsideDraw,
			insideDestroy = groupsInsideDestroy,
			checkFunction = checkIfGroupsAvailable
		}
		interiorPos = {3, 1}
		dashboardLayout[3][1] = {
			name = "Interiorok",
			xSize = 2,
			ySize = 2,
			background = "files/inti/interior_render1.dds",
			drawFunction = drawInteriorsInfo,
			insideDraw = interiorsInsideDraw,
			insideDestroy = interiorsInsideDestroy
		}
		bigRadarPos = {3, 3}
		dashboardLayout[3][3] = {
			name = "Világtérkép",
			xSize = 2,
			ySize = 2,
			background = "radar",
			topLabels = {"Világ", "térkép"}
		}
		vehsPosition = {5, 1}
		dashboardLayout[5][1] = {
			name = "Járművek",
			xSize = 2,
			ySize = 2,
			background = "files/fado2.dds",
			topLabels = {
				"Járművek: ",
				"vehicleNum"
			},
			drawFunction = drawVehiclesInfo,
			insideDraw = drawVehiclesInside,
			insideDestroy = vehiclesInsideDestroy,
			beforeExpand = requestPlayerVehicleList
		}
		dashboardLayout[5][3] = {
			name = "Report, Online adminisztrátorok",
			xSize = 2,
			ySize = 1,
			topLabels = {
				"Report",
				" / adminisztrátorok"
			},
			cornerBcg = "files/admins_bcg.dds",
			drawFunction = drawAdminsInfo,
			insideDraw = drawAdminInside,
			insideDestroy = adminInsideDestroy
		}
		animalsLocation = {5, 4}
		dashboardLayout[5][4] = {
			name = "Háziállatok",
			xSize = 2,
			ySize = 1,
			topLabels = {
				"Háziállatok: ",
				"animalNum"
			},
			cornerBcg = "files/pets_bcg.dds",
			insideDraw = animalsInsideDraw,
			insideDestroy = animalsInsideDestroy
		}
		for i in pairs(dashboardLayout) do
			for j, data in pairs(dashboardLayout[i]) do
				local xs = data.xSize
				local ys = data.ySize
				dashboardLayout[i][j].originalSize = {
					oneSize[1] * xs - dashboardPadding[3] * 2,
					oneSize[2] * ys - dashboardPadding[3] * 2
				}
			end
		end
		animalNum = 0
		local animalNumLabel = false
		playerAnimals = {}
		addEvent("recieveAnimals", true)
		addEventHandler("recieveAnimals", getRootElement(), function(data)
			animalNum = #data
			playerAnimals = data
			if dashboardState then
				sightexports.sGui:setLabelText(animalNumLabel, animalNum)
			end
			if animalMenuDrawn then
				if animalNum < selectedAnimal then
					selectedAnimal = 1
				end
				drawAnimal()
			end
		end)
		closeButton = false
		helpIcon = false
		local pageName = false
		local maxFactor = 0.0015
		local factor = 0
		dashboardState = false
		local animatedElements = 0
		local vign = false
		local nameLabel = false
		local nameRect1 = false
		local nameRect2 = false
		function preRenderDashboard(delta)
			if dashboardState then
				if factor < maxFactor then
					factor = factor + delta * maxFactor / expandTime
					if factor > maxFactor then
						factor = maxFactor
					end
					dxSetShaderValue(screenShader, "factor", factor)
				end
			elseif 0 < factor then
				factor = factor - delta * maxFactor / expandTime
				if factor < 0 then
					factor = 0
				end
				dxSetShaderValue(screenShader, "factor", factor)
			end
		end
		local lastPage = false
		openedColorSet = 1
		playedMinutes = 0
		addEvent("refreshPlayedMinutes", true)
		addEventHandler("refreshPlayedMinutes", getRootElement(), function(data)
			playedMinutes = data
		end)
		playerInteriors = {}
		interiorLimit = 0
		interiorNum = 0
		local interiorNumLabel = false
		vehicleNumLabel = false
		addEvent("gotInteriorLimitForDashboard", true)
		addEventHandler("gotInteriorLimitForDashboard", getRootElement(), function(limit)
			interiorLimit = limit
			if dashboardState then
				sightexports.sGui:setLabelText(intiLimitLabel, interiorLimit)
				if interiorMenuDrawn then
					drawInteriors()
				end
			end
		end)
		addEvent("refreshPlayerInteriors", true)
		addEventHandler("refreshPlayerInteriors", getRootElement(), function(num, data, rentable)
			interiorRenderList = {}
			interiorNum = num
			playerInteriors = data
			rentableNum = rentable
			farms = sightexports.sFarm:getPlayerFarmsForDashboard()
			for i = 1, #playerInteriors do
				if playerInteriors[i].type ~= "otherRentable" and playerInteriors[i].type ~= "workshop" and playerInteriors[i].type ~= "mine" then
					table.insert(interiorRenderList, {
						theType = "interior",
						data = playerInteriors[i]
					})
				end
				if playerInteriors[i].type == "otherRentable" or playerInteriors[i].type == "workshop" then
					table.insert(interiorRenderList, {
						theType = "otherRentable",
						data = playerInteriors[i]
					})
					rentableNum = rentableNum + 1
				end
				if playerInteriors[i].type == "mine" then
					table.insert(interiorRenderList, {
						theType = "mine",
						data = playerInteriors[i]
					})
					rentableNum = rentableNum + 1
				end
			end
			table.sort(interiorRenderList, function(a, b)
				if a.data.type == b.data.type then
					return a.data.interiorId < b.data.interiorId
				else
					return b.data.type < a.data.type
				end
			end)
			for i = 1, #farms do
				table.insert(interiorRenderList, {
					theType = "farm",
					data = farms[i]
				})
			end
			rentableNum = rentableNum + #farms
			if dashboardState then
				sightexports.sGui:setLabelText(ownInteriorLabel, interiorNum)
				sightexports.sGui:setLabelText(intiLimitLabel, interiorLimit)
				sightexports.sGui:setLabelText(rentableNumLabel, rentableNum)
				if interiorMenuDrawn then
					drawInteriors()
				end
			end
		end)
		function round2(num, idp)
			return tonumber(string.format("%." .. (idp or 0) .. "f", num))
		end
		charId = false
		if getElementData(localPlayer, "loggedIn") then
			triggerEvent("requestPlayerInteriors", localPlayer)
			triggerServerEvent("requestInteriorsForDashboard", localPlayer)
		end
		helperColor = {
			255,
			255,
			255
		}
		function createGuiCache()
			local v4red = sightexports.sGui:getColorCode("sightred")
			local v4purple = sightexports.sGui:getColorCode("sightpurple")
			helperColor[1] = (v4red[1] + v4purple[1]) / 2
			helperColor[2] = (v4red[2] + v4purple[2]) / 2
			helperColor[3] = (v4red[3] + v4purple[3]) / 2
			local icons = {
				sightexports.sGui:getFaIconFilename("building", 32, "solid", false, sightexports.sGui:getColorCodeToColor("sightgrey2"), sightexports.sGui:getColorCodeToColor("sightblue")),
				sightexports.sGui:getFaIconFilename("dollar-sign", 32, "solid", false, sightexports.sGui:getColorCodeToColor("sightgrey2"), sightexports.sGui:getColorCodeToColor("sightgreen")),
				sightexports.sGui:getFaIconFilename("garage", 32, "solid", false, sightexports.sGui:getColorCodeToColor("sightgrey2"), sightexports.sGui:getColorCodeToColor("sightblue-second")),
				sightexports.sGui:getFaIconFilename("hotel", 32, "solid", false, sightexports.sGui:getColorCodeToColor("sightgrey2"), sightexports.sGui:getColorCodeToColor("sightpurple")),
				sightexports.sGui:getFaIconFilename("sort-circle-up", 32, "solid", false, sightexports.sGui:getColorCodeToColor("sightgrey2"), sightexports.sGui:getColorCodeToColor("hudwhite")),
				sightexports.sGui:getFaIconFilename("door-closed", 32, "solid", false, sightexports.sGui:getColorCodeToColor("sightgrey2"), sightexports.sGui:getColorCodeToColor("hudwhite")),
				sightexports.sGui:getFaIconFilename("question", 32, "solid", false, sightexports.sGui:getColorCodeToColor("sightgrey2"), sightexports.sGui:getColorCodeToColor("sightyellow")),
				sightexports.sGui:getFaIconFilename("chevron-circle-left", 32),
				sightexports.sGui:getFaIconFilename("users-cog", 32)
			}
			sightexports.sGui:getFont(bebasSize + 5 .. "/BebasNeueBold.otf")
			sightexports.sGui:getFont(math.max(15, bebasSize - 5) .. "/BebasNeueRegular.otf")
			sightexports.sGui:getFont(bebasSize .. "/BebasNeueBold.otf")
			sightexports.sGui:getFont(bebasSize .. "/BebasNeueLight.otf")
			local grads = {}
			for i = 1, dashboardGridSize[1] do
				for j = 1, dashboardGridSize[2] do
					local data = dashboardLayout[i][j]
					if data then
						local xs = data.xSize
						local ys = data.ySize
						local sx, sy = oneSize[1] * xs - dashboardPadding[3] * 2, oneSize[2] * ys - dashboardPadding[3] * 2
						table.insert(grads, sightexports.sGui:getGradientFilename(sx, sy, sightexports.sGui:getColorCode("sightgrey2"), sightexports.sGui:getColorCode("sightgrey1")))
						if data.background == "green" then
							table.insert(grads, sightexports.sGui:getGradientFilename(sx, sy, sightexports.sGui:getColorCode("sightgreen-second"), sightexports.sGui:getColorCode("sightgreen")))
						end
					end
				end
			end
		end
		local localUserName = "false"
		addEvent("gotLocalUserName", true)
		addEventHandler("gotLocalUserName", getRootElement(), function(user)
			localUserName = user
		end)
		function createDashboard()
			if not dashboardState then
				dashboardLayout[interiorPos[1]][interiorPos[2]].background = "files/inti/interior_render" .. math.random(1, 10) .. ".dds"
				if not vehicleList then
					requestPlayerVehicleList()
				end
				triggerServerEvent("requestPremiumData", localPlayer)
				triggerServerEvent("requestAnimals", localPlayer)
				local startTick = getTickCount()
				openedColorSet = sightexports.sGui:getColorSet()
				dashboardLayout[1][1].topLabels[2] = (localUserName or "ismeretlen") .. "!"
				dashboardLayout[1][1].name = localUserName or "ismeretlen"
				charId = getElementData(localPlayer, "char.ID")
				charDatas = {
					{
						"Karaktered: ",
						(getElementData(localPlayer, "char.name") or "ismeretlen"):gsub("_", " ")
					},
					{
						"Játszott percek: ",
						sightexports.sGui:thousandsStepper(playedMinutes) .. " (" .. sightexports.sGui:thousandsStepper(math.floor(playedMinutes / 60)) .. " óra, LVL " .. sightexports.sCore:getLevel(playedMinutes) .. ")"
					},
					{
						"Account ID: ",
						getElementData(localPlayer, "char.accID") or "N/A"
					},
					{
						"Character ID: ",
						charId or "N/A"
					},
				}
				showCursor(true)
				showChat(false)
				sightexports.sHud:setHudEnabled(false, expandTime)
				dashboardState = true
				setElementData(localPlayer, "dashboardState", dashboardState)
				screenSrc = dxCreateScreenSource(screenX, screenY)
				local shaderSource = " texture texture0; float factor; sampler Sampler0 = sampler_state { Texture = (texture0); AddressU = MIRROR; AddressV = MIRROR; }; struct PSInput { float2 TexCoord : TEXCOORD0; }; float4 PixelShader_Background(PSInput PS) : COLOR0 { float4 sum = tex2D(Sampler0, PS.TexCoord); for (float i = 1; i < 3; i++) { sum += tex2D(Sampler0, float2(PS.TexCoord.x, PS.TexCoord.y + (i * factor))); sum += tex2D(Sampler0, float2(PS.TexCoord.x, PS.TexCoord.y - (i * factor))); sum += tex2D(Sampler0, float2(PS.TexCoord.x - (i * factor), PS.TexCoord.y)); sum += tex2D(Sampler0, float2(PS.TexCoord.x + (i * factor), PS.TexCoord.y)); } sum /= 9; sum.a = 1.0; return sum; } technique complercated { pass P0 { PixelShader = compile ps_2_0 PixelShader_Background(); } } technique simple { pass P0 { Texture[0] = texture0; } } "
				screenShader = dxCreateShader(shaderSource)
				dxSetShaderValue(screenShader, "UVSize", screenX, screenY)
				factor = 0
				dxSetShaderValue(screenShader, "texture0", screenSrc)
				addEventHandler("onClientPreRender", getRootElement(), preRenderDashboard)
				dashboardGui = sightexports.sGui:createGuiElement("image", 0, 0, screenX, screenY)
				sightexports.sGui:setImageFile(dashboardGui, screenShader)
				sightexports.sGui:setGuiHoverable(dashboardGui, true)
				sightexports.sGui:disableClickTrough(dashboardGui, true)
				sightexports.sGui:disableLinkCursor(dashboardGui, true)
				sightexports.sGui:updateScreenSourceBefore(dashboardGui, screenSrc, true)
				vign = sightexports.sGui:createGuiElement("image", 0, 0, screenX, screenY, dashboardGui)
				sightexports.sGui:setImageDDS(vign, "files/vignette.dds")
				sightexports.sGui:fadeIn(vign, expandTime)
				closeButton = sightexports.sGui:createGuiElement("image", dashboardPos[1] + dashSize[1] - dashboardPadding[3] - 32, dashboardPos[2] - dashboardPadding[3] - 32, 32, 32, dashboardGui)
				sightexports.sGui:setImageFile(closeButton, sightexports.sGui:getFaIconFilename("chevron-circle-left", 32))
				sightexports.sGui:setClickEvent(closeButton, "dashboardCloseClick", false)
				sightexports.sGui:fadeOut(closeButton, 0)
				sightexports.sGui:setGuiHoverable(closeButton, false)
				sightexports.sGui:setGuiHover(closeButton, "solid", "sightred")
				helpIcon = sightexports.sGui:createGuiElement("image", dashboardPos[1] + dashSize[1] - dashboardPadding[3] - 32, dashboardPos[2] - dashboardPadding[3] - 32, 32, 32, dashboardGui)
				sightexports.sGui:setImageFile(helpIcon, sightexports.sGui:getFaIconFilename("discord", 32, "brands"))
				sightexports.sGui:setClickEvent(helpIcon, "dashboardClipboardDiscord", false)
				sightexports.sGui:guiSetTooltip(helpIcon, "https://discord.gg/sightmta")
				sightexports.sGui:fadeIn(helpIcon, expandTime)
				sightexports.sGui:setGuiHoverable(helpIcon, true)
				sightexports.sGui:setGuiHover(helpIcon, "solid", "sightblue")
				nameLabel = sightexports.sGui:createGuiElement("label", dashboardPos[1] + dashboardPadding[3], dashboardPos[2] - dashboardPadding[3] - imageSizes, imageSizes, imageSizes, dashboardGui)
				sightexports.sGui:setLabelText(nameLabel, "SIGHTMTA DASHBOARD ")
				sightexports.sGui:setLabelFont(nameLabel, bebasSize + 5 .. "/BebasNeueBold.otf")
				sightexports.sGui:setLabelAlignment(nameLabel, "left", "bottom")
				sightexports.sGui:setLabelShadow(nameLabel, "#000000ae", 1, 1)
				sightexports.sGui:fadeIn(nameLabel, expandTime)
				pageName = sightexports.sGui:createGuiElement("label", dashboardPos[1] + 6 + dashboardPadding[3] + sightexports.sGui:getLabelTextWidth(nameLabel), dashboardPos[2] - dashboardPadding[3] - imageSizes, imageSizes, imageSizes, dashboardGui)
				sightexports.sGui:setLabelText(pageName, " KEZDŐLAP")
				sightexports.sGui:setLabelFont(pageName, math.max(15, bebasSize - 5) .. "/BebasNeueRegular.otf")
				sightexports.sGui:setLabelAlignment(pageName, "left", "bottom")
				sightexports.sGui:setLabelColor(pageName, "sightlightgrey")
				sightexports.sGui:setLabelShadow(pageName, "#000000ae", 1, 1)
				sightexports.sGui:fadeIn(pageName, expandTime)
				nameRect1 = sightexports.sGui:createGuiElement("rectangle", dashboardPos[1] + 2 + dashboardPadding[3] + sightexports.sGui:getLabelTextWidth(nameLabel) + 1, dashboardPos[2] - dashboardPadding[3] - sightexports.sGui:getLabelFontHeight(pageName) * 0.8 + 1, 2, sightexports.sGui:getLabelFontHeight(pageName) * 0.65, dashboardGui)
				sightexports.sGui:setGuiBackground(nameRect1, "solid", "#000000ae")
				sightexports.sGui:fadeIn(nameRect1, expandTime)
				nameRect2 = sightexports.sGui:createGuiElement("rectangle", dashboardPos[1] + 2 + dashboardPadding[3] + sightexports.sGui:getLabelTextWidth(nameLabel) + 0, dashboardPos[2] - dashboardPadding[3] - sightexports.sGui:getLabelFontHeight(pageName) * 0.8, 2, sightexports.sGui:getLabelFontHeight(pageName) * 0.65, dashboardGui)
				sightexports.sGui:setGuiBackground(nameRect2, "solid", "sightlightgrey")
				sightexports.sGui:fadeIn(nameRect2, expandTime)
				local x = dashboardPos[1]
				local y = dashboardPos[2]
				local id = 0
				local id2 = 0
				for i = 1, dashboardGridSize[1] do
					y = dashboardPos[2]
					for j = 1, dashboardGridSize[2] do
						local data = dashboardLayout[i][j]
						if data then
							do
								local xs = data.xSize
								local ys = data.ySize
								dashboardLayout[i][j].originalPosition = {
									x + dashboardPadding[3],
									y + dashboardPadding[3]
								}
								dashboardLayout[i][j].originalSize = {
									oneSize[1] * xs - dashboardPadding[3] * 2,
									oneSize[2] * ys - dashboardPadding[3] * 2
								}
								local rtg = sightexports.sGui:createGuiElement("rectangle", dashboardLayout[i][j].originalPosition[1], dashboardLayout[i][j].originalPosition[2] + (j > dashboardGridSize[2] / 2 and screenY or -screenY), dashboardLayout[i][j].originalSize[1], dashboardLayout[i][j].originalSize[2], dashboardGui)
								sightexports.sGui:setGuiBackground(rtg, "solid", "sightgrey1")
								sightexports.sGui:setGuiHover(rtg, "gradient", {"sightgrey2", "sightgrey1"}, false, true)
								if data.background == "green" then
									dashboardLayout[i][j].greenBcg = sightexports.sGui:createGuiElement("rectangle", 0, 0, dashboardLayout[i][j].originalSize[1], dashboardLayout[i][j].originalSize[2], rtg)
									sightexports.sGui:setGuiBackground(dashboardLayout[i][j].greenBcg, "solid", "sightgreen")
									sightexports.sGui:setGuiHover(dashboardLayout[i][j].greenBcg, "gradient", {
										"sightgreen-second",
										"sightgreen"
									}, false, true)
									sightexports.sGui:setGuiHoverable(dashboardLayout[i][j].greenBcg, true)
								end
								sightexports.sGui:setGuiHoverable(rtg, true)
								sightexports.sGui:setDisableClickSound(rtg, true)
								if not data.disabled then
									sightexports.sGui:setClickEvent(rtg, "dashboardElementClick", false)
								end
								dashboardLayout[i][j].element = rtg
								dashboardLayout[i][j].labels = {}
								dashboardLayout[i][j].images = {}
								if data.background == "radar" then
									local radarShader = sightexports.sRadar:setBigRadarElement(rtg)
									dashboardLayout[i][j].radarTexture = sightexports.sGui:createGuiElement("image", 0, 0, screenX, screenY, rtg)
									sightexports.sGui:setImageFile(dashboardLayout[i][j].radarTexture, radarShader)
								elseif data.background and data.background ~= "green" then
									local image = sightexports.sGui:createGuiElement("image", 0, 0, dashboardLayout[i][j].originalSize[1], dashboardLayout[i][j].originalSize[2], rtg)
									if isElement(data.background) then
										sightexports.sGui:setImageFile(image, data.background)
									else
										sightexports.sGui:setImageDDS(image, ":sDashboard/" .. tostring(data.background))
									end
									local vign = sightexports.sGui:createGuiElement("image", 0, 0, dashboardLayout[i][j].originalSize[1], dashboardLayout[i][j].originalSize[2], rtg)
									sightexports.sGui:setImageDDS(vign, "files/vignette.dds")
									if not backgroundSizes[data.background] and not isElement(data.background) then
										local tex = dxCreateTexture(data.background)
										if isElement(tex) then
											backgroundSizes[data.background] = {
												dxGetMaterialSize(tex)
											}
											destroyElement(tex)
										end
									end
									if backgroundSizes[data.background] then
										local u = 0
										local v = 0
										local us = backgroundSizes[data.background][1] / dashboardLayout[i][j].originalSize[1]
										local vs = backgroundSizes[data.background][2] / dashboardLayout[i][j].originalSize[2]
										if us < vs then
											u = backgroundSizes[data.background][1]
											v = dashboardLayout[i][j].originalSize[2] * us
										else
											u = dashboardLayout[i][j].originalSize[1] * vs
											v = backgroundSizes[data.background][2]
										end
										sightexports.sGui:setImageUV(image, (backgroundSizes[data.background][1] - u) / 2, (backgroundSizes[data.background][2] - v) / 2, u, v)
										sightexports.sGui:setGuiHoverable(image, true, 1000)
									end
									table.insert(dashboardLayout[i][j].images, image)
									table.insert(dashboardLayout[i][j].images, vign)
								end
								if data.centerBcg then
									local image = sightexports.sGui:createGuiElement("image", oneSize[1] * xs / 2 - imageSizes / 2, oneSize[2] * ys / 2 - imageSizes / 2, imageSizes, imageSizes, rtg)
									sightexports.sGui:setImageDDS(image, ":sDashboard/" .. data.centerBcg)
									if data.centerBcgColor then
										sightexports.sGui:setImageColor(image, data.centerBcgColor)
									end
									table.insert(dashboardLayout[i][j].images, image)
								end
								if data.cornerBcg then
									local smallerSize = math.floor(imageSizes * 0.8)
									local image = sightexports.sGui:createGuiElement("image", oneSize[1] * xs - dashboardPadding[3] * 2 - smallerSize, oneSize[2] * ys - dashboardPadding[3] * 2 - smallerSize, smallerSize, smallerSize, rtg)
									sightexports.sGui:setImageDDS(image, ":sDashboard/" .. data.cornerBcg)
									sightexports.sGui:setGuiHoverable(image, true, 500)
									sightexports.sGui:setGuiBoundingBox(image, rtg)
									sightexports.sGui:setImageRightCornerHover(image, imageSizes, imageSizes)
									table.insert(dashboardLayout[i][j].images, image)
								end
								local y = 0
								if data.topLabels then
									local xp = 0
									for k = 1, #data.topLabels do
										local label = sightexports.sGui:createGuiElement("label", xp + dashboardPadding[3] * 2, dashboardPadding[3], oneSize[1] * xs, oneSize[2] * ys, rtg)
										sightexports.sGui:setLabelFont(label, k == 1 and bebasSize .. "/BebasNeueBold.otf" or bebasSize .. "/BebasNeueLight.otf")
										sightexports.sGui:setLabelAlignment(label, "left", "top")
										local text = data.topLabels[k]
										if text == "vehicleNum" then
											text = vehicleNum
											vehicleNumLabel = label
										end
										if text == "animalNum" then
											text = animalNum
											animalNumLabel = label
										end
										sightexports.sGui:setLabelText(label, utf8.upper(text))
										if k < #data.topLabels then
											xp = xp + sightexports.sGui:getLabelTextWidth(label)
										else
											y = sightexports.sGui:getLabelFontHeight(label)
										end
										table.insert(dashboardLayout[i][j].labels, label)
									end
								end
								if data.drawFunction then
									data.drawFunction(dashboardPadding[3] * 2, y, dashboardLayout[i][j].originalSize[1] - dashboardPadding[3] * 4, dashboardLayout[i][j].originalSize[2] - y - dashboardPadding[3] * 2, rtg, i, j)
								end
								animatedElements = animatedElements + 1
								sightexports.sGui:lockHover(dashboardGui, true)
								setTimer(function()
									setTimer(playSound, expandTime / 4, 1, "files/sound/Whoo" .. math.random(3, 4) .. ".wav")
									sightexports.sGui:setGuiPositionAnimated(rtg, dashboardLayout[i][j].originalPosition[1], dashboardLayout[i][j].originalPosition[2], expandTime / 2, false, "InOutQuad", true)
									setTimer(function()
										animatedElements = animatedElements - 1
										if animatedElements == 0 then
											sightexports.sGui:lockHover(dashboardGui, false)
											if lastPage then
												expandDashboard(lastPage[1], lastPage[2])
											end
										end
									end, expandTime / 2, 1)
								end, expandTime / 6 * (j > dashboardGridSize[2] / 2 and id2 or id), 1)
								if j > dashboardGridSize[2] / 2 then
									id2 = id2 + 1
								else
									id = id + 1
								end
							end
						end
						y = y + oneSize[2]
					end
					x = x + oneSize[1]
				end
			end
		end
		function deleteDashboard(justCache)
			if dashboardState then
				dashboardClosing = false
				dashboardState = false
				setElementData(localPlayer, "dashboardState", dashboardState)
				showCursor(false)
				if not sightexports.sDeath:isDeath() then
					sightexports.sHud:setHudEnabled(true, expandTime)
				end
				sightexports.sGui:lockHover(dashboardGui, true)
				sightexports.sGui:fadeOut(vign, expandTime)
				sightexports.sGui:fadeOut(nameLabel, expandTime)
				sightexports.sGui:fadeOut(pageName, expandTime)
				sightexports.sGui:fadeOut(nameRect1, expandTime)
				sightexports.sGui:fadeOut(nameRect2, expandTime)
				sightexports.sGui:fadeOut(helpIcon, expandTime)
				animatedElements = 0
				local id = 0
				local id2 = 0
				for i = 1, dashboardGridSize[1] do
					for j = 1, dashboardGridSize[2] do
						if dashboardLayout[i][j] and dashboardLayout[i][j].element then
							animatedElements = animatedElements + 1
							setTimer(function()
								playSound("files/sound/Whoo" .. math.random(1, 2) .. ".wav")
								sightexports.sGui:setGuiPositionAnimated(dashboardLayout[i][j].element, dashboardLayout[i][j].originalPosition[1], dashboardLayout[i][j].originalPosition[2] + (j > dashboardGridSize[2] / 2 and screenY or -screenY), expandTime / 2, false, "InOutQuad", true)
								setTimer(function()
									animatedElements = animatedElements - 1
									if animatedElements == 0 then
										sightexports.sRadar:setBigRadarElement(false)
										sightexports.sGui:deleteGuiElement(dashboardGui)
										removeEventHandler("onClientPreRender", getRootElement(), preRenderDashboard)
										dashboardGui = false
										closeButton = false
										helpIcon = false
										pageName = false
										screenShader = false
										screenSrc = false
										vign = false
										nameLabel = false
										nameRect1 = false
										nameRect2 = false
										if isElement(screenSrc) then
											destroyElement(screenSrc)
										end
										screenSrc = nil
										if isElement(screenShader) then
											destroyElement(screenShader)
										end
										screenShader = nil
										if isElement(radarShader) then
											destroyElement(radarShader)
										end
										radarShader = nil
										collectgarbage()
										showChat(true)
									end
								end, expandTime / 2, 1)
							end, expandTime / 6 * (j > dashboardGridSize[2] / 2 and id2 or id), 1)
							if j > dashboardGridSize[2] / 2 then
								id2 = id2 + 1
							else
								id = id + 1
							end
						end
					end
				end
			end
		end
		function getDashboardState()
			return dashboardState
		end
		local lastDashboardAnimation = 0
		dashboardExpanded = false
		addEvent("forceCloseDashboard", true)
		addEventHandler("forceCloseDashboard", getRootElement(), function()
			closeDashboardKey()
		end)
		function closeDashboardKey(key, por)
			deletePreview()
			dashboardClosing = true
			local mapOpen = false
			local ppShopOpen = false
			local groupsOpen = false
			if key == "F11" and (dashboardExpanded and (dashboardExpanded[1] ~= bigRadarPos[1] or dashboardExpanded[2] ~= bigRadarPos[2]) or not dashboardExpanded) then
				mapOpen = true
			end
			if key == "F7" and (dashboardExpanded and (dashboardExpanded[1] ~= ppShopPos[1] or dashboardExpanded[2] ~= ppShopPos[2]) or not dashboardExpanded) then
				ppShopOpen = true
			end
			if key == "F3" and (dashboardExpanded and (dashboardExpanded[1] ~= groupsPos[1] or dashboardExpanded[2] ~= groupsPos[2]) or not dashboardExpanded) then
				groupsOpen = true
			end
			if ppShopOpen then
				if dashboardExpanded then
					local time = closeDashPage()
					setTimer(expandDashboard, time, 1, ppShopPos[1], ppShopPos[2])
				else
					expandDashboard(ppShopPos[1], ppShopPos[2])
				end
			elseif groupsOpen then
				if dashboardExpanded then
					local time = closeDashPage()
					setTimer(expandDashboard, time, 1, groupsPos[1], groupsPos[2])
				else
					expandDashboard(groupsPos[1], groupsPos[2])
				end
			elseif mapOpen then
				if dashboardExpanded then
					local time = closeDashPage()
					setTimer(expandDashboard, time, 1, bigRadarPos[1], bigRadarPos[2])
				else
					expandDashboard(bigRadarPos[1], bigRadarPos[2])
				end
			elseif dashboardExpanded then
				if key == "F11" or key == "F7" or key == "F3" then
					lastPage = false
				else
					lastPage = dashboardExpanded
				end
				local time = closeDashPage()
				setTimer(deleteDashboard, time, 1)
			else
				lastPage = false
				deleteDashboard()
			end
			shaderSource = nil
			collectgarbage()
		end
		addEventHandler("onClientKey", getRootElement(), function(key, por)
			if getElementData(localPlayer, "loggedIn") and not buyingItem and not buyingInteriorSlot and not buyingVehicleSlot and not sellingInteriorTo and not sellingAnimalTo and not selectedAnimalToBuy and not renameInput and not reportMode and not sellingVehicle and not groupModal and not sightexports.sGui:getActiveInput() and not isChatBoxInputActive() and not isConsoleActive() then
				if key == "backspace" then
					if dashboardState then
						if animatedElements <= 0 and getTickCount() - lastDashboardAnimation > expandTime + curtainTime then
							if dashboardExpanded then
								closeDashPage()
							else
								closeDashboardKey(key, por)
							end
						end
						cancelEvent()
					end
				elseif (key == "home" or key == "F11" or key == "F7" or key == "F3") and not sightexports.sHud:getWidgetEditMode() then
					if por and animatedElements <= 0 and getTickCount() - lastDashboardAnimation > expandTime + curtainTime then
						if not dashboardState then
							if key == "F7" then
								lastPage = {
									ppShopPos[1],
									ppShopPos[2]
								}
							end
							if key == "F3" then
								lastPage = {
									groupsPos[1],
									groupsPos[2]
								}
							end
							if key == "F11" then
								lastPage = {
									bigRadarPos[1],
									bigRadarPos[2]
								}
							end
							sightexports.sItems:toggleInventory(false)
							createDashboard()
							triggerEvent("requestPlayerInteriors", localPlayer)
							triggerServerEvent("requestInteriorsForDashboard", localPlayer)
						else
							closeDashboardKey(key, por)
						end
					end
					cancelEvent()
				end
			end
		end)
		function setDashboardState(i, j, expand)
			local data = dashboardLayout[i][j]
			if data then
				sightexports.sGui:guiToFront(dashboardLayout[i][j].element)
				if expand then
					if dashboardLayout[i][j].beforeExpand then
						dashboardLayout[i][j].beforeExpand()
					end
					if dashboardLayout[i][j].radarTexture then
						sightexports.sGui:setGuiPositionAnimated(dashboardLayout[i][j].radarTexture, dashboardPos[1] + dashboardPadding[3], dashboardPos[2] + dashboardPadding[3], expandTime, false, "InOutQuad", true)
						sightexports.sRadar:setBigRadarOpened(true, expandTime)
					end
					playSound("files/sound/Swipe" .. math.random(3, 4) .. ".wav")
					sightexports.sGui:setGuiPositionAnimated(dashboardLayout[i][j].element, dashboardPos[1] + dashboardPadding[3], dashboardPos[2] + dashboardPadding[3], expandTime, false, "InOutQuad", true)
					sightexports.sGui:setGuiSizeAnimated(dashboardLayout[i][j].element, dashSize[1] - dashboardPadding[3] * 2, dashSize[2] - dashboardPadding[3] * 2, expandTime, "dashboardExpandDone", "InOutQuad")
					if dashboardLayout[i][j].greenBcg then
						sightexports.sGui:fadeOut(dashboardLayout[i][j].greenBcg, expandTime)
					end
					for k = 1, #dashboardLayout[i][j].labels do
						sightexports.sGui:fadeOut(dashboardLayout[i][j].labels[k], expandTime)
					end
					for k = 1, #dashboardLayout[i][j].images do
						sightexports.sGui:fadeOut(dashboardLayout[i][j].images[k], expandTime)
					end
				else
					if dashboardLayout[i][j].radarTexture then
						sightexports.sGui:setGuiPositionAnimated(dashboardLayout[i][j].radarTexture, dashboardLayout[i][j].originalPosition[1], dashboardLayout[i][j].originalPosition[2], expandTime, false, "InOutQuad", true)
						sightexports.sRadar:setBigRadarOpened(false, expandTime)
					end
					playSound("files/sound/Swipe" .. math.random(1, 2) .. ".wav")
					sightexports.sGui:setGuiPositionAnimated(dashboardLayout[i][j].element, dashboardLayout[i][j].originalPosition[1], dashboardLayout[i][j].originalPosition[2], expandTime, false, "InOutQuad", true)
					sightexports.sGui:setGuiSizeAnimated(dashboardLayout[i][j].element, dashboardLayout[i][j].originalSize[1], dashboardLayout[i][j].originalSize[2], expandTime, false, "InOutQuad")
					if dashboardLayout[i][j].greenBcg then
						sightexports.sGui:fadeIn(dashboardLayout[i][j].greenBcg, expandTime)
					end
					for k = 1, #dashboardLayout[i][j].labels do
						sightexports.sGui:fadeIn(dashboardLayout[i][j].labels[k], expandTime)
					end
					for k = 1, #dashboardLayout[i][j].images do
						sightexports.sGui:fadeIn(dashboardLayout[i][j].images[k], expandTime)
					end
				end
			end
		end
		addEvent("dashboardExpandDone", true)
		addEventHandler("dashboardExpandDone", getRootElement(), function()
			if dashboardExpanded then
				sightexports.sGui:lockHover(closeButton, false)
				sightexports.sGui:lockHover(helpIcon, false)
				do
					local i, j = dashboardExpanded[1], dashboardExpanded[2]
					if dashboardLayout[i][j].insideLayer then
						sightexports.sGui:deleteGuiElement(dashboardLayout[i][j].insideLayer)
						dashboardLayout[i][j].insideLayer = false
					end
					if dashboardLayout[i][j] and dashboardLayout[i][j].insideDraw then
						local x = dashboardPos[1] + dashboardPadding[3]
						local y = dashboardPos[2] + dashboardPadding[3]
						local sx = dashSize[1] - dashboardPadding[3] * 2
						local sy = dashSize[2] - dashboardPadding[3] * 2
						dashboardLayout[i][j].insideLayer = sightexports.sGui:createGuiElement("null", x, y, sx, sy)
						dashboardLayout[i][j].insideDraw(0, 0, sx, sy, i, j, dashboardLayout[i][j].insideLayer)
						sightexports.sGui:lockHover(dashboardLayout[i][j].insideLayer, true)
						dashboardLayout[i][j].insideCurtain = sightexports.sGui:createGuiElement("rectangle", 0, 0, sx, sy, dashboardLayout[i][j].insideLayer)
						sightexports.sGui:setGuiBackground(dashboardLayout[i][j].insideCurtain, "solid", "sightgrey1")
						sightexports.sGui:fadeOut(dashboardLayout[i][j].insideCurtain, curtainTime)
						setTimer(function()
							sightexports.sGui:lockHover(dashboardLayout[i][j].insideLayer, false)
						end, curtainTime, 1)
					else
						lastDashboardAnimation = lastDashboardAnimation - curtainTime
					end
				end
			end
		end)
		function closeDashPage()
			local i, j = dashboardExpanded[1], dashboardExpanded[2]
			if dashboardLayout[i][j] and dashboardLayout[i][j].insideCurtain then
				lastDashboardAnimation = getTickCount()
				sightexports.sGui:lockHover(dashboardGui, true)
				sightexports.sGui:lockHover(dashboardLayout[i][j].insideLayer, true)
				sightexports.sGui:guiToFront(dashboardLayout[i][j].insideCurtain)
				sightexports.sGui:fadeIn(dashboardLayout[i][j].insideCurtain, curtainTime)
				setTimer(function()
					if dashboardLayout[i][j].insideLayer then
						sightexports.sGui:deleteGuiElement(dashboardLayout[i][j].insideLayer)
						dashboardLayout[i][j].insideLayer = false
						if dashboardLayout[i][j].insideDestroy then
							dashboardLayout[i][j].insideDestroy()
						end
					end
					setDashboardState(dashboardExpanded[1], dashboardExpanded[2], false)
					dashboardExpanded = false
					sightexports.sGui:fadeOut(closeButton, expandTime)
					sightexports.sGui:setGuiPositionAnimated(helpIcon, dashboardPos[1] + dashSize[1] - dashboardPadding[3] - 32, dashboardPos[2] - dashboardPadding[3] - 32, expandTime, false, "InOutQuad")
					sightexports.sGui:setGuiHoverable(closeButton, false)
					sightexports.sGui:setLabelText(pageName, " KEZDŐLAP")
					sightexports.sGui:lockHover(dashboardGui, false)
				end, curtainTime, 1)
				return expandTime + curtainTime
			else
				lastDashboardAnimation = getTickCount() - curtainTime
				if dashboardLayout[i][j].insideLayer then
					sightexports.sGui:deleteGuiElement(dashboardLayout[i][j].insideLayer)
					dashboardLayout[i][j].insideLayer = false
					if dashboardLayout[i][j].insideDestroy then
						dashboardLayout[i][j].insideDestroy()
					end
				end
				setDashboardState(dashboardExpanded[1], dashboardExpanded[2], false)
				dashboardExpanded = false
				sightexports.sGui:fadeOut(closeButton, expandTime)
				sightexports.sGui:setGuiPositionAnimated(helpIcon, dashboardPos[1] + dashSize[1] - dashboardPadding[3] - 32, dashboardPos[2] - dashboardPadding[3] - 32, expandTime, false, "InOutQuad")
				sightexports.sGui:setGuiHoverable(closeButton, false)
				sightexports.sGui:setLabelText(pageName, " KEZDŐLAP")
				sightexports.sGui:lockHover(dashboardGui, false)
				return expandTime
			end
		end
		addEvent("dashboardCloseClick", true)
		addEventHandler("dashboardCloseClick", getRootElement(), function(button, state, absoluteX, absoluteY, el)
			if getTickCount() - lastDashboardAnimation > expandTime + curtainTime and dashboardExpanded then
				closeDashPage()
			end
		end)
		function expandDashboard(i, j)
			if dashboardLayout[i][j].url then
				openURL(dashboardLayout[i][j].url)
				return
			end
			if dashboardLayout[i][j].checkFunction and not dashboardLayout[i][j].checkFunction() then
				return
			end
			sightexports.sGui:lockHover(dashboardGui, true)
			setDashboardState(i, j, true)
			dashboardExpanded = {i, j}
			sightexports.sGui:fadeIn(closeButton, expandTime)
			sightexports.sGui:setGuiPositionAnimated(helpIcon, dashboardPos[1] + dashSize[1] - dashboardPadding[3] - 32 - 32, dashboardPos[2] - dashboardPadding[3] - 32, expandTime, false, "InOutQuad")
			sightexports.sGui:setGuiHoverable(closeButton, true)
			sightexports.sGui:setLabelText(pageName, " " .. utf8.upper(dashboardLayout[i][j].name, ""))
			lastDashboardAnimation = getTickCount()
		end
		addEvent("dashboardElementClick", true)
		addEventHandler("dashboardElementClick", getRootElement(), function(button, state, absoluteX, absoluteY, el)
			if getTickCount() - lastDashboardAnimation > expandTime + curtainTime and not dashboardExpanded then
				for i = 1, dashboardGridSize[1] do
					for j = 1, dashboardGridSize[2] do
						if dashboardLayout[i][j] and dashboardLayout[i][j].element == el then
							expandDashboard(i, j)
							break
						end
					end
				end
			end
		end)
		--[[
		if getPlayerSerial() == "FC543CC5BCCE7C48917D1F2EB849DC03" then
			createDashboard()
			setTimer(function()
				expandDashboard(1, 3)
			end, 1500, 1)
		end
		]]
		