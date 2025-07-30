local ammoIds = {
  ["12gauge"] = 531,
  ["357magnum"] = 532,
  ["4.6x30"] = 533,
  ["45ACP"] = 534,
  ["5.45x39"] = 535,
  ["5.56x45"] = 536,
  ["5.7x28"] = 537,
  ["50AE"] = 538,
  ["7.62x39"] = 539,
  ["7.62x51"] = 540,
  ["7.62x54r"] = 541,
  ["9x19mm"] = 542
}
customWeapons = {
  colt45 = {
    modelName = "colt45",
    muzzle = {
      3,
      13,
      0.065,
      0.25,
      0.2366,
      0.0387,
      0.1155,
      0.986048,
      0.057934,
      0.156054
    },
    sound = "colt",
    heating = 0.075,
    cooling = 0.075,
    weaponWear = 0.05,
    itemId = 76,
    ammoId = ammoIds["45ACP"],
    skillBook = 234,
    weaponId = 22,
    damage = 8,
    boneId = {
      [1] = true,
      [3] = true,
      [25] = true,
      [35] = true,
      [41] = true,
      [51] = true
    },
    clothHide = true
  },
  silenced = {
    modelName = "silenced",
    sound = "silenced",
    itemId = 77,
    ammoId = ammoIds["45ACP"],
    heating = 0.075,
    cooling = 0.0765,
    weaponWear = 0.05,
    skillBook = 235,
    weaponId = 23,
    damage = 8,
    boneId = {
      [1] = true,
      [3] = true,
      [25] = true,
      [35] = true,
      [41] = true,
      [51] = true
    },
    clothHide = true
  },
  desert_eagle = {
    modelName = "desert_eagle",
    skins = {
      [272] = "camo",
      [273] = "gold",
      [414] = "hellokitty",
      [665] = "airsoft"
    },
    heating = 0.135,
    cooling = 0.07,
    weaponWear = 0.05,
    textureName = "deagle",
    muzzle = {
      4,
      15,
      0.15,
      0.45,
      0.3258,
      0.0131,
      0.093,
      0.99942,
      -0.033718,
      0.004768
    },
    sound = "rev",
    itemId = 78,
    ammoId = ammoIds["50AE"],
    skillBook = 236,
    weaponId = 24,
    damage = 16,
    boneId = {
      [1] = true,
      [3] = true,
      [25] = true,
      [35] = true,
      [41] = true,
      [51] = true,
    },
    clothHide = false
  },
  shotgun = {
    modelName = "chromegun",
    skins = {
      [342] = "1",
      [343] = "2",
      [344] = "3",
      [345] = "4"
    },
    heating = 0.2,
    cooling = 0.09,
    weaponWear = 0.05,
    textureName = "m870t",
    muzzle = {
      5,
      20,
      0.225,
      0.9,
      0.8217,
      -0.0602,
      0.1954,
      0.983415,
      -0.118713,
      0.137118
    },
    sound = "shoti",
    itemId = 79,
    ammoId = ammoIds["12gauge"],
    skillBook = 242,
    weaponId = 25,
    damage = 40,
    boneId = {
      [3] = true,
      [25] = true,
      [35] = true
    },
    clothHide = false
  },
  ["spaz-12"] = {
    modelName = "shotgspa",
    textureName = "one",
    skins = {
      [673] = "airsoft"
    },
    sound = "i_shoti",
    muzzle = {
      5,
      19,
      0.225,
      0.9,
      0.7685,
      -0.0483,
      0.2252,
      0.982694,
      -0.104713,
      0.152803
    },
    heating = 0.125,
    cooling = 0.08,
    weaponWear = 0.016665,
    itemId = 81,
    ammoId = ammoIds["12gauge"],
    skillBook = 243,
    weaponId = 27,
    damage = 24,
    boneId = {
      [3] = true,
      [25] = true,
      [35] = true
    },
    clothHide = false
  },
  uzi = {
    modelName = "micro_uzi",
    skins = {
      [433] = "uzi1",
      [434] = "uzi2",
      [435] = "uzi3",
      [436] = "uzi4",
      [666] = "airsoft"
    },
    heating = 0.039,
    cooling = 0.075,
    weaponWear = 0.01,
    textureName = "9MM_C",
    muzzle = {
      8,
      14,
      0.125,
      0.35,
      0.2804,
      -0.0059,
      0.1089,
      0.990446,
      -0.110783,
      0.082122
    },
    sound = "uzi",
    itemId = 82,
    ammoId = ammoIds["9x19mm"],
    skillBook = 555,
    weaponId = 28,
    damage = 6,
    boneId = {
      [1] = true,
      [3] = true,
      [25] = true,
      [35] = true,
      [41] = true,
      [51] = true
    },
    clothHide = "illegal"
  },
  mp5lng = {
    modelName = "mp5lng",
    skins = {
      [276] = "mp51",
      [277] = "mp52",
      [278] = "mp53",
      [279] = "mp54",
      [660] = "mp55",
      [668] = "airsoft",
      [693] = "mp52xmas",
      [733] = "mp56"

    },
    heating = 0.039,
    cooling = 0.085,
    weaponWear = 0.01,
    textureName = "mp5mli_bear",
    muzzle = {
      7,
      18,
      0.125,
      0.375,
      0.4313,
      -0.0259,
      0.1828,
      0.983905,
      -0.121228,
      0.131282
    },
    sound = "mp5",
    itemId = 83,
    ammoId = ammoIds["9x19mm"],
    skillBook = 238,
    weaponId = 29,
    damage = 7,
    boneId = {
      [1] = true,
      [3] = true,
      [25] = true,
      [35] = true,
      [41] = true,
      [51] = true
    },
    clothHide = false
  },
  tec9 = {
    modelName = "tec9",
    skins = {
      [283] = "tec1",
      [284] = "tec2",
      [285] = "tec3",
      [286] = "tec4",
      [667] = "airsoft"
    },
    heating = 0.039,
    cooling = 0.075,
    weaponWear = 0.01,
    textureName = "bm_uzi_micro1",
    muzzle = {
      8,
      17,
      0.125,
      0.35,
      0.4037,
      0.0218,
      0.1142,
      0.996637,
      -0.050762,
      0.064332
    },
    sound = "tec9",
    itemId = 84,
    ammoId = ammoIds["9x19mm"],
    skillBook = 237,
    weaponId = 32,
    damage = 6.5,
    boneId = {
      [1] = true,
      [3] = true,
      [25] = true,
      [35] = true,
      [41] = true,
      [51] = true
    },
    clothHide = "illegal"
  },
  ak47 = {
    modelName = "ak47",
    itemId = 85,
    ammoId = ammoIds["7.62x39"],
    heating = 0.045599999999999995,
    cooling = 0.135,
    weaponWear = 0.01,
    skins = {
      [265] = "camo",
      [266] = "camo2",
      [267] = "camo3",
      [268] = "gold",
      [269] = "gold2",
      [270] = "silver",
      [271] = "kitty",
      [661] = "ak47halloween",
      [674] = "airsoft",
      [734] = "easter"
    },
    textureName = "ak",
    muzzle = {
      3,
      20,
      0.2,
      0.6,
      0.7475,
      -0.0394,
      0.118,
      0.994628,
      -0.092372,
      0.046715
    },
    sound = "ak",
    skillBook = 239,
    weaponId = 30,
    damage = 12,
    boneId = {
      [3] = true,
      [25] = true,
      [35] = true
    },
    clothHide = false
  },
  m4 = {
    modelName = "m4",
    itemId = 86,
    ammoId = ammoIds["5.56x45"],
    heating = 0.045,
    cooling = 0.1375,
    weaponWear = 0.01,
    muzzle = {
      4,
      18,
      0.175,
      0.5,
      0.7163,
      -0.0318,
      0.0854,
      0.996944,
      -0.077726,
      -0.007808
    },
    sound = "m16a2",
    skillBook = 240,
    weaponId = 31,
    damage = 11,
    boneId = {
      [3] = true,
      [25] = true,
      [35] = true
    },
    clothHide = false
  },
  rifle = {
    modelName = "rifle",
    skins = {
      [677] = "airsoft"
    },
    textureName = "m14p",
    heating = 0.2,
    cooling = 0.09,
    weaponWear = 0.05,
    muzzle = {
      4,
      20,
      0.3,
      0.725,
      0.9607,
      -0.08,
      0.1926,
      0.987464,
      -0.110425,
      0.112788
    },
    sound = "rifle",
    itemId = 87,
    ammoId = ammoIds["7.62x51"],
    skillBook = 241,
    weaponId = 33,
    damage = 32,
    boneId = {
      [3] = true,
      [25] = true,
      [35] = true
    },
    clothHide = false
  },
  sniper = {
    modelName = "sniper",
    scope = "dragunov",
    skins = {
      [274] = "camo",
      [275] = "camo2",
      [678] = "airsoft"
    },
    textureName = "tekstura",
    heating = 0.225,
    cooling = 0.095,
    weaponWear = 0.05,
    muzzle = {
      4,
      20,
      0.25,
      0.7,
      0.8908,
      -0.0106,
      0.0978,
      0.998738,
      -0.047275,
      0.016955
    },
    sound = "sniper",
    itemId = 88,
    ammoId = ammoIds["7.62x54r"],
    skillBook = 551,
    weaponId = 34,
    damage = 48,
    boneId = {
      [3] = true,
      [25] = true,
      [35] = true
    },
    clothHide = false
  },
  sniper2 = {
    modelName = "sniper",
    scope = "dragunov",
    skins = {
      [755] = "summer1",
      [756] = "summer2",
    },
    textureName = "v4_svd",
    heating = 0.225,
    cooling = 0.095,
    weaponWear = 0.05,
    muzzle = {
      4,
      20,
      0.25,
      0.7,
      0.8908,
      -0.0106,
      0.0978,
      0.998738,
      -0.047275,
      0.016955
    },
    sound = "sniper",
    itemId = 754,
    ammoId = ammoIds["7.62x54r"],
    skillBook = 551,
    weaponId = 34,
    damage = 48,
    boneId = {
      [3] = true,
      [25] = true,
      [35] = true
    },
    clothHide = false
  },
  wep_sw_model66 = {
    modelName = "wep_sw_model66",
    skins = {
      [523] = "1",
      [524] = "2",
      [525] = "3",
      [526] = "4"
    },
    textureName = "sw_model66",
    muzzle = {
      3,
      18,
      0.15,
      0.4,
      0.3108,
      0.017,
      0.0784,
      0.999425,
      -0.033846,
      -0.002262
    },
    heating = 0.135,
    cooling = 0.055,
    weaponWear = 0.05,
    sound = "rev2",
    itemId = 527,
    ammoId = ammoIds["357magnum"],
    skillBook = 552,
    weaponId = 24,
    damage = 20,
    boneId = {
      [1] = true,
      [3] = true,
      [25] = true,
      [35] = true,
      [41] = true,
      [51] = true
    },
    clothHide = true
  },
  wep_colt_1911 = {
    modelName = "wep_colt_1911",
    skins = {
      [472] = "1",
      [473] = "2",
      [474] = "3"
    },
    heating = 0.085,
    cooling = 0.075,
    weaponWear = 0.05,
    textureName = "v4_1911_512",
    muzzle = {
      3,
      13,
      0.065,
      0.25,
      0.2232,
      0.0363,
      0.1104,
      0.988773,
      0.050775,
      0.140532
    },
    sound = "colt",
    itemId = 471,
    ammoId = ammoIds["45ACP"],
    skillBook = 545,
    weaponId = 23,
    damage = 15,
    boneId = {
      [1] = true,
      [3] = true,
      [25] = true,
      [35] = true,
      [41] = true,
      [51] = true
    },
    clothHide = true
  },
  ["wep_ak-74"] = {
    modelName = "wep_ak-74",
    skins = {
      [476] = "1",
      [477] = "2",
      [478] = "3",
      [479] = "4",
      [690] = "airsoft"
    },
    heating = 0.048,
    cooling = 0.145,
    weaponWear = 0.01,
    textureName = "ak-74",
    sound = "ak74",
    muzzle = {
      4,
      19,
      0.25,
      0.6,
      0.7587,
      -0.0402,
      0.1198,
      0.994264,
      -0.093369,
      0.052171
    },
    itemId = 475,
    ammoId = ammoIds["5.45x39"],
    skillBook = 543,
    weaponId = 30,
    damage = 15,
    boneId = {
      [3] = true,
      [25] = true,
      [35] = true
    },
    clothHide = false
  },
  wep_mp7a1 = {
    modelName = "wep_mp7a1",
    skins = {
      [521] = "1",
      [522] = "2",
      [670] = "airsoft"
    },
    heating = 0.039,
    cooling = 0.12025,
    weaponWear = 0.01,
    textureName = "v4_mp7a1",
    sound = "mp7",
    muzzle = {
      8,
      17,
      0.175,
      0.45,
      0.2959,
      -0.0074,
      0.1288,
      0.977563,
      -0.125085,
      0.169481
    },
    itemId = 520,
    ammoId = ammoIds["4.6x30"],
    skillBook = 554,
    weaponId = 29,
    damage = 8.5,
    boneId = {
      [1] = true,
      [3] = true,
      [25] = true,
      [35] = true,
      [41] = true,
      [51] = true
    },
    clothHide = false
  },
  wep_mp7a1_aimpoint = {
    modelName = "wep_mp7a1_aimpoint",
    skins = {
      [529] = "1",
      [530] = "2"
    },
    heating = 0.039,
    cooling = 0.0925,
    weaponWear = 0.01,
    skinFolder = "wep_mp7a1",
    textureName = "v4_mp7a1",
    sound = "mp7",
    laser = {
      0.1987,
      -0.0069,
      0.174,
      0.977563,
      -0.125085,
      0.169481
    },
    muzzle = {
      8,
      17,
      0.175,
      0.45,
      0.2959,
      -0.0074,
      0.1288,
      0.977563,
      -0.125085,
      0.169481
    },
    itemId = 528,
    ammoId = ammoIds["4.6x30"],
    skillBook = 554,
    weaponId = 29,
    damage = 8.5,
    boneId = {
      [1] = true,
      [3] = true,
      [25] = true,
      [35] = true,
      [41] = true,
      [51] = true
    },
    clothHide = false
  },
  wep_m4a1 = {
    modelName = "wep_m4a1",
    skins = {
      [508] = "1",
      [509] = "2",
      [510] = "3",
      [511] = "4",
      [675] = "airsoft",
      [697] = "5",
      [739] = "6" 
    },
    heating = 0.045,
    cooling = 0.1375,
    weaponWear = 0.01,
    textureName = "m4a1_patesz",
    sound = "m4",
    muzzle = {
      3,
      20,
      0.2,
      0.525,
      0.7176,
      -0.0354,
      0.1255,
      0.995506,
      -0.08701,
      0.037384
    },
    itemId = 507,
    ammoId = ammoIds["5.56x45"],
    skillBook = 549,
    weaponId = 31,
    damage = 12.25,
    boneId = {
      [3] = true,
      [25] = true,
      [35] = true
    },
    clothHide = false
  },
  wep_m4a1_sopmod = {
    modelName = "wep_m4a1_sopmod",
    skins = {
      [513] = "1",
      [514] = "2",
      [515] = "3",
      [516] = "4"
    },
    laser = {
      0.4511,
      -0.032,
      0.16,
      0.995506,
      -0.08701,
      0.037384
    },
    heating = 0.045,
    cooling = 0.1375,
    weaponWear = 0.01,
    sound = "m4",
    skinFolder = "wep_m4a1",
    textureName = "m4a1_patesz",
    muzzle = {
      3,
      20,
      0.2,
      0.525,
      0.7176,
      -0.0354,
      0.1255,
      0.995506,
      -0.08701,
      0.037384
    },
    itemId = 512,
    ammoId = ammoIds["5.56x45"],
    skillBook = 549,
    weaponId = 31,
    damage = 12.25,
    boneId = {
      [3] = true,
      [25] = true,
      [35] = true
    },
    clothHide = false
  },
  ["wep_ar-15"] = {
    modelName = "wep_ar-15",
    skins = {
      [481] = "1",
      [482] = "2",
      [676] = "airsoft"
    },
    textureName = "ar-15_patesz",
    heating = 0.042,
    cooling = 0.115,
    weaponWear = 0.01,
    sound = "m4light",
    muzzle = {
      4,
      17,
      0.2,
      0.525,
      0.7176,
      -0.0354,
      0.1255,
      0.995506,
      -0.08701,
      0.037384
    },
    itemId = 480,
    ammoId = ammoIds["5.56x45"],
    skillBook = 544,
    weaponId = 31,
    damage = 13.5,
    boneId = {
      [3] = true,
      [25] = true,
      [35] = true
    },
    clothHide = false
  },
  ["wep_ar-15_holo"] = {
    modelName = "wep_ar-15_holo",
    skins = {
      [487] = "1",
      [488] = "2"
    },
    skinFolder = "wep_ar-15",
    textureName = "ar-15_patesz",
    heating = 0.042,
    cooling = 0.115,
    weaponWear = 0.01,
    sound = "m4light",
    muzzle = {
      4,
      17,
      0.2,
      0.525,
      0.7176,
      -0.0354,
      0.1255,
      0.995506,
      -0.08701,
      0.037384
    },
    itemId = 486,
    ammoId = ammoIds["5.56x45"],
    skillBook = 544,
    weaponId = 31,
    damage = 13.5,
    boneId = {
      [3] = true,
      [25] = true,
      [35] = true
    },
    clothHide = false
  },
  ["wep_ar-15_aimpoint"] = {
    modelName = "wep_ar-15_aimpoint",
    skins = {
      [484] = "1",
      [485] = "2"
    },
    skinFolder = "wep_ar-15",
    textureName = "ar-15_patesz",
    heating = 0.042,
    cooling = 0.115,
    weaponWear = 0.01,
    laser = {
      0.5369,
      -0.0403,
      0.1628,
      0.995506,
      -0.08701,
      0.037384
    },
    sound = "m4light",
    muzzle = {
      4,
      17,
      0.2,
      0.525,
      0.7176,
      -0.0354,
      0.1255,
      0.995506,
      -0.08701,
      0.037384
    },
    itemId = 483,
    ammoId = ammoIds["5.56x45"],
    skillBook = 544,
    weaponId = 31,
    damage = 13.5,
    boneId = {
      [3] = true,
      [25] = true,
      [35] = true
    },
    clothHide = false
  },
  ["wep_glock-19"] = {
    modelName = "wep_glock-19",
    skins = {
      [494] = "1",
      [495] = "2",
      [496] = "3",
      [497] = "4",
      [498] = "5",
      [499] = "6",
      [662] = "7",
      [663] = "airsoft",
      [696] = "8",
      [737] = "9",
      [738] = "10"

    },
    heating = 0.085,
    cooling = 0.075,
    weaponWear = 0.05,
    textureName = "glock-19_patesz",
    sound = "bm9",
    muzzle = {
      3,
      14,
      0.0875,
      0.25,
      0.1951,
      0.0345,
      0.106,
      0.988773,
      0.050775,
      0.140532
    },
    itemId = 493,
    ammoId = ammoIds["9x19mm"],
    skillBook = 547,
    weaponId = 23,
    damage = 15,
    boneId = {
      [1] = true,
      [3] = true,
      [25] = true,
      [35] = true,
      [41] = true,
      [51] = true
    },
    clothHide = true
  },
  ["wep_glock-19_laser"] = {
    modelName = "wep_glock-19_laser",
    skins = {
      [576] = "1",
      [577] = "2",
      [578] = "3",
      [579] = "4",
      [580] = "5",
      [581] = "6"
    },
    heating = 0.085,
    cooling = 0.075,
    weaponWear = 0.05,
    laser = {
      0.1943,
      0.0342,
      0.0446,
      0.988773,
      0.050775,
      0.140532
    },
    textureName = "glock-19_patesz",
    skinFolder = "wep_glock-19",
    sound = "bm9",
    muzzle = {
      3,
      14,
      0.0875,
      0.25,
      0.1951,
      0.0345,
      0.106,
      0.988773,
      0.050775,
      0.140532
    },
    itemId = 575,
    ammoId = ammoIds["9x19mm"],
    boneId = 1,
    skillBook = 547,
    weaponId = 23,
    damage = 15,
    boneId = {
      [1] = true,
      [3] = true,
      [25] = true,
      [35] = true,
      [41] = true,
      [51] = true
    },
    clothHide = true
  },
  wep_hk_usp45 = {
    modelName = "wep_hk_usp45",
    skins = {
      [501] = "1",
      [502] = "2",
      [503] = "3",
      [504] = "4"
    },
    heating = 0.085,
    cooling = 0.075,
    weaponWear = 0.05,
    textureName = "hk_usp_patesz",
    sound = "fnp40",
    muzzle = {
      3,
      13,
      0.075,
      0.25,
      0.2026,
      0.0351,
      0.1069,
      0.988773,
      0.050775,
      0.140532
    },
    itemId = 500,
    ammoId = ammoIds["45ACP"],
    skillBook = 548,
    weaponId = 23,
    damage = 13,
    boneId = {
      [1] = true,
      [3] = true,
      [25] = true,
      [35] = true,
      [41] = true,
      [51] = true
    },
    clothHide = true
  },
  wep_mosin_nagant = {
    modelName = "wep_mosin_nagant",
    skins = {
      [518] = "1",
      [519] = "2"
    },
    heating = 0.25,
    cooling = 0.1,
    weaponWear = 0.05,
    textureName = "v4_mosin_nagant",
    sound = "nagant",
    muzzle = {
      3,
      20,
      0.3,
      0.75,
      0.9299,
      -0.076,
      0.1794,
      0.99053,
      -0.109389,
      0.082973
    },
    itemId = 517,
    ammoId = ammoIds["7.62x54r"],
    skillBook = 553,
    weaponId = 33,
    damage = 40,
    boneId = {
      [3] = true,
      [25] = true,
      [35] = true
    },
    clothHide = false
  },
  wep_m110 = {
    modelName = "wep_m110",
    scope = "m110",
    skinScope = {
      ["1"] = "m110_tan",
      [680] = "airsoft"
    },
    skins = {
      [506] = "1",
      [680] = "airsoft"
    },
    heating = 0.225,
    cooling = 0.095,
    weaponWear = 0.05,
    textureName = "v4_m110",
    sound = "fnfal",
    muzzle = {
      3,
      19,
      0.225,
      0.6,
      0.8485,
      -0.0088,
      0.0979,
      0.998631,
      -0.050753,
      0.012695
    },
    itemId = 505,
    ammoId = ammoIds["7.62x51"],
    skillBook = 550,
    weaponId = 34,
    damage = 60,
    boneId = {
      [3] = true,
      [25] = true,
      [35] = true
    },
    clothHide = false
  },
  wep_micro_draco = {
    modelName = "wep_micro_draco",
    textureName = "v4_micro_draco",
    skins = {
      [671] = "airsoft",
      [694] = "gingerbread",
      [740] = "easter"
    },
    sound = "draco",
    heating = 0.0325,
    cooling = 0.1,
    weaponWear = 0.01,
    muzzle = {
      4,
      19,
      0.25,
      0.575,
      0.43,
      -0.0085,
      0.1027,
      0.99382,
      -0.103684,
      0.039642
    },
    itemId = 492,
    ammoId = ammoIds["7.62x39"],
    skillBook = 546,
    weaponId = 29,
    damage = 9,
    boneId = {
      [3] = true,
      [25] = true,
      [35] = true
    },
    clothHide = false
  },
  ["wep_glock-17"] = {
    modelName = "wep_glock-17",
    skins = {
      [664] = "airsoft"
    },
    textureName = "3",
    sound = "bm9",
    heating = 0.075,
    cooling = 0.075,
    weaponWear = 0.05,
    muzzle = {
      3,
      13,
      0.065,
      0.25,
      0.2083,
      0.0389,
      0.1076,
      0.986938,
      0.080292,
      0.139666
    },
    itemId = 561,
    ammoId = ammoIds["9x19mm"],
    skillBook = 563,
    weaponId = 22,
    damage = 8,
    boneId = {
      [1] = true,
      [3] = true,
      [25] = true,
      [35] = true,
      [41] = true,
      [51] = true
    },
    clothHide = true
  },
  wep_p90 = {
    modelName = "wep_p90",
    heating = 0.039,
    cooling = 0.085,
    weaponWear = 0.01,
    skins = {
      [340] = "5",
      [341] = "6",
      [346] = "7",
      [347] = "8",
      [369] = "9",
      [557] = "1",
      [558] = "2",
      [559] = "3",
      [560] = "4",
      [669] = "airsoft",
      [741] = "10"
    },
    textureName = "p90tex",
    sound = "p90",
    muzzle = {
      7,
      18,
      0.175,
      0.45,
      0.3375,
      -0.014,
      0.1416,
      0.983577,
      -0.119891,
      0.13492
    },
    itemId = 556,
    ammoId = ammoIds["5.7x28"],
    skillBook = 564,
    weaponId = 29,
    damage = 7,
    boneId = {
      [1] = true,
      [3] = true,
      [25] = true,
      [35] = true,
      [41] = true,
      [51] = true
    },
    clothHide = false
  },
  wep_m700 = {
    modelName = "wep_m700",
    scope = "m700",
    skins = {
      [679] = "airsoft"
    },
    textureName = "bodybyaudi",
    sound = "m700",
    heating = 0.225,
    cooling = 0.095,
    weaponWear = 0.05,
    muzzle = {
      4,
      20,
      0.25,
      0.7,
      1.0736,
      -0.0558,
      0.2053,
      0.993135,
      -0.086408,
      0.078852
    },
    itemId = 562,
    ammoId = ammoIds["7.62x51"],
    skillBook = 565,
    weaponId = 34,
    damage = 60,
    boneId = {
      [3] = true,
      [25] = true,
      [35] = true
    },
    clothHide = false
  },
  wep_benelli_m4 = {
    modelName = "wep_benelli_m4",
    skins = {
      [490] = "1",
      [491] = "2",
      [672] = "airsoft"
    },
    heating = 0.1875,
    cooling = 0.09,
    weaponWear = 0.05,
    textureName = "v4_benelli_m4",
    muzzle = {
      5,
      20,
      0.225,
      0.9,
      0.8199,
      -0.0596,
      0.1978,
      0.986987,
      -0.11858,
      0.108607
    },
    sound = "shoti",
    itemId = 489,
    ammoId = ammoIds["12gauge"],
    skillBook = 566,
    weaponId = 25,
    damage = 50,
    boneId = {
      [3] = true,
      [25] = true,
      [35] = true
    },
    clothHide = false
  },
  sawnoff = {
    modelName = "sawnoff",
    skins = {
      [567] = "1",
      [568] = "2",
      [569] = "3",
      [570] = "4",
      [571] = "5",
      [572] = "6"
    },
    textureName = "db_shotgun",
    sound = "i_shoti",
    muzzle = {
      5,
      19,
      0.225,
      0.9,
      0.4851,
      0.0493,
      0.145,
      0.994343,
      0.073367,
      0.076805
    },
    itemId = 80,
    ammoId = ammoIds["12gauge"],
    skillBook = 244,
    weaponId = 26,
    damage = 40,
    boneId = {
      [1] = true,
      [3] = true,
      [25] = true,
      [35] = true,
      [41] = true,
      [51] = true
    },
    clothHide = false
  },
  knife = {
    modelName = "knifecur",
    skins = {
      [280] = "knife1",
      [281] = "knife2",
      [282] = "knife3",
      [407] = "knife4",
      [408] = "knife5",
      [409] = "knife6",
      [659] = "knife7",
      [691] = "knife8",
      [736] = "knife9" 
    },
    textureName = "kabar",
    itemId = 70,
    weaponId = 4,
    boneId = {
      [1] = true,
      [3] = true,
      [25] = true,
      [35] = true,
      [41] = true,
      [51] = true
    },
    clothHide = true
  },
  bard = {
    modelName = "wep_bard",
    skins = {
      [410] = "1",
      [411] = "2"
    },
    textureName = "cleaver01_ah_d",
    itemId = 102,
    weaponId = 4,
    boneId = {
      [1] = true,
      [3] = true,
      [25] = true,
      [35] = true,
      [41] = true,
      [51] = true
    },
    clothHide = true
  },
  katana = {
    modelName = "katana",
    textureName = "gun_katana",
    skins = {
      [692] = "1",
      [735] = "2"
    },
    itemId = 74,
    model = 339,
    weaponId = 8,
    boneId = {
      [3] = true
    },
    clothHide = false
  },
  wep_suspension = {
    modelName = "wep_suspension",
    itemId = 573,
    weaponId = 10,
    breakBone = true,
    boneId = {
      [1] = true,
      [3] = true,
      [25] = true,
      [35] = true,
      [41] = true,
      [51] = true
    },
    clothHide = true,
    skipSerial = true
  },
  wep_axe = {
    modelName = "wep_axe",
    itemId = 426,
    weaponId = 10,
    boneId = {
      [1] = true,
      [3] = true,
      [25] = true,
      [35] = true,
      [41] = true,
      [51] = true
    },
    clothHide = true,
    skipSerial = true
  },
  boxer = {
    itemId = 67,
    weaponId = 1,
    model = 331,
    boneId = {
      [1] = true,
      [3] = true,
      [25] = true,
      [35] = true,
      [41] = true,
      [51] = true
    },
    clothHide = true
  },
  golfclub = {
    itemId = 68,
    weaponId = 2,
    model = 333,
    boneId = {
      [3] = true,
      [25] = true,
      [35] = true
    },
    clothHide = false,
    skipSerial = true
  },
  nitestick = {
    itemId = 69,
    weaponId = 3,
    boneId = {
      [1] = true,
      [3] = true,
      [25] = true,
      [35] = true,
      [41] = true,
      [51] = true
    },
    clothHide = false,
    skipSerial = true
  },
  bat = {
    itemId = 71,
    weaponId = 5,
    model = 336,
    boneId = {
      [3] = true,
      [25] = true,
      [35] = true
    },
    clothHide = false,
    skipSerial = true
  },
  flower = {
    itemId = 103,
    weaponId = 14,
    model = 325,
    boneId = {
      [1] = true,
      [3] = true,
      [25] = true,
      [35] = true,
      [41] = true,
      [51] = true
    },
    clothHide = true,
    skipSerial = true
  },
  cane = {
    itemId = 104,
    weaponId = 15,
    model = 326,
    boneId = {
      [3] = true,
      [25] = true,
      [35] = true
    },
    clothHide = false,
    skipSerial = true
  },
  gun_para = {
    itemId = 107,
    weaponId = 46,
    model = 371,
    boneId = {
      [3] = true,
      [25] = true,
      [35] = true
    },
    clothHide = true,
    skipSerial = true
  },
  chnsaw = {
    itemId = 75,
    weaponId = 9,
    model = 341,
    boneId = {
      [3] = true,
      [25] = true,
      [35] = true
    },
    clothHide = false,
    skipSerial = true
  },
  spraycan = {
    itemId = 97,
    ammoId = 151,
    noReload = true,
    model = 365,
    canAmmo = true,
    weaponId = 41,
    boneId = {
      [1] = true,
      [3] = true,
      [41] = true,
      [51] = true
    },
    clothHide = true,
    skipSerial = true
  },
  fire_ex = {
    itemId = 98,
    selfCanAmmo = true,
    weaponId = 42,
    model = 366,
    boneId = {
      [3] = true,
      [25] = true,
      [35] = true
    },
    clothHide = true,
    skipSerial = true
  },
  camera = {
    itemId = 99,
    weaponId = 43,
    model = 367,
    boneId = {
      [3] = true,
      [25] = true,
      [35] = true
    },
    clothHide = true,
    skipSerial = true
  },
  grenade = {
    itemId = 93,
    weaponId = 16,
    model = 342,
    projectileAmmo = true,
    boneId = {
      [3] = true,
      [25] = true,
      [35] = true
    },
    clothHide = true
  },
  teargas = {
    itemId = 94,
    weaponId = 17,
    model = 343,
    projectileAmmo = true,
    boneId = {
      [3] = true,
      [25] = true,
      [35] = true
    },
    clothHide = true
  },
  molotov = {
    itemId = 95,
    weaponId = 18,
    model = 344,
    projectileAmmo = true,
    boneId = {
      [3] = true,
      [25] = true,
      [35] = true
    },
    clothHide = true
  },
  wep_vipera = {
    modelName = "wep_vipera",
    itemId = 574,
    weaponId = 10,
    breakBone = true,
    boneId = {
      [1] = true,
      [3] = true,
      [25] = true,
      [35] = true,
      [41] = true,
      [51] = true
    },
    clothHide = true
  },
  wep_pipe_wrench = {
    modelName = "wep_pipe_wrench",
    itemId = 582,
    weaponId = 10,
    boneId = {
      [1] = true,
      [3] = true,
      [25] = true,
      [35] = true,
      [41] = true,
      [51] = true
    },
    clothHide = true,
    skipSerial = true
  },
  wep_hammer = {
    modelName = "wep_hammer",
    itemId = 34,
    weaponId = 10,
    boneId = {
      [1] = true,
      [3] = true,
      [25] = true,
      [35] = true,
      [41] = true,
      [51] = true
    },
    clothHide = true,
    skipSerial = true
  },
  wep_taser_x26 = {
    modelName = "wep_taser_x26",
    laser = {
      0.1913,
      0.0349,
      0.0183,
      0.979252,
      0.056627,
      0.194573
    },
    itemId = 155,
    weaponId = 23,
    taser = true,
    boneId = {
      [1] = true,
      [3] = true,
      [25] = true,
      [35] = true,
      [41] = true,
      [51] = true
    },
    clothHide = true
  },
  wep_pickaxe = {
    modelName = "wep_pickaxe",
    itemId = 164,
    weaponId = 10,
    boneId = {
      [3] = true,
      [25] = true,
      [35] = true
    },
    clothHide = true,
    skipSerial = true
  },
  wep_pickaxe2 = {
    modelName = "wep_pickaxe2",
    itemId = 724,
    weaponId = 10,
    boneId = {
      [3] = true,
      [25] = true,
      [35] = true
    },
    clothHide = true,
    skipSerial = true
  },
  wep_pickaxe3 = {
    modelName = "wep_pickaxe3",
    itemId = 725,
    weaponId = 10,
    boneId = {
      [3] = true,
      [25] = true,
      [35] = true
    },
    clothHide = true,
    skipSerial = true
  },
  wep_pickaxe4 = {
    modelName = "wep_pickaxe4",
    itemId = 726,
    weaponId = 10,
    boneId = {
      [3] = true,
      [25] = true,
      [35] = true
    },
    clothHide = true,
    skipSerial = true
  },
  wep_pickaxe5 = {
    modelName = "wep_pickaxe5",
    itemId = 727,
    weaponId = 10,
    boneId = {
      [3] = true,
      [25] = true,
      [35] = true
    },
    clothHide = true,
    skipSerial = true
  },
  physgun = {
    modelName = "ggun",
    itemId = 609,
    weaponId = 31,
    damage = 0,
    boneId = {
      [3] = true,
      [25] = true,
      [35] = true
    },
    clothHide = true
  },
  flamethrower = {
    weaponId = 37,
    itemId = 609,
    damage = 0
  },
}
weaponRanges = {
  [22] = {
    60,
    0.5,
    "colt 45"
  },
  [23] = {
    65,
    0.5,
    "silenced"
  },
  [24] = {
    90,
    0.35,
    "deagle"
  },
  [25] = {
    15,
    2.5,
    "shotgun"
  },
  [26] = {
    10,
    4.5,
    "sawed-off"
  },
  [27] = {
    25,
    3.5,
    "combat shotgun"
  },
  [28] = {
    55,
    0.75,
    "uzi"
  },
  [29] = {
    95,
    0.35,
    "mp5"
  },
  [30] = {
    110,
    0.45,
    "ak-47"
  },
  [31] = {
    120,
    0.3,
    "m4"
  },
  [32] = {
    60,
    0.75,
    "tec9"
  },
  [33] = {
    300,
    0.2,
    "rifle"
  },
  [34] = {
    300,
    0.2,
    "sniper"
  }
}
ammoWeaponList = {}
for wp in pairs(customWeapons) do
  local ammo = customWeapons[wp].ammoId
  if ammo then
    if not ammoWeaponList[ammo] then
      ammoWeaponList[ammo] = {}
    end
    table.insert(ammoWeaponList[ammo], wp)
  end
  local wpid = customWeapons[wp].weaponId
  if wpid and weaponRanges[wpid] then
    customWeapons[wp].range = weaponRanges[wpid][1]
    customWeapons[wp].rangePow = weaponRanges[wpid][2]
  end
  if customWeapons[wp].muzzle then
    customWeapons[wp].muzzle[5] = customWeapons[wp].muzzle[5] + customWeapons[wp].muzzle[8] * 0.001
    customWeapons[wp].muzzle[6] = customWeapons[wp].muzzle[6] + customWeapons[wp].muzzle[9] * 0.001
    customWeapons[wp].muzzle[7] = customWeapons[wp].muzzle[7] + customWeapons[wp].muzzle[10] * 0.001
  end
