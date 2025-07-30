local sightexports = {
  sMarkers = false,
  sGui = false,
  sWorkaround = false,
  sGroups = false,
  sPermission = false,
  sGarages = false,
  sControls = false
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
local lobbyObj = false
local lobbyObj2 = false
local lobbyExitMarker = false
markers = {}
local insideMarkers = {}
local garageDoorMarker = false
local garageDoorMarkerId = false
function setLobbyMarkers(dim, shop)
  if shop then
      for marker, i in pairs(insideMarkers) do
          local x, y, z, rz = unpack(aisleDoors[i])
          x = x + lobbyX
          y = y + lobbyY
          z = z + lobbyZ + 1
          local rad = math.rad(rz) - math.pi / 2
          x = x + math.cos(rad) * 1.254387 - math.sin(rad) * 4.62655
          y = y + math.sin(rad) * 1.254387 + math.cos(rad) * 4.62655
          sightexports.sMarkers:setCustomMarkerPosition(marker, x, y, z, targetIntLobby, dim)
          sightexports.sMarkers:setCustomMarkerInterior(marker, "paintshopEnter", i, 1)
      end
  else
      for marker, i in pairs(insideMarkers) do
          local x, y, z, rz = unpack(aisleDoors[i])
          x = x + lobbyX
          y = y + lobbyY
          z = z + lobbyZ + 1
          local rad = math.rad(rz) - math.pi / 2
          x = x + math.cos(rad) * 6.66072
          y = y + math.sin(rad) * 6.66072
          sightexports.sMarkers:setCustomMarkerPosition(marker, x, y, z, targetIntLobby, 65535 - dim)
          sightexports.sMarkers:setCustomMarkerInterior(marker, "paintshopEnter", i, 3)
      end
  end
end
local garagesExitMarker = false
function createLobbyMarkers()
  local x, y, z = lobbyX, lobbyY, lobbyZ
  local rz = lobbyInsideDoor[4]
  x = x + lobbyInsideDoor[1]
  y = y + lobbyInsideDoor[2]
  z = z + lobbyInsideDoor[3]
  local r = math.rad(rz) + math.pi / 2
  x = x + 6.66073 * math.cos(r)
  y = y + 6.66073 * math.sin(r)
  z = z + 1
  lobbyExitMarker = sightexports.sMarkers:createCustomMarker(x, y, z, targetIntLobby, 0, "sightorange", "garage")
  sightexports.sMarkers:setCustomMarkerInterior(lobbyExitMarker, "lobbyExit", false, 3)
  table.insert(markers, lobbyExitMarker)
  garagesExitMarker =
      sightexports.sMarkers:createCustomMarker(621.785, -26, 1000.9199829102, 1, 0, "sightblue", "garage")
  sightexports.sMarkers:setCustomMarkerInterior(garagesExitMarker, "garageExit", false, 3)
  table.insert(markers, garagesExitMarker)
  insideMarkers = {}
  for i = 1, #aisleDoors do
      local x, y, z, rz = unpack(aisleDoors[i])
      x = x + lobbyX
      y = y + lobbyY
      z = z + lobbyZ + 1
      local rad = math.rad(rz) - math.pi / 2
      x = x + math.cos(rad) * 1.254387 - math.sin(rad) * 4.62655
      y = y + math.sin(rad) * 1.254387 + math.cos(rad) * 4.62655
      local marker = sightexports.sMarkers:createCustomMarker(x, y, z, targetIntLobby, 0, "sightorange", "garage")
      insideMarkers[marker] = i
      table.insert(markers, marker)
  end
end
function setLobbyDimension(dim, shop)
  setElementDimension(lobbyObj, shop and dim or 65535 - dim)
  setElementDimension(lobbyObj2, shop and dim or 65535 - dim)
  sightexports.sMarkers:setCustomMarkerDimension(lobbyExitMarker, shop and dim or 65535 - dim)
  setLobbyMarkers(dim, shop)
end

function modelsLoadedLobby()
  for i = 1, #garageDoors do
      local x, y, z = garageDoors[i][1], garageDoors[i][2], garageDoors[i][3]
      local el = sightexports.sMarkers:createCustomMarker(x, y, z + 1, 0, 0, "sightorange", "garage")
      sightexports.sMarkers:setCustomMarkerInterior(el, "lobbyEnter", i, 3)
      sightexports.sMarkers:setCustomMarkerText(
          el,
          {
              garageDoors[i][7],
              garageDoors[i][5] .. " csarnok " .. garageDoors[i][6] .. ". ajtó"
          }
      )
      table.insert(markers, el)
  end
  createLobbyMarkers()
  lobbyObj = createObject(models.spray_hall, lobbyX, lobbyY, lobbyZ)
  lobbyObj2 = createObject(models.spray_hall_props, lobbyX, lobbyY, lobbyZ)
  setElementInterior(lobbyObj, targetIntLobby)
  setElementInterior(lobbyObj2, targetIntLobby)
  setLobbyDimension(1, true)
end

addEventHandler(
  "onClientResourceStop",
  getResourceRootElement(),
  function()
      sightexports.sMarkers:deleteCustomMarker(workshopMarker)
      for i, v in pairs(markers) do
          sightexports.sMarkers:deleteCustomMarker(v)
      end
  end
)
local loadedGaragesLobby = false
local loadedPaintshopLobby = false
local lobbyRenderHandled = false
local stencilTexture = false
local starsTexture = false
local paintshopCerts = {}
local garagesRented = {}
local paintshopRented = {}
local stencilChars = {
  A = 0,
  B = 1,
  C = 2,
  D = 3,
  E = 4,
  F = 5,
  G = 6,
  H = 7,
  I = 8,
  J = 9,
  K = 10,
  L = 11,
  M = 12,
  N = 13,
  O = 14,
  P = 15,
  Q = 16,
  R = 17,
  S = 18,
  T = 19,
  U = 20,
  V = 21,
  W = 22,
  X = 23,
  Y = 24,
  Z = 25,
  ["-"] = 26,
  ["0"] = 27,
  ["1"] = 28,
  ["2"] = 29,
  ["3"] = 30,
  ["4"] = 31,
  ["5"] = 32,
  ["6"] = 33,
  ["7"] = 34,
  ["8"] = 35,
  ["9"] = 36
}
local stencilLetters = false
local charsetLetters = false
local charset = {
  "A",
  "B",
  "C",
  "D",
  "E",
  "F",
  "G",
  "H",
  "I",
  "J",
  "K",
  "L",
  "M",
  "N",
  "O",
  "P",
  "Q",
  "R",
  "S",
  "T",
  "U",
  "V",
  "W",
  "X",
  "Y",
  "Z",
  "a",
  "b",
  "c",
  "d",
  "e",
  "f",
  "g",
  "h",
  "i",
  "j",
  "k",
  "l",
  "m",
  "n",
  "o",
  "p",
  "q",
  "r",
  "s",
  "t",
  "u",
  "v",
  "w",
  "x",
  "y",
  "z",
  "0",
  "1",
  "2",
  "3",
  "4",
  "5",
  "6",
  "7",
  "8",
  "9",
  "Á",
  "É",
  "Í",
  "Ó",
  "Ö",
  "Ő",
  "Ú",
  "Ü",
  "Ű",
  "á",
  "é",
  "í",
  "ó",
  "ö",
  "ő",
  "ú",
  "ü",
  "ű",
  "-",
  ".",
  ",",
  "'",
  '"',
  ";",
  "!",
  "/"
}
local charsetChars = {
  A = {1, 0.34375},
  B = {2, 0.34375},
  C = {3, 0.328125},
  D = {4, 0.34375},
  E = {5, 0.3125},
  F = {6, 0.296875},
  G = {7, 0.34375},
  H = {8, 0.359375},
  I = {9, 0.15625},
  J = {10, 0.21875},
  K = {11, 0.34375},
  L = {12, 0.296875},
  M = {13, 0.453125},
  N = {14, 0.359375},
  O = {15, 0.34375},
  P = {16, 0.328125},
  Q = {17, 0.34375},
  R = {18, 0.34375},
  S = {19, 0.3125},
  T = {20, 0.3125},
  U = {21, 0.34375},
  V = {22, 0.328125},
  W = {23, 0.484375},
  X = {24, 0.34375},
  Y = {25, 0.328125},
  Z = {26, 0.3125},
  a = {27, 0.3125},
  b = {28, 0.328125},
  c = {29, 0.3125},
  d = {30, 0.328125},
  e = {31, 0.3125},
  f = {32, 0.21875},
  g = {33, 0.328125},
  h = {34, 0.328125},
  i = {35, 0.140625},
  j = {36, 0.140625},
  k = {37, 0.328125},
  l = {38, 0.140625},
  m = {39, 0.5},
  n = {40, 0.328125},
  o = {41, 0.3125},
  p = {42, 0.328125},
  q = {43, 0.328125},
  r = {44, 0.234375},
  s = {45, 0.296875},
  t = {46, 0.234375},
  u = {47, 0.328125},
  v = {48, 0.3125},
  w = {49, 0.453125},
  x = {50, 0.3125},
  y = {51, 0.3125},
  z = {52, 0.28125},
  ["0"] = {53, 0.34375},
  ["1"] = {54, 0.234375},
  ["2"] = {55, 0.3125},
  ["3"] = {56, 0.328125},
  ["4"] = {57, 0.34375},
  ["5"] = {58, 0.328125},
  ["6"] = {59, 0.34375},
  ["7"] = {60, 0.3125},
  ["8"] = {61, 0.34375},
  ["9"] = {62, 0.34375},
  ["Á"] = {63, 0.34375},
  ["É"] = {64, 0.3125},
  ["Í"] = {65, 0.15625},
  ["Ó"] = {66, 0.34375},
  ["Ö"] = {67, 0.34375},
  ["Ő"] = {68, 0.34375},
  ["Ú"] = {69, 0.34375},
  ["Ü"] = {70, 0.34375},
  ["Ű"] = {71, 0.34375},
  ["á"] = {72, 0.3125},
  ["é"] = {73, 0.3125},
  ["í"] = {74, 0.140625},
  ["ó"] = {75, 0.3125},
  ["ö"] = {76, 0.3125},
  ["ő"] = {77, 0.3125},
  ["?"] = {78, 0.328125},
  ["ü"] = {79, 0.328125},
  ["ű"] = {80, 0.328125},
  ["-"] = {81, 0.234375},
  ["."] = {82, 0.15625},
  [","] = {83, 0.15625},
  ["'"] = {84, 0.140625},
  ['"'] = {85, 0.25},
  [";"] = {86, 0.15625},
  ["!"] = {87, 0.171875},
  ["/"] = {88, 0.328125}
}
local charsetTexture = false
function loadCharsetFile()
  local file = fileOpen("files/charset.sight")
  if file then
      local data = fileRead(file, fileGetSize(file))
      if sha256(data) == "C1BD5A355AF1DF2F1067F5606F2511F7295027993954E4E1951D0BEAD774F143" then
          if isElement(charsetTexture) then
              destroyElement(charsetTexture)
          end
          charsetTexture = dxCreateTexture(data)
      end
      data = nil
      collectgarbage("collect")
      fileClose(file)
  end
end
function processStencilLetters(lobby, i)
  if aisleDoors[i] and stencilLetters and stencilLetters[i] then
      stencilLetters[i] = {}
      local x, y, z, rz = unpack(aisleDoors[i])
      x = x + lobbyX
      y = y + lobbyY
      z = z + lobbyZ
      local rad = math.rad(rz) - math.pi / 2
      local cos = math.cos(rad)
      local sin = math.sin(rad)
      local s = 0.75
      local bx = x + cos * 0.025
      local by = y + sin * 0.025
      local bz = z + 1.6
      x = bx + sin * s * 4 * 0.5
      y = by - cos * s * 4 * 0.5
      z = bz
      local text = {}
      local door, aisle = getDoorFromAisle(lobby)
      table.insert(text, garageDoors[door][5])
      local str = tostring(garageDoors[door][6])
      if utf8.len(str) == 1 then
          table.insert(text, "0")
          table.insert(text, str)
      else
          table.insert(text, utf8.sub(str, 1, 1))
          table.insert(text, utf8.sub(str, 2, 2))
      end
      table.insert(text, "-")
      local str = tostring(aisle)
      if utf8.len(str) == 1 then
          table.insert(text, "0")
          table.insert(text, str)
      else
          table.insert(text, utf8.sub(str, 1, 1))
          table.insert(text, utf8.sub(str, 2, 2))
      end
      table.insert(text, "-")
      local str = tostring(i)
      if utf8.len(str) == 1 then
          table.insert(text, "0")
          table.insert(text, str)
      else
          table.insert(text, utf8.sub(str, 1, 1))
          table.insert(text, utf8.sub(str, 2, 2))
      end
      for j = 1, 9 do
          local c = stencilChars[text[j]]
          if c then
              local vx, vy, vz = x + cos, y + sin, z
              table.insert(
                  stencilLetters[i],
                  {
                      x,
                      y,
                      z,
                      s,
                      vx,
                      vy,
                      vz,
                      c
                  }
              )
          end
          x = x - sin * s * 0.5
          y = y + cos * s * 0.5
      end
      local str = tostring(getAisleWorkshopId(lobby, i))
      local s2 = s * 0.6
      len = utf8.len(str)
      x = bx + sin * s2 * (len - 1) / 2 * 0.5
      y = by - cos * s2 * (len - 1) / 2 * 0.5
      z = bz - s / 2 - s2 / 2
      for j = 1, len do
          local c = stencilChars[utf8.sub(str, j, j)]
          if c then
              local vx, vy, vz = x + cos, y + sin, z
              table.insert(
                  stencilLetters[i],
                  {
                      x,
                      y,
                      z,
                      s2,
                      vx,
                      vy,
                      vz,
                      c
                  }
              )
          end
          x = x - sin * s2 * 0.5
          y = y + cos * s2 * 0.5
      end
      local str = utf8.upper(garageDoors[door][7])
      local s2 = s * 0.6
      len = utf8.len(str)
      x = bx + sin * s2 * (len - 1) / 2 * 0.5
      y = by - cos * s2 * (len - 1) / 2 * 0.5
      z = bz + s / 2 + s2 / 2
      for j = 1, len do
          local c = stencilChars[utf8.sub(str, j, j)]
          if c then
              local vx, vy, vz = x + cos, y + sin, z
              table.insert(
                  stencilLetters[i],
                  {
                      x,
                      y,
                      z,
                      s2,
                      vx,
                      vy,
                      vz,
                      c
                  }
              )
          end
          x = x - sin * s2 * 0.5
          y = y + cos * s2 * 0.5
      end
  end
end
function processCharsetLetters(i, text)
  processCertLetters(i, text)
  if aisleDoors[i] and charsetLetters and charsetLetters[i] then
      charsetLetters[i] = {}
      local x, y, z, rz = unpack(aisleDoors[i])
      x = x + lobbyX
      y = y + lobbyY
      z = z + lobbyZ
      local rad = math.rad(rz)
      local cos = math.cos(rad)
      local sin = math.sin(rad)
      local s = 0.15
      local bx = x
      local by = y
      local bz = z + 1.76661
      bx = bx + cos * 4.63803 + sin * 0.054381
      by = by + sin * 4.63803 - cos * 0.054381
      bx = bx + sin * 0.0175
      by = by - cos * 0.0175
      text = split(text, " ")
      local line = 1
      local lw = 0
      local tmp = {
          {}
      }
      for k = 1, #text do
          local tw = 0
          local len = utf8.len(text[k])
          for j = 1, len do
              local c = utf8.sub(text[k], j, j)
              if c and charsetChars[c] then
                  tw = tw + charsetChars[c][2]
              else
                  tw = tw + 0.25
              end
          end
          if lw + tw > 0.925 / s then
              line = line + 1
              tmp[line] = {}
              lw = tw
          else
              lw = lw + 0.25 + tw
          end
          table.insert(tmp[line], text[k])
      end
      bz = bz + (line - 1) / 2 * s * 0.8
      for k = 1, line do
          local text = table.concat(tmp[k], " ")
          local len = utf8.len(text)
          local tw = 0
          for j = 1, len do
              local c = utf8.sub(text, j, j)
              if c and charsetChars[c] then
                  tw = tw + charsetChars[c][2]
              else
                  tw = tw + 0.25
              end
          end
          x = bx - cos * s * tw / 2
          y = by - sin * s * tw / 2
          z = bz
          for j = 1, len do
              local c = utf8.sub(text, j, j)
              local w = 0.25
              if c and charsetChars[c] then
                  w = charsetChars[c][2]
                  local x = x + cos * s * w / 2
                  local y = y + sin * s * w / 2
                  local vx, vy, vz = x + sin, y - cos, z
                  table.insert(
                      charsetLetters[i],
                      {
                          x,
                          y,
                          z,
                          s,
                          vx,
                          vy,
                          vz,
                          charsetChars[c][1] - 1
                      }
                  )
              end
              x = x + cos * s * w
              y = y + sin * s * w
          end
          bz = bz - s * 0.8
      end
  end
end
function processCertLetters(i, text)
  if paintshopCerts[i] then
      paintshopCerts[i][2] = {}
      local x, y, z, rz = unpack(aisleDoors[i])
      x = x + lobbyX
      y = y + lobbyY
      z = z + lobbyZ
      local rad = math.rad(rz)
      local cos = math.cos(rad)
      local sin = math.sin(rad)
      local bx = x + sin * 0.01
      local by = y - cos * 0.01
      local bz = z + 1.5
      local s = 0.525
      local tw = 0
      local len = utf8.len(text)
      for j = 1, len do
          local c = utf8.sub(text, j, j)
          if c and charsetChars[c] then
              tw = tw + charsetChars[c][2]
          else
              tw = tw + 0.25
          end
      end
      local ts = 0.05025
      bx = bx + cos * 5.93093 + sin * 0.207655
      by = by + sin * 5.93093 - cos * 0.207655
      x = bx - cos * ts * tw / 2
      y = by - sin * ts * tw / 2
      z = bz - s * 0.625 * 0.0425
      for j = 1, len do
          local c = utf8.sub(text, j, j)
          local w = 0.25
          if c and charsetChars[c] then
              w = charsetChars[c][2]
              local x = x + cos * ts * w / 2
              local y = y + sin * ts * w / 2
              local vx, vy, vz = x + sin, y - cos, z
              table.insert(
                  paintshopCerts[i][2],
                  {
                      x,
                      y,
                      z,
                      ts,
                      vx,
                      vy,
                      vz,
                      charsetChars[c][1] - 1
                  }
              )
          end
          x = x + cos * ts * w
          y = y + sin * ts * w
      end
  end
end
function processCert(i, dat)
  if paintshopCerts[i] and isElement(paintshopCerts[i][1]) then
      destroyElement(paintshopCerts[i][1])
  end
  paintshopCerts[i] = false
  if aisleDoors[i] and dat and paintshopRented[i] then
      paintshopCerts[i] = {}
      local x, y, z, rz = unpack(aisleDoors[i])
      x = x + lobbyX
      y = y + lobbyY
      z = z + lobbyZ
      local rad = math.rad(rz)
      local cos = math.cos(rad)
      local sin = math.sin(rad)
      local bx = x + sin * 0.005
      local by = y - cos * 0.005
      local bz = z + 1.5
      local s = 0.525
      bx = bx + cos * 5.93093 + sin * 0.207655
      by = by + sin * 5.93093 - cos * 0.207655
      paintshopCerts[i][1] = createObject(models.spray_certificate, bx, by, bz, 0, 0, rz)
      setObjectScale(paintshopCerts[i][1], s)
      setElementDimension(paintshopCerts[i][1], loadedPaintshopLobby)
      setElementInterior(paintshopCerts[i][1], targetIntLobby)
      setElementCollisionsEnabled(paintshopCerts[i][1], false)
      bz = bz - s * 0.145
      local h = 0.035
      local w = h * 5.5625
      x = bx + sin * 0.005
      y = by - cos * 0.005
      local r = 0
      if 0 < dat[2] then
          r = dat[1] / dat[2] / 5
      end
      paintshopCerts[i][3] = {
          x - cos * (w / 2 - w * r / 2),
          y - sin * (w / 2 - w * r / 2),
          x - cos * (w / 2 - w * r - w * (1 - r) / 2),
          y - sin * (w / 2 - w * r - w * (1 - r) / 2),
          bz,
          cos,
          sin,
          w,
          h,
          r
      }
      paintshopCerts[i][4] = {}
      local ts = 0.045
      bz = bz - h * 1 - ts * 0.5
      local text = "Nincs értékelés"
      if 0 < dat[2] then
          text =
              math.floor(dat[1] / dat[2] * 10) / 10 ..
              " - " .. sightexports.sGui:thousandsStepper(dat[2]) .. " értékelés"
      end
      local tw = 0
      local len = utf8.len(text)
      for j = 1, len do
          local c = utf8.sub(text, j, j)
          if c and charsetChars[c] then
              tw = tw + charsetChars[c][2]
          else
              tw = tw + 0.25
          end
      end
      x = bx - cos * ts * tw / 2 + sin * 0.005
      y = by - sin * ts * tw / 2 - cos * 0.005
      z = bz
      for j = 1, len do
          local c = utf8.sub(text, j, j)
          local w = 0.25
          if c and charsetChars[c] then
              w = charsetChars[c][2]
              local x = x + cos * ts * w / 2
              local y = y + sin * ts * w / 2
              local vx, vy, vz = x + sin, y - cos, z
              table.insert(
                  paintshopCerts[i][4],
                  {
                      x,
                      y,
                      z,
                      ts,
                      vx,
                      vy,
                      vz,
                      charsetChars[c][1] - 1
                  }
              )
          end
          x = x + cos * ts * w
          y = y + sin * ts * w
      end
      local text = paintshopRented[i].workshopName
      processCertLetters(i, text)
  end
end
function startPaintshopLobbyLoading(id, shop)
  setLobbyDimension(id, shop)
  disableControls(true)
  setLobbyLoader(true, false, true)
end
addEvent("startPaintshopLobbyLoading", true)
addEventHandler("startPaintshopLobbyLoading", getRootElement(), startPaintshopLobbyLoading)
local lobbyButtons = {}
local lobbyEnterWindow = false
local standingLobbyEnter = false
local standingLobbyExit = false
local standingPaintshopEnter = false
standingPaintshopExit = false
local standingGarageExit = false
local standingGarageEnter = false
addEvent("loadedGaragesLobby", true)
addEventHandler(
  "loadedGaragesLobby",
  getRootElement(),
  function(id, rented)
      standingGarageExit = false
      loadedGaragesLobby = id
      loadedPaintshopLobby = false
      sightexports.sWorkaround:setDisableDetach(id and true or 600)
      setLobbyLoader(false)
      if id then
          garagesRented = rented
          setLobbyDimension(id, false)
          if not isElement(stencilTexture) then
              stencilTexture = dxCreateTexture("files/stencil.dds")
          end
          if not lobbyRenderHandled then
              addEventHandler("onClientPreRender", getRootElement(), preRenderPaintshopLobby)
              lobbyRenderHandled = true
          end
          stencilLetters = {}
          for marker, id in pairs(insideMarkers) do
              stencilLetters[id] = {}
              if rented[id] then
                  sightexports.sMarkers:setCustomMarkerType(marker, "garage")
                  sightexports.sMarkers:setCustomMarkerColor(marker, "sightblue")
                  sightexports.sMarkers:setCustomMarkerText(
                      marker,
                      {
                          formatGarageNameEx(loadedGaragesLobby, id)
                      }
                  )
                  if rented[id].policeLock then
                      local locker =
                          rented[id].policeLock and rented[id].policeLockBy and rented[id].policeLockGroup and
                          rented[id].policeLockBy .. " (" .. rented[id].policeLockGroup .. ")" or
                          ""
                      sightexports.sMarkers:setCustomMarkerPolice(marker, rented[id].policeLock, locker)
                  else
                      sightexports.sMarkers:setCustomMarkerPolice(marker, false, false)
                  end
              else
                  sightexports.sMarkers:setCustomMarkerType(marker, "garage_rent")
                  sightexports.sMarkers:setCustomMarkerColor(marker, "sightgreen")
                  sightexports.sMarkers:setCustomMarkerText(
                      marker,
                      {
                          formatGarageNameEx(loadedGaragesLobby, id),
                          "Kiadó!"
                      },
                      {"#ffffff", "sightgreen"}
                  )
                  sightexports.sMarkers:setCustomMarkerPolice(marker, false, false)
              end
              processStencilLetters(loadedGaragesLobby, id)
          end
      else
          garagesRented = false
          if isElement(stencilTexture) then
              destroyElement(stencilTexture)
          end
          stencilTexture = false
          if lobbyRenderHandled then
              removeEventHandler("onClientPreRender", getRootElement(), preRenderPaintshopLobby)
              lobbyRenderHandled = false
          end
      end
  end
)
addEvent("loadedPaintshopLobby", true)
addEventHandler(
  "loadedPaintshopLobby",
  getRootElement(),
  function(id, rented, certs)
      loadedGaragesLobby = false
      loadedPaintshopLobby = id
      sightexports.sWorkaround:setDisableDetach(id and true or 600)
      setLobbyLoader(false)
      if id then
          paintshopRented = rented
          for i = 1, #aisleDoors do
              processCert(i, certs[i])
          end
          setLobbyDimension(id, true)
          if not isElement(stencilTexture) then
              stencilTexture = dxCreateTexture("files/stencil.dds")
          end
          if not isElement(starsTexture) then
              starsTexture = dxCreateTexture("files/stars.dds")
          end
          if not isElement(charsetTexture) then
              loadCharsetFile()
          end
          if not lobbyRenderHandled then
              addEventHandler("onClientPreRender", getRootElement(), preRenderPaintshopLobby)
              lobbyRenderHandled = true
          end
          stencilLetters = {}
          charsetLetters = {}
          for marker, id in pairs(insideMarkers) do
              stencilLetters[id] = {}
              charsetLetters[id] = {}
              if rented[id] then
                  sightexports.sMarkers:setCustomMarkerType(marker, "garage_paint")
                  sightexports.sMarkers:setCustomMarkerColor(marker, "sightyellow")
                  processCharsetLetters(id, rented[id].workshopName)
                  sightexports.sMarkers:setCustomMarkerText(
                      marker,
                      {
                          formatShopNameEx(loadedPaintshopLobby, id)
                      }
                  )
              else
                  sightexports.sMarkers:setCustomMarkerType(marker, "garage_paint_rent")
                  sightexports.sMarkers:setCustomMarkerColor(marker, "sightgreen")
                  processCharsetLetters(id, "Kiadó műhely!")
                  sightexports.sMarkers:setCustomMarkerText(
                      marker,
                      {
                          formatShopNameEx(loadedPaintshopLobby, id),
                          "Kiadó!"
                      },
                      {"#ffffff", "sightgreen"}
                  )
              end
              processStencilLetters(loadedPaintshopLobby, id)
          end
      else
          paintshopRented = false
          stencilLetters = false
          charsetLetters = false
          if isElement(stencilTexture) then
              destroyElement(stencilTexture)
          end
          stencilTexture = false
          if isElement(starsTexture) then
              destroyElement(starsTexture)
          end
          starsTexture = false
          if isElement(charsetTexture) then
              destroyElement(charsetTexture)
          end
          charsetTexture = false
          if lobbyRenderHandled then
              removeEventHandler("onClientPreRender", getRootElement(), preRenderPaintshopLobby)
              lobbyRenderHandled = false
          end
      end
  end
)
function drawStencilLetter(x, y, z, s, vx, vy, vz, ind)
  dxDrawMaterialSectionLine3D(
      x,
      y,
      z + s / 2,
      x,
      y,
      z - s / 2,
      ind * 64,
      0,
      64,
      64,
      stencilTexture,
      s,
      tocolor(0, 0, 0, 230),
      vx,
      vy,
      vz
  )
end
function drawCharsetLetter(dat, a)
  local x, y, z, s, vx, vy, vz, ind = unpack(dat)
  dxDrawMaterialSectionLine3D(
      x,
      y,
      z + s / 2,
      x,
      y,
      z - s / 2,
      ind * 32,
      0,
      32,
      32,
      charsetTexture,
      s,
      tocolor(0, 0, 0, a),
      vx,
      vy,
      vz
  )
end
function preRenderPaintshopLobby()
  for i = 1, #aisleDoors do
      if stencilLetters[i] then
          for j = 1, #stencilLetters[i] do
              if stencilLetters[i][j] then
                  drawStencilLetter(unpack(stencilLetters[i][j]))
              end
          end
      end
      if loadedPaintshopLobby then
          if charsetLetters[i] then
              for j = 1, #charsetLetters[i] do
                  if charsetLetters[i][j] then
                      drawCharsetLetter(charsetLetters[i][j], 230)
                  end
              end
          end
          if paintshopCerts[i] then
              local x, y, x2, y2, z, c, s, w, h, r = unpack(paintshopCerts[i][3])
              dxDrawMaterialSectionLine3D(
                  x,
                  y,
                  z + h / 2,
                  x,
                  y,
                  z - h / 2,
                  0,
                  16,
                  89 * r,
                  16,
                  false,
                  starsTexture,
                  w * r,
                  tocolor(255, 255, 255, 245),
                  x + s,
                  y - c,
                  z
              )
              dxDrawMaterialSectionLine3D(
                  x2,
                  y2,
                  z + h / 2,
                  x2,
                  y2,
                  z - h / 2,
                  89 * r,
                  0,
                  89 * (1 - r),
                  16,
                  false,
                  starsTexture,
                  w * (1 - r),
                  tocolor(255, 255, 255, 245),
                  x2 + s,
                  y2 - c,
                  z
              )
              local let = paintshopCerts[i][2]
              for j = 1, #let do
                  if let[j] then
                      drawCharsetLetter(let[j], 245)
                  end
              end
              local let2 = paintshopCerts[i][4]
              for j = 1, #let2 do
                  if let2[j] then
                      drawCharsetLetter(let2[j], 245)
                  end
              end
          end
      end
  end
end
function lobbyEnterMarkerHit(id)
  standingLobbyEnter = id
  createIntiBox(
      "garage",
      garageDoors[standingLobbyEnter][7],
      garageDoors[standingLobbyEnter][5] .. " csarnok " .. garageDoors[standingLobbyEnter][6] .. ". ajtó",
      "sightorange"
  )
  if id == garageDoorMarkerId then
      if isElement(garageDoorMarker) then
          destroyElement(garageDoorMarker)
      end
      garageDoorMarker = nil
      garageDoorMarkerId = false
  end
end
function lobbyExitMarkerHit()
  standingLobbyExit = true
  local id = loadedPaintshopLobby or loadedGaragesLobby
  if id then
      local door, aisle = getDoorFromAisle(id)
      if garageDoors[door] then
          createIntiBox(
              "garage",
              garageDoors[door][7],
              garageDoors[door][5] .. " csarnok " .. garageDoors[door][6] .. ". ajtó",
              "sightorange"
          )
      end
  end
end
function paintshopEnterMarkerHit(id)
  if loadedPaintshopLobby then
      standingPaintshopEnter = id
      local rented = paintshopRented[standingPaintshopEnter]
      local id = getAisleWorkshopId(loadedPaintshopLobby, standingPaintshopEnter)
      if paintshopRented[standingPaintshopEnter] then
          local cid = getElementData(localPlayer, "char.ID")
          createIntiBox(
              "garage_paint",
              "Műhely #" .. id,
              paintshopRented[standingPaintshopEnter].workshopName,
              "sightyellow",
              false,
              true,
              paintshopRented[standingPaintshopEnter].rentedBy == cid
          )
          if paintshopRented[standingPaintshopEnter].rentedBy == cid then
              local delta = paintshopRented[standingPaintshopEnter].rentUntil - getRealTimestamp()
              if delta < 86400 then
                  sightexports.sGui:showInfobox("w", "A műhely bérlete hamarosan lejár!")
                  outputChatBox(
                      "[color=sightorange][SightMTA - Fényezőműhely]: #ffffffA műhely bérlete hamarosan lejár!",
                      255,
                      255,
                      255,
                      true
                  )
                  if paintshopRented[standingPaintshopEnter].rentMode == "pp" then
                      outputChatBox(
                          " #ffffff - Heti bérleti díj: [color=sightblue]" ..
                              sightexports.sGui:thousandsStepper(1500) .. " PP",
                          255,
                          255,
                          255,
                          true
                      )
                      outputChatBox(
                          " #ffffff - Meghosszabbításhoz használd az [color=sightblue]'E'#ffffff gombot.",
                          255,
                          255,
                          255,
                          true
                      )
                  else
                      outputChatBox(
                          " #ffffff - Heti bérleti díj: [color=sightgreen]" ..
                              sightexports.sGui:thousandsStepper(15000) .. " $#ffffff",
                          255,
                          255,
                          255,
                          true
                      )
                      outputChatBox(
                          " #ffffff - Meghosszabbításhoz használd az [color=sightblue]'E'#ffffff gombot.",
                          255,
                          255,
                          255,
                          true
                      )
                  end
              end
          end
      else
          createIntiBox("garage_paint_rent", "Műhely #" .. id, "Kiadó!", "sightgreen", true)
          outputChatBox("[color=sightorange][SightMTA - Fényezőműhely]: #ffffffEz a műhely kiadó!", 255, 255, 255, true)
          outputChatBox(
              " #ffffff - Heti bérleti díj: [color=sightgreen]" ..
                  sightexports.sGui:thousandsStepper(15000) ..
                      " $#ffffff vagy [color=sightblue]" .. sightexports.sGui:thousandsStepper(1500) .. " PP",
              255,
              255,
              255,
              true
          )
          outputChatBox(
              " #ffffff - Kaució: [color=sightgreen]" ..
                  sightexports.sGui:thousandsStepper(60000) ..
                      " $#ffffff vagy [color=sightblue]0 PP, mely lemondás során visszajár.",
              255,
              255,
              255,
              true
          )
          outputChatBox(" #ffffff - Bérléshez használd az [color=sightblue]'E'#ffffff gombot.", 255, 255, 255, true)
      end
  elseif loadedGaragesLobby then
      standingGarageEnter = id
      local id = getAisleWorkshopId(loadedGaragesLobby, standingGarageEnter)
      if garagesRented[standingGarageEnter] then
          local cid = getElementData(localPlayer, "char.ID")
          createIntiBox(
              "garage",
              "Garázs #" .. id,
              formatGarageName(id),
              "sightblue",
              false,
              true,
              garagesRented[standingGarageEnter].rentedBy == cid
          )
          if garagesRented[standingGarageEnter].rentedBy == cid then
              local delta = garagesRented[standingGarageEnter].rentUntil - getRealTimestamp()
              if delta < 86400 then
                  sightexports.sGui:showInfobox("w", "A garázs bérlete hamarosan lejár!")
                  outputChatBox(
                      "[color=sightorange][SightMTA - Garázs]: #ffffffA garázs bérlete hamarosan lejár!",
                      255,
                      255,
                      255,
                      true
                  )
                  if garagesRented[standingGarageEnter].rentMode == "pp" then
                      outputChatBox(
                          " #ffffff - Kétheti bérleti díj: [color=sightblue]" ..
                              sightexports.sGui:thousandsStepper(500) .. " PP",
                          255,
                          255,
                          255,
                          true
                      )
                      outputChatBox(
                          " #ffffff - Meghosszabbításhoz használd az [color=sightblue]'E'#ffffff gombot.",
                          255,
                          255,
                          255,
                          true
                      )
                  else
                      outputChatBox(
                          " #ffffff - Kétheti bérleti díj: [color=sightgreen]" ..
                              sightexports.sGui:thousandsStepper(20000) .. " $#ffffff",
                          255,
                          255,
                          255,
                          true
                      )
                      outputChatBox(
                          " #ffffff - Meghosszabbításhoz használd az [color=sightblue]'E'#ffffff gombot.",
                          255,
                          255,
                          255,
                          true
                      )
                  end
              end
          end
      else
          createIntiBox("garage_rent", "Garázs #" .. id, "Kiadó!", "sightgreen", true)
          outputChatBox("[color=sightorange][SightMTA - Garázs]: #ffffffEz a garázs kiadó!", 255, 255, 255, true)
          outputChatBox(
              " #ffffff - Kétheti bérleti díj: [color=sightgreen]" ..
                  sightexports.sGui:thousandsStepper(20000) ..
                      " $#ffffff vagy [color=sightblue]" .. sightexports.sGui:thousandsStepper(500) .. " PP",
              255,
              255,
              255,
              true
          )
          outputChatBox(
              " #ffffff - Kaució: [color=sightgreen]" ..
                  sightexports.sGui:thousandsStepper(40000) ..
                      " $#ffffff vagy [color=sightblue]0 PP, mely lemondás során visszajár.",
              255,
              255,
              255,
              true
          )
          outputChatBox(" #ffffff - Bérléshez használd az [color=sightblue]'E'#ffffff gombot.", 255, 255, 255, true)
      end
  end
end
function getStandingInMarker()
  return standingPaintshopEnter or standingGarageEnter or standingPaintshopExit or standingGarageExit
end
function policeLockGarage(cmd, ...)
  local currentGarage = standingGarageEnter
  local id = currentGarage and getAisleWorkshopId(loadedGaragesLobby, standingGarageEnter) or false
  if
      currentGarage and id and
          (sightexports.sGroups:getPlayerPermission("interiorLock") or
              sightexports.sPermission:hasPermission(localPlayer, "forceUnlockInterior"))
   then
      if not garagesRented[currentGarage] then
          sightexports.sGui:showInfobox("e", "Ez a garázs nincs kiadva!")
          return
      end
      if garagesRented[currentGarage].policeLock then
          triggerServerEvent("unlockPoliceCustomGarage", localPlayer, id)
      else
          local reason =
              table.concat(
              {
                  ...
              },
              " "
          )
          if reason and utf8.len(reason) > 0 then
              if utf8.len(reason) <= 24 then
                  triggerServerEvent("lockPoliceCustomGarage", localPlayer, id, reason)
              else
                  sightexports.sGui:showInfobox("e", "Az indok maximum 24 karakter lehet!")
              end
          else
              outputChatBox(
                  "[color=sightblue][SightMTA - Használat]: #ffffff/" .. cmd .. " [Indok]",
                  255,
                  255,
                  255,
                  true
              )
          end
      end
  end
end
addCommandHandler("policelock", policeLockGarage)
addCommandHandler("navlock", policeLockGarage)
addCommandHandler("nnilock", policeLockGarage)
addCommandHandler("okflock", policeLockGarage)
function tryToBreakInRentable(itemDbId)
  local currentGarage = standingGarageEnter and getAisleWorkshopId(loadedGaragesLobby, standingGarageEnter) or false
  local currentPaintshop =
      standingPaintshopEnter and getAisleWorkshopId(loadedPaintshopLobby, standingPaintshopEnter) or false
  local currentRentable = currentGarage or currentPaintshop
  if currentRentable then
      triggerServerEvent("tryToBreakInRentable", localPlayer, currentGarage, currentPaintshop, itemDbId)
  end
end
local oldMarkId = false
function markGarageDoor(id)
  if isElement(garageDoorMarker) then
      destroyElement(garageDoorMarker)
  end
  garageDoorMarker = nil
  local door = getAisleFromWorkshop(id)
  if oldMarkId == id then
      oldMarkId = false
      return
  end
  oldMarkId = id
  garageDoorMarkerId = door
  local x, y, z = garageDoors[door][1], garageDoors[door][2], garageDoors[door][3]
  if x and y and z then
      local col = sightexports.sGui:getColorCode("sightpurple")
      garageDoorMarker = createBlip(x, y, z + 1, 24, 2, col[1], col[2], col[3])
      sightexports.sGui:showInfobox("s", "Sikeresen megjelölted a kiválasztott helyet a térképen!")
  end
end
function loadedGarageData(id)
  setLobbyLoader(false)
  if standingGarageExit and id and id < 0 then
      id = math.abs(id)
      createIntiBox("garage", "Garázs #" .. id, formatGarageName(id), "sightblue")
  end
end
function garageExitMarkerHit()
  standingGarageExit = true
  standingGarageEnter = false
  local id = sightexports.sGarages:getCurrentGarage()
  if id and id < 0 then
      id = math.abs(id)
      createIntiBox("garage", "Garázs #" .. id, formatGarageName(id), "sightblue")
  end
end
function paintshopExitMarkerHit()
  standingPaintshopExit = true
  standingPaintshopEnter = false
  if currentWorkshop and workshopRented then
      createIntiBox("garage_paint", "Műhely #" .. currentWorkshop, (workshopRented.workshopName or "Ismeretlen"), "sightyellow")
  end
end
function paintshopMarkerLeave()
  if
      standingLobbyEnter or standingLobbyExit or standingPaintshopEnter or standingPaintshopExit or
          standingGarageEnter or
          standingGarageExit
   then
      createIntiBox()
  end
  if lobbyEnterWindow then
      sightexports.sGui:deleteGuiElement(lobbyEnterWindow)
      showCursor(false)
  end
  lobbyEnterWindow = false
  standingLobbyEnter = false
  standingLobbyExit = false
  standingPaintshopEnter = false
  standingPaintshopExit = false
  standingGarageExit = false
  standingGarageEnter = false
  lobbyButtons = {}
end
local loaderState = false
local loaderArg = false
local loaderStart = false
local loaderEnd = false
loaderIsLobby = false
loaderIsGarage = false
loaderHandled = false
addEvent("tryToEnterGaragesLobby", false)
addEventHandler(
  "tryToEnterGaragesLobby",
  getRootElement(),
  function(button, state, absoluteX, absoluteY, el)
      if lobbyButtons[el] and not isLoading() and not loaderHandled then
          sightexports.sWorkaround:setDisableDetach(true)
          local id = lobbyButtons[el]
          setLobbyDimension(id, false)
          disableControls(true)
          setLobbyLoader("enterGarageLobby", id, true)
          if lobbyEnterWindow then
              sightexports.sGui:deleteGuiElement(lobbyEnterWindow)
              showCursor(false)
          end
          lobbyEnterWindow = false
          lobbyButtons = {}
      end
  end
)
addEvent("tryToEnterPaintshopLobby", false)
addEventHandler(
  "tryToEnterPaintshopLobby",
  getRootElement(),
  function(button, state, absoluteX, absoluteY, el)
      if lobbyButtons[el] and not isLoading() and not loaderHandled then
          sightexports.sWorkaround:setDisableDetach(true)
          local id = lobbyButtons[el]
          setLobbyDimension(id, true)
          disableControls(true)
          setLobbyLoader("enterLobby", id, true)
          if lobbyEnterWindow then
              sightexports.sGui:deleteGuiElement(lobbyEnterWindow)
              showCursor(false)
          end
          lobbyEnterWindow = false
          lobbyButtons = {}
      end
  end
)
addEvent("closeLobbyEnterWindow", false)
addEventHandler(
  "closeLobbyEnterWindow",
  getRootElement(),
  function(button, state, absoluteX, absoluteY, el)
      if lobbyEnterWindow then
          sightexports.sGui:deleteGuiElement(lobbyEnterWindow)
          showCursor(false)
      end
      lobbyEnterWindow = false
  end
)
addEvent("refreshWorkshopReviews", true)
addEventHandler(
  "refreshWorkshopReviews",
  getRootElement(),
  function(ws, num, sum)
      local doorId, aisleId, id = getAisleFromWorkshop(ws)
      if aisleId == loadedPaintshopLobby then
          processCert(id, {sum, num})
      end
      if ws == currentWorkshop then
          workshopRatingNum = num
          workshopRatingSum = sum
      end
  end
)
addEvent("refreshPaintshopRented", true)
addEventHandler(
  "refreshPaintshopRented",
  getRootElement(),
  function(ws, dat)
      local doorId, aisleId, id = getAisleFromWorkshop(ws)
      if aisleId == loadedPaintshopLobby then
          local marker = false
          for m, i in pairs(insideMarkers) do
              if i == id then
                  marker = m
              end
          end
          local was = paintshopRented[id]
          paintshopRented[id] = dat
          if not was and dat then
              processCert(id, {0, 0})
          end
          if paintshopRented[id] then
              if marker then
                  sightexports.sMarkers:setCustomMarkerType(marker, "garage_paint")
                  sightexports.sMarkers:setCustomMarkerColor(marker, "sightyellow")
                  sightexports.sMarkers:setCustomMarkerText(
                      marker,
                      {
                          formatShopNameEx(loadedPaintshopLobby, id)
                      }
                  )
              end
              processCharsetLetters(id, paintshopRented[id].workshopName)
          else
              if marker then
                  sightexports.sMarkers:setCustomMarkerType(marker, "garage_paint_rent")
                  sightexports.sMarkers:setCustomMarkerColor(marker, "sightgreen")
                  sightexports.sMarkers:setCustomMarkerText(
                      marker,
                      {
                          formatShopNameEx(loadedPaintshopLobby, id),
                          "Kiadó!"
                      },
                      {"#ffffff", "sightgreen"}
                  )
              end
              processCharsetLetters(id, "Kiadó műhely!")
              processCert(id)
          end
          if id == standingPaintshopEnter then
              paintshopEnterMarkerHit(standingPaintshopEnter)
          end
      end
      if ws == currentWorkshop then
          workshopRented = dat
          if standingPaintshopExit and workshopRented then
              createIntiBox("garage_paint", "Műhely #" .. currentWorkshop, workshopRented.workshopName, "sightyellow")
          end
      end
  end
)
addEvent("refreshGarageRented", true)
addEventHandler(
  "refreshGarageRented",
  getRootElement(),
  function(ws, dat)
      local doorId, aisleId, id = getAisleFromWorkshop(ws)
      if aisleId == loadedGaragesLobby then
          local marker = false
          for m, i in pairs(insideMarkers) do
              if i == id then
                  marker = m
              end
          end
          garagesRented[id] = dat
          if garagesRented[id] then
              if marker then
                  sightexports.sMarkers:setCustomMarkerType(marker, "garage")
                  sightexports.sMarkers:setCustomMarkerColor(marker, "sightblue")
                  sightexports.sMarkers:setCustomMarkerText(
                      marker,
                      {
                          formatGarageNameEx(loadedGaragesLobby, id)
                      }
                  )
                  if garagesRented[id].policeLock then
                      local locker =
                          garagesRented[id].policeLock and garagesRented[id].policeLockBy and
                          garagesRented[id].policeLockGroup and
                          garagesRented[id].policeLockBy .. " (" .. garagesRented[id].policeLockGroup .. ")" or
                          ""
                      sightexports.sMarkers:setCustomMarkerPolice(marker, garagesRented[id].policeLock, locker)
                  else
                      sightexports.sMarkers:setCustomMarkerPolice(marker, false, false)
                  end
              end
          elseif marker then
              sightexports.sMarkers:setCustomMarkerType(marker, "garage_rent")
              sightexports.sMarkers:setCustomMarkerColor(marker, "sightgreen")
              sightexports.sMarkers:setCustomMarkerText(
                  marker,
                  {
                      formatGarageNameEx(loadedGaragesLobby, id),
                      "Kiadó!"
                  },
                  {"#ffffff", "sightgreen"}
              )
              sightexports.sMarkers:setCustomMarkerPolice(marker, false, false)
          end
          if id == standingGarageEnter then
              paintshopEnterMarkerHit(standingGarageEnter)
          end
      end
  end
)
addEvent("refreshPaintshopLocked", true)
addEventHandler(
  "refreshPaintshopLocked",
  getRootElement(),
  function(ws, dat)
      local doorId, aisleId, id = getAisleFromWorkshop(ws)
      if aisleId == loadedPaintshopLobby and paintshopRented[id] then
          paintshopRented[id].locked = dat
          local x, y, z, rz = unpack(aisleDoors[id])
          x = x + lobbyX
          y = y + lobbyY
          z = z + lobbyZ + 1
          local rad = math.rad(rz) - math.pi / 2
          x = x + math.cos(rad) * 1.254387 - math.sin(rad) * 4.62655
          y = y + math.sin(rad) * 1.254387 + math.cos(rad) * 4.62655
          local sound = playSound3D("files/lockunlock.mp3", x, y, z)
          setElementInterior(sound, targetIntLobby)
          setElementDimension(sound, loadedPaintshopLobby)
          if id == standingPaintshopEnter then
              paintshopEnterMarkerHit(standingPaintshopEnter)
          end
      end
      if ws == currentWorkshop and workshopRented then
          workshopRented.locked = dat
          local sound = playSound3D("files/lockunlock.mp3", wsX - 4.36904, wsY + 16.4841, wsZ + 1)
          setElementInterior(sound, targetInt)
          setElementDimension(sound, currentWorkshop)
      end
  end
)
addEvent("refreshGarageLocked", true)
addEventHandler(
  "refreshGarageLocked",
  getRootElement(),
  function(ws, dat)
      local doorId, aisleId, id = getAisleFromWorkshop(ws)
      if aisleId == loadedGaragesLobby and garagesRented[id] then
          garagesRented[id].locked = dat
          local x, y, z, rz = unpack(aisleDoors[id])
          x = x + lobbyX
          y = y + lobbyY
          z = z + lobbyZ + 1
          local rad = math.rad(rz) - math.pi / 2
          x = x + math.cos(rad) * 6.66072
          y = y + math.sin(rad) * 6.66072
          local sound = playSound3D("files/lockunlock.mp3", x, y, z)
          setElementInterior(sound, targetIntLobby)
          setElementDimension(sound, 65535 - loadedGaragesLobby)
          if id == standingGarageEnter then
              paintshopEnterMarkerHit(standingGarageEnter)
          end
      end
      if -ws == sightexports.sGarages:getCurrentGarage() then
          sightexports.sGarages:setCurrentGarageLocked(dat)
          local sound = playSound3D("files/lockunlock.mp3", 621.785, -26, 1000.9199829102)
          setElementInterior(sound, 2)
          setElementDimension(sound, ws)
      end
  end
)
addEvent("garageEnterSoundEffect", true)
addEventHandler(
  "garageEnterSoundEffect",
  getRootElement(),
  function(ws, selfPlay)
      if selfPlay then
          playSound(":sInteriors/files/garage.mp3")
      else
          local doorId, aisleId, id = getAisleFromWorkshop(ws)
          if aisleId == loadedGaragesLobby and garagesRented[id] then
              local x, y, z, rz = unpack(aisleDoors[id])
              x = x + lobbyX
              y = y + lobbyY
              z = z + lobbyZ + 1
              local rad = math.rad(rz) - math.pi / 2
              x = x + math.cos(rad) * 6.66072
              y = y + math.sin(rad) * 6.66072
              local sound = playSound3D(":sInteriors/files/garage.mp3", x, y, z)
              setElementInterior(sound, targetIntLobby)
              setElementDimension(sound, 65535 - loadedGaragesLobby)
          end
          if -ws == sightexports.sGarages:getCurrentGarage() then
              local sound = playSound3D(":sInteriors/files/garage.mp3", 621.785, -26, 1000.9199829102)
              setElementInterior(sound, 2)
              setElementDimension(sound, ws)
          end
      end
  end
)
local interiorEnterGui = false
local paintshopRentWindow = false
addEvent("paintshopRentSuccess", true)
addEventHandler(
  "paintshopRentSuccess",
  getRootElement(),
  function(reOpen)
      if paintshopRentWindow then
          sightexports.sGui:deleteGuiElement(paintshopRentWindow)
      end
      paintshopRentWindow = false
  end
)
addEvent("paintshopRentFail", true)
addEventHandler(
  "paintshopRentFail",
  getRootElement(),
  function()
      openPaintshopRentPanel()
  end
)
addEvent("rentPaintshopWithCash", false)
addEventHandler(
  "rentPaintshopWithCash",
  getRootElement(),
  function()
      if loadedPaintshopLobby and standingPaintshopEnter then
          local id = getAisleWorkshopId(loadedPaintshopLobby, standingPaintshopEnter)
          local rented = paintshopRented[standingPaintshopEnter]
          if not rented or rented.rentedBy == getElementData(localPlayer, "char.ID") then
              triggerServerEvent("rentPaintshopWorkshop", localPlayer, id, false)
              createRentPanelLoader()
          end
      end
  end
)
addEvent("rentPaintshopWithPP", false)
addEventHandler(
  "rentPaintshopWithPP",
  getRootElement(),
  function()
      if loadedPaintshopLobby and standingPaintshopEnter then
          local id = getAisleWorkshopId(loadedPaintshopLobby, standingPaintshopEnter)
          local rented = paintshopRented[standingPaintshopEnter]
          if not rented or rented.rentedBy == getElementData(localPlayer, "char.ID") then
              triggerServerEvent("rentPaintshopWorkshop", localPlayer, id, true)
              createRentPanelLoader()
          end
      end
  end
)
addEvent("unrentPaintshop", false)
addEventHandler(
  "unrentPaintshop",
  getRootElement(),
  function()
      if standingPaintshopEnter then
          local id = getAisleWorkshopId(loadedPaintshopLobby, standingPaintshopEnter)
          if paintshopRentWindow then
              sightexports.sGui:deleteGuiElement(paintshopRentWindow)
          end
          local titleBarHeight = sightexports.sGui:getTitleBarHeight()
          local pw = 300
          local ph = titleBarHeight + 100
          paintshopRentWindow =
              sightexports.sGui:createGuiElement("window", screenX / 2 - pw / 2, screenY / 2 - ph / 2, pw, ph)
          sightexports.sGui:setWindowTitle(paintshopRentWindow, "16/BebasNeueRegular.otf", "Műhely #" .. id)
          local label =
              sightexports.sGui:createGuiElement(
              "label",
              0,
              titleBarHeight,
              pw,
              ph - 8 - 32 - 8 - titleBarHeight,
              paintshopRentWindow
          )
          sightexports.sGui:setLabelAlignment(label, "center", "center")
          sightexports.sGui:setLabelText(label, "Biztosan lemondod a bérleted?")
          sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
          local w = (pw - 24) / 2
          local btn = sightexports.sGui:createGuiElement("button", 8, ph - 8 - 32, w, 32, paintshopRentWindow)
          sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
          sightexports.sGui:setGuiHover(
              btn,
              "gradient",
              {
                  "sightgreen",
                  "sightgreen-second"
              },
              false,
              true
          )
          sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
          sightexports.sGui:setButtonText(btn, "Igen")
          sightexports.sGui:setClickEvent(btn, "unrentPaintshopFinal")
          local btn =
              sightexports.sGui:createGuiElement("button", pw - w - 8, ph - 8 - 32, w, 32, paintshopRentWindow)
          sightexports.sGui:setGuiBackground(btn, "solid", "sightred")
          sightexports.sGui:setGuiHover(
              btn,
              "gradient",
              {
                  "sightred",
                  "sightred-second"
              },
              false,
              true
          )
          sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
          sightexports.sGui:setButtonText(btn, "Nem")
          sightexports.sGui:setClickEvent(btn, "openPaintshopRentPanel")
      end
  end
)
addEvent("unrentPaintshopFinal", false)
addEventHandler(
  "unrentPaintshopFinal",
  getRootElement(),
  function()
      if loadedPaintshopLobby and standingPaintshopEnter then
          local id = getAisleWorkshopId(loadedPaintshopLobby, standingPaintshopEnter)
          local rented = paintshopRented[standingPaintshopEnter]
          if rented and rented.rentedBy == getElementData(localPlayer, "char.ID") then
              triggerServerEvent("unrentPaintshopWorkshop", localPlayer, id)
              createRentPanelLoader()
          end
      end
  end
)
addEvent("rentGarageWithCash", false)
addEventHandler(
  "rentGarageWithCash",
  getRootElement(),
  function()
      if loadedGaragesLobby and standingGarageEnter then
          local id = getAisleWorkshopId(loadedGaragesLobby, standingGarageEnter)
          local rented = garagesRented[standingGarageEnter]
          if not rented or rented.rentedBy == getElementData(localPlayer, "char.ID") then
              triggerServerEvent("rentGarage", localPlayer, id, false)
              createRentPanelLoader()
          end
      end
  end
)
addEvent("rentGarageWithPP", false)
addEventHandler(
  "rentGarageWithPP",
  getRootElement(),
  function()
      if loadedGaragesLobby and standingGarageEnter then
          local id = getAisleWorkshopId(loadedGaragesLobby, standingGarageEnter)
          local rented = garagesRented[standingGarageEnter]
          if not rented or rented.rentedBy == getElementData(localPlayer, "char.ID") then
              triggerServerEvent("rentGarage", localPlayer, id, true)
              createRentPanelLoader()
          end
      end
  end
)
addEvent("unrentGarage", false)
addEventHandler(
  "unrentGarage",
  getRootElement(),
  function()
      if standingGarageEnter then
          local id = getAisleWorkshopId(loadedGaragesLobby, standingGarageEnter)
          if paintshopRentWindow then
              sightexports.sGui:deleteGuiElement(paintshopRentWindow)
          end
          local titleBarHeight = sightexports.sGui:getTitleBarHeight()
          local pw = 300
          local ph = titleBarHeight + 100
          paintshopRentWindow =
              sightexports.sGui:createGuiElement("window", screenX / 2 - pw / 2, screenY / 2 - ph / 2, pw, ph)
          sightexports.sGui:setWindowTitle(paintshopRentWindow, "16/BebasNeueRegular.otf", "Garázs #" .. id)
          local label =
              sightexports.sGui:createGuiElement(
              "label",
              0,
              titleBarHeight,
              pw,
              ph - 8 - 32 - 8 - titleBarHeight,
              paintshopRentWindow
          )
          sightexports.sGui:setLabelAlignment(label, "center", "center")
          sightexports.sGui:setLabelText(label, "Biztosan lemondod a bérleted?")
          sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
          local w = (pw - 24) / 2
          local btn = sightexports.sGui:createGuiElement("button", 8, ph - 8 - 32, w, 32, paintshopRentWindow)
          sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
          sightexports.sGui:setGuiHover(
              btn,
              "gradient",
              {
                  "sightgreen",
                  "sightgreen-second"
              },
              false,
              true
          )
          sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
          sightexports.sGui:setButtonText(btn, "Igen")
          sightexports.sGui:setClickEvent(btn, "unrentGarageFinal")
          local btn =
              sightexports.sGui:createGuiElement("button", pw - w - 8, ph - 8 - 32, w, 32, paintshopRentWindow)
          sightexports.sGui:setGuiBackground(btn, "solid", "sightred")
          sightexports.sGui:setGuiHover(
              btn,
              "gradient",
              {
                  "sightred",
                  "sightred-second"
              },
              false,
              true
          )
          sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
          sightexports.sGui:setButtonText(btn, "Nem")
          sightexports.sGui:setClickEvent(btn, "openPaintshopRentPanel")
      end
  end
)
addEvent("unrentGarageFinal", false)
addEventHandler(
  "unrentGarageFinal",
  getRootElement(),
  function()
      if loadedGaragesLobby and standingGarageEnter then
          local id = getAisleWorkshopId(loadedGaragesLobby, standingGarageEnter)
          local rented = garagesRented[standingGarageEnter]
          if rented and rented.rentedBy == getElementData(localPlayer, "char.ID") then
              triggerServerEvent("unrentGarage", localPlayer, id)
              createRentPanelLoader()
          end
      end
  end
)
local controlState = false
function disableControls(state)
  if controlState ~= state then
      controlState = state
      sightexports.sControls:toggleAllControls(not state)
  end
end
function setLobbyLoader(state, arg, lobby, garage)
  if loaderState ~= state then
      if state then
          if not loaderStart then
              loaderStart = getTickCount()
          end
          if not bigLoader then
              bigLoader = math.random(1, 6)
          end
          loaderIsLobby = lobby
          loaderIsGarage = garage
      else
          loaderEnd = getTickCount()
      end
      if not loaderHandled then
          loaderHandled = true
          addEventHandler("onClientRender", getRootElement(), drawLoader, true, "low-999")
      end
      loaderState = state
  end
  loaderArg = arg
end

function drawLoader()
  local now = getTickCount()
  local p = 1
  if loaderStart then
      p = (now - loaderStart) / 500
      if loaderEnd then
          loaderEnd = now
      end
      if 1 < p then
          if 3 < p then
              loaderStart = false
              if loaderState == "enterGarage" then
                  triggerServerEvent("tryToEnterRentGarage", localPlayer, loaderArg)
              elseif loaderState == "exitGarage" then
                  triggerServerEvent("exitRentGarage", localPlayer)
              elseif loaderState == "enterWorkshop" then
                  triggerServerEvent("tryToEnterPaintWorkshop", localPlayer, loaderArg)
              elseif loaderState == "exitWorkshop" then
                  triggerServerEvent("exitPaintWorkshop", localPlayer)
              elseif loaderState == "enterLobby" then
                  triggerServerEvent("enterPaintshopLobby", localPlayer, loaderArg)
              elseif loaderState == "enterGarageLobby" then
                  triggerServerEvent("enterGarageLobby", localPlayer, loaderArg)
              end
              loaderState = true
          end
          p = 1
      end
  elseif loaderEnd or not bigLoader then
      if bigLoader then
          p = 1 - (now - loaderEnd) / 500
      else
          p = 0
      end
      disableControls(false)
      if p < 0 then
          loaderEnd = false
          if loaderHandled then
              removeEventHandler("onClientRender", getRootElement(), drawLoader)
          end
          if not isLoading() then
              bigLoader = false
          end
          loaderHandled = false
          loaderState = false
          loaderArg = false
      end
  end
  if 0 < p then
      local s = 1.5 - p * 0.5
      local sy = screenY + 2
      sy = sy * s
      local sx = math.ceil(sy * 1.7777777777777777)
      if sx < screenX then
          dxDrawRectangle(
              0,
              0,
              screenX / 2 - sx / 2,
              screenY,
              "files/loading/" .. bigLoader .. ".dds",
              0,
              0,
              0,
              tocolor(0, 0, 0, 255 * p)
          )
          dxDrawRectangle(
              screenX / 2 + sx / 2,
              0,
              screenX / 2 - sx / 2,
              screenY,
              "files/loading/" .. bigLoader .. ".dds",
              0,
              0,
              0,
              tocolor(0, 0, 0, 255 * p)
          )
      end
      dxDrawImage(
          screenX / 2 - sx / 2,
          screenY / 2 - sy / 2,
          sx,
          sy,
          "files/loading/" .. bigLoader .. ".dds",
          0,
          0,
          0,
          tocolor(255, 255, 255, 255 * p)
      )
      local sp = 90 * s
      dxDrawImage(
          screenX / 2 - sp / 2,
          screenY / 2 - sp / 2,
          sp,
          sp,
          "files/loading/sp2.dds",
          0,
          0,
          0,
          tocolor(green[1] * 0.1, green[2] * 0.1, green[3] * 0.1, 200 * p)
      )
      dxDrawImage(
          screenX / 2 - sp / 2,
          screenY / 2 - sp / 2,
          sp,
          sp,
          "files/loading/sp1.dds",
          -now / 4.75 % 360,
          0,
          0,
          tocolor(green[1], green[2], green[3], 255 * p)
      )
      if loaderIsLobby then
          dxDrawText(
              "Folyosó betöltése",
              0,
              screenY / 2 + 50 + 12,
              screenX,
              screenY / 2 + 50 + 12 + 32,
              tocolor(255, 255, 255, 255 * p),
              loaderFontScale * s,
              loaderFont,
              "center",
              "center"
          )
      elseif loaderIsGarage then
          dxDrawText(
              "Garázs betöltése",
              0,
              screenY / 2 + 50 + 12,
              screenX,
              screenY / 2 + 50 + 12 + 32,
              tocolor(255, 255, 255, 255 * p),
              loaderFontScale * s,
              loaderFont,
              "center",
              "center"
          )
      else
          dxDrawText(
              "Fényezőműhely betöltése",
              0,
              screenY / 2 + 50 + 12,
              screenX,
              screenY / 2 + 50 + 12 + 32,
              tocolor(255, 255, 255, 255 * p),
              loaderFontScale * s,
              loaderFont,
              "center",
              "center"
          )
      end
  end
end
addEvent("paintshopEntryFailed", true)
addEventHandler(
  "paintshopEntryFailed",
  getRootElement(),
  function()
      disableControls(false)
      setLobbyLoader(false)
  end
)
function lockUnlockPaintshop()
  if not isLoading() and not lobbyEnterWindow and not loaderHandled then
      if currentWorkshop then
          if standingPaintshopExit then
              if isPedInVehicle(localPlayer) then
                  return
              end
              triggerServerEvent("tryToLockUnlockWorkshop", localPlayer)
          end
      elseif loadedPaintshopLobby then
          if standingPaintshopEnter then
              if isPedInVehicle(localPlayer) then
                  return
              end
              local id = getAisleWorkshopId(loadedPaintshopLobby, standingPaintshopEnter)
              if paintshopRented[standingPaintshopEnter] then
                  triggerServerEvent("tryToLockUnlockWorkshop", localPlayer, id)
              end
          end
      elseif standingGarageExit then
          local id = sightexports.sGarages:getCurrentGarage()
          if id and id < 0 then
              triggerServerEvent("tryToLockUnlockRentGarage", localPlayer)
          end
      elseif loadedGaragesLobby and standingGarageEnter then
          local id = getAisleWorkshopId(loadedGaragesLobby, standingGarageEnter)
          if garagesRented[standingGarageEnter] then
              triggerServerEvent("tryToLockUnlockRentGarage", localPlayer, id)
          end
      end
  end
end
bindKey("K", "up", lockUnlockPaintshop)
addEvent("lockUnlockPaintshop", false)
addEventHandler("lockUnlockPaintshop", getRootElement(), lockUnlockPaintshop)
addEvent("startRentableGarageLoad", true)
addEventHandler(
  "startRentableGarageLoad",
  getRootElement(),
  function(id)
      disableControls(true)
      setLobbyLoader(true, false, false, true)
      sightexports.sGarages:prepareGarageFloor(-id)
      sightexports.sMarkers:setCustomMarkerDimension(garagesExitMarker, -id)
  end
)

bindKey(
  "E",
  "up",
  function()
      if not isLoading() and not lobbyEnterWindow and not loaderHandled and not paintshopRentWindow then
          if currentWorkshop then
              if standingPaintshopExit and workshopRented then
                  if isPedInVehicle(localPlayer) then
                      return
                  end
                  if hasPlayerSkin then 
                    sightexports.sGui:showInfobox("e", "Öltözz át, mielőtt kimennél!")
                    return
                  end
                  if playerSanders[localPlayer] then
                    sightexports.sGui:showInfobox("e", "Rakd vissza a csiszolót amikor kimennél!")
                    return
                  end
                  if playerHoldingCasette then
                    sightexports.sGui:showInfobox("e", "Kazettával a kezedben nem mehetsz ki!")
                    return
                  end
                  if tankInHand then
                    sightexports.sGui:showInfobox("e", "Ezzel a kezedben nem mehetsz ki!")
                    return
                  end
                  for i = 1, 2 do
                      if dataToSync[i] or 0 < (unsyncedPaintDelta[i] or 0) then
                          sightexports.sGui:showInfobox("e", "Várj egy kicsit!")
                          return
                      end
                  end
                  if permissionDataToSync then
                      sightexports.sGui:showInfobox("e", "Várj egy kicsit!")
                      return
                  end
                  if workshopRented.locked then
                      sightexports.sGui:showInfobox("e", "A műhely be van zárva!")
                      playSound("files/locked.mp3")
                  else
                      disableControls(true)
                      setLobbyLoader("exitWorkshop", false, true)
                      local doorId, aisleId = getAisleFromWorkshop(currentWorkshop)
                      setLobbyDimension(aisleId, true)
                  end
              end
          elseif standingGarageExit then
              local id = sightexports.sGarages:getCurrentGarage()
              if id and id < 0 then
                  id = math.abs(id)
                  if sightexports.sGarages:isCurrentGarageLocked() then
                      sightexports.sGui:showInfobox("e", "A garázs be van zárva!")
                      playSound("files/locked.mp3")
                  else
                      local veh = getPedOccupiedVehicle(localPlayer)
                      if veh then
                          if getPedOccupiedVehicleSeat(localPlayer) ~= 0 then
                              return
                          end
                          if getElementData(veh, "towCar") then
                              sightexports.sGui:showInfobox("e", "Utánfutóval nem mehetsz be!")
                              return
                          end
                          setElementData(veh, "vehicle.gear", "N")
                      end
                      disableControls(true)
                      setLobbyLoader("exitGarage", false, true)
                      local doorId, aisleId = getAisleFromWorkshop(id)
                      setLobbyDimension(aisleId, false)
                  end
              end
          elseif loadedGaragesLobby then
              if standingGarageEnter then
                  local veh = getPedOccupiedVehicle(localPlayer)
                  if veh then
                      if getPedOccupiedVehicleSeat(localPlayer) ~= 0 then
                          return
                      end
                      if getElementData(veh, "towCar") then
                          sightexports.sGui:showInfobox("e", "Utánfutóval nem mehetsz be!")
                          return
                      end
                      setElementData(veh, "vehicle.gear", "N")
                  end
                  if garagesRented[standingGarageEnter] then
                      if garagesRented[standingGarageEnter].policeLock then
                          sightexports.sGui:showInfobox("e", "A garázs le van zárva!")
                          return
                      end
                      if garagesRented[standingGarageEnter].locked then
                          sightexports.sGui:showInfobox("e", "A garázs be van zárva!")
                          playSound("files/locked.mp3")
                      else
                          local id = getAisleWorkshopId(loadedGaragesLobby, standingGarageEnter)
                          sightexports.sGarages:prepareGarageFloor(-id)
                          sightexports.sMarkers:setCustomMarkerDimension(garagesExitMarker, 65535 - id)
                          disableControls(true)
                          setLobbyLoader("enterGarage", id, false, true)
                      end
                  else
                      openPaintshopRentPanel()
                  end
              elseif standingLobbyExit then
                  if isPedInVehicle(localPlayer) and getPedOccupiedVehicleSeat(localPlayer) ~= 0 then
                      return
                  end
                  sightexports.sWorkaround:setDisableDetach(true)
                  triggerServerEvent("exitPaintshopLobby", localPlayer)
              end
          elseif loadedPaintshopLobby then
              if standingPaintshopEnter then
                  if paintshopRented[standingPaintshopEnter] then
                      if isPedInVehicle(localPlayer) then
                          return
                      end
                      if paintshopRented[standingPaintshopEnter].locked then
                          sightexports.sGui:showInfobox("e", "A műhely be van zárva!")
                          playSound("files/locked.mp3")
                      else
                          local id = getAisleWorkshopId(loadedPaintshopLobby, standingPaintshopEnter)
                          disableControls(true)
                          setLobbyLoader("enterWorkshop", id)
                          preparePaintshopObject(id)
                      end
                  else
                      openPaintshopRentPanel()
                  end
              elseif standingLobbyExit then
                  if isPedInVehicle(localPlayer) and getPedOccupiedVehicleSeat(localPlayer) ~= 0 then
                      return
                  end
                  sightexports.sWorkaround:setDisableDetach(true)
                  triggerServerEvent("exitPaintshopLobby", localPlayer)
              end
          elseif standingLobbyEnter then
              if isPedInVehicle(localPlayer) and getPedOccupiedVehicleSeat(localPlayer) ~= 0 then
                  return
              end
              local veh = getPedOccupiedVehicle(localPlayer)
              if veh then
                  setElementData(veh, "vehicle.gear", "N")
              end
              local titleBarHeight = sightexports.sGui:getTitleBarHeight()
              local aisleNum = garageDoors[standingLobbyEnter][8]
              local garageNum = garageDoors[standingLobbyEnter][9]
              local pw = 300
              local ph = titleBarHeight + 48 * math.max(aisleNum, garageNum) + 24 + 16
              local title =
                  garageDoors[standingLobbyEnter][5] .. " csarnok " .. garageDoors[standingLobbyEnter][6] .. ". ajtó"
              if lobbyEnterWindow then
                  sightexports.sGui:deleteGuiElement(lobbyEnterWindow)
              end
              local n = 0
              if 0 < aisleNum then
                  n = n + 1
              end
              if 0 < garageNum then
                  n = n + 1
              end
              lobbyEnterWindow =
                  sightexports.sGui:createGuiElement(
                  "window",
                  screenX / 2 - pw * n / 2,
                  screenY / 2 - ph / 2,
                  pw * n,
                  ph
              )
              sightexports.sGui:setWindowTitle(
                  lobbyEnterWindow,
                  "16/BebasNeueRegular.otf",
                  garageDoors[standingLobbyEnter][7]
              )
              sightexports.sGui:setWindowCloseButton(lobbyEnterWindow, "closeLobbyEnterWindow")
              showCursor(true)
              lobbyButtons = {}
              local y = titleBarHeight + 8
              local x = 0
              if 0 < aisleNum then
                  local label = sightexports.sGui:createGuiElement("label", x, y - 4, pw, 24, lobbyEnterWindow)
                  sightexports.sGui:setLabelAlignment(label, "center", "center")
                  sightexports.sGui:setLabelText(label, "Bérelhető műhelyek:")
                  sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
                  y = y + 24
                  for i = 1, aisleNum do
                      local id = getAisleId(standingLobbyEnter, i)
                      local x = x + 8
                      local pw = pw - 32 - 16
                      if boxBlipData and boxBlipData[2] == id or currentMarkerWS and currentMarkerWS[2] == id then
                          local image =
                              sightexports.sGui:createGuiElement(
                              "image",
                              x,
                              y + 24 - 10,
                              20,
                              20,
                              lobbyEnterWindow
                          )
                          sightexports.sGui:setImageFile(
                              image,
                              sightexports.sGui:getFaIconFilename("circle", 24)
                          )
                          sightexports.sGui:setImageColor(image, "sightgreen")
                          x = x + 20 + 8
                          pw = pw - 20 - 8
                      end
                      local label = sightexports.sGui:createGuiElement("label", x, y, 0, 24, lobbyEnterWindow)
                      sightexports.sGui:setLabelAlignment(label, "left", "center")
                      sightexports.sGui:setLabelText(label, i .. ". folyosó")
                      sightexports.sGui:setLabelColor(label, "sightgreen")
                      sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
                      local label =
                          sightexports.sGui:createGuiElement("label", x, y + 24, 0, 24, lobbyEnterWindow)
                      sightexports.sGui:setLabelAlignment(label, "left", "center")
                      sightexports.sGui:setLabelText(label, title)
                      sightexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
                      local btn =
                          sightexports.sGui:createGuiElement(
                          "button",
                          x + pw,
                          y + 24 - 16,
                          32,
                          32,
                          lobbyEnterWindow
                      )
                      sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
                      sightexports.sGui:setGuiHover(
                          btn,
                          "gradient",
                          {
                              "sightgreen",
                              "sightgreen-second"
                          },
                          false,
                          true
                      )
                      sightexports.sGui:setButtonFont(btn, "14/BebasNeueBold.otf")
                      sightexports.sGui:setButtonIcon(
                          btn,
                          sightexports.sGui:getFaIconFilename("sign-in-alt", 32)
                      )
                      sightexports.sGui:setClickEvent(btn, "tryToEnterPaintshopLobby")
                      sightexports.sGui:guiSetTooltip(btn, "Belépés")
                      lobbyButtons[btn] = id
                      y = y + 48
                      local border =
                          sightexports.sGui:createGuiElement("hr", x, y - 1, pw - 16, 2, lobbyEnterWindow)
                  end
                  x = x + pw
              end
              y = titleBarHeight + 8
              if 0 < garageNum then
                  if 0 < aisleNum then
                      local border =
                          sightexports.sGui:createGuiElement("hr", x - 1, y, 2, ph - y - 8, lobbyEnterWindow)
                  end
                  local label = sightexports.sGui:createGuiElement("label", x, y - 4, pw, 24, lobbyEnterWindow)
                  sightexports.sGui:setLabelAlignment(label, "center", "center")
                  sightexports.sGui:setLabelText(label, "Bérelhető garázsok:")
                  sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
                  y = y + 24
                  for i = 1, garageNum do
                      local id = getAisleId(standingLobbyEnter, i)
                      local x = x + 8
                      local label = sightexports.sGui:createGuiElement("label", x, y, 0, 24, lobbyEnterWindow)
                      sightexports.sGui:setLabelAlignment(label, "left", "center")
                      sightexports.sGui:setLabelText(label, i .. ". folyosó")
                      sightexports.sGui:setLabelColor(label, "sightgreen")
                      sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
                      local label =
                          sightexports.sGui:createGuiElement("label", x, y + 24, 0, 24, lobbyEnterWindow)
                      sightexports.sGui:setLabelAlignment(label, "left", "center")
                      sightexports.sGui:setLabelText(label, title)
                      sightexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
                      local btn =
                          sightexports.sGui:createGuiElement(
                          "button",
                          x + pw - 32 - 16,
                          y + 24 - 16,
                          32,
                          32,
                          lobbyEnterWindow
                      )
                      sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
                      sightexports.sGui:setGuiHover(
                          btn,
                          "gradient",
                          {
                              "sightgreen",
                              "sightgreen-second"
                          },
                          false,
                          true
                      )
                      sightexports.sGui:setButtonFont(btn, "14/BebasNeueBold.otf")
                      sightexports.sGui:setButtonIcon(
                          btn,
                          sightexports.sGui:getFaIconFilename("sign-in-alt", 32)
                      )
                      sightexports.sGui:setClickEvent(btn, "tryToEnterGaragesLobby")
                      sightexports.sGui:guiSetTooltip(btn, "Belépés")
                      lobbyButtons[btn] = id
                      y = y + 48
                      local border =
                          sightexports.sGui:createGuiElement("hr", x, y - 1, pw - 16, 2, lobbyEnterWindow)
                  end
              end
          end
      end
  end
)
function drawCharset()
  local font = sightexports.sGui:getFont("19/BebasNeueRegular.otf")
  local fontScale = sightexports.sGui:getFontScale("19/BebasNeueRegular.otf")
  local rt = dxCreateRenderTarget(32 * #charset, 32, true)
  dxSetRenderTarget(rt)
  for i = 1, #charset do
      local w = dxGetTextWidth(charset[i], fontScale, font) / 32
      dxDrawText(charset[i], 32 * (i - 1), 0, 32 * i, 32, tocolor(255, 255, 255), fontScale, font, "center", "center")
      --outputChatBox('["' .. charset[i] .. '"] = {' .. i .. ", " .. w .. "},")
  end
  dxSetRenderTarget()
  destroyElement(font)
  local pixels = dxGetTexturePixels(rt)
  destroyElement(rt)
  if pixels then
      local convertedPixels = dxConvertPixels(pixels, "plain")
      if convertedPixels then
          local checksum = sha256(convertedPixels)
          if fileExists("charset.sight") then
              fileDelete("charset.sight")
          end
          local convertedFile = fileCreate("charset.sight")
          if convertedFile then
              fileWrite(convertedFile, convertedPixels)
              fileClose(convertedFile)
          end
      end
  end
end
addEvent("changeEnteredCustomMarker", false)
addEventHandler(
  "changeEnteredCustomMarker",
  getRootElement(),
  function(theType, id)
      if theType == "lobbyExit" then
          lobbyExitMarkerHit()
      elseif theType == "lobbyEnter" then
          lobbyEnterMarkerHit(id)
      elseif theType == "garageExit" then
          garageExitMarkerHit()
      elseif theType == "paintshopExit" then
          paintshopExitMarkerHit()
      elseif theType == "paintshopEnter" then
          paintshopEnterMarkerHit(id)
      else
          paintshopMarkerLeave()
      end
  end
)
addEvent("closePaintshopRentPanel", false)
addEventHandler(
  "closePaintshopRentPanel",
  getRootElement(),
  function()
      if paintshopRentWindow then
          sightexports.sGui:deleteGuiElement(paintshopRentWindow)
      end
      paintshopRentWindow = false
  end
)
function createRentPanelLoader()
  local titleBarHeight = sightexports.sGui:getTitleBarHeight()
  local pw, ph = 300, titleBarHeight + 100
  if paintshopRentWindow then
      pw, ph = sightexports.sGui:getGuiSize(paintshopRentWindow)
      sightexports.sGui:deleteGuiElement(paintshopRentWindow)
  end
  paintshopRentWindow =
      sightexports.sGui:createGuiElement("window", screenX / 2 - pw / 2, screenY / 2 - ph / 2, pw, ph)
  sightexports.sGui:setWindowTitle(paintshopRentWindow, "16/BebasNeueRegular.otf", "Kérlek várj...")
  sightexports.sGui:setWindowCloseButton(paintshopRentWindow, "closePaintshopRentPanel")
  local icon =
      sightexports.sGui:createGuiElement(
      "image",
      pw / 2 - 24,
      titleBarHeight + (ph - titleBarHeight) / 2 - 24,
      48,
      48,
      paintshopRentWindow
  )
  sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("circle-notch", 48))
  sightexports.sGui:setImageSpinner(icon, true)
end
function openPaintshopRentPanel()
  if paintshopRentWindow then
      sightexports.sGui:deleteGuiElement(paintshopRentWindow)
  end
  paintshopRentWindow = false
  if standingGarageEnter then
      local id = getAisleWorkshopId(loadedGaragesLobby, standingGarageEnter)
      local pw = 300
      local titleBarHeight = sightexports.sGui:getTitleBarHeight()
      if garagesRented[standingGarageEnter] then
          local cid = getElementData(localPlayer, "char.ID")
          if garagesRented[standingGarageEnter].rentedBy == cid then
              local deltaRaw = garagesRented[standingGarageEnter].rentUntil - getRealTimestamp()
              local ph = titleBarHeight + 32 + 8 + 76
              paintshopRentWindow =
                  sightexports.sGui:createGuiElement(
                  "window",
                  screenX / 2 - pw / 2,
                  screenY / 2 - ph / 2,
                  pw,
                  ph
              )
              sightexports.sGui:setWindowTitle(paintshopRentWindow, "16/BebasNeueRegular.otf", "Garázs #" .. id)
              sightexports.sGui:setWindowCloseButton(paintshopRentWindow, "closePaintshopRentPanel")
              local y = titleBarHeight
              delta = deltaRaw / 3600
              if delta < 0.5 then
                  delta = "kevesebb mint fél óra"
              elseif delta < 1 then
                  delta = "kevesebb mint 1 óra"
              elseif delta < 24 then
                  delta = math.floor(delta) .. " óra"
              else
                  local days = math.floor(delta / 24)
                  local hours = math.floor(delta) - days * 24
                  if 0 < hours then
                      delta = days .. " nap " .. hours .. " óra"
                  else
                      delta = days .. " nap"
                  end
              end
              local label = sightexports.sGui:createGuiElement("label", 0, y, pw, 32, paintshopRentWindow)
              sightexports.sGui:setLabelAlignment(label, "center", "center")
              sightexports.sGui:setLabelText(label, "Bérlet lejár: " .. delta)
              sightexports.sGui:setLabelFont(label, "15/BebasNeueBold.otf")
              sightexports.sGui:setLabelColor(label, "sightgreen")
              y = y + 32 + 8
              if deltaRaw < 172800 then
                  local btn =
                      sightexports.sGui:createGuiElement("button", 8, y, pw - 16, 30, paintshopRentWindow)
                  sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
                  sightexports.sGui:setGuiHover(
                      btn,
                      "gradient",
                      {
                          "sightgreen",
                          "sightgreen-second"
                      },
                      false,
                      true
                  )
                  sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
                  if garagesRented[standingGarageEnter].rentMode == "pp" then
                      sightexports.sGui:setButtonText(
                          btn,
                          "Meghosszabbítás (2 hét - " .. sightexports.sGui:thousandsStepper(500) .. " PP)"
                      )
                      sightexports.sGui:setClickEvent(btn, "rentGarageWithPP")
                  else
                      sightexports.sGui:setButtonText(
                          btn,
                          "Meghosszabbítás (2 hét - " .. sightexports.sGui:thousandsStepper(20000) .. " $)"
                      )
                      sightexports.sGui:setClickEvent(btn, "rentGarageWithCash")
                  end
              else
                  local label = sightexports.sGui:createGuiElement("label", 0, y, pw, 30, paintshopRentWindow)
                  sightexports.sGui:setLabelAlignment(label, "center", "center")
                  sightexports.sGui:setLabelText(label, "Meghosszabbítani lejárat előtt 48 órával lehet.")
                  sightexports.sGui:setLabelFont(label, "13/BebasNeueRegular.otf")
              end
              y = y + 30 + 8
              local btn = sightexports.sGui:createGuiElement("button", 8, y, pw - 16, 30, paintshopRentWindow)
              sightexports.sGui:setGuiBackground(btn, "solid", "sightred")
              sightexports.sGui:setGuiHover(
                  btn,
                  "gradient",
                  {
                      "sightred",
                      "sightred-second"
                  },
                  false,
                  true
              )
              sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
              sightexports.sGui:setButtonText(btn, "Bérlet lemondása")
              sightexports.sGui:setClickEvent(btn, "unrentGarage")
          end
      else
          local ph = titleBarHeight + 96 + 24 + 8 + 76
          paintshopRentWindow =
              sightexports.sGui:createGuiElement("window", screenX / 2 - pw / 2, screenY / 2 - ph / 2, pw, ph)
          sightexports.sGui:setWindowTitle(paintshopRentWindow, "16/BebasNeueRegular.otf", "Garázs #" .. id)
          sightexports.sGui:setWindowCloseButton(paintshopRentWindow, "closePaintshopRentPanel")
          local y = titleBarHeight
          local label = sightexports.sGui:createGuiElement("label", 0, y, pw, 32, paintshopRentWindow)
          sightexports.sGui:setLabelAlignment(label, "center", "center")
          sightexports.sGui:setLabelText(label, sightexports.sGui:thousandsStepper(20000) .. " $ / 2 hét")
          sightexports.sGui:setLabelFont(label, "15/BebasNeueBold.otf")
          sightexports.sGui:setLabelColor(label, "sightgreen")
          y = y + 32
          local label = sightexports.sGui:createGuiElement("label", 0, y, pw, 32, paintshopRentWindow)
          sightexports.sGui:setLabelAlignment(label, "center", "center")
          sightexports.sGui:setLabelText(
              label,
              " + " .. sightexports.sGui:thousandsStepper(40000) .. " $ egyszeri kaució"
          )
          sightexports.sGui:setLabelFont(label, "13/BebasNeueBold.otf")
          sightexports.sGui:setLabelColor(label, "sightgreen")
          y = y + 32
          local label = sightexports.sGui:createGuiElement("label", 0, y, pw, 24, paintshopRentWindow)
          sightexports.sGui:setLabelAlignment(label, "center", "center")
          sightexports.sGui:setLabelText(label, "vagy")
          sightexports.sGui:setLabelFont(label, "13/BebasNeueRegular.otf")
          y = y + 24
          local label = sightexports.sGui:createGuiElement("label", 0, y, pw, 32, paintshopRentWindow)
          sightexports.sGui:setLabelAlignment(label, "center", "center")
          sightexports.sGui:setLabelText(label, sightexports.sGui:thousandsStepper(500) .. " PP / 2 hét")
          sightexports.sGui:setLabelFont(label, "15/BebasNeueBold.otf")
          sightexports.sGui:setLabelColor(label, "sightblue")
          y = y + 32 + 8
          local bw = (pw - 16) / 2 - 4
          local btn = sightexports.sGui:createGuiElement("button", 8, y, bw, 30, paintshopRentWindow)
          sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
          sightexports.sGui:setGuiHover(
              btn,
              "gradient",
              {
                  "sightgreen",
                  "sightgreen-second"
              },
              false,
              true
          )
          sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
          sightexports.sGui:setButtonText(btn, "Bérlés ($)")
          sightexports.sGui:setClickEvent(btn, "rentGarageWithCash")
          local btn = sightexports.sGui:createGuiElement("button", 8 + bw + 8, y, bw, 30, paintshopRentWindow)
          sightexports.sGui:setGuiBackground(btn, "solid", "sightblue")
          sightexports.sGui:setGuiHover(
              btn,
              "gradient",
              {
                  "sightblue",
                  "sightblue-second"
              },
              false,
              true
          )
          sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
          sightexports.sGui:setButtonText(btn, "Bérlés (PP)")
          sightexports.sGui:setClickEvent(btn, "rentGarageWithPP")
          y = y + 30 + 8
          local btn = sightexports.sGui:createGuiElement("button", 8, y, pw - 16, 30, paintshopRentWindow)
          sightexports.sGui:setGuiBackground(btn, "solid", "sightred")
          sightexports.sGui:setGuiHover(
              btn,
              "gradient",
              {
                  "sightred",
                  "sightred-second"
              },
              false,
              true
          )
          sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
          sightexports.sGui:setButtonText(btn, "Mégsem")
          sightexports.sGui:setClickEvent(btn, "closePaintshopRentPanel")
      end
  elseif standingPaintshopEnter then
      local id = getAisleWorkshopId(loadedPaintshopLobby, standingPaintshopEnter)
      local pw = 300
      local titleBarHeight = sightexports.sGui:getTitleBarHeight()
      if paintshopRented[standingPaintshopEnter] then
          local cid = getElementData(localPlayer, "char.ID")
          if paintshopRented[standingPaintshopEnter].rentedBy == cid then
              local deltaRaw = paintshopRented[standingPaintshopEnter].rentUntil - getRealTimestamp()
              local ph = titleBarHeight + 32 + 8 + 76
              paintshopRentWindow =
                  sightexports.sGui:createGuiElement(
                  "window",
                  screenX / 2 - pw / 2,
                  screenY / 2 - ph / 2,
                  pw,
                  ph
              )
              sightexports.sGui:setWindowTitle(paintshopRentWindow, "16/BebasNeueRegular.otf", "Műhely #" .. id)
              sightexports.sGui:setWindowCloseButton(paintshopRentWindow, "closePaintshopRentPanel")
              local y = titleBarHeight
              delta = deltaRaw / 3600
              if delta < 0.5 then
                  delta = "kevesebb mint fél óra"
              elseif delta < 1 then
                  delta = "kevesebb mint 1 óra"
              elseif delta < 24 then
                  delta = math.floor(delta) .. " óra"
              else
                  local days = math.floor(delta / 24)
                  local hours = math.floor(delta) - days * 24
                  if 0 < hours then
                      delta = days .. " nap " .. hours .. " óra"
                  else
                      delta = days .. " nap"
                  end
              end
              local label = sightexports.sGui:createGuiElement("label", 0, y, pw, 32, paintshopRentWindow)
              sightexports.sGui:setLabelAlignment(label, "center", "center")
              sightexports.sGui:setLabelText(label, "Bérlet lejár: " .. delta)
              sightexports.sGui:setLabelFont(label, "15/BebasNeueBold.otf")
              sightexports.sGui:setLabelColor(label, "sightgreen")
              y = y + 32 + 8
              if deltaRaw < 86400 then
                  local btn =
                      sightexports.sGui:createGuiElement("button", 8, y, pw - 16, 30, paintshopRentWindow)
                  sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
                  sightexports.sGui:setGuiHover(
                      btn,
                      "gradient",
                      {
                          "sightgreen",
                          "sightgreen-second"
                      },
                      false,
                      true
                  )
                  sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
                  if paintshopRented[standingPaintshopEnter].rentMode == "pp" then
                      sightexports.sGui:setButtonText(
                          btn,
                          "Meghosszabbítás (1 hét - " .. sightexports.sGui:thousandsStepper(1500) .. " PP)"
                      )
                      sightexports.sGui:setClickEvent(btn, "rentPaintshopWithPP")
                  else
                      sightexports.sGui:setButtonText(
                          btn,
                          "Meghosszabbítás (1 hét - " .. sightexports.sGui:thousandsStepper(15000) .. " $)"
                      )
                      sightexports.sGui:setClickEvent(btn, "rentPaintshopWithCash")
                  end
              else
                  local label = sightexports.sGui:createGuiElement("label", 0, y, pw, 30, paintshopRentWindow)
                  sightexports.sGui:setLabelAlignment(label, "center", "center")
                  sightexports.sGui:setLabelText(label, "Meghosszabbítani lejárat előtt 24 órával lehet.")
                  sightexports.sGui:setLabelFont(label, "13/BebasNeueRegular.otf")
              end
              y = y + 30 + 8
              local btn = sightexports.sGui:createGuiElement("button", 8, y, pw - 16, 30, paintshopRentWindow)
              sightexports.sGui:setGuiBackground(btn, "solid", "sightred")
              sightexports.sGui:setGuiHover(
                  btn,
                  "gradient",
                  {
                      "sightred",
                      "sightred-second"
                  },
                  false,
                  true
              )
              sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
              sightexports.sGui:setButtonText(btn, "Bérlet lemondása")
              sightexports.sGui:setClickEvent(btn, "unrentPaintshop")
          end
      else
          local ph = titleBarHeight + 96 + 24 + 8 + 76
          paintshopRentWindow =
              sightexports.sGui:createGuiElement("window", screenX / 2 - pw / 2, screenY / 2 - ph / 2, pw, ph)
          sightexports.sGui:setWindowTitle(paintshopRentWindow, "16/BebasNeueRegular.otf", "Műhely #" .. id)
          sightexports.sGui:setWindowCloseButton(paintshopRentWindow, "closePaintshopRentPanel")
          local y = titleBarHeight
          local label = sightexports.sGui:createGuiElement("label", 0, y, pw, 32, paintshopRentWindow)
          sightexports.sGui:setLabelAlignment(label, "center", "center")
          sightexports.sGui:setLabelText(label, sightexports.sGui:thousandsStepper(15000) .. " $ / hét")
          sightexports.sGui:setLabelFont(label, "15/BebasNeueBold.otf")
          sightexports.sGui:setLabelColor(label, "sightgreen")
          y = y + 32
          local label = sightexports.sGui:createGuiElement("label", 0, y, pw, 32, paintshopRentWindow)
          sightexports.sGui:setLabelAlignment(label, "center", "center")
          sightexports.sGui:setLabelText(
              label,
              " + " .. sightexports.sGui:thousandsStepper(60000) .. " $ egyszeri kaució"
          )
          sightexports.sGui:setLabelFont(label, "13/BebasNeueBold.otf")
          sightexports.sGui:setLabelColor(label, "sightgreen")
          y = y + 32
          local label = sightexports.sGui:createGuiElement("label", 0, y, pw, 24, paintshopRentWindow)
          sightexports.sGui:setLabelAlignment(label, "center", "center")
          sightexports.sGui:setLabelText(label, "vagy")
          sightexports.sGui:setLabelFont(label, "13/BebasNeueRegular.otf")
          y = y + 24
          local label = sightexports.sGui:createGuiElement("label", 0, y, pw, 32, paintshopRentWindow)
          sightexports.sGui:setLabelAlignment(label, "center", "center")
          sightexports.sGui:setLabelText(label, sightexports.sGui:thousandsStepper(1500) .. " PP / hét")
          sightexports.sGui:setLabelFont(label, "15/BebasNeueBold.otf")
          sightexports.sGui:setLabelColor(label, "sightblue")
          y = y + 32 + 8
          local bw = (pw - 16) / 2 - 4
          local btn = sightexports.sGui:createGuiElement("button", 8, y, bw, 30, paintshopRentWindow)
          sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
          sightexports.sGui:setGuiHover(
              btn,
              "gradient",
              {
                  "sightgreen",
                  "sightgreen-second"
              },
              false,
              true
          )
          sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
          sightexports.sGui:setButtonText(btn, "Bérlés ($)")
          sightexports.sGui:setClickEvent(btn, "rentPaintshopWithCash")
          local btn = sightexports.sGui:createGuiElement("button", 8 + bw + 8, y, bw, 30, paintshopRentWindow)
          sightexports.sGui:setGuiBackground(btn, "solid", "sightblue")
          sightexports.sGui:setGuiHover(
              btn,
              "gradient",
              {
                  "sightblue",
                  "sightblue-second"
              },
              false,
              true
          )
          sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
          sightexports.sGui:setButtonText(btn, "Bérlés (PP)")
          sightexports.sGui:setClickEvent(btn, "rentPaintshopWithPP")
          y = y + 30 + 8
          local btn = sightexports.sGui:createGuiElement("button", 8, y, pw - 16, 30, paintshopRentWindow)
          sightexports.sGui:setGuiBackground(btn, "solid", "sightred")
          sightexports.sGui:setGuiHover(
              btn,
              "gradient",
              {
                  "sightred",
                  "sightred-second"
              },
              false,
              true
          )
          sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
          sightexports.sGui:setButtonText(btn, "Mégsem")
          sightexports.sGui:setClickEvent(btn, "closePaintshopRentPanel")
      end
  end
end
addEvent("openPaintshopRentPanel", false)
addEventHandler("openPaintshopRentPanel", getRootElement(), openPaintshopRentPanel)
function createIntiBox(iconIn, text, text2, color, forRent, lock, manage)
  local was = false
  if interiorEnterGui then
      was = true
      sightexports.sGui:deleteGuiElement(interiorEnterGui)
  end
  interiorEnterGui = false
  if paintshopRentWindow then
      sightexports.sGui:deleteGuiElement(paintshopRentWindow)
  end
  paintshopRentWindow = false
  if iconIn then
      interiorEnterGui =
          sightexports.sGui:createGuiElement("rectangle", screenX / 2 - 150, screenY + 64, 300, 75)
      sightexports.sGui:setGuiBackground(interiorEnterGui, "solid", "sightgrey2")
      local rect = sightexports.sGui:createGuiElement("rectangle", 0, 0, 75, 75, interiorEnterGui)
      sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey1")
      local icon = sightexports.sGui:createGuiElement("image", 6, 10, 63, 59, interiorEnterGui)
      sightexports.sGui:setImageDDS(icon, sightexports.sMarkers:getCustomMarkerTexture(iconIn))
      sightexports.sGui:setImageColor(icon, color)
      local s = 5.079365079365079
      sightexports.sGui:setImageUV(icon, 0, 0, 320, 320 - 4 * s)
      local label = sightexports.sGui:createGuiElement("label", 87, 4, 0, 37.5, interiorEnterGui)
      sightexports.sGui:setLabelAlignment(label, "left", "center")
      sightexports.sGui:setLabelText(label, text)
      sightexports.sGui:setLabelFont(label, "16/BebasNeueBold.otf")
      sightexports.sGui:setLabelColor(label, color)
      local label2 = sightexports.sGui:createGuiElement("label", 87, 33.5, 0, 37.5, interiorEnterGui)
      sightexports.sGui:setLabelAlignment(label2, "left", "center")
      sightexports.sGui:setLabelText(label2, text2)
      sightexports.sGui:setLabelFont(label2, "16/BebasNeueRegular.otf")
      local w =
          math.max(sightexports.sGui:getLabelTextWidth(label), sightexports.sGui:getLabelTextWidth(label2))
      w = 87 + math.max(200, w) + 12
      local yMinus = false
      if forRent then
          local label = sightexports.sGui:createGuiElement("label", w / 2, -72, 0, 32, interiorEnterGui)
          sightexports.sGui:setLabelAlignment(label, "center", "center")
          sightexports.sGui:setLabelText(label, "Kiadó!")
          sightexports.sGui:setLabelColor(label, "sightgreen")
          sightexports.sGui:setLabelFont(label, "14/BebasNeueBold.otf")
          local text = false
          if loadedPaintshopLobby then
              text =
                  " Bérlés (" ..
                  sightexports.sGui:thousandsStepper(15000) ..
                      " $ / hét vagy " .. sightexports.sGui:thousandsStepper(1500) .. " PP / hét)"
          else
              text =
                  " Bérlés (" ..
                  sightexports.sGui:thousandsStepper(20000) ..
                      " $ / 2 hét vagy " .. sightexports.sGui:thousandsStepper(500) .. " PP / 2 hét)"
          end
          local bw =
              math.ceil((28 + sightexports.sGui:getTextWidthFont(text, "12/BebasNeueRegular.otf") + 4) / 2) * 2
          local btn = sightexports.sGui:createGuiElement("button", w / 2 - bw / 2, -36, bw, 28, interiorEnterGui)
          sightexports.sGui:setGuiBackground(btn, "solid", "sightgrey1")
          sightexports.sGui:setGuiHover(
              btn,
              "gradient",
              {
                  "sightgreen",
                  "sightgreen-second"
              },
              false,
              true
          )
          sightexports.sGui:setButtonFont(btn, "12/BebasNeueRegular.otf")
          sightexports.sGui:setButtonText(btn, text)
          sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("tags", 28))
          sightexports.sGui:setClickEvent(btn, "openPaintshopRentPanel")
          yMinus = 72
      elseif manage or lock then
          local manW = 0
          if manage then
              manW =
                  math.ceil(
                  (28 + sightexports.sGui:getTextWidthFont(" Albérlet kezelése", "12/BebasNeueRegular.otf") + 4) /
                      2
              ) *
                  2 +
                  8
          end
          local x = w / 2 - ((lock and 36 or 0) + manW) / 2
          local y = -36
          if manage then
              manW = manW - 8
              local btn = sightexports.sGui:createGuiElement("button", x, -36, manW, 28, interiorEnterGui)
              sightexports.sGui:setGuiBackground(btn, "solid", "sightgrey1")
              sightexports.sGui:setGuiHover(
                  btn,
                  "gradient",
                  {
                      "sightgreen",
                      "sightgreen-second"
                  },
                  false,
                  true
              )
              sightexports.sGui:setButtonFont(btn, "12/BebasNeueRegular.otf")
              sightexports.sGui:setButtonText(btn, " Albérlet kezelése")
              sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("tags", 28))
              sightexports.sGui:setClickEvent(btn, "openPaintshopRentPanel")
              x = x + manW + 8
          end
          if lock then
              local rect = sightexports.sGui:createGuiElement("rectangle", x, y, 28, 28, interiorEnterGui)
              sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey1")
              local icon = sightexports.sGui:createGuiElement("image", 2, 2, 24, 24, rect)
              sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("key", 24))
              sightexports.sGui:setGuiBoundingBox(icon, rect)
              sightexports.sGui:setGuiHoverable(icon, true)
              sightexports.sGui:setGuiHover(icon, "solid", "sightyellow")
              sightexports.sGui:setClickEvent(icon, "lockUnlockPaintshop")
              if loadedGaragesLobby then
                  if garagesRented[standingGarageEnter].locked then
                      sightexports.sGui:guiSetTooltip(icon, "Garázs kinyitása")
                  else
                      sightexports.sGui:guiSetTooltip(icon, "Garázs bezárása")
                  end
              elseif paintshopRented[standingPaintshopEnter].locked then
                  sightexports.sGui:guiSetTooltip(icon, "Műhely kinyitása")
              else
                  sightexports.sGui:guiSetTooltip(icon, "Műhely bezárása")
              end
          end
          yMinus = 36
      end
      yMinus = yMinus or 32
      local label = sightexports.sGui:createGuiElement("label", w / 2, 75, 0, 32, interiorEnterGui)
      sightexports.sGui:setLabelAlignment(label, "center", "center")
      sightexports.sGui:setLabelText(
          label,
          "Nyomj [E] gombot a " .. (forRent and "bérléshez" or "belépéshez") .. "."
      )
      sightexports.sGui:setLabelFont(label, "14/BebasNeueBold.otf")
      sightexports.sGui:setGuiSize(interiorEnterGui, w, 75)
      if was then
          sightexports.sGui:setGuiPosition(interiorEnterGui, screenX / 2 - w / 2, screenY - 128 - 64 - yMinus)
      else
          sightexports.sGui:setGuiPosition(interiorEnterGui, screenX / 2 - w / 2, screenY + yMinus)
          sightexports.sGui:setGuiPositionAnimated(
              interiorEnterGui,
              screenX / 2 - w / 2,
              screenY - 128 - 64 - yMinus,
              1000,
              false,
              "OutBounce"
          )
      end
  end
