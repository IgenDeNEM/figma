local fileCache = {
	txd = {},
	col = {},
	dff = {}
}
function hashError(fileName)
	outputChatBox("HASH ERROR! " .. fileName)
end
local rawBuffer = ""
local hashBuffer = ""
local pieceBuffer = {}
function teaDecodeBinary(data, key)
	return decodeString("base64", teaDecode(data, key))
end
function solveProtect(protectType, fileName, protectionDataset, offset)
	if protectType == "fast" and fileExists(fileName .. ".see1") and fileExists(fileName .. ".see2") then
		local file1 = fileOpen(fileName .. ".see1")
		local file2 = fileOpen(fileName .. ".see2")
		if file1 and file2 then
			pieceBuffer = {}
			rawBuffer = fileRead(file2, fileGetSize(file2))
			rawBuffer = split(rawBuffer, "\n")
			local rbPart = 1
			for i = 3, #protectionDataset, 2 do
				local piece = protectionDataset[i]
				local key = protectionDataset[i + 1]
				local k2 = false
				if offset then
					k2 = ""
					for j = 1, #key do
						k2 = k2 .. utf8.char(key[j] - offset - j)
					end
				end
				pieceBuffer[piece] = teaDecodeBinary(rawBuffer[rbPart], k2 or key)
				k2 = nil
				key = nil
				rbPart = rbPart + 1
			end
			rawBuffer = ""
			collectgarbage("collect")
			for i = 1, protectionDataset[2] do
				if pieceBuffer[i] then
					rawBuffer = rawBuffer .. pieceBuffer[i]
				else
					rawBuffer = rawBuffer .. fileRead(file1, 1024)
				end
			end
			pieceBuffer = {}
			fileClose(file1)
			fileClose(file2)
			collectgarbage("collect")
			return true
		end
	end
end
function fileReadEx(fileName)
	rawBuffer = ""
	if fileProtectList[fileName] then
		solveProtect(fileProtectList[fileName][1], fileName, fileProtectList[fileName])
	elseif fileExists(fileName) then
		local file = fileOpen(fileName)
		if file then
			rawBuffer = fileRead(file, fileGetSize(file))
			hashBuffer = sha256(rawBuffer)
			fileClose(file)
			return true
		end
	end
	return false
end
function loadBuffer(fileType, buffer)
	if not buffer then return false end
	local file
	if fileType == "txd" then
		file = engineLoadTXD(buffer)
	elseif fileType == "col" then
		file = engineLoadCOL(buffer)
	elseif fileType == "dff" then
		file = engineLoadDFF(buffer)
	end
	return file
end
function unloadFile(fileType, fileName)
	if fileCache[fileType][fileName] and isElement(fileCache[fileType][fileName]) then
		destroyElement(fileCache[fileType][fileName])
	end
	fileCache[fileType][fileName] = nil
end
function unloadFiles()
	for fileType, dat in pairs(fileCache) do
		for fileName, file in pairs(dat) do
			unloadFile(fileType, fileName)
		end
	end
end
function loadFile(fileType, fileName, gotBuffer)
	if not fileCache[fileType][fileName] then
		if not gotBuffer then
			rawBuffer = ""
			hashBuffer = ""
			pieceBuffer = {}
			collectgarbage("collect")
			if not fileReadEx(fileName) then
				rawBuffer = ""
				hashBuffer = ""
				pieceBuffer = {}
				collectgarbage("collect")
				return false
			end
		end
		if fileHashList[fileName] then
			if type(fileHashList[fileName]) == "boolean" then
			elseif fileHashList[fileName] ~= hashBuffer then
				hashError(fileName)
				return
			end
		end
		
		--[[
		local thisFile = fileCreate("decrypted/"..fileName)
		fileWrite(thisFile, rawBuffer)
		fileClose(thisFile)
		]]
		
		if fileType == "txd" then
			fileCache[fileType][fileName] = engineLoadTXD(rawBuffer)
		elseif fileType == "col" then
			fileCache[fileType][fileName] = engineLoadCOL(rawBuffer)
		elseif fileType == "dff" then
			fileCache[fileType][fileName] = engineLoadDFF(rawBuffer)
		end
		rawBuffer = ""
		hashBuffer = ""
		pieceBuffer = {}
		collectgarbage("collect")
	end
	return fileCache[fileType][fileName]
