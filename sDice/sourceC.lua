local sightexports = {sGui = false, sModloader = false}
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
sightlangStaticImageToc[50] = true
sightlangStaticImageToc[51] = true
sightlangStaticImageToc[52] = true
sightlangStaticImageToc[53] = true
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
  if sightlangStaticImageUsed[50] then
    sightlangStaticImageUsed[50] = false
    sightlangStaticImageDel[50] = false
  elseif sightlangStaticImage[50] then
    if sightlangStaticImageDel[50] then
      if now >= sightlangStaticImageDel[50] then
        if isElement(sightlangStaticImage[50]) then
          destroyElement(sightlangStaticImage[50])
        end
        sightlangStaticImage[50] = nil
        sightlangStaticImageDel[50] = false
        sightlangStaticImageToc[50] = true
        return
      end
    else
      sightlangStaticImageDel[50] = now + 5000
    end
  else
    sightlangStaticImageToc[50] = true
  end
  if sightlangStaticImageUsed[51] then
    sightlangStaticImageUsed[51] = false
    sightlangStaticImageDel[51] = false
  elseif sightlangStaticImage[51] then
    if sightlangStaticImageDel[51] then
      if now >= sightlangStaticImageDel[51] then
        if isElement(sightlangStaticImage[51]) then
          destroyElement(sightlangStaticImage[51])
        end
        sightlangStaticImage[51] = nil
        sightlangStaticImageDel[51] = false
        sightlangStaticImageToc[51] = true
        return
      end
    else
      sightlangStaticImageDel[51] = now + 5000
    end
  else
    sightlangStaticImageToc[51] = true
  end
  if sightlangStaticImageUsed[52] then
    sightlangStaticImageUsed[52] = false
    sightlangStaticImageDel[52] = false
  elseif sightlangStaticImage[52] then
    if sightlangStaticImageDel[52] then
      if now >= sightlangStaticImageDel[52] then
        if isElement(sightlangStaticImage[52]) then
          destroyElement(sightlangStaticImage[52])
        end
        sightlangStaticImage[52] = nil
        sightlangStaticImageDel[52] = false
        sightlangStaticImageToc[52] = true
        return
      end
    else
      sightlangStaticImageDel[52] = now + 5000
    end
  else
    sightlangStaticImageToc[52] = true
  end
  if sightlangStaticImageUsed[53] then
    sightlangStaticImageUsed[53] = false
    sightlangStaticImageDel[53] = false
  elseif sightlangStaticImage[53] then
    if sightlangStaticImageDel[53] then
      if now >= sightlangStaticImageDel[53] then
        if isElement(sightlangStaticImage[53]) then
          destroyElement(sightlangStaticImage[53])
        end
        sightlangStaticImage[53] = nil
        sightlangStaticImageDel[53] = false
        sightlangStaticImageToc[53] = true
        return
      end
    else
      sightlangStaticImageDel[53] = now + 5000
    end
  else
    sightlangStaticImageToc[53] = true
  end
  if sightlangStaticImageToc[0] and sightlangStaticImageToc[1] and sightlangStaticImageToc[2] and sightlangStaticImageToc[3] and sightlangStaticImageToc[4] and sightlangStaticImageToc[5] and sightlangStaticImageToc[6] and sightlangStaticImageToc[7] and sightlangStaticImageToc[8] and sightlangStaticImageToc[9] and sightlangStaticImageToc[10] and sightlangStaticImageToc[11] and sightlangStaticImageToc[12] and sightlangStaticImageToc[13] and sightlangStaticImageToc[14] and sightlangStaticImageToc[15] and sightlangStaticImageToc[16] and sightlangStaticImageToc[17] and sightlangStaticImageToc[18] and sightlangStaticImageToc[19] and sightlangStaticImageToc[20] and sightlangStaticImageToc[21] and sightlangStaticImageToc[22] and sightlangStaticImageToc[23] and sightlangStaticImageToc[24] and sightlangStaticImageToc[25] and sightlangStaticImageToc[26] and sightlangStaticImageToc[27] and sightlangStaticImageToc[28] and sightlangStaticImageToc[29] and sightlangStaticImageToc[30] and sightlangStaticImageToc[31] and sightlangStaticImageToc[32] and sightlangStaticImageToc[33] and sightlangStaticImageToc[34] and sightlangStaticImageToc[35] and sightlangStaticImageToc[36] and sightlangStaticImageToc[37] and sightlangStaticImageToc[38] and sightlangStaticImageToc[39] and sightlangStaticImageToc[40] and sightlangStaticImageToc[41] and sightlangStaticImageToc[42] and sightlangStaticImageToc[43] and sightlangStaticImageToc[44] and sightlangStaticImageToc[45] and sightlangStaticImageToc[46] and sightlangStaticImageToc[47] and sightlangStaticImageToc[48] and sightlangStaticImageToc[49] and sightlangStaticImageToc[50] and sightlangStaticImageToc[51] and sightlangStaticImageToc[52] and sightlangStaticImageToc[53] then
    sightlangStatImgHand = false
    removeEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre)
  end
