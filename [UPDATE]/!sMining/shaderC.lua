local maxSpotLights = maxWorkersInside
local maxPointLights = 20 -- HQ 13 + 7 extra
local maxRedLights = 2 -- Válogatógép + Mozdony
local maxOrangeLights = 3 -- Kohó + Dinamit + Robbantás

local streamedHardHats = {}
local hardHatProcessingEnabled = false

local numStreamedSpotLights = 0
local numStreamedPointLights = 0
local numStreamedOrangeLights = 0
local numStreamedRedLights = 0

local shouldRefreshSpotLights = false
local shouldRefreshPointLights = false
local shouldRefreshRedLights = false
local shouldRefreshOrangeLights = false

local objectShader
local objectShaderWorldTextures = {
	"auto_tune2",
	"bucket",
	"chipboard_256",
	"cj_cablewrap",
	"cj_darkwood",
	"cj_panel",
	"cj_ped_feet",
	"cj_sheet2",
	"cj_slatedwood",
	"impact_wrench",
	"metal1_128_railway",
	"metal1_128_railway2",
	"paint_bucket",
	"paint_bucket2",
	"sanpedock8",
	"slated",
	"unnamed",
	"v4_coffee_machine",
	"v4_constructionvest",
	"v4_mine_box",
	"v4_mine_computer",
	"v4_mine_computer2",
	"v4_mine_computer3",
	"v4_mine_dirt",
	"v4_mine_dirt2",
	"v4_mine_dirtystone1",
	"v4_mine_electricmotor",
	"v4_mine_fourma",
	"v4_mine_furnace",
	"v4_mine_ibc",
	"v4_mine_lampbox",
	"v4_mine_lampbox2",
	"v4_mine_machine",
	"v4_mine_machine2",
	"v4_mine_machine_rollers",
	"v4_mine_silo",
	"v4_mine_wood",
	"v4_mine_wood_railway",
	"v4_minecart1",
	"v4_minecart2",
	"v4_mining_fusebox",
	"mp_cop_light",
	"cj_chromepipe",
	"wall",
	"ws_griddyfence",
	"wmycon",
	"cj_fire",
	"canister_d",
	"bm_amb_pickaxe"
}

local shaderElements = {}

local conveyorShader
local conveyorScroll = 0
local conveyorScrollRate = conveyorDuration / conveyorLength * 1.35

local meltShader

local faceDirtShader
local faceDirtShaderSource
local faceDirtTexture
local insideDirtyShader
local playerDirtyFaces = {}

local dirtTexture
local noiseTexture
local spotlightTexture
local headlightTexture

local streamPointLights = {}
local lightBulbSwitching = {}

local streamedPointLights = {}
local streamedSpotLights = {}
local streamedRedLights = {}
local streamedOrangeLights = {}

local additionalOrangeLights = {}

local surgeProgress = 1
local surgeStrength = 1

currentActiveShaftShader = false
currentActiveDepthRT = false
currentActiveNormalRT = false

local selfDirtHandled = false

addEventHandler("onClientResourceStart", resourceRoot,
	function ()
		local streamedPlayers = getElementsByType("player", root, true)
		
		for i = 1, #streamedPlayers do
			local playerElement = streamedPlayers[i]

			if hasElementData(playerElement, "mineDirtyFace") then
				playerDirtyFaces[playerElement] = true

				if playerElement == localPlayer then
					if not selfDirtHandled then
						addEventHandler("onClientPreRender", root, preRenderSelfDirt)
						selfDirtHandled = true
					end
				end
			end
		end

		processDirtyShader()
	end
)

addEventHandler("onClientPlayerDataChange", root,
	function (dataName, oldData, newData)
		if dataName == "mineDirtyFace" then
			if isElementStreamedIn(source) then
				if newData then
					streamInDirtyFace(source)
				else
					streamOutDirtyFace(source)
				end
			end
		end
	end
)

addEventHandler("onClientPlayerStreamIn", root,
	function ()
		if not playerDirtyFaces[source] then
			if hasElementData(source, "mineDirtyFace") then
				streamInDirtyFace(source)
			end
		end
	end
)

addEventHandler("onClientPlayerStreamOut", root,
	function ()
		if playerDirtyFaces[source] then
			streamOutDirtyFace(source)
		end
	end
)

function isStreamedLight(spotX, spotY)
	return streamPointLights[spotX] and streamPointLights[spotX][spotY]
end

function setStreamedLights(spotX, spotY, preventSound)
	if not streamPointLights[spotX] then
		streamPointLights[spotX] = {}
	end

	if not streamPointLights[spotX][spotY] then
		local lampPosX = minePosX + spotX * 6
		local lampPosY = minePosY + spotY * 6
		local lampPosZ = minePosZ + (spotX < -1 and 2 or 0)

		streamPointLights[spotX][spotY] = createObject(modelIds.v4_mine_lamp, lampPosX, lampPosY, lampPosZ)

		if isElement(streamPointLights[spotX][spotY]) then
			setElementInterior(streamPointLights[spotX][spotY], 0)
			setElementDimension(streamPointLights[spotX][spotY], currentMine)
		end

		if not preventSound then
			local soundElement = playSound3D("files/sounds/lamp.wav", lampPosX, lampPosY, lampPosZ)
			
			if isElement(soundElement) then
				setElementInterior(soundElement, 0)
				setElementDimension(soundElement, currentMine)
				setSoundMaxDistance(soundElement, 20)
			end

			if not lightBulbSwitching[spotX] then
				lightBulbSwitching[spotX] = {}
			end

			lightBulbSwitching[spotX][spotY] = getTickCount()
		end
	end
end

