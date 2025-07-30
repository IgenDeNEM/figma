local sightexports = {sCarshop = false, sCustompj = false}
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
local vehicleNames = false
local vehicleManufacturers = false
vehicleNames = {
	[466] = "Alfa Romeo Giulia",
	[424] = "Ariel Nomad",
	[585] = "Audi 80",
	[526] = "Audi A3 Mk2",
	[405] = "Audi A8 D4",
	[490] = "Audi Q7 Mk1",
	[533] = "Audi R8 Spyder",
	[580] = "Audi RS4 Avant B8",
	[596] = "Audi RS6 Avant C7",
	[602] = "Audi Sport Quattro '83",
	[599] = "Audi TT RS Coupe Mk3",
	[483] = "Barkas B1000-1",
	[421] = "BMW 7 series e65",
	[551] = "BMW 7 series e38",
	[558] = "BMW 3 series e46",
	[503] = "BMW M4 G82",
	[420] = "BMW 5 series e34",
	[445] = "BMW 5 series e60",
	[598] = "BMW 5 series F11",
	[491] = "BMW M635 CSi e24",
	[549] = "BMW M8 Competition",
	[522] = "Suzuki Hayabusa",
	[400] = "BMW X5",
	[508] = "Brute Camper",
	[494] = "Bugatti Chiron",
	[576] = "Chevrolet Bel Air",
	[541] = "Chevrolet Camaro ZL1",
	[467] = "Toyota Camry V70",
	[517] = "Chevrolet Chevelle SS '67",
	[567] = "Chevrolet Impala '64",
	[554] = "Chevrolet Silverado 1500 LT",
	[439] = "Dodge Charger '69 R/T",
	[603] = "Dodge Coronet 440",
	[426] = "Dodge Demon SRT",
	[429] = "Dodge Viper SRT GTS",
	[521] = "Ducati Desmosedici RR",
	[555] = "Ferrari 250 GTO",
	[411] = "Ferrari 488 Pista",
	[413] = "Ford Econoline",
	[605] = "Ford F-150",
	[495] = "Ford F-150 Raptor",
	[525] = "Ford F-550 Towtruck",
	[401] = "Ford Focus RS Mk2",
	[527] = "Ford Mustang GT 2015",
	[535] = "Ford Pick Up Custom '51",
	[434] = "Ford Ratrod '34",
	[536] = "Ford Thunderbird '64",
	[586] = "Harley Davidson Fat Boy",
	[463] = "Harley Davidson Knucklehead",
	[565] = "Honda Civic ek9",
	[462] = "Yamaha Aerox",
	[542] = "Honda CR-X SiR '90",
	[470] = "Hummer H2",
	[500] = "Jeep Wrangler",
	[546] = "Lada 2107",
	[451] = "Lamborghini Huracan",
	[409] = "Lincoln Town Car Limousine",
	[534] = "Lincoln Town Coupe",
	[477] = "Nissan 240SX SE",
	[506] = "McLaren P1",
	[479] = "Mercedes-Benz 190E Evolution II",
	[516] = "Mercedes-Benz 300 SEL",
	[502] = "Mercedes-Benz AMG GT",
	[415] = "Mercedes-Benz AMG One",
	[438] = "Mercedes-Benz E-Class W212 Estate",
	[550] = "Mercedes-Benz E-Class W210",
	[507] = "Mercedes-Benz S-Class W220",
	[404] = "Mercedes-Benz G-Class W463",
	[604] = "Mercedes-Benz GT 63 S",
	[582] = "Mercedes-Benz Sprinter",
	[492] = "Mercedes-Benz C-Class W206",
	[560] = "Mitsubishi Lancer EVO X",
	[587] = "Nissan GT-R",
	[562] = "Nissan Skyline R34 GT-R",
	[475] = "Plymouth Hemi 'Cuda '70",
	[402] = "Pontiac Firebird",
	[436] = "Nissan 370Z",
	[523] = "BMW R 1200RT",
	[480] = "Porsche 911 Turbo S",
	[579] = "Range Rover Sport SC.",
	[529] = "Seat Leon Mk1",
	[566] = "Skoda Octavia Mk1",
	[597] = "Skoda Octavia VRS Estate",
	[540] = "Subaru Impreza WRX STI",
	[419] = "Toyota Supra A90",
	[559] = "Toyota Supra Mk4",
	[474] = "Volkswagen Beetle '73",
	[547] = "Volkswagen Bora",
	[418] = "Volkswagen Caravelle 2018",
	[410] = "Volkswagen Golf I",
	[561] = "Volkswagen Golf V",
	[589] = "Volkswagen Golf VII",
	[458] = "Volkswagen Passat B6",
	[496] = "Volkswagen Scirocco Mk3",
	[471] = "Quadbike",
	[468] = "Sanchez",
	[416] = "Mercedes-Benz Sprinter Ambulance",
	[407] = "Mercedes-Benz Atego Firetruck",
	[452] = "Wellcraft 38 Scarab KV",
	[446] = "Lampadati Toro",
	[528] = "Lenco Bearcat",
	[543] = "Chevrolet Corvette C8"
}
vehicleManufacturers = {
	[466] = "Alfa Romeo",
	[424] = "Ariel",
	[585] = "Audi",
	[526] = "Audi",
	[405] = "Audi",
	[490] = "Audi",
	[533] = "Audi",
	[580] = "Audi",
	[596] = "Audi",
	[602] = "Audi",
	[599] = "Audi",
	[483] = "Barkas",
	[492] = "Mercedes-Benz",
	[421] = "BMW",
	[551] = "BMW",
	[558] = "BMW",
	[503] = "BMW",
	[420] = "BMW",
	[445] = "BMW",
	[598] = "BMW",
	[491] = "BMW",
	[549] = "BMW",
	[523] = "BMW",
	[522] = "Suzuki",
	[400] = "BMW",
	[494] = "Bugatti",
	[576] = "Chevrolet",
	[541] = "Chevrolet",
	[517] = "Chevrolet",
	[567] = "Chevrolet",
	[554] = "Chevrolet",
	[439] = "Dodge",
	[603] = "Dodge",
	[426] = "Dodge",
	[429] = "Dodge",
	[521] = "Ducati",
	[555] = "Ferrari",
	[411] = "Ferrari",
	[413] = "Ford",
	[605] = "Ford",
	[495] = "Ford",
	[525] = "Ford",
	[401] = "Ford",
	[527] = "Ford",
	[535] = "Ford",
	[434] = "Ford",
	[536] = "Ford",
	[586] = "Harley Davidson",
	[463] = "Harley Davidson",
	[565] = "Honda",
	[462] = "Yamaha",
	[542] = "Honda",
	[470] = "Hummer",
	[500] = "Jeep",
	[546] = "Lada",
	[451] = "Lamborghini",
	[409] = "Lincoln",
	[534] = "Lincoln",
	[477] = "Nissan",
	[436] = "Nissan",
	[506] = "McLaren",
	[479] = "Mercedes-Benz",
	[516] = "Mercedes-Benz",
	[502] = "Mercedes-Benz",
	[415] = "Mercedes-Benz",
	[438] = "Mercedes-Benz",
	[550] = "Mercedes-Benz",
	[507] = "Mercedes-Benz",
	[404] = "Mercedes-Benz",
	[604] = "Mercedes-Benz",
	[582] = "Mercedes-Benz",
	[560] = "Mitsubishi",
	[587] = "Nissan",
	[562] = "Nissan",
	[475] = "Plymouth",
	[402] = "Pontiac",
	[480] = "Porsche",
	[579] = "Land-Rover",
	[529] = "Seat",
	[566] = "Skoda",
	[597] = "Skoda",
	[540] = "Subaru",
	[419] = "Toyota",
	[559] = "Toyota",
	[467] = "Toyota",
	[474] = "Volkswagen",
	[547] = "Volkswagen",
	[418] = "Volkswagen",
	[410] = "Volkswagen",
	[561] = "Volkswagen",
	[589] = "Volkswagen",
	[458] = "Volkswagen",
	[496] = "Volkswagen",
	[416] = "Mercedes-Benz",
	[407] = "Mercedes-Benz",
	[452] = "Wellcraft",
	[446] = "Lampadati",
	[543] = "Chevrolet"
}
if triggerClientEvent then
	if fileExists("vehs.sight") then
		fileDelete("vehs.sight")
	end
	local file = fileCreate("vehs.sight")
	local vehicleIds = {
		[400] = true,
		[401] = true,
		[402] = true,
		[403] = true,
		[404] = true,
		[405] = true,
		[406] = true,
		[407] = true,
		[408] = true,
		[409] = true,
		[410] = true,
		[411] = true,
		[412] = true,
		[413] = true,
		[414] = true,
		[415] = true,
		[416] = true,
		[417] = true,
		[418] = true,
		[419] = true,
		[420] = true,
		[421] = true,
		[422] = true,
		[423] = true,
		[424] = true,
		[425] = true,
		[426] = true,
		[427] = true,
		[428] = true,
		[429] = true,
		[430] = true,
		[431] = true,
		[432] = true,
		[433] = true,
		[434] = true,
		[435] = true,
		[436] = true,
		[437] = true,
		[438] = true,
		[439] = true,
		[440] = true,
		[441] = true,
		[442] = true,
		[443] = true,
		[444] = true,
		[445] = true,
		[446] = true,
		[447] = true,
		[448] = true,
		[449] = true,
		[450] = true,
		[451] = true,
		[452] = true,
		[453] = true,
		[454] = true,
		[455] = true,
		[456] = true,
		[457] = true,
		[458] = true,
		[459] = true,
		[460] = true,
		[461] = true,
		[462] = true,
		[463] = true,
		[464] = true,
		[465] = true,
		[466] = true,
		[467] = true,
		[468] = true,
		[469] = true,
		[470] = true,
		[471] = true,
		[472] = true,
		[473] = true,
		[474] = true,
		[475] = true,
		[476] = true,
		[477] = true,
		[478] = true,
		[479] = true,
		[480] = true,
		[481] = true,
		[482] = true,
		[483] = true,
		[484] = true,
		[485] = true,
		[486] = true,
		[487] = true,
		[488] = true,
		[489] = true,
		[490] = true,
		[491] = true,
		[492] = true,
		[493] = true,
		[494] = true,
		[495] = true,
		[496] = true,
		[497] = true,
		[498] = true,
		[499] = true,
		[500] = true,
		[501] = true,
		[502] = true,
		[503] = true,
		[504] = true,
		[505] = true,
		[506] = true,
		[507] = true,
		[508] = true,
		[509] = true,
		[510] = true,
		[511] = true,
		[512] = true,
		[513] = true,
		[514] = true,
		[515] = true,
		[516] = true,
		[517] = true,
		[518] = true,
		[519] = true,
		[520] = true,
		[521] = true,
		[522] = true,
		[523] = true,
		[524] = true,
		[525] = true,
		[526] = true,
		[527] = true,
		[528] = true,
		[529] = true,
		[530] = true,
		[531] = true,
		[532] = true,
		[533] = true,
		[534] = true,
		[535] = true,
		[536] = true,
		[537] = true,
		[538] = true,
		[539] = true,
		[540] = true,
		[541] = true,
		[542] = true,
		[543] = true,
		[544] = true,
		[545] = true,
		[546] = true,
		[547] = true,
		[548] = true,
		[549] = true,
		[550] = true,
		[551] = true,
		[552] = true,
		[553] = true,
		[554] = true,
		[555] = true,
		[556] = true,
		[557] = true,
		[558] = true,
		[559] = true,
		[560] = true,
		[561] = true,
		[562] = true,
		[563] = true,
		[564] = true,
		[565] = true,
		[566] = true,
		[567] = true,
		[568] = true,
		[569] = true,
		[570] = true,
		[571] = true,
		[572] = true,
		[573] = true,
		[574] = true,
		[575] = true,
		[576] = true,
		[577] = true,
		[578] = true,
		[579] = true,
		[580] = true,
		[581] = true,
		[582] = true,
		[583] = true,
		[584] = true,
		[585] = true,
		[586] = true,
		[587] = true,
		[588] = true,
		[589] = true,
		[590] = true,
		[591] = true,
		[592] = true,
		[593] = true,
		[594] = true,
		[595] = true,
		[596] = true,
		[597] = true,
		[598] = true,
		[599] = true,
		[600] = true,
		[601] = true,
		[602] = true,
		[603] = true,
		[604] = true,
		[605] = true,
		[606] = true,
		[607] = true,
		[608] = true,
		[609] = true,
		[610] = true,
		[611] = true
	}
	for model, name in pairs(vehicleNames) do
		fileWrite(file, model .. ";" .. name .. "\n")
		vehicleIds[model] = nil
	end
	for model in pairs(vehicleIds) do
		fileWrite(file, model .. ";" .. (getVehicleNameFromModel(model) or "N/A") .. "\n")
	end
	fileClose(file)
