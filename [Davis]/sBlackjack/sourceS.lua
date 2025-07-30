local connection = false
local blackjackTables = {}
local tablePositions = {}
local occupiedSeats = {}
local playerOccupiedSeat = {}

addEventHandler("onDatabaseConnected", getRootElement(),
	function (db)
		connection = db
	end)

addEventHandler("onResourceStart", getResourceRootElement(),
	function ()
		connection = exports.sConnection:getConnection()

		dbQuery(
			function (qh)
				local result = dbPoll(qh, 0)

				if result then
					for k, v in pairs(result) do
						loadBlackjack(v.id, v)
					end
				end
			end,
		connection, "SELECT * FROM blackjack")
	end
)

local blackjackTablesId = {
	[1] = 2188,
	[2] = 1948,
	[3] = 2349
}

addEvent("placeBlackjackTable", true)
addEventHandler("placeBlackjackTable", getRootElement(),
	function (dat)
		if isElement(client) then
			if dat then
				dbExec(connection, "INSERT INTO blackjack (x, y, z, rz, interior, dimension, minEntry, maxEntry) VALUES (?,?,?,?,?,?,?,?)", unpack(dat))
				dbQuery(
					function (qh, sourcePlayer)
						local result = dbPoll(qh, 0)[1]

						if result then
							loadBlackjack(result.id, result, true)
						end
					end,
				{client}, connection, "SELECT * FROM blackjack WHERE id = LAST_INSERT_ID()")
			end
		end
	end)

addCommandHandler("deleteblackjack",
	function (sourcePlayer, commandName, tableIdB)
		if getElementData(sourcePlayer, "acc.adminLevel") >= 9 then
			tableIdB = tonumber(tableIdB)

			if not tableIdB then
				outputChatBox("[color=sightblue][SightMTA - BlackJack]: #ffffff/" .. commandName .. " [ID]", sourcePlayer, 255, 255, 255, true)
			else
				if blackjackTables[tableIdB] then
					if isElement(blackjackTables[tableIdB].element) then
						destroyElement(blackjackTables[tableIdB].element)
					end

					if isElement(blackjackTables[tableIdB].dealer) then
						destroyElement(blackjackTables[tableIdB].dealer)
					end

					blackjackTables[tableIdB] = nil
					tablePositions[tableIdB] = nil

					triggerClientEvent("deleteBlackjackTable", resourceRoot, tableIdB)

					dbExec(connection, "DELETE FROM blackjack WHERE id = ?", tableIdB)
				else
					outputChatBox("[color=sightred][SightMTA - Blackjack]: #ffffffA kiválasztott asztal nem létezik.", sourcePlayer, 255, 255, 255, true)
				end
			end
		end
	end)

function loadBlackjack(id, data, sync)
	if data.dimension == 3 then
		obj = createObject(blackjackTablesId[data.tableModel], data.x, data.y, data.z, 0, 0, data.rz)
	else
		obj = createObject(blackjackTablesId[data.tableModel], data.x, data.y, data.z + 0.452, 0, 0, data.rz)
	end
	setElementInterior(obj, data.interior)
	setElementDimension(obj, data.dimension)
	setElementData(obj, "blackjackTable", id)

	local x, y = rotateAround(data.rz, 0, 0.35)
	local ped = createPed(171, data.x + x, data.y + y, data.z, data.rz + 180)

	setElementInterior(ped, data.interior)
	setElementDimension(ped, data.dimension)
	setElementFrozen(ped, true)
	setElementData(ped, "invulnerable", true)
	setElementData(ped, "visibleName", "Dealer")

	tablePositions[id] = {data.x, data.y, data.dimension == 3 and data.z or data.z + 0.425, data.rz, data.interior, data.dimension, data.minEntry, data.maxEntry}

	blackjackTables[id] = data
	blackjackTables[id].element = obj
	blackjackTables[id].dealer = ped
	blackjackTables[id].credit = 0
	blackjackTables[id].deckCards = {}
	blackjackTables[id].data = {
		tableId = id,
		player = {
			cards = {},
			element = false
		},
		gameState = 0,
		suspended = true,
		object = obj,
		positions = {data.x, data.y, data.dimension == 3 and data.z or data.z + 0.425, data.rz},
		minEntry = data.minEntry,
		maxEntry = data.maxEntry,
		dealerCard = {},
		cards = {}
	}

	setElementData(obj, "blackjack.data", blackjackTables[id].data)

	if sync then
		triggerClientEvent("getBlackjackTables", resourceRoot, blackjackTables)
	end
