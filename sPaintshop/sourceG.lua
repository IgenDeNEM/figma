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
function formatGarageName(id)
	if id then
		id = math.abs(id)
		local door, aisle, inside = getAisleFromWorkshop(id)
		if garageDoors[door] then
			local num = tostring(garageDoors[door][6])
			if utf8.len(num) < 2 then
				num = "0" .. num
			end
			return garageDoors[door][5] .. num .. " " .. aisle % 10 .. ". folyosó " .. inside .. ". garázs"
		end
	end
	return "N/A"
end
function formatShopName(id)
	local door, aisle, inside = getAisleFromWorkshop(id)
	if garageDoors[door] then
		local num = tostring(garageDoors[door][6])
		if utf8.len(num) < 2 then
			num = "0" .. num
		end
		return garageDoors[door][5] .. num .. " " .. aisle % 10 .. ". folyosó " .. inside .. ". műhely"
	end
	return "N/A"
end
function formatGarageNameEx(id, inside)
	if id then
		id = math.abs(id)
		local door, aisle = getDoorFromAisle(id)
		if garageDoors[door] then
			local num = tostring(garageDoors[door][6])
			if utf8.len(num) < 2 then
				num = "0" .. num
			end
			return garageDoors[door][5] .. num .. " " .. aisle % 10 .. ". folyosó " .. inside .. ". garázs"
		end
	end
	return "N/A"
end
function formatShopNameEx(id, inside)
	local door, aisle = getDoorFromAisle(id)
	if garageDoors[door] then
		local num = tostring(garageDoors[door][6])
		if utf8.len(num) < 2 then
			num = "0" .. num
		end
		return garageDoors[door][5] .. num .. " " .. aisle % 10 .. ". folyosó " .. inside .. ". műhely"
	end
	return "N/A"
