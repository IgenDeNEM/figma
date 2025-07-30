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
local screenX, screenY = guiGetScreenSize()
local vehDoorWindowWidth = 200
local vehDoorWindowHeight = 0
local vehWindowWindowWidth = 200
local vehWindowWindowHeight = 0
local padding = 5
local doorRowHeight = 24
local y = 0
local y2 = 0
local doorPanelState = false
local windowPanelSate = false
local buttonActions = {}
local doorBtns = {}
local windowBtns = {}
local vehicleDoors = {
  [0] = {
    "Motorháztető",
    "bonnet_dummy"
  },
  [1] = {
    "Csomagtartó",
    "boot_dummy"
  },
  [2] = {
    "Bal első ajtó",
    "door_lf_dummy",
    "Bal első (sofőr) ablak",
    4
  },
  [3] = {
    "Jobb első ajtó",
    "door_rf_dummy",
    "Jobb első ablak",
    2
  },
  [4] = {
    "Bal hátsó ajtó",
    "door_lr_dummy",
    "Bal hátsó ablak",
    5
  },
  [5] = {
    "Jobb hátsó ajtó",
    "door_rr_dummy",
    "Jobb hátsó ablak",
    3
  }
}
local windowNames = {
  "Jobb első ablak",
  "Jobb hátsó ablak",
  "Bal első ablak",
  "Bal hátsó ablak"
}
local noWindowVehicles = {
  [424] = true,
  [457] = true,
  [486] = true,
  [500] = true,
  [504] = true,
  [530] = true,
  [531] = true,
  [539] = true,
  [568] = true,
  [571] = true,
  [572] = true
}
local seatWindows = {
  [0] = 4,
  [1] = 2,
  [2] = 5,
  [3] = 3
}
local lastWindowSet = {
  0,
  0,
  0,
  0,
  0
}
local lastOpenDoor = {}
function showVehDoorPanel(state)
  if state then
    local titleBarHeight = sightexports.sGui:getTitleBarHeight()
    local veh = getPedOccupiedVehicle(localPlayer)
    for i = 0, #vehicleDoors do
      if getVehicleDoorState(veh, i) ~= 4 and getVehicleComponentPosition(veh, vehicleDoors[i][2]) ~= false then
        vehDoorWindowHeight = vehDoorWindowHeight + doorRowHeight + padding
      end
    end
    local windowHeight = titleBarHeight + vehDoorWindowHeight + padding
    cvehWindow = sightexports.sGui:createGuiElement("window", screenX / 2 - vehDoorWindowWidth / 2, screenY / 2 - windowHeight / 2, vehDoorWindowWidth, windowHeight)
    sightexports.sGui:setWindowTitle(cvehWindow, "16/BebasNeueRegular.otf", "Járműkezelés (Ajtó)")
    sightexports.sGui:setWindowCloseButton(cvehWindow, "closeVehDoorPanel")
    for i = 0, #vehicleDoors do
      if getVehicleDoorState(veh, i) ~= 4 and getVehicleComponentPosition(veh, vehicleDoors[i][2]) ~= false then
        y = y + doorRowHeight + padding
        local doorName = sightexports.sGui:createGuiElement("label", 5, titleBarHeight - doorRowHeight + y, vehDoorWindowWidth / 2.5, doorRowHeight, cvehWindow)
        sightexports.sGui:setLabelText(doorName, vehicleDoors[i][1])
        sightexports.sGui:setLabelAlignment(doorName, "left", "center")
        doorBtns[i] = sightexports.sGui:createGuiElement("button", vehDoorWindowWidth - padding - 24, titleBarHeight - doorRowHeight + y, doorRowHeight, doorRowHeight, cvehWindow)
        sightexports.sGui:setGuiBackground(doorBtns[i], "solid", "sightgreen")
        sightexports.sGui:setGuiHover(doorBtns[i], "gradient", {
          "sightgreen",
          "sightgreen-second"
        }, false, true)
        sightexports.sGui:setButtonIcon(doorBtns[i], sightexports.sGui:getFaIconFilename("lock", 24, "solid"))
        sightexports.sGui:guiSetTooltip(doorBtns[i], "Kinyitás")
        sightexports.sGui:setButtonFont(doorBtns[i], "12/BebasNeueBold.otf")
        sightexports.sGui:setClickEvent(doorBtns[i], "toggleDoorState", false)
        buttonActions[doorBtns[i]] = i
      end
    end
    addEventHandler("onClientRender", getRootElement(), refreshDoorStates)
  else
    doorPanelState = false
    sightexports.sGui:deleteGuiElement(cvehWindow)
    removeEventHandler("onClientRender", getRootElement(), refreshDoorStates)
    y = 0
    vehDoorWindowHeight = 0
  end