end

addEvent("requestBlackjackTables", true)
addEventHandler("requestBlackjackTables", getRootElement(),
	function ()
		if isElement(client) then
			triggerClientEvent(client, "getBlackjackTables", client, tablePositions)
		end
	end
)

addEvent("tryToSitBlackJack", true)
function tryToSitBlackJack(tbl)
	if blackjackTables[tbl] then
		if not occupiedSeats[tbl] and not playerOccupiedSeat[client] then
			local x, y, z, rz = unpack(tablePositions[tbl])
			local int, dim = tablePositions[tbl][5], tablePositions[tbl][6]
			local px, py, pz = getElementPosition(client)
			if getDistanceBetweenPoints3D(x, y, z, px, py, pz) < 5 then
				occupiedSeats[tbl] = client
				playerOccupiedSeat[client] = tbl

				blackjackTables[tbl].data.player = {
					cards = {},
					element = client
				}
				blackjackTables[tbl].data.cards = {}
				triggerClientEvent(client, "onOpenBlackjack", client, blackjackTables[tbl].data)
				triggerClientEvent(client, "playBlackjackSound", client, x, y, z, int, dim, "sit")

				local targetX, targetY, targetZ, targetRot = x, y, z, rz
				local x, y = rotateAround(targetRot, 0, -1.65)

				setElementPosition(client, targetX + x, targetY + y, z)

				local rx, ry = getElementRotation(client)

				setElementRotation(client, rx, ry, rz)

				setElementData(client, "blackjack.data", blackjackTables[tbl].data)
				setElementData(blackjackTables[tbl].element, "blackjack.data", blackjackTables[tbl].data)
				exports.sChat:localAction(client, "leült egy blackjack asztalhoz.")
				sendDealerChat(client, "Dealer", "Szép napot! Kérem tegye meg tétjét!", blackjackTables[tbl].dealer)
				setElementData(client, "playerUsingBlackjack", tbl)
			end
		end
	end
end
addEventHandler("tryToSitBlackJack", root, tryToSitBlackJack)

addEvent("quitBlackjack", true)
function quitBlackjack()
	if playerOccupiedSeat[client] then
		local tbl = playerOccupiedSeat[client]
		if blackjackTables[tbl] then
			if occupiedSeats[tbl] then
				local x, y, z = unpack(tablePositions[tbl])
				local int, dim = tablePositions[tbl][5], tablePositions[tbl][6]
				local px, py, pz = getElementPosition(client)
				occupiedSeats[tbl] = nil
				playerOccupiedSeat[client] = nil

				blackjackTables[tbl].data.player = {
					cards = {},
					element = false
				}
				blackjackTables[tbl].data.cards = {}
				removeElementData(client, "blackjack.data")
				setElementData(blackjackTables[tbl].element, "blackjack.data", blackjackTables[tbl].data)
				triggerClientEvent(client, "playBlackjackSound", client, x, y, z, int, dim, "stand")
				setPedAnimation(client)

				exports.sChat:localAction(client, "felállt egy blackjack asztaltól.")
				sendDealerChat(client, "Dealer", "Viszont látásra!", blackjackTables[tbl].dealer)

			end
		end
	end
end
addEventHandler("quitBlackjack", root, quitBlackjack)

function resetTable(tableId, newround)
	local blackjackTable = blackjackTables[tableId]

	if blackjackTable then
		local currentPlayer = blackjackTables[tableId].data.player.element

		if newround then
			if isElement(currentPlayer) then
				local currentBalance = exports.sCore:getSSC(currentPlayer)

				if currentBalance < blackjackTables[tableId].minEntry then
					currentPlayer = nil
				end
			end
		end

		if newround then
			blackjackTables[tableId].data.player.element = currentPlayer
		else
			blackjackTable.data.player.element = false
		end

		blackjackTables[tableId].data.gameState = 0
		blackjackTables[tableId].data.player.cards = {}
		blackjackTables[tableId].data.cards = {}
		blackjackTables[tableId].data.suspended = false
		blackjackTables[tableId].credit = 0

		setElementData(blackjackTables[tableId].data.object, "blackjack.data", blackjackTables[tableId].data)
	end
end

