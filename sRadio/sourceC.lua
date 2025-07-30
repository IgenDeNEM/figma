local sightexports = {
  sGui = false,
  sVehicles = false,
  sRadar = false,
  sGps = false,
  sDashboard = false
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
sightlangStaticImageToc[5] = true
sightlangStaticImageToc[6] = true
sightlangStaticImageToc[7] = true
sightlangStaticImageToc[8] = true
sightlangStaticImageToc[9] = true
sightlangStaticImageToc[10] = true
sightlangStaticImageToc[11] = true
sightlangStaticImageToc[12] = true
sightlangStaticImageToc[13] = true
sightlangStaticImageToc[14] = true
sightlangStaticImageToc[15] = true
sightlangStaticImageToc[16] = true
sightlangStaticImageToc[17] = true
sightlangStaticImageToc[18] = true
sightlangStaticImageToc[19] = true
sightlangStaticImageToc[20] = true
sightlangStaticImageToc[21] = true
sightlangStaticImageToc[22] = true
sightlangStaticImageToc[23] = true
sightlangStaticImageToc[24] = true
sightlangStaticImageToc[25] = true
sightlangStaticImageToc[26] = true
sightlangStaticImageToc[27] = true
sightlangStaticImageToc[28] = true
sightlangStaticImageToc[29] = true
sightlangStaticImageToc[30] = true
sightlangStaticImageToc[31] = true
sightlangStaticImageToc[32] = true
sightlangStaticImageToc[33] = true
sightlangStaticImageToc[34] = true
sightlangStaticImageToc[35] = true
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
  if sightlangStaticImageUsed[5] then
    sightlangStaticImageUsed[5] = false
    sightlangStaticImageDel[5] = false
  elseif sightlangStaticImage[5] then
    if sightlangStaticImageDel[5] then
      if now >= sightlangStaticImageDel[5] then
        if isElement(sightlangStaticImage[5]) then
          destroyElement(sightlangStaticImage[5])
        end
        sightlangStaticImage[5] = nil
        sightlangStaticImageDel[5] = false
        sightlangStaticImageToc[5] = true
        return
      end
    else
      sightlangStaticImageDel[5] = now + 5000
    end
  else
    sightlangStaticImageToc[5] = true
  end
  if sightlangStaticImageUsed[6] then
    sightlangStaticImageUsed[6] = false
    sightlangStaticImageDel[6] = false
  elseif sightlangStaticImage[6] then
    if sightlangStaticImageDel[6] then
      if now >= sightlangStaticImageDel[6] then
        if isElement(sightlangStaticImage[6]) then
          destroyElement(sightlangStaticImage[6])
        end
        sightlangStaticImage[6] = nil
        sightlangStaticImageDel[6] = false
        sightlangStaticImageToc[6] = true
        return
      end
    else
      sightlangStaticImageDel[6] = now + 5000
    end
  else
    sightlangStaticImageToc[6] = true
  end
  if sightlangStaticImageUsed[7] then
    sightlangStaticImageUsed[7] = false
    sightlangStaticImageDel[7] = false
  elseif sightlangStaticImage[7] then
    if sightlangStaticImageDel[7] then
      if now >= sightlangStaticImageDel[7] then
        if isElement(sightlangStaticImage[7]) then
          destroyElement(sightlangStaticImage[7])
        end
        sightlangStaticImage[7] = nil
        sightlangStaticImageDel[7] = false
        sightlangStaticImageToc[7] = true
        return
      end
    else
      sightlangStaticImageDel[7] = now + 5000
    end
  else
    sightlangStaticImageToc[7] = true
  end
  if sightlangStaticImageUsed[8] then
    sightlangStaticImageUsed[8] = false
    sightlangStaticImageDel[8] = false
  elseif sightlangStaticImage[8] then
    if sightlangStaticImageDel[8] then
      if now >= sightlangStaticImageDel[8] then
        if isElement(sightlangStaticImage[8]) then
          destroyElement(sightlangStaticImage[8])
        end
        sightlangStaticImage[8] = nil
        sightlangStaticImageDel[8] = false
        sightlangStaticImageToc[8] = true
        return
      end
    else
      sightlangStaticImageDel[8] = now + 5000
    end
  else
    sightlangStaticImageToc[8] = true
  end
  if sightlangStaticImageUsed[9] then
    sightlangStaticImageUsed[9] = false
    sightlangStaticImageDel[9] = false
  elseif sightlangStaticImage[9] then
    if sightlangStaticImageDel[9] then
      if now >= sightlangStaticImageDel[9] then
        if isElement(sightlangStaticImage[9]) then
          destroyElement(sightlangStaticImage[9])
        end
        sightlangStaticImage[9] = nil
        sightlangStaticImageDel[9] = false
        sightlangStaticImageToc[9] = true
        return
      end
    else
      sightlangStaticImageDel[9] = now + 5000
    end
  else
    sightlangStaticImageToc[9] = true
  end
  if sightlangStaticImageUsed[10] then
    sightlangStaticImageUsed[10] = false
    sightlangStaticImageDel[10] = false
  elseif sightlangStaticImage[10] then
    if sightlangStaticImageDel[10] then
      if now >= sightlangStaticImageDel[10] then
        if isElement(sightlangStaticImage[10]) then
          destroyElement(sightlangStaticImage[10])
        end
        sightlangStaticImage[10] = nil
        sightlangStaticImageDel[10] = false
        sightlangStaticImageToc[10] = true
        return
      end
    else
      sightlangStaticImageDel[10] = now + 5000
    end
  else
    sightlangStaticImageToc[10] = true
  end
  if sightlangStaticImageUsed[11] then
    sightlangStaticImageUsed[11] = false
    sightlangStaticImageDel[11] = false
  elseif sightlangStaticImage[11] then
    if sightlangStaticImageDel[11] then
      if now >= sightlangStaticImageDel[11] then
        if isElement(sightlangStaticImage[11]) then
          destroyElement(sightlangStaticImage[11])
        end
        sightlangStaticImage[11] = nil
        sightlangStaticImageDel[11] = false
        sightlangStaticImageToc[11] = true
        return
      end
    else
      sightlangStaticImageDel[11] = now + 5000
    end
  else
    sightlangStaticImageToc[11] = true
  end
  if sightlangStaticImageUsed[12] then
    sightlangStaticImageUsed[12] = false
    sightlangStaticImageDel[12] = false
  elseif sightlangStaticImage[12] then
    if sightlangStaticImageDel[12] then
      if now >= sightlangStaticImageDel[12] then
        if isElement(sightlangStaticImage[12]) then
          destroyElement(sightlangStaticImage[12])
        end
        sightlangStaticImage[12] = nil
        sightlangStaticImageDel[12] = false
        sightlangStaticImageToc[12] = true
        return
      end
    else
      sightlangStaticImageDel[12] = now + 5000
    end
  else
    sightlangStaticImageToc[12] = true
  end
  if sightlangStaticImageUsed[13] then
    sightlangStaticImageUsed[13] = false
    sightlangStaticImageDel[13] = false
  elseif sightlangStaticImage[13] then
    if sightlangStaticImageDel[13] then
      if now >= sightlangStaticImageDel[13] then
        if isElement(sightlangStaticImage[13]) then
          destroyElement(sightlangStaticImage[13])
        end
        sightlangStaticImage[13] = nil
        sightlangStaticImageDel[13] = false
        sightlangStaticImageToc[13] = true
        return
      end
    else
      sightlangStaticImageDel[13] = now + 5000
    end
  else
    sightlangStaticImageToc[13] = true
  end
  if sightlangStaticImageUsed[14] then
    sightlangStaticImageUsed[14] = false
    sightlangStaticImageDel[14] = false
  elseif sightlangStaticImage[14] then
    if sightlangStaticImageDel[14] then
      if now >= sightlangStaticImageDel[14] then
        if isElement(sightlangStaticImage[14]) then
          destroyElement(sightlangStaticImage[14])
        end
        sightlangStaticImage[14] = nil
        sightlangStaticImageDel[14] = false
        sightlangStaticImageToc[14] = true
        return
      end
    else
      sightlangStaticImageDel[14] = now + 5000
    end
  else
    sightlangStaticImageToc[14] = true
  end
  if sightlangStaticImageUsed[15] then
    sightlangStaticImageUsed[15] = false
    sightlangStaticImageDel[15] = false
  elseif sightlangStaticImage[15] then
    if sightlangStaticImageDel[15] then
      if now >= sightlangStaticImageDel[15] then
        if isElement(sightlangStaticImage[15]) then
          destroyElement(sightlangStaticImage[15])
        end
        sightlangStaticImage[15] = nil
        sightlangStaticImageDel[15] = false
        sightlangStaticImageToc[15] = true
        return
      end
    else
      sightlangStaticImageDel[15] = now + 5000
    end
  else
    sightlangStaticImageToc[15] = true
  end
  if sightlangStaticImageUsed[16] then
    sightlangStaticImageUsed[16] = false
    sightlangStaticImageDel[16] = false
  elseif sightlangStaticImage[16] then
    if sightlangStaticImageDel[16] then
      if now >= sightlangStaticImageDel[16] then
        if isElement(sightlangStaticImage[16]) then
          destroyElement(sightlangStaticImage[16])
        end
        sightlangStaticImage[16] = nil
        sightlangStaticImageDel[16] = false
        sightlangStaticImageToc[16] = true
        return
      end
    else
      sightlangStaticImageDel[16] = now + 5000
    end
  else
    sightlangStaticImageToc[16] = true
  end
  if sightlangStaticImageUsed[17] then
    sightlangStaticImageUsed[17] = false
    sightlangStaticImageDel[17] = false
  elseif sightlangStaticImage[17] then
    if sightlangStaticImageDel[17] then
      if now >= sightlangStaticImageDel[17] then
        if isElement(sightlangStaticImage[17]) then
          destroyElement(sightlangStaticImage[17])
        end
        sightlangStaticImage[17] = nil
        sightlangStaticImageDel[17] = false
        sightlangStaticImageToc[17] = true
        return
      end
    else
      sightlangStaticImageDel[17] = now + 5000
    end
  else
    sightlangStaticImageToc[17] = true
  end
  if sightlangStaticImageUsed[18] then
    sightlangStaticImageUsed[18] = false
    sightlangStaticImageDel[18] = false
  elseif sightlangStaticImage[18] then
    if sightlangStaticImageDel[18] then
      if now >= sightlangStaticImageDel[18] then
        if isElement(sightlangStaticImage[18]) then
          destroyElement(sightlangStaticImage[18])
        end
        sightlangStaticImage[18] = nil
        sightlangStaticImageDel[18] = false
        sightlangStaticImageToc[18] = true
        return
      end
    else
      sightlangStaticImageDel[18] = now + 5000
    end
  else
    sightlangStaticImageToc[18] = true
  end
  if sightlangStaticImageUsed[19] then
    sightlangStaticImageUsed[19] = false
    sightlangStaticImageDel[19] = false
  elseif sightlangStaticImage[19] then
    if sightlangStaticImageDel[19] then
      if now >= sightlangStaticImageDel[19] then
        if isElement(sightlangStaticImage[19]) then
          destroyElement(sightlangStaticImage[19])
        end
        sightlangStaticImage[19] = nil
        sightlangStaticImageDel[19] = false
        sightlangStaticImageToc[19] = true
        return
      end
    else
      sightlangStaticImageDel[19] = now + 5000
    end
  else
    sightlangStaticImageToc[19] = true
  end
  if sightlangStaticImageUsed[20] then
    sightlangStaticImageUsed[20] = false
    sightlangStaticImageDel[20] = false
  elseif sightlangStaticImage[20] then
    if sightlangStaticImageDel[20] then
      if now >= sightlangStaticImageDel[20] then
        if isElement(sightlangStaticImage[20]) then
          destroyElement(sightlangStaticImage[20])
        end
        sightlangStaticImage[20] = nil
        sightlangStaticImageDel[20] = false
        sightlangStaticImageToc[20] = true
        return
      end
    else
      sightlangStaticImageDel[20] = now + 5000
    end
  else
    sightlangStaticImageToc[20] = true
  end
  if sightlangStaticImageUsed[21] then
    sightlangStaticImageUsed[21] = false
    sightlangStaticImageDel[21] = false
  elseif sightlangStaticImage[21] then
    if sightlangStaticImageDel[21] then
      if now >= sightlangStaticImageDel[21] then
        if isElement(sightlangStaticImage[21]) then
          destroyElement(sightlangStaticImage[21])
        end
        sightlangStaticImage[21] = nil
        sightlangStaticImageDel[21] = false
        sightlangStaticImageToc[21] = true
        return
      end
    else
      sightlangStaticImageDel[21] = now + 5000
    end
  else
    sightlangStaticImageToc[21] = true
  end
  if sightlangStaticImageUsed[22] then
    sightlangStaticImageUsed[22] = false
    sightlangStaticImageDel[22] = false
  elseif sightlangStaticImage[22] then
    if sightlangStaticImageDel[22] then
      if now >= sightlangStaticImageDel[22] then
        if isElement(sightlangStaticImage[22]) then
          destroyElement(sightlangStaticImage[22])
        end
        sightlangStaticImage[22] = nil
        sightlangStaticImageDel[22] = false
        sightlangStaticImageToc[22] = true
        return
      end
    else
      sightlangStaticImageDel[22] = now + 5000
    end
  else
    sightlangStaticImageToc[22] = true
  end
  if sightlangStaticImageUsed[23] then
    sightlangStaticImageUsed[23] = false
    sightlangStaticImageDel[23] = false
  elseif sightlangStaticImage[23] then
    if sightlangStaticImageDel[23] then
      if now >= sightlangStaticImageDel[23] then
        if isElement(sightlangStaticImage[23]) then
          destroyElement(sightlangStaticImage[23])
        end
        sightlangStaticImage[23] = nil
        sightlangStaticImageDel[23] = false
        sightlangStaticImageToc[23] = true
        return
      end
    else
      sightlangStaticImageDel[23] = now + 5000
    end
  else
    sightlangStaticImageToc[23] = true
  end
  if sightlangStaticImageUsed[24] then
    sightlangStaticImageUsed[24] = false
    sightlangStaticImageDel[24] = false
  elseif sightlangStaticImage[24] then
    if sightlangStaticImageDel[24] then
      if now >= sightlangStaticImageDel[24] then
        if isElement(sightlangStaticImage[24]) then
          destroyElement(sightlangStaticImage[24])
        end
        sightlangStaticImage[24] = nil
        sightlangStaticImageDel[24] = false
        sightlangStaticImageToc[24] = true
        return
      end
    else
      sightlangStaticImageDel[24] = now + 5000
    end
  else
    sightlangStaticImageToc[24] = true
  end
  if sightlangStaticImageUsed[25] then
    sightlangStaticImageUsed[25] = false
    sightlangStaticImageDel[25] = false
  elseif sightlangStaticImage[25] then
    if sightlangStaticImageDel[25] then
      if now >= sightlangStaticImageDel[25] then
        if isElement(sightlangStaticImage[25]) then
          destroyElement(sightlangStaticImage[25])
        end
        sightlangStaticImage[25] = nil
        sightlangStaticImageDel[25] = false
        sightlangStaticImageToc[25] = true
        return
      end
    else
      sightlangStaticImageDel[25] = now + 5000
    end
  else
    sightlangStaticImageToc[25] = true
  end
  if sightlangStaticImageUsed[26] then
    sightlangStaticImageUsed[26] = false
    sightlangStaticImageDel[26] = false
  elseif sightlangStaticImage[26] then
    if sightlangStaticImageDel[26] then
      if now >= sightlangStaticImageDel[26] then
        if isElement(sightlangStaticImage[26]) then
          destroyElement(sightlangStaticImage[26])
        end
        sightlangStaticImage[26] = nil
        sightlangStaticImageDel[26] = false
        sightlangStaticImageToc[26] = true
        return
      end
    else
      sightlangStaticImageDel[26] = now + 5000
    end
  else
    sightlangStaticImageToc[26] = true
  end
  if sightlangStaticImageUsed[27] then
    sightlangStaticImageUsed[27] = false
    sightlangStaticImageDel[27] = false
  elseif sightlangStaticImage[27] then
    if sightlangStaticImageDel[27] then
      if now >= sightlangStaticImageDel[27] then
        if isElement(sightlangStaticImage[27]) then
          destroyElement(sightlangStaticImage[27])
        end
        sightlangStaticImage[27] = nil
        sightlangStaticImageDel[27] = false
        sightlangStaticImageToc[27] = true
        return
      end
    else
      sightlangStaticImageDel[27] = now + 5000
    end
  else
    sightlangStaticImageToc[27] = true
  end
  if sightlangStaticImageUsed[28] then
    sightlangStaticImageUsed[28] = false
    sightlangStaticImageDel[28] = false
  elseif sightlangStaticImage[28] then
    if sightlangStaticImageDel[28] then
      if now >= sightlangStaticImageDel[28] then
        if isElement(sightlangStaticImage[28]) then
          destroyElement(sightlangStaticImage[28])
        end
        sightlangStaticImage[28] = nil
        sightlangStaticImageDel[28] = false
        sightlangStaticImageToc[28] = true
        return
      end
    else
      sightlangStaticImageDel[28] = now + 5000
    end
  else
    sightlangStaticImageToc[28] = true
  end
  if sightlangStaticImageUsed[29] then
    sightlangStaticImageUsed[29] = false
    sightlangStaticImageDel[29] = false
  elseif sightlangStaticImage[29] then
    if sightlangStaticImageDel[29] then
      if now >= sightlangStaticImageDel[29] then
        if isElement(sightlangStaticImage[29]) then
          destroyElement(sightlangStaticImage[29])
        end
        sightlangStaticImage[29] = nil
        sightlangStaticImageDel[29] = false
        sightlangStaticImageToc[29] = true
        return
      end
    else
      sightlangStaticImageDel[29] = now + 5000
    end
  else
    sightlangStaticImageToc[29] = true
  end
  if sightlangStaticImageUsed[30] then
    sightlangStaticImageUsed[30] = false
    sightlangStaticImageDel[30] = false
  elseif sightlangStaticImage[30] then
    if sightlangStaticImageDel[30] then
      if now >= sightlangStaticImageDel[30] then
        if isElement(sightlangStaticImage[30]) then
          destroyElement(sightlangStaticImage[30])
        end
        sightlangStaticImage[30] = nil
        sightlangStaticImageDel[30] = false
        sightlangStaticImageToc[30] = true
        return
      end
    else
      sightlangStaticImageDel[30] = now + 5000
    end
  else
    sightlangStaticImageToc[30] = true
  end
  if sightlangStaticImageUsed[31] then
    sightlangStaticImageUsed[31] = false
    sightlangStaticImageDel[31] = false
  elseif sightlangStaticImage[31] then
    if sightlangStaticImageDel[31] then
      if now >= sightlangStaticImageDel[31] then
        if isElement(sightlangStaticImage[31]) then
          destroyElement(sightlangStaticImage[31])
        end
        sightlangStaticImage[31] = nil
        sightlangStaticImageDel[31] = false
        sightlangStaticImageToc[31] = true
        return
      end
    else
      sightlangStaticImageDel[31] = now + 5000
    end
  else
    sightlangStaticImageToc[31] = true
  end
  if sightlangStaticImageUsed[32] then
    sightlangStaticImageUsed[32] = false
    sightlangStaticImageDel[32] = false
  elseif sightlangStaticImage[32] then
    if sightlangStaticImageDel[32] then
      if now >= sightlangStaticImageDel[32] then
        if isElement(sightlangStaticImage[32]) then
          destroyElement(sightlangStaticImage[32])
        end
        sightlangStaticImage[32] = nil
        sightlangStaticImageDel[32] = false
        sightlangStaticImageToc[32] = true
        return
      end
    else
      sightlangStaticImageDel[32] = now + 5000
    end
  else
    sightlangStaticImageToc[32] = true
  end
  if sightlangStaticImageUsed[33] then
    sightlangStaticImageUsed[33] = false
    sightlangStaticImageDel[33] = false
  elseif sightlangStaticImage[33] then
    if sightlangStaticImageDel[33] then
      if now >= sightlangStaticImageDel[33] then
        if isElement(sightlangStaticImage[33]) then
          destroyElement(sightlangStaticImage[33])
        end
        sightlangStaticImage[33] = nil
        sightlangStaticImageDel[33] = false
        sightlangStaticImageToc[33] = true
        return
      end
    else
      sightlangStaticImageDel[33] = now + 5000
    end
  else
    sightlangStaticImageToc[33] = true
  end
  if sightlangStaticImageUsed[34] then
    sightlangStaticImageUsed[34] = false
    sightlangStaticImageDel[34] = false
  elseif sightlangStaticImage[34] then
    if sightlangStaticImageDel[34] then
      if now >= sightlangStaticImageDel[34] then
        if isElement(sightlangStaticImage[34]) then
          destroyElement(sightlangStaticImage[34])
        end
        sightlangStaticImage[34] = nil
        sightlangStaticImageDel[34] = false
        sightlangStaticImageToc[34] = true
        return
      end
    else
      sightlangStaticImageDel[34] = now + 5000
    end
  else
    sightlangStaticImageToc[34] = true
  end
  if sightlangStaticImageUsed[35] then
    sightlangStaticImageUsed[35] = false
    sightlangStaticImageDel[35] = false
  elseif sightlangStaticImage[35] then
    if sightlangStaticImageDel[35] then
      if now >= sightlangStaticImageDel[35] then
        if isElement(sightlangStaticImage[35]) then
          destroyElement(sightlangStaticImage[35])
        end
        sightlangStaticImage[35] = nil
        sightlangStaticImageDel[35] = false
        sightlangStaticImageToc[35] = true
        return
      end
    else
      sightlangStaticImageDel[35] = now + 5000
    end
  else
    sightlangStaticImageToc[35] = true
  end
  if sightlangStaticImageToc[0] and sightlangStaticImageToc[1] and sightlangStaticImageToc[2] and sightlangStaticImageToc[3] and sightlangStaticImageToc[4] and sightlangStaticImageToc[5] and sightlangStaticImageToc[6] and sightlangStaticImageToc[7] and sightlangStaticImageToc[8] and sightlangStaticImageToc[9] and sightlangStaticImageToc[10] and sightlangStaticImageToc[11] and sightlangStaticImageToc[12] and sightlangStaticImageToc[13] and sightlangStaticImageToc[14] and sightlangStaticImageToc[15] and sightlangStaticImageToc[16] and sightlangStaticImageToc[17] and sightlangStaticImageToc[18] and sightlangStaticImageToc[19] and sightlangStaticImageToc[20] and sightlangStaticImageToc[21] and sightlangStaticImageToc[22] and sightlangStaticImageToc[23] and sightlangStaticImageToc[24] and sightlangStaticImageToc[25] and sightlangStaticImageToc[26] and sightlangStaticImageToc[27] and sightlangStaticImageToc[28] and sightlangStaticImageToc[29] and sightlangStaticImageToc[30] and sightlangStaticImageToc[31] and sightlangStaticImageToc[32] and sightlangStaticImageToc[33] and sightlangStaticImageToc[34] and sightlangStaticImageToc[35] then
    sightlangStatImgHand = false
    removeEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre)
  end
