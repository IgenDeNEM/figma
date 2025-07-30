local sightexports = {sCarshop = false, sVehiclenames = false}
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
local sightlangWaiterState0 = false
local function sightlangProcessResWaiters()
  if not sightlangWaiterState0 then
    local res0 = getResourceFromName("sCarshop")
    local res1 = getResourceFromName("sVehiclenames")
    if res0 and res1 and getResourceState(res0) == "running" and getResourceState(res1) == "running" then
      gotVehicleNames()
      sightlangWaiterState0 = true
    end
  end
end
if triggerServerEvent then
  addEventHandler("onClientResourceStart", getRootElement(), sightlangProcessResWaiters)
end
if triggerClientEvent then
  addEventHandler("onResourceStart", getRootElement(), sightlangProcessResWaiters)
end
basePriceMargins = {
  0,
  5,
  10,
  20,
  30,
  40,
  75
}
baseWages = {
  0,
  500,
  1000,
  2000,
  3000,
  4000,
  5000
}
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
lifts = {
  {
    -1918.77,
    -1674.38,
    20.77,
    3
  },
  {
    -1932.9399,
    -1675.1,
    20.78,
    3
  },
  {
    -1932.03,
    -1693.01,
    20.79,
    183
  },
  {
    -1917.84,
    -1692.27,
    20.83,
    183
  },
  {
    -1824.0996,
    -1636.7002,
    20.8,
    270
  },
  {
    -1825.9301,
    -1624.72,
    20.77,
    269.25
  },
  {
    -1825.77,
    -1610.47,
    20.77,
    269.25
  },
  {
    -1843.85,
    -1624.53,
    20.78,
    89.25
  },
  {
    -1843.64,
    -1610.26,
    20.77,
    89.25
  },
  {
    -1858.64,
    -1610.0699,
    20.77,
    269.25
  },
  {
    -1858.85,
    -1624.3101,
    20.76,
    269.25
  },
  {
    -1876.73,
    -1624.13,
    20.78,
    89.25
  },
  {
    -1876.54,
    -1609.87,
    20.77,
    89
  },
  {
    2400.7,
    -2625.6001,
    12.7,
    359.75
  },
  {
    2386.5,
    -2625.6001,
    12.7,
    359.747
  },
  {
    2400.7,
    -2643.5,
    12.7,
    0.497
  },
  {
    2386.5,
    -2643.5,
    12.7,
    359.747
  },
  {
    2412.1001,
    -2612,
    12.7,
    359.242
  },
  {
    2400.7,
    -2611.7,
    12.7,
    359.992
  },
  {
    2386.5,
    -2611.7,
    12.7,
    359.992
  },
  {
    2386.5,
    -2593.8999,
    12.7,
    0.242
  },
  {
    2400.7,
    -2593.8999,
    12.7,
    359.242
  },
  {
    2449.3999,
    -2630.8,
    12.7,
    180.242
  },
  {
    2400.7,
    -2559.2,
    12.7,
    359.989
  },
  {
    2400.7,
    -2541.3999,
    12.7,
    359.989
  },
  {
    2386.5,
    -2541.3999,
    12.7,
    359.989
  },
  {
    2386.5,
    -2559.2,
    12.7,
    359.989
  },
  {
    2449.5,
    -2541.3999,
    12.7,
    179.989
  },
  {
    2463.5,
    -2541.3,
    12.7,
    179.984
  },
  {
    2463.5,
    -2523.5,
    12.7,
    179.984
  },
  {
    2449.3,
    -2523.5,
    12.7,
    179.984
  },
  {
    2463.6001,
    -2630.8,
    12.7,
    180.242
  },
  {
    2463.6001,
    -2613,
    12.7,
    180.242
  },
  {
    2449.3999,
    -2613,
    12.7,
    180.242
  },
  {
    -1438.9,
    1007.9,
    6.2,
    90
  },
  {
    -1482.3,
    977.70001,
    6.2,
    0
  },
  {
    -1496.6,
    977.70001,
    6.2,
    0
  },
  {
    -1496.5996,
    995.5,
    6.2,
    0
  },
  {
    -1444,
    996.5,
    6.2,
    0
  },
  {
    -1429.8,
    996.5,
    6.2,
    0
  },
  {
    -1429.7,
    978.5,
    6.2,
    0
  },
  {
    -1444,
    978.5,
    6.2,
    0
  },
  {
    -1444.9,
    951.09998,
    6.2,
    0
  },
  {
    -1430.6,
    951.09998,
    6.2,
    0
  },
  {
    -1430.7,
    933.09998,
    6.2,
    0
  },
  {
    -1444.8,
    933.09998,
    6.2,
    0
  },
  {
    -1446.7,
    898.20001,
    6.2,
    270
  },
  {
    -1446.7,
    912.40002,
    6.2,
    270
  },
  {
    -1428.7,
    912.40002,
    6.2,
    270
  },
  {
    -1428.7,
    898.20001,
    6.2,
    270
  },
  {
    -1481.9004,
    898.5,
    6.2,
    270
  },
  {
    -1481.9004,
    912.7002,
    6.2,
    270
  },
  {
    -1499.9,
    912.70001,
    6.2,
    270
  },
  {
    -1499.9,
    898.5,
    6.2,
    270
  },
  {
    -1483.2,
    933.40002,
    6.2,
    0
  },
  {
    -1497.4,
    933.40002,
    6.2,
    0
  },
  {
    -1497.4,
    951.29999,
    6.2,
    0
  },
  {
    -1483.2,
    951.29999,
    6.2,
    0
  },
  {
    -1482.4,
    995.59998,
    6.2,
    0
  },
-- ring -> r = -135.18 -> r = 0  
  {
    -1371.757,
    28.743,
    13.915,
    -135.18
  },
  {
    -1365.5391,
    34.922,
    13.915,
    -135.18
  },
  {
    -1357.6982,
    42.7136,
    13.915,
    -135.18
  },
  {
    -1351.4803,
    48.8926,
    13.915,
    -135.18
  },
  {
    -1343.6395,
    56.6843,
    13.915,
    -135.18
  },
  {
    -1337.4215,
    62.8634,
    13.915,
    -135.18
  },
  {
    -1329.5808,
    70.6549,
    13.915,
    -135.18
  },
  {
    -1323.3628,
    76.834,
    13.915,
    -135.18
  },
  {
    -1315.5221,
    84.6256,
    13.915,
    -135.18
  },
  {
    -1309.3041,
    90.8047,
    13.915,
    -135.18
  },
  {
    -1301.4634,
    98.5963,
    13.915,
    -135.18
  },
  {
    -1295.2454,
    104.7753,
    13.915,
    -135.18
  },
  {
    -1287.4045,
    112.567,
    13.915,
    -135.18
  },
  {
    -1281.1866,
    118.746,
    13.915,
    -135.18
  },
  {
    -1273.3458,
    126.5377,
    13.915,
    -135.18
  },
  {
    -1267.1279,
    132.7167,
    13.915,
    -135.18
  },
  {
    -1259.2871,
    140.5083,
    13.915,
    -135.18
  },
  {
    -1253.0691,
    146.6874,
    13.915,
    -135.18
  },
  {
    -1245.2284,
    154.479,
    13.915,
    -135.18
  },
  {
    -1239.0104,
    160.6581,
    13.915,
    -135.18
  },
  {
    -1231.1697,
    168.4497,
    13.915,
    -135.18
  },
  {
    -1224.9517,
    174.6287,
    13.915,
    -135.18
  },
  {
    -1217.111,
    182.4204,
    13.915,
    -135.18
  },
  {
    -1210.8929,
    188.5994,
    13.915,
    -135.18
  }
}
workshops = {
  [1] = {
    "RING",
    "SightRing services",
    {
      {
        -1218.087890625,
        217.5185546875,
        14.9140625
      },
      {
        -1205.7822265625,
        204.0380859375,
        14.906700134277
      },
      {
        -1211.4697265625,
        197.5,
        14.9140625
      },
      {
        -1188.541015625,
        174.4326171875,
        14.9140625
      },
      {
        -1371.5908203125,
        -7.80859375,
        14.9140625
      },
      {
        -1395.1611328125,
        16.0615234375,
        14.9140625
      },
      {
        -1420.8291015625,
        -9.0546875,
        14.9140625
      },
      {
        -1432.818359375,
        3.048828125,
        14.9140625
      }
    },
    {
      -1383.0498046875,
      11.76953125,
      13.9140625,
      224
    },
    {
      -1376.556640625,
      18.03125,
      13.9140625,
      224
    },
    {
      {
        -1387.5029296875,
        21.8173828125,
        14.9140625,
        225
      },
      {
        -1373.5,
        35.7373046875,
        14.9140625,
        225
      },
      {
        -1359.32421875,
        49.658203125,
        14.9140625,
        225
      },
      {
        -1345.3544921875,
        63.703125,
        14.9140625,
        225
      },
      {
        -1331.3544921875,
        77.619140625,
        14.9140625,
        225
      },
      {
        -1317.2294921875,
        91.66015625,
        14.9140625,
        225
      },
      {
        -1303.22265625,
        105.5732421875,
        14.9140625,
        225
      },
      {
        -1289.1455078125,
        119.5654296875,
        14.9140625,
        225
      },
      {
        -1275.09765625,
        133.529296875,
        14.9140625,
        225
      },
      {
        -1261.015625,
        147.5166015625,
        14.9140625,
        225
      },
      {
        -1246.9951171875,
        161.453125,
        14.9140625,
        225
      },
      {
        -1232.90234375,
        175.4501953125,
        14.9140625,
        225
      },
      {
        -1218.8515625,
        189.4169921875,
        14.9140625,
        225
      }
    },
    "RING",
    true
  },
  [2] = {
    "JUNKYARD",
    "Angel Pine Junkyard Auto Service",
    {
      {
        -1941.3728027344,
        -1719.7242431641,
        27.624198913574
      },
      {
        -1893.2431640625,
        -1719.8310546875,
        24.535823822021
      },
      {
        -1886.9189453125,
        -1697.0224609375,
        22.835960388184
      },
      {
        -1817.22265625,
        -1707.2470703125,
        33.35022354126
      },
      {
        -1771.94140625,
        -1672.19140625,
        39.750312805176
      },
      {
        -1750.677734375,
        -1659.8779296875,
        37.211982727051
      },
      {
        -1756.06433,
        -1598.45374,
        29.26696
      },
      {
        -1907.9071,
        -1499.61646,
        29.26696
      },
      {
        -1908.56640625,
        -1631.9619140625,
        25.120170593262
      },
      {
        -1941.5116,
        -1632.77063,
        48.16684
      }
    },
    {
      -1932.3896484375,
      -1644.05859375,
      20.807811737061,
      91.5
    },
    {
      -1931.9599609375,
      -1662.486328125,
      20.807811737061,
      91.5
    },
    {
      {
        -1925.0400390625,
        -1693.01953125,
        21.75,
        3.5733642578125
      },
      {
        -1927.8896484375,
        -1675.1689453125,
        21.75,
        171.08996582031
      },
      {
        -1877.357421875,
        -1616.61328125,
        21.754102706909,
        264.74432373047
      },
      {
        -1858.4951171875,
        -1617.1357421875,
        21.764225006104,
        78.671569824219
      },
      {
        -1844.1982421875,
        -1617.51953125,
        21.75,
        267.71618652344
      },
      {
        -1825.8134765625,
        -1616.1416015625,
        21.764225006104,
        71.145812988281
      }
    },
    "APMS",
    true
  },
  [3] = {
    "BMS",
    "Boxter Mechanic Shop",
    {
      {
        2404.6201171875,
        -2432.0068359375,
        13.541892051697
      },
      {
        2472.2177734375,
        -2495.9873046875,
        13.650871276855
      },
      {
        2472.89453125,
        -2654.033203125,
        13.6484375
      },
      {
        2372.8349609375,
        -2654.791015625,
        16.584354400635
      },
      {
        2368.775390625,
        -2465.0078125,
        27.384395599365
      }
    },
    {
      2455.8974609375,
      -2599.8994140625,
      12.655431747437,
      270
    },
    {
      2456.1298828125,
      -2586.5146484375,
      12.655375480652,
      270
    },
    {
      {
        2459.044921875,
        -2629.5927734375,
        13.662845611572,
        359.5123124
      },
      {
        2457.00390625,
        -2613.486328125,
        13.662976264954,
        179.12312312
      },
      {
        2393.3447265625,
        -2624.966796875,
        13.6640625,
        176.05584716797
      },
      {
        2393.7978515625,
        -2643.623046875,
        13.6640625,
        2.721923828125
      },
      {
        2393.486328125,
        -2612.107421875,
        13.6640625,
        5.7267150878906
      },
      {
        2393.0390625,
        -2593.88671875,
        13.6640625,
        178.52233886719
      },
      {
        2393.3984375,
        -2559.8603515625,
        13.6640625,
        4.5950927734375
      },
      {
        2393.0439453125,
        -2541.3583984375,
        13.647094726563,
        178.77502441406
      },
      {
        2456.3662109375,
        -2522.9541015625,
        13.6484375,
        184.52093505859
      },
      {
        2456.765625,
        -2541.607421875,
        13.655220031738,
        1.2771911621094
      }
    },
    "BMS",
    true
  },
  [4] = {
    "FIX",
    "Fix & Drive Mechanic Shop",
    {
      {
        -1510.197265625,
        839.9921875,
        7.1853160858154
      },
      {
        -1514.10546875,
        1020.8291015625,
        7.1853160858154
      },
      {
        -1413.4033203125,
        1027.9921875,
        7.1853160858154
      },
      {
        -1403.3291015625,
        838.1806640625,
        7.1853160858154
      }
    },
    {
      -1436.4794921875,
      965.04296875,
      6.2078123092651,
      270
    },
    {
      -1491.2099609375,
      964.453203125,
      6.2078123092651,
      90
    },
    {
      {
        -1481.576171875,
        905.90625,
        7.1796875,
        78.616607666016
      },
      {
        -1499.4228515625,
        905.720703125,
        7.1813831329346,
        270.07278442383
      },
      {
        -1447.37890625,
        905.3896484375,
        7.1853160858154,
        277.96658325195
      },
      {
        -1428.8974609375,
        906.2646484375,
        7.1875,
        99.551391601563
      },
      {
        -1437.6982421875,
        932.82421875,
        7.1853160858154,
        350.20278930664
      },
      {
        -1437.4541015625,
        949.998046875,
        7.1853160858154,
        181.9281463623
      },
      {
        -1436.7900390625,
        977.6455078125,
        7.1853160858154,
        358.16250610352
      },
      {
        -1436.767578125,
        995.462890625,
        7.1826477050781,
        189.06387329102
      },
      {
        -1489.8251953125,
        996.9599609375,
        7.1827907562256,
        180.47241210938
      },
      {
        -1489.537109375,
        976.7958984375,
        7.1777172088623,
        4.018310546875
      },
      {
        -1490.513671875,
        951.8896484375,
        7.1835517883301,
        163.5751953125
      },
      {
        -1490.9814453125,
        932.6103515625,
        7.1796875,
        352.81756591797
      }
    },
    "FIX",
    true
  }
}
for i = 1, #workshops do
  local x, y, z, rz = workshops[i][4][1], workshops[i][4][2], workshops[i][4][3], workshops[i][4][4]
  x = x + -1.2214 * math.cos(math.rad(rz)) - 5.2575 * math.sin(math.rad(rz))
  y = y + -1.2214 * math.sin(math.rad(rz)) + 5.2575 * math.cos(math.rad(rz))
  table.insert(workshops[i][6], {
    x,
    y,
    z + 1,
    rz + 12.9725 + 180
  })
  local x, y, z, rz = workshops[i][5][1], workshops[i][5][2], workshops[i][5][3], workshops[i][5][4]
  x = x + -1.2214 * math.cos(math.rad(rz)) - 5.2575 * math.sin(math.rad(rz))
  y = y + -1.2214 * math.sin(math.rad(rz)) + 5.2575 * math.cos(math.rad(rz))
  table.insert(workshops[i][6], {
    x,
    y,
    z + 1,
    rz + 12.9725 + 180
  })