end
addEvent("playPaintshopDoorSound", true)
addEventHandler(
  "playPaintshopDoorSound",
  getRootElement(),
  function(id)
      if source == localPlayer then
          playSound(":sInteriors/files/door/" .. math.random(1, 4) .. ".mp3")
      elseif currentWorkshop == id then
          local sound =
              playSound3D(
              ":sInteriors/files/door/" .. math.random(1, 4) .. ".mp3",
              wsX - 4.36904,
              wsY + 16.4841,
              wsZ + 1
          )
          setElementInterior(sound, getElementInterior(localPlayer))
          setElementDimension(sound, getElementDimension(localPlayer))
      else
          local doorId, aisleId, insideId = getAisleFromWorkshop(id)
          if aisleId == loadedPaintshopLobby then
              local x, y, z, rz = unpack(aisleDoors[insideId])
              x = x + lobbyX
              y = y + lobbyY
              z = z + lobbyZ + 1
              local rad = math.rad(rz) - math.pi / 2
              x = x + math.cos(rad) * 1.254387 - math.sin(rad) * 4.62655
              y = y + math.sin(rad) * 1.254387 + math.cos(rad) * 4.62655
              local sound = playSound3D(":sInteriors/files/door/" .. math.random(1, 4) .. ".mp3", x, y, z)
              setElementInterior(sound, getElementInterior(localPlayer))
              setElementDimension(sound, getElementDimension(localPlayer))
          end
      end
  end
)
addEvent("playPaintshopLobbyGarageSound", true)
addEventHandler(
  "playPaintshopLobbyGarageSound",
  getRootElement(),
  function(id, gar)
      local match = false
      if gar then
          match = loadedGaragesLobby == id
      else
          match = loadedPaintshopLobby == id
      end
      if source == localPlayer or source == getPedOccupiedVehicle(localPlayer) then
          playSound(":sInteriors/files/garage.mp3")
      elseif match then
          local x, y, z = lobbyX, lobbyY, lobbyZ
          local rz = lobbyInsideDoor[4]
          x = x + lobbyInsideDoor[1]
          y = y + lobbyInsideDoor[2]
          z = z + lobbyInsideDoor[3]
          local r = math.rad(rz) + math.pi / 2
          x = x + 6.66073 * math.cos(r)
          y = y + 6.66073 * math.sin(r)
          z = z + 1
          local sound = playSound3D(":sInteriors/files/garage.mp3", x, y, z)
          setElementInterior(sound, getElementInterior(localPlayer))
          setElementDimension(sound, getElementDimension(localPlayer))
      else
          local doorId, aisle = getDoorFromAisle(id)
          if garageDoors[doorId] then
              local px, py, pz = getElementPosition(localPlayer)
              local x, y, z = garageDoors[doorId][1], garageDoors[doorId][2], garageDoors[doorId][3]
              if getDistanceBetweenPoints3D(px, py, pz, x, y, z) < 50 then
                  playSound3D(":sInteriors/files/garage.mp3", x, y, z)
              end
          end
      end
  end
)
