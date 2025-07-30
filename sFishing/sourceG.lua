fishingLineColors = {
  {
    173,
    176,
    151,
    "bézs"
  },
  {
    163,
    244,
    171,
    "zöld"
  },
  {
    210,
    210,
    255,
    "fehér"
  },
  {
    255,
    140,
    140,
    "piros"
  },
  {
    222,
    222,
    110,
    "sárga"
  },
  {
    255,
    150,
    255,
    "pink"
  },
  {
    100,
    200,
    255,
    "kék"
  }
}
function getFishingLineColor(id)
  id = tonumber(id)
  if fishingLineColors[id] then
    return fishingLineColors[id]
  end
end
function isFloatSkinValid(id)
  id = tonumber(id)
  return 1 <= id and id <= 4
end
function fishingToRealWorldCoords(client, r, d)
  local rx, ry, rz = getElementRotation(client)
  rz = math.rad(rz + 90)
  local sin = math.sin(r + rz)
  local cos = math.cos(r + rz)
  local px, py, pz = getElementPosition(client)
  return px + d * cos, py + d * sin
end
function checkPosesForSync(x, y, z, x2, y2, z2, mode)
  return getDistanceBetweenPoints3D(x, y, z, x2, y2, z2) > (mode == "catching" and 0.025 or 0.1)
