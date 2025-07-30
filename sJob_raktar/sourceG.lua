shelfPoses = {
  {
    -588.6724,
    -544.7463,
    25.5219
  },
  {
    -588.6724,
    -533.7463,
    25.5219
  },
  {
    -588.6724,
    -522.7463,
    25.5219
  },
  {
    -588.6724,
    -511.7463,
    25.5219
  },
  {
    -588.6724,
    -500.7462,
    25.5219
  },
  {
    -588.6724,
    -489.7462,
    25.5219
  },
  {
    -588.6724,
    -478.8138,
    25.5219
  }
}
jobNPCPos = {
  -529.0166015625,
  -472.0654296875,
  25.663763046265,
  320
}
carMarkersPos = {
  {
    -521.6705,
    -505.4865,
    25.5267
  },
  {
    -521.6705,
    -513.7374,
    25.5267
  },
  {
    -521.6705,
    -521.9883,
    25.5267
  }
}
carMarkerRot = 90
raktarZonePos = {
  -623.7998046875,
  -562.8935546875,
  124.549805,
  95.180664
}
sprinterX, sprinterY, sprinterZ = 1.76648, 1.86427, 1.66
sprinterOffX, spriterOffY, sprinterOffZ = -0.7949, 0.5574, -0.402
function toVehCargo(id, tbl)
  local to = false
  local dat = tonumber(id) and cargoTypes[id] or id
  local l = dat.length
  local stack = dat.stack
  for j = #tbl, 1, -1 do
    if tbl[j] == id or cargoTypes[tbl[j]].stack == stack then
      to = j + 1
      break
    end
  end
  if not to then
    for j = 1, #tbl do
      if l > cargoTypes[tbl[j]].length then
        break
      end
      to = j + 1
    end
  end
  return to or 1
end
function checkVehCargo(id, tbl)
  local dat = tonumber(id) and cargoTypes[id] or id
  local to = toVehCargo(dat, tbl)
  local x, y, z, lastStack, lastW, maxL = 0, 0, 0, false, 0, 0
  local found = false
  for i = 1, #tbl do
    if to == i then
      found = true
      x, y, z, lastStack, lastW, maxL = processVehCargo(dat, x, y, z, lastStack, lastW, maxL)
      if not x then
        return false
      end
    end
    x, y, z, lastStack, lastW, maxL = processVehCargo(tbl[i], x, y, z, lastStack, lastW, maxL)
    if not x then
      return false
    end
  end
  if not found then
    x, y, z, lastStack, lastW, maxL = processVehCargo(dat, x, y, z, lastStack, lastW, maxL)
    if not x then
      return false
    end
  end
  return to or true
end
function processVehCargo(id, x, y, z, lastStack, lastW, maxL)
  if not x then
    return false
  end
  local dat = tonumber(id) and cargoTypes[id] or id
  if lastStack and dat.stack ~= lastStack or z + dat.height > sprinterZ then
    y = y + lastW
    z = 0
    if y + dat.width > sprinterY then
      y = 0
      x = x + maxL
      maxL = 0
      if x + dat.length > sprinterX then
        return false
      end
    end
  end
  lastStack = dat.stack
  lastW = dat.width
  z = z + dat.height
  maxL = math.max(maxL, dat.length)
  return x, y, z, lastStack, lastW, maxL
end
function toCartCargo(id, tbl)
  local to = false
  local dat = tonumber(id) and cargoTypes[id] or id
  local stack = dat.stack
  for j = #tbl, 1, -1 do
    if tbl[j] == id or cargoTypes[tbl[j]].stack == stack then
      to = j + 1
      break
    end
  end
  return to
end
function checkCartCargo(id, tbl)
  local dat = tonumber(id) and cargoTypes[id] or id
  local to = toCartCargo(dat, tbl)
  local y, z = 0, 0
  local lastStack = false
  local lastW = 0
  local nextRow = false
  local found = false
  for i = 1, #tbl do
    if to == i then
      found = true
      y, z, lastStack, lastW, nextRow = processCartCargo(dat, y, z, lastStack, lastW, nextRow)
      if not y then
        return false
      end
    end
    y, z, lastStack, lastW, nextRow = processCartCargo(tbl[i], y, z, lastStack, lastW, nextRow)
    if not y then
      return false
    end
  end
  if not found then
    y, z, lastStack, lastW, nextRow = processCartCargo(dat, y, z, lastStack, lastW, nextRow)
    if not y then
      return false
    end
  end
  return to or true
end
function processCartCargo(id, y, z, lastStack, lastW, nextRow)
  local dat = tonumber(id) and cargoTypes[id] or id
  if not y then
    return false
  end
  if lastStack and dat.stack ~= lastStack or nextRow then
    y = y + lastW
    z = 0
    nextRow = false
    if y + dat.width > 1.275 then
      return false
    end
  end
  lastStack = dat.stack
  lastW = dat.width
  z = z + dat.height
  if 1 < z then
    nextRow = true
  end
  return y, z, lastStack, lastW, nextRow
end
function shuffleTable(t)
  local rand = math.random
  local iterations = #t
  local j
  for i = iterations, 2, -1 do
    j = rand(i)
    t[i], t[j] = t[j], t[i]
  end
  return t