end
garageDoors = {
	{
		121.6406,
		-241.5947,
		0.5786,
		0,
		"A",
		false,
		"Blueberry Ipari Park",
		3,
		2
	},
	{
		106.6406,
		-241.5947,
		0.5786,
		0,
		"A",
		false,
		"Blueberry Ipari Park",
		3,
		2
	},
	{
		97.1406,
		-252.3447,
		0.5786,
		90,
		"A",
		false,
		"Blueberry Ipari Park",
		3,
		2
	},
	{
		97.1406,
		-267.3447,
		0.5786,
		90,
		"A",
		false,
		"Blueberry Ipari Park",
		3,
		2
	},
	{
		106.6406,
		-278.0947,
		0.5786,
		180,
		"A",
		false,
		"Blueberry Ipari Park",
		3,
		2
	},
	{
		121.6406,
		-278.0947,
		0.5786,
		180,
		"A",
		false,
		"Blueberry Ipari Park",
		3,
		2
	},
	{
		136.6406,
		-278.0947,
		0.5786,
		180,
		"A",
		false,
		"Blueberry Ipari Park",
		3,
		2
	},
	{
		146.1406,
		-267.3447,
		0.5786,
		270,
		"A",
		false,
		"Blueberry Ipari Park",
		3,
		2
	},
	{
		146.1406,
		-252.3447,
		0.5786,
		270,
		"A",
		false,
		"Blueberry Ipari Park",
		3,
		2
	},
	{
		31.6406,
		-241.5947,
		0.5786,
		0,
		"B",
		false,
		"Blueberry Ipari Park",
		3,
		2
	},
	{
		46.6406,
		-241.5947,
		0.5786,
		0,
		"B",
		false,
		"Blueberry Ipari Park",
		3,
		2
	},
	{
		61.6406,
		-241.5947,
		0.5786,
		0,
		"B",
		false,
		"Blueberry Ipari Park",
		3,
		2
	},
	{
		71.1406,
		-252.3447,
		0.5786,
		270,
		"B",
		false,
		"Blueberry Ipari Park",
		3,
		2
	},
	{
		71.1406,
		-267.3447,
		0.5786,
		270,
		"B",
		false,
		"Blueberry Ipari Park",
		3,
		2
	},
	{
		61.6406,
		-278.0947,
		0.5786,
		180,
		"B",
		false,
		"Blueberry Ipari Park",
		3,
		2
	},
	{
		46.6406,
		-278.0947,
		0.5786,
		180,
		"B",
		false,
		"Blueberry Ipari Park",
		3,
		2
	},
	{
		31.6406,
		-278.0947,
		0.5786,
		180,
		"B",
		false,
		"Blueberry Ipari Park",
		3,
		2
	},
	{
		71.1406,
		-329.8447,
		0.5786,
		270,
		"C",
		false,
		"Blueberry Ipari Park",
		3,
		2
	},
	{
		71.1406,
		-314.8447,
		0.5786,
		270,
		"C",
		false,
		"Blueberry Ipari Park",
		3,
		2
	},
	{
		61.6406,
		-304.0947,
		0.5786,
		0,
		"C",
		false,
		"Blueberry Ipari Park",
		3,
		2
	},
	{
		46.6406,
		-304.0947,
		0.5786,
		0,
		"C",
		false,
		"Blueberry Ipari Park",
		3,
		2
	},
	{
		31.6406,
		-304.0947,
		0.5786,
		0,
		"C",
		false,
		"Blueberry Ipari Park",
		3,
		2
	},
	{
		146.1406,
		-329.8447,
		0.5786,
		270,
		"D",
		false,
		"Blueberry Ipari Park",
		3,
		2
	},
	{
		146.1406,
		-314.8447,
		0.5786,
		270,
		"D",
		false,
		"Blueberry Ipari Park",
		3,
		2
	},
	{
		136.6406,
		-304.0947,
		0.5786,
		0,
		"D",
		false,
		"Blueberry Ipari Park",
		3,
		2
	},
	{
		121.6406,
		-304.0947,
		0.5786,
		0,
		"D",
		false,
		"Blueberry Ipari Park",
		3,
		2
	},
	{
		106.6406,
		-304.0947,
		0.5786,
		0,
		"D",
		false,
		"Blueberry Ipari Park",
		3,
		2
	},
	{
		97.1406,
		-314.8447,
		0.5786,
		90,
		"D",
		false,
		"Blueberry Ipari Park",
		3,
		2
	},
	{
		97.1406,
		-329.8447,
		0.5786,
		90,
		"D",
		false,
		"Blueberry Ipari Park",
		3,
		2
	},
	{
		-203.2707,
		-221.1584,
		0.4286,
		90,
		"E",
		false,
		"Blueberry Ipari Park",
		3,
		2
	},
	{
		-203.2707,
		-236.1584,
		0.4286,
		90,
		"E",
		false,
		"Blueberry Ipari Park",
		3,
		2
	},
	{
		-203.2707,
		-251.1584,
		0.4286,
		90,
		"E",
		false,
		"Blueberry Ipari Park",
		3,
		2
	},
	{
		-193.7707,
		-260.6584,
		0.4286,
		180,
		"E",
		false,
		"Blueberry Ipari Park",
		3,
		2
	},
	{
		-178.7707,
		-260.6584,
		0.4286,
		180,
		"E",
		false,
		"Blueberry Ipari Park",
		3,
		2
	},
	{
		-163.7707,
		-260.6584,
		0.4286,
		180,
		"E",
		false,
		"Blueberry Ipari Park",
		3,
		2
	},
	{
		-148.7707,
		-260.6584,
		0.4286,
		180,
		"E",
		false,
		"Blueberry Ipari Park",
		3,
		2
	},
	{
		-139.2707,
		-251.1584,
		0.4286,
		270,
		"E",
		false,
		"Blueberry Ipari Park",
		3,
		2
	},
	{
		-139.2707,
		-236.1584,
		0.4286,
		270,
		"E",
		false,
		"Blueberry Ipari Park",
		3,
		2
	},
	{
		-139.2707,
		-221.1584,
		0.4286,
		270,
		"E",
		false,
		"Blueberry Ipari Park",
		3,
		2
	},
	{
		-113.2707,
		-221.1584,
		0.4286,
		90,
		"F",
		false,
		"Blueberry Ipari Park",
		3,
		2
	},
	{
		-113.2707,
		-236.1584,
		0.4286,
		90,
		"F",
		false,
		"Blueberry Ipari Park",
		3,
		2
	},
	{
		-113.2707,
		-251.1584,
		0.4286,
		90,
		"F",
		false,
		"Blueberry Ipari Park",
		3,
		2
	},
	{
		-102.5207,
		-260.6584,
		0.4286,
		180,
		"F",
		false,
		"Blueberry Ipari Park",
		3,
		2
	},
	{
		-87.5207,
		-260.6584,
		0.4286,
		180,
		"F",
		false,
		"Blueberry Ipari Park",
		3,
		2
	},
	{
		-87.5207,
		-286.6584,
		0.4286,
		0,
		"G",
		false,
		"Blueberry Ipari Park",
		3,
		2
	},
	{
		-102.5207,
		-286.6584,
		0.4286,
		0,
		"G",
		false,
		"Blueberry Ipari Park",
		3,
		2
	},
	{
		-113.2707,
		-296.1584,
		0.4286,
		90,
		"G",
		false,
		"Blueberry Ipari Park",
		3,
		2
	},
	{
		-113.2707,
		-311.1584,
		0.4286,
		90,
		"G",
		false,
		"Blueberry Ipari Park",
		3,
		2
	},
	{
		-113.2707,
		-326.1584,
		0.4286,
		90,
		"G",
		false,
		"Blueberry Ipari Park",
		3,
		2
	},
	{
		-102.5207,
		-335.6584,
		0.4286,
		180,
		"G",
		false,
		"Blueberry Ipari Park",
		3,
		2
	},
	{
		-87.5207,
		-335.6584,
		0.4286,
		180,
		"G",
		false,
		"Blueberry Ipari Park",
		3,
		2
	},
	{
		2073.5549,
		-2300.1851,
		12.5501,
		270,
		"A",
		false,
		"Ocean Docks Ipari Park",
		1,
		2
	},
	{
		2073.5552,
		-2285.1851,
		12.5501,
		270,
		"A",
		false,
		"Ocean Docks Ipari Park",
		1,
		2
	},
	{
		2073.5552,
		-2270.1851,
		12.5501,
		270,
		"A",
		false,
		"Ocean Docks Ipari Park",
		1,
		2
	},
	{
		2062.7849,
		-2260.6851,
		12.5501,
		0,
		"A",
		false,
		"Ocean Docks Ipari Park",
		1,
		2
	},
	{
		2047.8051,
		-2260.6851,
		12.5501,
		0,
		"A",
		false,
		"Ocean Docks Ipari Park",
		1,
		2
	},
	{
		2037.0551,
		-2270.1851,
		12.5501,
		90,
		"A",
		false,
		"Ocean Docks Ipari Park",
		1,
		2
	},
	{
		2037.0551,
		-2285.1851,
		12.5501,
		90,
		"A",
		false,
		"Ocean Docks Ipari Park",
		1,
		2
	},
	{
		2037.0551,
		-2300.1851,
		12.5501,
		90,
		"A",
		false,
		"Ocean Docks Ipari Park",
		1,
		2
	},
	{
		2047.7848,
		-2309.6851,
		12.5501,
		180,
		"A",
		false,
		"Ocean Docks Ipari Park",
		1,
		2
	},
	{
		2062.8052,
		-2309.6851,
		12.5501,
		180,
		"A",
		false,
		"Ocean Docks Ipari Park",
		1,
		2
	},
	{
		2073.5552,
		-2195.1851,
		12.5501,
		270,
		"B",
		false,
		"Ocean Docks Ipari Park",
		1,
		2
	},
	{
		2073.5552,
		-2210.1851,
		12.5501,
		270,
		"B",
		false,
		"Ocean Docks Ipari Park",
		1,
		2
	},
	{
		2073.5552,
		-2225.1851,
		12.5501,
		270,
		"B",
		false,
		"Ocean Docks Ipari Park",
		1,
		2
	},
	{
		2062.7849,
		-2234.6851,
		12.5501,
		180,
		"B",
		false,
		"Ocean Docks Ipari Park",
		1,
		2
	},
	{
		2047.8051,
		-2234.6851,
		12.5501,
		180,
		"B",
		false,
		"Ocean Docks Ipari Park",
		1,
		2
	},
	{
		2037.0551,
		-2225.1851,
		12.5501,
		90,
		"B",
		false,
		"Ocean Docks Ipari Park",
		1,
		2
	},
	{
		2037.0551,
		-2210.1851,
		12.5501,
		90,
		"B",
		false,
		"Ocean Docks Ipari Park",
		1,
		2
	},
	{
		2037.0551,
		-2195.1851,
		12.5501,
		90,
		"B",
		false,
		"Ocean Docks Ipari Park",
		1,
		2
	},
	{
		1984.6531,
		-2234.6851,
		12.5803,
		180,
		"C",
		false,
		"Ocean Docks Ipari Park",
		1,
		2
	},
	{
		2000.2848,
		-2234.6851,
		12.5501,
		180,
		"C",
		false,
		"Ocean Docks Ipari Park",
		1,
		2
	},
	{
		2011.0552,
		-2225.1851,
		12.5501,
		270,
		"C",
		false,
		"Ocean Docks Ipari Park",
		1,
		2
	},
	{
		2011.0552,
		-2210.1851,
		12.5501,
		270,
		"C",
		false,
		"Ocean Docks Ipari Park",
		1,
		2
	},
	{
		2011.0551,
		-2195.1851,
		12.5501,
		270,
		"C",
		false,
		"Ocean Docks Ipari Park",
		1,
		2
	},
	{
		1985.3051,
		-2309.6851,
		12.5501,
		180,
		"D",
		false,
		"Ocean Docks Ipari Park",
		1,
		2
	},
	{
		2000.2849,
		-2309.6851,
		12.5501,
		180,
		"D",
		false,
		"Ocean Docks Ipari Park",
		1,
		2
	},
	{
		2011.0551,
		-2300.1851,
		12.5501,
		270,
		"D",
		false,
		"Ocean Docks Ipari Park",
		1,
		2
	},
	{
		2011.0549,
		-2285.1851,
		12.5501,
		270,
		"D",
		false,
		"Ocean Docks Ipari Park",
		1,
		2
	},
	{
		2011.0549,
		-2270.1851,
		12.5501,
		270,
		"D",
		false,
		"Ocean Docks Ipari Park",
		1,
		2
	},
	{
		2000.3051,
		-2260.6851,
		12.5501,
		0,
		"D",
		false,
		"Ocean Docks Ipari Park",
		1,
		2
	},
	{
		1985.3051,
		-2260.6851,
		12.5501,
		0,
		"D",
		false,
		"Ocean Docks Ipari Park",
		1,
		2
	}
}
dropoffPoses = {
	{
		-1215.103515625,
		1808.37890625,
		41.560150146484
	},
	{
		745.9736328125,
		264.4892578125,
		27.0859375
	},
	{
		1337.478515625,
		285.5703125,
		19.561452865601
	},
	{
		2269.138671875,
		27.1650390625,
		26.433862686157
	},
	{
		2277.3701171875,
		-83.3173828125,
		26.524486541748
	},
	{
		2443.7392578125,
		-43.2470703125,
		26.864574432373
	},
	{
		2494.8251953125,
		5.384765625,
		27.070764541626
	},
	{
		2503.416015625,
		6.0771484375,
		27.185266494751
	},
	{
		2519.2470703125,
		-23.0400390625,
		27.237564086914
	},
	{
		2550.859375,
		12.025390625,
		27.012769699097
	},
	{
		2494.3662109375,
		129.5244140625,
		27.021995544434
	},
	{
		2434.0361328125,
		114.99609375,
		26.468873977661
	},
	{
		2861.0830078125,
		-1355.1943359375,
		11.019073486328
	},
	{
		2762.1337890625,
		-1944.4794921875,
		13.546875
	},
	{
		2262.544921875,
		-2428.3486328125,
		13.546875
	},
	{
		2197.8310546875,
		-2654.9228515625,
		13.546875
	},
	{
		2104.0283203125,
		-2089.447265625,
		13.546875
	},
	{
		1848.8369140625,
		-2101.8828125,
		13.551877975464
	},
	{
		1372.435546875,
		-1818.3017578125,
		13.550800323486
	},
	{
		2041.62109375,
		-1654.904296875,
		13.546875
	},
	{
		2092.5634765625,
		-1595.517578125,
		13.336435317993
	},
	{
		2285.7890625,
		-1674.0244140625,
		14.701529502869
	},
	{
		2509.12109375,
		-1782.75390625,
		13.546875
	},
	{
		2449.7412109375,
		-1549.513671875,
		24.000526428223
	},
	{
		2521.982421875,
		-1524.4404296875,
		23.838260650635
	},
	{
		-2531.2216796875,
		2284.1025390625,
		4.984375
	},
	{
		1021.2841796875,
		-1451.7607421875,
		13.554634094238
	},
	{
		868.1259765625,
		-1522.865234375,
		13.5546875
	},
	{
		663.017578125,
		-1415.548828125,
		13.555514335632
	},
	{
		602.7724609375,
		-1508.8271484375,
		14.977685928345
	},
	{
		-67.1259765625,
		-1583.1494140625,
		2.6171875
	},
	{
		-274.873046875,
		-2186.8818359375,
		28.762731552124
	},
	{
		-2234.2646484375,
		-2472.9072265625,
		31.099021911621
	},
	{
		-2147.1748046875,
		-2541.005859375,
		30.6171875
	},
	{
		-2097.5322265625,
		-2241.830078125,
		30.625
	},
	{
		-2756.50390625,
		-296.580078125,
		7.0390625
	},
	{
		-2566.388671875,
		602.1083984375,
		14.453125
	},
	{
		-1786.4482421875,
		1198.27734375,
		25.125
	},
	{
		-1645.2646484375,
		1295.5947265625,
		7.03567123413
	},
	{
		-1834.4140625,
		1417.8125,
		7.1875
	},
	{
		-2896.6044921875,
		1162.2255859375,
		13.260840415955
	},
	{
		-2861.783203125,
		1056.1240234375,
		32.498962402344
	},
	{
		-2848.88671875,
		687.1279296875,
		22.671876907349
	},
	{
		-2458.8994140625,
		2292.2109375,
		4.984375
	},
	{
		-1294.294921875,
		2719.59765625,
		50.0703125
	},
	{
		-1563.1318359375,
		2695.236328125,
		55.773067474365
	},
	{
		-1936.853515625,
		2383.6142578125,
		49.4921875
	},
	{
		-754.1572265625,
		1587.9873046875,
		26.9609375
	},
	{
		-866.2099609375,
		1553.982421875,
		23.789836883545
	},
	{
		-683.779296875,
		965.599609375,
		12.1328125
	}
}
paintPrices = {
	12000,
	9600,
	11200,
	4800,
	4800,
	4800,
	4800,
	4800,
	4800,
	4800,
	4800,
	4800,
	4800,
	4800,
	4800,
	4800,
	4800
}
local count = 1
for i = 1, #garageDoors do
	local r = math.rad(garageDoors[i][4]) + math.pi / 2
	garageDoors[i][1] = garageDoors[i][1] + 4 * math.cos(r)
	garageDoors[i][2] = garageDoors[i][2] + 4 * math.sin(r)
	if 1 < i and (garageDoors[i][5] ~= garageDoors[i - 1][5] or garageDoors[i][7] ~= garageDoors[i - 1][7]) then
		count = 1
	end
	garageDoors[i][6] = count
	count = count + 1
end

function getAisleId(doorId, aisle)
	return doorId * 10 + aisle
end

-- // Folyosó id, Marker id (1, 14)
function getAisleWorkshopId(aisleId, inside)
	return aisleId * 20 + inside
end

-- // Folyosó id, Dimension
function getInsideFromId(aisleId, id)
	if isWorkshopIdValid(id) then
		return id - (aisleId * 20)
	else
		return false
	end
