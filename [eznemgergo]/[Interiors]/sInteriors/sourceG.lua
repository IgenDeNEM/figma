local sightexports = {sGui = false, sGroups = false}
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
transferSpeed = 250000
gameInteriors = {
  e = {
    interior = 1,
    name = "Szerkeszthető",
    position = {37.9, 2034.5, 50},
    rotation = 0,
  },
  [1] = {
    name = "Ammo nation 1",
    position = {
      285.8505859375,
      -41.099609375,
      1001.515625
    },
    rotation = 0,
    interior = 1,
    object = false,
    safe = false
  },
  [2] = {
    name = "Burglary House 1",
    position = {
      223.125,
      1287.0751953125,
      1082.140625
    },
    rotation = 0,
    interior = 1,
    object = false,
    safe = false
  },
  [3] = {
    name = "The Wellcome Pump (Catalina)",
    position = {
      681.5654296875,
      -446.388671875,
      -25.609762191772
    },
    rotation = 0,
    interior = 1,
    object = false,
    safe = false
  },
  [4] = {
    name = "Restaurant 1",
    position = {
      455.2529296875,
      -22.484375,
      999.9296875
    },
    rotation = 0,
    interior = 1,
    object = false,
    safe = false
  },
  [5] = {
    name = "Caligulas Casino",
    position = {
      2233.9345703125,
      1714.6845703125,
      1012.3828125
    },
    rotation = 0,
    interior = 1,
    object = false,
    safe = false
  },
  [6] = {
    name = "Denise's Place",
    position = {
      244.0892,
      304.8456,
      999.1484
    },
    rotation = 0,
    interior = 1,
    object = false,
    safe = false
  },
  [7] = {
    name = "Shamal cabin",
    position = {
      3.0205078125,
      33.20703125,
      1199.59375
    },
    rotation = 0,
    interior = 1,
    object = false,
    safe = false
  },
  [8] = {
    name = "Sweet's House",
    position = {
      2525.042,
      -1679.115,
      1015.499
    },
    rotation = 0,
    interior = 1,
    object = false,
    safe = false
  },
  [9] = {
    name = "Transfender",
    position = {
      627.302734375,
      -12.056640625,
      1000.921875
    },
    rotation = 0,
    interior = 1,
    object = false,
    safe = false
  },
  [10] = {
    name = "Safe House 4",
    position = {
      2216.54,
      -1076.29,
      1050.484
    },
    rotation = 0,
    interior = 1,
    object = false,
    safe = false
  },
  [11] = {
    name = "Trials Stadium",
    position = {
      -1401.13,
      106.11,
      1032.273
    },
    rotation = 0,
    interior = 1,
    object = false,
    safe = false
  },
  [12] = {
    name = "Warehouse 1",
    position = {
      1403.1142578125,
      -0.267578125,
      1000.9110717773
    },
    rotation = 0,
    interior = 1,
    object = false,
    safe = false
  },
  [13] = {
    name = "Doherty Garage",
    position = {
      -2042.42,
      178.59,
      28.84
    },
    rotation = 0,
    interior = 1,
    object = false,
    safe = false
  },
  [14] = {
    name = "Sindacco Abatoir",
    position = {
      963.6078,
      2108.397,
      1011.03
    },
    rotation = 0,
    interior = 1,
    object = false,
    safe = false
  },
  [15] = {
    name = "Sub Urban",
    position = {
      203.6484375,
      -50.6640625,
      1001.8046875
    },
    rotation = 0,
    interior = 1,
    object = false,
    safe = false
  },
  [16] = {
    name = "Wu Zi Mu's Betting place",
    position = {
      -2159.926,
      641.4587,
      1052.382
    },
    rotation = 0,
    interior = 1,
    object = false,
    safe = false
  },
  [17] = {
    name = "Ryder's House",
    position = {
      2468.8427734375,
      -1698.2109375,
      1013.5078125
    },
    rotation = 0,
    interior = 2,
    object = false,
    safe = false
  },
  [18] = {
    name = "Angel Pine Trailer",
    position = {
      2.0595703125,
      -3.0146484375,
      999.42840576172
    },
    rotation = 0,
    interior = 2,
    object = false,
    safe = false
  },
  [19] = {
    name = "The Pig Pen",
    position = {
      1204.748046875,
      -13.8515625,
      1000.921875
    },
    rotation = 0,
    interior = 2,
    object = false,
    safe = false
  },
  [20] = {
    name = "BDups Crack Palace",
    position = {
      1523.751,
      -46.0458,
      1002.131
    },
    rotation = 0,
    interior = 2,
    object = false,
    safe = false
  },
  [21] = {
    name = "Big Smoke's Crack Palace",
    position = {
      2541.5400390625,
      -1303.8642578125,
      1025.0703125
    },
    rotation = 0,
    interior = 2,
    object = false,
    safe = false
  },
  [22] = {
    name = "Burglary House 2",
    position = {
      225.756,
      1240,
      1082.149
    },
    rotation = 0,
    interior = 2,
    object = false,
    safe = false
  },
  [23] = {
    name = "Burglary House 3",
    position = {
      447.47,
      1398.348,
      1084.305
    },
    rotation = 0,
    interior = 2,
    object = false,
    safe = false
  },
  [24] = {
    name = "Burglary House 4",
    position = {
      491.33203125,
      1398.4990234375,
      1080.2578125
    },
    rotation = 0,
    interior = 2,
    object = false,
    safe = false
  },
  [25] = {
    name = "Katie's Place",
    position = {
      267.229,
      304.71,
      999.148
    },
    rotation = 0,
    interior = 2,
    object = false,
    safe = false
  },
  [26] = {
    name = "Loco Low Co.",
    position = {
      612.591,
      -75.637,
      997.992
    },
    rotation = 0,
    interior = 2,
    object = false,
    safe = false
  },
  [27] = {
    name = "Reece's Barbershop",
    position = {
      612.591,
      -75.637,
      997.992
    },
    rotation = 0,
    interior = 2,
    object = false,
    safe = false
  },
  [28] = {
    name = "Jizzy's Pleasure Domes",
    position = {
      -2636.719,
      1402.917,
      906.4609
    },
    rotation = 0,
    interior = 3,
    object = false,
    safe = false
  },
  [29] = {
    name = "Brothel",
    position = {
      620.197265625,
      -70.900390625,
      997.9921875
    },
    rotation = 0,
    interior = 3,
    object = false,
    safe = false
  },
  [30] = {
    name = "Brothel 2",
    position = {
      967.5334,
      -53.0245,
      1001.125
    },
    rotation = 0,
    interior = 3,
    object = false,
    safe = false
  },
  [31] = {
    name = "BDups Apartment",
    position = {
      1525.6337890625,
      -11.015625,
      1002.0971069336
    },
    rotation = 0,
    interior = 3,
    object = false,
    safe = false
  },
  [32] = {
    name = "Bike School",
    position = {
      1494.390625,
      1303.5791015625,
      1093.2890625
    },
    rotation = 0,
    interior = 3,
    object = false,
    safe = false
  },
  [33] = {
    name = "Big Spread Ranch",
    position = {
      1212.0166015625,
      -25.875,
      1000.953125
    },
    rotation = 0,
    interior = 3,
    object = false,
    safe = false
  },
  [34] = {
    name = "LV Tattoo Parlour",
    position = {
      -204.439,
      -43.652,
      1002.299
    },
    rotation = 0,
    interior = 3,
    object = false,
    safe = false
  },
  [35] = {
    name = "LVPD HQ",
    position = {
      288.8291015625,
      166.921875,
      1007.171875
    },
    rotation = 0,
    interior = 3,
    object = false,
    safe = false
  },
  [36] = {
    name = "OG Loc's House",
    position = {
      516.889,
      -18.412,
      1001.565
    },
    rotation = 0,
    interior = 3,
    object = false,
    safe = false
  },
  [37] = {
    name = "Pro-Laps",
    position = {
      206.9296875,
      -140.375,
      1003.5078125
    },
    rotation = 0,
    interior = 3,
    object = false,
    safe = false
  },
  [38] = {
    name = "Las Venturas Planning Dep.",
    position = {
      390.7685546875,
      173.8505859375,
      1008.3828125
    },
    rotation = 0,
    interior = 3,
    object = false,
    safe = false
  },
  [39] = {
    name = "Record Label Hallway",
    position = {
      1038.219,
      6.9905,
      1001.284
    },
    rotation = 0,
    interior = 3,
    object = false,
    safe = false
  },
  [40] = {
    name = "Driving School",
    position = {
      -2027.92,
      -105.183,
      1035.172
    },
    rotation = 0,
    interior = 3,
    object = false,
    safe = false
  },
  [41] = {
    name = "Johnson House",
    position = {
      2496.0791015625,
      -1692.083984375,
      1014.7421875
    },
    rotation = 0,
    interior = 3,
    object = false,
    safe = false
  },
  [42] = {
    name = "Burglary House 5",
    position = {
      235.2529296875,
      1186.6806640625,
      1080.2578125
    },
    rotation = 0,
    interior = 3,
    object = false,
    safe = false
  },
  [43] = {
    name = "Gay Gordo's Barbershop",
    position = {
      418.662109375,
      -84.3671875,
      1001.8046875
    },
    rotation = 0,
    interior = 3,
    object = false,
    safe = false
  },
  [44] = {
    name = "Helena's Place",
    position = {
      292.4459,
      308.779,
      999.1484
    },
    rotation = 0,
    interior = 3,
    object = false,
    safe = false
  },
  [45] = {
    name = "Inside Track Betting",
    position = {
      834.66796875,
      7.306640625,
      1004.1870117188
    },
    rotation = 0,
    interior = 3,
    object = false,
    safe = false
  },
  [46] = {
    name = "Sex Shop",
    position = {
      -100.314453125,
      -25.0380859375,
      1000.71875
    },
    rotation = 0,
    interior = 3,
    object = false,
    safe = false
  },
  [47] = {
    name = "Wheel Arch Angels",
    position = {
      614.3889,
      -124.0991,
      997.995
    },
    rotation = 0,
    interior = 3,
    object = false,
    safe = false
  },
  [48] = {
    name = "24/7 shop 1",
    position = {
      -27.0751953125,
      -31.7607421875,
      1003.5572509766
    },
    rotation = 0,
    interior = 4,
    object = false,
    safe = false
  },
  [49] = {
    name = "Ammu-Nation 2",
    position = {
      285.6376953125,
      -86.6171875,
      1001.5228881836
    },
    rotation = 0,
    interior = 4,
    object = false,
    safe = false
  },
  [50] = {
    name = "Burglary House 6",
    position = {
      -260.65234375,
      1456.9775390625,
      1084.3671875
    },
    rotation = 0,
    interior = 4,
    object = false,
    safe = false
  },
  [51] = {
    name = "Burglary House 7",
    position = {
      221.7998046875,
      1140.837890625,
      1082.609375
    },
    rotation = 0,
    interior = 4,
    object = false,
    safe = false
  },
  [52] = {
    name = "Burglary House 8",
    position = {
      261.01953125,
      1284.294921875,
      1080.2578125
    },
    rotation = 0,
    interior = 4,
    object = false,
    safe = false
  },
  [53] = {
    name = "Diner 2",
    position = {
      460,
      -88.43,
      999.62
    },
    rotation = 0,
    interior = 4,
    object = false,
    safe = false
  },
  [54] = {
    name = "Dirtbike Stadium",
    position = {
      -1435.869,
      -662.2505,
      1052.465
    },
    rotation = 0,
    interior = 4,
    object = false,
    safe = false
  },
  [55] = {
    name = "Michelle's Place",
    position = {
      302.6404,
      304.8048,
      999.1484
    },
    rotation = 0,
    interior = 4,
    object = false,
    safe = false
  },
  [56] = {
    name = "Madd Dogg's Mansion",
    position = {
      1272.9116,
      -768.9028,
      1090.5097
    },
    rotation = 0,
    interior = 5,
    object = false,
    safe = false
  },
  [57] = {
    name = "Well Stacked Pizza Co.",
    position = {
      372.3212890625,
      -133.27734375,
      1001.4921875
    },
    rotation = 0,
    interior = 5,
    object = false,
    safe = false
  },
  [58] = {
    name = "Victim",
    position = {
      227.5625,
      -7.5419921875,
      1002.2109375
    },
    rotation = 0,
    interior = 5,
    object = false,
    safe = false
  },
  [59] = {
    name = "Burning Desire House",
    position = {
      2351.154,
      -1180.577,
      1027.977
    },
    rotation = 0,
    interior = 5,
    object = false,
    safe = false
  },
  [60] = {
    name = "Burglary House 9",
    position = {
      22.79996,
      1404.642,
      1084.43
    },
    rotation = 0,
    interior = 5,
    object = false,
    safe = false
  },
  [61] = {
    name = "Burglary House 10",
    position = {
      227.0888671875,
      1114.2666015625,
      1080.9969482422
    },
    rotation = 0,
    interior = 5,
    object = false,
    safe = false
  },
  [62] = {
    name = "Burglary House 11",
    position = {
      140.5107421875,
      1365.939453125,
      1083.859375
    },
    rotation = 0,
    interior = 5,
    object = false,
    safe = false
  },
  [63] = {
    name = "The Crack Den",
    position = {
      318.6767578125,
      1115.048828125,
      1083.8828125
    },
    rotation = 0,
    interior = 5,
    object = false,
    safe = false
  },
  [64] = {
    name = "Police Station (Barbara's)",
    position = {
      322.318359375,
      302.396484375,
      999.1484375
    },
    rotation = 0,
    interior = 5,
    object = false,
    safe = false
  },
  [65] = {
    name = "Diner 1",
    position = {
      448.7435,
      -110.0457,
      1000.0772
    },
    rotation = 0,
    interior = 5,
    object = false,
    safe = false
  },
  [66] = {
    name = "Ganton Gym",
    position = {
      772.36328125,
      -5.5146484375,
      1000.7286376953
    },
    rotation = 0,
    interior = 5,
    object = false,
    safe = false
  },
  [67] = {
    name = "Vank Hoff Hotel",
    position = {
      2233.650390625,
      -1114.6142578125,
      1050.8828125
    },
    rotation = 0,
    interior = 5,
    object = false,
    safe = false
  },
  [68] = {
    name = "Ammu-Nation 3",
    position = {
      296.8642578125,
      -112.0703125,
      1001.515625
    },
    rotation = 0,
    interior = 6,
    object = false,
    safe = false
  },
  [69] = {
    name = "Ammu-Nation 4",
    position = {
      316.4541015625,
      -169.509765625,
      999.60101318359
    },
    rotation = 0,
    interior = 6,
    object = false,
    safe = false
  },
  [70] = {
    name = "LSPD HQ",
    position = {
      246.7333984375,
      63.0712890625,
      1003.640625
    },
    rotation = 0,
    interior = 6,
    object = false,
    safe = false
  },
  [71] = {
    name = "Safe House 3",
    position = {
      2333.033,
      -1073.96,
      1049.023
    },
    rotation = 0,
    interior = 6,
    object = false,
    safe = false
  },
  [72] = {
    name = "Safe House 5",
    position = {
      2196.7109375,
      -1204.205078125,
      1049.0234375
    },
    rotation = 0,
    interior = 6,
    object = false,
    safe = false
  },
  [73] = {
    name = "Safe House 6",
    position = {
      2308.6064453125,
      -1212.41796875,
      1049.0234375
    },
    rotation = 0,
    interior = 6,
    object = false,
    safe = false
  },
  [74] = {
    name = "Cobra Marital Arts Gym",
    position = {
      774.056640625,
      -50.0830078125,
      1000.5859375
    },
    rotation = 0,
    interior = 6,
    object = false,
    safe = false
  },
  [75] = {
    name = "24/7 shop 2",
    position = {
      -27.365234375,
      -57.5771484375,
      1003.546875
    },
    rotation = 0,
    interior = 6,
    object = false,
    safe = false
  },
  [76] = {
    name = "Millie's Bedroom",
    position = {
      344.52,
      304.821,
      999.148
    },
    rotation = 0,
    interior = 6,
    object = false,
    safe = false
  },
  [77] = {
    name = "Fanny Batter's Brothel",
    position = {
      744.271,
      1437.253,
      1102.703
    },
    rotation = 0,
    interior = 6,
    object = false,
    safe = false
  },
  [78] = {
    name = "Restaurant 2",
    position = {
      443.981,
      -65.219,
      1050
    },
    rotation = 0,
    interior = 6,
    object = false,
    safe = false
  },
  [79] = {
    name = "Burglary House 15",
    position = {
      234.220703125,
      1064.42578125,
      1084.2111816406
    },
    rotation = 0,
    interior = 6,
    object = false,
    safe = false
  },
  [80] = {
    name = "Burglary House 16",
    position = {
      -68.701171875,
      1351.806640625,
      1080.2109375
    },
    rotation = 0,
    interior = 6,
    object = false,
    safe = false
  },
  [81] = {
    name = "Ammu-Nation 5 (2 Floors)",
    position = {
      315.385,
      -142.242,
      999.601
    },
    rotation = 0,
    interior = 7,
    object = false,
    safe = false
  },
  [82] = {
    name = "8-Track Stadium",
    position = {
      -1417.872,
      -276.426,
      1051.191
    },
    rotation = 0,
    interior = 7,
    object = false,
    safe = false
  },
  [83] = {
    name = "Below the Belt Gym",
    position = {
      773.7890625,
      -78.080078125,
      1000.6616821289
    },
    rotation = 0,
    interior = 7,
    object = false,
    safe = false
  },
  [84] = {
    name = "Colonel Fuhrberger's House",
    position = {
      2807.5234375,
      -1174.1103515625,
      1025.5703125
    },
    rotation = 0,
    interior = 8,
    object = false,
    safe = false
  },
  [85] = {
    name = "Burglary House 22",
    position = {
      -42.49,
      1407.644,
      1084.43
    },
    rotation = 0,
    interior = 8,
    object = false,
    safe = false
  },
  [86] = {
    name = "Unknown safe house",
    position = {
      2255.09375,
      -1140.169921875,
      1050.6328125
    },
    rotation = 0,
    interior = 9,
    object = false,
    safe = false
  },
  [87] = {
    name = "Andromada Cargo hold",
    position = {
      315.48,
      984.13,
      1959.11
    },
    rotation = 0,
    interior = 9,
    object = false,
    safe = false
  },
  [88] = {
    name = "Burglary House 12",
    position = {
      82.8525390625,
      1322.6796875,
      1083.8662109375
    },
    rotation = 0,
    interior = 9,
    object = false,
    safe = false
  },
  [89] = {
    name = "Burglary House 13",
    position = {
      260.642578125,
      1237.58203125,
      1084.2578125
    },
    rotation = 0,
    interior = 9,
    object = false,
    safe = false
  },
  [90] = {
    name = "Cluckin' Bell",
    position = {
      365.67,
      -11.61,
      1000.87
    },
    rotation = 0,
    interior = 9,
    object = false,
    safe = false
  },
  [91] = {
    name = "Four Dragons Casino",
    position = {
      2018.384765625,
      1017.8740234375,
      996.875
    },
    rotation = 0,
    interior = 10,
    object = false,
    safe = false
  },
  [92] = {
    name = "RC Zero's Battlefield",
    position = {
      -1128.666015625,
      1066.4921875,
      1345.7438964844
    },
    rotation = 0,
    interior = 10,
    object = false,
    safe = false
  },
  [93] = {
    name = "Burger Shot",
    position = {
      363.0419921875,
      -74.9619140625,
      1001.5078125
    },
    rotation = 0,
    interior = 10,
    object = false,
    safe = false
  },
  [94] = {
    name = "Burglary House 14",
    position = {
      24.0498046875,
      1340.3623046875,
      1084.375
    },
    rotation = 0,
    interior = 10,
    object = false,
    safe = false
  },
  [95] = {
    name = "Janitor room(Four Dragons Maintenance)",
    position = {
      1891.396,
      1018.126,
      31.882
    },
    rotation = 0,
    interior = 10,
    object = false,
    safe = false
  },
  [96] = {
    name = "Hashbury safe house",
    position = {
      2269.576171875,
      -1210.4306640625,
      1047.5625
    },
    rotation = 0,
    interior = 10,
    object = false,
    safe = false
  },
  [97] = {
    name = "24/7 shop 3",
    position = {
      6.0673828125,
      -30.60546875,
      1003.5494384766
    },
    rotation = 0,
    interior = 10,
    object = false,
    safe = false
  },
  [98] = {
    name = "Abandoned AC Tower",
    position = {
      422.0302734375,
      2536.4365234375,
      10
    },
    rotation = 0,
    interior = 10,
    object = false,
    safe = false
  },
  [99] = {
    name = "SFPD HQ",
    position = {
      246.3916015625,
      108.1259765625,
      1003.21875
    },
    rotation = 0,
    interior = 10,
    object = false,
    safe = false
  },
  [100] = {
    name = "The Four Dragons Office",
    position = {
      2011.603,
      1017.023,
      39.091
    },
    rotation = 0,
    interior = 11,
    object = false,
    safe = false
  },
  [101] = {
    name = "Ten Green Bottles Bar",
    position = {
      501.900390625,
      -67.828125,
      998.7578125
    },
    rotation = 0,
    interior = 11,
    object = false,
    safe = false
  },
  [102] = {
    name = "The Casino",
    position = {
      1133.158203125,
      -15.0625,
      1000.6796875
    },
    rotation = 0,
    interior = 12,
    object = false,
    safe = false
  },
  [103] = {
    name = "Macisla's Barbershop",
    position = {
      411.98046875,
      -53.673828125,
      1001.8984375
    },
    rotation = 0,
    interior = 12,
    object = false,
    safe = false
  },
  [104] = {
    name = "Safe house 7",
    position = {
      2237.297,
      -1077.925,
      1049.023
    },
    rotation = 0,
    interior = 12,
    object = false,
    safe = false
  },
  [105] = {
    name = "Modern safe house",
    position = {
      2324.499,
      -1147.071,
      1050.71
    },
    rotation = 0,
    interior = 12,
    object = false,
    safe = false
  },
  [106] = {
    name = "LS Atrium",
    position = {
      2324.499,
      -1147.071,
      1050.71
    },
    rotation = 0,
    interior = 13,
    object = false,
    safe = false
  },
  [107] = {
    name = "CJ's Garage",
    position = {
      2324.499,
      -1147.071,
      1050.71
    },
    rotation = 0,
    interior = 13,
    object = false,
    safe = false
  },
  [108] = {
    name = "Kickstart Stadium",
    position = {
      -1464.536,
      1557.69,
      1052.531
    },
    rotation = 0,
    interior = 14,
    object = false,
    safe = false
  },
  [109] = {
    name = "Didier Sachs",
    position = {
      204.0888671875,
      -168.1689453125,
      1000.5234375
    },
    rotation = 0,
    interior = 14,
    object = false,
    safe = false
  },
  [110] = {
    name = "Francis Int. Airport (Front ext.)",
    position = {
      -1827.1473,
      7.2074,
      1061.1435
    },
    rotation = 0,
    interior = 14,
    object = false,
    safe = false
  },
  [111] = {
    name = "Francis Int. Airport (Baggage Claim/Ticket Sales)",
    position = {
      -1855.5687,
      41.2631,
      1061.1435
    },
    rotation = 0,
    interior = 14,
    object = false,
    safe = false
  },
  [112] = {
    name = "Wardrobe",
    position = {
      255.719,
      -41.137,
      1002.023
    },
    rotation = 0,
    interior = 14,
    object = false,
    safe = false
  },
  [113] = {
    name = "Binco",
    position = {
      207.543,
      -109.004,
      1005.133
    },
    rotation = 0,
    interior = 15,
    object = false,
    safe = false
  },
  [114] = {
    name = "Blood Bowl Stadium",
    position = {
      -1423.505859375,
      936.16015625,
      1036.4901123047
    },
    rotation = 0,
    interior = 15,
    object = false,
    safe = false
  },
  [115] = {
    name = "Jefferson Motel",
    position = {
      2227.7724609375,
      -1150.2373046875,
      1025.796875
    },
    rotation = 0,
    interior = 15,
    object = false,
    safe = false
  },
  [116] = {
    name = "Burglary House 17",
    position = {
      -284.4794921875,
      1471.185546875,
      1084.375
    },
    rotation = 0,
    interior = 15,
    object = false,
    safe = false
  },
  [117] = {
    name = "Burglary House 18",
    position = {
      327.808,
      1479.74,
      1084.438
    },
    rotation = 0,
    interior = 15,
    object = false,
    safe = false
  },
  [118] = {
    name = "Burglary House 19",
    position = {
      375.572,
      1417.439,
      1081.328
    },
    rotation = 0,
    interior = 15,
    object = false,
    safe = false
  },
  [119] = {
    name = "Burglary House 20",
    position = {
      384.644,
      1471.479,
      1080.195
    },
    rotation = 0,
    interior = 15,
    object = false,
    safe = false
  },
  [120] = {
    name = "Burglary House 21",
    position = {
      294.990234375,
      1472.7744140625,
      1080.2578125
    },
    rotation = 0,
    interior = 15,
    object = false,
    safe = false
  },
  [121] = {
    name = "24/7 shop 4",
    position = {
      -25.8740234375,
      -140.95703125,
      1003.546875
    },
    rotation = 0,
    interior = 16,
    object = false,
    safe = false
  },
  [122] = {
    name = "LS Tattoo Parlour",
    position = {
      -204.2294921875,
      -26.71875,
      1002.2734375
    },
    rotation = 0,
    interior = 16,
    object = false,
    safe = false
  },
  [123] = {
    name = "Sumoring? stadium",
    position = {
      -1400,
      1250,
      1040
    },
    rotation = 0,
    interior = 16,
    object = false,
    safe = false
  },
  [124] = {
    name = "24/7 shop 5",
    position = {
      -25.7509765625,
      -187.48046875,
      1003.546875
    },
    rotation = 0,
    interior = 17,
    object = false,
    safe = false
  },
  [125] = {
    name = "Club",
    position = {
      493.4687,
      -23.008,
      1000.6796
    },
    rotation = 0,
    interior = 17,
    object = false,
    safe = false
  },
  [126] = {
    name = "Rusty Brown's - Ring Donuts",
    position = {
      377.003,
      -192.507,
      1000.633
    },
    rotation = 0,
    interior = 17,
    object = false,
    safe = false
  },
  [127] = {
    name = "The Sherman's Dam Generator Hall",
    position = {
      -942.132,
      1849.142,
      5.005
    },
    rotation = 0,
    interior = 17,
    object = false,
    safe = false
  },
  [128] = {
    name = "Hemlock Tattoo",
    position = {
      377.003,
      -192.507,
      1000.633
    },
    rotation = 0,
    interior = 17,
    object = false,
    safe = false
  },
  [129] = {
    name = "Lil Probe Inn",
    position = {
      -228.796875,
      1401.177734375,
      27.765625
    },
    rotation = 0,
    interior = 18,
    object = false,
    safe = false
  },
  [130] = {
    name = "24/7 shop 6",
    position = {
      -30.8720703125,
      -91.3359375,
      1003.546875
    },
    rotation = 0,
    interior = 18,
    object = false,
    safe = false
  },
  [131] = {
    name = "Atrium",
    position = {
      1726.974609375,
      -1637.888671875,
      20.222967147827
    },
    rotation = 0,
    interior = 18,
    object = false,
    safe = false
  },
  [132] = {
    name = "Warehouse 2",
    position = {
      1278.7236328125,
      -2.2646484375,
      1000.9351806641
    },
    rotation = 0,
    interior = 18,
    object = false,
    safe = false
  },
  [133] = {
    name = "Zip",
    position = {
      161.2744140625,
      -96.2490234375,
      1001.8046875
    },
    rotation = 0,
    interior = 18,
    object = false,
    safe = false
  },
  [134] = {
    name = "Egyedi garázs",
    position = {
        621.78497314453, -11, 316.4248046875
    },
    rotation = 0,
    interior = 0,
    object = false,
    safe = false
  },
}
function getInteriorName(i)
  if interiorList[i] then
    return interiorList[i].name
  end
