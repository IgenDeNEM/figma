textureFilePaths = {}
texturePrices = {}
textureDXT = {}
vehPjApplyInfo = {}
function registerVehiclePaintjob(model, tex)
  if not vehPjApplyInfo[model] then
    vehPjApplyInfo[model] = {}
  elseif vehPjApplyInfo[model].texName and tex ~= vehPjApplyInfo[model].texName then
    outputChatBox("PJ ÜTKÖZÉS!! registerVehiclePaintjob - " .. model)
    outputChatBox("Új: " .. tex)
    outputChatBox("Régi: " .. vehPjApplyInfo[model].texName)
  end
  vehPjApplyInfo[model].texName = tex
  if not vehPjApplyInfo[model].pjTexIds then
    vehPjApplyInfo[model].pjTexIds = {}
  end
end
function createNewVehiclePaintjob(model, file, dxt, price)
  local texId = false
  for i = 1, #textureFilePaths do
    if textureFilePaths[i] == file and (textureDXT[i] or false) == (dxt or false) and (texturePrices[i] or false) == (price or false) then
      texId = i
      break
    end
  end
  if not texId then
    texId = #textureFilePaths + 1
    textureFilePaths[texId] = file
  end
  table.insert(vehPjApplyInfo[model].pjTexIds, texId)
  if dxt then
    textureDXT[texId] = dxt
  end
  if price then
    texturePrices[texId] = price
  end
end
function registerHeadlightPaintjob(model, tex)
  if not vehPjApplyInfo[model] then
    vehPjApplyInfo[model] = {}
  elseif vehPjApplyInfo[model].headlightName and tex ~= vehPjApplyInfo[model].headlightName then
    outputChatBox("HEADLIGHT ÜTKÖZÉS!! registerHeadlightPaintjob - " .. model)
    outputChatBox("Új: " .. tex)
    outputChatBox("Régi: " .. vehPjApplyInfo[model].headlightName)
  end
  vehPjApplyInfo[model].headlightName = tex
  if not vehPjApplyInfo[model].headlightTexIds then
    vehPjApplyInfo[model].headlightTexIds = {}
  end
end
function createNewHeadlightPaintjob(model, file, dxt, price)
  local texId = false
  for i = 1, #textureFilePaths do
    if textureFilePaths[i] == file and (textureDXT[i] or false) == (dxt or false) and (texturePrices[i] or false) == (price or false) then
      texId = i
      break
    end
  end
  if not texId then
    texId = #textureFilePaths + 1
    textureFilePaths[texId] = file
  end
  table.insert(vehPjApplyInfo[model].headlightTexIds, texId)
  if dxt then
    textureDXT[texId] = dxt
  end
  if price then
    texturePrices[texId] = price
  end
end
function registerWheelPaintjob(model, tex)
  if not vehPjApplyInfo[model] then
    vehPjApplyInfo[model] = {}
  elseif vehPjApplyInfo[model].wheelName and tex ~= vehPjApplyInfo[model].wheelName then
    outputChatBox("Ütközés! registerWheelPaintjob - " .. model)
    outputChatBox("Új: " .. tex)
    outputChatBox("Régi: " .. vehPjApplyInfo[model].wheelName)
  end
  vehPjApplyInfo[model].wheelName = tex
  if not vehPjApplyInfo[model].wheelTexIds then
    vehPjApplyInfo[model].wheelTexIds = {}
  end
end
function createNewWheelPaintjob(model, file, dxt, price)
  local texId = false
  for i = 1, #textureFilePaths do
    if textureFilePaths[i] == file and (textureDXT[i] or false) == (dxt or false) and (texturePrices[i] or false) == (price or false) then
      texId = i
      break
    end
  end
  if not texId then
    texId = #textureFilePaths + 1
    textureFilePaths[texId] = file
  end
  table.insert(vehPjApplyInfo[model].wheelTexIds, texId)
  if dxt then
    textureDXT[texId] = dxt
  end
  if price then
    texturePrices[texId] = price
  end
end
registerWheelPaintjob(1079, "v4_hubcap")
for i = 1, 127 do
  createNewWheelPaintjob(1079, "wheels/hubcaps/" .. i .. ".dds", "dxt3", i < 78 and 1200)
