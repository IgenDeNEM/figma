airsoftMaps = {
  {
    name = "Caligula Casino",
    interior = 1,
    map = "airsoft_caligula.map",
    image = ":sAirsoft/files/maps/sm/2.dds",
    bigImage = "files/maps/2.dds",
    gamemodes = {
      "ctf",
      "tdm",
      "lms",
      "ffa"
    },
    campos = {
      2235.8859863281,
      1564.5235595703,
      1009.0592651367,
      2235.3625488281,
      1664.5002441406,
      1006.9653930664
    },
  },
  {
    name = "Gyár",
    interior = 2,
    map = "airsoft_gyar.map",
    image = ":sAirsoft/files/maps/sm/3.dds",
    bigImage = "files/maps/3.dds",
    gamemodes = {
      "ctf",
      "tdm",
      "lms",
      "ffa"
    },
    campos = {
      2531.4208984375,
      -1298.1680908203,
      1050.2249755859,
      2620.443359375,
      -1264.0933837891,
      1019.9935302734
    },
  },
  {
    name = "Jefferson Motel",
    interior = 15,
    map = "airsoft_jefferson.map",
    image = ":sAirsoft/files/maps/sm/4.dds",
    bigImage = "files/maps/4.dds",
    gamemodes = {
      "ctf",
      "tdm",
      "lms",
      "ffa"
    },
    campos = {
      2193.8283691406,
      -1195.6610107422,
      1035.9742431641,
      2144.1350097656,
      -1116.1163330078,
      1001.2869873047
    },
  },
  {
    name = "Maddog Ház",
    interior = 5,
    map = "airsoft_maddog.map",
    image = ":sAirsoft/files/maps/sm/5.dds",
    bigImage = "files/maps/5.dds",
    gamemodes = {
      "ctf",
      "tdm",
      "lms",
      "ffa"
    },
    campos = {
      1265.9868164062,
      -838.64367675781,
      1092.1794433594,
      1345.3739013672,
      -781.44183349609,
      1071.5484619141
    },
  },
  {
    name = "San Fierro Rendőrség",
    interior = 10,
    map = "airsoft_pdinti.map",
    image = ":sAirsoft/files/maps/sm/6.dds",
    bigImage = "files/maps/6.dds",
    gamemodes = {
      "ctf",
      "tdm",
      "lms",
      "ffa"
    },
    campos = {
      251.82817077637,
      108.03707122803,
      1006.7842407227,
      192.64581298828,
      180.71371459961,
      971.91943359375
    },
  },
  {
    name = "Stadion",
    interior = 14,
    map = "airsoft_stadion.map",
    image = ":sAirsoft/files/maps/sm/7.dds",
    bigImage = "files/maps/7.dds",
    gamemodes = {
      "ctf",
      "tdm",
      "lms",
      "ffa"
    },
    campos = {
      -1338.2717285156,
      1544.9584960938,
      1072.2320556641,
      -1414.0526123047,
      1605.69140625,
      1048.3831787109
    },
  },
  {
    name = "Terepasztal",
    interior = 10,
    map = "airsoft_terepasztal.map",
    image = ":sAirsoft/files/maps/sm/8.dds",
    bigImage = "files/maps/8.dds",
    gamemodes = {
      "ctf",
      "tdm",
      "lms",
      "ffa"
    },
    campos = {
      -981.69915771484,
      1094.1762695312,
      1362.0794677734,
      -1064.0888671875,
      1046.7819824219,
      1331.0034179688
    },
  },
  {
    name = "Átrium",
    interior = 18,
    map = "airsoft_atrium.map",
    image = ":sAirsoft/files/maps/sm/1.dds",
    bigImage = "files/maps/1.dds",
    gamemodes = {
      "ffa"
    },
    campos = {
      1728.9428710938,
      -1640.1890869141,
      33.593894958496,
      1698.2202148438,
      -1720.0993652344,
      -18.082712173462
    },
  }
}
function basicScoreboardSort(r0_1, r1_1)
  -- line: [76, 86] id: 1
  if r0_1.k == r1_1.k then
    if r0_1.d == r1_1.d then
      return r0_1.lastFrag < r1_1.lastFrag
    else
      return r0_1.d < r1_1.d
    end
  else
    return r1_1.k < r0_1.k
  end
end
function lmsScoreboardSort(r0_2, r1_2)
  -- line: [88, 94] id: 2
  if r0_2.standing == r1_2.standing then
    return basicScoreboardSort(r0_2, r1_2)
  else
    local r2_2 = r0_2.standing or 0
    return r2_2 < (r1_2.standing or 0)
  end
end
 gameModes = {}
gameModes.tdm = {
  name = "Team Deathmatch",
  color = "sightred",
  team = true,
  reSpawn = true,
  scoreboardSort = basicScoreboardSort,
  description = "A klasszikus Team Deathmatch játékmód nyertese az a csapat, amelyik több killt ér el a megadott játékidő végére.",
  time = {
    5,
    30
  },
}
gameModes.ctf = {
  name = "Capture The Flag",
  color = "sightgreen",
  team = true,
  teamSpawn = true,
  reSpawn = true,
  scoreboardSort = basicScoreboardSort,
  description = "A Capture The Flag játékmód során a pályán 3 zászló, jelen esetben SightMTA logó van elhelyezve. Ezeket kell elfoglani a csapatoknak. Egy elfoglalt zászló után 50 pont kerül jóváírásra a csapatnak, valamint másodpercenként " .. 2 .. " pontot kapnak minden elfoglalt zászló után, egészen addig, amíg a másik csapat meg nem szerzi azt. A nyertes az, aki több pontot ér el a játékidő végére.",
  time = {
    5,
    30
  },
}
gameModes.lms = {
  name = "Last Man Standing",
  color = "sightorange",
  team = false,
  scoreboardSort = lmsScoreboardSort,
  description = "A Last Man Standing játékmód lényege, hogy a játékosoknak egymás ellen kell harcolniuk. Akit lelőnek, kiesik. Az első három helyezett díjazott. Amennyiben a játékidő lejár, és több játékos is életben van, akkor a legjobb K/D rátával rendelkező játékos nyer.",
  time = {
    5,
    15
  },
}
gameModes.ffa = {
  name = "Free For All",
  color = "sightblue",
  team = false,
  reSpawn = true,
  scoreboardSort = basicScoreboardSort,
  description = "A Free For All játékmód során mindenki-mindenki ellen játszik, aki több killt ér el a játékidő végére, az nyer. Ugyanannyi kill esetén a K/D ráta dönt. Az első három helyezett díjazott.",
  time = {
    5,
    30
  },
}
function processScoreboardList(r0_3, r1_3)
  local r2_3 = {
    name = r0_3.name,
    k = r0_3.k,
    d = r0_3.d,
    lastFrag = r0_3.lastFrag,
    team = r0_3.team,
    standing = r0_3.standing,
  }
  local r3_3 = r0_3.client
  r2_3.client = r3_3
  if r1_3 then
    r3_3 = true or r0_3.spawned
  else
    r3_3 = r0_3.spawned
  end
  r2_3.spawned = r3_3
  r2_3.i = r1_3
  return r2_3
end