end
wsX, wsY, wsZ = 0, 0, 5000
lobbyX, lobbyY, lobbyZ = wsX, wsY, wsZ + 45
targetInt = 0
targetIntLobby = 0
lobbyInsideDoor = {
	-66.5735,
	-4.2903,
	-4.049,
	-90
}
aisleDoors = {
	{
		-48,
		13.2885,
		-4.049,
		0
	},
	{
		-28.8,
		13.2885,
		-4.049,
		0
	},
	{
		-9.6,
		13.2885,
		-4.049,
		0
	},
	{
		9.6,
		13.2885,
		-4.049,
		0
	},
	{
		28.8,
		13.2885,
		-4.049,
		0
	},
	{
		48,
		13.2885,
		-4.049,
		0
	},
	{
		69.2375,
		6.3125,
		-4.049,
		270
	},
	{
		69.2375,
		-12.8875,
		-4.049,
		270
	},
	{
		48,
		-21.869,
		-4.049,
		180
	},
	{
		28.8,
		-21.869,
		-4.049,
		180
	},
	{
		9.6,
		-21.869,
		-4.049,
		180
	},
	{
		-9.6,
		-21.869,
		-4.049,
		180
	},
	{
		-28.8,
		-21.869,
		-4.049,
		180
	},
	{
		-48,
		-21.869,
		-4.049,
		180
	}
}
function isWorkshopIdValid(id)
	local doorId, aisleId, insideId = getAisleFromWorkshop(id)
	if garageDoors[doorId] then
		return isAisleIdValid(aisleId) and 1 <= insideId and insideId <= #aisleDoors
	end
end
function isAisleIdValid(aisleId)
	local doorId, aisle = getDoorFromAisle(aisleId)
	if garageDoors[doorId] then
		return 1 <= aisle and aisle <= garageDoors[doorId][8]
	end
end
function isGarageAisleIdValid(aisleId)
	local doorId, aisle = getDoorFromAisle(aisleId)
	if garageDoors[doorId] then
		return 1 <= aisle and aisle <= garageDoors[doorId][9]
	end
end
function isGarageIdValid(id)
	local doorId, aisleId, insideId = getAisleFromWorkshop(id)
	if garageDoors[doorId] then
		return isAisleIdValidGarage(aisleId) and 1 <= insideId and insideId <= #aisleDoors
	end
end
function isAisleIdValidGarage(aisleId)
	local doorId, aisle = getDoorFromAisle(aisleId)
	if garageDoors[doorId] then
		return 1 <= aisle and aisle <= garageDoors[doorId][9]
	end
end
function getWorkshopsInAisle(aisleId)
    local workshops = {}

    if not isAisleIdValid(aisleId) then
        return workshops
    end

    for insideId = 1, #aisleDoors do
        local id = aisleId * 20 + insideId
        table.insert(workshops, id)
    end

    return workshops
end
function getDoorFromAisle(aisleId)
	local doorId = math.floor(aisleId / 10)
	return doorId, aisleId % 10
end

function getAisleFromWorkshop(id)
	local aisleId = math.floor(id / 20)
	local doorId = math.floor(aisleId / 10)
	local insideId = id - aisleId * 20
	return doorId, aisleId, insideId
end

workStateFlow = {
	"transportIn",
	"sanding",
	"primer",
	"primerDry",
	"break",
	"paint",
	"paintDry",
	"transportOut"
}
sprayGunPoses = {
	{
		-8.3115,
		-2.0055,
		0.9955,
		-24.763,
		0,
		360
	},
	{
		-8.3115,
		-1.5632,
		0.9839,
		-16.8406,
		0,
		180
	}
}
sanderPosition = {
	{
		7.7042,
		12.2628,
		1.2542,
		0,
		0,
		42.8787
	},
	{
		7.8175,
		12.1226,
		1.616,
		0,
		0,
		-42.1082
	},
	{
		7.8175,
		12.1599,
		2.0799,
		0,
		0,
		-173.7396
	},
	{
		-7.3357,
		16.3663,
		1.0473,
		0,
		0,
		75.9587
	}
}
barNeedles = {
	{
		-8.3211,
		-2.3953,
		1.2443,
		0
	},
	{
		-8.3211,
		-1.1533,
		1.2443,
		0
	}
}
sanderSockets = {
	{
		-0.5881,
		7.3629,
		0.4646,
		90
	},
	{
		-8.395,
		11.2334,
		0.4646,
		0
	},
	{
		-3.2948,
		16.8948,
		0.4646,
		-90
	},
	{
		8.3947,
		7.2397,
		0.4646,
		180
	},
	{
		4.3837,
		-2.8395,
		0.4646,
		90
	},
	{
		-0.0809,
		6.9029,
		0.4646,
		0
	}
}

mixerTankMaximum = {
	primer = 20.5,
	base = 23.5,
	color = 200
}

function getWorkshopIds(ws)
	local ids = {}
	for i = 1, 2 do
		table.insert(ids, ws * 10 + i)
	end
	return ids
end

function getWorkshopId(id)
	return math.floor(id / 10)
end

function getWorkId(ws, id)
	if 1 <= id and id <= 2 then
		return ws * 10 + id
	end
end

function convertWorkId(ws, id)
	if id >= ws * 10 + 1 and id <= ws * 10 + 2 then
		return id - ws * 10
	end
end

function hue2rgb(m1, m2, h)
	if h < 0 then
		h = h + 1
	elseif 1 < h then
		h = h - 1
	end
	if 1 > h * 6 then
		return m1 + (m2 - m1) * h * 6
	elseif 1 > h * 2 then
		return m2
	elseif 2 > h * 3 then
		return m1 + (m2 - m1) * (0.6666666666666666 - h) * 6
	else
		return m1
	end
end
function convertHSLToRGB(h, s, l)
	h = h / 360
	local m2
	if l < 0.5 then
		m2 = l * (s + 1)
	else
		m2 = l + s - l * s
	end
	local m1 = l * 2 - m2
	local r = hue2rgb(m1, m2, h + 0.3333333333333333) * 255
	local g = hue2rgb(m1, m2, h) * 255
	local b = hue2rgb(m1, m2, h - 0.3333333333333333) * 255
	return math.floor(r + 0.5), math.floor(g + 0.5), math.floor(b + 0.5)
end
function convertRGBToHSL(r, g, b)
	r = r / 255
	g = g / 255
	b = b / 255
	local max = math.max(r, g, b)
	local min = math.min(r, g, b)
	local h, s
	local l = (max + min) / 2
	if max == min then
		h = 0
		s = 0
	else
		local d = max - min
		s = 0.5 < l and d / (2 - max - min) or d / (max + min)
		if max == r then
			h = (g - b) / d + (g < b and 6 or 0)
		end
		if max == g then
			h = (b - r) / d + 2
		end
		if max == b then
			h = (r - g) / d + 4
		end
		h = h / 6
	end
	return h * 360, s, l
end
function hslToXyz(hue, saturation, lightness)
	local x = math.cos(hue / 180 * math.pi) * saturation
	local y = math.sin(hue / 180 * math.pi) * saturation
	local z = lightness
	return x, y, z
end
function xyzToHsl(x, y, z)
	local h = math.atan2(y, x) * 180 / math.pi
	local s = math.sqrt(x * x + y * y)
	local l = z
	return h, s, l
end
function hexToRGB(val)
	local r = tonumber("0x" .. val:sub(1, 2))
	local g = tonumber("0x" .. val:sub(3, 4))
	local b = tonumber("0x" .. val:sub(5, 6))
	return r, g, b
end
function getColorCodeHex(rgb)
	if rgb then
		local hexadecimal = ""
		for key, value in pairs(rgb) do
			local hex = ""
			while 0 < value do
				local index = math.fmod(value, 16) + 1
				value = math.floor(value / 16)
				hex = string.sub("0123456789ABCDEF", index, index) .. hex
			end
			if string.len(hex) == 0 then
				hex = "00"
			elseif string.len(hex) == 1 then
				hex = "0" .. hex
			end
			hexadecimal = hexadecimal .. hex
		end
		return hexadecimal
	end
end
permissionList = {
	{
		"openClose",
		"Műhely nyitás/zárás"
	},
	{
		"useSkin",
		"Munkaruha használata"
	},
	{
		"sander",
		"Csiszológép használata"
	},
	{
		"paintGun",
		"Festékszóró használata"
	},
	{
		"toggleDry",
		"Fényezőkamra használata"
	},
	{
		"nextState",
		"Munkafolyamat léptetése"
	},
	{
		"sendOffer",
		"Ajánlat küldése"
	},
	{
		"startJob",
		"Munka megkezdése"
	},
	{
		"cancelJob",
		"Munka visszamondása"
	},
	{
		"useMixer",
		"Keverőgép használata"
	},
	{
		"mixerMaintenance",
		"Keverőgép karbantartása"
	},
	{
		"createOrder",
		"MiguItalia rendelés leadása"
	},
	{
		"transportOrder",
		"MiguItalia rendelés átvétele"
	},
	{
		"transportIn",
		"Autószállítás a műhelybe"
	},
	{
		"transportOut",
		"Autó leszállítása az ügyfélnek"
	},
	{
		"buyUpgrade",
		"Fejlesztés vásárlása"
	}
}
maxPermissionPlayers = 12
permissionIds = {}
for i = 1, #permissionList do
	permissionIds[permissionList[i][1]] = i
end
colorNames = {
	"WHITE",
	"BLACK",
	"RL00",
	"GL12",
	"BL24",
	"CL18",
	"ML30",
	"YL60",
	"RD00",
	"GD12",
	"BD24",
	"CD18",
	"MD30",
	"YD60"
}
colorPalette = {
	"FFFFFF",
	"000000",
	"FF0000",
	"00FF00",
	"0000FF",
	"00FFFF",
	"FF00FF",
	"FFFF00",
	"400000",
	"004000",
	"000040",
	"004040",
	"400040",
	"404000"
}
for i = 1, #colorPalette do
	local r, g, b = hexToRGB(colorPalette[i])
	local h, s, l = convertRGBToHSL(r, g, b)
	local x, y, z = hslToXyz(h, s, l)
	colorPalette[i] = {
		r,
		g,
		b,
		x,
		y,
		z
	}
