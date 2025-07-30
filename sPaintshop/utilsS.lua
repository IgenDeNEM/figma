function processJSON(jsonTable)
  local newTable = {}
  for key, value in pairs(jsonTable) do
    local numericKey = tonumber(key)
    if numericKey then
      key = numericKey
    end

    if type(value) == "table" then
      newTable[key] = processJSON(value)
    else
      newTable[key] = value
    end
  end
  return newTable
end

function readFileData(filePath)
  local fileData = false
  if filePath and fileExists(filePath) then
    local thisFile = fileOpen(filePath, true)
    if thisFile then
      local content = fileRead(thisFile, fileGetSize(thisFile))
      fileData = processJSON(fromJSON(content))
      fileClose(thisFile)
    end
  end
  return fileData
end

function getWorkshopSavedData(workshopIdentity)
    local filePath = "data/"..workshopIdentity.."/workshopData.sight"
    if fileExists(filePath) then
        return readFileData(filePath)
    else
        local defaultPath = "data/defaultData.sight"
        local fileData = readFileData(defaultPath)
        local workshopFile = fileCreate("data/"..workshopIdentity.."/workshopData.sight")
        fileWrite(workshopFile, toJSON(fileData, false, "tabs"))
        fileClose(workshopFile)
        return fileData
    end
end

function saveWorkshopData(workshopIdentity, partialData)
    local filePath = "data/"..workshopIdentity.."/workshopData.sight"

    local fullData = getWorkshopSavedData(workshopIdentity) or {}

    for key, val in pairs(partialData) do
        fullData[key] = val
    end

    if fileExists(filePath) then
        local f = fileOpen(filePath)
        fileSetPos(f, 0)
        fileWrite(f, toJSON(fullData, false, "tabs"))
        fileClose(f)
    else
        local f = fileCreate(filePath)
        fileWrite(f, toJSON(fullData, false, "tabs"))
        fileClose(f)
    end
end

function saveFileData(filePath, data)
  if not filePath then return false end
  
  local file = fileCreate(filePath)
  if file then
    local success = fileWrite(file, toJSON(data, false, "tabs"))
    fileClose(file)
    return success
  end
  return false
end

function fromUInt32(str)
    local byte1, byte2, byte3, byte4 = string.byte(str, 1, 4)
    if byte1 and byte2 and byte3 and byte4 then
        return byte4 * 0x1000000 + byte3 * 0x10000 + byte2 * 0x100 + byte1
    end

    return false
end

local uint32Cache = {}
function toUInt32(number)
    number = math.floor(number) % 0x100000000

    if not uint32Cache[number] then
        local byte4 = string.char(number % 256)
        local byte3 = string.char(math.floor(number / 0x100) % 256)
        local byte2 = string.char(math.floor(number / 0x10000) % 256)
        local byte1 = string.char(math.floor(number / 0x1000000) % 256)

        uint32Cache[number] = byte4 .. byte3 .. byte2 .. byte1
    end

    return uint32Cache[number]
end

function packSync(syncId, syncValue)
    return toUInt32(syncId * 256 + syncValue)
end

function unpackSync(packedValue)
    packedValue = fromUInt32(packedValue)
    
    if packedValue then
        local syncId = math.floor(packedValue / 256)
        local syncValue = packedValue % 256
        
        return syncId, syncValue
    end
    return false
end

function loadFileData(filePath)
    local fileHandle = fileOpen(filePath, true)

    if fileHandle then
        local fileData = fileRead(fileHandle, fileGetSize(fileHandle))
        
        fileClose(fileHandle)

        return fileData
    end
    return false
end