end
local cargoIds = {
  sight_urmatrans_shelf_almapapr = 1,
  sight_urmatrans_shelf_tvpapr = 2,
  sight_urmatrans_shelf_chili = 3,
  sight_urmatrans_shelf_repa = 4,
  sight_urmatrans_shelf_onion = 5,
  sight_urmatrans_shelf_onion2 = 6,
  sight_urmatrans_shelf_cucum = 7,
  sight_urmatrans_shelf_karalabe = 8,
  sight_urmatrans_shelf_radish = 9,
  sight_urmatrans_shelf_cabbage = 10,
  sight_urmatrans_shelf_salad = 11,
  sight_urmatrans_shelf_pumpkin = 12,
  sight_urmatrans_shelf_waterm = 13,
  sight_urmatrans_shelf_fanta = 14,
  sight_urmatrans_shelf_cocacola = 15,
  sight_urmatrans_shelf_pepsi = 16,
  sight_urmatrans_shelf_szkiralyi1 = 17,
  sight_urmatrans_shelf_szkiralyi2 = 18,
  sight_urmatrans_shelf_szkiralyi3 = 19,
  sight_urmatrans_shelf_kobanyai = 20,
  sight_urmatrans_shelf_soproni = 21,
  sight_urmatrans_shelf_tokaji = 22,
  sight_urmatrans_shelf_soproni2 = 23,
  sight_urmatrans_shelf_somersby = 24,
  sight_urmatrans_shelf_hell = 25,
  sight_urmatrans_shelf_pepsi2 = 26,
  sight_urmatrans_shelf_nber = 27,
  sight_urmatrans_shelf_redbull = 28
}
local cargoStacks = {
  {
    sight_urmatrans_shelf_almapapr = true,
    sight_urmatrans_shelf_tvpapr = true,
    sight_urmatrans_shelf_chili = true,
    sight_urmatrans_shelf_repa = true,
    sight_urmatrans_shelf_onion = true,
    sight_urmatrans_shelf_onion2 = true,
    sight_urmatrans_shelf_cucum = true,
    sight_urmatrans_shelf_karalabe = true,
    sight_urmatrans_shelf_radish = true,
    sight_urmatrans_shelf_cabbage = true,
    sight_urmatrans_shelf_salad = true,
    sight_urmatrans_shelf_pumpkin = true,
    sight_urmatrans_shelf_waterm = true
  },
  {
    sight_urmatrans_shelf_fanta = true,
    sight_urmatrans_shelf_cocacola = true,
    sight_urmatrans_shelf_pepsi = true,
    sight_urmatrans_shelf_soproni = true,
    sight_urmatrans_shelf_tokaji = true
  },
  {
    sight_urmatrans_shelf_szkiralyi1 = true,
    sight_urmatrans_shelf_szkiralyi2 = true,
    sight_urmatrans_shelf_szkiralyi3 = true,
    sight_urmatrans_shelf_kobanyai = true
  },
  {
    sight_urmatrans_shelf_soproni2 = true,
    sight_urmatrans_shelf_somersby = true,
    sight_urmatrans_shelf_hell = true,
    sight_urmatrans_shelf_pepsi2 = true,
    sight_urmatrans_shelf_nber = true,
    sight_urmatrans_shelf_redbull = true
  }
}
local createLoadingBay = function(x1, y1, x2, y2, z)
  local minX = math.min(x1, x2)
  local maxX = math.max(x1, x2)
  local minY = math.min(y1, y2)
  local maxY = math.max(y1, y2)
  return {
    minX,
    minY,
    maxX - minX,
    maxY - minY,
    z - 1 + 0.05
  }