end
registerWheelPaintjob(1078, "sight_tuningwheel_tire(r)")
createNewWheelPaintjob(1078, "wheels/drag/1.dds")
createNewWheelPaintjob(1078, "wheels/drag/2.dds")
createNewWheelPaintjob(1078, "wheels/drag/3.dds")
registerWheelPaintjob(1075, "sight_tuningwheel_ronalt1")
createNewWheelPaintjob(1075, "wheels/ronalt/1.dds")
createNewWheelPaintjob(1075, "wheels/ronalt/2.dds")
createNewWheelPaintjob(1075, "wheels/ronalt/3.dds")
createNewWheelPaintjob(1075, "wheels/ronalt/4.dds")
createNewWheelPaintjob(1075, "wheels/ronalt/5.dds")
createNewWheelPaintjob(1075, "wheels/ronalt/6.dds")
createNewWheelPaintjob(1075, "wheels/ronalt/7.dds")
createNewWheelPaintjob(1075, "wheels/ronalt/8.dds")
createNewWheelPaintjob(1075, "wheels/ronalt/9.dds")
createNewWheelPaintjob(1075, "wheels/ronalt/10.dds")
registerWheelPaintjob(1081, "sight_tuningwheel_vette")
createNewWheelPaintjob(1081, "wheels/vette/1.dds")
registerWheelPaintjob(503, "nosegrillm4_wheel")
createNewWheelPaintjob(503, "wheels/bmw_m4/1.dds")
createNewWheelPaintjob(503, "wheels/bmw_m4/2.dds")
createNewWheelPaintjob(503, "wheels/bmw_m4/3.dds")
createNewWheelPaintjob(503, "wheels/bmw_m4/4.dds")
createNewWheelPaintjob(503, "wheels/bmw_m4/5.dds")
registerWheelPaintjob(405, "a8wheel")
createNewWheelPaintjob(405, "wheels/audi_a8/1.dds")
registerWheelPaintjob(547, "borarim")
createNewWheelPaintjob(547, "wheels_sight/vw_bora/1.dds")
registerWheelPaintjob(516, "generic_leather_white02")
createNewWheelPaintjob(516, "wheels_sight/mb_300_sel/1.dds")
registerWheelPaintjob(585, "wheel_lod0")
createNewWheelPaintjob(585, "wheels_sight/audi_80/1.dds")
registerWheelPaintjob(596, "rs6_wheel")
createNewWheelPaintjob(596, "wheels_sight/audi_rs6/1.dds")
registerVehiclePaintjob(550, "remap_e420")
createNewVehiclePaintjob(550, "oktato_sight/e420.dds")
registerVehiclePaintjob(561, "remapelegybody128")
createNewVehiclePaintjob(561, "oktato_sight/golfv.dds")
registerVehiclePaintjob(458, "remap")
createNewVehiclePaintjob(458, "oktato_sight/passat.dds")
registerVehiclePaintjob(582, "template")
createNewVehiclePaintjob(582, "migutrans/1.dds")
createNewVehiclePaintjob(582, "migutrans/2.dds")
createNewVehiclePaintjob(582, "migutrans/3.dds")
createNewVehiclePaintjob(582, "migutrans/4.dds")
createNewVehiclePaintjob(582, "migutrans/5.dds")
createNewVehiclePaintjob(582, "migutrans/6.dds")
createNewVehiclePaintjob(582, "migutrans/7.dds")
createNewVehiclePaintjob(582, "migutrans/8.dds")
createNewVehiclePaintjob(582, "migutrans/9.dds")
createNewVehiclePaintjob(582, "migutrans/10.dds")
createNewVehiclePaintjob(582, "migutrans/11.dds")
createNewVehiclePaintjob(582, "migutrans/12.dds")
createNewVehiclePaintjob(582, "migutrans/13.dds")
createNewVehiclePaintjob(582, "migutrans/14.dds")
createNewVehiclePaintjob(582, "migutrans/15.dds")
createNewVehiclePaintjob(582, "migutrans/16.dds")
createNewVehiclePaintjob(582, "migutrans/17.dds")
createNewVehiclePaintjob(582, "migutrans/18.dds")
registerVehiclePaintjob(443, "extra")
createNewVehiclePaintjob(443, "packer/empty.dds", "dxt5")
createNewVehiclePaintjob(443, "packer/pf.dds", "dxt5")
createNewVehiclePaintjob(443, "packer/jesse.dds", "dxt5")
createNewVehiclePaintjob(443, "packer/polgi.dds", "dxt5")
createNewVehiclePaintjob(443, "packer_sight/bms.dds", "dxt5")
createNewVehiclePaintjob(443, "packer_sight/fix.dds", "dxt5")
createNewVehiclePaintjob(443, "packer_sight/apms.dds", "dxt5")
registerVehiclePaintjob(490, "remap_q7")
createNewVehiclePaintjob(490, "emergency_sight/audi_q7/army.dds")
createNewVehiclePaintjob(490, "emergency_sight/audi_q7/army2.dds")
createNewVehiclePaintjob(490, "emergency_sight/audi_q7/nav.dds")
createNewVehiclePaintjob(490, "emergency_sight/audi_q7/okf.dds")
createNewVehiclePaintjob(490, "emergency_sight/audi_q7/pd.dds")
registerVehiclePaintjob(596, "remap_rs_body")
createNewVehiclePaintjob(596, "emergency_sight/audi_rs6/nav.dds")
createNewVehiclePaintjob(596, "emergency_sight/audi_rs6/okf.dds")
createNewVehiclePaintjob(596, "emergency_sight/audi_rs6/omsz1.dds")
createNewVehiclePaintjob(596, "emergency_sight/audi_rs6/omsz2.dds")
createNewVehiclePaintjob(596, "emergency_sight/audi_rs6/pd.dds")
registerVehiclePaintjob(599, "remap")
createNewVehiclePaintjob(599, "emergency_sight/audi_tt/army1.dds")
createNewVehiclePaintjob(599, "emergency_sight/audi_tt/army2.dds")
createNewVehiclePaintjob(599, "emergency_sight/audi_tt/nav.dds")
createNewVehiclePaintjob(599, "emergency_sight/audi_tt/okf.dds")
createNewVehiclePaintjob(599, "emergency_sight/audi_tt/pd1.dds")
createNewVehiclePaintjob(599, "emergency_sight/audi_tt/pd2.dds")
registerVehiclePaintjob(598, "remap")
createNewVehiclePaintjob(598, "emergency_sight/bmw_f11/army1.dds")
createNewVehiclePaintjob(598, "emergency_sight/bmw_f11/army2.dds")
createNewVehiclePaintjob(598, "emergency_sight/bmw_f11/nav.dds")
createNewVehiclePaintjob(598, "emergency_sight/bmw_f11/omsz.dds")
createNewVehiclePaintjob(598, "emergency_sight/bmw_f11/pd.dds")
registerVehiclePaintjob(597, "remap_octavia")
createNewVehiclePaintjob(597, "emergency_sight/skoda_octavia/army.dds")
createNewVehiclePaintjob(597, "emergency_sight/skoda_octavia/army2.dds")
createNewVehiclePaintjob(597, "emergency_sight/skoda_octavia/nav.dds")
createNewVehiclePaintjob(597, "emergency_sight/skoda_octavia/okf.dds")
createNewVehiclePaintjob(597, "emergency_sight/skoda_octavia/omsz.dds")
createNewVehiclePaintjob(597, "emergency_sight/skoda_octavia/pd.dds")
registerVehiclePaintjob(416, "sprinter2body")
createNewVehiclePaintjob(416, "emergency_sight/sprinter/pd.dds", "dxt1")
createNewVehiclePaintjob(416, "emergency_sight/sprinter/okf.dds", "dxt1")
createNewVehiclePaintjob(416, "emergency_sight/sprinter/omsz.dds", "dxt1")
createNewVehiclePaintjob(416, "emergency_sight/sprinter/army.dds", "dxt1")
registerVehiclePaintjob(407, "remap_okf")
createNewVehiclePaintjob(407, "emergency_sight/firetruck/1.dds", "dxt1")
registerVehiclePaintjob(497, "remap")
createNewVehiclePaintjob(497, "emergency_sight/police_maverick/heli1.dds", "dxt1")
createNewVehiclePaintjob(497, "emergency_sight/police_maverick/heli2.dds", "dxt1")
createNewVehiclePaintjob(497, "emergency_sight/police_maverick/heli3.dds", "dxt1")
createNewVehiclePaintjob(497, "emergency_sight/police_maverick/heli4.dds", "dxt1")
createNewVehiclePaintjob(497, "emergency_sight/police_maverick/heli5.dds", "dxt1")
createNewVehiclePaintjob(497, "emergency_sight/police_maverick/heli6.dds", "dxt1")
createNewVehiclePaintjob(497, "emergency_sight/police_maverick/heli7.dds", "dxt1")
registerHeadlightPaintjob(565, "rear_lights")
createNewHeadlightPaintjob(565, "headlight/honda_civic/1.dds")
createNewHeadlightPaintjob(565, "headlight/honda_civic/2.dds")
createNewHeadlightPaintjob(565, "headlight/honda_civic/3.dds")
createNewHeadlightPaintjob(565, "headlight/honda_civic/4.dds")
createNewHeadlightPaintjob(565, "headlight/honda_civic/5.dds")
createNewHeadlightPaintjob(565, "headlight/honda_civic/6.dds")
createNewHeadlightPaintjob(565, "headlight/honda_civic/7.dds")
registerHeadlightPaintjob(585, "vehiclelights")
createNewHeadlightPaintjob(585, "headlight_sight/audi_80/1.dds")
createNewHeadlightPaintjob(585, "headlight_sight/audi_80/2.dds")
registerHeadlightPaintjob(596, "rs6_light")
createNewHeadlightPaintjob(596, "headlight_sight/audi_a6/1.dds")
registerHeadlightPaintjob(502, "GT lights")
createNewHeadlightPaintjob(502, "headlight/mercedes-benz_amg_gt/1.dds")

