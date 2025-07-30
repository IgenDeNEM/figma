borders = {
  {
    pronoun = "A",
    name = "déli Los Santos ➞ San Fierro",
    pos = {
      59.9,
      -1526.3,
      4.1,
      443
    },
    size = 1,
    price = 100
  },
  {
    pronoun = "A",
    name = "déli San Fierro ➞ Los Santos",
    pos = {
      41.6,
      -1536.8,
      4.25,
      264.25
    },
    size = 1,
    price = 100
  },
  {
    pronoun = "Az",
    name = "északi San Fierro ➞ Los Santos",
    pos = {
      -5.2,
      -1360,
      9.8,
      -52.004
    },
    size = 3,
    price = 100
  },
  {
    pronoun = "Az",
    name = "északi Los Santos ➞ San Fierro",
    pos = {
      -17.7,
      -1340.7,
      10.1,
      128
    },
    size = 3,
    price = 100
  },
  {
    pronoun = "A",
    name = "San Fierro ➞ Bayside", --[R]
    pos = {
      -2667.5951171875,
      1273.9970703125,
      54.4296875,
      0
    },
    size = 1,
    price = 100
  },
  {
    pronoun = "A",
    name = "San Fierro ➞ Bayside", --[L]
    pos = {
      -2677.0951171875,
      1273.9970703125,
      54.4296875,
      0
    },
    size = 1,
    price = 100
  },
  {
    pronoun = "A",
    name = "Bayside ➞ San Fierro", --[L]
    pos = {
      -2686.5951171875,
      1273.9970703125,
      54.4296875,
      180
    },
    size = 1,
    price = 100
  },
  {
    pronoun = "A",
    name = "Bayside ➞ San Fierro", --[R]
    pos = {
      -2695.5951171875,
      1273.9970703125,
      54.4296875,
      180
    },
    size = 1,
    price = 100
  },
  {
    pronoun = "A",
    name = "Flint County ➞ Los Santos",
    pos = {
      -42.3,
      -832.40002,
      11.4,
      -24
    },
    size = 2,
    price = 100
  },
  {
    pronoun = "A",
    name = "Flint County ➞ San Fierro",
    pos = {
      -48.5,
      -829.59998,
      11.4,
      155.995
    },
    size = 2,
    price = 100
  },
  {
    pronoun = "A",
    name = "Red County ➞ Los Santos",
    pos = {
      -963.40002,
      -341.10001,
      35.3,
      -10.003
    },
    size = 3,
    price = 100
  },
  {
    pronoun = "A",
    name = "Red County ➞ San Fierro",
    pos = {
      -970.40002,
      -340.10001,
      35.5,
      170
    },
    size = 3,
    price = 100
  },
  {
    pronoun = "A",
    name = "San Fierro ➞ Tierra Robada",
    pos = {
      -1398.5,
      821,
      46.35,
      316.5
    },
    size = 3,
    price = 100
  },
  {
    pronoun = "A",
    name = "Tierra Robada ➞ San Fierro",
    pos = {
      -1405.1,
      827.29999,
      46.35,
      136.5
    },
    size = 3,
    price = 100
  }
}
sizes = {
  {
    -3,
    -1.5,
    0,
    1.5,
    3
  },
  {
    -1.5,
    0,
    1.5
  },
  {
    -2.25,
    -0.75,
    0.75,
    2.25
  },
  {
    -6,
    -4.5,
    -3,
    -1.5,
    0,
    1.5,
    3,
    4.5,
    6
  },
  {
    -4.5,
    -3,
    -1.5,
    0,
    1.5,
    3,
    4.5
  }
}
maxSizes = {}
minSizes = {}
for i = 1, #sizes do
  for j = 1, #sizes[i] do
    maxSizes[i] = math.max(maxSizes[i] or 0, sizes[i][j])
    minSizes[i] = math.min(minSizes[i] or sizes[i][j], sizes[i][j])
  end
end
