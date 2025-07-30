local airSoftMatches = {}
local matchMapLimits = {}
local matchStartTimers = {}
local matchRunTimers = {}
local flagOwners = {}
local flaggingTimers = {}
local playerMatchIDs = {}
local subPlayers = {}
--local nextPlayerID = 1 -- vissza ne huzd

matchMapLimits[1] = {30, 30, 30} -- Caligula CTF 30/30 ; TDM 30/30 ; LMS 30 ; FFA 30
matchMapLimits[2] = {16, 20, 20} -- Gyár CTF 20/20 ; TDM 20/20 ; LMS 16 ; FFA 16
matchMapLimits[3] = {14, 20, 20} -- Jefferson CTF 20/20 ; TDM 20/20 ; LMS 14 ; FFA 14
matchMapLimits[4] = {22, 20, 20} -- Maddog CTF 20/20 ; TDM 20/20 ; LMS 22 ; FFA 22
matchMapLimits[5] = {20, 10, 10} -- SFPD CTF 10/10 ; TDM 10/10 ; LMS 20 ; FFA 20
matchMapLimits[6] = {18, 30, 30} -- Stadion CTF 30/30 ; TDM 30/30 ; LMS 18 ; FFA 18
matchMapLimits[7] = {10, 20, 20} -- Terepasztal CTF 20/20 ; TDM 20/20 ; LMS 10 ; FFA 10
matchMapLimits[8] = {10, 0, 0}   -- Átrium FFA 10

flagPositions = {}
-- X, Y, Z, ID, Owner(=0)
flagPositions[1] = { -- Caligula
    {2182.734375, 1603.5737304688, 1005.0625, 1, 0},
    {2182.6174316406, 1584.5817871094, 999.97344970703, 2, 0},
    {2181.994140625, 1624.1220703125, 999.97351074219, 3, 0}
}
flagPositions[2] = { -- Gyár 
    {2547.3515625, -1294.0126953125, 1054.640625, 1, 0},
    {2573.2890625, -1283.9931640625, 1037.7734375, 2, 0},
    {2548.1181640625, -1293.1005859375, 1044.125, 3, 0},
}
flagPositions[3] = { -- Jefferson
    {2187.7255859375, -1182.5104980469, 1029.796875, 1, 0},
    {2226.8928222656, -1183.3929443359, 1029.804321, 2, 0},
    {2246.2199707031, -1192.0921630859, 1029.796875, 3, 0},
}
flagPositions[4] = {-- MadDog
    {1277.36328125, -833.2314453125, 1085.6328125, 1, 0},
    {1232.162109375, -811.6953125, 1084.0078125, 2, 0},
    {1268.115234375, -789.7548828125, 1084.0078125, 3, 0},
}
flagPositions[5] = { -- SFPD
    {268.3759765625, 118.5517578125, 1004.6171875, 1, 0},
    {246.423828125, 112.2880859375, 1003.21875, 2, 0},
    {228.4951171875, 115.4609375, 1010.21875, 3, 0},
}
flagPositions[6] = { -- Stadion
    {-1458.8779296875, 1628.533203125, 1052.53125, 1, 0},
    {-1417.630859375, 1629.4853515625, 1052.53125, 2, 0},
    {-1388.7587890625, 1590.4052734375, 1052.53125, 3, 0},
}
flagPositions[7] = { -- Terepasztal
    {-1031.0859375, 1079.7626953125, 1343.1335449219, 1, 0},
    {-1084.4169921875, 1042.1806640625, 1343.3703613281, 2, 0},
    {-1057.7099609375, 1069.556640625, 1341.3515625, 3, 0},
}

playerSpawns = {}
playerSpawns[1] = { -- Caligula
  {2205.5634765625, 1551.5577392578, 1008.2857666016}, -- Garázs
  {2236.0329589844, 1668.0874023438, 1008.359375}, -- Octogonba fent
  {2235.9304199219, 1686.2097167969, 1008.359375}, -- Másik oldala u.a.
  -- eddig volt sees
  {2152.0734863281, 1599.3735351562, 1006.1748046871},
  {2144.1337890625, 1602.8676757812, 1006.1677246094},
  {2157.9421386719, 1597.7014160156, 999.96850585938},
  {2144.6381835938, 1597.5228271484, 999.76763916016},
  {2171.7509765625, 1602.2120361328, 999.96832275391},
  {2169.9262695312, 1627.0886230469, 999.96844482422},
  {2194.6420898438, 1610.5512695312, 999.96826171875},
  {2218.3261718764, 1613.6234130859, 999.98266601562},
  {2229.7509765625, 1574.8631591797, 999.97082519531},
  {2194.2653808594, 1577.4720458984, 999.96557617188},
  {2169.1286621094, 1593.2650146484, 999.96618652344},
  {2230.5532226562, 1597.1551513672, 999.96569824219},
  {2191.0903320312, 1603.1011962891, 1005.0625142536},
}
playerSpawns[2] = { -- Gyár
  {2564.0502929688, -1281.3328857422, 1031.421875},
  {2574.3125, -1283.8016357422, 1037.7734375},
  --eddig volt sees
  {2532.47265625, -1305.8507080078, 1044.125},
  {2532.2919921875, -1281.0025634766, 1048.2890625},
  {2569.8608398438, -1306.3607177734, 1048.2890625}, 
  {2529.1184082031, -1284.8515625, 1048.2890625},
  {2519.9807128906, -1306.7174072266, 1048.2890625},
  {2521.1616210938, -1281.3012695312, 1054.640625},
  {2527.9663085938, -1288.5447998047, 1054.640625},
  {2528.7797851562, -1299.4965820312, 1054.640625}, 
  {2548.9333496094, -1306.4221191406, 1054.6469726562},
  {2547.4372558594, -1288.6247558594, 1054.640625},
  {2552.4006347656, -1288.9794921875, 1054.640625},
  {2569.9521484375, -1289.2504882812, 1054.640625},
  {2571.9309082031, -1299.3260498047, 1054.640625},
  {2580.9006347656, -1283.3741455078, 1054.640625},
  {2576.0749511719, -1305.3828125, 1060.984375},
  {2576.1328125, -1286.8143310547, 1060.984375},
  {2553.2219238281, -1291.5709228516, 1060.984375},
  {2582.8371582031, -1282.728515625, 1065.359375},
  {2570.021484375, -1280.9709472656, 1044.125},
  {2569.90625, -1306.7779541016, 1044.125},
  {2575.931640625, -1281.2403564453, 1044.125},
  {2580.7939453125, -1285.7984619141, 1044.125},
  {2579.5983886719, -1305.5374755859, 1037.7734375},
}
playerSpawns[3] = { -- Jefferson
  {2192.599609375, -1145.9388427734, 1029.796875}, -- Hátul exit fele 9-12 room
  --eddig volt sees
  {2192.9206542969, -1180.8782958984, 1033.7895507812},
  {2203.7634277344, -1198.6160888672, 1029.796875},
  {2231.5107421875, -1178.6705322266, 1029.796875},
  {2230.6330566406, -1186.1431884766, 1029.796252},
  {2239.5505371094, -1192.6723632812, 1033.796875},
  {2235.4375, -1193.9458007812, 1029.8043212891},
  {2231.5122070312, -1172.5882568359, 1029.796875},
  {2230.9543457031, -1164.6447753906, 1029.796875},
  {2243.8303222656, -1164.7956542969, 1029.796875},
  {2251.5354003906, -1165.6971435547, 1029.796875},
  {2231.0092773438, -1153.9450683594, 1029.796875},
  {2227.7277832031, -1154.5714111328, 1029.796875},
  {2227.6577148438, -1150.6799316406, 1025.796875},
  {2214.8874511719, -1154.328125, 1025.796875},
  {2189.4584960938, -1146.7150878906, 1033.796875},
  {2203.2080078125, -1155.1750488281, 1029.796875},
}
playerSpawns[4] = { -- Maddog
  --eddig volt sees
  {1266.8764648438, -786.51403808594, 1091.90625},
  {1287.3757324219, -782.6806640625, 1091.90625},
  {1285.3082275391, -782.732421875, 1089.9285888672},
  {1278.09375, -797.35620117188, 1089.9375},
  {1286.7507324219, -786.22534179688, 1089.9375},
  {1292.9659423828, -811.37353515625, 1089.9375},
  {1278.0748291016, -822.43450927734, 1089.9375},
  {1286.8668212891, -813.64984130859, 1089.9375},
  {1289.2395019531, -825.88854980469, 1085.6328125},
  {1283.6275634766, -809.06921386719, 1085.6328125},
  {1274.1898193359, -824.69012451172, 1085.6328125},
  {1259.3028564453, -830.07336425781, 1084.0078125},
  {1243.3236083984, -829.77691650391, 1084.0078125},
  {1225.599609375, -807.18426513672, 1084.00781},
  {1243.4572753906, -817.08660888672, 1084.0078125},
  {1258.3697509766, -807.17980957031, 1084.0151367188},
  {1246.9494628906, -806.06976318359, 1084.0078125},
  {1267.916015625, -813.42626953125, 1084.0078125},
  {1273.2326660156, -813.95440673828, 1084.0078125},
  {1284.1883544922, -801.27844238281, 1084.0078125},
  {1284.6862792969, -787.30096435547, 1084.0078125},
  {1271.3068847656, -796.04107666016, 1084.171875},
  {1266.6784667969, -795.81097412109, 1084.0078125},
  {1246.6185302734, -775.60821533203, 1084.0078125},
  {1261.9409179688, -782.75848388672, 1084.0078125},
  {1265.9348144531, -781.30291748047, 1084.0078125},
  {1269.5300292969, -783.39508056641, 1084.0148925781},
  {1291.1557617188, -765.42877197266, 1084.0078125},
  {1296.1103515625, -796.18341064453, 1084.0148925781},
}
playerSpawns[5] = { -- SFPD
  --eddig volt sees
  {259.10113525391, 108.18228912354, 1003.21875},
  {233.25758361816, 108.25522613525, 1003.2257080078},
  {236.71411132812, 120.38244628906, 1003.21875},
  {259.41744995117, 122.21620178223, 1003.21875},
  {261.71636962891, 111.39675140381, 1004.6171875},
  {278.30798339844, 107.51091766357, 1004.6171875},
  {269.38623046875, 116.8454208374, 1004.6171875},
  {274.34552001953, 122.11678314209, 1004.6171875},
  {277.82281494141, 126.10057830811, 1008.8203125},
  {277.95132446289, 116.73294830322, 1008.8130493164},
  {278.09982299805, 111.78051757812, 1008.8203125},
  {264.50021362305, 107.76264953613, 1009.03125},
  {264.19003295898, 116.70927429199, 1008.8130493164},
  {254.26223754883, 116.8900604248, 1008.8203125},
  {251.45721435547, 120.62487792969, 1010.21875},
  {238.0366973877, 114.97318267822, 1010.21875},
  {223.94705200195, 127.29917144775, 1010.21875},
  {233.91786193848, 111.42234039307, 1010.21875},
  {216.43034362793, 123.5736618042, 1007.4140625},
  {215.55805969238, 124.91639709473, 1003.21875},
  {214.64891052246, 108.16014099121, 1003.21875},
  {230.66430664062, 113.33361816406, 1003.21875},
  {233.85638427734, 125.57453155518, 1003.21875},
  {221.36036682129, 117.83013916016, 999.16961669922},
  {214.5453338623, 126.28573608398, 999.015625},
  {214.88427734375, 114.76639556885, 999.015625},
  {228.10977172852, 114.53963470459, 999.015625},
}
playerSpawns[6] = { -- Stadion 
  {-1362.4982910156, 1605.4965820312, 1052.53125}, -- Busz előtt
  {-1433.5377197266, 1564.2297363281, 1052.53125}, -- Kék konténer
  --eddig volt sees
  {-1359.5606689453, 1643.1629638672, 1052.53125},
  {-1383.6854248047, 1641.1213378906, 1052.53125},
  {-1420.8127441406, 1622.5887451172, 1052.935791015},
  {-1434.4759521484, 1617.5501708984, 1052.53125},
  {-1430.5931396484, 1631.1915283203, 1052.53125},
  {-1491.2286376953, 1642.7288818359, 1052.53125},
  {-1484.3771972656, 1610.9464111328, 1052.53125},
  {-1481.2116699219, 1561.4273681641, 1052.53125},
  {-1454.2198486328, 1568.5992431641, 1052.75},
  {-1453.904296875, 1578.3334960938, 1052.75},
  {-1416.1580810547, 1557.0717773438, 1052.53125},
  {-1384.4078369141, 1586.7160644531, 1052.53125},
  {-1487.3770751953, 1641.9047851562, 1060.671875},
  {-1456.6000976562, 1572.3072509766, 1055.9074707031},
}
playerSpawns[7] = { -- Terepasztal
  {-1083.4169921875, 1043.8033447266, 1343.44921875}, -- Közép kb.
  {-1009.7321777344, 1083.0213623047, 1341.02185058}, -- Vízbe
  {-1130.962890625, 1023.3265991211, 1345.7161865234}, -- Sarokba szögesdrót
  {-1132.1364746094, 1091.3581542969, 1345.7894287109}, -- Másik sarok ugyanott
  {-1050.6514892578, 1052.9978027344, 1341.3515625}, -- Vízbe megint
  --eddig volt sees
}
playerSpawns[8] = {-- Átrium
  {1734.7353515625, -1639.2113037109, 20.230548858643},
  {1733.4176025391, -1639.6882324219, 23.768077850342},
  {1733.8780517578, -1640.1043701172, 27.253314971924},
  {1722.1907958984, -1672.0927734375, 20.223724365234},
  {1710.3698730469, -1673.4636230469, 20.224256515503},
  {1709.6273193359, -1642.7921142578, 20.218753456344},
  {1712.2247314453, -1640.0163574219, 20.223884582524},
  {1717.5958251953, -1640.0385742188, 27.205307006836},
  {1709.1743164062, -1672.8680419922, 27.195312565753},
  {1720.6218261719, -1676.3251953125, 23.692174911499},
  {1723.2792968759, -1673.2476806641, 27.204696655273},
}