registerHeadlightPaintjob("dodge", "ramlight")
createNewHeadlightPaintjob("dodge", "headlight/ram1500/1.dds")

registerHeadlightPaintjob(467, "lightsus")
createNewHeadlightPaintjob(467, "headlight/chevrolet_caprice_87/1.dds")
createNewHeadlightPaintjob(467, "headlight/chevrolet_caprice_87/2.dds")
createNewHeadlightPaintjob(467, "headlight/chevrolet_caprice_87/3.dds")
createNewHeadlightPaintjob(467, "headlight/chevrolet_caprice_87/4.dds")
createNewHeadlightPaintjob(467, "headlight/chevrolet_caprice_87/5.dds")
createNewHeadlightPaintjob(467, "headlight/chevrolet_caprice_87/6.dds")
createNewHeadlightPaintjob(467, "headlight/chevrolet_caprice_87/7.dds")
createNewHeadlightPaintjob(467, "headlight/chevrolet_caprice_87/8.dds")
createNewHeadlightPaintjob(467, "headlight/chevrolet_caprice_87/9.dds")
registerHeadlightPaintjob(558, "lights")
createNewHeadlightPaintjob(558, "headlight/bmw_3_series_e46/1.dds")
createNewHeadlightPaintjob(558, "headlight/bmw_3_series_e46/2.dds")
createNewHeadlightPaintjob(558, "headlight/bmw_3_series_e46/3.dds")
createNewHeadlightPaintjob(558, "headlight/bmw_3_series_e46/4.dds")
registerHeadlightPaintjob(445, "lights")
createNewHeadlightPaintjob(445, "headlight/bmw_5_series_e60/1.dds")
createNewHeadlightPaintjob(445, "headlight/bmw_5_series_e60/2.dds")
createNewHeadlightPaintjob(445, "headlight/bmw_5_series_e60/3.dds")
createNewHeadlightPaintjob(445, "headlight/bmw_5_series_e60/4.dds")
createNewHeadlightPaintjob(445, "headlight/bmw_5_series_e60/5.dds")
createNewHeadlightPaintjob(445, "headlight/bmw_5_series_e60/6.dds")
registerHeadlightPaintjob(529, "lights")
createNewHeadlightPaintjob(529, "headlight_sight/seat_leon/1.dds")
registerHeadlightPaintjob(420, "lights")
createNewHeadlightPaintjob(420, "headlight/bmw_5_series_e34/1.dds")
createNewHeadlightPaintjob(420, "headlight/bmw_5_series_e34/2.dds")
createNewHeadlightPaintjob(420, "headlight/bmw_5_series_e34/3.dds")
createNewHeadlightPaintjob(420, "headlight/bmw_5_series_e34/4.dds")
createNewHeadlightPaintjob(420, "headlight/bmw_5_series_e34/5.dds")
createNewHeadlightPaintjob(420, "headlight/bmw_5_series_e34/6.dds")
registerHeadlightPaintjob(400, "lights")
createNewHeadlightPaintjob(400, "headlight_sight/bmw_x5/1.dds")
createNewHeadlightPaintjob(400, "headlight_sight/bmw_x5/2.dds")
createNewHeadlightPaintjob(400, "headlight_sight/bmw_x5/3.dds")
createNewHeadlightPaintjob(400, "headlight_sight/bmw_x5/4.dds")
createNewHeadlightPaintjob(400, "headlight_sight/bmw_x5/5.dds")
registerHeadlightPaintjob(547, "lights")
createNewHeadlightPaintjob(547, "headlight_sight/volkswagen_bora/1.dds")
registerHeadlightPaintjob(561, "EMzone_GTi_detales")
createNewHeadlightPaintjob(561, "headlight_sight/volkswagen_golf_v/1.dds")
createNewHeadlightPaintjob(561, "headlight_sight/volkswagen_golf_v/2.dds")
createNewHeadlightPaintjob(561, "headlight_sight/volkswagen_golf_v/3.dds")
registerHeadlightPaintjob(551, "01")
createNewHeadlightPaintjob(551, "headlight/bmw_7_series_e38/1.dds")
createNewHeadlightPaintjob(551, "headlight/bmw_7_series_e38/2.dds")
createNewHeadlightPaintjob(551, "headlight/bmw_7_series_e38/3.dds")
createNewHeadlightPaintjob(551, "headlight/bmw_7_series_e38/4.dds")
createNewHeadlightPaintjob(551, "headlight/bmw_7_series_e38/5.dds")
createNewHeadlightPaintjob(551, "headlight/bmw_7_series_e38/6.dds")
createNewHeadlightPaintjob(551, "headlight/bmw_7_series_e38/7.dds")
createNewHeadlightPaintjob(551, "headlight/bmw_7_series_e38/8.dds")
createNewHeadlightPaintjob(551, "headlight/bmw_7_series_e38/9.dds")
createNewHeadlightPaintjob(551, "headlight/bmw_7_series_e38/10.dds")
createNewHeadlightPaintjob(551, "headlight/bmw_7_series_e38/11.dds")
registerHeadlightPaintjob(496, "scirocco_lights")
createNewHeadlightPaintjob(496, "headlight/volkswagen_scirocco/1.dds")
createNewHeadlightPaintjob(496, "headlight/volkswagen_scirocco/2.dds")
createNewHeadlightPaintjob(496, "headlight/volkswagen_scirocco/3.dds")
createNewHeadlightPaintjob(496, "headlight/volkswagen_scirocco/4.dds")
createNewHeadlightPaintjob(496, "headlight/volkswagen_scirocco/5.dds")
createNewHeadlightPaintjob(496, "headlight/volkswagen_scirocco/6.dds")

