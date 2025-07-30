local seexports = {sModloader = false, sGui = false}
local function sightlangProcessExports()
	for k in pairs(seexports) do
		local res = getResourceFromName(k)
		if res and getResourceState(res) == "running" then
			seexports[k] = exports[k]
		else
			seexports[k] = false
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
local sightlangModloaderLoaded = function()
	setDoRestream()
end
addEventHandler("modloaderLoaded", getRootElement(), sightlangModloaderLoaded)
if getElementData(localPlayer, "loggedIn") or seexports.sModloader and seexports.sModloader:isModloaderLoaded() then
	addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangModloaderLoaded)
end
local sightlangCondHandlState0 = false
local function sightlangCondHandl0(cond, prio)
	cond = cond and true or false
	if cond ~= sightlangCondHandlState0 then
		sightlangCondHandlState0 = cond
		if cond then
			addEventHandler("onClientPreRender", getRootElement(), doRestreamNextFrame, true, prio)
		else
			removeEventHandler("onClientPreRender", getRootElement(), doRestreamNextFrame)
		end
	end
end

disableableResources = {
	{
		"Fémdetektor",
		"sMetaldetector"
	},
	{
		"Fényezőműhely",
		"sPaintshop"
	},
	{
		"Adminisztráció",
		"sAdministration"
	},
	{
		"Bánya",
		"sMining"
	},
	{
		"Hirdetőtáblák",
		"sBillboard"
	},
	{
		"Farm",
		"sFarm"
	}
}

