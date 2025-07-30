local sightexports = {
  sGui = false,
  sInteriors = false,
  sGates = false,
  sVehiclenames = false,
  sGroups = false,
  sItems = false
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
local rtg = false
local sx, sy = 0, 0
local inside = false
local menuW = 0
groupModal = false
local groupFonts = {
  "13/BebasNeueBold.otf",
  "16/BebasNeueRegular.otf",
  "22/BebasNeueRegular.otf",
  "14/BebasNeueBold.otf",
  "14/BebasNeueRegular.otf",
  "11/Ubuntu-R.ttf"
}
local groupLoader = false
local groupLoaderIcon = false
addEvent("markGroupVehicle", true)
addEventHandler("markGroupVehicle", getRootElement(), function(button, state, absoluteX, absoluteY, el, id)
  triggerServerEvent("markVehicleOnGPS", localPlayer, id)
end)
function deleteGroupLoader()
  if groupLoader then
    sightexports.sGui:deleteGuiElement(groupLoader)
  end
  groupLoader = false
  groupLoaderIcon = false
end
function createGroupLoader()
  deleteGroupLoader()
  if groupModal then
    sightexports.sGui:deleteGuiElement(groupModal)
  end
  groupModal = false
  groupLoader = sightexports.sGui:createGuiElement("rectangle", 0, 0, sx, sy, rtg)
  sightexports.sGui:setGuiBackground(groupLoader, "solid", {
    0,
    0,
    0,
    150
  })
  sightexports.sGui:setGuiHover(groupLoader, "none", false, false, true)
  sightexports.sGui:setGuiHoverable(groupLoader, true)
  sightexports.sGui:disableClickTrough(groupLoader, true)
  sightexports.sGui:disableLinkCursor(groupLoader, true)
  groupLoaderIcon = sightexports.sGui:createGuiElement("image", sx / 2 - 32, sy / 2 - 32, 64, 64, groupLoader)
  sightexports.sGui:setImageFile(groupLoaderIcon, sightexports.sGui:getFaIconFilename("circle-notch", 64))
  sightexports.sGui:setImageSpinner(groupLoaderIcon, true)
end
local sideMenu = {}
local selectedGroup = false
local groupList = {}
local groupDatas = {}
local groupPanel = false
local selectedMenu = "home"
local menuButtons = {}
local groupDescriptionInput = false
local memberElements = {}
local selectedMember = false
local memberNameLabel = false
local memberFireButton = false
local memberRankLabel = false
local memberRankEdit = false
local memberSalaryLabel = false
local memberLeaderLabel = false
local memberLastOnlineLabel = false
local memberAddedLabel = false
local memberPromotedLabel = false
local perMemberPermissions = {}
local memberPermissionsData = {}
local newMemberInput = false
local groupBalanceInput = false
local newMemberList = {}
local rankCheckboxes = {}
local rankElements = {}
local perRankPermission = {}
local rankPermissionsData = {}
local selectedRank = 1
local rankNumLabel = false
local rankNameLabel = false
local rankSalaryLabel = false
local rankPermissionEdit = false
local rankPermissionEditButton = false
local rankEditButton = false
local rankDeleteButton = false
local rankUpButton = false
local rankDownButton = false
local rankNameInput = false
local rankSalaryInput = false
local rankEditColor = false
local rankEditColorElements = {}
local groupInteriors = {}
local groupGates = {}
local vehicleElements = {}
local selectedVehicle = false
local vehicleNameLabel = false
local vehiclePlateLabel = false
local vehicleSidePanel = false
local vehicleDataBg = false
local vehicleMemberElements = {}
local vehicleMemberList = {}
local vehicleMemberEditButton = false
local vehicleMemberEditing = false
local vehicleMemberButton = false
local vehicleDataButton = false
local interiorElements = {}
local interiorMemberEditButton = false
local interiorNameLabel = false
local interiorTypeLabel = false
local interiorSidePanel = false
local interiorMemberButton = false
local interiorDataButton = false
local selectedInterior = false
local interiorDataBg = false
local interiorMemberEditing = false
local interiorMemberElements = {}
local interiorMemberList = {}
local selectedGate = false
local gateMemberEditing = false
local gatesMembersList = {}
local gateNameLabel = false
local gatePermissionEditButton = false
local gatesElements = {}
local gatesMemberElements = {}
local gatesMemberBg = false
local gatesMemberScrollBar = false
local gatesMemberScroll = 0
local gatesBg = false
local gatesScrollBar = false
local gatesScroll = 0
local interiorMemberBg = false
local interiorMemberScrollBar = false
local interiorMemberScroll = 0
local interiorsBg = false
local interiorsScrollBar = false
local interiorsScroll = 0
local rankBg = false
local rankPermBg = false
local rankScrollbar = false
local rankPermScrollbar = false
local rankScroll = 0
local rankPermScroll = 0
local memberBg = false
local perMemberBg = false
local memberScroll = 0
local perMemberScroll = 0
local memberScrollBar = false
local perMemberScrollBar = false
local vehiclesBg = false
local vehicleMemberBg = false
local vehiclesScroll = 0
local vehicleMemberScroll = 0
local vehiclesScrollBar = false
local vehicleMemberScrollBar = false
function groupPanelScrollKey(key)
  local cx, cy = getCursorPosition()
  if cx then
    cx = cx * screenX
    cy = cy * screenY
    if selectedMenu == "gates" and gatesBg and gatesMemberBg then
      local x, y = sightexports.sGui:getGuiRealPosition(gatesBg)
      local w, h = sightexports.sGui:getGuiSize(gatesBg)
      if cx >= x and cy >= y and cx <= x + w and cy <= y + h then
        if key == "mouse_wheel_down" then
          local n = math.max(0, #groupGates - #gatesElements)
          if n > gatesScroll then
            gatesScroll = gatesScroll + 1
            processGroupGates()
          end
        elseif key == "mouse_wheel_up" and 0 < gatesScroll then
          gatesScroll = gatesScroll - 1
          processGroupGates()
        end
        return
      end
      if not sightexports.sGui:isGuiRenderDisabled(gatesMemberBg) then
        local x, y = sightexports.sGui:getGuiRealPosition(gatesMemberBg)
        local w, h = sightexports.sGui:getGuiSize(gatesMemberBg)
        if cx >= x and cy >= y and cx <= x + w and cy <= y + h then
          if key == "mouse_wheel_down" then
            local n = math.max(0, #gatesMembersList - #gatesMemberElements)
            if n > gatesMemberScroll then
              gatesMemberScroll = gatesMemberScroll + 1
              processGroupGatesMemberList()
            end
          elseif key == "mouse_wheel_up" and 0 < gatesMemberScroll then
            gatesMemberScroll = gatesMemberScroll - 1
            processGroupGatesMemberList()
          end
          return
        end
      end
    elseif selectedMenu == "interiors" and interiorsBg and interiorMemberBg then
      local x, y = sightexports.sGui:getGuiRealPosition(interiorsBg)
      local w, h = sightexports.sGui:getGuiSize(interiorsBg)
      if cx >= x and cy >= y and cx <= x + w and cy <= y + h then
        if key == "mouse_wheel_down" then
          local n = math.max(0, #groupInteriors - #interiorElements)
          if n > interiorsScroll then
            interiorsScroll = interiorsScroll + 1
            processGroupInteriorList()
          end
        elseif key == "mouse_wheel_up" and 0 < interiorsScroll then
          interiorsScroll = interiorsScroll - 1
          processGroupInteriorList()
        end
        return
      end
      if not sightexports.sGui:isGuiRenderDisabled(interiorMemberBg) then
        local x, y = sightexports.sGui:getGuiRealPosition(interiorMemberBg)
        local w, h = sightexports.sGui:getGuiSize(interiorMemberBg)
        if cx >= x and cy >= y and cx <= x + w and cy <= y + h then
          if key == "mouse_wheel_down" then
            local n = math.max(0, #interiorMemberList - #interiorMemberElements)
            if n > interiorMemberScroll then
              interiorMemberScroll = interiorMemberScroll + 1
              processGroupInteriorMemberList()
            end
          elseif key == "mouse_wheel_up" and 0 < interiorMemberScroll then
            interiorMemberScroll = interiorMemberScroll - 1
            processGroupInteriorMemberList()
          end
          return
        end
      end
    elseif selectedMenu == "vehicles" and vehiclesBg and vehicleMemberBg then
      local x, y = sightexports.sGui:getGuiRealPosition(vehiclesBg)
      local w, h = sightexports.sGui:getGuiSize(vehiclesBg)
      if cx >= x and cy >= y and cx <= x + w and cy <= y + h then
        if key == "mouse_wheel_down" then
          local n = math.max(0, #groupDatas[selectedGroup].vehicles - #vehicleElements)
          if n > vehiclesScroll then
            vehiclesScroll = vehiclesScroll + 1
            processGroupVehicleList()
          end
        elseif key == "mouse_wheel_up" and 0 < vehiclesScroll then
          vehiclesScroll = vehiclesScroll - 1
          processGroupVehicleList()
        end
        return
      end
      if not sightexports.sGui:isGuiRenderDisabled(vehicleMemberBg) then
        local x, y = sightexports.sGui:getGuiRealPosition(vehicleMemberBg)
        local w, h = sightexports.sGui:getGuiSize(vehicleMemberBg)
        if cx >= x and cy >= y and cx <= x + w and cy <= y + h then
          if key == "mouse_wheel_down" then
            local n = math.max(0, #vehicleMemberList - #vehicleMemberElements)
            if n > vehicleMemberScroll then
              vehicleMemberScroll = vehicleMemberScroll + 1
              processGroupVehicleMemberList()
            end
          elseif key == "mouse_wheel_up" and 0 < vehicleMemberScroll then
            vehicleMemberScroll = vehicleMemberScroll - 1
            processGroupVehicleMemberList()
          end
          return
        end
      end
    elseif selectedMenu == "members" and perMemberBg and memberBg then
      local x, y = sightexports.sGui:getGuiRealPosition(perMemberBg)
      local w, h = sightexports.sGui:getGuiSize(perMemberBg)
      if cx >= x and cy >= y and cx <= x + w and cy <= y + h then
        if key == "mouse_wheel_down" then
          local n = math.max(0, #memberPermissionsData - #perMemberPermissions)
          if n > perMemberScroll then
            perMemberScroll = perMemberScroll + 1
            processSelectedMemberPermissionList()
          end
        elseif key == "mouse_wheel_up" and 0 < perMemberScroll then
          perMemberScroll = perMemberScroll - 1
          processSelectedMemberPermissionList()
        end
        return
      end
      local x, y = sightexports.sGui:getGuiRealPosition(memberBg)
      local w, h = sightexports.sGui:getGuiSize(memberBg)
      if cx >= x and cy >= y and cx <= x + w and cy <= y + h then
        if key == "mouse_wheel_down" then
          local n = math.max(0, #groupDatas[selectedGroup].members - #memberElements)
          if n > memberScroll then
            memberScroll = memberScroll + 1
            refreshGroupMemberList()
          end
        elseif key == "mouse_wheel_up" and 0 < memberScroll then
          memberScroll = memberScroll - 1
          refreshGroupMemberList()
        end
        return
      end
    elseif selectedMenu == "ranks" and rankBg and rankPermBg then
      local x, y = sightexports.sGui:getGuiRealPosition(rankBg)
      local w, h = sightexports.sGui:getGuiSize(rankBg)
      if cx >= x and cy >= y and cx <= x + w and cy <= y + h then
        if key == "mouse_wheel_down" then
          local n = math.max(0, #groupDatas[selectedGroup].ranks - #rankElements)
          if n > rankScroll then
            rankScroll = rankScroll + 1
            processRanksList()
          end
        elseif key == "mouse_wheel_up" and 0 < rankScroll then
          rankScroll = rankScroll - 1
          processRanksList()
        end
        return
      end
      local x, y = sightexports.sGui:getGuiRealPosition(rankPermBg)
      local w, h = sightexports.sGui:getGuiSize(rankPermBg)
      if cx >= x and cy >= y and cx <= x + w and cy <= y + h then
        if key == "mouse_wheel_down" then
          local n = math.max(0, #rankPermissionsData - #perRankPermission)
          if n > rankPermScroll then
            rankPermScroll = rankPermScroll + 1
            processPerRankpermissionList()
          end
        elseif key == "mouse_wheel_up" and 0 < rankPermScroll then
          rankPermScroll = rankPermScroll - 1
          processPerRankpermissionList()
        end
        return
      end
    end
  end
end
function requestSelectedGroup()
  if selectedGroup then
    groupDatas[selectedGroup] = nil
    triggerLatentServerEvent("requestPlayerGroupData", localPlayer, selectedGroup)
  end
end
function groupMemberSort(a, b)
  if a[2] == b[2] then
    return a[6] > b[6]
  else
    return a[2] < b[2]
  end
end
function groupVehicleMemberSort(a, b)
  if a[4] == b[4] then
    if a[3] == b[3] then
      return a[2] < b[2]
    else
      return a[3] < b[3]
    end
  else
    return (a[4] and 1 or 0) > (b[4] and 1 or 0)
  end
end
function groupVehicleMemberSortEx(a, b)
  if a[3] == b[3] then
    return a[2] < b[2]
  else
    return a[3] < b[3]
  end
end
function groupVehicleSort(a, b)
  if a[2] == b[2] then
    return a[3] < b[3]
  else
    return a[2] < b[2]
  end
end
function groupInteriorSort(a, b)
  if a[3] == b[3] then
    return a[2] < b[2]
  else
    return a[3] < b[3]
  end
end
function processGroupInteriors()
  groupInteriors = {}
  local list = sightexports.sInteriors:getGroupInteriors(selectedGroup)
  for i = 1, #list do
    table.insert(groupInteriors, {
      list[i],
      sightexports.sInteriors:getInteriorName(list[i]),
      sightexports.sInteriors:getInteriorTypeName(sightexports.sInteriors:getInteriorType(list[i]))
    })
  end
  table.sort(groupInteriors, groupInteriorSort)
end
function processGroupGates()
  groupGates = {}
  local list = sightexports.sGates:getGroupGates(selectedGroup)
  for i = 1, #list do
    table.insert(groupGates, list[i])
  end
  table.sort(groupGates)
end
function processGotVehicles(prefix)
  groupDatas[prefix].vehicles = {}
  for vid, dat in pairs(groupDatas[prefix].gotVehicles) do
    local plate = dat[2] or ""
    local tmp = {}
    plate = split(plate, "-")
    for i = 1, #plate do
      if 1 <= utf8.len(plate[i]) then
        table.insert(tmp, plate[i])
      end
    end
    if dat[4] then
      customName = sightexports.sVehiclenames:getCustomVehicleName(dat[4])
    end
    table.insert(groupDatas[prefix].vehicles, {
      vid,
      customName or sightexports.sVehiclenames:getCustomVehicleName(dat[1]),
      table.concat(tmp, "-"),
      dat[5] or false
    })
  end
  table.sort(groupDatas[selectedGroup].vehicles, groupVehicleSort)
end
function processGotMembers(prefix)
  groupDatas[prefix].members = {}
  for mid, dat in pairs(groupDatas[prefix].gotMembers) do
    table.insert(groupDatas[prefix].members, {
      dat[1],
      dat[2],
      dat[3],
      dat[4],
      dat[5],
      dat[6],
      mid,
      dat[7]
    })
  end
  table.sort(groupDatas[prefix].members, groupMemberSort)
end
addEvent("refreshPlayerGroupData", true)
addEventHandler("refreshPlayerGroupData", getRootElement(), function(prefix, data)
  if groupDatas[prefix] then
    for k, v in pairs(data) do
      groupDatas[prefix][k] = v
      if k == "gotMembers" then
        processGotMembers(prefix)
      elseif k == "gotVehicles" then
        processGotVehicles(prefix)
      end
    end
    if inside and selectedGroup == prefix then
      drawGroupPanel()
    end
  end
end)
addEvent("refreshPlayerGroupDataParamter", true)
addEventHandler("refreshPlayerGroupDataParamter", getRootElement(), function(prefix, param, data)
  if groupDatas[prefix] then
    for k, v in pairs(data) do
      if not groupDatas[prefix][k] then
        groupDatas[prefix][k] = {}
      end
      if v then
        groupDatas[prefix][k][param] = v
      else
        groupDatas[prefix][k][param] = nil
      end
      if k == "gotMembers" then
        processGotMembers(prefix)
      elseif k == "gotVehicles" then
        processGotVehicles(prefix)
      end
    end
    if inside and selectedGroup == prefix then
      drawGroupPanel()
    end
  end
end)
addEvent("gotPlayerGroupData", true)
addEventHandler("gotPlayerGroupData", getRootElement(), function(prefix, data)
  groupDatas[prefix] = data
  processGotMembers(prefix)
  processGotVehicles(prefix)
  processGroupInteriors()
  processGroupGates()
  if inside and selectedGroup == prefix then
    drawGroupPanel()
  end
end)
addEvent("gotPlayerGroupList", true)
addEventHandler("gotPlayerGroupList", getRootElement(), function(list)
  groupList = list
  if inside then
    drawGroupSideMenu()
    if selectedGroup then
      for i = 1, #list do
        if list[i][1] == selectedGroup then
          requestSelectedGroup()
          createGroupLoader()
          return
        end
      end
      groupDatas[selectedGroup] = nil
      selectedGroup = false
      drawGroupPanel()
    end
  end
end)
addEvent("switchGroupPanelGroup", false)
addEventHandler("switchGroupPanelGroup", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  if sideMenu[el] then
    selectedGroup = sideMenu[el]
    setTimer(requestSelectedGroup, math.random(250, 750), 1)
    selectedMenu = "home"
    processSideMenu()
    createGroupLoader()
  end
end)
addEvent("switchGroupPanelMenu", false)
addEventHandler("switchGroupPanelMenu", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  if menuButtons[el] then
    selectedMenu = menuButtons[el]
    drawGroupPanel()
  end
end)
addEvent("doneGroupMOTD", false)
addEventHandler("doneGroupMOTD", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  createGroupLoader()
  triggerServerEvent("editGroupMOTD", localPlayer, selectedGroup, sightexports.sGui:getInputValue(groupDescriptionInput))
  sightexports.sGui:setGuiRenderDisabled(groupDescriptionInput, true)
  sightexports.sGui:setActiveInput(false)
  sightexports.sGui:deleteGuiElement(el)
end)
addEvent("editGroupMOTD", false)
addEventHandler("editGroupMOTD", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  sightexports.sGui:setGuiRenderDisabled(groupDescriptionInput, false)
  sightexports.sGui:setActiveInput(groupDescriptionInput)
  sightexports.sGui:setClickEvent(el, "doneGroupMOTD")
  sightexports.sGui:setGuiBackground(el, "solid", "sightgreen")
  sightexports.sGui:setGuiHover(el, "gradient", {
    "sightgreen",
    "sightgreen-second"
  }, false, true)
  sightexports.sGui:setButtonIcon(el, sightexports.sGui:getFaIconFilename("check", 24))
end)
function refreshGroupMemberList()
  local w, h = sightexports.sGui:getGuiSize(memberBg)
  local n = math.max(0, #groupDatas[selectedGroup].members - #memberElements)
  h = h / (n + 1)
  if n < memberScroll then
    memberScroll = n
  end
  sightexports.sGui:setGuiSize(memberScrollBar, false, h)
  sightexports.sGui:setGuiPosition(memberScrollBar, false, h * memberScroll)
  for i = 1, #memberElements do
    if groupDatas[selectedGroup].members[i + memberScroll] then
      local rect = memberElements[i][1]
      if not selectedMember then
        selectedMember = groupDatas[selectedGroup].members[i + memberScroll][7]
      end
      if selectedMember == groupDatas[selectedGroup].members[i + memberScroll][7] then
        sightexports.sGui:setGuiHoverable(rect, false)
        sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey3")
      else
        sightexports.sGui:setGuiHoverable(rect, true)
        sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey1")
      end
      local image = memberElements[i][2]
      if isElement(groupDatas[selectedGroup].members[i + memberScroll][4]) then
        sightexports.sGui:setImageFile(image, sightexports.sGui:getFaIconFilename("circle", 32))
        sightexports.sGui:setImageColor(image, "sightgreen")
        sightexports.sGui:guiSetTooltip(image, "Jelenleg online")
        sightexports.sGui:guiSetTooltip(rect, "Jelenleg online")
      else
        sightexports.sGui:setImageFile(image, sightexports.sGui:getFaIconFilename("circle", 32, "regular"))
        sightexports.sGui:setImageColor(image, "sightred")
        local time = getRealTime(groupDatas[selectedGroup].members[i + memberScroll][4])
        sightexports.sGui:guiSetTooltip(rect, "Utoljára online: " .. string.format("%04d. %02d. %02d. %02d:%02d", time.year + 1900, time.month + 1, time.monthday, time.hour, time.minute))
      end
      local image = memberElements[i][3]
      if sightexports.sGui:isGuiElementValid(image) then
        sightexports.sGui:setGuiRenderDisabled(image, not groupDatas[selectedGroup].members[i + memberScroll][3])
      end
      local label = memberElements[i][4]
      sightexports.sGui:setLabelText(label, groupDatas[selectedGroup].members[i + memberScroll][1])
      local w, h = sightexports.sGui:getGuiSize(rect)
      local label = memberElements[i][5]
      if groupDatas[selectedGroup].members[i + memberScroll][3] then
        sightexports.sGui:setGuiSize(label, w - h, false)
      else
        sightexports.sGui:setGuiSize(label, w - dashboardPadding[3] * 2, false)
      end
      sightexports.sGui:setLabelColor(label, "sight" .. (groupDatas[selectedGroup].rankColors[groupDatas[selectedGroup].members[i + memberScroll][2]] or "blue"))
      local rankText = (groupDatas[selectedGroup].ranks[groupDatas[selectedGroup].members[i + memberScroll][2]] or "N/A") .. " [" .. groupDatas[selectedGroup].members[i + memberScroll][2] .. "]"
      sightexports.sGui:setLabelText(label, rankText)
    end
  end
end
addEvent("selectGroupPanelMember", false)
addEventHandler("selectGroupPanelMember", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  for i = 1, #memberElements do
    if memberElements[i][1] == el and groupDatas[selectedGroup].members[i + memberScroll] then
      selectedMember = groupDatas[selectedGroup].members[i + memberScroll][7]
      refreshGroupMemberList()
      processSelectedMember()
    end
  end
end)
addEvent("closeGroupModal", false)
addEventHandler("closeGroupModal", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  if groupModal then
    sightexports.sGui:deleteGuiElement(groupModal)
  end
  groupModal = false
end)
addEvent("stopGroupLoader", true)
addEventHandler("stopGroupLoader", getRootElement(), function()
  deleteGroupLoader()
end)
addEvent("selectGroupMemberNewRank", false)
addEventHandler("selectGroupMemberNewRank", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  for e, i in pairs(rankCheckboxes) do
    if e == el then
      createGroupLoader()
      triggerServerEvent("groupMemberSetRank", localPlayer, selectedGroup, selectedMember, i)
      return
    end
  end
end)
addEvent("changeGroupMemberRank", false)
addEventHandler("changeGroupMemberRank", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  rankCheckboxes = {}
  if selectedMember and groupDatas[selectedGroup].gotMembers[selectedMember] then
    local data = groupDatas[selectedGroup].gotMembers[selectedMember]
    groupModal = sightexports.sGui:createGuiElement("rectangle", 0, 0, screenX, screenY)
    sightexports.sGui:setGuiBackground(groupModal, "solid", {
      0,
      0,
      0,
      150
    })
    sightexports.sGui:setGuiHover(groupModal, "none")
    sightexports.sGui:setGuiHoverable(groupModal, true)
    sightexports.sGui:disableClickTrough(groupModal, true)
    sightexports.sGui:disableLinkCursor(groupModal, true)
    local titlebarHeight = sightexports.sGui:getTitleBarHeight()
    local n = #groupDatas[selectedGroup].ranks
    local panelWidth = 600
    local panelHeight = titlebarHeight + math.ceil(n / 2) * 32
    local window = sightexports.sGui:createGuiElement("window", screenX / 2 - panelWidth / 2, -panelHeight, panelWidth, panelHeight, groupModal)
    sightexports.sGui:setWindowTitle(window, "16/BebasNeueRegular.otf", data[1])
    sightexports.sGui:setWindowCloseButton(window, "closeGroupModal")
    local x = 0
    local y = titlebarHeight
    local border = sightexports.sGui:createGuiElement("hr", panelWidth / 2 - 1, y, 2, panelHeight - y, window)
    for j = 1, n do
      local rect = sightexports.sGui:createGuiElement("rectangle", x, y, panelWidth / 2, 32, window)
      sightexports.sGui:setGuiBackground(rect, "solid", {
        0,
        0,
        0,
        0
      })
      sightexports.sGui:setGuiHover(rect, "none")
      local checkbox = sightexports.sGui:createGuiElement("checkbox", x + 2, y + 2, 28, 28, window)
      sightexports.sGui:setGuiColorScheme(checkbox, "darker")
      rankCheckboxes[checkbox] = j
      if j == data[2] then
        sightexports.sGui:setCheckboxChecked(checkbox, true)
        sightexports.sGui:setGuiHoverable(checkbox, false)
      else
        sightexports.sGui:setGuiHoverable(rect, true)
        sightexports.sGui:setGuiBoundingBox(checkbox, rect)
        sightexports.sGui:setClickEvent(checkbox, "selectGroupMemberNewRank")
      end
      local label = sightexports.sGui:createGuiElement("label", x + 32, y, 0, 32, window)
      sightexports.sGui:setLabelFont(label, groupFonts[4])
      sightexports.sGui:setLabelAlignment(label, "left", "center")
      sightexports.sGui:setLabelColor(label, "sight" .. (groupDatas[selectedGroup].rankColors[j] or "blue"))
      sightexports.sGui:setLabelText(label, groupDatas[selectedGroup].ranks[j] .. " [" .. j .. "]")
      local label = sightexports.sGui:createGuiElement("label", x, y, panelWidth / 2 - dashboardPadding[3] * 2, 32, window)
      sightexports.sGui:setLabelFont(label, groupFonts[4])
      sightexports.sGui:setLabelAlignment(label, "right", "center")
      sightexports.sGui:setLabelColor(label, "sightgreen")
      sightexports.sGui:setLabelText(label, sightexports.sGui:thousandsStepper(groupDatas[selectedGroup].salaries[j] or 0) .. " $")
      y = y + 32
      if j == math.ceil(n / 2) then
        x = x + panelWidth / 2
        y = titlebarHeight
      end
    end
    sightexports.sGui:setGuiPositionAnimated(window, false, screenY / 2 - panelHeight / 2, 250)
  end
end)
local permValues = {
  vehicle = 1,
  interior = 2,
  skin = 3,
  item = 4,
  permission = 5
}
function sortPermissionData(a, b)
  local av = permValues[a[1]] or 999
  local bv = permValues[b[1]] or 999
  if av == bv then
    return a[2] < b[2]
  else
    return av < bv
  end
end
function sortPermissionDataEx(a, b)
  local av = permValues[a[1]] or 999
  local bv = permValues[b[1]] or 999
  if av == bv then
    local at = a[3] and 1 or 0
    local bt = b[3] and 1 or 0
    if at == bt then
      return a[2] < b[2]
    else
      return at > bt
    end
  else
    return av < bv
  end
end
function processSelectedMemberPermissionList()
  local w, h = sightexports.sGui:getGuiSize(perMemberBg)
  local n = math.max(0, #memberPermissionsData - #perMemberPermissions)
  h = h / (n + 1)
  if n < perMemberScroll then
    perMemberScroll = n
  end
  sightexports.sGui:setGuiSize(perMemberScrollBar, false, h)
  sightexports.sGui:setGuiPosition(perMemberScrollBar, false, h * perMemberScroll)
  for i = 1, #perMemberPermissions do
    if memberPermissionsData[i + perMemberScroll] then
      sightexports.sGui:setGuiRenderDisabled(perMemberPermissions[i][1], false)
      sightexports.sGui:setGuiRenderDisabled(perMemberPermissions[i][2], false)
      if perMemberPermissions[i][3] then
        sightexports.sGui:setGuiRenderDisabled(perMemberPermissions[i][3], false)
      end
      if memberPermissionsData[i + perMemberScroll][1] == "vehicle" then
        sightexports.sGui:setImageFile(perMemberPermissions[i][1], sightexports.sGui:getFaIconFilename("car", 32))
        sightexports.sGui:setImageColor(perMemberPermissions[i][1], "sightgreen")
        sightexports.sGui:setLabelColor(perMemberPermissions[i][2], "sightgreen")
        sightexports.sGui:setLabelText(perMemberPermissions[i][2], "Jármű #ffffff " .. memberPermissionsData[i + perMemberScroll][2])
      elseif memberPermissionsData[i + perMemberScroll][1] == "gate" then
        sightexports.sGui:setImageDDS(perMemberPermissions[i][1], ":sGates/files/icon.dds")
        sightexports.sGui:setImageColor(perMemberPermissions[i][1], "sightred")
        sightexports.sGui:setLabelColor(perMemberPermissions[i][2], "sightred")
        sightexports.sGui:setLabelText(perMemberPermissions[i][2], "Kapu #ffffff " .. memberPermissionsData[i + perMemberScroll][2])
      elseif memberPermissionsData[i + perMemberScroll][1] == "interior" then
        sightexports.sGui:setImageFile(perMemberPermissions[i][1], sightexports.sGui:getFaIconFilename("building", 32))
        sightexports.sGui:setImageColor(perMemberPermissions[i][1], "sightblue")
        sightexports.sGui:setLabelColor(perMemberPermissions[i][2], "sightblue")
        sightexports.sGui:setLabelText(perMemberPermissions[i][2], "Interior #ffffff " .. memberPermissionsData[i + perMemberScroll][2])
      elseif memberPermissionsData[i + perMemberScroll][1] == "skin" then
        sightexports.sGui:setImageFile(perMemberPermissions[i][1], sightexports.sGui:getFaIconFilename("user-tie", 32))
        sightexports.sGui:setImageColor(perMemberPermissions[i][1], "sightpurple")
        sightexports.sGui:setLabelColor(perMemberPermissions[i][2], "sightpurple")
        sightexports.sGui:setLabelText(perMemberPermissions[i][2], "Skin #ffffff" .. memberPermissionsData[i + perMemberScroll][2])
      elseif memberPermissionsData[i + perMemberScroll][1] == "item" then
        sightexports.sGui:setImageFile(perMemberPermissions[i][1], sightexports.sGui:getFaIconFilename("box", 32))
        sightexports.sGui:setImageColor(perMemberPermissions[i][1], "sightorange")
        sightexports.sGui:setLabelColor(perMemberPermissions[i][2], "sightorange")
        sightexports.sGui:setLabelText(perMemberPermissions[i][2], "Duty item #ffffff" .. memberPermissionsData[i + perMemberScroll][2])
      elseif memberPermissionsData[i + perMemberScroll][1] == "permission" then
        sightexports.sGui:setImageFile(perMemberPermissions[i][1], sightexports.sGui:getFaIconFilename("bolt", 32))
        sightexports.sGui:setImageColor(perMemberPermissions[i][1], "sightyellow")
        sightexports.sGui:setLabelColor(perMemberPermissions[i][2], "sightyellow")
        sightexports.sGui:setLabelText(perMemberPermissions[i][2], "Jog #ffffff" .. memberPermissionsData[i + perMemberScroll][2])
      end
    else
      sightexports.sGui:setGuiRenderDisabled(perMemberPermissions[i][1], true)
      sightexports.sGui:setGuiRenderDisabled(perMemberPermissions[i][2], true)
      if perMemberPermissions[i][3] then
        sightexports.sGui:setGuiRenderDisabled(perMemberPermissions[i][3], true)
      end
    end
  end
end
function processSelectedMember()
  perMemberScroll = 0
  rankCheckboxes = {}
  memberPermissionsData = {}
  if selectedMember and groupDatas[selectedGroup].gotMembers[selectedMember] then
    local member = groupDatas[selectedGroup].gotMembers[selectedMember]
    sightexports.sGui:setLabelText(memberNameLabel, member[1])
    if memberFireButton then
      if member[3] and not groupDatas[selectedGroup].isLeader then
        sightexports.sGui:setGuiRenderDisabled(memberFireButton, true)
      else
        sightexports.sGui:setGuiRenderDisabled(memberFireButton, false)
        local x = sightexports.sGui:getGuiPosition(memberNameLabel)
        local w = sightexports.sGui:getLabelTextWidth(memberNameLabel)
        sightexports.sGui:setGuiPosition(memberFireButton, x + w + dashboardPadding[3], false)
      end
    end
    local rank = member[2]
    sightexports.sGui:setLabelColor(memberRankLabel, "sight" .. (groupDatas[selectedGroup].rankColors[rank] or "blue"))
    sightexports.sGui:setLabelText(memberRankLabel, (groupDatas[selectedGroup].ranks[rank] or "N/A") .. " [" .. rank .. "]")
    if memberRankEdit then
      sightexports.sGui:setGuiRenderDisabled(memberRankEdit, false)
      local x = sightexports.sGui:getGuiPosition(memberRankLabel)
      local w = sightexports.sGui:getLabelTextWidth(memberRankLabel)
      sightexports.sGui:setGuiPosition(memberRankEdit, x + w + dashboardPadding[3], false)
    end
    sightexports.sGui:setLabelText(memberSalaryLabel, sightexports.sGui:thousandsStepper(groupDatas[selectedGroup].salaries[rank] or 0) .. " $")
    sightexports.sGui:setLabelColor(memberLeaderLabel, member[3] and "sightgreen" or "sightred")
    sightexports.sGui:setLabelText(memberLeaderLabel, member[3] and "igen" or "nem")
    if isElement(member[4]) then
      sightexports.sGui:setLabelColor(memberLastOnlineLabel, "sightgreen")
      sightexports.sGui:setLabelText(memberLastOnlineLabel, "jelenleg online")
    else
      local time = getRealTime(member[4])
      sightexports.sGui:setLabelColor(memberLastOnlineLabel, "sightblue")
      sightexports.sGui:setLabelText(memberLastOnlineLabel, string.format("%04d. %02d. %02d. %02d:%02d", time.year + 1900, time.month + 1, time.monthday, time.hour, time.minute))
    end
    local time = getRealTime(member[5])
    sightexports.sGui:setLabelText(memberAddedLabel, string.format("%04d. %02d. %02d. %02d:%02d", time.year + 1900, time.month + 1, time.monthday, time.hour, time.minute))
    local time = getRealTime(member[6])
    sightexports.sGui:setLabelText(memberPromotedLabel, string.format("%04d. %02d. %02d. %02d:%02d", time.year + 1900, time.month + 1, time.monthday, time.hour, time.minute))
    local n = #perMemberPermissions
    if member[3] then
      for i = 1, #perMemberPermissions do
        if i <= 5 then
          sightexports.sGui:setGuiRenderDisabled(perMemberPermissions[i][1], false)
          sightexports.sGui:setGuiRenderDisabled(perMemberPermissions[i][2], false)
          if perMemberPermissions[i][3] then
            sightexports.sGui:setGuiRenderDisabled(perMemberPermissions[i][3], false)
          end
          if i == 1 then
            sightexports.sGui:setImageFile(perMemberPermissions[i][1], sightexports.sGui:getFaIconFilename("car", 32))
            sightexports.sGui:setImageColor(perMemberPermissions[i][1], "sightgreen")
            sightexports.sGui:setLabelColor(perMemberPermissions[i][2], "sightgreen")
            sightexports.sGui:setLabelText(perMemberPermissions[i][2], "Összes jármű")
          elseif i == 2 then
            sightexports.sGui:setImageFile(perMemberPermissions[i][1], sightexports.sGui:getFaIconFilename("building", 32))
            sightexports.sGui:setImageColor(perMemberPermissions[i][1], "sightblue")
            sightexports.sGui:setLabelColor(perMemberPermissions[i][2], "sightblue")
            sightexports.sGui:setLabelText(perMemberPermissions[i][2], "Összes interior")
          elseif i == 3 then
            sightexports.sGui:setImageFile(perMemberPermissions[i][1], sightexports.sGui:getFaIconFilename("user-tie", 32))
            sightexports.sGui:setImageColor(perMemberPermissions[i][1], "sightpurple")
            sightexports.sGui:setLabelColor(perMemberPermissions[i][2], "sightpurple")
            sightexports.sGui:setLabelText(perMemberPermissions[i][2], "Összes skin")
          elseif i == 4 then
            sightexports.sGui:setImageFile(perMemberPermissions[i][1], sightexports.sGui:getFaIconFilename("box", 32))
            sightexports.sGui:setImageColor(perMemberPermissions[i][1], "sightorange")
            sightexports.sGui:setLabelColor(perMemberPermissions[i][2], "sightorange")
            sightexports.sGui:setLabelText(perMemberPermissions[i][2], "Összes duty item")
          elseif i == 5 then
            sightexports.sGui:setImageDDS(perMemberPermissions[i][1], ":sGates/files/icon.dds")
            sightexports.sGui:setImageColor(perMemberPermissions[i][1], "sightred")
            sightexports.sGui:setLabelColor(perMemberPermissions[i][2], "sightred")
            sightexports.sGui:setLabelText(perMemberPermissions[i][2], "Összes kapu")
          else
            sightexports.sGui:setImageFile(perMemberPermissions[i][1], sightexports.sGui:getFaIconFilename("bolt", 32))
            sightexports.sGui:setImageColor(perMemberPermissions[i][1], "sightyellow")
            sightexports.sGui:setLabelColor(perMemberPermissions[i][2], "sightyellow")
            sightexports.sGui:setLabelText(perMemberPermissions[i][2], "Összes jog")
          end
        else
          sightexports.sGui:setGuiRenderDisabled(perMemberPermissions[i][1], true)
          sightexports.sGui:setGuiRenderDisabled(perMemberPermissions[i][2], true)
          if perMemberPermissions[i][3] then
            sightexports.sGui:setGuiRenderDisabled(perMemberPermissions[i][3], true)
          end
        end
      end
    else
      if groupDatas[selectedGroup].rankPermissions[rank] then
        for perm in pairs(groupDatas[selectedGroup].rankPermissions[rank]) do
          if groupDatas[selectedGroup].rankPermissions[rank][perm] then
            table.insert(memberPermissionsData, {
              "permission",
              sightexports.sGroups:getPermissionName(perm)
            })
          end
        end
      end
      if groupDatas[selectedGroup].rankSkins[rank] then
        for skin in pairs(groupDatas[selectedGroup].rankSkins[rank]) do
          if groupDatas[selectedGroup].rankSkins[rank][skin] then
            table.insert(memberPermissionsData, {
              "skin",
              sightexports.sGroups:getDutySkinName(selectedGroup, skin)
            })
        end
        end
      end
      if groupDatas[selectedGroup].rankItems[rank] then
        for item in pairs(groupDatas[selectedGroup].rankItems[rank]) do
          if groupDatas[selectedGroup].rankItems[rank][item] then
            if 1 < groupDatas[selectedGroup].items[item][1] then
              table.insert(memberPermissionsData, {
                "item",
                groupDatas[selectedGroup].items[item][1] .. "db " .. sightexports.sItems:getItemName(item) .. " (" .. sightexports.sGui:thousandsStepper(sightexports.sGroups:getDutyItemPrice(selectedGroup, item)) .. " $/db)"
              })
            else
              table.insert(memberPermissionsData, {
                "item",
                sightexports.sItems:getItemName(item) .. " (" .. sightexports.sGui:thousandsStepper(sightexports.sGroups:getDutyItemPrice(selectedGroup, item)) .. " $/db)"
              })
            end
          end
        end
      end
      for i = 1, #groupDatas[selectedGroup].vehicles do
        local selectedMember = groupDatas[selectedGroup].gotMembers[selectedMember][7]
        if groupDatas[selectedGroup].vehicleMembers[groupDatas[selectedGroup].vehicles[i][1]][selectedMember] then
          table.insert(memberPermissionsData, {
            "vehicle",
            "[" .. groupDatas[selectedGroup].vehicles[i][1] .. "] " .. groupDatas[selectedGroup].vehicles[i][2] .. " ([color=sightblue]" .. groupDatas[selectedGroup].vehicles[i][3] .. "#ffffff)"
          })
        end 
      end
      for i = 1, #groupInteriors do
        local selectedMember = groupDatas[selectedGroup].gotMembers[selectedMember][7]
        if groupDatas[selectedGroup].interiorMembers[groupInteriors[i][1]][selectedMember] then
          table.insert(memberPermissionsData, {
            "interior",
            "[" .. groupInteriors[i][1] .. "] " .. groupInteriors[i][2] .. " (" .. groupInteriors[i][3] .. "#ffffff)"
          })
        end
      end
      for i = 1, #groupGates do
        if groupDatas[selectedGroup].gateMembers[groupGates[i]][selectedMember] then
          table.insert(memberPermissionsData, {
            "gate",
            "[" .. groupGates[i] .. "]"
          })
        end
      end
      table.sort(memberPermissionsData, sortPermissionData)
      processSelectedMemberPermissionList()
    end
  else
    sightexports.sGui:setLabelText(memberNameLabel, "Válassz tagot!")
    sightexports.sGui:setLabelText(memberRankLabel, "")
    sightexports.sGui:setLabelText(memberSalaryLabel, "")
    sightexports.sGui:setLabelText(memberLeaderLabel, "")
    sightexports.sGui:setLabelText(memberLastOnlineLabel, "")
    sightexports.sGui:setLabelText(memberAddedLabel, "")
    if memberRankEdit then
      sightexports.sGui:setGuiRenderDisabled(memberRankEdit, true)
    end
    if memberFireButton then
      sightexports.sGui:setGuiRenderDisabled(memberFireButton, true)
    end
    for i = 1, #perMemberPermissions do
      sightexports.sGui:setGuiRenderDisabled(perMemberPermissions[i][1], true)
      sightexports.sGui:setGuiRenderDisabled(perMemberPermissions[i][2], true)
      if perMemberPermissions[i][3] then
        sightexports.sGui:setGuiRenderDisabled(perMemberPermissions[i][3], true)
      end
    end
  end
end
addEvent("finalFireMemberFromGroup", false)
addEventHandler("finalFireMemberFromGroup", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  if groupDatas[selectedGroup] and groupDatas[selectedGroup].gotMembers[selectedMember] then
    createGroupLoader()
    triggerServerEvent("firePlayerFromGroup", localPlayer, selectedGroup, selectedMember)
    selectedMember = false
  end
end)
addEvent("fireMemberFromGroup", false)
addEventHandler("fireMemberFromGroup", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  if groupDatas[selectedGroup] and groupDatas[selectedGroup].gotMembers[selectedMember] then
    groupModal = sightexports.sGui:createGuiElement("rectangle", 0, 0, screenX, screenY)
    sightexports.sGui:setGuiBackground(groupModal, "solid", {
      0,
      0,
      0,
      150
    })
    sightexports.sGui:setGuiHover(groupModal, "none")
    sightexports.sGui:setGuiHoverable(groupModal, true)
    sightexports.sGui:disableClickTrough(groupModal, true)
    sightexports.sGui:disableLinkCursor(groupModal, true)
    local titlebarHeight = sightexports.sGui:getTitleBarHeight()
    local panelWidth = 375
    local pad = dashboardPadding[3] * 2
    local panelHeight = titlebarHeight + 96
    local window = sightexports.sGui:createGuiElement("window", screenX / 2 - panelWidth / 2, -panelHeight, panelWidth, panelHeight, groupModal)
    sightexports.sGui:setWindowTitle(window, "16/BebasNeueRegular.otf", groupDatas[selectedGroup].gotMembers[selectedMember][1] .. " kirúgása")
    local label = sightexports.sGui:createGuiElement("label", pad, titlebarHeight, panelWidth - pad, panelHeight - titlebarHeight - 24 - pad, window)
    sightexports.sGui:setLabelFont(label, groupFonts[6])
    sightexports.sGui:setLabelAlignment(label, "center", "center")
    sightexports.sGui:setLabelText(label, "Biztosan szeretnéd kirúgni a tagot?")
    local w = (panelWidth - pad * 3) / 2
    local btn = sightexports.sGui:createGuiElement("button", pad, panelHeight - 24 - pad, w, 24, window)
    sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
    sightexports.sGui:setGuiHover(btn, "gradient", {
      "sightgreen",
      "sightgreen-second"
    }, false, true)
    sightexports.sGui:setButtonFont(btn, groupFonts[1])
    sightexports.sGui:setButtonText(btn, "Igen")
    sightexports.sGui:setClickEvent(btn, "finalFireMemberFromGroup")
    local btn = sightexports.sGui:createGuiElement("button", pad + w + pad, panelHeight - 24 - pad, w, 24, window)
    sightexports.sGui:setGuiBackground(btn, "solid", "sightred")
    sightexports.sGui:setGuiHover(btn, "gradient", {
      "sightred",
      "sightred-second"
    }, false, true)
    sightexports.sGui:setButtonFont(btn, groupFonts[1])
    sightexports.sGui:setButtonText(btn, "Nem")
    sightexports.sGui:setClickEvent(btn, "closeGroupModal")
    sightexports.sGui:setGuiPositionAnimated(window, false, screenY / 2 - panelHeight / 2, 250)
  end
end)
addEvent("finalAddGroupMember", false)
addEventHandler("finalAddGroupMember", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  for i = 1, #newMemberList do
    if newMemberList[i][2] == el then
      createGroupLoader()
      triggerServerEvent("addPlayerToGroup", localPlayer, selectedGroup, newMemberList[i][3])
      return
    end
  end
end)
function refreshNewMemberList()
  local players = getElementsByType("player")
  local c = 1
  local value = sightexports.sGui:getInputValue(newMemberInput) or ""
  for i = 1, #players do
    local cid = getElementData(players[i], "char.ID")
    if cid then
      local pid, name
      local found = true
      if tonumber(value) then
        pid = getElementData(players[i], "playerID")
        found = tonumber(value) == pid
      elseif utf8.len(value) > 0 then
        name = getElementData(players[i], "visibleName"):gsub("_", " ")
        found = utf8.find(utf8.lower(name), utf8.lower(value:gsub("_", " ")))
      end
      if found then
        pid = pid or getElementData(players[i], "playerID")
        name = name or getElementData(players[i], "visibleName"):gsub("_", " ")
        sightexports.sGui:setGuiRenderDisabled(newMemberList[c][1], false)
        sightexports.sGui:setGuiRenderDisabled(newMemberList[c][2], false)
        sightexports.sGui:setLabelText(newMemberList[c][1], "[" .. pid .. "] " .. name)
        local icon = newMemberList[c][2]
        local tMembers = {}
        for k, v in pairs(groupDatas[selectedGroup].gotMembers) do
          tMembers[v[7]] = v
        end
        if tMembers[cid] then
          sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("user-tag", 24))
          sightexports.sGui:setImageColor(icon, "sightmidgrey")
          sightexports.sGui:setGuiHover(icon, "solid", "sightmidgrey")
          sightexports.sGui:setClickEvent(icon, false)
          sightexports.sGui:guiSetTooltip(icon, "Jelenleg tag")
          sightexports.sGui:setLabelColor(newMemberList[c][1], "sightmidgrey")
        else
          sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("user-plus", 24))
          sightexports.sGui:setImageColor(icon, "#ffffff")
          sightexports.sGui:setGuiHover(icon, "solid", "sightgreen")
          sightexports.sGui:setClickEvent(icon, "finalAddGroupMember")
          sightexports.sGui:guiSetTooltip(icon, "Tag felvétele")
          sightexports.sGui:setLabelColor(newMemberList[c][1], "sightlightgrey")
        end
        newMemberList[c][3] = players[i]
        c = c + 1
        if c > #newMemberList then
          break
        end
      end
    end
  end
  for i = c, #newMemberList do
    sightexports.sGui:setGuiRenderDisabled(newMemberList[i][1], true)
    sightexports.sGui:setGuiRenderDisabled(newMemberList[i][2], true)
    newMemberList[c][3] = false
  end
end
addEvent("refreshNewMemberList", true)
addEventHandler("refreshNewMemberList", getRootElement(), refreshNewMemberList)
addEvent("openMemberAddModal", false)
addEventHandler("openMemberAddModal", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  groupModal = sightexports.sGui:createGuiElement("rectangle", 0, 0, screenX, screenY)
  sightexports.sGui:setGuiBackground(groupModal, "solid", {
    0,
    0,
    0,
    150
  })
  sightexports.sGui:setGuiHover(groupModal, "none")
  sightexports.sGui:setGuiHoverable(groupModal, true)
  sightexports.sGui:disableClickTrough(groupModal, true)
  sightexports.sGui:disableLinkCursor(groupModal, true)
  local titlebarHeight = sightexports.sGui:getTitleBarHeight()
  local panelWidth = 375
  local pad = dashboardPadding[3] * 2
  local panelHeight = titlebarHeight + 160 + pad + 30 + pad
  local window = sightexports.sGui:createGuiElement("window", screenX / 2 - panelWidth / 2, -panelHeight, panelWidth, panelHeight, groupModal)
  sightexports.sGui:setWindowTitle(window, "16/BebasNeueRegular.otf", "Tagfelvétel")
  sightexports.sGui:setWindowCloseButton(window, "closeGroupModal")
  local y = titlebarHeight
  newMemberList = {}
  for i = 1, 5 do
    newMemberList[i] = {}
    local label = sightexports.sGui:createGuiElement("label", pad, y, 0, 32, window)
    sightexports.sGui:setLabelFont(label, groupFonts[4])
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    newMemberList[i][1] = label
    local icon = sightexports.sGui:createGuiElement("image", panelWidth - 24 - pad, y + 16 - 12, 24, 24, window)
    sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("user-plus", 24))
    sightexports.sGui:setGuiHover(icon, "solid", "sightgreen")
    sightexports.sGui:setGuiHoverable(icon, true)
    sightexports.sGui:setClickEvent(icon, "finalAddGroupMember")
    sightexports.sGui:guiSetTooltip(icon, "Tag felvétele")
    newMemberList[i][2] = icon
    y = y + 32
    if i < 5 then
      local border = sightexports.sGui:createGuiElement("hr", pad, y - 1, panelWidth - pad * 2, 2, window)
    end
  end
  y = y + pad
  newMemberInput = sightexports.sGui:createGuiElement("input", pad, y, panelWidth - pad * 2, 30, window)
  sightexports.sGui:setInputPlaceholder(newMemberInput, "Játékos neve / ID")
  sightexports.sGui:setInputMaxLength(newMemberInput, 32)
  sightexports.sGui:setInputIcon(newMemberInput, "user")
  sightexports.sGui:setInputChangeEvent(newMemberInput, "refreshNewMemberList")
  refreshNewMemberList()
  sightexports.sGui:setGuiPositionAnimated(window, false, screenY / 2 - panelHeight / 2, 250)
end)
addEvent("depositGroup", true)
addEventHandler("depositGroup", getRootElement(), function()
  local value = sightexports.sGui:getInputValue(groupBalanceInput)
  if not tonumber(value) then
    sightexports.sGui:showInfobox("e", "Érvénytelen összeg!")
    return
  end
  value = tonumber(value)
  if value < 1000 then
    sightexports.sGui:showInfobox("e", "Minimum kezelhető összeg: 1 000$")
    return
  end
  createGroupLoader()
  triggerEvent("closeGroupModal", localPlayer)
  triggerLatentServerEvent("depositGroupBalance", localPlayer, selectedGroup, value)
end)
addEvent("withdrawGroup", true)
addEventHandler("withdrawGroup", getRootElement(), function()
  local value = sightexports.sGui:getInputValue(groupBalanceInput)
  if not tonumber(value) then
    sightexports.sGui:showInfobox("e", "Érvénytelen összeg!")
    return
  end
  value = tonumber(value)
  if value < 1000 then
    sightexports.sGui:showInfobox("e", "Minimum kezelhető összeg: 1 000$")
    return
  end
  createGroupLoader()
  triggerEvent("closeGroupModal", localPlayer)
  triggerLatentServerEvent("withdrawGroupBalance", localPlayer, selectedGroup, value)
end)
addEvent("refreshGroupBalance", true)
addEventHandler("refreshGroupBalance", getRootElement(), function(prefix, amount)
  if groupDatas[prefix] then
    groupDatas[prefix].balance = amount
  end
  deleteGroupLoader()
  drawGroupPanel()
end)
addEvent("openGroupBalanceModal", false)
addEventHandler("openGroupBalanceModal", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  groupModal = sightexports.sGui:createGuiElement("rectangle", 0, 0, screenX, screenY)
  sightexports.sGui:setGuiBackground(groupModal, "solid", {
    0,
    0,
    0,
    150
  })
  sightexports.sGui:setGuiHover(groupModal, "none")
  sightexports.sGui:setGuiHoverable(groupModal, true)
  sightexports.sGui:disableClickTrough(groupModal, true)
  sightexports.sGui:disableLinkCursor(groupModal, true)
  local titlebarHeight = sightexports.sGui:getTitleBarHeight()
  local panelWidth = 375
  local pad = dashboardPadding[3] * 2
  local panelHeight = titlebarHeight + 30 + 60 + pad * 2
  local window = sightexports.sGui:createGuiElement("window", screenX / 2 - panelWidth / 2, -panelHeight, panelWidth, panelHeight, groupModal)
  sightexports.sGui:setWindowTitle(window, "16/BebasNeueRegular.otf", "Kasszakezelés")
  sightexports.sGui:setWindowCloseButton(window, "closeGroupModal")
  local y = titlebarHeight
  local label = sightexports.sGui:createGuiElement("label", pad, y, 0, 32, window)
  sightexports.sGui:setLabelFont(label, groupFonts[4])
  sightexports.sGui:setLabelAlignment(label, "left", "center")
  local label = sightexports.sGui:createGuiElement("label", pad + 2, y, 0, 0, window)
  sightexports.sGui:setLabelFont(label, groupFonts[4])
  sightexports.sGui:setLabelAlignment(label, "left", "top")
  sightexports.sGui:setLabelText(label, "Egyenleg: ")
  local label = sightexports.sGui:createGuiElement("label", pad + 2 + sightexports.sGui:getLabelTextWidth(label), y, 0, 0, window)
  sightexports.sGui:setLabelFont(label, groupFonts[5])
  sightexports.sGui:setLabelAlignment(label, "left", "top")
  if 0 <= groupDatas[selectedGroup].balance then
    sightexports.sGui:setLabelColor(label, "sightgreen")
  else
    sightexports.sGui:setLabelColor(label, "sightred")
  end
  sightexports.sGui:setLabelText(label, sightexports.sGui:thousandsStepper(groupDatas[selectedGroup].balance) .. " $")
  y = y + pad + sightexports.sGui:getLabelFontHeight(label)
  groupBalanceInput = sightexports.sGui:createGuiElement("input", pad, y, panelWidth - pad * 2, 30, window)
  sightexports.sGui:setInputPlaceholder(groupBalanceInput, "Összeg")
  sightexports.sGui:setInputMaxLength(groupBalanceInput, 32)
  sightexports.sGui:setInputIcon(groupBalanceInput, "coins")
  sightexports.sGui:setInputNumberOnly(groupBalanceInput, true)
  y = y + pad + 30
  local buttonSizeX = (panelWidth - pad * 3) / 2
  local btn = sightexports.sGui:createGuiElement("button", pad, y, buttonSizeX, 30, window)
  sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
  sightexports.sGui:setGuiHover(btn, "gradient", {
    "sightgreen",
    "sightgreen-second"
  }, false, true)
  sightexports.sGui:setButtonFont(btn, groupFonts[1])
  sightexports.sGui:setButtonText(btn, " Befizetés")
  sightexports.sGui:setClickEvent(btn, "depositGroup")
  sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("plus", 24))
  local btn = sightexports.sGui:createGuiElement("button", pad * 2 + buttonSizeX, y, buttonSizeX, 30, window)
  sightexports.sGui:setGuiBackground(btn, "solid", "sightred")
  sightexports.sGui:setGuiHover(btn, "gradient", {
    "sightred",
    "sightred-second"
  }, false, true)
  sightexports.sGui:setButtonFont(btn, groupFonts[1])
  sightexports.sGui:setButtonText(btn, " Kifizetés")
  sightexports.sGui:setClickEvent(btn, "withdrawGroup")
  sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("minus", 24))
  sightexports.sGui:setGuiPositionAnimated(window, false, screenY / 2 - panelHeight / 2, 250)
end)
function drawGroupMembers()
  local onlineMembers = 0
  for i = 1, #groupDatas[selectedGroup].members do
    if isElement(groupDatas[selectedGroup].members[i][4]) then
      onlineMembers = onlineMembers + 1
    end
  end
  local label = sightexports.sGui:createGuiElement("label", dashboardPadding[3] * 4, 40, 0, 48, groupPanel)
  sightexports.sGui:setLabelFont(label, groupFonts[3])
  sightexports.sGui:setLabelAlignment(label, "left", "center")
  sightexports.sGui:setLabelText(label, "Tagok: " .. onlineMembers .. "/" .. #groupDatas[selectedGroup].members)
  local perm = sightexports.sGroups:getPlayerPermissionInGroup(selectedGroup, "hireFire")
  if groupDatas[selectedGroup].isLeader or perm then
    local btn = sightexports.sGui:createGuiElement("button", dashboardPadding[3] * 4 + sightexports.sGui:getLabelTextWidth(label) + dashboardPadding[3] * 2, 52, 100, 24, groupPanel)
    sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
    sightexports.sGui:setGuiHover(btn, "gradient", {
      "sightgreen",
      "sightgreen-second"
    }, false, true)
    sightexports.sGui:setButtonFont(btn, groupFonts[1])
    sightexports.sGui:setButtonText(btn, "Tagfelvétel")
    sightexports.sGui:setClickEvent(btn, "openMemberAddModal")
  end
  local w = math.ceil((sx - menuW) * 0.45)
  local h = sy - 40 - dashboardPadding[3] * 8 - 48
  memberBg = sightexports.sGui:createGuiElement("rectangle", dashboardPadding[3] * 4, 88 + dashboardPadding[3] * 4, w, h, groupPanel)
  sightexports.sGui:setGuiBackground(memberBg, "solid", "sightgrey1")
  local sbg = sightexports.sGui:createGuiElement("rectangle", w - 2, 0, 2, h, memberBg)
  sightexports.sGui:setGuiBackground(sbg, "solid", "sightgrey3")
  memberScrollBar = sightexports.sGui:createGuiElement("rectangle", w - 2, 0, 2, h, memberBg)
  sightexports.sGui:setGuiBackground(memberScrollBar, "solid", "sightmidgrey")
  local n = math.floor(h / 32)
  h = h / n
  memberElements = {}
  y = 0
  for i = 1, n do
    if groupDatas[selectedGroup].members[i] then
      memberElements[i] = {}
      local rect = sightexports.sGui:createGuiElement("rectangle", 0, y, w - 2, h - 1, memberBg)
      sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey1")
      sightexports.sGui:setGuiHover(rect, "gradient", {"sightgrey1", "sightgrey2"}, false, true)
      sightexports.sGui:setGuiHoverable(rect, true)
      sightexports.sGui:setClickEvent(rect, "selectGroupPanelMember")
      memberElements[i][1] = rect
      local image = sightexports.sGui:createGuiElement("image", dashboardPadding[3], dashboardPadding[3] * 2, h - dashboardPadding[3] * 4, h - dashboardPadding[3] * 4, rect)
      memberElements[i][2] = image
      local image = sightexports.sGui:createGuiElement("image", w - h + dashboardPadding[3] * 2 - 2, dashboardPadding[3] * 2, h - dashboardPadding[3] * 4, h - dashboardPadding[3] * 4, rect)
      sightexports.sGui:setImageFile(image, sightexports.sGui:getFaIconFilename("user-shield", 32))
      sightexports.sGui:setImageColor(image, "sightyellow")
      memberElements[i][3] = image
      local label = sightexports.sGui:createGuiElement("label", h - dashboardPadding[3] * 2, 0, 0, h, rect)
      sightexports.sGui:setLabelFont(label, groupFonts[4])
      sightexports.sGui:setLabelAlignment(label, "left", "center")
      memberElements[i][4] = label
      local label = sightexports.sGui:createGuiElement("label", 0, 0, w - dashboardPadding[3] * 2 - 2, h, rect)
      sightexports.sGui:setLabelFont(label, groupFonts[5])
      sightexports.sGui:setLabelColor(label, "sightblue")
      sightexports.sGui:setLabelAlignment(label, "right", "center")
      memberElements[i][5] = label
      if i < n then
        local border = sightexports.sGui:createGuiElement("hr", 0, h - 1, w - 2, 2, rect)
        sightexports.sGui:setGuiHrColor(border, "sightgrey3", "sightgrey2")
      end
    end
    y = y + h
  end
  x = dashboardPadding[3] * 4 + w
  y = 88 + dashboardPadding[3] * 4
  local w = sx - menuW - x
  x = x + dashboardPadding[3] * 4
  memberNameLabel = sightexports.sGui:createGuiElement("label", x, y, w, 0, groupPanel)
  sightexports.sGui:setLabelFont(memberNameLabel, groupFonts[3])
  sightexports.sGui:setLabelAlignment(memberNameLabel, "left", "top")
  local perm = sightexports.sGroups:getPlayerPermissionInGroup(selectedGroup, "hireFire")
  if groupDatas[selectedGroup].isLeader or perm then
    local h = sightexports.sGui:getLabelFontHeight(memberNameLabel)
    memberFireButton = sightexports.sGui:createGuiElement("image", x, y, h, h, groupPanel)
    sightexports.sGui:setImageFile(memberFireButton, sightexports.sGui:getFaIconFilename("user-times", h))
    sightexports.sGui:setGuiHover(memberFireButton, "solid", "sightred")
    sightexports.sGui:setGuiHoverable(memberFireButton, true)
    sightexports.sGui:setClickEvent(memberFireButton, "fireMemberFromGroup")
    sightexports.sGui:guiSetTooltip(memberFireButton, "Tag kirúgása")
  end
  y = y + sightexports.sGui:getLabelFontHeight(memberNameLabel) + dashboardPadding[3] * 2
  local label = sightexports.sGui:createGuiElement("label", x, y, 0, 0, groupPanel)
  sightexports.sGui:setLabelFont(label, groupFonts[4])
  sightexports.sGui:setLabelAlignment(label, "left", "top")
  sightexports.sGui:setLabelText(label, "Rang: ")
  memberRankLabel = sightexports.sGui:createGuiElement("label", x + sightexports.sGui:getLabelTextWidth(label), y, 0, 0, groupPanel)
  sightexports.sGui:setLabelFont(memberRankLabel, groupFonts[5])
  sightexports.sGui:setLabelAlignment(memberRankLabel, "left", "top")
  sightexports.sGui:setLabelColor(memberRankLabel, "sightblue")
  local h = sightexports.sGui:getLabelFontHeight(label)
  local perm = sightexports.sGroups:getPlayerPermissionInGroup(selectedGroup, "promoteDemote")
  if groupDatas[selectedGroup].isLeader or perm then
    memberRankEdit = sightexports.sGui:createGuiElement("image", x, y, h, h, groupPanel)
    sightexports.sGui:setImageFile(memberRankEdit, sightexports.sGui:getFaIconFilename("pen", h))
    sightexports.sGui:setGuiHover(memberRankEdit, "solid", "sightgreen")
    sightexports.sGui:setGuiHoverable(memberRankEdit, true)
    sightexports.sGui:setClickEvent(memberRankEdit, "changeGroupMemberRank")
    sightexports.sGui:guiSetTooltip(memberRankEdit, "Tag rangjának szerkesztése")
  else
    memberRankEdit = false
  end
  y = y + h + dashboardPadding[3]
  local label = sightexports.sGui:createGuiElement("label", x, y, 0, 0, groupPanel)
  sightexports.sGui:setLabelFont(label, groupFonts[4])
  sightexports.sGui:setLabelAlignment(label, "left", "top")
  sightexports.sGui:setLabelText(label, "Fizetés: ")
  memberSalaryLabel = sightexports.sGui:createGuiElement("label", x + sightexports.sGui:getLabelTextWidth(label), y, 0, 0, groupPanel)
  sightexports.sGui:setLabelFont(memberSalaryLabel, groupFonts[5])
  sightexports.sGui:setLabelAlignment(memberSalaryLabel, "left", "top")
  sightexports.sGui:setLabelColor(memberSalaryLabel, "sightgreen")
  y = y + sightexports.sGui:getLabelFontHeight(label) + dashboardPadding[3]
  local label = sightexports.sGui:createGuiElement("label", x, y, 0, 0, groupPanel)
  sightexports.sGui:setLabelFont(label, groupFonts[4])
  sightexports.sGui:setLabelAlignment(label, "left", "top")
  sightexports.sGui:setLabelText(label, "Leader: ")
  memberLeaderLabel = sightexports.sGui:createGuiElement("label", x + sightexports.sGui:getLabelTextWidth(label), y, 0, 0, groupPanel)
  sightexports.sGui:setLabelFont(memberLeaderLabel, groupFonts[5])
  sightexports.sGui:setLabelAlignment(memberLeaderLabel, "left", "top")
  sightexports.sGui:setLabelColor(memberLeaderLabel, "sightgreen")
  y = y + sightexports.sGui:getLabelFontHeight(label) + dashboardPadding[3]
  local label = sightexports.sGui:createGuiElement("label", x, y, 0, 0, groupPanel)
  sightexports.sGui:setLabelFont(label, groupFonts[4])
  sightexports.sGui:setLabelAlignment(label, "left", "top")
  sightexports.sGui:setLabelText(label, "Utoljára online: ")
  memberLastOnlineLabel = sightexports.sGui:createGuiElement("label", x + sightexports.sGui:getLabelTextWidth(label), y, 0, 0, groupPanel)
  sightexports.sGui:setLabelFont(memberLastOnlineLabel, groupFonts[5])
  sightexports.sGui:setLabelAlignment(memberLastOnlineLabel, "left", "top")
  sightexports.sGui:setLabelColor(memberLastOnlineLabel, "sightblue")
  y = y + sightexports.sGui:getLabelFontHeight(label) + dashboardPadding[3]
  local label = sightexports.sGui:createGuiElement("label", x, y, 0, 0, groupPanel)
  sightexports.sGui:setLabelFont(label, groupFonts[4])
  sightexports.sGui:setLabelAlignment(label, "left", "top")
  sightexports.sGui:setLabelText(label, "Felvéve a frakcióba: ")
  memberAddedLabel = sightexports.sGui:createGuiElement("label", x + sightexports.sGui:getLabelTextWidth(label), y, 0, 0, groupPanel)
  sightexports.sGui:setLabelFont(memberAddedLabel, groupFonts[5])
  sightexports.sGui:setLabelAlignment(memberAddedLabel, "left", "top")
  sightexports.sGui:setLabelColor(memberAddedLabel, "sightblue")
  y = y + sightexports.sGui:getLabelFontHeight(label) + dashboardPadding[3]
  local label = sightexports.sGui:createGuiElement("label", x, y, 0, 0, groupPanel)
  sightexports.sGui:setLabelFont(label, groupFonts[4])
  sightexports.sGui:setLabelAlignment(label, "left", "top")
  sightexports.sGui:setLabelText(label, "Rang változtatva: ")
  memberPromotedLabel = sightexports.sGui:createGuiElement("label", x + sightexports.sGui:getLabelTextWidth(label), y, 0, 0, groupPanel)
  sightexports.sGui:setLabelFont(memberPromotedLabel, groupFonts[5])
  sightexports.sGui:setLabelAlignment(memberPromotedLabel, "left", "top")
  sightexports.sGui:setLabelColor(memberPromotedLabel, "sightblue")
  y = y + sightexports.sGui:getLabelFontHeight(label) + dashboardPadding[3] * 4
  local label = sightexports.sGui:createGuiElement("label", x, y, 0, 0, groupPanel)
  sightexports.sGui:setLabelFont(label, groupFonts[2])
  sightexports.sGui:setLabelAlignment(label, "left", "top")
  sightexports.sGui:setLabelText(label, "Tag jogosultságai:")
  y = y + sightexports.sGui:getLabelFontHeight(label) + dashboardPadding[3] * 2
  w = w - dashboardPadding[3] * 4 * 2
  local h = sy - y - dashboardPadding[3] * 4
  perMemberBg = sightexports.sGui:createGuiElement("rectangle", x, y, w, h, groupPanel)
  sightexports.sGui:setGuiBackground(perMemberBg, "solid", "sightgrey1")
  local sbg = sightexports.sGui:createGuiElement("rectangle", w - 2, 0, 2, h, perMemberBg)
  sightexports.sGui:setGuiBackground(sbg, "solid", "sightgrey3")
  perMemberScrollBar = sightexports.sGui:createGuiElement("rectangle", w - 2, 0, 2, h, perMemberBg)
  sightexports.sGui:setGuiBackground(perMemberScrollBar, "solid", "sightmidgrey")
  local n = math.floor(h / 32)
  h = h / n
  perMemberPermissions = {}
  for i = 1, n do
    perMemberPermissions[i] = {}
    local image = sightexports.sGui:createGuiElement("image", x + dashboardPadding[3], y + dashboardPadding[3] * 2, h - dashboardPadding[3] * 4, h - dashboardPadding[3] * 4, groupPanel)
    perMemberPermissions[i][1] = image
    local label = sightexports.sGui:createGuiElement("label", x + h - dashboardPadding[3] * 2, y, 0, h, groupPanel)
    sightexports.sGui:setLabelFont(label, groupFonts[4])
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    perMemberPermissions[i][2] = label
    if i < n then
      local border = sightexports.sGui:createGuiElement("hr", x, y + h - 1, w - 2, 2, groupPanel)
      sightexports.sGui:setGuiHrColor(border, "sightgrey3", "sightgrey2")
      perMemberPermissions[i][3] = border
    end
    y = y + h
  end
  refreshGroupMemberList()
  processSelectedMember()
end
function processSelectedRank()
  rankPermScroll = 0
  rankPermissionEdit = false
  if rankPermissionEditButton then
    sightexports.sGui:setImageFile(rankPermissionEditButton, sightexports.sGui:getFaIconFilename("pen", 32))
    sightexports.sGui:setClickEvent(rankPermissionEditButton, "editRankPermissions")
  end
  if selectedRank and groupDatas[selectedGroup].ranks[selectedRank] then
    sightexports.sGui:setGuiRenderDisabled(rankEditButton, false)
    sightexports.sGui:setLabelText(rankNameLabel, "[" .. selectedRank .. "] " .. groupDatas[selectedGroup].ranks[selectedRank])
    sightexports.sGui:setLabelColor(rankNameLabel, "sight" .. (groupDatas[selectedGroup].rankColors[selectedRank] or "blue"))
    if rankEditButton and rankDeleteButton and rankUpButton and rankDownButton then
      if #groupDatas[selectedGroup].ranks > 1 then
        sightexports.sGui:setGuiRenderDisabled(rankDeleteButton, false)
      else
        sightexports.sGui:setGuiRenderDisabled(rankDeleteButton, true)
      end
      local x = sightexports.sGui:getGuiPosition(rankNameLabel)
      local w = sightexports.sGui:getLabelTextWidth(rankNameLabel)
      local h = sightexports.sGui:getLabelFontHeight(rankNameLabel) * 0.75
      sightexports.sGui:setGuiPosition(rankEditButton, x + w + dashboardPadding[3], false)
      sightexports.sGui:setGuiPosition(rankDeleteButton, x + w + dashboardPadding[3] + h, false)
      if 1 < selectedRank then
        x = x + h
        sightexports.sGui:setGuiPosition(rankUpButton, x + w + dashboardPadding[3] + h, false)
        sightexports.sGui:setGuiRenderDisabled(rankUpButton, false)
      else
        sightexports.sGui:setGuiRenderDisabled(rankUpButton, true)
      end
      if selectedRank < #groupDatas[selectedGroup].ranks then
        x = x + h
        sightexports.sGui:setGuiPosition(rankDownButton, x + w + dashboardPadding[3] + h, false)
        sightexports.sGui:setGuiRenderDisabled(rankDownButton, false)
      else
        sightexports.sGui:setGuiRenderDisabled(rankDownButton, true)
      end
    end
    sightexports.sGui:setLabelText(rankSalaryLabel, sightexports.sGui:thousandsStepper(groupDatas[selectedGroup].salaries[selectedRank] or 0) .. " $")
    local rankNum = 0
    for i = 1, #groupDatas[selectedGroup].members do
      if groupDatas[selectedGroup].members[i] and groupDatas[selectedGroup].members[i][2] == selectedRank then
        rankNum = rankNum + 1
      end
    end
    rankPermissionsData = {}
    for perm in pairs(groupDatas[selectedGroup].permissions) do
      table.insert(rankPermissionsData, {
        "permission",
        sightexports.sGroups:getPermissionName(perm),
        groupDatas[selectedGroup].rankPermissions[selectedRank][perm],
        perm
      })
    end
    for skin = 1, groupDatas[selectedGroup].skins do
      table.insert(rankPermissionsData, {
        "skin",
        sightexports.sGroups:getDutySkinName(selectedGroup, skin),
        groupDatas[selectedGroup].rankSkins[selectedRank][skin],
        skin
      })
    end
    for item, v in pairs(groupDatas[selectedGroup].items) do
      if 1 < v[1] then
        table.insert(rankPermissionsData, {
          "item",
          v[1] .. "db " .. sightexports.sItems:getItemName(item) .. " (" .. sightexports.sGui:thousandsStepper(sightexports.sGroups:getDutyItemPrice(selectedGroup, item)) .. " $/db)",
          groupDatas[selectedGroup].rankItems[selectedRank][item],
          item
        })
      else
        table.insert(rankPermissionsData, {
          "item",
          sightexports.sItems:getItemName(item) .. " (" .. sightexports.sGui:thousandsStepper(sightexports.sGroups:getDutyItemPrice(selectedGroup, item)) .. " $/db)",
          groupDatas[selectedGroup].rankItems[selectedRank][item],
          item
        })
      end
    end
    table.sort(rankPermissionsData, sortPermissionDataEx)
    processPerRankpermissionList()
    sightexports.sGui:setLabelText(rankNumLabel, rankNum)
  else
    if rankDeleteButton then
      sightexports.sGui:setGuiRenderDisabled(rankDeleteButton, true)
    end
    if rankEditButton then
      sightexports.sGui:setGuiRenderDisabled(rankEditButton, true)
    end
    sightexports.sGui:setLabelText(rankNameLabel, "Válassz rangot!")
    sightexports.sGui:setLabelText(rankSalaryLabel, "")
    sightexports.sGui:setLabelText(rankNumLabel, "")
    for i = 1, #perRankPermission do
      sightexports.sGui:setGuiRenderDisabled(perRankPermission[i][1], true)
      sightexports.sGui:setGuiRenderDisabled(perRankPermission[i][2], true)
      sightexports.sGui:setGuiRenderDisabled(perRankPermission[i][3], true)
      if perRankPermission[i][4] then
        sightexports.sGui:setGuiRenderDisabled(perRankPermission[i][4], true)
      end
    end
  end
end
addEvent("doneRankPermission", false)
addEventHandler("doneRankPermission", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  sightexports.sGui:deleteGuiElement(el)
  local permissions = {}
  local items = {}
  local skins = {}
  for i = 1, #rankPermissionsData do
    if rankPermissionsData[i][3] then
      if rankPermissionsData[i][1] == "permission" then
        table.insert(permissions, rankPermissionsData[i][4])
      elseif rankPermissionsData[i][1] == "skin" then
        table.insert(skins, rankPermissionsData[i][4])
      elseif rankPermissionsData[i][1] == "item" then
        table.insert(items, rankPermissionsData[i][4])
      end
    end
  end
  createGroupLoader()
  triggerLatentServerEvent("refreshRankPermissions", localPlayer, selectedGroup, selectedRank, permissions, items, skins)
end)
addEvent("editRankPermissions", false)
addEventHandler("editRankPermissions", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  if selectedRank and groupDatas[selectedGroup].ranks[selectedRank] then
    sightexports.sGui:setImageFile(rankPermissionEditButton, sightexports.sGui:getFaIconFilename("save", 32))
    sightexports.sGui:setClickEvent(rankPermissionEditButton, "doneRankPermission")
    rankPermissionEdit = true
    table.sort(rankPermissionsData, sortPermissionData)
    processPerRankpermissionList()
  end
end)
addEvent("selectRankPermissionCheckbox", false)
addEventHandler("selectRankPermissionCheckbox", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  for i = 1, #perRankPermission do
    if rankPermissionsData[i + rankPermScroll] then
      rankPermissionsData[i + rankPermScroll][3] = sightexports.sGui:isCheckboxChecked(perRankPermission[i][3])
    end
  end
  processPerRankpermissionList()
end)
function processPerRankpermissionList()
  local w, h = sightexports.sGui:getGuiSize(rankPermBg)
  local n = math.max(0, #rankPermissionsData - #perRankPermission)
  h = h / (n + 1)
  if n < rankPermScroll then
    rankPermScroll = n
  end
  sightexports.sGui:setGuiSize(rankPermScrollbar, false, h)
  sightexports.sGui:setGuiPosition(rankPermScrollbar, false, h * rankPermScroll)
  for i = 1, #perRankPermission do
    if rankPermissionsData[i + rankPermScroll] then
      sightexports.sGui:setGuiRenderDisabled(perRankPermission[i][1], false)
      sightexports.sGui:setGuiRenderDisabled(perRankPermission[i][2], false)
      local hex = rankPermissionsData[i + rankPermScroll][3] and "#ffffff" or ""
      if rankPermissionsData[i + rankPermScroll][1] == "skin" then
        sightexports.sGui:setImageFile(perRankPermission[i][1], sightexports.sGui:getFaIconFilename("user-tie", 32))
        sightexports.sGui:setLabelText(perRankPermission[i][2], "Skin " .. hex .. rankPermissionsData[i + rankPermScroll][2])
      elseif rankPermissionsData[i + rankPermScroll][1] == "item" then
        sightexports.sGui:setImageFile(perRankPermission[i][1], sightexports.sGui:getFaIconFilename("box", 32))
        sightexports.sGui:setLabelText(perRankPermission[i][2], "Duty item " .. hex .. rankPermissionsData[i + rankPermScroll][2])
      elseif rankPermissionsData[i + rankPermScroll][1] == "permission" then
        sightexports.sGui:setImageFile(perRankPermission[i][1], sightexports.sGui:getFaIconFilename("bolt", 32))
        sightexports.sGui:setLabelText(perRankPermission[i][2], "Jog " .. hex .. rankPermissionsData[i + rankPermScroll][2])
      end
      if not rankPermissionsData[i + rankPermScroll][3] then
        sightexports.sGui:setImageColor(perRankPermission[i][1], "sightmidgrey")
        sightexports.sGui:setLabelColor(perRankPermission[i][2], "sightmidgrey")
      elseif rankPermissionsData[i + rankPermScroll][1] == "skin" then
        sightexports.sGui:setImageColor(perRankPermission[i][1], "sightpurple")
        sightexports.sGui:setLabelColor(perRankPermission[i][2], "sightpurple")
      elseif rankPermissionsData[i + rankPermScroll][1] == "item" then
        sightexports.sGui:setImageColor(perRankPermission[i][1], "sightorange")
        sightexports.sGui:setLabelColor(perRankPermission[i][2], "sightorange")
      elseif rankPermissionsData[i + rankPermScroll][1] == "permission" then
        sightexports.sGui:setImageColor(perRankPermission[i][1], "sightyellow")
        sightexports.sGui:setLabelColor(perRankPermission[i][2], "sightyellow")
      end
      if perRankPermission[i][4] then
        sightexports.sGui:setGuiRenderDisabled(perRankPermission[i][4], false)
      end
      if rankPermissionEdit then
        sightexports.sGui:setGuiRenderDisabled(perRankPermission[i][3], false)
        sightexports.sGui:setCheckboxChecked(perRankPermission[i][3], rankPermissionsData[i + rankPermScroll][3])
      else
        sightexports.sGui:setGuiRenderDisabled(perRankPermission[i][3], true)
      end
    else
      sightexports.sGui:setGuiRenderDisabled(perRankPermission[i][1], true)
      sightexports.sGui:setGuiRenderDisabled(perRankPermission[i][2], true)
      sightexports.sGui:setGuiRenderDisabled(perRankPermission[i][3], true)
      if perRankPermission[i][4] then
        sightexports.sGui:setGuiRenderDisabled(perRankPermission[i][4], true)
      end
    end
  end
end
addEvent("selectGroupRank", false)
addEventHandler("selectGroupRank", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  for i = 1, #rankElements do
    if rankElements[i][1] == el then
      selectedRank = i + rankScroll
      processRanksList()
      processSelectedRank()
      return
    end
  end
end)
addEvent("selectRankColor", false)
addEventHandler("selectRankColor", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  if rankEditColorElements[el] then
    rankEditColor = rankEditColorElements[el]
    sightexports.sGui:setInputColor(rankNameInput, "sightmidgrey", "sightgrey2", "sightgrey4", "sightgrey3", "sight" .. rankEditColor)
  end
end)
addEvent("newGroupRank", false)
addEventHandler("newGroupRank", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  createGroupLoader()
  triggerServerEvent("createNewGroupRank", localPlayer, selectedGroup)
end)
addEvent("moveRankUp", false)
addEventHandler("moveRankUp", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  if groupDatas[selectedGroup] and groupDatas[selectedGroup].ranks[selectedRank] then
    createGroupLoader()
    triggerServerEvent("moveRankUp", localPlayer, selectedGroup, selectedRank)
    selectedRank = selectedRank - 1
  end
end)
addEvent("moveRankDown", false)
addEventHandler("moveRankDown", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  if groupDatas[selectedGroup] and groupDatas[selectedGroup].ranks[selectedRank] then
    createGroupLoader()
    triggerServerEvent("moveRankDown", localPlayer, selectedGroup, selectedRank)
    selectedRank = selectedRank + 1
  end
end)
addEvent("finalDeleteGroupRank", false)
addEventHandler("finalDeleteGroupRank", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  if groupDatas[selectedGroup] and groupDatas[selectedGroup].ranks[selectedRank] then
    createGroupLoader()
    triggerServerEvent("deleteGroupRank", localPlayer, selectedGroup, selectedRank)
    selectedRank = 1
  end
end)
addEvent("deleteGroupRank", false)
addEventHandler("deleteGroupRank", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  if groupDatas[selectedGroup] and groupDatas[selectedGroup].ranks[selectedRank] then
    groupModal = sightexports.sGui:createGuiElement("rectangle", 0, 0, screenX, screenY)
    sightexports.sGui:setGuiBackground(groupModal, "solid", {
      0,
      0,
      0,
      150
    })
    sightexports.sGui:setGuiHover(groupModal, "none")
    sightexports.sGui:setGuiHoverable(groupModal, true)
    sightexports.sGui:disableClickTrough(groupModal, true)
    sightexports.sGui:disableLinkCursor(groupModal, true)
    local titlebarHeight = sightexports.sGui:getTitleBarHeight()
    local panelWidth = 375
    local pad = dashboardPadding[3] * 2
    local panelHeight = titlebarHeight + 96
    local window = sightexports.sGui:createGuiElement("window", screenX / 2 - panelWidth / 2, -panelHeight, panelWidth, panelHeight, groupModal)
    sightexports.sGui:setWindowTitle(window, "16/BebasNeueRegular.otf", "'" .. (groupDatas[selectedGroup].ranks[selectedRank] or "N/A") .. "' rang törlése")
    local label = sightexports.sGui:createGuiElement("label", pad, titlebarHeight, panelWidth - pad, panelHeight - titlebarHeight - 24 - pad, window)
    sightexports.sGui:setLabelFont(label, groupFonts[6])
    sightexports.sGui:setLabelAlignment(label, "center", "center")
    sightexports.sGui:setLabelText(label, "Biztosan törölni szeretnéd a rangot?")
    local w = (panelWidth - pad * 3) / 2
    local btn = sightexports.sGui:createGuiElement("button", pad, panelHeight - 24 - pad, w, 24, window)
    sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
    sightexports.sGui:setGuiHover(btn, "gradient", {
      "sightgreen",
      "sightgreen-second"
    }, false, true)
    sightexports.sGui:setButtonFont(btn, groupFonts[1])
    sightexports.sGui:setButtonText(btn, "Igen")
    sightexports.sGui:setClickEvent(btn, "finalDeleteGroupRank")
    local btn = sightexports.sGui:createGuiElement("button", pad + w + pad, panelHeight - 24 - pad, w, 24, window)
    sightexports.sGui:setGuiBackground(btn, "solid", "sightred")
    sightexports.sGui:setGuiHover(btn, "gradient", {
      "sightred",
      "sightred-second"
    }, false, true)
    sightexports.sGui:setButtonFont(btn, groupFonts[1])
    sightexports.sGui:setButtonText(btn, "Nem")
    sightexports.sGui:setClickEvent(btn, "closeGroupModal")
    sightexports.sGui:setGuiPositionAnimated(window, false, screenY / 2 - panelHeight / 2, 250)
  end
end)
addEvent("doneEditingGroupRank", false)
addEventHandler("doneEditingGroupRank", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  local rankName = sightexports.sGui:getInputValue(rankNameInput) or ""
  local rankSalary = tonumber(sightexports.sGui:getInputValue(rankSalaryInput)) or 0
  if 100000 < rankSalary then
    sightexports.sGui:showInfobox("e", "Maximum fizetés: 100 000 $!")
  end
  if rankSalary and 0 <= rankSalary and rankSalary <= 100000 and rankName then
    createGroupLoader()
    triggerServerEvent("editGroupRank", localPlayer, selectedGroup, selectedRank, rankName, rankSalary, rankEditColor)
  end
end)
addEvent("editGroupRank", false)
addEventHandler("editGroupRank", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  if groupDatas[selectedGroup] and groupDatas[selectedGroup].ranks[selectedRank] then
    groupModal = sightexports.sGui:createGuiElement("rectangle", 0, 0, screenX, screenY)
    sightexports.sGui:setGuiBackground(groupModal, "solid", {
      0,
      0,
      0,
      150
    })
    sightexports.sGui:setGuiHover(groupModal, "none")
    sightexports.sGui:setGuiHoverable(groupModal, true)
    sightexports.sGui:disableClickTrough(groupModal, true)
    sightexports.sGui:disableLinkCursor(groupModal, true)
    local titlebarHeight = sightexports.sGui:getTitleBarHeight()
    local panelWidth = 375
    local pad = dashboardPadding[3] * 2
    local rankColorList = sightexports.sGroups:getRankColorList()
    local w = (panelWidth - pad) / #rankColorList
    local panelHeight = titlebarHeight + pad + (30 + pad) * 2 + w + 24 + pad
    local window = sightexports.sGui:createGuiElement("window", screenX / 2 - panelWidth / 2, -panelHeight, panelWidth, panelHeight, groupModal)
    sightexports.sGui:setWindowTitle(window, "16/BebasNeueRegular.otf", "'" .. (groupDatas[selectedGroup].ranks[selectedRank] or "N/A") .. "' rang szerkesztése")
    sightexports.sGui:setWindowCloseButton(window, "closeGroupModal")
    rankEditColor = groupDatas[selectedGroup].rankColors[selectedRank] or "blue"
    local y = titlebarHeight + pad
    rankNameInput = sightexports.sGui:createGuiElement("input", pad, y, panelWidth - pad * 2, 30, window)
    sightexports.sGui:setInputColor(rankNameInput, "sightmidgrey", "sightgrey2", "sightgrey4", "sightgrey3", "sight" .. rankEditColor)
    sightexports.sGui:setInputPlaceholder(rankNameInput, "Rang neve")
    sightexports.sGui:setInputMaxLength(rankNameInput, 24)
    sightexports.sGui:setInputIcon(rankNameInput, "id-badge")
    sightexports.sGui:setInputValue(rankNameInput, groupDatas[selectedGroup].ranks[selectedRank] or "N/A")
    y = y + 30 + pad
    rankEditColorElements = {}
    for i = 1, #rankColorList do
      local rect = sightexports.sGui:createGuiElement("rectangle", pad + (i - 1) * w, y, w - pad, w - pad, window)
      sightexports.sGui:setGuiBackground(rect, "solid", "sight" .. rankColorList[i])
      sightexports.sGui:setGuiHover(rect, "none", false, false, true)
      sightexports.sGui:setGuiHoverable(rect, true)
      sightexports.sGui:setClickEvent(rect, "selectRankColor")
      rankEditColorElements[rect] = rankColorList[i]
    end
    y = y + w
    rankSalaryInput = sightexports.sGui:createGuiElement("input", pad, y, panelWidth - pad * 2, 30, window)
    sightexports.sGui:setInputColor(rankSalaryInput, "sightmidgrey", "sightgrey2", "sightgrey4", "sightgrey3", "sightgreen")
    sightexports.sGui:setInputPlaceholder(rankSalaryInput, "Fizetés (Max. 100 000 $)")
    sightexports.sGui:setInputMaxLength(rankSalaryInput, 20)
    sightexports.sGui:setInputIcon(rankSalaryInput, "dollar-sign")
    sightexports.sGui:setInputValue(rankSalaryInput, groupDatas[selectedGroup].salaries[selectedRank] or 0)
    sightexports.sGui:setInputNumberOnly(rankSalaryInput, true)
    y = y + 30 + pad
    local btn = sightexports.sGui:createGuiElement("button", pad, y, panelWidth - pad * 2, 24, window)
    sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
    sightexports.sGui:setGuiHover(btn, "gradient", {
      "sightgreen",
      "sightgreen-second"
    }, false, true)
    sightexports.sGui:setButtonFont(btn, groupFonts[1])
    sightexports.sGui:setButtonText(btn, "Szerkesztés")
    sightexports.sGui:setClickEvent(btn, "doneEditingGroupRank")
    sightexports.sGui:setGuiPositionAnimated(window, false, screenY / 2 - panelHeight / 2, 250)
  end
end)
function processRanksList()
  local w, h = sightexports.sGui:getGuiSize(rankBg)
  local n = math.max(0, #groupDatas[selectedGroup].ranks - #rankElements)
  h = h / (n + 1)
  if n < rankScroll then
    rankScroll = n
  end
  sightexports.sGui:setGuiSize(rankScrollbar, false, h)
  sightexports.sGui:setGuiPosition(rankScrollbar, false, h * rankScroll)
  for i = 1, #rankElements do
    if groupDatas[selectedGroup].ranks[i + rankScroll] then
      local rect = rankElements[i][1]
      if i + rankScroll == selectedRank then
        sightexports.sGui:setGuiHoverable(rect, false)
        sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey3")
      else
        sightexports.sGui:setGuiHoverable(rect, true)
        sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey1")
      end
      local label = rankElements[i][2]
      sightexports.sGui:setLabelColor(label, "sight" .. (groupDatas[selectedGroup].rankColors[i + rankScroll] or "blue"))
      sightexports.sGui:setLabelText(label, "[" .. i + rankScroll .. "] " .. groupDatas[selectedGroup].ranks[i + rankScroll])
      local label = rankElements[i][3]
      sightexports.sGui:setLabelText(label, sightexports.sGui:thousandsStepper(groupDatas[selectedGroup].salaries[i + rankScroll] or 0) .. " $")
    end
  end
end
function drawGroupRanks()
  local label = sightexports.sGui:createGuiElement("label", dashboardPadding[3] * 4, 40, 0, 48, groupPanel)
  sightexports.sGui:setLabelFont(label, groupFonts[3])
  sightexports.sGui:setLabelAlignment(label, "left", "center")
  sightexports.sGui:setLabelText(label, "Rangok: " .. #groupDatas[selectedGroup].ranks .. "/" .. sightexports.sGroups:getMaxRanks(selectedGroup))
  if groupDatas[selectedGroup].isLeader and #groupDatas[selectedGroup].ranks < sightexports.sGroups:getMaxRanks(selectedGroup) then
    local btn = sightexports.sGui:createGuiElement("button", dashboardPadding[3] * 4 + sightexports.sGui:getLabelTextWidth(label) + dashboardPadding[3] * 2, 52, 100, 24, groupPanel)
    sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
    sightexports.sGui:setGuiHover(btn, "gradient", {
      "sightgreen",
      "sightgreen-second"
    }, false, true)
    sightexports.sGui:setButtonFont(btn, groupFonts[1])
    sightexports.sGui:setButtonText(btn, "Új rang")
    sightexports.sGui:setClickEvent(btn, "newGroupRank")
  end
  local w = math.ceil((sx - menuW) * 0.45)
  local h = sy - 40 - dashboardPadding[3] * 8 - 48
  rankBg = sightexports.sGui:createGuiElement("rectangle", dashboardPadding[3] * 4, 88 + dashboardPadding[3] * 4, w, h, groupPanel)
  sightexports.sGui:setGuiBackground(rankBg, "solid", "sightgrey1")
  local sbg = sightexports.sGui:createGuiElement("rectangle", w - 2, 0, 2, h, rankBg)
  sightexports.sGui:setGuiBackground(sbg, "solid", "sightgrey3")
  rankScrollbar = sightexports.sGui:createGuiElement("rectangle", w - 2, 0, 2, h, rankBg)
  sightexports.sGui:setGuiBackground(rankScrollbar, "solid", "sightmidgrey")
  local n = math.floor(h / 32)
  h = h / n
  rankElements = {}
  y = 0
  for i = 1, n do
    if groupDatas[selectedGroup].ranks[i] then
      rankElements[i] = {}
      local rect = sightexports.sGui:createGuiElement("rectangle", 0, y, w - 2, h - 1, rankBg)
      sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey1")
      sightexports.sGui:setGuiHover(rect, "gradient", {"sightgrey1", "sightgrey2"}, false, true)
      sightexports.sGui:setGuiHoverable(rect, true)
      sightexports.sGui:setClickEvent(rect, "selectGroupRank")
      rankElements[i][1] = rect
      local label = sightexports.sGui:createGuiElement("label", dashboardPadding[3] * 2, 0, 0, h, rect)
      sightexports.sGui:setLabelFont(label, groupFonts[4])
      sightexports.sGui:setLabelAlignment(label, "left", "center")
      rankElements[i][2] = label
      local label = sightexports.sGui:createGuiElement("label", 0, 0, w - dashboardPadding[3] * 2, h, rect)
      sightexports.sGui:setLabelFont(label, groupFonts[5])
      sightexports.sGui:setLabelColor(label, "sightgreen")
      sightexports.sGui:setLabelAlignment(label, "right", "center")
      rankElements[i][3] = label
      if i < n then
        local border = sightexports.sGui:createGuiElement("hr", 0, h - 1, w - 2, 2, rect)
        sightexports.sGui:setGuiHrColor(border, "sightgrey3", "sightgrey2")
      end
    end
    y = y + h
  end
  x = dashboardPadding[3] * 4 + w
  y = 88 + dashboardPadding[3] * 4
  local w = sx - menuW - x
  x = x + dashboardPadding[3] * 4
  rankNameLabel = sightexports.sGui:createGuiElement("label", x, y, w, 0, groupPanel)
  sightexports.sGui:setLabelFont(rankNameLabel, groupFonts[3])
  sightexports.sGui:setLabelAlignment(rankNameLabel, "left", "top")
  local h = sightexports.sGui:getLabelFontHeight(rankNameLabel)
  if groupDatas[selectedGroup].isLeader then
    local ih = h * 0.75
    rankEditButton = sightexports.sGui:createGuiElement("image", x, y + h / 2 - ih / 2, ih, ih, groupPanel)
    sightexports.sGui:setImageFile(rankEditButton, sightexports.sGui:getFaIconFilename("pen", h))
    sightexports.sGui:setGuiHover(rankEditButton, "solid", "sightgreen")
    sightexports.sGui:setGuiHoverable(rankEditButton, true)
    sightexports.sGui:setClickEvent(rankEditButton, "editGroupRank")
    sightexports.sGui:guiSetTooltip(rankEditButton, "Rang szerkesztése")
    rankDeleteButton = sightexports.sGui:createGuiElement("image", x, y + h / 2 - ih / 2, ih, ih, groupPanel)
    sightexports.sGui:setImageFile(rankDeleteButton, sightexports.sGui:getFaIconFilename("trash-alt", h))
    sightexports.sGui:setGuiHover(rankDeleteButton, "solid", "sightred")
    sightexports.sGui:setGuiHoverable(rankDeleteButton, true)
    sightexports.sGui:setClickEvent(rankDeleteButton, "deleteGroupRank")
    sightexports.sGui:guiSetTooltip(rankDeleteButton, "Rang törlése")
    rankUpButton = sightexports.sGui:createGuiElement("image", x, y + h / 2 - ih / 2, ih, ih, groupPanel)
    sightexports.sGui:setImageFile(rankUpButton, sightexports.sGui:getFaIconFilename("level-up-alt", h))
    sightexports.sGui:setGuiHover(rankUpButton, "solid", "sightgreen")
    sightexports.sGui:setGuiHoverable(rankUpButton, true)
    sightexports.sGui:setClickEvent(rankUpButton, "moveRankUp")
    sightexports.sGui:guiSetTooltip(rankUpButton, "Rang fentebb mozgatása")
    rankDownButton = sightexports.sGui:createGuiElement("image", x, y + h / 2 - ih / 2, ih, ih, groupPanel)
    sightexports.sGui:setImageFile(rankDownButton, sightexports.sGui:getFaIconFilename("level-down-alt", h))
    sightexports.sGui:setGuiHover(rankDownButton, "solid", "sightgreen")
    sightexports.sGui:setGuiHoverable(rankDownButton, true)
    sightexports.sGui:setClickEvent(rankDownButton, "moveRankDown")
    sightexports.sGui:guiSetTooltip(rankDownButton, "Rang lentebb mozgatása")
  else
    rankEditButton = false
    rankDeleteButton = false
    rankUpButton = false
    rankDownButton = false
  end
  y = y + h + dashboardPadding[3] * 2
  local label = sightexports.sGui:createGuiElement("label", x, y, 0, 0, groupPanel)
  sightexports.sGui:setLabelFont(label, groupFonts[4])
  sightexports.sGui:setLabelAlignment(label, "left", "top")
  sightexports.sGui:setLabelText(label, "Fizetés: ")
  rankSalaryLabel = sightexports.sGui:createGuiElement("label", x + sightexports.sGui:getLabelTextWidth(label), y, 0, 0, groupPanel)
  sightexports.sGui:setLabelFont(rankSalaryLabel, groupFonts[5])
  sightexports.sGui:setLabelAlignment(rankSalaryLabel, "left", "top")
  sightexports.sGui:setLabelColor(rankSalaryLabel, "sightgreen")
  y = y + sightexports.sGui:getLabelFontHeight(label) + dashboardPadding[3]
  local label = sightexports.sGui:createGuiElement("label", x, y, 0, 0, groupPanel)
  sightexports.sGui:setLabelFont(label, groupFonts[4])
  sightexports.sGui:setLabelAlignment(label, "left", "top")
  sightexports.sGui:setLabelText(label, "Tagok száma: ")
  rankNumLabel = sightexports.sGui:createGuiElement("label", x + sightexports.sGui:getLabelTextWidth(label), y, 0, 0, groupPanel)
  sightexports.sGui:setLabelFont(rankNumLabel, groupFonts[5])
  sightexports.sGui:setLabelAlignment(rankNumLabel, "left", "top")
  sightexports.sGui:setLabelColor(rankNumLabel, "sightgreen")
  y = y + sightexports.sGui:getLabelFontHeight(label) + dashboardPadding[3] * 4
  local label = sightexports.sGui:createGuiElement("label", x, y, 0, 0, groupPanel)
  sightexports.sGui:setLabelFont(label, groupFonts[2])
  sightexports.sGui:setLabelAlignment(label, "left", "top")
  sightexports.sGui:setLabelText(label, "Rang jogosultságai:")
  local h = sightexports.sGui:getLabelFontHeight(label)
  w = w - dashboardPadding[3] * 4 * 2
  if groupDatas[selectedGroup].isLeader then
    rankPermissionEditButton = sightexports.sGui:createGuiElement("image", x + w - h, y, h, h, groupPanel)
    sightexports.sGui:setImageFile(rankPermissionEditButton, sightexports.sGui:getFaIconFilename("pen", 32))
    sightexports.sGui:setGuiHover(rankPermissionEditButton, "solid", "sightgreen")
    sightexports.sGui:setGuiHoverable(rankPermissionEditButton, true)
    sightexports.sGui:setClickEvent(rankPermissionEditButton, "editRankPermissions")
    sightexports.sGui:guiSetTooltip(rankPermissionEditButton, "Rang jogosultságainak szerkesztése")
  else
    rankPermissionEditButton = false
  end
  y = y + h + dashboardPadding[3] * 2
  local h = sy - y - dashboardPadding[3] * 4
  rankPermBg = sightexports.sGui:createGuiElement("rectangle", x, y, w, h, groupPanel)
  sightexports.sGui:setGuiBackground(rankPermBg, "solid", "sightgrey1")
  local sbg = sightexports.sGui:createGuiElement("rectangle", w - 2, 0, 2, h, rankPermBg)
  sightexports.sGui:setGuiBackground(sbg, "solid", "sightgrey3")
  rankPermScrollbar = sightexports.sGui:createGuiElement("rectangle", w - 2, 0, 2, h, rankPermBg)
  sightexports.sGui:setGuiBackground(rankPermScrollbar, "solid", "sightmidgrey")
  local n = math.floor(h / 32)
  h = h / n
  perRankPermission = {}
  for i = 1, n do
    perRankPermission[i] = {}
    local image = sightexports.sGui:createGuiElement("image", x + dashboardPadding[3], y + dashboardPadding[3] * 2, h - dashboardPadding[3] * 4, h - dashboardPadding[3] * 4, groupPanel)
    perRankPermission[i][1] = image
    local label = sightexports.sGui:createGuiElement("label", x + h - dashboardPadding[3] * 2 - 2, y, 0, h, groupPanel)
    sightexports.sGui:setLabelFont(label, groupFonts[4])
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    perRankPermission[i][2] = label
    local checkbox = sightexports.sGui:createGuiElement("checkbox", x + w - h - 2, y + 2, h - 4, h - 4, groupPanel)
    sightexports.sGui:setGuiColorScheme(checkbox, "darker")
    sightexports.sGui:setClickEvent(checkbox, "selectRankPermissionCheckbox")
    perRankPermission[i][3] = checkbox
    if i < n then
      local border = sightexports.sGui:createGuiElement("hr", x, y + h - 1, w - 2, 2, groupPanel)
      sightexports.sGui:setGuiHrColor(border, "sightgrey3", "sightgrey2")
      perRankPermission[i][4] = border
    end
    y = y + h
  end
  processRanksList()
  processSelectedRank()
end
function processGroupSelectedVehicle()
  vehicleMemberEditing = false
  sightexports.sGui:setGuiBackground(vehicleMemberButton, "solid", "sightgreen")
  sightexports.sGui:setGuiHoverable(vehicleMemberButton, false)
  sightexports.sGui:setGuiBackground(vehicleDataButton, "solid", "sightgrey4")
  sightexports.sGui:setGuiHoverable(vehicleDataButton, true)
  sightexports.sGui:setGuiRenderDisabled(vehicleMemberBg, false, true)
  sightexports.sGui:setGuiRenderDisabled(vehicleDataBg, true, true)
  if selectedVehicle and groupDatas[selectedGroup].gotVehicles[selectedVehicle] then
    vehicleMemberList = {}
    for i = 1, #groupDatas[selectedGroup].members do
      if not groupDatas[selectedGroup].members[i][3] then
        table.insert(vehicleMemberList, {
          groupDatas[selectedGroup].members[i][7],
          groupDatas[selectedGroup].members[i][1],
          groupDatas[selectedGroup].members[i][2],
          groupDatas[selectedGroup].vehicleMembers[selectedVehicle][groupDatas[selectedGroup].members[i][8]]
        })
      end
    end
    table.sort(vehicleMemberList, groupVehicleMemberSort)
    local dat = groupDatas[selectedGroup].gotVehicles[selectedVehicle]
    if dat[4] then
      customName = sightexports.sVehiclenames:getCustomVehicleName(dat[4])
    end
    sightexports.sGui:setLabelText(vehicleNameLabel, "[" .. selectedVehicle .. "] " .. (customName or sightexports.sVehiclenames:getCustomVehicleName(dat[1])))
    local plate = dat[2] or ""
    local tmp = {}
    plate = split(plate, "-")
    for i = 1, #plate do
      if 1 <= utf8.len(plate[i]) then
        table.insert(tmp, plate[i])
      end
    end
    sightexports.sGui:setLabelText(vehiclePlateLabel, table.concat(tmp, "-"))
    processGroupVehicleMemberList()
  else
    sightexports.sGui:setLabelText(vehicleNameLabel, "Válassz járművet!")
    sightexports.sGui:setLabelText(vehiclePlateLabel, "")
    for i = 1, #vehicleMemberElements do
      sightexports.sGui:setGuiRenderDisabled(vehicleMemberElements[i][1], true)
      sightexports.sGui:setGuiRenderDisabled(vehicleMemberElements[i][2], true)
      if vehicleMemberElements[i][3] then
        sightexports.sGui:setGuiRenderDisabled(vehicleMemberElements[i][3], true)
      end
    end
  end
end
function processGroupVehicleList()
  local w, h = sightexports.sGui:getGuiSize(vehiclesBg)
  local n = math.max(0, #groupDatas[selectedGroup].vehicles - #vehicleElements)
  h = h / (n + 1)
  if n < vehiclesScroll then
    vehiclesScroll = n
  end
  sightexports.sGui:setGuiSize(vehiclesScrollBar, false, h)
  sightexports.sGui:setGuiPosition(vehiclesScrollBar, false, h * vehiclesScroll)
  for i = 1, #vehicleElements do
    if groupDatas[selectedGroup].vehicles[i + vehiclesScroll] then
      sightexports.sGui:setGuiRenderDisabled(vehicleElements[i][1], false)
      sightexports.sGui:setGuiRenderDisabled(vehicleElements[i][2], false)
      sightexports.sGui:setGuiRenderDisabled(vehicleElements[i][3], false)
      if vehicleElements[i][4] then
        sightexports.sGui:setGuiRenderDisabled(vehicleElements[i][4], false)
      end
      if not selectedVehicle then
        selectedVehicle = groupDatas[selectedGroup].vehicles[i + vehiclesScroll][1]
      end
      local rect = vehicleElements[i][1]
      if groupDatas[selectedGroup].vehicles[i + vehiclesScroll][1] == selectedVehicle then
        sightexports.sGui:setGuiHoverable(rect, true)
        sightexports.sGui:setGuiHover(rect, "solid", "sightgrey3", false, true)
        sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey3")
      else
        sightexports.sGui:setGuiHoverable(rect, true)
        sightexports.sGui:setGuiHover(rect, "gradient", {"sightgrey1", "sightgrey2"}, false, true)
        sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey1")
      end
      local label = vehicleElements[i][2]
      sightexports.sGui:setLabelText(label, "[" .. groupDatas[selectedGroup].vehicles[i + vehiclesScroll][1] .. "] " .. groupDatas[selectedGroup].vehicles[i + vehiclesScroll][2])
      sightexports.sGui:setLabelColor(label, groupDatas[selectedGroup].vehicles[i + vehiclesScroll][4] and "sightred-second" or "#ffffff")
      local label = vehicleElements[i][3]
      sightexports.sGui:setLabelText(label, groupDatas[selectedGroup].vehicles[i + vehiclesScroll][3])
    else
      sightexports.sGui:setGuiRenderDisabled(vehicleElements[i][1], true)
      sightexports.sGui:setGuiRenderDisabled(vehicleElements[i][2], true)
      sightexports.sGui:setGuiRenderDisabled(vehicleElements[i][3], true)
      if vehicleElements[i][4] then
        sightexports.sGui:setGuiRenderDisabled(vehicleElements[i][4], true)
      end
    end
  end
end
addEvent("selectGroupVehicle", false)
addEventHandler("selectGroupVehicle", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  if button == "right" and state == "down" then
    for i = 1, #vehicleElements do
      if vehicleElements[i][1] == el and groupDatas[selectedGroup].vehicles[i + vehiclesScroll] then
        triggerServerEvent("markVehicleOnGPS", localPlayer, groupDatas[selectedGroup].vehicles[i + vehiclesScroll][1])
        return
      end
    end
  else
    for i = 1, #vehicleElements do
      if vehicleElements[i][1] == el and groupDatas[selectedGroup].vehicles[i + vehiclesScroll] then
        selectedVehicle = groupDatas[selectedGroup].vehicles[i + vehiclesScroll][1]
        vehicleMemberScroll = 0
        processGroupVehicleList()
        processGroupSelectedVehicle()
        return
      end
    end
  end
end)
addEvent("setGroupVehicleDataPanel", false)
addEventHandler("setGroupVehicleDataPanel", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  sightexports.sGui:setGuiBackground(vehicleDataButton, "solid", "sightgreen")
  sightexports.sGui:setGuiHoverable(vehicleDataButton, false)
  sightexports.sGui:setGuiBackground(vehicleMemberButton, "solid", "sightgrey4")
  sightexports.sGui:setGuiHoverable(vehicleMemberButton, true)
  sightexports.sGui:setGuiRenderDisabled(vehicleDataBg, false, true)
  sightexports.sGui:setGuiRenderDisabled(vehicleMemberBg, true, true)
  sightexports.sGui:deleteAllChildren(vehicleDataBg)
  if selectedVehicle then
    createGroupLoader()
    triggerLatentServerEvent("requestVehicleGroupData", localPlayer, selectedGroup, selectedVehicle)
  end
end)
addEvent("gotGroupVehicleDatas", true)
addEventHandler("gotGroupVehicleDatas", getRootElement(), function(vehicleId, datas)
  deleteGroupLoader()
  if vehicleId == selectedVehicle and vehicleDataBg then
    sightexports.sGui:deleteAllChildren(vehicleDataBg)
    local x = dashboardPadding[3] * 2
    local y = dashboardPadding[3] * 2
    if datas.impounded then
      local label = sightexports.sGui:createGuiElement("label", x, y, 0, 0, vehicleDataBg)
      sightexports.sGui:setLabelFont(label, groupFonts[4])
      sightexports.sGui:setLabelAlignment(label, "left", "top")
      sightexports.sGui:setLabelText(label, "Lefoglalva: ")
      local label = sightexports.sGui:createGuiElement("label", x + sightexports.sGui:getLabelTextWidth(label), y, 0, 0, vehicleDataBg)
      sightexports.sGui:setLabelFont(label, groupFonts[5])
      sightexports.sGui:setLabelAlignment(label, "left", "top")
      sightexports.sGui:setLabelText(label, getVehLabelValue(datas, "impounded"))
      y = y + sightexports.sGui:getLabelFontHeight(label) + dashboardPadding[3]
    end
    if datas.inService then
      local label = sightexports.sGui:createGuiElement("label", x, y, 0, 0, vehicleDataBg)
      sightexports.sGui:setLabelFont(label, groupFonts[4])
      sightexports.sGui:setLabelAlignment(label, "left", "top")
      sightexports.sGui:setLabelText(label, "Motor szerviz: ")
      local label = sightexports.sGui:createGuiElement("label", x + sightexports.sGui:getLabelTextWidth(label), y, 0, 0, vehicleDataBg)
      sightexports.sGui:setLabelFont(label, groupFonts[5])
      sightexports.sGui:setLabelAlignment(label, "left", "top")
      sightexports.sGui:setLabelText(label, getVehLabelValue(datas, "inService"))
      y = y + sightexports.sGui:getLabelFontHeight(label) + dashboardPadding[3]
    end
    local label = sightexports.sGui:createGuiElement("label", x, y, 0, 0, vehicleDataBg)
    sightexports.sGui:setLabelFont(label, groupFonts[4])
    sightexports.sGui:setLabelAlignment(label, "left", "top")
    sightexports.sGui:setLabelText(label, "Motor: ")
    local label = sightexports.sGui:createGuiElement("label", x + sightexports.sGui:getLabelTextWidth(label), y, 0, 0, vehicleDataBg)
    sightexports.sGui:setLabelFont(label, groupFonts[5])
    sightexports.sGui:setLabelAlignment(label, "left", "top")
    sightexports.sGui:setLabelText(label, getVehLabelValue(datas, "engine"))
    y = y + sightexports.sGui:getLabelFontHeight(label) + dashboardPadding[3]
    local label = sightexports.sGui:createGuiElement("label", x, y, 0, 0, vehicleDataBg)
    sightexports.sGui:setLabelFont(label, groupFonts[4])
    sightexports.sGui:setLabelAlignment(label, "left", "top")
    sightexports.sGui:setLabelText(label, "Akkumulátor: ")
    local label = sightexports.sGui:createGuiElement("label", x + sightexports.sGui:getLabelTextWidth(label), y, 0, 0, vehicleDataBg)
    sightexports.sGui:setLabelFont(label, groupFonts[5])
    sightexports.sGui:setLabelAlignment(label, "left", "top")
    sightexports.sGui:setLabelText(label, getVehLabelValue(datas, "battery"))
    y = y + sightexports.sGui:getLabelFontHeight(label) + dashboardPadding[3]
    local label = sightexports.sGui:createGuiElement("label", x, y, 0, 0, vehicleDataBg)
    sightexports.sGui:setLabelFont(label, groupFonts[4])
    sightexports.sGui:setLabelAlignment(label, "left", "top")
    sightexports.sGui:setLabelText(label, "Kilóméteróra állása: ")
    local label = sightexports.sGui:createGuiElement("label", x + sightexports.sGui:getLabelTextWidth(label), y, 0, 0, vehicleDataBg)
    sightexports.sGui:setLabelFont(label, groupFonts[5])
    sightexports.sGui:setLabelAlignment(label, "left", "top")
    sightexports.sGui:setLabelText(label, getVehLabelValue(datas, "odometer"))
    y = y + sightexports.sGui:getLabelFontHeight(label) + dashboardPadding[3]
    local label = sightexports.sGui:createGuiElement("label", x, y, 0, 0, vehicleDataBg)
    sightexports.sGui:setLabelFont(label, groupFonts[4])
    sightexports.sGui:setLabelAlignment(label, "left", "top")
    sightexports.sGui:setLabelText(label, "Üzemanyag: ")
    local label = sightexports.sGui:createGuiElement("label", x + sightexports.sGui:getLabelTextWidth(label), y, 0, 0, vehicleDataBg)
    sightexports.sGui:setLabelFont(label, groupFonts[5])
    sightexports.sGui:setLabelAlignment(label, "left", "top")
    sightexports.sGui:setLabelText(label, getVehLabelValue(datas, "fuel"))
    y = y + sightexports.sGui:getLabelFontHeight(label) + dashboardPadding[3]
    local label = sightexports.sGui:createGuiElement("label", x, y, 0, 0, vehicleDataBg)
    sightexports.sGui:setLabelFont(label, groupFonts[4])
    sightexports.sGui:setLabelAlignment(label, "left", "top")
    sightexports.sGui:setLabelText(label, "Meghajtás: ")
    local label = sightexports.sGui:createGuiElement("label", x + sightexports.sGui:getLabelTextWidth(label), y, 0, 0, vehicleDataBg)
    sightexports.sGui:setLabelFont(label, groupFonts[5])
    sightexports.sGui:setLabelAlignment(label, "left", "top")
    sightexports.sGui:setLabelText(label, getVehLabelValue(datas, "driveType"))
    y = y + sightexports.sGui:getLabelFontHeight(label) + dashboardPadding[3]
    local label = sightexports.sGui:createGuiElement("label", x, y, 0, 0, vehicleDataBg)
    sightexports.sGui:setLabelFont(label, groupFonts[4])
    sightexports.sGui:setLabelAlignment(label, "left", "top")
    sightexports.sGui:setLabelText(label, "Motor: ")
    local label = sightexports.sGui:createGuiElement("label", x + sightexports.sGui:getLabelTextWidth(label), y, 0, 0, vehicleDataBg)
    sightexports.sGui:setLabelFont(label, groupFonts[5])
    sightexports.sGui:setLabelAlignment(label, "left", "top")
    sightexports.sGui:setLabelText(label, getVehLabelValue(datas, "performance.engine"))
    y = y + sightexports.sGui:getLabelFontHeight(label) + dashboardPadding[3]
    local label = sightexports.sGui:createGuiElement("label", x, y, 0, 0, vehicleDataBg)
    sightexports.sGui:setLabelFont(label, groupFonts[4])
    sightexports.sGui:setLabelAlignment(label, "left", "top")
    sightexports.sGui:setLabelText(label, "Turbó: ")
    local label = sightexports.sGui:createGuiElement("label", x + sightexports.sGui:getLabelTextWidth(label), y, 0, 0, vehicleDataBg)
    sightexports.sGui:setLabelFont(label, groupFonts[5])
    sightexports.sGui:setLabelAlignment(label, "left", "top")
    sightexports.sGui:setLabelText(label, getVehLabelValue(datas, "performance.turbo"))
    y = y + sightexports.sGui:getLabelFontHeight(label) + dashboardPadding[3]
    local label = sightexports.sGui:createGuiElement("label", x, y, 0, 0, vehicleDataBg)
    sightexports.sGui:setLabelFont(label, groupFonts[4])
    sightexports.sGui:setLabelAlignment(label, "left", "top")
    sightexports.sGui:setLabelText(label, "ECU: ")
    local label = sightexports.sGui:createGuiElement("label", x + sightexports.sGui:getLabelTextWidth(label), y, 0, 0, vehicleDataBg)
    sightexports.sGui:setLabelFont(label, groupFonts[5])
    sightexports.sGui:setLabelAlignment(label, "left", "top")
    sightexports.sGui:setLabelText(label, getVehLabelValue(datas, "performance.ecu"))
    y = y + sightexports.sGui:getLabelFontHeight(label) + dashboardPadding[3]
    local label = sightexports.sGui:createGuiElement("label", x, y, 0, 0, vehicleDataBg)
    sightexports.sGui:setLabelFont(label, groupFonts[4])
    sightexports.sGui:setLabelAlignment(label, "left", "top")
    sightexports.sGui:setLabelText(label, "Váltó: ")
    local label = sightexports.sGui:createGuiElement("label", x + sightexports.sGui:getLabelTextWidth(label), y, 0, 0, vehicleDataBg)
    sightexports.sGui:setLabelFont(label, groupFonts[5])
    sightexports.sGui:setLabelAlignment(label, "left", "top")
    sightexports.sGui:setLabelText(label, getVehLabelValue(datas, "performance.transmission"))
    y = y + sightexports.sGui:getLabelFontHeight(label) + dashboardPadding[3]
    local label = sightexports.sGui:createGuiElement("label", x, y, 0, 0, vehicleDataBg)
    sightexports.sGui:setLabelFont(label, groupFonts[4])
    sightexports.sGui:setLabelAlignment(label, "left", "top")
    sightexports.sGui:setLabelText(label, "Felfüggesztés: ")
    local label = sightexports.sGui:createGuiElement("label", x + sightexports.sGui:getLabelTextWidth(label), y, 0, 0, vehicleDataBg)
    sightexports.sGui:setLabelFont(label, groupFonts[5])
    sightexports.sGui:setLabelAlignment(label, "left", "top")
    sightexports.sGui:setLabelText(label, getVehLabelValue(datas, "performance.suspension"))
    y = y + sightexports.sGui:getLabelFontHeight(label) + dashboardPadding[3]
    local label = sightexports.sGui:createGuiElement("label", x, y, 0, 0, vehicleDataBg)
    sightexports.sGui:setLabelFont(label, groupFonts[4])
    sightexports.sGui:setLabelAlignment(label, "left", "top")
    sightexports.sGui:setLabelText(label, "Fék: ")
    local label = sightexports.sGui:createGuiElement("label", x + sightexports.sGui:getLabelTextWidth(label), y, 0, 0, vehicleDataBg)
    sightexports.sGui:setLabelFont(label, groupFonts[5])
    sightexports.sGui:setLabelAlignment(label, "left", "top")
    sightexports.sGui:setLabelText(label, getVehLabelValue(datas, "performance.brake"))
    y = y + sightexports.sGui:getLabelFontHeight(label) + dashboardPadding[3]
    local label = sightexports.sGui:createGuiElement("label", x, y, 0, 0, vehicleDataBg)
    sightexports.sGui:setLabelFont(label, groupFonts[4])
    sightexports.sGui:setLabelAlignment(label, "left", "top")
    sightexports.sGui:setLabelText(label, "Gumik: ")
    local label = sightexports.sGui:createGuiElement("label", x + sightexports.sGui:getLabelTextWidth(label), y, 0, 0, vehicleDataBg)
    sightexports.sGui:setLabelFont(label, groupFonts[5])
    sightexports.sGui:setLabelAlignment(label, "left", "top")
    sightexports.sGui:setLabelText(label, getVehLabelValue(datas, "performance.tire"))
    y = y + sightexports.sGui:getLabelFontHeight(label) + dashboardPadding[3]
    local label = sightexports.sGui:createGuiElement("label", x, y, 0, 0, vehicleDataBg)
    sightexports.sGui:setLabelFont(label, groupFonts[4])
    sightexports.sGui:setLabelAlignment(label, "left", "top")
    sightexports.sGui:setLabelText(label, "Súlycsökkentés: ")
    local label = sightexports.sGui:createGuiElement("label", x + sightexports.sGui:getLabelTextWidth(label), y, 0, 0, vehicleDataBg)
    sightexports.sGui:setLabelFont(label, groupFonts[5])
    sightexports.sGui:setLabelAlignment(label, "left", "top")
    sightexports.sGui:setLabelText(label, getVehLabelValue(datas, "performance.weightReduction"))
    y = y + sightexports.sGui:getLabelFontHeight(label) + dashboardPadding[3]
    local label = sightexports.sGui:createGuiElement("label", x, y, 0, 0, vehicleDataBg)
    sightexports.sGui:setLabelFont(label, groupFonts[4])
    sightexports.sGui:setLabelAlignment(label, "left", "top")
    sightexports.sGui:setLabelText(label, "Hasmagasság: ")
    local label = sightexports.sGui:createGuiElement("label", x + sightexports.sGui:getLabelTextWidth(label), y, 0, 0, vehicleDataBg)
    sightexports.sGui:setLabelFont(label, groupFonts[5])
    sightexports.sGui:setLabelAlignment(label, "left", "top")
    sightexports.sGui:setLabelText(label, getVehLabelValue(datas, "rideTuning"))
    y = y + sightexports.sGui:getLabelFontHeight(label) + dashboardPadding[3]
    local label = sightexports.sGui:createGuiElement("label", x, y, 0, 0, vehicleDataBg)
    sightexports.sGui:setLabelFont(label, groupFonts[4])
    sightexports.sGui:setLabelAlignment(label, "left", "top")
    sightexports.sGui:setLabelText(label, "Nitro: ")
    local label = sightexports.sGui:createGuiElement("label", x + sightexports.sGui:getLabelTextWidth(label), y, 0, 0, vehicleDataBg)
    sightexports.sGui:setLabelFont(label, groupFonts[5])
    sightexports.sGui:setLabelAlignment(label, "left", "top")
    sightexports.sGui:setLabelText(label, getVehLabelValue(datas, "nitro"))
    y = y + sightexports.sGui:getLabelFontHeight(label) + dashboardPadding[3]
  end
end)
addEvent("setGroupVehicleMemberPanel", false)
addEventHandler("setGroupVehicleMemberPanel", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  sightexports.sGui:setGuiBackground(vehicleMemberButton, "solid", "sightgreen")
  sightexports.sGui:setGuiHoverable(vehicleMemberButton, false)
  sightexports.sGui:setGuiBackground(vehicleDataButton, "solid", "sightgrey4")
  sightexports.sGui:setGuiHoverable(vehicleDataButton, true)
  sightexports.sGui:setGuiRenderDisabled(vehicleMemberBg, false, true)
  sightexports.sGui:setGuiRenderDisabled(vehicleDataBg, true, true)
  processGroupVehicleMemberList()
end)
addEvent("doneEditVehicleMembers", false)
addEventHandler("doneEditVehicleMembers", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  sightexports.sGui:deleteGuiElement(el)
  createGroupLoader()
  local members = {}
  for i = 1, #vehicleMemberList do
    if vehicleMemberList[i] and vehicleMemberList[i][4] then
      table.insert(members, vehicleMemberList[i][1])
    end
  end
  triggerLatentServerEvent("editGroupVehicleMembers", localPlayer, selectedGroup, selectedVehicle, members)
end)
addEvent("selectVehicleMemberCheckbox", false)
addEventHandler("selectVehicleMemberCheckbox", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  for i = 1, #vehicleMemberElements do
    if vehicleMemberElements[i][3] == el then
      if vehicleMemberList[i + vehicleMemberScroll] then
        vehicleMemberList[i + vehicleMemberScroll][4] = sightexports.sGui:isCheckboxChecked(el)
        processGroupVehicleMemberList()
      end
      return
    end
  end
end)
addEvent("editVehicleMembers", false)
addEventHandler("editVehicleMembers", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  if selectedVehicle and groupDatas[selectedGroup].gotVehicles[selectedVehicle] then
    sightexports.sGui:setGuiHoverable(vehicleMemberButton, false)
    sightexports.sGui:setGuiHoverable(vehicleDataButton, false)
    vehicleMemberEditing = true
    table.sort(vehicleMemberList, groupVehicleMemberSortEx)
    processGroupVehicleMemberList()
    sightexports.sGui:setImageFile(vehicleMemberEditButton, sightexports.sGui:getFaIconFilename("save", 32))
    sightexports.sGui:setClickEvent(vehicleMemberEditButton, "doneEditVehicleMembers")
  end
end)
function processGroupVehicleMemberList()
  local w, h = sightexports.sGui:getGuiSize(vehicleMemberBg)
  local n = math.max(0, #vehicleMemberList - #vehicleMemberElements)
  h = h / (n + 1)
  if n < vehicleMemberScroll then
    vehicleMemberScroll = n
  end
  sightexports.sGui:setGuiSize(vehicleMemberScrollBar, false, h)
  sightexports.sGui:setGuiPosition(vehicleMemberScrollBar, false, h * vehicleMemberScroll)
  for i = 1, #vehicleMemberElements do
    if vehicleMemberList[i + vehicleMemberScroll] then
      local hasPerm = vehicleMemberList[i + vehicleMemberScroll][4]
      sightexports.sGui:setGuiRenderDisabled(vehicleMemberElements[i][1], false)
      sightexports.sGui:setGuiRenderDisabled(vehicleMemberElements[i][2], false)
      local label = vehicleMemberElements[i][1]
      sightexports.sGui:setLabelText(label, vehicleMemberList[i + vehicleMemberScroll][2])
      local w, h = sightexports.sGui:getGuiSize(label)
      sightexports.sGui:setLabelColor(label, hasPerm and "#ffffff" or "sightmidgrey")
      local label = vehicleMemberElements[i][2]
      local rank = vehicleMemberList[i + vehicleMemberScroll][3]
      sightexports.sGui:setLabelColor(label, hasPerm and "sight" .. (groupDatas[selectedGroup].rankColors[rank] or "blue") or "sightmidgrey")
      sightexports.sGui:setLabelText(label, (groupDatas[selectedGroup].ranks[rank] or "N/A") .. " [" .. rank .. "]")
      local checkbox = vehicleMemberElements[i][3]
      if vehicleMemberEditing then
        sightexports.sGui:setGuiRenderDisabled(checkbox, false)
        sightexports.sGui:setCheckboxChecked(checkbox, hasPerm)
        sightexports.sGui:setGuiSize(label, w - h, false)
      else
        sightexports.sGui:setGuiRenderDisabled(checkbox, true)
        sightexports.sGui:setGuiSize(label, w, false)
      end
      if vehicleMemberElements[i][4] then
        sightexports.sGui:setGuiRenderDisabled(vehicleMemberElements[i][4], false)
      end
    else
      sightexports.sGui:setGuiRenderDisabled(vehicleMemberElements[i][1], true)
      sightexports.sGui:setGuiRenderDisabled(vehicleMemberElements[i][2], true)
      sightexports.sGui:setGuiRenderDisabled(vehicleMemberElements[i][3], true)
      if vehicleMemberElements[i][4] then
        sightexports.sGui:setGuiRenderDisabled(vehicleMemberElements[i][4], true)
      end
    end
  end
end
function drawGroupVehicles()
  local label = sightexports.sGui:createGuiElement("label", dashboardPadding[3] * 4, 40, 0, 48, groupPanel)
  sightexports.sGui:setLabelFont(label, groupFonts[3])
  sightexports.sGui:setLabelAlignment(label, "left", "center")
  sightexports.sGui:setLabelText(label, "Járművek: " .. #groupDatas[selectedGroup].vehicles)
  local w = math.ceil((sx - menuW) * 0.45)
  local h = sy - 40 - dashboardPadding[3] * 8 - 48
  vehiclesBg = sightexports.sGui:createGuiElement("rectangle", dashboardPadding[3] * 4, 88 + dashboardPadding[3] * 4, w, h, groupPanel)
  sightexports.sGui:setGuiBackground(vehiclesBg, "solid", "sightgrey1")
  local sbg = sightexports.sGui:createGuiElement("rectangle", w - 2, 0, 2, h, vehiclesBg)
  sightexports.sGui:setGuiBackground(sbg, "solid", "sightgrey3")
  vehiclesScrollBar = sightexports.sGui:createGuiElement("rectangle", w - 2, 0, 2, h, vehiclesBg)
  sightexports.sGui:setGuiBackground(vehiclesScrollBar, "solid", "sightmidgrey")
  local n = math.floor(h / 32)
  h = h / n
  vehicleElements = {}
  y = 0
  for i = 1, n do
    if groupDatas[selectedGroup].vehicles[i] then
      vehicleElements[i] = {}
      local rect = sightexports.sGui:createGuiElement("rectangle", 0, y, w - 2, h - 1, vehiclesBg)
      sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey1")
      sightexports.sGui:setGuiHover(rect, "gradient", {"sightgrey1", "sightgrey2"}, false, true)
      sightexports.sGui:setGuiHoverable(rect, true)
      sightexports.sGui:setClickEvent(rect, "selectGroupVehicle")
      vehicleElements[i][1] = rect
      local label = sightexports.sGui:createGuiElement("label", dashboardPadding[3] * 2, 0, 0, h, rect)
      sightexports.sGui:setLabelFont(label, groupFonts[4])
      sightexports.sGui:setLabelAlignment(label, "left", "center")
      vehicleElements[i][2] = label
      local label = sightexports.sGui:createGuiElement("label", 0, 0, w - dashboardPadding[3] * 2, h, rect)
      sightexports.sGui:setLabelFont(label, groupFonts[5])
      sightexports.sGui:setLabelColor(label, "sightblue")
      sightexports.sGui:setLabelAlignment(label, "right", "center")
      vehicleElements[i][3] = label
      if i < n then
        local border = sightexports.sGui:createGuiElement("hr", 0, h - 1, w - 2, 2, rect)
        sightexports.sGui:setGuiHrColor(border, "sightgrey3", "sightgrey2")
        vehicleElements[i][4] = border
      end
    end
    y = y + h
  end
  x = dashboardPadding[3] * 4 + w
  y = 88 + dashboardPadding[3] * 4
  local w = sx - menuW - x
  x = x + dashboardPadding[3] * 4
  vehicleNameLabel = sightexports.sGui:createGuiElement("label", x, y, w, 0, groupPanel)
  sightexports.sGui:setLabelFont(vehicleNameLabel, groupFonts[3])
  sightexports.sGui:setLabelAlignment(vehicleNameLabel, "left", "top")
  y = y + sightexports.sGui:getLabelFontHeight(label) + dashboardPadding[3] * 2
  local label = sightexports.sGui:createGuiElement("label", x, y, 0, 0, groupPanel)
  sightexports.sGui:setLabelFont(label, groupFonts[4])
  sightexports.sGui:setLabelAlignment(label, "left", "top")
  sightexports.sGui:setLabelText(label, "Rendszám: ")
  vehiclePlateLabel = sightexports.sGui:createGuiElement("label", x + sightexports.sGui:getLabelTextWidth(label), y, 0, 0, groupPanel)
  sightexports.sGui:setLabelFont(vehiclePlateLabel, groupFonts[5])
  sightexports.sGui:setLabelAlignment(vehiclePlateLabel, "left", "top")
  sightexports.sGui:setLabelColor(vehiclePlateLabel, "sightblue")
  y = y + sightexports.sGui:getLabelFontHeight(label) + dashboardPadding[3]
  y = y + dashboardPadding[3] * 2 + 24
  w = w - dashboardPadding[3] * 4 * 2
  local h = sy - y - dashboardPadding[3] * 4
  vehicleSidePanel = sightexports.sGui:createGuiElement("rectangle", x, y, w, h, groupPanel)
  sightexports.sGui:setGuiBackground(vehicleSidePanel, "solid", "sightgrey1")
  vehicleMemberButton = sightexports.sGui:createGuiElement("button", 0, -24, w / 2, 24, vehicleSidePanel)
  sightexports.sGui:setGuiBackground(vehicleMemberButton, "solid", "sightgreen")
  sightexports.sGui:setGuiHover(vehicleMemberButton, "gradient", {"sightgrey4", "sightgrey3"}, false, true)
  sightexports.sGui:setGuiHoverable(vehicleMemberButton, false)
  sightexports.sGui:setButtonFont(vehicleMemberButton, groupFonts[1])
  sightexports.sGui:setButtonTextColor(vehicleMemberButton, "#ffffff")
  sightexports.sGui:setButtonText(vehicleMemberButton, " Tagok")
  sightexports.sGui:setButtonIcon(vehicleMemberButton, sightexports.sGui:getFaIconFilename("users", 24))
  sightexports.sGui:setClickEvent(vehicleMemberButton, "setGroupVehicleMemberPanel")
  vehicleDataButton = sightexports.sGui:createGuiElement("button", w / 2, -24, w / 2, 24, vehicleSidePanel)
  sightexports.sGui:setGuiBackground(vehicleDataButton, "solid", "sightgrey4")
  sightexports.sGui:setGuiHover(vehicleDataButton, "gradient", {"sightgrey4", "sightgrey3"}, false, true)
  sightexports.sGui:setClickEvent(vehicleDataButton, "switchGroupPanelMenu")
  sightexports.sGui:setButtonFont(vehicleDataButton, groupFonts[1])
  sightexports.sGui:setButtonTextColor(vehicleDataButton, "#ffffff")
  sightexports.sGui:setButtonText(vehicleDataButton, " Adatok")
  sightexports.sGui:setButtonIcon(vehicleDataButton, sightexports.sGui:getFaIconFilename("list", 24))
  sightexports.sGui:setClickEvent(vehicleDataButton, "setGroupVehicleDataPanel")
  local n = math.floor(h / 32)
  h = h / n
  n = n - 1
  y = y + h
  vehicleDataBg = sightexports.sGui:createGuiElement("rectangle", x, y - h, w, h * (n + 1), groupPanel)
  sightexports.sGui:setGuiBackground(vehicleDataBg, "solid", "sightgrey1")
  sightexports.sGui:setGuiRenderDisabled(vehicleDataBg, true, true)
  vehicleMemberBg = sightexports.sGui:createGuiElement("rectangle", x, y, w, h * n, groupPanel)
  sightexports.sGui:setGuiBackground(vehicleMemberBg, "solid", "sightgrey1")
  local label = sightexports.sGui:createGuiElement("label", dashboardPadding[3] * 2, -h, 0, h, vehicleMemberBg)
  sightexports.sGui:setLabelFont(label, groupFonts[4])
  sightexports.sGui:setLabelAlignment(label, "left", "center")
  sightexports.sGui:setLabelText(label, "Tagok:")
  local lh = sightexports.sGui:getLabelFontHeight(label)
  if groupDatas[selectedGroup].isLeader or sightexports.sGroups:getPlayerPermissionInGroup(selectedGroup, "manageKeysVehicle") then
    vehicleMemberEditButton = sightexports.sGui:createGuiElement("image", w - h, -h / 2 - lh / 2, lh, lh, vehicleMemberBg)
    sightexports.sGui:setImageFile(vehicleMemberEditButton, sightexports.sGui:getFaIconFilename("pen", 32))
    sightexports.sGui:setGuiHover(vehicleMemberEditButton, "solid", "sightgreen")
    sightexports.sGui:setGuiHoverable(vehicleMemberEditButton, true)
    sightexports.sGui:setClickEvent(vehicleMemberEditButton, "editVehicleMembers")
    sightexports.sGui:guiSetTooltip(vehicleMemberEditButton, "Jármű jogosultságainak szerkesztése")
  else
    vehicleMemberEditButton = false
  end
  local border = sightexports.sGui:createGuiElement("hr", 0, -1, w, 2, vehicleMemberBg)
  sightexports.sGui:setGuiHrColor(border, "sightgrey3", "sightgrey2")
  local sbg = sightexports.sGui:createGuiElement("rectangle", w - 2, 0, 2, h * n, vehicleMemberBg)
  sightexports.sGui:setGuiBackground(sbg, "solid", "sightgrey3")
  vehicleMemberScrollBar = sightexports.sGui:createGuiElement("rectangle", w - 2, 0, 2, h * n, vehicleMemberBg)
  sightexports.sGui:setGuiBackground(vehicleMemberScrollBar, "solid", "sightmidgrey")
  vehicleMemberElements = {}
  y = 0
  for i = 1, n do
    vehicleMemberElements[i] = {}
    local label = sightexports.sGui:createGuiElement("label", dashboardPadding[3] * 2, y, w - dashboardPadding[3] * 2 - 2, h, vehicleMemberBg)
    sightexports.sGui:setLabelFont(label, groupFonts[4])
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    vehicleMemberElements[i][1] = label
    local label = sightexports.sGui:createGuiElement("label", 0, y, 0, h, vehicleMemberBg)
    sightexports.sGui:setLabelFont(label, groupFonts[5])
    sightexports.sGui:setLabelAlignment(label, "right", "center")
    vehicleMemberElements[i][2] = label
    local checkbox = sightexports.sGui:createGuiElement("checkbox", 0 + w - h - 2, y + 2, h - 4, h - 4, vehicleMemberBg)
    sightexports.sGui:setGuiColorScheme(checkbox, "darker")
    sightexports.sGui:setClickEvent(checkbox, "selectVehicleMemberCheckbox")
    vehicleMemberElements[i][3] = checkbox
    if n > i then
      local border = sightexports.sGui:createGuiElement("hr", 0, y + h - 1, w - 2, 2, vehicleMemberBg)
      sightexports.sGui:setGuiHrColor(border, "sightgrey3", "sightgrey2")
      vehicleMemberElements[i][4] = border
    end
    y = y + h
  end
  processGroupVehicleList()
  processGroupSelectedVehicle()
end
function processGroupSelectedInterior()
  interiorMemberEditing = false
  sightexports.sGui:setGuiBackground(interiorMemberButton, "solid", "sightgreen")
  sightexports.sGui:setGuiHoverable(interiorMemberButton, false)
  sightexports.sGui:setGuiBackground(interiorDataButton, "solid", "sightgrey4")
  sightexports.sGui:setGuiHoverable(interiorDataButton, true)
  sightexports.sGui:setGuiRenderDisabled(interiorMemberBg, false, true)
  sightexports.sGui:setGuiRenderDisabled(interiorDataBg, true, true)
  if selectedInterior and groupDatas[selectedGroup].interiorMembers[selectedInterior] then
    interiorMemberList = {}
    for i = 1, #groupDatas[selectedGroup].members do
      if not groupDatas[selectedGroup].members[i][3] then
        table.insert(interiorMemberList, {
          groupDatas[selectedGroup].members[i][7],
          groupDatas[selectedGroup].members[i][1],
          groupDatas[selectedGroup].members[i][2],
          groupDatas[selectedGroup].interiorMembers[selectedInterior][groupDatas[selectedGroup].members[i][8]]
        })
      end
    end
    table.sort(interiorMemberList, groupVehicleMemberSort)
    sightexports.sGui:setLabelText(interiorNameLabel, "[" .. selectedInterior .. "] " .. sightexports.sInteriors:getInteriorName(selectedInterior))
    sightexports.sGui:setLabelText(interiorTypeLabel, sightexports.sInteriors:getInteriorTypeName(sightexports.sInteriors:getInteriorType(selectedInterior)))
    processGroupInteriorMemberList()
  else
    sightexports.sGui:setLabelText(interiorNameLabel, "Válassz interiort!")
    sightexports.sGui:setLabelText(interiorTypeLabel, "")
    for i = 1, #interiorMemberElements do
      sightexports.sGui:setGuiRenderDisabled(interiorMemberElements[i][1], true)
      sightexports.sGui:setGuiRenderDisabled(interiorMemberElements[i][2], true)
      if interiorMemberElements[i][3] then
        sightexports.sGui:setGuiRenderDisabled(interiorMemberElements[i][3], true)
      end
    end
  end
end
function processGroupInteriorList()
  local w, h = sightexports.sGui:getGuiSize(interiorsBg)
  local n = math.max(0, #groupInteriors - #interiorElements)
  h = h / (n + 1)
  if n < interiorsScroll then
    interiorsScroll = n
  end
  sightexports.sGui:setGuiSize(interiorsScrollBar, false, h)
  sightexports.sGui:setGuiPosition(interiorsScrollBar, false, h * interiorsScroll)
  for i = 1, #interiorElements do
    if groupInteriors[i + interiorsScroll] then
      sightexports.sGui:setGuiRenderDisabled(interiorElements[i][1], false)
      sightexports.sGui:setGuiRenderDisabled(interiorElements[i][2], false)
      sightexports.sGui:setGuiRenderDisabled(interiorElements[i][3], false)
      if interiorElements[i][4] then
        sightexports.sGui:setGuiRenderDisabled(interiorElements[i][4], false)
      end
      if not selectedInterior then
        selectedInterior = groupInteriors[i + interiorsScroll][1]
      end
      local rect = interiorElements[i][1]
      if groupInteriors[i + interiorsScroll][1] == selectedInterior then
        sightexports.sGui:setGuiHoverable(rect, false)
        sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey3")
      else
        sightexports.sGui:setGuiHoverable(rect, true)
        sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey1")
      end
      local label = interiorElements[i][2]
      sightexports.sGui:setLabelText(label, "[" .. groupInteriors[i + interiorsScroll][1] .. "] " .. groupInteriors[i + interiorsScroll][2])
      local label = interiorElements[i][3]
      sightexports.sGui:setLabelText(label, groupInteriors[i + interiorsScroll][3])
    else
      sightexports.sGui:setGuiRenderDisabled(interiorElements[i][1], true)
      sightexports.sGui:setGuiRenderDisabled(interiorElements[i][2], true)
      sightexports.sGui:setGuiRenderDisabled(interiorElements[i][3], true)
      if interiorElements[i][4] then
        sightexports.sGui:setGuiRenderDisabled(interiorElements[i][4], true)
      end
    end
  end
end
addEvent("selectGroupInterior", false)
addEventHandler("selectGroupInterior", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  for i = 1, #interiorElements do
    if interiorElements[i][1] == el and groupInteriors[i + interiorsScroll] then
      selectedInterior = groupInteriors[i + interiorsScroll][1]
      interiorMemberScroll = 0
      processGroupInteriorList()
      processGroupSelectedInterior()
      return
    end
  end
end)
addEvent("setGroupInteriorDataPanel", false)
addEventHandler("setGroupInteriorDataPanel", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  sightexports.sGui:setGuiBackground(interiorDataButton, "solid", "sightgreen")
  sightexports.sGui:setGuiHoverable(interiorDataButton, false)
  sightexports.sGui:setGuiBackground(interiorMemberButton, "solid", "sightgrey4")
  sightexports.sGui:setGuiHoverable(interiorMemberButton, true)
  sightexports.sGui:setGuiRenderDisabled(interiorDataBg, false, true)
  sightexports.sGui:setGuiRenderDisabled(interiorMemberBg, true, true)
  if selectedInterior then
    sightexports.sGui:deleteAllChildren(interiorDataBg)
    local x = dashboardPadding[3] * 2
    local y = dashboardPadding[3] * 2
    local label = sightexports.sGui:createGuiElement("label", x, y, 0, 0, interiorDataBg)
    sightexports.sGui:setLabelFont(label, groupFonts[4])
    sightexports.sGui:setLabelAlignment(label, "left", "top")
    sightexports.sGui:setLabelText(label, "Zárva: ")
    local label = sightexports.sGui:createGuiElement("label", x + sightexports.sGui:getLabelTextWidth(label), y, 0, 0, interiorDataBg)
    sightexports.sGui:setLabelFont(label, groupFonts[5])
    sightexports.sGui:setLabelAlignment(label, "left", "top")
    local locked = sightexports.sInteriors:getInteriorLocked(selectedInterior)
    if locked then
      sightexports.sGui:setLabelColor(label, "sightgreen")
      sightexports.sGui:setLabelText(label, "igen")
    else
      sightexports.sGui:setLabelColor(label, "sightred")
      sightexports.sGui:setLabelText(label, "nem")
    end
    y = y + sightexports.sGui:getLabelFontHeight(label) + dashboardPadding[3]
    local label = sightexports.sGui:createGuiElement("label", x, y, 0, 0, interiorDataBg)
    sightexports.sGui:setLabelFont(label, groupFonts[4])
    sightexports.sGui:setLabelAlignment(label, "left", "top")
    sightexports.sGui:setLabelText(label, "Szerkeszthető: ")
    local label = sightexports.sGui:createGuiElement("label", x + sightexports.sGui:getLabelTextWidth(label), y, 0, 0, interiorDataBg)
    sightexports.sGui:setLabelFont(label, groupFonts[5])
    sightexports.sGui:setLabelAlignment(label, "left", "top")
    local editable = sightexports.sInteriors:getInteriorEditable(selectedInterior)
    if editable == "N" then
      sightexports.sGui:setLabelColor(label, "sightred")
      sightexports.sGui:setLabelText(label, "nem")
    else
      sightexports.sGui:setLabelColor(label, "sightgreen")
      sightexports.sGui:setLabelText(label, editable)
    end
    y = y + sightexports.sGui:getLabelFontHeight(label) + dashboardPadding[3] * 2
    local sx, sy = sightexports.sGui:getGuiSize(interiorDataBg)
    local px, py = x, y
    local pw, ph = sx - x - dashboardPadding[3] * 2, sy - y - dashboardPadding[3] * 2
    local rx, ry = sightexports.sInteriors:getInteriorOutsidePosition(selectedInterior)
    local map = sightexports.sGui:createGuiElement("radar", px, py, pw, ph, interiorDataBg)
    sightexports.sGui:setRadarCoords(map, rx, ry, 128)
    local img = sightexports.sGui:createGuiElement("image", px, py, 16, 16, interiorDataBg)
    sightexports.sGui:setImageDDS(img, ":sDashboard/files/mapcorner.dds")
    sightexports.sGui:setImageColor(img, "sightgrey1")
    local img = sightexports.sGui:createGuiElement("image", px + pw, py, -16, 16, interiorDataBg)
    sightexports.sGui:setImageDDS(img, ":sDashboard/files/mapcorner.dds")
    sightexports.sGui:setImageColor(img, "sightgrey1")
    local img = sightexports.sGui:createGuiElement("image", px + 16, py, pw - 32, 16, interiorDataBg)
    sightexports.sGui:setImageDDS(img, ":sDashboard/files/mapside.dds")
    sightexports.sGui:setImageColor(img, "sightgrey1")
    sightexports.sGui:setImageUV(img, 0, 0, pw - 64, 32)
    local img = sightexports.sGui:createGuiElement("image", px, py + ph, 16, -16, interiorDataBg)
    sightexports.sGui:setImageDDS(img, ":sDashboard/files/mapcorner.dds")
    sightexports.sGui:setImageColor(img, "sightgrey1")
    local img = sightexports.sGui:createGuiElement("image", px + pw, py + ph, -16, -16, interiorDataBg)
    sightexports.sGui:setImageDDS(img, ":sDashboard/files/mapcorner.dds")
    sightexports.sGui:setImageColor(img, "sightgrey1")
    local img = sightexports.sGui:createGuiElement("image", px + 16, py + ph, pw - 32, -16, interiorDataBg)
    sightexports.sGui:setImageDDS(img, ":sDashboard/files/mapside.dds")
    sightexports.sGui:setImageColor(img, "sightgrey1")
    sightexports.sGui:setImageUV(img, 0, 0, pw - 64, 32)
    local img = sightexports.sGui:createGuiElement("image", px, py + 16, 16, ph - 32, interiorDataBg)
    sightexports.sGui:setImageDDS(img, ":sDashboard/files/mapside2.dds")
    sightexports.sGui:setImageColor(img, "sightgrey1")
    sightexports.sGui:setImageUV(img, 0, 0, 32, ph - 64)
    local img = sightexports.sGui:createGuiElement("image", px + pw, py + 16, -16, ph - 32, interiorDataBg)
    sightexports.sGui:setImageDDS(img, ":sDashboard/files/mapside2.dds")
    sightexports.sGui:setImageColor(img, "sightgrey1")
    sightexports.sGui:setImageUV(img, 0, 0, 32, ph - 64)
    local cross = sightexports.sGui:createGuiElement("image", px + pw / 2 - 16, py + ph / 2 - 16, 32, 32, interiorDataBg)
    local theType = sightexports.sInteriors:getInteriorType(selectedInterior)
    if theType == "house" then
      sightexports.sGui:setImageFile(cross, sightexports.sGui:getFaIconFilename("building", 32, "solid", false, sightexports.sGui:getColorCodeToColor("sightgrey2"), sightexports.sGui:getColorCodeToColor("sightblue")))
    elseif theType == "business" then
      sightexports.sGui:setImageFile(cross, sightexports.sGui:getFaIconFilename("dollar-sign", 32, "solid", false, sightexports.sGui:getColorCodeToColor("sightgrey2"), sightexports.sGui:getColorCodeToColor("sightgreen")))
    elseif theType == "garage" or theType == "garage2" then
      sightexports.sGui:setImageFile(cross, sightexports.sGui:getFaIconFilename("garage", 32, "solid", false, sightexports.sGui:getColorCodeToColor("sightgrey2"), sightexports.sGui:getColorCodeToColor("sightblue-second")))
    elseif theType == "rentable" then
      sightexports.sGui:setImageFile(cross, sightexports.sGui:getFaIconFilename("hotel", 32, "solid", false, sightexports.sGui:getColorCodeToColor("sightgrey2"), sightexports.sGui:getColorCodeToColor("sightpurple")))
    elseif theType == "lift" or theType == "stairs" then
      sightexports.sGui:setImageFile(cross, sightexports.sGui:getFaIconFilename("sort-circle-up", 32, "solid", false, sightexports.sGui:getColorCodeToColor("sightgrey2"), sightexports.sGui:getColorCodeToColor("hudwhite")))
    elseif theType == "door" then
      sightexports.sGui:setImageFile(cross, sightexports.sGui:getFaIconFilename("door-closed", 32, "solid", false, sightexports.sGui:getColorCodeToColor("sightgrey2"), sightexports.sGui:getColorCodeToColor("hudwhite")))
    else
      sightexports.sGui:setImageFile(cross, sightexports.sGui:getFaIconFilename("question", 32, "solid", false, sightexports.sGui:getColorCodeToColor("sightgrey2"), sightexports.sGui:getColorCodeToColor("sightyellow")))
    end
  end
end)
addEvent("setGroupInteriorMemberPanel", false)
addEventHandler("setGroupInteriorMemberPanel", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  sightexports.sGui:setGuiBackground(interiorMemberButton, "solid", "sightgreen")
  sightexports.sGui:setGuiHoverable(interiorMemberButton, false)
  sightexports.sGui:setGuiBackground(interiorDataButton, "solid", "sightgrey4")
  sightexports.sGui:setGuiHoverable(interiorDataButton, true)
  sightexports.sGui:setGuiRenderDisabled(interiorMemberBg, false, true)
  sightexports.sGui:setGuiRenderDisabled(interiorDataBg, true, true)
  processGroupInteriorMemberList()
end)
addEvent("doneEditInteriorMembers", false)
addEventHandler("doneEditInteriorMembers", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  sightexports.sGui:deleteGuiElement(el)
  createGroupLoader()
  local members = {}
  for i = 1, #interiorMemberList do
    if interiorMemberList[i] and interiorMemberList[i][4] then
      table.insert(members, interiorMemberList[i][1])
    end
  end
  triggerLatentServerEvent("editGroupInteriorMembers", localPlayer, selectedGroup, selectedInterior, members)
end)
addEvent("selectInteriorMemberCheckbox", false)
addEventHandler("selectInteriorMemberCheckbox", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  for i = 1, #interiorMemberElements do
    if interiorMemberElements[i][3] == el then
      if interiorMemberList[i + interiorMemberScroll] then
        interiorMemberList[i + interiorMemberScroll][4] = sightexports.sGui:isCheckboxChecked(el)
        processGroupInteriorMemberList()
      end
      return
    end
  end
end)
addEvent("editInteriorMembers", false)
addEventHandler("editInteriorMembers", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  if selectedInterior and groupDatas[selectedGroup].interiorMembers[selectedInterior] then
    sightexports.sGui:setGuiHoverable(interiorMemberButton, false)
    sightexports.sGui:setGuiHoverable(interiorDataButton, false)
    interiorMemberEditing = true
    table.sort(interiorMemberList, groupVehicleMemberSortEx)
    processGroupInteriorMemberList()
    sightexports.sGui:setImageFile(interiorMemberEditButton, sightexports.sGui:getFaIconFilename("save", 32))
    sightexports.sGui:setClickEvent(interiorMemberEditButton, "doneEditInteriorMembers")
  end
end)
function processGroupInteriorMemberList()
  local w, h = sightexports.sGui:getGuiSize(interiorMemberBg)
  local n = math.max(0, #interiorMemberList - #interiorMemberElements)
  h = h / (n + 1)
  if n < interiorMemberScroll then
    interiorMemberScroll = n
  end
  sightexports.sGui:setGuiSize(interiorMemberScrollBar, false, h)
  sightexports.sGui:setGuiPosition(interiorMemberScrollBar, false, h * interiorMemberScroll)
  for i = 1, #interiorMemberElements do
    if interiorMemberList[i + interiorMemberScroll] then
      local hasPerm = interiorMemberList[i + interiorMemberScroll][4]
      sightexports.sGui:setGuiRenderDisabled(interiorMemberElements[i][1], false)
      sightexports.sGui:setGuiRenderDisabled(interiorMemberElements[i][2], false)
      local label = interiorMemberElements[i][1]
      sightexports.sGui:setLabelText(label, interiorMemberList[i + interiorMemberScroll][2])
      local w, h = sightexports.sGui:getGuiSize(label)
      sightexports.sGui:setLabelColor(label, hasPerm and "#ffffff" or "sightmidgrey")
      local label = interiorMemberElements[i][2]
      local rank = interiorMemberList[i + interiorMemberScroll][3]
      sightexports.sGui:setLabelColor(label, hasPerm and "sight" .. (groupDatas[selectedGroup].rankColors[rank] or "blue") or "sightmidgrey")
      sightexports.sGui:setLabelText(label, (groupDatas[selectedGroup].ranks[rank] or "N/A") .. " [" .. rank .. "]")
      local checkbox = interiorMemberElements[i][3]
      if interiorMemberEditing then
        sightexports.sGui:setGuiRenderDisabled(checkbox, false)
        sightexports.sGui:setCheckboxChecked(checkbox, hasPerm)
        sightexports.sGui:setGuiSize(label, w - h, false)
      else
        sightexports.sGui:setGuiRenderDisabled(checkbox, true)
        sightexports.sGui:setGuiSize(label, w, false)
      end
      if interiorMemberElements[i][4] then
        sightexports.sGui:setGuiRenderDisabled(interiorMemberElements[i][4], false)
      end
    else
      sightexports.sGui:setGuiRenderDisabled(interiorMemberElements[i][1], true)
      sightexports.sGui:setGuiRenderDisabled(interiorMemberElements[i][2], true)
      sightexports.sGui:setGuiRenderDisabled(interiorMemberElements[i][3], true)
      if interiorMemberElements[i][4] then
        sightexports.sGui:setGuiRenderDisabled(interiorMemberElements[i][4], true)
      end
    end
  end
end
function drawGroupInteriors()
  local label = sightexports.sGui:createGuiElement("label", dashboardPadding[3] * 4, 40, 0, 48, groupPanel)
  sightexports.sGui:setLabelFont(label, groupFonts[3])
  sightexports.sGui:setLabelAlignment(label, "left", "center")
  sightexports.sGui:setLabelText(label, "Interiorok: " .. #groupInteriors)
  local w = math.ceil((sx - menuW) * 0.45)
  local h = sy - 40 - dashboardPadding[3] * 8 - 48
  interiorsBg = sightexports.sGui:createGuiElement("rectangle", dashboardPadding[3] * 4, 88 + dashboardPadding[3] * 4, w, h, groupPanel)
  sightexports.sGui:setGuiBackground(interiorsBg, "solid", "sightgrey1")
  local sbg = sightexports.sGui:createGuiElement("rectangle", w - 2, 0, 2, h, interiorsBg)
  sightexports.sGui:setGuiBackground(sbg, "solid", "sightgrey3")
  interiorsScrollBar = sightexports.sGui:createGuiElement("rectangle", w - 2, 0, 2, h, interiorsBg)
  sightexports.sGui:setGuiBackground(interiorsScrollBar, "solid", "sightmidgrey")
  local n = math.floor(h / 32)
  h = h / n
  interiorElements = {}
  y = 0
  for i = 1, n do
    if groupInteriors[i] then
      interiorElements[i] = {}
      local rect = sightexports.sGui:createGuiElement("rectangle", 0, y, w - 2, h - 1, interiorsBg)
      sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey1")
      sightexports.sGui:setGuiHover(rect, "gradient", {"sightgrey1", "sightgrey2"}, false, true)
      sightexports.sGui:setGuiHoverable(rect, true)
      sightexports.sGui:setClickEvent(rect, "selectGroupInterior")
      interiorElements[i][1] = rect
      local label = sightexports.sGui:createGuiElement("label", dashboardPadding[3] * 2, 0, 0, h, rect)
      sightexports.sGui:setLabelFont(label, groupFonts[4])
      sightexports.sGui:setLabelAlignment(label, "left", "center")
      interiorElements[i][2] = label
      local label = sightexports.sGui:createGuiElement("label", 0, 0, w - dashboardPadding[3] * 2, h, rect)
      sightexports.sGui:setLabelFont(label, groupFonts[5])
      sightexports.sGui:setLabelAlignment(label, "right", "center")
      interiorElements[i][3] = label
      if i < n then
        local border = sightexports.sGui:createGuiElement("hr", 0, h - 1, w - 2, 2, rect)
        sightexports.sGui:setGuiHrColor(border, "sightgrey3", "sightgrey2")
        interiorElements[i][4] = border
      end
    end
    y = y + h
  end
  x = dashboardPadding[3] * 4 + w
  y = 88 + dashboardPadding[3] * 4
  local w = sx - menuW - x
  x = x + dashboardPadding[3] * 4
  interiorNameLabel = sightexports.sGui:createGuiElement("label", x, y, w, 0, groupPanel)
  sightexports.sGui:setLabelFont(interiorNameLabel, groupFonts[3])
  sightexports.sGui:setLabelAlignment(interiorNameLabel, "left", "top")
  y = y + sightexports.sGui:getLabelFontHeight(label) + dashboardPadding[3] * 2
  local label = sightexports.sGui:createGuiElement("label", x, y, 0, 0, groupPanel)
  sightexports.sGui:setLabelFont(label, groupFonts[4])
  sightexports.sGui:setLabelAlignment(label, "left", "top")
  sightexports.sGui:setLabelText(label, "Interior típus: ")
  interiorTypeLabel = sightexports.sGui:createGuiElement("label", x + sightexports.sGui:getLabelTextWidth(label), y, 0, 0, groupPanel)
  sightexports.sGui:setLabelFont(interiorTypeLabel, groupFonts[5])
  sightexports.sGui:setLabelAlignment(interiorTypeLabel, "left", "top")
  y = y + sightexports.sGui:getLabelFontHeight(label) + dashboardPadding[3]
  y = y + dashboardPadding[3] * 2 + 24
  w = w - dashboardPadding[3] * 4 * 2
  local h = sy - y - dashboardPadding[3] * 4
  interiorSidePanel = sightexports.sGui:createGuiElement("rectangle", x, y, w, h, groupPanel)
  sightexports.sGui:setGuiBackground(interiorSidePanel, "solid", "sightgrey1")
  interiorMemberButton = sightexports.sGui:createGuiElement("button", 0, -24, w / 2, 24, interiorSidePanel)
  sightexports.sGui:setGuiBackground(interiorMemberButton, "solid", "sightgreen")
  sightexports.sGui:setGuiHover(interiorMemberButton, "gradient", {"sightgrey4", "sightgrey3"}, false, true)
  sightexports.sGui:setGuiHoverable(interiorMemberButton, false)
  sightexports.sGui:setButtonFont(interiorMemberButton, groupFonts[1])
  sightexports.sGui:setButtonTextColor(interiorMemberButton, "#ffffff")
  sightexports.sGui:setButtonText(interiorMemberButton, " Tagok")
  sightexports.sGui:setButtonIcon(interiorMemberButton, sightexports.sGui:getFaIconFilename("users", 24))
  sightexports.sGui:setClickEvent(interiorMemberButton, "setGroupInteriorMemberPanel")
  interiorDataButton = sightexports.sGui:createGuiElement("button", w / 2, -24, w / 2, 24, interiorSidePanel)
  sightexports.sGui:setGuiBackground(interiorDataButton, "solid", "sightgrey4")
  sightexports.sGui:setGuiHover(interiorDataButton, "gradient", {"sightgrey4", "sightgrey3"}, false, true)
  sightexports.sGui:setClickEvent(interiorDataButton, "switchGroupPanelMenu")
  sightexports.sGui:setButtonFont(interiorDataButton, groupFonts[1])
  sightexports.sGui:setButtonTextColor(interiorDataButton, "#ffffff")
  sightexports.sGui:setButtonText(interiorDataButton, " Adatok")
  sightexports.sGui:setButtonIcon(interiorDataButton, sightexports.sGui:getFaIconFilename("list", 24))
  sightexports.sGui:setClickEvent(interiorDataButton, "setGroupInteriorDataPanel")
  local n = math.floor(h / 32)
  h = h / n
  n = n - 1
  y = y + h
  interiorDataBg = sightexports.sGui:createGuiElement("rectangle", x, y - h, w, h * (n + 1), groupPanel)
  sightexports.sGui:setGuiBackground(interiorDataBg, "solid", "sightgrey1")
  sightexports.sGui:setGuiRenderDisabled(interiorDataBg, true, true)
  interiorMemberBg = sightexports.sGui:createGuiElement("rectangle", x, y, w, h * n, groupPanel)
  sightexports.sGui:setGuiBackground(interiorMemberBg, "solid", "sightgrey1")
  local label = sightexports.sGui:createGuiElement("label", dashboardPadding[3] * 2, -h, 0, h, interiorMemberBg)
  sightexports.sGui:setLabelFont(label, groupFonts[4])
  sightexports.sGui:setLabelAlignment(label, "left", "center")
  sightexports.sGui:setLabelText(label, "Tagok:")
  local lh = sightexports.sGui:getLabelFontHeight(label)
  if groupDatas[selectedGroup].isLeader or sightexports.sGroups:getPlayerPermissionInGroup(selectedGroup, "manageKeysInterior") then
    interiorMemberEditButton = sightexports.sGui:createGuiElement("image", w - h, -h / 2 - lh / 2, lh, lh, interiorMemberBg)
    sightexports.sGui:setImageFile(interiorMemberEditButton, sightexports.sGui:getFaIconFilename("pen", 32))
    sightexports.sGui:setGuiHover(interiorMemberEditButton, "solid", "sightgreen")
    sightexports.sGui:setGuiHoverable(interiorMemberEditButton, true)
    sightexports.sGui:setClickEvent(interiorMemberEditButton, "editInteriorMembers")
    sightexports.sGui:guiSetTooltip(interiorMemberEditButton, "Interior jogosultságainak szerkesztése")
  else
    interiorMemberEditButton = false
  end
  local border = sightexports.sGui:createGuiElement("hr", 0, -1, w, 2, interiorMemberBg)
  sightexports.sGui:setGuiHrColor(border, "sightgrey3", "sightgrey2")
  local sbg = sightexports.sGui:createGuiElement("rectangle", w - 2, 0, 2, h * n, interiorMemberBg)
  sightexports.sGui:setGuiBackground(sbg, "solid", "sightgrey3")
  interiorMemberScrollBar = sightexports.sGui:createGuiElement("rectangle", w - 2, 0, 2, h * n, interiorMemberBg)
  sightexports.sGui:setGuiBackground(interiorMemberScrollBar, "solid", "sightmidgrey")
  interiorMemberElements = {}
  y = 0
  for i = 1, n do
    interiorMemberElements[i] = {}
    local label = sightexports.sGui:createGuiElement("label", dashboardPadding[3] * 2, y, w - dashboardPadding[3] * 2 - 2, h, interiorMemberBg)
    sightexports.sGui:setLabelFont(label, groupFonts[4])
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    interiorMemberElements[i][1] = label
    local label = sightexports.sGui:createGuiElement("label", 0, y, 0, h, interiorMemberBg)
    sightexports.sGui:setLabelFont(label, groupFonts[5])
    sightexports.sGui:setLabelAlignment(label, "right", "center")
    interiorMemberElements[i][2] = label
    local checkbox = sightexports.sGui:createGuiElement("checkbox", 0 + w - h - 2, y + 2, h - 4, h - 4, interiorMemberBg)
    sightexports.sGui:setGuiColorScheme(checkbox, "darker")
    sightexports.sGui:setClickEvent(checkbox, "selectInteriorMemberCheckbox")
    interiorMemberElements[i][3] = checkbox
    if n > i then
      local border = sightexports.sGui:createGuiElement("hr", 0, y + h - 1, w - 2, 2, interiorMemberBg)
      sightexports.sGui:setGuiHrColor(border, "sightgrey3", "sightgrey2")
      interiorMemberElements[i][4] = border
    end
    y = y + h
  end
  processGroupInteriorList()
  processGroupSelectedInterior()
end
function drawGroupHome()
  local label = sightexports.sGui:createGuiElement("label", dashboardPadding[3] * 4, 40, 0, 48, groupPanel)
  sightexports.sGui:setLabelFont(label, groupFonts[3])
  sightexports.sGui:setLabelAlignment(label, "left", "center")
  sightexports.sGui:setLabelText(label, groupDatas[selectedGroup].name)
  local x = (sx - menuW) / 2 + dashboardPadding[3] * 4
  local y = 40 + dashboardPadding[3] * 4 + 48
  local label = sightexports.sGui:createGuiElement("label", x, y, 0, 0, groupPanel)
  sightexports.sGui:setLabelFont(label, groupFonts[2])
  sightexports.sGui:setLabelAlignment(label, "left", "top")
  sightexports.sGui:setLabelText(label, getElementData(localPlayer, "char.name"):gsub("_", " "))
  y = y + sightexports.sGui:getLabelFontHeight(label) + dashboardPadding[3]
  local label = sightexports.sGui:createGuiElement("label", x, y, 0, 0, groupPanel)
  sightexports.sGui:setLabelFont(label, groupFonts[4])
  sightexports.sGui:setLabelAlignment(label, "left", "top")
  sightexports.sGui:setLabelText(label, "Rang: ")
  local label = sightexports.sGui:createGuiElement("label", x + sightexports.sGui:getLabelTextWidth(label), y, 0, 0, groupPanel)
  sightexports.sGui:setLabelFont(label, groupFonts[5])
  sightexports.sGui:setLabelAlignment(label, "left", "top")
  sightexports.sGui:setLabelColor(label, "sight" .. (groupDatas[selectedGroup].rankColors[groupDatas[selectedGroup].rank] or "blue"))
  sightexports.sGui:setLabelText(label, (groupDatas[selectedGroup].ranks[groupDatas[selectedGroup].rank] or "N/A") .. " [" .. groupDatas[selectedGroup].rank .. "]")
  y = y + sightexports.sGui:getLabelFontHeight(label) + dashboardPadding[3]
  local label = sightexports.sGui:createGuiElement("label", x, y, 0, 0, groupPanel)
  sightexports.sGui:setLabelFont(label, groupFonts[4])
  sightexports.sGui:setLabelAlignment(label, "left", "top")
  sightexports.sGui:setLabelText(label, "Fizetés: ")
  local label = sightexports.sGui:createGuiElement("label", x + sightexports.sGui:getLabelTextWidth(label), y, 0, 0, groupPanel)
  sightexports.sGui:setLabelFont(label, groupFonts[5])
  sightexports.sGui:setLabelAlignment(label, "left", "top")
  sightexports.sGui:setLabelColor(label, "sightgreen")
  sightexports.sGui:setLabelText(label, sightexports.sGui:thousandsStepper(groupDatas[selectedGroup].salaries[groupDatas[selectedGroup].rank] or 0) .. " $")
  y = y + sightexports.sGui:getLabelFontHeight(label) + dashboardPadding[3]
  local label = sightexports.sGui:createGuiElement("label", x, y, 0, 0, groupPanel)
  sightexports.sGui:setLabelFont(label, groupFonts[4])
  sightexports.sGui:setLabelAlignment(label, "left", "top")
  sightexports.sGui:setLabelText(label, "Leader: ")
  local label = sightexports.sGui:createGuiElement("label", x + sightexports.sGui:getLabelTextWidth(label), y, 0, 0, groupPanel)
  sightexports.sGui:setLabelFont(label, groupFonts[5])
  sightexports.sGui:setLabelAlignment(label, "left", "top")
  sightexports.sGui:setLabelColor(label, groupDatas[selectedGroup].isLeader and "sightgreen" or "sightred")
  sightexports.sGui:setLabelText(label, groupDatas[selectedGroup].isLeader and "igen" or "nem")
  y = y + sightexports.sGui:getLabelFontHeight(label) + dashboardPadding[3]
  local label = sightexports.sGui:createGuiElement("label", x, y, 0, 0, groupPanel)
  sightexports.sGui:setLabelFont(label, groupFonts[4])
  sightexports.sGui:setLabelAlignment(label, "left", "top")
  sightexports.sGui:setLabelText(label, "Felvéve a frakcióba: ")
  local label = sightexports.sGui:createGuiElement("label", x + sightexports.sGui:getLabelTextWidth(label), y, 0, 0, groupPanel)
  sightexports.sGui:setLabelFont(label, groupFonts[5])
  sightexports.sGui:setLabelAlignment(label, "left", "top")
  sightexports.sGui:setLabelColor(label, "sightblue")
  local time = getRealTime(groupDatas[selectedGroup].added)
  sightexports.sGui:setLabelText(label, string.format("%04d. %02d. %02d. %02d:%02d", time.year + 1900, time.month + 1, time.monthday, time.hour, time.minute))
  y = y + sightexports.sGui:getLabelFontHeight(label) + dashboardPadding[3]
  local label = sightexports.sGui:createGuiElement("label", x, y, 0, 0, groupPanel)
  sightexports.sGui:setLabelFont(label, groupFonts[4])
  sightexports.sGui:setLabelAlignment(label, "left", "top")
  sightexports.sGui:setLabelText(label, "Rang változtatva: ")
  local label = sightexports.sGui:createGuiElement("label", x + sightexports.sGui:getLabelTextWidth(label), y, 0, 0, groupPanel)
  sightexports.sGui:setLabelFont(label, groupFonts[5])
  sightexports.sGui:setLabelAlignment(label, "left", "top")
  sightexports.sGui:setLabelColor(label, "sightblue")
  local time = getRealTime(groupDatas[selectedGroup].promoted)
  sightexports.sGui:setLabelText(label, string.format("%04d. %02d. %02d. %02d:%02d", time.year + 1900, time.month + 1, time.monthday, time.hour, time.minute))
  y = y + sightexports.sGui:getLabelFontHeight(label) + dashboardPadding[3]
  y = 40 + dashboardPadding[3] * 4 + 48
  x = dashboardPadding[3] * 4
  local onlineMembers = 0
  local onlineLeaders = 0
  local leaderCount = 0
  for i = 1, #groupDatas[selectedGroup].members do
    if isElement(groupDatas[selectedGroup].members[i][4]) then
      onlineMembers = onlineMembers + 1
    end
    if groupDatas[selectedGroup].members[i][3] then
      leaderCount = leaderCount + 1
      if isElement(groupDatas[selectedGroup].members[i][4]) then
        onlineLeaders = onlineLeaders + 1
      end
    end
  end
  local label = sightexports.sGui:createGuiElement("label", x, y, 0, 0, groupPanel)
  sightexports.sGui:setLabelFont(label, groupFonts[4])
  sightexports.sGui:setLabelAlignment(label, "left", "top")
  sightexports.sGui:setLabelText(label, "Tagok száma: ")
  local label = sightexports.sGui:createGuiElement("label", x + sightexports.sGui:getLabelTextWidth(label), y, 0, 0, groupPanel)
  sightexports.sGui:setLabelFont(label, groupFonts[5])
  sightexports.sGui:setLabelAlignment(label, "left", "top")
  sightexports.sGui:setLabelColor(label, "sightgreen")
  sightexports.sGui:setLabelText(label, #groupDatas[selectedGroup].members)
  y = y + sightexports.sGui:getLabelFontHeight(label) + dashboardPadding[3]
  local label = sightexports.sGui:createGuiElement("label", x, y, 0, 0, groupPanel)
  sightexports.sGui:setLabelFont(label, groupFonts[4])
  sightexports.sGui:setLabelAlignment(label, "left", "top")
  sightexports.sGui:setLabelText(label, "Online tagok: ")
  local label = sightexports.sGui:createGuiElement("label", x + sightexports.sGui:getLabelTextWidth(label), y, 0, 0, groupPanel)
  sightexports.sGui:setLabelFont(label, groupFonts[5])
  sightexports.sGui:setLabelAlignment(label, "left", "top")
  sightexports.sGui:setLabelColor(label, "sightgreen")
  sightexports.sGui:setLabelText(label, onlineMembers)
  y = y + sightexports.sGui:getLabelFontHeight(label) + dashboardPadding[3]
  local label = sightexports.sGui:createGuiElement("label", x, y, 0, 0, groupPanel)
  sightexports.sGui:setLabelFont(label, groupFonts[4])
  sightexports.sGui:setLabelAlignment(label, "left", "top")
  sightexports.sGui:setLabelText(label, "Leaderek száma: ")
  local label = sightexports.sGui:createGuiElement("label", x + sightexports.sGui:getLabelTextWidth(label), y, 0, 0, groupPanel)
  sightexports.sGui:setLabelFont(label, groupFonts[5])
  sightexports.sGui:setLabelAlignment(label, "left", "top")
  sightexports.sGui:setLabelColor(label, "sightgreen")
  sightexports.sGui:setLabelText(label, leaderCount)
  y = y + sightexports.sGui:getLabelFontHeight(label) + dashboardPadding[3]
  local label = sightexports.sGui:createGuiElement("label", x, y, 0, 0, groupPanel)
  sightexports.sGui:setLabelFont(label, groupFonts[4])
  sightexports.sGui:setLabelAlignment(label, "left", "top")
  sightexports.sGui:setLabelText(label, "Online leaderek: ")
  local label = sightexports.sGui:createGuiElement("label", x + sightexports.sGui:getLabelTextWidth(label), y, 0, 0, groupPanel)
  sightexports.sGui:setLabelFont(label, groupFonts[5])
  sightexports.sGui:setLabelAlignment(label, "left", "top")
  sightexports.sGui:setLabelColor(label, "sightgreen")
  sightexports.sGui:setLabelText(label, onlineLeaders)
  y = y + sightexports.sGui:getLabelFontHeight(label) + dashboardPadding[3]
  local label = sightexports.sGui:createGuiElement("label", x, y, 0, 0, groupPanel)
  sightexports.sGui:setLabelFont(label, groupFonts[4])
  sightexports.sGui:setLabelAlignment(label, "left", "top")
  sightexports.sGui:setLabelText(label, "Dutyban levő tagok: ")
  local label = sightexports.sGui:createGuiElement("label", x + sightexports.sGui:getLabelTextWidth(label), y, 0, 0, groupPanel)
  sightexports.sGui:setLabelFont(label, groupFonts[5])
  sightexports.sGui:setLabelAlignment(label, "left", "top")
  sightexports.sGui:setLabelColor(label, "sightblue")
  sightexports.sGui:setLabelText(label, groupDatas[selectedGroup].dutyCount)
  y = y + sightexports.sGui:getLabelFontHeight(label) + dashboardPadding[3]
  local label = sightexports.sGui:createGuiElement("label", x, y, 0, 0, groupPanel)
  sightexports.sGui:setLabelFont(label, groupFonts[4])
  sightexports.sGui:setLabelAlignment(label, "left", "top")
  sightexports.sGui:setLabelText(label, "Védett rádiófrekvencia: ")
  local label = sightexports.sGui:createGuiElement("label", x + sightexports.sGui:getLabelTextWidth(label), y, 0, 0, groupPanel)
  sightexports.sGui:setLabelFont(label, groupFonts[5])
  sightexports.sGui:setLabelAlignment(label, "left", "top")
  sightexports.sGui:setLabelColor(label, groupDatas[selectedGroup].protectedRadio and "sightgreen" or "sightred")
  sightexports.sGui:setLabelText(label, groupDatas[selectedGroup].protectedRadio or "nincs")
  y = y + sightexports.sGui:getLabelFontHeight(label) + dashboardPadding[3]
  local label = sightexports.sGui:createGuiElement("label", x, y, 0, 0, groupPanel)
  sightexports.sGui:setLabelFont(label, groupFonts[4])
  sightexports.sGui:setLabelAlignment(label, "left", "top")
  sightexports.sGui:setLabelText(label, "Voice rádió: ")
  local label = sightexports.sGui:createGuiElement("label", x + sightexports.sGui:getLabelTextWidth(label), y, 0, 0, groupPanel)
  sightexports.sGui:setLabelFont(label, groupFonts[5])
  sightexports.sGui:setLabelAlignment(label, "left", "top")
  sightexports.sGui:setLabelColor(label, groupDatas[selectedGroup].voiceRadio and "sightgreen" or "sightred")
  sightexports.sGui:setLabelText(label, groupDatas[selectedGroup].voiceRadio and "van" or "nincs")
  y = y + sightexports.sGui:getLabelFontHeight(label) + dashboardPadding[3]
  local label = sightexports.sGui:createGuiElement("label", x, y, 0, 0, groupPanel)
  sightexports.sGui:setLabelFont(label, groupFonts[4])
  sightexports.sGui:setLabelAlignment(label, "left", "top")
  sightexports.sGui:setLabelText(label, "Járművek száma: ")
  local label = sightexports.sGui:createGuiElement("label", x + sightexports.sGui:getLabelTextWidth(label), y, 0, 0, groupPanel)
  sightexports.sGui:setLabelFont(label, groupFonts[5])
  sightexports.sGui:setLabelAlignment(label, "left", "top")
  sightexports.sGui:setLabelColor(label, "sightblue")
  sightexports.sGui:setLabelText(label, #groupDatas[selectedGroup].vehicles)
  y = y + sightexports.sGui:getLabelFontHeight(label) + dashboardPadding[3]
  local label = sightexports.sGui:createGuiElement("label", x, y, 0, 0, groupPanel)
  sightexports.sGui:setLabelFont(label, groupFonts[4])
  sightexports.sGui:setLabelAlignment(label, "left", "top")
  sightexports.sGui:setLabelText(label, "Interiorok száma: ")
  local label = sightexports.sGui:createGuiElement("label", x + sightexports.sGui:getLabelTextWidth(label), y, 0, 0, groupPanel)
  sightexports.sGui:setLabelFont(label, groupFonts[5])
  sightexports.sGui:setLabelAlignment(label, "left", "top")
  sightexports.sGui:setLabelColor(label, "sightblue")
  sightexports.sGui:setLabelText(label, #groupInteriors)
  y = y + sightexports.sGui:getLabelFontHeight(label) + dashboardPadding[3]
  if groupDatas[selectedGroup].isLeader or sightexports.sGroups:getPlayerPermissionInGroup(selectedGroup, "manageGroupBalance") then
    y = y + dashboardPadding[3] * 2
    local label = sightexports.sGui:createGuiElement("label", x, y, 0, 0, groupPanel)
    sightexports.sGui:setLabelFont(label, groupFonts[2])
    sightexports.sGui:setLabelAlignment(label, "left", "top")
    sightexports.sGui:setLabelText(label, "Pénzügyek")
    y = y + sightexports.sGui:getLabelFontHeight(label) + dashboardPadding[3]
    y = y + dashboardPadding[3]
    local label = sightexports.sGui:createGuiElement("label", x, y, 0, 0, groupPanel)
    sightexports.sGui:setLabelFont(label, groupFonts[4])
    sightexports.sGui:setLabelAlignment(label, "left", "top")
    sightexports.sGui:setLabelText(label, "Egyenleg: ")
    local x2 = x + sightexports.sGui:getLabelTextWidth(label)
    local label = sightexports.sGui:createGuiElement("label", x2, y, 0, 0, groupPanel)
    sightexports.sGui:setLabelFont(label, groupFonts[5])
    sightexports.sGui:setLabelAlignment(label, "left", "top")
    if groupDatas[selectedGroup].balance and 0 <= groupDatas[selectedGroup].balance then
      sightexports.sGui:setLabelColor(label, "sightgreen")
    else
      sightexports.sGui:setLabelColor(label, "sightred")
    end
    sightexports.sGui:setLabelText(label, sightexports.sGui:thousandsStepper(groupDatas[selectedGroup].balance or 0) .. " $")
    local fh = sightexports.sGui:getLabelFontHeight(label)
    local btn = sightexports.sGui:createGuiElement("button", x2 + 6 + sightexports.sGui:getLabelTextWidth(label), y + fh / 2 - 12, 24, 24, groupPanel)
    sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
    sightexports.sGui:setGuiHover(btn, "gradient", {
      "sightgreen",
      "sightgreen-second"
    }, false, true)
    sightexports.sGui:setButtonFont(btn, groupFonts[1])
    sightexports.sGui:guiSetTooltip(btn, "Kasszakezelés")
    sightexports.sGui:setClickEvent(btn, "openGroupBalanceModal")
    sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("coins", 24))
    y = y + fh + dashboardPadding[3]
    local label = sightexports.sGui:createGuiElement("label", x, y, 0, 0, groupPanel)
    sightexports.sGui:setLabelFont(label, groupFonts[4])
    sightexports.sGui:setLabelAlignment(label, "left", "top")
    sightexports.sGui:setLabelText(label, "Állami támogatás: ")
    local label = sightexports.sGui:createGuiElement("label", x + sightexports.sGui:getLabelTextWidth(label), y, 0, 0, groupPanel)
    sightexports.sGui:setLabelFont(label, groupFonts[5])
    sightexports.sGui:setLabelAlignment(label, "left", "top")
    sightexports.sGui:setLabelColor(label, "sightgreen")
    sightexports.sGui:setLabelText(label, sightexports.sGui:thousandsStepper(groupDatas[selectedGroup].aid or 0) .. " $ / online tag / óra")
    y = y + sightexports.sGui:getLabelFontHeight(label) + dashboardPadding[3]
    local label = sightexports.sGui:createGuiElement("label", x, y, 0, 0, groupPanel)
    sightexports.sGui:setLabelFont(label, groupFonts[4])
    sightexports.sGui:setLabelAlignment(label, "left", "top")
    sightexports.sGui:setLabelText(label, "Adó: ")
    local label = sightexports.sGui:createGuiElement("label", x + sightexports.sGui:getLabelTextWidth(label), y, 0, 0, groupPanel)
    sightexports.sGui:setLabelFont(label, groupFonts[5])
    sightexports.sGui:setLabelAlignment(label, "left", "top")
    sightexports.sGui:setLabelColor(label, "sightred")
    sightexports.sGui:setLabelText(label, sightexports.sGui:thousandsStepper(groupDatas[selectedGroup].tax or 0) .. " $ / óra")
    y = y + dashboardPadding[3]
  end
  y = y + dashboardPadding[3] * 4
  local border = sightexports.sGui:createGuiElement("hr", (sx - menuW) / 2 - 1, 88 + dashboardPadding[3] * 2, 2, y - 40 - 48 - dashboardPadding[3] * 2, groupPanel)
  y = y + dashboardPadding[3] * 4
  local border = sightexports.sGui:createGuiElement("hr", dashboardPadding[3] * 4, y - 1, sx - menuW - dashboardPadding[3] * 8, 2, groupPanel)
  y = y + dashboardPadding[3] * 6
  local label = sightexports.sGui:createGuiElement("label", x, y, 0, 0, groupPanel)
  sightexports.sGui:setLabelFont(label, groupFonts[2])
  sightexports.sGui:setLabelAlignment(label, "left", "top")
  sightexports.sGui:setLabelText(label, "Leírás")
  y = y + sightexports.sGui:getLabelFontHeight(label) + dashboardPadding[3] * 2
  local w, h = sx - menuW - dashboardPadding[3] * 4 * 2, sy - y - dashboardPadding[3] * 4
  local rect = sightexports.sGui:createGuiElement("rectangle", dashboardPadding[3] * 4, y, w, h, groupPanel)
  sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey1")
  local label = sightexports.sGui:createGuiElement("label", dashboardPadding[3], dashboardPadding[3], w - dashboardPadding[3] * 2, h - dashboardPadding[3] * 2, rect)
  sightexports.sGui:setLabelFont(label, groupFonts[6])
  sightexports.sGui:setLabelAlignment(label, "left", "top")
  sightexports.sGui:setLabelWordBreak(label, true)
  sightexports.sGui:setLabelText(label, groupDatas[selectedGroup].motd)
  if groupDatas[selectedGroup].isLeader then
    groupDescriptionInput = sightexports.sGui:createGuiElement("input", 0, 0, w, h, rect)
    sightexports.sGui:setInputFont(groupDescriptionInput, groupFonts[6])
    sightexports.sGui:setInputPlaceholder(groupDescriptionInput, "Leírás")
    sightexports.sGui:setInputMaxLength(groupDescriptionInput, 1000)
    sightexports.sGui:setInputMultiline(groupDescriptionInput, true)
    sightexports.sGui:setInputFontPaddingHeight(groupDescriptionInput, 32)
    sightexports.sGui:disableClickTrough(groupDescriptionInput, true)
    sightexports.sGui:setInputValue(groupDescriptionInput, groupDatas[selectedGroup].motd)
    sightexports.sGui:setGuiRenderDisabled(groupDescriptionInput, true)
    local btn = sightexports.sGui:createGuiElement("button", w - 24, h - 24, 24, 24, rect)
    sightexports.sGui:setGuiBackground(btn, "solid", "sightblue")
    sightexports.sGui:setGuiHover(btn, "gradient", {
      "sightblue",
      "sightblue-second"
    }, false, true)
    sightexports.sGui:setButtonFont(btn, groupFonts[1])
    sightexports.sGui:disableClickTrough(btn, true)
    sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("pen", 24))
    sightexports.sGui:setClickEvent(btn, "editGroupMOTD")
    sightexports.sGui:guiSetTooltip(btn, "Leírás szerkesztése")
  end
end
addEvent("doneGatesMembersEdit", false)
addEventHandler("doneGatesMembersEdit", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  sightexports.sGui:deleteGuiElement(el)
  createGroupLoader()
  local members = {}
  for i = 1, #gatesMembersList do
    if gatesMembersList[i] and gatesMembersList[i][4] then
      table.insert(members, gatesMembersList[i][1])
    end
  end
  triggerLatentServerEvent("editGroupGatesMembers", localPlayer, selectedGroup, selectedGate, members)
end)
addEvent("selectGatesMemberCheckbox", false)
addEventHandler("selectGatesMemberCheckbox", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  for i = 1, #gatesMemberElements do
    if gatesMemberElements[i][3] == el then
      if gatesMembersList[i + gatesMemberScroll] then
        gatesMembersList[i + gatesMemberScroll][4] = sightexports.sGui:isCheckboxChecked(el)
        processGroupGatesMemberList()
      end
      return
    end
  end
end)
addEvent("editGatesPermissions", false)
addEventHandler("editGatesPermissions", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  if not selectedGate then
    return
  else
    local found = false
    for i = 1, #groupGates do
      if groupGates[i] == selectedGate then
        found = true
        break
      end
    end
    if not found then
      return
    end
  end
  gateMemberEditing = true
  table.sort(interiorMemberList, groupVehicleMemberSortEx)
  processGroupGatesMemberList()
  sightexports.sGui:setImageFile(gatePermissionEditButton, sightexports.sGui:getFaIconFilename("save", 32))
  sightexports.sGui:setClickEvent(gatePermissionEditButton, "doneGatesMembersEdit")
end)
function processGroupGatesMemberList()
  local w, h = sightexports.sGui:getGuiSize(gatesMemberBg)
  local n = math.max(0, #gatesMembersList - #gatesMemberElements)
  h = h / (n + 1)
  if n < gatesMemberScroll then
    gatesMemberScroll = n
  end
  sightexports.sGui:setGuiSize(gatesMemberScrollBar, false, h)
  sightexports.sGui:setGuiPosition(gatesMemberScrollBar, false, h * gatesMemberScroll)
  for i = 1, #gatesMemberElements do
    if gatesMembersList[i + gatesMemberScroll] then
      local hasPerm = gatesMembersList[i + gatesMemberScroll][4]
      sightexports.sGui:setGuiRenderDisabled(gatesMemberElements[i][1], false)
      sightexports.sGui:setGuiRenderDisabled(gatesMemberElements[i][2], false)
      local label = gatesMemberElements[i][1]
      sightexports.sGui:setLabelText(label, gatesMembersList[i + gatesMemberScroll][2])
      local w, h = sightexports.sGui:getGuiSize(label)
      sightexports.sGui:setLabelColor(label, hasPerm and "#ffffff" or "sightmidgrey")
      local label = gatesMemberElements[i][2]
      local rank = gatesMembersList[i + gatesMemberScroll][3]
      sightexports.sGui:setLabelColor(label, hasPerm and "sight" .. (groupDatas[selectedGroup].rankColors[rank] or "blue") or "sightmidgrey")
      sightexports.sGui:setLabelText(label, (groupDatas[selectedGroup].ranks[rank] or "N/A") .. " [" .. rank .. "]")
      local checkbox = gatesMemberElements[i][3]
      if gateMemberEditing then
        sightexports.sGui:setGuiRenderDisabled(checkbox, false)
        sightexports.sGui:setCheckboxChecked(checkbox, hasPerm)
        sightexports.sGui:setGuiSize(label, w - h, false)
      else
        sightexports.sGui:setGuiRenderDisabled(checkbox, true)
        sightexports.sGui:setGuiSize(label, w, false)
      end
      if gatesMemberElements[i][4] then
        sightexports.sGui:setGuiRenderDisabled(gatesMemberElements[i][4], false)
      end
    else
      sightexports.sGui:setGuiRenderDisabled(gatesMemberElements[i][1], true)
      sightexports.sGui:setGuiRenderDisabled(gatesMemberElements[i][2], true)
      sightexports.sGui:setGuiRenderDisabled(gatesMemberElements[i][3], true)
      if gatesMemberElements[i][4] then
        sightexports.sGui:setGuiRenderDisabled(gatesMemberElements[i][4], true)
      end
    end
  end
end
addEvent("selectGroupGate", false)
addEventHandler("selectGroupGate", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  for i = 1, #gatesElements do
    if gatesElements[i][1] == el and groupGates[i + gatesScroll] then
      selectedGate = groupGates[i + gatesScroll]
      gatesMemberScroll = 0
      processGroupGatesList()
      processSelectedGate()
      return
    end
  end
end)
function processSelectedGate()
  gateMemberEditing = false
  if selectedGate then
    for i = 1, #groupGates do
      if groupGates[i] == selectedGate then
        gatesMembersList = {}
        for i = 1, #groupDatas[selectedGroup].members do
          if not groupDatas[selectedGroup].members[i][3] then
            table.insert(gatesMembersList, {
              groupDatas[selectedGroup].members[i][7],
              groupDatas[selectedGroup].members[i][1],
              groupDatas[selectedGroup].members[i][2],
              groupDatas[selectedGroup].gateMembers[selectedGate][groupDatas[selectedGroup].members[i][8]]
            })
          end
        end
        table.sort(gatesMembersList, groupVehicleMemberSort)
        sightexports.sGui:setLabelText(gateNameLabel, "Kapu #" .. selectedGate)
        processGroupGatesMemberList()
        return
      end
    end
  end
  sightexports.sGui:setLabelText(gateNameLabel, "Válassz kaput!")
  for i = 1, #gatesMemberElements do
    sightexports.sGui:setGuiRenderDisabled(gatesMemberElements[i][1], true)
    sightexports.sGui:setGuiRenderDisabled(gatesMemberElements[i][2], true)
    if gatesMemberElements[i][3] then
      sightexports.sGui:setGuiRenderDisabled(gatesMemberElements[i][3], true)
    end
  end
end
function processGroupGatesList()
  local w, h = sightexports.sGui:getGuiSize(gatesBg)
  local n = math.max(0, #groupGates - #interiorElements)
  h = h / (n + 1)
  if n < gatesScroll then
    gatesScroll = n
  end
  sightexports.sGui:setGuiSize(gatesScrollBar, false, h)
  sightexports.sGui:setGuiPosition(gatesScrollBar, false, h * gatesScroll)
  for i = 1, #gatesElements do
    if groupGates[i + gatesScroll] then
      sightexports.sGui:setGuiRenderDisabled(gatesElements[i][1], false)
      sightexports.sGui:setGuiRenderDisabled(gatesElements[i][2], false)
      if gatesElements[i][3] then
        sightexports.sGui:setGuiRenderDisabled(gatesElements[i][3], false)
      end
      if not selectedGate then
        selectedGate = groupGates[i + gatesScroll]
      end
      local rect = gatesElements[i][1]
      if groupGates[i + gatesScroll] == selectedGate then
        sightexports.sGui:setGuiHoverable(rect, false)
        sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey3")
      else
        sightexports.sGui:setGuiHoverable(rect, true)
        sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey1")
      end
      local label = gatesElements[i][2]
      sightexports.sGui:setLabelText(label, "Kapu #" .. groupGates[i + gatesScroll])
    else
      sightexports.sGui:setGuiRenderDisabled(gatesElements[i][1], true)
      sightexports.sGui:setGuiRenderDisabled(gatesElements[i][2], true)
      if gatesElements[i][3] then
        sightexports.sGui:setGuiRenderDisabled(gatesElements[i][3], true)
      end
    end
  end
end
function drawGroupGates()
  local label = sightexports.sGui:createGuiElement("label", dashboardPadding[3] * 4, 40, 0, 48, groupPanel)
  sightexports.sGui:setLabelFont(label, groupFonts[3])
  sightexports.sGui:setLabelAlignment(label, "left", "center")
  sightexports.sGui:setLabelText(label, "Kapuk: " .. #groupGates)
  local w = math.ceil((sx - menuW) * 0.45)
  local h = sy - 40 - dashboardPadding[3] * 8 - 48
  gatesBg = sightexports.sGui:createGuiElement("rectangle", dashboardPadding[3] * 4, 88 + dashboardPadding[3] * 4, w, h, groupPanel)
  sightexports.sGui:setGuiBackground(gatesBg, "solid", "sightgrey1")
  local sbg = sightexports.sGui:createGuiElement("rectangle", w - 2, 0, 2, h, gatesBg)
  sightexports.sGui:setGuiBackground(sbg, "solid", "sightgrey3")
  gatesScrollBar = sightexports.sGui:createGuiElement("rectangle", w - 2, 0, 2, h, gatesBg)
  sightexports.sGui:setGuiBackground(gatesScrollBar, "solid", "sightmidgrey")
  local n = math.floor(h / 32)
  h = h / n
  gatesElements = {}
  y = 0
  for i = 1, n do
    if groupGates[i] then
      gatesElements[i] = {}
      local rect = sightexports.sGui:createGuiElement("rectangle", 0, y, w - 2, h - 1, gatesBg)
      sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey1")
      sightexports.sGui:setGuiHover(rect, "gradient", {"sightgrey1", "sightgrey2"}, false, true)
      sightexports.sGui:setGuiHoverable(rect, true)
      sightexports.sGui:setClickEvent(rect, "selectGroupGate")
      gatesElements[i][1] = rect
      local label = sightexports.sGui:createGuiElement("label", dashboardPadding[3] * 2, 0, 0, h, rect)
      sightexports.sGui:setLabelFont(label, groupFonts[4])
      sightexports.sGui:setLabelAlignment(label, "left", "center")
      gatesElements[i][2] = label
      if i < n then
        local border = sightexports.sGui:createGuiElement("hr", 0, h - 1, w - 2, 2, rect)
        sightexports.sGui:setGuiHrColor(border, "sightgrey3", "sightgrey2")
        gatesElements[i][3] = border
      end
    end
    y = y + h
  end
  x = dashboardPadding[3] * 4 + w
  y = 88 + dashboardPadding[3] * 4
  local w = sx - menuW - x
  x = x + dashboardPadding[3] * 4
  gateNameLabel = sightexports.sGui:createGuiElement("label", x, y, w, 0, groupPanel)
  sightexports.sGui:setLabelFont(gateNameLabel, groupFonts[3])
  sightexports.sGui:setLabelAlignment(gateNameLabel, "left", "top")
  y = y + sightexports.sGui:getLabelFontHeight(label) + dashboardPadding[3] * 4
  local label = sightexports.sGui:createGuiElement("label", x, y, 0, 0, groupPanel)
  sightexports.sGui:setLabelFont(label, groupFonts[2])
  sightexports.sGui:setLabelAlignment(label, "left", "top")
  sightexports.sGui:setLabelText(label, "Kapu jogosultságai:")
  local h = sightexports.sGui:getLabelFontHeight(label)
  w = w - dashboardPadding[3] * 4 * 2
  if groupDatas[selectedGroup].isLeader or sightexports.sGroups:getPlayerPermissionInGroup(selectedGroup, "manageKeysGate") then
    gatePermissionEditButton = sightexports.sGui:createGuiElement("image", x + w - h, y, h, h, groupPanel)
    sightexports.sGui:setImageFile(gatePermissionEditButton, sightexports.sGui:getFaIconFilename("pen", 32))
    sightexports.sGui:setGuiHover(gatePermissionEditButton, "solid", "sightgreen")
    sightexports.sGui:setGuiHoverable(gatePermissionEditButton, true)
    sightexports.sGui:setClickEvent(gatePermissionEditButton, "editGatesPermissions")
    sightexports.sGui:guiSetTooltip(gatePermissionEditButton, "Kapu jogosultságainak szerkesztése")
  else
    gatePermissionEditButton = false
  end
  y = y + h + dashboardPadding[3] * 2
  local h = sy - y - dashboardPadding[3] * 4
  local n = math.floor(h / 32)
  h = h / n
  gatesMemberBg = sightexports.sGui:createGuiElement("rectangle", x, y, w, h * n, groupPanel)
  sightexports.sGui:setGuiBackground(gatesMemberBg, "solid", "sightgrey1")
  local border = sightexports.sGui:createGuiElement("hr", 0, -1, w, 2, gatesMemberBg)
  sightexports.sGui:setGuiHrColor(border, "sightgrey3", "sightgrey2")
  local sbg = sightexports.sGui:createGuiElement("rectangle", w - 2, 0, 2, h * n, gatesMemberBg)
  sightexports.sGui:setGuiBackground(sbg, "solid", "sightgrey3")
  gatesMemberScrollBar = sightexports.sGui:createGuiElement("rectangle", w - 2, 0, 2, h * n, gatesMemberBg)
  sightexports.sGui:setGuiBackground(gatesMemberScrollBar, "solid", "sightmidgrey")
  gatesMemberElements = {}
  y = 0
  for i = 1, n do
    gatesMemberElements[i] = {}
    local label = sightexports.sGui:createGuiElement("label", dashboardPadding[3] * 2, y, w - dashboardPadding[3] * 2 - 2, h, gatesMemberBg)
    sightexports.sGui:setLabelFont(label, groupFonts[4])
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    gatesMemberElements[i][1] = label
    local label = sightexports.sGui:createGuiElement("label", 0, y, 0, h, gatesMemberBg)
    sightexports.sGui:setLabelFont(label, groupFonts[5])
    sightexports.sGui:setLabelAlignment(label, "right", "center")
    gatesMemberElements[i][2] = label
    local checkbox = sightexports.sGui:createGuiElement("checkbox", 0 + w - h - 2, y + 2, h - 4, h - 4, gatesMemberBg)
    sightexports.sGui:setGuiColorScheme(checkbox, "darker")
    sightexports.sGui:setClickEvent(checkbox, "selectGatesMemberCheckbox")
    gatesMemberElements[i][3] = checkbox
    if n > i then
      local border = sightexports.sGui:createGuiElement("hr", 0, y + h - 1, w - 2, 2, gatesMemberBg)
      sightexports.sGui:setGuiHrColor(border, "sightgrey3", "sightgrey2")
      gatesMemberElements[i][4] = border
    end
    y = y + h
  end
  processGroupGatesList()
  processSelectedGate()
end
function drawGroupPanel()
  deleteGroupLoader()
  if groupModal then
    sightexports.sGui:deleteGuiElement(groupModal)
  end
  groupModal = false
  if groupPanel then
    sightexports.sGui:deleteGuiElement(groupPanel)
  end
  groupDescriptionInput = false
  menuButtons = {}
  if selectedGroup and groupDatas[selectedGroup] then
    groupPanel = sightexports.sGui:createGuiElement("null", menuW, 0, sx - menuW, sy, inside)
    local x = 0
    local w = (sx - menuW) / 6
    local btn = sightexports.sGui:createGuiElement("button", x, 0, w, 40, groupPanel)
    if selectedMenu == "home" then
      sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
      sightexports.sGui:setGuiHoverable(btn, false)
    else
      sightexports.sGui:setGuiBackground(btn, "solid", "sightgrey1")
      sightexports.sGui:setGuiHover(btn, "gradient", {"sightgrey2", "sightgrey1"}, false, true)
      sightexports.sGui:setClickEvent(btn, "switchGroupPanelMenu")
    end
    sightexports.sGui:setButtonFont(btn, groupFonts[1])
    sightexports.sGui:setButtonTextColor(btn, "#ffffff")
    sightexports.sGui:setButtonText(btn, " Kezdőlap")
    sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("home", 40))
    menuButtons[btn] = "home"
    x = x + w
    local btn = sightexports.sGui:createGuiElement("button", x, 0, w, 40, groupPanel)
    if selectedMenu == "members" then
      sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
      sightexports.sGui:setGuiHoverable(btn, false)
    else
      sightexports.sGui:setGuiBackground(btn, "solid", "sightgrey1")
      sightexports.sGui:setGuiHover(btn, "gradient", {"sightgrey2", "sightgrey1"}, false, true)
      sightexports.sGui:setClickEvent(btn, "switchGroupPanelMenu")
    end
    sightexports.sGui:setButtonFont(btn, groupFonts[1])
    sightexports.sGui:setButtonTextColor(btn, "#ffffff")
    sightexports.sGui:setButtonText(btn, " Tagok")
    sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("users", 40))
    menuButtons[btn] = "members"
    x = x + w
    local btn = sightexports.sGui:createGuiElement("button", x, 0, w, 40, groupPanel)
    if selectedMenu == "ranks" then
      sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
      sightexports.sGui:setGuiHoverable(btn, false)
    else
      sightexports.sGui:setGuiBackground(btn, "solid", "sightgrey1")
      sightexports.sGui:setGuiHover(btn, "gradient", {"sightgrey2", "sightgrey1"}, false, true)
      sightexports.sGui:setClickEvent(btn, "switchGroupPanelMenu")
    end
    sightexports.sGui:setButtonFont(btn, groupFonts[1])
    sightexports.sGui:setButtonTextColor(btn, "#ffffff")
    sightexports.sGui:setButtonText(btn, " Rangok")
    sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("id-badge", 40))
    menuButtons[btn] = "ranks"
    x = x + w
    local btn = sightexports.sGui:createGuiElement("button", x, 0, w, 40, groupPanel)
    if selectedMenu == "vehicles" then
      sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
      sightexports.sGui:setGuiHoverable(btn, false)
    else
      sightexports.sGui:setGuiBackground(btn, "solid", "sightgrey1")
      sightexports.sGui:setGuiHover(btn, "gradient", {"sightgrey2", "sightgrey1"}, false, true)
      sightexports.sGui:setClickEvent(btn, "switchGroupPanelMenu")
    end
    sightexports.sGui:setButtonFont(btn, groupFonts[1])
    sightexports.sGui:setButtonTextColor(btn, "#ffffff")
    sightexports.sGui:setButtonText(btn, " Járművek")
    sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("car", 40))
    menuButtons[btn] = "vehicles"
    x = x + w
    local btn = sightexports.sGui:createGuiElement("button", x, 0, w, 40, groupPanel)
    if selectedMenu == "interiors" then
      sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
      sightexports.sGui:setGuiHoverable(btn, false)
    else
      sightexports.sGui:setGuiBackground(btn, "solid", "sightgrey1")
      sightexports.sGui:setGuiHover(btn, "gradient", {"sightgrey2", "sightgrey1"}, false, true)
      sightexports.sGui:setClickEvent(btn, "switchGroupPanelMenu")
    end
    sightexports.sGui:setButtonFont(btn, groupFonts[1])
    sightexports.sGui:setButtonTextColor(btn, "#ffffff")
    sightexports.sGui:setButtonText(btn, " Interiorok")
    sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("building", 40))
    menuButtons[btn] = "interiors"
    x = x + w
    local btn = sightexports.sGui:createGuiElement("button", x, 0, w, 40, groupPanel)
    if selectedMenu == "gates" then
      sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
      sightexports.sGui:setGuiHoverable(btn, false)
    else
      sightexports.sGui:setGuiBackground(btn, "solid", "sightgrey1")
      sightexports.sGui:setGuiHover(btn, "gradient", {"sightgrey2", "sightgrey1"}, false, true)
      sightexports.sGui:setClickEvent(btn, "switchGroupPanelMenu")
    end
    sightexports.sGui:setButtonFont(btn, groupFonts[1])
    sightexports.sGui:setButtonTextColor(btn, "#ffffff")
    sightexports.sGui:setButtonText(btn, " Kapuk")
    sightexports.sGui:setButtonIconDDS(btn, ":sGates/files/icon.dds")
    menuButtons[btn] = "gates"
    if selectedMenu == "home" then
      drawGroupHome()
    elseif selectedMenu == "members" then
      drawGroupMembers()
    elseif selectedMenu == "ranks" then
      drawGroupRanks()
    elseif selectedMenu == "vehicles" then
      drawGroupVehicles()
    elseif selectedMenu == "interiors" then
      drawGroupInteriors()
    elseif selectedMenu == "gates" then
      drawGroupGates()
    end
  else
    groupPanel = false
  end
end
function processSideMenu()
  for el, group in pairs(sideMenu) do
    if selectedGroup == group then
      sightexports.sGui:setGuiBackground(el, "solid", "sightgrey2")
      sightexports.sGui:setGuiHoverable(el, false)
    else
      sightexports.sGui:setGuiBackground(el, "solid", "sightgrey1")
      sightexports.sGui:setGuiHoverable(el, true)
      sightexports.sGui:setClickEvent(el, "switchGroupPanelGroup")
    end
  end
end
function drawGroupSideMenu()
  for el in pairs(sideMenu) do
    if el then
      sightexports.sGui:deleteGuiElement(el)
    end
  end
  sideMenu = {}
  local n = math.max(10, #groupList)
  local h = sy / n
  if not selectedGroup then
    selectedGroup = groupList[1] and groupList[1][1]
    requestSelectedGroup()
    selectedMenu = "home"
    processSideMenu()
    createGroupLoader()
  end
  for i = 1, n do
    if groupList[i] then
      local bcg = sightexports.sGui:createGuiElement("rectangle", 0, (i - 1) * h, menuW, h, inside)
      sightexports.sGui:setGuiHover(bcg, "gradient", {"sightgrey4", "sightgrey1"}, false, true)
      if selectedGroup == groupList[i][1] then
        sightexports.sGui:setGuiBackground(bcg, "solid", "sightgrey4")
      else
        sightexports.sGui:setGuiBackground(bcg, "solid", "sightgrey1")
        sightexports.sGui:setGuiHoverable(bcg, true)
        sightexports.sGui:setClickEvent(bcg, "switchGroupPanelGroup")
      end
      sideMenu[bcg] = groupList[i][1]
      local label = sightexports.sGui:createGuiElement("label", 0, 0, menuW, h, bcg)
      sightexports.sGui:setLabelFont(label, groupFonts[2])
      sightexports.sGui:setLabelAlignment(label, "center", "center")
      if sightexports.sGui:getTextWidthFont(groupList[i][2], groupFonts[2]) > menuW - 16 then
        sightexports.sGui:setLabelText(label, groupList[i][1])
      else
        sightexports.sGui:setLabelText(label, groupList[i][2])
      end
    end
  end
end
function drawGroups()
  menuW = math.floor(sx * 0.27)
  if inside then
    sightexports.sGui:deleteGuiElement(inside)
  end
  inside = sightexports.sGui:createGuiElement("null", 0, 0, sx, sy, rtg)
  local rect = sightexports.sGui:createGuiElement("rectangle", menuW, 0, sx - menuW, sy, inside)
  sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey2")
  local rect = sightexports.sGui:createGuiElement("rectangle", 0, 0, menuW, sy, inside)
  sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey1")
  drawGroupSideMenu()
  drawGroupPanel()
end
function resetGroupGuiValues()
  groupDescriptionInput = false
  groupLoader = false
  groupLoaderIcon = false
  groupModal = false
  groupPanel = false
  interiorDataBg = false
  interiorDataButton = false
  interiorMemberBg = false
  interiorMemberButton = false
  interiorMemberEditButton = false
  interiorMemberScrollBar = false
  interiorNameLabel = false
  interiorsBg = false
  interiorSidePanel = false
  interiorsScrollBar = false
  interiorTypeLabel = false
  memberAddedLabel = false
  memberBg = false
  memberFireButton = false
  memberLastOnlineLabel = false
  memberLeaderLabel = false
  memberNameLabel = false
  memberPromotedLabel = false
  memberRankEdit = false
  memberRankLabel = false
  memberSalaryLabel = false
  memberScrollBar = false
  newMemberInput = false
  groupBalanceInput = false
  perMemberBg = false
  perMemberScrollBar = false
  rankBg = false
  rankDeleteButton = false
  rankUpButton = false
  rankDownButton = false
  rankEditButton = false
  rankNameInput = false
  rankNameLabel = false
  rankNumLabel = false
  rankPermBg = false
  rankPermissionEditButton = false
  rankPermScrollbar = false
  rankSalaryInput = false
  rankSalaryLabel = false
  rankScrollbar = false
  vehicleDataBg = false
  vehicleDataButton = false
  vehicleMemberBg = false
  vehicleMemberButton = false
  vehicleMemberEditButton = false
  vehicleMemberScrollBar = false
  vehicleNameLabel = false
  vehiclePlateLabel = false
  vehiclesBg = false
  vehicleSidePanel = false
  vehiclesScrollBar = false
  gateMemberEditing = false
  gateNameLabel = false
  gatePermissionEditButton = false
end
function resetGroupGuiValues2()
  sideMenu = {}
  memberElements = {}
  rankElements = {}
  rankEditColorElements = {}
  vehicleElements = {}
  vehicleMemberElements = {}
  interiorElements = {}
  interiorMemberElements = {}
  gatesElements = {}
  gatesMemberElements = {}
end
function groupsInsideDestroy()
  inside = false
  rtg = false
  resetGroupGuiValues()
  resetGroupGuiValues2()
  removeEventHandler("onClientKey", getRootElement(), groupPanelScrollKey)
end
function groupsInsideDraw(x, y, isx, isy, i, j, irtg)
  rtg = irtg
  sx, sy = isx, isy
  addEventHandler("onClientKey", getRootElement(), groupPanelScrollKey)
  drawGroups()
  createGroupLoader()
  triggerServerEvent("requestPlayerGroupList", localPlayer)
end