end
function getInteriorType(i)
  if interiorList[i] then
    return interiorList[i].type
  end
end
function getInteriorLocked(i)
  if interiorList[i] then
    return interiorList[i].locked
  end
end
function getInteriorEditable(i)
  if interiorList[i] then
    return interiorList[i].editable
  end
end
function getInteriorOwner(i)
  if interiorList[i] then
    return interiorList[i].ownerType, interiorList[i].owner
  end
end
function getInteriorOutsidePosition(i)
  if interiorList[i] and interiorList[i].outside then
    return unpack(interiorList[i].outside)
  end
end
function getInteriorInsidePosition(i, getInt)
  if interiorList[i] then
    if interiorList[i].type == "garage" then
      return 621.785, -26, 1000.9199829102, 1, i, 180
    elseif tonumber(interiorList[i].inside) then
      if gameInteriors[interiorList[i].inside] then
        return gameInteriors[interiorList[i].inside].position[1], gameInteriors[interiorList[i].inside].position[2], gameInteriors[interiorList[i].inside].position[3], gameInteriors[interiorList[i].inside].interior, i, gameInteriors[interiorList[i].inside].rotation
      end
    elseif interiorList[i].inside then
      if getInt then
        return unpack(interiorList[i].inside), interiorList[i].interior
      else
        return unpack(interiorList[i].inside)
      end
    end
  end
