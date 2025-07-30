local sightexports = {
	sChat = false,
	sWeather = false,
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
local loaderIcon = false
local faTicks = false
local function sightlangGuiRefreshColors()
	local res = getResourceFromName("sGui")
	if res and getResourceState(res) == "running" then
		loaderIcon = sightexports.sGui:getFaIconFilename("circle-notch", 64)
		r16_0 = sightexports.sGui:getFont("14/Ubuntu-B.ttf")
		r17_0 = sightexports.sGui:getFontScale("14/Ubuntu-B.ttf")
		r18_0 = sightexports.sGui:getFont("11/Ubuntu-R.ttf")
		r19_0 = sightexports.sGui:getFontScale("11/Ubuntu-R.ttf")
		faTicks = sightexports.sGui:getFaTicks()
	end
end
addEventHandler("onGuiRefreshColors", getRootElement(), sightlangGuiRefreshColors)
addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangGuiRefreshColors)
addEventHandler("refreshFaTicks", getRootElement(), function()
	faTicks = sightexports.sGui:getFaTicks()
end)
local screenX, screenY = guiGetScreenSize()
local sx, sy = 516, 316
local x = screenX / 2 - sx / 2
local y = screenY / 2 - sy / 2
local loadingLicenseType = false
local loadingLicenseId = false
local gotLicenseData = false
local licensePic = false
local lunabar = false
local ticketFont = false
function deleteLicenseStuff()
	if isElement(lunabar) then
		destroyElement(lunabar)
	end
	lunabar = nil
	if isElement(ticketFont) then
		destroyElement(ticketFont)
	end
	ticketFont = nil
	if isElement(licensePic) then
		destroyElement(licensePic)
	end
	licensePic = nil
