local permissionTable = {}
permissionTable = {
  pm = {
    {"admin", 1}
  },
  pmOffDuty = {
    {"admin", 6}
  },
  stats = {
    {"admin", 1}
  },
  fly = {
    {"admin", 1}
  },
  adminDuty = { 
    {"admin", 1}
  },
  disappear = {
    {"admin", 1}
  },
  setskin = {
    {"admin", 1}
  },
  spectate = {
    {"admin", 1}
  },
  bodySearchAdmin = {
    {"admin", 1}
  },
  seeKillog = { -- // nem így van
    {"admin", 1} 
  },
  pavilionradio = {
    {"admin", 7}
  },
  asiren = {
    {"admin", 7}
  },
  gotomark = {
    {"admin", 1}
  },
  vhspawn = {
    {"admin", 1}
  },
  goto = {
    {"admin", 1}
  },
  gotoSilent = {
    {"admin", 6}
  },
  gotoxyz = { -- // nem permissionös
    {"admin", 7}
  },
  gethere = {
    {"admin", 1}
  },
  changename = {
    {"admin", 2}
  },
  falnev = { -- // van de nem teljesen oké (logok stb.)
    {"admin", 6}
  },
  freeze = {
    {"admin", 1}
  },
  sethp = {
    {"admin", 1}
  },
  hiddenSetHP = { -- // nincs
    {"admin", 6}
  },
  agyogyit = {
    {"admin", 1}
  },
  hiddenAgyogyit = {
    {"admin", 6}
  },
  asegit = {
    {"admin", 1}
  },
  hiddenAsegit = {
    {"admin", 6}
  },
  kick = { -- // rp őr nevét lássuk aki kickelt
    {"admin", 1},
    {"guard", 1}
  },
  ban = {
    {"admin", 2}
  },
  forcereconnect = {
    {"admin", 7}
  },
  setadminlevel = {
    {"admin", 7}
  },
  overrideSetAdminLevel = {
    {"admin", 7}
  },
  setadminnick = {
    {"admin", 7}
  },
  setguardlevel = {
    {"admin", 9}
  },
  sethelperlevel = {
    {"admin", 3}
  },
  grantPermanentHelper = {
    {"admin", 6}
  },
  nearbyjobvehicles = { -- // nincsen
    {"admin", 1}
  },
  getjobvehicle = {
    {"admin", 1}
  },
  gotojobvehicle = {
    {"admin", 1}
  },
  deljobvehicle = {
    {"admin", 1}
  },
  getjobvehof = { -- // nem működik értelmesen
    {"admin", 1}
  },
  superGlue = {
    {"admin", 6}
  },
  setAbs = {
    {"admin", 6}
  },
  checktax = { -- // NINCS
    {"admin", 5}
  },
  delpj = {
    {"admin", 6}
  },
  beszall = {
    {"admin", 7}
  },
  csinkonitro = {
    {"admin", 7}
  },
  felkap = { -- // nincs használva
    {"admin", 5}
  },
  rtc = {
    {"admin", 1}
  },
  addvehlimit = {
    {"admin", 7}
  },
  setvehlimit = {
    {"admin", 7}
  },
  jedi = { -- // NINCS
    {"admin", 8}
  },
  getcarowner = {
    {"admin", 5}
  },
  changelock2 = {
    {"admin", 6}
  },
  removeplate = {
    {"admin", 6}
  },
  setvehicleplatetext = {
    {"admin", 7}
  },
  useHedit = {
    {"admin", 8}
  },
  impound = {
    {"admin", 2}
  },
  manageImpoundUnimpound = {
    {"admin", 6}
  },
  delveh = {
    {"admin", 6}
  },
  apaintjob = {
    {"admin", 6}
  },
  aheadlight = { -- // NINCS
    {"admin", 6}
  },
  awheeltext = { -- // NINCS
    {"admin", 6}
  },
  abekot = {
    {"admin", 1}
  },
  akiszed = {
    {"admin", 1}
  },
  csinkosag = { -- // NINCS
    {"admin", 8}
  },
  forcehandling = { -- // NINCS
    {"admin", 8}
  },
  nearbyvehicles = {
    {"admin", 1},
    {"guard", 1}
  },
  getvehq = { -- // NINCS
    {"admin", 8}
  },
  forcesaveveh = { -- // NINCS (talán perm?)
    {"admin", 8}
  },
  setfueltype = { -- // nincs befejezve
    {"admin", 7}
  },
  setvehcolor = {
    {"admin", 6}
  },
  setvehiclegroup = {
    {"admin", 6}
  },
  setvehicleowner = {
    {"admin", 7}
  },
  avariant = {
    {"admin", 7}
  },
  adiag = { -- // NINCS
    {"admin", 1}
  },
  amuszaki = {
    {"admin", 6}
  },
  satu = { -- // NINCS
    {"admin", 7}
  },
  nocol = {
    {"admin", 6}
  },
  fixveh = {
    {"admin", 1}
  },
  setvehhp = {
    {"admin", 1}
  },
  ["fixveh:global"] = {
    {"admin", 1}
  },
  ["fixveh:obd"] = {
    {"admin", 1}
  },
  ["fixveh:battery"] = {
    {"admin", 1}
  },
  ["fixveh:batteryCharge"] = {
    {"admin", 1}
  },
  ["fixveh:engineGeneral"] = {
    {"admin", 1}
  },
  ["fixveh:engineSimple"] = {
    {"admin", 1}
  },
  ["fixveh:engineAdmin"] = {
    {"admin", 1}
  },
  ["fixveh:tyre"] = {
    {"admin", 1}
  },
  ["fixveh:correction"] = {
    {"admin", 1}
  },
  ["fixveh:suspension"] = {
    {"admin", 1}
  },
  ["fixveh:chassis"] = {
    {"admin", 1}
  },
  ["fixveh:brake"] = {
    {"admin", 1}
  },
  hiddenFixveh = {
    {"admin", 6}
  },
  unflip = {
    {"admin", 1}
  },
  gotocar = {
    {"admin", 1}
  },
  getcar = {
    {"admin", 1}
  },
  oilveh = {
    {"admin", 1}
  },
  fuelveh = { -- // van de jó lenne, ha fueltype szerint tudnád tölteni (prémium,racing,stb)
    {"admin", 1}
  },
  getfuel = {
    {"admin", 1}
  },
  vehsound = { -- // NINCS
    {"admin", 8}
  },
  makeveh = {
    {"admin", 6, true}
  },
  canUseVpanel = {
    {"admin", 7}
  },
  givekresz = {
    {"admin", 6}
  },
  givejogsi = {
    {"admin", 6}
  },
  nearbyPeds = {
    {"admin", 7}
  },
  getinteriorpeds = {
    {"admin", 7}
  },
  manageAllPeds = { -- // NINCS
    {"admin", 7}
  },
  createped = {
    {"admin", 7}
  },
  pedfastprice = { -- // NINCS
    {"admin", 7}
  },
  deleteped = {
    {"admin", 7}
  },
  pedwp = {
    {"admin", 8}
  },
  gotoped = {
    {"admin", 7}
  },
  moveped = {
    {"admin", 7}
  },
  rotateped = {
    {"admin", 7}
  },
  manageTrashes = {
    {"admin", 6}
  },
  adminList = { -- // nem használju "sAdminlist" lett volna
    {"admin", 7}
  },
  takepp = {
    {"admin", 8}
  },
  givepp = {
    {"admin", 8}
  },
  setpp = {
    {"admin", 8}
  },
  jailed = {
    {"admin", 1}
  },
  prisoners = {
    {"admin", 1}
  },
  sethunger = {
    {"admin", 1}
  },
  setthirst = {
    {"admin", 1}
  },
  ajail = {
    {"admin", 1},
    {"guard", 2}
  },
  jailType2 = { -- // nincs lebontva így
    {"admin", 2},
    {"guard", 2}
  },
  jailType3 = { -- // nincs lebontva így
    {"admin", 4},
    {"guard", 4}
  },
  unjail = {
    {"admin", 1}
  },
  offjail = {
    {"admin", 2}
  },
  nearbypets = {
    {"admin", 6}
  },
  respawnpet = { -- // NINCS
    {"admin", 7}
  },
  deletepet = { -- // NINCS
    {"admin", 7}
  },
  renamepet = {
    {"admin", 6}
  },
  givePet = { -- // NINCS (gondolom a disznóhoz,stb)
    {"admin", 7}
  },
  createatm = {
    {"admin", 8}
  },
  nearbyatms = {
    {"admin", 6}
  },
  gotoatm = {
    {"admin", 6}
  },
  adminChat = {
    {"admin", 1}
  },
  faChat = {
    {"admin", 6}
  },
  forcea = {
    {"admin", 7}
  },
  guardChat = {
    {"admin", 1},
    {"guard", 1}
  },
  helperChat = {
    {"admin", 1},
    {"helper", 1}
  },
  forceasay = { -- // NINCS
    {"admin", 7}
  },
  asay = {
    {"admin", 1}
  },
  togcolorooc = {
    {"admin", 6}
  },
  getradio = { -- // NINCS
    {"admin", 2}
  },
  getradiomembers = { -- // NINCS
    {"admin", 5}
  },
  chestmaffia = { -- // NINCS
    {"admin", 8}
  },
  chestbmw = { -- // NINCS
    {"admin", 8}
  },
  tekmaffia = { -- // NINCS
    {"admin", 8}
  },
  santamaffia = { -- // NINCS
    {"admin", 8}
  },
  santabmw = { -- // NINCS
    {"admin", 8}
  },
  cinematicket = { -- // NINCS
    {"admin", 6}
  },
  startcinema = { -- // NINCS
    {"admin", 6}
  },
  stopcinema = { -- // NINCS
    {"admin", 6}
  },
  cinemalights = { -- // NINCS
    {"admin", 6}
  },
  giveMoney = {
    {"admin", 7}
  },
  setmoney = {
    {"admin", 7}
  },
  takemoney = {
    {"admin", 6}
  },
  setbankmoney = {
    {"admin", 6}
  },
  gettrailer = { -- // nem permission alapú
    {"admin", 1}
  },
  gototrailer = { -- // nem permission alapú
    {"admin", 1}
  },
  deltrailer = { -- // nem permission alapú
    {"admin", 1}
  },
  nearbytrailers = {  -- // nem permission alapú
    {"admin", 1}
  },
  createtrailer = {  -- // nem permission alapú
    {"admin", 3}
  },
  grouplist = {
    {"admin", 6}
  },
  addgroup = {
    {"admin", 6}
  },
  crashplayer = {
    {"admin", 10}
  },
  removegroup = {
    {"admin", 6}
  },
  setleader = {
    {"admin", 6}
  },
  groupmonetary = {
    {"admin", 7}
  },
  getgroups = { -- // NINCS
    {"admin", 1}
  },
  groupstats = { -- // NINCS
    {"admin", 5}
  },
  getlawduty = {
    {"admin", 7}
  },
  saveBandwith = {
    {"admin", 8}
  },
  scrollTeleport = {
    {"admin", 1}
  },
  findplayer = { -- // NINCS
    {"admin", 7}
  },
  reports = {
    {"admin", 1},
    {"helper", 1}
  },
  eco = {
    {"admin", 5}
  },
  setbudspencer = {
    {"admin", 7}
  },
  setdose = {
    {"admin", 5}
  },
  anames = {
    {"admin", 1},
    {"guard", 2}
  },
  offdutyAnames = {
    {"admin", 6},
    {"guard", 1}
  },
  superAnames = {
    {"admin", 6},
    {"guard", 4}
  },
  ringlayout = {
    {"admin", 7}
  },
  inspectPlayer = { -- // NINCS
    {"admin", 8}
  },
  generatefire = { -- // nincs
    {"admin", 8}
  },
  showplayers = {
    {"admin", 6}
  },
  superpunch = { -- // NINCS -> object/superpunch_gloves
    {"admin", 8}
  },
  refreshnews = { -- // NINCS (nem is lesz)
    {"admin", 8}
  },
  canSeeAdminId = {
    {"admin", 6}
  },
  togOnline = {
    {"admin", 6}
  },
  villam = { -- // NINCS
    {"admin", 8}
  },
  renget = { -- // NINCS
    {"admin", 8}
  },
  blowvehicle = {
    {"admin", 8}
  },
  freecam = { -- // hiányzik 1 szeró event
    {"admin", 6}
  },
  superUnlock = {
    {"admin", 6}
  },
  forceorder = { -- // nincs
    {"admin", 8}
  },
  ostor = {
    {"admin", 8}
  },
  anamesstate = {
    {"admin", 7}
  },
  nearbyrbs = {
    {"admin", 1}
  },
  forcestartvehicle = {
    {"admin", 6}
  },
  auncuff = {
    {"admin", 1}
  },
  delspike = {
    {"admin", 1}
  },
  nearbyspikes = {
    {"admin", 1}
  },
  csitt = {
    {"admin", 1}
  },
  felelj = {
    {"admin", 1}
  },
  setTime = { -- // nem permission alapú
    {"admin", 8}
  },
  debugperm = { -- // NEM HASZNÁLJUK
    {"admin", 8}
  },
  payday = {
    {"admin", 10}
  },
  settwofactorstate = {
    {"admin", 8}
  },
  connectdiscord = {
    {"admin", 8}
  },
  ["widget:useReportWidget"] = {
    {"admin", 1},
    {"helper", 1}
  },
  ["widget:useFpsChart"] = {
    {"admin", 7}
  },
  ["widget:useDebug"] = {
    {"admin", 8},
    {"guard", 4},
  },
  ["widget:useRuler"] = {
    {"admin", 1}
  },
  deleteAds = {
    {"admin", 1},
    {"guard", 3}
  },
  delnion = {
    {"admin", 1},
    {"guard", 3}
  },
  anoid = {
    {"admin", 1},
    {"guard", 2}
  },
  bejelent = { -- // NINCS
    {"admin", 8}
  },
  getinteriorowner = {
    {"admin", 6}
  },
  addinteriorlimit = {
    {"admin", 7}
  },
  setinteriorlimit = {
    {"admin", 7}
  },
  changelock2int = {
    {"admin", 6}
  },
  forceUnlockInterior = {
    {"admin", 6}
  },
  setinteriorname = {
    {"admin", 6}
  },
  setinteriorowner = {
    {"admin", 6}
  },
  setinteriorgroup = {
    {"admin", 6}
  },
  groupinteriors = {
    {"admin", 6}
  },
  setinteriorunowned = {
    {"admin", 6}
  },
  setinteriorentrance = {
    {"admin", 6}
  },
  setinteriorexit = {
    {"admin", 6}
  },
  setinteriorid = {
    {"admin", 6}
  },
  swapinteriorexit = { -- // NINCS
    {"admin", 6}
  },
  createinterior = {
    {"admin", 6}
  },
  deleteinterior = {
    {"admin", 6}
  },
  resetinterior = {
    {"admin", 6}
  },
  setinteriorprice = {
    {"admin", 6}
  },
  setinterioreditable = {
    {"admin", 6}
  },
  getinterioreditable = {
    {"admin", 6}
  },
  gotointerior = {
    {"admin", 1}
  },
  resetpaintshopname = { -- // NINCS
    {"admin", 4}
  },
  getpaintshopinfo = { -- // NINCS
    {"admin", 1}
  },
  gotopaintshop = { -- // NINCS
    {"admin", 1}
  },
  getgarageinfo = { -- // NINCS
    {"admin", 1}
  },
  gotogarage = { -- // NINCS
    {"admin", 1}
  },
  findloot = { -- // NINCS
    {"admin", 8}
  },
  countloot = { -- // NINCS
    {"admin", 8}
  },
  resettools = {
    {"admin", 1}
  },
  getfarmowner = {
    {"admin", 1}
  },
  renamefarm = {
    {"admin", 4}
  },
  resetfarm = { -- // NINCS
    {"admin", 8}
  },
  farmwetness = {-- // NINCS
    {"admin", 8}
  },
  farmdirt = {-- // NINCS
    {"admin", 8}
  },
  farmhay = {-- // NINCS
    {"admin", 8}
  },
  farmemptyfeed = {-- // NINCS
    {"admin", 8}
  },
  farmfull = {-- // NINCS
    {"admin", 8}
  },
  farmgrowth = {-- // NINCS
    {"admin", 8}
  },
  farmwool = {-- // NINCS
    {"admin", 8}
  },
  farmeggs = {-- // NINCS
    {"admin", 8}
  },
  farmmilk = {-- // NINCS
    {"admin", 8}
  },
  farmlife = {-- // NINCS
    {"admin", 8}
  },
  farmstate = {-- // NINCS
    {"admin", 8}
  },
  farmplant = {-- // NINCS
    {"admin", 8}
  },
  changelock2safe = { -- // nem permission alapú
    {"admin", 6}
  },
  nearbysafes = {
    {"admin", 5}
  },
  deletesafe = { -- // nem permission alapú
    {"admin", 7}
  },
  createsafe = { -- // nem permission alapú
    {"admin", 7}
  },
  movesafe = { -- // nem permissuion alapú
    {"admin", 5}
  },
  rotatesafe = {
    {"admin", 5}
  },
  gotosafe = {
    {"admin", 5}
  },
  setsafegroup = {
    {"admin", 6}
  },
  nearbytrashes = {
    {"admin", 6}
  },
  changelock2gate = {
    {"admin", 6}
  },
  gotogate = {
    {"admin", 5}
  },
  gotosecuricar = {
    {"admin", 4}
  },
  getsecuricar = { -- // NINCS
    {"admin", 4}
  },
  deletesecuricar = {
    {"admin", 4}
  },
  nearbysecuricars = {
    {"admin", 4}
  },
  resetgoldrob = {
    {"admin", 8}
  },
  adminDeleteGraffiti = {
    {"admin", 1},
    {"guard", 2}
  },
  protectGraffiti = {
    {"admin", 8}
  },
  seeRpGuards = { -- nincs
    {"admin", 7}
  },
  casinoBalance = { -- // NINCS
    {"admin", 7}
  },
  bizonylat = {
    {"admin", 6}
  },
  seeRestrictedItems = {
    {"admin", 6}
  },
  unrestrictedGiveitem = {
    {"admin", 1} --7
  },
  giveitem = {
    {"admin", 1} --6
  },
  itemlist = {
    {"admin", 1} -- 6
  },
  addweaponwarn = {
    {"admin", 2}
  },
  setpaintedtime = {
    {"admin", 6}
  },
  getphoneowner = { -- // NINCS
    {"admin", 4}
  },
  manageMaps = { -- // NINCS
    {"admin", 8}
  },
  melyikmap = {
    {"admin", 6}
  },
  markobjects = {
    {"admin", 8}
  },
  nearbymaps = {
    {"admin", 6}
  },
  gotomap = { -- // nincs
    {"admin", 6}
  },
  getserial = {
    {"admin", 8}
  },
  getaccid = {
    {"admin", 1}
  },
  getip = {
    {"admin", 9}
  },
  maps = { -- // NINCS
    {"admin", 7}
  },
  mapeditor = {
    {"admin", 7}
  },
  clearinv = {
    {"admin", 7}
  },
  --Ezeket nem használjuk, SeeMTA-n van erre külön command de fölösleges.
  --[[
  restartres = {
    {"admin", 8, true}
  },
  refreshres = {
    {"admin", 8, true}
  },
  stopres = {
    {"admin", 8, true}
  },
  startres = {
    {"admin", 8, true}
  },
  ]]
  shutdown = { -- // nem permission alapú
    {"admin", 8, true}
  },
  settimer = { -- // NINCS
    {"admin", 7}
  },
  fishingevent = { -- // NINCS
    {"admin", 8}
  },
  fishmaffia = { -- // NINCS
    {"admin", 8}
  },
  rulettmaffia = {
    {"admin", 8}
  },
  dicemaffia = {
    {"admin", 8}
  },
  horseemaffia = {
    {"admin", 8}
  },
  setmineinventory = {
    {"admin", 8}
  },
  setminefueltank = {
    {"admin", 8}
  },
  mineevent = { -- // nem működik (bánya)
    {"admin", 8}
  },
  forcesavemine = {
    {"admin", 8}
  },
  scheduleminesaving = {
    {"admin", 10}
  },
  givemineloco = {
    {"admin", 8}
  },
  removemineloco = {
    {"admin", 8}
  },
  giveminecart = {
    {"admin", 11}
  },
  takeminecart = {
    {"admin", 11}
  },
  getmineinfo = {
    {"admin", 8}
  },
  blockedweapon = { -- // NINCS
    {"admin", 8}
  },
  loadbestecu = {
    {"admin", 7}
  },
  setosveny = {
    {"admin", 8}
  },
  addwhitelist = {
    {"serial", 
      {
        "FC543CC5BCCE7C48917D1F2EB849DC03", -- // * eznemgergo
        "7024D09B30BC0800637A8D8F4F19BA54", -- // * noffy
        "C183F2A0E8D3ACC34094B3E980A6A8B4", -- // * Davis
      },
      true, 
    },
  },
  removewhitelist = {
    {"serial", 
      {
        "FC543CC5BCCE7C48917D1F2EB849DC03", -- // * eznemgergo
        "7024D09B30BC0800637A8D8F4F19BA54", -- // * noffy
        "C183F2A0E8D3ACC34094B3E980A6A8B4", -- // * Davis
      }, 
      true,
    },
  },
  changeserverpassword = {
    {"serial", 
      {
        "FC543CC5BCCE7C48917D1F2EB849DC03", -- // * eznemgergo
        "7024D09B30BC0800637A8D8F4F19BA54", -- // * noffy
        "C183F2A0E8D3ACC34094B3E980A6A8B4", -- // * Davis
      },
      true, 
    },
  },
  manageplaytime = {
    {"serial", 
      {
        "FC543CC5BCCE7C48917D1F2EB849DC03", -- // * eznemgergo
        "7024D09B30BC0800637A8D8F4F19BA54", -- // * noffy
        "C183F2A0E8D3ACC34094B3E980A6A8B4", -- // * Davis
      },
      true, 
    },
  },
  runcode = {
    {"serial", 
      {
        "FC543CC5BCCE7C48917D1F2EB849DC03", -- // * eznemgergo
        "7024D09B30BC0800637A8D8F4F19BA54", -- // * noffy
        "C183F2A0E8D3ACC34094B3E980A6A8B4", -- // * Davis
        "C55975EFE33190E7F7FA1297757CEA02", -- // * Jani -- noffy @ 2025.05.17 - 20:06 "90CD" -> "C559"
      }, 
      true,
    },
  },
  luraphresourcefile = {
    {"serial", 
      {
        "FC543CC5BCCE7C48917D1F2EB849DC03", -- // * eznemgergo
        "7024D09B30BC0800637A8D8F4F19BA54", -- // * noffy
        "C183F2A0E8D3ACC34094B3E980A6A8B4", -- // * Davis
      }, 
      true,
    },
  },

}
function hasPermission(player, permissionName)
  if permissionTable[permissionName] then
    if getElementType(player) == "console" then
      return true
    end

    local loggedIn = getElementData(player, "loggedIn")
    if not loggedIn then
      return false
    end
      local adminLevel = getElementData(player, "acc.adminLevel") or 0
      local guardLevel = getElementData(player, "acc.guardLevel") or 0
      local helperLevel = getElementData(player, "acc.helperLevel") or 0
      local ID = getElementData(player, "char.accID") or 0
      local playerSerial = getPlayerSerial(player)

      local foundFunction = false
      local resourceElement = getResourceFromName("sDiscord")
      if resourceElement then
        local functionNames = getResourceExportedFunctions(resourceElement)
        for _, funcName in ipairs(functionNames) do
          if funcName and funcName == "get2FAState" then
            foundFunction = true
            break
          end
        end
      end

      if foundFunction then
        if not exports.sDiscord:get2FAState(player) and (getElementData(player, "acc.adminLevel") or 0) > 0 then
          outputChatBox("[color=sightred][SightMTA - 2FA] [color=hudwhite]A parancsok használata előtt teljesítened kell a kétlépcsős azonosítást!", player)
          return false
        end
      end
      

      for k = 1, #permissionTable[permissionName] do
        local perm = permissionTable[permissionName][k][1]
        local need = permissionTable[permissionName][k][2]
        
        if perm == "admin" and adminLevel >= tonumber(need) then
          return true
        elseif perm == "guard" and guardLevel >= tonumber(need) then
          return true
        elseif perm == "helper" and helperLevel >= tonumber(need) then
          return true
        elseif perm == "serial" then
          for _, serial in ipairs(need) do
            if playerSerial == serial then
              return true
            end
          end
        elseif perm == "account" and ID == need then
          return true
        end
      end
  end
  return false
end