end
shelfOffsetsBig = {
  {
    7.4533,
    -1.3621,
    0
  },
  {
    2.504,
    -1.3621,
    0
  },
  {
    -2.499,
    -1.3621,
    0
  },
  {
    -7.4533,
    -1.3621,
    0
  },
  {
    7.4533,
    1.3621,
    0
  },
  {
    2.504,
    1.3621,
    0
  },
  {
    -2.499,
    1.3621,
    0
  },
  {
    -7.4533,
    1.3621,
    0
  }
}
companies = {
  {
    name = "San Fierro Burger Shot",
    loadingBay = {
      -2309.3984375,
      -148.1201171875,
      7.619140625,
      13.3876953125,
      34.35
    },
    items = {
      "sight_urmatrans_shelf_tvpapr",
      "sight_urmatrans_shelf_chili",
      "sight_urmatrans_shelf_repa",
      "sight_urmatrans_shelf_onion",
      "sight_urmatrans_shelf_onion2",
      "sight_urmatrans_shelf_cucum",
      "sight_urmatrans_shelf_radish",
      "sight_urmatrans_shelf_cabbage",
      "sight_urmatrans_shelf_salad",
      "sight_urmatrans_shelf_fanta",
      "sight_urmatrans_shelf_cocacola",
      "sight_urmatrans_shelf_pepsi",
      "sight_urmatrans_shelf_soproni",
      "sight_urmatrans_shelf_somersby",
      "sight_urmatrans_shelf_hell",
      "sight_urmatrans_shelf_pepsi2",
      "sight_urmatrans_shelf_nber",
      "sight_urmatrans_shelf_redbull"
    }
  },
  {
    name = "San Fierro Cluckin Bell",
    loadingBay = {
      -2695.857421875,
      228.6328125,
      11.431640625,
      10.1533203125,
      3.35
    },
    items = {
      "sight_urmatrans_shelf_tvpapr",
      "sight_urmatrans_shelf_chili",
      "sight_urmatrans_shelf_repa",
      "sight_urmatrans_shelf_onion",
      "sight_urmatrans_shelf_onion2",
      "sight_urmatrans_shelf_cucum",
      "sight_urmatrans_shelf_radish",
      "sight_urmatrans_shelf_cabbage",
      "sight_urmatrans_shelf_salad",
      "sight_urmatrans_shelf_fanta",
      "sight_urmatrans_shelf_cocacola",
      "sight_urmatrans_shelf_pepsi",
      "sight_urmatrans_shelf_soproni",
      "sight_urmatrans_shelf_somersby",
      "sight_urmatrans_shelf_hell",
      "sight_urmatrans_shelf_pepsi2",
      "sight_urmatrans_shelf_nber",
      "sight_urmatrans_shelf_redbull"
    }
  },
  {
    name = "Supa Save ABC",
    loadingBay = {
      -2461.9677734375,
      777.0361328125,
      4.669921875,
      20.1044921875,
      34.2
    },
    items = {
      "sight_urmatrans_shelf_almapapr",
      "sight_urmatrans_shelf_tvpapr",
      "sight_urmatrans_shelf_chili",
      "sight_urmatrans_shelf_repa",
      "sight_urmatrans_shelf_onion",
      "sight_urmatrans_shelf_onion2",
      "sight_urmatrans_shelf_cucum",
      "sight_urmatrans_shelf_karalabe",
      "sight_urmatrans_shelf_radish",
      "sight_urmatrans_shelf_cabbage",
      "sight_urmatrans_shelf_salad",
      "sight_urmatrans_shelf_pumpkin",
      "sight_urmatrans_shelf_waterm",
      "sight_urmatrans_shelf_fanta",
      "sight_urmatrans_shelf_cocacola",
      "sight_urmatrans_shelf_pepsi",
      "sight_urmatrans_shelf_szkiralyi1",
      "sight_urmatrans_shelf_szkiralyi2",
      "sight_urmatrans_shelf_szkiralyi3",
      "sight_urmatrans_shelf_kobanyai",
      "sight_urmatrans_shelf_soproni",
      "sight_urmatrans_shelf_tokaji",
      "sight_urmatrans_shelf_soproni2",
      "sight_urmatrans_shelf_somersby",
      "sight_urmatrans_shelf_hell",
      "sight_urmatrans_shelf_pepsi2",
      "sight_urmatrans_shelf_nber",
      "sight_urmatrans_shelf_redbull"
    }
  },
  {
    name = "San Fierro Burger Shot",
    loadingBay = {
      -2339.755859375,
      983.41015625,
      11.95703125,
      8.708984375,
      49.72
    },
    items = {
      "sight_urmatrans_shelf_tvpapr",
      "sight_urmatrans_shelf_chili",
      "sight_urmatrans_shelf_repa",
      "sight_urmatrans_shelf_onion",
      "sight_urmatrans_shelf_onion2",
      "sight_urmatrans_shelf_cucum",
      "sight_urmatrans_shelf_radish",
      "sight_urmatrans_shelf_cabbage",
      "sight_urmatrans_shelf_salad",
      "sight_urmatrans_shelf_fanta",
      "sight_urmatrans_shelf_cocacola",
      "sight_urmatrans_shelf_pepsi",
      "sight_urmatrans_shelf_kobanyai",
      "sight_urmatrans_shelf_soproni",
      "sight_urmatrans_shelf_somersby",
      "sight_urmatrans_shelf_hell",
      "sight_urmatrans_shelf_pepsi2",
      "sight_urmatrans_shelf_nber",
      "sight_urmatrans_shelf_redbull"
    }
  },
  {
    name = "Fix&Drive",
    loadingBay = {
      -1511.516602,
      999.5986328125,
      4,
      6,
      6.2
    },
    items = {
      "sight_urmatrans_shelf_fanta",
      "sight_urmatrans_shelf_cocacola",
      "sight_urmatrans_shelf_pepsi",
      "sight_urmatrans_shelf_szkiralyi1",
      "sight_urmatrans_shelf_szkiralyi2",
      "sight_urmatrans_shelf_szkiralyi3",
      "sight_urmatrans_shelf_hell",
      "sight_urmatrans_shelf_pepsi2",
      "sight_urmatrans_shelf_nber",
      "sight_urmatrans_shelf_redbull"
    }
  },
  {
    name = "Fix&Drive lerakat",
    loadingBay = {
      -1775.3779296875,
      1201.794921875,
      8.451171875,
      6.9912109375,
      24.145
    },
    items = {
      "sight_urmatrans_shelf_fanta",
      "sight_urmatrans_shelf_cocacola",
      "sight_urmatrans_shelf_pepsi",
      "sight_urmatrans_shelf_szkiralyi1",
      "sight_urmatrans_shelf_szkiralyi2",
      "sight_urmatrans_shelf_szkiralyi3",
      "sight_urmatrans_shelf_hell",
      "sight_urmatrans_shelf_pepsi2",
      "sight_urmatrans_shelf_nber",
      "sight_urmatrans_shelf_redbull"
    }
  },
  {
    name = "Los Santos Burger Shot",
    loadingBay = {
      786.16015625,
      -1623.5693359375,
      5.06640625,
      8.640625,
      12.4
    },
    items = {
      "sight_urmatrans_shelf_tvpapr",
      "sight_urmatrans_shelf_chili",
      "sight_urmatrans_shelf_repa",
      "sight_urmatrans_shelf_onion",
      "sight_urmatrans_shelf_onion2",
      "sight_urmatrans_shelf_cucum",
      "sight_urmatrans_shelf_radish",
      "sight_urmatrans_shelf_cabbage",
      "sight_urmatrans_shelf_salad",
      "sight_urmatrans_shelf_fanta",
      "sight_urmatrans_shelf_cocacola",
      "sight_urmatrans_shelf_pepsi",
      "sight_urmatrans_shelf_soproni",
      "sight_urmatrans_shelf_somersby",
      "sight_urmatrans_shelf_hell",
      "sight_urmatrans_shelf_pepsi2",
      "sight_urmatrans_shelf_nber",
      "sight_urmatrans_shelf_redbull"
    }
  },
  {
    name = "Los Santos Jim's Ring",
    loadingBay = {
      1020.3271484375,
      -1371.2568359375,
      8.2958984375,
      9.8896484375,
      12.57
    },
    items = {
      "sight_urmatrans_shelf_fanta",
      "sight_urmatrans_shelf_cocacola",
      "sight_urmatrans_shelf_pepsi",
      "sight_urmatrans_shelf_soproni2",
      "sight_urmatrans_shelf_somersby",
      "sight_urmatrans_shelf_hell",
      "sight_urmatrans_shelf_pepsi2",
      "sight_urmatrans_shelf_nber",
      "sight_urmatrans_shelf_redbull"
    }
  },
  {
    name = "Los Santos Burger Shot",
    loadingBay = {
      1176.9814453125,
      -888.71484375,
      8.5615234375,
      8.8330078125,
      42.28
    },
    items = {
      "sight_urmatrans_shelf_tvpapr",
      "sight_urmatrans_shelf_chili",
      "sight_urmatrans_shelf_repa",
      "sight_urmatrans_shelf_onion",
      "sight_urmatrans_shelf_onion2",
      "sight_urmatrans_shelf_cucum",
      "sight_urmatrans_shelf_radish",
      "sight_urmatrans_shelf_cabbage",
      "sight_urmatrans_shelf_salad",
      "sight_urmatrans_shelf_fanta",
      "sight_urmatrans_shelf_cocacola",
      "sight_urmatrans_shelf_pepsi",
      "sight_urmatrans_shelf_soproni",
      "sight_urmatrans_shelf_somersby",
      "sight_urmatrans_shelf_hell",
      "sight_urmatrans_shelf_pepsi2",
      "sight_urmatrans_shelf_nber",
      "sight_urmatrans_shelf_redbull"
    }
  },
  {
    name = "Boxter Mechanic Shop",
    loadingBay = createLoadingBay(2463.21484375, -2498.04296875, 2469.8876953125, -2500.966796875, 13.6484375),
    items = {
      "sight_urmatrans_shelf_fanta",
      "sight_urmatrans_shelf_cocacola",
      "sight_urmatrans_shelf_pepsi",
      "sight_urmatrans_shelf_szkiralyi1",
      "sight_urmatrans_shelf_szkiralyi2",
      "sight_urmatrans_shelf_szkiralyi3",
      "sight_urmatrans_shelf_hell",
      "sight_urmatrans_shelf_pepsi2",
      "sight_urmatrans_shelf_nber",
      "sight_urmatrans_shelf_redbull"
    }
  },
  {
    name = "Jefferson Motel",
    loadingBay = {
      2225.52734375,
      -1169.3271484375,
      5.650390625,
      7,
      24.79
    },
    items = {
      "sight_urmatrans_shelf_almapapr",
      "sight_urmatrans_shelf_tvpapr",
      "sight_urmatrans_shelf_chili",
      "sight_urmatrans_shelf_repa",
      "sight_urmatrans_shelf_onion",
      "sight_urmatrans_shelf_onion2",
      "sight_urmatrans_shelf_cucum",
      "sight_urmatrans_shelf_karalabe",
      "sight_urmatrans_shelf_radish",
      "sight_urmatrans_shelf_cabbage",
      "sight_urmatrans_shelf_salad",
      "sight_urmatrans_shelf_pumpkin",
      "sight_urmatrans_shelf_waterm",
      "sight_urmatrans_shelf_fanta",
      "sight_urmatrans_shelf_cocacola",
      "sight_urmatrans_shelf_pepsi",
      "sight_urmatrans_shelf_szkiralyi1",
      "sight_urmatrans_shelf_szkiralyi2",
      "sight_urmatrans_shelf_szkiralyi3",
      "sight_urmatrans_shelf_kobanyai",
      "sight_urmatrans_shelf_soproni",
      "sight_urmatrans_shelf_tokaji",
      "sight_urmatrans_shelf_soproni2",
      "sight_urmatrans_shelf_somersby",
      "sight_urmatrans_shelf_hell",
      "sight_urmatrans_shelf_pepsi2",
      "sight_urmatrans_shelf_nber",
      "sight_urmatrans_shelf_redbull"
    }
  },
  {
    name = "Dillimore Gasso kút",
    loadingBay = {
      664.609375,
      -585.529296875,
      5.9833984375,
      7.2626953125,
      15.35
    },
    items = {
      "sight_urmatrans_shelf_almapapr",
      "sight_urmatrans_shelf_tvpapr",
      "sight_urmatrans_shelf_chili",
      "sight_urmatrans_shelf_repa",
      "sight_urmatrans_shelf_onion",
      "sight_urmatrans_shelf_onion2",
      "sight_urmatrans_shelf_cucum",
      "sight_urmatrans_shelf_karalabe",
      "sight_urmatrans_shelf_radish",
      "sight_urmatrans_shelf_cabbage",
      "sight_urmatrans_shelf_salad",
      "sight_urmatrans_shelf_pumpkin",
      "sight_urmatrans_shelf_waterm",
      "sight_urmatrans_shelf_fanta",
      "sight_urmatrans_shelf_cocacola",
      "sight_urmatrans_shelf_pepsi",
      "sight_urmatrans_shelf_szkiralyi1",
      "sight_urmatrans_shelf_szkiralyi2",
      "sight_urmatrans_shelf_szkiralyi3",
      "sight_urmatrans_shelf_kobanyai",
      "sight_urmatrans_shelf_soproni",
      "sight_urmatrans_shelf_tokaji",
      "sight_urmatrans_shelf_soproni2",
      "sight_urmatrans_shelf_somersby",
      "sight_urmatrans_shelf_hell",
      "sight_urmatrans_shelf_pepsi2",
      "sight_urmatrans_shelf_nber",
      "sight_urmatrans_shelf_redbull"
    }
  },
  {
    name = "Los Santos Cluckin Bell",
    loadingBay = {
      2390.19921875,
      -1489.3291015625,
      4.2939453125,
      8.7705078125,
      22.84
    },
    items = {
      "sight_urmatrans_shelf_tvpapr",
      "sight_urmatrans_shelf_chili",
      "sight_urmatrans_shelf_repa",
      "sight_urmatrans_shelf_onion",
      "sight_urmatrans_shelf_onion2",
      "sight_urmatrans_shelf_cucum",
      "sight_urmatrans_shelf_radish",
      "sight_urmatrans_shelf_cabbage",
      "sight_urmatrans_shelf_salad",
      "sight_urmatrans_shelf_fanta",
      "sight_urmatrans_shelf_cocacola",
      "sight_urmatrans_shelf_pepsi",
      "sight_urmatrans_shelf_soproni",
      "sight_urmatrans_shelf_somersby",
      "sight_urmatrans_shelf_hell",
      "sight_urmatrans_shelf_pepsi2",
      "sight_urmatrans_shelf_nber",
      "sight_urmatrans_shelf_redbull"
    }
  },
  {
    name = "Los Santos Cluckin Bell",
    loadingBay = {
      2383.4736328125,
      -1941.2666015625,
      3.71484375,
      9.4580078125,
      12.56
    },
    items = {
      "sight_urmatrans_shelf_tvpapr",
      "sight_urmatrans_shelf_chili",
      "sight_urmatrans_shelf_repa",
      "sight_urmatrans_shelf_onion",
      "sight_urmatrans_shelf_onion2",
      "sight_urmatrans_shelf_cucum",
      "sight_urmatrans_shelf_radish",
      "sight_urmatrans_shelf_cabbage",
      "sight_urmatrans_shelf_salad",
      "sight_urmatrans_shelf_fanta",
      "sight_urmatrans_shelf_cocacola",
      "sight_urmatrans_shelf_pepsi",
      "sight_urmatrans_shelf_soproni",
      "sight_urmatrans_shelf_somersby",
      "sight_urmatrans_shelf_hell",
      "sight_urmatrans_shelf_pepsi2",
      "sight_urmatrans_shelf_nber",
      "sight_urmatrans_shelf_redbull"
    }
  },
  {
    name = "Los Santos 24/7",
    loadingBay = {
      1356.4111328125,
      -1755.8955078125,
      4.3447265625,
      8.20703125,
      12.39
    },
    items = {
      "sight_urmatrans_shelf_almapapr",
      "sight_urmatrans_shelf_tvpapr",
      "sight_urmatrans_shelf_chili",
      "sight_urmatrans_shelf_repa",
      "sight_urmatrans_shelf_onion",
      "sight_urmatrans_shelf_onion2",
      "sight_urmatrans_shelf_cucum",
      "sight_urmatrans_shelf_karalabe",
      "sight_urmatrans_shelf_radish",
      "sight_urmatrans_shelf_cabbage",
      "sight_urmatrans_shelf_salad",
      "sight_urmatrans_shelf_pumpkin",
      "sight_urmatrans_shelf_waterm",
      "sight_urmatrans_shelf_fanta",
      "sight_urmatrans_shelf_cocacola",
      "sight_urmatrans_shelf_pepsi",
      "sight_urmatrans_shelf_szkiralyi1",
      "sight_urmatrans_shelf_szkiralyi2",
      "sight_urmatrans_shelf_szkiralyi3",
      "sight_urmatrans_shelf_kobanyai",
      "sight_urmatrans_shelf_soproni",
      "sight_urmatrans_shelf_tokaji",
      "sight_urmatrans_shelf_soproni2",
      "sight_urmatrans_shelf_somersby",
      "sight_urmatrans_shelf_hell",
      "sight_urmatrans_shelf_pepsi2",
      "sight_urmatrans_shelf_nber",
      "sight_urmatrans_shelf_redbull"
    }
  },
  {
    name = "Los Santos 24/7",
    loadingBay = {
      1305.478515625,
      -876.255859375,
      8.7138671875,
      5.2060546875,
      38.59
    },
    items = {
      "sight_urmatrans_shelf_almapapr",
      "sight_urmatrans_shelf_tvpapr",
      "sight_urmatrans_shelf_chili",
      "sight_urmatrans_shelf_repa",
      "sight_urmatrans_shelf_onion",
      "sight_urmatrans_shelf_onion2",
      "sight_urmatrans_shelf_cucum",
      "sight_urmatrans_shelf_karalabe",
      "sight_urmatrans_shelf_radish",
      "sight_urmatrans_shelf_cabbage",
      "sight_urmatrans_shelf_salad",
      "sight_urmatrans_shelf_pumpkin",
      "sight_urmatrans_shelf_waterm",
      "sight_urmatrans_shelf_fanta",
      "sight_urmatrans_shelf_cocacola",
      "sight_urmatrans_shelf_pepsi",
      "sight_urmatrans_shelf_szkiralyi1",
      "sight_urmatrans_shelf_szkiralyi2",
      "sight_urmatrans_shelf_szkiralyi3",
      "sight_urmatrans_shelf_kobanyai",
      "sight_urmatrans_shelf_soproni",
      "sight_urmatrans_shelf_tokaji",
      "sight_urmatrans_shelf_soproni2",
      "sight_urmatrans_shelf_somersby",
      "sight_urmatrans_shelf_hell",
      "sight_urmatrans_shelf_pepsi2",
      "sight_urmatrans_shelf_nber",
      "sight_urmatrans_shelf_redbull"
    }
  },
  {
    name = "Los Santos 24/7",
    loadingBay = {
      1387.6708984375,
      -1898.2607421875,
      9.2578125,
      5.443359375,
      12.51
    },
    items = {
      "sight_urmatrans_shelf_almapapr",
      "sight_urmatrans_shelf_tvpapr",
      "sight_urmatrans_shelf_chili",
      "sight_urmatrans_shelf_repa",
      "sight_urmatrans_shelf_onion",
      "sight_urmatrans_shelf_onion2",
      "sight_urmatrans_shelf_cucum",
      "sight_urmatrans_shelf_karalabe",
      "sight_urmatrans_shelf_radish",
      "sight_urmatrans_shelf_cabbage",
      "sight_urmatrans_shelf_salad",
      "sight_urmatrans_shelf_pumpkin",
      "sight_urmatrans_shelf_waterm",
      "sight_urmatrans_shelf_fanta",
      "sight_urmatrans_shelf_cocacola",
      "sight_urmatrans_shelf_pepsi",
      "sight_urmatrans_shelf_szkiralyi1",
      "sight_urmatrans_shelf_szkiralyi2",
      "sight_urmatrans_shelf_szkiralyi3",
      "sight_urmatrans_shelf_kobanyai",
      "sight_urmatrans_shelf_soproni",
      "sight_urmatrans_shelf_tokaji",
      "sight_urmatrans_shelf_soproni2",
      "sight_urmatrans_shelf_somersby",
      "sight_urmatrans_shelf_hell",
      "sight_urmatrans_shelf_pepsi2",
      "sight_urmatrans_shelf_nber",
      "sight_urmatrans_shelf_redbull"
    }
  },
  {
    name = "See City Mall",
    loadingBay = createLoadingBay(1124.037109375, -1539.5146484375, 1132.9658203125, -1547.150390625, 13.95432472229),
    items = {
      "sight_urmatrans_shelf_almapapr",
      "sight_urmatrans_shelf_tvpapr",
      "sight_urmatrans_shelf_chili",
      "sight_urmatrans_shelf_repa",
      "sight_urmatrans_shelf_onion",
      "sight_urmatrans_shelf_onion2",
      "sight_urmatrans_shelf_cucum",
      "sight_urmatrans_shelf_karalabe",
      "sight_urmatrans_shelf_radish",
      "sight_urmatrans_shelf_cabbage",
      "sight_urmatrans_shelf_salad",
      "sight_urmatrans_shelf_pumpkin",
      "sight_urmatrans_shelf_waterm",
      "sight_urmatrans_shelf_fanta",
      "sight_urmatrans_shelf_cocacola",
      "sight_urmatrans_shelf_pepsi",
      "sight_urmatrans_shelf_szkiralyi1",
      "sight_urmatrans_shelf_szkiralyi2",
      "sight_urmatrans_shelf_szkiralyi3",
      "sight_urmatrans_shelf_kobanyai",
      "sight_urmatrans_shelf_soproni",
      "sight_urmatrans_shelf_tokaji",
      "sight_urmatrans_shelf_soproni2",
      "sight_urmatrans_shelf_somersby",
      "sight_urmatrans_shelf_hell",
      "sight_urmatrans_shelf_pepsi2",
      "sight_urmatrans_shelf_nber",
      "sight_urmatrans_shelf_redbull"
    }
  },
  {
    name = "Los Santos Kórház",
    loadingBay = createLoadingBay(1145.61328125, -1353.5390625, 1149.61328125, -1347.5390625, 13.647333145142),
    items = {
      "sight_urmatrans_shelf_almapapr",
      "sight_urmatrans_shelf_tvpapr",
      "sight_urmatrans_shelf_chili",
      "sight_urmatrans_shelf_repa",
      "sight_urmatrans_shelf_onion",
      "sight_urmatrans_shelf_onion2",
      "sight_urmatrans_shelf_cucum",
      "sight_urmatrans_shelf_karalabe",
      "sight_urmatrans_shelf_radish",
      "sight_urmatrans_shelf_cabbage",
      "sight_urmatrans_shelf_salad",
      "sight_urmatrans_shelf_pumpkin",
      "sight_urmatrans_shelf_waterm",
      "sight_urmatrans_shelf_szkiralyi1",
      "sight_urmatrans_shelf_szkiralyi2",
      "sight_urmatrans_shelf_szkiralyi3"
    }
  },
  {
    name = "sOIL Shop LS",
    loadingBay = createLoadingBay(1934.470703125, -1805.765625, 1930.3974609375, -1811.0322265625, 13.384672164917),
    items = {
      "sight_urmatrans_shelf_almapapr",
      "sight_urmatrans_shelf_tvpapr",
      "sight_urmatrans_shelf_chili",
      "sight_urmatrans_shelf_repa",
      "sight_urmatrans_shelf_onion",
      "sight_urmatrans_shelf_onion2",
      "sight_urmatrans_shelf_cucum",
      "sight_urmatrans_shelf_karalabe",
      "sight_urmatrans_shelf_radish",
      "sight_urmatrans_shelf_cabbage",
      "sight_urmatrans_shelf_salad",
      "sight_urmatrans_shelf_pumpkin",
      "sight_urmatrans_shelf_waterm",
      "sight_urmatrans_shelf_fanta",
      "sight_urmatrans_shelf_cocacola",
      "sight_urmatrans_shelf_pepsi",
      "sight_urmatrans_shelf_szkiralyi1",
      "sight_urmatrans_shelf_szkiralyi2",
      "sight_urmatrans_shelf_szkiralyi3",
      "sight_urmatrans_shelf_kobanyai",
      "sight_urmatrans_shelf_soproni",
      "sight_urmatrans_shelf_tokaji",
      "sight_urmatrans_shelf_soproni2",
      "sight_urmatrans_shelf_somersby",
      "sight_urmatrans_shelf_hell",
      "sight_urmatrans_shelf_pepsi2",
      "sight_urmatrans_shelf_nber",
      "sight_urmatrans_shelf_redbull"
    }
  },
  {
    name = "sOIL Shop LS",
    loadingBay = createLoadingBay(1004.5341796875, -894.6865234375, 1009.5751953125, -890.376953125, 42.226921081543),
    items = {
      "sight_urmatrans_shelf_almapapr",
      "sight_urmatrans_shelf_tvpapr",
      "sight_urmatrans_shelf_chili",
      "sight_urmatrans_shelf_repa",
      "sight_urmatrans_shelf_onion",
      "sight_urmatrans_shelf_onion2",
      "sight_urmatrans_shelf_cucum",
      "sight_urmatrans_shelf_karalabe",
      "sight_urmatrans_shelf_radish",
      "sight_urmatrans_shelf_cabbage",
      "sight_urmatrans_shelf_salad",
      "sight_urmatrans_shelf_pumpkin",
      "sight_urmatrans_shelf_waterm",
      "sight_urmatrans_shelf_fanta",
      "sight_urmatrans_shelf_cocacola",
      "sight_urmatrans_shelf_pepsi",
      "sight_urmatrans_shelf_szkiralyi1",
      "sight_urmatrans_shelf_szkiralyi2",
      "sight_urmatrans_shelf_szkiralyi3",
      "sight_urmatrans_shelf_kobanyai",
      "sight_urmatrans_shelf_soproni",
      "sight_urmatrans_shelf_tokaji",
      "sight_urmatrans_shelf_soproni2",
      "sight_urmatrans_shelf_somersby",
      "sight_urmatrans_shelf_hell",
      "sight_urmatrans_shelf_pepsi2",
      "sight_urmatrans_shelf_nber",
      "sight_urmatrans_shelf_redbull"
    }
  }
}
local names = {}
for i = 1, #companies do
  companies[i].blip = {
    companies[i].loadingBay[1] + companies[i].loadingBay[3] / 2,
    companies[i].loadingBay[2] + companies[i].loadingBay[4] / 2,
    companies[i].loadingBay[5] + 1
  }
  local n = #companies[i].items
  local tmp = {}
  for j = 1, n do
    tmp[cargoIds[companies[i].items[j]]] = true
  end
  names[companies[i].name] = (names[companies[i].name] or 0) + 1
  companies[i].items = tmp