end
addEvent("gotLicenseData", true)
addEventHandler("gotLicenseData", getRootElement(), function(pic, data)
	if data then
		if data and data.licenseType == loadingLicenseType and data.id == loadingLicenseId then
			if not isElement(lunabar) then
				lunabar = dxCreateFont("files/lunabar.ttf", 34, false, "antialiased")
			end
			if not isElement(ticketFont) then
				ticketFont = dxCreateFont("files/IckyticketMono-nKpJ.ttf", 25, false, "antialiased")
			end
			if isElement(licensePic) then
				destroyElement(licensePic)
			end
			if pic then
				licensePic = dxCreateTexture(pic)
			else
				licensePic = false
			end
			local time = getRealTime(data.created * 24 * 60 * 60)
			data.created = string.format("%04d. %02d. %02d.", time.year + 1900, time.month + 1, time.monthday)
			local time = getRealTime(data.expire * 24 * 60 * 60)
			data.expire = string.format("%04d. %02d. %02d.", time.year + 1900, time.month + 1, time.monthday)
			gotLicenseData = data
		end
	elseif loadingLicenseType then
		deleteLicenseStuff()
		loadingLicenseType = false
		loadingLicenseId = false
		gotLicenseData = false
		removeEventHandler("onClientClick", getRootElement(), licenseClick)
		removeEventHandler("onClientCursorMove", getRootElement(), licenseCursorMove)
		removeEventHandler("onClientRender", getRootElement(), renderLicense)
	end
	pic = nil
	collectgarbage("collect")
end)
function renderLicense()
	if loadingLicenseType == "mine" or gotLicenseData and gotLicenseData.licenseType == "mine" then
		local r0_11 = latentDynamicImage("files/mine.dds")
		local r1_11 = latentDynamicImage("files/minelam.dds")
		local r2_11 = 416
		local r3_11 = 512
		local r4_11 = x + sx / 2 - r2_11 / 2
		local r5_11 = y + sy / 2 - r3_11 / 2
		if gotLicenseData then
			dxDrawImage(r4_11, r5_11, r2_11, r3_11, r0_11)
			dxDrawImage(r4_11 + 131, r5_11 + 167, 155, 158, licensePic)
			dxDrawText(gotLicenseData.name, r4_11 + 92, 0, r4_11 + r2_11 - 92, r5_11 + 365, tocolor(0, 0, 0), r17_0, r16_0, "center", "bottom", true)
			dxDrawText(gotLicenseData.expire, 0, r5_11 + 401, r4_11 + r2_11 - 105, r5_11 + 402, tocolor(0, 0, 0), r19_0, r18_0, "right", "center")
			dxDrawText(gotLicenseData.id, r4_11, r5_11 + 437, r4_11 + r2_11, r5_11 + 437, tocolor(0, 0, 0), r17_0, r16_0, "center", "center")
			dxDrawImage(r4_11, r5_11, r2_11, r3_11, r1_11)
		else
			dxDrawImage(r4_11, r5_11, r2_11, r3_11, dynamicImage("files/mineblur.dds"))
			dxDrawImage(r4_11 + r2_11 / 2 - 32, r5_11 + r3_11 / 2 - 32, 64, 64, ":sGui/" .. loaderIcon .. faTicks[loaderIcon], getTickCount() / 5 % 360)
		end
	else
		local tex = latentDynamicImage("files/" .. (loadingLicenseType or gotLicenseData.licenseType) .. ".dds")
		local lamin = latentDynamicImage("files/lamin.dds")
		if gotLicenseData then
			if tex then
				dxDrawImage(x, y, sx, sy, tex)
			end
			if gotLicenseData.licenseType == "fs" then
				dxDrawText(gotLicenseData.id, x + 60 + 10, y + 40 + 5, 0, 0, tocolor(0, 0, 0, 255), 0.5, ticketFont, "left", "top")
				dxDrawText(gotLicenseData.name, x + 102, y + 118 - 1, 0, y + 118 - 1, tocolor(0, 0, 0, 255), 0.5, ticketFont, "left", "center")
				dxDrawText(gotLicenseData.created, x + 157, y + 142 - 1, 0, y + 142 - 1, tocolor(0, 0, 0, 255), 0.5, ticketFont, "left", "center")
				dxDrawText(gotLicenseData.expire, x + 152, y + 166 - 1, 0, y + 166 - 1, tocolor(0, 0, 0, 255), 0.5, ticketFont, "left", "center")
				dxDrawText(gotLicenseData.name, x + 225, y + 242, x + 225, y + 242, tocolor(50, 27, 149, 255), 0.5, lunabar, "center", "center")
			elseif gotLicenseData.licenseType == "wp" then
				dxDrawImage(x + 73, y + 106, 101, 103, licensePic)
				dxDrawText(gotLicenseData.name, x + 214, y + 114 - 1, 0, y + 114 - 1, tocolor(0, 0, 0, 255), 0.5, ticketFont, "left", "center")
				dxDrawText(gotLicenseData.id, x + 248, y + 138 - 1, 0, y + 138 - 1, tocolor(0, 0, 0, 255), 0.5, ticketFont, "left", "center")
				dxDrawText(gotLicenseData.created, x + 268, y + 162 - 1, 0, y + 162 - 1, tocolor(0, 0, 0, 255), 0.5, ticketFont, "left", "center")
				dxDrawText(gotLicenseData.expire, x + 264, y + 186 - 1, 0, y + 186 - 1, tocolor(0, 0, 0, 255), 0.5, ticketFont, "left", "center")
				dxDrawText("9 mm / .45 ACP", x + 234, y + 210 - 1, 0, y + 210 - 1, tocolor(0, 0, 0, 255), 0.5, ticketFont, "left", "center")
				dxDrawText(gotLicenseData.name, x + 120, y + 242, 0, y + 242, tocolor(0, 0, 0, 255), 0.5, lunabar, "left", "center")
			else
				dxDrawImage(x + 73, y + 106, 101, 103, licensePic)
				dxDrawText(gotLicenseData.name, x + 214, y + 114 - 1, 0, y + 114 - 1, tocolor(0, 0, 0, 255), 0.5, ticketFont, "left", "center")
				dxDrawText(gotLicenseData.id, x + 248, y + 143 - 1, 0, y + 143 - 1, tocolor(0, 0, 0, 255), 0.5, ticketFont, "left", "center")
				dxDrawText(gotLicenseData.created, x + 268, y + 172 - 1, 0, y + 172 - 1, tocolor(0, 0, 0, 255), 0.5, ticketFont, "left", "center")
				dxDrawText(gotLicenseData.expire, x + 264, y + 200 - 1, 0, y + 200 - 1, tocolor(0, 0, 0, 255), 0.5, ticketFont, "left", "center")
				dxDrawText(gotLicenseData.name, x + 120, y + 242, 0, y + 242, tocolor(0, 0, 0, 255), 0.5, lunabar, "left", "center")
			end
			if lamin then
				dxDrawImage(x, y, sx, sy, lamin)
			end
		else
			dxDrawImage(x, y, sx, sy, dynamicImage("files/" .. loadingLicenseType .. "blur.dds"))
			dxDrawImage(x + sx / 2 - 32, y + sy / 2 - 32, 64, 64, ":sGui/" .. loaderIcon .. faTicks[loaderIcon], getTickCount() / 5 % 360)
		end
	end
