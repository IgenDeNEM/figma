local roomDatas = {}

local waitTime = 20

local totalTime = 0

local playerHasTicketFor = {}

local roomQueue = {
    [1] = {},
    [2] = {},
}

local currentFilm = false
--[[
local links = {
    {"tc8xRWyHp3M", "Busák József személyazonosságai", 60},
    {"bXkojm481xU", "Lakatos Ali 80 milliós háza - Busák Józsi HOUSE TOUR", 250},
    {"doA_m4azblU", "Busák József gyrosos karddal támad a rendőrökre", 250},
    {"_N97XBwUosE", "Busák Ali Gammernak üzen", 30},
}--]]

local links = { -- EMBED, CÍM, HOSSZ
    {"l1l178L4b-c", "Taxi I.", 5178}, -- SightMTA Filmek
    {"FlHcRcIWfXo", "Üvegtigris I", 6222},
    {"Sgl5BkHCoK0", "Üvegtigris II.", 6485},
    {"cklnctnGhV4", "Gengszterzsaruk", 8433},
    {"RLKvLeyGJfQ", "Lopott idő", 6293}, 
    --{"bs1k2r5BcWc", "Kill Bill", 6651}, -- SeeMTA Filmek (korhatáros)
    --{"RDQt4FB67pY", "Machete Gyilkol", 6305}, (korhatáros)
    {"o4lG7GKSdsc", "Született Gengszterek", 5703},
    {"h1bQHGwXVzc", "Kém a szomszédban", 5664},
    {"OLomMqpHP6E", "Száguldás a semmibe", 5478},
    {"HI8VdHmNHmM", "Az ördög jobb és bal keze II.", 7556},
    {"b9pOldV2zOM", "Kiből lesz a cserebogár", 4958},
    {"0piiNk_jMrE", "Mindenki Sing", 1504},
    {"KNzdz8qe33Y", "Kung Fury", 1860},
    {"1XZH4ZS5SXg", "Bud Spencer: Nincs kettő négy nélkül", 6234},
    {"a2wKXY_k-TA", "Nyomás utána!", 6575},
    {"6-4Rr_YI9F8", "Csonthülye I.", 5821},
    {"hkFXPko-8bk", "Csonthülye II.", 6043},

}

local ads = {
    {"tE-tYo7-Htc", 15}
}

local filmTimers = {}