end
function showVehWindowPanel(state)
  if state then
    local titleBarHeight = sightexports.sGui:getTitleBarHeight()
    local veh = getPedOccupiedVehicle(localPlayer)
    for i = 1, #vehicleDoors do
      if getVehicleDoorState(veh, i) ~= 4 and getVehicleComponentPosition(veh, vehicleDoors[i][2]) ~= false and vehicleDoors[i][3] then
        vehWindowWindowHeight = vehWindowWindowHeight + doorRowHeight + padding
      end
    end
    local windowHeight = titleBarHeight + vehWindowWindowHeight + padding
    vehWindowsWindow = sightexports.sGui:createGuiElement("window", screenX / 2 - vehWindowWindowWidth / 2, screenY / 2 - windowHeight / 2, vehWindowWindowWidth, windowHeight)
    sightexports.sGui:setWindowTitle(vehWindowsWindow, "16/BebasNeueRegular.otf", "Járműkezelés (Ablak)")
    sightexports.sGui:setWindowCloseButton(vehWindowsWindow, "closeVehWindowPanel")
    for i = 1, #vehicleDoors do
      if getVehicleDoorState(veh, i) ~= 4 and getVehicleComponentPosition(veh, vehicleDoors[i][2]) ~= false and vehicleDoors[i][3] then
        y2 = y2 + doorRowHeight + padding
        local doorName = sightexports.sGui:createGuiElement("label", 5, titleBarHeight - doorRowHeight + y2, vehWindowWindowWidth / 2.5, doorRowHeight, vehWindowsWindow)
        sightexports.sGui:setLabelText(doorName, vehicleDoors[i][3])
        sightexports.sGui:setLabelAlignment(doorName, "left", "center")
        windowBtns[i] = sightexports.sGui:createGuiElement("button", vehWindowWindowWidth - padding - 24, titleBarHeight - doorRowHeight + y2, doorRowHeight, doorRowHeight, vehWindowsWindow)
        sightexports.sGui:setGuiBackground(windowBtns[i], "solid", "sightgreen")
        sightexports.sGui:setGuiHover(windowBtns[i], "gradient", {
          "sightgreen",
          "sightgreen-second"
        }, false, true)
        sightexports.sGui:setButtonIcon(windowBtns[i], sightexports.sGui:getFaIconFilename("chevron-down", 24, "solid"))
        sightexports.sGui:guiSetTooltip(windowBtns[i], "Kinyitás")
        sightexports.sGui:setButtonFont(windowBtns[i], "12/BebasNeueBold.otf")
        sightexports.sGui:setClickEvent(windowBtns[i], "toggleWindowState", false)
        buttonActions[windowBtns[i]] = vehicleDoors[i][4]
      end
    end
    addEventHandler("onClientRender", getRootElement(), refreshWindowStates)
  else
    windowPanelSate = false
    sightexports.sGui:deleteGuiElement(vehWindowsWindow)
    removeEventHandler("onClientRender", getRootElement(), refreshWindowStates)
    y2 = 0
    vehWindowWindowHeight = 0
  end