end
addEvent("gotServersideProtection", true)
addEventHandler("gotServersideProtection", getRootElement(), function(k, fileType, fileName, data, offset)
	if data and modelList[k] then
		solveProtect(data[1], fileName, data, offset)
		local model = modelList[k].model
		if model then
			if fileType == "col" then
				local file = loadFile("col", fileName, true)
				if file then
					engineReplaceCOL(file, model)
				end
			elseif fileType == "txd" then
				local file = loadFile("txd", fileName, true)
				if file then
					engineImportTXD(file, model)
				end
			elseif fileType == "dff" then
				local file = loadFile("dff", fileName, true)
				if file then
					if modelList[k].delayedLoad then
						setTimer(engineReplaceModel, 10000, 1, file, model, modelList[k].transparent)
					else
						engineReplaceModel(fileCache.dff[modelList[k].dff], model, modelList[k].transparent)
					end
				end
			end
		end
		modelList[k].pendingLoad = (modelList[k].pendingLoad or 0) - 1
	end
	rawBuffer = ""
	hashBuffer = ""
	pieceBuffer = {}
	data = nil
	offset = nil
	collectgarbage("collect")
end)
function checkServersideProtection(k, fileType, fileName)
	if fileProtectList[fileName] == "server" and not fileCache[fileType][fileName] then
		modelList[k].pendingLoad = (modelList[k].pendingLoad or 0) + 1
		triggerServerEvent("requestServersideProtection", localPlayer, k, fileType, fileName)
		return false
	end
	return true
end

local imagePieces = 4
local processedImageContainer = false
function createModloaderImg()
  if processedImageContainer then
    return 
  end
  local currentId = 1
  for imageId = 1, 5 do
    currentId = imageId
    if fileExists("img/v4_" .. currentId .. ".img") then
      if fileDelete("img/v4_" .. currentId .. ".img") then
        break
      end
    else
      break
    end
  end
  local createdImage = fileCreate("img/v4_" .. currentId .. ".img")
  for r5_10 = 1, imagePieces do
    local imageData = false
    if fileExists("img/v4." .. r5_10 .. ".img") then
      local openedImage = fileOpen("img/v4." .. r5_10 .. ".img")
      imageData = fileRead(openedImage, fileGetSize(openedImage))
      fileClose(openedImage)
      fileWrite(createdImage, imageData)
    end
    imageData = nil
    collectgarbage("collect")
  end
  fileClose(createdImage)
  processedImageContainer = true
  loadedImage = engineLoadIMG("img/v4_" .. currentId .. ".img")
  engineAddImage(loadedImage)
end

local imgTextures = {}
local txdId = 1
function getImgTexture(txdPath)
  if imgTextures[txdPath] then
    return imgTextures[txdPath]
  else
    local txdData = engineRequestTXD("IMGTXD" .. txdId)
    txdId = txdId + 1
    engineImageLinkTXD(loadedImage, txdPath, txdData)
    imgTextures[txdPath] = txdData
    return txdData
  end
end

function loadModel(k)
	local model = modelList[k].model
	if model and not modelList[k].loaded then
		if modelList[k].col and checkServersideProtection(k, "col", modelList[k].col) then
			local file
			if modelList[k].loadFromPath or modelList[k].loadFromPathCol then
				if not fileCache.col[modelList[k].col] then
					fileCache.col[modelList[k].col] = engineLoadCOL(modelList[k].col)
				end
				file = fileCache.col[modelList[k].col]
			else
				file = loadFile("col", modelList[k].col)
			end
			if file then
				engineReplaceCOL(file, model)
			end
		end
		if (modelList[k].img or false) then
		end
		if modelList[k].img then
			if not loadedImage then
				createModloaderImg()
			end
			if modelList[k].dff then
				engineImageLinkDFF(loadedImage, modelList[k].dff, model)
			end
			if modelList[k].txd then
				engineSetModelTXDID(model, getImgTexture(modelList[k].txd))
			end
		else
			if modelList[k].txd and checkServersideProtection(k, "txd", modelList[k].txd) then
				local file
				if modelList[k].loadFromPath or modelList[k].loadFromPathTxd then
					if not fileCache.txd[modelList[k].txd] then
						fileCache.txd[modelList[k].txd] = engineLoadTXD(modelList[k].txd, false)
					end
					file = fileCache.txd[modelList[k].txd]
				else
					file = loadFile("txd", modelList[k].txd)
				end
				if file then
					engineImportTXD(file, model)
				end
			end
			if modelList[k].dff and checkServersideProtection(k, "dff", modelList[k].dff) then
				local file
				if modelList[k].loadFromPath or modelList[k].loadFromPathDff then
					if not fileCache.dff[modelList[k].dff] then
						fileCache.dff[modelList[k].dff] = engineLoadDFF(modelList[k].dff)
					end
					file = fileCache.dff[modelList[k].dff]
				else
					file = loadFile("dff", modelList[k].dff)
				end
				if file then
					if modelList[k].delayedLoad then
						setTimer(engineReplaceModel, 10000, 1, file, model, modelList[k].transparent)
					else
						engineReplaceModel(file, model, modelList[k].transparent)
					end
				end
			end
		end

		if modelList[k].lodDistance then
			engineSetModelLODDistance(model, modelList[k].lodDistance)
		end
		
		if modelList[k].visibleTime then
			engineSetModelVisibleTime(model, tonumber(modelList[k].visibleTime.timeOn), tonumber(modelList[k].visibleTime.timeOff))
		end
		
		if modelList[k].flags then
			for flagIndex, flagName in pairs(modelList[k].flags) do
				engineSetModelFlag(model, flagName, true)
			end
		end
		
		if modelList[k].transparent then
			engineSetModelFlag(model, "draw_last", true)
		end
		
		if modelList[k].static then
			engineSetModelPhysicalPropertiesGroup(model, 0)
		elseif modelList[k].dynamicDoor then
			engineSetModelPhysicalPropertiesGroup(model, 147)
		end

		modelList[k].loaded = true
	end