end
validInteriorTypes = {}
interiorTypeList = {
  "house",
  "business",
  "garage",
  "garage2",
  "rentable",
  "lift",
  "stairs",
  "door",
  "building"
}
function getInteriorTypeName(input, nocol)
  if input == "house" then
    return (nocol and "" or sightexports.sGui:getColorCodeHex("sightblue")) .. "Ház"
  elseif input == "business" then
    return (nocol and "" or sightexports.sGui:getColorCodeHex("sightgreen")) .. "Üzlet"
  elseif input == "garage" then
    return (nocol and "" or sightexports.sGui:getColorCodeHex("sightblue-second")) .. "Garázs"
  elseif input == "garage2" then
    return (nocol and "" or sightexports.sGui:getColorCodeHex("sightblue-second")) .. "Garázs"
  elseif input == "rentable" then
    return (nocol and "" or sightexports.sGui:getColorCodeHex("sightpurple")) .. "Albérlet"
  elseif input == "lift" then
    return (nocol and "" or sightexports.sGui:getColorCodeHex("hudwhite")) .. "Lift"
  elseif input == "stairs" then
    return (nocol and "" or sightexports.sGui:getColorCodeHex("hudwhite")) .. "Lépcső"
  elseif input == "door" then
    return (nocol and "" or sightexports.sGui:getColorCodeHex("hudwhite")) .. "Ajtó"
  elseif input == "building" then
    return (nocol and "" or sightexports.sGui:getColorCodeHex("sightyellow")) .. "Középület"
  elseif input == "mine" then
    return (nocol and "" or sightexports.sGui:getColorCodeHex("sightyellow")) .. "Bánya"
  end