end
faultCodes = {
  [1] = {
    name = "MOTORHIBA - ÉGÉSKIMARADÁS",
    prefix = "P"
  },
  [2] = {
    name = "MOTORHIBA - KRITIKUS MEGHIBÁSODÁS",
    prefix = "P"
  },
  [3] = {
    name = "AKKUMULÁTOR FESZ. ALACSONY",
    prefix = "E"
  },
  [4] = {
    name = "AKKUMULÁTOR CELLAZÁRLAT",
    prefix = "E"
  },
  [5] = {
    name = "VEZÉRM\195\155TENGELY POZÍCIÓ HIBÁS",
    prefix = "P"
  },
  [6] = {
    name = "ÜZEMANYAG SZIVATTYÚ HIBA",
    prefix = "P"
  },
  [7] = {
    name = "VILÁGÍTÁS ÁRAMKÖR NYITOTT",
    prefix = "E"
  },
  [8] = {
    name = "KORMÁNYSZERVO HIBA",
    prefix = "S"
  },
  [9] = {
    name = "SEBESSÉGVÁLTÓ MEGHIBÁSODÁS",
    prefix = "P"
  },
  [10] = {
    name = "L7 ER\195\148SÍT\195\148 BEÁZÁS",
    prefix = "E"
  }
}
function getFaultCodeName(code)
  return faultCodes[code] and faultCodes[code].prefix .. code .. " - " .. faultCodes[code].name or code .. " - Ismeretlen hiba"
