local sightexports = {sModloader = false, sGui = false}
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
sightlangStaticImageToc[36] = true
sightlangStaticImageToc[37] = true
sightlangStaticImageToc[38] = true
sightlangStaticImageToc[39] = true
sightlangStaticImageToc[40] = true
sightlangStaticImageToc[41] = true
sightlangStaticImageToc[42] = true
sightlangStaticImageToc[43] = true
sightlangStaticImageToc[44] = true
sightlangStaticImageToc[45] = true
sightlangStaticImageToc[46] = true
sightlangStaticImageToc[47] = true
sightlangStaticImageToc[48] = true
sightlangStaticImageToc[49] = true
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
  if sightlangStaticImageUsed[36] then
    sightlangStaticImageUsed[36] = false
    sightlangStaticImageDel[36] = false
  elseif sightlangStaticImage[36] then
    if sightlangStaticImageDel[36] then
      if now >= sightlangStaticImageDel[36] then
        if isElement(sightlangStaticImage[36]) then
          destroyElement(sightlangStaticImage[36])
        end
        sightlangStaticImage[36] = nil
        sightlangStaticImageDel[36] = false
        sightlangStaticImageToc[36] = true
        return
      end
    else
      sightlangStaticImageDel[36] = now + 5000
    end
  else
    sightlangStaticImageToc[36] = true
  end
  if sightlangStaticImageUsed[37] then
    sightlangStaticImageUsed[37] = false
    sightlangStaticImageDel[37] = false
  elseif sightlangStaticImage[37] then
    if sightlangStaticImageDel[37] then
      if now >= sightlangStaticImageDel[37] then
        if isElement(sightlangStaticImage[37]) then
          destroyElement(sightlangStaticImage[37])
        end
        sightlangStaticImage[37] = nil
        sightlangStaticImageDel[37] = false
        sightlangStaticImageToc[37] = true
        return
      end
    else
      sightlangStaticImageDel[37] = now + 5000
    end
  else
    sightlangStaticImageToc[37] = true
  end
  if sightlangStaticImageUsed[38] then
    sightlangStaticImageUsed[38] = false
    sightlangStaticImageDel[38] = false
  elseif sightlangStaticImage[38] then
    if sightlangStaticImageDel[38] then
      if now >= sightlangStaticImageDel[38] then
        if isElement(sightlangStaticImage[38]) then
          destroyElement(sightlangStaticImage[38])
        end
        sightlangStaticImage[38] = nil
        sightlangStaticImageDel[38] = false
        sightlangStaticImageToc[38] = true
        return
      end
    else
      sightlangStaticImageDel[38] = now + 5000
    end
  else
    sightlangStaticImageToc[38] = true
  end
  if sightlangStaticImageUsed[39] then
    sightlangStaticImageUsed[39] = false
    sightlangStaticImageDel[39] = false
  elseif sightlangStaticImage[39] then
    if sightlangStaticImageDel[39] then
      if now >= sightlangStaticImageDel[39] then
        if isElement(sightlangStaticImage[39]) then
          destroyElement(sightlangStaticImage[39])
        end
        sightlangStaticImage[39] = nil
        sightlangStaticImageDel[39] = false
        sightlangStaticImageToc[39] = true
        return
      end
    else
      sightlangStaticImageDel[39] = now + 5000
    end
  else
    sightlangStaticImageToc[39] = true
  end
  if sightlangStaticImageUsed[40] then
    sightlangStaticImageUsed[40] = false
    sightlangStaticImageDel[40] = false
  elseif sightlangStaticImage[40] then
    if sightlangStaticImageDel[40] then
      if now >= sightlangStaticImageDel[40] then
        if isElement(sightlangStaticImage[40]) then
          destroyElement(sightlangStaticImage[40])
        end
        sightlangStaticImage[40] = nil
        sightlangStaticImageDel[40] = false
        sightlangStaticImageToc[40] = true
        return
      end
    else
      sightlangStaticImageDel[40] = now + 5000
    end
  else
    sightlangStaticImageToc[40] = true
  end
  if sightlangStaticImageUsed[41] then
    sightlangStaticImageUsed[41] = false
    sightlangStaticImageDel[41] = false
  elseif sightlangStaticImage[41] then
    if sightlangStaticImageDel[41] then
      if now >= sightlangStaticImageDel[41] then
        if isElement(sightlangStaticImage[41]) then
          destroyElement(sightlangStaticImage[41])
        end
        sightlangStaticImage[41] = nil
        sightlangStaticImageDel[41] = false
        sightlangStaticImageToc[41] = true
        return
      end
    else
      sightlangStaticImageDel[41] = now + 5000
    end
  else
    sightlangStaticImageToc[41] = true
  end
  if sightlangStaticImageUsed[42] then
    sightlangStaticImageUsed[42] = false
    sightlangStaticImageDel[42] = false
  elseif sightlangStaticImage[42] then
    if sightlangStaticImageDel[42] then
      if now >= sightlangStaticImageDel[42] then
        if isElement(sightlangStaticImage[42]) then
          destroyElement(sightlangStaticImage[42])
        end
        sightlangStaticImage[42] = nil
        sightlangStaticImageDel[42] = false
        sightlangStaticImageToc[42] = true
        return
      end
    else
      sightlangStaticImageDel[42] = now + 5000
    end
  else
    sightlangStaticImageToc[42] = true
  end
  if sightlangStaticImageUsed[43] then
    sightlangStaticImageUsed[43] = false
    sightlangStaticImageDel[43] = false
  elseif sightlangStaticImage[43] then
    if sightlangStaticImageDel[43] then
      if now >= sightlangStaticImageDel[43] then
        if isElement(sightlangStaticImage[43]) then
          destroyElement(sightlangStaticImage[43])
        end
        sightlangStaticImage[43] = nil
        sightlangStaticImageDel[43] = false
        sightlangStaticImageToc[43] = true
        return
      end
    else
      sightlangStaticImageDel[43] = now + 5000
    end
  else
    sightlangStaticImageToc[43] = true
  end
  if sightlangStaticImageUsed[44] then
    sightlangStaticImageUsed[44] = false
    sightlangStaticImageDel[44] = false
  elseif sightlangStaticImage[44] then
    if sightlangStaticImageDel[44] then
      if now >= sightlangStaticImageDel[44] then
        if isElement(sightlangStaticImage[44]) then
          destroyElement(sightlangStaticImage[44])
        end
        sightlangStaticImage[44] = nil
        sightlangStaticImageDel[44] = false
        sightlangStaticImageToc[44] = true
        return
      end
    else
      sightlangStaticImageDel[44] = now + 5000
    end
  else
    sightlangStaticImageToc[44] = true
  end
  if sightlangStaticImageUsed[45] then
    sightlangStaticImageUsed[45] = false
    sightlangStaticImageDel[45] = false
  elseif sightlangStaticImage[45] then
    if sightlangStaticImageDel[45] then
      if now >= sightlangStaticImageDel[45] then
        if isElement(sightlangStaticImage[45]) then
          destroyElement(sightlangStaticImage[45])
        end
        sightlangStaticImage[45] = nil
        sightlangStaticImageDel[45] = false
        sightlangStaticImageToc[45] = true
        return
      end
    else
      sightlangStaticImageDel[45] = now + 5000
    end
  else
    sightlangStaticImageToc[45] = true
  end
  if sightlangStaticImageUsed[46] then
    sightlangStaticImageUsed[46] = false
    sightlangStaticImageDel[46] = false
  elseif sightlangStaticImage[46] then
    if sightlangStaticImageDel[46] then
      if now >= sightlangStaticImageDel[46] then
        if isElement(sightlangStaticImage[46]) then
          destroyElement(sightlangStaticImage[46])
        end
        sightlangStaticImage[46] = nil
        sightlangStaticImageDel[46] = false
        sightlangStaticImageToc[46] = true
        return
      end
    else
      sightlangStaticImageDel[46] = now + 5000
    end
  else
    sightlangStaticImageToc[46] = true
  end
  if sightlangStaticImageUsed[47] then
    sightlangStaticImageUsed[47] = false
    sightlangStaticImageDel[47] = false
  elseif sightlangStaticImage[47] then
    if sightlangStaticImageDel[47] then
      if now >= sightlangStaticImageDel[47] then
        if isElement(sightlangStaticImage[47]) then
          destroyElement(sightlangStaticImage[47])
        end
        sightlangStaticImage[47] = nil
        sightlangStaticImageDel[47] = false
        sightlangStaticImageToc[47] = true
        return
      end
    else
      sightlangStaticImageDel[47] = now + 5000
    end
  else
    sightlangStaticImageToc[47] = true
  end
  if sightlangStaticImageUsed[48] then
    sightlangStaticImageUsed[48] = false
    sightlangStaticImageDel[48] = false
  elseif sightlangStaticImage[48] then
    if sightlangStaticImageDel[48] then
      if now >= sightlangStaticImageDel[48] then
        if isElement(sightlangStaticImage[48]) then
          destroyElement(sightlangStaticImage[48])
        end
        sightlangStaticImage[48] = nil
        sightlangStaticImageDel[48] = false
        sightlangStaticImageToc[48] = true
        return
      end
    else
      sightlangStaticImageDel[48] = now + 5000
    end
  else
    sightlangStaticImageToc[48] = true
  end
  if sightlangStaticImageUsed[49] then
    sightlangStaticImageUsed[49] = false
    sightlangStaticImageDel[49] = false
  elseif sightlangStaticImage[49] then
    if sightlangStaticImageDel[49] then
      if now >= sightlangStaticImageDel[49] then
        if isElement(sightlangStaticImage[49]) then
          destroyElement(sightlangStaticImage[49])
        end
        sightlangStaticImage[49] = nil
        sightlangStaticImageDel[49] = false
        sightlangStaticImageToc[49] = true
        return
      end
    else
      sightlangStaticImageDel[49] = now + 5000
    end
  else
    sightlangStaticImageToc[49] = true
  end
  if sightlangStaticImageToc[0] and sightlangStaticImageToc[1] and sightlangStaticImageToc[2] and sightlangStaticImageToc[3] and sightlangStaticImageToc[4] and sightlangStaticImageToc[5] and sightlangStaticImageToc[6] and sightlangStaticImageToc[7] and sightlangStaticImageToc[8] and sightlangStaticImageToc[9] and sightlangStaticImageToc[10] and sightlangStaticImageToc[11] and sightlangStaticImageToc[12] and sightlangStaticImageToc[13] and sightlangStaticImageToc[14] and sightlangStaticImageToc[15] and sightlangStaticImageToc[16] and sightlangStaticImageToc[17] and sightlangStaticImageToc[18] and sightlangStaticImageToc[19] and sightlangStaticImageToc[20] and sightlangStaticImageToc[21] and sightlangStaticImageToc[22] and sightlangStaticImageToc[23] and sightlangStaticImageToc[24] and sightlangStaticImageToc[25] and sightlangStaticImageToc[26] and sightlangStaticImageToc[27] and sightlangStaticImageToc[28] and sightlangStaticImageToc[29] and sightlangStaticImageToc[30] and sightlangStaticImageToc[31] and sightlangStaticImageToc[32] and sightlangStaticImageToc[33] and sightlangStaticImageToc[34] and sightlangStaticImageToc[35] and sightlangStaticImageToc[36] and sightlangStaticImageToc[37] and sightlangStaticImageToc[38] and sightlangStaticImageToc[39] and sightlangStaticImageToc[40] and sightlangStaticImageToc[41] and sightlangStaticImageToc[42] and sightlangStaticImageToc[43] and sightlangStaticImageToc[44] and sightlangStaticImageToc[45] and sightlangStaticImageToc[46] and sightlangStaticImageToc[47] and sightlangStaticImageToc[48] and sightlangStaticImageToc[49] then
    sightlangStatImgHand = false
    removeEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre)
  end