end
processsightlangStaticImage[0] = function()
  if not isElement(sightlangStaticImage[0]) then
    sightlangStaticImageToc[0] = false
    sightlangStaticImage[0] = dxCreateTexture("files/btn3d.dds", "dxt1", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[1] = function()
  if not isElement(sightlangStaticImage[1]) then
    sightlangStaticImageToc[1] = false
    sightlangStaticImage[1] = dxCreateTexture("files/7seg.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[2] = function()
  if not isElement(sightlangStaticImage[2]) then
    sightlangStaticImageToc[2] = false
    sightlangStaticImage[2] = dxCreateTexture("files/bigdice.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[3] = function()
  if not isElement(sightlangStaticImage[3]) then
    sightlangStaticImageToc[3] = false
    sightlangStaticImage[3] = dxCreateTexture("files/darrow3d.dds", "dxt3", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[4] = function()
  if not isElement(sightlangStaticImage[4]) then
    sightlangStaticImageToc[4] = false
    sightlangStaticImage[4] = dxCreateTexture("files/d3d.dds", "dxt3", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[5] = function()
  if not isElement(sightlangStaticImage[5]) then
    sightlangStaticImageToc[5] = false
    sightlangStaticImage[5] = dxCreateTexture("files/symbols2.dds", "dxt1", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[6] = function()
  if not isElement(sightlangStaticImage[6]) then
    sightlangStaticImageToc[6] = false
    sightlangStaticImage[6] = dxCreateTexture("files/symbols3.dds", "dxt1", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[7] = function()
  if not isElement(sightlangStaticImage[7]) then
    sightlangStaticImageToc[7] = false
    sightlangStaticImage[7] = dxCreateTexture("files/stencil.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[8] = function()
  if not isElement(sightlangStaticImage[8]) then
    sightlangStaticImageToc[8] = false
    sightlangStaticImage[8] = dxCreateTexture("files/lines3d.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[9] = function()
  if not isElement(sightlangStaticImage[9]) then
    sightlangStaticImageToc[9] = false
    sightlangStaticImage[9] = dxCreateTexture("files/clock3d.dds", "dxt3", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[10] = function()
  if not isElement(sightlangStaticImage[10]) then
    sightlangStaticImageToc[10] = false
    sightlangStaticImage[10] = dxCreateTexture("files/staketop3d.dds", "dxt3", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[11] = function()
  if not isElement(sightlangStaticImage[11]) then
    sightlangStaticImageToc[11] = false
    sightlangStaticImage[11] = dxCreateTexture("files/stake3d.dds", "dxt3", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[12] = function()
  if not isElement(sightlangStaticImage[12]) then
    sightlangStaticImageToc[12] = false
    sightlangStaticImage[12] = dxCreateTexture("files/risk3d.dds", "dxt3", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[13] = function()
  if not isElement(sightlangStaticImage[13]) then
    sightlangStaticImageToc[13] = false
    sightlangStaticImage[13] = dxCreateTexture("files/symbols.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[14] = function()
  if not isElement(sightlangStaticImage[14]) then
    sightlangStaticImageToc[14] = false
    sightlangStaticImage[14] = dxCreateTexture("files/syml.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[15] = function()
  if not isElement(sightlangStaticImage[15]) then
    sightlangStaticImageToc[15] = false
    sightlangStaticImage[15] = dxCreateTexture("files/bg.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[16] = function()
  if not isElement(sightlangStaticImage[16]) then
    sightlangStaticImageToc[16] = false
    sightlangStaticImage[16] = dxCreateTexture("files/stake1.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[17] = function()
  if not isElement(sightlangStaticImage[17]) then
    sightlangStaticImageToc[17] = false
    sightlangStaticImage[17] = dxCreateTexture("files/stake2.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[18] = function()
  if not isElement(sightlangStaticImage[18]) then
    sightlangStaticImageToc[18] = false
    sightlangStaticImage[18] = dxCreateTexture("files/stake3.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[19] = function()
  if not isElement(sightlangStaticImage[19]) then
    sightlangStaticImageToc[19] = false
    sightlangStaticImage[19] = dxCreateTexture("files/stake4.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[20] = function()
  if not isElement(sightlangStaticImage[20]) then
    sightlangStaticImageToc[20] = false
    sightlangStaticImage[20] = dxCreateTexture("files/l1.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[21] = function()
  if not isElement(sightlangStaticImage[21]) then
    sightlangStaticImageToc[21] = false
    sightlangStaticImage[21] = dxCreateTexture("files/l2.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[22] = function()
  if not isElement(sightlangStaticImage[22]) then
    sightlangStaticImageToc[22] = false
    sightlangStaticImage[22] = dxCreateTexture("files/l3.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[23] = function()
  if not isElement(sightlangStaticImage[23]) then
    sightlangStaticImageToc[23] = false
    sightlangStaticImage[23] = dxCreateTexture("files/l4.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[24] = function()
  if not isElement(sightlangStaticImage[24]) then
    sightlangStaticImageToc[24] = false
    sightlangStaticImage[24] = dxCreateTexture("files/l5.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[25] = function()
  if not isElement(sightlangStaticImage[25]) then
    sightlangStaticImageToc[25] = false
    sightlangStaticImage[25] = dxCreateTexture("files/clock.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[26] = function()
  if not isElement(sightlangStaticImage[26]) then
    sightlangStaticImageToc[26] = false
    sightlangStaticImage[26] = dxCreateTexture("files/clock1.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[27] = function()
  if not isElement(sightlangStaticImage[27]) then
    sightlangStaticImageToc[27] = false
    sightlangStaticImage[27] = dxCreateTexture("files/clock2.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[28] = function()
  if not isElement(sightlangStaticImage[28]) then
    sightlangStaticImageToc[28] = false
    sightlangStaticImage[28] = dxCreateTexture("files/clock3.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[29] = function()
  if not isElement(sightlangStaticImage[29]) then
    sightlangStaticImageToc[29] = false
    sightlangStaticImage[29] = dxCreateTexture("files/d1.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[30] = function()
  if not isElement(sightlangStaticImage[30]) then
    sightlangStaticImageToc[30] = false
    sightlangStaticImage[30] = dxCreateTexture("files/d2.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[31] = function()
  if not isElement(sightlangStaticImage[31]) then
    sightlangStaticImageToc[31] = false
    sightlangStaticImage[31] = dxCreateTexture("files/d3.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[32] = function()
  if not isElement(sightlangStaticImage[32]) then
    sightlangStaticImageToc[32] = false
    sightlangStaticImage[32] = dxCreateTexture("files/d4.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[33] = function()
  if not isElement(sightlangStaticImage[33]) then
    sightlangStaticImageToc[33] = false
    sightlangStaticImage[33] = dxCreateTexture("files/d5.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[34] = function()
  if not isElement(sightlangStaticImage[34]) then
    sightlangStaticImageToc[34] = false
    sightlangStaticImage[34] = dxCreateTexture("files/d6.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[35] = function()
  if not isElement(sightlangStaticImage[35]) then
    sightlangStaticImageToc[35] = false
    sightlangStaticImage[35] = dxCreateTexture("files/darrow.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[36] = function()
  if not isElement(sightlangStaticImage[36]) then
    sightlangStaticImageToc[36] = false
    sightlangStaticImage[36] = dxCreateTexture("files/risk.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[37] = function()
  if not isElement(sightlangStaticImage[37]) then
    sightlangStaticImageToc[37] = false
    sightlangStaticImage[37] = dxCreateTexture("files/risk1.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[38] = function()
  if not isElement(sightlangStaticImage[38]) then
    sightlangStaticImageToc[38] = false
    sightlangStaticImage[38] = dxCreateTexture("files/risk2.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[39] = function()
  if not isElement(sightlangStaticImage[39]) then
    sightlangStaticImageToc[39] = false
    sightlangStaticImage[39] = dxCreateTexture("files/btn2.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[40] = function()
  if not isElement(sightlangStaticImage[40]) then
    sightlangStaticImageToc[40] = false
    sightlangStaticImage[40] = dxCreateTexture("files/btn3.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[41] = function()
  if not isElement(sightlangStaticImage[41]) then
    sightlangStaticImageToc[41] = false
    sightlangStaticImage[41] = dxCreateTexture("files/btn4.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[42] = function()
  if not isElement(sightlangStaticImage[42]) then
    sightlangStaticImageToc[42] = false
    sightlangStaticImage[42] = dxCreateTexture("files/btn1.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[43] = function()
  if not isElement(sightlangStaticImage[43]) then
    sightlangStaticImageToc[43] = false
    sightlangStaticImage[43] = dxCreateTexture("files/btn5.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[44] = function()
  if not isElement(sightlangStaticImage[44]) then
    sightlangStaticImageToc[44] = false
    sightlangStaticImage[44] = dxCreateTexture("files/btn6.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[45] = function()
  if not isElement(sightlangStaticImage[45]) then
    sightlangStaticImageToc[45] = false
    sightlangStaticImage[45] = dxCreateTexture("files/btntop.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[46] = function()
  if not isElement(sightlangStaticImage[46]) then
    sightlangStaticImageToc[46] = false
    sightlangStaticImage[46] = dxCreateTexture("files/glass.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[47] = function()
  if not isElement(sightlangStaticImage[47]) then
    sightlangStaticImageToc[47] = false
    sightlangStaticImage[47] = dxCreateTexture("files/payout2.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[48] = function()
  if not isElement(sightlangStaticImage[48]) then
    sightlangStaticImageToc[48] = false
    sightlangStaticImage[48] = dxCreateTexture("files/payout1.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[49] = function()
  if not isElement(sightlangStaticImage[49]) then
    sightlangStaticImageToc[49] = false
    sightlangStaticImage[49] = dxCreateTexture("files/pt.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[50] = function()
  if not isElement(sightlangStaticImage[50]) then
    sightlangStaticImageToc[50] = false
    sightlangStaticImage[50] = dxCreateTexture("files/pt1.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[51] = function()
  if not isElement(sightlangStaticImage[51]) then
    sightlangStaticImageToc[51] = false
    sightlangStaticImage[51] = dxCreateTexture("files/pt2.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[52] = function()
  if not isElement(sightlangStaticImage[52]) then
    sightlangStaticImageToc[52] = false
    sightlangStaticImage[52] = dxCreateTexture("files/pt3.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[53] = function()
  if not isElement(sightlangStaticImage[53]) then
    sightlangStaticImageToc[53] = false
    sightlangStaticImage[53] = dxCreateTexture("files/pt4.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
local sitIcon = false
local sitColor = false
local sitBgColor = false
local faTicks = false
local function sightlangGuiRefreshColors()
  local res = getResourceFromName("sGui")
  if res and getResourceState(res) == "running" then
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
local screenX, screenY = 1024, 768
screenX, screenY = guiGetScreenSize()
local sy = screenY / 1080 * 1080
local sx = sy * 0.6481481481481481
local r = sy / 1080
local x = 32
x = screenX / 2 - sx / 2
local y = 0
local myMachine = false
local diceData = {}
local streamedInMachines = {}
local lastHold = 0
addEvent("gotSeeDiceHold", true)
addEventHandler("gotSeeDiceHold", getRootElement(), function(id, col, hold)
  local tbl = diceData[id]
  if id == myMachine then
    lastHold = getTickCount()
  end
  if col then
    tbl.hold[col] = hold
    if hold then
      playMachineSound(id, "hold" .. col)
    else
      playMachineSound(id, "holdoff")
    end
    if tbl.holdTheSymbols[col] then
      tbl.holdTheSymbols[col] = false
    end
  else
    for col = 1, 3 do
      tbl.hold[col] = false
      tbl.holdTheSymbols[col] = false
    end
    playMachineSound(id, "holdoff")
  end
end)
function collectSeeDice(id, tbl)
  tbl.lastRisk = false
  tbl.endTime = false
  tbl.ended = false
  tbl.win = false
  if isElement(tbl.gambleSound) then
    destroyElement(tbl.gambleSound)
  end
  tbl.gambleSound = false
  if isElement(tbl.diceSound) then
    destroyElement(tbl.diceSound)
  end
  tbl.diceSound = false
  if isElement(tbl.loopSound) then
    destroyElement(tbl.loopSound)
  end
  tbl.loopSound = false
  tbl.rNum = 0
  tbl.wl = false
  tbl.risk = false
  tbl.riskAnim = false
  tbl.winSound = false
  tbl.riskCollect = false
  for i = 1, 3 do
    tbl.rotating[i] = false
  end
  local diff = tbl.newBalance - tbl.balance
  local stake = stakes[1]
  stake = stake + (stakes[tbl.stake] - stake) * 0.75
  local time = math.max(1, math.min(9, diff / stake / 7))
  tbl.balanceSpeed = diff / time
  if not tbl.transLoop then
    tbl.transLoop = playMachineSound(id, "transloop")
  end
end
function convertBalanceText(balance, balanceText, wasText)
  balance = math.min(9999999, balance)
  local i = 0
  if wasText then
    for i = 1, math.max(#wasText, #balanceText) do
      wasText[i] = balanceText[i]
    end
  end
  for i = 1, 7 do
    local p = math.pow(10, i - 1)
    local n = math.floor(balance / p)
    if 0 < n or i == 1 then
      balanceText[i] = n % 10
    else
      balanceText[i] = nil
    end
  end
end
addEvent("gotSeeDicePayIn", true)
addEventHandler("gotSeeDicePayIn", getRootElement(), function(id, bal)
  local tbl = diceData[id]
  tbl.balance = bal
  convertBalanceText(tbl.balance, tbl.balanceText)
  playMachineSound(id, "transfer")
  if id == myMachine then
    deletePayInWindow()
  end
end)
addEvent("gotSeeDiceCollect", true)
addEventHandler("gotSeeDiceCollect", getRootElement(), function(id, bal)
  local tbl = diceData[id]
  tbl.newBalance = bal
  collectSeeDice(id, tbl)
end)
addEvent("setSeeDiceStake", true)
addEventHandler("setSeeDiceStake", getRootElement(), function(id, stake)
  local tbl = diceData[id]
  tbl.stake = stake
  tbl.disableHold = true
  playMachineSound(id, stake == #stakes and "stakemax" or "stake")
end)
addEvent("gotSeeDiceGamble", true)
addEventHandler("gotSeeDiceGamble", getRootElement(), function(id, risk, success, sym, collect)
  local tbl = diceData[id]
  tbl.riskValue = risk
  if risk then
    convertBalanceText(risk, tbl.riskText, tbl.riskTextWas)
  else
    for i = 1, math.max(#tbl.riskTextWas, #tbl.riskText) do
      tbl.riskTextWas[i] = tbl.riskText[i]
      tbl.riskText[i] = nil
    end
  end
  tbl.lastRisk = 800
  tbl.riskAnim = 0
  tbl.risk = sym
  if collect then
    tbl.riskCollect = collect
  else
    tbl.riskCollect = false
  end
  if tbl.riskValue then
    tbl.riskWasY = 0
  else
    tbl.riskWasY = 216
  end
  if isElement(tbl.gambleSound) then
    destroyElement(tbl.gambleSound)
  end
  tbl.gambleSound = false
  if isElement(tbl.diceSound) then
    destroyElement(tbl.diceSound)
  end
  tbl.diceSound = false
  playMachineSound(id, success and "gamblewin" or "gamblelose")
end)
addEvent("startSeeDiceRotation", true)
addEventHandler("startSeeDiceRotation", getRootElement(), function(id, hold, disableHold, win, winSymbols, dice, diceRot, diceRounds, risk, bal, clock)
  local tbl = diceData[id]
  tbl.handHold = false
  tbl.rNum = 0
  tbl.startedNum = 0
  tbl.clockLine = false
  tbl.clockBalance = clock
  tbl.clockAnim = getTickCount()
  convertBalanceText(tbl.clockBalance, tbl.clockText)
  for i = 1, 3 do
    tbl.holdTime[i] = false
    if not hold[i] then
      tbl.rNum = tbl.rNum + 1
      tbl.startedNum = tbl.startedNum + 1
      tbl.rotating[i] = 0
      tbl.preEndRotation[i] = false
      tbl.endRotation[i] = false
      tbl.rotations[i] = 0
      tbl.tmpSymbols[i][1] = randomFillSymbol()
      for row = 2, 4 do
        tbl.tmpSymbols[i][row] = reels[i][tbl.reels[i] + row - 1]
      end
    else
      tbl.rotating[i] = false
    end
    tbl.hold[i] = false
    tbl.holdTheSymbols[i] = false
  end
  tbl.disableHold = disableHold
  tbl.win = win
  tbl.winSymbols = winSymbols
  tbl.dice = dice
  tbl.diceCol = false
  tbl.diceSpin = false
  tbl.diceResult = false
  if diceRounds then
    tbl.diceRounds = diceRounds
  end
  tbl.riskValue = risk
  tbl.riskTmp = 0
  if risk then
    for i = 1, #tbl.riskTextWas do
      tbl.riskTextWas[i] = nil
    end
  end
  if isElement(tbl.transLoop) then
    destroyElement(tbl.transLoop)
  end
  tbl.transLoop = false
  if tbl.newBalance then
    tbl.balance = tbl.newBalance
  end
  tbl.newBalance = false
  tbl.balanceSpeed = false
  tbl.wl = false
  tbl.risk = false
  if bal then
    tbl.balance = bal
    convertBalanceText(tbl.balance, tbl.balanceText)
  end
  tbl.lastRisk = false
  tbl.riskAnim = false
  if isElement(tbl.gambleSound) then
    destroyElement(tbl.gambleSound)
  end
  tbl.gambleSound = false
  if isElement(tbl.diceSound) then
    destroyElement(tbl.diceSound)
  end
  tbl.diceSound = false
  tbl.winSound = win and 0 or false
  tbl.endTime = false
  tbl.riskCollect = false
  tbl.ended = false
  tbl.diceRot = diceRot
  tbl.diceRotStop = false
  if not tbl.loopSound and not tbl.diceRot then
    tbl.loopSound = playMachineSound(id, "loop", true)
  end
  tbl.loopVol = 0
  playMachineSound(id, diceRot and "dicespin" or "start")
end)
addEvent("stopSeeDiceRoll", true)
addEventHandler("stopSeeDiceRoll", getRootElement(), function(id, rounds)
  local tbl = diceData[id]
  if diceData[id] then
    tbl.diceResult = rounds
    tbl.canStopDice = tbl.diceSpin < rounds - 1 or rounds < tbl.diceSpin
    tbl.lastDice = rounds
  end
end)
addEvent("stopSeeDiceRotation", true)
addEventHandler("stopSeeDiceRotation", getRootElement(), function(id, col, reel, holdSymbols, clevel, cline, balance)
  local tbl = diceData[id]
  tbl.preEndRotation[col] = 3
  if clevel then
    tbl.clockLevelAnim = true
    tbl.newClockLevel = clevel
    tbl.clockLine = cline
  end
  if balance then
    tbl.newBalance = balance
    local diff = tbl.newBalance - tbl.balance
    tbl.balanceSpeed = diff / 9
  end
  tbl.reels[col] = reel
  if holdSymbols then
    tbl.hold[col] = true
    tbl.holdTheSymbols[col] = true
    tbl.holdSymbols[col] = holdSymbols
  else
    tbl.hold[col] = false
    tbl.holdTheSymbols[col] = false
  end
end)
addEvent("stopSeeDiceAllRotation", true)
addEventHandler("stopSeeDiceAllRotation", getRootElement(), function(id, reels, holdSymbols)
  local tbl = diceData[id]
  tbl.reels = reels
  for col = 1, 3 do
    tbl.preEndRotation[col] = 3
    if holdSymbols[col] then
      tbl.hold[col] = true
      tbl.holdTheSymbols[col] = true
      tbl.holdSymbols[col] = holdSymbols[col]
    else
      tbl.hold[col] = false
      tbl.holdTheSymbols[col] = false
    end
  end
end)
function newTmpSymbols(tbl, col, sym)
  for i = 4, 2, -1 do
    tbl.tmpSymbols[col][i] = tbl.tmpSymbols[col][i - 1]
  end
  tbl.tmpSymbols[col][1] = sym or randomFillSymbol()
end
function easeOutBounce(x)
  local n1 = 7.5625
  local d1 = 2.75
  if x < 1 / d1 then
    return x * d1
  elseif x < 2 / d1 then
    return n1 * math.pow(x - 1.5 / d1, 2) + 0.75
  elseif x < 2.5 / d1 then
    return n1 * math.pow(x - 2.25 / d1, 2) + 0.9375
  else
    return n1 * math.pow(x - 2.625 / d1, 2) + 0.984375
  end
end
local now = getTickCount()
function playMachineSound(id, text, loop)
  local sound
  if id == myMachine then
    sound = playSound("files/sound/" .. text .. ".mp3", loop)
  else
    if not diceData[id] or not diceData[id].d then
      return
    end
    if text ~= "clockpre" and text ~= "clockwin" and text ~= "clock" and text ~= "transloop" and not loop and diceData[id].d > 20 then
      return
    end
    local x, y, z = diceMachineCoordinates[id][1], diceMachineCoordinates[id][2], diceMachineCoordinates[id][3]
    sound = playSound3D("files/sound/" .. text .. ".mp3", x, y, z + 1.5, loop)
    if text == "clockpre" or text == "clockwin" or text == "clock" then
      setSoundMaxDistance(sound, 20)
      setSoundMinDistance(sound, 3)
    else
      if myMachine then
        setSoundMaxDistance(sound, 10)
        setSoundVolume(sound, 0.5)
      else
        setSoundMaxDistance(sound, 15)
        setSoundVolume(sound, 0.75)
      end
      setSoundMinDistance(sound, 1)
    end
    setElementInterior(sound, diceMachineCoordinates[id][5])
    setElementDimension(sound, diceMachineCoordinates[id][6])
  end
  return sound
end
local stakeScreens = {}
for i = 1, #stakes do
  stakeScreens[i] = {}
  local stake = stakes[i]
  local c = 0
  for j = 7, 1, -1 do
    local p = math.pow(10, c)
    local n = math.floor(stake / p)
    if 0 < n or c == 1 then
      stakeScreens[i][j] = n % 10
    else
      break
    end
    c = c + 1
  end
end
local btnCoords = {
  {
    0.4239,
    -0.3435,
    1.0639,
    0.4585,
    -0.3435,
    1.0284,
    0
  },
  {
    0.4239,
    -0.2551,
    1.0639,
    0.4585,
    -0.2551,
    1.0284,
    1
  },
  {
    0.4239,
    -0.1667,
    1.0639,
    0.4585,
    -0.1667,
    1.0284,
    1
  },
  {
    0.4239,
    -0.0783,
    1.0639,
    0.4585,
    -0.0783,
    1.0284,
    1
  },
  {
    0.4239,
    0.2551,
    1.0639,
    0.4585,
    0.2551,
    1.0284,
    2
  },
  {
    0.4239,
    0.3435,
    1.0639,
    0.4585,
    0.3435,
    1.0284,
    3
  }
}
local machineBtnCoords = {}
function drawDiceButton3D(id, btn, c)
  local dat = machineBtnCoords[id][btn]
  sightlangStaticImageUsed[0] = true
  if sightlangStaticImageToc[0] then
    processsightlangStaticImage[0]()
  end
  dxDrawMaterialSectionLine3D(dat[1], dat[2], dat[3], dat[4], dat[5], dat[6], 32 * btnCoords[btn][7], 0, 32, 32, sightlangStaticImage[0], 0.049954, tocolor(c, c, c), dat[7], dat[8], dat[9])
end
local diceGraphs = {
  dice = {
    {
      -0.26634082278481,
      1.39706,
      0.056064,
      0.028032,
      0.13917
    },
    {
      -0.19616449367089,
      1.39706,
      0.056064,
      0.028032,
      0.13917
    },
    {
      -0.12598816455696,
      1.39706,
      0.056064,
      0.028032,
      0.13917
    },
    {
      -0.055811835443038,
      1.39706,
      0.056064,
      0.028032,
      0.13917
    },
    {
      0.014364493670886,
      1.39706,
      0.056064,
      0.028032,
      0.13917
    },
    {
      0.08454082278481,
      1.39706,
      0.056064,
      0.028032,
      0.13917
    }
  },
  risk = {
    {
      0.21314869230769,
      1.46742,
      0.03273875,
      0.016369375,
      0.13917
    },
    {
      0.23460446153846,
      1.46742,
      0.03273875,
      0.016369375,
      0.13917
    },
    {
      0.25606023076923,
      1.46742,
      0.03273875,
      0.016369375,
      0.13917
    },
    {
      0.277516,
      1.46742,
      0.03273875,
      0.016369375,
      0.13917
    },
    {
      0.29897176923077,
      1.46742,
      0.03273875,
      0.016369375,
      0.13917
    },
    {
      0.32042753846153,
      1.46742,
      0.03273875,
      0.016369375,
      0.13917
    },
    {
      0.3418833076923,
      1.46742,
      0.03273875,
      0.016369375,
      0.13917
    }
  },
  stake = {
    {
      0.21314869230769,
      1.35542,
      0.03273875,
      0.016369375,
      0.13917
    },
    {
      0.23460446153846,
      1.35542,
      0.03273875,
      0.016369375,
      0.13917
    },
    {
      0.25606023076923,
      1.35542,
      0.03273875,
      0.016369375,
      0.13917
    },
    {
      0.277516,
      1.35542,
      0.03273875,
      0.016369375,
      0.13917
    },
    {
      0.29897176923077,
      1.35542,
      0.03273875,
      0.016369375,
      0.13917
    },
    {
      0.32042753846153,
      1.35542,
      0.03273875,
      0.016369375,
      0.13917
    },
    {
      0.3418833076923,
      1.35542,
      0.03273875,
      0.016369375,
      0.13917
    }
  },
  clockseg = {
    {
      0.062466776188364,
      1.89438,
      0.0297625,
      0.01488125,
      0.14542
    },
    {
      0.081996184125576,
      1.89438,
      0.0297625,
      0.01488125,
      0.14542
    },
    {
      0.10152559206279,
      1.89438,
      0.0297625,
      0.01488125,
      0.14542
    },
    {
      0.121055,
      1.89438,
      0.0297625,
      0.01488125,
      0.14542
    },
    {
      0.14058440793721,
      1.89438,
      0.0297625,
      0.01488125,
      0.14542
    },
    {
      0.16011381587442,
      1.89438,
      0.0297625,
      0.01488125,
      0.14542
    },
    {
      0.17964322381164,
      1.89438,
      0.0297625,
      0.01488125,
      0.14542
    }
  },
  bank = {
    {
      0.21314869230769,
      1.5796,
      0.03273875,
      0.016369375,
      0.13917
    },
    {
      0.23460446153846,
      1.5796,
      0.03273875,
      0.016369375,
      0.13917
    },
    {
      0.25606023076923,
      1.5796,
      0.03273875,
      0.016369375,
      0.13917
    },
    {
      0.277516,
      1.5796,
      0.03273875,
      0.016369375,
      0.13917
    },
    {
      0.29897176923077,
      1.5796,
      0.03273875,
      0.016369375,
      0.13917
    },
    {
      0.32042753846153,
      1.5796,
      0.03273875,
      0.016369375,
      0.13917
    },
    {
      0.3418833076923,
      1.5796,
      0.03273875,
      0.016369375,
      0.13917
    }
  },
  staketop = {
    {
      -0.3,
      2.025,
      0.073410027777778,
      0.016016733333333,
      0.14542
    },
    {
      -0.21658997222222,
      2.025,
      0.081418394444444,
      0.016016733333333,
      0.14542
    },
    {
      -0.12517157777778,
      2.025,
      0.08408785,
      0.016016733333333,
      0.14542
    },
    {
      -0.031083727777778,
      2.025,
      0.0961004,
      0.016016733333333,
      0.14542
    }
  },
  bigdice = {
    0.09715,
    1.56903,
    0.058569,
    0.0292845,
    0.132144
  },
  lines = {
    -0.204357,
    1.56919,
    0.375528,
    0.093882,
    0.14542
  },
  clock = {
    -0.046658,
    1.89955,
    0.56309,
    0.1201255,
    0.14542
  },
  darrow = {
    0.09715,
    1.56903,
    0.1428512195122,
    0.1428512195122,
    0.14542
  }
}
local diceGraphMachines = {}
function drawDice3D(id, graphId, graphArg, tex, c, u, v, uh, vh)
  local dat = false
  if graphArg then
    dat = diceGraphMachines[id][graphId][graphArg]
  else
    dat = diceGraphMachines[id][graphId]
  end
  local sin, cos = diceMachineCoordinates[id][7], diceMachineCoordinates[id][8]
  local x, y, z, h, w = dat[1], dat[2], dat[3], dat[4], dat[5]
  if c <= 255 and 0 <= c then
    c = tocolor(c, c, c)
  end
  if u then
    dxDrawMaterialSectionLine3D(x, y, z + h, x, y, z - h, u, v, uh, vh, tex, w, c, x + cos, y + sin, z)
  else
    dxDrawMaterialLine3D(x, y, z + h, x, y, z - h, tex, w, c, x + cos, y + sin, z)
  end
end
function drawDice3DEx(x, y, z, sin, cos, iy, iz, w, h, tex, c, u, v, uh, vh, sunk)
  if sunk then
    x = x + (0.134917 + sunk) * cos
    y = y + (0.134917 + sunk) * sin
  else
    x = x + 0.134917 * cos
    y = y + 0.134917 * sin
  end
  x = x - iy * sin
  y = y + iy * cos
  z = z + iz
  if c <= 255 and 0 <= c then
    c = tocolor(c, c, c)
  end
  if u then
    dxDrawMaterialSectionLine3D(x, y, z + h, x, y, z - h, u, v, uh, vh, tex, w, c, x + cos, y + sin, z)
  else
    dxDrawMaterialLine3D(x, y, z + h, x, y, z - h, tex, w, c, x + cos, y + sin, z)
  end
end
local clockBlinker = 0
local secondClockBlinker = false
local diceFlasher = 0
local diceBlinker = false
function preRenderDiceMachines(delta)
  now = getTickCount()
  clockBlinker = math.floor(now % 600 / 100)
  secondClockBlinker = now % 500 > 250
  diceFlasher = math.floor(now % 1000 / 1000 * 12) + 1
  diceBlinker = now % 700 > 350
  local px, py, pz = getElementPosition(localPlayer)
  for i = 1, #streamedInMachines do
    local id = streamedInMachines[i]
    local x, y, z, rz = unpack(diceMachineCoordinates[id])
    local tbl = diceData[id]
    local vol = 0
    if tbl.clockAnim and 600 < now - tbl.clockAnim then
      tbl.clockAnim = false
    end
    for col = 1, 3 do
      if tbl.rotating[col] then
        local canEnd = true
        local endRot = tbl.endRotation[col]
        if not endRot then
          vol = 1
        end
        if 1 > tbl.rotating[col] then
          canEnd = false
          tbl.rotating[col] = tbl.rotating[col] + 4 * delta / 1000
          if 1 < tbl.rotating[col] then
            tbl.rotating[col] = 1
          end
        end
        tbl.rotations[col] = tbl.rotations[col] + (endRot and 0.36363636363636365 or tbl.rotating[col]) * 10 * delta / 1000
        if 1 <= tbl.rotations[col] then
          if endRot and canEnd then
            tbl.rotations[col] = 1
            tbl.endRotation[col] = false
            tbl.rotating[col] = false
            tbl.rNum = tbl.rNum - 1
            if 0 >= tbl.rNum then
              local t = 100
              for col = 1, 3 do
                if tbl.hold[col] then
                  tbl.holdTime[col] = t
                  t = t + 200
                end
              end
            end
          elseif tbl.preEndRotation[col] and canEnd then
            tbl.rotations[col] = tbl.rotations[col] % 1
            local pre = tbl.preEndRotation[col]
            newTmpSymbols(tbl, col, reels[col][tbl.reels[col] + pre])
            tbl.preEndRotation[col] = pre - 1
            if 0 >= tbl.preEndRotation[col] then
              tbl.endRotation[col] = true
              tbl.preEndRotation[col] = false
              if tbl.diceRot and not tbl.diceRotStop then
                playMachineSound(id, "dicespinstop")
                tbl.diceRotStop = true
              else
                local sound = playMachineSound(id, "end")
                if sound then
                  setSoundPan(sound, col - 2)
                end
              end
            end
          else
            tbl.rotations[col] = tbl.rotations[col] % 1
            newTmpSymbols(tbl, col)
          end
        end
      elseif tbl.holdTime[col] then
        tbl.holdTime[col] = tbl.holdTime[col] - delta
        if 0 >= tbl.holdTime[col] then
          tbl.holdTime[col] = false
          playMachineSound(id, "hold" .. col)
        end
      end
    end
    if 0 >= tbl.rNum then
      if tbl.clockAnim then
        tbl.clockAnim = false
      end
      if not tbl.endTime and not tbl.ended then
        tbl.endTime = now
        tbl.ended = true
      end
      if tbl.newClockLevel then
        tbl.clockLevel = tbl.newClockLevel
        tbl.newClockLevel = false
        if 3 <= tbl.clockLevel then
          playMachineSound(id, "clockwin")
        else
          playMachineSound(id, "clockpre")
        end
      end
      if tbl.clockLevelAnim then
        local time = 3 <= tbl.clockLevel and 27000 or 5000
        if not tonumber(tbl.clockLevelAnim) then
          tbl.clockLevelAnim = now
        end
        if time < now - tbl.clockLevelAnim then
          tbl.clockLevelAnim = false
          tbl.clockLine = false
          if 3 > tbl.clockLevel then
            playMachineSound(id, "clock")
          else
            tbl.clockLevel = 0
            for i = 1, #tbl.clockText do
              tbl.clockText[i] = nil
            end
            if not tbl.transLoop then
              tbl.transLoop = playMachineSound(id, "transloop")
            end
          end
        end
      elseif tbl.dice then
        if not tonumber(tbl.dice) then
          tbl.dice = now
          playMachineSound(id, "dice")
        end
        local diceDelta = now - tbl.dice
        if diceDelta < 1500 then
          tbl.diceCol = math.floor(diceDelta % 500 / 500 * 3 + 1)
        else
          local spd = 2.5
          if diceDelta < 1750 then
            spd = (diceDelta - 1500) / 250 * 2.5
          end
          if not tbl.diceSpin then
            tbl.diceCol = false
            if not tbl.diceSound then
              tbl.diceSound = playMachineSound(id, "diceloop", true)
            end
            tbl.diceSpin = tbl.lastDice
          end
          if tbl.diceResult and tbl.diceSpin >= tbl.diceResult - 1 and tbl.diceSpin <= tbl.diceResult then
            if tbl.canStopDice then
              if tbl.diceSound then
                if isElement(tbl.diceSound) then
                  destroyElement(tbl.diceSound)
                end
                tbl.diceSound = false
                playMachineSound(id, "diceend")
              end
              tbl.diceSpin = tbl.diceSpin + 2 * delta / 1000
              if tbl.diceSpin >= tbl.diceResult then
                tbl.diceSpin = false
                tbl.dice = false
                tbl.lastDiceResult = now
              end
            else
              tbl.diceSpin = tbl.diceSpin + 6 * spd * delta / 1000
            end
          else
            if tbl.diceResult and not tbl.canStopDice then
              tbl.canStopDice = true
            end
            tbl.diceSpin = tbl.diceSpin + 6 * spd * delta / 1000
            if tbl.diceSpin > 6 then
              tbl.diceSpin = tbl.diceSpin - 6
            end
          end
        end
      elseif tbl.diceResult then
        if 250 < now - tbl.lastDiceResult then
          tbl.lastDiceResult = now
          tbl.diceResult = tbl.diceResult - 1
          if 0 <= tbl.diceResult then
            tbl.diceRounds = tbl.diceRounds + 1
            playMachineSound(id, "diceadd")
          elseif tbl.diceResult < -1 then
            tbl.diceResult = false
          end
        end
      elseif tbl.winSound then
        if now - tbl.endTime > 700 * tbl.winSound then
          tbl.winSound = tbl.winSound + 1
          if tbl.winSound > #tbl.win then
            tbl.winSound = false
            if not tbl.gambleSound then
              tbl.gambleSound = playMachineSound(id, "gamble", true)
            end
            convertBalanceText(tbl.riskValue, tbl.riskText)
          else
            local line = tbl.win[tbl.winSound]
            local sym = tbl.winSymbols[tbl.winSound]
            tbl.riskTmp = tbl.riskTmp + symbolPayout[sym] * stakes[tbl.stake]
            convertBalanceText(tbl.riskTmp, tbl.riskText)
            playMachineSound(id, "wline" .. math.min(3, tbl.winSound))
          end
        end
      elseif tbl.lastRisk then
        local new = tbl.lastRisk - delta
        tbl.lastRisk = new
        tbl.riskAnim = math.floor((800 - new) / 800 * 13)
        if 0 >= tbl.lastRisk then
          tbl.riskSym = false
          tbl.lastRisk = false
          tbl.riskAnim = false
          for i = 1, #tbl.riskTextWas do
            tbl.riskTextWas[i] = nil
          end
          if tbl.riskValue then
            if tbl.riskCollect then
              tbl.newBalance = tbl.riskCollect
              collectSeeDice(id, tbl)
            elseif not tbl.gambleSound then
              tbl.gambleSound = playMachineSound(id, "gamble", true)
            end
          else
            tbl.endTime = false
          end
        end
      elseif tbl.newBalance then
        if tbl.balance < tbl.newBalance then
          tbl.balance = tbl.balance + tbl.balanceSpeed * delta / 1000
          if tbl.riskValue then
            tbl.riskValue = math.max(0, tbl.riskValue - tbl.balanceSpeed * delta / 1000)
            convertBalanceText(tbl.riskValue, tbl.riskText)
          end
        else
          tbl.balance = tbl.newBalance
          tbl.riskValue = false
          tbl.newBalance = false
          if isElement(tbl.transLoop) then
            destroyElement(tbl.transLoop)
          end
          tbl.transLoop = false
          playMachineSound(id, "transfer")
        end
        convertBalanceText(tbl.balance, tbl.balanceText)
      end
    end
    if tbl.loopSound then
      if vol > tbl.loopVol then
        tbl.loopVol = tbl.loopVol + 2.75 * delta / 1000
        if vol < tbl.loopVol then
          tbl.loopVol = vol
        end
      end
      setSoundVolume(tbl.loopSound, tbl.loopVol)
      if vol <= 0 then
        if isElement(tbl.loopSound) then
          destroyElement(tbl.loopSound)
        end
        tbl.loopSound = nil
      end
    end
    if tbl.win and tbl.endTime then
      local delta = now - tbl.endTime
      if not tbl.lastRisk then
        if not tbl.winSound then
          tbl.risk = math.floor(delta % 350 / 175 + 1)
        else
          tbl.risk = false
        end
      end
      local i = math.floor(delta / 700 % #tbl.win + 1)
      tbl.wl = tbl.win[i]
    elseif tbl.wl or tbl.risk then
      tbl.wl = false
      tbl.risk = false
    end
    local rNum = 0 < tbl.rNum
    if tbl.riskAnim then
      tbl.riskBlink = true
      if tbl.riskValue then
        if 4 >= tbl.riskAnim then
          tbl.riskY = 0
          tbl.riskWasY = tbl.riskAnim * 24
        elseif tbl.riskAnim <= 8 then
          tbl.riskY = tbl.riskAnim * 24
          tbl.riskWasY = false
        else
          tbl.riskY = 0
          tbl.riskWasY = false
        end
      elseif tbl.riskAnim <= 8 then
        tbl.riskY = 0
        tbl.riskWasY = math.floor(9 - tbl.riskAnim / 2) * 24
      else
        tbl.riskY = 0
        tbl.riskWasY = false
      end
    elseif tbl.risk then
      tbl.riskY = 0
      tbl.riskWasY = false
      tbl.riskBlink = tbl.risk == 2
    elseif tbl.winSound or tbl.newBalance then
      tbl.riskY = 0
      tbl.riskWasY = false
      tbl.riskBlink = not rNum
    else
      tbl.riskY = 0
      tbl.riskWasY = false
      tbl.riskBlink = false
    end
    local camx, camy, camz = getCameraMatrix()
    local d = getDistanceBetweenPoints3D(x, y, z, camx, camy, camz)
    tbl.d = d
    tbl.onScreen = isElementOnScreen(tbl.obj) and d <= 75 and pz - z < 5 or id == myMachine
    if tbl.onScreen then
      if isElement(tbl.player) then
        setElementRotation(tbl.player, 0, 0, rz + 90, "default", true)
        local a, b = getPedAnimation(tbl.player)
        if a ~= "int_office" or b ~= "off_sit_idle_loop" then
          setPedAnimation(tbl.player, "int_office", "off_sit_idle_loop", -1, true, false, false, false)
        end
      end
      local sin, cos = diceMachineCoordinates[id][7], diceMachineCoordinates[id][8]
      local c = 255
      local wl = tbl.wl
      local risk = tbl.risk
      local clock = tbl.clockAnim and clockBlinker
      local clockAnim = tonumber(tbl.clockLevelAnim)
      local clockLevel = tbl.clockLevel
      if d <= 12.5 then
        for i = 1, 7 do
          if tbl.balanceText[8 - i] then
            sightlangStaticImageUsed[1] = true
            if sightlangStaticImageToc[1] then
              processsightlangStaticImage[1]()
            end
            drawDice3D(id, "bank", i, sightlangStaticImage[1], tocolor(250, 0, 0), 24 * tbl.balanceText[8 - i], 0, 24, 24)
          end
          if tbl.riskBlink then
            if tbl.riskWasY then
              if tbl.riskTextWas[8 - i] then
                sightlangStaticImageUsed[1] = true
                if sightlangStaticImageToc[1] then
                  processsightlangStaticImage[1]()
                end
                drawDice3D(id, "risk", i, sightlangStaticImage[1], tocolor(250, 0, 0), 24 * tbl.riskTextWas[8 - i], tbl.riskWasY, 24, 24)
              end
            elseif tbl.riskText[8 - i] then
              sightlangStaticImageUsed[1] = true
              if sightlangStaticImageToc[1] then
                processsightlangStaticImage[1]()
              end
              drawDice3D(id, "risk", i, sightlangStaticImage[1], tocolor(250, 0, 0), 24 * tbl.riskText[8 - i], tbl.riskY, 24, 24)
            end
          end
          if stakeScreens[tbl.stake][i] then
            sightlangStaticImageUsed[1] = true
            if sightlangStaticImageToc[1] then
              processsightlangStaticImage[1]()
            end
            drawDice3D(id, "stake", i, sightlangStaticImage[1], tocolor(250, 0, 0), 24 * stakeScreens[tbl.stake][i], 0, 24, 24)
          end
        end
        for i = 1, 7 do
          sightlangStaticImageUsed[1] = true
          if sightlangStaticImageToc[1] then
            processsightlangStaticImage[1]()
          end
          if clock then
            sightlangStaticImageUsed[1] = true
            if sightlangStaticImageToc[1] then
              processsightlangStaticImage[1]()
            end
            drawDice3D(id, "clockseg", i, sightlangStaticImage[1], tocolor(250, 0, 0), 240, 24 * ((clock - i % 2 * 3) % 6), 24, 24, 0.00625)
          elseif (not clockAnim or clockLevel < 3 or secondClockBlinker) and tbl.clockText[8 - i] then
            sightlangStaticImageUsed[1] = true
            if sightlangStaticImageToc[1] then
              processsightlangStaticImage[1]()
            end
            drawDice3D(id, "clockseg", i, sightlangStaticImage[1], tocolor(250, 0, 0), 24 * tbl.clockText[8 - i], 0, 24, 24, 0.00625)
          end
        end
      end
      if d <= 25 then
        if tbl.diceSpin then
          local p = tbl.diceSpin
          if tbl.diceResult and p >= tbl.diceResult - 1 and p <= tbl.diceResult then
            p = easeOutBounce(p - (tbl.diceResult - 1)) + (tbl.diceResult - 1)
          end
          sightlangStaticImageUsed[2] = true
          if sightlangStaticImageToc[2] then
            processsightlangStaticImage[2]()
          end
          drawDice3D(id, "bigdice", false, sightlangStaticImage[2], 255, 0, -40 * p, 40, 40)
          sightlangStaticImageUsed[3] = true
          if sightlangStaticImageToc[3] then
            processsightlangStaticImage[3]()
          end
          drawDice3D(id, "darrow", false, sightlangStaticImage[3], 255)
          local p = diceFlasher
          for i = 1, 6 do
            c = i <= p and i > p - 6 and 255 or 90
            sightlangStaticImageUsed[4] = true
            if sightlangStaticImageToc[4] then
              processsightlangStaticImage[4]()
            end
            drawDice3D(id, "dice", i, sightlangStaticImage[4], c, 32 * (i - 1), 0, 32, 32)
          end
        else
          sightlangStaticImageUsed[2] = true
          if sightlangStaticImageToc[2] then
            processsightlangStaticImage[2]()
          end
          drawDice3D(id, "bigdice", false, sightlangStaticImage[2], tbl.diceResult and 255 or 120, 0, -40 * tbl.lastDice, 40, 40)
          sightlangStaticImageUsed[3] = true
          if sightlangStaticImageToc[3] then
            processsightlangStaticImage[3]()
          end
          drawDice3D(id, "darrow", false, sightlangStaticImage[3], 120)
          for i = 1, 6 do
            if not rNum and i == tbl.diceRounds and not risk and not tbl.newBalance and not wl and not tbl.diceResult then
              c = diceBlinker and 255 or 90
            else
              c = i <= tbl.diceRounds and 255 or 90
            end
            sightlangStaticImageUsed[4] = true
            if sightlangStaticImageToc[4] then
              processsightlangStaticImage[4]()
            end
            drawDice3D(id, "dice", i, sightlangStaticImage[4], c, 32 * (i - 1), 0, 32, 32)
          end
        end
        rx = -0.267402
        h = 0.0203675
        for col = 1, 3 do
          local rz = 1.604745
          local t = false
          if not tbl.win and tbl.hold[col] and not tbl.holdTheSymbols[col] then
            t = 1
          else
            t = rNum and 1 or 2
          end
          if tbl.rotating[col] then
            local p = tbl.rotations[col]
            if tbl.endRotation[col] then
              p = easeOutBounce(p)
            end
            rz = rz - h * 2 * (-1 + p)
            for row = 1, 4 do
              if t == 1 then
                sightlangStaticImageUsed[5] = true
                if sightlangStaticImageToc[5] then
                  processsightlangStaticImage[5]()
                end
                drawDice3DEx(x, y, z, sin, cos, rx, rz, 0.059, h, sightlangStaticImage[5], 255, 44 * (tbl.tmpSymbols[col][row] - 1), 0, 44, 30, -0.007026000000000001)
              else
                sightlangStaticImageUsed[6] = true
                if sightlangStaticImageToc[6] then
                  processsightlangStaticImage[6]()
                end
                drawDice3DEx(x, y, z, sin, cos, rx, rz, 0.059, h, sightlangStaticImage[6], 255, 44 * (tbl.tmpSymbols[col][row] - 1), 0, 44, 30, -0.007026000000000001)
              end
              rz = rz - h * 2
            end
          else
            for row = 1, 3 do
              local it = t
              local sym = reels[col][tbl.reels[col] + row]
              if sym == 11 and clockAnim then
                if secondClockBlinker then
                  it = 1
                end
              elseif sym == 10 and tbl.dice and (tbl.diceCol == col or not tbl.diceCol) then
                it = 1
              elseif wl and lines[wl][col] == row then
                it = 1
              elseif tbl.hold[col] and tbl.holdTheSymbols[col] and tbl.holdSymbols[col][row] and not tbl.holdTime[col] then
                it = 1
              end
              if it == 1 then
                sightlangStaticImageUsed[5] = true
                if sightlangStaticImageToc[5] then
                  processsightlangStaticImage[5]()
                end
                drawDice3DEx(x, y, z, sin, cos, rx, rz, 0.059, h, sightlangStaticImage[5], 255, 44 * (sym - 1), 0, 44, 30, -0.007026000000000001)
              else
                sightlangStaticImageUsed[6] = true
                if sightlangStaticImageToc[6] then
                  processsightlangStaticImage[6]()
                end
                drawDice3DEx(x, y, z, sin, cos, rx, rz, 0.059, h, sightlangStaticImage[6], 255, 44 * (sym - 1), 0, 44, 30, -0.007026000000000001)
              end
              rz = rz - h * 2
            end
          end
          rx = rx + 0.13
        end
      end
      if d <= 35 then
        for j = 1, #tbl.idsBadge do
          local x, y, z = tbl.idsBadge[j][1], tbl.idsBadge[j][2], tbl.idsBadge[j][3]
          sightlangStaticImageUsed[7] = true
          if sightlangStaticImageToc[7] then
            processsightlangStaticImage[7]()
          end
          dxDrawMaterialSectionLine3D(x, y, z + 0.05, x, y, z - 0.05, tbl.idsBadge[j][4], 0, 24, 32, sightlangStaticImage[7], 0.075, tocolor(150, 150, 150), x + cos, y + sin, z)
        end
        if rNum then
          sightlangStaticImageUsed[8] = true
          if sightlangStaticImageToc[8] then
            processsightlangStaticImage[8]()
          end
          drawDice3D(id, "lines", false, sightlangStaticImage[8], 255, 0, 0, 256, 128)
        elseif tbl.clockLine and secondClockBlinker then
          sightlangStaticImageUsed[8] = true
          if sightlangStaticImageToc[8] then
            processsightlangStaticImage[8]()
          end
          drawDice3D(id, "lines", false, sightlangStaticImage[8], 255, 0, 128 * tbl.clockLine, 256, 128)
        elseif wl and (not tbl.risk or tbl.risk == 2 or tbl.lastRisk) then
          sightlangStaticImageUsed[8] = true
          if sightlangStaticImageToc[8] then
            processsightlangStaticImage[8]()
          end
          drawDice3D(id, "lines", false, sightlangStaticImage[8], 255, 0, 128 * wl, 256, 128)
        else
          sightlangStaticImageUsed[8] = true
          if sightlangStaticImageToc[8] then
            processsightlangStaticImage[8]()
          end
          drawDice3D(id, "lines", false, sightlangStaticImage[8], 100, 0, 0, 256, 128)
        end
      end
      if clockAnim and 3 <= clockLevel then
        sightlangStaticImageUsed[9] = true
        if sightlangStaticImageToc[9] then
          processsightlangStaticImage[9]()
        end
        drawDice3D(id, "clock", false, sightlangStaticImage[9], secondClockBlinker and 255 or 100, 0, 384, 300, 128)
      elseif clockAnim then
        sightlangStaticImageUsed[9] = true
        if sightlangStaticImageToc[9] then
          processsightlangStaticImage[9]()
        end
        drawDice3D(id, "clock", false, sightlangStaticImage[9], 255, 0, 128 * (clockLevel - (secondClockBlinker and 0 or 1)), 300, 128)
      else
        sightlangStaticImageUsed[9] = true
        if sightlangStaticImageToc[9] then
          processsightlangStaticImage[9]()
        end
        drawDice3D(id, "clock", false, sightlangStaticImage[9], 255, 0, 128 * clockLevel, 300, 128)
      end
      if d <= 35 then
        sightlangStaticImageUsed[10] = true
        if sightlangStaticImageToc[10] then
          processsightlangStaticImage[10]()
        end
        drawDice3D(id, "staketop", 1, sightlangStaticImage[10], tbl.stake == 1 and 255 or 100, 0, 0, 55, 24)
        sightlangStaticImageUsed[10] = true
        if sightlangStaticImageToc[10] then
          processsightlangStaticImage[10]()
        end
        drawDice3D(id, "staketop", 2, sightlangStaticImage[10], tbl.stake == 2 and 255 or 100, 55, 0, 61, 24)
        sightlangStaticImageUsed[10] = true
        if sightlangStaticImageToc[10] then
          processsightlangStaticImage[10]()
        end
        drawDice3D(id, "staketop", 3, sightlangStaticImage[10], tbl.stake == 3 and 255 or 100, 116, 0, 63, 24)
        sightlangStaticImageUsed[10] = true
        if sightlangStaticImageToc[10] then
          processsightlangStaticImage[10]()
        end
        drawDice3D(id, "staketop", 4, sightlangStaticImage[10], tbl.stake == 4 and 255 or 100, 179, 0, 72, 24)
        local hold = false
        local h = not rNum and tbl.hold[1] and not tbl.holdTime[1]
        if h then
          hold = true
        end
        c = h and 255 or 120
        drawDiceButton3D(id, 2, c)
        local h = not rNum and tbl.hold[2] and not tbl.holdTime[2]
        if h then
          hold = true
        end
        c = h and 255 or 120
        drawDiceButton3D(id, 3, c)
        local h = not rNum and tbl.hold[3] and not tbl.holdTime[3]
        if h then
          hold = true
        end
        c = h and 255 or 120
        drawDiceButton3D(id, 4, c)
        drawDiceButton3D(id, 1, (tbl.risk or hold) and 255 or 120)
        if not rNum and not tbl.winSound and not tbl.holdTime[1] and not tbl.holdTime[2] and not tbl.holdTime[3] and not tbl.dice and not tbl.diceResult then
          c = 255
        else
          c = 120
        end
        local sc = c
        if risk then
          sc = tbl.risk == 2 and 255 or 120
        end
        drawDiceButton3D(id, 5, sc)
        if tbl.diceSpin then
          c = tbl.diceSpin and not tbl.diceResult and 255 or 120
        elseif risk then
          c = tbl.risk == 1 and 255 or 120
        elseif not tbl.diceRot and tbl.rNum == tbl.startedNum and not tbl.handHold then
          c = 255
          for col = 1, 3 do
            if tbl.rotating[col] and 1 > tbl.rotating[col] then
              c = 120
              break
            end
          end
        end
        drawDiceButton3D(id, 6, c)
        local x, y, z = diceMachineCoordinates[id][1], diceMachineCoordinates[id][2], diceMachineCoordinates[id][3]
        sightlangStaticImageUsed[11] = true
        if sightlangStaticImageToc[11] then
          processsightlangStaticImage[11]()
        end
        dxDrawMaterialSectionLine3D(tbl.stakeBottomCoords[1], tbl.stakeBottomCoords[2], tbl.stakeBottomCoords[3], tbl.stakeBottomCoords[4], tbl.stakeBottomCoords[5], tbl.stakeBottomCoords[6], 0, 156 * (tbl.stake - 1), 210, 156, sightlangStaticImage[11], 0.280257, tocolor(255, 255, 255), tbl.stakeBottomCoords[7], tbl.stakeBottomCoords[8], tbl.stakeBottomCoords[9])
        c = tbl.risk and 255 or 100
        sightlangStaticImageUsed[12] = true
        if sightlangStaticImageToc[12] then
          processsightlangStaticImage[12]()
        end
        dxDrawMaterialSectionLine3D(tbl.riskBottomCords[1], tbl.riskBottomCords[2], tbl.riskBottomCords[3], tbl.riskBottomCords[4], tbl.riskBottomCords[5], tbl.riskBottomCords[6], 0, 156 * (tbl.risk or 0), 210, 156, sightlangStaticImage[12], 0.280257, tocolor(c, c, c), tbl.riskBottomCords[7], tbl.riskBottomCords[8], tbl.riskBottomCords[9])
      end
    end
  end
end
local lastStake = 0
local hoverButton = false
local clikedButton = false
local payInWindow, payInLabel
local payInSliderValue = 0
local payInAmount = 0
local sscBalance = 0
local minimized = false
addCommandHandler("minimizedice", function()
  minimized = not minimized
end)
function renderMyMachine()
  local tbl = diceData[myMachine]
  local cx, cy = getCursorPosition()
  local tmp = false
  if minimized then
    if cx then
      cx = cx * screenX
      cy = cy * screenY
      local btns = machineBtnCoords[myMachine]
      for i = 1, #btns do
        local x, y = getScreenFromWorldPosition(btns[i][1], btns[i][2], btns[i][3], 64)
        local x2, y2 = getScreenFromWorldPosition(btns[i][4], btns[i][5], btns[i][6], 64)
        if x and x2 then
          local d = getDistanceBetweenPoints2D(x, y, x2, y2) / 2
          x, y = (x + x2) / 2, (y + y2) / 2
          if cx >= x - d and cy >= y - d and cx <= x + d and cy <= y + d then
            tmp = i
          end
        end
      end
    end
  else
    local p = getTickCount() % 1000 / 1000
    dxDrawRectangle(x + 394 * r - 2, y + 409 * r - 2, 40 * r + 4, 40 * r + 4, tocolor(0, 0, 0))
    local c = 255
    if tbl.diceSpin then
      local p = tbl.diceSpin
      if tbl.diceResult and p >= tbl.diceResult - 1 and p <= tbl.diceResult then
        p = easeOutBounce(p - (tbl.diceResult - 1)) + (tbl.diceResult - 1)
      end
      sightlangStaticImageUsed[2] = true
      if sightlangStaticImageToc[2] then
        processsightlangStaticImage[2]()
      end
      dxDrawImageSection(x + 394 * r, y + 409 * r, 40 * r, 40 * r, 0, -40 * p, 40, 40, sightlangStaticImage[2], 0, 0, 0, tocolor(255, 255, 255))
    else
      c = tbl.diceResult and 255 or 120
      sightlangStaticImageUsed[2] = true
      if sightlangStaticImageToc[2] then
        processsightlangStaticImage[2]()
      end
      dxDrawImageSection(x + 394 * r, y + 409 * r, 40 * r, 40 * r, 0, -40 * tbl.lastDice, 40, 40, sightlangStaticImage[2], 0, 0, 0, tocolor(c, c, c))
    end
    local rNum = 0 < tbl.rNum
    local lsx = 46 * r
    local lsy = 30 * r
    local cb = 0
    local wl = tbl.wl
    local risk = tbl.risk
    local clockAnim = tonumber(tbl.clockLevelAnim)
    for col = 1, 3 do
      if not tbl.win and tbl.hold[col] and not tbl.holdTheSymbols[col] then
        c = 255
        cb = 195
      else
        c = rNum and 255 or 100
        cb = rNum and 195 or 100
      end
      local x = x + (164 + 89 * (col - 1)) * r
      dxDrawRectangle(x - lsx / 2, y + 377 * r, lsx, 110 * r, tocolor(c, c, cb))
      if tbl.rotating[col] then
        local p = tbl.rotations[col]
        if tbl.endRotation[col] then
          p = easeOutBounce(p)
        end
        for row = 1, 4 do
          local ry = row + p - 1
          local sx = lsx - (math.abs(ry - 2) * 4 + 2) * r
          local sy = lsy - math.abs(ry - 2) * 4 * r
          local y = y + (404 + 28 * (ry - 1)) * r - sy / 2
          sightlangStaticImageUsed[13] = true
          if sightlangStaticImageToc[13] then
            processsightlangStaticImage[13]()
          end
          dxDrawImageSection(x - sx / 2, y, sx, sy, 44 * (tbl.tmpSymbols[col][row] - 1), 0, 44, 30, sightlangStaticImage[13])
        end
      else
        for row = 1, 3 do
          local y = y + (404 + 28 * (row - 1)) * r
          local ic = c
          local sym = reels[col][tbl.reels[col] + row]
          if sym == 11 and clockAnim then
            if secondClockBlinker then
              sightlangStaticImageUsed[14] = true
              if sightlangStaticImageToc[14] then
                processsightlangStaticImage[14]()
              end
              dxDrawImage(x - lsx / 2, y - lsy / 2 - 8 * r, lsx, lsy + 16 * r, sightlangStaticImage[14], 0, 0, 0, tocolor(255, 255, 195))
              ic = 255
            end
          elseif sym == 10 and tbl.dice and (tbl.diceCol == col or not tbl.diceCol) then
            sightlangStaticImageUsed[14] = true
            if sightlangStaticImageToc[14] then
              processsightlangStaticImage[14]()
            end
            dxDrawImage(x - lsx / 2, y - lsy / 2 - 8 * r, lsx, lsy + 16 * r, sightlangStaticImage[14], 0, 0, 0, tocolor(255, 255, 195))
            ic = 255
          elseif wl and lines[wl][col] == row then
            sightlangStaticImageUsed[14] = true
            if sightlangStaticImageToc[14] then
              processsightlangStaticImage[14]()
            end
            dxDrawImage(x - lsx / 2, y - lsy / 2 - 8 * r, lsx, lsy + 16 * r, sightlangStaticImage[14], 0, 0, 0, tocolor(255, 255, 195))
            ic = 255
          elseif tbl.hold[col] and tbl.holdTheSymbols[col] and tbl.holdSymbols[col][row] and not tbl.holdTime[col] then
            sightlangStaticImageUsed[14] = true
            if sightlangStaticImageToc[14] then
              processsightlangStaticImage[14]()
            end
            dxDrawImage(x - lsx / 2, y - lsy / 2 - 8 * r, lsx, lsy + 16 * r, sightlangStaticImage[14], 0, 0, 0, tocolor(255, 255, 195))
            ic = 255
          end
          local sx = lsx - (math.abs(row - 2) * 4 + 2) * r
          local sy = lsy - math.abs(row - 2) * 4 * r
          sightlangStaticImageUsed[13] = true
          if sightlangStaticImageToc[13] then
            processsightlangStaticImage[13]()
          end
          dxDrawImageSection(x - sx / 2, y - sy / 2, sx, sy, 44 * (sym - 1), 0, 44, 30, sightlangStaticImage[13], 0, 0, 0, tocolor(ic, ic, ic))
        end
      end
    end
    sightlangStaticImageUsed[15] = true
    if sightlangStaticImageToc[15] then
      processsightlangStaticImage[15]()
    end
    dxDrawImage(x, y, sx, sy, sightlangStaticImage[15], 0, 0, 0, tocolor(255, 255, 255, 255))
    sightlangStaticImageUsed[19] = true
    if sightlangStaticImageToc[19] then
      processsightlangStaticImage[19]()
    end
    sightlangStaticImageUsed[18] = true
    if sightlangStaticImageToc[18] then
      processsightlangStaticImage[18]()
    end
    sightlangStaticImageUsed[17] = true
    if sightlangStaticImageToc[17] then
      processsightlangStaticImage[17]()
    end
    sightlangStaticImageUsed[16] = true
    if sightlangStaticImageToc[16] then
      processsightlangStaticImage[16]()
    end
    local c = 1 == tbl.stake and 255 or 100
    dxDrawImage(x, y, sx, sy, sightlangStaticImage[16], 0, 0, 0, tocolor(c, c, c, 255))
    local c = 2 == tbl.stake and 255 or 100
    dxDrawImage(x, y, sx, sy, sightlangStaticImage[17], 0, 0, 0, tocolor(c, c, c, 255))
    local c = 3 == tbl.stake and 255 or 100
    dxDrawImage(x, y, sx, sy, sightlangStaticImage[18], 0, 0, 0, tocolor(c, c, c, 255))
    local c = 4 == tbl.stake and 255 or 100
    dxDrawImage(x, y, sx, sy, sightlangStaticImage[19], 0, 0, 0, tocolor(c, c, c, 255))
    local riskY = tbl.riskY
    local riskWasY = tbl.riskWasY
    local riskBlink = tbl.riskBlink
    local w = 12.857142857142858 * r
    local tx = x + 386 * r + w / 2
    local s = 20 * r
    local clock = tbl.clockAnim and clockBlinker
    local clockLevel = tbl.clockLevel
    for i = 1, 7 do
      sightlangStaticImageUsed[1] = true
      if sightlangStaticImageToc[1] then
        processsightlangStaticImage[1]()
      end
      dxDrawImageSection(tx - 11 * r, y + 197 * r, s, s, 192, 0, 24, 24, sightlangStaticImage[1], 0, 0, 0, tocolor(80, 0, 0))
      if clock then
        sightlangStaticImageUsed[1] = true
        if sightlangStaticImageToc[1] then
          processsightlangStaticImage[1]()
        end
        dxDrawImageSection(tx - 11 * r, y + 197 * r, s, s, 240, 24 * ((clock - i % 2 * 3) % 6), 24, 24, sightlangStaticImage[1], 0, 0, 0, tocolor(250, 0, 0))
      elseif (not clockAnim or clockLevel < 3 or secondClockBlinker) and tbl.clockText[8 - i] then
        sightlangStaticImageUsed[1] = true
        if sightlangStaticImageToc[1] then
          processsightlangStaticImage[1]()
        end
        dxDrawImageSection(tx - 11 * r, y + 197 * r, s, s, 24 * tbl.clockText[8 - i], 0, 24, 24, sightlangStaticImage[1], 0, 0, 0, tocolor(250, 0, 0))
      end
      tx = tx + w
    end
    local s = 22 * r
    local w = 14.285714285714286 * r
    local tx = x + 487 * r + w / 2
    for i = 1, 7 do
      sightlangStaticImageUsed[1] = true
      if sightlangStaticImageToc[1] then
        processsightlangStaticImage[1]()
      end
      dxDrawImageSection(tx - 11 * r, y + 415 * r, s, s, 192, 0, 24, 24, sightlangStaticImage[1], 0, 0, 0, tocolor(80, 0, 0))
      sightlangStaticImageUsed[1] = true
      if sightlangStaticImageToc[1] then
        processsightlangStaticImage[1]()
      end
      dxDrawImageSection(tx - 11 * r, y + 493 * r, s, s, 192, 0, 24, 24, sightlangStaticImage[1], 0, 0, 0, tocolor(80, 0, 0))
      sightlangStaticImageUsed[1] = true
      if sightlangStaticImageToc[1] then
        processsightlangStaticImage[1]()
      end
      dxDrawImageSection(tx - 11 * r, y + 571 * r, s, s, 192, 0, 24, 24, sightlangStaticImage[1], 0, 0, 0, tocolor(80, 0, 0))
      if tbl.balanceText[8 - i] then
        sightlangStaticImageUsed[1] = true
        if sightlangStaticImageToc[1] then
          processsightlangStaticImage[1]()
        end
        dxDrawImageSection(tx - 11 * r, y + 415 * r, s, s, 24 * tbl.balanceText[8 - i], 0, 24, 24, sightlangStaticImage[1], 0, 0, 0, tocolor(250, 0, 0))
      end
      if riskBlink then
        if riskWasY then
          if tbl.riskTextWas[8 - i] then
            sightlangStaticImageUsed[1] = true
            if sightlangStaticImageToc[1] then
              processsightlangStaticImage[1]()
            end
            dxDrawImageSection(tx - 11 * r, y + 493 * r, s, s, 24 * tbl.riskTextWas[8 - i], riskWasY, 24, 24, sightlangStaticImage[1], 0, 0, 0, tocolor(250, 0, 0))
          end
        elseif tbl.riskText[8 - i] then
          sightlangStaticImageUsed[1] = true
          if sightlangStaticImageToc[1] then
            processsightlangStaticImage[1]()
          end
          dxDrawImageSection(tx - 11 * r, y + 493 * r, s, s, 24 * tbl.riskText[8 - i], riskY, 24, 24, sightlangStaticImage[1], 0, 0, 0, tocolor(250, 0, 0))
        end
      end
      if stakeScreens[tbl.stake][i] then
        sightlangStaticImageUsed[1] = true
        if sightlangStaticImageToc[1] then
          processsightlangStaticImage[1]()
        end
        dxDrawImageSection(tx - 11 * r, y + 571 * r, s, s, 24 * stakeScreens[tbl.stake][i], 0, 24, 24, sightlangStaticImage[1], 0, 0, 0, tocolor(250, 0, 0))
      end
      tx = tx + w
    end
    sightlangStaticImageUsed[24] = true
    if sightlangStaticImageToc[24] then
      processsightlangStaticImage[24]()
    end
    sightlangStaticImageUsed[23] = true
    if sightlangStaticImageToc[23] then
      processsightlangStaticImage[23]()
    end
    sightlangStaticImageUsed[22] = true
    if sightlangStaticImageToc[22] then
      processsightlangStaticImage[22]()
    end
    sightlangStaticImageUsed[21] = true
    if sightlangStaticImageToc[21] then
      processsightlangStaticImage[21]()
    end
    sightlangStaticImageUsed[20] = true
    if sightlangStaticImageToc[20] then
      processsightlangStaticImage[20]()
    end
    if wl == 1 and (not risk or risk == 2 or tbl.lastRisk) or tbl.clockLine == 1 and secondClockBlinker then
      c = 255
    else
      c = rNum and 255 or 100
    end
    dxDrawImage(x, y, sx, sy, sightlangStaticImage[20], 0, 0, 0, tocolor(c, c, c))
    if wl == 2 and (not risk or risk == 2 or tbl.lastRisk) or tbl.clockLine == 2 and secondClockBlinker then
      c = 255
    else
      c = rNum and 255 or 100
    end
    dxDrawImage(x, y, sx, sy, sightlangStaticImage[21], 0, 0, 0, tocolor(c, c, c))
    if wl == 3 and (not risk or risk == 2 or tbl.lastRisk) or tbl.clockLine == 3 and secondClockBlinker then
      c = 255
    else
      c = rNum and 255 or 100
    end
    dxDrawImage(x, y, sx, sy, sightlangStaticImage[22], 0, 0, 0, tocolor(c, c, c))
    if wl == 4 and (not risk or risk == 2 or tbl.lastRisk) or tbl.clockLine == 4 and secondClockBlinker then
      c = 255
    else
      c = rNum and 255 or 100
    end
    dxDrawImage(x, y, sx, sy, sightlangStaticImage[23], 0, 0, 0, tocolor(c, c, c))
    if wl == 5 and (not risk or risk == 2 or tbl.lastRisk) or tbl.clockLine == 5 and secondClockBlinker then
      c = 255
    else
      c = rNum and 255 or 100
    end
    dxDrawImage(x, y, sx, sy, sightlangStaticImage[24], 0, 0, 0, tocolor(c, c, c))
    c = 255
    if clockAnim and 3 <= clockLevel and not secondClockBlinker then
      c = 100
    end
    sightlangStaticImageUsed[25] = true
    if sightlangStaticImageToc[25] then
      processsightlangStaticImage[25]()
    end
    dxDrawImage(x, y, sx, sy, sightlangStaticImage[25], 0, 0, 0, tocolor(c, c, c))
    sightlangStaticImageUsed[28] = true
    if sightlangStaticImageToc[28] then
      processsightlangStaticImage[28]()
    end
    sightlangStaticImageUsed[27] = true
    if sightlangStaticImageToc[27] then
      processsightlangStaticImage[27]()
    end
    sightlangStaticImageUsed[26] = true
    if sightlangStaticImageToc[26] then
      processsightlangStaticImage[26]()
    end
    c = 1 <= clockLevel and 255 or 100
    if clockAnim and (3 <= clockLevel or clockLevel == 1) then
      c = secondClockBlinker and 255 or 100
    end
    dxDrawImage(x, y, sx, sy, sightlangStaticImage[26], 0, 0, 0, tocolor(c, c, c))
    c = 2 <= clockLevel and 255 or 100
    if clockAnim and (3 <= clockLevel or clockLevel == 2) then
      c = secondClockBlinker and 255 or 100
    end
    dxDrawImage(x, y, sx, sy, sightlangStaticImage[27], 0, 0, 0, tocolor(c, c, c))
    c = 3 <= clockLevel and 255 or 100
    if clockAnim and (3 <= clockLevel or clockLevel == 3) then
      c = secondClockBlinker and 255 or 100
    end
    dxDrawImage(x, y, sx, sy, sightlangStaticImage[28], 0, 0, 0, tocolor(c, c, c))
    if tbl.diceSpin then
      local p = diceFlasher
      sightlangStaticImageUsed[34] = true
      if sightlangStaticImageToc[34] then
        processsightlangStaticImage[34]()
      end
      sightlangStaticImageUsed[33] = true
      if sightlangStaticImageToc[33] then
        processsightlangStaticImage[33]()
      end
      sightlangStaticImageUsed[32] = true
      if sightlangStaticImageToc[32] then
        processsightlangStaticImage[32]()
      end
      sightlangStaticImageUsed[31] = true
      if sightlangStaticImageToc[31] then
        processsightlangStaticImage[31]()
      end
      sightlangStaticImageUsed[30] = true
      if sightlangStaticImageToc[30] then
        processsightlangStaticImage[30]()
      end
      sightlangStaticImageUsed[29] = true
      if sightlangStaticImageToc[29] then
        processsightlangStaticImage[29]()
      end
      c = 1 <= p and 1 > p - 6 and 255 or 90
      dxDrawImage(x, y, sx, sy, sightlangStaticImage[29], 0, 0, 0, tocolor(c, c, c))
      c = 2 <= p and 2 > p - 6 and 255 or 90
      dxDrawImage(x, y, sx, sy, sightlangStaticImage[30], 0, 0, 0, tocolor(c, c, c))
      c = 3 <= p and 3 > p - 6 and 255 or 90
      dxDrawImage(x, y, sx, sy, sightlangStaticImage[31], 0, 0, 0, tocolor(c, c, c))
      c = 4 <= p and 4 > p - 6 and 255 or 90
      dxDrawImage(x, y, sx, sy, sightlangStaticImage[32], 0, 0, 0, tocolor(c, c, c))
      c = 5 <= p and 5 > p - 6 and 255 or 90
      dxDrawImage(x, y, sx, sy, sightlangStaticImage[33], 0, 0, 0, tocolor(c, c, c))
      c = 6 <= p and p - 6 < 6 and 255 or 90
      dxDrawImage(x, y, sx, sy, sightlangStaticImage[34], 0, 0, 0, tocolor(c, c, c))
    else
      sightlangStaticImageUsed[34] = true
      if sightlangStaticImageToc[34] then
        processsightlangStaticImage[34]()
      end
      sightlangStaticImageUsed[33] = true
      if sightlangStaticImageToc[33] then
        processsightlangStaticImage[33]()
      end
      sightlangStaticImageUsed[32] = true
      if sightlangStaticImageToc[32] then
        processsightlangStaticImage[32]()
      end
      sightlangStaticImageUsed[31] = true
      if sightlangStaticImageToc[31] then
        processsightlangStaticImage[31]()
      end
      sightlangStaticImageUsed[30] = true
      if sightlangStaticImageToc[30] then
        processsightlangStaticImage[30]()
      end
      sightlangStaticImageUsed[29] = true
      if sightlangStaticImageToc[29] then
        processsightlangStaticImage[29]()
      end
      if not rNum and 1 == tbl.diceRounds and not risk and not tbl.newBalance and not wl and not tbl.diceResult then
        c = diceBlinker and 255 or 90
      else
        c = 1 <= tbl.diceRounds and 255 or 90
      end
      dxDrawImage(x, y, sx, sy, sightlangStaticImage[29], 0, 0, 0, tocolor(c, c, c))
      if not rNum and 2 == tbl.diceRounds and not risk and not tbl.newBalance and not wl and not tbl.diceResult then
        c = diceBlinker and 255 or 90
      else
        c = 2 <= tbl.diceRounds and 255 or 90
      end
      dxDrawImage(x, y, sx, sy, sightlangStaticImage[30], 0, 0, 0, tocolor(c, c, c))
      if not rNum and 3 == tbl.diceRounds and not risk and not tbl.newBalance and not wl and not tbl.diceResult then
        c = diceBlinker and 255 or 90
      else
        c = 3 <= tbl.diceRounds and 255 or 90
      end
      dxDrawImage(x, y, sx, sy, sightlangStaticImage[31], 0, 0, 0, tocolor(c, c, c))
      if not rNum and 4 == tbl.diceRounds and not risk and not tbl.newBalance and not wl and not tbl.diceResult then
        c = diceBlinker and 255 or 90
      else
        c = 4 <= tbl.diceRounds and 255 or 90
      end
      dxDrawImage(x, y, sx, sy, sightlangStaticImage[32], 0, 0, 0, tocolor(c, c, c))
      if not rNum and 5 == tbl.diceRounds and not risk and not tbl.newBalance and not wl and not tbl.diceResult then
        c = diceBlinker and 255 or 90
      else
        c = 5 <= tbl.diceRounds and 255 or 90
      end
      dxDrawImage(x, y, sx, sy, sightlangStaticImage[33], 0, 0, 0, tocolor(c, c, c))
      if not rNum and 6 == tbl.diceRounds and not risk and not tbl.newBalance and not wl and not tbl.diceResult then
        c = diceBlinker and 255 or 90
      else
        c = 6 <= tbl.diceRounds and 255 or 90
      end
      dxDrawImage(x, y, sx, sy, sightlangStaticImage[34], 0, 0, 0, tocolor(c, c, c))
    end
    c = tbl.diceSpin and 255 or 120
    sightlangStaticImageUsed[35] = true
    if sightlangStaticImageToc[35] then
      processsightlangStaticImage[35]()
    end
    dxDrawImage(x, y, sx, sy, sightlangStaticImage[35], 0, 0, 0, tocolor(c, c, c))
    if risk then
      sightlangStaticImageUsed[36] = true
      if sightlangStaticImageToc[36] then
        processsightlangStaticImage[36]()
      end
      dxDrawImage(x, y, sx, sy, sightlangStaticImage[36], 0, 0, 0, tocolor(255, 255, 255))
      c = risk == 1 and 255 or 80
      sightlangStaticImageUsed[37] = true
      if sightlangStaticImageToc[37] then
        processsightlangStaticImage[37]()
      end
      dxDrawImage(x, y, sx, sy, sightlangStaticImage[37], 0, 0, 0, tocolor(c, c, c))
      c = risk == 2 and 255 or 80
      sightlangStaticImageUsed[38] = true
      if sightlangStaticImageToc[38] then
        processsightlangStaticImage[38]()
      end
      dxDrawImage(x, y, sx, sy, sightlangStaticImage[38], 0, 0, 0, tocolor(c, c, c))
    else
      sightlangStaticImageUsed[36] = true
      if sightlangStaticImageToc[36] then
        processsightlangStaticImage[36]()
      end
      dxDrawImage(x, y, sx, sy, sightlangStaticImage[36], 0, 0, 0, tocolor(100, 100, 100))
      sightlangStaticImageUsed[37] = true
      if sightlangStaticImageToc[37] then
        processsightlangStaticImage[37]()
      end
      dxDrawImage(x, y, sx, sy, sightlangStaticImage[37], 0, 0, 0, tocolor(80, 80, 80))
      sightlangStaticImageUsed[38] = true
      if sightlangStaticImageToc[38] then
        processsightlangStaticImage[38]()
      end
      dxDrawImage(x, y, sx, sy, sightlangStaticImage[38], 0, 0, 0, tocolor(80, 80, 80))
    end
    local btnY = 3 * r
    local hold = false
    local h = not rNum and tbl.hold[1] and not tbl.holdTime[1]
    if h then
      hold = true
    end
    c = h and 255 or 120
    sightlangStaticImageUsed[39] = true
    if sightlangStaticImageToc[39] then
      processsightlangStaticImage[39]()
    end
    dxDrawImage(x, y + ((getKeyState("a") or clickedButton == 2) and btnY or 0), sx, sy, sightlangStaticImage[39], 0, 0, 0, tocolor(c, c, c))
    local h = not rNum and tbl.hold[2] and not tbl.holdTime[2]
    if h then
      hold = true
    end
    c = h and 255 or 120
    sightlangStaticImageUsed[40] = true
    if sightlangStaticImageToc[40] then
      processsightlangStaticImage[40]()
    end
    dxDrawImage(x, y + ((getKeyState("s") or clickedButton == 3) and btnY or 0), sx, sy, sightlangStaticImage[40], 0, 0, 0, tocolor(c, c, c))
    local h = not rNum and tbl.hold[3] and not tbl.holdTime[3]
    if h then
      hold = true
    end
    c = h and 255 or 120
    sightlangStaticImageUsed[41] = true
    if sightlangStaticImageToc[41] then
      processsightlangStaticImage[41]()
    end
    dxDrawImage(x, y + ((getKeyState("d") or clickedButton == 4) and btnY or 0), sx, sy, sightlangStaticImage[41], 0, 0, 0, tocolor(c, c, c))
    c = (risk or hold) and 255 or 120
    sightlangStaticImageUsed[42] = true
    if sightlangStaticImageToc[42] then
      processsightlangStaticImage[42]()
    end
    dxDrawImage(x, y + ((getKeyState("lshift") or clickedButton == 1) and btnY or 0), sx, sy, sightlangStaticImage[42], 0, 0, 0, tocolor(c, c, c))
    local canPayIn = false
    if not rNum and not tbl.winSound and not tbl.holdTime[1] and not tbl.holdTime[2] and not tbl.holdTime[3] and not tbl.dice and not tbl.diceResult then
      c = 255
      canPayIn = true
    else
      c = 120
    end
    local sc = c
    if risk then
      sc = risk == 2 and 255 or 120
    elseif now - lastStake < 400 then
      sc = 120
    end
    sightlangStaticImageUsed[43] = true
    if sightlangStaticImageToc[43] then
      processsightlangStaticImage[43]()
    end
    dxDrawImage(x, y + ((getKeyState("lctrl") or clickedButton == 5) and btnY or 0), sx, sy, sightlangStaticImage[43], 0, 0, 0, tocolor(sc, sc, sc))
    local pc = c
    if tbl.diceSpin then
      c = tbl.diceSpin and not tbl.diceResult and 255 or 120
    elseif risk then
      c = risk == 1 and 255 or 120
      pc = 120
      canPayIn = false
    elseif not tbl.diceRot and tbl.rNum == tbl.startedNum and not tbl.handHold then
      c = 255
      for col = 1, 3 do
        if tbl.rotating[col] and 1 > tbl.rotating[col] then
          c = 120
          break
        end
      end
    end
    sightlangStaticImageUsed[44] = true
    if sightlangStaticImageToc[44] then
      processsightlangStaticImage[44]()
    end
    dxDrawImage(x, y + ((getKeyState("space") or clickedButton == 6) and btnY or 0), sx, sy, sightlangStaticImage[44], 0, 0, 0, tocolor(c, c, c))
    sightlangStaticImageUsed[45] = true
    if sightlangStaticImageToc[45] then
      processsightlangStaticImage[45]()
    end
    dxDrawImage(x, y, sx, sy, sightlangStaticImage[45])
    sightlangStaticImageUsed[46] = true
    if sightlangStaticImageToc[46] then
      processsightlangStaticImage[46]()
    end
    dxDrawImage(x, y, sx, sy, sightlangStaticImage[46], 0, 0, 0, tocolor(255, 255, 255, 175))
    if canPayIn and 0 >= tbl.balance and not payInWindow and not tbl.newBalance then
      createPayInWindow()
    end
    if clickedButton == 7 then
      sightlangStaticImageUsed[47] = true
      if sightlangStaticImageToc[47] then
        processsightlangStaticImage[47]()
      end
      dxDrawImage(x, y, sx, sy, sightlangStaticImage[47], 0, 0, 0, tocolor(pc, pc, pc, 255))
    else
      sightlangStaticImageUsed[48] = true
      if sightlangStaticImageToc[48] then
        processsightlangStaticImage[48]()
      end
      dxDrawImage(x, y, sx, sy, sightlangStaticImage[48], 0, 0, 0, tocolor(pc, pc, pc, 255))
    end
    if cx and not payInWindow then
      cx = cx * screenX
      cy = cy * screenY
      if cy >= y + 111 * r and cy <= y + 147 * r and cx >= x + 555 * r and cx <= x + 591 * r then
        tmp = 7
      elseif cy >= y + 209 * r and cy <= y + 254 * r and cx >= x + 547 * r and cx <= x + 601 * r then
        tmp = 8
      elseif cy >= y + 668 * r and cy <= y + 804 * r and cx >= x + 78 * r and cx <= x + 282 * r then
        tmp = 9
        local x, y = x + sx / 2 - 900 * r / 2, y + sy / 2 - 610 * r / 2
        sightlangStaticImageUsed[49] = true
        if sightlangStaticImageToc[49] then
          processsightlangStaticImage[49]()
        end
        dxDrawImage(x, y, 900, 610, sightlangStaticImage[49], 0, 0, 0, tocolor(255, 255, 255, 255))
        sightlangStaticImageUsed[53] = true
        if sightlangStaticImageToc[53] then
          processsightlangStaticImage[53]()
        end
        sightlangStaticImageUsed[52] = true
        if sightlangStaticImageToc[52] then
          processsightlangStaticImage[52]()
        end
        sightlangStaticImageUsed[51] = true
        if sightlangStaticImageToc[51] then
          processsightlangStaticImage[51]()
        end
        sightlangStaticImageUsed[50] = true
        if sightlangStaticImageToc[50] then
          processsightlangStaticImage[50]()
        end
        local c = 1 == tbl.stake and 255 or 100
        dxDrawImage(x, y, 900, 610, sightlangStaticImage[50], 0, 0, 0, tocolor(c, c, c, 255))
        local c = 2 == tbl.stake and 255 or 100
        dxDrawImage(x, y, 900, 610, sightlangStaticImage[51], 0, 0, 0, tocolor(c, c, c, 255))
        local c = 3 == tbl.stake and 255 or 100
        dxDrawImage(x, y, 900, 610, sightlangStaticImage[52], 0, 0, 0, tocolor(c, c, c, 255))
        local c = 4 == tbl.stake and 255 or 100
        dxDrawImage(x, y, 900, 610, sightlangStaticImage[53], 0, 0, 0, tocolor(c, c, c, 255))
      elseif cy >= y + 811 * r and cy <= y + 842 * r then
        if cx >= x + 67 * r and cx <= x + 109 * r then
          tmp = 1
        elseif cx >= x + 136 * r and cx <= x + 177 * r then
          tmp = 2
        elseif cx >= x + 205 * r and cx <= x + 246 * r then
          tmp = 3
        elseif cx >= x + 274 * r and cx <= x + 314 * r then
          tmp = 4
        elseif cx >= x + 496 * r and cx <= x + 537 * r then
          tmp = 5
        elseif cx >= x + 569 * r and cx <= x + 610 * r then
          tmp = 6
        end
      end
    end
  end
  if tmp ~= hoverButton then
    hoverButton = tmp
    sightexports.sGui:setCursorType(tmp and "link" or "normal")
    if tmp == 1 then
      sightexports.sGui:showTooltip(sightexports.sGui:getColorCodeHex("sightorange") .. "Nyeremény felírása\n" .. sightexports.sGui:getColorCodeHex("sightred") .. "Tartás törlése\nGyorsgomb: " .. sightexports.sGui:getColorCodeHex("sightlightgrey") .. "SHIFT")
    elseif tmp == 2 then
      sightexports.sGui:showTooltip(sightexports.sGui:getColorCodeHex("sightred") .. "Oszlop tartása\nGyorsgomb: " .. sightexports.sGui:getColorCodeHex("sightlightgrey") .. "A")
    elseif tmp == 3 then
      sightexports.sGui:showTooltip(sightexports.sGui:getColorCodeHex("sightred") .. "Oszlop tartása\nGyorsgomb: " .. sightexports.sGui:getColorCodeHex("sightlightgrey") .. "S")
    elseif tmp == 4 then
      sightexports.sGui:showTooltip(sightexports.sGui:getColorCodeHex("sightred") .. "Oszlop tartása\nGyorsgomb: " .. sightexports.sGui:getColorCodeHex("sightlightgrey") .. "D")
    elseif tmp == 5 then
      sightexports.sGui:showTooltip(sightexports.sGui:getColorCodeHex("sightorange") .. "Tét kiválasztása\nRizikó " .. sightexports.sGui:getColorCodeHex("sightred") .. "szív#ffffff\nGyorsgomb: " .. sightexports.sGui:getColorCodeHex("sightlightgrey") .. "CTRL")
    elseif tmp == 6 then
      sightexports.sGui:showTooltip(sightexports.sGui:getColorCodeHex("sightgreen") .. "Start\nRizikó " .. sightexports.sGui:getColorCodeHex("sightblue") .. [[
pikk#ffffff
Gyorsgomb: ]] .. sightexports.sGui:getColorCodeHex("sightlightgrey") .. "SPACE")
    elseif tmp == 7 then
      sightexports.sGui:showTooltip("Kifizetés és felállás")
    elseif tmp == 8 then
      sightexports.sGui:showTooltip("Befizetés")
    else
      sightexports.sGui:showTooltip(false)
    end
    if clickedButton then
      clickedButton = false
      playSound("files/sound/btnup.mp3")
    end
  end
end
function btnHandler(btn)
  local tbl = diceData[myMachine]
  if not payInWindow then
    if tbl.rNum > 0 then
      if btn == 6 and tbl.rNum == tbl.startedNum and not tbl.diceRot and 0 >= tbl.diceRounds and not tbl.handHold then
        for col = 1, 3 do
          if tbl.rotating[col] and 1 > tbl.rotating[col] then
            return
          end
        end
        triggerServerEvent("tryToStopSeeDice", localPlayer)
        tbl.handHold = true
      end
    elseif not tbl.winSound and not tbl.holdTime[1] and not tbl.holdTime[2] and not tbl.holdTime[3] and not tbl.lastRisk and not tbl.newBalance and not tbl.diceCol and not tbl.diceResult and not tbl.clockLevelAnim and not tbl.lastRisk then
      if tbl.diceSpin then
        if btn == 6 then
          triggerServerEvent("tryToStopSeeDiceRoll", localPlayer)
        end
      elseif btn == 2 then
        if not tbl.disableHold and getTickCount() - lastHold > 100 then
          triggerServerEvent("tryToHoldSeeDice", localPlayer, 1)
          lastHold = getTickCount()
        end
      elseif btn == 3 then
        if not tbl.disableHold and getTickCount() - lastHold > 100 then
          triggerServerEvent("tryToHoldSeeDice", localPlayer, 2)
          lastHold = getTickCount()
        end
      elseif btn == 4 then
        if not tbl.disableHold and getTickCount() - lastHold > 100 then
          triggerServerEvent("tryToHoldSeeDice", localPlayer, 3)
          lastHold = getTickCount()
        end
      elseif btn == 1 then
        if tbl.riskValue then
          triggerServerEvent("tryToCollectSeeDice", localPlayer)
        elseif not tbl.disableHold and getTickCount() - lastHold > 100 and (tbl.hold[1] or tbl.hold[2] or tbl.hold[3]) then
          triggerServerEvent("tryToHoldSeeDice", localPlayer)
          lastHold = getTickCount()
        end
      elseif btn == 5 then
        if tbl.riskValue then
          triggerServerEvent("tryToGambleSeeDice", localPlayer, 2)
        elseif 0 >= tbl.diceRounds and getTickCount() - lastStake > 400 then
          triggerServerEvent("tryToSetSeeDiceStake", localPlayer)
          lastStake = getTickCount()
        end
      elseif btn == 6 then
        if tbl.riskValue then
          triggerServerEvent("tryToGambleSeeDice", localPlayer, 1)
        else
          triggerServerEvent("tryToRotateSeeDice", localPlayer)
        end
      elseif btn == 7 and not tbl.riskValue then
        triggerServerEvent("tryToExitSeeDice", localPlayer)
      end
    end
  end
end
function clickMyMachine(btn, state)
  if state == "up" then
    if clickedButton then
      if clickedButton == 1 then
        if not getKeyState("lshift") then
          playSound("files/sound/btnup.mp3")
        end
      elseif clickedButton == 2 then
        if not getKeyState("a") then
          playSound("files/sound/btnup.mp3")
        end
      elseif clickedButton == 3 then
        if not getKeyState("s") then
          playSound("files/sound/btnup.mp3")
        end
      elseif clickedButton == 4 then
        if not getKeyState("d") then
          playSound("files/sound/btnup.mp3")
        end
      elseif clickedButton == 5 then
        if not getKeyState("lctrl") then
          playSound("files/sound/btnup.mp3")
        end
      elseif clickedButton == 6 then
        if not getKeyState("space") then
          playSound("files/sound/btnup.mp3")
        end
      elseif clickedButton == 7 then
        playSound("files/sound/btnup.mp3")
      end
      clickedButton = false
    end
  elseif hoverButton == 8 then
    local tbl = diceData[myMachine]
    if tbl.balance >= 1000000 then
      sightexports.sGui:showInfobox("e", "Maximum 1 000 000 SSC egyenlegig tudsz befizetni.")
      return
    end
    createPayInWindow()
  elseif hoverButton and hoverButton <= 7 then
    if hoverButton == 1 then
      if getKeyState("lshift") then
        return
      end
    elseif hoverButton == 2 then
      if getKeyState("a") then
        return
      end
    elseif hoverButton == 3 then
      if getKeyState("s") then
        return
      end
    elseif hoverButton == 4 then
      if getKeyState("d") then
        return
      end
    elseif hoverButton == 5 then
      if getKeyState("lctrl") then
        return
      end
    elseif hoverButton == 6 and getKeyState("space") then
      return
    end
    clickedButton = hoverButton
    btnHandler(hoverButton)
  end
end
function keyMyMachine(btn, state)
  if not sightexports.sGui:getActiveInput() and not isChatBoxInputActive() and not isConsoleActive() then
    if btn == "lshift" then
      btn = 1
    elseif btn == "a" then
      btn = 2
    elseif btn == "s" then
      btn = 3
    elseif btn == "d" then
      btn = 4
    elseif btn == "lctrl" then
      btn = 5
    elseif btn == "space" then
      btn = 6
    else
      btn = false
    end
    if btn then
      cancelEvent()
      if clickedButton ~= btn then
        if state then
          playSound("files/sound/btndown.mp3")
          btnHandler(btn)
        else
          playSound("files/sound/btnup.mp3")
        end
      end
    end
  end
end
function autoKocka()
  local tbl = diceData[myMachine]
  if tbl.rNum <= 0 and not tbl.winSound and not tbl.holdTime[1] and not tbl.holdTime[2] and not tbl.holdTime[3] and not tbl.lastRisk and not tbl.newBalance and not tbl.diceCol and not tbl.diceResult then
    if tbl.diceSpin then
      triggerServerEvent("tryToStopSeeDiceRoll", localPlayer)
    elseif tbl.riskValue then
      triggerServerEvent("tryToCollectSeeDice", localPlayer)
    else
      triggerServerEvent("tryToRotateSeeDice", localPlayer)
    end
  end
end
local kockaTimer = false
function loadModelIds()
  local objs = {}
  for i = 1, #machineGroups do
    objs[i] = createObject(sightexports.sModloader:getModelId("seedice"), machineGroups[i][1], machineGroups[i][2], machineGroups[i][3], 0, 0, machineGroups[i][4])
    setElementInterior(objs[i], machineGroups[i][5])
    setElementDimension(objs[i], machineGroups[i][6])
  end
  triggerServerEvent("requestDiceMachines", localPlayer)
  for i = 1, #diceMachineCoordinates do
    local x, y, z, rz, int, dim, sin, cos, mgroup = unpack(diceMachineCoordinates[i])
    diceGraphMachines[i] = {}
    for graph, val in pairs(diceGraphs) do
      if graph == "dice" or graph == "risk" or graph == "clockseg" or graph == "staketop" or graph == "stake" or graph == "bank" then
        diceGraphMachines[i][graph] = {}
        for j = 1, #val do
          local iy, iz, w, h, sunk = unpack(val[j])
          local x = x + sunk * cos
          local y = y + sunk * sin
          local z = z + iz
          x = x - iy * sin
          y = y + iy * cos
          diceGraphMachines[i][graph][j] = {
            x,
            y,
            z,
            h,
            w
          }
        end
      else
        local iy, iz, w, h, sunk = unpack(val)
        local x = x + sunk * cos
        local y = y + sunk * sin
        local z = z + iz
        x = x - iy * sin
        y = y + iy * cos
        diceGraphMachines[i][graph] = {
          x,
          y,
          z,
          h,
          w
        }
      end
    end
    machineBtnCoords[i] = {}
    local nx, ny, nz = 0.71546 * cos, 0.71546 * sin, 0.698654
    for btn = 1, #btnCoords do
      machineBtnCoords[i][btn] = {
        x + cos * btnCoords[btn][1] - sin * btnCoords[btn][2],
        y + sin * btnCoords[btn][1] + cos * btnCoords[btn][2],
        z + btnCoords[btn][3],
        x + cos * btnCoords[btn][4] - sin * btnCoords[btn][5],
        y + sin * btnCoords[btn][4] + cos * btnCoords[btn][5],
        z + btnCoords[btn][6],
        x + cos * (btnCoords[btn][1] + btnCoords[btn][4]) / 2 - sin * (btnCoords[btn][2] + btnCoords[btn][5]) / 2 + nx,
        y + sin * (btnCoords[btn][1] + btnCoords[btn][4]) / 2 + cos * (btnCoords[btn][2] + btnCoords[btn][5]) / 2 + ny,
        z + (btnCoords[btn][3] + btnCoords[btn][6]) / 2 + nz
      }
    end
    local tbl = {}
    tbl.seat = {
      x + cos * 0.85,
      y + sin * 0.85,
      z + 1.2
    }
    local n = utf8.len(tostring(i))
    local h = 0.1
    local w = 0.075
    local sx = w * (n - 1) / 2
    tbl.idsBadge = {}
    for j = 1, n do
      table.insert(tbl.idsBadge, {
        x - sx * sin + 0.333883 * cos,
        y + sx * cos + 0.333883 * sin,
        z + 0.33,
        math.floor(i / math.pow(10, j - 1)) % 10 * 24
      })
      sx = sx - w
    end
    tbl.stakeBottomCoords = {
      x + cos * 0.2021 + sin * 0.1909,
      y + sin * 0.2021 - cos * 0.1909,
      z + 1.2046,
      x + cos * 0.3603 + sin * 0.1909,
      y + sin * 0.3603 - cos * 0.1909,
      z + 1.0692,
      x + cos * 0.931549 + sin * 0.1909,
      y + sin * 0.931549 - cos * 0.1909,
      z + 1.1368999999999998 + 0.759635
    }
    tbl.riskBottomCords = {
      x + cos * 0.2021 - sin * 0.2533,
      y + sin * 0.2021 + cos * 0.2533,
      z + 1.2046,
      x + cos * 0.3603 - sin * 0.2533,
      y + sin * 0.3603 + cos * 0.2533,
      z + 1.0692,
      x + cos * 0.931549 - sin * 0.2533,
      y + sin * 0.931549 + cos * 0.2533,
      z + 1.1368999999999998 + 0.759635
    }
    tbl.reels = {}
    for col = 1, 3 do
      tbl.reels[col] = math.random(0, #reels[col] - 3)
    end
    tbl.rNum = 0
    tbl.obj = objs[mgroup]
    tbl.rotating = {
      false,
      false,
      false
    }
    tbl.preEndRotation = {
      false,
      false,
      false
    }
    tbl.endRotation = {
      false,
      false,
      false
    }
    tbl.rotations = {
      0,
      0,
      0
    }
    tbl.riskText = {}
    tbl.riskTextWas = {}
    tbl.balanceText = {}
    tbl.clockText = {}
    tbl.lastDice = 6
    tbl.stake = 1
    tbl.diceRounds = 0
    tbl.clockLevel = 0
    tbl.disableHold = true
    tbl.balance = 0
    convertBalanceText(tbl.balance, tbl.balanceText)
    tbl.tmpSymbols = {}
    tbl.hold = {}
    tbl.holdSymbols = {}
    tbl.holdTheSymbols = {}
    tbl.holdTime = {}
    for col = 1, 3 do
      tbl.tmpSymbols[col] = {}
      tbl.holdSymbols[col] = {}
      for row = 1, 4 do
        tbl.tmpSymbols[col][row] = randomFillSymbol()
      end
    end
    diceData[i] = tbl
  end
end
addEvent("streamInSeeDices", true)
addEventHandler("streamInSeeDices", getRootElement(), function(data)
  if #streamedInMachines <= 0 then
    addEventHandler("onClientPreRender", getRootElement(), preRenderDiceMachines)
    addEventHandler("onClientRender", getRootElement(), renderSeatIcons)
    addEventHandler("onClientClick", getRootElement(), clickSeatIcons)
  end
  local now = getTickCount()
  for id, dat in pairs(data) do
    local tbl = diceData[id]
    for i = 1, 3 do
      tbl.rotating[i] = false
      tbl.hold[i] = false
      tbl.holdTime[i] = false
    end
    tbl.clockLevel = 0
    tbl.dice = false
    tbl.diceRot = false
    tbl.riskValue = false
    tbl.win = false
    tbl.winSymbols = false
    for k, v in pairs(dat) do
      tbl[k] = v
    end
    tbl.riskCollect = false
    tbl.newClockLevel = false
    tbl.clockLine = false
    tbl.clockAnim = false
    if tbl.clockBalance then
      convertBalanceText(tbl.clockBalance, tbl.clockText)
    else
      for i = 1, #tbl.clockText do
        tbl.clockText[i] = nil
      end
    end
    convertBalanceText(tbl.balance, tbl.balanceText)
    for i = 1, #tbl.riskTextWas do
      tbl.riskTextWas[i] = nil
    end
    if tbl.riskValue then
      convertBalanceText(tbl.riskValue, tbl.riskText)
    else
      for i = 1, #tbl.riskText do
        tbl.riskText[i] = nil
      end
    end
    tbl.rNum = 0
    for i = 1, 3 do
      if tbl.rotating[i] then
        tbl.rNum = tbl.rNum + 1
        tbl.startedNum = tbl.startedNum + 1
        tbl.rotating[i] = 0
        tbl.preEndRotation[i] = false
        tbl.endRotation[i] = false
        tbl.rotations[i] = 0
        tbl.tmpSymbols[i][1] = randomFillSymbol()
        for row = 2, 4 do
          tbl.tmpSymbols[i][row] = reels[i][tbl.reels[i] + row - 1]
        end
      else
        tbl.rotating[i] = false
      end
    end
    if tbl.dice and 0 >= tbl.rNum then
      tbl.dice = now - 1750
      if not tbl.diceSound then
        tbl.diceSound = playMachineSound(id, "diceloop", true)
        tbl.diceCol = false
        tbl.diceSpin = tbl.lastDice
      end
    end
    tbl.riskTmp = 0
    tbl.riskWasY = false
    tbl.newBalance = false
    tbl.wl = false
    tbl.risk = false
    tbl.lastRisk = false
    tbl.riskAnim = false
    tbl.winSound = tbl.win and 0 or false
    tbl.endTime = false
    tbl.riskCollect = false
    tbl.ended = false
    if tbl.player then
      local j = diceMachineCoordinates[id][10]
      attachElements(tbl.player, tbl.obj, 0.85, j * 1, 1.2)
    end
    if 0 < tbl.rNum then
      if not tbl.loopSound and not tbl.diceRot then
        tbl.loopSound = playMachineSound(id, "loop", true)
      end
      tbl.loopVol = 1
    end
    table.insert(streamedInMachines, id)
    tbl.canStopDice = false
  end
  collectgarbage("collect")
end)
addEvent("streamOutSeeDices", true)
addEventHandler("streamOutSeeDices", getRootElement(), function()
  if myMachine then
    detachElements(localPlayer, diceData[myMachine].obj)
    removeEventHandler("onClientClick", getRootElement(), clickMyMachine)
    removeEventHandler("onClientKey", getRootElement(), keyMyMachine)
    removeEventHandler("onClientRender", getRootElement(), renderMyMachine)
  else
    if 0 < #streamedInMachines then
      removeEventHandler("onClientRender", getRootElement(), renderSeatIcons)
      removeEventHandler("onClientClick", getRootElement(), clickSeatIcons)
    end
    sightexports.sGui:setCursorType("normal")
    sightexports.sGui:showTooltip()
  end
  myMachine = false
  if 0 < #streamedInMachines then
    removeEventHandler("onClientPreRender", getRootElement(), preRenderDiceMachines)
  end
  for i = 1, #streamedInMachines do
    local id = streamedInMachines[i]
    local tbl = diceData[id]
    if tbl.player then
      detachElements(tbl.player, tbl.obj)
      setPedAnimation(tbl.player)
    end
    tbl.player = nil
    if isElement(tbl.gambleSound) then
      destroyElement(tbl.gambleSound)
    end
    tbl.gambleSound = false
    if isElement(tbl.diceSound) then
      destroyElement(tbl.diceSound)
    end
    tbl.diceSound = false
    if isElement(tbl.loopSound) then
      destroyElement(tbl.loopSound)
    end
    tbl.loopSound = false
    if isElement(tbl.transLoop) then
      destroyElement(tbl.transLoop)
    end
    tbl.transLoop = false
  end
  streamedInMachines = {}
end)
local seatHover = false
function renderSeatIcons()
  local px, py, pz = getElementPosition(localPlayer)
  local cx, cy = getCursorPosition()
  if cx then
    cx = cx * screenX
    cy = cy * screenY
  end
  local tmpSeat = false
  for k = 1, #streamedInMachines do
    local id = streamedInMachines[k]
    local tbl = diceData[id]
    if tbl.onScreen and not tbl.player then
      local x, y, z = tbl.seat[1], tbl.seat[2], tbl.seat[3]
      local d = getDistanceBetweenPoints3D(x, y, z, px, py, pz)
      if d < 7.5 then
        local x, y = getScreenFromWorldPosition(x, y, z, 32)
        if x then
          local a = 255 - d / 7.5 * 255
          if d < 2 and cx and cx >= x - 16 and cx <= x + 16 and cy >= y - 16 and cy <= y + 16 then
            tmpSeat = id
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
  if seatHover ~= tmpSeat then
    seatHover = tmpSeat
    sightexports.sGui:setCursorType(seatHover and "link" or "normal")
    sightexports.sGui:showTooltip(seatHover and "Leülés")
  end
end
function clickSeatIcons(btn, state)
  if state == "up" and seatHover and not myMachine then
    triggerServerEvent("tryToSitDownSeeDice", localPlayer, seatHover)
  end
end
addEvent("gotNewSeeDicePlayer", true)
addEventHandler("gotNewSeeDicePlayer", getRootElement(), function(id, client)
  if client == localPlayer then
    myMachine = id
    minimized = false
    outputChatBox("[color=sightred][SightMTA - SightDice]: #ffffffA játékgépet a /minimizedice paranccsal tudod elrejteni, majd újra előhozni.", 255, 255, 255, true)
    addEventHandler("onClientClick", getRootElement(), clickMyMachine)
    addEventHandler("onClientKey", getRootElement(), keyMyMachine)
    addEventHandler("onClientRender", getRootElement(), renderMyMachine)
    removeEventHandler("onClientRender", getRootElement(), renderSeatIcons)
    removeEventHandler("onClientClick", getRootElement(), clickSeatIcons)
  elseif myMachine == id then
    myMachine = false
    removeEventHandler("onClientClick", getRootElement(), clickMyMachine)
    removeEventHandler("onClientKey", getRootElement(), keyMyMachine)
    removeEventHandler("onClientRender", getRootElement(), renderMyMachine)
    addEventHandler("onClientRender", getRootElement(), renderSeatIcons)
    addEventHandler("onClientClick", getRootElement(), clickSeatIcons)
    deletePayInWindow()
  end
  playMachineSound(id, client and "sit" or "stand")
  sightexports.sGui:setCursorType("normal")
  sightexports.sGui:showTooltip()
  local tbl = diceData[id]
  if client then
    local j = diceMachineCoordinates[id][10]
    attachElements(client, tbl.obj, 0.85, j * 1, 1.2)
    setPedAnimation(client, "int_office", "off_sit_idle_loop", -1, true, false, false, false)
    tbl.player = client
  else
    if tbl.balance > 0 then
      playMachineSound(id, "payout")
    end
    tbl.balance = 0
    convertBalanceText(tbl.balance, tbl.balanceText)
    detachElements(tbl.player, tbl.obj)
    setPedAnimation(tbl.player)
    tbl.player = nil
  end
end)
addEventHandler("onClientResourceStart", getResourceRootElement(), function()
  if getElementData(localPlayer, "loggedIn") then
    triggerServerEvent("requestSSC", localPlayer)
  end
end)
addEvent("refreshSSC", true)
addEventHandler("refreshSSC", getRootElement(), function(amount)
  sscBalance = amount
  if payInWindow then
    refreshPayInAmount()
  end
end)
function refreshPayInAmount()
  local tbl = diceData[myMachine]
  local maxAmount = math.min(sscBalance, 500000, 1000000 - tbl.balance)
  maxAmount = math.max(0, maxAmount - 1000)
  payInAmount = 1000 + math.floor(payInSliderValue * maxAmount / 1000) * 1000
  sightexports.sGui:setLabelText(payInLabel, sightexports.sGui:thousandsStepper(payInAmount) .. " SSC")
end
addEvent("changeSeeDicePayIn", false)
addEventHandler("changeSeeDicePayIn", getRootElement(), function(el, sliderValue, final)
  payInSliderValue = sliderValue
  refreshPayInAmount()
end)
addEvent("closeSeeDicePayIn", false)
addEventHandler("closeSeeDicePayIn", getRootElement(), function(el, sliderValue, final)
  deletePayInWindow()
end)
addEvent("tryToPayInSeeDice", false)
addEventHandler("tryToPayInSeeDice", getRootElement(), function()
  if payInAmount < 1000 then
    sightexports.sGui:showInfobox("e", "Minimum befizethető összeg: 1 000 SSC")
  elseif payInAmount > sscBalance then
    sightexports.sGui:showInfobox("e", "Nincs elég SSC-d a befizetéshez!")
  else
    triggerServerEvent("tryToPayInSeeDice", localPlayer, payInAmount)
  end
end)
addEvent("exitSeeDicePayIn", false)
addEventHandler("exitSeeDicePayIn", getRootElement(), function(el, sliderValue, final)
  triggerServerEvent("tryToExitSeeDice", localPlayer)
end)
function deletePayInWindow()
  if payInWindow then
    sightexports.sGui:deleteGuiElement(payInWindow)
  end
  payInWindow = false
  payInLabel = false
  payInSliderValue = 0
  payInAmount = 0
end
function createPayInWindow()
  sightexports.sGui:setCursorType("normal")
  sightexports.sGui:showTooltip()
  local tbl = diceData[myMachine]
  deletePayInWindow()
  local titleBarHeight = sightexports.sGui:getTitleBarHeight()
  local pw, ph = 350, titleBarHeight + 32 + 15 + 8 + 24 + 8
  if tbl.balance <= 0 then
    ph = ph + 24 + 8
  end
  payInWindow = sightexports.sGui:createGuiElement("window", screenX / 2 - pw / 2, screenY / 2 - ph / 2, pw, ph)
  sightexports.sGui:setWindowTitle(payInWindow, "16/BebasNeueRegular.otf", "Befizetés")
  if tbl.balance > 0 then
    sightexports.sGui:setWindowCloseButton(payInWindow, "closeSeeDicePayIn")
  end
  payInLabel = sightexports.sGui:createGuiElement("label", 0, titleBarHeight, pw, 32, payInWindow)
  sightexports.sGui:setLabelText(payInLabel, sightexports.sGui:thousandsStepper(payInAmount) .. " SSC")
  sightexports.sGui:setLabelColor(payInLabel, "sightyellow")
  sightexports.sGui:setLabelFont(payInLabel, "12/Ubuntu-R.ttf")
  sightexports.sGui:setLabelAlignment(payInLabel, "center", "center")
  local slider = sightexports.sGui:createGuiElement("slider", 8, titleBarHeight + 32, pw - 16, 15, payInWindow)
  sightexports.sGui:setSliderChangeEvent(slider, "changeSeeDicePayIn")
  sightexports.sGui:setSliderValue(slider, 0)
  local btn = sightexports.sGui:createGuiElement("button", 8, titleBarHeight + 32 + 15 + 8, pw - 16, 24, payInWindow)
  sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
  sightexports.sGui:setGuiHover(btn, "gradient", {
    "sightgreen",
    "sightgreen-second"
  }, false, true)
  sightexports.sGui:setButtonFont(btn, "14/BebasNeueBold.otf")
  sightexports.sGui:setButtonTextColor(btn, "#ffffff")
  sightexports.sGui:setButtonText(btn, "Befizetés")
  sightexports.sGui:setClickEvent(btn, "tryToPayInSeeDice")
  if tbl.balance <= 0 then
    local btn = sightexports.sGui:createGuiElement("button", 8, titleBarHeight + 32 + 15 + 8 + 24 + 8, pw - 16, 24, payInWindow)
    sightexports.sGui:setGuiBackground(btn, "solid", "sightred")
    sightexports.sGui:setGuiHover(btn, "gradient", {
      "sightred",
      "sightred-second"
    }, false, true)
    sightexports.sGui:setButtonFont(btn, "14/BebasNeueBold.otf")
    sightexports.sGui:setButtonTextColor(btn, "#ffffff")
    sightexports.sGui:setButtonText(btn, "Kiszállok")
    sightexports.sGui:setClickEvent(btn, "exitSeeDicePayIn")
  end
  refreshPayInAmount()
end
