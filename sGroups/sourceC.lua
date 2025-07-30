  local sightexports = {
  sPermission = false,
  sDashboard = false,
  sGui = false,
  sMarkers = false,
  sItems = false
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
local function sightlangProcessResWaiters()
  if not sightlangWaiterState0 then
    local res0 = getResourceFromName("sMarkers")
    if res0 and getResourceState(res0) == "running" then
      createDutyMarkers()
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
local screenX, screenY = guiGetScreenSize()
addCommandHandler("grouplist", function()
  if sightexports.sPermission:hasPermission(localPlayer, "grouplist") then
    outputChatBox("[color=sightgreen][SightMTA - Frakció]: #ffffffFrakciólista:", 255, 255, 255, true)
    for prefix, data in pairs(groupList) do
      outputChatBox("   [color=sightgreen]" .. prefix .. "#ffffff - " .. data.name, 255, 255, 255, true)
    end
  end
end)
local playerPermissions = {}
local playerInteriors = {}
local playerVehicles = {}
local playerGates = {}
local playerMembership = {}
local groupMessagePrefixDisable = {}
function playRadioSound()
  playSoundFrontEnd(47)
  setTimer(playSoundFrontEnd, 700, 1, 48)
  setTimer(playSoundFrontEnd, 800, 1, 48)
end
addEvent("playWalkieTalkieSound", true)
addEventHandler("playWalkieTalkieSound", getRootElement(), playRadioSound)
local togd2 = true
function setD2State(state)
  togd2 = state
end
function getD2State()
  return togd2
end
local togairfield = true
function setAirfieldState(state)
  togairfield = state
end
function getAirfieldState()
  return togairfield
end
local toggroupmsg = true
function getTogGroupMsg()
  return toggroupmsg
end
function setTogGroupMsg(val)
  toggroupmsg = val
end
addCommandHandler("togd2", function()
  togd2 = not togd2
  sightexports.sDashboard:saveValue("d2State", togd2)
  outputChatBox("[color=sightblue][SightMTA - D2]: " .. (togd2 and "[color=sightgreen]Bekapcsoltad" or "[color=sightred]Kikapcsoltad") .. "#FFFFFF a másodlagos sürgősségi rádiót.", 255, 255, 255, true)
end)
addCommandHandler("toglegter", function()
  togairfield = not togairfield
  sightexports.sDashboard:saveValue("airfieldState", togairfield)
  outputChatBox("[color=sightblue][SightMTA - Légtér]: " .. (togairfield and "[color=sightgreen]Bekapcsoltad" or "[color=sightred]Kikapcsoltad") .. "#FFFFFF a légtér értesítéseket.", 255, 255, 255, true)
end)
addCommandHandler("toggroupmsg", function()
  toggroupmsg = not toggroupmsg
  sightexports.sDashboard:saveValue("toggroupmsg", toggroupmsg)
  outputChatBox("[color=sightblue][SightMTA - Frakció]: " .. (toggroupmsg and "[color=sightgreen]Bekapcsoltad" or "[color=sightred]Kikapcsoltad") .. "#FFFFFF a frakció üzeneteket és hangokat.", 255, 255, 255, true)
end)
function sendGroupMessage(group, color, prefix, message, sound)
  if not toggroupmsg then
    return
  end
  if group == "department" then
    for i = 1, #departmentGroups do
      if playerMembership[departmentGroups[i]] then
        outputChatBox(message, 222, 53, 84, true)
        if sound then
          if sound == "gta" then
            playRadioSound()
          else
            playSound("files/" .. sound)
          end
        end
        return
      end
    end
  elseif group == "department2" then
    if togd2 then
      for i = 1, #departmentGroups do
        if playerMembership[departmentGroups[i]] then
          local col = sightexports.sGui:getColorCode("sightred-second")
          outputChatBox(message, col[1], col[2], col[3], true)
          if sound then
            if sound == "gta" then
              playRadioSound()
            else
              playSound("files/" .. sound)
            end
          end
          return
        end
      end
    end
  elseif group == "department_airfield" then
    if togairfield then
      for i = 1, #departmentGroups do
        if playerMembership[departmentGroups[i]] then
          local col = sightexports.sGui:getColorCode("sightred-second")
          outputChatBox(message, col[1], col[2], col[3], true)
          if sound then
            if sound == "gta" then
              playRadioSound()
            else
              playSound("files/" .. sound)
            end
          end
          return
        end
      end
    end
  elseif playerMembership[group] and not groupMessagePrefixDisable[prefix] then
    outputChatBox("[color=sight" .. color .. "][SightMTA - " .. prefix .. "]: #ffffff" .. message, 255, 255, 255, true)
    if sound then
      if sound == "gta" then
        playRadioSound()
      else
        playSound("files/" .. sound)
      end
    end
  end
end
addEvent("gotGroupMessage", true)
addEventHandler("gotGroupMessage", getRootElement(), sendGroupMessage)
function getTogTraffi()
  return not groupMessagePrefixDisable.Traffipax
end
function setTogTraffi(val)
  groupMessagePrefixDisable.Traffipax = not val
end
addCommandHandler("togtraffi", function()
  groupMessagePrefixDisable.Traffipax = not groupMessagePrefixDisable.Traffipax
  outputChatBox("[color=sightblue][SightMTA - Traffipax]: #ffffffTraffipax üzenetek [color=sight" .. (groupMessagePrefixDisable.Traffipax and "red]kikapcsolva" or "green]bekapcsolva") .. "#ffffff.", 255, 255, 255, true)
  sightexports.sDashboard:saveValue("togtraffi", not groupMessagePrefixDisable.Traffipax)
end)
addEvent("gotPlayerGroupMembership", true)
addEventHandler("gotPlayerGroupMembership", getRootElement(), function(membership)
  playerMembership = {}
  for i = 1, #membership do
    playerMembership[membership[i]] = true
  end
end, true, "high+9999999999")
function getPlayerGroupMembership()
  return playerMembership
end
function isPlayerInGroup(prefix)
  return playerMembership[prefix]
end
function isPlayerInLawEnforcement(excludeGroups)
  for i = 1, #lawEnforcementGroups do
    if playerMembership[lawEnforcementGroups[i]] and (not excludeGroups or not excludeGroups[lawEnforcementGroups[i]]) then
      return lawEnforcementGroups[i]
    end
  end
  return false
end
addEvent("gotPlayerGroupPermissions", true)
addEventHandler("gotPlayerGroupPermissions", getRootElement(), function(permissions)
  playerPermissions = permissions
end, true, "high+9999999999")
addEvent("gotPlayerGroupInteriors", true)
addEventHandler("gotPlayerGroupInteriors", getRootElement(), function(interiors)
  playerInteriors = interiors
end, true, "high+9999999999")
addEvent("gotPlayerGroupVehicles", true)
addEventHandler("gotPlayerGroupVehicles", getRootElement(), function(vehicles)
  playerVehicles = vehicles
end, true, "high+9999999999")
addEvent("gotPlayerGroupGates", true)
addEventHandler("gotPlayerGroupGates", getRootElement(), function(gates)
  playerGates = gates
end, true, "high+9999999999")
function getPlayerPermission(permission)
  return playerPermissions[permission] and playerPermissions[permission][1]
end
function getPlayerPermissionInGroup(prefix, permission)
  if playerPermissions[permission] then
    for i = 1, #playerPermissions[permission] do
      if playerPermissions[permission][i] == prefix then
        return true
      end
    end
  end
  return false
end
function getPlayerInterior(interior)
  return playerInteriors[interior]
end
function getPlayerVehicle(vehicle)
  return playerVehicles[vehicle]
end
function getPlayerGate(gate)
  return playerGates[gate]
end
if getElementData(localPlayer, "loggedIn") then
  triggerServerEvent("requestPlayerPermissions", localPlayer)
end
local groupSkins = {}
local skinIntegrity = {
  PD1 = "1C63AAEF4971B06DCB4BBE8B2882E55D4A724D30F5A631629E7F41C408F07AB6",
  PD2 = "79D32004F8B899326BBA2E6D68A27BA8473450807EBB9EB637409807D8C8757A",
  PD3 = "B4A144875263AFFE5D3439B8D9EEF93BF5D0291AA81B45BAFD68924E5410D754",
  PD4 = "A513BEE189D8C89D37B3E0103ABA07AE13BA4A4B4E13EDFDF8C9B38B30E4A85D",
  PD5 = "DA35C81E133D0ADDB07240EAF22028C8910AF8A58C55751DF36E61A75281E2B1",
  PD6 = "CB136851732DA32D81905FEA595FA287CE70BDD9E0F878838EB5075048BFCFDD",
  PD7 = "F74C02511644E68A383D00B5D0587FF8FCD2AA7F26FC2000A7561A0A4F744A59",
  PF1 = "A5CE3E3D10A37FFC7A7535CD224528020D45D16021D3C2861340E849A0931FD1",
  PF2 = "BF82BDEFDD03554AF5B89BFEB6C044974B9F4CB28849EFD9A4BBB16FE9D15A4A",
  PF3 = "58E045C7471CF448CE25DE18EC40A58D8717342AD0F5CD38D5B79684E2B3A63F",
  PF4 = "B81FD8439E64D15326C307ED722EE6C8AFA16630E3497EF00A977E7441865CB5",
  ARMY1 = "F831515B57ED690A077A5FE6FCACCFCC6A1DB2BABE2A9BA61ABD26CA96058A3F",
  ARMY2 = "4E554F868ECB0ADB8C7C79A8E6E0A330B201D660C5C76C59C330F716175D3A85",
  ARMY3 = "54B7042CD4A2EBF73479FBCAA896A10BD4113759DA4332975A05DB1FF4F32106",
  ARMY4 = "E53E900CDE6D05224F995B4CABD08CEAD4C60C280DA3473CCC26EBE21D25EB53",
  ARMY5 = "7D8B3699AEB01C45F5D22764D33EFE7DE6314E688234A7325CBBA5359FA2AB15",
  ARMY6 = "E5C532085C630F47CFDF150A5EA81B1DCC95E8946015B928912E448500CBF9BF",
  ARMY7 = "3B248008CD59340A90200EBA3034831982A786191DE574CAAC7E16157C3112C9",
  MAFTESZT1 = "903299EA0BF34D843A4199459BC74ABE13BCF37BF1C7C0927C7E064EB17909F7",
  MAFTESZT2 = "24ECD4E32A3ED7CD89957134D34531C1816C816D6AB582733D938B57978DC18E",
  MAFTESZT3 = "624D24EB85D5C57CED6289B88F5DF326276695D5D2BDB74CCFBAF199612E262E",
  OMSZ1 = "602A5D3EB30BF3C8E97D59FDC57B6BBC9293A9043AF0DFEC9CCAE3E601FBD28A",
  OMSZ2 = "7B375280C55BA940196AD9B59C86ACDA9D429772CE06DC9C11F8084673063060",
  OMSZ3 = "EA858CFBCF1F6A967212C195A47A1A7C70884683F8F46B1EDED29D7D9FEAA0C6",
  OMSZ4 = "B9F01D69A6B9445B463943261C93817F579CA26E4723BD62E6C92A2C1E792731",
  OMSZ5 = "BF96B79DF84D338A9642EE662F13F529B5B00D310EA4F0A40BF1FDE8AB6DA251",
  OMSZ6 = "4D62F64B47DA5A7D795CAE650E69CB73DA2F6CCBACFE67441D0B7C3E0C75BB56",
  OMSZ7 = "8EBB11039CC065AB30E0796BD81329BDC5493FBEAADE684EBE5B281678107A31",
  NAV1 = "7D1A1C0CF22E67072926A74FEF25A7669AF86224CD5475F01C3F01085FADF5BA",
  NAV2 = "BB7E70F6713C40894A8DB4BAFB5AD21AF4A3278C1E589E8EAC98B494569B8C6E",
  NAV3 = "60DD947C9A069AF3219DA2E1D3D2A672B5341C84558BAACEE83F980B19D9510E",
  NAV4 = "2EDA47B9498A848D3531CD37FA1E1020248C0D758AB2799B8F6FC71F48263263",
  NAV5 = "F2FCD38FF3B45CDE4FE330B8FECF6314B31BAD1C0340754A253A42AF411AEBDF",
  NAV6 = "92773CADA65EB8CD82E60CC89412688094CC7CD537A22F4060127925C75E5A20",
  NAV7 = "B0DB8A826241A8F245BBA0A2C7E9451ECA2C61A65DFC7CD0EF6E9C439EE981FB",
  BMS1 = "47E4613B335C8090C617B1EBF12F90955CA2BB7097426B2FF6FB1BF99CD930E6",
  BMS2 = "2C3782AC6AB9F790D20C12D12121C7C4CE1A5D0FDD81453362E06DD0EABD6F1E",
  BMS3 = "200E1B70C5F4D6AA0A817AD22DA6E51AFF7E5DD8B1FB654F8D003286B7C50EA7",
  BMS4 = "69775B0D2BEBADFE3BE91DF64AFD30F159353CD69CCAED1AEC3E36DEF56EFF89",
  BMS5 = "CAF7F093909B0EAED63EABA4F19672E66FE63ED0CCC4C9B5A31331A1A0F4DF00",
  BMS6 = "5A42187E3DFA91DEC7FD6021390868726727575F289F9CB409CE7DB0D8A84927",
  FIX1 = "47E4613B335C8090C617B1EBF12F90955CA2BB7097426B2FF6FB1BF99CD930E6",
  FIX2 = "1B1E49AFA2DE3C7D068690F23FDE8B5133DBDD0BE7441C9FCB9DD51B65774476",
  FIX3 = "619D2568E7F8673DF9A07604B3CAEB8E05EDAB8C956BEC9CE46218445BC20EC9",
  FIX4 = "83ED230BD8BB94D7B1631AE6F853E6AF76DD4EF382F8532662D8459CE1F40C33",
  FIX5 = "B47AD2C1602CDFF0D8F193444AC66B241ADBC6B85F0A9BBF42B44A8C6AF5BFCA",
  SOD1 = "1A6362743B28B6D63F4A4225C46A8F995F866BC3BFA18743986ED499FDDD83FF",
  SOD2 = "BF1447DB60D7EB07CDB59D1DD9E876DB18D1E87291DD41F531C625EC2319565B",
  SOD3 = "439F5C6874E1EBB917E752B45D038401EC5220A8D8814517A5918B496C0ABD95",
  SOD4 = "A58D8E24C577F8FDD491F5B7AF781EA98FE7F707B0E6041F0AE89F73928200FA",
  SOD5 = "083B8C2DCA01DEAADE836F6003AEC5DEB109598A20E9B66B5502C611AE78D465",
  SOD6 = "3C529B36E0F22E4E37C95F631295F5E3CBD94DD89F43C80219864C7D6000F913",
  SOD7 = "D0EFFB1CD9E8F342A8BBF557F4D0FDA6A08AB0F701F6B78F0FB12DD2CECEBDA1",
  LM1 = "7CD12EECD4847CE465A40980F49F3DA2FA0D11328689B55EDCACDCC092DEAB1B",
  LM2 = "85E6577D7ED5D19B88732F490ED9CAA07DDB74F8F49565475A81083B0E902E38",
  LM3 = "6682D3253F23989BE30827621B3B344B726F1B6340C840F485A5FA4C024A70E3",
  LM4 = "16EE2134C8BDCC090F11E40A2C04795D9E41E805F22BBAD3A0B1B7CEE9A64E39",
  LM5 = "F109679FC1D1EAA6EC73DD644CBC1DAA73597CD88B2FFE7BAEC1AF69ED2F2D37",
  LM6 = "BD0FFB9F009497B9643304299771A9147A8067E9B73FFBD2B8FCAA8B5D539B54",
  LM7 = "7D9FA3F9602DFB96E38F44E624C1F9B2414368FFD56EC83D8C66D62E994554D4",
  DV1 = "250B8F71E32137A3C38304307EB4E2AE7ED29FC10046E62A7F9AF28A221FBEDE",
  DV2 = "F373D20136BA7353584AD7FDCBEA79A3BE4074FE83731976265956BD7F0DD471",
  DV3 = "A435EF8A953C868ED0C3403D9B4211C9B544A9BFB73EB417F5E88CE3D5E5139F",
  Dsight = "DBD20A041C5E175E04C6606EB85DD8AE3762211A4455E4D9AFAFF29598298C1D",
  DV5 = "E3E8743772E0F22E8FFB530F2E66AC49163C46F51BE4CA31063331B82960DE75",
  DV6 = "8D5BFE3C6C76CCD95F21E6CB25795A0A419858D688B6C97871DA7945532D31FC",
  DV7 = "866A333B55919D9A6EE8A644F3EB54552DE1801AB05F00D54D5530D2D21EC0C9",
  CNC1 = "C4666655C233A14C6313036792AFCA7646726FA27B10F23DBE220AE65F743BEE",
  CNC2 = "C926F8E2F740D62D39ABA3033FAB76E980EA5E8ED800FDF8A4FED836021EE5A8",
  CNC3 = "8B249F94A14FA072B5DBA721C630ABD901360A1FED7741C14B4D19910663EDF7",
  CNC4 = "FFEF5CE9A57F741ADF7554E72E8C16438EFF2EFD24F3D60FB3C9FC036CB76D11",
  CNC5 = "7E606295D73E3F5EF3494E1D0E653DC080E01A314B081270C601783208576747",
  CNC6 = "1FC10694FE88F2F8A51265BA8567FC97B404ACD42A7789157EC2C417DE71A130",
  CNC7 = "F6B0797AA617F74CEEB69F03444F54CF2968879746642286C59FF2B657084B7D",
  NSM1 = "91CB0873E4ED0A4D5E3B244327DC6B9160AA418B3EB43E5E50968CBB9DBB5640",
  NSM2 = "934AF5FA40ECCA76F0DD1A2F0C96906C34870224CAFF7BFEF805228B8091659C",
  NSM3 = "7CB95902BABF05A7EBFCFCC1FA45362364667EEB0DA830D327A7A4451205A4C4",
  NSM4 = "4515D9D12C36EC543F1DBC9A30054E54FE197004A8A1F3EE062A88D9ED192140",
  NSM5 = "5F19B7D615D9847B3F015F5EE89B6BEDD1EB0550AA6F470E1B6241A4D1405D73",
  NSM6 = "B0C66B3B92D4A5F4F051AFAAF468718E010BC197FCBBA97B7400C12EDCBEE783",
  NSM7 = "D84CD2F9994943EDE7D91AD253BDC6C6AAD2C4513CFEE9B1302B509F7B23EE2B",
  OV1 = "C9E177BA83D02FBCE0FB31639016C91E45416E7E3A98EE1FBD0468B244F91987",
  OV2 = "EBEEE5C282AA2CC841499362DFF6678B944566A54C396C15F71EE24DE61AF2CE",
  OV3 = "B393926F41DDF2F09629C33A320415FDDC389E8F91F99AB9EE28117FA3039C47",
  OV4 = "EBDDE8FBAE358E627FA72F5F45D473E57625FE2AB6675BFC583B19FE471C0C9A",
  OV5 = "9F30988F2B856EB8C5C29F41C67891C0DE9F5DBF8C0009DC1C6B199A7A18907D",
  OV6 = "18DE9A1FA72722A93F7040D08D727E39CD076118D16E3917309A6EB9BDDBA416",
  OV7 = "2A2BF513F93BC426B59317AB860E025E35B660DDF1E62D4AAB9DACAEFD0517DD",
  ROB1 = "C0ACCD183639C936D593E944A61B42787BF226EF0A84AE982AD220E48D254C5C",
  ROB2 = "4F9D34C4F80DF08CFB4273AAA789DD64A3DF9930AC45F2720DAB00D3E52753DA",
  ROB3 = "D8EB5BDD923B1B8DBB054A84EF6788D121345646871694B56F1DD1EBFF8501C5",
  ROB4 = "85462F9AD76F0339BC3DC294B2ADE34AD8D75812F2EF7847345588DF8AC02BDA",
  ROB5 = "19D21B4A0CD46BFEF821C59EE718276CEDF223986AC8CA714FFEC8AC532DBF62",
  ROB6 = "E01862B43A5B09ABFA028BA9C7CE013101789503B1634C656C6465529698362E",
  ROB7 = "FF0FFE97FFA70EFCE1B6DF4A9AA7E93DB459A73470B1A89A13D38822C28A0B0F",
  NDR1 = "F22ECADAFA31BCE9BDC25C5CD0A408706F1AFDB4D3803E1138D0F6F92F2882B4",
  NDR2 = "59F42B9EAF44E682136696C17B3BF3B41C011FDB65377742F11C0F8A14D6C315",
  NDR3 = "B33F79E231D8CC61BDC21C7931E97A67EEC78729ED81A17B61E8F2E9085E1140",
  NDR4 = "64589CA9AAE77E9A50BE3B73E61E95095E8997107EA8D14B5F60E4FB00BF8B87",
  NDR5 = "DE9ACC5E49D7BE7CE0959B7272D3CEA7C06EBE0A2BE9D53E558755E6F3C1964F",
  NDR6 = "588EDAA210624E041A2C0CDA3E0E2D9351B7E94F212E869353DBE9D562F8236E",
  NDR7 = "36D9FC394DB046A505369E4DED1EC7216B20421A5A043A332D150F58399B3017",
  TEK1 = "23ADBF5C051AEE7BF7C6364F33067AB8D06DC49B923AC630DA57586A8290FF3C",
  TEK2 = "C66885F5AE32B5529745BCF2D7879D38315C3335E777A05008526368E944CA7B",
  TEK3 = "92813A2F7DE0CAC94EA92FC1B9A406530437928014C469401B3ACE6AF5ABEA7F",
  TEK4 = "46019D7D27B5AB8312CCE2A7141F2A5295627AADB54C67EF8511E039C505B510",
  TEK5 = "17183E494C3E08F611578B411599882044B8526CCB3AC689FCAC5E5FD44FBFFD",
  NNI1 = "90D7D0FD57CD30C3110698D3BE9299342D3D630A0F0D86D130C2B050AB1117C1",
  NNI2 = "FE502C7F42FF9631EB57223A9CF9B3127F2CEB51FF30CACB59131504F034D63A",
  NNI3 = "8146A790386B4E359674F1EA3FFDC843D180482CB2DFB444FD1EB9C69952AE6A",
  NNI4 = "6BCACDA313EFFDB546F4A99959B4397E698D7B00E32C6E694408C226DA434DC8",
  NNI5 = "2DCD9D091D9E175466E95EBAB0D501B87CEF64CDF2F52D8345FDE9448A681FEE",
  NNI6 = "65AD1C3819D70391F83ACA2C25A952416294AB4FCE577309AE853195449CD426",
  NNI7 = "DD1075879F14837DCD061A4F26DD9981431CFC17280796B981D3FF3298FEABEF",
  SG1 = "1A088957DB00EB078707FAE880C496FC9B42E76E511753C510AD80B3BBF2022B",
  SG2 = "C42187B6365B202D60F30B2519F2FD224F804FE1C94242F05BDA5E054D29F4D7",
  SG3 = "9E5B35FCB33B14284D1A11DAE95D3A61033B07494174564F71A47C91BC002A91",
  SG4 = "22B1F383214E09128C9776207B06CC27F1E2C0BDFC5760BF54E23994669105D8",
  SG5 = "D9DE8FABFB824631E3169F572B276A4FADFC219824F8677DF6251E8E17860E68",
  SG6 = "C8DF7E56B5CEEB0ADCEE247CC046CE94660F4E0E0A7F4D8B882FDEEBA51E345C",
  SG7 = "5180C676A07AF96CB305D1ABA1C89BA6E8E4A30C9B853E77F881F19DDBCF2348",
  SG8 = "3C70AB102DEC8D3A128AFA1E5E7DCDA0016CC1734E34C21A8033E0077717AD98",
  SG9 = "42A6F28D2ABFA153652FC7CD93F8242FB0E77D4F4E9FADFEF9C3B91874405397",
  SG10 = "EE5B695240944453B2A1913CFDDE00AC005D29302ED1A9247B8B315BA8390889",
  SG11 = "6D8CFDE7502FC7768F323F050D75F3CA004825FC4150E7076D3C83DEFB498F9B",
  SG12 = "BC2ABE1C8369855A7D8073E579F6525CD218A76E1A60F0C8F1CAA1A65AC91AF3",
  SG13 = "0AF87EBBEDA63E1075E59C2383E7933A78B6A7A4E0E6BA8E2F2E05E75F16D42E",
  SG14 = "06AD1A3EFCEE4BE1F010FD9E4C6F25467DA3C229A080A2C97F9552EB21FCCFB5",
  SG15 = "C74E611BE3DB825E22BBFF46CA60681372E274E9065E48344D016D36498A9CEA",
  SG16 = "A7C6FCE1D98FEEBA883FF14DFB655EC5034BCDFADD3C700AE8399752D8FAF541",
  SG17 = "3014A000A7FB548E34898BEFD1B340915159DFFDD650B297A07D75F83ED8FAED",
  SG18 = "A35FA29237004E6A680860AF7B576A6A3F13D00F1BCA695FF2A82FE02D8A61E2",
  SG19 = "F6D4D5B1860B56458FB883C6BC12B5F6AC4FB19813E427B5042C45EB8D879D78",
  SG20 = "204AC7C98FB3E4C30642D39E24B089BBEF25E4698BF11A09C6F67D08E2963FB7",
  SG21 = "FDBA52580E504EED33FC1A9091BE10DD68C4C9F5ED4AF2F1E065A860F5BE874C",
  OKF1 = "2BACE91B2D4D097B3E9761F7A8B4EEE217CC2449B8471212E6C1DD990E5156EE",
  OKF2 = "5E773737C09DE72A92C5288D384CD4EC370FF49E2C575E8A20E4C2F2D428830F",
  OKF3 = "56660B4622726347B46D3054A9A9FC4F4599CB190431D9762F704B2974555890",
  OKF4 = "6F05F9B4D7946AFC211C979E76B2B4F253F5912B1248CFB6BF6E962A2A08A851",
  OKF5 = "5E773737C09DE72A92C5288D384CD4EC370FF49E2C575E8A20E4C2F2D428830F",
  OKF6 = "5CAD64D802BC86EE9476CE7A863EA5C8FC65E5E34A9B2A2D25AB82F4A661A8A3",
  OKF7 = "9AD40C9799B8C0808959DD3242F6F0F52B6D60DCD633ED97ACE060A4C336CD2C",
  APMS1 = "B9964A92803B9C4B39D229CA41ADD30A602CA1E69E3A091454812BF27039848A",
  APMS2 = "57EFF147C5E72F4C890BA8AD7491592C2CCF4ECBB4CD6353D5A93C5E897920B0",
  APMS3 = "6C22B2FEB648507EBE22E9E2EA071C3B7FCA045715E27DC8C6E1B63D78C25293",
  APMS4 = "F62FB0D2D186E26461C30674B00E4EC44FFD4DC5B16B7C4FA57A52320CE6CAC0"
}
function getGroupSkinId(group)
  return groupSkins[group]
end
local dutySkinCache = {}
local dutySkinForceOff = {}
function setDutySkinForceOff(client, data)
  dutySkinForceOff[client] = data
end
function processPlayerGroupSkin(client, data)
  data = data or dutySkinCache[client] or getElementData(client, "groupSkin") or getElementData(client, "permGroupSkin")
  dutySkinCache[client] = data
  if dutySkinForceOff[client] then
    return
  end
  if data and groupSkins[data] then
    setElementModel(client, groupSkins[data])
  else
    if getElementData(client, "char.skin") then
      setElementModel(client, getElementData(client, "char.skin"))
    end
  end
end
addEventHandler("onClientElementDataChange", getRootElement(), function(data, old, new)
  if data == "groupSkin" or data == "permGroupSkin" then
    dutySkinCache[source] = nil
    if isElementStreamedIn(source) then
      processPlayerGroupSkin(source, new)
    end
  end
end)
addEventHandler("onClientPlayerStreamIn", getRootElement(), function()
  processPlayerGroupSkin(source)
end)
addEventHandler("onClientPlayerSpawn", getRootElement(), function()
  if isElementStreamedIn(source) then
    processPlayerGroupSkin(source)
  end
end)
addEventHandler("onClientPlayerQuit", getRootElement(), function()
  dutySkinCache[source] = nil
  dutySkinForceOff[source] = nil
end)
addEventHandler("onClientResourceStop", getResourceRootElement(), function()
  for prefix, data in pairs(groupList) do
    if data.dutyPoses and data.dutyMarkers then
      for i = 1, #data.dutyPoses do
        if data.dutyMarkers[i] then
          sightexports.sMarkers:deleteCustomMarker(data.dutyMarkers[i])
        end
      end
    end
  end
end)
function countGroupSkins()
  local c = 0
  for prefix, data in pairs(groupList) do
    c = c + data.skins
  end
  return c
end
function loadAGroupSkin()
  for prefix, data in pairs(groupList) do
    if data.skins then
      for i = 1, data.skins do
        if not groupSkins[prefix .. i] then
          local skin = engineRequestModel("ped")
          if fileExists("files/skins/" .. prefix .. "/" .. i .. ".dff") then
            local file = fileOpen("files/skins/" .. prefix .. "/" .. i .. ".dff")
            if file then
              local content = fileRead(file, fileGetSize(file))
              local hash = sha256(content)
              local txd = engineLoadTXD("files/skins/" .. prefix .. "/" .. i .. ".txd")
              engineImportTXD(txd, skin)
              local dff = engineLoadDFF(content)
              engineReplaceModel(dff, skin)
              content = nil
              hash = nil
              collectgarbage("collect")
              fileClose(file)
            end
          end
          groupSkins[prefix .. i] = skin
          return true
        end
      end
    end
  end
  return false
end

if getElementData(localPlayer, "loggedIn") then
  while true do
    if not loadAGroupSkin() then
      break
    end
  end
end
function createDutyMarkers()
  for prefix, data in pairs(groupList) do
    if data.dutyPoses then
      groupList[prefix].dutyMarkers = {}
      for i = 1, #data.dutyPoses do
        groupList[prefix].dutyMarkers[i] = sightexports.sMarkers:createCustomMarker(data.dutyPoses[i][1], data.dutyPoses[i][2], data.dutyPoses[i][3], data.dutyPoses[i][4], data.dutyPoses[i][5], "sightgreen", "duty", {
          "Szolgálat:",
          data.name
        }, {"sightgreen", "#ffffff"})
        sightexports.sMarkers:setCustomMarkerInterior(groupList[prefix].dutyMarkers[i], "duty", prefix, 1.5)
      end
    end
  end
end
addEventHandler("onClientResourceStart", getResourceRootElement(), function()
  local players = getElementsByType("player", getRootElement(), true)
  for i = 1, #players do
    processPlayerGroupSkin(players[i])
  end
end)
resetVehiclesLODDistance()
local dutyGroup = false
local dutyWindow = false
local dutyItems = {}
local dutySkins = {}
local currentAmounts = {}
local dutySkinElements = {}
local dutyItemElements = {}
local selectedDutySkin = false
function deleteDutyWindow()
  if dutyWindow then
    sightexports.sGui:deleteGuiElement(dutyWindow)
  end
  dutyWindow = false
  dutyItemElements = {}
  dutySkinElements = {}
  dutyItems = {}
  dutySkins = {}
  currentAmounts = {}
  dutyGroup = false
  processDutyMarkerGui()
end
addEvent("closeGroupDutyWindow", false)
addEventHandler("closeGroupDutyWindow", getRootElement(), deleteDutyWindow)
function processDutyItems()
  for id, dat in pairs(dutyItemElements) do
    local amount = currentAmounts[id] or 0
    local img = dat[1]
    sightexports.sGui:setImageColor(img, {
      255,
      255,
      255,
      0 < amount and 255 or 150
    })
    local label = dat[2]
    sightexports.sGui:setLabelColor(label, 0 < amount and "#ffffff" or "sightmidgrey")
    local label = dat[3]
    sightexports.sGui:setLabelText(label, amount)
    sightexports.sGui:setLabelColor(label, 0 < amount and "#ffffff" or "sightmidgrey")
    local btn = dat[4]
    sightexports.sGui:setGuiRenderDisabled(btn, amount <= 0)
    local btn = dat[5]
    sightexports.sGui:setGuiRenderDisabled(btn, amount >= dutyItems[id])
  end
end
addEvent("plusDutyItemAmount", false)
addEventHandler("plusDutyItemAmount", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  for id, dat in pairs(dutyItemElements) do
    if dat[5] == el then
      local amount = currentAmounts[id] or 0
      if amount < dutyItems[id] then
        currentAmounts[id] = math.min(dutyItems[id], amount + math.max(1, math.floor(dutyItems[id] * 0.1)))
        processDutyItems()
      end
      break
    end
  end
end)
addEvent("minusDutyItemAmount", false)
addEventHandler("minusDutyItemAmount", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  for id, dat in pairs(dutyItemElements) do
    if dat[4] == el then
      local amount = currentAmounts[id] or 0
      if 0 < amount then
        currentAmounts[id] = math.max(0, amount - math.max(1, math.floor(dutyItems[id] * 0.1)))
        processDutyItems()
      end
      break
    end
  end
end)
function processDutySkins()
  for skin, dat in pairs(dutySkinElements) do
    if selectedDutySkin == skin then
      sightexports.sGui:setCheckboxChecked(dat[1], true)
      sightexports.sGui:setLabelColor(dat[2], "#ffffff")
    else
      sightexports.sGui:setCheckboxChecked(dat[1], false)
      sightexports.sGui:setLabelColor(dat[2], "sightmidgrey")
    end
  end
end
addEvent("selectDutySkin", false)
addEventHandler("selectDutySkin", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  for skin, dat in pairs(dutySkinElements) do
    if dat[1] == el then
      if selectedDutySkin == skin then
        selectedDutySkin = false
        break
      end
      selectedDutySkin = skin
      break
    end
  end
  processDutySkins()
end)
local currentDutyMarker = false
addEvent("gotDutyData", true)
addEventHandler("gotDutyData", getRootElement(), function(group, skins, items)
  if group == currentDutyMarker then
    dutyGroup = group
    dutySkins = skins
    dutyItems = items
    selectedDutySkin = false
    currentAmounts = {}
    if fileExists(dutyGroup .. ".duty") then
      local file = fileOpen(dutyGroup .. ".duty")
      if file then
        local data = fileRead(file, fileGetSize(file))
        local dat = split(data, ";")
        local skin = tonumber(dat[1]) or 0
        if 0 < skin then
          for i = 1, #skins do
            if skins[i] == skin then
              selectedDutySkin = skin
            end
          end
        end
        table.remove(dat, 1)
        for i = 1, #dat, 2 do
          local item = tonumber(dat[i])
          local amount = tonumber(dat[i + 1])
          if item and amount and 0 < amount and items[item] then
            currentAmounts[item] = math.min(items[item], amount)
          end
        end
        dat = nil
        data = nil
        collectgarbage("collect")
        fileClose(file)
      end
    end
    createDutyWindow()
  end
end)
local lastDuty = 0
addEvent("groupDutySound", true)
addEventHandler("groupDutySound", getRootElement(), function(dutyInOut)
  if isElement(source) and isElementStreamedIn(source) then
    local x, y, z = getElementPosition(source)
    local sound = false
    if dutyInOut then
      sound = playSound3D("files/dutyin.wav", x, y, z)
    else
      sound = playSound3D("files/dutyout.wav", x, y, z)
    end
    setElementInterior(sound, getElementInterior(source))
    setElementDimension(sound, getElementDimension(source))
    attachElements(sound, source)
    if source == localPlayer then
      lastDuty = getTickCount()
    end
  end
end)
addEvent("tryToGroupDuty", false)
addEventHandler("tryToGroupDuty", getRootElement(), function()
  if dutyGroup then
    for id, amount in pairs(currentAmounts) do
      if amount <= 0 then
        currentAmounts[id] = nil
      end
    end
    if fileExists(dutyGroup .. ".duty") then
      fileDelete(dutyGroup .. ".duty")
    end
    local file = fileCreate(dutyGroup .. ".duty")
    if file then
      fileWrite(file, (selectedDutySkin or 0) .. ";")
      for id, amount in pairs(currentAmounts) do
        if 0 < amount then
          fileWrite(file, id .. ";")
          fileWrite(file, amount .. ";")
        end
      end
      fileClose(file)
    end
    if getTickCount() - lastDuty < 60000 then
      sightexports.sGui:showInfobox("e", "Percenként csak egyszer dutyzhatsz be!")
      return
    end
    triggerServerEvent("tryToGroupDuty", localPlayer, dutyGroup, selectedDutySkin, currentAmounts)
  end
  deleteDutyWindow()
end)
function createDutyWindow()
  if dutyWindow then
    sightexports.sGui:deleteGuiElement(dutyWindow)
  end
  dutyItemElements = {}
  dutySkinElements = {}
  local titleBarHeight = sightexports.sGui:getTitleBarHeight()
  local sh = 32
  local ih = sh * 4
  local itemCount = 0
  for id, max in pairs(dutyItems) do
    if 0 < max then
      itemCount = itemCount + 1
    end
  end
  local w = 175
  local sx = (w * math.min(7, 1 + itemCount)) * 0.7
  local sy = (math.max(sh * #dutySkins, ih * math.ceil(itemCount / 6))) * 0.7
  local tempy = 0
  if 0 < #dutySkins then
    for i = 1, #dutySkins do
      tempy = titleBarHeight + sh
    end
  end
  if sy + titleBarHeight + 32 < sy + titleBarHeight + 32 + tempy then
    sy = sy + titleBarHeight + 32 + tempy
  else
    sy = sy + titleBarHeight + 32
  end
  dutyWindow = sightexports.sGui:createGuiElement("window", screenX / 2 - sx / 2, screenY / 2 - sy / 2, sx, sy)
  sightexports.sGui:setWindowTitle(dutyWindow, "16/BebasNeueRegular.otf", "Szolgálat: " .. dutyGroup)
  sightexports.sGui:setWindowCloseButton(dutyWindow, "closeGroupDutyWindow")
  local y = titleBarHeight
  if 0 < #dutySkins then
    for i = 1, #dutySkins do
      local rect = sightexports.sGui:createGuiElement("rectangle", 0, y, w, sh, dutyWindow)
      sightexports.sGui:setGuiBackground(rect, "solid", {
        0,
        0,
        0,
        0
      })
      local checkbox = sightexports.sGui:createGuiElement("checkbox", 2, y + 2, sh - 4, sh - 4, dutyWindow)
      sightexports.sGui:setGuiColorScheme(checkbox, "darker")
      sightexports.sGui:setGuiBoundingBox(checkbox, rect)
      sightexports.sGui:setClickEvent(checkbox, "selectDutySkin")
      local label = sightexports.sGui:createGuiElement("label", sh + 2, y, w - sh - 2, sh, dutyWindow)
      sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
      sightexports.sGui:setLabelAlignment(label, "left", "center")
      if groupList[currentDutyMarker].dutySkinNames then
        sightexports.sGui:setLabelText(label, groupList[currentDutyMarker].dutySkinNames[dutySkins[i]] or "Duty skin " .. dutySkins[i])
      else
        sightexports.sGui:setLabelText(label, "Duty skin " .. dutySkins[i])
      end
      dutySkinElements[dutySkins[i]] = {checkbox, label}
      y = y + sh
    end
    processDutySkins()
  end
  local x = (w + 4) * 0.7
  local n = sx / w - 1
  w = ((sx - w - n * 2) / n) * 0.7
  ih = (ih - n * 2 / n) * 0.7
  local y = titleBarHeight + 4
  local i = 0
  for id, max in pairs(dutyItems) do
    if 0 < max then
      dutyItemElements[id] = {}
      i = i + 1
      local j = (i - 1) % 6
      local rect = sightexports.sGui:createGuiElement("rectangle", x + 4 + w * j, y + 4, w - 8, ih - 8, dutyWindow)
      sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey1")
      local rect = sightexports.sGui:createGuiElement("rectangle", x + 4 + w * j, y + 4, w - 8 - 2, ih - 8 - 2, dutyWindow)
      sightexports.sGui:setGuiBackground(rect, "gradient", {"sightgrey3", "sightgrey2"})
      local w = w - 8 - 2
      local h = ih - 8 - 2
      local img = sightexports.sGui:createGuiElement("image", w / 2 - 18, 8, 36, 36, rect)
      sightexports.sGui:setImageFile(img, ":sItems/" .. sightexports.sItems:getItemPic(id))
      dutyItemElements[id][1] = img
      h = h - 36 - 8
      local name = sightexports.sItems:getItemName(id)
      local label = sightexports.sGui:createGuiElement("label", 0, 44, w, h / 2, rect)
      sightexports.sGui:setLabelFont(label, "8/Ubuntu-B.ttf")
      sightexports.sGui:setLabelAlignment(label, "center", "center")
      sightexports.sGui:setLabelText(label, name)
      dutyItemElements[id][2] = label
      if sightexports.sGui:getLabelTextWidth(label) > w - 16 then
        for c = utf8.len(name), 1, -1 do
          sightexports.sGui:setLabelText(label, utf8.sub(name, 1, c) .. "...")
          if sightexports.sGui:getLabelTextWidth(label) < w - 16 then
            break
          end
        end
      end
      local label = sightexports.sGui:createGuiElement("label", 0, 44 + h / 2, w, h / 2, rect)
      sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
      sightexports.sGui:setLabelAlignment(label, "center", "center")
      dutyItemElements[id][3] = label
      local btn = sightexports.sGui:createGuiElement("button", w / 2 - 32 - 16, 44 + h / 2 + h / 4 - 8, 16, 16, rect)
      sightexports.sGui:setGuiBackground(btn, "solid", "sightgrey1")
      sightexports.sGui:setGuiHover(btn, "gradient", {"sightgrey2", "sightgrey1"}, false, true)
      sightexports.sGui:setButtonFont(btn, "8/BebasNeueRegular.otf")
      sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("minus", 16))
      sightexports.sGui:setClickEvent(btn, "minusDutyItemAmount")
      dutyItemElements[id][4] = btn
      local btn = sightexports.sGui:createGuiElement("button", w / 2 + 32, 44 + h / 2 + h / 4 - 8, 16, 16, rect)
      sightexports.sGui:setGuiBackground(btn, "solid", "sightgrey1")
      sightexports.sGui:setGuiHover(btn, "gradient", {"sightgrey2", "sightgrey1"}, false, true)
      sightexports.sGui:setButtonFont(btn, "8/BebasNeueRegular.otf")
      sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("plus", 16))
      sightexports.sGui:setClickEvent(btn, "plusDutyItemAmount")
      dutyItemElements[id][5] = btn
      if i % 6 == 0 then
        y = y + ih
      end
    end
  end
  processDutyItems()
  w = math.min(175, w or 0)
  local border = sightexports.sGui:createGuiElement("hr", 0, titleBarHeight + sy - titleBarHeight - 32 - 1, sx, 2, dutyWindow)
  local border = sightexports.sGui:createGuiElement("hr", w - 1, titleBarHeight, 2, sy - titleBarHeight - 32, dutyWindow)
  local btn = sightexports.sGui:createGuiElement("button", sx - 128 - 4, sy - 16 - 12, 128, 24, dutyWindow)
  sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
  sightexports.sGui:setGuiHover(btn, "gradient", {
    "sightgreen",
    "sightgreen-second"
  }, false, true)
  sightexports.sGui:setButtonFont(btn, "12/BebasNeueRegular.otf")
  sightexports.sGui:setButtonText(btn, "Szolgálatba állás")
  sightexports.sGui:setClickEvent(btn, "tryToGroupDuty")
  processDutyMarkerGui()
end
addEvent("changeEnteredCustomMarker", false)
addEventHandler("changeEnteredCustomMarker", getRootElement(), function(theType, id)
  if dutyWindow then
    deleteDutyWindow()
  end
  if theType == "duty" then
    currentDutyMarker = id
    processDutyMarkerGui()
  elseif currentDutyMarker then
    currentDutyMarker = false
    processDutyMarkerGui()
  end
end)
bindKey("e", "up", function()
  if currentDutyMarker and not dutyWindow then
    triggerServerEvent("requestMyDutyData", localPlayer, currentDutyMarker)
  end
end)
local dutyMarkerGui = false
function processDutyMarkerGui()
  if currentDutyMarker and not dutyWindow then
    if not dutyMarkerGui then
      dutyMarkerGui = sightexports.sGui:createGuiElement("rectangle", screenX / 2, screenY + 64, 100, 75)
      sightexports.sGui:setGuiBackground(dutyMarkerGui, "solid", "sightgrey2")
      local rect = sightexports.sGui:createGuiElement("rectangle", 0, 0, 75, 75, dutyMarkerGui)
      sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey1")
      local icon = sightexports.sGui:createGuiElement("image", 6, 10, 63, 59, dutyMarkerGui)
      sightexports.sGui:setImageDDS(icon, sightexports.sMarkers:getCustomMarkerTexture("duty"))
      local s = 5.079365079365079
      sightexports.sGui:setImageUV(icon, 0, 0, 320, 320 - 4 * s)
      sightexports.sGui:setImageColor(icon, "sightgreen")
      local label = sightexports.sGui:createGuiElement("label", 87, 4, 0, 37.5, dutyMarkerGui)
      sightexports.sGui:setLabelAlignment(label, "left", "center")
      sightexports.sGui:setLabelText(label, "Szolgálat")
      sightexports.sGui:setLabelFont(label, "16/BebasNeueBold.otf")
      sightexports.sGui:setLabelColor(label, "sightgreen")
      local label2 = sightexports.sGui:createGuiElement("label", 87, 33.5, 0, 37.5, dutyMarkerGui)
      sightexports.sGui:setLabelAlignment(label2, "left", "center")
      sightexports.sGui:setLabelText(label2, groupList[currentDutyMarker].name)
      sightexports.sGui:setLabelFont(label2, "16/BebasNeueRegular.otf")
      local w = math.max(sightexports.sGui:getLabelTextWidth(label), sightexports.sGui:getLabelTextWidth(label2))
      w = math.max(200, w) + 72 + 24
      sightexports.sGui:setGuiSize(dutyMarkerGui, w, 75)
      local label = sightexports.sGui:createGuiElement("label", w / 2, 75, 0, 32, dutyMarkerGui)
      sightexports.sGui:setLabelAlignment(label, "center", "center")
      sightexports.sGui:setLabelText(label, "Nyomj [E] gombot a használathoz.")
      sightexports.sGui:setLabelFont(label, "14/BebasNeueBold.otf")
      sightexports.sGui:setGuiPosition(dutyMarkerGui, screenX / 2 - w / 2, screenY + 32)
      sightexports.sGui:setGuiPositionAnimated(dutyMarkerGui, screenX / 2 - w / 2, screenY - 128 - 64 - 32, 1000, false, "OutBounce")
    end
  else
    if dutyMarkerGui then
      sightexports.sGui:deleteGuiElement(dutyMarkerGui)
    end
    dutyMarkerGui = false
  end
end
local aidInputs = false
local taxInputs = false
local editedInputs = {}
local saveButton = false
local monetaryWindow = false
addEvent("closeGroupMonetaryWindow", false)
addEventHandler("closeGroupMonetaryWindow", getRootElement(), function()
  aidInputs = {}
  taxInputs = {}
  saveButton = false
  if monetaryWindow then
    sightexports.sGui:deleteGuiElement(monetaryWindow)
  end
  monetaryWindow = nil
end)
addEvent("groupMonetaryChange", true)
addEventHandler("groupMonetaryChange", getRootElement(), function(value, el)
  if aidInputs[el] then
    sightexports.sGui:setInputColor(el, "sightblue", "sightgrey2", "sightgrey4", "sightblue", "sightlightgrey")
    editedInputs[el] = true
    sightexports.sGui:setGuiRenderDisabled(saveButton, false)
  elseif taxInputs[el] then
    sightexports.sGui:setInputColor(el, "sightblue", "sightgrey2", "sightgrey4", "sightblue", "sightlightgrey")
    editedInputs[el] = true
    sightexports.sGui:setGuiRenderDisabled(saveButton, false)
  end
end)
addEvent("saveGroupMonetary", true)
addEventHandler("saveGroupMonetary", getRootElement(), function(value, el)
  local data = {}
  for el in pairs(editedInputs) do
    local val = tonumber(sightexports.sGui:getInputValue(el)) or 0
    if 0 <= val then
      if aidInputs[el] then
        table.insert(data, {
          aidInputs[el],
          "aid",
          val
        })
      elseif taxInputs[el] then
        table.insert(data, {
          taxInputs[el],
          "tax",
          val
        })
      end
    end
  end
  if 0 < #data then
    sightexports.sGui:showInfobox("i", "Mentés folyamatban...")
    sightexports.sGui:setGuiRenderDisabled(saveButton, true)
    triggerServerEvent("saveGroupMonetary", localPlayer, data)
  end
end)
addEvent("groupMonetary", true)
addEventHandler("groupMonetary", getRootElement(), function(datas)
  aidInputs = {}
  taxInputs = {}
  editedInputs = {}
  saveButton = false
  if monetaryWindow then
    sightexports.sGui:deleteGuiElement(monetaryWindow)
  end
  monetaryWindow = nil
  local titleBarHeight = sightexports.sGui:getTitleBarHeight()
  local sx = 800
  local sy = titleBarHeight + 24 * (1 + #datas) + 8 + 24 + 4
  monetaryWindow = sightexports.sGui:createGuiElement("window", screenX / 2 - sx / 2, screenY / 2 - sy / 2, sx, sy)
  sightexports.sGui:setWindowTitle(monetaryWindow, "16/BebasNeueRegular.otf", "Frakció pénzügyek")
  sightexports.sGui:setWindowCloseButton(monetaryWindow, "closeGroupMonetaryWindow")
  local y = titleBarHeight + 4
  local w = (sx - 8) / 4
  local label = sightexports.sGui:createGuiElement("label", 4, y, w, 22, monetaryWindow)
  sightexports.sGui:setLabelFont(label, "10/Ubuntu-B.ttf")
  sightexports.sGui:setLabelAlignment(label, "center", "center")
  sightexports.sGui:setLabelClip(label, true)
  sightexports.sGui:setLabelText(label, "Frakció")
  local label = sightexports.sGui:createGuiElement("label", 4 + w, y, w, 22, monetaryWindow)
  sightexports.sGui:setLabelFont(label, "10/Ubuntu-B.ttf")
  sightexports.sGui:setLabelAlignment(label, "center", "center")
  sightexports.sGui:setLabelText(label, "Egyenleg")
  local label = sightexports.sGui:createGuiElement("label", 4 + w * 2, y, w, 22, monetaryWindow)
  sightexports.sGui:setLabelFont(label, "10/Ubuntu-B.ttf")
  sightexports.sGui:setLabelAlignment(label, "center", "center")
  sightexports.sGui:setLabelText(label, "Támogatás (/tag/óra)")
  local label = sightexports.sGui:createGuiElement("label", 4 + w * 3, y, w, 22, monetaryWindow)
  sightexports.sGui:setLabelFont(label, "10/Ubuntu-B.ttf")
  sightexports.sGui:setLabelAlignment(label, "center", "center")
  sightexports.sGui:setLabelText(label, "Adó (/óra)")
  local border = sightexports.sGui:createGuiElement("hr", 4, y + 24 - 2, sx - 8, 2, monetaryWindow)
  for i = 1, 3 do
    local border = sightexports.sGui:createGuiElement("hr", 4 + w * i - 1, y, 2, sy - titleBarHeight - 8 - 24 - 4, monetaryWindow)
  end
  y = y + 24
  for i = 1, #datas do
    local prefix = datas[i][1]
    local label = sightexports.sGui:createGuiElement("label", 4, y, w, 22, monetaryWindow)
    sightexports.sGui:setLabelFont(label, "10/Ubuntu-B.ttf")
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    sightexports.sGui:setLabelClip(label, true)
    sightexports.sGui:setLabelText(label, prefix .. " (" .. groupList[prefix].name .. ")")
    local label = sightexports.sGui:createGuiElement("label", 4 + w, y, w, 22, monetaryWindow)
    sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
    sightexports.sGui:setLabelAlignment(label, "center", "center")
    sightexports.sGui:setLabelColor(label, datas[i][2] < 0 and "sightred" or "sightgreen")
    sightexports.sGui:setLabelText(label, sightexports.sGui:thousandsStepper(datas[i][2]) .. " $")
    local input = sightexports.sGui:createGuiElement("input", 4 + w * 2, y, w, 24, monetaryWindow)
    sightexports.sGui:setInputPlaceholder(input, "Összeg")
    sightexports.sGui:setInputValue(input, datas[i][3])
    sightexports.sGui:setInputMaxLength(input, 32)
    sightexports.sGui:setInputNumberOnly(input, true)
    sightexports.sGui:setInputChangeEvent(input, "groupMonetaryChange")
    aidInputs[input] = prefix
    local input = sightexports.sGui:createGuiElement("input", 4 + w * 3, y, w, 24, monetaryWindow)
    sightexports.sGui:setInputPlaceholder(input, "Összeg")
    sightexports.sGui:setInputValue(input, datas[i][4])
    sightexports.sGui:setInputMaxLength(input, 32)
    sightexports.sGui:setInputNumberOnly(input, true)
    sightexports.sGui:setInputChangeEvent(input, "groupMonetaryChange")
    taxInputs[input] = prefix
    local border = sightexports.sGui:createGuiElement("hr", 4, y + 24 - 2, sx - 8, 2, monetaryWindow)
    y = y + 24
  end
  for el in pairs(aidInputs) do
    sightexports.sGui:guiToFront(el)
  end
  for el in pairs(taxInputs) do
    sightexports.sGui:guiToFront(el)
  end
  saveButton = sightexports.sGui:createGuiElement("button", sx - 4 - 100, y + 4, 100, 24, monetaryWindow)
  sightexports.sGui:setGuiBackground(saveButton, "solid", "sightblue")
  sightexports.sGui:setGuiHover(saveButton, "gradient", {
    "sightblue",
    "sightblue-second"
  }, false, true)
  sightexports.sGui:setButtonFont(saveButton, "11/Ubuntu-R.ttf")
  sightexports.sGui:setButtonText(saveButton, " Mentés")
  sightexports.sGui:setClickEvent(saveButton, "saveGroupMonetary")
  sightexports.sGui:setButtonIcon(saveButton, sightexports.sGui:getFaIconFilename("save", 24))
  sightexports.sGui:setGuiRenderDisabled(saveButton, true)
end)
