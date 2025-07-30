goldSellPoses = {
  {
    -2617.6337890625,
    186.6621093755,
    4,
    138,
    269,
    "Ben Christensen"
  },
  {
    -1636.0390625,
    -2233.5517578125,
    31.4765625,
    221,
    14,
    "John Williams"
  },
  {
    -2205.3125,
    -22.890625,
    35.3203125,
    18.317230224609,
    53,
    "Earl Shimer"
  },
  {
    -1782.7509765625,
    1229.2255859375,
    32.65625,
    131,
    56,
    "Bruce Gutshall"
  },
  {
    -2186.91015625,
    710.4423828125,
    53.890625,
    229,
    61,
    "James Bryne"
  },
  {
    -1675.4287109375,
    1008.9423828125,
    7.9,
    315,
    76,
    "Stanley Mendenhall"
  }
}
function getGoldSellPoses()
  return goldSellPoses
end

moneyStackSellPoses = {
    {
      -757.2587890625,
      -134.0986328125,
      65.828125,
      328
    },
    {
      -44.9248046875,
      55.9404296875,
      3.1171875,
      205
    },
    {
      301.765625,
      -187.8662109375,
      1.578125,
      314
    },
    {
      1186.6806640625,
      146.2392578125,
      20.541748046875,
      287
    },
    {
      2113.125,
      193.4306640625,
      1.479190826416,
      87
    },
    {
      -2620.1728515625,
      2236.7333984375,
      5.194242477417,
      326
    },
    {
      2427.2802734375, 
      -1309.4204101562, 
      25.609796524048,
      222
    },
    {
      2542.4621582031, 
      -369.96133422852, 
      77.349555969238,
      117
    }
  }
  
  moneyStackSkins = {
    15,
    28,
    30,
    39,
    52,
    67,
    109,
    125,
    155,
    223,
    292,
    300,
    303,
    311
}

surNames = {
    "Bell",
    "Walsh",
    "Black",
    "Butler",
    "Thompson",
    "O\'connor",
    "Marquez",
    "Morales",
    "Douglas",
    "Hendrix",
    "Chapman",
    "Adams",
    "Harper",
    "Saunders",
    "Reynolds",
    "Wong",
    "Leon",
    "Mayo",
    "Donaldson",
    "Stewart",
    "Wallace",
    "Sutton",
    "Shaw",
    "Carson",
    "Ferrell",
    "Donovan",
    "Mathis",
    "Riley",
    "West",
    "Stone",
    "Hughes",
    "Lawson",
    "Zamora",
    "Cotton",
    "Silva",
    "Frye",
    "Townsend",
    "Hopkins",
    "Brown",
    "Kelly",
    "Harris",
    "Harvey",
    "Sparks",
    "Gonzales",
    "Lane",
    "Meyer",
    "Vazquez",
    "Day",
    "Hayes",
    "Wilson",
    "Howard",
    "Jordan",
    "Mills",
    "Daugherty",
    "Manning",
    "Franklin",
    "Duffy"
  }
  maleNames = {
    "Jess",
    "Leigh",
    "Elliot",
    "Rory",
    "Silver",
    "Emerson",
    "Kris",
    "Tyler",
    "Casey",
    "Ashton",
    "Sam",
    "Taylor",
    "Ollie",
    "Christoph",
    "Brennen",
    "Cedric",
    "Otto",
    "Colten",
    "Jameson",
    "Morgan",
    "Bobby",
    "Anthony",
    "Arthur",
    "Leo",
    "Gilbert",
    "Jaycob",
    "Wade",
    "Louis",
    "Jake",
    "Declan",
    "Kian",
    "Charles",
    "Kayson",
    "Bryan",
    "Caiden",
    "Foster",
    "Moshe",
    "Zak",
    "Alex",
    "Lucas",
    "Oliver",
    "Atticus",
    "Randall",
    "Prince",
    "Royce",
    "Jalen",
    "Kayden",
    "Matthew",
    "Ryan",
    "Edward",
    "Levi",
    "Fletcher",
    "William",
    "Hassan",
    "Ernesto"
  }

