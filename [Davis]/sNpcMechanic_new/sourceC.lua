local sightexports = {
    sGui = false,
    sItems = false,
    sModloader = false,
    sCrate = false,
    sPattach = false,
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

local sightlangStatImgPre = nil

function sightlangStatImgPre()
    local now = getTickCount()
    if sightlangStaticImageUsed[0] then
        sightlangStaticImageUsed[0] = false
        sightlangStaticImageDel[0] = false
    elseif sightlangStaticImage[0] then
        if sightlangStaticImageDel[0] then
            if sightlangStaticImageDel[0] <= now then
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
        sightlangStaticImage[0] = dxCreateTexture("files/park.dds", "dxt3", true)
    end
    if not sightlangStatImgHand then
        sightlangStatImgHand = true
        addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
    end
end

local green = false
local greenToColor = false
local orange = false
local red = false
local grey1 = false
local blueHex = false
local redHex = false
local greenHex = false
local grabIcon = false
local downIcon = false
local faTicks = false
local function sightlangGuiRefreshColors()
    local res = getResourceFromName("sGui")
    if res and getResourceState(res) == "running" then
        green = sightexports.sGui:getColorCode("sightgreen")
        greenToColor = sightexports.sGui:getColorCodeToColor("sightgreen")
        orange = sightexports.sGui:getColorCode("sightorange")
        red = sightexports.sGui:getColorCode("sightred")
        grey1 = sightexports.sGui:getColorCode("sightgrey1")
        hudwhite = sightexports.sGui:getColorCodeToColor("hudwhite")
        blueHex = sightexports.sGui:getColorCodeHex("sightblue")
        redHex = sightexports.sGui:getColorCodeHex("sightred")
        greenHex = sightexports.sGui:getColorCodeHex("sightgreen")
        grabIcon = sightexports.sGui:getFaIconFilename("hand-rock", 24)
        downIcon = sightexports.sGui:getFaIconFilename("arrow-alt-down", 24)
        faTicks = sightexports.sGui:getFaTicks()
    end
end
addEventHandler("onGuiRefreshColors", getRootElement(), sightlangGuiRefreshColors)
addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangGuiRefreshColors)


function renderRepairPoints()
    
    sightlangStaticImageUsed[0] = true
    if sightlangStaticImageToc[0] then
        processsightlangStaticImage[0]()
    end
    
    for k, v in pairs(repairPoints) do
        local x, y, z, rot = v[1] + 3.5, v[2] - 2, v[3] - 0.95, v[4] - 90
        local length = 8
        local width = 4
        
        local radRot = math.rad(rot)
        local cosRot = math.cos(radRot)
        local sinRot = math.sin(radRot)
        
        local endX = x + cosRot * length
        local endY = y + sinRot * length
        
        local p1X = x - sinRot * 2
        local p1Y = y + cosRot * 2
        
        local p2X = x + sinRot * 2
        local p2Y = y - cosRot * 2
        
        local p3X = endX + sinRot * 2
        local p3Y = endY - cosRot * 2
        
        local p4X = endX - sinRot * 2
        local p4Y = endY + cosRot * 2
        
        local materialColor = hudwhite
        
        local veh = getPedOccupiedVehicle(localPlayer)
        if veh and isElement(veh) and getVehicleType(veh) == "Automobile" then
            local corners = getVehicleCorners(veh)
            local zoneCorners = {
                {p1X, p1Y},
                {p2X, p2Y},
                {p3X, p3Y},
                {p4X, p4Y}
            }
            
            local insideCount = 0
            for i, corner in ipairs(corners) do
                local cx, cy = corner[1], corner[2]
                if isPointInPolygon(cx, cy, zoneCorners) then
                    insideCount = insideCount + 1
                end
            end
            
            if insideCount == 4 then
                materialColor = greenToColor
                if not mechanicWindow then
                    createPanel()
                end
            else
                if mechanicWindow then
                    destroyPanel()
                end
            end
        end
        
        dxDrawMaterialLine3D(x, y, z, endX, endY, z, sightlangStaticImage[0], width, materialColor, x, y, z + 0.5)
    end
end
addEventHandler("onClientRender", root, renderRepairPoints)

mechanicWindow = false
local screenX, screenY = guiGetScreenSize()
local panelWidth, panelHeight = 500, 400

function createPanel()
    if not mechanicWindow then
        local titleBarHeight = sightexports.sGui:getTitleBarHeight()
        mechanicWindow = sightexports.sGui:createGuiElement("window", screenX / 2 - panelWidth / 2, screenY - panelHeight - 144, panelWidth, panelHeight)
        sightexports.sGui:setWindowTitle(mechanicWindow, "16/BebasNeueRegular.otf", "Járműszerelés")
        sightexports.sGui:setWindowCloseButton(mechanicWindow, "closeNPCMechanicPanel")
    end
end

addEvent("closeNPCMechanicPanel", true)
function destroyPanel()
    if mechanicWindow then
        sightexports.sGui:deleteGuiElement(mechanicWindow)
        mechanicWindow = false
    end
end
addEventHandler("closeNPCMechanicPanel", root, destroyPanel)

function getVehicleCorners(vehicle)
    local corners = {}
    local minX, minY, minZ, maxX, maxY, maxZ = getElementBoundingBox(vehicle)
    if minX and minY and maxX and maxY then
        local offsets = {
            {x = minX, y = minY},
            {x = maxX, y = minY},
            {x = maxX, y = maxY},
            {x = minX, y = maxY},
        }
        for _, offset in ipairs(offsets) do
            local cornerPos = getPositionFromElementOffset(vehicle, offset.x, offset.y, 0)
            table.insert(corners, cornerPos)
        end
    end
    return corners
end

function getPositionFromElementOffset(element, x, y, z)
    local matrix = getElementMatrix(element)
    local offsetX = x * matrix[1][1] + y * matrix[2][1] + z * matrix[3][1] + matrix[4][1]
    local offsetY = x * matrix[1][2] + y * matrix[2][2] + z * matrix[3][2] + matrix[4][2]
    local offsetZ = x * matrix[1][3] + y * matrix[2][3] + z * matrix[3][3] + matrix[4][3]
    return {offsetX, offsetY, offsetZ}
end

function isPointInPolygon(x, y, poly)
    local inside = false
    local j = #poly
    for i = 1, #poly do
        local xi, yi = poly[i][1], poly[i][2]
        local xj, yj = poly[j][1], poly[j][2]
        
        if ((yi > y) ~= (yj > y)) then
            local intersect = (xj - xi) * (y - yi) / (yj - yi + 0.00001) + xi
            if x < intersect then
                inside = not inside
            end
        end
        j = i
    end
    return inside
end