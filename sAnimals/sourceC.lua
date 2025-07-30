local seexports = {
  sGui = false,
  sWebdebug = false,
  sItems = false
}
local function sightlangProcessExports()
  for k in pairs(seexports) do
    local res = getResourceFromName(k)
    if res and getResourceState(res) == "running" then
      seexports[k] = exports[k]
    else
      seexports[k] = false
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
local titleBarHeight = false
local function sightlangGuiRefreshColors()
  local res = getResourceFromName("sGui")
  if res and getResourceState(res) == "running" then
    titleBarHeight = seexports.sGui:getTitleBarHeight(nil)
  end
end
addEventHandler("onGuiRefreshColors", getRootElement(), sightlangGuiRefreshColors)
addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangGuiRefreshColors)
local screenX, screenY = guiGetScreenSize()
local panelState = false
local panelWidth = 200
local panelHeight = 320
local panelPosX = screenX / 2
local panelPosY = screenY / 2
local panelMargin = 3
local animalElement = false
local panelFont = false
local moveDifferenceX, moveDifferenceY = 0, 0
local isMoving = false
local animalTimer = false
local feedPanel = false
local playerPanelState = false
local playerPanelWidth = 200
local playerPanelHeight = 140
local playerPanelPosX = screenX / 2
local playerPanelPosY = screenY / 2
local actionBarWidth = 286
addEventHandler("onClientResourceStart", getResourceRootElement(), function()
  if isTimer(animalTimer) then
    killTimer(animalTimer)
  end
  animalTimer = setTimer(function()
    local characterId = getElementData(localPlayer, "char.ID")
    if characterId then
      local animalElement = getElementByID("animal_" .. characterId)
      if isElement(animalElement) then
        local currentHunger = getElementData(animalElement, "animal.hunger") - 1
        local currentLove = getElementData(animalElement, "animal.love")
        if currentLove == 0 then
          setElementData(animalElement, "animal.obedient", false, true)
        else
          setElementData(animalElement, "animal.love", currentLove - 1, true)
        end
        if currentHunger <= 0 then
          setElementData(animalElement, "animal.hunger", 0, true)
          triggerServerEvent("animalStarvedToDeath", localPlayer, animalElement, getElementData(animalElement, "animal.animalId"))
        end
        setElementData(animalElement, "animal.hunger", currentHunger, true)
      end
    end
  end, 360000, 0)
end)
local animalPanelState = false
addEventHandler("onClientClick", getRootElement(), function(button, state, absoluteX, absoluteY, worldX, worldY, worldZ, clickedElement)
  if state == "up" and not animalPanelState and button == "right" and isElement(clickedElement) then
    if getElementType(clickedElement) == "ped" then
      local animalId = getElementData(clickedElement, "animal.animalId")
      if animalId then
        local playerPosX, playerPosY, playerPosZ = getElementPosition(localPlayer)
        local targetPosX, targetPosY, targetPosZ = getElementPosition(clickedElement)
        if getDistanceBetweenPoints3D(playerPosX, playerPosY, playerPosZ, targetPosX, targetPosY, targetPosZ) <= 5 then
          feeding = false
          panelPosX = absoluteX
          panelPosY = absoluteY
          animalElement = clickedElement
          createAnimalPanel()
          animalPanelState = true
        end
      end
    elseif getElementType(clickedElement) == "player" and clickedElement ~= localPlayer then
      local characterId = getElementData(localPlayer, "char.ID")
      if characterId then
        local myAnimal = getElementByID("animal_" .. characterId)
        if isElement(myAnimal) then
          local playerPosX, playerPosY, playerPosZ = getElementPosition(localPlayer)
          local targetPosX, targetPosY, targetPosZ = getElementPosition(clickedElement)
          if getDistanceBetweenPoints3D(playerPosX, playerPosY, playerPosZ, targetPosX, targetPosY, targetPosZ) <= 5 then
            playerPanelPosX = absoluteX
            playerPanelPosY = absoluteY
            playerAnimalElement = clickedElement
            createPlayerPanel()
            animalPanelState = true
          end
        end
      end
    end
  end
end)
addEventHandler("onClientPedDamage", getRootElement(), function(attacker)
  if isElement(attacker) and getElementData(source, "animal.animalId") then
    local characterId = getElementData(localPlayer, "char.ID")
    local attackerId = getElementData(attacker, "char.ID")
    if characterId then
      local ownerId = getElementData(source, "animal.ownerId")
      if ownerId and tonumber(ownerId) == tonumber(characterId) then
        local currentTask = getElementData(source, "ped.task.1")
        if attackerId == ownerId then
          return
        end
        if currentTask then
          if currentTask[1] ~= "killPed" then
            setPedTask(source, {
              "killPed",
              attacker,
              5,
              1
            })
            seexports.sGui:showInfobox("w", "Valaki bántja a peted!")
          end
        else
          setPedTask(source, {
            "killPed",
            attacker,
            5,
            1
          })
          seexports.sGui:showInfobox("w", "Valaki bántja a peted!")
        end
      end
    end
  end
end)
addEventHandler("onClientPlayerDamage", getRootElement(), function(attacker)
  if source == localPlayer and isElement(attacker) then
    local characterId = getElementData(localPlayer, "char.ID")
    if characterId then
      myAnimal = getElementByID("animal_" .. characterId)
      if isElement(myAnimal) then
        local playerX, playerY, playerZ = getElementPosition(localPlayer)
        local animalX, animalY, animalZ = getElementPosition(myAnimal)
        if getDistanceBetweenPoints3D(playerX, playerY, playerZ, animalX, animalY, animalZ) <= 100 then
          local currentTask = getElementData(myAnimal, "ped.task.1")
          if currentTask then
            if currentTask[1] ~= "killPed" then
              setPedTask(myAnimal, {
                "killPed",
                attacker,
                5,
                1
              })
            end
          else
            setPedTask(myAnimal, {
              "killPed",
              attacker,
              5,
              1
            })
          end
        end
      end
    end
  end
end)
local callbackBtn = false
local myAnimal = false
setTimer(function()
  myAnimal = false
  local characterId = getElementData(localPlayer, "char.ID")
  if characterId then
    for k, v in pairs(getElementsByType("ped")) do
      if getElementData(v, "animal.ownerId") == characterId then
        myAnimal = v
        break
      end
    end
  end
  if not myAnimal then
    if callbackBtn then
      seexports.sGui:deleteGuiElement(callbackBtn)
    end
    callbackBtn = nil
  end
end, 1000, 0)
addEvent("callbackBtnPet", true)
addEventHandler("callbackBtnPet", getRootElement(), function()
  local characterId = getElementData(localPlayer, "char.ID")
  if characterId then
    clickAnimal = getElementByID("animal_" .. characterId)
  end
  if isElement(clickAnimal) then
    local currentTask = getElementData(clickAnimal, "ped.task.1")
    if currentTask and currentTask[1] == "killPed" then
      setPedTask(clickAnimal, {
        "walkFollowElement",
        localPlayer,
        3
      })
      if callbackBtn then
        seexports.sGui:deleteGuiElement(callbackBtn)
      end
      callbackBtn = nil
    end
  end
end)
addEventHandler("onClientElementDataChange", getResourceRootElement(), function(dataName, oldValue, newValue)
  if source == myAnimal and dataName == "ped.task.1" then
    if newValue and newValue[1] and newValue[1] == "killPed" then
      if callbackBtn then
        seexports.sGui:deleteGuiElement(callbackBtn)
      end
      callbackBtn = nil
      local btn = seexports.sGui:createGuiElement("button", screenX / 2 - actionBarWidth / 2, screenY - 170, actionBarWidth, 30, false)
      seexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
      seexports.sGui:setGuiHover(btn, "gradient", {
        "sightgreen",
        "sightgreen-second"
      }, false, true)
      seexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
      seexports.sGui:setButtonTextColor(btn, "#ffffff")
      seexports.sGui:setButtonText(btn, "Gyere vissza")
      seexports.sGui:setClickEvent(btn, "callbackBtnPet")
      callbackBtn = btn
    elseif oldValue and oldValue[1] and oldValue[1] == "killPed" then
      if callbackBtn then
        seexports.sGui:deleteGuiElement(callbackBtn)
      end
      callbackBtn = nil
    end
  end
end)
local petWindow = false
function playerPanelAttack()
  if isElement(playerAnimalElement) then
    local localX, localY, localZ = getElementPosition(localPlayer)
    local targetX, targetY, targetZ = getElementPosition(playerAnimalElement)
    if getDistanceBetweenPoints3D(localX, localY, localZ, targetX, targetY, targetZ) <= 15 then
      local characterId = getElementData(localPlayer, "char.ID")
      if characterId then
        local myAnimal = getElementByID("animal_" .. characterId)
        if isElement(myAnimal) then
          setPedTask(myAnimal, {
            "killPed",
            playerAnimalElement,
            5,
            1
          })
        end
      end
    else
      seexports.sGui:showInfobox("e", "Túl messze vagy a petedtől!")
    end
    playerPanelState = false
    playerPanelClose()
  end