end
validColors = {
	["67722A"] = {
		0.644,
		0.75,
		1.4,
		1.48,
		0,
		0.43,
		0,
		2.21,
		1.74,
		2,
		0.48,
		0.66,
		0.23,
		2.03
	},
	["959CAA"] = {
		4.8673293645697,
		0,
		2.8320288952747,
		2.6243982899073,
		4.3673287245697,
		2.2573287245697,
		1.2073287245697,
		1.3349287245697,
		0,
		0,
		0,
		0,
		0,
		0
	},
	["595E66"] = {
		1.37296,
		1.4732,
		0.8948,
		1.132,
		1.3032,
		0.9632,
		0.9832,
		1.3132,
		1.0432,
		0.9532,
		1.3032,
		0.7932,
		0.4896,
		0
	},
	["060607"] = {
		0,
		99.3424,
		0,
		0,
		0,
		0,
		0,
		0,
		3.9384,
		1.8864,
		14.1924,
		1.9824,
		0,
		1.2412
	},
	["080812"] = {
		0,
		134.974064,
		0,
		0,
		0,
		0,
		0,
		0,
		1.380112,
		0,
		81.760864,
		4.170864,
		2.980864,
		1.500864
	},
	["0E2119"] = {
		0,
		3.79472,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		3.65792,
		2.30792,
		2.96792,
		0,
		1.53032
	},
	["3D0312"] = {
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		10.183943926784,
		0,
		0,
		0,
		3.955943926784,
		0
	},
	["8C0808"] = {
		0,
		0,
		6.529692790784,
		0,
		0,
		0,
		0,
		0.565613430784,
		6.279692790784,
		0,
		0,
		0,
		1.709385590784,
		1.154620790784
	},
	A80A24 = {
		0,
		0,
		60.973093346673,
		0,
		0,
		0,
		27.953093346673,
		3.3738933466726,
		55.223093346673,
		0,
		0,
		0,
		5.0730932686029,
		2.4236692615987
	},
	["3B332A"] = {
		0,
		3.5,
		1.75,
		1,
		0.25,
		0.25,
		0.75,
		2,
		3,
		2.75,
		3,
		1.25,
		2.25,
		3
	},
	["09315F"] = {
		0,
		0,
		0,
		0,
		8.3516,
		5.6616,
		0,
		0,
		0,
		1.151199872,
		24.4116,
		25.6616,
		2.1716,
		0
	},
	["0D1422"] = {
		0,
		9.465056,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		2.831008,
		10.470704,
		8.720704,
		4.720704,
		0.330704
	},
	["242132"] = {
		0,
		3.64,
		0,
		0,
		1.2,
		0.48,
		0.51,
		0.42,
		0.45,
		0.33,
		2.47,
		1.09,
		1.55,
		1.85
	},
	["522C06"] = {
		0,
		0,
		7.5496,
		0,
		0,
		0,
		0,
		1.8796,
		30.2696,
		0,
		0,
		0,
		0,
		35.0196
	},
	["879799"] = {
		7.0181566266806,
		0.25,
		3.1888480359705,
		4.9980926266806,
		6.5181566266806,
		4.9857566266806,
		5.0041566266806,
		6.2681566266806,
		0,
		0.79114625260275,
		0.93130625588001,
		0.46000145649238,
		0,
		0
	},
	["210E17"] = {
		0,
		9.1144,
		0,
		0,
		0,
		0,
		0,
		0,
		7.9948,
		0,
		4.0644,
		0,
		7.9948,
		4.4948
	},
	["949380"] = {
		2.5669123999792,
		0.096912399979228,
		2.0113104799792,
		2.0541123999792,
		2.2993123999792,
		1.7281123999792,
		1.7562864799792,
		2.3149123999792,
		0.41111591997923,
		0.29063561277923,
		0,
		0,
		0,
		0.73122752008504
	},
	["1040A7"] = {
		0.25000000000066,
		0,
		0,
		0,
		12.973840002046,
		12.723840002046,
		2.1762400020464,
		0,
		0,
		0,
		12.973840002046,
		4.0938400020464,
		0.49424000204636,
		0
	},
	AECB60 = {
		9.02571759104,
		0,
		5.7441176064,
		8.7757176064,
		0,
		0.7016419328,
		0,
		9.0257176064,
		0.2852100864,
		2.5951416064,
		0,
		0,
		0,
		0.6379582464
	},
	["132F26"] = {
		0,
		1.5,
		0,
		0,
		0,
		0.690272,
		0,
		0,
		0,
		4.780272,
		4.030272,
		4.280272,
		0.550272,
		2.810272
	},
	["685D49"] = {
		2.35,
		1,
		2.75,
		2.5,
		0.5,
		0.25,
		2.25,
		2.5,
		2.25,
		2.5,
		2.5,
		1.5,
		1.5,
		2.5
	},
	["947C99"] = {
		6.7782000690237,
		0.33820006902366,
		4.9759735090237,
		3.9526844210237,
		6.2782000690237,
		4.1998000690237,
		6.0250000690237,
		6.2782000690237,
		0,
		0,
		1.8312221257993,
		0,
		1.8524320806358,
		0
	},
	["18181A"] = {
		0,
		6.99,
		0,
		0,
		0.65,
		0,
		0,
		0.62,
		0.73,
		0.73,
		1.57,
		0.81,
		0.81,
		1.12
	},
	AD9D79 = {
		14.707933339772,
		0,
		14.207933339773,
		14.207933339773,
		10.457917339773,
		0.77086678527836,
		4.4863050506846,
		13.957933339773,
		3.0773771797725,
		0,
		0,
		0,
		0,
		0.9019865928106
	},
	["6A858C"] = {
		18.45972422697,
		13.709724227584,
		1.270004878336,
		6.102524227584,
		12.959724227584,
		8.209724227584,
		7.959724227584,
		13.459724227584,
		0,
		3.215441936384,
		5.139452022784,
		2.561245353984,
		0,
		0
	},
	["343641"] = {
		0.1,
		1.5,
		0.25,
		0.25,
		0.75,
		0.5,
		0.75,
		0.5,
		0.5,
		0.75,
		1.25,
		1,
		0.75,
		1
	},
	["261E45"] = {
		0,
		4.31,
		0,
		0,
		8.97,
		0.81,
		3.05,
		0,
		0.39,
		0,
		13.22,
		8.97,
		12.47,
		10.47
	},
	["240707"] = {
		0,
		4.570864,
		0,
		0,
		0,
		0,
		0,
		0,
		9.069136,
		0,
		0,
		0,
		0.179136,
		0.179136
	},
	DADEE1 = {
		75.8,
		3.75,
		0,
		0,
		4.75,
		8.25,
		1.75,
		2.25,
		0,
		0,
		0.75,
		0,
		0,
		0
	},
	CCDEE1 = {
		63.948130338132,
		0,
		0,
		3.1160950613323,
		7.2939794261323,
		19.096186658132,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0
	},
	["7E4328"] = {
		0.25296,
		0,
		2.3184,
		0,
		0,
		0,
		2.2352,
		2.3084,
		2.3184,
		2.2676,
		0,
		0,
		0.9356,
		1.3184
	},
	DC3E24 = {
		4.0141123130497,
		0,
		14.984786347513,
		0,
		0,
		0,
		4.4547703475126,
		8.9947863475126,
		5.1947863475126,
		0,
		0,
		0,
		0,
		0
	},
	["059A89"] = {
		0,
		0,
		0,
		0.599359997952,
		0,
		6.626367997952,
		0,
		0.08,
		0,
		1.241167997952,
		0,
		6.183967997952,
		0,
		0
	},
	["0B1A1F"] = {
		0,
		8.5408064,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		2.81459648,
		5.04499648,
		7.54499648,
		0.89499648,
		0
	},
	["57B458"] = {
		23.177487616,
		2.2500064,
		3.46458368,
		22.677488,
		17.156688,
		5.417488,
		0,
		20.177488,
		0,
		17.177488,
		0,
		2.58616448,
		0,
		0.952128
	},
	F4DE06 = {
		0,
		0,
		8.44728896,
		0,
		0,
		0,
		0,
		70.67588096,
		0,
		0,
		0,
		0,
		0,
		2.34588096
	},
	["2B1B4A"] = {
		0,
		3.000032,
		0,
		0,
		3.989984,
		0.279984,
		2.989984,
		0,
		0.359936,
		0,
		7.239984,
		3.989984,
		6.989984,
		3.919984
	},
	E55B0F = {
		0,
		0,
		16.202074546878,
		0,
		0,
		0,
		0,
		10.372074546878,
		1.6758985468783,
		0,
		0,
		0,
		0,
		0
	},
	B01CB0 = {
		11.67000008704,
		0,
		2.3564214784,
		0,
		10.3489014784,
		0,
		26.5989014784,
		0,
		10.8484374784,
		0,
		2.9689014784,
		0,
		26.0989014784,
		0
	},
	["35AAE6"] = {
		1.6150045248587,
		0,
		0,
		0,
		4.3759215690828,
		7.8832047690828,
		0,
		0,
		0,
		0,
		0,
		0.095876769082769,
		0,
		0
	}
}
validColorList = {}
validColorNames = {}
colorNameBackward = {}
for col in pairs(validColors) do
	local sum = 0
	for i = 1, #validColors[col] do
		sum = sum + validColors[col][i]
	end
	for i = 1, #validColors[col] do
		validColors[col][i] = validColors[col][i] / sum * 100
	end
	table.insert(validColorList, col)
	local r, g, b = hexToRGB(col)
	local h, s, l = convertRGBToHSL(r, g, b)
	l = math.floor(l * 21 + 0.5) + 1
	local c = string.sub("ABCDEFGHJKLMNPRSTVWXYZ", l, l)
	h = math.floor(h / 360 * 31 + 0.5) + 1
	local c2 = string.sub("0123456789ABCDEFGHJKLMNPRSTVWXYZ", h, h)
	s = tostring(math.floor(s * 100 + 0.5))
	for i = string.len(s) + 1, 3 do
		s = "0" .. s
	end
	local name = c .. c2 .. s
	while colorNameBackward[name] do
		s = tostring(tonumber(s) + 1)
		for i = string.len(s) + 1, 3 do
			s = "0" .. s
		end
		name = c .. c2 .. s
	end
	validColorNames[col] = name
	colorNameBackward[name] = col
