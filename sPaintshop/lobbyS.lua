addEvent("syncWorkshopPermissions", true)
addEventHandler("syncWorkshopPermissions", getRootElement(), function(ws, cid, dat)
  if ws == currentWorkshop and workshopPermissions then
    local was = workshopPermissions[cid]
    workshopPermissions[cid] = dat
    if (not dat or not was and dat) and openedComputerApp == "internet" and computerWindow and openedWebsite == "company" then
      createInternetWindow()
    end
  end
end)

addEvent("refreshPaintShopMixerMaintenanceAll", true)
addEventHandler("refreshPaintShopMixerMaintenanceAll", getRootElement(), function(ws, data)
  if ws == currentWorkshop then
    playerHoldingCasette = false
    mixerMaintenance = data
    local sound = playSound3D("files/prompt.mp3", mixerX + 0.01264, mixerY + 1.83547, mixerZ + 0.162247)
    setElementInterior(sound, targetInt)
    setElementDimension(sound, currentWorkshop)
    if data then
      loadedMixerRecipe = false
      for i = 1, #data do
        if data[i] == localPlayer then
          playerHoldingCasette = i
        end
        processMixerMachineCasette(i)
      end
    end
    if mixerWindow then
      createMixerWindow()
    else
      processMixerRenderTarget()
    end
  end
end)
addEvent("refreshPaintShopMixerMaintenance", true)
addEventHandler("refreshPaintShopMixerMaintenance", getRootElement(), function(ws, i, data)
  if ws == currentWorkshop then
    i = tonumber(i)
    if i then
      if mixerMaintenance[i] == localPlayer then
        playerHoldingCasette = false
      end
      if data and mixerMaintenance[i] then
        local x, y, z
        if i == 1 then
          x, y, z = mixerX + 0.018, mixerY - 2.4809, mixerZ + 0.548
        elseif i <= 3 then
          local j = i - 1
          x, y, z = mixerX + mixerBaseOffsets[j][1], mixerY + mixerBaseOffsets[j][2], mixerZ + mixerBaseOffsets[j][3]
        else
          local j = i - 3
          x, y, z = mixerX + mixerColorOffets[j][1], mixerY + mixerColorOffets[j][2], mixerZ + mixerColorOffets[j][3]
        end
        local sound = playSound3D("files/casette.mp3", x, y, z)
        setElementInterior(sound, targetInt)
        setElementDimension(sound, currentWorkshop)
        if isElement(data) then
          local sound = playSound3D("files/hardout.mp3", mixerX + 0.01264, mixerY + 1.83547, mixerZ + 0.162247)
          setElementInterior(sound, targetInt)
          setElementDimension(sound, currentWorkshop)
        else
          local sound = playSound3D("files/hardin.mp3", mixerX + 0.01264, mixerY + 1.83547, mixerZ + 0.162247)
          setElementInterior(sound, targetInt)
          setElementDimension(sound, currentWorkshop)
        end
      end
      mixerMaintenance[i] = data
      if data == localPlayer then
        playerHoldingCasette = i
      end
      processMixerMachineCasette(i)
    end
    if mixerWindow then
      createMixerWindow()
    else
      processMixerRenderTarget()
    end
  end
end)

addEvent("refreshPaintshopOrder", true)
addEventHandler("refreshPaintshopOrder", getRootElement(), function(ws, data)
  if ws == currentWorkshop then
    workshopOrder = data
    if openedComputerApp == "internet" and computerWindow and openedWebsite == "paint" then
      createInternetWindow()
    end
  end
end)

