local sightexports = {
  sGui = false,
  sControls = false,
  sModloader = false
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
local shaderSource = [[
#include "files/mta-helper.fx"
 struct PSInput { float4 Position : POSITION0; float4 Diffuse : COLOR0; float2 TexCoord : TEXCOORD0; }; struct VSInput { float3 Position : POSITION0; float4 Diffuse : COLOR0; float2 TexCoord : TEXCOORD0; }; texture MaskTexture; sampler2D MaskSampler = sampler_state { Texture = (MaskTexture); }; texture CutTexture; sampler2D CutSampler = sampler_state { Texture = (CutTexture); }; sampler2D OrigSampler = sampler_state { Texture = (gTexture0); }; float4 PixelShaderFunction(PSInput PS) : COLOR0 { float4 col = tex2D(OrigSampler, PS.TexCoord); float4 cut = tex2D(CutSampler, PS.TexCoord); float4 mask = tex2D(MaskSampler, PS.TexCoord); col.rgb = lerp(col.rgb, cut.rgb, mask.r); return col*PS.Diffuse; } technique Technique1 { pass Pass1 { AlphaBlendEnable = true; AlphaFunc = GreaterEqual; PixelShader = compile ps_2_0 PixelShaderFunction(); } } ]]
robbingAtm = false
function absmax(a, b)
  if math.abs(a) > math.abs(b) then
    return a
  else
    return b
  end
end
local ds = 0.3120555
local flex = false
local disc = false
local shader = false
local shaderApplied = false
function applyShader()
  if isElement(atmDatas[robbingAtm].obj) then
    destroyElement(atmDatas[robbingAtm].obj)
  end
  local x, y, z = atmDatas[robbingAtm].pos[1], atmDatas[robbingAtm].pos[2], atmDatas[robbingAtm].pos[3] - 0.355
  local r = atmDatas[robbingAtm].pos[4]
  atmDatas[robbingAtm].obj = createObject(models.v4_atm2, x, y, z, 0, 0, r)
  local rad = math.rad(r)
  local cos = math.cos(rad)
  local sin = math.sin(rad)
  if not isElement(atmDatas[robbingAtm].door) then
    atmDatas[robbingAtm].door = createObject(models.v4_atm2_door, x, y, z, 0, 0, r)
    setElementInterior(atmDatas[robbingAtm].door, atmDatas[robbingAtm].pos[5])
    setElementDimension(atmDatas[robbingAtm].door, atmDatas[robbingAtm].pos[6])
    setElementCollisionsEnabled(atmDatas[robbingAtm].door, false)
  end
  for i = 1, #moneyBoxes do
    if not isElement(atmDatas[robbingAtm].boxes[i]) then
      local x = x + cos * moneyBoxes[i][1] + sin * moneyBoxes[i][2]
      local y = y + sin * moneyBoxes[i][1] - cos * moneyBoxes[i][2]
      local z = z + moneyBoxes[i][3]
      atmDatas[robbingAtm].boxes[i] = createObject(models.v4_atm_cassette, x, y, z, 0, 0, r - 90)
      setElementInterior(atmDatas[robbingAtm].boxes[i], atmDatas[robbingAtm].pos[5])
      setElementDimension(atmDatas[robbingAtm].boxes[i], atmDatas[robbingAtm].pos[6])
      setElementCollisionsEnabled(atmDatas[robbingAtm].boxes[i], false)
    end
  end
  engineApplyShaderToWorldTexture(shader, "v4_atm_weld", atmDatas[robbingAtm].obj)
  engineApplyShaderToWorldTexture(shader, "v4_atm_weld", atmDatas[robbingAtm].door)
  shaderApplied = true
end
local rt = false
local cutText = false
local progress = {}
local fr = 0
local targetFr = 0
local fd = 0.5
local targetFd = 0
local cutProg = 0
local doorProg = 0
local fadeProg = 1
local endP = 0
local fadeStart = false
local startingFade = false
function renderFade()
  local p = (getTickCount() - fadeStart) / 1000
  if 1 < p then
    p = 1
    fadeStart = false
    removeEventHandler("onClientRender", getRootElement(), renderFade)
    if startingFade then
      startMinigameEx()
      dxDrawRectangle(0, 0, screenX, screenY, tocolor(0, 0, 0, 255))
    end
    startingFade = false
  else
    if not startingFade then
      p = 1 - p
    end
    dxDrawRectangle(0, 0, screenX, screenY, tocolor(0, 0, 0, 255 * p))
  end
end
local cursorState = false
local cutting = false
function endMinigame()
  cutting = false
  cursorState = false
  sightexports.sGui:setCursorType("normal")
  triggerServerEvent("endATMRobbing", localPlayer)
  showCursor(false)
  removeEventHandler("onClientPreRender", getRootElement(), preRenderATMRob)
  removeEventHandler("onClientRender", getRootElement(), renderATMRob)
  if not fadeStart and not skipFade then
    addEventHandler("onClientRender", getRootElement(), renderFade)
    fadeStart = getTickCount()
  end
  setCameraTarget(localPlayer)
  sightexports.sControls:toggleAllControls(true)
  if isElement(cutText) then
    destroyElement(cutText)
  end
  cutText = false
  if isElement(cut) then
    destroyElement(cut)
  end
  cut = false
  if isElement(loop) then
    destroyElement(loop)
  end
  loop = false
  if isElement(flex) then
    destroyElement(flex)
  end
  flex = false
  if isElement(disc) then
    destroyElement(disc)
  end
  disc = false
  if isElement(shader) then
    destroyElement(shader)
  end
  shader = false
  if isElement(rt) then
    destroyElement(rt)
  end
  rt = false
  setElementAlpha(localPlayer, 255)
  shaderApplied = false
  local id = robbingAtm
  robbingAtm = false
  resetATM(id)
  exports.sCamera:setAlpha(false, 255)
end
function renderATMRob()
  local y = math.floor(screenY * 0.8)
  local a = 1
  dxDrawText(math.floor(cutProg * 100) .. " %", 1, 1, screenX + 1, y - 4 + 1, tocolor(0, 0, 0, 150 * a), fontScale, font, "center", "bottom")
  dxDrawText(math.floor(cutProg * 100) .. " %", 0, 0, screenX, y - 4, tocolor(255, 255, 255, 255 * a), fontScale, font, "center", "bottom")
  dxDrawRectangle(screenX / 2 - 128, y, 256, 12, tocolor(v4grey[1], v4grey[2], v4grey[3], 255 * a))
  dxDrawRectangle(screenX / 2 - 128, y, 256 * cutProg, 12, tocolor(v4green[1], v4green[2], v4green[3], 255 * a))
  dxDrawRectangle(0, 0, screenX, screenY, tocolor(0, 0, 0, 255 * fadeProg))
end
local sparks = {}
function preRenderATMRob(delta)
  if (not checkDistance(localPlayer, robbingAtm) or getKeyState("backspace")) and not isChatBoxInputActive() and cutProg < 1 or getElementHealth(localPlayer) <= 20 then
    endMinigame(true)
    return
  end
  for i = #sparks, 1, -1 do
    local nx, ny, nz = sparks[i][4], sparks[i][5], sparks[i][6]
    sparks[i][1] = sparks[i][1] + nx * 2.5 * delta / 1000
    sparks[i][2] = sparks[i][2] + ny * 2.5 * delta / 1000
    sparks[i][3] = sparks[i][3] + nz * 2.5 * delta / 1000
    local sx, sy, sz = sparks[i][1], sparks[i][2], sparks[i][3]
    sparks[i][7] = sparks[i][7] + 0.25 * delta / 1000
    local a = 255 - sparks[i][7] * sparks[i][9] * 255
    if a < 0 then
      table.remove(sparks, i)
    else
      local p = sparks[i][7] * 30
      local c = false
      if 2 <= p then
        c = tocolor(175, 50, 20, a)
      elseif 1 <= p then
        local r = 245 + -70 * (p - 1)
        local g = 219 + -169 * (p - 1)
        local b = 121 + -101 * (p - 1)
        c = tocolor(r, g, b, a)
      elseif 0 <= p then
        local r = 255 + -10 * p
        local g = 255 + -36 * p
        local b = 255 + -134 * p
        c = tocolor(r, g, b, a)
      else
        c = tocolor(255, 255, 255)
      end
      local len = math.sqrt(nx * nx + ny * ny + nz * nz) * 2
      nx = nx / len * sparks[i][8]
      ny = ny / len * sparks[i][8]
      nz = nz / len * sparks[i][8]
      dxDrawLine3D(sx, sy, sz, sx + nx, sy + ny, sz + nz, c, 0.125)
    end
  end
  local tmp = false
  local obj = atmDatas[robbingAtm].obj
  local curX, curY = getCursorPosition()
  if fr ~= targetFr then
    if fr > targetFr then
      fr = fr - 360 * delta / 1000
      if fr < targetFr then
        fr = targetFr
      end
    elseif fr < targetFr then
      fr = fr + 360 * delta / 1000
      if fr > targetFr then
        fr = targetFr
      end
    end
    setElementRotation(flex, 0, fr, atmDatas[robbingAtm].pos[4])
  end
  if fd > targetFd then
    fd = fd - 0.5 * delta / 1000
    if fd < targetFd then
      fd = targetFd
    end
  elseif fd < targetFd then
    fd = fd + 0.5 * delta / 1000
    if fd > targetFd then
      fd = targetFd
    end
  end
  local cutVol = 0
  if fd <= 0.0751145 then
    cutVol = (fd - 0.0851145) / -0.01
  end
  setSoundVolume(cut, cutVol)
  if 1 <= cutProg and doorProg < 1 then
    doorProg = doorProg + 1 * delta / 1000
    if 1 < doorProg then
      doorProg = 1
    end
    setElementAlpha(atmDatas[robbingAtm].door, 255 - 255 * doorProg)
    local r = math.rad(atmDatas[robbingAtm].pos[4])
    local x, y, z = atmDatas[robbingAtm].pos[1], atmDatas[robbingAtm].pos[2], atmDatas[robbingAtm].pos[3] - 0.355
    local c = math.cos(r - math.pi / 2)
    local s = math.sin(r - math.pi / 2)
    setElementPosition(atmDatas[robbingAtm].door, x + c * doorProg * 0.25, y + s * doorProg * 0.25, z)
  end
  if 1 <= doorProg and fadeProg < 1 then
    fadeProg = fadeProg + 1 * delta / 1000
    if 1 < fadeProg then
      fadeProg = 1
      endMinigame()
      return
    end
    setSoundVolume(loop, 1 - fadeProg)
  elseif 0 < fadeProg then
    fadeProg = fadeProg - 1 * delta / 1000
    if fadeProg < 0 then
      fadeProg = 0
    end
    setSoundVolume(loop, 1 - fadeProg)
  end
  local r = math.rad(atmDatas[robbingAtm].pos[4])
  local c = math.cos(r)
  local s = math.sin(r)
  setCameraMatrix(atmDatas[robbingAtm].pos[1] + s * 1.75, atmDatas[robbingAtm].pos[2] - c * 1.75, atmDatas[robbingAtm].pos[3] + 0.15, atmDatas[robbingAtm].pos[1], atmDatas[robbingAtm].pos[2], atmDatas[robbingAtm].pos[3] - 0.355 - 0.2656 - 0.15)
  setElementAttachedOffsets(disc, 0, 0, 0, 0, 0, -getTickCount() * 2)
  targetFd = 0.1201145
  local ctmp = false
  if curX then
    local x, y, z = getWorldFromScreenPosition(curX * screenX, curY * screenY, 3)
    local cx, cy, cz = getCameraMatrix()
    local h, hx, hy, hz, he, nx, ny, nz, mat = processLineOfSight(cx, cy, cz, x, y, z, false, false, false, true, false)
    if he == obj then
      setElementPosition(flex, hx + nx * fd, hy + ny * fd, hz)
      local x = hx - atmDatas[robbingAtm].pos[1]
      local y = hy - atmDatas[robbingAtm].pos[2]
      local d = (s * x - c * y) / (c * c + s * s)
      if math.abs(d - 0.29685058593759) < 0.05 then
        local a = (c * x + s * y) / (c * c + s * s)
        local b = hz - (atmDatas[robbingAtm].pos[3] - 0.355 - 0.2656)
        local aa = math.abs(a)
        local ab = math.abs(b)
        if aa > ab then
          targetFr = 90
        else
          targetFr = 0
        end
        local s = math.max(aa, ab)
        tmp = true
        if math.abs(math.abs(s) - ds) < 0.025 and cutProg < 1 then
          if getKeyState("mouse1") then
            targetFd = 0.0751145
            ctmp = true
          end
          local p = 0
          if aa > ab then
            if 0 < a then
              p = 0.25 + 0.25 * (-b / (ds * 2) + 0.5)
            else
              p = 0.75 + 0.25 * (b / (ds * 2) + 0.5)
            end
          elseif b < 0 then
            p = 0.5 + 0.25 * (-a / (ds * 2) + 0.5)
          else
            p = 0.25 * (a / (ds * 2) + 0.5)
          end
          if fd < 0.0851145 then
            hx, hy = hx + nx * 0.015, hy + ny * 0.015
            if aa > ab then
              local r = math.pi / 9 * math.random()
              local nx, ny, nz = (-0.125 + 0.25 * math.random()) * math.cos(r), (-0.125 + 0.25 * math.random()) * math.sin(r), -1
              local s = 1
              local alive = 6
              if math.random() > 0.8 then
                s = 0.75
                alive = 16
                nz = -nz
              end
              table.insert(sparks, {
                hx,
                hy,
                hz,
                nx * s,
                ny * s,
                nz * s,
                math.random() * 0.075 - 0.025,
                0.05 + math.random() * 0.25 * s * s,
                alive * (0.8 + math.random() * 0.3)
              })
            else
              local nx, ny, nz = -ny, nx, -0.125 + 0.25 * math.random()
              local s = 1
              local alive = 6
              local rp = -1
              if math.random() > 0.8 then
                s = 0.75
                alive = 16
                rp = 1
                nx, ny = -nx, -ny
              end
              local r = rp * math.pi / 9 * math.random()
              nx, ny = nx * math.cos(r) - ny * math.sin(r), nx * math.sin(r) + ny * math.cos(r)
              table.insert(sparks, {
                hx,
                hy,
                hz,
                nx * s,
                ny * s,
                nz * s,
                math.random() * 0.075 - 0.025,
                0.05 + math.random() * 0.25 * s * s,
                alive * (0.8 + math.random() * 0.3)
              })
            end
            if not atmDatas[robbingAtm].robStarted then
              atmDatas[robbingAtm].robStarted = true
              triggerServerEvent("atmRobStart", localPlayer, robbingAtm)
            end
            if not shaderApplied then
              applyShader()
            end
            dxSetRenderTarget(rt)
            local x = math.floor(p * 1024) - 5
            for i = x, x + 10 do
              local new = math.min(1, (progress[i % 1024] or 0) + 2.5 * delta / 1000)
              progress[i % 1024] = new
              dxDrawRectangle(i % 1024, 0, 1, 1, tocolor(255 * new * new, 255 * new * new, 255 * new * new))
            end
            dxSetRenderTarget()
            cutProg = 0
            for i = 0, 1023 do
              if progress[i] then
                cutProg = cutProg + math.min(1, progress[i] / 0.95)
              end
            end
            cutProg = cutProg / 1024
            if 1 <= cutProg and not atmDatas[robbingAtm].robbed then
              atmDatas[robbingAtm].robbed = {}
              triggerServerEvent("atmDoorCut", localPlayer, robbingAtm)
            end
          end
        end
      end
    end
  end
  if ctmp ~= cutting then
    cutting = ctmp
    triggerServerEvent("syncAtmCutSound", localPlayer, cutting)
  end
  if tmp ~= cursorState then
    cursorState = tmp
    sightexports.sGui:setCursorType(cursorState and "none" or "normal")
  end
end
function startMinigameEx()
  sightexports.sGui:showInfobox("i", "A Backspace gomb használatával megszakíthatod a folyamatot.")
  showCursor(true)
  progress = {}
  fr = 0
  targetFr = 0
  fd = 0.5
  targetFd = 0
  cutProg = 0
  doorProg = 0
  fadeProg = 1
  endP = 0
  fadeStart = false
  startingFade = false
  if isElement(cut) then
    destroyElement(cut)
  end
  cut = nil
  if isElement(loop) then
    destroyElement(loop)
  end
  loop = nil
  if isElement(flex) then
    destroyElement(flex)
  end
  flex = nil
  if isElement(disc) then
    destroyElement(disc)
  end
  disc = nil
  if isElement(shader) then
    destroyElement(shader)
  end
  shader = nil
  if isElement(rt) then
    destroyElement(rt)
  end
  rt = nil
  if isElement(cutText) then
    destroyElement(cutText)
  end
  cutText = nil
  cut = playSound("files/cut.mp3", true)
  loop = playSound("files/loop.mp3", true)
  setSoundVolume(cut, 0)
  setSoundVolume(loop, 0)
  flex = createObject(sightexports.sModloader:getModelId("flex"), 0, 0, 0)
  setElementRotation(flex, 0, 0, atmDatas[robbingAtm].pos[4])
  setElementCollisionsEnabled(flex, false)
  disc = createObject(sightexports.sModloader:getModelId("flex_disc"), 0, 0, 0)
  setElementRotation(disc, 0, 0, atmDatas[robbingAtm].pos[4])
  setElementCollisionsEnabled(disc, false)
  attachElements(disc, flex)
  shader = dxCreateShader(shaderSource)
  rt = dxCreateRenderTarget(1024, 1)
  cutText = dxCreateTexture("files/cut.dds")
  dxSetShaderValue(shader, "MaskTexture", rt)
  dxSetShaderValue(shader, "CutTexture", cutText)
  addEventHandler("onClientPreRender", getRootElement(), preRenderATMRob)
  addEventHandler("onClientRender", getRootElement(), renderATMRob)
  applyShader()
  setElementAlpha(localPlayer, 0)
  setElementData(localPlayer, "usingGrinder", false)
end
function startMinigame(id)
  if not robbingAtm then
    robbingAtm = id
    sightexports.sControls:toggleAllControls(false)
    startingFade = true
    if not fadeStart then
      addEventHandler("onClientRender", getRootElement(), renderFade)
      fadeStart = getTickCount()
    end
  end
end
addEvent("startATMRob", true)
addEventHandler("startATMRob", getRootElement(), function(id)
  startMinigame(id)
  exports.sCamera:setAlpha(true, 0)
end)
local paintShaderSource = [[
#include "files/mta-helper.fx"
 struct PSInput { float4 Position : POSITION0; float4 Diffuse : COLOR0; float2 TexCoord : TEXCOORD0; float1 Rot : TEXCOORD1; }; struct VSInput { float3 Position : POSITION0; float3 Normal : NORMAL0; float4 Diffuse : COLOR0; float2 TexCoord : TEXCOORD0; }; PSInput VertexShaderFunction(VSInput VS) { PSInput PS = (PSInput)0; MTAFixUpNormal(VS.Normal); PS.Rot = atan2(VS.Normal.y, VS.Normal.x); VS.Position += VS.Normal * 0.001; PS.Position = mul(float4(VS.Position, 1), gWorldViewProjection); PS.Diffuse = MTACalcGTABuildingDiffuse(VS.Diffuse); PS.TexCoord = VS.TexCoord; return PS; } texture MaskTexture; sampler2D MaskSampler = sampler_state { Texture = (MaskTexture); }; texture CloudTexture; sampler2D CloudSampler = sampler_state { Texture = (CloudTexture); }; float4 PixelShaderFunction(PSInput PS) : COLOR0 { float4 cloud = tex2D(CloudSampler, PS.TexCoord*2); float mask = 1-abs(PS.Rot-3.14/2)/3.14; return float4(0.58, 0.235, 0.721, cloud.r*mask)*PS.Diffuse; } technique Technique1 { pass Pass1 { DepthBias=-0.0002; VertexShader = compile vs_2_0 VertexShaderFunction(); PixelShader = compile ps_2_0 PixelShaderFunction(); } } ]]
local paintedPlayer = {}
local cloudTex = false
local paintShader = false
function checkPaintShader()
  local tmp = false
  for k in pairs(paintedPlayer) do
    tmp = true
    break
  end
  if tmp ~= paintShaderState then
    paintShaderState = tmp
    if isElement(cloudTex) then
      destroyElement(cloudTex)
    end
    cloudTex = nil
    if isElement(paintShader) then
      destroyElement(paintShader)
    end
    paintShader = nil
    if tmp then
      cloudTex = dxCreateTexture("files/cloud.dds")
      paintShader = dxCreateShader(paintShaderSource, 0, 0, true, "ped")
      dxSetShaderValue(paintShader, "CloudTexture", cloudTex)
    end
  end
  paintShaderState = tmp
end
local players = getElementsByType("player", getRootElement(), true)
for i = 1, #players do
  if getElementData(players[i], "facePaint") then
    paintedPlayer[players[i]] = true
    checkPaintShader()
    engineApplyShaderToWorldTexture(paintShader, "*", players[i])
  end
end
addEventHandler("onClientPlayerDataChange", getRootElement(), function(data, old, new)
  if data == "facePaint" and isElementStreamedIn(source) then
    if new then
      if not paintedPlayer[source] then
        paintedPlayer[source] = true
        checkPaintShader()
        engineApplyShaderToWorldTexture(paintShader, "*", source)
      end
    elseif paintedPlayer[source] then
      if isElement(paintShader) then
        engineRemoveShaderFromWorldTexture(paintShader, "*", source)
      end
      paintedPlayer[source] = nil
      checkPaintShader()
    end
  end
end)
addEventHandler("onClientPlayerStreamIn", getRootElement(), function()
  if not paintedPlayer[source] and getElementData(source, "facePaint") then
    paintedPlayer[source] = true
    checkPaintShader()
    engineApplyShaderToWorldTexture(paintShader, "*", source)
  end
end)
addEventHandler("onClientPlayerStreamOut", getRootElement(), function()
  if paintedPlayer[source] then
    if isElement(paintShader) then
      engineRemoveShaderFromWorldTexture(paintShader, "*", source)
    end
    paintedPlayer[source] = nil
    checkPaintShader()
  end
end)
addEventHandler("onClientPlayerStreamQuit", getRootElement(), function()
  if paintedPlayer[source] then
    if isElement(paintShader) then
      engineRemoveShaderFromWorldTexture(paintShader, "*", source)
    end
    paintedPlayer[source] = nil
    checkPaintShader()
  end
end)