for i = 1, #moneyStackSellPoses do
    moneyStackSellPoses[i][5] = moneyStackSkins[math.random(1, #moneyStackSkins)]
    moneyStackSellPoses[i][6] = string.format("%s %s", maleNames[math.random(1, #maleNames)], surNames[math.random(1, #surNames)])
end

negotiationTexts = {
    "Szép napot. Érdekesnek tűnik, mennyit kér érte?",
    "Jó napot kívánok! Szép portéka, mi az ára?",
    "Szép napot. Mennyi az annyi?",
    "Mit szólna $ dollárhoz? Ennyit érne meg nekem.",
    "Legyen $ dollár.",
    "Mit szólna $ dollárhoz?",
    "Ez nekem $ dollárt ér.",
    "Az utolsó ajánlatom $ dollár!",
    "$ dollár a vége, ennél többet nem adok!",
    "Áll az alku! Megállapodtunk $ dollárban! Kezet rá!",
    "Ez irreális ajánlat, kicsit engedjen Ön is!",
    "Kicsit engedjen Ön is!",
    "Szevasz. Ó a híres Aranyrúd? Mennyit szeretnél érte?",
    "Szeva! Mi a...?!Érdekel! Mennyit kérsz érte? ",
    "Hi! Ó a híres \"lophatatlan\" aranyrúd?! Mennyiért akarod eladni?",
    "Mit szólnál $ dollárhoz? Ennyit érne meg nekem.",
    "Legyen $ dollár.",
    "Mit szólnál $ dollárhoz?",
    "Ez nekem $ dollárt ér.",
    "Az utolsó ajánlatom $ dollár!",
    "$ dollár a vége, ennél többet nem adok!",
    "Áll az alku! Megállapodtunk $ dollárban! Kezet rá!",
    "Ez teljesen irreális, engedj belőle!",
    "Kicsit engedj te is!",
    "Szevasz. Na... Csak nem a híres jelölt pénz? Mennyit szeretnél érte?",
  }
playerReplys = {
  "Az ajánlatom $ dollár.",
  "Mit szólna $ dollárhoz?",
  "Legyen $ dollár.",
  "$ dollárt kérek érte.",
  "Áll az alku! Kezet rá!",
  "Az ajánlatom $ dollár.",
  "Mit szólnál $ dollárhoz?",
  "Legyen $ dollár.",
  "$ dollárt kérek érte.",
  "Áll az alku! Kezet rá!"
}
pawnSellPosX, pawnSellPosY, pawnSellPosZ, pawnSellPosR = 251.6943359375, -53.9775390625, 1.5776442289352, 180
pawnItems = {
  [465] = 50000,
  [254] = 45000,
  [158] = 100000,
  [464] = 40000,
  [122] = 25000,
  [461] = 25000,
  [460] = 42000,
  [467] = 41000,
  [466] = 39000,
  [462] = 38500,
  [468] = 46000,
  [463] = 41000,
  [253] = 41000,
  [260] = 60000,
  [259] = 60000,
  [728] = 440000, -- Pecsétgyúrú, amúgy 110-440k kellene lennie
  [117] = 60000,
  [651] = 42000,
  [652] = 200000
}
mineItems = {
  [723] = 1000,
  [702] = 1000,
  [703] = 1000,
  [704] = 1000,
  [705] = 1000,
  [706] = 1000,
  [707] = 1000,
  [708] = 1000,
  [709] = 1000,
  [710] = 1000,
  [711] = 1000,
  [712] = 1000,
  [713] = 1000,
  [714] = 1000,
}
local refreshTimer = nil

mineItemNames = {
  [723] = "SRC",
  [702] = "AMB",
  [703] = "AME",
  [704] = "ALU",
  [705] = "CHR",
  [706] = "COL",
  [707] = "COP",
  [708] = "DIA",
  [709] = "EMD",
  [710] = "GOL",
  [711] = "IRN",
  [712] = "NIK",
  [713] = "PLT",
  [714] = "RUB",
}

function refreshPrices()
  for k, v in pairs(mineItems) do
    mineItems[k] = (exports.sTrading:getPrice(mineItemNames[k]) or 1)
  end
end
refreshPrices()
refreshTimer = setTimer(refreshPrices, 60000 * 5, 0)
