tankPreRequest = false
addEventHandler("onClientResourceStart", resourceRoot, function()
  if getPedOccupiedVehicleSeat(localPlayer) == 0 then
    _UPVALUE0_ = getPedOccupiedVehicle(localPlayer)
  end
  for _FORV_3_ = 1, #orderPoses do
    if isElement((createPed(unpack(orderPoses[_FORV_3_])))) then
      setElementData(createPed(unpack(orderPoses[_FORV_3_])), "invulnerable", true)
      setElementData(createPed(unpack(orderPoses[_FORV_3_])), "visibleName", unpack(orderPoses[_FORV_3_]))
      setElementData(createPed(unpack(orderPoses[_FORV_3_])), "pedNameType", "See Mining Co. rendelésátvétel")
      setElementFrozen(createPed(unpack(orderPoses[_FORV_3_])), true)
      _UPVALUE1_[createPed(unpack(orderPoses[_FORV_3_]))] = _FORV_3_
    end
    if isElement((createColSphere(unpack(orderPoses[_FORV_3_]) + unpack(orderPoses[_FORV_3_]) / 2, unpack(orderPoses[_FORV_3_]) + unpack(orderPoses[_FORV_3_]) / 2, unpack(orderPoses[_FORV_3_])))) then
      addEventHandler("onClientLocalColShapeHit", createColSphere(unpack(orderPoses[_FORV_3_]) + unpack(orderPoses[_FORV_3_]) / 2, unpack(orderPoses[_FORV_3_]) + unpack(orderPoses[_FORV_3_]) / 2, unpack(orderPoses[_FORV_3_])), handleOrderStreamZoneEnter)
      addEventHandler("onClientLocalColShapeLeave", createColSphere(unpack(orderPoses[_FORV_3_]) + unpack(orderPoses[_FORV_3_]) / 2, unpack(orderPoses[_FORV_3_]) + unpack(orderPoses[_FORV_3_]) / 2, unpack(orderPoses[_FORV_3_])), handleOrderStreamZoneLeave)
    end
    orderPoses[_FORV_3_] = {
      unpack(orderPoses[_FORV_3_])
    }
  end
  _FOR_()
end)
addEvent("gotMineTankPreRequest", true)
addEventHandler("gotMineTankPreRequest", localPlayer, function(_ARG_0_)
  tankPreRequest = _ARG_0_
  refreshMineMarkers()
end)
function handleMineColShapeEnter(_ARG_0_, _ARG_1_)
  if _ARG_1_ and _ARG_0_ == _UPVALUE0_ then
    if _UPVALUE1_ then
      if mineColShapes[source] == _UPVALUE1_ then
        triggerServerEvent("deliverMineOrder", localPlayer, _UPVALUE1_)
      end
    elseif _UPVALUE2_ then
      if mineColShapes[source] == _UPVALUE2_ then
        createMineTankPrompt()
      end
    elseif tankPreRequest and mineColShapes[source] == tankPreRequest then
      triggerServerEvent("trailerMineTank", localPlayer, tankPreRequest)
    end
  end
end
function handleMineColShapeLeave(_ARG_0_, _ARG_1_)
  if _ARG_0_ == _UPVALUE0_ then
    deleteMineTankPrompt()
  end
end
function handleOrderStreamZoneEnter()
  _UPVALUE0_ = _UPVALUE0_ + 1
  if not _UPVALUE1_ then
    addEventHandler("onClientClick", root, handleOrderPedClick, true, "high+1")
    addEventHandler("onClientPreRender", root, handleStripesRender)
    _UPVALUE1_ = true
  end
end
function handleOrderStreamZoneLeave()
  _UPVALUE0_ = math.max(0, _UPVALUE0_ - 1)
  if _UPVALUE0_ <= 0 and _UPVALUE1_ then
    removeEventHandler("onClientClick", root, handleOrderPedClick)
    removeEventHandler("onClientPreRender", root, handleStripesRender)
    _UPVALUE1_ = false
  end
end
function handleOrderPedClick(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_, _ARG_5_, _ARG_6_, _ARG_7_)
  if _UPVALUE0_[_ARG_7_] and _ARG_1_ == "down" and not _UPVALUE1_ and getDistanceBetweenPoints3D(getElementPosition(localPlayer)) < 2.5 then
    _UPVALUE2_ = _ARG_7_
    triggerLatentServerEvent("requestMineListForOrders", localPlayer)
    createMineOrderWindow()
  end
end
function handleStripesRender()
  for _FORV_4_ = 1, #orderPoses do
    if isElementWithinColShape(localPlayer, unpack(orderPoses[_FORV_4_])) then
      if _UPVALUE0_ then
        if isElementWithinColShape(_UPVALUE0_, unpack(orderPoses[_FORV_4_])) then
        else
        end
      else
        for _FORV_17_ = 1, #getElementsWithinColShape(unpack(orderPoses[_FORV_4_])) do
          if getElementModel(getElementsWithinColShape(unpack(orderPoses[_FORV_4_]))[_FORV_17_]) == 611 then
            break
          end
        end
      end
      dxDrawMaterialLine3D(unpack(orderPoses[_FORV_4_]))
      dxDrawMaterialLine3D(unpack(orderPoses[_FORV_4_]) + unpack(orderPoses[_FORV_4_]), unpack(orderPoses[_FORV_4_]) + 0.1, unpack(orderPoses[_FORV_4_]))
      dxDrawMaterialLine3D(unpack(orderPoses[_FORV_4_]) - 0.1, unpack(orderPoses[_FORV_4_]))
      dxDrawMaterialLine3D(unpack(orderPoses[_FORV_4_]) - 0.1, unpack(orderPoses[_FORV_4_]) + unpack(orderPoses[_FORV_4_]), unpack(orderPoses[_FORV_4_]))
      dxDrawMaterialSectionLine3D(unpack(orderPoses[_FORV_4_]) + unpack(orderPoses[_FORV_4_]) / 2, unpack(orderPoses[_FORV_4_]) + 0.1, unpack(orderPoses[_FORV_4_]))
    end
  end
