local sightexports = {
  sWeapons = false,
  sItems = false,
  sGui = false
}
local function sightlangProcessExports()
  for k in pairs(sightexports) do
    local res = getResourceFromName(k)
    if res and getResourceState(res) == "running" then
      sightexports[k] = exports[k]
    else
      sightexports[k] = false
    end
  end
end
sightlangProcessExports()
if triggerServerEvent then
  addEventHandler("onClientResourceStart", getRootElement(), sightlangProcessExports, true, "high+9999999999")
end
if triggerClientEvent then
  addEventHandler("onResourceStart", getRootElement(), sightlangProcessExports, true, "high+9999999999")
end
local sightlangWaiterState0 = false
local sightlangWaiterState1 = false
local function sightlangProcessResWaiters()
  if not sightlangWaiterState0 then
    local res0 = getResourceFromName("sItems")
    local res1 = getResourceFromName("sWeapons")
    if res0 and res1 and getResourceState(res0) == "running" and getResourceState(res1) == "running" then
      fetchWeaponData()
      sightlangWaiterState0 = true
    end
  end
  if not sightlangWaiterState1 then
    local res0 = getResourceFromName("sGui")
    local res1 = getResourceFromName("sItems")
    if res0 and res1 and getResourceState(res0) == "running" and getResourceState(res1) == "running" then
      fetchItemDatas()
      sightlangWaiterState1 = true
    end
  end
end
if triggerServerEvent then
  addEventHandler("onClientResourceStart", getRootElement(), sightlangProcessResWaiters)
end
if triggerClientEvent then
  addEventHandler("onResourceStart", getRootElement(), sightlangProcessResWaiters)
