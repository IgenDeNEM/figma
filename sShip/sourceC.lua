local sightexports = {sGui = false}
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
  if sightlangStaticImageToc[0] and sightlangStaticImageToc[1] and sightlangStaticImageToc[2] and sightlangStaticImageToc[3] and sightlangStaticImageToc[4] and sightlangStaticImageToc[5] then
    sightlangStatImgHand = false
    removeEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre)
  end
end
processsightlangStaticImage[0] = function()
  if not isElement(sightlangStaticImage[0]) then
    sightlangStaticImageToc[0] = false
    sightlangStaticImage[0] = dxCreateTexture("files/rotor.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[1] = function()
  if not isElement(sightlangStaticImage[1]) then
    sightlangStaticImageToc[1] = false
    sightlangStaticImage[1] = dxCreateTexture("files/overlay.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[2] = function()
  if not isElement(sightlangStaticImage[2]) then
    sightlangStaticImageToc[2] = false
    sightlangStaticImage[2] = dxCreateTexture("files/overlay2.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[3] = function()
  if not isElement(sightlangStaticImage[3]) then
    sightlangStaticImageToc[3] = false
    sightlangStaticImage[3] = dxCreateTexture("files/comp.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[4] = function()
  if not isElement(sightlangStaticImage[4]) then
    sightlangStaticImageToc[4] = false
    sightlangStaticImage[4] = dxCreateTexture("files/btm.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[5] = function()
  if not isElement(sightlangStaticImage[5]) then
    sightlangStaticImageToc[5] = false
    sightlangStaticImage[5] = dxCreateTexture("files/side.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
local sightgreen = false
local sightgreenEx = false
local compassFont = false
local compassFontScale = false
local zoomPlusIcon = false
local zoomMinusIcon = false
local lootPositions = {}
local faTicks = false
local function sightlangGuiRefreshColors()
  local res = getResourceFromName("sGui")
  if res and getResourceState(res) == "running" then
    sightgreen = sightexports.sGui:getColorCodeToColor("sightgreen")
    sightgreenEx = sightexports.sGui:getColorCode("sightgreen")
    compassFont = sightexports.sGui:getFont("15/BebasNeueBold.otf")
    compassFontScale = sightexports.sGui:getFontScale("15/BebasNeueBold.otf")
    zoomPlusIcon = sightexports.sGui:getFaIconFilename("search-plus", 32, "regular")
    zoomMinusIcon = sightexports.sGui:getFaIconFilename("search-minus", 32, "regular")
    faTicks = sightexports.sGui:getFaTicks()
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
      --lootPositions = exports.sCrab:getWeaponLootPositions()
      addEventHandler("onClientRender", getRootElement(), renderShipSpeedo, true, prio)
    else
      removeEventHandler("onClientRender", getRootElement(), renderShipSpeedo)
    end
  end
end
local zoom = 400
local shader1_source = " float posX; float posY; texture waterTexture; sampler waterSampler = sampler_state { Texture = <waterTexture>; AddressU = BORDER; AddressV = BORDER; BorderColor = {0, 0, 0, 1}; }; texture bedTexture; sampler bedSampler = sampler_state { Texture = <bedTexture>; AddressU = MIRROR; AddressV = MIRROR; }; float zoom = 400; float r = 0; float rp = 0; static const float PI = 3.14159265f; float am(float a) { return a - floor(a/(PI*2)) * (PI*2); } float4 PixelShaderFunction(float2 TexCoord : TEXCOORD0) : COLOR0 { float2 coord = float2(posX, posY); TexCoord -= 0.5; float rd = r-atan2(TexCoord.y, TexCoord.x) + PI; TexCoord = float2( TexCoord.x*cos(rp) - TexCoord.y*sin(rp), TexCoord.x*sin(rp) + TexCoord.y*cos(rp) ); coord = coord + TexCoord/6000*zoom; float d = tex2D(waterSampler, coord).r; for (float i = 1; i < 2; i++) { d += tex2D(waterSampler, float2(coord.x, coord.y + (i/6000*5))).r; d += tex2D(waterSampler, float2(coord.x, coord.y - (i/6000*5))).r; d += tex2D(waterSampler, float2(coord.x - (i/6000*5), coord.y)).r; d += tex2D(waterSampler, float2(coord.x + (i/6000*5), coord.y)).r; } d /= 4; rd = am(rd) - PI; float a = 0; if(rd > 0 && rd < 0.5) { a = smoothstep(1, 0, rd/(0.5)); } float bed = tex2D(bedSampler, coord).r; d = saturate(bed*0.5 + d); return float4(d, 0, 0, a); } technique Technique1 { pass Pass1 { PixelShader = compile ps_2_0 PixelShaderFunction(); } } "
local shader2_source = " texture rtTexture; sampler rtSampler = sampler_state { Texture = <rtTexture>; AddressU = MIRROR; AddressV = MIRROR; }; float grid(float2 c) { float x = min(frac(c.x), frac(c.y)); return saturate(x/0.222); } float4 PixelShaderFunction(float2 TexCoord : TEXCOORD0) : COLOR0 { float v = tex2D(rtSampler, round(TexCoord*60-0.5)/60).r; float v2 = tex2D(rtSampler, round(TexCoord*60-0.5)/60).g; TexCoord -= 0.5; float d = sqrt(TexCoord.x*TexCoord.x + TexCoord.y*TexCoord.y); if(d <= 0.435) { float3 c; float a = saturate(0.5 + d); if(d > 0.25) { v = v*(1-(d-0.25)/0.185); v2 = v2*(1-(d-0.25)/0.185); } if(v > 0.5) c = lerp(float3(0.38, 0.88, 0.3019), float3(0.38, 0.88, 0.3019), v/0.5-1); else c = lerp(float3(0, 0, 0), float3(0.38, 0.88, 0.3019), v/0.5); c = lerp(c, float3(0, 0.5, 1), v2); return lerp(float4(0, 0, 0, 0.85), float4(c, 0.85*a), grid(TexCoord*60)); } else return float4(1, 1, 1, 0); } technique Technique1 { pass Pass1 { PixelShader = compile ps_2_0 PixelShaderFunction(); } } "
local shader = false
local shader2 = false
local water = false
local bed = false
local rt = false
function createShaders()
  shader = dxCreateShader(shader1_source)
  dxSetShaderValue(shader, "zoom", zoom * 2)
  shader2 = dxCreateShader(shader2_source)
  water = dxCreateTexture("files/water.dds", "dxt1")
  bed = dxCreateTexture("files/bed.dds", "dxt1")
  dxSetShaderValue(shader, "waterTexture", water)
  dxSetShaderValue(shader, "bedTexture", bed)
  rt = dxCreateRenderTarget(360, 360)
  dxSetShaderValue(shader2, "rtTexture", rt)
end
function deleteShaders()
  if isElement(rt) then
    destroyElement(rt)
  end
  rt = nil
  if isElement(shader) then
    destroyElement(shader)
  end
  shader = nil
  if isElement(shader2) then
    destroyElement(shader2)
  end
  shader2 = nil
  if isElement(water) then
    destroyElement(water)
  end
  water = nil
  if isElement(bed) then
    destroyElement(bed)
  end
  bed = nil
end
addEventHandler("onClientResourceStop", getResourceRootElement(), function()
  deleteShaders()
end)
function compassColor(r)
  local rd = r - math.pi / 2
  rd = (rd + math.pi) % (math.pi * 2) - math.pi
  if rd < 0 then
    rd = math.abs(rd)
    if rd < 1.05 then
      return tocolor(0, 0, 0, 0)
    elseif rd < 1.55 then
      return tocolor(sightgreenEx[1], sightgreenEx[2], sightgreenEx[3], 255 * (rd - 1.05) / 0.5)
    else
      return sightgreen
    end
  elseif rd < 1.85 then
    return tocolor(0, 0, 0, 0)
  elseif rd < 2.35 then
    return tocolor(sightgreenEx[1], sightgreenEx[2], sightgreenEx[3], 255 * (rd - 1.85) / 0.5)
  else
    return sightgreen
  end
end
local widgetState = false
local widgetPos = {0, 0}
local widgetSize = {0, 0}
local radarSize = 256
local radarPosX = 0
local radarPosY = 0
function mToNm(m)
  return m * 0.539956803 / 1000
end
local hover = false
addEventHandler("onClientClick", getRootElement(), function(btn, state)
  if btn == "left" and state == "down" then
    if hover == "zplus" then
      if 100 < zoom then
        zoom = zoom - 50
        dxSetShaderValue(shader, "zoom", zoom * 2)
      end
    elseif hover == "zminus" and zoom < 600 then
      zoom = zoom + 50
      dxSetShaderValue(shader, "zoom", zoom * 2)
    end
  end
end)
local screenX, screenY = guiGetScreenSize()
function getVehicleSpeed(currentElement)
  if isElement(currentElement) then
    local x, y, z = getElementVelocity(currentElement)
    local speed = math.sqrt(x ^ 2 + y ^ 2 + z ^ 2)
    speed = speed * 97.1928
    return speed
  end
  return 0
end
local currentVehicle = false
local currentVehicleType = false
function renderShipSpeedo()
  local veh = getPedOccupiedVehicle(localPlayer)
  if veh ~= currentVehicle then
    currentVehicle = veh
    currentVehicleType = veh and getVehicleType(veh)
  end
  local tmp = false
  if veh and currentVehicleType == "Boat" then
    if widgetState then
      local x, y = getElementPosition(veh)
      local rx, ry, rz = getElementRotation(veh)
      local rrz = math.rad(-rz)
      local r = getTickCount() % 1000 / 1000 * math.pi * 2
      dxSetShaderValue(shader, "posX", (x + 3000) / 6000)
      dxSetShaderValue(shader, "posY", (-y + 3000) / 6000)
      dxSetShaderValue(shader, "r", r)
      dxSetShaderValue(shader, "rp", rrz)
      dxSetRenderTarget(rt)
      dxSetBlendMode("blend")
      dxDrawImage(0, 0, 360, 360, shader)
      local vehs = getElementsByType("vehicle", getRootElement(), true)
      local s = math.min(16, 200 / zoom * 14)
      for i = 1, #vehs do
        local v = vehs[i]
        if v ~= veh and getVehicleType(v) == "Boat" then
          local vx, vy = getElementPosition(v)
          vx = vx - x
          vy = vy - y
          local d = math.sqrt(vx * vx + vy * vy) / zoom
          if d < 1 then
            local vr = -rrz - math.atan2(vy, vx)
            local rd = r - vr
            rd = (rd + math.pi) % (math.pi * 2) - math.pi
            if 0 < rd and rd < 0.5 then
              dxDrawRectangle(180 + d * 180 * math.cos(vr) - s, 180 + d * 180 * math.sin(vr) - s, s * 2, s * 2, tocolor(0, 255, 0, 255 * (1 - rd / 0.5)))
            end
          end
        end
      end

      if lootPositions and type(lootPositions) == "table" then
        local s = math.min(16, 200 / zoom * 7)
        for i = 1, #lootPositions do
          local loot = lootPositions[i]
          if loot and loot[1] and loot[2] then
            local lx, ly = loot[1], loot[2]
            lx = lx - x
            ly = ly - y
            local d = math.sqrt(lx * lx + ly * ly) / zoom
            if d < 1 then
              local lr = -rrz - math.atan2(ly, lx)
              local rd = r - lr
              rd = (rd + math.pi) % (math.pi * 2) - math.pi
              if 0 < rd and rd < 0.5 then
                local posX = 180 + d * 180 * math.cos(lr) - s/2
                local posY = 180 + d * 180 * math.sin(lr) - s/2
                dxDrawRectangle(posX, posY, s, s, tocolor(0, 255, 0, 255 * (1 - rd / 0.5)))
              end
            end
          end
        end
      end

      dxSetBlendMode("blend")
      dxSetRenderTarget()
      dxDrawImage(radarPosX, radarPosY, radarSize * 2, radarSize * 2, shader2)
      sightlangStaticImageUsed[0] = true
      if sightlangStaticImageToc[0] then
        processsightlangStaticImage[0]()
      end
      dxDrawImage(radarPosX, radarPosY, radarSize * 2, radarSize * 2, sightlangStaticImage[0], math.deg(r) + 90, 0, 0, sightgreen)
      sightlangStaticImageUsed[1] = true
      if sightlangStaticImageToc[1] then
        processsightlangStaticImage[1]()
      end
      dxDrawImage(radarPosX, radarPosY, radarSize * 2, radarSize * 2, sightlangStaticImage[1], 0, 0, 0, sightgreen)
      sightlangStaticImageUsed[2] = true
      if sightlangStaticImageToc[2] then
        processsightlangStaticImage[2]()
      end
      dxDrawImage(radarPosX, radarPosY, radarSize * 2, radarSize * 2, sightlangStaticImage[2], 0, 0, 0, sightgreen)
      sightlangStaticImageUsed[3] = true
      if sightlangStaticImageToc[3] then
        processsightlangStaticImage[3]()
      end
      dxDrawImage(radarPosX, radarPosY, radarSize * 2, radarSize * 2, sightlangStaticImage[3], rz, 0, 0, sightgreen)
      dxDrawText(math.floor(mToNm(zoom * 0.83) * 100) / 100 .. " NM", radarPosX, 0, radarPosX + radarSize * 2, radarPosY + radarSize * 2 * 0.137, sightgreen, compassFontScale * 0.65, compassFont, "center", "bottom")
      dxDrawText(math.floor(mToNm(zoom * 0.69) * 100) / 100 .. " NM", radarPosX, 0, radarPosX + radarSize * 2, radarPosY + radarSize * 2 * 0.198, sightgreen, compassFontScale * 0.65, compassFont, "center", "bottom")
      dxDrawText(math.floor(mToNm(zoom * 0.55) * 100) / 100 .. " NM", radarPosX, 0, radarPosX + radarSize * 2, radarPosY + radarSize * 2 * 0.258, sightgreen, compassFontScale * 0.65, compassFont, "center", "bottom")
      local r = -rrz
      local tx, ty = radarPosX + radarSize + radarSize * math.cos(r), radarPosY + radarSize + radarSize * math.sin(r)
      dxDrawText("E", tx, ty, tx, ty, compassColor(r), compassFontScale, compassFont, "center", "center")
      local r = -rrz + math.pi / 4
      local tx, ty = radarPosX + radarSize + radarSize * math.cos(r), radarPosY + radarSize + radarSize * math.sin(r)
      dxDrawText("SE", tx, ty, tx, ty, compassColor(r), compassFontScale * 0.75, compassFont, "center", "center")
      local r = -rrz + math.pi / 2
      local tx, ty = radarPosX + radarSize + radarSize * math.cos(r), radarPosY + radarSize + radarSize * math.sin(r)
      dxDrawText("S", tx, ty, tx, ty, compassColor(r), compassFontScale, compassFont, "center", "center")
      local r = -rrz + math.pi / 4 * 3
      local tx, ty = radarPosX + radarSize + radarSize * math.cos(r), radarPosY + radarSize + radarSize * math.sin(r)
      dxDrawText("SW", tx, ty, tx, ty, compassColor(r), compassFontScale * 0.75, compassFont, "center", "center")
      local r = -rrz + math.pi
      local tx, ty = radarPosX + radarSize + radarSize * math.cos(r), radarPosY + radarSize + radarSize * math.sin(r)
      dxDrawText("W", tx, ty, tx, ty, compassColor(r), compassFontScale, compassFont, "center", "center")
      local r = -rrz + math.pi / 4 * 5
      local tx, ty = radarPosX + radarSize + radarSize * math.cos(r), radarPosY + radarSize + radarSize * math.sin(r)
      dxDrawText("NW", tx, ty, tx, ty, compassColor(r), compassFontScale * 0.75, compassFont, "center", "center")
      local r = -rrz + math.pi / 2 * 3
      local tx, ty = radarPosX + radarSize + radarSize * math.cos(r), radarPosY + radarSize + radarSize * math.sin(r)
      dxDrawText("N", tx, ty, tx, ty, compassColor(r), compassFontScale, compassFont, "center", "center")
      local r = -rrz + math.pi / 4 * 7
      local tx, ty = radarPosX + radarSize + radarSize * math.cos(r), radarPosY + radarSize + radarSize * math.sin(r)
      dxDrawText("NE", tx, ty, tx, ty, compassColor(r), compassFontScale * 0.75, compassFont, "center", "center")
      dxDrawText(math.floor(rz + 0.5) % 360 .. "°", radarPosX, radarPosY + radarSize * 2 * 0.98, radarPosX + radarSize * 2, radarPosY + radarSize * 2 * 0.98, sightgreen, compassFontScale * 0.75, compassFont, "center", "center")
      sightlangStaticImageUsed[4] = true
      if sightlangStaticImageToc[4] then
        processsightlangStaticImage[4]()
      end
      dxDrawImage(radarPosX, radarPosY, radarSize * 2, radarSize * 2, sightlangStaticImage[4], 0, 0, 0, tocolor(0, 0, 0, 150))
      sightlangStaticImageUsed[5] = true
      if sightlangStaticImageToc[5] then
        processsightlangStaticImage[5]()
      end
      dxDrawImage(radarPosX - radarSize, radarPosY, radarSize * 2, radarSize * 2, sightlangStaticImage[5], 0, 0, 0, tocolor(0, 0, 0, 150))
      dxDrawText(math.floor(getVehicleSpeed(veh)) .. " kn", 0, radarPosY + radarSize * 2 * 0.396, radarPosX + radarSize * -0.030000000000000027, radarPosY + radarSize * 2 * 0.396, sightgreen, compassFontScale * 0.95, compassFont, "right", "center")
      local coords = math.abs(math.floor(mToNm(x) * 1000) / 1000)
      if x < 0 then
        coords = coords .. "E "
      else
        coords = coords .. "W "
      end
      dxDrawText(coords, 0, radarPosY + radarSize * 2 * 0.5, radarPosX + radarSize * -0.062000000000000055, radarPosY + radarSize * 2 * 0.5, sightgreen, compassFontScale * 0.95, compassFont, "right", "center")
      local coords = math.abs(math.floor(mToNm(y) * 1000) / 1000)
      if y < 0 then
        coords = coords .. "N"
      else
        coords = coords .. "S"
      end
      dxDrawText(coords, 0, radarPosY + radarSize * 2 * 0.604, radarPosX + radarSize * -0.030000000000000027, radarPosY + radarSize * 2 * 0.604, sightgreen, compassFontScale * 0.95, compassFont, "right", "center")
      local cx, cy = getCursorPosition()
      if cx then
        cx = cx * screenX
        cy = cy * screenY
        if cx >= radarPosX + radarSize * 2 * 0.15 - 16 and cy >= radarPosY + radarSize * 2 * 0.915 - 16 and cx <= radarPosX + radarSize * 2 * 0.15 + 16 and cy <= radarPosY + radarSize * 2 * 0.915 + 16 then
          tmp = "zminus"
        elseif cx >= radarPosX + radarSize * 2 * 0.85 - 16 and cy >= radarPosY + radarSize * 2 * 0.915 - 16 and cx <= radarPosX + radarSize * 2 * 0.85 + 16 and cy <= radarPosY + radarSize * 2 * 0.915 + 16 then
          tmp = "zplus"
        end
      end
      dxDrawImage(radarPosX + radarSize * 2 * 0.15 - 16, radarPosY + radarSize * 2 * 0.915 - 16, 32, 32, ":sGui/" .. zoomMinusIcon .. faTicks[zoomMinusIcon], 0, 0, 0, tmp == "zminus" and sightgreen or tocolor(255, 255, 255, 170))
      dxDrawImage(radarPosX + radarSize * 2 * 0.85 - 16, radarPosY + radarSize * 2 * 0.915 - 16, 32, 32, ":sGui/" .. zoomPlusIcon .. faTicks[zoomPlusIcon], 0, 0, 0, tmp == "zplus" and sightgreen or tocolor(255, 255, 255, 170))
    end
  else
    deleteShaders()
    sightlangCondHandl0(false)
  end
  if tmp ~= hover then
    hover = tmp
    sightexports.sGui:setCursorType(hover and "link" or "normal")
    if hover == "zplus" then
      sightexports.sGui:showTooltip("Nagyítás")
    elseif hover == "zminus" then
      sightexports.sGui:showTooltip("Kicsinyítés")
    else
      sightexports.sGui:showTooltip()
    end
  end
end
addEvent("hudWidgetState:speedo", true)
addEventHandler("hudWidgetState:speedo", getRootElement(), function(state)
  if widgetState ~= state then
    widgetState = state
    if hover then
      sightexports.sGui:setCursorType("normal")
      sightexports.sGui:showTooltip()
      hover = false
    end
  end
end)
addEvent("hudWidgetPosition:speedo", true)
addEventHandler("hudWidgetPosition:speedo", getRootElement(), function(pos, final)
  widgetPos = pos
  radarPosX = widgetPos[1] + widgetSize[1] / 2 - radarSize
  radarPosY = widgetPos[2] + widgetSize[2] / 2 - radarSize
end)
addEvent("hudWidgetSize:speedo", true)
addEventHandler("hudWidgetSize:speedo", getRootElement(), function(size, final)
  widgetSize = size
  radarSize = math.floor(math.max(widgetSize[1], widgetSize[2]) / 2) - 12
  radarPosX = widgetPos[1] + widgetSize[1] / 2 - radarSize
  radarPosY = widgetPos[2] + widgetSize[2] / 2 - radarSize
end)
triggerEvent("requestWidgetDatas", localPlayer, "speedo")
addEventHandler("onClientVehicleEnter", getRootElement(), function(ped, seat)
  if ped == localPlayer and getVehicleType(source) == "Boat" then
    exports.sSpeedo:setSpeedoType("digital")
    createShaders()
    sightlangCondHandl0(true)
  end
end)