addEvent("refreshPaintshopStockData", true)
addEventHandler("refreshPaintshopStockData", getRootElement(), function(ws, i, data)
  if ws == currentWorkshop then
    if paintStockData[i][2] == true and tonumber(data[2]) then
      local sound = playSound3D("files/cut" .. math.random(1, 4) .. ".mp3", wsX + paintBoxOffsets[i][1], wsY + paintBoxOffsets[i][2], wsZ + paintBoxOffsets[i][3] + 0.25)
      setElementInterior(sound, targetInt)
      setElementDimension(sound, currentWorkshop)
    elseif (tonumber(paintStockData[i][2]) or 0) > (tonumber(data[2]) or 0) then
      local sound = playSound3D("files/boxout.mp3", wsX + paintBoxOffsets[i][1], wsY + paintBoxOffsets[i][2], wsZ + paintBoxOffsets[i][3] + 0.25)
      setElementInterior(sound, targetInt)
      setElementDimension(sound, currentWorkshop)
    end
    paintStockData[i] = data
    processPaintStockBoxes(i)
  end
end)

addEvent("exitedPaintWorkshop", true)
addEventHandler("exitedPaintWorkshop", getRootElement(), function(lobby)
  resetVariables()
  sightexports.sWeather:resetWeather()
  if lobby then
    startPaintshopLobbyLoading(lobby, true)
  end
end)

addEvent("enteredPaintWorkshop", true)
addEventHandler("enteredPaintWorkshop", getRootElement(), function(id)
  loadedPaintshop(id)
end)
addEvent("setPaintshopWorkSkin", true)
addEventHandler("setPaintshopWorkSkin", getRootElement(), function(ws, id)
  if isElement(source) then
    if currentWorkshop == ws then
      if source == localPlayer then
        myWorkSkin = not tonumber(id)
        paintshopHover = false
      end
      if tonumber(id) then
        sightexports.sGroups:setDutySkinForceOff(source, false)
        setElementModel(source, id)
        sightexports.sGroups:processPlayerGroupSkin(source)
      else
        sightexports.sGroups:setDutySkinForceOff(source, true)
        setElementModel(source, models.paintshop_skin)
      end
      local x, y, z = getElementPosition(source)
      local sound = false
      if tonumber(id) then
        sound = playSound3D(":sGroups/files/dutyout.wav", x, y, z)
      else
        sound = playSound3D(":sGroups/files/dutyin.wav", x, y, z)
      end
      setElementInterior(sound, getElementInterior(source))
      setElementDimension(sound, getElementDimension(source))
      attachElements(sound, source)
    elseif tonumber(id) then
      sightexports.sGroups:setDutySkinForceOff(source, false)
      setElementModel(source, id)
      sightexports.sGroups:processPlayerGroupSkin(source)
    end
  end
end)

addEvent("paintshopNewPlayerEntered", true)
addEventHandler("paintshopNewPlayerEntered", getRootElement(), function(ws)
  if currentWorkshop == ws then
    lastParticleSync = 0
    lastParticleEffect = 0
    paintingAnim[localPlayer] = false
  end
end)
triggerClientEvent("gotPaintshopSyncedData", me, getElementDimension(me), 1, {})
addEvent("gotPaintshopResetSyncedData", true)
addEventHandler("gotPaintshopResetSyncedData", getRootElement(), function(ws, id, data)
  if ws == currentWorkshop and carMaskBgs[id] then
    syncedData[id] = data
    redrawFullMask(id)
  end
end)
addEvent("gotPaintshopSyncedData", true)
addEventHandler("gotPaintshopSyncedData", getRootElement(), function(ws, id, data)
  if ws == currentWorkshop and carMaskBgs[id] then
    dxSetBlendMode("modulate_add")
    dxSetRenderTarget(carMaskBgs[id])
    local brush = getBrush(id)
    local brushSize = getBrushSize(id)
    for s, val in pairs(data) do
      local x, y = syncToCoord(s)
      if syncedData[id][s] then
        dxDrawImage(x - brushSize / 2, y - brushSize / 2, brushSize, brushSize, brush, 0, 0, 0, tocolor(0, 0, 0, alphaTarget(syncedData[id][s], val)))
      else
        dxDrawImage(x - brushSize / 2, y - brushSize / 2, brushSize, brushSize, brush, 0, 0, 0, tocolor(0, 0, 0, val))
      end
      syncedData[id][s] = val
    end
    drawMask(id)
  end
end)