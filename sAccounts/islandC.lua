local seexports = {
  sPavilion = false,
  sGui = false,
  sWeather = false,
  sBinco = false,
  sMarkers = false,
  sWater = false,
  sDashboard = false
}
local function seelangProcessExports()
  for k in pairs(seexports) do
    local res = getResourceFromName(k)
    if res and getResourceState(res) == "running" then
      seexports[k] = exports[k]
    else
      seexports[k] = false
    end
  end
end
seelangProcessExports()
if triggerServerEvent then
  addEventHandler("onClientResourceStart", getRootElement(), seelangProcessExports, true, "high+9999999999")
end
if triggerClientEvent then
  addEventHandler("onResourceStart", getRootElement(), seelangProcessExports, true, "high+9999999999")
end
local seelangStatImgHand = false
local seelangStaticImage = {}
local seelangStaticImageToc = {}
local seelangStaticImageUsed = {}
local seelangStaticImageDel = {}
local processSeelangStaticImage = {}
seelangStaticImageToc[0] = true
seelangStaticImageToc[1] = true
local seelangStatImgPre
function seelangStatImgPre()
  local now = getTickCount()
  if seelangStaticImageUsed[0] then
    seelangStaticImageUsed[0] = false
    seelangStaticImageDel[0] = false
  elseif seelangStaticImage[0] then
    if seelangStaticImageDel[0] then
      if now >= seelangStaticImageDel[0] then
        if isElement(seelangStaticImage[0]) then
          destroyElement(seelangStaticImage[0])
        end
        seelangStaticImage[0] = nil
        seelangStaticImageDel[0] = false
        seelangStaticImageToc[0] = true
        return
      end
    else
      seelangStaticImageDel[0] = now + 5000
    end
  else
    seelangStaticImageToc[0] = true
  end
  if seelangStaticImageUsed[1] then
    seelangStaticImageUsed[1] = false
    seelangStaticImageDel[1] = false
  elseif seelangStaticImage[1] then
    if seelangStaticImageDel[1] then
      if now >= seelangStaticImageDel[1] then
        if isElement(seelangStaticImage[1]) then
          destroyElement(seelangStaticImage[1])
        end
        seelangStaticImage[1] = nil
        seelangStaticImageDel[1] = false
        seelangStaticImageToc[1] = true
        return
      end
    else
      seelangStaticImageDel[1] = now + 5000
    end
  else
    seelangStaticImageToc[1] = true
  end
  if seelangStaticImageToc[0] and seelangStaticImageToc[1] then
    seelangStatImgHand = false
    removeEventHandler("onClientPreRender", getRootElement(), seelangStatImgPre)
  end
end
processSeelangStaticImage[0] = function()
  if not isElement(seelangStaticImage[0]) then
    seelangStaticImageToc[0] = false
    seelangStaticImage[0] = dxCreateTexture("files/star.dds", "argb", true)
  end
  if not seelangStatImgHand then
    seelangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), seelangStatImgPre, true, "high+999999999")
  end
end
processSeelangStaticImage[1] = function()
  if not isElement(seelangStaticImage[1]) then
    seelangStaticImageToc[1] = false
    seelangStaticImage[1] = dxCreateTexture("files/vignette.dds", "argb", true)
  end
  if not seelangStatImgHand then
    seelangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), seelangStatImgPre, true, "high+999999999")
  end
end
local seelangStrmMode = true
if seexports.sDashboard then
  local val = seexports.sDashboard:getStreamerMode()
  seelangStrmMode = val
end
local streamerSounds = {}
function seelangSoundDestroy()
  streamerSounds[source] = nil
end
function setStreamerModeVolume(sound, vol)
  if not sound then
    return
  end
  if not streamerSounds[sound] then
    addEventHandler("onClientElementDestroy", sound, seelangSoundDestroy)
  end
  streamerSounds[sound] = vol
  setSoundVolume(sound, seelangStrmMode and 0 or vol)
end
addEventHandler("streamerModeChanged", getRootElement(), function(val)
  seelangStrmMode = val
  for sound, vol in pairs(streamerSounds) do
    setSoundVolume(sound, val and 0 or vol)
  end
end)
local _createPed = createPed
function createPed(...)
  local ped = _createPed(...)
  seexports.sPavilion:disablePedHeadmove(ped)
  return ped
end
local movieShaderSource = " texture sBaseTexture; float blur = 0; float Hue; float Brightness; float Contrast; float Saturation; float R; float G; float B; float L; float noise; float noiseX = 12.9898; float noiseY = 78.2330; sampler Samp = sampler_state { Texture = (sBaseTexture); AddressU = MIRROR; AddressV = MIRROR; }; float3x3 QuaternionToMatrix(float4 quat) { float3 cross = quat.yzx * quat.zxy; float3 square= quat.xyz * quat.xyz; float3 wimag = quat.w * quat.xyz; square = square.xyz + square.yzx; float3 diag = 0.5 - square; float3 a = (cross + wimag); float3 b = (cross - wimag); return float3x3( 2.0 * float3(diag.x, b.z, a.y), 2.0 * float3(a.z, diag.y, b.x), 2.0 * float3(b.y, a.x, diag.z)); } const float3 lumCoeff = float3(0.2125, 0.7154, 0.0721); float rand_1_05(in float2 uv) { float2 noise = (frac(sin(dot(uv, float2(noiseX,noiseY)*2.0)) * 43758.5453)); return abs(noise.x + (noise.y)) * 0.5; } float4 PixelShaderFunction(float2 uv : TEXCOORD) : COLOR { float4 outputColor = tex2D(Samp, uv); float3 hsv; float3 intensity; if(blur > 0) { for (float i = 1; i < 3; i++) { outputColor += tex2D(Samp, float2(uv.x, uv.y + (i * blur))); outputColor += tex2D(Samp, float2(uv.x, uv.y - (i * blur))); outputColor += tex2D(Samp, float2(uv.x - (i * blur), uv.y)); outputColor += tex2D(Samp, float2(uv.x + (i * blur), uv.y)); } outputColor /= 9; } float3 root3 = float3(0.57735, 0.57735, 0.57735); float half_angle = 0.5 * radians(Hue); float4 rot_quat = float4( (root3 * sin(half_angle)), cos(half_angle)); float3x3 rot_Matrix = QuaternionToMatrix(rot_quat); outputColor.rgb = mul(rot_Matrix, outputColor.rgb); outputColor.rgb = (outputColor.rgb - 0.5) *(Contrast + 1.0) + 0.5; outputColor.rgb = outputColor.rgb + Brightness; intensity = float(dot(outputColor.rgb, lumCoeff)); outputColor.rgb = lerp(intensity, outputColor.rgb, Saturation ); outputColor.rgb *= L; outputColor.rgb *= 1+rand_1_05(uv)*noise; outputColor.r *= R; outputColor.g *= G; outputColor.b *= B; return outputColor; } technique movie { pass P0 { PixelShader = compile ps_2_0 PixelShaderFunction(); } } technique fallback { pass P0 { } } "
addEvent("passBorderAnimation2", true)
addEventHandler("passBorderAnimation2", getRootElement(), function(el)
  if seexports.sGui:isGuiElementValid(el) then
    seexports.sGui:setGuiSizeAnimated(el, 599, 25, 350)
    seexports.sGui:setGuiPositionAnimated(el, 48, 77, 350, "passBorderAnimation1")
  end
end)
addEvent("passBorderAnimation1", true)
addEventHandler("passBorderAnimation1", getRootElement(), function(el)
  if seexports.sGui:isGuiElementValid(el) then
    seexports.sGui:setGuiSizeAnimated(el, 603, 29, 350)
    seexports.sGui:setGuiPositionAnimated(el, 46, 75, 350, "passBorderAnimation2")
  end
end)
local boardingPass = false
local characterNameInput = false
local sceneTarget = false
local movieShader = false
local renderHandled = false
local vignetteGui = false
local blurFadeOut = false
function deleteBoardingPass()
  dxSetShaderValue(movieShader, "blur", 0)
  showCursor(false)
  if boardingPass then
    seexports.sGui:deleteGuiElement(boardingPass)
  end
  boardingPass = false
  characterNameInput = false
end
selectedPlayerSkin = 1
characterName = ""
characterGender = 1
local sceneElements = {}
local sceneMarkers = {}
local toCity = "Los Santos"
local toAirport = "Los Santos Int'l"
local lastCityIntro = false
local cameraMatrix = false
local fadeScreen = false
function createBoardingPass()
  setPedAnimation(sceneElements.airport[1])
  setPedAnimation(sceneElements.airport[2])
  deleteBoardingPass()
  showCursor(true)
  dxSetShaderValue(movieShader, "blur", 0.0015)
  boardingPass = seexports.sGui:createGuiElement("image", screenX / 2 - 384, screenY / 2 - 160, 768, 320)
  seexports.sGui:setImageDDS(boardingPass, ":sAccounts/files/pass.dds")
  local border = seexports.sGui:createGuiElement("rectangle", 48, 77, 599, 25, boardingPass)
  seexports.sGui:setGuiBackground(border, "solid", "sightgreen")
  seexports.sGui:setGuiSizeAnimated(border, 603, 29, 350)
  seexports.sGui:setGuiPositionAnimated(border, 46, 75, 350, "passBorderAnimation2")
  characterNameInput = seexports.sGui:createGuiElement("input", 48, 77, 599, 25, boardingPass)
  seexports.sGui:setInputColor(characterNameInput, "#484848", "#e2cea1", "#484848", "#e2cea1", "#484848")
  seexports.sGui:setInputPlaceholder(characterNameInput, " Add meg a karaktered nevét")
  seexports.sGui:setInputFont(characterNameInput, "12/IckyticketMono-nKpJ.ttf")
  seexports.sGui:guiSetTooltip(characterNameInput, "Minimum 6 karakter, maximum 24 karakter.\nMinimum 2, maximum 4 részből állhat, melyeket szóközzel kell elválasztani.\nNem tartalmazhat számokat, ékezeteket és különleges karaktereket.\nPl.: 'Teszt Elek'")
  local label = seexports.sGui:createGuiElement("label", 48, 135, 294, 25, boardingPass)
  seexports.sGui:setLabelAlignment(label, "left", "center")
  seexports.sGui:setLabelText(label, " Liberty City International / Terminal 2")
  seexports.sGui:setLabelColor(label, "#484848")
  seexports.sGui:setLabelFont(label, "12/IckyticketMono-nKpJ.ttf")
  local label = seexports.sGui:createGuiElement("label", 353, 135, 294, 25, boardingPass)
  seexports.sGui:setLabelAlignment(label, "left", "center")
  seexports.sGui:setLabelText(label, " " .. toAirport .. " / Terminal A")
  seexports.sGui:setLabelColor(label, "#484848")
  seexports.sGui:setLabelFont(label, "12/IckyticketMono-nKpJ.ttf")
  local label = seexports.sGui:createGuiElement("label", 48, 191, 141, 25, boardingPass)
  seexports.sGui:setLabelAlignment(label, "left", "center")
  seexports.sGui:setLabelText(label, " Gate " .. utf8.char(65 + math.random(5)))
  seexports.sGui:setLabelColor(label, "#484848")
  seexports.sGui:setLabelFont(label, "12/IckyticketMono-nKpJ.ttf")
  local label = seexports.sGui:createGuiElement("label", 201, 191, 141, 25, boardingPass)
  seexports.sGui:setLabelAlignment(label, "left", "center")
  seexports.sGui:setLabelText(label, " SA111 / A" .. math.random(6, 10))
  seexports.sGui:setLabelColor(label, "#484848")
  seexports.sGui:setLabelFont(label, "12/IckyticketMono-nKpJ.ttf")
  local rt = getRealTime()
  local rt2 = getRealTime(math.floor((rt.timestamp - 2592000 + math.random(-15, 15) * 60) / 300 + 0.5) * 300)
  local rt3 = getRealTime(rt2.timestamp + math.random(6, 9) * 300)
  seexports.sWeather:setForceTime(12, 0, 0, 1)
  local label = seexports.sGui:createGuiElement("label", 353, 191, 294, 25, boardingPass)
  seexports.sGui:setLabelAlignment(label, "left", "center")
  seexports.sGui:setLabelText(label, " " .. seexports.sGui:formatDate("Y.m.d. h:i", "'", rt2.timestamp) .. " / " .. seexports.sGui:formatDate("Y.m.d. h:i", "'", rt3.timestamp))
  seexports.sGui:setLabelColor(label, "#484848")
  seexports.sGui:setLabelFont(label, "12/IckyticketMono-nKpJ.ttf")
  local button = seexports.sGui:createGuiElement("button", 334, 352, 100, "normal", boardingPass)
  seexports.sGui:setButtonText(button, "Tovább")
  seexports.sGui:setGuiFontScheme(button, "normal")
  seexports.sGui:setGuiColorScheme(button, "green")
  seexports.sGui:setClickEvent(button, "boardingPassNext", true)
  setSubtitles("")
