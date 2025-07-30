local sightexports = {
	sGui = false,
	sCamera = false,
	sRadar = false,
	sModloader = false,
	sPattach = false,
	sTrading = false,
	sCore = false
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
local sightlangModloaderLoaded = function()
	loadModels()
end
addEventHandler("modloaderLoaded", getRootElement(), sightlangModloaderLoaded)
if getElementData(localPlayer, "loggedIn") or sightexports.sModloader and sightexports.sModloader:isModloaderLoaded() then
	addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangModloaderLoaded)
end
local sightlangCondHandlState0 = false
local function sightlangCondHandl0(cond, prio)
	cond = cond and true or false
	if cond ~= sightlangCondHandlState0 then
		sightlangCondHandlState0 = cond
		if cond then
			addEventHandler("onClientPedsProcessed", getRootElement(), mobileBones, true, prio)
		else
			removeEventHandler("onClientPedsProcessed", getRootElement(), mobileBones)
		end
	end
end

local sightlangCondHandlState1 = false
local function sightlangCondHandl1(cond, prio)
	cond = cond and true or false
	if cond ~= sightlangCondHandlState1 then
		sightlangCondHandlState1 = cond
		if cond then
			addEventHandler("onForexUpdate", getRootElement(), onHomeForexUpdate, true, prio)
		else
			removeEventHandler("onForexUpdate", getRootElement(), onHomeForexUpdate)
		end
	end
end

local sightlangCondHandlState2 = false
local function sightlangCondHandl2(cond, prio)
	cond = cond and true or false
	if cond ~= sightlangCondHandlState2 then
		sightlangCondHandlState2 = cond
		if cond then
			addEventHandler("onClientKey", getRootElement(), forexAppScrollHandler, true, prio)
		else
			removeEventHandler("onClientKey", getRootElement(), forexAppScrollHandler)
		end
	end
end
local sightlangCondHandlState3 = false
local function sightlangCondHandl3(cond, prio)
	cond = cond and true or false
	if cond ~= sightlangCondHandlState3 then
		sightlangCondHandlState3 = cond
		if cond then
			addEventHandler("onForexUpdate", getRootElement(), onAppForexUpdate, true, prio)
		else
			removeEventHandler("onForexUpdate", getRootElement(), onAppForexUpdate)
		end
	end
end

function fileExists(f)
	return origFE(":sMobile/!mobile_sight/" .. f)
end
function fileCreate(f)
	return origFC(":sMobile/!mobile_sight/" .. f)
end
function fileOpen(f)
	return origFO(":sMobile/!mobile_sight/" .. f)
end
function fileDelete(f)
	return origFD(":sMobile/!mobile_sight/" .. f)
end
screenX, screenY = guiGetScreenSize()
local mobileObjects = {}
contactColors = {
	{
		78,
		205,
		196
	},
	{
		48,
		204,
		113
	},
	{
		52,
		152,
		219
	},
	{
		25,
		181,
		254
	},
	{
		52,
		73,
		94
	},
	{
		155,
		89,
		182
	},
	{
		241,
		196,
		13
	},
	{
		217,
		30,
		24
	},
	{
		243,
		156,
		18
	},
	{
		233,
		200,
		90
	},
	{
		134,
		226,
		213
	},
	{
		34,
		49,
		63
	},
	{
		231,
		76,
		60
	},
	{
		108,
		122,
		137
	}
}
soundState = false
vibrationState = false
locationState = false
voiceState = false
phoneContacts = {
	{
		{
			"ambulance",
			"solid"
		},
		8,
		"* SEGÉLYHÍVÓ *",
		112,
		false,
		1,
		true
	},
	{
		{
			"concierge-bell",
			"solid"
		},
		7,
		"* SZOLGÁLTATÁSOK *",
		1818,
		false,
		2,
		true
	},
	{
		"$",
		2,
		"* EGYENLEGINFÓ *",
		131,
		false,
		4,
		true
	}
}
hiddenContacts = {
	[3876100107] = {
		{
			"car",
			"solid"
		},
		8,
		"* SCKH BÍRSÁG *",
		3876100107,
		false,
		3,
		true
	},
	[1331] = {
		{
			"phone",
			"solid"
		},
		4,
		"* SIGHT-COM *",
		1331,
		false,
		5,
		true
	},
	[16053134000] = {
		{
			"hat-santa",
			"solid"
		},
		8,
		"* MIKULÁS *",
		16053134000
	},
	[73382228466] = {
		{
			"briefcase",
			"solid"
		},
		1,
		"* UTAZÁSI IRODA *",
		73382228466
	},
	[387579460801] = {
		{
			"money-bill"
		},
		9,
		"* A Valutás *",
		387579460801
	},
}
callSounds = {}
vibrateSounds = {}
function saveContacts()
	if fileExists("contacts.sight") then
		fileDelete("contacts.sight")
	end
	local file = fileCreate("contacts.sight")
	if file then
		for i = 1, #phoneContacts do
			if not phoneContacts[i][7] then
				fileWrite(file, phoneContacts[i][6] .. "#")
				fileWrite(file, phoneContacts[i][4] .. "#")
				fileWrite(file, phoneContacts[i][2] .. "#")
				fileWrite(file, phoneContacts[i][3] .. "\n")
			end
		end
		fileClose(file)
	end
end
contactsReversed = {}
lastContact = 0
function contactSort(a, b)
	local a2 = a and a[7] and 1 or 0
	local b2 = b and b[7] and 1 or 0
	if a2 and b2 and (a2 == 1 or b2 == 1) then
		return (a[6] or 0) < (b[6] or 0)
	else
		return utf8.lower(a[3]) < utf8.lower(b[3])
	end
end
function processContacts()
	table.sort(phoneContacts, contactSort)
	contactsReversed = {}
	for i = #phoneContacts, 1, -1 do
		if phoneContacts[i] then
			if not contactsReversed[phoneContacts[i][4]] then
				contactsReversed[phoneContacts[i][4]] = i
				if phoneContacts[i][6] > lastContact then
					lastContact = phoneContacts[i][6]
				end
			else
				table.remove(phoneContacts, i)
			end
		end
	end
end
loadedTextures = {}
local texturesToLoad = {
	{
		"files/img/avcut_sm.png",
		"E8130FF56469554A1A09A48E947ABF9CE183FB1C16BDB379DD91447721BD50B7"
	},
	{
		"files/img/avcut_lg.png",
		"CD3062395EFF636B7AEC97C64415647F73C1CA961DBBDCDA6D56683DED60AC01"
	},
	{
		"files/img/avshad.png",
		"29F52522A927B034DDEAE2F27D742E3C55AEF46AB270782746B10A1EF30AB538"
	},
	{
		"files/img/cam.png",
		"32D253DA61DEA24B9E2A5535C379144ACE109CD1775DD4DF955D7506F08CD268"
	},
	{
		"files/img/camload.png",
		"D3DE63DDE48260A9A5827649D00111D490C91CE3916F3D4D2E05C3EAE1DE0CCD"
	},
	{
		"files/img/camplus.png",
		"9932AEAB1C1E3E5C2A9996260B9CD62D4E7D866F1A87CAF51A85470ED6D2139C"
	},
	{
		"files/img/camcut.png",
		"3AA144C6D996378E707D37461B1D9F0210D58A2B9B808172AC196417E7742B5B"
	},
	{
		"files/img/prev.png",
		"6823F92FF411FB9B0085452970B69ECF4D00FC6FC358A47A9CCC98F7C4DE3ABF"
	},
	{
		"files/img/phone2x.png",
		"7F9545F621FC7CBEC5BF470B5638E9F1F5D4600F3A44B86E2E50571B8DFD5524"
	},
	{
		"files/img/phoneglass.png",
		"27178094317F7F27ABA33DC5CADA8E8E36D481BF890750F8DC23B5730473F894"
	},
	{
		"files/img/item_x.png",
		"437CCB93E42DC5B14A8EE8F43DB32EBB79E36B07BC48F4E2F4E392FEB3BE67E5"
	},
	{
		"files/img/widget.png",
		"E3EAD5C387954B335E177D3879ADCF36093E44D153E451579A959ACDBBDD654E"
	},
	{
		"files/icons/calculator.png",
		"B1A0EB38278FD96FD73B5A4A28E400ECFA068D17E7229F60F4EA76CFA816539C"
	},
	{
		"files/icons/camera.png",
		"752DD5E210729DE419091FC43B3872A8FA704E836BFC17AC9A09786D453ED382"
	},
	{
		"files/icons/settings.png",
		"D899023CE06C758ADA2B4C1BE52EF4EA3331AEC2B525D5538132B52A2B095000"
	},
	{
		"files/icons/sms.png",
		"F4A99FF85F8907A8E00F87BCCF9D93990896F769E7883E99D3AE3408279C93D0"
	},
	{
		"files/icons/gallery.png",
		"FB11DB90D2CBFDCD8A5308838B385FCF1EE4E646E83CD62F45F8B413D60FED2A"
	},
	{
		"files/icons/ad.png",
		"E6658A658CB8B9107E2043B459B70CC1746C1D7C2814B89506960F16876262BD"
	},
	{
		"files/icons/sightnion.png",
		"D9E1EFA126876CD731A3FB0E3B04741F32D9DE512030291CE3F6088BC4E5AEB6"
	},
	{
		"files/icons/phone.png",
		"964C97FBE647602E03B20A6D6FCA4555C05C1457C572F002FB891E74FBCBC6BC"
	},
	{
		"files/bcg/0.png",
		"BBD2926381B4592724226A38090961E078A09B6D618E6969CB563CFB8E6D7915"
	},
	{
		"files/bcg/1.png",
		"B07B3BDDCBD5CF0A095FA4A76F50C2E3CC10159B9653E7114B3133C2DD934EFE"
	},
	{
		"files/bcg/2.png",
		"DDB8E86CA25EF664497B31A9A2ECE28B2F25058D95698B7EDF599B8AF7E398F0"
	},
	{
		"files/bcg/3.png",
		"698BE6E594CA2F11BF72A7C97588D2699546AC80669EDE94089FE93E5980220C"
	},
	{
		"files/bcg/4.png",
		"3FBCF7C0C8420D75CAEA31515BE1B5635CBDE22727C3BA728A11E5943EEB2408"
	},
	{
		"files/bcg/5.png",
		"C4F5A73809E8CB85B8A39B7790A5D05B7CA0BEF4D28CE2F31117FA8AEF0D7BB8"
	},
	{
		"files/bcg/6.png",
		"E541E0C28DC9691DC207945BBCC4293303CF919FFF4F62775EECE4FFACE284DB"
	},
	{
		"files/bcg/7.png",
		"953154E6796B9BAF8AFD3BB22B5470B80A58195CB6004642C0504D54B97F50F5"
	},
	{
		"files/bcg/8.png",
		"3BEA6F0AB055497BC5621E0D542E0DED4E8CADC25AD62AE784F871DEB63F95E7"
	},
	{
		"files/bcg/9.png",
		"3AD8099DBA25DD08FF4B90BDC4B227787A2C9920919FB5B59039B13F37080542"
	},
	{
		"files/bcg/10.png",
		"E76F101457793E47D947C6E7C798C550C0C8FB3903D1A0703F1A09905C60EBAF"
	},
	{
		"files/bcg/11.png",
		"DA80A90AD7DCF73B2831AD79D2C8AE37B79374D8D6B94B692540EEE6C6B77D78"
	},
	{
		"files/bcg/12.png",
		"54919DCB8ACB09A02AE5607AC357FE8450159B8C93791DBD0BB7BAC7DA89479D"
	},
	{
		"files/bcg/13.png",
		"0201BF78BAD28CA03F9A5A19FE8D608B7CB61D6BADBFF11716C5DAC1835B455C"
	},
	{
		"files/bcg/14.png",
		"4CDD682F5DB0FD40907C742C08A966E17F4CA8DA8920E0927AFBBFAAED144BBB"
	},
	{
		"files/bcg/15.png",
		"705A2EDC5066E0A75C68620BB46C8200AADF875651A9EF0B89CC7FD1CD41C898"
	},
	{
		"files/bcg/16.png",
		"49A036CF9B95874EC058CB70AD33AA38F85C7DDF4CE137355D1E2ABEB10476FB"
	},
	{
		"files/bcg/17.png",
		"C6484ECCCDDAFE2DC9218203609A630089143CF19AFBFDA3FA5D6CB9656B0BAE"
	},
	{
		"files/bcg/18.png",
		"1ED63B4E375CC684128E32C4F047DDC3BB44E2541C9C605F144E9CD5364C7A29"
	},
	{
		"files/bcg/19.png",
		"4CBEA10A4AC4FB0C368A88700C3EEA91D5DB2A30566A23A9B5F01009FE01F412"
	},
	{
		"files/bcg/20.png",
		"A80CEE0439034536B9EFD4DAAF3E0B32CB54639FE6A488AC42F768C65FCF4EA3"
	},
	{
		"files/bcg/21.png",
		"A925A640FE99B0AF910EF101434CC064C972EA5098C7022F74C07FCB8964DB11"
	},
	{
		"files/bcg/22.png",
		"396656E5A772916F84647E190ACC51EBA3C4F591CD4C96337BFE7A6DA0AF62BC"
	},
	{
		"files/bcg/23.png",
		"018463832051122DB08335EEEA611AC9054335A42BB18B49FD89E7A97186F2CE"
	},
	{
		"files/bcg/24.png",
		"22F681DB1C968D4EFA5D8CA4090F4CABBA51D1AFB28A39DBC47E3910147EDAE5"
	},
	{
		"files/bcg/25.png",
		"C3E00B8730151D40F7A23F98109293B5078AE10E556D31BC464AF458952C8599"
	},
	{
		"files/bcg/26.png",
		"246A5A5D214171612737D2B75EB62E67BADAB63F7962F17C99CF1408D597A657"
	},
	{
		"files/bcg/27.png",
		"402D8E73C52F710BD36593500F4CD477F4F534D8B6548D12A79D2F3F25EC1C5D"
	},
	{
		"files/bcg/28.png",
		"F76671501098FFB5AB4970287052F095949822EE005E2CA9CEE29BFCCC9DB4C6"
	},
	{
		"files/bcg/29.png",
		"20F464B6C033AD3F94351FAE6B9AA8EB9F461DD1062CACE4712C920CA6AB04B7"
	},
	{
		"files/bcg/30.png",
		"E172086A65ABB0CE7D1D46881EE382EBB489F1E1A1825D23FBA73066D1D60779"
	},
	{
		"files/bcg/31.png",
		"5705760D384226F49C185FF6EE1253369F69B4863A97A2F713F2ECD2A6649B24"
	},
	{
		"files/bcg/32.png",
		"CA1682CBBD9E3F6FB47F667F6BF8C7396BDBF1D75541A84A0496DCD9F5E33448"
	},
	{
		"files/bcg/33.png",
		"5947E90EA5F883A4012AEE3237A0AFB9ED0B5B66866CEEC05BAC6C973C269F9C"
	},
	{
		"files/bcg/34.png",
		"6D7B990CC3C0FB6EEED8108E1806899FDEBC87EB7574E898C0110D1427873550"
	},
	{
		"files/bcg/35.png",
		"EC7E86C9291C882B09D3E2DECC4C7FEEE23C9C77C6EBBE9875028D990AB72E22"
	},
	{
		"files/bcg/36.png",
		"BEB1464126758E7F796322CA42878223E28D3ED7A4A6DA8F671A2EEB66C01E05"
	},
	{
		"files/bcg/37.png",
		"E1C25BFD4D0BE6BFF37C24049A7D91FC0C111DE4B7C7E2C1F403470E95A3F8D8"
	},
	{
		"files/bcg/38.png",
		"2840F80B254C0453A56A8D75202F36298DDEC63F0321F8CEA41DAC03F9D89710"
	},
	{
		"files/bcg/39.png",
		"3D0F2CE9D27CB95D9170656C1D78699F888CCAFE8A0628A7BAF3D6514042E9A7"
	},
	{
		"files/bcg/40.png",
		"DE73CD69814E2EE61857E024C9830906284F8B7C01C402DC029B6DFB1EFC70A1"
	},
	{
		"files/bcg/41.png",
		"DA6555CACCD84EA4D3579B3A0EC014EC1C5805958F55F647039D0328B1074A91"
	}
}
red = "#ee2129"
green = "#0c9c5d"
green2 = "#0b854f"
blue = "#21b7ee"
blue2 = "#1c9bc9"
yellow = "#e8ce23"
grey1 = "#a1a1a1"
grey2 = "#999999"
grey3 = "#474747"
mobileBackground = false
mobileFrame = false
mobileScreen = false
appInside = false
topRect = false
topLabel = false
topLabel2 = false
topIcons = {}
appCloses = {}
appScreens = {}
local timeLabel = fal
sx, sy = 262, 522
bsx, bsy = 241, 505
if origFE("!mobile_pos.sight") then
	local file = origFO("!mobile_pos.sight")
	local data = fileRead(file, fileGetSize(file))
	fileClose(file)
	local pos = split(data, ",")
	x = tonumber(pos[1])
	y = tonumber(pos[2])
	if x and y then
		x = math.max(0 - sx / 2, math.min(screenX - sx / 2, x))
		y = math.max(0 - sy / 2, math.min(screenY - sy / 2, y))
	else
		x = screenX - sx * 1.5
		y = screenY / 2 - sy / 2
	end
else
	x = screenX - sx * 1.5
	y = screenY / 2 - sy / 2
end
topSize = 20
currentBackground = 0
currentPhoneScreen = "locked"
ppBalance = 0
addEvent("gotPremiumData", true)
addEventHandler("gotPremiumData", getRootElement(), function(dat)
	ppBalance = dat
end)
photoLandscape = false
local cameraLandscape = true
local gallerySelecting = false
local originalBcgX, originalBcgY = 460, 972
local customBackground = false
function generateBottom(solid, back, noScreen)
	local rect = sightexports.sGui:createGuiElement("rectangle", 0, bsy - topSize * 1.5, bsx, topSize * 1.5, appInside)
	sightexports.sGui:setGuiBackground(rect, "solid", {
		0,
		0,
		0,
		solid and 255 or 125
	})
	local icon = sightexports.sGui:createGuiElement("image", bsx / 2 - topSize * 1.1 / 2, bsy - topSize * 1.5 / 2 - topSize * 1.1 / 2, topSize * 1.1, topSize * 1.1, appInside)
	sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("circle", topSize * 1.1, "regular"))
	sightexports.sGui:setGuiHoverable(icon, true)
	sightexports.sGui:setClickEvent(icon, "backToHome")
	local icon = sightexports.sGui:createGuiElement("image", topSize * 2, bsy - topSize * 1.5 / 2 - topSize * 1.1 / 2, topSize * 1.1, topSize * 1.1, appInside)
	sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("chevron-left", topSize * 1.1, "solid"))
	sightexports.sGui:setGuiHoverable(icon, true)
	sightexports.sGui:setClickEvent(icon, back or "backToHome")
	if not noScreen then
		local icon = sightexports.sGui:createGuiElement("image", bsx - topSize * 2 - topSize * 1.1, bsy - topSize * 1.5 / 2 - topSize * 1.1 / 2, topSize * 1.1, topSize * 1.1, appInside)
		sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("camera", topSize * 1.1, "solid"))
		sightexports.sGui:setGuiHoverable(icon, true)
		sightexports.sGui:setClickEvent(icon, "takeScreenshot")
	else
		local icon = sightexports.sGui:createGuiElement("image", bsx - topSize * 2 - topSize * 1.1, bsy - topSize * 1.5 / 2 - topSize * 1.1 / 2, topSize * 1.1, topSize * 1.1, appInside)
		sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("camera", topSize * 1.1, "solid"))
		sightexports.sGui:setImageColor(icon, {
			255,
			255,
			255,
			100
		})
	end
end
local topRect = false
function bringBackFront()
	if topRect then
		sightexports.sGui:guiToFront(topRect)
	end
	if mobileFrame then
		sightexports.sGui:guiToFront(mobileFrame)
	end
end
function appScreens.none()
	appInside = sightexports.sGui:createGuiElement("null", 0, 0, bsx, bsy, mobileBackground)
	local rect = sightexports.sGui:createGuiElement("rectangle", 0, 0, bsx, bsy, appInside)
	sightexports.sGui:setGuiBackground(rect, "solid", {
		255,
		255,
		255
	})
	generateBottom(true)
	bringBackFront()
end
addEvent("takeScreenshot", false)
addEventHandler("takeScreenshot", getRootElement(), function()
	takePhoto(true)
end)
local previewBackground = false
addEvent("nextBackground", false)
addEventHandler("nextBackground", getRootElement(), function()
	currentBackground = currentBackground + 1
	if currentBackground > 41 then
		currentBackground = customBackground and -1 or 0
	end
	if currentBackground == -1 then
		sightexports.sGui:setImageDDS(mobileBackground, ":sMobile/!mobile_sight/bcg.dds", "dxt3", false)
		sightexports.sGui:setImageDDS(previewBackground, ":sMobile/!mobile_sight/bcg.dds", "dxt3", false)
	else
		sightexports.sGui:setImageFile(mobileBackground, loadedTextures["files/bcg/" .. currentBackground .. ".png"])
		sightexports.sGui:setImageFile(previewBackground, loadedTextures["files/bcg/" .. currentBackground .. ".png"])
	end
	local currFile = false
	if fileExists("curr_bcg.sight") then
		currFile = fileOpen("curr_bcg.sight")
	else
		currFile = fileCreate("curr_bcg.sight")
	end
	if currFile then
		local str = ""
		if currentBackground < 0 then
			fileWrite(currFile, "-01")
		else
			str = tostring(currentBackground)
			for i = 1, 3 - utf8.len(str) do
				str = "0" .. str
			end
			fileWrite(currFile, str)
		end
		fileClose(currFile)
	end
end)
addEvent("previousBackground", false)
addEventHandler("previousBackground", getRootElement(), function()
	currentBackground = currentBackground - 1
	if currentBackground < (customBackground and -1 or 0) then
		currentBackground = 41
	end
	if currentBackground == -1 then
		sightexports.sGui:setImageDDS(mobileBackground, ":sMobile/!mobile_sight/bcg.dds", "dxt3", false)
		sightexports.sGui:setImageDDS(previewBackground, ":sMobile/!mobile_sight/bcg.dds", "dxt3", false)
	else
		sightexports.sGui:setImageFile(mobileBackground, loadedTextures["files/bcg/" .. currentBackground .. ".png"])
		sightexports.sGui:setImageFile(previewBackground, loadedTextures["files/bcg/" .. currentBackground .. ".png"])
	end
	local currFile = false
	if fileExists("curr_bcg.sight") then
		currFile = fileOpen("curr_bcg.sight")
	else
		currFile = fileCreate("curr_bcg.sight")
	end
	if currFile then
		local str = ""
		if currentBackground < 0 then
			fileWrite(currFile, "-01")
		else
			str = tostring(currentBackground)
			for i = 1, 3 - utf8.len(str) do
				str = "0" .. str
			end
			fileWrite(currFile, str)
		end
		fileClose(currFile)
	end
end)
local settingsLabels = {}
currentSound = {ringtone = 1, noti = 1}
local previewSound = false
addEvent("notiPlay", false)
addEventHandler("notiPlay", getRootElement(), function()
	if isElement(previewSound) then
		destroyElement(previewSound)
	end
	previewSound = playSound("files/noti/" .. currentSound.noti .. ".wav")
end)
addEvent("ringtoneNext", false)
addEventHandler("ringtoneNext", getRootElement(), function()
	currentSound.ringtone = currentSound.ringtone + 1
	if currentSound.ringtone > ringtoneNum then
		currentSound.ringtone = 1
	end
	triggerServerEvent("syncRingtoneSound", localPlayer, currentSound.ringtone)
	sightexports.sGui:setLabelText(settingsLabels.ringtone, currentSound.ringtone)
	if isElement(previewSound) then
		destroyElement(previewSound)
	end
	previewSound = playSound("files/call/ringtone/" .. currentSound.ringtone .. ".wav")
end)
addEventHandler("onClientSoundStopped", getRootElement(), function()
	if source == previewSound then
		previewSound = false
	end
end)
addEvent("ringtonePrev", false)
addEventHandler("ringtonePrev", getRootElement(), function()
	currentSound.ringtone = currentSound.ringtone - 1
	if currentSound.ringtone < 1 then
		currentSound.ringtone = ringtoneNum
	end
	triggerServerEvent("syncRingtoneSound", localPlayer, currentSound.ringtone)
	sightexports.sGui:setLabelText(settingsLabels.ringtone, currentSound.ringtone)
	if isElement(previewSound) then
		destroyElement(previewSound)
	end
	previewSound = playSound("files/call/ringtone/" .. currentSound.ringtone .. ".wav")
end)
addEvent("notiNext", false)
addEventHandler("notiNext", getRootElement(), function()
	currentSound.noti = currentSound.noti + 1
	if currentSound.noti > notiNum then
		currentSound.noti = 1
	end
	triggerServerEvent("syncNotiSound", localPlayer, currentSound.noti)
	sightexports.sGui:setLabelText(settingsLabels.noti, currentSound.noti)
	if isElement(previewSound) then
		destroyElement(previewSound)
	end
	previewSound = playSound("files/noti/" .. currentSound.noti .. ".wav")
end)
addEvent("notiPrev", false)
addEventHandler("notiPrev", getRootElement(), function()
	currentSound.noti = currentSound.noti - 1
	if currentSound.noti < 1 then
		currentSound.noti = notiNum
	end
	triggerServerEvent("syncNotiSound", localPlayer, currentSound.noti)
	sightexports.sGui:setLabelText(settingsLabels.noti, currentSound.noti)
	if isElement(previewSound) then
		destroyElement(previewSound)
	end
	previewSound = playSound("files/noti/" .. currentSound.noti .. ".wav")
end)
addEvent("ringtonePlay", false)
addEventHandler("ringtonePlay", getRootElement(), function()
	if isElement(previewSound) then
		destroyElement(previewSound)
	else
		previewSound = playSound("files/call/ringtone/" .. currentSound.ringtone .. ".wav")
	end
end)
function appCloses.settings()
	if isElement(previewSound) then
		destroyElement(previewSound)
	end
	previewSound = false
end
clickSoundState = true
addEvent("toggleClick", true)
addEventHandler("toggleClick", getRootElement(), function(button, state, absoluteX, absoluteY, el, eventArgument)
	if state == "down" then
		if eventArgument == "click" then
			clickSoundState = sightexports.sGui:getToggleState(el)
			if fileExists("clicksound.sight") then
				fileDelete("clicksound.sight")
			end
			local file = fileCreate("clicksound.sight")
			if file then
				fileWrite(file, tostring(clickSoundState and 1 or 0))
				fileClose(file)
			end
			if clickSoundState then
				playSound("files/click.wav")
			end
		end
	end
end)

addEvent("toggleSeerexWidget", true)
addEventHandler("toggleSeerexWidget", getRootElement(), function(r0_32, r1_32, r2_32, r3_32, r4_32)
  -- line: [702, 725] id: 32
  if r1_32 == "down" then
    widgetShowState = sightexports.sGui:getToggleState(r4_32)
    if fileExists("widgetstate.sight") then
      fileDelete("widgetstate.sight")
    end
    local r5_32 = fileCreate("widgetstate.sight")
    if r5_32 then
      local r6_32 = fileWrite
      local r7_32 = r5_32
      local r8_32 = tostring
      local r9_32 = widgetShowState
      if r9_32 then
        r9_32 = 1
      else
        r9_32 = 0
      end
      r6_32(r7_32, r8_32(r9_32))
      fileClose(r5_32)
    end
    if widgetShowState then
      playSound("files/click.wav")
    end
    if currentPhoneScreen == "home" then
      switchAppScreen("home", true)
    end
  end
end)

addEvent("copyPhoneNumber", false)
addEventHandler("copyPhoneNumber", getRootElement(), function(button, state, absoluteX, absoluteY, el)
	if currentMobileNumber then
		setClipboard(formatPhoneNumber(currentMobileNumber))
		sightexports.sGui:showInfobox("s", "A telefonszámod sikeresen a vágólapra lett másolva!")
	end
end)
local settings = {
	{
		"Telefonszám",
		"num"
	},
	{
		"Érintés hangja",
		"clickToggle",
		"click",
	},
	{
		"Csengőhang",
		"selector",
		"ringtone"
	},
	{
		"Értesítéshang",
		"selector",
		"noti"
	},
	{
		"SIGHTREX Trading Widget",
		"widgetToggle"
	},
	{
		"Háttérkép",
		"bcg",
		"bcg"
	}
}

