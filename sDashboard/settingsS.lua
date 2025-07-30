local walkingStyle = {}
connection = exports.sConnection:getConnection()

addEvent("refreshWalkingStyle", true)
addEventHandler("refreshWalkingStyle", getRootElement(), function(val)
    setPedWalkingStyle(client, walkingStyles[val][1])

    walkingStyle[client] = walkingStyles[val][1]
end)

function getWalkingStyle(player)
    if walkingStyle[player] then
        return walkingStyle[player]
    end
end

addEvent("refreshFightingStyle", true)
addEventHandler("refreshFightingStyle", getRootElement(), function(val)
    setPedFightingStyle(client, fightingStyles[val])
end)

addEventHandler("onResourceStart", root, 
    function()
        setTimer(function()
            for k, v in ipairs(getElementsByType("player")) do
                triggerClientEvent(v, "gotLocalUserName", v, getElementData(v, "acc.Name"))
                triggerClientEvent(v, "refreshPlayedMinutes", v, exports.sCore:getPlayedMinutes(v))
            end
        end, 1000, 1)
    end
)

--[[
azert nem igy irom be, mert hogyha valaki ledumpolja tul konnyu dolga lesz visszairni a szerooldalt.
invitedMembers = {
    {
        accountIdentity = 1,
        playerName = "Dennis Mercury",
        lastOnline = "2025.02.29",
        playedMinutes = math.random(1, 250000),
        --Ezeket kell még menteni:
        --onlineStreak: 1-online volt, 2-nem volt online
        onlineStreak = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
        haveWorked = false,
        wasInGroup = false,
        boughtVehicle = false,
        boughtHouse = false,
    },
}
]]

invitedMembers = {
}

local names = {
    "Sasha", "Raylan", "Addyson", "Morgan", "Sutton", "Jamari", "Leila", "Wilson", "Liliana", "Marlon",
    "Rowan", "Mylo", "Laurel", "Phoenix", "Emberly", "Sage", "Carly", "Murphy", "Joy", "Callen",
    "Veronica", "Matias", "Sofia", "Idris", "Livia", "Hugh", "Zoey", "Genesis", "Noelle", "Luis",
    "Bonnie", "Bryant", "Brayden", "Jazmin", "King", "Alanna", "Keith", "Bristol", "Mack", "Carolina",
    "Davis", "Marie", "Jones", "Virginia", "Dario", "Oaklee", "Jonas", "Sarah", "Davian", "Barbara",
    "Jamir", "Nalani", "Miller", "Leilany", "Arthur", "Emerson", "Curtis", "Artemis", "Sawyer", "Tessa",
    "Allen", "Lilyana", "Jayden", "Makenna", "Braden", "Anika", "Jacob", "Shay", "Collin", "Deborah",
    "Maximiliano", "Rosie", "Asher", "Catalina", "Cyrus", "Mariam", "Dustin", "Colette", "Gustavo",
    "Joyce", "Judah", "Dakota", "Stefan", "Bellamy", "Xavier", "Avayah", "Rio", "Rylan", "Dexter",
    "Adalee", "Gabriel", "Elina", "Jamal", "Kataleya", "Cyrus", "Zuri", "Malakai", "Noah", "Edgar",
    "June", "Owen", "June", "Ameer", "Amara", "Ty", "Rachel", "Trevor", "Clara", "Otto", "Julieta",
    "Marcos", "Yaretzi", "Thatcher", "Dream", "Hugo", "Paige", "Elijah", "Khloe", "Theodore", "Oaklee",
    "Richard", "Indie", "Abner", "Rebecca", "Gordon", "Cassandra", "Jamari", "Natasha", "Moshe", "Naomi",
    "Jakobe", "Harmoni", "Ledger", "Yareli", "Madden", "Kamiyah", "Reece", "Gloria", "Cameron", "Zuri",
    "Marcos", "Ariella", "Aaron", "Marlee", "Azariah", "Eliza", "Shiloh", "Zara", "Ty", "Mina", "Kai",
    "Catherine", "Jaylen", "April", "Jaxson", "Gloria", "Abel", "Zariyah", "Luca", "Brynn", "Josue",
    "Julieta", "Cason", "Allison", "Christopher", "Jovie", "Ahmad", "Catalina", "Mac", "Yareli",
    "Devon", "Juliana", "Nixon", "Nathalia", "Gage", "Milena", "Ocean", "Jenesis", "Maverick", "Alia",
    "Watson", "Penelope", "Brett", "Bristol", "Brian", "Dahlia", "Alfred", "Ariana", "Lawson", "Sunny",
    "Milan", "Nataly", "Kai", "Lilianna", "Dariel", "Kiara", "Ricky", "Myla", "Jaxtyn", "Lyanna",
    "Dane", "Frances", "Byron", "Aarya", "Bruno"
}