function refreshActiveShaftShader()
	if isElement(currentActiveShaftShader) then
		if isElement(currentActiveDepthRT) then
			dxSetShaderValue(currentActiveShaftShader, "DepthTexture", currentActiveDepthRT)
		end

		if isElement(currentActiveNormalRT) then
			dxSetShaderValue(currentActiveShaftShader, "NormalTexture", currentActiveNormalRT)
		end
	end
end

function refreshActiveShaftShaderBase(baseX, baseY, baseCos, baseSin)
	if isElement(currentActiveShaftShader) then
		dxSetShaderValue(currentActiveShaftShader, "BasePos", baseX, baseY, minePosZ)
		dxSetShaderValue(currentActiveShaftShader, "BaseCos", baseCos)
		dxSetShaderValue(currentActiveShaftShader, "BaseSin", baseSin)
	end
end

function refreshOreShader(oreElement, oreType)
	local oreInfo = oreTypes[oreType]

	if oreInfo then
		if isElement(objectShader) then
			engineRemoveShaderFromWorldTexture(objectShader, "*", oreElement)
		end

		if isElement(oreInfo.oreShader) then
			engineApplyShaderToWorldTexture(oreInfo.oreShader, "*", oreElement)
		end
	elseif isElement(objectShader) then
		engineApplyShaderToWorldTexture(objectShader, "*", oreElement)
	end
end

function setMeltingMetal(metalType)
	if isElement(meltShader) then
		dxSetShaderValue(meltShader, "MetalColor", oreTypes[metalType]["meltingColor"])
	end
end

function loadShaders()
	loaderText = "Shaderek inicializálása"

	if not dirtTexture then
		dirtTexture = dxCreateTexture("files/textures/shaftwall.dds")
	end

	if not noiseTexture then
		noiseTexture = dxCreateTexture("files/textures/noise.dds", "argb", false, "clamp")
	end

	if not spotlightTexture then
		spotlightTexture = dxCreateTexture("files/textures/spotlight.dds", "argb", false, "clamp")
	end

	if not headlightTexture then
		headlightTexture = dxCreateTexture("files/textures/headlight.dds", "argb", false, "clamp")
	end

	local compiledObjectShader = preprocessShader("files/shaders/object.fx")
	local compiledWallShader = preprocessShader("files/shaders/wall.fx")
	local compiledOreShader = preprocessShader("files/shaders/ore.fx")
	local compiledMeltShader = preprocessShader("files/shaders/melt.fx")
	local compiledDirtyShader = preprocessShader("files/shaders/ped.fx")

	if compiledMeltShader then
		meltShader = dxCreateShader(compiledMeltShader, 0, 40, false, "all")

		if isElement(meltShader) then
			engineApplyShaderToWorldTexture(meltShader, "v4_mine_ingot")
		end

		table.insert(shaderElements, meltShader)
	end

	if compiledWallShader then
		currentActiveShaftShader = dxCreateShader(compiledWallShader, 0, 40, false, "all")

		if isElement(currentActiveShaftShader) then
			dxSetShaderValue(currentActiveShaftShader, "DirtTexture", dirtTexture)
		end

		table.insert(shaderElements, currentActiveShaftShader)
	end

	if compiledObjectShader then
		objectShader = dxCreateShader(compiledObjectShader, 0, 40, false, "all")
		conveyorShader = dxCreateShader(compiledObjectShader, {CONVEYOR_BELT = true}, 0, 40, false, "all")

		for i = 1, #objectShaderWorldTextures do
			engineApplyShaderToWorldTexture(objectShader, objectShaderWorldTextures[i])
		end

		engineApplyShaderToWorldTexture(conveyorShader, "*_scroll")

		table.insert(shaderElements, objectShader)
		table.insert(shaderElements, conveyorShader)
	end

	if compiledDirtyShader then
		insideDirtyShader = dxCreateShader(compiledDirtyShader, {INSIDE_MINE = true}, 0, 40, false, "ped")

		if isElement(insideDirtyShader) then
			processDirtyShader()
		end

		table.insert(shaderElements, insideDirtyShader)
	end

	for k,v in pairs(oreTypes) do
		v.oreTexture = dxCreateTexture("files/textures/ores/" .. k .. ".dds")

		checkMineLoadingTime()
		
		if v.metallicOre then
			v.glitterTexture = dxCreateTexture("files/textures/ores/" .. k .. "_metallic.dds")
		end

		checkMineLoadingTime()

		if v.metallicOre then
			v.oreShader = dxCreateShader(compiledOreShader, {METALLIC_ORE = true}, 0, 40, false, "object")
		else
			v.oreShader = dxCreateShader(compiledOreShader, 0, 40, false, "object")
		end

		checkMineLoadingTime()

		if isElement(v.oreShader) then
			dxSetShaderValue(v.oreShader, "OreTexture", v.oreTexture)

			if v.metallicOre then
				dxSetShaderValue(v.oreShader, "NoiseTexture", noiseTexture)
				dxSetShaderValue(v.oreShader, "GlitterTexture", v.glitterTexture)
			end

			table.insert(shaderElements, v.oreShader)
		end

		checkMineLoadingTime()
	end

	for i = 1, #shaderElements do
		dxSetShaderValue(shaderElements[i], "PointSurge", surgeProgress * surgeStrength)
	end

	addEventHandler("onClientPedsProcessed", root, processShaders, true, "low-100")

	compiledMeltShader = nil
	compiledOreShader = nil
	compiledWallShader = nil
	compiledObjectShader = nil
	compiledDirtyShader = nil

	collectgarbage()
end