end
addEvent("playerPanelAttack", true)
addEventHandler("playerPanelAttack", getRootElement(), playerPanelAttack)
function playerPanelClose()
  seexports.sGui:deleteGuiElement(petWindow)
  animalPanelState = false
end
addEvent("playerPanelClose", true)
addEventHandler("playerPanelClose", getRootElement(), playerPanelClose)
function createPlayerPanel()
  local windowWidth, windowHeight = 180, titleBarHeight + 60 + 15
  petWindow = seexports.sGui:createGuiElement("window", playerPanelPosX, playerPanelPosY - titleBarHeight, windowWidth, windowHeight)
  seexports.sGui:setWindowTitle(petWindow, "16/BebasNeueRegular.otf", "SightMTA - Pet")
  local btn = seexports.sGui:createGuiElement("button", 5, titleBarHeight + 5, 170, 30, petWindow)
  seexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
  seexports.sGui:setGuiHover(btn, "gradient", {
    "sightgreen",
    "sightgreen-second"
  }, false, true)
  seexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
  seexports.sGui:setButtonTextColor(btn, "#ffffff")
  seexports.sGui:setButtonText(btn, "Támadás")
  seexports.sGui:setClickEvent(btn, "playerPanelAttack")
  local btn = seexports.sGui:createGuiElement("button", 5, titleBarHeight + 5 + 30 + 5, 170, 30, petWindow)
  seexports.sGui:setGuiBackground(btn, "solid", "sightred")
  seexports.sGui:setGuiHover(btn, "gradient", {
    "sightred",
    "sightred-second"
  }, false, true)
  seexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
  seexports.sGui:setButtonTextColor(btn, "#ffffff")
  seexports.sGui:setButtonText(btn, "Kilépés")
  seexports.sGui:setClickEvent(btn, "playerPanelClose")
  seexports.sGui:setWindowElementMaxDistance(petWindow, playerAnimalElement, 8)
