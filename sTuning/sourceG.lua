local sightexports = {sPaintjob = false, sVehicles = false}
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
workshopLocations = {
	{
		1027.1103515625,
		-909.490234375,
		42.145027160645,
		false,
		0,
		0,
		0,
		0,
		1044.333984375,
		-906.740234375,
		41,
		98.5,
		{
			{
				1017.8427734375,
				-890.4833984375,
				42.1171875,
				97
			},
			{
				1018.4375,
				-895.3271484375,
				42.1171875,
				97
			},
			{
				1019.076171875,
				-900.5947265625,
				42.1171875,
				97
			},
			{
				1021.2138671875,
				-918.755859375,
				42.125331878662,
				97
			},
			{
				1021.841796875,
				-923.3291015625,
				42.125373840332,
				97
			},
			{
				1022.822265625,
				-927.3232421875,
				42.127605438232,
				97
			}
		}
	},
	{
		-1787.26171875,
		-1600.935546875,
		21.384313583374,
		false,
		0,
		0,
		0,
		0,
		-1804.5,
		-1600,
		20.756885528564,
		-93,
		{
			{
				-1788.599609375,
				-1609.41015625,
				21.382768630981,
				266.8
			}
		}
	},
	{
		2463.9182,
		-2427.7976,
		13.5407,
		false,
		0,
		0,
		0,
		0,
		2451.4363,
		-2415.3157,
		12.6634,
		225,
		{
			{
				2470.1962890625,
				-2409.6494140625,
				13.630796432495,
				225
			}
		}
	},
	{
		-1297.78,
		24.0547,
		14.676,
		false,
		0,
		0,
		0,
		0,
		-1285.35,
		11.5227,
		14.0884,
		45,
		{
			{
				-1292.6474609375,
				34.732421875,
				14.959094047546,
				45
			},
			{
				-1295.716796875,
				31.69921875,
				14.958545684814,
				45
			},
			{
				-1308.3359375,
				19.7451171875,
				14.955911636353,
				45
			},
			{
				-1308.205078125,
				4.6787109375,
				14.978740692139,
				135
			},
			{
				-1305.15234375,
				1.7080078125,
				14.98926448822,
				135
			},
			{
				-1301.7998046875,
				-1.5537109375,
				15.00084400177,
				135
			},
			{
				-1298.544921875,
				-4.8193359375,
				15.010791778564,
				135
			},
			{
				-1295.4208984375,
				-8.0126953125,
				15.019616127014,
				135
			},
			{
				-1292.2880859375,
				-11.216796875,
				15.01974105835,
				135
			}
		}
	},
	{
		-1281.9886,
		2700.041,
		50.0702,
		false,
		0,
		0,
		0,
		0,
		-1266.0283,
		2709.2568,
		49.0702,
		120,
		{
			{
				-1295.265625,
				2715.1943359375,
				50.0703125,
				210
			},
			{
				-1292.4951171875,
				2716.8115234375,
				50.0703125,
				210
			},
			{
				-1290.0771484375,
				2718.326171875,
				50.0703125,
				210
			},
			{
				-1287.6162109375,
				2719.83984375,
				50.0703125,
				210
			},
			{
				-1285.0537109375,
				2721.505859375,
				50.0703125,
				210
			},
			{
				-1282.4443359375,
				2722.94140625,
				50.0703125,
				210
			},
			{
				-1279.8076171875,
				2724.4384765625,
				50.0703125,
				210
			},
			{
				-1277.203125,
				2726.0322265625,
				50.0703125,
				210
			}
		}
	}
}
workshopSpotlightData = {
	0,
	13.8914,
	4.4325,
	0,
	17,
	0,
	0.2,
	75
}
function checkDisabledVariant(model, value)
	if model == 490 or model == 598 or model == 599 or model == 596 then
		return value == 1
	elseif model == 597 then
		return value == 1 or value == 2
	elseif model == "model_y" or model == "model_s" or model == "leaf" then
		return value == 1 or value == 2 or value == 3 or value == 4
	elseif model == "dodge" then
		return value == 3
	end
	return false