randomExitPositions = {
    {999.36956787109, -1505.2087402344, 1999.1875},
    {998.83386230469, -1505.4987792969, 1999.1875},
    {999.90753173828, -1503.9725341797, 1999.1875},
    {998.92492675781, -1503.8499755859, 1999.1875},
    {996.76049804688, -1505.4781494141, 1999.1875},
    {995.74224853516, -1505.5423583984, 1999.1875},
    {996.73754882812, -1504.0373535156, 1999.1875},
    {995.78668212891, -1503.9410400391, 1999.1875},
    {999.87738037109, -1501.1541748047, 1999.1875},
    {998.91058349609, -1501.0197753906, 1999.1875},
    {999.90795898438, -1499.4145507812, 1999.1875},
    {998.98803710938, -1499.5527343754, 1999.1875},
    {996.75146484375, -1501.1358642578, 1999.1875},
    {995.77154541016, -1501.0998535156, 1999.1875},
    {996.76098632812, -1499.4460449219, 1999.1875},
    {995.80407714844, -1499.4901123047, 1999.1875},
    {999.95471191406, -1496.7518310547, 1999.1875},
    {998.88806152344, -1496.7165527344, 1999.1875},
    {999.88116455078, -1494.9869384766, 1999.1875},
    {998.92626953125, -1494.8616943359, 1999.1875},
    {996.78411865234, -1496.7084960938, 1999.1875},
    {995.80865478516, -1496.7164306641, 1999.1875},
    {996.77789306641, -1494.8791503906, 1999.1875},
    {995.81481933594, -1494.8857421875, 1999.1875},
}


function subscribePlayer(playerElement, subState)
    if playerElement then
        if subState then
            if not isTimer(subPlayers[playerElement]) then
                subPlayers[playerElement] = setTimer(function()
                    triggerClientEvent(playerElement, "gotAirsoftMatchList", playerElement, airSoftMatches)
                end, 5000, 0, playerElement)
            end
        else
            if isTimer(subPlayers[playerElement]) then
                killTimer(subPlayers[playerElement])
            end
        end
    end
end

addEvent("requestAirsoftMatchList", true)
addEventHandler("requestAirsoftMatchList", root, function()
    if client and client == source then
        subscribePlayer(client, true)
        triggerClientEvent(client, "gotAirsoftMatchList", client, airSoftMatches)
    end
end)

addEvent("closeAirsoftMatchList", true)
addEventHandler("closeAirsoftMatchList", root, function()
    if client and client == source then
        subscribePlayer(client, false)
    end
end)

addEvent("unsubscribeMatchJoinWindow", true)
addEventHandler("unsubscribeMatchJoinWindow", root, function()
    if client and client == source then
        subscribePlayer(client, false)
    end
end)

addEvent("requestAirsoftMapLimits", true)
addEventHandler("requestAirsoftMapLimits", root, function()
    triggerClientEvent(client, "gotAirsoftMapLimits", client, matchMapLimits)
end)

function generatePinCode()
    return math.random(100000, 999999)
end

function processFlagPoints()
    for _, match in pairs(airSoftMatches) do
        local matchId = match.id
        if match.flags then
            for k, flag in pairs(match.flags) do
                if flag and flag.owner then
                    if flag.owner == 1 then
                        airSoftMatches[matchId].team1Score = airSoftMatches[matchId].team1Score + 2
                        triggerClientEvent("syncAirsoftInMatchData", getRootElement(), matchId, "team1", airSoftMatches[matchId].team1Score)
                    else
                        airSoftMatches[matchId].team2Score = airSoftMatches[matchId].team2Score + 2
                        triggerClientEvent("syncAirsoftInMatchData", getRootElement(), matchId, "team2", airSoftMatches[matchId].team2Score)
                    end
                end
            end
        end
    end 
end
setTimer(processFlagPoints, 2000, 0)

warmupTimers = {}

closeConnectionTimers = {}