end
local feeding = false
local buttonActions = {}
function createAnimalPanel()
  buttonActions = {}
  local myAnimal = false
  local characterId = getElementData(localPlayer, "char.ID")
  if not characterId then
    return
  end
  local ownAnimalElement = getElementByID("animal_" .. characterId)
  if characterId and isElement(ownAnimalElement) and animalElement == ownAnimalElement then
    myAnimal = true
  end
  local toggleText = "Marad"
  local thisTask = getElementData(animalElement, "ped.thisTask")
  if not thisTask then
    toggleText = "Kövess"
  end
  if not feeding then
    local windowWidth, windowHeight = 180, titleBarHeight + 150 + 25 + 5
    if not myAnimal and isElement(ownAnimalElement) then
      windowHeight = windowHeight + 30 + 5
    end
    petWindow = seexports.sGui:createGuiElement("window", panelPosX, panelPosY - titleBarHeight, windowWidth, windowHeight)
    seexports.sGui:setWindowTitle(petWindow, "16/BebasNeueRegular.otf", "SightMTA - Pet")
    seexports.sGui:setWindowElementMaxDistance(petWindow, animalElement, 8)
    local btn = seexports.sGui:createGuiElement("button", 5, titleBarHeight + 5, 170, 30, petWindow)
    seexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
    seexports.sGui:setGuiHover(btn, "gradient", {
      "sightgreen",
      "sightgreen-second"
    }, false, true)
    seexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
    seexports.sGui:setButtonTextColor(btn, "#ffffff")
    seexports.sGui:setButtonText(btn, toggleText)
    if myAnimal then
      seexports.sGui:setClickEvent(btn, "animalPanelToggle")
    end
    local btn = seexports.sGui:createGuiElement("button", 5, seexports.sGui:getGuiPosition("last", "y") + 35, 170, 30, petWindow)
    seexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
    seexports.sGui:setGuiHover(btn, "gradient", {
      "sightgreen",
      "sightgreen-second"
    }, false, true)
    seexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
    seexports.sGui:setButtonTextColor(btn, "#ffffff")
    seexports.sGui:setButtonText(btn, "Simogatás")
    seexports.sGui:setClickEvent(btn, "animalPanelPet")
    local btn = seexports.sGui:createGuiElement("button", 5, seexports.sGui:getGuiPosition("last", "y") + 35, 170, 30, petWindow)
    seexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
    seexports.sGui:setGuiHover(btn, "gradient", {
      "sightgreen",
      "sightgreen-second"
    }, false, true)
    seexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
    seexports.sGui:setButtonTextColor(btn, "#ffffff")
    seexports.sGui:setButtonText(btn, "Etetés")
    seexports.sGui:setClickEvent(btn, "animalPanelFeed")
    if not myAnimal and isElement(ownAnimalElement) then
      local btn = seexports.sGui:createGuiElement("button", 5, seexports.sGui:getGuiPosition("last", "y") + 35, 170, 30, petWindow)
      seexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
      seexports.sGui:setGuiHover(btn, "gradient", {
        "sightgreen",
        "sightgreen-second"
      }, false, true)
      seexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
      seexports.sGui:setButtonTextColor(btn, "#ffffff")
      seexports.sGui:setButtonText(btn, "Támadás")
      seexports.sGui:setClickEvent(btn, "animalPanelAttack")
    end
    local btn = seexports.sGui:createGuiElement("button", 5, seexports.sGui:getGuiPosition("last", "y") + 35, 170, 30, petWindow)
    seexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
    seexports.sGui:setGuiHover(btn, "gradient", {
      "sightgreen",
      "sightgreen-second"
    }, false, true)
    seexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
    seexports.sGui:setButtonTextColor(btn, "#ffffff")
    seexports.sGui:setButtonText(btn, "Ugattatás")
    if myAnimal then
      seexports.sGui:setClickEvent(btn, "animalPanelBark")
    end
    local btn = seexports.sGui:createGuiElement("button", 5, seexports.sGui:getGuiPosition("last", "y") + 35, 170, 30, petWindow)
    seexports.sGui:setGuiBackground(btn, "solid", "sightred")
    seexports.sGui:setGuiHover(btn, "gradient", {
      "sightred",
      "sightred-second"
    }, false, true)
    seexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
    seexports.sGui:setButtonTextColor(btn, "#ffffff")
    seexports.sGui:setButtonText(btn, "Kilépés")
    seexports.sGui:setClickEvent(btn, "animalPanelClose")
  else
    local windowWidth, windowHeight = 180, titleBarHeight + 150 + 25 + 5
    petWindow = seexports.sGui:createGuiElement("window", panelPosX, panelPosY - titleBarHeight, windowWidth, windowHeight)
    seexports.sGui:setWindowTitle(petWindow, "16/BebasNeueRegular.otf", "SightMTA - Pet")
    seexports.sGui:setWindowElementMaxDistance(petWindow, animalElement, 8)
    local feedingItems = {
      163,
      161,
      162,
      160
    }
    local btn = seexports.sGui:createGuiElement("button", 5, titleBarHeight + 5, 170, 30, petWindow)
    seexports.sGui:setGuiBackground(btn, "solid", "sightblue")
    seexports.sGui:setGuiHover(btn, "gradient", {
      "sightblue",
      "sightblue-second"
    }, false, true)
    seexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
    seexports.sGui:setButtonTextColor(btn, "#ffffff")
    seexports.sGui:setButtonText(btn, seexports.sItems:getItemName(feedingItems[1]))
    seexports.sGui:setClickEvent(btn, "feedPetAction")
    buttonActions[btn] = feedingItems[1]
    for i = 2, #feedingItems do
      local btn = seexports.sGui:createGuiElement("button", 5, seexports.sGui:getGuiPosition("last", "y") + 35, 170, 30, petWindow)
      seexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
      seexports.sGui:setGuiHover(btn, "gradient", {
        "sightgreen",
        "sightgreen-second"
      }, false, true)
      seexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
      seexports.sGui:setButtonTextColor(btn, "#ffffff")
      seexports.sGui:setButtonText(btn, seexports.sItems:getItemName(feedingItems[i]))
      seexports.sGui:setClickEvent(btn, "feedPetAction")
      buttonActions[btn] = feedingItems[i]
    end
    local btn = seexports.sGui:createGuiElement("button", 5, seexports.sGui:getGuiPosition("last", "y") + 35, 170, 30, petWindow)
    seexports.sGui:setGuiBackground(btn, "solid", "sightred")
    seexports.sGui:setGuiHover(btn, "gradient", {
      "sightred",
      "sightred-second"
    }, false, true)
    seexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
    seexports.sGui:setButtonTextColor(btn, "#ffffff")
    seexports.sGui:setButtonText(btn, "Kilépés")
    seexports.sGui:setClickEvent(btn, "animalPanelClose")
  end
