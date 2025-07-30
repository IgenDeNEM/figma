local sightexports = {sGui = false}
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
function processDimension(el, dim)
  if 0 < dim then
    setElementInterior(el, 1)
    setElementDimension(el, dim)
  else
    setElementInterior(el, 2)
    setElementDimension(el, 65535 - math.abs(dim))
  end
end
baseX, baseY, baseZ = 621.785, -11, 999.92
textureNum = {}
textureNum.floor = 28
textureNum.ceiling = 21
textureNum.wall = 28
textureNum.toolbox = 14
textureNum.door = 21
floorAlpha = {
  245,
  250,
  250,
  250,
  250,
  255,
  250,
  250,
  250,
  230,
  245,
  235,
  230,
  230,
  230,
  240,
  220,
  200,
  245,
  240,
  240,
  220,
  200,
  230,
  230,
  230,
  230,
  235
}
garagePrices = {
  floor = {
    {"cash", 100000},
    {"cash", 100000},
    {"cash", 100000},
    {"cash", 100000},
    {"cash", 100000},
    {"cash", 100000},
    {"cash", 100000},
    {"cash", 100000},
    {"cash", 100000},
    {"cash", 100000},
    {"cash", 100000},
    {"cash", 100000},
    {"cash", 100000},
    {"cash", 100000},
    {"cash", 100000},
    {"cash", 100000},
    {"pp", 250},
    {"pp", 250},
    {"pp", 250},
    {"pp", 250},
    {"pp", 250},
    {"pp", 250},
    {"pp", 250},
    {"pp", 250},
    {"pp", 250},
    {"pp", 250},
    {"pp", 250},
    {"pp", 250}
  },
  ceiling = {
    {"cash", 50000},
    {"cash", 50000},
    {"cash", 50000},
    {"cash", 50000},
    {"cash", 50000},
    {"cash", 50000},
    {"cash", 50000},
    {"cash", 50000},
    {"cash", 50000},
    {"cash", 50000},
    {"cash", 50000},
    {"cash", 50000},
    {"cash", 50000},
    {"cash", 50000},
    {"cash", 50000},
    {"cash", 50000},
    {"cash", 50000},
    {"cash", 50000},
    {"cash", 50000},
    {"cash", 50000},
    {"cash", 50000}
  },
  door = {
    {"cash", 40000},
    {"cash", 40000},
    {"cash", 40000},
    {"cash", 40000},
    {"cash", 40000},
    {"cash", 40000},
    {"cash", 40000},
    {"cash", 40000},
    {"cash", 40000},
    {"cash", 40000},
    {"cash", 40000},
    {"cash", 40000},
    {"cash", 40000},
    {"cash", 40000},
    {"pp", 200},
    {"pp", 200},
    {"pp", 200},
    {"pp", 200},
    {"pp", 200},
    {"pp", 200},
    {"pp", 200}
  },
  wall = {
    {"cash", 200000},
    {"cash", 200000},
    {"cash", 200000},
    {"cash", 200000},
    {"cash", 200000},
    {"cash", 200000},
    {"cash", 200000},
    {"cash", 200000},
    {"cash", 200000},
    {"cash", 200000},
    {"cash", 200000},
    {"cash", 200000},
    {"cash", 200000},
    {"cash", 200000},
    {"cash", 200000},
    {"cash", 200000},
    {"cash", 200000},
    {"cash", 200000},
    {"pp", 300},
    {"pp", 300},
    {"pp", 300},
    {"pp", 300},
    {"pp", 300},
    {"pp", 300},
    {"pp", 300},
    {"pp", 300},
    {"pp", 300},
    {"pp", 300}
  },
  toolbox = {
    {"cash", 100000},
    {"pp", 300},
    {"pp", 300},
    {"cash", 100000},
    {"cash", 100000},
    {"cash", 100000},
    {"cash", 100000},
    {"pp", 300},
    {"pp", 300},
    {"pp", 300},
    {"pp", 300},
    {"pp", 300},
    {"cash", 100000},
    {"cash", 100000}
  },
  furnishing = {
    false,
    {"pp", 2000}
  },
  sizeX = {
    false,
    {"cash", 50000},
    {"cash", 100000},
    {"cash", 200000},
    {"pp", 250},
    {"pp", 500}
  },
  sizeY = {
    false,
    {"cash", 100000},
    {"pp", 500}
  },
  lift1 = {
    {"pp", 3000},
    {"pp", 6000}
  },
  lift2 = {
    {"pp", 3000},
    {"pp", 6000}
  },
  lift3 = {
    {"pp", 3000},
    {"pp", 6000}
  },
  lift4 = {
    {"pp", 3000},
    {"pp", 6000}
  },
  lift5 = {
    {"pp", 3000},
    {"pp", 6000}
  },
  kruton = {
    {"pp", 4000}
  },
  plugsight = {
    {"pp", 3900}
  },
  workbench = {
    {"pp", 4000}
  }
}
liftMaxHeight = 2.5
wallSizesX = {
  -6,
  -2.58,
  2,
  6,
  12,
  20
}
wallSizesY = {
  6,
  11,
  15
}
liftLayout = {
  {
    -9.3071,
    -3.7527,
    90,
    3,
    1
  },
  {
    -9.3071,
    13.1871,
    90,
    6,
    1
  },
  {
    9.22477,
    -13,
    270,
    1,
    3
  },
  {
    9.22477,
    0.5,
    270,
    4,
    3
  },
  {
    9.22477,
    13.1871,
    270,
    6,
    3
  }
}
function getItemPrice(item, value)
  if garagePrices[item] and garagePrices[item][value] then
    return garagePrices[item][value]
  end
