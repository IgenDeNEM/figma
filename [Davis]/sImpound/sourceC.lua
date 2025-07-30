local sightexports = {
  sGroups = false,
  sGui = false,
  sVehiclenames = false
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
sightlangStaticImageToc[6] = true
sightlangStaticImageToc[7] = true
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
  if sightlangStaticImageUsed[6] then
    sightlangStaticImageUsed[6] = false
    sightlangStaticImageDel[6] = false
  elseif sightlangStaticImage[6] then
    if sightlangStaticImageDel[6] then
      if now >= sightlangStaticImageDel[6] then
        if isElement(sightlangStaticImage[6]) then
          destroyElement(sightlangStaticImage[6])
        end
        sightlangStaticImage[6] = nil
        sightlangStaticImageDel[6] = false
        sightlangStaticImageToc[6] = true
        return
      end
    else
      sightlangStaticImageDel[6] = now + 5000
    end
  else
    sightlangStaticImageToc[6] = true
  end
  if sightlangStaticImageUsed[7] then
    sightlangStaticImageUsed[7] = false
    sightlangStaticImageDel[7] = false
  elseif sightlangStaticImage[7] then
    if sightlangStaticImageDel[7] then
      if now >= sightlangStaticImageDel[7] then
        if isElement(sightlangStaticImage[7]) then
          destroyElement(sightlangStaticImage[7])
        end
        sightlangStaticImage[7] = nil
        sightlangStaticImageDel[7] = false
        sightlangStaticImageToc[7] = true
        return
      end
    else
      sightlangStaticImageDel[7] = now + 5000
    end
  else
    sightlangStaticImageToc[7] = true
  end
  if sightlangStaticImageToc[0] and sightlangStaticImageToc[1] and sightlangStaticImageToc[2] and sightlangStaticImageToc[3] and sightlangStaticImageToc[4] and sightlangStaticImageToc[5] and sightlangStaticImageToc[6] and sightlangStaticImageToc[7] then
    sightlangStatImgHand = false
    removeEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre)
  end