end
function animalPanelClose()
  feeding = false
  seexports.sGui:deleteGuiElement(petWindow)
  animalPanelState = false
end
addEvent("animalPanelClose", true)
addEventHandler("animalPanelClose", getRootElement(), animalPanelClose)
function animalPanelFeed()
  animalPanelClose()
  feeding = true
  createAnimalPanel()
  animalPanelState = true
end
addEvent("animalPanelFeed", true)
addEventHandler("animalPanelFeed", getRootElement(), animalPanelFeed)
function feedPetAction(button, state, absX, absY, el)
  if buttonActions[el] then
    triggerServerEvent("feedAnimal", localPlayer, animalElement, buttonActions[el])
    animalPanelClose()
    feeding = false
  end
end
addEvent("feedPetAction", true)
addEventHandler("feedPetAction", getRootElement(), feedPetAction)
function animalPanelAttack()
  local characterId = getElementData(localPlayer, "char.ID")
  if characterId then
    local ownerId = getElementData(animalElement, "animal.ownerId")
    if ownerId and tonumber(characterId) ~= tonumber(ownerId) then
      local localAnimal = getElementByID("animal_" .. tostring(characterId))
      if isElement(localAnimal) then
        clearPedTasks(localAnimal)
        clearPedTasks(animalElement)
        addPedTask(localAnimal, {
          "killPed",
          animalElement,
          5,
          1
        })
        addPedTask(animalElement, {
          "killPed",
          localAnimal,
          5,
          1
        })
        seexports.sGui:showInfobox("s", "Ráuszítottad a peted a kiválasztott állatra.")
      end
    end
  end
  animalPanelClose()
end
addEvent("animalPanelAttack", true)
addEventHandler("animalPanelAttack", getRootElement(), animalPanelAttack)
function animalPanelBark()
  local characterId = getElementData(localPlayer, "char.ID")
  if characterId then
    local ownerId = getElementData(animalElement, "animal.ownerId")
    if ownerId and tonumber(characterId) == tonumber(ownerId) then
      triggerServerEvent("triggerBark", localPlayer, animalElement)
    end
  end
  animalPanelClose()
end
addEvent("animalPanelBark", true)
addEventHandler("animalPanelBark", getRootElement(), animalPanelBark)
function animalPanelToggle()
  local characterId = getElementData(localPlayer, "char.ID")
  if characterId then
    local ownerId = getElementData(animalElement, "animal.ownerId")
    if ownerId and tonumber(characterId) == tonumber(ownerId) then
      local doAction = true
      if not getElementData(animalElement, "animal.obedient") then
        local randomNumber = math.random(0, 101)
        if 10 < randomNumber then
          doAction = false
        end
      end
      if doAction then
        local thisTask = getElementData(animalElement, "ped.thisTask")
        if thisTask then
          local task = getElementData(animalElement, "ped.task." .. thisTask)
          if task and (task[1] == "walkFollowElement" or task[1] == "killPed") then
            clearPedTasks(animalElement)
            seexports.sGui:showInfobox("s", "Megállítottad a peted. Mostantól itt fog várni.")
          end
        else
          setPedTask(animalElement, {
            "walkFollowElement",
            localPlayer,
            3
          })
          seexports.sGui:showInfobox("s", "A peted elkezdett követni téged.")
        end
      end
    end
  end
  animalPanelClose()