function unloadShaders()
	removeEventHandler("onClientPedsProcessed", root, processShaders)

	for spotX in pairs(streamPointLights) do
		for spotY in pairs(streamPointLights[spotX]) do
			checkMineUnloadingTime()

			if isElement(streamPointLights[spotX][spotY]) then
				destroyElement(streamPointLights[spotX][spotY])
			end

			streamPointLights[spotX][spotY] = nil
		end
	end

	streamPointLights = {}
	lightBulbSwitching = {}
	
	streamedPointLights = {}
	streamedSpotLights = {}
	streamedRedLights = {}
	streamedOrangeLights = {}

	additionalOrangeLights = {}

	numStreamedSpotLights = 0
	numStreamedPointLights = 0
	numStreamedOrangeLights = 0
	numStreamedRedLights = 0

	shouldRefreshSpotLights = false
	shouldRefreshPointLights = false
	shouldRefreshRedLights = false
	shouldRefreshOrangeLights = false
	
	for i = 1, #shaderElements do
		if isElement(shaderElements[i]) then
			destroyElement(shaderElements[i])
		end
	end

	shaderElements = {}

	meltShader = nil
	objectShader = nil
	conveyorShader = nil
	insideDirtyShader = nil
	currentActiveShaftShader = nil

	checkMineUnloadingTime()

	for k,v in pairs(oreTypes) do
		if isElement(v.oreShader) then
			destroyElement(v.oreShader)
		end
		v.oreShader = nil

		if isElement(v.oreTexture) then
			destroyElement(v.oreTexture)
		end
		v.oreTexture = nil

		if isElement(v.glitterTexture) then
			destroyElement(v.glitterTexture)
		end
		v.glitterTexture = nil
	end

	checkMineUnloadingTime()

	if isElement(dirtTexture) then
		destroyElement(dirtTexture)
	end

	if isElement(noiseTexture) then
		destroyElement(noiseTexture)
	end

	if isElement(spotlightTexture) then
		destroyElement(spotlightTexture)
	end

	if isElement(headlightTexture) then
		destroyElement(headlightTexture)
	end

	dirtTexture = nil
	noiseTexture = nil
	spotlightTexture = nil
	headlightTexture = nil
end

function streamOutDirtyFace(clientId)
	playerDirtyFaces[clientId] = nil
	removeDirtyShader(clientId)
end

function streamInDirtyFace(clientId)
	playerDirtyFaces[clientId] = true

	if not faceDirtTexture then
		processDirtyShader()
	elseif isElement(insideDirtyShader) then
		engineApplyShaderToWorldTexture(insideDirtyShader, "*", clientId)

		if isElement(objectShader) then
			engineRemoveShaderFromWorldTexture(objectShader, "*", clientId)
		end
	elseif isElement(faceDirtShader) then
		engineApplyShaderToWorldTexture(faceDirtShader, "*", clientId)
	else
		processDirtyShader()
	end

	if clientId == localPlayer then
		if not selfDirtHandled then
			addEventHandler("onClientPreRender", root, preRenderSelfDirt)
			selfDirtHandled = true
		end
	end
end

function processDirtyShader()
	if not next(playerDirtyFaces) then
		if isElement(faceDirtShader) then
			destroyElement(faceDirtShader)
		end
		
		if isElement(faceDirtTexture) then
			destroyElement(faceDirtTexture)
		end

		faceDirtShader = nil
		faceDirtTexture = nil

		return
	end

	if isElement(insideDirtyShader) then
		if isElement(faceDirtShader) then
			destroyElement(faceDirtShader)
		end

		faceDirtShader = nil
	elseif not faceDirtShader then
		if not faceDirtShaderSource then
			faceDirtShaderSource = preprocessShader("files/shaders/ped.fx")
		end

		faceDirtShader = dxCreateShader(faceDirtShaderSource, 0, 0, true, "ped")
	end

	if not faceDirtTexture then
		faceDirtTexture = dxCreateTexture("files/textures/dirtmap.dds")
	end

	if isElement(faceDirtTexture) then
		if isElement(faceDirtShader) then
			dxSetShaderValue(faceDirtShader, "DirtMapTexture", faceDirtTexture)
		end

		if isElement(insideDirtyShader) then
			dxSetShaderValue(insideDirtyShader, "DirtMapTexture", faceDirtTexture)
		end
	end

	for playerElement in pairs(playerDirtyFaces) do
		if isElement(insideDirtyShader) then
			engineApplyShaderToWorldTexture(insideDirtyShader, "*", playerElement)
			
			if isElement(objectShader) then
				engineRemoveShaderFromWorldTexture(objectShader, "*", playerElement)
			end

			if isElement(faceDirtShader) then
				engineRemoveShaderFromWorldTexture(faceDirtShader, "*", playerElement)
			end
		elseif isElement(faceDirtShader) then
			engineApplyShaderToWorldTexture(faceDirtShader, "*", playerElement)
		end
	end
end

function removeDirtyShader(playerElement)
	if isElement(faceDirtShader) then
		engineRemoveShaderFromWorldTexture(faceDirtShader, "*", playerElement)
	end

	if isElement(insideDirtyShader) then
		engineRemoveShaderFromWorldTexture(insideDirtyShader, "*", playerElement)

		if isElement(objectShader) then
			engineApplyShaderToWorldTexture(objectShader, "*", playerElement)
		end
	end

	if not next(playerDirtyFaces) then
		if isElement(faceDirtShader) then
			destroyElement(faceDirtShader)
		end

		if isElement(faceDirtTexture) then
			destroyElement(faceDirtTexture)
		end

		faceDirtShader = nil
		faceDirtTexture = nil
	end
end

function preRenderSelfDirt()
	if getPedSimplestTask(localPlayer) == "TASK_SIMPLE_SWIM" then
		playerDirtyFaces[localPlayer] = nil
		triggerServerEvent("removeMineDirtyFace", localPlayer)
		removeDirtyShader(localPlayer)
	end

	if not playerDirtyFaces[localPlayer] then
		if selfDirtHandled then
			removeEventHandler("onClientPreRender", root, preRenderSelfDirt)
			selfDirtHandled = false
		end
	end
end

function removeShaderFromObject(objectElement)
	if isElement(objectShader) then
		engineRemoveShaderFromWorldTexture(objectShader, "*", objectElement)
	end
