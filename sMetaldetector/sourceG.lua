syncSize = 23
diggableZones = {}
diggableSync = {}
islandSync = {}
function convertToSync(x, y)
  return math.floor(x / syncSize), math.floor(y / syncSize)
end
diggableCount = 0
diggableCountIsland = 0
function findNearestHoleCoord(x, y)
  x, y = math.floor(x / 3), math.floor(y / 3)
  if diggableZones[x] and diggableZones[x][y] then
    return x * 3, y * 3, diggableZones[x][y][1]
  end
  local isx, isy = convertToSync(x, y)
  local d, minL, minJ = false, false, false
  for sx = isx - 1, isx + 1 do
    if diggableSync[sx] then
      for sy = isy - 1, isy + 1 do
        if diggableSync[sx][sy] then
          for l = sx * syncSize, sx * syncSize + syncSize do
            if diggableZones[l] then
              for j = sy * syncSize, sy * syncSize + syncSize do
                if diggableZones[l][j] then
                  local sd = getDistanceBetweenPoints2D(l, j, x, y)
                  if not d or d > sd then
                    d = sd
                    minL = l
                    minJ = j
                  end
                end
              end
            end
          end
        end
      end
    end
  end
  if minL and minJ then
    return minL * 3, minJ * 3, diggableZones[minL][minJ][1]
  end
  local d, minL, minJ = false, false, false
  for sx = isx - 10, isx + 10 do
    if diggableSync[sx] then
      for sy = isy - 10, isy + 10 do
        if diggableSync[sx][sy] then
          for l = sx * syncSize, sx * syncSize + syncSize do
            if diggableZones[l] then
              for j = sy * syncSize, sy * syncSize + syncSize do
                if diggableZones[l][j] then
                  local sd = getDistanceBetweenPoints2D(l, j, x, y)
                  if not d or d > sd then
                    d = sd
                    minL = l
                    minJ = j
                  end
                end
              end
            end
          end
        end
      end
    end
  end
  if minL and minJ then
    return minL * 3, minJ * 3, diggableZones[minL][minJ][1]
  end
end
function initDiggableZone(x, y, mz, nd, nd2, island)
  if not diggableZones[x] then
    diggableZones[x] = {}
  end
  diggableZones[x][y] = {
    mz,
    nd,
    nd2
  }
  local sx, sy = convertToSync(x, y)
  if not diggableSync[sx] then
    diggableSync[sx] = {}
  end
  if triggerServerEvent then
    diggableSync[sx][sy] = true
  else
    diggableSync[sx][sy] = (diggableSync[sx][sy] or 0) + 1
  end
  if island then
    if not islandSync[sx] then
      islandSync[sx] = {}
    end
    islandSync[sx][sy] = true
    diggableCountIsland = diggableCountIsland + 1
  else
    diggableCount = diggableCount + 1
  end
end
lootSum = 0
lootSumIsland = 0
lootTypes = {
  {
    "crate/1",
    true,
    456,
    math.ceil(850),
    true
  },
  {
    "crate/2",
    true,
    455,
    math.ceil(850),
    true
  },
  {
    "crate/3",
    true,
    459,
    math.ceil(170),
    true
  },
  {
    "crate/4",
    true,
    458,
    math.ceil(850),
    true
  },
  {
    "crate/5",
    true,
    457,
    math.ceil(85),
    true
  },
  {
    "crate/6",
    true,
    606,
    math.ceil(85),
    true
  },
  {
    "treasure/1",
    true,
    607,
    170
  },
  {
    "loot/1",
    true,
    465,
    math.ceil(127.5)
  },
  {
    "loot/10",
    true,
    254,
    math.ceil(127.5)
  },
  {
    "loot/11",
    true,
    158,
    math.ceil(72.25)
  },
  {
    "loot/12",
    true,
    247,
    math.ceil(170)
  },
  {
    "loot/13",
    true,
    464,
    math.ceil(170)
  },
  {
    "loot/14",
    true,
    122,
    math.ceil(255)
  },
  {
    "loot/2",
    true,
    461,
    math.ceil(297.5)
  },
  {
    "loot/3",
    true,
    460,
    math.ceil(255)
  },
  {
    "loot/4",
    true,
    467,
    math.ceil(170)
  },
  {
    "loot/5",
    true,
    466,
    math.ceil(170)
  },
  {
    "loot/6",
    true,
    462,
    math.ceil(255)
  },
  {
    "loot/7",
    true,
    468,
    math.ceil(255)
  },
  {
    "loot/8",
    true,
    463,
    math.ceil(255)
  },
  {
    "loot/9",
    true,
    253,
    math.ceil(212.5)
  },
  {
    "nm_loot/1",
    false,
    260,
    math.ceil(276.25)
  },
  {
    "nm_loot/2",
    false,
    259,
    math.ceil(255)
  },
  {
    "nm_loot/3",
    false,
    117,
    math.ceil(255)
  },
  {
    "nm_trash/1",
    false,
    152,
    math.ceil(425)
  },
  {
    "nm_trash/2",
    false,
    217,
    math.ceil(425)
  },
  {
    "nm_trash/3",
    false,
    152,
    500
  },
  {
    "nm_trash/4",
    false,
    249,
    500
  },
  {
    "nm_trash/5",
    false,
    258,
    500
  },
  {
    "nm_trash/6",
    false,
    37,
    500
  },
  {
    "trash/1",
    true,
    34,
    500
  },
  {
    "trash/10",
    true,
    72,
    500
  },
  {
    "trash/11",
    true,
    68,
    500
  },
  {
    "trash/13",
    true,
    164,
    500
  },
  {
    "trash/14",
    true,
    97,
    500
  },
  {
    "trash/15",
    true,
    257,
    500
  },
  {
    "trash/16",
    true,
    362,
    500
  },
  {
    "trash/17",
    true,
    426,
    500
  },
  {
    "trash/18",
    true,
    441,
    500
  },
  {
    "trash/19",
    true,
    245,
    500
  },
  {
    "trash/2",
    true,
    33,
    500
  },
  {
    "trash/20",
    true,
    338,
    500
  },
  {
    "trash/3",
    true,
    33,
    500
  },
  {
    "trash/4",
    true,
    33,
    500
  },
  {
    "trash/5",
    true,
    469,
    500
  },
  {
    "trash/6",
    true,
    216,
    500
  },
  {
    "trash/7",
    true,
    220,
    500
  },
  {
    "trash/8",
    true,
    24,
    500
  },
  {
    "trash/9",
    true,
    23,
    500
  },
  {
    "trash/21",
    true,
    707,
    350
  },
}
for i = 1, #lootTypes do
  lootSumIsland = lootSumIsland + lootTypes[i][4]
end
for i = 1, #lootTypes do
  if not lootTypes[i][5] then
    lootSum = lootSum + lootTypes[i][4]
  end
end