local surnames = {
    "Jefferson", "Dorsey", "Ho", "Campos", "Valenzuela", "Peters", "Horn", "Barnes", "Jarvis", "Carr",
    "Sexton", "Dillon", "Estrada", "Burnett", "Garner", "Monroe", "Schmitt", "Daniel", "Norton", "Dawson",
    "Lane", "Taylor", "Noble", "Buck", "Macdonald", "Young", "Bravo", "Elliott", "Ford", "Poole",
    "Yu", "Campos", "Gonzales", "Atkinson", "Holmes", "Shaffer", "Whitaker", "Waters", "Glover", "Goodman",
    "Burnett", "Pittman", "Krueger", "Hoover", "Frost", "Huynh", "Gallegos", "Gray", "Good", "Bernard",
    "Mathews", "Carson", "Rich", "Stein", "Mendez", "Burns", "Brennan", "Vo", "Jordan", "Garrett",
    "Mullins", "Bender", "Torres", "Lin", "Leblanc", "Kemp", "Anderson", "Mullen", "Castaneda", "Nixon",
    "Montgomery", "Hubbard", "Young", "Stone", "Lyons", "Boone", "Barron", "Lindsey", "Mathis", "McCann",
    "Garza", "Vega", "Nava", "O’Donnell", "Alvarez", "Hayden", "Dejesus", "Hurley", "Shaffer", "Hurst",
    "Nguyen", "Compton", "Benton", "Winters", "Lyons", "Chapman", "Marquez", "Everett", "Salinas", "Mills",
    "Perez", "Mills", "Spears", "Fernandez", "Farrell", "Pena", "Bowen", "Perry", "Robles", "Jefferson",
    "Gallagher", "Floyd", "Quintero", "Bowen", "Swanson", "Li", "Brown", "Hunter", "Thompson", "Huynh",
    "Bradley", "Preston", "Compton", "Morrison", "Vo", "Sosa", "Valenzuela", "Donaldson", "Macias", "Phillips",
    "Hickman", "Tanner", "Christian", "Pennington", "Sellers", "Melton", "Underwood", "Rangel", "Murphy",
    "Chapman", "Gallagher", "Webb", "Morales", "Fitzgerald", "Wiggins", "Romero", "Anthony", "Carroll",
    "Farrell", "Atkins", "Castillo", "Williamson", "Avila", "McGuire", "James", "Rangel", "Warren", "Booth",
    "Gutierrez", "Craig", "Reid", "Jefferson", "Atkins", "Richardson", "Campbell", "Finley", "Combs", "Stone",
    "Huber", "Pennington", "Shields", "Ferguson", "Sweeney", "Good", "Franco", "Livingston", "Sloan", "Bean",
    "Carter", "Briggs", "Carey", "Harris", "Dougherty", "Waters", "Sims", "McDaniel", "Potts", "Ward",
    "Becker", "Rich", "Serrano", "Booker", "Castillo", "Walls", "Davenport", "Pearson", "Beltran", "Le",
    "Bryan", "Roach", "McFarland", "Blair", "Berger", "Mayo", "Tanner", "Lee"
}