end
tuningPrices = {
	offroadSetting = {
		{"cash", 30000},
		{"cash", 30000}
	},
	steeringLock = {
		{"cash", 5000},
		{"cash", 10000},
		{"cash", 15000},
		{"cash", 20000},
		{"cash", 25000},
		{"cash", 30000},
		{"cash", 35000},
		{"cash", 40000},
		{"cash", 45000},
		{"cash", 50000}
	},
	headlightColor = {"cash", 25000},
	variant = {"cash", 200000},
	traffipaxRadar = {
		{"cash", 220000},
		{"pp", 2000}
	},
	spinner = {
		{"pp", 1200},
		{"pp", 1500},
		{"pp", 1200},
		{"pp", 1500},
		{"pp", 1200},
		{"pp", 1500},
		{"pp", 1200},
		{"pp", 1500}
	},
	frontwheels = {
		{"cash", 10000},
		{"cash", 10000},
		{"cash", 10000},
		{"cash", 10000},
		{"cash", 10000},
		{"cash", 10000},
		{"cash", 10000},
		{"cash", 10000},
		{"cash", 10000},
		{"cash", 10000},
		{"cash", 10000},
		{"cash", 10000},
		{"cash", 10000},
		{"cash", 10000},
		{"cash", 10000},
		{"cash", 10000},
		{"cash", 10000},
		{"cash", 10000},
		{"cash", 10000},
		{"cash", 10000},
		{"cash", 10000},
		{"cash", 10000},
		{"cash", 10000},
		{"cash", 10000},
		{"cash", 10000},
		{"cash", 10000}
	},
	rearwheels = {
		{"cash", 10000},
		{"cash", 10000},
		{"cash", 10000},
		{"cash", 10000},
		{"cash", 10000},
		{"cash", 10000},
		{"cash", 10000},
		{"cash", 10000},
		{"cash", 10000},
		{"cash", 10000},
		{"cash", 10000},
		{"cash", 10000},
		{"cash", 10000},
		{"cash", 10000},
		{"cash", 10000},
		{"cash", 10000},
		{"cash", 10000},
		{"cash", 10000},
		{"cash", 10000},
		{"cash", 10000},
		{"cash", 10000},
		{"cash", 10000},
		{"cash", 10000},
		{"cash", 10000},
		{"cash", 10000},
		{"cash", 10000}
	},
	nitro = {
		[true] = {"pp", 2000}
	},
	lsdDoor = {
		[true] = {"pp", 1500}
	},
	customPlate = {
		[true] = {"pp", 1500}
	},
	neon = {
		custom = {"pp", 1200},
		white = {"cash", 20000},
		blue = {"cash", 20000},
		lightblue = {"cash", 20000},
		red = {"cash", 20000},
		orange = {"cash", 20000},
		green = {"cash", 20000},
		yellow = {"cash", 20000},
		pink = {"cash", 20000},
		purple = {"cash", 20000}
	},
	["wheelwidth.front"] = {
		{"cash", 20000},
		{"cash", 10000},
		{"cash", 10000},
		{"cash", 20000}
	},
	["wheelwidth.rear"] = {
		{"cash", 20000},
		{"cash", 10000},
		{"cash", 10000},
		{"cash", 20000}
	},
	["wheelsettings"] = {
		{"pp", 800},
		{"pp", 800},
	},
	nosrefill = {
		{"cash", 10000},
		{"pp", 300}
	},
	["performance.engine"] = {
		{"cash", 17500},
		{"cash", 35000},
		{"pp", 1200}
	},
	["performance.turbo"] = {
		{"cash", 17500},
		{"cash", 35000},
		{"pp", 1200},
		{"pp", 2500},
		{"pp", 3400}
	},
	["performance.supercharger"] = {
		[true] = {"pp", 2500}
	},
	["performance.ecu"] = {
		{"cash", 17500},
		{"cash", 35000},
		{"pp", 1200},
		{"pp", 4500}
	},
	["performance.transmission"] = {
		{"cash", 17500},
		{"cash", 35000},
		{"pp", 1200}
	},
	["performance.suspension"] = {
		{"cash", 17500},
		{"cash", 35000},
		{"pp", 1200}
	},
	["performance.brakes"] = {
		{"cash", 17500},
		{"cash", 35000},
		{"pp", 1200}
	},
	["performance.tire"] = {
		{"cash", 17500},
		{"cash", 35000},
		{"pp", 1200}
	},
	["performance.weightReduction"] = {
		{"cash", 17500},
		{"cash", 35000},
		{"pp", 1200}
	},
	driveType = {
		awd = {"cash", 20000},
		fwd = {"cash", 20000},
		rwd = {"cash", 20000},
		set = {"pp", 1200}
	},
	backfire = {
		{"pp", 1800},
		{"pp", 4500}
	},
	rideTuning = {
		{"cash", 15000},
		{"cash", 20000},
		{"cash", 25000},
		{"cash", 30000},
		{"pp", 1500}
	},
	wheelPaintjob = {"pp", 1600},
	headlightPaintjob = {"pp", 1600},
	paintjob = {},
	color = {"cash", 15000},
	abs = {
		{"cash", 75000},
		{"cash", 75000},
		{"cash", 75000}
	},
	automaticShifter = {
		{"pp", 1200}
	}
}
function getTuningPrice(name, value, veh)
	if tuningPrices[name] then
		if name == "wheelPaintjob" then
			if value then
				local model = false
				local wheelTuning = getVehicleUpgradeOnSlot(veh, 12)
				if 0 < wheelTuning then
					model = wheelTuning
				else
					model = getElementModel(veh)
				end
				local cp = sightexports.sPaintjob:getCustomPrice(model, "wheel", value)
				if cp then
					return {"pp", cp}
				else
					return tuningPrices.wheelPaintjob
				end
			end
		elseif name == "headlightPaintjob" then
			if value then
				local cp = sightexports.sPaintjob:getCustomPrice(getElementModel(veh), "headlight", value)
				if cp then
					return {"pp", cp}
				else
					return tuningPrices.headlightPaintjob
				end
			end
		elseif name == "paintjob" then
			if value then
				return tuningPrices.paintjob.custom
			end
		elseif tonumber(tuningPrices[name][2]) then
			return tuningPrices[name]
		elseif tuningPrices[name][value] then
			return tuningPrices[name][value]
		end
	end
	return false
end
function validateTuningUpgrade(veh, slot, value)
	local compatibles = getVehicleCompatibleUpgrades(veh, slot)
	for i = 1, #compatibles do
		if compatibles[i] == value then
			return true
		end
	end
	return false
end
local disabledOptions = {
	Bike = {
		rideTuning = true,
		neon = true,
		wheelMenu = true,
		frontwheels = true,
		rearwheels = true,
		wheelPaintjob = true,
		spinner = true,
		spinner = true,
		["wheelwidth.front"] = true,
		["wheelwidth.rear"] = true,
		opticalMenu = true,
		["optical.14"] = true,
		["optical.0"] = true,
		["optical.7"] = true,
		["optical.3"] = true,
		["optical.2"] = true,
		["optical.12"] = true,
		["optical.14"] = true,
		["optical.15"] = true,
		lsdDoor = true,
		driveType = true,
		steeringLock = true,
		offroadSetting = true
	},
	Quad = {
		rideTuning = true,
		neon = true,
		wheelMenu = true,
		frontwheels = true,
		rearwheels = true,
		wheelPaintjob = true,
		spinner = true,
		spinner = true,
		["wheelwidth.front"] = true,
		["wheelwidth.rear"] = true,
		opticalMenu = true,
		["optical.14"] = true,
		["optical.0"] = true,
		["optical.7"] = true,
		["optical.3"] = true,
		["optical.2"] = true,
		["optical.12"] = true,
		["optical.14"] = true,
		["optical.15"] = true,
		lsdDoor = true,
		driveType = true,
		steeringLock = true,
		offroadSetting = true
	},
	electric = {
		backfire = true,
		nitro = true,
		nosrefill = true,
		automaticShifter = true
	}
}

electricVehicles = {
	["model_s"] = true,
	["model_y"] = true,
	["leaf"] = true,
}