end
addEvent("gotMineListForOrders", true)
addEventHandler("gotMineListForOrders", localPlayer, function(_ARG_0_)
  if _UPVALUE0_ then
    createMineOrderWindow(_ARG_0_)
  end
end)
addEvent("closeMineOrderWindow", false)
addEventHandler("closeMineOrderWindow", localPlayer, function()
  if _UPVALUE0_ then
    guiDeleteElement(_UPVALUE0_)
  end
  if _UPVALUE1_ then
    guiDeleteElement(_UPVALUE1_)
  end
  _UPVALUE0_ = nil
  _UPVALUE1_ = nil
end)
function createMineOrderWindow(_ARG_0_)
  if _ARG_0_ then
  else
  end
  if _UPVALUE0_ then
    guiDeleteElement(_UPVALUE0_)
  end
  if _UPVALUE1_ then
    guiDeleteElement(_UPVALUE1_)
  end
  _UPVALUE0_ = guiCreateElement("window", (screenWidth - 350) / 2, (screenHeight - (guiGetTitleBarHeight() + math.max(#_ARG_0_, 1) * 48 + 96)) / 2, 350, guiGetTitleBarHeight() + math.max(#_ARG_0_, 1) * 48 + 96)
  _UPVALUE1_ = nil
  if _UPVALUE0_ then
    guiSetWindowTitle(_UPVALUE0_, "16/BebasNeueRegular.otf", "Rendelésátvétel")
    guiSetWindowCloseButton(_UPVALUE0_, "closeMineOrderWindow")
    guiSetWindowElementMaxDistance(_UPVALUE0_, _UPVALUE2_, 2.5, "closeMineOrderWindow")
  end
  if not _ARG_0_ then
    if guiCreateElement("image", (350 - 48) / 2, guiGetTitleBarHeight() + (guiGetTitleBarHeight() + math.max(#_ARG_0_, 1) * 48 + 96 - guiGetTitleBarHeight()) / 2 - 24, 48, 48, _UPVALUE0_) then
      guiSetImageFile(guiCreateElement("image", (350 - 48) / 2, guiGetTitleBarHeight() + (guiGetTitleBarHeight() + math.max(#_ARG_0_, 1) * 48 + 96 - guiGetTitleBarHeight()) / 2 - 24, 48, 48, _UPVALUE0_), guiGetFaIconFilename("circle-notch", 48))
      guiSetImageSpinner(guiCreateElement("image", (350 - 48) / 2, guiGetTitleBarHeight() + (guiGetTitleBarHeight() + math.max(#_ARG_0_, 1) * 48 + 96 - guiGetTitleBarHeight()) / 2 - 24, 48, 48, _UPVALUE0_), true)
    end
  elseif #_ARG_0_ == 0 then
    if guiCreateElement("label", 0, guiGetTitleBarHeight(), 350, guiGetTitleBarHeight() + math.max(#_ARG_0_, 1) * 48 + 96 - guiGetTitleBarHeight(), _UPVALUE0_) then
      guiSetLabelAlignment(guiCreateElement("label", 0, guiGetTitleBarHeight(), 350, guiGetTitleBarHeight() + math.max(#_ARG_0_, 1) * 48 + 96 - guiGetTitleBarHeight(), _UPVALUE0_), "center", "center")
      guiSetLabelColor(guiCreateElement("label", 0, guiGetTitleBarHeight(), 350, guiGetTitleBarHeight() + math.max(#_ARG_0_, 1) * 48 + 96 - guiGetTitleBarHeight(), _UPVALUE0_), "lightgrey")
      guiSetLabelFont(guiCreateElement("label", 0, guiGetTitleBarHeight(), 350, guiGetTitleBarHeight() + math.max(#_ARG_0_, 1) * 48 + 96 - guiGetTitleBarHeight(), _UPVALUE0_), "11/Ubuntu-LI.ttf")
      guiSetLabelText(guiCreateElement("label", 0, guiGetTitleBarHeight(), 350, guiGetTitleBarHeight() + math.max(#_ARG_0_, 1) * 48 + 96 - guiGetTitleBarHeight(), _UPVALUE0_), "Nincs aktív megrendelés.")
    end
  else
    for _FORV_8_ = 1, #_ARG_0_ do
      if not _ARG_0_[_FORV_8_].inTransit then
        if _ARG_0_[_FORV_8_].isPaid then
          guiSetBackground(guiCreateElement("button", 350 - 32 - 8, guiGetTitleBarHeight() + 8, 32, 32, _UPVALUE0_), "solid", "blue")
          guiSetHover(guiCreateElement("button", 350 - 32 - 8, guiGetTitleBarHeight() + 8, 32, 32, _UPVALUE0_), "gradient", {
            "blue",
            "blue-second"
          }, false, true)
          guiSetButtonFont(guiCreateElement("button", 350 - 32 - 8, guiGetTitleBarHeight() + 8, 32, 32, _UPVALUE0_), "14/BebasNeueBold.otf")
          guiSetButtonIcon(guiCreateElement("button", 350 - 32 - 8, guiGetTitleBarHeight() + 8, 32, 32, _UPVALUE0_), guiGetFaIconFilename("box-open", 32))
          guiSetTooltip(guiCreateElement("button", 350 - 32 - 8, guiGetTitleBarHeight() + 8, 32, 32, _UPVALUE0_), "Rendelés felrakodása")
          guiSetClickEvent(guiCreateElement("button", 350 - 32 - 8, guiGetTitleBarHeight() + 8, 32, 32, _UPVALUE0_), "trailerMineOrder")
        else
          guiSetBackground(guiCreateElement("button", 350 - 32 - 8, guiGetTitleBarHeight() + 8, 32, 32, _UPVALUE0_), "solid", _ARG_0_[_FORV_8_].isPremium and "blue" or "green")
          guiSetHover(guiCreateElement("button", 350 - 32 - 8, guiGetTitleBarHeight() + 8, 32, 32, _UPVALUE0_), "gradient", {
            _ARG_0_[_FORV_8_].isPremium and "blue" or "green",
            (_ARG_0_[_FORV_8_].isPremium and "blue" or "green") .. "-second"
          }, false, true)
          guiSetButtonFont(guiCreateElement("button", 350 - 32 - 8, guiGetTitleBarHeight() + 8, 32, 32, _UPVALUE0_), "14/BebasNeueBold.otf")
          guiSetButtonIcon(guiCreateElement("button", 350 - 32 - 8, guiGetTitleBarHeight() + 8, 32, 32, _UPVALUE0_), guiGetFaIconFilename("cash-register", 32))
          guiSetTooltip(guiCreateElement("button", 350 - 32 - 8, guiGetTitleBarHeight() + 8, 32, 32, _UPVALUE0_), "Rendelés kifizetése")
          guiSetClickEvent(guiCreateElement("button", 350 - 32 - 8, guiGetTitleBarHeight() + 8, 32, 32, _UPVALUE0_), "payMineOrder")
        end
        guiSetClickArgument(guiCreateElement("button", 350 - 32 - 8, guiGetTitleBarHeight() + 8, 32, 32, _UPVALUE0_), _ARG_0_[_FORV_8_])
      end
      if guiCreateElement("label", 8, guiGetTitleBarHeight(), 0, 24, _UPVALUE0_) then
        guiSetLabelAlignment(guiCreateElement("label", 8, guiGetTitleBarHeight(), 0, 24, _UPVALUE0_), "left", "center")
        guiSetLabelColor(guiCreateElement("label", 8, guiGetTitleBarHeight(), 0, 24, _UPVALUE0_), "yellow")
        guiSetLabelFont(guiCreateElement("label", 8, guiGetTitleBarHeight(), 0, 24, _UPVALUE0_), "11/Ubuntu-B.ttf")
        guiSetLabelText(guiCreateElement("label", 8, guiGetTitleBarHeight(), 0, 24, _UPVALUE0_), "(" .. _ARG_0_[_FORV_8_].mineId .. ") " .. _ARG_0_[_FORV_8_].mineName)
      end
      if guiCreateElement("label", 8, guiGetTitleBarHeight() + 24, 0, 24, _UPVALUE0_) then
        guiSetLabelAlignment(guiCreateElement("label", 8, guiGetTitleBarHeight() + 24, 0, 24, _UPVALUE0_), "left", "center")
        guiSetLabelFont(guiCreateElement("label", 8, guiGetTitleBarHeight() + 24, 0, 24, _UPVALUE0_), "11/Ubuntu-R.ttf")
        guiSetLabelText(guiCreateElement("label", 8, guiGetTitleBarHeight() + 24, 0, 24, _UPVALUE0_), "[color=" .. (_ARG_0_[_FORV_8_].isPremium and "blue" or "green") .. "]" .. _ARG_0_[_FORV_8_].totalPrice)
        if _ARG_0_[_FORV_8_].isPaid then
          if guiCreateElement("label", guiGetLabelTextWidth((guiCreateElement("label", 8, guiGetTitleBarHeight() + 24, 0, 24, _UPVALUE0_))) + 8, 0, 0, guiGetLabelFontHeight((guiCreateElement("label", 8, guiGetTitleBarHeight() + 24, 0, 24, _UPVALUE0_))), (guiCreateElement("label", 8, guiGetTitleBarHeight() + 24, 0, 24, _UPVALUE0_))) then
            guiSetLabelAlignment(guiCreateElement("label", guiGetLabelTextWidth((guiCreateElement("label", 8, guiGetTitleBarHeight() + 24, 0, 24, _UPVALUE0_))) + 8, 0, 0, guiGetLabelFontHeight((guiCreateElement("label", 8, guiGetTitleBarHeight() + 24, 0, 24, _UPVALUE0_))), (guiCreateElement("label", 8, guiGetTitleBarHeight() + 24, 0, 24, _UPVALUE0_))), "left", "center")
            guiSetLabelFont(guiCreateElement("label", guiGetLabelTextWidth((guiCreateElement("label", 8, guiGetTitleBarHeight() + 24, 0, 24, _UPVALUE0_))) + 8, 0, 0, guiGetLabelFontHeight((guiCreateElement("label", 8, guiGetTitleBarHeight() + 24, 0, 24, _UPVALUE0_))), (guiCreateElement("label", 8, guiGetTitleBarHeight() + 24, 0, 24, _UPVALUE0_))), "11/Ubuntu-R.ttf")
            guiSetLabelText(guiCreateElement("label", guiGetLabelTextWidth((guiCreateElement("label", 8, guiGetTitleBarHeight() + 24, 0, 24, _UPVALUE0_))) + 8, 0, 0, guiGetLabelFontHeight((guiCreateElement("label", 8, guiGetTitleBarHeight() + 24, 0, 24, _UPVALUE0_))), (guiCreateElement("label", 8, guiGetTitleBarHeight() + 24, 0, 24, _UPVALUE0_))), "(fizetve)")
          end
          guiSetLabelColor(guiCreateElement("label", 8, guiGetTitleBarHeight() + 24, 0, 24, _UPVALUE0_), _ARG_0_[_FORV_8_].isPremium and "blue" or "green")
          guiSetLabelStrikeThrough(guiCreateElement("label", 8, guiGetTitleBarHeight() + 24, 0, 24, _UPVALUE0_), true)
        end
      end
      if _FORV_8_ < #_ARG_0_ then
        guiCreateElement("hr", 8, guiGetTitleBarHeight() + 24 + 24 - 1, 350 - 16, 2, _UPVALUE0_)
      end
    end
  end
end
function createMineOrderPrompt(_ARG_0_, _ARG_1_, _ARG_2_)
  if _UPVALUE0_ then
    guiDeleteElement(_UPVALUE0_)
  end
  _UPVALUE0_ = guiCreateElement("window", (screenWidth - 360) / 2, (screenHeight - 170) / 2, 360, 170)
  if _UPVALUE0_ then
    guiSetWindowTitle(_UPVALUE0_, "16/BebasNeueRegular.otf", _ARG_0_)
  end
  if guiCreateElement("label", 0, guiGetTitleBarHeight(), 360, 170 - guiGetTitleBarHeight() - 30 - 12, _UPVALUE0_) then
    guiSetLabelAlignment(guiCreateElement("label", 0, guiGetTitleBarHeight(), 360, 170 - guiGetTitleBarHeight() - 30 - 12, _UPVALUE0_), "center", "center")
    guiSetLabelText(guiCreateElement("label", 0, guiGetTitleBarHeight(), 360, 170 - guiGetTitleBarHeight() - 30 - 12, _UPVALUE0_), _ARG_2_)
    guiSetLabelFont(guiCreateElement("label", 0, guiGetTitleBarHeight(), 360, 170 - guiGetTitleBarHeight() - 30 - 12, _UPVALUE0_), "11/Ubuntu-R.ttf")
  end
  if guiCreateElement("button", 6, 170 - 30 - 6, (360 - 18) / 2, 30, _UPVALUE0_) then
    guiSetBackground(guiCreateElement("button", 6, 170 - 30 - 6, (360 - 18) / 2, 30, _UPVALUE0_), "solid", "green")
    guiSetHover(guiCreateElement("button", 6, 170 - 30 - 6, (360 - 18) / 2, 30, _UPVALUE0_), "gradient", {
      "green",
      "green-second"
    }, false, true)
    guiSetButtonFont(guiCreateElement("button", 6, 170 - 30 - 6, (360 - 18) / 2, 30, _UPVALUE0_), "15/BebasNeueBold.otf")
    guiSetButtonText(guiCreateElement("button", 6, 170 - 30 - 6, (360 - 18) / 2, 30, _UPVALUE0_), "Igen")
    guiSetClickEvent(guiCreateElement("button", 6, 170 - 30 - 6, (360 - 18) / 2, 30, _UPVALUE0_), "confirmMineOrderPrompt")
    guiSetClickArgument(guiCreateElement("button", 6, 170 - 30 - 6, (360 - 18) / 2, 30, _UPVALUE0_), _ARG_1_)
  end
  if guiCreateElement("button", 360 - (360 - 18) / 2 - 6, 170 - 30 - 6, (360 - 18) / 2, 30, _UPVALUE0_) then
    guiSetBackground(guiCreateElement("button", 360 - (360 - 18) / 2 - 6, 170 - 30 - 6, (360 - 18) / 2, 30, _UPVALUE0_), "solid", "red")
    guiSetHover(guiCreateElement("button", 360 - (360 - 18) / 2 - 6, 170 - 30 - 6, (360 - 18) / 2, 30, _UPVALUE0_), "gradient", {"red", "red-second"}, false, true)
    guiSetButtonFont(guiCreateElement("button", 360 - (360 - 18) / 2 - 6, 170 - 30 - 6, (360 - 18) / 2, 30, _UPVALUE0_), "15/BebasNeueBold.otf")
    guiSetButtonText(guiCreateElement("button", 360 - (360 - 18) / 2 - 6, 170 - 30 - 6, (360 - 18) / 2, 30, _UPVALUE0_), "Nem")
    guiSetClickEvent(guiCreateElement("button", 360 - (360 - 18) / 2 - 6, 170 - 30 - 6, (360 - 18) / 2, 30, _UPVALUE0_), "closeMineOrderPrompt")
  end
end
addEvent("payMineOrder", false)
addEventHandler("payMineOrder", localPlayer, function(_ARG_0_, _ARG_1_)
  createMineOrderPrompt("Rendelés kifizetése", _ARG_1_, ("Biztosan szeretnéd kifizetni?\n\nRendelés: [color=yellow](%s) %s[color=white]\nFizetendő: [color=%s] %s"):format(_ARG_1_.mineId, _ARG_1_.mineName, _ARG_1_.isPremium and "blue" or "green", _ARG_1_.totalPrice))
end)
addEvent("trailerMineOrder", false)
addEventHandler("trailerMineOrder", localPlayer, function(_ARG_0_, _ARG_1_)
  for _FORV_9_ = 1, #getElementsWithinColShape(orderPoses[_UPVALUE0_[_UPVALUE1_]][7], "vehicle") do
    if getElementModel(getElementsWithinColShape(orderPoses[_UPVALUE0_[_UPVALUE1_]][7], "vehicle")[_FORV_9_]) == 611 then
      break
    end
  end
  if getElementsWithinColShape(orderPoses[_UPVALUE0_[_UPVALUE1_]][7], "vehicle")[_FORV_9_] then
    createMineOrderPrompt("Rendelés átvétele", {
      mineId = _ARG_1_.mineId,
      isPaid = _ARG_1_.isPaid,
      trailerId = getElementsWithinColShape(orderPoses[_UPVALUE0_[_UPVALUE1_]][7], "vehicle")[_FORV_9_]
    }, ("Biztosan szeretnéd felrakodni?\n\nRendelés: [color=yellow](%s) %s[color=white]\nRendszám: [color=blue]%s"):format(_ARG_1_.mineId, _ARG_1_.mineName, table.concat(split(utf8.upper(getVehiclePlateText(getElementsWithinColShape(orderPoses[_UPVALUE0_[_UPVALUE1_]][7], "vehicle")[_FORV_9_])), "-"), "-")))
  else
    exports.see_gui:showInfobox("e", "Nem áll utánfutó a zónán belül!")
  end
end)
addEvent("closeMineOrderPrompt", false)
addEventHandler("closeMineOrderPrompt", localPlayer, function()
  if _UPVALUE0_ then
    guiDeleteElement(_UPVALUE0_)
  end
  _UPVALUE0_ = nil
end)
addEvent("confirmMineOrderPrompt", false)
addEventHandler("confirmMineOrderPrompt", localPlayer, function(_ARG_0_, _ARG_1_)
  createMineOrderWindow()
  if not _ARG_1_.isPaid then
    triggerLatentServerEvent("payMineOrder", localPlayer, _ARG_1_.mineId)
  else
    triggerLatentServerEvent("trailerMineOrder", localPlayer, _ARG_1_.mineId, _ARG_1_.trailerId)
  end
end)
function createMineTankPrompt()
  if not _UPVALUE0_ then
    _UPVALUE0_ = guiCreateElement("window", (screenWidth - 300) / 2, (screenHeight - 150) / 2, 300, 150)
    if _UPVALUE0_ then
      guiSetWindowTitle(_UPVALUE0_, "16/BebasNeueRegular.otf", "Üzemanyagtartály")
    end
    if guiCreateElement("label", 0, guiGetTitleBarHeight(), 300, 150 - guiGetTitleBarHeight() - 30 - 12, _UPVALUE0_) then
      guiSetLabelAlignment(guiCreateElement("label", 0, guiGetTitleBarHeight(), 300, 150 - guiGetTitleBarHeight() - 30 - 12, _UPVALUE0_), "center", "center")
      guiSetLabelText(guiCreateElement("label", 0, guiGetTitleBarHeight(), 300, 150 - guiGetTitleBarHeight() - 30 - 12, _UPVALUE0_), "Szeretnéd visszavinni a tartályt\na bányába?")
      guiSetLabelFont(guiCreateElement("label", 0, guiGetTitleBarHeight(), 300, 150 - guiGetTitleBarHeight() - 30 - 12, _UPVALUE0_), "11/Ubuntu-R.ttf")
    end
    if guiCreateElement("button", 6, 150 - 30 - 6, (300 - 18) / 2, 30, _UPVALUE0_) then
      guiSetBackground(guiCreateElement("button", 6, 150 - 30 - 6, (300 - 18) / 2, 30, _UPVALUE0_), "solid", "green")
      guiSetHover(guiCreateElement("button", 6, 150 - 30 - 6, (300 - 18) / 2, 30, _UPVALUE0_), "gradient", {
        "green",
        "green-second"
      }, false, true)
      guiSetButtonFont(guiCreateElement("button", 6, 150 - 30 - 6, (300 - 18) / 2, 30, _UPVALUE0_), "15/BebasNeueBold.otf")
      guiSetButtonText(guiCreateElement("button", 6, 150 - 30 - 6, (300 - 18) / 2, 30, _UPVALUE0_), "Igen")
      guiSetClickEvent(guiCreateElement("button", 6, 150 - 30 - 6, (300 - 18) / 2, 30, _UPVALUE0_), "confirmMineTankPrompt")
    end
    if guiCreateElement("button", 300 - (300 - 18) / 2 - 6, 150 - 30 - 6, (300 - 18) / 2, 30, _UPVALUE0_) then
      guiSetBackground(guiCreateElement("button", 300 - (300 - 18) / 2 - 6, 150 - 30 - 6, (300 - 18) / 2, 30, _UPVALUE0_), "solid", "red")
      guiSetHover(guiCreateElement("button", 300 - (300 - 18) / 2 - 6, 150 - 30 - 6, (300 - 18) / 2, 30, _UPVALUE0_), "gradient", {"red", "red-second"}, false, true)
      guiSetButtonFont(guiCreateElement("button", 300 - (300 - 18) / 2 - 6, 150 - 30 - 6, (300 - 18) / 2, 30, _UPVALUE0_), "15/BebasNeueBold.otf")
      guiSetButtonText(guiCreateElement("button", 300 - (300 - 18) / 2 - 6, 150 - 30 - 6, (300 - 18) / 2, 30, _UPVALUE0_), "Nem")
      guiSetClickEvent(guiCreateElement("button", 300 - (300 - 18) / 2 - 6, 150 - 30 - 6, (300 - 18) / 2, 30, _UPVALUE0_), "closeMineTankPrompt")
    end
  end
end
function deleteMineTankPrompt()
  if _UPVALUE0_ then
    guiDeleteElement(_UPVALUE0_)
    _UPVALUE0_ = nil
  end
end
addEvent("closeMineTankPrompt", false)
addEventHandler("closeMineTankPrompt", localPlayer, function()
  deleteMineTankPrompt()
end)
addEvent("confirmMineTankPrompt", false)
addEventHandler("confirmMineTankPrompt", localPlayer, function()
  triggerServerEvent("returnMineFuelTank", localPlayer)
  deleteMineTankPrompt()
end)
addEventHandler("onClientPlayerVehicleEnter", localPlayer, function(_ARG_0_, _ARG_1_)
  if _ARG_1_ == 0 then
    _UPVALUE0_ = _ARG_0_
    refreshSelfVehicleData()
  end
end)
addEventHandler("onClientVehicleTrailerChange", root, function(_ARG_0_, _ARG_1_, _ARG_2_)
  refreshSelfVehicleData()
end)
function refreshSelfVehicleData()
  _UPVALUE0_ = _UPVALUE1_ and exports.see_trailers:getAttachedTrailer(_UPVALUE1_)
  if _UPVALUE0_ then
    if _UPVALUE2_[_UPVALUE0_] then
      if #_UPVALUE2_[_UPVALUE0_] == 1 then
        _UPVALUE3_ = _UPVALUE2_[_UPVALUE0_][1]
      elseif #_UPVALUE2_[_UPVALUE0_] >= 2 then
        _UPVALUE4_ = _UPVALUE2_[_UPVALUE0_][1]
      end
    else
      _UPVALUE3_ = false
      _UPVALUE4_ = false
    end
  else
    _UPVALUE3_ = false
    _UPVALUE4_ = false
  end
  if _UPVALUE1_ then
    if not _UPVALUE5_ then
      addEventHandler("onClientPreRender", root, handleSelfVehicleCheck)
      _UPVALUE5_ = true
    end
  elseif _UPVALUE5_ then
    removeEventHandler("onClientPreRender", root, handleSelfVehicleCheck)
    _UPVALUE5_ = false
  end
  if not _UPVALUE3_ then
    deleteMineTankPrompt()
  end
  refreshMineMarkers()
end
function handleSelfVehicleCheck()
  if getPedOccupiedVehicle(localPlayer) ~= _UPVALUE0_ then
    _UPVALUE0_ = false
    refreshSelfVehicleData()
  end
end
function processTrailerData(_ARG_0_, _ARG_1_)
  if _ARG_1_ then
    if not _UPVALUE0_[_ARG_0_] then
      addEventHandler("onClientVehicleDestroy", _ARG_0_, handleTrailerDestroy)
      addEventHandler("onClientVehicleStreamIn", _ARG_0_, handleTrailerStreamIn)
      addEventHandler("onClientVehicleStreamOut", _ARG_0_, handleTrailerStreamOut)
      addEventHandler("onClientVehicleDimensionChange", _ARG_0_, handleTrailerWorldChange)
    end
    _UPVALUE0_[_ARG_0_] = _ARG_1_
    if isElementStreamedIn(_ARG_0_) and not _UPVALUE1_[_ARG_0_] then
      createTrailerObjects(_ARG_0_)
      _UPVALUE1_[_ARG_0_] = true
    end
  else
    if _UPVALUE1_[_ARG_0_] then
      deleteTrailerObjects(_ARG_0_)
      _UPVALUE1_[_ARG_0_] = nil
    end
    if _UPVALUE0_[_ARG_0_] then
      removeEventHandler("onClientVehicleDestroy", _ARG_0_, handleTrailerDestroy)
      removeEventHandler("onClientVehicleStreamIn", _ARG_0_, handleTrailerStreamIn)
      removeEventHandler("onClientVehicleStreamOut", _ARG_0_, handleTrailerStreamOut)
      removeEventHandler("onClientVehicleDimensionChange", _ARG_0_, handleTrailerWorldChange)
    end
    _UPVALUE0_[_ARG_0_] = nil
  end
  if _UPVALUE2_ == _ARG_0_ then
    refreshSelfVehicleData()
  end
end
function handleTrailerStreamIn()
  if not _UPVALUE0_[source] then
    createTrailerObjects(source)
    _UPVALUE0_[source] = true
  end
end
function handleTrailerStreamOut()
  if _UPVALUE0_[source] then
    deleteTrailerObjects(source)
    _UPVALUE0_[source] = nil
  end
end
function handleTrailerDestroy()
  processTrailerData(source, false)
end
function handleTrailerWorldChange(_ARG_0_, _ARG_1_)
  if _UPVALUE0_[source] then
    for _FORV_5_, _FORV_6_ in pairs(_UPVALUE0_[source]) do
      setElementDimension(_FORV_6_, _ARG_1_)
    end
  end
end
function createTrailerObjects(_ARG_0_)
  if _UPVALUE0_[_ARG_0_] and not _UPVALUE1_[_ARG_0_] then
    _UPVALUE1_[_ARG_0_] = {}
    if #_UPVALUE0_[_ARG_0_] >= 2 then
      for _FORV_5_ = 2, #_UPVALUE0_[_ARG_0_] do
        if trailerOffsets[_UPVALUE0_[_ARG_0_][_FORV_5_]] and trailerOffsets[_UPVALUE0_[_ARG_0_][_FORV_5_]][_FORV_5_ - 1] then
          if isElement((createObject(modelIds[unpack(trailerOffsets[_UPVALUE0_[_ARG_0_][_FORV_5_]][_FORV_5_ - 1])], 0, 0, 0))) then
            setElementCollisionsEnabled(createObject(modelIds[unpack(trailerOffsets[_UPVALUE0_[_ARG_0_][_FORV_5_]][_FORV_5_ - 1])], 0, 0, 0), false)
            setElementDimension(createObject(modelIds[unpack(trailerOffsets[_UPVALUE0_[_ARG_0_][_FORV_5_]][_FORV_5_ - 1])], 0, 0, 0), getElementDimension(_ARG_0_))
            setElementInterior(createObject(modelIds[unpack(trailerOffsets[_UPVALUE0_[_ARG_0_][_FORV_5_]][_FORV_5_ - 1])], 0, 0, 0), getElementInterior(_ARG_0_))
            attachElements(createObject(modelIds[unpack(trailerOffsets[_UPVALUE0_[_ARG_0_][_FORV_5_]][_FORV_5_ - 1])], 0, 0, 0), _ARG_0_, unpack(trailerOffsets[_UPVALUE0_[_ARG_0_][_FORV_5_]][_FORV_5_ - 1]))
          end
          table.insert(_UPVALUE1_[_ARG_0_], (createObject(modelIds[unpack(trailerOffsets[_UPVALUE0_[_ARG_0_][_FORV_5_]][_FORV_5_ - 1])], 0, 0, 0)))
        end
      end
    elseif #_UPVALUE0_[_ARG_0_] == 1 then
      if isElement((createObject(modelIds.v4_mine_tank, 0, 0, 0))) then
        setElementCollisionsEnabled(createObject(modelIds.v4_mine_tank, 0, 0, 0), false)
        setElementDimension(createObject(modelIds.v4_mine_tank, 0, 0, 0), getElementDimension(_ARG_0_))
        setElementInterior(createObject(modelIds.v4_mine_tank, 0, 0, 0), getElementInterior(_ARG_0_))
        attachElements(createObject(modelIds.v4_mine_tank, 0, 0, 0), _ARG_0_, 0, 0.3298, 0.0051, 0, 0, 0)
      end
      table.insert(_UPVALUE1_[_ARG_0_], (createObject(modelIds.v4_mine_tank, 0, 0, 0)))
    end
  end
end
function deleteTrailerObjects(_ARG_0_)
  if _UPVALUE0_[_ARG_0_] then
    for _FORV_4_ in pairs(_UPVALUE0_[_ARG_0_]) do
      if isElement(_UPVALUE0_[_ARG_0_][_FORV_4_]) then
        destroyElement(_UPVALUE0_[_ARG_0_][_FORV_4_])
      end
      _UPVALUE0_[_ARG_0_][_FORV_4_] = nil
    end
    _UPVALUE0_[_ARG_0_] = nil
  end
end
function refreshMineMarkers()
  if true and _UPVALUE0_ then
    if createMineOrderMark(_UPVALUE0_) then
    end
  else
    deleteMineOrderMark()
  end
  if false and _UPVALUE1_ then
    if createMineTankMark(_UPVALUE1_) then
    end
  else
    deleteMineTankMark()
  end
  if false and tankPreRequest and _UPVALUE2_ then
    if createMineTankRequestMark(tankPreRequest) then
    end
  else
    deleteMineTankRequestMark()
  end
  shouldRefreshUrmaMotoDevice = true
end
function isCorridorMarked(_ARG_0_, _ARG_1_)
  if validateMineId(getLobbyMineBaseId(_ARG_0_, _ARG_1_), _UPVALUE0_) then
    return "green"
  end
  if validateMineId(getLobbyMineBaseId(_ARG_0_, _ARG_1_), _UPVALUE1_) then
    return "blue"
  end
  if validateMineId(getLobbyMineBaseId(_ARG_0_, _ARG_1_), tankPreRequest) then
    return "blue"
  end
  if validateMineId(getLobbyMineBaseId(_ARG_0_, _ARG_1_), _UPVALUE2_) then
    return "yellow"
  end
  return false
end
function createMineOrderMark(_ARG_0_)
  if loadedMineLobby == getCorridorIdFromLobbyCorridor(getLobbyFromMineId(_ARG_0_)) then
    _UPVALUE0_ = requestMineMarker(_UPVALUE0_, getLobbyFromMineId(_ARG_0_))
  else
    deleteMineOrderMark("marker")
  end
  if not loadedMineLobby and not currentMine then
    _UPVALUE1_ = requestLobbyBlip(_UPVALUE1_, getLobbyFromMineId(_ARG_0_))
  else
    deleteMineOrderMark("blip")
  end
  return _UPVALUE0_ or _UPVALUE1_
end
function deleteMineOrderMark(_ARG_0_)
  if not _ARG_0_ or _ARG_0_ == "blip" then
    if isElement(_UPVALUE0_) then
      destroyElement(_UPVALUE0_)
    end
    _UPVALUE0_ = nil
  end
  if not _ARG_0_ or _ARG_0_ == "marker" then
    if isElement(_UPVALUE1_) then
      destroyElement(_UPVALUE1_)
    end
    _UPVALUE1_ = nil
  end
end
function createMineTankMark(_ARG_0_)
  if loadedMineLobby == getCorridorIdFromLobbyCorridor(getLobbyFromMineId(_ARG_0_)) then
    _UPVALUE0_ = requestMineMarker(_UPVALUE0_, getLobbyFromMineId(_ARG_0_))
  else
    deleteMineTankMark("marker")
  end
  if not loadedMineLobby and not currentMine then
    _UPVALUE1_ = requestLobbyBlip(_UPVALUE1_, getLobbyFromMineId(_ARG_0_))
  else
    deleteMineTankMark("blip")
  end
  return _UPVALUE0_ or _UPVALUE1_
end
function deleteMineTankMark(_ARG_0_)
  if not _ARG_0_ or _ARG_0_ == "blip" then
    if isElement(_UPVALUE0_) then
      destroyElement(_UPVALUE0_)
    end
    _UPVALUE0_ = nil
  end
  if not _ARG_0_ or _ARG_0_ == "marker" then
    if isElement(_UPVALUE1_) then
      destroyElement(_UPVALUE1_)
    end
    _UPVALUE1_ = nil
  end
end
function createMineTankRequestMark(_ARG_0_)
  if loadedMineLobby == getCorridorIdFromLobbyCorridor(getLobbyFromMineId(_ARG_0_)) then
    _UPVALUE0_ = requestMineMarker(_UPVALUE0_, getLobbyFromMineId(_ARG_0_))
  else
    deleteMineTankRequestMark("marker")
  end
  if not loadedMineLobby and not currentMine then
    _UPVALUE1_ = requestLobbyBlip(_UPVALUE1_, getLobbyFromMineId(_ARG_0_))
  else
    deleteMineTankRequestMark("blip")
  end
  return _UPVALUE0_ or _UPVALUE1_
end
function deleteMineTankRequestMark(_ARG_0_)
  if not _ARG_0_ or _ARG_0_ == "blip" then
    if isElement(_UPVALUE0_) then
      destroyElement(_UPVALUE0_)
    end
    _UPVALUE0_ = nil
  end
  if not _ARG_0_ or _ARG_0_ == "marker" then
    if isElement(_UPVALUE1_) then
      destroyElement(_UPVALUE1_)
    end
    _UPVALUE1_ = nil
  end
end
function requestMineMarker(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  _ARG_0_ = _ARG_0_ or createMarker(unpack(mineCoords[_ARG_1_], 1, 3))
  if isElement(_ARG_0_) then
    setMarkerColor(_ARG_0_, _ARG_3_[1], _ARG_3_[2], _ARG_3_[3], 255)
    setElementPosition(_ARG_0_, unpack(mineCoords[_ARG_1_], 1, 3))
    setElementInterior(_ARG_0_, 0)
    setElementDimension(_ARG_0_, _ARG_2_)
  end
  return _ARG_0_
end
function requestLobbyBlip(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  if not _ARG_0_ then
    _ARG_0_ = createBlip(unpack(lobbyCoords[_ARG_1_], 1, 3))
    if isElement(_ARG_0_) then
      setElementData(_ARG_0_, "blipTooltipText", _ARG_2_)
    end
  end
  if isElement(_ARG_0_) then
    setBlipColor(_ARG_0_, _ARG_3_[1], _ARG_3_[2], _ARG_3_[3], 255)
    setElementPosition(_ARG_0_, unpack(lobbyCoords[_ARG_1_], 1, 3))
  end
  return _ARG_0_
end