local orderDetails = {
	[1] = {
		position = {1743.8348388672, -1800.1613769531, 54.568691253662},
		name = "Dennis_Mercury",
		orderedFrom = "Burger King"
	},
	[2] = {
		position = {2146.4829101562, -2021.3071289062, 54.568691253662},
		name = "Dennis_Mercury2",
		orderedFrom = "Burger King"
	},
	[3] = {
		position = {2469.029296875, -1638.3331298828, 54.568691253662},
		name = "Dennis_Mercury3",
		orderedFrom = "Burger King"
	},
	[4] = {
		position = {1673.0301513672, -374.43048095703, 115.56869506836},
		name = "Dennis_Mercury4",
		orderedFrom = "Burger King"
	},
	[5] = {
		position = {762.76861572266, -518.41577148438, 60.568695068359},
		name = "Dennis_Mercury5",
		orderedFrom = "Burger King"
	},
}

function appScreens.sighteats()
	appInside = sightexports.sGui:createGuiElement("null", 0, 0, bsx, bsy, mobileBackground)
	local rect = sightexports.sGui:createGuiElement("rectangle", 0, 0, bsx, bsy, appInside)
	sightexports.sGui:setGuiBackground(rect, "solid", {
		255,
		255,
		255
	})
	
	local label = sightexports.sGui:createGuiElement("label", 7.5, topSize + 5, bsx, bsy, appInside)
	sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
	sightexports.sGui:setLabelAlignment(label, "left", "top")
	sightexports.sGui:setLabelColor(label, "#000000")
	sightexports.sGui:setLabelText(label, "Üdvözlünk [color=sightgreen]Dennis Mercury#000000!")
	
	local label = sightexports.sGui:createGuiElement("label", 0, topSize + 5 + 20, bsx, bsy, appInside)
	sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
	sightexports.sGui:setLabelAlignment(label, "center", "top")
	sightexports.sGui:setLabelColor(label, "#000000")
	sightexports.sGui:setLabelText(label, "Bejövő rendelések")
	
	local rect = sightexports.sGui:createGuiElement("rectangle", 10, topSize + 18 + 30, bsx - 20, 75, appInside)
	sightexports.sGui:setGuiBackground(rect, "solid", "sightmidgrey")
	local rect = sightexports.sGui:createGuiElement("rectangle", 10 + 1, topSize + 18 + 1 + 30, bsx - 20 - 2, 75 - 2, appInside)
	sightexports.sGui:setGuiBackground(rect, "solid", "hudwhite")
	
	exports.sRadar:drawSecondaryRadar(200, 200, 20, 20, orderDetails[1].position[1], orderDetails[1].position[2], orderDetails[1].position[3], 255)
	exports.sRadar:forceRadarToRender(true)
	
	generateBottom(true, false, true)
	bringBackFront()
end

function appScreens.settings()
	appInside = sightexports.sGui:createGuiElement("null", 0, 0, bsx, bsy, mobileBackground)
	local rect = sightexports.sGui:createGuiElement("rectangle", 0, 0, bsx, bsy, appInside)
	sightexports.sGui:setGuiBackground(rect, "solid", {
		255,
		255,
		255
	})
	local h = (bsy - topSize - topSize * 1.5) / 13
	local y = 0
	for i = 1, 13 do
		if settings[i] then
			y = y + 1
			local bbox = sightexports.sGui:createGuiElement("null", 0, topSize + (y - 1) * h, bsx, h, appInside)
			local label = sightexports.sGui:createGuiElement("label", 12, topSize + (y - 1) * h, bsx - 24 - h * 2, h - 1, appInside)
			sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
			sightexports.sGui:setLabelAlignment(label, "left", "center")
			sightexports.sGui:setLabelColor(label, "#000000")
			sightexports.sGui:setLabelText(label, settings[i][1])
			if settings[i][2] == "selector" then
				local icon = sightexports.sGui:createGuiElement("image", bsx - h * 2, topSize + (y - 1) * h, h, h, appInside)
				sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("angle-right", h))
				sightexports.sGui:setImageColor(icon, "#333333")
				sightexports.sGui:setGuiHoverable(icon, true)
				sightexports.sGui:setClickEvent(icon, settings[i][3] .. "Next")
				local icon = sightexports.sGui:createGuiElement("image", bsx - h * 3, topSize + (y - 1) * h, h, h, appInside)
				sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("angle-left", h))
				sightexports.sGui:setImageColor(icon, "#333333")
				sightexports.sGui:setGuiHoverable(icon, true)
				sightexports.sGui:setClickEvent(icon, settings[i][3] .. "Prev")
				local label = sightexports.sGui:createGuiElement("label", bsx - h * 3, topSize + (y - 1) * h, h * 2, h, appInside)
				sightexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
				sightexports.sGui:setLabelAlignment(label, "center", "center")
				sightexports.sGui:setLabelColor(label, "#000000")
				sightexports.sGui:setLabelText(label, currentSound[settings[i][3]])
				settingsLabels[settings[i][3]] = label
				local h2 = math.floor(h * 0.6)
				local icon = sightexports.sGui:createGuiElement("image", bsx - h * 0.8, topSize + (y - 1) * h + h / 2 - h2 / 2, h2, h2, appInside)
				sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("play", h2))
				sightexports.sGui:setImageColor(icon, "#333333")
				sightexports.sGui:setGuiHoverable(icon, true)
				sightexports.sGui:setClickEvent(icon, settings[i][3] .. "Play")
			elseif settings[i][2] == "bcg" then
				local icon = sightexports.sGui:createGuiElement("image", bsx - 48, topSize + (y - 1) * h + h / 2 - 16, 32, 32, appInside)
				sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("folder-open", 32, "regular"))
				sightexports.sGui:setImageColor(icon, "#333333")
				sightexports.sGui:setGuiHoverable(icon, true)
				sightexports.sGui:setClickEvent(icon, "openGalleryForSettings")
				local r = h * 6 / sy
				local icon = sightexports.sGui:createGuiElement("image", bsx / 2 + bsx * r / 2 + 8, topSize + y * h + 10 + h * 6 / 2 - 24, 48, 48, appInside)
				sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("angle-right", 48))
				sightexports.sGui:setImageColor(icon, "#333333")
				sightexports.sGui:setGuiHoverable(icon, true)
				sightexports.sGui:setClickEvent(icon, "nextBackground")
				local icon = sightexports.sGui:createGuiElement("image", bsx / 2 - bsx * r / 2 - 8 - 48, topSize + y * h + 10 + h * 6 / 2 - 24, 48, 48, appInside)
				sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("angle-left", 48))
				sightexports.sGui:setImageColor(icon, "#333333")
				sightexports.sGui:setGuiHoverable(icon, true)
				sightexports.sGui:setClickEvent(icon, "previousBackground")
				local pw, ph = sx * r, h * 6
				local pbw, pbh = bsx * r, bsy * r
				local px, py = math.floor(bsx / 2 - bsx * r / 2), math.floor(topSize + y * h + 10)
				previewBackground = sightexports.sGui:createGuiElement("image", px + math.floor((pw - pbw) / 2), py + math.floor((ph - pbh) / 2), pbw, pbh, appInside)
				if customBackground and currentBackground == -1 then
					sightexports.sGui:setImageDDS(previewBackground, ":sMobile/!mobile_sight/bcg.dds", "dxt3", false)
				else
					sightexports.sGui:setImageFile(previewBackground, loadedTextures["files/bcg/" .. currentBackground .. ".png"])
				end
				local frame = sightexports.sGui:createGuiElement("image", px, py, pw, ph, appInside)
				sightexports.sGui:setImageFile(frame, loadedTextures["files/img/phone2x.png"])
				y = y + 7
			elseif settings[i][2] == "num" then
				local label = sightexports.sGui:createGuiElement("label", 12, topSize + (y - 1) * h, bsx - 24, h - 1, appInside)
				sightexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
				sightexports.sGui:setLabelAlignment(label, "right", "center")
				sightexports.sGui:setLabelColor(label, "#000000")
				sightexports.sGui:setLabelText(label, formatPhoneNumber(currentMobileNumber))
				sightexports.sGui:setGuiHoverable(label, true)
				sightexports.sGui:setClickEvent(label, "copyPhoneNumber")
			elseif settings[i][2] == "clickToggle" then
				local rect = sightexports.sGui:createGuiElement("rectangle", bsx - 12 - 25, topSize + (y - 1) * h + 10, 25, h - 20 - 1, appInside)
				sightexports.sGui:setGuiBackground(rect, "solid", grey1)
				local toggle = sightexports.sGui:createGuiElement("toggle", bsx - 12 - 25 + 1, topSize + (y - 1) * h + 10 + 1, 23, h - 20 - 2 - 1, appInside)
				sightexports.sGui:setToggleColor(toggle, "#ffffff", red, green)
				sightexports.sGui:setGuiBoundingBox(toggle, bbox)
				sightexports.sGui:setClickEvent(toggle, "toggleClick")
				sightexports.sGui:setClickArgument(toggle, settings[i][3])
				sightexports.sGui:setToggleState(toggle, settings[i][3] == "click" and clickSoundState or widgetShowState, true)
				settings[i][4] = toggle
			elseif settings[i][2] == "widgetToggle" then
				sightexports.sGui:setGuiBackground(sightexports.sGui:createGuiElement("rectangle", bsx - 12 - 25, topSize + (y - 1) * h + 10, 25, h - 20 - 1, appInside), "solid", grey1)
				local toggle = sightexports.sGui:createGuiElement("toggle", bsx - 12 - 25 + 1, topSize + (y - 1) * h + 10 + 1, 23, h - 20 - 2 - 1, appInside)
				sightexports.sGui:setToggleColor(toggle, "#ffffff", red, green)
				sightexports.sGui:setGuiBoundingBox(toggle, bbox)
				sightexports.sGui:setClickEvent(toggle, "toggleSeerexWidget")
				sightexports.sGui:setToggleState(toggle, widgetShowState, true)
        		settings[i][4] = toggle
			else
				settings[i][4] = bbox
			end
			if y < 13 then
				local border = sightexports.sGui:createGuiElement("rectangle", 0, topSize + y * h - 2, bsx, 1, appInside)
				sightexports.sGui:setGuiBackground(border, "solid", grey2)
			else
				break
			end
		end
	end
	generateBottom(true, false, true)
	bringBackFront()
end
local time = ""
topExpanded = false
topExpandClose = false
topExpandedElements = false
local soundIcons = {}
local vibrationIcons = {}
local locationIcons = {}
local voiceIcons = {}
function deleteTop()
	topIcons = {}
	if topExpandedElements then
		sightexports.sGui:deleteGuiElement(topExpandedElements[1])
		for i = 1, #topExpandedElements[2] do
			sightexports.sGui:deleteGuiElement(topExpandedElements[2][i][1])
		end
		for i = 1, #topExpandedElements[8] do
			sightexports.sGui:deleteGuiElement(topExpandedElements[8][i][1])
		end
		sightexports.sGui:deleteGuiElement(topExpandedElements[5])
		sightexports.sGui:deleteGuiElement(topExpandedElements[6])
		sightexports.sGui:deleteGuiElement(topExpandedElements[7])
		topExpandedElements = false
		soundIcons = {}
		vibrationIcons = {}
		locationIcons = {}
		voiceIcons = {}
	end
	if topRect then
		sightexports.sGui:deleteGuiElement(topRect)
	end
	topRect = false
	if topNoti then
		topNoti[1] = false
	end
end
notifications = {}
function saveNotifications()
	if fileExists("notifications.sight") then
		fileDelete("notifications.sight")
	end
	local file = fileCreate("notifications.sight")
	if file then
		for i = 1, #notifications do
			if notifications[i] then
				fileWrite(file, notifications[i][1] .. "#" .. notifications[i][2] .. "#" .. notifications[i][3] .. "#" .. notifications[i][4] .. "\n")
			end
		end
		fileClose(file)
	end
end
function refreshNotifications()
	for i = 1, #notifications do
		if notifications[i] then
			notifications[i][5] = nil
		end
	end
	if mobileState and currentPhoneScreen ~= "photo_landscape" and currentPhoneScreen ~= "camera_landscape" and currentPhoneScreen ~= "photo_portrait" and currentPhoneScreen ~= "camera" then
		createTop(true)
		if topExpanded then
			bringBackFront()
		end
	end
end
smallVibration = false
local lastNoti = 0
function pushNotification(theType, from, time, text, noRefresh, now, sound, vib)
	local file = false
	if fileExists("notifications.sight") then
		file = fileOpen("notifications.sight")
		fileSetPos(file, fileGetSize(file))
	else
		file = fileCreate("notifications.sight")
	end
	if file then
		fileWrite(file, theType .. "#" .. from .. "#" .. time .. "#" .. text .. "\n")
		fileClose(file)
	end
	table.insert(notifications, {
		theType,
		from,
		time,
		text,
		noRefresh
	})
	if currentPhoneScreen == "home" and (theType == "call" or theType == "sms") then
		switchAppScreen("home", true)
	end
	if not noRefresh then
		if now then
			sound = sound or soundState
			vib = vib or vibrationState
			if getTickCount() - lastNoti > 500 then
				if sound then
					playSound("files/noti/" .. currentSound.noti .. ".wav")
				end
				if vib then
					playSound("files/noti/vib.wav")
					smallVibration = getTickCount()
				end
				lastNoti = getTickCount()
			end
		end
		refreshNotifications()
	end
end
local lastToggle = {
	soundState = 0,
	vibrationState = 0,
	locationState = 0,
	voiceState = 0
}
addEvent("toggleSoundState", false)
addEventHandler("toggleSoundState", getRootElement(), function()
	if getTickCount() - lastToggle.soundState > 500 then
		lastToggle.soundState = getTickCount()
		soundState = not soundState
		triggerServerEvent("syncSoundState", localPlayer, soundState)
		if soundState then
			playSound("files/soundon.wav")
		end
		createTop(topExpandedElements)
		bringBackFront()
		if topExpandedElements then
			if soundState and clickSoundState then
				playSound("files/click.wav")
			end
			sightexports.sGui:setImageColor(soundIcons[1], soundState and blue or "#ffffff")
			sightexports.sGui:setImageColor(soundIcons[2], soundState and "#ffffff" or "#444444")
		end
	end
end)
addEvent("toggleVibrationState", false)
addEventHandler("toggleVibrationState", getRootElement(), function()
	if getTickCount() - lastToggle.vibrationState > 500 then
		lastToggle.vibrationState = getTickCount()
		vibrationState = not vibrationState
		triggerServerEvent("syncVibrationState", localPlayer, vibrationState)
		if vibrationState then
			playSound("files/noti/vib.wav")
			smallVibration = getTickCount()
		end
		createTop(topExpandedElements)
		bringBackFront()
		if topExpandedElements then
			if soundState and clickSoundState then
				playSound("files/click.wav")
			end
			sightexports.sGui:setImageColor(vibrationIcons[1], vibrationState and blue or "#ffffff")
			sightexports.sGui:setImageColor(vibrationIcons[2], vibrationState and "#ffffff" or "#444444")
			sightexports.sGui:setImageColor(vibrationIcons[3], vibrationState and "#ffffff" or "#444444")
			sightexports.sGui:setImageColor(vibrationIcons[4], vibrationState and "#ffffff" or "#444444")
		end
	end
end)
addEvent("toggleLocationState", false)
addEventHandler("toggleLocationState", getRootElement(), function()
	if getTickCount() - lastToggle.locationState > 500 then
		lastToggle.locationState = getTickCount()
		locationState = not locationState
		triggerServerEvent("syncLocationState", localPlayer, locationState)
		if currentPhoneScreen == "sms_single" then
			lockSMSScroll = true
			switchAppScreen("sms_single", true)
		end
		createTop(topExpandedElements)
		bringBackFront()
		if topExpandedElements then
			if soundState and clickSoundState then
				playSound("files/click.wav")
			end
			sightexports.sGui:setImageColor(locationIcons[1], locationState and blue or "#ffffff")
			sightexports.sGui:setImageColor(locationIcons[2], locationState and "#ffffff" or "#444444")
		end
	end
end)
addEvent("toggleVoiceState", false)
addEventHandler("toggleVoiceState", getRootElement(), function()
	if getTickCount() - lastToggle.voiceState > 500 then
		lastToggle.voiceState = getTickCount()
		voiceState = not voiceState
		triggerServerEvent("syncVoiceState", localPlayer, voiceState)
		createTop(topExpandedElements)
		bringBackFront()
		if topExpandedElements then
			if soundState and clickSoundState then
				playSound("files/click.wav")
			end
			sightexports.sGui:setImageColor(voiceIcons[1], voiceState and blue or "#ffffff")
			sightexports.sGui:setImageColor(voiceIcons[2], voiceState and "#ffffff" or "#444444")
		end
	end
end)
local notiCount = 0
function expandTop(force, fromTop)
	if topExpanded and topRect then
		if not fromTop and callStatus and not inCallScreens[currentPhoneScreen] then
			createTop()
			return
		end
		if force and topExpandedElements then
			sightexports.sGui:deleteGuiElement(topExpandedElements[1])
			for i = 1, #topExpandedElements[2] do
				sightexports.sGui:deleteGuiElement(topExpandedElements[2][i][1])
			end
			for i = 1, #topExpandedElements[8] do
				sightexports.sGui:deleteGuiElement(topExpandedElements[8][i][1])
			end
			sightexports.sGui:deleteGuiElement(topExpandedElements[5])
			sightexports.sGui:deleteGuiElement(topExpandedElements[6])
			sightexports.sGui:deleteGuiElement(topExpandedElements[7])
			topExpandedElements = false
			soundIcons = {}
			vibrationIcons = {}
			locationIcons = {}
			voiceIcons = {}
		end
		if not topExpandedElements then
			topExpandedElements = {}
			notiCount = 0
			for i = #notifications, 1, -1 do
				if notifications[i] and not notifications[i][5] then
					notiCount = notiCount + 1
				end
			end
			local w = (bsx - 16) / 4
			local eh = topSize + w + 8 + 4 + 68 * math.min(notiCount, 5) + 2
			local w2 = math.floor(w * 0.5 / 2) * 2
			local w3 = math.floor(w * 0.35 / 2) * 2
			local rect = sightexports.sGui:createGuiElement("rectangle", 0, 0, bsx, topSize + w + 8, topRect)
			sightexports.sGui:setGuiBackground(rect, "solid", {
				0,
				0,
				0,
				50
			})
			topExpandedElements[1] = rect
			soundIcons = {}
			vibrationIcons = {}
			locationIcons = {}
			voiceIcons = {}
			topExpandedElements[2] = {}
			local x = 8
			local icon = sightexports.sGui:createGuiElement("image", x, topSize + 4, w, w, topRect)
			sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("circle", w, "solid"))
			sightexports.sGui:setImageColor(icon, soundState and blue or "#ffffff")
			sightexports.sGui:setGuiHoverable(icon, true)
			sightexports.sGui:setClickEvent(icon, "toggleSoundState")
			table.insert(topExpandedElements[2], {
				icon,
				topSize + 4,
				w
			})
			table.insert(soundIcons, icon)
			local icon = sightexports.sGui:createGuiElement("image", x + w / 2 - w2 / 2, topSize + 4 + w / 2 - w2 / 2, w2, w2, topRect)
			sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("volume-up", w2, "solid"))
			sightexports.sGui:setImageColor(icon, soundState and "#ffffff" or "#444444")
			table.insert(topExpandedElements[2], {
				icon,
				topSize + 4 + w / 2 - w2 / 2,
				w2
			})
			table.insert(soundIcons, icon)
			x = x + w
			local icon = sightexports.sGui:createGuiElement("image", x, topSize + 4, w, w, topRect)
			sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("circle", w, "solid"))
			sightexports.sGui:setImageColor(icon, vibrationState and blue or "#ffffff")
			sightexports.sGui:setGuiHoverable(icon, true)
			sightexports.sGui:setClickEvent(icon, "toggleVibrationState")
			table.insert(topExpandedElements[2], {
				icon,
				topSize + 4,
				w
			})
			table.insert(vibrationIcons, icon)
			local icon = sightexports.sGui:createGuiElement("image", x + w / 2 - w2 / 2, topSize + 4 + w / 2 - w2 / 2, w2, w2, topRect)
			sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("mobile-alt", w2, "solid"))
			sightexports.sGui:setImageColor(icon, vibrationState and "#ffffff" or "#444444")
			table.insert(topExpandedElements[2], {
				icon,
				topSize + 4 + w / 2 - w2 / 2,
				w2
			})
			table.insert(vibrationIcons, icon)
			local icon = sightexports.sGui:createGuiElement("image", x + w / 2 - w3 / 2 - w3 * 0.7, topSize + 4 + w / 2 - w3 / 2, w3, w3, topRect)
			sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("angle-double-left", w3, "solid"))
			sightexports.sGui:setImageColor(icon, vibrationState and "#ffffff" or "#444444")
			table.insert(topExpandedElements[2], {
				icon,
				topSize + 4 + w / 2 - w3 / 2,
				w3
			})
			table.insert(vibrationIcons, icon)
			local icon = sightexports.sGui:createGuiElement("image", x + w / 2 - w3 / 2 + w3 * 0.7, topSize + 4 + w / 2 - w3 / 2, w3, w3, topRect)
			sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("angle-double-right", w3, "solid"))
			sightexports.sGui:setImageColor(icon, vibrationState and "#ffffff" or "#444444")
			table.insert(topExpandedElements[2], {
				icon,
				topSize + 4 + w / 2 - w3 / 2,
				w3
			})
			table.insert(vibrationIcons, icon)
			x = x + w
			local icon = sightexports.sGui:createGuiElement("image", x, topSize + 4, w, w, topRect)
			sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("circle", w, "solid"))
			sightexports.sGui:setImageColor(icon, locationState and blue or "#ffffff")
			sightexports.sGui:setGuiHoverable(icon, true)
			sightexports.sGui:setClickEvent(icon, "toggleLocationState")
			table.insert(topExpandedElements[2], {
				icon,
				topSize + 4,
				w
			})
			table.insert(locationIcons, icon)
			local icon = sightexports.sGui:createGuiElement("image", x + w / 2 - w2 / 2, topSize + 4 + w / 2 - w2 / 2, w2, w2, topRect)
			sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("map-marker-alt", w2, "solid"))
			sightexports.sGui:setImageColor(icon, locationState and "#ffffff" or "#444444")
			table.insert(topExpandedElements[2], {
				icon,
				topSize + 4 + w / 2 - w2 / 2,
				w2
			})
			table.insert(locationIcons, icon)
			x = x + w
			local icon = sightexports.sGui:createGuiElement("image", x, topSize + 4, w, w, topRect)
			sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("circle", w, "solid"))
			sightexports.sGui:setImageColor(icon, voiceState and blue or "#ffffff")
			sightexports.sGui:setGuiHoverable(icon, true)
			sightexports.sGui:setClickEvent(icon, "toggleVoiceState")
			table.insert(topExpandedElements[2], {
				icon,
				topSize + 4,
				w
			})
			table.insert(voiceIcons, icon)
			local icon = sightexports.sGui:createGuiElement("image", x + w / 2 - w2 / 2, topSize + 4 + w / 2 - w2 / 2, w2, w2, topRect)
			sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("microphone", w2, "solid"))
			sightexports.sGui:setImageColor(icon, voiceState and "#ffffff" or "#444444")
			table.insert(topExpandedElements[2], {
				icon,
				topSize + 4 + w / 2 - w2 / 2,
				w2
			})
			table.insert(voiceIcons, icon)
			local rect = sightexports.sGui:createGuiElement("rectangle", 0, eh - topSize, bsx, topSize, topRect)
			sightexports.sGui:setGuiBackground(rect, "solid", {
				220,
				220,
				220,
				255
			})
			sightexports.sGui:setGuiHover(rect, "none", {
				220,
				220,
				220,
				255
			}, false, true)
			sightexports.sGui:setGuiHoverable(rect, false)
			sightexports.sGui:disableClickTrough(rect, true)
			sightexports.sGui:setClickEvent(rect, "closeExpandedTop")
			topExpandedElements[5] = rect
			if topExpanded + 1000 > getTickCount() then
				sightexports.sGui:fadeIn(rect, 500)
			end
			local h = sightexports.sGui:getFontHeight("11/Ubuntu-R.ttf")
			local label = sightexports.sGui:createGuiElement("label", 8, eh - topSize / 2 - h / 2, bsx - 16, topSize, topRect)
			sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
			sightexports.sGui:setLabelClip(label, true)
			sightexports.sGui:setLabelAlignment(label, "left", "bottom")
			sightexports.sGui:setLabelColor(label, "#333333")
			if notiCount == 0 then
				sightexports.sGui:setLabelText(label, "Nincs értesítés!")
				sightexports.sGui:setLabelAlignment(label, "center", "bottom")
			else
				sightexports.sGui:setLabelText(label, notiCount .. " értesítés")
			end
			topExpandedElements[6] = label
			if topExpanded + 1000 > getTickCount() then
				sightexports.sGui:fadeIn(label, 500)
			end
			local border = sightexports.sGui:createGuiElement("rectangle", 0, eh - 1, bsx, 1, topRect)
			sightexports.sGui:setGuiBackground(border, "solid", grey2)
			topExpandedElements[7] = border
			if topExpanded + 1000 > getTickCount() then
				sightexports.sGui:fadeIn(border, 500)
			end
			topExpandedElements[8] = {}
			local y = topSize + w + 8 + 4
			for i = #notifications, 1, -1 do
				if notifications[i] and not notifications[i][5] then
					local holder, els = createExpandedNoti({
						notifications[i][3],
						notifications[i][2],
						notifications[i][1],
						notifications[i][4]
					}, y + 16)
					table.insert(topExpandedElements[8], {
						holder,
						els,
						y + 16
					})
					if #topExpandedElements[8] >= 5 then
						break
					end
					y = y + 48 + 4 + 16
				end
			end
			renderMobile()
		end
	end