local vehicleMods = {
	{
		dff = "emperor.dff",
		txd = "emperor.txd",
		model = 585
	},
	{
		dff = "rancher2.dff",
		txd = "rancher2.txd",
		model = 505
	},
	{
		dff = "ambulan.dff",
		txd = "ambulan.txd",
		model = 416
	},
	{
		dff = "landstal.dff",
		txd = "landstal.txd",
		model = 400
	},
	{
		dff = "nrg500.dff",
		txd = "nrg500.txd",
		model = 522
	},
	{
		dff = "fortune.dff",
		txd = "fortune.txd",
		model = 526
	},
	{
		dff = "vcnmav.dff",
		txd = "vcnmav.txd",
		model = 488
	},
	{
		dff = "supergt.dff",
		txd = "supergt.txd",
		model = 506
	},
	{
		dff = "banshee.dff",
		txd = "banshee.txd",
		model = 429
	},
	{
		dff = "hotrina.dff",
		txd = "hotrina.txd",
		model = 502
	},
	{
		dff = "perennial.dff",
		txd = "perennial.txd",
		model = 404
	},
	{
		dff = "sandking.dff",
		txd = "sandking.txd",
		model = 495
	},
	{
		dff = "copcarla.dff",
		txd = "copcarla.txd",
		model = 596
	},
	{
		dff = "sadlshit.dff",
		txd = "sadlshit.txd",
		model = 605
	},
	{
		dff = "clover.dff",
		txd = "clover.txd",
		model = 542
	},
	{
		dff = "faggio.dff",
		txd = "faggio.txd",
		model = 462
	},
	{
		dff = "turismo.dff",
		txd = "turismo.txd",
		model = 451
	},
	{
		dff = "intruder.dff",
		txd = "intruder.txd",
		model = 546
	},
	{
		dff = "euros.dff",
		txd = "euros.txd",
		model = 587
	},
	{
		dff = "club.dff",
		txd = "club.txd",
		model = 589
	},
	{
		dff = "willard.dff",
		txd = "willard.txd",
		model = 529
	},
	{
		dff = "primo.dff",
		txd = "primo.txd",
		model = 547
	},
	{
		dff = "tahoma.dff",
		txd = "tahoma.txd",
		model = 566
	},
	{
		dff = "blistac.dff",
		txd = "blistac.txd",
		model = 496
	},
	{
		dff = "merit.dff",
		txd = "merit.txd",
		model = 551
	},
	{
		dff = "cadrona.dff",
		txd = "cadrona.txd",
		model = 527
	},
	{
		dff = "admiral.dff",
		txd = "admiral.txd",
		model = 445
	},
	{
		dff = "sentinel.dff",
		txd = "sentinel.txd",
		model = 405
	},
	{
		dff = "copcarsf.dff",
		txd = "copcarsf.txd",
		model = 597
	},
	{
		dff = "copcarvg.dff",
		txd = "copcarvg.txd",
		model = 598
	},
	{
		dff = "copcarru.dff",
		txd = "copcarru.txd",
		model = 599
	},
	{
		dff = "fbiranch.dff",
		txd = "fbiranch.txd",
		model = 490
	},
	{
		dff = "towtruck.dff",
		txd = "towtruck.txd",
		model = 525
	},
	{
		dff = "washing.dff",
		txd = "washing.txd",
		model = 421
	},
	{
		dff = "huntley.dff",
		txd = "huntley.txd",
		model = 579
	},
	{
		dff = "phoenix.dff",
		txd = "phoenix.txd",
		model = 603
	},
	{
		dff = "yosemite.dff",
		txd = "yosemite.txd",
		model = 554
	},
	{
		dff = "elegant.dff",
		txd = "elegant.txd",
		model = 507
	},
	{
		dff = "sabre.dff",
		txd = "sabre.txd",
		model = 475
	},
	{
		dff = "zr350.dff",
		txd = "zr350.txd",
		model = 477
	},
	{
		dff = "pony.dff",
		txd = "pony.txd",
		model = 413
	},
	{
		dff = "bullet.dff",
		txd = "bullet.txd",
		model = 541
	},
	{
		dff = "taxi.dff",
		txd = "taxi.txd",
		model = 420
	},
	{
		dff = "feltzer.dff",
		txd = "feltzer.txd",
		model = 533
	},
	{
		dff = "manana.dff",
		txd = "manana.txd",
		model = 410
	},
	{
		dff = "stafford.dff",
		txd = "stafford.txd",
		model = 580
	},
	{
		dff = "barracks.dff",
		txd = "barracks.txd",
		model = 433
	},
	{
		dff = "glendaleshit.dff",
		txd = "glendaleshit.txd",
		model = 604
	},
	{
		dff = "stallion.dff",
		txd = "stallion.txd",
		model = 439
	},
	{
		dff = "nebula.dff",
		txd = "nebula.txd",
		model = 516
	},
	{
		dff = "cargobob.dff",
		txd = "cargobob.txd",
		model = 548
	},
	{
		dff = "alpha.dff",
		txd = "alpha.txd",
		model = 602
	},
	{
		dff = "oceanic.dff",
		txd = "oceanic.txd",
		model = 467
	},
	{
		dff = "fcr900.dff",
		txd = "fcr900.txd",
		model = 521
	},
	{
		dff = "hermes.dff",
		txd = "hermes.txd",
		model = 474
	},
	{
		dff = "majestic.dff",
		txd = "majestic.txd",
		model = 517
	},
	{
		dff = "jesseboat.dff",
		txd = "jesseboat.txd",
		model = 446
	},
	{
		dff = "sunrise.dff",
		txd = "sunrise.txd",
		model = 550
	},
	{
		dff = "polmav.dff",
		txd = "polmav.txd",
		model = 497
	},
	{
		dff = "freeway.dff",
		txd = "freeway.txd",
		model = 463
	},
	{
		dff = "fire.dff",
		txd = "fire.txd",
		model = 407
	},
	{
		dff = "reefer.dff",
		txd = "reefer.txd",
		model = 453
	},
	{
		dff = "buffalo.dff",
		txd = "buffalo.txd",
		model = 402
	},
	{
		dff = "mesa.dff",
		txd = "mesa.txd",
		model = 500
	},
	{
		dff = "bravura.dff",
		txd = "bravura.txd",
		model = 401
	},
	{
		dff = "speeder.dff",
		txd = "speeder.txd",
		model = 452
	},
	{
		dff = "camper.dff",
		txd = "camper.txd",
		model = 483
	},
	{
		dff = "journey.dff",
		txd = "journey.txd",
		model = 508
	},
	{
		dff = "vincent.dff",
		txd = "vincent.txd",
		model = 540
	},
	{
		dff = "wayfarer.dff",
		txd = "wayfarer.txd",
		model = 586
	},
	{
		dff = "stretch.dff",
		txd = "stretch.txd",
		model = 409
	},
	{
		dff = "virgo.dff",
		txd = "virgo.txd",
		model = 491
	},
	{
		dff = "greenwood.dff",
		txd = "greenwood.txd",
		model = 492
	},
	{
		dff = "sanchez.dff",
		txd = "sanchez.txd",
		model = 468
	},
	{
		dff = "cabbie.dff",
		txd = "cabbie.txd",
		model = 438
	},
	{
		dff = "bmx.dff",
		txd = "bmx.txd",
		model = 481
	},
	{
		dff = "mtbike.dff",
		txd = "mtbike.txd",
		model = 510
	},
	{
		dff = "hotring.dff",
		txd = "hotring.txd",
		model = 494
	},
	{
		dff = "patriot.dff",
		txd = "patriot.txd",
		model = 470
	},
	{
		dff = "enforcer.dff",
		txd = "enforcer.txd",
		model = 427
	},
	{
		dff = "glendale.dff",
		txd = "glendale.txd",
		model = 466
	},
	{
		dff = "rustler.dff",
		txd = "rustler.txd",
		model = 476
	},
	{
		dff = "packer.dff",
		txd = "packer.txd",
		model = 443
	},
	{
		dff = "swatvan.dff",
		txd = "swatvan.txd",
		model = 601
	},
	{
		dff = "hotknife.dff",
		txd = "hotknife.txd",
		model = 434
	},
	{
		dff = "newsvan.dff",
		txd = "newsvan.txd",
		model = 582
	},
	{
		dff = "bfinjection.dff",
		txd = "bfinjection.txd",
		model = 424
	},
	{
		dff = "windsor.dff",
		txd = "windsor.txd",
		model = 555
	},
	{
		dff = "copbike.dff",
		txd = "copbike.txd",
		model = 523
	},
	{
		dff = "comet.dff",
		txd = "comet.txd",
		model = 480
	},
	{
		dff = "solair.dff",
		txd = "solair.txd",
		model = 458
	},
	{
		dff = "infernus.dff",
		txd = "infernus.txd",
		model = 411
	},
	{
		dff = "tampa.dff",
		txd = "tampa.txd",
		model = 549
	},
	{
		dff = "premier.dff",
		txd = "premier.txd",
		model = 426
	},
	{
		dff = "hotrinb.dff",
		txd = "hotrinb.txd",
		model = 503
	},
	{
		dff = "cheetah.dff",
		txd = "cheetah.txd",
		model = 415
	},
	{
		dff = "blade.dff",
		txd = "blade.txd",
		model = 536
	},
	{
		dff = "tornado.dff",
		txd = "tornado.txd",
		model = 576
	},
	{
		dff = "remingtn.dff",
		txd = "remingtn.txd",
		model = 534
	},
	{
		dff = "flash.dff",
		txd = "flash.txd",
		model = 565
	},
	{
		dff = "savanna.dff",
		txd = "savanna.txd",
		model = 567
	},
	{
		dff = "fbitruck.dff",
		txd = "fbitruck.txd",
		model = 528
	},
	{
		dff = "stratum.dff",
		txd = "stratum.txd",
		model = 561
	},
	{
		dff = "jester.dff",
		txd = "jester.txd",
		model = 559
	},
	{
		dff = "slamvan.dff",
		txd = "slamvan.txd",
		model = 535
	},
	{
		dff = "sultan.dff",
		txd = "sultan.txd",
		model = 560
	},
	{
		dff = "elegy.dff",
		txd = "elegy.txd",
		model = 562
	},
	{
		dff = "previon.dff",
		txd = "previon.txd",
		model = 436
	},
	{
		dff = "uranus.dff",
		txd = "uranus.txd",
		model = 558
	},
	{
		dff = "exh_lr_bl1.dff",
		model = 1104
	},
	{
		dff = "exh_lr_bl2.dff",
		model = 1105
	},
	{
		dff = "fbmp_lr_bl1.dff",
		model = 1182
	},
	{
		dff = "fbmp_lr_bl2.dff",
		model = 1181
	},
	{
		dff = "rbmp_lr_bl1.dff",
		model = 1184
	},
	{
		dff = "exh_lr_t1.dff",
		model = 1136
	},
	{
		dff = "exh_lr_t2.dff",
		model = 1135
	},
	{
		dff = "fbmp_lr_t1.dff",
		model = 1191
	},
	{
		dff = "fbmp_lr_t2.dff",
		model = 1190
	},
	{
		dff = "rbmp_lr_t1.dff",
		model = 1192
	},
	{
		dff = "rbmp_lr_t2.dff",
		model = 1193
	},
	{
		dff = "wg_l_lr_t1.dff",
		model = 1134
	},
	{
		dff = "wg_r_lr_t1.dff",
		model = 1137
	},
	{
		dff = "rbmp_lr_rem1.dff",
		model = 1180
	},
	{
		dff = "fbmp_lr_rem1.dff",
		model = 1179
	},
	{
		dff = "fbmp_lr_rem2.dff",
		model = 1185
	},
	{
		dff = "rbmp_lr_rem2.dff",
		model = 1178
	},
	{
		dff = "misc_c_lr_rem2.dff",
		model = 1123
	},
	{
		dff = "exh_lr_rem2.dff",
		model = 1127
	},
	{
		dff = "misc_c_lr_rem1.dff",
		model = 1100
	},
	{
		dff = "exh_lr_rem1.dff",
		model = 1126
	},
	{
		dff = "wg_r_lr_rem2.dff",
		model = 1124
	},
	{
		dff = "wg_l_lr_rem2.dff",
		model = 1106
	},
	{
		dff = "misc_c_lr_rem3.dff",
		model = 1125
	},
	{
		dff = "wg_r_lr_rem1.dff",
		model = 1101
	},
	{
		dff = "wg_l_lr_rem1.dff",
		model = 1122
	},
	{
		dff = "exh_a_f.dff",
		model = 1046
	},
	{
		dff = "exh_c_f.dff",
		model = 1045
	},
	{
		dff = "fbmp_a_f.dff",
		model = 1153
	},
	{
		dff = "fbmp_c_f.dff",
		model = 1152
	},
	{
		dff = "rbmp_a_f.dff",
		model = 1150
	},
	{
		dff = "rbmp_c_f.dff",
		model = 1151
	},
	{dff = "rf_a_f.dff", model = 1054},
	{dff = "rf_c_f.dff", model = 1053},
	{
		dff = "spl_a_f_r.dff",
		model = 1049
	},
	{
		dff = "spl_c_f_r.dff",
		model = 1050
	},
	{
		dff = "wg_l_a_f.dff",
		model = 1047
	},
	{
		dff = "wg_l_c_f.dff",
		model = 1048
	},
	{
		dff = "wg_r_a_f.dff",
		model = 1051
	},
	{
		dff = "wg_r_c_f.dff",
		model = 1052
	},
	{
		dff = "exh_lr_sv1.dff",
		model = 1129
	},
	{
		dff = "exh_lr_sv2.dff",
		model = 1132
	},
	{
		dff = "fbmp_lr_sv1.dff",
		model = 1189
	},
	{
		dff = "fbmp_lr_sv2.dff",
		model = 1188
	},
	{
		dff = "rbmp_lr_sv1.dff",
		model = 1187
	},
	{
		dff = "rbmp_lr_sv2.dff",
		model = 1186
	},
	{
		dff = "rf_lr_sv1.dff",
		model = 1130
	},
	{
		dff = "rf_lr_sv2.dff",
		model = 1131
	},
	{
		dff = "exh_a_st.dff",
		model = 1064
	},
	{
		dff = "exh_c_st.dff",
		model = 1059
	},
	{
		dff = "fbmp_a_st.dff",
		model = 1155
	},
	{
		dff = "fbmp_c_st.dff",
		model = 1157
	},
	{
		dff = "rbmp_a_st.dff",
		model = 1154
	},
	{
		dff = "rbmp_c_st.dff",
		model = 1156
	},
	{
		dff = "rf_a_st.dff",
		model = 1055
	},
	{
		dff = "rf_c_st.dff",
		model = 1061
	},
	{
		dff = "spl_a_st_r.dff",
		model = 1058
	},
	{
		dff = "spl_c_st_r.dff",
		model = 1060
	},
	{
		dff = "wg_l_a_st.dff",
		model = 1056
	},
	{
		dff = "wg_l_c_st.dff",
		model = 1057
	},
	{
		dff = "wg_r_a_st.dff",
		model = 1062
	},
	{
		dff = "wg_r_c_st.dff",
		model = 1063
	},
	{
		dff = "exh_a_j.dff",
		model = 1065
	},
	{
		dff = "exh_c_j.dff",
		model = 1066
	},
	{
		dff = "fbmp_a_j.dff",
		model = 1160
	},
	{
		dff = "fbmp_c_j.dff",
		model = 1173
	},
	{
		dff = "rbmp_a_j.dff",
		model = 1159
	},
	{
		dff = "rbmp_c_j.dff",
		model = 1161
	},
	{dff = "rf_a_j.dff", model = 1067},
	{dff = "rf_c_j.dff", model = 1068},
	{
		dff = "spl_a_j_b.dff",
		model = 1162
	},
	{
		dff = "spl_c_j_b.dff",
		model = 1158
	},
	{
		dff = "wg_l_a_j.dff",
		model = 1070
	},
	{
		dff = "wg_r_a_j.dff",
		model = 1071
	},
	{
		dff = "wg_r_c_j.dff",
		model = 1072
	},
	{
		dff = "bbb_lr_slv1.dff",
		model = 1109
	},
	{
		dff = "exh_lr_slv1.dff",
		model = 1113
	},
	{
		dff = "exh_lr_slv2.dff",
		model = 1114
	},
	{
		dff = "fbb_lr_slv1.dff",
		model = 1115
	},
	{
		dff = "fbb_lr_slv2.dff",
		model = 1116
	},
	{
		dff = "fbmp_lr_slv1.dff",
		model = 1117
	},
	{
		dff = "exh_a_s.dff",
		model = 1028
	},
	{
		dff = "exh_c_s.dff",
		model = 1029
	},
	{
		dff = "fbmp_a_s.dff",
		model = 1169
	},
	{
		dff = "fbmp_c_s.dff",
		model = 1170
	},
	{
		dff = "rbmp_a_s.dff",
		model = 1141
	},
	{
		dff = "rbmp_c_s.dff",
		model = 1140
	},
	{dff = "rf_a_s.dff", model = 1032},
	{dff = "rf_c_s.dff", model = 1033},
	{
		dff = "spl_a_s_b.dff",
		model = 1138
	},
	{
		dff = "spl_c_s_b.dff",
		model = 1139
	},
	{
		dff = "wg_l_a_s.dff",
		model = 1026
	},
	{
		dff = "wg_l_c_s.dff",
		model = 1031
	},
	{
		dff = "wg_r_a_s.dff",
		model = 1027
	},
	{
		dff = "wg_r_c_s.dff",
		model = 1030
	},
	{
		dff = "fbmp_a_l.dff",
		model = 1171
	},
	{
		dff = "fbmp_c_l.dff",
		model = 1172
	},
	{
		dff = "rbmp_a_l.dff",
		model = 1149
	},
	{
		dff = "rbmp_c_l.dff",
		model = 1148
	},
	{
		dff = "spl_a_l_b.dff",
		model = 1147
	},
	{
		dff = "spl_c_l_b.dff",
		model = 1146
	},
	{
		dff = "wg_L_a_l.dff",
		model = 1036
	},
	{
		dff = "wg_l_c_l.dff",
		model = 1039
	},
	{
		dff = "wg_r_a_l.dff",
		model = 1040
	},
	{
		dff = "wg_r_c_l.dff",
		model = 1041
	},
	{
		dff = "exh_a_f.dff",
		model = 1046
	},
	{
		dff = "exh_c_f.dff",
		model = 1045
	},
	{
		dff = "fbmp_a_f.dff",
		model = 1153
	},
	{
		dff = "fbmp_c_f.dff",
		model = 1152
	},
	{
		dff = "rbmp_a_f.dff",
		model = 1150
	},
	{
		dff = "rbmp_c_f.dff",
		model = 1151
	},
	{dff = "rf_a_f.dff", model = 1054},
	{dff = "rf_c_f.dff", model = 1053},
	{
		dff = "spl_a_f_r.dff",
		model = 1049
	},
	{
		dff = "spl_c_f_r.dff",
		model = 1050
	},
	{
		dff = "wg_l_a_f.dff",
		model = 1047
	},
	{
		dff = "wg_l_c_f.dff",
		model = 1048
	},
	{
		dff = "wg_r_a_f.dff",
		model = 1051
	},
	{
		dff = "wg_r_c_f.dff",
		model = 1052
	},
	{
		dff = "exh_a_u.dff",
		model = 1092
	},
	{
		dff = "exh_c_u.dff",
		model = 1089
	},
	{
		dff = "fbmp_a_u.dff",
		model = 1166
	},
	{
		dff = "fbmp_c_u.dff",
		model = 1165
	},
	{
		dff = "rbmp_a_u.dff",
		model = 1168
	},
	{
		dff = "rbmp_c_u.dff",
		model = 1167
	},
	{dff = "rf_a_u.dff", model = 1088},
	{dff = "rf_c_u.dff", model = 1091},
	{
		dff = "spl_a_u_b.dff",
		model = 1164
	},
	{
		dff = "spl_c_u_b.dff",
		model = 1163
	},
	{
		dff = "wg_l_a_u.dff",
		model = 1090
	},
	{
		dff = "wg_l_c_u.dff",
		model = 1093
	},
	{
		dff = "wg_r_a_u.dff",
		model = 1094
	},
	{
		dff = "wg_r_c_u.dff",
		model = 1095
	},
	{
		dff = "exh_a_l.dff",
		model = 1034
	},
	{
		dff = "exh_c_l.dff",
		model = 1037
	},
	{
		dff = "trailer.dff",
		txd = "trailer.txd",
		model = 608
	},
	{
		dff = "utiltr1.dff",
		txd = "utiltr1.txd",
		model = 611
	},
	{
		dff = "quad.dff",
		txd = "quad.txd",
		model = 471
	},
	{
		dff = "regina.dff",
		txd = "regina.txd",
		model = 479
	},
	{
		dff = "moonbeam.dff",
		txd = "moonbeam.txd",
		model = 418
	},
	{
		dff = "esperanto.dff",
		txd = "esperanto.txd",
		model = 419
	},
	{
		dff = "raindance.dff",
		txd = "raindance.txd",
		model = 563
	},
	{
		dff = "securica.dff",
		txd = "securica.txd",
		model = 428
	},
	{
		dff = "sadler.dff",
		txd = "sadler.txd",
		model = 543
	},
	{
		name = "Tesla Model S",
		model = engineRequestModel("vehicle", 445),
		customVeh = "model_s",
		dff = "model_s.dff",
		txd = "model_s.txd",
		manufacturer = "Tesla",
		carshop = {
			price = 299000000,
			premium = 79900,
			limit = 1,
			customVeh = true
		}
	},
	{
		name = "Tesla Model Y",
		model = engineRequestModel("vehicle", 445),
		customVeh = "model_y",
		dff = "model_y.dff",
		txd = "model_y.txd",
		manufacturer = "Tesla",
		carshop = {
			price = 299000000,
			premium = 79900,
			limit = 1,
			customVeh = true
		}
	},
	{
		name = "Nissan Leaf",
		model = engineRequestModel("vehicle", 445),
		customVeh = "leaf",
		dff = "leaf.dff",
		txd = "leaf.txd",
		manufacturer = "Nissan",
		carshop = {
			price = 299000000,
			premium = 79900,
			limit = 1,
			customVeh = true
		}
	},
	{
		name = "BMW M3 G20",
		model = engineRequestModel("vehicle", 445),
		customVeh = "primo2",
		dff = "primo2.dff",
		txd = "primo2.txd",
		manufacturer = "BMW",
		carshop = {
			price = 299000000,
			premium = 79900,
			limit = 1,
			customVeh = true
		}
	},
	{
		name = "Audi RS7 Sportback",
		model = engineRequestModel("vehicle", 445),
		customVeh = "audirs7",
		dff = "audirs7.dff",
		txd = "audirs7.txd",
		manufacturer = "Audi",
		carshop = {
			price = 299000000,
			premium = 79900,
			limit = 1,
			customVeh = true
		}
	},
	{
		name = "Dodge RAM 1500 Limited",
		model = engineRequestModel("vehicle", 495),
		customVeh = "dodge",
		dff = "dodge.dff",
		txd = "dodge.txd",
		manufacturer = "Dodge",
		carshop = {
			price = 299000000,
			premium = 79900,
			limit = 1,
			customVeh = true
		}
	},
}
local putTogether = false
local img
function processVehPieces()
	if putTogether then
		return
	end
	img = engineLoadIMG("vehs_sight_1.img")
	engineAddImage(img)