end
function getAmmoWeapons(ammo)
  return ammoWeaponList[ammo]
end
weaponStatIds = {
  [22] = 69,
  [23] = 70,
  [24] = 71,
  [25] = 72,
  [26] = 73,
  [27] = 74,
  [28] = 75,
  [29] = 76,
  [30] = 77,
  [31] = 78,
  [32] = 75,
  [33] = 79,
  [34] = 79
}
usedGTAWeapons = {}
skillBooks = {}
weaponItemIds = {}
ammoItemIds = {}
local defaultWeaponModels = {
  [1] = 331,
  [2] = 333,
  [3] = 334,
  [4] = 335,
  [5] = 336,
  [6] = 337,
  [7] = 338,
  [8] = 339,
  [9] = 341,
  [10] = 321,
  [11] = 322,
  [12] = 323,
  [14] = 325,
  [15] = 326,
  [16] = 342,
  [17] = 343,
  [18] = 344,
  [22] = 346,
  [23] = 347,
  [24] = 348,
  [25] = 349,
  [26] = 350,
  [27] = 351,
  [28] = 352,
  [29] = 353,
  [30] = 355,
  [31] = 356,
  [32] = 372,
  [33] = 357,
  [34] = 358,
  [35] = 359,
  [36] = 360,
  [37] = 361,
  [38] = 362,
  [39] = 363,
  [40] = 364,
  [41] = 365,
  [42] = 366,
  [43] = 367,
  [44] = 368,
  [45] = 369,
  [46] = 371
}
function getWeaponClothesshopData(itemId)
  local wep = weaponItemIds[itemId]
  if wep then
    if customWeapons[wep].modelName then
      return customWeapons[wep].modelName, customWeapons[wep].boneId or 3, customWeapons[wep].clothHide
    end
    if customWeapons[wep].weaponId then
      return defaultWeaponModels[customWeapons[wep].weaponId], customWeapons[wep].boneId or 3, customWeapons[wep].clothHide
    end
  end
  return false
