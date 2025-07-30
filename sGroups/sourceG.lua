rankColorList = {
  "green",
  "green-second",
  "red",
  "red-second",
  "blue",
  "blue-second",
  "yellow",
  "yellow-second",
  "purple",
  "purple-second",
  "orange",
  "orange-second"
}
rankColors = {}
for i = 1, #rankColorList do
  rankColors[rankColorList[i]] = true
end
function getRankColorList()
  return rankColorList
end
function getRankColors()
  return rankColors
end
permissionNames = {
  mdc = "MDC használata",
  mdcrevoke = "MDC: okmány bevonása",
  mdcdelwar = "MDC: körözés törlése",
  traffi = "MDC: traffipax",
  squad = "Egységek kezelése",
  jail = "Börtön",
  spike = "Szögesdrót",
  useD = "Sűrgősségi rádió",
  rbs = "RBS",
  megaphone = "Megafon használata",
  badge = "Jelvényadás/Jelvényelvétel",
  department = "/d használata",
  gov = "/gov használata",
  alnev = "Álnév használata",
  lenyomoz = "Telefon bemérés",
  mechanicCheckout = "Szerelő kasszazárás",
  mechanicStats = "Szerelő munkateljesítmény lekérdezés",
  mechanicCheckStock = "Szerelő készlethiány nyomtatás",
  nixorder = "SightNIX rendelés",
  vehicleExam = "Műszaki vizsga",
  packerTow = "Vontatás Packer segítségével",
  packerImpound = "Jármű lefoglalás",
  interiorLock = "Interior lezárás",
  graffitiClean = "Graffiti lemosás",
  crateOpen = "Láda felnyitás",
  casetteOpen = "ATM kazetta felnyitás",
  atmRob = "ATM rablás",
  goldrobMute = "Bank riasztó némítása",
  goldrobLock = "Bank ajtók nyitása/zárása",
  goldrobRepairGarage = "SECURITY garázs riasztó javítás",
  goldrobDestroy = "Aranybank láda megsemmisítése",
  fireman = "Tűzoltás",
  robGoldBank = "Aranybank-rablás indítása",
  weaponHide = "Fegyver elrejtés",
  borderControl = "Határ átállítása",
  ["craft:76"] = "Craft: Colt-45",
  ["craft:85"] = "Craft: AK-47",
  ["craft:79"] = "Craft: Sörétes puska",
  ["craft:87"] = "Craft: Vadászpuska",
  ["craft:82"] = "Craft: UZI",
  ["craft:84"] = "Craft: TEC-9",
  ["craft:70"] = "Craft: Kés",
  ["craft:16"] = "Craft: Szárított marihuána",
  ["craft:65"] = "Craft: Füves cigi",
  ["craft:17"] = "Craft: Kokain",
  ["craft:431"] = "Craft: Parazeldum por",
  ["craft:444"] = "Craft: LSD",
  ["craft:233"] = "Craft: Extasy",
  ["craft:445"] = "Craft: Speed",
  ["craft:18"] = "Craft: Magic Mushroom",
  ["craft:561"] = "Craft: Glock-17",

  ["craft:743"] = "Craft: 9x19mm hüvely",
  ["craft:744"] = "Craft: .45 ACP hüvely",
  ["craft:745"] = "Craft: .50 AE hüvely",
  ["craft:746"] = "Craft: 7.62x39mm hüvely",
  ["craft:747"] = "Craft: 5.7x28mm hüvely",
  ["craft:748"] = "Craft: 7.62x51mm hüvely",
  ["craft:749"] = "Craft: 7.62x54mmR hüvely",
  ["craft:750"] = "Craft: 12 gauge hüvely",
  unimpoundPolice = "Rendőrség által lefoglalt jármű kiváltása",
  impoundBikes = "Bicikli/Helikopter lefoglalása paranccsal",
  departmentRadio = "Sürgősségi rádió használata",
  departmentBlip = "Koordinátamegosztás",
  manageKeysVehicle = "Kulcskezelés (Járművek)",
  manageKeysInterior = "Kulcskezelés (Interiorok)",
  manageKeysGate = "Kulcskezelés (Kapuk)",
  manageGroupBalance = "Kasszakezelés",
  medic = "Sérülések ellátása",
  promoteDemote = "Előléptetés/Lefokozás",
  hireFire = "Tagfelvétel/Kirúgás",
  applyBag = "Zsák használata",
  nion = "SightNion használata",
  graffiti = "Graffiti",
  taximeter = "Taxióra kezelése",
  listCompanies = "Cégek lekérdezése",
  createCompany = "Cég létrehozása",
  editCompany = "Cég szerkesztése",
  manageCompanyTax = "Cégek adószámlájának kezelése",
  manageInvoiceBooks = "Céges számlatömbök kezelése",
  pavilionradio = "/pavilionradio parancs használata",
  clubradio = "/clubradio parancs használata",
  fishradio = "/fishradio parancs használata",
  editInteriors = "Interior szerkesztés",
  engineKey = "Járművek beindítása",
  editPed = "Pedek szerkesztése"
}
permissionSets = {
  global = {
    "promoteDemote",
    "hireFire",
    "manageKeysVehicle",
    "manageKeysInterior",
    "manageKeysGate",
    "manageGroupBalance",
    "editInteriors",
    "editPed"
  },
  law = {
    "applyBag",
    "medic",
    "megaphone",
    "mdc",
    "mdcrevoke",
    "mdcdelwar",
    "traffi",
    "squad",
    "jail",
    "spike",
    "rbs",
    "graffitiClean",
    "goldrobLock",
    "goldrobMute",
    "goldrobRepairGarage",
    "goldrobDestroy",
    "borderControl"
  },
  illegal = {
    "nion",
    "applyBag",
    "casetteOpen",
    "crateOpen",
    "atmRob",
    "craft:76",
    "craft:85",
    "craft:79",
    "craft:87",
    "craft:82",
    "craft:84",
    "craft:70",
    "craft:16",
    "craft:65",
    "craft:17",
    "craft:431",
    "craft:444",
    "craft:233",
    "craft:445",
    "craft:18",
    "craft:561",
    "craft:743",
    "craft:744",
    "craft:745",
    "craft:746",
    "craft:747",
    "craft:748",
    "craft:749",
    "craft:750",
    "robGoldBank",
    "weaponHide",
    "graffiti"
  },
  company = {
    "listCompanies",
    "createCompany",
    "editCompany",
    "manageCompanyTax",
    "manageInvoiceBooks"
  },
  mechanic = {
    "mechanicCheckout",
    "mechanicStats",
    "mechanicCheckStock",
    "nixorder",
    "vehicleExam",
    "packerTow",
    "engineKey"
  },
  club = {
    "pavilionradio",
    "clubradio",
    "fishradio"
  }
}
permissionSets.all = {}
for k in pairs(permissionNames) do
  table.insert(permissionSets.all, k)
