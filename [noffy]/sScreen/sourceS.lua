local lastplayer

function screenShotHandler(player)
	takePlayerScreenShot(player, 1920, 1080, "screenshot", 30, 875000,875000)
	lastplayer = player
end
addEvent("onScreenShot", true)
addEventHandler("onScreenShot", resourceRoot, screenShotHandler)

addEventHandler("onPlayerScreenShot", root,
    function (theResource, status, pixels, timestamp, tag)
    	if status == "ok" then
        	local newFile = fileCreate("test.jpg")
			if (newFile) then
    			fileWrite(newFile, pixels)
    			fileClose(newFile)
    			screenshot()
			end
		end
    end
)

local imgur = "https://api.imgur.com/3/upload"

function screenshot()
	local file = fileOpen ( "test.jpg", true )
	local data = fileRead ( file, fileGetSize ( file ) )
	data = encodeString ("base64", data)
	fileClose ( file )
	sendOptions = {
    	method = "POST",
    	headers = {
        	[ "Authorization" ] = "Client-ID 620659b4dda7173",
        	[ "Content-Type" ] = "multipart/form-data"
    	},
    	formFields = {
        	[ "image" ] = data,
        	[ "type" ] = "base64"
    	}
	}
	fetchRemote(imgur, sendOptions, uploadCallback)
end

function uploadCallback(responseData) 
    if responseData~="" then
        discordLogger(responseData)
    end
end

local discordWebhookchat = "https://discord.com/api/webhooks/1311341913458212974/Y95Mu6D43fljDKRuxbjAz6N6IK7GTtXqsTd7XbQQTcDRU7R0CKPGUJ1DOIT7ang4PXlj"

local gWeekDays = {
	"vasárnap",
	"hétfő",
	"kedd",
	"szerda",
	"csütörtök",
	"péntek",
	"szombat"
  }

function formatDate(format, escaper, timestamp)
	escaper = (escaper or "'"):sub(1, 1)
	local time = getRealTime(timestamp)
	local formattedDate = ""
	local escaped = false
	time.year = time.year + 1900
	time.month = time.month + 1
	local datetime = {
	  d = ("%02d"):format(time.monthday),
	  h = ("%02d"):format(time.hour),
	  i = ("%02d"):format(time.minute),
	  m = ("%02d"):format(time.month),
	  s = ("%02d"):format(time.second),
	  w = gWeekDays[time.weekday + 1]:sub(1, 2),
	  W = gWeekDays[time.weekday + 1],
	  y = tostring(time.year):sub(-2),
	  Y = time.year
	}
	for char in format:gmatch(".") do
	  if char == escaper then
		escaped = not escaped
	  else
		formattedDate = formattedDate .. (not escaped and datetime[char] or char)
	  end
	end
	return formattedDate
  end

function discordLogger(responseData2)
	responseData = fromJSON(responseData2)
	imgurid = responseData['data'] and responseData['data']['id']
	if imgurid then
		imgurlink = "https://i.imgur.com/"..imgurid..".jpg"
		sendOptions = {
			formFields = {
				content="```📷 "..getPlayerName(lastplayer):gsub("_", " ").." screenshotja (Készült: ".. formatDate("Y.m.d. h:i:s", "'", os.time()) ..")```" .. imgurlink
			},
		}
		fetchRemote(discordWebhookchat, sendOptions, loggerCallback)
	else
		sendOptions = {
			formFields = {
				content="```📷 "..getPlayerName(lastplayer).." screenshot fail (" .. responseData2 .. ")```"
			},
		}
		fetchRemote(discordWebhookchat, sendOptions, loggerCallback)
	end
end

function loggerCallback(responseData) 
    if responseData~="" then
    end
end

addCommandHandler("createscreenshot", 
	function(sourcePlayer, commandName, targetP)
		local targetPlayer, targetName = exports.sCore:findPlayer(sourcePlayer, targetP)

		if isElement(targetPlayer) then
			screenShotHandler(targetPlayer)
		end
	end
)

addCommandHandler("screenshotstatus", 
	function(sourcePlayer, commandName, targetPlayer)
		fetchRemote("https://api.imgur.com/3/credits",
			function(returns)
				sendOptions = {
					formFields = {
						content="```📷 screenshot status (" .. returns .. ")```"
					},
				}
				fetchRemote(discordWebhookchat, sendOptions, loggerCallback)
			end
		)
	end
)