end
addEvent("animalPanelToggle", true)
addEventHandler("animalPanelToggle", getRootElement(), animalPanelToggle)
function animalPanelPet()
  local currentLove = getElementData(animalElement, "animal.love")
  if currentLove + 5 > 100 then
    setElementData(animalElement, "animal.love", 100, true)
  else
    setElementData(animalElement, "animal.love", currentLove + 5, true)
  end
  triggerServerEvent("setAnimationForAnimalPet", localPlayer, animalElement, true)
  setTimer(function()
    triggerServerEvent("setAnimationForAnimalPet", localPlayer, animalElement, false)
  end, 7000, 1)
  animalPanelClose()
end
addEvent("animalPanelPet", true)
addEventHandler("animalPanelPet", getRootElement(), animalPanelPet)
addEvent("petSound", true)
addEventHandler("petSound", getRootElement(), function(typ)
  local prefix = ""
  if getElementModel(source) == 278 then
    prefix = "goat/"
  elseif getElementModel(source) == 277 then
    prefix = "pig/"
  end

  local x, y, z = getElementPosition(source)
  if typ == "attack" then
    local soundElement = playSound3D("files/" .. prefix .. "attack.mp3", x, y, z)
    setSoundMaxDistance(soundElement, 20)
    attachElements(soundElement, source)
    setElementDimension(soundElement, getElementDimension(source))
    setElementInterior(soundElement, getElementInterior(source))
  elseif typ == "follow" then
    local soundElement = playSound3D("files/" .. prefix .. "follownew.mp3", x, y, z)
    setSoundMaxDistance(soundElement, 20)
    attachElements(soundElement, source)
    setElementDimension(soundElement, getElementDimension(source))
    setElementInterior(soundElement, getElementInterior(source))
  elseif typ == "simogat" then
    local soundElement = playSound3D("files/" .. prefix .. "simogat.mp3", x, y, z)
    setSoundMaxDistance(soundElement, 20)
    attachElements(soundElement, source)
    setElementDimension(soundElement, getElementDimension(source))
    setElementInterior(soundElement, getElementInterior(source))
  elseif typ == "ugat" then
    local soundElement = playSound3D("files/" .. prefix .. "ugat.mp3", x, y, z)
    setSoundMaxDistance(soundElement, 30)
    attachElements(soundElement, source)
    setElementDimension(soundElement, getElementDimension(source))
    setElementInterior(soundElement, getElementInterior(source))
  end
end)
addEventHandler("onClientElementDataChange", getRootElement(), function(dataName, oldValue)
  if isElement(source) then
    if source == localPlayer then
      if dataName == "loggedIn" then
        if isTimer(animalTimer) then
          killTimer(animalTimer)
        end
        animalTimer = setTimer(function()
          local characterId = getElementData(localPlayer, "char.ID")
          if characterId then
            local animalElement = getElementByID("animal_" .. characterId)
            if isElement(animalElement) then
              local currentHunger = getElementData(animalElement, "animal.hunger") - 1
              local currentLove = getElementData(animalElement, "animal.love")
              if currentLove == 0 then
                setElementData(animalElement, "animal.obedient", false, true)
              else
                setElementData(animalElement, "animal.love", currentLove - 1, true)
              end
              if currentHunger <= 0 then
                setElementData(animalElement, "animal.hunger", 0, true)
                triggerServerEvent("animalStarvedToDeath", localPlayer, animalElement, getElementData(animalElement, "animal.animalId"))
              end
              setElementData(animalElement, "animal.hunger", currentHunger, true)
            end
          end
        end, 360000, 0)
      end
    elseif getElementData(source, "animal.animalId") then
      if dataName == "ped.task.1" then
        local selectedTask = getElementData(source, "ped.task.1")
        if selectedTask then
          if selectedTask[1] == "killPed" then
            local prefix = ""
            if getElementModel(source) == 88 then
              prefix = "goat/"
            elseif getElementModel(source) == 269 then
              prefix = "pig/"
            end
            local pedPosX, pedPosY, pedPosZ = getElementPosition(source)
            local soundElement = playSound3D("files/" .. prefix .. "attack.mp3", pedPosX, pedPosY, pedPosZ)
            if isElement(soundElement) then
              setSoundMaxDistance(soundElement, 20)
              attachElements(soundElement, source)
              setElementDimension(soundElement, getElementDimension(source))
              setElementInterior(soundElement, getElementInterior(source))
            end
          elseif selectedTask[1] == "walkFollowElement" then
            local prefix = ""
            if getElementModel(source) == 88 then
              prefix = "goat/"
            elseif getElementModel(source) == 269 then
              prefix = "pig/"
            end
            local pedPosX, pedPosY, pedPosZ = getElementPosition(source)
            local soundElement = playSound3D("files/" .. prefix .. "follownew.mp3", pedPosX, pedPosY, pedPosZ)
            if isElement(soundElement) then
              setSoundMaxDistance(soundElement, 20)
              attachElements(soundElement, source)
              setElementDimension(soundElement, getElementDimension(source))
              setElementInterior(soundElement, getElementInterior(source))
            end
          end
        end
      elseif dataName == "animal.health" then
      end
    end
  end
end)
UPDATE_COUNT = 16
UPDATE_INTERVAL_MS = 2000
local maxDistance = 120
local zombieTable = {}
addEventHandler("onClientResourceStart", getResourceRootElement(), function()
  addEventHandler("onClientPreRender", root, cycleNPCs)
end, true, "high+999999")
function stopAllNPCActions(npc)
  stopNPCWalkingActions(npc)
  stopNPCWeaponActions(npc)
  setPedControlState(npc, "vehicle_fire", false)
  setPedControlState(npc, "vehicle_secondary_fire", false)
  setPedControlState(npc, "steer_forward", false)
  setPedControlState(npc, "steer_back", false)
  setPedControlState(npc, "horn", false)
  setPedControlState(npc, "handbrake", false)
