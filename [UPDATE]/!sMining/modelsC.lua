local requestedModels = {}

modelIds = {
	v4_mine_entrance1 = false,
	v4_mine_entrance2 = false,
	v4_mine_entrance3 = false,
	v4_mine_entrance4 = false,
	v4_mine_entrance5 = false,
	v4_mine_entrance6 = false,
	v4_mine_lobby = false,
	v4_mine_lobby_alpha = false,
	v4_mine_table0 = false,
	v4_mine_table1 = false,
	v4_mine_table2 = false,
	v4_mine_table3 = false,
	v4_mine_table4 = false,
	v4_mine_table5 = false,
	v4_mine_hq = false,
	v4_mine_wall = false,
	v4_mine_tunnel1 = false,
	v4_mine_tunnel2 = false,
	v4_mine_tunnel3 = false,
	v4_mine_tunnel4 = false,
	v4_mine_tunnel5 = false,
	v4_mine_tunnel1_columnless = false,
	v4_mine_tunnel2_columnless = false,
	v4_mine_tunnel3_columnless = false,
	v4_mine_tunnel4_columnless = false,
	v4_mine_tunnel5_columnless = false,
	v4_mine_tunnel_left1 = false,
	v4_mine_tunnel_left2 = false,
	v4_mine_tunnel_left3 = false,
	v4_mine_tunnel_left4 = false,
	v4_mine_tunnel_left5 = false,
	v4_mine_tunnel_crossing1 = false,
	v4_mine_tunnel_crossing2 = false,
	v4_mine_tunnel_crossing3 = false,
	v4_mine_tunnel_crossing4 = false,
	v4_mine_tunnel_crossing5 = false,
	v4_mine_rail = false,
	v4_mine_rail_end = false,
	v4_mine_rail_left = false,
	v4_mine_rail_3way = false,
	v4_mine_rail_crossing = false,
	v4_mine_ore1 = false,
	v4_mine_ore2 = false,
	v4_mine_ore3 = false,
	v4_mine_ore4 = false,
	v4_mine_ore5 = false,
	v4_mine_urmamoto = false,
	v4_mine_cart1 = false,
	v4_mine_cart1_turtle = false,
	v4_mine_cart1_wheels = false,
	v4_mine_dynamite = false,
	v4_mine_tablet = false,
	v4_mine_box = false,
	v4_mine_box_content = false,
	v4_mine_furnace = false,
	v4_mine_ingot = false,
	v4_mine_flow = false,
	v4_mine_lamp = false,
	v4_mine_jerrycan = false,
	v4_mine_machine = false,
	v4_mine_machine2 = false,
	v4_mine_machine_crusher = false,
	v4_mine_ore_debris = false,
	v4_mine_ore_debris2 = false,
	v4_mine_tank = false,
	v4_mine_silo = false,
	v4_mining_hardhat = false,
	v4_mining_chest2 = false,
	v4_mine_cargo_rail = false,
	v4_mine_cargo_wood = false,
	v4_mine_cargo_lamp = false,
	v4_mine_cargo_cart1 = false,
	v4_mine_cargo_urmamoto = false,
}

modelPool = {}
modelPoolCount = 0

railModels = {}
tunnelModels = {}

local function loadModels()
	if isElement(mineHq) then
		destroyElement(mineHq)
	end

	railModels = {}
	tunnelModels = {}

	for modelName in pairs(modelIds) do
		modelIds[modelName] = exports.sModloader:getModelId(modelName)

		if string.find(modelName, "v4_mine_tunnel") then
			tunnelModels[modelIds[modelName]] = true
		end

		if string.find(modelName, "v4_mine_rail") then
			railModels[modelIds[modelName]] = modelName
		end
	end

	mineHq = createObject(modelIds.v4_mine_hq, mineHqX, mineHqY, mineHqZ, 0, 0, 180)

	if isElement(mineHq) then
		setElementInterior(mineHq, 0)
		setElementDimension(mineHq, 1)
	end
end

addEventHandler("onClientResourceStart", resourceRoot,
	function ()
		loadModels()

		for i = 1, 10 do
			table.insert(requestedModels, engineRequestModel("object"))
		end
	end
)

addEventHandler("onClientResourceStop", resourceRoot,
	function ()
		for i = 1, #requestedModels do
			engineFreeModel(requestedModels[i])
		end
	end
)

addEventHandler("onModloaderLoaded", localPlayer, loadModels)

function poolGetModel()
	for i = 1, #requestedModels do
		local modelId = requestedModels[i]

		if not modelPool[modelId] then
			modelPool[modelId] = true
			modelPoolCount = modelPoolCount + 1
			return modelId
		end
	end

	local modelId = engineRequestModel("object")

	modelPool[modelId] = true
	modelPoolCount = modelPoolCount + 1
	table.insert(requestedModels, modelId)

	return modelId
end

function poolFreeModel(modelId)
	if modelPool[modelId] then
		modelPool[modelId] = false
		modelPoolCount = modelPoolCount - 1
	end
end

function handleEvent(eventName, attachedElement, handlerFunction, actionType, eventPriority)
    local handledState = false
    
    if type(eventName) == "string" and isElement(attachedElement) and type(handlerFunction) == "function" then
        local attachedFunctions = getEventHandlers(eventName, attachedElement)

        if type(attachedFunctions) == "table" and #attachedFunctions > 0 then
            for _, attachedFunction in ipairs(attachedFunctions) do
                if attachedFunction == handlerFunction then
                    handledState = true
                    break
                end
            end
        end
    end

    if actionType == "addEvent" then
        if not handledState then
            addEventHandler(eventName, attachedElement, handlerFunction, true, eventPriority)
        end
    elseif actionType == "removeEvent" then
        if handledState then
            removeEventHandler(eventName, attachedElement, handlerFunction)
        end
    end
end