function getRandomName()
    local firstName = names[math.random(#names)]
    local lastName = surnames[math.random(#surnames)]
    return firstName .. "_" .. lastName
end

function getInvitedPlayersWithData(inviteCode)
    local invitedPlayers = {}
    local query = dbQuery(connection, "SELECT accountId, achievements, online, lastOnline, loginStreak FROM accounts WHERE invitedBy = ?", inviteCode)
    local accountsResult = dbPoll(query, -1)
    
    if accountsResult and #accountsResult > 0 then
        for _, account in ipairs(accountsResult) do
            local accountId = account.accountId
            local achievements = account.achievements or "0:0:0:0"
            local online = account.online
            local lastOnline = account.lastOnline
            local onlineStreak = account.loginStreak
            
            local queryChar = dbQuery(connection, "SELECT name, playedMinutes FROM characters WHERE accountId = ?", accountId)
            local charResult = dbPoll(queryChar, -1)
            local charName = ""
            local playedMinutes = 0
            if charResult and #charResult > 0 then
                local character = charResult[1]
                charName = character.name
                playedMinutes = character.playedMinutes
            end
            
            local worked, wasInFaction, boughtVehicle, boughtHouse = 0, 0, 0, 0
            local parts = {}
            for part in string.gmatch(achievements, "[^:]+") do
                table.insert(parts, part)
            end

            if #parts >= 4 then
                worked        = parts[1]
                wasInFaction  = parts[2]
                boughtVehicle = parts[3]
                boughtHouse   = parts[4]
            end


            local isOnline = (online == "Y") and 1 or 0
            
            local playerData = {
                tonumber(accountId),
                charName,
                tonumber(lastOnline),
                tonumber(playedMinutes),
                onlineStreak,
                tonumber(worked),
                tonumber(wasInFaction),
                tonumber(boughtVehicle),
                tonumber(boughtHouse),
                isOnline
            }
            
            table.insert(invitedPlayers, playerData)
        end
    end
    
    return invitedPlayers
end

function generateRandomPlayers(count)
    local randomPlayers = {}

    for i = 1, count do
        local accountId = i
        local charName = getRandomName()


        local playedMinutes = math.random(0, 50000)
        local onlineStreak = {}

        for j = 1, 30 do
            onlineStreak[j] = math.random(0, 1)
        end

        local worked = math.random(0, 1)
        local wasInFaction = math.random(0, 1)
        local boughtVehicle = math.random(0, 1)
        local boughtHouse = math.random(0, 1)
        local isOnline = math.random(0, 1)
        local randomTime = isOnline == 1 and getRealTime().timestamp or getRealTime().timestamp - math.random(1, 15000000)

        local playerData = {
            accountId,
            charName,
            randomTime,
            playedMinutes,
            onlineStreak,
            worked,
            wasInFaction,
            boughtVehicle,
            boughtHouse,
            isOnline
        }

        table.insert(randomPlayers, playerData)
    end
    return randomPlayers
end

addCommandHandler("giveachievement", function(sourcePlayer, sourceCommand, targetPlayer, achievementType)
    --TODO
end)

function isInviteCodeOccupied(inviteCode)
    local query = dbQuery(connection, "SELECT COUNT(*) AS count FROM accounts WHERE inviteCode = ?", inviteCode)
    local result = dbPoll(query, -1)
    
    if result and result[1] and tonumber(result[1].count) > 0 then
        return true
    else
        return false
    end
end

function generateInviteCode()
    local chars = "ABCDEFGHIJKLMNOPQRSTUVWXY123456789"
    local code = ""
    repeat
        code = ""
        for i = 1, 6 do
            local index = math.random(1, #chars)
            code = code .. chars:sub(index, index)
        end
    until 
        not isInviteCodeOccupied(code)
    return code
end

function updatePlayerInviteCode(playerElement, inviteCode)
    local inviteCode = inviteCode
    local accountId = getElementData(playerElement, "char.accID")
    if not accountId then
        return false
    end

    if not inviteCode then
        inviteCode = generateInviteCode()
    end

    local query = dbQuery(connection, "SELECT inviteCode FROM accounts WHERE accountId = ?", accountId)
    local result = dbPoll(query, -1)
    
    if result and result[1] then
        local oldInviteCode = result[1].inviteCode
        dbExec(connection, "UPDATE accounts SET inviteCode = ? WHERE accountId = ?", inviteCode, accountId)
        dbExec(connection, "UPDATE accounts SET invitedBy = ? WHERE invitedBy = ?", inviteCode, oldInviteCode)
        return true
    else
        return false
    end
end


function getPlayerInviteCode(playerElement)
    local accountId = getElementData(playerElement, "char.accID")
    if not accountId then
        return false
    end

    local query = dbQuery(connection, "SELECT inviteCode FROM accounts WHERE accountId = ?", accountId)
    local result = dbPoll(query, -1)

    if result and result[1] and result[1].inviteCode then
        return result[1].inviteCode
    else
        return false
    end
end

addCommandHandler("changeinvitecode", function(sourcePlayer, sourceCommand, targetPlayer, newInviteCode)
    if exports.sPermission:hasPermission(sourcePlayer, "runcode") then
        if not targetPlayer or not newInviteCode or string.len(newInviteCode) > 6 or string.len(newInviteCode) < 3 then
            outputChatBox("[color=sightblue][SightMTA - Használat]: [color=hudwhite]/changeinvitecode [Játékos Név / ID)] [Invite kód (min. 3, max 6)]", sourcePlayer)
            return
        end

        local targetPlayer, targetName = exports.sCore:findPlayer(sourcePlayer, targetPlayer)
        if targetPlayer then
            if not isInviteCodeOccupied(newInviteCode) then
                if updatePlayerInviteCode(targetPlayer, newInviteCode) then
                    outputChatBox("[color=sightgreen][SightMTA - Meghívókód]: [color=hudwhite]Sikeresen megváltoztattad a [color=sightgreen]"..getElementData(targetPlayer, "visibleName"):gsub("_", " ").."[color=hudwhite] meghívókódját! [color=sightgreen]["..newInviteCode.."]", sourcePlayer)
                    
                    exports.sGui:showInfobox(targetPlayer, "s", "Egy adminisztrátor megváltoztatta a meghívókódod! ["..newInviteCode.."]")

                    for k, v in pairs(getElementsByType("player")) do
                        if getElementData(v, "acc.adminLevel") >= 6 then
                            outputChatBox("[color=sightyellow][SightMTA - Meghívókód]: [color=hudwhite]Egy adminisztrátor [color=sightyellow]("..getElementData(sourcePlayer, "visibleName"):gsub("_", " ")..") [color=hudwhite]megváltoztatta "..getElementData(targetPlayer, "visibleName"):gsub("_", " ").." meghívókódját! [color=sightyellow]["..newInviteCode.."]", v)
                        end
                    end
                else
                    outputChatBox("[color=sightred][SightMTA - Meghívókód]: [color=hudwhite]Hiba történt a meghívókód véglegesítése során!", sourcePlayer)
                end
            else
                outputChatBox("[color=sightred][SightMTA - Meghívókód]: [color=hudwhite]Ez a meghívókód már foglalt! [color=sightred]["..newInviteCode.."]", sourcePlayer)
            end
        end
    end
end)

addCommandHandler("resetinvitecode", function(sourcePlayer, sourceCommand, targetPlayer)
    if exports.sPermission:hasPermission(sourcePlayer, "runcode") then
        if not targetPlayer then
            outputChatBox("[color=sightblue][SightMTA - Használat]: [color=hudwhite]/resetinvitecode [Játékos Név / ID]", sourcePlayer)
            return
        end

        local targetPlayer, targetName = exports.sCore:findPlayer(client, targetPlayer)
        local invCode = generateInviteCode()
        if targetPlayer and invCode then
            if updatePlayerInviteCode(targetPlayer, invCode) then
                outputChatBox("[color=sightgreen][SightMTA - Meghívókód]: [color=hudwhite]Sikeresen alaphelyzetbe állítottad "..getElementData(targetPlayer, "visibleName"):gsub("_", " ").." meghívókódját! ["..invCode.."]")
            
                exports.sGui:showInfobox(targetPlayer, "s", "Egy adminisztrátor alaphelyzetbe állította a meghívókódod! ["..invCode.."]")

                for k, v in pairs(getElementsByType("player")) do
                    if getElementData(v, "acc.adminLevel") >= 6 then
                        outputChatBox("[color=sightyellow][SightMTA - Meghívókód]: [color=hudwhite]Egy adminisztrátor [color=sightyellow]("..getElementData(sourcePlayer, "visibleName"):gsub("_", " ")..") [color=hudwhite]alaphelyzetbe állította "..getElementData(targetPlayer, "visibleName"):gsub("_", " ").." meghívókódját! [color=sightyellow]["..invCode.."]", v)
                    end
                end
            else
                outputChatBox("[color=sightred][SightMTA - Meghívókód]: [color=hudwhite]Hiba történt a meghívókód véglegesítése során!", sourcePlayer)
            end
        end
    end
end)

addEvent("requestPlayerInvitationCode", true)
addEventHandler("requestPlayerInvitationCode", root, function()
    if source and source == client then
        triggerClientEvent(client, "gotInvitationCode", client, getPlayerInviteCode(client))
    end
end)

function setPlayerTakenAchievementPrize(playerElement, awardIndex)
    if not isElement(playerElement) then return end
    if not awardIndex or type(awardIndex) ~= "number" then return end

    local accountId = getElementData(playerElement, "char.accID")
    if not accountId then return end

    local dataString = getElementData(playerElement, "char.takenAchievements") or ""
    local takenAchievements = {}

    for number in string.gmatch(dataString, "%d+") do
        takenAchievements[tonumber(number)] = true
    end

    if not takenAchievements[awardIndex] then
        takenAchievements[awardIndex] = true
    end

    local newString = ""
    for index in pairs(takenAchievements) do
        newString = newString .. index .. ","
    end
    newString = newString:sub(1, -2)

    setElementData(playerElement, "char.takenAchievements", newString)

    local query = string.format("UPDATE accounts SET takenAchievements='%s' WHERE accountId='%d'", dbPrepareString(connection, newString), accountId)
    dbExec(connection, query)
end

function isAwardTaken(playerElement, awardIndex)
    if not isElement(playerElement) then return false end
    if not awardIndex or type(awardIndex) ~= "number" then return false end

    local dataString = getElementData(playerElement, "char.takenAchievements")

    if not dataString or dataString == "" then
        local accountId = getElementData(playerElement, "char.accID")
        if not accountId then return false end

        local result = dbPoll(dbQuery(connection, "SELECT takenAchievements FROM accounts WHERE accountId=?", accountId), -1)
        if result and result[1] and result[1].takenAchievements then
            dataString = result[1].takenAchievements
            setElementData(playerElement, "char.takenAchievements", dataString)
        else
            return false
        end
    end

    for number in string.gmatch(dataString, "%d+") do
        if tonumber(number) == awardIndex then
            return true
        end
    end

    return false
end

function givePlayerAchievement(playerElement, achievementType)
    local accountId = getElementData(playerElement, "char.accID")
    if not accountId then return end

    local currentAchievements = getElementData(playerElement, "char.achievements") or "0:0:0:0"

    local achievementTable = split(currentAchievements, ":")

    for i = 1, 4 do
        achievementTable[i] = tonumber(achievementTable[i]) or 0
    end

    --[1 - work, 2 - group, 3 - vehicle, 4 - interior]

    if achievementType == "work" then
        achievementTable[1] = 1
    elseif achievementType == "group" then
        achievementTable[2] = 1
    elseif achievementType == "vehicle" then
        achievementTable[3] = 1
    elseif achievementType == "interior" then
        achievementTable[4] = 1
    else
        return
    end

    local newAchievements = table.concat(achievementTable, ":")

    setElementData(playerElement, "char.achievements", newAchievements)

    local query = string.format("UPDATE accounts SET achievements='%s' WHERE accountId='%d'", newAchievements, accountId)
    dbExec(connection, query)
end

local invitedMembers = {}
addEvent("requestPlayerInvitations", true)
addEventHandler("requestPlayerInvitations", root, function()
    if client and client == source then
        local inviteCode = getPlayerInviteCode(client)
        local invitedPlayers = getInvitedPlayersWithData(inviteCode)
        triggerLatentClientEvent(client, "gotPlayerInvitations", client, invitedPlayers)
    end
end)

--[[
local awardDetails = {
    --Tudsz hozzaadni is az elkeszult dolgokbol egyebkent, kimasolsz egy sort es beilleszed, arra figyelj oda, hogy clientside is add hozza
    --Ha itt kesz vagy / clientsideon elmeletben ugyan ugy kene kinezzen a ket tabla, csak a tabla nevre figyelj oda.
    {"invite:1", awardLabel = "Hívj meg 1 embert", reward = {100, "premium"}},
    {"invite:3", awardLabel = "Hívj meg 3 embert", reward = {100, "premium"}},
    {"invite:5", awardLabel = "Hívj meg 5 embert", reward = {100, "premium"}},
    {"invite:10", awardLabel = "Hívj meg 10 embert", reward = {100, "premium"}},
    {"invite:15", awardLabel = "Hívj meg 15 embert", reward = {100, "premium"}},
    {"invite:20", awardLabel = "Hívj meg 20 embert", reward = {100, "premium"}},
    {"invite:25", awardLabel = "Hívj meg 25 embert", reward = {100, "premium"}},
    {"invite:30", awardLabel = "Hívj meg 30 embert", reward = {100, "premium"}},
    {"invite:40", awardLabel = "Hívj meg 40 embert", reward = {100, "premium"}},
    {"invite:50", awardLabel = "Hívj meg 50 embert", reward = {100, "premium"}},
    
    {"earn:1:lvl:10", awardLabel = "1 meghívottad érje el a 10-es szintet!", reward = {100, "premium"}},
    {"earn:2:lvl:15", awardLabel = "2 meghívottad érje el a 15-es szintet!", reward = {100, "premium"}},
    {"earn:5:lvl:20", awardLabel = "5 meghívottad érje el a 20-es szintet!", reward = {100, "premium"}},
    {"earn:3:lvl:25", awardLabel = "3 meghívottad érje el a 25-es szintet!", reward = {100, "premium"}},
    {"earn:1:lvl:30", awardLabel = "1 meghívottad érje el a 30-es szintet!", reward = {100, "premium"}},

    {"work:1", awardLabel = "Kezdjen el 1 általad meghívott játékos dolgozni!", reward = {100, "premium"}},
    {"work:3", awardLabel = "Kezdjen el 3 általad meghívott játékos dolgozni!", reward = {100, "premium"}},
    {"work:5", awardLabel = "Kezdjen el 5 általad meghívott játékos dolgozni!", reward = {100, "premium"}},
    
    {"group:1", awardLabel = "Csatlakozzon 1 általad meghívott játékos egy frakcióba", reward = {100, "premium"}},
    {"group:3", awardLabel = "Csatlakozzon 3 általad meghívott játékos egy frakcióba", reward = {100, "premium"}},
    {"group:5", awardLabel = "Csatlakozzon 5 általad meghívott játékos egy frakcióba", reward = {100, "premium"}},
    {"group:10", awardLabel = "Csatlakozzon 10 általad meghívott játékos egy frakcióba", reward = {100, "premium"}},
    
    {"buy:1:vehicle", awardLabel = "Vásároljon 1 általad meghívott játékos autót!", reward = {100, "premium"}},
    {"buy:3:vehicle", awardLabel = "Vásároljon 3 általad meghívott játékos autót!", reward = {100, "premium"}},
    {"buy:5:vehicle", awardLabel = "Vásároljon 5 általad meghívott játékos autót!", reward = {100, "premium"}},
    {"buy:10:vehicle", awardLabel = "Vásároljon 10 általad meghívott játékos autót!", reward = {100, "premium"}},
    
	{"buy:1:house", awardLabel = "Vásároljon 1 általad meghívott játékos házat!", reward = {100, "premium"}},
    {"buy:3:house", awardLabel = "Vásároljon 3 általad meghívott játékos házat!", reward = {100, "premium"}},
    {"buy:5:house", awardLabel = "Vásároljon 5 általad meghívott játékos házat!", reward = {100, "premium"}},
    {"buy:10:house", awardLabel = "Vásároljon 10 általad meghívott játékos házat!", reward = {100, "premium"}},
	
	{"buy:1:house-vehicle",  awardLabel = "Vásároljon 1 általad meghívott játékos autót és házat!", reward = {100, "premium"}},
	{"buy:3:house-vehicle",  awardLabel = "Vásároljon 3 általad meghívott játékos autót és házat!", reward = {100, "premium"}},
	{"buy:5:house-vehicle",  awardLabel = "Vásároljon 4 általad meghívott játékos autót és házat!", reward = {100, "premium"}},

    {"play:1:day:3", awardLabel = "Játszon sorozatban 1 általad meghívott játékos 3 napot!", reward = {100, "premium"}},
    {"play:1:day:7", awardLabel = "Játszon sorozatban 1 általad meghívott játékos 7 napot!", reward = {100, "premium"}},
    {"play:1:day:14", awardLabel = "Játszon sorozatban 1 általad meghívott játékos 14 napot!", reward = {100, "premium"}},
    {"play:1:day:30", awardLabel = "Játszon sorozatban 1 általad meghívott játékos 30 napot!", reward = {100, "premium"}}, 

    {"earn:together:lvl:100", awardLabel = "A meghívott játékosaid szintje érje el a lvl100-at!", reward = {100, "premium"}},
    {"earn:together:hour:100", awardLabel = "A meghívott játékosaid érjék el eggyütessen 100 játszott órát!", reward = {100, "premium"}},

    {"have:self:allachievements", awardLabel = "Érd el az összes meghívás jutalmat", reward = {100, "premium"}}, --Egyedul ez nincs meg kesz.
}
    ]]

local playerAwards = {}

function checkPlayerAchievements(invitedMembers, playerElement)
    local playerAwards = {}
    for awardIndex, awardDetail in ipairs(awardDetails) do
        local condition = awardDetail[1]
        local reward = awardDetail.reward or {0, "money"}
        local awardParts = split(condition, ":")

        local done = false

        if awardParts[1] == "invite" then
            local targetAmount = tonumber(awardParts[2])
            if targetAmount and #invitedMembers >= targetAmount then
                done = true
            end
        elseif awardParts[1] == "earn" then
            if awardParts[2] == "together" then
                if awardParts[3] == "lvl" then
                    local targetAmount = tonumber(awardParts[4])
                    local totalLevel = 0
        
                    for invitedIndex, invitedMember in pairs(invitedMembers) do
                        totalLevel = totalLevel + exports.sCore:getLevel(invitedMember[4])
                    end
        
                    if totalLevel >= targetAmount then
                        done = true
                    end
        
                elseif awardParts[3] == "hour" then
                    local targetAmount = tonumber(awardParts[4])
                    local totalHours = 0
        
                    for invitedIndex, invitedMember in pairs(invitedMembers) do
                        totalHours = totalHours + ((invitedMember[4] / 60) or 0)
                    end
        
                    if totalHours >= targetAmount then
                        done = true
                    end
                end
            else
                if awardParts[3] == "lvl" then
                    local targetAmount = tonumber(awardParts[4])
                    for invitedIndex, invitedMember in pairs(invitedMembers) do
                        if exports.sCore:getLevel(invitedMember[4]) >= targetAmount then
                            done = true
                        end
                    end
                end
            end
        elseif awardParts[1] == "work" then
            local targetAmount = tonumber(awardParts[2])
            local workingCount = 0
            for invitedIndex, invitedMember in pairs(invitedMembers) do
                if invitedMember[6] == 1 then
                    workingCount = workingCount + 1
                end
            end

            if workingCount >= targetAmount then
                done = true
            end
        elseif awardParts[1] == "group" then
            local targetAmount = tonumber(awardParts[2])
            local factionCount = 0
            for invitedIndex, invitedMember in pairs(invitedMembers) do
                if invitedMember[7] == 1 then
                    factionCount = factionCount + 1
                end
            end

            if factionCount >= targetAmount then
                done = true
            end
        elseif awardParts[1] == "buy" then
            local targetAmount = tonumber(awardParts[2])
            local boughtCount = 0
        
            local targetQuest = awardParts[3] == "vehicle" and {8} or awardParts[3] == "house" and {9} or awardParts[3] == "house-vehicle" and {8, 9}
        
            if type(targetQuest) == "table" then
                local vehicleCount = 0
                local houseCount = 0
        
                for invitedIndex, invitedMember in pairs(invitedMembers) do
                    if invitedMember[8] == 1 then
                        vehicleCount = vehicleCount + 1
                    end
                    if invitedMember[9] == 1 then
                        houseCount = houseCount + 1
                    end
                end
                
                if vehicleCount >= targetAmount and houseCount >= targetAmount then
                    done = true
                end
            else
                for invitedIndex, invitedMember in pairs(invitedMembers) do
                    if invitedMember[targetQuest] == 1 then
                        boughtCount = boughtCount + 1
                    end
                end
        
                if boughtCount >= targetAmount then
                    done = true
                end
            end

        elseif awardParts[1] == "play" then
            local targetPlayStreak = tonumber(awardParts[4])
            
            local streakCount = 0
            local maxStreak = 0
        
            for i = 1, #invitedMembers do
                local invitedMember = invitedMembers[i]
                local onlineStreak = invitedMember[5]
        
                local currentStreak = 0
                for day = 30, 1, -1 do
                    if onlineStreak[day] == 1 then
                        currentStreak = currentStreak + 1
                    else
                        break
                    end
                end
        
                if currentStreak >= targetPlayStreak then
                    done = true
                end
            end
        end
        
        playerAwards[awardIndex] = {
            reward = reward,
            done = done,
            taken = isAwardTaken(playerElement, awardIndex)
        }
    end
    return playerAwards
end

addEvent("givePlayerAwardPrize", true)
addEventHandler("givePlayerAwardPrize", root, function(awardIndex)
    if client and client == source then
        local inviteCode = getPlayerInviteCode(client)
        local invitedPlayers = getInvitedPlayersWithData(inviteCode)
        local playerAwards = checkPlayerAchievements(invitedPlayers, client)

        if not playerAwards[awardIndex].taken and playerAwards[awardIndex].done then
            local rewardType = playerAwards[awardIndex].reward[2]
            local rewardAmount = playerAwards[awardIndex].reward[1]
            setPlayerTakenAchievementPrize(client, awardIndex)

            if rewardType == "premium" then
                triggerLatentClientEvent(client, "updatePlayerAwardData", client, awardIndex, true)
                exports.sCore:givePP(client, rewardAmount)
            else
                triggerLatentClientEvent(client, "updatePlayerAwardData", client, awardIndex, true)
                exports.sCore:giveMoney(client, rewardAmount)
            end
            
            exports.sGui:showInfobox(client, "s", "Sikeresen átvetted a jutalmadat! (" .. rewardAmount .. " " .. (rewardType == "premium" and "PP" or "$") .. ")")
        else
            if not playerAwards[awardIndex].done then
                return
            end
            exports.sGui:showInfobox(client, "e", "Ezt a jutalmat már átvetted!")
        end
    end
end)

addEvent("requestPlayerAwardDetails", true)
addEventHandler("requestPlayerAwardDetails", root, function()
    if client and client == source then
        local inviteCode = getPlayerInviteCode(client)
        local invitedPlayers = getInvitedPlayersWithData(inviteCode)
        local playerAwards = checkPlayerAchievements(invitedPlayers, client)
        triggerLatentClientEvent(client, "gotPlayerAwardData", client, playerAwards)
    end
end)