end

processedHardHatLights = 0

function processShaders()
	if loaderA < 1 then
		local particleX, particleY, particleZ = computeParticleVector()

		-- Do surge effect
		if nextSurge then
			surgeProgress = (mineTick - nextSurge) / 150

			if surgeProgress > 1 then
				nextSurge = false
				surgeProgress = 1
			end

			surgeProgress = 1 - math.cos(surgeProgress * math.pi / 2) * 0.75
			
			for shaderIndex = 1, #shaderElements do
				dxSetShaderValue(shaderElements[shaderIndex], "PointSurge", surgeProgress * surgeStrength)
			end
		end
		
		local currentSurge = 1

		if mineMachineData.machineRunning or mineMachineData.forceMachine then
			currentSurge = currentSurge - 0.2
		end

		if mineFoundryData.furnaceRunning then
			currentSurge = currentSurge - 0.3
		end

		if surgeStrength ~= currentSurge then
			surgeStrength = currentSurge

			for shaderIndex = 1, #shaderElements do
				dxSetShaderValue(shaderElements[shaderIndex], "PointSurge", surgeProgress * surgeStrength)
			end
		end

		-- Do conveyor belt animation
		conveyorScroll = conveyorScroll + mineDelta / conveyorScrollRate * math.min(1, mineMachineData.machineRunProgress)
		
		if conveyorScroll > 1 then
			conveyorScroll = 0
		end

		if isElement(conveyorShader) then
			dxSetShaderValue(conveyorShader, "ConveyorBeltScroll", conveyorScroll)
		end

		if isElement(mineMachineData.mineMachine3) then
			setElementRotation(mineMachineData.mineMachine3, conveyorScroll * 360, 0, 0)
		end

		-- Handle point lights
		local pointLightIndex = 1

		iterateGrid(streamPointLights, selfMineX - 8, selfMineY - 8, selfMineX + 8, selfMineY + 8,
			function (lampObject, cellX, cellY)
				local lightState = true
				
				if lightBulbSwitching[cellX] then
					local startTime =  lightBulbSwitching[cellX][cellY]

					if startTime then
						if mineTick - startTime > 600 then
							lightBulbSwitching[cellX][cellY] = nil
						end

						if math.random() < 0.9 then
							lightState = mineTick % 250 > 150
						else
							lightState = false
						end
					end
				end

				if lightState then
					local streamData = streamedPointLights[pointLightIndex] or {}

					local lightPosX = minePosX + cellX * 6
					local lightPosY = minePosY + cellY * 6

					if lightPosX ~= streamData[1] or lightPosY ~= streamData[2] then
						streamedPointLights[pointLightIndex] = streamData

						streamData[1] = lightPosX
						streamData[2] = lightPosY
						streamData[3] = streamData[3] and true or false
						streamData[4] = cellX < -1
						streamData[5] = lampObject

						shouldRefreshPointLights = true
					end

					pointLightIndex = pointLightIndex + 1
				end
			end
		)

		local numPointLights = numStreamedPointLights

		local bulbOffsetX = particleX * 0.6
		local bulbOffsetY = particleY * 0.6
		local bulbOffsetZ = particleZ * 0.6

		for i = #streamedPointLights, 1, -1 do
			local streamData = streamedPointLights[i]

			if pointLightIndex <= i then
				if streamData[3] then
					numPointLights = numPointLights - 1
					shouldRefreshPointLights = true
				end

				table.remove(streamedPointLights, i)
			else
				local playerToLightDistance = getDistanceBetweenPoints2D(selfPosX, selfPosY, streamData[1], streamData[2])

				if playerToLightDistance <= 48 then
					local distanceAttenuation = math.min(1, math.max(0, (getDistanceBetweenPoints2D(streamData[1], streamData[2], selfCamX, selfCamY) - 1) / 4))

					if streamData[4] then
						dxDrawMaterialLine3D(streamData[1], streamData[2], minePosZ + 4.25, streamData[1], streamData[2], minePosZ - 0.5, spotlightTexture, 6, tocolor(244.8, 224.4, 140.25, 100 * distanceAttenuation * surgeProgress))
					else
						dxDrawMaterialLine3D(streamData[1], streamData[2], minePosZ + 2.25, streamData[1], streamData[2], minePosZ - 0.5, spotlightTexture, 4, tocolor(244.8, 224.4, 140.25, 100 * distanceAttenuation * surgeProgress))
					end
					
					if isElementOnScreen(streamData[5]) then
						distanceAttenuation = math.min(1, math.max(0, (getDistanceBetweenPoints3D(streamData[1], streamData[2], minePosZ + (streamData[4] and 4 or 2), selfCamX, selfCamY, selfCamZ) - 1) / 4))

						if streamData[4] then
							dxDrawMaterialLine3D(streamData[1] - bulbOffsetX, streamData[2] - bulbOffsetY, minePosZ + 4.1 - bulbOffsetZ, streamData[1] + bulbOffsetX, streamData[2] + bulbOffsetY, minePosZ + 4.1 + bulbOffsetZ, headlightTexture, 0.6, tocolor(244.8, 224.4, 140.25, 200 * distanceAttenuation * surgeProgress))
						else
							dxDrawMaterialLine3D(streamData[1] - bulbOffsetX, streamData[2] - bulbOffsetY, minePosZ + 2.1 - bulbOffsetZ, streamData[1] + bulbOffsetX, streamData[2] + bulbOffsetY, minePosZ + 2.1 + bulbOffsetZ, headlightTexture, 0.6, tocolor(244.8, 224.4, 140.25, 200 * distanceAttenuation * surgeProgress))
						end
					end

					if not streamData[3] then
						streamData[3] = true
						numPointLights = numPointLights + 1
						shouldRefreshPointLights = true
					end
				elseif streamData[3] then
					streamData[3] = false
					numPointLights = numPointLights - 1
					shouldRefreshPointLights = true
				end
			end
		end

		-- Handle spot lights
		local spotLightIndex = 0

		for remotePlayer, objectElement in pairs(streamedHardHats) do
			if (not isDieselLocomotive or railCarSyncedBy ~= remotePlayer and not locoSeatByPassenger[remotePlayer]) and isElement(objectElement) then
				local objectMatrix = getElementMatrix(objectElement)
				
				if objectMatrix then
					local objectPosX = objectMatrix[4][1]
					local objectPosY = objectMatrix[4][2]
					local objectPosZ = objectMatrix[4][3]
					
					if convertSingleMineCoordinate(objectPosX) >= -1 and getDistanceBetweenPoints2D(objectPosX, objectPosY, selfPosX, selfPosY) < 60 then
						local objectScaleX, objectScaleY, objectScaleZ = getObjectScale(objectElement)
						
						objectPosX = objectPosX + 0.1 * objectMatrix[2][1] * objectScaleY + 0.0398 * objectMatrix[3][1] * objectScaleZ
						objectPosY = objectPosY + 0.1 * objectMatrix[2][2] * objectScaleY + 0.0398 * objectMatrix[3][2] * objectScaleZ
						objectPosZ = objectPosZ + 0.1 * objectMatrix[2][3] * objectScaleY + 0.0398 * objectMatrix[3][3] * objectScaleZ
						
						local objectVecX = objectMatrix[2][1]
						local objectVecY = objectMatrix[2][2]
						local objectVecZ = objectMatrix[2][3]
						
						spotLightIndex = processSpotLight(spotLightIndex, objectPosX, objectPosY, objectPosZ, objectVecX, objectVecY, objectVecZ, true)
					end
				end
			end
		end

		-- Handle red lights
		local redLightIndex = 0

		if mineMachineData.machineRunProgress >= 0.1 then
			local lightAngle = mineTick % 750 / 750 * math.pi * 2

			local lightDirX = math.cos(lightAngle)
			local lightDirY = math.sin(lightAngle)
			local lightDirZ = 0

			local lightPosX = minePosX - 15.7845 + lightDirX * 0.08
			local lightPosY = minePosY + 6.47950 + lightDirY * 0.08
			local lightPosZ = minePosZ + 2.24120

			redLightIndex = processRedLight(redLightIndex, lightPosX, lightPosY, lightPosZ, lightDirX, lightDirY, lightDirZ)
		end

		if currentMineInventory.dieselLoco then
			local locoEngineRev = getLocoEngineRev()
			
			if locoEngineRev > 0 then
				local locoX, locoY, locoCos, locoSin = getFirstRailCarPosition()

				if getDistanceBetweenPoints2D(locoX, locoY, selfPosX, selfPosY) <= 60 then
					local lightPosX = locoX + locoCos * 1.285
					local lightPosY = locoY + locoSin * 1.285
					local lightPosZ = minePosZ + 0.7646

					if convertSingleMineCoordinate(lightPosX) >= -1 then
						if locoEngineRev < 1 and locoEngineRev <= mineTick % 200 / 200 then
							lightPosZ = minePosZ - 5000
						end

						spotLightIndex = processSpotLight(spotLightIndex, lightPosX, lightPosY, lightPosZ, locoCos, locoSin, 0)
					end

					if locoEngineRev >= 1 then
						local lightAngle = mineTick % 750 / 750 * math.pi * 2

						local lightDirX = math.cos(lightAngle)
						local lightDirY = math.sin(lightAngle)
						local lightDirZ = 0

						local lightPosX = locoX + locoCos * 1.15233 - locoSin * 0.462 + lightDirX * 0.08
						local lightPosY = locoY + locoSin * 1.15233 + locoCos * 0.462 + lightDirY * 0.08
						local lightPosZ = minePosZ + 1.4138

						redLightIndex = processRedLight(redLightIndex, lightPosX, lightPosY, lightPosZ, lightDirX, lightDirY, lightDirZ)
					end
				end
			end
		end

		-- Handle orange lights
		local orangeLightIndex = 0

		for i = #bombDetonations, 1, -1 do
			local detonationX, detonationY, detonationZ, detonationProgress = unpack(bombDetonations[i])
			detonationProgress = getEasingValue(1 - detonationProgress, "InQuad")
			orangeLightIndex = processOrangeLight(orangeLightIndex, detonationX, detonationY, detonationZ, 35 - detonationProgress * 30, detonationProgress * 10)
		end

		for i = #additionalOrangeLights, 1, -1 do
			orangeLightIndex = processOrangeLight(orangeLightIndex, unpack(additionalOrangeLights[i]))
			table.remove(additionalOrangeLights, i)
		end

		if mineFoundryData.meltingOre then
			local meltPosition = oreTypes[mineFoundryData.meltingOre].meltPosition
			local meltProgress = mineFoundryData.meltProgress * 7.5
			local meltColorProgress = 1
			
			if meltProgress > 1 then
				meltColorProgress = getEasingValue(math.max(0, 1 - (meltProgress - 1) / 6), "OutQuad")
			end

			if isElement(meltShader) then
				dxSetShaderValue(meltShader, "MeltProgress", meltColorProgress)
			end
			
			local flowProgress = math.min(1, meltProgress / 0.3) * 0.3
			local ingotProgress = math.min(1, math.max(0, (meltProgress - 0.3) / 0.7)) * 0.7
			local overallProgress = getEasingValue(flowProgress + ingotProgress, "OutQuad")
			
			local lightRadius = 0.25 + 1.25 * meltColorProgress * overallProgress
			local lightBrightness = math.min(2, meltColorProgress * 5) * overallProgress
			
			if lightRadius > 0 then
				orangeLightIndex = processOrangeLight(orangeLightIndex, meltPosition[1], meltPosition[2], meltPosition[3], lightRadius, lightBrightness, meltColorProgress)
			end
		end

		-- Refresh point lights
		if numStreamedPointLights ~= numPointLights then
			numStreamedPointLights = numPointLights
			shouldRefreshPointLights = true
		end

		if shouldRefreshPointLights then
			refreshPointLights()

			if #streamedPointLights <= maxPointLights then
				shouldRefreshPointLights = false
			end
		end

		-- Refresh spot lights
		for lightIndex = #streamedSpotLights, spotLightIndex + 1, -1 do
			table.remove(streamedSpotLights, lightIndex)
		end

		if numStreamedSpotLights ~= #streamedSpotLights then
			numStreamedSpotLights = #streamedSpotLights
			shouldRefreshSpotLights = false
		end

		if shouldRefreshSpotLights then
			refreshSpotLights()

			if #streamedSpotLights <= maxPointLights then
				shouldRefreshSpotLights = false
			end
		end

		-- Refresh red lights
		for lightIndex = #streamedRedLights, redLightIndex + 1, -1 do
			table.remove(streamedRedLights, lightIndex)
		end

		if numStreamedRedLights ~= #streamedRedLights then
			numStreamedRedLights = #streamedRedLights
			shouldRefreshRedLights = true
		end

		if shouldRefreshRedLights then
			refreshRedLights()

			if #streamedRedLights <= maxRedLights then
				shouldRefreshRedLights = false
			end
		end

		-- Refresh orange lights
		for lightIndex = #streamedOrangeLights, orangeLightIndex + 1, -1 do
			table.remove(streamedOrangeLights, lightIndex)
		end

		if numStreamedOrangeLights ~= orangeLightIndex then
			numStreamedOrangeLights = orangeLightIndex
			shouldRefreshOrangeLights = true
		end

		if shouldRefreshOrangeLights then
			refreshOrangeLights()

			if #streamedOrangeLights <= maxOrangeLights then
				shouldRefreshOrangeLights = false
			end
		end
	end