registerHeadlightPaintjob(492, "w206_lightpj")
createNewHeadlightPaintjob(492, "headlight/w206/1.dds")
createNewHeadlightPaintjob(492, "headlight/w206/2.dds")

registerHeadlightPaintjob(405, "a8tail")
createNewHeadlightPaintjob(405, "headlight/audi_a8/1.dds")
createNewHeadlightPaintjob(405, "headlight/audi_a8/2.dds")
createNewHeadlightPaintjob(405, "headlight/audi_a8/3.dds")
registerHeadlightPaintjob(566, "tail_octavia")
createNewHeadlightPaintjob(566, "headlight_sight/skoda_octavia/1.dds", "dxt5")
createNewHeadlightPaintjob(566, "headlight_sight/skoda_octavia/2.dds", "dxt5")
createNewHeadlightPaintjob(566, "headlight_sight/skoda_octavia/3.dds", "dxt5")
createNewHeadlightPaintjob(566, "headlight_sight/skoda_octavia/4.dds", "dxt5")
registerHeadlightPaintjob(562, "brakelight")
createNewHeadlightPaintjob(562, "headlight/nissan_skyline_r34_gtr/1.dds", "dxt5")
createNewHeadlightPaintjob(562, "headlight/nissan_skyline_r34_gtr/2.dds", "dxt5")
createNewHeadlightPaintjob(562, "headlight/nissan_skyline_r34_gtr/3.dds", "dxt5")
createNewHeadlightPaintjob(562, "headlight/nissan_skyline_r34_gtr/4.dds", "dxt5")
createNewHeadlightPaintjob(562, "headlight/nissan_skyline_r34_gtr/5.dds", "dxt5")
createNewHeadlightPaintjob(562, "headlight/nissan_skyline_r34_gtr/6.dds", "dxt5")
createNewHeadlightPaintjob(562, "headlight/nissan_skyline_r34_gtr/7.dds", "dxt5")
createNewHeadlightPaintjob(562, "headlight/nissan_skyline_r34_gtr/8.dds", "dxt5")
registerHeadlightPaintjob(507, "20")
createNewHeadlightPaintjob(507, "headlight/mercedes-benz_w220/1.dds")
createNewHeadlightPaintjob(507, "headlight/mercedes-benz_w220/2.dds")
createNewHeadlightPaintjob(507, "headlight/mercedes-benz_w220/3.dds")
createNewHeadlightPaintjob(507, "headlight/mercedes-benz_w220/4.dds")
createNewHeadlightPaintjob(507, "headlight/mercedes-benz_w220/5.dds")
registerVehiclePaintjob(561, "remapelegybody128")
createNewVehiclePaintjob(561, "taxi_sight/golfv.dds")
registerVehiclePaintjob(458, "remap")
createNewVehiclePaintjob(458, "taxi_sight/passat.dds")
registerVehiclePaintjob(589, "remap_body")
createNewVehiclePaintjob(589, "taxi_sight/golfvii.dds")
registerVehiclePaintjob(467, "t_body2")
createNewVehiclePaintjob(467, "taxi_sight/caprice.dds")
registerVehiclePaintjob(598, "remap")
createNewVehiclePaintjob(598, "taxi_sight/f11.dds")
registerVehiclePaintjob(551, "remap_750")
createNewVehiclePaintjob(551, "taxi_sight/e38.dds")
registerVehiclePaintjob(596, "remap_rs_body")
createNewVehiclePaintjob(596, "taxi_sight/rs6c7.dds")
registerVehiclePaintjob(580, "remap")
createNewVehiclePaintjob(580, "taxi_sight/rs4b8.dds")
registerVehiclePaintjob(466, "remap")
createNewVehiclePaintjob(466, "taxi_sight/giulia.dds")
registerVehiclePaintjob(405, "remap_a8")
createNewVehiclePaintjob(405, "taxi_sight/a8d4.dds")
registerVehiclePaintjob(445, "remap")
createNewVehiclePaintjob(445, "taxi_sight/e60.dds")
registerVehiclePaintjob(503, "remap_nosegrillm4")
createNewVehiclePaintjob(503, "taxi_sight/m4.dds")
registerVehiclePaintjob(420, "remap_e34")
createNewVehiclePaintjob(420, "taxi_sight/e34.dds")
registerVehiclePaintjob(400, "remap_x5")
createNewVehiclePaintjob(400, "taxi_sight/x5.dds")
registerVehiclePaintjob(582, "template")
createNewVehiclePaintjob(582, "taxi_sight/sprinter.dds")
registerVehiclePaintjob(418, "remap_body")
createNewVehiclePaintjob(418, "taxi_sight/caravelle.dds")
registerVehiclePaintjob(540, "remap_impreza")
createNewVehiclePaintjob(540, "taxi_sight/impreza.dds")
registerVehiclePaintjob(566, "remap_body")
createNewVehiclePaintjob(566, "taxi_sight/octaviamk1.dds")
registerVehiclePaintjob(529, "leon_remap")
createNewVehiclePaintjob(529, "taxi_sight/leon.dds")
registerVehiclePaintjob(560, "remapelegybody128")
createNewVehiclePaintjob(560, "taxi_sight/evo1.dds")
createNewVehiclePaintjob(560, "taxi_sight/evo2.dds")
registerVehiclePaintjob(507, "remap_w220")
createNewVehiclePaintjob(507, "taxi_sight/w220.dds")
registerVehiclePaintjob(549, "remap_m8comp")
createNewVehiclePaintjob(549, "taxi_sight/m81.dds")
createNewVehiclePaintjob(549, "taxi_sight/m82.dds")
registerVehiclePaintjob(401, "remap")
createNewVehiclePaintjob(401, "taxi_sight/focus.dds")
registerVehiclePaintjob(546, "lada_remap")
createNewVehiclePaintjob(546, "taxi_sight/lada.dds")
registerVehiclePaintjob(479, "remap_190e")
createNewVehiclePaintjob(479, "taxi_sight/190evo.dds")
registerVehiclePaintjob(438, "remap")
createNewVehiclePaintjob(438, "taxi_sight/w212.dds")
registerVehiclePaintjob(579, "remap_rover")
createNewVehiclePaintjob(579, "taxi_sight/range.dds")
registerVehiclePaintjob(547, "remap")
createNewVehiclePaintjob(547, "taxi_sight/bora.dds")
registerWheelPaintjob(467, "T_chrome2")
createNewWheelPaintjob(467, "wheels/caprice/1.dds")
createNewWheelPaintjob(467, "wheels/caprice/2.dds")
createNewWheelPaintjob(467, "wheels/caprice/3.dds")