end
for i = 1, #interiorTypeList do
  validInteriorTypes[interiorTypeList[i]] = true
end
ownableInteriorTypes = {
  house = true,
  business = true,
  garage = true,
  garage2 = true,
  rentable = true,
  lift = true,
  stairs = true,
  door = true
}
knockInteriorTypes = {
  house = true,
  business = true,
  rentable = true,
  garage = true,
  garage2 = true,
  door = true
}
ringInteriorTypes = {
  house = true,
  business = true,
  rentable = true
}
govableInteriorTypes = {
  lift = true,
  stairs = true,
  door = true,
  business = true
}
doorSoundDistance = 35
lockSoundDistance = 30
knockInsideDistance = 40
knockOutsideDistance = 40
ringInsideDistance = 110
ringOutsideDistance = 55
function getMarkerColor(i)
  local data = interiorList[i]
  if data then
    if ownableInteriorTypes[data.type] then
      if data.owner then
        if data.type == "house" then
          return "sightblue"
        elseif data.type == "business" then
          return "sightgreen-second"
        elseif data.type == "garage" or data.type == "garage2" then
          return "sightblue-second"
        elseif data.type == "rentable" then
          return "sightpurple"
        elseif data.type == "lift" or data.type == "stairs" or data.type == "door" then
          return "hudwhite"
        end
      elseif data.price then
        if data.type == "rentable" then
          return "sightpurple-second"
        else
          return "sightgreen"
        end
      elseif govableInteriorTypes[data.type] then
        return "sightyellow"
      else
        return "sightlightgrey"
      end
    else
      return "sightyellow"
    end
  end
  return "sightlightgrey"