addEvent("blackJackHandler", true)
addEventHandler("blackJackHandler", getRootElement(),
	function (action, credit)
		if isElement(client) then
			local tableIdB = getElementData(client, "playerUsingBlackjack")

			if tableIdB then
				local blackjackTable = blackjackTables[tableIdB]
				if blackjackTable then
					local currentPlayer = blackjackTable.data.player.element
					local currentBalance = exports.sCore:getSSC(client) or 0
					if action == "pot" then
						if currentBalance >= credit then
							createDeck(tableIdB)

							blackjackTable.credit = credit
							blackjackTable.data.gameState = 1
							blackjackTable.data.player.cards = giveCards(blackjackTable.deckCards, 2)
							blackjackTable.data.cards = giveCards(blackjackTable.deckCards, 2)
							blackjackTable.data.suspended = false

							setPedAnimation(blackjackTable.dealer, "CASINO", "dealone", 800, false, false, false, false)
							setTimer(setPedAnimation, 800, 3, blackjackTable.dealer, "CASINO", "dealone", 800, false, false, false, false)

							triggerClientEvent(client, "addBlackjackChat", client, "[color=sightorange]Új kör kezdődik.")
							exports.sCore:takeSSC(client, credit)
							triggerClientEvent(client, "refreshSSC", client, exports.sCore:getSSC(client))

							setElementData(blackjackTable.data.object, "blackjack.data", blackjackTable.data)

							local playerX, playerY, playerZ = getElementPosition(client)
							local int, dim = getElementInterior(client), getElementDimension(client)
							triggerClientEvent("playBlackjackSound", client, playerX, playerY, playerZ, int, dim, "newcardintable")

							setTimer(function(currentPlayer)
								local playerX, playerY, playerZ = getElementPosition(currentPlayer)
								local int, dim = getElementInterior(currentPlayer), getElementDimension(currentPlayer)
								triggerClientEvent("playBlackjackSound", currentPlayer, playerX, playerY, playerZ, int, dim, "newcardintable")
							end, 1000, 3, client)
							local fakeCards = {}

							setTimer(function(blackjackTable, client, fakeCards)
								for i = 1, 2 do
									table.insert(fakeCards, i, blackjackTable.data.player.cards[i])
									setTimer(sendDealerChat, i * 1000, 1, client, "Dealer", getValueOf(fakeCards), blackjackTable.dealer)
		
								end
							end, 1800, 1, blackjackTable, client, fakeCards)
						end
					elseif action == "hit" then
						if not blackjackTable.data.suspended then
							if #blackjackTable.data.player.cards >= 2 then
								table.insert(blackjackTable.data.player.cards, giveCards(blackjackTable.deckCards, 1)[1])

								setPedAnimation(blackjackTable.dealer, "CASINO", "dealone", 800, false, false, false, false)

								local playerX, playerY, playerZ = getElementPosition(client)
								local int, dim = getElementInterior(client), getElementDimension(client)
								triggerClientEvent("playBlackjackSound", client, playerX, playerY, playerZ, int, dim, "newcardintable")

								if getValueOf(blackjackTable.data.player.cards) > 21 then
									blackjackTable.data.suspended = true
									setTimer(gameLoop, 1000, 1, tableIdB, "bust")
								end

								setElementData(blackjackTable.data.object, "blackjack.data", blackjackTable.data)
							end
						end
					elseif action == "stay" then
						if blackjackTable.data.gameState == 1 then
							triggerClientEvent(client, "addBlackjackChat", client, "#ffffffA bank megfordítja a második kártyát.")
						end

						blackjackTable.data.suspended = true
						blackjackTable.data.gameState = 2

						setTimer(gameLoop, 1000, 1, tableIdB, "newcard")
						setElementData(blackjackTable.data.object, "blackjack.data", blackjackTable.data)

						triggerClientEvent("chatBubble", client, "say", "Megállok.")
						setTimer(sendDealerChat, 1000, 1, client, "Dealer", "A játékos megáll.", blackjackTable.dealer)
					elseif action == "double" then
						if #blackjackTable.data.player.cards == 2 then
							blackjackTable.data.suspended = false

							if currentBalance - blackjackTable.credit >= 0 then
								triggerClientEvent("chatBubble", client, "say", "Duplázok!")
								setTimer(sendDealerChat, 1000, 1, client, "Dealer", "A játékos duplázik.", blackjackTable.dealer)

								if blackjackTable.data.gameState == 1 then
									triggerClientEvent(client, "addBlackjackChat", client, "#ffffffA bank megfordítja a második kártyát.")
									blackjackTable.data.gameState = 2
								end

								blackjackTable.credit = blackjackTable.credit * 2
								blackjackTable.data.suspended = true

								exports.sCore:takeSSC(client, (blackjackTable.credit / 2))
								setPedAnimation(blackjackTable.dealer, "CASINO", "dealone", 800, false, false, false, false)
								
								table.insert(blackjackTable.data.player.cards, giveCards(blackjackTable.deckCards, 1)[1])

								if getValueOf(blackjackTable.data.player.cards) > 21 then
									setTimer(gameLoop, 1000, 1, tableIdB, "bust")
								else
									setTimer(gameLoop, 1000, 1, tableIdB, "newcard")
								end
							else
								triggerClientEvent(client, "addBlackjackChat", client, "#d75959Nem rendelkezel elég Coin-al a duplázáshoz!")
							end

							setElementData(blackjackTable.data.object, "blackjack.data", blackjackTable.data)
						end
					end
				end
			end
		end
	end
)