end
function stopNPCWalkingActions(npc)
  setPedControlState(npc, "forwards", false)
  setPedControlState(npc, "sprint", false)
  setPedControlState(npc, "walk", false)
end
function stopNPCWeaponActions(npc)
  setPedControlState(npc, "aim_weapon", false)
  setPedControlState(npc, "fire", false)
end
function makeNPCWalkToPos(npc, x, y)
  local px, py = getElementPosition(npc)
  setPedCameraRotation(npc, math.deg(math.atan2(x - px, y - py)))
  setPedControlState(npc, "forwards", true)
  local speed = getNPCWalkSpeed(npc)
  setPedControlState(npc, "walk", speed == "walk")
  setPedControlState(npc, "sprint", speed == "sprint" or speed == "sprintfast" and not getPedControlState(npc, "sprint"))
end
function makeNPCWalkAlongLine(npc, x1, y1, z1, x2, y2, z2, off)
  local x, y, z = getElementPosition(npc)
  local p2 = getPercentageInLine(x, y, x1, y1, x2, y2)
  local len = getDistanceBetweenPoints3D(x1, y1, z1, x2, y2, z2)
  p2 = p2 + off / len
  local p1 = 1 - p2
  local destx, desty = p1 * x1 + p2 * x2, p1 * y1 + p2 * y2
  makeNPCWalkToPos(npc, destx, desty)
end
function makeNPCWalkAroundBend(npc, x0, y0, x1, y1, x2, y2, off)
  local x, y, z = getElementPosition(npc)
  local len = getDistanceBetweenPoints2D(x1, y1, x2, y2) * math.pi * 0.5
  local p2 = getAngleInBend(x, y, x0, y0, x1, y1, x2, y2) / math.pi * 2 + off / len
  local destx, desty = getPosFromBend(p2 * math.pi * 0.5, x0, y0, x1, y1, x2, y2)
  makeNPCWalkToPos(npc, destx, desty)
end
function makeNPCShootAtPos(npc, x, y, z)
  local sx, sy, sz = getElementPosition(npc)
  x, y, z = x - sx, y - sy, z - sz
  local yx, yy, yz = 0, 0, 1
  local xx, xy, xz = yy * z - yz * y, yz * x - yx * z, yx * y - yy * x
  yx, yy, yz = y * xz - z * xy, z * xx - x * xz, x * xy - y * xx
  local inacc = 1 - getNPCWeaponAccuracy(npc)
  local ticks = getTickCount()
  local xmult = inacc * math.sin(ticks * 0.01) * 1000 / math.sqrt(xx * xx + xy * xy + xz * xz)
  local ymult = inacc * math.cos(ticks * 0.011) * 1000 / math.sqrt(yx * yx + yy * yy + yz * yz)
  local mult = 1000 / math.sqrt(x * x + y * y + z * z)
  xx, xy, xz = xx * xmult, xy * xmult, xz * xmult
  yx, yy, yz = yx * ymult, yy * ymult, yz * ymult
  x, y, z = x * mult, y * mult, z * mult
  setPedAimTarget(npc, sx + xx + yx + x, sy + xy + yy + y, sz + xz + yz + z)
  if isPedInVehicle(npc) then
    setPedControlState(npc, "vehicle_fire", not getPedControlState(npc, "vehicle_fire"))
  else
    setPedControlState(npc, "aim_weapon", true)
    setPedControlState(npc, "fire", not getPedControlState(npc, "fire"))
  end
end
function makeNPCShootAtElement(npc, target)
  local x, y, z = getElementPosition(target)
  local vx, vy, vz = getElementVelocity(target)
  local tgtype = getElementType(target)
  if tgtype == "ped" or tgtype == "player" then
    x, y, z = getPedBonePosition(target, 3)
    local vehicle = getPedOccupiedVehicle(target)
    if vehicle then
      vx, vy, vz = getElementVelocity(vehicle)
    end
  end
  vx, vy, vz = vx * 6, vy * 6, vz * 6
  makeNPCShootAtPos(npc, x + vx, y + vy, z + vz)
end
function stopAllNPCActions(npc)
  stopNPCWalkingActions(npc)
  stopNPCWeaponActions(npc)
  setPedControlState(npc, "vehicle_fire", false)
  setPedControlState(npc, "vehicle_secondary_fire", false)
  setPedControlState(npc, "steer_forward", false)
  setPedControlState(npc, "steer_back", false)
  setPedControlState(npc, "horn", false)
  setPedControlState(npc, "handbrake", false)
end
function stopNPCWalkingActions(npc)
  setPedControlState(npc, "forwards", false)
  setPedControlState(npc, "sprint", false)
  setPedControlState(npc, "walk", false)
