addEvent("doBagPlayer", true)
addEventHandler("doBagPlayer", getRootElement(),
	function(playerHover)
		triggerClientEvent(playerHover, "setBagEffect", playerHover, not getElementData(playerHover, "bagged"))
        setElementData(playerHover, "bagged", not getElementData(playerHover, "bagged"))
	end
)

addEvent("processBagWield", true)
addEventHandler("processBagWield", getRootElement(),
	function(state)
        setElementData(client, "bagWield", state)
	end
)