end
partsOnVehicle = {
  frontLeftPanel = {
    name = "Bal első panel"
  },
  frontRightPanel = {
    name = "Jobb első panel"
  },
  rearLeftPanel = {
    name = "Bal hátsó panel"
  },
  rearRightPanel = {
    name = "Jobb hátsó panel"
  },
  windscreen = {
    name = "Szélvédő"
  },
  frontBumper = {
    name = "Első lökhárító"
  },
  rearBumper = {
    name = "Hátsó lökhárító"
  },
  hood = {
    name = "Motorháztető"
  },
  trunk = {
    name = "Csomagtartó"
  },
  frontLeftDoor = {
    name = "Bal első ajtó"
  },
  frontRightDoor = {
    name = "Jobb első ajtó"
  },
  rearLeftDoor = {
    name = "Bal hátsó ajtó"
  },
  rearRightDoor = {
    name = "Jobb hátsó ajtó"
  },
  frontTires = {
    name = "Első gumik"
  },
  rearTires = {
    name = "Hátsó gumik"
  },
  frontLeftLight = {
    name = "Bal első fényszóró"
  },
  frontRightLight = {
    name = "Jobb első fényszóró"
  },
  rearLeftLight = {
    name = "Bal hátsó fényszóró"
  },
  rearRightLight = {
    name = "Jobb hátsó fényszóró"
  },
  oilChangeKit = {name = "Olajcsere"},
  engineRepairKit = {name = "Motor"},
  engineGeneralKit = {
    name = "Motorgenerál"
  },
  engineTimingKit = {name = "Vezérlés"},
  battery = {
    name = "Akkumulátor"
  },
  fuelRepairKit = {
    name = "Üzemanyagrendszer"
  },
  frontBrakes = {name = "Első fék"},
  rearBrakes = {
    name = "Hátsó fék"
  },
  frontLeftSuspension = {
    name = "Bal első felfüggesztés"
  },
  frontRightSuspension = {
    name = "Jobb első felfüggesztés"
  },
  rearLeftSuspension = {
    name = "Bal hátsó felfüggesztés"
  },
  rearRightSuspension = {
    name = "Jobb hátsó felfüggesztés"
  }
}
partsList = {}
for k in pairs(partsOnVehicle) do
  table.insert(partsList, k)