end
local licenseMoving = false
function licenseClick(button, state, absoluteX, absoluteY, worldX, worldY, worldZ, clickedElement)
	if state == "down" then
		if loadingLicenseType == "mine" or gotLicenseData and gotLicenseData.licenseType == "mine" then
			local r8_12 = 416
			local r10_12 = x + sx / 2 - r8_12 / 2
			local r11_12 = y + sy / 2 - 512 / 2
			if r10_12 + 85 <= absoluteX and absoluteX <= r10_12 + r8_12 - 85 and r11_12 + 55 <= absoluteY and absoluteY <= r11_12 + 455 then
				r35_0 = {
				r2_12,
				r3_12
				}
			end
		elseif absoluteX >= x + 51 and absoluteX <= x + 463 and absoluteY >= y + 31 and absoluteY <= y + 283 then
			licenseMoving = {absoluteX, absoluteY}
		end
	else
		licenseMoving = false
	end
end
function licenseCursorMove(rx, ry, cx, cy)
	if licenseMoving then
		if r28_0 == "mine" then
			local r4_13 = 416
			local r5_13 = 512
			x = math.max(-(sx / 2 - r4_13 / 2 + 85), math.min(r22_0 - sx / 2 + r4_13 / 2 - 85, x + r2_13 - r35_0[1]))
			y = math.max(-(sy / 2 - r5_13 / 2 + 55), math.min(r23_0 - sy / 2 - r5_13 / 2 + 455, y + r3_13 - r35_0[2]))
		else
			x = math.max(-51, math.min(screenX - 463, x + cx - licenseMoving[1]))
			y = math.max(-31, math.min(screenY - 283, y + cy - licenseMoving[2]))
		end

		licenseMoving[1] = cx
		licenseMoving[2] = cy

	    refreshCloseButton()
	end
end
function refreshCloseButton()
  -- line: [207, 224] id: 14
  if r34_0 then
    if r30_0 then
      sightexports.sGui:setGuiRenderDisabled(r34_0, false)
      if r30_0.licenseType == "mine" then
        local r0_14 = 416
        sightexports.sGui:setGuiPosition(r34_0, r26_0 + sx / 2 - r0_14 / 2 + r0_14 / 2 - 50, r27_0 + sy / 2 - 512 / 2 + 455 + 24)
      else
        sightexports.sGui:setGuiPosition(r34_0, r26_0 + sx / 2 - 50, r27_0 + 275 + 24)
      end
    else
      sightexports.sGui:setGuiRenderDisabled(r34_0, true)
    end
  end
