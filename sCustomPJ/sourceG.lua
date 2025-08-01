textureNames = {
  [466] = "remap",
  [424] = "remap",
  [585] = "rs2_remap",
  [526] = "remap",
  [405] = "remap_a8",
  [490] = "remap_q7",
  [533] = "remap",
  [580] = "remap_rs_body",
  [596] = "remap_rs_body",
  [602] = "remap_quattro82",
  [599] = "remap",
  [483] = "remap",
  [492] = "remap",
  [551] = "remap_750",
  [558] = "remap",
  [503] = "remap_nosegrillm4",
  [420] = "remap_e34",
  [445] = "remap",
  [598] = "remap",
  [491] = "remap_m635csi84",
  [549] = "remap_m8comp",
  [522] = "remap_suzuki",
  [400] = "remap_x5",
  [508] = "remap_camper",
  [494] = "remap_chiron",
  [576] = "remap_belair57",
  [541] = "camaro_remap",
  [467] = "remap_camry",
  [517] = "remap_chevelle67",
  [567] = "remap",
  [554] = "remap_silverado",
  [439] = "remap_charger70",
  [603] = "remap_coronet67",
  [426] = "paint_material",
  [429] = "remap_gts",
  [521] = "remap",
  [555] = "remap_250gto62",
  [411] = "remap_pista",
  [413] = "remap_eco",
  [495] = "remap",
  [525] = "remap_f550",
  [401] = "remap",
  [527] = "remap_mustang",
  [535] = "remapslamvan92body128",
  [434] = "remap_body",
  [536] = "remapbirdbody",
  [586] = "remap_fatboy",
  [463] = "remap_freeway",
  [565] = "remap_civic",
  [462] = "remap_yamaha",
  [542] = "remap_crx",
  [470] = "remap",
  [500] = "remapmesa256",
  [546] = "lada_remap",
  [451] = "remap",
  [409] = "remap_limo",
  [534] = "@hite",
  [477] = "remap",
  [506] = "remap",
  [479] = "remap_190e",
  [516] = "remap_300sel72",
  [502] = "remap",
  [415] = "remap",
  [438] = "remap",
  [550] = "remap_e420",
  [507] = "remap_w220",
  [404] = "remap_g63",
  [604] = "remap_body",
  [582] = "template",
  [560] = "remapelegybody128",
  [587] = "remap",
  [562] = "remapelegybody",
  [475] = "remap_cuda",
  [402] = "remap_firebird",
  [480] = "remap_porsche",
  [579] = "remap_rover",
  [529] = "leon_remap",
  [566] = "remap_body",
  [597] = "remap_octavia",
  [540] = "remap_impreza",
  [419] = "remap_body",
  [559] = "remap_supra92",
  [474] = "remap",
  [547] = "remap",
  [418] = "remap_body",
  [410] = "remapelegybody128",
  [561] = "remapelegybody128",
  [589] = "remap_body",
  [458] = "remap",
  [496] = "remap",
  [471] = "remap_quad",
  [468] = "remap",
  [497] = "remap",
  [421] = "remap_760",
  [543] = "remap_c8",
  [436] = "remap_34_body",
  ["leaf"] = "remap_leaf",
  ["model_s"] = "remap_models",
  ["model_y"] = "remap_modely",
  ["audirs7"] = "#emap_rs7",
  ["primo2"] = "remap_3erg20",
  ["dodge"] = "#emap_pear1500"
}



function getCustomPjTextureName(model)
  return textureNames[model]
end
function getCustomPjPrice()
  return 2300
end
origFE = fileExists
origFC = fileCreate
origFO = fileOpen
origFD = fileDelete