end
function shuffleTable(t)
	local rand = math.random
	local iterations = #t
	local j
	for i = iterations, 2, -1 do
		j = rand(i)
		t[i], t[j] = t[j], t[i]
	end
	return t
end
emailReferrer = {
	"Unokatestvérem",
	"Barátom",
	"Régi, közös ismerősünk",
	"Kollégám",
	"Testvérem",
	"Partner cégem"
}
offerTitles = {
	"Árajánlatkérés",
	"Ajánlatkérés",
	"Fényezés",
	"Festésre ajánlat",
	"Érdeklődés"
}
offerPrices = {
	{0.925, 0.75},
	{0.7, 0.916},
	{0.475, 1.082},
	{0.25, 1.248}
}
function getOfferEmail(id, shopName, ref, vehicleName, colorName, parts, sender)
	local text = ""
	ref = emailReferrer[ref]
	if id == 1 then
		text = text .. "Tisztelt " .. shopName .. [[
!
		
]]
		text = text .. ref .. " ajánlotta az Ön festő műhelyét, és adta meg ezt az elérhetőséget.\n\n"
		text = text .. "Az ügyben keresném, hogy nemrégiben vásároltam egy használt " .. vehicleName .. " gépjárművet. A járművön több, szükséges karosszéria munkálat történt. A Legtöbb javítást - elem cserét sajnos nem sikerült színazonosan megoldani, illetve a jármű eredeti fényezése is elég viseltes.\n\n"
		text = text .. "Amit mindenképp újra kéne fényezni az autó eredeti színére (" .. colorName .. ") az az alábbi elemek: " .. parts .. [[
		
		
]]
		text = text .. "Kérem válasz levélben küldjön egy ajánlatot, hogy mekkora összegért tudná a szükséges munkálatokat elvégezni.\n\n"
		text = text .. "Válaszát előre is köszönöm!\n"
		text = text .. "Szép napot!\n\n"
		text = text .. "Tisztelettel:\n"
		text = text .. sender
	elseif id == 2 then
		text = text .. "Tisztelt " .. shopName .. [[
!
		
]]
		text = text .. ref .. " ajánlotta az Ön festő műhelyét, és adta meg ezt az elérhetőséget.\n\n"
		text = text .. "Azon ügyben írom ezt az e-mailt Önnek, hogy egy sajnálatos közúti baleset következtében " .. vehicleName .. " gépjárművem megrongálódott. Szerencsére anyagi káron kívül más gond nem történt, viszont a járművön lenne bőven fényezni való elem, amit " .. colorName .. " színkódra kéne fényezni. A fényezendő elemek az alábbiak: " .. parts
		text = text .. "\n\nEzekre a munkákra kérnék egy korrekt árajánlatot, lehetőleg minél hamarabb, hisz az autó fontos családunk számára is.\n\n"
		text = text .. "Várom mielőbbi válaszát!\n\n"
		text = text .. "Üdvözlettel:\n"
		text = text .. sender
	elseif id == 3 then
		text = text .. "Üdv!\n\n"
		text = text .. "A minap pont az internetet böngésztem, amikor egy hirdetésbe futottam bele, miszerint az Ön műhelye vállal autófényezést. Ott találtam ezt az elérhetőséget is. Nos nekem lenne egy " .. vehicleName .. " gépjárművem, amin több sérülés is található, ezenkívül korábban, egy karosszérialakatos elemeket is cserélt rajta, amit színazonosra (" .. colorName .. ") kéne fújni. Az ügyben érdeklődnék, hogy kb mennyibe kerülne, ezekkel az elemekkel kalkulálva: " .. parts
		text = text .. "\n\nMielőbbi válaszát várom!\n\n"
		text = text .. "Szép napot!\n\n"
		text = text .. sender
	elseif id == 4 then
		text = text .. "Tisztelt " .. shopName .. [[
!
		
]]
		text = text .. "Cégünk használt gépjárművek értékesítésével foglalkozik hosszú évek óta. Fő profilunk, hogy külföldről importált, rosszabb állapotú gépjárműveket, a lehető legjobb minőségben helyreállítsunk és azt értékesítsük. Több ismerős is ajánlotta az Ön műhelyét. Lenne egy fényezendő " .. vehicleName .. " típusú járművünk, aminek a " .. parts .. " elemeit kellene fényezni, " .. colorName .. " színben.\n\n"
		text = text .. "Kérnénk erre egy megfelelő ajánlatot Öntől. Korrekt ajánlat esetén, mielőbb szeretnénk ezt a járművet megcsináltatni, illetve, megfelelő együttműködés esetén, a jövőben több járművet is fényeztetnénk Önnel.\n\n"
		text = text .. "Várjuk mielőbbi válaszát!\n\n"
		text = text .. "Tisztelettel:\n"
		text = text .. sender
	elseif id == 5 then
		text = text .. "Tisztelt " .. shopName .. [[
!
		
]]
		text = text .. "Azért kerestük fel az Ön műhelyét ezen elérhetőségen, mivel biztosítónk szerződéses ügyfeleinek a bekövetkezett káreset javíttatását is elintézi. Egyik ügyfelünk " .. vehicleName .. " típusú járművén az alábbi fényezési munkálatokra kérnénk árajánlatot: " .. parts .. ". Mindezt pedig " .. colorName .. " színben kéne megcsinálni.\n\n"
		text = text .. "Mielőbbi válaszát előre is köszönjük!\n\n"
		text = text .. "Tisztelettel:\n"
		text = text .. sender
	elseif id == 6 then
		text = text .. "Helló!\n\n"
		text = text .. ref .. " adta ezt az elérhetőséget.\n\n"
		text = text .. "Nagy gondba kerültem, a párom a múlt héten, nem tudom szebben fogalmazni, megcsukta a kocsit, nem kicsit, de cserébe viszont nagyon... A gond, hogy addig is autót kell bérelnem, mert kell a melóhoz. Na most egy \226\128\156szaki\226\128\157 összerakta bontott és utángyártott alkatrészekből, de még a festés hátra van. Azért is fordulok hozzád, mert ajánlottak téged. Ez egy " .. vehicleName .. " autó lenne, festeni kéne ezeket: " .. parts .. ". Az autó színe: " .. colorName .. [[
		
		
]]
		text = text .. "Légyszi mielőbb üzenj meg nekem egy árat, hogy mennyiért tudnád vállalni.\n\n"
		text = text .. "Köszi előre is!\n\n"
		text = text .. sender
	elseif id == 7 then
		text = text .. [[
Szia!
		
]]
		text = text .. "Láttam a neten keresgélve ezt a műhelyt, ez a mail volt elérésként megadva.\n\n"
		text = text .. "Pár hete SightCity Advertisementen találtam egy autót, ami rohadt jól nézett ki képek alapján, szóval meg is vettem... Bárcsak ne tettem volna, szó szerint rohadt... Később kiderült, hogy egy csomó karosszéria meló van rajta, cserélni kellett elemeket, mert csak rá volt fújva, meg inkább nem is sorolom... A kocsi már nagyjából készen van, viszont mindenképp fújni kéne. Ez egy " .. vehicleName .. " egyébként és a következő elemeket kéne " .. colorName .. " színre fújni: " .. parts .. [[
		
		
]]
		text = text .. "Kérdés az lenne, hogy ezt mennyiért tudod vállalni?\n\n"
		text = text .. "Köszi előre is a válaszod!\n\n"
		text = text .. sender
	elseif id == 8 then
		text = text .. [[
Hello!
		
]]
		text = text .. sender .. " vagyok és lenne egy " .. vehicleName .. " amit fényezni kéne.\n\n"
		text = text .. "Amit biztos festeni kéne, az a " .. parts .. ", a többit rád bízom, mit látsz jónak, a lényeg, hogy a kocsi jól nézzen ki. A színe egyébként " .. colorName .. [[
.
		
]]
		text = text .. "Mennyiért tudnád ezt megcsinálni?\n\n"
		text = text .. "Várom a válaszod!\n\n"
		text = text .. sender
	elseif id == 9 then
		text = text .. [[
Szeva!
		
]]
		text = text .. sender .. " vagyok, spanom adta meg a mailed, állítólag kened vágod ezt a szakmát.\n\n"
		text = text .. "Figyi lenne nekem egy " .. vehicleName .. " amit nagyon szeretnék frankóra megcsináltatni. Az a gáz, hogy nem adta ki múltkor a Venom, aztán most a kasztnis Tibi, tudod a lakatos tőletek nem messze, na az összepakolta, de ilyen gány, bontott cuccokból. Na most az van, hogy egy frankó fényezéssel viszont olyan lenne mint az új, szal le kéne fújni a kicsikét brutál jól. Amit még én is látok, hogy ezek az elemek gázosak: " .. parts .. ". Amúgy a színe az patika mert " .. colorName .. " színre kente le a gyár.\n\n"
		text = text .. "Remélem meg tudod oldani, álmodd meg, hogy mennyi lenne aztán dobj 1 választ az árral.\n\n"
		text = text .. "Kösz! Na Csumi!"
	elseif id == 10 then
		text = text .. "Szép napot!\n\n"
		text = text .. sender .. " vagyok és lenne egy " .. vehicleName .. " amit fényezni kéne.\n\n"
		text = text .. "Az alábbi elemeket kéne festeni: " .. parts .. ".\n A többit Önre bízom, a lényeg, hogy a kocsi jól nézzen ki. A színe egyébként " .. colorName .. " színkódú.\n\n"
		text = text .. "Mennyiért tudná elvállalni?\n\n"
		text = text .. "Köszönettel:\n"
		text = text .. sender
	elseif id == 11 then
		text = text .. "Üdv!\n\n"
		text = text .. "Bocs a tegezésért élből, de így egyszerűbb szerintem.\n\n"
		text = text .. sender .. " vagyok és lenne nekem egy " .. vehicleName .. ", amit mondjuk úgy, hogy nem a megfelelő helyen javíttattam a múltban és elég rosszul néz ki. Másoktól azt hallottam, hogy ez a műhely rendben van, így ajánlatot kérnék tőled. Fújni kéne " .. colorName .. " színben ezeket az elemeket: " .. parts .. [[
		
		
]]
		text = text .. "Erre tudsz nekem egy árat írni? Köszi előre is!"
	elseif id == 12 then
		text = text .. [[
Szia!
		
]]
		text = text .. sender .. " vagyok. " .. ref .. " adta meg az elérhetőséged.\n\n"
		text = text .. "Az van, hogy volt egy biztosítós ügy, nekem jöttek két hete és most tartunk ott, hogy felajánlott nekem egy összeget a biztosító, ha én javíttatom a kocsit. A karosszéria igazából már kész van, már 'csak' festeni kéne. Az autó egy " .. vehicleName .. ", a színe pedig " .. colorName .. ". Amit fújni kéne az pedig: " .. parts .. [[
.
		
]]
		text = text .. "Így előreláthatólag mennyi lenne a festése az autónak?\n\n"
		text = text .. "Előre is köszi az ajánlatot!\n\n"
		text = text .. "Szép napot!"
	elseif id == 13 then
		text = text .. "Üdv!\n\n"
		text = text .. "A nevem " .. sender .. ". " .. ref .. " adta az elérésed, mármint ezt az email címet, hogy itt keresselek fel.\n\n"
		text = text .. "Van egy " .. vehicleName .. " autóm, amit sajnos pár hete sikeresen összetörtem. Egy vad kiugrott elém. Az autón a karosszéria javítás megtörtént, de a festést csak horror összegért vállalják, így úgy gondoltam keresek egy jó fényezőt. Így jutottam hozzád. Szeretnék ajánlatot kérni tőled a következő elemek fújására: " .. parts .. ". Az autó színe pontosan: " .. colorName .. [[
.
		
]]
		text = text .. "Mennyiért tudnád vállalni az autót? Válaszlevélben írd meg.\n\nFelőlem akár már ma viheted is az autót, hisz sürgős lenne.\n\n"
		text = text .. "Előre is köszönöm!"
	elseif id == 14 then
		text = text .. "Cső! " .. sender .. " vagyok biztos láttál má.\n\n"
		text = text .. "Figyejjé má, nem vágom ezt az emélt meg ilyenek, de mondta a tesó, hogy itt lehet tégedet elérni. Na hozattam a németbő egy kocsit, full-fullos. De tényleg. A kasztni az nem full, átcsesztek vágod?! Meglett patikára csináltatva minedenjó csak a szín nem jó. Az nagyon nem jó. Mennyié fújod le nekem ezt a full fullos " .. vehicleName .. " kocsim??? Am a plakett szerint a színkódja " .. colorName .. ". Ezek vannak oda rajta:  " .. parts .. [[
		
		
]]
		text = text .. "Mennyi a matek??? Mondj egy számot!"
	end
	return text
