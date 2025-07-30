local screenX, screenY = guiGetScreenSize()
local shopX, shopY = 620, 375

local selectedCouponType = false

addEvent("changeCouponType", false)
addEventHandler("changeCouponType", getRootElement(), function(button, state, absoluteX, absoluteY, el)
    if el == ppCheckbox then
        selectedCouponType = 1
    elseif el == moneyCheckBox then
        selectedCouponType = 2
    elseif el == itemCheckBox then
        selectedCouponType = 3
    end

    exports.sGui:setCheckboxChecked(ppCheckbox, selectedCouponType == 1)
    exports.sGui:setCheckboxChecked(moneyCheckBox, selectedCouponType == 2)
    exports.sGui:setCheckboxChecked(itemCheckBox, selectedCouponType == 3)
end)

addEvent("createCoupon", true)
addEventHandler("createCoupon", root, 
    function()
        if selectedCouponType == 3 then
            triggerServerEvent("createCoupon", localPlayer, exports.sGui:getInputValue(couponName), exports.sGui:getInputValue(couponMaxValue), selectedCouponType, exports.sGui:getInputValue(couponValue), exports.sGui:getInputValue(couponItem))
        else
            triggerServerEvent("createCoupon", localPlayer, exports.sGui:getInputValue(couponName), exports.sGui:getInputValue(couponMaxValue), selectedCouponType, exports.sGui:getInputValue(couponValue))
        end
    end
)

addEvent("closeCouponCreator", true)
addEventHandler("closeCouponCreator", root, 
    function()
        exports.sGui:deleteGuiElement(creatorWindow)
        creatorWindow = false
        selectedCouponType = false
    end
)

addEvent("initCouponCreator", true)
addEventHandler("initCouponCreator", root, 
    function()
        if creatorWindow then
            return
        end

        createCouponWindow()
    end
)

function createCouponWindow()
    local titleBarHeight = exports.sGui:getTitleBarHeight()

    creatorWindow = exports.sGui:createGuiElement("window", screenX / 2 - shopX / 2, screenY / 2 - shopY / 2, shopX, shopY)
    exports.sGui:setWindowTitle(creatorWindow, "16/BebasNeueRegular.otf", "SightMTA - Kupon")
    exports.sGui:setWindowCloseButton(creatorWindow, "closeCouponCreator")

    couponName = exports.sGui:createGuiElement("input", 10, 50, shopX - 20, 30, creatorWindow)
    exports.sGui:setInputPlaceholder(couponName, "Kuponkód")
    exports.sGui:setInputFont(couponName, "10/Ubuntu-R.ttf")
    exports.sGui:setInputIcon(couponName, "ticket")

    couponMaxValue = exports.sGui:createGuiElement("input", 10, 85, shopX - 20, 30, creatorWindow)
    exports.sGui:setInputPlaceholder(couponMaxValue, "Felhasználók száma")
    exports.sGui:setInputFont(couponMaxValue, "10/Ubuntu-R.ttf")
    exports.sGui:setInputIcon(couponMaxValue, "user")
    exports.sGui:setInputNumberOnly(couponMaxValue, true)

    ppCheckbox = exports.sGui:createGuiElement("checkbox", 12.5, 125, shopX - 20, 30, creatorWindow)
    exports.sGui:setGuiColorScheme(ppCheckbox, "dark")
    exports.sGui:setCheckboxText(ppCheckbox, "PrémiumPont")
    exports.sGui:setClickEvent(ppCheckbox, "changeCouponType")

    moneyCheckBox = exports.sGui:createGuiElement("checkbox", 12.5, 155, shopX - 20, 30, creatorWindow)
    exports.sGui:setGuiColorScheme(moneyCheckBox, "dark")
    exports.sGui:setCheckboxText(moneyCheckBox, "Készpénz")
    exports.sGui:setClickEvent(moneyCheckBox, "changeCouponType")

    itemCheckBox = exports.sGui:createGuiElement("checkbox", 12.5, 185, shopX - 20, 30, creatorWindow)
    exports.sGui:setGuiColorScheme(itemCheckBox, "dark")
    exports.sGui:setCheckboxText(itemCheckBox, "Tárgy")
    exports.sGui:setClickEvent(itemCheckBox, "changeCouponType")

    exports.sGui:setCheckboxChecked(ppCheckbox, selectedCouponType == 1)
    exports.sGui:setCheckboxChecked(moneyCheckBox, selectedCouponType == 2)
    exports.sGui:setCheckboxChecked(itemCheckBox, selectedCouponType == 3)

    couponValue = exports.sGui:createGuiElement("input", 10, 225, shopX - 20, 30, creatorWindow)
    exports.sGui:setInputPlaceholder(couponValue, "Érték")
    exports.sGui:setInputFont(couponValue, "10/Ubuntu-R.ttf")
    exports.sGui:setInputIcon(couponValue, "gem")
    exports.sGui:setInputNumberOnly(couponValue, true)

    couponItem = exports.sGui:createGuiElement("input", 10, 265, shopX - 20, 30, creatorWindow)
    exports.sGui:setInputPlaceholder(couponItem, "Mennyiség (Tárgy esetén)")
    exports.sGui:setInputFont(couponItem, "10/Ubuntu-R.ttf")
    exports.sGui:setInputIcon(couponItem, "gem")
    exports.sGui:setInputNumberOnly(couponItem, true)

    couponCreate = exports.sGui:createGuiElement("button", 10, 330, shopX - 20, 30, creatorWindow)
    exports.sGui:setGuiBackground(couponCreate, "solid", "sightgreen")
    exports.sGui:setGuiHover(couponCreate, "gradient", {
        "sightgreen",
        "sightgreen-second"
    }, false, true)
    exports.sGui:setButtonText(couponCreate, "Létrehozás")
    exports.sGui:setButtonFont(couponCreate, "15/BebasNeueBold.otf")
    exports.sGui:setClickEvent(couponCreate, "createCoupon")