end
processsightlangStaticImage[0] = function()
  if not isElement(sightlangStaticImage[0]) then
    sightlangStaticImageToc[0] = false
    sightlangStaticImage[0] = dxCreateTexture("files/arrow.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[1] = function()
  if not isElement(sightlangStaticImage[1]) then
    sightlangStaticImageToc[1] = false
    sightlangStaticImage[1] = dxCreateTexture("files/cardisc.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[2] = function()
  if not isElement(sightlangStaticImage[2]) then
    sightlangStaticImageToc[2] = false
    sightlangStaticImage[2] = dxCreateTexture("files/cardown.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[3] = function()
  if not isElement(sightlangStaticImage[3]) then
    sightlangStaticImageToc[3] = false
    sightlangStaticImage[3] = dxCreateTexture("files/carup.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[4] = function()
  if not isElement(sightlangStaticImage[4]) then
    sightlangStaticImageToc[4] = false
    sightlangStaticImage[4] = dxCreateTexture("files/winch.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[5] = function()
  if not isElement(sightlangStaticImage[5]) then
    sightlangStaticImageToc[5] = false
    sightlangStaticImage[5] = dxCreateTexture("files/impound.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[6] = function()
  if not isElement(sightlangStaticImage[6]) then
    sightlangStaticImageToc[6] = false
    sightlangStaticImage[6] = dxCreateTexture("files/tow.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[7] = function()
  if not isElement(sightlangStaticImage[7]) then
    sightlangStaticImageToc[7] = false
    sightlangStaticImage[7] = dxCreateTexture("files/road.dds", "dxt3", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
local sightlangWaiterState0 = false
local function sightlangProcessResWaiters()
  if not sightlangWaiterState0 then
    local res0 = getResourceFromName("sGroups")
    if res0 and getResourceState(res0) == "running" then
      processPermission()
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
local green = false
local red = false
local grey = false
local attachIcon = false
local faTicks = false
local function sightlangGuiRefreshColors()
  local res = getResourceFromName("sGui")
  if res and getResourceState(res) == "running" then
    green = sightexports.sGui:getColorCodeToColor("sightgreen")
    red = sightexports.sGui:getColorCodeToColor("sightred")
    grey = sightexports.sGui:getColorCodeToColor("sightgrey1")
    attachIcon = sightexports.sGui:getFaIconFilename("link", 24)
    faTicks = sightexports.sGui:getFaTicks()
  end
end
addEventHandler("onGuiRefreshColors", getRootElement(), sightlangGuiRefreshColors)
addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangGuiRefreshColors)
addEventHandler("refreshFaTicks", getRootElement(), function()
  faTicks = sightexports.sGui:getFaTicks()
end)
local sightlangCondHandlState3 = false
local function sightlangCondHandl3(cond, prio)
  cond = cond and true or false
  if cond ~= sightlangCondHandlState3 then
    sightlangCondHandlState3 = cond
    if cond then
      addEventHandler("onClientKey", getRootElement(), impoundWindowKeyPolice, true, prio)
    else
      removeEventHandler("onClientKey", getRootElement(), impoundWindowKeyPolice)
    end
  end
end
local sightlangCondHandlState2 = false
local function sightlangCondHandl2(cond, prio)
  cond = cond and true or false
  if cond ~= sightlangCondHandlState2 then
    sightlangCondHandlState2 = cond
    if cond then
      addEventHandler("onClientKey", getRootElement(), impoundWindowKey, true, prio)
    else
      removeEventHandler("onClientKey", getRootElement(), impoundWindowKey)
    end
  end
end
local sightlangCondHandlState1 = false
local function sightlangCondHandl1(cond, prio)
  cond = cond and true or false
  if cond ~= sightlangCondHandlState1 then
    sightlangCondHandlState1 = cond
    if cond then
      addEventHandler("onClientClick", getRootElement(), towClick, true, prio)
    else
      removeEventHandler("onClientClick", getRootElement(), towClick)
    end
  end
end
local sightlangCondHandlState0 = false
local function sightlangCondHandl0(cond, prio)
  cond = cond and true or false
  if cond ~= sightlangCondHandlState0 then
    sightlangCondHandlState0 = cond
    if cond then
      addEventHandler("onClientRender", getRootElement(), towRender, true, prio)
    else
      removeEventHandler("onClientRender", getRootElement(), towRender)
    end
  end
end
local hoveredCarIcon = false
local tmpCarIcon = false
local carIconX, carIconY = 32, 32
local pos = {
  0.78211838006973,
  -2.5830059051514,
  -0.085817605257034
}
local gvcp = getVehicleComponentPosition
function getVehicleComponentPosition(veh, comp, rel)
  local x, y, z = gvcp(veh, comp, rel)
  return tonumber(x) or 0, tonumber(y) or 0, tonumber(z) or 0
end
local bbox = getElementBoundingBox
function getElementBoundingBox(el)
  local x, y, z, x2, y2, z2 = bbox(el)
  return tonumber(x) or 0, tonumber(y) or 0, tonumber(z) or 0, tonumber(x2) or 0, tonumber(y2) or 0, tonumber(z2) or 0
end
function attachRotationAdjusted(from, to)
  local frPosX, frPosY, frPosZ = getElementPosition(from)
  local frRotX, frRotY, frRotZ = getElementRotation(from)
  local toPosX, toPosY, toPosZ = getElementPosition(to)
  local toRotX, toRotY, toRotZ = getElementRotation(to)
  local offsetPosX = frPosX - toPosX
  local offsetPosY = frPosY - toPosY
  local offsetPosZ = frPosZ - toPosZ
  local offsetRotX = frRotX - toRotX
  local offsetRotY = frRotY - toRotY
  local offsetRotZ = frRotZ - toRotZ
  offsetPosX, offsetPosY, offsetPosZ = applyInverseRotation(offsetPosX, offsetPosY, offsetPosZ, toRotX, toRotY, toRotZ)
  return offsetPosX, offsetPosY, offsetPosZ, offsetRotX, offsetRotY, offsetRotZ
end
function applyInverseRotation(x, y, z, rx, ry, rz)
  local DEG2RAD = math.pi * 2 / 360
  rx = rx * DEG2RAD
  ry = ry * DEG2RAD
  rz = rz * DEG2RAD
  local tempY = y
  y = math.cos(rx) * tempY + math.sin(rx) * z
  z = -math.sin(rx) * tempY + math.cos(rx) * z
  local tempX = x
  x = math.cos(ry) * tempX - math.sin(ry) * z
  z = math.sin(ry) * tempX + math.cos(ry) * z
  tempX = x
  x = math.cos(rz) * tempX + math.sin(rz) * y
  y = -math.sin(rz) * tempX + math.cos(rz) * y
  return x, y, z
end
local interpolations = {}
local playerHandLines = {}
local selectedPacker = false
local carOnPacker = false
local hasPermission = false
local activePacker = false
local activeButton = false
function processPermission()
  local tmp = sightexports.sGroups:getPlayerPermission("packerTow")
  if tmp ~= hasPermission then
    hasPermission = true
    if activeButton then
      sightexports.sGui:setCursorType("normal")
    end
    activePacker = false
    activeButton = false
    sightlangCondHandl0(hasPermission)
    sightlangCondHandl1(hasPermission)
  end
end
addEvent("gotPlayerGroupPermissions", true)
addEventHandler("gotPlayerGroupPermissions", getRootElement(), function()
  processPermission()
end)
addEventHandler("onClientVehicleEnter", getRootElement(), function(player)
  if player == localPlayer then
    carOnPacker = getElementData(source, "carOnPacker")
  end
end)
local screenX, screenY = guiGetScreenSize()
local _getCursorPosition = getCursorPosition
function getCursorPosition()
  if isCursorShowing() then
    local x, y, worldX, worldY, worldZ = _getCursorPosition()
    return x * screenX, y * screenY
  else
    return -9999, -9999
  end
end
local packerRampState = {}
local carRoped = {}
local carAttached = {}
local packerInAnimation = {}
function towClick(button, state, absoluteX, absoluteY, worldX, worldY, worldZ, clickedElement)
  if state == "up" then
    if isElement(activePacker) then
      if activeButton == "cardisc" then
        if not packerInAnimation[activePacker] then
          triggerServerEvent("packerDisconnectCar", localPlayer, activePacker)
        end
      elseif activeButton == "cardown" then
        if not packerInAnimation[activePacker] then
          triggerServerEvent("packerDetachCar", localPlayer, activePacker)
        end
      elseif activeButton == "carup" then
        local dat = getElementData(activePacker, "carRoped")
        if dat and isElement(dat[1]) then
          local veh = dat[1]
          local counter = 0
          for seat, player in pairs(getVehicleOccupants(veh)) do
            counter = counter + 1
          end
          if counter == 0 then
            local ox, oy, oz = getPositionFromElementOffset(activePacker, 0, -13, -0.5)
            local x, y, z = getElementPosition(veh)
            local canUse = allowedVehicleTypes[getVehicleType(veh)]
            if not canUse or getElementModel(veh) == 443 then
              outputChatBox("[color=sightred][SightMTA - Lefoglalás]: #ffffffCsak autókat foglalhatsz le.", 255, 255, 255, true)
            elseif not getElementData(veh, "vehicle.dbID") then
              outputChatBox("[color=sightred][SightMTA - Lefoglalás]: #ffffffCsak olyan autót foglalhatsz le, melynek van tulajdonosa.", 255, 255, 255, true)
            elseif getDistanceBetweenPoints2D(x, y, ox, oy) <= 2 then
              local rx, ry, rz1 = getElementRotation(veh)
              local rx, ry, rz2 = getElementRotation(activePacker)
              local shortest_angle = math.abs(((rz1 - rz2) % 360 + 540) % 360 - 180)
              rot = 0
              if 90 < shortest_angle then
                rot = 180
              end
              local offsetPosX, offsetPosY, offsetPosZ, offsetRotX, offsetRotY, offsetRotZ = attachRotationAdjusted(veh, activePacker)
              local x, y, zCorrection
              if getVehicleType(veh) ~= "Automobile" then
                if getVehicleType(veh) ~= "Quad" then
                  x, y, zCorrection = getVehicleComponentPosition(veh, "wheel_front")
                else
                  x, y, zCorrection = getVehicleComponentPosition(veh, "wheel_rf_dummy")
                end
              else
                x, y, zCorrection = getVehicleComponentPosition(veh, "wheel_rf_dummy")
              end
              x, y, z = getVehicleComponentPosition(veh, "wheel_rf_dummy", "world")
              local gz = getGroundPosition(x, y, z)
              zCorrection = zCorrection + (z - gz) * 0.25
              if not packerInAnimation[activePacker] then
                triggerServerEvent("packerAttachCar", localPlayer, activePacker, veh, {
                  offsetPosX,
                  offsetPosY,
                  offsetPosZ,
                  offsetRotX,
                  offsetRotY,
                  offsetRotZ
                }, zCorrection, rot)
              end
            else
              outputChatBox("[color=sightred][SightMTA - Lefoglalás]: #ffffffAz autó nincs az autószállító mögött!", 255, 255, 255, true)
            end
          else
            outputChatBox("[color=sightred][SightMTA - Lefoglalás]: #ffffffEbben az autóban ülnek!", 255, 255, 255, true)
          end
        end
      elseif activeButton == "winch" then
        if selectedPacker == activePacker then
          selectedPacker = false
          setElementData(localPlayer, "packerLine", false)
        else
          selectedPacker = activePacker
          setElementData(localPlayer, "packerLine", activePacker)
        end
      elseif activeButton == "ramp" then
        if not packerInAnimation[activePacker] then
          triggerServerEvent("packerRamp", localPlayer, activePacker)
        end
      end
    elseif (hoveredCarIcon or clickedElement) and selectedPacker then
      if clickedElement == selectedPacker then
        selectedPacker = false
        setElementData(localPlayer, "packerLine", false)
      elseif hoveredCarIcon then
        local counter = 0
        for seat, player in pairs(getVehicleOccupants(hoveredCarIcon)) do
          counter = counter + 1
        end
        if counter == 0 then
          local ox, oy, oz = getPositionFromElementOffset(selectedPacker, 0, -13, -0.5)
          local x, y, z = getElementPosition(hoveredCarIcon)
          local canUse = allowedVehicleTypes[getVehicleType(hoveredCarIcon)]
          if not canUse or getElementModel(hoveredCarIcon) == 443 then
            outputChatBox("[color=sightred][SightMTA - Lefoglalás]: #ffffffCsak autókat foglalhatsz le.", 255, 255, 255, true)
          elseif not getElementData(hoveredCarIcon, "vehicle.dbID") then
            outputChatBox("[color=sightred][SightMTA - Lefoglalás]: #ffffffCsak olyan autót foglalhatsz le, melynek van tulajdonosa.", 255, 255, 255, true)
          elseif getDistanceBetweenPoints2D(x, y, ox, oy) <= 2 then
            local rx, ry, rz1 = getElementRotation(hoveredCarIcon)
            local rx, ry, rz2 = getElementRotation(selectedPacker)
            local shortest_angle = math.abs(((rz1 - rz2) % 360 + 540) % 360 - 180)
            rot = 0
            if 90 < shortest_angle then
              rot = 180
            end
            triggerServerEvent("packerConnectCar", localPlayer, selectedPacker, hoveredCarIcon, rot)
            setElementData(localPlayer, "packerLine", false)
            selectedPacker = false
          else
            outputChatBox("[color=sightred][SightMTA - Lefoglalás]: #ffffffAz autó nincs az autószállító mögött!", 255, 255, 255, true)
          end
        else
          outputChatBox("[color=sightred][SightMTA - Lefoglalás]: #ffffffEbben az autóban ülnek!", 255, 255, 255, true)
        end
      end
    end
  end
end
function towRender()
  local tmpButton = false
  local tmpPacker = false
  if not isPedInVehicle(localPlayer) then
    local vehs = getElementsByType("vehicle", getRootElement(), true)
    local cx, cy = getCursorPosition()
    local px, py, pz = getElementPosition(localPlayer)
    for k = 1, #vehs do
      local veh = vehs[k]
      if getElementModel(veh) == 443 then
        local rx, ry, rz = getElementRotation(veh)
        local x, y, z = getPositionFromElementOffset(veh, -1.35, -5.5, 0.25)
        if 1 > getDistanceBetweenPoints3D(x, y, z, px, py, pz) then
          local angle = math.abs(((rz - (math.deg(math.atan2(y - py, x - px)) + 180)) % 360 + 540) % 360 - 180)
          if 90 < angle then
            local x, y = getScreenFromWorldPosition(x, y, z, 512)
            if x then
              dxDrawRectangle(x - 32, y - 32, 64, 64, grey)
              if cx >= x - 32 and cy >= y - 32 and cx <= x + 32 and cy <= y + 32 then
                sightlangStaticImageUsed[0] = true
                if sightlangStaticImageToc[0] then
                  processsightlangStaticImage[0]()
                end
                dxDrawImage(x - 24, y - 24, 48, 48, sightlangStaticImage[0], packerRampState[veh] and 180 or 0, 0, 0, green)
                tmpPacker = veh
                tmpButton = "ramp"
              else
                sightlangStaticImageUsed[0] = true
                if sightlangStaticImageToc[0] then
                  processsightlangStaticImage[0]()
                end
                dxDrawImage(x - 24, y - 24, 48, 48, sightlangStaticImage[0], packerRampState[veh] and 180 or 0)
              end
            end
          end
        end
        if carRoped[veh] and isElement(carRoped[veh][1]) then
          local minX, minY, minZ = getVehicleComponentPosition(carRoped[veh][1], "wheel_rf_dummy")
          local minX, minY, minZ2, maxX, maxY, maxZ = getElementBoundingBox(carRoped[veh][1])
          local x, y, z = getPositionFromElementOffset(carRoped[veh][1], 0, (carRoped[veh][2] and minY or maxY) * 0.9, minZ)
          if getDistanceBetweenPoints3D(x, y, z, px, py, pz) < 2.5 then
            local x, y = getScreenFromWorldPosition(x, y, z, 512)
            if x then
              dxDrawRectangle(x - 32, y - 32, 64, 64, grey)
              if cx >= x - 32 and cy >= y - 32 and cx <= x + 32 and cy <= y + 32 then
                sightlangStaticImageUsed[1] = true
                if sightlangStaticImageToc[1] then
                  processsightlangStaticImage[1]()
                end
                dxDrawImage(x - 24, y - 24, 48, 48, sightlangStaticImage[1], 0, 0, 0, green)
                tmpPacker = veh
                tmpButton = "cardisc"
              else
                sightlangStaticImageUsed[1] = true
                if sightlangStaticImageToc[1] then
                  processsightlangStaticImage[1]()
                end
                dxDrawImage(x - 24, y - 24, 48, 48, sightlangStaticImage[1])
              end
            end
          end
        else
          carRoped[veh] = nil
        end
        local x, y, z = getPositionFromElementOffset(veh, 0.3, 0.8, 0.5)
        if getDistanceBetweenPoints3D(x, y, z, px, py, pz) < 2.5 then
          local x, y = getScreenFromWorldPosition(x, y, z, 512)
          if x then
            if carAttached[veh] then
              if packerRampState[veh] then
                dxDrawRectangle(x - 32, y - 32, 64, 64, grey)
                if cx >= x - 32 and cy >= y - 32 and cx <= x + 32 and cy <= y + 32 then
                  sightlangStaticImageUsed[2] = true
                  if sightlangStaticImageToc[2] then
                    processsightlangStaticImage[2]()
                  end
                  dxDrawImage(x - 24, y - 24, 48, 48, sightlangStaticImage[2], 0, 0, 0, green)
                  tmpPacker = veh
                  tmpButton = "cardown"
                else
                  sightlangStaticImageUsed[2] = true
                  if sightlangStaticImageToc[2] then
                    processsightlangStaticImage[2]()
                  end
                  dxDrawImage(x - 24, y - 24, 48, 48, sightlangStaticImage[2])
                end
              end
            elseif carRoped[veh] then
              if packerRampState[veh] then
                dxDrawRectangle(x - 32, y - 32, 64, 64, grey)
                if cx >= x - 32 and cy >= y - 32 and cx <= x + 32 and cy <= y + 32 then
                  sightlangStaticImageUsed[3] = true
                  if sightlangStaticImageToc[3] then
                    processsightlangStaticImage[3]()
                  end
                  dxDrawImage(x - 24, y - 24, 48, 48, sightlangStaticImage[3], 0, 0, 0, green)
                  tmpPacker = veh
                  tmpButton = "carup"
                else
                  sightlangStaticImageUsed[3] = true
                  if sightlangStaticImageToc[3] then
                    processsightlangStaticImage[3]()
                  end
                  dxDrawImage(x - 24, y - 24, 48, 48, sightlangStaticImage[3])
                end
              end
            else
              dxDrawRectangle(x - 32, y - 32, 64, 64, grey)
              dxDrawRectangle(x - 32, y - 32, 64, 64, grey)
              if cx >= x - 32 and cy >= y - 32 and cx <= x + 32 and cy <= y + 32 then
                sightlangStaticImageUsed[4] = true
                if sightlangStaticImageToc[4] then
                  processsightlangStaticImage[4]()
                end
                dxDrawImage(x - 24, y - 24, 48, 48, sightlangStaticImage[4], 0, 0, 0, green)
                tmpPacker = veh
                tmpButton = "winch"
              else
                sightlangStaticImageUsed[4] = true
                if sightlangStaticImageToc[4] then
                  processsightlangStaticImage[4]()
                end
                dxDrawImage(x - 24, y - 24, 48, 48, sightlangStaticImage[4])
              end
            end
          end
        end
      end
    end
  end
  if activeButton ~= tmpButton or activePacker ~= tmpPacker then
    activeButton = tmpButton
    activePacker = tmpPacker
    sightexports.sGui:setCursorType(activeButton and "link" or "normal")
  end
end
addEventHandler("onClientResourceStart", getResourceRootElement(), function()
  local vehs = getElementsByType("vehicle")
  for k = 1, #vehs do
    local veh = vehs[k]
    if getElementModel(veh) == 443 then
      carRoped[veh] = getElementData(veh, "carRoped")
      carAttached[veh] = getElementData(veh, "carAttached")
      packerRampState[veh] = getElementData(veh, "packerRampState")
      if packerRampState[veh] then
        setVehicleComponentPosition(veh, "ramp", pos[1], pos[2] - 3.75, pos[3] - 0.15)
        setVehicleComponentRotation(veh, "ramp", 20, 0, 0)
      else
        setVehicleComponentPosition(veh, "ramp", pos[1], pos[2], pos[3])
        setVehicleComponentRotation(veh, "ramp", 0, 0, 0)
      end
    end
  end
end)
addEventHandler("onClientElementStreamIn", getResourceRootElement(), function()
  if getElementData(source, "packerRampState") then
    setVehicleComponentPosition(source, "ramp", pos[1], pos[2] - 3.75, pos[3] - 0.15)
    setVehicleComponentRotation(source, "ramp", 20, 0, 0)
  end
end)
addEvent("packerAttachAnimation", true)
addEventHandler("packerAttachAnimation", getRootElement(), function(packer, veh, data, zCorrection, rotCorrection)
  local x, y, z = getPositionFromElementOffset(packer, 0.3, 0.8, 0.5)
  local sound = playSound3D("files/winch.mp3", x, y, z)
  setSoundMaxDistance(sound, 60)
  packerInAnimation[packer] = true
  table.insert(interpolations, {
    "attach",
    packer,
    veh,
    getTickCount(),
    1,
    data,
    zCorrection,
    rotCorrection
  })
end)
addEvent("packerDetachAnimation", true)
addEventHandler("packerDetachAnimation", getRootElement(), function(packer, veh, zCorrection, rotCorrection)
  local x, y, z = getPositionFromElementOffset(packer, 0.3, 0.8, 0.5)
  local sound = playSound3D("files/winch.mp3", x, y, z)
  setSoundMaxDistance(sound, 60)
  packerInAnimation[packer] = true
  table.insert(interpolations, {
    "detach",
    packer,
    veh,
    getTickCount(),
    1,
    false,
    zCorrection,
    rotCorrection
  })
end)
addEventHandler("onClientElementDataChange", getRootElement(), function(data, oldData)
  if data == "carAttached" then
    carAttached[source] = getElementData(source, "carAttached")
  elseif data == "carRoped" then
    carRoped[source] = getElementData(source, "carRoped")
    if carRoped[source] then
      local minX, minY, minZ = getVehicleComponentPosition(carRoped[source][1], "wheel_rf_dummy")
      local minX, minY, minZ2, maxX, maxY, maxZ = getElementBoundingBox(carRoped[source][1])
      x, y, z = getPositionFromElementOffset(carRoped[source][1], 0, (carRoped[source][2] and minY or maxY) * 0.9, minZ)
      local sound = playSound3D("files/couple.mp3", x, y, z)
      setSoundMaxDistance(sound, 60)
    elseif oldData and isElement(oldData[1]) then
      local minX, minY, minZ = getVehicleComponentPosition(oldData[1], "wheel_rf_dummy")
      local minX, minY, minZ2, maxX, maxY, maxZ = getElementBoundingBox(oldData[1])
      local x, y, z = getPositionFromElementOffset(oldData[1], 0, (oldData[2] and minY or maxY) * 0.9, minZ)
      local sound = playSound3D("files/couple.mp3", x, y, z)
      setSoundMaxDistance(sound, 60)
    end
  elseif data == "packerRampState" then
    packerRampState[source] = getElementData(source, "packerRampState")
    table.insert(interpolations, {
      "ramp",
      source,
      getTickCount(),
      1,
      packerRampState[source]
    })
    if getElementData(source, "packerRampState") then
      local x, y, z = getVehicleComponentPosition(source, "ramp", "world")
      local sound = playSound3D("files/slide.mp3", x, y, z)
      setSoundMaxDistance(sound, 60)
    else
      local x, y, z = getVehicleComponentPosition(source, "ramp", "world")
      local sound = playSound3D("files/rotup.mp3", x, y, z)
      setSoundMaxDistance(sound, 60)
    end
  elseif data == "carOnPacker" and source == getPedOccupiedVehicle(localPlayer) then
    carOnPacker = getElementData(source, "carOnPacker")
  elseif data == "packerLine" then
    local val = getElementData(source, "packerLine")
    for k = 1, #playerHandLines do
      if playerHandLines[k] and playerHandLines[k][1] == source then
        table.remove(playerHandLines, k)
        break
      end
    end
    if isElement(val) then
      table.insert(playerHandLines, {source, val})
    end
  end
end)
function degreeInterpolate(start, enda, amount)
  local shortest_angle = ((enda - start) % 360 + 540) % 360 - 180
  return start + shortest_angle * amount % 360
end
function previewPacker(veh, size)
  local ox, oy, oz = getPositionFromElementOffset(veh, 0, -13, -0.5)
  local x, y = getScreenFromWorldPosition(ox, oy, oz, (size or 128) / 2)
  local vehs = getElementsByType("vehicle", getRootElement(), true)
  if x and y then
    local found = false
    if carAttached[veh] then
      local color = red
      for i = 1, #impoundPositions do
        local maxX, maxY, minX, minY, zoneZ = impoundPositions[i][1], impoundPositions[i][2], impoundPositions[i][3], impoundPositions[i][4], impoundPositions[i][5]
        if ox >= minX and oy >= minY and ox <= maxX and oy <= maxY then
          color = green
          break
        end
      end
      sightlangStaticImageUsed[5] = true
      if sightlangStaticImageToc[5] then
        processsightlangStaticImage[5]()
      end
      dxDrawImage(x - (size or 128) / 2, y - (size or 128) / 2, size or 128, size or 128, sightlangStaticImage[5], 0, 0, 0, color)
    else
      for k = 1, #vehs do
        local canUse = allowedVehicleTypes[getVehicleType(vehs[k])]
        if canUse and getElementModel(vehs[k]) ~= 443 then
          local cx, cy = getElementPosition(vehs[k])
          if 2 >= getDistanceBetweenPoints2D(cx, cy, ox, oy) then
            found = true
            break
          end
        end
      end
      sightlangStaticImageUsed[6] = true
      if sightlangStaticImageToc[6] then
        processsightlangStaticImage[6]()
      end
      dxDrawImage(x - (size or 128) / 2, y - (size or 128) / 2, size or 128, size or 128, sightlangStaticImage[6], 0, 0, 0, found and green or red)
    end
  end
  if not getPedOccupiedVehicle(localPlayer) then
    local renderedIcon = false
    for k = 1, #vehs do
      local canUse = allowedVehicleTypes[getVehicleType(vehs[k])]
      if canUse and getElementModel(vehs[k]) ~= 443 then
        local cx, cy = getElementPosition(vehs[k])
        if 2 >= getDistanceBetweenPoints2D(cx, cy, ox, oy) then
          renderedIcon = vehs[k]
          break
        end
      end
    end
    if renderedIcon then
      local minX, minY, minZ = getVehicleComponentPosition(renderedIcon, "wheel_rf_dummy")
      local minX, minY, minZ2, maxX, maxY, maxZ = getElementBoundingBox(renderedIcon)
      local x2, y2, z2 = getPositionFromElementOffset(renderedIcon, 0, (rot and minY or maxY) * 0.9, minZ)
      local x, y = getScreenFromWorldPosition(x2, y2, z2, (size or 128) / 2)
      if x and y then
        local cx, cy = getCursorPosition()
        if cx and cy then
          if cx >= x - carIconX / 2 and cy >= y - carIconY / 2 and cx < x + carIconX / 2 and cy < y + carIconY / 2 then
            hoveredCarIcon = renderedIcon
          else
            hoveredCarIcon = false
          end
        else
          hoveredCarIcon = false
        end
        if tmpCarIcon ~= hoveredCarIcon then
          if hoveredCarIcon then
            sightexports.sGui:setCursorType("link")
          else
            sightexports.sGui:setCursorType("normal")
          end
          tmpCarIcon = hoveredCarIcon
        end
        dxDrawRectangle(x - carIconX / 2, y - carIconY / 2, carIconX, carIconY, grey)
        dxDrawImage(x - 12, y - 12, 24, 24, ":sGui/" .. attachIcon .. (faTicks[attachIcon] or ""), 0, 0, 0, hoveredCarIcon and green or tocolor(255, 255, 255, 255))
      end
    end
  end
end
function getVehicleSpeed(currentElement)
  if isElement(currentElement) then
    local x, y, z = getElementVelocity(currentElement)
    return math.sqrt(x ^ 2 + y ^ 2 + z ^ 2) * 187.5
  end
end
function drawCarRope(packer, veh, rot, adv)
  local x, y, z = getPositionFromElementOffset(packer, 0.3, 0.8, 0.5)
  local minX, minY, minZ = getVehicleComponentPosition(veh, "wheel_rf_dummy")
  local minX, minY, minZ2, maxX, maxY, maxZ = getElementBoundingBox(veh)
  local x2, y2, z2 = getPositionFromElementOffset(veh, 0, (rot and minY or maxY) * 0.9, minZ)
  if adv then
    local xh, yh, zh = 0, 0, 0
    local bend = false
    local steps = getDistanceBetweenPoints2D(x, y, x2, y2) * 1.5
    for i = 1, steps do
      local xp, yp = interpolateBetween(x, y, z, x2, y2, z2, i / steps, "Linear")
      local hit, hitX, hitY, hitZ, el = processLineOfSight(xp, yp, z + 10, xp, yp, z - 10, false, true, false, false, false, false)
      if el == packer then
        xh, yh, zh = xp, yp, hitZ + 0.025
      else
        bend = true
        break
      end
    end
    if bend and z2 < zh then
      dxDrawLine3D(x, y, z, xh, yh, zh, tocolor(20, 20, 20), 4)
      dxDrawLine3D(xh, yh, zh, x2, y2, z2, tocolor(20, 20, 20), 4)
    else
      dxDrawLine3D(x, y, z, x2, y2, z2, tocolor(20, 20, 20), 4)
    end
  else
    dxDrawLine3D(x, y, z, x2, y2, z2, tocolor(20, 20, 20), 4)
  end
end
function reMap(x, in_min, in_max, out_min, out_max)
  return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min
end
addEventHandler("onClientRender", getRootElement(), function()
  local camX, camY, camZ = getCameraMatrix()
  for i = 1, #impoundPositions do
    local maxX, maxY, minX, minY, zoneZ = impoundPositions[i][1], impoundPositions[i][2], impoundPositions[i][3], impoundPositions[i][4], impoundPositions[i][5]
    if getDistanceBetweenPoints3D(camX, camY, camZ, minX, minY, zoneZ) <= 100 then
      if impoundPositions[i][6] then
        sightlangStaticImageUsed[7] = true
        if sightlangStaticImageToc[7] then
          processsightlangStaticImage[7]()
        end
        dxDrawMaterialLine3D(maxX, minY + (maxY - minY) / 2, zoneZ, minX, minY + (maxY - minY) / 2, zoneZ, sightlangStaticImage[7], maxX - minX, tocolor(220, 180, 90), false, minX + (maxX - minX) / 2, minY + (maxY - minY) / 2, zoneZ + 1)
      else
        sightlangStaticImageUsed[7] = true
        if sightlangStaticImageToc[7] then
          processsightlangStaticImage[7]()
        end
        dxDrawMaterialLine3D(minX + (maxX - minX) / 2, minY, zoneZ, minX + (maxX - minX) / 2, maxY, zoneZ, sightlangStaticImage[7], maxX - minX, tocolor(220, 180, 90), false, minX + (maxX - minX) / 2, minY + (maxY - minY) / 2, zoneZ + 1)
      end
    end
  end
  for packer, veh in pairs(carAttached) do
    if isElement(packer) and veh and isElement(veh[1]) then
      drawCarRope(packer, veh[1], veh[3] == 180, packerInAnimation[packer])
    else
      carAttached[packer] = nil
    end
  end
  for packer, veh in pairs(carRoped) do
    if isElement(packer) and veh and isElement(veh[1]) then
      drawCarRope(packer, veh[1], veh[2], true)
    else
      carRoped[packer] = nil
    end
  end
  for k = #interpolations, 1, -1 do
    if interpolations[k] then
      if interpolations[k][1] == "attach" and isElement(interpolations[k][2]) and isElement(interpolations[k][3]) then
        local progress = (getTickCount() - interpolations[k][4]) / carAnimationTime
        if progress <= 1 then
          local offsetPosX, offsetPosY, offsetPosZ = 0, 0, 0
          local offsetRotX, offsetRotY, offsetRotZ = 0, 0, interpolations[k][8]
          if interpolations[k][5] == 1 then
            offsetPosX, offsetPosY, offsetPosZ = interpolateBetween(interpolations[k][6][1], interpolations[k][6][2], interpolations[k][6][3], 0, -8, 0.1 - interpolations[k][7], progress, "InOutQuad")
            offsetRotX = degreeInterpolate(interpolations[k][6][4], 20 * math.cos(math.rad(interpolations[k][8])), getEasingValue(progress, "InOutQuad"))
            offsetRotY = degreeInterpolate(interpolations[k][6][5], 0, getEasingValue(progress, "InOutQuad"))
            offsetRotZ = degreeInterpolate(interpolations[k][6][6], interpolations[k][8], getEasingValue(progress, "InOutQuad"))
          else
            offsetPosX, offsetPosY, offsetPosZ = interpolateBetween(0, -8, 0.1 - interpolations[k][7], 0, -2.5, 0.9 - interpolations[k][7], progress, "InOutQuad")
            offsetRotX = degreeInterpolate(20 * math.cos(math.rad(interpolations[k][8])), 0, getEasingValue(progress, "InOutQuad"))
            offsetPosZ = offsetPosZ + 0.25 * getEasingValue(math.min(progress * 2, 2 - progress * 2), "InOutQuad")
          end
          attachElements(interpolations[k][3], interpolations[k][2], offsetPosX, offsetPosY, offsetPosZ, offsetRotX, offsetRotY, offsetRotZ)
        else
          interpolations[k][4] = getTickCount()
          interpolations[k][5] = interpolations[k][5] + 1
          if 2 < interpolations[k][5] then
            attachElements(interpolations[k][3], interpolations[k][2], 0, -2.5, 0.9 - interpolations[k][7], 0, 0, interpolations[k][8])
            packerInAnimation[interpolations[k][2]] = false
            table.remove(interpolations, k)
          else
            local x, y, z = getPositionFromElementOffset(interpolations[k][2], 0.3, 0.8, 0.5)
            local sound = playSound3D("files/winch.mp3", x, y, z)
            setSoundMaxDistance(sound, 60)
          end
        end
      elseif interpolations[k][1] == "detach" and isElement(interpolations[k][2]) and isElement(interpolations[k][3]) then
        local progress = (getTickCount() - interpolations[k][4]) / carAnimationTime
        if progress <= 1 then
          local offsetPosX, offsetPosY, offsetPosZ = 0, 0, 0
          local offsetRotX, offsetRotY, offsetRotZ = 0, 0, interpolations[k][8]
          if interpolations[k][5] == 1 then
            offsetPosX, offsetPosY, offsetPosZ = interpolateBetween(0, -2.5, 0.9 - interpolations[k][7], 0, -8, 0.1 - interpolations[k][7], progress, "InOutQuad")
            offsetRotX = degreeInterpolate(0, 20 * math.cos(math.rad(interpolations[k][8])), getEasingValue(progress, "InOutQuad"))
            offsetPosZ = offsetPosZ + 0.25 * getEasingValue(math.min(progress * 2, 2 - progress * 2), "InOutQuad")
          else
            offsetPosX, offsetPosY, offsetPosZ = interpolateBetween(0, -8, 0.1 - interpolations[k][7], 0, -13, -0.5 - interpolations[k][7], progress, "InOutQuad")
            offsetRotX = degreeInterpolate(20 * math.cos(math.rad(interpolations[k][8])), 0, getEasingValue(progress, "InOutQuad"))
          end
          attachElements(interpolations[k][3], interpolations[k][2], offsetPosX, offsetPosY, offsetPosZ, offsetRotX, offsetRotY, offsetRotZ)
        else
          interpolations[k][4] = getTickCount()
          interpolations[k][5] = interpolations[k][5] + 1
          if 2 < interpolations[k][5] then
            detachElements(interpolations[k][3], interpolations[k][2])
            local x, y, z = getPositionFromElementOffset(interpolations[k][2], 0, -13, -0.5 - interpolations[k][7])
            local rx, ry, rz = getElementRotation(interpolations[k][2])
            setElementPosition(interpolations[k][3], x, y, z)
            setElementRotation(interpolations[k][3], rx, ry, rz + interpolations[k][8])
            packerInAnimation[interpolations[k][2]] = false
            table.remove(interpolations, k)
          else
            local x, y, z = getPositionFromElementOffset(interpolations[k][2], 0.3, 0.8, 0.5)
            local sound = playSound3D("files/winch.mp3", x, y, z)
            setSoundMaxDistance(sound, 60)
          end
        end
      elseif interpolations[k][1] == "ramp" and isElement(interpolations[k][2]) then
        local time = (interpolations[k][5] and interpolations[k][4] == 1 or not interpolations[k][5] and interpolations[k][4] == 2) and slideAnimationTime or rotateAnimationTime
        local progress = (getTickCount() - interpolations[k][3]) / time
        local y, z, r = 3.75, 0.15, 20
        if interpolations[k][5] then
          if interpolations[k][4] == 1 then
            y = interpolateBetween(0, 0, 0, 3.75, 0, 0, progress, "InOutQuad")
            z, r = 0, 0
          elseif interpolations[k][4] == 2 then
            z, r = interpolateBetween(0, 0, 0, 0.15, 20, 0, progress, "InOutQuad")
          end
        elseif interpolations[k][4] == 1 then
          z, r = interpolateBetween(0.15, 20, 0, 0, 0, 0, progress, "InOutQuad")
        elseif interpolations[k][4] == 2 then
          y = interpolateBetween(3.75, 0, 0, 0, 0, 0, progress, "InOutQuad")
          z, r = 0, 0
        end
        setVehicleComponentPosition(interpolations[k][2], "ramp", pos[1], pos[2] - y, pos[3] - z)
        setVehicleComponentRotation(interpolations[k][2], "ramp", r, 0, 0)
        if 1 <= progress then
          interpolations[k][3] = getTickCount()
          interpolations[k][4] = interpolations[k][4] + 1
          if interpolations[k][4] == 2 then
            if not interpolations[k][5] then
              local x, y, z = getVehicleComponentPosition(interpolations[k][2], "ramp", "world")
              local sound = playSound3D("files/slide.mp3", x, y, z)
              setSoundMaxDistance(sound, 60)
            else
              local x, y, z = getVehicleComponentPosition(interpolations[k][2], "ramp", "world")
              local sound = playSound3D("files/rotdown.mp3", x, y, z)
              setSoundMaxDistance(sound, 60)
            end
          end
          if 2 < interpolations[k][4] then
            table.remove(interpolations, k)
          end
        end
      else
        table.remove(interpolations, k)
      end
    else
      table.remove(interpolations, k)
    end
  end
  for k = #playerHandLines, 1, -1 do
    if playerHandLines[k] and isElement(playerHandLines[k][1]) and isElementStreamedIn(playerHandLines[k][1]) and isElement(playerHandLines[k][2]) then
      local x, y, z = getPositionFromElementOffset(playerHandLines[k][2], 0.3, 0.8, 0.5)
      local x2, y2, z2 = getPedBonePosition(playerHandLines[k][1], 24)
      local xh, yh, zh = 0, 0, 0
      local bend = false
      local steps = 0
      if x and y and x2 and y2 then
        steps = getDistanceBetweenPoints2D(x, y, x2, y2) * 2.5
      end
      if not (x2 and y2) or not z2 then
        steps = 0
      end
      if math.floor(steps * 1.25) ~= playerHandLines[k][3] then
        playerHandLines[k][3] = math.floor(steps * 1.25)
        local sound = playSound3D("files/ratchet.mp3", x, y, z)
        setSoundMaxDistance(sound, 60)
      end
      for i = 1, steps do
        local xp, yp = interpolateBetween(x, y, z, x2, y2, z2, i / steps, "Linear")
        local hit, hitX, hitY, hitZ, el = processLineOfSight(xp, yp, z + 10, xp, yp, z - 10, false, true, false, false, false, false)
        if el == playerHandLines[k][2] then
          xh, yh, zh = xp, yp, hitZ + 0.025
        else
          bend = true
          break
        end
      end
      if bend and z2 < zh then
        dxDrawLine3D(x, y, z, xh, yh, zh, tocolor(20, 20, 20), 4)
        dxDrawLine3D(xh, yh, zh, x2, y2, z2, tocolor(20, 20, 20), 4)
      elseif x2 and y2 and z2 then
        dxDrawLine3D(x, y, z, x2, y2, z2, tocolor(20, 20, 20), 4)
      end
    else
      table.remove(playerHandLines, k)
    end
  end
  local veh = getPedOccupiedVehicle(localPlayer)
  if veh and getElementModel(veh) == 443 and (20 > getVehicleSpeed(veh) or getVehicleCurrentGear(veh) == 0) then
    previewPacker(veh, 96)
  end
  if selectedPacker then
    if isPedInVehicle(localPlayer) or not isElement(selectedPacker) then
      setElementData(localPlayer, "packerLine", false)
      selectedPacker = false
    else
      local px, py, pz = getElementPosition(localPlayer)
      local cx, cy, cz = getElementPosition(selectedPacker)
      if getDistanceBetweenPoints3D(px, py, pz, cx, cy, cz) > 20 then
        setElementData(localPlayer, "packerLine", false)
        selectedPacker = false
      else
        previewPacker(selectedPacker)
      end
    end
  end
end)
local impoundLoaderWindow = false
addEvent("impoundLoader", true)
addEventHandler("impoundLoader", getRootElement(), function(isDelete)
  if impoundLoaderWindow then
    sightexports.sGui:deleteGuiElement(impoundLoaderWindow)
  end
  impoundLoaderWindow = nil
  if isDelete then
    return
  end
  local titleBarHeight = sightexports.sGui:getTitleBarHeight()
  local ph = 120
  local pw = 250
  impoundLoaderWindow = sightexports.sGui:createGuiElement("window", screenX / 2 - pw / 2, screenY / 2 - ph / 2, pw, ph)
  sightexports.sGui:setWindowTitle(impoundLoaderWindow, "16/BebasNeueRegular.otf", "Lefoglalt járművek betöltése...")
  local loadingIcon = sightexports.sGui:createGuiElement("image", pw / 2 - 24, titleBarHeight + (ph - titleBarHeight) / 2 - 24, 48, 48, impoundLoaderWindow)
  sightexports.sGui:setImageFile(loadingIcon, sightexports.sGui:getFaIconFilename("circle-notch", 48))
  sightexports.sGui:setImageSpinner(loadingIcon, true)
end)
local impoundList = {}
local impoundScroll = 0
local impoundScrollBar = false
local impoundElements = {}
local currentPoliceList = {}
local cachedImpoundList = {}
local impoundWindow = false
local impoundSearch = false
local maxElements = 10
local unimpoundType = 1
function processImpoundList()
  for i = 1, #impoundElements do
    local dat = impoundList[i + impoundScroll]
    if dat then
      if dat.customModel then
        dat.model = dat.customModel
      end
      sightexports.sGui:setLabelText(impoundElements[i][1], sightexports.sVehiclenames:getCustomVehicleName(dat.model))
      local plate = split(dat.plate, "-")
      plate = table.concat(plate, "-")
      if dat.isFaction then
        sightexports.sGui:setLabelText(impoundElements[i][2], "ID: " .. dat.vehicleId .. " / " .. plate .. " [color=sightblue](Frakció)")
        sightexports.sGui:setGuiHoverable(impoundElements[i][2], true)
        sightexports.sGui:guiSetTooltip(impoundElements[i][2], "Tulajdonos: " .. sightexports.sGroups:getGroupName(dat.owner), false, "up")
      else
        sightexports.sGui:setLabelText(impoundElements[i][2], "ID: " .. dat.vehicleId .. " / " .. plate)
      end
      if unimpoundType ~= 3 then
        price = sightexports.sGui:thousandsStepper(calculateUnimpound(dat.model) or 0) or 0
        sightexports.sGui:guiSetTooltip(impoundElements[i][3], "A kiváltás ára: " .. price .. "$")
        sightexports.sGui:setButtonText(impoundElements[i][3], "Kiváltás (" .. price .. " $)")
      end
    end
  end
  local n = #impoundList - #impoundElements
  local sh = (48 * maxElements - 8) / math.max(1, n + 1)
  sightexports.sGui:setGuiSize(impoundScrollBar, false, sh)
  sightexports.sGui:setGuiPosition(impoundScrollBar, false, sh * impoundScroll)
end
function processImpoundListPolice(list)
  for i = 1, #impoundElements do
    local dat = currentPoliceList[i + impoundScroll]
    if dat then
      sightexports.sGui:setLabelText(impoundElements[i][1], sightexports.sVehiclenames:getCustomVehicleName(dat.model))
      local plate = split(dat.plate, "-")
      plate = table.concat(plate, "-")
      if dat.isFaction then
        sightexports.sGui:setLabelText(impoundElements[i][2], "ID: " .. dat.vehicleId .. " / " .. plate .. " [color=sightblue](Frakció)")
        sightexports.sGui:setGuiHoverable(impoundElements[i][2], true)
        sightexports.sGui:guiSetTooltip(impoundElements[i][2], "Tulajdonos: " .. sightexports.sGroups:getGroupName(dat.owner), false, "up")
      else
        sightexports.sGui:setGuiHoverable(impoundElements[i][2], false)
        sightexports.sGui:setLabelText(impoundElements[i][2], "ID: " .. dat.vehicleId .. " / " .. plate)
      end
      sightexports.sGui:setButtonText(impoundElements[i][3], "Kiváltás")
    end
  end
  local n = #currentPoliceList - #impoundElements
  local sh = (48 * maxElements - 8) / math.max(1, n + 1)
  sightexports.sGui:setGuiSize(impoundScrollBar, false, sh)
  sightexports.sGui:setGuiPosition(impoundScrollBar, false, sh * impoundScroll)
end
function impoundWindowKey(key)
  if key == "mouse_wheel_up" then
    if 0 < impoundScroll then
      impoundScroll = impoundScroll - 1
      processImpoundList()
    end
  elseif key == "mouse_wheel_down" then
    local n = #impoundList - #impoundElements
    if n > impoundScroll then
      impoundScroll = impoundScroll + 1
      processImpoundList()
    end
  end
end
function impoundWindowKeyPolice(key)
  if key == "mouse_wheel_up" then
    if 0 < impoundScroll then
      impoundScroll = impoundScroll - 1
      processImpoundListPolice()
    end
  elseif key == "mouse_wheel_down" then
    local n = #currentPoliceList - #impoundElements
    if n > impoundScroll then
      impoundScroll = impoundScroll + 1
      processImpoundListPolice()
    end
  end
end
function deleteImpoundWindow()
  if impoundLoaderWindow then
    sightexports.sGui:deleteGuiElement(impoundLoaderWindow)
  end
  impoundLoaderWindow = nil
  if impoundWindow then
    sightexports.sGui:deleteGuiElement(impoundWindow)
  end
  impoundWindow = false
  impoundScrollBar = false
  impoundElements = {}
  impoundSearch = false
  sightlangCondHandl2(false)
  sightlangCondHandl3(false)
end
addEvent("closeVehicleImpoundWindow", false)
addEventHandler("closeVehicleImpoundWindow", getRootElement(), deleteImpoundWindow)
addEvent("unImpoundVehicle", false)
addEventHandler("unImpoundVehicle", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  for i = 1, #impoundElements do
    if impoundElements[i][3] == el then
      local dat = impoundList[i + impoundScroll]
      if dat then
        triggerServerEvent("tryToUnimpoundVehicle", localPlayer, dat.vehicleId, dat.model)
        deleteImpoundWindow()
      end
      return
    end
  end
end)
addEvent("unImpoundVehiclePolice", false)
addEvent("gotImpoundedVehicleList", true)
addEventHandler("gotImpoundedVehicleList", getRootElement(), function(res, ped, target)
  if impoundLoaderWindow then
    sightexports.sGui:deleteGuiElement(impoundLoaderWindow)
  end
  impoundLoaderWindow = nil
  unimpoundType = 1
  impoundList = res
  impoundScroll = 0
  deleteImpoundWindow()
  local titleBarHeight = sightexports.sGui:getTitleBarHeight()
  local n = 10
  local pw = 450
  local ph = titleBarHeight + 48 * n
  impoundWindow = sightexports.sGui:createGuiElement("window", screenX / 2 - pw / 2, screenY / 2 - ph / 2, pw, ph)
  sightexports.sGui:setWindowTitle(impoundWindow, "16/BebasNeueRegular.otf", "Lefoglalt járművek"..(target and " ["..target.."]" or ""))
  sightexports.sGui:setWindowCloseButton(impoundWindow, "closeVehicleImpoundWindow")
  sightexports.sGui:setWindowElementMaxDistance(impoundWindow, ped, 10)
  local rect = sightexports.sGui:createGuiElement("rectangle", pw - 4 - 2, titleBarHeight + 4, 2, 48 * n - 8, impoundWindow)
  sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey1")
  impoundScrollBar = sightexports.sGui:createGuiElement("rectangle", 0, 0, 2, 48 * n - 8, rect)
  sightexports.sGui:setGuiBackground(impoundScrollBar, "solid", "sightmidgrey")
  local y = titleBarHeight
  n = math.min(n, #impoundList)
  for i = 1, n do
    impoundElements[i] = {}
    local label = sightexports.sGui:createGuiElement("label", 8, y, 0, 24, impoundWindow)
    sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    impoundElements[i][1] = label
    local label = sightexports.sGui:createGuiElement("label", 8, y + 24, pw, 24, impoundWindow)
    sightexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    sightexports.sGui:setLabelColor(label, "sightlightgrey")
    impoundElements[i][2] = label
    local btn = sightexports.sGui:createGuiElement("button", pw - 4 - 2 - 8 - 150, y + 24 - 12, 150, 24, impoundWindow)
    sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
    sightexports.sGui:setGuiHover(btn, "gradient", {
      "sightgreen",
      "sightgreen-second"
    }, false, true)
    sightexports.sGui:setButtonFont(btn, "13/BebasNeueBold.otf")
    sightexports.sGui:setButtonTextColor(btn, "#ffffff")
    sightexports.sGui:setButtonText(btn, "betöltés...\t")
    sightexports.sGui:setClickEvent(btn, "unImpoundVehicle")
    sightexports.sGui:guiSetTooltip(btn, "A kiváltás ára betöltés alatt...")
    impoundElements[i][3] = btn
    y = y + 48
    if i < n then
      local border = sightexports.sGui:createGuiElement("hr", 8, y - 1, pw - 4 - 2 - 4 - 8, 2, impoundWindow)
    end
  end
  maxElements = 10
  processImpoundList()
  sightlangCondHandl2(true)
end)
addEventHandler("unImpoundVehiclePolice", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  for i = 1, #impoundElements do
    if impoundElements[i][3] == el then
      local dat = currentPoliceList[i + impoundScroll]
      if dat then
        triggerServerEvent("tryToUnimpoundVehicle", localPlayer, dat.vehicleId)
        deleteImpoundWindow()
      end
      return
    end
  end
end)
function createPoliceGuiElements()
  for i = 1, #impoundElements do
    if impoundElements[i][1] then
      sightexports.sGui:deleteGuiElement(impoundElements[i][1])
    end
    impoundElements[i][1] = nil
    if impoundElements[i][2] then
      sightexports.sGui:deleteGuiElement(impoundElements[i][2])
    end
    impoundElements[i][2] = nil
    if impoundElements[i][3] then
      sightexports.sGui:deleteGuiElement(impoundElements[i][3])
    end
    impoundElements[i][3] = nil
  end
  local n = 9
  local titleBarHeight = sightexports.sGui:getTitleBarHeight()
  local pw = 450
  local ph = titleBarHeight + 48 + 48 * n
  local n = 9
  local y = titleBarHeight + 48
  for i = 1, n do
    if i < n then
      local border = sightexports.sGui:createGuiElement("hr", 8, y + 48 * i - 1, pw - 4 - 2 - 4 - 8, 2, impoundWindow)
    end
  end
  n = math.min(n, #currentPoliceList)
  for i = 1, n do
    impoundElements[i] = {}
    local label = sightexports.sGui:createGuiElement("label", 8, y, 0, 24, impoundWindow)
    sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    impoundElements[i][1] = label
    local label = sightexports.sGui:createGuiElement("label", 8, y + 24, pw - 150 - 4 - 2 - 16, 24, impoundWindow)
    sightexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    sightexports.sGui:setLabelColor(label, "sightlightgrey")
    impoundElements[i][2] = label
    local btn = sightexports.sGui:createGuiElement("button", pw - 4 - 2 - 8 - 150, y + 24 - 12, 150, 24, impoundWindow)
    sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
    sightexports.sGui:setGuiHover(btn, "gradient", {
      "sightgreen",
      "sightgreen-second"
    }, false, true)
    sightexports.sGui:setButtonFont(btn, "13/BebasNeueBold.otf")
    sightexports.sGui:setButtonTextColor(btn, "#ffffff")
    sightexports.sGui:setButtonText(btn, "betöltés...\t")
    sightexports.sGui:setClickEvent(btn, "unImpoundVehiclePolice")
    impoundElements[i][3] = btn
    y = y + 48
  end
end
addEvent("searchImpoundList", true)
addEventHandler("searchImpoundList", getRootElement(), function(value)
  cachedImpoundList = {}
  local value = value and utf8.lower(value)
  if impoundSearch ~= value then
    impoundSearch = value
    if impoundSearch and utf8.len(impoundSearch) > 0 then
      impoundScroll = 0
      for i = 1, #impoundList do
        if utf8.find(utf8.lower(utf8.gsub(impoundList[i].plate, "-", "")), utf8.lower(utf8.gsub(impoundSearch, "-", "")), nil, true) then
          table.insert(cachedImpoundList, impoundList[i])
        elseif tonumber(impoundSearch) then
          if tonumber(impoundList[i].vehicleId) == tonumber(impoundSearch) then
            table.insert(cachedImpoundList, impoundList[i])
          elseif utf8.find(tostring(impoundList[i].vehicleId), utf8.lower(utf8.gsub(impoundSearch, "-", ""))) then
            table.insert(cachedImpoundList, impoundList[i])
          end
        end
      end
      currentPoliceList = cachedImpoundList
      createPoliceGuiElements()
      processImpoundListPolice()
    else
      currentPoliceList = impoundList
      createPoliceGuiElements()
      processImpoundListPolice()
    end
  else
    currentPoliceList = impoundList
    createPoliceGuiElements()
    processImpoundListPolice()
  end
end)
addEvent("gotImpoundedVehicleListPolice", true)
addEventHandler("gotImpoundedVehicleListPolice", getRootElement(), function(res, ped)
  if impoundLoaderWindow then
    sightexports.sGui:deleteGuiElement(impoundLoaderWindow)
  end
  impoundLoaderWindow = nil
  unimpoundType = 2
  impoundList = res
  currentPoliceList = impoundList
  impoundScroll = 0
  deleteImpoundWindow()
  local titleBarHeight = sightexports.sGui:getTitleBarHeight()
  local n = 9
  local pw = 450
  local ph = titleBarHeight + 48 + 48 * n
  impoundWindow = sightexports.sGui:createGuiElement("window", screenX / 2 - pw / 2, screenY / 2 - ph / 2, pw, ph)
  sightexports.sGui:setWindowTitle(impoundWindow, "16/BebasNeueRegular.otf", "Lefoglalt járművek")
  sightexports.sGui:setWindowCloseButton(impoundWindow, "closeVehicleImpoundWindow")
  sightexports.sGui:setWindowElementMaxDistance(impoundWindow, ped, 10)
  local y = titleBarHeight
  local searchInput = sightexports.sGui:createGuiElement("input", 8, y + 8, pw - 16, 32, impoundWindow)
  sightexports.sGui:setInputPlaceholder(searchInput, "Keresés (FRSZ, ID)")
  sightexports.sGui:setInputIcon(searchInput, "search")
  sightexports.sGui:setInputChangeEvent(searchInput, "searchImpoundList")
  sightexports.sGui:setInputValue(searchInput, rulesSearch or "")
  y = y + 48
  n = math.min(9, #currentPoliceList)
  local rect = sightexports.sGui:createGuiElement("rectangle", pw - 4 - 2, titleBarHeight + 48 + 4, 2, 48 * n - 8, impoundWindow)
  sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey1")
  impoundScrollBar = sightexports.sGui:createGuiElement("rectangle", 0, 0, 2, 48 * n - 8, rect)
  sightexports.sGui:setGuiBackground(impoundScrollBar, "solid", "sightmidgrey")
  createPoliceGuiElements()
  maxElements = 9
  processImpoundListPolice()
  sightlangCondHandl3(true)
end)
addEvent("gotImpoundedVehicleList3", true)
addEventHandler("gotImpoundedVehicleList3", getRootElement(), function(res, ped)
  if impoundLoaderWindow then
    sightexports.sGui:deleteGuiElement(impoundLoaderWindow)
  end
  impoundLoaderWindow = nil
  unimpoundType = 3
  impoundList = res
  impoundScroll = 0
  deleteImpoundWindow()
  local titleBarHeight = sightexports.sGui:getTitleBarHeight()
  local n = 10
  local pw = 450
  local ph = titleBarHeight + 48 * n
  impoundWindow = sightexports.sGui:createGuiElement("window", screenX / 2 - pw / 2, screenY / 2 - ph / 2, pw, ph)
  sightexports.sGui:setWindowTitle(impoundWindow, "16/BebasNeueRegular.otf", "Lefoglalt járművek")
  sightexports.sGui:setWindowCloseButton(impoundWindow, "closeVehicleImpoundWindow")
  sightexports.sGui:setWindowElementMaxDistance(impoundWindow, ped, 10)
  local rect = sightexports.sGui:createGuiElement("rectangle", pw - 4 - 2, titleBarHeight + 4, 2, 48 * n - 8, impoundWindow)
  sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey1")
  impoundScrollBar = sightexports.sGui:createGuiElement("rectangle", 0, 0, 2, 48 * n - 8, rect)
  sightexports.sGui:setGuiBackground(impoundScrollBar, "solid", "sightmidgrey")
  local y = titleBarHeight
  n = math.min(n, #impoundList)
  for i = 1, n do
    impoundElements[i] = {}
    local label = sightexports.sGui:createGuiElement("label", 8, y, 0, 24, impoundWindow)
    sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    impoundElements[i][1] = label
    local label = sightexports.sGui:createGuiElement("label", 8, y + 24, pw, 24, impoundWindow)
    sightexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    sightexports.sGui:setLabelColor(label, "sightlightgrey")
    impoundElements[i][2] = label
    local btn = sightexports.sGui:createGuiElement("button", pw - 4 - 2 - 8 - 150, y + 24 - 12, 150, 24, impoundWindow)
    sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
    sightexports.sGui:setGuiHover(btn, "gradient", {
      "sightgreen",
      "sightgreen-second"
    }, false, true)
    sightexports.sGui:setButtonFont(btn, "13/BebasNeueBold.otf")
    sightexports.sGui:setButtonTextColor(btn, "#ffffff")
    sightexports.sGui:setButtonText(btn, "Kiváltás")
    sightexports.sGui:setClickEvent(btn, "unImpoundVehicle")
    sightexports.sGui:guiSetTooltip(btn, "A kiváltás ingyenes.")
    impoundElements[i][3] = btn
    y = y + 48
    if i < n then
      local border = sightexports.sGui:createGuiElement("hr", 8, y - 1, pw - 4 - 2 - 4 - 8, 2, impoundWindow)
    end
  end
  maxElements = 10
  processImpoundList()
  sightlangCondHandl2(true)
end)
local convertNotification = false
addEvent("closeConvertNotification", false)
addEventHandler("closeConvertNotification", getRootElement(), function()
  if convertNotification then
    sightexports.sGui:deleteGuiElement(convertNotification)
  end
  convertNotification = nil
end)
addEvent("convertNotification", true)
addEventHandler("convertNotification", getRootElement(), function()
  local titleBarHeight = sightexports.sGui:getTitleBarHeight()
  local pw = 400
  local ph = titleBarHeight + 140
  convertNotification = sightexports.sGui:createGuiElement("window", screenX / 2 - pw / 2, screenY / 2 - ph / 2, pw, ph)
  sightexports.sGui:setWindowColors(convertNotification, "sightgrey2", "sightgrey1", "sightgrey3", "#ffffff")
  sightexports.sGui:setWindowTitle(convertNotification, "16/BebasNeueRegular.otf", "Jármű konvertálás")
  local label = sightexports.sGui:createGuiElement("label", 8, titleBarHeight, pw - 16, ph - 8 - 32 - 8 - titleBarHeight, convertNotification)
  sightexports.sGui:setLabelAlignment(label, "center", "center")
  local append = ""
  sightexports.sGui:setLabelText(label, "A SightMTA " .. append .. " szerveréről áthozott járműveid megtalálod a reptér parkolójában (F11 - Narancssárga jármű ikon). Az ingyenes kiváltáshoz kattints az NPC-re.")
  sightexports.sGui:setLabelWordBreak(label, true)
  sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
  local w = pw - 16
  local btn = sightexports.sGui:createGuiElement("button", 8, ph - 8 - 32, w, 32, convertNotification)
  sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
  sightexports.sGui:setGuiHover(btn, "gradient", {
    "sightgreen",
    "sightgreen-second"
  }, false, true)
  sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
  sightexports.sGui:setButtonText(btn, "Rendben")
  sightexports.sGui:setClickEvent(btn, "closeConvertNotification")
end)
