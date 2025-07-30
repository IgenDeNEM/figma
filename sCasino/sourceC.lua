local sightexports = {
  sWeather = false,
  sCctv = false,
  sGui = false
}
local function sightlangProcessExports()
  for k in pairs(sightexports) do
    local res = getResourceFromName(k)
    if res and getResourceState(res) == "running" then
      sightexports[k] = exports[k]
    else
      sightexports[k] = false
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
local sightlangStatImgHand = false
local sightlangStaticImage = {}
local sightlangStaticImageToc = {}
local sightlangStaticImageUsed = {}
local sightlangStaticImageDel = {}
local processsightlangStaticImage = {}
sightlangStaticImageToc[0] = true
sightlangStaticImageToc[1] = true
sightlangStaticImageToc[2] = true
sightlangStaticImageToc[3] = true
sightlangStaticImageToc[4] = true
local sightlangStatImgPre
function sightlangStatImgPre()
  local now = getTickCount()
  if sightlangStaticImageUsed[0] then
    sightlangStaticImageUsed[0] = false
    sightlangStaticImageDel[0] = false
  elseif sightlangStaticImage[0] then
    if sightlangStaticImageDel[0] then
      if now >= sightlangStaticImageDel[0] then
        if isElement(sightlangStaticImage[0]) then
          destroyElement(sightlangStaticImage[0])
        end
        sightlangStaticImage[0] = nil
        sightlangStaticImageDel[0] = false
        sightlangStaticImageToc[0] = true
        return
      end
    else
      sightlangStaticImageDel[0] = now + 5000
    end
  else
    sightlangStaticImageToc[0] = true
  end
  if sightlangStaticImageUsed[1] then
    sightlangStaticImageUsed[1] = false
    sightlangStaticImageDel[1] = false
  elseif sightlangStaticImage[1] then
    if sightlangStaticImageDel[1] then
      if now >= sightlangStaticImageDel[1] then
        if isElement(sightlangStaticImage[1]) then
          destroyElement(sightlangStaticImage[1])
        end
        sightlangStaticImage[1] = nil
        sightlangStaticImageDel[1] = false
        sightlangStaticImageToc[1] = true
        return
      end
    else
      sightlangStaticImageDel[1] = now + 5000
    end
  else
    sightlangStaticImageToc[1] = true
  end
  if sightlangStaticImageUsed[2] then
    sightlangStaticImageUsed[2] = false
    sightlangStaticImageDel[2] = false
  elseif sightlangStaticImage[2] then
    if sightlangStaticImageDel[2] then
      if now >= sightlangStaticImageDel[2] then
        if isElement(sightlangStaticImage[2]) then
          destroyElement(sightlangStaticImage[2])
        end
        sightlangStaticImage[2] = nil
        sightlangStaticImageDel[2] = false
        sightlangStaticImageToc[2] = true
        return
      end
    else
      sightlangStaticImageDel[2] = now + 5000
    end
  else
    sightlangStaticImageToc[2] = true
  end
  if sightlangStaticImageUsed[3] then
    sightlangStaticImageUsed[3] = false
    sightlangStaticImageDel[3] = false
  elseif sightlangStaticImage[3] then
    if sightlangStaticImageDel[3] then
      if now >= sightlangStaticImageDel[3] then
        if isElement(sightlangStaticImage[3]) then
          destroyElement(sightlangStaticImage[3])
        end
        sightlangStaticImage[3] = nil
        sightlangStaticImageDel[3] = false
        sightlangStaticImageToc[3] = true
        return
      end
    else
      sightlangStaticImageDel[3] = now + 5000
    end
  else
    sightlangStaticImageToc[3] = true
  end
  if sightlangStaticImageUsed[4] then
    sightlangStaticImageUsed[4] = false
    sightlangStaticImageDel[4] = false
  elseif sightlangStaticImage[4] then
    if sightlangStaticImageDel[4] then
      if now >= sightlangStaticImageDel[4] then
        if isElement(sightlangStaticImage[4]) then
          destroyElement(sightlangStaticImage[4])
        end
        sightlangStaticImage[4] = nil
        sightlangStaticImageDel[4] = false
        sightlangStaticImageToc[4] = true
        return
      end
    else
      sightlangStaticImageDel[4] = now + 5000
    end
  else
    sightlangStaticImageToc[4] = true
  end
  if sightlangStaticImageToc[0] and sightlangStaticImageToc[1] and sightlangStaticImageToc[2] and sightlangStaticImageToc[3] and sightlangStaticImageToc[4] then
    sightlangStatImgHand = false
    removeEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre)
  end