addEvent("createAirsoftMatch", true)
addEventHandler("createAirsoftMatch", root, function(matchData)
    exports.sGui:showInfobox(client, "s", "Sikeresen létrehoztad az airsoft meccset!")

    exports.sCore:takeMoney(client, 50000)
    local matchId = #airSoftMatches + 1
    matchData.id = matchId
    
    matchData.playerNum = 0
    matchData.playerDatas = {}
    matchData.playerElements = {}
    matchData.state = "waiting"
    matchData.name = matchData.matchName

    matchData.playerList = {}
    matchData.length = matchData.playTime

    if matchData.private then
        matchData.private = generatePinCode()
        exports.sGui:showInfobox(client, "i", "A meccs PIN kódja: " .. matchData.private)
    end

    matchData.waitTime = matchData.waitTime or 10
    matchData.created = getRealTime().timestamp
    matchData.gameStartTime = (matchData.startTime or 1) * 60
    matchData.reSpawn = matchData.respawnTime or 10
    matchData.starting = getRealTime().timestamp

    if not matchData.stamina then
        matchData.stamina = 100
    end

    
    if not matchData.headshots then
        matchData.headshots = 100
    end
    
    if not matchData.respawnLoadout then
        matchData.respawnLoadout = 10
    end
    
    if not matchData.canChangeLoadout then
        matchData.canChangeLoadout = matchData.respawnLoadout
    end

    matchData.staminaMul = matchData.stamina or 100
    matchData.shaderAllowed = matchData.shaderAllowed

    matchData.headshots = matchData.headshots or 100
    matchData.headshotPlus = matchData.headshots or 100


    matchData.joinFee = matchData.joinFee or 0
    
    if matchData.gm == "ctf" then
        matchData.scores = {0, 0}
        matchData.flags = createCTFFlags(matchId, matchData.map)
    end

    matchData.id = matchId

    local creatorName = getElementData(client, "visibleName") or "Ismeretlen"
    if type(creatorName) == "string" then
        matchData.createdBy = creatorName:gsub("_", " ")
    else
        matchData.createdBy = "Ismeretlen"
    end
    
    if matchData.private then
        matchData.private = generatePinCode()
    end
    
    matchData.starting = getRealTime().timestamp + (matchData.waitTime * 60)
    
    local time = getRealTime()
    local date = string.format("%02d:%02d:%02d", time.hour, time.minute, time.second)
    local charID = getElementData(client, "char.ID") or "Ismeretlen"
    
    matchData.chatLines = {
        "[color=sightmidgray] [".. date .."] [color=sightgreen]" .. matchData.createdBy .. " (" .. charID .. ") [color=sightlightgrey]létrehozta a meccset.",
        "[color=sightmidgray] [".. date .."] [color=sightlightgrey]Pálya: [color=sightgreen]" .. airsoftMaps[matchData.map].name,
        "[color=sightmidgray] [".. date .."] [color=sightlightgrey]Játékmód: [color=sightblue]" .. gameModes[matchData.gm].name,
        "[color=sightmidgray] [".. date .."] [color=sightlightgrey]Maximum játékosok: [color=sightgreen]" .. matchData.maxPlayers,
    }

    matchData.team1Score = 0
    matchData.team2Score = 0
    
    table.insert(airSoftMatches, matchData)
    
    warmupTimers[matchId] = setTimer(setMatchWarmUp, (matchData.gameStartTime) * (1000), 1, matchId)

    matchStartTimers[matchId] = setTimer(startMatch, (matchData.gameStartTime) * (1000) + (matchData.waitTime) * (1000 * 60), 1, client, matchId)
    
    setElementData(client, "dev:airsoftMatchData", matchData)

    for _, player in ipairs(getElementsByType("player")) do
        if player ~= client and subPlayers[player] then
            triggerClientEvent(player, "gotNewAirsoftMatch", player, matchData)
        end
    end
    
    local clientMatchData = {}
    for k, v in pairs(matchData) do
        if k ~= "playerDatas" and k ~= "playerElements" then
            clientMatchData[k] = v
        end
    end
    
    triggerClientEvent(client, "createAirsoftMatchResponse", client, true)
    triggerClientEvent(client, "gotAirsoftMatchJoinWindow", client, clientMatchData, {})

end)

function setMatchWarmUp(matchId)
    local game = airSoftMatches[matchId]
    if game then
        local time = getRealTime()
        local date = string.format("%02d:%02d:%02d", time.hour, time.minute, time.second)
        local chatLine = "[color=sightmidgray]["..date.."] [color=sightlightgrey]A csatlakozás lezárult. A meccs hamarosan indul."
        
        triggerClientEvent("gotAirsoftChatLine", root, matchId, chatLine)

        game.state = "warmup"
    end
end

function addPlayerToMatch(player, matchId)
    local game = airSoftMatches[matchId]
    if not game or not isElement(player) then return false end

    local count = 1
    for k, v in pairs(game.playerDatas) do
        count = count + 1
    end

    if game.maxPlayers <= count - 1 then
        triggerClientEvent(client, "airsoftMatchPinResponse", client, matchId, false)
        return false, false
    end

    local nextPlayerID = count

    local playerID = nextPlayerID
    nextPlayerID = nextPlayerID + 1
    
    if not playerMatchIDs[player] then
        playerMatchIDs[player] = {}
    end
    playerMatchIDs[player][matchId] = playerID
    
    local team = false

    if gameModes[game.gm].team then
    
        team = math.random(1, 2)
    end
    
    if not game.playerDatas then
        game.playerDatas = {}
    end
    
    game.playerDatas[playerID] = {
        client = player,
        name = getElementData(player, "visibleName"):gsub("_", " "),
        k = 0,
        d = 0,
        lastFrag = 0,
        team = team,
        spawned = false,
        loadout = {}
    }
    
    if not game.playerElements then
        game.playerElements = {}
    end
    game.playerElements[player] = playerID
    
    game.playerNum = game.playerNum + 1
    
    if game.gm == "lms" and game.state == "running" then
        game.playersAlive = {}
        game.playersAlive[playerID] = true
    end
    
    return true, playerID
end

function startMatch(matchCreator, matchId)
    local game = airSoftMatches[matchId]
    if not game then return end

    local team1Count = 0
    local team2Count = 0
    for playerID, data in pairs(game.playerDatas) do
        local player = data.client
        if isElement(player) then
            local playerID = game.playerElements and game.playerElements[player]
            if playerID and game.playerDatas[playerID] then
                local map = airsoftMaps[game.map]
                local pTeam = game.playerDatas[playerID].team
                if gameModes[game.gm].team and pTeam == 1 then
                    team1Count = team1Count + 1
                elseif gameModes[game.gm].team and pTeam == 2 then
                    team2Count = team2Count + 1
                end
            end
        end
    end

    local time = getRealTime()
    local date = string.format("%02d:%02d:%02d", time.hour, time.minute, time.second)

    if gameModes[game.gm].team then
        local failColor = false
        if team1Count == 0 then
            local color = "[color=sightblue]kék"
            failColor = "kék"
            local chatLine = "[color=sightmidgray]["..date.."] [color=sightlightgrey]A meccs nem indult el, mivel nincs játékos a ".. color .." csapatban."
            triggerClientEvent("gotAirsoftChatLine", root, matchId, chatLine)
        end

        if team2Count == 0 then
            local color = "[color=sightred]piros"
            failColor = "piros"
            local chatLine = "[color=sightmidgray]["..date.."] [color=sightlightgrey]A meccs nem indult el, mivel nincs játékos a ".. color .." csapatban."
            triggerClientEvent( "gotAirsoftChatLine", root, matchId, chatLine)
        end
        if failColor then
            local errorMessage = "A meccs nem indult el, mivel nincs játékos a "..failColor.." csapatban"

            local devMode = true

            if not devMode then
                for k, v in pairs(subPlayers) do
                    if isElement(k) then
                        triggerClientEvent(k, "deleteAirsoftMatch", k, matchId)
                    end
                end

                for playerID, data in pairs(game.playerDatas) do
                    local player = data.client
                    if isElement(player) then
                        exports.sGui:showInfobox(player, "e", errorMessage)
                        triggerClientEvent(player, "syncAirsoftInMatchData", player, matchId, "ended")
                    end
                end

                cleanupMatch(matchId)
                return
            end
        end
    end
        
    game.state = "running"
    game.startTime = getRealTime().timestamp
    game.endTime = game.startTime + (game.length * 60)
    
    game.ending = game.startTime + (game.length * 60)

    if game.gm == "ctf" then
        if not game.flags or #game.flags == 0 then
            game.flags = createCTFFlags(matchId, game.map)
        end
        
        if not game.scores then
            game.scores = {0, 0}
        end
    elseif game.gm == "tdm" then
        game.scores = {0, 0}
    elseif game.gm == "lms" then
        game.playersAlive = {}
        for playerID, data in pairs(game.playerDatas) do
            if isElement(data.client) then
                game.playersAlive[playerID] = true
            end
        end
    elseif game.gm == "ffa" then
    end
    

    game.timerText = 20

    matchRunTimers[matchId] = setTimer(endMatch, game.length * 60 * 1000, 1, matchId)
    
    local time = getRealTime()
    local date = string.format("%02d:%02d:%02d", time.hour, time.minute, time.second)
    local chatLine = "[color=sightmidgray]["..date.."] [color=sightlightgrey]A meccs elindult. Jó szórakozást!"
    
    for playerID, data in pairs(game.playerDatas) do
        local player = data.client
        if isElement(player) then
            triggerClientEvent(player, "syncAirsoftInMatchData", player, matchId, "started")
            triggerClientEvent(player, "syncAirsoftInMatchData", player, matchId, "canChangeLoadout", (game.respawnLoadout or 10))
            triggerClientEvent(player, "gotAirsoftChatLine", player, matchId, chatLine)
            spawnPlayerInMatch(player, matchId)
        end
    end
