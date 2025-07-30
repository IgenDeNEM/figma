local createdGates = {}

addEventHandler("onResourceStart", getResourceRootElement(),
	function()
		for k, v in pairs(availableGates) do
			local objectId = v.objectId

			if type(objectId) == "string" then
				objectId = exports.sModloader:getModelId(objectId)
			end

			local objectElement = createObject(objectId, v.closed[1], v.closed[2], v.closed[3], v.closed[4], v.closed[5], v.closed[6])
			
			if isElement(objectElement) then
				setElementInterior(objectElement, v.int)
				setElementDimension(objectElement, v.dim)

				createdGates[k] = {}
				createdGates[k].objectElement = objectElement
				createdGates[k].state = false
				createdGates[k].startTime = 0
			end
		end
	end
)


addEvent("requestGateObjects", true)
addEventHandler("requestGateObjects", getRootElement(),
	function()
		local objects = {}

		for k, v in pairs(createdGates) do
			objects[v.objectElement] = k
		end

		triggerClientEvent(client, "gotGateObjects", client, objects)
	end
)

addEvent("toggleGate", true)
addEventHandler("toggleGate", getRootElement(),
	function(gateID)
		if isElement(client) then
			local gateParameters = availableGates[gateID]

			if gateParameters then
				local selectedGate = createdGates[gateID]

				if selectedGate then
					local adminDutyState = 1

					if adminDutyState > 0 then
						local elapsedTime = getTickCount() - selectedGate.startTime
						local movementTime = gateParameters.time

						if elapsedTime >= movementTime then
							selectedGate.startTime = getTickCount()

							local rotX = angleDiff(gateParameters.closed[4], gateParameters.open[4])
							local rotY = angleDiff(gateParameters.closed[5], gateParameters.open[5])
							local rotZ = angleDiff(gateParameters.closed[6], gateParameters.open[6])

							if selectedGate.state then
								moveObject(selectedGate.objectElement, movementTime, gateParameters.closed[1], gateParameters.closed[2], gateParameters.closed[3], -rotX, -rotY, -rotZ)
							else
								moveObject(selectedGate.objectElement, movementTime, gateParameters.open[1], gateParameters.open[2], gateParameters.open[3], rotX, rotY, rotZ)
							end

							selectedGate.state = not selectedGate.state

							if selectedGate.state then
								exports.sChat:localAction(client, "kinyit egy közelben lévő kaput.")
							else
								exports.sChat:localAction(client, "bezár egy közelben lévő kaput.")
							end
						end
					end
				end
			end
		end
	end
)

function angleDiff(firstAngle, secondAngle)
	local difference = secondAngle - firstAngle

	while difference < -180 do
		difference = difference + 360
	end

	while difference > 180 do
		difference = difference - 360
	end

	return difference
end