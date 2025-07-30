drugTypes = {
  shroom = {
    rampagePerItem = 0.3333333333333333,
    startTime = 2,
    buildTime = 3,
    maxTime = 10,
    downTime = 2,
    takeTime = 3,
    color1 = "sightyellow-second",
    color2 = "sightorange",
    damageLoss = 0.8
  },
  lsd = {
    rampagePerItem = 0.5,
    startTime = 1,
    buildTime = 2.5,
    maxTime = 12,
    downTime = 2,
    takeTime = 3,
    color1 = "sightorange",
    color2 = "sightred-second",
    damageLoss = 1
  },
  weed = {
    rampagePerItem = 0.07500000000000001,
    startTime = 0,
    buildTime = 1,
    maxTime = 8,
    downTime = 5,
    takeTime = 0.5,
    color1 = "sightgreen",
    color2 = "sightgreen-second",
    damageLoss = 0.4
  },
  coke = {
    rampagePerItem = 0.2,
    startTime = 1,
    buildTime = 3,
    maxTime = 6,
    downTime = 2,
    takeTime = 1,
    color1 = "hudwhite",
    color2 = "sightlightgrey",
    damageLoss = 0.6
  },
  para = {
    rampagePerItem = 0.25,
    startTime = 1,
    buildTime = 2.5,
    maxTime = 8,
    downTime = 3,
    takeTime = 1,
    color1 = "hudwhite",
    color2 = "sightpurple-second",
    damageLoss = 0.7
  },
  speed = {
    rampagePerItem = 0.3333333333333333,
    startTime = 1,
    buildTime = 2,
    maxTime = 9,
    downTime = 4,
    takeTime = 1,
    color1 = "sightred-second",
    color2 = "sightpurple-second",
    damageLoss = 0.8
  },
  ex = {
    rampagePerItem = 0.5,
    startTime = 2,
    buildTime = 1,
    maxTime = 8,
    downTime = 4,
    takeTime = 1.5,
    color1 = "sightpurple",
    color2 = "sightblue",
    damageLoss = 0.75
  }
}
for d in pairs(drugTypes) do
  drugTypes[d].endTime = drugTypes[d].startTime + drugTypes[d].buildTime + drugTypes[d].maxTime
end