end
fishTypes = {
  sight_fish_mackerel = {
    model = "v4_fish_mackerel",
    name = "Makréla",
    nameEx = "makrélát",
    sellableFish = true,
    length = 0.402829,
    previewLength = 0.134241,
    height = 0.021172,
    weight = {
      1,
      5,
      1,
      1.3
    },
    item = 631
  },
  sight_fish_hardheadcatfish = {
    model = "v4_fish_hardheadcatfish",
    name = "Keményfejű harcsa",
    nameEx = "keményfejű harcsát",
    sellableFish = true,
    length = 0.579515,
    previewLength = 0.183608,
    height = 0.025234,
    weight = {
      1,
      10,
      0.8,
      1.3
    },
    item = 632
  },
  sight_fish_snapper = {
    model = "v4_fish_snapper",
    name = "Csattogóhal",
    nameEx = "csattogóhalat",
    sellableFish = true,
    length = 0.589667,
    previewLength = 0.19652,
    height = 0.050125,
    weight = {
      2,
      15,
      0.8,
      1.3
    },
    item = 633
  },
  sight_fish_yellowtailsnapper = {
    model = "v4_fish_yellowtailsnapper",
    name = "Sárgafarkú csattogóhal",
    nameEx = "sárgafarkú csattogóhalat",
    sellableFish = true,
    length = 0.640533,
    previewLength = 0.216426,
    height = 0.054449,
    weight = {
      2,
      15,
      0.8,
      1.3
    },
    item = 634
  },
  sight_fish_snapper_leg = {
    class = "Legendary",
    classColor = "sightpurple",
    model = "v4_fish_snapper_leg",
    name = "Legendary Csattogóhal",
    nameEx = "legendary csattogóhalat",
    sellableFish = true,
    length = 0.726116,
    previewLength = 0.245344,
    height = 0.061724,
    weight = {
      15,
      20,
      0.9,
      1.2
    },
    item = 635
  },
  sight_fish_redsalmon = {
    model = "v4_fish_redsalmon",
    name = "Vörös lazac",
    nameEx = "vörös lazacot",
    sellableFish = true,
    length = 0.690272,
    previewLength = 0.251439,
    height = 0.069008,
    weight = {
      5,
      12,
      0.8,
      1.25
    },
    item = 636
  },
  sight_fish_pinksalmon = {
    model = "v4_fish_pinksalmon",
    name = "Rózsaszín lazac",
    nameEx = "rózsaszín lazacot",
    sellableFish = true,
    length = 0.791416,
    previewLength = 0.287634,
    height = 0.077053,
    weight = {
      5,
      12,
      0.8,
      1.25
    },
    item = 637
  },
  sight_fish_tunabluefin = {
    model = "v4_fish_tunabluefin",
    name = "Kékúszójú tonhal",
    nameEx = "kékúszójú tonhalat",
    sellableFish = true,
    length = 0.800695,
    previewLength = 0.253344,
    height = 0.06859,
    weight = {
      10,
      50,
      1.1,
      1.7
    },
    item = 638
  },
  sight_fish_tunayellowfin = {
    model = "v4_fish_tunayellowfin",
    name = "Sárgaúszójú tonhal",
    nameEx = "sárgaúszójú tonhalat",
    sellableFish = true,
    length = 0.800695,
    previewLength = 0.253344,
    height = 0.06859,
    weight = {
      10,
      50,
      1.1,
      1.7
    },
    item = 639
  },
  sight_fish_rooster = {
    model = "v4_fish_rooster",
    name = "Kakashal",
    nameEx = "kakashalat",
    sellableFish = true,
    length = 1.00003,
    previewLength = 0.303493,
    height = 0.090114,
    weight = {
      10,
      40,
      0.8,
      1.2
    },
    item = 640
  },
  sight_fish_rooster_leg = {
    class = "Legendary",
    classColor = "sightpurple",
    model = "v4_fish_rooster_leg",
    name = "Legendary Kakashal",
    nameEx = "legendary kakashalat",
    sellableFish = true,
    length = 1.18155,
    previewLength = 0.357844,
    height = 0.113248,
    weight = {
      30,
      40,
      1,
      1.2
    },
    item = 641
  },
  sight_fish_swordfish = {
    model = "v4_fish_swordfish",
    name = "Kardhal",
    nameEx = "kardhalat",
    sellableFish = true,
    length = 1.30176,
    previewLength = 0.363215,
    height = 0.099308,
    weight = {
      10,
      45,
      0.8,
      1.1
    },
    item = 642
  },
  sight_fish_mahi = {
    model = "v4_fish_mahi",
    name = "Mahi-mahi",
    nameEx = "mahi-mahit",
    sellableFish = true,
    length = 1.00431,
    previewLength = 0.317332,
    height = 0.112133,
    weight = {
      10,
      30,
      0.7,
      1.1
    },
    item = 643
  },
  sight_fish_mahi_leg = {
    class = "Legendary",
    classColor = "sightpurple",
    model = "v4_fish_mahi_leg",
    name = "Legendary Mahi-mahi",
    nameEx = "legendary mahi-mahit",
    sellableFish = true,
    length = 1.30112,
    previewLength = 0.410878,
    height = 0.144108,
    weight = {
      30,
      40,
      0.9,
      1.1
    },
    item = 644
  },
  sight_fish_makoshark = {
    model = "v4_fish_makoshark",
    name = "Makócápa",
    nameEx = "makócápát",
    sellableFish = true,
    length = 1.61124,
    previewLength = 0.50739,
    height = 0.09738,
    weight = {
      10,
      50,
      0.5,
      1
    },
    item = 645
  },
  sight_fish_tigershark = {
    model = "v4_fish_tigershark",
    name = "Tigriscápa",
    nameEx = "tigriscápát",
    sellableFish = true,
    length = 1.80773,
    previewLength = 0.565378,
    height = 0.109256,
    weight = {
      10,
      50,
      0.5,
      1
    },
    item = 646
  },
  sight_fish_greatwhite = {
    model = "v4_fish_greatwhite",
    name = "Fehér cápa",
    nameEx = "fehér cápát",
    sellableFish = true,
    length = 2.2629,
    previewLength = 0.693678,
    height = 0.136406,
    weight = {
      20,
      55,
      0.5,
      1
    },
    item = 647
  },
  sight_fish_greatwhite_leg = {
    class = "Legendary",
    classColor = "sightpurple",
    model = "v4_fish_greatwhite_leg",
    name = "Legendary Fehér cápa",
    nameEx = "legendary fehér cápát",
    sellableFish = true,
    length = 2.8235,
    previewLength = 0.86468,
    height = 0.170647,
    weight = {
      50,
      60,
      0.8,
      1
    },
    item = 648
  },
  rolex = {
    model = "sight_gold_green_rolex_watch",
    nonAlive = true,
    name = "Arany óra",
    nameEx = "arany órát",
    weight = 0.5,
    item = 460
  },
  chain = {
    model = "sight_gold_vastag_nyaklanc",
    nonAlive = true,
    name = "Arany lánc",
    nameEx = "arany láncot",
    weight = 0.5,
    scale = 1.5,
    item = 465
  },
  starfish = {
    modelId = 902,
    nonAlive = true,
    name = "Tengericsillag",
    nameEx = "tengericsillagot",
    weight = 1,
    scale = 0.1,
    doublesided = true
  },
  jellyfish = {
    modelId = 1603,
    nonAlive = true,
    name = "Medúza",
    nameEx = "medúzát",
    weight = 1,
    scale = 0.25
  },
  jellyfish2 = {
    modelId = 1602,
    nonAlive = true,
    name = "Medúza",
    nameEx = "medúzát",
    weight = 1,
    scale = 0.25
  },
  oyster = {
    modelId = 953,
    nonAlive = true,
    name = "Kagyló",
    nameEx = "kagylót",
    weight = 0.5,
    scale = 0.25,
    item = 649
  },
  oyster_empty = {
    modelId = 953,
    nonAlive = true,
    name = "Kagyló",
    nameEx = "kagylót",
    weight = 0.5,
    scale = 0.25,
    item = 650
  },
  ball = {
    modelId = 1598,
    nonAlive = true,
    name = "Labda",
    nameEx = "labdát",
    weight = 0.5,
    scale = 0.25
  },
  szatyor = {
    model = "sight_szatyor",
    nonAlive = true,
    name = "Szatyor",
    nameEx = "szatyrot",
    weight = 0.1,
    scale = 1
  },
  chest = {
    event = true,
    model = "v4_fishing_chest_catch",
    nonAlive = true,
    name = "Fishing Chest",
    nameEx = "Fishing Chestet",
    weight = 2,
    scale = 1,
    item = 653
  }
}
function calculateFishLength(fish, weight)
  local fishType = fishTypes[fish]
  if fishType then
    local scale = 1
    if weight and type(fishType.weight) == "table" then
      scale = (weight - fishType.weight[1]) / (fishType.weight[2] - fishType.weight[1]) * (fishType.weight[4] - fishType.weight[3]) + fishType.weight[3]
    end
    return math.floor((fishType.length or 0) * scale * 100)
  end
  return 0