end
for id, dat in pairs(customWeapons) do
  if dat.itemId then
    weaponItemIds[dat.itemId] = id
  end
  if dat.skins then
    for si in pairs(dat.skins) do
      weaponItemIds[si] = id
    end
  end
  if dat.ammoId then
    ammoItemIds[dat.ammoId] = id
  end
  if dat.skillBook then
    if not skillBooks[dat.skillBook] then
      skillBooks[dat.skillBook] = {}
    end
    table.insert(skillBooks[dat.skillBook], id)
  end
  usedGTAWeapons[dat.weaponId] = true
end
for i = 0, 18 do
  usedGTAWeapons[i] = nil
end
function isStackable(wep)
  if customWeapons[wep] then
    return customWeapons[wep].projectileAmmo or customWeapons[wep].selfCanAmmo
  end
  return false
end
function getWeaponId(wep)
  if customWeapons[wep] then
    return customWeapons[wep].weaponId
  end
  wep = tonumber(wep)
  if weaponItemIds[wep] then
    wep = weaponItemIds[wep]
    return customWeapons[wep].weaponId
  end
  return false
end
function getSkipSerial(wep)
  if customWeapons[wep] then
    return customWeapons[wep].skipSerial
  end
  return false
end
function getMainItemID(wep)
  if customWeapons[wep] then
    return customWeapons[wep].itemId
  end
  return false