end

local function updateLightData(lightData, ...)
	local shouldRefresh = false

	for i = 1, #arg do
		if lightData[i] ~= arg[i] then
			lightData[i] = arg[i]
			shouldRefresh = true
		end
	end

	return shouldRefresh
end

function processSpotLight(lightIndex, lightPosX, lightPosY, lightPosZ, lightDirX, lightDirY, lightDirZ, isHardHat)
	lightIndex = lightIndex + 1
	
	local lightFade = 1 - math.abs(lightDirX * selfCamDirX + lightDirY * selfCamDirY + lightDirZ * selfCamDirZ)
	local lightData = streamedSpotLights[lightIndex] or {}
	
	if isHardHat then
		dxDrawMaterialLine3D(lightPosX, lightPosY, lightPosZ + 0.15, lightPosX, lightPosY, lightPosZ - 0.15, headlightTexture, 0.3, tocolor(255, 242.25, 191.25, (1 - lightFade) * 200), lightPosX + lightDirX, lightPosY + lightDirY, lightPosZ + lightDirZ)
		dxDrawLightCone3D(lightPosX, lightPosY, lightPosZ, lightPosX + lightDirX * 20, lightPosY + lightDirY * 20, lightPosZ + lightDirZ * 20, 5.5, tocolor(255, 242.25, 191.25, lightFade * 220))
	else
		dxDrawMaterialLine3D(lightPosX, lightPosY, lightPosZ + 0.3, lightPosX, lightPosY, lightPosZ - 0.3, headlightTexture, 0.6, tocolor(255, 242.25, 191.25, (1 - lightFade) * 200), lightPosX + lightDirX, lightPosY + lightDirY, lightPosZ + lightDirZ)
		dxDrawLightCone3D(lightPosX, lightPosY, lightPosZ, lightPosX + lightDirX * 15, lightPosY + lightDirY * 15, lightPosZ + lightDirZ * 15, 3.5, tocolor(255, 242.25, 191.25, lightFade * 220))
	end
	
	if updateLightData(lightData, lightPosX, lightPosY, lightPosZ, lightDirX, lightDirY, lightDirZ) then
		shouldRefreshSpotLights = true
	end
	
	if shouldRefreshSpotLights then
		streamedSpotLights[lightIndex] = lightData
	end
	
	return lightIndex