end
chances = {}
chances.sight_fish_mackerel = 15
chances.sight_fish_hardheadcatfish = 10
chances.sight_fish_snapper = 10
chances.sight_fish_yellowtailsnapper = 10
chances.sight_fish_redsalmon = 10
chances.sight_fish_pinksalmon = 10
chances.sight_fish_tunayellowfin = 8
chances.sight_fish_tunabluefin = 8
chances.sight_fish_mahi = 7
chances.sight_fish_rooster = 5
chances.sight_fish_swordfish = 5
chances.sight_fish_tigershark = 3
chances.sight_fish_makoshark = 3
chances.sight_fish_greatwhite = 2
chances.sight_fish_snapper_leg = 1
chances.sight_fish_rooster_leg = 1
chances.sight_fish_mahi_leg = 1
chances.sight_fish_greatwhite_leg = 1
chances.szatyor = 3
chances.rolex = 2
chances.oyster = 2
chances.oyster_empty = 2
chances.ball = 3
chances.chain = 1.7
chances.starfish = 3
chances.jellyfish = 3
chances.jellyfish2 = 3
chances.chest = 1
chanceSum = 0
for k, data in pairs(fishTypes) do
  data.catchChance = chances[k] or 0
  if not data.event then
    chanceSum = chanceSum + data.catchChance
  end
end
local toClass = {}
for k, data in pairs(fishTypes) do
  if not data.class and data.previewLength then
    table.insert(toClass, {
      k,
      data.catchChance
    })
  end
end
table.sort(toClass, function(a, b)
  return a[2] > b[2]
end)
local common = math.ceil(#toClass / 2)
local rare = math.ceil(#toClass * 0.25)
for i = 1, #toClass do
  if 0 < common then
    common = common - 1
    fishTypes[toClass[i][1]].class = "Common"
    fishTypes[toClass[i][1]].classColor = "sightmidgrey"
  elseif 0 < rare then
    rare = rare - 1
    fishTypes[toClass[i][1]].class = "Rare"
    fishTypes[toClass[i][1]].classColor = "sightyellow"
  else
    fishTypes[toClass[i][1]].class = "Epic"
    fishTypes[toClass[i][1]].classColor = "sightred"
  end
end
local basePrice = 40000
fishSellableItems = {}
for k, data in pairs(fishTypes) do
  if data.sellableFish then
    local weight = tonumber(data.weight) or (data.weight[2] - data.weight[1]) * 0.4 + data.weight[1]
    data.price = basePrice / (data.catchChance / chanceSum * 100) / weight
    fishSellableItems[data.item] = data
  end
end
dropoffPoses = {
  {
    -2056.3994,
    -2462.2002,
    29.7,
    -128.5
  },
  {
    -1501.8,
    1955.7,
    47.5,
    89.5
  }
}
displayPoses = {
  {
    2157.46484375,
    -97.6298828125,
    2.8015184402466,
    170.53
  },
  {
    2114.5185546875,
    194.0791015625,
    1.4524021148682,
    281
  }
}
