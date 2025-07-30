local seexports = {sVehiclenames = false}
local function sightlangProcessExports()
  for k in pairs(seexports) do
    local res = getResourceFromName(k)
    if res and getResourceState(res) == "running" then
      seexports[k] = exports[k]
    else
      seexports[k] = false
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
colorTable = {
  {
    0,
    0,
    0
  },
  {
    106,
    107,
    109
  },
  {
    255,
    255,
    255
  },
  {
    111,
    2,
    5
  },
  {
    200,
    18,
    25
  },
  {
    7,
    158,
    79
  },
  {
    4,
    21,
    40
  },
  {
    4,
    80,
    156
  },
  {
    110,
    161,
    179
  },
  {
    231,
    116,
    27
  }
}
carshopX, carshopY, carshopZ = 2131.79296875, -1150.03515625, 24.201324462891
carshopDropX, carshopDropY, carshopDropZ = 2131.7958984375, -1145.814453125, 24.655485153198
carshopData = {
  [466] = {
    price = 735000,
    premium = 32500,
    limit = 20
  },
  [424] = {
    price = 2000000,
    premium = 32000,
    limit = 24
  },
  [585] = {
    price = 148000,
    premium = 3800,
    limit = -1
  },
  [526] = {
    price = 138000,
    premium = 6800,
    limit = -1
  },
  [405] = {
    price = 185000,
    premium = 4500,
    limit = -1
  },
  [490] = {
    price = 1200000,
    premium = 25000,
    limit = 10
  },
  [533] = {
    price = 1620000,
    premium = 32000,
    limit = 0
  },
  [580] = {
    price = 830000,
    premium = 23000,
    limit = 25
  },
  [596] = {
    price = 1500000,
    premium = 34000,
    limit = 10
  },
  [602] = {
    price = 1250000,
    premium = 32000,
    limit = 0
  },
  [599] = {
    price = 1100000,
    premium = 22500,
    limit = 15
  },
  [483] = {
    price = 280000,
    premium = 7500,
    limit = 450
  },
  [492] = {
    price = 540000,
    premium = 21500,
    limit = 100
  },
  [421] = {
    price = 185000,
    premium = 5000,
    limit = -1
  },
  [551] = {
    price = 215000,
    premium = 6500,
    limit = -1
  },
  [558] = {
    price = 645000,
    premium = 24000,
    limit = 30
  },
  [503] = {
    price = 3250000,
    premium = 49000,
    limit = 0
  },
  [420] = {
    price = 1150000,
    premium = 26000,
    limit = 20
  },
  [445] = {
    price = 820000,
    premium = 21000,
    limit = 35
  },
  [598] = {
    price = 1700000,
    premium = 21000,
    limit = 15
  },
  [491] = {
    price = 1280000,
    premium = 28000,
    limit = 0
  },
  [549] = {
    price = 3600000,
    premium = 49500,
    limit = 0
  },
  [522] = {
    price = 160000,
    premium = 4000,
    limit = -1
  },
  [400] = {
    price = 695000,
    premium = 19000,
    limit = 120
  },
  [508] = {
    price = 840000,
    premium = 26600,
    limit = 25
  },
  [494] = {
    price = 1950000,
    premium = 40000,
    limit = 0
  },
  [576] = {
    price = 800000,
    premium = 20000,
    limit = 400
  },
  [541] = {
    price = 780000,
    premium = 20000,
    limit = 18
  },
  [467] = {
    price = 182000,
    premium = 4500,
    limit = 200
  },
  [517] = {
    price = 490000,
    premium = 16500,
    limit = 22
  },
  [567] = {
    price = 505000,
    premium = 18000,
    limit = 40
  },
  [554] = {
    price = 145000,
    premium = 4000,
    limit = 80
  },
  [439] = {
    price = 690000,
    premium = 18500,
    limit = -1
  },
  [603] = {
    price = 240000,
    premium = 6500,
    limit = -1
  },
  [426] = {
    price = 1250000,
    premium = 29000,
    limit = 70
  },
  [429] = {
    price = 610000,
    premium = 26900,
    limit = 30
  },
  [521] = {
    price = 190000,
    premium = 6000,
    limit = 200
  },
  [555] = {
    price = 3500000,
    premium = 38000,
    limit = 4
  },
  [411] = {
    price = 2850000,
    premium = 33000,
    limit = 30
  },
  [413] = {
    price = 160000,
    premium = 3500,
    limit = -1
  },
  [605] = {
    price = 85000,
    premium = 2500,
    limit = 500
  },
  [495] = {
    price = 1400000,
    premium = 32000,
    limit = 5
  },
  [525] = {
    price = 1800000,
    premium = 36000,
    limit = 0
  },
  [401] = {
    price = 610000,
    premium = 16500,
    limit = 300
  },
  [527] = {
    price = 685000,
    premium = 18500,
    limit = 30
  },
  [535] = {
    price = 680000,
    premium = 22000,
    limit = 20
  },
  [434] = {
    price = 1380000,
    premium = 36000,
    limit = 5
  },
  [536] = {
    price = 785000,
    premium = 19800,
    limit = 550
  },
  [586] = {
    price = 220000,
    premium = 6900,
    limit = 400
  },
  [463] = {
    price = 230000,
    premium = 6900,
    limit = 500
  },
  [565] = {
    price = 138000,
    premium = 8000,
    limit = 70
  },
  [462] = {
    price = 40000,
    premium = 2500,
    limit = -1
  },
  [542] = {
    price = 38000,
    premium = 1000,
    limit = -1
  },
  [470] = {
    price = 480000,
    premium = 19500,
    limit = 350
  },
  [500] = {
    price = 360000,
    premium = 9500,
    limit = 1000
  },
  [546] = {
    price = 85000,
    premium = 2000,
    limit = -1
  },
  [451] = {
    price = 950000,
    premium = 27000,
    limit = 18
  },
  [409] = {
    price = 1100000,
    premium = 26000,
    limit = 60
  },
  [534] = {
    price = 690000,
    premium = 18000,
    limit = 15
  },
  [477] = {
    price = 205000,
    premium = 8500,
    limit = 60
  },
  [506] = {
    price = 1400000,
    premium = 32000,
    limit = 0
  },
  [479] = {
    price = 1200000,
    premium = 35000,
    limit = 5
  },
  [516] = {
    price = 685000,
    premium = 18500,
    limit = 300
  },
  [502] = {
    price = 1650000,
    premium = 32000,
    limit = 0
  },
  [415] = {
    price = 5560000,
    premium = 51500,
    limit = 0
  },
  [438] = {
    price = 700000,
    premium = 21500,
    limit = 30
  },
  [550] = {
    price = 240000,
    premium = 8000,
    limit = 30
  },
  [507] = {
    price = 480000,
    premium = 14800,
    limit = -1
  },
  [404] = {
    price = 2350000,
    premium = 46500,
    limit = 2
  },
  [604] = {
    price = 2300000,
    premium = 49500,
    limit = 0
  },
  [582] = {
    price = 400000,
    premium = 12000,
    limit = -1
  },
  [560] = {
    price = 540000,
    premium = 22000,
    limit = 60
  },
  [587] = {
    price = 990000,
    premium = 28000,
    limit = 30
  },
  [562] = {
    price = 540000,
    premium = 21000,
    limit = 60
  },
  [436] = {
    price = 890000,
    premium = 24000,
    limit = 15
  },
  [475] = {
    price = 545000,
    premium = 18000,
    limit = 65
  },
  [402] = {
    price = 265000,
    premium = 9800,
    limit = 450
  },
  [480] = {
    price = 980000,
    premium = 33000,
    limit = 65
  },
  [579] = {
    price = 230000,
    premium = 6000,
    limit = 650
  },
  [529] = {
    price = 160000,
    premium = 4000,
    limit = -1
  },
  [566] = {
    price = 120000,
    premium = 4500,
    limit = -1
  },
  [597] = {
    price = 1100000,
    premium = 24000,
    limit = 20
  },
  [540] = {
    price = 565000,
    premium = 19000,
    limit = 60
  },
  [419] = {
    price = 2200000,
    premium = 38000,
    limit = 0
  },
  [559] = {
    price = 800000,
    premium = 21000,
    limit = 34
  },
  [474] = {
    price = 120000,
    premium = 4000,
    limit = 130
  },
  [547] = {
    price = 165000,
    premium = 3500,
    limit = -1
  },
  [418] = {
    price = 300000,
    premium = 1500,
    limit = -1
  },
  [410] = {
    price = 100000,
    premium = 2800,
    limit = -1
  },
  [561] = {
    price = 208000,
    premium = 5500,
    limit = 60
  },
  [589] = {
    price = 540000,
    premium = 18000,
    limit = 15
  },
  [458] = {
    price = 140000,
    premium = 4000,
    limit = -1
  },
  [496] = {
    price = 320000,
    premium = 8000,
    limit = 420
  },
  [471] = {
    price = 423000,
    premium = 37000,
    limit = 0
  },
  [468] = {
    price = 15000,
    premium = 5000,
    limit = 2600
  },
  [452] = {
    price = 990000,
    premium = 17000,
    limit = 8
  },
  [446] = {
    price = 2200000,
    premium = 30000,
    limit = 1
  },
  [454] = {
    price = 1500000,
    premium = 40000,
    limit = 3
  },
  [473] = {
    price = 120000,
    premium = 10000,
    limit = 250
  },
  [484] = {
    price = 500000,
    premium = 35000,
    limit = 10
  },
  [453] = {
    price = 110000,
    premium = 7500,
    limit = -1
  },
  [487] = {
    price = 1500000,
    premium = 36000,
    limit = 0
  },
  [422] = {
    price = 25000,
    premium = 2000,
    limit = -1
  },
  [478] = {
    price = 25000,
    premium = 2000,
    limit = -1
  },
  [481] = {
    price = 5000,
    premium = 800,
    limit = -1
  },
  [509] = {
    price = 5000,
    premium = 800,
    limit = -1
  },
  [510] = {
    price = 5000,
    premium = 800,
    limit = -1
  },
  [543] = {
    price = 2500000,
    premium = 45000,
    limit = 0
  },
  ["model_s"] = {
    price = 4500000,
    premium = 49900,
    limit = 0
  },
  ["model_y"] = {
    price = 2400000,
    premium = 39000,
    limit = 5
  },
  ["leaf"] = {
    price = 1900000,
    premium = 19000,
    limit = 2000
  },
  ["primo2"] = {
    price = 1790000,
    premium = 29900,
    limit = 0
  },
  ["dodge"] = {
    price = 1790000,
    premium = 29900,
    limit = 0
  },
}
boatshopData = {}
helishopData = {}
for model in pairs(carshopData) do
  if tonumber(model) then
    if getVehicleType(model) == "Boat" then
      boatshopData[model] = carshopData[model]
      carshopData[model] = nil
    elseif getVehicleType(model) == "Helicopter" then
      helishopData[model] = carshopData[model]
      carshopData[model] = nil
    end
  end
end
function getCarshopPrice(model)
  if carshopData[model] then
    return carshopData[model].price
  end
  if boatshopData[model] then
    return boatshopData[model].price
  end
  if helishopData[model] then
    return helishopData[model].price
  end
end
function getCarshopPremium(model)
  if carshopData[model] then
    return carshopData[model].premium
  end
  if boatshopData[model] then
    return boatshopData[model].premium
  end
  if helishopData[model] then
    return helishopData[model].premium
  end
end
function getCarshopLimit(model)
  if carshopData[model] then
    return carshopData[model].limit
  end
  if boatshopData[model] then
    return boatshopData[model].limit
  end
  if helishopData[model] then
    return helishopData[model].limit
  end
end
function getCarshopData(model)
  if carshopData[model] then
    return carshopData[model]
  end
  if boatshopData[model] then
    return boatshopData[model]
  end
  if helishopData[model] then
    return helishopData[model]
  end
end