end
function getPermissionName(name)
  return permissionNames[name] or "N/A"
end
groupList = {
  PD = {
    name = "Rendőrség",
    legal = true,
    mdclisting = true,
    permissionList = {
      permissionSets.law,
      "interiorLock",
      "unimpoundPolice",
      "packerTow",
      "packerImpound",
      "departmentRadio",
      "departmentBlip"
    },
    skins = 7,
    maxRanks = 50,
    items = {
      [561] = {
        1,
        false,
        false,
        5000
      },
      [77] = {
        1,
        false,
        false,
        25000
      },
      [471] = {
        1,
        false,
        false,
        6000
      },
      [493] = {
        1,
        false,
        false,
        6000
      },
      [575] = {
        1,
        false,
        false,
        7500
      },
      [500] = {
        1,
        false,
        false,
        6000
      },
      [83] = {
        1,
        false,
        false,
        12500
      },
      [556] = {
        1,
        false,
        false,
        15000
      },
      [520] = {
        1,
        false,
        false,
        19000
      },
      [528] = {
        1,
        false,
        false,
        21000
      },
      [86] = {
        1,
        false,
        false,
        25000
      },
      [507] = {
        1,
        false,
        false,
        27500
      },
      [512] = {
        1,
        false,
        false,
        30000
      },
      [480] = {
        1,
        false,
        false,
        27500
      },
      [483] = {
        1,
        false,
        false,
        30000
      },
      [486] = {
        1,
        false,
        false,
        30000
      },
      [88] = {
        1,
        false,
        false,
        50000
      },
      [562] = {
        1,
        false,
        false,
        60000
      },
      [505] = {
        1,
        false,
        false,
        75000
      },
      [291] = {
        1,
        false,
        false,
        0
      },
      [292] = {
        1,
        false,
        false,
        0
      },
      [118] = {
        1,
        false,
        false,
        1000
      },
      [119] = {
        3,
        false,
        false,
        1000
      },
      [115] = {
        1,
        false,
        false,
        15000
      },
      [69] = {
        1,
        false,
        false,
        0
      },
      [155] = {
        1,
        false,
        false,
        5000
      },
      [542] = {
        450,
        false,
        false,
        10
      },
      [534] = {
        450,
        false,
        false,
        11
      },
      [537] = {
        450,
        false,
        false,
        15
      },
      [533] = {
        450,
        false,
        false,
        15
      },
      [536] = {
        450,
        false,
        false,
        17
      },
      [540] = {
        450,
        false,
        false,
        50
      },
      [541] = {
        450,
        false,
        false,
        50
      },
      [93] = {
        5,
        false,
        false,
        2000
      },
      [94] = {
        5,
        false,
        false,
        2000
      },
      [314] = {
        1,
        "PD",
        false,
        0
      },
      [100] = {
        1,
        false,
        false,
        3000
      },
      [612] = {
        15,
        false,
        false,
        1000
      },
      [592] = {
        5,
        false,
        false,
        0
      },
      [372] = {
        2,
        false,
        false,
        1000
      },
      [127] = {
        1,
        "PD",
        false,
        0
      },
      [427] = {
        1,
        false,
        false,
        0
      },
      [613] = {
        1,
        false,
        false,
        5000
      }
    },
    dutyPoses = {
      {
        1546.6978759766,
        -1720.3432617188,
        1997.5616455078,
        1,
        1
      },
    },
    gov = "[color=sightblue]==============[Rendőrségi felhívás]==============",
    departmentRadio = "PD",
    voiceRadio = true,
    protectedRadio = 911,
    lawEnforcement = true,
    badge = "Rendőrség"
  },
  NAV = {
    name = "Nemzeti Adó- és Vámhivatal",
    legal = true,
    mdclisting = true,
    permissionList = {
      permissionSets.law,
      permissionSets.company,
      "alnev",
      "packerTow",
      "interiorLock",
      "departmentRadio",
      "departmentBlip"
    },
    skins = 7,
    maxRanks = 50,
    items = {
      [561] = {
        1,
        false,
        false,
        5000
      },
      [77] = {
        1,
        false,
        false,
        25000
      },
      [471] = {
        1,
        false,
        false,
        6000
      },
      [493] = {
        1,
        false,
        false,
        6000
      },
      [575] = {
        1,
        false,
        false,
        7500
      },
      [500] = {
        1,
        false,
        false,
        6000
      },
      [83] = {
        1,
        false,
        false,
        12500
      },
      [556] = {
        1,
        false,
        false,
        15000
      },
      [520] = {
        1,
        false,
        false,
        19000
      },
      [528] = {
        1,
        false,
        false,
        21000
      },
      [86] = {
        1,
        false,
        false,
        25000
      },
      [507] = {
        1,
        false,
        false,
        27500
      },
      [512] = {
        1,
        false,
        false,
        30000
      },
      [480] = {
        1,
        false,
        false,
        27500
      },
      [483] = {
        1,
        false,
        false,
        30000
      },
      [486] = {
        1,
        false,
        false,
        30000
      },
      [88] = {
        1,
        false,
        false,
        50000
      },
      [562] = {
        1,
        false,
        false,
        60000
      },
      [505] = {
        1,
        false,
        false,
        75000
      },
      [291] = {
        1,
        false,
        false,
        0
      },
      [292] = {
        1,
        false,
        false,
        0
      },
      [118] = {
        1,
        false,
        false,
        1000
      },
      [119] = {
        3,
        false,
        false,
        1000
      },
      [115] = {
        1,
        false,
        false,
        15000
      },
      [69] = {
        1,
        false,
        false,
        0
      },
      [155] = {
        1,
        false,
        false,
        5000
      },
      [542] = {
        450,
        false,
        false,
        10
      },
      [534] = {
        450,
        false,
        false,
        11
      },
      [537] = {
        450,
        false,
        false,
        15
      },
      [533] = {
        450,
        false,
        false,
        15
      },
      [536] = {
        450,
        false,
        false,
        17
      },
      [540] = {
        450,
        false,
        false,
        50
      },
      [541] = {
        450,
        false,
        false,
        50
      },
      [93] = {
        5,
        false,
        false,
        2000
      },
      [94] = {
        5,
        false,
        false,
        2000
      },
      [314] = {
        1,
        "NAV",
        false,
        0
      },
      [100] = {
        1,
        false,
        false,
        3000
      },
      [612] = {
        15,
        false,
        false,
        1000
      },
      [592] = {
        5,
        false,
        false,
        0
      },
      [427] = {
        1,
        false,
        false,
        0
      },
      [372] = {
        2,
        false,
        false,
        1000
      },
      [127] = {
        1,
        "NAV",
        false,
        0
      },
      [427] = {
        1,
        false,
        false,
        0
      },
      [613] = {
        1,
        false,
        false,
        5000
      }
    },
    gov = "[color=sightgreen-second]==============[Nemzeti Adó- és Vámhivatal felhívása]==============",
    departmentRadio = "NAV",
    voiceRadio = true,
    protectedRadio = 999,
    lawEnforcement = true,
    dutyPoses = {
      {
        -1639.822265625,
        698.0087890625,
        8999.107421875,
        1,
        1
      },
      {
        254.015,
        79.067,
        1003.641,
        6,
        1
      }
    },
    dutySkinNames = {
      [1] = "Próba"
    },
    badge = "NAV"
  },
  NNI = {
    name = "Nemzeti Nyomozó Iroda",
    legal = true,
    mdclisting = true,
    permissionList = {
      permissionSets.law,
      "interiorLock",
      "nion",
      "packerTow",
      "interiorLock",
      "alnev",
      "lenyomoz",
      "departmentRadio",
      "departmentBlip"
    },
    skins = 7,
    maxRanks = 50,
    items = {
      [561] = {
        1,
        false,
        false,
        5000
      },
      [77] = {
        1,
        false,
        false,
        25000
      },
      [471] = {
        1,
        false,
        false,
        6000
      },
      [493] = {
        1,
        false,
        false,
        6000
      },
      [575] = {
        1,
        false,
        false,
        7500
      },
      [500] = {
        1,
        false,
        false,
        6000
      },
      [83] = {
        1,
        false,
        false,
        12500
      },
      [556] = {
        1,
        false,
        false,
        15000
      },
      [520] = {
        1,
        false,
        false,
        19000
      },
      [528] = {
        1,
        false,
        false,
        21000
      },
      [86] = {
        1,
        false,
        false,
        25000
      },
      [507] = {
        1,
        false,
        false,
        27500
      },
      [512] = {
        1,
        false,
        false,
        30000
      },
      [480] = {
        1,
        false,
        false,
        27500
      },
      [483] = {
        1,
        false,
        false,
        30000
      },
      [486] = {
        1,
        false,
        false,
        30000
      },
      [88] = {
        1,
        false,
        false,
        50000
      },
      [562] = {
        1,
        false,
        false,
        60000
      },
      [505] = {
        1,
        false,
        false,
        75000
      },
      [291] = {
        1,
        false,
        false,
        0
      },
      [292] = {
        1,
        false,
        false,
        0
      },
      [118] = {
        1,
        false,
        false,
        1000
      },
      [119] = {
        3,
        false,
        false,
        1000
      },
      [115] = {
        1,
        false,
        false,
        15000
      },
      [69] = {
        1,
        false,
        false,
        0
      },
      [155] = {
        1,
        false,
        false,
        5000
      },
      [542] = {
        450,
        false,
        false,
        10
      },
      [534] = {
        450,
        false,
        false,
        11
      },
      [537] = {
        450,
        false,
        false,
        15
      },
      [533] = {
        450,
        false,
        false,
        15
      },
      [536] = {
        450,
        false,
        false,
        17
      },
      [540] = {
        450,
        false,
        false,
        50
      },
      [541] = {
        450,
        false,
        false,
        50
      },
      [93] = {
        5,
        false,
        false,
        2000
      },
      [94] = {
        5,
        false,
        false,
        2000
      },
      [127] = {
        1,
        "NNI",
        false,
        0
      },
      [314] = {
        1,
        "NNI",
        false,
        0
      },
      [100] = {
        1,
        false,
        false,
        3000
      },
      [612] = {
        15,
        false,
        false,
        1000
      },
      [592] = {
        5,
        false,
        false,
        0
      },
      [372] = {
        2,
        false,
        false,
        1000
      },
      [427] = {
        1,
        false,
        false,
        0
      },
      [613] = {
        1,
        false,
        false,
        5000
      }
    },
    dutyPoses = {
      {
        1547.587890625,
        -1719.728515625,
        1997.5616455078,
        1,
        2
      }
    },
    gov = "[color=sightblue-second]==============[Nemzeti Nyomozó Iroda felhívása]==============",
    departmentRadio = "NNI",
    voiceRadio = true,
    protectedRadio = 920,
    lawEnforcement = true,
    badge = "NNI"
  },
  OMSZ = {
    name = "Országos Mentőszolgálat",
    legal = true,
    mdclisting = true,
    permissionList = {
      "medic",
      "packerTow",
      "departmentRadio",
      "departmentBlip",
      "megaphone",
      "rbs"
    },
    skins = 7,
    maxRanks = 50,
    dutyPoses = {
      { -- Los Santos
        1606.8087158203,
        1759.8062744141,
        5001.1015625,
        1,
        1
      },
      { -- Montgomery
        1238.4426269531,
        310.74508666992,
        999,
        1,
        1
      },
      { -- San Fierro
      1607.0562744141, 
      1759.6423339844, 
      5001.1015625,
      1,
      2
      },
      { -- Tierra Robada
      1238.5679931641,
      310.80264282227,
      999,
      1,
      2
      }
    },
    items = {
      [100] = {
        1,
        false,
        false,
        0
      },
      [612] = {
        15,
        false,
        false,
        0
      },
      [314] = {
        1,
        "OMSZ",
        false,
        0
      },
      [127] = {
        1,
        "OMSZ",
        false,
        0
      },
      [592] = {
        5,
        false,
        false,
        0
      }
    },
    gov = "[color=sightred]==============[Országos Mentőszolgálat felhívása]==============",
    departmentRadio = "OMSZ",
    voiceRadio = true,
    protectedRadio = 104,
    badge = "OMSZ",
    badgeEx = true
  },
  TOW = {
    name = "Sight City Autómentők",
    legal = true,
    mdclisting = true,
    permissionList = {"packerTow"},
    skins = 0,
    maxRanks = 50,
    items = {
      [127] = {
        1,
        "TOW",
        false,
        0
      }
    },
    dutyPoses = {
      {
        1757.0595703125,
        -1930.072265625,
        19.668014526367,
        0,
        0
      }
    },
    voiceRadio = true,
    protectedRadio = 980
  },
  OKF = {
    name = "Katasztrófavédelem",
    legal = true,
    mdclisting = true,
    permissionList = {
      "interiorLock",
      "medic",
      "packerTow",
      "departmentRadio",
      "departmentBlip",
      "rbs",
      "fireman"
    },
    skins = 7,
    maxRanks = 50,
    gov = "[color=sightred]==============[Katasztrófavédelmi felhívás]==============",
    items = {
      [98] = {
        25000,
        false,
        false,
        0
      },
      [427] = {
        1,
        false,
        false,
        0
      },
      [127] = {
        1,
        "OKF",
        false,
        0
      },
      [100] = {
        1,
        false,
        false,
        0
      }
    },
    dutyPoses = {
      {
        2715.7939453125,
        -2388.5654296875,
        9998.5,
        1,
        1
      },
      {
        -2025.8170703125,
        73.915078125,
        34.4048125,
        0,
        0
      },
      {
      -2031.5162353516, 
      72.221260070801, 
      29.17031288147,
      0,
      0
      }
    },
    departmentRadio = "OKF",
    voiceRadio = true,
    protectedRadio = 970,
    badge = "OKF"
  },
  ARMY = {
    name = "Katonaság",
    legal = true,
    mdclisting = true,
    lawEnforcement = true,
    permissionList = {
      permissionSets.law,
      "packerTow",
      "departmentRadio",
      "departmentBlip"
    },
    skins = 7,
    maxRanks = 50,
    items = {
      [561] = {
        1,
        false,
        false,
        5000
      },
      [77] = {
        1,
        false,
        false,
        25000
      },
      [471] = {
        1,
        false,
        false,
        6000
      },
      [493] = {
        1,
        false,
        false,
        6000
      },
      [575] = {
        1,
        false,
        false,
        7500
      },
      [500] = {
        1,
        false,
        false,
        6000
      },
      [83] = {
        1,
        false,
        false,
        12500
      },
      [556] = {
        1,
        false,
        false,
        15000
      },
      [520] = {
        1,
        false,
        false,
        19000
      },
      [528] = {
        1,
        false,
        false,
        21000
      },
      [86] = {
        1,
        false,
        false,
        25000
      },
      [507] = {
        1,
        false,
        false,
        27500
      },
      [512] = {
        1,
        false,
        false,
        30000
      },
      [480] = {
        1,
        false,
        false,
        27500
      },
      [483] = {
        1,
        false,
        false,
        30000
      },
      [486] = {
        1,
        false,
        false,
        30000
      },
      [88] = {
        1,
        false,
        false,
        50000
      },
      [562] = {
        1,
        false,
        false,
        60000
      },
      [505] = {
        1,
        false,
        false,
        75000
      },
      [291] = {
        1,
        false,
        false,
        0
      },
      [292] = {
        1,
        false,
        false,
        0
      },
      [118] = {
        1,
        false,
        false,
        1000
      },
      [119] = {
        3,
        false,
        false,
        1000
      },
      [115] = {
        1,
        false,
        false,
        15000
      },
      [69] = {
        1,
        false,
        false,
        0
      },
      [155] = {
        1,
        false,
        false,
        5000
      },
      [542] = {
        450,
        false,
        false,
        10
      },
      [534] = {
        450,
        false,
        false,
        11
      },
      [537] = {
        450,
        false,
        false,
        15
      },
      [533] = {
        450,
        false,
        false,
        15
      },
      [536] = {
        450,
        false,
        false,
        17
      },
      [540] = {
        450,
        false,
        false,
        50
      },
      [541] = {
        450,
        false,
        false,
        50
      },
      [93] = {
        5,
        false,
        false,
        2000
      },
      [94] = {
        5,
        false,
        false,
        2000
      },
      [314] = {
        1,
        "ARMY",
        false,
        0
      },
      [100] = {
        1,
        false,
        false,
        3000
      },
      [612] = {
        15,
        false,
        false,
        1000
      },
      [592] = {
        5,
        false,
        false,
        0
      },
      [107] = {
        1,
        false,
        false,
        10000
      },
      [372] = {
        2,
        false,
        false,
        1000
      },
      [613] = {
        1,
        false,
        false,
        5000
      }
    },
    dutyPoses = {
      {
        -1542.873046875,
        412.9384765625,
        9007.05859375,
        1,
        1
      }
    },
    gov = "[color=sightgreen]==============[Honvédségi felhívás]==============",
    departmentRadio = "HONVÉDSÉG",
    voiceRadio = true,
    protectedRadio = 101,
    badge = "Honvédség"
  },
  TEK = {
    name = "Terrorelhárítási Központ",
    legal = true,
    mdclisting = true,
    permissionList = {
      permissionSets.law,
      "packerTow",
      "departmentRadio",
      "departmentBlip"
    },
    skins = 5,
      dutySkinNames = {
        [1] = "Tiszt",
        [2] = "Zászlós",
        [3] = "Őrmester",
        [4] = "Női",
        [5] = "SPSU",
    },
    maxRanks = 50,
    items = {
      [561] = {
        1,
        false,
        false,
        5000
      },
      [77] = {
        1,
        false,
        false,
        25000
      },
      [471] = {
        1,
        false,
        false,
        6000
      },
      [493] = {
        1,
        false,
        false,
        6000
      },
      [575] = {
        1,
        false,
        false,
        7500
      },
      [500] = {
        1,
        false,
        false,
        6000
      },
      [83] = {
        1,
        false,
        false,
        12500
      },
      [556] = {
        1,
        false,
        false,
        15000
      },
      [520] = {
        1,
        false,
        false,
        19000
      },
      [528] = {
        1,
        false,
        false,
        21000
      },
      [86] = {
        1,
        false,
        false,
        25000
      },
      [507] = {
        1,
        false,
        false,
        27500
      },
      [512] = {
        1,
        false,
        false,
        30000
      },
      [480] = {
        1,
        false,
        false,
        27500
      },
      [483] = {
        1,
        false,
        false,
        30000
      },
      [486] = {
        1,
        false,
        false,
        30000
      },
      [88] = {
        1,
        false,
        false,
        50000
      },
      [562] = {
        1,
        false,
        false,
        60000
      },
      [505] = {
        1,
        false,
        false,
        75000
      },
      [291] = {
        1,
        false,
        false,
        0
      },
      [292] = {
        1,
        false,
        false,
        0
      },
      [118] = {
        1,
        false,
        false,
        1000
      },
      [119] = {
        3,
        false,
        false,
        1000
      },
      [115] = {
        1,
        false,
        false,
        15000
      },
      [69] = {
        1,
        false,
        false,
        0
      },
      [155] = {
        1,
        false,
        false,
        5000
      },
      [542] = {
        450,
        false,
        false,
        10
      },
      [534] = {
        450,
        false,
        false,
        11
      },
      [537] = {
        450,
        false,
        false,
        15
      },
      [533] = {
        450,
        false,
        false,
        15
      },
      [536] = {
        450,
        false,
        false,
        17
      },
      [540] = {
        450,
        false,
        false,
        50
      },
      [541] = {
        450,
        false,
        false,
        50
      },
      [93] = {
        5,
        false,
        false,
        2000
      },
      [94] = {
        5,
        false,
        false,
        2000
      },
      [314] = {
        1,
        "TEK",
        false,
        0
      },
      [100] = {
        1,
        false,
        false,
        3000
      },
      [612] = {
        15,
        false,
        false,
        1000
      },
      [592] = {
        5,
        false,
        false,
        0
      },
      [372] = {
        2,
        false,
        false,
        1000
      },
      [127] = {
        1,
        "TEK",
        false,
        0
      },
      [613] = {
        1,
        false,
        false,
        5000
      },
      [489] = {
        1,
        false,
        false,
        5000
      },
      [531] = {
        450,
        false,
        false,
        11
      },
    },
    gov = "[color=sightblue]==============[Terrorelhárítási Központ felhívása]==============",
    dutyPoses = {
      {
        1527.267578125, -1467.7861328125, 8053.546875,
        1,
        1
      }
    },
    departmentRadio = "TEK",
    voiceRadio = true,
    protectedRadio = 925,
    lawEnforcement = true,
    badge = "TEK"
  },
  FIX = {
    name = "Fix & Drive Mechanic Shop",
    legal = true,
    mdclisting = true,
    permissionList = {
      permissionSets.mechanic
    },
    skins = 5,
    maxRanks = 50,
    items = {
      [287] = {
        1,
        false,
        false,
        1000
      },
      [440] = {
        1,
        false,
        false,
        500
      },
      [127] = {
        1,
        "FIX",
        false,
        0
      }
    },
    dutyPoses = {
      {
        -1503.6254882813,
        881.94006347656,
        7.4241309165955,
        0,
        0
      }
    },
    gov = "[color=sightorange]==============[Fix & Drive Mechanic Shop felhívása]==============",
    voiceRadio = true,
    protectedRadio = 939,
    badge = "Fix&Drive",
    badgeEx = true
  },
  BMS = {
    name = "Boxter Mechanic Shop",
    legal = true,
    mdclisting = true,
    permissionList = {
      permissionSets.mechanic
    },
    skins = 6,
    maxRanks = 50,
    items = {
      [287] = {
        1,
        false,
        false,
        1000
      },
      [440] = {
        1,
        false,
        false,
        500
      },
      [127] = {
        1,
        "BMS",
        false,
        0
      }
    },
    dutyPoses = {
      {
        2444.6943359375,
        -2647.5693359375,
        13.88413143158,
        0,
        0
      },
      {
        2444.7626953125,
        -2515.6787109375,
        13.88413143158,
        0,
        0
      }
    },
    gov = "[color=sightorange]==============[Boxter Mechanic Shop felhívása]==============",
    voiceRadio = true,
    protectedRadio = 915,
    badge = "BMS",
    badgeEx = true
  },
  APMS = {
    name = "Angel Pine Junkyard Auto Service",
    legal = true,
    mdclisting = true,
    permissionList = {
      permissionSets.mechanic
    },
    skins = 4,
    maxRanks = 50,
    items = {
      [287] = {
        1,
        false,
        false,
        1000
      },
      [440] = {
        1,
        false,
        false,
        500
      },
      [127] = {
        1,
        "APMS",
        false,
        0
      }
    },
    dutyPoses = {
      {
        -1865.5791015625,
        -1674.29296875,
        21.753355026245,
        0,
        0
      }
    },
    gov = "[color=sightorange]==============[Angel Pine Junkyard Auto Service felhívása]==============",
    voiceRadio = true,
    protectedRadio = 905,
    badge = "Junkyard",
    badgeEx = true
  },
  RING = {
    name = "SightRing services",
    legal = true,
    mdclisting = true,
    permissionList = {
      permissionSets.mechanic
    },
    skins = 0,
    maxRanks = 50,
    items = {
      [127] = {
        1,
        "RING",
        false,
        0
      },
      [287] = {
        1,
        false,
        false,
        1000
      },
      [440] = {
        1,
        false,
        false,
        500
      }
    },
    gov = "[color=sightred]==============[SightRing Services felhívása]==============",
    voiceRadio = true,
    badge = "SightRing",
    badgeEx = true,
    dutyPoses = {
      {
        -1379.978515625,
        26.1494140625,
        14.9140625,
        0,
        0
      }
    },
    protectedRadio = 555
  },
  TAXI = {
    name = "Sight City Közlekedési Központ",
    legal = true,
    mdclisting = true,
    permissionList = {"taximeter"},
    skins = 0,
    maxRanks = 50,
    items = {
      [127] = {
        1,
        "TAXI",
        false,
        0
      },
      [316] = {
        1,
        false,
        false,
        0
      },
      [317] = {
        1,
        false,
        false,
        0
      }
    },
    dutyPoses = {
      {
        1757,
        -1927,
        19.7,
        0,
        0
      }
    },
    gov = "[color=sightyellow]==============[Sight City Közlekedési Központ felhívása]==============",
    voiceRadio = true,
    badge = "SCKK",
    badgeEx = true,
    protectedRadio = 89794
  },
  PF = {
    name = "Parkolásfelügyelet",
    legal = true,
    mdclisting = true,
    permissionList = {
      "packerTow",
      "packerImpound",
      "impoundBikes",
      "departmentRadio",
      "departmentBlip"
    },
    skins = 4,
    maxRanks = 50,
    items = {},
    items = {
      [314] = {
        1,
        "PF",
        false,
        0
      },
      [127] = {
        1,
        "PF",
        false,
        0
      }
    },
    departmentRadio = "PF",
    dutyPoses = {
      {
        1775.916015625,
        -2014.6259765625,
        1098.5625,
        1,
        1
      }
    },
    gov = "[color=sightblue]==============[Parkolás felügyelet felhívása]==============",
    voiceRadio = true,
    badge = "PF",
    badgeEx = true,
    protectedRadio = 888
  },
  OPSZ = {
    name = "Polgárőrség",
    legal = true,
    mdclisting = true,
    permissionList = {
      permissionSets.law,
      "packerTow",
      "departmentRadio",
      "departmentBlip"
    },
    skins = 0,
    maxRanks = 50,
    items = {
      [561] = {
        1,
        false,
        false,
        5000
      },
      [527] = {
        1,
        false,
        false,
        10000
      },
      [574] = {
        1,
        false,
        false,
        10000
      },
      [534] = {
        450,
        false,
        false,
        11
      },
      [532] = {
        450,
        false,
        false,
        11
      },
      [314] = {
        1,
        "OPSZ",
        false,
        0
      },
      [127] = {
        1,
        "OPSZ",
        false,
        0
      },
      [118] = {
        1,
        false,
        false,
        500
      },
      [119] = {
        3,
        false,
        false,
        500
      }
    },
    dutyPoses = {
      {
        326.1455078125,
        306.9609375,
        999.1484375,
        5,
        25353
      }
    },
    gov = "[color=sightblue]==============[Polgárőrség felhívás]==============",
    departmentRadio = "Polgárőrség",
    voiceRadio = true,
    protectedRadio = 600,
    lawEnforcement = true,
    badge = "Polgárőrség"
  },
  SOD = {
    name = "Sons of Odin",
    permissionList = {
      permissionSets.illegal
    },
    skins = 7,
    maxRanks = 50,
    items = {}
  },
  LM = {
    name = "Leveque Mob",
    permissionList = {
      permissionSets.illegal
    },
    skins = 7,
    maxRanks = 50,
    items = {}
  },
  DV = {
    name = "Deutsche Verbindung",
    permissionList = {
      permissionSets.illegal
    },
    skins = 7,
    maxRanks = 50,
    items = {}
  },
  CNC = {
    name = "Cancun Nueva Cartel",
    permissionList = {
      permissionSets.illegal
    },
    skins = 7,
    maxRanks = 50,
    items = {}
  },
  NSM = {
    name = "North Side Mob",
    permissionList = {
      permissionSets.illegal
    },
    skins = 7,
    maxRanks = 50,
    items = {}
  },
  OV = {
    name = "Opsezna Veza",
    permissionList = {
      permissionSets.illegal
    },
    skins = 7,
    maxRanks = 50,
    items = {}
  },
  ROB = {
    name = "Rollin 20s Outlaw Bloods",
    permissionList = {
      permissionSets.illegal
    },
    skins = 7,
    maxRanks = 50,
    items = {}
  },
  NDR = {
    name = "Ndrangheta",
    permissionList = {
      permissionSets.illegal
    },
    skins = 7,
    maxRanks = 50,
    items = {}
  },
  SG = {
    name = "SIGHTMTA",
    permissionList = {
      permissionSets.all
    },
    skins = 22,
    maxRanks = 999,
    items = {},
    dutySkinNames = {
      [1] = "Borisz",
      [2] = "Urma",
      [3] = "Pötyi",
      [4] = "SightDyno szerelő",
      [5] = "Jesse Jr",
      [6] = "Polgi",
      [7] = "Shifty",
      [8] = "Jesse",
      [9] = "Vezér 1",
      [10] = "Mikulás",
      [11] = "Jesse paraszt",
      [12] = "Jamie",
      [13] = "Carlos/Körte",
      [14] = "Carlos/Körte",
      [15] = "Pie",
      [16] = "Fásy",
      [17] = "Escobar"
    }
  },
  CLUB = {
    name = "The Club Management",
    permissionList = {
      permissionSets.club
    },
    skins = 0,
    maxRanks = 50,
    badge = "TCM",
    badgeEx = true,
    items = {},
    gov = "[color=sightblue]==============[Szórakozóhely felhívás]=============="
  }
}
function getDutySkinName(prefix, skin)
  if groupList[prefix] and groupList[prefix].dutySkinNames and groupList[prefix].dutySkinNames[skin] then
    return groupList[prefix].dutySkinNames[skin]
  end
  return "Skin #" .. skin