end


local customVehNames = {
	["model_s"] = {
		name = "Tesla Model S",
		manufacturer = "Tesla",
		model = 801,
	},
	["model_y"] = {
		name = "Tesla Model Y",
		manufacturer = "Tesla",
		model = 802,
	},
	["leaf"] = {
		name = "Nissan Leaf",
		manufacturer = "Nissan",
		model = 800,
	},
	["primo2"] = {
		name = "BMW M3 G20",
		manufacturer = "BMW",
		model = 700,
	},
	["audirs7"] = {
		name = "Audi RS7 Sportback",
		manufacturer = "AUDI",
		model = 700,
	},
	["dodge"] = {
		name = "Dodge RAM 1500 Limited",
		manufacturer = "DODGE",
		model = 700,
	},
}


function getVehicleCustomModel(element)
	if tonumber(element) then
		return tonumber(element)
	end
	local type = getElementType(element)
	local modelId = 400
	if type == "vehicle" then
		local customVeh = getElementData(element, "vehicle.customModel")
		if customVeh and customVeh ~= "false" then
			modelId = customVehNames[customVeh].model
		end
	else
		modelId = getElementModel(element)
	end
	return modelId
end

function getCustomVehicleName(modelId)
	if not tonumber(modelId) then
		if customVehNames[modelId] then
			return customVehNames[modelId].name
		end
	else
		modelId = tonumber(modelId)
		if modelId and 0 < modelId then
			if vehicleNames[modelId] then
				return vehicleNames[modelId]
			else
				return getVehicleNameFromModel(modelId)
			end
		else
			return "Invalid modelId"
		end
	end
end
function getCustomVehicleManufacturer(modelId)
	if not tonumber(modelId) then
		if customVehNames[modelId] then
			return customVehNames[modelId].manufacturer
		end
	else
		modelId = tonumber(modelId)
		if modelId and 0 < modelId then
			if vehicleManufacturers[modelId] then
				return vehicleManufacturers[modelId]
			else
				return "GTA-SA"
			end
		else
			return "Invalid modelId"
		end
	end
end
local tmp = {}
for k, v in pairs(vehicleNames) do
	if getVehicleType(k) == "Automobile" then
		local manu = getCustomVehicleManufacturer(k)
		if manu ~= "GTA-SA" then
			tmp[manu] = true
		end
	end
end
local vehicleManufacturerList = {}
for k in pairs(tmp) do
	table.insert(vehicleManufacturerList, k)
end
table.insert(vehicleManufacturerList, "Tesla")

table.sort(vehicleManufacturerList)
function getVehicleManufacturerList()
	return vehicleManufacturerList
end
local motorcycleList = {}
for k, v in pairs(vehicleNames) do
	if getVehicleType(k) == "Bike" then
		table.insert(motorcycleList, v)
	end
end
table.sort(motorcycleList)
function getMotorcycleNames()
	return motorcycleList
end
