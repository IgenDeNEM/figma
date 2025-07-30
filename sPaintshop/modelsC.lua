local sightexports = {
  sWorkaround = false,
  sModloader = false,
  sMarkers = false
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
models = {
  spray_hall = false,
  spray_hall_props = false,
  spray_certificate = false,
  spray_interior = false,
  spray_base_canister = false,
  spray_color_canister = false,
  spray_basebox_ = false,
  spray_basebox = false,
  spray_paintbox_ = false,
  spray_paintbox = false,
  spray_mixer_slider = false,
  spray_gun_cup = false,
  spray_manometer = false,
  spray_gun = false,
  spray_door = false,
  spray_interior_alpha = false,
  spray_booth = false,
  spray_door2 = false,
  spray_mixer = false,
  spray_office_door = false,
  spray_palette = false,
  spray_sander_shelf = false,
  spray_clock = false,
  paintshop_skin = false,
  wheel_mask_drying = false,
  wheel_mask = false,
  spray_booth_drying = false,
  spray_door2_drying = false,
  spray_door_drying = false,
  spray_gun_base = false,
  spray_plug = false,
  spray_sander = false,
  spray_basebox_1 = false,
  spray_paintbox_1 = false,
  spray_paintbox_2 = false,
  spray_paintbox_3 = false,
  spray_paintbox_4 = false
}
function loadModels()
  sightexports.sWorkaround:setDisableDetach(true)
  for k in pairs(models) do
    models[k] = sightexports.sModloader:getModelId(k)
  end
  workshopObj = createObject(models.spray_interior, wsX, wsY, wsZ)
  setElementInterior(workshopObj, targetInt)
  setElementDimension(workshopObj, 1)
  workshopMarker = sightexports.sMarkers:createCustomMarker(wsX - 4.36904, wsY + 16.4841, wsZ + 1, targetInt, 1, "sightyellow", "garage_paint")
  sightexports.sMarkers:setCustomMarkerInterior(workshopMarker, "paintshopExit", false, 1)
  modelsLoadedLobby()
  processColorPaletteLabel()
  setTimer(function()
    sightexports.sWorkaround:setDisableDetach(false)
  end, 1000, 1)
end

addEvent("modloaderLoaded", false)
addEventHandler("modloaderLoaded", getRootElement(), loadModels)
if getElementData(localPlayer, "loggedIn") then
  addEventHandler("onClientResourceStart", getResourceRootElement(), loadModels)
end
