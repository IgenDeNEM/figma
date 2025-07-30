local sightxports = {sVehiclenames = false, sAnimals = false}
local function sightlangProcessExports()
  for k in pairs(sightxports) do
    local res = getResourceFromName(k)
    if res and getResourceState(res) == "running" then
      sightxports[k] = exports[k]
    else
      sightxports[k] = false
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
    local res0 = getResourceFromName("sAnimals")
    local res1 = getResourceFromName("sVehiclenames")
    if res0 and res1 and getResourceState(res0) == "running" and getResourceState(res1) == "running" then
      waitForDepsForCats()
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
adPricePerHour = 50
minimumAdTime = 12
maximumAdTime = 72
highlightTime = 24
adHighlightPrice = 300
adCategories = {
  {
    "user",
    "solid",
    "Saját hirdetések",
    "own"
  },
  {
    "car-side",
    "solid",
    "Autó",
    false
  },
  {
    "motorcycle",
    "solid",
    "Motor",
    false
  },
  {
    "helicopter",
    "solid",
    "Egyéb jármű",
    false
  },
  {
    "home",
    "solid",
    "Ingatlan",
    false
  },
  {
    "boxes",
    "solid",
    "Tárgy",
    "items",
    false
  },
  {
    "users",
    "solid",
    "Szolgáltatás",
    false
  },
  {
    "paw",
    "solid",
    "Háziállat",
    false
  },
  {
    "list",
    "solid",
    "Egyéb",
    false
  }
}
adCategories[1][5] = {}
for i = 2, #adCategories do
  table.insert(adCategories[1][5], adCategories[i][3])
end
adCategories[4][5] = {
  "Légijármű",
  "Vízijármű",
  "Egyéb"
}
adCategories[5][5] = {
  "Los Santos",
  "San Fierro",
  "Bayside",
  "Blueberry",
  "Dillimore",
  "Montgomery",
  "Palomino Creek",
  "Angel Pine",
  "El Quebrados",
  "Las Barrancas",
  "Tierra Robada",
  "Flint County",
  "Red County"
}
adCategories[6][5] = {
  "Tárgyak",
  "Event tárgyak",
  "Prémium tárgyak"
}
adCategories[7][5] = {
  "Munkást keresek",
  "Munkát vállalok",
  "Egyéb"
}
adCategories[9][5] = {"Egyéb"}
function waitForDepsForCats()
  adCategories[2][5] = {"Egyéb", "Vontató"}
  local list = sightxports.sVehiclenames:getVehicleManufacturerList()
  for i = 1, #list do
    table.insert(adCategories[2][5], list[i])
  end
  adCategories[3][5] = {"Egyéb", "Quad"}
  local list = sightxports.sVehiclenames:getMotorcycleNames()
  for i = 1, #list do
    table.insert(adCategories[3][5], list[i])
  end
  adCategories[8][5] = {}
  local list = sightxports.sAnimals:getAvailablePets()
  for k in pairs(list) do
    if k ~= "Kecske" and k ~= "Diszno" then
      table.insert(adCategories[8][5], k)
    end
  end
  if doneLoadingAdCats then
    doneLoadingAdCats()
  end
end