end
function createExpandedNoti(data, y)
	local els = {}
	local current = getRealTime()
	local time = getRealTime(data[1])
	local date = ""
	if current.year == time.year and current.month == time.month and current.monthday == time.monthday then
		date = string.format("%02d:%02d", time.hour, time.minute)
	else
		date = string.format("%04d. %02d. %02d. %02d:%02d", time.year + 1900, time.month + 1, time.monthday, time.hour, time.minute)
	end
	els[2] = {}
	els[3] = {}
	local holder = sightexports.sGui:createGuiElement("rectangle", 8, y, bsx - 16, 48, topRect)
	sightexports.sGui:setGuiBackground(holder, "solid", grey1)
	sightexports.sGui:setGuiHover(holder, "none", grey1, false, true)
	sightexports.sGui:setGuiHoverable(holder, false)
	sightexports.sGui:disableClickTrough(holder, true)
	local rect = sightexports.sGui:createGuiElement("rectangle", 1, 1, bsx - 16 - 2, 46, holder)
	sightexports.sGui:setGuiBackground(rect, "solid", {
		255,
		255,
		255,
		255
	})
	els[1] = rect
	local label = sightexports.sGui:createGuiElement("label", 0, -16, bsx - 16 - 2, 14, rect)
	sightexports.sGui:setLabelFont(label, "9/Ubuntu-R.ttf")
	sightexports.sGui:setLabelClip(label, true)
	sightexports.sGui:setLabelAlignment(label, "center", "bottom")
	sightexports.sGui:setLabelColor(label, "#444444")
	sightexports.sGui:setLabelText(label, date)
	table.insert(els[2], {
		label,
		-16,
		14
	})
	local contact = phoneContacts[contactsReversed[data[2]]] or hiddenContacts[data[2]]
	local x = 4
	local y = 4
	local sx = 38
	if contact then
		local col = contact[2]
		if contact[1] ~= "dds" then
			local rect = sightexports.sGui:createGuiElement("rectangle", x, y, sx, sx, rect)
			sightexports.sGui:setGuiBackground(rect, "solid", {
				contactColors[col][1],
				contactColors[col][2],
				contactColors[col][3]
			})
			table.insert(els[2], {
				rect,
				y,
				sx
			})
		end
		if contact[1] == "dds" then
			local img = sightexports.sGui:createGuiElement("image", x, y, sx, sx, rect)
			sightexports.sGui:setImageDDS(img, ":sMobile/!mobile_sight/contacts/" .. contact[6] .. ".dds", "dxt1", false)
			table.insert(els[3], {
				img,
				y,
				sx,
				168
			})
		elseif type(contact[1]) == "string" then
			local h = sightexports.sGui:getFontHeight("14/Ubuntu-R.ttf")
			local label = sightexports.sGui:createGuiElement("label", x, y + sx / 2 - h / 2, sx, h, rect)
			sightexports.sGui:setLabelFont(label, "14/Ubuntu-R.ttf")
			sightexports.sGui:setLabelClip(label, true)
			sightexports.sGui:setLabelAlignment(label, "center", "bottom")
			sightexports.sGui:setLabelColor(label, "#ffffff")
			sightexports.sGui:setLabelText(label, contact[1])
			table.insert(els[2], {
				label,
				y + sx / 2 - h / 2,
				h
			})
		elseif type(contact[1]) == "table" then
			local is = math.floor(sx * 0.6)
			local icon = sightexports.sGui:createGuiElement("image", x + sx / 2 - is / 2, y + sx / 2 - is / 2, is, is, rect)
			sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename(contact[1][1], is, contact[1][2]))
			sightexports.sGui:setImageColor(icon, "#ffffff")
			table.insert(els[3], {
				img,
				y + sx / 2 - is / 2,
				is,
				is
			})
		else
			local h = sightexports.sGui:getFontHeight("14/Ubuntu-R.ttf")
			local label = sightexports.sGui:createGuiElement("label", x, y + sx / 2 - h / 2, sx, h, rect)
			sightexports.sGui:setLabelFont(label, "14/Ubuntu-R.ttf")
			sightexports.sGui:setLabelClip(label, true)
			sightexports.sGui:setLabelAlignment(label, "center", "bottom")
			sightexports.sGui:setLabelColor(label, "#ffffff")
			sightexports.sGui:setLabelText(label, "?")
			table.insert(els[2], {
				label,
				y + sx / 2 - h / 2,
				h
			})
		end
	else
		local r2 = sightexports.sGui:createGuiElement("rectangle", x, y, sx, sx, rect)
		sightexports.sGui:setGuiBackground(r2, "solid", {
			contactColors[1][1],
			contactColors[1][2],
			contactColors[1][3]
		})
		table.insert(els[2], {
			r2,
			y,
			sx
		})
		local h = sightexports.sGui:getFontHeight("14/Ubuntu-R.ttf")
		local label = sightexports.sGui:createGuiElement("label", x, y + sx / 2 - h / 2, sx, h, rect)
		sightexports.sGui:setLabelFont(label, "14/Ubuntu-R.ttf")
		sightexports.sGui:setLabelClip(label, true)
		sightexports.sGui:setLabelAlignment(label, "center", "bottom")
		sightexports.sGui:setLabelColor(label, "#ffffff")
		sightexports.sGui:setLabelText(label, "?")
		table.insert(els[2], {
			label,
			y + sx / 2 - h / 2,
			h
		})
	end
	local img = sightexports.sGui:createGuiElement("image", x - 1, y - 1, sx + 2, sx + 2, rect)
	sightexports.sGui:setImageFile(img, loadedTextures["files/img/avcut_sm.png"])
	sightexports.sGui:setImageColor(img, "#ffffff")
	table.insert(els[3], {
		img,
		y - 1,
		sx + 2,
		64
	})
	if data[3] == "call" then
		local h = sightexports.sGui:getFontHeight("10/Ubuntu-R.ttf")
		local ly = y + 2 + (sx - 4) / 2 * 0.5 - h / 2
		local label = sightexports.sGui:createGuiElement("label", x + sx + 4, ly, bsx - 16 - 2 - (x + sx + 4) - 4, h, rect)
		sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
		sightexports.sGui:setLabelAlignment(label, "left", "bottom")
		sightexports.sGui:setLabelColor(label, "#000000")
		sightexports.sGui:setLabelClip(label, true)
		sightexports.sGui:setLabelText(label, "Nem fogadott hívás")
		table.insert(els[2], {
			label,
			ly,
			h
		})
		local ih = math.ceil((sx - 4) / 2)
		local iy = y + 2 + (sx - 4) / 2 * 1.5 - ih / 2
		local icon = sightexports.sGui:createGuiElement("image", x + sx + 4, iy, ih, ih, rect)
		sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("phone", ih))
		sightexports.sGui:setImageColor(icon, red)
		table.insert(els[3], {
			icon,
			iy,
			ih,
			ih
		})
		local h = sightexports.sGui:getFontHeight("10/Ubuntu-L.ttf")
		local ly = y + 2 + (sx - 4) / 2 * 1.5 - h / 2
		local label = sightexports.sGui:createGuiElement("label", x + sx + 4 + ih + 2, ly, bsx - 16 - 2 - (x + sx + 4 + ih + 2) - 4, h, rect)
		sightexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
		sightexports.sGui:setLabelAlignment(label, "left", "bottom")
		sightexports.sGui:setLabelColor(label, "#000000")
		sightexports.sGui:setLabelClip(label, true)
		sightexports.sGui:setLabelText(label, contact and contact[3] or formatPhoneNumber(data[2]))
		table.insert(els[2], {
			label,
			ly,
			h
		})
		sightexports.sGui:setClickEvent(holder, "openPhoneApp")
	elseif data[3] == "sms" then
		local h = sightexports.sGui:getFontHeight("10/Ubuntu-R.ttf")
		local ly = y + 2 + (sx - 4) / 2 * 0.5 - h / 2
		local label = sightexports.sGui:createGuiElement("label", x + sx + 4, ly, bsx - 16 - 2 - (x + sx + 4) - 4, h, rect)
		sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
		sightexports.sGui:setLabelAlignment(label, "left", "bottom")
		sightexports.sGui:setLabelColor(label, "#000000")
		sightexports.sGui:setLabelClip(label, true)
		sightexports.sGui:setLabelText(label, contact and contact[3] or formatPhoneNumber(data[2]))
		table.insert(els[2], {
			label,
			ly,
			h
		})
		local ih = math.ceil((sx - 4) / 2)
		local iy = y + 2 + (sx - 4) / 2 * 1.5 - ih / 2
		local icon = sightexports.sGui:createGuiElement("image", x + sx + 4, iy, ih, ih, rect)
		sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("envelope", ih))
		sightexports.sGui:setImageColor(icon, "#222222")
		table.insert(els[3], {
			icon,
			iy,
			ih,
			ih
		})
		local h = sightexports.sGui:getFontHeight("10/Ubuntu-L.ttf")
		local ly = y + 2 + (sx - 4) / 2 * 1.5 - h / 2
		local label = sightexports.sGui:createGuiElement("label", x + sx + 4 + ih + 2, ly, bsx - 16 - 2 - (x + sx + 4 + ih + 2) - 4, h, rect)
		sightexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
		sightexports.sGui:setLabelAlignment(label, "left", "bottom")
		sightexports.sGui:setLabelColor(label, "#000000")
		sightexports.sGui:setLabelClip(label, true)
		sightexports.sGui:setLabelText(label, data[4])
		table.insert(els[2], {
			label,
			ly,
			h
		})
		sightexports.sGui:setClickEvent(holder, "openSMSFromTop")
	end
	return holder, els
end
function createTopNoti(data)
	if not topExpanded then
		topNoti = data
		if currentPhoneScreen ~= "photo_landscape" and currentPhoneScreen ~= "camera_landscape" and currentPhoneScreen ~= "photo_portrait" and currentPhoneScreen ~= "camera" then
			createTop()
		end
	end
end
function createTop(forceExpand)
	if mobileState then
		deleteTop()
		local rt = getRealTime()
		time = string.format("%02d:%02d", rt.hour, rt.minute)
		topRect = sightexports.sGui:createGuiElement("rectangle", 0, 0, bsx, topSize, mobileBackground)
		sightexports.sGui:setGuiBackground(topRect, "solid", {
			0,
			0,
			0,
			125
		})
		sightexports.sGui:setGuiHover(topRect, "none", false, false, true)
		sightexports.sGui:setGuiHoverable(topRect, true)
		sightexports.sGui:disableClickTrough(topRect, true)
		sightexports.sGui:setClickEvent(topRect, "expandTop")
		local tiX = 1
		if not voiceState then
			local icon = sightexports.sGui:createGuiElement("image", bsx - topSize * (2.25 + 1.1 * tiX), 0, topSize, topSize, topRect)
			sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("microphone-slash", topSize))
			table.insert(topIcons, icon)
			tiX = tiX + 1
		end
		if not locationState then
			local icon = sightexports.sGui:createGuiElement("image", bsx - topSize * (2.25 + 1.1 * tiX), 0, topSize, topSize, topRect)
			sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("map-marker-slash", topSize))
			table.insert(topIcons, icon)
		end
		topLabel = sightexports.sGui:createGuiElement("label", topSize / 2, 0, bsx - topSize, topSize, topRect)
		sightexports.sGui:setLabelAlignment(topLabel, "left", "center")
		sightexports.sGui:setLabelText(topLabel, "SightCom")
		sightexports.sGui:setLabelFont(topLabel, "10/Ubuntu-L.ttf")
		local tiX = topSize / 2 + 2 + sightexports.sGui:getLabelTextWidth(topLabel)
		if not soundState and not vibrationState then
			local icon = sightexports.sGui:createGuiElement("image", tiX, 0, topSize, topSize, topRect)
			sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("volume-mute", topSize))
			table.insert(topIcons, icon)
			tiX = tiX + topSize
		elseif not soundState and vibrationState then
			local icon = sightexports.sGui:createGuiElement("image", tiX, 0, topSize, topSize, topRect)
			sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("mobile-alt", topSize, "solid"))
			table.insert(topIcons, icon)
			local icon = sightexports.sGui:createGuiElement("image", tiX + topSize / 2 - topSize * 0.35 - topSize * 0.5 / 2, topSize / 2 - topSize * 0.5 / 2, topSize * 0.5, topSize * 0.5, topRect)
			sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("angle-double-left", topSize * 0.5, "solid"))
			table.insert(topIcons, icon)
			local icon = sightexports.sGui:createGuiElement("image", tiX + topSize / 2 + topSize * 0.35 - topSize * 0.5 / 2, topSize / 2 - topSize * 0.5 / 2, topSize * 0.5, topSize * 0.5, topRect)
			sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("angle-double-right", topSize * 0.5, "solid"))
			table.insert(topIcons, icon)
			tiX = tiX + topSize
		end
		if 0 < #notifications then
			local icon = sightexports.sGui:createGuiElement("image", tiX, 0, topSize, topSize, topRect)
			sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("envelope", topSize))
			table.insert(topIcons, icon)
		end
		topLabel2 = sightexports.sGui:createGuiElement("label", bsx - topSize * 2.25, 0, topSize * 1.75, topSize, topRect)
		sightexports.sGui:setLabelAlignment(topLabel2, "center", "center")
		sightexports.sGui:setLabelText(topLabel2, time)
		sightexports.sGui:setLabelFont(topLabel2, "10/Ubuntu-L.ttf")
		if topExpanded then
			expandTop(forceExpand, true)
		else
			if callStatus and not inCallScreens[currentPhoneScreen] then
				local topBar = sightexports.sGui:createGuiElement("rectangle", 8, topSize + 4, bsx - 16, 48, topRect)
				sightexports.sGui:setGuiBackground(topBar, "solid", grey1)
				sightexports.sGui:setGuiHover(topBar, "none", grey1, false, true)
				sightexports.sGui:setGuiHoverable(topBar, true)
				sightexports.sGui:disableClickTrough(topBar, true)
				sightexports.sGui:setClickEvent(topBar, "openDialer")
				local rect = sightexports.sGui:createGuiElement("rectangle", 1, 1, bsx - 16 - 2, 46, topBar)
				sightexports.sGui:setGuiBackground(rect, "solid", {
					255,
					255,
					255,
					255
				})
				local contact = phoneContacts[contactsReversed[callStatus[1]]] or hiddenContacts[callStatus[1]]
				local x = 4
				local y = 4
				local sx = 38
				if contact then
					local col = contact[2]
					if contact[1] ~= "dds" then
						local rect = sightexports.sGui:createGuiElement("rectangle", x, y, sx, sx, rect)
						sightexports.sGui:setGuiBackground(rect, "solid", {
							contactColors[col][1],
							contactColors[col][2],
							contactColors[col][3]
						})
					end
					if contact[1] == "dds" then
						local img = sightexports.sGui:createGuiElement("image", x, y, sx, sx, rect)
						sightexports.sGui:setImageDDS(img, ":sMobile/!mobile_sight/contacts/" .. contact[6] .. ".dds", "dxt1", false)
					elseif type(contact[1]) == "string" then
						local h = sightexports.sGui:getFontHeight("14/Ubuntu-R.ttf")
						local label = sightexports.sGui:createGuiElement("label", x, y + sx / 2 - h / 2, sx, h, rect)
						sightexports.sGui:setLabelFont(label, "14/Ubuntu-R.ttf")
						sightexports.sGui:setLabelClip(label, true)
						sightexports.sGui:setLabelAlignment(label, "center", "bottom")
						sightexports.sGui:setLabelColor(label, "#ffffff")
						sightexports.sGui:setLabelText(label, contact[1])
					elseif type(contact[1]) == "table" then
						local is = math.floor(sx * 0.6)
						local icon = sightexports.sGui:createGuiElement("image", x + sx / 2 - is / 2, y + sx / 2 - is / 2, is, is, rect)
						sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename(contact[1][1], is, contact[1][2]))
						sightexports.sGui:setImageColor(icon, "#ffffff")
					else
						local h = sightexports.sGui:getFontHeight("14/Ubuntu-R.ttf")
						local label = sightexports.sGui:createGuiElement("label", x, y + sx / 2 - h / 2, sx, h, rect)
						sightexports.sGui:setLabelFont(label, "14/Ubuntu-R.ttf")
						sightexports.sGui:setLabelClip(label, true)
						sightexports.sGui:setLabelAlignment(label, "center", "bottom")
						sightexports.sGui:setLabelColor(label, "#ffffff")
						sightexports.sGui:setLabelText(label, "?")
					end
				else
					local r2 = sightexports.sGui:createGuiElement("rectangle", x, y, sx, sx, rect)
					sightexports.sGui:setGuiBackground(r2, "solid", {
						contactColors[1][1],
						contactColors[1][2],
						contactColors[1][3]
					})
					local h = sightexports.sGui:getFontHeight("14/Ubuntu-R.ttf")
					local label = sightexports.sGui:createGuiElement("label", x, y + sx / 2 - h / 2, sx, h, rect)
					sightexports.sGui:setLabelFont(label, "14/Ubuntu-R.ttf")
					sightexports.sGui:setLabelClip(label, true)
					sightexports.sGui:setLabelAlignment(label, "center", "bottom")
					sightexports.sGui:setLabelColor(label, "#ffffff")
					sightexports.sGui:setLabelText(label, "?")
				end
				local img = sightexports.sGui:createGuiElement("image", x - 1, y - 1, sx + 2, sx + 2, rect)
				sightexports.sGui:setImageFile(img, loadedTextures["files/img/avcut_sm.png"])
				sightexports.sGui:setImageColor(img, "#ffffff")
				local h = sightexports.sGui:getFontHeight("10/Ubuntu-R.ttf")
				local ly = y + 2 + (sx - 4) / 2 * 1.5 - h / 2
				local label = sightexports.sGui:createGuiElement("label", x + sx + 4, ly, bsx - 16 - 2 - (x + sx + 4) - 4, h, rect)
				sightexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
				sightexports.sGui:setLabelAlignment(label, "left", "bottom")
				sightexports.sGui:setLabelColor(label, "#000000")
				sightexports.sGui:setLabelClip(label, true)
				sightexports.sGui:setLabelText(label, contact and contact[3] or formatPhoneNumber(callStatus[1]))
				local ih = math.ceil((sx - 4) / 2)
				local iy = y + 2 + 1
				local icon = sightexports.sGui:createGuiElement("image", x + sx + 4, iy, ih, ih, rect)
				sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("phone", ih))
				sightexports.sGui:setImageColor(icon, "#222222")
				local h = sightexports.sGui:getFontHeight("10/Ubuntu-L.ttf")
				local ly = y + 2 + (sx - 4) / 2 * 0.5 - h / 2
				local label = sightexports.sGui:createGuiElement("label", x + sx + 4 + ih + 2, ly, bsx - 16 - 2 - (x + sx + 4 + ih + 2) - 4, h, rect)
				sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
				sightexports.sGui:setLabelAlignment(label, "left", "bottom")
				sightexports.sGui:setLabelColor(label, "#000000")
				sightexports.sGui:setLabelClip(label, true)
				sightexports.sGui:setLabelText(label, "Hívás")
			elseif topNoti then
				topNoti[1] = sightexports.sGui:createGuiElement("rectangle", 8, -52.800000000000004, bsx - 16, 48, topRect)
				sightexports.sGui:setGuiBackground(topNoti[1], "solid", grey1)
				sightexports.sGui:setGuiHover(topNoti[1], "none", grey1, false, true)
				sightexports.sGui:setGuiHoverable(topNoti[1], false)
				sightexports.sGui:disableClickTrough(topNoti[1], true)
				local rect = sightexports.sGui:createGuiElement("rectangle", 1, 1, bsx - 16 - 2, 46, topNoti[1])
				sightexports.sGui:setGuiBackground(rect, "solid", {
					255,
					255,
					255,
					255
				})
				topNoti[6][1] = rect
				local contact = phoneContacts[contactsReversed[topNoti[2]]] or hiddenContacts[topNoti[2]]
				local x = 4
				local y = 4
				local sx = 38
				topNoti[6][2] = {}
				topNoti[6][3] = {}
				if contact then
					local col = contact[2]
					if contact[1] ~= "dds" then
						local rect = sightexports.sGui:createGuiElement("rectangle", x, y, sx, sx, rect)
						sightexports.sGui:setGuiBackground(rect, "solid", {
							contactColors[col][1],
							contactColors[col][2],
							contactColors[col][3]
						})
						table.insert(topNoti[6][2], {
							rect,
							y,
							sx
						})
					end
					if contact[1] == "dds" then
						local img = sightexports.sGui:createGuiElement("image", x, y, sx, sx, rect)
						sightexports.sGui:setImageDDS(img, ":sMobile/!mobile_sight/contacts/" .. contact[6] .. ".dds", "dxt1", false)
						table.insert(topNoti[6][3], {
							img,
							y,
							sx,
							168
						})
					elseif type(contact[1]) == "string" then
						local h = sightexports.sGui:getFontHeight("14/Ubuntu-R.ttf")
						local label = sightexports.sGui:createGuiElement("label", x, y + sx / 2 - h / 2, sx, h, rect)
						sightexports.sGui:setLabelFont(label, "14/Ubuntu-R.ttf")
						sightexports.sGui:setLabelClip(label, true)
						sightexports.sGui:setLabelAlignment(label, "center", "bottom")
						sightexports.sGui:setLabelColor(label, "#ffffff")
						sightexports.sGui:setLabelText(label, contact[1])
						table.insert(topNoti[6][2], {
							label,
							y + sx / 2 - h / 2,
							h
						})
					elseif type(contact[1]) == "table" then
						local is = math.floor(sx * 0.6)
						local icon = sightexports.sGui:createGuiElement("image", x + sx / 2 - is / 2, y + sx / 2 - is / 2, is, is, rect)
						sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename(contact[1][1], is, contact[1][2]))
						sightexports.sGui:setImageColor(icon, "#ffffff")
						table.insert(topNoti[6][3], {
							img,
							y + sx / 2 - is / 2,
							is,
							is
						})
					else
						local h = sightexports.sGui:getFontHeight("14/Ubuntu-R.ttf")
						local label = sightexports.sGui:createGuiElement("label", x, y + sx / 2 - h / 2, sx, h, rect)
						sightexports.sGui:setLabelFont(label, "14/Ubuntu-R.ttf")
						sightexports.sGui:setLabelClip(label, true)
						sightexports.sGui:setLabelAlignment(label, "center", "bottom")
						sightexports.sGui:setLabelColor(label, "#ffffff")
						sightexports.sGui:setLabelText(label, "?")
						table.insert(topNoti[6][2], {
							label,
							y + sx / 2 - h / 2,
							h
						})
					end
				else
					local r2 = sightexports.sGui:createGuiElement("rectangle", x, y, sx, sx, rect)
					sightexports.sGui:setGuiBackground(r2, "solid", {
						contactColors[1][1],
						contactColors[1][2],
						contactColors[1][3]
					})
					table.insert(topNoti[6][2], {
						r2,
						y,
						sx
					})
					local h = sightexports.sGui:getFontHeight("14/Ubuntu-R.ttf")
					local label = sightexports.sGui:createGuiElement("label", x, y + sx / 2 - h / 2, sx, h, rect)
					sightexports.sGui:setLabelFont(label, "14/Ubuntu-R.ttf")
					sightexports.sGui:setLabelClip(label, true)
					sightexports.sGui:setLabelAlignment(label, "center", "bottom")
					sightexports.sGui:setLabelColor(label, "#ffffff")
					sightexports.sGui:setLabelText(label, "?")
					table.insert(topNoti[6][2], {
						label,
						y + sx / 2 - h / 2,
						h
					})
				end
				local img = sightexports.sGui:createGuiElement("image", x - 1, y - 1, sx + 2, sx + 2, rect)
				sightexports.sGui:setImageFile(img, loadedTextures["files/img/avcut_sm.png"])
				sightexports.sGui:setImageColor(img, "#ffffff")
				table.insert(topNoti[6][3], {
					img,
					y - 1,
					sx + 2,
					64
				})
				if topNoti[3] == "sms" then
					local h = sightexports.sGui:getFontHeight("10/Ubuntu-R.ttf")
					local ly = y + 2 + (sx - 4) / 2 * 0.5 - h / 2
					local label = sightexports.sGui:createGuiElement("label", x + sx + 4, ly, bsx - 16 - 2 - (x + sx + 4) - 4, h, rect)
					sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
					sightexports.sGui:setLabelAlignment(label, "left", "bottom")
					sightexports.sGui:setLabelColor(label, "#000000")
					sightexports.sGui:setLabelClip(label, true)
					sightexports.sGui:setLabelText(label, contact and contact[3] or formatPhoneNumber(topNoti[2]))
					table.insert(topNoti[6][2], {
						label,
						ly,
						h
					})
					local ih = math.ceil((sx - 4) / 2)
					local iy = y + 2 + (sx - 4) / 2 * 1.5 - ih / 2
					local icon = sightexports.sGui:createGuiElement("image", x + sx + 4, iy, ih, ih, rect)
					sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("envelope", ih))
					sightexports.sGui:setImageColor(icon, "#222222")
					table.insert(topNoti[6][3], {
						icon,
						iy,
						ih,
						ih
					})
					local h = sightexports.sGui:getFontHeight("10/Ubuntu-L.ttf")
					local ly = y + 2 + (sx - 4) / 2 * 1.5 - h / 2
					local label = sightexports.sGui:createGuiElement("label", x + sx + 4 + ih + 2, ly, bsx - 16 - 2 - (x + sx + 4 + ih + 2) - 4, h, rect)
					sightexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
					sightexports.sGui:setLabelAlignment(label, "left", "bottom")
					sightexports.sGui:setLabelColor(label, "#000000")
					sightexports.sGui:setLabelClip(label, true)
					sightexports.sGui:setLabelText(label, topNoti[4])
					table.insert(topNoti[6][2], {
						label,
						ly,
						h
					})
					sightexports.sGui:setClickEvent(topNoti[1], "openSMSForTopNoti")
				end
				renderMobile()
			end
			bringBackFront()
		end
	end