end
menus = {
  {
    name = "Fegyverek",
    items = {
      {67, 2500},
      {70, 3000},
      {102, 5000},
      {74, 20000},
      {574, 9000},
      {76, 3200},
      {561, 4600},
      {77, 5000},
      {471, 6200},
      {493, 6200},
      {575, 8200},
      {500, 6200},
      {527, 10500},
      {78, 4500},
      {82, 6600},
      {84, 7200},
      {83, 6600},
      {556, 7100},
      {520, 12500},
      {528, 13000},
      {492, 12000},
      {80, 9500},
      {79, 6500},
      {489, 9900},
      {81, 12500},
      {85, 7700},
      {475, 13000},
      {86, 8000},
      {507, 13000},
      {512, 14000},
      {480, 13000},
      {483, 14000},
      {486, 15000},
      {87, 7500},
      {517, 12000},
      {88, 17500},
      {562, 22600},
      {505, 27600},
      {93, 500},
      {94, 500},
      {95, 1000}
    }
  },
  {
    name = "Skines fegyverek",
    items = {
      {280, 12000},
      {281, 12000},
      {282, 12000},
      {407, 12000},
      {408, 12000},
      {409, 12000},
      {410, 13500},
      {411, 13500},
      {472, 18500},
      {473, 18500},
      {474, 20500},
      {494, 19500},
      {495, 18500},
      {496, 22100},
      {497, 23100},
      {498, 18500},
      {499, 19000},
      {576, 21500},
      {577, 20500},
      {578, 24100},
      {579, 25100},
      {580, 20500},
      {581, 21000},
      {501, 19500},
      {502, 18500},
      {503, 18500},
      {504, 20500},
      {524, 21500},
      {525, 21500},
      {526, 24500},
      {272, 15500},
      {273, 17500},
      {414, 17500},
      {433, 17500},
      {434, 17500},
      {435, 19500},
      {436, 17500},
      {283, 18500},
      {284, 18500},
      {285, 20500},
      {286, 18500},
      {276, 17500},
      {277, 19500},
      {278, 19500},
      {279, 17500},
      {340, 19000},
      {341, 21500},
      {346, 19000},
      {347, 19000},
      {557, 19000},
      {558, 19000},
      {559, 19000},
      {560, 20500},
      {521, 22500},
      {522, 22500},
      {529, 23500},
      {530, 23500},
      {567, 19500},
      {568, 19500},
      {569, 19500},
      {570, 19500},
      {571, 19500},
      {572, 21500},
      {342, 16800},
      {343, 16800},
      {344, 18800},
      {345, 16800},
      {490, 20800},
      {491, 20800},
      {265, 19500},
      {266, 19500},
      {267, 19500},
      {268, 21500},
      {269, 21500},
      {270, 19500},
      {271, 20500},
      {476, 24500},
      {477, 24500},
      {478, 26500},
      {479, 27500},
      {508, 24500},
      {509, 24500},
      {510, 24500},
      {511, 25500},
      {513, 26500},
      {514, 26500},
      {515, 26500},
      {516, 27500},
      {481, 24500},
      {482, 24500},
      {484, 26500},
      {485, 26500},
      {487, 26500},
      {488, 26500},
      {518, 22000},
      {519, 22000},
      {274, 36000},
      {275, 36000},
      {754, 38000},
      {506, 44000}
    }
  },
  {
    name = "Lőszerek",
    items = {
      {542, 5},
      {534, 5},
      {532, 10},
      {538, 10},
      {531, 10},
      {533, 10},
      {537, 10},
      {535, 10},
      {536, 10},
      {539, 10},
      {540, 10},
      {541, 10}
    }
  },
  {
    name = "Mesterkönyvek",
    items = {
      {234, 2900},
      {563, 2900},
      {235, 2100},
      {545, 3900},
      {547, 3900},
      {548, 3900},
      {552, 4900},
      {236, 3900},
      {555, 3900},
      {237, 3900},
      {238, 3900},
      {564, 4900},
      {554, 4900},
      {546, 4900},
      {244, 4900},
      {242, 3900},
      {566, 4900},
      {243, 4900},
      {239, 4900},
      {543, 4900},
      {240, 4900},
      {549, 4900},
      {544, 4900},
      {241, 3900},
      {553, 4900},
      {551, 5900},
      {565, 5900},
      {550, 5900}
    }
  },
  {
    name = "Speciális itemek/kártyák",
    items = {
      {601, 800},
      {602, 100},
      {600, 200}, 
      {730, 200},
      {731, 200},
      {188, 200},
      {599, 200},
      {603, 100},
      {604, 200},
      {605, 200},
      {591, 400},
      {406, 1490},
      {315, 200},
      {120, 9800},
      {118, 4900},
      {119, 1800},
      {423, 3500},
      {590, 300},
      {405, 50},
      {189, 300},
      {732, 400},
      {153, 200},
      {163, 150},
      {190, 100},
      {148, 50},
      {149, 30}
    }
  },
  {
    name = "Drogok",
    items = {
      {65, 200},
      {17, 700},
      {18, 800},
      {233, 800},
      {444, 800},
      {445, 700},
      {431, 800},
      {449, 300},
      {454, 300},
      {11, 200},
      {57, 100},
      {448, 300},
      {428, 200}
    }
  },
  {
    name = "Blueprintek",
    items = {
      {
        299,
        3000,
        38
      },
      {
        299,
        3000,
        31
      },
      {
        299,
        3000,
        32
      },
      {
        299,
        3000,
        35
      },
      {
        299,
        3000,
        34
      },
      {
        299,
        3000,
        36
      },
      {
        299,
        3000,
        37
      },
      {
        299,
        3000,
        33
      },
      {
        299,
        3000,
        6
      },
      {
        299,
        3000,
        7
      },
      {
        299,
        3000,
        8
      },
      {
        299,
        3000,
        24
      },
      {
        299,
        3000,
        25
      },
      {
        299,
        3000,
        26
      },
      {
        299,
        3000,
        27
      },
      {
        299,
        3000,
        28
      },
      {
        299,
        3000,
        29
      },
      {
        299,
        3000,
        11
      },
      {
        299,
        3000,
        12
      },
      {
        299,
        3000,
        13
      },
      {
        299,
        3000,
        14
      },
      {
        299,
        3000,
        15
      },
      {
        299,
        3000,
        16
      },
      {
        299,
        3000,
        17
      }
    }
  },
  {
    name = "Készpénz",
    items = {
      {
        "money",
        3000,
        10000
      },
      {
        "money",
        6000,
        25000
      },
      {
        "money",
        15000,
        100000
      },
      {
        "money",
        30000,
        500000
      },
      {
        "money",
        50000,
        1500000
      },
      {
        "money",
        75000,
        2000000
      }
    }
  }
}
itemDatas = {}
weaponAmmoNames = {}
weaponsForAmmo = {}
weaponPreviewNames = {}
function fetchWeaponData()
  local weaponItemIds = sightexports.sWeapons:getWeaponItemIds()
  local tmp = {}
  local tmp2 = {}
  for itemId, wep in pairs(weaponItemIds) do
    tmp2[wep] = true
    local ammo = sightexports.sWeapons:getAmmoId(wep)
    if ammo then
      weaponAmmoNames[itemId] = sightexports.sItems:getItemName(ammo)
      tmp[ammo] = true
    end
  end
  for wep in pairs(tmp2) do
    local itemId = sightexports.sWeapons:getMainItemID(wep)
    weaponPreviewNames[itemId] = wep
    local skins = sightexports.sWeapons:getWeaponSkins(wep)
    if skins then
      for item, skin in pairs(skins) do
        weaponPreviewNames[item] = wep .. "_skin_" .. skin
      end
    end
  end
  for id in pairs(tmp) do
    local wps = sightexports.sWeapons:getAmmoWeapons(id)
    if wps then
      weaponsForAmmo[id] = {}
      for i = 1, #wps do
        local item = sightexports.sWeapons:getMainItemID(wps[i])
        table.insert(weaponsForAmmo[id], sightexports.sItems:getItemName(item))
      end
    end
  end
end
function fetchItemDatas()
  for i = 1, #menus do
    for j = 1, #menus[i].items do
      local d3 = menus[i].items[j][3]
      
      if menus[i].items[j][1] == "money" then
        itemDatas[menus[i].items[j][1] .. "-" .. d3] = {
          sightexports.sGui:thousandsStepper(d3) .. " $",
          false,
          false
        }
      elseif d3 then
        itemDatas[menus[i].items[j][1] .. "-" .. d3] = sightexports.sItems:getItemInfoForShop(menus[i].items[j][1], d3)
      else
        itemDatas[menus[i].items[j][1]] = sightexports.sItems:getItemInfoForShop(menus[i].items[j][1])
      end
    end
  end
end