end
processsightlangStaticImage[0] = function()
  if not isElement(sightlangStaticImage[0]) then
    sightlangStaticImageToc[0] = false
    sightlangStaticImage[0] = dxCreateTexture("files/bigshad.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[1] = function()
  if not isElement(sightlangStaticImage[1]) then
    sightlangStaticImageToc[1] = false
    sightlangStaticImage[1] = dxCreateTexture("files/reel.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[2] = function()
  if not isElement(sightlangStaticImage[2]) then
    sightlangStaticImageToc[2] = false
    sightlangStaticImage[2] = dxCreateTexture("files/reel2.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[3] = function()
  if not isElement(sightlangStaticImage[3]) then
    sightlangStaticImageToc[3] = false
    sightlangStaticImage[3] = dxCreateTexture("files/ball.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[4] = function()
  if not isElement(sightlangStaticImage[4]) then
    sightlangStaticImageToc[4] = false
    sightlangStaticImage[4] = dxCreateTexture("files/bshad.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[5] = function()
  if not isElement(sightlangStaticImage[5]) then
    sightlangStaticImageToc[5] = false
    sightlangStaticImage[5] = dxCreateTexture("files/reel1.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[6] = function()
  if not isElement(sightlangStaticImage[6]) then
    sightlangStaticImageToc[6] = false
    sightlangStaticImage[6] = dxCreateTexture("files/reel3_s.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[7] = function()
  if not isElement(sightlangStaticImage[7]) then
    sightlangStaticImageToc[7] = false
    sightlangStaticImage[7] = dxCreateTexture("files/reel3.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[8] = function()
  if not isElement(sightlangStaticImage[8]) then
    sightlangStaticImageToc[8] = false
    sightlangStaticImage[8] = dxCreateTexture("files/reel4.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[9] = function()
  if not isElement(sightlangStaticImage[9]) then
    sightlangStaticImageToc[9] = false
    sightlangStaticImage[9] = dxCreateTexture("files/reel5.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[10] = function()
  if not isElement(sightlangStaticImage[10]) then
    sightlangStaticImageToc[10] = false
    sightlangStaticImage[10] = dxCreateTexture("files/hlzero.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[11] = function()
  if not isElement(sightlangStaticImage[11]) then
    sightlangStaticImageToc[11] = false
    sightlangStaticImage[11] = dxCreateTexture("files/hl0.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[12] = function()
  if not isElement(sightlangStaticImage[12]) then
    sightlangStaticImageToc[12] = false
    sightlangStaticImage[12] = dxCreateTexture("files/hlvoisins.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[13] = function()
  if not isElement(sightlangStaticImage[13]) then
    sightlangStaticImageToc[13] = false
    sightlangStaticImage[13] = dxCreateTexture("files/hltier.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[14] = function()
  if not isElement(sightlangStaticImage[14]) then
    sightlangStaticImageToc[14] = false
    sightlangStaticImage[14] = dxCreateTexture("files/n0.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[15] = function()
  if not isElement(sightlangStaticImage[15]) then
    sightlangStaticImageToc[15] = false
    sightlangStaticImage[15] = dxCreateTexture("files/n10.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[16] = function()
  if not isElement(sightlangStaticImage[16]) then
    sightlangStaticImageToc[16] = false
    sightlangStaticImage[16] = dxCreateTexture("files/n11.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[17] = function()
  if not isElement(sightlangStaticImage[17]) then
    sightlangStaticImageToc[17] = false
    sightlangStaticImage[17] = dxCreateTexture("files/n23.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[18] = function()
  if not isElement(sightlangStaticImage[18]) then
    sightlangStaticImageToc[18] = false
    sightlangStaticImage[18] = dxCreateTexture("files/n26.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[19] = function()
  if not isElement(sightlangStaticImage[19]) then
    sightlangStaticImageToc[19] = false
    sightlangStaticImage[19] = dxCreateTexture("files/n3.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[20] = function()
  if not isElement(sightlangStaticImage[20]) then
    sightlangStaticImageToc[20] = false
    sightlangStaticImage[20] = dxCreateTexture("files/n30.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[21] = function()
  if not isElement(sightlangStaticImage[21]) then
    sightlangStaticImageToc[21] = false
    sightlangStaticImage[21] = dxCreateTexture("files/n32.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[22] = function()
  if not isElement(sightlangStaticImage[22]) then
    sightlangStaticImageToc[22] = false
    sightlangStaticImage[22] = dxCreateTexture("files/n35.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[23] = function()
  if not isElement(sightlangStaticImage[23]) then
    sightlangStaticImageToc[23] = false
    sightlangStaticImage[23] = dxCreateTexture("files/n5.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[24] = function()
  if not isElement(sightlangStaticImage[24]) then
    sightlangStaticImageToc[24] = false
    sightlangStaticImage[24] = dxCreateTexture("files/n8.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[25] = function()
  if not isElement(sightlangStaticImage[25]) then
    sightlangStaticImageToc[25] = false
    sightlangStaticImage[25] = dxCreateTexture("files/bg.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[26] = function()
  if not isElement(sightlangStaticImage[26]) then
    sightlangStaticImageToc[26] = false
    sightlangStaticImage[26] = dxCreateTexture("files/rstrip.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[27] = function()
  if not isElement(sightlangStaticImage[27]) then
    sightlangStaticImageToc[27] = false
    sightlangStaticImage[27] = dxCreateTexture("files/stripglow.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[28] = function()
  if not isElement(sightlangStaticImage[28]) then
    sightlangStaticImageToc[28] = false
    sightlangStaticImage[28] = dxCreateTexture("files/stripfg.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[29] = function()
  if not isElement(sightlangStaticImage[29]) then
    sightlangStaticImageToc[29] = false
    sightlangStaticImage[29] = dxCreateTexture("files/table.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[30] = function()
  if not isElement(sightlangStaticImage[30]) then
    sightlangStaticImageToc[30] = false
    sightlangStaticImage[30] = dxCreateTexture("files/coin/glow.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[31] = function()
  if not isElement(sightlangStaticImage[31]) then
    sightlangStaticImageToc[31] = false
    sightlangStaticImage[31] = dxCreateTexture("files/1.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[32] = function()
  if not isElement(sightlangStaticImage[32]) then
    sightlangStaticImageToc[32] = false
    sightlangStaticImage[32] = dxCreateTexture("files/2.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[33] = function()
  if not isElement(sightlangStaticImage[33]) then
    sightlangStaticImageToc[33] = false
    sightlangStaticImage[33] = dxCreateTexture("files/0.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[34] = function()
  if not isElement(sightlangStaticImage[34]) then
    sightlangStaticImageToc[34] = false
    sightlangStaticImage[34] = dxCreateTexture("files/liveshad.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[35] = function()
  if not isElement(sightlangStaticImage[35]) then
    sightlangStaticImageToc[35] = false
    sightlangStaticImage[35] = dxCreateTexture("files/live.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[36] = function()
  if not isElement(sightlangStaticImage[36]) then
    sightlangStaticImageToc[36] = false
    sightlangStaticImage[36] = dxCreateTexture("files/wave.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[37] = function()
  if not isElement(sightlangStaticImage[37]) then
    sightlangStaticImageToc[37] = false
    sightlangStaticImage[37] = dxCreateTexture("files/winbg.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[38] = function()
  if not isElement(sightlangStaticImage[38]) then
    sightlangStaticImageToc[38] = false
    sightlangStaticImage[38] = dxCreateTexture("files/win.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[39] = function()
  if not isElement(sightlangStaticImage[39]) then
    sightlangStaticImageToc[39] = false
    sightlangStaticImage[39] = dxCreateTexture("files/coin/shine.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[40] = function()
  if not isElement(sightlangStaticImage[40]) then
    sightlangStaticImageToc[40] = false
    sightlangStaticImage[40] = dxCreateTexture("files/light.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[41] = function()
  if not isElement(sightlangStaticImage[41]) then
    sightlangStaticImageToc[41] = false
    sightlangStaticImage[41] = dxCreateTexture("files/ledgrad.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[42] = function()
  if not isElement(sightlangStaticImage[42]) then
    sightlangStaticImageToc[42] = false
    sightlangStaticImage[42] = dxCreateTexture("files/ledgrad2.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[43] = function()
  if not isElement(sightlangStaticImage[43]) then
    sightlangStaticImageToc[43] = false
    sightlangStaticImage[43] = dxCreateTexture("files/livebg.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[44] = function()
  if not isElement(sightlangStaticImage[44]) then
    sightlangStaticImageToc[44] = false
    sightlangStaticImage[44] = dxCreateTexture("files/smlogo.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[45] = function()
  if not isElement(sightlangStaticImage[45]) then
    sightlangStaticImageToc[45] = false
    sightlangStaticImage[45] = dxCreateTexture("files/livecd.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[46] = function()
  if not isElement(sightlangStaticImage[46]) then
    sightlangStaticImageToc[46] = false
    sightlangStaticImage[46] = dxCreateTexture("files/livecd2.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[47] = function()
  if not isElement(sightlangStaticImage[47]) then
    sightlangStaticImageToc[47] = false
    sightlangStaticImage[47] = dxCreateTexture("files/smallbg.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[48] = function()
  if not isElement(sightlangStaticImage[48]) then
    sightlangStaticImageToc[48] = false
    sightlangStaticImage[48] = dxCreateTexture("files/smallfg.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[49] = function()
  if not isElement(sightlangStaticImage[49]) then
    sightlangStaticImageToc[49] = false
    sightlangStaticImage[49] = dxCreateTexture("files/win3d.dds", "argb", true)
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
local sightlangBlankTex = dxCreateTexture(1, 1)
local function latentDynamicImage(img, form, mip)
  if not sightlangDynImgHand then
    sightlangDynImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangDynImgPre, true, "high+999999999")
  end
  sightlangDynImageForm[img] = form
  sightlangDynImageMip[img] = mip
  sightlangDynImageUsed[img] = true
  return sightlangDynImage[img] or sightlangBlankTex
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
local lightGreyHex = false
local greenHex = false
local redHex = false
local blueHex = false
local helpFont = false
local helpFontScale = false
local cdFont = false
local cdFontScale = false
local numberFont = false
local numberFontScale = false
local sitIcon = false
local sitColor = false
local sitBgColor = false
local faTicks = false
local function sightlangGuiRefreshColors()
  local res = getResourceFromName("sGui")
  if res and getResourceState(res) == "running" then
    lightGreyHex = sightexports.sGui:getColorCodeHex("sightlightgrey")
    greenHex = sightexports.sGui:getColorCodeHex("sightgreen")
    redHex = sightexports.sGui:getColorCodeHex("sightred")
    blueHex = sightexports.sGui:getColorCodeHex("sightblue")
    helpFont = sightexports.sGui:getFont("12/BebasNeueRegular.otf")
    helpFontScale = sightexports.sGui:getFontScale("12/BebasNeueRegular.otf")
    cdFont = sightexports.sGui:getFont("20/BebasNeueBold.otf")
    cdFontScale = sightexports.sGui:getFontScale("20/BebasNeueBold.otf")
    numberFont = sightexports.sGui:getFont("10/Impact.ttf")
    numberFontScale = sightexports.sGui:getFontScale("10/Impact.ttf")
    sitIcon = sightexports.sGui:getFaIconFilename("user", 24)
    sitColor = sightexports.sGui:getColorCodeToColor("sightgreen")
    sitBgColor = sightexports.sGui:getColorCode("sightgrey1")
    faTicks = sightexports.sGui:getFaTicks()
  end
end
addEventHandler("onGuiRefreshColors", getRootElement(), sightlangGuiRefreshColors)
addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangGuiRefreshColors)
addEventHandler("refreshFaTicks", getRootElement(), function()
  faTicks = sightexports.sGui:getFaTicks()
end)
local sightlangModloaderLoaded = function()
  loadModelIds()
end
addEventHandler("modloaderLoaded", getRootElement(), sightlangModloaderLoaded)
if getElementData(localPlayer, "loggedIn") or sightexports.sModloader and sightexports.sModloader:isModloaderLoaded() then
  addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangModloaderLoaded)
end
local screenX, screenY = guiGetScreenSize()
local objectModels = {}
local textureChanger = " texture gTexture; technique hello { pass P0 { Texture[0] = gTexture; } } "
function loadModelIds()
  objectModels = {
    roulette_table = sightexports.sModloader:getModelId("roulette_table"),
    roulette_wheel = sightexports.sModloader:getModelId("roulette_wheel"),
    roulette_ball = sightexports.sModloader:getModelId("roulette_ball"),
    roulette_glass = sightexports.sModloader:getModelId("roulette_glass")
  }
  triggerServerEvent("requestRouletteMachine", localPlayer)
end
rouletteTables = {}
local myTable = false
local mySeat = false
local myLastBets = {}
local myBetPlus = {}
local myWin = 0
local myWinFormatted = "0"
local myBet = 0
local myBetFormatted = "0"
local wheelRot = getRealTime().timestamp % 360
local seatOffsets = {
  {
    -1.9,
    0.5415,
    1.1,
    -90
  },
  {
    -0.5415,
    1.9,
    1.1,
    180
  },
  {
    0.5415,
    1.9,
    1.1,
    180
  },
  {
    1.9,
    0.5415,
    1.1,
    90
  },
  {
    1.9,
    -0.5415,
    1.1,
    90
  },
  {
    0.5415,
    -1.9,
    1.1,
    0
  },
  {
    -0.5415,
    -1.9,
    1.1,
    0
  },
  {
    -1.9,
    -0.5415,
    1.1,
    -90
  }
}
addEventHandler("onClientResourceStart", getResourceRootElement(), function()
  if getElementData(localPlayer, "loggedIn") then
    triggerServerEvent("requestSSC", localPlayer)
  end
  for i = 1, #rouletteTableCoords do
    local tbl = {}
    tbl.id = i
    tbl.players = {}
    tbl.win = {}
    tbl.betted = {}
    tbl.int = rouletteTableCoords[i][5]
    tbl.dim = rouletteTableCoords[i][6]
    local tx, ty, tz, rz = rouletteTableCoords[i][1], rouletteTableCoords[i][2], rouletteTableCoords[i][3], rouletteTableCoords[i][4]
    tbl.seats = {}
    tbl.rad = math.rad(rz)
    tbl.cos = math.cos(tbl.rad)
    tbl.sin = math.sin(tbl.rad)
    for j = 1, 8 do
      tbl.seats[j] = {
        tx + seatOffsets[j][1] * tbl.cos - seatOffsets[j][2] * tbl.sin,
        ty + seatOffsets[j][1] * tbl.sin + seatOffsets[j][2] * tbl.cos,
        tz + seatOffsets[j][3],
        seatOffsets[j][4] + rz
      }
    end
    tbl.bz = rouletteTableCoords[i][3] + 1.02845
    tbl.rad = math.rad(rouletteTableCoords[i][4])
    tbl.ballRad = 0.435
    tbl.ballRot = 0
    tbl.ballRotBounce = 0
    tbl.ballWrs = 0
    tbl.ballSpeed = 0
    tbl.wheelRandom = i * 21.5
    tbl.lastPos = math.random(0, 36)
    tbl.lastNumber = rouletteWheelNums[tbl.lastPos + 1]
    tbl.lastNumberColor = numberColors[tbl.lastNumber]
    tbl.history = {}
    tbl.canBet = true
    tbl.bets = {}
    for i = 1, 8 do
      tbl.bets[i] = {}
    end
    tbl.betCoins = {}
    for i = 1, 8 do
      tbl.betCoins[i] = {}
    end
    rouletteTables[i] = tbl
  end
  generateHoverRectangles()
end)
local streamedIn = {}
addEvent("streamInRoulette", true)
addEventHandler("streamInRoulette", getRootElement(), function(id, data, spin, slow, bounce, n, cd, history)
  if #streamedIn <= 0 then
    addEventHandler("onClientRender", getRootElement(), renderSeatIcons)
    addEventHandler("onClientClick", getRootElement(), clickSeatIcons)
    addEventHandler("onClientRender", getRootElement(), renderRoulette)
    addEventHandler("onClientPreRender", getRootElement(), preRenderRoulette)
  end
  local tx, ty, tz, rz = rouletteTableCoords[id][1], rouletteTableCoords[id][2], rouletteTableCoords[id][3], rouletteTableCoords[id][4]
  local tbl = rouletteTables[id]
  if not isElement(tbl.obj) then
    tbl.obj = createObject(objectModels.roulette_table, tx, ty, tz, 0, 0, rz)
    setElementInterior(tbl.obj, tbl.int)
    setElementDimension(tbl.obj, tbl.dim)
  end
  if not isElement(tbl.wheel) then
    tbl.wheel = createObject(objectModels.roulette_wheel, tx, ty, tbl.bz, 0, 0, rz)
    setElementInterior(tbl.wheel, tbl.int)
    setElementDimension(tbl.wheel, tbl.dim)
  end
  if not isElement(tbl.glass) then
    tbl.glass = createObject(objectModels.roulette_glass, tx, ty, tz)
    setElementInterior(tbl.glass, tbl.int)
    setElementDimension(tbl.glass, tbl.dim)
  end
  if not isElement(tbl.ball) then
    tbl.ball = createObject(objectModels.roulette_ball, tx, ty, tz)
    setElementInterior(tbl.ball, tbl.int)
    setElementDimension(tbl.ball, tbl.dim)
  end
  if not isElement(tbl.smallRt) then
    tbl.smallRt = dxCreateRenderTarget(170, 129)
  end
  if not isElement(tbl.smallShader) then
    tbl.smallShader = dxCreateShader(textureChanger)
    dxSetShaderValue(tbl.smallShader, "gTexture", tbl.smallRt)
    engineApplyShaderToWorldTexture(tbl.smallShader, "roulette_screen", tbl.obj)
  end
  if not isElement(tbl.bigRt) then
    tbl.bigRt = dxCreateRenderTarget(342, 256)
  end
  if not isElement(tbl.bigShader) then
    tbl.bigShader = dxCreateShader(textureChanger)
    dxSetShaderValue(tbl.bigShader, "gTexture", tbl.bigRt)
    engineApplyShaderToWorldTexture(tbl.bigShader, "roulette_bigscreen", tbl.obj)
  end
  if not isElement(tbl.ledRt) then
    tbl.ledRt = dxCreateRenderTarget(360, 32)
  end
  if not isElement(tbl.ledShader) then
    tbl.ledShader = dxCreateShader(textureChanger)
    dxSetShaderValue(tbl.ledShader, "gTexture", tbl.ledRt)
    engineApplyShaderToWorldTexture(tbl.ledShader, "roulette_neon", tbl.obj)
  end
  for k, v in pairs(data) do
    tbl[k] = v
  end
  tbl.lastNumberColor = numberColors[tbl.lastNumber]
  for i = 1, math.max(#history, #tbl.history) do
    if history[i] then
      tbl.history[i] = {
        history[i],
        numberColors[history[i]] or 0
      }
    else
      tbl.history[i] = nil
    end
  end
  if bounce then
    bounceTheBallFinal(id, tbl.lastPos, n, bounce)
  elseif slow then
    slowDownBall(id, slow)
  elseif spin then
    spinUpBall(id, spin)
  end
  if cd then
    tbl.countdown = getTickCount() - cd
    tbl.countdownTime = false
  end
  for seat = 1, 8 do
    for bet, val in pairs(tbl.bets[seat]) do
      processBetCoin(tbl, seat, bet, val)
    end
    if isElement(tbl.players[seat]) then
      attachElements(tbl.players[seat], tbl.obj, seatOffsets[seat][1], seatOffsets[seat][2], seatOffsets[seat][3])
      setPedAnimation(tbl.players[seat], "int_office", "off_sit_idle_loop", -1, true, false, false, false)
    end
  end
  table.insert(streamedIn, id)
end)
addEvent("streamOutRoulettes", true)
addEventHandler("streamOutRoulettes", getRootElement(), function()
  if 0 < #streamedIn then
    for i = 1, #streamedIn do
      local tbl = rouletteTables[streamedIn[i]]
      if isElement(tbl.obj) then
        destroyElement(tbl.obj)
      end
      tbl.obj = nil
      if isElement(tbl.wheel) then
        destroyElement(tbl.wheel)
      end
      tbl.wheel = nil
      if isElement(tbl.glass) then
        destroyElement(tbl.glass)
      end
      tbl.glass = nil
      if isElement(tbl.ball) then
        destroyElement(tbl.ball)
      end
      tbl.ball = nil
      if isElement(tbl.smallRt) then
        destroyElement(tbl.smallRt)
      end
      tbl.smallRt = nil
      if isElement(tbl.smallShader) then
        destroyElement(tbl.smallShader)
      end
      tbl.smallShader = nil
      if isElement(tbl.bigRt) then
        destroyElement(tbl.bigRt)
      end
      tbl.bigRt = nil
      if isElement(tbl.bigShader) then
        destroyElement(tbl.bigShader)
      end
      tbl.bigShader = nil
      if isElement(tbl.ledRt) then
        destroyElement(tbl.ledRt)
      end
      tbl.ledRt = nil
      if isElement(tbl.ledShader) then
        destroyElement(tbl.ledShader)
      end
      tbl.ledShader = nil
      if isTimer(tbl.winLoseSoundTimer) then
        killTimer(tbl.winLoseSoundTimer)
      end
      tbl.winLoseSoundTimer = nil
      if isElement(tbl.spinSound) then
        destroyElement(tbl.spinSound)
      end
      tbl.spinSound = false
      for seat = 1, 8 do
        if isElement(tbl.players[seat]) then
          detachElements(tbl.players[seat], tbl.obj)
          setPedAnimation(tbl.players[seat])
        end
      end
    end
    removeEventHandler("onClientRender", getRootElement(), renderSeatIcons)
    removeEventHandler("onClientClick", getRootElement(), clickSeatIcons)
    removeEventHandler("onClientRender", getRootElement(), renderRoulette)
    removeEventHandler("onClientPreRender", getRootElement(), preRenderRoulette)
  end
  streamedIn = {}
end)
function rDistRad(a, b)
  local a = a - b
  return (a + math.pi) % pif - math.pi
end
function rDist(a, b)
  local a = a - b
  return (a + 180) % 360 - 180
end
function saveDebug(id)
  pixels = dxConvertPixels(dxGetTexturePixels(rouletteTables[id].bigRt), "png")
  local fh = fileCreate(id .. getRealTime().timestamp .. getTickCount() .. ".png")
  fileWrite(fh, pixels)
  fileClose(fh)
end
local knocks = {}
for i = 1, 8 do
  table.insert(knocks, math.rad((i - 0.5) * 45))
end
local titleBarHeight = 0
local bigX, bigY = false, false
local bigWindow = false
local bigPreview = false
local smallWindow = false
local smallX, smallY = false, false
function playTableSound(sound, id)
  local el = false
  if id == myTable then
    el = playSound("files/sound/" .. sound .. ".mp3")
  else
    local tbl = rouletteTables[id]
    el = playSound3D("files/sound/" .. sound .. ".mp3", rouletteTableCoords[id][1], rouletteTableCoords[id][2], rouletteTableCoords[id][3])
    setElementDimension(el, tbl.dim)
    setElementInterior(el, tbl.int)
    setSoundVolume(el, 0.75)
    setSoundMinDistance(el, 1.35)
    setSoundMaxDistance(el, 14)
  end
  return el
end
function playSeatSound(sound, tbl, seat)
  local el = false
  if tbl.id == myTable and seat == mySeat then
    el = playSound("files/sound/" .. sound .. ".mp3")
  else
    local scr = tbl.screenCoord[seat]
    local x, y, z = scr[1], scr[2], scr[3]
    el = playSound3D("files/sound/" .. sound .. ".mp3", x, y, z)
    setElementDimension(el, tbl.dim)
    setElementInterior(el, tbl.int)
    setSoundVolume(el, 0.75)
    setSoundMinDistance(el, 1.35)
    setSoundMaxDistance(el, 14)
  end
  return el
end
function playBallSound(tbl, text, loop, notAttach)
  if isElement(tbl.ball) then
    local x, y, z = getElementPosition(tbl.ball)
    local sound = playSound3D("files/sound/" .. text .. ".mp3", x, y, z, loop)
    setElementInterior(sound, tbl.int)
    setElementDimension(sound, tbl.dim)
    if not notAttach then
      attachElements(sound, tbl.ball)
    end
    return sound
  end
end
function bounceTheBall(id, lp, n, win, bet)
  local tbl = rouletteTables[id]
  tbl.bounceNextLP = lp
  tbl.bounceNextN = n
  for i = 1, 8 do
    tbl.win[i] = win[i]
    tbl.betted[i] = bet[i]
  end
end
local balance = 0
local balanceNew = 0
local balanceText = false
local balanceSpeed = false
function convertBalanceText()
  balanceText = sightexports.sGui:thousandsStepper(math.floor(balance))
end
addEvent("refreshSSC", true)
addEventHandler("refreshSSC", getRootElement(), function(amount)
  balanceNew = math.max(0, tonumber(amount) or 0)
  if not myTable or not balanceText then
    balance = balanceNew
    convertBalanceText()
  elseif balance > balanceNew then
    balanceSpeed = math.abs(balance - balanceNew) / 400
  else
    balanceSpeed = math.abs(balance - balanceNew) / 1000
  end
end)
function playWinLoseSound(id)
  if id == myTable and smallWindow then
    createWindow(true)
  end
  local tbl = rouletteTables[id]
  tbl.winLoseSoundTimer = nil
  for j = 1, 8 do
    if tbl.win[j] then
      local maxtime = 3500 + 450 * (tbl.win[j] - 1) + 2000
      for k = 3750, maxtime, 250 do
        setTimer(playSeatSound, k, 1, "wincount", tbl, j)
      end
      for k = 0, tbl.win[j] - 1 do
        setTimer(playSeatSound, 3500 + 450 * k, 1, "sscfade", tbl, j)
      end
    end
  end
end
function bounceTheBallFinal(id, lp, n, delta)
  local tbl = rouletteTables[id]
  if not delta then
    if not tbl.spinSound then
      tbl.spinSound = playBallSound(tbl, "spin", true)
    end
    setSoundSpeed(tbl.spinSound, 0.95)
  end
  delta = delta or 0
  myWin = 0
  myWinFormatted = "0"
  tbl.canBet = false
  tbl.spinUp = false
  tbl.slowDown = false
  tbl.countdown = false
  tbl.countdownTime = false
  tbl.bounces = {}
  tbl.bounceStart = getTickCount() - delta
  tbl.lastPos = lp
  tbl.lastNumber = rouletteWheelNums[lp + 1]
  tbl.lastNumberColor = numberColors[tbl.lastNumber]
  tbl.winnerBets = {}
  for i = 1, #winnerBets[tbl.lastNumber] do
    tbl.winnerBets[winnerBets[tbl.lastNumber][i]] = true
  end
  table.insert(tbl.history, {
    tbl.lastNumber,
    tbl.lastNumberColor or 0
  })
  if #tbl.history > 25 then
    table.remove(tbl.history, 1)
  end
  tbl.ballSpeed = 0
  local wr = math.rad(wheelRot + tbl.wheelRandom) + oneRad * tbl.lastPos
  local d = pif + rDistRad(wr, tbl.ballRot)
  local t = d / (wrSpeedRad + slowSpeed)
  local bt = tbl.ballRot + slowSpeed * t
  local absMinD = false
  local minD = false
  for i = 1, 8 do
    local d = rDistRad(knocks[i], bt)
    local dAbs = math.abs(d)
    if not absMinD or absMinD > dAbs then
      absMinD = dAbs
      minD = d
    end
  end
  t = (d + minD) / (wrSpeedRad + slowSpeed)
  local time = t
  wr = wr - wrSpeedRad * t
  local rad = 0.4175
  local rot = tbl.ballRot + slowSpeed * t
  table.insert(tbl.bounces, {
    tbl.ballRot,
    slowSpeed * t,
    0.435,
    -0.019500000000000017,
    t * 1000,
    true
  })
  local d = 1 + n * 0.8
  local t = 0.45 * math.pow(0.8583690987124464, n)
  local lastSide = 0
  for i = 1, n do
    t = t * 1.15
    d = d / 1.25
    local target = 0
    local side = math.random() < 0.5 and -1 or 1
    if side == lastSide then
      target = wr + side * (1 + math.random()) * d / 2 * oneRad
    else
      target = wr + side * math.random() * d / 2 * oneRad
    end
    lastSide = side
    local newRad = 0.275 + (i % 2 == 1 and -1 or 1) * (0.5 + math.random()) * d / 1.5 * (0.2 / (1 + n))
    table.insert(tbl.bounces, {
      rot,
      rDistRad(target, rot),
      rad,
      newRad - rad,
      t * 1000,
      delta >= time
    })
    time = time + t
    rad = newRad
    rot = target
    wr = wr - wrSpeedRad * t
  end
  t = t * 1.25
  wr = wr - wrSpeedRad * t
  table.insert(tbl.bounces, {
    rot,
    rDistRad(wr, rot),
    rad,
    0.275 - rad,
    t * 1000,
    delta >= time
  })
  time = time + t
  tbl.ended = tbl.bounceStart + time * 1000
  local t = time * 1000 + 1000 - delta
  if 100 < t then
    tbl.winLoseSoundTimer = setTimer(playWinLoseSound, t, 1, id)
  end
end
function slowDownBall(id, delta)
  local tbl = rouletteTables[id]
  if not tbl.spinSound then
    tbl.spinSound = playBallSound(tbl, "spin", true)
  end
  tbl.canBet = false
  tbl.ended = false
  tbl.spinUp = false
  tbl.slowDown = getTickCount() - (delta or 0)
  tbl.countdown = false
  tbl.countdownTime = false
  tbl.ballRad = 0.435
  tbl.ballSpeed = fastSpeed
  myWin = 0
  myWinFormatted = "0"
end
function spinUpBall(id, delta)
  if id == myTable and bigWindow then
    createWindow(false)
  end
  local tbl = rouletteTables[id]
  if not delta then
    playBallSound(tbl, "air", false, true)
  end
  if not tbl.spinSound then
    tbl.spinSound = playBallSound(tbl, "spin", true)
  end
  local wr = wheelRot + tbl.wheelRandom
  tbl.canBet = false
  tbl.ended = false
  tbl.slowDown = false
  tbl.spinUp = getTickCount() - (delta or 0)
  tbl.countdown = false
  tbl.countdownTime = 0
  tbl.ballRad = 0.435
  tbl.ballRot = math.rad(wr) + oneRad * tbl.lastPos
  tbl.ballSpeed = 0
  myWin = 0
  myWinFormatted = "0"
end
addEvent("rouletteSpinUpBall", true)
addEventHandler("rouletteSpinUpBall", getRootElement(), spinUpBall)
addEvent("rouletteSlowDownBall", true)
addEventHandler("rouletteSlowDownBall", getRootElement(), slowDownBall)
addEvent("rouletteBounceTheBall", true)
addEventHandler("rouletteBounceTheBall", getRootElement(), bounceTheBall)
function drawReel(x, y, s, r, br, bd, pos, bNot)
  local rx = x - s / 2
  local ry = y - s / 2
  sightlangStaticImageUsed[0] = true
  if sightlangStaticImageToc[0] then
    processsightlangStaticImage[0]()
  end
  dxDrawImage(rx + s * 0.05 * 0.3826, ry + s * 0.05 * 0.9238, s, s, sightlangStaticImage[0], 0, 0, 0, tocolor(0, 0, 0, 125))
  sightlangStaticImageUsed[1] = true
  if sightlangStaticImageToc[1] then
    processsightlangStaticImage[1]()
  end
  dxDrawImage(rx, ry, s, s, sightlangStaticImage[1], r)
  sightlangStaticImageUsed[2] = true
  if sightlangStaticImageToc[2] then
    processsightlangStaticImage[2]()
  end
  dxDrawImage(rx, ry, s, s, sightlangStaticImage[2])
  if not bNot then
    local bs = s / 230 * (9.5 + pos * 11)
    local bs2 = bs / 34 * 60
    local bx = x - s * bd * math.cos(br)
    local by = y - s * bd * math.sin(br)
    sightlangStaticImageUsed[3] = true
    if sightlangStaticImageToc[3] then
      processsightlangStaticImage[3]()
    end
    dxDrawImage(bx - bs / 2, by - bs / 2, bs, bs, sightlangStaticImage[3], math.deg(br))
    sightlangStaticImageUsed[4] = true
    if sightlangStaticImageToc[4] then
      processsightlangStaticImage[4]()
    end
    dxDrawImage(bx - bs2 / 2, by - bs2 / 2, bs2, bs2, sightlangStaticImage[4], 0, 0, 0, tocolor(0, 0, 0))
  end
  sightlangStaticImageUsed[5] = true
  if sightlangStaticImageToc[5] then
    processsightlangStaticImage[5]()
  end
  dxDrawImage(rx, ry, s, s, sightlangStaticImage[5])
  if not bNot then
    sightlangStaticImageUsed[6] = true
    if sightlangStaticImageToc[6] then
      processsightlangStaticImage[6]()
    end
    dxDrawImage(rx + s * 0.035 * 0.3826, ry + s * 0.035 * 0.9238, s, s, sightlangStaticImage[6], r, 0, 0, tocolor(0, 0, 0, 100))
  end
  sightlangStaticImageUsed[7] = true
  if sightlangStaticImageToc[7] then
    processsightlangStaticImage[7]()
  end
  dxDrawImage(rx, ry, s, s, sightlangStaticImage[7], r)
  sightlangStaticImageUsed[8] = true
  if sightlangStaticImageToc[8] then
    processsightlangStaticImage[8]()
  end
  dxDrawImage(rx, ry, s, s, sightlangStaticImage[8])
  sightlangStaticImageUsed[9] = true
  if sightlangStaticImageToc[9] then
    processsightlangStaticImage[9]()
  end
  dxDrawImage(rx, ry, s, s, sightlangStaticImage[9], r)
end
local zSegments = {
  {0.425858, -0.001797},
  {0.376589, -0.019799},
  {0.30914, -0.040762},
  {0.306024, -0.040762},
  {0.285381, -0.066699},
  {0.264619, -0.066699},
  {0.244739, -0.040762},
  {0.229809, -0.040763},
  {0.037806, 0}
}
for i = 1, #zSegments do
  zSegments[i][2] = zSegments[i][2] + 0.02785
end
function calculateZSegment(p)
  for i = 1, #zSegments do
    if p > zSegments[i][1] then
      local fromP = zSegments[i - 1] and zSegments[i - 1][1] or 0.5
      local from = zSegments[i][2]
      local to = zSegments[math.max(i - 1, 1)][2]
      return from + (to - from) * (p - zSegments[i][1]) / (fromP - zSegments[i][1])
    end
  end
  return -0.02785
end
local restZ = calculateZSegment(0.275)
local spinZ = calculateZSegment(0.435)
local wRad = 1.2332836363636361
function processBall(id, tbl, rot, rad, bz)
  local x, y, z = rouletteTableCoords[id][1], rouletteTableCoords[id][2], rouletteTableCoords[id][3]
  x = x + wRad * rad * math.cos(-rot + tbl.rad + math.pi)
  y = y + wRad * rad * math.sin(-rot + tbl.rad + math.pi)
  setElementPosition(tbl.ball, x, y, tbl.bz + bz)
end
local hlColor = tocolor(190, 190, 190, 110)
local hover = false
local screenCoords = {
  {
    -1.1564,
    0.54,
    1.0499,
    -0.26745,
    0,
    0.963572,
    0,
    -1,
    0,
    -0.963572,
    0,
    -0.267449
  },
  {
    -0.54,
    1.1564,
    1.0499,
    0,
    0.2674,
    0.9636,
    -1,
    0,
    0,
    0,
    0.963572,
    -0.26745
  },
  {
    0.54,
    1.1564,
    1.0499,
    0,
    0.2674,
    0.9636,
    -1,
    0,
    0,
    0,
    0.963572,
    -0.26745
  },
  {
    1.1564,
    0.54,
    1.0499,
    0.26745,
    0,
    0.963572,
    0,
    1,
    0,
    0.963572,
    0,
    -0.267449
  },
  {
    1.1564,
    -0.54,
    1.0499,
    0.26745,
    0,
    0.963572,
    0,
    1,
    0,
    0.963572,
    0,
    -0.267449
  },
  {
    0.54,
    -1.1564,
    1.0499,
    0,
    -0.2674,
    0.9636,
    1,
    0,
    0,
    0,
    -0.963572,
    -0.26745
  },
  {
    -0.54,
    -1.1564,
    1.0499,
    0,
    -0.2674,
    0.9636,
    1,
    0,
    0,
    0,
    -0.963572,
    -0.26745
  },
  {
    -1.1564,
    -0.54,
    1.0499,
    -0.26745,
    0,
    0.963572,
    0,
    -1,
    0,
    -0.963572,
    0,
    -0.267449
  }
}
local hoverRectangles = {}
local betCoinPlaces = {}
local coinS = 0.007980875
function generateHoverRectangles()
  local w = 43
  local h = 57
  betCoinPlaces[0] = {
    408.5,
    478.5 - h * 1.5
  }
  for i = 0, 11 do
    for j = 1, 3 do
      hoverRectangles[i * 3 + j] = {
        {
          442.5 + w * i,
          478.5 - h * j,
          w,
          h
        }
      }
      betCoinPlaces[i * 3 + j] = {
        442.5 + w * (i + 0.5),
        478.5 - h * (j - 0.5)
      }
    end
  end
  for i = 1, 3 do
    hoverRectangles["col" .. i] = {
      {
        442.5,
        478.5 - h * i,
        516 + w,
        h
      }
    }
    betCoinPlaces["col" .. i] = {
      442.5 + w * 12.5,
      478.5 - h * (i - 0.5)
    }
  end
  for i = 1, 3 do
    hoverRectangles["d" .. i] = {
      {
        442.5 + w * 4 * (i - 1),
        307.5,
        w * 4,
        h * 4
      }
    }
    betCoinPlaces["d" .. i] = {
      442.5 + w * 4 * (i - 1 + 0.5),
      478.5 + h * 0.5
    }
  end
  betCoinPlaces["1half"] = {
    442.5 + w * 2 * 0.5,
    478.5 + h * 1.5
  }
  betCoinPlaces.even = {
    442.5 + w * 2 * 1.5,
    478.5 + h * 1.5
  }
  betCoinPlaces.red = {
    442.5 + w * 2 * 2.5,
    478.5 + h * 1.5
  }
  betCoinPlaces.black = {
    442.5 + w * 2 * 3.5,
    478.5 + h * 1.5
  }
  betCoinPlaces.odd = {
    442.5 + w * 2 * 4.5,
    478.5 + h * 1.5
  }
  betCoinPlaces["2half"] = {
    442.5 + w * 2 * 5.5,
    478.5 + h * 1.5
  }
  hoverRectangles["1half"] = {
    {
      442.5,
      478.5 + h,
      w * 2,
      h
    },
    {
      442.5,
      307.5,
      w * 6,
      h * 3
    }
  }
  hoverRectangles["2half"] = {
    {
      958.5 - w * 2,
      478.5 + h,
      w * 2,
      h
    },
    {
      442.5 + w * 6,
      307.5,
      w * 6,
      h * 3
    }
  }
  hoverRectangles.even = {
    {
      442.5 + w * 2,
      478.5 + h,
      w * 2,
      h
    }
  }
  hoverRectangles.odd = {
    {
      958.5 - w * 4,
      478.5 + h,
      w * 2,
      h
    }
  }
  for i = 1, 36 do
    if i % 2 == 1 then
      table.insert(hoverRectangles.odd, hoverRectangles[i][1])
    else
      table.insert(hoverRectangles.even, hoverRectangles[i][1])
    end
  end
  hoverRectangles.red = {
    {
      442.5 + w * 4,
      478.5 + h,
      w * 2,
      h
    }
  }
  hoverRectangles.black = {
    {
      958.5 - w * 6,
      478.5 + h,
      w * 2,
      h
    }
  }
  for j = 0, 2 do
    for i = 0, 11 do
      local num = 1 + i * 3 + j
      local col = numberColors[num] == 1 and "red" or "black"
      if numberColors[num] == numberColors[num + 3] then
        table.insert(hoverRectangles[col], {
          hoverRectangles[num][1][1],
          hoverRectangles[num][1][2],
          w * 2,
          hoverRectangles[num][1][4]
        })
      elseif numberColors[num] ~= numberColors[num - 3] then
        table.insert(hoverRectangles[col], hoverRectangles[num][1])
      end
    end
  end
  for i = 0, 11 do
    for j = 1, 3 do
      if i == 0 then
        hoverRectangles["splith" .. j + i * 3] = {
          {
            442.5,
            478.5 - h * j,
            w,
            h
          }
        }
        betCoinPlaces["splith" .. j + i * 3] = {
          442.5,
          478.5 - h * (j - 0.5)
        }
      else
        hoverRectangles["splith" .. j + i * 3] = {
          {
            442.5 + w * (i - 1),
            478.5 - h * j,
            w * 2,
            h
          }
        }
        betCoinPlaces["splith" .. j + i * 3] = {
          442.5 + w * i,
          478.5 - h * (j - 0.5)
        }
      end
      if j < 3 then
        hoverRectangles["splitv" .. j + i * 3] = {
          {
            442.5 + w * i,
            478.5 - h * (j + 1),
            w,
            h * 2
          }
        }
        betCoinPlaces["splitv" .. j + i * 3] = {
          442.5 + w * (i + 0.5),
          478.5 - h * j
        }
      end
    end
  end
  for i = 0, 11 do
    hoverRectangles["street" .. i * 3 + 1] = {
      {
        442.5 + i * w,
        307.5,
        w,
        h * 3
      }
    }
    betCoinPlaces["street" .. i * 3 + 1] = {
      442.5 + w * (i + 0.5),
      478.5
    }
  end
  for i = 0, 10 do
    hoverRectangles["doublestreet" .. i * 3 + 1] = {
      {
        442.5 + i * w,
        307.5,
        w * 2,
        h * 3
      }
    }
    betCoinPlaces["doublestreet" .. i * 3 + 1] = {
      442.5 + w * (i + 1),
      478.5
    }
  end
  hoverRectangles.basket = {
    {
      442.5,
      307.5,
      w,
      h * 3
    }
  }
  betCoinPlaces.basket = {442.5, 478.5}
  for i = 1, 2 do
    hoverRectangles["trio" .. i] = {
      {
        442.5,
        478.5 - h * (i + 1),
        w,
        h * 2
      }
    }
    betCoinPlaces["trio" .. i] = {
      442.5,
      478.5 - h * i
    }
  end
  for i = 0, 10 do
    for j = 1, 2 do
      hoverRectangles["corner" .. j + i * 3] = {
        {
          442.5 + w * i,
          478.5 - h * (j + 1),
          w * 2,
          h * 2
        }
      }
      betCoinPlaces["corner" .. j + i * 3] = {
        442.5 + w * (i + 1),
        478.5 - h * j
      }
    end
  end
  for i = 0, 36 do
    local num = rouletteWheelNums[i + 1]
    hoverRectangles["n" .. num] = {}
    if hoverRectangles[num] then
      table.insert(hoverRectangles["n" .. num], hoverRectangles[num][1])
    end
    for j = -1, 1, 2 do
      local k = rouletteWheelNums[(i + j) % 37 + 1]
      if hoverRectangles[k] then
        table.insert(hoverRectangles["n" .. num], hoverRectangles[k][1])
      end
    end
    if 33 <= i then
      table.insert(hoverRectangles["n" .. num], {
        238.5 + 34 * (i - 33),
        153,
        102,
        48
      })
    elseif 27 <= i then
    elseif 25 <= i then
      table.insert(hoverRectangles["n" .. num], {
        374.5 - 34 * (3 + i - 25),
        239,
        102,
        48
      })
    elseif i == 24 then
      table.insert(hoverRectangles["n" .. num], {
        307,
        239,
        125,
        48
      })
    elseif i == 23 then
      table.insert(hoverRectangles["n" .. num], {
        341,
        239,
        148,
        48
      })
    elseif i == 22 then
      table.insert(hoverRectangles["n" .. num], {
        375,
        239,
        171,
        48
      })
    elseif i == 21 then
      table.insert(hoverRectangles["n" .. num], {
        432,
        239,
        148,
        48
      })
    elseif i == 20 then
      table.insert(hoverRectangles["n" .. num], {
        488,
        239,
        126,
        48
      })
    elseif 15 <= i then
      table.insert(hoverRectangles["n" .. num], {
        784.5 - 34 * (3 + i - 15),
        239,
        102,
        48
      })
    elseif i <= 9 then
      table.insert(hoverRectangles["n" .. num], {
        375 + 34 * i,
        153,
        102,
        48
      })
    end
  end
  hoverRectangles.tier = {}
  hoverRectangles.orphelins = {
    {
      375,
      153,
      171,
      135
    }
  }
  hoverRectangles.voisins = {}
  hoverRectangles.zero = {}
  for i = 1, #tierBets do
    for j = 1, #hoverRectangles[tierBets[i]] do
      table.insert(hoverRectangles.tier, hoverRectangles[tierBets[i]][j])
    end
  end
  for i = 1, #orphelinsBets do
    for j = 1, #hoverRectangles[orphelinsBets[i]] do
      table.insert(hoverRectangles.orphelins, hoverRectangles[orphelinsBets[i]][j])
    end
  end
  for i = 1, #voisinsBets do
    for j = 1, #hoverRectangles[voisinsBets[i]] do
      table.insert(hoverRectangles.voisins, hoverRectangles[voisinsBets[i]][j])
    end
  end
  for i = 1, #zeroBets do
    for j = 1, #hoverRectangles[zeroBets[i]] do
      table.insert(hoverRectangles.zero, hoverRectangles[zeroBets[i]][j])
    end
  end
  for i = 1, #rouletteTableCoords do
    local tx, ty, tz = rouletteTableCoords[i][1], rouletteTableCoords[i][2], rouletteTableCoords[i][3]
    local tbl = rouletteTables[i]
    tbl.screenCoord = {}
    tbl.screenBets = {}
    tbl.winCoord = {}
    for j = 1, #screenCoords do
      tbl.screenCoord[j] = {
        tx + screenCoords[j][1] * tbl.cos - screenCoords[j][2] * tbl.sin,
        ty + screenCoords[j][1] * tbl.sin + screenCoords[j][2] * tbl.cos,
        tz + screenCoords[j][3]
      }
      tbl.screenBets[j] = {}
      for bet, c in pairs(betCoinPlaces) do
        local bx = (c[1] - 512) / 1024 * 0.583744
        local by = (c[2] - 384) / 768 * 0.437808
        local x, y, z = tx, ty, tz
        x = x + screenCoords[j][1] * tbl.cos - screenCoords[j][2] * tbl.sin
        y = y + screenCoords[j][1] * tbl.sin + screenCoords[j][2] * tbl.cos
        z = z + screenCoords[j][3]
        x = x + screenCoords[j][7] * tbl.cos * bx - screenCoords[j][8] * tbl.sin * bx
        y = y + screenCoords[j][7] * tbl.sin * bx + screenCoords[j][8] * tbl.cos * bx
        z = z + screenCoords[j][9] * bx
        x = x + screenCoords[j][10] * tbl.cos * by - screenCoords[j][11] * tbl.sin * by
        y = y + screenCoords[j][10] * tbl.sin * by + screenCoords[j][11] * tbl.cos * by
        z = z + screenCoords[j][12] * by
        local nx = x + screenCoords[j][4] * tbl.cos - screenCoords[j][5] * tbl.sin
        local ny = y + screenCoords[j][4] * tbl.sin + screenCoords[j][5] * tbl.cos
        local nz = z + screenCoords[j][6]
        x = x + screenCoords[j][4] * tbl.cos * 0.0025 - screenCoords[j][5] * tbl.sin * 0.0025
        y = y + screenCoords[j][4] * tbl.sin * 0.0025 + screenCoords[j][5] * tbl.cos * 0.0025
        z = z + screenCoords[j][6] * 0.0025
        tbl.screenBets[j][bet] = {
          x - screenCoords[j][10] * tbl.cos * coinS + screenCoords[j][11] * tbl.sin * coinS,
          y - screenCoords[j][10] * tbl.sin * coinS - screenCoords[j][11] * tbl.cos * coinS,
          z - screenCoords[j][12] * coinS,
          x + screenCoords[j][10] * tbl.cos * coinS - screenCoords[j][11] * tbl.sin * coinS,
          y + screenCoords[j][10] * tbl.sin * coinS + screenCoords[j][11] * tbl.cos * coinS,
          z + screenCoords[j][12] * coinS,
          nx,
          ny,
          nz
        }
      end
      local x, y, z = tx, ty, tz
      x = x + screenCoords[j][1] * tbl.cos - screenCoords[j][2] * tbl.sin
      y = y + screenCoords[j][1] * tbl.sin + screenCoords[j][2] * tbl.cos
      z = z + screenCoords[j][3]
      local nx = x + screenCoords[j][4] * tbl.cos - screenCoords[j][5] * tbl.sin
      local ny = y + screenCoords[j][4] * tbl.sin + screenCoords[j][5] * tbl.cos
      local nz = z + screenCoords[j][6]
      x = x + screenCoords[j][4] * tbl.cos * 0.005 - screenCoords[j][5] * tbl.sin * 0.005
      y = y + screenCoords[j][4] * tbl.sin * 0.005 + screenCoords[j][5] * tbl.cos * 0.005
      z = z + screenCoords[j][6] * 0.005
      tbl.winCoord[j] = {
        x - screenCoords[j][10] * tbl.cos * 0.218904 + screenCoords[j][11] * tbl.sin * 0.218904,
        y - screenCoords[j][10] * tbl.sin * 0.218904 - screenCoords[j][11] * tbl.cos * 0.218904,
        z - screenCoords[j][12] * 0.218904,
        x + screenCoords[j][10] * tbl.cos * 0.218904 - screenCoords[j][11] * tbl.sin * 0.218904,
        y + screenCoords[j][10] * tbl.sin * 0.218904 + screenCoords[j][11] * tbl.cos * 0.218904,
        z + screenCoords[j][12] * 0.218904,
        nx,
        ny,
        nz
      }
    end
  end
end
function processHover(cx, cy)
  if cx < 170 or cy < 154 or 1001.5 < cx then
    return false
  end
  if 307.5 <= cy then
    if cy <= 478.5 then
      if 958.5 <= cx then
        if cx <= 1001.5 then
          if 421.5 <= cy then
            return "col1"
          elseif 364.5 <= cy then
            return "col2"
          else
            return "col3"
          end
        end
      elseif 442.5 <= cx then
        cx = (cx - 442.5) / 43
        cy = (cy - 307.5) / 57
        local px1 = cx % 1 <= 0.2
        local py2 = cy % 1 >= 0.8
        local py1, px2
        if cx <= 11 then
          px2 = cx % 1 >= 0.8
        end
        if 1 <= cy then
          py1 = cy % 1 <= 0.2
        end
        if px1 then
          if py1 then
            if 1 <= cx then
              return "corner" .. math.floor(4 - cy) + math.floor(cx - 1) * 3
            else
              return "trio" .. math.floor(4 - cy)
            end
          elseif py2 then
            if cx <= 1 then
              if cy <= 2 then
                return "trio" .. math.floor(4 - cy - 1)
              else
                return "basket"
              end
            elseif cy <= 2 then
              return "corner" .. math.floor(4 - cy - 1) + math.floor(cx - 1) * 3
            else
              return "doublestreet" .. 1 + math.floor(cx - 1) * 3
            end
          else
            return "splith" .. math.floor(4 - cy) + math.floor(cx) * 3
          end
        elseif px2 then
          if py1 then
            return "corner" .. math.floor(4 - cy) + math.floor(cx) * 3
          elseif py2 then
            if cy <= 2 then
              return "corner" .. math.floor(4 - cy - 1) + math.floor(cx) * 3
            else
              return "doublestreet" .. 1 + math.floor(cx) * 3
            end
          else
            return "splith" .. math.floor(4 - cy) + math.floor(cx + 1) * 3
          end
        elseif py1 then
          return "splitv" .. math.floor(4 - cy) + math.floor(cx) * 3
        elseif py2 then
          if cy <= 2 then
            return "splitv" .. math.floor(4 - cy - 1) + math.floor(cx) * 3
          else
            return "street" .. 1 + math.floor(cx) * 3
          end
        else
          return math.floor(4 - cy) + math.floor(cx) * 3
        end
      elseif 433.4 <= cx then
        cy = (cy - 307.5) / 57
        if cy <= 0.8 then
          return "splith3"
        elseif 2.8 <= cy then
          return "basket"
        elseif cy % 1 <= 0.2 then
          return "trio" .. math.floor(4 - cy)
        elseif cy % 1 >= 0.8 then
          return "trio" .. math.floor(4 - cy - 1)
        else
          return "splith" .. math.floor(4 - cy)
        end
      elseif 400 <= cx then
        return 0
      elseif 374.5 <= cx then
        return 1 >= math.abs(cy - 393) / 85.5 / ((cx - 374.5) / 25.5) and 0 or false
      end
    elseif 442.5 <= cx and cx <= 958.5 then
      if cy <= 489.9 then
        cx = (cx - 442.5) / 43
        if cx % 1 <= 0.2 then
          if cx <= 1 then
            return "basket"
          else
            return "doublestreet" .. 1 + math.floor(cx - 1) * 3
          end
        elseif cx <= 11 and cx % 1 >= 0.8 then
          return "doublestreet" .. 1 + math.floor(cx) * 3
        else
          return "street" .. 1 + math.floor(cx) * 3
        end
      elseif cy <= 535.5 then
        cx = (cx - 442.5) / 172
        return "d" .. math.floor(cx) + 1
      elseif cy <= 592.5 then
        cx = math.floor((cx - 442.5) / 86)
        if cx == 0 then
          return "1half"
        elseif cx == 1 then
          return "even"
        elseif cx == 2 then
          return "red"
        elseif cx == 3 then
          return "black"
        elseif cx == 4 then
          return "odd"
        elseif cx == 5 then
          return "2half"
        end
      end
    end
  elseif 154 <= cy and 170 <= cx then
    if cx <= 238.5 and cy <= 286.5 then
      cx = cx - 238.5
      cy = cy - 220.25
      local r = math.sqrt(cx * cx + cy * cy)
      if r <= 19.5 then
        return "tier"
      elseif r <= 67.5 then
        local r = -math.atan2(cx, cy)
        if r >= piq3 then
          return "n10"
        elseif r >= piq2 then
          return "n23"
        elseif r >= piq then
          return "n8"
        else
          return "n30"
        end
      end
    elseif cx <= 784.5 then
      if cy <= 201 then
        return "n" .. rouletteWheelNums[(math.floor((cx - 238.5) / 34.125) - 5) % 37 + 1]
      elseif cy <= 239.5 then
        if 699 <= cx then
          return "zero"
        elseif 546 <= cx then
          return "voisins"
        elseif 375 <= cx then
          return "orphelins"
        elseif 238.5 <= cx then
          return "tier"
        end
      elseif cy <= 286.5 then
        if 546 <= cx then
          return "n" .. rouletteWheelNums[30 - math.floor((cx - 238.5) / 34.125)]
        elseif 375 <= cx then
          return "n" .. rouletteWheelNums[24 - math.floor((cx - 375) / 57)]
        elseif 238.5 <= cx then
          return "n" .. rouletteWheelNums[28 - math.floor((cx - 238.5) / 34.125)]
        end
      end
    elseif cx <= 854 and cy <= 286.5 then
      cx = cx - 784.5
      cy = cy - 220.25
      local r = math.sqrt(cx * cx + cy * cy)
      if r <= 19.5 then
        return "zero"
      elseif r <= 67.5 then
        local r = math.atan2(cx, cy)
        if r >= pit2 then
          return "n3"
        elseif r >= pit then
          return "n26"
        else
          return "n0"
        end
      end
    end
  end
end
function getBetName(hover)
  if hover == "tier" then
    return "Le Tiers du Cylindre " .. lightGreyHex .. "(6 zsetonos gyorstét 12 számra)"
  elseif hover == "orphelins" then
    return "Orphelins \195\160 Cheval " .. lightGreyHex .. "(5 zsetonos gyorstét 8 számra)"
  elseif hover == "voisins" then
    return "Voisins du Zéro " .. lightGreyHex .. "(9 zsetonos gyorstét 17 számra)"
  elseif hover == "zero" then
    return "Jeu Zéro " .. lightGreyHex .. "(4 zsetonos gyorstét 7 számra)"
  elseif validBets[hover] == "straight" then
    return "Straight up " .. hover
  elseif validBets[hover] == "even" then
    return "Even " .. lightGreyHex .. "(Páros számok)"
  elseif validBets[hover] == "red" then
    return "Red " .. lightGreyHex .. "(Piros számok)"
  elseif validBets[hover] == "black" then
    return "Black " .. lightGreyHex .. "(Fekete számok)"
  elseif validBets[hover] == "odd" then
    return "Odd " .. lightGreyHex .. "(Páratlan számok)"
  elseif validBets[hover] == "basket" then
    return "Basket " .. lightGreyHex .. "(0-tól 3-ig)"
  elseif validBets[hover] then
    local n = validBets[hover][2]
    if validBets[hover][1] == "dozen" then
      if n == 1 then
        return "1. dozen " .. lightGreyHex .. "(1-től 12-ig)"
      elseif n == 2 then
        return "2. dozen " .. lightGreyHex .. "(13-tól 24-ig)"
      elseif n == 3 then
        return "3. dozen " .. lightGreyHex .. "(25-től 36-ig)"
      end
    elseif validBets[hover][1] == "half" then
      if n == 1 then
        return "Low " .. lightGreyHex .. "(1-től 18-ig)"
      elseif n == 2 then
        return "High " .. lightGreyHex .. "(19-től 36-ig)"
      end
    elseif validBets[hover][1] == "col" then
      return n .. ".column " .. lightGreyHex .. "(" .. n .. ", " .. n + 3 .. ", " .. n + 6 .. " ... " .. 33 + n .. "-ig)"
    elseif validBets[hover][1] == "splith" then
      return "Split " .. math.max(0, n - 3) .. "-" .. n
    elseif validBets[hover][1] == "splitv" then
      return "Split " .. n .. "-" .. n + 1
    elseif validBets[hover][1] == "trio" then
      return "Trio 0-" .. n .. "-" .. n + 1
    elseif validBets[hover][1] == "corner" then
      return "Corner " .. n .. "-" .. n + 1 .. "-" .. n + 3 .. "-" .. n + 4
    elseif validBets[hover][1] == "street" then
      return "Street " .. n .. "-" .. n + 2
    elseif validBets[hover][1] == "doublestreet" then
      return "Double Street " .. n .. "-" .. n + 2 .. " & " .. n + 3 .. "-" .. n + 5
    elseif validBets[hover][1] == "n" then
      return "3 zsetonos gyorstét: " .. neighbours[n][1] .. "-" .. n .. "-" .. neighbours[n][3]
    end
  end
end
function formatBetTooltip(tbl, hover)
  local name = getBetName(hover)
  if name then
    if tbl.bets[mySeat][hover] then
      if payoutsForBets[hover] then
        name = name .. "\n#ffffffTét: " .. greenHex .. sightexports.sGui:thousandsStepper(tbl.bets[mySeat][hover]) .. " SSC\n#ffffffKifizetés: " .. blueHex .. payoutsForBets[hover] .. ":1 " .. lightGreyHex .. "(" .. sightexports.sGui:thousandsStepper(tbl.bets[mySeat][hover] * (payoutsForBets[hover] + 1)) .. " SSC)"
      else
        name = name .. "\n#ffffffTét: " .. greenHex .. sightexports.sGui:thousandsStepper(tbl.bets[mySeat][hover]) .. " SSC"
      end
    elseif validBets[hover] and tbl.canBet and (not tbl.countdownTime or tbl.countdownTime > 0) and payoutsForBets[hover] then
      name = name .. "\n#ffffffMinimum tét: " .. greenHex .. minBet .. " SSC\n#ffffffKifizetés: " .. blueHex .. payoutsForBets[hover] .. ":1 " .. lightGreyHex .. "(" .. payoutsForBets[hover] + 1 .. "x)"
    end
    return name
  end
  return hover
end
local cx, cy = false, false
local currentCoin = 1
function drawHover(x, y, hover, hlColor)
  if hover == "zero" then
    sightlangStaticImageUsed[10] = true
    if sightlangStaticImageToc[10] then
      processsightlangStaticImage[10]()
    end
    dxDrawImage(x, y, 1024, 768, sightlangStaticImage[10], 0, 0, 0, hlColor)
    sightlangStaticImageUsed[11] = true
    if sightlangStaticImageToc[11] then
      processsightlangStaticImage[11]()
    end
    dxDrawImage(x, y, 1024, 768, sightlangStaticImage[11], 0, 0, 0, hlColor)
  elseif hover == "voisins" then
    sightlangStaticImageUsed[12] = true
    if sightlangStaticImageToc[12] then
      processsightlangStaticImage[12]()
    end
    dxDrawImage(x, y, 1024, 768, sightlangStaticImage[12], 0, 0, 0, hlColor)
    sightlangStaticImageUsed[11] = true
    if sightlangStaticImageToc[11] then
      processsightlangStaticImage[11]()
    end
    dxDrawImage(x, y, 1024, 768, sightlangStaticImage[11], 0, 0, 0, hlColor)
  elseif hover == "tier" then
    sightlangStaticImageUsed[13] = true
    if sightlangStaticImageToc[13] then
      processsightlangStaticImage[13]()
    end
    dxDrawImage(x, y, 1024, 768, sightlangStaticImage[13], 0, 0, 0, hlColor)
  elseif hover == "n0" then
    sightlangStaticImageUsed[11] = true
    if sightlangStaticImageToc[11] then
      processsightlangStaticImage[11]()
    end
    dxDrawImage(x, y, 1024, 768, sightlangStaticImage[11], 0, 0, 0, hlColor)
    sightlangStaticImageUsed[14] = true
    if sightlangStaticImageToc[14] then
      processsightlangStaticImage[14]()
    end
    dxDrawImage(x, y, 1024, 768, sightlangStaticImage[14], 0, 0, 0, hlColor)
  elseif hover == "n10" then
    sightlangStaticImageUsed[15] = true
    if sightlangStaticImageToc[15] then
      processsightlangStaticImage[15]()
    end
    dxDrawImage(x, y, 1024, 768, sightlangStaticImage[15], 0, 0, 0, hlColor)
  elseif hover == "n11" then
    sightlangStaticImageUsed[16] = true
    if sightlangStaticImageToc[16] then
      processsightlangStaticImage[16]()
    end
    dxDrawImage(x, y, 1024, 768, sightlangStaticImage[16], 0, 0, 0, hlColor)
  elseif hover == "n23" then
    sightlangStaticImageUsed[17] = true
    if sightlangStaticImageToc[17] then
      processsightlangStaticImage[17]()
    end
    dxDrawImage(x, y, 1024, 768, sightlangStaticImage[17], 0, 0, 0, hlColor)
  elseif hover == "n26" then
    sightlangStaticImageUsed[11] = true
    if sightlangStaticImageToc[11] then
      processsightlangStaticImage[11]()
    end
    dxDrawImage(x, y, 1024, 768, sightlangStaticImage[11], 0, 0, 0, hlColor)
    sightlangStaticImageUsed[18] = true
    if sightlangStaticImageToc[18] then
      processsightlangStaticImage[18]()
    end
    dxDrawImage(x, y, 1024, 768, sightlangStaticImage[18], 0, 0, 0, hlColor)
  elseif hover == "n3" then
    sightlangStaticImageUsed[19] = true
    if sightlangStaticImageToc[19] then
      processsightlangStaticImage[19]()
    end
    dxDrawImage(x, y, 1024, 768, sightlangStaticImage[19], 0, 0, 0, hlColor)
  elseif hover == "n30" then
    sightlangStaticImageUsed[20] = true
    if sightlangStaticImageToc[20] then
      processsightlangStaticImage[20]()
    end
    dxDrawImage(x, y, 1024, 768, sightlangStaticImage[20], 0, 0, 0, hlColor)
  elseif hover == "n32" then
    sightlangStaticImageUsed[11] = true
    if sightlangStaticImageToc[11] then
      processsightlangStaticImage[11]()
    end
    dxDrawImage(x, y, 1024, 768, sightlangStaticImage[11], 0, 0, 0, hlColor)
    sightlangStaticImageUsed[21] = true
    if sightlangStaticImageToc[21] then
      processsightlangStaticImage[21]()
    end
    dxDrawImage(x, y, 1024, 768, sightlangStaticImage[21], 0, 0, 0, hlColor)
  elseif hover == "n35" then
    sightlangStaticImageUsed[22] = true
    if sightlangStaticImageToc[22] then
      processsightlangStaticImage[22]()
    end
    dxDrawImage(x, y, 1024, 768, sightlangStaticImage[22], 0, 0, 0, hlColor)
  elseif hover == "n5" then
    sightlangStaticImageUsed[23] = true
    if sightlangStaticImageToc[23] then
      processsightlangStaticImage[23]()
    end
    dxDrawImage(x, y, 1024, 768, sightlangStaticImage[23], 0, 0, 0, hlColor)
  elseif hover == "n8" then
    sightlangStaticImageUsed[24] = true
    if sightlangStaticImageToc[24] then
      processsightlangStaticImage[24]()
    end
    dxDrawImage(x, y, 1024, 768, sightlangStaticImage[24], 0, 0, 0, hlColor)
  elseif hover == 0 or hover == "basket" or hover == "trio1" or hover == "trio2" or hover == "splith1" or hover == "splith2" or hover == "splith3" then
    sightlangStaticImageUsed[11] = true
    if sightlangStaticImageToc[11] then
      processsightlangStaticImage[11]()
    end
    dxDrawImage(x, y, 1024, 768, sightlangStaticImage[11], 0, 0, 0, hlColor)
  end
  if hoverRectangles[hover] then
    for i = 1, #hoverRectangles[hover] do
      local r = hoverRectangles[hover][i]
      dxDrawRectangle(x + r[1], y + r[2], r[3], r[4], hlColor)
    end
  end
end
function drawTable(x, y)
  local now = getTickCount()
  local tbl = rouletteTables[myTable]
  sightlangStaticImageUsed[25] = true
  if sightlangStaticImageToc[25] then
    processsightlangStaticImage[25]()
  end
  dxDrawImage(x, y, 1024, 768, sightlangStaticImage[25])
  if tbl.bounceStart then
    sightlangStaticImageUsed[26] = true
    if sightlangStaticImageToc[26] then
      processsightlangStaticImage[26]()
    end
    dxDrawImageSection(x + 660, y + 72, 364, 44, -208 + (tbl.ballRotBounce - tbl.ballWrs) / math.pi * 814, 0, 364, 44, sightlangStaticImage[26])
  elseif tbl.spinUp or tbl.slowDown then
    sightlangStaticImageUsed[26] = true
    if sightlangStaticImageToc[26] then
      processsightlangStaticImage[26]()
    end
    dxDrawImageSection(x + 660, y + 72, 364, 44, -208 + (tbl.ballRot - tbl.ballWrs) / math.pi * 814, 0, 364, 44, sightlangStaticImage[26])
  else
    sightlangStaticImageUsed[26] = true
    if sightlangStaticImageToc[26] then
      processsightlangStaticImage[26]()
    end
    dxDrawImageSection(x + 660, y + 72, 364, 44, -208 + tbl.lastPos * 44, 0, 364, 44, sightlangStaticImage[26])
  end
  local eDelta = tbl.ended and now - tbl.ended - 1000
  local ep = false
  local ep2 = false
  local rp = false
  local pulse = false
  if tbl.newRound then
    rp = 1 - math.min(1, (now - tbl.newRound) / 1000)
    pulse = now % 1500 / 1500
    if 0.5 < pulse then
      pulse = 1 - pulse
    end
    pulse = getEasingValue(pulse * 2, "OutQuad")
    sightlangStaticImageUsed[27] = true
    if sightlangStaticImageToc[27] then
      processsightlangStaticImage[27]()
    end
    dxDrawImage(x + 858, y + 62, 64, 64, sightlangStaticImage[27], 0, 0, 0, tocolor(255, 255, 255, (155 + 100 * pulse) * rp))
  elseif eDelta and 0 < eDelta then
    ep = math.min(1, eDelta / 1000)
    ep2 = math.min(1, eDelta / 3000)
    pulse = now % 1500 / 1500
    if 0.5 < pulse then
      pulse = 1 - pulse
    end
    pulse = getEasingValue(pulse * 2, "OutQuad")
    sightlangStaticImageUsed[27] = true
    if sightlangStaticImageToc[27] then
      processsightlangStaticImage[27]()
    end
    dxDrawImage(x + 858, y + 62, 64, 64, sightlangStaticImage[27], 0, 0, 0, tocolor(255, 255, 255, (155 + 100 * pulse) * ep))
  end
  sightlangStaticImageUsed[28] = true
  if sightlangStaticImageToc[28] then
    processsightlangStaticImage[28]()
  end
  dxDrawImage(x, y, 1024, 768, sightlangStaticImage[28])
  local tcx, tcy = getCursorPosition()
  local tmp = false
  if tcx and bigWindow then
    tcx = tcx * screenX - x
    tcy = tcy * screenY - y
    if tcx ~= cx or tcy ~= cy then
      cx = tcx
      cy = tcy
      tmp = processHover(cx, cy)
      if tmp ~= hover then
        hover = tmp
        sightexports.sGui:setCursorType(hover and "link" or "normal")
        sightexports.sGui:showTooltip(formatBetTooltip(tbl, hover))
      end
    end
  elseif hover then
    hover = false
    sightexports.sGui:setCursorType("normal")
    sightexports.sGui:showTooltip()
    tcx, tcy = false, false
  end
  if ep or rp then
    local a = 120 + 85 * pulse
    drawHover(x, y, tbl.lastNumber, tocolor(218, 181, 72, a * (ep or rp)))
  elseif hover then
    drawHover(x, y, hover, hlColor)
  end
  sightlangStaticImageUsed[29] = true
  if sightlangStaticImageToc[29] then
    processsightlangStaticImage[29]()
  end
  dxDrawImage(x, y, 1024, 768, sightlangStaticImage[29])
  if eDelta and 0 < eDelta then
    dxDrawText("Játék vége, eredményhirdetés", x + 15, y + 68, 0, y + 120, tocolor(255, 255, 255), cdFontScale * 0.8, cdFont, "left", "center")
  elseif tbl.spinUp or tbl.slowDown or tbl.bounceStart or tbl.ended then
    dxDrawText("Sok szerencsét!", x + 15, y + 68, 0, y + 120, tocolor(255, 255, 255), cdFontScale * 0.8, cdFont, "left", "center")
  else
    local w = 0
    local py = 120
    if tbl.countdownTime and 0 < tbl.countdownTime then
      local p = math.max(0, 1 - (now - (tbl.countdown or 0)) / (countdownTime * 1000))
      dxDrawRectangle(x + 7, y + 117, 350, 3, tocolor(180, 180, 180))
      dxDrawRectangle(x + 7, y + 117, 350 * p, 3, tocolor(245, 95, 95))
      py = 117
      w = 56
      dxDrawText(tbl.countdownTime .. "s", x + 15, y + 68, 0, y + py, tocolor(245, 95, 95), cdFontScale * 1.25, cdFont, "left", "center")
    end
    if not tbl.countdownTime or 0 < tbl.countdownTime then
      dxDrawText("Kérem tegyék meg tétjeiket!", x + 15 + w, y + 68, 0, y + py, tocolor(255, 255, 255), cdFontScale * 0.8, cdFont, "left", "center")
    else
      dxDrawText("Köszönöm, nincs több tét!", x + 15 + w, y + 68, 0, y + py, tocolor(255, 255, 255), cdFontScale * 0.8, cdFont, "left", "center")
    end
  end
  local excludeBets = false
  if tbl.canBet and (not tbl.countdownTime or 0 < tbl.countdownTime) then
    if hover == "tier" then
      for i = 1, #tierBets do
        local bet = tierBets[i]
        local r = betCoinPlaces[bet]
        if r then
          local s = 14
          local c = 0
          if myLastBets[bet] then
            local p = (now - myLastBets[bet]) / 400
            if 1 < p then
              p = 1
              myLastBets[bet] = nil
            end
            if myBetPlus[bet] then
              s = 19 - 5 * getEasingValue(p, "OutQuad")
            else
              s = 14 + 5 * getEasingValue(p, "OutQuad")
            end
          else
            c = coinValues[math.max(currentCoin, minCoin)]
          end
          if tbl.bets[mySeat][bet] then
            c = processBetCoinEx(tbl.bets[mySeat][bet] + c)
          else
            c = processBetCoinEx(c)
          end
          sightlangStaticImageUsed[30] = true
          if sightlangStaticImageToc[30] then
            processsightlangStaticImage[30]()
          end
          dxDrawImage(x + r[1] - 14, y + r[2] - 14, 28, 28, sightlangStaticImage[30])
          dxDrawImage(x + r[1] - s, y + r[2] - s, s * 2, s * 2, dynamicImage("files/coin/c" .. c .. ".dds"))
        end
      end
      excludeBets = tierBetsRev
    elseif hover == "orphelins" then
      for i = 1, #orphelinsBets do
        local bet = orphelinsBets[i]
        local r = betCoinPlaces[bet]
        if r then
          local s = 14
          local c = 0
          if myLastBets[bet] then
            local p = (now - myLastBets[bet]) / 400
            if 1 < p then
              p = 1
              myLastBets[bet] = nil
            end
            if myBetPlus[bet] then
              s = 19 - 5 * getEasingValue(p, "OutQuad")
            else
              s = 14 + 5 * getEasingValue(p, "OutQuad")
            end
          else
            c = coinValues[math.max(currentCoin, minCoin)]
          end
          if tbl.bets[mySeat][bet] then
            c = processBetCoinEx(tbl.bets[mySeat][bet] + c)
          else
            c = processBetCoinEx(c)
          end
          sightlangStaticImageUsed[30] = true
          if sightlangStaticImageToc[30] then
            processsightlangStaticImage[30]()
          end
          dxDrawImage(x + r[1] - 14, y + r[2] - 14, 28, 28, sightlangStaticImage[30])
          dxDrawImage(x + r[1] - s, y + r[2] - s, s * 2, s * 2, dynamicImage("files/coin/c" .. c .. ".dds"))
        end
      end
      excludeBets = orphelinsBetsRev
    elseif hover == "voisins" then
      for i = 1, #voisinsBets do
        local bet = voisinsBets[i]
        local r = betCoinPlaces[bet]
        if r then
          local s = 14
          local c = 0
          if myLastBets[bet] then
            local p = (now - myLastBets[bet]) / 400
            if 1 < p then
              p = 1
              myLastBets[bet] = nil
            end
            if myBetPlus[bet] then
              s = 19 - 5 * getEasingValue(p, "OutQuad")
            else
              s = 14 + 5 * getEasingValue(p, "OutQuad")
            end
          elseif bet == "trio2" or bet == "corner25" then
            c = coinValues[math.max(currentCoin, minCoin)] * 2
          else
            c = coinValues[math.max(currentCoin, minCoin)]
          end
          if tbl.bets[mySeat][bet] then
            c = processBetCoinEx(tbl.bets[mySeat][bet] + c)
          else
            c = processBetCoinEx(c)
          end
          sightlangStaticImageUsed[30] = true
          if sightlangStaticImageToc[30] then
            processsightlangStaticImage[30]()
          end
          dxDrawImage(x + r[1] - 14, y + r[2] - 14, 28, 28, sightlangStaticImage[30])
          dxDrawImage(x + r[1] - s, y + r[2] - s, s * 2, s * 2, dynamicImage("files/coin/c" .. c .. ".dds"))
        end
      end
      excludeBets = voisinsBetsRev
    elseif hover == "zero" then
      for i = 1, #zeroBets do
        local bet = zeroBets[i]
        local r = betCoinPlaces[bet]
        if r then
          local s = 14
          local c = 0
          if myLastBets[bet] then
            local p = (now - myLastBets[bet]) / 400
            if 1 < p then
              p = 1
              myLastBets[bet] = nil
            end
            if myBetPlus[bet] then
              s = 19 - 5 * getEasingValue(p, "OutQuad")
            else
              s = 14 + 5 * getEasingValue(p, "OutQuad")
            end
          else
            c = coinValues[math.max(currentCoin, minCoin)]
          end
          if tbl.bets[mySeat][bet] then
            c = processBetCoinEx(tbl.bets[mySeat][bet] + c)
          else
            c = processBetCoinEx(c)
          end
          sightlangStaticImageUsed[30] = true
          if sightlangStaticImageToc[30] then
            processsightlangStaticImage[30]()
          end
          dxDrawImage(x + r[1] - 14, y + r[2] - 14, 28, 28, sightlangStaticImage[30])
          dxDrawImage(x + r[1] - s, y + r[2] - s, s * 2, s * 2, dynamicImage("files/coin/c" .. c .. ".dds"))
        end
      end
      excludeBets = zeroBetsRev
    elseif hover and type(validBets[hover]) == "table" and validBets[hover][1] == "n" then
      local n = validBets[hover][2]
      for i = 1, 3 do
        local bet = neighbours[n][i]
        local r = betCoinPlaces[bet]
        if r then
          local s = 14
          local c = 0
          if myLastBets[bet] then
            local p = (now - myLastBets[bet]) / 400
            if 1 < p then
              p = 1
              myLastBets[bet] = nil
            end
            if myBetPlus[bet] then
              s = 19 - 5 * getEasingValue(p, "OutQuad")
            else
              s = 14 + 5 * getEasingValue(p, "OutQuad")
            end
          else
            c = coinValues[math.max(currentCoin, minCoin)]
          end
          if tbl.bets[mySeat][bet] then
            c = processBetCoinEx(tbl.bets[mySeat][bet] + c)
          else
            c = processBetCoinEx(c)
          end
          sightlangStaticImageUsed[30] = true
          if sightlangStaticImageToc[30] then
            processsightlangStaticImage[30]()
          end
          dxDrawImage(x + r[1] - 14, y + r[2] - 14, 28, 28, sightlangStaticImage[30])
          dxDrawImage(x + r[1] - s, y + r[2] - s, s * 2, s * 2, dynamicImage("files/coin/c" .. c .. ".dds"))
        end
      end
      excludeBets = neighboursEx[n]
    end
  end
  local wt = eDelta and eDelta - 3500
  if ep and 1 <= ep and not rp then
    myWin = 0
  end
  if not rp then
    for bet, value in pairs(tbl.bets[mySeat]) do
      local r = betCoinPlaces[bet]
      if r and (not excludeBets or not excludeBets[bet]) then
        if ep then
          local s = 14
          if tbl.winnerBets[bet] and payoutsForBets[bet] then
            if 1 <= ep then
              local cx, cy, a = interpolateBetween(r[1], r[2], 1, 512, 230, 0, math.min(1, math.max(0, wt / 2000)), "OutQuad")
              myWin = myWin + value * (1 + payoutsForBets[bet]) * (1 - a)
              wt = wt - 450
              sightlangStaticImageUsed[30] = true
              if sightlangStaticImageToc[30] then
                processsightlangStaticImage[30]()
              end
              dxDrawImage(x + cx - s, y + cy - s, s * 2, s * 2, sightlangStaticImage[30], 0, 0, 0, tocolor(255, 255, 255, (155 + 100 * pulse) * ep * a))
              dxDrawImage(x + cx - s, y + cy - s, s * 2, s * 2, dynamicImage("files/coin/c" .. tbl.betCoins[mySeat][bet] .. ".dds"), 0, 0, 0, tocolor(255, 255, 255, 255 * a))
            else
              sightlangStaticImageUsed[30] = true
              if sightlangStaticImageToc[30] then
                processsightlangStaticImage[30]()
              end
              dxDrawImage(x + r[1] - s, y + r[2] - s, s * 2, s * 2, sightlangStaticImage[30], 0, 0, 0, tocolor(255, 255, 255, (155 + 100 * pulse) * ep))
              dxDrawImage(x + r[1] - s, y + r[2] - s, s * 2, s * 2, dynamicImage("files/coin/c" .. tbl.betCoins[mySeat][bet] .. ".dds"), 0, 0, 0, tocolor(255, 255, 255))
            end
          else
            s = s - 3 * ep
            dxDrawImage(x + r[1] - s, y + r[2] - s, s * 2, s * 2, dynamicImage("files/coin/c" .. tbl.betCoins[mySeat][bet] .. ".dds"), 0, 0, 0, tocolor(255 - 125 * ep, 255 - 125 * ep, 255 - 125 * ep, 255 - 255 * ep2))
          end
        else
          local s = 14
          if myLastBets[bet] then
            local p = (now - myLastBets[bet]) / 400
            if 1 < p then
              p = 1
              myLastBets[bet] = nil
            end
            if myBetPlus[bet] then
              s = 19 - 5 * getEasingValue(p, "OutQuad")
            else
              s = 14 + 5 * getEasingValue(p, "OutQuad")
            end
          end
          dxDrawImage(x + r[1] - s, y + r[2] - s, s * 2, s * 2, dynamicImage("files/coin/c" .. tbl.betCoins[mySeat][bet] .. ".dds"), 0, 0, 0, tocolor(255, 255, 255, excludeBets and 102 or 255))
        end
      end
    end
  end
  if ep and 1 <= ep and not rp then
    myWin = math.floor(myWin)
    myWinFormatted = sightexports.sGui:thousandsStepper(myWin)
  end
  local w = 42.083333333333336
  local hx = 7 + x + w / 2 - 12
  local a = 255
  local n = #tbl.history
  if tbl.bounceStart or tbl.ended and now - tbl.ended <= 1000 then
    n = n - 1
  end
  local to = math.max(1, n - 23)
  for i = n, to, -1 do
    if tbl.history[i] then
      local c = tocolor(255, 255, 255, a)
      if tbl.history[i][2] == 1 then
        sightlangStaticImageUsed[31] = true
        if sightlangStaticImageToc[31] then
          processsightlangStaticImage[31]()
        end
        dxDrawImage(hx, y + 21, 24, 24, sightlangStaticImage[31], 0, 0, 0, c)
      elseif tbl.history[i][2] == 2 then
        sightlangStaticImageUsed[32] = true
        if sightlangStaticImageToc[32] then
          processsightlangStaticImage[32]()
        end
        dxDrawImage(hx, y + 21, 24, 24, sightlangStaticImage[32], 0, 0, 0, c)
      else
        sightlangStaticImageUsed[33] = true
        if sightlangStaticImageToc[33] then
          processsightlangStaticImage[33]()
        end
        dxDrawImage(hx, y + 21, 24, 24, sightlangStaticImage[33], 0, 0, 0, c)
      end
      dxDrawText(tbl.history[i][1], hx, y + 21, hx + 24, y + 45, c, numberFontScale, numberFont, "center", "center")
      hx = hx + w
      a = a - 8
    end
  end
  dxDrawText(balanceText, x + 219, y + 725, x + 407, y + 753, tocolor(255, 255, 255), cdFontScale * 0.8, cdFont, "center", "center")
  dxDrawText(myBetFormatted, x, y + 725, x + 1024, y + 753, tocolor(255, 255, 255), cdFontScale * 0.8, cdFont, "center", "center")
  dxDrawText(myWinFormatted, x + 617, y + 725, x + 807, y + 753, tocolor(255, 255, 255), cdFontScale * 0.8, cdFont, "center", "center")
  sightlangStaticImageUsed[34] = true
  if sightlangStaticImageToc[34] then
    processsightlangStaticImage[34]()
  end
  dxDrawImage(x + 6, y + 315, 350, 270, sightlangStaticImage[34])
  dxDrawImage(x + 21, y + 330, 320, 240, tbl.bigRt)
  sightlangStaticImageUsed[35] = true
  if sightlangStaticImageToc[35] then
    processsightlangStaticImage[35]()
  end
  dxDrawImage(x + 19, y + 328, 324, 244, sightlangStaticImage[35])
  if (tbl.newRound or eDelta) and tbl.win[mySeat] then
    local gp = 0
    local p = 0.5
    local tp = 1
    if tbl.newRound then
      gp = rp
      p = now % 2000 / 2000
    elseif eDelta and 0 < eDelta then
      gp = ep
      p = now % 2000 / 2000
      tp = math.min(1, math.max(0, (eDelta - 3500) / 500))
    end
    if 0 < gp then
      sightlangStaticImageUsed[36] = true
      if sightlangStaticImageToc[36] then
        processsightlangStaticImage[36]()
      end
      dxDrawImageSection(x + 7, y + 7, 1010, 754, 0, -756 * p, 1012, 756, sightlangStaticImage[36], 0, 0, 0, tocolor(243, 210, 74, 75 * gp))
      sightlangStaticImageUsed[37] = true
      if sightlangStaticImageToc[37] then
        processsightlangStaticImage[37]()
      end
      dxDrawImage(x, y + 146, 1024, 100, sightlangStaticImage[37], 0, 0, 0, tocolor(255, 255, 255, 255 * gp))
      sightlangStaticImageUsed[38] = true
      if sightlangStaticImageToc[38] then
        processsightlangStaticImage[38]()
      end
      dxDrawImage(x, y + 107 + 16 * (1 - tp), 1024, 146, sightlangStaticImage[38], 0, 0, 0, tocolor(255, 255, 255, 255 * gp))
      if 0 < tp then
        local text2 = myWinFormatted .. " SSC"
        local n = utf8.len(text2)
        local w = 12
        local x = x + 512 + w * n / 2
        for i = 1, n do
          local d = 1 - (i - n * p) % n / n
          if 0.5 < d then
            d = (1 - d) * 2
          else
            d = d * 2
          end
          d = 0.75 + getEasingValue(d, "InQuad") * 0.25
          dxDrawText(utf8.sub(text2, -i, -i), x - w, y + 200, x, y + 246, tocolor(243 * d, 210 * d, 74 * d, 255 * tp), cdFontScale * 0.85, cdFont, "center", "center")
          x = x - w
        end
      end
    end
  elseif tbl.countdownTime and tbl.countdownTime <= 10 and tbl.countdown then
    local delta = now - tbl.countdown
    local a = 1 - delta % 1000 / 1000
    if delta < countdownTime * 1000 then
      sightlangStaticImageUsed[36] = true
      if sightlangStaticImageToc[36] then
        processsightlangStaticImage[36]()
      end
      dxDrawImageSection(x + 7, y + 7, 1010, 754, 0, -378 - 756 * delta / 1000, 1012, 756, sightlangStaticImage[36], 0, 0, 0, tocolor(245, 95, 95, 125 * a))
    end
  end
  local cx = x + 512 - 64 * #coinValues / 2
  local cy = y + 632
  for i = 1, #coinValues do
    local curr = i == currentCoin
    local s = curr and 1 or 0.9
    if curr then
      sightlangStaticImageUsed[30] = true
      if sightlangStaticImageToc[30] then
        processsightlangStaticImage[30]()
      end
      dxDrawImage(cx + 64 * (1 - s) / 2, cy + 64 * (1 - s) / 2, 64 * s, 64 * s, sightlangStaticImage[30])
    end
    dxDrawImage(cx + 64 * (1 - s) / 2, cy + 64 * (1 - s) / 2, 64 * s, 64 * s, dynamicImage("files/coin/" .. i .. ".dds"))
    dxDrawText(coinValues[i], cx, cy, cx + 64, cy + 60.8, tocolor(0, 0, 0), helpFontScale * s, helpFont, "center", "center")
    sightlangStaticImageUsed[39] = true
    if sightlangStaticImageToc[39] then
      processsightlangStaticImage[39]()
    end
    dxDrawImage(cx + 64 * (1 - s) / 2, cy + 64 * (1 - s) / 2, 64 * s, 64 * s, sightlangStaticImage[39], 0, 0, 0, tocolor(255, 255, 255, curr and 255 or 175))
    cx = cx + 64
  end
  sightlangStaticImageUsed[40] = true
  if sightlangStaticImageToc[40] then
    processsightlangStaticImage[40]()
  end
  dxDrawImage(x, y, 1024, 768, sightlangStaticImage[40])
end
function preRenderRoulette(delta)
  if balanceSpeed then
    if balance > balanceNew then
      balance = balance - balanceSpeed * delta
      if balance < balanceNew then
        balance = balanceNew
        balanceSpeed = false
      end
      convertBalanceText()
    end
    if balance < balanceNew then
      balance = balance + balanceSpeed * delta
      if balance > balanceNew then
        balance = balanceNew
        balanceSpeed = false
      end
      convertBalanceText()
    end
  end
  local now = getTickCount()
  local pulse = now % 1500 / 1500
  if 0.5 < pulse then
    pulse = 1 - pulse
  end
  pulse = getEasingValue(pulse * 2, "OutQuad")
  wheelRot = (wheelRot - wrSpeed * delta / 1000) % 360
  local px, py, pz = getElementPosition(localPlayer)
  local camx, camy, camz = getCameraMatrix()
  for l = 1, #streamedIn do
    local i = streamedIn[l]
    local tbl = rouletteTables[i]
    local tx, ty, tz = rouletteTableCoords[i][1], rouletteTableCoords[i][2], rouletteTableCoords[i][3]
    tbl.d = getDistanceBetweenPoints3D(tx, ty, tz, camx, camy, camz)
    tbl.onScreen = i == myTable or isElementOnScreen(tbl.obj) and tbl.d < 75 and pz - tz < 5
    local wr = wheelRot + tbl.wheelRandom
    local wrs = math.rad(wr)
    tbl.ballWrs = wrs
    if tbl.spinUp or tbl.slowDown then
      tbl.ballRot = tbl.ballRot + tbl.ballSpeed * delta / 1000
    end
    if tbl.bounceNextLP then
      bounceTheBallFinal(i, tbl.bounceNextLP, tbl.bounceNextN)
      tbl.bounceNextLP = nil
      tbl.bounceNextN = nil
    end
    if tbl.newRound and 1000 < now - tbl.newRound then
      tbl.canBet = true
      tbl.newRound = false
      tbl.countdown = false
      tbl.countdownTime = false
      for i = 1, 8 do
        tbl.bets[i] = {}
        tbl.betCoins[i] = {}
      end
      myLastBets = {}
      if i == myTable then
        myBet = 0
        myBetFormatted = 0
      end
    end
    local rot = 0
    local rad = 0
    local pos = 0
    if tbl.bounceStart then
      local bDelta = now - tbl.bounceStart
      local n = #tbl.bounces
      for i = 1, n do
        local bounce = tbl.bounces[i]
        local t = bounce[5]
        bDelta = bDelta - t
        if bDelta <= 0 then
          local p = (bDelta + t) / t
          if not bounce[6] then
            if tbl.spinSound then
              if isElement(tbl.spinSound) then
                destroyElement(tbl.spinSound)
              end
              tbl.spinSound = false
            end
            playBallSound(tbl, "knock-0" .. math.random(1, 8))
            bounce[6] = true
          end
          if i == n then
            rad = bounce[3] + bounce[4] * p
            p = getEasingValue(p, "OutQuad")
          elseif i == 1 then
            rad = bounce[3] + bounce[4] * getEasingValue(p, "InQuad")
          else
            rad = bounce[3] + bounce[4] * p
          end
          rot = bounce[1] + bounce[2] * p
          break
        end
      end
      if 0 < bDelta then
        rot = tbl.bounces[n][1] + tbl.bounces[n][2]
        rad = tbl.bounces[n][3] + tbl.bounces[n][4]
        tbl.bounceStart = false
        playBallSound(tbl, "end")
      end
      tbl.ballRotBounce = rot
      pos = rad < 0.435 and calculateZSegment(rad) or spinZ
    elseif tbl.slowDown then
      local p = getEasingValue(math.min(1, (now - tbl.slowDown) / 5000), "OutQuad")
      tbl.ballSpeed = slowSpeed + sfSpeed * (1 - p)
      setSoundSpeed(tbl.spinSound, 1.05 - 0.1 * p)
      rot, rad, pos = tbl.ballRot, 0.435, spinZ
    elseif tbl.spinUp then
      local p = getEasingValue(math.min(1, (now - tbl.spinUp) / 5000), "OutQuad")
      tbl.ballSpeed = fastSpeed * p
      local p2 = math.min(1, p * 7)
      rad = 0.275 + 0.16 * p2
      setSoundVolume(tbl.spinSound, p2)
      setSoundSpeed(tbl.spinSound, 0.95 + 0.1 * p)
      pos = rad < 0.435 and calculateZSegment(rad) or spinZ
      rot = tbl.ballRot
    else
      rot, rad, pos = wrs + oneRad * tbl.lastPos, 0.275, restZ
    end
    if tbl.onScreen then
      if tbl.d < 15 then
        setElementRotation(tbl.wheel, 0, 0, -wr + rouletteTableCoords[i][4])
      end
      for i = 1, 8 do
        if isElement(tbl.players[i]) then
          setElementRotation(tbl.players[i], 0, 0, tbl.seats[i][4], "default", true)
          local a, b = getPedAnimation(tbl.players[i])
          if a ~= "int_office" or b ~= "off_sit_idle_loop" then
            setPedAnimation(tbl.players[i], "int_office", "off_sit_idle_loop", -1, true, false, false, false)
          end
        end
      end
    end
    if tbl.countdown then
      local new = math.max(0, math.ceil(countdownTime - (now - tbl.countdown) / 1000))
      if tbl.countdownTime ~= new then
        tbl.countdownTime = new
        if new <= 10 and 1 <= new then
          playTableSound("10sec", i)
        end
        if i == myTable and new <= 0 then
          sightexports.sGui:showTooltip(formatBetTooltip(tbl, hover))
        end
      end
    end
    local s = 246
    local zoom = 0
    local xp = 0
    local eDelta = false
    if tbl.spinUp then
      xp = 1 - getEasingValue(math.min(1, (now - tbl.spinUp) / 1000), "InOutQuad")
    elseif tbl.bounceStart then
      local bDelta = now - tbl.bounceStart
      zoom = math.min(1, bDelta / 3500)
      if zoom < 1 then
        zoom = getEasingValue(zoom, "InOutQuad")
      end
    elseif tbl.ended then
      eDelta = now - tbl.ended
      eDelta = eDelta - 3500
      if 5000 < eDelta then
        xp = 1
        zoom = 0
      elseif 0 < eDelta then
        xp = math.min(1, eDelta / 5000)
        zoom = 1 - xp
        if zoom < 1 then
          zoom = getEasingValue(zoom, "InOutQuad")
        end
        if 1 < xp then
          xp = 1
        else
          xp = math.max(0, xp * 2 - 1)
        end
      else
        zoom = 1
      end
    elseif not tbl.spinUp and tbl.ballSpeed <= 0 then
      xp = 1
    end
    s = s * (1 + zoom * 1.05)
    if tbl.onScreen then
      if tbl.d < 15 then
        processBall(i, tbl, rot, rad, pos)
      end
      dxSetBlendMode("modulate_add")
      dxSetRenderTarget(tbl.ledRt, true)
      local degRot = math.deg(rot)
      if tbl.spinUp or tbl.slowDown or tbl.bounceStart or tbl.ended and 1000 >= now - tbl.ended then
        dxDrawRectangle(0, 8, 360, 8, tocolor(220, 175, 16, 50))
        sightlangStaticImageUsed[41] = true
        if sightlangStaticImageToc[41] then
          processsightlangStaticImage[41]()
        end
        dxDrawImageSection(0, 8, 360, 8, -180 - degRot, 0, 360, 8, sightlangStaticImage[41], 0, 0, 0, tocolor(220, 175, 16))
        dxDrawRectangle(0, 0, 360, 8, tocolor(220, 175, 16, 150))
        dxDrawRectangle(0, 24, 360, 8, tocolor(220, 175, 16, 50))
        sightlangStaticImageUsed[42] = true
        if sightlangStaticImageToc[42] then
          processsightlangStaticImage[42]()
        end
        dxDrawImageSection(0, 0, 360, 8, -180 + degRot, 0, 360, 8, sightlangStaticImage[42], 0, 0, 0, tocolor(220, 175, 16))
        sightlangStaticImageUsed[42] = true
        if sightlangStaticImageToc[42] then
          processsightlangStaticImage[42]()
        end
        dxDrawImageSection(0, 24, 360, 8, -180 - degRot, 0, 360, 8, sightlangStaticImage[42], 0, 0, 0, tocolor(220, 175, 16))
      else
        if tbl.lastNumberColor == 1 then
          dxDrawRectangle(0, 0, 360, 16, tocolor(205, 50, 38, 150))
        elseif tbl.lastNumberColor == 2 then
          dxDrawRectangle(0, 0, 360, 16, tocolor(10, 10, 10, 150))
        else
          dxDrawRectangle(0, 0, 360, 16, tocolor(0, 166, 62, 150))
        end
        sightlangStaticImageUsed[41] = true
        if sightlangStaticImageToc[41] then
          processsightlangStaticImage[41]()
        end
        dxDrawImageSection(0, 0, 360, 8, -180 - degRot, 0, 360, 8, sightlangStaticImage[41], 0, 0, 0, tocolor(255, 255, 255))
        sightlangStaticImageUsed[42] = true
        if sightlangStaticImageToc[42] then
          processsightlangStaticImage[42]()
        end
        dxDrawImageSection(0, 8, 360, 8, -180 - degRot, 0, 360, 8, sightlangStaticImage[42], 0, 0, 0, tocolor(255, 255, 255))
        dxDrawRectangle(0, 24, 360, 8, tocolor(220, 175, 16, 100))
        sightlangStaticImageUsed[42] = true
        if sightlangStaticImageToc[42] then
          processsightlangStaticImage[42]()
        end
        sightlangStaticImageUsed[42] = true
        if sightlangStaticImageToc[42] then
          processsightlangStaticImage[42]()
        end
        dxDrawImageSection(0, 24, 360, 8, -180 - degRot, 0, 360, 8, sightlangStaticImage[42], 0, 0, 0, tocolor(220, 175, 16))
        if tbl.newRound or tbl.ended and 1000 < now - tbl.ended then
          local a = 130 + 125 * pulse
          if tbl.newRound then
            a = a - a * math.min(1, (now - tbl.newRound) / 1000)
          end
          for i = 1, 8 do
            local c = tocolor(0, 0, 0, a)
            if tbl.win[i] then
              c = tocolor(0, 166, 62, a)
            elseif tbl.betted[i] then
              c = tocolor(205, 50, 38, a)
            end
            dxDrawRectangle((i - 1) * 45, 16, 45, 8, c)
          end
        end
        if tbl.countdownTime and tbl.countdownTime <= 10 then
          local delta = now - tbl.countdown
          local a = 1 - delta % 1000 / 1000
          if delta < countdownTime * 1000 then
            dxDrawRectangle(0, 0, 360, 32, tocolor(245, 95, 95, 255 * a))
          end
        end
      end
      dxSetRenderTarget(tbl.bigRt)
      dxDrawRectangle(0, 0, 342, 256, tocolor(26, 70, 30))
      local bx = 171 + s * rad * math.cos(rot) * zoom - xp * 34
      local by = 128 + s * rad * math.sin(rot) * zoom
      local sx = s * 342 / 256
      sightlangStaticImageUsed[43] = true
      if sightlangStaticImageToc[43] then
        processsightlangStaticImage[43]()
      end
      dxDrawImage(bx - sx / 2, by - s / 2, sx, s, sightlangStaticImage[43])
      drawReel(bx, by, s, wr, rot, rad, pos, tbl.d > 20)
      if 0 < xp then
        local x = 342 - xp * 68
        dxDrawRectangle(x, 0, 68, 256, tocolor(0, 0, 0, 75))
        local h = 26.5
        local w = h - 6
        local y = 36 + h / 2
        local c = 0
        for i = #tbl.history, 1, -1 do
          if tbl.history[i] then
            local x = x + 34
            if tbl.history[i][2] == 1 then
              x = x - 12
              sightlangStaticImageUsed[31] = true
              if sightlangStaticImageToc[31] then
                processsightlangStaticImage[31]()
              end
              dxDrawImage(x - w / 2, y - w / 2, w, w, sightlangStaticImage[31])
            elseif tbl.history[i][2] == 2 then
              x = x + 12
              sightlangStaticImageUsed[32] = true
              if sightlangStaticImageToc[32] then
                processsightlangStaticImage[32]()
              end
              dxDrawImage(x - w / 2, y - w / 2, w, w, sightlangStaticImage[32])
            else
              sightlangStaticImageUsed[33] = true
              if sightlangStaticImageToc[33] then
                processsightlangStaticImage[33]()
              end
              dxDrawImage(x - w / 2, y - w / 2, w, w, sightlangStaticImage[33])
            end
            if tbl.d < 25 then
              dxDrawText(tbl.history[i][1], x, y, x, y, tocolor(255, 255, 255), numberFontScale, numberFont, "center", "center")
            end
            y = y + h
            c = c + 1
            if 8 <= c then
              break
            end
          end
        end
      end
      sightlangStaticImageUsed[44] = true
      if sightlangStaticImageToc[44] then
        processsightlangStaticImage[44]()
      end
      dxDrawImage(278, 4, 62, 24, sightlangStaticImage[44], 0, 0, 0, tocolor(255, 255, 255, 255 * (0.5 + 0.5 * xp)))
      if tbl.countdownTime and 0 < xp then
        if tbl.countdownTime > 0 then
          sightlangStaticImageUsed[45] = true
          if sightlangStaticImageToc[45] then
            processsightlangStaticImage[45]()
          end
          dxDrawImage(0, 30, 342, 45, sightlangStaticImage[45], 0, 0, 0, tocolor(255, 255, 255, 160))
          dxDrawText(tbl.countdownTime .. "s", 8, 30, 0, 75, tocolor(245, 95, 95), cdFontScale * 1.25, cdFont, "left", "center")
        else
          sightlangStaticImageUsed[46] = true
          if sightlangStaticImageToc[46] then
            processsightlangStaticImage[46]()
          end
          sightlangStaticImageUsed[45] = true
          if sightlangStaticImageToc[45] then
            processsightlangStaticImage[45]()
          end
          dxDrawImage(0, 30, 342, 45, sightlangStaticImage[45], 0, 0, 0, tocolor(255, 255, 255, 160 * xp))
          dxDrawText("Köszönöm, nincs több tét!", 8, 30, 0, 75, tocolor(255, 255, 255, 255 * xp), cdFontScale * 0.65, cdFont, "left", "center")
        end
        if tbl.countdown and tbl.countdownTime <= 10 then
          local delta = now - tbl.countdown
          local a = 1 - delta % 1000 / 1000
          if delta < countdownTime * 1000 then
            sightlangStaticImageUsed[36] = true
            if sightlangStaticImageToc[36] then
              processsightlangStaticImage[36]()
            end
            dxDrawImageSection(0, 0, 342, 256, 0, -378 - 756 * delta / 1000, 1012, 756, sightlangStaticImage[36], 0, 0, 0, tocolor(245, 95, 95, 125 * a))
          end
        end
      end
      dxSetRenderTarget(tbl.smallRt)
      sightlangStaticImageUsed[47] = true
      if sightlangStaticImageToc[47] then
        processsightlangStaticImage[47]()
      end
      dxDrawImage(0, 0, 170, 129, sightlangStaticImage[47])
      if tbl.d < 25 then
        if tbl.bounceStart then
          sightlangStaticImageUsed[26] = true
          if sightlangStaticImageToc[26] then
            processsightlangStaticImage[26]()
          end
          dxDrawImageSection(109.57, 12.093, 60.429, 7.39, -208 + (tbl.ballRotBounce - tbl.ballWrs) / math.pi * 814, 0, 364, 44, sightlangStaticImage[26])
        elseif tbl.spinUp or tbl.slowDown then
          sightlangStaticImageUsed[26] = true
          if sightlangStaticImageToc[26] then
            processsightlangStaticImage[26]()
          end
          dxDrawImageSection(109.57, 12.093, 60.429, 7.39, -208 + (tbl.ballRot - tbl.ballWrs) / math.pi * 814, 0, 364, 44, sightlangStaticImage[26])
        else
          sightlangStaticImageUsed[26] = true
          if sightlangStaticImageToc[26] then
            processsightlangStaticImage[26]()
          end
          dxDrawImageSection(109.57, 12.093, 60.429, 7.39, -208 + tbl.lastPos * 44, 0, 364, 44, sightlangStaticImage[26])
        end
        if tbl.countdownTime and tbl.countdownTime <= 10 and tbl.countdown then
          local delta = now - tbl.countdown
          local a = 1 - delta % 1000 / 1000
          if delta < countdownTime * 1000 then
            sightlangStaticImageUsed[36] = true
            if sightlangStaticImageToc[36] then
              processsightlangStaticImage[36]()
            end
            dxDrawImageSection(1.162, 1.162, 167.676, 126.676, 0, -378 - 756 * delta / 1000, 1012, 756, sightlangStaticImage[36], 0, 0, 0, tocolor(245, 95, 95, 125 * a))
          end
        end
        if eDelta and 0 < eDelta + 2500 then
          dxDrawText("Játék vége, eredményhirdetés", 2.5, 11.421, 0, 20.156, tocolor(255, 255, 255), cdFontScale * 0.1328, cdFont, "left", "center")
        elseif tbl.spinUp or tbl.slowDown or tbl.bounceStart or tbl.ended then
          dxDrawText("Sok szerencsét!", 2.5, 11.421, 0, 20.156, tocolor(255, 255, 255), cdFontScale * 0.1328, cdFont, "left", "center")
        else
          local w = 0
          if tbl.countdownTime and tbl.countdownTime > 0 then
            w = 9.296
            dxDrawText(tbl.countdownTime .. "s", 2.5, 11.421, 0, 20.156, tocolor(245, 95, 95), cdFontScale * 0.2075, cdFont, "left", "center")
          end
          if not tbl.countdownTime or tbl.countdownTime > 0 then
            dxDrawText("Kérem tegyék meg tétjeiket!", 2.5 + w, 11.421, 0, 20.156, tocolor(255, 255, 255), cdFontScale * 0.1328, cdFont, "left", "center")
          else
            dxDrawText("Köszönöm, nincs több tét!", 2.5 + w, 11.421, 0, 20.156, tocolor(255, 255, 255), cdFontScale * 0.1328, cdFont, "left", "center")
          end
        end
      end
      dxDrawImage(3.486, 55.429, 53.125, 40.3125, tbl.bigRt)
      sightlangStaticImageUsed[48] = true
      if sightlangStaticImageToc[48] then
        processsightlangStaticImage[48]()
      end
      dxDrawImage(0, 0, 170, 129, sightlangStaticImage[48])
      dxSetBlendMode("blend")
      dxSetRenderTarget()
    end
  end
end
local coinButtons = {}
addEvent("changeRouletteCoin", false)
addEventHandler("changeRouletteCoin", getRootElement(), function(button, state, absX, absY, el)
  if coinButtons[el] and currentCoin ~= coinButtons[el] then
    currentCoin = coinButtons[el]
    playSound("files/sound/sscswitch" .. math.random(1, 3) .. ".mp3")
  end
end)
function deleteWindow()
  if hover then
    hover = false
    sightexports.sGui:setCursorType("normal")
    sightexports.sGui:showTooltip()
  end
  if smallWindow then
    smallX, smallY = sightexports.sGui:getGuiPosition(smallWindow)
    sightexports.sGui:deleteGuiElement(smallWindow)
  end
  smallWindow = false
  if bigWindow then
    sightexports.sGui:deleteGuiElement(bigWindow)
  end
  bigWindow = false
  bigPreview = false
  coinButtons = {}
end
addEvent("toggleRouletteWindow", false)
addEventHandler("toggleRouletteWindow", getRootElement(), function(el, state)
  if bigWindow then
    createWindow(false)
  else
    createWindow(true)
  end
end)
addEvent("rouletteBigPreview", false)
addEventHandler("rouletteBigPreview", getRootElement(), function(el, state)
  bigPreview = state
end)
function createWindow(big)
  deleteWindow()
  titleBarHeight = sightexports.sGui:getTitleBarHeight()
  local pw, ph
  if big then
    pw, ph = 1024, 768 + titleBarHeight
    if not bigX then
      bigX, bigY = screenX / 2 - pw / 2, screenY / 2 - ph / 2
    end
  else
    pw, ph = 324, 244 + titleBarHeight
    if not smallX then
      smallX, smallY = screenX / 2 - pw / 2, math.floor(screenY * 0.75) - ph / 2
    end
  end
  local x = big and bigX or smallX
  local y = big and bigY or smallY
  local window = sightexports.sGui:createGuiElement("window", x, y, pw, big and titleBarHeight or ph)
  sightexports.sGui:setWindowTitle(window, "16/BebasNeueRegular.otf", "Roulette")
  if big then
    sightexports.sGui:setWindowCloseButton(window, "tryToExitRoulette")
    sightexports.sGui:setWindowMoveEvent(window, "moveRouletteWindow")
    local image = sightexports.sGui:createGuiElement("image", pw - titleBarHeight * 2, 0, titleBarHeight, titleBarHeight, window)
    sightexports.sGui:setImageFile(image, sightexports.sGui:getFaIconFilename("compress-alt", titleBarHeight))
    sightexports.sGui:setGuiHoverable(image, true)
    sightexports.sGui:setGuiHover(image, "solid", "sightgreen")
    sightexports.sGui:setClickEvent(image, "toggleRouletteWindow")
    bigWindow = window
    local x = 512 - 64 * #coinValues / 2
    local y = titleBarHeight + 632
    for i = 1, #coinValues do
      local btn = sightexports.sGui:createGuiElement("rectangle", x + 6, y + 6, 52, 52, window)
      sightexports.sGui:setGuiHover(btn, "none", false, false, true)
      sightexports.sGui:setGuiHoverable(btn, true)
      sightexports.sGui:setClickEvent(btn, "changeRouletteCoin")
      coinButtons[btn] = i
      x = x + 64
    end
  else
    local image = sightexports.sGui:createGuiElement("image", pw - titleBarHeight, 0, titleBarHeight, titleBarHeight, window)
    sightexports.sGui:setImageFile(image, sightexports.sGui:getFaIconFilename("expand-alt", titleBarHeight))
    sightexports.sGui:setGuiHoverable(image, true)
    sightexports.sGui:setGuiHover(image, "solid", "sightgreen")
    sightexports.sGui:setClickEvent(image, "toggleRouletteWindow")
    local image = sightexports.sGui:createGuiElement("image", pw - titleBarHeight * 2, 0, titleBarHeight, titleBarHeight, window)
    sightexports.sGui:setImageFile(image, sightexports.sGui:getFaIconFilename("eye", titleBarHeight, "regular"))
    sightexports.sGui:setGuiHoverable(image, true)
    sightexports.sGui:setGuiHover(image, "solid", "sightgreen")
    sightexports.sGui:setHoverEvent(image, "rouletteBigPreview")
    smallWindow = window
    local tbl = rouletteTables[myTable]
    local image = sightexports.sGui:createGuiElement("image", 2, titleBarHeight + 2, 320, 240, window)
    sightexports.sGui:setImageFile(image, tbl.bigRt)
    local image = sightexports.sGui:createGuiElement("image", 0, titleBarHeight, 324, 244, window)
    sightexports.sGui:setImageDDS(image, ":sRoulette/files/live.dds")
  end
end
addEvent("moveRouletteWindow", false)
addEventHandler("moveRouletteWindow", getRootElement(), function(el, x, y)
  bigX, bigY = x, y
end)
function processBetCoinEx(val)
  if val then
    for i = #coinValues, 1, -1 do
      if val >= coinValues[i] then
        return i
      end
    end
  else
    return 1
  end
end
function processBetCoin(tbl, seat, bet, val)
  if val then
    for i = #coinValues, 1, -1 do
      if val >= coinValues[i] then
        tbl.betCoins[seat][bet] = i
        break
      end
    end
  else
    tbl.betCoins[seat][bet] = nil
  end
end
addEvent("rouletteNewRound", true)
addEventHandler("rouletteNewRound", getRootElement(), function(id)
  local tbl = rouletteTables[id]
  tbl.ended = false
  tbl.newRound = getTickCount()
end)
addEvent("gotNewRouletteBet", true)
addEventHandler("gotNewRouletteBet", getRootElement(), function(id, seat, bet, amount, disableSound)
  local tbl = rouletteTables[id]
  if id == myTable and seat == mySeat then
    myBet = myBet - (tbl.bets[seat][bet] or 0)
    myBetPlus[bet] = (amount or 0) > (tbl.bets[seat][bet] or 0)
  end
  if not disableSound then
    if amount then
      if amount > (tbl.bets[seat][bet] or 0) then
        playSeatSound("ssc1", tbl, seat)
      else
        playSeatSound("ssc2", tbl, seat)
      end
    else
      playSeatSound("ssc2", tbl, seat)
    end
  end
  tbl.bets[seat][bet] = amount
  if id == myTable and seat == mySeat then
    myBet = myBet + (tbl.bets[seat][bet] or 0)
    myBetFormatted = sightexports.sGui:thousandsStepper(myBet)
  end
  processBetCoin(tbl, seat, bet, amount)
  local now = getTickCount()
  if id == myTable and seat == mySeat then
    myLastBets[bet] = amount and now or nil
    if bet == hover then
      sightexports.sGui:showTooltip(formatBetTooltip(tbl, hover))
    end
  end
  if not tbl.countdown then
    tbl.countdown = now
    tbl.countdownTime = false
  end
end)
local lastBetTry = {}
function rouletteClick(btn, state)
  if state == "down" then
    local tbl = rouletteTables[myTable]
    if tbl.canBet and (not tbl.countdownTime or tbl.countdownTime > 0) then
      local now = getTickCount()
      if now - (lastBetTry[hover] or 0) <= 250 then
        return
      end
      local amount = (btn == "right" and -1 or 1) * coinValues[currentCoin]
      if hover == "tier" then
        for i = 1, #tierBets do
          if myLastBets[tierBets[i]] then
            return
          end
        end
        if 0 < amount and (balanceNew or balance) < coinValues[currentCoin] * 6 then
          sightexports.sGui:showInfobox("e", "Nincs elegendő SSC egyenleged!")
          return
        end
        triggerServerEvent("tryToAddRouletteBet", localPlayer, "tier", amount)
        lastBetTry.tier = now + 500
      elseif hover == "orphelins" then
        for i = 1, #orphelinsBets do
          if myLastBets[orphelinsBets[i]] then
            return
          end
        end
        if 0 < amount and (balanceNew or balance) < coinValues[currentCoin] * 5 then
          sightexports.sGui:showInfobox("e", "Nincs elegendő SSC egyenleged!")
          return
        end
        triggerServerEvent("tryToAddRouletteBet", localPlayer, "orphelins", amount)
        lastBetTry.orphelins = now + 500
      elseif hover == "voisins" then
        for i = 1, #voisinsBets do
          if myLastBets[voisinsBets[i]] then
            return
          end
        end
        if 0 < amount and (balanceNew or balance) < coinValues[currentCoin] * 9 then
          sightexports.sGui:showInfobox("e", "Nincs elegendő SSC egyenleged!")
          return
        end
        triggerServerEvent("tryToAddRouletteBet", localPlayer, "voisins", amount)
        lastBetTry.voisins = now + 500
      elseif hover == "zero" then
        for i = 1, #zeroBets do
          if myLastBets[zeroBets[i]] then
            return
          end
        end
        if 0 < amount and (balanceNew or balance) < coinValues[currentCoin] * 4 then
          sightexports.sGui:showInfobox("e", "Nincs elegendő SSC egyenleged!")
          return
        end
        triggerServerEvent("tryToAddRouletteBet", localPlayer, "zero", amount)
        lastBetTry.zero = now + 500
      elseif validBets[hover] then
        if type(validBets[hover]) == "table" and validBets[hover][1] == "n" then
          local num = validBets[hover][2]
          local j = rouletteWheelNumsReverse[num] - 1
          if myLastBets[num] then
            return
          end
          if 0 < amount and (balanceNew or balance) < coinValues[currentCoin] * 3 then
            sightexports.sGui:showInfobox("e", "Nincs elegendő SSC egyenleged!")
            return
          end
          for k = -1, 1, 2 do
            local num = rouletteWheelNums[(j + k) % 37 + 1]
            if myLastBets[num] then
              return
            end
          end
          triggerServerEvent("tryToAddRouletteBet", localPlayer, hover, amount)
          lastBetTry[hover] = now + 500
        else
          if myLastBets[hover] then
            return
          end
          if 0 < amount and (balanceNew or balance) < coinValues[currentCoin] then
            sightexports.sGui:showInfobox("e", "Nincs elegendő SSC egyenleged!")
            return
          end
          triggerServerEvent("tryToAddRouletteBet", localPlayer, hover, amount)
          lastBetTry[hover] = now
        end
      end
    end
  end
end
local tblHover = false
local seatHover = false
function renderSeatIcons()
  local cx, cy = getCursorPosition()
  if cx then
    cx = cx * screenX
    cy = cy * screenY
  end
  local tmpTbl = false
  local tmpSeat = false
  local px, py, pz = getElementPosition(localPlayer)
  for l = 1, #streamedIn do
    local k = streamedIn[l]
    local tbl = rouletteTables[k]
    if tbl.onScreen then
      for i = 1, 8 do
        if not tbl.players[i] then
          local x, y, z = tbl.seats[i][1], tbl.seats[i][2], tbl.seats[i][3]
          local d = getDistanceBetweenPoints3D(px, py, pz, x, y, z)
          if d < 5 then
            local x, y = getScreenFromWorldPosition(x, y, z, 32)
            if x then
              local a = 255 - d / 5 * 255
              if d < 1.5 and cx and cx >= x - 16 and cx <= x + 16 and cy >= y - 16 and cy <= y + 16 then
                tmpTbl = k
                tmpSeat = i
                dxDrawRectangle(x - 16, y - 16, 32, 32, tocolor(sitBgColor[1], sitBgColor[2], sitBgColor[3]))
                dxDrawImage(x - 12, y - 12, 24, 24, ":sGui/" .. sitIcon .. faTicks[sitIcon], 0, 0, 0, sitColor)
              else
                dxDrawRectangle(x - 16, y - 16, 32, 32, tocolor(sitBgColor[1], sitBgColor[2], sitBgColor[3], a))
                dxDrawImage(x - 12, y - 12, 24, 24, ":sGui/" .. sitIcon .. faTicks[sitIcon], 0, 0, 0, tocolor(255, 255, 255, a))
              end
            end
          end
        end
      end
    end
  end
  if tblHover ~= tmpTbl or seatHover ~= tmpSeat then
    tblHover = tmpTbl
    seatHover = tmpSeat
    sightexports.sGui:setCursorType(tblHover and "link" or "normal")
    sightexports.sGui:showTooltip(tblHover and "Leülés")
  end
end
function clickSeatIcons(btn, state)
  if state == "up" and tblHover and not myTable then
    triggerServerEvent("tryToSitDownRoulette", localPlayer, tblHover, seatHover)
  end
end
addEvent("tryToExitRoulette", false)
addEventHandler("tryToExitRoulette", getRootElement(), function()
  local tbl = rouletteTables[myTable]
  for bet in pairs(tbl.bets[mySeat]) do
    sightexports.sGui:showInfobox("e", "Amíg érvényes téted van az asztalon, nem állhatsz fel!")
    return
  end
  triggerServerEvent("tryToExitRoulette", localPlayer)
end)
addEvent("gotRoulettePlayer", true)
addEventHandler("gotRoulettePlayer", getRootElement(), function(id, seat, client)
  local tbl = rouletteTables[id]
  if client then
    if client == localPlayer then
      if not myTable then
        removeEventHandler("onClientRender", getRootElement(), renderSeatIcons)
        removeEventHandler("onClientClick", getRootElement(), clickSeatIcons)
        addEventHandler("onClientClick", getRootElement(), rouletteClick)
      end
      myTable = id
      mySeat = seat
      createWindow(true)
    end
    tbl.players[seat] = client
    playSeatSound("sit", tbl, seat)
    if isElement(tbl.obj) then
      attachElements(tbl.players[seat], tbl.obj, seatOffsets[seat][1], seatOffsets[seat][2], seatOffsets[seat][3])
    end
    setPedAnimation(client, "int_office", "off_sit_idle_loop", -1, true, false, false, false)
  else
    if id == myTable and seat == mySeat then
      if myTable then
        addEventHandler("onClientRender", getRootElement(), renderSeatIcons)
        addEventHandler("onClientClick", getRootElement(), clickSeatIcons)
        removeEventHandler("onClientClick", getRootElement(), rouletteClick)
      end
      myTable = false
      mySeat = false
      deleteWindow()
    end
    playSeatSound("stand", tbl, seat)
    if isElement(tbl.players[seat]) then
      detachElements(tbl.players[seat], tbl.obj)
      setPedAnimation(tbl.players[seat])
    end
    tbl.bets[seat] = {}
    tbl.betCoins[seat] = {}
    tbl.players[seat] = nil
  end
end)
function renderRoulette()
  local now = getTickCount()
  if myTable then
    if bigWindow then
      drawTable(bigX, bigY + titleBarHeight)
    elseif bigPreview then
      drawTable(screenX / 2 - 512, screenY / 2 - 384)
    end
  end
  for l = 1, #streamedIn do
    local i = streamedIn[l]
    local tbl = rouletteTables[i]
    if tbl.onScreen and tbl.d < 25 then
      for j = 1, 8 do
        for bet, value in pairs(tbl.bets[j]) do
          local el = tbl.screenBets[j][bet]
          dxDrawMaterialLine3D(el[1], el[2], el[3], el[4], el[5], el[6], latentDynamicImage("files/coin/s" .. tbl.betCoins[j][bet] .. ".dds"), coinS * 2, tocolor(255, 255, 255), el[7], el[8], el[9])
        end
        if (tbl.newRound or tbl.ended and now > tbl.ended + 1000) and tbl.win[j] then
          local el = tbl.winCoord[j]
          sightlangStaticImageUsed[49] = true
          if sightlangStaticImageToc[49] then
            processsightlangStaticImage[49]()
          end
          dxDrawMaterialLine3D(el[1], el[2], el[3], el[4], el[5], el[6], sightlangStaticImage[49], 0.583744, tocolor(255, 255, 255), el[7], el[8], el[9])
        end
      end
    end
  end
end