end
local imageSizeX, imageSizeY = 1920, 1080
local cameraClick = false
local cameraShutter = false
local cameraScreenSource = false
local cameraPreview = false
photoListData = {}
photoListForCategory = {
	all = {},
	camera = {},
	screenshot = {},
	downloads = {}
}
photoCategoryNames = {
	{
		"all",
		"Összes kép"
	},
	{"camera", "Kamera"},
	{
		"screenshot",
		"Képernyőfotó"
	},
	{"downloads", "Letöltés"}
}
addEventHandler("onClientResourceStart", getResourceRootElement(), function()
	if getElementData(localPlayer, "loggedIn") then
		triggerServerEvent("requestPremiumData", localPlayer)
	end
	for i = 1, #texturesToLoad do
		if origFE(texturesToLoad[i][1]) then
			local image = origFO(texturesToLoad[i][1], true)
			if image then
				local data = fileRead(image, fileGetSize(image))
				fileClose(image)
				local checksum = sha256(data)
				loadedTextures[texturesToLoad[i][1]] = dxCreateTexture(data, "dxt5")
			end
		end
	end
	if fileExists("notifications.sight") then
		local file = fileOpen("notifications.sight", true)
		if file then
			local data = fileRead(file, fileGetSize(file))
			fileClose(file)
			data = split(data, "\n")
			for i = 1, #data do
				local dat = split(data[i], "#")
				if 4 <= #dat then
					local theType = dat[1]
					local num = tonumber(dat[2])
					if theType and num then
						local text = {
							dat[4]
						}
						for j = 5, #dat do
							if dat[j] then
								table.insert(text, dat[j])
							end
						end
						table.insert(notifications, {
							theType,
							num,
							tonumber(dat[3]) or 0,
							table.concat(text, "#")
						})
						if theType == "sms" then
							unreadSMSFromNumber[num] = true
						end
					end
				end
			end
		end
	end
	if fileExists("contacts.sight") then
		local contacts = fileOpen("contacts.sight", true)
		if contacts then
			local data = fileRead(contacts, fileGetSize(contacts))
			fileClose(contacts)
			data = split(data, "\n")
			for i = 1, #data do
				if data[i] then
					local dat = split(data[i], "#")
					local id = tonumber(dat[1])
					local num = tonumber(dat[2])
					local color = tonumber(dat[3])
					local contactName = dat[4]
					for i = 5, #dat do
						if dat[i] then
							contactName = contactName .. "#" .. dat[i]
						end
					end
					if contactName and id and num and color and contactColors[color] then
						table.insert(phoneContacts, {
							utf8.upper(utf8.sub(contactName, 1, 1)),
							color,
							contactName,
							num,
							false,
							id
						})
					end
				end
			end
		end
	end
	processContacts()
	for i = 1, #phoneContacts do
		if phoneContacts[i] and fileExists("contacts/" .. phoneContacts[i][6] .. ".dds") then
			phoneContacts[i][5] = phoneContacts[i][1] or utf8.upper(utf8.sub(phoneContacts[i][3], 1, 1))
			phoneContacts[i][1] = "dds"
		end
	end
	if fileExists("bcg.sight") then
		local bcg = fileOpen("bcg.sight", true)
		if bcg then
			local data = fileRead(bcg, fileGetSize(bcg))
			local checksum = teaDecode(data, "bcg")
			fileClose(bcg)
			local image = fileOpen("bcg.dds", true)
			if image then
				local data = fileRead(image, fileGetSize(image))
				fileClose(image)
				if checksum == sha256(data) then
					customBackground = true
				end
			end
		end
	end
	currentBackground = 0
	if fileExists("curr_bcg.sight") then
		local bcg = fileOpen("curr_bcg.sight", true)
		if bcg then
			local data = fileRead(bcg, fileGetSize(bcg))
			fileClose(bcg)
			data = tonumber(data)
			if data and (data == -1 or loadedTextures["files/bcg/" .. data .. ".png"]) then
				currentBackground = data or 1
			end
		end
	end
	clickSoundState = true
	if fileExists("clicksound.sight") then
		local bcg = fileOpen("clicksound.sight", true)
		if bcg then
			local data = fileRead(bcg, fileGetSize(bcg))
			fileClose(bcg)
			clickSoundState = tonumber(data) == 1
		end
	end
	widgetShowState = true
	if fileExists("widgetstate.sight") then
		local r0_47 = fileOpen("widgetstate.sight", true)
		if r0_47 then
		local r1_47 = fileRead(r0_47, fileGetSize(r0_47))
		fileClose(r0_47)
		widgetShowState = tonumber(r1_47) == 1
		end
	end
	
	currentForex = true
	if fileExists("widgetindex.sight") then
		local r0_47 = fileOpen("widgetindex.sight", true)
		if r0_47 then
			local r1_47 = fileRead(r0_47, fileGetSize(r0_47))
			fileClose(r0_47)
			currentForex = r1_47
		end
	end
	
	if not customBackground and 0 > currentBackground then
		currentBackground = 0
	end
	if fileExists("photolist.sight") then
		local photoList = fileOpen("photolist.sight", true)
		if photoList then
			local data = fileRead(photoList, fileGetSize(photoList))
			data = split(data, "\n")
			if 0 < #data then
				for i = 1, #data do
					local args = split(data[i], "#")
					if #args == 10 then
						local fileName = args[1]
						if fileExists("photos/" .. fileName .. ".dds") and fileExists("photos/thumbs/" .. fileName .. ".dds") then
							local timestamp = tonumber(args[2])
							local sx = tonumber(args[3])
							local sy = tonumber(args[4])
							local name = args[5]
							local x = tonumber(args[6])
							local y = tonumber(args[7])
							local size = tonumber(args[8])
							local checksum = args[9]
							local category = args[10]
							if timestamp and sx and sy and name and x and y and size and checksum and category and photoListForCategory[category] then
								table.insert(photoListData, {
									fileName,
									timestamp,
									sx,
									sy,
									name,
									x,
									y,
									size,
									checksum,
									category
								})
								table.insert(photoListForCategory.all, #photoListData)
								table.insert(photoListForCategory[category], #photoListData)
							end
						end
					end
				end
			end
			fileClose(photoList)
		end
	end
end)
local galleryIcons = {}
local galleryIconIds = {}
local galleryScroll = 1
local currentGalleryScroll = 0
local galleryScrollBar = false
selectedGalleryCategory = false
local lastGalleryScroll = {}
function galleryScrollKey(key)
	if key == "mouse_wheel_up" then
		if 0 < currentGalleryScroll then
			currentGalleryScroll = currentGalleryScroll - 1
			lastGalleryScroll[selectedGalleryCategory] = currentGalleryScroll
			local j = 1
			local k = #photoListForCategory[selectedGalleryCategory] - currentGalleryScroll * 3
			for y = 0, 5 do
				for x = 0, 2 do
					local i = photoListForCategory[selectedGalleryCategory][k]
					if photoListData[i] then
						galleryIconIds[galleryIcons[j]] = i
						sightexports.sGui:setGuiHoverable(galleryIcons[j], true)
						sightexports.sGui:setImageDDS(galleryIcons[j], ":sMobile/!mobile_sight/photos/thumbs/" .. photoListData[i][1] .. ".dds", "dxt1", false, true)
					else
						galleryIconIds[galleryIcons[j]] = nil
						sightexports.sGui:setGuiHoverable(galleryIcons[j], false)
						sightexports.sGui:setImageFile(galleryIcons[j], false)
					end
					j = j + 1
					k = k - 1
				end
			end
			local prevSize = (bsx - 28) / 3
			local h = (prevSize + 4) * 6 - 4
			sightexports.sGui:setGuiPosition(galleryScrollBar, bsx - 10, topSize + 4 + currentGalleryScroll * (h / galleryScroll))
		end
	elseif key == "mouse_wheel_down" and currentGalleryScroll + 1 < galleryScroll then
		currentGalleryScroll = currentGalleryScroll + 1
		lastGalleryScroll[selectedGalleryCategory] = currentGalleryScroll
		local j = 1
		local k = #photoListForCategory[selectedGalleryCategory] - currentGalleryScroll * 3
		for y = 0, 5 do
			for x = 0, 2 do
				local i = photoListForCategory[selectedGalleryCategory][k]
				if photoListData[i] then
					galleryIconIds[galleryIcons[j]] = i
					sightexports.sGui:setGuiHoverable(galleryIcons[j], true)
					sightexports.sGui:setImageDDS(galleryIcons[j], ":sMobile/!mobile_sight/photos/thumbs/" .. photoListData[i][1] .. ".dds", "dxt1", false, true)
				else
					galleryIconIds[galleryIcons[j]] = nil
					sightexports.sGui:setGuiHoverable(galleryIcons[j], false)
					sightexports.sGui:setImageFile(galleryIcons[j], false)
				end
				j = j + 1
				k = k - 1
			end
		end
		local prevSize = (bsx - 28) / 3
		local h = (prevSize + 4) * 6 - 4
		sightexports.sGui:setGuiPosition(galleryScrollBar, bsx - 10, topSize + 4 + currentGalleryScroll * (h / galleryScroll))
	end
end
photoFromSMS = false
photoDeleting = false
photoInfo = false
currentPhoto = false
addEvent("openPhoto", false)
addEventHandler("openPhoto", getRootElement(), function(button, state, absoluteX, absoluteY, el)
	if el and galleryIconIds[el] then
		currentPhoto = galleryIconIds[el]
	end
	local force = photoDeleting or photoInfo
	photoDeleting = false
	photoInfo = false
	if photoLandscape then
		switchAppScreen("photo_landscape", force)
	else
		switchAppScreen("photo", force)
	end
end)
addEvent("forceBackToPhoto", false)
addEventHandler("forceBackToPhoto", getRootElement(), function()
	if photoLandscape then
		switchAppScreen("photo_landscape", true)
	else
		switchAppScreen("photo", true)
	end
end)
local nextPhoto = false
local prevPhoto = false
addEvent("nextPhoto", false)
addEventHandler("nextPhoto", getRootElement(), function(button, state, absoluteX, absoluteY, el)
	if nextPhoto then
		currentPhoto = nextPhoto
		photoDeleting = false
		photoInfo = false
		if photoLandscape then
			switchAppScreen("photo_landscape", true)
		else
			switchAppScreen("photo", true)
		end
	end
end)
addEvent("prevPhoto", false)
addEventHandler("prevPhoto", getRootElement(), function(button, state, absoluteX, absoluteY, el)
	if prevPhoto then
		currentPhoto = prevPhoto
		photoDeleting = false
		photoInfo = false
		if photoLandscape then
			switchAppScreen("photo_landscape", true)
		else
			switchAppScreen("photo", true)
		end
	end
end)
addEvent("openPhotoForContacts", false)
addEventHandler("openPhotoForContacts", getRootElement(), function(button, state, absoluteX, absoluteY, el)
	if galleryIconIds[el] then
		currentPhoto = galleryIconIds[el]
		if photoListData[currentPhoto] then
			gallerySelecting = false
			openedPhotoForContacts(currentPhoto)
		end
	end
end)
addEvent("openPhotoForAds", false)
addEventHandler("openPhotoForAds", getRootElement(), function(button, state, absoluteX, absoluteY, el)
	if galleryIconIds[el] then
		currentPhoto = galleryIconIds[el]
		if photoListData[currentPhoto] then
			gallerySelecting = false
			openedPhotoForAd(currentPhoto)
		end
	end
end)
addEvent("openGalleryCategory", false)
addEventHandler("openGalleryCategory", getRootElement(), function(button, state, absoluteX, absoluteY, el)
	if galleryIconIds[el] then
		selectedGalleryCategory = galleryIconIds[el]
		switchAppScreen("gallery", true)
	end
end)
addEvent("openPhotoForSettings", false)
addEventHandler("openPhotoForSettings", getRootElement(), function(button, state, absoluteX, absoluteY, el)
	if galleryIconIds[el] then
		currentPhoto = galleryIconIds[el]
		if photoListData[currentPhoto] then
			local file = fileOpen("photos/" .. photoListData[currentPhoto][1] .. ".sight", true)
			if file then
				local checksum = fileRead(file, fileGetSize(file))
				fileClose(file)
				if checksum then
					checksum = teaDecode(checksum, "mk" .. photoListData[currentPhoto][2] .. utf8.sub(photoListData[currentPhoto][1], 1, 10))
					local image = fileOpen("photos/" .. photoListData[currentPhoto][1] .. ".dds", true)
					if image then
						local imageData = fileRead(image, fileGetSize(image))
						fileClose(image)
						if imageData then
							local calculatedSum = sha256(imageData)
							if calculatedSum == checksum then
								local rtx = math.ceil(originalBcgX / 4) * 4
								local rty = math.ceil(originalBcgY / 4) * 4
								local photoRt = dxCreateRenderTarget(rtx, rty)
								local sx, sy = photoListData[currentPhoto][3], photoListData[currentPhoto][4]
								local w = sy / rty * rtx
								dxSetRenderTarget(photoRt)
								local text = dxCreateTexture(imageData, "dxt3", false)
								if isElement(text) then
									dxDrawImageSection(0, 0, rtx, rty, sx / 2 - w / 2, 0, w, sy, text)
									destroyElement(text)
								end
								dxSetRenderTarget()
								if isElement(photoRt) then
									local pixels = dxGetTexturePixels(photoRt, "dds", "dxt3", false)
									destroyElement(photoRt)
									if pixels then
										local checksum = sha256(pixels)
										local convertedFile = fileCreate("bcg.dds")
										if convertedFile then
											fileWrite(convertedFile, pixels)
											fileClose(convertedFile)
											if fileExists("bcg.sight") then
												fileDelete("bcg.sight")
											end
											local dataFile = fileCreate("bcg.sight")
											if dataFile then
												fileWrite(dataFile, teaEncode(checksum, "bcg"))
												fileClose(dataFile)
												customBackground = true
												currentBackground = -1
												local currFile = false
												if fileExists("curr_bcg.sight") then
													currFile = fileOpen("curr_bcg.sight")
												else
													currFile = fileCreate("curr_bcg.sight")
												end
												if currFile then
													local str = ""
													if 0 > currentBackground then
														fileWrite(currFile, "-01")
													else
														str = tostring(currentBackground)
														for i = 1, 3 - utf8.len(str) do
															str = "0" .. str
														end
														fileWrite(currFile, str)
													end
													fileClose(currFile)
												end
												sightexports.sGui:resetImageDDS(":sMobile/!mobile_sight/bcg.dds")
												sightexports.sGui:setImageDDS(mobileBackground, ":sMobile/!mobile_sight/bcg.dds", "dxt3", false)
											end
										end
									end
									pixels = nil
								end
								photoRt = nil
								switchAppScreen("settings")
								gallerySelecting = false
							end
						end
						imageData = nil
					end
				end
			end
		end
	end
	collectgarbage("collect")
end)
function appCloses.photo()
	createTop()
end
function appCloses.photo_landscape()
	createTop()
	sightexports.sGui:setImageRotation(mobileFrame, 0)
	sightexports.sGui:setImageRotation(mobileBackground, 0)
	sightexports.sGui:setImageRotation(mobileScreen, 0)
end
function appScreens.photo()
	deleteTop()
	photoLandscape = false
	appInside = sightexports.sGui:createGuiElement("null", 0, 0, bsx, bsy, mobileBackground)
	local rect = sightexports.sGui:createGuiElement("rectangle", 0, 0, bsx, bsy, appInside)
	sightexports.sGui:setGuiBackground(rect, "solid", {
		0,
		0,
		0
	})
	local icon = sightexports.sGui:createGuiElement("image", bsx - 24 - 16, bsy * 0.1 / 2 - 12, 24, 24, appInside)
	sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("sync", 24))
	if not photoDeleting and not photoInfo then
		sightexports.sGui:setGuiHoverable(icon, true)
		sightexports.sGui:setClickEvent(icon, "flipPhoto")
	end
	local yt = bsy * 0.1 / 2 + 12 + 8
	local yb = bsy - topSize * 1.5 - 24 - 8 - 8
	nextPhoto = false
	prevPhoto = false
	if not photoDeleting and not photoInfo then
		for k = 1, #photoListForCategory[selectedGalleryCategory] do
			if photoListForCategory[selectedGalleryCategory][k] == currentPhoto then
				nextPhoto = photoListForCategory[selectedGalleryCategory][k - 1]
			end
		end
		for k = 1, #photoListForCategory[selectedGalleryCategory] do
			if photoListForCategory[selectedGalleryCategory][k] == currentPhoto then
				prevPhoto = photoListForCategory[selectedGalleryCategory][k + 1]
			end
		end
		if prevPhoto then
			local btn = sightexports.sGui:createGuiElement("rectangle", 0, yt, bsx / 2, yb - yt, appInside)
			sightexports.sGui:setGuiHoverable(btn, true)
			sightexports.sGui:setGuiBackground(btn, "solid", {
				0,
				0,
				0,
				0
			})
			sightexports.sGui:setGuiHover(btn, "none", {
				0,
				0,
				0,
				0
			}, false, true)
			sightexports.sGui:setClickEvent(btn, "prevPhoto")
		end
		if nextPhoto then
			local btn = sightexports.sGui:createGuiElement("rectangle", bsx / 2, yt, bsx / 2, yb - yt, appInside)
			sightexports.sGui:setGuiHoverable(btn, true)
			sightexports.sGui:setGuiBackground(btn, "solid", {
				0,
				0,
				0,
				0
			})
			sightexports.sGui:setGuiHover(btn, "none", {
				0,
				0,
				0,
				0
			}, false, true)
			sightexports.sGui:setClickEvent(btn, "nextPhoto")
		end
	end
	if currentPhoto and photoListData[currentPhoto] then
		local sx = bsx
		local sy = bsx * (photoListData[currentPhoto][4] / photoListData[currentPhoto][3])
		if sy > yb - yt then
			local n = yb - yt
			sx = n / sy * bsx
			sy = n
		end
		local img = sightexports.sGui:createGuiElement("image", bsx / 2 - sx / 2, yt + (yb - yt) / 2 - sy / 2, sx, sy, appInside)
		sightexports.sGui:setImageDDS(img, ":sMobile/!mobile_sight/photos/" .. photoListData[currentPhoto][1] .. ".dds", "dxt3", false)
	end
	local icon = sightexports.sGui:createGuiElement("image", bsx / 4 / 2 - 12, bsy - topSize * 1.5 - 24 - 8, 24, 24, appInside)
	sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("trash-alt", 24, "regular"))
	if not photoDeleting and not photoInfo then
		sightexports.sGui:setGuiHoverable(icon, true)
		sightexports.sGui:setClickEvent(icon, "deletePhoto")
	end
	local icon = sightexports.sGui:createGuiElement("image", bsx / 4 + bsx / 4 / 2 - 12, bsy - topSize * 1.5 - 24 - 8, 24, 24, appInside)
	sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("info", 24))
	if not photoDeleting and not photoInfo then
		sightexports.sGui:setGuiHoverable(icon, true)
		sightexports.sGui:setClickEvent(icon, "openPhotoInfo")
	end
	local icon = sightexports.sGui:createGuiElement("image", bsx / 4 * 2 + bsx / 4 / 2 - 12, bsy - topSize * 1.5 - 24 - 8, 24, 24, appInside)
	sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("share-alt", 24))
	if not photoDeleting and not photoInfo then
		sightexports.sGui:setGuiHoverable(icon, true)
		sightexports.sGui:setClickEvent(icon, "sharePhoto")
	end
	local icon = sightexports.sGui:createGuiElement("image", bsx / 4 * 3 + bsx / 4 / 2 - 12, bsy - topSize * 1.5 - 24 - 8, 24, 24, appInside)
	sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("search", 24))
	if not photoDeleting and not photoInfo then
		sightexports.sGui:setGuiHoverable(icon, true)
		sightexports.sGui:setClickEvent(icon, "magnifyPhonePhoto")
	end
	if photoInfo then
		local rect = sightexports.sGui:createGuiElement("rectangle", 0, 0, bsx, bsy, appInside)
		sightexports.sGui:setGuiBackground(rect, "solid", {
			0,
			0,
			0,
			150
		})
		if photoListData[currentPhoto] then
			local time = getRealTime(photoListData[currentPhoto][2])
			local date = string.format("%04d. %02d. %02d. %02d:%02d:%02d", time.year + 1900, time.month + 1, time.monthday, time.hour, time.minute, time.second)
			local y = bsy / 2 - 140
			local icon = sightexports.sGui:createGuiElement("image", 8, y + 16 - 12, 24, 24, rect)
			sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("file-image", 24, "regular"))
			local label = sightexports.sGui:createGuiElement("label", 40, y, bsx - 16 - 32, 32, rect)
			sightexports.sGui:setLabelClip(label, true)
			sightexports.sGui:setLabelAlignment(label, "left", "center")
			sightexports.sGui:setLabelText(label, photoListData[currentPhoto][1])
			sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
			sightexports.sGui:setLabelColor(label, "#ffffff")
			y = y + 32
			local icon = sightexports.sGui:createGuiElement("image", 8, y + 16 - 12, 24, 24, rect)
			sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("save", 24, "regular"))
			local label = sightexports.sGui:createGuiElement("label", 40, y, bsx - 16 - 32, 32, rect)
			sightexports.sGui:setLabelClip(label, true)
			sightexports.sGui:setLabelAlignment(label, "left", "center")
			sightexports.sGui:setLabelText(label, photoListData[currentPhoto][8] .. " MB")
			sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
			sightexports.sGui:setLabelColor(label, "#ffffff")
			y = y + 32
			local icon = sightexports.sGui:createGuiElement("image", 8, y + 16 - 12, 24, 24, rect)
			sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("tv", 24))
			local label = sightexports.sGui:createGuiElement("label", 40, y, bsx - 16 - 32, 32, rect)
			sightexports.sGui:setLabelClip(label, true)
			sightexports.sGui:setLabelAlignment(label, "left", "center")
			sightexports.sGui:setLabelText(label, photoListData[currentPhoto][3] .. "x" .. photoListData[currentPhoto][4])
			sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
			sightexports.sGui:setLabelColor(label, "#ffffff")
			y = y + 32
			local icon = sightexports.sGui:createGuiElement("image", 8, y + 16 - 12, 24, 24, rect)
			sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("clock", 24))
			local label = sightexports.sGui:createGuiElement("label", 40, y, bsx - 16 - 32, 32, rect)
			sightexports.sGui:setLabelClip(label, true)
			sightexports.sGui:setLabelAlignment(label, "left", "center")
			sightexports.sGui:setLabelText(label, date)
			sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
			sightexports.sGui:setLabelColor(label, "#ffffff")
			y = y + 32
			local icon = sightexports.sGui:createGuiElement("image", 8, y + 16 - 12, 24, 24, rect)
			sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("map-marker-alt", 24))
			local label = sightexports.sGui:createGuiElement("label", 40, y, bsx - 16 - 32, 32, rect)
			sightexports.sGui:setLabelClip(label, true)
			sightexports.sGui:setLabelAlignment(label, "left", "center")
			sightexports.sGui:setLabelText(label, photoListData[currentPhoto][5])
			sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
			sightexports.sGui:setLabelColor(label, "#ffffff")
			y = y + 32 + 8
			if photoListData[currentPhoto][5] ~= "N/A" then
				local pw, ph = bsx - 32, 112
				local px, py = bsx / 2 - pw / 2, y
				local zoom = 2
				local rx, ry = photoListData[currentPhoto][6], photoListData[currentPhoto][7]
				local map = sightexports.sGui:createGuiElement("radar", px, py, pw, ph, rect)
				sightexports.sGui:setRadarCoords(map, rx, ry, 64)
				local icon = sightexports.sGui:createGuiElement("image", px + pw / 2 - 16, py + ph / 2 - 32, 32, 32, rect)
				sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("map-marker-alt", 32))
				sightexports.sGui:setImageColor(icon, green)
			end
		end
		generateBottom(true, "openPhoto", true)
	elseif photoDeleting then
		local rect = sightexports.sGui:createGuiElement("rectangle", 0, 0, bsx, bsy, appInside)
		sightexports.sGui:setGuiBackground(rect, "solid", {
			0,
			0,
			0,
			150
		})
		local w, h = bsx * 0.8, bsy * 0.175
		local rect = sightexports.sGui:createGuiElement("rectangle", bsx / 2 - w / 2, bsy / 2 - h / 2, w, h, appInside)
		sightexports.sGui:setGuiBackground(rect, "solid", {
			255,
			255,
			255
		})
		local label = sightexports.sGui:createGuiElement("label", 0, 0, w, h - 24 - 4 - 4, rect)
		sightexports.sGui:setLabelAlignment(label, "center", "center")
		sightexports.sGui:setLabelText(label, "Biztosan szeretnéd\ntörölni a képet?")
		sightexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
		sightexports.sGui:setLabelColor(label, "#000000")
		local btn = sightexports.sGui:createGuiElement("button", 4, h - 24 - 4, w / 2 - 6, 24, rect)
		sightexports.sGui:setGuiBackground(btn, "solid", green)
		sightexports.sGui:setGuiHover(btn, "none", green, false, true)
		sightexports.sGui:setButtonTextColor(btn, "#ffffff")
		sightexports.sGui:setButtonText(btn, "Igen")
		sightexports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
		sightexports.sGui:setClickEvent(btn, "finalDeletePhoto")
		local btn = sightexports.sGui:createGuiElement("button", w - w / 2 + 2, h - 24 - 4, w / 2 - 6, 24, rect)
		sightexports.sGui:setGuiBackground(btn, "solid", red)
		sightexports.sGui:setGuiHover(btn, "none", red, false, true)
		sightexports.sGui:setButtonTextColor(btn, "#ffffff")
		sightexports.sGui:setButtonText(btn, "Nem")
		sightexports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
		sightexports.sGui:setClickEvent(btn, "openPhoto")
		generateBottom(true, "openPhoto", true)
	elseif photoFromSMS then
		photoFromSMS = false
		generateBottom(true, "goBackToSMSSingle", true)
	else
		generateBottom(true, "openGallery", true)
	end
	bringBackFront()
end
function appScreens.photo_landscape()
	deleteTop()
	photoLandscape = true
	sightexports.sGui:setImageRotation(mobileFrame, 270)
	sightexports.sGui:setImageRotation(mobileBackground, 270)
	sightexports.sGui:setImageRotation(mobileScreen, 270)
	local a = math.rad(270)
	local pointX = 0
	local pointY = 0
	local centerX = bsx / 2
	local centerY = bsy / 2
	local drawX = centerX + (pointX - centerX) * math.cos(a) - (pointY - centerY) * math.sin(a)
	local drawY = centerY + (pointX - centerX) * math.sin(a) + (pointY - centerY) * math.cos(a)
	appInside = sightexports.sGui:createGuiElement("null", drawX, drawY - bsx, bsy, bsx, mobileBackground)
	local rect = sightexports.sGui:createGuiElement("rectangle", 0, 0, bsy, bsx, appInside)
	sightexports.sGui:setGuiBackground(rect, "solid", {
		0,
		0,
		0
	})
	local icon = sightexports.sGui:createGuiElement("image", math.floor(bsy * 0.1 / 2 - 12), 16, 24, 24, appInside)
	sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("sync", 24))
	if not photoDeleting and not photoInfo then
		sightexports.sGui:setGuiHoverable(icon, true)
		sightexports.sGui:setClickEvent(icon, "flipPhoto")
	end
	local yt = bsy * 0.1 / 2 + 12 + 8
	local yb = bsy - topSize * 1.5 - 24 - 8 - 8
	nextPhoto = false
	prevPhoto = false
	if not photoDeleting and not photoInfo then
		for k = 1, #photoListForCategory[selectedGalleryCategory] do
			if photoListForCategory[selectedGalleryCategory][k] == currentPhoto then
				nextPhoto = photoListForCategory[selectedGalleryCategory][k - 1]
			end
		end
		for k = 1, #photoListForCategory[selectedGalleryCategory] do
			if photoListForCategory[selectedGalleryCategory][k] == currentPhoto then
				prevPhoto = photoListForCategory[selectedGalleryCategory][k + 1]
			end
		end
		if prevPhoto then
			local btn = sightexports.sGui:createGuiElement("rectangle", yt, 0, (yb - yt) / 2, bsx, appInside)
			sightexports.sGui:setGuiHoverable(btn, true)
			sightexports.sGui:setGuiBackground(btn, "solid", {
				0,
				0,
				0,
				0
			})
			sightexports.sGui:setGuiHover(btn, "none", {
				0,
				0,
				0,
				0
			}, false, true)
			sightexports.sGui:setClickEvent(btn, "prevPhoto")
		end
		if nextPhoto then
			local btn = sightexports.sGui:createGuiElement("rectangle", yt + (yb - yt) / 2, 0, (yb - yt) / 2, bsx, appInside)
			sightexports.sGui:setGuiHoverable(btn, true)
			sightexports.sGui:setGuiBackground(btn, "solid", {
				0,
				0,
				0,
				0
			})
			sightexports.sGui:setGuiHover(btn, "none", {
				0,
				0,
				0,
				0
			}, false, true)
			sightexports.sGui:setClickEvent(btn, "nextPhoto")
		end
	end
	if currentPhoto and photoListData[currentPhoto] then
		local sx = bsx * (photoListData[currentPhoto][3] / photoListData[currentPhoto][4])
		local img = sightexports.sGui:createGuiElement("image", yt + (yb - yt) / 2 - sx / 2, 0, sx, bsx, appInside)
		sightexports.sGui:setImageDDS(img, ":sMobile/!mobile_sight/photos/" .. photoListData[currentPhoto][1] .. ".dds", "dxt3", false)
	end
	local icon = sightexports.sGui:createGuiElement("image", bsy - topSize * 1.5 - 24 - 8, bsx / 4 / 2 - 12, 24, 24, appInside)
	sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("search", 24))
	if not photoDeleting and not photoInfo then
		sightexports.sGui:setGuiHoverable(icon, true)
		sightexports.sGui:setClickEvent(icon, "magnifyPhonePhoto")
	end
	local icon = sightexports.sGui:createGuiElement("image", bsy - topSize * 1.5 - 24 - 8, bsx / 4 + bsx / 4 / 2 - 12, 24, 24, appInside)
	sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("share-alt", 24))
	if not photoDeleting and not photoInfo then
		sightexports.sGui:setGuiHoverable(icon, true)
		sightexports.sGui:setClickEvent(icon, "sharePhoto")
	end
	local icon = sightexports.sGui:createGuiElement("image", bsy - topSize * 1.5 - 24 - 8, bsx / 4 * 2 + bsx / 4 / 2 - 12, 24, 24, appInside)
	sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("info", 24))
	if not photoDeleting and not photoInfo then
		sightexports.sGui:setGuiHoverable(icon, true)
		sightexports.sGui:setClickEvent(icon, "openPhotoInfo")
	end
	local icon = sightexports.sGui:createGuiElement("image", bsy - topSize * 1.5 - 24 - 8, bsx / 4 * 3 + bsx / 4 / 2 - 12, 24, 24, appInside)
	sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("trash-alt", 24, "regular"))
	if not photoDeleting and not photoInfo then
		sightexports.sGui:setGuiHoverable(icon, true)
		sightexports.sGui:setClickEvent(icon, "deletePhoto")
	end
	if photoInfo then
		local rect = sightexports.sGui:createGuiElement("rectangle", 0, 0, bsy, bsx, appInside)
		sightexports.sGui:setGuiBackground(rect, "solid", {
			0,
			0,
			0,
			150
		})
		if photoListData[currentPhoto] then
			local time = getRealTime(photoListData[currentPhoto][2])
			local date = string.format("%04d. %02d. %02d. %02d:%02d:%02d", time.year + 1900, time.month + 1, time.monthday, time.hour, time.minute, time.second)
			local y = bsx / 2 - 80
			local icon = sightexports.sGui:createGuiElement("image", topSize + 8, y + 16 - 12, 24, 24, rect)
			sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("file-image", 24, "regular"))
			local label = sightexports.sGui:createGuiElement("label", topSize + 8 + 32, y, bsy / 2 - topSize - 24 - 32, 32, rect)
			sightexports.sGui:setLabelClip(label, true)
			sightexports.sGui:setLabelAlignment(label, "left", "center")
			sightexports.sGui:setLabelText(label, photoListData[currentPhoto][1])
			sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
			sightexports.sGui:setLabelColor(label, "#ffffff")
			y = y + 32
			local icon = sightexports.sGui:createGuiElement("image", topSize + 8, y + 16 - 12, 24, 24, rect)
			sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("save", 24, "regular"))
			local label = sightexports.sGui:createGuiElement("label", topSize + 8 + 32, y, bsy / 2 - topSize - 24 - 32, 32, rect)
			sightexports.sGui:setLabelClip(label, true)
			sightexports.sGui:setLabelAlignment(label, "left", "center")
			sightexports.sGui:setLabelText(label, photoListData[currentPhoto][8] .. " MB")
			sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
			sightexports.sGui:setLabelColor(label, "#ffffff")
			y = y + 32
			local icon = sightexports.sGui:createGuiElement("image", topSize + 8, y + 16 - 12, 24, 24, rect)
			sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("tv", 24))
			local label = sightexports.sGui:createGuiElement("label", topSize + 8 + 32, y, bsy / 2 - topSize - 24 - 32, 32, rect)
			sightexports.sGui:setLabelClip(label, true)
			sightexports.sGui:setLabelAlignment(label, "left", "center")
			sightexports.sGui:setLabelText(label, photoListData[currentPhoto][3] .. "x" .. photoListData[currentPhoto][4])
			sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
			sightexports.sGui:setLabelColor(label, "#ffffff")
			y = y + 32
			local icon = sightexports.sGui:createGuiElement("image", topSize + 8, y + 16 - 12, 24, 24, rect)
			sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("clock", 24))
			local label = sightexports.sGui:createGuiElement("label", topSize + 8 + 32, y, bsy / 2 - topSize - 24 - 32, 32, rect)
			sightexports.sGui:setLabelClip(label, true)
			sightexports.sGui:setLabelAlignment(label, "left", "center")
			sightexports.sGui:setLabelText(label, date)
			sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
			sightexports.sGui:setLabelColor(label, "#ffffff")
			y = y + 32
			local icon = sightexports.sGui:createGuiElement("image", topSize + 8, y + 16 - 12, 24, 24, rect)
			sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("map-marker-alt", 24))
			local label = sightexports.sGui:createGuiElement("label", topSize + 8 + 32, y, bsy / 2 - topSize - 24 - 32, 32, rect)
			sightexports.sGui:setLabelClip(label, true)
			sightexports.sGui:setLabelAlignment(label, "left", "center")
			sightexports.sGui:setLabelText(label, photoListData[currentPhoto][5])
			sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
			sightexports.sGui:setLabelColor(label, "#ffffff")
			y = y + 32 + 8
			if photoListData[currentPhoto][5] ~= "N/A" then
				local pw, ph = bsy / 2 - 24 - topSize * 1.5, bsx - 32
				local px, py = bsy / 2 + 16 - topSize * 1.5, 16
				local rx, ry = photoListData[currentPhoto][6], photoListData[currentPhoto][7]
				local map = sightexports.sGui:createGuiElement("radar", px, py, pw, ph, rect)
				sightexports.sGui:setRadarCoords(map, rx, ry, 64)
				local icon = sightexports.sGui:createGuiElement("image", px + pw / 2 - 16, py + ph / 2 - 32, 32, 32, rect)
				sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("map-marker-alt", 32))
				sightexports.sGui:setImageColor(icon, green)
			end
		end
	elseif photoDeleting then
		local rect = sightexports.sGui:createGuiElement("rectangle", 0, 0, bsy, bsx, appInside)
		sightexports.sGui:setGuiBackground(rect, "solid", {
			0,
			0,
			0,
			150
		})
		local w, h = bsx * 0.8, bsy * 0.175
		local rect = sightexports.sGui:createGuiElement("rectangle", bsy / 2 - w / 2, bsx / 2 - h / 2, w, h, appInside)
		sightexports.sGui:setGuiBackground(rect, "solid", {
			255,
			255,
			255
		})
		local label = sightexports.sGui:createGuiElement("label", 0, 0, w, h - 24 - 4 - 4, rect)
		sightexports.sGui:setLabelAlignment(label, "center", "center")
		sightexports.sGui:setLabelText(label, "Biztosan szeretnéd\ntörölni a képet?")
		sightexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
		sightexports.sGui:setLabelColor(label, "#000000")
		local btn = sightexports.sGui:createGuiElement("button", 4, h - 24 - 4, w / 2 - 6, 24, rect)
		sightexports.sGui:setGuiBackground(btn, "solid", green)
		sightexports.sGui:setGuiHover(btn, "none", green, false, true)
		sightexports.sGui:setButtonTextColor(btn, "#ffffff")
		sightexports.sGui:setButtonText(btn, "Igen")
		sightexports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
		sightexports.sGui:setClickEvent(btn, "finalDeletePhoto")
		local btn = sightexports.sGui:createGuiElement("button", w - w / 2 + 2, h - 24 - 4, w / 2 - 6, 24, rect)
		sightexports.sGui:setGuiBackground(btn, "solid", red)
		sightexports.sGui:setGuiHover(btn, "none", red, false, true)
		sightexports.sGui:setButtonTextColor(btn, "#ffffff")
		sightexports.sGui:setButtonText(btn, "Nem")
		sightexports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
		sightexports.sGui:setClickEvent(btn, "openPhoto")
	end
	local icon = sightexports.sGui:createGuiElement("image", bsy - topSize * 1.5 / 2 - topSize * 1.1 / 2, bsx / 2 - topSize * 1.1 / 2, topSize * 1.1, topSize * 1.1, appInside)
	sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("circle", topSize * 1.1, "regular"))
	sightexports.sGui:setGuiHoverable(icon, true)
	sightexports.sGui:setClickEvent(icon, "backToHome")
	local icon = sightexports.sGui:createGuiElement("image", bsy - topSize * 1.5 / 2 - topSize * 1.1 / 2, bsx - topSize * 3.25, topSize * 1.1, topSize * 1.1, appInside)
	sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("chevron-left", topSize * 1.1, "solid"))
	sightexports.sGui:setGuiHoverable(icon, true)
	if photoInfo then
		sightexports.sGui:setClickEvent(icon, "openPhoto")
	elseif photoDeleting then
		sightexports.sGui:setClickEvent(icon, "openPhoto")
	elseif photoFromSMS then
		photoFromSMS = false
		sightexports.sGui:setClickEvent(icon, "goBackToSMSSingle")
	else
		sightexports.sGui:setClickEvent(icon, "openGallery")
	end
	local icon = sightexports.sGui:createGuiElement("image", bsy - topSize * 1.5 / 2 - topSize * 1.1 / 2, topSize * 2, topSize * 1.1, topSize * 1.1, appInside)
	sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("camera", topSize * 1.1, "solid"))
	sightexports.sGui:setImageColor(icon, {
		255,
		255,
		255,
		100
	})
	bringBackFront()