end
for name, num in pairs(names) do
  if 1 < num then
    local j = 1
    for i = 1, #companies do
      if companies[i].name == name then
        companies[i].name = companies[i].name .. " #" .. j
        j = j + 1
      end
    end
  end
end
cargoTypes = {
  sight_urmatrans_shelf_almapapr = {
    cargo = "sight_urmatrans_cargo_almapapr",
    name = "Almapaprika",
    quantity = "láda",
    height = 0.26,
    width = 0.6,
    length = 1,
    cargoPos = {
      {
        1.5115,
        -0.6648,
        1.1514,
        90
      },
      {
        0.5067,
        -0.6831,
        1.4193,
        85.5
      },
      {
        -0.5552,
        -0.8065,
        1.1514,
        92.7
      },
      {
        -1.5492,
        -0.7156,
        0.89,
        90
      }
    }
  },
  sight_urmatrans_shelf_tvpapr = {
    cargo = "sight_urmatrans_cargo_tvpapr",
    name = "TV Paprika",
    quantity = "láda",
    height = 0.26,
    width = 0.6,
    length = 1,
    cargoPos = {
      {
        1.5077,
        -0.672,
        1.1514,
        90.3
      },
      {
        -0.5573,
        -0.8063,
        1.1514,
        92.6
      },
      {
        -1.5661,
        -0.7084,
        0.89,
        90
      }
    }
  },
  sight_urmatrans_shelf_chili = {
    cargo = "sight_urmatrans_cargo_chili",
    name = "Pirospaprika",
    quantity = "láda",
    height = 0.26,
    width = 0.6,
    length = 1,
    cargoPos = {
      {
        1.5077,
        -0.672,
        1.1514,
        90.3
      },
      {
        -0.5573,
        -0.8063,
        1.1514,
        92.6
      },
      {
        -1.5661,
        -0.7084,
        0.89,
        90
      }
    }
  },
  sight_urmatrans_shelf_repa = {
    cargo = "sight_urmatrans_cargo_repa",
    name = "Répa",
    quantity = "láda",
    height = 0.26,
    width = 0.6,
    length = 1,
    cargoPos = {
      {
        1.5077,
        -0.672,
        1.1514,
        90.3
      },
      {
        -0.5573,
        -0.8063,
        1.1514,
        92.6
      },
      {
        -1.5661,
        -0.7084,
        0.89,
        90
      }
    }
  },
  sight_urmatrans_shelf_onion = {
    cargo = "sight_urmatrans_cargo_onion",
    name = "Vöröshagyma",
    quantity = "láda",
    height = 0.26,
    width = 0.6,
    length = 1,
    cargoPos = {
      {
        1.5077,
        -0.672,
        1.1514,
        90.3
      },
      {
        -0.5573,
        -0.8063,
        1.1514,
        92.6
      },
      {
        -1.5661,
        -0.7084,
        0.89,
        90
      }
    }
  },
  sight_urmatrans_shelf_onion2 = {
    cargo = "sight_urmatrans_cargo_onion2",
    name = "Lilahagyma",
    quantity = "láda",
    height = 0.26,
    width = 0.6,
    length = 1,
    cargoPos = {
      {
        1.5077,
        -0.672,
        1.1514,
        90.3
      },
      {
        -0.5573,
        -0.8063,
        1.1514,
        92.6
      },
      {
        -1.5661,
        -0.7084,
        0.89,
        90
      }
    }
  },
  sight_urmatrans_shelf_cucum = {
    cargo = "sight_urmatrans_cargo_cucum",
    name = "Uborka",
    quantity = "láda",
    height = 0.26,
    width = 0.6,
    length = 1,
    cargoPos = {
      {
        1.5077,
        -0.672,
        1.1514,
        90.3
      },
      {
        -0.5573,
        -0.8063,
        1.1514,
        92.6
      },
      {
        -1.5661,
        -0.7084,
        0.89,
        90
      }
    }
  },
  sight_urmatrans_shelf_karalabe = {
    cargo = "sight_urmatrans_cargo_karalabe",
    name = "Karalábé",
    quantity = "láda",
    height = 0.26,
    width = 0.6,
    length = 1,
    cargoPos = {
      {
        1.5077,
        -0.672,
        1.1514,
        90.3
      },
      {
        -0.5573,
        -0.8063,
        1.1514,
        92.6
      },
      {
        -1.5661,
        -0.7084,
        0.89,
        90
      }
    }
  },
  sight_urmatrans_shelf_radish = {
    cargo = "sight_urmatrans_cargo_radish",
    name = "Retek",
    quantity = "láda",
    height = 0.26,
    width = 0.6,
    length = 1,
    cargoPos = {
      {
        1.5077,
        -0.672,
        1.1514,
        90.3
      },
      {
        -0.5573,
        -0.8063,
        1.1514,
        92.6
      },
      {
        -1.5661,
        -0.7084,
        0.89,
        90
      }
    }
  },
  sight_urmatrans_shelf_cabbage = {
    cargo = "sight_urmatrans_cargo_cabbage",
    name = "Káposzta",
    quantity = "láda",
    height = 0.26,
    width = 0.6,
    length = 1,
    cargoPos = {
      {
        1.5077,
        -0.672,
        1.1514,
        90.3
      },
      {
        -0.5573,
        -0.8063,
        1.1514,
        92.6
      },
      {
        -1.5661,
        -0.7084,
        0.89,
        90
      }
    }
  },
  sight_urmatrans_shelf_salad = {
    cargo = "sight_urmatrans_cargo_salad",
    name = "Saláta",
    quantity = "láda",
    height = 0.26,
    width = 0.6,
    length = 1,
    cargoPos = {
      {
        1.5077,
        -0.672,
        1.1514,
        90.3
      },
      {
        -0.5573,
        -0.8063,
        1.1514,
        92.6
      },
      {
        -1.5661,
        -0.7084,
        0.89,
        90
      }
    }
  },
  sight_urmatrans_shelf_pumpkin = {
    cargo = "sight_urmatrans_cargo_pumpkin",
    name = "Tök",
    quantity = "láda",
    height = 0.494,
    width = 0.6,
    length = 1,
    cargoPos = {
      {
        1.57,
        -0.6264,
        1.1255,
        90
      },
      {
        0.5496,
        -0.6264,
        1.1255,
        90
      },
      {
        -0.5001,
        -0.6899,
        0.6362,
        90
      },
      {
        -1.5077,
        -0.7405,
        1.1255,
        90
      }
    }
  },
  sight_urmatrans_shelf_waterm = {
    cargo = "sight_urmatrans_cargo_waterm",
    name = "Görögdinnye",
    quantity = "láda",
    height = 0.494,
    width = 0.6,
    length = 1,
    cargoPos = {
      {
        1.57,
        -0.6264,
        1.1255,
        90
      },
      {
        0.5496,
        -0.6264,
        1.1255,
        90
      },
      {
        -0.5001,
        -0.6899,
        0.6362,
        90
      },
      {
        -1.5077,
        -0.7405,
        1.1255,
        90
      }
    }
  },
  sight_urmatrans_shelf_fanta = {
    cargo = "sight_urmatrans_cargo_fanta",
    name = "Fanta",
    quantity = "rekesz",
    height = 0.310628,
    width = 0.42,
    length = 0.6,
    cargoPos = {
      {
        1.7962,
        -0.7056,
        1.245,
        94
      },
      {
        1.0967,
        -0.7056,
        1.245,
        91
      },
      {
        0.4436,
        -0.606,
        1.245,
        86
      },
      {
        -0.3934,
        -0.7087,
        0.9379,
        93
      },
      {
        -1.0517,
        -0.7309,
        1.2467,
        93
      },
      {
        -1.6889,
        -0.7309,
        0.6335,
        83.5
      }
    }
  },
  sight_urmatrans_shelf_cocacola = {
    cargo = "sight_urmatrans_cargo_cocacola",
    name = "Coca Cola",
    quantity = "rekesz",
    height = 0.310628,
    width = 0.42,
    length = 0.6,
    cargoPos = {
      {
        1.7962,
        -0.7056,
        1.245,
        94
      },
      {
        1.0967,
        -0.7056,
        1.245,
        91
      },
      {
        0.4436,
        -0.606,
        1.245,
        86
      },
      {
        -0.3934,
        -0.7087,
        0.9379,
        93
      },
      {
        -1.0517,
        -0.7309,
        1.2467,
        93
      },
      {
        -1.6889,
        -0.7309,
        0.6335,
        83.5
      }
    }
  },
  sight_urmatrans_shelf_pepsi = {
    cargo = "sight_urmatrans_cargo_pepsi",
    name = "Pepsi",
    quantity = "rekesz",
    height = 0.310628,
    width = 0.42,
    length = 0.6,
    cargoPos = {
      {
        1.7962,
        -0.7056,
        1.245,
        94
      },
      {
        1.0967,
        -0.7056,
        1.245,
        91
      },
      {
        0.4436,
        -0.606,
        1.245,
        86
      },
      {
        -0.3934,
        -0.7087,
        0.9379,
        93
      },
      {
        -1.0517,
        -0.7309,
        1.2467,
        93
      },
      {
        -1.6889,
        -0.7309,
        0.6335,
        83.5
      }
    }
  },
  sight_urmatrans_shelf_szkiralyi1 = {
    cargo = "sight_urmatrans_cargo_szkiralyi1",
    name = "Savas Szentkirályi",
    quantity = "zsugor",
    height = 0.474023,
    width = 0.34,
    length = 0.5,
    cargoPos = {
      {
        2.0675,
        -0.7971,
        1.0984,
        0
      },
      {
        1.7096,
        -0.7971,
        1.0984,
        0
      },
      {
        1.0119,
        -0.7971,
        0.6266,
        0
      },
      {
        0.6597,
        -0.7971,
        1.0984,
        0
      },
      {
        -0.9807,
        -0.7971,
        1.0984,
        0
      },
      {
        -1.6879,
        -0.7971,
        1.0984,
        0
      },
      {
        -2.0395,
        -0.7971,
        1.0984,
        0
      }
    }
  },
  sight_urmatrans_shelf_szkiralyi2 = {
    cargo = "sight_urmatrans_cargo_szkiralyi2",
    name = "Mentes Szentkirályi",
    quantity = "zsugor",
    height = 0.474023,
    width = 0.34,
    length = 0.5,
    cargoPos = {
      {
        2.0675,
        -0.7971,
        1.0984,
        0
      },
      {
        1.7096,
        -0.7971,
        1.0984,
        0
      },
      {
        1.0119,
        -0.7971,
        0.6266,
        0
      },
      {
        0.6597,
        -0.7971,
        1.0984,
        0
      },
      {
        -0.9807,
        -0.7971,
        1.0984,
        0
      },
      {
        -1.6879,
        -0.7971,
        1.0984,
        0
      },
      {
        -2.0395,
        -0.7971,
        1.0984,
        0
      }
    }
  },
  sight_urmatrans_shelf_szkiralyi3 = {
    cargo = "sight_urmatrans_cargo_szkiralyi3",
    name = "Enyhe Szentkirályi",
    quantity = "zsugor",
    height = 0.474023,
    width = 0.34,
    length = 0.5,
    cargoPos = {
      {
        2.0675,
        -0.7971,
        1.0984,
        0
      },
      {
        1.7096,
        -0.7971,
        1.0984,
        0
      },
      {
        1.0119,
        -0.7971,
        0.6266,
        0
      },
      {
        0.6597,
        -0.7971,
        1.0984,
        0
      },
      {
        -0.9807,
        -0.7971,
        1.0984,
        0
      },
      {
        -1.6879,
        -0.7971,
        1.0984,
        0
      },
      {
        -2.0395,
        -0.7971,
        1.0984,
        0
      }
    }
  },
  sight_urmatrans_shelf_kobanyai = {
    cargo = "sight_urmatrans_cargo_kobanyai",
    name = "Kőbányai",
    quantity = "zsugor",
    height = 0.444023,
    width = 0.34,
    length = 0.5,
    cargoPos = {
      {
        2.0675,
        -0.7971,
        1.0984,
        0
      },
      {
        1.7096,
        -0.7971,
        1.0984,
        0
      },
      {
        1.0119,
        -0.7971,
        0.6266,
        0
      },
      {
        0.6597,
        -0.7971,
        1.0984,
        0
      },
      {
        -0.9807,
        -0.7971,
        1.0984,
        0
      },
      {
        -1.6879,
        -0.7971,
        1.0984,
        0
      },
      {
        -2.0395,
        -0.7971,
        1.0984,
        0
      }
    }
  },
  sight_urmatrans_shelf_soproni = {
    cargo = "sight_urmatrans_cargo_soproni",
    name = "Üveges Soproni",
    quantity = "rekesz",
    height = 0.310628,
    width = 0.42,
    length = 0.6,
    cargoPos = {
      {
        1.7962,
        -0.7056,
        1.245,
        94
      },
      {
        1.0967,
        -0.7056,
        1.245,
        91
      },
      {
        0.4436,
        -0.606,
        1.245,
        86
      },
      {
        -0.3934,
        -0.7087,
        0.9379,
        93
      },
      {
        -1.0517,
        -0.7309,
        1.2467,
        93
      },
      {
        -1.6889,
        -0.7309,
        0.6335,
        83.5
      }
    }
  },
  sight_urmatrans_shelf_tokaji = {
    cargo = "sight_urmatrans_cargo_tokaji",
    name = "Tokaji bor",
    quantity = "rekesz",
    height = 0.310628,
    width = 0.42,
    length = 0.6,
    cargoPos = {
      {
        1.7962,
        -0.7056,
        1.245,
        94
      },
      {
        1.0967,
        -0.7056,
        1.245,
        91
      },
      {
        0.4436,
        -0.606,
        1.245,
        86
      },
      {
        -0.3934,
        -0.7087,
        0.9379,
        93
      },
      {
        -1.0517,
        -0.7309,
        1.2467,
        93
      },
      {
        -1.6889,
        -0.7309,
        0.6335,
        83.5
      }
    }
  },
  sight_urmatrans_shelf_soproni2 = {
    cargo = "sight_urmatrans_cargo_soproni2",
    name = "Dobozos Soproni",
    quantity = "tálca",
    height = 0.2,
    width = 0.47,
    length = 0.68,
    cargoPos = {
      {
        1.7507,
        -0.6826,
        0.6335,
        90
      },
      {
        1.0838,
        -0.6969,
        0.8973,
        90
      },
      {
        0.4054,
        -0.6926,
        1.1645,
        90
      },
      {
        -0.4484,
        -0.6877,
        1.1645,
        90
      },
      {
        -1.6181,
        -0.7121,
        0.899,
        93
      }
    }
  },
  sight_urmatrans_shelf_somersby = {
    cargo = "sight_urmatrans_cargo_somersby",
    name = "Somersby",
    quantity = "tálca",
    height = 0.2,
    width = 0.47,
    length = 0.68,
    cargoPos = {
      {
        1.7507,
        -0.6826,
        0.6335,
        90
      },
      {
        1.0838,
        -0.6969,
        0.8973,
        90
      },
      {
        0.4054,
        -0.6926,
        1.1645,
        90
      },
      {
        -0.4484,
        -0.6877,
        1.1645,
        90
      },
      {
        -1.6181,
        -0.7121,
        0.899,
        93
      }
    }
  },
  sight_urmatrans_shelf_hell = {
    cargo = "sight_urmatrans_cargo_hell",
    name = "Hell Classic",
    quantity = "tálca",
    height = 0.16,
    width = 0.47,
    length = 0.68,
    cargoPos = {
      {
        1.7649,
        -0.711,
        0.6335,
        90
      },
      {
        1.0854,
        -0.7258,
        0.7902,
        90
      },
      {
        0.4093,
        -0.7258,
        0.9466,
        90
      },
      {
        -0.4442,
        -0.7179,
        0.9466,
        90
      },
      {
        -1.6167,
        -0.7179,
        0.7957,
        90
      }
    }
  },
  sight_urmatrans_shelf_pepsi2 = {
    cargo = "sight_urmatrans_cargo_pepsi2",
    name = "Pepsi MAX",
    quantity = "tálca",
    height = 0.16,
    width = 0.47,
    length = 0.68,
    cargoPos = {
      {
        1.7649,
        -0.711,
        0.6335,
        90
      },
      {
        1.0854,
        -0.7258,
        0.7902,
        90
      },
      {
        0.4093,
        -0.7258,
        0.9466,
        90
      },
      {
        -0.4442,
        -0.7179,
        0.9466,
        90
      },
      {
        -1.6167,
        -0.7179,
        0.7957,
        90
      }
    }
  },
  sight_urmatrans_shelf_nber = {
    cargo = "sight_urmatrans_cargo_nber",
    name = "NBER Energydrink",
    quantity = "tálca",
    height = 0.16,
    width = 0.47,
    length = 0.68,
    cargoPos = {
      {
        1.7649,
        -0.711,
        0.6335,
        90
      },
      {
        1.0854,
        -0.7258,
        0.7902,
        90
      },
      {
        0.4093,
        -0.7258,
        0.9466,
        90
      },
      {
        -0.4442,
        -0.7179,
        0.9466,
        90
      },
      {
        -1.6167,
        -0.7179,
        0.7957,
        90
      }
    }
  },
  sight_urmatrans_shelf_redbull = {
    cargo = "sight_urmatrans_cargo_redbull",
    name = "RedBull",
    quantity = "tálca",
    height = 0.16,
    width = 0.47,
    length = 0.68,
    cargoPos = {
      {
        1.7649,
        -0.711,
        0.6335,
        90
      },
      {
        1.0854,
        -0.7258,
        0.7902,
        90
      },
      {
        0.4093,
        -0.7258,
        0.9466,
        90
      },
      {
        -0.4442,
        -0.7179,
        0.9466,
        90
      },
      {
        -1.6167,
        -0.7179,
        0.7957,
        90
      }
    }
  }
}
for k, id in pairs(cargoIds) do
  cargoTypes[id] = cargoTypes[k]
  cargoTypes[id].model = k
  cargoTypes[k] = nil
end
for k in pairs(cargoTypes) do
  cargoTypes[k].vol = cargoTypes[k].width * cargoTypes[k].height * cargoTypes[k].length
end
for i = 1, #cargoStacks do
  for k in pairs(cargoStacks[i]) do
    if cargoIds[k] then
      cargoTypes[cargoIds[k]].stack = i
    end
  end
end
cargoIds = nil
