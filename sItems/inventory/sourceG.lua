local sightexports = {
  sLottery = false,
  sWeapons = false,
  sCrate = false
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
local sightlangWaiterState0 = false
local sightlangWaiterState1 = false
local function sightlangProcessResWaiters()
  if not sightlangWaiterState0 then
    local res0 = getResourceFromName("sWeapons")
    if res0 and getResourceState(res0) == "running" then
      weaponsRunning()
      sightlangWaiterState0 = true
    end
  end
  if not sightlangWaiterState1 then
    local res0 = getResourceFromName("sCrate")
    if res0 and getResourceState(res0) == "running" then
      crateRunning()
      sightlangWaiterState1 = true
    end
  end
end
if triggerServerEvent then
  addEventHandler("onClientResourceStart", getRootElement(), sightlangProcessResWaiters)
end
if triggerClientEvent then
  addEventHandler("onResourceStart", getRootElement(), sightlangProcessResWaiters)
end
illegalItemDropoffs = {
  [606] = 15000,
  [299] = 10000,
  [428] = 1500,
  [11] = 1500,
  [12] = 1500,
  [13] = 2000,
  [14] = 2000,
  [15] = 2000,
  [16] = 2000,
  [17] = 4000,
  [18] = 4000,
  [19] = 4000,
  [57] = 1500,
  [60] = 4000,
  [65] = 2000,
  [67] = 10000,
  [70] = 9000,
  [74] = 50000,
  [76] = 20000,
  [77] = 40000,
  [78] = 25000,
  [79] = 30000,
  [80] = 60000,
  [81] = 60000,
  [82] = 25000,
  [83] = 35000,
  [84] = 25000,
  [85] = 28000,
  [86] = 45000,
  [87] = 70000,
  [88] = 70000,
  [93] = 5000,
  [94] = 5000,
  [95] = 5000,
  [102] = 38000,
  [128] = 2500,
  [129] = 2500,
  [130] = 2500,
  [131] = 2500,
  [132] = 2500,
  [133] = 2500,
  [134] = 2500,
  [135] = 2500,
  [136] = 2500,
  [137] = 2500,
  [138] = 2500,
  [139] = 2500,
  [140] = 2500,
  [141] = 2500,
  [142] = 2500,
  [143] = 2500,
  [144] = 2500,
  [145] = 2500,
  [146] = 2500,
  [233] = 2500,
  [265] = 500000,
  [266] = 500000,
  [267] = 500000,
  [268] = 500000,
  [269] = 500000,
  [270] = 500000,
  [271] = 500000,
  [272] = 300000,
  [273] = 300000,
  [274] = 750000,
  [275] = 750000,
  [276] = 400000,
  [277] = 400000,
  [278] = 400000,
  [279] = 400000,
  [280] = 120000,
  [281] = 120000,
  [282] = 120000,
  [283] = 350000,
  [284] = 350000,
  [285] = 350000,
  [286] = 350000,
  [301] = 2500,
  [302] = 2500,
  [303] = 2500,
  [304] = 2500,
  [305] = 2500,
  [306] = 2500,
  [307] = 2500,
  [340] = 400000,
  [341] = 400000,
  [342] = 200000,
  [343] = 200000,
  [344] = 200000,
  [345] = 200000,
  [346] = 400000,
  [347] = 400000,
  [361] = 200000,
  [369] = 400000,
  [407] = 120000,
  [408] = 120000,
  [409] = 120000,
  [410] = 150000,
  [411] = 150000,
  [414] = 300000,
  [431] = 2000,
  [432] = 2000,
  [433] = 350000,
  [434] = 350000,
  [435] = 350000,
  [436] = 350000,
  [444] = 2500,
  [445] = 2500,
  [448] = 2000,
  [449] = 2500,
  [450] = 2000,
  [451] = 2500,
  [452] = 2000,
  [454] = 2500,
  [455] = 15000,
  [456] = 15000,
  [457] = 15000,
  [458] = 15000,
  [459] = 15000,
  [471] = 22000,
  [472] = 220000,
  [473] = 220000,
  [474] = 220000,
  [475] = 32000,
  [476] = 550000,
  [477] = 550000,
  [478] = 550000,
  [479] = 550000,
  [480] = 50000,
  [481] = 570000,
  [482] = 570000,
  [483] = 58000,
  [484] = 580000,
  [485] = 580000,
  [486] = 58000,
  [487] = 580000,
  [488] = 580000,
  [489] = 58000,
  [490] = 580000,
  [491] = 580000,
  [492] = 60000,
  [493] = 25000,
  [494] = 220000,
  [495] = 220000,
  [496] = 220000,
  [497] = 220000,
  [498] = 220000,
  [499] = 220000,
  [500] = 30000,
  [501] = 250000,
  [502] = 250000,
  [503] = 250000,
  [504] = 250000,
  [505] = 90000,
  [506] = 750000,
  [507] = 67000,
  [508] = 550000,
  [509] = 550000,
  [510] = 550000,
  [511] = 550000,
  [512] = 70000,
  [513] = 570000,
  [514] = 570000,
  [515] = 570000,
  [516] = 570000,
  [517] = 65000,
  [518] = 550000,
  [519] = 550000,
  [520] = 55000,
  [521] = 425000,
  [522] = 425000,
  [523] = 225000,
  [524] = 225000,
  [525] = 225000,
  [526] = 225000,
  [527] = 225000,
  [528] = 65000,
  [529] = 455000,
  [530] = 455000,
  [531] = 50,
  [532] = 75,
  [533] = 75,
  [534] = 75,
  [535] = 50,
  [536] = 100,
  [537] = 100,
  [538] = 50,
  [539] = 50,
  [540] = 75,
  [541] = 75,
  [542] = 25,
  [556] = 400000,
  [557] = 400000,
  [558] = 400000,
  [559] = 400000,
  [560] = 400000,
  [561] = 25000,
  [562] = 90000,
  [567] = 275000,
  [568] = 275000,
  [569] = 275000,
  [570] = 275000,
  [571] = 275000,
  [572] = 275000,
  [574] = 35000,
  [575] = 30000,
  [576] = 250000,
  [577] = 250000,
  [578] = 250000,
  [579] = 250000,
  [580] = 250000,
  [581] = 250000
}
illegalItemNpcs = {
  {
    3,
    1561.6572265625,
    -1709.357421875,
    1994.8203125,
    0,
    1,
    1,
    "PD"
  },
  {
    3,
    257.5380859375,
    67.2021484375,
    1003.640625,
    90,
    6,
    5555,
    "PD"
  },
  {
    3,
    -1549.9736328125,
    414.0732421875,
    9007.05859375,
    180,
    1,
    1,
    "ARMY"
  },
  {
    3,
    -1555.916015625,
    414.0830078125,
    9007.05859375,
    180,
    1,
    1,
    "ARMY"
  },
  {
    3,
    -1596.7158203125,
    688.994140625,
    8993.5185546875,
    270,
    1,
    1,
    "NAV"
  },
  {
    3,
    257.5361328125,
    67.2685546875,
    1003.640625,
    90,
    6,
    1,
    "NAV"
  },
  {
    3,
    1625.109375, -1504.7294921875, 7498.7670898438,
    -90,
    1,
    1,
    "TEK"
  },
  {
    3,
    1561.6572265625,
    -1709.357421875,
    1994.8203125,
    0,
    1,
    2,
    "NNI"
  }
}
illegalDropoffGroups = {}
for i = 1, #illegalItemNpcs do
  illegalDropoffGroups[illegalItemNpcs[i][8]] = true
end
function checkDutyData3(dat3)
  return dat3 and utf8.sub(tostring(dat3), 1, 4) == "duty"
end
newItemList = {
  [1] = {
    name = "Jármű kulcs",
    description = "Jármű kulcs, a gépjárművedhez",
    keyItem = true
  },
  [2] = {
    name = "Lakás kulcs",
    description = "Lakáskulcs a lakásodhoz",
    keyItem = true
  },
  [3] = {
    name = "Kapu távirányító",
    description = "Távirányító egy kapuhoz",
    keyItem = true
  },
  [4] = {
    name = "Rádió",
    description = "Egy kis walkie-talkie rádió",
    weight = 0.3
  },
  [5] = {
    name = "Megaphone",
    description = "Egy megaphone",
    weight = 0.5,
    use = "megaphone"
  },
  [6] = {
    name = "Hot Dog",
    description = "Egy nagyon ízletes hot-dog",
    weight = 0.25,
    simpleUse = "eat",
    cooldown = 3,
    perishable = 600
  },
  [7] = {
    name = "Hamburger",
    description = "Egy guszta, jól megpakolt hamburger",
    weight = 0.25,
    simpleUse = "eat",
    perishable = 600
  },
  [8] = {
    name = "Kebab",
    description = "Kebab duplaszósszal az élvezet miatt",
    weight = 0.25,
    simpleUse = "eat",
    perishable = 600
  },
  [9] = {
    name = "Telefon",
    description = "Egy okostelefon",
    weight = 0.2,
    use = "mobile"
  },
  [10] = {name = "unused"},
  [11] = {
    name = "Kokacserje mag",
    description = "Mag",
    weight = 0.001,
    stackable = true
  },
  [12] = {
    name = "Mákmag",
    description = "Egy apró magvacska",
    weight = 0.001,
    stackable = true
  },
  [13] = {
    name = "Bibe",
    description = "Marihuana levél",
    weight = 0.001,
    stackable = true
  },
  [14] = {
    name = "Kokalevél",
    description = "Kokain levél",
    weight = 0.001,
    stackable = true
  },
  [15] = {
    name = "Mákszalma",
    description = "Mák levél",
    weight = 0.001,
    stackable = true
  },
  [16] = {
    name = "Szárított marihuana",
    weight = 0.001,
    stackable = true
  },
  [17] = {
    name = "Kokain",
    description = "Tiszta kokain por",
    weight = 0.001,
    stackable = true,
    dose = 3,
    simpleUse = "drug",
    useArg = "coke"
  },
  [18] = {
    name = "Magic Mushroom",
    description = "Varázs gomba",
    weight = 0.001,
    stackable = true,
    simpleUse = "drug",
    useArg = "shroom"
  },
  [19] = {
    name = "Hasis",
    weight = 0.003,
    stackable = true
  },
  [20] = {
    name = "UV Lámpa",
    description = "Speciális, hordozható UV lámpa",
    weight = 0.4,
    stackable = true,
    craftDoNotTake = true
  },
  [21] = {
    name = "Öngyújtó benzin",
    weight = 0.005
  },
  [22] = {
    name = "Akkumulátor sav",
    description = "Ampullányi akkumulátor sav",
    weight = 0.005,
    stackable = true
  },
  [23] = {
    name = "Öngyújtó benzin",
    description = "Öngyújtó utántöltő készlet",
    weight = 0.005,
    stackable = true
  },
  [24] = {
    name = "Kanál",
    description = "Kanál",
    weight = 0.005
  },
  [25] = {name = "unused"},
  [26] = {
    name = "Szódabikarbóna",
    description = "Egy csipetnyi szódabikarbóna",
    weight = 0.001,
    stackable = true
  },
  [27] = {
    name = "Granulátum",
    description = "Egy kevés szerves anyag",
    weight = 0.001,
    stackable = true
  },
  [28] = {
    name = "Cigipapír",
    description = "1db cigipapír",
    weight = 0.001,
    stackable = true
  },
  [29] = {
    name = "Cigipapír (rollni)",
    description = "20db cigipapír dobozkában",
    weight = 0.02,
    stackOfItem = 28,
    stackOfItemCount = 20,
    simpleUse = "stackOfItem"
  },
  [30] = {name = "unused"},
  [31] = {name = "unused"},
  [32] = {name = "unused"},
  [33] = {
    name = "Anyag vas",
    description = "Egy darab vas",
    weight = 0.5,
    stackable = true
  },
  [34] = {
    name = "Kalapács",
    weight = 0.4,
    stackable = true,
    craftDoNotTake = true
  },
  [35] = {name = "unused"},
  [36] = {name = "unused"},
  [37] = {
    name = "Üvegdarab",
    description = "Egy darabka üveg",
    weight = 0.15,
    stackable = true
  },
  [38] = {name = "unused"},
  [39] = {
    name = "Ásványvíz",
    weight = 0.5,
    simpleUse = "drink"
  },
  [40] = {name = "Bor", weight = 0.8},
  [41] = {
    name = "Coca Cola üveges",
    weight = 0.5,
    simpleUse = "drink"
  },
  [42] = {
    name = "Fanta üveges",
    weight = 0.5,
    simpleUse = "drink"
  },
  [43] = {name = "Pálinka", weight = 0.7},
  [44] = {name = "Sör", weight = 0.5},
  [45] = {name = "Whiskey", weight = 0.7},
  [46] = {name = "Vodka", weight = 0.8},
  [47] = {name = "unused"},
  [48] = {name = "unused"},
  [49] = {name = "unused"},
  [50] = {name = "unused"},
  [51] = {name = "unused"},
  [52] = {name = "unused"},
  [53] = {name = "unused"},
  [54] = {name = "unused"},
  [55] = {
    name = "Vizes kanna",
    description = "Egy kis éltető víz",
    weight = 1,
    stackable = true
  },
  [56] = {name = "unused"},
  [57] = {
    name = "Marihuana mag",
    description = "Mag",
    weight = 0.001,
    stackable = true
  },
  [58] = {name = "unused"},
  [59] = {name = "unused"},
  [60] = {name = "unused"},
  [61] = {name = "unused"},
  [62] = {name = "unused"},
  [63] = {name = "unused"},
  [64] = {name = "unused"},
  [65] = {
    name = "Füves cigi",
    description = "Cigi egy kis 'zölddel' spékelve",
    weight = 0.005,
    stackable = true,
    dose = 10,
    simpleUse = "drug",
    useArg = "weed"
  },
  [66] = {name = "unused"},
  [67] = {
    name = "Boxer",
    description = "Kicsit nagyobb pofont lehet vele osztani",
    weight = 0.25
  },
  [68] = {
    name = "Golf ütő",
    description = "Egy szép darab golf ütő",
    weight = 0.5
  },
  [69] = {
    name = "Gumibot",
    description = "Gumibot, tartani a rendet",
    weight = 0.8
  },
  [70] = {
    name = "Kés",
    description = "Egy fegyvernek minősülő kés",
    weight = 0.3
  },
  [71] = {
    name = "Baseball ütő",
    description = "Egy szép darab baseball ütő",
    weight = 1
  },
  [72] = {
    name = "Ásó",
    description = "Egy szép darab ásó",
    weight = 1.5
  },
  [73] = {
    name = "Biliárd dákó",
    description = "Egy hosszú biliárd dákó",
    weight = 0.8
  },
  [74] = {
    name = "Katana",
    description = "Ősi japán ereklye",
    weight = 3
  },
  [75] = {
    name = "Láncfűrész",
    description = "Egy benzines motoros láncfűrész",
    weight = 2
  },
  [76] = {
    name = "Colt 45",
    description = "Egy Colt45-ös",
    weight = 3
  },
  [77] = {
    name = "Hangtompítós Colt 45",
    description = "Egy Colt45-ös hangtompítóval szerelve",
    weight = 3
  },
  [78] = {
    name = "Desert Eagle pisztoly",
    description = "Nagy kaliberű pisztoly",
    weight = 3
  },
  [79] = {
    name = "Remington 870",
    description = "Nagy kaliberű sörétes puska",
    weight = 6
  },
  [80] = {
    name = "Colt 1883 Sawed Off",
    description = "Sörétes puska levágott csővel",
    weight = 6
  },
  [81] = {
    name = "SPAZ-12",
    description = "Taktikai sörétes puska",
    weight = 6
  },
  [82] = {
    name = "UZI",
    description = "Uzi géppisztoly",
    weight = 3
  },
  [83] = {
    name = "MP5",
    description = "MP5-ös fegyver",
    weight = 3
  },
  [84] = {
    name = "TEC-9",
    description = "TEC-9-es gépfegyver",
    weight = 3
  },
  [85] = {
    name = "AK-47",
    description = "AK-47-es gépfegyver",
    weight = 5
  },
  [86] = {
    name = "M4",
    description = "M4-es gépfegyver",
    weight = 5
  },
  [87] = {name = "M14", weight = 6},
  [88] = {
    name = "Dragunov SVD",
    description = "Mesterlövész puska",
    weight = 6
  },
  [89] = {
    name = "Rocket Launcher",
    weight = 1.23
  },
  [90] = {
    name = "Heat-Seeking RPG",
    weight = 1.23
  },
  [91] = {
    name = "Flamethrower",
    weight = 1.23
  },
  [92] = {name = "Minigun", weight = 1.23},
  [93] = {
    name = "Flashbang",
    weight = 0.3,
    stackable = true
  },
  [94] = {
    name = "Füstgránát",
    description = "Taktikai fegyver",
    weight = 0.3,
    stackable = true
  },
  [95] = {
    name = "Molotov koktél",
    weight = 0.7,
    stackable = true
  },
  [96] = {
    name = "Flash táska",
    weight = 0.4
  },
  [97] = {
    name = "Spray kanna",
    weight = 0.3
  },
  [98] = {name = "Poroltó"},
  [99] = {
    name = "Nikon D600",
    description = "Camera",
    weight = 0.3
  },
  [100] = {
    name = "OMSZ Esettáska",
    weight = 1.23,
    simpleUse = "medikit"
  },
  [101] = {name = "Dildo", weight = 1.23},
  [102] = {name = "Bárd", weight = 1},
  [103] = {
    name = "Virágok",
    description = "Egy csokor virág",
    weight = 0.3
  },
  [104] = {
    name = "Sétapálca",
    weight = 0.2
  },
  [105] = {
    name = "Éjjel látó",
    description = "Éjjel látó szemüveg",
    weight = 0.7
  },
  [106] = {
    name = "Infravörös szemüveg",
    weight = 0.7
  },
  [107] = {
    name = "Ejtőernyő",
    weight = 2.23
  },
  [108] = {name = "Detonator", weight = 1.23},
  [109] = {name = "unused"},
  [110] = {name = "unused"},
  [111] = {name = "unused"},
  [112] = {name = "unused"},
  [113] = {name = "unused"},
  [114] = {name = "unused"},
  [115] = {
    name = "Faltörő kos",
    weight = 2,
    stackable = true,
    simpleUse = "doorRam"
  },
  [117] = {
    name = "Maszk",
    weight = 0.2,
    stackable = true
  },
  [118] = {name = "Bilincs", weight = 0.2},
  [119] = {
    name = "Bilincskulcs"
  },
  [120] = {
    name = "Kiváltható fegyverengedély",
    description = "Kiváltható a városházán",
    paperItem = true,
    simpleUse = "tempWeaponLicense"
  },
  [121] = {name = "unused"},
  [122] = {name = "Gázmaszk", weight = 0.5},
  [123] = {name = "unused"},
  [124] = {name = "unused"},
  [125] = {name = "unused"},
  [126] = {
    name = "Kész szendvics",
    weight = 0.02,
    simpleUse = "eat",
    perishable = 600
  },
  [127] = {
    name = "Tablet",
    weight = 0.5,
    use = "groupTablet"
  },
  [128] = {
    name = "Cső és előágy (AK-47)",
    description = "Cső és előágy",
    weight = 0.5,
    stackable = true
  },
  [129] = {
    name = "Előágy felső része (AK-47)",
    description = "Előágy felső része",
    weight = 0.5,
    stackable = true
  },
  [130] = {
    name = "Elsütőszerkezet és tus (AK-47)",
    description = "Elsütőszerkezet és tus",
    weight = 0.5,
    stackable = true
  },
  [131] = {name = "unused"},
  [132] = {
    name = "Tár (AK-47)",
    description = "Tár",
    weight = 0.5,
    stackable = true
  },
  [133] = {name = "unused"},
  [134] = {
    name = "Alsó rész (Colt-45, Glock-17)",
    description = "Alsó rész",
    weight = 0.2,
    stackable = true
  },
  [135] = {
    name = "Felső rész (Colt-45, Glock-17)",
    description = "Felső rész",
    weight = 0.2,
    stackable = true
  },
  [136] = {
    name = "Markolat (Colt-45, Glock-17)",
    description = "Markolat",
    weight = 0.2,
    stackable = true
  },
  [137] = {
    name = "Ravasz (AK-47, Colt-45, Glock-17, TEC-9, UZI, M14)",
    description = "Ravasz",
    weight = 0.2,
    stackable = true
  },
  [138] = {
    name = "Tár (Colt-45, Glock-17)",
    description = "Tár",
    weight = 0.2,
    stackable = true
  },
  [139] = {
    name = "Cső (Colt-45, Glock-17)",
    description = "Cső",
    weight = 0.5,
    stackable = true
  },
  [140] = {
    name = "Pumpáló (Remington 870)",
    description = "Pumpáló",
    weight = 0.5,
    stackable = true
  },
  [141] = {
    name = "Ravasz és tok (Remington 870)",
    description = "Ravasz és tok",
    weight = 0.5,
    stackable = true
  },
  [142] = {
    name = "Tus (Remington 870)",
    description = "Tus",
    weight = 0.5,
    stackable = true
  },
  [143] = {
    name = "Cső (M14)",
    description = "Cső",
    weight = 0.5,
    stackable = true
  },
  [144] = {name = "unused"},
  [145] = {
    name = "Tok (M14)",
    description = "Tok",
    weight = 0.5,
    stackable = true
  },
  [146] = {
    name = "Tus (M14)",
    description = "Tus",
    weight = 0.5,
    stackable = true
  },
  [147] = {
    name = "Zsemle",
    weight = 0.05,
    simpleUse = "eat",
    perishable = 600
  },
  [148] = {
    name = "Gyógyszer",
    description = "Életmentő kapszula",
    weight = 0.001,
    perishable = 2000,
    simpleUse = "medicine"
  },
  [149] = {
    name = "Vitamin",
    description = "Fő az egészség",
    weight = 0.001,
    perishable = 2000,
    simpleUse = "vitamin"
  },
  [150] = {
    name = "HI-FI",
    description = "HI-FI rendszer",
    weight = 1.3,
    simpleUse = "hifi",
    useArg = 2103
  },
  [151] = {
    name = "Festék patron",
    description = "Festék patron fújós spayekhez",
    weight = 0.001,
    stackable = true
  },
  [152] = {
    name = "Hobby fa",
    weight = 1.12,
    stackable = true
  },
  [153] = {
    name = "Eü. doboz",
    description = "Egészségügyi doboz",
    weight = 0.25,
    stackable = true,
    simpleUse = "medikit"
  },
  [154] = {
    name = "Széf kulcs",
    keyItem = true
  },
  [155] = {
    name = "Sokkoló",
    description = "Sokkoló pisztoly",
    weight = 0.45,
    serial = "TAZ"
  },
  [156] = {
    name = "Ajándék",
    description = "Ajándék, tele meglepetésekkel",
    simpleUse = "santaPresent"
  },
  [157] = {
    name = "Ünnepi süti",
    description = "Csak egy harapás és minden jobb lesz",
    weight = 0.25,
    simpleUse = "santaCookie"
  },
  [158] = {
    name = "Aranyrúd",
    description = "Tömör aranyrúd, add el mihamarabb",
    weight = 0.5
  },
  [159] = {name = "unused"},
  [160] = {
    name = "Jutalomfalat",
    description = "Melyik kutya ne szeretné?",
    weight = 0.01,
    stackable = true
  },
  [161] = {
    name = "Kutyatáp",
    description = "Finom, ízletes kutyakaja",
    weight = 0.01,
    stackable = true
  },
  [162] = {
    name = "Kutyasnack",
    description = "A kutyák Snickers-e",
    weight = 0.01,
    stackable = true
  },
  [163] = {
    name = "PPSnack",
    description = "Prémium jutalomfalat",
    weight = 0.01,
    stackable = true
  },
  [164] = {
    name = "Csákány",
    weight = 1.7,
    use = "pickaxe",
    useArg = ""
  },
  [165] = {
    name = "Kisebb petárda",
    description = "Egy petárda, mely a szilveszter már már hagyományos kelléke",
    weight = 0.005,
    stackable = true,
    simpleUse = "fireCracker",
    useArg = "small"
  },
  [166] = {
    name = "Nagyobb petárda",
    description = "Egy petárda, mely a szilveszter már már hagyományos kelléke",
    weight = 0.005,
    stackable = true,
    simpleUse = "fireCracker",
    useArg = "large"
  },
  [167] = {
    name = "Magyaros Pizza",
    weight = 0.3,
    simpleUse = "eat",
    perishable = 600
  },
  [168] = {
    name = "Mozerella Pizza",
    weight = 0.3,
    simpleUse = "eat",
    perishable = 600
  },
  [169] = {
    name = "Bolognese Pizza",
    weight = 0.3,
    simpleUse = "eat",
    perishable = 600
  },
  [170] = {
    name = "Spaghetti Bolognese",
    weight = 0.3,
    simpleUse = "eat",
    perishable = 600
  },
  [171] = {
    name = "Spaghetti Carbonara",
    weight = 0.3,
    simpleUse = "eat",
    perishable = 600
  },
  [172] = {
    name = "Lasagne",
    weight = 0.3,
    simpleUse = "eat",
    perishable = 600
  },
  [173] = {
    name = "Dürüm",
    weight = 0.2,
    simpleUse = "eat",
    perishable = 600
  },
  [174] = {
    name = "Baklava",
    weight = 0.2,
    simpleUse = "eat",
    perishable = 600
  },
  [175] = {
    name = "Tacos",
    weight = 0.2,
    simpleUse = "eat",
    perishable = 600
  },
  [176] = {
    name = "Burritos",
    weight = 0.2,
    simpleUse = "eat",
    perishable = 600
  },
  [177] = {
    name = "Quesadilla",
    weight = 0.2,
    simpleUse = "eat",
    perishable = 600
  },
  [178] = {
    name = "Fajitas",
    weight = 0.2,
    simpleUse = "eat",
    perishable = 600
  },
  [179] = {
    name = "Sajtos Hamburger",
    weight = 0.2,
    simpleUse = "eat",
    perishable = 600
  },
  [180] = {
    name = "Dupla húsos hamburger",
    weight = 0.2,
    simpleUse = "eat",
    perishable = 600
  },
  [181] = {
    name = "Sültkrumpli",
    weight = 0.2,
    simpleUse = "eat",
    perishable = 600
  },
  [182] = {
    name = "Presso Caffe",
    weight = 0.2,
    simpleUse = "drink"
  },
  [183] = {
    name = "Capucino",
    weight = 0.2,
    simpleUse = "drink"
  },
  [184] = {
    name = "Cafe Latte",
    weight = 0.2,
    simpleUse = "drink"
  },
  [185] = {
    name = "Fórró csoki",
    weight = 0.2,
    simpleUse = "drink"
  },
  [186] = {
    name = "Coca Cola dobozos",
    weight = 0.2,
    simpleUse = "drink"
  },
  [187] = {name = "unused"},
  [188] = {
    name = "Karosszéria javító kártya",
    stackable = true,
    tooltip = "* Teljes javítást végez a jármű összes karosszéria (külső) elemén\n* Kicseréli a rádiós fejegységet\n* Gyári minőségü alkatrészek (OEM)",
    simpleUse = "fixVeh",
    useArg = "chassis"
  },
  [189] = {
    name = "Instant Üzemanyag Kártya",
    description = "Megtankolja az autód",
    stackable = true,
    simpleUse = "fuelVeh"
  },
  [190] = {
    name = "Instant Gyógyítás",
    description = "Meggyógyítja sérüléseid",
    stackable = true,
    simpleUse = "instantHeal"
  },
  [191] = {name = "unused"},
  [192] = {name = "unused"},
  [193] = {
    name = "Bónusz tojás",
    stackable = true,
    simpleUse = "ogBonusEgg"
  },
  [194] = {
    name = "Speciális locsoló kölni",
    description = "Exkluzív termék",
    stackable = true
  },
  [195] = {
    name = "Hagyományos locsoló kölni",
    description = "Olcsó és meglehetősen büdös kölni"
  },
  [196] = {
    name = "Igazi piros tojás",
    description = "Ritka mint a fehér holló",
    stackable = true
  },
  [197] = {
    name = "A tökéletes sonka receptje",
    description = "Több száz éves titok",
    stackable = true
  },
  [198] = {name = "unused"},
  [199] = {name = "unused"},
  [200] = {name = "unused"},
  [201] = {name = "unused"},
  [202] = {name = "unused"},
  [203] = {name = "unused"},
  [204] = {name = "Dobókocka", simpleUse = "dice"},
  [205] = {
    name = "Kártyapakli",
    simpleUse = "cards"
  },
  [206] = {
    name = "Jelvény",
    paperItem = true,
    secondaryUse = "badge"
  },
  [207] = {
    name = "Személyazonosító igazolvány",
    description = "Személyi",
    paperItem = true,
    use = "license",
    useArg = "id"
  },
  [208] = {
    name = "Vezetői engedély",
    description = "Jogosítvány",
    paperItem = true,
    use = "license",
    useArg = "dl"
  },
  [209] = {name = "unused"},
  [210] = {
    name = "Karácsonyfa",
    description = "Egy díszes karácsonyfa"
  },
  [211] = {name = "unused", weight = 1},
  [212] = {
    name = "unused",
    weight = 0.01,
    stackable = true
  },
  [213] = {
    name = "Csali és úszó",
    description = "Csali és úszó szett",
    weight = 0.1,
    stackable = true
  },
  [214] = {
    name = "Horog",
    description = "Egy hegyes horog",
    weight = 0.01,
    stackable = true
  },
  [215] = {name = "unused", weight = 1.1},
  [216] = {name = "Fűrész", weight = 1},
  [217] = {
    name = "Bakancs",
    description = "Egy büdös bakancs",
    weight = 1
  },
  [218] = {
    name = "Hínár",
    description = "Tenyérnyi csúszós maszat",
    weight = 0.1
  },
  [219] = {
    name = "Döglött hal",
    description = "Evésre kevésbé alkalmas hal"
  },
  [220] = {
    name = "Konzervdoboz",
    description = "Üres konzervdoboz",
    weight = 0.3
  },
  [221] = {
    name = "Ismeretlen hal",
    description = "Senki se tudja mi ez, de aranyat ér",
    weight = 2,
    perishable = 360,
    perishableEvent = "fishPerishableEvent"
  },
  [222] = {
    name = "Cápa",
    description = "Bébicápa",
    weight = 7.5,
    perishable = 360,
    perishableEvent = "fishPerishableEvent"
  },
  [223] = {
    name = "Polip",
    weight = 2,
    perishable = 360,
    perishableEvent = "fishPerishableEvent"
  },
  [224] = {
    name = "Ördöghal",
    weight = 2,
    perishable = 360,
    perishableEvent = "fishPerishableEvent"
  },
  [225] = {
    name = "Kardhal",
    weight = 3,
    perishable = 360,
    perishableEvent = "fishPerishableEvent"
  },
  [226] = {
    name = "Szamuráj rák",
    weight = 0.5,
    perishable = 360,
    perishableEvent = "fishPerishableEvent"
  },
  [227] = {
    name = "Lepényhal",
    weight = 1,
    perishable = 360,
    perishableEvent = "fishPerishableEvent"
  },
  [228] = {
    name = "Sügér",
    weight = 2,
    perishable = 360,
    perishableEvent = "fishPerishableEvent"
  },
  [229] = {
    name = "Harcsa",
    weight = 2,
    perishable = 360,
    perishableEvent = "fishPerishableEvent"
  },
  [230] = {
    name = "Ponty",
    weight = 2,
    perishable = 360,
    perishableEvent = "fishPerishableEvent"
  },
  [231] = {
    name = "Tengericsillag",
    weight = 0.2,
    perishable = 360,
    perishableEvent = "fishPerishableEvent"
  },
  [232] = {name = "unused"},
  [233] = {
    name = "Extasy",
    description = "Extasy tabletta",
    weight = 0.001,
    stackable = true,
    simpleUse = "drug",
    useArg = "ex"
  },
  [234] = {
    name = "A fegyvermester: Colt-45"
  },
  [235] = {
    name = "A fegyvermester: A hangtompítós Colt-45"
  },
  [236] = {
    name = "A fegyvermester: Desert Eagle"
  },
  [237] = {
    name = "A fegyvermester: TEC-9"
  },
  [238] = {
    name = "A fegyvermester: MP5"
  },
  [239] = {
    name = "A fegyvermester: AK-47"
  },
  [240] = {
    name = "A fegyvermester: M4"
  },
  [241] = {
    name = "A fegyvermester: M14"
  },
  [242] = {
    name = "A fegyvermester: Remington 870"
  },
  [243] = {
    name = "A fegyvermester: SPAZ-12"
  },
  [244] = {
    name = "A fegyvermester: Colt 1883 Sawed Off"
  },
  [245] = {
    name = "Flex",
    description = "Egy flex",
    weight = 1,
    craftDoNotTake = true,
    use = "flex"
  },
  [246] = {
    name = "Púpos horgászhal",
    weight = 1,
    perishable = 360,
    perishableEvent = "fishPerishableEvent"
  },
  [247] = {
    name = "Láda",
    weight = 2,
    simpleUse = "fishingChest"
  },
  [248] = {
    name = "Rák",
    weight = 0.5,
    perishable = 360,
    perishableEvent = "fishPerishableEvent"
  },
  [249] = {
    name = "Szakadt halászháló",
    weight = 0.5
  },
  [250] = {
    name = "Óriáspolip",
    weight = 5,
    perishable = 360,
    perishableEvent = "fishPerishableEvent"
  },
  [251] = {
    name = "Pörölycápa",
    weight = 4,
    perishable = 360,
    perishableEvent = "fishPerishableEvent"
  },
  [252] = {
    name = "Koi ponty",
    weight = 2,
    perishable = 360,
    perishableEvent = "fishPerishableEvent"
  },
  [253] = {
    name = "Antik törzsi maszk",
    weight = 2
  },
  [254] = {
    name = "Antik szobor",
    weight = 2
  },
  [255] = {
    name = "Piranha",
    weight = 0.5,
    perishable = 360,
    perishableEvent = "fishPerishableEvent"
  },
  [256] = {
    name = "Gömbhal",
    weight = 0.5,
    perishable = 360,
    perishableEvent = "fishPerishableEvent"
  },
  [257] = {
    name = "Rozsdás vödör",
    weight = 0.5
  },
  [258] = {
    name = "Törött deszka",
    weight = 1
  },
  [259] = {
    name = "Cápafog nyaklánc",
    weight = 0.1
  },
  [260] = {name = "Koponya", weight = 2},
  [261] = {
    name = "Teknős",
    weight = 2,
    perishable = 360,
    perishableEvent = "fishPerishableEvent"
  },
  [262] = {name = "Autóbomba", weight = 5},
  [263] = {
    name = "Méreg Injekció",
    weight = 0.1
  },
  [264] = {name = "unused"},
  [265] = {
    name = "Winter AK-47",
    description = "Winter Camo AK-47",
    weight = 5
  },
  [266] = {
    name = "Camo AK-47",
    description = "Terep mintás AK-47 2",
    weight = 5
  },
  [267] = {
    name = "Digit AK-47",
    description = "Digit camo AK-47",
    weight = 5
  },
  [268] = {
    name = "Gold AK-47",
    description = "Arany AK-47 ver. 1",
    weight = 5
  },
  [269] = {
    name = "Gold AK-47",
    description = "Arany AK-47 ver. 2",
    weight = 5
  },
  [270] = {
    name = "Silver AK-47",
    description = "Ezüst AK-47-es",
    weight = 5
  },
  [271] = {
    name = "Hello AK-47",
    description = "Pink Camo AK-47",
    weight = 5
  },
  [272] = {
    name = "Camo Desert Eagle",
    description = "Terep mintás Desert Eagle",
    weight = 3
  },
  [273] = {
    name = "Gold Desert Eagle",
    description = "Arany Desert Eagle",
    weight = 3
  },
  [274] = {
    name = "Winter Dragunov PSL",
    description = "Winter Camo Dragunov PSL",
    weight = 6
  },
  [275] = {
    name = "Camo Dragunov PSL",
    weight = 6
  },
  [276] = {
    name = "Camo MP5",
    description = "Camo MP5-ös fegyver",
    weight = 3
  },
  [277] = {
    name = "Gold MP5",
    description = "Gold MP5-ös fegyver",
    weight = 3
  },
  [278] = {
    name = "Hotline Miami MP5",
    description = "Hotline Miami MP5-ös fegyver",
    weight = 3
  },
  [279] = {
    name = "Winter MP5",
    description = "Winter MP5-ös fegyver",
    weight = 3
  },
  [280] = {
    name = "Camo knife",
    description = "Terep mintás kés",
    weight = 0.3
  },
  [281] = {
    name = "Rust knife",
    description = "Rozsdás kés",
    weight = 0.3
  },
  [282] = {
    name = "Carbon knife",
    description = "Carbonból készült kés",
    weight = 0.3
  },
  [283] = {
    name = "Bronze TEC-9",
    description = "Bronz TEC-9-es",
    weight = 3
  },
  [284] = {
    name = "Camo TEC-9",
    description = "Terep mintás TEC-9",
    weight = 3
  },
  [285] = {
    name = "Gold TEC-9",
    description = "Arany TEC-9-es",
    weight = 3
  },
  [286] = {
    name = "Winter TEC-9",
    description = "Winter style TEC-9",
    weight = 3
  },
  [287] = {
    name = "OBD scanner",
    weight = 0.8,
    use = "obd"
  },
  [288] = {
    name = "Műszaki adatlap",
    paperItem = true,
    simpleUse = "trafficLicenseEx"
  },
  [289] = {
    name = "Forgalmi engedély",
    paperItem = true,
    use = "trafficLicense"
  },
  [290] = {name = "unused"},
  [291] = {
    name = "Villogó",
    weight = 0.8,
    simpleUse = "siren"
  },
  [292] = {
    name = "Villogó (Levétel)",
    description = "Villogó",
    weight = 0.8,
    simpleUse = "siren"
  },
  [293] = {name = "unused"},
  [294] = {name = "unused"},
  [295] = {name = "unused"},
  [296] = {name = "unused"},
  [297] = {
    name = "Tüzijáték",
    weight = 0.25,
    simpleUse = "firework",
    useArg = 1
  },
  [298] = {
    name = "Tüzijáték 2",
    weight = 0.25,
    simpleUse = "firework",
    useArg = 2
  },
  [299] = {
    name = "Blueprint",
    paperItem = true,
    simpleUse = "blueprint"
  },
  [300] = {name = "unused", stackable = true},
  [301] = {
    name = "Markolat (Kés)",
    description = "Markolat",
    weight = 0.15,
    stackable = true
  },
  [302] = {
    name = "Penge (Kés)",
    description = "Penge",
    weight = 0.15,
    stackable = true
  },
  [303] = {
    name = "Tár (UZI, TEC-9)",
    description = "Tár",
    weight = 1.1,
    stackable = true
  },
  [304] = {
    name = "Markolat (UZI, TEC-9)",
    description = "Markolat",
    weight = 1.1,
    stackable = true
  },
  [305] = {
    name = "Cső (UZI)",
    description = "Cső",
    weight = 1.1,
    stackable = true
  },
  [306] = {
    name = "Felső rész (UZI)",
    description = "Felső rész",
    weight = 1.1,
    stackable = true
  },
  [307] = {
    name = "Felső rész (TEC-9)",
    description = "Felső rész",
    weight = 1.1,
    stackable = true
  },
  [308] = {
    name = "Fegyverviselési engedély",
    description = "Fegyverengedély",
    paperItem = true,
    use = "license",
    useArg = "wp"
  },
  [309] = {
    name = "Jármű adásvételi szerződés",
    description = "Adásvételi szerződés",
    paperItem = true,
    use = "vehicleSellPaper"
  },
  [310] = {
    name = "Horgászengedély",
    paperItem = true,
    use = "license",
    useArg = "fs"
  },
  [311] = {
    name = "Üres adásvételi",
    paperItem = true
  },
  [312] = {name = "Toll", weight = 0.01},
  [313] = {
    name = "Csekk",
    paperItem = true,
    simpleUse = "ticket"
  },
  [314] = {
    name = "Csekkfüzet",
    paperItem = true,
    simpleUse = "ticketBook"
  },
  [315] = {
    name = "Névcédula",
    use = "nametag"
  },
  [316] = {
    name = "Taxi lámpa",
    weight = 1,
    simpleUse = "taxilamp"
  },
  [317] = {
    name = "Taxi lámpa (levétel)",
    weight = 1,
    simpleUse = "taxilamp"
  },
  [318] = {
    name = "Távirányítós autóbomba",
    weight = 3,
    stackable = true
  },
  [319] = {name = "unused", weight = 0.5},
  [320] = {name = "unused"},
  [321] = {name = "unused"},
  [322] = {name = "unused"},
  [323] = {name = "unused"},
  [324] = {name = "unused"},
  [325] = {name = "unused"},
  [326] = {name = "unused"},
  [327] = {name = "unused"},
  [328] = {name = "unused"},
  [329] = {name = "unused"},
  [330] = {name = "unused"},
  [331] = {name = "unused"},
  [332] = {name = "unused"},
  [333] = {name = "unused"},
  [334] = {name = "unused"},
  [335] = {name = "unused"},
  [336] = {name = "unused"},
  [337] = {name = "unused"},
  [338] = {name = "Zseblámpa", weight = 0.05},
  [339] = {name = "unused"},
  [340] = {
    name = "No Limit P90",
    description = "No Limit P90-ös fegyver",
    weight = 3
  },
  [341] = {
    name = "Oni P90",
    description = "Oni P90-ös fegyver",
    weight = 3
  },
  [342] = {
    name = "Black Remington 870",
    description = "Nagy kaliberű Remington 870",
    weight = 6
  },
  [343] = {
    name = "Black Remington 870",
    description = "Nagy kaliberű Remington 870",
    weight = 6
  },
  [344] = {
    name = "Gold Remington 870",
    description = "Nagy kaliberű Remington 870",
    weight = 6
  },
  [345] = {
    name = "Rust Remington 870",
    description = "Nagy kaliberű Remington 870",
    weight = 6
  },
  [346] = {
    name = "Carbon P90",
    description = "Carbon P90-ös fegyver",
    weight = 3
  },
  [347] = {
    name = "Wooden P90",
    description = "Wooden P90-ös fegyver",
    weight = 3
  },
  [348] = {
    name = "Nike: A nagy bumm",
    description = "Egy stílusos táska, ami egy bombát tartalmaz",
    weight = 1.5
  },
  [349] = {
    name = "Nike detonátor",
    description = "Magától értetődő mit tud",
    weight = 0.1
  },
  [350] = {
    name = "Egy 'Ferrari 250 GTO' kulcsa"
  },
  [351] = {name = "Barracuda", weight = 2.5},
  [352] = {name = "Mahi Mahi", weight = 3},
  [353] = {name = "Makréla", weight = 1.5},
  [354] = {name = "Pávahal", weight = 2},
  [355] = {name = "Rája", weight = 4},
  [356] = {
    name = "Piros Snapper",
    weight = 1
  },
  [357] = {name = "Kakashal", weight = 3},
  [358] = {
    name = "Szakadt damil",
    weight = 0.1
  },
  [359] = {
    name = "Kék tonhal",
    weight = 3
  },
  [360] = {name = "Viperahal", weight = 1},
  [361] = {
    name = "Pénzkazetta",
    weight = 2,
    crateItem = "atm",
    serial = "CAS"
  },
  [362] = {
    name = "Véső",
    weight = 0.5,
    stackable = true
  },
  [363] = {
    name = "Kakashal (verseny)",
    weight = 1
  },
  [364] = {name = "unused"},
  [365] = {name = "unused"},
  [366] = {name = "unused"},
  [367] = {name = "unused"},
  [368] = {
    name = "Tök",
    weight = 2,
    simpleUse = "halloweenPumpkin"
  },
  [369] = {
    name = "Halloween P90",
    description = "P90-es fegyver",
    weight = 3
  },
  [370] = {
    name = "Tombola",
    description = "Tembola",
    use = "raffle",
    paperItem = true
  },
  [371] = {name = "unused"},
  [372] = {
    name = "Kötszer",
    weight = 0.1,
    simpleUse = "bandage"
  },
  [373] = {
    name = "Üres kanna",
    weight = 0.25,
    simpleUse = "emptyCan"
  },
  [374] = {
    name = "Rohadt növény",
    weight = 0.3,
    stackable = true
  },
  [375] = {
    name = "TV Paprika",
    description = "Termés",
    weight = 0.125,
    stackable = true
  },
  [376] = {
    name = "Almapaprika",
    description = "Termés",
    weight = 0.1,
    stackable = true
  },
  [377] = {
    name = "Chili",
    description = "Termés",
    weight = 0.05,
    stackable = true
  },
  [378] = {
    name = "Vöröshagyma",
    description = "Termés",
    weight = 0.05,
    stackable = true
  },
  [379] = {
    name = "Lilahagyma",
    description = "Termés",
    weight = 0.05,
    stackable = true
  },
  [380] = {
    name = "Sütőtök",
    description = "Termés",
    weight = 2,
    stackable = true
  },
  [381] = {
    name = "Sárgadinnye",
    description = "Termés",
    weight = 1,
    stackable = true
  },
  [382] = {
    name = "Görögdinnye",
    description = "Termés",
    weight = 4,
    stackable = true
  },
  [383] = {
    name = "Saláta",
    description = "Termés",
    weight = 0.5,
    stackable = true
  },
  [384] = {
    name = "Retek",
    description = "Termés",
    weight = 0.06,
    stackable = true
  },
  [385] = {
    name = "Sárgarépa",
    description = "Termés",
    weight = 0.06,
    stackable = true
  },
  [386] = {
    name = "Petrezselyem",
    description = "Termés",
    weight = 0.05,
    stackable = true
  },
  [387] = {
    name = "Karalábé",
    description = "Termés",
    weight = 0.35,
    stackable = true
  },
  [388] = {
    name = "Káposzta",
    description = "Termés",
    weight = 1,
    stackable = true
  },
  [389] = {
    name = "Uborka",
    description = "Termés",
    weight = 0.1,
    stackable = true
  },
  [390] = {
    name = "Vetőmag: TV Paprika",
    description = "Vetőmag",
    weight = 0.1,
    stackable = true
  },
  [391] = {
    name = "Vetőmag: Almapaprika",
    description = "Vetőmag",
    weight = 0.1,
    stackable = true
  },
  [392] = {
    name = "Vetőmag: Chili",
    description = "Vetőmag",
    weight = 0.1,
    stackable = true
  },
  [393] = {
    name = "Dughagyma: Vöröshagyma",
    description = "Dughagyma",
    weight = 0.1,
    stackable = true
  },
  [394] = {
    name = "Dughagyma: Lilahagyma",
    description = "Dughagyma",
    weight = 0.1,
    stackable = true
  },
  [395] = {
    name = "Vetőmag: Sütőtök",
    description = "Vetőmag",
    weight = 0.1,
    stackable = true
  },
  [396] = {
    name = "Vetőmag: Sárgadinnye",
    description = "Vetőmag",
    weight = 0.1,
    stackable = true
  },
  [397] = {
    name = "Vetőmag: Görögdinnye",
    description = "Vetőmag",
    weight = 0.1,
    stackable = true
  },
  [398] = {
    name = "Vetőmag: Saláta",
    description = "Vetőmag",
    weight = 0.1,
    stackable = true
  },
  [399] = {
    name = "Vetőmag: Retek",
    description = "Vetőmag",
    weight = 0.1,
    stackable = true
  },
  [400] = {
    name = "Vetőmag: Sárgarépa",
    description = "Vetőmag",
    weight = 0.1,
    stackable = true
  },
  [401] = {
    name = "Vetőmag: Petrezselyem",
    description = "Vetőmag",
    weight = 0.1,
    stackable = true
  },
  [402] = {
    name = "Vetőmag: Karalábé",
    description = "Vetőmag",
    weight = 0.1,
    stackable = true
  },
  [403] = {
    name = "Vetőmag: Káposzta",
    description = "Vetőmag",
    weight = 0.1,
    stackable = true
  },
  [404] = {
    name = "Vetőmag: Uborka",
    description = "Vetőmag",
    weight = 0.1,
    stackable = true
  },
  [405] = {
    name = "Prémium növénytápszer",
    weight = 0.1,
    stackable = true
  },
  [406] = {
    name = "Fegyverjavító kártya",
    description = "Csak skines fegyverhez!"
  },
  [407] = {
    name = "Tiger knife",
    description = "Tigris mintás kés",
    weight = 0.3
  },
  [408] = {
    name = "Digit knife",
    description = "Digit camo mintás kés",
    weight = 0.3
  },
  [409] = {
    name = "Spider knife",
    description = "Spider camo mintás kés",
    weight = 0.3
  },
  [410] = {
    name = "Damascus bárd",
    weight = 1
  },
  [411] = {name = "Rust bárd", weight = 1},
  [412] = {name = "unused"},
  [413] = {name = "Szonda"},
  [414] = {
    name = "Hello Desert Eagle",
    description = "Hello Kitty mintás Desert Eagle pisztoly",
    weight = 3
  },
  [415] = {
    name = "Bónusztojás",
    simpleUse = "bonusEgg"
  },
  [416] = {
    name = "Csokitojás",
    stackable = true,
    simpleUse = "chocoEggs"
  },
  [417] = {
    name = "Záptojás",
    stackable = true,
    simpleUse = "rottenEggs"
  },
  [418] = {
    name = "A BMW M8 kulcsa"
  },
  [419] = {
    name = "Üres kölni"
  },
  [420] = {
    name = "Monster energiaital",
    description = "Egészségtelen lötty",
    weight = 0.5,
    simpleUse = "drink"
  },
  [421] = {
    name = "RedBull energiaital",
    description = "Egészségtelen lötty",
    weight = 0.25,
    simpleUse = "drink"
  },
  [422] = {
    name = "Hell energiaital",
    description = "Egészségtelen lötty",
    weight = 0.25,
    simpleUse = "drink"
  },
  [423] = {
    name = "Háziállat átnevező kártya",
    description = "Segítségével átnevezheted háziállatod",
    stackable = true
  },
  [424] = {name = "unused"},
  [425] = {name = "unused"},
  [426] = {name = "Balta", weight = 1.23},
  [427] = {
    name = "Lezáró cédula",
    description = "NAV Lezáró cédula"
  },
  [428] = {
    name = "Parazen mag",
    description = "Mag",
    weight = 0.001,
    stackable = true
  },
  [429] = {
    name = "SHTG tápoldat",
    description = "See How They Grow :)",
    weight = 1,
    stackable = true
  },
  [430] = {
    name = "SHTG tápoldat koncentrátum",
    description = "See How They Grow :)",
    weight = 0.1
  },
  [431] = {
    name = "Parazeldum por",
    description = "Tiszta parazeldum por",
    weight = 0.001,
    stackable = true,
    dose = 3,
    simpleUse = "drug",
    useArg = "para"
  },
  [432] = {
    name = "Parazen virág",
    weight = 0.001,
    stackable = true
  },
  [433] = {name = "Bronze UZI", weight = 3},
  [434] = {name = "Camo UZI", weight = 3},
  [435] = {name = "Gold UZI", weight = 3},
  [436] = {name = "Winter UZI", weight = 3},
  [437] = {
    name = "Mozijegy",
    description = "Jegy, ami SIGHTNEMA moziba szól",
    paperItem = true,
    use = "cinemaTicket"
  },
  [438] = {
    name = "SightDyno eredmény",
    description = "Ez egy kibaszott mérés",
    paperItem = true,
    use = "seedyno"
  },
  [439] = {
    name = "Szerviz számla",
    paperItem = true,
    use = "serviceInvoice"
  },
  [440] = {
    name = "Akkumulátoros csavarbehajtó",
    weight = 0.6,
    use = "wrench"
  },
  [441] = {
    name = "Bikakábel",
    weight = 1.25,
    use = "jumperCable"
  },
  [442] = {
    name = "Interior adásvételi szerződés",
    description = "Adásvételi szerződés",
    paperItem = true,
    use = "interiorSellPaper"
  },
  [443] = {
    name = "Névkitűző",
    paperItem = true,
    secondaryUse = "badge",
    useArg = true
  },
  [444] = {
    name = "LSD",
    description = "LSD bélyeg",
    weight = 0.002,
    stackable = true,
    simpleUse = "drug",
    useArg = "lsd"
  },
  [445] = {
    name = "Speed",
    description = "Speed por",
    weight = 0.001,
    stackable = true,
    dose = 3,
    simpleUse = "drug",
    useArg = "speed"
  },
  [446] = {
    name = "Fémdetektor",
    description = "Vinnyog a fímre",
    weight = 2,
    use = "metaldetector"
  },
  [447] = {
    name = "Lombik",
    weight = 0.5,
    stackable = true,
    craftDoNotTake = true
  },
  [448] = {
    name = "Magic Mushroom spóra",
    weight = 0.001,
    stackable = true
  },
  [449] = {
    name = "Nyers metamfetamin",
    weight = 0.001,
    stackable = true
  },
  [450] = {
    name = "Lizergsav",
    weight = 5.0E-4,
    stackable = true
  },
  [451] = {
    name = "Nyers gomba",
    weight = 0.05,
    stackable = true
  },
  [452] = {
    name = "Dietil-amin",
    weight = 5.0E-4,
    stackable = true
  },
  [453] = {
    name = "Bélyeg",
    weight = 0.001,
    stackable = true
  },
  [454] = {
    name = "Nyers amfetamin",
    weight = 0.001,
    stackable = true
  },
  [455] = {
    name = "Láda (Drog hozzávalók)",
    description = "Láda",
    weight = 1,
    crateItem = "drug_parts"
  },
  [456] = {
    name = "Láda (Lőszer)",
    description = "Láda",
    weight = 1,
    crateItem = "ammo"
  },
  [457] = {
    name = "Láda (Fegyver)",
    description = "Láda",
    weight = 1,
    crateItem = "weapon"
  },
  [458] = {
    name = "Láda (Fegyver alkatrész)",
    description = "Láda",
    weight = 1,
    crateItem = "weapon_parts"
  },
  [459] = {
    name = "Láda (Drog)",
    description = "Láda",
    weight = 1,
    crateItem = "drug"
  },
  [460] = {
    name = "Arany óra",
    description = "Fődes lút",
    weight = 0.15
  },
  [461] = {
    name = "Üres háborús lőszer",
    description = "Fődes lút",
    weight = 1.5,
    powderItem = true,
    use = true,
  },
  [462] = {
    name = "Antik étkészlet",
    description = "Fődes lút",
    weight = 0.75
  },
  [463] = {
    name = "Kehely",
    description = "Fődes lút",
    weight = 0.5
  },
  [464] = {
    name = "Kereszt",
    description = "Fődes lút",
    weight = 0.125
  },
  [465] = {
    name = "Aranylánc",
    description = "Fődes lút",
    weight = 0.05
  },
  [466] = {
    name = "Aranymedál",
    description = "Fődes lút",
    weight = 0.25
  },
  [467] = {
    name = "Antik pénz",
    description = "Fődes lút",
    weight = 0.01
  },
  [468] = {
    name = "Antik tányér",
    description = "Fődes lút",
    weight = 0.5
  },
  [469] = {
    name = "Üdítős doboz",
    description = "Fődes lút",
    weight = 0.01
  },
  [470] = {
    name = "Lángvágó",
    description = "Blótorcs",
    weight = 1,
    use = "blowtorch"
  },
  [471] = {name = "Colt 1911", weight = 3},
  [472] = {
    name = "Black Colt 1911",
    weight = 3
  },
  [473] = {
    name = "Engraved Colt 1911",
    weight = 3
  },
  [474] = {
    name = "Gold Colt 1911",
    weight = 3
  },
  [475] = {name = "AK-74", weight = 5},
  [476] = {name = "AK-74M", weight = 5},
  [477] = {name = "Plum AK-74", weight = 5},
  [478] = {name = "Gold AK-74", weight = 5},
  [479] = {
    name = "Engraved Gold AK-74",
    weight = 5
  },
  [480] = {name = "AR-15", weight = 5},
  [481] = {name = "Tan AR-15", weight = 5},
  [482] = {
    name = "Olive AR-15",
    weight = 5
  },
  [483] = {
    name = "AR-15 + Aimpoint",
    weight = 5
  },
  [484] = {
    name = "Tan AR-15 + Aimpoint",
    weight = 5
  },
  [485] = {
    name = "Olive AR-15 + Aimpoint",
    weight = 5
  },
  [486] = {
    name = "AR-15 + HOLO",
    weight = 5
  },
  [487] = {
    name = "Tan AR-15 + HOLO",
    weight = 5
  },
  [488] = {
    name = "Olive AR-15 + HOLO",
    weight = 5
  },
  [489] = {name = "Benelli M4", weight = 5},
  [490] = {
    name = "Tan Benelli M4",
    weight = 5
  },
  [491] = {
    name = "SC Tactical Benelli M4",
    weight = 5
  },
  [492] = {
    name = "Micro Draco",
    weight = 3
  },
  [493] = {name = "Glock 19", weight = 3},
  [494] = {
    name = "Silver Glock 19",
    weight = 3
  },
  [495] = {
    name = "Tan Glock 19",
    weight = 3
  },
  [496] = {
    name = "Tiffany Blue Glock 19",
    weight = 3
  },
  [497] = {
    name = "Victoria Pink Glock 19",
    weight = 3
  },
  [498] = {
    name = "SC-Tactical Glock 19",
    weight = 3
  },
  [499] = {
    name = "SC-Tactical Glock 19",
    weight = 3
  },
  [500] = {name = "HK USP 45", weight = 3},
  [501] = {
    name = "Silver HK USP 45",
    weight = 3
  },
  [502] = {
    name = "Tan HK USP 45",
    weight = 3
  },
  [503] = {
    name = "SC Tactical HK USP 45",
    weight = 3
  },
  [504] = {
    name = "Gold HK USP 45",
    weight = 3
  },
  [505] = {name = "M110", weight = 6},
  [506] = {name = "Tan M110", weight = 6},
  [507] = {name = "M4A1", weight = 5},
  [508] = {name = "Tan M4A1", weight = 5},
  [509] = {name = "Olive M4A1", weight = 5},
  [510] = {name = "Camo M4A1", weight = 5},
  [511] = {name = "USA M4A1", weight = 5},
  [512] = {
    name = "M4A1 SOPMOD",
    weight = 5
  },
  [513] = {
    name = "Tan M4A1 SOPMOD",
    weight = 5
  },
  [514] = {
    name = "Olive M4A1 SOPMOD",
    weight = 5
  },
  [515] = {
    name = "Camo M4A1 SOPMOD",
    weight = 5
  },
  [516] = {
    name = "USA M4A1 SOPMOD",
    weight = 5
  },
  [517] = {
    name = "Mosin Nagant",
    weight = 6
  },
  [518] = {
    name = "Beech Mosin Nagant",
    weight = 6
  },
  [519] = {
    name = "Leather wrap Mosin Nagant",
    weight = 6
  },
  [520] = {name = "HK MP7A1", weight = 4},
  [521] = {
    name = "Tan HK MP7A1",
    weight = 4
  },
  [522] = {
    name = "Camo HK MP7A1",
    weight = 4
  },
  [523] = {
    name = "Wooden S&W Model 66",
    weight = 3
  },
  [524] = {
    name = "Black S&W Model 66",
    weight = 3
  },
  [525] = {
    name = "Engraved S&W Model 66",
    weight = 3
  },
  [526] = {
    name = "Gold S&W Model 66",
    weight = 3
  },
  [527] = {
    name = "S&W Model 66",
    weight = 3
  },
  [528] = {
    name = "HK MP7A1 + Aimpoint",
    weight = 4
  },
  [529] = {
    name = "Tan HK MP7A1 + Aimpoint",
    weight = 4
  },
  [530] = {
    name = "Camo HK MP7A1 + Aimpoint",
    weight = 4
  },
  [531] = {
    name = "12 Gauge",
    stackable = true,
    weight = 0.003
  },
  [532] = {
    name = ".357 Magnum",
    stackable = true,
    weight = 0.003
  },
  [533] = {
    name = "4.6x30mm",
    stackable = true,
    weight = 0.003
  },
  [534] = {
    name = ".45 ACP",
    stackable = true,
    weight = 0.003
  },
  [535] = {
    name = "5.45x39mm",
    stackable = true,
    weight = 0.003
  },
  [536] = {
    name = "5.56x45mm",
    stackable = true,
    weight = 0.003
  },
  [537] = {
    name = "5.7x28mm",
    stackable = true,
    weight = 0.003
  },
  [538] = {
    name = ".50 AE",
    stackable = true,
    weight = 0.003
  },
  [539] = {
    name = "7.62x39mm",
    stackable = true,
    weight = 0.003
  },
  [540] = {
    name = "7.62x51mm",
    stackable = true,
    weight = 0.003
  },
  [541] = {
    name = "7.62x54mmR",
    stackable = true,
    weight = 0.003
  },
  [542] = {
    name = "9x19mm",
    stackable = true,
    weight = 0.003
  },
  [543] = {
    name = "A fegyvermester: AK-74"
  },
  [544] = {
    name = "A fegyvermester: AR-15"
  },
  [545] = {
    name = "A fegyvermester: Colt 1911"
  },
  [546] = {
    name = "A fegyvermester: Micro Draco"
  },
  [547] = {
    name = "A fegyvermester: Glock 19"
  },
  [548] = {
    name = "A fegyvermester: HK USP 45"
  },
  [549] = {
    name = "A fegyvermester: M4A1"
  },
  [550] = {
    name = "A fegyvermester: M110"
  },
  [551] = {
    name = "A fegyvermester: Dragunov PSL"
  },
  [552] = {
    name = "A fegyvermester: S&W Model 66"
  },
  [553] = {
    name = "A fegyvermester: Mosin Nagant"
  },
  [554] = {
    name = "A fegyvermester: MP7A1"
  },
  [555] = {
    name = "A fegyvermester: UZI"
  },
  [556] = {name = "FN P90", weight = 3},
  [557] = {name = "Camo P90", weight = 3},
  [558] = {
    name = "Winter Camo P90",
    weight = 3
  },
  [559] = {name = "Black P90", weight = 3},
  [560] = {
    name = "Gold Flow P90",
    weight = 3
  },
  [561] = {name = "Glock 17", weight = 3},
  [562] = {
    name = "Remington M700",
    weight = 3
  },
  [563] = {
    name = "A fegyvermester: Glock 17"
  },
  [564] = {
    name = "A fegyvermester: FN P90"
  },
  [565] = {
    name = "A fegyvermester: Remington M700"
  },
  [566] = {
    name = "A fegyvermester: Benelli M4"
  },
  [567] = {
    name = "Green Colt 1883 Sawed Off",
    weight = 3
  },
  [568] = {
    name = "Blue Colt 1883 Sawed Off",
    weight = 3
  },
  [569] = {
    name = "Platinum Colt 1883 Sawed Off",
    weight = 3
  },
  [570] = {
    name = "Rust Colt 1883 Sawed Off",
    weight = 3
  },
  [571] = {
    name = "Orange Colt 1883 Sawed Off",
    weight = 3
  },
  [572] = {
    name = "Gold Colt 1883 Sawed Off",
    weight = 3
  },
  [573] = {name = "Rugóstag", weight = 2.5},
  [574] = {name = "Vipera", weight = 1},
  [575] = {
    name = "Glock 19 (Lézer)",
    weight = 3
  },
  [576] = {
    name = "Silver Glock 19 (Lézer)",
    weight = 3
  },
  [577] = {
    name = "Tan Glock 19 (Lézer)",
    weight = 3
  },
  [578] = {
    name = "Tiffany Blue Glock 19 (Lézer)",
    weight = 3
  },
  [579] = {
    name = "Victoria Pink Glock 19 (Lézer)",
    weight = 3
  },
  [580] = {
    name = "SC-Tactical Glock 19 (Lézer)",
    weight = 3
  },
  [581] = {
    name = "SC-Tactical Glock 19 (Lézer)",
    weight = 3
  },
  [582] = {name = "Csőkulcs", weight = 2},
  [583] = {
    name = "Fegyvervásárlási bizonylat",
    paperItem = true,
    use = "weaponReceipt"
  },
  [584] = {
    name = "Drag verseny eredmény",
    paperItem = true,
    use = "dragSlip"
  },
  [585] = {
    name = "Gyapjú",
    weight = 1,
    stackable = true
  },
  [586] = {
    name = "Juhnyírógép",
    weight = 0.25,
    use = "sheepCutter"
  },
  [587] = {
    name = "Tojás",
    weight = 0.06,
    stackable = true
  },
  [588] = {
    name = "Friss tej",
    weight = 1,
    stackable = true
  },
  [589] = {
    name = "Milka csoki",
    stackable = true,
    use = "milkaMode"
  },
  [590] = {
    name = "Haszonállat stats kártya",
    stackable = true
  },
  [591] = {
    name = "Respawn kártya",
    stackable = true,
    simpleUse = "respawnCard"
  },
  [592] = {
    name = "Adrenalin injekció",
    stackable = true,
    simpleUse = "adrenalineUseSelf"
  },
  [593] = {name = "Zsák", use = "bagMode"},
  [594] = {
    name = "Tüzijáték 3",
    weight = 0.25,
    simpleUse = "firework",
    useArg = 3
  },
  [595] = {
    name = "Taxi kasszazárás",
    use = "taxiCheckout",
    paperItem = true
  },
  [596] = {
    name = "Vállalkozói igazolvány",
    paperItem = true
  },
  [597] = {
    name = "Számla",
    paperItem = true,
    use = "invoice"
  },
  [598] = {
    name = "Számlatömb",
    paperItem = true,
    use = "invoiceBook"
  },
  [599] = {
    name = "Futómű javító kártya",
    stackable = true,
    tooltip = "* Teljes felfüggesztést megjavítja\n* Kormányzást helyreállítja\n* Gyári minőségü alkatrészek (OEM)",
    simpleUse = "fixVeh",
    useArg = "suspension"
  },
  [600] = {
    name = "Motor nagyszervíz kártya",
    stackable = true,
    tooltip = "* Minden karbantartást elvégez a jármű motorján\n* Motor állapotát megjavítja\n* 100%-ra állítja a vezérlés - olajcsere - generál állapotát\n* Gyári minőségü alkatrészek (OEM)",
    simpleUse = "fixVeh",
    useArg = "engineGeneral"
  },
  [601] = {
    name = "Prémium full szervíz kártya",
    stackable = true,
    tooltip = "*Minden javítást és karbantartást elvégez a járművön\n* Vadonatúj járműnek megfelelő értékeket ad (OEM)\n*Az összes javítókártya képességeivel rendelkezik",
    simpleUse = "fixVeh",
    useArg = "global"
  },
  [602] = {
    name = "Motor kisszervíz kártya",
    description = "Megjavítja az autód motorját",
    stackable = true,
    tooltip = "* Motor állapotát megjavítja\n* 100%-ra állítja az olajcsere állapotát\n* Gyári minőségü alkatrészek (OEM)",
    simpleUse = "fixVeh",
    useArg = "engineSimple"
  },
  [603] = {
    name = "Akkumulátor javító kártya",
    stackable = true,
    tooltip = "* 100%-ra állítja az akkumulátor állapotát\n* 100%-ra tölti az akkumulátor teljesítményét\n* Gyári minőségü alkatrészek (OEM)",
    simpleUse = "fixVeh",
    useArg = "battery"
  },
  [604] = {
    name = "Gumiszervíz kártya",
    stackable = true,
    tooltip = "* 100%-ra - helyre állítja az összes gumi állapotát\n* Gyári minőségü alkatrészek (OEM)",
    simpleUse = "fixVeh",
    useArg = "tyre"
  },
  [605] = {
    name = "Fék javító kártya",
    stackable = true,
    tooltip = "* 100%-ra - helyre állítja az összes fék állapotát\n* Gyári minőségü alkatrészek (OEM)",
    simpleUse = "fixVeh",
    useArg = "brake"
  },
  [606] = {
    name = "Láda (Blueprint)",
    description = "Láda",
    weight = 1,
    crateItem = "blueprint"
  },
  [607] = {
    name = "Treasure Chest",
    description = "Láda",
    weight = 2,
    simpleUse = "treasureChest"
  },
  [608] = {
    name = "Mystery Chest",
    description = "Láda",
    weight = 2,
    simpleUse = "treasureChest"
  },
  [609] = {name = "Physgun"},
  [610] = {
    name = "Modern HI-FI",
    description = "HI-FI rendszer",
    weight = 0.9,
    simpleUse = "hifi",
    useArg = 2226
  },
  [611] = {
    name = "Pici HI-FI",
    description = "HI-FI rendszer",
    weight = 0.65,
    simpleUse = "hifi",
    useArg = 2102
  },
  [612] = {
    name = "Vitamin injekció",
    weight = 0.015,
    simpleUse = "vitaminInjection",
    stackable = true
  },
  [613] = {
    name = "Ballisztikus pajzs",
    weight = 15,
    use = "riotshield",
    dose = 100
  },
  [614] = {
    name = "SightRod 2000",
    weight = 2,
    use = "fishingRod",
    useArg = 0
  },
  [615] = {
    name = "SightRod 3000",
    weight = 2,
    use = "fishingRod",
    useArg = 1
  },
  [616] = {
    name = "SightRod 4000",
    weight = 2,
    use = "fishingRod",
    useArg = 2
  },
  [617] = {
    name = "SightRod 5000",
    weight = 2,
    use = "fishingRod",
    useArg = 3
  },
  [618] = {
    name = "SightRod 6000",
    weight = 2,
    use = "fishingRod",
    useArg = 4
  },
  [619] = {
    name = "Bézs damil",
    weight = 0.25,
    fishingLine = 1
  },
  [620] = {
    name = "Zöld damil",
    weight = 0.25,
    fishingLine = 2
  },
  [621] = {
    name = "Fehér damil",
    weight = 0.25,
    fishingLine = 3
  },
  [622] = {
    name = "Piros damil",
    weight = 0.25,
    fishingLine = 4
  },
  [623] = {
    name = "Sárga damil",
    weight = 0.25,
    fishingLine = 5
  },
  [624] = {
    name = "Pink damil",
    weight = 0.25,
    fishingLine = 6
  },
  [625] = {
    name = "Kék damil",
    weight = 0.25,
    fishingLine = 7
  },
  [626] = {
    name = "Úszó 1",
    weight = 0.01,
    fishingFloat = 1
  },
  [627] = {
    name = "Úszó 2",
    weight = 0.01,
    fishingFloat = 2
  },
  [628] = {
    name = "Úszó 3",
    weight = 0.01,
    fishingFloat = 3
  },
  [629] = {
    name = "Úszó 4",
    weight = 0.01,
    fishingFloat = 4
  },
  [630] = {
    name = "Egy doboz csali",
    weight = 0.1,
    dose = 20
  },
  [631] = {
    name = "Makréla",
    use = "fish",
    preUse = "fish",
    useArg = "sight_fish_mackerel",
    perishable = 600,
    perishableEvent = "fishPerishableEvent"
  },
  [632] = {
    name = "Keményfejű harcsa",
    use = "fish",
    preUse = "fish",
    useArg = "sight_fish_hardheadcatfish",
    perishable = 600,
    perishableEvent = "fishPerishableEvent"
  },
  [633] = {
    name = "Csattogóhal",
    use = "fish",
    preUse = "fish",
    useArg = "sight_fish_snapper",
    perishable = 600,
    perishableEvent = "fishPerishableEvent"
  },
  [634] = {
    name = "Sárgafarkú csattogóhal",
    use = "fish",
    preUse = "fish",
    useArg = "sight_fish_yellowtailsnapper",
    perishable = 600,
    perishableEvent = "fishPerishableEvent"
  },
  [635] = {
    name = "Legendary Csattogóhal",
    use = "fish",
    preUse = "fish",
    useArg = "sight_fish_snapper_leg",
    perishable = 600,
    perishableEvent = "fishPerishableEvent"
  },
  [636] = {
    name = "Vörös lazac",
    use = "fish",
    preUse = "fish",
    useArg = "sight_fish_redsalmon",
    perishable = 600,
    perishableEvent = "fishPerishableEvent"
  },
  [637] = {
    name = "Rózsaszín lazac",
    use = "fish",
    preUse = "fish",
    useArg = "sight_fish_pinksalmon",
    perishable = 600,
    perishableEvent = "fishPerishableEvent"
  },
  [638] = {
    name = "Kékúszójú tonhal",
    use = "fish",
    preUse = "fish",
    useArg = "sight_fish_tunabluefin",
    perishable = 600,
    perishableEvent = "fishPerishableEvent"
  },
  [639] = {
    name = "Sárgaúszójú tonhal",
    use = "fish",
    preUse = "fish",
    useArg = "sight_fish_tunayellowfin",
    perishable = 600,
    perishableEvent = "fishPerishableEvent"
  },
  [640] = {
    name = "Kakashal",
    use = "fish",
    preUse = "fish",
    useArg = "sight_fish_rooster",
    perishable = 600,
    perishableEvent = "fishPerishableEvent"
  },
  [641] = {
    name = "Legendary Kakashal",
    use = "fish",
    preUse = "fish",
    useArg = "sight_fish_rooster_leg",
    perishable = 600,
    perishableEvent = "fishPerishableEvent"
  },
  [642] = {
    name = "Kardhal",
    use = "fish",
    preUse = "fish",
    useArg = "sight_fish_swordfish",
    perishable = 600,
    perishableEvent = "fishPerishableEvent"
  },
  [643] = {
    name = "Mahi-mahi",
    use = "fish",
    preUse = "fish",
    useArg = "sight_fish_mahi",
    perishable = 600,
    perishableEvent = "fishPerishableEvent"
  },
  [644] = {
    name = "Legendary Mahi-mahi",
    use = "fish",
    preUse = "fish",
    useArg = "sight_fish_mahi_leg",
    perishable = 600,
    perishableEvent = "fishPerishableEvent"
  },
  [645] = {
    name = "Makócápa",
    use = "fish",
    preUse = "fish",
    useArg = "sight_fish_makoshark",
    perishable = 600,
    perishableEvent = "fishPerishableEvent"
  },
  [646] = {
    name = "Tigriscápa",
    use = "fish",
    preUse = "fish",
    useArg = "sight_fish_tigershark",
    perishable = 600,
    perishableEvent = "fishPerishableEvent"
  },
  [647] = {
    name = "Fehér cápa",
    use = "fish",
    preUse = "fish",
    useArg = "sight_fish_greatwhite",
    perishable = 600,
    perishableEvent = "fishPerishableEvent"
  },
  [648] = {
    name = "Legendary Fehér cápa",
    use = "fish",
    preUse = "fish",
    useArg = "sight_fish_greatwhite_leg",
    perishable = 600,
    perishableEvent = "fishPerishableEvent"
  },
  [649] = {
    name = "Kagyló igazgyönggyel",
    simpleUse = "oyster"
  },
  [650] = {
    name = "Üres kagyló"
  },
  [651] = {
    name = "Igazgyöngy"
  },
  [652] = {
    name = "Haller Babó medálja",
    weight = 0.25
  },
  [653] = {
    name = "Fishing Chest",
    description = "Láda",
    weight = 2,
    simpleUse = "treasureChest"
  },
  [654] = {
    name = "Töklámpás",
    weight = 0,
  },
  [655] = {
    name = "Ghost Detector 2000", -- nincs
    weight = 0.2,
  },
  [656] = {
    name = "Halloween cukorka", -- effect kell
    description = "Halloweeni cukorka.",
    simpleUse = "halloweenCandy",
    weight = 0,
  },
  [657] = {
    name = "Savanyú cukorka", -- ehhez is
    description = "Savanyú cukorka.",
    simpleUse = "halloweenSourCandy",
    weight = 0,
  },
  [658] = {
    name = "Proton Pack", -- nincs
    description = "igen, visszairtuk ezt is:( @noffy",
    weight = 0,
  },
  [659] = {
    name = "Halloween Knife",
    weight = 0.3,
  },
  [660] = {
    name = "Halloween MP5",
    weight = 3,
  },
  [661] = {
    name = "Halloween AK-47",
    weight = 5,
  },
  [662] = {
    name = "Halloween Glock 19",
    weight = 3,
  },
  [663] = {name = "Glock 19(Airsoft)", weight = 3},
  [664] = {name = "Glock 17(Airsoft)", weight = 3},
  [665] = {name = "Desert Eagle(Airsoft)", weight = 3},
  [666] = {name = "UZI(Airsoft)", weight = 3},
  [667] = {name = "TEC-9(Airsoft)", weight = 3},
  [668] = {name = "MP5(Airsoft)", weight = 3},
  [669] = {name = "FN P90(Airsoft)", weight = 3},
  [670] = {name = "HK MP7A1(Airsoft)", weight = 4},
  [671] = {name = "Micro Draco(Airsoft)", weight = 3},
  [672] = {name = "Benelli M4(Airsoft)", weight = 5},
  [673] = {name = "SPAZ-12(Airsoft)", weight = 6},
  [674] = {name = "AK-47(Airsoft)", weight = 5},
  [675] = {name = "M4A1(Airsoft)", weight = 5},
  [676] = {name = "AR-15(Airsoft)", weight = 5},
  [677] = {name = "M14(Airsoft)", weight = 6},
  [678] = {name = "Dragunov PSL(Airsoft)", weight = 6},
  [679] = {name = "Remington M700(Airsoft)", weight = 3},
  [680] = {name = "M110(Airsoft)", weight = 6},
  [681] = {name = "Ballisztikus pajzs(Airsoft)", weight = 15, use = "riotshield", dose = 100},
  [682] = { -- effect
  name = "Cukorpálca",
  description = "Cukorpálca.",
  simpleUse = "santaCandy",
  weight = 0,
  },
  [683] = { -- nincs megirva hozza a simpleuse talan
    name = "Arany ajándék",
    weight = 0,
  },
  [684] = { -- nincs
    name = "Adventi kalendárium 2023",
    weight = 0,
  },
  [685] = { -- ezt hajigalni nem igen tudod
    name = "Kis hógolyó",
    weight = 0.15,
  },
  [686] = {
    name = "Közepes hógolyó",
    weight = 0.3,
  },
  [687] = {
    name = "Nagy hógolyó",
    weight = 0.6,
  },
  [688] = {
    name = "Faág",
    weight = 0.2,
  },
  [689] = { -- nincs
    name = "Hóember",
    weight = 1.31,
  },
  [690] = {name = "AK-74(Airsoft)", weight = 5},
  [691] = {
    name = "Xmas Knife",
    weight = 0.3,
  },
  [692] = {
    name = "Xmas Katana",
    weight = 3,
  },
  [693] = {
    name = "Xmas MP5",
    weight = 3,
  },
  [694] = {
    name = "Gingerbread Micro Draco",
    weight = 3,
  },
  [695] = { -- haszna nincs
    name = "Téli Kesztyű",
    weight = 0,
  },
  [696] = {
    name = "Gingerbread Glock 19",
    weight = 3,
  },
  [697] = {
    name = "Gingerbread M4A1",
    weight = 5,
  },
  [698] = { -- nincs a script kesz
    name = "Csillagszóró",
    weight = 0.1,
  },
  [699] = { -- ez sincs megcsinalva
    name = "Zserbó",
    weight = 0.075,
  },
  [700] = { -- szinten
    name = "Bejgli",
    weight = 0.5,
  },
  [701] = { -- szinten
    name = "Bejgli szelet",
    weight = 0.05,
  },
  [702] = {
    name = "Borostyán",
    weight = 0,
  },
  [703] = {
    name = "Ametiszt",
    weight = 0,
  },
  [704] = {
    name = "Alumíniumrúd",
    weight = 0,
  },
  [705] = {
    name = "Krómrúd",
    weight = 0,
  },
  [706] = {
    name = "Szén",
    weight = 0,
  },
  [707] = {
    name = "Rézrúd",
    weight = 0,
  },
  [708] = {
    name = "Gyémánt",
    weight = 0,
  },
  [709] = {
    name = "Smaragd",
    weight = 0,
  },
  [710] = {
    name = "Aranyrúd",
    weight = 0,
  },
  [711] = {
    name = "Vasrúd",
    weight = 0,
  },
  [712] = {
    name = "Nikkelrúd",
    weight = 0,
  },
  [713] = {
    name = "Platinarúd",
    weight = 0,
  },
  [714] = {
    name = "Rubin",
    weight = 0,
  },
  [715] = {
    name = "Kis köteg pénz",
    description = "Egy illegális pénzköteg, amellyel a valutásnál fizethetsz.",
    isMoneyStack = true,
    weight = 0.25,
  },
  [716] = {
    name = "Közepes köteg pénz",
    description = "Egy illegális pénzköteg, amellyel a valutásnál fizethetsz.",
    isMoneyStack = true,
    weight = 0.5,
  },
  [717] = {
    name = "Nagy köteg pénz",
    description = "Egy illegális pénzköteg, amellyel a valutásnál fizethetsz.",
    isMoneyStack = true,
    weight = 1,
  },
  [718] = {
    name = "Bányászati engedély",
    weight = 0,
    paperItem = true,
    use = "license",
    useArg = "mine"
  },
  [719] = {
    name = "MiguMoto Tablet",
    weight = 0.5,
    use = "migumoto"
  },
  [720] = {
    name = "Dinamit (Meglévő járat)",
    weight = 1,
  },
  [721] = {
    name = "Dinamit (Új járat)",
    weight = 1,
  },
  [722] = {
    name = "Miner Chest", -- nincs
    weight = 2,
  },
  [723] = {
    name = "Sightcronium",
    weight = 0,
  },
  [724] = {
    name = "Flint Tools Csákány",
    weight = 1.7,
    use = "pickaxe",
    useArg = 2
  },
  [725] = {
    name = "MiguMoto Csákány",
    weight = 1.7,
    use = "pickaxe",
    useArg = 3
  },
  [726] = {
    name = "Silver Vein Csákány",
    weight = 1.7,
    use = "pickaxe",
    useArg = 4
  },
  [727] = {
    name = "Gold Csákány",
    weight = 1.7,
    use = "pickaxe",
    useArg = 5
  },
  [728] = {
    name = "Fémes Dénes pecsétgyűrűje",
    weight = 0.25,
  },
  [729] = {
    name = "Adventi kalendárium 2024", -- nincs
    weight = 0,
  },
  [730] = {
    name = "EV motor javító kártya",
    weight = 0,
    simpleUse = "fixVeh",
    useArg = "evFix"
  },
  [731] = {
    name = "EV akkumlátor javító kártya",
    weight = 0,
    simpleUse = "fixVeh",
    useArg = "evBattery"
  },
  [732] = {
    name = "Instant EV töltés Kártya",
    weight = 0,
    simpleUse = "fixVeh",
    useArg = "evFuel"
  },
  [733] = {
    name = "Easter MP5",
    weight = 3,
  },
  [734] = {
    name = "Easter AK-47",
    weight = 5,
  },
  [735] = {
    name = "Easter Katana",
    weight = 3,
  },
  [736] = {
    name = "Easter Knife",
    weight = 0.3,
  },
  [737] = {
    name = "Easter Pink Glock 19",
    weight = 3,
  },
  [738] = {
    name = "Easter Blue Glock 19",
    weight = 3,
  },
  [739] = {
    name = "Easter M4A1",
    weight = 5,
  },
  [740] = {
    name = "Easter Micro Draco",
    weight = 3,
  },
  [741] = {
    name = "Easter P90",
    weight = 3,
  },
--- mostani update 06.18
  [742] = {
    name = "Lőpor",
    weight = 0.001,
    stackable = true
  },
  [743] = {
    name = "9x19mm hüvely",
    weight = 0.003,
    stackable = true
  },
  [744] = {
    name = ".45 ACP hüvely",
    weight = 0.003,
    stackable = true
  },
  [745] = {
    name = ".50 AE hüvely",
    weight = 0.003,
    stackable = true
  },
  [746] = {
    name = "7.62x39mm hüvely",
    weight = 0.003,
    stackable = true
  },
  [747] = {
    name = "5.7x28mm hüvely",
    weight = 0.003,
    stackable = true
  },
  [748] = {
    name = "7.62x51mm hüvely",
    weight = 0.003,
    stackable = true
  },
  [749] = {
    name = "7.62x54mmR hüvely",
    weight = 0.003,
    stackable = true
  },
  [750] = {
    name = "12 Gauge hüvely",
    weight = 0.003,
    stackable = true
  },
  [751] = {
    name = "Vacation Chest",
    description = "Láda",
    simpleUse = "vacationChest",
    weight = 2,
  },
  [752] = {
    name = "Különleges pálcikás jégkrém", -- nincs
    simpleUse = "icecream",
    weight = 0,
  },
  [753] = {
    name = "Hűsítő nyári koktél", -- nincs
    simpleUse = "cocktail",
    weight = 0,
  },
  [754] = {
    name = "Dragunov SVDM", -- ez se
    weight = 6,
  },
  [755] = {
    name = "Summer Dragunov SVD", -- ez se
    weight = 6,
  },
  [756] = {
    name = "Summer 2 Dragunov SVD", -- nincsbeirva sehova
    weight = 6,
  },
}

restrictedItemIds = {
  [5] = true,
  [10] = true,
  [21] = true,
  [24] = true,
  [25] = true,
  [30] = true,
  [31] = true,
  [32] = true,
  [35] = true,
  [36] = true,
  [38] = true,
  [47] = true,
  [48] = true,
  [49] = true,
  [50] = true,
  [51] = true,
  [52] = true,
  [53] = true,
  [54] = true,
  [56] = true,
  [58] = true,
  [59] = true,
  [60] = true,
  [61] = true,
  [62] = true,
  [63] = true,
  [64] = true,
  [66] = true,
  [69] = true,
  [74] = true,
  [89] = true,
  [90] = true,
  [91] = true,
  [92] = true,
  [93] = true,
  [94] = true,
  [95] = true,
  [96] = true,
  [101] = true,
  [102] = true,
  [105] = true,
  [106] = true,
  [108] = true,
  [109] = true,
  [110] = true,
  [111] = true,
  [112] = true,
  [113] = true,
  [114] = true,
  [116] = true,
  [120] = true,
  [121] = true,
  [122] = true,
  [123] = true,
  [124] = true,
  [125] = true,
  [131] = true,
  [133] = true,
  [144] = true,
  [157] = true,
  [159] = true,
  [163] = true,
  [187] = true,
  [188] = true,
  [189] = true,
  [190] = true,
  [191] = true,
  [192] = true,
  [193] = true,
  [198] = true,
  [199] = true,
  [200] = true,
  [201] = true,
  [202] = true,
  [203] = true,
  [209] = true,
  [216] = true,
  [232] = true,
  [234] = true,
  [235] = true,
  [236] = true,
  [237] = true,
  [238] = true,
  [239] = true,
  [240] = true,
  [241] = true,
  [242] = true,
  [243] = true,
  [244] = true,
  [262] = true,
  [263] = true,
  [264] = true,
  [265] = true,
  [266] = true,
  [267] = true,
  [268] = true,
  [269] = true,
  [270] = true,
  [271] = true,
  [272] = true,
  [273] = true,
  [274] = true,
  [275] = true,
  [276] = true,
  [277] = true,
  [278] = true,
  [279] = true,
  [280] = true,
  [281] = true,
  [282] = true,
  [283] = true,
  [284] = true,
  [285] = true,
  [286] = true,
  [290] = true,
  [291] = true,
  [292] = true,
  [293] = true,
  [294] = true,
  [295] = true,
  [296] = true,
  [299] = true,
  [308] = true,
  [313] = true,
  [314] = true,
  [315] = true,
  [316] = true,
  [317] = true,
  [318] = true,
  [319] = true,
  [320] = true,
  [321] = true,
  [322] = true,
  [323] = true,
  [324] = true,
  [325] = true,
  [326] = true,
  [327] = true,
  [328] = true,
  [329] = true,
  [330] = true,
  [331] = true,
  [332] = true,
  [333] = true,
  [334] = true,
  [335] = true,
  [336] = true,
  [337] = true,
  [338] = true,
  [339] = true,
  [340] = true,
  [341] = true,
  [342] = true,
  [343] = true,
  [344] = true,
  [345] = true,
  [346] = true,
  [347] = true,
  [348] = true,
  [349] = true,
  [350] = true,
  [361] = true,
  [364] = true,
  [365] = true,
  [366] = true,
  [367] = true,
  [368] = true,
  [369] = true,
  [370] = true,
  [371] = true,
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
  [423] = true,
  [424] = true,
  [425] = true,
  [427] = true,
  [429] = true,
  [433] = true,
  [434] = true,
  [435] = true,
  [436] = true,
  [437] = true,
  [438] = true,
  [439] = true,
  [442] = true,
  [443] = true,
  [455] = true,
  [456] = true,
  [457] = true,
  [458] = true,
  [459] = true,
  [472] = true,
  [473] = true,
  [474] = true,
  [476] = true,
  [477] = true,
  [478] = true,
  [479] = true,
  [481] = true,
  [482] = true,
  [484] = true,
  [485] = true,
  [487] = true,
  [488] = true,
  [490] = true,
  [491] = true,
  [494] = true,
  [495] = true,
  [496] = true,
  [497] = true,
  [498] = true,
  [499] = true,
  [501] = true,
  [502] = true,
  [503] = true,
  [504] = true,
  [506] = true,
  [508] = true,
  [509] = true,
  [510] = true,
  [511] = true,
  [513] = true,
  [514] = true,
  [515] = true,
  [516] = true,
  [518] = true,
  [519] = true,
  [521] = true,
  [522] = true,
  [523] = true,
  [524] = true,
  [525] = true,
  [526] = true,
  [527] = true,
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
  [557] = true,
  [558] = true,
  [559] = true,
  [560] = true,
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
  [576] = true,
  [577] = true,
  [578] = true,
  [579] = true,
  [580] = true,
  [581] = true,
  [582] = true,
  [583] = true,
  [584] = true,
  [589] = true,
  [590] = true,
  [591] = true,
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
  [75] = true,
  [115] = true,
  [156] = true,
  [155] = true,
  [210] = true,
  [207] = true,
  [208] = true,
  [287] = true,
  [288] = true,
  [289] = true,
  [309] = true,
  [310] = true,
  [440] = true,
  [653] = true,
  [631] = true,
  [632] = true,
  [633] = true,
  [634] = true,
  [635] = true,
  [636] = true,
  [637] = true,
  [638] = true,
  [639] = true,
  [640] = true,
  [641] = true,
  [642] = true,
  [643] = true,
  [644] = true,
  [645] = true,
  [646] = true,
  [647] = true,
  [648] = true,
  [649] = true,
  [650] = true,
  [651] = true,
  [652] = true
}
local reverseHifis = {}
for i in pairs(newItemList) do
  if newItemList[i] then
    if newItemList[i].simpleUse == "hifi" then
      reverseHifis[newItemList[i].useArg] = i
    elseif newItemList[i].simpleUse == "eat" or newItemList[i].simpleUse == "drink" then
      newItemList[i].dose = 5
    end
  end
end
function getHifiItem(model)
  return reverseHifis[model]
end
function getItemSpecialTooltip(itemId)
  if newItemList[itemId] then
    return newItemList[itemId].tooltip
  end
  return false
end
itemList = {}
maxId = 0
for id, dat in pairs(newItemList) do
  if dat.serial then
    dat.stackable = false
  end
  itemList[id] = {
    dat.name,
    dat.description or "",
    1,
    0,
    0,
    0,
    0,
    0,
    0,
    dat.weight or 0,
    -1,
    -1,
    false,
    dat.stackable
  }
  maxId = math.max(id, maxId)
end
for id = 1, maxId do
  if not itemList[id] then
    itemList[id] = {
      "nincs item",
      "",
      1,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      -1,
      -1,
      false,
      false
    }
  end
end
crateItems = {}
for id, dat in pairs(newItemList) do
  if dat.crateItem then
    crateItems[id] = dat.crateItem
    newItemList[id].use = "crate"
  end
end
local serialType = {
  [22] = "P",
  [23] = "P",
  [24] = "P",
  [25] = "S",
  [26] = "S",
  [27] = "S",
  [28] = "SM",
  [29] = "SM",
  [32] = "SM",
  [30] = "AR",
  [31] = "AR",
  [33] = "R",
  [34] = "R",
  [12] = "K",
  [8] = "K",
  [4] = "K"
}
function getLastItemId()
  return #itemList
end
local hasPic = {}
local differentPics = {}
local lotteryTickets = {}
function shallowcopy(orig)
  local orig_type = type(orig)
  local copy
  if orig_type == "table" then
    copy = {}
    for orig_key, orig_value in pairs(orig) do
      copy[orig_key] = orig_value
    end
  else
    copy = orig
  end
  return copy
end
for j = 1, #itemList do
  lotteryTickets[j] = false
  local i = j - 1
  differentPics[i] = fileExists("files/items/sight/" .. i .. ".png")
  hasPic[i] = fileExists("files/items/" .. i .. ".png")
end
function getItemPic(itemData)
  if tonumber(itemData) then
    local id = itemData - 1
    if differentPics[id] then
      return "files/items/" .. id .. ".png"
    elseif hasPic[id] then
      return "files/items/" .. id .. ".png"
    end
    return "files/items/nopic.png"
  else
    local picPath = "files/items/nopic.png"
    if lotteryTickets[itemData.itemId] then
      if itemData.data3 == "empty" then
        picPath = "files/items/" .. itemData.itemId - 1 .. "_monochrome.png"
      else
        picPath = "files/items/" .. itemData.itemId - 1 .. ".png"
      end
    else
      local id = itemData.itemId - 1
      if differentPics[id] then
        picPath = "files/items/sight/" .. id .. ".png"
      elseif hasPic[id] then
        picPath = "files/items/" .. id .. ".png"
      end
    end
    return picPath
  end
end
doseItems = {}
for id, dat in pairs(newItemList) do
  if dat.dose then
    doseItems[id] = dat.dose
  end
end
copyableItems = {}
specialItems = {}
weaponSkins = {}
craftDoNotTakeItems = {}
for id, dat in pairs(newItemList) do
  if dat.craftDoNotTake then
    craftDoNotTakeItems[id] = dat.craftDoNotTake
  end
end
perishableItems = {}
perishableEvent = {}
for id, dat in pairs(newItemList) do
  if dat.perishable then
    perishableItems[id] = dat.perishable
    perishableEvent[id] = dat.perishableEvent
  end
end
for k = 1, #itemList do
  itemList[k][13] = false
end
for k, v in pairs(perishableItems) do
  itemList[k][13] = false
  itemList[k][14] = false
end
local nonStackableItems = {}
for k = 1, #itemList do
  if not itemList[k][14] then
    table.insert(nonStackableItems, k)
  end
end
function getNonStackableItems(itemid)
  return nonStackableItems
end
function isKeyItem(itemid)
  if itemid <= 3 then
    return true
  end
  if itemid == 154 then
    return true
  end
  return false
end
function isPaperItem(itemid)
  itemid = tonumber(itemid)
  return newItemList[itemid] and newItemList[itemid].paperItem
end
function getItemNameList()
  local tmp = {}
  for id = 1, #itemList do
    tmp[id] = itemList[id][1]
  end
  return tmp
end
function getItemDescriptionList()
  local tmp = {}
  for id = 1, #itemList do
    tmp[id] = itemList[id][2]
  end
  return tmp
end
function getItemRotInfo(id)
  if not itemList[id] then
    return 0, 0, 0, 0
  else
    return itemList[id][5], itemList[id][6], itemList[id][7], itemList[id][8]
  end
end
function getItemName(id)
  if not itemList[id] then
    return ""
  else
    return itemList[id][1]
  end
end
function getItemWeight(id)
  if not itemList[id] then
    return 0
  else
    return itemList[id][10] or 0
  end
end
function getItemType(id)
  if not itemList[id] then
    return 0
  else
    return itemList[id][3]
  end
end
function getWeaponID(id)
  if not itemList[id] then
    return 0
  elseif getItemType(id) == 2 then
    return itemList[id][11]
  else
    return 0
  end
end
function isItemDroppable(id)
  if not itemList[id] then
    return false
  else
    return itemList[id][13]
  end
end
function isItemStackable(id)
  if not itemList[id] then
    return false
  else
    return itemList[id][14]
  end
end
function getItemAmmoID(id)
  if not itemList[id] then
    return 0
  else
    return itemList[id][12]
  end
end
function getItemModel(id)
  return (itemList[id] or {
    nil,
    nil,
    nil,
    1271
  })[4]
end
availableRecipes = {
  [6] = {
    "Szárított marihuána",
    {
      {
        false,
        false,
        false
      },
      {
        false,
        20,
        false
      },
      {
        false,
        13,
        false
      }
    },
    {16, 1},
    true,
    true,
    "Drogok"
  },
  [7] = {
    "Füves cigi",
    {
      {
        false,
        false,
        false
      },
      {
        false,
        16,
        28
      },
      {
        false,
        false,
        false
      }
    },
    {65, 1},
    false,
    false,
    "Drogok"
  },
  [8] = {
    "Kokain",
    {
      {
        false,
        14,
        false
      },
      {
        23,
        26,
        27
      },
      {
        false,
        false,
        false
      }
    },
    {17, 1},
    true,
    true,
    "Drogok"
  },
  [11] = {
    "Colt-45",
    {
      {
        139,
        135,
        134
      },
      {
        false,
        137,
        136
      },
      {
        34,
        false,
        138
      }
    },
    {
      76,
      1,
      25,
      52
    },
    true,
    true,
    "Fegyverek"
  },
  [12] = {
    "AK-47",
    {
      {
        false,
        34,
        false
      },
      {
        128,
        129,
        130
      },
      {
        false,
        137,
        132
      }
    },
    {
      85,
      1,
      25,
      52
    },
    true,
    true,
    "Fegyverek"
  },
  [13] = {
    "Remington 870",
    {
      {
        false,
        34,
        false
      },
      {
        140,
        141,
        142
      },
      {
        false,
        false,
        false
      }
    },
    {
      79,
      1,
      25,
      52
    },
    true,
    true,
    "Fegyverek"
  },
  [14] = {
    "M14",
    {
      {
        false,
        34,
        false
      },
      {
        143,
        145,
        146
      },
      {
        false,
        137,
        false
      }
    },
    {
      87,
      1,
      25,
      52
    },
    true,
    true,
    "Fegyverek"
  },
  [15] = {
    "UZI",
    {
      {
        305,
        306,
        34
      },
      {
        137,
        304,
        false
      },
      {
        false,
        303,
        false
      }
    },
    {
      82,
      1,
      25,
      52
    },
    true,
    true,
    "Fegyverek"
  },
  [16] = {
    "TEC-9",
    {
      {
        false,
        307,
        34
      },
      {
        137,
        304,
        false
      },
      {
        false,
        303,
        false
      }
    },
    {
      84,
      1,
      25,
      52
    },
    true,
    true,
    "Fegyverek"
  },
  [17] = {
    "Kés",
    {
      {
        34,
        false,
        245
      },
      {
        false,
        false,
        302
      },
      {
        false,
        301,
        false
      }
    },
    {70, 1},
    true,
    true,
    "Fegyverek"
  },
  [24] = {
    "Parazeldum por",
    {
      {
        false,
        432,
        false
      },
      {
        23,
        26,
        27
      },
      {
        false,
        false,
        false
      }
    },
    {431, 1},
    true,
    true,
    "Drogok"
  },
  [25] = {
    "LSD",
    {
      {
        false,
        450,
        false
      },
      {
        false,
        452,
        false
      },
      {
        false,
        447,
        453
      }
    },
    {444, 2},
    true,
    true,
    "Drogok"
  },
  [26] = {
    "Extasy",
    {
      {
        false,
        449,
        false
      },
      {
        22,
        26,
        27
      },
      {
        false,
        false,
        false
      }
    },
    {233, 1},
    true,
    true,
    "Drogok"
  },
  [27] = {
    "Speed",
    {
      {
        false,
        454,
        false
      },
      {
        22,
        23,
        27
      },
      {
        false,
        false,
        false
      }
    },
    {445, 1},
    true,
    true,
    "Drogok"
  },
  [28] = {
    "Magic Mushroom",
    {
      {
        false,
        false,
        false
      },
      {
        false,
        20,
        false
      },
      {
        false,
        451,
        false
      }
    },
    {18, 1},
    true,
    true,
    "Drogok"
  },
  [29] = {
    "Glock-17",
    {
      {
        139,
        135,
        134
      },
      {
        false,
        137,
        136
      },
      {
        34,
        false,
        138
      }
    },
    {
      561,
      1,
      25,
      52
    },
    true,
    true,
    "Fegyverek"
  },
  [30] = {
    "Hóember",
    {
      {
        385,
        685,
        false
      },
      {
        false,
        686,
        688
      },
      {
        false,
        687,
        false
      }
    },
    {689, 1},
    false,
    false,
    "Tél"
  },
-- hüvely
  [31] = {
    ".45 ACP hüvely (25db)",
    {
      {
        false,
        false,
        false
      },
      {
        false,
        707,
        false
      },
      {
        false,
        false,
        false
      }
    },
    {744, 1},
    true,
    "hydraulic",
    "Töltényhüvely"
  },
  [32] = {
    ".50 AE hüvely (20db)",
    {
      {
        false,
        false,
        false
      },
      {
        false,
        707,
        false
      },
      {
        false,
        false,
        false
      }
    },
    {745, 1},
    true,
    "hydraulic",
    "Töltényhüvely"
  },
  [33] = {
    "12 gauge hüvely (10db)",
    {
      {
        false,
        false,
        false
      },
      {
        false,
        707,
        false
      },
      {
        false,
        false,
        false
      }
    },
    {750, 1},
    true,
    "hydraulic",
    "Töltényhüvely"
  },
  [34] = {
    "5.7x28mm hüvely (20db)",
    {
      {
        false,
        false,
        false
      },
      {
        false,
        707,
        false
      },
      {
        false,
        false,
        false
      }
    },
    {747, 1},
    true,
    "hydraulic",
    "Töltényhüvely"
  },
  [35] = {
    "7.62x39mm hüvely (15db)",
    {
      {
        false,
        false,
        false
      },
      {
        false,
        707,
        false
      },
      {
        false,
        false,
        false
      }
    },
    {746, 1},
    true,
    "hydraulic",
    "Töltényhüvely"
  },
  [36] = {
    "7.62x51mm hüvely (10db)",
    {
      {
        false,
        false,
        false
      },
      {
        false,
        707,
        false
      },
      {
        false,
        false,
        false
      }
    },
    {748, 1},
    true,
    "hydraulic",
    "Töltényhüvely"
  },
  [37] = {
    "7.62x54mmR hüvely (10db)",
    {
      {
        false,
        false,
        false
      },
      {
        false,
        707,
        false
      },
      {
        false,
        false,
        false
      }
    },
    {749, 1},
    true,
    "hydraulic",
    "Töltényhüvely"
  },
  [38] = {
    "9x19mm hüvely (25db)",
    {
      {
        false,
        false,
        false
      },
      {
        false,
        707,
        false
      },
      {
        false,
        false,
        false
      }
    },
    {743, 1},
    true,
    "hydraulic",
    "Töltényhüvely"
  },
}
defaultKnownRecipes = {
  [11] = true,
  [29] = true,
  [17] = true,
  [30] = true,
}
function getBlueprintName(data)
  return availableRecipes[data] and availableRecipes[data][1] or "n/a"
end
function getItemInfoForShop(id, data)
  if itemList[id] then
    if id == 299 then
      return {
        "Blueprint: " .. (availableRecipes[data] and availableRecipes[data][1] or "n/a"),
        itemList[id][10],
        itemList[id][14]
      }
    else
      return {
        itemList[id][1],
        itemList[id][10],
        itemList[id][14]
      }
    end
  end
end
function weaponsRunning()
  weaponItemIds = sightexports.sWeapons:getWeaponItemIds()
  ammoItemIds = sightexports.sWeapons:getAmmoItemIds()
  skillBooks = sightexports.sWeapons:getSkillBooks()
  serialItems = {}
  for id in pairs(newItemList) do
    if newItemList[id].serial then
      serialItems[id] = newItemList[id].serial
    end
    if weaponItemIds[id] and not isPickaxeItem(id) then
      newItemList[id].use = "weapon"
      newItemList[id].weapon = weaponItemIds[id]
      serialItems[id] = "OTH"
      local wpid = sightexports.sWeapons:getWeaponId(weaponItemIds[id])
      if wpid and serialType[wpid] then
        serialItems[id] = serialType[wpid]
      end
      local ammo = sightexports.sWeapons:getAmmoId(weaponItemIds[id])
      if ammo then
        newItemList[id].ammoName = newItemList[ammo].name
        newItemList[id].ammoId = ammo
      else
        newItemList[id].ammoName = nil
        newItemList[id].ammoId = nil
      end
      newItemList[id].stackable = sightexports.sWeapons:isStackable(weaponItemIds[id])
      itemList[id][14] = newItemList[id].stackable
    elseif newItemList[id].use == "weapon" then
      newItemList[id].use = nil
      newItemList[id].weapon = nil
      newItemList[id].ammoName = nil
      newItemList[id].ammoId = nil
    end
    if ammoItemIds[id] then
      newItemList[id].stackable = true
      itemList[id][14] = true
      newItemList[id].secondaryUse = "ammo"
      local wps = sightexports.sWeapons:getAmmoWeapons(id)
      if wps then
        newItemList[id].weaponList = {}
        newItemList[id].weaponItemIds = {}
        for i = 1, #wps do
          local item = sightexports.sWeapons:getMainItemID(wps[i])
          if item then
            table.insert(newItemList[id].weaponList, newItemList[item].name)
            table.insert(newItemList[id].weaponItemIds, item)
          end
          local skins = sightexports.sWeapons:getWeaponSkins(wps[i])
          if skins then
            for item in pairs(skins) do
              table.insert(newItemList[id].weaponItemIds, item)
            end
          end
        end
      else
        newItemList[id].weaponList = nil
        newItemList[id].weaponItemIds = nil
      end
    elseif newItemList[id].secondaryUse == "ammo" then
      newItemList[id].secondaryUse = nil
      newItemList[id].weaponList = nil
    end
    if skillBooks[id] then
      newItemList[id].simpleUse = "wpskill"
      local tmp = {}
      for i = 1, #skillBooks[id] do
        local item = sightexports.sWeapons:getMainItemID(skillBooks[id][i])
        if item then
          table.insert(tmp, newItemList[item].name)
        end
      end
      newItemList[id].skillBook = table.concat(tmp, ", ")
    elseif newItemList[id].simpleUse == "wpskill" then
      newItemList[id].simpleUse = nil
      newItemList[id].skillBook = nil
    end
    if newItemList[id].skipSerial or sightexports.sWeapons:getSkipSerial(weaponItemIds[id]) then
      serialItems[id] = nil
    end
  end
  if triggerClientEvent then
    initSerials()
    if fileExists("data/serial.sight") then
      fileDelete("data/serial.sight")
    end
    local file = fileCreate("data/serial.sight")
    for id, serial in pairs(serialItems) do
      fileWrite(file, id .. ";" .. serial .. "\n")
    end
    fileClose(file)
  end
end
function crateRunning()
  for item, ct in pairs(crateItems) do
    local maxWeight = 0
    local items, itemAmounts, n = sightexports.sCrate:getDetailsForWeight(ct)
    if items then
      for i = 1, #items do
        local w = getItemWeight(items[i]) * itemAmounts[i]
        if maxWeight < w then
          maxWeight = w
        end
      end
      itemList[item][10] = math.max(1.5, maxWeight * n * 2)
    end
  end
end

airSoftItems = {663, 664, 665, 666, 667, 668, 669, 670, 671, 672, 673, 674, 675, 676, 677, 678, 679, 680, 681, 690}


function getAirsoftItems()
  return airSoftItems
end

pickaxeItems = {
    [164] = true,
    [724] = true,
    [725] = true,
    [726] = true,
    [727] = true,
}

function isPickaxeItem(itemId)
    return pickaxeItems[itemId]
end