end
function getVehicleCount()
	local c = 0
	for i in pairs(vehicleMods) do
		c = c + 1
	end
	return c
end

local doRestream = false


function getCustomModel(type)
	local modelId = false
	for i in pairs(vehicleMods) do
		if vehicleMods[i].customVeh == type then
			modelId = vehicleMods[i].model
		end
	end
	return modelId
end

function getCustomVehicleName(model)
	local name = "N/A"
	for i in pairs(vehicleMods) do
		if vehicleMods[i].model == model then
			name = vehicleMods[i].name
		end
	end
	return name
end

function getCustomVehicleManufacturer(model)
	local name = "N/A"
	for i in pairs(vehicleMods) do
		if vehicleMods[i].model == model then
			name = vehicleMods[i].manufacturer
		end
	end
	return name
end

function loadVehicleModel()
	processVehPieces()
	for i in pairs(vehicleMods) do
		if not vehicleMods[i].loaded then
			local model = vehicleMods[i].model
			if vehicleMods[i].txd then
				local txdID = engineGetModelTXDID(model)
				if model > 611 then
					newTxdID = engineRequestTXD("WESTERNHOUSES01"..model)
					engineImageLinkTXD(img, vehicleMods[i].txd, newTxdID)
					engineSetModelTXDID(model, newTxdID)
					exports.sInfinity:setCustomVehicleModel(vehicleMods[i].customVeh, model)
				else
					engineImageLinkTXD(img, vehicleMods[i].txd, txdID)
				end
			end
			engineImageLinkDFF(img, vehicleMods[i].dff, model)
			vehicleMods[i].loaded = true
		end
	end
	engineRestreamWorld()
	return false
