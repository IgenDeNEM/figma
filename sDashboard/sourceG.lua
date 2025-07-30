intiSlotPrice = 100
vehSlotPrice = 100
animalsToBuy = {
  {"Husky", 9000},
  {"Rottweiler", 6000},
  {"Doberman", 8000},
  {
    "Bull Terrier",
    9000
  },
  {"Boxer", 7000},
  {
    "Francia Bulldog",
    10000
  }
}
walkingStyles = {
  {118, "Stílus #1"},
  {119, "Stílus #2"},
  {120, "Stílus #3"},
  {123, "Stílus #4"},
  {124, "Stílus #5"},
  {121, "Stílus #6"},
  {122, "Stílus #7"},
  {126, "Stílus #8"},
  {128, "Stílus #9"},
  {
    133,
    "Stílus #10"
  },
  {
    129,
    "Stílus #11"
  },
  {
    131,
    "Stílus #12"
  },
  {
    134,
    "Stílus #13"
  },
  {
    137,
    "Stílus #14"
  },
  {
    135,
    "Stílus #15"
  },
  {
    130,
    "Stílus #16"
  },
  {
    132,
    "Stílus #17"
  }
}
fightingStyles = {
  4,
  5,
  6,
  15,
  16
}
chatAnims = {
  {
    "GANGS",
    "prtial_gngtlkA"
  },
  {
    "GANGS",
    "prtial_gngtlkB"
  },
  {
    "GANGS",
    "prtial_gngtlkC"
  },
  {
    "GANGS",
    "prtial_gngtlkD"
  },
  {
    "GANGS",
    "prtial_gngtlkE"
  },
  {
    "GANGS",
    "prtial_gngtlkF"
  },
  {
    "GANGS",
    "prtial_gngtlkG"
  },
  {
    "GANGS",
    "prtial_gngtlkH"
  },
  {"GHANDS", "gsign2"},
  {"GHANDS", "gsign3"},
  {"GHANDS", "gsign4"},
  {"GHANDS", "gsign5"},
  {"GHANDS", "gsign1"},
  {},
  {}
}
function getChatAnims()
  return chatAnims