end
addEvent("finalDeletePhoto", false)
addEventHandler("finalDeletePhoto", getRootElement(), function()
	photoDeleting = false
	local foundNext = false
	if currentPhoto and photoListData[currentPhoto] then
		if fileExists("photos/" .. photoListData[currentPhoto][1] .. ".dds") then
			fileDelete("photos/" .. photoListData[currentPhoto][1] .. ".dds")
		end
		if fileExists("photos/" .. photoListData[currentPhoto][1] .. ".sight") then
			fileDelete("photos/" .. photoListData[currentPhoto][1] .. ".sight")
		end
		if fileExists("photos/thumbs/" .. photoListData[currentPhoto][1] .. ".dds") then
			fileDelete("photos/thumbs/" .. photoListData[currentPhoto][1] .. ".dds")
		end
		local categoryWas = photoListData[currentPhoto][10]
		table.remove(photoListData, currentPhoto)
		if fileExists("photolist.sight") then
			fileDelete("photolist.sight")
		end
		local photoList = fileCreate("photolist.sight")
		photoListForCategory = {
			all = {},
			camera = {},
			screenshot = {},
			downloads = {}
		}
		for i = 1, #photoListData do
			if photoListData[i] then
				local fileName = photoListData[i][1]
				local timestamp = tonumber(photoListData[i][2])
				local sx = tonumber(photoListData[i][3])
				local sy = tonumber(photoListData[i][4])
				local name = photoListData[i][5]
				local x = tonumber(photoListData[i][6])
				local y = tonumber(photoListData[i][7])
				local size = tonumber(photoListData[i][8])
				local checksum = photoListData[i][9]
				local category = photoListData[i][10]
				if timestamp and sx and sy and name and x and y and size and checksum and category and photoListForCategory[category] then
					fileWrite(photoList, fileName .. "#" .. timestamp .. "#" .. sx .. "#" .. sy .. "#" .. name .. "#" .. x .. "#" .. y .. "#" .. size .. "#" .. checksum .. "#" .. category .. "\n")
					table.insert(photoListForCategory.all, i)
					table.insert(photoListForCategory[category], i)
					if category == selectedGalleryCategory or selectedGalleryCategory == "all" then
						if i <= currentPhoto then
							foundNext = i
						elseif i >= currentPhoto and not foundNext then
							foundNext = i
						end
					end
				end
			end
		end
		fileClose(photoList)
	end
	if foundNext then
		currentPhoto = foundNext
		photoDeleting = false
		photoInfo = false
		if photoLandscape then
			switchAppScreen("photo_landscape", true)
		else
			switchAppScreen("photo", true)
		end
	else
		switchAppScreen("gallery", true)
	end
end)
addEvent("magnifyPhonePhoto", false)
addEventHandler("magnifyPhonePhoto", getRootElement(), function(button, state, absoluteX, absoluteY, el)
	if currentPhoto and photoListData[currentPhoto] then
		sightexports.sGui:setDDSPreview(":sMobile/!mobile_sight/photos/" .. photoListData[currentPhoto][1] .. ".dds", "dxt3", false)
	end
end)
addEvent("sharePhoto", false)
addEventHandler("sharePhoto", getRootElement(), function(button, state, absoluteX, absoluteY, el)
	if currentPhoto then
		openSMSListForPhoto(currentPhoto)
	end
end)
addEvent("openPhotoInfo", false)
addEventHandler("openPhotoInfo", getRootElement(), function()
	photoInfo = true
	if photoLandscape then
		switchAppScreen("photo_landscape", true)
	else
		switchAppScreen("photo", true)
	end
end)
addEvent("deletePhoto", false)
addEventHandler("deletePhoto", getRootElement(), function()
	photoDeleting = true
	if photoLandscape then
		switchAppScreen("photo_landscape", true)
	else
		switchAppScreen("photo", true)
	end
end)
local galleryFromCamera = false
function appCloses.gallery()
	removeEventHandler("onClientKey", getRootElement(), galleryScrollKey)
	galleryIcons = {}
	galleryScroll = 1
	galleryScrollBar = false
	galleryFromCamera = false
end
function appScreens.gallery()
	appInside = sightexports.sGui:createGuiElement("null", 0, 0, bsx, bsy, mobileBackground)
	local rect = sightexports.sGui:createGuiElement("rectangle", 0, 0, bsx, bsy, appInside)
	sightexports.sGui:setGuiBackground(rect, "solid", {
		255,
		255,
		255
	})
	if not selectedGalleryCategory then
		local prevSize = (bsx - 20) / 2
		local i = 1
		for y = 0, 2 do
			for x = 0, 1 do
				if photoCategoryNames[i] then
					local img = sightexports.sGui:createGuiElement("image", 8 + (prevSize + 4) * x, topSize + 4 + (prevSize + 4) * y, prevSize, prevSize, appInside)
					if photoListForCategory[photoCategoryNames[i][1]][#photoListForCategory[photoCategoryNames[i][1]]] and photoListData[photoListForCategory[photoCategoryNames[i][1]][#photoListForCategory[photoCategoryNames[i][1]]]] then
						galleryIconIds[img] = photoCategoryNames[i][1]
						sightexports.sGui:setGuiHoverable(img, true)
						sightexports.sGui:setImageDDS(img, ":sMobile/!mobile_sight/photos/thumbs/" .. photoListData[photoListForCategory[photoCategoryNames[i][1]][#photoListForCategory[photoCategoryNames[i][1]]]][1] .. ".dds", "dxt1", false, true)
						sightexports.sGui:setClickEvent(img, "openGalleryCategory")
					else
						sightexports.sGui:setImageFile(img, loadedTextures["files/img/cam.png"])
					end
					local rect = sightexports.sGui:createGuiElement("rectangle", 8 + (prevSize + 4) * x, topSize + 4 + (prevSize + 4) * y, prevSize, prevSize, appInside)
					sightexports.sGui:setGuiBackground(rect, "solid", {
						0,
						0,
						0,
						150
					})
					local label = sightexports.sGui:createGuiElement("label", 0, 0, prevSize, prevSize, rect)
					sightexports.sGui:setLabelAlignment(label, "center", "center")
					sightexports.sGui:setLabelText(label, photoCategoryNames[i][2])
					sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
					sightexports.sGui:setLabelColor(label, "#ffffff")
				end
				i = i + 1
			end
		end
	else
		local prevSize = (bsx - 28) / 3
		addEventHandler("onClientKey", getRootElement(), galleryScrollKey)
		local j = 1
		local k = #photoListForCategory[selectedGalleryCategory]
		local lines = math.ceil(k / 3)
		galleryScroll = math.max(1, lines - 6 + 1)
		currentGalleryScroll = math.min(galleryScroll - 1, lastGalleryScroll[selectedGalleryCategory] or 0)
		k = #photoListForCategory[selectedGalleryCategory] - currentGalleryScroll * 3
		for y = 0, 5 do
			for x = 0, 2 do
				local img = sightexports.sGui:createGuiElement("image", 8 + (prevSize + 4) * x, topSize + 4 + (prevSize + 4) * y, prevSize, prevSize, appInside)
				local i = photoListForCategory[selectedGalleryCategory][k]
				if photoListData[i] then
					galleryIconIds[img] = i
					sightexports.sGui:setGuiHoverable(img, true)
					sightexports.sGui:setImageDDS(img, ":sMobile/!mobile_sight/photos/thumbs/" .. photoListData[i][1] .. ".dds", "dxt1", false, true)
				end
				if gallerySelecting == "ad" then
					sightexports.sGui:setClickEvent(img, "openPhotoForAds")
				elseif gallerySelecting == "contacts" then
					sightexports.sGui:setClickEvent(img, "openPhotoForContacts")
				elseif gallerySelecting == "settings" then
					sightexports.sGui:setClickEvent(img, "openPhotoForSettings")
				else
					sightexports.sGui:setClickEvent(img, "openPhoto")
				end
				galleryIcons[j] = img
				j = j + 1
				k = k - 1
			end
		end
		local h = (prevSize + 4) * 6 - 4
		local rect = sightexports.sGui:createGuiElement("rectangle", bsx - 10, topSize + 4, 3, h, appInside)
		sightexports.sGui:setGuiBackground(rect, "solid", grey1)
		galleryScrollBar = sightexports.sGui:createGuiElement("rectangle", bsx - 10, topSize + 4 + currentGalleryScroll * (h / galleryScroll), 3, h / galleryScroll, appInside)
		sightexports.sGui:setGuiBackground(galleryScrollBar, "solid", grey3)
	end
	if selectedGalleryCategory then
		if galleryFromCamera then
			generateBottom(true, "openCamera", true)
		else
			generateBottom(true, "openGalleryEx", true)
		end
	elseif gallerySelecting == "ad" then
		generateBottom(true, "selectAdPhotoEx", true)
	elseif gallerySelecting == "contacts" then
		generateBottom(true, "openSingleContact", true)
	elseif gallerySelecting == "settings" then
		generateBottom(true, "openSettings", true)
	else
		generateBottom(true, false, true)
	end
	bringBackFront()
end
function appCloses.camera_portrait(force)
	if isElement(mobileObjects[localPlayer]) then
		setElementAlpha(mobileObjects[localPlayer], 255)
	end
	if not force then
		setElementData(localPlayer, "mobile", 1)
	end
	createTop()
	if isElement(cameraScreenSource) then
		destroyElement(cameraScreenSource)
	end
	cameraScreenSource = false
	cameraPreview = false
	cameraShutter = false
	sightexports.sCamera:toggleCamera(false, true)
	removeEventHandler("onClientHUDRender", getRootElement(), refreshScreenSource)
end
function appScreens.camera_portrait()
	if isElement(mobileObjects[localPlayer]) then
		setElementAlpha(mobileObjects[localPlayer], 0)
	end
	setElementData(localPlayer, "mobile", 3)
	deleteTop()
	cameraLandscape = false
	appInside = sightexports.sGui:createGuiElement("null", 0, 0, bsx, bsy, mobileBackground)
	local rect = sightexports.sGui:createGuiElement("rectangle", 0, 0, bsx, bsy, appInside)
	sightexports.sGui:setGuiBackground(rect, "solid", {
		0,
		0,
		0
	})
	sightexports.sCamera:toggleCamera("fp2", true)
	cameraScreenSource = dxCreateScreenSource(imageSizeX, imageSizeY)
	addEventHandler("onClientHUDRender", getRootElement(), refreshScreenSource)
	local img = sightexports.sGui:createGuiElement("image", 0, bsy * 0.1, bsx, bsy * 0.7, appInside)
	sightexports.sGui:setImageFile(img, cameraScreenSource)
	local u = imageSizeY * (bsx / (bsy * 0.7))
	sightexports.sGui:setImageUV(img, imageSizeX / 2 - u / 2, 0, u, imageSizeY)
	cameraShutter = sightexports.sGui:createGuiElement("rectangle", 0, 0, bsx, bsy * 0.7, img)
	sightexports.sGui:setGuiRenderDisabled(cameraShutter, true)
	local icon = sightexports.sGui:createGuiElement("image", bsx - 24 - 16 - 24 - 8, bsy * 0.1 / 2 - 12, 24, 24, appInside)
	sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("search", 24))
	sightexports.sGui:setGuiHoverable(icon, true)
	sightexports.sGui:setClickEvent(icon, "previewCameraBig")
	local icon = sightexports.sGui:createGuiElement("image", bsx - 24 - 16, bsy * 0.1 / 2 - 12, 24, 24, appInside)
	sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("sync", 24))
	sightexports.sGui:setGuiHoverable(icon, true)
	sightexports.sGui:setClickEvent(icon, "flipCamera")
	cameraPreview = sightexports.sGui:createGuiElement("image", math.floor(bsx / 4 - 24), math.floor(bsy * 0.1 + bsy * 0.7 + (bsy * 0.2 - topSize * 1.5) / 2 - 24), 48, 48, appInside)
	if 0 < #photoListData then
		sightexports.sGui:setImageDDS(cameraPreview, ":sMobile/!mobile_sight/photos/thumbs/" .. photoListData[#photoListData][1] .. ".dds", "dxt1", false)
	else
		sightexports.sGui:setImageFile(cameraPreview, loadedTextures["files/img/prev.png"])
	end
	sightexports.sGui:setGuiHoverable(cameraPreview, true)
	sightexports.sGui:setClickEvent(cameraPreview, "openGalleryFromCamera")
	local icon = sightexports.sGui:createGuiElement("image", math.floor(bsx / 4 - 25), math.floor(bsy * 0.1 + bsy * 0.7 + (bsy * 0.2 - topSize * 1.5) / 2 - 25), 50, 50, appInside)
	sightexports.sGui:setImageColor(icon, {
		0,
		0,
		0
	})
	sightexports.sGui:setImageFile(icon, loadedTextures["files/img/camcut.png"])
	local icon = sightexports.sGui:createGuiElement("image", math.floor(bsx / 2 - 28), math.floor(bsy * 0.1 + bsy * 0.7 + (bsy * 0.2 - topSize * 1.5) / 2 - 28), 56, 56, appInside)
	sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("circle", 56))
	sightexports.sGui:setGuiHoverable(icon, true)
	sightexports.sGui:setClickEvent(icon, "takePhoto", true)
	local icon = sightexports.sGui:createGuiElement("image", 12, 12, 32, 32, icon)
	sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("camera", 32))
	sightexports.sGui:setImageColor(icon, {
		0,
		0,
		0
	})
	sightexports.sGui:setGuiHoverable(icon, true)
	generateBottom(false, false, true)
	bringBackFront()
end
function appCloses.camera_landscape(force)
	if not force then
		setElementData(localPlayer, "mobile", 1)
	end
	if isElement(mobileObjects[localPlayer]) then
		setElementAlpha(mobileObjects[localPlayer], 255)
	end
	createTop()
	sightexports.sGui:setImageRotation(mobileFrame, 0)
	sightexports.sGui:setImageRotation(mobileBackground, 0)
	sightexports.sGui:setImageRotation(mobileScreen, 0)
	if isElement(cameraScreenSource) then
		destroyElement(cameraScreenSource)
	end
	cameraScreenSource = false
	cameraPreview = false
	cameraShutter = false
	sightexports.sCamera:toggleCamera(false, true)
	removeEventHandler("onClientHUDRender", getRootElement(), refreshScreenSource)
end
function appScreens.camera_landscape()
	setElementData(localPlayer, "mobile", 3)
	if isElement(mobileObjects[localPlayer]) then
		setElementAlpha(mobileObjects[localPlayer], 0)
	end
	deleteTop()
	sightexports.sGui:setImageRotation(mobileFrame, 270)
	sightexports.sGui:setImageRotation(mobileBackground, 270)
	sightexports.sGui:setImageRotation(mobileScreen, 270)
	local a = math.rad(270)
	cameraLandscape = true
	local pointX = 0
	local pointY = 0
	local centerX = bsx / 2
	local centerY = bsy / 2
	local drawX = centerX + (pointX - centerX) * math.cos(a) - (pointY - centerY) * math.sin(a)
	local drawY = centerY + (pointX - centerX) * math.sin(a) + (pointY - centerY) * math.cos(a)
	appInside = sightexports.sGui:createGuiElement("null", drawX, drawY - bsx, bsy, bsx, mobileBackground)
	local rect = sightexports.sGui:createGuiElement("rectangle", 0, 0, bsy, bsx, appInside)
	sightexports.sGui:setGuiBackground(rect, "solid", {
		0,
		0,
		0
	})
	sightexports.sCamera:toggleCamera("fp2", true)
	cameraScreenSource = dxCreateScreenSource(imageSizeX, imageSizeY)
	addEventHandler("onClientHUDRender", getRootElement(), refreshScreenSource)
	local img = sightexports.sGui:createGuiElement("image", bsy * 0.1, 0, bsy * 0.7, bsx, appInside)
	sightexports.sGui:setImageFile(img, cameraScreenSource)
	local u = imageSizeY * (bsy * 0.7 / bsx)
	sightexports.sGui:setImageUV(img, imageSizeX / 2 - u / 2, 0, u, imageSizeY)
	cameraShutter = sightexports.sGui:createGuiElement("rectangle", 0, 0, bsy * 0.7, bsx, img)
	sightexports.sGui:setGuiRenderDisabled(cameraShutter, true)
	local icon = sightexports.sGui:createGuiElement("image", math.floor(bsy * 0.1 / 2 - 12), 48, 24, 24, appInside)
	sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("search", 24))
	sightexports.sGui:setGuiHoverable(icon, true)
	sightexports.sGui:setClickEvent(icon, "previewCameraBig")
	local icon = sightexports.sGui:createGuiElement("image", math.floor(bsy * 0.1 / 2 - 12), 16, 24, 24, appInside)
	sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("sync", 24))
	sightexports.sGui:setGuiHoverable(icon, true)
	sightexports.sGui:setClickEvent(icon, "flipCamera")
	local icon = sightexports.sGui:createGuiElement("image", math.floor(bsy * 0.1 + bsy * 0.7 + (bsy * 0.2 - topSize * 1.5) / 2 - 28), math.floor(bsx / 2 - 28), 56, 56, appInside)
	sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("circle", 56))
	sightexports.sGui:setGuiHoverable(icon, true)
	sightexports.sGui:setClickEvent(icon, "takePhoto", true)
	local icon = sightexports.sGui:createGuiElement("image", 12, 12, 32, 32, icon)
	sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("camera", 32))
	sightexports.sGui:setImageColor(icon, {
		0,
		0,
		0
	})
	sightexports.sGui:setGuiHoverable(icon, true)
	cameraPreview = sightexports.sGui:createGuiElement("image", math.floor(bsy * 0.1 + bsy * 0.7 + (bsy * 0.2 - topSize * 1.5) / 2 - 24), math.floor(bsx / 4 * 3 - 24), 48, 48, appInside)
	if 0 < #photoListForCategory.camera and photoListData[photoListForCategory.camera[#photoListForCategory.camera]] then
		sightexports.sGui:setImageDDS(cameraPreview, ":sMobile/!mobile_sight/photos/thumbs/" .. photoListData[photoListForCategory.camera[#photoListForCategory.camera]][1] .. ".dds", "dxt1", false)
	else
		sightexports.sGui:setImageFile(cameraPreview, loadedTextures["files/img/prev.png"])
	end
	sightexports.sGui:setGuiHoverable(cameraPreview, true)
	sightexports.sGui:setClickEvent(cameraPreview, "openGalleryFromCamera")
	local icon = sightexports.sGui:createGuiElement("image", math.floor(bsy * 0.1 + bsy * 0.7 + (bsy * 0.2 - topSize * 1.5) / 2 - 25), math.floor(bsx / 4 * 3 - 25), 50, 50, appInside)
	sightexports.sGui:setImageColor(icon, {
		0,
		0,
		0
	})
	sightexports.sGui:setImageFile(icon, loadedTextures["files/img/camcut.png"])
	local icon = sightexports.sGui:createGuiElement("image", bsy - topSize * 1.5 / 2 - topSize * 1.1 / 2, bsx / 2 - topSize * 1.1 / 2, topSize * 1.1, topSize * 1.1, appInside)
	sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("circle", topSize * 1.1, "regular"))
	sightexports.sGui:setGuiHoverable(icon, true)
	sightexports.sGui:setClickEvent(icon, "backToHome")
	local icon = sightexports.sGui:createGuiElement("image", bsy - topSize * 1.5 / 2 - topSize * 1.1 / 2, bsx - topSize * 3.25, topSize * 1.1, topSize * 1.1, appInside)
	sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("chevron-left", topSize * 1.1, "solid"))
	sightexports.sGui:setGuiHoverable(icon, true)
	sightexports.sGui:setClickEvent(icon, "backToHome")
	local icon = sightexports.sGui:createGuiElement("image", bsy - topSize * 1.5 / 2 - topSize * 1.1 / 2, topSize * 2, topSize * 1.1, topSize * 1.1, appInside)
	sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("camera", topSize * 1.1, "solid"))
	sightexports.sGui:setImageColor(icon, {
		255,
		255,
		255,
		100
	})
	bringBackFront()
end
function refreshScreenSource()
	dxUpdateScreenSource(cameraScreenSource, true)
	if cameraShutter and cameraClick then
		local p = (getTickCount() - cameraClick) / 500
		if 1 < p then
			sightexports.sGui:setGuiRenderDisabled(cameraShutter, true)
			cameraClick = false
		else
			p = getEasingValue(p, "OutQuad")
			sightexports.sGui:setGuiBackground(cameraShutter, "solid", {
				0,
				0,
				0,
				255 * (1 - p)
			})
			sightexports.sGui:setGuiRenderDisabled(cameraShutter, false)
		end
	end