end
local nameCheckInProgress = false
addEvent("characterNameResponse", true)
addEventHandler("characterNameResponse", getRootElement(), function(used)
  nameCheckInProgress = false
  if used then
    seexports.sGui:showInfobox("e", "A megadott név már foglalt!")
  else
    deleteBoardingPass()
    setPedAnimation(sceneElements.airport[1])
    setPedAnimation(sceneElements.airport[2], "GANGS", "prtial_gngtlkA")
    setSubtitles("Jó utat kívánunk! Viszont látásra!")
    setTimer(function()
      triggerServerEvent("tryCharacterCreation", localPlayer, characterName, selectedPlayerSkin)
    end, 3000, 1)
  end
end)
addEvent("successCharCreation", true)
addEventHandler("successCharCreation", getRootElement(), function()
  setPedAnimation(sceneElements.airport[2])
  setSubtitles("")
  setTimer(setupCharCreationStage, 1500, 1, 0)
end)
addEvent("boardingPassNext", true)
addEventHandler("boardingPassNext", getRootElement(), function()
  if not nameCheckInProgress then
    local name = utf8.gsub(seexports.sGui:getInputValue(characterNameInput) or "", "_", " ")
    if utf8.len(name) < 1 then
      seexports.sGui:showInfobox("e", "Add meg a karaktered nevét!")
    else
      name = split(name, " ")
      for i = #name, 1, -1 do
        if utf8.len(name[i]) < 1 then
          table.remove(name, i)
        end
      end
      if 4 < #name then
        seexports.sGui:showInfobox("e", "Maximum 3 részből állhat a név!")
      elseif #name < 2 then
        seexports.sGui:showInfobox("e", "Minimum 2 részből kell állnia a névnek!")
      else
        for k = 1, #name do
          name[k] = utf8.gsub(utf8.lower(name[k]), "^%l", utf8.upper)
        end
        name = table.concat(name, "_")
        if utf8.len(name) < 6 then
          seexports.sGui:showInfobox("e", "Minimum 6 karakter hosszú lehet a név!")
        elseif utf8.len(name) > 24 then
          seexports.sGui:showInfobox("e", "Maximum 24 karakter hosszú lehet a név!")
        elseif utf8.match(name, "[^a-zA-Z_]") then
          seexports.sGui:showInfobox("e", "A név csak ékezet nélküli betűket tartalmazhat!")
        else
          characterName = name
          nameCheckInProgress = true
          triggerServerEvent("checkCharacterName", localPlayer, name)
        end
      end
    end
  end
end)
function preRenderCharCreation()
  if sceneElements.airport2 and isElement(sceneElements.airport2[1]) then
    setElementDimension(sceneElements.airport2[1], getElementDimension(localPlayer))
    setElementDimension(sceneElements.airport2[2], getElementDimension(localPlayer))
  end
  if blurFadeOut then
    local progress = (getTickCount() - blurFadeOut) / 20000
    if 1 <= progress then
      progress = 1
      blurFadeOut = 0
    end
    dxSetShaderValue(movieShader, "blur", 0.005 * (1 - progress))
  end
  if cameraMatrix then
    if lastCityIntro and sceneElements.intro and isElement(sceneElements.intro[1]) then
      local progress = (getTickCount() - (cameraMatrix[1] + cameraMatrix[2] - 1000)) / 1000
      if 1 < progress then
        progress = 1
      end
      setStreamerModeVolume(sceneElements.intro[1], math.min(1, 1 - progress))
    end
    local progress = (getTickCount() - cameraMatrix[1]) / cameraMatrix[2]
    local x, y, z = interpolateBetween(cameraMatrix[3][1], cameraMatrix[3][2], cameraMatrix[3][3], cameraMatrix[4][1], cameraMatrix[4][2], cameraMatrix[4][3], progress, cameraMatrix[5])
    local tx, ty, tz = interpolateBetween(cameraMatrix[3][4], cameraMatrix[3][5], cameraMatrix[3][6], cameraMatrix[4][4], cameraMatrix[4][5], cameraMatrix[4][6], progress, cameraMatrix[5])
    setCameraMatrix(x, y, z, tx, ty, tz)
    if 1 <= progress then
      cameraMatrix = false
    end
  end
end
function renderCharCreation()
  if fadeScreen then
    local progress = math.min((getTickCount() - fadeScreen[1]) / 1000, 1)
    if getTickCount() - fadeScreen[1] > fadeScreen[2] + 1000 then
      progress = math.max(0, 1 - (getTickCount() - (fadeScreen[1] + (fadeScreen[2] + 1000))) / 1000)
    end
    local alpha = 255 * progress
    local x, y = 0, 0
    if fadeScreen[5] and getTickCount() - fadeScreen[1] > fadeScreen[2] + 1000 then
      alpha = 255
      if fadeScreen[7] == 1 then
        y = (screenY + 32) * (1 - progress)
      elseif fadeScreen[7] == 2 then
        y = -(screenY + 32) * (1 - progress)
      elseif fadeScreen[7] == 3 then
        x = (screenX + 32) * (1 - progress)
      else
        x = -(screenX + 32) * (1 - progress)
      end
      dxDrawRectangle(x + screenX, y, 2, screenY, fadeScreen[5])
      dxDrawRectangle(x - 2, y, 2, screenY, fadeScreen[5])
      dxDrawRectangle(x - 2, y - 2, screenX + 4, 2, fadeScreen[5])
      dxDrawRectangle(x - 2, y + screenY, screenX + 4, 2, fadeScreen[5])
    end
    if fadeScreen[6] then
      if sceneElements.intro and sceneElements.intro[3] then
        dxSetShaderValue(sceneElements.intro[3], "alpha", alpha / 255)
      end
      dxDrawImage(x, y, screenX, screenY, fadeScreen[6])
    else
      dxDrawRectangle(x, y, screenX, screenY, tocolor(0, 0, 0, alpha))
    end
    if fadeScreen[3] then
      dxDrawText(fadeScreen[3][1], x, y, x + screenX, y + screenY, tocolor(255, 255, 255, alpha), fadeScreen[3][3], fadeScreen[3][2], "center", "center", false, false, false, true)
    end
    if fadeScreen[4] then
      dxDrawText(fadeScreen[4][1], x, y, x + screenX - 64, y + screenY - 64, tocolor(255, 255, 255, alpha), fadeScreen[4][3], fadeScreen[4][2], "right", "bottom", false, false, false, true)
    end
    if getTickCount() - fadeScreen[1] > fadeScreen[2] + 1000 and progress <= 0 then
      fadeScreen = false
    end
  end