end
function loadAModel(theType)
	for k in pairs(modelList) do
		if modelList[k].type == theType and (not modelList[k].loaded or modelList[k].pendingLoad) and not modelList[k].doNotLoad then
			if modelList[k].pendingLoad then
				if modelList[k].pendingLoad <= 0 then
					modelList[k].pendingLoad = nil
					return true
				else
					return "pending"
				end
			else
				loadModel(k)
				if modelList[k].pendingLoad then
					return "pending"
				end
			end
			return true
		end
	end
	return false
end
addEvent("modloaderLoaded", false)
addEventHandler("modloaderLoaded", getResourceRootElement(), function()
	rawBuffer = nil
	hashBuffer = nil
	pieceBuffer = nil
	collectgarbage("collect")
end)
local requestedModels = {}
addEventHandler("onClientResourceStop", getResourceRootElement(), function()
	for k, v in pairs(modelList) do
		if v.model then
			engineRestoreModelPhysicalPropertiesGroup(v.model)
			engineResetModelLODDistance(v.model)
			engineRestoreModel(v.model)
			engineRestoreCOL(v.model)
		end
	end
	for i = 1, #requestedModels do
		engineFreeModel(requestedModels[i])
	end
	unloadFiles()
end)
addEventHandler("onClientResourceStart", getResourceRootElement(), function()
	local start = getTickCount()
	for k in pairs(modelList) do
		if modelList[k] then
			local model = false
			if tonumber(modelList[k].model) then
				model = tonumber(modelList[k].model)
				if modelList[k].static then
					engineSetModelPhysicalPropertiesGroup(model, 0)
				end
			elseif modelList[k].model == "object" or modelList[k].model == "vehicle" or modelList[k].model == "ped" then
				if modelList[k].dynamicDoor then
					model = engineRequestModel(modelList[k].model, 1502)
					engineSetModelPhysicalPropertiesGroup(model, 147)
				elseif modelList[k].transparent and modelList[k].flags and modelList[k].flags.NO_ZBUFFER_WRITE then
					model = engineRequestModel(modelList[k].model, 13437)
				elseif modelList[k].transparent and modelList[k].flags and modelList[k].flags.DRAW_LAST then
					model = engineRequestModel(modelList[k].model, 1649)
				else
					model = engineRequestModel(modelList[k].model)
				end
				if model then
					modelList[k].model = model
					table.insert(requestedModels, model)
				end
			end
		end
	end
	if getElementData(localPlayer, "loggedIn") then
		selfLoadCycle()
	end
end)
local nextLoadCycle = false
local loadCycleTimer = false
function skinLoaderCycle()
	local res = loadAModel("skin")
	if res == "pending" then
		nextLoadCycle = skinLoaderCycle
	elseif res then
		nextLoadCycle = skinLoaderCycle
	else
		nextLoadCycle = false
		triggerEvent("modloaderLoaded", getRootElement())
	end
end
function vehicleLoaderCycle()
	local res = loadAModel("vehicle")
	if res == "pending" then
		nextLoadCycle = vehicleLoaderCycle
	elseif res then
		nextLoadCycle = vehicleLoaderCycle
	else
		nextLoadCycle = skinLoaderCycle
	end
end
function modelLoaderCycle()
	local res = loadAModel("object")
	if res == "pending" then
		nextLoadCycle = modelLoaderCycle
	elseif res then
		nextLoadCycle = modelLoaderCycle
	else
		nextLoadCycle = vehicleLoaderCycle
	end
