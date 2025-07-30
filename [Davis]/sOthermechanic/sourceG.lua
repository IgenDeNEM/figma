local sightexports = {sCarshop = false}
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
bikePositions = {
  {
    -2723.0625,
    217.025390625,
    4.484375
  },
  {
    1025.1015625,
    -1023.6884765625,
    32.1015625
  }
}
heliPositions = {
  {
    -2227.55859375,
    2326.8330078125,
    7.546875
  },
  {
    1765.7763671875,
    -2286.2509765625,
    26.796022415161
  }
}
boatPositions = {
  {
    -333.5126953125,
    -473.4560546875,
    1.5
  },
  {
    727.803515625,
    -1509.7265625,
    1.5
  }
}
bikeOptions = {
  {
    part = "repair",
    name = "Javítás",
    price = 0.05,
    time = 1
  },
  {
    part = "engineCondition",
    name = "Motorgenerál",
    price = 0.0625,
    time = 1
  },
  {
    part = "timing",
    name = "Vezérlés",
    price = 0.0375,
    time = 0.75
  },
  {
    part = "tires",
    name = "Gumik",
    price = 0.01,
    time = 0.25
  },
  {
    part = "brake",
    name = "Fékek",
    price = 0.0175,
    time = 0.375
  },
  {
    part = "oil",
    name = "Olajcsere",
    price = 0.0125,
    time = 0.125
  },
  {
    part = "exam",
    name = "Műszaki vizsga",
    price = 1000,
    time = 0.1
  }
}
heliFixPrice = 0.05
overridePrices = {}
function getBasePrice(veh)
  local model = false
  if tonumber(veh) then
    model = veh
  else
    model = getElementModel(veh)
  end
  if model then
    return sightexports.sCarshop:getCarshopPrice(model) or overridePrices[model] or 1000000
  else
    return 1000000
  end
end
function getItemPrice(veh, price)
  if 1 < price then
    return price
  else
    local base = getBasePrice(veh)
    return math.floor(base * price + 0.5)
  end
end