end
function getMarkerIcon(i)
  local data = interiorList[i]
  if data then
    if data.type == "house" or data.type == "business" or data.type == "stairs" or data.type == "lift" or data.type == "door" or data.type == "garage" then
      if data.ownerType == "group" then
        return data.type .. "_group"
      elseif data.owner or not data.price then
        return data.type
      else
        return data.type .. "_sale"
      end
    elseif data.type == "garage2" then
      if data.ownerType == "group" then
        return "garage_group"
      elseif data.owner or not data.price then
        return "garage"
      else
        return "garage_sale"
      end
    elseif data.type == "rentable" then
      if data.owner or not data.price then
        return "house"
      else
        return "rentable_forrent"
      end
    elseif data.type == "building" then
      return "building"
    end
  end
  return "arrow"
end
function getMarkerText(i, mc)
  mc = mc or getMarkerColor(i)
  local data = interiorList[i]
  local text = {}
  local textCols = false
  if data then
    text[1] = "[" .. i .. "] " .. interiorList[i].name
    if ownableInteriorTypes[data.type] then
      if not data.owner and not govableInteriorTypes[data.type] then
        textCols = {"#ffffff"}
        if data.price then
          textCols[2] = mc
          if data.type == "rentable" then
            text[2] = "Kiadó! (" .. sightexports.sGui:thousandsStepper(data.price) .. " $ / hét)"
          else
            text[2] = "Eladó! (" .. sightexports.sGui:thousandsStepper(data.price) .. " $)"
          end
        else
          textCols[2] = "sightlightgrey"
          text[2] = "Elhagyatott"
        end
      elseif data.ownerType == "group" then
        textCols = {"#ffffff"}
        textCols[2] = mc
        text[2] = sightexports.sGroups:getGroupName(data.owner) or "N/A"
      end
    end
  else
    text[1] = "n/a"
  end
  return text, textCols
end
interiorList = {}
function getGroupInteriors(prefix)
  local list = {}
  for id, data in pairs(interiorList) do
    if data.ownerType == "group" and data.owner == prefix then
      table.insert(list, id)
    end
  end
  return list
end
function getGroupInteriorsEx(prefix)
  local list = {}
  for id, data in pairs(interiorList) do
    if data.ownerType == "group" and data.owner == prefix then
      list[id] = true
    end
  end
  return list
end