end

function processRedLight(lightIndex, lightPosX, lightPosY, lightPosZ, lightDirX, lightDirY, lightDirZ)
	lightIndex = lightIndex + 1

	local lightFade = 1 - math.abs(lightDirX * selfCamDirX + lightDirY * selfCamDirY + lightDirZ * selfCamDirZ)
	local lightData = streamedRedLights[lightIndex] or {}

	dxDrawMaterialLine3D(lightPosX, lightPosY, lightPosZ + 0.3, lightPosX, lightPosY, lightPosZ - 0.3, headlightTexture, 0.6, tocolor(255, 25, 25, (1 - lightFade) * 200), lightPosX + lightDirX, lightPosY + lightDirY, lightPosZ + lightDirZ)
	-- dxDrawLightCone3D(lightPosX, lightPosY, lightPosZ, lightPosX + lightDirX * 15, lightPosY + lightDirY * 15, lightPosZ + lightDirZ * 15, 3.5, tocolor(255, 25, 25, lightFade * 255))

	if updateLightData(lightData, lightPosX, lightPosY, lightPosZ, lightDirX, lightDirY, lightDirZ) then
		shouldRefreshRedLights = true
	end

	if shouldRefreshRedLights then
		streamedRedLights[lightIndex] = lightData
	end

	return lightIndex
end

