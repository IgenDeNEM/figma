local sightexports = {sItems = false}
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
local function sightlangProcessResWaiters()
  if not sightlangWaiterState0 then
    local res0 = getResourceFromName("sItems")
    if res0 and getResourceState(res0) == "running" then
      itemsLoaded()
      sightlangWaiterState0 = true
    end
  end
end
if triggerServerEvent then
  addEventHandler("onClientResourceStart", getRootElement(), sightlangProcessResWaiters)
end
if triggerClientEvent then
  addEventHandler("onResourceStart", getRootElement(), sightlangProcessResWaiters)
end
predefCategoryNames = {
  "Összes",
  "Műszaki",
  "Szerszámok",
  "Hobby",
  "Kisállat",
  "Egészség",
  "Gyorsételek",
  "Főtt ételek",
  "Üditők",
  "Forró italok",
  "Alkohol/Cigaretta",
  "Pirotechnika",
  "Farm",
  "Fegyver",
  "Horgászat",
  "Bányászat"
}
categoryIconsRaw = {
  "ellipsis-h",
  "hamburger",
  "burger-soda",
  "meat",
  "utensils-alt",
  "cookie-bite",
  "coffee",
  "coffee-togo",
  "glass-citrus",
  "glass-whiskey-rocks",
  "cocktail",
  "glass-cheers",
  "flask",
  "smoking",
  "mobile-alt",
  "desktop",
  "tools",
  "hammer",
  "car",
  "car-mechanic",
  "fish",
  "carrot",
  "pepper-hot",
  "seedling",
  "bone",
  "dog",
  "heart",
  "medkit",
  "prescription-bottle-alt",
  "pills",
  "book",
  "receipt",
  "shopping-bag",
  "store-alt",
  "store",
  "globe-europe"
}
predefCategories = {
  {},
  {
    4,
    9,
    150,
    610,
    611
  },
  {
    34,
    72,
    164,
    245,
    441,
    446,
    373,
    362,
    470,
    586
  },
  {
    20,
    22,
    23,
    26,
    27,
    68,
    71,
    73,
    97,
    99,
    103,
    104,
    151,
    195,
    204,
    205,
    312,
    430,
    447,
    593,
    311,
    453
  },
  {
    160,
    161,
    162
  },
  {
    148,
    149,
    153,
    372
  },
  {
    6,
    7,
    8,
    126,
    147,
    167,
    168,
    169,
    179,
    180,
    181
  },
  {
    170,
    171,
    172,
    173,
    174,
    175,
    176,
    177,
    178
  },
  {
    39,
    42,
    186,
    420,
    421,
    422
  },
  {
    182,
    183,
    184,
    185
  },
  {
    29,
    40,
    43,
    44,
    45,
    46
  },
  {
    165,
    166,
    297,
    298,
    594
  },
  {
    390,
    391,
    392,
    393,
    394,
    395,
    396,
    397,
    398,
    399,
    400,
    401,
    402,
    403,
    404
  },
  {
    118,
    119,
    76,
    534,
    493,
    542
  },
  {
    614,
    615,
    616,
    619,
    620,
    621,
    622,
    630,
    626,
    627,
    628,
    629
  },
  {
    164,
    593,
    719,
    720,
    721
  }
}
onlyWeaponLicenseItems = {
  [76] = true,
  [534] = true,
  [493] = true,
  [542] = true
}
levelRestriction = {
  [118] = 10,
  [119] = 10,
  [593] = 5,
  [76] = 5,
  [534] = 5,
  [493] = 5,
  [542] = 5
}
globalAllowed = {}
for i = 1, #predefCategories do
  for j = 1, #predefCategories[i] do
    globalAllowed[predefCategories[i][j]] = true
  end
end
local list = {}
function itemsLoaded()
  local n = sightexports.sItems:getLastItemId()
  for i = 1, n do
    if globalAllowed[i] then
      table.insert(predefCategories[1], i)
    end
  end
end
function getPedPrice(tbl, item)
  if tbl[item] then
    return math.max(1, tbl[item])
  else
    return getWholesalePrice(item) or 1
  end
end
wholesalePrices = {}
function getWholesalePrice(item)
  if wholesalePrices[item] then
    return math.max(1, wholesalePrices[item])
  else
    return 1
  end
end
payoutTax = 0.05