end
function createCloseButton()
  -- line: [226, 238] id: 15
  deleteCloseButton()
  r34_0 = sightexports.sGui:createGuiElement("button", 0, 0, 100, 24)
  sightexports.sGui:setGuiBackground(r34_0, "solid", "v4red")
  sightexports.sGui:setGuiHover(r34_0, "gradient", {
    "v4red",
    "v4red-second"
  }, false, true)
  sightexports.sGui:setButtonFont(r34_0, "12/BebasNeueBold.otf")
  sightexports.sGui:setButtonTextColor(r34_0, "#ffffff")
  sightexports.sGui:setButtonText(r34_0, "Bezárás")
  sightexports.sGui:setClickEvent(r34_0, "hideLicenseForce")
  refreshCloseButton()
end
function deleteCloseButton()
  -- line: [240, 242] id: 16
  if r34_0 then
    sightexports.sGui:deleteGuiElement(r34_0)
  end
  r34_0 = nil
end
function hideLicense(licenseType)
	deleteLicenseStuff()
	loadingLicenseType = false
	loadingLicenseId = false
	gotLicenseData = false
	removeEventHandler("onClientClick", getRootElement(), licenseClick)
	removeEventHandler("onClientCursorMove", getRootElement(), licenseCursorMove)
	removeEventHandler("onClientRender", getRootElement(), renderLicense)
	if licenseType == "id" then
		sightexports.sChat:localActionC(localPlayer, "elrakott egy személyazonosító igazolványt.")
	elseif licenseType == "dl" then
		sightexports.sChat:localActionC(localPlayer, "elrakott egy vezetői engedélyt.")
	elseif licenseType == "wp" then
		sightexports.sChat:localActionC(localPlayer, "elrakott egy fegyverengedélyt.")
	elseif licenseType == "fs" then
		sightexports.sChat:localActionC(localPlayer, "elrakott egy horgászengedélyt.")
	elseif r0_17 == "mine" then
      	sightexports.sChat:localActionC(localPlayer, "elrakott egy bányászengedélyt.")
	end
end
function showLicense(licenseType, id)
	if gotLicenseData then
		gotLicenseData = false
		loadingLicenseType = licenseType
		loadingLicenseId = id
		triggerServerEvent("loadLicenseData", localPlayer, loadingLicenseId)
		if licenseType == "id" then
			sightexports.sChat:localActionC(localPlayer, "elővett egy személyazonosító igazolványt.")
		elseif licenseType == "dl" then
			sightexports.sChat:localActionC(localPlayer, "elővett egy vezetői engedélyt.")
		elseif licenseType == "wp" then
			sightexports.sChat:localActionC(localPlayer, "elővett egy fegyverengedélyt.")
		elseif licenseType == "fs" then
			sightexports.sChat:localActionC(localPlayer, "elővett egy horgászengedélyt.")
		elseif r0_19 == "mine" then
			sightexports.sChat:localActionC(localPlayer, "elővett egy bányászengedélyt.")
		end
	elseif not loadingLicenseType then
		deleteLicenseStuff()
		gotLicenseData = false
		loadingLicenseType = licenseType
		loadingLicenseId = id
		triggerServerEvent("loadLicenseData", localPlayer, loadingLicenseId)
		addEventHandler("onClientClick", getRootElement(), licenseClick)
		addEventHandler("onClientCursorMove", getRootElement(), licenseCursorMove)
		addEventHandler("onClientRender", getRootElement(), renderLicense)
		if licenseType == "id" then
			sightexports.sChat:localActionC(localPlayer, "elővett egy személyazonosító igazolványt.")
		elseif licenseType == "dl" then
			sightexports.sChat:localActionC(localPlayer, "elővett egy vezetői engedélyt.")
		elseif licenseType == "wp" then
			sightexports.sChat:localActionC(localPlayer, "elővett egy fegyverengedélyt.")
		elseif licenseType == "fs" then
			sightexports.sChat:localActionC(localPlayer, "elővett egy horgászengedélyt.")
		elseif r0_19 == "mine" then
	        sightexports.sChat:localActionC(localPlayer, "elővett egy bányászengedélyt.")
		end
	end