end
function getOfferPlayerReply(id, shopName, sender, price, rnd1, rnd2)
	local text = ""
	price = math.floor(price)
	text = text .. "Szép napot!\n\n"
	text = text .. "Köszönöm "
	if rnd1 == 1 then
		text = text .. "a megkeresést"
	elseif rnd1 == 2 then
		text = text .. "az érdeklődést"
	elseif rnd1 == 3 then
		text = text .. "az ajánlatkérést"
	end
	text = text .. ". Az autó fényezése összesen " .. sightexports.sGui:thousandsStepper(price) .. " $ lenne, mely tartalmazza az anyagköltséget, munkadíjat és az autó szállítását is.\n\n"
	text = text .. "Várom mielőbbi "
	if id <= 5 or id == 10 then
		if rnd2 == 1 then
			text = text .. "válaszát"
		elseif rnd2 == 2 then
			text = text .. "üzenetét"
		elseif rnd2 == 3 then
			text = text .. "jelentkezését"
		elseif rnd2 == 4 then
			text = text .. "visszajelzését"
		end
	elseif rnd2 == 1 then
		text = text .. "válaszod"
	elseif rnd2 == 2 then
		text = text .. "üzeneted"
	elseif rnd2 == 3 then
		text = text .. "jelentkezésed"
	elseif rnd2 == 4 then
		text = text .. "visszajelzésed"
	end
	text = text .. [[
!
	
]]
	text = text .. "Tisztelettel:\n"
	text = text .. shopName
	return text
end
function getOfferReply(id, rnd, result, vehicle, color, parts, price, playerPrice, shopName, sender)
	local text = ""
	price = math.floor(price)
	if id <= 3 or id == 10 then
		text = text .. "Tisztelt " .. shopName .. [[
!
		
]]
		if result == "timeout" then
			if rnd == 1 then
				text = text .. "Ajánlatkérésemet kérem vegye időközben tárgytalannak, már máshol kaptam egy jó ajánlatot. Tudja, az idő fontos számomra."
			elseif rnd == 2 then
				text = text .. "Sajnos nem tudok tovább várni az ajánlatára, kérem tekintse [levelem, érdeklődésem, ajánlatkérésem] tárgytalannak."
			elseif rnd == 3 then
				text = text .. "Ne haragudjon, de ennél kicsit gyorsabb reakciót várok az üzleti életben, kértem máshol ajánlatot, amire már választ is kaptam. Talán legközelebb."
			elseif rnd == 4 then
				text = text .. "Ha ennyi időt kell várnom az ajánlatra, vajon mennyi idő alatt készülne el az autóm?!\n"
				text = text .. "Tekintse tárgytalannak az ajánlatkérésem."
			end
		elseif result then
			if rnd == 1 then
				text = text .. "Köszönöm, az ajánlatát elfogadom."
			elseif rnd == 2 then
				text = text .. "Korrekt ajánlat, elfogadom."
			elseif rnd == 3 then
				text = text .. "Rendben van az ajánlat, elfogadom."
			elseif rnd == 4 then
				text = text .. "Tisztességes ajánlat, megegyeztünk. Hogyan tovább?"
			end
		elseif rnd == 1 then
			text = text .. "Köszönöm, azonban ez az ajánlat túl drága lenne számomra jelenleg. Talán majd máshol sikerrel járok."
		elseif rnd == 2 then
			text = text .. "Köszönöm, azonban máshol olcsóbban meg tudják csinálni az autóm."
		elseif rnd == 3 then
			text = text .. "Megkaptam az ajánlatát, azonban nem tudom elfogadni. Máshol jobb ajánlatot kaptam."
		elseif rnd == 4 then
			text = text .. "Erősen túlzónak tartom az ajánlatát, nem tudom ezt elfogadni, máshol kérek ajánlatot!"
		end
		text = text .. [[
		
		
]]
		text = text .. "Tisztelettel:\n"
		text = text .. sender
	elseif id == 4 or id == 5 then
		text = text .. "Tisztelt " .. shopName .. [[
!
		
]]
		if result == "timeout" then
			if rnd == 1 then
				text = text .. "Cégünk ajánlatkérését vegye időközben tárgytalannak, már máshol kaptunk egy számunkra kedvező ajánlatot. Tudja, az idő fontos számunkra."
			elseif rnd == 2 then
				text = text .. "Sajnos nem tudunk tovább várni az ajánlatára, kérem tekintse érdeklődésünk tárgytalannak."
			elseif rnd == 3 then
				text = text .. "Ne haragudjon, de ennél kicsit gyorsabb reakciót várunk az üzleti életben, cégünk kért máshol ajánlatot, amire már választ is kaptunk. Talán legközelebb."
			elseif rnd == 4 then
				text = text .. "Ha ennyi időt kell várnunk egy ajánlatra, vajon mennyi idő alatt készülne el a jármű?!\n\nTekintse tárgytalannak az ajánlatkérésünk."
			end
		elseif result then
			if rnd == 1 then
				text = text .. "Köszönjük, az ajánlatát cégünk elfogadja."
			elseif rnd == 2 then
				text = text .. "Korrekt ajánlat, elfogadjuk."
			elseif rnd == 3 then
				text = text .. "Rendben van az ajánlat, cégünk számára kedvező, így elfogadjuk."
			elseif rnd == 4 then
				text = text .. "Tisztességes ajánlatot kaptunk, megegyeztünk. Hogyan tovább?"
			end
		elseif rnd == 1 then
			text = text .. "Köszönjük, azonban ez az ajánlat cégünk részére jelenleg túl költséges lenne. Ezesetben mástól kérünk ajánlatot."
		elseif rnd == 2 then
			text = text .. "Köszönjük, azonban máshol kedvezőbb áron meg tudják csinálni ugyanezt a munkát."
		elseif rnd == 3 then
			text = text .. "Megkaptuk az ajánlatát, azonban nem tudja cégünk elfogadni. Máshol jobb ajánlatot kaptunk."
		elseif rnd == 4 then
			text = text .. "Erősen túlzónak tartjuk az ajánlatát, nem tudjuk ezt elfogadni, máshol kérünk ajánlatot!"
		end
		text = text .. [[
		
		
]]
		text = text .. "Tisztelettel:\n"
		text = text .. sender
	elseif id == 9 or id == 14 then
		if result == "timeout" then
			if rnd == 1 then
				text = text .. "Na szeva!\n\nFigyi vedd úgy, hogy nem írtam semmit, ennyit semmire nem várok, mint rád!"
			elseif rnd == 2 then
				text = text .. "Hi!\n\nNa? Válasz luxus, vagy mivan? Tudod mit?! Ne is válaszolj, nem veled csináltatom!"
			elseif rnd == 3 then
				text = text .. "Cső!\n\nAz komoly, hogy mennyi idő kell neked arra, hogy válaszolj\226\128\166 Ne is írj már, megcsinálja más!"
			elseif rnd == 4 then
				text = text .. "Csá!\n\nBiztos nagyba vagy má\226\128\153 ha nem is válaszolsz! Felejtsük el, nem csináltatok veled semmit!"
			end
		elseif result then
			if rnd == 1 then
				text = text .. "Cső!\n\nNagy király vagy, frankó az ár, mikor jössz a kocsiért?"
			elseif rnd == 2 then
				text = text .. "Szeva!\n\nEz a beszéd, korrekt a matek! Ma már jössz is érte?"
			elseif rnd == 3 then
				text = text .. "Hi!\n\nTökély. Azt hittem aranyárban dolgozol te is\226\128\166 Mikor ugrasz be a verdáért?"
			elseif rnd == 4 then
				text = text .. "Na csá!\n\nPatika! El van fogadva, mikor tudsz nekiugrani?"
			end
		elseif rnd == 1 then
			text = text .. "Mennyi??!! Há más ezért nekem 3 kocsit megcsinál! Biztos, hogy nem!\n\nNa csá!"
		elseif rnd == 2 then
			text = text .. "Huzatot kaptál báttya?! Ennyiből másik kocsit veszek! Felejtsd el!"
		elseif rnd == 3 then
			text = text .. "Ki akarsz rabolni, vagy mi van veled?! Ne nézz madárnak, nincs üzlet!"
		elseif rnd == 4 then
			text = text .. "Tesó! Nem azt mondtam, hogy aranyat fújj rá!!! Felejtsük el!"
		end
	elseif result == "timeout" then
		if rnd == 1 then
			text = text .. "Szia!\n\nKöszi de nem is kell ajánlatot adnod már. Légyszíves az ajánlatkérésem tekintsd semmisnek, időközben más elvállalta a munkát..."
		elseif rnd == 2 then
			text = text .. "Hello!\n\nNe haragudj de nem tudok ennyit várni a válaszodra, tekints az ajánlat kérésem tárgytalannak.\n\nÜdvözlettel:\n" .. sender
		elseif rnd == 3 then
			text = text .. "Hello!\n\nNem tudom mikor terveztél végül ajánlatot adni, de csak szólok, hogy már nem is kell, elvállalta más az autót, sürgős volt nekem is."
		elseif rnd == 4 then
			text = text .. "Üdv.\n\nHa ennyi ideig tart egy árajánlat, vajon az autóm meddig állna nálad?! Felejtsük el, tekintsd semmisnek a korábbi ajánlatkérésem. Más biztos hamarabb ad ajánlatot erre..."
		end
	elseif result then
		if rnd == 1 then
			text = text .. "Hello!\n\nKöszi az ajánlatot, szerintem rendben van, elfogadom.\n\nÜdvözlettel:\n" .. sender
		elseif rnd == 2 then
			text = text .. "Szia!\n\nNagyon köszönöm, tetszik az ajánlat, szóval el is fogadom akkor.\n\nÜdvözlettel:\n" .. sender
		elseif rnd == 3 then
			text = text .. "Szia!\n\nNa ez egy jó ajánlat, többre számítottam, mikor tudjuk akkor kezdeni?\n\nVárom válaszod:\n" .. sender
		elseif rnd == 4 then
			text = text .. "Üdv.\n\nNa ez egy korrekt ajánlat, el is fogadom, köszönöm szépen!\n\nÜdvözlettel:\n" .. sender
		end
	elseif rnd == 1 then
		text = text .. "Üdv!\n\nKöszi az ajánlatot, de nem tudom elfogadni, nincs ennyi pénzem most.\n\nÜdvözlettel:\n" .. sender
	elseif rnd == 2 then
		text = text .. "Hello!\n\nHát őszintén szólva ennél olcsóbbra számítottam, bocsi de ezt most inkább nem fogadnám el. Azért köszönöm a választ.\n\nÜdvözlettel:" .. sender
	elseif rnd == 3 then
		text = text .. "Jézus! Nem számítottam ilyen nagy összegre, akkor ez tárgytalan, azért köszi. Kérek mástól ajánlatot."
	elseif rnd == 4 then
		text = text .. "Már ne is haragudj de máshol ennek a töredékéért vállalják, nem kérem, köszi. Iszonyatosan túl van árazva a munkád!"
	end
	text = text .. [[
	
	
----
	
]]
	text = text .. "Gépjármű típusa: " .. vehicle .. "\n"
	text = text .. "Gépjármű színkódja: " .. color .. "\n"
	if playerPrice then
		text = text .. "Munkadíj: " .. sightexports.sGui:thousandsStepper(math.floor(price * offerPrices[playerPrice][2])) .. " $\n"
	end
	text = text .. "Sérült elemek: " .. parts .. "\n"
	return text