end
function toggleVehDoorPanel()
  local veh = getPedOccupiedVehicle(localPlayer)
  if veh and (getVehicleType(veh) == "Automobile" or getVehicleType(veh) == "Helicopter" or getVehicleType(veh) == "Monster Truck") then
    if getPedOccupiedVehicleSeat(localPlayer) == 0 then
      if doorPanelState == false then
        doorPanelState = true
        showVehDoorPanel(true)
      else
        doorPanelState = false
        showVehDoorPanel(false)
      end
    else
      local val = tonumber(getPedOccupiedVehicleSeat(localPlayer))
      local val = val + 2
      local players = getElementsByType("player", getRootElement(), true)
      local soundPlayers = {}
      local vehiclePlayers = {}
      for k = 1, #players do
        if players[k] then
          if getPedOccupiedVehicle(players[k]) == veh then
            table.insert(vehiclePlayers, players[k])
          else
            table.insert(soundPlayers, players[k])
          end
        end
      end
      if getTickCount() - (lastOpenDoor[val] or 0) >= 750 then
        triggerServerEvent("openTheDoor", veh, val, vehiclePlayers, soundPlayers, getVehicleDoorOpenRatio(veh, val))
        local name = utf8.lower(vehicleDoors[val][1])
        if 0 < getVehicleDoorOpenRatio(veh, val) then
          sightexports.sChat:localActionC(localPlayer, "becsukja a " .. name .. "t.")
        else
          sightexports.sChat:localActionC(localPlayer, "kinyitja a " .. name .. "t.")
        end
        lastOpenDoor[val] = getTickCount()
      end
    end
  end
end
addCommandHandler("cveh", toggleVehDoorPanel)
function toggleVehWindowPanel()
  local veh = getPedOccupiedVehicle(localPlayer)
  if veh and (getVehicleType(veh) == "Automobile" or getVehicleType(veh) == "Monster Truck" and not noWindowVehicles[getElementModel(veh)]) then
    if getPedOccupiedVehicleSeat(localPlayer) == 0 then
      if windowPanelSate == false then
        windowPanelSate = true
        showVehWindowPanel(true)
      else
        windowPanelSate = false
        showVehWindowPanel(false)
      end
    else
      local val = tonumber(seatWindows[getPedOccupiedVehicleSeat(localPlayer)]) or 2
      if getTickCount() - lastWindowSet[val] > 4000 then
        local veh = getPedOccupiedVehicle(localPlayer)
        if val and veh then
          lastWindowSet[val] = getTickCount()
          setElementData(veh, "vehicle.window." .. val, not getElementData(veh, "vehicle.window." .. val))
          if getElementData(veh, "vehicle.window." .. val) then
            sightexports.sChat:localActionC(localPlayer, "lehúzza a " .. string.lower(windowNames[val - 1]) .. "ot.")
          else
            sightexports.sChat:localActionC(localPlayer, "felhúzza a " .. string.lower(windowNames[val - 1]) .. "ot.")
          end
          local opened = false
          for k = 2, 5 do
            local state = getElementData(veh, "vehicle.window." .. k)
            if state then
              opened = true
              break
            end
          end
          setElementData(veh, "vehicle.windowState", opened)
          local playersTable = {}
          local sourceX, sourceY, sourceZ = getElementPosition(localPlayer)
          for k, v in ipairs(getElementsByType("player", getRootElement(), true)) do
            if v ~= localPlayer then
              if getPedOccupiedVehicle(v) == veh then
                table.insert(playersTable, {v, "2d"})
              else
                local targetX, targetY, targetZ = getElementPosition(v)
                if getDistanceBetweenPoints3D(sourceX, sourceY, sourceZ, targetX, targetY, targetZ) <= 10 then
                  table.insert(playersTable, {v, "3d"})
                end
              end
            end
          end
          if 0 < #playersTable then
            triggerServerEvent("playWindowSound", veh, playersTable)
          end
          playSound(":sChat/files/window.mp3")
        end
      end
    end
  end