end

function setDoRestream()
	doRestream = true
	sightlangCondHandl0(true)
end
addEventHandler("onClientPlayerSpawn", localPlayer, setDoRestream)
function doRestreamNextFrame()
	local now = getTickCount()
	if doRestream then
		doRestream = false
		engineRestreamWorld(false)
	end
	sightlangCondHandl0(false)
end
local r10_0 = {
	256,
	768,
	true,
	20,
	false,
	30,
	false,
	30
}
local r11_0 = 256
local r12_0 = 768
local r13_0 = 41943040
local r14_0 = 83886080
local r15_0 = 57671680
local r16_0 = 115343360
local r17_0 = 8
local r18_0 = 5000
local r19_0 = 5
local r20_0, r21_0 = guiGetScreenSize()
local r22_0 = nil
local r23_0 = false
local r24_0 = 15
local r25_0 = nil
local r26_0 = 0
local r27_0 = false
local r28_0 = false
local r29_0 = false
local r30_0 = false
local r31_0 = 1
local r32_0 = 0
local r33_0 = {
	"Streaming beállítások",
	"Resource beállítások",
}
local r34_0 = {}
for r38_0 = 1, #disableableResources, 1 do
	r34_0[disableableResources[r38_0][2]] = r38_0
end
local r35_0 = {}
function isResourceDisabled(r0_7)
	local r1_7 = r34_0[r0_7]
	if not r1_7 then
		return false
	end
	return r35_0[r1_7]
end
local r36_0 = {}
function processSettings(r0_8)
	if r0_8[3] then
		triggerServerEvent("enableRestreamForPlayer", localPlayer, true)
	else
		triggerServerEvent("enableRestreamForPlayer", localPlayer, false)
	end
	return {
		minmb = r0_8[1],
		maxmb = r0_8[2],
		enabled = r0_8[3],
		diffIs = r0_8[4],
		onTimeEnabled = r0_8[5],
		onTime = r0_8[6],
		forceFreeEnabled = r0_8[7],
		forceFree = r0_8[8],
	}
end
function timerFunction()
	local r0_9 = engineStreamingGetMemorySize()
	local r1_9 = r0_9 - engineStreamingGetUsedMemory()
	if r25_0.enabled then
		local r2_9 = r25_0.minmb * 1024 * 1024
		local r3_9 = r25_0.maxmb * 1024 * 1024
		if r0_9 == r3_9 and r1_9 <= r25_0.diffIs then
			r26_0 = r26_0 + 1
			if r26_0 == r19_0 then
				r26_0 = 0
				forceRestreamHandler()
			end
		end
		if r1_9 <= r13_0 then
			local r4_9 = math.max(math.min(r0_9 + r15_0, r3_9), r2_9)
			if r0_9 ~= r4_9 then
				engineStreamingSetMemorySize(r4_9)
			end
		end
		if r14_0 <= r1_9 then
			local r4_9 = math.min(math.max(r0_9 - r16_0, r2_9), r3_9)
			if r0_9 ~= r4_9 then
				engineStreamingSetMemorySize(r4_9)
			end
		end
	end
	if r25_0.onTimeEnabled then
		local r2_9 = getTickCount()
		if not r28_0 or r25_0.onTime * 60000 <= r2_9 - r28_0 then
			r28_0 = r2_9
			forceRestreamHandler()
		end
	end
	if r25_0.forceFreeEnabled then
		local r2_9 = getTickCount()
		if not r29_0 or r25_0.forceFree * 60000 <= r2_9 - r29_0 then
			r29_0 = r2_9
			engineStreamingFreeUpMemory(99999999)
		end
	end
end
function forceRestreamHandler()
	if not streamingEnabled then
		return 
	end
	engineRestreamWorld()
	lastRestream = getTickCount()
end
addEvent("forceRestreamPlayerWorld", true)
addEventHandler("forceRestreamPlayerWorld", getRootElement(), function(r0_11)
	if r0_11 and source == localPlayer then
		engineRestreamWorld()
	end
end)
local r37_0 = true