end
function getOfferStartTimeoutReply(id, rnd, shopName, sender)
	local text = ""
	if id <= 3 or id == 10 then
		text = text .. "Tisztelt " .. shopName .. [[
!
		
]]
		if rnd == 1 then
			text = text .. "Sajnálattal látom, hogy, bár az ajánlatát elfogadtam, mégsem jelentkezett felém, hogy mikor állna neki, így sajnos nem tudok tovább várni. A munkát vegye tárgytalannak."
		elseif rnd == 2 then
			text = text .. "Ezúton értesíteném, hogy az előző beszélgetésünket tekintse semmisnek, hisz rengeteg idő telt el és még mindig nem kaptam érdemi választ a munka megkezdéséről."
		elseif rnd == 3 then
			text = text .. "Csak azért üzennék, hogy meggondoltam magam, mivel eddig nem jelentkezett, mással csináltatom meg a gépjárművet."
		elseif rnd == 4 then
			text = text .. "Kérem tekintse a korábbi beszélgetésünk semmisnek, ugyanis, míg Ön nem válaszolt semmit az üzletkötésünk óta, más műhely elvállalta még jobb feltételekkel a munkát, valamint a járművet már el is szállította."
		end
		text = text .. [[
		
		
]]
		text = text .. "Tisztelettel:\n"
		text = text .. sender
	elseif id == 4 or id == 5 then
		text = text .. "Tisztelt " .. shopName .. [[
!
		
]]
		text = text .. "Sajnos nem tudunk tovább várni az munkálatok megkezdésére, kérem tekintse "
		if rnd <= 2 then
			text = "megegyezésünket"
		elseif rnd <= 4 then
			text = "szerződésünket"
		end
		text = text .. " tárgytalannak.\n\n"
		text = text .. "Tisztelettel:\n"
		text = text .. sender
	elseif id == 9 or id == 14 then
		if rnd == 1 then
			text = text .. "Szeva!\n\nAz komoly, hogy rá is bólintok az, amúgy nem túl olcsó pénzé\226\128\153 a munkádra, azt nem is írsz vissza. Tárgytalan már az egész!"
		elseif rnd == 2 then
			text = text .. "Cső!\n\nNa azé\226\128\153 írok mert én nem várok rád tovább, vedd úgy, hogy nem írtam semmit! Cső!"
		elseif rnd == 3 then
			text = text .. "Csá!\n\nNos?! Na?! Figyi\226\128\166 Én értem, hogy k*rva elfoglalt vagy, de azért van egy határ\226\128\166 Felejtsd el, más megcsinálja, ja és olcsóbbé!!!"
		elseif rnd == 4 then
			text = text .. "Hi!\n\nMinek adsz ajánlatot ha utána lesz*rod az embert?! Cimbora megcsinálja inkább, az legalább dolgozni is akar!!!\n\nNincs üzlet!"
		end
	elseif rnd == 1 then
		text = text .. "Szia!\n\nA korábbi beszélgetésünk légyszíves tekintsd semmisnek, időközben más elvállalta a munkát..."
	elseif rnd == 2 then
		text = text .. "Hello!\n\nNe haragudj de nem tudok ennyit várni arra, hogy elvidd a kocsit, tekintsd korábbi válaszom tárgytalannak."
	elseif rnd == 3 then
		text = text .. "Szia!\n\nNem tudom mikor terveztél nekiállni, de csak szólok, hogy már nem kell, elvállalta más az autót, sürgős volt nekem is."
	elseif rnd == 4 then
		text = text .. "Üdv.\n\nHa ennyi ideig tart hogy idegyere a kocsiért, vajon az autóm meddig állna nálad?! Felejtsük el, tekintsd semmisnek a korábbi beszélgetésünk. Más biztos hamarabb reagál."
	end
	return text
end
function convertPlate(n)
	n = tostring(tonumber(n) or 1)
	for i = utf8.len(n) + 1, 6 do
		n = "0" .. n
	end
	return "P-" .. n
end
function getEmailTime(data)
	local time = data.emailTime or getRealTimestamp()
	if data.playerReplyTime then
		time = math.max(time, data.playerReplyTime)
	end
	if data.offerReplyTime then
		time = math.max(time, data.offerReplyTime)
	end
	if data.offerStartTimeoutTime then
		time = math.max(time, data.offerStartTimeoutTime)
	end
	if data.jobStartTime then
		time = math.max(time, data.jobStartTime)
	end
	return time