end

function endMatch(matchId)
    local game = airSoftMatches[matchId]
    if not game then return end
    
    game.state = "ended"
    
    local winners = determineWinners(matchId)
    
    local time = getRealTime()
    local date = string.format("%02d:%02d:%02d", time.hour, time.minute, time.second)
    local chatLine = "[color=sightmidgray] [".. date .."] [color=sightlightgrey]A meccs véget ért!"
    triggerClientEvent("syncAirsoftInMatchData", root, matchId, "ended", 60)
    for playerID, data in pairs(game.playerDatas) do
        local player = data.client
        if isElement(player) then
            triggerClientEvent(player, "gotAirsoftChatLine", player, matchId, chatLine)
            if game.gm == "ffa" or game.gm == "lms" then
                if game.gm == "ffa" then
                    table.sort(game.playerDatas, function(a, b)
                        if not a or not b then
                            return false
                        end
                        if a.standing ~= b.standing then
                            return a.standing > b.standing
                        elseif a.k ~= b.k then
                            return a.k > b.k
                        else
                            return (a.kd or 0) > (b.kd or 0)
                        end
                    end)
                else
                    table.sort(game.playerDatas, function(a, b)
                        if not a.eliminated and not b.eliminated then
                            return false
                        end
                        if not a.eliminated then
                            return true
                        end
                        if not b.eliminated then
                            return false
                        end
                        return a.eliminated > b.eliminated
                    end)
                end
                triggerClientEvent(player, "gotAirsoftMatchResults", player, game.playerDatas, false, false)
            else
                triggerClientEvent(player, "gotAirsoftMatchResults", player, game.playerDatas, game.team1Score, game.team2Score)
            end
        end
    end
    
    distributeMatchPrizes(matchId)

    setTimer(function(matchId)
        cleanupMatch(matchId)
    end, 60000, 1, matchId)
end