local _getVehicleType = getVehicleType

function getVehicleType(element)
	local model = getElementData(element, "vehicle.customModel") or getElementModel(element)
	if electricVehicles[model] then
		return "electric"
	else
		return _getVehicleType(element)
	end
end

function isTuningVisible(veh, name, visName)
	local vehType = getVehicleType(veh)
	if name == "performance.supercharger" then
		return sightexports.sVehicles:getSuperChargerOffset(getElementModel(veh)) and true or false
	end
	if disabledOptions[vehType] and (disabledOptions[vehType][name] or disabledOptions[vehType][visName]) then
		return false
	end
	return true
end
function canTuningFitted(veh, name, value)
	local vehType = getVehicleType(veh)
	if disabledOptions[vehType] and disabledOptions[vehType][name] then
		return false
	end
	if name == "backfire" then
		if value then
			if getElementData(veh, "performance.engine") >= 3 and 3 <= getElementData(veh, "performance.turbo") and 3 <= getElementData(veh, "performance.ecu") and 3 <= getElementData(veh, "performance.transmission") then
				return true
			end
			return false
		end
	elseif name == "nosrefill" then
		return getElementData(veh, "nitro")
	elseif name == "optical.12" then
		if 0 < (getElementData(veh, "vehicle.currentWheelTexture") or 0) then
			return false
		end
		return true
	elseif name == "optical.13" then
		if 0 < (getElementData(veh, "vehicle.currentWheelTexture") or 0) then
			return false
		end
		return true
	elseif name == "performance.turbo" then
		return getElementData(veh, "performance.turbo") ~= 4
	elseif name == "performance.ecu" then
		if value < 4 then
			return true
		else
			return vehType == "Automobile" or vehType == "electric"
		end
	elseif name == "performance.supercharger" then
		if sightexports.sVehicles:getSuperChargerOffset(getElementModel(veh)) then
			return getElementData(veh, "performance.turbo") == 0 or getElementData(veh, "performance.turbo") == 4
		else
			return false
		end
	elseif name == "optical.14" then
		if value then
			return validateTuningUpgrade(veh, 14, value)
		end
	elseif name == "optical.15" then
		if value then
			return validateTuningUpgrade(veh, 15, value)
		end
	elseif name == "optical.3" then
		if value then
			return validateTuningUpgrade(veh, 3, value)
		end
	elseif name == "optical.0" then
		if value then
			return validateTuningUpgrade(veh, 0, value)
		end
	elseif name == "optical.2" then
		if value then
			return validateTuningUpgrade(veh, 2, value)
		end
	elseif name == "optical.7" then
		if value then
			return validateTuningUpgrade(veh, 7, value)
		end
	elseif name == "optical.12" then
		if value then
			return validateTuningUpgrade(veh, 12, value)
		end
	elseif name == "optical.13" then
		if value then
			return validateTuningUpgrade(veh, 12, value)
		end
	elseif name == "optical.14" and value then
		return validateTuningUpgrade(veh, 13, value)
	end
	return true
end
validTuningValues = {}
validTuningValuesEx = {}
validValuesPerTuning = {}
canBuyAgainPerTuning = {}
defaultCamera = {
	math.pi / 3 - math.pi,
	6.5,
	6.5,
	1.25,
	10,
	1,
	0,
	0
}
local opticalTuningPrices = {
	["optical.14"] = {"cash", 10000},
	["optical.15"] = {"cash", 10000},
	["optical.3"] = {"cash", 10000},
	["optical.0"] = {"cash", 10000},
	["optical.2"] = {"cash", 10000},
	["optical.7"] = {"cash", 10000},
	["optical.14"] = {"cash", 10000},
	["optical.12"] = {"cash", 10000},
	["optical.13"] = {"cash", 10000}
}
local opticalTuningList = {
	["optical.14"] = {
		1117,
		1152,
		1153,
		1155,
		1157,
		1160,
		1165,
		1166,
		1169,
		1170,
		1171,
		1172,
		1173,
		1174,
		1176,
		1179,
		1181,
		1182,
		1185,
		1188,
		1189,
		1190,
		1191
	},
	["optical.15"] = {
		1140,
		1141,
		1148,
		1149,
		1150,
		1151,
		1154,
		1156,
		1159,
		1161,
		1167,
		1168,
		1175,
		1177,
		1178,
		1180,
		1183,
		1184,
		1186,
		1187,
		1192,
		1193
	},
	["optical.3"] = {
		1007,
		1017,
		1026,
		1027,
		1030,
		1031,
		1056,
		1057,
		1062,
		1063,
		1069,
		1070,
		1071,
		1072,
		1090,
		1093,
		1094,
		1095,
		1099,
		1101,
		1102,
		1106,
		1107,
		1108,
		1118,
		1119,
		1120,
		1121,
		1122,
		1124,
		1133,
		1137,
		1036,
		1039,
		1040,
		1041,
		1042,
		1047,
		1048,
		1051,
		1052,
		1134
	},
	["optical.0"] = {
		1142,
		1143,
		1144,
		1145
	},
	["optical.2"] = {
		1000,
		1001,
		1002,
		1003,
		1014,
		1015,
		1016,
		1023,
		1049,
		1050,
		1058,
		1060,
		1138,
		1139,
		1146,
		1147,
		1158,
		1162,
		1163,
		1164
	},
	["optical.7"] = {
		1006,
		1032,
		1033,
		1035,
		1038,
		1053,
		1054,
		1055,
		1061,
		1067,
		1068,
		1088,
		1091,
		1103,
		1128,
		1130,
		1131
	},
	["optical.12"] = {
		1025,
		1073,
		1074,
		1075,
		1076,
		1077,
		1078,
		1079,
		1080,
		1081,
		1082,
		1083,
		1084,
		1085,
		1096,
		1097,
		1098
	},
	["optical.13"] = {
		1025,
		1073,
		1074,
		1075,
		1076,
		1077,
		1078,
		1079,
		1080,
		1081,
		1082,
		1083,
		1084,
		1085,
		1096,
		1097,
		1098
	},
	["optical.14"] = {
		1018,
		1019,
		1020,
		1021,
		1022,
		1028,
		1029,
		1034,
		1037,
		1043,
		1044,
		1045,
		1046,
		1059,
		1064,
		1065,
		1066,
		1089,
		1092,
		1104,
		1105,
		1113,
		1114,
		1126,
		1127,
		1129,
		1132,
		1135,
		1136
	}
}
local customHornNum = 44
local customHornPrice = {"pp", 1800}
function searchTuningMenuForValues(menu)
	for i = 1, #menu do
		if menu[i].tuningId then
			local found = false
			for j = 1, #validTuningValues do
				if validTuningValues[j] == menu[i].tuningId then
					found = true
					break
				end
			end
			if not found then
				table.insert(validTuningValues, menu[i].tuningId)
			end
			validTuningValuesEx[menu[i].tuningId] = true
			if not validValuesPerTuning[menu[i].tuningId] then
				validValuesPerTuning[menu[i].tuningId] = {}
			end
			if not canBuyAgainPerTuning[menu[i].tuningId] then
				canBuyAgainPerTuning[menu[i].tuningId] = {}
			end
			if menu[i].tuningId == "customHorn" then
				menu[i].values = {
					{
						icon = menu[i].icon,
						name = "Nincs",
						value = false
					}
				}
				if not tuningPrices[menu[i].tuningId] then
					tuningPrices[menu[i].tuningId] = {}
				end
				for j = 1, customHornNum do
					table.insert(menu[i].values, {
						icon = menu[i].icon,
						name = "Duda #" .. j,
						value = j,
						blue = true
					})
					tuningPrices[menu[i].tuningId][j] = customHornPrice
				end
			elseif opticalTuningList[menu[i].tuningId] then
				menu[i].values = {
					{
						icon = menu[i].icon,
						name = "Nincs",
						value = false
					}
				}
				if not tuningPrices[menu[i].tuningId] then
					tuningPrices[menu[i].tuningId] = {}
				end
				for j = 1, #opticalTuningList[menu[i].tuningId] do
					local name = menu[i].name
					local val = opticalTuningList[menu[i].tuningId][j]
					table.insert(menu[i].values, {
						icon = menu[i].icon,
						name = utf8.sub(name, 1, 1) .. utf8.lower(utf8.sub(name, 2)),
						value = val
					})
					tuningPrices[menu[i].tuningId][val] = opticalTuningPrices[menu[i].tuningId]
				end
			end
			for j = 1, #menu[i].values do
				validValuesPerTuning[menu[i].tuningId][menu[i].values[j].value] = true
				canBuyAgainPerTuning[menu[i].tuningId][menu[i].values[j].value] = menu[i].values[j].canBuyAgain
				if menu[i].values[j].adjustables then
					for k = 1, #menu[i].values[j].adjustables do
						table.insert(validTuningValues, menu[i].values[j].adjustables[k][2])
						validTuningValuesEx[menu[i].values[j].adjustables[k][2]] = true
					end
				end
			end
		end
		if menu[i].submenus then
			searchTuningMenuForValues(menu[i].submenus)
		end
	end