addEventHandler("onClientResourceStart", getResourceRootElement(), function()
	if source == resourceRoot then
		r25_0 = processSettings(r10_0)
		hasFile = fileExists("performance.sight")
		if hasFile then
			perfFile = fileOpen("performance.sight", true)
			if perfFile then
				fileContent = fileRead(perfFile, fileGetSize(perfFile))
				if fileContent then
					local r0_15 = fromJSON(fileContent)
					if r0_15 then
						r25_0 = processSettings(r0_15)
					end
				end
				fileClose(perfFile)
			end
		end
		engineStreamingSetModelCacheLimits(0, 0)
		r1_11 = engineStreamingSetBufferSize(r17_0 * 1024 * 1024)
		if not r1_11 then
			r2_11 = string.format("[SIGHT-STREAMER] Could not resize IMG streaming buffer to %d megabytes, gameplay will be affected negatively.", r17_0)
		end
		timerFunction()
		setTimer(timerFunction, r18_0, 0)
	end
	r1_11 = r38_0
	if r1_11 then
		r1_11 = getResourceFromName("sLast")
		if r1_11 and getResourceState(r1_11) == "running" then
			if fileExists("resourceStates.sight") then
				r2_11 = fileOpen("resourceStates.sight", true)
				local r0_15 = false
				if r2_11 then
					local r1_15 = fileRead(r2_11, fileGetSize(r2_11))
					if r1_15 then
						local r2_15 = fromJSON(r1_15)
						if r2_15 then
							for r6_15, r7_15 in pairs(r2_15) do
								r0_15 = true
								r35_0[tonumber(r6_15)] = true
							end
						end
					end
					fileClose(r2_11)
				end
				if r0_15 then
					for r4_15 = 1, #disableableResources, 1 do
						if r35_0[r4_15] then
							triggerServerEvent("requestToStopResource", resourceRoot, disableableResources[r4_15][2])
						end
					end
				end
			end
			r38_0 = false
		end
	end
end)
addEventHandler("onClientResourceStart", resourceRoot, function()
	if fileExists("performance.sight") then
		perfFile = fileOpen("performance.sight", true)
		if perfFile then
			fileContent = fileRead(perfFile, fileGetSize(perfFile))
			if fileContent and fromJSON(fileContent)[3] then
				triggerServerEvent("enableRestreamForPlayer", localPlayer, true)
			end
		end
	end
end)
addEvent("setRestreamingEnabled", true)
addEventHandler("setRestreamingEnabled", root, function(r0_17)
	streamingEnabled = r0_17
	if r0_17 then
		forceRestreamHandler()
	end
end)
local function r39_0()
	forceRestreamHandler()
end
if seexports.sModloader and seexports.sModloader:isModloaderLoaded() and getElementData(localPlayer, "loggedIn") then
	addEventHandler("onClientResourceStart", resourceRoot, r39_0)
end
addEventHandler("modloaderLoaded", root, r39_0)
local r40_0 = false
local r41_0 = 650
local r42_0 = 400
local r43_0 = false
local r44_0 = false
local r45_0 = false
local r46_0 = false
local r47_0 = false
local r48_0 = false
local r49_0 = false
local r50_0 = false
local r51_0 = false
local r52_0 = false
local r53_0 = false
local r54_0 = false
local r55_0 = false
local r56_0 = false
local r57_0 = {}
local r58_0 = {}
function convertSliderToRange(r0_19, r1_19, r2_19, r3_19)
	return math.floor(((r1_19 + (r2_19 - r1_19) * r0_19) / r3_19 + 0.5)) * r3_19
end
function convertRangeToSlider(r0_20, r1_20, r2_20)
	return (r0_20 - r1_20) / (r2_20 - r1_20)