end
function stopNPCWeaponActions(npc)
  setPedControlState(npc, "aim_weapon", false)
  setPedControlState(npc, "fire", false)
end
function makeNPCWalkToPos(npc, x, y)
  local px, py = getElementPosition(npc)
  setPedCameraRotation(npc, math.deg(math.atan2(x - px, y - py)))
  setPedControlState(npc, "forwards", true)
  local speed = getNPCWalkSpeed(npc)
  setPedControlState(npc, "walk", speed == "walk")
  setPedControlState(npc, "sprint", speed == "sprint" or speed == "sprintfast" and not getPedControlState(npc, "sprint"))
end
function makeNPCWalkAlongLine(npc, x1, y1, z1, x2, y2, z2, off)
  local x, y, z = getElementPosition(npc)
  local p2 = getPercentageInLine(x, y, x1, y1, x2, y2)
  local len = getDistanceBetweenPoints3D(x1, y1, z1, x2, y2, z2)
  p2 = p2 + off / len
  local p1 = 1 - p2
  local destx, desty = p1 * x1 + p2 * x2, p1 * y1 + p2 * y2
  makeNPCWalkToPos(npc, destx, desty)
end
function makeNPCWalkAroundBend(npc, x0, y0, x1, y1, x2, y2, off)
  local x, y, z = getElementPosition(npc)
  local len = getDistanceBetweenPoints2D(x1, y1, x2, y2) * math.pi * 0.5
  local p2 = getAngleInBend(x, y, x0, y0, x1, y1, x2, y2) / math.pi * 2 + off / len
  local destx, desty = getPosFromBend(p2 * math.pi * 0.5, x0, y0, x1, y1, x2, y2)
  makeNPCWalkToPos(npc, destx, desty)
end
function makeNPCShootAtPos(npc, x, y, z)
  local sx, sy, sz = getElementPosition(npc)
  x, y, z = x - sx, y - sy, z - sz
  local yx, yy, yz = 0, 0, 1
  local xx, xy, xz = yy * z - yz * y, yz * x - yx * z, yx * y - yy * x
  yx, yy, yz = y * xz - z * xy, z * xx - x * xz, x * xy - y * xx
  local inacc = 0
  local ticks = getTickCount()
  local xmult = inacc * math.sin(ticks * 0.01) * 1000 / math.sqrt(xx * xx + xy * xy + xz * xz)
  local ymult = inacc * math.cos(ticks * 0.011) * 1000 / math.sqrt(yx * yx + yy * yy + yz * yz)
  local mult = 1000 / math.sqrt(x * x + y * y + z * z)
  xx, xy, xz = xx * xmult, xy * xmult, xz * xmult
  yx, yy, yz = yx * ymult, yy * ymult, yz * ymult
  x, y, z = x * mult, y * mult, z * mult
  setPedAimTarget(npc, sx + xx + yx + x, sy + xy + yy + y, sz + xz + yz + z)
  if isPedInVehicle(npc) then
    setPedControlState(npc, "vehicle_fire", not getPedControlState(npc, "vehicle_fire"))
  else
    setPedControlState(npc, "aim_weapon", true)
    setPedControlState(npc, "fire", not getPedControlState(npc, "fire"))
  end
end
function makeNPCShootAtElement(npc, target)
  local x, y, z = getElementPosition(target)
  local vx, vy, vz = getElementVelocity(target)
  local tgtype = getElementType(target)
  if tgtype == "ped" or tgtype == "player" then
    x, y, z = getPedBonePosition(target, 3)
    local vehicle = getPedOccupiedVehicle(target)
    if vehicle then
      vx, vy, vz = getElementVelocity(vehicle)
    end
  end
  vx, vy, vz = vx * 6, vy * 6, vz * 6
  makeNPCShootAtPos(npc, x + vx, y + vy, z + vz)
end
performTask = {}
function performTask.walkToPos(npc, task)
  if isPedInVehicle(npc) then
    return true
  end
  local destx, desty, destz, dest_dist = task[2], task[3], task[4], task[5]
  local x, y = getElementPosition(npc)
  local distx, disty = destx - x, desty - y
  local dist = distx * distx + disty * disty
  local dest_dist = task[5]
  if dist < dest_dist * dest_dist then
    return true
  end
  makeNPCWalkToPos(npc, destx, desty)
end
function performTask.walkAlongLine(npc, task)
  if isPedInVehicle(npc) then
    return true
  end
  local x1, y1, z1, x2, y2, z2 = task[2], task[3], task[4], task[5], task[6], task[7]
  local off, enddist = task[8], task[9]
  local x, y, z = getElementPosition(npc)
  local pos = getPercentageInLine(x, y, x1, y1, x2, y2)
  local len = getDistanceBetweenPoints3D(x1, y1, z1, x2, y2, z2)
  if pos >= 1 - enddist / len then
    return true
  end
  makeNPCWalkAlongLine(npc, x1, y1, z1, x2, y2, z2, off)
end
function performTask.walkAroundBend(npc, task)
  if isPedInVehicle(npc) then
    return true
  end
  local x0, y0 = task[2], task[3]
  local x1, y1, z1 = task[4], task[5], task[6]
  local x2, y2, z2 = task[7], task[8], task[9]
  local off, enddist = task[10], task[11]
  local x, y, z = getElementPosition(npc)
  local len = getDistanceBetweenPoints2D(x1, y1, x2, y2) * math.pi * 0.5
  local angle = getAngleInBend(x, y, x0, y0, x1, y1, x2, y2) + enddist / len
  if angle >= math.pi * 0.5 then
    return true
  end
  makeNPCWalkAroundBend(npc, x0, y0, x1, y1, x2, y2, off)