end
jobRatingTexts = {
	{
		"Nem vagyok elégedett!",
		0,
		1
	},
	{
		"Minőségben nem megfelelő!",
		0,
		1
	},
	{
		"Vihetem újra fényezőhöz, abszolút nem ajánlott!",
		0,
		1
	},
	{
		"Nem ajánlom senkinek, rossz minőségű munka",
		0,
		1.5
	},
	{
		"Kritikán aluli.",
		0,
		1.5
	},
	{
		"Sokkal jobbra számítottam őszintén szólva.",
		1.5,
		2.5
	},
	{
		"Meg lett csinálva, de legközelebb nem ide viszem!",
		1.5,
		2.5
	},
	{
		"Sok hibával kaptam vissza az autót.",
		1.5,
		2.5
	},
	{
		"A festés több mint hanyag!",
		1.5,
		2.5
	},
	{
		"Azt hittem jobb lesz a végeredmény.",
		1.5,
		2.5
	},
	{
		"Nem rossz, de a jó nem ilyen\226\128\166",
		2.5,
		3.6
	},
	{
		"Elmegy kategória, máshol jobb minőséget kaptam.",
		2.5,
		3.6
	},
	{
		"Végülis meg lett csinálva az autó, de messze nem a legjobb minőség.",
		2.5,
		3.6
	},
	{
		"Lehetett volna szerintem jobb is, de nem lett rossz.",
		2.5,
		3.8
	},
	{
		"Több hibát is észrevettem, de összességében egész jó lett a minősége.",
		2.75,
		3.6
	},
	{
		"Rendben volt, kisebb hibákat leszámítva jó lett.",
		3.6,
		4.5
	},
	{
		"Összességében elégedett vagyok, majdnem tökéletes minden. Ajánlom másnak is.",
		3.6,
		4.5
	},
	{
		"Abszolút ajánlom másnak is, mintha kis hiba lenne a festésben, de teljesen rendben van.",
		3.6,
		4.5
	},
	{
		"Teljesen rendben volt, kicsi precizitás még és azt fogom mondani, hogy tökéletes, másnak is ajánlom bátran!",
		3.6,
		4.5
	},
	{
		"Fantasztikus munka, köszönöm!",
		4.5,
		5
	},
	{
		"Szuper munka, erősen ajánlott mindenkinek, akinek profi fényező kell!",
		4.5,
		5
	},
	{
		"Másnak is ajánlani fogom, tökéletes autót kaptam vissza!",
		5,
		5
	},
	{
		"Ha lehetne, 10 csillagot adnék, de ez a maximum, nyugodt szívvel ajánlom bárkinek, tökéletes munka!",
		5,
		5
	},
	{
		"Elképesztően szép lett az autó, nem kérdés, hogy 5 csillag!",
		5,
		5
	},
	--// Visszamondások.
	{
		"Megbeszéltünk mindent, aztán hirtelen mégis visszamondta! ",
		0,
		5,
		true
	},
	{
		"Nem ajánlott, komolytalan!",
		0,
		5,
		true
	},
	{
		"Minden meg lett beszélve, majd egy üzenetet küldött, hogy mégsem vállalja!",
		0,
		5,
		true
	},
	{
		"Messziről kerülendő, nem is értem, hogy van bármilyen munkája!",
		0,
		5,
		true
	},
	{
		"Nem korrekt, miután elvállalta és megtörtént a megegyezés, egyszer csak visszamondta!",
		0,
		5,
		true
	}
}
firstNames = {
	"Frank",
	"Mark",
	"Pedro",
	"Kate",
	"Claude",
	"Floyd",
	"Colleen",
	"Kari",
	"Neal",
	"Margie",
	"Harold",
	"Leo",
	"Charlie",
	"Mike",
	"Daisy",
	"Rick",
	"Maggie",
	"Jacquelyn",
	"Juan",
	"Celia",
	"Penny",
	"Brenda",
	"Robert",
	"Katherine",
	"Lyle",
	"Jeanette",
	"Jessie",
	"Laurence",
	"Kristen",
	"Steve",
	"Peggy",
	"Guy",
	"Timmy",
	"Chester",
	"Alfred",
	"Benjamin",
	"William",
	"Ernest",
	"Sidney",
	"Byron",
	"Carol",
	"Elisa",
	"Roberto",
	"Alvin",
	"Adrian",
	"Jessie",
	"Stanley",
	"Joey",
	"Stewart",
	"Zachary",
	"Pearl",
	"Don",
	"Colin",
	"Derek",
	"Darrel",
	"Edith",
	"Tami",
	"Dwight",
	"Ernestine",
	"Randolph",
	"Anita",
	"Jamie",
	"Victor",
	"Erica",
	"Owen",
	"Tanya",
	"Matthew",
	"Salvatore",
	"Jean",
	"Ronald",
	"Cody",
	"Regina",
	"Wilbert",
	"Julian",
	"Johnathan",
	"Emanuel",
	"Salvador",
	"Oscar",
	"Morris",
	"Wallace",
	"Leona",
	"Curtis",
	"Kellie",
	"Ted",
	"Jessica",
	"Jodi",
	"Harry",
	"Alexandra",
	"April",
	"Melinda",
	"Leticia",
	"Dale",
	"Lynda",
	"Sally",
	"Patricia",
	"Todd",
	"Brooke",
	"Sheldon",
	"Claudia",
	"Chris"
}
lastNames = {
	"Owen",
	"Bowman",
	"James",
	"Dunn",
	"Hale",
	"Sanchez",
	"Harris",
	"Morrison",
	"Massey",
	"Allison",
	"Curry",
	"Delgado",
	"Owens",
	"Howard",
	"Wood",
	"Webb",
	"Castillo",
	"Jennings",
	"Cummings",
	"Hammond",
	"Brown",
	"Byrd",
	"Mckinney",
	"Lane",
	"Rodriquez",
	"Nash",
	"Dennis",
	"Tucker",
	"Mckenzie",
	"Kelley",
	"Gross",
	"Porter",
	"Mccarthy",
	"Wilkins",
	"Stevens",
	"Conner",
	"Simmons",
	"Farmer",
	"Gutierrez",
	"Fuller",
	"Fisher",
	"Ward",
	"Ferguson",
	"Cunningham",
	"Franklin",
	"Holmes",
	"Hopkins",
	"Henderson",
	"Diaz",
	"Lucas",
	"Frank",
	"Swanson",
	"Parker",
	"Cobb",
	"Richardson",
	"Horton",
	"Carpenter",
	"Harmon",
	"Long",
	"Newman",
	"Bryant",
	"Daniel",
	"Larson",
	"Bush",
	"Warren",
	"Ortega",
	"Hunter",
	"Lee",
	"Douglas",
	"Hudson",
	"Turner",
	"Santos",
	"Robbins",
	"Simon",
	"Beck",
	"Bryan",
	"Haynes",
	"Welch",
	"Barton",
	"Murray",
	"Boyd",
	"Fleming",
	"Stephens",
	"Gray",
	"Clark",
	"Frazier",
	"Coleman",
	"Dean",
	"Malone",
	"Price",
	"Maldonado",
	"Holland",
	"Thomas",
	"Tran",
	"Lowe",
	"Ball",
	"Day",
	"Chavez",
	"Lopez",
	"Morales"
}
companies = {
	"Like New Car Kft.",
	"Bokszi Autó Bt.",
	"Ott-Autó Kft.",
	"SEE THE SAFE Biztosító Zrt.",
	"Kár-Öltés Biztosítási Kft.",
	"Generális Csoport Biztosító Kft."
}
function getEmailName(sender)
	if tonumber(sender) then
		return companies[sender]
	else
		return firstNames[sender[1]] .. " " .. lastNames[sender[2]]
	end
end

function isLeapYear(year)
	if year then year = math.floor(year)
	else year = getRealTime().year + 1900 end
	return ((year % 4 == 0 and year % 100 ~= 0) or year % 400 == 0)
end

function getRealTimestamp(year, month, day, hour, minute, second)
	local monthseconds = { 2678400, 2419200, 2678400, 2592000, 2678400, 2592000, 2678400, 2678400, 2592000, 2678400, 2592000, 2678400 }
	local timestamp = 0
	local datetime = getRealTime()
	year, month, day = year or datetime.year + 1900, month or datetime.month + 1, day or datetime.monthday
	hour, minute, second = hour or datetime.hour, minute or datetime.minute, second or datetime.second
	
	for i=1970, year-1 do timestamp = timestamp + (isLeapYear(i) and 31622400 or 31536000) end
	for i=1, month-1 do timestamp = timestamp + ((isLeapYear(year) and i == 2) and 2505600 or monthseconds[i]) end
	timestamp = timestamp + 86400 * (day - 1) + 3600 * hour + 60 * minute + second
	
	timestamp = timestamp - 3600
	if datetime.isdst then timestamp = timestamp - 3600 end
	
	return timestamp
end
possiblePoints = {
  [1] = {
    amount = 800,
    price = 900
  },
  [2] = {
    amount = 1800,
    price = 1500
  },
  [3] = {
    amount = 3000,
    price = 2300
  },
  [4] = {
    amount = 4200,
    price = 3000
  },
  [5] = {
    amount = 6200,
    price = 4800
  }
}
possibleUpgrades = {
  [1] = {
    label = "Particle csökkentése",
    description = "Tisztább festési és csiszolási felület.",
    levelAmount = {5, 10, 15, 25, 50},
    levelPrice = {1800, 2400, 3500, 4800, 6400}
  },
  [2] = {
    label = "Száradási idő csökkentése",
    description = "Gyorsabban szárad a festék.",
    levelAmount = {5, 10, 15, 20, 25},
    levelPrice = {800, 2000, 3400, 4100, 4700}
  },
  [3] = {
    label = "Alapozó használat csökkentése",
    description = "Kevesebb alapozó szükséges festéshez.",
    levelAmount = {5, 10, 15, 20, 25},
    levelPrice = {1000, 2100, 2900, 4100, 6500}
  },
  [4] = {
    label = "Festék használat csökkentése",
    description = "Kevesebb festékkel teljes fedés.",
    levelAmount = {5, 10, 15, 20, 25},
    levelPrice = {1000, 2000, 2500, 3500, 4000}
  },
  [5] = {
    label = "Csiszoló felület növelése",
    description = "Nagyobb csiszolási felület.",
    levelAmount = {5, 15, 25, 50, 75},
    levelPrice = {1000, 2500, 3700, 7100, 12000}
  },
  [6] = {
    label = "Alapozó és fényező felület növelése",
    description = "Nagyobb hatósugár az eszközöknek.",
    levelAmount = {5, 15, 25, 50, 75},
    levelPrice = {1000, 2400, 3300, 6000, 9000}
  }
}