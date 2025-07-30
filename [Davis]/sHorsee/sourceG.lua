horseNum = 6
goHomeTime = 22
goHomeEndFade = 1.5 / goHomeTime
seats = 10
minBet = 100
minBetSide = 50
minBetOverall = math.min(minBet, minBetSide)
horseColors = {
  {
    60,
    184,
    130
  },
  {
    245,
    110,
    110
  },
  {
    49,
    154,
    215
  },
  {
    210,
    205,
    210
  },
  {
    255,
    149,
    20
  },
  {
    204,
    111,
    242
  }
}
coinValues = {
  5,
  25,
  50,
  100,
  500,
  1000,
  5000
}
maxCoinValue = coinValues[#coinValues]
for i = 1, #coinValues do
  if coinValues[i] >= minBet then
    minCoin = i
    break
  end
end
for i = 1, #coinValues do
  if coinValues[i] >= minBetSide then
    minCoinSide = i
    break
  end
end
minCoinOverall = math.min(minCoin, minCoinSide)
horseSeats = {
  {
    -2.75,
    2.07158,
    1.1,
    -90
  },
  {
    -2.75,
    0.690524,
    1.1,
    -90
  },
  {
    -2.75,
    -0.690524,
    1.1,
    -90
  },
  {
    -2.75,
    -2.07158,
    1.1,
    -90
  },
  {
    -0.69,
    -4.07,
    1.1,
    0
  },
  {
    0.69,
    -4.07,
    1.1,
    0
  },
  {
    2.75,
    -2.07158,
    1.1,
    90
  },
  {
    2.75,
    -0.690524,
    1.1,
    90
  },
  {
    2.75,
    0.690524,
    1.1,
    90
  },
  {
    2.75,
    2.07158,
    1.1,
    90
  }
}
syncZoneCoords = {
  [1] = {
    1041.5185546875,
    -1557.923828125,
    95.099609,
    98.515625,
    10,
    3,
    "Admiral Casino"
  },
  [3] = {
    1918.8002,
    961.8665,
    109.393,
    111.912,
    10,
    17282,
    "Los Santos Casino"
  },
  [4] = {
    1918.8002,
    961.8665,
    109.393,
    111.912,
    10,
    23763,
    "San Fierro Casino"
  }
}
tableList = {
  {
    1069.092,
    -1547.8801,
    10033.1464,
    180,
    10,
    3
  },
  {
    1054.7899,
    -1547.8801,
    10033.1464,
    180,
    10,
    3
  },
  {
    1055.2899,
    -1532.0234,
    10033.1464,
    0,
    10,
    3
  },
  {
    1121.3764,
    -1530.5466,
    10040.478922,
    -90,
    10,
    3
  },
  {
    1121.3764,
    -1546.0501,
    10040.478922,
    -90,
    10,
    3
  },
  {
    1106.83527,
    -1546.3623,
    10040.478922,
    180,
    10,
    3
  },
  {
    1959.8862,
    1028.3999,
    991.4712,
    0,
    10,
    17282
  },
  {
    1959.8862,
    1007.3159,
    991.4712,
    180,
    10,
    17282
  },
  {
    1939.3807,
    1022.5853,
    991.4712,
    180,
    10,
    17282
  },
  {
    1939.3807,
    1013.0352,
    991.4712,
    0,
    10,
    17282
  },
  {
    1959.8862,
    1028.3999,
    991.4712,
    0,
    10,
    23763
  },
  {
    1959.8862,
    1007.3159,
    991.4712,
    180,
    10,
    23763
  },
  {
    1939.3807,
    1022.5853,
    991.4712,
    180,
    10,
    23763
  },
  {
    1939.3807,
    1013.0352,
    991.4712,
    0,
    10,
    23763
  }
}
tablesPerDimension = {}
for i = 1, #tableList do
  if tableList[i] then
    if not tablesPerDimension[tableList[i][6]] then
      tablesPerDimension[tableList[i][6]] = {}
    end
    table.insert(tablesPerDimension[tableList[i][6]], i)
  end
end
countdownTime = 60
betWait = 350
horseNames = {
  "Ludmilla",
  "Kupakszemű",
  "Bánat",
  "Nemigaz",
  "Körni",
  "Kicsikamat",
  "Büdös búvár",
  "Gyomros",
  "Jóvanaz",
  "Nokedli",
  "Jesse mó",
  "Pötyi",
  "Álom",
  "Asterix",
  "Árnyék",
  "Alibaba",
  "Adél",
  "Álmi",
  "Angyal",
  "Ábránd",
  "Bájos",
  "Bajnok",
  "Bambi",
  "Bella",
  "Báttya",
  "Baltazár",
  "Benga",
  "Borika",
  "Betyár",
  "Csimpi",
  "Csibész",
  "Calypso",
  "Cecil",
  "Dzsoni",
  "Délceg",
  "Doki",
  "Dodo",
  "Drazsé",
  "Drágám",
  "Domino",
  "Dömper",
  "Dögös",
  "Dolly",
  "Elvis",
  "Életem",
  "Ében",
  "Escobar",
  "Elza",
  "Füge",
  "Frutti",
  "Frenky",
  "Foltos",
  "Fáraó",
  "Főnix",
  "Fagyi",
  "Frédi",
  "Fabolous",
  "Galagonya",
  "Galaxis",
  "Galiba",
  "Gypsi",
  "Goldie",
  "Gyémi",
  "Gyémánt",
  "Gyarló",
  "Gesztenye",
  "Gizmó",
  "Gloria",
  "Gólem",
  "Géniusz",
  "Gringó",
  "Góliát",
  "Gino",
  "Gelesztás",
  "Ibike",
  "Illúzió",
  "Indigó",
  "Italos",
  "Indián",
  "Indián Joe",
  "Irgalmas",
  "Izi",
  "Jack",
  "Jackson",
  "Jampi",
  "Jampec",
  "Jágó",
  "Jolly",
  "Jimmy",
  "Kajla",
  "Kalóz",
  "Kedves",
  "Király",
  "Királynő",
  "Kiscsillag",
  "Kleopátra",
  "Kefír",
  "Konok",
  "Kobold",
  "Kamilla",
  "Kakaó",
  "Kispajtás",
  "Kaland",
  "Körte",
  "Lady",
  "Lil Lada",
  "Lajcsi",
  "Legenda",
  "Lancelot",
  "Lázadó",
  "Leila",
  "Lia",
  "Leonidasz",
  "Lepke",
  "Liza",
  "Lollipop",
  "Lucky",
  "Matróz",
  "Muki",
  "Maci",
  "Manci",
  "Missy",
  "Maximus",
  "Mercedes",
  "Mese",
  "Mokka",
  "Mustang",
  "Moncsicsi",
  "Morcos",
  "Mohikán",
  "Mars",
  "Mogyoró",
  "Málna",
  "Napocska",
  "Napsugár",
  "Nagylada",
  "Nyeremény",
  "Nelly",
  "Noé",
  "Nero",
  "Olimpia",
  "Okos",
  "Olivér",
  "Oxford",
  "Öcsi",
  "Ördög",
  "Pablo",
  "Pamacs",
  "Party",
  "Papám",
  "Popeye",
  "Pazarló",
  "Pedró",
  "Pegazus",
  "Penge",
  "Pumukli",
  "Pengő",
  "Pejko",
  "Peggy",
  "Pepino",
  "Plútó",
  "Pipacs",
  "Príma",
  "Patás",
  "Rabló",
  "Rainbow",
  "Rakéta",
  "Ramóna",
  "Rejtély",
  "Remény",
  "Ria",
  "Remete",
  "Ribizli",
  "Rocky",
  "Römi",
  "Suttogó",
  "Setemény",
  "Stella",
  "Stallone",
  "Silver",
  "Sunshine",
  "Szerény",
  "Szilaj",
  "Szépfiú",
  "Szelíd",
  "Üstökös",
  "Úrfi",
  "Unicum",
  "Urmácska",
  "Ursula",
  "Vadóc",
  "Vinetu",
  "Vándor",
  "Vadló",
  "Vadalma",
  "Valutás",
  "Vadvirág",
  "Vagány",
  "Vanília",
  "Valéria",
  "Vénusz",
  "Versace",
  "Virgonc",
  "Véglet",
  "Vihar",
  "Vidám",
  "Villám",
  "Virtuóz",
  "Vipera",
  "Venom",
  "Vuki",
  "Willy",
  "Xénia",
  "Zorró",
  "Zugló",
  "Zengő",
  "Zafír",
  "Zarándok",
  "Zsemle",
  "Zseniális",
  "Zsivány",
  "Zuzmó",
  "Zseton",
  "Macsinó",
  "Latte",
  "Kató",
  "Faló",
  "Maló",
  "Csaló",
  "Trikszi",
  "Rozi",
  "Maró",
  "Dózis",
  "Adag",
  "Bogár",
  "Bandi"
}
cupNames = {
  "Jani kupa",
  "Kapa-kupa",
  "MiguMeistertaile kupa",
  "Liqui Family kupa",
  "Sight City Park kupa",
  "Las Venturas Park kupa",
  "Los Santos Park kupa",
  "San Fierro Park kupa",
  "Victoria Park kupa",
  "Pershing Square kupa",
  "SightRing kupa",
  "SightRing kupa",
  "Bayside kupa",
  "Magyar Derby",
  "Aqueduct",
  "Las Virgenes",
  "Jenny Wiley",
  "Shoemaker Mile",
  "Mother Goose",
  "Diana Stakes",
  "American Oaks",
  "Warwick",
  "Sedgefield",
  "Kincsem kupa",
  "Gold Cup"
}
function floorOdds(odds)
  if 100 <= odds then
    return math.floor(odds + 0.5)
  elseif 10 <= odds then
    return math.floor(odds * 10 + 0.5) / 10
  end
  return math.floor(odds * 100 + 0.5) / 100
end