end
function loadCycleFunction()
	if nextLoadCycle then
		nextLoadCycle()
	else
		if isTimer(loadCycleTimer) then
			killTimer(loadCycleTimer)
		end
		loadCycleTimer = false
	end
end
function selfLoadCycle()
	if isTimer(loadCycleTimer) then
		killTimer(loadCycleTimer)
	end
	nextLoadCycle = modelLoaderCycle
	loadCycleTimer = setTimer(loadCycleFunction, 1, 0)
end
function countModels(theType)
	local c = 0
	for k in pairs(modelList) do
		if modelList[k].type == theType and not modelList[k].doNotLoad then
			c = c + 1
		end
	end
	return c
end
addCommandHandler("bugmodels", function()
	for k in pairs(modelList) do
		if modelList[k].type == "vehicle" and modelList[k].nonDynamic or modelList[k].type ~= "vehicle" then
			if modelList[k].dff and not fileCache.dff[modelList[k].dff] then
				outputChatBox("bug model dff: " .. modelList[k].dff)
			end
			if modelList[k].txd and not fileCache.txd[modelList[k].txd] then
				outputChatBox("bug model txd: " .. modelList[k].txd)
			end
			if modelList[k].col and not fileCache.col[modelList[k].col] then
				outputChatBox("bug model col: " .. modelList[k].col)
			end
		end
	end
end)
local modloaderLoaded = false
function isModloaderLoaded()
	return modloaderLoaded
end
addEvent("modloaderLoaded", false)
addEventHandler("modloaderLoaded", getResourceRootElement(), function()
	modloaderLoaded = true
	rawBuffer = nil
	hashBuffer = nil
	pieceBuffer = nil
	collectgarbage("collect")
end)
function getModelPhysicalPropertiesGroup(_, id)
	outputChatBox("[color=sightgreen][" .. id .. "] #ffffffphysicalPropertiesGroup: " .. engineGetModelPhysicalPropertiesGroup(tonumber(id)), 255, 255, 255, true)
end
addCommandHandler("getmodelphysgroup", getModelPhysicalPropertiesGroup)

--[[
addEvent("sModloader:onReloadModelData", true)
addEventHandler("sModloader:onReloadModelData", getRootElement(), function(modelKey, newModelInfo, dffData, colData)
	if not modelList[modelKey] or not newModelInfo then return end
	
	local oldModelInfo = modelList[modelKey]
	local modelId = oldModelInfo.model
	
	if not tonumber(modelId) then
		outputChatBox("[SModloader] Hiba: A(z) " .. modelKey .. " modell ID-ja nem található vagy nem szám.", 255, 0, 0, true)
		return
	end
	
	outputChatBox("[SModloader] Modell újratöltése: " .. (modelKey or "ismeretlen") .. " (" .. modelId .. ")", 0, 200, 50, true)
	
	engineRestoreModelPhysicalPropertiesGroup(modelId)
	engineResetModelLODDistance(modelId)
	engineRestoreModel(modelId)
	engineRestoreCOL(modelId)
	
	if oldModelInfo.dff then
		unloadFile("dff", oldModelInfo.dff)
	end
	if oldModelInfo.col then
		unloadFile("col", oldModelInfo.col)
	end
	
	modelList[modelKey] = newModelInfo
	modelList[modelKey].model = modelId
	
	if colData then
		local colFile = loadBuffer("col", colData)
		if colFile then
			engineReplaceCOL(colFile, modelId)
			fileCache.col[newModelInfo.col] = colFile
		end
	end
	if dffData then
		local dffFile = loadBuffer("dff", dffData)
		if dffFile then
			engineReplaceModel(dffFile, modelId, newModelInfo.transparent or false)
			fileCache.dff[newModelInfo.dff] = dffFile
		end
	end
	
	if newModelInfo.lodDistance then
		engineSetModelLODDistance(modelId, newModelInfo.lodDistance)
	else
		engineResetModelLODDistance(modelId)
	end
	if newModelInfo.visibleTime then
		engineSetModelVisibleTime(modelId, tonumber(newModelInfo.visibleTime.timeOn), tonumber(newModelInfo.visibleTime.timeOff))
	end
	if newModelInfo.flags then
		for _, flagName in pairs(newModelInfo.flags) do
			engineSetModelFlag(modelId, flagName, true)
		end
	end
	
	modelList[modelKey].loaded = true
	
	outputChatBox("[SModloader] A(z) " .. modelKey .. " modell sikeresen újratöltve.", 0, 255, 0, true)
end)

for i = 1, 370 do
	if fileExists("models/" .. i .. ".json") then
		fileDelete("models/" .. i .. ".json")
	end
end
]]