end
partCategories = {
  ["Karosszéria"] = {
    "windscreen",
    "hood",
    "frontLeftLight",
    "frontRightLight",
    "frontBumper",
    "frontLeftPanel",
    "frontRightPanel",
    "frontLeftDoor",
    "frontRightDoor",
    "rearLeftDoor",
    "rearRightDoor",
    "rearLeftPanel",
    "rearRightPanel",
    "rearBumper",
    "rearLeftLight",
    "rearRightLight",
    "trunk"
  },
  Gumik = {
    "frontTires",
    "rearTires",
    "frontWinterTires",
    "rearWinterTires"
  },
  ["Motor és erőátvitel"] = {
    "oilChangeKit",
    "engineRepairKit",
    "engineGeneralKit",
    "engineTimingKit",
    "fuelRepairKit",
    "battery"
  },
  ["Fékek"] = {
    "frontBrakes",
    "rearBrakes"
  },
  ["Felfüggesztés"] = {
    "frontLeftSuspension",
    "frontRightSuspension",
    "rearLeftSuspension",
    "rearRightSuspension"
  }
}
partTypes = {
  frontLeftPanel = {
    name = "Bal első panel",
    wage = 0.25,
    manufacturers = {
      {
        "Kazanish",
        85,
        80,
        "KZN-1101"
      },
      {
        "OEM",
        100,
        100,
        "OEM-LPF-"
      }
    }
  },
  frontRightPanel = {
    name = "Jobb első panel",
    wage = 0.25,
    manufacturers = {
      {
        "Kazanish",
        85,
        80,
        "KZN-1102"
      },
      {
        "OEM",
        100,
        100,
        "OEM-LPF-"
      }
    }
  },
  rearLeftPanel = {
    name = "Bal hátsó panel",
    wage = 0.25,
    manufacturers = {
      {
        "Kazanish",
        85,
        80,
        "KZN-1103"
      },
      {
        "OEM",
        100,
        100,
        "OEM-LPR-"
      }
    }
  },
  rearRightPanel = {
    name = "Jobb hátsó panel",
    wage = 0.25,
    manufacturers = {
      {
        "Kazanish",
        85,
        80,
        "KZN-1104"
      },
      {
        "OEM",
        100,
        100,
        "OEM-RPR-"
      }
    }
  },
  windscreen = {
    name = "Szélvédő",
    wage = 0.5,
    manufacturers = {
      {
        "Tarjáni Öblös",
        75,
        80,
        "ÖBLÖS"
      },
      {
        "Sicurit",
        95,
        95,
        "SC"
      },
      {
        "OEM",
        100,
        100,
        "OEM-WS-"
      }
    }
  },
  frontBumper = {
    name = "Első lökhárító",
    wage = 1,
    manufacturers = {
      {
        "MiguPlast",
        95,
        95,
        "UP"
      },
      {
        "OEM",
        100,
        100,
        "OM-FB-"
      }
    }
  },
  rearBumper = {
    name = "Hátsó lökhárító",
    wage = 1,
    manufacturers = {
      {
        "MiguPlast",
        95,
        95,
        "UP"
      },
      {
        "OEM",
        100,
        100,
        "OEM-RB-"
      }
    }
  },
  hood = {
    name = "Motorháztető",
    wage = 0.75,
    manufacturers = {
      {
        "Kazanish",
        85,
        80,
        "KZN-1210"
      },
      {
        "OEM",
        100,
        100,
        "OEM-H-"
      }
    }
  },
  trunk = {
    name = "Csomagtartó",
    wage = 0.75,
    manufacturers = {
      {
        "Kazanish",
        85,
        80,
        "KZN-1211"
      },
      {
        "OEM",
        100,
        100,
        "OEM-T-"
      }
    }
  },
  frontLeftDoor = {
    name = "Bal első ajtó",
    wage = 0.5,
    manufacturers = {
      {
        "Kazanish",
        85,
        90,
        "KZN-2010"
      },
      {
        "OEM",
        100,
        100,
        "OEM-LDF-"
      }
    }
  },
  frontRightDoor = {
    name = "Jobb első ajtó",
    wage = 0.5,
    manufacturers = {
      {
        "Kazanish",
        85,
        90,
        "KZN-2011"
      },
      {
        "OEM",
        100,
        100,
        "OEM-RDF-"
      }
    }
  },
  rearLeftDoor = {
    name = "Bal hátsó ajtó",
    wage = 0.5,
    manufacturers = {
      {
        "Kazanish",
        85,
        90,
        "KZN-2012"
      },
      {
        "OEM",
        100,
        100,
        "OEM-LDR-"
      }
    }
  },
  rearRightDoor = {
    name = "Jobb hátsó ajtó",
    wage = 0.5,
    manufacturers = {
      {
        "Kazanish",
        85,
        90,
        "KZN-2013"
      },
      {
        "OEM",
        100,
        100,
        "OEM-RDR-"
      }
    }
  },
  frontTires = {
    name = "Első gumik (nyári, párban)",
    wage = 1,
    manufacturers = {
      {
        "TsingLeen Tires",
        70,
        75,
        "LEEN-1-"
      },
      {
        "Pelikan",
        78,
        85,
        "PT"
      },
      {
        "SCGoodpoor",
        85,
        90,
        "SCGP"
      },
      {
        "Hama Street",
        100,
        100,
        "UHAMA-1250"
      },
      {
        "Tichellin",
        115,
        120,
        "TCHT-5-"
      },
      {
        "Pirelli Sport",
        120,
        125,
        "SRTIRESFS"
      }
    }
  },
  rearTires = {
    name = "Hátsó gumik (nyári, párban)",
    wage = 1,
    manufacturers = {
      {
        "TsingLeen Tires",
        70,
        75,
        "LEEN-2-"
      },
      {
        "Pelikan",
        78,
        85,
        "PT"
      },
      {
        "SCGoodpoor",
        85,
        90,
        "SCGP"
      },
      {
        "Hama Street",
        100,
        100,
        "UHAMA-1251"
      },
      {
        "Tichellin",
        115,
        120,
        "TCHT-6-"
      },
      {
        "Pirelli Sport",
        120,
        125,
        "SRTIRESRS"
      }
    }
  },
  frontWinterTires = {
    name = "Első gumik (téli, párban)",
    wage = 1,
    manufacturers = {
      {
        "TsingLeen WinterLine",
        70,
        75,
        "LEEN-3-"
      },
      {
        "Pelikan",
        78,
        85,
        "PT"
      },
      {
        "SCGoodpoor Arctic",
        85,
        90,
        "SCGP-A-"
      },
      {
        "Hama Frost",
        100,
        100,
        "UHAMA-1550"
      },
      {
        "Tichellin",
        115,
        120,
        "TCHT-5-W-"
      },
      {
        "Pirelli WinterSport",
        120,
        125,
        "SRTIRESFWS"
      }
    }
  },
  rearWinterTires = {
    name = "Hátsó gumik (téli, párban)",
    wage = 1,
    manufacturers = {
      {
        "TsingLeen WinterLine",
        70,
        75,
        "LEEN-4-"
      },
      {
        "Pelikan",
        78,
        85,
        "PT"
      },
      {
        "SCGoodpoor Arctic",
        85,
        90,
        "SCGP-A-"
      },
      {
        "Hama Frost",
        100,
        100,
        "UHAMA-1551"
      },
      {
        "Tichellin",
        115,
        120,
        "TCHT-6-W-"
      },
      {
        "Pirelli WinterSport",
        120,
        125,
        "SRTIRESRWS"
      }
    }
  },
  frontLeftLight = {
    name = "Bal első fényszóró",
    wage = 0.25,
    manufacturers = {
      {
        "Tóth-Izzó",
        80,
        80,
        "TÓTH15-"
      },
      {
        "OEM",
        100,
        100,
        "OEM-FLLI-"
      },
      {
        "Bella",
        105,
        110,
        "BELLA"
      }
    }
  },
  frontRightLight = {
    name = "Jobb első fényszóró",
    wage = 0.25,
    manufacturers = {
      {
        "Tóth-Izzó",
        80,
        80,
        "TÓTH16-"
      },
      {
        "OEM",
        100,
        100,
        "OEM-FRLI-"
      },
      {
        "Bella",
        105,
        110,
        "BELLA"
      }
    }
  },
  rearLeftLight = {
    name = "Bal hátsó fényszóró",
    wage = 0.25,
    manufacturers = {
      {
        "Tóth-Izzó",
        80,
        80,
        "TÓTH17-"
      },
      {
        "OEM",
        100,
        100,
        "OEM-RLLI-"
      },
      {
        "Bella",
        105,
        110,
        "BELLA"
      }
    }
  },
  rearRightLight = {
    name = "Jobb hátsó fényszóró",
    wage = 0.25,
    manufacturers = {
      {
        "Tóth-Izzó",
        80,
        80,
        "TÓTH18-"
      },
      {
        "OEM",
        100,
        100,
        "OEM-RRLI-"
      },
      {
        "Bella",
        105,
        110,
        "BELLA"
      }
    }
  },
  oilChangeKit = {
    name = "Olajcsere készlet",
    wage = 1,
    manufacturers = {
      {
        "Sultan",
        80,
        80,
        "SLTNOIL"
      },
      {
        "Venus",
        85,
        90,
        "VENUS-"
      },
      {
        "Mogul",
        95,
        95,
        "MGO-1055-"
      },
      {
        "Migu Meisterteile",
        100,
        100,
        "UMT-O-"
      },
      {
        "Octan",
        110,
        115,
        "OCTAN-"
      },
      {
        "Liqui Family",
        110,
        120,
        "LFAM"
      }
    }
  },
  engineRepairKit = {
    name = "Motor javítókészlet",
    wage = 3,
    manufacturers = {
      {
        "Döfi",
        100,
        95,
        "DF-RK-"
      },
      {
        "Migu Meisterteile",
        100,
        100,
        "UMT-ER-"
      },
      {
        "OEM",
        100,
        105,
        "OEM-ERKIT-"
      }
    }
  },
  engineGeneralKit = {
    name = "Motorgenerál készlet",
    wage = 5,
    manufacturers = {
      {
        "Migu Meisterteile",
        85,
        80,
        "UMT-EG-"
      },
      {
        "Sightemberg",
        90,
        90,
        "STBG"
      },
      {
        "OEM",
        100,
        100,
        "OEM-EGKIT-"
      },
      {
        "TransFender",
        125,
        120,
        "FENDER-05-"
      }
    }
  },
  engineTimingKit = {
    name = "Vezérlés készlet",
    wage = 3,
    manufacturers = {
      {
        "Döfi",
        80,
        75,
        "DF-TK-"
      },
      {
        "Migu Meisterteile",
        90,
        90,
        "UMT-ETK-"
      },
      {
        "OEM",
        100,
        100,
        "OEM-ETKIT-"
      },
      {
        "Sightemberg",
        110,
        110,
        "STBG"
      },
      {
        "TransFender",
        125,
        125,
        "FENDER-43-"
      }
    }
  },
  battery = {
    name = "Akkumulátor",
    wage = 0.25,
    manufacturers = {
      {
        "Tóth-Power",
        90,
        90,
        "TÓTH03-"
      },
      {
        "OEM",
        100,
        100,
        "OEM-BATT-"
      },
      {
        "Kosch",
        105,
        110,
        "K1345"
      }
    }
  },
  fuelRepairKit = {
    name = "Üzemanyagrendszer javítókészlet",
    wage = 1,
    manufacturers = {
      {
        "Migu Meisterteile",
        100,
        95,
        "UMT-FR-"
      },
      {
        "OEM",
        100,
        100,
        "OEM-FRK-"
      }
    }
  },
  frontBrakes = {
    name = "Első fék készlet",
    wage = 1,
    manufacturers = {
      {
        "Walio",
        80,
        85,
        "WALI"
      },
      {
        "Migu Meisterteile",
        95,
        90,
        "UMT-FBKIT-"
      },
      {
        "OEM",
        100,
        100,
        "OEM-FB-"
      },
      {
        "Rexstar",
        105,
        105,
        "REX"
      },
      {
        "Beembo",
        115,
        110,
        "BB-1-"
      }
    }
  },
  rearBrakes = {
    name = "Hátsó fék készlet",
    wage = 1,
    manufacturers = {
      {
        "Walio",
        80,
        85,
        "WALI"
      },
      {
        "Migu Meisterteile",
        95,
        90,
        "UMT-RBKIT-"
      },
      {
        "OEM",
        100,
        100,
        "OEM-RB-"
      },
      {
        "Rexstar",
        105,
        105,
        "REX"
      },
      {
        "Beembo",
        115,
        110,
        "BB-2-"
      }
    }
  },
  frontLeftSuspension = {
    name = "Bal első felfüggesztés készlet",
    wage = 2,
    manufacturers = {
      {
        "Migu Meisterteile",
        90,
        85,
        "UMT-FLSKIT-"
      },
      {
        "Sightemberg",
        95,
        95,
        "STBG"
      },
      {
        "OEM",
        100,
        100,
        "OEM-FLS-"
      },
      {
        "Suchs",
        110,
        115,
        "SCH-1405-"
      }
    }
  },
  frontRightSuspension = {
    name = "Jobb első felfüggesztés készlet",
    wage = 2,
    manufacturers = {
      {
        "Migu Meisterteile",
        90,
        85,
        "UMT-FRSKIT-"
      },
      {
        "Sightemberg",
        95,
        95,
        "STBG"
      },
      {
        "OEM",
        100,
        100,
        "OEM-FRS-"
      },
      {
        "Suchs",
        110,
        115,
        "SCH-1406-"
      }
    }
  },
  rearLeftSuspension = {
    name = "Bal hátsó felfüggesztés készlet",
    wage = 2,
    manufacturers = {
      {
        "Migu Meisterteile",
        90,
        85,
        "UMT-RLSKIT-"
      },
      {
        "Sightemberg",
        95,
        95,
        "STBG"
      },
      {
        "OEM",
        100,
        100,
        "OEM-RLS-"
      },
      {
        "Suchs",
        110,
        115,
        "SCH-1407-"
      }
    }
  },
  rearRightSuspension = {
    name = "Jobb hátsó felfüggesztés készlet",
    wage = 2,
    manufacturers = {
      {
        "Migu Meisterteile",
        90,
        85,
        "UMT-RRSKIT-"
      },
      {
        "Sightemberg",
        95,
        95,
        "STBG"
      },
      {
        "OEM",
        100,
        100,
        "OEM-RRS-"
      },
      {
        "Suchs",
        110,
        115,
        "SCH-1408-"
      }
    }
  }
}
examPrice = 500
fuelPrice = 1500
radioPrice = 3000
immaterials = {
  {
    "Műszaki vizsga",
    examPrice,
    1
  },
  {
    "Futómű beállítás",
    0,
    2
  },
  {
    "Állapotfelmérés",
    0,
    1
  },
  {
    "5 liter üzemanyag",
    fuelPrice,
    0.1
  },
  {
    "Fejegység csere",
    radioPrice,
    0.25
  }
}
local currentPartNum = {}
vehicleIds = {
  582,
  489,
  550,
  516,
  466,
  507,
  502,
  438,
  579,
  580,
  596,
  405,
  533,
  602,
  404,
  585,
  479,
  526,
  500,
  483,
  560,
  486,
  543,
  423,
  499,
  434,
  609,
  412,
  504,
  524,
  508,
  574,
  408,
  403,
  428,
  427,
  575,
  443,
  498,
  419,
  437,
  485,
  505,
  578,
  552,
  599,
  571,
  490,
  407,
  424,
  568,
  482,
  572,
  545,
  544,
  518,
  433,
  457,
  456,
  531,
  530,
  525,
  436,
  600,
  514,
  432,
  470,
  601,
  459,
  414,
  478,
  588,
  583,
  532,
  422,
  455,
  440,
  418,
  442,
  416,
  565,
  542,
  477,
  400,
  492,
  491,
  558,
  445,
  421,
  549,
  420,
  551,
  506,
  402,
  546,
  458,
  540,
  566,
  480,
  554,
  598,
  439,
  603,
  426,
  541,
  576,
  517,
  567,
  467,
  451,
  431,
  562,
  587,
  597,
  503,
  529,
  559,
  429,
  411,
  555,
  589,
  561,
  410,
  496,
  474,
  547,
  415,
  494,
  401,
  527,
  535,
  413,
  605,
  536,
  495,
  528,
  604,
  475,
  409,
  534,
  "primo2",
  "model_s",
  "model_y",
  "leaf",
  "dodge"
}
listOfCarParts = {
  "frontLeftPanel",
  "frontRightPanel",
  "rearLeftPanel",
  "rearRightPanel",
  "windscreen",
  "frontBumper",
  "rearBumper",
  "hood",
  "trunk",
  "frontLeftDoor",
  "frontRightDoor",
  "rearLeftDoor",
  "rearRightDoor",
  "frontTires",
  "rearTires",
  "frontLeftLight",
  "frontRightLight",
  "rearLeftLight",
  "rearRightLight",
  "oilChangeKit",
  "engineRepairKit",
  "engineGeneralKit",
  "engineTimingKit",
  "battery",
  "fuelRepairKit",
  "frontBrakes",
  "rearBrakes",
  "frontLeftSuspension",
  "frontRightSuspension",
  "rearLeftSuspension",
  "rearRightSuspension"
}
partTypePrices = {
  frontLeftPanel = 2,
  frontRightPanel = 2,
  rearLeftPanel = 2,
  rearRightPanel = 2,
  windscreen = 4.25,
  frontBumper = 4,
  rearBumper = 4,
  hood = 5,
  trunk = 5,
  frontLeftDoor = 7,
  frontRightDoor = 7,
  rearLeftDoor = 7,
  rearRightDoor = 7,
  frontTires = 20,
  rearTires = 20,
  frontWinterTires = 20,
  rearWinterTires = 20,
  frontLeftLight = 1.5,
  frontRightLight = 1.5,
  rearLeftLight = 1.5,
  rearRightLight = 1.5,
  oilChangeKit = 12.5,
  engineRepairKit = 40,
  engineGeneralKit = 60,
  engineTimingKit = 45,
  battery = 4.5,
  fuelRepairKit = 5,
  frontBrakes = 35,
  rearBrakes = 35,
  frontLeftSuspension = 30,
  frontRightSuspension = 30,
  rearLeftSuspension = 30,
  rearRightSuspension = 30
}
priceOverride = {}
local basePrices = {}
vehicleModels = {
  ["Egyéb"] = {
    {"Egyéb", 0}
  }
}
makeAndModel = {}
makeAndModel[0] = {"Egyéb", "Egyéb"}
manufacturerList = {}
basePrices[0] = 1000000
local lastOfPrefix = {}
function gotVehicleNames()
  for i = 1, #vehicleIds do
    if not basePrices[vehicleIds[i]] then
      basePrices[vehicleIds[i]] = priceOverride[vehicleIds[i]] or sightexports.sCarshop:getCarshopPrice(vehicleIds[i]) or basePrices[0]
    end
    if vehicleIds[i] then
      local vehMake = sightexports.sVehiclenames:getCustomVehicleManufacturer(vehicleIds[i])
      local vehModel = sightexports.sVehiclenames:getCustomVehicleName(vehicleIds[i])
      vehModel = utf8.gsub(vehModel, string.gsub(vehMake, "%-", "%%-") .. " ", "")
      makeAndModel[vehicleIds[i]] = {vehMake, vehModel}
      if not vehicleModels[vehMake] then
        vehicleModels[vehMake] = {}
        table.insert(manufacturerList, vehMake)
      end
      table.insert(vehicleModels[vehMake], {
        vehModel,
        vehicleIds[i]
      })
    end
  end
  table.sort(manufacturerList)
  local modelSort = function(a, b)
    return a[1] < b[1]
  end
  for i = 1, #manufacturerList do
    table.sort(vehicleModels[manufacturerList[i]], modelSort)
  end
  table.insert(manufacturerList, "Egyéb")
  table.insert(vehicleIds, 0)
  perVehicleParts = {}
  perVehiclePartNumbers = {}
  partPrices = {}
  partBackwards = {}
  for l = 1, #vehicleIds do
    for k, v in pairs(partCategories) do
      for i = 1, #v do
        local manufacturers = partTypes[v[i]].manufacturers
        for j = 1, #manufacturers do
          local model = vehicleIds[l]
          if not perVehicleParts[model] then
            perVehicleParts[model] = {}
          end
          if not perVehiclePartNumbers[model] then
            perVehiclePartNumbers[model] = {}
          end
          if not perVehicleParts[model][v[i]] then
            perVehicleParts[model][v[i]] = {}
          end
          local prefix = manufacturers[j][4]
          if not lastOfPrefix[prefix] then
            lastOfPrefix[prefix] = 0
            for c = 1, utf8.len(prefix) do
              local char = utf8.sub(prefix, c, c)
              if char ~= "-" then
                lastOfPrefix[prefix] = lastOfPrefix[prefix] + string.byte(char) * 85.431
              end
            end
            for c = 1, utf8.len(v[i]) do
              lastOfPrefix[prefix] = lastOfPrefix[prefix] + string.byte(utf8.sub(v[i], c, c)) * 45.12
            end
            lastOfPrefix[prefix] = math.floor(lastOfPrefix[prefix])
          end
          lastOfPrefix[prefix] = lastOfPrefix[prefix] + 1
          local num = tostring(math.floor(lastOfPrefix[prefix] * 1.9412))
          for i = utf8.len(num), 6 do
            num = "0" .. num
          end
          table.insert(perVehiclePartNumbers[model], prefix .. num)
          perVehicleParts[model][v[i]][manufacturers[j][1]] = prefix .. num
          partBackwards[prefix .. num] = {
            model,
            k,
            v[i],
            manufacturers[j][1],
            manufacturers[j][3],
            manufacturers[j][2]
          }
          local percent = math.min(3, math.max(2, 1 / (basePrices[model] / 3500000)))
          local price = basePrices[model] * percent / 100 * partTypePrices[v[i]] / 100
          partPrices[prefix .. num] = math.floor(price * manufacturers[j][3] / 100 + 0.5)
        end
      end
    end
  end
end


evVehicles = {
  ["model_s"] = true,
  ["model_y"] = true,
  ["leaf"] = true,
}