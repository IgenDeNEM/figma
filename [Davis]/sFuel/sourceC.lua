elementsSuccessfullyLoaded = false

local sightexports = {
	sGui = false,
	sModloader = false,
	sPattach = false,
	sVehicles = false
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
	if sightlangStaticImageToc[0] and sightlangStaticImageToc[1] and sightlangStaticImageToc[2] and sightlangStaticImageToc[3] and sightlangStaticImageToc[4] and sightlangStaticImageToc[5] and sightlangStaticImageToc[6] and sightlangStaticImageToc[7] and sightlangStaticImageToc[8] then
		sightlangStatImgHand = false
		removeEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre)
	end
end
processsightlangStaticImage[0] = function()
	if not isElement(sightlangStaticImage[0]) then
		sightlangStaticImageToc[0] = false
		sightlangStaticImage[0] = dxCreateTexture("files/7seg.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processsightlangStaticImage[1] = function()
	if not isElement(sightlangStaticImage[1]) then
		sightlangStaticImageToc[1] = false
		sightlangStaticImage[1] = dxCreateTexture("files/pempty.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processsightlangStaticImage[2] = function()
	if not isElement(sightlangStaticImage[2]) then
		sightlangStaticImageToc[2] = false
		sightlangStaticImage[2] = dxCreateTexture("files/pgetout.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processsightlangStaticImage[3] = function()
	if not isElement(sightlangStaticImage[3]) then
		sightlangStaticImageToc[3] = false
		sightlangStaticImage[3] = dxCreateTexture("files/ppress.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processsightlangStaticImage[4] = function()
	if not isElement(sightlangStaticImage[4]) then
		sightlangStaticImageToc[4] = false
		sightlangStaticImage[4] = dxCreateTexture("files/pdrop.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processsightlangStaticImage[5] = function()
	if not isElement(sightlangStaticImage[5]) then
		sightlangStaticImageToc[5] = false
		sightlangStaticImage[5] = dxCreateTexture("files/pputin.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processsightlangStaticImage[6] = function()
	if not isElement(sightlangStaticImage[6]) then
		sightlangStaticImageToc[6] = false
		sightlangStaticImage[6] = dxCreateTexture("files/pback.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processsightlangStaticImage[7] = function()
	if not isElement(sightlangStaticImage[7]) then
		sightlangStaticImageToc[7] = false
		sightlangStaticImage[7] = dxCreateTexture("files/pget.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processsightlangStaticImage[8] = function()
	if not isElement(sightlangStaticImage[8]) then
		sightlangStaticImageToc[8] = false
		sightlangStaticImage[8] = dxCreateTexture("files/paper.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
local fuelCaps = {
	[596] = {
		1.1805026808362,
		-1.4997738599777,
		0.072159466470122,
		-70.408786795954,
		0
	},
	[404] = {
		1.2762842869303,
		-1.446338314919,
		0.44022172689438,
		-73.391727763376,
		0
	},
	[581] = {
		0.0085472856831346,
		-0.26923085481693,
		0.70297898696019,
		-107.414533501,
		270
	},
	[462] = {
		0.33850486435974,
		-0.7146420626786,
		0.48121908593758,
		-95.374203821656,
		0
	},
	[521] = {
		-0.0042732271373782,
		-0.31410245406322,
		0.74840352321282,
		-109.2948785195,
		270
	},
	[463] = {
		-0.14135570760466,
		-0.064102282890907,
		0.78287621033497,
		-104.3589810836,
		270
	},
	[522] = {
		0.0063696668695332,
		-0.35188901648303,
		0.71622481116201,
		-110,
		270
	},
	[461] = {
		0.019108669013734,
		-0.37591999826158,
		0.63531177894325,
		-103.93980105394,
		270
	},
	[448] = {
		0,
		0,
		0.14743606860821,
		-104.00641070472,
		270
	},
	[518] = {
		1.4566505676622,
		-2.1897752285004,
		-0.11785054662425,
		-68.289628562842,
		0
	},
	[468] = {
		-2.2123313852251E-4,
		-0.089866171502003,
		0.52115693840252,
		-95.193040925031,
		270
	},
	[419] = {
		-1.3254376399289,
		-1.9956621220157,
		-0.11509682608258,
		-48.111129973656,
		180
	},
	[586] = {
		-0.130710729558,
		0.012698242988693,
		0.82149450799014,
		-110,
		270
	},
	[602] = {
		1.2075651690459,
		-1.6465590000153,
		0.090577186292903,
		-66.457961819845,
		0
	},
	[527] = {
		-1.2059266212309,
		-2.0227001250111,
		0.075087176479196,
		-65.936989635497,
		180
	},
	[589] = {
		1.1194567511822,
		-1.5161251174689,
		0.064230707741902,
		-71.26960813321,
		0
	},
	[587] = {
		1.2410739664384,
		-1.7359606190365,
		0.042754639855753,
		-63.741512632933,
		0
	},
	[533] = {
		1.1125860759336,
		-0.9804601317797,
		0.47392013592598,
		-70.160276135828,
		0
	},
	[410] = {
		1.1324783716446,
		-1.5833335289588,
		0.11538459093143,
		-56.762846066402,
		0
	},
	[439] = {
		-1.2501061217398,
		-2.1636644693521,
		0.43752986039871,
		-81.559859993111,
		180
	},
	[549] = {
		1.2669168349005,
		-0.95981468298496,
		0.21494422279871,
		-64.871829391545,
		0
	},
	[491] = {
		1.171388640363,
		-2.1823888252943,
		-0.16875618658005,
		-53.237213558621,
		0
	},
	[445] = {
		1.2233151462343,
		-1.5567739498921,
		0.11845292342015,
		-71.217941545014,
		0
	},
	[604] = {
		1.2009575621338,
		-1.7383109331131,
		0.29800254106522,
		-84.879609779836,
		0
	},
	[507] = {
		1.1427883285626,
		-2.0731604099274,
		0.10623330988322,
		-70.146770035995,
		0
	},
	[585] = {
		1.229356457535,
		-1.9058303557909,
		-0.012249869604905,
		-57.350403141772,
		0
	},
	[466] = {
		-1.2271366785877,
		-1.8109250177497,
		0.29286417120981,
		-79.428693678533,
		180
	},
	[492] = {
		1.1694502540124,
		-1.70297650973,
		0.28671742427043,
		-65.224332075853,
		0
	},
	[546] = {
		1.1947511373422,
		-1.4548368545679,
		0.1491940403596,
		-51.709373914278,
		0
	},
	[551] = {
		1.2934722543782,
		-1.8210319280624,
		0.29852027847217,
		-56.410226821899,
		0
	},
	[426] = {
		-1.2393358018663,
		-1.5994194348653,
		0.25840417773296,
		-64.871792181944,
		180
	},
	[547] = {
		1.1484852392449,
		-1.5629321734111,
		0.33162396534895,
		-55.940163767236,
		0
	},
	[405] = {
		1.2641253471375,
		-1.6016501707908,
		0.062917969165704,
		-60.641013088389,
		0
	},
	[580] = {
		1.2599263191223,
		-1.6356640198292,
		0.2326779518372,
		-63.226486760327,
		0
	},
	[409] = {
		-1.3139542203683,
		-3.6380134304034,
		0.31817972660065,
		-68.397430517735,
		180
	},
	[550] = {
		1.2402053001599,
		-1.694712968973,
		-0.025193304122809,
		-65.584409376696,
		0
	},
	[566] = {
		1.2112939752591,
		-1.5790203809738,
		0.27275100464274,
		-68.988040479346,
		0
	},
	[540] = {
		1.2329171101252,
		-1.57563492885,
		0.14230683216682,
		-53.237180383796,
		0
	},
	[421] = {
		1.2138914131814,
		-1.8358227014542,
		-0.012026411380359,
		-64.761757165594,
		0
	},
	[529] = {
		1.157362924552,
		-1.5868797827328,
		0.026747296811145,
		-59.916444213371,
		0
	},
	[431] = {
		-1.6473912418268,
		-5.4585981429762,
		-0.23864144352591,
		-60.288457951994,
		180
	},
	[438] = {
		1.2540744054012,
		-1.7755032777786,
		0.21708838297771,
		-60.288457951994,
		0
	},
	[437] = {
		-1.6642297058024,
		-4.9488324507689,
		-0.62636276544669,
		-52.767092672169,
		180
	},
	[574] = {
		-1.0015907435336,
		-0.96569287776947,
		0.16535517344108,
		-61.463681041685,
		180
	},
	[420] = {
		1.2561367622807,
		-1.9905004501343,
		-0.17934781809648,
		-49.82906251891,
		0
	},
	[525] = {
		1.315607599749,
		-0.36247531851386,
		-0.08287180385353,
		-57.258364505426,
		0
	},
	[408] = {
		-1.3611891605915,
		1.2851812482899,
		-0.86845006392552,
		-42.660255961948,
		180
	},
	[552] = {
		-1.490680060835,
		-0.95979237556458,
		0.3304107219745,
		-42.660255961948,
		180
	},
	[416] = {
		-1.2991455925836,
		0.48076894548204,
		-0.10256415147048,
		-58.87820378328,
		180
	},
	[433] = {
		-1.7879434711913,
		0.16199457645416,
		-0.7553420983828,
		-64.519231217539,
		180
	},
	[427] = {
		-1.4397172805591,
		-3.1999545097351,
		-0.31159893671672,
		-47.948719741952,
		180
	},
	[490] = {
		1.3439496277244,
		-1.7086458540266,
		0.52356578438145,
		-66.106889839106,
		0
	},
	[528] = {
		-1.3902366901821,
		-2.002249034347,
		0.050573223106966,
		-65.082142802015,
		180
	},
	[407] = {
		1.5684862395001,
		0.86827781587649,
		-0.19542501952238,
		-82.937911452761,
		0
	},
	[544] = {
		-1.4199863417536,
		2.066534280777,
		0.15384600712703,
		-47.478634271866,
		180
	},
	[523] = {
		0,
		-0.05000049729123,
		0.65484781754323,
		-103.06624559256,
		270
	},
	[470] = {
		-1.3733319637272,
		-2.2349143316791,
		0.1046363905172,
		-76.100713394315,
		180
	},
	[598] = {
		1.2269824505229,
		-1.6115747887618,
		0.044427562600527,
		-68.817373902454,
		0
	},
	[599] = {
		1.127760999142,
		-1.3700577020645,
		0.37148380279541,
		-83.092856954896,
		0
	},
	[597] = {
		1.1828948415658,
		-1.3316368210899,
		0.4789762372346,
		-73.405199394858,
		0
	},
	[601] = {
		-1.5479056325733,
		-1.692116674195,
		0.82162402837704,
		-61.816252765493,
		180
	},
	[428] = {
		-1.4394908346188,
		-0.19108255957342,
		-0.48726114649682,
		-82.675164581104,
		180
	},
	[499] = {
		-1.2194332556847,
		-1.0735371245278,
		-0.61609328862948,
		-30.43804987883,
		180
	},
	[609] = {
		-1.4790201574309,
		-0.002114057540894,
		-0.11609972134615,
		-39.839757935614,
		180
	},
	[524] = {
		1.8253012905773,
		0.48094522953033,
		-1.1007207020735,
		-51.474370630378,
		0
	},
	[578] = {
		-1.5517683110685,
		2.9110345840454,
		-0.17117821864593,
		-51.474370630378,
		180
	},
	[486] = {
		-0.83296983669966,
		-3.1656203269958,
		0.4405552148819,
		-53.002149304773,
		180
	},
	[406] = {
		-2.1623930971847,
		0.69444444444444,
		-0.8974357018104,
		-53.002149304773,
		180
	},
	[573] = {
		-1.4922449772175,
		0.53131033008934,
		-0.7597002524596,
		-33.96368821462,
		180
	},
	[455] = {
		-1.7473824920817,
		0.0072396927409707,
		-0.95293612663562,
		-43.600442592914,
		180
	},
	[588] = {
		-1.6615425521492,
		-2.1146416541858,
		0.096483251987359,
		-51.709416951889,
		180
	},
	[403] = {
		-1.5261324419935,
		0.07311162352562,
		-0.93236737984877,
		-56.175230710934,
		180
	},
	[423] = {
		-1.2979259837387,
		-1.9019415378571,
		-0.49482322044862,
		-41.250016139104,
		180
	},
	[414] = {
		-1.0439823825135,
		-0.74315750598907,
		-0.81717834105858,
		-52.061980606144,
		180
	},
	[443] = {
		-1.487179291554,
		-0.43803475860857,
		0.128205372737,
		-66.752148856465,
		180
	},
	[515] = {
		-1.8856673872369,
		0.478881294656,
		-1.4044749217156,
		-55.117531678615,
		180
	},
	[514] = {
		-1.6153848762186,
		-0.87967757689647,
		-0.4385794095504,
		-48.771376935845,
		180
	},
	[531] = {
		-0.67074069202456,
		0.73198877644335,
		-0.14408735281382,
		-42.072659435435,
		180
	},
	[456] = {
		1.1020914779769,
		-0.049150580014939,
		-0.79427651869945,
		-42.072659435435,
		0
	},
	[459] = {
		-1.2956160948827,
		-2.2943491059491,
		0.044494677812625,
		-47.713683731536,
		180
	},
	[422] = {
		-1.2860408277593,
		-0.42444550991058,
		-0.35261725156735,
		-47.713683731536,
		180
	},
	[482] = {
		1.2775785841494,
		-2.2670500971313,
		-0.1634237521734,
		-47.713683731536,
		0
	},
	[605] = {
		-1.247862954425,
		-0.64102539649377,
		-0.52564102564103,
		-35.491458371154,
		180
	},
	[418] = {
		-1.4301525334008,
		-1.7519893554541,
		-0.15759044732803,
		-48.888892027048,
		180
	},
	[572] = {
		-0.38491249084473,
		-1.260683923705,
		0.15139634486956,
		-85.320510578971,
		270
	},
	[582] = {
		-1.2735044039213,
		0.61965832343468,
		-0.24999997554681,
		-53.237175452404,
		180
	},
	[413] = {
		-1.3594497187525,
		-0.64311566006424,
		-0.52511776716281,
		-42.542734594427,
		180
	},
	[440] = {
		-1.2939631735158,
		-0.46366101503372,
		-0.5779128135779,
		-50.534186240954,
		180
	},
	[543] = {
		-1.3691201271155,
		-0.93720263089889,
		-0.15157845845589,
		-50.299140816061,
		180
	},
	[583] = {
		-1.0779632956554,
		0.40057613197555,
		-0.17333435324522,
		-59.818367998824,
		180
	},
	[478] = {
		1.3972232117612,
		-0.34270495176315,
		0.22152974055364,
		-73.803403560932,
		0
	},
	[554] = {
		-1.3466893108028,
		-0.91574241363319,
		-0.20842449983973,
		-59.965071830021,
		180
	},
	[579] = {
		1.2700870103306,
		-2.1685609817505,
		0.16845145363074,
		-50.769214630127,
		0
	},
	[400] = {
		1.2040540214278,
		-1.4925094985554,
		-0.068710989676989,
		-54.529898390811,
		0
	},
	[489] = {
		1.4768671488306,
		-0.73726749420166,
		-0.10975351758823,
		-59.122205300014,
		0
	},
	[505] = {
		1.4628539146521,
		-1.5659454235664,
		-0.080494283483579,
		-48.653823290116,
		0
	},
	[479] = {
		1.2021327561439,
		-1.478839576624,
		0.073336126830684,
		-68.535892315348,
		0
	},
	[442] = {
		-1.4005849799539,
		-2.2110741138458,
		-0.061015153542543,
		-53.472203393268,
		180
	},
	[458] = {
		1.2449966840281,
		-1.9295461227278,
		0.16615291237929,
		-59.087032210594,
		0
	},
	[536] = {
		-1.3431048383061,
		-2.2587780952454,
		-0.084133100433227,
		-49.358946563851,
		180
	},
	[575] = {
		0,
		-3.0997438471541,
		-0.18634361945666,
		-51.474328937694,
		270
	},
	[534] = {
		-1.3651980660919,
		-1.969175696373,
		-0.14466130341857,
		-51.474328937694,
		180
	},
	[567] = {
		-1.4825815084653,
		-1.8443995714188,
		-0.23659051037752,
		-54.17731904576,
		180
	},
	[535] = {
		-1.3818174167576,
		-1.755467414856,
		-0.027627290823521,
		-67.222192633865,
		180
	},
	[576] = {
		-0.93098843097687,
		-3.3140360962631,
		-0.013366552499624,
		-50.181596136501,
		270
	},
	[412] = {
		0,
		-3.834509539808,
		-0.36563866260724,
		-42.895271798484,
		270
	},
	[402] = {
		0.0063704561003171,
		-2.9800581713495,
		-0.27087135569281,
		-49.946555194692,
		270
	},
	[542] = {
		-1.2080397768917,
		-0.97279576868073,
		0.083135452025976,
		-55.235016733153,
		180
	},
	[603] = {
		-1.2675635284848,
		-2.4287309646606,
		-0.075581474946095,
		-51.474331627544,
		180
	},
	[475] = {
		-1.3036022114957,
		-2.2518640338865,
		0.0082355294472134,
		-51.474331627544,
		180
	},
	[541] = {
		1.2221257177174,
		-1.6628079414368,
		0.18126814258404,
		-57.937999668284,
		0
	},
	[415] = {
		1.2215312719345,
		-0.72079831361771,
		0.33830502782112,
		-64.989277236482,
		0
	},
	[480] = {
		1.1847131814167,
		0.97133745813066,
		0.066878835107111,
		-76.75189537711,
		0
	},
	[562] = {
		1.1790121212984,
		-1.6393713951111,
		0.05408009657493,
		-54.059787815453,
		0
	},
	[565] = {
		-1.1278383899958,
		-1.4946628808975,
		0.11112306133295,
		-54.059787815453,
		180
	},
	[434] = {
		4.1431188583374E-4,
		-1.8803407391931,
		0.38482005015398,
		-84.967908370189,
		270
	},
	[494] = {
		1.1833498681712,
		-0.65012627840042,
		0.35307070077994,
		-62.991412643693,
		0
	},
	[502] = {
		1.338270195529,
		-1.0762057304382,
		0.071858988740505,
		-61.463639349,
		0
	},
	[503] = {
		1.1785312259299,
		-1.4703746483876,
		0.30251548076287,
		-63.814067596044,
		0
	},
	[411] = {
		1.3216155696119,
		-1.3118118047714,
		0.18678851311023,
		-49.711503941789,
		0
	},
	[559] = {
		1.219506540869,
		-1.7510749101639,
		0.014424417263422,
		-49.711503941789,
		0
	},
	[561] = {
		1.1439284070944,
		-1.6377079486847,
		0.16016394205582,
		-58.290563770848,
		0
	},
	[560] = {
		-1.2497473354014,
		-1.5466023683548,
		0.33737588922183,
		-54.412357746026,
		180
	},
	[506] = {
		-0.60017468582871,
		-0.5957486456276,
		0.80128210018843,
		-103.41876979567,
		180
	},
	[451] = {
		1.145304177292,
		-0.81819891869922,
		0.53458525320488,
		-91.184579805476,
		0
	},
	[558] = {
		1.1532520473513,
		-1.6230405569077,
		0.026970728467672,
		-51.121766180055,
		0
	},
	[555] = {
		-0.76869809118092,
		-1.9659205675125,
		0.45974426162549,
		-90.021337036394,
		180
	},
	[477] = {
		1.2177613468686,
		-1.8492089509964,
		0.10289194040997,
		-68.43482990972,
		0
	},
	[568] = {
		-0.6327982779242,
		-0.70604986207098,
		0.44815824734859,
		-87.670903409648,
		180
	},
	[424] = {
		-0.99635566146965,
		-1.4812017679214,
		0.60168298544028,
		-87.670903409648,
		180
	},
	[504] = {
		-1.3857279934435,
		-1.8286168575287,
		-0.054160822660495,
		-45.833294778808,
		180
	},
	[483] = {
		1.2995191190997,
		-1.9499107599258,
		-0.23552404458706,
		-49.123892621097,
		0
	},
	[508] = {
		-1.7179488157615,
		-0.51281994224614,
		0,
		-59.113214240115,
		180
	},
	[571] = {
		-0.41840437618651,
		0.16513191201748,
		0.047720338289555,
		-80.267085499234,
		180
	},
	[500] = {
		-1.1648379681457,
		-1.4839718341827,
		-0.37791379331014,
		-45.245715736324,
		180
	},
	[444] = {
		1.4615378094535,
		-2.7623676805415,
		0.42655995870248,
		-45.245715736324,
		0
	},
	[556] = {
		1.4786323482155,
		-2.510683923705,
		0.32692312582945,
		-45.245715736324,
		0
	},
	[557] = {
		1.4935775394114,
		-2.4587724066188,
		0.35154414788271,
		-43.717939303471,
		0
	},
	[471] = {
		-0.00560688249521,
		-0.14331137298778,
		0.49767202850496,
		-102.63657558801,
		270
	},
	[495] = {
		-1.4290223172587,
		-1.3421647548676,
		0.06911100485386,
		-46.185890262962,
		180
	},
	[516] = {
		-4.6985759399831E-4,
		-3.2261438451262,
		-0.2885810197928,
		-59.348278942271,
		270
	},
	[517] = {
		-2.5761872529984E-4,
		-3.1771085404942,
		-0.31627341417166,
		-65.224341938638,
		270
	},
	[474] = {
		0.96815189434465,
		1.0515817775848,
		0.57034979531642,
		-59.146160949872,
		0
	},
	[496] = {
		1.19085234964,
		-1.301638007164,
		0.11768850645958,
		-55.117499400408,
		0
	},
	[401] = {
		1.1606643963661,
		-1.7033843120951,
		0.29149402252856,
		-62.671814899361,
		0
	},
	[526] = {
		1.1756195680708,
		-1.7817393276427,
		0.26871502399445,
		-60.5234881344,
		0
	},
	[436] = {
		-1.2896223088615,
		-1.8230194291498,
		0.057619438721583,
		-60.5234881344,
		180
	},
	[545] = {
		0.0025759339332581,
		-2.5165915929588,
		-0.19410108855575,
		-100.628978219,
		270
	},
	[600] = {
		1.3789958483095,
		-2.0251038074493,
		-0.042993703465553,
		-55.154954856647,
		0
	},
	[467] = {
		0.0043638348579407,
		-3.020107580598,
		0.14818670463031,
		-73.648444246899,
		270
	},
	[415] = {
		0.909429166727,
		-1.2621991015544,
		0.41951521890392,
		-99.320482082129,
		0
	},
	[418] = {
		-1.4174138742771,
		-2.2854293318487,
		-0.028609701392894,
		-62.638894699766,
		180
	},
	[419] = {
		1.2441020866109,
		-1.0590000152588,
		0.32600000500679,
		-78.140481711018,
		0
	},
	[429] = {
		1.246516258094,
		-1.6631724348493,
		0.34303108616999,
		-89.296751608229,
		0
	},
	[432] = {
		1.5350312639953,
		-4.004775855192,
		1.218152866242,
		-110,
		0
	},
	[457] = {
		0.35031866571706,
		0.2468152866242,
		0.014331355975692,
		-84.899092556454,
		270
	},
	[485] = {
		-1.1101847180895,
		0.70778878707035,
		-0.061567990263556,
		-60.94714102874,
		180
	},
	[530] = {
		0.025477318247413,
		-2.2611464968153,
		0.3152863326346,
		-62.718989311354,
		270
	},
	[532] = {
		-0.012739242262142,
		-1.9028650271665,
		-1.2611466425999,
		-79.609872611465,
		270
	},
	[539] = {
		0.38853483746766,
		-0.70063694267516,
		0.53503184713376,
		-95.863720961197,
		0
	},
	[545] = {
		0.0025755451743015,
		-2.5325154028121,
		-0.28008805813303,
		-82.598069041612,
		270
	},
	[498] = {
		-1.4969846868211,
		-0.011567837873082,
		-0.043090899279164,
		-53.949045922346,
		180
	},
	[611] = {
		0,
		0.12,
		1.45,
		-130,
		270
	},
}
for k in pairs(fuelCaps) do
	local ry, rz = math.rad(fuelCaps[k][4]), math.rad(fuelCaps[k][5])
	local crz = math.cos(rz)
	local cry = math.cos(ry)
	local srz = math.sin(rz)
	local sry = math.sin(ry)
	fuelCaps[k][6] = -0.065953 * (crz * cry) + 6.0E-5 * (-1 * srz) + 0.321929 * (crz * sry) + fuelCaps[k][1]
	fuelCaps[k][7] = -0.065953 * (cry * srz) + 6.0E-5 * crz + 0.321929 * (srz * sry) + fuelCaps[k][2]
	fuelCaps[k][8] = -0.065953 * (-1 * sry) + 0.321929 * (1 * cry) + fuelCaps[k][3]
end
function getFuelCapIcon(veh)
	local model = getElementModel(veh)
	if fuelCaps[model] then
		return fuelCaps[model][6], fuelCaps[model][7], fuelCaps[model][8]
	else
		local x, y, z = getVehicleDummyPosition(veh, "gas_cap")
		return x, y, z
	end
end
function getFuelCapPosition(veh)
	local model = getElementModel(veh)
	if fuelCaps[model] then
		return fuelCaps[model][1], fuelCaps[model][2], fuelCaps[model][3], fuelCaps[model][4], fuelCaps[model][5]
	else
		local x, y, z = getVehicleDummyPosition(veh, "gas_cap")
		return x, y, z
	end
end
local mainFuelElements = {}
local fuelDigits = {}
local fuelDigitVectors = {}
local priceDigits = {}
local priceDigitVectors = {}
local priceDigitStationIds = {}
local fuelSyncZones = {}
local hover = false
local hoverCmd = false
local screenX, screenY = guiGetScreenSize()
local selfFueling = false
local lastClick = 0
local selfPump = false
local currentFuelStation = false
local neededDoorProgress = 0
local currentDoorProgress = 0
local doorSound = false
function playDoorSound()
	if isElement(doorSound) then
		destroyElement(doorSound)
	end
	doorSound = nil
	if currentFuelStation then
		local x, y, z = unpack(fuelStations[currentFuelStation].storeDoors.soundPos)
		if neededDoorProgress == 1 then
			doorSound = playSound3D("files/dooropen.wav", x, y, z)
			setSoundPosition(doorSound, currentDoorProgress * 1.2)
		else
			doorSound = playSound3D("files/doorclose.wav", x, y, z)
			setSoundPosition(doorSound, (1 - currentDoorProgress) * 1.2)
		end
	end
end
function enterStoreDoor(theElement, matchingDimension)
	if matchingDimension and getElementType(theElement) == "player" then
		local tmp = #getElementsWithinColShape(source, "player") >= 1 and 1 or 0
		if tmp ~= neededDoorProgress then
			neededDoorProgress = tmp
			playDoorSound()
		end
	end
end
local fuelingSounds = {}
local green = false
local font, fontScale
function initColorsAndFonts()
	green = sightexports.sGui:getColorCode("sightgreen")
	font = sightexports.sGui:getFont("13/BebasNeueBold.otf")
	fontScale = sightexports.sGui:getFontScale("13/BebasNeueBold.otf")
end
function streamInFuelStation(col)
	if currentFuelStation == fuelSyncZones[col] then
		return
	end
	if currentFuelStation then
		removeEventHandler("onClientColShapeHit", fuelStations[currentFuelStation].storeDoors.colShape, enterStoreDoor)
	else
		addEventHandler("onClientRender", getRootElement(), renderFuelStation)
		addEventHandler("onClientClick", getRootElement(), fuelClick)
	end
	syncPumpDatas = {}
	for k, v in pairs(fuelingSounds) do
		if isElement(v) then
			destroyElement(v)
		end
	end
	fuelingSounds = {}
	initColorsAndFonts()
	currentFuelStation = fuelSyncZones[col]
	selfPump = false
	neededDoorProgress = #getElementsWithinColShape(fuelStations[currentFuelStation].storeDoors.colShape, "player") >= 1 and 1 or 0
	addEventHandler("onClientColShapeHit", fuelStations[currentFuelStation].storeDoors.colShape, enterStoreDoor)
	if currentFuelStation then
		fuelDigits = fuelStations[currentFuelStation].digits
		fuelDigitVectors = fuelStations[currentFuelStation].vectors
		triggerServerEvent("requestFuelStationSync", localPlayer, currentFuelStation)
	end
end
addEventHandler("onClientElementStreamIn", localPlayer, function(old, new)
	for col in pairs(fuelSyncZones) do
		if isElementWithinColShape(localPlayer, col) then
			streamInFuelStation(col)
		end
	end
end)
addEventHandler("onClientElementDimensionChange", localPlayer, function(old, new)
	for col in pairs(fuelSyncZones) do
		if isElementWithinColShape(localPlayer, col) then
			streamInFuelStation(col)
		end
	end
end)
function enterFuelSyncZone(el, md)
	if el == localPlayer and md then
		streamInFuelStation(source)
	end
end
function leaveFuelSyncZone(el, md)
	if el == localPlayer and md then
		if currentFuelStation then
			removeEventHandler("onClientColShapeHit", fuelStations[currentFuelStation].storeDoors.colShape, enterStoreDoor)
			removeEventHandler("onClientRender", getRootElement(), renderFuelStation)
			removeEventHandler("onClientClick", getRootElement(), fuelClick)
		end
		syncPumpDatas = {}
		for k, v in pairs(fuelingSounds) do
			if isElement(v) then
				destroyElement(v)
			end
		end
		fuelingSounds = {}
		currentFuelStation = false
		fuelDigits = {}
		fuelDigitVectors = {}
	end
end
function initmainFuelElements()
	for i = 1, #mainFuelElements do
		if isElement(mainFuelElements[i]) then
			destroyElement(mainFuelElements[i])
		end
	end
	mainFuelElements = {}
	fuelSyncZones = {}
	for i = 1, #fuelStations do
		fuelStations[i].syncZone = createColSphere(fuelStations[i].stationPos[1], fuelStations[i].stationPos[2], fuelStations[i].stationPos[3], 100)
		fuelSyncZones[fuelStations[i].syncZone] = i
		addEventHandler("onClientColShapeHit", fuelStations[i].syncZone, enterFuelSyncZone)
		addEventHandler("onClientColShapeLeave", fuelStations[i].syncZone, leaveFuelSyncZone)
		table.insert(mainFuelElements, fuelStations[i].syncZone)
		local store = createObject(objectModels.sight_soil_store, fuelStations[i].storePos[1], fuelStations[i].storePos[2], fuelStations[i].storePos[3], 0, 0, fuelStations[i].storePos[4])
		local storeLOD = createObject(objectModels.sight_soil_store_LOD, fuelStations[i].storePos[1], fuelStations[i].storePos[2], fuelStations[i].storePos[3], 0, 0, fuelStations[i].storePos[4], true)
		setElementDimension(store, -1)
		setElementDimension(storeLOD, -1)
		setLowLODElement(store, storeLOD)
		table.insert(mainFuelElements, store)
		table.insert(mainFuelElements, storeLOD)
		local glassOffX = 2.5E-5
		local glassOffY = 5.53034
		local glassOffZ = 1.58612
		local gMatrix = getElementMatrix(store)
		local storeGlass = createObject(objectModels.sight_soil_store_alpha, glassOffX * gMatrix[1][1] + glassOffY * gMatrix[2][1] + glassOffZ * gMatrix[3][1] + gMatrix[4][1], glassOffX * gMatrix[1][2] + glassOffY * gMatrix[2][2] + glassOffZ * gMatrix[3][2] + gMatrix[4][2], glassOffX * gMatrix[1][3] + glassOffY * gMatrix[2][3] + glassOffZ * gMatrix[3][3] + gMatrix[4][3], 0, 0, fuelStations[i].storePos[4])
		setElementCollisionsEnabled(storeGlass, false)
		setElementDimension(storeGlass, -1)
		table.insert(mainFuelElements, storeGlass)
		fuelStations[i].storeElement = store
		local pedOffX = -7.73841
		local pedOffY = 0.761253
		local pedOffZ = 0.982498
		fuelStations[i].storePed = createPed(fuelStations[i].clerkSkin, pedOffX * gMatrix[1][1] + pedOffY * gMatrix[2][1] + pedOffZ * gMatrix[3][1] + gMatrix[4][1], pedOffX * gMatrix[1][2] + pedOffY * gMatrix[2][2] + pedOffZ * gMatrix[3][2] + gMatrix[4][2], pedOffX * gMatrix[1][3] + pedOffY * gMatrix[2][3] + pedOffZ * gMatrix[3][3] + gMatrix[4][3], fuelStations[i].storePos[4] - 90)
		setElementData(fuelStations[i].storePed, "invulnerable", true)
		setElementData(fuelStations[i].storePed, "visibleName", fuelStations[i].clerkName)
		setElementData(fuelStations[i].storePed, "pedNameType", "Benzinkút")
		setElementFrozen(fuelStations[i].storePed, true)
		table.insert(mainFuelElements, fuelStations[i].storePed)
		local storeProds = createObject(objectModels.sight_soil_store_prods, fuelStations[i].storePos[1], fuelStations[i].storePos[2], fuelStations[i].storePos[3], 0, 0, fuelStations[i].storePos[4])
		setElementDoubleSided(storeProds, true)
		setElementCollisionsEnabled(storeProds, false)
		setElementDimension(storeProds, -1)
		table.insert(mainFuelElements, storeProds)
		local doorOffX = {0.47153, -0.471482}
		local doorOffY = 5.54779
		local doorOffZ = 1.36487
		door1X = doorOffX[1] * gMatrix[1][1] + doorOffY * gMatrix[2][1] + doorOffZ * gMatrix[3][1] + gMatrix[4][1]
		door1Y = doorOffX[1] * gMatrix[1][2] + doorOffY * gMatrix[2][2] + doorOffZ * gMatrix[3][2] + gMatrix[4][2]
		door1Z = doorOffX[1] * gMatrix[1][3] + doorOffY * gMatrix[2][3] + doorOffZ * gMatrix[3][3] + gMatrix[4][3]
		door2X = doorOffX[2] * gMatrix[1][1] + doorOffY * gMatrix[2][1] + doorOffZ * gMatrix[3][1] + gMatrix[4][1]
		door2Y = doorOffX[2] * gMatrix[1][2] + doorOffY * gMatrix[2][2] + doorOffZ * gMatrix[3][2] + gMatrix[4][2]
		door2Z = doorOffX[2] * gMatrix[1][3] + doorOffY * gMatrix[2][3] + doorOffZ * gMatrix[3][3] + gMatrix[4][3]
		fuelStations[i].storeDoors = {
			colShape = createColSphere(0 * gMatrix[1][1] + doorOffY * gMatrix[2][1] + doorOffZ * gMatrix[3][1] + gMatrix[4][1], 0 * gMatrix[1][2] + doorOffY * gMatrix[2][2] + doorOffZ * gMatrix[3][2] + gMatrix[4][2], 0 * gMatrix[1][3] + doorOffY * gMatrix[2][3] + doorOffZ * gMatrix[3][3] + gMatrix[4][3], 3),
			door1 = createObject(objectModels.sight_soil_door, door1X, door1Y, door1Z, 0, 0, fuelStations[i].storePos[4]),
			door1Pos = {
				door1X,
				door1Y,
				door1Z
			},
			door2 = createObject(objectModels.sight_soil_door, door2X, door2Y, door2Z, 0, 0, fuelStations[i].storePos[4]),
			door2Pos = {
				door2X,
				door2Y,
				door2Z
			},
			soundPos = {
				(door1X + door2X) / 2,
				(door1Y + door2Y) / 2,
				(door1Z + door2Z) / 2
			}
		}
		setElementDoubleSided(fuelStations[i].storeDoors.door1, true)
		setElementDoubleSided(fuelStations[i].storeDoors.door2, true)
		setElementDimension(fuelStations[i].storeDoors.door1, -1)
		setElementDimension(fuelStations[i].storeDoors.door2, -1)
		table.insert(mainFuelElements, fuelStations[i].storeDoors.door1)
		table.insert(mainFuelElements, fuelStations[i].storeDoors.door1)
		table.insert(mainFuelElements, fuelStations[i].storeDoors.colShape)
		local station = createObject(objectModels[fuelStations[i].stationModel], fuelStations[i].stationPos[1], fuelStations[i].stationPos[2], fuelStations[i].stationPos[3], 0, 0, fuelStations[i].stationPos[4])
		local stationLOD = createObject(objectModels[fuelStations[i].stationModel_LOD], fuelStations[i].stationPos[1], fuelStations[i].stationPos[2], fuelStations[i].stationPos[3], 0, 0, fuelStations[i].stationPos[4], true)
		setLowLODElement(station, stationLOD)
		setElementDimension(station, -1)
		setElementDimension(stationLOD, -1)
		table.insert(mainFuelElements, station)
		table.insert(mainFuelElements, stationLOD)
		local pMatrix = getElementMatrix(station)
		fuelStations[i].pumpPoses = {}
		local pnum = 0
		local insideColPos = {}
		if fuelStations[i].stationModel == "sight_soil_station" then
			table.insert(insideColPos, -16.6282 * pMatrix[1][1] + 7.36831 * pMatrix[2][1] + pMatrix[4][1])
			table.insert(insideColPos, -16.6282 * pMatrix[1][2] + 7.36831 * pMatrix[2][2] + pMatrix[4][2])
			table.insert(insideColPos, -16.6282 * pMatrix[1][1] - 6.2981 * pMatrix[2][1] + pMatrix[4][1])
			table.insert(insideColPos, -16.6282 * pMatrix[1][2] - 6.2981 * pMatrix[2][2] + pMatrix[4][2])
			table.insert(insideColPos, 16.5123 * pMatrix[1][1] - 6.2981 * pMatrix[2][1] + pMatrix[4][1])
			table.insert(insideColPos, 16.5123 * pMatrix[1][2] - 6.2981 * pMatrix[2][2] + pMatrix[4][2])
			table.insert(insideColPos, 16.5123 * pMatrix[1][1] + 7.36831 * pMatrix[2][1] + pMatrix[4][1])
			table.insert(insideColPos, 16.5123 * pMatrix[1][2] + 7.36831 * pMatrix[2][2] + pMatrix[4][2])
			local pumpOffX = {
				10.5394,
				0.005737,
				-10.5279
			}
			local pumpOffY = 1.03691
			local pumpOffZ = -1.65737
			for pump = 1, 3 do
				local obj = createObject(objectModels.sight_soil_pump, pumpOffX[pump] * pMatrix[1][1] + pumpOffY * pMatrix[2][1] + pumpOffZ * pMatrix[3][1] + pMatrix[4][1], pumpOffX[pump] * pMatrix[1][2] + pumpOffY * pMatrix[2][2] + pumpOffZ * pMatrix[3][2] + pMatrix[4][2], pumpOffX[pump] * pMatrix[1][3] + pumpOffY * pMatrix[2][3] + pumpOffZ * pMatrix[3][3] + pMatrix[4][3], 0, 0, fuelStations[i].stationPos[4])
				setElementDimension(obj, -1)
				fuelStations[i].pumpPoses[pump] = {
					pumpOffX[pump] * pMatrix[1][1] + pumpOffY * pMatrix[2][1] + pumpOffZ * pMatrix[3][1] + pMatrix[4][1],
					pumpOffX[pump] * pMatrix[1][2] + pumpOffY * pMatrix[2][2] + pumpOffZ * pMatrix[3][2] + pMatrix[4][2],
					pumpOffX[pump] * pMatrix[1][3] + pumpOffY * pMatrix[2][3] + pumpOffZ * pMatrix[3][3] + pMatrix[4][3],
					fuelStations[i].stationPos[4]
				}
				table.insert(mainFuelElements, obj)
				pnum = pump * 2
			end
		elseif fuelStations[i].stationModel == "sight_soil_station_mid" then
			table.insert(insideColPos, -11.3133 * pMatrix[1][1] + 7.29973 * pMatrix[2][1] + pMatrix[4][1])
			table.insert(insideColPos, -11.3133 * pMatrix[1][2] + 7.29973 * pMatrix[2][2] + pMatrix[4][2])
			table.insert(insideColPos, -11.3133 * pMatrix[1][1] - 6.40847 * pMatrix[2][1] + pMatrix[4][1])
			table.insert(insideColPos, -11.3133 * pMatrix[1][2] - 6.40847 * pMatrix[2][2] + pMatrix[4][2])
			table.insert(insideColPos, 11.1634 * pMatrix[1][1] - 6.40847 * pMatrix[2][1] + pMatrix[4][1])
			table.insert(insideColPos, 11.1634 * pMatrix[1][2] - 6.40847 * pMatrix[2][2] + pMatrix[4][2])
			table.insert(insideColPos, 11.1634 * pMatrix[1][1] + 7.29973 * pMatrix[2][1] + pMatrix[4][1])
			table.insert(insideColPos, 11.1634 * pMatrix[1][2] + 7.29973 * pMatrix[2][2] + pMatrix[4][2])
			local pumpOffX = {5.19039, -5.34325}
			local pumpOffY = 0.951815
			local pumpOffZ = -2.10435
			for pump = 1, 2 do
				local obj = createObject(objectModels.sight_soil_pump, pumpOffX[pump] * pMatrix[1][1] + pumpOffY * pMatrix[2][1] + pumpOffZ * pMatrix[3][1] + pMatrix[4][1], pumpOffX[pump] * pMatrix[1][2] + pumpOffY * pMatrix[2][2] + pumpOffZ * pMatrix[3][2] + pMatrix[4][2], pumpOffX[pump] * pMatrix[1][3] + pumpOffY * pMatrix[2][3] + pumpOffZ * pMatrix[3][3] + pMatrix[4][3], 0, 0, fuelStations[i].stationPos[4])
				setElementDimension(obj, -1)
				fuelStations[i].pumpPoses[pump] = {
					pumpOffX[pump] * pMatrix[1][1] + pumpOffY * pMatrix[2][1] + pumpOffZ * pMatrix[3][1] + pMatrix[4][1],
					pumpOffX[pump] * pMatrix[1][2] + pumpOffY * pMatrix[2][2] + pumpOffZ * pMatrix[3][2] + pMatrix[4][2],
					pumpOffX[pump] * pMatrix[1][3] + pumpOffY * pMatrix[2][3] + pumpOffZ * pMatrix[3][3] + pMatrix[4][3],
					fuelStations[i].stationPos[4]
				}
				table.insert(mainFuelElements, obj)
				pnum = pump * 2
			end
		end
		fuelStations[i].insideCol = createColPolygon(insideColPos[1], insideColPos[2], unpack(insideColPos))
		table.insert(mainFuelElements, fuelStations[i].insideCol)
		fuelStations[i].signPoses = {}
		if fuelStations[i].signs then
			for signID = 1, #fuelStations[i].signs do
				local sign = createObject(objectModels.sight_soil_sign, fuelStations[i].signs[signID][1], fuelStations[i].signs[signID][2], fuelStations[i].signs[signID][3], 0, 0, fuelStations[i].signs[signID][4])
				local signLOD = createObject(objectModels.sight_soil_sign_LOD, fuelStations[i].signs[signID][1], fuelStations[i].signs[signID][2], fuelStations[i].signs[signID][3], 0, 0, fuelStations[i].signs[signID][4], true)
				setLowLODElement(sign, signLOD)
				setElementDimension(sign, -1)
				setElementDimension(signLOD, -1)
				table.insert(mainFuelElements, sign)
				table.insert(mainFuelElements, signLOD)
				fuelStations[i].signPoses[signID] = {
					fuelStations[i].signs[signID][1],
					fuelStations[i].signs[signID][2],
					fuelStations[i].signs[signID][3],
					fuelStations[i].signs[signID][4]
				}
			end
		end
		local dispalyX, displayY, displayZ = 4.14865, 5.55, 2.92969
		local ls = 0.15
		local xp = ls * (1.75 * (pnum - 1)) / 2
		fuelStations[i].pumpDisplays = {}
		local c = math.cos(math.rad(fuelStations[i].storePos[4]) + math.pi / 2)
		local s = math.sin(math.rad(fuelStations[i].storePos[4]) + math.pi / 2)
		for j = 1, pnum do
			local x = (dispalyX + xp) * gMatrix[1][1] + displayY * gMatrix[2][1] + displayZ * gMatrix[3][1] + gMatrix[4][1]
			local y = (dispalyX + xp) * gMatrix[1][2] + displayY * gMatrix[2][2] + displayZ * gMatrix[3][2] + gMatrix[4][2]
			local z = (dispalyX + xp) * gMatrix[1][3] + displayY * gMatrix[2][3] + displayZ * gMatrix[3][3] + gMatrix[4][3]
			fuelStations[i].pumpDisplays[j] = {
				x,
				y,
				z,
				c,
				s,
				ls
			}
			xp = xp - ls * 1.75
		end
	end
	loadPriceDisplays()
	loadFuelDisplays()
	loadFuelPistols()
	elementsSuccessfullyLoaded = true
end
function loadModelIds()
	objectModels = {
		sight_soil_station = sightexports.sModloader:getModelId("v4_soil_station"),
		sight_soil_station_mid = sightexports.sModloader:getModelId("v4_soil_station_mid"),
		sight_soil_station_LOD = sightexports.sModloader:getModelId("v4_soil_station_LOD"),
		sight_soil_station_mid_LOD = sightexports.sModloader:getModelId("v4_soil_station_mid_LOD"),
		sight_soil_store = sightexports.sModloader:getModelId("v4_soil_store"),
		sight_soil_store_LOD = sightexports.sModloader:getModelId("v4_soil_store_LOD"),
		sight_soil_store_alpha = sightexports.sModloader:getModelId("v4_soil_store_alpha"),
		sight_soil_store_prods = sightexports.sModloader:getModelId("v4_soil_store_prods"),
		sight_soil_pump = sightexports.sModloader:getModelId("v4_soil_pump"),
		sight_soil_sign = sightexports.sModloader:getModelId("v4_soil_sign"),
		sight_soil_sign_LOD = sightexports.sModloader:getModelId("v4_soil_sign_LOD"),
		sight_soil_door = sightexports.sModloader:getModelId("v4_soil_door"),
		sight_soil_fuelnozzle = sightexports.sModloader:getModelId("v4_soil_fuelnozzle"),
		sight_soil_fuelnozzle_diesel = sightexports.sModloader:getModelId("v4_soil_fuelnozzle_diesel")
	}
	initmainFuelElements()
end
addEvent("modloaderLoaded", false)
addEventHandler("modloaderLoaded", getRootElement(), loadModelIds)
local fuelPrices = {}
local heliFuelPrice = 0
function getHeliFuelPrices()
	return heliFuelPrice
end
addEvent("syncFuelPrices", true)
addEventHandler("syncFuelPrices", getRootElement(), function(data)
	fuelPrices = data
	local sum = 0
	for i = 1, #fuelStations do
		sum = sum + fuelPrices[i][3]
	end
	heliFuelPrice = math.floor(sum / #fuelStations * 1.1)
	for i = 1, #fuelStations do
		processPriceDisplay(i)
	end
end)
local stationSyncDatas = {}
local calibratePumpList = {}
local fuelingPumpList = {}
addEvent("calibrateFuelPump", true)
addEventHandler("calibrateFuelPump", getRootElement(), function(station, pump)
	if station == currentFuelStation then
		calibratePumpList[pump] = getTickCount()
		processFuelDisplay(pump)
	end
end)
function processPumsPattach(pump)
	if fuelStations[currentFuelStation].pistolAttaced[pump] then
		local i = fuelStations[currentFuelStation].pistolAttaced[pump]
		if fuelStations[currentFuelStation].pistols[pump][i] then
			detachElements(fuelStations[currentFuelStation].pistols[pump][i])
			sightexports.sPattach:detach(fuelStations[currentFuelStation].pistols[pump][i])
			local x, y, z, rz = unpack(fuelStations[currentFuelStation].pistolPoses[pump][i])
			setElementPosition(fuelStations[currentFuelStation].pistols[pump][i], x, y, z)
			setElementRotation(fuelStations[currentFuelStation].pistols[pump][i], 0, -5, rz)
			fuelStations[currentFuelStation].pistolAttaced[pump] = nil
		end
	end
	if stationSyncDatas[pump] and stationSyncDatas[pump].fuelType and isElement(stationSyncDatas[pump].controller) and stationSyncDatas[pump].pistolInHand then
		local i = stationSyncDatas[pump].fuelType
		if fuelStations[currentFuelStation].pistols[pump][i] then
			sightexports.sPattach:attach(fuelStations[currentFuelStation].pistols[pump][i], stationSyncDatas[pump].controller, "right-hand", 0.1, 0.05, 0, 0, 0, 110)
			fuelStations[currentFuelStation].pistolAttaced[pump] = i
		end
	end
	if stationSyncDatas[pump] and isElement(stationSyncDatas[pump].pistolInVehicle) then
		local i = stationSyncDatas[pump].fuelType
		if fuelStations[currentFuelStation].pistols[pump][i] then
			local x, y, z, ry, rz = getFuelCapPosition(stationSyncDatas[pump].pistolInVehicle)
			attachElements(fuelStations[currentFuelStation].pistols[pump][i], stationSyncDatas[pump].pistolInVehicle, x, y, z, 0, ry, rz)
			fuelStations[currentFuelStation].pistolAttaced[pump] = i
		end
	end
end
function playFuelSound(sound, pump, ft)
	local x, y, z = 0, 0, 0
	if ft then
		x, y, z = unpack(fuelStations[currentFuelStation].pistolPoses[pump][ft])
	else
		x, y, z = unpack(fuelStations[currentFuelStation].pumpPoses[math.ceil(pump / 2)])
	end
	local sound = playSound3D("files/" .. sound, x, y, z)
end
addEvent("syncPumpDatas", true)
addEventHandler("syncPumpDatas", getRootElement(), function(station, data, display)
	if station == currentFuelStation then
		for pump in pairs(data) do
			local fType = (not stationSyncDatas[pump] or not stationSyncDatas[pump].fuelType) and data[pump] and data[pump].fuelType
			local wasHand = stationSyncDatas[pump] and stationSyncDatas[pump].pistolInHand
			local wasVeh = isElement(stationSyncDatas[pump] and stationSyncDatas[pump].pistolInVehicle)
			if data[pump] then
				if not stationSyncDatas[pump] then
					stationSyncDatas[pump] = {}
				end
				for value in pairs(data[pump]) do
					stationSyncDatas[pump][value] = data[pump][value]
				end
			else
				stationSyncDatas[pump] = nil
			end
			if stationSyncDatas[pump] and stationSyncDatas[pump].fueling then
				fuelingPumpList[pump] = getTickCount()
				if isElement(fuelingSounds[pump]) then
					destroyElement(fuelingSounds[pump])
				end
				local x, y, z = unpack(fuelStations[currentFuelStation].pumpPoses[math.ceil(pump / 2)])
				fuelingSounds[pump] = playSound3D("files/fuelfill.mp3", x, y, z, true)
				setSoundMaxDistance(fuelingSounds[pump], 50)
			else
				if fuelingPumpList[pump] and stationSyncDatas[pump].maximumFuel <= 0 then
					playFuelSound("tankfull.mp3", pump, fType)
				end
				fuelingPumpList[pump] = nil
				if isElement(fuelingSounds[pump]) then
					destroyElement(fuelingSounds[pump])
				end
				fuelingSounds[pump] = nil
			end
			if stationSyncDatas[pump] and stationSyncDatas[pump].controller == localPlayer then
				selfPump = pump
			elseif selfPump == pump then
				selfPump = false
			end
			local newHand = stationSyncDatas[pump] and stationSyncDatas[pump].pistolInHand
			local newVeh = isElement(stationSyncDatas[pump] and stationSyncDatas[pump].pistolInVehicle)
			if wasHand ~= newHand or wasVeh ~= newVeh then
				processPumsPattach(pump)
			end
			if wasHand and not newHand and not newVeh then
				playFuelSound("fuelpickup.mp3", pump, fType)
			elseif newVeh and not wasVeh then
				playFuelSound("fuelstart.mp3", pump, fType)
			elseif not newVeh and wasVeh then
				playFuelSound("fuelover.mp3", pump, fType)
			elseif newHand and not wasHand then
				playFuelSound("fuelpickup.mp3", pump, fType)
			end
			if display then
				processFuelDisplay(pump)
			end
		end
	end
end)
local pistolOffsets = {
	{
		0.649296,
		0.458715,
		-0.13163
	},
	{
		0.649296,
		0.271227,
		-0.13163
	},
	{
		0.649296,
		0.08374,
		-0.13163
	},
	{
		0.649296,
		-0.103748,
		-0.13163
	},
	{
		0.649296,
		-0.291236,
		-0.13163
	}
}
function loadFuelPistols(station)
	for i = 1, #fuelStations do
		local fuelDisplays = {}
		fuelStations[i].pumpPistolCenters = {}
		fuelStations[i].pistols = {}
		fuelStations[i].pistolAttaced = {}
		fuelStations[i].pistolPoses = {}
		fuelStations[i].pistolBases = {}
		for j = 1, #fuelStations[i].pumpPoses do
			local rz = fuelStations[i].pumpPoses[j][4]
			local bx, by, bz = fuelStations[i].pumpPoses[j][1], fuelStations[i].pumpPoses[j][2], fuelStations[i].pumpPoses[j][3]
			local c = math.cos(math.rad(rz))
			local s = math.sin(math.rad(rz))
			for k = 1, 2 do
				local pump = (j - 1) * 2 + k
				fuelStations[i].pistols[pump] = {}
				fuelStations[i].pistolAttaced[pump] = false
				fuelStations[i].pistolPoses[pump] = {}
				fuelStations[i].pistolBases[pump] = {}
				for l = 1, #fuelTypeNames do
					local sm = k == 2 and -1 or 1
					local x = bx + pistolOffsets[l][1] * sm * c - pistolOffsets[l][2] * s
					local y = by + pistolOffsets[l][1] * sm * s + pistolOffsets[l][2] * c
					local z = bz + pistolOffsets[l][3]
					local x2 = bx + (pistolOffsets[l][1] - 0.185) * sm * c - (pistolOffsets[l][2] - 0.03 * sm) * s
					local y2 = by + (pistolOffsets[l][1] - 0.185) * sm * s + (pistolOffsets[l][2] - 0.03 * sm) * c
					local z2 = bz + pistolOffsets[l][3] - 0.5
					if k == 2 then
						l = #fuelTypeNames - l + 1
					end
					local model = l <= 2 and "sight_soil_fuelnozzle_diesel" or "sight_soil_fuelnozzle"
					fuelStations[i].pistols[pump][l] = createObject(objectModels[model], x, y, z, 0, -5, rz + 180 * (k - 1))
					fuelStations[i].pistolPoses[pump][l] = {
						x,
						y,
						z,
						rz + 180 * (k - 1)
					}
					fuelStations[i].pistolBases[pump][l] = {
						x2,
						y2,
						z2
					}
					setElementDimension(fuelStations[i].pistols[pump][l], -1)
					setElementCollisionsEnabled(fuelStations[i].pistols[pump][l], false)
					table.insert(mainFuelElements, fuelStations[i].pistols[pump][l])
				end
				fuelStations[i].pumpPistolCenters[pump] = {
					fuelStations[i].pistolPoses[pump][math.floor(#fuelTypeNames / 2 + 0.5)][1],
					fuelStations[i].pistolPoses[pump][math.floor(#fuelTypeNames / 2 + 0.5)][2],
					fuelStations[i].pistolPoses[pump][math.floor(#fuelTypeNames / 2 + 0.5)][3]
				}
			end
		end
	end
end
function loadFuelDisplays(station)
	for i = 1, #fuelStations do
		local fuelDisplays = {}
		for j = 1, #fuelStations[i].pumpPoses do
			calculateFuelDisplays(fuelDisplays, fuelStations[i].pumpPoses[j][1], fuelStations[i].pumpPoses[j][2], fuelStations[i].pumpPoses[j][3], fuelStations[i].pumpPoses[j][4])
		end
		fuelStations[i].digits, fuelStations[i].vectors = calculateFuelDigits(fuelDisplays)
	end
end
function loadPriceDisplays()
	priceDigits = {}
	priceDigitVectors = {}
	priceDigitStationIds = {}
	for i = 1, #fuelStations do
		local priceDisplays = {}
		for j = 1, #fuelStations[i].signPoses do
			calculatePriceDisplays(priceDisplays, fuelStations[i].signPoses[j][1], fuelStations[i].signPoses[j][2], fuelStations[i].signPoses[j][3], fuelStations[i].signPoses[j][4])
		end
		calculatePriceDigits(priceDisplays, i)
		processPriceDisplay(i)
	end
	triggerServerEvent("requestFuelPrices", localPlayer)
end
function drawSegment(x, y, z, cos, sin, s, bd, digit, bc, fc)
	if bd or digit then
		local bx, by, bz = x - cos * s / 100, y - sin * s / 100, z
		local fx, fy, fz = x + cos * 1, y + sin * 1, z
		if bd then
			sightlangStaticImageUsed[0] = true
			if sightlangStaticImageToc[0] then
				processsightlangStaticImage[0]()
			end
			dxDrawMaterialSectionLine3D(bx, by, bz + s, bx, by, bz - s, 32 * bd, 0, 32, 64, sightlangStaticImage[0], s, bc, fx, fy, fz)
		end
		if digit then
			sightlangStaticImageUsed[0] = true
			if sightlangStaticImageToc[0] then
				processsightlangStaticImage[0]()
			end
			dxDrawMaterialSectionLine3D(x, y, z + s, x, y, z - s, 32 * digit, 0, 32, 64, sightlangStaticImage[0], s, fc, fx, fy, fz)
		end
	end
end
function processFuelDisplay(pump)
	local digits = fuelDigits[pump]
	local liter, literPrice, price
	local calib = calibratePumpList[pump]
	if not calib and stationSyncDatas[pump] then
		literPrice = stationSyncDatas[pump].fuelPrice
		liter = stationSyncDatas[pump].fuelAmount
		if fuelingPumpList[pump] then
			local sec = (getTickCount() - fuelingPumpList[pump]) / 1000
			if sec < 1 then
				sec = sec * sec
			end
			liter = liter + sec * fuelFlow
		end
		if tonumber(liter) and tonumber(literPrice) then
			price = liter * literPrice
		end
	end
	local work = tonumber(price) and tonumber(liter) and tonumber(literPrice)
	if work then
		price = math.floor(price + 0.5)
		liter = math.floor(liter * 100 + 0.5)
		literPrice = math.floor(literPrice * 10 + 0.5)
		if 99999 < price then
			price = 99999
		end
		if 99999 < liter then
			liter = 99999
		end
		if 9999 < literPrice then
			literPrice = 9999
		end
		price = tostring(price)
		liter = tostring(liter)
		literPrice = tostring(literPrice)
		for i = utf8.len(price) + 1, 5 do
			price = "-" .. price
		end
		for i = utf8.len(liter) + 1, 5 do
			if i <= 3 then
				liter = "0" .. liter
			else
				liter = "-" .. liter
			end
		end
		for i = utf8.len(literPrice) + 1, 4 do
			if i <= 2 then
				literPrice = "0" .. literPrice
			else
				literPrice = "-" .. literPrice
			end
		end
	end
	local d = 0
	if digits then
		for i = 1, #digits do
			local bc, fc = 8, false
			if i == 10 or i == 17 then
				bc, fc = 10, 10
			elseif i == 6 or i == 19 then
				bc, fc = 11, 13
			elseif i == 20 then
				bc, fc = 11, 12
			elseif i == 21 or i == 13 then
				bc, fc = 11, 14
			end
			if work then
				if 14 <= i and i <= 18 and i ~= 17 then
					d = d + 1
					fc = tonumber(utf8.sub(literPrice, d - 10, d - 10))
				elseif 7 <= i and i <= 12 and i ~= 10 then
					d = d + 1
					fc = tonumber(utf8.sub(liter, d - 5, d - 5))
				elseif i <= 5 then
					d = d + 1
					fc = tonumber(utf8.sub(price, d, d))
				end
			elseif calib then
				fc = bc
			else
				fc = false
			end
			digits[i][5] = bc
			digits[i][6] = fc
		end
	end
end
function drawFuelDisplay(digits, c, s)
	for i = 1, #digits do
		drawSegment(digits[i][1], digits[i][2], digits[i][3], c, s, digits[i][4], digits[i][5], digits[i][6], tocolor(30, 30, 30, 60), tocolor(0, 5, 0))
	end
end
function drawPriceDisplay(digits, c, s, ls)
	for i = 1, #digits do
		drawSegment(digits[i][1], digits[i][2], digits[i][3], c, s, ls, digits[i][4], digits[i][5], tocolor(0, 0, 0, 55), tocolor(219, 233, 244))
	end
end
function calculateFuelDisplays(tbl, x, y, z, rz)
	rz = math.rad(rz)
	local c = math.cos(rz)
	local s = math.sin(rz)
	local px = x + 0.54 * c + 0.68886 * s
	local py = y + 0.54 * s - 0.68886 * c
	table.insert(tbl, {
		px,
		py,
		z + 0.811203,
		c,
		s
	})
	local px = x - 0.54 * c + 0.68886 * s
	local py = y - 0.54 * s - 0.68886 * c
	table.insert(tbl, {
		px,
		py,
		z + 0.811203,
		-c,
		-s
	})
end
function calculateFuelDigits(fuelDisplays)
	local digits = {}
	local vectors = {}
	for i = 1, #fuelDisplays do
		digits[i] = {}
		local x, y, z = fuelDisplays[i][1], fuelDisplays[i][2], fuelDisplays[i][3]
		local c, s = fuelDisplays[i][4], fuelDisplays[i][5]
		local nc, ns = -fuelDisplays[i][5], fuelDisplays[i][4]
		vectors[i] = {c, s}
		local ls = 0.05
		local xp = ls * 5.5 / 2
		z = z + ls * 2 * 2 / 2
		table.insert(digits[i], {
			x - nc * xp,
			y - ns * xp,
			z,
			ls
		})
		xp = xp - ls * 1.1
		table.insert(digits[i], {
			x - nc * xp,
			y - ns * xp,
			z,
			ls
		})
		xp = xp - ls * 1.1
		table.insert(digits[i], {
			x - nc * xp,
			y - ns * xp,
			z,
			ls
		})
		xp = xp - ls * 1.1
		table.insert(digits[i], {
			x - nc * xp,
			y - ns * xp,
			z,
			ls
		})
		xp = xp - ls * 1.1
		table.insert(digits[i], {
			x - nc * xp,
			y - ns * xp,
			z,
			ls
		})
		xp = xp - ls * 1.1
		table.insert(digits[i], {
			x - nc * xp,
			y - ns * xp,
			z,
			ls
		})
		z = z - ls * 2
		xp = ls * 5.8 / 2
		table.insert(digits[i], {
			x - nc * xp,
			y - ns * xp,
			z,
			ls
		})
		xp = xp - ls * 1.1
		table.insert(digits[i], {
			x - nc * xp,
			y - ns * xp,
			z,
			ls
		})
		xp = xp - ls * 1.1
		table.insert(digits[i], {
			x - nc * xp,
			y - ns * xp,
			z,
			ls
		})
		xp = xp - ls * 0.3
		table.insert(digits[i], {
			x - nc * (xp - ls * 0.05),
			y - ns * (xp - ls * 0.05),
			z,
			ls
		})
		xp = xp - ls * 1.1
		table.insert(digits[i], {
			x - nc * xp,
			y - ns * xp,
			z,
			ls
		})
		xp = xp - ls * 1.1
		table.insert(digits[i], {
			x - nc * xp,
			y - ns * xp,
			z,
			ls
		})
		xp = xp - ls * 1.1
		table.insert(digits[i], {
			x - nc * xp,
			y - ns * xp,
			z,
			ls
		})
		z = z - ls * 2
		ls = ls * 0.75
		xp = ls * 6.9 / 2
		table.insert(digits[i], {
			x - nc * xp,
			y - ns * xp,
			z,
			ls
		})
		xp = xp - ls * 1.1
		table.insert(digits[i], {
			x - nc * xp,
			y - ns * xp,
			z,
			ls
		})
		xp = xp - ls * 1.1
		table.insert(digits[i], {
			x - nc * xp,
			y - ns * xp,
			z,
			ls
		})
		xp = xp - ls * 0.3
		table.insert(digits[i], {
			x - nc * (xp - ls * 0.05),
			y - ns * (xp - ls * 0.05),
			z,
			ls
		})
		xp = xp - ls * 1.1
		table.insert(digits[i], {
			x - nc * xp,
			y - ns * xp,
			z,
			ls
		})
		xp = xp - ls * 1.1
		table.insert(digits[i], {
			x - nc * xp,
			y - ns * xp,
			z,
			ls
		})
		xp = xp - ls * 1.1
		table.insert(digits[i], {
			x - nc * xp,
			y - ns * xp,
			z,
			ls
		})
		xp = xp - ls * 1.1
		table.insert(digits[i], {
			x - nc * xp,
			y - ns * xp,
			z,
			ls
		})
	end
	return digits, vectors
end
function calculatePriceDigits(priceDisplays, station)
	for i = 1, #priceDisplays do
		local id = #priceDigits + 1
		priceDigits[id] = {}
		local x, y, z = priceDisplays[i][1], priceDisplays[i][2], priceDisplays[i][3]
		local c, s = priceDisplays[i][4], priceDisplays[i][5]
		local nc, ns = -priceDisplays[i][5], priceDisplays[i][4]
		local ls = 0.18
		priceDigitVectors[id] = {
			c,
			s,
			ls,
			x,
			y,
			z
		}
		priceDigitStationIds[id] = station
		for j = -2, 2 do
			local z = z + 0.6026 * j
			local xp = -ls * 3.6 / 2
			table.insert(priceDigits[id], {
				x + nc * xp,
				y + ns * xp,
				z,
				8,
				false
			})
			xp = xp + ls * 1.1
			table.insert(priceDigits[id], {
				x + nc * xp,
				y + ns * xp,
				z,
				8,
				false
			})
			xp = xp + ls * 1.1
			table.insert(priceDigits[id], {
				x + nc * xp,
				y + ns * xp,
				z,
				8,
				false
			})
			xp = xp + ls * 0.3
			table.insert(priceDigits[id], {
				x + nc * (xp + ls * 0.05),
				y + ns * (xp + ls * 0.05),
				z,
				10,
				false
			})
			xp = xp + ls * 1.1
			table.insert(priceDigits[id], {
				x + nc * xp,
				y + ns * xp,
				z,
				8,
				false
			})
		end
	end
end
function processPriceDisplay(station)
	local prices = fuelPrices[station]
	if prices then
		for i = 1, #prices do
			prices[i] = math.floor((tonumber(prices[i]) or 0) * 10 + 0.5)
			if 9999 < prices[i] then
				prices[i] = 9999
			end
			prices[i] = tostring(prices[i])
			for j = utf8.len(prices[i]) + 1, 4 do
				prices[i] = "-" .. prices[i]
			end
		end
		for i = 1, #priceDigits do
			if priceDigits[i] and priceDigitStationIds[i] == station then
				local c = 0
				for j = 1, #priceDigits[i] do
					if j % 5 == 4 then
						priceDigits[i][j][4] = 10
						priceDigits[i][j][5] = 10
					else
						local char = c % 4 + 1
						local price = prices[math.floor(c / 4) + 1]
						priceDigits[i][j][4] = 8
						priceDigits[i][j][5] = tonumber(utf8.sub(price, char, char))
						c = c + 1
					end
				end
			end
		end
	end
end
function calculatePriceDisplays(tbl, x, y, z, rz)
	rz = math.rad(rz)
	local c = math.cos(rz)
	local s = math.sin(rz)
	local px = x - 0.475 * c + 0.84 * s
	local py = y - 0.475 * s - 0.84 * c
	table.insert(tbl, {
		px,
		py,
		z + 3.265,
		-c,
		-s
	})
	local px = x + 0.475 * c - 0.84 * s
	local py = y + 0.475 * s + 0.84 * c
	table.insert(tbl, {
		px,
		py,
		z + 3.265,
		c,
		s
	})
end
local nearestPump = false
local nearestVeh = false
local nearestFuelType = false
addEventHandler("onClientPreRender", getRootElement(), function(delta)
	local x, y, z = getElementPosition(localPlayer)
	for i = 1, #priceDigits do
		if priceDigits[i] and getDistanceBetweenPoints2D(x, y, priceDigitVectors[i][4], priceDigitVectors[i][5]) < 250 then
			drawPriceDisplay(priceDigits[i], priceDigitVectors[i][1], priceDigitVectors[i][2], priceDigitVectors[i][3])
		end
	end
	if currentFuelStation then
		local now = getTickCount()
		local desLen = 5
		local losLen = 0.5
		local segs = 10
		local displays = fuelStations[currentFuelStation].pumpDisplays
		for pump = 1, #displays do
			for l = 1, #fuelTypeNames do
				local x, y, z
				if stationSyncDatas[pump] and fuelStations[currentFuelStation].pistolAttaced[pump] == l then
					x, y, z = getElementPosition(fuelStations[currentFuelStation].pistols[pump][l])
				else
					x, y, z = unpack(fuelStations[currentFuelStation].pistolPoses[pump][l])
				end
				local x2, y2, z2 = unpack(fuelStations[currentFuelStation].pistolBases[pump][l])
				local d = getDistanceBetweenPoints3D(x, y, z, x2, y2, z2)
				if d < 100 then
					local loose = (desLen - d) / desLen
					if 0 < loose then
						local vx, vy, vz = (x2 - x) / segs, (y2 - y) / segs, (z2 - z) / segs
						local zp = 0
						for i = 1, segs do
							local p = i / segs * 2
							if 1 < p then
								p = 2 - p
							end
							zpn = -math.sin(p * math.pi / 2) * loose * losLen
							dxDrawLine3D(x + vx * (i - 1), y + vy * (i - 1), z + vz * (i - 1) + zp, x + vx * i, y + vy * i, z + vz * i + zpn, tocolor(0, 0, 0), 2)
							zp = zpn
						end
					else
						dxDrawLine3D(x, y, z, x2, y2, z2, tocolor(0, 0, 0), 2)
					end
				end
			end
		end
		local pulse = now % 1000 > 500
		for i = 1, #displays do
			if stationSyncDatas[i] then
				if stationSyncDatas[i].pistolInHand or stationSyncDatas[i].pistolInVehicle then
					drawSegment(displays[i][1], displays[i][2], displays[i][3], displays[i][4], displays[i][5], displays[i][6], 8, i, tocolor(55, 55, 55, 75), tocolor(0, 225, 95))
				else
					drawSegment(displays[i][1], displays[i][2], displays[i][3], displays[i][4], displays[i][5], displays[i][6], 8, pulse and i, tocolor(55, 55, 55, 75), tocolor(0, 225, 95))
				end
			else
				drawSegment(displays[i][1], displays[i][2], displays[i][3], displays[i][4], displays[i][5], displays[i][6], 8, false, tocolor(55, 55, 55, 75), false)
			end
		end
		if 0 < neededDoorProgress then
			neededDoorProgress = 1 <= #getElementsWithinColShape(fuelStations[currentFuelStation].storeDoors.colShape, "player") and 1 or 0
			if neededDoorProgress <= 0 then
				playDoorSound()
			end
		end
		local refresh = true
		if currentDoorProgress < neededDoorProgress then
			currentDoorProgress = currentDoorProgress + delta / 1200
			if currentDoorProgress > neededDoorProgress then
				currentDoorProgress = neededDoorProgress
			end
			refresh = true
		elseif currentDoorProgress > neededDoorProgress then
			currentDoorProgress = currentDoorProgress - delta / 1250
			if currentDoorProgress < neededDoorProgress then
				currentDoorProgress = neededDoorProgress
			end
			refresh = true
		end
		if 0 < currentDoorProgress or refresh then
			rotOff = math.rad(fuelStations[currentFuelStation].storePos[4])
			local p = getEasingValue(currentDoorProgress, "InOutQuad")
			setElementPosition(fuelStations[currentFuelStation].storeDoors.door1, fuelStations[currentFuelStation].storeDoors.door1Pos[1] + 0.8 * math.cos(rotOff) * p, fuelStations[currentFuelStation].storeDoors.door1Pos[2] + 0.8 * math.sin(rotOff) * p, fuelStations[currentFuelStation].storeDoors.door1Pos[3])
			setElementPosition(fuelStations[currentFuelStation].storeDoors.door2, fuelStations[currentFuelStation].storeDoors.door2Pos[1] - 0.8 * math.cos(rotOff) * p, fuelStations[currentFuelStation].storeDoors.door2Pos[2] - 0.8 * math.sin(rotOff) * p, fuelStations[currentFuelStation].storeDoors.door2Pos[3])
		end
		for pump in pairs(fuelingPumpList) do
			processFuelDisplay(pump)
			if selfFueling and selfPump == pump then
				local sec = (getTickCount() - fuelingPumpList[pump]) / 1000
				if sec < 1 then
					sec = sec * sec
				end
				local liter = sec * fuelFlow
				if liter > stationSyncDatas[selfPump].maximumFuel then
					stopFueling()
				end
			end
		end
		for pump, t in pairs(calibratePumpList) do
			if not t or 1000 < now - t then
				calibratePumpList[pump] = nil
				processFuelDisplay(pump)
			end
		end
		local inVeh = isPedInVehicle(localPlayer)
		local tmpveh = false
		if selfPump then
			if not inVeh then
				local vehs = getElementsWithinColShape(fuelStations[currentFuelStation].insideCol, "vehicle")
				local minD = 10
				for i = 1, #vehs do
					local vx, vy, vz = getElementPosition(vehs[i])
					local d = getDistanceBetweenPoints3D(x, y, z, vx, vy, vz)
					if minD > d then
						minD = d
						tmpveh = vehs[i]
					end
				end
			end
			if stationSyncDatas[selfPump].pistolInHand or stationSyncDatas[selfPump].pistolInVehicle then
				local removePump = "Ide nem ér el a cső!"
				local l = stationSyncDatas[selfPump].fuelType
				if fuelTypeNames[l] then
					local x, y, z = 0, 0, 0
					local maxD = 3.5
					if stationSyncDatas[selfPump].pistolInHand then
						x, y, z = getElementPosition(localPlayer)
					elseif isElement(stationSyncDatas[selfPump].pistolInVehicle) then
						x, y, z = getElementPosition(fuelStations[currentFuelStation].pistols[selfPump][l])
						maxD = 5
					end
					local x2, y2, z2 = unpack(fuelStations[currentFuelStation].pistolBases[selfPump][l])
					local d = getDistanceBetweenPoints2D(x, y, x2, y2)
					if maxD >= d then
						local r = math.deg(math.atan2(y2 - y, x2 - x)) + selfPump % 2 * 180
						local a = math.abs((r - fuelStations[currentFuelStation].stationPos[4] + 180) % 360 - 180)
						if a < 80 then
							removePump = false
						end
					end
				end
				if isElement(stationSyncDatas[selfPump].pistolInVehicle) then
					if getElementModel(stationSyncDatas[selfPump].pistolInVehicle) ~= 611 and getVehicleEngineState(stationSyncDatas[selfPump].pistolInVehicle) then
						removePump = "Állítsd le a jármű motorját!"
					end
				elseif stationSyncDatas[selfPump].pistolInHand and inVeh then
					removePump = "Szállj ki a járműből!"
				end
				if removePump then
					stopFueling()
					stationSyncDatas[selfPump].pistolInHand = false
					stationSyncDatas[selfPump].pistolInVehicle = false
					processPumsPattach(selfPump)
					triggerServerEvent("putBackFuelPistol", localPlayer, true)
					sightexports.sGui:showInfobox("e", removePump)
				end
			end
		end
		if nearestVeh ~= tmpveh then
			nearestVeh = tmpveh
			if tmpveh then
				nearestFuelType = sightexports.sVehicles:getFuelType(tmpveh)
			end
		end
		local minD = 1
		nearestPump = false
		for i = 1, #fuelDigits do
			if not inVeh then
				local d = getDistanceBetweenPoints3D(x, y, z, fuelStations[currentFuelStation].pumpPistolCenters[i][1], fuelStations[currentFuelStation].pumpPistolCenters[i][2], fuelStations[currentFuelStation].pumpPistolCenters[i][3])
				if minD >= d then
					minD = d
					nearestPump = i
				end
			end
			if fuelDigits[i] then
				drawFuelDisplay(fuelDigits[i], fuelDigitVectors[i][1], fuelDigitVectors[i][2])
			end
		end
	end
end)
addEvent("stopFueling", true)
function stopFueling()
	selfFueling = false
	triggerServerEvent("setVehicleFuelingState", localPlayer, false)
end
addEventHandler("stopFueling", root, stopFueling)
local receiptStart = false
local receiptFont = false
local receiptFont2 = false
local receiptGUI = false
local receiptSound = false
local receiptSignature = false
local receiptSignatureStart = false
local receiptDate = false
local receiptId = false
local charMoney = 0
addEvent("refreshMoney", true)
addEventHandler("refreshMoney", getRootElement(), function(amount)
	charMoney = amount
end)
addEventHandler("onClientResourceStart", getResourceRootElement(), function()
	if getElementData(localPlayer, "loggedIn") then
		triggerServerEvent("requestMoney", localPlayer)
	end
end)
addEvent("payFuelReceipt", false)
addEventHandler("payFuelReceipt", getRootElement(), function()
	local money = math.floor(stationSyncDatas[selfPump].fuelAmount * stationSyncDatas[selfPump].fuelPrice + 0.5)
	if money > charMoney then
		sightexports.sGui:showInfobox("e", "Nincs elég pénzed!")
	else
		if receiptGUI then
			sightexports.sGui:deleteGuiElement(receiptGUI)
		end
		receiptGUI = false
		receiptSignatureStart = getTickCount()
		receiptSound = playSound("files/sign.mp3")
	end
end)
addEvent("cancelFuelReceipt", false)
addEventHandler("cancelFuelReceipt", getRootElement(), function()
	destroyReceipt()
end)
function destroyReceipt()
	if isElement(receiptSound) then
		destroyElement(receiptSound)
	end
	receiptSound = false
	if isElement(receiptFont) then
		destroyElement(receiptFont)
	end
	if isElement(receiptFont2) then
		destroyElement(receiptFont2)
	end
	receiptFont = false
	receiptFont2 = false
	receiptStart = false
	if receiptGUI then
		sightexports.sGui:deleteGuiElement(receiptGUI)
	end
	receiptGUI = false
	receiptSignature = false
	receiptSignatureStart = false
	setElementFrozen(localPlayer, false)
end
doubleClicked = false
function fuelClick(key, state, cx, cy, wx, wy, wz, clickedElement)
	if state == "up" then
		if selfFueling and not doubleClicked then
			stopFueling()
		end
	elseif state == "down" then
		if hoverCmd then
			if getTickCount() - lastClick < 500 and hoverCmd[1] ~= "startFueling" then
				sightexports.sGui:showInfobox("e", "Várj egy kicsit!")
				return
			end
			if hoverCmd[1] == "startFueling" then
				doubleClicked = false
				
				if getTickCount() - lastClick < 300 then
					doubleClicked = true
				end

				lastClick = getTickCount()

				if not selfFueling and nearestVeh and selfPump and stationSyncDatas[selfPump] then
					if stationSyncDatas[selfPump].maximumFuel > 0 then
						selfFueling = true
						triggerServerEvent("setVehicleFuelingState", localPlayer, true)
					else
						sightexports.sGui:showInfobox("e", "Tele a jármű tankja!")
					end
				end
			elseif hoverCmd[1] == "getPistolFrsight_soileh" then
				if selfPump then
					triggerServerEvent("getFuelPistolToHand", localPlayer, currentFuelStation, selfPump)
					lastClick = getTickCount()
				end
			elseif hoverCmd[1] == "getPistol" then
				if nearestPump then
					triggerServerEvent("getFuelPistolToHand", localPlayer, currentFuelStation, nearestPump, tonumber(hoverCmd[2]))
					lastClick = getTickCount()
				end
			elseif hoverCmd[1] == "pistolBack" then
				triggerServerEvent("putBackFuelPistol", localPlayer)
				lastClick = getTickCount()
			elseif hoverCmd[1] == "putPistolInVeh" and nearestVeh and selfPump then
				if getElementModel(nearestVeh) ~= 611 and getVehicleEngineState(nearestVeh) then
					sightexports.sGui:showInfobox("e", "Állítsd le a jármű motorját!")
				else
					triggerServerEvent("putFuelPistolInVehicle", nearestVeh)
					lastClick = getTickCount()
				end
			end
		elseif clickedElement and clickedElement == fuelStations[currentFuelStation].storePed then
			local x, y, z = getElementPosition(localPlayer)
			local x2, y2, z2 = getElementPosition(fuelStations[currentFuelStation].storePed)
			if not receiptStart and getDistanceBetweenPoints3D(x, y, z, x2, y2, z2) <= 2.5 and selfPump and stationSyncDatas[selfPump].fuelPrice and stationSyncDatas[selfPump].fuelAmount and not stationSyncDatas[selfPump].pistolInHand and not stationSyncDatas[selfPump].pistolInVehicle and not stationSyncDatas[selfPump].fueling then
				receiptStart = getTickCount()
				receiptGUI = false
				receiptSound = playSound("files/receipt.mp3")
				if isElement(receiptFont) then
					destroyElement(receiptFont)
				end
				if isElement(receiptFont2) then
					destroyElement(receiptFont2)
				end
				receiptFont = dxCreateFont("files/ThermalPrinter.ttf", 30, false, "antialiased")
				receiptFont2 = dxCreateFont("files/lunabar.ttf", 20, false, "antialiased")
				receiptSignature = getElementData(localPlayer, "visibleName"):gsub("_", " ")
				receiptSignatureStart = false
				local time = getRealTime()
				receiptDate = string.format("%04d. %02d. %02d. %02d:%02d", time.year + 1900, time.month + 1, time.monthday, time.hour, time.minute)
				receiptId = math.random(10000000, 99999999)
				setElementFrozen(localPlayer, true)
			end
		end
	end
end
function getFuelColor(l)
	if l <= 2 then
		return tocolor(0, 0, 0)
	else
		return tocolor(green[1], green[2], green[3])
	end
end
function getFuelBorder(l)
	if l <= 2 then
		return tocolor(255, 255, 255)
	else
		return tocolor(0, 0, 0)
	end
end
function dxDrawImageEx(x, y, sx, sy, f, c, b)
	for i = -1, 1, 2 do
		for j = -1, 1, 2 do
			dxDrawImage(x + i, y + j, sx, sy, f, 0, 0, 0, b)
		end
	end
	dxDrawImage(x, y, sx, sy, f, 0, 0, 0, c)
end
function getPositionFromElementOffset(element, offX, offY, offZ)
	local m = getElementMatrix(element)
	local x = offX * m[1][1] + offY * m[2][1] + offZ * m[3][1] + m[4][1]
	local y = offX * m[1][2] + offY * m[2][2] + offZ * m[3][2] + m[4][2]
	local z = offX * m[1][3] + offY * m[2][3] + offZ * m[3][3] + m[4][3]
	return x, y, z
end
function getPositionFromMatrixOffset(m, offX, offY, offZ)
	local x = offX * m[1][1] + offY * m[2][1] + offZ * m[3][1] + m[4][1]
	local y = offX * m[1][2] + offY * m[2][2] + offZ * m[3][2] + m[4][2]
	local z = offX * m[1][3] + offY * m[2][3] + offZ * m[3][3] + m[4][3]
	return x, y, z
end
local receiptTimes = {
	389,
	801,
	1220,
	1609,
	2028,
	2836,
	3300,
	4468,
	4902
}

function drawFuelCapIcon(vehicle)
	local x, y, z = getFuelCapIcon(vehicle)
	if x then
		x, y, z = getPositionFromElementOffset(vehicle, x, y, z)
		local screenX, screenY = getScreenFromWorldPosition(x, y, z, 56)
		local now = getTickCount()
		if screenX and screenY then
			local a = now % 1600 / 800
			if 1 < a then
				a = 2 - a
			end
			a = getEasingValue(a, "InOutQuad") * 255
			sightlangStaticImageUsed[1] = true
			if sightlangStaticImageToc[1] then
				processsightlangStaticImage[1]()
			end
			dxDrawImageEx(screenX - 24, screenY - 24, 48, 48, sightlangStaticImage[1], tocolor(255, 255, 255, a), tocolor(0, 0, 0, a))
		end
	end
end
function renderFuelStation()
	local now = getTickCount()
	local tmpHover = false
	local cx, cy = getCursorPosition()
	if cx and cy then
		cx = cx * screenX
		cy = cy * screenY
	end
	local veh = getPedOccupiedVehicle(localPlayer)
	if veh then
		vehTrailer = getVehicleTowedByVehicle(veh)
	end
	if (veh and isElementWithinColShape(veh, fuelStations[currentFuelStation].insideCol)) or (vehTrailer and isElementWithinColShape(vehTrailer, fuelStations[currentFuelStation].insideCol)) then
		if veh or vehTrailer then
			if not exports.sSpeedo:isVehicleElectric(veh) then
				drawFuelCapIcon(veh)
			end
		end
		if veh then
			if not exports.sSpeedo:isVehicleElectric(veh) then
				drawFuelCapIcon(veh)
			end
		end
		if vehTrailer then drawFuelCapIcon(vehTrailer) end
	elseif nearestVeh and stationSyncDatas[selfPump] and (not stationSyncDatas[selfPump].pistolInVehicle and stationSyncDatas[selfPump].pistolInHand or stationSyncDatas[selfPump].pistolInVehicle == nearestVeh) then
		local l = stationSyncDatas[selfPump].fuelType
		if l then
			local x, y, z = getFuelCapIcon(nearestVeh)
			local distance = 1
			if getElementModel(nearestVeh) == 611 then
				distance = 3
			end
			if getElementModel(nearestVeh) == 611 and not getElementData(nearestVeh, "mineTankOnTrailer") then
				distance = 0
			end
			x, y, z = getPositionFromElementOffset(nearestVeh, x, y, z)
			local px, py, pz = getElementPosition(localPlayer)
			if distance > getDistanceBetweenPoints2D(px, py, x, y) then
				local x, y = getScreenFromWorldPosition(x, y, z, 56)
				if x and y then
					if stationSyncDatas[selfPump].pistolInVehicle then
						sightlangStaticImageUsed[2] = true
						if sightlangStaticImageToc[2] then
							processsightlangStaticImage[2]()
						end
						dxDrawImageEx(x - 48 - 8, y - 24, 48, 48, sightlangStaticImage[2], getFuelColor(l), getFuelBorder(l))
						if cx and cx >= x - 48 - 8 and cx <= x - 8 and cy >= y - 24 and cy <= y + 24 then
							tmpHover = "getPistolFrsight_soileh"
						end
						if selfFueling then
							sightlangStaticImageUsed[3] = true
							if sightlangStaticImageToc[3] then
								processsightlangStaticImage[3]()
							end
							dxDrawImageEx(x + 8, y - 24, 48, 48, sightlangStaticImage[3], getFuelColor(l), getFuelBorder(l))
							local p = now % 500 / 500
							sightlangStaticImageUsed[4] = true
							if sightlangStaticImageToc[4] then
								processsightlangStaticImage[4]()
							end
							dxDrawImageEx(x + 8 - 4 * p, y - 24 + 24 * p - 4 * p, 48 + 8 * p, 48 + 8 * p, sightlangStaticImage[4], getFuelColor(l), getFuelBorder(l))
						else
							sightlangStaticImageUsed[1] = true
							if sightlangStaticImageToc[1] then
								processsightlangStaticImage[1]()
							end
							dxDrawImageEx(x + 8, y - 24, 48, 48, sightlangStaticImage[1], getFuelColor(l), getFuelBorder(l))
						end
						if cx and cx >= x + 8 and cx <= x + 8 + 48 and cy >= y - 24 and cy <= y + 24 then
							tmpHover = "startFueling"
						end
					elseif stationSyncDatas[selfPump].pistolInHand then
						sightlangStaticImageUsed[5] = true
						if sightlangStaticImageToc[5] then
							processsightlangStaticImage[5]()
						end
						dxDrawImageEx(x - 32, y - 32, 64, 64, sightlangStaticImage[5], getFuelColor(l), getFuelBorder(l))
						if nearestFuelType == "petrol" then
							dxDrawRectangle(x - 12, y + 32 + 8, 24, 24, tocolor(green[1], green[2], green[3]))
							dxDrawText("B", x, y + 32 + 8 + 12, x, y + 32 + 8 + 12, tocolor(0, 0, 0, 255), fontScale, font, "center", "center")
						elseif nearestFuelType == "diesel" then
							dxDrawRectangle(x - 12, y + 32 + 8, 24, 24, tocolor(0, 0, 0))
							dxDrawText("D", x, y + 32 + 8 + 12, x, y + 32 + 8 + 12, tocolor(255, 255, 255, 255), fontScale, font, "center", "center")
						end
						if cx and cx >= x - 32 and cx <= x + 32 and cy >= y - 32 and cy <= y + 32 then
							tmpHover = "putPistolInVeh"
						end
					end
				end
			end
		end
	end
	if nearestPump and fuelStations[currentFuelStation].pistolPoses[nearestPump] and (not selfPump or selfPump == nearestPump) then
		if stationSyncDatas[nearestPump] and stationSyncDatas[nearestPump].pistolInHand then
			if stationSyncDatas[nearestPump].controller == localPlayer then
				local l = stationSyncDatas[nearestPump].fuelType
				if l and fuelStations[currentFuelStation].pistolPoses[nearestPump][l] then
					local x, y, z = unpack(fuelStations[currentFuelStation].pistolPoses[nearestPump][l])
					local x, y = getScreenFromWorldPosition(x, y, z + 0.5, 32)
					if x and y then
						sightlangStaticImageUsed[6] = true
						if sightlangStaticImageToc[6] then
							processsightlangStaticImage[6]()
						end
						dxDrawImageEx(x - 32, y - 32, 64, 64, sightlangStaticImage[6], getFuelColor(l), getFuelBorder(l))
						if cx and cx >= x - 32 and cx <= x + 32 and cy >= y - 32 and cy <= y + 32 then
							tmpHover = "pistolBack"
						end
					end
				end
			end
		elseif stationSyncDatas[nearestPump] and stationSyncDatas[nearestPump].controller == localPlayer then
			local l = stationSyncDatas[nearestPump].fuelType
			if l and fuelStations[currentFuelStation].pistolPoses[nearestPump][l] and not stationSyncDatas[nearestPump].pistolInVehicle then
				local x, y, z = unpack(fuelStations[currentFuelStation].pistolPoses[nearestPump][l])
				local x, y = getScreenFromWorldPosition(x, y, z + 0.5, 32)
				if x and y then
					sightlangStaticImageUsed[7] = true
					if sightlangStaticImageToc[7] then
						processsightlangStaticImage[7]()
					end
					dxDrawImageEx(x - 32, y - 32, 64, 64, sightlangStaticImage[7], getFuelColor(l), getFuelBorder(l))
					if cx and cx >= x - 32 and cx <= x + 32 and cy >= y - 32 and cy <= y + 32 then
						tmpHover = "getPistol:" .. l
					end
				end
			end
		elseif not stationSyncDatas[nearestPump] then
			for l = 1, #fuelStations[currentFuelStation].pistolPoses[nearestPump] do
				local x, y, z = unpack(fuelStations[currentFuelStation].pistolPoses[nearestPump][l])
				local x, y = getScreenFromWorldPosition(x, y, z + 0.5, 32)
				if x and y then
					sightlangStaticImageUsed[7] = true
					if sightlangStaticImageToc[7] then
						processsightlangStaticImage[7]()
					end
					dxDrawImageEx(x - 32, y - 32, 64, 64, sightlangStaticImage[7], getFuelColor(l), getFuelBorder(l))
					if cx and cx >= x - 32 and cx <= x + 32 and cy >= y - 32 and cy <= y + 32 then
						tmpHover = "getPistol:" .. l
					end
				end
			end
		end
	end
	if receiptStart then
		if selfPump and stationSyncDatas[selfPump].fuelPrice and stationSyncDatas[selfPump].fuelAmount and not stationSyncDatas[selfPump].pistolInHand and not stationSyncDatas[selfPump].pistolInVehicle and not stationSyncDatas[selfPump].fueling then
			local w, h = 275, 400
			local p = 0
			local d = now - receiptStart
			for i = 1, #receiptTimes do
				p = p + math.min(1, math.max(d - receiptTimes[i], 0) / 250) / #receiptTimes
			end
			if 1 <= p then
				p = 1
				if not receiptGUI and not receiptSignatureStart then
					receiptGUI = sightexports.sGui:createGuiElement("null", screenX / 2 - w / 2, screenY / 2 + h / 2 + 8, w, 24)
					local btn = sightexports.sGui:createGuiElement("button", 0, 0, w / 2 - 4, 24, receiptGUI)
					sightexports.sGui:setGuiBackground(btn, "solid", "sightred")
					sightexports.sGui:setGuiHover(btn, "gradient", {
						"sightred",
						"sightred-second"
					}, false, true)
					sightexports.sGui:setButtonFont(btn, "13/BebasNeueBold.otf")
					sightexports.sGui:setButtonTextColor(btn, "#ffffff")
					sightexports.sGui:setButtonText(btn, "Mégsem")
					sightexports.sGui:setClickEvent(btn, "cancelFuelReceipt")
					local btn = sightexports.sGui:createGuiElement("button", w / 2 + 4, 0, w / 2 - 4, 24, receiptGUI)
					sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
					sightexports.sGui:setGuiHover(btn, "gradient", {
						"sightgreen",
						"sightgreen-second"
					}, false, true)
					sightexports.sGui:setButtonFont(btn, "13/BebasNeueBold.otf")
					sightexports.sGui:setButtonTextColor(btn, "#ffffff")
					sightexports.sGui:setButtonText(btn, "Kifizetés")
					sightexports.sGui:setClickEvent(btn, "payFuelReceipt")
				end
			end
			local ch = h * p
			local x, y = screenX / 2 - w / 2, screenY / 2 + h / 2 - ch
			local by = y + ch
			dxDrawRectangle(x, y, w, ch, tocolor(255, 255, 255))
			sightlangStaticImageUsed[8] = true
			if sightlangStaticImageToc[8] then
				processsightlangStaticImage[8]()
			end
			dxDrawImageSection(x, y, w, ch, 0, 0, 626, 626 * (ch / w), sightlangStaticImage[8], 0, 0, 0, tocolor(255, 255, 255, 100))
			dxDrawText("sOIL TÖLTŐÁLLOMÁS", x, y + 12, x + w, by, tocolor(0, 0, 0, 255), 0.45, receiptFont, "center", "top", true)
			local name = tostring(currentFuelStation)
			for i = utf8.len(name) + 1, 2 do
				name = "0" .. name
			end
			name = name .. " - " .. fuelStations[currentFuelStation].stationName
			dxDrawText(name, x, y + 35, x + w, by, tocolor(0, 0, 0, 255), 0.39, receiptFont, "center", "top", true)
			dxDrawText("---------------------", x, y + 55, x + w, by, tocolor(0, 0, 0, 255), 0.39, receiptFont, "center", "top", true)
			dxDrawText("Nyugta", x, y + 80, x + w, by, tocolor(0, 0, 0, 255), 0.425, receiptFont, "center", "top", true)
			dxDrawText(fuelTypeShortNames[stationSyncDatas[selfPump].fuelType], x + 8, y + 120, x + w, by, tocolor(0, 0, 0, 255), 0.3, receiptFont, "left", "top", true)
			dxDrawText(math.floor(stationSyncDatas[selfPump].fuelAmount * 100 + 0.5) / 100 .. " L", x + 8, y + 135, x + w - 8, by, tocolor(0, 0, 0, 255), 0.3, receiptFont, "left", "top", true)
			dxDrawText(math.floor(stationSyncDatas[selfPump].fuelPrice * 10 + 0.5) / 10 .. " $/L", x + 8, y + 135, x + w - 8, by, tocolor(0, 0, 0, 255), 0.3, receiptFont, "center", "top", true)
			local money = math.floor(stationSyncDatas[selfPump].fuelAmount * stationSyncDatas[selfPump].fuelPrice + 0.5)
			dxDrawText(money .. " $", x + 8, y + 135, x + w - 8, by, tocolor(0, 0, 0, 255), 0.3, receiptFont, "right", "top", true)
			dxDrawText("ÖSSZESEN: " .. money .. " $", x + 8, y + 170, x + w - 8, by, tocolor(0, 0, 0, 255), 0.375, receiptFont, "right", "top", true)
			dxDrawText("KÉSZPÉNZ: " .. money .. " $", x + 8, y + 190, x + w - 8, by, tocolor(0, 0, 0, 255), 0.325, receiptFont, "right", "top", true)
			dxDrawText("Pénztáros: " .. fuelStations[currentFuelStation].clerkName, x, y + 230, x + w, by, tocolor(0, 0, 0, 255), 0.3, receiptFont, "center", "top", true)
			dxDrawText("Nyugtaszám: " .. receiptId, x, y + 250, x + w, by, tocolor(0, 0, 0, 255), 0.3, receiptFont, "center", "top", true)
			dxDrawText(receiptDate, x, y + 270, x + w, by, tocolor(0, 0, 0, 255), 0.3, receiptFont, "center", "top", true)
			local ap = 0
			local n = utf8.len(name)
			for i = 1, n do
				ap = ap + utf8.byte(utf8.sub(name, n - i + 1, n - i + 1)) * math.pow(2, i - 1)
			end
			dxDrawText("AP" .. ap, x, y + 310, x + w, by, tocolor(0, 0, 0, 255), 0.3, receiptFont, "center", "top", true)
			local sp = receiptSignatureStart and (now - receiptSignatureStart) / 3580 or 0
			local sw = dxGetTextWidth(receiptSignature, 0.8, receiptFont2)
			dxDrawText(receiptSignature, x + w / 4 + (w - w / 4) / 2 - sw / 2, 0, math.min(x + w / 4 + (w - w / 4) / 2 - sw / 2 + sw * math.min(sp, 1), x + w - 4), y + 375, tocolor(20, 100, 200, 255), 0.8, receiptFont2, "left", "bottom", true)
			dxDrawText("--------------------", x + w / 4, y + 360, x + w, by, tocolor(0, 0, 0, 255), 0.3, receiptFont, "center", "top", true)
			dxDrawText("Aláírás", x + w / 4, y + 370, x + w, by, tocolor(0, 0, 0, 255), 0.3, receiptFont, "center", "top", true)
			if 1.25 <= sp then
				destroyReceipt()
				triggerServerEvent("payTheFuel", localPlayer)
			end
			local x, y, z = getElementPosition(localPlayer)
			local x2, y2, z2 = getElementPosition(fuelStations[currentFuelStation].storePed)
			if getDistanceBetweenPoints3D(x, y, z, x2, y2, z2) > 2.5 then
				destroyReceipt()
			end
		else
			destroyReceipt()
		end
	end
	if tmpHover ~= hover then
		hover = tmpHover
		sightexports.sGui:setCursorType(hover and "link" or "normal")
		if hover then
			hoverCmd = split(hover, ":")
			if hoverCmd[1] == "pistolBack" then
				sightexports.sGui:showTooltip("Pisztoly visszarakása")
			elseif hoverCmd[1] == "getPistolFrsight_soileh" then
				sightexports.sGui:showTooltip("Pisztoly kivétele")
			elseif hoverCmd[1] == "startFueling" then
				sightexports.sGui:showTooltip("Tankolás (tartsd lenyomva/dupla kattintás)")
			elseif hoverCmd[1] == "putPistolInVeh" then
				sightexports.sGui:showTooltip("Pisztoly behelyezése")
			elseif hoverCmd[1] == "getPistol" then
				sightexports.sGui:showTooltip("Pisztoly leemelése (" .. fuelTypeNames[tonumber(hoverCmd[2])] .. ")")
			else
				sightexports.sGui:showTooltip(false)
			end
		else
			hoverCmd = false
			sightexports.sGui:showTooltip(false)
		end
	end
end
if getElementData(localPlayer, "loggedIn") then
	loadModelIds()
end

function areMainElementsCreated()
	return elementsSuccessfullyLoaded
end