end
local photoId = 1
local lastPhoto = 0
thumbSize = 128
local lastScreenshotUrl = false
function takePhoto(screenshot)
	if cameraClick or lastScreenshot then
		return
	end
	local category = screenshot and "screenshot" or "camera"
	local x, y = 0, 0
	local sx, sy = 0, 0
	if currentPhoneScreen == "camera_portrait" then
		local u = imageSizeY * (bsx / (bsy * 0.7))
		x, y = imageSizeX / 2 - u / 2, 0
		sx, sy = u, imageSizeY
	elseif currentPhoneScreen == "camera_landscape" then
		local u = imageSizeY * (bsy * 0.7 / bsx)
		x, y = imageSizeX / 2 - u / 2, 0
		sx, sy = u, imageSizeY
	elseif screenshot then
		sx = bsx - 8
		sy = bsy
	end
	sx = math.floor(sx / 4) * 4
	sy = math.floor(sy / 4) * 4
	local photoRt = dxCreateRenderTarget(sx, sy)
	dxSetRenderTarget(photoRt)
	if screenshot then
		local x, y = sightexports.sGui:getGuiRealPosition(mobileBackground)
		sightexports.sGui:drawGuiElementWithChildren(mobileBackground, -x - 4, -y)
		local x, y = sightexports.sGui:getGuiRealPosition(appInside)
		sightexports.sGui:drawGuiElementWithChildren(appInside, -x - 4, -y)
		local x, y = sightexports.sGui:getGuiRealPosition(topRect)
		sightexports.sGui:drawGuiElementWithChildren(topRect, -x - 4, -y)
	else
		dxDrawImageSection(0, 0, sx, sy, x, y, sx, sy, cameraScreenSource)
	end
	dxSetRenderTarget()
	if isElement(photoRt) then
		local pixels = dxGetTexturePixels(photoRt, "dds", "dxt3", false)
		local rawPixels = dxGetTexturePixels(photoRt)
		if not screenshot then
			destroyElement(photoRt)
		end
		if pixels then
			local time = getRealTime()
			local fileName = string.format("%04d-%02d-%02d_%02d-%02d-%02d", time.year + 1900, time.month + 1, time.monthday, time.hour, time.minute, time.second)
			if time.timestamp == lastPhoto then
				photoId = photoId + 1
				fileName = fileName .. "_" .. photoId
			else
				photoId = 1
			end
			lastPhoto = time.timestamp
			local checksum = sha256(pixels)
			local convertedFile = fileCreate("photos/" .. fileName .. ".dds")
			if convertedFile then
				fileWrite(convertedFile, pixels)
				local size = math.floor(fileGetSize(convertedFile) / 1048576 * 100) / 100
				fileClose(convertedFile)
				local thumbRt = dxCreateRenderTarget(thumbSize, thumbSize)
				dxSetRenderTarget(thumbRt)
				if screenshot then
					local tsy = thumbSize / bsx * bsy
					dxDrawImage(0, thumbSize / 2 - tsy / 2, thumbSize, tsy, photoRt)
					destroyElement(photoRt)
				else
					local ts = math.floor(math.min(sx, sy) * 0.75)
					dxDrawImageSection(0, 0, thumbSize, thumbSize, imageSizeX / 2 - ts / 2, imageSizeY / 2 - ts / 2, ts, ts, cameraScreenSource)
				end
				dxSetRenderTarget()
				if isElement(thumbRt) then
					local pixels = dxGetTexturePixels(thumbRt, "dds", "dxt1", false)
					if pixels then
						local convertedFile = fileCreate("photos/thumbs/" .. fileName .. ".dds")
						if convertedFile then
							fileWrite(convertedFile, pixels)
							fileClose(convertedFile)
							local checksumFile = fileCreate("photos/" .. fileName .. ".sight")
							if checksumFile then
								fileWrite(checksumFile, teaEncode(checksum, "mk" .. time.timestamp .. utf8.sub(fileName, 1, 10)))
								fileClose(checksumFile)
								local photoList = false
								if fileExists("photolist.sight") then
									photoList = fileOpen("photolist.sight")
								else
									photoList = fileCreate("photolist.sight")
								end
								if photoList then
									local name = "N/A"
									local x, y, z = 0, 0, 0
									if locationState and 0 >= getElementInterior(localPlayer) and 0 >= getElementDimension(localPlayer) then
										x, y, z = getElementPosition(localPlayer)
										name = sightexports.sRadar:getZoneName(x, y, z)
										x = math.floor(x + 0.5)
										y = math.floor(y + 0.5)
									end
									fileSetPos(photoList, fileGetSize(photoList))
									fileWrite(photoList, fileName .. "#" .. time.timestamp .. "#" .. sx .. "#" .. sy .. "#" .. name .. "#" .. x .. "#" .. y .. "#" .. size .. "#" .. checksum .. "#" .. category .. "\n")
									fileClose(photoList)
									rawPixels = dxConvertPixels(rawPixels, "jpeg", 95)
									if rawPixels then
										local jpg = fileName
										local post = ""
										local i = 1
										while origFE("#mobile_sight/" .. jpg .. post .. ".jpg") do
											i = i + 1
											post = "_" .. i
										end
										jpg = "#mobile_sight/" .. jpg .. post .. ".jpg"
										if not origFE(jpg) then
											local file = origFC(jpg)
											if file then
												fileWrite(file, rawPixels)
												fileClose(file)
											end
										end
									end
									table.insert(photoListData, {
										fileName,
										time.timestamp,
										sx,
										sy,
										name,
										x,
										y,
										size,
										checksum,
										category
									})
									table.insert(photoListForCategory.all, #photoListData)
									table.insert(photoListForCategory[category], #photoListData)
									if not screenshot then
										sightexports.sGui:setImageDDS(cameraPreview, ":sMobile/!mobile_sight/photos/thumbs/" .. fileName .. ".dds", "dxt1", false)
										cameraClick = getTickCount()
										if soundState then
											local players = getElementsByType("player", getRootElement(), true)
											local x, y, z = getElementPosition(localPlayer)
											for i = #players, 1, -1 do
												local x2, y2, z2 = getElementPosition(players[i])
												if getDistanceBetweenPoints3D(x, y, z, x2, y2, z2) > 30 or players[i] == localPlayer then
													table.remove(players, i)
												end
											end
											triggerServerEvent("syncCameraShutterSound", localPlayer, players)
											playSound("files/cam.wav")
										end
									else
										lastScreenshot = getTickCount()
										lastScreenshotUrl = ":sMobile/!mobile_sight/photos/" .. fileName .. ".dds"
									end
								end
								photoList = nil
							end
							checksumFile = nil
						end
						convertedFile = nil
						checksum = nil
					end
					pixels = nil
					rawPixels = nil
					destroyElement(thumbRt)
				end
				thumbRt = nil
			end
			convertedFile = nil
		end
		pixels = nil
	end
	photoRt = nil
	collectgarbage("collect")
end
addEvent("takePhoto", false)
addEventHandler("takePhoto", getRootElement(), function()
	takePhoto()
end)

currentForex = false

function appCloses.home()
	sightexports.sTrading:setForexSubscription(false, "phoneWidget")
	r66_0 = false
	r67_0 = false
	r68_0 = false
	r69_0 = {}
	sightlangCondHandl1(false)
end

function appScreens.home()
	appInside = sightexports.sGui:createGuiElement("null", 0, 0, bsx, bsy, mobileBackground)
	local rt = getRealTime()
	local tmp = string.format("%02d:%02d", rt.hour, rt.minute)
	local h = sightexports.sGui:getFontHeight("40/BebasNeueLight.otf")
	local label = sightexports.sGui:createGuiElement("label", 8, bsy / 8, bsx, bsy / 8, appInside)
	sightexports.sGui:setLabelAlignment(label, "left", "center")
	sightexports.sGui:setLabelText(label, tmp)
	sightexports.sGui:setLabelShadow(label, {
		0,
		0,
		0,
		175
	}, 1, 1)
	sightexports.sGui:setLabelFont(label, "40/BebasNeueLight.otf")
	timeLabel = label
	local label = sightexports.sGui:createGuiElement("label", 8, bsy / 8 + bsy / 8 / 2 + h / 2, bsx, h, appInside)
	sightexports.sGui:setLabelAlignment(label, "left", "top")
	local time = getRealTime()
	local date = time.year + 1900 .. ". "
	if time.month == 0 then
		date = date .. "január"
	elseif time.month == 1 then
		date = date .. "február"
	elseif time.month == 2 then
		date = date .. "március"
	elseif time.month == 3 then
		date = date .. "április"
	elseif time.month == 4 then
		date = date .. "május"
	elseif time.month == 5 then
		date = date .. "június"
	elseif time.month == 6 then
		date = date .. "július"
	elseif time.month == 7 then
		date = date .. "augusztus"
	elseif time.month == 8 then
		date = date .. "szeptember"
	elseif time.month == 9 then
		date = date .. "október"
	elseif time.month == 10 then
		date = date .. "november"
	elseif time.month == 11 then
		date = date .. "december"
	end
	date = date .. " " .. time.monthday .. "., "
	if time.weekday == 1 then
		date = date .. "hétfő"
	elseif time.weekday == 2 then
		date = date .. "kedd"
	elseif time.weekday == 3 then
		date = date .. "szerda"
	elseif time.weekday == 4 then
		date = date .. "csütörtök"
	elseif time.weekday == 5 then
		date = date .. "péntek"
	elseif time.weekday == 6 then
		date = date .. "szombat"
	elseif time.weekday == 0 then
		date = date .. "vasárnap"
	end
	sightexports.sGui:setLabelText(label, date)
	sightexports.sGui:setLabelShadow(label, {
		0,
		0,
		0,
		175
	}, 1, 1)
	sightexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
	
	
	local callNotiCount = 0
	local smsNotiCount = 0
	for i = 1, #notifications do
		if notifications[i] then
			if notifications[i][1] == "call" then
				if callNotiCount < 99 then
					callNotiCount = callNotiCount + 1
				end
			elseif notifications[i][1] == "sms" and smsNotiCount < 99 then
				smsNotiCount = smsNotiCount + 1
			end
			if 99 <= smsNotiCount and 99 <= callNotiCount then
				break
			end
		end
	end
	local w = (bsx - 16) / 4
	
	if widgetShowState then
		if not sightexports.sTrading:isValidIndex(currentForex) then
			currentForex = sightexports.sTrading:getIndexList()[1]
		end
		sightexports.sTrading:setForexSubscription(currentForex, "phoneWidget")
		r66_0 = sightexports.sGui:createGuiElement("image", 8, bsy / 8 + bsy / 8 / 2 + h / 2 + sightexports.sGui:getLabelFontHeight(label) + 12, bsx - 16, 64, appInside)
		sightexports.sGui:setImageFile(r66_0, loadedTextures["files/img/widget.png"])
		sightexports.sGui:setImageColor(r66_0, "#000000")
		sightexports.sGui:setGuiHoverable(r66_0, true)
		sightexports.sGui:setClickEvent(r66_0, "openForexWidget")
		local r7_85 = sightexports.sGui:getFontHeight("14/BebasNeueBold.otf")
		local r8_85 = sightexports.sGui:getFontHeight("11/BebasNeueBold.otf")
		priceLabel = sightexports.sGui:createGuiElement("label", 0, 32 - (r7_85 + r8_85) / 2, 0, r7_85, r66_0)
		sightexports.sGui:setLabelAlignment(priceLabel, "left", "center")
		sightexports.sGui:setLabelFont(priceLabel, "14/BebasNeueBold.otf")
		local r9_85 = math.floor(r7_85 / 2)
		r68_0 = sightexports.sGui:createGuiElement("image", 0, math.floor(32 - (r7_85 + r8_85) / 2 + r7_85 / 2 - r9_85 / 2), r9_85, r9_85, r66_0)
		sightexports.sGui:setImageFile(r68_0, ":sMobile/files/img/tri.png")
		label = sightexports.sGui:createGuiElement("label", 4, 32 - (r7_85 + r8_85) / 2 + r7_85, 90, r8_85, r66_0)
		sightexports.sGui:setLabelAlignment(label, "center", "center")
		sightexports.sGui:setLabelFont(label, "11/BebasNeueBold.otf")
		sightexports.sGui:setLabelText(label, currentForex)
		sightlangCondHandl1(true)
		onHomeForexUpdate()
	end
	
	local bbox = sightexports.sGui:createGuiElement("null", 8, bsy - topSize * 2 - 52, w, 52, appInside)
	local icon = sightexports.sGui:createGuiElement("image", 8 + w / 2 - 18, bsy - topSize * 2 - 52, 36, 36, appInside)
	
	sightexports.sGui:setImageFile(icon, loadedTextures["files/icons/phone.png"])
	sightexports.sGui:setGuiBoundingBox(icon, bbox)
	sightexports.sGui:setGuiHoverable(icon, true)
	sightexports.sGui:setClickEvent(icon, "openDialer")
	if 0 < callNotiCount then
		local icon = sightexports.sGui:createGuiElement("image", 8 + w / 2 - 18 + 36 - 12, bsy - topSize * 2 - 52 - 6, 24, 24, appInside)
		sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("circle", 24, "solid"))
		sightexports.sGui:setImageColor(icon, red)
		local label = sightexports.sGui:createGuiElement("label", 0, -1, 24, 24, icon)
		sightexports.sGui:setLabelAlignment(label, "center", "center")
		sightexports.sGui:setLabelText(label, callNotiCount)
		sightexports.sGui:setLabelFont(label, "8/Ubuntu-R.ttf")
	end
	local label = sightexports.sGui:createGuiElement("label", 8, bsy - topSize * 2 - 52 + 36, w, 16, appInside)
	sightexports.sGui:setLabelAlignment(label, "center", "center")
	sightexports.sGui:setLabelText(label, "Telefon")
	sightexports.sGui:setLabelShadow(label, {
		0,
		0,
		0,
		175
	}, 1, 1)
	sightexports.sGui:setLabelFont(label, "10/BebasNeueRegular.otf")
	sightexports.sGui:setGuiBoundingBox(label, bbox)
	sightexports.sGui:setGuiHoverable(label, true)
	local bbox = sightexports.sGui:createGuiElement("null", 8 + w, bsy - topSize * 2 - 52, w, 52, appInside)
	local icon = sightexports.sGui:createGuiElement("image", 8 + w / 2 + w - 18, bsy - topSize * 2 - 52, 36, 36, appInside)
	sightexports.sGui:setImageFile(icon, loadedTextures["files/icons/sms.png"])
	sightexports.sGui:setGuiBoundingBox(icon, bbox)
	sightexports.sGui:setGuiHoverable(icon, true)
	sightexports.sGui:setClickEvent(icon, "openSMSList")
	if 0 < smsNotiCount then
		local icon = sightexports.sGui:createGuiElement("image", 8 + w / 2 + w - 18 + 36 - 12, bsy - topSize * 2 - 52 - 6, 24, 24, appInside)
		sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("circle", 24, "solid"))
		sightexports.sGui:setImageColor(icon, red)
		local label = sightexports.sGui:createGuiElement("label", 0, -1, 24, 24, icon)
		sightexports.sGui:setLabelAlignment(label, "center", "center")
		sightexports.sGui:setLabelText(label, smsNotiCount)
		sightexports.sGui:setLabelFont(label, "8/Ubuntu-R.ttf")
	end
	local label = sightexports.sGui:createGuiElement("label", 8 + w, bsy - topSize * 2 - 52 + 36, w, 16, appInside)
	sightexports.sGui:setLabelAlignment(label, "center", "center")
	sightexports.sGui:setLabelText(label, "SMS")
	sightexports.sGui:setLabelShadow(label, {
		0,
		0,
		0,
		175
	}, 1, 1)
	sightexports.sGui:setLabelFont(label, "10/BebasNeueRegular.otf")
	sightexports.sGui:setGuiBoundingBox(label, bbox)
	sightexports.sGui:setGuiHoverable(label, true)
	local bbox = sightexports.sGui:createGuiElement("null", 8 + w * 2, bsy - topSize * 2 - 52, w, 52, appInside)
	local icon = sightexports.sGui:createGuiElement("image", 8 + w / 2 + w * 2 - 18, bsy - topSize * 2 - 52, 36, 36, appInside)
	sightexports.sGui:setImageFile(icon, loadedTextures["files/icons/camera.png"])
	sightexports.sGui:setGuiBoundingBox(icon, bbox)
	sightexports.sGui:setGuiHoverable(icon, true)
	sightexports.sGui:setClickEvent(icon, "openCamera")
	local label = sightexports.sGui:createGuiElement("label", 8 + w * 2, bsy - topSize * 2 - 52 + 36, w, 16, appInside)
	sightexports.sGui:setLabelAlignment(label, "center", "center")
	sightexports.sGui:setLabelText(label, "Kamera")
	sightexports.sGui:setLabelShadow(label, {
		0,
		0,
		0,
		175
	}, 1, 1)
	sightexports.sGui:setLabelFont(label, "10/BebasNeueRegular.otf")
	sightexports.sGui:setGuiBoundingBox(label, bbox)
	sightexports.sGui:setGuiHoverable(label, true)
	local bbox = sightexports.sGui:createGuiElement("null", 8 + w * 3, bsy - topSize * 2 - 52, w, 52, appInside)
	local icon = sightexports.sGui:createGuiElement("image", 8 + w / 2 + w * 3 - 18, bsy - topSize * 2 - 52, 36, 36, appInside)
	sightexports.sGui:setImageFile(icon, loadedTextures["files/icons/gallery.png"])
	sightexports.sGui:setGuiBoundingBox(icon, bbox)
	sightexports.sGui:setGuiHoverable(icon, true)
	sightexports.sGui:setClickEvent(icon, "openGallery")
	local label = sightexports.sGui:createGuiElement("label", 8 + w * 3, bsy - topSize * 2 - 52 + 36, w, 16, appInside)
	sightexports.sGui:setLabelAlignment(label, "center", "center")
	sightexports.sGui:setLabelText(label, "Galéria")
	sightexports.sGui:setLabelShadow(label, {
		0,
		0,
		0,
		175
	}, 1, 1)
	sightexports.sGui:setLabelFont(label, "10/BebasNeueRegular.otf")
	sightexports.sGui:setGuiBoundingBox(label, bbox)
	sightexports.sGui:setGuiHoverable(label, true)
	
	--[[
	local bbox = sightexports.sGui:createGuiElement("null", 8, bsy - topSize * 3 - 156, w, 52, appInside)
	local icon = sightexports.sGui:createGuiElement("image", 8 + w / 2 - 18, bsy - topSize * 3 - 156, 36, 36, appInside)
	sightexports.sGui:setImageFile(icon, loadedTextures["files/icons/settings.png"])
	sightexports.sGui:setGuiBoundingBox(icon, bbox)
	sightexports.sGui:setGuiHoverable(icon, true)
	sightexports.sGui:setClickEvent(icon, "openSightEats")
	local label = sightexports.sGui:createGuiElement("label", 8, bsy - topSize * 3 - 156 + 36, w, 16, appInside)
	sightexports.sGui:setLabelAlignment(label, "center", "center")
	sightexports.sGui:setLabelText(label, "SightEats")
	sightexports.sGui:setLabelShadow(label, {
	0,
	0,
	0,
	175
	}, 1, 1)
	sightexports.sGui:setLabelFont(label, "10/BebasNeueRegular.otf")
	sightexports.sGui:setGuiBoundingBox(label, bbox)
	sightexports.sGui:setGuiHoverable(label, true)
	]]
	
	local bbox = sightexports.sGui:createGuiElement("null", 8, bsy - topSize * 2.5 - 104, w, 52, appInside)
	local icon = sightexports.sGui:createGuiElement("image", 8 + w / 2 - 18, bsy - topSize * 2.5 - 104, 36, 36, appInside)
	sightexports.sGui:setImageFile(icon, loadedTextures["files/icons/settings.png"])
	sightexports.sGui:setGuiBoundingBox(icon, bbox)
	sightexports.sGui:setGuiHoverable(icon, true)
	sightexports.sGui:setClickEvent(icon, "openSettings")
	local label = sightexports.sGui:createGuiElement("label", 8, bsy - topSize * 2.5 - 104 + 36, w, 16, appInside)
	sightexports.sGui:setLabelAlignment(label, "center", "center")
	sightexports.sGui:setLabelText(label, "Beállítások")
	sightexports.sGui:setLabelShadow(label, {
		0,
		0,
		0,
		175
	}, 1, 1)
	sightexports.sGui:setLabelFont(label, "10/BebasNeueRegular.otf")
	sightexports.sGui:setGuiBoundingBox(label, bbox)
	sightexports.sGui:setGuiHoverable(label, true)
	local bbox = sightexports.sGui:createGuiElement("null", 8 + w, bsy - topSize * 2.5 - 104, w, 52, appInside)
	local icon = sightexports.sGui:createGuiElement("image", 8 + w / 2 + w - 18, bsy - topSize * 2.5 - 104, 36, 36, appInside)
	sightexports.sGui:setImageFile(icon, loadedTextures["files/icons/calculator.png"])
	sightexports.sGui:setGuiBoundingBox(icon, bbox)
	sightexports.sGui:setGuiHoverable(icon, true)
	sightexports.sGui:setClickEvent(icon, "openCalculator")
	local label = sightexports.sGui:createGuiElement("label", 8 + w, bsy - topSize * 2.5 - 104 + 36, w, 16, appInside)
	sightexports.sGui:setLabelAlignment(label, "center", "center")
	sightexports.sGui:setLabelText(label, "Számológép")
	sightexports.sGui:setLabelShadow(label, {
		0,
		0,
		0,
		175
	}, 1, 1)
	sightexports.sGui:setLabelFont(label, "10/BebasNeueRegular.otf")
	sightexports.sGui:setGuiBoundingBox(label, bbox)
	sightexports.sGui:setGuiHoverable(label, true)
	local bbox = sightexports.sGui:createGuiElement("null", 8 + w * 2, bsy - topSize * 2.5 - 104, w, 52, appInside)
	local icon = sightexports.sGui:createGuiElement("image", 8 + w / 2 + w * 2 - 18, bsy - topSize * 2.5 - 104, 36, 36, appInside)
	sightexports.sGui:setImageFile(icon, loadedTextures["files/icons/ad.png"])
	sightexports.sGui:setGuiBoundingBox(icon, bbox)
	sightexports.sGui:setGuiHoverable(icon, true)
	sightexports.sGui:setClickEvent(icon, "openAds")
	local label = sightexports.sGui:createGuiElement("label", 8 + w * 2, bsy - topSize * 2.5 - 104 + 36, w, 16, appInside)
	sightexports.sGui:setLabelAlignment(label, "center", "center")
	sightexports.sGui:setLabelText(label, "Hirdetés")
	sightexports.sGui:setLabelShadow(label, {
		0,
		0,
		0,
		175
	}, 1, 1)
	sightexports.sGui:setLabelFont(label, "10/BebasNeueRegular.otf")
	sightexports.sGui:setGuiBoundingBox(label, bbox)
	sightexports.sGui:setGuiHoverable(label, true)
	local bbox = sightexports.sGui:createGuiElement("null", 8 + w * 3, bsy - topSize * 2.5 - 104, w, 52, appInside)
	local icon = sightexports.sGui:createGuiElement("image", 8 + w / 2 + w * 3 - 18, bsy - topSize * 2.5 - 104, 36, 36, appInside)
	sightexports.sGui:setImageFile(icon, loadedTextures["files/icons/sightnion.png"])
	sightexports.sGui:setGuiBoundingBox(icon, bbox)
	sightexports.sGui:setGuiHoverable(icon, true)
	sightexports.sGui:setClickEvent(icon, "opensightNion")
	local label = sightexports.sGui:createGuiElement("label", 8 + w * 3, bsy - topSize * 2.5 - 104 + 36, w, 16, appInside)
	sightexports.sGui:setLabelAlignment(label, "center", "center")
	sightexports.sGui:setLabelText(label, "SightNion")
	sightexports.sGui:setLabelShadow(label, {
		0,
		0,
		0,
		175
	}, 1, 1)
	sightexports.sGui:setLabelFont(label, "10/BebasNeueRegular.otf")
	sightexports.sGui:setGuiBoundingBox(label, bbox)
	sightexports.sGui:setGuiHoverable(label, true)
	generateBottom()
	bringBackFront()
end
function appScreens.locked()
	local rt = getRealTime()
	local tmp = string.format("%02d:%02d", rt.hour, rt.minute)
	appInside = sightexports.sGui:createGuiElement("null", 0, 0, bsx, bsy, mobileBackground)
	local rect = sightexports.sGui:createGuiElement("rectangle", 0, 0, bsx, bsy, appInside)
	sightexports.sGui:setGuiBackground(rect, "solid", {
		0,
		0,
		0,
		75
	})
	local h = sightexports.sGui:getFontHeight("40/BebasNeueLight.otf")
	local label = sightexports.sGui:createGuiElement("label", 0, bsy / 6, bsx, bsy / 6, appInside)
	sightexports.sGui:setLabelAlignment(label, "center", "center")
	sightexports.sGui:setLabelText(label, tmp)
	sightexports.sGui:setLabelFont(label, "40/BebasNeueLight.otf")
	timeLabel = label
	local label = sightexports.sGui:createGuiElement("label", 0, bsy / 6 + bsy / 6 / 2 + h / 2, bsx, h, appInside)
	sightexports.sGui:setLabelAlignment(label, "center", "top")
	local time = getRealTime()
	local date = string.format("%04d. %02d. %02d.", time.year + 1900, time.month + 1, time.monthday)
	sightexports.sGui:setLabelText(label, date)
	sightexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
	local icon = sightexports.sGui:createGuiElement("image", bsx / 2 - (bsx / 5 + 32) / 2, bsy / 6 * 4.5 - 16, bsx / 5 + 32, bsx / 5 + 32, appInside)
	sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("circle", bsx / 5 + 32))
	sightexports.sGui:setImageColor(icon, {
		0,
		0,
		0,
		125
	})
	sightexports.sGui:setGuiHoverable(icon, true)
	sightexports.sGui:setGuiHover(icon, "none", {
		255,
		255,
		255,
		125
	})
	local icon2 = sightexports.sGui:createGuiElement("image", bsx / 2 - bsx / 5 / 2, bsy / 6 * 4.5, bsx / 5, bsx / 5, appInside)
	sightexports.sGui:setImageFile(icon2, sightexports.sGui:getFaIconFilename("fingerprint", bsx / 5))
	sightexports.sGui:setGuiHoverable(icon2, true)
	sightexports.sGui:setGuiHover(icon2, "none", {
		0,
		0,
		0,
		255
	})
	sightexports.sGui:setGuiBoundingBox(icon, icon2)
	sightexports.sGui:setClickEvent(icon, "backToHome")
	bringBackFront()
end
local movingPhone = false
function onClientCursorMove(rx, ry, cx, cy)
	if movingPhone then
		if isCursorShowing() then
			x = math.max(0 - sx / 2, math.min(screenX - sx / 2, movingPhone[1] + cx - movingPhone[3]))
			y = math.max(0 - sy / 2, math.min(screenY - sy / 2, movingPhone[2] + cy - movingPhone[4]))
			movingPhone[5] = x
			movingPhone[6] = y
			sightexports.sGui:setGuiPosition(mobileBackground, x + math.floor((sx - bsx) / 2), y + math.floor((sy - bsy) / 2))
			sightexports.sGui:setGuiPosition(mobileFrame, x, y)
		else
			local x, y = tonumber(movingPhone[5]), tonumber(movingPhone[6])
			if origFE("!mobile_pos.sight") then
				origFD("!mobile_pos.sight")
			end
			if x and y then
				local file = origFC("!mobile_pos.sight")
				fileWrite(file, x .. "," .. y)
				fileClose(file)
			end
			movingPhone = false
		end
	end
end
function onClientClick(button, state, cx, cy)
	if button ~= "left" then
		return
	end
	if state == "down" then
		if sightexports.sGui:getDDSPreview() or getElementData(localPlayer, "inventoryState") then
			return
		end
		local x2, y2 = x + math.floor((sx - bsx) / 2), y + math.floor((sy - bsy) / 2)
		if not (cx > x2 and cx < x2 + bsx and cy > y2) or not (cy < y2 + bsy) then
			movingPhone = {
				x,
				y,
				cx,
				cy
			}
		end
	elseif state == "up" then
		if movingPhone then
			local x, y = tonumber(movingPhone[5]), tonumber(movingPhone[6])
			if origFE("!mobile_pos.sight") then
				origFD("!mobile_pos.sight")
			end
			if x and y then
				local file = origFC("!mobile_pos.sight")
				fileWrite(file, x .. "," .. y)
				fileClose(file)
			end
		end
		movingPhone = false
	end
end
currentMobileNumber = false
mobileState = false
function deleteMobile(create)
	if mobileState then
		cancelDial(true)
		if appCloses[currentPhoneScreen] then
			appCloses[currentPhoneScreen](true)
		end
		topExpandedElements = false
		soundIcons = {}
		vibrationIcons = {}
		locationIcons = {}
		voiceIcons = {}
		if topNoti then
			topNoti[1] = false
		end
		currentMobileNumber = false
		mobileState = false
		currentPhoneScreen = false
		sightexports.sGui:deleteGuiElement(mobileBackground)
		sightexports.sGui:deleteGuiElement(mobileFrame)
		mobileBackground = nil
		mobileFrame = nil
		mobileScreen = nil
		appInside = false
		topRect = false
		topLabel = false
		topLabel2 = false
		topIcons = {}
		removeEventHandler("onClientRender", getRootElement(), renderMobile, true, "low-999999")
		removeEventHandler("onClientCursorMove", getRootElement(), onClientCursorMove)
		removeEventHandler("onClientClick", getRootElement(), onClientClick)
		if not create then
			setElementData(localPlayer, "mobile", nil)
		end
	end