end
local wardrobePed = false
local wardrobeGui = false
local wardrobeMale = false
local wardrobeFemale = false
function nextWardrobeIdleAnimation()
  if wardrobePed then
    setPedAnimation(wardrobePed, "playidles", idles[math.random(#idles)], -1, false, false)
  end
end
local skins = false
local currentSkin = {1, 1}
function deleteWardrobe()
  showCursor(false)
  if wardrobeGui then
    seexports.sGui:deleteGuiElement(wardrobeGui)
  end
  if isElement(wardrobePed) then
    destroyElement(wardrobePed)
  end
  wardrobePed = false
  wardrobeGui = false
  wardrobeMale = false
  wardrobeFemale = false
end
function createCharacterWardrobe(time)
  deleteWardrobe()
  skins = seexports.sBinco:getSkins()
  setElementInterior(localPlayer, 14)
  setCameraMatrix(258.25390625, -39.514453125, 1002.85, 256.8984375, -42.7890625, 1002.0234375)
  characterGender = 1
  selectedPlayerSkin = skins["Férfi"][currentSkin[characterGender]]
  wardrobePed = createPed(selectedPlayerSkin, 256.8984375, -42.7890625, 1002.0234375, -20)
  setElementInterior(wardrobePed, 14)
  setElementDimension(wardrobePed, getElementDimension(localPlayer))
  nextWardrobeIdleAnimation()
  seexports.sWeather:setForceTime(8, 0, 0, 1)
  wardrobeGui = seexports.sGui:createGuiElement("null", 0, 0, screenX, screenY)
  local h = 48
  local button = seexports.sGui:createGuiElement("button", screenX / 2 - 50, screenY - h, 100, "normal", wardrobeGui)
  seexports.sGui:setButtonText(button, "Tovább")
  seexports.sGui:setGuiFontScheme(button, "normal")
  seexports.sGui:setGuiColorScheme(button, "green")
  setTimer(function()
    showCursor(true)
    seexports.sGui:setClickEvent(button, "wardrobeNextStep", true)
  end, 5000 + time + 1000, 1)
  fadeScreen = {
    getTickCount(),
    5000 + time,
    {
      "Eljött a nagy nap! Végre elhagyhatom ezt a várost...\n\nÖltözzünk fel az alkalomhoz illően!",
      seexports.sGui:getFont("27/Ubuntu-L.ttf"),
      seexports.sGui:getFontScale("27/Ubuntu-L.ttf")
    },
    {
      "1 hónappal ezelőtt",
      seexports.sGui:getFont("30/BebasNeueRegular.otf"),
      seexports.sGui:getFontScale("30/BebasNeueRegular.otf")
    }
  }
  local rect = seexports.sGui:createGuiElement("rectangle", screenX / 2 - h * 2, screenY - h - seexports.sGui:getGuiSize(button, "y") - 48, h * 4, h, wardrobeGui)
  seexports.sGui:setGuiBackground(rect, "solid", "sightgrey1")
  local previousButton = seexports.sGui:createGuiElement("image", screenX / 2 - h * 2, screenY - h - seexports.sGui:getGuiSize(button, "y") - 48, h, h, wardrobeGui)
  seexports.sGui:setImageFile(previousButton, seexports.sGui:getFaIconFilename("chevron-left", h))
  seexports.sGui:setGuiHoverable(previousButton, true)
  seexports.sGui:setGuiHover(previousButton, "solid", "sightgreen")
  seexports.sGui:setClickEvent(previousButton, "charPreviousSkin")
  wardrobeMale = seexports.sGui:createGuiElement("image", screenX / 2 - h, screenY - h - seexports.sGui:getGuiSize(button, "y") - 48, h, h, wardrobeGui)
  seexports.sGui:setImageFile(wardrobeMale, seexports.sGui:getFaIconFilename("male", h))
  seexports.sGui:setGuiHoverable(wardrobeMale, true)
  seexports.sGui:setImageColor(wardrobeMale, "sightgreen")
  seexports.sGui:setGuiHover(wardrobeMale, "solid", "sightgreen")
  seexports.sGui:setClickEvent(wardrobeMale, "setCharMale")
  seexports.sGui:guiSetTooltip(wardrobeMale, "Férfi skinek")
  wardrobeFemale = seexports.sGui:createGuiElement("image", screenX / 2, screenY - h - seexports.sGui:getGuiSize(button, "y") - 48, h, h, wardrobeGui)
  seexports.sGui:setImageFile(wardrobeFemale, seexports.sGui:getFaIconFilename("female", h))
  seexports.sGui:setGuiHoverable(wardrobeFemale, true)
  seexports.sGui:setGuiHover(wardrobeFemale, "solid", "sightgreen")
  seexports.sGui:setClickEvent(wardrobeFemale, "setCharFemale")
  seexports.sGui:guiSetTooltip(wardrobeFemale, "Női skinek")
  local nextButton = seexports.sGui:createGuiElement("image", screenX / 2 + h, screenY - h - seexports.sGui:getGuiSize(button, "y") - 48, h, h, wardrobeGui)
  seexports.sGui:setImageFile(nextButton, seexports.sGui:getFaIconFilename("chevron-right", h))
  seexports.sGui:setGuiHoverable(nextButton, true)
  seexports.sGui:setGuiHover(nextButton, "solid", "sightgreen")
  seexports.sGui:setClickEvent(nextButton, "charNextSkin")
  setFarClipDistance(550)
  setFogDistance(500)
  if not renderHandled then
    renderHandled = true
    addEventHandler("onClientRender", getRootElement(), renderCharCreation, true, "low-9999999999999999999999")
    addEventHandler("onClientPreRender", getRootElement(), preRenderCharCreation)
    addEventHandler("onClientHUDRender", getRootElement(), renderHUDCharCreation, true, "low")
    addEventHandler("onClientPlayerDamage", localPlayer, cancelDamage)
    sceneTarget = dxCreateScreenSource(screenX, screenY)
    movieShader = dxCreateShader(movieShaderSource)
    dxSetShaderValue(movieShader, "Hue", 0)
    dxSetShaderValue(movieShader, "Brightness", 0.05)
    dxSetShaderValue(movieShader, "Contrast", 0.13)
    dxSetShaderValue(movieShader, "Saturation", 1.2)
    dxSetShaderValue(movieShader, "R", 1.28)
    dxSetShaderValue(movieShader, "G", 1.1)
    dxSetShaderValue(movieShader, "B", 0.98)
    dxSetShaderValue(movieShader, "L", 0.74)
    dxSetShaderValue(movieShader, "noise", 0.16)
    dxSetShaderValue(movieShader, "blur", 0)
    dxSetShaderValue(movieShader, "sBaseTexture", sceneTarget)
  end
end
addEvent("wardrobeNextStep", true)
addEventHandler("wardrobeNextStep", getRootElement(), function()
  fadeScreen = {
    getTickCount(),
    2000,
    false,
    {
      "1 órával később",
      seexports.sGui:getFont("30/BebasNeueRegular.otf"),
      seexports.sGui:getFontScale("30/BebasNeueRegular.otf")
    }
  }
  showCursor(false)
  setTimer(setupAirportScene, 1500, 1)
end)
addEvent("charPreviousSkin", true)
addEventHandler("charPreviousSkin", getRootElement(), function()
  if currentSkin[characterGender] > 1 then
    currentSkin[characterGender] = currentSkin[characterGender] - 1
    selectedPlayerSkin = skins[characterGender == 1 and "Férfi" or "Női"][currentSkin[characterGender]]
    setElementModel(wardrobePed, selectedPlayerSkin)
    nextWardrobeIdleAnimation()
  end
end)
addEvent("charNextSkin", true)
addEventHandler("charNextSkin", getRootElement(), function()
  if currentSkin[characterGender] < #skins[characterGender == 1 and "Férfi" or "Női"] then
    currentSkin[characterGender] = currentSkin[characterGender] + 1
    selectedPlayerSkin = skins[characterGender == 1 and "Férfi" or "Női"][currentSkin[characterGender]]
    setElementModel(wardrobePed, selectedPlayerSkin)
    nextWardrobeIdleAnimation()
  end
end)
addEvent("setCharMale", true)
addEventHandler("setCharMale", getRootElement(), function()
  characterGender = 1
  selectedPlayerSkin = skins["Férfi"][currentSkin[characterGender]]
  setElementModel(wardrobePed, selectedPlayerSkin)
  nextWardrobeIdleAnimation()
  seexports.sGui:setImageColor(wardrobeMale, "sightgreen")
  seexports.sGui:setImageColor(wardrobeFemale, "#ffffff")
end)
addEvent("setCharFemale", true)
addEventHandler("setCharFemale", getRootElement(), function()
  characterGender = 2
  selectedPlayerSkin = skins["Női"][currentSkin[characterGender]]
  setElementModel(wardrobePed, selectedPlayerSkin)
  nextWardrobeIdleAnimation()
  seexports.sGui:setImageColor(wardrobeFemale, "sightgreen")
  seexports.sGui:setImageColor(wardrobeMale, "#ffffff")
end)
local sceneSubtitleBcg = false
local sceneSubtitleText = false
function setSubtitles(text)
  if utf8.len(text) > 0 then
    text = " " .. text .. " "
  end
  local h = seexports.sGui:getFontHeight("17/Ubuntu-L.ttf") + 4
  local w = seexports.sGui:getTextWidthFont(text, "17/Ubuntu-L.ttf")
  seexports.sGui:setGuiPosition(sceneSubtitleBcg, screenX / 2 - w / 2, screenY - h - 48)
  seexports.sGui:setGuiSize(sceneSubtitleBcg, w, h)
  seexports.sGui:setLabelText(sceneSubtitleText, text)
end
function airportSceneHandover()
  setPedAnimation(sceneElements.airport[1])
  setPedAnimation(sceneElements.airport[2], "GANGS", "prtial_gngtlkA")
  setSubtitles("Üdvözlöm " .. (characterGender == 1 and "uram" or "hölgyem") .. "! Máris adom a beszállókártyát.")
  setTimer(createBoardingPass, 3500, 1)
end
local sceneHandled = false
local sceneGui = false
addEventHandler("onClientResourceStop", getRootElement(), function()
  for i = 1, #sceneMarkers do
    seexports.sMarkers:deleteCustomMarker(sceneMarkers[i])
    sceneMarkers[i] = nil
  end
end)
function clearSceneElements()
  for scene in pairs(sceneElements) do
    if sceneElements[scene] then
      for k = 1, #sceneElements[scene] do
        if isElement(sceneElements[scene][k]) then
          destroyElement(sceneElements[scene][k])
        end
      end
    end
  end
  for i = 1, #sceneMarkers do
    seexports.sMarkers:deleteCustomMarker(sceneMarkers[i])
    sceneMarkers[i] = nil
  end
  sceneElements = {}
  if sceneGui then
    seexports.sGui:deleteGuiElement(sceneGui)
  end
  sceneGui = false
end
function setupAirportScene()
  dxSetShaderValue(movieShader, "Hue", 0)
  dxSetShaderValue(movieShader, "Brightness", 0)
  dxSetShaderValue(movieShader, "Contrast", 0)
  dxSetShaderValue(movieShader, "Saturation", 1)
  dxSetShaderValue(movieShader, "R", 1)
  dxSetShaderValue(movieShader, "G", 1)
  dxSetShaderValue(movieShader, "B", 1)
  dxSetShaderValue(movieShader, "L", 1)
  dxSetShaderValue(movieShader, "noise", 0.16)
  dxSetShaderValue(movieShader, "blur", 0)
  deleteWardrobe()
  clearSceneElements()
  cameraMatrix = {
    getTickCount(),
    6000,
    {
      -1837.830078125,
      13.4580078125,
      1064.1435546875,
      -1835.4951171875,
      18.5322265625,
      1061.1435546875
    },
    {
      -1838.1494140625,
      17.14453125,
      1062.1435546875,
      -1835.4951171875,
      19.5322265625,
      1061.1435546875
    },
    "OutQuad"
  }
  local ped = createPed(selectedPlayerSkin, -1835.4580078125, 12, 1061.1435546875)
  setElementInterior(ped, 14)
  setElementDimension(ped, getElementDimension(localPlayer))
  setPedAnimation(ped, "ped", "WALK_player")
  local stopCol = createColSphere(-1835.4580078125, 18.45, 1061.1435546875, 0.5)
  addEventHandler("onClientElementColShapeHit", ped, function(hitElement)
    if isElement(hitElement) and hitElement == stopCol then
      setPedAnimation(ped, "GANGS", "prtial_gngtlkA")
      setSubtitles("Szép napot hölgyem!")
      setTimer(setSubtitles, 2000, 1, "A " .. toCity .. "i járatra szeretnék becsekkolni.")
      setTimer(airportSceneHandover, 4500, 1)
      destroyElement(hitElement)
    end
  end)
  skins = seexports.sBinco:getSkins()
  local clerkPed3 = createPed(76, -1824.5302734375, 20.171875, 1061.1435546875, 180)
  setElementInterior(clerkPed3, 14)
  setElementDimension(clerkPed3, getElementDimension(localPlayer))
  local clerkPed2 = createPed(76, -1829.7802734375, 20.171875, 1061.1435546875, 180)
  setElementInterior(clerkPed2, 14)
  setElementDimension(clerkPed2, getElementDimension(localPlayer))
  local clerkPed = createPed(76, -1835.4580078125, 20.171875, 1061.1435546875, 180)
  setElementInterior(clerkPed, 14)
  setElementDimension(clerkPed, getElementDimension(localPlayer))
  local airport = playSound("files/airport.mp3", true)
  sceneElements.airport = {
    ped,
    clerkPed,
    stopCol,
    clerkPed2,
    clerkPed3,
    airport
  }
  setTimer(setPedControlState, 1000, 1, ped, "enter_passenger", true)
  local h = seexports.sGui:getFontHeight("17/Ubuntu-L.ttf") + 4
  if sceneSubtitleBcg then
    seexports.sGui:deleteGuiElement(sceneSubtitleBcg)
  end
  if sceneSubtitleText then
    seexports.sGui:deleteGuiElement(sceneSubtitleText)
  end
  sceneSubtitleBcg = seexports.sGui:createGuiElement("rectangle", screenX / 2, screenY - h - 48, 0, h, wardrobeGui)
  seexports.sGui:setGuiBackground(sceneSubtitleBcg, "solid", "#000000ae")
  sceneSubtitleText = seexports.sGui:createGuiElement("label", 0, screenY - h - 48, screenX, h, panel)
  seexports.sGui:setLabelAlignment(sceneSubtitleText, "center", "center")
  seexports.sGui:setLabelFont(sceneSubtitleText, "17/Ubuntu-L.ttf")
  seexports.sGui:setLabelText(sceneSubtitleText, " ")
end
local copterStart = false
local starNotified = false
local islandTick = 0
local insectSoundState = false
local nextInsectState = getTickCount() + 10000
function cancelDamage(attacker, weapon, bodyPart, loss)
  cancelEvent()
end
function setupCharCreationStage(stage)
  showChat(false)
  if sceneSubtitleBcg then
    seexports.sGui:deleteGuiElement(sceneSubtitleBcg)
  end
  if sceneSubtitleText then
    seexports.sGui:deleteGuiElement(sceneSubtitleText)
  end
  local h = seexports.sGui:getFontHeight("17/Ubuntu-L.ttf") + 4
  sceneSubtitleBcg = seexports.sGui:createGuiElement("rectangle", screenX / 2, screenY - h - 48, 0, h, wardrobeGui)
  seexports.sGui:setGuiBackground(sceneSubtitleBcg, "solid", "#000000ae")
  sceneSubtitleText = seexports.sGui:createGuiElement("label", 0, screenY - h - 48, screenX, h, panel)
  seexports.sGui:setLabelAlignment(sceneSubtitleText, "center", "center")
  seexports.sGui:setLabelFont(sceneSubtitleText, "17/Ubuntu-L.ttf")
  seexports.sGui:setLabelText(sceneSubtitleText, " ")
  triggerServerEvent("setCharacterCreationStage", localPlayer, stage)
  if not renderHandled and stage < 7 then
    renderHandled = true
    addEventHandler("onClientRender", getRootElement(), renderCharCreation, true, "low-9999999999999999999999")
    addEventHandler("onClientPreRender", getRootElement(), preRenderCharCreation)
    addEventHandler("onClientHUDRender", getRootElement(), renderHUDCharCreation, true, "low")
    addEventHandler("onClientPlayerDamage", localPlayer, cancelDamage)
    sceneTarget = dxCreateScreenSource(screenX, screenY)
    movieShader = dxCreateShader(movieShaderSource)
    vignetteGui = seexports.sGui:createGuiElement("image", 0, 0, screenX, screenY)
    seexports.sGui:setImageDDS(vignetteGui, "files/vignette.dds")
    dxSetShaderValue(movieShader, "sBaseTexture", sceneTarget)
  end
  seexports.sWater:setWaterDimension(getElementDimension(localPlayer))
  seexports.sWeather:resetWeather()
  seexports.sDashboard:resetFogAndFarClip()
  if 2 <= stage and stage < 7 then
    seexports.sWeather:setForceTime(12, 0, 0, 1)
    setTimer(function()
      dxSetShaderValue(movieShader, "Hue", 0)
      dxSetShaderValue(movieShader, "Brightness", 0)
      dxSetShaderValue(movieShader, "Contrast", 0.156)
      dxSetShaderValue(movieShader, "Saturation", 1.2)
      dxSetShaderValue(movieShader, "R", 1.28)
      dxSetShaderValue(movieShader, "G", 1.1)
      dxSetShaderValue(movieShader, "B", 0.98)
      dxSetShaderValue(movieShader, "L", 0.74)
      dxSetShaderValue(movieShader, "noise", 0.16)
      dxSetShaderValue(movieShader, "blur", 0)
      setFarClipDistance(1300)
      setFogDistance(400)
    end, 1000, 1)
  end
  if 0 < stage then
    setElementInterior(localPlayer, 0)
  end
  if stage == 0 then
    if 1 == 1 then
        removeEventHandler("onClientElementColShapeHit", localPlayer, hitColIsland2)
        removeEventHandler("onClientRender", getRootElement(), renderIsland2)
        setupCharCreationStage(5)
        return
    end
    seexports.sWeather:setForceTime(12, 0, 0, 1)
    fadeScreen = {
      getTickCount(),
      3000,
      false,
      {
        "3 órával később",
        seexports.sGui:getFont("30/BebasNeueRegular.otf"),
        seexports.sGui:getFontScale("30/BebasNeueRegular.otf")
      }
    }
    setTimer(function()
      dxSetShaderValue(movieShader, "Hue", 0)
      dxSetShaderValue(movieShader, "Brightness", 0.12)
      dxSetShaderValue(movieShader, "Contrast", 0.3)
      dxSetShaderValue(movieShader, "Saturation", 0.7)
      dxSetShaderValue(movieShader, "R", 0.76)
      dxSetShaderValue(movieShader, "G", 0.76)
      dxSetShaderValue(movieShader, "B", 0.92)
      dxSetShaderValue(movieShader, "L", 1.22)
      dxSetShaderValue(movieShader, "noise", 0.5)
    end, 1000, 1)
    setTimer(function()
      clearSceneElements()
      local sound = playSound("files/plane.mp3", true)
      local sound2 = playSound("files/airplanechillbackground.mp3", true)
      setStreamerModeVolume(sound2, 1)
      skins = seexports.sBinco:getSkins()
      setElementInterior(localPlayer, 0)
      local color = seexports.sGui:getColorCode("sightgreen")
      local plane = createVehicle(577, 0, 0, 3000)
      setElementDimension(plane, getElementDimension(localPlayer))
      setVehicleColor(plane, 255, 255, 255, color[1], color[2], color[3])
      setElementFrozen(plane, true)
      seexports.sWeather:setForceTime(0, 0, 0, 8)
      sceneElements.plane1 = {
        plane,
        sound,
        sound2
      }
      for h = -6, 11 do
        for i = 0, 3 do
          if 3 <= math.random(1, 10) or h == 7 and i == 1 then
            local skinsToChoose = skins[math.random(2) == 1 and "Férfi" or "Női"]
            local skin = skinsToChoose[math.random(#skinsToChoose)]
            if skin ~= selectedPlayerSkin or h == 7 and i == 1 then
              local x, y, z = 1.107421875 + i, 0.9898437500000004 + h * 1.5, 3004.28906059265
              if 1 < i then
                x = -2.1 + (i - 2)
              end
              if h < 2 then
                y = 0.8 + (h - 1) * 1.5
              end
              if h == 7 and i == 1 then
                skin = selectedPlayerSkin
                cameraMatrix = {
                  getTickCount(),
                  17000,
                  {
                    x - 3.5,
                    y + 10.5,
                    z + 1.55,
                    x,
                    y - 0.25,
                    z
                  },
                  {
                    x - 2.25,
                    y + 0.65,
                    z + 0.75,
                    x,
                    y - 0.25,
                    z
                  },
                  "OutQuad"
                }
              end
              local ped = createPed(skin, x, y, z, 0)
              setElementDimension(ped, getElementDimension(localPlayer))
              attachElements(ped, plane, x, y, z - 3000)
              setPedAnimation(ped, "ped", "SEAT_idle", -1, true, false, false)
              table.insert(sceneElements.plane1, ped)
            end
          end
        end
      end
      setTimer(setSubtitles, 25000, 1, "Tisztelt utasaink! Váratlan viharba keveredtünk. Kérjük őrizzék meg nyugalmukat!")
      setTimer(function()
        playSound("files/airplbeep.wav")
        if isElement(sceneElements.plane1[3]) then
          destroyElement(sceneElements.plane1[3])
        end
        sceneElements.plane1[3] = playSound("files/airplanedisbackmusic.mp3", true)
        setStreamerModeVolume(sceneElements.plane1[3], 1)
      end, 25000, 1)
      setTimer(setSubtitles, 31000, 1, "")
      setTimer(function()
        table.insert(sceneElements.plane1, playSound("files/airplthunder.mp3"))
        local level = 0
        setTimer(function()
          table.insert(sceneElements.plane1, playSound("files/airplaneofferror.mp3"))
        end, 2000, 1)
        setTimer(function()
          local x, y, z = getCameraMatrix(localPlayer)
          level = level + 0.2
          createExplosion(x, y, z - 50, 12, false, math.min(1.5, level), false)
        end, 500, 14)
        setTimer(function()
          playSound("files/crash.wav")
          clearSceneElements()
          sceneGui = seexports.sGui:createGuiElement("null", 0, 0, screenX, screenY)
          local rect = seexports.sGui:createGuiElement("rectangle", 0, 0, screenX, screenY, sceneGui)
          seexports.sGui:setGuiBackground(rect, "solid", "#000000")
          setupCharCreationStage(1)
        end, 6000, 1)
      end, 32500, 1)
    end, 1500, 1)
  elseif stage == 1 then
    fadeScreen = {
      getTickCount(),
      4000,
      false,
      false
    }
    seexports.sWeather:setForceTime(0, 0, 0, 9)
    setTimer(function()
      dxSetShaderValue(movieShader, "Hue", 3.6)
      dxSetShaderValue(movieShader, "Brightness", 0.22)
      dxSetShaderValue(movieShader, "Contrast", 0.6)
      dxSetShaderValue(movieShader, "Saturation", 0.64)
      dxSetShaderValue(movieShader, "R", 0.52)
      dxSetShaderValue(movieShader, "G", 0.825)
      dxSetShaderValue(movieShader, "B", 1.25)
      dxSetShaderValue(movieShader, "L", 1.21)
      dxSetShaderValue(movieShader, "noise", 0.5)
      dxSetShaderValue(movieShader, "blur", 0.005)
    end, 1000, 1)
    setElementFrozen(localPlayer, true)
    setWaterColor(60, 70, 80, 255)
    setSkyGradient(2, 4, 10, 5, 10, 15)
    setFarClipDistance(175)
    setFogDistance(-50)
    setTimer(function()
      local effect = createEffect("smoke50lit", 6977.3720703125, -49.0146484375, 7.0994729995728)
      setEffectDensity(effect, 2)
      local sound2 = playSound("files/scaryisland.mp3", true)
      local sound = playSound("files/thunderisland.mp3", true)
      playSound("files/breath.mp3")
      setCameraTarget(localPlayer)
      setElementPosition(localPlayer, 6989.693359375, -36.201171875, 7.1042098999023)
      setElementRotation(localPlayer, 0, 0, 60)
      blurFadeOut = getTickCount()
      clearSceneElements()
      setWindVelocity(4, 0, 0)
      setWaveHeight(0.4)
      setTimer(function()
        setElementFrozen(localPlayer, false)
        setPedAnimation(localPlayer, "CRACK", "crckidle2", -1, true, false, false)
      end, 2000, 1)
      local x2, y2, z2 = getElementPosition(localPlayer)
      local x, y, z = getPositionOffset(x2, y2, z2, 0, 0, 60, 3, 3, 0.25)
      local to = {
        x,
        y,
        z - 1,
        x2,
        y2,
        z2 - 1
      }
      local x, y, z = getPositionOffset(x2, y2, z2, 0, 0, 60, 15, 20, 13.5)
      local from = {
        x,
        y,
        z - 1,
        x2,
        y2,
        z2 - 1
      }
      cameraMatrix = {
        getTickCount(),
        10000,
        from,
        to,
        "OutQuad"
      }
      skins = seexports.sBinco:getSkins()
      local skinsToChoose = skins[math.random(2) == 1 and "Férfi" or "Női"]
      local ped1 = createPed(skinsToChoose[math.random(#skinsToChoose)], 6979.603515625, -45.6708984375, 5.1440258026123, 68)
      setTimer(setPedAnimation, 1000, 1, ped1, "crack", "crckdeth1", -1, false, true, false, true)
      setElementDimension(ped1, getElementDimension(localPlayer))
      local skinsToChoose = skins[math.random(2) == 1 and "Férfi" or "Női"]
      local ped2 = createPed(skinsToChoose[math.random(#skinsToChoose)], 6973.2919921875, -39.6513671875, 4.3686790466309, 259)
      setTimer(setPedAnimation, 1000, 1, ped2, "crack", "crckdeth2", -1, false, true, false, true)
      setElementDimension(ped2, getElementDimension(localPlayer))
      local skinsToChoose = skins[math.random(2) == 1 and "Férfi" or "Női"]
      local ped3 = createPed(skinsToChoose[math.random(#skinsToChoose)], 6996.361328125, -33.7724609375, 7.4343452453613, 97)
      setTimer(setPedAnimation, 1000, 1, ped3, "crack", "crckdeth3", -1, false, true, false, true)
      setElementDimension(ped3, getElementDimension(localPlayer))
      local skinsToChoose = skins[math.random(2) == 1 and "Férfi" or "Női"]
      local ped4 = createPed(skinsToChoose[math.random(#skinsToChoose)], 6971.521484375, -36.04296875, 4.111780166626, 312)
      setTimer(setPedAnimation, 1000, 1, ped4, "crack", "crckdeth4", -1, false, true, false, true)
      setElementDimension(ped4, getElementDimension(localPlayer))
      setTimer(function()
        setCameraTarget(localPlayer)
        setPedAnimation(localPlayer)
        setTimer(function()
          local h = seexports.sGui:getFontHeight("12/Ubuntu-L.ttf") + 8
          local w = seexports.sGui:getTextWidthFont(" Találj menedéket a sziget belsejében ", "12/Ubuntu-L.ttf")
          sceneGui = seexports.sGui:createGuiElement("null", -(48 + w + h + 48), 0, screenX, screenY)
          local rect = seexports.sGui:createGuiElement("rectangle", 48, 48, h + w, h, sceneGui)
          seexports.sGui:setGuiBackground(rect, "solid", "#000000ae")
          local rect = seexports.sGui:createGuiElement("rectangle", 48, 48, h, h, sceneGui)
          seexports.sGui:setGuiBackground(rect, "solid", "#000000ae")
          local label = seexports.sGui:createGuiElement("label", 48 + h, 48, w, h, sceneGui)
          seexports.sGui:setLabelAlignment(label, "center", "center")
          seexports.sGui:setLabelText(label, "Találj " .. seexports.sGui:getColorCodeHex("sightgreen") .. "menedéket #ffffffa sziget belsejében")
          seexports.sGui:setLabelFont(label, "12/Ubuntu-L.ttf")
          local icon = seexports.sGui:createGuiElement("image", 48, 48, h, h, sceneGui)
          seexports.sGui:setImageFile(icon, seexports.sGui:getFaIconFilename("bullseye", h))
          seexports.sGui:setImageColor(icon, "sightgreen")
          setTimer(function()
            playSound("files/hint.mp3")
            seexports.sGui:setGuiPositionAnimated(sceneGui, 0, 0, 1000, false, "OutQuad")
            local nextCol = createColSphere(7527.7119140625, -76.4423828125, 65.0939636230475, 1)
            setElementDimension(nextCol, getElementDimension(localPlayer))
            local marker = seexports.sMarkers:createCustomMarker(7527.7119140625, -76.4423828125, 65.0939636230475, 0, getElementDimension(localPlayer), "sightgreen", "arrow")
            table.insert(sceneMarkers, marker)
            addEventHandler("onClientElementColShapeHit", localPlayer, hitColIsland1)
            sceneElements.island1 = {
              nextCol,
              false,
              sound,
              sound2,
              effect,
              ped1,
              ped2,
              ped3,
              ped4
            }
            islandTick = getTickCount()
            starNotified = false
            addEventHandler("onClientRender", getRootElement(), renderIsland1)
          end, 1000, 1)
        end, 3000, 1)
      end, 11000, 1)
    end, 1000, 1)
  elseif stage == 2 then
    if not fadeScreen then
      fadeScreen = {
        getTickCount(),
        6000,
        false,
        false
      }
    end
    copterStart = false
    setElementFrozen(localPlayer, true)
    setFarClipDistance(1300)
    setFogDistance(40)
    seexports.sWeather:setForceTime(12, 0, 0, 1)
    do
      local instects = createEffect("insects", 0, 0, 0)
      setEffectDensity(instects, 2)
      setElementDimension(instects, getElementDimension(localPlayer))
      local nature = playSound("files/natureisland.mp3")
      setCameraTarget(localPlayer)
      setElementPosition(localPlayer, 7527.7119140625, -76.4423828125, 66.093963623047)
      setElementRotation(localPlayer, 0, 0, 208)
      setWindVelocity(1.5, 0, 0)
      setWaveHeight(0.15)
      clearSceneElements()
      setTimer(function()
        setElementFrozen(localPlayer, false)
        setPedAnimation(localPlayer)
        local copterSound = playSound3D("files/rescuecopter.mp3", 7499.4853515625, -233.94921875, 194.6976318359, true)
        setSoundMaxDistance(copterSound, 1000)
        setElementDimension(copterSound, getElementDimension(localPlayer))
        local h = seexports.sGui:getFontHeight("12/Ubuntu-L.ttf") + 8
        local w = seexports.sGui:getTextWidthFont(" Menj a partra, ahol már vár a mentőcsapat ", "12/Ubuntu-L.ttf")
        sceneGui = seexports.sGui:createGuiElement("null", -(48 + w + h + 48), 0, screenX, screenY)
        local rect = seexports.sGui:createGuiElement("rectangle", 48, 48, h + w, h, sceneGui)
        seexports.sGui:setGuiBackground(rect, "solid", "#000000ae")
        local rect = seexports.sGui:createGuiElement("rectangle", 48, 48, h, h, sceneGui)
        seexports.sGui:setGuiBackground(rect, "solid", "#000000ae")
        local label = seexports.sGui:createGuiElement("label", 48 + h, 48, w, h, sceneGui)
        seexports.sGui:setLabelAlignment(label, "center", "center")
        seexports.sGui:setLabelText(label, "Menj a " .. seexports.sGui:getColorCodeHex("sightyellow") .. "partra#ffffff, ahol már vár a mentőcsapat")
        seexports.sGui:setLabelFont(label, "12/Ubuntu-L.ttf")
        local icon = seexports.sGui:createGuiElement("image", 48, 48, h, h, sceneGui)
        seexports.sGui:setImageFile(icon, seexports.sGui:getFaIconFilename("bullseye", h))
        seexports.sGui:setImageColor(icon, "sightyellow")
        setTimer(function()
          playSound("files/hint.mp3")
          seexports.sGui:setGuiPositionAnimated(sceneGui, 0, 0, 1000, false, "OutQuad")
          local nextCol = createColSphere(7064.8759765625, 179.1083984375, 1.7733249664307, 1)
          setElementDimension(nextCol, getElementDimension(localPlayer))
          local marker = seexports.sMarkers:createCustomMarker(7064.8759765625, 179.1083984375, 1.7733249664307, 0, getElementDimension(localPlayer), "sightyellow", "arrow")
          table.insert(sceneMarkers, marker)
          addEventHandler("onClientElementColShapeHit", localPlayer, hitColIsland2)
          local boat1 = createVehicle(472, 7053.076171875, 197.64491271973, 0.082938462495804, 0, 0, math.random(220000, 235000) / 1000)
          local ped1 = createPed(284, 7053.076171875, 197.64491271973, 0.082938462495804)
          warpPedIntoVehicle(ped1, boat1)
          setElementDimension(boat1, getElementDimension(localPlayer))
          setElementDimension(ped1, getElementDimension(localPlayer))
          local boat2 = createVehicle(472, 7045.3051757813, 204.70700073242, 0.093194171786308, 0, 0, math.random(220000, 235000) / 1000)
          local ped2 = createPed(284, 7045.3051757813, 204.70700073242, 0.093194171786308)
          warpPedIntoVehicle(ped2, boat2)
          setElementDimension(boat2, getElementDimension(localPlayer))
          setElementDimension(ped2, getElementDimension(localPlayer))
          local heli = createVehicle(563, 7499.4853515625, -233.94921875, 194.6976318359, 0, 0, 260)
          setElementFrozen(heli, true)
          setElementDimension(heli, getElementDimension(localPlayer))
          local ped3 = createPed(275, 7061.1884765625, 180.9365234375, 1.7560302019119, 237)
          setPedAnimation(ped3, "ped", "roadcross")
          setElementDimension(ped3, getElementDimension(localPlayer))
          local ped4 = createPed(276, 7063.6904296875, 182.0869140625, 1.7733249664307, 208)
          setPedAnimation(ped4, "on_lookers", "panic_shout")
          setElementDimension(ped4, getElementDimension(localPlayer))
          local ped5 = createPed(274, 7070.7314453125, 174.806640625, 1.9202117919922, 208)
          setPedAnimation(ped5, "on_lookers", "lkup_loop")
          setElementDimension(ped5, getElementDimension(localPlayer))
          local sound2 = playSound3D("files/rescueteam.mp3", 7064.8759765625, 179.1083984375, 1.7733249664307, true)
          setSoundMaxDistance(sound2, 500)
          setElementDimension(sound2, getElementDimension(localPlayer))
          setTimer(function()
            seexports.sGui:showInfobox("i", "Tipp: kövesd a helikopter hangját!")
          end, 2000, 1)
          islandTick = getTickCount()
          starNotified = false
          sceneElements.island2 = {
            nextCol,
            boat1,
            boat2,
            heli,
            ped1,
            ped2,
            ped3,
            ped4,
            ped5,
            copterSound,
            sound2,
            nature,
            instects
          }
          copterStart = getTickCount()
          insectSoundState = false
          nextInsectState = getTickCount() + 10000
          addEventHandler("onClientRender", getRootElement(), renderIsland2)
        end, 5000, 1)
      end, 4000, 1)
    end
  elseif stage == 3 then
    if not fadeScreen then
      setElementFrozen(localPlayer, true)
      fadeScreen = {
        getTickCount(),
        3000,
        false,
        {
          "30 perccel később",
          seexports.sGui:getFont("30/BebasNeueRegular.otf"),
          seexports.sGui:getFontScale("30/BebasNeueRegular.otf")
        }
      }
    end
    seexports.sWeather:setForceTime(12, 0, 0, 1)
    setCameraTarget(localPlayer)
    setElementPosition(localPlayer, 7057.75, 186.265625, 2.7733249664307)
    setElementRotation(localPlayer, 0, 0, 0)
    resetWindVelocity()
    setWaveHeight(0.2)
    clearSceneElements()
    setTimer(function()
      setTimer(playSound, 1000, 1, "files/rescue.mp3")
      setElementFrozen(localPlayer, false)
      setPedAnimation(localPlayer)
      local boat1 = createVehicle(472, 7053.076171875, 212.64491271973, 0.082938462495804, 0, 0, 0)
      local ped1 = createPed(284, 7053.076171875, 212.64491271973, 0.082938462495804)
      warpPedIntoVehicle(ped1, boat1)
      setElementDimension(boat1, getElementDimension(localPlayer))
      setElementDimension(ped1, getElementDimension(localPlayer))
      local boat2 = createVehicle(472, 7046.076171875, 202.64491271973, 0.082938462495804, 0, 0, 0)
      local ped2 = createPed(284, 7053.076171875, 202.64491271973, 0.082938462495804)
      warpPedIntoVehicle(ped2, boat2)
      setElementDimension(boat2, getElementDimension(localPlayer))
      setElementDimension(ped2, getElementDimension(localPlayer))
      setTimer(setPedControlState, 1000, 1, ped1, "accelerate", true)
      setTimer(setPedControlState, 1000, 1, ped2, "accelerate", true)
      setPedAnimation(localPlayer, "ped", "SEAT_idle", -1, true, false, false)
      local ped3 = createPed(275, 7053.076171875, 197.64491271973, 1.082938462495804, 0)
      local ped4 = createPed(276, 7053.076171875, 197.64491271973, 1.082938462495804, 0)
      local ped5 = createPed(274, 7053.076171875, 197.64491271973, 1.082938462495804, 0)
      setElementDimension(ped3, getElementDimension(localPlayer))
      setElementDimension(ped4, getElementDimension(localPlayer))
      setElementDimension(ped5, getElementDimension(localPlayer))
      setPedAnimation(ped3, "ped", "SEAT_idle", -1, true, false, false)
      setPedAnimation(ped4, "ped", "SEAT_idle", -1, true, false, false)
      setPedAnimation(ped5, "ped", "SEAT_idle", -1, true, false, false)
      local z = getElementDistanceFromCentreOfMassToBaseOfModel(localPlayer) - 0.1
      attachElements(localPlayer, boat1, -0.35, -2.25, z)
      setTimer(attachElements, 1000, 1, ped3, boat1, 0.35, -2.25, z)
      setTimer(attachElements, 1000, 1, ped4, boat2, 0.35, -2.25, z)
      setTimer(attachElements, 1000, 1, ped5, boat2, -0.35, -2.25, z)
      addEventHandler("onClientRender", getRootElement(), renderIsland3)
      sceneElements.island3 = {
        boat1,
        ped1,
        boat2,
        ped2,
        ped3,
        ped4,
        ped5
      }
      setTimer(setupCharCreationStage, 8000, 1, 4)
      setTimer(function()
        removeEventHandler("onClientRender", getRootElement(), renderIsland3)
      end, 9000, 1)
    end, 1000, 1)
  elseif stage == 4 then
    fadeScreen = {
      getTickCount(),
      4000,
      {
        "Valami csoda folytán túléltem ezt a katasztrófát...",
        seexports.sGui:getFont("27/Ubuntu-L.ttf"),
        seexports.sGui:getFontScale("27/Ubuntu-L.ttf")
      },
      false
    }
    setTimer(function()
      clearSceneElements()
      sceneGui = seexports.sGui:createGuiElement("null", 0, 0, screenX, screenY)
      local rect = seexports.sGui:createGuiElement("rectangle", 0, 0, screenX, screenY, sceneGui)
      seexports.sGui:setGuiBackground(rect, "solid", "#000000")
      setTimer(function()
        setTimer(setCameraMatrix, 1000, 1, 1462.4736328125, -885.16998291016, 78.666496276855, 1415.5435791016, -797.06292724609, 84.558662414551)
        fadeScreen = {
          getTickCount(),
          4000,
          {
            "A kórházi kezelésem után folytathattam utamat\nLos Santosba, a remény városába.",
            seexports.sGui:getFont("27/Ubuntu-L.ttf"),
            seexports.sGui:getFontScale("27/Ubuntu-L.ttf")
          },
          false
        }
        setTimer(setupCharCreationStage, 4000, 1, 5)
      end, 5000, 1)
    end, 2000, 1)
  elseif stage == 5 then
    clearSceneElements()
    sceneGui = seexports.sGui:createGuiElement("null", 0, 0, screenX, screenY)
    local rect = seexports.sGui:createGuiElement("rectangle", 0, 0, screenX, screenY, sceneGui)
    seexports.sGui:setGuiBackground(rect, "solid", "#000000")
    setTimer(function()
      fadeScreen = {
        getTickCount(),
        3000,
        {
          "A SightMTA bemutatja:",
          seexports.sGui:getFont("40/BebasNeueRegular.otf"),
          seexports.sGui:getFontScale("40/BebasNeueRegular.otf")
        }
      }
      setTimer(function()
        local light = seexports.sGui:createGuiElement("image", screenX / 2 - 410, screenY / 2 - 330, 820, 660, sceneGui)
        seexports.sGui:setImageDDS(light, ":sAccounts/files/light.dds")
        seexports.sGui:fadeOut(light, 0)
        local logo = seexports.sGui:createGuiElement("logo", screenX / 2, screenY / 2, 768, 768, sceneGui)
        seexports.sGui:setLogoAnimated(logo, true)
        seexports.sGui:playLogoAnimation(logo, "in", 0)
        seexports.sGui:fadeIn(logo, 4000)
        seexports.sGui:setGuiSizeAnimated(logo, 384, 384, 3000, false, "InOutQuad")
        playSound("files/logohexa.mp3")
        setTimer(function()
          playSound("files/logoimpact1.mp3")
          setTimer(playSound, 400, 1, "files/logoimpact2.mp3")
          setTimer(playSound, 800, 1, "files/logoimpact3.mp3")
          setTimer(playSound, 1200, 1, "files/logoimpact1.mp3")
        end, 3000, 1)
        setTimer(function()
          local label = seexports.sGui:createGuiElement("label", 0, screenY / 2 + 192, screenX, 48, sceneGui)
          seexports.sGui:setLabelFont(label, "32/Ubuntu-L.ttf")
          seexports.sGui:setLabelText(label, "SightMTA")
          seexports.sGui:fadeInLabel(label, 1200)
          local label = seexports.sGui:createGuiElement("label", 0, seexports.sGui:getGuiPosition("last", "y") + seexports.sGui:getGuiSize("last", "y"), screenX, 24, sceneGui)
          seexports.sGui:setLabelFont(label, "13/Ubuntu-L.ttf")
          seexports.sGui:setLabelText(label, "w w w . s i g h t m t a . h u")
          seexports.sGui:setLabelColor(label, "sightgreen")
          seexports.sGui:fadeInLabel(label, 1200)
        end, 4200, 1)
        setTimer(function()
          seexports.sGui:fadeIn(light, 3000)
        end, 4600, 1)
        setTimer(function()
          fadeScreen = {
            getTickCount(),
            1000,
            false,
            false,
            seexports.sGui:getColorCodeToColor("sightyellow")
          }
          setTimer(setCityIntroState, 1000, 1, 1)
        end, 11000, 1)
      end, 5000, 1)
    end, 2000, 1)
  elseif stage == 6 then
    clearSceneElements()
    fadeScreen = {
      getTickCount(),
      3000,
      false,
      {
        "Napjainkban",
        seexports.sGui:getFont("30/BebasNeueRegular.otf"),
        seexports.sGui:getFontScale("30/BebasNeueRegular.otf")
      }
    }
    playSound("files/airp.mp3")
    setTimer(function()
      setCameraMatrix(1503.22265625, -2494.0400390625, 13.5546875, 1503.22265625, -2494.0400390625, 23.5546875, 270)
      local meat = createObject(2803, 1443.22265625, -2494.0400390625, 73.5546875, 0, 0, 270)
      setObjectScale(meat, 0)
      moveObject(meat, 6000, 1568.22265625, -2494.0400390625, 43.5546875)
      setElementDimension(meat, getElementDimension(localPlayer))
      local color = seexports.sGui:getColorCode("sightgreen")
      local plane = createVehicle(577, 1503.22265625, -2494.0400390625, 53.5546875, 0, 0, 270)
      setVehicleColor(plane, 255, 255, 255, color[1], color[2], color[3])
      setElementFrozen(plane, true)
      setElementDimension(plane, getElementDimension(localPlayer))
      attachElements(plane, meat)
      sceneElements.airport2 = {plane, meat}
    end, 3000, 1)
    setTimer(setupCharCreationStage, 3000, 1, 7)
  elseif stage == 7 then
    setTimer(function()
      clearSceneElements()
      if renderHandled then
        renderHandled = false
        seexports.sGui:deleteGuiElement(vignetteGui)
        removeEventHandler("onClientRender", getRootElement(), renderCharCreation)
        removeEventHandler("onClientPreRender", getRootElement(), preRenderCharCreation)
        removeEventHandler("onClientHUDRender", getRootElement(), renderHUDCharCreation)
        removeEventHandler("onClientPlayerDamage", localPlayer, cancelDamage)
        if isElement(sceneTarget) then
          destroyElement(sceneTarget)
        end
        if isElement(movieShader) then
          destroyElement(movieShader)
        end
        sceneTarget = false
        movieShader = false
      end
    end, 6000, 1)
    if sceneSubtitleBcg then
      seexports.sGui:deleteGuiElement(sceneSubtitleBcg)
    end
    sceneSubtitleBcg = false
    if sceneSubtitleText then
      seexports.sGui:deleteGuiElement(sceneSubtitleText)
    end
    sceneSubtitleText = false
  end
end
local cityIntro = {
  {
    false,
    false,
    {
      "A SightMTA bemutatja",
      "SightMTA"
    },
    {
      1462.4736328125,
      -885.16998291016,
      78.666496276855,
      1415.5435791016,
      -797.06292724609,
      84.558662414551
    }
  },
  {
    "Los Santos Hall",
    "Los Santos Városháza: itt tudod az okmányaidat kiváltani és az ingatlanjaidat bejelenteni.",
    false,
    {
      1454.0842285156,
      -1711.2188720703,
      31.79314994812,
      1501.6549072266,
      -1798.7291259766,
      22.905393600464
    }
  },
  {
    "Autókereskedés",
    "Itt tudsz új járművet vásárolni.",
    false,
    {
      2114.2670898438,
      -1130.8419189453,
      33.335655212402,
      2178.6638183594,
      -1202.4669189453,
      6.4486203193665
    }
  },
  {
    false,
    false,
    {
      "Készítette",
      "eznemgergo"
    },
    {
      -1898.8413085938,
      -1722.6910400391,
      30.649366378784,
      -1846.1221923828,
      -1640.4637451172,
      9.2163724899292
    }
  },
  {
    "Kórházak",
    "Sérülés esetén itt tudnak ellátni. Karaktered halála után a legközelebbi kórházban éled újra.",
    false,
    {
      1204.8625488281,
      -1300.7336425781,
      25.223545074463,
      1126.2238769531,
      -1359.0850830078,
      4.9485878944397
    }
  },
  {
    "Los Santos Mall",
    "Egy modern bevásárlóközpont, ahol mindent megtalálsz: bank, ruhabolt, casino, mozi, üzletek.",
    false,
    {
      1128.5517578125,
      -1405.7473144531,
      20.937286376953,
      1127.4459228516,
      -1505.7069091797,
      18.320085525513
    }
  },
  {
    false,
    false,
    {
      "Készítette",
      "Davis"
    },
    {
      1479.5174560547,
      -1693.6246337891,
      15.868656158447,
      1478.7158203125,
      -1594.64453125,
      1.6454757452011
    }
  },
  {
    "sOil Benzinkutak",
    "Itt tudod járművedet megtankolni a megfelelő üzemanyaggal. A kút shopja óriási kínálattal vár.",
    false,
    {
      -104.66873931885,
      -1147.4486083984,
      7.0358619689941,
      -77.769287109375,
      -1243.5906982422,
      1.2805440425873
    }
  },
  {
    "Kaszinók",
    "Próbálj szerencsét, s térj haza gazdagon! Keresd a térképen a piros dobókocka ikonokat.",
    false,
    {
      -829.53747558594,
      1561.9831542969,
      31.697526931763,
      -908.07476806641,
      1500.4555664062,
      24.89727973938
    }
  },
  {
    false,
    false,
    {
      "Készítette",
      "noffy"
    },
    {
      -1807.0893554688,
      -603.96929931641,
      22.26530456543,
      -1821.8931884766,
      -508.28237915039,
      -2.7318413257599
    }
  },
  {
    "San Andreas Bank & Gold Depot",
    "Amennyiben átlépted napi ATM kereted, a bankfiókokban korlátlanul intézheted pénzügyeid.",
    false,
    {
      634.87725830078,
      -1615.3770751953,
      21.371932983398,
      555.08074951172,
      -1674.734375,
      10.921051025391
    }
  },
  {
    "Autósiskola",
    "Itt tudsz jogosítványt szerezni.",
    false,
    {
      1057.0261230469,
      -1768.3428955078,
      25.890377044678,
      1144.7202148438,
      -1809.6949462891,
      1.4004518985748
    }
  },
  {
    false,
    false,
    {
      "Készítette",
      "Jani"
    },
    {
      1439.8736572266,
      -1806.8701171875,
      18.94571762085,
      1439.8768310547,
      -1903.6422119141,
      41.447999572754
    }
  },
  {
    "Szerelőtelepek",
    "Amennyiben járművednek lejárt a műszaki vizsgája, vagy bármilyen problémája van, keresd fel Los Santos 3 szerelőtelepének egyikét.",
    false,
    {
      -1509.3868408203,
      817.80627441406,
      14.223379135132,
      -1472.9213867188,
      909.92657470703,
      0.65436631441116
    }
  },
  {
    "Sight Ring versenypálya",
    "Ha szólít az aszfalt illata, próbáld ki magad a Sight Ring verseny- vagy dragpályán.",
    false,
    {
      -1184.8062744141,
      255.46311950684,
      24.100961685181,
      -1257.1931152344,
      187.54708862305,
      11.953458786011
    }
  },
  {
    false,
    false,
    {
      "Készítette",
      "szurikata"
    },
    {
      -1422.2078857422,
      1837.3038330078,
      45.885841369629,
      -1504.2099609375,
      1890.7745361328,
      25.476673126221
    }
  },
  {
    "Sight Customs",
    "Amennyiben szeretnéd tuningolni, egyedivé tenni járműveid, keresd Los Santos tuningműhelyeit.",
    false,
    {
      1014.1039428711,
      -928.55755615234,
      49.509273529053,
      1084.412109375,
      -859.68603515625,
      31.804103851318
    }
  },
  {
    "SightDyno",
    "Járműved maximális teljesítményének elérésében segít a SightDyno.",
    false,
    {
      -1422.3577880859,
      2610.6162109375,
      61.105422973633,
      -1420.0786132812,
      2512.7197265625,
      40.830463409424
    }
  },
  {
    false,
    false,
    {
      "Készítette",
      "SightMTA csapata"
    },
    {
      -1290.6066894531,
      2458.587890625,
      89.804565429688,
      -1314.9366455078,
      2555.4685058594,
      85.09481048584
    }
  },
  {
    "Los Santos Industrial Parks",
    "Garázs és műhelybérleti szolgáltatások. Itt vághatsz bele az autófényező vállalkozásba.",
    false,
    {
      2105.958984375,
      -2228.7841796875,
      24.682638168335,
      2018.4600830078,
      -2276.248046875,
      15.13711643219
    }
  },
  {
    "MiguTrans telephely",
    "Amennyiben árufuvarozással szeretnél foglalkozni, ez a te helyed.",
    false,
    {
      -498.00326538086,
      -547.63879394531,
      38.240867614746,
      -581.19213867188,
      -492.9716796875,
      28.695344924927
    }
  },
  {
    false,
    false,
    {
      "Már csak annyi maradt hátra, hogy",
      "jó szórakozást kívánjunk!"
    },
    {
      1970.1413574219,
      -1746.2581787109,
      25.281934738159,
      1905.7027587891,
      -1819.9544677734,
      4.8727655410767
    }
  }
}
local grayScaleSource = " texture GrayscaleTexture; float alpha = 1; sampler screenSampler = sampler_state { Texture = <GrayscaleTexture>; }; float4 main(float2 uv : TEXCOORD0) : COLOR0 { float4 Color; Color = tex2D( screenSampler , uv); Color.rgb = round((Color.r+Color.g+Color.b)*10.0f)/30.0f; Color.r=Color.rgb; Color.g=Color.rgb; Color.b=Color.rgb; Color.rgb = (Color.rgb - 0.5) *(0.25 + 1.0) + 0.5; Color.a *= alpha; return Color; }; technique Grayscale { pass P1 { PixelShader = compile ps_2_0 main(); } } "
function setCityIntroState(state)
  local x, y, z = cityIntro[state][4][1], cityIntro[state][4][2], cityIntro[state][4][3]
  local tx, ty, tz = cityIntro[state][4][4], cityIntro[state][4][5], cityIntro[state][4][6]
  local cx = x - tx
  local cy = y - ty
  local cz = z - tz
  local length = math.sqrt(math.pow(cx, 2) + math.pow(cy, 2) + math.pow(cz, 2))
  cx = cx / length
  cy = cy / length
  cz = cz / length
  cameraMatrix = {
    getTickCount(),
    9000,
    {
      x + cx * 25,
      y + cy * 25,
      z + cz * 25 + 10,
      tx,
      ty,
      tz - 5
    },
    {
      x,
      y,
      z,
      tx,
      ty,
      tz
    },
    "OutQuad"
  }
  if not sceneElements.intro then
    sceneElements.intro = {
      playSound("files/intro.mp3"),
      dxCreateScreenSource(screenX, screenY),
      dxCreateShader(grayScaleSource)
    }
    setStreamerModeVolume(sceneElements.intro[1], 1)
    dxSetShaderValue(sceneElements.intro[3], "GrayscaleTexture", sceneElements.intro[2])
    dxSetShaderValue(sceneElements.intro[3], "alpha", 1)
  end
  seexports.sGui:deleteGuiElement(sceneGui)
  sceneGui = seexports.sGui:createGuiElement("null", 0, 0, screenX, screenY)
  if cityIntro[state][1] then
    local label = seexports.sGui:createGuiElement("label", 1, 1, screenX - 48, screenY - 48, sceneGui)
    seexports.sGui:setLabelText(label, cityIntro[state][2])
    seexports.sGui:setLabelAlignment(label, "right", "bottom")
    seexports.sGui:setLabelFont(label, "15/Ubuntu-L.ttf")
    seexports.sGui:setLabelColor(label, "#000000ae")
    local label = seexports.sGui:createGuiElement("label", 0, 0, screenX - 48, screenY - 48, sceneGui)
    seexports.sGui:setLabelText(label, cityIntro[state][2])
    seexports.sGui:setLabelAlignment(label, "right", "bottom")
    seexports.sGui:setLabelFont(label, "15/Ubuntu-L.ttf")
    local h = seexports.sGui:getLabelFontHeight(label)
    local label = seexports.sGui:createGuiElement("label", 1, 1 - h, screenX - 48, screenY - 48, sceneGui)
    seexports.sGui:setLabelText(label, cityIntro[state][1])
    seexports.sGui:setLabelAlignment(label, "right", "bottom")
    seexports.sGui:setLabelFont(label, "30/BebasNeueRegular.otf")
    seexports.sGui:setLabelColor(label, "#000000ae")
    local label = seexports.sGui:createGuiElement("label", 0, 0 - h, screenX - 48, screenY - 48, sceneGui)
    seexports.sGui:setLabelText(label, cityIntro[state][1])
    seexports.sGui:setLabelAlignment(label, "right", "bottom")
    seexports.sGui:setLabelFont(label, "30/BebasNeueRegular.otf")
  end
  if cityIntro[state][3] then
    local data = cityIntro[state][3]
    local label = seexports.sGui:createGuiElement("label", 50, 2, screenX, screenY - 48, sceneGui)
    seexports.sGui:setLabelText(label, utf8.upper(data[2]))
    seexports.sGui:setLabelAlignment(label, "left", "bottom")
    seexports.sGui:setLabelFont(label, "35/Impact.ttf")
    seexports.sGui:setLabelColor(label, "#000000ae")
    local label = seexports.sGui:createGuiElement("label", 48, 0, screenX, screenY - 48, sceneGui)
    seexports.sGui:setLabelText(label, utf8.upper(data[2]))
    seexports.sGui:setLabelAlignment(label, "left", "bottom")
    seexports.sGui:setLabelFont(label, "35/Impact.ttf")
    seexports.sGui:setLabelColor(label, "sightyellow")
    local h = seexports.sGui:getLabelFontHeight(label)
    local label = seexports.sGui:createGuiElement("label", 50, 2 - h, screenX, screenY - 48, sceneGui)
    seexports.sGui:setLabelText(label, data[1])
    seexports.sGui:setLabelAlignment(label, "left", "bottom")
    seexports.sGui:setLabelFont(label, "30/SweetSixteen.ttf")
    seexports.sGui:setLabelColor(label, "#000000ae")
    local label = seexports.sGui:createGuiElement("label", 48, 0 - h, screenX, screenY - 48, sceneGui)
    seexports.sGui:setLabelText(label, data[1])
    seexports.sGui:setLabelAlignment(label, "left", "bottom")
    seexports.sGui:setLabelFont(label, "30/SweetSixteen.ttf")
    seexports.sGui:setLabelColor(label, "sightyellow")
  end
  if state < #cityIntro then
    lastCityIntro = false
    setTimer(function()
      dxUpdateScreenSource(sceneElements.intro[2])
      fadeScreen = {
        getTickCount(),
        1000,
        false,
        false,
        seexports.sGui:getColorCodeToColor("sightyellow"),
        sceneElements.intro[3] or sceneElements.intro[2],
        math.random(4)
      }
      setTimer(setCityIntroState, 1000, 1, state + 1)
    end, 9000, 1)
  else
    lastCityIntro = true
    setTimer(setupCharCreationStage, 9000, 1, 6)
  end
end
function hitColIsland1(hitElement, md)
  if md and isElement(hitElement) and hitElement == sceneElements.island1[1] then
    removeEventHandler("onClientElementColShapeHit", localPlayer, hitColIsland1)
    setTimer(function()
      removeEventHandler("onClientRender", getRootElement(), renderIsland1)
      setupCharCreationStage(2)
    end, 1000, 1)
    fadeScreen = {
      getTickCount(),
      6000,
      false,
      false
    }
  end
end
function hitColIsland2(hitElement, md)
  if md and isElement(hitElement) and hitElement == sceneElements.island2[1] then
    removeEventHandler("onClientElementColShapeHit", localPlayer, hitColIsland2)
    setTimer(function()
      removeEventHandler("onClientRender", getRootElement(), renderIsland2)
      setupCharCreationStage(3)
    end, 1000, 1)
    setElementFrozen(localPlayer, true)
    fadeScreen = {
      getTickCount(),
      3000,
      false,
      {
        "30 perccel később",
        seexports.sGui:getFont("30/BebasNeueRegular.otf"),
        seexports.sGui:getFontScale("30/BebasNeueRegular.otf")
      }
    }
  end
end
function renderIsland3()
  setElementRotation(sceneElements.island3[1], 0, 0, 0)
  setElementRotation(sceneElements.island3[3], 0, 0, 0)
  local x, y, z = getElementPosition(sceneElements.island3[1])
  setCameraMatrix(x + 6, y + 8, 5, x, y, 1)
end
function renderIsland2()
  local x, y, z = getElementPosition(localPlayer)
  local progress = getTickCount() - nextInsectState
  if 0 < progress and progress < 29000 then
    if not insectSoundState then
      insectSoundState = true
      playSound("files/insect.mp3")
    end
    setElementPosition(sceneElements.island2[13], x, y, z)
  else
    if 0 < progress then
      nextInsectState = getTickCount() + math.random(10, 40) * 1000
    end
    insectSoundState = false
    setElementPosition(sceneElements.island2[13], 0, 0, 0)
  end
  setVehicleRotorSpeed(sceneElements.island2[4], 0.25)
  local progress = getTickCount() % 5000 / 5000 * 2
  if 1 <= progress then
    progress = 2 - progress
  end
  progress = getEasingValue(progress, "InOutQuad")
  local progress2 = getTickCount() % 8000 / 8000 * 2
  if 1 <= progress2 then
    progress2 = 2 - progress2
  end
  progress2 = getEasingValue(progress2, "InOutQuad")
  local hx, hy, hz = 7499.4853515625, -233.94921875, 194.6976318359
  local rz = 265
  local heliProgress = (getTickCount() - copterStart) / 30000
  if 1 <= heliProgress then
    hx, hy, hz = 6995.59375 + progress2 * 0.5, 177.478515625 + progress2 * 0.5, 40.205303192139 + progress * 1.5
  else
    hx, hy, hz = interpolateBetween(7499.4853515625, -233.94921875, 194.6976318359, 6995.59375, 177.478515625, 40.205303192139, heliProgress, "Linear")
    rz = -(math.deg(math.atan2(hy - 177.478515625, hx - 6995.5937)) + 180) + 180
  end
  setElementPosition(sceneElements.island2[10], hx, hy, hz)
  setElementPosition(sceneElements.island2[4], hx, hy, hz)
  setElementRotation(sceneElements.island2[4], -6 + progress * 3, -3 + progress2 * 6, rz + progress * 10)
  local redProgress = math.min(1, (getTickCount() - islandTick) / 600000)
  if 0.5 <= redProgress then
    if not starNotified then
      starNotified = true
      seexports.sGui:showInfobox("i", "Tipp: kövesd a fényt!")
    end
    local x, y, s = getScreenFromWorldPosition(hx, hy, hz, 128)
    if x then
      if x < 0 then
        x = 0
      end
      if y < 0 then
        y = 0
      end
      if x > screenX then
        x = screenX
      end
      if y > screenY then
        y = screenY
      end
      local prog = getTickCount() % 2000 / 1000
      if 1 < prog then
        prog = 2 - prog
      end
      seelangStaticImageUsed[0] = true
      if seelangStaticImageToc[0] then
        processSeelangStaticImage[0]()
      end
      dxDrawImage(x - 64, y - 64, 128, 128, seelangStaticImage[0], 0, 0, 0, tocolor(255, 255, 255, 200 * getEasingValue(prog, "InOutQuad")))
    end
  end
end
function renderIsland1()
  local x, y, z = getElementPosition(localPlayer)
  if not alertedAboutInnerSound then
    if getDistanceBetweenPoints3D(6989.693359375, -36.201171875, 6.1042098999023, x, y, z) >= 50 then
      alertedAboutInnerSound = true
      seexports.sGui:showInfobox("i", "Tipp: hallgass az ösztöneidre!", 7982)
      playSound("files/inner.mp3")
      sceneElements.island1[2] = playSound3D("files/inner.mp3", 7527.7119140625, -76.4423828125, 65.093963623047, true)
      setSoundMaxDistance(sceneElements.island1[2], 1200)
      setElementDimension(sceneElements.island1[2], getElementDimension(localPlayer))
    end
  else
    local dist = getDistanceBetweenPoints3D(7527.7119140625, -76.4423828125, 65.093963623047, x, y, z)
    if dist < 300 then
      setSoundSpeed(sceneElements.island1[2], 0.75 + 0.4 * (300 - dist) / 300)
    else
      setSoundSpeed(sceneElements.island1[2], 0.75)
    end
  end
  local redProgress = math.min(1, (getTickCount() - islandTick) / 360000)
  if 0.5 <= redProgress then
    if not starNotified then
      starNotified = true
      seexports.sGui:showInfobox("i", "Tipp: hallgass a megérzéseidre!")
    end
    local x, y, s = getScreenFromWorldPosition(7527.7119140625, -76.4423828125, 65.093963623047, 128)
    if x then
      if x < 0 then
        x = 0
      end
      if y < 0 then
        y = 0
      end
      if x > screenX then
        x = screenX
      end
      if y > screenY then
        y = screenY
      end
      local prog = getTickCount() % 2000 / 1000
      if 1 < prog then
        prog = 2 - prog
      end
      seelangStaticImageUsed[0] = true
      if seelangStaticImageToc[0] then
        processSeelangStaticImage[0]()
      end
      dxDrawImage(x - 64, y - 64, 128, 128, seelangStaticImage[0], 0, 0, 0, tocolor(255, 255, 255, 200 * getEasingValue(prog, "InOutQuad")))
    end
  end
  seelangStaticImageUsed[1] = true
  if seelangStaticImageToc[1] then
    processSeelangStaticImage[1]()
  end
  dxDrawImage(0, 0, screenX, screenY, seelangStaticImage[1], 0, 0, 0, tocolor(138, 3, 3, 255 * redProgress))
end
function renderHUDCharCreation()
  dxUpdateScreenSource(sceneTarget)
  dxDrawImage(0, 0, screenX, screenY, movieShader)
  dxSetShaderValue(movieShader, "noiseX", math.random(119898, 139898) / 10000)
  dxSetShaderValue(movieShader, "noiseY", math.random(772330, 792330) / 10000)
end