end
processsightlangStaticImage[0] = function()
  if not isElement(sightlangStaticImage[0]) then
    sightlangStaticImageToc[0] = false
    sightlangStaticImage[0] = dxCreateTexture(":sRadar/files/arrow_shadow.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[1] = function()
  if not isElement(sightlangStaticImage[1]) then
    sightlangStaticImageToc[1] = false
    sightlangStaticImage[1] = dxCreateTexture(":sRadar/files/arrow.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[2] = function()
  if not isElement(sightlangStaticImage[2]) then
    sightlangStaticImageToc[2] = false
    sightlangStaticImage[2] = dxCreateTexture(":sRadar/files/arrow2.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[3] = function()
  if not isElement(sightlangStaticImage[3]) then
    sightlangStaticImageToc[3] = false
    sightlangStaticImage[3] = dxCreateTexture("files/grad2.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[4] = function()
  if not isElement(sightlangStaticImage[4]) then
    sightlangStaticImageToc[4] = false
    sightlangStaticImage[4] = dxCreateTexture("files/grad.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[5] = function()
  if not isElement(sightlangStaticImage[5]) then
    sightlangStaticImageToc[5] = false
    sightlangStaticImage[5] = dxCreateTexture("files/bgshine.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[6] = function()
  if not isElement(sightlangStaticImage[6]) then
    sightlangStaticImageToc[6] = false
    sightlangStaticImage[6] = dxCreateTexture("files/timer.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[7] = function()
  if not isElement(sightlangStaticImage[7]) then
    sightlangStaticImageToc[7] = false
    sightlangStaticImage[7] = dxCreateTexture("files/speedo.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[8] = function()
  if not isElement(sightlangStaticImage[8]) then
    sightlangStaticImageToc[8] = false
    sightlangStaticImage[8] = dxCreateTexture("files/battery.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[9] = function()
  if not isElement(sightlangStaticImage[9]) then
    sightlangStaticImageToc[9] = false
    sightlangStaticImage[9] = dxCreateTexture("files/engine.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[10] = function()
  if not isElement(sightlangStaticImage[10]) then
    sightlangStaticImageToc[10] = false
    sightlangStaticImage[10] = dxCreateTexture("files/fuel.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[11] = function()
  if not isElement(sightlangStaticImage[11]) then
    sightlangStaticImageToc[11] = false
    sightlangStaticImage[11] = dxCreateTexture("files/car1.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[12] = function()
  if not isElement(sightlangStaticImage[12]) then
    sightlangStaticImageToc[12] = false
    sightlangStaticImage[12] = dxCreateTexture("files/car2.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[13] = function()
  if not isElement(sightlangStaticImage[13]) then
    sightlangStaticImageToc[13] = false
    sightlangStaticImage[13] = dxCreateTexture("files/ar1.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[14] = function()
  if not isElement(sightlangStaticImage[14]) then
    sightlangStaticImageToc[14] = false
    sightlangStaticImage[14] = dxCreateTexture("files/ar2.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[15] = function()
  if not isElement(sightlangStaticImage[15]) then
    sightlangStaticImageToc[15] = false
    sightlangStaticImage[15] = dxCreateTexture("files/neonside.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[16] = function()
  if not isElement(sightlangStaticImage[16]) then
    sightlangStaticImageToc[16] = false
    sightlangStaticImage[16] = dxCreateTexture("files/neonfront.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[17] = function()
  if not isElement(sightlangStaticImage[17]) then
    sightlangStaticImageToc[17] = false
    sightlangStaticImage[17] = dxCreateTexture("files/neoncar.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[18] = function()
  if not isElement(sightlangStaticImage[18]) then
    sightlangStaticImageToc[18] = false
    sightlangStaticImage[18] = dxCreateTexture("files/currneon.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[19] = function()
  if not isElement(sightlangStaticImage[19]) then
    sightlangStaticImageToc[19] = false
    sightlangStaticImage[19] = dxCreateTexture("files/neonlight.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[20] = function()
  if not isElement(sightlangStaticImage[20]) then
    sightlangStaticImageToc[20] = false
    sightlangStaticImage[20] = dxCreateTexture("files/neonoff.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[21] = function()
  if not isElement(sightlangStaticImage[21]) then
    sightlangStaticImageToc[21] = false
    sightlangStaticImage[21] = dxCreateTexture("files/4wdr.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[22] = function()
  if not isElement(sightlangStaticImage[22]) then
    sightlangStaticImageToc[22] = false
    sightlangStaticImage[22] = dxCreateTexture("files/4wdf.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[23] = function()
  if not isElement(sightlangStaticImage[23]) then
    sightlangStaticImageToc[23] = false
    sightlangStaticImage[23] = dxCreateTexture("files/4wd1.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[24] = function()
  if not isElement(sightlangStaticImage[24]) then
    sightlangStaticImageToc[24] = false
    sightlangStaticImage[24] = dxCreateTexture("files/dot.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[25] = function()
  if not isElement(sightlangStaticImage[25]) then
    sightlangStaticImageToc[25] = false
    sightlangStaticImage[25] = dxCreateTexture("files/background.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[26] = function()
  if not isElement(sightlangStaticImage[26]) then
    sightlangStaticImageToc[26] = false
    sightlangStaticImage[26] = dxCreateTexture("files/off.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[27] = function()
  if not isElement(sightlangStaticImage[27]) then
    sightlangStaticImageToc[27] = false
    sightlangStaticImage[27] = dxCreateTexture("files/on.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[28] = function()
  if not isElement(sightlangStaticImage[28]) then
    sightlangStaticImageToc[28] = false
    sightlangStaticImage[28] = dxCreateTexture("files/next.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[29] = function()
  if not isElement(sightlangStaticImage[29]) then
    sightlangStaticImageToc[29] = false
    sightlangStaticImage[29] = dxCreateTexture("files/stop.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[30] = function()
  if not isElement(sightlangStaticImage[30]) then
    sightlangStaticImageToc[30] = false
    sightlangStaticImage[30] = dxCreateTexture("files/play.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[31] = function()
  if not isElement(sightlangStaticImage[31]) then
    sightlangStaticImageToc[31] = false
    sightlangStaticImage[31] = dxCreateTexture("files/iconshine.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[32] = function()
  if not isElement(sightlangStaticImage[32]) then
    sightlangStaticImageToc[32] = false
    sightlangStaticImage[32] = dxCreateTexture("files/shine.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[33] = function()
  if not isElement(sightlangStaticImage[33]) then
    sightlangStaticImageToc[33] = false
    sightlangStaticImage[33] = dxCreateTexture("files/radioglass.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[34] = function()
  if not isElement(sightlangStaticImage[34]) then
    sightlangStaticImageToc[34] = false
    sightlangStaticImage[34] = dxCreateTexture("files/scratch.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[35] = function()
  if not isElement(sightlangStaticImage[35]) then
    sightlangStaticImageToc[35] = false
    sightlangStaticImage[35] = dxCreateTexture("files/crash.dds", "argb", true)
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
    local res0 = getResourceFromName("sGui")
    local res1 = getResourceFromName("sRadar")
    if res0 and res1 and getResourceState(res0) == "running" and getResourceState(res1) == "running" then
      gotBlipsEx()
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
local saveIcon = false
local resetIcon = false
local caretIcon = false
local songIcon = false
local radioIcon = false
local listIcon = false
local hw = false
local faTicks = false
local function sightlangGuiRefreshColors()
  local res = getResourceFromName("sGui")
  if res and getResourceState(res) == "running" then
    saveIcon = sightexports.sGui:getFaIconFilename("save", 24)
    resetIcon = sightexports.sGui:getFaIconFilename("undo", 24)
    caretIcon = sightexports.sGui:getFaIconFilename("angle-up", 24)
    songIcon = sightexports.sGui:getFaIconFilename("album-collection", 48, "regular")
    radioIcon = sightexports.sGui:getFaIconFilename("radio", 48)
    listIcon = sightexports.sGui:getFaIconFilename("list", 32)
    hw = sightexports.sGui:getColorCode("hudwhite")
    faTicks = sightexports.sGui:getFaTicks()
    refreshFonts()
    gotBlips()
  end
end
addEventHandler("onGuiRefreshColors", getRootElement(), sightlangGuiRefreshColors)
addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangGuiRefreshColors)
addEventHandler("refreshFaTicks", getRootElement(), function()
  faTicks = sightexports.sGui:getFaTicks()
end)
local sightlangCondHandlState0 = false
local function sightlangCondHandl0(cond, prio)
  cond = cond and true or false
  if cond ~= sightlangCondHandlState0 then
    sightlangCondHandlState0 = cond
    if cond then
      addEventHandler("onClientPreRender", getRootElement(), checkInsideVehicle, true, prio)
    else
      removeEventHandler("onClientPreRender", getRootElement(), checkInsideVehicle)
    end
  end
end
local sightlangStrmMode = true
if sightexports.sDashboard then
  local val = sightexports.sDashboard:getStreamerMode()
  sightlangStrmMode = val
end
local streamerSounds = {}
function sightlangSoundDestroy()
  streamerSounds[source] = nil
end
function setStreamerModeVolume(sound, vol)
  if not sound then
    return
  end
  if not streamerSounds[sound] then
    addEventHandler("onClientElementDestroy", sound, sightlangSoundDestroy)
  end
  streamerSounds[sound] = vol
  setSoundVolume(sound, sightlangStrmMode and 0 or vol)
end
addEventHandler("streamerModeChanged", getRootElement(), function(val)
  sightlangStrmMode = val
  for sound, vol in pairs(streamerSounds) do
    setSoundVolume(sound, val and 0 or vol)
  end
end)
local currentVehicle = false
local vehicleSounds = {}
local radioFavorites = {}
local radioVolume = 1
local scratchLevel = 0
local radioCrashed = false
local radioState = false
local radioOpened = false
local defSoundDistane = 30
local radioWallpaper = 0
local radioBrightness = 0
local disableSystemAudio = false
local fonts = {}
local fontScales = {}
local fontHeights = {}
local currentRadio = 1
local cachedDatas = {}
local monitoredDatas = {}
function deleteMonitoring()
  cachedDatas[source] = nil
  monitoredDatas[source] = nil
end
addEventHandler("onClientVehicleDestroy", getRootElement(), deleteMonitoring)
addEventHandler("onClientVehicleStreamOut", getRootElement(), deleteMonitoring)
addEventHandler("onClientVehicleDataChange", getRootElement(), function(data, old, new)
  if monitoredDatas[source] and monitoredDatas[source][data] then
    cachedDatas[source][data] = new
  end
end)
function getCachedData(veh, data)
  if not monitoredDatas[veh] then
    monitoredDatas[veh] = {}
    cachedDatas[veh] = {}
  end
  if not monitoredDatas[veh][data] then
    monitoredDatas[veh][data] = true
    cachedDatas[veh][data] = getElementData(veh, data)
  end
  return cachedDatas[veh][data]
end
function checkVehicleRadio2D()
  radioState = getCachedData(currentVehicle, "vehradio.state")
  if radioState then
    local station = getCachedData(currentVehicle, "vehradio.station")
    if station then
      currentRadio = station
      if isElement(vehicleSounds[currentVehicle]) then
        destroyElement(vehicleSounds[currentVehicle])
      end
      radioFavorites = getCachedData(currentVehicle, "vehradio.favorites") or {}
      radioVolume = getCachedData(currentVehicle, "vehradio.volume") or 1
      vehicleSounds[currentVehicle] = playSound(stationList[station][1], true)
      setStreamerModeVolume(vehicleSounds[currentVehicle], radioVolume)
      if radioCrashed then
        setSoundEffectEnabled(vehicleSounds[currentVehicle], "distortion", true)
      end
    end
  end
end
addEventHandler("onClientPlayerWasted", localPlayer, function()
  if vehicleSounds[currentVehicle] then
    if isElement(vehicleSounds[currentVehicle]) then
      destroyElement(vehicleSounds[currentVehicle])
    end
    vehicleSounds[currentVehicle] = nil
  end
end)
function checkVehicleRadioWindow(veh)
  if vehicleSounds[veh] then
    local vol = getCachedData(veh, "vehradio.volume") or 1
    local dist = defSoundDistane
    setSoundMinDistance(vehicleSounds[veh], 1.25)
    if getCachedData(veh, "vehicle.windowState") then
      setSoundEffectEnabled(vehicleSounds[veh], "i3dl2reverb", false)
      setSoundEffectEnabled(vehicleSounds[veh], "compressor", false)
      if getCachedData(veh, "vehradio.broken") then
        setSoundEffectEnabled(vehicleSounds[veh], "distortion", true)
      else
        setSoundEffectEnabled(vehicleSounds[veh], "distortion", false)
      end
    else
      vol = vol * 0.25
      dist = dist * 0.5
      setSoundEffectEnabled(vehicleSounds[veh], "i3dl2reverb", true)
      setSoundEffectEnabled(vehicleSounds[veh], "compressor", true)
      setSoundEffectEnabled(vehicleSounds[veh], "distortion", false)
    end
    setStreamerModeVolume(vehicleSounds[veh], vol)
    setSoundMaxDistance(vehicleSounds[veh], dist)
  end
end
function checkVehicleRadio3D(veh, exit)
  if isElementStreamedIn(veh) and (veh ~= currentVehicle or exit) then
    local state = getCachedData(veh, "vehradio.state")
    if state then
      local station = getCachedData(veh, "vehradio.station")
      if station then
        if isElement(vehicleSounds[veh]) then
          destroyElement(vehicleSounds[veh])
        end
        local x, y, z = getElementPosition(veh)
        vehicleSounds[veh] = playSound3D(stationList[station][1], x, y, z, true)
        setElementDimension(vehicleSounds[veh], getElementDimension(veh))
        setElementInterior(vehicleSounds[veh], getElementInterior(veh))
        checkVehicleRadioWindow(veh)
        attachElements(vehicleSounds[veh], veh)
      else
        if isElement(vehicleSounds[veh]) then
          destroyElement(vehicleSounds[veh])
        end
        vehicleSounds[veh] = nil
      end
    else
      if isElement(vehicleSounds[veh]) then
        destroyElement(vehicleSounds[veh])
      end
      vehicleSounds[veh] = nil
    end
  end
end
local favoriteSetTimer = false
local volumeTimer = false
function refreshFonts()
  fonts["18/Ubuntu-B.ttf"] = sightexports.sGui:getFont("18/Ubuntu-B.ttf")
  fontScales["18/Ubuntu-B.ttf"] = sightexports.sGui:getFontScale("18/Ubuntu-B.ttf")
  fontHeights["18/Ubuntu-B.ttf"] = sightexports.sGui:getFontHeight("18/Ubuntu-B.ttf")
  fonts["16/Ubuntu-R.ttf"] = sightexports.sGui:getFont("16/Ubuntu-R.ttf")
  fontScales["16/Ubuntu-R.ttf"] = sightexports.sGui:getFontScale("16/Ubuntu-R.ttf")
  fontHeights["16/Ubuntu-R.ttf"] = sightexports.sGui:getFontHeight("16/Ubuntu-R.ttf")
end
addEventHandler("onClientResourceStart", getResourceRootElement(), function()
  local veh = getPedOccupiedVehicle(localPlayer)
  if veh then
    vehicleEnter(veh)
  end
end)
local vehs = getElementsByType("vehicle", getRootElement(), true)
for k = 1, #vehs do
  checkVehicleRadio3D(vehs[k])
end
function vehicleEnter(veh)
  if currentVehicle then
    onPlayerVehicleExit()
  end
  local vt = getVehicleType(veh)
  if vt == "Automobile" or vt == "Quad" or vt == "Bike" then
    currentVehicle = veh
    if isElement(currentVehicle) then
      currentRadio = getCachedData(currentVehicle, "vehradio.station") or 1
    end
    radioCrashed = getCachedData(currentVehicle, "vehradio.broken")
    currentHover = false
    triggerServerEvent("requestECUData", currentVehicle)
    triggerServerEvent("requestAirrideData", currentVehicle)
    triggerServerEvent("requestNeonData", currentVehicle)
    triggerServerEvent("requestDriveTypeData", currentVehicle)
    triggerServerEvent("requestJourneyData", currentVehicle)
    checkVehicleRadio2D()
    sightlangCondHandl0(true)
  else
    currentVehicle = false
  end
end
addEventHandler("onClientPlayerVehicleEnter", localPlayer, function(veh, seat)
  vehicleEnter(veh)
end)
addEventHandler("onClientVehicleStreamOut", getRootElement(), function()
  if source ~= currentVehicle then
    if isElement(vehicleSounds[source]) then
      destroyElement(vehicleSounds[source])
    end
    vehicleSounds[source] = nil
  end
end)
addEventHandler("onClientVehicleStreamIn", getRootElement(), function()
  checkVehicleRadio3D(source)
end)
addEventHandler("onClientVehicleDestroy", getRootElement(), function()
  if isElement(vehicleSounds[source]) then
    destroyElement(vehicleSounds[source])
  end
  vehicleSounds[source] = nil
  if source == currentVehicle then
    onPlayerVehicleExit(true)
  end
end)
function onPlayerVehicleExit(exit)
  sightlangCondHandl0(false)
  if currentVehicle then
    if isElement(vehicleSounds[currentVehicle]) then
      destroyElement(vehicleSounds[currentVehicle])
    end
    vehicleSounds[currentVehicle] = nil
    if not exit then
      checkVehicleRadio3D(currentVehicle, true)
    end
  end
  if isTimer(favoriteSetTimer) then
    killTimer(favoriteSetTimer)
  end
  favoriteSetTimer = false
  if isTimer(volumeTimer) then
    killTimer(volumeTimer)
  end
  volumeTimer = false
  currentVehicle = false
  if radioOpened then
    toggleRadio()
  end
end
addEventHandler("onClientPlayerVehicleExit", localPlayer, onPlayerVehicleExit)
screenX, screenY = guiGetScreenSize()
local sizeX = 652
local sizeY = 332
local radioX, radioY = math.floor(screenX / 2 - sizeX / 2), math.floor(screenY / 5)
local lastCurrentMenu = "off"
local currentMenu = "off"
local radioListScroll = 0
local radioOn = 0
local menuChange = 0
local ecuBalanceValue = false
local savedEcuBalanceValue = false
local ecuValues = false
local savedEcuValues = false
function setMenu(menu)
  if currentMenu == "on" and menu == "home" then
    radioOn = getTickCount()
  end
  lastCurrentMenu = currentMenu
  currentMenu = menu
  menuChange = getTickCount()
  if menu == "on" then
    radioOn = getTickCount()
  end
end
local radioChangeDir = false
local currentRadioChange = false
local lastStationName = false
local lastStationWidth = 0
local stationName = ""
local stationWidth = 0
local currentSongChange = false
local lastCurrentSong = false
local lastCurrentWidth = 0
local currentSong = ""
local currentWidth = 0
local currentHover = false
local volumeSet = false
local menus = {
  "radio",
  "navigation",
  "settings",
  "computer",
  "neon",
  "airride",
  "ecu",
  "awd"
}
local menuTitles = {
  "Rádió",
  "Navigáció",
  "Beállítások",
  "Computer",
  "Neon",
  "AirRide",
  "SightECU",
  "Meghajtás"
}
function drawBcg(x, y, progress)
  if radioWallpaper == 0 then
    dxDrawRectangle(x, y, 538, 293, tocolor(17, 20, 32, 255 * progress))
  else
    dxDrawImage(x, y, 538, 293, dynamicImage("files/wp/" .. radioWallpaper .. ".dds"), 0, 0, 0, tocolor(255, 255, 255, 255 * progress))
  end
  if radioBrightness < 6 then
    local a = (6 - radioBrightness) / 6 * 110
    dxDrawRectangle(x, y, 538, 293, tocolor(10, 10, 10, a * progress))
  end
end
local journeyTime = 0
local journeyTimestamp = 0
local journeyDistance = 0
local journeyGotDistance = 0
local currentOdomoter = 0
local journeyAvgSpeed = 0
local lastOdometerSync = 0
addEvent("syncOdometer", true)
addEventHandler("syncOdometer", getRootElement(), function(data)
  currentOdomoter = data
  local jTime = journeyTime + getRealTime().timestamp - journeyTimestamp
  local jDist = journeyGotDistance + currentOdomoter - journeyDistance
  journeyAvgSpeed = math.floor(jDist / (jTime / 3600) * 10 + 0.5) / 10
end)
addEvent("gotJourneyData", true)
addEventHandler("gotJourneyData", getRootElement(), function(time, distance)
  if source == currentVehicle then
    journeyTime = time
    journeyTimestamp = getRealTime().timestamp
    journeyDistance = currentOdomoter
    journeyGotDistance = distance
    local jTime = journeyTime
    local jDist = journeyGotDistance + currentOdomoter - journeyDistance
    journeyAvgSpeed = math.floor(jDist / (jTime / 3600) * 10 + 0.5) / 10
  end
end)
local oilLevel = 10000
addEvent("gotVehicleOilLevel", true)
addEventHandler("gotVehicleOilLevel", getRootElement(), function(level)
  if source == currentVehicle then
    oilLevel = level
  end
end)
local batteryCharge = 2048
local maxBatteryCharge = 2048
local factoryMaxBatteryCharge = 2048
local batteryRate = 0
local starterValue = 256
addEvent("gotVehicleBatteryCharge", true)
addEventHandler("gotVehicleBatteryCharge", getRootElement(), function(level, max, factoryMax, rate)
  if source == currentVehicle then
    batteryCharge = level
    maxBatteryCharge = max
    factoryMaxBatteryCharge = factoryMax
    batteryRate = rate
    starterValue = math.abs(sightexports.sVehicles:getBatteryValues(currentVehicle, "starter")) / 60
  end
end)
local fuelLiters = 80
local fuelMaxLiters = 80
local fuelConsumption = 10
addEvent("gotVehicleFuelLevel", true)
addEventHandler("gotVehicleFuelLevel", getRootElement(), function(level)
  if source == currentVehicle then
    fuelLiters = level
  end
end)
function rotate(px, py, pz, pitch, roll, yaw)
  local cosa = math.cos(math.rad(yaw))
  local sina = math.sin(math.rad(yaw))
  local cosb = math.cos(math.rad(pitch))
  local sinb = math.sin(math.rad(pitch))
  local cosc = math.cos(math.rad(roll))
  local sinc = math.sin(math.rad(roll))
  local Axx = cosa * cosb
  local Axy = cosa * sinb * sinc - sina * cosc
  local Axz = cosa * sinb * cosc + sina * sinc
  local Ayx = sina * cosb
  local Ayy = sina * sinb * sinc + cosa * cosc
  local Ayz = sina * sinb * cosc - cosa * sinc
  local Azx = -sinb
  local Azy = cosb * sinc
  local Azz = cosb * cosc
  return Axx * px + Axy * py + Axz * pz, Ayx * px + Ayy * py + Ayz * pz, Azx * px + Azy * py + Azz * pz
end
local focal = 1024
function projection(x, y, z, size)
  size = size * 2
  local tana = size / 2 / focal
  local oX = x / z * (size / 2 / tana)
  local oY = y / z * (size / 2 / tana)
  return oX, oY
end
local radarRot = -65
function calculateInnerSize(radarSizeX)
  local x, y, z = rotate(-radarSizeX / 2, 0, 0, 0, radarRot, 0)
  z = z + focal
  minX, minY = projection(x, y, z, radarSizeX)
  minX = math.abs(minX * 2) * 0.75
  return radarSizeX / minX * radarSizeX
end
local radarInnerSize = math.ceil(calculateInnerSize(538) * 1.75)
local rtSize = math.ceil(math.sqrt(math.pow(radarInnerSize, 2) + math.pow(radarInnerSize, 2)) * 1.05)
local blankShader = [[
texture texture0;

sampler implicitInputTexture = sampler_state 
{ 
	Texture = <texture0>; 
}; 
  
float4 Blank( float2 uv : TEXCOORD0 ) : COLOR0 
{ 
	 
	float4 sampledTexture = tex2D( implicitInputTexture, uv ); 
	return sampledTexture; 
} 
  
technique Technique1 
{ 
	pass Pass1 
	{ 
		PixelShader = compile ps_2_0 Blank(); 
	} 
} 
]]
local baseRt = false
local playerRt = false
local baseShader = false
local radarZoom = 1
local radarW = 522
local radarH = 293
local finalRt = false
local radioMove = false
local blips = {}
local blipGroups = {}
local blipSize = 28
local targetBlipSize = 32
local targetBlipIcon = false
local targetBlipAlpha = 255
local gpsLineColor = tocolor(255, 255, 255)
local blipColor = tocolor(255, 255, 255)
local blipShadow = tocolor(0, 0, 0)
local gotBlipsReady = false
function gotBlips()
  if gotBlipsReady then
    gpsLineColor = sightexports.sGui:getColorSetCodeToColor("sightyellow", 1)
    blipShadow = sightexports.sGui:getColorSetCodeToColor("sightgrey2", 1)
    blipColor = sightexports.sGui:getColorCodeToColor("#ffffff")
    targetBlipIcon = sightexports.sGui:getFaIconFilename("map-marker-alt", targetBlipSize, "solid", false, blipShadow, blipColor)
    blips = {}
    local black = sightexports.sGui:getColorCodeToColor("#000000")
    local hudwhite = sightexports.sGui:getColorCodeToColor("#ffffff")
    local dataIn = sightexports.sRadar:getBlipList()
    for k = 1, #dataIn do
      local data = dataIn[k]
      if #data == 5 or #data == 6 then
        local dat = {
          tonumber(data[1]),
          tonumber(data[2])
        }
        local name = data[3] .. data[#data - 1] .. data[#data]
        local blipColor = sightexports.sGui:getColorSetCodeToColor(data[#data - 1], 1)
        local shadow = blipShadow
        local border = false
        dat[3] = sightexports.sGui:getFaIconFilename(data[3], blipSize, #data == 6 and data[4] or false, false, shadow, blipColor, border)
        dat[4] = blipSize
        dat[5] = {
          255,
          255,
          255
        }
        dat[6] = false
        dat[7] = data[#data]
        dat[8] = name
        if not dat[5] then
          dat[5] = {}
        end
        dat[5][4] = blipAlpha
        table.insert(blips, dat)
      end
    end
  end
end
function gotBlipsEx()
  gotBlipsReady = true
  gotBlips()
end
function renderRadar()
  dxSetRenderTarget(baseRt, true)
  dxSetBlendMode("modulate_add")
  local px, py, pz = getElementPosition(localPlayer)
  local rx, ry, rz = getElementRotation(localPlayer)
  x = (px + 3000) / 6000 * 3072
  y = (py * -1 + 3000) / 6000 * 3072
  local mapAngle = rz
  local mapAngleRad = math.rad(mapAngle)
  local mapAngleCos = math.cos(mapAngleRad)
  local mapAngleSin = math.sin(mapAngleRad)
  local size = rtSize / radarZoom
  local radar = false
  radar = dynamicImage("files/radar.dds", "dxt1")
  dxSetTextureEdge(radar, "border", tocolor(128, 166, 205))
  dxDrawImageSection(radarInnerSize / 2 - rtSize / 2, radarInnerSize / 2 - rtSize / 2, rtSize, rtSize, x - size / 2, y - size / 2, size, size, radar, mapAngle)
  local navc = tocolor(60, 143, 184)
  local inNav = sightexports.sGps:drawRadioRoute(radarInnerSize / 2, rtSize, px, py, radarZoom, mapAngleSin, mapAngleCos, navc)
  dxSetRenderTarget(playerRt, true)
  dxSetBlendMode("modulate_add")
  sightlangStaticImageUsed[0] = true
  if sightlangStaticImageToc[0] then
    processsightlangStaticImage[0]()
  end
  dxDrawImage(0, 0, 41, 43, sightlangStaticImage[0], 0, 0, 0, tocolor(0, 0, 0, 165.75))
  sightlangStaticImageUsed[1] = true
  if sightlangStaticImageToc[1] then
    processsightlangStaticImage[1]()
  end
  dxDrawImage(0, 0, 41, 43, sightlangStaticImage[1], 0, 0, 0, inNav and navc or tocolor(60, 184, 130))
  sightlangStaticImageUsed[2] = true
  if sightlangStaticImageToc[2] then
    processsightlangStaticImage[2]()
  end
  dxDrawImage(0, 0, 41, 43, sightlangStaticImage[2], 0, 0, 0, inNav and navc or tocolor(60, 184, 130))
  dxSetRenderTarget(finalRt, true)
  dxSetBlendMode("modulate_add")
  local x, y = -(radarInnerSize / 2 - radarW / 2), -(radarInnerSize / 2 - radarH / 2) + 90
  dxDrawImage(x, y, radarInnerSize, radarInnerSize, baseShader)
  local cx, cy = x + radarInnerSize / 2, y + radarInnerSize / 2
  local px, py, pz = getElementPosition(localPlayer)
  local blipZoom = (radarZoom - 1) * 0.5 + 1
  local blipElements = getElementsByType("blip")
  local blipTexts = {}
  for k = 1, #blips + #blipElements do
    local data = false
    if k > #blips then
      local i = k - #blips
      local element = blipElements[i]
      local x, y = getElementPosition(element)
      local r, g, b = getBlipColor(element)
      data = {
        x,
        y,
        targetBlipIcon,
        targetBlipSize,
        {
          r,
          g,
          b,
          targetBlipAlpha
        },
        true,
        false,
        "target",
        true
      }
    else
      data = blips[k]
    end
    if data then
      local pointX = data[1] - px
      local pointY = py - data[2]
      local size = rtSize / radarZoom
      if size > math.abs(pointX) and size > math.abs(pointY) then
        if pointX < -size * 0.75 then
          pointX = -size * 0.75
        end
        if pointY < -size * 0.75 then
          pointY = -size * 0.75
        end
        if pointX > size * 0.75 then
          pointX = size * 0.75
        end
        if pointY > size * 0.75 then
          pointY = size * 0.75
        end
        pointX = pointX / 6000 * 3072 * radarZoom
        pointY = pointY / 6000 * 3072 * radarZoom
        local x = pointX * mapAngleCos - pointY * mapAngleSin
        local y = pointX * mapAngleSin + pointY * mapAngleCos
        local z = 0
        if data[9] then
          y = y - data[4] * blipZoom * 0.55
        end
        x, y, z = rotate(x, y, z, 0, radarRot, 0)
        z = z + focal
        x, y = projection(x, y, z, radarInnerSize)
        local color = tocolor(data[5][1], data[5][2], data[5][3], data[5][4])
        dxDrawImage(cx + x - data[4] * blipZoom / 2, cy + y - data[4] * blipZoom / 2, data[4] * blipZoom, data[4] * blipZoom, ":sGui/" .. data[3] .. (faTicks[data[3]] or ""), 0, 0, 0, color)
        if data[7] then
          table.insert(blipTexts, {
            data[7],
            cx + x,
            cy + y - data[4] * blipZoom / 2
          })
        end
      end
    end
  end
  dxDrawImage(cx - 25.625, cy - 26.875, 51.25, 53.75, playerShader)
  for k = 1, #blipTexts do
    dxDrawText(blipTexts[k][1], blipTexts[k][2] + 1, 0, blipTexts[k][2] + 1, blipTexts[k][3] + 1, blipShadow, 0.85 * blipZoom * fontScales["11/Ubuntu-L.ttf"], fonts["11/Ubuntu-L.ttf"], "center", "bottom")
    dxDrawText(blipTexts[k][1], blipTexts[k][2], 0, blipTexts[k][2], blipTexts[k][3], tocolor(255, 255, 255), 0.85 * blipZoom * fontScales["11/Ubuntu-L.ttf"], fonts["11/Ubuntu-L.ttf"], "center", "bottom")
  end
  local bx, by, bz = 0, -radarInnerSize / 2, 0
  bx, by, bz = rotate(bx, by, bz, 0, radarRot, 0)
  bz = bz + focal
  bx, by = projection(bx, by, bz, radarInnerSize)
  local hin = math.ceil(radarInnerSize / 2 + by)
  dxDrawRectangle(x, math.ceil(y), radarInnerSize, hin, tocolor(128, 166, 205, 255))
  sightlangStaticImageUsed[3] = true
  if sightlangStaticImageToc[3] then
    processsightlangStaticImage[3]()
  end
  dxDrawImage(x, math.ceil(y) + hin, radarInnerSize, 32, sightlangStaticImage[3], 180, 0, 0, tocolor(128, 166, 205, 255))
  if inNav then
    local sy = hin + y + 8
    sightexports.sGps:drawGPSInstructions(0, 4, radarW, sy, sy, false)
  end
  dxSetBlendMode("blend")
  dxSetRenderTarget()
end
local function electricVehicle(vehicleElement)
  if electricVehicles[getElementData(vehicleElement, "vehicle.customModel")] then
    return true
  end
  return false
end
function drawComputer(rt, month, monthday, hour, minute, x, y, progress)
  drawBcg(x, y, progress)
  dxDrawText(rt.year - 100 .. "." .. month .. "." .. monthday .. " | " .. hour .. ":" .. minute, 0, y + 4, x + 538 - 8, 0, tocolor(255, 255, 255, 255 * progress), fontScales["11/Ubuntu-L.ttf"], fonts["11/Ubuntu-L.ttf"], "right", "top")
  x = x + 8
  dxDrawText("Computer", x, y, 0, 0, tocolor(255, 255, 255, 255 * progress), fontScales["15/BebasNeueBold.otf"], fonts["15/BebasNeueBold.otf"], "left", "top")
  y = y + fontHeights["15/BebasNeueBold.otf"] + 2
  sightlangStaticImageUsed[4] = true
  if sightlangStaticImageToc[4] then
    processsightlangStaticImage[4]()
  end
  dxDrawImage(x, y, math.floor(256), 2, sightlangStaticImage[4], 0, 0, 0, tocolor(60, 184, 130, 255 * progress))
  y = y + 8
  x = x - 4
  local w = 176.66666666666666
  local h = math.floor((293 - (y - (radioY + 19)) - 4) / 3)
  local id = 0
  local ts = getRealTime().timestamp
  local jTime = journeyTime + ts - journeyTimestamp
  local jDist = math.floor((journeyGotDistance + currentOdomoter - journeyDistance) * 10 + 0.5) / 10
  local engine = getVehicleEngineState(currentVehicle)
  for j = 1, 3 do
    for i = 1, 3 do
      local px, py = x + w * (i - 1) + 4, y + h * (j - 1) + 4
      if electricVehicle(currentVehicle) and id >= 3 then
        return
      end
      dxDrawRectangle(px, py, w - 8, h - 8, tocolor(34, 38, 42, 200 * progress))
      id = id + 1
      if id == 1 then
        sightlangStaticImageUsed[5] = true
        if sightlangStaticImageToc[5] then
          processsightlangStaticImage[5]()
        end
        dxDrawImage(px, py, w - 8, h - 8, sightlangStaticImage[5], 0, 0, 0, tocolor(255, 255, 255, 75 * progress))
        dxDrawText("Indítás óta eltelt idő", px + 4, py + 2, 0, 0, tocolor(255, 255, 255, 200 * progress), fontScales["11/Ubuntu-L.ttf"] * 0.9, fonts["11/Ubuntu-L.ttf"], "left", "top")
        if engine then
          local sec = jTime
          local hour = math.floor(sec / 3600)
          sec = sec - hour * 3600
          local minute = math.floor(sec / 60)
          sec = sec - minute * 60
          if 2 > utf8.len(hour) then
            hour = "0" .. hour
          end
          if 2 > utf8.len(minute) then
            minute = "0" .. minute
          end
          if 2 > utf8.len(sec) then
            sec = "0" .. sec
          end
          dxDrawText(hour .. ":" .. minute .. ":" .. sec, 0, 0, px + w - 8 - 4, py + h - 8 - 2, tocolor(255, 255, 255, 255 * progress), fontScales["22/BebasNeueBold.otf"], fonts["22/BebasNeueBold.otf"], "right", "bottom")
        else
          dxDrawText("---", 0, 0, px + w - 8 - 4, py + h - 8 - 2, tocolor(255, 255, 255, 255 * progress), fontScales["22/BebasNeueBold.otf"], fonts["22/BebasNeueBold.otf"], "right", "bottom")
        end
        sightlangStaticImageUsed[6] = true
        if sightlangStaticImageToc[6] then
          processsightlangStaticImage[6]()
        end
        dxDrawImage(px, py + h - 8 - 40, 40, 40, sightlangStaticImage[6], 0, 0, 0, tocolor(255, 255, 255, 255 * progress))
      elseif id == 2 then
        sightlangStaticImageUsed[5] = true
        if sightlangStaticImageToc[5] then
          processsightlangStaticImage[5]()
        end
        dxDrawImage(px, py, w - 8, h - 8, sightlangStaticImage[5], 0, 0, 0, tocolor(255, 255, 255, 75 * progress))
        dxDrawText("Indítás óta megtett út ", px + 4, py + 2, 0, 0, tocolor(255, 255, 255, 200 * progress), fontScales["11/Ubuntu-L.ttf"] * 0.9, fonts["11/Ubuntu-L.ttf"], "left", "top")
        dxDrawText(" km", 0, 0, px + w - 8 - 4, py + h - 8 - 2, tocolor(255, 255, 255, 255 * progress), fontScales["15/BebasNeueBold.otf"], fonts["15/BebasNeueBold.otf"], "right", "bottom")
        if engine then
          dxDrawText(jDist, 0, 0, px + w - 8 - 4 - dxGetTextWidth(" km", fontScales["15/BebasNeueBold.otf"], fonts["15/BebasNeueBold.otf"]), py + h - 8 - 2, tocolor(255, 255, 255, 255 * progress), fontScales["22/BebasNeueBold.otf"], fonts["22/BebasNeueBold.otf"], "right", "bottom")
        else
          dxDrawText("---", 0, 0, px + w - 8 - 4 - dxGetTextWidth(" km", fontScales["15/BebasNeueBold.otf"], fonts["15/BebasNeueBold.otf"]), py + h - 8 - 2, tocolor(255, 255, 255, 255 * progress), fontScales["22/BebasNeueBold.otf"], fonts["22/BebasNeueBold.otf"], "right", "bottom")
        end
        sightlangStaticImageUsed[6] = true
        if sightlangStaticImageToc[6] then
          processsightlangStaticImage[6]()
        end
        dxDrawImage(px, py + h - 8 - 40, 40, 40, sightlangStaticImage[6], 0, 0, 0, tocolor(255, 255, 255, 255 * progress))
      elseif id == 3 then
        sightlangStaticImageUsed[5] = true
        if sightlangStaticImageToc[5] then
          processsightlangStaticImage[5]()
        end
        dxDrawImage(px, py, w - 8, h - 8, sightlangStaticImage[5], 0, 0, 0, tocolor(255, 255, 255, 75 * progress))
        dxDrawText("Átl. sebesség (indítás óta)", px + 4, py + 2, 0, 0, tocolor(255, 255, 255, 200 * progress), fontScales["11/Ubuntu-L.ttf"] * 0.9, fonts["11/Ubuntu-L.ttf"], "left", "top")
        dxDrawText(" km/h", 0, 0, px + w - 8 - 4, py + h - 8 - 2, tocolor(255, 255, 255, 255 * progress), fontScales["15/BebasNeueBold.otf"], fonts["15/BebasNeueBold.otf"], "right", "bottom")
        if 2 < ts - lastOdometerSync then
          triggerEvent("requestOdometerSync", currentVehicle)
          lastOdometerSync = ts
        end
        if 0 < jDist and 1 <= jTime and engine then
          dxDrawText(journeyAvgSpeed, 0, 0, px + w - 8 - 4 - dxGetTextWidth(" km/h", fontScales["15/BebasNeueBold.otf"], fonts["15/BebasNeueBold.otf"]), py + h - 8 - 2, tocolor(255, 255, 255, 255 * progress), fontScales["22/BebasNeueBold.otf"], fonts["22/BebasNeueBold.otf"], "right", "bottom")
        else
          dxDrawText("---", 0, 0, px + w - 8 - 4 - dxGetTextWidth(" km/h", fontScales["15/BebasNeueBold.otf"], fonts["15/BebasNeueBold.otf"]), py + h - 8 - 2, tocolor(255, 255, 255, 255 * progress), fontScales["22/BebasNeueBold.otf"], fonts["22/BebasNeueBold.otf"], "right", "bottom")
        end
        sightlangStaticImageUsed[7] = true
        if sightlangStaticImageToc[7] then
          processsightlangStaticImage[7]()
        end
        dxDrawImage(px, py + h - 8 - 40, 40, 40, sightlangStaticImage[7], 0, 0, 0, tocolor(255, 255, 255, 255 * progress))
      elseif id == 4 then
        local r, g, b = 255, 255, 255
        local val = math.floor(batteryCharge / maxBatteryCharge * 100 + 0.5)
        if batteryCharge <= starterValue * 2 then
          r, g, b = 243, 90, 90
        elseif batteryCharge < starterValue * 6 then
          r, g, b = 243, 214, 90
        end
        sightlangStaticImageUsed[5] = true
        if sightlangStaticImageToc[5] then
          processsightlangStaticImage[5]()
        end
        dxDrawImage(px, py, w - 8, h - 8, sightlangStaticImage[5], 0, 0, 0, tocolor(r, g, b, 75 * progress))
        local rateText = math.floor(batteryRate / maxBatteryCharge * 100 * 10 + 0.5) / 10
        if 0 < rateText then
          rateText = "+" .. rateText
        end
        dxDrawText("Akkumulátor töltöttség\n(" .. rateText .. "%/min)", px + 4, py + 2, 0, 0, tocolor(r, g, b, 200 * progress), fontScales["11/Ubuntu-L.ttf"] * 0.9, fonts["11/Ubuntu-L.ttf"], "left", "top")
        dxDrawText(" %", 0, 0, px + w - 8 - 4, py + h - 8 - 2, tocolor(r, g, b, 255 * progress), fontScales["15/BebasNeueBold.otf"], fonts["15/BebasNeueBold.otf"], "right", "bottom")
        dxDrawText(val, 0, 0, px + w - 8 - 4 - dxGetTextWidth(" %", fontScales["15/BebasNeueBold.otf"], fonts["15/BebasNeueBold.otf"]), py + h - 8 - 2, tocolor(r, g, b, 255 * progress), fontScales["22/BebasNeueBold.otf"], fonts["22/BebasNeueBold.otf"], "right", "bottom")
        sightlangStaticImageUsed[8] = true
        if sightlangStaticImageToc[8] then
          processsightlangStaticImage[8]()
        end
        dxDrawImage(px, py + h - 8 - 40, 40, 40, sightlangStaticImage[8], 0, 0, 0, tocolor(r, g, b, 255 * progress))
      elseif id == 5 then
        local r, g, b = 255, 255, 255
        local val = math.floor(maxBatteryCharge / factoryMaxBatteryCharge * 100 + 0.5)
        if val <= 25 then
          r, g, b = 243, 90, 90
        elseif val <= 50 then
          r, g, b = 243, 214, 90
        end
        sightlangStaticImageUsed[5] = true
        if sightlangStaticImageToc[5] then
          processsightlangStaticImage[5]()
        end
        dxDrawImage(px, py, w - 8, h - 8, sightlangStaticImage[5], 0, 0, 0, tocolor(r, g, b, 75 * progress))
        dxDrawText("Akkumulátor állapot", px + 4, py + 2, 0, 0, tocolor(r, g, b, 200 * progress), fontScales["11/Ubuntu-L.ttf"] * 0.9, fonts["11/Ubuntu-L.ttf"], "left", "top")
        dxDrawText(" %", 0, 0, px + w - 8 - 4, py + h - 8 - 2, tocolor(r, g, b, 255 * progress), fontScales["15/BebasNeueBold.otf"], fonts["15/BebasNeueBold.otf"], "right", "bottom")
        dxDrawText(val, 0, 0, px + w - 8 - 4 - dxGetTextWidth(" %", fontScales["15/BebasNeueBold.otf"], fonts["15/BebasNeueBold.otf"]), py + h - 8 - 2, tocolor(r, g, b, 255 * progress), fontScales["22/BebasNeueBold.otf"], fonts["22/BebasNeueBold.otf"], "right", "bottom")
        sightlangStaticImageUsed[8] = true
        if sightlangStaticImageToc[8] then
          processsightlangStaticImage[8]()
        end
        dxDrawImage(px, py + h - 8 - 40, 40, 40, sightlangStaticImage[8], 0, 0, 0, tocolor(r, g, b, 255 * progress))
      elseif id == 6 then
        local r, g, b = 255, 255, 255
        local val = math.floor(oilLevel + 0.5)
        if val <= 0 then
          r, g, b = 243, 90, 90
        elseif val <= 100 then
          r, g, b = 243, 214, 90
        end
        sightlangStaticImageUsed[5] = true
        if sightlangStaticImageToc[5] then
          processsightlangStaticImage[5]()
        end
        dxDrawImage(px, py, w - 8, h - 8, sightlangStaticImage[5], 0, 0, 0, tocolor(r, g, b, 75 * progress))
        dxDrawText("Következő olajcsere", px + 4, py + 2, 0, 0, tocolor(r, g, b, 200 * progress), fontScales["11/Ubuntu-L.ttf"] * 0.9, fonts["11/Ubuntu-L.ttf"], "left", "top")
        dxDrawText(" km", 0, 0, px + w - 8 - 4, py + h - 8 - 2, tocolor(r, g, b, 255 * progress), fontScales["15/BebasNeueBold.otf"], fonts["15/BebasNeueBold.otf"], "right", "bottom")
        dxDrawText(val, 0, 0, px + w - 8 - 4 - dxGetTextWidth(" km", fontScales["15/BebasNeueBold.otf"], fonts["15/BebasNeueBold.otf"]), py + h - 8 - 2, tocolor(r, g, b, 255 * progress), fontScales["22/BebasNeueBold.otf"], fonts["22/BebasNeueBold.otf"], "right", "bottom")
        sightlangStaticImageUsed[9] = true
        if sightlangStaticImageToc[9] then
          processsightlangStaticImage[9]()
        end
        dxDrawImage(px, py + h - 8 - 40, 40, 40, sightlangStaticImage[9], 0, 0, 0, tocolor(r, g, b, 255 * progress))
      elseif id == 7 then
        local r, g, b = 255, 255, 255
        local val = fuelLiters
        local max = fuelMaxLiters
        if val / max <= 0.1 then
          r, g, b = 243, 90, 90
        elseif val / max <= 0.15 then
          r, g, b = 243, 214, 90
        end
        sightlangStaticImageUsed[5] = true
        if sightlangStaticImageToc[5] then
          processsightlangStaticImage[5]()
        end
        dxDrawImage(px, py, w - 8, h - 8, sightlangStaticImage[5], 0, 0, 0, tocolor(r, g, b, 75 * progress))
        dxDrawText("Üzemanyag", px + 4, py + 2, 0, 0, tocolor(r, g, b, 200 * progress), fontScales["11/Ubuntu-L.ttf"] * 0.9, fonts["11/Ubuntu-L.ttf"], "left", "top")
        dxDrawText("/" .. math.floor(max + 0.5) .. " L", 0, 0, px + w - 8 - 4, py + h - 8 - 2, tocolor(r, g, b, 255 * progress), fontScales["15/BebasNeueBold.otf"], fonts["15/BebasNeueBold.otf"], "right", "bottom")
        dxDrawText(math.floor(val + 0.5), 0, 0, px + w - 8 - 4 - dxGetTextWidth("/" .. max .. " L", fontScales["15/BebasNeueBold.otf"], fonts["15/BebasNeueBold.otf"]), py + h - 8 - 2, tocolor(r, g, b, 255 * progress), fontScales["22/BebasNeueBold.otf"], fonts["22/BebasNeueBold.otf"], "right", "bottom")
        sightlangStaticImageUsed[10] = true
        if sightlangStaticImageToc[10] then
          processsightlangStaticImage[10]()
        end
        dxDrawImage(px, py + h - 8 - 40, 40, 40, sightlangStaticImage[10], 0, 0, 0, tocolor(r, g, b, 255 * progress))
      elseif id == 8 then
        sightlangStaticImageUsed[5] = true
        if sightlangStaticImageToc[5] then
          processsightlangStaticImage[5]()
        end
        dxDrawImage(px, py, w - 8, h - 8, sightlangStaticImage[5], 0, 0, 0, tocolor(255, 255, 255, 75 * progress))
        dxDrawText("Üzemanyag fogyasztás", px + 4, py + 2, 0, 0, tocolor(255, 255, 255, 200 * progress), fontScales["11/Ubuntu-L.ttf"] * 0.9, fonts["11/Ubuntu-L.ttf"], "left", "top")
        dxDrawText(" L/100km", 0, 0, px + w - 8 - 4, py + h - 8 - 2, tocolor(255, 255, 255, 255 * progress), fontScales["15/BebasNeueBold.otf"], fonts["15/BebasNeueBold.otf"], "right", "bottom")
        dxDrawText(fuelConsumption, 0, 0, px + w - 8 - 4 - dxGetTextWidth(" L/100km", fontScales["15/BebasNeueBold.otf"], fonts["15/BebasNeueBold.otf"]), py + h - 8 - 2, tocolor(255, 255, 255, 255 * progress), fontScales["22/BebasNeueBold.otf"], fonts["22/BebasNeueBold.otf"], "right", "bottom")
        sightlangStaticImageUsed[10] = true
        if sightlangStaticImageToc[10] then
          processsightlangStaticImage[10]()
        end
        dxDrawImage(px, py + h - 8 - 40, 40, 40, sightlangStaticImage[10], 0, 0, 0, tocolor(255, 255, 255, 255 * progress))
      elseif id == 9 then
        local r, g, b = 255, 255, 255
        local val = math.floor(fuelLiters / fuelConsumption * 100 + 0.5)
        if val <= 25 then
          r, g, b = 243, 90, 90
        elseif val <= 100 then
          r, g, b = 243, 214, 90
        end
        sightlangStaticImageUsed[5] = true
        if sightlangStaticImageToc[5] then
          processsightlangStaticImage[5]()
        end
        dxDrawImage(px, py, w - 8, h - 8, sightlangStaticImage[5], 0, 0, 0, tocolor(r, g, b, 75 * progress))
        dxDrawText("Üzemanyag hatótáv", px + 4, py + 2, 0, 0, tocolor(r, g, b, 200 * progress), fontScales["11/Ubuntu-L.ttf"] * 0.9, fonts["11/Ubuntu-L.ttf"], "left", "top")
        dxDrawText(" km", 0, 0, px + w - 8 - 4, py + h - 8 - 2, tocolor(r, g, b, 255 * progress), fontScales["15/BebasNeueBold.otf"], fonts["15/BebasNeueBold.otf"], "right", "bottom")
        dxDrawText(val, 0, 0, px + w - 8 - 4 - dxGetTextWidth(" km", fontScales["15/BebasNeueBold.otf"], fonts["15/BebasNeueBold.otf"]), py + h - 8 - 2, tocolor(r, g, b, 255 * progress), fontScales["22/BebasNeueBold.otf"], fonts["22/BebasNeueBold.otf"], "right", "bottom")
        sightlangStaticImageUsed[10] = true
        if sightlangStaticImageToc[10] then
          processsightlangStaticImage[10]()
        end
        dxDrawImage(px, py + h - 8 - 40, 40, 40, sightlangStaticImage[10], 0, 0, 0, tocolor(r, g, b, 255 * progress))
      end
    end
  end
end
addEvent("gotVehicleEcuData", true)
addEventHandler("gotVehicleEcuData", getRootElement(), function(bal, opt)
  if source == currentVehicle then
    ecuBalanceValue = bal
    savedEcuBalanceValue = bal
    ecuValues = {}
    savedEcuValues = {}
    if opt then
      for i = 1, 6 do
        ecuValues[i] = math.max(math.min(1, tonumber(opt[i]) or 0), -1)
        savedEcuValues[i] = math.max(math.min(1, tonumber(opt[i]) or 0), -1)
      end
    end
  end
end)
local ecuSettingState = false
function getVehicleSpeed(currentElement)
  if isElement(currentElement) then
    local x, y, z = getElementVelocity(currentElement)
    return math.sqrt(x ^ 2 + y ^ 2 + z ^ 2) * 187.5
  end
end
local airrideLevel = 0
local airrideSettingLevel = false
local airrideBias = 0
local airrideSettingBias = false
local airrideSoftness = 0
local airrideSettingSoftness
local hasNeon = false
local neonSideColor = false
local neonFrontColor = false
local currentDriveType = false
addEvent("gotVehicleDriveTypeData", true)
addEventHandler("gotVehicleDriveTypeData", getRootElement(), function(dt)
  if source == currentVehicle then
    currentDriveType = dt
  end
end)
addEvent("gotVehicleNeon", true)
addEventHandler("gotVehicleNeon", getRootElement(), function(state, cside, cfront)
  if source == currentVehicle then
    hasNeon = state
    neonSideColor = cside
    neonFrontColor = cfront
  end
end)
addEvent("gotVehicleAirRide", true)
addEventHandler("gotVehicleAirRide", getRootElement(), function(lvl, bias, softness)
  if source == currentVehicle then
    airrideLevel = lvl
    airrideSettingLevel = false
    airrideBias = bias
    airrideSettingBias = false
    airrideSoftness = softness
    airrideSettingSoftness = false
  end
end)
addEvent("airrideSound", true)
addEventHandler("airrideSound", getRootElement(), function()
  local s = playSound3D("files/airride.wav", 0, 0, 0, false)
  attachElements(s, source)
  setSoundVolume(s, 0.75)
  setElementDimension(s, getElementDimension(source))
  setElementInterior(s, getElementInterior(source))
end)
function drawAirRide(cx, cy, hover, rt, month, monthday, hour, minute, x, y, progress)
  local canClick = getVehicleController(currentVehicle) == localPlayer and getVehicleSpeed(currentVehicle) <= 10
  local pulse = getTickCount() % 1000 / 1000
  pulse = pulse * 2
  if 1 < pulse then
    pulse = 2 - pulse
  end
  pulse = getEasingValue(pulse, "InOutQuad")
  drawBcg(x, y, progress)
  dxDrawText(rt.year - 100 .. "." .. month .. "." .. monthday .. " | " .. hour .. ":" .. minute, 0, y + 4, x + 538 - 8, 0, tocolor(255, 255, 255, 255 * progress), fontScales["11/Ubuntu-L.ttf"], fonts["11/Ubuntu-L.ttf"], "right", "top")
  x = x + 8
  dxDrawText("AirRide", x, y, 0, 0, tocolor(255, 255, 255, 255 * progress), fontScales["15/BebasNeueBold.otf"], fonts["15/BebasNeueBold.otf"], "left", "top")
  y = y + fontHeights["15/BebasNeueBold.otf"] + 2
  sightlangStaticImageUsed[4] = true
  if sightlangStaticImageToc[4] then
    processsightlangStaticImage[4]()
  end
  dxDrawImage(x, y, math.floor(256), 2, sightlangStaticImage[4], 0, 0, 0, tocolor(60, 184, 130, 255 * progress))
  if airrideLevel then
    local w = 522
    y = y + 8
    for i = 1, 4 do
      if canClick and cx and cx >= x + w / 2 + 40 * (i - 3) and cy >= y and cx <= x + w / 2 + 40 * (i - 2) and cy <= y + 32 then
        dxDrawRectangle(x + w / 2 + 40 * (i - 3) + 4, y, 32, 32, tocolor(44, 48, 52, 200 * progress))
        hover = "airridememory:" .. i
      else
        dxDrawRectangle(x + w / 2 + 40 * (i - 3) + 4, y, 32, 32, tocolor(34, 38, 42, 200 * progress))
      end
      dxDrawText("M" .. i, x + w / 2 + 40 * (i - 3), y, x + w / 2 + 40 * (i - 2), y + 32, tocolor(255, 255, 255, 200 * progress), fontScales["11/Ubuntu-L.ttf"] * 0.9, fonts["11/Ubuntu-L.ttf"], "center", "center")
    end
    y = y - 12
    sightlangStaticImageUsed[11] = true
    if sightlangStaticImageToc[11] then
      processsightlangStaticImage[11]()
    end
    dxDrawImage(x + w / 2 - 150, y, 300, 300, sightlangStaticImage[11], 0, 0, 0, tocolor(60, 184, 130, 200 * progress))
    local ty = 0
    local rot = 0
    if airrideSettingLevel then
      rot = (1.5 - airrideSettingLevel / 7 * 0.35) * (airrideBias / 4)
      sightlangStaticImageUsed[12] = true
      if sightlangStaticImageToc[12] then
        processsightlangStaticImage[12]()
      end
      dxDrawImage(x + w / 2 - 150, y - 8 + (airrideSettingLevel + 8) / 15 * 16, 300, 300, sightlangStaticImage[12], -0.75 + rot, 0, 0, tocolor(60, 184, 130, (155 + 100 * pulse) * progress))
      ty = y - 8 + (airrideSettingLevel + 8) / 15 * 16
    elseif airrideSettingBias then
      rot = (1.5 - airrideLevel / 7 * 0.35) * (airrideSettingBias / 4)
      sightlangStaticImageUsed[12] = true
      if sightlangStaticImageToc[12] then
        processsightlangStaticImage[12]()
      end
      dxDrawImage(x + w / 2 - 150, y - 8 + (airrideLevel + 8) / 15 * 16, 300, 300, sightlangStaticImage[12], -0.75 + rot, 0, 0, tocolor(60, 184, 130, 255 * progress))
      ty = y - 8 + (airrideLevel + 8) / 15 * 16
    else
      rot = (1.5 - airrideLevel / 7 * 0.35) * (airrideBias / 4)
      sightlangStaticImageUsed[12] = true
      if sightlangStaticImageToc[12] then
        processsightlangStaticImage[12]()
      end
      dxDrawImage(x + w / 2 - 150, y - 8 + (airrideLevel + 8) / 15 * 16, 300, 300, sightlangStaticImage[12], -0.75 + rot, 0, 0, tocolor(60, 184, 130, 255 * progress))
      ty = y - 8 + (airrideLevel + 8) / 15 * 16
    end
    ty = ty + 142.5
    local hoverSoftness = airrideSoftness
    for i = -4, 4 do
      if i == airrideSoftness then
        dxDrawRectangle(x + w / 2 - 150 - 12 - 24, y + 150 - 5 + 1 + 10 * i, 24, 7, tocolor(60, 184, 130, 255 * progress))
      elseif i == airrideSettingSoftness then
        dxDrawRectangle(x + w / 2 - 150 - 12 - 24, y + 150 - 5 + 1 + 10 * i, 24, 7, tocolor(255, 255, 255, 255 * progress))
        dxDrawRectangle(x + w / 2 - 150 - 12 - 24, y + 150 - 5 + 1 + 10 * i, 24, 7, tocolor(60, 184, 130, 255 * progress * pulse))
      elseif canClick and not airrideSettingLevel and not airrideSettingBias and not airrideSettingSoftness and cx and cx >= x + w / 2 - 150 - 12 - 24 and cx <= x + w / 2 - 150 - 12 - 24 + 24 and cy >= y + 150 - 5 + 1 + 10 * i and cy <= y + 150 - 5 + 1 + 10 * i + 10 then
        dxDrawRectangle(x + w / 2 - 150 - 12 - 24, y + 150 - 5 + 1 + 10 * i, 24, 7, tocolor(255, 255, 255, 255 * progress))
        hover = "airridesoftness:" .. i
        hoverSoftness = i
      else
        dxDrawRectangle(x + w / 2 - 150 - 12 - 24, y + 150 - 5 + 1 + 10 * i, 24, 7, tocolor(255, 255, 255, 150 * progress))
      end
    end
    if -4 < airrideSoftness then
      if canClick and not airrideSettingLevel and not airrideSettingBias and not airrideSettingSoftness and cx and cx >= x + w / 2 - 150 - 12 - 24 and cx <= x + w / 2 - 150 - 12 - 24 + 24 and cy >= y + 150 - 5 + 1 - 40 - 24 and cy <= y + 150 - 5 + 1 - 40 - 24 + 24 then
        dxDrawImage(x + w / 2 - 150 - 12 - 24, y + 150 - 5 + 1 - 40 - 24, 24, 24, ":sGui/" .. caretIcon .. (faTicks[caretIcon] or ""), 0, 0, 0, tocolor(60, 184, 130, 255 * progress))
        hover = "airridesoftness:up"
        hoverSoftness = hoverSoftness - 1
      else
        dxDrawImage(x + w / 2 - 150 - 12 - 24, y + 150 - 5 + 1 - 40 - 24, 24, 24, ":sGui/" .. caretIcon .. (faTicks[caretIcon] or ""), 0, 0, 0, tocolor(255, 255, 255, 255 * progress))
      end
    end
    if airrideSoftness < 4 then
      if canClick and not airrideSettingLevel and not airrideSettingBias and not airrideSettingSoftness and cx and cx >= x + w / 2 - 150 - 12 - 24 and cx <= x + w / 2 - 150 - 12 - 24 + 24 and cy >= y + 150 - 5 + 1 + 50 - 3 and cy <= y + 150 - 5 + 1 + 50 - 3 + 24 then
        dxDrawImage(x + w / 2 - 150 - 12 - 24, y + 150 - 5 + 1 + 50 - 3, 24, 24, ":sGui/" .. caretIcon .. (faTicks[caretIcon] or ""), 180, 0, 0, tocolor(60, 184, 130, 255 * progress))
        hover = "airridesoftness:down"
        hoverSoftness = hoverSoftness + 1
      else
        dxDrawImage(x + w / 2 - 150 - 12 - 24, y + 150 - 5 + 1 + 50 - 3, 24, 24, ":sGui/" .. caretIcon .. (faTicks[caretIcon] or ""), 180, 0, 0, tocolor(255, 255, 255, 255 * progress))
      end
    end
    local a = 200
    if airrideSettingSoftness then
      a = 200 - pulse * 100
      hoverSoftness = airrideSettingSoftness
    end
    local sw = 30 - 3 * hoverSoftness
    local tan = math.tan(math.rad(rot))
    local h = y + 174 - (ty + -83.1 * tan)
    sightlangStaticImageUsed[13] = true
    if sightlangStaticImageToc[13] then
      processsightlangStaticImage[13]()
    end
    dxDrawImage(x + w / 2 - 150 + 66.9 - 16, ty + -83.1 * tan, 32, h, sightlangStaticImage[13], 0, 0, 0, tocolor(255, 255, 255, a * progress))
    sightlangStaticImageUsed[14] = true
    if sightlangStaticImageToc[14] then
      processsightlangStaticImage[14]()
    end
    dxDrawImage(x + w / 2 - 150 + 66.9 - sw / 2, ty + -83.1 * tan, sw, h, sightlangStaticImage[14], 0, 0, 0, tocolor(255, 255, 255, a * progress))
    local h = y + 174 - (ty + 88.20000000000002 * tan)
    sightlangStaticImageUsed[13] = true
    if sightlangStaticImageToc[13] then
      processsightlangStaticImage[13]()
    end
    dxDrawImage(x + w / 2 - 150 + 238.20000000000002 - 16, ty + 88.20000000000002 * tan, 32, h, sightlangStaticImage[13], 0, 0, 0, tocolor(255, 255, 255, a * progress))
    sightlangStaticImageUsed[14] = true
    if sightlangStaticImageToc[14] then
      processsightlangStaticImage[14]()
    end
    dxDrawImage(x + w / 2 - 150 + 238.20000000000002 - sw / 2, ty + 88.20000000000002 * tan, sw, h, sightlangStaticImage[14], 0, 0, 0, tocolor(255, 255, 255, a * progress))
    for i = 1, 15 do
      local iy = y + 150 + 10 * (-7.5 + i - 1)
      if i == airrideLevel + 8 then
        dxDrawRectangle(x + w / 2 + 150 + 12, iy + 5 - 3.5, 24, 7, tocolor(60, 184, 130, 255 * progress))
      elseif airrideSettingLevel and i == airrideSettingLevel + 8 then
        dxDrawRectangle(x + w / 2 + 150 + 12, iy + 5 - 3.5, 24, 7, tocolor(255, 255, 255, 150 * progress))
        dxDrawRectangle(x + w / 2 + 150 + 12, iy + 5 - 3.5, 24, 7, tocolor(60, 184, 130, 255 * progress * pulse))
      elseif canClick and not airrideSettingLevel and not airrideSettingBias and not airrideSettingSoftness and cx and cx >= x + w / 2 + 150 + 12 and cx <= x + w / 2 + 150 + 12 + 24 and cy >= iy and cy <= iy + 10 then
        dxDrawRectangle(x + w / 2 + 150 + 12, iy + 5 - 3.5, 24, 7, tocolor(255, 255, 255, 255 * progress))
        hover = "airride:" .. i
        local rot = (1.5 - (i - 8) / 7 * 0.35) * (airrideBias / 4)
        sightlangStaticImageUsed[12] = true
        if sightlangStaticImageToc[12] then
          processsightlangStaticImage[12]()
        end
        dxDrawImage(x + w / 2 - 150, y - 8 + i / 15 * 16, 300, 300, sightlangStaticImage[12], -0.75 + rot, 0, 0, tocolor(255, 255, 255, 125 * progress))
      else
        dxDrawRectangle(x + w / 2 + 150 + 12, iy + 5 - 3.5, 24, 7, tocolor(255, 255, 255, 150 * progress))
      end
    end
    for i = -4, 4 do
      if i == airrideBias then
        dxDrawRectangle(x + w / 2 - 3.5 + 10 * i, y + 150 + 75, 7, 24, tocolor(60, 184, 130, 255 * progress))
      elseif i == airrideSettingBias then
        dxDrawRectangle(x + w / 2 - 3.5 + 10 * i, y + 150 + 75, 7, 24, tocolor(255, 255, 255, 255 * progress))
        dxDrawRectangle(x + w / 2 - 3.5 + 10 * i, y + 150 + 75, 7, 24, tocolor(60, 184, 130, 255 * progress * pulse))
      elseif canClick and not airrideSettingLevel and not airrideSettingBias and not airrideSettingSoftness and cx and cx >= x + w / 2 - 5 + 10 * i and cx <= x + w / 2 - 5 + 10 * i + 10 and cy >= y + 150 + 75 and cy <= y + 150 + 75 + 24 then
        dxDrawRectangle(x + w / 2 - 3.5 + 10 * i, y + 150 + 75, 7, 24, tocolor(255, 255, 255, 255 * progress))
        hover = "airridebias:" .. i
        local rot = (1.5 - airrideLevel / 7 * 0.35) * (i / 4)
        sightlangStaticImageUsed[12] = true
        if sightlangStaticImageToc[12] then
          processsightlangStaticImage[12]()
        end
        dxDrawImage(x + w / 2 - 150, y - 8 + (airrideLevel + 8) / 15 * 16, 300, 300, sightlangStaticImage[12], -0.75 + rot, 0, 0, tocolor(255, 255, 255, 125 * progress))
      else
        dxDrawRectangle(x + w / 2 - 3.5 + 10 * i, y + 150 + 75, 7, 24, tocolor(255, 255, 255, 150 * progress))
      end
    end
    if airrideBias < 4 then
      if canClick and not airrideSettingLevel and not airrideSettingBias and not airrideSettingSoftness and cx and cx >= x + w / 2 - 5 + 50 - 2 and cx <= x + w / 2 - 5 + 50 - 2 + 24 and cy >= y + 150 + 75 and cy <= y + 150 + 75 + 24 then
        dxDrawImage(x + w / 2 - 5 + 50 - 2, y + 150 + 75, 24, 24, ":sGui/" .. caretIcon .. (faTicks[caretIcon] or ""), 90, 0, 0, tocolor(60, 184, 130, 255 * progress))
        hover = "airridebias:down"
        local rot = (1.5 - airrideLevel / 7 * 0.35) * ((airrideBias + 1) / 4)
        sightlangStaticImageUsed[12] = true
        if sightlangStaticImageToc[12] then
          processsightlangStaticImage[12]()
        end
        dxDrawImage(x + w / 2 - 150, y - 8 + (airrideLevel + 8) / 15 * 16, 300, 300, sightlangStaticImage[12], -0.75 + rot, 0, 0, tocolor(255, 255, 255, 125 * progress))
      else
        dxDrawImage(x + w / 2 - 5 + 50 - 2, y + 150 + 75, 24, 24, ":sGui/" .. caretIcon .. (faTicks[caretIcon] or ""), 90, 0, 0, tocolor(255, 255, 255, 255 * progress))
      end
    end
    if -4 < airrideBias then
      if canClick and not airrideSettingLevel and not airrideSettingBias and not airrideSettingSoftness and cx and cx >= x + w / 2 - 5 - 40 - 23 and cx <= x + w / 2 - 5 - 40 - 23 + 24 and cy >= y + 150 + 75 and cy <= y + 150 + 75 + 24 then
        dxDrawImage(x + w / 2 - 5 - 40 - 23, y + 150 + 75, 24, 24, ":sGui/" .. caretIcon .. (faTicks[caretIcon] or ""), 270, 0, 0, tocolor(60, 184, 130, 255 * progress))
        hover = "airridebias:up"
        local rot = (1.5 - airrideLevel / 7 * 0.35) * ((airrideBias - 1) / 4)
        sightlangStaticImageUsed[12] = true
        if sightlangStaticImageToc[12] then
          processsightlangStaticImage[12]()
        end
        dxDrawImage(x + w / 2 - 150, y - 8 + (airrideLevel + 8) / 15 * 16, 300, 300, sightlangStaticImage[12], -0.75 + rot, 0, 0, tocolor(255, 255, 255, 125 * progress))
      else
        dxDrawImage(x + w / 2 - 5 - 40 - 23, y + 150 + 75, 24, 24, ":sGui/" .. caretIcon .. (faTicks[caretIcon] or ""), 270, 0, 0, tocolor(255, 255, 255, 255 * progress))
      end
    end
    if 1 < airrideLevel + 8 then
      if canClick and not airrideSettingLevel and not airrideSettingBias and not airrideSettingSoftness and cx and cx >= x + w / 2 + 150 + 12 and cx <= x + w / 2 + 150 + 12 + 24 and cy >= y + 150 - 75 - 24 and cy <= y + 150 - 75 then
        dxDrawImage(x + w / 2 + 150 + 12, y + 150 - 75 - 24, 24, 24, ":sGui/" .. caretIcon .. (faTicks[caretIcon] or ""), 0, 0, 0, tocolor(60, 184, 130, 255 * progress))
        hover = "airride:up"
        local rot = (1.5 - (airrideLevel - 1) / 7 * 0.35) * (airrideBias / 3)
        sightlangStaticImageUsed[12] = true
        if sightlangStaticImageToc[12] then
          processsightlangStaticImage[12]()
        end
        dxDrawImage(x + w / 2 - 150, y - 8 + (airrideLevel + 8 - 1) / 15 * 16, 300, 300, sightlangStaticImage[12], -0.75 + rot, 0, 0, tocolor(255, 255, 255, 125 * progress))
      else
        dxDrawImage(x + w / 2 + 150 + 12, y + 150 - 75 - 24, 24, 24, ":sGui/" .. caretIcon .. (faTicks[caretIcon] or ""), 0, 0, 0, tocolor(255, 255, 255, 255 * progress))
      end
    end
    if airrideLevel + 8 < 15 then
      if canClick and not airrideSettingLevel and not airrideSettingBias and not airrideSettingSoftness and cx and cx >= x + w / 2 + 150 + 12 and cx <= x + w / 2 + 150 + 12 + 24 and cy >= y + 150 + 75 and cy <= y + 150 + 75 + 24 then
        dxDrawImage(x + w / 2 + 150 + 12, y + 150 + 75, 24, 24, ":sGui/" .. caretIcon .. (faTicks[caretIcon] or ""), 180, 0, 0, tocolor(60, 184, 130, 255 * progress))
        hover = "airride:down"
        local rot = (1.25 - (airrideLevel + 1) / 7 * 0.35) * (airrideBias / 3)
        sightlangStaticImageUsed[12] = true
        if sightlangStaticImageToc[12] then
          processsightlangStaticImage[12]()
        end
        dxDrawImage(x + w / 2 - 150, y - 8 + (airrideLevel + 8 + 1) / 15 * 16, 300, 300, sightlangStaticImage[12], -0.75 + rot, 0, 0, tocolor(255, 255, 255, 125 * progress))
      else
        dxDrawImage(x + w / 2 + 150 + 12, y + 150 + 75, 24, 24, ":sGui/" .. caretIcon .. (faTicks[caretIcon] or ""), 180, 0, 0, tocolor(255, 255, 255, 255 * progress))
      end
    end
  end
  return hover
end
local neonColors = {
  white = {
    255,
    255,
    255
  },
  blue = {
    0,
    25,
    255
  },
  lightblue = {
    0,
    150,
    255
  },
  red = {
    255,
    0,
    0
  },
  orange = {
    255,
    120,
    25
  },
  green = {
    30,
    220,
    63
  },
  yellow = {
    255,
    206,
    60
  },
  pink = {
    210,
    28,
    110
  },
  purple = {
    151,
    36,
    195
  }
}
function drawNeon(cx, cy, hover, rt, month, monthday, hour, minute, x, y, progress)
  local canClick = cx and getVehicleController(currentVehicle) == localPlayer
  drawBcg(x, y, progress)
  dxDrawText(rt.year - 100 .. "." .. month .. "." .. monthday .. " | " .. hour .. ":" .. minute, 0, y + 4, x + 538 - 8, 0, tocolor(255, 255, 255, 255 * progress), fontScales["11/Ubuntu-L.ttf"], fonts["11/Ubuntu-L.ttf"], "right", "top")
  x = x + 8
  dxDrawText("Neon", x, y, 0, 0, tocolor(255, 255, 255, 255 * progress), fontScales["15/BebasNeueBold.otf"], fonts["15/BebasNeueBold.otf"], "left", "top")
  y = y + fontHeights["15/BebasNeueBold.otf"] + 2
  sightlangStaticImageUsed[4] = true
  if sightlangStaticImageToc[4] then
    processsightlangStaticImage[4]()
  end
  dxDrawImage(x, y, math.floor(256), 2, sightlangStaticImage[4], 0, 0, 0, tocolor(60, 184, 130, 255 * progress))
  if hasNeon then
    local w = 522
    local h = 293 - (y - (radioY + 19))
    is = math.floor(h * 0.75 / 2) * 2
    if neonSideColor and neonColors[neonSideColor] then
      local c = tocolor(neonColors[neonSideColor][1], neonColors[neonSideColor][2], neonColors[neonSideColor][3], 255 * progress)
      sightlangStaticImageUsed[15] = true
      if sightlangStaticImageToc[15] then
        processsightlangStaticImage[15]()
      end
      dxDrawImage(x + w / 2 - is, y + h / 2 - is / 2 - 32, is * 2, is, sightlangStaticImage[15], 0, 0, 0, tocolor(255, 255, 255, 50 * progress))
      sightlangStaticImageUsed[15] = true
      if sightlangStaticImageToc[15] then
        processsightlangStaticImage[15]()
      end
      dxDrawImage(x + w / 2 - is, y + h / 2 - is / 2 - 32, is * 2, is, sightlangStaticImage[15], 0, 0, 0, c)
    end
    if neonFrontColor and neonColors[neonFrontColor] then
      local c = tocolor(neonColors[neonFrontColor][1], neonColors[neonFrontColor][2], neonColors[neonFrontColor][3], 255 * progress)
      sightlangStaticImageUsed[16] = true
      if sightlangStaticImageToc[16] then
        processsightlangStaticImage[16]()
      end
      dxDrawImage(x + w / 2 - is, y + h / 2 - is / 2 - 32, is * 2, is, sightlangStaticImage[16], 0, 0, 0, tocolor(255, 255, 255, 50 * progress))
      sightlangStaticImageUsed[16] = true
      if sightlangStaticImageToc[16] then
        processsightlangStaticImage[16]()
      end
      dxDrawImage(x + w / 2 - is, y + h / 2 - is / 2 - 32, is * 2, is, sightlangStaticImage[16], 0, 0, 0, c)
    end
    sightlangStaticImageUsed[17] = true
    if sightlangStaticImageToc[17] then
      processsightlangStaticImage[17]()
    end
    dxDrawImage(x + w / 2 - is, y + h / 2 - is / 2 - 32, is * 2, is, sightlangStaticImage[17], 0, 0, 0, tocolor(60, 184, 130, 225 * progress))
    local c = 1
    for k in pairs(neonColors) do
      c = c + 1
    end
    x = x + w / 2 - c * 30 / 2
    local p = 3
    for k, v in pairs(neonColors) do
      if canClick and neonFrontColor ~= k and cx >= x + p and cx <= x + p + 24 and cy >= math.floor(y + h / 2 + is / 2 + p - 12) and cy <= math.floor(y + h / 2 + is / 2 + p - 12) + 24 then
        hover = "neonfront:" .. k
      end
      if canClick and neonSideColor ~= k and cx >= x + p and cx <= x + p + 24 and cy >= math.floor(y + h / 2 + is / 2 + p - 12) - 30 and cy <= math.floor(y + h / 2 + is / 2 + p - 12) - 30 + 24 then
        hover = "neonside:" .. k
      end
      if neonFrontColor == k then
        sightlangStaticImageUsed[18] = true
        if sightlangStaticImageToc[18] then
          processsightlangStaticImage[18]()
        end
        dxDrawImage(x + p, math.floor(y + h / 2 + is / 2 + p - 12) + 24 + 2, 24, 24, sightlangStaticImage[18], 180, 0, 0, tocolor(v[1], v[2], v[3], 255 * progress))
      end
      if neonSideColor == k then
        sightlangStaticImageUsed[18] = true
        if sightlangStaticImageToc[18] then
          processsightlangStaticImage[18]()
        end
        dxDrawImage(x + p, math.floor(y + h / 2 + is / 2 + p - 12) - 30 - 24 - 2, 24, 24, sightlangStaticImage[18], 0, 0, 0, tocolor(v[1], v[2], v[3], 255 * progress))
      end
      sightlangStaticImageUsed[19] = true
      if sightlangStaticImageToc[19] then
        processsightlangStaticImage[19]()
      end
      dxDrawImage(x + p, math.floor(y + h / 2 + is / 2 + p - 12), 24, 24, sightlangStaticImage[19], 0, 0, 0, tocolor(v[1], v[2], v[3], 255 * progress))
      sightlangStaticImageUsed[19] = true
      if sightlangStaticImageToc[19] then
        processsightlangStaticImage[19]()
      end
      dxDrawImage(x + p, math.floor(y + h / 2 + is / 2 + p - 12) - 30, 24, 24, sightlangStaticImage[19], 0, 0, 0, tocolor(v[1], v[2], v[3], 255 * progress))
      x = x + 30
    end
    local p = 5
    if canClick and neonFrontColor and cx >= x + p and cx <= x + p + 24 and cy >= math.floor(y + h / 2 + is / 2 + p - 12) and cy <= math.floor(y + h / 2 + is / 2 + p - 12) + 24 then
      hover = "neonfront:off"
    end
    if canClick and neonSideColor and cx >= x + p and cx <= x + p + 24 and cy >= math.floor(y + h / 2 + is / 2 + p - 12) - 30 and cy <= math.floor(y + h / 2 + is / 2 + p - 12) - 30 + 24 then
      hover = "neonside:off"
    end
    sightlangStaticImageUsed[20] = true
    if sightlangStaticImageToc[20] then
      processsightlangStaticImage[20]()
    end
    dxDrawImage(x + p, math.floor(y + h / 2 + is / 2 + p - 12), 20, 20, sightlangStaticImage[20], 0, 0, 0, tocolor(255, 255, 255, 255 * progress))
    sightlangStaticImageUsed[20] = true
    if sightlangStaticImageToc[20] then
      processsightlangStaticImage[20]()
    end
    dxDrawImage(x + p, math.floor(y + h / 2 + is / 2 + p - 12) - 30, 20, 20, sightlangStaticImage[20], 0, 0, 0, tocolor(255, 255, 255, 255 * progress))
  end
  return hover
end
function draw4WD(cx, cy, hover, rt, month, monthday, hour, minute, x, y, progress)
  local canClick = cx and getVehicleController(currentVehicle) == localPlayer and getVehicleSpeed(currentVehicle) <= 10
  drawBcg(x, y, progress)
  dxDrawText(rt.year - 100 .. "." .. month .. "." .. monthday .. " | " .. hour .. ":" .. minute, 0, y + 4, x + 538 - 8, 0, tocolor(255, 255, 255, 255 * progress), fontScales["11/Ubuntu-L.ttf"], fonts["11/Ubuntu-L.ttf"], "right", "top")
  x = x + 8
  dxDrawText("Meghajtás", x, y, 0, 0, tocolor(255, 255, 255, 255 * progress), fontScales["15/BebasNeueBold.otf"], fonts["15/BebasNeueBold.otf"], "left", "top")
  y = y + fontHeights["15/BebasNeueBold.otf"] + 2
  sightlangStaticImageUsed[4] = true
  if sightlangStaticImageToc[4] then
    processsightlangStaticImage[4]()
  end
  dxDrawImage(x, y, math.floor(256), 2, sightlangStaticImage[4], 0, 0, 0, tocolor(60, 184, 130, 255 * progress))
  local w = 522
  local h = 293 - (y - (radioY + 19))
  is = math.floor(h * 0.75 / 2) * 2
  local red = tocolor(184, 60, 60, 255 * progress)
  local green = tocolor(60, 184, 130, 255 * progress)
  local white = tocolor(255, 255, 255, 255 * progress)
  sightlangStaticImageUsed[21] = true
  if sightlangStaticImageToc[21] then
    processsightlangStaticImage[21]()
  end
  dxDrawImage(x + w / 2 - is, y + h / 2 - is / 2 - 16, is * 2, is, sightlangStaticImage[21], 0, 0, 0, (currentDriveType == "awd" or currentDriveType == "rwd") and green or red)
  sightlangStaticImageUsed[22] = true
  if sightlangStaticImageToc[22] then
    processsightlangStaticImage[22]()
  end
  dxDrawImage(x + w / 2 - is, y + h / 2 - is / 2 - 16, is * 2, is, sightlangStaticImage[22], 0, 0, 0, (currentDriveType == "awd" or currentDriveType == "fwd") and green or red)
  sightlangStaticImageUsed[23] = true
  if sightlangStaticImageToc[23] then
    processsightlangStaticImage[23]()
  end
  dxDrawImage(x + w / 2 - is, y + h / 2 - is / 2 - 16, is * 2, is, sightlangStaticImage[23], 0, 0, 0, tocolor(61, 122, 184, 255 * progress))
  if canClick and cx >= x + w / 2 - 80 - 20 and cx <= x + w / 2 - 80 + 20 and cy >= y + h / 2 + is / 2 - 16 and cy <= y + h / 2 + is / 2 then
    hover = "drivetype:rwd"
  end
  dxDrawText("RWD", x + w / 2 - 80, y + h / 2 + is / 2 - 16, x + w / 2 - 80, y + h / 2 + is / 2, currentDriveType == "rwd" and green or white, fontScales["15/BebasNeueBold.otf"], fonts["15/BebasNeueBold.otf"], "center", "center")
  if canClick and cx >= x + w / 2 - 20 and cx <= x + w / 2 + 20 and cy >= y + h / 2 + is / 2 - 16 and cy <= y + h / 2 + is / 2 then
    hover = "drivetype:awd"
  end
  dxDrawText("AWD", x + w / 2, y + h / 2 + is / 2 - 16, x + w / 2, y + h / 2 + is / 2, currentDriveType == "awd" and green or white, fontScales["15/BebasNeueBold.otf"], fonts["15/BebasNeueBold.otf"], "center", "center")
  if canClick and cx >= x + w / 2 + 80 - 20 and cx <= x + w / 2 + 80 + 20 and cy >= y + h / 2 + is / 2 - 16 and cy <= y + h / 2 + is / 2 then
    hover = "drivetype:fwd"
  end
  dxDrawText("FWD", x + w / 2 + 80, y + h / 2 + is / 2 - 16, x + w / 2 + 80, y + h / 2 + is / 2, currentDriveType == "fwd" and green or white, fontScales["15/BebasNeueBold.otf"], fonts["15/BebasNeueBold.otf"], "center", "center")
  return hover
end
function drawECU(cx, cy, hover, rt, month, monthday, hour, minute, x, y, progress)
  local click = false
  if 1 <= progress then
    click = getKeyState("mouse1")
    if click and (getVehicleController(currentVehicle) ~= localPlayer or getVehicleSpeed(currentVehicle) > 10) then
      click = false
    end
  end
  local tmp = false
  local pulse = getTickCount() % 1000 / 1000
  pulse = pulse * 2
  if 1 < pulse then
    pulse = 2 - pulse
  end
  pulse = getEasingValue(pulse, "InOutQuad")
  drawBcg(x, y, progress)
  dxDrawText(rt.year - 100 .. "." .. month .. "." .. monthday .. " | " .. hour .. ":" .. minute, 0, y + 4, x + 538 - 8, 0, tocolor(255, 255, 255, 255 * progress), fontScales["11/Ubuntu-L.ttf"], fonts["11/Ubuntu-L.ttf"], "right", "top")
  x = x + 8
  dxDrawText("SightECU", x, y, 0, 0, tocolor(255, 255, 255, 255 * progress), fontScales["15/BebasNeueBold.otf"], fonts["15/BebasNeueBold.otf"], "left", "top")
  y = y + fontHeights["15/BebasNeueBold.otf"] + 2
  sightlangStaticImageUsed[4] = true
  if sightlangStaticImageToc[4] then
    processsightlangStaticImage[4]()
  end
  dxDrawImage(x, y, math.floor(256), 2, sightlangStaticImage[4], 0, 0, 0, tocolor(60, 184, 130, 255 * progress))
  local w = 522
  if ecuBalanceValue then
    y = y + 16
    dxDrawText("Gyorsulás", x, y, 0, 0, tocolor(255, 255, 255, 255 * progress), fontScales["15/BebasNeueBold.otf"] * 0.75, fonts["15/BebasNeueBold.otf"], "left", "top")
    dxDrawText("Végsebesség", 0, y, x + w, 0, tocolor(255, 255, 255, 255 * progress), fontScales["15/BebasNeueBold.otf"] * 0.75, fonts["15/BebasNeueBold.otf"], "right", "top")
    y = y + fontHeights["15/BebasNeueBold.otf"] * 0.75 + 4
    dxDrawRectangle(x, y, w, 2, tocolor(255, 255, 255, 125 * progress))
    dxDrawRectangle(x, y + 24 - 2, w, 2, tocolor(255, 255, 255, 125 * progress))
    dxDrawRectangle(x, y + 2, 2, 20, tocolor(255, 255, 255, 125 * progress))
    dxDrawRectangle(x + w - 2, y + 2, 2, 20, tocolor(255, 255, 255, 125 * progress))
    local balW = (w / 2 - 2) * savedEcuBalanceValue
    sightlangStaticImageUsed[24] = true
    if sightlangStaticImageToc[24] then
      processsightlangStaticImage[24]()
    end
    dxDrawImage(x + w / 2 + balW - 4, y + 12 - 4, 8, 8, sightlangStaticImage[24], 0, 0, 0, tocolor(255, 255, 255, 200 * progress))
    if cx and cx >= x and cx <= x + w and cy >= y and cy <= y + 24 then
      hover = "ecuBalance"
      if click then
        ecuBalanceValue = math.max(math.min(1, (cx - (x + 2)) / (w - 4) * 2 - 1), -1)
        tmp = "bal"
      end
    end
    local balW = (w / 2 - 2) * ecuBalanceValue
    if tmp == "bal" then
      dxDrawRectangle(x + w / 2, y + 2, balW, 20, tocolor(60, 184, 130, (150 - 100 * pulse) * progress))
    else
      dxDrawRectangle(x + w / 2, y + 2, balW, 20, tocolor(60, 184, 130, 150 * progress))
    end
    sightlangStaticImageUsed[24] = true
    if sightlangStaticImageToc[24] then
      processsightlangStaticImage[24]()
    end
    dxDrawImage(x + w / 2 + balW - 4, y + 12 - 4, 8, 8, sightlangStaticImage[24], 0, 0, 0, tocolor(60, 184, 130, 255 * progress))
    local cols = 6
    local rows = 8
    local w2 = w / cols
    y = y + 32
    dxDrawText("Optimalizálás:", x, y, 0, 0, tocolor(255, 255, 255, 255 * progress), fontScales["15/BebasNeueBold.otf"], fonts["15/BebasNeueBold.otf"], "left", "top")
    y = y + fontHeights["15/BebasNeueBold.otf"] + 4
    local h = 293 - (y - (radioY + 19)) - 8 - 24 - 8
    local h2 = h / rows
    local ly = 0
    if cx and cx >= x and cy >= y and cx <= x + w and cy <= y + h then
      hover = "ecuValues"
      if click then
        local i = math.ceil((cx - x) / w2)
        ecuValues[i] = math.max(math.min(1, 1 - (cy - y) / h), -1) * 2 - 1
        tmp = i
      end
    end
    for i = 1, cols do
      local val = ecuValues[i] / 2 + 0.5
      if tmp == i then
        dxDrawRectangle(x + (i - 1) * w2, y + h * (1 - val), w2, h * val, tocolor(60, 184, 130, (150 - 100 * pulse) * progress))
      else
        dxDrawRectangle(x + (i - 1) * w2, y + h * (1 - val), w2, h * val, tocolor(60, 184, 130, 150 * progress))
      end
      if 1 < i then
        dxDrawRectangle(x + (i - 1) * w2 - 1, y + 2, 2, h - 4, tocolor(255, 255, 255, 125 * progress))
      end
      ly = y + h * (1 - val)
    end
    for i = 1, rows do
      if 1 < i then
        dxDrawRectangle(x, y + (i - 1) * h2 - 1, w, 2, tocolor(255, 255, 255, 62.5 * progress))
      end
    end
    dxDrawRectangle(x, y, w, 2, tocolor(255, 255, 255, 125 * progress))
    dxDrawRectangle(x, y + 2, 2, h - 4, tocolor(255, 255, 255, 125 * progress))
    dxDrawRectangle(x + w - 2, y + 2, 2, h - 4, tocolor(255, 255, 255, 125 * progress))
    dxDrawRectangle(x, y + h - 2, w, 2, tocolor(255, 255, 255, 125 * progress))
    local ly = 0
    local ly2 = 0
    for i = 1, cols do
      local lastVal = savedEcuValues[i] / 2 + 0.5
      if 1 < i then
        dxDrawLine(x + (i - 2 + 0.5) * w2, ly2, x + (i - 1 + 0.5) * w2, y + h * (1 - lastVal), tocolor(255, 255, 255, 100 * progress), 2)
      end
      sightlangStaticImageUsed[24] = true
      if sightlangStaticImageToc[24] then
        processsightlangStaticImage[24]()
      end
      dxDrawImage(x + (i - 1 + 0.5) * w2 - 5, y + h * (1 - lastVal) - 5, 10, 10, sightlangStaticImage[24], 0, 0, 0, tocolor(255, 255, 255, 100 * progress))
      ly2 = y + h * (1 - lastVal)
      local val = ecuValues[i] / 2 + 0.5
      if 1 < i then
        dxDrawLine(x + (i - 2 + 0.5) * w2, ly, x + (i - 1 + 0.5) * w2, y + h * (1 - val), tocolor(60, 184, 130, 255 * progress), 2)
      end
      sightlangStaticImageUsed[24] = true
      if sightlangStaticImageToc[24] then
        processsightlangStaticImage[24]()
      end
      dxDrawImage(x + (i - 1 + 0.5) * w2 - 5, y + h * (1 - val) - 5, 10, 10, sightlangStaticImage[24], 0, 0, 0, tocolor(60, 184, 130, 255 * progress))
      ly = y + h * (1 - val)
    end
    y = y + h + 10
    if cx and cx >= x + w - 24 and cx <= x + w and cy >= y and cy <= y + 24 and getVehicleController(currentVehicle) == localPlayer and getVehicleSpeed(currentVehicle) <= 10 then
      dxDrawImage(x + w - 24, y, 24, 24, ":sGui/" .. saveIcon .. (faTicks[saveIcon] or ""), 0, 0, 0, tocolor(60, 184, 130, 255 * progress))
      hover = "saveECU"
    else
      dxDrawImage(x + w - 24, y, 24, 24, ":sGui/" .. saveIcon .. (faTicks[saveIcon] or ""), 0, 0, 0, tocolor(255, 255, 255, 255 * progress))
    end
    if cx and cx >= x + w - 48 and cx <= x + w - 24 and cy >= y and cy <= y + 24 and getVehicleController(currentVehicle) == localPlayer and getVehicleSpeed(currentVehicle) <= 10 then
      dxDrawImage(x + w - 48, y, 24, 24, ":sGui/" .. resetIcon .. (faTicks[resetIcon] or ""), 0, 0, 0, tocolor(60, 184, 130, 255 * progress))
      hover = "resetECU"
    else
      dxDrawImage(x + w - 48, y, 24, 24, ":sGui/" .. resetIcon .. (faTicks[resetIcon] or ""), 0, 0, 0, tocolor(255, 255, 255, 255 * progress))
    end
    if tmp ~= ecuSettingState then
      ecuSettingState = tmp
      if ecuSettingState then
        local sound = playSound("files/push.wav")
        if radioCrashed then
          setSoundEffectEnabled(sound, "distortion", true)
        end
      else
        local sound = playSound("files/pushend.wav")
        if radioCrashed then
          setSoundEffectEnabled(sound, "distortion", true)
        end
      end
    end
  end
  return hover
end
function renderRadio()
  local cx, cy = getCursorPosition()
  if cx then
    cx = cx * screenX
    cy = cy * screenY
    if radioMove then
      radioX = cx - radioMove[1] + radioMove[3]
      radioY = cy - radioMove[2] + radioMove[4]
    end
  else
    radioMove = false
  end
  local hover = false
  local x, y = radioX, radioY
  sightlangStaticImageUsed[25] = true
  if sightlangStaticImageToc[25] then
    processsightlangStaticImage[25]()
  end
  dxDrawImage(x, y, sizeX, sizeY, sightlangStaticImage[25])
  if currentMenu == "off" then
    sightlangStaticImageUsed[26] = true
    if sightlangStaticImageToc[26] then
      processsightlangStaticImage[26]()
    end
    dxDrawImage(x, y, sizeX, sizeY, sightlangStaticImage[26])
  elseif currentMenu == "on" then
    local progress = getEasingValue(math.min((getTickCount() - radioOn) / 2500, 1), "InOutQuad")
    sightlangStaticImageUsed[26] = true
    if sightlangStaticImageToc[26] then
      processsightlangStaticImage[26]()
    end
    dxDrawImage(x, y, sizeX, sizeY, sightlangStaticImage[26], 0, 0, 0, tocolor(255, 255, 255, 255 - progress * 255))
    sightlangStaticImageUsed[27] = true
    if sightlangStaticImageToc[27] then
      processsightlangStaticImage[27]()
    end
    dxDrawImage(x, y, sizeX, sizeY, sightlangStaticImage[27], 0, 0, 0, tocolor(255, 255, 255, progress * 255))
  else
    sightlangStaticImageUsed[27] = true
    if sightlangStaticImageToc[27] then
      processsightlangStaticImage[27]()
    end
    dxDrawImage(x, y, sizeX, sizeY, sightlangStaticImage[27])
  end
  if currentMenu ~= "on" and cx and cx >= x + 23 and cx <= x + 37 and cy >= y + 26 and cy <= y + 41 then
    hover = "toggle"
  end
  local rt = getRealTime()
  local month = rt.month + 1
  if 2 > utf8.len(month) then
    month = "0" .. month
  end
  local monthday = rt.monthday
  if 2 > utf8.len(monthday) then
    monthday = "0" .. monthday
  end
  local hour = rt.hour
  if 2 > utf8.len(hour) then
    hour = "0" .. hour
  end
  local minute = rt.minute
  if 2 > utf8.len(minute) then
    minute = "0" .. minute
  end
  local progress = 1
  if (currentMenu ~= "radio" or lastCurrentMenu ~= "radiolist") and (currentMenu ~= "radiolist" or lastCurrentMenu ~= "radio") then
    progress = (getTickCount() - menuChange) / 1000
    progress = getEasingValue(math.min(progress, 1), "InOutQuad")
  end
  if currentMenu ~= "off" and cx and cx >= x + 610 and cx <= x + 630 then
    if cy >= y + 26 and cy <= y + 46 then
      hover = "menu:home"
    elseif cy >= y + 75 and cy <= y + 89 then
      hover = "volPlus"
    elseif cy >= y + 122 and cy <= y + 136 then
      hover = "volMinus"
    end
  end
  local click = getKeyState("mouse1") or getKeyState("mouse2")
  dxDrawImage(x, y, sizeX, sizeY, dynamicImage("files/home_" .. (click and hover == "menu:home" and "on" or "off") .. ".dds"))
  dxDrawImage(x, y, sizeX, sizeY, dynamicImage("files/plus_" .. (click and hover == "volPlus" and "on" or "off") .. ".dds"))
  dxDrawImage(x, y, sizeX, sizeY, dynamicImage("files/minus_" .. (click and hover == "volMinus" and "on" or "off") .. ".dds"))
  if progress < 1 and hover == "menu:home" then
    hover = false
  end
  if currentMenu == "home" or currentMenu == "off" then
    progress = 1 - progress
    if progress <= 0 then
      lastCurrentMenu = false
    end
  end
  local streamTitle = "N/A"
  if isElement(vehicleSounds[currentVehicle]) then
    local metaTags = getSoundMetaTags(vehicleSounds[currentVehicle])
    if metaTags and metaTags.stream_title then
      streamTitle = metaTags.stream_title
      if utf8.len(streamTitle) > 60 then
        streamTitle = utf8.sub(streamTitle, 1, 60) .. "..."
      end
    end
  end
  if streamTitle ~= currentSong then
    setCurrentSong(streamTitle)
  end
  local songMove = 0
  if currentSongChange then
    songMove = (getTickCount() - currentSongChange) / 750
    songMove = getEasingValue(math.min(songMove, 1), "InOutQuad")
    if 1 <= songMove then
      currentSongChange = false
    end
  end
  if currentMenu == "on" then
    local progress = (getTickCount() - radioOn) / 2500
    if 2 < progress then
      progress = 1 - (progress - 2)
      if progress <= 0 then
        progress = 0
        setMenu("home")
      end
    end
    progress = getEasingValue(math.min(progress, 1), "InOutQuad")
    dxDrawRectangle(x + 57, y + 19, 538, 293, tocolor(17, 20, 32))
    x = x + sizeX / 2
    y = y + sizeY / 2 - 60
    for k = 0, 8 do
      local h = math.floor(math.random(60) * (math.min(k / 8, (8 - k) / 8) * 1.75 + 0.25) * progress)
      sightlangStaticImageUsed[3] = true
      if sightlangStaticImageToc[3] then
        processsightlangStaticImage[3]()
      end
      dxDrawImage(math.floor(x + 16 * (-4.5 + k) + 2), y + 60 - h, 12, h, sightlangStaticImage[3], 0, 0, 0, tocolor(60, 184, 130))
    end
    y = y + 60 + 20
    dxDrawText("SIGHT AUDIO SYSTEM", x - 256 * progress, y - 10, x + 256 * progress, y + 10, tocolor(255, 255, 255), fontScales["18/BebasNeueBold.otf"], fonts["18/BebasNeueBold.otf"], "center", "center", true)
    y = y + 25
    local w = math.floor(128 * progress + 0.5)
    sightlangStaticImageUsed[4] = true
    if sightlangStaticImageToc[4] then
      processsightlangStaticImage[4]()
    end
    dxDrawImage(x, y - 2, w, 2, sightlangStaticImage[4], 0, 0, 0, tocolor(60, 184, 130))
    sightlangStaticImageUsed[4] = true
    if sightlangStaticImageToc[4] then
      processsightlangStaticImage[4]()
    end
    dxDrawImage(x - w, y - 2, w, 2, sightlangStaticImage[4], 180, 0, 0, tocolor(60, 184, 130))
  elseif currentMenu ~= "off" and (currentMenu == "home" or progress < 1) then
    local onProgress = (getTickCount() - radioOn) / 1000
    onProgress = getEasingValue(math.min(onProgress, 1), "InOutQuad")
    x = x + 57
    y = y + 19
    drawBcg(x, y, onProgress)
    sightlangStaticImageUsed[4] = true
    if sightlangStaticImageToc[4] then
      processsightlangStaticImage[4]()
    end
    dxDrawImage(x, y + 293 - 48 - 20, math.floor(538 * onProgress), 20, sightlangStaticImage[4], 0, 0, 0, tocolor(60, 184, 130))
    dxDrawRectangle(x, y + 293 - 48, 538 * onProgress, 48, tocolor(18, 18, 18))
    dxDrawText(stationName .. ": ", x + 8, y + 293 - 48 - 20, x + 538 * onProgress, y + 293 - 48, tocolor(255, 255, 255), fontScales["11/Ubuntu-B.ttf"], fonts["11/Ubuntu-B.ttf"], "left", "center", true)
    if currentSongChange then
      dxDrawText(currentSong, x + 8 + dxGetTextWidth(stationName .. ": ", fontScales["11/Ubuntu-B.ttf"], fonts["11/Ubuntu-B.ttf"]), y + 293 - 48 - 20, x + 538 * onProgress, y + 293 - 48 - 20 + 20 * songMove, tocolor(255, 255, 255), fontScales["11/Ubuntu-LI.ttf"], fonts["11/Ubuntu-LI.ttf"], "left", "center", true)
      dxDrawText(lastCurrentSong, x + 8 + dxGetTextWidth(stationName .. ": ", fontScales["11/Ubuntu-B.ttf"], fonts["11/Ubuntu-B.ttf"]), y + 293 - 48 - 20 + 20 * songMove, x + 538 * onProgress, y + 293 - 48, tocolor(255, 255, 255), fontScales["11/Ubuntu-LI.ttf"], fonts["11/Ubuntu-LI.ttf"], "left", "center", true)
    else
      dxDrawText(currentSong, x + 8 + dxGetTextWidth(stationName .. ": ", fontScales["11/Ubuntu-B.ttf"], fonts["11/Ubuntu-B.ttf"]), y + 293 - 48 - 20, x + 538 * onProgress, y + 293 - 48, tocolor(255, 255, 255), fontScales["11/Ubuntu-LI.ttf"], fonts["11/Ubuntu-LI.ttf"], "left", "center", true)
    end
    dxDrawRectangle(x + 538 - 175 - 9, y + 293 - 24 + 14 - 6, 175, 3, tocolor(135, 135, 135, 255 * onProgress))
    if cy and cy >= y + 293 - 48 and cy <= y + 293 and cx >= x + 538 - 175 - 9 - 8 and cx <= x + 538 - 9 + 8 then
      hover = "volume"
    end
    if volumeSet then
      radioVolume = math.max(math.min(1, (cx - (x + 538 - 175 - 9)) / 175), 0)
      if isElement(vehicleSounds[currentVehicle]) then
        setStreamerModeVolume(vehicleSounds[currentVehicle], radioVolume)
      end
    end
    sightlangStaticImageUsed[3] = true
    if sightlangStaticImageToc[3] then
      processsightlangStaticImage[3]()
    end
    dxDrawImage(x + 538 - 175 - 9 + 171 * radioVolume, math.floor(y + 293 - 24 - 14), 4, 28, sightlangStaticImage[3], 0, 0, 0, tocolor(60, 184, 130, 255 * onProgress))
    dxDrawText(math.floor(radioVolume * 100 + 0.5) .. " % ", 0, math.floor(y + 293 - 24 - 14), x + 538 - 175 - 9 + 171 * radioVolume - 4, 0, tocolor(255, 255, 255, 255 * onProgress), fontScales["11/Ubuntu-L.ttf"], fonts["11/Ubuntu-L.ttf"], "right", "top")
    if cx and cy >= y + 293 - 48 and cy <= y + 293 then
      if cx >= x + 8 and cx <= x + 8 + 43 then
        hover = "prev"
      elseif cx >= x + 16 + 43 and cx <= x + 16 + 43 + 48 then
        hover = "startstop"
      elseif cx >= x + 24 + 43 + 48 and cx <= x + 24 + 43 + 48 + 43 then
        hover = "next"
      end
    end
    if hover == "prev" then
      sightlangStaticImageUsed[28] = true
      if sightlangStaticImageToc[28] then
        processsightlangStaticImage[28]()
      end
      dxDrawImage(x + 8, y + 293 - 24 - 11, 43, 22, sightlangStaticImage[28], 180, 0, 0, tocolor(60, 184, 130, 255 * onProgress))
    else
      sightlangStaticImageUsed[28] = true
      if sightlangStaticImageToc[28] then
        processsightlangStaticImage[28]()
      end
      dxDrawImage(x + 8, y + 293 - 24 - 11, 43, 22, sightlangStaticImage[28], 180, 0, 0, tocolor(255, 255, 255, 105 * onProgress))
    end
    local color = tocolor(255, 255, 255, 105 * onProgress)
    if hover == "startstop" then
      color = tocolor(60, 184, 130, 255 * onProgress)
    end
    if radioState then
      sightlangStaticImageUsed[29] = true
      if sightlangStaticImageToc[29] then
        processsightlangStaticImage[29]()
      end
      dxDrawImage(x + 16 + 43, y + 293 - 48, 48, 48, sightlangStaticImage[29], 0, 0, 0, color)
    else
      sightlangStaticImageUsed[30] = true
      if sightlangStaticImageToc[30] then
        processsightlangStaticImage[30]()
      end
      dxDrawImage(x + 16 + 43, y + 293 - 48, 48, 48, sightlangStaticImage[30], 0, 0, 0, color)
    end
    if hover == "next" then
      sightlangStaticImageUsed[28] = true
      if sightlangStaticImageToc[28] then
        processsightlangStaticImage[28]()
      end
      dxDrawImage(x + 24 + 43 + 48, y + 293 - 24 - 11, 43, 22, sightlangStaticImage[28], 0, 0, 0, tocolor(60, 184, 130, 255 * onProgress))
    else
      sightlangStaticImageUsed[28] = true
      if sightlangStaticImageToc[28] then
        processsightlangStaticImage[28]()
      end
      dxDrawImage(x + 24 + 43 + 48, y + 293 - 24 - 11, 43, 22, sightlangStaticImage[28], 0, 0, 0, tocolor(255, 255, 255, 105 * onProgress))
    end
    dxDrawText(rt.year - 100 .. "." .. month .. "." .. monthday .. " | " .. hour .. ":" .. minute, x + 538 - 8 - 128 * onProgress, y + 4, x + 538 - 8, y + 64, tocolor(255, 255, 255), fontScales["11/Ubuntu-L.ttf"], fonts["11/Ubuntu-L.ttf"], "right", "top", true)
    x = x + 8
    dxDrawText("SIGHT AUDIO SYSTEM", x, y, x + 145 * onProgress, y + 64, tocolor(255, 255, 255), fontScales["15/BebasNeueBold.otf"], fonts["15/BebasNeueBold.otf"], "left", "top", true)
    y = y + fontHeights["15/BebasNeueBold.otf"] + 2
    sightlangStaticImageUsed[4] = true
    if sightlangStaticImageToc[4] then
      processsightlangStaticImage[4]()
    end
    dxDrawImage(x, y, math.floor(256 * onProgress), 2, sightlangStaticImage[4], 0, 0, 0, tocolor(60, 184, 130))
    local w = math.floor(261)
    local itemW = w * 2 / 4
    local h = 225 - (fontHeights["15/BebasNeueBold.otf"] + 2)
    sightlangStaticImageUsed[4] = true
    if sightlangStaticImageToc[4] then
      processsightlangStaticImage[4]()
    end
    dxDrawImage(x, y + h / 2, w + 64, 1, sightlangStaticImage[4], 0, 0, 0, tocolor(220, 220, 220, 220 * onProgress))
    sightlangStaticImageUsed[4] = true
    if sightlangStaticImageToc[4] then
      processsightlangStaticImage[4]()
    end
    dxDrawImage(x + w - 64, y + h / 2, w + 64, 1, sightlangStaticImage[4], 180, 0, 0, tocolor(220, 220, 220, 220 * onProgress))
    local item = 48 + fontHeights["11/Ubuntu-L.ttf"] + 4
    local id = 1
    for i = 1, 2 do
      for k = 1, 4 do
        if menus[id] then
          local available = true
          local a = 255
          if menus[id] == "ecu" then
            available = ecuBalanceValue and true or false
            a = available and 255 or 200
          elseif menus[id] == "airride" then
            available = airrideLevel and true or false
            a = available and 255 or 200
          elseif menus[id] == "neon" then
            available = hasNeon and true or false
            a = available and 255 or 200
          elseif menus[id] == "awd" then
            available = currentDriveType and true or false
            a = available and 255 or 200
          end
          if cx and cx >= x + itemW / 2 - 32 and cx <= x + itemW / 2 + 32 and cy >= y + h / 4 - item / 2 and cy <= y + h / 4 + item / 2 then
            hover = "menu:" .. menus[id]
            dxDrawImage(x + itemW / 2 - 24, y + h / 4 - item / 2, 48, 48, dynamicImage("files/" .. menus[id] .. (not available and "2" or "") .. ".dds"), 0, 0, 0, tocolor(255, 255, 255, a * onProgress))
            sightlangStaticImageUsed[31] = true
            if sightlangStaticImageToc[31] then
              processsightlangStaticImage[31]()
            end
            dxDrawImage(x + itemW / 2 - 24, y + h / 4 - item / 2, 48, 48, sightlangStaticImage[31], 0, 0, 0, tocolor(255, 255, 255, a * 0.75 * onProgress))
            dxDrawText(menuTitles[id], x + itemW / 2 - 32, y + h / 4 - item / 2 + 48 + 4, x + itemW / 2 + 32, y, tocolor(255, 255, 255, a * onProgress), fontScales["11/Ubuntu-L.ttf"], fonts["11/Ubuntu-L.ttf"], "center", "top")
          else
            dxDrawImage(x + itemW / 2 - 24 + 3, y + h / 4 - item / 2 + 3, 42, 42, dynamicImage("files/" .. menus[id] .. (not available and "2" or "") .. ".dds"), 0, 0, 0, tocolor(255, 255, 255, a * onProgress))
            dxDrawText(menuTitles[id], x + itemW / 2 - 32, y + h / 4 - item / 2 + 48 + 4, x + itemW / 2 + 32, y, tocolor(255, 255, 255, a * onProgress), fontScales["11/Ubuntu-L.ttf"] * 0.9, fonts["11/Ubuntu-L.ttf"], "center", "top")
          end
        end
        id = id + 1
        x = x + itemW
      end
      x = x - itemW * 4
      y = y + h / 2 + 1
    end
  else
    dxDrawRectangle(x + 57, y + 19, 538, 293, tocolor(15, 15, 15))
  end
  x, y = radioX + 57, radioY + 19
  if currentMenu == "navigation" or lastCurrentMenu == "navigation" then
    dxDrawImage(radioX + 57, radioY + 19, radarW, radarH, finalRt, 0, 0, 0, tocolor(255, 255, 255, 255 * progress))
    dxDrawText(rt.year - 100 .. "." .. month .. "." .. monthday .. " | " .. hour .. ":" .. minute, 0, y + 4, x + 538 - 8, 0, tocolor(255, 255, 255, 255 * progress), fontScales["11/Ubuntu-L.ttf"], fonts["11/Ubuntu-L.ttf"], "right", "top")
    x = x + 8
    dxDrawText("Navigáció", x, y, 0, 0, tocolor(255, 255, 255, 255 * progress), fontScales["15/BebasNeueBold.otf"], fonts["15/BebasNeueBold.otf"], "left", "top")
    renderRadar()
  elseif currentMenu == "awd" or lastCurrentMenu == "awd" then
    hover = draw4WD(cx, cy, hover, rt, month, monthday, hour, minute, x, y, progress)
  elseif currentMenu == "ecu" or lastCurrentMenu == "ecu" then
    hover = drawECU(cx, cy, hover, rt, month, monthday, hour, minute, x, y, progress)
  elseif currentMenu == "neon" or lastCurrentMenu == "neon" then
    hover = drawNeon(cx, cy, hover, rt, month, monthday, hour, minute, x, y, progress)
  elseif currentMenu == "airride" or lastCurrentMenu == "airride" then
    hover = drawAirRide(cx, cy, hover, rt, month, monthday, hour, minute, x, y, progress)
  elseif currentMenu == "computer" or lastCurrentMenu == "computer" then
    drawComputer(rt, month, monthday, hour, minute, x, y, progress)
  elseif currentMenu == "settings" or lastCurrentMenu == "settings" then
    drawBcg(x, y, progress)
    dxDrawText(rt.year - 100 .. "." .. month .. "." .. monthday .. " | " .. hour .. ":" .. minute, 0, y + 4, x + 538 - 8, 0, tocolor(255, 255, 255, 255 * progress), fontScales["11/Ubuntu-L.ttf"], fonts["11/Ubuntu-L.ttf"], "right", "top")
    x = x + 8
    dxDrawText("Beállítások", x, y, 0, 0, tocolor(255, 255, 255, 255 * progress), fontScales["15/BebasNeueBold.otf"], fonts["15/BebasNeueBold.otf"], "left", "top")
    y = y + fontHeights["15/BebasNeueBold.otf"] + 2
    sightlangStaticImageUsed[4] = true
    if sightlangStaticImageToc[4] then
      processsightlangStaticImage[4]()
    end
    dxDrawImage(x, y, math.floor(256), 2, sightlangStaticImage[4], 0, 0, 0, tocolor(60, 184, 130, 255 * progress))
    y = y + 24
    dxDrawText("Háttérkép: ", x, y, 0, 0, tocolor(255, 255, 255, 255 * progress), fontScales["11/Ubuntu-L.ttf"], fonts["11/Ubuntu-L.ttf"], "left", "top")
    x = x + dxGetTextWidth("Háttérkép: ", fontScales["11/Ubuntu-L.ttf"], fonts["11/Ubuntu-L.ttf"]) + 8
    if cx and cx >= x and cx <= x + 12 and cy >= y and cy <= y + fontHeights["11/Ubuntu-L.ttf"] then
      hover = "prevWallpaper"
      dxDrawText("<", x, y, x + 12, 0, tocolor(60, 184, 130, 255 * progress), fontScales["11/Ubuntu-L.ttf"], fonts["11/Ubuntu-L.ttf"], "center", "top")
    else
      dxDrawText("<", x, y, x + 12, 0, tocolor(255, 255, 255, 255 * progress), fontScales["11/Ubuntu-L.ttf"], fonts["11/Ubuntu-L.ttf"], "center", "top")
    end
    x = x + 12
    dxDrawText(radioWallpaper, x, y, x + 24, 0, tocolor(60, 184, 130, 255 * progress), fontScales["11/Ubuntu-L.ttf"], fonts["11/Ubuntu-L.ttf"], "center", "top")
    x = x + 24
    if cx and cx >= x and cx <= x + 12 and cy >= y and cy <= y + fontHeights["11/Ubuntu-L.ttf"] then
      hover = "nextWallpaper"
      dxDrawText(">", x, y, x + 12, 0, tocolor(60, 184, 130, 255 * progress), fontScales["11/Ubuntu-L.ttf"], fonts["11/Ubuntu-L.ttf"], "center", "top")
    else
      dxDrawText(">", x, y, x + 12, 0, tocolor(255, 255, 255, 255 * progress), fontScales["11/Ubuntu-L.ttf"], fonts["11/Ubuntu-L.ttf"], "center", "top")
    end
    x = radioX + 57 + 8
    y = y + fontHeights["11/Ubuntu-L.ttf"] + 4
    sightlangStaticImageUsed[4] = true
    if sightlangStaticImageToc[4] then
      processsightlangStaticImage[4]()
    end
    dxDrawImage(x, y, math.floor(256), 2, sightlangStaticImage[4], 0, 0, 0, tocolor(220, 220, 220, 220 * progress))
    y = y + 8
    dxDrawText("Fényerő: ", x, y, 0, 0, tocolor(255, 255, 255, 255 * progress), fontScales["11/Ubuntu-L.ttf"], fonts["11/Ubuntu-L.ttf"], "left", "top")
    x = x + dxGetTextWidth("Fényerő: ", fontScales["11/Ubuntu-L.ttf"], fonts["11/Ubuntu-L.ttf"]) + 8
    if cx and cx >= x and cx <= x + 12 and cy >= y and cy <= y + fontHeights["11/Ubuntu-L.ttf"] then
      hover = "minusBrightness"
      dxDrawText("<", x, y, x + 12, 0, tocolor(60, 184, 130, 255 * progress), fontScales["11/Ubuntu-L.ttf"], fonts["11/Ubuntu-L.ttf"], "center", "top")
    else
      dxDrawText("<", x, y, x + 12, 0, tocolor(255, 255, 255, 255 * progress), fontScales["11/Ubuntu-L.ttf"], fonts["11/Ubuntu-L.ttf"], "center", "top")
    end
    x = x + 12
    dxDrawText(radioBrightness, x, y, x + 24, 0, tocolor(60, 184, 130, 255 * progress), fontScales["11/Ubuntu-L.ttf"], fonts["11/Ubuntu-L.ttf"], "center", "top")
    x = x + 24
    if cx and cx >= x and cx <= x + 12 and cy >= y and cy <= y + fontHeights["11/Ubuntu-L.ttf"] then
      hover = "plusBrightness"
      dxDrawText(">", x, y, x + 12, 0, tocolor(60, 184, 130, 255 * progress), fontScales["11/Ubuntu-L.ttf"], fonts["11/Ubuntu-L.ttf"], "center", "top")
    else
      dxDrawText(">", x, y, x + 12, 0, tocolor(255, 255, 255, 255 * progress), fontScales["11/Ubuntu-L.ttf"], fonts["11/Ubuntu-L.ttf"], "center", "top")
    end
    x = radioX + 57 + 8
    y = y + fontHeights["11/Ubuntu-L.ttf"] + 4
    sightlangStaticImageUsed[4] = true
    if sightlangStaticImageToc[4] then
      processsightlangStaticImage[4]()
    end
    dxDrawImage(x, y, math.floor(256), 2, sightlangStaticImage[4], 0, 0, 0, tocolor(220, 220, 220, 220 * progress))
    y = y + 8
    dxDrawText("Rendszerhangok: ", x, y, 0, 0, tocolor(255, 255, 255, 255 * progress), fontScales["11/Ubuntu-L.ttf"], fonts["11/Ubuntu-L.ttf"], "left", "top")
    x = x + dxGetTextWidth("Rendszerhangok: ", fontScales["11/Ubuntu-L.ttf"], fonts["11/Ubuntu-L.ttf"]) + 8
    if cx and cx >= x and cx <= x + 24 and cy >= y and cy <= y + fontHeights["11/Ubuntu-L.ttf"] then
      hover = "disableSystemAudio"
    end
    if not disableSystemAudio then
      dxDrawText("be", x, y, x + 24, 0, tocolor(60, 184, 130, 255 * progress), fontScales["11/Ubuntu-L.ttf"], fonts["11/Ubuntu-L.ttf"], "center", "top")
    else
      dxDrawText("ki", x, y, x + 24, 0, tocolor(243, 90, 90, 255 * progress), fontScales["11/Ubuntu-L.ttf"], fonts["11/Ubuntu-L.ttf"], "center", "top")
    end
    x = radioX + 57 + 8
    y = y + fontHeights["11/Ubuntu-L.ttf"] + 4
    sightlangStaticImageUsed[4] = true
    if sightlangStaticImageToc[4] then
      processsightlangStaticImage[4]()
    end
    dxDrawImage(x, y, math.floor(256), 2, sightlangStaticImage[4], 0, 0, 0, tocolor(220, 220, 220, 220 * progress))
  elseif currentMenu == "radio" or lastCurrentMenu == "radio" or currentMenu == "radiolist" or lastCurrentMenu == "radiolist" then
    drawBcg(x, y, progress)
    dxDrawRectangle(x, y + 293 - 48, 538, 48, tocolor(18, 18, 18, 255 * progress))
    local s = math.ceil(fontHeights["11/Ubuntu-L.ttf"] * 1.25)
    if cx and cx >= x + 4 and cy >= y + 4 and cx <= x + s + 4 and cy <= y + s + 4 and (not menuChange or getTickCount() - menuChange >= 1000) then
      hover = "menu:" .. (currentMenu == "radio" and "radiolist" or "radio")
    end
    dxDrawImage(x + 4, y + 4, s, s, ":sGui/" .. listIcon .. (faTicks[listIcon] or ""), 0, 0, 0, tocolor(255, 255, 255, 255 * progress))
    if cx and cx >= x and cy >= y + 293 - 48 and cx <= x + 48 and cy <= y + 293 then
      hover = "startstop"
    end
    if hover == "startstop" then
      if isElement(vehicleSounds[currentVehicle]) and radioState then
        sightlangStaticImageUsed[29] = true
        if sightlangStaticImageToc[29] then
          processsightlangStaticImage[29]()
        end
        dxDrawImage(x, y + 293 - 48, 48, 48, sightlangStaticImage[29], 0, 0, 0, tocolor(60, 184, 130, 255 * progress))
      else
        sightlangStaticImageUsed[30] = true
        if sightlangStaticImageToc[30] then
          processsightlangStaticImage[30]()
        end
        dxDrawImage(x, y + 293 - 48, 48, 48, sightlangStaticImage[30], 0, 0, 0, tocolor(60, 184, 130, 255 * progress))
      end
    elseif isElement(vehicleSounds[currentVehicle]) and radioState then
      sightlangStaticImageUsed[29] = true
      if sightlangStaticImageToc[29] then
        processsightlangStaticImage[29]()
      end
      dxDrawImage(x, y + 293 - 48, 48, 48, sightlangStaticImage[29], 0, 0, 0, tocolor(255, 255, 255, 105 * progress))
    else
      sightlangStaticImageUsed[30] = true
      if sightlangStaticImageToc[30] then
        processsightlangStaticImage[30]()
      end
      dxDrawImage(x, y + 293 - 48, 48, 48, sightlangStaticImage[30], 0, 0, 0, tocolor(255, 255, 255, 105 * progress))
    end
    dxDrawRectangle(x + 538 - 175 - 9, y + 293 - 24 + 14 - 6, 175, 3, tocolor(135, 135, 135, 255 * progress))
    if cy and cy >= y + 293 - 48 and cy <= y + 293 and cx >= x + 538 - 175 - 9 - 8 and cx <= x + 538 - 9 + 8 then
      hover = "volume"
    end
    if volumeSet then
      radioVolume = math.max(math.min(1, (cx - (x + 538 - 175 - 9)) / 175), 0)
      if isElement(vehicleSounds[currentVehicle]) then
        setStreamerModeVolume(vehicleSounds[currentVehicle], radioVolume)
      end
    end
    sightlangStaticImageUsed[3] = true
    if sightlangStaticImageToc[3] then
      processsightlangStaticImage[3]()
    end
    dxDrawImage(x + 538 - 175 - 9 + 171 * radioVolume, math.floor(y + 293 - 24 - 14), 4, 28, sightlangStaticImage[3], 0, 0, 0, tocolor(60, 184, 130, 255 * progress))
    dxDrawText(math.floor(radioVolume * 100 + 0.5) .. " % ", 0, math.floor(y + 293 - 24 - 14), x + 538 - 175 - 9 + 171 * radioVolume - 4, 0, tocolor(255, 255, 255, 255 * progress), fontScales["11/Ubuntu-L.ttf"], fonts["11/Ubuntu-L.ttf"], "right", "top")
    dxDrawText(rt.year - 100 .. "." .. month .. "." .. monthday .. " | " .. hour .. ":" .. minute, x, y + 4, x + 538 - 8, y + 64, tocolor(255, 255, 255, 255 * progress), fontScales["11/Ubuntu-L.ttf"], fonts["11/Ubuntu-L.ttf"], "right", "top", true)
    local id = 0
    x = x + 1
    y = y - 1
    local w = 134
    for i = 1, 4 do
      for j = 1, 2 do
        id = id + 1
        if cx and cx >= x + w * (i - 1) + 1 and cy >= y + 293 - 48 - 64 + 32 * (j - 1) + 1 and cx <= x + w * i + 1 and cy <= y + 293 - 48 - 64 + 32 * j + 1 then
          dxDrawRectangle(x + w * (i - 1) + 1, y + 293 - 48 - 64 + 32 * (j - 1) + 1, w - 2, 30, tocolor(44, 48, 52, 200 * progress))
          hover = "fav:" .. id
        else
          dxDrawRectangle(x + w * (i - 1) + 1, y + 293 - 48 - 64 + 32 * (j - 1) + 1, w - 2, 30, tocolor(34, 38, 42, 200 * progress))
        end
        if radioFavorites[id] and stationList[radioFavorites[id]] then
          local color = false
          if currentRadio == radioFavorites[id] then
            color = tocolor(60, 184, 130, 255 * progress)
          else
            color = tocolor(255, 255, 255, 200 * progress)
          end
          dxDrawText(stationList[radioFavorites[id]][2], x + w * (i - 1) + 5, y + 293 - 48 - 64 + 32 * (j - 1) + 5, x + w * i - 5, y + 293 - 48 - 64 + 32 * j - 5, color, fontScales["11/Ubuntu-L.ttf"] * 0.9, fonts["11/Ubuntu-L.ttf"], dxGetTextWidth(stationList[radioFavorites[id]][2], fontScales["11/Ubuntu-L.ttf"] * 0.9, fonts["11/Ubuntu-L.ttf"]) > 124.5 and "left" or "center", "center", true)
        end
      end
    end
    x = x - 1
    y = y + 1
    y = y + 8
    local p2 = (currentMenu == "radiolist" or lastCurrentMenu == "radiolist") and 1 or 0
    local p3 = (currentMenu == "radio" or lastCurrentMenu == "radio") and 1 or 0
    if currentMenu == "radio" and lastCurrentMenu == "radiolist" or currentMenu == "radiolist" and lastCurrentMenu == "radio" then
      p2 = (getTickCount() - menuChange) / 1000
      p2 = getEasingValue(math.min(p2, 1), "InOutQuad")
      p3 = 1 - p2
      if currentMenu == "radio" then
        p2, p3 = p3, p2
      end
    end
    if 0 < p2 then
      local y = y + 4 + s
      local h = 165 - s
      dxDrawRectangle(x + 4, y, 530, h, tocolor(34, 38, 42, 150 * progress * p2))
      local sh = h / (#stationList - 6 + 1)
      dxDrawRectangle(x + 538 - 4 - 2, y, 2, h, tocolor(34, 38, 42, 255 * progress * p2))
      dxDrawRectangle(x + 538 - 4 - 2, y + sh * radioListScroll, 2, sh, tocolor(60, 184, 130, 255 * progress * p2))
      h = h / 6
      for i = 1, 6 do
        if 1 <= progress and 1 <= p2 then
          if currentRadio == i + radioListScroll then
            dxDrawRectangle(x + 4, y, 528, h, tocolor(44, 48, 52, 170 * progress * p2))
            if cx and cx >= x + 4 and cx <= x + 538 - 4 and cy >= y and cy <= y + h then
              hover = "radiolist:" .. i
            end
          elseif cx and cx >= x + 4 and cx <= x + 538 - 4 and cy >= y and cy <= y + h then
            dxDrawRectangle(x + 4, y, 528, h, tocolor(44, 48, 52, 150 * progress * p2))
            hover = "radiolist:" .. i
          end
        end
        if stationList[i + radioListScroll] then
          local c = currentRadio == i + radioListScroll and tocolor(60, 184, 130, 255 * progress * p2) or tocolor(255, 255, 255, 200 * progress * p2)
          dxDrawText(stationList[i + radioListScroll][2], x + 4 + 4, y, x + 538 - 12 - 2, y + h, c, fontScales["11/Ubuntu-R.ttf"], fonts["11/Ubuntu-R.ttf"], "left", "center", true)
          if currentRadio == i + radioListScroll then
            local sx = x + 538 - 12 - 2 - 32
            if isElement(vehicleSounds[currentVehicle]) then
              local w = 3.2
              local soundSample = getSoundFFTData(vehicleSounds[currentVehicle], 1024, 24)
              if soundSample then
                for i = 1, 10 do
                  local p1 = math.min(1, math.max(0, soundSample[i * 2 - 1]))
                  local p2 = math.min(1, math.max(0, soundSample[i * 2]))
                  local hg = math.floor((h - 8) * (p1 + p2) + 0.5) + 5
                  if hg > h - 8 then
                    hg = h - 8
                  end
                  sightlangStaticImageUsed[3] = true
                  if sightlangStaticImageToc[3] then
                    processsightlangStaticImage[3]()
                  end
                  dxDrawImage(sx + w * (i - 1), y + h - 4 - hg, w / 2, hg, sightlangStaticImage[3], 0, 0, 0, tocolor(60, 184, 130, 255 * progress * p2))
                end
              end
            end
            dxDrawText(currentSong, x + 4 + 4 + dxGetTextWidth(stationList[i + radioListScroll][2], fontScales["11/Ubuntu-R.ttf"], fonts["11/Ubuntu-R.ttf"]) + 4, y, sx - 8, y + h, c, fontScales["11/Ubuntu-LI.ttf"], fonts["11/Ubuntu-LI.ttf"], "right", "center", true)
          end
          y = y + h
        end
      end
    end
    if 0 < p3 then
      if currentRadioChange then
        local move = (getTickCount() - currentRadioChange) / 1000
        move = getEasingValue(math.min(move, 1), "InOutQuad")
        if 1 <= move then
          currentRadioChange = false
        end
        if radioChangeDir then
          dxDrawText(lastStationName, x + 269 - lastStationWidth / 2 + (269 + lastStationWidth / 2) * move, y, x + 538 - 43 - 8, y + 293 - 48 - 64, tocolor(255, 255, 255, 255 * progress * p3), fontScales["24/BebasNeueLight.otf"], fonts["24/BebasNeueLight.otf"], "left", "center", true)
          dxDrawText(stationName, x + 43 + 8, y, x + (269 + stationWidth / 2) * move, y + 293 - 48 - 64, tocolor(255, 255, 255, 255 * progress * p3), fontScales["24/BebasNeueLight.otf"], fonts["24/BebasNeueLight.otf"], "right", "center", true)
        else
          dxDrawText(lastStationName, x + 43 + 8, y, x + (269 + lastStationWidth / 2) * (1 - move), y + 293 - 48 - 64, tocolor(255, 255, 255, 255 * progress * p3), fontScales["24/BebasNeueLight.otf"], fonts["24/BebasNeueLight.otf"], "right", "center", true)
          dxDrawText(stationName, x + 538 - 43 - 8 + (269 - stationWidth / 2 - 487) * move, y, x + 538 - 43 - 8, y + 293 - 48 - 64, tocolor(255, 255, 255, 255 * progress * p3), fontScales["24/BebasNeueLight.otf"], fonts["24/BebasNeueLight.otf"], "left", "center", true)
        end
      else
        dxDrawText(stationName, x + 269 - stationWidth / 2, y, x + 538, y + 293 - 48 - 64, tocolor(255, 255, 255, 255 * progress * p3), fontScales["24/BebasNeueLight.otf"], fonts["24/BebasNeueLight.otf"], "left", "center", true)
      end
      sightlangStaticImageUsed[28] = true
      if sightlangStaticImageToc[28] then
        processsightlangStaticImage[28]()
      end
      if cy and cy >= y + 90.5 - 11 and cy <= y + 90.5 + 11 then
        if cx >= x + 538 - 43 - 8 and cx <= x + 538 - 8 then
          hover = "next"
        elseif cx >= x + 8 and cx <= x + 8 + 43 then
          hover = "prev"
        end
      end
      if hover == "next" then
        sightlangStaticImageUsed[28] = true
        if sightlangStaticImageToc[28] then
          processsightlangStaticImage[28]()
        end
        dxDrawImage(x + 538 - 43 - 8, y + 90.5 - 11, 43, 22, sightlangStaticImage[28], 0, 0, 0, tocolor(60, 184, 130, 255 * progress * p3))
      else
        sightlangStaticImageUsed[28] = true
        if sightlangStaticImageToc[28] then
          processsightlangStaticImage[28]()
        end
        dxDrawImage(x + 538 - 43 - 8, y + 90.5 - 11, 43, 22, sightlangStaticImage[28], 0, 0, 0, tocolor(255, 255, 255, 105 * progress * p3))
      end
      if hover == "prev" then
        sightlangStaticImageUsed[28] = true
        if sightlangStaticImageToc[28] then
          processsightlangStaticImage[28]()
        end
        dxDrawImage(x + 8, y + 90.5 - 11, 43, 22, sightlangStaticImage[28], 180, 0, 0, tocolor(60, 184, 130, 255 * progress * p3))
      else
        sightlangStaticImageUsed[28] = true
        if sightlangStaticImageToc[28] then
          processsightlangStaticImage[28]()
        end
        dxDrawImage(x + 8, y + 90.5 - 11, 43, 22, sightlangStaticImage[28], 180, 0, 0, tocolor(255, 255, 255, 105 * progress * p3))
      end
      local w = math.floor(134.5)
      sightlangStaticImageUsed[4] = true
      if sightlangStaticImageToc[4] then
        processsightlangStaticImage[4]()
      end
      dxDrawImage(x + 269 - w, y + 90.5 + 8 + fontHeights["24/BebasNeueLight.otf"] / 2, w, 2, sightlangStaticImage[4], 180, 0, 0, tocolor(60, 184, 130, 255 * progress * p3))
      sightlangStaticImageUsed[4] = true
      if sightlangStaticImageToc[4] then
        processsightlangStaticImage[4]()
      end
      dxDrawImage(x + 269, y + 90.5 + 8 + fontHeights["24/BebasNeueLight.otf"] / 2, w, 2, sightlangStaticImage[4], 0, 0, 0, tocolor(60, 184, 130, 255 * progress * p3))
      if currentSongChange then
        dxDrawText(currentSong, x + 269 - currentWidth / 2, y + 90.5 + 8 + fontHeights["24/BebasNeueLight.otf"] / 2 + 10, x + 538, y + 90.5 + 8 + fontHeights["24/BebasNeueLight.otf"] / 2 + 10 + fontHeights["11/Ubuntu-LI.ttf"] * songMove, tocolor(255, 255, 255, 255 * progress * p3), fontScales["11/Ubuntu-LI.ttf"], fonts["11/Ubuntu-LI.ttf"], "left", "top", true)
        dxDrawText(lastCurrentSong, x + 269 - lastCurrentWidth / 2, y + 90.5 + 8 + fontHeights["24/BebasNeueLight.otf"] / 2 + 10 + fontHeights["11/Ubuntu-LI.ttf"] * songMove, x + 538, y + 90.5 + 8 + fontHeights["24/BebasNeueLight.otf"] / 2 + 10 + fontHeights["11/Ubuntu-LI.ttf"], tocolor(255, 255, 255, 255 * progress * p3), fontScales["11/Ubuntu-LI.ttf"], fonts["11/Ubuntu-LI.ttf"], "left", "bottom", true)
      else
        dxDrawText(currentSong, x + 269 - currentWidth / 2, y + 90.5 + 8 + fontHeights["24/BebasNeueLight.otf"] / 2 + 10, x + 538, y + 293 - 48 - 64, tocolor(255, 255, 255, 255 * progress * p3), fontScales["11/Ubuntu-LI.ttf"], fonts["11/Ubuntu-LI.ttf"], "left", "top", true)
      end
      if isElement(vehicleSounds[currentVehicle]) then
        local w = math.floor((stationWidth + 4) / 10)
        local bx = math.floor(x + 269 - (stationWidth + 4) / 2)
        local by = math.floor(y + 90.5 - fontHeights["24/BebasNeueLight.otf"] / 2)
        local soundSample = getSoundFFTData(vehicleSounds[currentVehicle], 1024, 24)
        if soundSample then
          for i = 1, 10 do
            local p1 = math.min(1, math.max(0, soundSample[i * 2 - 1]))
            local p2 = math.min(1, math.max(0, soundSample[i * 2]))
            local h = math.floor(65 * (p1 + p2) + 0.5) + 5
            if 65 < h then
              h = 65
            end
            sightlangStaticImageUsed[3] = true
            if sightlangStaticImageToc[3] then
              processsightlangStaticImage[3]()
            end
            dxDrawImage(bx + w * (i - 1) + 2, by - h, w - 4, h, sightlangStaticImage[3], 0, 0, 0, tocolor(60, 184, 130, 255 * progress * p3))
          end
        end
      end
    end
    if not (1 <= p2) and not (1 <= p3) then
      hover = false
    end
  end
  if hover ~= currentHover and 1 >= getPedOccupiedVehicleSeat(localPlayer) then
    currentHover = hover
    sightexports.sGui:setCursorType(hover and "link" or "normal")
    if currentHover then
      local cmd = split(currentHover, ":")
      if cmd[1] == "fav" then
        sightexports.sGui:showTooltip("Mentéshez tartsd nyomva")
      elseif cmd[1] == "airridesoftness" then
        sightexports.sGui:showTooltip("Airride keménység")
      elseif cmd[1] == "airride" then
        sightexports.sGui:showTooltip("Airride hasmagasság")
      elseif cmd[1] == "airridebias" then
        sightexports.sGui:showTooltip("Airride dőlés")
      elseif cmd[1] == "airridememory" then
        sightexports.sGui:showTooltip("Kattintás: memória betöltése\nNyomva tartás (pittyenésig): memória mentés")
      else
        sightexports.sGui:showTooltip(false)
      end
    else
      sightexports.sGui:showTooltip(false)
    end
  end
  if currentMenu ~= "off" or 0 < progress then
    local prog = (currentMenu == "off" or currentMenu == "on") and progress or 1
    if radioBrightness < 5 then
      local a = (5 - radioBrightness) / 5 * 195
      dxDrawRectangle(radioX + 57, radioY + 19, 538, 293, tocolor(10, 10, 10, a * prog))
    end
    sightlangStaticImageUsed[32] = true
    if sightlangStaticImageToc[32] then
      processsightlangStaticImage[32]()
    end
    dxDrawImage(radioX, radioY, sizeX, sizeY, sightlangStaticImage[32], 0, 0, 0, tocolor(255, 255, 255, 200 * (radioBrightness / 10) * prog))
  end
  sightlangStaticImageUsed[33] = true
  if sightlangStaticImageToc[33] then
    processsightlangStaticImage[33]()
  end
  dxDrawImage(radioX, radioY, sizeX, sizeY, sightlangStaticImage[33])
  if 0 < scratchLevel then
    sightlangStaticImageUsed[34] = true
    if sightlangStaticImageToc[34] then
      processsightlangStaticImage[34]()
    end
    dxDrawImage(radioX, radioY, sizeX, sizeY, sightlangStaticImage[34], 0, 0, 0, tocolor(255, 255, 255, 255 * scratchLevel))
  end
  if radioCrashed then
    sightlangStaticImageUsed[35] = true
    if sightlangStaticImageToc[35] then
      processsightlangStaticImage[35]()
    end
    dxDrawImage(radioX, radioY, sizeX, sizeY, sightlangStaticImage[35], 0, 0, 0, tocolor(255, 255, 255, 178.5))
  end
end
function carTuneRadio(veh)
end
addEventHandler("onClientVehicleDataChange", getRootElement(), function(data, was, new)
  if source == currentVehicle then
    if data == "performance.ecu" then
      if (new and tonumber(new)) and new ~= 4 and currentMenu == "ecu" then
        currentMenu = "home"
        setElementData(currentVehicle, "vehradio.menu", "home")
      end
    elseif data == "vehradio.broken" then
      radioCrashed = new
      checkVehicleRadio2D()
    elseif data == "vehradio.wallpaper" then
      radioWallpaper = new or 0
      if not disableSystemAudio then
        local sound = playSound("files/button.wav")
        if radioCrashed then
          setSoundEffectEnabled(sound, "distortion", true)
        end
      end
    elseif data == "vehradio.brightness" then
      radioBrightness = new or 6
      if not disableSystemAudio then
        local sound = playSound("files/button.wav")
        if radioCrashed then
          setSoundEffectEnabled(sound, "distortion", true)
        end
      end
    elseif data == "vehradio.sysAudio" then
      disableSystemAudio = new
      if not disableSystemAudio then
        local sound = playSound("files/button.wav")
        if radioCrashed then
          setSoundEffectEnabled(sound, "distortion", true)
        end
      end
    elseif data == "vehradio.state" then
      radioState = new
      if isElement(vehicleSounds[currentVehicle]) then
        destroyElement(vehicleSounds[currentVehicle])
      end
      if radioState then
        vehicleSounds[currentVehicle] = playSound(stationList[currentRadio][1], true)
        setStreamerModeVolume(vehicleSounds[currentVehicle], radioVolume)
        if radioCrashed then
          setSoundEffectEnabled(vehicleSounds[currentVehicle], "distortion", true)
        end
      else
        vehicleSounds[currentVehicle] = false
      end
    elseif data == "vehradio.favorites" then
      radioFavorites = new or {}
      local sound = "fav"
      local sum = 0
      for k in pairs(radioFavorites) do
        if radioFavorites[k] and stationList[radioFavorites[k]] then
          sum = sum + 1
        end
      end
      local sum2 = 0
      for k in pairs(was or {}) do
        if was[k] and stationList[was[k]] then
          sum2 = sum2 + 1
        end
      end
      if sum < sum2 then
        sound = "delfav"
      end
      if not disableSystemAudio then
        local sound = playSound("files/" .. sound .. ".wav")
        if radioCrashed then
          setSoundEffectEnabled(sound, "distortion", true)
        end
      end
    elseif data == "vehradio.menu" then
      local menu = new or "off"
      if menu == "off" then
        setElementData(currentVehicle, "vehradio.state", false)
      end
      if was == "off" or not was then
        if not disableSystemAudio then
          local sound = playSound("files/on.wav")
          if radioCrashed then
            setSoundEffectEnabled(sound, "distortion", true)
          end
        end
        setMenu("on")
      else
        setMenu(menu)
        if not disableSystemAudio then
          local sound = playSound("files/menu.wav")
          if radioCrashed then
            setSoundEffectEnabled(sound, "distortion", true)
          end
        end
      end
    elseif data == "vehradio.volume" then
      radioVolume = new or 1
      if isElement(vehicleSounds[currentVehicle]) then
        setStreamerModeVolume(vehicleSounds[currentVehicle], radioVolume)
      end
    elseif data == "vehradio.station" then
      currentRadio = tonumber(new) or 1
      setCurrentStation(currentRadio)
      local dir = currentRadio - (was or 0)
      radioChangeDir = (not (0 < dir) or not (dir <= 1)) and not (dir < -1)
      if not disableSystemAudio then
        local sound = playSound("files/button.wav")
        if radioCrashed then
          setSoundEffectEnabled(sound, "distortion", true)
        end
      end
    end
  elseif data == "vehradio.volume" then
    if isElement(vehicleSounds[source]) then
      if isElementStreamedIn(source) and source ~= currentVehicle then
        checkVehicleRadioWindow(source)
      else
        setStreamerModeVolume(vehicleSounds[source], new or 1)
      end
    end
  elseif data == "vehicle.windowState" or data == "vehradio.broken" then
    if isElementStreamedIn(source) and source ~= currentVehicle then
      checkVehicleRadioWindow(source)
    end
  elseif data == "vehradio.station" or data == "vehradio.state" then
    checkVehicleRadio3D(source)
  end
end)
function setFavorite()
  favoriteSetTimer = false
  if currentVehicle and currentHover then
    local cmd = split(currentHover, ":")
    if cmd[1] == "fav" then
      local id = tonumber(cmd[2]) or 1
      if id then
        radioFavorites[id] = currentRadio
        setElementData(currentVehicle, "vehradio.favorites", radioFavorites)
      end
    end
  end
end
function setVolumeButton(cmd)
  if cmd == "volPlus" then
    radioVolume = radioVolume + 0.05
    if 1 < radioVolume then
      radioVolume = 1
    end
    setElementData(currentVehicle, "vehradio.volume", radioVolume)
  elseif cmd == "volMinus" then
    radioVolume = radioVolume - 0.05
    if radioVolume < 0 then
      radioVolume = 0
    end
    setElementData(currentVehicle, "vehradio.volume", radioVolume)
  end
end
local lastChange = 0
function setFavoriteAirride()
  favoriteSetTimer = false
  if currentVehicle and currentHover then
    local cmd = split(currentHover, ":")
    if cmd[1] == "airridememory" then
      local id = tonumber(cmd[2]) or 1
      if id then
        triggerServerEvent("saveVehicleAirrideFavorite", currentVehicle, id)
        local sound = playSound("files/fav.wav")
      end
    end
  end
end
local lastAirrideLoad = 0
function clickRadio(button, state, cx, cy)
  if getElementData(localPlayer, "cuffed") then
    return
  end
  if state == "up" and radioMove then
    radioMove = false
  elseif state == "up" and volumeTimer then
    if isTimer(volumeTimer) then
      killTimer(volumeTimer)
    end
    volumeTimer = false
  elseif state == "up" and favoriteSetTimer then
    if isTimer(favoriteSetTimer) then
      killTimer(favoriteSetTimer)
    end
    favoriteSetTimer = false
    if currentHover then
      local cmd = split(currentHover, ":")
      if cmd[1] == "airridememory" then
        local id = tonumber(cmd[2]) or 1
        triggerServerEvent("loadVehicleAirrideFavorite", currentVehicle, id, getElementsByType("player", getRootElement(), true))
      elseif cmd[1] == "fav" then
        local id = tonumber(cmd[2]) or 1
        if radioFavorites[id] and stationList[radioFavorites[id]] then
          setElementData(currentVehicle, "vehradio.station", radioFavorites[id])
        end
      end
    end
  elseif state == "up" and volumeSet then
    volumeSet = false
    setElementData(currentVehicle, "vehradio.volume", radioVolume)
  elseif state == "down" then
    if currentHover then
      local cmd = split(currentHover, ":")
      if cmd[1] == "neonside" then
        triggerServerEvent("refreshNeonColor", currentVehicle, "side", cmd[2])
        local sound = playSound("files/savestats.wav")
        if radioCrashed then
          setSoundEffectEnabled(sound, "distortion", true)
        end
      elseif cmd[1] == "neonfront" then
        triggerServerEvent("refreshNeonColor", currentVehicle, "front", cmd[2])
        local sound = playSound("files/savestats.wav")
        if radioCrashed then
          setSoundEffectEnabled(sound, "distortion", true)
        end
      elseif cmd[1] == "drivetype" then
        triggerServerEvent("setCurrentVehicleDriveType", currentVehicle, cmd[2])
        local sound = playSound("files/savestats.wav")
        if radioCrashed then
          setSoundEffectEnabled(sound, "distortion", true)
        end
      elseif cmd[1] == "saveECU" then
        triggerServerEvent("saveEcuData", currentVehicle, ecuBalanceValue, ecuValues)
        local sound = playSound("files/savestats.wav")
        if radioCrashed then
          setSoundEffectEnabled(sound, "distortion", true)
        end
      elseif cmd[1] == "resetECU" then
        ecuBalanceValue = savedEcuBalanceValue
        for i = 1, #ecuValues do
          ecuValues[i] = savedEcuValues[i]
        end
        local sound = playSound("files/reset.wav")
        if radioCrashed then
          setSoundEffectEnabled(sound, "distortion", true)
        end
      elseif cmd[1] == "airridememory" then
        if not airrideSettingLevel and not airrideSettingBias and not airrideSettingSoftness and getTickCount() - lastAirrideLoad > 2000 then
          favoriteSetTimer = setTimer(setFavoriteAirride, 1000, 1)
          lastAirrideLoad = getTickCount()
        end
      elseif cmd[1] == "airridesoftness" then
        if not airrideSettingLevel and not airrideSettingBias and not airrideSettingSoftness then
          if cmd[2] == "up" then
            if -4 < airrideSoftness then
              airrideSettingSoftness = airrideSoftness - 1
              triggerServerEvent("setVehicleAirRideSoftness", currentVehicle, airrideSettingSoftness, getElementsByType("player", getRootElement(), true))
            end
          elseif cmd[2] == "down" then
            if airrideSoftness < 4 then
              airrideSettingSoftness = airrideSoftness + 1
              triggerServerEvent("setVehicleAirRideSoftness", currentVehicle, airrideSettingSoftness, getElementsByType("player", getRootElement(), true))
            end
          elseif tonumber(cmd[2]) and tonumber(cmd[2]) >= -4 and tonumber(cmd[2]) <= 4 then
            airrideSettingSoftness = tonumber(cmd[2])
            triggerServerEvent("setVehicleAirRideSoftness", currentVehicle, airrideSettingSoftness, getElementsByType("player", getRootElement(), true))
          end
        end
      elseif cmd[1] == "airridebias" then
        if not airrideSettingLevel and not airrideSettingBias and not airrideSettingSoftness then
          if cmd[2] == "up" then
            if -4 < airrideBias then
              airrideSettingBias = airrideBias - 1
              triggerServerEvent("setVehicleAirRideBias", currentVehicle, airrideSettingBias, getElementsByType("player", getRootElement(), true))
            end
          elseif cmd[2] == "down" then
            if airrideBias < 4 then
              airrideSettingBias = airrideBias + 1
              triggerServerEvent("setVehicleAirRideBias", currentVehicle, airrideSettingBias, getElementsByType("player", getRootElement(), true))
            end
          elseif tonumber(cmd[2]) and tonumber(cmd[2]) >= -4 and tonumber(cmd[2]) <= 4 then
            airrideSettingBias = tonumber(cmd[2])
            triggerServerEvent("setVehicleAirRideBias", currentVehicle, airrideSettingBias, getElementsByType("player", getRootElement(), true))
          end
        end
      elseif cmd[1] == "airride" then
        if not airrideSettingLevel and not airrideSettingBias and not airrideSettingSoftness then
          if cmd[2] == "up" then
            if -7 < airrideLevel then
              airrideSettingLevel = airrideLevel - 1
              triggerServerEvent("setVehicleAirRideLevel", currentVehicle, airrideSettingLevel, getElementsByType("player", getRootElement(), true))
            end
          elseif cmd[2] == "down" then
            if airrideLevel < 7 then
              airrideSettingLevel = airrideLevel + 1
              triggerServerEvent("setVehicleAirRideLevel", currentVehicle, airrideSettingLevel, getElementsByType("player", getRootElement(), true))
            end
          elseif tonumber(cmd[2]) and 1 <= tonumber(cmd[2]) and tonumber(cmd[2]) <= 15 then
            airrideSettingLevel = tonumber(cmd[2]) - 8
            triggerServerEvent("setVehicleAirRideLevel", currentVehicle, airrideSettingLevel, getElementsByType("player", getRootElement(), true))
          end
        end
      elseif cmd[1] == "menu" then
        if cmd[2] == "ecu" then
          if not ecuBalanceValue then
            sightexports.sGui:showInfobox("e", "A menüpont használatához Állítható Venom ECU-ra van szükséged!")
            return
          end
        elseif cmd[2] == "airride" then
          if not airrideLevel then
            sightexports.sGui:showInfobox("e", "A menüpont használatához AirRide szettre van szükséged!")
            return
          end
        elseif cmd[2] == "neon" then
          if not hasNeon then
            sightexports.sGui:showInfobox("e", "A menüpont használatához állítható neon szettre van szükséged!")
            return
          end
        elseif cmd[2] == "awd" and not currentDriveType then
          sightexports.sGui:showInfobox("e", "A menüpont használatához állítható AWD meghajtásra van szükséged!")
          return
        end
        setElementData(currentVehicle, "vehradio.menu", cmd[2])
      elseif cmd[1] == "disableSystemAudio" then
        setElementData(currentVehicle, "vehradio.sysAudio", not disableSystemAudio)
      elseif cmd[1] == "plusBrightness" then
        if radioBrightness < 10 then
          radioBrightness = radioBrightness + 1
          setElementData(currentVehicle, "vehradio.brightness", radioBrightness)
        end
      elseif cmd[1] == "minusBrightness" then
        if 1 < radioBrightness then
          radioBrightness = radioBrightness - 1
          setElementData(currentVehicle, "vehradio.brightness", radioBrightness)
        end
      elseif cmd[1] == "nextWallpaper" then
        radioWallpaper = radioWallpaper + 1
        if 39 < radioWallpaper then
          radioWallpaper = 0
        end
        setElementData(currentVehicle, "vehradio.wallpaper", radioWallpaper)
      elseif cmd[1] == "prevWallpaper" then
        radioWallpaper = radioWallpaper - 1
        if radioWallpaper < 0 then
          radioWallpaper = 39
        end
        setElementData(currentVehicle, "vehradio.wallpaper", radioWallpaper)
      elseif cmd[1] == "radiolist" then
        if not currentRadioChange and getTickCount() - lastChange > 250 then
          local id = (tonumber(cmd[2]) or 0) + radioListScroll
          if id ~= currentRadio and stationList[id] then
            lastChange = getTickCount()
            currentRadio = id
            setElementData(currentVehicle, "vehradio.station", currentRadio)
          end
        end
      elseif cmd[1] == "fav" then
        local id = tonumber(cmd[2]) or 1
        if button == "right" then
          radioFavorites[id] = false
          setElementData(currentVehicle, "vehradio.favorites", radioFavorites)
        else
          favoriteSetTimer = setTimer(setFavorite, 1000, 1)
        end
      elseif cmd[1] == "volPlus" or cmd[1] == "volMinus" then
        setVolumeButton(cmd[1])
        if isTimer(volumeTimer) then
          killTimer(volumeTimer)
        end
        volumeTimer = setTimer(setVolumeButton, 300, 0, cmd[1])
      elseif cmd[1] == "volume" then
        volumeSet = true
      elseif cmd[1] == "startstop" then
        radioState = not radioState
        setElementData(currentVehicle, "vehradio.state", radioState)
      elseif cmd[1] == "toggle" then
        if currentMenu == "off" then
          setElementData(currentVehicle, "vehradio.menu", "home")
        else
          setElementData(currentVehicle, "vehradio.menu", "off")
        end
      elseif cmd[1] == "next" then
        if not currentRadioChange and getTickCount() - lastChange > 250 then
          lastChange = getTickCount()
          currentRadio = currentRadio + 1
          if currentRadio > #stationList then
            currentRadio = 1
          end
          setElementData(currentVehicle, "vehradio.station", currentRadio)
        end
      elseif cmd[1] == "prev" and not currentRadioChange and getTickCount() - lastChange > 250 then
        lastChange = getTickCount()
        currentRadio = currentRadio - 1
        if currentRadio < 1 then
          currentRadio = #stationList
        end
        setElementData(currentVehicle, "vehradio.station", currentRadio)
      end
    elseif cx >= radioX and cy >= radioY and cx <= radioX + sizeX and cy <= radioY + sizeY and (cx <= radioX + 57 or cy <= radioY + 19 or cx >= radioX + 57 + 538 or cy >= radioY + 19 + 293) then
      radioMove = {
        cx,
        cy,
        radioX,
        radioY
      }
    end
  end
end
function setCurrentStation(id)
  if currentMenu == "radio" then
    currentRadioChange = getTickCount()
  end
  lastStationName = stationName
  lastStationWidth = stationWidth
  stationName = stationList[id][2] or ""
  if fonts["24/BebasNeueLight.otf"] then
    stationWidth = dxGetTextWidth(stationName, fontScales["24/BebasNeueLight.otf"], fonts["24/BebasNeueLight.otf"])
  else
    stationWidth = 0
  end
  if isElement(vehicleSounds[currentVehicle]) then
    destroyElement(vehicleSounds[currentVehicle])
  end
  if radioState then
    vehicleSounds[currentVehicle] = playSound(stationList[id][1], true)
    setStreamerModeVolume(vehicleSounds[currentVehicle], radioVolume)
    if radioCrashed then
      setSoundEffectEnabled(vehicleSounds[currentVehicle], "distortion", true)
    end
  else
    vehicleSounds[currentVehicle] = false
  end
end
local lastWheel = 0
function keyRadio(key, por)
  if getTickCount() - lastWheel > 250 and getPedOccupiedVehicleSeat(localPlayer) <= 1 and (key == "mouse_wheel_up" or key == "mouse_wheel_down") then
    if getElementData(localPlayer, "cuffed") then
      return
    end
    local on = getCachedData(currentVehicle, "vehradio.menu") or "off"
    if on == "off" then
      return
    end
    if currentHover == "volume" then
      if key == "mouse_wheel_up" then
        setVolumeButton("volPlus")
        lastWheel = getTickCount()
      elseif key == "mouse_wheel_down" then
        setVolumeButton("volMinus")
        lastWheel = getTickCount()
      end
    elseif currentHover and utf8.find(currentHover, "radiolist") then
      if key == "mouse_wheel_up" then
        if 0 < radioListScroll then
          radioListScroll = radioListScroll - 1
        end
      elseif key == "mouse_wheel_down" and radioListScroll < #stationList - 6 then
        radioListScroll = radioListScroll + 1
      end
    elseif key == "mouse_wheel_down" then
      if not currentRadioChange then
        currentRadio = currentRadio + 1
        if currentRadio > #stationList then
          currentRadio = 1
        end
        setElementData(currentVehicle, "vehradio.station", currentRadio)
        lastWheel = getTickCount()
      end
    elseif key == "mouse_wheel_up" and not currentRadioChange then
      currentRadio = currentRadio - 1
      if currentRadio < 1 then
        currentRadio = #stationList
      end
      setElementData(currentVehicle, "vehradio.station", currentRadio)
      lastWheel = getTickCount()
    end
  end
end
function setCurrentSong(text)
  currentSongChange = getTickCount()
  if utf8.len(text) > 50 then
    text = utf8.sub(text, 1, 50) .. "..."
  end
  lastCurrentSong = currentSong
  lastCurrentWidth = currentWidth
  currentSong = text
  currentWidth = dxGetTextWidth(currentSong, fontScales["11/Ubuntu-LI.ttf"], fonts["11/Ubuntu-LI.ttf"])
end
function toggleRadio()
  radioOpened = not radioOpened
  if radioOpened then
    if not currentVehicle then
      radioOpened = false
    else
      addEventHandler("onClientRender", getRootElement(), renderRadio)
      addEventHandler("onClientClick", getRootElement(), clickRadio)
      addEventHandler("onClientKey", getRootElement(), keyRadio)
      fonts["24/BebasNeueLight.otf"] = sightexports.sGui:getFont("24/BebasNeueLight.otf")
      fontScales["24/BebasNeueLight.otf"] = sightexports.sGui:getFontScale("24/BebasNeueLight.otf")
      fontHeights["24/BebasNeueLight.otf"] = sightexports.sGui:getFontHeight("24/BebasNeueLight.otf")
      fonts["22/BebasNeueBold.otf"] = sightexports.sGui:getFont("22/BebasNeueBold.otf")
      fontScales["22/BebasNeueBold.otf"] = sightexports.sGui:getFontScale("22/BebasNeueBold.otf")
      fontHeights["22/BebasNeueBold.otf"] = sightexports.sGui:getFontHeight("22/BebasNeueBold.otf")
      fonts["18/BebasNeueBold.otf"] = sightexports.sGui:getFont("18/BebasNeueBold.otf")
      fontScales["18/BebasNeueBold.otf"] = sightexports.sGui:getFontScale("18/BebasNeueBold.otf")
      fontHeights["18/BebasNeueBold.otf"] = sightexports.sGui:getFontHeight("18/BebasNeueBold.otf")
      fonts["15/BebasNeueBold.otf"] = sightexports.sGui:getFont("15/BebasNeueBold.otf")
      fontScales["15/BebasNeueBold.otf"] = sightexports.sGui:getFontScale("15/BebasNeueBold.otf")
      fontHeights["15/BebasNeueBold.otf"] = sightexports.sGui:getFontHeight("15/BebasNeueBold.otf")
      fonts["11/Ubuntu-L.ttf"] = sightexports.sGui:getFont("11/Ubuntu-L.ttf")
      fontScales["11/Ubuntu-L.ttf"] = sightexports.sGui:getFontScale("11/Ubuntu-L.ttf")
      fontHeights["11/Ubuntu-L.ttf"] = sightexports.sGui:getFontHeight("11/Ubuntu-L.ttf")
      fonts["11/Ubuntu-R.ttf"] = sightexports.sGui:getFont("11/Ubuntu-R.ttf")
      fontScales["11/Ubuntu-R.ttf"] = sightexports.sGui:getFontScale("11/Ubuntu-R.ttf")
      fontHeights["11/Ubuntu-R.ttf"] = sightexports.sGui:getFontHeight("11/Ubuntu-R.ttf")
      fonts["11/Ubuntu-LI.ttf"] = sightexports.sGui:getFont("11/Ubuntu-LI.ttf")
      fontScales["11/Ubuntu-LI.ttf"] = sightexports.sGui:getFontScale("11/Ubuntu-LI.ttf")
      fontHeights["11/Ubuntu-LI.ttf"] = sightexports.sGui:getFontHeight("11/Ubuntu-LI.ttf")
      fonts["11/Ubuntu-B.ttf"] = sightexports.sGui:getFont("11/Ubuntu-B.ttf")
      fontScales["11/Ubuntu-B.ttf"] = sightexports.sGui:getFontScale("11/Ubuntu-B.ttf")
      fontHeights["11/Ubuntu-B.ttf"] = sightexports.sGui:getFontHeight("11/Ubuntu-B.ttf")
      radarW = 538
      radarH = 293
      if isElement(finalRt) then
        destroyElement(finalRt)
      end
      if isElement(baseRt) then
        destroyElement(baseRt)
      end
      if isElement(baseShader) then
        destroyElement(baseShader)
      end
      if isElement(playerRt) then
        destroyElement(playerRt)
      end
      if isElement(playerShader) then
        destroyElement(playerShader)
      end
      finalRt = dxCreateRenderTarget(radarW, radarH)
      baseRt = dxCreateRenderTarget(radarInnerSize, radarInnerSize)
      playerRt = dxCreateRenderTarget(41, 43, true)
      playerShader = dxCreateShader(blankShader)
      dxSetShaderValue(playerShader, "texture0", playerRt)
      dxSetShaderTransform(playerShader, 0, radarRot, 0)
      baseShader = dxCreateShader(blankShader)
      dxSetShaderValue(baseShader, "texture0", baseRt)
      dxSetShaderTransform(baseShader, 0, radarRot, 0)
      radioFavorites = getCachedData(currentVehicle, "vehradio.favorites") or {}
      radioVolume = getCachedData(currentVehicle, "vehradio.volume") or 1
      currentRadio = getCachedData(currentVehicle, "vehradio.station") or 1
      radioCrashed = getCachedData(currentVehicle, "vehradio.broken")
      stationName = stationList[currentRadio][2]
      stationWidth = dxGetTextWidth(stationName, fontScales["24/BebasNeueLight.otf"], fonts["24/BebasNeueLight.otf"])
      currentMenu = getCachedData(currentVehicle, "vehradio.menu") or "off"
      radioWallpaper = getCachedData(currentVehicle, "vehradio.wallpaper") or 0
      radioBrightness = getCachedData(currentVehicle, "vehradio.brightness") or 6
      disableSystemAudio = getCachedData(currentVehicle, "vehradio.sysAudio")
      if currentMenu == "home" and 1 > (getTickCount() - radioOn) / 2500 then
        currentMenu = "on"
      end
      fuelMaxLiters = sightexports.sVehicles:getTankSize(currentVehicle)
      fuelConsumption = sightexports.sVehicles:getFuelConsumption(currentVehicle)
      if getElementData(currentVehicle, "performance.ecu") ~= 4 and currentMenu == "ecu" then
        currentMenu = "home"
        setElementData(currentVehicle, "vehradio.menu", "home")
      end
    end
  else
    sightexports.sGui:setCursorType("normal")
    sightexports.sGui:showTooltip(false)
    removeEventHandler("onClientRender", getRootElement(), renderRadio)
    removeEventHandler("onClientClick", getRootElement(), clickRadio)
    removeEventHandler("onClientKey", getRootElement(), keyRadio)
    if isElement(finalRt) then
      destroyElement(finalRt)
    end
    finalRt = false
    if isElement(baseRt) then
      destroyElement(baseRt)
    end
    baseRt = false
    if isElement(baseShader) then
      destroyElement(baseShader)
    end
    baseShader = false
    if isElement(playerRt) then
      destroyElement(playerRt)
    end
    playerRt = false
    if isElement(playerShader) then
      destroyElement(playerShader)
    end
    playerShader = false
  end
end
bindKey("r", "down", toggleRadio)
local radioWidgetState = false
local widgetPos = {}
local widgetSize = {}
local radioAlpha = 0
local songTitleWidgetTmp = false
local radioWidgetTmp = false
local lastRadio = 0
local lastTickWidget = 0
local widgetSide = false
function renderRadioWidget()
  local radioName = "Kikapcsolva"
  local streamTitle = "Kikapcsolva"
  if currentVehicle and radioState and currentRadio then
    streamTitle = "N/A"
    if isElement(vehicleSounds[currentVehicle]) then
      local metaTags = getSoundMetaTags(vehicleSounds[currentVehicle])
      if metaTags and metaTags.stream_title then
        streamTitle = metaTags.stream_title
        if utf8.len(streamTitle) > 60 then
          streamTitle = utf8.sub(streamTitle, 1, 60) .. "..."
        end
      end
    end
    radioName = stationList[currentRadio][2]
  end
  local now = getTickCount()
  local delta = now - lastTickWidget
  lastTickWidget = now
  if songTitleWidgetTmp ~= streamTitle or radioWidgetTmp ~= radioName then
    songTitleWidgetTmp = streamTitle
    radioWidgetTmp = radioName
    lastRadio = now
  end
  if now - lastRadio < 5000 then
    if radioAlpha < 1 then
      radioAlpha = radioAlpha + 4 * delta / 1000
      if 1 < radioAlpha then
        radioAlpha = 1
      end
    end
  elseif 0 < radioAlpha then
    radioAlpha = radioAlpha - 1 * delta / 1000
  end
  if 0 < radioAlpha then
    local x, y = unpack(widgetPos)
    local sx, sy = unpack(widgetSize)
    local is = sy / 2
    local fs = sy / 96
    if widgetSide then
      dxDrawImage(x + sx - is, y, is, is, ":sGui/" .. radioIcon .. (faTicks[radioIcon] or ""), 0, 0, 0, tocolor(hw[1], hw[2], hw[3], 180 * radioAlpha))
      dxDrawImage(x + sx - is, y + is, is, is, ":sGui/" .. songIcon .. (faTicks[songIcon] or ""), 0, 0, 0, tocolor(hw[1], hw[2], hw[3], 220 * radioAlpha))
      dxDrawText(radioWidgetTmp, x, y, x + sx - is * 1.1, y + is, tocolor(hw[1], hw[2], hw[3], 180 * radioAlpha), 1 * fs * fontScales["16/Ubuntu-R.ttf"], fonts["16/Ubuntu-R.ttf"], "right", "center", true)
      if dxGetTextWidth(streamTitle, 1 * fs * fontScales["18/Ubuntu-B.ttf"] * 0.9, fonts["18/Ubuntu-B.ttf"]) > sx - is * 1.1 then
        dxDrawText(streamTitle, x, y + is, x + sx - is * 1.1, y + is * 2, tocolor(hw[1], hw[2], hw[3], 220 * radioAlpha), 1 * fs * fontScales["18/Ubuntu-B.ttf"] * 0.9, fonts["18/Ubuntu-B.ttf"], "left", "center", true)
      else
        dxDrawText(streamTitle, x, y + is, x + sx - is * 1.1, y + is * 2, tocolor(hw[1], hw[2], hw[3], 220 * radioAlpha), 1 * fs * fontScales["18/Ubuntu-B.ttf"] * 0.9, fonts["18/Ubuntu-B.ttf"], "right", "center", true)
      end
    else
      dxDrawImage(x, y, is, is, ":sGui/" .. radioIcon .. (faTicks[radioIcon] or ""), 0, 0, 0, tocolor(hw[1], hw[2], hw[3], 180 * radioAlpha))
      dxDrawImage(x, y + is, is, is, ":sGui/" .. songIcon .. (faTicks[songIcon] or ""), 0, 0, 0, tocolor(hw[1], hw[2], hw[3], 220 * radioAlpha))
      dxDrawText(radioWidgetTmp, x + is * 1.1, y, x + sx, y + is, tocolor(hw[1], hw[2], hw[3], 180 * radioAlpha), 1 * fs * fontScales["16/Ubuntu-R.ttf"], fonts["16/Ubuntu-R.ttf"], "left", "center", true)
      dxDrawText(streamTitle, x + is * 1.1, y + is, x + sx, y + is * 2, tocolor(hw[1], hw[2], hw[3], 220 * radioAlpha), 1 * fs * fontScales["18/Ubuntu-B.ttf"] * 0.9, fonts["18/Ubuntu-B.ttf"], "left", "center", true)
    end
  end
end
addEvent("hudWidgetState:radio", true)
addEventHandler("hudWidgetState:radio", getRootElement(), function(state)
  if radioWidgetState ~= state then
    radioWidgetState = state
    if radioWidgetState then
      addEventHandler("onClientRender", getRootElement(), renderRadioWidget)
    else
      removeEventHandler("onClientRender", getRootElement(), renderRadioWidget)
    end
  end
end)
addEvent("hudWidgetPosition:radio", true)
addEventHandler("hudWidgetPosition:radio", getRootElement(), function(pos, final, car)
  widgetPos = pos
  if not car then
    lastRadio = getTickCount()
  end
  if widgetPos[1] and widgetSize[1] then
    widgetSide = widgetPos[1] + widgetSize[1] / 2 > screenX / 2
  end
end)
addEvent("hudWidgetSize:radio", true)
addEventHandler("hudWidgetSize:radio", getRootElement(), function(size, final)
  widgetSize = size
  lastRadio = getTickCount()
  if widgetPos[1] and widgetSize[1] then
    widgetSide = widgetPos[1] + widgetSize[1] / 2 > screenX / 2
  end
end)
triggerEvent("requestWidgetDatas", localPlayer, "radio")
function checkInsideVehicle()
  local veh = getPedOccupiedVehicle(localPlayer)
  if veh ~= currentVehicle then
    if isElement(veh) then
      vehicleEnter(veh)
    else
      onPlayerVehicleExit()
    end
  end
end