function loadBrushData(brushType, asyncIterTick, asyncIterTime)
    local brushName = brushTypes[brushType]
    local asyncMode = coroutine.running()

    if not brushPixels[brushType] then
        local fileData = LoadFileData("assets/brushes/" .. brushName .. ".see")

        if fileData then
            local scriptedBrushSize = brushSizes[brushType]
            local originalBrushSize = math.sqrt(#fileData)
            local sizeScaleFactor = originalBrushSize / scriptedBrushSize

            brushPixels[brushType] = {}

            for pixelY = 0, scriptedBrushSize - 1 do
                brushPixels[brushType][pixelY] = {}

                for pixelX = 0, scriptedBrushSize - 1 do
                    local originalX = math.floor(pixelX * sizeScaleFactor)
                    local originalY = math.floor(pixelY * sizeScaleFactor)

                    local pixelIndex = originalY * originalBrushSize + originalX
                    local pixelAlpha = fileData:sub(pixelIndex, pixelIndex + 1):byte()

                    brushPixels[brushType][pixelY][pixelX] = pixelAlpha / 255

                    if asyncMode then
                        if getTickCount() - asyncIterTick > asyncIterTime then
                            asyncIterTick = coroutine.yield()
                        end
                    end
                end
            end
        end
        fileData = nil
    end
    collectgarbage()
end

function checkPaintshopProgress(workId)
    local workshopId = getWorkshopFromWork(workId)
    local workNumber = convertWorkId(workshopId, workId)

    local workData = paintshopWorks[workshopId][workNumber]
    local workMaskData = workMasksCache[workId]

    local brushSize = brushSizes[workData.workState]
    local brushRadius = math.max(2, brushSize / 2)
    local brushPixels = brushPixels[workData.workState]

    local overallSum = 0
    local coveredSum = 0

    local validPixels = {}
    local accumulatedAlpha = {}

    local saveFile = false

    local defaultMaskData = {}
    local defaultMaskFile = fileOpen("assets/paintjobs/" .. paintJobs[workData.paintjobId]["dataPath"] .. "/mask.sight", true)

    if defaultMaskFile then
        local iterationCounter = 0
    
        while not fileIsEOF(defaultMaskFile) do
            defaultMaskData[iterationCounter] = fileRead(defaultMaskFile, 1):byte()
    
            iterationCounter = iterationCounter + 1
        end
    
        fileClose(defaultMaskFile)
    end
    
    
    for i = 0, (1025 * 1025) do
        local grayScaleValue = defaultMaskData[i] or 255
    
        if grayScaleValue < 128 then
            grayScaleValue = workMaskData[i] or 255
        end
    
        if grayScaleValue < 128 then
            validPixels[i] = true
            overallSum = overallSum + 1
        end
    end    
end

function processWorkStateSwitching(asyncIterTick, asyncIterTime, workId, isSandingSkip)
    local workshopId = getWorkshopFromWork(workId)
    local workNumber = convertWorkId(workshopId, workId)

    local workData = paintshopWorks[workshopId][workNumber]
    local workStateMaskData = workStateMasks[workId]
    local workMaskPixelData = workMasksCache[workId]

    local brushSize = brushSizes[workData.workState]
    local brushRadius = math.max(2, brushSize / 2)
    local brushPixels = brushPixels[workData.workState]

    local maskPixelValues = {}

    for i = 0, biggestSync do
        if isSandingSkip then
            local grayScaleValue = workMaskPixelData[i]

            if grayScaleValue < 128 then
                maskPixelValues[i] = 0
            else
                maskPixelValues[i] = grayScaleValue
            end
        elseif workStateMaskData then
            maskPixelValues[i] = 255
        end

        if getTickCount() - asyncIterTick > asyncIterTime then
            asyncIterTick = coroutine.yield()
        end
    end

    if workStateMaskData then
        local accumulatedAlpha = {}

        for syncId, syncValue in pairs(workStateMasks[workId]) do
            local coordX, coordY = syncToCoord(syncId)

            coordX = coordX - brushRadius
            coordY = coordY - brushRadius

            if syncValue > 0 then
                if not saveFile then
                    saveFile = fileCreate("data/workstatemasks/" .. workId .. ".see")
                end

                if saveFile then
                    fileWrite(saveFile, packSync(syncId, syncValue))
                end
            end

            syncValue = syncValue / 255

            for pixelY = 0, brushSize - 1 do
                for pixelX = 0, brushSize - 1 do
                    local pixelSyncId = coordToSync(coordX + pixelX, coordY + pixelY)

                    if validPixels[pixelSyncId] then
                        local pixelAlpha = brushPixels[pixelY][pixelX]

                        if pixelAlpha > 0 then
                            pixelAlpha = syncValue * pixelAlpha

                            if not accumulatedAlpha[pixelSyncId] then
                                accumulatedAlpha[pixelSyncId] = pixelAlpha
                            else
                                accumulatedAlpha[pixelSyncId] = pixelAlpha + accumulatedAlpha[pixelSyncId] * (1 - pixelAlpha) -- Inline alphaBlend()
                            end
                        end
                    end
                end
            end
        end
    end
end