end
local photoStart = false
local photoSource = false
local photoShader = false
local photoShaderSource = " texture sBaseTexture; float blur = 0; float Contrast = 0; float Saturation = 1; const float3 lumCoeff = float3(0.2125, 0.7154, 0.0721); sampler Samp = sampler_state { Texture = (sBaseTexture); AddressU = MIRROR; AddressV = MIRROR; }; float4 PixelShaderFunction(float2 uv : TEXCOORD) : COLOR { float4 outputColor = tex2D(Samp, uv); if(blur > 0) { for (float i = 1; i < 3; i++) { outputColor += tex2D(Samp, float2(uv.x, uv.y + (i * blur))); outputColor += tex2D(Samp, float2(uv.x, uv.y - (i * blur))); outputColor += tex2D(Samp, float2(uv.x - (i * blur), uv.y)); outputColor += tex2D(Samp, float2(uv.x + (i * blur), uv.y)); } outputColor /= 9; } outputColor.rgb = (outputColor.rgb - 0.5) *(Contrast + 1.0) + 0.5; float3 intensity = float(dot(outputColor.rgb, lumCoeff)); outputColor.rgb = lerp(intensity, outputColor.rgb, Saturation ); return outputColor; } technique movie { pass P0 { PixelShader = compile ps_2_0 PixelShaderFunction(); } } technique fallback { pass P0 { } } "
local photoX, photoY, photoZ
local photoSent = false
local photoUpdated = false
addEvent("endLicensePhotoMode", true)
addEventHandler("endLicensePhotoMode", getRootElement(), function()
	waitingForLicenseOffice = false
	if isElement(photoSource) then
		destroyElement(photoSource)
	end
	photoSource = false
	if isElement(photoShader) then
		destroyElement(photoShader)
	end
	photoShader = false
	photoStart = false
	if photoX then
		setElementPosition(localPlayer, photoX, photoY, photoZ)
		setCameraTarget(localPlayer)
	end
	exports.sCamera:setAlpha(false)
	photoX, photoY, photoZ = nil, nil, nil
	removeEventHandler("onClientRender", getRootElement(), renderLicensePhoto)
end)
function renderLicensePhoto()
	exports.sCamera:setAlpha(true)
	setElementPosition(localPlayer, 1502.6181640625, -1806.6103515625, 17.54686164856)
	setElementRotation(localPlayer, 0, 0, 90, "default", true)
	local delta = getTickCount() - photoStart
	local x, y, z = getPedBonePosition(localPlayer, 8)
	if delta < 300 then
		setCameraMatrix(x - 0.65 * (1.5 - 0.5 * (delta / 300)), y, z, x, y, z)
		dxSetShaderValue(photoShader, "blur", 0.0035 + 0.025 * (1 - delta / 300))
	else
		setCameraMatrix(x - 0.65, y, z, x, y, z)
		if 500 < delta then
			dxSetShaderValue(photoShader, "blur", 0)
		else
			dxSetShaderValue(photoShader, "blur", 0.0035 * (1 - (delta - 400) / 100))
		end
	end
	dxDrawImage(0, 0, screenX, screenY, photoShader)
	if 800 < delta and delta < 1000 and photoUpdated then
		local a = 1 - math.min(1, (delta - 800) / 75)
		dxSetShaderValue(photoShader, "Contrast", -0.25)
		dxSetShaderValue(photoShader, "Saturation", 0)
		dxSetShaderValue(photoShader, "blur", 0)
		dxDrawRectangle(0, 0, screenX, screenY, tocolor(255, 255, 255, 255 * a))
	elseif 1000 < delta and not photoSent and photoUpdated then
		dxSetShaderValue(photoShader, "Contrast", -0.25)
		dxSetShaderValue(photoShader, "Saturation", 0)
		dxSetShaderValue(photoShader, "blur", 0)
		local rt = dxCreateRenderTarget(202, 206)
		if isElement(rt) then
			dxSetRenderTarget(rt, true)
			local w = 206 / screenY * screenX
			dxDrawImage(101 - w / 2, 0, w, 206, photoShader)
			dxSetRenderTarget()
			local pixels = dxGetTexturePixels(rt)
			pixels = dxConvertPixels(pixels, "jpeg")
			triggerLatentServerEvent("sendLicensePhoto", localPlayer, pixels)
			pixels = nil
			collectgarbage("collect")
			destroyElement(rt)
		end
		sightexports.sWeather:resetWeather()
		photoSent = true
	elseif not photoSent then
		setTime(12, 0)
		dxUpdateScreenSource(photoSource)
		photoUpdated = true
	end
	dxDrawRectangle(0, 0, (screenX - screenY) / 2, screenY, tocolor(0, 0, 0))
	dxDrawRectangle(screenX - (screenX - screenY) / 2, 0, (screenX - screenY) / 2, screenY, tocolor(0, 0, 0))
