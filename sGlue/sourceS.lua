local weaponModels = {
	[563] = true,
	[497] = true,
	[528] = true,
}

addEvent("gluePlayer", true)
addEventHandler("gluePlayer", getRootElement(),
	function (slot, vehicle, x, y, z, rotX, rotY, rotZ)
		if client then
			if isElement(vehicle) then
				if not weaponModels[getElementModel(vehicle)] then
					exports.sControls:toggleControl(source, {"aim_weapon", "action"}, false)
				end
				attachElements(source, vehicle, x, y, z, rotX, rotY, rotZ)
				setPedWeaponSlot(source, slot)
				setElementData(source, "playerGlueRotation", rz)
				setElementData(source, "playerGlueState", vehicle)
			end
		end
	end
)

addEvent("unGluePlayer", true)
addEventHandler("unGluePlayer", getRootElement(),
	function ()
		if client then
			detachElements(source)
			removeElementData(source, "playerGlueState")
			removeElementData(source, "playerGlueRotation")
			exports.sControls:toggleControl(source, {"aim_weapon", "action"}, true)
		end
	end
)