end
function refreshResourceList()
	for r3_21 = 1, #r58_0, 1 do
		if not disableableResources[r3_21] then
			for r7_21 = 1, #r58_0[r3_21], 1 do
				if r58_0[r3_21][r7_21] then
					seexports.sGui:setGuiRenderDisabled(r58_0[r3_21][r7_21], true)
				end
			end
		else
			for r7_21 = 1, #r58_0[r3_21], 1 do
				if r58_0[r3_21][r7_21] then
					seexports.sGui:setGuiRenderDisabled(r58_0[r3_21][r7_21], false)
				end
			end
			seexports.sGui:setLabelText(r58_0[r3_21][1], disableableResources[r3_21 + r32_0][1])
			if r35_0[r3_21 + r32_0] then
				seexports.sGui:setGuiBackground(r58_0[r3_21][2], "solid", "sightgreen")
				seexports.sGui:setGuiHover(r58_0[r3_21][2], "gradient", {
					"sightgreen",
					"sightgreen-second"
				}, false, true)
				seexports.sGui:setButtonText(r58_0[r3_21][2], "Bekapcsolás")
			else
				seexports.sGui:setGuiBackground(r58_0[r3_21][2], "solid", "sightred")
				seexports.sGui:setGuiHover(r58_0[r3_21][2], "gradient", {
					"sightred",
					"sightred-second"
				}, false, true)
				seexports.sGui:setButtonText(r58_0[r3_21][2], "Kikapcsolás")
			end
			seexports.sGui:setClickArgument(r58_0[r3_21][2], r3_21 + r32_0)
		end
	end
	local r0_21 = 350 / math.max(1, (#disableableResources - 12 + 1))
	seexports.sGui:setGuiSize(r56_0, false, r0_21)
	seexports.sGui:setGuiPosition(r56_0, false, r0_21 * r32_0)
end
function refreshPerformanceWindowAll()
	seexports.sGui:setSliderValue(r43_0, convertRangeToSlider(r25_0.minmb, r11_0, r12_0))
	seexports.sGui:setInputValue(r44_0, string.format("%.2f", r25_0.minmb))
	seexports.sGui:setSliderValue(r45_0, convertRangeToSlider(r25_0.maxmb, r11_0, r12_0))
	seexports.sGui:setInputValue(r46_0, string.format("%.2f", r25_0.maxmb))
	seexports.sGui:setCheckboxChecked(r47_0, r25_0.enabled)
	seexports.sGui:setSliderValue(r48_0, convertRangeToSlider(r25_0.diffIs, 1, 100))
	seexports.sGui:setInputValue(r49_0, string.format("%.2f", r25_0.diffIs))
	seexports.sGui:setCheckboxChecked(r50_0, r25_0.onTimeEnabled)
	seexports.sGui:setSliderValue(r51_0, convertRangeToSlider(r25_0.onTime, 15, 300))
	seexports.sGui:setInputValue(r52_0, string.format("%.2f", r25_0.onTime))
	seexports.sGui:setCheckboxChecked(r53_0, r25_0.forceFreeEnabled)
	seexports.sGui:setSliderValue(r54_0, convertRangeToSlider(r25_0.forceFree, 15, 300))
	seexports.sGui:setInputValue(r55_0, string.format("%.2f", r25_0.forceFree))
end
function destroyPerformanceWindow()
	if r40_0 then
		seexports.sGui:deleteGuiElement(r40_0)
	end
	r40_0 = false
	r43_0 = false
	r44_0 = false
	r45_0 = false
	r46_0 = false
	r47_0 = false
	r48_0 = false
	r49_0 = false
	r50_0 = false
	r51_0 = false
	r52_0 = false
	r56_0 = false
	r57_0 = {}
	r58_0 = {}
	removeEventHandler("onClientKey", getRootElement(), scrollHandler)
end
function createPerformanceWindow()
	destroyPerformanceWindow()
	r40_0 = seexports.sGui:createGuiElement("window", r20_0 / 2 - r41_0 / 2, r21_0 / 2 - r42_0 / 2, r41_0, r42_0)
	seexports.sGui:setWindowTitle(r40_0, "16/BebasNeueRegular.otf", "SightMTA - Performance")
	seexports.sGui:setWindowCloseButton(r40_0, "closePerformanceWindow")
	local r0_25 = seexports.sGui:getTitleBarHeight()
	local r1_25 = (r42_0 - r0_25) / #r33_0
	local r2_25 = r0_25
	for r6_25 = 1, #r33_0, 1 do
		local r7_25 = seexports.sGui:createGuiElement("button", 0, r2_25, 160, r1_25, r40_0)
		seexports.sGui:setGuiBackground(r7_25, "solid", "sightgrey1")
		seexports.sGui:setGuiHover(r7_25, "gradient", {
			"sightgrey1",
			"sightgrey2"
		}, false, true)
		seexports.sGui:setButtonFont(r7_25, "12/BebasNeueBold.otf")
		seexports.sGui:setButtonText(r7_25, r33_0[r6_25])
		seexports.sGui:setClickEvent(r7_25, "selectPerformanceWindowCategory")
		r57_0[r7_25] = r6_25
		r2_25 = r2_25 + r1_25
	end
	for r6_25, r7_25 in pairs(r57_0) do
		if r31_0 == r7_25 then
			seexports.sGui:setGuiBackground(r6_25, "solid", "sightgrey2")
			seexports.sGui:setGuiHoverable(r6_25, false)
		else
			seexports.sGui:setGuiBackground(r6_25, "solid", "sightgrey1")
			seexports.sGui:setGuiHoverable(r6_25, true)
		end
	end
	if r31_0 == 1 then
		local r3_25 = seexports.sGui:getFontHeight("11/Ubuntu-R.ttf")
		local r4_25 = seexports.sGui:createGuiElement("label", 170, r0_25, r41_0, 20 + r3_25 * 1, r40_0)
		seexports.sGui:setLabelAlignment(r4_25, "left", "center")
		seexports.sGui:setLabelText(r4_25, "Minimum streaming memory")
		seexports.sGui:setLabelFont(r4_25, "11/Ubuntu-R.ttf")
		local r5_25 = 180 + seexports.sGui:getLabelTextWidth(r4_25)
		r43_0 = seexports.sGui:createGuiElement("slider", r5_25, 28 + r3_25 * 1, r41_0 - r5_25 - 60, 20, r40_0)
		seexports.sGui:setSliderChangeEvent(r43_0, "refreshPerformanceWindowSlider")
		seexports.sGui:setClickArgument(r43_0, "minimumStreamingMemory")
		r44_0 = seexports.sGui:createGuiElement("input", r5_25 + r41_0 - r5_25 - 60 + 5, 28 + r3_25 * 1, 50, 20, r40_0)
		seexports.sGui:setInputNumberOnly(r44_0, true, true)
		seexports.sGui:setInputFont(r44_0, "10/Ubuntu-R.ttf")
		seexports.sGui:setClickArgument(r44_0, "minimumStreamingMemory")
		seexports.sGui:setInputChangeEvent(r44_0, "refreshPerformanceWindowInput")
		local r6_25 = seexports.sGui:getFontHeight("11/Ubuntu-R.ttf")
		local r7_25 = seexports.sGui:createGuiElement("label", 170, r0_25, r41_0, 20 + r6_25 * 5, r40_0)
		seexports.sGui:setLabelAlignment(r7_25, "left", "center")
		seexports.sGui:setLabelText(r7_25, "Maximum streaming memory")
		seexports.sGui:setLabelFont(r7_25, "11/Ubuntu-R.ttf")
		local r8_25 = 180 + seexports.sGui:getLabelTextWidth(r7_25)
		r45_0 = seexports.sGui:createGuiElement("slider", r8_25, 28 + r6_25 * 3, r41_0 - r8_25 - 60, 20, r40_0)
		seexports.sGui:setSliderChangeEvent(r45_0, "refreshPerformanceWindowSlider")
		seexports.sGui:setClickArgument(r45_0, "maximumStreamingMemory")
		r46_0 = seexports.sGui:createGuiElement("input", r8_25 + r41_0 - r8_25 - 60 + 5, 28 + r6_25 * 3, 50, 20, r40_0)
		seexports.sGui:setInputNumberOnly(r46_0, true)
		seexports.sGui:setInputFont(r46_0, "10/Ubuntu-R.ttf")
		seexports.sGui:setClickArgument(r46_0, "maximumStreamingMemory")
		seexports.sGui:setInputChangeEvent(r46_0, "refreshPerformanceWindowInput")
		local r9_25 = seexports.sGui:createGuiElement("label", 170, r0_25, r41_0, 20 + seexports.sGui:getFontHeight("11/Ubuntu-R.ttf") * 9, r40_0)
		seexports.sGui:setLabelAlignment(r9_25, "left", "center")
		seexports.sGui:setLabelText(r9_25, "Restream beállítások")
		seexports.sGui:setLabelFont(r9_25, "11/Ubuntu-R.ttf")
		local r10_25 = seexports.sGui:getFontHeight("11/Ubuntu-R.ttf")
		local r11_25 = seexports.sGui:createGuiElement("label", 170, r0_25, r41_0, 20 + r10_25 * 13, r40_0)
		seexports.sGui:setLabelAlignment(r11_25, "left", "center")
		seexports.sGui:setLabelText(r11_25, "Automatikus újrastreamelés")
		seexports.sGui:setLabelFont(r11_25, "11/Ubuntu-R.ttf")
		r47_0 = seexports.sGui:createGuiElement("checkbox", 180 + seexports.sGui:getLabelTextWidth(r11_25), 25 + r10_25 * 7, 300, "normal", r40_0)
		seexports.sGui:setCheckboxColor(r47_0, "sightmidgrey", "sightgrey2", "sightgreen", "sightmidgrey")
		local r12_25 = seexports.sGui:getFontHeight("11/Ubuntu-R.ttf")
		local r13_25 = seexports.sGui:createGuiElement("label", 170, r0_25, r41_0, 20 + r12_25 * 17, r40_0)
		seexports.sGui:setLabelAlignment(r13_25, "left", "center")
		seexports.sGui:setLabelText(r13_25, "Memóriakülönbség")
		seexports.sGui:setLabelFont(r13_25, "11/Ubuntu-R.ttf")
		r48_0 = seexports.sGui:createGuiElement("slider", r8_25, 28 + r12_25 * 9, r41_0 - r8_25 - 60, 20, r40_0)
		seexports.sGui:setSliderChangeEvent(r48_0, "refreshPerformanceWindowSlider")
		seexports.sGui:setClickArgument(r48_0, "restreamingMemoryDiff")
		r49_0 = seexports.sGui:createGuiElement("input", r8_25 + r41_0 - r8_25 - 60 + 5, 28 + r12_25 * 9, 50, 20, r40_0)
		seexports.sGui:setInputNumberOnly(r49_0, true)
		seexports.sGui:setInputFont(r49_0, "10/Ubuntu-R.ttf")
		seexports.sGui:setClickArgument(r49_0, "restreamingMemoryDiff")
		seexports.sGui:setInputChangeEvent(r49_0, "refreshPerformanceWindowInput")
		local r14_25 = seexports.sGui:getFontHeight("11/Ubuntu-R.ttf")
		local r15_25 = seexports.sGui:createGuiElement("label", 170, r0_25, r41_0, 20 + r14_25 * 21, r40_0)
		seexports.sGui:setLabelAlignment(r15_25, "left", "center")
		seexports.sGui:setLabelText(r15_25, "Időközönként")
		seexports.sGui:setLabelFont(r15_25, "11/Ubuntu-R.ttf")
		r50_0 = seexports.sGui:createGuiElement("checkbox", 180 + seexports.sGui:getLabelTextWidth(r15_25), 25 + r14_25 * 11, 300, "normal", r40_0)
		seexports.sGui:setCheckboxColor(r50_0, "sightmidgrey", "sightgrey2", "sightgreen", "sightmidgrey")
		local r16_25 = seexports.sGui:getFontHeight("11/Ubuntu-R.ttf")
		local r17_25 = seexports.sGui:createGuiElement("label", 170, r0_25, r41_0, 20 + r16_25 * 25, r40_0)
		seexports.sGui:setLabelAlignment(r17_25, "left", "center")
		seexports.sGui:setLabelText(r17_25, "X percenként")
		seexports.sGui:setLabelFont(r17_25, "11/Ubuntu-R.ttf")
		r51_0 = seexports.sGui:createGuiElement("slider", r8_25, 28 + r16_25 * 13, r41_0 - r8_25 - 60, 20, r40_0)
		seexports.sGui:setSliderChangeEvent(r51_0, "refreshPerformanceWindowSlider")
		seexports.sGui:setClickArgument(r51_0, "restreamMinutes")
		r52_0 = seexports.sGui:createGuiElement("input", r8_25 + r41_0 - r8_25 - 60 + 5, 28 + r16_25 * 13, 50, 20, r40_0)
		seexports.sGui:setInputNumberOnly(r52_0, true)
		seexports.sGui:setInputFont(r52_0, "10/Ubuntu-R.ttf")
		seexports.sGui:setClickArgument(r52_0, "restreamMinutes")
		seexports.sGui:setInputChangeEvent(r52_0, "refreshPerformanceWindowInput")
		local r18_25 = seexports.sGui:getFontHeight("11/Ubuntu-R.ttf")
		local r19_25 = seexports.sGui:createGuiElement("label", 170, r0_25, r41_0, 20 + r18_25 * 29, r40_0)
		seexports.sGui:setLabelAlignment(r19_25, "left", "center")
		seexports.sGui:setLabelText(r19_25, "Kényszerített memórafelszabadítás")
		seexports.sGui:setLabelFont(r19_25, "11/Ubuntu-R.ttf")
		r53_0 = seexports.sGui:createGuiElement("checkbox", 180 + seexports.sGui:getLabelTextWidth(r19_25), 25 + r18_25 * 15, 300, "normal", r40_0)
		seexports.sGui:setCheckboxColor(r53_0, "sightmidgrey", "sightgrey2", "sightgreen", "sightmidgrey")
		local r20_25 = seexports.sGui:getFontHeight("11/Ubuntu-R.ttf")
		local r21_25 = seexports.sGui:createGuiElement("label", 170, r0_25, r41_0, 20 + r20_25 * 33, r40_0)
		seexports.sGui:setLabelAlignment(r21_25, "left", "center")
		seexports.sGui:setLabelText(r21_25, "X percenként")
		seexports.sGui:setLabelFont(r21_25, "11/Ubuntu-R.ttf")
		r54_0 = seexports.sGui:createGuiElement("slider", r8_25, 28 + r20_25 * 17, r41_0 - r8_25 - 60, 20, r40_0)
		seexports.sGui:setSliderChangeEvent(r54_0, "refreshPerformanceWindowSlider")
		seexports.sGui:setClickArgument(r54_0, "forceReleaseMinutes")
		r55_0 = seexports.sGui:createGuiElement("input", r8_25 + r41_0 - r8_25 - 60 + 5, 28 + r20_25 * 17, 50, 20, r40_0)
		seexports.sGui:setInputNumberOnly(r55_0, true)
		seexports.sGui:setInputFont(r55_0, "10/Ubuntu-R.ttf")
		seexports.sGui:setClickArgument(r55_0, "forceReleaseMinutes")
		seexports.sGui:setInputChangeEvent(r55_0, "refreshPerformanceWindowInput")
		refreshPerformanceWindowAll()
		local r22_25 = r41_0 / 2 + 62.5 + 80
		local r23_25 = 20 + r20_25 * 21
		local r24_25 = seexports.sGui:createGuiElement("button", r22_25 - 125, r23_25 - 35, 25, 25, r40_0)
		seexports.sGui:setGuiBackground(r24_25, "solid", "sightgrey3")
		seexports.sGui:setGuiHover(r24_25, "gradient", {
			"sightred",
			"sightred-second"
		}, false, true)
		seexports.sGui:setButtonFont(r24_25, "14/BebasNeueBold.otf")
		seexports.sGui:setButtonIcon(r24_25, seexports.sGui:getFaIconFilename("bolt", 25))
		seexports.sGui:guiSetTooltip(r24_25, "Újrastreamelés azonnal")
		seexports.sGui:setClickEvent(r24_25, "forceRestreamManually")
		local r25_25 = seexports.sGui:createGuiElement("button", r22_25 - 95, r23_25 - 35, 25, 25, r40_0)
		seexports.sGui:setGuiBackground(r25_25, "solid", "sightgrey3")
		seexports.sGui:setGuiHover(r25_25, "gradient", {
			"sightred",
			"sightred-second"
		}, false, true)
		seexports.sGui:setButtonFont(r25_25, "14/BebasNeueBold.otf")
		seexports.sGui:setButtonIcon(r25_25, seexports.sGui:getFaIconFilename("sync", 25))
		seexports.sGui:guiSetTooltip(r25_25, "Alap visszaállítása")
		seexports.sGui:setClickEvent(r25_25, "restoreDefaultStreamingSettings")
		local r26_25 = seexports.sGui:createGuiElement("button", r22_25 - 65, r23_25 - 35, 25, 25, r40_0)
		seexports.sGui:setGuiBackground(r26_25, "solid", "sightgrey3")
		seexports.sGui:setGuiHover(r26_25, "gradient", {
			"sightred",
			"sightred-second"
		}, false, true)
		seexports.sGui:setButtonFont(r26_25, "14/BebasNeueBold.otf")
		seexports.sGui:setButtonIcon(r26_25, seexports.sGui:getFaIconFilename("trash", 25))
		seexports.sGui:guiSetTooltip(r26_25, "Módosítások elvetése")
		seexports.sGui:setClickEvent(r26_25, "restoreStreamingSettings")
		local r27_25 = seexports.sGui:createGuiElement("button", r22_25 - 35, r23_25 - 35, 25, 25, r40_0)
		seexports.sGui:setGuiBackground(r27_25, "solid", "sightgrey3")
		seexports.sGui:setGuiHover(r27_25, "gradient", {
			"sightgreen",
			"sightgreen-second"
		}, false, true)
		seexports.sGui:setButtonFont(r27_25, "14/BebasNeueBold.otf")
		seexports.sGui:setButtonIcon(r27_25, seexports.sGui:getFaIconFilename("save", 25))
		seexports.sGui:guiSetTooltip(r27_25, "Mentés")
		seexports.sGui:setClickEvent(r27_25, "saveStreamingSettings")
	elseif r31_0 == 2 then
		addEventHandler("onClientKey", getRootElement(), scrollHandler)
		local r3_25 = 160
		local r4_25 = r0_25
		for r8_25 = 1, 12, 1 do
			r58_0[r8_25] = {}
			r58_0[r8_25][1] = seexports.sGui:createGuiElement("label", r3_25 + 6 + 3, r4_25, 0, 30, r40_0)
			seexports.sGui:setLabelAlignment(r58_0[r8_25][1], "left", "center")
			seexports.sGui:setLabelFont(r58_0[r8_25][1], "14/BebasNeueRegular.otf")
			local r9_25 = seexports.sGui:createGuiElement("button", r41_0 - 24 - 2 - 6 - 2 - 80 - 2, r4_25 + 12 - 9, 100, 24, r40_0)
			seexports.sGui:setGuiBackground(r9_25, "solid", "sightred")
			seexports.sGui:setGuiHover(r9_25, "gradient", {
				"sightred",
				"sightred-second"
			}, false, true)
			seexports.sGui:setButtonFont(r9_25, "11/BebasNeueBold.otf")
			seexports.sGui:setButtonTextColor(r9_25, "#ffffff")
			seexports.sGui:setButtonText(r9_25, "Leállítás")
			seexports.sGui:setClickEvent(r9_25, "toggleResource")
			r58_0[r8_25][2] = r9_25
			r4_25 = r4_25 + 30
			if r8_25 < 12 then
				local r10_25 = seexports.sGui:createGuiElement("hr", r3_25 + 6, r4_25 - 1, r41_0 - 12 - r3_25 - 2 - 6, 2, r40_0)
			end
		end
		local r5_25 = seexports.sGui:createGuiElement("rectangle", r41_0 - 6 - 2, r0_25 + 6, 2, 350, r40_0)
		seexports.sGui:setGuiBackground(r5_25, "solid", "sightgrey3")
		r56_0 = seexports.sGui:createGuiElement("rectangle", 0, 0, 2, 350, r5_25)
		seexports.sGui:setGuiBackground(r56_0, "solid", "sightmidgrey")
		refreshResourceList()
	end
end
addEvent("closePerformanceWindow", false)
addEventHandler("closePerformanceWindow", getRootElement(), function()
	destroyPerformanceWindow()
end)
addEvent("refreshPerformanceWindowSlider", false)
addEventHandler("refreshPerformanceWindowSlider", getRootElement(), function(r0_27, r1_27, r2_27, r3_27, r4_27, r5_27)
	if seexports.sGui:getClickArgument(r0_27) == "minimumStreamingMemory" then
		seexports.sGui:setInputValue(r44_0, string.format("%.2f", convertSliderToRange(r1_27, r11_0, r12_0, 1)))
	elseif seexports.sGui:getClickArgument(r0_27) == "maximumStreamingMemory" then
		seexports.sGui:setInputValue(r46_0, string.format("%.2f", convertSliderToRange(r1_27, r11_0, r12_0, 1)))
	elseif seexports.sGui:getClickArgument(r0_27) == "restreamingMemoryDiff" then
		seexports.sGui:setInputValue(r49_0, string.format("%.2f", convertSliderToRange(r1_27, 1, 100, 1)))
	elseif seexports.sGui:getClickArgument(r0_27) == "restreamMinutes" then
		seexports.sGui:setInputValue(r52_0, string.format("%.2f", convertSliderToRange(r1_27, 15, 300, 1)))
	elseif seexports.sGui:getClickArgument(r0_27) == "forceReleaseMinutes" then
		seexports.sGui:setInputValue(r55_0, string.format("%.2f", convertSliderToRange(r1_27, 15, 300, 1)))
	end
end)
addEvent("refreshPerformanceWindowInput", false)
addEventHandler("refreshPerformanceWindowInput", getRootElement(), function(r0_28, r1_28, r2_28)
	r0_28 = tonumber(r0_28)
	if not r0_28 then
		return 
	end
	if seexports.sGui:getClickArgument(r1_28) == "minimumStreamingMemory" then
		seexports.sGui:setSliderValue(r43_0, convertRangeToSlider(r0_28, r11_0, r12_0))
	elseif seexports.sGui:getClickArgument(r1_28) == "maximumStreamingMemory" then
		seexports.sGui:setSliderValue(r45_0, convertRangeToSlider(r0_28, r11_0, r12_0))
	elseif seexports.sGui:getClickArgument(r1_28) == "restreamingMemoryDiff" then
		seexports.sGui:setSliderValue(r48_0, convertRangeToSlider(r0_28, 1, 100))
	elseif seexports.sGui:getClickArgument(r1_28) == "restreamMinutes" then
		seexports.sGui:setSliderValue(r51_0, convertRangeToSlider(r0_28, 15, 300))
	elseif seexports.sGui:getClickArgument(r1_28) == "forceReleaseMinutes" then
		seexports.sGui:setSliderValue(r54_0, convertRangeToSlider(r0_28, 15, 300))
	end
end)
addEvent("restoreDefaultStreamingSettings", false)
addEventHandler("restoreDefaultStreamingSettings", getRootElement(), function()
	seexports.sGui:showInfobox("i", "Visszaállítottad az alapértelmezett beállításokat.")
	r25_0 = processSettings(r10_0)
	refreshPerformanceWindowAll()
end)
addEvent("restoreStreamingSettings", false)
addEventHandler("restoreStreamingSettings", getRootElement(), function()
	seexports.sGui:showInfobox("i", "Elvetetted a módosításokat.")
	refreshPerformanceWindowAll()
end)
addEvent("saveStreamingSettings", false)
addEventHandler("saveStreamingSettings", getRootElement(), function()
	local r0_31 = convertSliderToRange(seexports.sGui:getSliderValue(r43_0), r11_0, r12_0, 1)
	local r1_31 = convertSliderToRange(seexports.sGui:getSliderValue(r45_0), r11_0, r12_0, 1)
	if r1_31 < r0_31 then
		seexports.sGui:showInfobox("e", "A minimum streaming memory nem lehet több, mint a maximum!")
		return 
	end
	if r1_31 < r0_31 then
		seexports.sGui:showInfobox("e", "A maximum streaming memory nem lehet kevesebb, mint a minimum!")
		return 
	end
	seexports.sGui:showInfobox("i", "Mentetted a beállításaidat.")
	r25_0 = {
		minmb = r0_31,
		maxmb = r1_31,
		enabled = seexports.sGui:isCheckboxChecked(r47_0),
		diffIs = convertSliderToRange(seexports.sGui:getSliderValue(r48_0), 1, 100, 1),
		onTimeEnabled = seexports.sGui:isCheckboxChecked(r50_0),
		onTime = convertSliderToRange(seexports.sGui:getSliderValue(r51_0), 15, 300, 1),
		forceFreeEnabled = seexports.sGui:isCheckboxChecked(r53_0),
		forceFree = convertSliderToRange(seexports.sGui:getSliderValue(r54_0), 15, 300, 1),
	}
	if fileExists("performance.sight") then
		fileDelete("performance.sight")
	end
	local r2_31 = fileCreate("performance.sight")
	if r2_31 then
		fileWrite(r2_31, toJSON({
			r25_0.minmb,
			r25_0.maxmb,
			r25_0.enabled,
			r25_0.diffIs,
			r25_0.onTimeEnabled,
			r25_0.onTime,
			r25_0.forceFreeEnabled,
			r25_0.forceFree
		}, true))
		fileClose(r2_31)
	end
end)
addEvent("forceRestreamManually", false)
addEventHandler("forceRestreamManually", getRootElement(), function()
	if isPedInVehicle(localPlayer) then
		seexports.sGui:showInfobox("e", "Járműben ülve nem lehetséges.")
		return 
	end
	local r0_32 = getTickCount()
	if r30_0 and r0_32 - r30_0 <= 60000 then
		seexports.sGui:showInfobox("e", "Csak percenként lehetséges.")
		return 
	end
	seexports.sGui:showInfobox("i", "Világ újratöltve.")
	engineRestreamWorld()
	r30_0 = r0_32
end)
addEvent("selectPerformanceWindowCategory", false)
addEventHandler("selectPerformanceWindowCategory", getRootElement(), function(r0_33, r1_33, r2_33, r3_33, r4_33)
	if r57_0[r4_33] then
		r31_0 = r57_0[r4_33]
		createPerformanceWindow()
	end
end)
addEvent("toggleResource", false)
addEventHandler("toggleResource", getRootElement(), function(r0_34, r1_34, r2_34, r3_34, r4_34, r5_34)
	if r35_0[r5_34] then
		r35_0[r5_34] = nil
		triggerServerEvent("requestToStartResource", resourceRoot, disableableResources[r5_34][2])
	else
		r35_0[r5_34] = true
		triggerServerEvent("requestToStopResource", resourceRoot, disableableResources[r5_34][2])
	end
	if fileExists("resourceStates.sight") then
		fileDelete("resourceStates.sight")
	end
	local r6_34 = fileCreate("resourceStates.sight")
	if r6_34 then
		fileWrite(r6_34, toJSON(r35_0, true))
		fileClose(r6_34)
	end
	refreshResourceList()
end)
addCommandHandler("performance", function()
	if getElementData(localPlayer, "loggedIn") then
		if r40_0 then
			destroyPerformanceWindow()
		else
			createPerformanceWindow()
		end
	end
end)
addEventHandler("onClientResourceStop", getResourceRootElement(), function()
	engineStreamingRestoreMemorySize()
	engineStreamingRestoreBufferSize()
end)