end

addEvent("activateCoupon", true)
addEventHandler("activateCoupon", root, 
    function()
        local couponCode = exports.sGui:getInputValue(couponInput)

        triggerServerEvent("activateCoupon", localPlayer, couponCode)
    end
)

addEvent("closeCoupon", true)
addEventHandler("closeCoupon", root, 
    function()
        exports.sGui:deleteGuiElement(couponBackground)
        couponBackground = false
    end
)

addCommandHandler("coupon", 
    function()
        titleHeight = exports.sGui:getTitleBarHeight()

        couponBackground = exports.sGui:createGuiElement("window", (screenX - 300) / 2, (screenY - 150) / 2, 300, 150)
        exports.sGui:setWindowTitle(couponBackground, "16/BebasNeueRegular.otf", "SightMTA - Kupon")
        exports.sGui:setWindowCloseButton(couponBackground, "closeCoupon")
        
        couponInput = exports.sGui:createGuiElement("input", 5, 10 + titleHeight, 290, 30, couponBackground)
        exports.sGui:setInputPlaceholder(couponInput, "Kuponkód")
        exports.sGui:setInputFont(couponInput, "10/Ubuntu-R.ttf")
        exports.sGui:setInputIcon(couponInput, "gem")

        local couponActivateButton = exports.sGui:createGuiElement("button", 5, (100 - 32.5) + titleHeight, 300 - 10, 40, couponBackground)
        exports.sGui:setGuiBackground(couponActivateButton, "solid", "sightgrey1")
        exports.sGui:setGuiHover(couponActivateButton, "gradient", {"sightgrey1", "sightgrey3"}, true, true)
        exports.sGui:setClickEvent(couponActivateButton, "activateCoupon")
    
        local couponActivateText = exports.sGui:createGuiElement("label", 0, 0, 300 - 20, 40, couponActivateButton)
        exports.sGui:setLabelAlignment(couponActivateText, "center", "center")
        exports.sGui:setLabelText(couponActivateText, "[color=sightgreen]Kupon aktiválása")
        exports.sGui:setLabelFont(couponActivateText, "11/Ubuntu-R.ttf")
    end
)