end
function performTask.walkFollowElement(npc, task)
  if isPedInVehicle(npc) then
    return true
  end
  local followed, mindist = task[2], task[3]
  if not isElement(followed) then
    return true
  end
  local x, y = getElementPosition(npc)
  local fx, fy = getElementPosition(followed)
  local dx, dy = fx - x, fy - y
  if dx * dx + dy * dy > mindist * mindist then
    makeNPCWalkToPos(npc, fx, fy)
  else
    stopAllNPCActions(npc)
  end
end
function performTask.shootPoint(npc, task)
  local x, y, z = task[2], task[3], task[4]
  makeNPCShootAtPos(npc, x, y, z)
end
function performTask.shootElement(npc, task)
  local target = task[2]
  if not isElement(target) then
    return true
  end
  makeNPCShootAtElement(npc, target)
end
function performTask.killPed(npc, task)
  if isPedInVehicle(npc) then
    return true
  end
  local target, shootdist, followdist = task[2], task[3], task[4]
  if isElement(target) and getElementType(target) == "object" then
    return true
  end
  if not isElement(target) or isPedDead(target) then
    return true
  end
  local x, y, z = getElementPosition(npc)
  local tx, ty, tz = getElementPosition(target)
  local dx, dy = tx - x, ty - y
  local distsq = dx * dx + dy * dy
  if distsq < shootdist * shootdist then
    makeNPCShootAtElement(npc, target)
    setPedRotation(npc, -math.deg(math.atan2(dx, dy)))
  else
    stopNPCWeaponActions(npc)
  end
  if distsq > followdist * followdist then
    makeNPCWalkToPos(npc, tx, ty)
  else
    stopNPCWalkingActions(npc)
  end
  return false
end
local attackDistance = 10
function addPedTask(pedElement, selectedTask)
  if isElement(pedElement) then
    local lastTask = getElementData(pedElement, "ped.lastTask")
    if not lastTask then
      lastTask = 1
      setElementData(pedElement, "ped.thisTask", 1)
    else
      lastTask = lastTask + 1
    end
    setElementData(pedElement, "ped.task." .. lastTask, selectedTask)
    setElementData(pedElement, "ped.lastTask", lastTask)
    return true
  else
    return false
  end
end
function clearPedTasks(pedElement)
  if isElement(pedElement) then
    local thisTask = getElementData(pedElement, "ped.thisTask")
    if thisTask then
      local lastTask = getElementData(pedElement, "ped.lastTask")
      for currentTask = thisTask, lastTask do
        setElementData(pedElement, "ped.task." .. currentTask, nil)
      end
      setElementData(pedElement, "ped.thisTask", nil)
      setElementData(pedElement, "ped.lastTask", nil)
      return true
    end
  else
    return false
  end
end
function setPedTask(pedElement, selectedTask)
  if isElement(pedElement) then
    clearPedTasks(pedElement)
    setElementData(pedElement, "ped.task.1", selectedTask)
    setElementData(pedElement, "ped.thisTask", 1)
    setElementData(pedElement, "ped.lastTask", 1)
    return true
  else
    return false
  end
end
function doRefreshing()
  local localX, localY, localZ = getElementPosition(localPlayer)
  for pednum, ped in ipairs(getElementsByType("ped", root, true)) do
    if getElementData(ped, "ped.isControllable") then
      local pedX, pedY, pedZ = getElementPosition(ped)
      if getDistanceBetweenPoints3D(localX, localY, localZ, pedX, pedY, pedZ) <= attackDistance then
        addPedTask(ped, {
          "killPed",
          localPlayer,
          5,
          1
        })
      end
    end
  end
end
local streamedPeds = {}
addEventHandler("onClientPedDataChange", getRootElement(), function(data, old, new)
  if data == "ped.isControllable" then
    streamedPeds[source] = new and true or nil
  end
end)
addEventHandler("onClientPedDestroy", getRootElement(), function()
  streamedPeds[source] = nil
end)
function cycleNPCs()
  for npc, streamedin in pairs(streamedPeds) do
    if isElementStreamedIn(npc) and getElementHealth(getPedOccupiedVehicle(npc) or npc) >= 1 then
      while true do
        local thisTask = getElementData(npc, "ped.thisTask")
        if thisTask then
          local task = getElementData(npc, "ped.task." .. thisTask)
          if task then
            if performTask[task[1]](npc, task) then
              clearPedTasks(npc)
            else
              break
            end
          else
            stopAllNPCActions(npc)
            break
          end
        else
          stopAllNPCActions(npc)
          break
        end
      end
    else
      stopAllNPCActions(npc)
    end
  end
end
function setNPCTaskToNext(npc)
  setElementData(npc, "ped.thisTask", getElementData(npc, "ped.thisTask") + 1, true)
end
addEvent("onGuiWindowForceClosed", true)
addEventHandler("onGuiWindowForceClosed", getRootElement(), function(el)
  if el == petWindow then
    animalPanelState = false
  end
end)