function quitPlayer()
	local client = source
	if playerOccupiedSeat[client] then
		local tbl = playerOccupiedSeat[client]
		if blackjackTables[tbl] then
			if occupiedSeats[tbl] then
				local x, y, z = unpack(tablePositions[tbl])
				local int, dim = tablePositions[tbl][5], tablePositions[tbl][6]
				local px, py, pz = getElementPosition(client)
				occupiedSeats[tbl] = nil
				playerOccupiedSeat[client] = nil

				blackjackTables[tbl].data.player = {
					cards = {},
					element = false
				}
				blackjackTables[tbl].data.cards = {}
				removeElementData(client, "blackjack.data")
				setElementData(blackjackTables[tbl].element, "blackjack.data", blackjackTables[tbl].data)
				triggerClientEvent(client, "playBlackjackSound", client, x, y, z, int, dim, "stand")
				setPedAnimation(client)

				exports.sChat:localAction(client, "felállt egy blackjack asztaltól.")
				sendDealerChat(client, "Dealer", "Viszont látásra!", blackjackTables[tbl].dealer)

			end
		end
	end
end
addEventHandler("onPlayerQuit", root, quitPlayer)

function gameLoop(tableIdB, state)
	local blackjackTable = blackjackTables[tableIdB]

	if blackjackTable then
		local currentPlayer = blackjackTable.data.player.element

		blackjackTable.data.gameState = blackjackTable.data.gameState + 1

		if isElement(currentPlayer) then
			local dealerHand = getValueOf(blackjackTable.data.cards)
			local playerHand = getValueOf(blackjackTable.data.player.cards)

			local playerX, playerY, playerZ = getElementPosition(currentPlayer)
			local int, dim = getElementInterior(currentPlayer), getElementDimension(currentPlayer)
			triggerClientEvent("playBlackjackSound", currentPlayer, playerX, playerY, playerZ, int, dim, "newcardintable")

			if state == "newcard" then
				if dealerHand > 21 and playerHand <= 21 then
					return gameLoop(tableIdB, "win")
				elseif playerHand == 21 and dealerHand ~= 21 and #blackjackTable.data.player.cards == 2 then
					return gameLoop(tableIdB, "blackjack")
				elseif dealerHand < 17 then
					triggerClientEvent(currentPlayer, "addBlackjackChat", currentPlayer, "#ffffffBank lapot kér.")

					table.insert(blackjackTable.data.cards, giveCards(blackjackTable.deckCards, 1)[1])

					setElementData(blackjackTable.data.object, "blackjack.data", blackjackTable.data)
					setPedAnimation(blackjackTable.dealer, "CASINO", "dealone", 800, false, false, false, false)

					return setTimer(gameLoop, 1000, 1, tableIdB, "newcard")
				elseif playerHand > dealerHand and playerHand <= 21 then
					return gameLoop(tableIdB, "win")
				elseif playerHand > 21 then
					return gameLoop(tableIdB, "loses")
				elseif playerHand == dealerHand then
					return gameLoop(tableIdB, "push")
				elseif dealerHand > playerHand then
					return gameLoop(tableIdB, "loses")
				end
			else
				local win = 0

				triggerClientEvent(currentPlayer, "addBlackjackChat", currentPlayer, "#ffffffJáték vége.")
				local playerX, playerY, playerZ = getElementPosition(currentPlayer)
				local int, dim = getElementInterior(currentPlayer), getElementDimension(currentPlayer)
				if state == "push" then
					win = blackjackTable.credit
					triggerClientEvent(currentPlayer, "addBlackjackChat", currentPlayer, "[color=hudwhite]Push! Visszakapod a tétet.")
					triggerClientEvent("playBlackjackSound", resourceRoot, playerX, playerY, playerZ, int, dim, "chip1")
				elseif state == "bust" then
					triggerClientEvent(currentPlayer, "addBlackjackChat", currentPlayer, "[color=sightred]Vesztettél! (Bust)")
					triggerClientEvent("playBlackjackSound", resourceRoot, playerX, playerY, playerZ, int, dim, "chip2")
					sendDealerChat(currentPlayer, "Dealer", "Sok, a játékos veszített!", blackjackTable.dealer)
				elseif state == "loses" then
					triggerClientEvent(currentPlayer, "addBlackjackChat", currentPlayer, "[color=hudwhite]Vesztettél [color=sightred]" .. blackjackTable.credit .. "[color=hudwhite] SSC-t!")
					triggerClientEvent("playBlackjackSound", resourceRoot, playerX, playerY, playerZ, int, dim, "chip3")
					sendDealerChat(currentPlayer, "Dealer", "Kevés, a játékos veszített!", blackjackTable.dealer)
				elseif state == "win" then
					win = blackjackTable.credit * 2
					triggerClientEvent(currentPlayer, "addBlackjackChat", currentPlayer, "[color=hudwhite]Nyertél [color=sightgreen]" .. blackjackTable.credit .. "[color=hudwhite] SSC-t!")
					triggerClientEvent("playBlackjackSound", resourceRoot, playerX, playerY, playerZ, int, dim, "chip4")
					sendDealerChat(currentPlayer, "Dealer", "Sok, a játékos nyert!", blackjackTable.dealer)
				elseif state == "blackjack" then
					win = math.floor(blackjackTable.credit * 2.5)
					triggerClientEvent(currentPlayer, "addBlackjackChat", currentPlayer, "[color=hudwhite]Blackjack! Tét 3:2 Arányban visszaadva.")
					triggerClientEvent("playBlackjackSound", resourceRoot, playerX, playerY, playerZ, int, dim, "chip5")
					sendDealerChat(currentPlayer, "Dealer", "Blackjack a játékosnál!", blackjackTable.dealer)
				end

				exports.sCore:giveSSC(currentPlayer, win)

				if win ~= blackjackTable.credit then
					if win > blackjackTable.credit then
						setPedAnimation(currentPlayer, "CASINO", "slot_win_out", -1, false, false, false, false)
						setElementData(currentPlayer, "playerIcons", {"plus", win})
					else
						setPedAnimation(currentPlayer, "CASINO", "cards_lose", -1, false, false, false, false)
						setElementData(currentPlayer, "playerIcons", {"minus", blackjackTable.credit})
					end

					setTimer(setPedAnimation, 2000, 1, currentPlayer, "CASINO", "cards_loop", -1, true, false, false, false)
				end

				triggerClientEvent(currentPlayer, "addBlackjackChat", currentPlayer, "#ffffffÚj kör kezdéséig #3d7abc5 másodperc!")

				setTimer(resetTable, 5000, 1, tableIdB, true)
			end
		end
	end
end

function giveCards(deck, amount)
	local cards = {}

	for i = 1, amount do
		cards[i] = table.remove(deck)
	end

	return cards
end

function shuffleDeck(deck)
	for i = #deck, 2, -1 do
		local j = math.random(i)
		deck[i], deck[j] = deck[j], deck[i]
	end
end

function createDeck(tableIdB)
	blackjackTables[tableIdB].deckCards = {}

	for i = 1, #cardRanks do
		for j = 1, 4 do
			table.insert(blackjackTables[tableIdB].deckCards, {i, j})
		end
	end

	for i = 1, 3 do
		shuffleDeck(blackjackTables[tableIdB].deckCards)
	end
end

function sendDealerChat(player, senderName, text, ped, sound)
	triggerClientEvent("npcChatBubble", ped, "say", text)
	if sound then
		local playerX, playerY, playerZ = getElementPosition(ped)
		local int, dim = getElementInterior(ped), getElementDimension(ped)
		triggerClientEvent("playBlackjackSound", player, playerX, playerY, playerZ, int, dim, "newcardintable")
	end
end