function startMovie(i, k, film, title, length)
    local ad = ads[math.random(1, #ads)]
    triggerClientEvent("refreshRoomLights", resourceRoot, i, true)
    roomDatas[i] = {ad[1], 0, "Reklám", ad[2], false, ad[2], getRealTime().timestamp}
    triggerClientEvent("gotRoomData", resourceRoot, i, roomDatas[i])
    setTimer(function(i, k, film, title, length)
        roomDatas[i] = {film, 0, title, length, false, length, getRealTime().timestamp}
        triggerClientEvent("gotRoomData", resourceRoot, i, roomDatas[i])
        setTimer(setRoomLightOn, length * 1000, 1, i)
        setTimer(generateNewFilm, length * 1000, 1, i, k)
    end, ad[2] * 1000, 1, i, k, film, title, length)
end


function setRoomLightOn(i)
    triggerClientEvent("refreshRoomLights", resourceRoot, i, false)
end

insideCols = {
    createColSphere(1160.0201416016, -1507.3751220703, 15.800888061523, 2),
    createColSphere(1168.5684814453, -1511.5372314453, 22.803665161133, 2),
}

for i = 1, #insideCols do
    setElementData(insideCols[i], "cinemaRoom", i)
end

function onColHit(hitElement, matchDim)
    if matchDim and isElement(source) then
        local i = getElementData(source, "cinemaRoom")
        if i then
            local nextFilm = getNextFilm(i)
            local filmTitle, filmTime = nextFilm[1], nextFilm[2]
            local time = getRealTime(filmTime)
            local formattedTime = string.format("%02d:%02d", time.hour, time.minute)
            outputChatBox("[color=sightblue][SightMTA - Információ]#ffffff Következő vetítés: Ma ".. formattedTime .." - ".. filmTitle .."", hitElement, 255, 255, 255)
        end
    end
end
addEventHandler("onColShapeHit", root, onColHit)

function generateNewFilm(i)
    local randomNum = roomQueue[i][1][6]
    local randomLink = links[randomNum]
    table.remove(roomQueue[i], 1)
    local allTotal = roomQueue[i][#links - 1][3]
    totalTime = totalTime + waitTime + (allTotal * 1000)
    roomQueue[i][#links] = {randomLink[1], k, randomLink[3], randomLink[2], (getRealTime().timestamp) + (totalTime / 1000), randomNum, getRealTime().timestamp + randomLink[3] + 10}
    filmTimers[i][4] = setTimer(startMovie, totalTime, 1, i, 4, randomLink[1], randomLink[2], randomLink[3])
    triggerClientEvent("gotRoomQueue", resourceRoot, i, roomQueue[i])
end

function generateRooms()
    for i = 1, 2 do
        if i == 2 then
            totalTime = 0
        end
        filmTimers[i] = {}
        local randomNum = math.random(1, #links)
        local randomLink = links[randomNum]
        roomDatas[i] = false
        for k = 1, #links do
            local randomNum = math.random(1, #links)
            local randomLink = links[randomNum]
            if roomQueue[i][k - 1] then
                totalTime = totalTime + waitTime + (roomQueue[i][k - 1][3] * 1000)
                roomQueue[i][k] = {randomLink[1], randomNum, randomLink[3], randomLink[2], (getRealTime().timestamp) + (totalTime / 1000), randomNum, getRealTime().timestamp + randomLink[3] + 10}
                filmTimers[i][k] = setTimer(startMovie, totalTime, 1, i, k, randomLink[1], randomLink[2], randomLink[3])
            else
                totalTime = totalTime + ((1 * 10) * 1000)
                roomQueue[i][k] = {randomLink[1], randomNum, randomLink[3], randomLink[2], (getRealTime().timestamp + 1 * 60), randomNum}
                filmTimers[i][k] = setTimer(startMovie, ((1 * 10) * 1000), 1, i, k, randomLink[1], randomLink[2], randomLink[3])
            end
        end
    end
end

function getNextFilm(room)
    local nowTime = getRealTime().timestamp
    local nextFilm = {"N/A", getRealTime().timestamp}
    for i = 1, #roomQueue[room] do
        if roomQueue[room][i][5] > getRealTime().timestamp then
            nextFilm = {roomQueue[room][i][4], roomQueue[room][i][5]}
            break
        end
    end
    return nextFilm
end

addEvent("requestRoomData", true)
function requestRoomData(i)
    triggerClientEvent(client, "gotRoomData", client, i, roomDatas[i])
    triggerClientEvent(client, "gotRoomQueue", resourceRoot, i, roomQueue[i])
end
addEventHandler("requestRoomData", root, requestRoomData)

addEvent("tryToBuyCinemaTicket", true)
addEventHandler("tryToBuyCinemaTicket", root, function(roomID, queueID, videoId)
    if exports.sCore:getMoney(client) >= ticketPrice then
        local data = {room = roomID, seat = math.random(1, 100), valid = roomQueue[roomID][queueID][5], title = roomQueue[roomID][queueID][4], start = roomQueue[roomID][queueID][5]}
        exports.sItems:giveItem(client, 437, 1, false, toJSON(data))
        if not playerHasTicketFor[getElementData(client, "char.ID")] then
            playerHasTicketFor[getElementData(client, "char.ID")] = {}
        end
        playerHasTicketFor[getElementData(client, "char.ID")][roomID] = roomQueue[roomID][queueID][5] + roomQueue[roomID][queueID][3]
        exports.sCore:takeMoney(client, ticketPrice)
        exports.sGui:showInfobox(client, "s", "Sikeres vásárlás!")
    else
        exports.sGui:showInfobox(client, "e", "Nincs elég pénzed!")
    end
end)

addEvent("checkCinemaTicket", true)
addEventHandler("checkCinemaTicket", root, function(roomID)
    local canPlayerGo = false

    if playerHasTicketFor[getElementData(client, "char.ID")] then
        if playerHasTicketFor[getElementData(client, "char.ID")][roomID] then
            if playerHasTicketFor[getElementData(client, "char.ID")][roomID] >= getRealTime().timestamp then
                if roomDatas[roomID] then
                    if roomDatas[roomID][7] < getRealTime().timestamp then
                        roomDatas[roomID][2] = getRealTime().timestamp - roomDatas[roomID][7]
                    else
                        roomDatas[roomID][2] = 0
                    end
                end

                triggerClientEvent(client, "gotRoomData", client, roomID, roomDatas[roomID])

                canPlayerGo = true
            end
        end
    end
    if not canPlayerGo then
        if roomID == 1 then
            x, y, z = 1154.0157470703, -1531.6156005859, 15.789838790894
        elseif roomID == 2 then
            x, y, z = 1162.8122558594, -1534.8648681641, 22.860591888428
        end
        setElementPosition(client, x, y, z)
        setElementRotation(client, 0, 0, 337)
        setElementDimension(client, 0)
        setElementInterior(client, 0)
        exports.sGui:showInfobox(client, "e", "Nincs érvényes jegyed!")
    end
end)

addEventHandler("onResourceStart", getRootElement(), function(res)
    local resName = getResourceName(res)

    if res == getThisResource() then
        generateRooms()
    end
end)