end
bindKey("F4", "down", toggleVehWindowPanel)
addCommandHandler("ablak", toggleVehWindowPanel)
addEvent("toggleDoorState", true)
addEventHandler("toggleDoorState", getRootElement(), function(button, state, absX, absY, el)
  local veh = getPedOccupiedVehicle(localPlayer)
  if veh then
    local val = buttonActions[el]
    local players = getElementsByType("player", getRootElement(), true)
    local soundPlayers = {}
    local vehiclePlayers = {}
    for k = 1, #players do
      if players[k] then
        if getPedOccupiedVehicle(players[k]) == veh then
          table.insert(vehiclePlayers, players[k])
        else
          table.insert(soundPlayers, players[k])
        end
      end
    end
    if getTickCount() - (lastOpenDoor[val] or 0) >= 750 then
      triggerServerEvent("openTheDoor", veh, val, vehiclePlayers, soundPlayers, getVehicleDoorOpenRatio(veh, val))
      local name = utf8.lower(vehicleDoors[val][1])
      if val == 0 or val == 1 then
        closeActionName = "lecsukja"
        openActionName = "felnyitja"
      else
        closeActionName = "becsukja"
        openActionName = "kinyitja"
      end
      if 0 < getVehicleDoorOpenRatio(veh, val) then
        sightexports.sChat:localActionC(localPlayer, closeActionName .. " a " .. name .. "t.")
      else
        sightexports.sChat:localActionC(localPlayer, openActionName .. " a " .. name .. "t.")
      end
      lastOpenDoor[val] = getTickCount()
    end
  end
end)
addEvent("toggleWindowState", true)
addEventHandler("toggleWindowState", getRootElement(), function(button, state, absX, absY, el)
  local veh = getPedOccupiedVehicle(localPlayer)
  if veh then
    local val = buttonActions[el]
    if getTickCount() - lastWindowSet[val] > 4000 then
      local veh = getPedOccupiedVehicle(localPlayer)
      if val and veh then
        lastWindowSet[val] = getTickCount()
        setElementData(veh, "vehicle.window." .. val, not getElementData(veh, "vehicle.window." .. val))
        if getElementData(veh, "vehicle.window." .. val) then
          sightexports.sChat:localActionC(localPlayer, "lehúzza a " .. string.lower(windowNames[val - 1]) .. "ot.")
        else
          sightexports.sChat:localActionC(localPlayer, "felhúzza a " .. string.lower(windowNames[val - 1]) .. "ot.")
        end
        local opened = false
        for k = 2, 5 do
          local state = getElementData(veh, "vehicle.window." .. k)
          if state then
            opened = true
            break
          end
        end
        setElementData(veh, "vehicle.windowState", opened)
        local playersTable = {}
        local sourceX, sourceY, sourceZ = getElementPosition(localPlayer)
        for k, v in ipairs(getElementsByType("player", getRootElement(), true)) do
          if v ~= localPlayer then
            if getPedOccupiedVehicle(v) == veh then
              table.insert(playersTable, {v, "2d"})
            else
              local targetX, targetY, targetZ = getElementPosition(v)
              if getDistanceBetweenPoints3D(sourceX, sourceY, sourceZ, targetX, targetY, targetZ) <= 10 then
                table.insert(playersTable, {v, "3d"})
              end
            end
          end
        end
        if 0 < #playersTable then
          triggerServerEvent("playWindowSound", veh, playersTable)
        end
        playSound(":sChat/files/window.mp3")
      end
    end
  end
end)
addEvent("playTheDoorSound", true)
addEventHandler("playTheDoorSound", getRootElement(), function(veh, state, twoDee)
  if 0 < state then
    if twoDee and not isElement(veh) then
      playSound("files/doorclose.mp3")
    else
      local x, y, z = getElementPosition(veh)
      local s = playSound3D("files/doorclose.mp3", x, y, z)
      attachElements(s, veh)
    end
  elseif twoDee and not isElement(veh) then
    playSound("files/dooropen.mp3")
  else
    local x, y, z = getElementPosition(veh)
    local s = playSound3D("files/dooropen.mp3", x, y, z)
    attachElements(s, veh)
  end
end)
addEvent("closeVehDoorPanel", true)
addEventHandler("closeVehDoorPanel", getRootElement(), function()
  showVehDoorPanel(false)
  doorPanelState = false
end)
addEvent("closeVehWindowPanel", true)
addEventHandler("closeVehWindowPanel", getRootElement(), function()
  showVehWindowPanel(false)
  windowPanelSate = false
end)
function refreshDoorStates()
  local veh = getPedOccupiedVehicle(localPlayer)
  if veh then
    for i = 0, #vehicleDoors do
      if getVehicleDoorState(veh, i) ~= 4 and getVehicleComponentPosition(veh, vehicleDoors[i][2]) ~= false then
        if getVehicleDoorOpenRatio(veh, i) == 0 then
          sightexports.sGui:setGuiBackground(doorBtns[i], "solid", "sightgreen")
          sightexports.sGui:setGuiHover(doorBtns[i], "gradient", {
            "sightgreen",
            "sightgreen-second"
          }, false, true)
          sightexports.sGui:setButtonIcon(doorBtns[i], sightexports.sGui:getFaIconFilename("lock", 24, "solid"))
          sightexports.sGui:guiSetTooltip(doorBtns[i], "Kinyitás")
        else
          sightexports.sGui:setGuiBackground(doorBtns[i], "solid", "sightred")
          sightexports.sGui:setGuiHover(doorBtns[i], "gradient", {
            "sightred",
            "sightred-second"
          }, false, true)
          sightexports.sGui:setButtonIcon(doorBtns[i], sightexports.sGui:getFaIconFilename("lock-open", 24, "solid"))
          sightexports.sGui:guiSetTooltip(doorBtns[i], "Bezárás")
        end
      end
    end
  end