end
function getWeaponSkins(wep)
  if customWeapons[wep] then
    return customWeapons[wep].skins
  end
  return false
end
function getAmmoId(wep)
  if customWeapons[wep] then
    return customWeapons[wep].ammoId
  end
  return false
end
function getWeaponItemIds()
  return weaponItemIds
end
function getAmmoItemIds()
  return ammoItemIds
end
function getSkillBooks()
  return skillBooks
end
function isSkinItemId(itemId)
  for _, weaponData in pairs(customWeapons) do
    if weaponData.skins and weaponData.skins[itemId] then
      return true
    end
  end
  return false
end
function canFixWeapon(itemId)
  local wep = weaponItemIds[itemId]
  if customWeapons[wep] and customWeapons[wep].skins and customWeapons[wep].skins[itemId] then
    return true
  end
  return false
end


airsoftSounds = {
  --Pisztoly
  ["wep_glock-19"] = "airsoft3",
  ["wep_glock-17"] = "airsoft3",
  desert_eagle = "airsoft3",
  --SMG
  ["uzi"] = "airsoft2",
  tec9 = "airsoft2",
  ["mp5lng"] = "airsoft2",
  wep_p90 = "airsoft2",
  wep_mp7a1 = "airsoft2",
  --AR
  wep_micro_draco = "airsoft5",
  ak47 = "airsoft5",
  wep_m4a1 = "airsoft5",
  ["wep_ar-15"] = "airsoft5",
  ["wep_ak-74"] = "airsoft5",
  --SHOTGUN
  wep_benelli_m4 = "airsoft1",
  ["spaz-12"] = "airsoft1",
  --SNIPER
  rifle = "airsoft4",
  sniper = "airsoft4",
  wep_m700 = "airsoft4",
  wep_m110 = "airsoft4"
}

function getWeaponDamage(wep)
  return customWeapons[wep].damage
end