end
function isGroupValid(prefix)
  if groupList[prefix] then
    return true
  end
  return false
end
function getGroupName(prefix)
  if groupList[prefix] then
    return groupList[prefix].name
  end
  return "N/A"
end
function getMaxRanks(prefix)
  if groupList[prefix] then
    return groupList[prefix].maxRanks
  end
  return 0
end
protectedRadios = {}
badgeGroups = {}
voiceGroups = {}
govGroups = {}
departmentGroups = {}
departmentGroupsEx = {}
lawEnforcementGroups = {}
for prefix in pairs(groupList) do
  groupList[prefix].permissions = {}
  if groupList[prefix].voiceRadio then
    table.insert(voiceGroups, prefix)
  end
  if groupList[prefix].departmentRadio then
    table.insert(departmentGroups, prefix)
  end
  if groupList[prefix].badge then
    table.insert(badgeGroups, prefix)
    groupList[prefix].permissions.badge = true
  end
  if groupList[prefix].gov then
    table.insert(govGroups, prefix)
    groupList[prefix].permissions.gov = true
  end
  if groupList[prefix].protectedRadio then
    protectedRadios[groupList[prefix].protectedRadio] = prefix
  end
  table.insert(groupList[prefix].permissionList, permissionSets.global)
  for i = 1, #groupList[prefix].permissionList do
    if type(groupList[prefix].permissionList[i]) == "table" then
      for j = 1, #groupList[prefix].permissionList[i] do
        groupList[prefix].permissions[groupList[prefix].permissionList[i][j]] = true
      end
    else
      groupList[prefix].permissions[groupList[prefix].permissionList[i]] = true
    end
  end
  if groupList[prefix].lawEnforcement then
    table.insert(lawEnforcementGroups, prefix)
  end