end
awardDetails = {
    {"invite:1", awardLabel = "Hívj meg 1 embert", reward = {1500, "premium"}},                                                   -- 1.500     pp
    {"invite:3", awardLabel = "Hívj meg 3 embert", reward = {2000, "premium"}},                                                   -- 2.000     pp
    {"invite:5", awardLabel = "Hívj meg 5 embert", reward = {2500, "premium"}},                                                   -- 2.500     pp
    {"invite:10", awardLabel = "Hívj meg 10 embert", reward = {3000, "premium"}},                                                 -- 3.000     pp
    {"invite:15", awardLabel = "Hívj meg 15 embert", reward = {3500, "premium"}},                                                 -- 3.500     pp
    {"invite:20", awardLabel = "Hívj meg 20 embert", reward = {4000, "premium"}},                                                 -- 4.000     pp
    {"invite:25", awardLabel = "Hívj meg 25 embert", reward = {4500, "premium"}},                                                 -- 4.500     pp
    {"invite:30", awardLabel = "Hívj meg 30 embert", reward = {5000, "premium"}},                                                 -- 5.000     pp
    {"invite:40", awardLabel = "Hívj meg 40 embert", reward = {6000, "premium"}},                                                 -- 6.000     pp
    {"invite:50", awardLabel = "Hívj meg 50 embert", reward = {8000, "premium"}},                                                 -- 8.000     pp

    {"earn:1:lvl:10", awardLabel = "1 meghívottad érje el a 10-es szintet!", reward = {300000, "money"}},                         -- 300.000   $
    {"earn:2:lvl:15", awardLabel = "2 meghívottad érje el a 15-es szintet!", reward = {800000, "money"}},                         -- 800.000   $
    {"earn:5:lvl:20", awardLabel = "5 meghívottad érje el a 20-es szintet!", reward = {1000000, "money"}},                        -- 1.000.000 $
    {"earn:3:lvl:25", awardLabel = "3 meghívottad érje el a 25-es szintet!", reward = {1500000, "money"}},                        -- 1.500.000 $
    {"earn:1:lvl:30", awardLabel = "1 meghívottad érje el a 30-es szintet!", reward = {12500, "premium"}},                        -- 12.500    pp

    {"work:1", awardLabel = "Kezdjen el 1 általad meghívott játékos dolgozni!", reward = {3500, "premium"}},                      -- 3.500     pp
    {"work:3", awardLabel = "Kezdjen el 3 általad meghívott játékos dolgozni!", reward = {5000, "premium"}},                      -- 5.000     pp
    {"work:5", awardLabel = "Kezdjen el 5 általad meghívott játékos dolgozni!", reward = {7000, "premium"}},                      -- 7.000     pp

    {"group:1", awardLabel = "Csatlakozzon 1 általad meghívott játékos egy frakcióba", reward = {85000, "money"}},                -- 85.000    $
    {"group:3", awardLabel = "Csatlakozzon 3 általad meghívott játékos egy frakcióba", reward = {185000, "money"}},               -- 185.000   $
    {"group:5", awardLabel = "Csatlakozzon 5 általad meghívott játékos egy frakcióba", reward = {245000, "money"}},               -- 245.000   $
    {"group:10", awardLabel = "Csatlakozzon 10 általad meghívott játékos egy frakcióba", reward = {15000, "premium"}},            -- 15.000    pp

    {"buy:1:vehicle", awardLabel = "Vásároljon 1 általad meghívott játékos autót!", reward = {100000, "money"}},                  -- 100.000   $
    {"buy:3:vehicle", awardLabel = "Vásároljon 3 általad meghívott játékos autót!", reward = {150000, "money"}},                  -- 150.000   $
    {"buy:5:vehicle", awardLabel = "Vásároljon 5 általad meghívott játékos autót!", reward = {300000, "money"}},                  -- 300.000   $
    {"buy:10:vehicle", awardLabel = "Vásároljon 10 általad meghívott játékos autót!", reward = {10000, "premium"}},               -- 10.000    pp

    {"buy:1:house", awardLabel = "Vásároljon 1 általad meghívott játékos házat!", reward = {150000, "money"}},                    -- 150.000   $
    {"buy:3:house", awardLabel = "Vásároljon 3 általad meghívott játékos házat!", reward = {175000, "money"}},                    -- 175.000   $
    {"buy:5:house", awardLabel = "Vásároljon 5 általad meghívott játékos házat!", reward = {7500, "premium"}},                    -- 7.500     pp
    {"buy:10:house", awardLabel = "Vásároljon 10 általad meghívott játékos házat!", reward = {15000, "premium"}},                 -- 15.000    pp

    {"buy:1:house-vehicle",  awardLabel = "Vásároljon 1 általad meghívott játékos autót és házat!", reward = {200000, "money"}},  -- 200.000   $
    {"buy:3:house-vehicle",  awardLabel = "Vásároljon 3 általad meghívott játékos autót és házat!", reward = {350000, "money"}},  -- 350.000   $
    {"buy:5:house-vehicle",  awardLabel = "Vásároljon 4 általad meghívott játékos autót és házat!", reward = {12500, "premium"}}, -- 12.500    pp

    --[[
    {"play:1:day-3", awardLabel = "Játszon sorozatban 1 általad meghívott játékos 3 napot!", reward = {300, "money"}},
    {"play:1:day-7", awardLabel = "Játszon sorozatban 1 általad meghívott játékos 7 napot!", reward = {500, "premium"}},
    {"play:1:day-14", awardLabel = "Játszon sorozatban 1 általad meghívott játékos 14 napot!", reward = {1000, "premium"}},
    {"play:1:day-30", awardLabel = "Játszon sorozatban 1 általad meghívott játékos 30 napot!", reward = {2000, "premium"}},
    ]]

    {"earn:together:lvl-100", awardLabel = "A meghívott játékosaid szintje érje el a lvl100-at!", reward = {25000, "premium"}},              -- 25.000    pp
    {"earn:together:hour-100", awardLabel = "A meghívott játékosaid érjék el eggyütessen 100 játszott órát!", reward = {7500, "premium"}},   -- 7.500    pp

    {"have:self:allachievements", awardLabel = "Érd el az összes meghívásos jutalmat", reward = {35000, "premium"}},                         -- 35.000    pp lvl 100 a visszatartó hogy ne legyen meg
}