function processOrangeLight(lightIndex, lightX, lightY, lightZ, lightRadius, lightBrightness, lightProgress)
	local playerToLightDistance = getDistanceBetweenPoints2D(lightX, lightY, selfPosX, selfPosY)

	if playerToLightDistance <= 40 + lightRadius then
		lightIndex = lightIndex + 1
		lightProgress = tonumber(lightProgress) or -1

		local lightData = streamedOrangeLights[lightIndex] or {}

		if updateLightData(lightData, lightX, lightY, lightZ, lightRadius, lightBrightness, lightProgress) then
			shouldRefreshOrangeLights = true
		end

		if shouldRefreshOrangeLights then
			streamedOrangeLights[lightIndex] = lightData
		end

		return lightIndex
	end
end

local function sortPointLights(a, b)
	return a[3] < b[3]
end

function refreshPointLights()
	local sortedLights = {}

	for lightIndex = 1, #streamedPointLights do
		local streamData = streamedPointLights[lightIndex]

		if streamData[3] then
			table.insert(sortedLights, {streamData[1], streamData[2], getDistanceBetweenPoints2D(selfPosX, selfPosY, streamData[1], streamData[2]), streamData[4]})
		end
	end

	table.sort(sortedLights, sortPointLights)

	for lightIndex = 1, math.min(maxPointLights, #sortedLights) do
		local lightPosX, lightPosY, lightPosZ = sortedLights[lightIndex][1], sortedLights[lightIndex][2], minePosZ + (sortedLights[lightIndex][4] and 2 or 0)

		for shaderIndex = 1, #shaderElements do
			dxSetShaderValue(shaderElements[shaderIndex], "PointLightPos"   .. lightIndex, lightPosX, lightPosY, lightPosZ)
			dxSetShaderValue(shaderElements[shaderIndex], "PointLightState" .. lightIndex, true)
		end
	end

	for lightIndex = #sortedLights + 1, maxPointLights do
		for shaderIndex = 1, #shaderElements do
			dxSetShaderValue(shaderElements[shaderIndex], "PointLightState" .. lightIndex, false)
		end
	end
end

function refreshSpotLights()
	for lightIndex = 1, math.min(maxSpotLights, #streamedSpotLights) do
		local lightPosX, lightPosY, lightPosZ, lightDirX, lightDirY, lightDirZ = unpack(streamedSpotLights[lightIndex])

		for shaderIndex = 1, #shaderElements do
			dxSetShaderValue(shaderElements[shaderIndex], "SpotLightPos"   .. lightIndex, lightPosX, lightPosY, lightPosZ)
			dxSetShaderValue(shaderElements[shaderIndex], "SpotLightDir"   .. lightIndex, lightDirX, lightDirY, lightDirZ)
			dxSetShaderValue(shaderElements[shaderIndex], "SpotLightState" .. lightIndex, true)
		end
	end

	for lightIndex = #streamedSpotLights + 1, maxSpotLights do
		for shaderIndex = 1, #shaderElements do
			dxSetShaderValue(shaderElements[shaderIndex], "SpotLightState" .. lightIndex, false)
		end
	end
end

function refreshRedLights()
	for lightIndex = 1, math.min(maxRedLights, #streamedRedLights) do
		local lightPosX, lightPosY, lightPosZ, lightDirX, lightDirY, lightDirZ = unpack(streamedRedLights[lightIndex])

		for shaderIndex = 1, #shaderElements do
			dxSetShaderValue(shaderElements[shaderIndex], "RedLightPos"   .. lightIndex, lightPosX, lightPosY, lightPosZ)
			dxSetShaderValue(shaderElements[shaderIndex], "RedLightDir"   .. lightIndex, lightDirX, lightDirY, lightDirZ)
			dxSetShaderValue(shaderElements[shaderIndex], "RedLightState" .. lightIndex, true)
		end
	end

	for lightIndex = #streamedRedLights + 1, maxRedLights do
		for shaderIndex = 1, #shaderElements do
			dxSetShaderValue(shaderElements[shaderIndex], "RedLightState" .. lightIndex, false)
		end
	end
end

local function sortOrangeLights(a, b)
	return a[7] < b[7]
end

function refreshOrangeLights()
	local sortedLights = {}

	for lightIndex = 1, #streamedOrangeLights do
		local lightData = streamedOrangeLights[lightIndex]

		table.insert(sortedLights, {
			lightData[1],
			lightData[2],
			lightData[3],
			lightData[4],
			lightData[5],
			lightData[6],
			getDistanceBetweenPoints2D(selfPosX, selfPosY, lightData[1], lightData[2])
		})
	end

	table.sort(sortedLights, sortOrangeLights)

	for lightIndex = 1, math.min(maxOrangeLights, #sortedLights) do
		local lightX, lightY, lightZ, lightRadius, lightBrightness, lightProgress = unpack(sortedLights[lightIndex])

		for shaderIndex = 1, #shaderElements do
			dxSetShaderValue(shaderElements[shaderIndex], "OrangeLightPos"      .. lightIndex, lightX, lightY, lightZ)
			dxSetShaderValue(shaderElements[shaderIndex], "OrangeLightData"     .. lightIndex, lightRadius, lightBrightness)
			dxSetShaderValue(shaderElements[shaderIndex], "OrangeLightProgress" .. lightIndex, lightProgress)
			dxSetShaderValue(shaderElements[shaderIndex], "OrangeLightState"    .. lightIndex, true)
		end
	end

	for lightIndex = #sortedLights + 1, maxOrangeLights do
		for shaderIndex = 1, #shaderElements do
			dxSetShaderValue(shaderElements[shaderIndex], "OrangeLightState" .. lightIndex, false)
		end
	end
end

function addOrangeLight(lightX, lightY, lightZ, lightRadius, lightBrightness)
	table.insert(additionalOrangeLights, {lightX, lightY, lightZ, lightRadius, lightBrightness})
end

function dxDrawLightCone3D(sourceX, sourceY, sourceZ, targetX, targetY, targetZ, coneSize, coneColor)
	local surfaceHit, surfaceX, surfaceY, surfaceZ = processLineOfSight(sourceX, sourceY, sourceZ, targetX, targetY, targetZ)
	local scaleFactor = 1
	
	if surfaceHit then
		scaleFactor = getDistanceBetweenPoints3D(sourceX, sourceY, sourceZ, surfaceX, surfaceY, surfaceZ) / getDistanceBetweenPoints3D(sourceX, sourceY, sourceZ, targetX, targetY, targetZ)
	end

	dxDrawMaterialLine3D(sourceX, sourceY, sourceZ, surfaceX or targetX, surfaceY or targetY, surfaceZ or targetZ, spotlightTexture, coneSize * 4 * scaleFactor, coneColor)
end

function preprocessShader(shaderPath)
	local shaderHandle = fileOpen(shaderPath, true)
	local shaderBuffer = ""

	if shaderHandle then
		shaderBuffer = fileGetContents(shaderHandle)

		if shaderBuffer then
			-- Handle includes
			local lightHelperFile = fileOpen("files/shaders/lighthelper.fxh", true)

			if lightHelperFile then
				local lightHelperData = fileGetContents(lightHelperFile)
				
				if lightHelperData then
					local lightHelperLines = split(lightHelperData, "\n")
					local lightHelperExports = {}

					for lineIndex = 1, #lightHelperLines do
						local exportName = lightHelperLines[lineIndex]:match(">export:(%w+)")

						if exportName then
							lightHelperExports[exportName] = true
						end
					end

					for exportName in pairs(lightHelperExports) do
						local exportStart = lightHelperData:find((">export:%s"):format(exportName))

						if exportStart then
							local exportEnd = lightHelperData:find("<exportend", exportStart)

							if exportEnd then
								local exportData = lightHelperData:sub(exportStart, exportEnd + 9)
								local exportLines = split(exportData, "\n")

								table.remove(exportLines, 1)
								table.remove(exportLines, #exportLines)

								shaderBuffer = shaderBuffer:gsub(("::%s::"):format(exportName), table.concat(exportLines, "\n"))
							else
								outputDebugString("[Shader Preprocessor]: Failed to find end of export '" .. exportName .. "'", 1)
							end
						else
							shaderBuffer = shaderBuffer:gsub(("::%s::"):format(exportName), "")
						end
					end
				else
					outputDebugString("[Shader Preprocessor]: Failed to load helper shader", 2)
				end

				fileClose(lightHelperFile)
			end

			-- Handle variables
			local shaderVariables = {
				maxSpotLights = maxSpotLights,
				maxPointLights = maxPointLights,
				maxRedLights = maxRedLights,
				maxOrangeLights = maxOrangeLights,
				
				wallMeshWidth = wallMeshWidth,
				wallMeshHeight = wallMeshHeight,
				wallMaximumDepth = wallMaximumDepth,

				insideFarClipDistance = insideFarClipDistance,
			}

			for variableName, variableValue in pairs(shaderVariables) do
				shaderBuffer = shaderBuffer:gsub(("::%s::"):format(variableName), variableValue)
			end

			-- Handle loops
			local loopStart = shaderBuffer:find("::loop")

			while loopStart do
				local loopEnd = shaderBuffer:find("::end", loopStart)

				if loopEnd then
					local loopLines = split(shaderBuffer:sub(loopStart, loopEnd + 4), "\n")

					if #loopLines > 0 then
						local variableName, startIndex, stopIndex = loopLines[1]:match("::loop%((%w+),%s*(%d+),%s*(%d+)%)")

						if variableName and startIndex and stopIndex then
							startIndex = tonumber(startIndex)
							stopIndex = tonumber(stopIndex)

							table.remove(loopLines, 1)
							table.remove(loopLines, #loopLines)

							local loopContent = table.concat(loopLines, "\n")
							local finalContent = ""

							for iteratorIndex = startIndex, stopIndex do
								finalContent = finalContent .. loopContent:gsub("%(:" .. variableName .. ":%)", iteratorIndex)

								if iteratorIndex < stopIndex then
									finalContent = finalContent .. "\n"
								end
							end

							shaderBuffer = shaderBuffer:sub(1, loopStart - 1) .. finalContent .. shaderBuffer:sub(loopEnd + 5)
						else
							outputDebugString("[Shader Preprocessor]: Failed to parse loop in " .. shaderBuffer, 1)
						end
					else
						outputDebugString("[Shader Preprocessor]: Empty loop in " .. shaderBuffer, 2)
					end
				else
					outputDebugString("[Shader Preprocessor]: Missing loop end in " .. shaderBuffer, 1)
				end

				loopStart = shaderBuffer:find("::loop", loopStart + 1)
			end
		end

		fileClose(shaderHandle)
	end

	return shaderBuffer
end

local handleProcessedHardhatsState = false
local function handleProcessedHardhats(cond, prio)
	cond = cond and true or false
	if cond ~= handleProcessedHardhatsState then
		handleProcessedHardhatsState = cond
		if cond then
			addEventHandler("onClientPreRender", getRootElement(), processHardHats, true, prio)
		else
			removeEventHandler("onClientPreRender", getRootElement(), processHardHats)
		end
	end
end


function processHardHats()
	local noHardHatsPresent = true
	for playerElement, hardHatObject in pairs(streamedHardHats) do
		noHardHatsPresent = false
		iprint(hardHatObject)
		if not isElement(playerElement) or not isElement(hardHatObject) or getElementModel(hardHatObject) ~= modelIds.v4_mining_hardhat then
			streamedHardHats[playerElement] = nil
		end
	end
	if noHardHatsPresent then
		handleProcessedHardhats(false)
	end
end

function setStreamedHardHat(playerElement, objectElement)
	streamedHardHats[playerElement] = objectElement
	handleProcessedHardhats(true)
end