end
local officePedPoses = {
	{
		12,
		"Judith Smith",
		1499.55078125,
		-1796.8603515625,
		17.54686164856,
		270
	},
	{
		150,
		"Sunshine Walker",
		1499.5498046875,
		-1801.146484375,
		17.54686164856,
		270
	},
	{
		40,
		"Monica Degucci",
		1513.6904296875,
		-1796.7919921875,
		17.54686164856,
		90
	},
	{
		76,
		"Maria Weaver",
		1513.6904296875,
		-1801.072265625,
		17.54686164856,
		90
	},
	{
		148,
		"Joyce Rudement",
		1513.69140625,
		-1805.349609375,
		17.54686164856,
		90
	}
}
local officePeds = {}
for i = 1, #officePedPoses do
	local ped = createPed(officePedPoses[i][1], officePedPoses[i][3], officePedPoses[i][4], officePedPoses[i][5], officePedPoses[i][6])
	setElementData(ped, "visibleName", officePedPoses[i][2])
	setElementData(ped, "pedNameType", "Ügyintéző")
	setElementFrozen(ped, true)
	setElementData(ped, "invulnerable", true)
	if officePedPoses[i][7] then
		setElementInterior(ped, officePedPoses[i][7])
	end
	if officePedPoses[i][8] then
		setElementDimension(ped, officePedPoses[i][8])
	end
	officePeds[ped] = true