registerWheelPaintjob(492, "w206_wheel")
createNewWheelPaintjob(492, "wheels/w206/1.dds")

registerHeadlightPaintjob(567, "@hite")
createNewHeadlightPaintjob(567, "wheels/impala/1.dds")
registerWheelPaintjob(540, "wheel")
createNewWheelPaintjob(540, "wheels/subaru_wrx/1.dds")
registerWheelPaintjob(445, "nodamage")
createNewWheelPaintjob(445, "wheels/bmw_e60/1.dds", "dxt5")
registerHeadlightPaintjob(438, "mbextra")
createNewHeadlightPaintjob(438, "wheels/mb_w212/1.dds")
registerHeadlightPaintjob(491, "vehiclelights")
createNewHeadlightPaintjob(491, "headlight/bmw_m635/1.dds")
createNewHeadlightPaintjob(491, "headlight/bmw_m635/2.dds")
createNewHeadlightPaintjob(491, "headlight/bmw_m635/3.dds")
registerHeadlightPaintjob(477, "vehiclelights")
createNewHeadlightPaintjob(477, "headlight/nissan_240sx/1.dds")
createNewHeadlightPaintjob(477, "headlight/nissan_240sx/2.dds")
createNewHeadlightPaintjob(477, "headlight/nissan_240sx/3.dds")
createNewHeadlightPaintjob(477, "headlight/nissan_240sx/4.dds")
registerHeadlightPaintjob(419, "lampshade_r")
createNewHeadlightPaintjob(419, "headlight/toyota_supra_a90/1.dds")
registerHeadlightPaintjob(589, "blightglass")
createNewHeadlightPaintjob(589, "headlight/vw_golf_vii/1.dds")
registerVehiclePaintjob(608, "v4_cartrailer_remap")
createNewVehiclePaintjob(608, "car_trailer/1.dds")
createNewVehiclePaintjob(608, "car_trailer/2.dds")
createNewVehiclePaintjob(608, "car_trailer/3.dds")
registerVehiclePaintjob(611, "v4_futo_remap")
createNewVehiclePaintjob(611, "futo/1.dds")
createNewVehiclePaintjob(611, "futo/2.dds")
createNewVehiclePaintjob(611, "futo/3.dds")
createNewVehiclePaintjob(611, "futo/4.dds")
registerHeadlightPaintjob(527, "lightglass")
createNewHeadlightPaintjob(527, "headlight/ford_mustang_gt/1.dds")
createNewHeadlightPaintjob(527, "headlight/ford_mustang_gt/2.dds")

registerHeadlightPaintjob("primo2", "bmw3erg20_lightglass")
createNewHeadlightPaintjob("primo2", "headlight/bmw_3_series_g20/1.dds")

registerVehiclePaintjob(528, "remap_bearcat")
createNewVehiclePaintjob(528, "emergency_sight/bearcat/1.dds")