end
tuningMenus = {
	{
		icon = "teljesitmeny",
		name = "TELJESÍTMÉNY",
		submenus = {
			{
				icon = "teljesitmeny",
				name = "MOTOR",
				keepDefaultOnOthers = true,
				vehicleMode = "engine",
				cameraTarget = "engine",
				camera = {
					math.pi / 3 - math.pi,
					2,
					2,
					1.5,
					0,
					-0.3,
					0,
					0
				},
				outlineColors = {
					[0] = "lightgrey",
					[1] = "green",
					[2] = "yellow",
					[3] = "blue"
				},
				outlineObjects = {engine_block = true},
				tuningId = "performance.engine",
				values = {
					{
						icon = "teljesitmeny",
						name = "Gyári motor",
						value = 0
					},
					{
						icon = "teljesitmeny",
						name = "Profi motor",
						value = 1
					},
					{
						icon = "teljesitmeny",
						name = "Verseny motor",
						value = 2
					},
					{
						icon = "teljesitmeny",
						name = "Venom motor",
						value = 3,
						blue = true
					}
				}
			},
			{
				icon = "turbo",
				name = "TURBO",
				keepDefaultOnOthers = true,
				vehicleMode = "engine",
				cameraTarget = "engine",
				camera = {
					math.pi / 3 - math.pi * 1.5,
					1.5,
					1.5,
					0.65,
					0,
					-0.3,
					0.15,
					0
				},
				outlineColors = {
					[0] = "lightgrey",
					[1] = "green",
					[2] = "yellow",
					[3] = "blue",
					[4] = "purple",
					[5] = "purple"
				},
				outlineObjects = {turbo = true},
				notFitWarning = "Turbó beszereléséhez szereld ki a SuperCharger tuningot!",
				lowerMusic = true,
				tuningId = "performance.turbo",
				values = {
					{
						icon = "turbo",
						name = "Gyári turbo",
						value = 0
					},
					{
						icon = "turbo",
						name = "Profi turbo",
						value = 1
					},
					{
						icon = "turbo",
						name = "Verseny turbo",
						value = 2
					},
					{
						icon = "turbo",
						name = "Venom turbo",
						value = 3,
						blue = true
					},
					{
						icon = "turbo",
						name = "Egyedi Venom turbo",
						value = 5,
						purple = true,
						canBuyAgain = true,
						adjustables = {
							{
								"Töltőnyomás hangereje",
								"turbo.soundVolume",
								0,
								1,
								0.01
							},
							{
								"Töltőnyomás hangja",
								"turbo.sound",
								1,
								8,
								1,
								true
							},
							{
								"Wastegate szelep hangerő",
								"turbo.blowoffVolume",
								0,
								1,
								0.01
							},
							{
								"Wastegate szelep típus",
								"turbo.blowoff",
								1,
								18,
								1,
								true
							}
						}
					}
				}
			},
			{
				icon = "sch",
				name = "SUPERCHARGER",
				clientPreview = true,
				notFitWarning = "SuperCharger beszereléséhez szereld ki a Turbó tuningot!",
				keepDefaultOnOthers = true,
				vehicleMode = "sc",
				cameraTarget = "engine",
				camera = {
					math.pi / 3 - math.pi * 1,
					2.5,
					2.5,
					1,
					0,
					0,
					0,
					0
				},
				tuningId = "performance.supercharger",
				values = {
					{
						icon = "sch",
						name = "Nincs",
						value = false
					},
					{
						icon = "sch",
						name = "Venom SuperCharger",
						value = true,
						purple = true
					}
				}
			},
			{
				icon = "ecu",
				name = "ECU",
				keepDefaultOnOthers = true,
				vehicleMode = "engine",
				cameraTarget = "engine",
				camera = {
					math.pi / 3 - math.pi * 0.5,
					1.25,
					1.25,
					1.25,
					0,
					0.25,
					0.25,
					0
				},
				outlineColors = {
					[0] = "lightgrey",
					[1] = "green",
					[2] = "yellow",
					[3] = "blue",
					[4] = "purple"
				},
				outlineObjects = {ecu = true},
				tuningId = "performance.ecu",
				values = {
					{
						icon = "ecu",
						name = "Gyári ECU",
						value = 0
					},
					{
						icon = "ecu",
						name = "Profi ECU",
						value = 1
					},
					{
						icon = "ecu",
						name = "Verseny ECU",
						value = 2
					},
					{
						icon = "ecu",
						name = "Venom ECU",
						value = 3,
						blue = true
					},
					{
						icon = "ecu",
						name = "Állítható Venom ECU",
						value = 4,
						purple = true
					}
				}
			},
			{
				icon = "valto",
				name = "VÁLTÓ",
				outlineColors = {
					[0] = "lightgrey",
					[1] = "green",
					[2] = "yellow",
					[3] = "blue"
				},
				outlineObjects = {transmission = true},
				keepDefaultOnOthers = true,
				vehicleMode = "engine",
				cameraTarget = "engine",
				camera = {
					math.pi / 3 - math.pi * 0.5,
					2,
					2,
					1,
					0,
					0.5,
					0,
					-0.25
				},
				tuningId = "performance.transmission",
				values = {
					{
						icon = "valto",
						name = "Gyári váltó",
						value = 0
					},
					{
						icon = "valto",
						name = "Profi váltó",
						value = 1
					},
					{
						icon = "valto",
						name = "Verseny váltó",
						value = 2
					},
					{
						icon = "valto",
						name = "Venom váltó",
						value = 3,
						blue = true
					}
				}
			},
			{
				icon = "felfugg",
				name = "FELFÜGGESZTÉS",
				outlineColors = {
					[0] = "lightgrey",
					[1] = "green",
					[2] = "yellow",
					[3] = "blue"
				},
				outlineObjects = {
					suspension_fr = true,
					suspension_fl = true,
					suspension_rl = true,
					suspension_rr = true
				},
				keepDefaultOnOthers = true,
				vehicleMode = "wheels",
				cameraTarget = "wheel",
				camera = {
					math.pi / 3 - math.pi * 1.15,
					1.25,
					1.25,
					0.25,
					0,
					0.25,
					0,
					0.25
				},
				tuningId = "performance.suspension",
				values = {
					{
						icon = "felfugg",
						name = "Gyári felfüggesztés",
						value = 0
					},
					{
						icon = "felfugg",
						name = "Profi felfüggesztés",
						value = 1
					},
					{
						icon = "felfugg",
						name = "Verseny felfüggesztés",
						value = 2
					},
					{
						icon = "felfugg",
						name = "Venom felfüggesztés",
						value = 3,
						blue = true
					}
				}
			},
			{
				icon = "fek",
				name = "FÉK",
				outlineColors = {
					[0] = "lightgrey",
					[1] = "green",
					[2] = "yellow",
					[3] = "blue"
				},
				outlineObjects = {
					brake_fr = true,
					brake_fl = true,
					brake_rl = true,
					brake_rr = true
				},
				keepDefaultOnOthers = true,
				vehicleMode = "wheels",
				cameraTarget = "wheel",
				camera = {
					math.pi / 3 - math.pi * 1.5,
					1,
					1,
					0,
					0,
					0,
					0,
					0
				},
				tuningId = "performance.brakes",
				values = {
					{
						icon = "fek",
						name = "Gyári fék",
						value = 0
					},
					{
						icon = "fek",
						name = "Profi fék",
						value = 1
					},
					{
						icon = "fek",
						name = "Verseny fék",
						value = 2
					},
					{
						icon = "fek",
						name = "Venom fék",
						value = 3,
						blue = true
					}
				}
			},
			{
				icon = "gumi",
				name = "GUMI",
				keepDefaultOnOthers = true,
				cameraTarget = "wheel",
				camera = {
					math.pi / 3 - math.pi * 1.6,
					1.75,
					1.75,
					0,
					0,
					0,
					0,
					0.1
				},
				tuningId = "performance.tire",
				values = {
					{
						icon = "gumi",
						name = "Gyári gumi",
						value = 0
					},
					{
						icon = "gumi",
						name = "Profi gumi",
						value = 1
					},
					{
						icon = "gumi",
						name = "Verseny gumi",
						value = 2
					},
					{
						icon = "gumi",
						name = "Venom gumi",
						value = 3,
						blue = true
					}
				}
			},
			{
				icon = "sulycsokkentes",
				name = "SÚLYCSÖKKENTÉS",
				keepDefaultOnOthers = true,
				camera = {
					math.pi / 3 - math.pi * 1.6,
					5,
					7,
					2.5,
					0,
					0,
					1,
					1
				},
				tuningId = "performance.weightReduction",
				values = {
					{
						icon = "sulycsokkentes",
						name = "Gyári súlycsökkentés",
						value = 0
					},
					{
						icon = "sulycsokkentes",
						name = "Profi súlycsökkentés",
						value = 1
					},
					{
						icon = "sulycsokkentes",
						name = "Verseny súlycsökkentés",
						value = 2
					},
					{
						icon = "sulycsokkentes",
						name = "Venom súlycsökkentés",
						value = 3,
						blue = true
					}
				}
			}
		}
	},
	{
		icon = "optika",
		name = "OPTIKA",
		camera = {
			-math.pi * 0.85,
			6,
			6,
			0.75,
			0,
			0,
			0,
			0
		},
		submenus = {
			{
				icon = "felfugg",
				name = "HASMAGASSÁG/AIRRIDE",
				camera = {
					-math.pi * 0.85,
					7,
					7,
					1,
					0,
					-0.2,
					0.5,
					0.75
				},
				tuningId = "rideTuning",
				serverPreview = true,
				values = {
					{
						icon = "felfugg",
						name = "Gyári hasmagasság",
						value = false
					},
					{
						icon = "felfugg",
						name = "Ültetőrugó - 1",
						value = 1
					},
					{
						icon = "felfugg",
						name = "Ültetőrugó - 2",
						value = 2
					},
					{
						icon = "felfugg",
						name = "Ültetőrugó - 3",
						value = 3
					},
					{
						icon = "felfugg",
						name = "Ültetőrugó - 4",
						value = 4
					},
					{
						icon = "airride",
						name = "AirRide",
						value = 5,
						blue = true
					}
				}
			},
			{
				icon = "neon",
				name = "NEON",
				camera = {
					-math.pi * 0.725,
					8,
					8,
					2,
					0,
					-0.2,
					0.5,
					0.25
				},
				clientPreview = true,
				tuningId = "neon",
				nightTime = true,
				values = {
					{
						icon = "neon",
						name = "Nincs",
						value = false
					},
					{
						icon = "neon",
						name = "Állítható",
						value = "custom",
						blue = true
					},
					{
						icon = "neon",
						name = "Fehér",
						value = "white"
					},
					{
						icon = "neon",
						name = "Kék",
						value = "blue"
					},
					{
						icon = "neon",
						name = "Világoskék",
						value = "lightblue"
					},
					{
						icon = "neon",
						name = "Piros",
						value = "red"
					},
					{
						icon = "neon",
						name = "Narancssárga",
						value = "orange"
					},
					{
						icon = "neon",
						name = "Zöld",
						value = "green"
					},
					{
						icon = "neon",
						name = "Sárga",
						value = "yellow"
					},
					{
						icon = "neon",
						name = "Pink",
						value = "pink"
					},
					{
						icon = "neon",
						name = "Lila",
						value = "purple"
					}
				}
			},
			{
				icon = "felni",
				name = "KEREKEK",
				menuVisibilityName = "wheelMenu",
				camera = {
					-math.pi * 0.875,
					7,
					7,
					1,
					0,
					-0.2,
					0.65,
					0.75
				},
				submenus = {
					{
						icon = "felni",
						name = "FELNI",
						notFitWarning = "Felnicseréhez vedd le a felni paintjobot!",
						serverPreview = true,
						tuningId = "optical.12",
						camera = {
							-math.pi * 0.875,
							7,
							7,
							1,
							0,
							-0.2,
							0.65,
							0.75
						},
					},
					{
						icon = "felni",
						name = "FELNI PAINTJOB",
						clientPreview = true,
						tuningId = "wheelPaintjob",
						dynamicValues = true,
						camera = {
							-math.pi * 0.875,
							7,
							7,
							1,
							0,
							-0.2,
							0.65,
							0.75
						},
						values = {}
					},
					{
						icon = "spinner",
						name = "SPINNER",
						camera = {
							-math.pi * 0.875,
							7,
							7,
							1,
							0,
							-0.2,
							0.65,
							0.75
						},
						submenus = {
							{
								icon = "spinner",
								name = "KRÓM",
								tuningId = "spinner",
								clientPreview = true,
								camera = {
									-math.pi * 0.875,
									7,
									7,
									1,
									0,
									-0.2,
									0.65,
									0.75
								},
								values = {
									{
										icon = "spinner",
										name = "Nincs",
										value = false
									},
									{
										icon = "spinner",
										name = "Spinner #1",
										blue = true,
										value = 1
									},
									{
										icon = "spinner",
										name = "Spinner #2",
										blue = true,
										value = 3
									},
									{
										icon = "spinner",
										name = "Spinner #3",
										blue = true,
										value = 5
									},
									{
										icon = "spinner",
										name = "Spinner #4",
										blue = true,
										value = 7
									}
								}
							},
							{
								icon = "spinner",
								name = "SZÍNEZHETŐ",
								tuningId = "spinner",
								clientPreview = true,
								colorpicker = "spinner",
								camera = {
									-math.pi * 0.875,
									7,
									7,
									1,
									0,
									-0.2,
									0.65,
									0.75
								},
								values = {
									{
										icon = "spinner",
										name = "Nincs",
										value = false
									},
									{
										icon = "spinner",
										name = "Spinner #1",
										blue = true,
										value = 2
									},
									{
										icon = "spinner",
										name = "Spinner #2",
										blue = true,
										value = 4
									},
									{
										icon = "spinner",
										name = "Spinner #3",
										blue = true,
										value = 6
									},
									{
										icon = "spinner",
										name = "Spinner #4",
										blue = true,
										value = 8
									}
								}
							}
						}
					},
				},
			},
			{
				icon = "optika",
				name = "KAROSSZÉRIA",
				menuVisibilityName = "opticalMenu",
				submenus = {
					{
						icon = "elso",
						name = "ELSŐ LÖKHÁRÍTÓ",
						serverPreview = true,
						tuningId = "optical.14",
						cameraTarget = "front",
						camera = {
							-math.pi / 2 * 1,
							4,
							4,
							1,
							0,
							0,
							0,
							0
						}
					},
					{
						icon = "motorhaz",
						name = "MOTORHÁZTETŐ",
						serverPreview = true,
						tuningId = "optical.0",
						cameraTarget = "front",
						camera = {
							-math.pi / 2 * 1,
							4.5,
							4.5,
							2,
							0,
							0,
							0,
							1
						}
					},
					{
						icon = "tetolegterelo",
						name = "TETŐLÉGTERELŐ",
						serverPreview = true,
						tuningId = "optical.7",
						cameraTarget = "front",
						camera = {
							-math.pi / 2 * 1,
							3.5,
							3.5,
							3,
							0,
							0,
							0,
							2
						}
					},
					{
						icon = "kuszob",
						name = "KÜSZÖB",
						serverPreview = true,
						tuningId = "optical.3",
						camera = {
							-math.pi * 0.85,
							7,
							7,
							1,
							0,
							-0.2,
							0.5,
							0.75
						}
					},
					{
						icon = "legterelo",
						name = "SPOILER",
						serverPreview = true,
						tuningId = "optical.2",
						cameraTarget = "rear",
						camera = {
							-math.pi / 2 * 3,
							4,
							4,
							2,
							0,
							0,
							0,
							1
						}
					},
					{
						icon = "kipufogo",
						name = "KIPUFOGÓ",
						cameraTarget = "exhaust",
						camera = {
							math.pi / 3 - math.pi * 2.075,
							3,
							3,
							0.75,
							0,
							0.475,
							0,
							0.25
						},
						serverPreview = true,
						tuningId = "optical.14"
					},
					{
						icon = "hatso",
						name = "HÁTSÓ LÖKHÁRÍTÓ",
						serverPreview = true,
						tuningId = "optical.15",
						cameraTarget = "rear",
						camera = {
							-math.pi / 2 * 3,
							4,
							4,
							1,
							0,
							0,
							0,
							0
						}
					}
				}
			},
			{
				icon = "izzo",
				name = "FÉNYSZÓRÓK",
				submenus = {
					{
						icon = "izzo",
						name = "LÁMPA PAINTJOB",
						clientPreview = true,
						tuningId = "headlightPaintjob",
						dynamicValues = true,
						cameraTarget = "rear",
						camera = {
							-math.pi / 2 * 3 + math.pi * 0.175,
							3,
							3,
							1,
							0,
							0,
							0,
							0.25
						},
						values = {}
					},
					{
						icon = "izzo",
						name = "IZZÓ SZÍN",
						nightTime = true,
						tuningId = "headlightColor",
						serverPreview = true,
						cameraTarget = "front",
						camera = {
							-math.pi / 2 * 3,
							4,
							4,
							2,
							0,
							0,
							0,
							1
						},
						hexPicker = true,
						values = {
							{
								icon = "izzo",
								name = "Gyári fehér",
								value = "ffffff"
							},
							{
								icon = "izzo",
								name = "Halogén (3000K)",
								value = "ffe053"
							},
							{
								icon = "izzo",
								name = "Halogén (3500K)",
								value = "ffeb8f"
							},
							{
								icon = "izzo",
								name = "Halogén (4000K)",
								value = "fff4c1"
							},
							{
								icon = "izzo",
								name = "Xenon (6000K)",
								value = "c1e5ff"
							},
							{
								icon = "izzo",
								name = "Xenon (7000K)",
								value = "8fd1ff"
							},
							{
								icon = "izzo",
								name = "Xenon (8000K)",
								value = "53b8ff"
							},
							{
								icon = "izzo",
								name = "Egyedi izzó",
								value = "hexpicker",
								canBuyAgain = true
							}
						}
					}
				}
			}
		}
	},
	{
		icon = "fenyezes",
		name = "FÉNYEZÉS/PAINTJOB",
		camera = {
			-math.pi * 0.7,
			8,
			8,
			1.5,
			0,
			-0.2,
			0.5,
			0.5
		},
		submenus = {
			{
				icon = "fenyezes",
				name = "PAINTJOB",
				customPj = true,
				tuningId = "paintjob",
				clientPreview = true,
				dynamicValues = true,
				paintSound = true,
				camera = {
					-math.pi * 0.7,
					8,
					8,
					1.5,
					0,
					-0.2,
					0.5,
					0.5
				},
				values = {}
			},
			{
				icon = "fenyezes",
				name = "FÉNYEZÉS",
				colorpicker = "col",
				tuningId = "color",
				paintSound = true,
				serverPreview = true,
				camera = {
					-math.pi * 0.7,
					8,
					8,
					1.5,
					0,
					-0.2,
					0.5,
					0.5
				},
				values = {
					{
						icon = "fenyezes",
						name = "1. szín",
						canBuyAgain = true,
						value = 1
					},
					{
						icon = "fenyezes",
						name = "2. szín",
						canBuyAgain = true,
						value = 2
					},
					{
						icon = "fenyezes",
						name = "3. szín",
						canBuyAgain = true,
						value = 3
					},
					{
						icon = "fenyezes",
						name = "4. szín",
						canBuyAgain = true,
						value = 4
					}
				}
			}
		}
	},
	{
		icon = "misc",
		name = "EXTRÁK",
		submenus = {
			{
				icon = "backfire",
				name = "BACKFIRE",
				tuningId = "backfire",
				lowerMusic = true,
				notFitWarning = "Backfire beszereléséhez szükséged lesz a következő venom tuningokra: Motor, Turbó/SuperCharger, ECU, Váltó.",
				cameraTarget = "exhaust",
				camera = {
					math.pi / 3 - math.pi * 2.075,
					3,
					3,
					0.75,
					0,
					0.475,
					0,
					0.25
				},
				values = {
					{
						icon = "backfire",
						name = "Nincs",
						value = false
					},
					{
						icon = "backfire",
						name = "Normál",
						value = 1,
						blue = true
					},
					{
						icon = "backfire",
						name = "Egyedi",
						value = 2,
						purple = true,
						canBuyAgain = true,
						adjustables = {
							{
								"Hang",
								"backfire.sound",
								1,
								12,
								1,
								true
							},
							{
								"Sebesség",
								"backfire.speed",
								0,
								1,
								0.01
							},
							{
								"Sűrűség",
								"backfire.num",
								0,
								1,
								0.025
							}
						}
					}
				}
			},
			{
				icon = "nitro",
				name = "NITRO",
				cameraTarget = "exhaust",
				camera = {
					math.pi / 3 - math.pi * 2.075,
					3,
					3,
					0.75,
					0,
					0.475,
					0,
					0.25
				},
				submenus = {
					{
						icon = "nitro",
						name = "NITRO SZETT",
						tuningId = "nitro",
						clientPreview = true,
						cameraTarget = "exhaust",
						camera = {
							math.pi / 3 - math.pi * 2.075,
							3,
							3,
							0.75,
							0,
							0.475,
							0,
							0.25
						},
						values = {
							{
								icon = "turbo",
								name = "Nincs",
								value = false
							},
							{
								icon = "turbo",
								name = "NOS szett",
								value = true,
								purple = true
							}
						}
					},
					{
						icon = "nitro",
						name = "ÚJRATÖLTÉS",
						tuningId = "nosrefill",
						clientPreview = true,
						cameraTarget = "exhaust",
						camera = {
							math.pi / 3 - math.pi * 2.075,
							3,
							3,
							0.75,
							0,
							0.475,
							0,
							0.25
						},
						notFitWarning = "Szereld be a NOS szettet az újratöltéshez!",
						values = {
							{
								icon = "turbo",
								name = "Normál NOS töltet",
								value = 1,
								canBuyAgain = true
							},
							{
								icon = "turbo",
								name = "Venom NOS töltet",
								value = 2,
								purple = true,
								canBuyAgain = true
							}
						}
					}
				}
			},
			{
				icon = "speedtrap",
				name = "TRAFFIPAX RADAR",
				tuningId = "traffipaxRadar",
				values = {
					{
						icon = "speedtrap",
						name = "Nincs",
						value = false
					},
					{
						icon = "speedtrap",
						name = "Normál radar",
						value = 1
					},
					{
						icon = "speedtrap",
						name = "Prémium radar",
						value = 2,
						blue = true
					}
				}
			},
			{
				icon = "plate",
				name = "EGYEDI RENDSZÁM",
				textinput = "plate",
				serverPreview = true,
				cameraTarget = "rear",
				camera = {
					-math.pi / 2 * 3,
					2.5,
					2.5,
					0.5,
					0,
					0,
					0,
					0.25
				},
				tuningId = "customPlate",
				values = {
					{
						icon = "plate",
						name = "Gyári rendszám",
						value = false
					},
					{
						icon = "plate",
						name = "Egyedi rendszám",
						value = true,
						blue = true,
						canBuyAgain = true
					}
				}
			},
			{
				icon = "meghajtas",
				name = "MEGHAJTÁS",
				vehicleMode = "powertrain",
				camera = {
					-math.pi,
					0.01,
					0.01,
					5.5,
					0,
					0.1,
					0,
					0
				},
				tuningId = "driveType",
				switchDriveType = true,
				values = {
					{
						icon = "meghajtas",
						name = "FWD",
						value = "fwd"
					},
					{
						icon = "meghajtas",
						name = "RWD",
						value = "rwd"
					},
					{
						icon = "meghajtas",
						name = "AWD",
						value = "awd"
					},
					{
						icon = "meghajtas",
						name = "Állítható AWD",
						blue = true,
						value = "set"
					}
				}
			},
			{
				icon = "horn",
				name = "EGYEDI DUDA",
				lowerMusic = true,
				tuningId = "customHorn",
				clientPreview = true,
				values = {}
			},
			{
				icon = "lsd",
				name = "LSD AJTÓ",
				camera = {
					-math.pi * 0.6,
					8,
					8,
					2.25,
					0,
					-0.2,
					0.5,
					0.5
				},
				tuningId = "lsdDoor",
				clientPreview = true,
				values = {
					{
						icon = "lsd",
						name = "Gyári ajtó",
						value = false
					},
					{
						icon = "lsd",
						name = "LSD ajtók",
						value = true,
						blue = true
					}
				}
			},
			{
				icon = "variant",
				name = "VARIÁNS",
				camera = {
					-math.pi * 0.75,
					7,
					7,
					2.25,
					0,
					-0.2,
					0.5,
					0.25
				},
				tuningId = "variant",
				dynamicValues = true,
				serverPreview = true,
				values = {}
			},
			{
				icon = "slock",
				name = "FORDULÓKÖR",
				tuningId = "steeringLock",
				values = {
					{
						icon = "slock",
						name = "Gyári",
						value = 0
					},
					{
						icon = "slock",
						name = "+10%",
						value = 1
					},
					{
						icon = "slock",
						name = "+20%",
						value = 2
					},
					{
						icon = "slock",
						name = "+30%",
						value = 3
					},
					{
						icon = "slock",
						name = "+40%",
						value = 4
					},
					{
						icon = "slock",
						name = "+50%",
						value = 5
					},
					{
						icon = "slock",
						name = "+60%",
						value = 6
					},
					{
						icon = "slock",
						name = "+70%",
						value = 7
					},
					{
						icon = "slock",
						name = "+80%",
						value = 8
					},
					{
						icon = "slock",
						name = "+90%",
						value = 9
					},
					{
						icon = "slock",
						name = "+100%",
						value = 10
					}
				}
			},
			{
				icon = "offroad",
				name = "OFFROAD BEÁLLÍTÁS",
				tuningId = "offroadSetting",
				values = {
					{
						icon = "offroad",
						name = "Gyári",
						value = 0
					},
					{
						icon = "offroad",
						name = "Murva beállítás",
						value = 1
					},
					{
						icon = "offroad",
						name = "Terep beállítás",
						value = 2
					}
				}
			},
			{
				icon = "abs",
				name = "ABS",
				tuningId = "abs",
				absAlert = true,
				values = {
					{
						icon = "abs",
						name = "Nincs",
						value = false,
						absAlert = true,
					},
					{
						icon = "abs",
						name = "Gyenge",
						value = 1,
						absAlert = true,
					},
					{
						icon = "abs",
						name = "Normál",
						value = 2,
						absAlert = true,
					},
					{
						icon = "abs",
						name = "Erős",
						value = 3,
						absAlert = true,
					}
				}
			},
			{
				icon = "valto",
				name = "AUTOMATA VÁLTÓ",
				tuningId = "automaticShifter",
				values = {
					{
						icon = "valto",
						name = "Kiszerelés",
						value = false
					},
					{
						icon = "valto",
						name = "Beszerelés",
						value = 1,
						purple = true,
					},
				}
			}
		}
	}
}
searchTuningMenuForValues(tuningMenus)