end
function refreshWindowStates()
  local veh = getPedOccupiedVehicle(localPlayer)
  if veh then
    for i = 0, #vehicleDoors do
      if getVehicleDoorState(veh, i) ~= 4 and getVehicleComponentPosition(veh, vehicleDoors[i][2]) ~= false and vehicleDoors[i][3] then
        if isVehicleWindowOpen(veh, vehicleDoors[i][4]) then
          sightexports.sGui:setGuiBackground(windowBtns[i], "solid", "sightred")
          sightexports.sGui:setGuiHover(windowBtns[i], "gradient", {
            "sightred",
            "sightred-second"
          }, false, true)
          sightexports.sGui:setButtonIcon(windowBtns[i], sightexports.sGui:getFaIconFilename("chevron-up", 24, "solid"))
          sightexports.sGui:guiSetTooltip(windowBtns[i], "Felhúzás")
        else
          sightexports.sGui:setGuiBackground(windowBtns[i], "solid", "sightgreen")
          sightexports.sGui:setGuiHover(windowBtns[i], "gradient", {
            "sightgreen",
            "sightgreen-second"
          }, false, true)
          sightexports.sGui:setButtonIcon(windowBtns[i], sightexports.sGui:getFaIconFilename("chevron-down", 24, "solid"))
          sightexports.sGui:guiSetTooltip(windowBtns[i], "Lehúzás")
        end
      end
    end
  end
end
addEventHandler("onClientVehicleExit", getRootElement(), function(player)
  if player == localPlayer then
    if doorPanelState then
      showVehDoorPanel(false)
    end
    if windowPanelSate then
      showVehWindowPanel(false)
    end
  end
end)