end
function getMobileState()
	return mobileState
end
function createMobile()
	if mobileState then
		deleteMobile(true)
	end
	setElementData(localPlayer, "mobile", 1)
	currentPhoneScreen = "locked"
	if callStatus and callStatus[3] == "incoming" then
		currentPhoneScreen = "in_call"
	end
	addEventHandler("onClientRender", getRootElement(), renderMobile, true, "low-999999")
	mobileState = true
	movingPhone = false
	processContacts()
	mobileBackground = sightexports.sGui:createGuiElement("image", x + math.floor((sx - bsx) / 2), y + math.floor((sy - bsy) / 2), bsx, bsy)
	sightexports.sGui:setDisableClickSound(mobileBackground, false, true)
	if customBackground and currentBackground == -1 then
		sightexports.sGui:setImageDDS(mobileBackground, ":sMobile/!mobile_sight/bcg.dds", "dxt3", false)
	else
		sightexports.sGui:setImageFile(mobileBackground, loadedTextures["files/bcg/" .. currentBackground .. ".png"])
	end
	createTop()
	mobileFrame = sightexports.sGui:createGuiElement("image", x, y, sx, sy)
	sightexports.sGui:setImageFile(mobileFrame, loadedTextures["files/img/phone2x.png"])
	mobileScreen = sightexports.sGui:createGuiElement("image", 0, 0, sx, sy, mobileFrame)
	sightexports.sGui:setImageFile(mobileScreen, loadedTextures["files/img/phoneglass.png"])
	appScreens[currentPhoneScreen]()
	addEventHandler("onClientCursorMove", getRootElement(), onClientCursorMove)
	addEventHandler("onClientClick", getRootElement(), onClientClick)
end
local lastNotiSound = {}
addEvent("notiSoundForPlayer", true)
addEventHandler("notiSoundForPlayer", getRootElement(), function(num, vib)
	if isElement(source) and isElementStreamedIn(source) and source ~= localPlayer then
		local x, y, z = getElementPosition(source)
		if getTickCount() - (lastNotiSound[source] or 0) < 500 then
			return
		end
		lastNotiSound[source] = getTickCount()
		if num then
			local sound = playSound3D("files/noti/" .. num .. ".wav", x, y, z)
			attachElements(sound, source)
			setElementDimension(sound, getElementDimension(source))
			setElementInterior(sound, getElementInterior(source))
		end
		if vib then
			local sound = playSound3D("files/noti/vib.wav", x, y, z)
			attachElements(sound, source)
			setElementDimension(sound, getElementDimension(source))
			setElementInterior(sound, getElementInterior(source))
		end
	end
end)
addEvent("callSoundForPlayer", true)
addEventHandler("callSoundForPlayer", getRootElement(), function(num, vib)
	if isElement(source) and (isElementStreamedIn(source) or not num) and source ~= localPlayer then
		if isElement(callSounds[source]) then
			destroyElement(callSounds[source])
		end
		callSounds[source] = nil
		if isElement(vibrateSounds[source]) then
			destroyElement(vibrateSounds[source])
		end
		vibrateSounds[source] = nil
		if num then
			local x, y, z = getElementPosition(source)
			if tonumber(num) then
				callSounds[source] = playSound3D("files/call/ringtone/" .. num .. ".wav", x, y, z, true)
				attachElements(callSounds[source], source)
				setElementDimension(callSounds[source], getElementDimension(source))
				setElementInterior(callSounds[source], getElementInterior(source))
			end
			if vib then
				vibrateSounds[source] = playSound3D("files/call/vib.wav", x, y, z, true)
				attachElements(vibrateSounds[source], source)
				setElementDimension(vibrateSounds[source], getElementDimension(source))
				setElementInterior(vibrateSounds[source], getElementInterior(source))
			end
		end
	end
end)
addEventHandler("onClientElementStreamOut", getRootElement(), function()
	if source ~= localPlayer then
		if isElement(callSounds[source]) then
			setElementDimension(callSounds[source], getElementDimension(source))
			setElementInterior(callSounds[source], getElementInterior(source))
		end
		if isElement(vibrateSounds[source]) then
			setElementDimension(vibrateSounds[source], getElementDimension(source))
			setElementInterior(vibrateSounds[source], getElementInterior(source))
		end
	end
end)
addEventHandler("onClientPlayerQuit", getRootElement(), function()
	if isElement(callSounds[source]) then
		destroyElement(callSounds[source])
	end
	callSounds[source] = nil
	if isElement(vibrateSounds[source]) then
		destroyElement(vibrateSounds[source])
	end
	vibrateSounds[source] = nil
end)
addEvent("openPhone", true)
addEventHandler("openPhone", getRootElement(), function(num, noti, ringtone, sound, vibration, location, voice)
	currentMobileNumber = num
	soundState = sound
	vibrationState = vibration
	locationState = location
	voiceState = voice
	currentSound.noti = noti
	currentSound.ringtone = ringtone
	createMobile()
end)
addEvent("closePhone", true)
addEventHandler("closePhone", getRootElement(), function(num)
	deleteMobile()
end)
function switchAppScreen(new, force, delF)
	if currentPhoneScreen ~= new or force then
		if soundState and clickSoundState then
			playSound("files/click.wav")
		end
		if appCloses[currentPhoneScreen] then
			appCloses[currentPhoneScreen](delF)
		end
		if appInside then
			sightexports.sGui:deleteGuiElement(appInside)
		end
		timeLabel = false
		local was = currentPhoneScreen
		currentPhoneScreen = new
		if inCallScreens[was] and was ~= new then
			createTop()
		end
		appScreens[currentPhoneScreen]()
	end
end
addEvent("backToHome", false)
addEventHandler("backToHome", getRootElement(), function()
	switchAppScreen("home")
end)
addEvent("openAds", false)
addEventHandler("openAds", getRootElement(), function()
	switchAppScreen("ads")
end)
addEvent("openAdsEx", false)
addEventHandler("openAdsEx", getRootElement(), function()
	switchAppScreen("ads")
end)
addEvent("openCalculator", false)
addEventHandler("openCalculator", getRootElement(), function()
	switchAppScreen("calculator")
end)
addEvent("openGallery", false)
addEventHandler("openGallery", getRootElement(), function()
	gallerySelecting = false
	switchAppScreen("gallery", true)
end)
addEvent("openGalleryFromCamera", false)
addEventHandler("openGalleryFromCamera", getRootElement(), function()
	galleryFromCamera = true
	gallerySelecting = false
	selectedGalleryCategory = "camera"
	switchAppScreen("gallery")
end)
addEvent("openGalleryForSettings", false)
addEventHandler("openGalleryForSettings", getRootElement(), function()
	gallerySelecting = "settings"
	switchAppScreen("gallery")
end)
addEvent("openGalleryForContact", false)
addEventHandler("openGalleryForContact", getRootElement(), function()
	gallerySelecting = "contacts"
	switchAppScreen("gallery")
end)
addEvent("openGalleryEx", false)
addEventHandler("openGalleryEx", getRootElement(), function()
	galleryFromCamera = false
	selectedGalleryCategory = false
	switchAppScreen("gallery", true)
end)
addEvent("openGalleryForAd", false)
addEventHandler("openGalleryForAd", getRootElement(), function(button, state, absoluteX, absoluteY, el)
	if el == newAdBigPic then
		selectingAdPhoto = 1
	else
		for i = 1, #newAdPics do
			if el == newAdPics[i] then
				selectingAdPhoto = i + 1
				break
			end
		end
	end
	if selectingAdPhoto then
		gallerySelecting = "ad"
		switchAppScreen("gallery")
	end
end)

addEvent("openSightEats", false)
addEventHandler("openSightEats", getRootElement(), function()
	switchAppScreen("sighteats")
end)

addEvent("openSettings", false)
addEventHandler("openSettings", getRootElement(), function()
	switchAppScreen("settings")
end)

r60_0 = false
local r61_0 = false
local r62_0 = false
local r63_0 = false
local r64_0 = 0
local r65_0 = 0