end
processsightlangStaticImage[0] = function()
  if not isElement(sightlangStaticImage[0]) then
    sightlangStaticImageToc[0] = false
    sightlangStaticImage[0] = dxCreateTexture("files/neon.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[1] = function()
  if not isElement(sightlangStaticImage[1]) then
    sightlangStaticImageToc[1] = false
    sightlangStaticImage[1] = dxCreateTexture("files/neon2.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[2] = function()
  if not isElement(sightlangStaticImage[2]) then
    sightlangStaticImageToc[2] = false
    sightlangStaticImage[2] = dxCreateTexture("files/glass.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[3] = function()
  if not isElement(sightlangStaticImage[3]) then
    sightlangStaticImageToc[3] = false
    sightlangStaticImage[3] = dxCreateTexture("files/admiral_lights.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[4] = function()
  if not isElement(sightlangStaticImage[4]) then
    sightlangStaticImageToc[4] = false
    sightlangStaticImage[4] = dxCreateTexture("files/bubble.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
local sightlangDynImgHand = false
local sightlangDynImgLatCr = falselocal
sightlangDynImage = {}
local sightlangDynImageForm = {}
local sightlangDynImageMip = {}
local sightlangDynImageUsed = {}
local sightlangDynImageDel = {}
local sightlangDynImgPre
function sightlangDynImgPre()
  local now = getTickCount()
  sightlangDynImgLatCr = true
  local rem = true
  for k in pairs(sightlangDynImage) do
    rem = false
    if sightlangDynImageDel[k] then
      if now >= sightlangDynImageDel[k] then
        if isElement(sightlangDynImage[k]) then
          destroyElement(sightlangDynImage[k])
        end
        sightlangDynImage[k] = nil
        sightlangDynImageForm[k] = nil
        sightlangDynImageMip[k] = nil
        sightlangDynImageDel[k] = nil
        break
      end
    elseif not sightlangDynImageUsed[k] then
      sightlangDynImageDel[k] = now + 5000
    end
  end
  for k in pairs(sightlangDynImageUsed) do
    if not sightlangDynImage[k] and sightlangDynImgLatCr then
      sightlangDynImgLatCr = false
      sightlangDynImage[k] = dxCreateTexture(k, sightlangDynImageForm[k], sightlangDynImageMip[k])
    end
    sightlangDynImageUsed[k] = nil
    sightlangDynImageDel[k] = nil
    rem = false
  end
  if rem then
    removeEventHandler("onClientPreRender", getRootElement(), sightlangDynImgPre)
    sightlangDynImgHand = false
  end
end
local function dynamicImage(img, form, mip)
  if not sightlangDynImgHand then
    sightlangDynImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangDynImgPre, true, "high+999999999")
  end
  if not sightlangDynImage[img] then
    sightlangDynImage[img] = dxCreateTexture(img, form, mip)
  end
  sightlangDynImageForm[img] = form
  sightlangDynImageUsed[img] = true
  return sightlangDynImage[img]
end
local sightlangWaiterState0 = false
local function sightlangProcessResWaiters()
  if not sightlangWaiterState0 then
    local res0 = getResourceFromName("sCctv")
    if res0 and getResourceState(res0) == "running" then
      waitForCCTV()
      sightlangWaiterState0 = true
    end
  end
end
if triggerServerEvent then
  addEventHandler("onClientResourceStart", getRootElement(), sightlangProcessResWaiters)
end
if triggerClientEvent then
  addEventHandler("onResourceStart", getRootElement(), sightlangProcessResWaiters)
end
local sightlangCondHandlState1 = false
local function sightlangCondHandl1(cond, prio)
  cond = cond and true or false
  if cond ~= sightlangCondHandlState1 then
    sightlangCondHandlState1 = cond
    if cond then
      addEventHandler("onClientPreRender", getRootElement(), doInitCasinoStuff, true, prio)
    else
      removeEventHandler("onClientPreRender", getRootElement(), doInitCasinoStuff)
    end
  end
end
local sightlangCondHandlState0 = false
local function sightlangCondHandl0(cond, prio)
  cond = cond and true or false
  if cond ~= sightlangCondHandlState0 then
    sightlangCondHandlState0 = cond
    if cond then
      addEventHandler("onClientPreRender", getRootElement(), processJazz, true, prio)
    else
      removeEventHandler("onClientPreRender", getRootElement(), processJazz)
    end
  end
end
local textureChanger = " texture gTexture; technique hello { pass P0 { Texture[0] = gTexture; } } "
local fishTextures = {
  "files/fish1.dds",
  "files/fish2.dds",
  "files/fish3.dds",
  "files/fish4.dds",
  "files/fish5.dds"
}
local lcdTexture = {
  {
    "files/lcd1.dds",
    "dxt1"
  },
  {
    "files/lcd2.dds",
    "dxt1"
  },
  {
    "files/lcd3.dds",
    "dxt1"
  },
  {
    "files/lcd4.dds",
    "dxt1"
  },
  {
    "files/lcd81.dds",
    "dxt1"
  },
  {
    "files/lcd82.dds",
    "dxt1"
  },
  {
    "files/coins.dds"
  },
  {
    "files/fruit.dds"
  },
  {
    "files/cards.dds"
  },
  {
    "files/cash.dds"
  },
  {
    "files/lcd71.dds",
    "dxt1"
  },
  {
    "files/lcd72.dds"
  },
  {
    "files/ball.dds"
  }
}
local neons, neons2, lcd, textureShader, textureShader2
local bubbleDispensers = {
  {
    1066.58484,
    -1475.51904,
    10034.25,
    0,
    10,
    10039
  },
  {
    1069.97546,
    -1475.60754,
    10034.25,
    0,
    10,
    10039
  },
  {
    1073.41345,
    -1475.83435,
    10034.25,
    0,
    10,
    10037.75
  }
}
local s = 1
local switch = false
local floorColColor = {
  255,
  255,
  255,
  255,
  255,
  255
}
local neonColors = {
  {
    255,
    255,
    255
  },
  {
    255,
    255,
    255
  },
  {
    255,
    255,
    255
  },
  {
    255,
    255,
    255
  },
  {
    255,
    255,
    255
  },
  {
    255,
    255,
    255
  },
  {
    255,
    255,
    255
  },
  {
    255,
    255,
    255
  },
  {
    255,
    255,
    255
  },
  {
    255,
    255,
    255
  },
  {
    255,
    255,
    255
  },
  {
    255,
    255,
    255
  },
  {
    255,
    255,
    255
  },
  {
    255,
    255,
    255
  }
}
local roomIds = {
  5,
  6,
  7,
  8,
  10,
  11,
  12,
  13,
  14
}
local lcdX, lcdY = 3200, 64
function generateRandomSlot()
  return {
    {
      math.random(1, 8),
      math.random(1, 8),
      math.random(1, 8),
      math.random(1, 8),
      math.random(1, 8),
      math.random(1, 8),
      math.random(1, 8),
      math.random(1, 8),
      math.random(1, 8)
    },
    {
      math.random(1, 8),
      math.random(1, 8),
      math.random(1, 8),
      math.random(1, 8),
      math.random(1, 8),
      math.random(1, 8),
      math.random(1, 8),
      math.random(1, 8),
      math.random(1, 8)
    },
    {
      math.random(1, 8),
      math.random(1, 8),
      math.random(1, 8),
      math.random(1, 8),
      math.random(1, 8),
      math.random(1, 8),
      math.random(1, 8),
      math.random(1, 8),
      math.random(1, 8)
    },
    {
      math.random(1, 8),
      math.random(1, 8),
      math.random(1, 8),
      math.random(1, 8),
      math.random(1, 8),
      math.random(1, 8),
      math.random(1, 8),
      math.random(1, 8),
      math.random(1, 8)
    },
    {
      math.random(1, 8),
      math.random(1, 8),
      math.random(1, 8),
      math.random(1, 8),
      math.random(1, 8),
      math.random(1, 8),
      math.random(1, 8),
      math.random(1, 8),
      math.random(1, 8)
    },
    {
      math.random(1, 8),
      math.random(1, 8),
      math.random(1, 8),
      math.random(1, 8),
      math.random(1, 8),
      math.random(1, 8),
      math.random(1, 8),
      math.random(1, 8),
      math.random(1, 8)
    },
    {
      math.random(1, 8),
      math.random(1, 8),
      math.random(1, 8),
      math.random(1, 8),
      math.random(1, 8),
      math.random(1, 8),
      math.random(1, 8),
      math.random(1, 8),
      math.random(1, 8)
    },
    {
      math.random(1, 8),
      math.random(1, 8),
      math.random(1, 8),
      math.random(1, 8),
      math.random(1, 8),
      math.random(1, 8),
      math.random(1, 8),
      math.random(1, 8),
      math.random(1, 8)
    },
    {
      math.random(1, 8),
      math.random(1, 8),
      math.random(1, 8),
      math.random(1, 8),
      math.random(1, 8),
      math.random(1, 8),
      math.random(1, 8),
      math.random(1, 8),
      math.random(1, 8)
    },
    {
      math.random(1, 8),
      math.random(1, 8),
      math.random(1, 8),
      math.random(1, 8),
      math.random(1, 8),
      math.random(1, 8),
      math.random(1, 8),
      math.random(1, 8),
      math.random(1, 8)
    }
  }
end
local lcdAnimation = {
  "roulette",
  getTickCount()
}
function drawNeonsFinal()
  local now = getTickCount()
  if switch and now > switch then
    local p = (now - switch) / 10000
    if 1 < p then
      p = 1
    end
    local i = currentFirstColor
    local n = currentFirstColor + 1
    if n > #firstFloor then
      n = 1
    end
    local r = firstFloor[i][1] + (firstFloor[n][1] - firstFloor[i][1]) * p
    local g = firstFloor[i][2] + (firstFloor[n][2] - firstFloor[i][2]) * p
    local b = firstFloor[i][3] + (firstFloor[n][3] - firstFloor[i][3]) * p
    floorColColor[1] = r
    floorColColor[2] = g
    floorColColor[3] = b
    neonColors[1][1] = r
    neonColors[1][2] = g
    neonColors[1][3] = b
    neonColors[9][4] = r
    neonColors[9][5] = g
    neonColors[9][6] = b
    neonColors[2][1] = r
    neonColors[2][2] = g
    neonColors[2][3] = b
    neonColors[3][4] = r
    neonColors[3][5] = g
    neonColors[3][6] = b
    neonColors[4][1] = r
    neonColors[4][2] = g
    neonColors[4][3] = b
    local r = firstFloor[i][4] + (firstFloor[n][4] - firstFloor[i][4]) * p
    local g = firstFloor[i][5] + (firstFloor[n][5] - firstFloor[i][5]) * p
    local b = firstFloor[i][6] + (firstFloor[n][6] - firstFloor[i][6]) * p
    floorColColor[4] = r
    floorColColor[5] = g
    floorColColor[6] = b
    neonColors[1][4] = r
    neonColors[1][5] = g
    neonColors[1][6] = b
    neonColors[9][1] = r
    neonColors[9][2] = g
    neonColors[9][3] = b
    neonColors[2][4] = r
    neonColors[2][5] = g
    neonColors[2][6] = b
    neonColors[3][1] = r
    neonColors[3][2] = g
    neonColors[3][3] = b
    neonColors[4][4] = r
    neonColors[4][5] = g
    neonColors[4][6] = b
    for j = 1, #roomIds do
      local room = roomIds[j]
      local i = currentRoom + j
      local n = i + 1
      while i > #roomColors do
        i = i - #roomColors
      end
      while n > #roomColors do
        n = n - #roomColors
      end
      local col1 = roomColors[i]
      local col2 = roomColors[n]
      local r = col1[1] + (col2[1] - col1[1]) * p
      local g = col1[2] + (col2[2] - col1[2]) * p
      local b = col1[3] + (col2[3] - col1[3]) * p
      neonColors[room][1] = r
      neonColors[room][2] = g
      neonColors[room][3] = b
      local r = col1[4] + (col2[4] - col1[4]) * p
      local g = col1[5] + (col2[5] - col1[5]) * p
      local b = col1[6] + (col2[6] - col1[6]) * p
      neonColors[room][4] = r
      neonColors[room][5] = g
      neonColors[room][6] = b
    end
    drawNeons()
    if 1 <= p then
      switch = false
    end
  end
  local p = now % 6000 / 6000
  local p2 = now % 70000 / 70000
  dxSetRenderTarget(lcd, true)
  local lcdi = 10
  if lcdAnimation[1] == "casino" then
    local p = (getTickCount() - lcdAnimation[2]) / 1000
    if p < 1 then
      for j = -2, 2 do
        dxDrawImage(lcdX * p2 + lcdX / 2 * j, 0, lcdX / 2, lcdY, dynamicImage(lcdTexture[1][1], lcdTexture[1][2]))
      end
    elseif p > lcdi - 1 and lcdi >= p then
      for j = -2, 2 do
        dxDrawImage(lcdX * p2 + lcdX / 2 * j, 0, lcdX / 2, lcdY, dynamicImage(lcdTexture[1][1], lcdTexture[1][2]))
      end
      p = 1 - (p - (lcdi - 1))
    elseif lcdi < p then
      for j = -2, 2 do
        dxDrawImage(lcdX * p2 + lcdX / 2 * j, 0, lcdX / 2, lcdY, dynamicImage(lcdTexture[1][1], lcdTexture[1][2]))
      end
      lcdAnimation = {
        "transitionslot",
        getTickCount(),
        generateRandomSlot()
      }
      p = 0
    elseif 1 < p then
      p = 1
    end
    for j = -2, 2 do
      dxDrawImage(lcdX * p2 + lcdX / 2 * j, 0, lcdX / 2, lcdY, dynamicImage(lcdTexture[2][1], lcdTexture[2][2]), 0, 0, 0, tocolor(255, 255, 255, 255 * p))
    end
  elseif lcdAnimation[1] == "slot" then
    local p = (getTickCount() - lcdAnimation[2]) / 1000
    if p < 1 then
      for j = -2, 2 do
        dxDrawImage(lcdX * p2 + lcdX / 2 * j, 0, lcdX / 2, lcdY, dynamicImage(lcdTexture[1][1], lcdTexture[1][2]))
      end
    elseif p > lcdi - 1 and lcdi >= p then
      for j = -2, 2 do
        dxDrawImage(lcdX * p2 + lcdX / 2 * j, 0, lcdX / 2, lcdY, dynamicImage(lcdTexture[1][1], lcdTexture[1][2]))
      end
      p = 1 - (p - (lcdi - 1))
    elseif lcdi < p then
      for j = -2, 2 do
        dxDrawImage(lcdX * p2 + lcdX / 2 * j, 0, lcdX / 2, lcdY, dynamicImage(lcdTexture[1][1], lcdTexture[1][2]))
      end
      lcdAnimation = {
        "transition2",
        getTickCount()
      }
      p = 0
    elseif 1 < p then
      p = 1
    end
    for j = -2, 2 do
      dxDrawImage(lcdX * p2 + lcdX / 2 * j, 0, lcdX / 2, lcdY, dynamicImage(lcdTexture[3][1], lcdTexture[3][2]), 0, 0, 0, tocolor(255, 255, 255, 255 * p))
    end
  elseif lcdAnimation[1] == "roulette" then
    local p = (getTickCount() - lcdAnimation[2]) / 1000
    if p < 1 then
      for j = -2, 2 do
        dxDrawImage(lcdX * p2 + lcdX / 2 * j, 0, lcdX / 2, lcdY, dynamicImage(lcdTexture[1][1], lcdTexture[1][2]))
      end
      hp = getEasingValue(1 - p, "InQuad")
    elseif p > lcdi - 1 and lcdi >= p then
      for j = -2, 2 do
        dxDrawImage(lcdX * p2 + lcdX / 2 * j, 0, lcdX / 2, lcdY, dynamicImage(lcdTexture[1][1], lcdTexture[1][2]))
      end
      p = 1 - (p - (lcdi - 1))
      hp = 0 - getEasingValue(1 - p, "OutQuad")
    elseif lcdi < p then
      for j = -2, 2 do
        dxDrawImage(lcdX * p2 + lcdX / 2 * j, 0, lcdX / 2, lcdY, dynamicImage(lcdTexture[1][1], lcdTexture[1][2]))
      end
      lcdAnimation = {
        "transition3",
        getTickCount()
      }
      p = 0
    elseif 1 < p then
      p = 1
    end
    local p3 = (1 - p2) % 0.0625 / 0.0625
    for j = -2, 2 do
      dxDrawImage(lcdX * p2 + lcdX / 2 * j, 0, lcdX / 2, lcdY, dynamicImage(lcdTexture[5][1], lcdTexture[5][2]), 0, 0, 0, tocolor(255, 255, 255, 255 * p))
    end
    local x = lcdX * p3
    dxDrawImage(x, 0, lcdY, lcdY, dynamicImage(lcdTexture[13][1], lcdTexture[13][2]), 0, 0, 0, tocolor(255, 255, 255, 255 * p))
    local e = lcdX - lcdY
    if x > e then
      dxDrawImage(-lcdY + (x - e), 0, lcdY, lcdY, dynamicImage(lcdTexture[13][1], lcdTexture[13][2]), 0, 0, 0, tocolor(255, 255, 255, 255 * p))
    end
    for j = -2, 2 do
      dxDrawImage(lcdX * p2 + lcdX / 2 * j, 0, lcdX / 2, lcdY, dynamicImage(lcdTexture[6][1], lcdTexture[6][2]), 0, 0, 0, tocolor(255, 255, 255, 255 * p))
    end
  elseif lcdAnimation[1] == "bj" then
    local p = (getTickCount() - lcdAnimation[2]) / 1000
    if p < 1 then
      for j = -2, 2 do
        dxDrawImage(lcdX * p2 + lcdX / 2 * j, 0, lcdX / 2, lcdY, dynamicImage(lcdTexture[1][1], lcdTexture[1][2]))
      end
    elseif p > lcdi - 1 and lcdi >= p then
      for j = -2, 2 do
        dxDrawImage(lcdX * p2 + lcdX / 2 * j, 0, lcdX / 2, lcdY, dynamicImage(lcdTexture[1][1], lcdTexture[1][2]))
      end
      p = 1 - (p - (lcdi - 1))
    elseif lcdi < p then
      for j = -2, 2 do
        dxDrawImage(lcdX * p2 + lcdX / 2 * j, 0, lcdX / 2, lcdY, dynamicImage(lcdTexture[1][1], lcdTexture[1][2]))
      end
      lcdAnimation = {
        "transition6",
        getTickCount()
      }
      p = 0
    elseif 1 < p then
      p = 1
    end
    for j = -2, 2 do
      dxDrawImage(lcdX * p2 + lcdX / 2 * j, 0, lcdX / 2, lcdY, dynamicImage(lcdTexture[4][1], lcdTexture[4][2]), 0, 0, 0, tocolor(255, 255, 255, 255 * p))
    end
  elseif lcdAnimation[1] == "horsee" then
    local p = (getTickCount() - lcdAnimation[2]) / 1000
    local hp = 0
    if p < 1 then
      for j = -2, 2 do
        dxDrawImage(lcdX * p2 + lcdX / 2 * j, 0, lcdX / 2, lcdY, dynamicImage(lcdTexture[1][1], lcdTexture[1][2]))
      end
      hp = getEasingValue(1 - p, "InQuad")
    elseif p > lcdi - 1 and lcdi >= p then
      for j = -2, 2 do
        dxDrawImage(lcdX * p2 + lcdX / 2 * j, 0, lcdX / 2, lcdY, dynamicImage(lcdTexture[1][1], lcdTexture[1][2]))
      end
      p = 1 - (p - (lcdi - 1))
      hp = 0 - getEasingValue(1 - p, "OutQuad")
    elseif lcdi < p then
      for j = -2, 2 do
        dxDrawImage(lcdX * p2 + lcdX / 2 * j, 0, lcdX / 2, lcdY, dynamicImage(lcdTexture[1][1], lcdTexture[1][2]))
      end
      lcdAnimation = {
        "transition1",
        getTickCount()
      }
      p = 0
      hp = -1
    elseif 1 < p then
      p = 1
      hp = 0
    end
    for j = -2, 2 do
      dxDrawImage(lcdX * p2 + lcdX / 2 * j, 0, lcdX / 2, lcdY, dynamicImage(lcdTexture[11][1], lcdTexture[11][2]), 0, 0, 0, tocolor(255, 255, 255, 255 * p))
      dxDrawImageSection(lcdX * p2 + lcdX / 2 * j, 0, lcdX / 2, lcdY, 75 * hp, 0, 1600, 64, dynamicImage(lcdTexture[12][1], lcdTexture[12][2]), 0, 0, 0, tocolor(255, 255, 255, 255 * p))
    end
  elseif lcdAnimation[1] == "transitionslot" then
    local p = (getTickCount() - lcdAnimation[2]) / 3500
    local a = 1
    if p < 0.2 then
      a = p / 0.2
    end
    if 0.875 < p then
      a = 1 * (p - 0.875) / 0.2 % 1
      if 0.5 < a then
        a = 1
      else
        a = 0
      end
    end
    if 1.5 < p then
      a = a * (1 - (p - 1.5) / 0.25)
      if a < 0 then
        a = 0
      end
    end
    for j = -2, 2 do
      dxDrawImage(lcdX * p2 + lcdX / 2 * j, 0, lcdX / 2, lcdY, dynamicImage(lcdTexture[1][1], lcdTexture[1][2]))
      for k = -1, 1 do
        local n = 7 + k
        for l = 1, 10 do
          local ix, iy = 2, 2
          local y = lcdY / 2 - 25 + 55 * (l - 2)
          if l ~= n + 2 then
            ix = lcdAnimation[3][l][2 + k] - 1
            iy = math.floor(ix / 3)
            ix = ix - iy * 3
          end
          dxDrawImageSection(lcdX * p2 + lcdX / 2 * j + lcdX / 2 * 0.225 - 25 + 50 * k, y - math.min(55 * n, 550 * p), 50, 50, ix * 50, iy * 50, 50, 50, dynamicImage(lcdTexture[8][1], lcdTexture[8][2]), 0, 0, 0, tocolor(255, 255, 255, 255 * a))
          if l ~= n + 2 then
            ix = lcdAnimation[3][l][3 + k] - 1
            iy = math.floor(ix / 3)
            ix = ix - iy * 3
          end
          dxDrawImageSection(lcdX * p2 + lcdX / 2 * j + lcdX / 2 * 0.5 - 25 + 50 * k, y - math.min(55 * n, 550 * p), 50, 50, ix * 50, iy * 50, 50, 50, dynamicImage(lcdTexture[8][1], lcdTexture[8][2]), 0, 0, 0, tocolor(255, 255, 255, 255 * a))
          if l ~= n + 2 then
            ix = lcdAnimation[3][l][4 + k] - 1
            iy = math.floor(ix / 3)
            ix = ix - iy * 3
          end
          dxDrawImageSection(lcdX * p2 + lcdX / 2 * j + lcdX / 2 * 0.805 - 25 + 50 * k, y - math.min(55 * n, 550 * p), 50, 50, ix * 50, iy * 50, 50, 50, dynamicImage(lcdTexture[8][1], lcdTexture[8][2]), 0, 0, 0, tocolor(255, 255, 255, 255 * a))
        end
      end
    end
    if 1.75 < p then
      lcdAnimation = {
        "slot",
        getTickCount()
      }
    end
  elseif lcdAnimation[1] == "transition1" then
    local p = (getTickCount() - lcdAnimation[2]) / 4000
    if 1 < p then
      lcdAnimation = {
        "casino",
        getTickCount()
      }
      p = 1
    end
    for j = -2, 2 do
      dxDrawImage(lcdX * p2 + lcdX / 2 * j, 0, lcdX / 2, lcdY, dynamicImage(lcdTexture[1][1], lcdTexture[1][2]))
      dxDrawImage(lcdX * p2 + lcdX / 2 * j, -600 + (600 + lcdY) * p, lcdX / 2, 600, dynamicImage(lcdTexture[10][1], lcdTexture[10][2]))
    end
  elseif lcdAnimation[1] == "transition2" then
    local p = (getTickCount() - lcdAnimation[2]) / 4000
    if 1 < p then
      lcdAnimation = {
        "roulette",
        getTickCount()
      }
      p = 1
    end
    for j = -2, 2 do
      dxDrawImage(lcdX * p2 + lcdX / 2 * j, 0, lcdX / 2, lcdY, dynamicImage(lcdTexture[1][1], lcdTexture[1][2]))
      dxDrawImage(lcdX * p2 + lcdX / 2 * j, -600 + (600 + lcdY) * p, lcdX / 2, 600, dynamicImage(lcdTexture[7][1], lcdTexture[7][2]))
    end
  elseif lcdAnimation[1] == "transition3" then
    local p = (getTickCount() - lcdAnimation[2]) / 4000
    if 1 < p then
      lcdAnimation = {
        "bj",
        getTickCount()
      }
      p = 1
    end
    for j = -2, 2 do
      dxDrawImage(lcdX * p2 + lcdX / 2 * j, 0, lcdX / 2, lcdY, dynamicImage(lcdTexture[1][1], lcdTexture[1][2]))
      dxDrawImage(lcdX * p2 + lcdX / 2 * j, -600 + (600 + lcdY) * p, lcdX / 2, 600, dynamicImage(lcdTexture[9][1], lcdTexture[9][2]))
    end
  elseif lcdAnimation[1] == "transition6" then
    local p = (getTickCount() - lcdAnimation[2]) / 4000
    if 1 < p then
      lcdAnimation = {
        "horsee",
        getTickCount()
      }
      p = 1
    end
    for j = -2, 2 do
      dxDrawImage(lcdX * p2 + lcdX / 2 * j, 0, lcdX / 2, lcdY, dynamicImage(lcdTexture[1][1], lcdTexture[1][2]))
      dxDrawImage(lcdX * p2 + lcdX / 2 * j, -600 + (600 + lcdY) * p, lcdX / 2, 600, dynamicImage(lcdTexture[7][1], lcdTexture[7][2]))
    end
  end
  dxSetRenderTarget(neons2, true)
  dxDrawImage(-256 * p, 0, 512, 512, neons)
  dxSetRenderTarget()
end
function drawNeons()
  dxSetRenderTarget(neons, true)
  sightlangStaticImageUsed[0] = true
  if sightlangStaticImageToc[0] then
    processsightlangStaticImage[0]()
  end
  local neon = sightlangStaticImage[0]
  sightlangStaticImageUsed[1] = true
  if sightlangStaticImageToc[1] then
    processsightlangStaticImage[1]()
  end
  local neon2 = sightlangStaticImage[1]
  for i = 1, 14 do
    if #neonColors[i] == 6 then
      dxDrawImage(0, 32 * (i - 1), 256, 32, neon, 0, 0, 0, tocolor(neonColors[i][1], neonColors[i][2], neonColors[i][3]))
      dxDrawImage(256, 32 * (i - 1), 256, 32, neon, 0, 0, 0, tocolor(neonColors[i][1], neonColors[i][2], neonColors[i][3]))
      dxDrawImage(0, 32 * (i - 1), 256, 32, neon2, 0, 0, 0, tocolor(neonColors[i][4], neonColors[i][5], neonColors[i][6]))
      dxDrawImage(256, 32 * (i - 1), 256, 32, neon2, 0, 0, 0, tocolor(neonColors[i][4], neonColors[i][5], neonColors[i][6]))
    else
      dxDrawImage(0, 32 * (i - 1), 256, 32, neon, 0, 0, 0, tocolor(neonColors[i][1], neonColors[i][2], neonColors[i][3]))
      dxDrawImage(256, 32 * (i - 1), 256, 32, neon, 0, 0, 0, tocolor(neonColors[i][1], neonColors[i][2], neonColors[i][3]))
    end
  end
  dxSetRenderTarget()
end
local bubbles = {}
function drawFish(t, x, y, z, s, r)
  dxDrawMaterialLine3D(x, y, z + s, x, y, z - s, dynamicImage(fishTextures[t]), s * 2, tocolor(255, 255, 255), x + math.cos(r), y + math.sin(r), z + s / 2)
end
function drawBubble(bubble, x, y, z, s)
  dxDrawMaterialLine3D(x, y, z + s, x, y, z - s, bubble, s * 2)
end
function spawnBubble(x, y, z, mz)
  local r = math.rad(math.random(0, 360))
  local rad = math.random(100, 200) / 100
  local dat = {
    x,
    y,
    z,
    math.random(250, 500) / 10000,
    math.random(100, 200) / 100,
    mz,
    math.cos(r) * rad,
    math.sin(r) * rad,
    0
  }
  table.insert(bubbles, dat)
end
function getZForAqua(x)
  if 1071.45 < x then
    return 38.5 + (x - 1071.45) / 6.0499999999999545 * -4.5
  else
    return 38.5
  end
end
function rand2(a, b)
  local min = math.min(a, b)
  local max = math.max(a, b)
  return math.random(min * 1000, max * 1000) / 1000
end
function getRandomFishPosition()
  local x = rand2(1064.75, 1076.32458)
  local y = rand2(-1476.93823, -1474.88562)
  local z = 10000 + rand2(34.75, getZForAqua(x) - 0.25)
  return x, y, z
end
local fishes = {}
local toSpawn = {
  {
    1,
    math.random(100, 200) / 1000
  },
  {
    1,
    math.random(100, 200) / 1000
  },
  {
    1,
    math.random(100, 200) / 1000
  },
  {
    1,
    math.random(100, 200) / 1000
  },
  {
    1,
    math.random(100, 200) / 1000
  },
  {
    1,
    math.random(100, 200) / 1000
  },
  {
    1,
    math.random(100, 200) / 1000
  },
  {
    1,
    math.random(100, 200) / 1000
  },
  {
    1,
    math.random(100, 200) / 1000
  },
  {
    1,
    math.random(100, 200) / 1000
  },
  {
    2,
    math.random(100, 200) / 1000
  },
  {
    2,
    math.random(100, 200) / 1000
  },
  {
    2,
    math.random(100, 200) / 1000
  },
  {
    2,
    math.random(100, 200) / 1000
  },
  {
    2,
    math.random(100, 200) / 1000
  },
  {
    2,
    math.random(100, 200) / 1000
  },
  {
    2,
    math.random(100, 200) / 1000
  },
  {
    2,
    math.random(100, 200) / 1000
  },
  {
    2,
    math.random(100, 200) / 1000
  },
  {
    3,
    math.random(150, 300) / 1000
  },
  {
    3,
    math.random(150, 300) / 1000
  },
  {
    3,
    math.random(150, 300) / 1000
  },
  {
    3,
    math.random(150, 300) / 1000
  },
  {
    3,
    math.random(150, 300) / 1000
  },
  {
    3,
    math.random(150, 300) / 1000
  },
  {
    4,
    math.random(200, 400) / 1000
  },
  {
    4,
    math.random(200, 400) / 1000
  },
  {
    4,
    math.random(200, 400) / 1000
  },
  {
    4,
    math.random(200, 400) / 1000
  },
  {
    4,
    math.random(200, 400) / 1000
  },
  {
    4,
    math.random(200, 400) / 1000
  },
  {
    5,
    math.random(200, 250) / 1000
  },
  {
    5,
    math.random(200, 250) / 1000
  },
  {
    5,
    math.random(200, 250) / 1000
  },
  {
    5,
    math.random(200, 250) / 1000
  }
}
for i = 1, #toSpawn do
  local x, y, z = getRandomFishPosition()
  local x2, y2, z2 = getRandomFishPosition()
  table.insert(fishes, {
    toSpawn[i][1],
    x,
    y,
    z,
    x2,
    y2,
    z2,
    math.random(25, 75) / 100 * 0.4,
    toSpawn[i][2]
  })
end
function casinoRender(delta)
  local h = 5
  sightlangStaticImageUsed[2] = true
  if sightlangStaticImageToc[2] then
    processsightlangStaticImage[2]()
  end
  dxDrawMaterialLine3D(1071, -1477.5, 10034 + h, 1071, -1477.5, 10034, sightlangStaticImage[2], 2.66 * h, tocolor(255, 255, 255, 110), 1071, -1482.5, 34.75 + h / 2)
end
local lightBase = {
  1100,
  -1500,
  10040
}
local lights = {
  {
    {
      {
        -7.1141,
        26.331,
        -6.16029
      },
      {
        -7.29374,
        26.4346,
        -6.24864
      }
    },
    {
      {
        -7.16282,
        26.0547,
        -6.16029
      },
      {
        -7.36709,
        26.0186,
        -6.24864
      }
    },
    {
      {
        -7.02254,
        25.8117,
        -6.16029
      },
      {
        -7.15587,
        25.6528,
        -6.24864
      }
    }
  },
  {
    {
      {
        -6.75891,
        25.7157,
        -6.16029
      },
      {
        -6.75891,
        25.5083,
        -6.24864
      }
    },
    {
      {
        -6.49529,
        25.8117,
        -6.16029
      },
      {
        -6.36195,
        25.6528,
        -6.24864
      }
    },
    {
      {
        -6.35502,
        26.0547,
        -6.16029
      },
      {
        -6.15074,
        26.0186,
        -6.24864
      }
    }
  },
  {
    {
      {
        -6.40373,
        26.331,
        -6.16029
      },
      {
        -6.2241,
        26.4346,
        -6.24864
      }
    },
    {
      {
        -6.61864,
        26.5113,
        -6.16029
      },
      {
        -6.5477,
        26.7062,
        -6.24864
      }
    },
    {
      {
        -6.89919,
        26.5113,
        -6.16029
      },
      {
        -6.97013,
        26.7062,
        -6.24864
      }
    }
  },
  {
    {
      {
        -5.52622,
        18.2229,
        -6.15878
      },
      {
        -5.7305,
        18.1869,
        -6.24713
      }
    },
    {
      {
        -5.38595,
        17.9799,
        -6.15878
      },
      {
        -5.51928,
        17.821,
        -6.24713
      }
    },
    {
      {
        -5.12232,
        17.884,
        -6.15878
      },
      {
        -5.12232,
        17.6765,
        -6.24713
      }
    }
  },
  {
    {
      {
        -4.85869,
        17.9799,
        -6.15878
      },
      {
        -4.72536,
        17.821,
        -6.24713
      }
    },
    {
      {
        -4.71842,
        18.2229,
        -6.15878
      },
      {
        -4.51414,
        18.1869,
        -6.24713
      }
    },
    {
      {
        -4.76714,
        18.4992,
        -6.15878
      },
      {
        -4.5875,
        18.6029,
        -6.15878
      }
    }
  },
  {
    {
      {
        -4.98205,
        18.6795,
        -6.15878
      },
      {
        -4.91111,
        18.8744,
        -6.24713
      }
    },
    {
      {
        -5.2626,
        18.6795,
        -6.15878
      },
      {
        -5.33354,
        18.8744,
        -6.24713
      }
    },
    {
      {
        -5.47751,
        18.4992,
        -6.15878
      },
      {
        -5.65714,
        18.6029,
        -6.24713
      }
    }
  },
  {
    {
      {
        -2.27785,
        11.806,
        -6.15133
      },
      {
        -2.48213,
        11.77,
        -6.23968
      }
    },
    {
      {
        -2.13758,
        11.563,
        -6.15133
      },
      {
        -2.27091,
        11.4042,
        -6.23968
      }
    },
    {
      {
        -1.87395,
        11.4671,
        -6.15133
      },
      {
        -1.87395,
        11.2597,
        -6.23968
      }
    }
  },
  {
    {
      {
        -1.61033,
        11.5631,
        -6.15133
      },
      {
        -1.47699,
        11.4042,
        -6.23968
      }
    },
    {
      {
        -1.47006,
        11.8061,
        -6.15133
      },
      {
        -1.26578,
        11.77,
        -6.23968
      }
    },
    {
      {
        -1.51877,
        12.0823,
        -6.15133
      },
      {
        -1.33913,
        12.186,
        -6.23968
      }
    }
  },
  {
    {
      {
        -1.73368,
        12.2626,
        -6.15133
      },
      {
        -1.66274,
        12.4576,
        -6.23968
      }
    },
    {
      {
        -2.01423,
        12.2626,
        -6.15133
      },
      {
        -2.08518,
        12.4576,
        -6.23968
      }
    },
    {
      {
        -2.22914,
        12.0823,
        -6.15133
      },
      {
        -2.40878,
        12.186,
        -6.23968
      }
    }
  },
  {
    {
      {
        11.2921,
        -2.62894,
        -6.14924
      },
      {
        11.0878,
        -2.66496,
        -6.23759
      }
    },
    {
      {
        11.4324,
        -2.8719,
        -6.14924
      },
      {
        11.299,
        -3.0308,
        -6.23759
      }
    },
    {
      {
        11.696,
        -2.96785,
        -6.14924
      },
      {
        11.696,
        -3.17528,
        -6.23759
      }
    }
  },
  {
    {
      {
        11.9596,
        -2.8719,
        -6.14924
      },
      {
        12.093,
        -3.0308,
        -6.23759
      }
    },
    {
      {
        12.0999,
        -2.62894,
        -6.14924
      },
      {
        12.3042,
        -2.66496,
        -6.23759
      }
    },
    {
      {
        12.0512,
        -2.35265,
        -6.14924
      },
      {
        12.2308,
        -2.24894,
        -6.23759
      }
    }
  },
  {
    {
      {
        11.8363,
        -2.17232,
        -6.14924
      },
      {
        11.9072,
        -1.9774,
        -6.23759
      }
    },
    {
      {
        11.5558,
        -2.17232,
        -6.14924
      },
      {
        11.4848,
        -1.9774,
        -6.23759
      }
    },
    {
      {
        11.3409,
        -2.35265,
        -6.14924
      },
      {
        11.1612,
        -2.24894,
        -6.23759
      }
    }
  },
  {
    {
      {
        17.2588,
        -5.76651,
        -6.14924
      },
      {
        17.0545,
        -5.80253,
        -6.23759
      }
    },
    {
      {
        17.3991,
        -6.00947,
        -6.14924
      },
      {
        17.2657,
        -6.16837,
        -6.23759
      }
    },
    {
      {
        17.6627,
        -6.10542,
        -6.14924
      },
      {
        17.6627,
        -6.31285,
        -6.23759
      }
    }
  },
  {
    {
      {
        17.9263,
        -6.00947,
        -6.14924
      },
      {
        18.0597,
        -6.16837,
        -6.23759
      }
    },
    {
      {
        18.0666,
        -5.76651,
        -6.14924
      },
      {
        18.2709,
        -5.80253,
        -6.23759
      }
    },
    {
      {
        18.0179,
        -5.49023,
        -6.14924
      },
      {
        18.1975,
        -5.38651,
        -6.23759
      }
    }
  },
  {
    {
      {
        17.803,
        -5.3099,
        -6.14924
      },
      {
        17.8739,
        -5.11498,
        -6.23759
      }
    },
    {
      {
        17.5224,
        -5.3099,
        -6.14924
      },
      {
        17.4515,
        -5.11498,
        -6.23759
      }
    },
    {
      {
        17.3075,
        -5.49023,
        -6.14924
      },
      {
        17.1279,
        -5.38651,
        -6.23759
      }
    }
  },
  {
    {
      {
        24.6709,
        -7.28022,
        -6.15057
      },
      {
        24.4666,
        -7.31624,
        -6.23892
      }
    },
    {
      {
        24.8112,
        -7.52318,
        -6.15057
      },
      {
        24.6778,
        -7.68208,
        -6.23892
      }
    },
    {
      {
        25.0748,
        -7.61913,
        -6.15057
      },
      {
        25.0748,
        -7.82656,
        -6.23892
      }
    }
  },
  {
    {
      {
        25.3384,
        -7.52318,
        -6.15057
      },
      {
        25.4718,
        -7.68208,
        -6.23892
      }
    },
    {
      {
        25.4787,
        -7.28022,
        -6.15057
      },
      {
        25.683,
        -7.31624,
        -6.23892
      }
    },
    {
      {
        25.43,
        -7.00393,
        -6.15057
      },
      {
        25.6096,
        -6.90022,
        -6.23892
      }
    }
  },
  {
    {
      {
        25.2151,
        -6.8236,
        -6.15057
      },
      {
        25.286,
        -6.62868,
        -6.23892
      }
    },
    {
      {
        24.9345,
        -6.8236,
        -6.15057
      },
      {
        24.8636,
        -6.62868,
        -6.23892
      }
    },
    {
      {
        24.7196,
        -7.00393,
        -6.15057
      },
      {
        24.54,
        -6.90022,
        -6.23892
      }
    }
  },
  {
    {
      {
        -0.116722,
        -10.3317,
        -6.16924
      },
      {
        0.062914,
        -10.228,
        -6.25759
      }
    },
    {
      {
        -0.331634,
        -10.1514,
        -6.16924
      },
      {
        -0.26069,
        -9.95645,
        -6.25759
      }
    },
    {
      {
        -0.61218,
        -10.1514,
        -6.16924
      },
      {
        -0.683126,
        -9.95644,
        -6.25759
      }
    }
  },
  {
    {
      {
        -0.827091,
        -10.3317,
        -6.16924
      },
      {
        -1.00673,
        -10.228,
        -6.25759
      }
    },
    {
      {
        -0.875808,
        -10.608,
        -6.16924
      },
      {
        -1.08008,
        -10.644,
        -6.25759
      }
    },
    {
      {
        -0.735534,
        -10.8509,
        -6.16924
      },
      {
        -0.868865,
        -11.0098,
        -6.25759
      }
    }
  },
  {
    {
      {
        -0.471906,
        -10.9469,
        -6.16924
      },
      {
        -0.471908,
        -11.1543,
        -6.25759
      }
    },
    {
      {
        -0.20828,
        -10.851,
        -6.16924
      },
      {
        -0.074947,
        -11.0098,
        -6.25759
      }
    },
    {
      {
        -0.068006,
        -10.608,
        -6.16924
      },
      {
        0.136271,
        -10.644,
        -6.25759
      }
    }
  },
  {
    {
      {
        -3.18647,
        -22.9572,
        -6.16923
      },
      {
        -2.98219,
        -22.9932,
        -6.25758
      }
    },
    {
      {
        -3.23519,
        -22.6809,
        -6.16923
      },
      {
        -3.05554,
        -22.5772,
        -6.25758
      }
    },
    {
      {
        -3.4501,
        -22.5006,
        -6.16923
      },
      {
        -3.37915,
        -22.3057,
        -6.25758
      }
    }
  },
  {
    {
      {
        -3.73064,
        -22.5006,
        -6.16923
      },
      {
        -3.80159,
        -22.3057,
        -6.25758
      }
    },
    {
      {
        -3.94555,
        -22.6809,
        -6.16923
      },
      {
        -4.12519,
        -22.5772,
        -6.25758
      }
    },
    {
      {
        -3.99427,
        -22.9572,
        -6.16923
      },
      {
        -4.19854,
        -22.9932,
        -6.25758
      }
    }
  },
  {
    {
      {
        -3.85399,
        -23.2002,
        -6.16923
      },
      {
        -3.98732,
        -23.3591,
        -6.25758
      }
    },
    {
      {
        -3.59036,
        -23.2961,
        -6.16923
      },
      {
        -3.59036,
        -23.5036,
        -6.25758
      }
    },
    {
      {
        -3.32674,
        -23.2001,
        -6.16923
      },
      {
        -3.19341,
        -23.3591,
        -6.25758
      }
    }
  },
  {
    {
      {
        -16.2749,
        -26.6929,
        -6.16923
      },
      {
        -16.0707,
        -26.7289,
        -6.25758
      }
    },
    {
      {
        -16.3236,
        -26.4166,
        -6.16923
      },
      {
        -16.144,
        -26.3129,
        -6.25758
      }
    },
    {
      {
        -16.5386,
        -26.2363,
        -6.16923
      },
      {
        -16.4676,
        -26.0413,
        -6.25758
      }
    }
  },
  {
    {
      {
        -16.8191,
        -26.2363,
        -6.16923
      },
      {
        -16.8901,
        -26.0413,
        -6.25758
      }
    },
    {
      {
        -17.034,
        -26.4166,
        -6.16923
      },
      {
        -17.2137,
        -26.3129,
        -6.25758
      }
    },
    {
      {
        -17.0827,
        -26.6929,
        -6.16923
      },
      {
        -17.287,
        -26.7289,
        -6.25758
      }
    }
  },
  {
    {
      {
        -16.9425,
        -26.9358,
        -6.16923
      },
      {
        -17.0758,
        -27.0947,
        -6.25758
      }
    },
    {
      {
        -16.6789,
        -27.0318,
        -6.16923
      },
      {
        -16.6788,
        -27.2392,
        -6.25758
      }
    },
    {
      {
        -16.4152,
        -26.9359,
        -6.16923
      },
      {
        -16.2819,
        -27.0947,
        -6.25758
      }
    }
  },
  {
    {
      {
        -25.7434,
        -17.0498,
        -6.16923
      },
      {
        -25.6101,
        -17.2087,
        -6.25758
      }
    },
    {
      {
        -25.6031,
        -16.8068,
        -6.16923
      },
      {
        -25.3989,
        -16.8429,
        -6.25758
      }
    },
    {
      {
        -25.6519,
        -16.5305,
        -6.16923
      },
      {
        -25.4723,
        -16.4269,
        -6.25758
      }
    }
  },
  {
    {
      {
        -25.8668,
        -16.3502,
        -6.16923
      },
      {
        -25.7959,
        -16.1553,
        -6.25758
      }
    },
    {
      {
        -26.1473,
        -16.3502,
        -6.16923
      },
      {
        -26.2183,
        -16.1553,
        -6.25758
      }
    },
    {
      {
        -26.3622,
        -16.5305,
        -6.16923
      },
      {
        -26.5419,
        -16.4268,
        -6.25758
      }
    }
  },
  {
    {
      {
        -26.4109,
        -16.8068,
        -6.16923
      },
      {
        -26.6152,
        -16.8428,
        -6.25758
      }
    },
    {
      {
        -26.2707,
        -17.0498,
        -6.16923
      },
      {
        -26.404,
        -17.2087,
        -6.25758
      }
    },
    {
      {
        -26.0071,
        -17.1458,
        -6.16923
      },
      {
        -26.0071,
        -17.3532,
        -6.25758
      }
    }
  },
  {
    {
      {
        -22.152,
        -4.47904,
        -6.16929
      },
      {
        -21.9724,
        -4.37533,
        -6.25764
      }
    },
    {
      {
        -22.3669,
        -4.29871,
        -6.16929
      },
      {
        -22.296,
        -4.10379,
        -6.25764
      }
    },
    {
      {
        -22.6475,
        -4.29871,
        -6.16929
      },
      {
        -22.7184,
        -4.10379,
        -6.25764
      }
    }
  },
  {
    {
      {
        -22.8624,
        -4.47904,
        -6.16929
      },
      {
        -23.042,
        -4.37533,
        -6.25764
      }
    },
    {
      {
        -22.9111,
        -4.75533,
        -6.16929
      },
      {
        -23.1154,
        -4.79135,
        -6.25764
      }
    },
    {
      {
        -22.7708,
        -4.99829,
        -6.16929
      },
      {
        -22.9042,
        -5.15719,
        -6.25764
      }
    }
  },
  {
    {
      {
        -22.5072,
        -5.09424,
        -6.16929
      },
      {
        -22.5072,
        -5.30167,
        -6.25764
      }
    },
    {
      {
        -22.2436,
        -4.99829,
        -6.16929
      },
      {
        -22.1102,
        -5.15719,
        -6.25764
      }
    },
    {
      {
        -22.1033,
        -4.75533,
        -6.16929
      },
      {
        -21.899,
        -4.79135,
        -6.25764
      }
    }
  },
  {
    {
      {
        -9.92168,
        -1.39261,
        -6.16923
      },
      {
        -9.78835,
        -1.55151,
        -6.25758
      }
    },
    {
      {
        -9.78141,
        -1.14965,
        -6.16923
      },
      {
        -9.57713,
        -1.18567,
        -6.25758
      }
    },
    {
      {
        -9.83012,
        -0.873362,
        -6.16923
      },
      {
        -9.65048,
        -0.769648,
        -6.25758
      }
    }
  },
  {
    {
      {
        -10.045,
        -0.693029,
        -6.16923
      },
      {
        -9.97409,
        -0.49811,
        -6.25758
      }
    },
    {
      {
        -10.3256,
        -0.693029,
        -6.16923
      },
      {
        -10.3965,
        -0.49811,
        -6.25758
      }
    },
    {
      {
        -10.5405,
        -0.873361,
        -6.16923
      },
      {
        -10.7201,
        -0.769647,
        -6.25758
      }
    }
  },
  {
    {
      {
        -10.5892,
        -1.14965,
        -6.16923
      },
      {
        -10.7935,
        -1.18566,
        -6.25758
      }
    },
    {
      {
        -10.4489,
        -1.39261,
        -6.16923
      },
      {
        -10.5823,
        -1.5515,
        -6.25758
      }
    },
    {
      {
        -10.1853,
        -1.48856,
        -6.16923
      },
      {
        -10.1853,
        -1.69599,
        -6.25758
      }
    }
  }
}
for i = 1, #lights do
  for j = 1, 3 do
    lights[i][j][1][1] = lights[i][j][1][1] + (lights[i][j][2][1] - lights[i][j][1][1]) * 0.1
    lights[i][j][1][2] = lights[i][j][1][2] + (lights[i][j][2][2] - lights[i][j][1][2]) * 0.1
    lights[i][j][1][3] = lights[i][j][1][3] + (lights[i][j][2][3] - lights[i][j][1][3]) * 0.1
  end
end
local timeDiff = {
  4250,
  4250,
  4250,
  2250,
  2250,
  2250,
  250,
  250,
  250,
  250,
  250,
  250,
  2250,
  2250,
  2250,
  4250,
  4250,
  4250,
  0,
  0,
  0,
  500,
  500,
  500,
  1000,
  1000,
  1000,
  1500,
  1500,
  1500,
  2000,
  2000,
  2000,
  2500,
  2500,
  2500
}
function casinoPreRender(delta)
  setTime(12, 0)
  setWeather(1)
  sightlangStaticImageUsed[3] = true
  if sightlangStaticImageToc[3] then
    processsightlangStaticImage[3]()
  end
  local admiral_lights = sightlangStaticImage[3]
  for i = 1, #lights do
    local now = getTickCount()
    if timeDiff[i] then
      now = now - timeDiff[i]
    end
    local p = now % 6000 / 6000
    p = p * 2
    if 1 < p then
      p = 2 - p
    end
    local r = floorColColor[1] + (floorColColor[4] - floorColColor[1]) * p
    local g = floorColColor[2] + (floorColColor[5] - floorColColor[2]) * p
    local b = floorColColor[3] + (floorColColor[6] - floorColColor[3]) * p
    local col = tocolor(r, g, b)
    dxDrawMaterialSectionLine3D(lightBase[1] + lights[i][1][1][1], lightBase[2] + lights[i][1][1][2], lightBase[3] + lights[i][1][1][3] + 3, lightBase[1] + lights[i][1][1][1], lightBase[2] + lights[i][1][1][2], lightBase[3] + lights[i][1][1][3], 0, 0, 22, 132, admiral_lights, 0.31373585327000003, col, lightBase[1] + lights[i][1][2][1], lightBase[2] + lights[i][1][2][2], lightBase[3] + lights[i][1][2][3] + 1.5)
    dxDrawMaterialSectionLine3D(lightBase[1] + lights[i][2][1][1], lightBase[2] + lights[i][2][1][2], lightBase[3] + lights[i][2][1][3] + 3, lightBase[1] + lights[i][2][1][1], lightBase[2] + lights[i][2][1][2], lightBase[3] + lights[i][2][1][3], 22, 0, 22, 132, admiral_lights, 0.31373585327000003, col, lightBase[1] + lights[i][2][2][1], lightBase[2] + lights[i][2][2][2], lightBase[3] + lights[i][2][2][3] + 1.5)
    dxDrawMaterialSectionLine3D(lightBase[1] + lights[i][3][1][1], lightBase[2] + lights[i][3][1][2], lightBase[3] + lights[i][3][1][3] + 3, lightBase[1] + lights[i][3][1][1], lightBase[2] + lights[i][3][1][2], lightBase[3] + lights[i][3][1][3], 44, 0, 22, 132, admiral_lights, 0.31373585327000003, col, lightBase[1] + lights[i][3][2][1], lightBase[2] + lights[i][3][2][2], lightBase[3] + lights[i][3][2][3] + 1.5)
  end
  for i = 1, #fishes do
    local spd = fishes[i][8] * delta / 1000
    if fishes[i][2] < fishes[i][5] then
      fishes[i][2] = fishes[i][2] + spd
      if fishes[i][2] > fishes[i][5] then
        fishes[i][2] = fishes[i][5]
      end
    elseif fishes[i][2] > fishes[i][5] then
      fishes[i][2] = fishes[i][2] - spd
      if fishes[i][2] < fishes[i][5] then
        fishes[i][2] = fishes[i][5]
      end
    end
    if fishes[i][3] < fishes[i][6] then
      fishes[i][3] = fishes[i][3] + spd
      if fishes[i][3] > fishes[i][6] then
        fishes[i][3] = fishes[i][6]
      end
    elseif fishes[i][3] > fishes[i][6] then
      fishes[i][3] = fishes[i][3] - spd
      if fishes[i][3] < fishes[i][6] then
        fishes[i][3] = fishes[i][6]
      end
    end
    if fishes[i][4] < fishes[i][7] then
      fishes[i][4] = fishes[i][4] + spd
      if fishes[i][4] > fishes[i][7] then
        fishes[i][4] = fishes[i][7]
      end
    elseif fishes[i][4] > fishes[i][7] then
      fishes[i][4] = fishes[i][4] - spd
      if fishes[i][4] < fishes[i][7] then
        fishes[i][4] = fishes[i][7]
      end
    end
    local d = getDistanceBetweenPoints3D(fishes[i][2], fishes[i][3], fishes[i][4], fishes[i][5], fishes[i][6], fishes[i][7])
    if d < 1 then
      fishes[i][5], fishes[i][6], fishes[i][7] = getRandomFishPosition()
      fishes[i][8] = math.random(50, 75) / 100 * 0.4
    end
    local r = math.atan2(fishes[i][6] - fishes[i][3], fishes[i][5] - fishes[i][2])
    drawFish(fishes[i][1], fishes[i][2], fishes[i][3], fishes[i][4], fishes[i][9], r - math.pi / 2)
  end
  local px, py, pz = getElementPosition(localPlayer)
  for i = 1, #bubbleDispensers do
    local x, y, z = bubbleDispensers[i][1], bubbleDispensers[i][2], bubbleDispensers[i][3]
    bubbleDispensers[i][4] = bubbleDispensers[i][4] - delta
    if 0 >= bubbleDispensers[i][4] then
      bubbleDispensers[i][4] = math.random(150, 400)
      for j = 1, math.random(1, bubbleDispensers[i][5]) do
        spawnBubble(x, y, z, bubbleDispensers[i][6])
      end
    end
  end
  sightlangStaticImageUsed[4] = true
  if sightlangStaticImageToc[4] then
    processsightlangStaticImage[4]()
  end
  local bubble = sightlangStaticImage[4]
  for i = #bubbles, 1, -1 do
    bubbles[i][3] = bubbles[i][3] + bubbles[i][5] * delta / 1000
    if 1 > bubbles[i][9] then
      bubbles[i][9] = bubbles[i][9] + 0.2 * delta / 1000
      if 1 < bubbles[i][9] then
        bubbles[i][9] = 1
      end
    end
    if bubbles[i][3] > bubbles[i][6] then
      table.remove(bubbles, i)
    else
      drawBubble(bubble, bubbles[i][1] + bubbles[i][7] * bubbles[i][9], bubbles[i][2] + bubbles[i][8] * bubbles[i][9], bubbles[i][3], bubbles[i][4])
    end
  end
end
local casinoCreated = false
addEvent("syncCasinoColors", true)
addEventHandler("syncCasinoColors", getRootElement(), function(fc, r)
  currentFirstColor = fc
  currentRoom = r
  switch = getTickCount()
end)
function createCasino()
  if not casinoCreated then
    casinoCreated = true
    triggerServerEvent("syncCasinoColors", localPlayer)
    neons = dxCreateRenderTarget(512, 512, true)
    neons2 = dxCreateRenderTarget(256, 512, true)
    lcd = dxCreateRenderTarget(lcdX, lcdY)
    textureShader = dxCreateShader(textureChanger)
    if textureShader then
      dxSetShaderValue(textureShader, "gTexture", neons2)
      engineApplyShaderToWorldTexture(textureShader, "admiral_neon")
    end
    textureShader2 = dxCreateShader(textureChanger)
    if textureShader2 then
      dxSetShaderValue(textureShader2, "gTexture", lcd)
      engineApplyShaderToWorldTexture(textureShader2, "admiral_led")
    end
    addEventHandler("onClientPreRender", getRootElement(), casinoPreRender)
    addEventHandler("onClientRender", getRootElement(), casinoRender)
    addEventHandler("onClientRestore", getRootElement(), drawNeons)
    addEventHandler("onClientRender", getRootElement(), drawNeonsFinal)
    drawNeons()
  end
end
function destroyCasino()
  if casinoCreated then
    casinoCreated = false
    sightexports.sWeather:resetWeather()
    if isElement(neons) then
      destroyElement(neons)
    end
    neons = false
    if isElement(neons2) then
      destroyElement(neons2)
    end
    neons2 = false
    if isElement(lcd) then
      destroyElement(lcd)
    end
    lcd = false
    if isElement(textureShader) then
      destroyElement(textureShader)
    end
    textureShader = false
    if isElement(textureShader2) then
      destroyElement(textureShader2)
    end
    textureShader2 = false
    removeEventHandler("onClientPreRender", getRootElement(), casinoPreRender)
    removeEventHandler("onClientRender", getRootElement(), casinoRender)
    removeEventHandler("onClientRestore", getRootElement(), drawNeons)
    removeEventHandler("onClientRender", getRootElement(), drawNeonsFinal)
  end
end
addEventHandler("requestCCTVSyncZonesClient", getRootElement(), function()
  sightexports.sCctv:registerSyncZone("Admiral Casino", syncZone)
end)
function waitForCCTV()
  sightexports.sCctv:registerSyncZone("Admiral Casino", syncZone)
end
addEventHandler("onClientElementDimensionChange", localPlayer, function(old, new)
  if new == 3 and sightexports.sCctv:isPlayerWithinColShape(syncZone) then
    createCasino()
  else
    destroyCasino()
  end
end)
addEventHandler("onLocalPlayerCCTVColShapeHit", syncZone, function()
  createCasino()
end)
addEventHandler("onLocalPlayerCCTVColShapeLeave", syncZone, function()
  destroyCasino()
end)
local screenX, screenY = guiGetScreenSize()
local sscNPCs = {
  {
    11,
    1050.88671875,
    -1508.2998046875,
    10034.756286621094,
    346.26412963867,
    10,
    3
  },
  {
    189,
    1052.56640625,
    -1508.810546875,
    10034.75,
    332.16296386719,
    10,
    3
  },
  {
    194,
    1053.8583984375,
    -1509.8994140625,
    10034.756286621094,
    307.09729003906,
    10,
    3
  },
  {
    171,
    1114.576171875,
    -1517.490234375,
    10041.461051940918,
    85.878662109375,
    10,
    3
  },
  {
    171,
    1938.943359375,
    -2156.359375,
    15425.518554688,
    180,
    1,
    23761
  },
  {
    172,
    1938.943359375,
    -2156.359375,
    15425.518554688,
    180,
    1,
    23764
  },
  {
    11,
    1953.7998046875,
    1017.794921875,
    992.46875,
    270,
    10,
    17282
  },
  {
    194,
    1953.7998046875,
    1017.794921875,
    992.46875,
    270,
    10,
    23763
  },
  {
    194,
    501.8505859375,
    -18.0703125,
    1000.671875,
    90,
    17,
    123
  }
}
local sscNPCElements = {}
for i = 1, #sscNPCs do
  local npc = createPed(sscNPCs[i][1], sscNPCs[i][2], sscNPCs[i][3], sscNPCs[i][4], sscNPCs[i][5])
  setElementInterior(npc, sscNPCs[i][6])
  setElementDimension(npc, sscNPCs[i][7])
  setElementFrozen(npc, true)
  setElementData(npc, "invulnerable", true)
  setElementData(npc, "visibleName", "Pénztáros")
  setElementData(npc, "pedNameType", "SSC")
  sscNPCElements[npc] = i
end
local currentSSCPed = false
addEventHandler("onClientClick", getRootElement(), function(button, state, absoluteX, absoluteY, worldX, worldY, worldZ, clickedElement)
  if state == "down" and not currentSSCPed then
    local i = sscNPCElements[clickedElement]
    if i then
      local x, y, z = getElementPosition(localPlayer)
      if 3 > getDistanceBetweenPoints3D(x, y, z, sscNPCs[i][2], sscNPCs[i][3], sscNPCs[i][4]) then
        currentSSCPed = clickedElement
        createSSCWindow()
      end
    end
  end
end, true, "high+9999999999")
local window = false
local amountBox = false
local amountSlider = false
local sscLabel = false
local buy = true
function deleteSSCWindow()
  amountBox = false
  amountSlider = false
  sscLabel = false
  if window then
    local x, y = sightexports.sGui:getGuiPosition(window)
    sightexports.sGui:deleteGuiElement(window)
    window = false
    return x, y
  end
end
addEvent("switchSSCWindowBuy", true)
addEventHandler("switchSSCWindowBuy", getRootElement(), function()
  buy = true
  createSSCWindow()
end)
addEvent("switchSSCWindowSell", true)
addEventHandler("switchSSCWindowSell", getRootElement(), function()
  buy = false
  createSSCWindow()
end)
function formatSSCLabel()
  if buy then
    sightexports.sGui:setLabelText(sscLabel, "[color=sightyellow]" .. sightexports.sGui:thousandsStepper(sscAmount) .. " SSC\n#ffffffFizetendő: [color=sightgreen]" .. sightexports.sGui:thousandsStepper(sscAmount * 5) .. " $")
  else
    local tax = math.ceil(sscAmount * 5 * 0.1)
    sightexports.sGui:setLabelText(sscLabel, "[color=sightyellow]" .. sightexports.sGui:thousandsStepper(sscAmount) .. " SSC\n#ffffffAdó: [color=sightgreen]" .. sightexports.sGui:thousandsStepper(tax) .. " $\n#ffffffVégösszeg: [color=sightgreen]" .. sightexports.sGui:thousandsStepper(sscAmount * 5 - tax) .. " $")
  end
end
addEvent("changeSSCSlider", false)
addEventHandler("changeSSCSlider", getRootElement(), function(el, sliderValue, final)
  sscAmount = 1000 + math.floor(sliderValue * 499000 / 1000) * 1000
  sightexports.sGui:setInputValue(amountBox, tostring(sscAmount))
  formatSSCLabel()
end)
addEvent("changeSSCInput", false)
addEventHandler("changeSSCInput", getRootElement(), function(amount)
  sscAmount = tonumber(amount) or 0
  local slider = math.min(1, math.max(0, (sscAmount - 1000) / 499000))
  sightexports.sGui:setSliderValue(amountSlider, slider)
  formatSSCLabel()
end)
local lastSSCTry = 0
addEvent("sscCashierFinal", false)
addEventHandler("sscCashierFinal", getRootElement(), function(amount)
  if sscAmount < 1000 then
    sscAmount = 1000
    formatSSCLabel()
    sightexports.sGui:showInfobox("e", "Minimum összeg: 1 000 SSC")
    sightexports.sGui:setInputValue(amountBox, tostring(sscAmount))
  elseif sscAmount > 5000000 then
    sscAmount = 5000000
    formatSSCLabel()
    sightexports.sGui:showInfobox("e", "Maximum összeg: 5 000 000 SSC")
    sightexports.sGui:setInputValue(amountBox, tostring(sscAmount))
  else
    if getTickCount() - lastSSCTry < 10000 then
      sightexports.sGui:showInfobox("e", "Kérlek várj!")
      return
    end
    lastSSCTry = getTickCount()
    triggerServerEvent(buy and "buySSC" or "sellSSC", localPlayer, sscAmount)
  end
end)
addEvent("closeSSCWindow", false)
addEventHandler("closeSSCWindow", getRootElement(), function(amount)
  deleteSSCWindow()
  currentSSCPed = false
end)
addEventHandler("onActiveInputChange", getRootElement(), function(el, was)
  if was and was == amountBox then
    if sscAmount < 1000 then
      sscAmount = 1000
      formatSSCLabel()
      sightexports.sGui:showInfobox("e", "Minimum összeg: 1 000 SSC")
      sightexports.sGui:setInputValue(amountBox, tostring(sscAmount))
    elseif sscAmount > 5000000 then
      sscAmount = 5000000
      formatSSCLabel()
      sightexports.sGui:showInfobox("e", "Maximum összeg: 5 000 000 SSC")
      sightexports.sGui:setInputValue(amountBox, tostring(sscAmount))
    end
  end
end)
function createSSCWindow()
  sscAmount = 1000
  local x, y = deleteSSCWindow()
  local titleBarHeight = sightexports.sGui:getTitleBarHeight()
  local pw, ph = 350, titleBarHeight + 20 + 8 + 30 + 8 + 15 + 8 + 96 + 8 + 24 + 8
  window = sightexports.sGui:createGuiElement("window", x or screenX / 2 - pw / 2, y or screenY / 2 - ph / 2, pw, ph)
  sightexports.sGui:setWindowTitle(window, "16/BebasNeueRegular.otf", "SSC pénztár")
  sightexports.sGui:setWindowCloseButton(window, "closeSSCWindow")
  sightexports.sGui:setWindowElementMaxDistance(window, currentSSCPed, 3, "closeSSCWindow")
  local btn = sightexports.sGui:createGuiElement("button", 0, titleBarHeight - 1, pw / 2, 21, window)
  if buy then
    sightexports.sGui:setGuiBackground(btn, "solid", "sightgrey2")
    sightexports.sGui:setGuiHoverable(btn, false)
  else
    sightexports.sGui:setGuiBackground(btn, "solid", "sightgrey1")
    sightexports.sGui:setGuiHover(btn, "gradient", {"sightgrey1", "sightgrey2"}, false, true)
  end
  sightexports.sGui:setButtonFont(btn, "12/BebasNeueBold.otf")
  sightexports.sGui:setButtonTextColor(btn, "#ffffff")
  sightexports.sGui:setButtonText(btn, "SSC vásárlás")
  sightexports.sGui:setClickEvent(btn, "switchSSCWindowBuy")
  local btn = sightexports.sGui:createGuiElement("button", pw / 2, titleBarHeight - 1, pw / 2, 21, window)
  if buy then
    sightexports.sGui:setGuiBackground(btn, "solid", "sightgrey1")
    sightexports.sGui:setGuiHover(btn, "gradient", {"sightgrey1", "sightgrey2"}, false, true)
  else
    sightexports.sGui:setGuiBackground(btn, "solid", "sightgrey2")
    sightexports.sGui:setGuiHoverable(btn, false)
  end
  sightexports.sGui:setButtonFont(btn, "12/BebasNeueBold.otf")
  sightexports.sGui:setButtonTextColor(btn, "#ffffff")
  sightexports.sGui:setButtonText(btn, "SSC eladás")
  sightexports.sGui:setClickEvent(btn, "switchSSCWindowSell")
  local y = titleBarHeight + 20 + 8
  amountBox = sightexports.sGui:createGuiElement("input", pw / 2 - 100, y, 200, 30, window)
  sightexports.sGui:setInputPlaceholder(amountBox, "SSC összeg")
  sightexports.sGui:setInputValue(amountBox, tostring(sscAmount))
  sightexports.sGui:setInputFont(amountBox, "10/Ubuntu-R.ttf")
  sightexports.sGui:setInputIcon(amountBox, "coin")
  sightexports.sGui:setInputMaxLength(amountBox, 16)
  sightexports.sGui:setInputNumberOnly(amountBox, true)
  sightexports.sGui:setInputChangeEvent(amountBox, "changeSSCInput")
  y = y + 30 + 8
  amountSlider = sightexports.sGui:createGuiElement("slider", 8, y, pw - 16, 15, window)
  sightexports.sGui:setSliderChangeEvent(amountSlider, "changeSSCSlider")
  sightexports.sGui:setSliderValue(amountSlider, 0)
  y = y + 15 + 8
  sscLabel = sightexports.sGui:createGuiElement("label", 0, y, pw, 96, window)
  sightexports.sGui:setLabelFont(sscLabel, "12/Ubuntu-R.ttf")
  sightexports.sGui:setLabelAlignment(sscLabel, "center", "center")
  y = y + 96 + 8
  local btn = sightexports.sGui:createGuiElement("button", 8, y, pw - 16, 24, window)
  sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
  sightexports.sGui:setGuiHover(btn, "gradient", {
    "sightgreen",
    "sightgreen-second"
  }, false, true)
  sightexports.sGui:setButtonFont(btn, "14/BebasNeueBold.otf")
  sightexports.sGui:setButtonTextColor(btn, "#ffffff")
  sightexports.sGui:setButtonText(btn, buy and "Vásárlás" or "Eladás")
  sightexports.sGui:setClickEvent(btn, "sscCashierFinal")
  formatSSCLabel()
end
local casinoMusic = true
local jazz = false
local casinoDims = {
  [3] = 10,
  [23761] = 1,
  [23764] = 1,
  [17282] = 10,
  [23763] = 10
}
function doRemoves()
  removeWorldModel(2786, 2, 1968.7344, 1029.6641, 992.3125)
  removeWorldModel(2786, 2, 1967.4063, 1029.6563, 992.3125)
  removeWorldModel(2786, 2, 1968.7344, 1021.6875, 992.3125)
  removeWorldModel(2786, 2, 1967.4063, 1021.6875, 992.3125)
  removeWorldModel(2786, 2, 1968.7344, 1014, 992.3125)
  removeWorldModel(2786, 2, 1967.4063, 1014, 992.3125)
  removeWorldModel(2786, 2, 1968.7344, 1006.3438, 992.3125)
  removeWorldModel(2786, 2, 1967.4063, 1006.3438, 992.3125)
  removeWorldModel(2786, 2, 1941.0234, 1014.2266, 992.3125)
  removeWorldModel(2786, 2, 1939.6953, 1014.2188, 992.3125)
  removeWorldModel(2786, 2, 1941.0234, 1021.4141, 992.3125)
  removeWorldModel(2786, 2, 1939.6953, 1021.4141, 992.3125)
  removeWorldModel(2786, 2, 1941.8438, 1029.1328, 992.3125)
  removeWorldModel(2786, 2, 1940.5547, 1029.4766, 992.3125)
  removeWorldModel(2786, 2, 1942.125, 1006.5703, 992.3125)
  removeWorldModel(2786, 2, 1940.8828, 1006.1094, 992.3125)
  removeWorldModel(1895, 2, 1938.0469, 986.625, 992.8828)
  removeWorldModel(1895, 2, 1940.6875, 989.1719, 992.8828)
  removeWorldModel(2785, 2, 1940.8828, 1006.1094, 992.3125)
  removeWorldModel(2098, 2, 1941.5234, 1006.3828, 993.4141)
  removeWorldModel(2785, 2, 1942.125, 1006.5703, 992.3125)
  removeWorldModel(1895, 2, 1943.2188, 986.5234, 992.8828)
  removeWorldModel(2785, 2, 1939.6953, 1014.2188, 992.3125)
  removeWorldModel(2098, 2, 1940.3906, 1014.2031, 993.4141)
  removeWorldModel(2785, 2, 1941.0234, 1014.2266, 992.3125)
  removeWorldModel(2785, 2, 1939.6953, 1021.4141, 992.3125)
  removeWorldModel(2098, 2, 1940.3906, 1021.4141, 993.4141)
  removeWorldModel(2785, 2, 1941.0234, 1021.4141, 992.3125)
  removeWorldModel(2325, 2, 1957.4453, 987.6719, 992.9844)
  removeWorldModel(2325, 2, 1957.7188, 987.1953, 992.9844)
  removeWorldModel(1978, 2, 1959.3984, 1010.1172, 992.5078)
  removeWorldModel(2325, 2, 1961.9609, 992.2031, 992.9844)
  removeWorldModel(2325, 2, 1962.4063, 991.875, 992.9844)
  removeWorldModel(2325, 2, 1964.5703, 998.4531, 992.9844)
  removeWorldModel(2325, 2, 1965.1016, 998.3047, 992.9844)
  removeWorldModel(1978, 2, 1963.7109, 1010.1172, 992.5078)
  removeWorldModel(2785, 2, 1967.4063, 1014, 992.3125)
  removeWorldModel(2785, 2, 1967.4063, 1006.3438, 992.3125)
  removeWorldModel(2785, 2, 1968.7344, 1006.3438, 992.3125)
  removeWorldModel(2785, 2, 1968.7344, 1014, 992.3125)
  removeWorldModel(2785, 2, 1967.4063, 1021.6875, 992.3125)
  removeWorldModel(2785, 2, 1968.7344, 1021.6875, 992.3125)
  removeWorldModel(2785, 2, 1940.5547, 1029.4766, 992.3125)
  removeWorldModel(2098, 2, 1941.2188, 1029.2969, 993.4141)
  removeWorldModel(2785, 2, 1941.8438, 1029.1328, 992.3125)
  removeWorldModel(2800, 2, 1936.3594, 1040.1719, 991.9844)
  removeWorldModel(2799, 2, 1936.3594, 1040.1719, 991.9844)
  removeWorldModel(2800, 2, 1940.7109, 1041.5781, 991.9844)
  removeWorldModel(2799, 2, 1940.7109, 1041.5781, 991.9844)
  removeWorldModel(2800, 2, 1944.9453, 1040.0547, 991.9844)
  removeWorldModel(2799, 2, 1944.9453, 1040.0547, 991.9844)
  removeWorldModel(1978, 2, 1959.3984, 1025.6953, 992.5078)
  removeWorldModel(1978, 2, 1963.7109, 1025.6953, 992.5078)
  removeWorldModel(2785, 2, 1967.4063, 1029.6563, 992.3125)
  removeWorldModel(2785, 2, 1968.7344, 1029.6641, 992.3125)
  removeWorldModel(2325, 2, 1964.5469, 1037.2813, 992.9844)
  removeWorldModel(2325, 2, 1965.0938, 1037.3516, 992.9844)
  removeWorldModel(2800, 2, 1936.3594, 1043.4063, 991.9844)
  removeWorldModel(2799, 2, 1936.3594, 1043.4063, 991.9844)
  removeWorldModel(2800, 2, 1936.3594, 1046.6641, 991.9844)
  removeWorldModel(2799, 2, 1936.3594, 1046.6641, 991.9844)
  removeWorldModel(2800, 2, 1940.7109, 1044.8125, 991.9844)
  removeWorldModel(2799, 2, 1940.7109, 1044.8125, 991.9844)
  removeWorldModel(2800, 2, 1940.7109, 1048.0703, 991.9844)
  removeWorldModel(2799, 2, 1940.7109, 1048.0703, 991.9844)
  removeWorldModel(2800, 2, 1944.9453, 1043.2891, 991.9844)
  removeWorldModel(2799, 2, 1944.9453, 1043.2891, 991.9844)
  removeWorldModel(2800, 2, 1944.9453, 1046.5469, 991.9844)
  removeWorldModel(2799, 2, 1944.9453, 1046.5469, 991.9844)
  removeWorldModel(2325, 2, 1961.9219, 1043.3594, 992.9844)
  removeWorldModel(2325, 2, 1962.3984, 1043.6328, 992.9844)
  removeWorldModel(2325, 2, 1957.3203, 1047.9766, 992.9844)
  removeWorldModel(2800, 2, 1938.1484, 1051.4922, 991.9844)
  removeWorldModel(2799, 2, 1938.1484, 1051.4922, 991.9844)
  removeWorldModel(2800, 2, 1941.3828, 1051.4922, 991.9844)
  removeWorldModel(2799, 2, 1941.3828, 1051.4922, 991.9844)
  removeWorldModel(2800, 2, 1936.5078, 1055.0391, 991.9844)
  removeWorldModel(2799, 2, 1936.5078, 1055.0391, 991.9844)
  removeWorldModel(2800, 2, 1939.7422, 1055.0391, 991.9844)
  removeWorldModel(2799, 2, 1939.7422, 1055.0391, 991.9844)
  removeWorldModel(2800, 2, 1944.6406, 1051.4922, 991.9844)
  removeWorldModel(2799, 2, 1944.6406, 1051.4922, 991.9844)
  removeWorldModel(2325, 2, 1957.6563, 1048.4141, 992.9844)
  removeWorldModel(2800, 2, 1943, 1055.0391, 991.9844)
  removeWorldModel(2799, 2, 1943, 1055.0391, 991.9844)
  removeWorldModel(2188, 2, 1960.3672, 1015.6641, 992.4688)
  removeWorldModel(2188, 2, 1960.3672, 1020.1719, 992.4688)
  removeWorldModel(2188, 2, 1962.3438, 1015.6641, 992.4688)
  removeWorldModel(2188, 2, 1962.3438, 1020.1797, 992.4688)
  removeWorldModel(2786, 2, 2273.4609, 1596.4766, 1006.0156)
  removeWorldModel(2786, 2, 2268.7188, 1596.4688, 1006.0156)
  removeWorldModel(2786, 2, 2273.4609, 1589.7969, 1006.0156)
  removeWorldModel(2786, 2, 2268.7188, 1589.7969, 1006.0156)
  removeWorldModel(2786, 2, 2263.6563, 1589.7969, 1006.0156)
  removeWorldModel(2786, 2, 2258.2578, 1589.7969, 1006.0156)
  removeWorldModel(2786, 2, 2253.2344, 1589.7969, 1006.0156)
  removeWorldModel(2786, 2, 2263.6563, 1596.4844, 1006.0156)
  removeWorldModel(2786, 2, 2258.2578, 1596.4766, 1006.0156)
  removeWorldModel(2786, 2, 2253.2344, 1596.4844, 1006.0156)
  removeWorldModel(2786, 2, 2254.1797, 1596.4844, 1006.0156)
  removeWorldModel(2786, 2, 2259.2188, 1596.4844, 1006.0156)
  removeWorldModel(2786, 2, 2264.625, 1596.4844, 1006.0156)
  removeWorldModel(2786, 2, 2269.6719, 1596.4844, 1006.0156)
  removeWorldModel(2786, 2, 2274.4063, 1596.4844, 1006.0156)
  removeWorldModel(2786, 2, 2274.4063, 1589.7891, 1006.0156)
  removeWorldModel(2786, 2, 2269.6563, 1589.7891, 1006.0156)
  removeWorldModel(2786, 2, 2264.6094, 1589.7891, 1006.0156)
  removeWorldModel(2786, 2, 2259.1875, 1589.7969, 1006.0156)
  removeWorldModel(2786, 2, 2254.1563, 1589.7969, 1006.0156)
  removeWorldModel(1837, 2, 2216.5703, 1588.0938, 1006)
  removeWorldModel(1836, 2, 2216.5781, 1588.5703, 1006)
  removeWorldModel(1837, 2, 2216.5703, 1592.3984, 1006)
  removeWorldModel(1836, 2, 2216.5781, 1592.875, 1006)
  removeWorldModel(1833, 2, 2217.0156, 1602.8125, 1005.9844)
  removeWorldModel(1833, 2, 2217.5469, 1602.7969, 1005.9844)
  removeWorldModel(2325, 2, 2217.0234, 1603.9297, 1006.7656)
  removeWorldModel(1835, 2, 2217.0156, 1605.0469, 1005.9844)
  removeWorldModel(2592, 2, 2217.0313, 1603.9219, 1006.0781)
  removeWorldModel(2325, 2, 2217.5469, 1603.8984, 1006.7656)
  removeWorldModel(2592, 2, 2217.5469, 1603.9141, 1006.0781)
  removeWorldModel(1834, 2, 2217.5469, 1605.0391, 1005.9844)
  removeWorldModel(1837, 2, 2216.5703, 1614.2422, 1006)
  removeWorldModel(1836, 2, 2216.5781, 1614.7188, 1006)
  removeWorldModel(1837, 2, 2216.5703, 1618.5781, 1006)
  removeWorldModel(1836, 2, 2216.5781, 1619.0547, 1006)
  removeWorldModel(1837, 2, 2220.7188, 1588.0938, 1006)
  removeWorldModel(2325, 2, 2218.6328, 1588.0781, 1006.7656)
  removeWorldModel(2325, 2, 2218.6641, 1588.6016, 1006.7656)
  removeWorldModel(1836, 2, 2220.6953, 1588.5703, 1006)
  removeWorldModel(2784, 2, 2218.6172, 1588.3359, 1006.4922)
  removeWorldModel(1978, 2, 2230.5703, 1589.1875, 1006.2266)
  removeWorldModel(1978, 2, 2242.3672, 1589.1875, 1006.2266)
  removeWorldModel(2325, 2, 2218.6328, 1592.3828, 1006.7656)
  removeWorldModel(2325, 2, 2218.6641, 1592.9063, 1006.7656)
  removeWorldModel(2784, 2, 2218.6172, 1592.6406, 1006.4922)
  removeWorldModel(1837, 2, 2220.7188, 1592.3984, 1006)
  removeWorldModel(1836, 2, 2220.6953, 1592.875, 1006)
  removeWorldModel(1978, 2, 2230.5703, 1594.7578, 1006.2266)
  removeWorldModel(1978, 2, 2242.3672, 1594.7578, 1006.2266)
  removeWorldModel(1833, 2, 2220.6719, 1602.8125, 1005.9844)
  removeWorldModel(1833, 2, 2221.2031, 1602.7969, 1005.9844)
  removeWorldModel(2188, 2, 2230.375, 1602.75, 1006.1563)
  removeWorldModel(2188, 2, 2241.3125, 1602.75, 1006.1563)
  removeWorldModel(2325, 2, 2220.6797, 1603.9297, 1006.7656)
  removeWorldModel(2325, 2, 2221.2031, 1603.8984, 1006.7656)
  removeWorldModel(2592, 2, 2220.6875, 1603.9219, 1006.0781)
  removeWorldModel(2592, 2, 2221.2031, 1603.9141, 1006.0781)
  removeWorldModel(2188, 2, 2243.125, 1604.4375, 1006.1563)
  removeWorldModel(2188, 2, 2232.1875, 1604.4375, 1006.1563)
  removeWorldModel(2188, 2, 2239.4297, 1604.4531, 1006.1563)
  removeWorldModel(2188, 2, 2228.4922, 1604.4531, 1006.1563)
  removeWorldModel(1834, 2, 2221.2031, 1605.0391, 1005.9844)
  removeWorldModel(1835, 2, 2220.6719, 1605.0469, 1005.9844)
  removeWorldModel(2188, 2, 2241.3125, 1606.2734, 1006.1563)
  removeWorldModel(2188, 2, 2230.375, 1606.2734, 1006.1563)
  removeWorldModel(2325, 2, 2218.6328, 1614.2266, 1006.7656)
  removeWorldModel(1837, 2, 2220.7188, 1614.2422, 1006)
  removeWorldModel(2784, 2, 2218.6172, 1614.4844, 1006.4922)
  removeWorldModel(2325, 2, 2218.6641, 1614.75, 1006.7656)
  removeWorldModel(1836, 2, 2220.6953, 1614.7188, 1006)
  removeWorldModel(1978, 2, 2230.5703, 1614.5938, 1006.2266)
  removeWorldModel(1978, 2, 2241.4453, 1614.5547, 1006.2266)
  removeWorldModel(1837, 2, 2220.7188, 1618.5781, 1006)
  removeWorldModel(2325, 2, 2218.6328, 1618.5625, 1006.7656)
  removeWorldModel(2325, 2, 2218.6641, 1619.0859, 1006.7656)
  removeWorldModel(1836, 2, 2220.6953, 1619.0547, 1006)
  removeWorldModel(2784, 2, 2218.6172, 1618.8203, 1006.4922)
  removeWorldModel(1978, 2, 2230.5703, 1619.6563, 1006.2266)
  removeWorldModel(1978, 2, 2241.4453, 1619.6094, 1006.2266)
  removeWorldModel(2785, 2, 2264.6094, 1589.7891, 1006.0156)
  removeWorldModel(2785, 2, 2263.6563, 1589.7969, 1006.0156)
  removeWorldModel(2785, 2, 2258.2578, 1589.7969, 1006.0156)
  removeWorldModel(2785, 2, 2253.2344, 1589.7969, 1006.0156)
  removeWorldModel(2785, 2, 2259.1875, 1589.7969, 1006.0156)
  removeWorldModel(2785, 2, 2254.1563, 1589.7969, 1006.0156)
  removeWorldModel(2785, 2, 2258.2578, 1596.4766, 1006.0156)
  removeWorldModel(2785, 2, 2263.6563, 1596.4844, 1006.0156)
  removeWorldModel(2785, 2, 2253.2344, 1596.4844, 1006.0156)
  removeWorldModel(2785, 2, 2254.1797, 1596.4844, 1006.0156)
  removeWorldModel(2785, 2, 2259.2188, 1596.4844, 1006.0156)
  removeWorldModel(2785, 2, 2264.625, 1596.4844, 1006.0156)
  removeWorldModel(1836, 2, 2253.125, 1609.6406, 1006)
  removeWorldModel(2325, 2, 2255.1563, 1609.6016, 1006.7656)
  removeWorldModel(1836, 2, 2257.2422, 1609.6406, 1006)
  removeWorldModel(2784, 2, 2255.2109, 1609.875, 1006.4922)
  removeWorldModel(1837, 2, 2253.1016, 1610.1172, 1006)
  removeWorldModel(1837, 2, 2257.25, 1610.1172, 1006)
  removeWorldModel(2325, 2, 2255.1875, 1610.125, 1006.7656)
  removeWorldModel(1837, 2, 2253.1016, 1614.1641, 1006)
  removeWorldModel(1836, 2, 2253.125, 1613.6875, 1006)
  removeWorldModel(2325, 2, 2255.1563, 1613.6484, 1006.7656)
  removeWorldModel(1837, 2, 2257.25, 1614.1641, 1006)
  removeWorldModel(1836, 2, 2257.2422, 1613.6875, 1006)
  removeWorldModel(2325, 2, 2255.1875, 1614.1719, 1006.7656)
  removeWorldModel(2784, 2, 2255.2109, 1613.9141, 1006.4922)
  removeWorldModel(1836, 2, 2253.125, 1617.5781, 1006)
  removeWorldModel(1836, 2, 2257.2422, 1617.5781, 1006)
  removeWorldModel(2325, 2, 2255.1563, 1617.5469, 1006.7656)
  removeWorldModel(2784, 2, 2255.2109, 1617.8125, 1006.4922)
  removeWorldModel(1837, 2, 2253.1016, 1618.0547, 1006)
  removeWorldModel(1837, 2, 2257.25, 1618.0547, 1006)
  removeWorldModel(2325, 2, 2255.1875, 1618.0703, 1006.7656)
  removeWorldModel(2785, 2, 2268.7188, 1589.7969, 1006.0156)
  removeWorldModel(2785, 2, 2269.6563, 1589.7891, 1006.0156)
  removeWorldModel(2785, 2, 2268.7188, 1596.4688, 1006.0156)
  removeWorldModel(2785, 2, 2269.6719, 1596.4844, 1006.0156)
  removeWorldModel(1837, 2, 2269.2578, 1604.5938, 1006)
  removeWorldModel(1836, 2, 2269.7344, 1604.6172, 1006)
  removeWorldModel(2325, 2, 2269.7734, 1606.6484, 1006.7656)
  removeWorldModel(1837, 2, 2269.2578, 1608.7422, 1006)
  removeWorldModel(2325, 2, 2269.25, 1606.6797, 1006.7656)
  removeWorldModel(1836, 2, 2269.7344, 1608.7344, 1006)
  removeWorldModel(2784, 2, 2269.5078, 1606.7031, 1006.4922)
  removeWorldModel(2785, 2, 2273.4609, 1589.7969, 1006.0156)
  removeWorldModel(2785, 2, 2274.4063, 1589.7891, 1006.0156)
  removeWorldModel(2785, 2, 2273.4609, 1596.4766, 1006.0156)
  removeWorldModel(2785, 2, 2274.4063, 1596.4844, 1006.0156)
  removeWorldModel(2325, 2, 2273.2969, 1606.6797, 1006.7656)
  removeWorldModel(1837, 2, 2273.3047, 1604.5938, 1006)
  removeWorldModel(1837, 2, 2273.3047, 1608.7422, 1006)
  removeWorldModel(2784, 2, 2273.5469, 1606.7031, 1006.4922)
  removeWorldModel(2325, 2, 2273.8203, 1606.6484, 1006.7656)
  removeWorldModel(1836, 2, 2273.7813, 1604.6172, 1006)
  removeWorldModel(1836, 2, 2273.7813, 1608.7344, 1006)
end
function processJazz()
  local dim = getElementDimension(localPlayer)
  if not casinoDims[dim] or casinoDims[dim] ~= getElementInterior(localPlayer) then
    if isElement(jazz) then
      destroyElement(jazz)
    end
    jazz = nil
    sightlangCondHandl0(false)
  end
end
function createCasinoMusic()
  if isElement(jazz) then
    destroyElement(jazz)
  end
  jazz = nil
  outputChatBox("[color=sightyellow][SightMTA - Kaszinó]: #ffffffA zene " .. (casinoMusic and "ki" or "be") .. "kapcsolásához: /togcasinomusic", 255, 255, 255, true)
  if casinoMusic then
    jazz = playSound("http://64.95.243.43:8002/listen.pls")
    setSoundVolume(jazz, 0.1)
    sightlangCondHandl0(true)
  end
end
function doInitCasinoStuff()
  local int = getElementInterior(localPlayer)
  local dim = getElementDimension(localPlayer)
  if casinoDims[dim] and casinoDims[dim] == int then
    createCasinoMusic()
    doRemoves()
    setInteriorSoundsEnabled(false)
  else
    setInteriorSoundsEnabled(true)
  end
  sightlangCondHandl1(false)
end
addEventHandler("onClientElementInteriorChange", localPlayer, function(oldDimension, newDimension)
  sightlangCondHandl1(true)
end)
addEventHandler("onClientElementDimensionChange", localPlayer, function(oldDimension, newDimension)
  sightlangCondHandl1(true)
end)
local dim = getElementDimension(localPlayer)
if casinoDims[dim] and casinoDims[dim] == getElementInterior(localPlayer) then
  createCasinoMusic()
  doRemoves()
  setInteriorSoundsEnabled(false)
else
  setInteriorSoundsEnabled(true)
end
addCommandHandler("togcasinomusic", function()
  local dim = getElementDimension(localPlayer)
  if casinoDims[dim] then
    casinoMusic = not casinoMusic
    createCasinoMusic()
  end
end)