end
function getBadgeGroups()
  return badgeGroups
end
function getGroupBadgeTitle(prefix)
  return groupList[prefix] and groupList[prefix].badge
end
function getGroupBadgeEx(prefix)
  return groupList[prefix] and groupList[prefix].badgeEx
end
function getDutyItemPrice(prefix, item)
  if groupList[prefix] and groupList[prefix].items and groupList[prefix].items[item] then
    return groupList[prefix].items[item][4] or 0
  end
  return 0
end
function firstToUpper(str)
  return (utf8.gsub(str, "^%l", utf8.upper))
end
function hasGroupMDC(prefix)
  return groupList[prefix].permissions.mdc or false
end
if triggerClientEvent then
  if fileExists("data/permname.sight") then
    fileDelete("data/permname.sight")
  end
  local file = fileCreate("data/permname.sight")
  for perm, name in pairs(permissionNames) do
    fileWrite(file, perm .. ";" .. name .. "\n")
  end
  fileClose(file)
  if fileExists("data/groupnames.sight") then
    fileDelete("data/groupnames.sight")
  end
  if fileExists("data/groupitems.sight") then
    fileDelete("data/groupitems.sight")
  end
  if fileExists("data/groupperms.sight") then
    fileDelete("data/groupperms.sight")
  end
  if fileExists("data/groupskins.sight") then
    fileDelete("data/groupskins.sight")
  end
  local groupnames = fileCreate("data/groupnames.sight")
  local groupitems = fileCreate("data/groupitems.sight")
  local groupperms = fileCreate("data/groupperms.sight")
  local groupskins = fileCreate("data/groupskins.sight")
  for prefix, dat in pairs(groupList) do
    fileWrite(groupnames, prefix .. ";" .. dat.name .. "\n")
    fileWrite(groupskins, prefix .. ";" .. (dat.skins or 0) .. "\n")
    local text = ""
    if dat.items then
      for item in pairs(dat.items) do
        text = text .. ";" .. item
      end
    end
    fileWrite(groupitems, prefix .. text .. "\n")
    local text = ""
    if dat.permissions then
      for perm in pairs(dat.permissions) do
        text = text .. ";" .. perm
      end
    end
    fileWrite(groupperms, prefix .. text .. "\n")
  end
  fileClose(groupnames)
  fileClose(groupitems)
  fileClose(groupperms)
  fileClose(groupskins)
end

function getDepRadio(prefix)
  return groupList[prefix].departmentRadio
end

function isLegalGroup(prefix)
  return groupList[prefix].legal
end

function getGroups()
  return groupList
end

function isLawEnforcementGroup(prefix)
  if groupList[prefix] then
    return groupList[prefix].lawEnforcement
  end
  return false
end