function appScreens.forex()
	-- line: [4046, 4270] id: 81
	appInside = sightexports.sGui:createGuiElement("null", 0, 0, bsx, bsy, mobileBackground)
	sightexports.sGui:setGuiBackground(sightexports.sGui:createGuiElement("rectangle", 0, 0, bsx, bsy, appInside), "solid", {
		255,
		255,
		255
	})
	local r1_81 = math.floor((bsy - topSize * 2.5 - 32 - 6) / 12)
	local r2_81 = bsy - topSize * 2.5 - r1_81 * 12 - 6
	sightexports.sGui:setGuiBackground(sightexports.sGui:createGuiElement("rectangle", 0, 0, bsx, r2_81 + topSize, appInside), "solid", blue)
	local r4_81 = sightexports.sGui:createGuiElement("label", 8, topSize, bsx - 16, r2_81, appInside)
	sightexports.sGui:setLabelFont(r4_81, "11/Ubuntu-R.ttf")
	sightexports.sGui:setLabelAlignment(r4_81, "center", "center")
	sightexports.sGui:setLabelColor(r4_81, "#ffffff")
	sightexports.sGui:setLabelText(r4_81, "SIGHTREX Trading")
	sightlangCondHandl3(true)
	local r5_81 = sightexports.sGui:getFontHeight("11/Ubuntu-R.ttf")
	local r6_81 = math.floor(r5_81 * 0.75 / 2) * 2
	local r7_81 = r2_81 + topSize
	if r60_0 then
		sightlangCondHandl2(false)
		sightexports.sTrading:setForexSubscription(r60_0, "phoneApp")
		local r8_81 = sightexports.sGui:createGuiElement("rectangle", 8, r7_81, r5_81, r1_81 - 1, appInside)
		sightexports.sGui:setGuiBackground(r8_81, "solid", "#ffffff")
		sightexports.sGui:setGuiHover(r8_81, "none", false, false, true)
		sightexports.sGui:setClickEvent(r8_81, "setWidgetIndex")
		local r9_81 = sightexports.sGui:createGuiElement("image", 8 + r5_81 / 2 - r6_81 / 2, r7_81 + r1_81 / 2 - r6_81 / 2, r6_81, r6_81, appInside)
		sightexports.sGui:setImageColor(r9_81, "#000000")
		local r10_81 = sightexports.sGui:createGuiElement("label", 8 + r5_81 + 4, r7_81, bsx - 16, r1_81, appInside)
		sightexports.sGui:setLabelFont(r10_81, "11/Ubuntu-R.ttf")
		sightexports.sGui:setLabelAlignment(r10_81, "left", "center")
		sightexports.sGui:setLabelColor(r10_81, "#000000")
		sightexports.sGui:setLabelText(r10_81, r60_0)
		local r11_81 = sightexports.sGui:createGuiElement("label", 8, r7_81, bsx - 16, r1_81, appInside)
		sightexports.sGui:setLabelFont(r11_81, "11/Ubuntu-R.ttf")
		sightexports.sGui:setLabelAlignment(r11_81, "right", "center")
		sightexports.sGui:setLabelColor(r11_81, "#000000")
		local r12_81 = sightexports.sGui:createGuiElement("image", 0, r7_81 + r1_81 / 2 - r6_81 / 2, r6_81, r6_81, appInside)
		sightexports.sGui:setImageFile(r12_81, ":sMobile/files/img/tri.png")
		sightexports.sGui:setGuiRenderDisabled(r12_81, true)
		r61_0 = {
			r10_81,
			r11_81,
			r12_81,
			r9_81,
			r8_81
		}
		r7_81 = r7_81 + r1_81
		sightexports.sGui:setGuiHrColor(sightexports.sGui:createGuiElement("hr", 8, r7_81 - 1, bsx - 16, 1, appInside), grey2, grey2)
		r1_81 = r1_81 * 11 / 3
		local r14_81 = (bsx - 32) / 5
		local r15_81 = sightexports.sGui:getFontHeight("10/Ubuntu-B.ttf") + 6
		local r16_81 = 16
		local r17_81 = r7_81 + r1_81 - r15_81 * 4 / 2
		sightexports.sGui:setGuiBackground(sightexports.sGui:createGuiElement("rectangle", r16_81, r17_81, 1, r15_81 * 4, appInside), "solid", grey2)
		sightexports.sGui:setGuiBackground(sightexports.sGui:createGuiElement("rectangle", r16_81 + r14_81, r17_81, 1, r15_81 * 4, appInside), "solid", grey2)
		sightexports.sGui:setGuiBackground(sightexports.sGui:createGuiElement("rectangle", r16_81 + r14_81 * 3, r17_81, 1, r15_81 * 4, appInside), "solid", grey2)
		sightexports.sGui:setGuiBackground(sightexports.sGui:createGuiElement("rectangle", r16_81 + r14_81 * 5, r17_81, 1, r15_81 * 4, appInside), "solid", grey2)
		for r25_81 = 1, 5, 1 do
			sightexports.sGui:setGuiBackground(sightexports.sGui:createGuiElement("rectangle", r16_81, r17_81 + (r25_81 - 1) * r15_81, r14_81 * 5, 1, appInside), "solid", grey2)
		end
		local r22_81 = sightexports.sGui:createGuiElement("label", r16_81 + r14_81, r17_81, r14_81 * 2, r15_81, appInside)
		sightexports.sGui:setLabelFont(r22_81, "10/Ubuntu-B.ttf")
		sightexports.sGui:setLabelAlignment(r22_81, "center", "center")
		sightexports.sGui:setLabelColor(r22_81, "#000000")
		sightexports.sGui:setLabelText(r22_81, "Avg")
		local r23_81 = sightexports.sGui:createGuiElement("label", r16_81 + r14_81 * 3, r17_81, r14_81 * 2, r15_81, appInside)
		sightexports.sGui:setLabelFont(r23_81, "10/Ubuntu-B.ttf")
		sightexports.sGui:setLabelAlignment(r23_81, "center", "center")
		sightexports.sGui:setLabelColor(r23_81, "#000000")
		sightexports.sGui:setLabelText(r23_81, "Med")
		local r24_81 = {}
		for r28_81 = 1, 3, 1 do
			r17_81 = r17_81 + r15_81
			local r29_81 = sightexports.sGui:createGuiElement("label", r16_81, r17_81, r14_81, r15_81, appInside)
			sightexports.sGui:setLabelFont(r29_81, "10/Ubuntu-B.ttf")
			sightexports.sGui:setLabelAlignment(r29_81, "center", "center")
			sightexports.sGui:setLabelColor(r29_81, "#000000")
			sightexports.sGui:setLabelText(r29_81, r28_81 * 12 .. "h")
			local r30_81 = sightexports.sGui:createGuiElement("label", r16_81 + r14_81, r17_81, r14_81 * 2, r15_81, appInside)
			sightexports.sGui:setLabelFont(r30_81, "10/Ubuntu-R.ttf")
			sightexports.sGui:setLabelAlignment(r30_81, "center", "center")
			sightexports.sGui:setLabelColor(r30_81, "#000000")
			local r31_81 = sightexports.sGui:createGuiElement("label", r16_81 + r14_81 * 3, r17_81, r14_81 * 2, r15_81, appInside)
			sightexports.sGui:setLabelFont(r31_81, "10/Ubuntu-R.ttf")
			sightexports.sGui:setLabelAlignment(r31_81, "center", "center")
			sightexports.sGui:setLabelColor(r31_81, "#000000")
			r24_81[r28_81] = {
				r30_81,
				r31_81
			}
		end
		table.insert(r61_0, r24_81)
		r7_81 = r7_81 + r1_81 * 2
		r1_81 = r1_81 / 9
		for r28_81 = 1, 9, 1 do
			sightexports.sGui:setGuiBackground(sightexports.sGui:createGuiElement("rectangle", 8, r7_81 - 1, bsx - 16, 1, appInside), "solid", grey2)
			r7_81 = r7_81 + r1_81
		end
		sightexports.sGui:setGuiBackground(sightexports.sGui:createGuiElement("rectangle", 8, r7_81 - 1, bsx - 16, 1, appInside), "solid", grey2)
		local r26_81 = sightexports.sGui:createGuiElement("label", 8, r7_81 - r1_81 * 9, 0, r1_81 * 9, appInside)
		sightexports.sGui:setLabelFont(r26_81, "9/Ubuntu-R.ttf")
		sightexports.sGui:setLabelAlignment(r26_81, "left", "top")
		sightexports.sGui:setLabelColor(r26_81, grey1)
		local r27_81 = sightexports.sGui:createGuiElement("label", 8, r7_81 - r1_81 * 9, 0, r1_81 * 9, appInside)
		sightexports.sGui:setLabelFont(r27_81, "9/Ubuntu-R.ttf")
		sightexports.sGui:setLabelAlignment(r27_81, "left", "center")
		sightexports.sGui:setLabelColor(r27_81, grey1)
		local r28_81 = sightexports.sGui:createGuiElement("label", 8, r7_81 - r1_81 * 9, 0, r1_81 * 9, appInside)
		sightexports.sGui:setLabelFont(r28_81, "9/Ubuntu-R.ttf")
		sightexports.sGui:setLabelAlignment(r28_81, "left", "bottom")
		sightexports.sGui:setLabelColor(r28_81, grey1)
		table.insert(r61_0, r26_81)
		table.insert(r61_0, r27_81)
		table.insert(r61_0, r28_81)
		table.insert(r61_0, {})
		onAppForexUpdate()
	else
		r61_0 = {}
		sightlangCondHandl2(true)
		sightexports.sTrading:setForexSubscription("all", "phoneApp")
		r62_0 = sightexports.sTrading:getIndexList()
		for r11_81 = 1, 12, 1 do
			local r12_81 = sightexports.sGui:createGuiElement("rectangle", 8, r7_81, r5_81, r1_81 - 1, appInside)
			sightexports.sGui:setGuiBackground(r12_81, "solid", "#ffffff")
			sightexports.sGui:setGuiHover(r12_81, "none", false, false, true)
			sightexports.sGui:setClickEvent(r12_81, "setWidgetIndex")
			local r13_81 = sightexports.sGui:createGuiElement("rectangle", 8 + r5_81, r7_81, bsx - 16 - r5_81, r1_81 - 1, appInside)
			sightexports.sGui:setGuiBackground(r13_81, "solid", "#ffffff")
			sightexports.sGui:setGuiHover(r13_81, "none", false, false, true)
			sightexports.sGui:setClickEvent(r13_81, "openForexIndex")
			local r14_81 = sightexports.sGui:createGuiElement("image", 8 + r5_81 / 2 - r6_81 / 2, r7_81 + r1_81 / 2 - r6_81 / 2, r6_81, r6_81, appInside)
			sightexports.sGui:setImageColor(r14_81, "#000000")
			local r15_81 = sightexports.sGui:createGuiElement("label", 8 + r5_81 + 4, r7_81, bsx - 16 - 3 - 8, r1_81, appInside)
			sightexports.sGui:setLabelFont(r15_81, "11/Ubuntu-R.ttf")
			sightexports.sGui:setLabelAlignment(r15_81, "left", "center")
			sightexports.sGui:setLabelColor(r15_81, "#000000")
			local r16_81 = sightexports.sGui:createGuiElement("label", 8, r7_81, bsx - 16 - 3 - 8, r1_81, appInside)
			sightexports.sGui:setLabelFont(r16_81, "11/Ubuntu-R.ttf")
			sightexports.sGui:setLabelAlignment(r16_81, "right", "center")
			sightexports.sGui:setLabelColor(r16_81, "#000000")
			local r17_81 = sightexports.sGui:createGuiElement("image", 0, r7_81 + r1_81 / 2 - r6_81 / 2, r6_81, r6_81, appInside)
			sightexports.sGui:setImageFile(r17_81, ":sMobile/files/img/tri.png")
			sightexports.sGui:setGuiRenderDisabled(r17_81, true)
			r61_0[r11_81] = {
				r15_81,
				r16_81,
				r17_81,
				r14_81,
				r12_81,
				r13_81
			}
			r7_81 = r7_81 + r1_81
			if r11_81 < 12 then
				sightexports.sGui:setGuiHrColor(sightexports.sGui:createGuiElement("hr", 8, r7_81 - 1, bsx - 16 - 3 - 8, 1, appInside), grey2, grey2)
			end
		end
		local r8_81 = sightexports.sGui:createGuiElement("rectangle", bsx - 8 - 3, r2_81 + topSize + 4, 3, r1_81 * 12 - 8, appInside)
		sightexports.sGui:setGuiBackground(r8_81, "solid", grey1)
		r65_0 = (r1_81 * 12 - 8) / math.max(1, (#r62_0 - 12 + 1))
		r63_0 = sightexports.sGui:createGuiElement("rectangle", 0, 0, 3, r65_0, r8_81)
		sightexports.sGui:setGuiBackground(r63_0, "solid", grey3)
		refreshForexAppList()
	end
	generateBottom(true, r60_0 and "openForexIndex", true)
	bringBackFront()
end

addEvent("openForexIndex", false)
addEventHandler("openForexIndex", getRootElement(), function(r0_79, r1_79, r2_79, r3_79, r4_79, r5_79)
	r60_0 = r5_79
	switchAppScreen("forex", true)
end)

function forexAppScrollHandler(cond5)
	-- line: [3824, 3836] id: 75
	if cond5 == "mouse_wheel_up" and r64_0 > 0 then
		r64_0 = r64_0 - 1
		refreshForexAppList()
	elseif cond5 == "mouse_wheel_down" and r64_0 < #r62_0 - 12 then
		r64_0 = r64_0 + 1
		refreshForexAppList()
	end
end

function onAppForexUpdate()
	-- line: [3838, 3969] id: 76
	local r1_76 = math.floor(sightexports.sGui:getFontHeight("11/Ubuntu-R.ttf") * 0.75 / 2) * 2
	local r18_76 = nil	-- notice: implicit variable refs by block#[48, 51]
	if r60_0 then
		local r2_76 = r60_0
		local r3_76, r4_76, r5_76, r6_76, r7_76, r8_76, r9_76, r10_76, r11_76, r12_76 = unpack(r61_0)
		for r16_76 = 1, #r12_76, 1 do
			if r12_76[r16_76] then
				sightexports.sGui:deleteGuiElement(r12_76[r16_76])
			end
			r12_76[r16_76] = nil
		end
		local r13_76 = sightexports.sTrading:getStats(r2_76)
		if r13_76 then
			for r17_76 = 1, #r8_76, 1 do
				sightexports.sGui:setGuiRenderDisabled(r8_76[r17_76][1], false)
				sightexports.sGui:setGuiRenderDisabled(r8_76[r17_76][2], false)
				r18_76 = r13_76[r17_76][1]
				if r18_76 ~= r13_76[r17_76][1] then
					sightexports.sGui:setLabelText(r8_76[r17_76][1], "-")
					sightexports.sGui:setLabelText(r8_76[r17_76][2], "-")
				else
					sightexports.sGui:setLabelText(r8_76[r17_76][1], sightexports.sGui:thousandsStepper(math.floor(r13_76[r17_76][1])) .. " $")
					sightexports.sGui:setLabelText(r8_76[r17_76][2], sightexports.sGui:thousandsStepper(math.floor(r13_76[r17_76][2])) .. " $")
				end
			end
		else
			for r17_76 = 1, #r8_76, 1 do
				sightexports.sGui:setGuiRenderDisabled(r8_76[r17_76][1], true)
				sightexports.sGui:setGuiRenderDisabled(r8_76[r17_76][2], true)
			end
		end
		local r14_76 = sightexports.sTrading:getHistory(r2_76)
		if r14_76 and 1 < #r14_76 then
			local r15_76, r16_76 = sightexports.sGui:getGuiPosition(r9_76)
			local r17_76, r18_76 = sightexports.sGui:getGuiSize(r9_76)
			local r19_76 = r14_76[1]
			r20_76 = r14_76[1]
			for r24_76 = 2, #r14_76, 1 do
				r19_76 = math.min(r19_76, r14_76[r24_76])
				r20_76 = math.max(r20_76, r14_76[r24_76])
			end
			r20_76 = r20_76 * 1.1
			r19_76 = r19_76 * 0.9
			sightexports.sGui:setGuiRenderDisabled(r9_76, false)
			sightexports.sGui:setGuiRenderDisabled(r10_76, false)
			sightexports.sGui:setGuiRenderDisabled(r11_76, false)
			sightexports.sGui:setLabelText(r9_76, sightexports.sGui:thousandsStepper(math.floor(r20_76 + 0.5)) .. " $")
			sightexports.sGui:setLabelText(r10_76, sightexports.sGui:thousandsStepper(math.floor((r20_76 + r19_76) / 2 + 0.5)) .. " $")
			sightexports.sGui:setLabelText(r11_76, sightexports.sGui:thousandsStepper(math.floor(r19_76 + 0.5)) .. " $")
			local r21_76 = (bsx - 16) / (#r14_76 - 1)
			local r22_76 = r16_76 + r18_76 - (r14_76[1] - r19_76) / (r20_76 - r19_76) * r18_76
			for r26_76 = 2, #r14_76, 1 do
				local r27_76 = r16_76 + r18_76 - (r14_76[r26_76] - r19_76) / (r20_76 - r19_76) * r18_76
				r12_76[r26_76] = sightexports.sGui:createGuiElement("line", r15_76 + r21_76 * (r26_76 - 2), r22_76, r21_76, r27_76 - r22_76, appInside)
				sightexports.sGui:setGuiBackground(r12_76[r26_76], "solid", blue)
				sightexports.sGui:setLineWidth(r12_76[r26_76], 2)
				r22_76 = r27_76
			end
		else
			sightexports.sGui:setGuiRenderDisabled(r9_76, true)
			sightexports.sGui:setGuiRenderDisabled(r10_76, true)
			sightexports.sGui:setGuiRenderDisabled(r11_76, true)
		end
		local r15_76 = sightexports.sTrading:getPrice(r2_76)
		if r15_76 then
			sightexports.sGui:setGuiRenderDisabled(r4_76, false)
			sightexports.sGui:setGuiRenderDisabled(r5_76, false)
			sightexports.sGui:setLabelText(r4_76, sightexports.sGui:thousandsStepper(math.floor(r15_76 + 0.5)) .. " $")
			local r16_76 = sightexports.sTrading:getTrend(r2_76)
			local r17_76 = sightexports.sGui
			local r19_76 = r5_76
			if r16_76 then
				r20_76 = green
			else
				r20_76 = red
			end
			r17_76:setImageColor(r19_76, r20_76)
			r17_76 = sightexports.sGui
			r19_76 = r5_76
			if r16_76 then
				r20_76 = 0
			else
				r20_76 = 180
			end
			r17_76:setImageRotation(r19_76, r20_76)
			sightexports.sGui:setGuiPosition(r5_76, bsx - 16 - sightexports.sGui:getLabelTextWidth(r4_76) - r1_76 + 4)
		else
			sightexports.sGui:setGuiRenderDisabled(r4_76, true)
			sightexports.sGui:setGuiRenderDisabled(r5_76, true)
		end
		sightexports.sGui:setGuiRenderDisabled(r6_76, false)
		local r16_76 = sightexports.sGui
		r18_76 = r6_76
		local r19_76 = sightexports.sGui
		local r21_76 = "star"
		local r22_76 = r1_76
		local r23_76 = currentForex
		if r23_76 == r2_76 then
			r23_76 = "solid"
		else
			r23_76 = "regular"
		end
		r16_76:setImageFile(r18_76, r19_76:getFaIconFilename(r21_76, r22_76, r23_76))
		sightexports.sGui:setClickArgument(r7_76, r2_76)
		r16_76 = sightexports.sGui
		r18_76 = r7_76
		r16_76:setGuiHoverable(r18_76, currentForex ~= r2_76)
	else
		for r5_76 = 1, #r61_0, 1 do
			local r6_76 = r62_0[r5_76 + r64_0]
			local r7_76, r8_76, r9_76, r10_76, r11_76, r12_76 = unpack(r61_0[r5_76])
			if r6_76 then
				local r13_76 = sightexports.sTrading:getPrice(r6_76)
				if r13_76 then
					sightexports.sGui:setGuiRenderDisabled(r8_76, false)
					sightexports.sGui:setGuiRenderDisabled(r9_76, false)
					sightexports.sGui:setLabelText(r8_76, sightexports.sGui:thousandsStepper(math.floor(r13_76 + 0.5)) .. " $")
					local r14_76 = sightexports.sTrading:getTrend(r6_76)
					local r15_76 = sightexports.sGui
					local r17_76 = r9_76
					if r14_76 then
						r18_76 = green
					else
						r18_76 = red
					end
					r15_76:setImageColor(r17_76, r18_76)
					r15_76 = sightexports.sGui
					r17_76 = r9_76
					if r14_76 then
						r18_76 = 0
					else
						r18_76 = 180
					end
					r15_76:setImageRotation(r17_76, r18_76)
					sightexports.sGui:setGuiPosition(r9_76, bsx - 16 - 3 - 8 - sightexports.sGui:getLabelTextWidth(r8_76) - r1_76 + 4)
				else
					sightexports.sGui:setGuiRenderDisabled(r8_76, true)
					sightexports.sGui:setGuiRenderDisabled(r9_76, true)
				end
			else
				sightexports.sGui:setGuiRenderDisabled(r8_76, true)
				sightexports.sGui:setGuiRenderDisabled(r9_76, true)
			end
		end
	end
end

function refreshForexAppList()
	-- line: [3971, 4003] id: 77
	local r1_77 = math.floor(sightexports.sGui:getFontHeight("11/Ubuntu-R.ttf") * 0.75 / 2) * 2
	for r5_77 = 1, #r61_0, 1 do
		local r6_77 = r62_0[r5_77 + r64_0]
		local r7_77, r8_77, r9_77, r10_77, r11_77, r12_77 = unpack(r61_0[r5_77])
		if r6_77 then
			sightexports.sGui:setGuiRenderDisabled(r7_77, false)
			sightexports.sGui:setLabelText(r7_77, r6_77)
			sightexports.sGui:setClickArgument(r11_77, r6_77)
			sightexports.sGui:setClickArgument(r12_77, r6_77)
			sightexports.sGui:setGuiRenderDisabled(r10_77, false)
			local r13_77 = sightexports.sGui
			local r15_77 = r10_77
			local r16_77 = sightexports.sGui
			local r18_77 = "star"
			local r19_77 = r1_77
			local r20_77 = currentForex
			if r20_77 == r6_77 then
				r20_77 = "solid"
			else
				r20_77 = "regular"
			end
			r13_77:setImageFile(r15_77, r16_77:getFaIconFilename(r18_77, r19_77, r20_77))
			sightexports.sGui:setGuiHoverable(r11_77, currentForex ~= r6_77)
			sightexports.sGui:setGuiHoverable(r12_77, true)
		else
			sightexports.sGui:setGuiRenderDisabled(r7_77, true)
			sightexports.sGui:setGuiRenderDisabled(r10_77, true)
			sightexports.sGui:setGuiHoverable(r11_77, false)
			sightexports.sGui:setGuiHoverable(r12_77, false)
		end
	end
	onAppForexUpdate()
	sightexports.sGui:setGuiPosition(r63_0, false, r65_0 * r64_0)
end

addEvent("setWidgetIndex", false)
addEventHandler("setWidgetIndex", getRootElement(), function(cond8, r1_78, r2_78, r3_78, r4_78, r5_78)
	-- line: [4007, 4026] id: 78
	currentForex = r5_78
	if fileExists("widgetindex.sight") then
		fileDelete("widgetindex.sight")
	end
	local r6_78 = fileCreate("widgetindex.sight")
	if r6_78 then
		fileWrite(r6_78, tostring(r5_78))
		fileClose(r6_78)
	end
	if r60_0 then
		onAppForexUpdate()
	else
		refreshForexAppList()
	end
end)

function appCloses.forex()
	sightexports.sTrading:setForexSubscription(false, "phoneApp")
	r61_0 = false
	r62_0 = false
	r63_0 = false
	sightlangCondHandl3(false)
	sightlangCondHandl2(false)
end

addEvent("openForexWidget", false)
addEventHandler("openForexWidget", getRootElement(), function()
	r60_0 = false
	switchAppScreen("forex")
end)

r69_0 = {}

function onHomeForexUpdate()
	-- line: [4284, 4350] id: 83
	local cond3 = sightexports.sTrading:getPrice(currentForex)
	local r1_83 = 0
	local r2_83 = 0
	for r6_83 = 1, #r69_0, 1 do
		if r69_0[r6_83] then
			sightexports.sGui:deleteGuiElement(r69_0[r6_83])
		end
		r69_0[r6_83] = nil
	end
	r69_0 = {}
	if cond3 then
		sightexports.sGui:setLabelText(priceLabel, sightexports.sGui:thousandsStepper(math.floor(cond3 + 0.5)) .. " $")
		r2_83 = math.floor(sightexports.sGui:getFontHeight("14/BebasNeueBold.otf") / 2)
		r1_83 = 49 - (sightexports.sGui:getLabelTextWidth(priceLabel) + r2_83 + 4) / 2
		sightexports.sGui:setGuiRenderDisabled(r68_0, false)
		local r5_83 = sightexports.sTrading:getTrend(currentForex)
		local r6_83 = sightexports.sGui
		local r8_83 = r68_0
		local r9_83 = nil	-- notice: implicit variable refs by block#[9, 12]
		if r5_83 then
			r9_83 = green
		else
			r9_83 = red
		end
		r6_83:setImageColor(r8_83, r9_83)
		r6_83 = sightexports.sGui
		r8_83 = r68_0
		if r5_83 then
			r9_83 = 0
		else
			r9_83 = 180
		end
		r6_83:setImageRotation(r8_83, r9_83)
		r6_83 = sightexports.sTrading:getHistory(currentForex)
		if r6_83 and 1 < #r6_83 then
			local r7_83 = r6_83[1]
			r8_83 = r6_83[1]
			for r12_83 = 2, #r6_83, 1 do
				r7_83 = math.min(r7_83, r6_83[r12_83])
				r8_83 = math.max(r8_83, r6_83[r12_83])
			end
			r8_83 = r8_83 * 1.1
			r7_83 = r7_83 * 0.9
			r9_83 = 115 / (#r6_83 - 1)
			local r10_83 = 60 - (r6_83[1] - r7_83) / (r8_83 - r7_83) * 56
			for r14_83 = 2, #r6_83, 1 do
				local r15_83 = 60 - (r6_83[r14_83] - r7_83) / (r8_83 - r7_83) * 56
				r69_0[r14_83] = sightexports.sGui:createGuiElement("line", 101 + r9_83 * (r14_83 - 2), r10_83, r9_83, r15_83 - r10_83, r66_0)
				sightexports.sGui:setGuiBackground(r69_0[r14_83], "solid", blue)
				r10_83 = r15_83
			end
		end
	else
		sightexports.sGui:setLabelText(priceLabel, "...")
		tw = sightexports.sGui:getLabelTextWidth(priceLabel)
		r1_83 = 49 - tw / 2
		sightexports.sGui:setGuiRenderDisabled(r68_0, true)
	end
	sightexports.sGui:setGuiPosition(priceLabel, r1_83 + r2_83 + 4)
	sightexports.sGui:setGuiPosition(r68_0, r1_83)
end

addEvent("openCamera", false)
addEventHandler("openCamera", getRootElement(), function()
	if callStatus then
		sightexports.sGui:showInfobox("e", "Hívás közben nem használhatod a kamerát!")
		return
	end
	if cameraLandscape then
		switchAppScreen("camera_landscape")
	else
		switchAppScreen("camera_portrait")
	end
end)
addEvent("previewCameraBig", false)
addEventHandler("previewCameraBig", getRootElement(), function()
	if isElement(cameraScreenSource) then
		local x, y, sx, sy
		if currentPhoneScreen == "camera_portrait" then
			local u = imageSizeY * (bsx / (bsy * 0.7))
			x, y = imageSizeX / 2 - u / 2, 0
			sx, sy = u, imageSizeY
		elseif currentPhoneScreen == "camera_landscape" then
			local u = imageSizeY * (bsy * 0.7 / bsx)
			x, y = imageSizeX / 2 - u / 2, 0
			sx, sy = u, imageSizeY
		end
		sightexports.sGui:setTexturePreview(cameraScreenSource, x, y, sx, sy, true)
	end
end)
addEvent("flipCamera", false)
addEventHandler("flipCamera", getRootElement(), function()
	if currentPhoneScreen == "camera_portrait" then
		switchAppScreen("camera_landscape", false, true)
	else
		switchAppScreen("camera_portrait", false, true)
	end
end)
addEvent("flipPhoto", false)
addEventHandler("flipPhoto", getRootElement(), function()
	if currentPhoneScreen == "photo" then
		switchAppScreen("photo_landscape")
	else
		switchAppScreen("photo")
	end
end)
notiAnimTime = 600
addEvent("closeExpandedTop", true)
addEventHandler("closeExpandedTop", getRootElement(), function()
	if not topExpandClose and getTickCount() - topExpanded > 1000 then
		topExpandClose = getTickCount()
		sightexports.sGui:fadeOut(topExpandedElements[5], 1000)
		sightexports.sGui:fadeOut(topExpandedElements[6], 1000)
		sightexports.sGui:fadeOut(topExpandedElements[7], 1000)
	end
end)
addEvent("expandTop", true)
addEventHandler("expandTop", getRootElement(), function()
	if not topExpanded then
		topExpanded = getTickCount()
		if topNoti then
			topNoti[5] = getTickCount() - notiAnimTime
			topNoti[7] = 600
		end
		expandTop()
		bringBackFront()
	end
end)
local vibration = false
local vibrationSound = false
local vibrationTimer = false
function vibratePhone()
	vibrationSound = playSound("files/call/vib.wav")
	vibration = getTickCount()
end
function startVibrate()
	endVibrate()
	vibratePhone()
	vibrationTimer = setTimer(vibratePhone, 1400, 0)
end
function endVibrate()
	if mobileState then
		sightexports.sGui:setGuiPosition(mobileBackground, x + math.floor((sx - bsx) / 2), y + math.floor((sy - bsy) / 2))
		sightexports.sGui:setGuiPosition(mobileFrame, x, y)
	end
	if isElement(vibrationSound) then
		destroyElement(vibrationSound)
	end
	vibrationSound = false
	if isTimer(vibrationTimer) then
		killTimer(vibrationTimer)
	end
	vibrationTimer = false
	vibration = false
end
function renderMobile()
	if vibration then
		local p = (getTickCount() - vibration) / 737
		if 1 < p then
			vibration = false
			vibrationSound = false
			p = 1
		end
		p = math.cos(p * 30 * math.pi)
		sightexports.sGui:setGuiPosition(mobileBackground, x + math.floor((sx - bsx) / 2) + 1 * p, y + math.floor((sy - bsy) / 2))
		sightexports.sGui:setGuiPosition(mobileFrame, x + 1 * p, y)
	end
	if smallVibration then
		local p = (getTickCount() - smallVibration) / 207
		if 1 < p then
			local p2 = (getTickCount() - (smallVibration + 293)) / 207
			if 1 < p2 then
				smallVibration = false
				sightexports.sGui:setGuiPosition(mobileBackground, x + math.floor((sx - bsx) / 2), y + math.floor((sy - bsy) / 2))
				sightexports.sGui:setGuiPosition(mobileFrame, x, y)
			else
				p = p2
			end
		end
		if 0 < p and p < 1 then
			p = math.cos(p * 30 * math.pi)
			sightexports.sGui:setGuiPosition(mobileBackground, x + math.floor((sx - bsx) / 2) + 1 * p, y + math.floor((sy - bsy) / 2))
			sightexports.sGui:setGuiPosition(mobileFrame, x + 1 * p, y)
		end
	end
	local now = getTickCount()
	if callStatus and dialerStatusLabel and callStatus[3] == "incall" then
		if voiceIcon then
			local l, r = getSoundLevelData(localPlayer)
			local lvl = 0
			if l and r then
				lvl = (l + r) / 65536
			elseif l then
				lvl = l / 32768
			elseif r then
				lvl = r / 32768
			end
			local a = math.min(1, lvl * 10)
			sightexports.sGui:setImageColor(voiceIcon, {
				12,
				156,
				93,
				255 * a
			})
		end
		local secs = math.floor((getTickCount() - callStatus[2]) / 1000)
		local mins = math.floor(secs / 60)
		local hours = math.floor(mins / 60)
		secs = secs - mins * 60
		mins = mins - hours * 60
		if 0 < hours then
			sightexports.sGui:setLabelText(dialerStatusLabel, string.format("%02d:%02d:%02d", hours, mins, secs))
		else
			sightexports.sGui:setLabelText(dialerStatusLabel, string.format("%02d:%02d", mins, secs))
		end
	end
	if topExpanded then
		local p = (now - topExpanded) / 1000
		if topExpandClose then
			p = 1 - (now - topExpandClose) / 1000
		end
		if 1 < p then
			p = 1
		end
		if p <= 0 then
			if topExpandedElements then
				sightexports.sGui:deleteGuiElement(topExpandedElements[1])
				for i = 1, #topExpandedElements[2] do
					sightexports.sGui:deleteGuiElement(topExpandedElements[2][i][1])
				end
				for i = 1, #topExpandedElements[8] do
					sightexports.sGui:deleteGuiElement(topExpandedElements[8][i][1])
				end
				sightexports.sGui:deleteGuiElement(topExpandedElements[5])
				sightexports.sGui:deleteGuiElement(topExpandedElements[6])
				sightexports.sGui:deleteGuiElement(topExpandedElements[7])
			end
			topExpanded = false
			topExpandClose = false
			topExpandedElements = false
			if callStatus and not inCallScreens[currentPhoneScreen] then
				createTop()
			end
		elseif topExpandedElements then
			p = getEasingValue(p, "InOutQuad")
			local w = (bsx - 16) / 4
			local w2 = math.floor(w * 0.5 / 2) * 2
			local w3 = math.floor(w * 0.35 / 2) * 2
			local eh = topSize + w + 8 + 4 + 68 * math.min(notiCount, 5) + 2
			sightexports.sGui:setGuiSize(topRect, false, topSize + (eh - topSize) * p)
			local col = {
				255 - 255 * p,
				255 - 255 * p,
				255 - 255 * p
			}
			for i = 1, #topIcons do
				sightexports.sGui:setImageColor(topIcons[i], col)
			end
			sightexports.sGui:setLabelColor(topLabel, col)
			sightexports.sGui:setLabelColor(topLabel2, col)
			sightexports.sGui:setGuiBackground(topRect, "solid", {
				255 * p,
				255 * p,
				255 * p,
				125 + 115 * p
			})
			local y = topSize - eh * (1 - p)
			local size = math.max(0, topSize + w + 8 - eh * (1 - p))
			sightexports.sGui:setGuiSize(topExpandedElements[1], false, size)
			local sy = topSize
			local ey = y + eh - topSize
			local ry = math.max(0, ey)
			local rsy = math.max(0, sy - (ry - ey))
			sightexports.sGui:setGuiPosition(topExpandedElements[5], false, ry)
			sightexports.sGui:setGuiSize(topExpandedElements[5], false, rsy)
			sightexports.sGui:setGuiHoverable(topExpandedElements[5], p == 1)
			sightexports.sGui:setGuiPosition(topExpandedElements[7], false, ry + rsy - 1)
			local sy = sightexports.sGui:getFontHeight("11/Ubuntu-R.ttf")
			local ey = y + eh - topSize / 2 - sy / 2
			local ry = math.max(0, ey)
			local rsy = math.max(0, sy - (ry - ey))
			sightexports.sGui:setGuiPosition(topExpandedElements[6], false, ry)
			sightexports.sGui:setGuiSize(topExpandedElements[6], false, rsy)
			y = y - topSize
			for i = 1, #topExpandedElements[2] do
				local ey = y + topExpandedElements[2][i][2]
				local sy = topExpandedElements[2][i][3]
				local ry = math.max(0, ey)
				local rsy = math.max(0, sy - (ry - ey))
				sightexports.sGui:setGuiPosition(topExpandedElements[2][i][1], false, ry)
				sightexports.sGui:setGuiSize(topExpandedElements[2][i][1], sy, rsy)
			end
			for j = 1, #topExpandedElements[8] do
				sightexports.sGui:setGuiHoverable(topExpandedElements[8][j][1], p == 1)
				local els = topExpandedElements[8][j][2]
				local sy = 48
				local y = y + topExpandedElements[8][j][3]
				local py = y
				local ry = math.max(0, y)
				local pry = ry
				sightexports.sGui:setGuiPosition(topExpandedElements[8][j][1], false, ry)
				sightexports.sGui:setGuiSize(topExpandedElements[8][j][1], false, math.max(0, sy - (ry - y)))
				y = y + 1
				sy = sy - 2
				ry = math.max(0, y)
				sightexports.sGui:setGuiPosition(els[1], false, ry - pry)
				sightexports.sGui:setGuiSize(els[1], false, math.max(0, sy - (ry - y)))
				py = y
				pry = ry
				for i = 1, #els[2] do
					local y = py + els[2][i][2]
					local sy = els[2][i][3]
					local ry = math.max(0, y)
					sightexports.sGui:setGuiPosition(els[2][i][1], false, ry - pry)
					sightexports.sGui:setGuiSize(els[2][i][1], false, math.max(0, sy - (ry - y)))
				end
				for i = 1, #els[3] do
					local y = py + els[3][i][2]
					local sy = els[3][i][3]
					local ry = math.max(0, y)
					local uv = els[3][i][4]
					local rsy = math.max(0, sy - (ry - y))
					if els[3][i][1] then
						sightexports.sGui:setGuiPosition(els[3][i][1], false, ry - pry)
						sightexports.sGui:setGuiSize(els[3][i][1], false, rsy)
						sightexports.sGui:setImageUV(els[3][i][1], 0, uv - rsy * (uv / sy), uv, rsy * (uv / sy))
					end
				end
			end
		end
	end
	if topNoti then
		local p = (now - topNoti[5]) / notiAnimTime
		local t = topNoti[7] / notiAnimTime
		if p > t then
			p = t + 1 - p
			p = getEasingValue(p, "OutQuad")
		else
			p = getEasingValue(p, "InQuad")
		end
		if 1 < p then
			p = 1
		end
		if p < 0 then
			p = 0
		end
		if topNoti[1] then
			sightexports.sGui:setGuiHoverable(topNoti[1], p == 1)
			local sy = 48
			local y = -sy * 1.1 + (sy * 1.1 + topSize + 4) * p
			local py = y
			local ry = math.max(0, y)
			local pry = ry
			sightexports.sGui:setGuiPosition(topNoti[1], false, ry)
			sightexports.sGui:setGuiSize(topNoti[1], false, math.max(0, sy - (ry - y)))
			y = y + 1
			sy = sy - 2
			ry = math.max(0, y)
			sightexports.sGui:setGuiPosition(topNoti[6][1], false, ry - pry)
			sightexports.sGui:setGuiSize(topNoti[6][1], false, math.max(0, sy - (ry - y)))
			py = y
			pry = ry
			for i = 1, #topNoti[6][2] do
				local y = py + topNoti[6][2][i][2]
				local sy = topNoti[6][2][i][3]
				local ry = math.max(0, y)
				sightexports.sGui:setGuiPosition(topNoti[6][2][i][1], false, ry - pry)
				sightexports.sGui:setGuiSize(topNoti[6][2][i][1], false, math.max(0, sy - (ry - y)))
			end
			for i = 1, #topNoti[6][3] do
				local y = py + topNoti[6][3][i][2]
				local sy = topNoti[6][3][i][3]
				local ry = math.max(0, y)
				local uv = topNoti[6][3][i][4]
				local rsy = math.max(0, sy - (ry - y))
				if topNoti[6][3][i][1] then
					sightexports.sGui:setGuiPosition(topNoti[6][3][i][1], false, ry - pry)
					sightexports.sGui:setGuiSize(topNoti[6][3][i][1], false, rsy)
					sightexports.sGui:setImageUV(topNoti[6][3][i][1], 0, uv - rsy * (uv / sy), uv, rsy * (uv / sy))
				end
			end
		end
		if p <= 0 then
			if topNoti[1] then
				sightexports.sGui:deleteGuiElement(topNoti[1])
			end
			topNoti = false
		end
	end
	local rt = getRealTime()
	local tmp = string.format("%02d:%02d", rt.hour, rt.minute)
	if time ~= tmp then
		time = tmp
		sightexports.sGui:setLabelText(topLabel2, time)
		if currentPhoneScreen == "home" or currentPhoneScreen == "locked" then
			sightexports.sGui:setLabelText(timeLabel, time)
		end
	end
	if lastScreenshot then
		local x2 = x + math.floor((sx - bsx) / 2)
		local y2 = y + math.floor((sy - bsy) / 2)
		local progress = (getTickCount() - lastScreenshot) / 350 - 0.1
		if progress < 0 then
			progress = 0
		end
		if 1.5 < progress then
			progress = (progress - 1.5) / 2
			dxDrawImage(x2 + 4 + (bsx - 8) * 0.25 / 2 + (bsx - 8) * 0.75 * progress / 2, y2 + bsy * 0.25 / 2 + bsy * 0.75 * progress / 2, (bsx - 8) * 0.75 * (1 - progress), bsy * 0.75 * (1 - progress), dynamicImage(lastScreenshotUrl, "dxt3", false), 0, 0, 0, tocolor(255, 255, 255, 255 - 255 * progress))
			if 1 < progress then
				lastScreenshot = false
			end
		elseif progress <= 1 then
			dxDrawImage(x2 + 4 + (bsx - 8) * 0.25 / 2, y2 + bsy * 0.25 / 2, (bsx - 8) * 0.75, bsy * 0.75, dynamicImage(lastScreenshotUrl, "dxt3", false))
			dxDrawRectangle(x2, y2, bsx, bsy, tocolor(255, 255, 255, 255 - 255 * progress))
			dxDrawImage(x, y, sx, sy, loadedTextures["files/img/phone2x.png"])
		else
			dxDrawImage(x2 + 4 + (bsx - 8) * 0.25 / 2, y2 + bsy * 0.25 / 2, (bsx - 8) * 0.75, bsy * 0.75, dynamicImage(lastScreenshotUrl, "dxt3", false))
		end
	end
end
local streamedPlayerMobiles = {}
local phoneQ = {
	0.035798,
	-0.021859,
	0.749572,
	0.660592
}
local phoneModel = false
function loadModels()
	phoneModel = sightexports.sModloader:getModelId("v4_phone")
end
addEventHandler("onClientPlayerDataChange", getRootElement(), function(data, old, new)
	if source == localPlayer or isElementStreamedIn(source) then
		if data == "calling" then
			if new then
				streamedPlayerMobiles[source] = 2
			else
				streamedPlayerMobiles[source] = getElementData(source, "mobile") or nil
			end
			if streamedPlayerMobiles[source] then
				sightlangCondHandl0(true)
				if not isElement(mobileObjects[source]) then
					mobileObjects[source] = createObject(phoneModel, 0, 0, 0)
					setElementCollisionsEnabled(mobileObjects[source], false)
					sightexports.sPattach:attach(mobileObjects[source], source, 25, -0.025992, 0.019625, 0.030808, 0, 0, 0)
					sightexports.sPattach:setRotationQuaternion(mobileObjects[source], phoneQ)
				end
			else
				if isElement(mobileObjects[source]) then
					destroyElement(mobileObjects[source])
				end
				mobileObjects[source] = nil
			end
		elseif data == "mobile" then
			if getElementData(source, "calling") then
				new = 2
			end
			streamedPlayerMobiles[source] = new or nil
			if new then
				sightlangCondHandl0(true)
				if not isElement(mobileObjects[source]) then
					mobileObjects[source] = createObject(phoneModel, 0, 0, 0)
					setElementCollisionsEnabled(mobileObjects[source], false)
					sightexports.sPattach:attach(mobileObjects[source], source, 25, -0.025992, 0.019625, 0.030808, 0, 0, 0)
					sightexports.sPattach:setRotationQuaternion(mobileObjects[source], phoneQ)
				end
			else
				if isElement(mobileObjects[source]) then
					destroyElement(mobileObjects[source])
				end
				mobileObjects[source] = nil
			end
		end
	end
end)
addEventHandler("onClientPlayerStreamIn", getRootElement(), function()
	if source ~= localPlayer then
		streamedPlayerMobiles[source] = getElementData(source, "calling") and 2 or getElementData(source, "mobile") or nil
		if streamedPlayerMobiles[source] then
			sightlangCondHandl0(true)
			if not isElement(mobileObjects[source]) then
				mobileObjects[source] = createObject(phoneModel, 0, 0, 0)
				setElementCollisionsEnabled(mobileObjects[source], false)
				sightexports.sPattach:attach(mobileObjects[source], source, 25, -0.025992, 0.019625, 0.030808, 0, 0, 0)
				sightexports.sPattach:setRotationQuaternion(mobileObjects[source], phoneQ)
			end
		else
			if isElement(mobileObjects[source]) then
				destroyElement(mobileObjects[source])
			end
			mobileObjects[source] = nil
		end
	end
end)
addEventHandler("onClientPlayerQuit", getRootElement(), function()
	if source ~= localPlayer then
		streamedPlayerMobiles[source] = nil
		if isElement(mobileObjects[source]) then
			destroyElement(mobileObjects[source])
		end
		mobileObjects[source] = nil
	end
end)
addEventHandler("onClientPlayerStreamOut", getRootElement(), function()
	if source ~= localPlayer then
		streamedPlayerMobiles[source] = nil
		if isElement(mobileObjects[source]) then
			destroyElement(mobileObjects[source])
		end
		mobileObjects[source] = nil
	end
end)
function mobileBones()
	for client, val in pairs(streamedPlayerMobiles) do
		if isElementOnScreen(client) then
			if val == 3 then
				setElementBoneRotation(client, 22, 54.782668403957, -91.304422461468, 13.043438455332)
				setElementBoneRotation(client, 23, -16.956501836362, -15.652193815812, -26.086936618971)
				setElementBoneRotation(client, 24, 173.47822603972, -46.95652173913, -24.782588792884)
				setElementBoneRotation(client, 25, -1.3043975830078, 9.1304596610691, 16.956457055133)
				setElementBoneRotation(client, 26, -5.2173266203507, 15.652084350586, 0)
			elseif val == 2 then
				setElementBoneRotation(client, 22, 103.0435877261, -90.000074635381, -37.82617651898)
				setElementBoneRotation(client, 23, -30.000089562458, -139.56517758577, -24.782539035963)
				setElementBoneRotation(client, 24, 165.65218386443, 6.5217291790511, 4.9756919509036E-6)
				setElementBoneRotation(client, 25, -5.2174311098845, 10.43479256008, 16.956457055133)
				setElementBoneRotation(client, 26, -5.2173266203507, 15.652084350586, 0)
			else
				setElementBoneRotation(client, 22, 51.73919511878, -74.347910673722, -58.695642222529)
				setElementBoneRotation(client, 23, -50.869565217392, -78.260849662452, -9.1302705847697)
				setElementBoneRotation(client, 24, -142.17389314071, -35.217426134192, -24.782568890116)
				setElementBoneRotation(client, 25, -1.3044174857762, 10.43479256008, 16.956457055133)
				setElementBoneRotation(client, 26, -5.2173266203507, 15.652084350586, 0)
			end
			sightexports.sCore:updateElementRpHAnim(client)
			if isElement(mobileObjects[client]) then
				setElementInterior(mobileObjects[client], getElementInterior(client))
				setElementDimension(mobileObjects[client], getElementDimension(client))
			end
		end
	end
	for client, val in pairs(streamedPlayerMobiles) do
		return
	end
	sightlangCondHandl0(false)
end
addEvent("syncCameraShutterSound", true)
addEventHandler("syncCameraShutterSound", getRootElement(), function()
	if isElement(source) then
		local obj = isElement(mobileObjects[source]) and mobileObjects[source] or source
		local x, y, z = getElementPosition(obj)
		local sound = playSound3D("files/cam.wav", x, y, z)
		setElementInterior(sound, getElementInterior(obj))
		setElementDimension(sound, getElementDimension(obj))
		attachElements(sound, obj)
	end
end)