end
local window = false
local officeButtons = {}
addEvent("closeLicenseOfficeWindow", false)
addEventHandler("closeLicenseOfficeWindow", getRootElement(), function()
	if window then
		sightexports.sGui:deleteGuiElement(window)
	end
	window = false
	officeButtons = {}
end)
local waitingForLicenseOffice = false
addEvent("licenseOfficeButton", false)
addEventHandler("licenseOfficeButton", getRootElement(), function(button, state, absoluteX, absoluteY, el)
	if officeButtons[el] then
		waitingForLicenseOffice = true
		triggerServerEvent("licenseOfficeRequest", localPlayer, officeButtons[el])
		if window then
			sightexports.sGui:deleteGuiElement(window)
		end
		window = false
		officeButtons = {}
	end
end)
addEvent("licenseOfficeResponse", true)
addEventHandler("licenseOfficeResponse", getRootElement(), function(photo)
	waitingForLicenseOffice = false
	if photo then
		if isElement(photoSource) then
			destroyElement(photoSource)
		end
		if isElement(photoShader) then
			destroyElement(photoShader)
		end
		photoSent = false
		photoUpdated = false
		photoStart = getTickCount()
		playSound("files/photo.wav")
		photoSource = dxCreateScreenSource(screenX, screenY)
		photoShader = dxCreateShader(photoShaderSource)
		dxSetShaderValue(photoShader, "sBaseTexture", photoSource)
		photoX, photoY, photoZ = getElementPosition(localPlayer)
		addEventHandler("onClientRender", getRootElement(), renderLicensePhoto, true, "low-999999999")
	end
end)
addEventHandler("onClientClick", getRootElement(), function(button, state, absoluteX, absoluteY, worldX, worldY, worldZ, clickedElement)
	if state == "down" and officePeds[clickedElement] and not waitingForLicenseOffice and not window then
		local px, py, pz = getElementPosition(localPlayer)
		local x, y, z = getElementPosition(clickedElement)
		if getDistanceBetweenPoints3D(x, y, z, px, py, pz) <= 3 then
			if window then
				sightexports.sGui:deleteGuiElement(window)
			end
			local titleBarHeight = sightexports.sGui:getTitleBarHeight()
			local pw = 265
			local ph = titleBarHeight + 4 + 170
			window = sightexports.sGui:createGuiElement("window", screenX / 2 - pw / 2, screenY / 2 - ph / 2, pw, ph)
			sightexports.sGui:setWindowTitle(window, "16/BebasNeueRegular.otf", "Okmányiroda")
			sightexports.sGui:setWindowCloseButton(window, "closeLicenseOfficeWindow")
			sightexports.sGui:setWindowElementMaxDistance(window, clickedElement, 3, "closeLicenseOfficeWindow")
			local y = titleBarHeight + 4
			local btn = sightexports.sGui:createGuiElement("button", 4, y, pw - 8, 30, window)
			sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
			sightexports.sGui:setGuiHover(btn, "gradient", {
				"sightgreen",
				"sightgreen-second"
			}, false, true)
			sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
			sightexports.sGui:setButtonTextColor(btn, "#ffffff")
			sightexports.sGui:setButtonText(btn, "Személyazonosító igazolvány")
			sightexports.sGui:setClickEvent(btn, "licenseOfficeButton")
			officeButtons[btn] = "id"
			y = y + 30 + 4
			local btn = sightexports.sGui:createGuiElement("button", 4, y, pw - 8, 30, window)
			sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
			sightexports.sGui:setGuiHover(btn, "gradient", {
				"sightgreen",
				"sightgreen-second"
			}, false, true)
			sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
			sightexports.sGui:setButtonTextColor(btn, "#ffffff")
			sightexports.sGui:setButtonText(btn, "Vezetői engedély")
			sightexports.sGui:setClickEvent(btn, "licenseOfficeButton")
			officeButtons[btn] = "dl"
			y = y + 30 + 4
			local btn = sightexports.sGui:createGuiElement("button", 4, y, pw - 8, 30, window)
			sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
			sightexports.sGui:setGuiHover(btn, "gradient", {
				"sightgreen",
				"sightgreen-second"
			}, false, true)
			sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
			sightexports.sGui:setButtonTextColor(btn, "#ffffff")
			sightexports.sGui:setButtonText(btn, "Fegyverviselési engedély")
			sightexports.sGui:setClickEvent(btn, "licenseOfficeButton")
			officeButtons[btn] = "wp"
			y = y + 30 + 4
			local btn = sightexports.sGui:createGuiElement("button", 4, y, pw - 8, 30, window)
			sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
			sightexports.sGui:setGuiHover(btn, "gradient", {
				"sightgreen",
				"sightgreen-second"
			}, false, true)
			sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
			sightexports.sGui:setButtonTextColor(btn, "#ffffff")
			sightexports.sGui:setButtonText(btn, "Horgászengedély (1 000 $)")
			sightexports.sGui:setClickEvent(btn, "licenseOfficeButton")
			officeButtons[btn] = "fs"
			y = y + 30 + 4
			local btn = sightexports.sGui:createGuiElement("button", 4, y, pw - 8, 30, window)
			sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
			sightexports.sGui:setGuiHover(btn, "gradient", {
				"sightgreen",
				"sightgreen-second"
			}, false, true)
			sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
			sightexports.sGui:setButtonTextColor(btn, "#ffffff")
			sightexports.sGui:setButtonText(btn, "Bányászati engedély (5 000 $)")
			sightexports.sGui:setClickEvent(btn, "licenseOfficeButton")
			officeButtons[btn] = "mine"
			y = y + 30 + 4
		end
	end
end, true, "high+999999999")