function determineWinners(matchId)
    local game = airSoftMatches[matchId]
    local winners = {}
    
    if game.gm == "ctf" or game.gm == "tdm" then
        if game.team1Score > game.team2Score then
            winners.winningTeam = 1
        elseif game.team2Score > game.team1Score then
            winners.winningTeam = 2
        else
            winners.winningTeam = 0 -- Draw
        end
    elseif game.gm == "lms" or game.gm == "ffa" then
        local playerScores = {}
        
        for playerID, data in pairs(game.playerDatas) do
            local player = data.client
            if isElement(player) then
                local kills = data.k or 0
                local deaths = data.d or 0
                local kd = deaths > 0 and kills/deaths or kills
                
                table.insert(playerScores, {
                    playerID = playerID,
                    player = player,
                    name = data.name,
                    k = kills,
                    d = deaths,
                    kd = kd,
                    lastFrag = data.lastFrag or 0,
                    standing = (game.gm == "lms" and game.playersAlive and game.playersAlive[playerID]) and 1 or 0
                })
            end
        end
        
        if game.gm == "lms" then
            table.sort(playerScores, function(a, b)
                if a.standing ~= b.standing then
                    return a.standing > b.standing
                elseif a.k ~= b.k then
                    return a.k > b.k
                else
                    return a.kd > b.kd
                end
            end)
        else
            table.sort(playerScores, function(a, b)
                if a.k ~= b.k then
                    return a.k > b.k
                else
                    return a.kd > b.kd
                end
            end)
        end
        
        winners.players = {}
        winners.playerElements = {}
        winners.scores = {}
        
        for place = 1, math.min(3, #playerScores) do
            local playerData = playerScores[place]
            table.insert(winners.players, playerData.playerID)
            table.insert(winners.playerElements, playerData.client)
            table.insert(winners.scores, {
                k = playerData.k,
                d = playerData.d,
                kd = playerData.kd
            })
        end
    end
    
    return winners
end

function spawnPlayerInMatch(player, matchId)
    local game = airSoftMatches[matchId]
    if not game or not isElement(player) then return end
    
    local playerID = game.playerElements and game.playerElements[player]
    if not playerID or not game.playerDatas[playerID] then return end
    
    local map = airsoftMaps[game.map]
    local team = game.playerDatas[playerID].team
    
    setElementInterior(player, map.interior)
    setElementDimension(player, matchId)
    
    local x, y, z, rot = getSpawnPosition(matchId, team)
    
    triggerClientEvent(player, "syncAirsoftPlayerData", player, matchId, playerID, "team", team)
    spawnPlayer(player, x, y, z, rot, getElementModel(player), map.interior, matchId)
    setCameraTarget(player)

    if isTimer(respawnTimers[player]) then
        killTimer(respawnTimers[player])
    end
    if isTimer(respawnCameraTimers[player]) then
        killTimer(respawnCameraTimers[player])
    end

    takeAllWeapons(player)
    exports.sItems:unuseItem(player)

    exports.sWeapons:giveWeaponFromItems(player, "airsoftDeath")
    
    game.playerDatas[playerID].spawned = true
    game.playerDatas[playerID].client = player
    game.playerDatas[playerID].spawnTime = getRealTime().timestamp
    
    triggerClientEvent(player, "syncAirsoftPlayerData", player, matchId, playerID, "team", team)
    for k, v in pairs(game.playerDatas) do
        if (v.health or 0) > 0 then
            triggerClientEvent(player, "syncAirsoftPlayerData", player, matchId, k, "spawned", true)
        end
    end
end

--[[function getSpawnPosition(matchId, team)
    local game = airSoftMatches[matchId]
    local map = airsoftMaps[game.map]
    
    -- This would need to be implemented based on your map data
    -- For now, we'll use some default values
    local spawnX, spawnY, spawnZ, spawnRot = 0, 0, 0, 0
    
    -- In a real implementation, you'd look up spawn points from a database or predefined list
    if team == 1 then
        spawnX, spawnY, spawnZ = map.campos[1], map.campos[2], map.campos[3]
    else
        spawnX, spawnY, spawnZ = map.campos[4], map.campos[5], map.campos[6]
    end
    
    spawnRot = math.random(0, 360)
    
    return spawnX, spawnY, spawnZ, spawnRot
end--]]


function getSpawnPosition(matchId, team)
    local game = airSoftMatches[matchId]
    local map = airsoftMaps[game.map]

    local mapId = game.map

    local spawnX, spawnY, spawnZ, spawnRot = 2235.7546386719, 1564.2155761719, 1008.359375, 0
    
    local pos = playerSpawns[mapId][math.random(1, #playerSpawns[mapId])]
    if pos then
        spawnX, spawnY, spawnZ = unpack(pos)
    end

    return spawnX, spawnY, spawnZ, spawnRot
end

function createCTFFlags(matchId, mapId)
    local currentFlags = {}

    for k, v in pairs(flagPositions[mapId]) do
        local x, y, z, id, owner = unpack(v)
        table.insert(currentFlags, {
            x, y, z, id, owner
        })
    end
    
    return currentFlags
end

function removePlayerFromMatch(player, matchId)
    local game = airSoftMatches[matchId]
    if not game or not isElement(player) then return end
    triggerClientEvent(player, "deleteAirsoftResultWindow", player, matchId, false, false)

    local playerID = game.playerElements and game.playerElements[player]
    if not playerID then return end
    
    if game.playerDatas[playerID] then
        game.playerDatas[playerID] = nil
    end
    
    if game.playerElements[player] then
        game.playerElements[player] = nil
    end
    
    if playerMatchIDs[player] and playerMatchIDs[player][matchId] then
        playerMatchIDs[player][matchId] = nil
    end

    game.playerNum = game.playerNum - 1
    
    if game.gm == "lms" and game.playersAlive and game.playersAlive[playerID] then
        game.playersAlive[playerID] = nil
    end
    
    setElementInterior(player, 1)
    setElementDimension(player, 1)

    local pos = randomExitPositions[math.random(1, #randomExitPositions)]

    local x, y, z = unpack(pos)

    setElementPosition(player, x, y, z)

    setCameraTarget(player)

    setElementData(player, "airsoftColor", false)
    
    local items = exports.sItems:getElementItems(player)

    for k, v in pairs(game.playerList) do
        if v[1] == getElementData(player, "char.ID") then
            table.remove(game.playerList, k)
        end
    end

    takeAllWeapons(player)
    exports.sItems:unuseItem(player)
    for k, v in pairs(items) do
        if exports.sItems:getItemData(player, v.dbID, 3) == "airsoft" then
            triggerEvent("onWeaponTake", player, v.dbID, v.itemId)
            exports.sItems:takeItem(player, "dbID", v.dbID)
        end
    end

    exports.sWeapons:giveWeaponFromItems(player, "airsoftDeath")
    
    for pid, pdata in pairs(game.playerDatas) do
        local otherPlayer = pdata.client
        if isElement(otherPlayer) then
            triggerClientEvent(otherPlayer, "syncAirsoftPlayerData", otherPlayer, matchId, playerID, "left")
        end
    end
    
    if tableLength(game.playerDatas) < 2 and game.state == "running" then
        if isTimer(matchRunTimers[matchId]) then
            killTimer(matchRunTimers[matchId])
        end
        endMatch(matchId)
    end

    triggerClientEvent(player, "airsoftMatchLeft", player)
end

function cleanupMatch(matchId)
    local game = airSoftMatches[matchId]
    if not game then return end

    for k, v in pairs(getElementsByType("player")) do
        if game.playerElements and game.playerElements[v] then
            removePlayerFromMatch(v, matchId)
        end
    end
    
    if isTimer(matchRunTimers[matchId]) then
        killTimer(matchRunTimers[matchId])
    end
    
    for flagId, timer in pairs(flagOwners) do
        if isTimer(timer) then
            killTimer(timer)
            flagOwners[flagId] = nil
        end
    end
    
    table.remove(airSoftMatches, matchId)
end

function tableLength(t)
    local count = 0
    for _ in pairs(t) do
        count = count + 1
    end
    return count
end

addEvent("tryAirsoftMatchPin", true)
addEventHandler("tryAirsoftMatchPin", root, function(matchId, pinCode)
    if client and client == source and airSoftMatches[matchId] then
        if airSoftMatches[matchId].private == pinCode then
            triggerClientEvent(client, "airsoftMatchPinResponse", client, matchId, true)
        else
            triggerClientEvent(client, "airsoftMatchPinResponse", client, matchId, false)
        end
    end
end)

addEvent("airsoftJoinMatch", true)
addEventHandler("airsoftJoinMatch", root, function(matchId)
    if not airSoftMatches[matchId] then return end
    
    if not client then client = source end

    local game = airSoftMatches[matchId]
    local success, playerID = addPlayerToMatch(client, matchId)
    
    if success then
        exports.sCore:takeMoney(client, game.joinFee)
        local team = game.playerDatas[playerID].team
        
        local joinData = {
            matchId, game.map, game.starting, game.gm, game.length
        }
        triggerClientEvent(client, "airsoftMatchJoined", client, unpack(joinData))
        
        local clientPlayerDatas = {}
        for pid, data in pairs(game.playerDatas) do
            clientPlayerDatas[pid] =  {
                id = pid,
                name = data.name,
                team = data.team,
                k = data.k or 0,
                d = data.d or 0,
                spawned = data.spawned or true,
                client = data.client,
                lastFrag = 0
            }
        end
        
        local clientMatchData = {}
        for k, v in pairs(game) do
            if k ~= "playerDatas" and k ~= "playerElements" then
                clientMatchData[k] = v
            end
        end
        clientMatchData.id = matchId
        
        local map = airsoftMaps[game.map]
        setElementInterior(client, map.interior)
        setElementDimension(client, matchId)
        
        local filePath = ":sMaps/airsoft/"..map["map"]

        local content = {}

        if fileExists(filePath) then
            local f = fileOpen(filePath)
            content = fileRead(f, fileGetSize(f))
            fileClose(f)
        end

        local data = {
            matchId, fromJSON(content), game.gm, game.staminaMul, game.gameStartTime, 
            game.shaderAllowed, game.shaderAllowed, game.chatLines, 
            clientPlayerDatas, team, game.canChangeTeam, game.flags, game.length
        }

        for pid, pData in pairs(game.playerDatas) do
            local targetPlayer = pData.client
            data[10] = game.playerDatas[pid].team
            triggerClientEvent(targetPlayer, "gotAirsoftMatchData", client, unpack(data))
        end

        triggerClientEvent(client, "syncAirsoftPlayerData", client, matchId, playerID, "team", team)
        for k, v in pairs(game.playerDatas) do
            if (v.health or 0) > 0 then
                triggerClientEvent(client, "syncAirsoftPlayerData", client, matchId, k, "spawned", true)
            end
        end
        triggerClientEvent(client, "syncAirsoftPlayerData", client, matchId, playerID, "spawned", true)
        
        if game.state == "running" then
            spawnPlayerInMatch(client, matchId)
        else
            local x, y, z = getSpawnPosition(matchId, team)
            spawnPlayer(client, x, y, z, math.random(0, 360), getElementModel(client), map.interior, matchId)  -- Changed dimension to matchId
            setCameraTarget(client)

            if isTimer(respawnTimers[client]) then
                killTimer(respawnTimers[client])
            end
            if isTimer(respawnCameraTimers[client]) then
                killTimer(respawnCameraTimers[client])
            end
            game.playerDatas[playerID].spawned = true
        end
        triggerClientEvent("gotAirsoftMatchJoinPlayerAdded", client, matchId, getElementData(client, "char.ID"), getElementData(client, "visibleName"):gsub("_", " "))
        table.insert(game.playerList, {getElementData(client, "char.ID"), getElementData(client, "visibleName"):gsub("_", " ")})
    else
        exports.sGui:showInfobox(client, "e", "Nem sikerült csatlakozni a meccshez!")
    end
end)

addEvent("airsoftMatchLoaded", true)
addEventHandler("airsoftMatchLoaded", root, function(matchId)
    if client and client == source and airSoftMatches[matchId] then
        local game = airSoftMatches[matchId]
        local playerID = game.playerElements[client]
        if not playerID then return end
        
        local time = getRealTime()
        local date = string.format("%02d:%02d:%02d", time.hour, time.minute, time.second)

        local playerTeam = game.playerDatas[playerID].team

        local teamColor = playerTeam == 1 and "[color=sightblue]" or "[color=sightred]"
        local teamName = playerTeam == 1 and "Kék csapat" or "Piros csapat"
        local playerName = getElementData(client, "char.name"):gsub("_", " ") 

        if playerTeam then
            line = "[color=sightmidgray] [".. date .."] ".. teamColor .. playerName .. "[color=sightlightgrey] belépett a meccsbe "..teamColor.."("..teamName..")[color=sightlightgrey]."
        else
            line = "[color=sightmidgray] [".. date .."][color=sightgreen] ".. playerName .. "[color=sightlightgrey] belépett a meccsbe."
        end        
        table.insert(game.chatLines, line)
        
        local count = 0
        for pid, pdata in pairs(game.playerDatas) do
            local player = pdata.client
            if isElement(player) then
                triggerClientEvent(player, "gotAirsoftChatLine", player, matchId, line)
                count = count + 1
            end
        end

        if count == game.maxPlayers then
            if game.state ~= "warmup" then
                if isTimer(matchStartTimers[matchId]) then
                    killTimer(matchStartTimers[matchId])
                end
                matchStartTimers[matchId] = setTimer(startMatch, (game.gameStartTime) * (1000), 1, player, matchId)
                if isTimer(warmupTimers[matchId]) then
                    killTimer(warmupTimers[matchId])
                end
                setMatchWarmUp(matchId)

                for playerID, data in pairs(game.playerDatas) do
                    local player = data.client
                    if isElement(player) then
                        triggerClientEvent(player, "syncAirsoftInMatchData", player, matchId, "starting", getRealTime().timestamp)
                    end
                end
            end
        end
    end
end)

addEvent("getAirsoftJoinMatchWindow", true)
addEventHandler("getAirsoftJoinMatchWindow", root, function(matchId)
    if airSoftMatches[matchId] then
        local sendData = airSoftMatches[matchId]
        triggerClientEvent(client, "gotAirsoftMatchJoinWindow", client, sendData, airSoftMatches[matchId].playerList)
    end
end)

addEvent("airsoftSetLoadout", true)
addEventHandler("airsoftSetLoadout", root, function(loadout)
    if client and client == source then
        local items = exports.sItems:getElementItems(client)

        takeAllWeapons(client)
        exports.sItems:unuseItem(client)

        for k, v in pairs(items) do
            if exports.sItems:getItemData(client, v.dbID, 3) == "airsoft" then
                exports.sItems:takeItem(client, "dbID", v.dbID)
            end
        end
        exports.sWeapons:giveWeaponFromItems(client, "airsoftDeath")

        for itemId, v in pairs(loadout) do
            if v then
                exports.sItems:giveItem(client, itemId, 1, false, false, false, "airsoft")
            end
        end
    end
end)

addEvent("airsoftSendChat", true)
addEventHandler("airsoftSendChat", root, function(matchId, message)
    if client and client == source and airSoftMatches[matchId] then
        local game = airSoftMatches[matchId]
        local playerID = game.playerElements[client]
        if not playerID then return end
        
        local time = getRealTime()
        local date = string.format("%02d:%02d:%02d", time.hour, time.minute, time.second)
        
        local playerName = getElementData(client, "visibleName"):gsub("_", " ")
        local team = game.playerDatas[playerID].team
        local teamColor = team == 1 and "sightblue" or (team == 2 and "sightred" or "sightgreen")
        
        local line = "[color=sightmidgray] [".. date .."] [color=" .. teamColor .. "]" .. playerName .. ": [color=sightlightgrey]" .. message
        
        table.insert(game.chatLines, line)
        
        for pid, pdata in pairs(game.playerDatas) do
            local player = pdata.client
            if isElement(player) then
                triggerClientEvent(player, "gotAirsoftChatLine", player, matchId, line)
            end
        end
    end
end)

addEvent("changeAirsoftTeam", true)
addEventHandler("changeAirsoftTeam", root, function(newTeam)
    if client and client == source then
        local matchId = nil

        if not matchId or not airSoftMatches[matchId] then
            for id, match in pairs(airSoftMatches) do
                if match.playerElements and match.playerElements[client] then
                    matchId = id
                    break
                end
            end
        end
        
        if matchId and airSoftMatches[matchId] then
            local game = airSoftMatches[matchId]
            
            local playerID = game.playerElements[client]
            if not playerID or not game.playerDatas[playerID] then 
                return 
            end
            
            if not gameModes[game.gm].team then return end
            if not game.canChangeTeam then return end
            
            local oldTeam = game.playerDatas[playerID].team
            
            if oldTeam == newTeam then
                return
            end
            
            game.playerDatas[playerID].team = newTeam
            
            local teamCounts = {0, 0}
            for _, playerData in pairs(game.playerDatas) do
                if playerData.team == 1 then
                    teamCounts[1] = teamCounts[1] + 1
                elseif playerData.team == 2 then
                    teamCounts[2] = teamCounts[2] + 1
                end
            end
            
            local time = getRealTime()
            local date = string.format("%02d:%02d:%02d", time.hour, time.minute, time.second)
            local playerName = getElementData(client, "visibleName"):gsub("_", " ")
            
            local teamNames = {"", "kék", "piros"} 
            local teamColors = {"", "sightblue", "sightred"}
            local teamColorString = newTeam == 1 and "sightblue" or "sightred"
            local teamNameString = newTeam == 1 and "kék" or "piros"
            
            local oldTeamColor = (oldTeam and oldTeam == 1 and "[color=sightblue]") or (oldTeam and oldTeam == 2 and "[color=sightred]")
            
            local line = "[color=sightmidgray] [".. date .."]" .. oldTeamColor .. "" .. playerName .. 
                " [color=sightlightgrey] csapatot váltott: [color=" .. teamColorString .. "]" .. teamNameString .. " csapat"
            
            table.insert(game.chatLines, line)
            
            if not game.teamCounts then
                game.teamCounts = {0, 0}
            end
            game.teamCounts = teamCounts
            
            local clientPlayerDatas = {}
            for pid, data in pairs(game.playerDatas) do
                if isElement(data.client) then
                    clientPlayerDatas[pid] = {
                        id = pid,
                        name = data.name,
                        team = data.team,
                        k = data.k or 0,
                        d = data.d or 0,
                        spawned = data.spawned or true,
                        client = data.client,
                        lastFrag = 0
                    }
                end
            end
            
            local clientMatchData = {}
            for k, v in pairs(game) do
                if k ~= "playerDatas" and k ~= "playerElements" then
                    clientMatchData[k] = v
                end
            end
            clientMatchData.id = matchId
            
            for pid, pData in pairs(game.playerDatas) do
                local targetPlayer = pData.client
                if isElement(targetPlayer) then
                    triggerClientEvent(targetPlayer, "gotAirsoftChatLine", targetPlayer, matchId, line)
                    
                    if client == targetPlayer then
                        game.playerDatas[pid].team = newTeam
                    end
                    local data = {
                        matchId, {}, game.gm, game.staminaMul, game.gameStartTime, 
                        game.shaderAllowed, game.shaderAllowed, game.chatLines, 
                        clientPlayerDatas, newTeam, game.canChangeTeam, game.flags, game.length
                    }
                    data[10] = game.playerDatas[pid].team
                    triggerClientEvent(targetPlayer, "gotAirsoftMatchData", client, unpack(data))
                end
            end

            local playerData = game.playerDatas[playerID]

            playerData.team = newTeam

            triggerClientEvent("syncAirsoftPlayerFullData", client, matchId, playerID, playerData)
            triggerClientEvent(client, "syncAirsoftPlayerData", client, matchId, playerID, "team", newTeam)
            
            if game.state == "running" then
                spawnPlayerInMatch(client, matchId)
            else
                local map = airsoftMaps[game.map]
                local x, y, z = getSpawnPosition(matchId, newTeam)
                spawnPlayer(client, x, y, z, math.random(0, 360), getElementModel(client), map.interior, matchId)
                setCameraTarget(client)

                if isTimer(respawnTimers[client]) then
                    killTimer(respawnTimers[client])
                end
                if isTimer(respawnCameraTimers[client]) then
                    killTimer(respawnCameraTimers[client])
                end
                
                takeAllWeapons(client)
                exports.sItems:unuseItem(client)

                exports.sWeapons:giveWeaponFromItems(client, "airsoftDeath")
                game.playerDatas[playerID].spawned = true
            end
        end
    end
end)

addEvent("leaveAirsoftGame", true)
addEventHandler("leaveAirsoftGame", root, function()
    if client and client == source then
        for matchId, game in pairs(airSoftMatches) do
            if game.playerElements and game.playerElements[client] then
                removePlayerFromMatch(client, matchId)
                break
            end
        end
    end
end)

function onPlayerQuit()
    for matchId, game in pairs(airSoftMatches) do
        if game.playerElements and game.playerElements[source] then
            removePlayerFromMatch(source, matchId)
        end
    end
    
    subscribePlayer(source, false)
end
addEventHandler("onPlayerQuit", root, onPlayerQuit)

respawnTimers = {}
respawnCameraTimers = {}

function respawnPlayer(player, team, matchId)
    local game = airSoftMatches[matchId]
    triggerClientEvent("syncAirsoftInMatchData", player, matchId, "spawned", true)
    triggerClientEvent(player, "syncAirsoftInMatchData", player, matchId, "canChangeLoadout", (game.respawnLoadout or 10))
    spawnPlayerInMatch(player, matchId)
    setCameraTarget(player)
end

function respawnPlayerCamera(player, team, matchId)
    local cam = airsoftMaps[airSoftMatches[matchId].map].campos
    setCameraMatrix(player, unpack(cam))
end

addEvent("airsoftNextSpectator", true)
addEventHandler("airsoftNextSpectator", root, function(next)

end)

addEvent("airsoftDamage", true)
addEventHandler("airsoftDamage", root, function(attacker, weapon, bodypart, loss)
    local shooter = attacker
    local hitElement = source
    local matchId = nil

    local headshot = bodypart == 9
    
    for id, match in pairs(airSoftMatches) do
        if match.playerElements and match.playerElements[shooter] then
            matchId = id
            break
        end
    end
    
    if not matchId or not isElement(hitElement) or getElementType(hitElement) ~= "player" then
        return
    end
    
    local game = airSoftMatches[matchId]
    local shooterID = game.playerElements[shooter]
    local victimID = game.playerElements[hitElement]

    local s = game.state
    if s ~= "running" and s ~= "warmup" then
        return
    end
    if not shooterID or not victimID then
        return
    end
    
    local shooterTeam = game.playerDatas[shooterID].team
    local victimTeam = game.playerDatas[victimID].team
    
    local wep = getElementData(shooter, "customWeapon")

    if shooterTeam and victimTeam and shooterTeam == victimTeam then
        if not game.friendlyFire then
            return
        end
    end

    local damage = exports.sWeapons:getWeaponDamage(wep)

    if not damage then
        damage = 0
    end

    local hsMul = game.headshots

    if headshot then
        damage = 100 * (hsMul / 100)
    end
    
    game.playerDatas[victimID].health = (game.playerDatas[victimID].health or 100) - damage
    --Flag abbahagyast ide.


    if game.playerDatas[victimID].health <= 0 then

        local time = airSoftMatches[matchId].reSpawn
        if game.state ~= "warmup" then
            game.playerDatas[victimID].eliminated  = getRealTime().timestamp
        end

        for k, v in pairs(game.playerDatas) do
            if (v.health or 0) > 0 then
                triggerClientEvent(hitElement, "syncAirsoftPlayerData", hitElement, matchId, k, "spawned", true)
            end
        end

        triggerClientEvent(hitElement, "syncAirsoftInMatchData", hitElement, matchId, "spawned", time)
        triggerClientEvent(hitElement, "syncAirsoftPlayerData", hitElement, matchId, victimID, "spawned", false)

        if game.state ~= "warmup" then
            game.playerDatas[shooterID].k = (game.playerDatas[shooterID].k or 0) + 1
            game.playerDatas[victimID].d = (game.playerDatas[victimID].d or 0) + 1

            triggerClientEvent("syncAirsoftPlayerData", shooter, matchId, shooterID, "k", game.playerDatas[shooterID].k)
            triggerClientEvent("syncAirsoftPlayerData", hitElement, matchId, victimID, "d", game.playerDatas[victimID].d)
        end

        game.playerDatas[victimID].health = 100
        triggerClientEvent(hitElement, "syncAirsoftInMatchData", hitElement, matchId, "health", game.playerDatas[victimID].health)
        
        local shooterName = getElementData(shooter, "visibleName"):gsub("_", " ")
        local victimName = getElementData(hitElement, "visibleName"):gsub("_", " ")

        local shooterColor = shooterTeam == 1 and "[color=sightblue]" or "[color=sightred]"
        local victimColor = victimTeam == 1 and "[color=sightblue]" or "[color=sightred]"

        if not shooterTeam then
            shooterColor = "[color=sightgreen]"
        end

        if not victimTeam then
            victimColor = "[color=sightgreen]"
        end
        
        local weaponName = getElementData(shooter, "airsoftgun")

        if headshot then
            weaponName = weaponName .. " - headshot"
        end

        local time = getRealTime()
        local date = string.format("%02d:%02d:%02d", time.hour, time.minute, time.second)

        if game.flags then
            for id, flag in pairs(game.flags) do
                if flag.capture and flag.capture[hitElement] then
                end
            end
        end
        

        local line = "[color=sightmidgray] [".. date .."] " ..  shooterColor .. shooterName .. "[color=sightlightgrey] lelőtte ".. victimColor .. "" .. victimName .. 
        " [color=sightlightgrey]játékost. (" .. weaponName .. ")"
    
        table.insert(game.chatLines, line)

        triggerClientEvent("gotAirsoftChatLine", hitElement, matchId, line)
        triggerClientEvent(shooter, "gotAirsoftDamage", shooter, x, y, z, damage, {bodypart, headshot})

        setElementPosition(hitElement, 0, 0, 0)

        takeAllWeapons(hitElement)
        exports.sItems:unuseItem(hitElement)

        exports.sWeapons:giveWeaponFromItems(hitElement, "airsoftDeath")

        setCameraTarget(hitElement, shooter)

        for k, v in pairs(getElementsByType("player")) do
            if getCameraTarget(v) == hitElement then
                respawnPlayerCamera(v, victimTeam, matchId)
            end
        end

        triggerClientEvent(shooter, "gotAirsoftFrag", shooter, headshot)
        if game.state ~= "warmup" then
            if shooterTeam == 1 then
                if shooterTeam ~= victimTeam then
                    airSoftMatches[matchId].team1Score = airSoftMatches[matchId].team1Score + 1
                    triggerClientEvent("syncAirsoftInMatchData", hitElement, matchId, "team1", airSoftMatches[matchId].team1Score)
                end
            else
                if shooterTeam ~= victimTeam then
                    airSoftMatches[matchId].team2Score = airSoftMatches[matchId].team2Score + 1
                    triggerClientEvent("syncAirsoftInMatchData", hitElement, matchId, "team2", airSoftMatches[matchId].team2Score)
                end
            end
        end
        local time = airSoftMatches[matchId].reSpawn
        if (game.gm ~= "lms") or (game.gm == "lms" and game.state == "warmup") then
            respawnTimers[hitElement] = setTimer(respawnPlayer, time * 1000, 1, hitElement, victimTeam, matchId)
            respawnCameraTimers[hitElement] = setTimer(respawnPlayerCamera, (time * 1000) - 2000, 1, hitElement, victimTeam, matchId)
        elseif game.gm == "lms" and game.state ~= "warmup" then
            local aliveCount = 0
            for k, v in pairs(game.playerDatas) do
                if not v.eliminated  then
                    aliveCount = aliveCount + 1
                end
            end
            if aliveCount == 1 then
                if isTimer(matchRunTimers[matchId]) then
                    killTimer(matchRunTimers[matchId])
                end
                endMatch(matchId)
            end
        end
    else
        triggerClientEvent(shooter, "gotAirsoftDamage", shooter, x, y, z, damage, {bodypart, headshot})
        triggerClientEvent(hitElement, "syncAirsoftInMatchData", hitElement, matchId, "health", game.playerDatas[victimID].health)
    end
end)

function findPlayerMatch(playerElement)
    for id, match in pairs(airSoftMatches) do
        if match.playerElements and match.playerElements[playerElement] then
            return id
        end
    end
    return false
end

local flagHandler = {}
function occupiedFlagHandler()
    for matchId, matchData in pairs(airSoftMatches) do
        if matchData.flags then
            for flagId, flagData in pairs(matchData.flags) do
                local flag = flagData
                if flag.progress == 1 and flag.owner then
                    if matchData.state == "running" then
                        if flag.owner == 1 then
                            matchData.team1Score = matchData.team1Score + 2
                            triggerClientEvent("syncAirsoftInMatchData", root, matchId, "team1", airSoftMatches[matchId].team1Score)
                        elseif flag.owner == 2 then
                            matchData.team2Score = matchData.team2Score + 2
                            triggerClientEvent("syncAirsoftInMatchData", root, matchId, "team2", airSoftMatches[matchId].team2Score)
                        end
                    end
                end
            end
        end
    end
end

flagTimers = {}

function setFlagOccupied(matchId, flagId, client)
    local game = airSoftMatches[matchId]
    local playerId = game.playerElements[client]
    local playerTeam = game.playerDatas[playerId].team
    local flag = game.flags[flagId]

    if not flagHandler then
        flagHandler = setTimer(occupiedFlagHandler, 2000, 0)
    end

    if flag.progress == 1 and flag.owner == playerTeam then
        return
    end

    flag.captured = playerTeam
    flag.owner = playerTeam

    for k, v in pairs(flag.capture) do
        setPedAnimation(k)
    end

    flag.capturers = 0
    flag.beingCaptured = false
    flag.capture[client] = false

    if flag.owner == 1 then
        game.team1Score = game.team1Score + 50
        triggerClientEvent("syncAirsoftInMatchData", root, matchId, "team1", airSoftMatches[matchId].team1Score)
    elseif flag.owner == 2 then
        game.team2Score = game.team2Score + 50
        triggerClientEvent("syncAirsoftInMatchData", root, matchId, "team2", airSoftMatches[matchId].team2Score)
    end


    local teamColor = playerTeam == 1 and "[color=sightblue]" or "[color=sightred]"
    local playerName = getElementData(client, "char.name"):gsub("_", " ") 
    sendAirsoftChatMessage(client, getRealTime(), matchId, teamColor .. playerName .. " [color=sightlightgrey]elfoglalt egy zászlót (+50 és +2/s)")

    triggerClientEvent("syncAirsoftFlagOccupied", client, matchId, flagId)
end

local captureTime = 5050
local decayTime   = 7000
local minSlice    = 50

local function advanceProgress(flag)
    local now = getTickCount()
    local dt  = now - (flag.lastTick or now)

    local c = flag.capturers or 0
    if c ~= 0 then
        flag.progress = flag.progress + dt / captureTime * c
        flag.progress = math.max(0, math.min(1, flag.progress))
    end

    flag.lastTick = now
end

local function restartTimer(flag, flagId, matchId, client)
    if isTimer(flag.flagTimer) then killTimer(flag.flagTimer) end
    flag.flagTimer = nil

    local c = flag.capturers or 0
    if c == 0 then return end

    local game     = matchId and airSoftMatches[matchId]
    local playerId = game.playerElements[client]
    local playerTeam = game.playerDatas[playerId].team

    if not flag.capturingTeam then
        flag.capturingTeam = playerTeam
    end

    if flag.progress == 0 and c < 0 then
        flag.capturers = math.abs(c)
        c = flag.capturers

        triggerClientEvent("syncAirsoftFlagData", client, matchId, flagId, "flagTeam", 0)
        triggerClientEvent("syncAirsoftFlagData", root,   matchId, flagId, "flagging",    c)
    end

    local remain
    if c > 0 then
        remain = (1 - flag.progress) * captureTime / c
    else
        remain = flag.progress * captureTime / math.abs(c)
    end
    remain = math.max(minSlice, remain)

    flag.flagTimer = setTimer(function()
        advanceProgress(flag)

        if flag.progress >= 1 then
            setFlagOccupied(matchId, flagId, client)
            flag.captured = playerTeam
            return
        elseif flag.progress <= 0 then
            flag.progress = 0
            flag.captured = false

            flag.capturingTeam = playerTeam

            if flag.capturers < 0 then
                flag.capturers = math.abs(flag.capturers)
            end

            triggerClientEvent("syncAirsoftFlagData", client, matchId, flagId, "flagTeam", playerTeam)
        end

        triggerClientEvent("syncAirsoftFlagData", root,   matchId, flagId, "flagging",    flag.capturers)
        triggerClientEvent("syncAirsoftFlagData", client, matchId, flagId, "flagProgress", flag.progress)

        restartTimer(flag, flagId, matchId, client)
    end, remain, 1)
end

function getAirsoftPlayerTeam(playerElement)
    local matchId = findPlayerMatch(client)
    local game = matchId and airSoftMatches[matchId]
    local playerId = game.playerElements[client]
    local playerTeam = game.playerDatas[playerId].team
    return playerTeam or false
end

addEvent("airsoftFlaggingState", true)
addEventHandler("airsoftFlaggingState", root, function(flagId)
    if not client then client = source end
    if client ~= source then return end

    local matchId = findPlayerMatch(client)
    local game = matchId and airSoftMatches[matchId]
    if not game then return end

    local playerId = game.playerElements[client]
    if not playerId then return end
    local playerTeam = game.playerDatas[playerId].team

    if flagId and tonumber(flagId) then
        local flag = game.flags and game.flags[flagId]
        if not flag then return end

        if flag.beingCaptured then
            for k, v in pairs(flag.capture) do
                if k ~= client then
                    local capturerId = game.playerElements[k]
                    if capturerId then
                        local capturerTeam = game.playerDatas[capturerId].team
                        if capturerTeam ~= playerTeam then
                            return
                        end
                    end
                end
            end
        end
    
        flag.progress = flag.progress or 0
        flag.capture = flag.capture or {}
        flag.capturers = flag.capturers or 0
        flag.captured = flag.captured or false
    
        advanceProgress(flag)
    
        if not flag.capture[client] then
            flag.capture[client] = true
            setPedAnimation(client, "bomber", "bom_plant_loop", -1, true, false, false)

            local isMyFlag = (flag.captured == playerTeam)
            local isNeutral = (flag.captured == false)
    
            local previousCapturingTeam = flag.capturingTeam
    
            if isNeutral or isMyFlag then
                if previousCapturingTeam and previousCapturingTeam ~= playerTeam then
                    flag.capturers = flag.capturers - 1
                else
                    flag.capturers = flag.capturers + 1
                end
            else
                flag.capturers = flag.capturers - 1
            end
    
            if flag.progress > 0 and flag.progress < 1 and not isMyFlag and not isNeutral then
                if flag.capturers > 0 then
                    flag.capturers = -math.abs(flag.capturers)
                end
            elseif flag.progress > 0 and flag.progress < 1 and (isMyFlag or isNeutral) then
                if flag.capturers < 0 then
                    flag.capturers = math.abs(flag.capturers)
                end
            end
    
            if previousCapturingTeam and previousCapturingTeam ~= playerTeam and flag.capturers ~= 0 then
                flag.capturers = -math.abs(flag.capturers)
            end
        end
    
        flag.beingCaptured = true
        

        if not flag.captured and flag.progress == 0 then
            flag.captured = playerTeam
            triggerClientEvent("syncAirsoftFlagData", client, matchId, flagId, "flagTeam", flag.captured)
        end
    
        triggerClientEvent("syncAirsoftFlagData", client, matchId, flagId, "flagProgress", flag.progress)
        triggerClientEvent("syncAirsoftFlagData", root, matchId, flagId, "flagging", flag.capturers)
    
        restartTimer(flag, flagId, matchId, client)
    else
        for id, flag in pairs(game.flags) do
            if flag.capture and flag.capture[client] then
                advanceProgress(flag)

                local playerTeam = getAirsoftPlayerTeam(client)
                local capturingTeam = flag.capturingTeam
                flag.capture[client] = false
                local currentCapturers = 0

                for k, v in pairs(flag.capture) do
                    if k and isElement(k) and k ~= client then
                        if v then
                            local capturerTeam = getAirsoftPlayerTeam(k)
                            if capturingTeam == playerTeam then
                                if capturerTeam == playerTeam then
                                    currentCapturers = currentCapturers + 1
                                end
                            else
                                if capturerTeam == playerTeam then
                                    currentCapturers = currentCapturers - 1
                                end
                            end
                        end
                    end
                end

                setPedAnimation(client)
                flag.capturers = currentCapturers

                if flag.capturers == 0 then
                    flag.beingCaptured = false
                end
    
                triggerClientEvent("syncAirsoftFlagData", root, matchId, id, "flagging", flag.capturers)
    
                if flag.capturers ~= 0 then
                    restartTimer(flag, id, matchId, client)
                end
                break
            end
        end
    end
end)


function sendAirsoftChatMessage(client, time, matchId, message)
    if matchId and airSoftMatches[matchId] then
        local time = getRealTime()
        local date = string.format("%02d:%02d:%02d", time.hour, time.minute, time.second)  
    
        local line = "[color=sightmidgray] [".. date .."] "..message
        triggerClientEvent("gotAirsoftChatLine", client, matchId, line)
    else
        return false
    end
end

function cTeam(client, cmd, team)
    local team = tonumber(team)
    local matchId = findPlayerMatch(client)
    local game = matchId and airSoftMatches[matchId]
    if not game then return end

    local time = getRealTime()
    local date = string.format("%02d:%02d:%02d", time.hour, time.minute, time.second)
    local playerName = getElementData(client, "visibleName"):gsub("_", " ")
    local teamColorString = team == 1 and "sightblue" or "sightred"
    local teamNameString = team == 1 and "kék" or "piros"


    local line = "[color=sightmidgray] [".. date .."] [color=sightgreen]" .. playerName .. 
        " [color=hudwhite]csapatot váltott: [color=" .. teamColorString .. "]" .. teamNameString .. " csapat"
    triggerClientEvent("gotAirsoftChatLine", client, matchId, line)

    local playerId = game.playerElements[client]
    if not playerId then return end
    game.playerDatas[playerId].team = team
end

function getPlayerMatchID(player, matchId)
    if playerMatchIDs[player] and playerMatchIDs[player][matchId] then
        return playerMatchIDs[player][matchId]
    end
    return nil
end

function getPlayerByMatchID(matchId, playerID)
    if airSoftMatches[matchId] and airSoftMatches[matchId].playerDatas[playerID] then
        return airSoftMatches[matchId].playerDatas[playerID].client
    end
    return nil
end

local obj = createObject(2964, 988.13354492188, -1500.6882324219, 1999.1875 - 1, 0, 0, 90)
setElementDimension(obj, 1)
setElementInterior(obj, 1)

function distributeMatchPrizes(matchId)
    local game = airSoftMatches[matchId]
    if not game then return end
    
    local prizePool = game.playerNum * game.joinFee
    winners = determineWinners(matchId)

    local time = getRealTime()
    local date = string.format("%02d:%02d:%02d", time.hour, time.minute, time.second)
    
    if gameModes[game.gm].team then
        if winners.winningTeam == 0 then
            local line = "[color=sightmidgray] [".. date .."][color=sightlightgrey] A meccs döntetlen lett."
            triggerClientEvent("gotAirsoftChatLine", root, matchId, line)
            for playerID, data in pairs(game.playerDatas) do
                local player = data.client
                if isElement(player) and prizePool > 0 then
                    local currentMoney = exports.sCore:getMoney(player) or 0
                    exports.sCore:giveMoney(player, game.joinFee)
                    exports.sGui:showInfobox(player, "i", "A meccs döntetlen lett, visszakaptad a nevezési díjat: $" .. game.joinFee)
                    
                    triggerClientEvent(player, "showAirsoftWin", player, game.map, currentMoney, game.joinFee)
                end
            end
        else
            local winnerCount = 0
            for playerID, data in pairs(game.playerDatas) do
                if data.team == winners.winningTeam then
                    winnerCount = winnerCount + 1
                end
            end

            local teamText = winners.winningTeam == 1 and "[color=sightblue]kék" or "[color=sightred]piros"

            local line = "[color=sightmidgray] [".. date .."][color=sightlightgrey] A " .. teamText .. " csapat [color=sightlightgrey]győzött."
            triggerClientEvent("gotAirsoftChatLine", root, matchId, line)
            
            if winnerCount > 0 then
                local prizePerPlayer = math.floor(prizePool / winnerCount)
                
                for playerID, data in pairs(game.playerDatas) do
                    local player = data.client
                    if isElement(player) and prizePool > 0 then
                        local currentMoney = exports.sCore:getMoney(player) or 0
                        local prize = 0
                        
                        if data.team == winners.winningTeam then
                            exports.sCore:giveMoney(player, prizePerPlayer)
                            exports.sGui:showInfobox(player, "s", "Gratulálunk! Nyertél " .. prizePerPlayer .. " $-t!")
                            prize = prizePerPlayer
                        end
                        
                        triggerClientEvent(player, "showAirsoftWin", player, game.map, currentMoney, prize)
                    end
                end
            end
        end
    else
        local sortedPlayers = {}
        for playerID, data in pairs(game.playerDatas) do
            local k = data.k or 0
            local d = data.d or 0
            local kd = d > 0 and k/d or k
            local eliminated = data.eliminated or 0
            
            table.insert(sortedPlayers, {
                playerID = playerID,
                player = data.client,
                name = data.name,
                kills = k,
                deaths = d,
                kd = kd,
                client = data.client
            })
        end
        
        if game.gm == "lms" then
            table.sort(sortedPlayers, function(a, b)
                local aElim = a.eliminated or 0
                local bElim = b.eliminated or 0

                if aElim == 0 and bElim > 0 then
                    return true
                elseif bElim == 0 and aElim > 0 then
                    return false
                elseif aElim ~= bElim then
                    return aElim > bElim
                else
                    return a.kills > b.kills
                end
            end)
        else
            table.sort(sortedPlayers, function(a, b)
                if a.kills ~= b.kills then
                    return a.kills > b.kills
                else
                    return a.kd > b.kd
                end
            end)
        end
        
        local prizes = {
            math.floor(prizePool * 0.5),
            math.floor(prizePool * 0.3),
            math.floor(prizePool * 0.2)
        }

        
        local playerPrizes = {}
        for place = 1, math.min(3, #sortedPlayers) do
            local playerData = sortedPlayers[place]
            local player = playerData.client
            if isElement(player) and prizePool > 0 then
                playerPrizes[player] = prizes[place]
            end
        end
        
        for place = 1, math.min(3, #sortedPlayers) do
            local playerData = sortedPlayers[place]
            local player = playerData.client
            
            if isElement(player) and prizePool > 0 then
                exports.sCore:giveMoney(player, prizes[place])
                exports.sGui:showInfobox(player, "s", "Gratulálunk! " .. place .. ". helyezést értél el, nyertél " .. prizes[place] .. " $-t!")
            end
        end
        
        for playerID, data in pairs(game.playerDatas) do
            local player = data.client
            if isElement(player) and prizePool > 0 then
                local currentMoney = exports.sCore:getMoney(player) or 0
                local prize = playerPrizes[player] or 0
                triggerClientEvent(player, "showAirsoftWin", player, game.map, currentMoney, prize)
            end
        end
    end
    
    local chatLine = "[color=sightmidgray] [".. date .."] [color=sightlightgrey]A nyeremények kiosztásra kerültek!"
    
    for playerID, data in pairs(game.playerDatas) do
        local player = data.client
        if isElement(player) then
            triggerClientEvent(player, "gotAirsoftChatLine", player, matchId, chatLine)
        end
    end
end