end
function formatPrice(item, value)
  local price = getItemPrice(item, value)
  if price then
    if price[1] == "cash" then
      return "[color=sightgreen]" .. sightexports.sGui:thousandsStepper(price[2]) .. " $"
    elseif price[1] == "pp" then
      return "[color=sightblue]" .. sightexports.sGui:thousandsStepper(price[2]) .. " PP"
    end
  else
    return "[color=sightgreen]Ingyenes"
  end
end
function getItemName(item, value)
  if item == "sizeX" and value then
    return "Szélesség növelése (" .. value .. ")"
  elseif item == "sizeY" and value then
    return "Hosszúság növelése (" .. value .. ")"
  elseif item == "ceiling" and value then
    return "Plafon (" .. value .. ")"
  elseif item == "floor" and value then
    return "Padló (" .. value .. ")"
  elseif item == "wall" and value then
    return "Falak (" .. value .. ")"
  elseif item == "door" and value then
    return "Garázsajtó (" .. value .. ")"
  elseif item == "toolbox" and value then
    return "Szekrények (" .. value .. ")"
  elseif item == "furnishing" then
    if value == 1 then
      return "Berendezés (Normál)"
    elseif value == 2 then
      return "Berendezés (Modern)"
    end
  elseif item == "lift1" then
    if value == 1 then
      return "Emelő 1 (Csápos)"
    elseif value == 2 then
      return "Emelő 1 (Modern)"
    elseif value == 0 then
      return "Emelő 1"
    end
  elseif item == "lift2" then
    if value == 1 then
      return "Emelő 2 (Csápos)"
    elseif value == 2 then
      return "Emelő 2 (Modern)"
    elseif value == 0 then
      return "Emelő 2"
    end
  elseif item == "lift3" then
    if value == 1 then
      return "Emelő 3 (Csápos)"
    elseif value == 2 then
      return "Emelő 3 (Modern)"
    elseif value == 0 then
      return "Emelő 3"
    end
  elseif item == "lift4" then
    if value == 1 then
      return "Emelő 4 (Csápos)"
    elseif value == 2 then
      return "Emelő 4 (Modern)"
    elseif value == 0 then
      return "Emelő 4"
    end
  elseif item == "kruton" then
    if value == 1 then
      return "Kruton diagnosztikai eszköz"
    end
  elseif item == "plugsight" then
    if value == 1 then
      return "PlugSight falitöltő"
    end
  elseif item == "workbench" then
    if value == 1 then
      return "Barkácsasztal"
    end
  elseif item == "lift5" then
    if value == 1 then
      return "Emelő 5 (Csápos)"
    elseif value == 2 then
      return "Emelő 5 (Modern)"
    elseif value == 0 then
      return "Emelő 5"
    end
  end
  return false
end
