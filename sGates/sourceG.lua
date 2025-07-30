local sightexports = {sGroups = false}
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
    local res0 = getResourceFromName("sGroups")
    if res0 and getResourceState(res0) == "running" then
      groupsRunning()
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
availableGates = {}
availableGates = {
  [1] = {
    objectId = 1447,
    time = 2000,
    open = {
      -1835.9,
      -1566.7,
      20.9,
      270,
      0,
      330
    },
    closed = {
      -1833.8,
      -1563.3,
      20.8,
      270,
      0,
      0
    },
    int = 0,
    dim = 0,
    groups = {"OPSZ"}
  },
  [2] = {
    objectId = "v4_seering_garagedoor",
    time = 2000,
    open = {
      -1365.1156,
      0.1619,
      17.0947,
      -80,
      0,
      44.678
    },
    closed = {
      -1364.7723,
      -0.1852,
      15.5283,
      0,
      0,
      44.678
    },
    int = 0,
    dim = 0,
    moveNoCol = true,
    groups = {"RING"}
  },
  [3] = {
    objectId = "v4_seering_garagedoor",
    time = 2000,
    open = {
      -1351.2386,
      14.3164,
      17.13,
      -80,
      0,
      44.678
    },
    closed = {
      -1350.7233,
      13.7952,
      15.5283,
      0,
      0,
      44.678
    },
    int = 0,
    dim = 0,
    moveNoCol = true,
    groups = {"RING"}
  },
  [4] = {
    objectId = "v4_seering_garagedoor",
    time = 2000,
    open = {
      -1337.1798,
      28.2871,
      17.13,
      -80,
      0,
      44.678
    },
    closed = {
      -1336.6644,
      27.7659,
      15.5283,
      0,
      0,
      44.678
    },
    int = 0,
    dim = 0,
    moveNoCol = true,
    groups = {"RING"}
  },
  [5] = {
    objectId = "v4_seering_garagedoor",
    time = 2000,
    open = {
      -1323.1212,
      42.2578,
      17.13,
      -80,
      0,
      44.678
    },
    closed = {
      -1322.6058,
      41.7366,
      15.5283,
      0,
      0,
      44.678
    },
    int = 0,
    dim = 0,
    moveNoCol = true,
    groups = {"RING"}
  },
  [6] = {
    objectId = "v4_seering_garagedoor",
    time = 2000,
    open = {
      -1309.0625,
      56.2284,
      17.13,
      -80,
      0,
      44.678
    },
    closed = {
      -1308.5471,
      55.7072,
      15.5283,
      0,
      0,
      44.678
    },
    int = 0,
    dim = 0,
    moveNoCol = true,
    groups = {"RING"}
  },
  [7] = {
    objectId = "v4_seering_garagedoor",
    time = 2000,
    open = {
      -1295.0038,
      70.1991,
      17.13,
      -80,
      0,
      44.678
    },
    closed = {
      -1294.4884,
      69.6779,
      15.5283,
      0,
      0,
      44.678
    },
    int = 0,
    dim = 0,
    moveNoCol = true,
    groups = {"RING"}
  },
  [8] = {
    objectId = "v4_seering_garagedoor",
    time = 2000,
    open = {
      -1280.9449,
      84.1698,
      17.13,
      -80,
      0,
      44.678
    },
    closed = {
      -1280.4296,
      83.6486,
      15.5283,
      0,
      0,
      44.678
    },
    int = 0,
    dim = 0,
    moveNoCol = true,
    groups = {"RING"}
  },
  [9] = {
    objectId = "v4_seering_garagedoor",
    time = 2000,
    open = {
      -1266.8861,
      98.1405,
      17.13,
      -80,
      0,
      44.678
    },
    closed = {
      -1266.3707,
      97.6192,
      15.5283,
      0,
      0,
      44.678
    },
    int = 0,
    dim = 0,
    moveNoCol = true,
    groups = {"RING"}
  },
  [10] = {
    objectId = "v4_seering_garagedoor",
    time = 2000,
    open = {
      -1252.8274,
      112.1112,
      17.13,
      -80,
      0,
      44.678
    },
    closed = {
      -1252.312,
      111.59,
      15.5283,
      0,
      0,
      44.678
    },
    int = 0,
    dim = 0,
    moveNoCol = true,
    groups = {"RING"}
  },
  [11] = {
    objectId = "v4_seering_garagedoor",
    time = 2000,
    open = {
      -1238.7688,
      126.0818,
      17.13,
      -80,
      0,
      44.678
    },
    closed = {
      -1238.2534,
      125.5606,
      15.5283,
      0,
      0,
      44.678
    },
    int = 0,
    dim = 0,
    moveNoCol = true,
    groups = {"RING"}
  },
  [12] = {
    objectId = "v4_seering_garagedoor",
    time = 2000,
    open = {
      -1224.7102,
      140.0525,
      17.13,
      -80,
      0,
      44.678
    },
    closed = {
      -1224.1948,
      139.5313,
      15.5283,
      0,
      0,
      44.678
    },
    int = 0,
    dim = 0,
    moveNoCol = true,
    groups = {"RING"}
  },
  [13] = {
    objectId = "v4_seering_garagedoor",
    time = 2000,
    open = {
      -1210.6515,
      154.0232,
      17.13,
      -80,
      0,
      44.678
    },
    closed = {
      -1210.1361,
      153.502,
      15.5283,
      0,
      0,
      44.678
    },
    int = 0,
    dim = 0,
    moveNoCol = true,
    groups = {"RING"}
  },
  [14] = {
    objectId = "v4_seering_garagedoor",
    time = 2000,
    open = {
      -1196.6174,
      168.0188,
      17.13,
      -80,
      0,
      44.678
    },
    closed = {
      -1196.1021,
      167.4975,
      15.5283,
      0,
      0,
      44.678
    },
    int = 0,
    dim = 0,
    moveNoCol = true,
    groups = {"RING"}
  },
  [15] = {
    objectId = 980,
    time = 3000,
    open = {
      1941.8000488281,
      -2230.6000976562,
      15.300000190735,
      0,
      0,
      0
    },
    closed = {
      1930.3000488281,
      -2230.6000976562,
      15.300000190735,
      0,
      0,
      0
    },
    int = 0,
    dim = 0
  },
--[[ SF Borisz magánbirtok (charlestown mob map mellett)  
  [16] = {
    objectId = 980,
    time = 1000,
    open = {
      -2046.9799804688,
      -103.20500183105,
      31.395500183105,
      0,
      0,
      0
    },
    closed = {
      -2046.9899902344,
      -103.18499755859,
      36.910301208496,
      0,
      0,
      0
    },
    int = 0,
    dim = 0
  },
]]--   
  [17] = {
    objectId = 985,
    time = 4000,
    open = {
      269.41500854492,
      -1328.3000488281,
      54.161701202393,
      0,
      -2,
      37
    },
    closed = {
      263.24200439453,
      -1333.0100097656,
      53.907699584961,
      0,
      -2,
      37
    },
    int = 0,
    dim = 0
  },
  [18] = {
    objectId = 980,
    time = 1500,
    open = {
      1245.4899902344,
      -767.22802734375,
      88.279998779297,
      0,
      0,
      0
    },
    closed = {
      1245.4899902344,
      -767.22802734375,
      91.430999755859,
      0,
      0,
      0
    },
    int = 0,
    dim = 0
  },
  [19] = {
    objectId = 980,
    time = 1000,
    open = {
      169.40899658203,
      -1350.25,
      65.323997497559,
      0,
      0,
      -5
    },
    closed = {
      169.40899658203,
      -1350.25,
      69.323997497559,
      0,
      0,
      -5
    },
    int = 0,
    dim = 0
  },
  [20] = {
    objectId = 980,
    time = 1500,
    open = {
      200.69999694824,
      -1386.8000488281,
      44,
      0,
      0,
      44.25
    },
    closed = {
      200.69999694824,
      -1386.8000488281,
      48.389999389648,
      0,
      0,
      44.25
    },
    int = 0,
    dim = 0
  },
  [21] = {
    objectId = 980,
    time = 1000,
    open = {
      1411.4399414063,
      -701.08898925781,
      83.319000244141,
      0,
      0,
      0
    },
    closed = {
      1411.4699707031,
      -700.92297363281,
      88.677299499512,
      0,
      0,
      -4.5
    },
    int = 0,
    dim = 0
  },
  [22] = {
    objectId = 980,
    time = 1000,
    open = {
      321.57800292969,
      -1188.0999755859,
      72.536796569824,
      0,
      0,
      36
    },
    closed = {
      321.47698974609,
      -1188.2900390625,
      77.122200012207,
      0,
      0,
      36
    },
    int = 0,
    dim = 0
  },
-- montgomery modellezett birtok gate 23  
  [23] = {
    objectId = 980,
    time = 1000,
    open = {
      1389.4799804688,
      33.214698791504,
      25.807699203491,
      0,
      0,
      39
    },
    closed = {
      1389.75,
      33.068099975586,
      31.325899124146,
      0,
      0,
      39
    },
    int = 0,
    dim = 0
  },
  [24] = {
    objectId = 980,
    time = 1000,
    open = {
      1643.7399902344,
      -1712.7800292969,
      11.865400314331,
      0,
      0,
      90
    },
    closed = {
      1643.6899414063,
      -1712.7099609375,
      15.910400390625,
      0,
      0,
      90
    },
    int = 0,
    dim = 0
  },
-- montgomery mappolt birtok
--[[  
  [25] = {
    objectId = 969,
    time = 1000,
    open = {
      1470.7600097656,
      218.57000732422,
      14.413000106812,
      0,
      0,
      23
    },
    closed = {
      1470.7600097656,
      218.57000732422,
      18.413000106812,
      0,
      0,
      23
    },
    int = 0,
    dim = 0
  },
]]--  
  [26] = {
    objectId = 975,
    time = 1500,
    open = {
      939.59997558594,
      -680.09997558594,
      116.80000305176,
      0,
      354,
      45.5
    },
    closed = {
      939.59997558594,
      -680.09997558594,
      120.40000152588,
      0,
      354,
      45.5
    },
    int = 0,
    dim = 0
  },
  [27] = {
    objectId = 980,
    time = 1000,
    open = {
      266.9,
      -1226.5,
      74.99,
      0,
      4,
      216
    },
    closed = {
      261.7,
      -1231.3,
      74.4,
      0,
      5,
      216
    },
    int = 0,
    dim = 0
  },
--farmos birtok garazs gate (ls hatar mellett)
--[[
  [28] = {
    objectId = 3037,
    time = 1500,
    open = {
      -373.67999267578,
      -1449.099609375,
      28.799999237061,
      0,
      -70,
      90
    },
    closed = {
      -373.67999267578,
      -1449.099609375,
      26.89999961853,
      0,
      0,
      90
    },
    int = 0,
    dim = 0,
    moveNoCol = true
  },
]]--  
--farmos birtok garazs gate (ls hatar mellett)
--[[
  [29] = {
    objectId = 13028,
    time = 1500,
    open = {
      -390.79998779297,
      -1449.1999511719,
      27.60000038147,
      0,
      75,
      270
    },
    closed = {
      -390.79998779297,
      -1449.1999511719,
      26.60000038147,
      0,
      0,
      270
    },
    int = 0,
    dim = 0,
    moveNoCol = true
  },
]]--  
--farmos birtok garazs gate (ls hatar mellett)  
--[[  
  [30] = {
    objectId = 969,
    time = 1500,
    open = {
      -390.29998779297,
      -1411,
      24.89999961853,
      0,
      0,
      0
    },
    closed = {
      -399.099609375,
      -1411,
      24.89999961853,
      0,
      0,
      0
    },
    int = 0,
    dim = 0
  },
]]--  
  [31] = {
    objectId = 989,
    time = 5000,
    open = {
      1494.9,
      -700.9,
      91.8,
      0,
      0,
      286
    },
    closed = {
      1494.9,
      -700.9,
      95.45,
      0,
      0,
      286
    },
    int = 0,
    dim = 0
  },
  [32] = {
    objectId = 980,
    time = 1000,
    open = {
      665,
      -1309.4004,
      9.6,
      0,
      0,
      179.995
    },
    closed = {
      665,
      -1309.4004,
      15.2,
      0,
      0,
      179.995
    },
    int = 0,
    dim = 0
  },
  [33] = {
    objectId = 980,
    time = 1000,
    open = {
      659.5,
      -1227.3,
      12.2,
      0,
      0,
      62
    },
    closed = {
      659.5,
      -1227.3,
      17.2,
      0,
      0,
      62
    },
    int = 0,
    dim = 0
  },
  [34] = {
    objectId = 980,
    time = 1000,
    open = {
      785.40002,
      -1152.5,
      19.7,
      0,
      0,
      270
    },
    closed = {
      785.40002,
      -1152.5,
      25.3,
      0,
      0,
      270
    },
    int = 0,
    dim = 0
  },
  [35] = {
    objectId = 971,
    time = 2000,
    open = {
      1003.0578,
      -643.59,
      114.92,
      0,
      358.099,
      202
    },
    closed = {
      1003.0578,
      -643.59,
      124,
      0,
      358.099,
      202
    },
    int = 0,
    dim = 0
  },
-- pietrak 4savos birtok
--[[  
  [36] = {
    objectId = 980,
    time = 1500,
    open = {
      2922.6000976563,
      -787.90002441406,
      6,
      0,
      0,
      90
    },
    closed = {
      2922.6000976563,
      -787.90002441406,
      12.800000190735,
      0,
      0,
      90
    },
    int = 0,
    dim = 0
  },
]]--  
  [37] = {
    objectId = 980,
    time = 1500,
    open = {
      282.60000610352,
      -1319.8000488281,
      48,
      0,
      0,
      34.5
    },
    closed = {
      282.60000610352,
      -1319.8000488281,
      55.439998626709,
      0,
      0,
      34.5
    },
    int = 0,
    dim = 0
  },
-- pietrak 4savos birtok garazs gate
--[[  
  [38] = {
    objectId = 10150,
    time = 2000,
    open = {
      3115.8,
      -815.29999,
      12.43,
      0,
      -90,
      90
    },
    closed = {
      3115.8,
      -813.40002,
      10.6,
      0,
      0,
      90
    },
    int = 0,
    dim = 0,
    moveNoCol = true
  },
]]--
-- pietrak 4savos birtok garazs gate
--[[
  [39] = {
    objectId = 10558,
    time = 2000,
    open = {
      3111.77,
      -755.20001,
      12.8,
      0,
      90,
      90
    },
    closed = {
      3111.77,
      -756.78003,
      11.3,
      0,
      0,
      90
    },
    int = 0,
    dim = 0,
    moveNoCol = true,
    scale = 1.05
  },
]]--
--palomino utani birtok
--[[  
  [40] = {
    objectId = 969,
    time = 1500,
    open = {
      1932.3000488281,
      169.80000305176,
      32.900001525879,
      0,
      0,
      340.24993896484
    },
    closed = {
      1932.3000488281,
      169.80000305176,
      35.900001525879,
      0,
      0,
      340.24993896484
    },
    int = 0,
    dim = 0
  },
]]--  
  [41] = {
    objectId = 975,
    time = 1500,
    open = {
      1092.5,
      -628,
      108,
      0,
      12,
      352.99987792969
    },
    closed = {
      1092.5,
      -628,
      111.69999694824,
      0,
      12,
      352.99987792969
    },
    int = 0,
    dim = 0
  },
-- :, zacis mellett bb
--[[ 
  [42] = {
    objectId = 986,
    time = 1000,
    open = {
      222.7548828125,
      19.900390625,
      -3.9999899864197,
      0,
      0,
      90
    },
    closed = {
      222.7548828125,
      19.900390625,
      0.93000000715256,
      0,
      0,
      90
    },
    int = 0,
    dim = 0
  },
]]--  
  [43] = {
    objectId = 980,
    time = 1000,
    open = {
      2817.3,
      -1112.5,
      22.3,
      0,
      0,
      202.5
    },
    closed = {
      2817.3,
      -1112.5,
      27,
      0,
      0,
      202.5
    },
    int = 0,
    dim = 0
  },
  [44] = {
    objectId = 975,
    time = 2000,
    open = {
      863.20001,
      -1385,
      10.5,
      0.247,
      0,
      179.995
    },
    closed = {
      863.20001,
      -1385,
      14,
      0.247,
      0,
      179.995
    },
    int = 0,
    dim = 0
  },
  [45] = {
    objectId = 971,
    time = 1500,
    open = {
      1047.099609375,
      -630.7001953125,
      113,
      0,
      0,
      115.99914550781
    },
    closed = {
      1047.099609375,
      -630.7001953125,
      117.40000152588,
      0,
      0,
      115.99914550781
    },
    int = 0,
    dim = 0
  },
  [46] = {
    objectId = 989,
    time = 1500,
    open = {
      1419.2998046875,
      -637.099609375,
      87,
      1.99951171875,
      0,
      134.99450683594
    },
    closed = {
      1419.2998046875,
      -637.099609375,
      91.400001525879,
      1.99951171875,
      0,
      134.99450683594
    },
    int = 0,
    dim = 0
  },
  [47] = {
    objectId = 969,
    time = 1500,
    open = {
      873.9,
      -866.3,
      76.2,
      0,
      0,
      23.241577148438
    },
    closed = {
      865.79,
      -869.79,
      76.2,
      0,
      0,
      23.241577148438
    },
    int = 0,
    dim = 0
  },
  [48] = {
    objectId = 971,
    time = 1500,
    open = {
      122.7998046875,
      -1483,
      10,
      0,
      0,
      234.4921875
    },
    closed = {
      122.7998046875,
      -1483,
      17.340000152588,
      0,
      0,
      234.4921875
    },
    int = 0,
    dim = 0
  },
  [49] = {
    objectId = 976,
    time = 1500,
    open = {
      951.5,
      -768.20001220703,
      103.8,
      0,
      2,
      106.74993896484
    },
    closed = {
      951.5,
      -768.20001220703,
      107.5,
      0,
      2,
      106.74993896484
    },
    int = 0,
    dim = 0
  },
  [50] = {
    objectId = 986,
    time = 1000,
    open = {
      921.900390625,
      -671.5,
      111.3,
      355.50659179688,
      354.47387695312,
      50.553588867188
    },
    closed = {
      921.900390625,
      -671.5,
      112.69999694824,
      355.50659179688,
      354.47387695312,
      50.553588867188
    },
    int = 0,
    dim = 0
  },
  [51] = {
    objectId = 980,
    time = 1500,
    open = {
      900.400390625,
      -649.099609375,
      109,
      0,
      0,
      236.25006103516
    },
    closed = {
      900.400390625,
      -649.099609375,
      112.69999694824,
      0,
      0,
      236.25006103516
    },
    int = 0,
    dim = 0
  },
  [52] = {
    objectId = 2949,
    time = 1000,
    open = {
      -1310.6899414062,
      2488.1599121094,
      86.120002746582,
      0,
      0,
      275
    },
    closed = {
      -1310.6899414062,
      2488.1599121094,
      86.120002746582,
      0,
      0,
      0
    },
    int = 0,
    dim = 0,
    moveNoCol = true
  },
  [53] = { -- dillimore pd
    objectId = 980,
    time = 1500,
    open = {
      251.2,
      72.4,
      999.7,
      0,
      0,
      0
    },
    closed = {
      251.2,
      72.4,
      1002.5,
      0,
      0,
      0
    },
    int = 6,
    dim = 5555,
    doubleSided = true,
    groups = {"PD"}
  },
  [54] = {
    objectId = 968,
    time = 1000,
    open = {
      1544.6899414063,
      -1630.8599853516,
      13.177800178528,
      0,
      0,
      90
    },
    closed = {
      1544.6899414063,
      -1630.8599853516,
      13.177800178528,
      0,
      90,
      90
    },
    int = 0,
    dim = 0,
    groups = {"PD"}
  },
  [55] = {
    objectId = 980,
    time = 3000,
    open = {
      1588.3800048828,
      -1638.0100097656,
      9.4981298446655,
      0,
      0,
      0
    },
    closed = {
      1588.3800048828,
      -1638.0100097656,
      14.698100090027,
      0,
      0,
      0
    },
    int = 0,
    dim = 0,
    groups = {"PD"}
  },
  [56] = {
    objectId = 980,
    time = 1500,
    open = {
      617.79999,
      -599.40002,
      13.2,
      0,
      0,
      270
    },
    closed = {
      617.79999,
      -599.40002,
      18.9,
      0,
      0,
      270
    },
    int = 0,
    dim = 0,
    groups = {"PD"}
  },
  [57] = {
    objectId = 980,
    time = 3000,
    open = {
      2813.6001,
      -1468.3,
      12.4,
      0,
      0,
      180
    },
    closed = {
      2813.6001,
      -1468.3,
      17.1,
      0,
      0,
      180
    },
    int = 0,
    dim = 0
  },
  [58] = {
    objectId = 3089,
    time = 1500,
    open = {
      1569.3499755859,
      -1678.3000488281,
      2001.3000488281,
      0,
      0,
      0
    },
    closed = {
      1569.3499755859,
      -1678.3000488281,
      2001.3000488281,
      0,
      0,
      270
    },
    int = 1,
    dim = 1,
    moveNoCol = true,
    groups = {"PD"}
  },
  [59] = {
    objectId = 3089,
    time = 1500,
    open = {
      1560.1999511719,
      -1685.4000244141,
      2001.3000488281,
      0,
      0,
      270
    },
    closed = {
      1560.1999511719,
      -1685.4000244141,
      2001.3000488281,
      0,
      0,
      180
    },
    int = 1,
    dim = 1,
    moveNoCol = true,
    groups = {"PD"}
  },
  [60] = {
    objectId = 2930,
    time = 1500,
    open = {
      1565.1600341797,
      -1688.0999755859,
      2002.5999755859,
      0,
      0,
      0
    },
    closed = {
      1565.1600341797,
      -1689.8599853516,
      2002.5999755859,
      0,
      0,
      0
    },
    int = 1,
    dim = 1,
    groups = {"PD"}
  },
  [61] = {
    objectId = 3089,
    time = 1500,
    open = {
      1528.9000244141,
      -1727,
      2002.2320556641,
      0,
      0,
      270
    },
    closed = {
      1528.9000244141,
      -1727,
      2002.2320556641,
      0,
      0,
      180
    },
    int = 1,
    dim = 1,
    groups = {"PD"}
  },
  [62] = {
    objectId = 980,
    time = 1500,
    open = {
      1534.8000488281,
      -1451.5,
      19.89999961853,
      0,
      0,
      0
    },
    closed = {
      1534.8000488281,
      -1451.5,
      14.800000190735,
      0,
      0,
      0
    },
    int = 0,
    dim = 0,
    groups = {"TEK"}
  },
  [63] = {
    objectId = 980,
    time = 2000,
    open = {
      1464.9000244141,
      -1510,
      13.39999961853,
      0,
      0,
      90
    },
    closed = {
      1464.900390625,
      -1501,
      13.39999961853,
      0,
      0,
      90
    },
    int = 0,
    dim = 0,
    groups = {
      "TEK"
    },
  },
  [64] = {
    objectId = 980,
    time = 2000,
    open = {
      1997.0999755859,
      -1445.4000244141,
      9.7,
      0,
      0,
      90
    },
    closed = {
      1997.0999755859, 
      -1445.4000244141, 
      14.800000190735,
      0,
      0,
      90
    },
    int = 0,
    dim = 0,
    groups = {"NNI"}
  },
  [65] = {
    objectId = 971,
    time = 1000,
    open = {
      -1571.6999511719,
      661.32000732422,
      0,
      0,
      0,
      90
    },
    closed = {
      -1571.6999511719,
      661.32000732422,
      5.9899997711182,
      0,
      0,
      90
    },
    int = 0,
    dim = 0,
    scale = 1.03999996,
    groups = {"NAV"}
  },
  [66] = {
    objectId = 3089,
    time = 1000,
    open = {
      -1602.3000488281,
      698.34997558594,
      9005,
      0,
      0,
      180
    },
    closed = {
      -1602.3000488281,
      698.34997558594,
      9005,
      0,
      0,
      270
    },
    int = 1,
    dim = 1,
    moveNoCol = true,
    groups = {"NAV"}
  },
  [67] = {
    objectId = 3089,
    time = 1000,
    open = {
      -1609.0999755859,
      687.79998779297,
      8998,
      0,
      0,
      0
    },
    closed = {
      -1609.0999755859,
      687.79998779297,
      8998,
      0,
      0,
      90
    },
    int = 1,
    dim = 1,
    moveNoCol = true,
    groups = {"NAV"}
  },
  [68] = {
    objectId = 3089,
    time = 1000,
    open = {
      -1629.8000488281,
      693.099609375,
      8999.400390625,
      0,
      0,
      180
    },
    closed = {
      -1629.8000488281,
      693.099609375,
      8999.400390625,
      0,
      0,
      270
    },
    int = 1,
    dim = 1,
    moveNoCol = true,
    groups = {"NAV"}
  },
  [69] = {
    objectId = 10184,
    time = 3000,
    open = {
      -1631.5500488281,
      691.51300048828,
      10.833499908447,
      0,
      90,
      90
    },
    closed = {
      -1631.5500488281,
      688.81298828125,
      8.5815000534058,
      0,
      0,
      90
    },
    int = 0,
    dim = 0,
    moveNoCol = true,
    groups = {"NAV"}
  },
  [70] = {
    objectId = 988,
    time = 1000,
    open = {
      -1620.3399658203,
      688.14398193359,
      1.5874999761581,
      0,
      0,
      0
    },
    closed = {
      -1620.3399658203,
      688.14398193359,
      6.5875000953674,
      0,
      0,
      0
    },
    int = 0,
    dim = 0,
    groups = {"NAV"}
  },
  [71] = {
    objectId = 968,
    time = 1000,
    open = {
      -1701.5200195313,
      687.51800537109,
      24.72859954834,
      0,
      0,
      90
    },
    closed = {
      -1701.5200195313,
      687.51800537109,
      24.72859954834,
      0,
      -90,
      90
    },
    int = 0,
    dim = 0,
    groups = {"NAV"}
  },
  [72] = {
    objectId = 980,
    time = 3000,
    open = {
      -2424.25,
      500.3869934082,
      31.846300125122,
      0,
      0,
      204
    },
    closed = {
      -2433.5,
      496.26599121094,
      31.846300125122,
      0,
      0,
      204
    },
    int = 0,
    dim = 0,
    groups = {"NAV"}
  },
  [73] = {
    objectId = 980,
    time = 1000,
    open = {
      -1528.6199951172,
      495.7001953125,
      3.4000000953674,
      0,
      0,
      0
    },
    closed = {
      -1528.6199951172,
      495.7001953125,
      8.9499998092651,
      0,
      0,
      0
    },
    int = 0,
    dim = 0,
    groups = {"ARMY"}
  },
  [74] = {
    objectId = 10841,
    time = 1000,
    open = {
      -1340.9000244141,
      391.099609375,
      3.89,
      0,
      0,
      90
    },
    closed = {
      -1340.9000244141,
      391.099609375,
      14.10000038147,
      0,
      0,
      90
    },
    int = 0,
    dim = 0,
    groups = {"ARMY"}
  },
  [75] = {
    objectId = 10828,
    time = 1000,
    open = {
      -1329.0999755859,
      354.7001953125,
      -6,
      0,
      0,
      90
    },
    closed = {
      -1329.0999755859,
      354.7001953125,
      2,
      0,
      0,
      90
    },
    int = 0,
    dim = 0,
    groups = {"ARMY"}
  },
  [76] = {
    objectId = 3115,
    time = 1000,
    open = {
      -1456.7099609375,
      501.29998779297,
      9.8699998855591,
      0,
      0,
      0
    },
    closed = {
      -1456.7099609375,
      501.29998779297,
      16.924999237061,
      0,
      0,
      0
    },
    int = 0,
    dim = 0,
    groups = {"ARMY"}
  },
  [77] = {
    objectId = 3114,
    time = 1000,
    open = {
      -1414.4499511719,
      516.46002197266,
      9.6379995346069,
      0,
      0,
      0
    },
    closed = {
      -1414.4499511719,
      516.46002197266,
      16.679000854492,
      0,
      0,
      0
    },
    int = 0,
    dim = 0,
    groups = {"ARMY"}
  },
  [78] = {
    objectId = 10841,
    time = 1000,
    open = {
      -1341.099609375,
      426.7001953125,
      3.89,
      0,
      0,
      90
    },
    closed = {
      -1341.099609375,
      426.7001953125,
      14.10000038147,
      0,
      0,
      90
    },
    int = 0,
    dim = 0,
    groups = {"ARMY"}
  },
  [79] = {
    objectId = "okf_firedep_door",
    time = 2000,
    open = {
      -2023.6,
      74.25,
      31.7,
      0,
      90,
      179.995
    },
    closed = {
      -2023.6,
      74.25,
      28.1,
      0,
      0,
      179.995
    },
    int = 0,
    dim = 0,
    groups = {"OKF"}
  },
  [80] = {
    objectId = "okf_firedep_door",
    time = 2000,
    open = {
      -2023.6,
      80.15,
      31.7,
      0,
      90,
      179.995
    },
    closed = {
      -2023.6,
      80.15,
      28.1,
      0,
      0,
      179.995
    },
    int = 0,
    dim = 0,
    groups = {"OKF"}
  },
  [81] = {
    objectId = "okf_firedep_door",
    time = 2000,
    open = {
      -2023.6,
      87.88,
      31.7,
      0,
      90,
      179.995
    },
    closed = {
      -2023.6,
      87.88,
      28.1,
      0,
      0,
      179.995
    },
    int = 0,
    dim = 0,
    groups = {"OKF"}
  },
  [82] = {
    objectId = 968,
    time = 1000,
    open = {
      -2029.8002,
      56.6,
      28.8,
      0,
      0,
      270
    },
    closed = {
      -2029.8002,
      56.6,
      28.8,
      0,
      90,
      270
    },
    int = 0,
    dim = 0,
    groups = {"OKF"}
  },
  [83] = {
    objectId = "okf_firedep_door",
    time = 2000,
    open = {
      -2023.6,
      93.82,
      31.7,
      0,
      90,
      179.995
    },
    closed = {
      -2023.6,
      93.82,
      28.1,
      0,
      0,
      179.995
    },
    int = 0,
    dim = 0,
    groups = {"OKF"}
  },
  [84] = {
    objectId = 980,
    time = 2000,
    open = {
      2704,
      -1970,
      6.4,
      0,
      90,
      270
    },
    closed = {
      2704,
      -1970,
      9.19999980926,
      0,
      90,
      270
    },
    int = 0,
    dim = 0,
    groups = {"OKF"}
  },
  [85] = {
    objectId = 16775,
    time = 2500,
    open = {
      1285.6,
      -1652.7,
      21.4,
      180,
      0,
      270
    },
    closed = {
      1285.6,
      -1652.7,
      16.5,
      180,
      0,
      270
    },
    int = 0,
    dim = 0,
    groups = {"OMSZ"}
  },
  [86] = {
    objectId = 980,
    time = 1500,
    open = {
      1286.3,
      -1602.8,
      14.4,
      0,
      0,
      270
    },
    closed = {
      1286.3,
      -1609.3,
      14.4,
      0,
      0,
      270
    },
    int = 0,
    dim = 0,
    groups = {"OMSZ"}
  },
  [87] = {
    objectId = 975,
    time = 1500,
    open = {
      1140.6999511719,
      -1291,
      13.699999809265,
      0,
      0,
      0
    },
    closed = {
      1131.7998046875,
      -1291,
      13.699999809265,
      0,
      0,
      0
    },
    int = 0,
    dim = 0,
    groups = {"OMSZ"}
  },
  [88] = {
    objectId = 968,
    time = 1500,
    open = {
      -2613.8999023438,
      619.09997558594,
      14.300000190735,
      0,
      0,
      90
    },
    closed = {
      -2613.8999023438,
      619.09997558594,
      14.300000190735,
      0,
      90,
      90
    },
    int = 0,
    dim = 0,
    groups = {"OMSZ"}
  },
  [89] = {
    objectId = 968,
    time = 1500,
    open = {
      -2676.8000488281,
      587.5,
      14.199999809265,
      0,
      0,
      90
    },
    closed = {
      -2676.8000488281,
      587.5,
      14.199999809265,
      0,
      90,
      90
    },
    int = 0,
    dim = 0,
    groups = {"OMSZ"}
  },
  [90] = {
    objectId = 968,
    time = 1500,
    open = {
      1211.5999755859,
      294.83999633789,
      19.260000228882,
      0,
      0,
      336.29992675781
    },
    closed = {
      1211.5999755859,
      294.83999633789,
      19.260000228882,
      0,
      90,
      336.29992675781
    },
    int = 0,
    dim = 0,
    groups = {"OMSZ"}
  },
  [91] = {
    objectId = 969,
    time = 2500,
    open = {
      1811.5,
      -1894.6,
      12.4,
      0,
      0,
      270
    },
    closed = {
      1811.5,
      -1885.9,
      12.4,
      0,
      0,
      270
    },
    int = 0,
    dim = 0,
    groups = {"TAXI", "TOW"}
  },
  [92] = {
    objectId = 980,
    time = 1000,
    open = {
      -2097.7998046875,
      -13,
      31.5,
      0,
      0,
      270
    },
    closed = {
      -2097.7998046875,
      -13,
      36.5,
      0,
      0,
      270
    },
    int = 0,
    dim = 0,
    groups = {"PF"}
  },
  [93] = {
    objectId = 971,
    time = 1000,
    open = {
      1812.900390625,
      -2072.4799804688,
      7.7,
      0,
      0,
      270
    },
    closed = {
      1812.900390625,
      -2072.4799804688,
      12.173999786377,
      0,
      0,
      270
    },
    int = 0,
    dim = 0,
    scale = 1.12800002,
    groups = {"PF"}
  },
  [94] = {
    objectId = 988,
    time = 1000,
    open = {
      -2108.8999,
      -2427.3999,
      25.1,
      0,
      0,
      321.5
    },
    closed = {
      -2108.9199,
      -2427.45,
      28.53,
      0,
      0,
      321.5
    },
    int = 0,
    dim = 0,
    groups = {"NSM"}
  },
  [95] = {
    objectId = 11102,
    time = 1000,
    open = {
      -2100.8,
      -2401.1001,
      32.2,
      0,
      0,
      140
    },
    closed = {
      -2104.1001,
      -2405,
      32.2,
      0,
      0,
      140
    },
    int = 0,
    dim = 0,
    groups = {"NSM"}
  },
-- sons of odin kapu minden kozepen
--[[
  [96] = {
    objectId = 988,
    time = 2000,
    open = {
      698.90002441406,
      -472.10000610352,
      11.199999809265,
      0,
      0,
      0
    },
    closed = {
      698.9296875,
      -472.099609375,
      15.000040054321,
      0,
      0,
      0
    },
    int = 0,
    dim = 0,
    groups = {"SOD"}
  },
]]--  
  [97] = {
    objectId = 980,
    time = 2000,
    open = {
      -2116.5,
      -80.900001525879,
      37.099998474121,
      0,
      0,
      0
    },
    closed = {
      -2127.6000976562,
      -80.800003051758,
      37.099998474121,
      0,
      0,
      0
    },
    int = 0,
    dim = 0,
    groups = {"SOD"}
  },
  [98] = {
    objectId = 13028,
    time = 2500,
    open = {
      720,
      -460.70001220703,
      18.700000762939,
      0,
      90,
      90
    },
    closed = {
      720,
      -462.5,
      17.200000762939,
      0,
      0,
      90
    },
    int = 0,
    dim = 0,
    groups = {"SOD"}
  },
  --[[
  [99] = {
    objectId = 969,
    time = 4000,
    open = {
      -1889.7900390625,
      -1709.5,
      20.909999847412,
      0,
      0,
      252.74597167969
    },
    closed = {
      -1887.91015625,
      -1702.3701171875,
      20.909999847412,
      0,
      0,
      255.498046875
    },
    int = 0,
    dim = 0,
    groups = {"APMS"}
  },
  ]]
  [100] = {
    objectId = "v4_armbarrier2",
    time = 2000,
    open = {
      -1887.3669433594, -1695.2022705078 - 0.725, 21.731058120728,
      180,
      180,
      -10
    },
    closed = {
      -1887.3669433594, -1695.2022705078 - 0.725, 21.731058120728,
      180,
      90,
      -10
    },
    int = 0,
    dim = 0,
    groups = {"APMS"}
  },
  [101] = {
    objectId = 975,
    time = 3000,
    open = {
      -1899.5999755859,
      -1601.5,
      22.70999961853,
      0,
      0,
      175.99450683594
    },
    closed = {
      -1890.8000488281,
      -1602,
      22.70999961853,
      0,
      0,
      177.5
    },
    int = 0,
    dim = 0,
    scale = 1.15,
    groups = {"APMS"}
  },
  [102] = {
    objectId = "v4_armbarrier2",
    time = 3000,
    open = {
      -1494.0999755859,
      843.24998779297,
      7.1000000953674,
      0,
      0,
      180
    },
    closed = {
      -1494.0999755859,
      843.24998779297,
      7.1000000953674,
      0,
      270,
      180
    },
    int = 0,
    dim = 0,
    groups = {"FIX"}
  },
  [103] = {
    objectId = 975,
    time = 3000,
    open = {
      -1506.5,
      1003.5999755859,
      7.9000000953674,
      0,
      0,
      90
    },
    closed = {
      -1506.5,
      1012.4000244141,
      7.9000000953674,
      0,
      0,
      90
    },
    int = 0,
    dim = 0,
    groups = {"FIX"}
  },
  [104] = {
    objectId = 975,
    time = 3000,
    open = {
      2429.5,
      -2653.3999023438,
      14.300000190735,
      0,
      0,
      180
    },
    closed = {
      2420.6000976562,
      -2653.3999023438,
      14.300000190735,
      0,
      0,
      180
    },
    int = 0,
    dim = 0,
    groups = {"BMS"}
  },
  [106] = {
    objectId = 1493,
    time = 1500,
    open = {
      473.89999,
      -21.3,
      1002.7,
      0,
      0,
      99
    },
    closed = {
      473.79999,
      -21.3,
      1002.7,
      0,
      0,
      0
    },
    int = 17,
    dim = 123,
    moveNoCol = true,
    groups = {"CLUB"}
  },
-- maganbirtok gate 4 savos palo melett
--[[
  [108] = {
    objectId = 980,
    time = 1000,
    open = {
      1543.1,
      66.6,
      22,
      0,
      0,
      19.25
    },
    closed = {
      1543.1,
      66.6,
      25.6,
      0,
      0,
      19.25
    },
    int = 0,
    dim = 0
  },
]]--  
  [109] = {
    objectId = 976,
    time = 1500,
    open = {
      1123,
      -1160,
      23,
      0,
      0,
      0
    },
    closed = {
      1115,
      -1160,
      23,
      0,
      0,
      0
    },
    int = 0,
    dim = 0,
    groups = {"NSM"}
  },
  [110] = {
    objectId = 5422,
    time = 1000,
    open = {
      -691.3,
      943.6,
      14.1,
      0,
      0,
      -90
    },
    closed = {
      -688.70534667969,
      943.6,
      14.1,
      0,
      0,
      -90
    },
    int = 0,
    dim = 0,
    groups = {"SG"}
  },
  [111] = {
    objectId = "v4_armbarrier2",
    time = 1000,
    open = {
      2436.5217,
      -2478.282,
      13.5907,
      0,
      0,
      -45
    },
    closed = {
      2436.5217,
      -2478.282,
      13.5907,
      0,
      -90,
      -45
    },
    int = 0,
    dim = 0,
    groups = {
      "BMS"
    },
  },
  [112] = {
    objectId = "v4_armbarrier2",
    time = 1000,
    open = {
      2432.0977,
      -2473.8579,
      13.5907,
      0,
      0,
      -45
    },
    closed = {
      2432.0977,
      -2473.8579,
      13.5907,
      0,
      -90,
      -45
    },
    int = 0,
    dim = 0,
    groups = {
      "BMS"
    },
  },
  [113] = {
    objectId = "v4_armbarrier2",
    time = 1000,
    open = {
      2427.7302,
      -2469.4905,
      13.5907,
      0,
      0,
      -45
    },
    closed = {
      2427.7302,
      -2469.4905,
      13.5907,
      0,
      -90,
      -45
    },
    int = 0,
    dim = 0,
    groups = {
      "BMS"
    },
  },
--[[  
  [114] = {
    objectId = "v4_armbarrier2",
    time = 1000,
    open = {
      -716.17114257812, 997.55133056641, 13.141407966614,
      0,
      0,
      0
    },
    closed = {
      -716.17114257812, 997.55133056641, 13.141407966614,
      0,
      -90,
      0
    },
    int = 0,
    dim = 0,
    groups = {
      "BMS"
    },
  },
]]--  
  [115] = {
    objectId = "v4_armbarrier2",
    time = 2000,
    open = {
      -1887.3669433594 + 5.25, -1695.2022705078 - 1.685, 21.731058120728,
      180,
      180,
      -10
    },
    closed = {
      -1887.3669433594 + 5.25, -1695.2022705078 - 1.685, 21.731058120728,
      180,
      90,
      -10
    },
    int = 0,
    dim = 0,
    groups = {"APMS"}
  },
  [116] = {
    objectId = "v4_armbarrier2",
    time = 2000,
    open = {
      -1887.3669433594 + 10.6, -1695.2022705078 - 2.65, 21.731058120728,
      180,
      180,
      -10
    },
    closed = {
      -1887.3669433594 + 10.6, -1695.2022705078 - 2.65, 21.731058120728,
      180,
      90,
      -10
    },
    int = 0,
    dim = 0,
    groups = {"APMS"}
  },
  [117] = {
    objectId = "v4_armbarrier2",
    time = 3000,
    open = {
      -1499.7999755859,
      843.24998779297,
      7.1000000953674,
      0,
      0,
      180
    },
    closed = {
      -1499.7999755859,
      843.24998779297,
      7.1000000953674,
      0,
      270,
      180
    },
    int = 0,
    dim = 0,
    groups = {"FIX"}
  },
  [118] = {
    objectId = "v4_armbarrier2",
    time = 3000,
    open = {
      -1505.5999755859,
      843.24998779297,
      7.1000000953674,
      0,
      0,
      180
    },
    closed = {
      -1505.5999755859,
      843.24998779297,
      7.1000000953674,
      0,
      270,
      180
    },
    int = 0,
    dim = 0,
    groups = {"FIX"}
  },
  [119] = { -- dillimore pd
    objectId = 980,
    time = 1500,
    open = {
      246.50733947754, 72.57933807373, 1003.640625 - 4,
      0,
      180,
      0
    },
    closed = {
      246.50733947754, 72.57933807373, 1003.640625 - 1,
      0,
      180,
      0
    },
    int = 6,
    dim = 63,
    doubleSided = true,
    groups = {"PD"}
  },
}
groupGates = {}
for k, v in pairs(availableGates) do
  if v.groups then
    for i = 1, #v.groups do
      if not groupGates[v.groups[i]] then
        groupGates[v.groups[i]] = {}
      end
      table.insert(groupGates[v.groups[i]], k)
    end
  end
end
function groupsRunning()
  if triggerClientEvent then
    --sightexports.sGroups:refreshAllGroupGates()
  end
end
function getGroupGates(prefix)
  return groupGates[prefix] or {}
end
function getGateGroups(id)
  local dat = false
  if availableGates[id] and availableGates[id].groups then
    dat = {}
    for i = 1, #availableGates[id].groups do
      dat[availableGates[id].groups[i]] = true
    end
  end
  return dat
end
function getGateDetails(id)
  return availableGates[id]
end
