fileHashList = {}
fileProtectList = {
	["files/bank/v4_goldbank_int1.dff"] = "server",
	["files/bank/v4_goldbank_int2.dff"] = "server",
	["files/bank/v4_goldbank_int3.dff"] = "server",
	["files/bank/v4_goldbank_vault_door.dff"] = "server",
	["files/bank/v4_goldbank.dff"] = "server",
	["files/casino/admiral_bar.dff"] = "server",
	["files/casino/admiral_neons.dff"] = "server",
	["files/casino/blackjack_table1.dff"] = "server",
	["files/casino/blackjack_table2.dff"] = "server",
	["files/casino/blackjack_table3.dff"] = "server",
	["files/casino/fortunecup_base.dff"] = "server",
	["files/casino/fortunecup_horse1.dff"] = "server",
	["files/casino/fortunecup_horse2.dff"] = "server",
	["files/casino/fortunecup_horse3.dff"] = "server",
	["files/casino/fortunecup_horse4.dff"] = "server",
	["files/casino/fortunecup_horse5.dff"] = "server",
	["files/casino/fortunecup_horse6.dff"] = "server",
	["files/casino/int_admiral_casino.dff"] = "server",
	["files/casino/int_admiral_casino2.dff"] = "server",
	["files/casino/roulette_table.dff"] = "server",
	["files/casino/roulette_wheel.dff"] = "server",
	["files/casino/seedice.dff"] = "server",
	["files/city_hall/cityhall_court.dff"] = "server",
	["files/city_hall/cityhall_interior.dff"] = "server",
	["files/city_hall/cityhall_office1.dff"] = "server",
	["files/city_hall/cityhall_office2.dff"] = "server",
	["files/city_hall/cityhall_office3.dff"] = "server",
	["files/city_hall/cityhall_office4.dff"] = "server",
	["files/city_hall/LAcityhall1_LAn.dff"] = "server",
	["files/city_hall/PershingSq1_LAn.dff"] = "server",
	["files/city_hall/PershingSq2_LAn.dff"] = "server",
	--["files/city_hall/v4_statue.dff"] = "server", -- v4 Logó
	["files/farm/animalfarm.dff"] = "server",
	["files/farm/furik.dff"] = "server",
	["files/farm/kokacserje.dff"] = "server",
	["files/farm/magic_mushroom.dff"] = "server",
	["files/farm/mak.dff"] = "server",
	["files/farm/marihuana.dff"] = "server",
	["files/farm/v4_sheep_shearer.dff"] = "server",
	["files/farm/exterior_15.dff"] = "server",
	["files/farm/exterior_5.dff"] = "server",
	["files/farm/exterior_10.dff"] = "server",
	["files/garage/garage_furnitures_1.dff"] = "server",
	["files/garage/garage_furnitures_2.dff"] = "server",
	["files/garage/garage_int.dff"] = "server",
	["files/garage/garage_wall_1_1.dff"] = "server",
	["files/garage/garage_wall_1_2.dff"] = "server",
	["files/garage/garage_wall_2_1.dff"] = "server",
	["files/garage/garage_wall_2_2.dff"] = "server",
	["files/garage/v4_carlift_base.dff"] = "server",
	["files/garage/v4_carlift_runway.dff"] = "server",
	["files/garage/v4_workbench.dff"] = "server",
	["files/lv_map_expansion/CE_ground03.dff"] = "server",
	["files/lv_map_expansion/ce_groundpalo03.dff"] = "server",
	["files/lv_map_expansion/cunte_roads26.dff"] = "server",
	["files/lv_map_expansion/cunte_roads35.dff"] = "server",
	["files/lv_map_expansion/cunte_roads48.dff"] = "server",
	["files/makvirag/lastripx1_LAS.dff"] = "server",
	["files/makvirag/v4_int_makvirag.dff"] = "server",
	["files/makvirag/v4_tuningsorozo.dff"] = "server",
	["files/mall/models/int_seenema.dff"] = "server",
	["files/mall/models/mall_laW_LV.dff"] = "server",
	["files/mall/models/mall_laW.dff"] = "server",
	["files/mall/models/mall_neon1_LV.dff"] = "server",
	["files/mall/models/mall_neon1.dff"] = "server",
	["files/mall/models/mall_neon2_LV.dff"] = "server",
	["files/mall/models/mall_neon2.dff"] = "server",
	["files/mall/models/mall_parking.dff"] = "server",
	["files/mall/models/mall_rooms_247.dff"] = "server",
	["files/mall/models/mall_rooms_burger_props.dff"] = "server",
	["files/mall/models/mall_rooms_burger.dff"] = "server",
	["files/mall/models/mall_rooms_cinema.dff"] = "server",
	["files/mall/models/mall_rooms_cinema2.dff"] = "server",
	["files/mall/models/mall_rooms_cluckinBell_props.dff"] = "server",
	["files/mall/models/mall_rooms_cluckinBell.dff"] = "server",
	["files/mall/models/mall_rooms_coffee.dff"] = "server",
	["files/mall/models/mall_rooms_digital.dff"] = "server",
	["files/mall/models/mall_rooms_jewelry.dff"] = "server",
	["files/mall/models/mall_rooms_zip.dff"] = "server",
	["files/mall/models/mallb_laW_LV.dff"] = "server",
	["files/mall/models/mallb_laW.dff"] = "server",
	["files/mall/models/mallglass_laW_LV.dff"] = "server",
	["files/mall/models/mallglass_laW.dff"] = "server",
	["files/mall/models/v4_barrier_gate1.dff"] = "server",
	["files/mall/models/v4_barrier_gate2.dff"] = "server",
	["files/mall/models/v4_barrier_gate3.dff"] = "server",
	["files/mansions/CEgroundT204.dff"] = "server",
	["files/mansions/v3_phouse2.dff"] = "server",
	["files/map_fixes/LAcityped1_LAs.dff"] = "server",
	["files/map_fixes/vegasWedge31.dff"] = "server",
	["files/mechanic/cylinder_head.dff"] = "server",
	["files/mechanic/dyno_pad.dff"] = "server",
	["files/mechanic/dyno_rear.dff"] = "server",
	["files/mechanic/emelo_block.dff"] = "server",
	["files/mechanic/emelo_kar.dff"] = "server",
	["files/mechanic/engine_block.dff"] = "server",
	["files/mechanic/exhaust_manifold.dff"] = "server",
	["files/mechanic/half_shaft.dff"] = "server",
	["files/mechanic/impact_wrench.dff"] = "server",
	["files/mechanic/inspection_pad.dff"] = "server",
	["files/mechanic/intake_manifold.dff"] = "server",
	["files/mechanic/kruton.dff"] = "server",
	["files/mechanic/motoroil.dff"] = "server",
	["files/mechanic/oil_sump.dff"] = "server",
	["files/mechanic/pistons.dff"] = "server",
	["files/mechanic/supercharger.dff"] = "server",
	["files/mechanic/transmission.dff"] = "server",
	["files/mechanic/tuning_workshop_exterior.dff"] = "server",
	["files/mechanic/tuning_workshop_props.dff"] = "server",
	["files/mechanic/tuning_workshop_props2.dff"] = "server",
	["files/mechanic/tuning_workshop.dff"] = "server",
	["files/mechanic/turbo.dff"] = "server",
	["files/mechanic/v4_mechanic_hangar_furnitures.dff"] = "server",
	["files/mechanic/v4_mechanic_shed_furnitures.dff"] = "server",
	["files/mechanic/wheel_align_machine.dff"] = "server",
	["files/objects/container_ammo.dff"] = "server",
	["files/objects/container_blueprint.dff"] = "server",
	["files/objects/container_drug_parts.dff"] = "server",
	["files/objects/container_drug.dff"] = "server",
	["files/objects/container_weapon_parts.dff"] = "server",
	["files/objects/container_weapon.dff"] = "server",
	["files/objects/flex.dff"] = "server",
	["files/objects/metal_detector.dff"] = "server",
	["files/objects/v4_safe1.dff"] = "server",
	["files/objects/v4_safe2.dff"] = "server",
	["files/objects/v4_safe3.dff"] = "server",
	["files/objects/v4_strangers_clock.dff"] = "server",
	["files/objects/v4_strangers_portal.dff"] = "server",
	["files/objects/v4_treasure_chest1.dff"] = "server",
	["files/objects/v4_treasure_chest2.dff"] = "server",
	["files/paintshop/carshow_SFSe_props.dff"] = "server",
	["files/paintshop/carshow_SFSe_props2.dff"] = "server",
	["files/paintshop/spray_booth_drying.dff"] = "server",
	["files/paintshop/spray_booth.dff"] = "server",
	["files/paintshop/spray_gun_base.dff"] = "server",
	["files/paintshop/spray_gun.dff"] = "server",
	["files/paintshop/spray_hall_building_LS.dff"] = "server",
	["files/paintshop/spray_hall_building.dff"] = "server",
	["files/paintshop/spray_hall_building2.dff"] = "server",
	["files/paintshop/spray_hall_props.dff"] = "server",
	["files/paintshop/spray_hall.dff"] = "server",
	["files/paintshop/spray_interior.dff"] = "server",
	["files/paintshop/spray_mixer.dff"] = "server",
	["files/paintshop/spray_sander_shelf.dff"] = "server",
	["files/paintshop/spray_sander.dff"] = "server",
	["files/paintshop/urmaitalia_shop_props.dff"] = "server",
	["files/paintshop/urmaitalia_shop_props2.dff"] = "server",
	["files/paintshop/urmaitalia_shop.dff"] = "server",
	["files/paintshop/v4_redsandswest_industrial.dff"] = "server",
	["files/pawnshop/cos_liqinside.dff"] = "server",
	["files/pawnshop/cos_liqinsidebits.dff"] = "server",
	["files/pawnshop/cunte_roads06.dff"] = "server",
	["files/petrol_station/v4_soil_pump.dff"] = "server",
	["files/petrol_station/v4_soil_sign.dff"] = "server",
	["files/petrol_station/v4_soil_station_mid.dff"] = "server",
	["files/petrol_station/v4_soil_station.dff"] = "server",
	["files/petrol_station/v4_soil_store_prods.dff"] = "server",
	["files/petrol_station/v4_soil_store.dff"] = "server",
	["files/seeburger/lae711block01.dff"] = "server",
	["files/seeburger/v4_int_seeburger_props.dff"] = "server",
	["files/seeburger/v4_int_seeburger.dff"] = "server",
	["files/seeburger/v4_seeburger.dff"] = "server",
	["files/SeeRing/roadsSFSE02.dff"] = "server",
	["files/SeeRing/SeeRing_01.dff"] = "server",
	["files/SeeRing/SeeRing_02.dff"] = "server",
	["files/SeeRing/SeeRing_03.dff"] = "server",
	["files/SeeRing/SeeRing_04.dff"] = "server",
	["files/SeeRing/SeeRing_05.dff"] = "server",
	["files/SeeRing/SeeRing_06.dff"] = "server",
	["files/SeeRing/SeeRing_07.dff"] = "server",
	["files/SeeRing/SeeRing_07_LV.dff"] = "server",
	["files/SeeRing/SeeRing_08.dff"] = "server",
	["files/SeeRing/SeeRing_bleacher.dff"] = "server",
	["files/SeeRing/SeeRing_bleacher2.dff"] = "server",
	["files/SeeRing/SeeRing_carpark.dff"] = "server",
	["files/SeeRing/SeeRing_overpass.dff"] = "server",
	["files/SeeRing/SeeRing_PitFurnitures.dff"] = "server",
	["files/urmatrans/sight_urmatrans_cart.dff"] = "server",
	["files/urmatrans/sight_urmatrans_cart2.dff"] = "server",
	["files/urmatrans/sight_urmatrans_warehouse_props.dff"] = "server",
	["files/urmatrans/sight_urmatrans_warehouse.dff"] = "server",
	["files/v4_map_expansion/nw_bit_10.dff"] = "server",
	["files/v4_map_expansion/nw_bit_16.dff"] = "server",
	["files/v4_map_expansion/nw_bit_21.dff"] = "server",
	["files/v4_map_expansion/sw_bit_06.dff"] = "server",
	["files/v4_map_expansion/sw_bit_09.dff"] = "server",
	["files/weapons/addon/ak-74.dff"] = "server",
	["files/weapons/addon/ar-15_aimpoint.dff"] = "server",
	["files/weapons/addon/ar-15_holo.dff"] = "server",
	["files/weapons/addon/ar-15.dff"] = "server",
	["files/weapons/addon/benelli_m4.dff"] = "server",
	["files/weapons/addon/colt_1911.dff"] = "server",
	["files/weapons/addon/glock-19_laser.dff"] = "server",
	["files/weapons/addon/glock-19.dff"] = "server",
	["files/weapons/addon/hk_usp45.dff"] = "server",
	["files/weapons/addon/m4a1_sopmod.dff"] = "server",
	["files/weapons/addon/m4a1.dff"] = "server",
	["files/weapons/addon/m110.dff"] = "server",
	["files/weapons/addon/micro_draco.dff"] = "server",
	["files/weapons/addon/mosin_nagant.dff"] = "server",
	["files/weapons/addon/mp7a1_aimpoint.dff"] = "server",
	["files/weapons/addon/mp7a1.dff"] = "server",
	["files/weapons/addon/sw_model66.dff"] = "server",
	["files/urmatrans/sight_urmatrans_cargo_almapapr.dff"] = "server",
	["files/urmatrans/sight_urmatrans_cargo_onion.dff"] = "server",
	["files/wheels/wheel_sr1.dff"] = "server",
	["files/urmatrans/sight_urmatrans_cargo_waterm.dff"] = "server",
	["files/urmatrans/sight_urmatrans_cargo_pepsi.dff"] = "server",
	["files/urmatrans/sight_urmatrans_cargo_fanta.dff"] = "server",
	["files/urmatrans/sight_urmatrans_cargo_karalabe.dff"] = "server",
	["files/urmatrans/sight_urmatrans_cargo_salad.dff"] = "server",
	["files/urmatrans/sight_urmatrans_cargo_tokaji.dff"] = "server",
	["files/urmatrans/sight_urmatrans_cargo_hell.dff"] = "server",
	["files/urmatrans/sight_urmatrans_cargo_chili.dff"] = "server",
	["files/urmatrans/sight_urmatrans_cargo_parsley.dff"] = "server",
	["files/urmatrans/sight_urmatrans_cargo_kobanyai.dff"] = "server",
	["files/urmatrans/sight_urmatrans_cargo_szkiralyi3.dff"] = "server",
	["files/urmatrans/sight_urmatrans_cargo_szkiralyi2.dff"] = "server",
	["files/urmatrans/sight_urmatrans_cargo_repa.dff"] = "server",
	["files/urmatrans/sight_urmatrans_cargo_soproni2.dff"] = "server",
	["files/urmatrans/sight_urmatrans_cargo_sutotok.dff"] = "server",
	["files/urmatrans/sight_urmatrans_cargo_cucum.dff"] = "server",
	["files/urmatrans/sight_urmatrans_cargo_soproni.dff"] = "server",
	["files/urmatrans/sight_urmatrans_cargo_sargadinnye.dff"] = "server",
	["files/urmatrans/sight_urmatrans_cargo_tvpapr.dff"] = "server",
	["files/urmatrans/sight_urmatrans_cargo_szkiralyi1.dff"] = "server",
	["files/urmatrans/sight_urmatrans_cargo_cocacola.dff"] = "server",
	["files/urmatrans/sight_urmatrans_cargo_redbull.dff"] = "server",
	["files/urmatrans/sight_urmatrans_cargo_radish.dff"] = "server",
	["files/urmatrans/sight_urmatrans_cargo_pumpkin.dff"] = "server",
	["files/urmatrans/sight_urmatrans_cargo_nber.dff"] = "server",
	["files/urmatrans/sight_urmatrans_cargo_cabbage.dff"] = "server",
	["files/urmatrans/sight_urmatrans_cargo_pepsi2.dff"] = "server",
	["files/urmatrans/sight_urmatrans_cargo_onion2.dff"] = "server",
	["files/urmatrans/sight_urmatrans_cargo_somersby.dff"] = "server",
	["files/city_hall/vegascollege_lvS.dff"] = "server",
	["files/garage/v4_hangar_int.dff"] = "server",
	["files/group_models/police_shield.dff"] = "server",
	["files/fishing/v4_fishing_rod.dff"] = "server",
	["files/fishing/v4_fishing_chest.dff"] = "server",
	["files/fishing/v4_fishing_chest_top.dff"] = "server",
	["files/fishing/v4_fishing_chest_catch.dff"] = "server",
	["files/fishing/des_baitshop.dff"] = "server",
	["files/fishing/des_baitshop_props.dff"] = "server",
	["files/fishing/fishes/v4_fish_greatwhite_leg.dff"] = "server",
	["files/fishing/fishes/v4_fish_greatwhite.dff"] = "server",
	["files/fishing/fishes/v4_fish_hardheadcatfish.dff"] = "server",
	["files/fishing/fishes/v4_fish_mackerel.dff"] = "server",
	["files/fishing/fishes/v4_fish_mahi_leg.dff"] = "server",
	["files/fishing/fishes/v4_fish_mahi.dff"] = "server",
	["files/fishing/fishes/v4_fish_makoshark.dff"] = "server",
	["files/fishing/fishes/v4_fish_pinksalmon.dff"] = "server",
	["files/fishing/fishes/v4_fish_redsalmon.dff"] = "server",
	["files/fishing/fishes/v4_fish_rooster_leg.dff"] = "server",
	["files/fishing/fishes/v4_fish_rooster.dff"] = "server",
	["files/fishing/fishes/v4_fish_snapper_leg.dff"] = "server",
	["files/fishing/fishes/v4_fish_snapper.dff"] = "server",
	["files/fishing/fishes/v4_fish_swordfish.dff"] = "server",
	["files/fishing/fishes/v4_fish_tigershark.dff"] = "server",
	["files/fishing/fishes/v4_fish_tunabluefin.dff"] = "server",
	["files/fishing/fishes/v4_fish_tunayellowfin.dff"] = "server",
	["files/fishing/fishes/v4_fish_yellowtailsnapper.dff"] = "server",
	["files/halloween/halloween_ghost.dff"] = "server",
	["files/halloween/v4_protongun.dff"] = "server",
	["files/halloween/v4_protonpack.dff"] = "server",
	["files/mall/models/v4_airsoftshop_int.dff"] = "server",
	["files/mall/models/v4_airsoftshop_int_props.dff"] = "server",
	["files/winter/v4_snowman1.dff"] = "server",
	["files/winter/v4_snowman2.dff"] = "server",
	["files/winter/sfn_coast01.dff"] = "server",
	["files/objects/billiard_table.dff"] = "server",
	["files/winter/v4_karifa.dff"] = "server",
	["files/winter/v4_santabag2.dff"] = "server",
	["files/winter/v4_santabag.dff"] = "server",
	["files/winter/sfn_coast06.dff"] = "server",
	["files/mechanic/cs_landbit_01.dff"] = "server",
	["files/mechanic/bms/sanpdmdock1_las2.dff"] = "server",
	["files/objects/v4_cashregister_drawer.dff"] = "server",
	["files/objects/v4_cashregister.dff"] = "server",
	["files/mining/v4_mine_tunnel1.dff"] = "server",
	["files/mining/v4_mine_tunnel1_columnless.dff"] = "server",
	["files/mining/v4_mine_tunnel2.dff"] = "server",
	["files/mining/v4_mine_tunnel2_columnless.dff"] = "server",
	["files/mining/v4_mine_tunnel3.dff"] = "server",
	["files/mining/v4_mine_tunnel3_columnless.dff"] = "server",
	["files/mining/v4_mine_tunnel4.dff"] = "server",
	["files/mining/v4_mine_tunnel4_columnless.dff"] = "server",
	["files/mining/v4_mine_tunnel5.dff"] = "server",
	["files/mining/v4_mine_tunnel5_columnless.dff"] = "server",
	["files/mining/v4_mine_tunnel_left1.dff"] = "server",
	["files/mining/v4_mine_tunnel_left2.dff"] = "server",
	["files/mining/v4_mine_tunnel_left3.dff"] = "server",
	["files/mining/v4_mine_tunnel_left4.dff"] = "server",
	["files/mining/v4_mine_tunnel_left5.dff"] = "server",
	["files/mining/v4_mine_tunnel_crossing1.dff"] = "server",
	["files/mining/v4_mine_tunnel_crossing2.dff"] = "server",
	["files/mining/v4_mine_tunnel_crossing3.dff"] = "server",
	["files/mining/v4_mine_tunnel_crossing4.dff"] = "server",
	["files/mining/v4_mine_tunnel_crossing5.dff"] = "server",
	["files/mining/v4_mine_rail.dff"] = "server",
	["files/mining/v4_mine_rail_end.dff"] = "server",
	["files/mining/v4_mine_rail_left.dff"] = "server",
	["files/mining/v4_mine_rail_3way.dff"] = "server",
	["files/mining/v4_mine_rail_crossing.dff"] = "server",
	["files/mining/v4_mine_hq.dff"] = "server",
	--["files/mining/v4_mine_lamp.dff"] = "server",
	["files/mining/v4_mine_machine.dff"] = "server",
	["files/mining/v4_mine_machine2.dff"] = "server",
	["files/mining/v4_mine_machine_crusher.dff"] = "server",
	["files/mining/v4_mine_silo.dff"] = "server",
	["files/mining/v4_mine_cart1.dff"] = "server",
	["files/mining/v4_mine_cart1_wheels.dff"] = "server",
	["files/mining/v4_mine_cart1_turtle.dff"] = "server",
	["files/mining/v4_mine_urmamoto.dff"] = "server",
	["files/mining/v4_mine_ore1.dff"] = "server",
	["files/mining/v4_mine_ore2.dff"] = "server",
	["files/mining/v4_mine_ore3.dff"] = "server",
	["files/mining/v4_mine_ore4.dff"] = "server",
	["files/mining/v4_mine_ore5.dff"] = "server",
	["files/mining/v4_mine_wall.dff"] = "server",
	["files/mining/v4_mining_hardhat.dff"] = "server",
	["files/mining/v4_mine_ore_debris.dff"] = "server",
	["files/mining/v4_mine_ore_debris2.dff"] = "server",
	["files/mining/v4_mine_box.dff"] = "server",
	["files/mining/v4_mine_box_content.dff"] = "server",
	["files/mining/v4_mine_furnace.dff"] = "server",
	["files/mining/v4_mine_ingot.dff"] = "server",
	["files/mining/v4_mine_flow.dff"] = "server",
	--["files/mining/v4_mine_lobby.dff"] = "server",
	--["files/mining/v4_mine_lobby_alpha.dff"] = "server",
	["files/mining/v4_mine_tank.dff"] = "server",
	["files/mining/v4_mine_cargo_rail.dff"] = "server",
	["files/mining/v4_mine_cargo_wood.dff"] = "server",
	["files/mining/v4_mine_jerrycan.dff"] = "server",
	["files/mining/v4_mine_table0.dff"] = "server",
	["files/mining/v4_mine_table1.dff"] = "server",
	["files/mining/v4_mine_table2.dff"] = "server",
	["files/mining/v4_mine_table3.dff"] = "server",
	["files/mining/v4_mine_table4.dff"] = "server",
	["files/mining/v4_mine_table5.dff"] = "server",
	["files/mining/v4_mine_tablet.dff"] = "server",
	["files/mining/v4_mine_dynamite.dff"] = "server",
	["files/mining/v4_mine_cargo_lamp.dff"] = "server",
	["files/mining/v4_mine_cargo_cart1.dff"] = "server",
	["files/mining/v4_mine_cargo_urmamoto.dff"] = "server",
	["files/mining/mining_comp/land_SFN17.dff"] = "server",
	["files/mining/mining_comp/land_sfn21.dff"] = "server",
	["files/mining/mining_comp/SFN_PRESHEDGE1.dff"] = "server",
	["files/mining/mining_comp/SFN_wall_cm01.dff"] = "server",
	["files/mining/mining_comp/track01_SFN.dff"] = "server",
	["files/mining/mining_comp/track01_SFN_alpha.dff"] = "server",
	["files/mining/mining_comp/track01_SFN_props.dff"] = "server",
	["files/mining/mining_comp/track01_SFN_props2.dff"] = "server",
	["files/mining/mining_comp/track01_SFN_props3.dff"] = "server",
	["files/mining/mining_comp/v4_miningshop.dff"] = "server",
	["files/mining/mining_comp/v4_miningshop_LOD.dff"] = "server",
	["files/mining/mining_comp/v4_miningshop_props.dff"] = "server",
	["files/mining/mining_comp/v4_miningshop_window.dff"] = "server",
	["files/mining/mining_comp/v4_miningshop_sign.dff"] = "server",
	["files/mining/mining_comp/v4_miningshop_door.dff"] = "server",
	["files/mining/mining_comp/lod_land_SFN17.dff"] = "server",
	["files/mining/mining_comp/lod_wall_cm01.dff"] = "server",
	["files/mining/mining_comp/lodck01_sfn.dff"] = "server",
	["files/mining/mining_comp/LODd_sfn21.dff"] = "server",
	["files/mining/v4_mine_entrance5.dff"] = "server",
	["files/mining/v4_mine_entrance1.dff"] = "server",
	["files/mining/nw_lodbit_24.dff"] = "server",
	["files/mining/nw_bit_24.dff"] = "server",
	["files/mining/v4_mine_entrance4.dff"] = "server",
	["files/mining/v4_mine_entrance2.dff"] = "server",
	["files/mining/nw_lodbit_20.dff"] = "server",
	["files/mining/nw_lodbit_15.dff"] = "server",
	["files/mining/nw_bit_15.dff"] = "server",
	["files/mining/nw_bit_20.dff"] = "server",
	["files/mining/v4_mine_entrance6.dff"] = "server",
	["files/mining/v4_mine_entrance3.dff"] = "server",
	["files/group_models/v4_stretcher.dff"] = "server",
	["files/group_models/v4_fire_watertank.dff"] = "server",
	["files/group_models/v4_fire_nozzle.dff"] = "server",
	["files/group_models/v4_fire_waterhose.dff"] = "server",
	["files/group_models/v4_fire_hose_balljoint.dff"] = "server",
	["files/objects/v4_plugsee_charger.dff"] = "server",
	["files/objects/v4_plugsee_wallcharger.dff"] = "server",
	------ Innen írkáltam
	--church 
	["files/church/v4_church.dff"] = "server",
	["files/church/v4_church_alpha.dff"] = "server",
	["files/church/v4_church_lights.dff"] = "server",
	["files/church/v4_church_props.dff"] = "server",
	--ammo_craft
	["files/ammo_craft/v4_bulletpress.dff"] = "server",
	["files/ammo_craft/v4_presser.dff"] = "server",
	["files/ammo_craft/v4_sheetpress.dff"] = "server",
	--objects
	["files/objects/v4_vacation_chest.dff"] = "server",
	["files/objects/v4_vacation_chest_top.dff"] = "server",
	--weapons
	["files/weapons/mp5lng.dff"] = "server",
	["files/weapons/sniper.dff"] = "server",
}

modelList = {
	["v4_snowman1"] = {
		type = "object",
		model = "object",
		dff = "files/winter/v4_snowman1.dff",
		col = "files/winter/v4_snowman1.col",
		txd = "files/winter/v4_winter.txd",
		lodDistance = 75
	},
	["v4_snowman2"] = {
		type = "object",
		model = "object",
		dff = "files/winter/v4_snowman2.dff",
		col = "files/winter/v4_snowman2.col",
		txd = "files/winter/v4_winter.txd",
		lodDistance = 75
	},
	["v4_santabag"] = {
		type = "object",
		model = "object",
		dff = "files/winter/v4_santabag.dff",
		col = "files/winter/v4_santabag.col",
		txd = "files/winter/v4_winter.txd",
		lodDistance = 100
	},
	["v4_santabag2"] = {
		type = "object",
		model = "object",
		dff = "files/winter/v4_santabag2.dff",
		col = "files/winter/v4_santabag2.col",
		txd = "files/winter/v4_winter.txd"
	},
	["v4_xmas_sparkler"] = {
		type = "object",
		model = "object",
		dff = "files/winter/v4_xmas_sparkler.dff",
		txd = "files/winter/v4_winter.txd"
	},
	["v4_karifa"] = {
		type = "object",
		model = "object",
		dff = "files/winter/v4_karifa.dff",
		col = "files/winter/v4_karifa.col",
		txd = "files/winter/v4_karifa.txd",
		transparent = true
	},
	["v4_bayside_ice"] = {
		type = "object",
		model = "object",
		dff = "files/winter/v4_bayside_ice.dff",
		col = "files/winter/v4_bayside_ice.col",
		txd = "files/winter/v4_winter.txd",
		lodDistance = 300
	},
	["v4_bayside_ice_snowalpha"] = {
		type = "object",
		model = "object",
		dff = "files/winter/v4_bayside_ice_snowalpha.dff",
		col = "files/winter/v4_bayside_ice_snowalpha.col",
		txd = "files/v4_alpha_textures.txd",
		transparent = true,
		flags = {
			"no_zbuffer_write"
		},
		lodDistance = 250
	},
	["v4_iceskate"] = {
		type = "object",
		model = "object",
		dff = "files/winter/v4_iceskate.dff",
		txd = "files/winter/v4_winter.txd"
	},
	["sfn_coast01"] = {
		type = "object",
		model = 9230,
		dff = "files/winter/sfn_coast01.dff",
		col = "files/winter/sfn_coast01.col",
		txd = "files/winter/sfn_coast.txd"
	},
	["LOD_coast69_sfn"] = {
		type = "object",
		model = 9366,
		dff = "files/winter/LOD_coast69_sfn.dff",
		txd = "files/winter/sfn_coast.txd"
	},
	["sfn_coast06"] = {
		type = "object",
		model = 9329,
		dff = "files/winter/sfn_coast06.dff",
		col = "files/winter/sfn_coast06.col",
		txd = "files/winter/sfn_coast.txd"
	},
	["LOD_coast06_sfn"] = {
		type = "object",
		model = 9367,
		dff = "files/winter/LOD_coast06_sfn.dff",
		txd = "files/winter/sfn_coast.txd"
	},
	["LAcityhall1_LAn"] = {
		type = "object",
		model = 3980,
		dff = "files/city_hall/LAcityhall1_LAn.dff",
		col = "files/city_hall/lacityhall1_lan.col",
		txd = "files/city_hall/cityhall_lan.txd"
	},
	["LAcityhall2_LAn"] = {
		type = "object",
		model = 4002,
		dff = "files/city_hall/LAcityhall2_LAn.dff",
		txd = "files/city_hall/cityhall_lan.txd"
	},
	["cityhallblok_LAn"] = {
		type = "object",
		model = 3997,
		dff = "files/city_hall/cityhallblok_LAn.dff",
		col = "files/city_hall/cityhallblok_LAn.col",
		txd = "files/city_hall/cityhall_lan.txd"
	},
	["cityhall_alpha"] = {
		type = "object",
		model = "object",
		dff = "files/city_hall/cityhall_alpha.dff",
		col = "files/city_hall/cityhall_alpha.col",
		txd = "files/city_hall/cityhall_alpha.txd",
		transparent = true,
		lodDistance = 140
	},
	["Roads24_LAn"] = {
		type = "object",
		model = 4163,
		dff = "files/city_hall/Roads24_LAn.dff",
		col = "files/city_hall/Roads24_LAn.col",
		txd = "files/city_hall/Roads24_LAn.txd"
	},
	["cityhall_door1"] = {
		type = "object",
		model = "object",
		dff = "files/city_hall/cityhall_door1.dff",
		col = "files/city_hall/cityhall_door1.col",
		txd = "files/city_hall/cityhall_alpha.txd",
		transparent = true,
		lodDistance = 140,
		dynamicDoor = true
	},
	["cityhall_door2"] = {
		type = "object",
		model = "object",
		dff = "files/city_hall/cityhall_door2.dff",
		txd = "files/city_hall/cityhall_offices.txd",
		col = "files/city_hall/cityhall_door2.col",
		dynamicDoor = true
	},
	["cityhall_interior"] = {
		type = "object",
		model = "object",
		dff = "files/city_hall/cityhall_interior.dff",
		col = "files/city_hall/cityhall_interior.col",
		txd = "files/city_hall/cityhall_interior.txd"
	},
	["cityhall_interior_LOD"] = {
		type = "object",
		model = "object",
		dff = "files/city_hall/cityhall_interior_LOD.dff",
		txd = "files/city_hall/cityhall_interior.txd"
	},
	["cityhall_interior2"] = {
		type = "object",
		model = "object",
		dff = "files/city_hall/cityhall_interior2.dff",
		col = "files/city_hall/cityhall_interior2.col",
		txd = "files/city_hall/cityhall_interior.txd"
	},
	["cityhall_interior_alpha"] = {
		type = "object",
		model = "object",
		dff = "files/city_hall/cityhall_interior_alpha.dff",
		col = "files/city_hall/cityhall_interior_alpha.col",
		txd = "files/city_hall/cityhall_alpha.txd",
		transparent = true
	},
	["cityhall_railing"] = {
		type = "object",
		model = "object",
		dff = "files/city_hall/cityhall_railing.dff",
		col = "files/city_hall/cityhall_railing.col",
		txd = "files/city_hall/cityhall_interior.txd"
	},
	["cityhall_railing2"] = {
		type = "object",
		model = "object",
		dff = "files/city_hall/cityhall_railing2.dff",
		col = "files/city_hall/cityhall_railing2.col",
		txd = "files/city_hall/cityhall_interior.txd"
	},
	["cityhall_office1"] = {
		type = "object",
		model = "object",
		dff = "files/city_hall/cityhall_office1.dff",
		col = "files/city_hall/cityhall_office1.col",
		txd = "files/city_hall/cityhall_offices.txd"
	},
	["cityhall_office2"] = {
		type = "object",
		model = "object",
		dff = "files/city_hall/cityhall_office2.dff",
		col = "files/city_hall/cityhall_office2.col",
		txd = "files/city_hall/cityhall_offices.txd"
	},
	["cityhall_office3"] = {
		type = "object",
		model = "object",
		dff = "files/city_hall/cityhall_office3.dff",
		col = "files/city_hall/cityhall_office3.col",
		txd = "files/city_hall/cityhall_offices.txd"
	},
	["cityhall_office4"] = {
		type = "object",
		model = "object",
		dff = "files/city_hall/cityhall_office4.dff",
		col = "files/city_hall/cityhall_office4.col",
		txd = "files/city_hall/cityhall_offices.txd"
	},
	["cityhall_library"] = {
		type = "object",
		model = "object",
		dff = "files/city_hall/cityhall_library.dff",
		col = "files/city_hall/cityhall_library.col",
		txd = "files/city_hall/cityhall_offices.txd"
	},
	["gold_chandelier"] = {
		type = "object",
		model = "object",
		dff = "files/city_hall/gold_chandelier.dff",
		col = "files/city_hall/gold_chandelier.col",
		txd = "files/city_hall/cityhall_offices.txd"
	},
	["cityhall_chandelier"] = {
		type = "object",
		model = "object",
		dff = "files/city_hall/cityhall_chandelier.dff",
		col = "files/city_hall/cityhall_chandelier.col",
		txd = "files/city_hall/cityhall_offices.txd"
	},
	["cityhall_chandelier1"] = {
		type = "object",
		model = "object",
		dff = "files/city_hall/cityhall_chandelier1.dff",
		col = "files/city_hall/cityhall_chandelier1.col",
		txd = "files/city_hall/cityhall_offices.txd"
	},
	["cityhall_chandelier2"] = {
		type = "object",
		model = "object",
		dff = "files/city_hall/cityhall_chandelier2.dff",
		col = "files/city_hall/cityhall_chandelier2.col",
		txd = "files/city_hall/cityhall_offices.txd"
	},
	["cityhall_chandelier3"] = {
		type = "object",
		model = "object",
		dff = "files/city_hall/cityhall_chandelier3.dff",
		col = "files/city_hall/cityhall_chandelier3.col",
		txd = "files/city_hall/cityhall_offices.txd"
	},
	["cityhall_server_room"] = {
		type = "object",
		model = "object",
		dff = "files/city_hall/cityhall_server_room.dff",
		col = "files/city_hall/cityhall_server_room.col",
		txd = "files/city_hall/cityhall_offices.txd"
	},
	["cityhall_passport_office"] = {
		type = "object",
		model = "object",
		dff = "files/city_hall/cityhall_passport_office.dff",
		col = "files/city_hall/cityhall_passport_office.col",
		txd = "files/city_hall/cityhall_offices.txd"
	},
	["cityhall_photo_booth"] = {
		type = "object",
		model = "object",
		dff = "files/city_hall/cityhall_photo_booth.dff",
		col = "files/city_hall/cityhall_photo_booth.col",
		txd = "files/city_hall/cityhall_offices.txd"
	},
	["cityhall_employment_center"] = {
		type = "object",
		model = "object",
		dff = "files/city_hall/cityhall_employment_center.dff",
		col = "files/city_hall/cityhall_employment_center.col",
		txd = "files/city_hall/cityhall_offices.txd"
	},
	["cityhall_court"] = {
		type = "object",
		model = "object",
		dff = "files/city_hall/cityhall_court.dff",
		col = "files/city_hall/cityhall_court.col",
		txd = "files/city_hall/cityhall_offices.txd"
	},
	["cityhall_ceremonial"] = {
		type = "object",
		model = "object",
		dff = "files/city_hall/cityhall_ceremonial.dff",
		col = "files/city_hall/cityhall_ceremonial.col",
		txd = "files/city_hall/cityhall_offices.txd"
	},
	["cityhall_ceremonial_chairs"] = {
		type = "object",
		model = "object",
		dff = "files/city_hall/cityhall_ceremonial_chairs.dff",
		col = "files/city_hall/cityhall_ceremonial_chairs.col",
		txd = "files/city_hall/cityhall_offices.txd"
	},
	["PershingSq1_LAn"] = {
		type = "object",
		model = 3985,
		dff = "files/city_hall/PershingSq1_LAn.dff",
		col = "files/city_hall/PershingSq1_LAn.col",
		txd = "files/city_hall/PershingSq.txd"
	},
	["PershingSq2_LAn"] = {
		type = "object",
		model = 4186,
		dff = "files/city_hall/PershingSq2_LAn.dff",
		col = "files/city_hall/PershingSq2_LAn.col",
		txd = "files/city_hall/PershingSq.txd"
	},
	["PershingSq1_LAn_LOD"] = {
		type = "object",
		model = 4210,
		dff = "files/city_hall/PershingSq1_LAn_LOD.dff",
		txd = "files/city_hall/PershingSq.txd"
	},
	["PershingSq2_LAn_LOD"] = {
		type = "object",
		model = 4057,
		dff = "files/city_hall/PershingSq2_LAn_LOD.dff",
		txd = "files/city_hall/PershingSq.txd"
	},
	["PershingPool_LAn"] = {
		type = "object",
		model = 4206,
		dff = "files/city_hall/PershingPool_LAn.dff",
		txd = "files/city_hall/PershingSq.txd",
		transparent = true,
		lodDistance = 140
	},
	["PershingSq_alpha"] = {
		type = "object",
		model = "object",
		dff = "files/city_hall/PershingSq_alpha.dff",
		col = "files/city_hall/PershingSq_alpha.col",
		txd = "files/city_hall/PershingSq.txd",
		transparent = true,
		lodDistance = 140
	},
	["v4_statue"] = {
		type = "object",
		model = "object",
		dff = "files/city_hall/v4_statue.dff",
		col = "files/city_hall/v4_statue.col",
		txd = "files/city_hall/PershingSq.txd",
		lodDistance = 150
	},
	["v4_barrier_gate1"] = {
		type = "object",
		model = "object",
		dff = "files/mall/models/v4_barrier_gate1.dff",
		txd = "files/mall/textures/v4_barrier_gate.txd",
		col = "files/mall/collisions/v4_barrier_gate1.col"
	},
	["v4_barrier_gate2"] = {
		type = "object",
		model = "object",
		dff = "files/mall/models/v4_barrier_gate2.dff",
		txd = "files/mall/textures/v4_barrier_gate.txd",
		col = "files/mall/collisions/v4_barrier_gate2.col"
	},
	["v4_barrier_gate3"] = {
		type = "object",
		model = "object",
		dff = "files/mall/models/v4_barrier_gate3.dff",
		txd = "files/mall/textures/v4_barrier_gate.txd",
		col = "files/mall/collisions/v4_barrier_gate3.col"
	},
	["road_lawn04"] = {
		type = "object",
		model = 5995,
		dff = "files/mall/models/road_lawn04.dff",
		txd = "files/mall/textures/v4_mall.txd",
		col = "files/mall/collisions/road_lawn04.col"
	},
	["mall_laW"] = {
		type = "object",
		model = 6048,
		dff = "files/mall/models/mall_laW.dff",
		txd = "files/mall/textures/v4_mall.txd",
		col = "files/mall/collisions/mall_laW.col"
	},
	["LODmall_law"] = {
		type = "object",
		model = 6131,
		dff = "files/mall/models/LODmall_law.dff",
		txd = "files/mall/textures/v4_mall_lod.txd",
		lodDistance = 10000
	},
	["mallb_laW"] = {
		type = "object",
		model = 6130,
		dff = "files/mall/models/mallb_laW.dff",
		txd = "files/mall/textures/v4_mall.txd",
		col = "files/mall/collisions/mallb_laW.col"
	},
	["LODmallb_laW"] = {
		type = "object",
		model = 6255,
		dff = "files/mall/models/LODmallb_laW.dff",
		txd = "files/mall/textures/v4_mall_lod.txd",
		lodDistance = 10000
	},
	["mall_parking"] = {
		type = "object",
		model = "object",
		dff = "files/mall/models/mall_parking.dff",
		txd = "files/mall/textures/v4_mall.txd",
		col = "files/mall/collisions/mall_parking.col",
		lodDistance = 200
	},
	["mall_parking_alpha"] = {
		type = "object",
		model = "object",
		dff = "files/mall/models/mall_parking_alpha.dff",
		txd = "files/v4_alpha_textures.txd",
		col = "files/mall/collisions/mall_parking_alpha.col",
		transparent = true,
		flags = {
			"no_zbuffer_write"
		},
		lodDistance = 250
	},
	["mall_parking_props"] = {
		type = "object",
		model = "object",
		dff = "files/mall/models/mall_parking_props.dff",
		txd = "files/mall/textures/v4_mall.txd",
		col = "files/mall/collisions/mall_parking_props.col"
	},
	["mall_parking_airsoftbollard"] = {
		type = "object",
		model = "object",
		dff = "files/mall/models/mall_parking_airsoftbollard.dff",
		txd = "files/mall/textures/v4_mall.txd",
		col = "files/mall/collisions/mall_parking_airsoftbollard.col"
	},
	["v4_airsoftshop_int"] = {
		type = "object",
		model = "object",
		dff = "files/mall/models/v4_airsoftshop_int.dff",
		txd = "files/mall/textures/v4_mall.txd",
		col = "files/mall/collisions/v4_airsoftshop_int.col"
	},
	["v4_airsoftshop_int_props"] = {
		type = "object",
		model = "object",
		dff = "files/mall/models/v4_airsoftshop_int_props.dff",
		txd = "files/mall/textures/v4_mall.txd",
		col = "files/mall/collisions/v4_airsoftshop_int_props.col"
	},
	["v4_airsoftshop_int_glass"] = {
		type = "object",
		model = "object",
		dff = "files/mall/models/v4_airsoftshop_int_glass.dff",
		txd = "files/mall/textures/v4_mall.txd",
		col = "files/mall/collisions/v4_airsoftshop_int_glass.col",
		transparent = true
	},
	["v4_airsoftshop_int_transparent"] = {
		type = "object",
		model = "object",
		dff = "files/mall/models/v4_airsoftshop_int_transparent.dff",
		txd = "files/v4_alpha_textures.txd",
		col = "files/mall/collisions/v4_airsoftshop_int_transparent.col",
		transparent = true,
		flags = {
			"no_zbuffer_write"
		},
		lodDistance = 250
	},
	["mall_neon1"] = {
		type = "object",
		model = "object",
		dff = "files/mall/models/mall_neon1.dff",
		txd = "files/mall/textures/v4_mall.txd",
		col = "files/mall/collisions/mall_neon1.col",
		transparent = true,
		flags = {
			"no_zbuffer_write"
		},
		lodDistance = 200
	},
	["mall_neon2"] = {
		type = "object",
		model = "object",
		dff = "files/mall/models/mall_neon2.dff",
		txd = "files/mall/textures/v4_mall.txd",
		col = "files/mall/collisions/mall_neon2.col",
		transparent = true,
		flags = {
			"no_zbuffer_write"
		},
		lodDistance = 200
	},
	["mallglass_laW"] = {
		type = "object",
		model = 6051,
		dff = "files/mall/models/mallglass_laW.dff",
		txd = "files/mall/textures/v4_mall.txd",
		col = "files/mall/collisions/mallglass_laW.col",
		transparent = true,
		flags = {"draw_last"},
		lodDistance = 200
	},
	["mallb_laW_storeLogos"] = {
		type = "object",
		model = "object",
		dff = "files/mall/models/mallb_laW_storeLogos.dff",
		txd = "files/mall/textures/v4_mall.txd",
		col = "files/mall/collisions/mallb_laW_storeLogos.col",
		lodDistance = 200
	},
	["mallb_laW_storeLogosLOD"] = {
		type = "object",
		model = "object",
		dff = "files/mall/models/mallb_laW_storeLogosLOD.dff",
		txd = "files/mall/textures/v4_mall.txd",
		transparent = true,
		lodDistance = 10000
	},
	["mall_clockwiseM"] = {
		type = "object",
		model = "object",
		dff = "files/mall/models/mall_clockwiseM.dff",
		txd = "files/mall/textures/v4_mall.txd",
		transparent = true
	},
	["mall_clockwiseH"] = {
		type = "object",
		model = "object",
		dff = "files/mall/models/mall_clockwiseH.dff",
		txd = "files/mall/textures/v4_mall.txd",
		transparent = true
	},
	["mall_door"] = {
		type = "object",
		model = "object",
		dff = "files/mall/models/mall_door.dff",
		col = "files/mall/collisions/mall_door.col",
		txd = "files/mall/textures/v4_mall.txd",
		transparent = true,
		lodDistance = 200,
		dynamicDoor = true
	},
	["mall_door_cinema"] = {
		type = "object",
		model = "object",
		dff = "files/mall/models/mall_door_cinema.dff",
		col = "files/mall/collisions/mall_door.col",
		txd = "files/mall/textures/v4_mall.txd",
		transparent = true,
		lodDistance = 200,
		dynamicDoor = true
	},
	["mall_bollards1"] = {
		type = "object",
		model = "object",
		dff = "files/mall/models/mall_bollards1.dff",
		txd = "files/mall/textures/v4_mall.txd",
		col = "files/mall/collisions/mall_bollards1.col"
	},
	["mall_rooms_247"] = {
		type = "object",
		model = "object",
		dff = "files/mall/models/mall_rooms_247.dff",
		txd = "files/mall/textures/v4_mall.txd",
		col = "files/mall/collisions/mall_rooms_247.col",
		lodDistance = 200
	},
	["mall_rooms_247prods"] = {
		type = "object",
		model = "object",
		dff = "files/mall/models/mall_rooms_247prods.dff",
		txd = "files/mall/textures/v4_mall.txd",
		col = "files/mall/collisions/mall_rooms_247.col"
	},
	["mall_rooms_zip"] = {
		type = "object",
		model = "object",
		dff = "files/mall/models/mall_rooms_zip.dff",
		txd = "files/mall/textures/v4_mall.txd",
		col = "files/mall/collisions/mall_rooms_zip.col",
		lodDistance = 200
	},
	["mall_rooms_burger_alpha"] = {
		type = "object",
		model = "object",
		dff = "files/mall/models/mall_rooms_burger_alpha.dff",
		txd = "files/mall/textures/v4_mall.txd",
		col = "files/mall/collisions/mall_rooms_burger_alpha.col",
		transparent = true,
		flags = {
			"no_zbuffer_write"
		},
		lodDistance = 250
	},
	["mall_rooms_burger_props"] = {
		type = "object",
		model = "object",
		dff = "files/mall/models/mall_rooms_burger_props.dff",
		txd = "files/mall/textures/v4_mall.txd",
		col = "files/mall/collisions/mall_rooms_burger_props.col"
	},
	["mall_rooms_burger"] = {
		type = "object",
		model = "object",
		dff = "files/mall/models/mall_rooms_burger.dff",
		txd = "files/mall/textures/v4_mall.txd",
		col = "files/mall/collisions/mall_rooms_burger.col",
		lodDistance = 200
	},
	["mall_rooms_jewelry"] = {
		type = "object",
		model = "object",
		dff = "files/mall/models/mall_rooms_jewelry.dff",
		txd = "files/mall/textures/v4_mall.txd",
		col = "files/mall/collisions/mall_rooms_jewelry.col",
		lodDistance = 200
	},
	["mall_rooms_pharmacy"] = {
		type = "object",
		model = "object",
		dff = "files/mall/models/mall_rooms_pharmacy.dff",
		txd = "files/mall/textures/v4_mall.txd",
		col = "files/mall/collisions/mall_rooms_pharmacy.col",
		lodDistance = 200
	},
	["mall_rooms_coffee_alpha"] = {
		type = "object",
		model = "object",
		dff = "files/mall/models/mall_rooms_coffee_alpha.dff",
		txd = "files/mall/textures/v4_mall.txd",
		col = "files/mall/collisions/mall_rooms_coffee_alpha.col",
		transparent = true,
		flags = {
			"no_zbuffer_write"
		},
		lodDistance = 250
	},
	["mall_rooms_coffee"] = {
		type = "object",
		model = "object",
		dff = "files/mall/models/mall_rooms_coffee.dff",
		txd = "files/mall/textures/v4_mall.txd",
		col = "files/mall/collisions/mall_rooms_coffee.col",
		lodDistance = 200
	},
	["mall_rooms_digital"] = {
		type = "object",
		model = "object",
		dff = "files/mall/models/mall_rooms_digital.dff",
		txd = "files/mall/textures/v4_mall.txd",
		col = "files/mall/collisions/mall_rooms_digital.col",
		lodDistance = 200
	},
	["mall_rooms_flintTools"] = {
		type = "object",
		model = "object",
		dff = "files/mall/models/mall_rooms_flintTools.dff",
		txd = "files/mall/textures/v4_mall.txd",
		col = "files/mall/collisions/mall_rooms_flintTools.col",
		lodDistance = 200
	},
	["mall_rooms_lottery"] = {
		type = "object",
		model = "object",
		dff = "files/mall/models/mall_rooms_lottery.dff",
		txd = "files/mall/textures/v4_mall.txd",
		col = "files/mall/collisions/mall_rooms_lottery.col",
		lodDistance = 200
	},
	["mall_rooms_bank"] = {
		type = "object",
		model = "object",
		dff = "files/mall/models/mall_rooms_bank.dff",
		txd = "files/mall/textures/v4_mall.txd",
		col = "files/mall/collisions/mall_rooms_bank.col",
		lodDistance = 200
	},
	["mall_rooms_cluckinBell_alpha"] = {
		type = "object",
		model = "object",
		dff = "files/mall/models/mall_rooms_cluckinBell_alpha.dff",
		txd = "files/mall/textures/v4_mall.txd",
		col = "files/mall/collisions/mall_rooms_cluckinBell_alpha.col",
		transparent = true,
		flags = {
			"no_zbuffer_write"
		},
		lodDistance = 250
	},
	["mall_rooms_cluckinBell_props"] = {
		type = "object",
		model = "object",
		dff = "files/mall/models/mall_rooms_cluckinBell_props.dff",
		txd = "files/mall/textures/v4_mall.txd",
		col = "files/mall/collisions/mall_rooms_cluckinBell_props.col"
	},
	["mall_rooms_cluckinBell"] = {
		type = "object",
		model = "object",
		dff = "files/mall/models/mall_rooms_cluckinBell.dff",
		txd = "files/mall/textures/v4_mall.txd",
		col = "files/mall/collisions/mall_rooms_cluckinBell.col",
		lodDistance = 200
	},
	["mall_rooms_cinema_alpha"] = {
		type = "object",
		model = "object",
		dff = "files/mall/models/mall_rooms_cinema_alpha.dff",
		txd = "files/mall/textures/v4_mall.txd",
		col = "files/mall/collisions/mall_rooms_cinema_alpha.col",
		transparent = true,
		flags = {
			"no_zbuffer_write"
		},
		lodDistance = 250
	},
	["mall_rooms_cinema"] = {
		type = "object",
		model = "object",
		dff = "files/mall/models/mall_rooms_cinema.dff",
		txd = "files/mall/textures/v4_mall.txd",
		col = "files/mall/collisions/mall_rooms_cinema.col",
		lodDistance = 200
	},
	["mall_rooms_cinema2"] = {
		type = "object",
		model = "object",
		dff = "files/mall/models/mall_rooms_cinema2.dff",
		txd = "files/mall/textures/v4_mall.txd",
		col = "files/mall/collisions/mall_rooms_cinema2.col",
		lodDistance = 200
	},
	["mall_rooms_toilet"] = {
		type = "object",
		model = "object",
		dff = "files/mall/models/mall_rooms_toilet.dff",
		txd = "files/mall/textures/v4_mall.txd",
		col = "files/mall/collisions/mall_rooms_toilet.col"
	},
	["mall_toiletdoor_male"] = {
		type = "object",
		model = "object",
		dff = "files/mall/models/mall_toiletdoor_male.dff",
		col = "files/mall/collisions/mall_door.col",
		txd = "files/mall/textures/v4_mall.txd",
		dynamicDoor = true
	},
	["mall_toiletdoor_female"] = {
		type = "object",
		model = "object",
		dff = "files/mall/models/mall_toiletdoor_female.dff",
		col = "files/mall/collisions/mall_door.col",
		txd = "files/mall/textures/v4_mall.txd",
		dynamicDoor = true
	},
	["int_seenema"] = {
		type = "object",
		model = "object",
		dff = "files/mall/models/int_seenema.dff",
		txd = "files/mall/textures/v4_mall.txd",
		col = "files/mall/collisions/int_seenema.col"
	},
	["prop_seenema_seats1"] = {
		type = "object",
		model = "object",
		dff = "files/mall/models/prop_seenema_seats1.dff",
		txd = "files/mall/textures/v4_mall.txd",
		col = "files/mall/collisions/prop_seenema_seats1.col"
	},
	["prop_seenema_seats2"] = {
		type = "object",
		model = "object",
		dff = "files/mall/models/prop_seenema_seats2.dff",
		txd = "files/mall/textures/v4_mall.txd",
		col = "files/mall/collisions/prop_seenema_seats2.col"
	},
	["admiral_neons"] = {
		type = "object",
		model = "object",
		dff = "files/casino/admiral_neons.dff",
		txd = "files/casino/admiral_neons.txd",
		col = "files/casino/admiral_neons.col",
		transparent = true
	},
	["int_admiral_casino"] = {
		type = "object",
		model = "object",
		dff = "files/casino/int_admiral_casino.dff",
		txd = "files/casino/int_admiral_casino.txd",
		col = "files/casino/int_admiral_casino.col"
	},
	["int_admiral_casino2"] = {
		type = "object",
		model = "object",
		dff = "files/casino/int_admiral_casino2.dff",
		txd = "files/casino/int_admiral_casino.txd",
		col = "files/casino/int_admiral_casino2.col"
	},
	["admiral_props"] = {
		type = "object",
		model = "object",
		dff = "files/casino/admiral_props.dff",
		txd = "files/casino/admiral_props.txd",
		col = "files/casino/admiral_props.col"
	},
	["admiral_props2"] = {
		type = "object",
		model = "object",
		dff = "files/casino/admiral_props2.dff",
		txd = "files/casino/admiral_props.txd",
		col = "files/casino/admiral_props2.col"
	},
	["admiral_bar"] = {
		type = "object",
		model = "object",
		dff = "files/casino/admiral_bar.dff",
		txd = "files/casino/admiral_props.txd",
		col = "files/casino/admiral_bar.col"
	},
	["admiral_restaurant"] = {
		type = "object",
		model = "object",
		dff = "files/casino/admiral_restaurant.dff",
		txd = "files/casino/admiral_props.txd",
		col = "files/casino/admiral_restaurant.col"
	},
	["admiral_escalator"] = {
		type = "object",
		model = "object",
		dff = "files/casino/admiral_escalator.dff",
		txd = "files/casino/admiral_props.txd",
		col = "files/casino/admiral_escalator.col"
	},
	["admiral_cashier1"] = {
		type = "object",
		model = "object",
		dff = "files/casino/admiral_cashier1.dff",
		txd = "files/casino/admiral_props.txd",
		col = "files/casino/admiral_cashier1.col"
	},
	["admiral_cashier2"] = {
		type = "object",
		model = "object",
		dff = "files/casino/admiral_cashier2.dff",
		txd = "files/casino/admiral_props.txd",
		col = "files/casino/admiral_cashier2.col"
	},
	["horsee_logo"] = {
		type = "object",
		model = "object",
		dff = "files/casino/horsee_logo.dff",
		col = "files/casino/horsee_logo.col",
		txd = "files/casino/horsee_logo.txd"
	},
	["roulette_logo"] = {
		type = "object",
		model = "object",
		dff = "files/casino/roulette_logo.dff",
		col = "files/casino/roulette_logo.col",
		txd = "files/casino/roulette_logo.txd"
	},
	["seedice_logo"] = {
		type = "object",
		model = "object",
		dff = "files/casino/seedice_logo.dff",
		col = "files/casino/seedice_logo.col",
		txd = "files/casino/seedice_logo.txd",
		transparent = true
	},
	["fortunecup_base"] = {
		type = "object",
		model = "object",
		dff = "files/casino/fortunecup_base.dff",
		col = "files/casino/fortunecup_base.col",
		txd = "files/casino/fortunecup.txd"
	},
	["fortunecup_alpha"] = {
		type = "object",
		model = "object",
		dff = "files/casino/fortunecup_alpha.dff",
		col = "files/casino/fortunecup_alpha.col",
		txd = "files/casino/fortunecup_alpha.txd",
		transparent = true
	},
	["fortunecup_finish"] = {
		type = "object",
		model = "object",
		dff = "files/casino/fortunecup_finish.dff",
		txd = "files/casino/fortunecup.txd",
		lodDistance = 20
	},
	["fortunecup_start"] = {
		type = "object",
		model = "object",
		dff = "files/casino/fortunecup_start.dff",
		txd = "files/casino/fortunecup.txd",
		lodDistance = 20
	},
	["fortunecup_horse1"] = {
		type = "object",
		model = "object",
		dff = "files/casino/fortunecup_horse1.dff",
		txd = "files/casino/fortunecup_horses.txd",
		lodDistance = 20
	},
	["fortunecup_horse2"] = {
		type = "object",
		model = "object",
		dff = "files/casino/fortunecup_horse2.dff",
		txd = "files/casino/fortunecup_horses.txd",
		lodDistance = 20
	},
	["fortunecup_horse3"] = {
		type = "object",
		model = "object",
		dff = "files/casino/fortunecup_horse3.dff",
		txd = "files/casino/fortunecup_horses.txd",
		lodDistance = 20
	},
	["fortunecup_horse4"] = {
		type = "object",
		model = "object",
		dff = "files/casino/fortunecup_horse4.dff",
		txd = "files/casino/fortunecup_horses.txd",
		lodDistance = 20
	},
	["fortunecup_horse5"] = {
		type = "object",
		model = "object",
		dff = "files/casino/fortunecup_horse5.dff",
		txd = "files/casino/fortunecup_horses.txd",
		lodDistance = 20
	},
	["fortunecup_horse6"] = {
		type = "object",
		model = "object",
		dff = "files/casino/fortunecup_horse6.dff",
		txd = "files/casino/fortunecup_horses.txd",
		lodDistance = 20
	},
	["fortunecup_horse_legsF_1"] = {
		type = "object",
		model = "object",
		dff = "files/casino/fortunecup_horse_legsF_1.dff",
		txd = "files/casino/fortunecup_horses.txd",
		lodDistance = 10
	},
	["fortunecup_horse_legsR_1"] = {
		type = "object",
		model = "object",
		dff = "files/casino/fortunecup_horse_legsR_1.dff",
		txd = "files/casino/fortunecup_horses.txd",
		lodDistance = 10
	},
	["fortunecup_horse_legsF_2"] = {
		type = "object",
		model = "object",
		dff = "files/casino/fortunecup_horse_legsF_2.dff",
		txd = "files/casino/fortunecup_horses.txd",
		lodDistance = 10
	},
	["fortunecup_horse_legsR_2"] = {
		type = "object",
		model = "object",
		dff = "files/casino/fortunecup_horse_legsR_2.dff",
		txd = "files/casino/fortunecup_horses.txd",
		lodDistance = 10
	},
	["fortunecup_horse_legsF_3"] = {
		type = "object",
		model = "object",
		dff = "files/casino/fortunecup_horse_legsF_3.dff",
		txd = "files/casino/fortunecup_horses.txd",
		lodDistance = 10
	},
	["fortunecup_horse_legsR_3"] = {
		type = "object",
		model = "object",
		dff = "files/casino/fortunecup_horse_legsR_3.dff",
		txd = "files/casino/fortunecup_horses.txd",
		lodDistance = 10
	},
	["fortunecup_horse_legsF_4"] = {
		type = "object",
		model = "object",
		dff = "files/casino/fortunecup_horse_legsF_4.dff",
		txd = "files/casino/fortunecup_horses.txd",
		lodDistance = 10
	},
	["fortunecup_horse_legsR_4"] = {
		type = "object",
		model = "object",
		dff = "files/casino/fortunecup_horse_legsR_4.dff",
		txd = "files/casino/fortunecup_horses.txd",
		lodDistance = 10
	},
	["seedice"] = {
		type = "object",
		model = "object",
		dff = "files/casino/seedice.dff",
		col = "files/casino/seedice.col",
		txd = "files/casino/seedice.txd"
	},
	["roulette_table"] = {
		type = "object",
		model = "object",
		dff = "files/casino/roulette_table.dff",
		col = "files/casino/roulette_table.col",
		txd = "files/casino/roulette.txd"
	},
	["roulette_wheel"] = {
		type = "object",
		model = "object",
		dff = "files/casino/roulette_wheel.dff",
		col = "files/casino/roulette_wheel.col",
		txd = "files/casino/roulette.txd"
	},
	["roulette_ball"] = {
		type = "object",
		model = "object",
		dff = "files/casino/roulette_ball.dff",
		col = "files/casino/roulette_ball.col",
		txd = "files/casino/roulette.txd"
	},
	["roulette_glass"] = {
		type = "object",
		model = "object",
		dff = "files/casino/roulette_glass.dff",
		col = "files/casino/roulette_glass.col",
		txd = "files/casino/roulette.txd",
		transparent = true
	},
	["blackjack_table1"] = {
		type = "object",
		model = 2188,
		dff = "files/casino/blackjack_table1.dff",
		col = "files/casino/blackjack_table.col",
		txd = "files/casino/blackjack_table.txd"
	},
	["blackjack_table2"] = {
		type = "object",
		model = 1948,
		dff = "files/casino/blackjack_table2.dff",
		col = "files/casino/blackjack_table.col",
		txd = "files/casino/blackjack_table.txd"
	},
	["blackjack_table3"] = {
		type = "object",
		model = 2349,
		dff = "files/casino/blackjack_table3.dff",
		col = "files/casino/blackjack_table.col",
		txd = "files/casino/blackjack_table.txd"
	},
	["spray_plug"] = {
		type = "object",
		model = "object",
		dff = "files/paintshop/spray_plug.dff",
		txd = "files/paintshop/spray_sander.txd"
	},
	["spray_sander"] = {
		type = "object",
		model = "object",
		dff = "files/paintshop/spray_sander.dff",
		txd = "files/paintshop/spray_sander.txd",
		transparent = true
	},
	["spray_sander_shelf"] = {
		type = "object",
		model = "object",
		dff = "files/paintshop/spray_sander_shelf.dff",
		txd = "files/paintshop/spray_sander.txd"
	},
	["wheel_mask"] = {
		type = "object",
		model = "object",
		dff = "files/paintshop/wheel_mask.dff",
		txd = "files/paintshop/wheel_mask.txd"
	},
	["wheel_mask_drying"] = {
		type = "object",
		model = "object",
		dff = "files/paintshop/wheel_mask_drying.dff",
		txd = "files/paintshop/wheel_mask.txd"
	},
	["spray_paintbox"] = {
		type = "object",
		model = "object",
		dff = "files/paintshop/spray_paintbox.dff",
		txd = "files/paintshop/v4_paintshop.txd"
	},
	["spray_paintbox_1"] = {
		type = "object",
		model = "object",
		dff = "files/paintshop/spray_paintbox_1.dff",
		txd = "files/paintshop/v4_paintshop.txd"
	},
	["spray_paintbox_2"] = {
		type = "object",
		model = "object",
		dff = "files/paintshop/spray_paintbox_2.dff",
		txd = "files/paintshop/v4_paintshop.txd"
	},
	["spray_paintbox_3"] = {
		type = "object",
		model = "object",
		dff = "files/paintshop/spray_paintbox_3.dff",
		txd = "files/paintshop/v4_paintshop.txd"
	},
	["spray_paintbox_4"] = {
		type = "object",
		model = "object",
		dff = "files/paintshop/spray_paintbox_4.dff",
		txd = "files/paintshop/v4_paintshop.txd"
	},
	["spray_office_door"] = {
		type = "object",
		model = "object",
		dff = "files/paintshop/spray_office_door.dff",
		col = "files/paintshop/spray_office_door.col",
		txd = "files/paintshop/v4_paintshop.txd"
	},
	["spray_mixer"] = {
		type = "object",
		model = "object",
		dff = "files/paintshop/spray_mixer.dff",
		col = "files/paintshop/spray_mixer.col",
		txd = "files/paintshop/v4_paintshop.txd"
	},
	["spray_mixer_slider"] = {
		type = "object",
		model = "object",
		dff = "files/paintshop/spray_mixer_slider.dff",
		txd = "files/paintshop/v4_paintshop.txd"
	},
	["spray_interior"] = {
		type = "object",
		model = "object",
		dff = "files/paintshop/spray_interior.dff",
		col = "files/paintshop/spray_interior.col",
		txd = "files/paintshop/v4_paintshop.txd"
	},
	["spray_interior_alpha"] = {
		type = "object",
		model = "object",
		dff = "files/paintshop/spray_interior_alpha.dff",
		col = "files/paintshop/spray_interior_alpha.col",
		txd = "files/paintshop/v4_paintshop.txd",
		transparent = true
	},
	["spray_manometer"] = {
		type = "object",
		model = "object",
		dff = "files/paintshop/spray_manometer.dff",
		txd = "files/paintshop/v4_paintshop.txd"
	},
	["spray_hall"] = {
		type = "object",
		model = "object",
		dff = "files/paintshop/spray_hall.dff",
		col = "files/paintshop/spray_hall.col",
		txd = "files/paintshop/v4_paintshop.txd"
	},
	["garage_hall"] = {
		type = "object",
		model = "object",
		dff = "files/paintshop/garage_hall.dff",
		col = "files/paintshop/spray_hall.col",
		txd = "files/paintshop/v4_paintshop.txd"
	},
	["spray_hall_props"] = {
		type = "object",
		model = "object",
		dff = "files/paintshop/spray_hall_props.dff",
		col = "files/paintshop/spray_hall_props.col",
		txd = "files/paintshop/v4_paintshop.txd"
	},
	["spray_gun"] = {
		type = "object",
		model = "object",
		dff = "files/paintshop/spray_gun.dff",
		txd = "files/paintshop/spray_gun.txd",
		transparent = true
	},
	["spray_gun_base"] = {
		type = "object",
		model = "object",
		dff = "files/paintshop/spray_gun_base.dff",
		txd = "files/paintshop/spray_gun.txd"
	},
	["spray_gun_cup"] = {
		type = "object",
		model = "object",
		dff = "files/paintshop/spray_gun_cup.dff",
		txd = "files/paintshop/spray_gun.txd",
		transparent = true
	},
	["spray_door"] = {
		type = "object",
		model = "object",
		dff = "files/paintshop/spray_door.dff",
		col = "files/paintshop/spray_door.col",
		txd = "files/paintshop/v4_paintshop.txd",
		transparent = true
	},
	["spray_door_drying"] = {
		type = "object",
		model = "object",
		dff = "files/paintshop/spray_door_drying.dff",
		col = "files/paintshop/spray_door.col",
		txd = "files/paintshop/v4_paintshop.txd",
		transparent = true
	},
	["spray_door2"] = {
		type = "object",
		model = "object",
		dff = "files/paintshop/spray_door2.dff",
		col = "files/paintshop/spray_door2.col",
		txd = "files/paintshop/v4_paintshop.txd",
		transparent = true,
		dynamicDoor = true
	},
	["spray_door2_drying"] = {
		type = "object",
		model = "object",
		dff = "files/paintshop/spray_door2_drying.dff",
		col = "files/paintshop/spray_door2.col",
		txd = "files/paintshop/v4_paintshop.txd",
		transparent = true,
		dynamicDoor = true
	},
	["spray_clock"] = {
		type = "object",
		model = "object",
		dff = "files/paintshop/spray_clock.dff",
		txd = "files/paintshop/v4_paintshop.txd"
	},
	["spray_certificate"] = {
		type = "object",
		model = "object",
		dff = "files/paintshop/spray_certificate.dff",
		txd = "files/paintshop/spray_certificate.txd"
	},
	["spray_booth"] = {
		type = "object",
		model = "object",
		dff = "files/paintshop/spray_booth.dff",
		col = "files/paintshop/spray_booth.col",
		txd = "files/paintshop/v4_paintshop.txd"
	},
	["spray_booth_drying"] = {
		type = "object",
		model = "object",
		dff = "files/paintshop/spray_booth_drying.dff",
		col = "files/paintshop/spray_booth_drying.col",
		txd = "files/paintshop/v4_paintshop.txd"
	},
	["spray_basebox"] = {
		type = "object",
		model = "object",
		dff = "files/paintshop/spray_basebox.dff",
		txd = "files/paintshop/v4_paintshop.txd"
	},
	["spray_basebox_1"] = {
		type = "object",
		model = "object",
		dff = "files/paintshop/spray_basebox_1.dff",
		txd = "files/paintshop/v4_paintshop.txd"
	},
	["spray_base_canister"] = {
		type = "object",
		model = "object",
		dff = "files/paintshop/spray_base_canister.dff",
		txd = "files/paintshop/v4_paintshop.txd"
	},
	["spray_color_canister"] = {
		type = "object",
		model = "object",
		dff = "files/paintshop/spray_color_canister.dff",
		txd = "files/paintshop/v4_paintshop.txd"
	},
	["sw_gate1"] = {
		type = "object",
		model = 12858,
		dff = "files/paintshop/sw_gate1.dff",
		col = "files/paintshop/sw_gate1.col"
	},
	["sw_breweryfence02"] = {
		type = "object",
		model = 13024,
		dff = "files/paintshop/sw_breweryfence02.dff",
		col = "files/paintshop/sw_breweryfence02.col",
		txd = "files/paintshop/CE_brewery.txd",
		transparent = true
	},
	["spray_palette"] = {
		type = "object",
		model = "object",
		dff = "files/paintshop/spray_palette.dff",
		col = "files/paintshop/spray_palette.col",
		txd = "files/paintshop/v4_paintshop.txd"
	},
	["spray_hall_building"] = {
		type = "object",
		model = "object",
		dff = "files/paintshop/spray_hall_building.dff",
		col = "files/paintshop/spray_hall_building.col",
		txd = "files/paintshop/v4_paintshop.txd",
		lodDistance = 250
	},
	["spray_hall_buildingLOD"] = {
		type = "object",
		model = "object",
		dff = "files/paintshop/spray_hall_buildingLOD.dff",
		col = "files/paintshop/spray_hall_building.col",
		txd = "files/paintshop/spray_hall_buildingLOD.txd",
		lodDistance = 10000
	},
	["spray_hall_building2"] = {
		type = "object",
		model = "object",
		dff = "files/paintshop/spray_hall_building2.dff",
		col = "files/paintshop/spray_hall_building2.col",
		txd = "files/paintshop/v4_paintshop.txd",
		lodDistance = 250
	},
	["spray_hall_building2LOD"] = {
		type = "object",
		model = "object",
		dff = "files/paintshop/spray_hall_building2LOD.dff",
		col = "files/paintshop/spray_hall_building2.col",
		txd = "files/paintshop/spray_hall_buildingLOD.txd",
		lodDistance = 10000
	},
	["CE_brewery"] = {
		type = "object",
		model = 12931,
		dff = "files/paintshop/CE_brewery.dff",
		col = "files/paintshop/CE_brewery.col",
		txd = "files/paintshop/CE_brewery.txd"
	},
	["lodce_brewery"] = {
		type = "object",
		model = 13048,
		dff = "files/paintshop/lodce_brewery.dff",
		txd = "files/paintshop/breweryLOD.txd"
	},
	["cuntEground09b"] = {
		type = "object",
		model = 12908,
		dff = "files/paintshop/cuntEground09b.dff",
		col = "files/paintshop/cuntEground09b.col",
		txd = "files/paintshop/cuntEground09b.txd"
	},
	["ce_wires"] = {
		type = "object",
		model = 13205,
		dff = "files/paintshop/ce_wires.dff",
		transparent = true
	},
	["ce_wires02"] = {
		type = "object",
		model = 13437,
		dff = "files/paintshop/ce_wires02.dff",
		txd = "files/paintshop/cunte_wires.txd",
		transparent = true
	},
	["carshow4_sfse"] = {
		type = "object",
		model = 11301,
		dff = "files/paintshop/carshow4_sfse.dff",
		col = "files/paintshop/carshow4_SFSe.col",
		txd = "files/paintshop/v4_paintshop.txd"
	},
	["Carshow2_SFSe"] = {
		type = "object",
		model = 11318,
		dff = "files/paintshop/Carshow2_SFSe.dff",
		col = "files/paintshop/carshow2_SFSe.col",
		txd = "files/paintshop/v4_paintshop.txd"
	},
	["carshow_SFSe"] = {
		type = "object",
		model = 11317,
		dff = "files/paintshop/carshow_SFSe.dff",
		col = "files/paintshop/carshow_SFSe.col",
		txd = "files/paintshop/v4_paintshop.txd"
	},
	["carshow_SFSe_props"] = {
		type = "object",
		model = "object",
		dff = "files/paintshop/carshow_SFSe_props.dff",
		col = "files/paintshop/carshow_SFSe_props.col",
		txd = "files/paintshop/v4_paintshop.txd"
	},
	["carshow_SFSe_props2"] = {
		type = "object",
		model = "object",
		dff = "files/paintshop/carshow_SFSe_props2.dff",
		col = "files/paintshop/carshow_SFSe_props2.col",
		txd = "files/paintshop/v4_paintshop.txd"
	},
	["carshow_SFSe_windows"] = {
		type = "object",
		model = "object",
		dff = "files/paintshop/carshow_SFSe_windows.dff",
		col = "files/paintshop/carshow_SFSe_windows.col",
		txd = "files/paintshop/v4_paintshop.txd",
		transparent = true,
		lodDistance = 120
	},
	["lod_carshow_SFSe"] = {
		type = "object",
		model = 11321,
		dff = "files/paintshop/lod_carshow_SFSe.dff",
		txd = "files/paintshop/lod_sfse.txd"
	},
	["lod_Carshow2_SFSe"] = {
		type = "object",
		model = 11322,
		dff = "files/paintshop/lod_Carshow2_SFSe.dff",
		txd = "files/paintshop/lod_sfse.txd"
	},
	["LOD_carshow4_SFSe"] = {
		type = "object",
		model = 11320,
		dff = "files/paintshop/LOD_carshow4_SFSe.dff",
		txd = "files/paintshop/lod_sfse.txd"
	},
	["carshow_door"] = {
		type = "object",
		model = "object",
		dff = "files/paintshop/carshow_door.dff",
		col = "files/paintshop/carshow_door.col",
		txd = "files/paintshop/v4_paintshop.txd",
		transparent = true,
		dynamicDoor = true
	},
	["paintshop_skin"] = {
		type = "skin",
		model = "ped",
		dff = "files/paintshop/skin.dff",
		txd = "files/paintshop/skin.txd"
	},
	["lasrnway7_LAS"] = {
		type = "object",
		model = 5009,
		dff = "files/paintshop/lasrnway7_LAS.dff",
		col = "files/paintshop/lasrnway7_LAS.col",
		txd = "files/paintshop/lasrnway7_LAS.txd"
	},
	["LODrnway7_LAS"] = {
		type = "object",
		model = 4955,
		dff = "files/paintshop/LODrnway7_LAS.dff",
		col = "files/paintshop/lasrnway7_LAS.col",
		txd = "files/paintshop/LODrnway7_LAS.txd"
	},
	["lasrnway8_LAS"] = {
		type = "object",
		model = 4869,
		dff = "files/paintshop/lasrnway8_LAS.dff",
		col = "files/paintshop/lasrnway8_LAS.col",
		txd = "files/paintshop/lasrnway7_LAS.txd"
	},
	["lasrnway7_alpha_LAS"] = {
		type = "object",
		model = "object",
		dff = "files/paintshop/lasrnway7_alpha_LAS.dff",
		col = "files/paintshop/lasrnway7_alpha_LAS.col",
		txd = "files/v4_alpha_textures.txd",
		transparent = true,
		flags = {
			"no_zbuffer_write"
		},
		lodDistance = 250
	},
	["spray_hall_building_LS"] = {
		type = "object",
		model = "object",
		dff = "files/paintshop/spray_hall_building_LS.dff",
		col = "files/paintshop/spray_hall_building.col",
		txd = "files/paintshop/v4_paintshop.txd",
		lodDistance = 250
	},
	["spray_hall_buildingLOD_LS"] = {
		type = "object",
		model = "object",
		dff = "files/paintshop/spray_hall_buildingLOD_LS.dff",
		col = "files/paintshop/spray_hall_building.col",
		txd = "files/paintshop/spray_hall_buildingLOD.txd",
		lodDistance = 10000
	},
	["v4_industrialsign_oceandocks"] = {
		type = "object",
		model = "object",
		dff = "files/paintshop/v4_industrialsign_oceandocks.dff",
		col = "files/paintshop/v4_industrialsign_oceandocks.col",
		txd = "files/paintshop/v4_paintshop.txd",
		lodDistance = 250
	},
	["cuntwland25b"] = {
		type = "object",
		model = 17099,
		dff = "files/urmatrans/cuntwland25b.dff",
		col = "files/urmatrans/cuntwland25b.col",
		txd = "files/urmatrans/urmatrans_ground_ls.txd"
	},
	["lodcuntw14"] = {
		type = "object",
		model = 17371,
		dff = "files/urmatrans/lodcuntw14.dff",
		col = "files/urmatrans/cuntwland25b.col",
		txd = "files/urmatrans/urmatrans_ground_lsLOD.txd"
	},
	["cuntwland26b"] = {
		type = "object",
		model = 17100,
		dff = "files/urmatrans/cuntwland26b.dff",
		col = "files/urmatrans/cuntwland26b.col",
		txd = "files/urmatrans/urmatrans_ground_ls.txd"
	},
	["lodcuntw15"] = {
		type = "object",
		model = 17372,
		dff = "files/urmatrans/lodcuntw15.dff",
		col = "files/urmatrans/cuntwland26b.col",
		txd = "files/urmatrans/urmatrans_ground_lsLOD.txd"
	},
	["sight_urmatrans_warehouse"] = {
		type = "object",
		model = "object",
		dff = "files/urmatrans/sight_urmatrans_warehouse.dff",
		col = "files/urmatrans/sight_urmatrans_warehouse.col",
		txd = "files/urmatrans/sight_urmatrans_main.txd",
		lodDistance = 300
	},
	["sight_urmatrans_warehouse_LOD"] = {
		type = "object",
		model = "object",
		dff = "files/urmatrans/sight_urmatrans_warehouse_LOD.dff",
		col = "files/urmatrans/sight_urmatrans_warehouse.col",
		txd = "files/urmatrans/sight_urmatrans_LOD.txd",
		lodDistance = 10000
	},
	["sight_urmatrans_warehouse_alpha"] = {
		type = "object",
		model = "object",
		dff = "files/urmatrans/sight_urmatrans_warehouse_alpha.dff",
		col = "files/urmatrans/sight_urmatrans_warehouse_alpha.col",
		txd = "files/urmatrans/sight_urmatrans_alpha.txd",
		transparent = true,
		lodDistance = 200
	},
	["sight_urmatrans_warehouse_props"] = {
		type = "object",
		model = "object",
		dff = "files/urmatrans/sight_urmatrans_warehouse_props.dff",
		col = "files/urmatrans/sight_urmatrans_warehouse_props.col",
		txd = "files/urmatrans/sight_urmatrans_main.txd",
		lodDistance = 200
	},
	["sight_urmatrans_warehouse_lights"] = {
		type = "object",
		model = "object",
		dff = "files/urmatrans/sight_urmatrans_warehouse_lights.dff",
		col = "files/urmatrans/sight_urmatrans_warehouse_lights.col",
		txd = "files/urmatrans/sight_urmatrans_main.txd",
		lodDistance = 100
	},
	["sight_urmatrans_garage"] = {
		type = "object",
		model = "object",
		dff = "files/urmatrans/sight_urmatrans_garage.dff",
		col = "files/urmatrans/sight_urmatrans_garage.col",
		txd = "files/urmatrans/sight_urmatrans_main.txd",
		lodDistance = 200
	},
	["sight_urmatrans_garage_LOD"] = {
		type = "object",
		model = "object",
		dff = "files/urmatrans/sight_urmatrans_garage_LOD.dff",
		col = "files/urmatrans/sight_urmatrans_garage.col",
		txd = "files/urmatrans/sight_urmatrans_LOD.txd",
		lodDistance = 10000
	},
	["sight_urmatrans_lsalpha"] = {
		type = "object",
		model = "object",
		dff = "files/urmatrans/sight_urmatrans_lsalpha.dff",
		col = "files/urmatrans/sight_urmatrans_lsalpha.col",
		txd = "files/v4_alpha_textures.txd",
		transparent = true,
		flags = {
			"no_zbuffer_write"
		},
		lodDistance = 250
	},
	["sight_soil_fueltank"] = {
		type = "object",
		model = "object",
		dff = "files/urmatrans/sight_soil_fueltank.dff",
		col = "files/urmatrans/sight_soil_fueltank.col",
		txd = "files/urmatrans/sight_urmatrans_main.txd",
		lodDistance = 200
	},
	["sight_urmatrans_fuelbollard"] = {
		type = "object",
		model = "object",
		dff = "files/urmatrans/sight_urmatrans_fuelbollard.dff",
		col = "files/urmatrans/sight_urmatrans_fuelbollard.col",
		txd = "files/urmatrans/sight_urmatrans_main.txd"
	},
	["sight_urmatrans_shelf"] = {
		type = "object",
		model = "object",
		dff = "files/urmatrans/sight_urmatrans_shelf.dff",
		col = "files/urmatrans/sight_urmatrans_shelf.col",
		txd = "files/urmatrans/sight_urmatrans_cargo.txd"
	},
	["sight_urmatrans_shelf_almapapr"] = {
		type = "object",
		model = "object",
		dff = "files/urmatrans/sight_urmatrans_shelf_almapapr.dff",
		col = "files/urmatrans/sight_urmatrans_shelf_cargo.col",
		txd = "files/urmatrans/sight_urmatrans_cargo.txd"
	},
	["sight_urmatrans_cargo_almapapr"] = {
		type = "object",
		model = "object",
		dff = "files/urmatrans/sight_urmatrans_cargo_almapapr.dff",
		col = "files/urmatrans/sight_urmatrans_cargo_scrate.col",
		txd = "files/urmatrans/sight_urmatrans_cargo.txd"
	},
	["sight_urmatrans_shelf_tvpapr"] = {
		type = "object",
		model = "object",
		dff = "files/urmatrans/sight_urmatrans_shelf_tvpapr.dff",
		col = "files/urmatrans/sight_urmatrans_shelf_cargo.col",
		txd = "files/urmatrans/sight_urmatrans_cargo.txd"
	},
	["sight_urmatrans_cargo_tvpapr"] = {
		type = "object",
		model = "object",
		dff = "files/urmatrans/sight_urmatrans_cargo_tvpapr.dff",
		col = "files/urmatrans/sight_urmatrans_cargo_scrate.col",
		txd = "files/urmatrans/sight_urmatrans_cargo.txd"
	},
	["sight_urmatrans_shelf_chili"] = {
		type = "object",
		model = "object",
		dff = "files/urmatrans/sight_urmatrans_shelf_chili.dff",
		col = "files/urmatrans/sight_urmatrans_shelf_cargo.col",
		txd = "files/urmatrans/sight_urmatrans_cargo.txd"
	},
	["sight_urmatrans_cargo_chili"] = {
		type = "object",
		model = "object",
		dff = "files/urmatrans/sight_urmatrans_cargo_chili.dff",
		col = "files/urmatrans/sight_urmatrans_cargo_scrate.col",
		txd = "files/urmatrans/sight_urmatrans_cargo.txd"
	},
	["sight_urmatrans_shelf_repa"] = {
		type = "object",
		model = "object",
		dff = "files/urmatrans/sight_urmatrans_shelf_repa.dff",
		col = "files/urmatrans/sight_urmatrans_shelf_cargo.col",
		txd = "files/urmatrans/sight_urmatrans_cargo.txd"
	},
	["sight_urmatrans_cargo_repa"] = {
		type = "object",
		model = "object",
		dff = "files/urmatrans/sight_urmatrans_cargo_repa.dff",
		col = "files/urmatrans/sight_urmatrans_cargo_scrate.col",
		txd = "files/urmatrans/sight_urmatrans_cargo.txd"
	},
	["sight_urmatrans_shelf_onion"] = {
		type = "object",
		model = "object",
		dff = "files/urmatrans/sight_urmatrans_shelf_onion.dff",
		col = "files/urmatrans/sight_urmatrans_shelf_cargo.col",
		txd = "files/urmatrans/sight_urmatrans_cargo.txd"
	},
	["sight_urmatrans_cargo_onion"] = {
		type = "object",
		model = "object",
		dff = "files/urmatrans/sight_urmatrans_cargo_onion.dff",
		col = "files/urmatrans/sight_urmatrans_cargo_scrate.col",
		txd = "files/urmatrans/sight_urmatrans_cargo.txd"
	},
	["sight_urmatrans_shelf_onion2"] = {
		type = "object",
		model = "object",
		dff = "files/urmatrans/sight_urmatrans_shelf_onion2.dff",
		col = "files/urmatrans/sight_urmatrans_shelf_cargo.col",
		txd = "files/urmatrans/sight_urmatrans_cargo.txd"
	},
	["sight_urmatrans_cargo_onion2"] = {
		type = "object",
		model = "object",
		dff = "files/urmatrans/sight_urmatrans_cargo_onion2.dff",
		col = "files/urmatrans/sight_urmatrans_cargo_scrate.col",
		txd = "files/urmatrans/sight_urmatrans_cargo.txd"
	},
	["sight_urmatrans_shelf_cucum"] = {
		type = "object",
		model = "object",
		dff = "files/urmatrans/sight_urmatrans_shelf_cucum.dff",
		col = "files/urmatrans/sight_urmatrans_shelf_cargo.col",
		txd = "files/urmatrans/sight_urmatrans_cargo.txd"
	},
	["sight_urmatrans_cargo_cucum"] = {
		type = "object",
		model = "object",
		dff = "files/urmatrans/sight_urmatrans_cargo_cucum.dff",
		col = "files/urmatrans/sight_urmatrans_cargo_scrate.col",
		txd = "files/urmatrans/sight_urmatrans_cargo.txd"
	},
	["sight_urmatrans_shelf_karalabe"] = {
		type = "object",
		model = "object",
		dff = "files/urmatrans/sight_urmatrans_shelf_karalabe.dff",
		col = "files/urmatrans/sight_urmatrans_shelf_cargo.col",
		txd = "files/urmatrans/sight_urmatrans_cargo.txd"
	},
	["sight_urmatrans_cargo_karalabe"] = {
		type = "object",
		model = "object",
		dff = "files/urmatrans/sight_urmatrans_cargo_karalabe.dff",
		col = "files/urmatrans/sight_urmatrans_cargo_scrate.col",
		txd = "files/urmatrans/sight_urmatrans_cargo.txd"
	},
	["sight_urmatrans_shelf_radish"] = {
		type = "object",
		model = "object",
		dff = "files/urmatrans/sight_urmatrans_shelf_radish.dff",
		col = "files/urmatrans/sight_urmatrans_shelf_cargo.col",
		txd = "files/urmatrans/sight_urmatrans_cargo.txd"
	},
	["sight_urmatrans_cargo_radish"] = {
		type = "object",
		model = "object",
		dff = "files/urmatrans/sight_urmatrans_cargo_radish.dff",
		col = "files/urmatrans/sight_urmatrans_cargo_scrate.col",
		txd = "files/urmatrans/sight_urmatrans_cargo.txd"
	},
	["sight_urmatrans_shelf_cabbage"] = {
		type = "object",
		model = "object",
		dff = "files/urmatrans/sight_urmatrans_shelf_cabbage.dff",
		col = "files/urmatrans/sight_urmatrans_shelf_cargo.col",
		txd = "files/urmatrans/sight_urmatrans_cargo.txd"
	},
	["sight_urmatrans_cargo_cabbage"] = {
		type = "object",
		model = "object",
		dff = "files/urmatrans/sight_urmatrans_cargo_cabbage.dff",
		col = "files/urmatrans/sight_urmatrans_cargo_scrate.col",
		txd = "files/urmatrans/sight_urmatrans_cargo.txd"
	},
	["sight_urmatrans_shelf_salad"] = {
		type = "object",
		model = "object",
		dff = "files/urmatrans/sight_urmatrans_shelf_salad.dff",
		col = "files/urmatrans/sight_urmatrans_shelf_cargo.col",
		txd = "files/urmatrans/sight_urmatrans_cargo.txd"
	},
	["sight_urmatrans_cargo_salad"] = {
		type = "object",
		model = "object",
		dff = "files/urmatrans/sight_urmatrans_cargo_salad.dff",
		col = "files/urmatrans/sight_urmatrans_cargo_scrate.col",
		txd = "files/urmatrans/sight_urmatrans_cargo.txd"
	},
	["sight_urmatrans_shelf_pumpkin"] = {
		type = "object",
		model = "object",
		dff = "files/urmatrans/sight_urmatrans_shelf_pumpkin.dff",
		col = "files/urmatrans/sight_urmatrans_shelf_cargo.col",
		txd = "files/urmatrans/sight_urmatrans_cargo.txd"
	},
	["sight_urmatrans_cargo_pumpkin"] = {
		type = "object",
		model = "object",
		dff = "files/urmatrans/sight_urmatrans_cargo_pumpkin.dff",
		col = "files/urmatrans/sight_urmatrans_cargo_lcrate.col",
		txd = "files/urmatrans/sight_urmatrans_cargo.txd"
	},
	["sight_urmatrans_shelf_waterm"] = {
		type = "object",
		model = "object",
		dff = "files/urmatrans/sight_urmatrans_shelf_waterm.dff",
		col = "files/urmatrans/sight_urmatrans_shelf_cargo.col",
		txd = "files/urmatrans/sight_urmatrans_cargo.txd"
	},
	["sight_urmatrans_cargo_waterm"] = {
		type = "object",
		model = "object",
		dff = "files/urmatrans/sight_urmatrans_cargo_waterm.dff",
		col = "files/urmatrans/sight_urmatrans_cargo_lcrate.col",
		txd = "files/urmatrans/sight_urmatrans_cargo.txd"
	},
	["sight_urmatrans_cargo_sutotok"] = {
		type = "object",
		model = "object",
		dff = "files/urmatrans/sight_urmatrans_cargo_sutotok.dff",
		col = "files/urmatrans/sight_urmatrans_cargo_scrate.col",
		txd = "files/urmatrans/sight_urmatrans_cargo.txd"
	},
	["sight_urmatrans_cargo_parsley"] = {
		type = "object",
		model = "object",
		dff = "files/urmatrans/sight_urmatrans_cargo_parsley.dff",
		col = "files/urmatrans/sight_urmatrans_cargo_scrate.col",
		txd = "files/urmatrans/sight_urmatrans_cargo.txd"
	},
	["sight_urmatrans_cargo_sargadinnye"] = {
		type = "object",
		model = "object",
		dff = "files/urmatrans/sight_urmatrans_cargo_sargadinnye.dff",
		col = "files/urmatrans/sight_urmatrans_cargo_scrate.col",
		txd = "files/urmatrans/sight_urmatrans_cargo.txd"
	},
	["sight_urmatrans_shelf_fanta"] = {
		type = "object",
		model = "object",
		dff = "files/urmatrans/sight_urmatrans_shelf_fanta.dff",
		col = "files/urmatrans/sight_urmatrans_shelf_cargo.col",
		txd = "files/urmatrans/sight_urmatrans_cargo.txd"
	},
	["sight_urmatrans_cargo_fanta"] = {
		type = "object",
		model = "object",
		dff = "files/urmatrans/sight_urmatrans_cargo_fanta.dff",
		col = "files/urmatrans/sight_urmatrans_cargo_beerbox.col",
		txd = "files/urmatrans/sight_urmatrans_cargo.txd"
	},
	["sight_urmatrans_shelf_cocacola"] = {
		type = "object",
		model = "object",
		dff = "files/urmatrans/sight_urmatrans_shelf_cocacola.dff",
		col = "files/urmatrans/sight_urmatrans_shelf_cargo.col",
		txd = "files/urmatrans/sight_urmatrans_cargo.txd"
	},
	["sight_urmatrans_cargo_cocacola"] = {
		type = "object",
		model = "object",
		dff = "files/urmatrans/sight_urmatrans_cargo_cocacola.dff",
		col = "files/urmatrans/sight_urmatrans_cargo_beerbox.col",
		txd = "files/urmatrans/sight_urmatrans_cargo.txd"
	},
	["sight_urmatrans_shelf_pepsi"] = {
		type = "object",
		model = "object",
		dff = "files/urmatrans/sight_urmatrans_shelf_pepsi.dff",
		col = "files/urmatrans/sight_urmatrans_shelf_cargo.col",
		txd = "files/urmatrans/sight_urmatrans_cargo.txd"
	},
	["sight_urmatrans_cargo_pepsi"] = {
		type = "object",
		model = "object",
		dff = "files/urmatrans/sight_urmatrans_cargo_pepsi.dff",
		col = "files/urmatrans/sight_urmatrans_cargo_beerbox.col",
		txd = "files/urmatrans/sight_urmatrans_cargo.txd"
	},
	["sight_urmatrans_shelf_szkiralyi1"] = {
		type = "object",
		model = "object",
		dff = "files/urmatrans/sight_urmatrans_shelf_szkiralyi1.dff",
		col = "files/urmatrans/sight_urmatrans_shelf_cargo.col",
		txd = "files/urmatrans/sight_urmatrans_cargo.txd"
	},
	["sight_urmatrans_cargo_szkiralyi1"] = {
		type = "object",
		model = "object",
		dff = "files/urmatrans/sight_urmatrans_cargo_szkiralyi1.dff",
		col = "files/urmatrans/sight_urmatrans_cargo_beerbox.col",
		txd = "files/urmatrans/sight_urmatrans_cargo.txd",
		transparent = true
	},
	["sight_urmatrans_shelf_szkiralyi2"] = {
		type = "object",
		model = "object",
		dff = "files/urmatrans/sight_urmatrans_shelf_szkiralyi2.dff",
		col = "files/urmatrans/sight_urmatrans_shelf_cargo.col",
		txd = "files/urmatrans/sight_urmatrans_cargo.txd"
	},
	["sight_urmatrans_cargo_szkiralyi2"] = {
		type = "object",
		model = "object",
		dff = "files/urmatrans/sight_urmatrans_cargo_szkiralyi2.dff",
		col = "files/urmatrans/sight_urmatrans_cargo_beerbox.col",
		txd = "files/urmatrans/sight_urmatrans_cargo.txd",
		transparent = true
	},
	["sight_urmatrans_shelf_szkiralyi3"] = {
		type = "object",
		model = "object",
		dff = "files/urmatrans/sight_urmatrans_shelf_szkiralyi3.dff",
		col = "files/urmatrans/sight_urmatrans_shelf_cargo.col",
		txd = "files/urmatrans/sight_urmatrans_cargo.txd"
	},
	["sight_urmatrans_cargo_szkiralyi3"] = {
		type = "object",
		model = "object",
		dff = "files/urmatrans/sight_urmatrans_cargo_szkiralyi3.dff",
		col = "files/urmatrans/sight_urmatrans_cargo_beerbox.col",
		txd = "files/urmatrans/sight_urmatrans_cargo.txd",
		transparent = true
	},
	["sight_urmatrans_shelf_kobanyai"] = {
		type = "object",
		model = "object",
		dff = "files/urmatrans/sight_urmatrans_shelf_kobanyai.dff",
		col = "files/urmatrans/sight_urmatrans_shelf_cargo.col",
		txd = "files/urmatrans/sight_urmatrans_cargo.txd"
	},
	["sight_urmatrans_cargo_kobanyai"] = {
		type = "object",
		model = "object",
		dff = "files/urmatrans/sight_urmatrans_cargo_kobanyai.dff",
		col = "files/urmatrans/sight_urmatrans_shelf_cargo.col",
		txd = "files/urmatrans/sight_urmatrans_cargo.txd",
		transparent = true
	},
	["sight_urmatrans_shelf_soproni"] = {
		type = "object",
		model = "object",
		dff = "files/urmatrans/sight_urmatrans_shelf_soproni.dff",
		col = "files/urmatrans/sight_urmatrans_shelf_cargo.col",
		txd = "files/urmatrans/sight_urmatrans_cargo.txd"
	},
	["sight_urmatrans_cargo_soproni"] = {
		type = "object",
		model = "object",
		dff = "files/urmatrans/sight_urmatrans_cargo_soproni.dff",
		col = "files/urmatrans/sight_urmatrans_cargo_beerbox.col",
		txd = "files/urmatrans/sight_urmatrans_cargo.txd"
	},
	["sight_urmatrans_shelf_tokaji"] = {
		type = "object",
		model = "object",
		dff = "files/urmatrans/sight_urmatrans_shelf_tokaji.dff",
		col = "files/urmatrans/sight_urmatrans_shelf_cargo.col",
		txd = "files/urmatrans/sight_urmatrans_cargo.txd"
	},
	["sight_urmatrans_cargo_tokaji"] = {
		type = "object",
		model = "object",
		dff = "files/urmatrans/sight_urmatrans_cargo_tokaji.dff",
		col = "files/urmatrans/sight_urmatrans_cargo_beerbox.col",
		txd = "files/urmatrans/sight_urmatrans_cargo.txd"
	},
	["sight_urmatrans_shelf_soproni2"] = {
		type = "object",
		model = "object",
		dff = "files/urmatrans/sight_urmatrans_shelf_soproni2.dff",
		col = "files/urmatrans/sight_urmatrans_shelf_cargo.col",
		txd = "files/urmatrans/sight_urmatrans_cargo.txd"
	},
	["sight_urmatrans_cargo_soproni2"] = {
		type = "object",
		model = "object",
		dff = "files/urmatrans/sight_urmatrans_cargo_soproni2.dff",
		col = "files/urmatrans/sight_urmatrans_cargo_beerbox2.col",
		txd = "files/urmatrans/sight_urmatrans_cargo.txd"
	},
	["sight_urmatrans_shelf_somersby"] = {
		type = "object",
		model = "object",
		dff = "files/urmatrans/sight_urmatrans_shelf_somersby.dff",
		col = "files/urmatrans/sight_urmatrans_shelf_cargo.col",
		txd = "files/urmatrans/sight_urmatrans_cargo.txd"
	},
	["sight_urmatrans_cargo_somersby"] = {
		type = "object",
		model = "object",
		dff = "files/urmatrans/sight_urmatrans_cargo_somersby.dff",
		col = "files/urmatrans/sight_urmatrans_cargo_beerbox2.col",
		txd = "files/urmatrans/sight_urmatrans_cargo.txd"
	},
	["sight_urmatrans_shelf_hell"] = {
		type = "object",
		model = "object",
		dff = "files/urmatrans/sight_urmatrans_shelf_hell.dff",
		col = "files/urmatrans/sight_urmatrans_shelf_cargo.col",
		txd = "files/urmatrans/sight_urmatrans_cargo.txd"
	},
	["sight_urmatrans_cargo_hell"] = {
		type = "object",
		model = "object",
		dff = "files/urmatrans/sight_urmatrans_cargo_hell.dff",
		col = "files/urmatrans/sight_urmatrans_cargo_beerbox2.col",
		txd = "files/urmatrans/sight_urmatrans_cargo.txd"
	},
	["sight_urmatrans_shelf_pepsi2"] = {
		type = "object",
		model = "object",
		dff = "files/urmatrans/sight_urmatrans_shelf_pepsi2.dff",
		col = "files/urmatrans/sight_urmatrans_shelf_cargo.col",
		txd = "files/urmatrans/sight_urmatrans_cargo.txd"
	},
	["sight_urmatrans_cargo_pepsi2"] = {
		type = "object",
		model = "object",
		dff = "files/urmatrans/sight_urmatrans_cargo_pepsi2.dff",
		col = "files/urmatrans/sight_urmatrans_cargo_beerbox2.col",
		txd = "files/urmatrans/sight_urmatrans_cargo.txd"
	},
	["sight_urmatrans_shelf_nber"] = {
		type = "object",
		model = "object",
		dff = "files/urmatrans/sight_urmatrans_shelf_nber.dff",
		col = "files/urmatrans/sight_urmatrans_shelf_cargo.col",
		txd = "files/urmatrans/sight_urmatrans_cargo.txd"
	},
	["sight_urmatrans_cargo_nber"] = {
		type = "object",
		model = "object",
		dff = "files/urmatrans/sight_urmatrans_cargo_nber.dff",
		col = "files/urmatrans/sight_urmatrans_cargo_beerbox2.col",
		txd = "files/urmatrans/sight_urmatrans_cargo.txd"
	},
	["sight_urmatrans_shelf_redbull"] = {
		type = "object",
		model = "object",
		dff = "files/urmatrans/sight_urmatrans_shelf_redbull.dff",
		col = "files/urmatrans/sight_urmatrans_shelf_cargo.col",
		txd = "files/urmatrans/sight_urmatrans_cargo.txd"
	},
	["sight_urmatrans_cargo_redbull"] = {
		type = "object",
		model = "object",
		dff = "files/urmatrans/sight_urmatrans_cargo_redbull.dff",
		col = "files/urmatrans/sight_urmatrans_cargo_beerbox2.col",
		txd = "files/urmatrans/sight_urmatrans_cargo.txd"
	},
	["sight_portacabin"] = {
		type = "object",
		model = "object",
		dff = "files/urmatrans/sight_portacabin.dff",
		col = "files/urmatrans/sight_portacabin.col",
		txd = "files/urmatrans/sight_portacabin.txd"
	},
	["sight_portacabin_alpha"] = {
		type = "object",
		model = "object",
		dff = "files/urmatrans/sight_portacabin_alpha.dff",
		col = "files/urmatrans/sight_portacabin_alpha.col",
		txd = "files/urmatrans/sight_portacabin.txd",
		transparent = true
	},
	["sight_portacabin_props"] = {
		type = "object",
		model = "object",
		dff = "files/urmatrans/sight_portacabin_props.dff",
		col = "files/urmatrans/sight_portacabin_props.col",
		txd = "files/urmatrans/sight_portacabin.txd"
	},
	["sight_portacabin_door"] = {
		type = "object",
		model = "object",
		dff = "files/urmatrans/sight_portacabin_door.dff",
		col = "files/urmatrans/sight_portacabin_door.col",
		txd = "files/urmatrans/sight_portacabin.txd",
		dynamicDoor = true
	},
	["sight_urmatrans_cart"] = {
		type = "object",
		model = "object",
		dff = "files/urmatrans/sight_urmatrans_cart.dff",
		col = "files/urmatrans/sight_urmatrans_cart.col",
		txd = "files/urmatrans/sight_urmatrans_cart.txd"
	},
	["sight_urmatrans_cart2"] = {
		type = "object",
		model = "object",
		dff = "files/urmatrans/sight_urmatrans_cart2.dff",
		col = "files/urmatrans/sight_urmatrans_cart2.col",
		txd = "files/urmatrans/sight_urmatrans_cart.txd"
	},
	["SeeRing_01"] = {
		type = "object",
		model = 10817,
		dff = "files/SeeRing/SeeRing_01.dff",
		col = "files/SeeRing/SeeRing_01.col",
		txd = "files/SeeRing/SeeRing_main.txd",
		lodDistance = 300
	},
	["SeeRing_01_LOD"] = {
		type = "object",
		model = 10877,
		dff = "files/SeeRing/SeeRing_01_LOD.dff",
		col = "files/SeeRing/SeeRing_01.col",
		txd = "files/SeeRing/SeeRing_LOD.txd"
	},
	["SeeRing_02"] = {
		type = "object",
		model = 10816,
		dff = "files/SeeRing/SeeRing_02.dff",
		col = "files/SeeRing/SeeRing_02.col",
		txd = "files/SeeRing/SeeRing_main.txd",
		lodDistance = 300
	},
	["SeeRing_02_LOD"] = {
		type = "object",
		model = 10878,
		dff = "files/SeeRing/SeeRing_02_LOD.dff",
		col = "files/SeeRing/SeeRing_02.col",
		txd = "files/SeeRing/SeeRing_LOD.txd"
	},
	["SeeRing_03"] = {
		type = "object",
		model = 4340,
		dff = "files/SeeRing/SeeRing_03.dff",
		col = "files/SeeRing/SeeRing_03.col",
		txd = "files/SeeRing/SeeRing_main.txd",
		lodDistance = 300
	},
	["SeeRing_03_LOD"] = {
		type = "object",
		model = 4473,
		dff = "files/SeeRing/SeeRing_03_LOD.dff",
		col = "files/SeeRing/SeeRing_03.col",
		txd = "files/SeeRing/SeeRing_LOD.txd"
	},
	["SeeRing_04"] = {
		type = "object",
		model = 4336,
		dff = "files/SeeRing/SeeRing_04.dff",
		col = "files/SeeRing/SeeRing_04.col",
		txd = "files/SeeRing/SeeRing_main.txd",
		lodDistance = 300
	},
	["SeeRing_04_LOD"] = {
		type = "object",
		model = 4469,
		dff = "files/SeeRing/SeeRing_04_LOD.dff",
		col = "files/SeeRing/SeeRing_04.col",
		txd = "files/SeeRing/SeeRing_LOD.txd"
	},
	["SeeRing_05"] = {
		type = "object",
		model = 10819,
		dff = "files/SeeRing/SeeRing_05.dff",
		col = "files/SeeRing/SeeRing_05.col",
		txd = "files/SeeRing/SeeRing_main.txd",
		lodDistance = 300
	},
	["SeeRing_05_LOD"] = {
		type = "object",
		model = 10881,
		dff = "files/SeeRing/SeeRing_05_LOD.dff",
		col = "files/SeeRing/SeeRing_05.col",
		txd = "files/SeeRing/SeeRing_LOD.txd"
	},
	["SeeRing_06"] = {
		type = "object",
		model = 10768,
		dff = "files/SeeRing/SeeRing_06.dff",
		col = "files/SeeRing/SeeRing_06.col",
		txd = "files/SeeRing/SeeRing_main.txd",
		lodDistance = 300
	},
	["SeeRing_06_LOD"] = {
		type = "object",
		model = 10882,
		dff = "files/SeeRing/SeeRing_06_LOD.dff",
		col = "files/SeeRing/SeeRing_06.col",
		txd = "files/SeeRing/SeeRing_LOD.txd"
	},
	["SeeRing_07"] = {
		type = "object",
		model = 10818,
		dff = "files/SeeRing/SeeRing_07.dff",
		col = "files/SeeRing/SeeRing_07.col",
		txd = "files/SeeRing/SeeRing_main.txd",
		lodDistance = 300
	},
	["SeeRing_07_LOD"] = {
		type = "object",
		model = 10876,
		dff = "files/SeeRing/SeeRing_07_LOD.dff",
		col = "files/SeeRing/SeeRing_07.col",
		txd = "files/SeeRing/SeeRing_LOD.txd"
	},
	["SeeRing_08"] = {
		type = "object",
		model = 10756,
		dff = "files/SeeRing/SeeRing_08.dff",
		col = "files/SeeRing/SeeRing_08.col",
		txd = "files/SeeRing/SeeRing_main.txd",
		lodDistance = 300
	},
	["SeeRing_08_LOD"] = {
		type = "object",
		model = 10924,
		dff = "files/SeeRing/SeeRing_08_LOD.dff",
		col = "files/SeeRing/SeeRing_08.col",
		txd = "files/SeeRing/SeeRing_LOD.txd"
	},
	["SeeRing_08_fix"] = {
		type = "object",
		model = "object",
		dff = "files/SeeRing/SeeRing_08_fix.dff",
		col = "files/SeeRing/SeeRing_08_fix.col",
		txd = "files/SeeRing/SeeRing_main.txd"
	},
	["SeeRing_01_alpha"] = {
		type = "object",
		model = "object",
		dff = "files/SeeRing/SeeRing_01_alpha.dff",
		col = "files/SeeRing/SeeRing_01_alpha.col",
		txd = "files/SeeRing/SeeRing_alpha.txd",
		transparent = true,
		lodDistance = 500
	},
	["SeeRing_02_alpha"] = {
		type = "object",
		model = "object",
		dff = "files/SeeRing/SeeRing_02_alpha.dff",
		col = "files/SeeRing/SeeRing_02_alpha.col",
		txd = "files/SeeRing/SeeRing_alpha.txd",
		transparent = true,
		lodDistance = 500
	},
	["SeeRing_03_alpha"] = {
		type = "object",
		model = "object",
		dff = "files/SeeRing/SeeRing_03_alpha.dff",
		col = "files/SeeRing/SeeRing_03_alpha.col",
		txd = "files/SeeRing/SeeRing_alpha.txd",
		transparent = true,
		lodDistance = 500
	},
	["SeeRing_04_alpha"] = {
		type = "object",
		model = "object",
		dff = "files/SeeRing/SeeRing_04_alpha.dff",
		col = "files/SeeRing/SeeRing_04_alpha.col",
		txd = "files/SeeRing/SeeRing_alpha.txd",
		transparent = true,
		lodDistance = 500
	},
	["SeeRing_05_alpha"] = {
		type = "object",
		model = "object",
		dff = "files/SeeRing/SeeRing_05_alpha.dff",
		col = "files/SeeRing/SeeRing_05_alpha.col",
		txd = "files/SeeRing/SeeRing_alpha.txd",
		transparent = true,
		lodDistance = 500
	},
	["SeeRing_06_alpha"] = {
		type = "object",
		model = "object",
		dff = "files/SeeRing/SeeRing_06_alpha.dff",
		col = "files/SeeRing/SeeRing_06_alpha.col",
		txd = "files/SeeRing/SeeRing_alpha.txd",
		transparent = true,
		lodDistance = 500
	},
	["SeeRing_07_alpha"] = {
		type = "object",
		model = "object",
		dff = "files/SeeRing/SeeRing_07_alpha.dff",
		col = "files/SeeRing/SeeRing_07_alpha.col",
		txd = "files/SeeRing/SeeRing_alpha.txd",
		transparent = true,
		lodDistance = 500
	},
	["SeeRing_08_alpha"] = {
		type = "object",
		model = "object",
		dff = "files/SeeRing/SeeRing_08_alpha.dff",
		col = "files/SeeRing/SeeRing_08_alpha.col",
		txd = "files/SeeRing/SeeRing_alpha.txd",
		transparent = true,
		lodDistance = 500
	},
	["SeeRing_carpark"] = {
		type = "object",
		model = "object",
		dff = "files/SeeRing/SeeRing_carpark.dff",
		col = "files/SeeRing/SeeRing_carpark.col",
		txd = "files/SeeRing/SeeRing_carpark.txd",
		lodDistance = 300
	},
	["SeeRing_carpark_props"] = {
		type = "object",
		model = "object",
		dff = "files/SeeRing/SeeRing_carpark_props.dff",
		col = "files/SeeRing/SeeRing_carpark_props.col",
		txd = "files/SeeRing/SeeRing_carpark.txd"
	},
	["SeeRing_carpark_LOD"] = {
		type = "object",
		model = "object",
		dff = "files/SeeRing/SeeRing_carpark_LOD.dff",
		col = "files/SeeRing/SeeRing_carpark.col",
		txd = "files/SeeRing/SeeRing_carpark_LOD.txd",
		lodDistance = 30000
	},
	["SeeRing_logo"] = {
		type = "object",
		model = "object",
		dff = "files/SeeRing/SeeRing_logo.dff",
		col = "files/SeeRing/SeeRing_logo.col",
		txd = "files/SeeRing/SeeRing_main.txd",
		lodDistance = 300
	},
	["SeeRing_bleacher"] = {
		type = "object",
		model = "object",
		dff = "files/SeeRing/SeeRing_bleacher.dff",
		col = "files/SeeRing/SeeRing_bleacher.col",
		txd = "files/SeeRing/SeeRing_main.txd",
		lodDistance = 100
	},
	["SeeRing_bleacher_LOD"] = {
		type = "object",
		model = "object",
		dff = "files/SeeRing/SeeRing_bleacher_LOD.dff",
		col = "files/SeeRing/SeeRing_bleacher.col",
		txd = "files/SeeRing/SeeRing_LOD.txd",
		lodDistance = 30000
	},
	["SeeRing_bleacher2"] = {
		type = "object",
		model = "object",
		dff = "files/SeeRing/SeeRing_bleacher2.dff",
		col = "files/SeeRing/SeeRing_bleacher2.col",
		txd = "files/SeeRing/SeeRing_main.txd",
		lodDistance = 100
	},
	["SeeRing_bleacher2_LOD"] = {
		type = "object",
		model = "object",
		dff = "files/SeeRing/SeeRing_bleacher2_LOD.dff",
		col = "files/SeeRing/SeeRing_bleacher2.col",
		txd = "files/SeeRing/SeeRing_LOD.txd",
		lodDistance = 30000
	},
	["SeeRing_bleacher_seats"] = {
		type = "object",
		model = "object",
		dff = "files/SeeRing/SeeRing_bleacher_seats.dff",
		col = "files/SeeRing/SeeRing_bleacher_seats.col",
		txd = "files/SeeRing/SeeRing_main.txd",
		lodDistance = 100
	},
	["SeeRing_tirewall1"] = {
		type = "object",
		model = "object",
		dff = "files/SeeRing/SeeRing_tirewall1.dff",
		col = "files/SeeRing/SeeRing_tirewall1.col",
		txd = "files/SeeRing/SeeRing_main.txd",
		lodDistance = 300
	},
	["SeeRing_tirewall2"] = {
		type = "object",
		model = "object",
		dff = "files/SeeRing/SeeRing_tirewall2.dff",
		col = "files/SeeRing/SeeRing_tirewall2.col",
		txd = "files/SeeRing/SeeRing_main.txd",
		lodDistance = 300
	},
	["SeeRing_PitBuilding"] = {
		type = "object",
		model = "object",
		dff = "files/SeeRing/SeeRing_PitBuilding.dff",
		col = "files/SeeRing/SeeRing_PitBuilding.col",
		txd = "files/SeeRing/SeeRing_main.txd",
		lodDistance = 500
	},
	["SeeRing_PitBuilding_LOD"] = {
		type = "object",
		model = "object",
		dff = "files/SeeRing/SeeRing_PitBuilding_LOD.dff",
		col = "files/SeeRing/SeeRing_PitBuilding.col",
		txd = "files/SeeRing/SeeRing_PitBuilding_LOD.txd",
		lodDistance = 30000
	},
	["SeeRing_PitBuilding_stairs"] = {
		type = "object",
		model = "object",
		dff = "files/SeeRing/SeeRing_PitBuilding_stairs.dff",
		col = "files/SeeRing/SeeRing_PitBuilding_stairs.col",
		txd = "files/SeeRing/SeeRing_main.txd",
		transparent = true
	},
	["v4_seering_garagedoor"] = {
		type = "object",
		model = 3892,
		dff = "files/SeeRing/v4_seering_garagedoor.dff",
		col = "files/SeeRing/v4_seering_garagedoor.col",
		txd = "files/SeeRing/SeeRing_main.txd"
	},
	["SeeRing_overpass"] = {
		type = "object",
		model = "object",
		dff = "files/SeeRing/SeeRing_overpass.dff",
		col = "files/SeeRing/SeeRing_overpass.col",
		txd = "files/SeeRing/SeeRing_main.txd",
		lodDistance = 300
	},
	["SeeRing_overpass_fence"] = {
		type = "object",
		model = "object",
		dff = "files/SeeRing/SeeRing_overpass_fence.dff",
		col = "files/SeeRing/SeeRing_overpass_fence.col",
		txd = "files/SeeRing/SeeRing_alpha.txd",
		transparent = true,
		lodDistance = 150
	},
	["SeeRing_PitFurnitures"] = {
		type = "object",
		model = "object",
		dff = "files/SeeRing/SeeRing_PitFurnitures.dff",
		col = "files/SeeRing/SeeRing_PitFurnitures.col",
		txd = "files/SeeRing/SeeRing_Pit.txd",
		lodDistance = 150
	},
	["SeeRing_tirebridge"] = {
		type = "object",
		model = "object",
		dff = "files/SeeRing/SeeRing_tirebridge.dff",
		col = "files/SeeRing/SeeRing_tirebridge.col",
		txd = "files/SeeRing/SeeRing_main.txd",
		lodDistance = 150
	},
	["SeeRing_tirebridge_LOD"] = {
		type = "object",
		model = "object",
		dff = "files/SeeRing/SeeRing_tirebridge_LOD.dff",
		col = "files/SeeRing/SeeRing_tirebridge.col",
		txd = "files/SeeRing/SeeRing_LOD.txd",
		lodDistance = 10000
	},
	["SeeRing_scoreboard"] = {
		type = "object",
		model = "object",
		dff = "files/SeeRing/SeeRing_scoreboard.dff",
		txd = "files/SeeRing/SeeRing_main.txd",
		col = "files/SeeRing/SeeRing_scoreboard.col",
		lodDistance = 250
	},
	["SeeRing_drag_scoreboard"] = {
		type = "object",
		model = "object",
		dff = "files/SeeRing/SeeRing_drag_scoreboard.dff",
		txd = "files/SeeRing/SeeRing_main.txd",
		col = "files/SeeRing/SeeRing_drag_scoreboard.col",
		lodDistance = 250
	},
	["SeeRing_drag_scoreboard2"] = {
		type = "object",
		model = "object",
		dff = "files/SeeRing/SeeRing_drag_scoreboard2.dff",
		txd = "files/SeeRing/SeeRing_main.txd",
		col = "files/SeeRing/SeeRing_drag_scoreboard.col",
		lodDistance = 250
	},
	["SeeRing_roadsign1"] = {
		type = "object",
		model = "object",
		dff = "files/SeeRing/SeeRing_roadsign1.dff",
		txd = "files/SeeRing/SeeRing_roadsign.txd",
		col = "files/SeeRing/SeeRing_roadsign.col",
		lodDistance = 250
	},
	["SeeRing_roadsign2"] = {
		type = "object",
		model = "object",
		dff = "files/SeeRing/SeeRing_roadsign2.dff",
		txd = "files/SeeRing/SeeRing_roadsign.txd",
		col = "files/SeeRing/SeeRing_roadsign.col",
		lodDistance = 250
	},
	["SeeRing_roadsign3"] = {
		type = "object",
		model = "object",
		dff = "files/SeeRing/SeeRing_roadsign3.dff",
		txd = "files/SeeRing/SeeRing_roadsign.txd",
		col = "files/SeeRing/SeeRing_roadsign.col",
		lodDistance = 250
	},
	["SeeRing_roadsign4"] = {
		type = "object",
		model = "object",
		dff = "files/SeeRing/SeeRing_roadsign4.dff",
		txd = "files/SeeRing/SeeRing_roadsign.txd",
		col = "files/SeeRing/SeeRing_roadsign.col",
		lodDistance = 250
	},
	["SeeRing_roadsign5"] = {
		type = "object",
		model = "object",
		dff = "files/SeeRing/SeeRing_roadsign5.dff",
		txd = "files/SeeRing/SeeRing_roadsign.txd",
		col = "files/SeeRing/SeeRing_roadsign.col",
		lodDistance = 250
	},
	["SeeRing_startgrid"] = {
		type = "object",
		model = "object",
		dff = "files/SeeRing/SeeRing_startgrid.dff",
		txd = "files/SeeRing/SeeRing_main.txd",
		col = "files/SeeRing/SeeRing_startgrid.col",
		lodDistance = 200,
		transparent = true
	},
	["gazebo_suchs"] = {
		type = "object",
		model = "object",
		dff = "files/SeeRing/gazebo_suchs.dff",
		col = "files/SeeRing/gazebo.col",
		txd = "files/SeeRing/gazebo.txd",
		lodDistance = 150
	},
	["gazebo_motul"] = {
		type = "object",
		model = "object",
		dff = "files/SeeRing/gazebo_motul.dff",
		col = "files/SeeRing/gazebo.col",
		txd = "files/SeeRing/gazebo.txd",
		lodDistance = 150
	},
	["gazebo_martini"] = {
		type = "object",
		model = "object",
		dff = "files/SeeRing/gazebo_martini.dff",
		col = "files/SeeRing/gazebo.col",
		txd = "files/SeeRing/gazebo.txd",
		lodDistance = 150
	},
	["gazebo_seenix"] = {
		type = "object",
		model = "object",
		dff = "files/SeeRing/gazebo_seenix.dff",
		col = "files/SeeRing/gazebo.col",
		txd = "files/SeeRing/gazebo.txd",
		lodDistance = 150
	},
	["CE_ground08"] = {
		type = "object",
		model = 12969,
		dff = "files/SeeRing/CE_ground08.dff",
		col = "files/SeeRing/CE_ground08.col",
		txd = "files/SeeRing/SF_roundabout.txd"
	},
	["CE_ground08_LOD"] = {
		type = "object",
		model = 13458,
		dff = "files/SeeRing/CE_ground08_LOD.dff",
		col = "files/SeeRing/CE_ground08.col",
		txd = "files/SeeRing/SF_roundaboutLOD.txd"
	},
	["counte_roads34"] = {
		type = "object",
		model = 12874,
		dff = "files/SeeRing/counte_roads34.dff",
		txd = "files/SeeRing/SF_roundabout.txd"
	},
	["sbseabed_05_SFSe"] = {
		type = "object",
		model = 4335,
		dff = "files/SeeRing/sbseabed_05_SFSe.dff",
		txd = "files/SeeRing/SeeRing_main.txd"
	},
	["roadsSFSE02"] = {
		type = "object",
		model = 10751,
		dff = "files/SeeRing/roadsSFSE02.dff",
		col = "files/SeeRing/roadsSFSE02.col",
		txd = "files/SeeRing/SF_roundabout.txd"
	},
	["LODroadsSFSE02"] = {
		type = "object",
		model = 10798,
		dff = "files/SeeRing/LODroadsSFSE02.dff",
		col = "files/SeeRing/roadsSFSE02.col",
		txd = "files/SeeRing/SF_roundaboutLOD.txd"
	},
	["cuntwland03b"] = {
		type = "object",
		model = 17078,
		dff = "files/SeeRing/cuntwland03b.dff",
		col = "files/SeeRing/cuntwland03b.col",
		txd = "files/SeeRing/SF_roundabout.txd",
		lodDistance = 300
	},
	["LODcuntwland03b"] = {
		type = "object",
		model = 17358,
		dff = "files/SeeRing/LODcuntwland03b.dff",
		col = "files/SeeRing/cuntwland03b.col",
		txd = "files/SeeRing/SF_roundaboutLOD.txd"
	},
	["cuntwland02c"] = {
		type = "object",
		model = 17308,
		dff = "files/SeeRing/cuntwland02c.dff",
		col = "files/SeeRing/cuntwland02c.col",
		txd = "files/SeeRing/SF_roundabout.txd"
	},
	["LODcuntwland02c"] = {
		type = "object",
		model = 17207,
		dff = "files/SeeRing/LODcuntwland02c.dff",
		col = "files/SeeRing/cuntwland02c.col",
		txd = "files/SeeRing/SF_roundaboutLOD.txd"
	},
	["roadsSFSE07"] = {
		type = "object",
		model = 10848,
		dff = "files/SeeRing/roadsSFSE07.dff",
		col = "files/SeeRing/roadsSFSE07.col",
		txd = "files/SeeRing/SF_roundabout.txd"
	},
	["cuntwroad74"] = {
		type = "object",
		model = 17208,
		dff = "files/SeeRing/cuntwroad74.dff",
		col = "files/SeeRing/cuntwroad74.col",
		txd = "files/SeeRing/SF_roundabout.txd"
	},
	["LODcuntwroad74"] = {
		type = "object",
		model = 17209,
		dff = "files/SeeRing/LODcuntwroad74.dff",
		col = "files/SeeRing/cuntwroad74.col",
		txd = "files/SeeRing/SF_roundaboutLOD.txd"
	},
	["landy2"] = {
		type = "object",
		model = 11107,
		dff = "files/SeeRing/landy2.dff",
		col = "files/SeeRing/landy2.col",
		txd = "files/SeeRing/SF_roundabout.txd"
	},
	["LODlandy2"] = {
		type = "object",
		model = 11108,
		dff = "files/SeeRing/LODlandy2.dff",
		col = "files/SeeRing/landy2.col",
		txd = "files/SeeRing/SF_roundaboutLOD.txd"
	},
	["sfseland02"] = {
		type = "object",
		model = 10851,
		dff = "files/SeeRing/sfseland02.dff",
		col = "files/SeeRing/sfseland02.col",
		txd = "files/SeeRing/SF_roundabout.txd"
	},
	["sf_landbut02"] = {
		type = "object",
		model = 10903,
		dff = "files/SeeRing/sf_landbut02.dff",
		col = "files/SeeRing/sf_landbut02.col",
		txd = "files/SeeRing/SF_roundabout.txd"
	},
	["farm:crate"] = {type = "object", model = 1355},
	["farm:crate2"] = {
		type = "object",
		model = 3917,
		dff = "files/farm/crate2.dff",
		txd = "files/farm/v4_farm.txd"
	},
	["farm:kanna"] = {
		type = "object",
		model = 3900,
		dff = "files/farm/kanna.dff",
		txd = "files/farm/v4_farm.txd"
	},
	["farm:hoe"] = {
		type = "object",
		model = "object",
		dff = "files/farm/hoe.dff",
		col = "files/farm/hoe.col",
		txd = "files/farm/v4_farm.txd"
	},
	["farm:minihoe"] = {
		type = "object",
		model = "object",
		dff = "files/farm/minihoe.dff",
		col = "files/farm/minihoe.col",
		txd = "files/farm/v4_farm.txd"
	},
	["farm:inti_kicsi"] = {
		type = "object",
		model = "object",
		dff = "files/farm/inti_kicsi.dff",
		col = "files/farm/inti_kicsi.col",
		txd = "files/farm/v4_farm.txd"
	},
	["farm:exterior_5"] = {
		type = "object",
		model = "object",
		dff = "files/farm/exterior_5.dff",
		col = "files/farm/exterior_5.col",
		txd = "files/farm/v4_farm.txd",
		lodDistance = 150
	},
	["farm:exterior_5_LOD"] = {
		type = "object",
		model = "object",
		dff = "files/farm/exterior_5_LOD.dff",
		txd = "files/farm/v4_farm.txd",
		lodDistance = 1000
	},
	["farm:exterior_10"] = {
		type = "object",
		model = "object",
		dff = "files/farm/exterior_10.dff",
		col = "files/farm/exterior_10.col",
		txd = "files/farm/v4_farm.txd",
		lodDistance = 150
	},
	["farm:exterior_10_LOD"] = {
		type = "object",
		model = "object",
		dff = "files/farm/exterior_10_LOD.dff",
		txd = "files/farm/v4_farm.txd",
		lodDistance = 1000
	},
	["farm:exterior_15"] = {
		type = "object",
		model = "object",
		dff = "files/farm/exterior_15.dff",
		col = "files/farm/exterior_15.col",
		txd = "files/farm/v4_farm.txd",
		lodDistance = 150
	},
	["farm:exterior_15_LOD"] = {
		type = "object",
		model = "object",
		dff = "files/farm/exterior_15_LOD.dff",
		txd = "files/farm/v4_farm.txd",
		lodDistance = 1000
	},
	["farm:egg"] = {
		type = "object",
		model = "object",
		dff = "files/farm/egg.dff",
		txd = "files/farm/v4_farm.txd"
	},
	["farm:egg_crate"] = {
		type = "object",
		model = "object",
		dff = "files/farm/egg_crate.dff",
		col = "files/farm/egg_crate.col",
		txd = "files/farm/v4_farm.txd"
	},
	["farm:v4_egg_holder"] = {
		type = "object",
		model = "object",
		dff = "files/farm/v4_egg_holder.dff",
		col = "files/farm/v4_egg_holder.col",
		txd = "files/farm/v4_farm.txd"
	},
	["farm:milk_crate"] = {
		type = "object",
		model = "object",
		dff = "files/farm/milk_crate.dff",
		col = "files/farm/milk_crate.col",
		txd = "files/farm/v4_farm.txd"
	},
	["farm:animaldoor"] = {
		type = "object",
		model = "object",
		dff = "files/farm/animaldoor.dff",
		col = "files/farm/animaldoor.col",
		txd = "files/farm/v4_farm.txd"
	},
	["farm:bucket"] = {
		type = "object",
		model = 3890,
		dff = "files/farm/bucket.dff",
		col = "files/farm/bucket.col",
		txd = "files/farm/v4_farm.txd"
	},
	["farm:bucket_csirketap"] = {
		type = "object",
		model = "object",
		dff = "files/farm/bucket_csirketap.dff",
		txd = "files/farm/v4_farm.txd"
	},
	["farm:bucket_milk"] = {
		type = "object",
		model = "object",
		dff = "files/farm/bucket_milk.dff",
		txd = "files/farm/v4_farm.txd"
	},
	["farm:bucket_pellet"] = {
		type = "object",
		model = "object",
		dff = "files/farm/bucket_pellet.dff",
		txd = "files/farm/v4_farm.txd"
	},
	["farm:bucket_water"] = {
		type = "object",
		model = "object",
		dff = "files/farm/bucket_water.dff",
		txd = "files/farm/v4_farm.txd"
	},
	["farm:feed_bag"] = {
		type = "object",
		model = "object",
		dff = "files/farm/feed_bag.dff",
		col = "files/farm/feed_bag.col",
		txd = "files/farm/v4_farm.txd"
	},
	["farm:chicken_feed_bag"] = {
		type = "object",
		model = "object",
		dff = "files/farm/chicken_feed_bag.dff",
		col = "files/farm/chicken_feed_bag.col",
		txd = "files/farm/v4_farm.txd"
	},
	["farm:animalfarm"] = {
		type = "object",
		model = "object",
		dff = "files/farm/animalfarm.dff",
		col = "files/farm/animalfarm.col",
		txd = "files/farm/v4_farm.txd"
	},
	["farm:csirketap"] = {
		type = "object",
		model = "object",
		dff = "files/farm/csirketap.dff",
		txd = "files/farm/v4_farm.txd"
	},
	["farm:valyupellet"] = {
		type = "object",
		model = "object",
		dff = "files/farm/valyupellet.dff",
		txd = "files/farm/v4_farm.txd"
	},
	["farm:csirke_eteto"] = {
		type = "object",
		model = "object",
		dff = "files/farm/csirke_eteto.dff",
		col = "files/farm/csirke_eteto.col",
		txd = "files/farm/v4_farm.txd"
	},
	["farm:csirke_itato"] = {
		type = "object",
		model = "object",
		dff = "files/farm/csirke_itato.dff",
		col = "files/farm/csirke_itato.col",
		txd = "files/farm/v4_farm.txd"
	},
	["farm:valyu"] = {
		type = "object",
		model = "object",
		dff = "files/farm/valyu.dff",
		col = "files/farm/valyu.col",
		txd = "files/farm/v4_farm.txd"
	},
	["farm:pitchfork"] = {
		type = "object",
		model = "object",
		dff = "files/farm/pitchfork.dff",
		col = "files/farm/pitchfork.col",
		txd = "files/farm/v4_farm.txd"
	},
	["farm:pitchfork_loaded"] = {
		type = "object",
		model = "object",
		dff = "files/farm/pitchfork_loaded.dff",
		txd = "files/farm/v4_farm.txd"
	},
	["farm:pitchfork_loaded_manure"] = {
		type = "object",
		model = "object",
		dff = "files/farm/pitchfork_loaded_manure.dff",
		txd = "files/farm/v4_farm.txd"
	},
	["farm:v4_sheep_shearer"] = {
		type = "object",
		model = "object",
		dff = "files/farm/v4_sheep_shearer.dff",
		txd = "files/farm/v4_sheep_shearer.txd"
	},
	["farm:bale"] = {
		type = "object",
		model = "object",
		dff = "files/farm/bale.dff",
		col = "files/farm/bale.col",
		txd = "files/farm/v4_farm.txd"
	},
	["farm:furik"] = {
		type = "object",
		model = 3910,
		dff = "files/farm/furik.dff",
		col = "files/farm/furik.col",
		txd = "files/farm/v4_farm.txd"
	},
	["farm:furik_wheel"] = {
		type = "object",
		model = "object",
		dff = "files/farm/furik_wheel.dff",
		txd = "files/farm/v4_farm.txd"
	},
	["farm:furik_manure"] = {
		type = "object",
		model = "object",
		dff = "files/farm/furik_manure.dff",
		txd = "files/farm/v4_farm.txd"
	},
	["farm:farm_compost"] = {
		type = "object",
		model = 1246,
		dff = "files/farm/farm_compost.dff",
		col = "files/farm/farm_compost.col",
		txd = "files/farm/v4_farm.txd"
	},
	["farm:plants/Tokok/palanta"] = {
		type = "object",
		model = "object",
		dff = "files/farm/plants/Tokok/palanta.dff",
		txd = "files/farm/plants/Tokok/palanta.txd"
	},
	["farm:plants/Tokok/sutotok"] = {
		type = "object",
		model = "object",
		dff = "files/farm/plants/Tokok/sutotok.dff",
		txd = "files/farm/plants/Tokok/sutotok.txd"
	},
	["farm:plants/Uborka/iborka_szar"] = {
		type = "object",
		model = "object",
		dff = "files/farm/plants/Uborka/iborka_szar.dff",
		txd = "files/farm/plants/Uborka/iborka_szar.txd"
	},
	["farm:plants/Uborka/iborka_termes"] = {
		type = "object",
		model = "object",
		dff = "files/farm/plants/Uborka/iborka_termes.dff",
		txd = "files/farm/plants/Uborka/iborka_termes.txd"
	},
	["farm:plants/Kaposzta/kaposzta"] = {
		type = "object",
		model = "object",
		dff = "files/farm/plants/Kaposzta/kaposzta.dff",
		txd = "files/farm/plants/Kaposzta/kaposzta.txd"
	},
	["farm:plants/Karalabe/karalabe"] = {
		type = "object",
		model = "object",
		dff = "files/farm/plants/Karalabe/karalabe.dff",
		txd = "files/farm/plants/Karalabe/karalabe.txd"
	},
	["farm:plants/Lilahagyma/lilahagyma_szar"] = {
		type = "object",
		model = "object",
		dff = "files/farm/plants/Lilahagyma/lilahagyma_szar.dff",
		txd = "files/farm/plants/Lilahagyma/lilahagyma_szar.txd"
	},
	["farm:plants/Lilahagyma/lilahagyma_termes"] = {
		type = "object",
		model = "object",
		dff = "files/farm/plants/Lilahagyma/lilahagyma_termes.dff",
		txd = "files/farm/plants/Lilahagyma/lilahagyma_termes.txd"
	},
	["farm:plants/Voroshagyma/voroshagyma_szar"] = {
		type = "object",
		model = "object",
		dff = "files/farm/plants/Voroshagyma/voroshagyma_szar.dff",
		txd = "files/farm/plants/Voroshagyma/voroshagyma_szar.txd"
	},
	["farm:plants/Voroshagyma/voroshagyma_termes"] = {
		type = "object",
		model = "object",
		dff = "files/farm/plants/Voroshagyma/voroshagyma_termes.dff",
		txd = "files/farm/plants/Voroshagyma/voroshagyma_termes.txd"
	},
	["farm:plants/Paprika/paprika_bokor"] = {
		type = "object",
		model = "object",
		dff = "files/farm/plants/Paprika/paprika_bokor.dff",
		txd = "files/farm/plants/Paprika/paprika_bokor.txd"
	},
	["farm:plants/Paprika/paprika_tv"] = {
		type = "object",
		model = "object",
		dff = "files/farm/plants/Paprika/paprika_tv.dff",
		txd = "files/farm/plants/Paprika/paprika_tv.txd"
	},
	["farm:plants/Paprika/paprika_chili"] = {
		type = "object",
		model = "object",
		dff = "files/farm/plants/Paprika/paprika_chili.dff",
		txd = "files/farm/plants/Paprika/paprika_chili.txd"
	},
	["farm:plants/Paprika/paprika_alma"] = {
		type = "object",
		model = "object",
		dff = "files/farm/plants/Paprika/paprika_alma.dff",
		txd = "files/farm/plants/Paprika/paprika_alma.txd"
	},
	["farm:plants/Petrezselyem/petrezselyem_szar"] = {
		type = "object",
		model = "object",
		dff = "files/farm/plants/Petrezselyem/petrezselyem_szar.dff",
		txd = "files/farm/plants/Petrezselyem/petrezselyem_szar.txd"
	},
	["farm:plants/Petrezselyem/petrezselyem_termes"] = {
		type = "object",
		model = "object",
		dff = "files/farm/plants/Petrezselyem/petrezselyem_termes.dff",
		txd = "files/farm/plants/Petrezselyem/petrezselyem_termes.txd"
	},
	["farm:plants/Repa/repa_szar"] = {
		type = "object",
		model = "object",
		dff = "files/farm/plants/Repa/repa_szar.dff",
		txd = "files/farm/plants/Repa/repa_szar.txd"
	},
	["farm:plants/Repa/repa_termes"] = {
		type = "object",
		model = "object",
		dff = "files/farm/plants/Repa/repa_termes.dff",
		txd = "files/farm/plants/Repa/repa_termes.txd"
	},
	["farm:plants/Retek/retek_szar"] = {
		type = "object",
		model = "object",
		dff = "files/farm/plants/Retek/retek_szar.dff",
		txd = "files/farm/plants/Retek/retek_szar.txd"
	},
	["farm:plants/Retek/retek_termes"] = {
		type = "object",
		model = "object",
		dff = "files/farm/plants/Retek/retek_termes.dff",
		txd = "files/farm/plants/Retek/retek_termes.txd"
	},
	["farm:plants/Salata/salata"] = {
		type = "object",
		model = "object",
		dff = "files/farm/plants/Salata/salata.dff",
		txd = "files/farm/plants/Salata/salata.txd"
	},
	["farm:plants/Dinnyek/palanta"] = {
		type = "object",
		model = "object",
		dff = "files/farm/plants/Dinnyek/palanta.dff",
		txd = "files/farm/plants/Dinnyek/palanta.txd"
	},
	["farm:plants/Dinnyek/gorogdinnye"] = {
		type = "object",
		model = "object",
		dff = "files/farm/plants/Dinnyek/gorogdinnye.dff",
		txd = "files/farm/plants/Dinnyek/gorogdinnye.txd"
	},
	["farm:plants/Dinnyek/sargadinnye"] = {
		type = "object",
		model = "object",
		dff = "files/farm/plants/Dinnyek/sargadinnye.dff",
		txd = "files/farm/plants/Dinnyek/sargadinnye.txd"
	},
	["farm:plants/parazen/szar"] = {
		type = "object",
		model = "object",
		dff = "files/farm/plants/parazen/parazen_szar.dff",
		txd = "files/farm/plants/parazen/parazen_szar.txd"
	},
	["farm:plants/parazen/virag"] = {
		type = "object",
		model = "object",
		dff = "files/farm/plants/parazen/parazen_virag.dff",
		txd = "files/farm/plants/parazen/parazen_virag.txd"
	},
	["farm:mak"] = {
		type = "object",
		model = "object",
		dff = "files/farm/mak.dff",
		txd = "files/farm/v4_farm.txd"
	},
	["farm:marihuana"] = {
		type = "object",
		model = "object",
		dff = "files/farm/marihuana.dff",
		txd = "files/farm/v4_farm.txd",
		transparent = true
	},
	["farm:magic_mushroom"] = {
		type = "object",
		model = "object",
		dff = "files/farm/magic_mushroom.dff",
		txd = "files/farm/v4_farm.txd"
	},
	["farm:kokacserje"] = {
		type = "object",
		model = "object",
		dff = "files/farm/kokacserje.dff",
		txd = "files/farm/v4_farm.txd"
	},
	["farm:v4_market_wool"] = {
		type = "object",
		model = "object",
		dff = "files/farm/v4_market_wool.dff",
		col = "files/farm/v4_market_wool.col",
		txd = "files/farm/v4_market_wool.txd"
	},
	["farm:chicken"] = {
		type = "skin",
		model = "ped",
		dff = "files/farm/animals/chicken.dff",
		txd = "files/farm/animals/chicken.txd"
	},
	["farm:cow"] = {
		type = "skin",
		model = "ped",
		dff = "files/farm/animals/cow.dff",
		txd = "files/farm/animals/cow.txd"
	},
	["farm:goat"] = {
		type = "skin",
		model = "ped",
		dff = "files/farm/animals/goat.dff",
		txd = "files/farm/animals/goat.txd"
	},
	["farm:pig"] = {
		type = "skin",
		model = "ped",
		dff = "files/farm/animals/pig.dff",
		txd = "files/farm/animals/pig.txd"
	},
	["farm:sheep"] = {
		type = "skin",
		model = "ped",
		dff = "files/farm/animals/sheep.dff",
		txd = "files/farm/animals/sheep.txd"
	},
	["farm:silicon09a_sfs"] = {
		type = "object",
		model = 11364,
		dff = "files/farm/silicon09a_sfs.dff",
		col = "files/farm/silicon09a_sfs.col",
		txd = "files/farm/silicon09a_sfs.txd"
	},
	["farm:silicon09b_sfs"] = {
		type = "object",
		model = 10939,
		dff = "files/farm/silicon09b_sfs.dff",
		col = "files/farm/silicon09b_sfs.col",
		txd = "files/farm/silicon09a_sfs.txd"
	},
	["dummyweapon_ak47"] = {
		type = "object",
		model = 355,
		dff = "files/weapons/v4_dummy_ak47.dff",
		txd = "files/weapons/v4_dummy_wep.txd"
	},
	["chnsaw"] = {
		type = "object",
		model = 341,
		dff = "files/weapons/chnsaw.dff",
		txd = "files/weapons/chnsaw.txd"
	},
	["dummyweapon_chromegun"] = {
		type = "object",
		model = 349,
		dff = "files/weapons/v4_dummy_chromegun.dff",
		txd = "files/weapons/v4_dummy_wep.txd"
	},
	["dummyweapon_colt45"] = {
		type = "object",
		model = 346,
		dff = "files/weapons/v4_dummy_colt45.dff",
		txd = "files/weapons/v4_dummy_wep.txd"
	},
	["dummyweapon_desert_eagle"] = {
		type = "object",
		model = 348,
		dff = "files/weapons/v4_dummy_desert_eagle.dff",
		txd = "files/weapons/v4_dummy_wep.txd"
	},
	["grenade"] = {
		type = "object",
		model = 342,
		dff = "files/weapons/grenade.dff",
		txd = "files/weapons/grenade.txd"
	},
	["dummyweapon_katana"] = {
		type = "object",
		model = 339,
		dff = "files/weapons/v4_dummy_katana.dff",
		txd = "files/weapons/v4_dummy_wep.txd"
	},
	["dummy_knifecur"] = {
		type = "object",
		model = 335,
		dff = "files/weapons/v4_dummy_knifecur.dff",
		txd = "files/weapons/v4_dummy_wep.txd"
	},
	["dummyweapon_m4"] = {
		type = "object",
		model = 356,
		dff = "files/weapons/v4_dummy_m4.dff",
		txd = "files/weapons/v4_dummy_wep.txd"
	},
	["dummyweapon_micro_uzi"] = {
		type = "object",
		model = 352,
		dff = "files/weapons/v4_dummy_micro_uzi.dff",
		txd = "files/weapons/v4_dummy_wep.txd"
	},
	["dummyweapon_mp5lng"] = {
		type = "object",
		model = 353,
		dff = "files/weapons/v4_dummy_mp5lng.dff",
		txd = "files/weapons/v4_dummy_wep.txd"
	},
	["dummyweapon_rifle"] = {
		type = "object",
		model = 357,
		dff = "files/weapons/v4_dummy_rifle.dff",
		txd = "files/weapons/v4_dummy_wep.txd"
	},
	["dummyweapon_shotgspa"] = {
		type = "object",
		model = 351,
		dff = "files/weapons/v4_dummy_shotgspa.dff",
		txd = "files/weapons/v4_dummy_wep.txd"
	},
	["dummyweapon_silenced"] = {
		type = "object",
		model = 347,
		dff = "files/weapons/v4_dummy_silenced.dff",
		txd = "files/weapons/v4_dummy_wep.txd"
	},
	["dummyweapon_sniper"] = {
		type = "object",
		model = 358,
		dff = "files/weapons/v4_dummy_sniper.dff",
		txd = "files/weapons/v4_dummy_wep.txd"
	},
	["dummyweapon_tec9"] = {
		type = "object",
		model = 372,
		dff = "files/weapons/v4_dummy_tec9.dff",
		txd = "files/weapons/v4_dummy_wep.txd"
	},
	["dummyweapon_sawnoff"] = {
		type = "object",
		model = 350,
		dff = "files/weapons/v4_dummy_sawnoff.dff",
		txd = "files/weapons/v4_dummy_wep.txd"
	},
	["dummyweapon_dildo"] = {
		type = "object",
		model = 321,
		dff = "files/weapons/v4_dummy_dildo.dff",
		txd = "files/weapons/v4_dummy_wep.txd"
	},
	["v4_dummy_flamethrower"] = {
		type = "object",
		model = 361,
		dff = "files/weapons/v4_dummy_flamethrower.dff",
		txd = "files/weapons/v4_dummy_wep.txd"
	},
	["ak47"] = {
		type = "object",
		model = "object",
		dff = "files/weapons/ak47.dff",
		txd = "files/weapons/ak47.txd"
	},
	["chromegun"] = {
		type = "object",
		model = "object",
		dff = "files/weapons/chromegun.dff",
		txd = "files/weapons/chromegun.txd"
	},
	["colt45"] = {
		type = "object",
		model = "object",
		dff = "files/weapons/colt45.dff",
		txd = "files/weapons/colt45.txd"
	},
	["desert_eagle"] = {
		type = "object",
		model = "object",
		dff = "files/weapons/desert_eagle.dff",
		txd = "files/weapons/desert_eagle.txd"
	},
	["katana"] = {
		type = "object",
		model = "object",
		dff = "files/weapons/katana.dff",
		txd = "files/weapons/katana.txd"
	},
	["knifecur"] = {
		type = "object",
		model = "object",
		dff = "files/weapons/knifecur.dff",
		txd = "files/weapons/knifecur.txd"
	},
	["m4"] = {
		type = "object",
		model = "object",
		dff = "files/weapons/m4.dff",
		txd = "files/weapons/m4.txd"
	},
	["micro_uzi"] = {
		type = "object",
		model = "object",
		dff = "files/weapons/micro_uzi.dff",
		txd = "files/weapons/micro_uzi.txd"
	},
	--["mp5lng"] = {
	--  type = "object",
	--  model = "object",
	--  dff = "files/weapons/mp5lng.dff",
	--  txd = "files/weapons/mp5lng.txd"
	--},
	["rifle"] = {
		type = "object",
		model = "object",
		dff = "files/weapons/rifle.dff",
		txd = "files/weapons/rifle.txd"
	},
	["shotgspa"] = {
		type = "object",
		model = "object",
		dff = "files/weapons/shotgspa.dff",
		txd = "files/weapons/shotgspa.txd"
	},
	["silenced"] = {
		type = "object",
		model = "object",
		dff = "files/weapons/silenced.dff",
		txd = "files/weapons/silenced.txd"
	},
	--["sniper"] = {
	--  type = "object",
	--  model = "object",
	--  dff = "files/weapons/sniper.dff",
	--  txd = "files/weapons/sniper.txd"
	--},
	["tec9"] = {
		type = "object",
		model = "object",
		dff = "files/weapons/tec9.dff",
		txd = "files/weapons/tec9.txd"
	},
	["sawnoff"] = {
		type = "object",
		model = "object",
		dff = "files/weapons/sawnoff.dff",
		txd = "files/weapons/sawnoff.txd"
	},
	["wep_suspension"] = {
		type = "object",
		model = "object",
		dff = "files/weapons/wep_suspension.dff",
		txd = "files/weapons/wep_suspension.txd"
	},
	["shovel"] = {
		type = "object",
		model = 337,
		dff = "files/weapons/shovel.dff",
		txd = "files/weapons/shovel.txd"
	},
	["wep_bard"] = {
		type = "object",
		model = "object",
		dff = "files/weapons/bard.dff",
		txd = "files/weapons/bard.txd"
	},
	["wep_vipera"] = {
		type = "object",
		model = "object",
		dff = "files/weapons/vipera.dff",
		txd = "files/weapons/vipera.txd"
	},
	["wep_axe"] = {
		type = "object",
		model = "object",
		dff = "files/weapons/addon/axe.dff",
		txd = "files/weapons/addon/axe.txd"
	},
	["wep_pipe_wrench"] = {
		type = "object",
		model = "object",
		dff = "files/weapons/addon/pipe_wrench.dff",
		txd = "files/weapons/addon/pipe_wrench.txd"
	},
	["wep_hammer"] = {
		type = "object",
		model = "object",
		dff = "files/weapons/addon/hammer.dff",
		txd = "files/weapons/addon/hammer.txd"
	},
	["wep_taser_x26"] = {
		type = "object",
		model = "object",
		dff = "files/weapons/addon/taser_x26.dff",
		txd = "files/weapons/addon/taser_x26.txd"
	},
	["wep_ak-74"] = {
		type = "object",
		model = "object",
		dff = "files/weapons/addon/ak-74.dff",
		txd = "files/weapons/addon/ak-74.txd"
	},
	["wep_mp7a1"] = {
		type = "object",
		model = "object",
		dff = "files/weapons/addon/mp7a1.dff",
		txd = "files/weapons/addon/mp7a1.txd"
	},
	["wep_mp7a1_aimpoint"] = {
		type = "object",
		model = "object",
		dff = "files/weapons/addon/mp7a1_aimpoint.dff",
		txd = "files/weapons/addon/mp7a1.txd"
	},
	["wep_m4a1"] = {
		type = "object",
		model = "object",
		dff = "files/weapons/addon/m4a1.dff",
		txd = "files/weapons/addon/m4a1.txd"
	},
	["wep_m4a1_sopmod"] = {
		type = "object",
		model = "object",
		dff = "files/weapons/addon/m4a1_sopmod.dff",
		txd = "files/weapons/addon/m4a1.txd"
	},
	["wep_ar-15"] = {
		type = "object",
		model = "object",
		dff = "files/weapons/addon/ar-15.dff",
		txd = "files/weapons/addon/m4a1.txd"
	},
	["wep_ar-15_holo"] = {
		type = "object",
		model = "object",
		dff = "files/weapons/addon/ar-15_holo.dff",
		txd = "files/weapons/addon/m4a1.txd"
	},
	["wep_ar-15_aimpoint"] = {
		type = "object",
		model = "object",
		dff = "files/weapons/addon/ar-15_aimpoint.dff",
		txd = "files/weapons/addon/m4a1.txd"
	},
	["wep_glock-19"] = {
		type = "object",
		model = "object",
		dff = "files/weapons/addon/glock-19.dff",
		txd = "files/weapons/addon/glock-19.txd"
	},
	["wep_glock-19_laser"] = {
		type = "object",
		model = "object",
		dff = "files/weapons/addon/glock-19_laser.dff",
		txd = "files/weapons/addon/glock-19.txd"
	},
	["wep_hk_usp45"] = {
		type = "object",
		model = "object",
		dff = "files/weapons/addon/hk_usp45.dff",
		txd = "files/weapons/addon/hk_usp45.txd"
	},
	["wep_colt_1911"] = {
		type = "object",
		model = "object",
		dff = "files/weapons/addon/colt_1911.dff",
		txd = "files/weapons/addon/colt_1911.txd"
	},
	["wep_sw_model66"] = {
		type = "object",
		model = "object",
		dff = "files/weapons/addon/sw_model66.dff",
		txd = "files/weapons/addon/sw_model66.txd"
	},
	["wep_mosin_nagant"] = {
		type = "object",
		model = "object",
		dff = "files/weapons/addon/mosin_nagant.dff",
		txd = "files/weapons/addon/mosin_nagant.txd"
	},
	["wep_m110"] = {
		type = "object",
		model = "object",
		dff = "files/weapons/addon/m110.dff",
		txd = "files/weapons/addon/m110.txd"
	},
	["wep_micro_draco"] = {
		type = "object",
		model = "object",
		dff = "files/weapons/addon/micro_draco.dff",
		txd = "files/weapons/addon/micro_draco.txd"
	},
	["wep_benelli_m4"] = {
		type = "object",
		model = "object",
		dff = "files/weapons/addon/benelli_m4.dff",
		txd = "files/weapons/addon/benelli_m4.txd"
	},
	["wep_glock-17"] = {
		type = "object",
		model = "object",
		dff = "files/weapons/addon/glock-17.dff",
		txd = "files/weapons/addon/glock-17.txd"
	},
	["wep_m700"] = {
		type = "object",
		model = "object",
		dff = "files/weapons/addon/m700.dff",
		txd = "files/weapons/addon/m700.txd"
	},
	["wep_p90"] = {
		type = "object",
		model = "object",
		dff = "files/weapons/addon/p90.dff",
		txd = "files/weapons/addon/p90.txd"
	},
	["wep_pickaxe"] = {
		type = "object",
		model = "object",
		dff = "files/weapons/addon/pickaxe_new.dff",
		txd = "files/weapons/addon/pickaxe_new.txd"
	},
	["wep_pickaxe2"] = {
		type = "object",
		model = "object",
		dff = "files/weapons/addon/pickaxe_new2.dff",
		txd = "files/weapons/addon/pickaxe_new.txd"
	},
	["wep_pickaxe3"] = {
		type = "object",
		model = "object",
		dff = "files/weapons/addon/pickaxe_new3.dff",
		txd = "files/weapons/addon/pickaxe_new.txd"
	},
	["wep_pickaxe4"] = {
		type = "object",
		model = "object",
		dff = "files/weapons/addon/pickaxe_new4.dff",
		txd = "files/weapons/addon/pickaxe_new.txd"
	},
	["wep_pickaxe5"] = {
		type = "object",
		model = "object",
		dff = "files/weapons/addon/pickaxe_new5.dff",
		txd = "files/weapons/addon/pickaxe_new.txd"
	},
	["ggun"] = {
		type = "object",
		model = "object",
		dff = "files/weapons/addon/ggun.dff",
		txd = "files/weapons/addon/ggun.txd"
	},
	["lae711block01"] = {
		type = "object",
		model = 5418,
		dff = "files/seeburger/lae711block01.dff",
		col = "files/seeburger/lae711block01.col",
		txd = "files/seeburger/v4_seeburger.txd"
	},
	["LOD711block02"] = {
		type = "object",
		model = 5530,
		dff = "files/seeburger/LOD711block02.dff",
		col = "files/seeburger/lae711block01.col",
		txd = "files/seeburger/v4_seeburger.txd"
	},
	["laeroad43"] = {
		type = "object",
		model = 5508,
		dff = "files/seeburger/laeroad43.dff",
		col = "files/seeburger/laeroad43.col",
		txd = "files/seeburger/v4_seeburger.txd"
	},
	["laeroad44"] = {
		type = "object",
		model = 5509,
		dff = "files/seeburger/laeroad44.dff",
		col = "files/seeburger/laeroad44.col",
		txd = "files/seeburger/v4_seeburger.txd"
	},
	["laeIdlewood11"] = {
		type = "object",
		model = 5430,
		dff = "files/seeburger/laeIdlewood11.dff",
		txd = "files/seeburger/v4_seeburger.txd"
	},
	["v4_seeburger"] = {
		type = "object",
		model = "object",
		dff = "files/seeburger/v4_seeburger.dff",
		col = "files/seeburger/v4_seeburger.col",
		txd = "files/seeburger/v4_seeburger.txd",
		lodDistance = 300
	},
	["v4_seeburgerLOD"] = {
		type = "object",
		model = "object",
		dff = "files/seeburger/v4_seeburgerLOD.dff",
		col = "files/seeburger/v4_seeburger.col",
		txd = "files/seeburger/v4_seeburger.txd",
		lodDistance = 10000
	},
	["v4_int_seeburger"] = {
		type = "object",
		model = "object",
		dff = "files/seeburger/v4_int_seeburger.dff",
		col = "files/seeburger/v4_int_seeburger.col",
		txd = "files/seeburger/v4_seeburger.txd",
		lodDistance = 300
	},
	["v4_seeburger_sign"] = {
		type = "object",
		model = "object",
		dff = "files/seeburger/v4_seeburger_sign.dff",
		col = "files/seeburger/v4_seeburger_sign.col",
		txd = "files/seeburger/v4_seeburger.txd",
		lodDistance = 300
	},
	["v4_seeburger_signLOD"] = {
		type = "object",
		model = "object",
		dff = "files/seeburger/v4_seeburger_signLOD.dff",
		col = "files/seeburger/v4_seeburger_sign.col",
		txd = "files/seeburger/v4_seeburger.txd",
		lodDistance = 10000
	},
	["v4_seeburger_groundalpha"] = {
		type = "object",
		model = "object",
		dff = "files/seeburger/v4_seeburger_groundalpha.dff",
		col = "files/seeburger/v4_seeburger_groundalpha.col",
		txd = "files/v4_alpha_textures.txd",
		transparent = true,
		flags = {
			"no_zbuffer_write"
		},
		lodDistance = 250
	},
	["v4_seeburger_plants"] = {
		type = "object",
		model = "object",
		dff = "files/seeburger/v4_seeburger_plants.dff",
		col = "files/seeburger/v4_seeburger_plants.col",
		txd = "files/seeburger/v4_seeburger.txd",
		transparent = true
	},
	["v4_int_seeburger_alpha"] = {
		type = "object",
		model = "object",
		dff = "files/seeburger/v4_int_seeburger_alpha.dff",
		col = "files/seeburger/v4_int_seeburger_alpha.col",
		txd = "files/seeburger/v4_seeburger.txd",
		transparent = true,
		flags = {
			"no_zbuffer_write"
		},
		lodDistance = 150
	},
	["v4_int_seeburger_props"] = {
		type = "object",
		model = "object",
		dff = "files/seeburger/v4_int_seeburger_props.dff",
		col = "files/seeburger/v4_int_seeburger_props.col",
		txd = "files/seeburger/v4_seeburger.txd",
		lodDistance = 150
	},
	["v4_int_seeburger_plants"] = {
		type = "object",
		model = "object",
		dff = "files/seeburger/v4_int_seeburger_plants.dff",
		col = "files/seeburger/v4_int_seeburger_plants.col",
		txd = "files/seeburger/v4_seeburger.txd",
		transparent = true,
		lodDistance = 150
	},
	["v4_seeburger_windows"] = {
		type = "object",
		model = "object",
		dff = "files/seeburger/v4_seeburger_windows.dff",
		col = "files/seeburger/v4_seeburger_windows.col",
		txd = "files/seeburger/v4_seeburger.txd",
		transparent = true,
		lodDistance = 300
	},
	["v4_seeburger_table3"] = {
		type = "object",
		model = "object",
		dff = "files/seeburger/v4_seeburger_table3.dff",
		col = "files/seeburger/v4_seeburger_table3.col",
		txd = "files/seeburger/v4_seeburger.txd"
	},
	["v4_seeburger_table4"] = {
		type = "object",
		model = "object",
		dff = "files/seeburger/v4_seeburger_table4.dff",
		col = "files/seeburger/v4_seeburger_table4.col",
		txd = "files/seeburger/v4_seeburger.txd"
	},
	["v4_seeburger_cornerseat"] = {
		type = "object",
		model = "object",
		dff = "files/seeburger/v4_seeburger_cornerseat.dff",
		col = "files/seeburger/v4_seeburger_cornerseat.col",
		txd = "files/seeburger/v4_seeburger.txd"
	},
	["v4_seeburger_door"] = {
		type = "object",
		model = "object",
		dff = "files/seeburger/v4_seeburger_door.dff",
		col = "files/seeburger/v4_seeburger_door.col",
		txd = "files/seeburger/v4_seeburger.txd",
		dynamicDoor = true,
		transparent = true,
		lodDistance = 300
	},
	["v4_goldbank_codelock"] = {
		type = "object",
		model = "object",
		dff = "files/bank/v4_goldbank_codelock.dff",
		col = "files/bank/v4_goldbank_codelock.col",
		txd = "files/bank/v4_goldbank_codelock.txd"
	},
	["v4_goldbank_codelockbroken"] = {
		type = "object",
		model = "object",
		dff = "files/bank/v4_goldbank_codelockbroken.dff",
		col = "files/bank/v4_goldbank_codelock.col",
		txd = "files/bank/v4_goldbank_codelock.txd"
	},
	["v4_blow_torch"] = {
		type = "object",
		model = "object",
		dff = "files/bank/v4_blow_torch.dff",
		txd = "files/bank/v4_blow_torch.txd"
	},
	["v4_goldbank_vault_safes"] = {
		type = "object",
		model = "object",
		dff = "files/bank/v4_goldbank_vault_safes.dff",
		col = "files/bank/v4_goldbank_vault_safes.col",
		txd = "files/bank/v4_goldbank_vault.txd"
	},
	["v4_goldbank_vault_door"] = {
		type = "object",
		model = "object",
		dff = "files/bank/v4_goldbank_vault_door.dff",
		col = "files/bank/v4_goldbank_vault_door.col",
		txd = "files/bank/v4_goldbank_vault.txd"
	},
	["v4_goldbank_vault_door_wheel"] = {
		type = "object",
		model = "object",
		dff = "files/bank/v4_goldbank_vault_door_wheel.dff",
		txd = "files/bank/v4_goldbank_vault.txd"
	},
	["v4_goldbank_vault_door_lock"] = {
		type = "object",
		model = "object",
		dff = "files/bank/v4_goldbank_vault_door_lock.dff",
		col = "files/bank/v4_goldbank_vault_door_lock.col",
		txd = "files/bank/v4_goldbank_vault.txd"
	},
	["v4_goldbank_vault_bars"] = {
		type = "object",
		model = "object",
		dff = "files/bank/v4_goldbank_vault_bars.dff",
		col = "files/bank/v4_goldbank_vault_bars.col",
		txd = "files/bank/v4_goldbank_vault.txd"
	},
	["v4_goldbank_vault_cuts1"] = {
		type = "object",
		model = "object",
		dff = "files/bank/v4_goldbank_vault_cuts1.dff",
		txd = "files/bank/v4_goldbank_vault.txd",
		transparent = true
	},
	["v4_goldbank_vault_cuts2"] = {
		type = "object",
		model = "object",
		dff = "files/bank/v4_goldbank_vault_cuts2.dff",
		txd = "files/bank/v4_goldbank_vault.txd",
		transparent = true
	},
	["v4_goldbank_vault_cuts3"] = {
		type = "object",
		model = "object",
		dff = "files/bank/v4_goldbank_vault_cuts3.dff",
		txd = "files/bank/v4_goldbank_vault.txd",
		transparent = true
	},
	["v4_goldbank_vault_cuts4"] = {
		type = "object",
		model = "object",
		dff = "files/bank/v4_goldbank_vault_cuts4.dff",
		txd = "files/bank/v4_goldbank_vault.txd",
		transparent = true
	},
	["v4_goldbank_vault_cuts5"] = {
		type = "object",
		model = "object",
		dff = "files/bank/v4_goldbank_vault_cuts5.dff",
		txd = "files/bank/v4_goldbank_vault.txd",
		transparent = true
	},
	["v4_goldbank_vault_cuts6"] = {
		type = "object",
		model = "object",
		dff = "files/bank/v4_goldbank_vault_cuts6.dff",
		txd = "files/bank/v4_goldbank_vault.txd",
		transparent = true
	},
	["v4_goldbank_vault_cuts7"] = {
		type = "object",
		model = "object",
		dff = "files/bank/v4_goldbank_vault_cuts7.dff",
		txd = "files/bank/v4_goldbank_vault.txd",
		transparent = true
	},
	["v4_goldbank_vault_cuts8"] = {
		type = "object",
		model = "object",
		dff = "files/bank/v4_goldbank_vault_cuts8.dff",
		txd = "files/bank/v4_goldbank_vault.txd",
		transparent = true
	},
	["v4_goldbank_vault_cuts9"] = {
		type = "object",
		model = "object",
		dff = "files/bank/v4_goldbank_vault_cuts9.dff",
		txd = "files/bank/v4_goldbank_vault.txd",
		transparent = true
	},
	["v4_goldbank_vault_cuts10"] = {
		type = "object",
		model = "object",
		dff = "files/bank/v4_goldbank_vault_cuts10.dff",
		txd = "files/bank/v4_goldbank_vault.txd",
		transparent = true
	},
	["v4_goldbank_vault_cuts11"] = {
		type = "object",
		model = "object",
		dff = "files/bank/v4_goldbank_vault_cuts11.dff",
		txd = "files/bank/v4_goldbank_vault.txd",
		transparent = true
	},
	["v4_goldbank_vault_cuts12"] = {
		type = "object",
		model = "object",
		dff = "files/bank/v4_goldbank_vault_cuts12.dff",
		txd = "files/bank/v4_goldbank_vault.txd",
		transparent = true
	},
	["v4_goldbank_vault_cuts13"] = {
		type = "object",
		model = "object",
		dff = "files/bank/v4_goldbank_vault_cuts13.dff",
		txd = "files/bank/v4_goldbank_vault.txd",
		transparent = true
	},
	["v4_goldbank_vault_cuts14"] = {
		type = "object",
		model = "object",
		dff = "files/bank/v4_goldbank_vault_cuts14.dff",
		txd = "files/bank/v4_goldbank_vault.txd",
		transparent = true
	},
	["v4_goldbank"] = {
		type = "object",
		model = 6389,
		dff = "files/bank/v4_goldbank.dff",
		col = "files/bank/v4_goldbank.col",
		txd = "files/bank/v4_goldbank.txd"
	},
	["v4_goldbank_alpha"] = {
		type = "object",
		model = "object",
		dff = "files/bank/v4_goldbank_alpha.dff",
		col = "files/bank/v4_goldbank_alpha.col",
		txd = "files/bank/v4_goldbank.txd",
		transparent = true,
		lodDistance = 150
	},
	["v4_goldbank_stairs"] = {
		type = "object",
		model = "object",
		dff = "files/bank/v4_goldbank_stairs.dff",
		col = "files/bank/v4_goldbank_stairs.col",
		txd = "files/bank/v4_goldbank.txd"
	},
	["v4_goldbank_int1"] = {
		type = "object",
		model = "object",
		dff = "files/bank/v4_goldbank_int1.dff",
		col = "files/bank/v4_goldbank_int1.col",
		txd = "files/bank/v4_goldbank.txd",
		lodDistance = 150
	},
	["v4_goldbank_int2"] = {
		type = "object",
		model = "object",
		dff = "files/bank/v4_goldbank_int2.dff",
		col = "files/bank/v4_goldbank_int2.col",
		txd = "files/bank/v4_goldbank.txd",
		lodDistance = 150
	},
	["v4_goldbank_int3"] = {
		type = "object",
		model = "object",
		dff = "files/bank/v4_goldbank_int3.dff",
		col = "files/bank/v4_goldbank_int3.col",
		txd = "files/bank/v4_goldbank.txd",
		lodDistance = 150
	},
	["v4_goldbank_columns"] = {
		type = "object",
		model = "object",
		dff = "files/bank/v4_goldbank_columns.dff",
		col = "files/bank/v4_goldbank_columns.col",
		txd = "files/bank/v4_goldbank.txd",
		lodDistance = 150
	},
	["v4_goldbank_props1"] = {
		type = "object",
		model = "object",
		dff = "files/bank/v4_goldbank_props1.dff",
		col = "files/bank/v4_goldbank_props1.col",
		txd = "files/bank/v4_goldbank_props.txd",
		lodDistance = 150
	},
	["v4_goldbank_props2"] = {
		type = "object",
		model = "object",
		dff = "files/bank/v4_goldbank_props2.dff",
		col = "files/bank/v4_goldbank_props2.col",
		txd = "files/bank/v4_goldbank_props.txd",
		lodDistance = 150
	},
	["v4_goldbank_props3"] = {
		type = "object",
		model = "object",
		dff = "files/bank/v4_goldbank_props3.dff",
		col = "files/bank/v4_goldbank_props3.col",
		txd = "files/bank/v4_goldbank_props.txd",
		lodDistance = 150
	},
	["v4_goldbank_props4"] = {
		type = "object",
		model = "object",
		dff = "files/bank/v4_goldbank_props4.dff",
		col = "files/bank/v4_goldbank_props4.col",
		txd = "files/bank/v4_goldbank_props.txd",
		lodDistance = 150
	},
	["v4_goldbank_props5"] = {
		type = "object",
		model = "object",
		dff = "files/bank/v4_goldbank_props5.dff",
		col = "files/bank/v4_goldbank_props5.col",
		txd = "files/bank/v4_goldbank_props.txd",
		lodDistance = 150
	},
	["v4_goldbank_props6"] = {
		type = "object",
		model = "object",
		dff = "files/bank/v4_goldbank_props6.dff",
		col = "files/bank/v4_goldbank_props6.col",
		txd = "files/bank/v4_goldbank_props.txd",
		lodDistance = 150
	},
	["v4_goldbank_props7"] = {
		type = "object",
		model = "object",
		dff = "files/bank/v4_goldbank_props7.dff",
		col = "files/bank/v4_goldbank_props7.col",
		txd = "files/bank/v4_goldbank_props.txd",
		lodDistance = 150
	},
	["v4_goldbank_vault"] = {
		type = "object",
		model = "object",
		dff = "files/bank/v4_goldbank_vault.dff",
		col = "files/bank/v4_goldbank_vault.col",
		txd = "files/bank/v4_goldbank_vault.txd"
	},
	["v4_goldbank_vaultprops"] = {
		type = "object",
		model = "object",
		dff = "files/bank/v4_goldbank_vaultprops.dff",
		col = "files/bank/v4_goldbank_vaultprops.col",
		txd = "files/bank/v4_goldbank_vault.txd"
	},
	["v4_goldbank_stairs2"] = {
		type = "object",
		model = "object",
		dff = "files/bank/v4_goldbank_stairs2.dff",
		col = "files/bank/v4_goldbank_stairs2.col",
		txd = "files/bank/v4_goldbank.txd",
		transparent = true,
		lodDistance = 150
	},
	["v4_goldbank_roof"] = {
		type = "object",
		model = "object",
		dff = "files/bank/v4_goldbank_roof.dff",
		col = "files/bank/v4_goldbank_roof.col",
		txd = "files/bank/v4_goldbank_roof.txd",
		lodDistance = 150
	},
	["v4_goldbank_elevator"] = {
		type = "object",
		model = "object",
		dff = "files/bank/v4_goldbank_elevator.dff",
		col = "files/bank/v4_goldbank_elevator.col",
		txd = "files/bank/v4_goldbank.txd"
	},
	["v4_goldbank_elevator_door"] = {
		type = "object",
		model = "object",
		dff = "files/bank/v4_goldbank_elevator_door.dff",
		col = "files/bank/v4_goldbank_elevator_door.col",
		txd = "files/bank/v4_goldbank.txd"
	},
	["v4_goldbank_counter_door"] = {
		type = "object",
		model = "object",
		dff = "files/bank/v4_goldbank_counter_door.dff",
		col = "files/bank/v4_goldbank_counter_door.col",
		txd = "files/bank/v4_goldbank.txd",
		dynamicDoor = true
	},
	["v4_goldbank_door1"] = {
		type = "object",
		model = "object",
		dff = "files/bank/v4_goldbank_door1.dff",
		col = "files/bank/v4_goldbank_door1.col",
		txd = "files/bank/v4_goldbank.txd",
		dynamicDoor = true
	},
	["v4_goldbank_door2"] = {
		type = "object",
		model = "object",
		dff = "files/bank/v4_goldbank_door2.dff",
		col = "files/bank/v4_goldbank_door2.col",
		txd = "files/bank/v4_goldbank.txd",
		transparent = true
	},
	["v4_goldbank_door3"] = {
		type = "object",
		model = "object",
		dff = "files/bank/v4_goldbank_door3.dff",
		col = "files/bank/v4_goldbank_door3.col",
		txd = "files/bank/v4_goldbank.txd",
		lodDistance = 150
	},
	["v4_goldbank_door3_dynamic"] = {
		type = "object",
		model = "object",
		dff = "files/bank/v4_goldbank_door3_dynamic.dff",
		col = "files/bank/v4_goldbank_roof_door_openable.col",
		txd = "files/bank/v4_goldbank.txd",
		lodDistance = 150,
		dynamicDoor = true
	},
	["v4_goldbank_door4"] = {
		type = "object",
		model = "object",
		dff = "files/bank/v4_goldbank_door4.dff",
		col = "files/bank/v4_goldbank_door4.col",
		txd = "files/bank/v4_goldbank.txd",
		transparent = true
	},
	["v4_goldbank_door5"] = {
		type = "object",
		model = "object",
		dff = "files/bank/v4_goldbank_door5.dff",
		col = "files/bank/v4_goldbank_door5.col",
		txd = "files/bank/v4_goldbank.txd"
	},
	["v4_goldbank_door5_dynamic"] = {
		type = "object",
		model = "object",
		dff = "files/bank/v4_goldbank_door5_dynamic.dff",
		col = "files/bank/v4_goldbank_door5_dynamic.col",
		txd = "files/bank/v4_goldbank.txd",
		dynamicDoor = true
	},
	["v4_goldbank_roof_door"] = {
		type = "object",
		model = "object",
		dff = "files/bank/v4_goldbank_roof_door.dff",
		col = "files/bank/v4_goldbank_roof_door.col",
		txd = "files/bank/v4_goldbank.txd",
		lodDistance = 150
	},
	["v4_goldbank_roof_door_dynamic"] = {
		type = "object",
		model = "object",
		dff = "files/bank/v4_goldbank_roof_door_dynamic.dff",
		col = "files/bank/v4_goldbank_roof_door_openable.col",
		txd = "files/bank/v4_goldbank.txd",
		dynamicDoor = true,
		lodDistance = 150
	},
	["v4_goldbank_roof_door2"] = {
		type = "object",
		model = "object",
		dff = "files/bank/v4_goldbank_roof_door2.dff",
		col = "files/bank/v4_goldbank_roof_door.col",
		txd = "files/bank/v4_goldbank.txd",
		lodDistance = 150
	},
	["v4_goldbank_roof_door2_dynamic"] = {
		type = "object",
		model = "object",
		dff = "files/bank/v4_goldbank_roof_door2_dynamic.dff",
		col = "files/bank/v4_goldbank_roof_door_openable.col",
		txd = "files/bank/v4_goldbank.txd",
		dynamicDoor = true,
		lodDistance = 150
	},
	["v4_goldbank_elevator_shaft"] = {
		type = "object",
		model = "object",
		dff = "files/bank/v4_goldbank_elevator_shaft.dff",
		col = "files/bank/v4_goldbank_elevator_shaft.col",
		txd = "files/bank/v4_goldbank.txd"
	},
	["v4_signal_alarm"] = {
		type = "object",
		model = "object",
		dff = "files/bank/v4_signal_alarm.dff",
		col = "files/bank/v4_signal_alarm.col",
		txd = "files/bank/v4_signal_alarm.txd"
	},
	["v4_goldbar"] = {
		type = "object",
		model = "object",
		dff = "files/bank/v4_goldbar.dff",
		col = "files/bank/v4_goldbar.col",
		txd = "files/bank/v4_goldbox.txd"
	},
	["v4_goldbox1"] = {
		type = "object",
		model = "object",
		dff = "files/bank/v4_goldbox1.dff",
		col = "files/bank/v4_goldbox.col",
		txd = "files/bank/v4_goldbox.txd"
	},
	["v4_goldbox2"] = {
		type = "object",
		model = "object",
		dff = "files/bank/v4_goldbox2.dff",
		col = "files/bank/v4_goldbox.col",
		txd = "files/bank/v4_goldbox.txd"
	},
	["v4_goldbank_logo"] = {
		type = "object",
		model = "object",
		dff = "files/bank/v4_goldbank_logo.dff",
		txd = "files/bank/v4_goldbank.txd"
	},
	["v4_goldbank_logo2"] = {
		type = "object",
		model = "object",
		dff = "files/bank/v4_goldbank_logo2.dff",
		col = "files/bank/v4_goldbank_logo2.col",
		txd = "files/bank/v4_goldbank.txd"
	},
	["v4_dealership_plants"] = {
		type = "object",
		model = "object",
		dff = "files/bank/v4_dealership_plants.dff",
		col = "files/bank/v4_dealership_plants.col",
		txd = "files/bank/v4_dealership_plants.txd"
	},
	["xref_garagedoor"] = {
		type = "object",
		model = 2885,
		dff = "files/bank/xref_garagedoor.dff",
		txd = "files/bank/xref_garagedoor.txd"
	},
	["v4_atm"] = {
		type = "object",
		model = "object",
		dff = "files/bank/v4_atm.dff",
		col = "files/bank/v4_atm.col",
		txd = "files/bank/v4_atm.txd"
	},
	["v4_atm2"] = {
		type = "object",
		model = "object",
		dff = "files/bank/v4_atm2.dff",
		col = "files/bank/v4_atm.col",
		txd = "files/bank/v4_atm.txd"
	},
	["v4_atm2_door"] = {
		type = "object",
		model = "object",
		dff = "files/bank/v4_atm2_door.dff",
		txd = "files/bank/v4_atm.txd",
		transparent = true
	},
	["v4_atm_cassette"] = {
		type = "object",
		model = "object",
		dff = "files/bank/v4_atm_cassette.dff",
		txd = "files/bank/v4_atm.txd",
		transparent = true
	},
	["container_atm"] = {
		type = "object",
		model = "object",
		dff = "files/bank/container_atm.dff",
		col = "files/bank/container_atm.col",
		txd = "files/bank/v4_atm.txd",
		transparent = true
	},
	["container_atm2"] = {
		type = "object",
		model = "object",
		dff = "files/bank/container_atm2.dff",
		col = "files/bank/container_atm.col",
		txd = "files/bank/v4_atm.txd",
		transparent = true
	},
	["container_atm_top"] = {
		type = "object",
		model = "object",
		dff = "files/bank/container_atm_top.dff",
		txd = "files/bank/v4_atm.txd",
		transparent = true
	},
	["container_atm_cash"] = {
		type = "object",
		model = "object",
		dff = "files/bank/container_atm_cash.dff",
		txd = "files/bank/v4_atm.txd",
		transparent = true
	},
	["container_atm_cash2"] = {
		type = "object",
		model = "object",
		dff = "files/bank/container_atm_cash2.dff",
		txd = "files/bank/v4_atm.txd",
		transparent = true
	},
	["v4_int_makvirag"] = {
		type = "object",
		model = "object",
		dff = "files/makvirag/v4_int_makvirag.dff",
		col = "files/makvirag/v4_int_makvirag.col",
		txd = "files/makvirag/v4_int_makvirag.txd"
	},
	["v4_int_makvirag_props"] = {
		type = "object",
		model = "object",
		dff = "files/makvirag/v4_int_makvirag_props.dff",
		col = "files/makvirag/v4_int_makvirag_props.col",
		txd = "files/makvirag/v4_int_makvirag.txd",
		transparent = true
	},
	["v4_int_makvirag_bar"] = {
		type = "object",
		model = "object",
		dff = "files/makvirag/v4_int_makvirag_bar.dff",
		col = "files/makvirag/v4_int_makvirag_bar.col",
		txd = "files/makvirag/v4_int_makvirag.txd",
		transparent = true
	},
	["LAroads_20gh_LAs"] = {
		type = "object",
		model = 4807,
		dff = "files/makvirag/LAroads_20gh_LAs.dff",
		col = "files/makvirag/LAroads_20gh_LAs.col",
		txd = "files/makvirag/v4_makvirag.txd"
	},
	["lastripx1_LAS"] = {
		type = "object",
		model = 5017,
		dff = "files/makvirag/lastripx1_LAS.dff",
		col = "files/makvirag/lastripx1_LAS.col",
		txd = "files/makvirag/v4_makvirag.txd"
	},
	["snpdmshfnc3_LAS"] = {
		type = "object",
		model = 4849,
		dff = "files/makvirag/snpdmshfnc3_LAS.dff",
		col = "files/makvirag/snpdmshfnc3_LAS.col",
		txd = "files/makvirag/v4_makvirag.txd"
	},
	["airpurt2_las"] = {
		type = "object",
		model = 4831,
		dff = "files/map_fixes/airpurt2_las.dff",
		col = "files/map_fixes/airpurt2_las.col",
		txd = "files/map_fixes/lsairport_roadfix.txd",
		lodDistance = 180
	},
	["BTOLAND1ct_LAS"] = {
		type = "object",
		model = 5036,
		dff = "files/map_fixes/BTOLAND1ct_LAS.dff",
		col = "files/map_fixes/BTOLAND1ct_LAS.col",
		txd = "files/map_fixes/lsairport_roadfix.txd",
		lodDistance = 180
	},
	["LAcityped1_LAs"] = {
		type = "object",
		model = 4846,
		dff = "files/map_fixes/LAcityped1_LAs.dff",
		col = "files/map_fixes/LAcityped1_LAs.col",
		txd = "files/map_fixes/lsairport_roadfix.txd",
		lodDistance = 180
	},
	["sjmbarct2_LAS"] = {
		type = "object",
		model = 5080,
		dff = "files/map_fixes/sjmbarct2_LAS.dff",
		col = "files/map_fixes/sjmbarct2_LAS.col",
		txd = "files/map_fixes/lsairport_roadfix.txd",
		lodDistance = 180
	},
	["LODpurt2_las01"] = {
		type = "object",
		model = 4950,
		dff = "files/map_fixes/LODpurt2_las01.dff",
		txd = "files/map_fixes/lsairport_roadfix_LOD.txd"
	},
	["LODLAND1ct_LAS"] = {
		type = "object",
		model = 5037,
		dff = "files/map_fixes/LODLAND1ct_LAS.dff",
		txd = "files/map_fixes/lsairport_roadfix_LOD.txd"
	},
	["LODityped1_LAs01"] = {
		type = "object",
		model = 4953,
		dff = "files/map_fixes/LODityped1_LAs01.dff",
		txd = "files/map_fixes/lsairport_roadfix_LOD.txd"
	},
	["CE_groundPALO03_bridge"] = {
		type = "object",
		model = 13101,
		col = "files/map_fixes/CE_groundPALO03_bridge.col"
	},
	["sunset10_LAw2"] = {
		type = "object",
		model = 6497,
		col = "files/map_fixes/sunset10_LAw2.col"
	},
	["lawroads_law21"] = {
		type = "object",
		model = 6127,
		dff = "files/map_fixes/lawroads_law21.dff",
		col = "files/map_fixes/lawroads_law21.col",
		txd = "files/map_fixes/lsairport_roadfix.txd"
	},
	["v4_lawroads_hedge01"] = {
		type = "object",
		model = "object",
		dff = "files/map_fixes/v4_lawroads_hedge01.dff",
		col = "files/map_fixes/v4_lawroads_hedge01.col",
		txd = "files/map_fixes/lsairport_roadfix.txd",
		lodDistance = 300
	},
	["v4_lawroads_hedge02"] = {
		type = "object",
		model = "object",
		dff = "files/map_fixes/v4_lawroads_hedge02.dff",
		col = "files/map_fixes/v4_lawroads_hedge02.col",
		txd = "files/map_fixes/lsairport_roadfix.txd",
		lodDistance = 300
	},
	["airprtwlkto2_LAS"] = {
		type = "object",
		model = 5006,
		col = "files/map_fixes/airprtwlkto2_LAS.col"
	},
	["md_lockdoor"] = {
		type = "object",
		model = 3033,
		col = "files/map_fixes/md_lockdoor.col"
	},
	["cuntwland09b"] = {
		type = "object",
		model = 17084,
		dff = "files/map_fixes/cuntwland09b.dff",
		col = "files/map_fixes/cuntwland09b.col",
		txd = "files/map_fixes/whetstone_road.txd"
	},
	["cuntwland09b_lod"] = {
		type = "object",
		model = 17387,
		dff = "files/map_fixes/cuntwland09b_lod.dff",
		txd = "files/map_fixes/whetstone_road.txd"
	},
	["cuntwroad01"] = {
		type = "object",
		model = 17218,
		dff = "files/map_fixes/cuntwroad01.dff",
		col = "files/map_fixes/cuntwroad01.col",
		txd = "files/map_fixes/whetstone_road.txd"
	},
	["cuntwroad01_lod"] = {
		type = "object",
		model = 17219,
		dff = "files/map_fixes/cuntwroad01_lod.dff",
		txd = "files/map_fixes/whetstone_road.txd"
	},
	["cuntwroad69"] = {
		type = "object",
		model = 17275,
		dff = "files/map_fixes/cuntwroad69.dff",
		col = "files/map_fixes/cuntwroad69.col",
		txd = "files/map_fixes/whetstone_road.txd"
	},
	["v4_fishing_rod"] = {
		type = "object",
		model = "object",
		dff = "files/fishing/v4_fishing_rod.dff",
		txd = "files/fishing/v4_fishing.txd",
		col = "files/fishing/v4_fishing_rod.col"
	},
	["v4_fishing_bobber"] = {
		type = "object",
		model = "object",
		dff = "files/fishing/v4_fishing_bobber.dff",
		txd = "files/fishing/v4_fishing.txd"
	},
	["des_baitshop"] = {
		type = "object",
		model = 18233,
		dff = "files/fishing/des_baitshop.dff",
		col = "files/fishing/des_baitshop.col",
		txd = "files/fishing/v4_fishing.txd"
	},
	["des_baitshop_alpha"] = {
		type = "object",
		model = "object",
		dff = "files/fishing/des_baitshop_alpha.dff",
		col = "files/fishing/des_baitshop_alpha.col",
		txd = "files/fishing/v4_fishing.txd",
		transparent = true
	},
	["des_baitshop_props"] = {
		type = "object",
		model = "object",
		dff = "files/fishing/des_baitshop_props.dff",
		col = "files/fishing/des_baitshop_props.col",
		txd = "files/fishing/v4_fishing.txd"
	},
	["des_baitshop_door"] = {
		type = "object",
		model = "object",
		dff = "files/fishing/des_baitshop_door.dff",
		col = "files/fishing/des_baitshop_door.col",
		txd = "files/fishing/v4_fishing.txd",
		transparent = true,
		dynamicDoor = true
	},
	["v4_fishing_chest"] = {
		type = "object",
		model = "object",
		dff = "files/fishing/v4_fishing_chest.dff",
		txd = "files/fishing/v4_fishing.txd",
		transparent = true
	},
	["v4_fishing_chest_top"] = {
		type = "object",
		model = "object",
		dff = "files/fishing/v4_fishing_chest_top.dff",
		txd = "files/fishing/v4_fishing.txd",
		transparent = true
	},
	["v4_fishing_chest_lock"] = {
		type = "object",
		model = "object",
		dff = "files/fishing/v4_fishing_chest_lock.dff",
		txd = "files/fishing/v4_fishing.txd",
		transparent = true
	},
	["v4_fishing_chest_catch"] = {
		type = "object",
		model = "object",
		dff = "files/fishing/v4_fishing_chest_catch.dff",
		txd = "files/fishing/v4_fishing.txd"
	},
	["v4_fishing_tournamentsign"] = {
		type = "object",
		model = "object",
		dff = "files/fishing/v4_fishing_tournamentsign.dff",
		col = "files/fishing/v4_fishing_tournamentsign.col",
		txd = "files/fishing/v4_fishing.txd"
	},
	["v4_fish_greatwhite_leg"] = {
		type = "object",
		model = "object",
		dff = "files/fishing/fishes/v4_fish_greatwhite_leg.dff",
		col = "files/fishing/fishes/v4_fish_greatwhite_leg.col",
		txd = "files/fishing/fishes/v4_fishes.txd"
	},
	["v4_fish_greatwhite"] = {
		type = "object",
		model = "object",
		dff = "files/fishing/fishes/v4_fish_greatwhite.dff",
		col = "files/fishing/fishes/v4_fish_greatwhite.col",
		txd = "files/fishing/fishes/v4_fishes.txd"
	},
	["v4_fish_hardheadcatfish"] = {
		type = "object",
		model = "object",
		dff = "files/fishing/fishes/v4_fish_hardheadcatfish.dff",
		col = "files/fishing/fishes/v4_fish_hardheadcatfish.col",
		txd = "files/fishing/fishes/v4_fishes.txd"
	},
	["v4_fish_mackerel"] = {
		type = "object",
		model = "object",
		dff = "files/fishing/fishes/v4_fish_mackerel.dff",
		col = "files/fishing/fishes/v4_fish_mackerel.col",
		txd = "files/fishing/fishes/v4_fishes.txd"
	},
	["v4_fish_mahi_leg"] = {
		type = "object",
		model = "object",
		dff = "files/fishing/fishes/v4_fish_mahi_leg.dff",
		col = "files/fishing/fishes/v4_fish_mahi_leg.col",
		txd = "files/fishing/fishes/v4_fishes.txd"
	},
	["v4_fish_mahi"] = {
		type = "object",
		model = "object",
		dff = "files/fishing/fishes/v4_fish_mahi.dff",
		col = "files/fishing/fishes/v4_fish_mahi.col",
		txd = "files/fishing/fishes/v4_fishes.txd"
	},
	["v4_fish_makoshark"] = {
		type = "object",
		model = "object",
		dff = "files/fishing/fishes/v4_fish_makoshark.dff",
		col = "files/fishing/fishes/v4_fish_makoshark.col",
		txd = "files/fishing/fishes/v4_fishes.txd"
	},
	["v4_fish_pinksalmon"] = {
		type = "object",
		model = "object",
		dff = "files/fishing/fishes/v4_fish_pinksalmon.dff",
		col = "files/fishing/fishes/v4_fish_pinksalmon.col",
		txd = "files/fishing/fishes/v4_fishes.txd"
	},
	["v4_fish_redsalmon"] = {
		type = "object",
		model = "object",
		dff = "files/fishing/fishes/v4_fish_redsalmon.dff",
		col = "files/fishing/fishes/v4_fish_redsalmon.col",
		txd = "files/fishing/fishes/v4_fishes.txd"
	},
	["v4_fish_rooster_leg"] = {
		type = "object",
		model = "object",
		dff = "files/fishing/fishes/v4_fish_rooster_leg.dff",
		col = "files/fishing/fishes/v4_fish_rooster_leg.col",
		txd = "files/fishing/fishes/v4_fishes.txd"
	},
	["v4_fish_rooster"] = {
		type = "object",
		model = "object",
		dff = "files/fishing/fishes/v4_fish_rooster.dff",
		col = "files/fishing/fishes/v4_fish_rooster.col",
		txd = "files/fishing/fishes/v4_fishes.txd"
	},
	["v4_fish_snapper_leg"] = {
		type = "object",
		model = "object",
		dff = "files/fishing/fishes/v4_fish_snapper_leg.dff",
		col = "files/fishing/fishes/v4_fish_snapper_leg.col",
		txd = "files/fishing/fishes/v4_fishes.txd"
	},
	["v4_fish_snapper"] = {
		type = "object",
		model = "object",
		dff = "files/fishing/fishes/v4_fish_snapper.dff",
		col = "files/fishing/fishes/v4_fish_snapper.col",
		txd = "files/fishing/fishes/v4_fishes.txd"
	},
	["v4_fish_swordfish"] = {
		type = "object",
		model = "object",
		dff = "files/fishing/fishes/v4_fish_swordfish.dff",
		col = "files/fishing/fishes/v4_fish_swordfish.col",
		txd = "files/fishing/fishes/v4_fishes.txd"
	},
	["v4_fish_tigershark"] = {
		type = "object",
		model = "object",
		dff = "files/fishing/fishes/v4_fish_tigershark.dff",
		col = "files/fishing/fishes/v4_fish_tigershark.col",
		txd = "files/fishing/fishes/v4_fishes.txd"
	},
	["v4_fish_tunabluefin"] = {
		type = "object",
		model = "object",
		dff = "files/fishing/fishes/v4_fish_tunabluefin.dff",
		col = "files/fishing/fishes/v4_fish_tunabluefin.col",
		txd = "files/fishing/fishes/v4_fishes.txd"
	},
	["v4_fish_tunayellowfin"] = {
		type = "object",
		model = "object",
		dff = "files/fishing/fishes/v4_fish_tunayellowfin.dff",
		col = "files/fishing/fishes/v4_fish_tunayellowfin.col",
		txd = "files/fishing/fishes/v4_fishes.txd"
	},
	["v4_fish_yellowtailsnapper"] = {
		type = "object",
		model = "object",
		dff = "files/fishing/fishes/v4_fish_yellowtailsnapper.dff",
		col = "files/fishing/fishes/v4_fish_yellowtailsnapper.col",
		txd = "files/fishing/fishes/v4_fishes.txd"
	},
	["sw_bit_06"] = {
		type = "object",
		model = 11535,
		dff = "files/v4_map_expansion/sw_bit_06.dff",
		col = "files/v4_map_expansion/sw_bit_06.col",
		txd = "files/v4_map_expansion/v4_map_expansion.txd"
	},
	["sw_bit_06_LOD"] = {
		type = "object",
		model = 11659,
		dff = "files/v4_map_expansion/sw_bit_06_LOD.dff",
		col = "files/v4_map_expansion/sw_bit_06.col",
		txd = "files/v4_map_expansion/v4_map_expansion_LOD.txd"
	},
	["sw_bit_08"] = {
		type = "object",
		model = 11536,
		dff = "files/v4_map_expansion/sw_bit_08.dff",
		col = "files/v4_map_expansion/sw_bit_08.col",
		txd = "files/v4_map_expansion/v4_map_expansion.txd"
	},
	["sw_bit_08_LOD"] = {
		type = "object",
		model = 11661,
		dff = "files/v4_map_expansion/sw_bit_08_LOD.dff",
		col = "files/v4_map_expansion/sw_bit_08.col",
		txd = "files/v4_map_expansion/v4_map_expansion_LOD.txd"
	},
	["sw_bit_09"] = {
		type = "object",
		model = 11557,
		dff = "files/v4_map_expansion/sw_bit_09.dff",
		col = "files/v4_map_expansion/sw_bit_09.col",
		txd = "files/v4_map_expansion/v4_map_expansion.txd"
	},
	["sw_bit_09_LOD"] = {
		type = "object",
		model = 11653,
		dff = "files/v4_map_expansion/sw_bit_09_LOD.dff",
		col = "files/v4_map_expansion/sw_bit_09.col",
		txd = "files/v4_map_expansion/v4_map_expansion_LOD.txd"
	},
	["sw_bit_10"] = {
		type = "object",
		model = 11560,
		dff = "files/v4_map_expansion/sw_bit_10.dff",
		col = "files/v4_map_expansion/sw_bit_10.col",
		txd = "files/v4_map_expansion/v4_map_expansion.txd"
	},
	["sw_bit_10_LOD"] = {
		type = "object",
		model = 11657,
		dff = "files/v4_map_expansion/sw_bit_10_LOD.dff",
		col = "files/v4_map_expansion/sw_bit_10.col",
		txd = "files/v4_map_expansion/v4_map_expansion.txd"
	},
	["sw_bit_11"] = {
		type = "object",
		model = 11537,
		dff = "files/v4_map_expansion/sw_bit_11.dff",
		col = "files/v4_map_expansion/sw_bit_11.col",
		txd = "files/v4_map_expansion/v4_map_expansion.txd"
	},
	["sw_bit_11_LOD"] = {
		type = "object",
		model = 11577,
		dff = "files/v4_map_expansion/sw_bit_11_LOD.dff",
		col = "files/v4_map_expansion/sw_bit_11.col",
		txd = "files/v4_map_expansion/v4_map_expansion_LOD.txd"
	},
	["sw_bit_12"] = {
		type = "object",
		model = 11538,
		dff = "files/v4_map_expansion/sw_bit_12.dff",
		txd = "files/v4_map_expansion/v4_map_expansion.txd"
	},
	["sw_bit_13"] = {
		type = "object",
		model = 11430,
		dff = "files/v4_map_expansion/sw_bit_13.dff",
		col = "files/v4_map_expansion/sw_bit_13.col",
		txd = "files/v4_map_expansion/v4_map_expansion.txd"
	},
	["sw_bit_13_LOD"] = {
		type = "object",
		model = 11662,
		dff = "files/v4_map_expansion/sw_bit_13_LOD.dff",
		col = "files/v4_map_expansion/sw_bit_13.col",
		txd = "files/v4_map_expansion/v4_map_expansion_LOD.txd"
	},
	["cn_teline_02"] = {
		type = "object",
		model = 11562,
		dff = "files/v4_map_expansion/cn_teline_02.dff",
		col = "files/v4_map_expansion/cn_teline_02.col",
		txd = "files/v4_map_expansion/v4_map_expansion.txd",
		transparent = true
	},
	["cn_teline_03"] = {
		type = "object",
		model = 11563,
		dff = "files/v4_map_expansion/cn_teline_03.dff",
		col = "files/v4_map_expansion/cn_teline_03.col",
		txd = "files/v4_map_expansion/v4_map_expansion.txd",
		transparent = true
	},
	["nw_bit_04"] = {
		type = "object",
		model = 11508,
		dff = "files/v4_map_expansion/nw_bit_04.dff",
		col = "files/v4_map_expansion/nw_bit_04.col",
		txd = "files/v4_map_expansion/v4_map_expansion.txd"
	},
	["nw_bit_04_LOD"] = {
		type = "object",
		model = 11635,
		dff = "files/v4_map_expansion/nw_bit_04_LOD.dff",
		col = "files/v4_map_expansion/nw_bit_04.col",
		txd = "files/v4_map_expansion/v4_map_expansion_LOD.txd"
	},
	["nw_bit_10"] = {
		type = "object",
		model = 11512,
		dff = "files/v4_map_expansion/nw_bit_10.dff",
		col = "files/v4_map_expansion/nw_bit_10.col",
		txd = "files/v4_map_expansion/v4_map_expansion.txd"
	},
	["nw_bit_10_LOD"] = {
		type = "object",
		model = 11636,
		dff = "files/v4_map_expansion/nw_bit_10_LOD.dff",
		col = "files/v4_map_expansion/nw_bit_10.col",
		txd = "files/v4_map_expansion/v4_map_expansion_LOD.txd"
	},
	["nw_bit_11"] = {
		type = "object",
		model = 11513,
		dff = "files/v4_map_expansion/nw_bit_11.dff",
		col = "files/v4_map_expansion/nw_bit_11.col",
		txd = "files/v4_map_expansion/v4_map_expansion.txd"
	},
	["nw_bit_11_LOD"] = {
		type = "object",
		model = 11585,
		dff = "files/v4_map_expansion/nw_bit_11_LOD.dff",
		col = "files/v4_map_expansion/nw_bit_11.col",
		txd = "files/v4_map_expansion/v4_map_expansion_LOD.txd"
	},
	["nw_bit_16"] = {
		type = "object",
		model = 11518,
		dff = "files/v4_map_expansion/nw_bit_16.dff",
		col = "files/v4_map_expansion/nw_bit_16.col",
		txd = "files/v4_map_expansion/v4_map_expansion.txd"
	},
	["nw_bit_16_LOD"] = {
		type = "object",
		model = 11587,
		dff = "files/v4_map_expansion/nw_bit_16_LOD.dff",
		col = "files/v4_map_expansion/nw_bit_16.col",
		txd = "files/v4_map_expansion/v4_map_expansion_LOD.txd"
	},
	["nw_bit_21"] = {
		type = "object",
		model = 11523,
		dff = "files/v4_map_expansion/nw_bit_21.dff",
		col = "files/v4_map_expansion/nw_bit_21.col",
		txd = "files/v4_map_expansion/v4_map_expansion.txd"
	},
	["nw_bit_21_LOD"] = {
		type = "object",
		model = 11645,
		dff = "files/v4_map_expansion/nw_bit_21_LOD.dff",
		col = "files/v4_map_expansion/nw_bit_21.col",
		txd = "files/v4_map_expansion/v4_map_expansion_LOD.txd"
	},
	["nw_bit_21_bridge"] = {
		type = "object",
		model = "object",
		dff = "files/v4_map_expansion/nw_bit_21_bridge.dff",
		col = "files/v4_map_expansion/nw_bit_21_bridge.col",
		txd = "files/v4_map_expansion/v4_map_expansion.txd",
		lodDistance = 300
	},
	["nw_bit_25"] = {
		type = "object",
		model = 11527,
		dff = "files/v4_map_expansion/nw_bit_25.dff",
		col = "files/v4_map_expansion/nw_bit_25.col",
		txd = "files/v4_map_expansion/v4_map_expansion.txd"
	},
	["nw_bit_25_LOD"] = {
		type = "object",
		model = 11582,
		dff = "files/v4_map_expansion/nw_bit_25_LOD.dff",
		col = "files/v4_map_expansion/nw_bit_25.col",
		txd = "files/v4_map_expansion/v4_map_expansion_LOD.txd"
	},
	["nw_bit_26"] = {
		type = "object",
		model = 11528,
		dff = "files/v4_map_expansion/nw_bit_26.dff",
		col = "files/v4_map_expansion/nw_bit_26.col",
		txd = "files/v4_map_expansion/v4_map_expansion.txd"
	},
	["nw_bit_26_LOD"] = {
		type = "object",
		model = 11573,
		dff = "files/v4_map_expansion/nw_bit_26_LOD.dff",
		col = "files/v4_map_expansion/nw_bit_26.col",
		txd = "files/v4_map_expansion/v4_map_expansion_LOD.txd"
	},
	["pylon-wires11"] = {
		type = "object",
		model = 11609,
		dff = "files/v4_map_expansion/pylon-wires11.dff",
		txd = "files/v4_map_expansion/v4_map_expansion.txd",
		transparent = true
	},
	["sbCE_groundPALO09"] = {
		type = "object",
		model = 4254,
		dff = "files/v4_map_expansion/seabed/sbCE_groundPALO09.dff",
		col = "files/v4_map_expansion/seabed/sbCE_groundPALO09.col",
		txd = "files/v4_map_expansion/v4_map_expansion.txd",
		lodDistance = 1500
	},
	["sbcn2_seafloor01"] = {
		type = "object",
		model = 4330,
		dff = "files/v4_map_expansion/seabed/sbcn2_seafloor01.dff",
		col = "files/v4_map_expansion/seabed/sbcn2_seafloor01.col",
		txd = "files/v4_map_expansion/v4_map_expansion.txd",
		lodDistance = 1500
	},
	["sbcn2_seafloor02"] = {
		type = "object",
		model = 4331,
		dff = "files/v4_map_expansion/seabed/sbcn2_seafloor02.dff",
		col = "files/v4_map_expansion/seabed/sbcn2_seafloor02.col",
		txd = "files/v4_map_expansion/v4_map_expansion.txd",
		lodDistance = 1500
	},
	["sbcn2_seafloor03"] = {
		type = "object",
		model = 4332,
		dff = "files/v4_map_expansion/seabed/sbcn2_seafloor03.dff",
		col = "files/v4_map_expansion/seabed/sbcn2_seafloor03.col",
		txd = "files/v4_map_expansion/v4_map_expansion.txd",
		lodDistance = 1500
	},
	["sbcn2_seafloor04"] = {
		type = "object",
		model = 4333,
		dff = "files/v4_map_expansion/seabed/sbcn2_seafloor04.dff",
		col = "files/v4_map_expansion/seabed/sbcn2_seafloor04.col",
		txd = "files/v4_map_expansion/v4_map_expansion.txd",
		lodDistance = 1500
	},
	["sbcn_seafloor01"] = {
		type = "object",
		model = 4319,
		dff = "files/v4_map_expansion/seabed/sbcn_seafloor01.dff",
		col = "files/v4_map_expansion/seabed/sbcn_seafloor01.col",
		txd = "files/v4_map_expansion/v4_map_expansion.txd",
		lodDistance = 1500
	},
	["sbcn_seafloor02"] = {
		type = "object",
		model = 4540,
		dff = "files/v4_map_expansion/seabed/sbcn_seafloor02.dff",
		col = "files/v4_map_expansion/seabed/sbcn_seafloor02.col",
		txd = "files/v4_map_expansion/v4_map_expansion.txd",
		lodDistance = 1500
	},
	["sbcn_seafloor03"] = {
		type = "object",
		model = 4317,
		dff = "files/v4_map_expansion/seabed/sbcn_seafloor03.dff",
		col = "files/v4_map_expansion/seabed/sbcn_seafloor03.col",
		txd = "files/v4_map_expansion/v4_map_expansion.txd",
		lodDistance = 1500
	},
	["sbcn_seafloor04"] = {
		type = "object",
		model = 4318,
		dff = "files/v4_map_expansion/seabed/sbcn_seafloor04.dff",
		col = "files/v4_map_expansion/seabed/sbcn_seafloor04.col",
		txd = "files/v4_map_expansion/v4_map_expansion.txd",
		lodDistance = 1500
	},
	["sbcn_seafloor05"] = {
		type = "object",
		model = 4320,
		dff = "files/v4_map_expansion/seabed/sbcn_seafloor05.dff",
		col = "files/v4_map_expansion/seabed/sbcn_seafloor05.col",
		txd = "files/v4_map_expansion/v4_map_expansion.txd",
		lodDistance = 1500
	},
	["sbcn_seafloor06"] = {
		type = "object",
		model = 4321,
		dff = "files/v4_map_expansion/seabed/sbcn_seafloor06.dff",
		col = "files/v4_map_expansion/seabed/sbcn_seafloor06.col",
		txd = "files/v4_map_expansion/v4_map_expansion.txd",
		lodDistance = 1500
	},
	["sbcn_seafloor07"] = {
		type = "object",
		model = 4322,
		dff = "files/v4_map_expansion/seabed/sbcn_seafloor07.dff",
		col = "files/v4_map_expansion/seabed/sbcn_seafloor07.col",
		txd = "files/v4_map_expansion/v4_map_expansion.txd",
		lodDistance = 1500
	},
	["sbcn_seafloor08"] = {
		type = "object",
		model = 4327,
		dff = "files/v4_map_expansion/seabed/sbcn_seafloor08.dff",
		col = "files/v4_map_expansion/seabed/sbcn_seafloor08.col",
		txd = "files/v4_map_expansion/v4_map_expansion.txd",
		lodDistance = 1500
	},
	["sbcn_seafloor09"] = {
		type = "object",
		model = 4328,
		dff = "files/v4_map_expansion/seabed/sbcn_seafloor09.dff",
		col = "files/v4_map_expansion/seabed/sbcn_seafloor09.col",
		txd = "files/v4_map_expansion/v4_map_expansion.txd",
		lodDistance = 1500
	},
	["sbcn_seafloor10"] = {
		type = "object",
		model = 4329,
		dff = "files/v4_map_expansion/seabed/sbcn_seafloor10.dff",
		col = "files/v4_map_expansion/seabed/sbcn_seafloor10.col",
		txd = "files/v4_map_expansion/v4_map_expansion.txd",
		lodDistance = 1500
	},
	["sbObject08"] = {
		type = "object",
		model = 4367,
		dff = "files/v4_map_expansion/seabed/sbObject08.dff",
		col = "files/v4_map_expansion/seabed/sbObject08.col",
		txd = "files/v4_map_expansion/v4_map_expansion.txd",
		lodDistance = 1500
	},
	["sbObject09"] = {
		type = "object",
		model = 4368,
		dff = "files/v4_map_expansion/seabed/sbObject09.dff",
		col = "files/v4_map_expansion/seabed/sbObject09.col",
		txd = "files/v4_map_expansion/v4_map_expansion.txd",
		lodDistance = 1500
	},
	["sbvgsEseafloor03"] = {
		type = "object",
		model = 4334,
		dff = "files/v4_map_expansion/seabed/sbvgsEseafloor03.dff",
		col = "files/v4_map_expansion/seabed/sbvgsEseafloor03.col",
		txd = "files/v4_map_expansion/v4_map_expansion.txd",
		lodDistance = 1500
	},
	["sbvgsSseafloor04"] = {
		type = "object",
		model = 4346,
		dff = "files/v4_map_expansion/seabed/sbvgsSseafloor04.dff",
		col = "files/v4_map_expansion/seabed/sbvgsSseafloor04.col",
		txd = "files/v4_map_expansion/v4_map_expansion.txd",
		lodDistance = 1500
	},
	["sbvgsSseafloor05"] = {
		type = "object",
		model = 4345,
		dff = "files/v4_map_expansion/seabed/sbvgsSseafloor05.dff",
		col = "files/v4_map_expansion/seabed/sbvgsSseafloor05.col",
		txd = "files/v4_map_expansion/v4_map_expansion.txd",
		lodDistance = 1500
	},
	["v4_seabed_custom"] = {
		type = "object",
		model = "object",
		dff = "files/v4_map_expansion/seabed/v4_seabed_custom.dff",
		col = "files/v4_map_expansion/seabed/v4_seabed_custom.col",
		txd = "files/v4_map_expansion/v4_map_expansion.txd",
		lodDistance = 300
	},
	["v4_seabed_custom_LOD"] = {
		type = "object",
		model = "object",
		dff = "files/v4_map_expansion/seabed/v4_seabed_custom_LOD.dff",
		col = "files/v4_map_expansion/seabed/v4_seabed_custom.col",
		txd = "files/v4_map_expansion/v4_map_expansion_LOD.txd",
		lodDistance = 1500
	},
	["CE_farmland03"] = {
		type = "object",
		model = 13051,
		dff = "files/v4_map_expansion/fixes/CE_farmland03.dff",
		col = "files/v4_map_expansion/fixes/CE_farmland03.col",
		txd = "files/v4_map_expansion/v4_map_expansion.txd"
	},
	["CE_farmland03_LOD"] = {
		type = "object",
		model = 13415,
		dff = "files/v4_map_expansion/fixes/CE_farmland03_LOD.dff",
		col = "files/v4_map_expansion/fixes/CE_farmland03.col",
		txd = "files/v4_map_expansion/v4_map_expansion_LOD.txd"
	},
	["cunte_roads11"] = {
		type = "object",
		model = 12809,
		dff = "files/v4_map_expansion/fixes/cunte_roads11.dff",
		col = "files/v4_map_expansion/fixes/cunte_roads11.col",
		txd = "files/v4_map_expansion/v4_map_expansion.txd"
	},
	["cunte_roads11_LOD"] = {
		type = "object",
		model = 13417,
		dff = "files/v4_map_expansion/fixes/cunte_roads11_LOD.dff",
		col = "files/v4_map_expansion/fixes/cunte_roads11.col",
		txd = "files/v4_map_expansion/v4_map_expansion_LOD.txd"
	},
	["cunte_roads08"] = {
		type = "object",
		model = 12806,
		dff = "files/v4_map_expansion/fixes/cunte_roads08.dff",
		col = "files/v4_map_expansion/fixes/cunte_roads08.col",
		txd = "files/v4_map_expansion/v4_map_expansion.txd"
	},
	["cunte_roads08_LOD"] = {
		type = "object",
		model = 13392,
		dff = "files/v4_map_expansion/fixes/cunte_roads08_LOD.dff",
		col = "files/v4_map_expansion/fixes/cunte_roads08.col",
		txd = "files/v4_map_expansion/v4_map_expansion_LOD.txd"
	},
	["cuntEground43"] = {
		type = "object",
		model = 12872,
		dff = "files/v4_map_expansion/fixes/cuntEground43.dff",
		col = "files/v4_map_expansion/fixes/cuntEground43.col",
		txd = "files/v4_map_expansion/v4_map_expansion.txd"
	},
	["cuntEground43_LOD"] = {
		type = "object",
		model = 13073,
		dff = "files/v4_map_expansion/fixes/cuntEground43_LOD.dff",
		col = "files/v4_map_expansion/fixes/cuntEground43.col",
		txd = "files/v4_map_expansion/v4_map_expansion_LOD.txd"
	},
	["coe_traintrax_09"] = {
		type = "object",
		model = 12838,
		dff = "files/v4_map_expansion/fixes/coe_traintrax_09.dff",
		col = "files/v4_map_expansion/fixes/coe_traintrax_09.col",
		txd = "files/v4_map_expansion/v4_map_expansion.txd"
	},
	["coe_traintrax_09_LOD"] = {
		type = "object",
		model = 13316,
		dff = "files/v4_map_expansion/fixes/coe_traintrax_09_LOD.dff",
		col = "files/v4_map_expansion/fixes/coe_traintrax_09.col",
		txd = "files/v4_map_expansion/v4_map_expansion_LOD.txd"
	},
	["roadsSFSE13"] = {
		type = "object",
		model = 10858,
		dff = "files/v4_map_expansion/fixes/roadsSFSE13.dff",
		col = "files/v4_map_expansion/fixes/roadsSFSE13.col",
		txd = "files/v4_map_expansion/v4_map_expansion.txd"
	},
	["v4_mine_wall"] = {
		type = "object",
		model = "object",
		dff = "files/mining/v4_mine_wall.dff",
		col = "files/mining/v4_mine_wall.col",
		txd = "files/mining/v4_mine.txd"
	},
	["v4_mine_tunnel1"] = {
		type = "object",
		model = "object",
		dff = "files/mining/v4_mine_tunnel1.dff",
		col = "files/mining/v4_mine_tunnel.col",
		txd = "files/mining/v4_mine.txd"
	},
	["v4_mine_tunnel1_columnless"] = {
		type = "object",
		model = "object",
		dff = "files/mining/v4_mine_tunnel1_columnless.dff",
		col = "files/mining/v4_mine_tunnel.col",
		txd = "files/mining/v4_mine.txd"
	},
	["v4_mine_tunnel2"] = {
		type = "object",
		model = "object",
		dff = "files/mining/v4_mine_tunnel2.dff",
		col = "files/mining/v4_mine_tunnel.col",
		txd = "files/mining/v4_mine.txd"
	},
	["v4_mine_tunnel2_columnless"] = {
		type = "object",
		model = "object",
		dff = "files/mining/v4_mine_tunnel2_columnless.dff",
		col = "files/mining/v4_mine_tunnel.col",
		txd = "files/mining/v4_mine.txd"
	},
	["v4_mine_tunnel3"] = {
		type = "object",
		model = "object",
		dff = "files/mining/v4_mine_tunnel3.dff",
		col = "files/mining/v4_mine_tunnel.col",
		txd = "files/mining/v4_mine.txd"
	},
	["v4_mine_tunnel3_columnless"] = {
		type = "object",
		model = "object",
		dff = "files/mining/v4_mine_tunnel3_columnless.dff",
		col = "files/mining/v4_mine_tunnel.col",
		txd = "files/mining/v4_mine.txd"
	},
	["v4_mine_tunnel4"] = {
		type = "object",
		model = "object",
		dff = "files/mining/v4_mine_tunnel4.dff",
		col = "files/mining/v4_mine_tunnel.col",
		txd = "files/mining/v4_mine.txd"
	},
	["v4_mine_tunnel4_columnless"] = {
		type = "object",
		model = "object",
		dff = "files/mining/v4_mine_tunnel4_columnless.dff",
		col = "files/mining/v4_mine_tunnel.col",
		txd = "files/mining/v4_mine.txd"
	},
	["v4_mine_tunnel5"] = {
		type = "object",
		model = "object",
		dff = "files/mining/v4_mine_tunnel5.dff",
		col = "files/mining/v4_mine_tunnel.col",
		txd = "files/mining/v4_mine.txd"
	},
	["v4_mine_tunnel5_columnless"] = {
		type = "object",
		model = "object",
		dff = "files/mining/v4_mine_tunnel5_columnless.dff",
		col = "files/mining/v4_mine_tunnel.col",
		txd = "files/mining/v4_mine.txd"
	},
	["v4_mine_tunnel_left1"] = {
		type = "object",
		model = "object",
		dff = "files/mining/v4_mine_tunnel_left1.dff",
		col = "files/mining/v4_mine_tunnel_left.col",
		txd = "files/mining/v4_mine.txd"
	},
	["v4_mine_tunnel_left2"] = {
		type = "object",
		model = "object",
		dff = "files/mining/v4_mine_tunnel_left2.dff",
		col = "files/mining/v4_mine_tunnel_left.col",
		txd = "files/mining/v4_mine.txd"
	},
	["v4_mine_tunnel_left3"] = {
		type = "object",
		model = "object",
		dff = "files/mining/v4_mine_tunnel_left3.dff",
		col = "files/mining/v4_mine_tunnel_left.col",
		txd = "files/mining/v4_mine.txd"
	},
	["v4_mine_tunnel_left4"] = {
		type = "object",
		model = "object",
		dff = "files/mining/v4_mine_tunnel_left4.dff",
		col = "files/mining/v4_mine_tunnel_left.col",
		txd = "files/mining/v4_mine.txd"
	},
	["v4_mine_tunnel_left5"] = {
		type = "object",
		model = "object",
		dff = "files/mining/v4_mine_tunnel_left5.dff",
		col = "files/mining/v4_mine_tunnel_left.col",
		txd = "files/mining/v4_mine.txd"
	},
	["v4_mine_tunnel_crossing1"] = {
		type = "object",
		model = "object",
		dff = "files/mining/v4_mine_tunnel_crossing1.dff",
		col = "files/mining/v4_mine_tunnel_crossing.col",
		txd = "files/mining/v4_mine.txd"
	},
	["v4_mine_tunnel_crossing2"] = {
		type = "object",
		model = "object",
		dff = "files/mining/v4_mine_tunnel_crossing2.dff",
		col = "files/mining/v4_mine_tunnel_crossing.col",
		txd = "files/mining/v4_mine.txd"
	},
	["v4_mine_tunnel_crossing3"] = {
		type = "object",
		model = "object",
		dff = "files/mining/v4_mine_tunnel_crossing3.dff",
		col = "files/mining/v4_mine_tunnel_crossing.col",
		txd = "files/mining/v4_mine.txd"
	},
	["v4_mine_tunnel_crossing4"] = {
		type = "object",
		model = "object",
		dff = "files/mining/v4_mine_tunnel_crossing4.dff",
		col = "files/mining/v4_mine_tunnel_crossing.col",
		txd = "files/mining/v4_mine.txd"
	},
	["v4_mine_tunnel_crossing5"] = {
		type = "object",
		model = "object",
		dff = "files/mining/v4_mine_tunnel_crossing5.dff",
		col = "files/mining/v4_mine_tunnel_crossing.col",
		txd = "files/mining/v4_mine.txd"
	},
	["v4_mine_rail"] = {
		type = "object",
		model = "object",
		dff = "files/mining/v4_mine_rail.dff",
		col = "files/mining/v4_mine_rail.col",
		txd = "files/mining/v4_mine.txd"
	},
	["v4_mine_rail_end"] = {
		type = "object",
		model = "object",
		dff = "files/mining/v4_mine_rail_end.dff",
		col = "files/mining/v4_mine_rail_end.col",
		txd = "files/mining/v4_mine.txd"
	},
	["v4_mine_rail_left"] = {
		type = "object",
		model = "object",
		dff = "files/mining/v4_mine_rail_left.dff",
		col = "files/mining/v4_mine_rail_left.col",
		txd = "files/mining/v4_mine.txd"
	},
	["v4_mine_rail_3way"] = {
		type = "object",
		model = "object",
		dff = "files/mining/v4_mine_rail_3way.dff",
		col = "files/mining/v4_mine_rail_3way.col",
		txd = "files/mining/v4_mine.txd"
	},
	["v4_mine_rail_crossing"] = {
		type = "object",
		model = "object",
		dff = "files/mining/v4_mine_rail_crossing.dff",
		col = "files/mining/v4_mine_rail_crossing.col",
		txd = "files/mining/v4_mine.txd"
	},
	["v4_mine_hq"] = {
		type = "object",
		model = "object",
		dff = "files/mining/v4_mine_hq.dff",
		col = "files/mining/v4_mine_hq.col",
		txd = "files/mining/v4_mine.txd"
	},
	["v4_mine_lamp"] = {
		type = "object",
		model = "object",
		dff = "files/mining/v4_mine_lamp.dff",
		col = "files/mining/v4_mine_lamp.col",
		txd = "files/mining/v4_mine.txd"
	},
	["v4_mine_cart1"] = {
		type = "object",
		model = "object",
		dff = "files/mining/v4_mine_cart1.dff",
		col = "files/mining/v4_mine_cart1.col",
		txd = "files/mining/v4_mine.txd"
	},
	["v4_mine_urmamoto"] = {
		type = "object",
		model = "object",
		dff = "files/mining/v4_mine_urmamoto.dff",
		col = "files/mining/v4_mine_urmamoto.col",
		txd = "files/mining/v4_mine.txd"
	},
	["v4_mine_cart1_wheels"] = {
		type = "object",
		model = "object",
		dff = "files/mining/v4_mine_cart1_wheels.dff",
		col = "files/mining/v4_mine_cart1_wheels.col",
		txd = "files/mining/v4_mine.txd"
	},
	["v4_mine_cart1_turtle"] = {
		type = "object",
		model = "object",
		dff = "files/mining/v4_mine_cart1_turtle.dff",
		col = "files/mining/v4_mine_cart1_turtle.col",
		txd = "files/mining/v4_mine.txd"
	},
	["v4_mine_machine"] = {
		type = "object",
		model = "object",
		dff = "files/mining/v4_mine_machine.dff",
		col = "files/mining/v4_mine_machine.col",
		txd = "files/mining/v4_mine.txd"
	},
	["v4_mine_machine2"] = {
		type = "object",
		model = "object",
		dff = "files/mining/v4_mine_machine2.dff",
		col = "files/mining/v4_mine_machine2.col",
		txd = "files/mining/v4_mine.txd"
	},
	["v4_mine_machine_crusher"] = {
		type = "object",
		model = "object",
		dff = "files/mining/v4_mine_machine_crusher.dff",
		col = "files/mining/v4_mine_machine_crusher.col",
		txd = "files/mining/v4_mine.txd"
	},
	["v4_mine_silo"] = {
		type = "object",
		model = "object",
		dff = "files/mining/v4_mine_silo.dff",
		col = "files/mining/v4_mine_silo.col",
		txd = "files/mining/v4_mine.txd"
	},
	["v4_mine_ore1"] = {
		type = "object",
		model = "object",
		dff = "files/mining/v4_mine_ore1.dff",
		col = "files/mining/v4_mine_ore.col",
		txd = "files/mining/v4_mine.txd"
	},
	["v4_mine_ore2"] = {
		type = "object",
		model = "object",
		dff = "files/mining/v4_mine_ore2.dff",
		col = "files/mining/v4_mine_ore.col",
		txd = "files/mining/v4_mine.txd"
	},
	["v4_mine_ore3"] = {
		type = "object",
		model = "object",
		dff = "files/mining/v4_mine_ore3.dff",
		col = "files/mining/v4_mine_ore.col",
		txd = "files/mining/v4_mine.txd"
	},
	["v4_mine_ore4"] = {
		type = "object",
		model = "object",
		dff = "files/mining/v4_mine_ore4.dff",
		col = "files/mining/v4_mine_ore.col",
		txd = "files/mining/v4_mine.txd"
	},
	["v4_mine_ore5"] = {
		type = "object",
		model = "object",
		dff = "files/mining/v4_mine_ore5.dff",
		col = "files/mining/v4_mine_ore.col",
		txd = "files/mining/v4_mine.txd"
	},
	["v4_mining_hardhat"] = {
		type = "object",
		model = "object",
		dff = "files/mining/v4_mining_hardhat.dff",
		txd = "files/mining/v4_mine.txd"
	},
	["v4_mine_ore_debris"] = {
		type = "object",
		model = "object",
		dff = "files/mining/v4_mine_ore_debris.dff",
		col = "files/mining/v4_mine_ore_debris.col",
		txd = "files/mining/v4_mine.txd"
	},
	["v4_mine_ore_debris2"] = {
		type = "object",
		model = "object",
		dff = "files/mining/v4_mine_ore_debris2.dff",
		col = "files/mining/v4_mine_ore_debris2.col",
		txd = "files/mining/v4_mine.txd"
	},
	["v4_mine_box"] = {
		type = "object",
		model = "object",
		dff = "files/mining/v4_mine_box.dff",
		col = "files/mining/v4_mine_box.col",
		txd = "files/mining/v4_mine.txd"
	},
	["v4_mine_box_content"] = {
		type = "object",
		model = "object",
		dff = "files/mining/v4_mine_box_content.dff",
		col = "files/mining/v4_mine_box_content.col",
		txd = "files/mining/v4_mine.txd"
	},
	["v4_mine_furnace"] = {
		type = "object",
		model = "object",
		dff = "files/mining/v4_mine_furnace.dff",
		col = "files/mining/v4_mine_furnace.col",
		txd = "files/mining/v4_mine.txd"
	},
	["v4_mine_ingot"] = {
		type = "object",
		model = "object",
		dff = "files/mining/v4_mine_ingot.dff",
		col = "files/mining/v4_mine_ingot.col",
		txd = "files/mining/v4_mine.txd"
	},
	["v4_mine_flow"] = {
		type = "object",
		model = "object",
		dff = "files/mining/v4_mine_flow.dff",
		col = "files/mining/v4_mine_flow.col",
		txd = "files/mining/v4_mine.txd"
	},
	["v4_mine_lobby"] = {
		type = "object",
		model = "object",
		dff = "files/mining/v4_mine_lobby.dff",
		col = "files/mining/v4_mine_lobby.col",
		txd = "files/mining/v4_mine.txd"
	},
	["v4_mine_lobby_alpha"] = {
		type = "object",
		model = "object",
		dff = "files/mining/v4_mine_lobby_alpha.dff",
		col = "files/mining/v4_mine_lobby_alpha.col",
		txd = "files/v4_alpha_textures.txd",
		transparent = true,
		flags = {
			"no_zbuffer_write"
		}
	},
	["v4_mine_tank"] = {
		type = "object",
		model = "object",
		dff = "files/mining/v4_mine_tank.dff",
		col = "files/mining/v4_mine_tank.col",
		txd = "files/mining/v4_mine.txd"
	},
	["v4_mine_cargo_rail"] = {
		type = "object",
		model = "object",
		dff = "files/mining/v4_mine_cargo_rail.dff",
		col = "files/mining/v4_mine_cargo_rail.col",
		txd = "files/mining/v4_mine.txd"
	},
	["v4_mine_cargo_wood"] = {
		type = "object",
		model = "object",
		dff = "files/mining/v4_mine_cargo_wood.dff",
		col = "files/mining/v4_mine_cargo_wood.col",
		txd = "files/mining/v4_mine.txd"
	},
	["v4_mine_cargo_cart1"] = {
		type = "object",
		model = "object",
		dff = "files/mining/v4_mine_cargo_cart1.dff",
		col = "files/mining/v4_mine_cargo_cart1.col",
		txd = "files/mining/v4_mine.txd"
	},
	["v4_mine_cargo_urmamoto"] = {
		type = "object",
		model = "object",
		dff = "files/mining/v4_mine_cargo_urmamoto.dff",
		col = "files/mining/v4_mine_cargo_urmamoto.col",
		txd = "files/mining/v4_mine.txd"
	},
	["v4_mine_jerrycan"] = {
		type = "object",
		model = "object",
		dff = "files/mining/v4_mine_jerrycan.dff",
		col = "files/mining/v4_mine_jerrycan.col",
		txd = "files/mining/v4_mine.txd"
	},
	["v4_mine_table0"] = {
		type = "object",
		model = "object",
		dff = "files/mining/v4_mine_table0.dff",
		col = "files/mining/v4_mine_table.col",
		txd = "files/mining/v4_mine.txd"
	},
	["v4_mine_table1"] = {
		type = "object",
		model = "object",
		dff = "files/mining/v4_mine_table1.dff",
		col = "files/mining/v4_mine_table.col",
		txd = "files/mining/v4_mine.txd"
	},
	["v4_mine_table2"] = {
		type = "object",
		model = "object",
		dff = "files/mining/v4_mine_table2.dff",
		col = "files/mining/v4_mine_table.col",
		txd = "files/mining/v4_mine.txd"
	},
	["v4_mine_table3"] = {
		type = "object",
		model = "object",
		dff = "files/mining/v4_mine_table3.dff",
		col = "files/mining/v4_mine_table.col",
		txd = "files/mining/v4_mine.txd"
	},
	["v4_mine_table4"] = {
		type = "object",
		model = "object",
		dff = "files/mining/v4_mine_table4.dff",
		col = "files/mining/v4_mine_table.col",
		txd = "files/mining/v4_mine.txd"
	},
	["v4_mine_table5"] = {
		type = "object",
		model = "object",
		dff = "files/mining/v4_mine_table5.dff",
		col = "files/mining/v4_mine_table.col",
		txd = "files/mining/v4_mine.txd"
	},
	["v4_mine_tablet"] = {
		type = "object",
		model = "object",
		dff = "files/mining/v4_mine_tablet.dff",
		col = "files/mining/v4_mine_tablet.col",
		txd = "files/mining/v4_mine.txd"
	},
	["v4_mine_dynamite"] = {
		type = "object",
		model = "object",
		dff = "files/mining/v4_mine_dynamite.dff",
		col = "files/mining/v4_mine_dynamite.col",
		txd = "files/mining/v4_mine.txd"
	},
	["v4_mine_cargo_lamp"] = {
		type = "object",
		model = "object",
		dff = "files/mining/v4_mine_cargo_lamp.dff",
		col = "files/mining/v4_mine_cargo_lamp.col",
		txd = "files/mining/v4_mine.txd"
	},
	["land_SFN17"] = {
		type = "object",
		model = 9276,
		dff = "files/mining/mining_comp/land_SFN17.dff",
		col = "files/mining/mining_comp/land_SFN17.col",
		txd = "files/mining/v4_mine.txd"
	},
	["land_sfn21"] = {
		type = "object",
		model = 9223,
		dff = "files/mining/mining_comp/land_sfn21.dff",
		col = "files/mining/mining_comp/land_sfn21.col",
		txd = "files/mining/v4_mine.txd"
	},
	["SFN_PRESHEDGE1"] = {
		type = "object",
		model = 9331,
		dff = "files/mining/mining_comp/SFN_PRESHEDGE1.dff",
		col = "files/mining/mining_comp/SFN_PRESHEDGE1.col",
		txd = "files/mining/v4_mine.txd"
	},
	["SFN_wall_cm01"] = {
		type = "object",
		model = 9330,
		dff = "files/mining/mining_comp/SFN_wall_cm01.dff",
		col = "files/mining/mining_comp/SFN_wall_cm01.col",
		txd = "files/mining/v4_mine.txd"
	},
	["track01_SFN"] = {
		type = "object",
		model = 9239,
		dff = "files/mining/mining_comp/track01_SFN.dff",
		col = "files/mining/mining_comp/track01_SFN.col",
		txd = "files/mining/v4_mine.txd"
	},
	["track01_SFN_alpha"] = {
		type = "object",
		model = "object",
		dff = "files/mining/mining_comp/track01_SFN_alpha.dff",
		col = "files/mining/mining_comp/track01_SFN_alpha.col",
		txd = "files/v4_alpha_textures.txd",
		transparent = true,
		flags = {
			"no_zbuffer_write"
		},
		lodDistance = 300
	},
	["track01_SFN_props"] = {
		type = "object",
		model = "object",
		dff = "files/mining/mining_comp/track01_SFN_props.dff",
		col = "files/mining/mining_comp/track01_SFN_props.col",
		txd = "files/mining/v4_mine.txd",
		lodDistance = 75
	},
	["track01_SFN_props2"] = {
		type = "object",
		model = "object",
		dff = "files/mining/mining_comp/track01_SFN_props2.dff",
		col = "files/mining/mining_comp/track01_SFN_props2.col",
		txd = "files/mining/v4_mine.txd",
		lodDistance = 75
	},
	["track01_SFN_props3"] = {
		type = "object",
		model = "object",
		dff = "files/mining/mining_comp/track01_SFN_props3.dff",
		col = "files/mining/mining_comp/track01_SFN_props3.col",
		txd = "files/mining/v4_mine.txd",
		lodDistance = 75
	},
	["lod_land_SFN17"] = {
		type = "object",
		model = 9453,
		dff = "files/mining/mining_comp/lod_land_SFN17.dff",
		txd = "files/mining/v4_mine.txd"
	},
	["LODd_sfn21"] = {
		type = "object",
		model = 9406,
		dff = "files/mining/mining_comp/LODd_sfn21.dff",
		txd = "files/mining/v4_mine.txd"
	},
	["lod_wall_cm01"] = {
		type = "object",
		model = 9432,
		dff = "files/mining/mining_comp/lod_wall_cm01.dff",
		txd = "files/mining/v4_mine.txd"
	},
	["lodck01_sfn"] = {
		type = "object",
		model = 9405,
		dff = "files/mining/mining_comp/lodck01_sfn.dff",
		txd = "files/mining/v4_mine.txd"
	},
	["v4_miningshop"] = {
		type = "object",
		model = "object",
		dff = "files/mining/mining_comp/v4_miningshop.dff",
		col = "files/mining/mining_comp/v4_miningshop.col",
		txd = "files/mining/v4_mine.txd",
		lodDistance = 150
	},
	["v4_miningshop_LOD"] = {
		type = "object",
		model = "object",
		dff = "files/mining/mining_comp/v4_miningshop_LOD.dff",
		txd = "files/mining/v4_mine.txd",
		lodDistance = 10000
	},
	["v4_miningshop_door"] = {
		type = "object",
		model = "object",
		dff = "files/mining/mining_comp/v4_miningshop_door.dff",
		col = "files/mining/mining_comp/v4_miningshop_door.col",
		txd = "files/mining/v4_mine.txd",
		lodDistance = 150,
		dynamicDoor = true,
		transparent = true
	},
	["v4_miningshop_props"] = {
		type = "object",
		model = "object",
		dff = "files/mining/mining_comp/v4_miningshop_props.dff",
		col = "files/mining/mining_comp/v4_miningshop_props.col",
		txd = "files/mining/v4_mine.txd"
	},
	["v4_miningshop_window"] = {
		type = "object",
		model = "object",
		dff = "files/mining/mining_comp/v4_miningshop_window.dff",
		col = "files/mining/mining_comp/v4_miningshop_window.col",
		txd = "files/mining/v4_mine.txd",
		lodDistance = 150,
		transparent = true
	},
	["v4_miningshop_sign"] = {
		type = "object",
		model = "object",
		dff = "files/mining/mining_comp/v4_miningshop_sign.dff",
		col = "files/mining/mining_comp/v4_miningshop_sign.col",
		txd = "files/mining/v4_mine.txd",
		lodDistance = 250
	},
	["v4_mine_entrance1"] = {
		type = "object",
		model = "object",
		dff = "files/mining/v4_mine_entrance1.dff",
		col = "files/mining/v4_mine_entrance.col",
		txd = "files/mining/v4_mine.txd"
	},
	["v4_mine_entrance2"] = {
		type = "object",
		model = "object",
		dff = "files/mining/v4_mine_entrance2.dff",
		col = "files/mining/v4_mine_entrance.col",
		txd = "files/mining/v4_mine.txd"
	},
	["v4_mine_entrance3"] = {
		type = "object",
		model = "object",
		dff = "files/mining/v4_mine_entrance3.dff",
		col = "files/mining/v4_mine_entrance.col",
		txd = "files/mining/v4_mine.txd"
	},
	["v4_mine_entrance4"] = {
		type = "object",
		model = "object",
		dff = "files/mining/v4_mine_entrance4.dff",
		col = "files/mining/v4_mine_entrance.col",
		txd = "files/mining/v4_mine.txd"
	},
	["v4_mine_entrance5"] = {
		type = "object",
		model = "object",
		dff = "files/mining/v4_mine_entrance5.dff",
		col = "files/mining/v4_mine_entrance.col",
		txd = "files/mining/v4_mine.txd"
	},
	["v4_mine_entrance6"] = {
		type = "object",
		model = "object",
		dff = "files/mining/v4_mine_entrance6.dff",
		col = "files/mining/v4_mine_entrance.col",
		txd = "files/mining/v4_mine.txd"
	},
	["nw_bit_15"] = {
		type = "object",
		model = 11517,
		dff = "files/mining/nw_bit_15.dff",
		col = "files/mining/nw_bit_15.col",
		txd = "files/mining/nw_bit_mine.txd"
	},
	["nw_lodbit_15"] = {
		type = "object",
		model = 11586,
		dff = "files/mining/nw_lodbit_15.dff",
		txd = "files/mining/nw_bit_mine.txd"
	},
	["nw_bit_20"] = {
		type = "object",
		model = 11522,
		dff = "files/mining/nw_bit_20.dff",
		col = "files/mining/nw_bit_20.col",
		txd = "files/mining/nw_bit_mine.txd"
	},
	["nw_lodbit_20"] = {
		type = "object",
		model = 11588,
		dff = "files/mining/nw_lodbit_20.dff",
		txd = "files/mining/nw_bit_mine.txd"
	},
	["nw_bit_24"] = {
		type = "object",
		model = 11526,
		dff = "files/mining/nw_bit_24.dff",
		col = "files/mining/nw_bit_24.col",
		txd = "files/mining/nw_bit_mine.txd"
	},
	["nw_lodbit_24"] = {
		type = "object",
		model = 11584,
		dff = "files/mining/nw_lodbit_24.dff",
		txd = "files/mining/nw_bit_mine.txd"
	},
	["v4_mining_chest"] = {
		type = "object",
		model = "object",
		dff = "files/mining/v4_mining_chest.dff",
		txd = "files/mining/v4_mining_chest.txd"
	},
	["v4_mining_chest_top"] = {
		type = "object",
		model = "object",
		dff = "files/mining/v4_mining_chest_top.dff",
		txd = "files/mining/v4_mining_chest.txd"
	},
	["v4_mining_chest_lock"] = {
		type = "object",
		model = "object",
		dff = "files/mining/v4_mining_chest_lock.dff",
		txd = "files/mining/v4_mining_chest.txd"
	},
	["v4_mining_chest2"] = {
		type = "object",
		model = "object",
		dff = "files/mining/v4_mining_chest2.dff",
		txd = "files/mining/v4_mining_chest.txd"
	},
	["v4_seccam1"] = {
		type = "object",
		model = "object",
		dff = "files/objects/v4_seccam1.dff",
		col = "files/objects/v4_seccam1.col",
		txd = "files/objects/v4_seccam.txd"
	},
	["v4_seccam2"] = {
		type = "object",
		model = "object",
		dff = "files/objects/v4_seccam2.dff",
		col = "files/objects/v4_seccam2.col",
		txd = "files/objects/v4_seccam.txd"
	},
	["v4_seccam3"] = {
		type = "object",
		model = "object",
		dff = "files/objects/v4_seccam3.dff",
		col = "files/objects/v4_seccam1.col",
		txd = "files/objects/v4_seccam.txd"
	},
	["v4_strangers_clock"] = {
		type = "object",
		model = "object",
		dff = "files/objects/v4_strangers_clock.dff",
		txd = "files/objects/v4_strangers_clock.txd",
		col = "files/objects/v4_strangers_clock.col",
		transparent = true
	},
	["v4_strangers_clock_pendulum"] = {
		type = "object",
		model = "object",
		dff = "files/objects/v4_strangers_clock_pendulum.dff",
		txd = "files/objects/v4_strangers_clock.txd",
		col = "files/objects/v4_strangers_clock_pendulum.col"
	},
	["v4_strangers_portal"] = {
		type = "object",
		model = "object",
		dff = "files/objects/v4_strangers_portal.dff",
		txd = "files/objects/v4_strangers_portal.txd",
		col = "files/objects/v4_strangers_portal.col",
		transparent = true
	},
	["v4_phone"] = {
		type = "object",
		model = "object",
		dff = "files/objects/v4_phone.dff",
		txd = "files/objects/v4_phone.txd"
	},
	["v4_tablet"] = {
		type = "object",
		model = "object",
		dff = "files/objects/v4_tablet.dff",
		txd = "files/objects/v4_tablet.txd"
	},
	["v4_trashcan1"] = {
		type = "object",
		model = 1328,
		dff = "files/objects/v4_trashcan1.dff",
		col = "files/objects/v4_trashcan1.col",
		txd = "files/objects/v4_trashcan.txd",
		static = true,
		lodDistance = 50
	},
	["v4_trashcan2"] = {
		type = "object",
		model = 1339,
		dff = "files/objects/v4_trashcan2.dff",
		col = "files/objects/v4_trashcan2.col",
		txd = "files/objects/v4_trashcan.txd",
		static = true,
		lodDistance = 50
	},
	["v4_trashcan3"] = {
		type = "object",
		model = 1337,
		dff = "files/objects/v4_trashcan3.dff",
		col = "files/objects/v4_trashcan2.col",
		txd = "files/objects/v4_trashcan.txd",
		static = true,
		lodDistance = 50
	},
	["v4_trashcan4"] = {
		type = "object",
		model = 1359,
		dff = "files/objects/v4_trashcan4.dff",
		col = "files/objects/v4_trashcan4.col",
		txd = "files/objects/v4_trashcan.txd",
		transparent = true,
		static = true,
		lodDistance = 50
	},
	["v4_trashcan5"] = {
		type = "object",
		model = 1329,
		dff = "files/objects/v4_trashcan5.dff",
		col = "files/objects/v4_trashcan5.col",
		txd = "files/objects/v4_trashcan.txd",
		static = true,
		lodDistance = 50
	},
	["v4_trashcan6"] = {
		type = "object",
		model = 1330,
		dff = "files/objects/v4_trashcan6.dff",
		col = "files/objects/v4_trashcan5.col",
		txd = "files/objects/v4_trashcan.txd",
		static = true,
		lodDistance = 50
	},
	["v4_trashcan7"] = {
		type = "object",
		model = 1574,
		dff = "files/objects/v4_trashcan7.dff",
		col = "files/objects/v4_trashcan7.col",
		txd = "files/objects/v4_trashcan.txd",
		static = true,
		lodDistance = 50
	},
	["v4_trashcan7_lid"] = {
		type = "object",
		model = "object",
		dff = "files/objects/v4_trashcan7_lid.dff",
		col = "files/objects/v4_trashcan7_lid.col",
		txd = "files/objects/v4_trashcan.txd",
		static = true,
		lodDistance = 50
	},
	["frend"] = {
		type = "object",
		model = "object",
		dff = "files/objects/frend.dff",
		col = "files/objects/frend.col",
		txd = "files/objects/frend.txd"
	},
	["adminjail"] = {
		type = "object",
		model = "object",
		dff = "files/objects/adminjail.dff",
		col = "files/objects/adminjail.col",
		txd = "files/objects/adminjail.txd"
	},
	["flex"] = {
		type = "object",
		model = "object",
		dff = "files/objects/flex.dff",
		txd = "files/objects/flex.txd"
	},
	["billboards"] = {
		type = "object",
		model = "object",
		dff = "files/objects/billboards.dff",
		txd = "files/objects/billboards.txd",
		col = "files/objects/billboards.col"
	},
	["v4_billboard"] = {
		type = "object",
		model = "object",
		dff = "files/objects/billboard.dff",
		col = "files/objects/billboard.col",
		txd = "files/objects/billboard.txd",
		lodDistance = 500
	},
	["vizmertek"] = {
		type = "object",
		model = "object",
		dff = "files/objects/vizmertek.dff",
		txd = "files/objects/vizmertek.txd"
	},
	["koviubi"] = {
		type = "object",
		model = "object",
		dff = "files/objects/koviubi.dff",
		txd = "files/objects/koviubi.txd"
	},
	["student_sign"] = {
		type = "object",
		model = "object",
		dff = "files/objects/student_sign.dff",
		txd = "files/objects/student_sign.txd"
	},
	["taxilogo_on"] = {
		type = "object",
		model = "object",
		dff = "files/objects/taxilogo_on.dff",
		txd = "files/objects/taxilogo.txd"
	},
	["taxilogo_off"] = {
		type = "object",
		model = "object",
		dff = "files/objects/taxilogo_off.dff",
		txd = "files/objects/taxilogo.txd"
	},
	["seec"] = {
		type = "object",
		model = 13722,
		dff = "files/objects/seec.dff",
		col = "files/objects/seec.col",
		txd = "files/objects/seec.txd"
	},
	["seeclod"] = {
		type = "object",
		model = 13759,
		dff = "files/objects/seeclod.dff",
		txd = "files/objects/seeclod.txd"
	},
	["turas"] = {
		type = "object",
		model = "object",
		dff = "files/objects/turas.dff",
		col = "files/objects/turas.col",
		txd = "files/objects/turas.txd"
	},
	["turas2"] = {
		type = "object",
		model = "object",
		dff = "files/objects/turas2.dff",
		col = "files/objects/turas.col",
		txd = "files/objects/turas.txd"
	},
	["metal_detector"] = {
		type = "object",
		model = "object",
		dff = "files/objects/metal_detector.dff",
		txd = "files/objects/metal_detector.txd"
	},
	["container_ammo"] = {
		type = "object",
		model = "object",
		dff = "files/objects/container_ammo.dff",
		col = "files/objects/container.col",
		txd = "files/objects/container_ammo.txd",
		transparent = true
	},
	["container_ammo_top"] = {
		type = "object",
		model = "object",
		dff = "files/objects/container_ammo_top.dff",
		txd = "files/objects/container_ammo.txd",
		transparent = true
	},
	["container_blueprint"] = {
		type = "object",
		model = "object",
		dff = "files/objects/container_blueprint.dff",
		col = "files/objects/container.col",
		txd = "files/objects/container_blueprint.txd",
		transparent = true
	},
	["container_blueprint_top"] = {
		type = "object",
		model = "object",
		dff = "files/objects/container_blueprint_top.dff",
		col = "files/objects/container.col",
		txd = "files/objects/container_blueprint.txd",
		transparent = true
	},
	["container_drug"] = {
		type = "object",
		model = "object",
		dff = "files/objects/container_drug.dff",
		col = "files/objects/container.col",
		txd = "files/objects/container_drug.txd",
		transparent = true
	},
	["container_drug_top"] = {
		type = "object",
		model = "object",
		dff = "files/objects/container_drug_top.dff",
		txd = "files/objects/container_drug.txd",
		transparent = true
	},
	["container_drug_parts"] = {
		type = "object",
		model = "object",
		dff = "files/objects/container_drug_parts.dff",
		col = "files/objects/container.col",
		txd = "files/objects/container_drug_parts.txd",
		transparent = true
	},
	["container_drug_parts_top"] = {
		type = "object",
		model = "object",
		dff = "files/objects/container_drug_parts_top.dff",
		txd = "files/objects/container_drug_parts.txd",
		transparent = true
	},
	["container_weapon"] = {
		type = "object",
		model = "object",
		dff = "files/objects/container_weapon.dff",
		col = "files/objects/container.col",
		txd = "files/objects/container_weapon.txd",
		transparent = true
	},
	["container_weapon_top"] = {
		type = "object",
		model = "object",
		dff = "files/objects/container_weapon_top.dff",
		txd = "files/objects/container_weapon.txd",
		transparent = true
	},
	["container_weapon_parts"] = {
		type = "object",
		model = "object",
		dff = "files/objects/container_weapon_parts.dff",
		col = "files/objects/container.col",
		txd = "files/objects/container_weapon_parts.txd",
		transparent = true
	},
	["container_weapon_parts_top"] = {
		type = "object",
		model = "object",
		dff = "files/objects/container_weapon_parts_top.dff",
		txd = "files/objects/container_weapon_parts.txd",
		transparent = true
	},
	["v4_treasure_chest1"] = {
		type = "object",
		model = "object",
		dff = "files/objects/v4_treasure_chest1.dff",
		txd = "files/objects/v4_treasure_chest.txd",
		transparent = true
	},
	["v4_treasure_chest1_top"] = {
		type = "object",
		model = "object",
		dff = "files/objects/v4_treasure_chest1_top.dff",
		txd = "files/objects/v4_treasure_chest.txd",
		transparent = true
	},
	["v4_treasure_chest1_lock"] = {
		type = "object",
		model = "object",
		dff = "files/objects/v4_treasure_chest1_lock.dff",
		txd = "files/objects/v4_treasure_chest.txd",
		transparent = true
	},
	["v4_treasure_chest2"] = {
		type = "object",
		model = "object",
		dff = "files/objects/v4_treasure_chest2.dff",
		txd = "files/objects/v4_treasure_chest.txd",
		transparent = true
	},
	["v4_treasure_chest2_top"] = {
		type = "object",
		model = "object",
		dff = "files/objects/v4_treasure_chest2_top.dff",
		txd = "files/objects/v4_treasure_chest.txd",
		transparent = true
	},
	["v4_treasure_chest2_lock"] = {
		type = "object",
		model = "object",
		dff = "files/objects/v4_treasure_chest2_lock.dff",
		txd = "files/objects/v4_treasure_chest.txd",
		transparent = true
	},
	["flex_disc"] = {
		type = "object",
		model = "object",
		dff = "files/objects/flex_disc.dff",
		txd = "files/objects/flex.txd",
		transparent = true
	},
	["cos_liqinside"] = {
		type = "object",
		model = 12844,
		dff = "files/pawnshop/cos_liqinside.dff",
		txd = "files/pawnshop/v4_pawnshop.txd"
	},
	["cos_liqinsidebits"] = {
		type = "object",
		model = 12845,
		dff = "files/pawnshop/cos_liqinsidebits.dff",
		col = "files/pawnshop/cos_liqinsidebits.col",
		txd = "files/pawnshop/v4_pawnshop.txd"
	},
	["cos_liquorshop"] = {
		type = "object",
		model = 12843,
		dff = "files/pawnshop/cos_liquorshop.dff",
		txd = "files/pawnshop/v4_pawnshop.txd"
	},
	["v4_pawnshop_alpha"] = {
		type = "object",
		model = "object",
		dff = "files/pawnshop/v4_pawnshop_alpha.dff",
		col = "files/pawnshop/v4_pawnshop_alpha.col",
		txd = "files/pawnshop/v4_pawnshop.txd",
		transparent = true
	},
	["v4_pawnshop_door"] = {
		type = "object",
		model = "object",
		dff = "files/pawnshop/v4_pawnshop_door.dff",
		col = "files/pawnshop/v4_pawnshop_door.col",
		txd = "files/pawnshop/v4_pawnshop.txd",
		transparent = true,
		dynamicDoor = true
	},
	["cunte_roads06"] = {
		type = "object",
		model = 12803,
		dff = "files/pawnshop/cunte_roads06.dff",
		col = "files/pawnshop/cunte_roads06.col",
		txd = "files/pawnshop/v4_pawnshop.txd"
	},
	["LODcunte_roads06"] = {
		type = "object",
		model = 13287,
		dff = "files/pawnshop/LODcunte_roads06.dff"
	},
	["cunte_roads06_alpha"] = {
		type = "object",
		model = "object",
		dff = "files/pawnshop/cunte_roads06_alpha.dff",
		col = "files/pawnshop/cunte_roads06_alpha.col",
		txd = "files/v4_alpha_textures.txd",
		transparent = true,
		flags = {
			"no_zbuffer_write"
		},
		lodDistance = 250
	},
	["cunte_roads64"] = {
		type = "object",
		model = 12995,
		dff = "files/pawnshop/cunte_roads64.dff",
		col = "files/pawnshop/cunte_roads64.col",
		txd = "files/pawnshop/v4_pawnshop.txd"
	},
	["cunte_roads88"] = {
		type = "object",
		model = 13173,
		dff = "files/pawnshop/cunte_roads88.dff",
		col = "files/pawnshop/cunte_roads88.col",
		txd = "files/pawnshop/v4_pawnshop.txd"
	},
	["ce_wires01"] = {
		type = "object",
		model = 13436,
		dff = "files/pawnshop/ce_wires01.dff",
		transparent = true
	},
	["ce_nitewindows2"] = {
		type = "object",
		model = 13493,
		dff = "files/pawnshop/ce_nitewindows2.dff"
	},
	["meth_lab"] = {
		type = "object",
		model = "object",
		dff = "files/objects/meth_lab.dff",
		col = "files/objects/meth_lab.col",
		txd = "files/objects/meth_lab.txd"
	},
	["meth_lab_2"] = {
		type = "object",
		model = "object",
		dff = "files/objects/meth_lab_2.dff",
		col = "files/objects/meth_lab_2.col",
		txd = "files/objects/meth_lab.txd"
	},
	["v4_safe1"] = {
		type = "object",
		model = "object",
		dff = "files/objects/v4_safe1.dff",
		col = "files/objects/v4_safe1.col",
		txd = "files/objects/v4_safes.txd"
	},
	["v4_safe1_door"] = {
		type = "object",
		model = "object",
		dff = "files/objects/v4_safe1_door.dff",
		col = "files/objects/v4_safe1_door.col",
		txd = "files/objects/v4_safes.txd"
	},
	["v4_safe2"] = {
		type = "object",
		model = "object",
		dff = "files/objects/v4_safe2.dff",
		col = "files/objects/v4_safe2.col",
		txd = "files/objects/v4_safes.txd"
	},
	["v4_safe2_door"] = {
		type = "object",
		model = "object",
		dff = "files/objects/v4_safe2_door.dff",
		col = "files/objects/v4_safe2_door.col",
		txd = "files/objects/v4_safes.txd"
	},
	["v4_safe3"] = {
		type = "object",
		model = "object",
		dff = "files/objects/v4_safe3.dff",
		col = "files/objects/v4_safe3.col",
		txd = "files/objects/v4_safes.txd"
	},
	["v4_safe3_Ldoor"] = {
		type = "object",
		model = "object",
		dff = "files/objects/v4_safe3_Ldoor.dff",
		col = "files/objects/v4_safe3_Ldoor.col",
		txd = "files/objects/v4_safes.txd"
	},
	["v4_safe3_Rdoor"] = {
		type = "object",
		model = "object",
		dff = "files/objects/v4_safe3_Rdoor.dff",
		col = "files/objects/v4_safe3_Rdoor.col",
		txd = "files/objects/v4_safes.txd"
	},
	["windmill_alap"] = {
		type = "object",
		model = "object",
		dff = "files/objects/windmill_alap.dff",
		col = "files/objects/windmill_alap.col",
		txd = "files/objects/windmill.txd",
		lodDistance = 10000
	},
	["windmill_rotor"] = {
		type = "object",
		model = "object",
		dff = "files/objects/windmill_rotor.dff",
		col = "files/objects/windmill_rotor.col",
		txd = "files/objects/windmill.txd",
		lodDistance = 10000
	},
	["superpounch_glove"] = {
		type = "object",
		model = "object",
		dff = "files/objects/superpounch_glove.dff",
		txd = "files/objects/superpounch_glove.txd"
	},
	["dancehut"] = {
		type = "object",
		model = "object",
		dff = "files/objects/dancehut.dff",
		col = "files/objects/dancehut.col",
		txd = "files/objects/dancehut.txd",
		lodDistance = 100
	},
	["dancehut_LOD"] = {
		type = "object",
		model = "object",
		dff = "files/objects/dancehut_LOD.dff",
		txd = "files/objects/dancehut.txd",
		lodDistance = 1000
	},
	["dancehut_windows"] = {
		type = "object",
		model = "object",
		dff = "files/objects/dancehut_windows.dff",
		col = "files/objects/dancehut_windows.col",
		txd = "files/objects/dancehut.txd",
		transparent = true,
		lodDistance = 100
	},
	["dancehut_door1"] = {
		type = "object",
		model = "object",
		dff = "files/objects/dancehut_door1.dff",
		col = "files/objects/dancehut_door1.col",
		txd = "files/objects/dancehut.txd",
		dynamicDoor = true,
		lodDistance = 100
	},
	["dancehut_door2"] = {
		type = "object",
		model = "object",
		dff = "files/objects/dancehut_door2.dff",
		col = "files/objects/dancehut_door2.col",
		txd = "files/objects/dancehut.txd",
		dynamicDoor = true,
		lodDistance = 100
	},
	["dancehut_door3"] = {
		type = "object",
		model = "object",
		dff = "files/objects/dancehut_door3.dff",
		col = "files/objects/dancehut_door3.col",
		txd = "files/objects/dancehut.txd",
		dynamicDoor = true,
		lodDistance = 100
	},
	["Bar_BAR1"] = {
		type = "object",
		model = 18090,
		dff = "files/objects/Bar_BAR1.dff",
		txd = "files/objects/v4_alhambra.txd"
	},
	["int_bars"] = {
		type = "object",
		model = 18018,
		dff = "files/objects/int_bars.dff",
		txd = "files/objects/v4_alhambra.txd"
	},
	["billiard_table"] = {
		type = "object",
		model = 2964,
		dff = "files/objects/billiard_table.dff",
		col = "files/objects/billiard_table.col",
		txd = "files/objects/billiard_table.txd"
	},
	["v4_markerlogo"] = {
		type = "object",
		model = "object",
		dff = "files/objects/v4_markerlogo.dff",
		col = "files/objects/v4_markerlogo.col",
		txd = "files/v4_alpha_textures.txd",
		transparent = true
	},
	["v4_cashregister"] = {
		type = "object",
		model = "object",
		dff = "files/objects/v4_cashregister.dff",
		col = "files/objects/v4_cashregister.col",
		txd = "files/objects/v4_cashregister.txd"
	},
	["v4_cashregister_drawer"] = {
		type = "object",
		model = "object",
		dff = "files/objects/v4_cashregister_drawer.dff",
		col = "files/objects/v4_cashregister_drawer.col",
		txd = "files/objects/v4_cashregister.txd"
	},
	["v4_cashregister_cash"] = {
		type = "object",
		model = "object",
		dff = "files/objects/v4_cashregister_cash.dff",
		col = "files/objects/v4_cashregister_cash.col",
		txd = "files/objects/v4_cashregister.txd"
	},
	["v4_plugsee_charger"] = {
		type = "object",
		model = "object",
		dff = "files/objects/v4_plugsee_charger.dff",
		col = "files/objects/v4_plugsee_charger.col",
		txd = "files/objects/v4_plugsee_charger.txd"
	},
	["v4_plugsee_wallcharger"] = {
		type = "object",
		model = "object",
		dff = "files/objects/v4_plugsee_wallcharger.dff",
		col = "files/objects/v4_plugsee_wallcharger.col",
		txd = "files/objects/v4_plugsee_charger.txd"
	},
	["v4_plugsee_pistol"] = {
		type = "object",
		model = "object",
		dff = "files/objects/v4_plugsee_pistol.dff",
		txd = "files/objects/v4_plugsee_charger.txd"
	},
	["v4_vacation_suitcase"] = {
		type = "object",
		model = "object",
		dff = "files/objects/v4_vacation_suitcase.dff",
		txd = "files/objects/v4_vacation_suitcase.txd"
	},
	["v4_vacation_suitcase_handle"] = {
		type = "object",
		model = "object",
		dff = "files/objects/v4_vacation_suitcase_handle.dff",
		txd = "files/objects/v4_vacation_suitcase.txd"
	},
	["halloween_ghost"] = {
		type = "object",
		model = "object",
		dff = "files/halloween/halloween_ghost.dff",
		col = "files/halloween/halloween_ghost.col",
		txd = "files/halloween/v4_halloween.txd",
		transparent = true
	},
	["v4_protonpack"] = {
		type = "object",
		model = "object",
		dff = "files/halloween/v4_protonpack.dff",
		col = "files/halloween/v4_protonpack.col",
		txd = "files/halloween/v4_halloween.txd"
	},
	["v4_protongun"] = {
		type = "object",
		model = "object",
		dff = "files/halloween/v4_protongun.dff",
		col = "files/halloween/v4_protongun.col",
		txd = "files/halloween/v4_halloween.txd"
	},
	["v4_ghostdetector2000"] = {
		type = "object",
		model = "object",
		dff = "files/halloween/v4_ghostdetector2000.dff",
		txd = "files/halloween/v4_halloween.txd"
	},
	["impact_wrench"] = {
		type = "object",
		model = "object",
		dff = "files/mechanic/impact_wrench.dff",
		txd = "files/mechanic/impact_wrench.txd"
	},
	["suspension_front"] = {
		type = "object",
		model = "object",
		dff = "files/mechanic/suspension_front.dff",
		txd = "files/mechanic/suspension.txd"
	},
	["suspension_rear"] = {
		type = "object",
		model = "object",
		dff = "files/mechanic/suspension_rear.dff",
		txd = "files/mechanic/suspension.txd"
	},
	["brakedisc"] = {
		type = "object",
		model = "object",
		dff = "files/mechanic/brakedisc.dff",
		txd = "files/mechanic/brakedisc.txd"
	},
	["emelo_block"] = {
		type = "object",
		model = 3907,
		dff = "files/mechanic/emelo_block.dff",
		txd = "files/mechanic/emelo.txd",
		col = "files/mechanic/emelo_block.col"
	},
	["emelo_kar"] = {
		type = "object",
		model = 3918,
		dff = "files/mechanic/emelo_kar.dff",
		txd = "files/mechanic/emelo.txd",
		col = "files/mechanic/emelo_kar.col"
	},
	["bms_sign"] = {
		type = "object",
		model = "object",
		dff = "files/mechanic/bms_sign.dff",
		col = "files/mechanic/bms_sign.col",
		txd = "files/mechanic/bms_sign.txd"
	},
	["fix_sign"] = {
		type = "object",
		model = "object",
		dff = "files/mechanic/fix_sign.dff",
		col = "files/mechanic/fix_sign.col",
		txd = "files/mechanic/bms_sign.txd"
	},
	["junkyard_sign"] = {
		type = "object",
		model = "object",
		dff = "files/mechanic/junkyard_sign.dff",
		col = "files/mechanic/junkyard_sign.col",
		txd = "files/mechanic/bms_sign.txd"
	},
	["dyno_pad"] = {
		type = "object",
		model = "object",
		dff = "files/mechanic/dyno_pad.dff",
		txd = "files/mechanic/dyno_pad.txd",
		col = "files/mechanic/dyno_pad.col"
	},
	["dyno_rear"] = {
		type = "object",
		model = "object",
		dff = "files/mechanic/dyno_rear.dff",
		txd = "files/mechanic/dyno_pad.txd"
	},
	["dyno_roller"] = {
		type = "object",
		model = "object",
		dff = "files/mechanic/dyno_roller.dff",
		txd = "files/mechanic/dyno_pad.txd"
	},
	["dyno_fan"] = {
		type = "object",
		model = "object",
		dff = "files/mechanic/dyno_fan.dff",
		txd = "files/mechanic/dyno_pad.txd"
	},
	["kruton"] = {
		type = "object",
		model = "object",
		dff = "files/mechanic/kruton.dff",
		txd = "files/mechanic/wheel_align_machine.txd",
		col = "files/mechanic/kruton.col"
	},
	["mechanic_document"] = {
		type = "object",
		model = "object",
		dff = "files/mechanic/mechanic_document.dff",
		txd = "files/mechanic/mechanic_document.txd"
	},
	["wheel_align_machine"] = {
		type = "object",
		model = "object",
		dff = "files/mechanic/wheel_align_machine.dff",
		txd = "files/mechanic/wheel_align_machine.txd",
		col = "files/mechanic/wheel_align_machine.col"
	},
	["wheel_align_machine2"] = {
		type = "object",
		model = "object",
		dff = "files/mechanic/wheel_align_machine2.dff",
		txd = "files/mechanic/wheel_align_machine.txd"
	},
	["cylinder_head"] = {
		type = "object",
		model = "object",
		dff = "files/mechanic/cylinder_head.dff",
		txd = "files/mechanic/engine.txd"
	},
	["timing_belt"] = {
		type = "object",
		model = "object",
		dff = "files/mechanic/timing_belt.dff",
		txd = "files/mechanic/engine.txd"
	},
	["engine_block"] = {
		type = "object",
		model = "object",
		dff = "files/mechanic/engine_block.dff",
		txd = "files/mechanic/engine.txd"
	},
	["gasket"] = {
		type = "object",
		model = "object",
		dff = "files/mechanic/gasket.dff",
		txd = "files/mechanic/engine.txd"
	},
	["oil_sump"] = {
		type = "object",
		model = "object",
		dff = "files/mechanic/oil_sump.dff",
		txd = "files/mechanic/engine.txd"
	},
	["pistons"] = {
		type = "object",
		model = "object",
		dff = "files/mechanic/pistons.dff",
		txd = "files/mechanic/engine.txd"
	},
	["valve_cover"] = {
		type = "object",
		model = "object",
		dff = "files/mechanic/valve_cover.dff",
		txd = "files/mechanic/engine.txd"
	},
	["oil_gasket"] = {
		type = "object",
		model = "object",
		dff = "files/mechanic/oil_gasket.dff",
		txd = "files/mechanic/engine.txd"
	},
	["valve_gasket"] = {
		type = "object",
		model = "object",
		dff = "files/mechanic/valve_gasket.dff",
		txd = "files/mechanic/engine.txd"
	},
	["car_battery"] = {
		type = "object",
		model = "object",
		dff = "files/mechanic/car_battery.dff",
		txd = "files/mechanic/engine.txd"
	},
	["bika"] = {
		type = "object",
		model = "object",
		dff = "files/mechanic/bika.dff",
		txd = "files/mechanic/bika.txd"
	},
	["bika2"] = {
		type = "object",
		model = "object",
		dff = "files/mechanic/bika2.dff",
		txd = "files/mechanic/bika.txd"
	},
	["bika_rolled"] = {
		type = "object",
		model = "object",
		dff = "files/mechanic/bika_rolled.dff",
		txd = "files/mechanic/bika.txd"
	},
	["bika_red"] = {
		type = "object",
		model = "object",
		dff = "files/mechanic/bika_red.dff",
		txd = "files/mechanic/bika.txd"
	},
	["bika_black"] = {
		type = "object",
		model = "object",
		dff = "files/mechanic/bika_black.dff",
		txd = "files/mechanic/bika.txd"
	},
	["bika_garage"] = {
		type = "object",
		model = "object",
		dff = "files/mechanic/bika_garage.dff",
		txd = "files/mechanic/bika.txd"
	},
	["inspection_pad"] = {
		type = "object",
		model = "object",
		dff = "files/mechanic/inspection_pad.dff",
		col = "files/mechanic/inspection_pad.col",
		txd = "files/mechanic/wheel_align_machine.txd"
	},
	["inspection_pad2"] = {
		type = "object",
		model = "object",
		dff = "files/mechanic/inspection_pad2.dff",
		col = "files/mechanic/inspection_pad2.col",
		txd = "files/mechanic/wheel_align_machine.txd"
	},
	["carbon_monoxide_meter"] = {
		type = "object",
		model = "object",
		dff = "files/mechanic/carbon_monoxide_meter.dff",
		txd = "files/mechanic/carbon_monoxide_meter.txd"
	},
	["oil_drain_can"] = {
		type = "object",
		model = "object",
		dff = "files/mechanic/oil_drain_can.dff",
		txd = "files/mechanic/oil_drain_can.txd"
	},
	["motoroil"] = {
		type = "object",
		model = "object",
		dff = "files/mechanic/motoroil.dff",
		txd = "files/mechanic/motoroil.txd"
	},
	["mechanic_sign_1"] = {
		type = "object",
		model = "object",
		dff = "files/mechanic/mechanic_sign_1.dff",
		col = "files/mechanic/mechanic_signs_lil.col",
		txd = "files/mechanic/mechanic_signs.txd",
		transparent = true,
		flags = {
			"no_zbuffer_write"
		},
		lodDistance = 250
	},
	["mechanic_sign_2"] = {
		type = "object",
		model = "object",
		dff = "files/mechanic/mechanic_sign_2.dff",
		col = "files/mechanic/mechanic_signs_lil.col",
		txd = "files/mechanic/mechanic_signs.txd",
		transparent = true,
		flags = {
			"no_zbuffer_write"
		},
		lodDistance = 250
	},
	["mechanic_sign_3"] = {
		type = "object",
		model = "object",
		dff = "files/mechanic/mechanic_sign_3.dff",
		col = "files/mechanic/mechanic_signs_lil.col",
		txd = "files/mechanic/mechanic_signs.txd",
		transparent = true,
		flags = {
			"no_zbuffer_write"
		},
		lodDistance = 250
	},
	["mechanic_sign_4"] = {
		type = "object",
		model = "object",
		dff = "files/mechanic/mechanic_sign_4.dff",
		col = "files/mechanic/mechanic_signs_lil.col",
		txd = "files/mechanic/mechanic_signs.txd",
		transparent = true,
		flags = {
			"no_zbuffer_write"
		},
		lodDistance = 250
	},
	["mechanic_sign_5"] = {
		type = "object",
		model = "object",
		dff = "files/mechanic/mechanic_sign_5.dff",
		col = "files/mechanic/mechanic_signs_lil.col",
		txd = "files/mechanic/mechanic_signs.txd",
		transparent = true,
		flags = {
			"no_zbuffer_write"
		},
		lodDistance = 250
	},
	["mechanic_sign_6"] = {
		type = "object",
		model = "object",
		dff = "files/mechanic/mechanic_sign_6.dff",
		col = "files/mechanic/mechanic_signs_lil.col",
		txd = "files/mechanic/mechanic_signs.txd",
		transparent = true,
		flags = {
			"no_zbuffer_write"
		},
		lodDistance = 250
	},
	["mechanic_sign_futomu"] = {
		type = "object",
		model = "object",
		dff = "files/mechanic/mechanic_sign_futomu.dff",
		col = "files/mechanic/mechanic_signs_big.col",
		txd = "files/mechanic/mechanic_signs.txd",
		lodDistance = 200
	},
	["mechanic_sign_muszaki"] = {
		type = "object",
		model = "object",
		dff = "files/mechanic/mechanic_sign_muszaki.dff",
		col = "files/mechanic/mechanic_signs_big.col",
		txd = "files/mechanic/mechanic_signs.txd",
		lodDistance = 200
	},
	["tuning_workshop"] = {
		type = "object",
		model = 14404,
		dff = "files/mechanic/tuning_workshop.dff",
		col = "files/mechanic/tuning_workshop.col",
		txd = "files/mechanic/tuning_workshop.txd"
	},
	["tuning_workshop_transparents"] = {
		type = "object",
		model = "object",
		dff = "files/mechanic/tuning_workshop_transparents.dff",
		col = "files/mechanic/tuning_workshop.col",
		txd = "files/mechanic/tuning_workshop.txd",
		transparent = true
	},
	["tuning_workshop_props"] = {
		type = "object",
		model = "object",
		dff = "files/mechanic/tuning_workshop_props.dff",
		col = "files/mechanic/tuning_workshop_props.col",
		txd = "files/mechanic/tuning_workshop_props.txd"
	},
	["tuning_workshop_props2"] = {
		type = "object",
		model = "object",
		dff = "files/mechanic/tuning_workshop_props2.dff",
		col = "files/mechanic/tuning_workshop_props.col",
		txd = "files/mechanic/tuning_workshop_props.txd"
	},
	["tuning_workshop_exterior"] = {
		type = "object",
		model = "object",
		dff = "files/mechanic/tuning_workshop_exterior.dff",
		col = "files/mechanic/tuning_workshop_exterior.col",
		txd = "files/mechanic/tuning_workshop.txd",
		lodDistance = 200
	},
	["tuning_workshop_exteriorglass"] = {
		type = "object",
		model = "object",
		dff = "files/mechanic/tuning_workshop_exteriorglass.dff",
		col = "files/mechanic/tuning_workshop_exteriorglass.col",
		txd = "files/mechanic/tuning_workshop.txd",
		transparent = true,
		lodDistance = 200
	},
	["tuning_workshop_exterioralpha"] = {
		type = "object",
		model = "object",
		dff = "files/mechanic/tuning_workshop_exterioralpha.dff",
		col = "files/mechanic/tuning_workshop_exterioralpha.col",
		txd = "files/mechanic/tuning_workshop.txd",
		transparent = true,
		flags = {
			"no_zbuffer_write"
		},
		lodDistance = 250
	},
	["tuning_workshop_exteriorLOD"] = {
		type = "object",
		model = "object",
		dff = "files/mechanic/tuning_workshop_exteriorLOD.dff",
		col = "files/mechanic/tuning_workshop_exterior.col",
		txd = "files/mechanic/tuning_workshopLOD.txd",
		lodDistance = 10000
	},
	["cardan_shaft"] = {
		type = "object",
		model = "object",
		dff = "files/mechanic/cardan_shaft.dff",
		txd = "files/mechanic/engine.txd"
	},
	["half_shaft"] = {
		type = "object",
		model = "object",
		dff = "files/mechanic/half_shaft.dff",
		txd = "files/mechanic/engine.txd"
	},
	["exhaust_manifold"] = {
		type = "object",
		model = "object",
		dff = "files/mechanic/exhaust_manifold.dff",
		txd = "files/mechanic/engine.txd"
	},
	["intake_manifold"] = {
		type = "object",
		model = "object",
		dff = "files/mechanic/intake_manifold.dff",
		txd = "files/mechanic/engine.txd"
	},
	["transmission"] = {
		type = "object",
		model = "object",
		dff = "files/mechanic/transmission.dff",
		txd = "files/mechanic/engine.txd"
	},
	["turbo"] = {
		type = "object",
		model = "object",
		dff = "files/mechanic/turbo.dff",
		txd = "files/mechanic/engine.txd"
	},
	["differential"] = {
		type = "object",
		model = "object",
		dff = "files/mechanic/differential.dff",
		txd = "files/mechanic/engine.txd"
	},
	["transfer_case"] = {
		type = "object",
		model = "object",
		dff = "files/mechanic/transfer_case.dff",
		txd = "files/mechanic/engine.txd"
	},
	["ecu"] = {
		type = "object",
		model = "object",
		dff = "files/mechanic/ecu.dff",
		txd = "files/mechanic/engine.txd"
	},
	["supercharger"] = {
		type = "object",
		model = "object",
		dff = "files/mechanic/supercharger.dff",
		txd = "files/mechanic/supercharger.txd"
	},
	["supercharger_butterfly_valves"] = {
		type = "object",
		model = "object",
		dff = "files/mechanic/supercharger_butterfly_valves.dff",
		txd = "files/mechanic/supercharger.txd"
	},
	["supercharger_pully"] = {
		type = "object",
		model = "object",
		dff = "files/mechanic/supercharger_pully.dff",
		txd = "files/mechanic/supercharger.txd"
	},
	["supercharger_pully2"] = {
		type = "object",
		model = "object",
		dff = "files/mechanic/supercharger_pully2.dff",
		txd = "files/mechanic/supercharger.txd"
	},
	["cs_landbit_31"] = {
		type = "object",
		model = 18320,
		dff = "files/mechanic/cs_landbit_31.dff",
		txd = "files/mechanic/cs_scrapyard.txd"
	},
	["cs_landbit_01"] = {
		type = "object",
		model = 18364,
		dff = "files/mechanic/cs_landbit_01.dff",
		txd = "files/mechanic/cs_scrapyard.txd",
		col = "files/mechanic/cs_landbit_01.col"
	},
	["cs_landbit_01_alpha"] = {
		type = "object",
		model = "object",
		dff = "files/mechanic/cs_landbit_01_alpha.dff",
		txd = "files/v4_alpha_textures.txd",
		col = "files/mechanic/cs_landbit_01_alpha.col",
		transparent = true,
		flags = {
			"no_zbuffer_write"
		},
		lodDistance = 250
	},
	["ferryland_sfe111"] = {
		type = "object",
		model = 10300,
		dff = "files/mechanic/ferryland_sfe111.dff",
		txd = "files/mechanic/ferryland_sfe111.txd",
		col = "files/mechanic/ferryland_sfe111.col"
	},
	["ferryland_sfe111_alpha"] = {
		type = "object",
		model = "object",
		dff = "files/mechanic/ferryland_sfe111_alpha.dff",
		col = "files/mechanic/ferryland_sfe111_alpha.col",
		txd = "files/v4_alpha_textures.txd",
		transparent = true,
		flags = {
			"no_zbuffer_write"
		},
		lodDistance = 250
	},
	["sanpdmdock1_las2"] = {
		type = "object",
		model = 5146,
		dff = "files/mechanic/bms/sanpdmdock1_las2.dff",
		col = "files/mechanic/bms/sanpdmdock1_las2.col"
	},
	["sanpdmdock1_las2_alpha"] = {
		type = "object",
		model = "object",
		dff = "files/mechanic/bms/sanpdmdock1_las2_alpha.dff",
		col = "files/mechanic/bms/sanpdmdock1_las2_alpha.col",
		txd = "files/v4_alpha_textures.txd",
		transparent = true,
		flags = {
			"no_zbuffer_write"
		},
		lodDistance = 250
	},
	["sanpdmdocka_las2"] = {
		type = "object",
		model = 5176,
		dff = "files/mechanic/bms/sanpdmdocka_las2.dff",
		col = "files/mechanic/bms/sanpdmdocka_las2.col"
	},
	["dockfencee_las2"] = {
		type = "object",
		model = 5325,
		dff = "files/mechanic/bms/dockfencee_las2.dff",
		transparent = true
	},
	["v4_armbarrier"] = {
		type = "object",
		model = "object",
		dff = "files/mechanic/bms/v4_armbarrier.dff",
		col = "files/mechanic/bms/v4_armbarrier.col",
		txd = "files/mechanic/bms/v4_armbarrier.txd"
	},
	["v4_armbarrier2"] = {
		type = "object",
		model = 3893,
		dff = "files/mechanic/bms/v4_armbarrier2.dff",
		col = "files/mechanic/bms/v4_armbarrier2.col",
		txd = "files/mechanic/bms/v4_armbarrier.txd"
	},
	["v4_mechanic_hangar"] = {
		type = "object",
		model = "object",
		dff = "files/mechanic/v4_mechanic_hangar.dff",
		txd = "files/mechanic/v4_mechanic_hangar.txd",
		col = "files/mechanic/v4_mechanic_hangar.col",
		lodDistance = 250
	},
	["v4_mechanic_hangarLOD"] = {
		type = "object",
		model = "object",
		dff = "files/mechanic/v4_mechanic_hangarLOD.dff",
		txd = "files/mechanic/v4_mechanic_hangarLOD.txd",
		lodDistance = 10000
	},
	["v4_mechanic_hangar_blue"] = {
		type = "object",
		model = "object",
		dff = "files/mechanic/v4_mechanic_hangar_blue.dff",
		txd = "files/mechanic/v4_mechanic_hangar.txd",
		col = "files/mechanic/v4_mechanic_hangar.col",
		lodDistance = 250
	},
	["v4_mechanic_hangar_blueLOD"] = {
		type = "object",
		model = "object",
		dff = "files/mechanic/v4_mechanic_hangar_blueLOD.dff",
		txd = "files/mechanic/v4_mechanic_hangarLOD.txd",
		lodDistance = 10000
	},
	["v4_mechanic_hangar_red"] = {
		type = "object",
		model = "object",
		dff = "files/mechanic/v4_mechanic_hangar_red.dff",
		txd = "files/mechanic/v4_mechanic_hangar.txd",
		col = "files/mechanic/v4_mechanic_hangar.col",
		lodDistance = 250
	},
	["v4_mechanic_hangar_redLOD"] = {
		type = "object",
		model = "object",
		dff = "files/mechanic/v4_mechanic_hangar_redLOD.dff",
		txd = "files/mechanic/v4_mechanic_hangarLOD.txd",
		lodDistance = 10000
	},
	["v4_mechanic_hangar_white"] = {
		type = "object",
		model = "object",
		dff = "files/mechanic/v4_mechanic_hangar_white.dff",
		txd = "files/mechanic/v4_mechanic_hangar.txd",
		col = "files/mechanic/v4_mechanic_hangar.col",
		lodDistance = 250
	},
	["v4_mechanic_hangar_whiteLOD"] = {
		type = "object",
		model = "object",
		dff = "files/mechanic/v4_mechanic_hangar_whiteLOD.dff",
		txd = "files/mechanic/v4_mechanic_hangarLOD.txd",
		lodDistance = 10000
	},
	["v4_mechanic_hangar_furnitures"] = {
		type = "object",
		model = "object",
		dff = "files/mechanic/v4_mechanic_hangar_furnitures.dff",
		txd = "files/mechanic/v4_mechanic_hangar.txd",
		col = "files/mechanic/v4_mechanic_hangar_furnitures.col",
		lodDistance = 100
	},
	["v4_mechanic_shed"] = {
		type = "object",
		model = "object",
		dff = "files/mechanic/v4_mechanic_shed.dff",
		txd = "files/mechanic/v4_mechanic_hangar.txd",
		col = "files/mechanic/v4_mechanic_shed.col",
		lodDistance = 150
	},
	["v4_mechanic_shed_furnitures"] = {
		type = "object",
		model = "object",
		dff = "files/mechanic/v4_mechanic_shed_furnitures.dff",
		txd = "files/mechanic/v4_mechanic_hangar.txd",
		col = "files/mechanic/v4_mechanic_shed_furnitures.col",
		lodDistance = 75
	},
	["fctrygrnd01_lvs"] = {
		type = "object",
		model = 8547,
		dff = "files/mechanic/fctrygrnd01_lvs.dff",
		col = "files/mechanic/fctrygrnd01_lvs.col",
		txd = "files/mechanic/fctrygrnd01_lvs.txd"
	},
	["fctrygrnd01_lvs_fence"] = {
		type = "object",
		model = "object",
		dff = "files/mechanic/fctrygrnd01_lvs_fence.dff",
		col = "files/mechanic/fctrygrnd01_lvs_fence.col",
		txd = "files/mechanic/fctrygrnd01_lvs.txd",
		transparent = true,
		lodDistance = 150
	},
	["fctrygrnd01_lvs_alpha"] = {
		type = "object",
		model = "object",
		dff = "files/mechanic/fctrygrnd01_lvs_alpha.dff",
		col = "files/mechanic/fctrygrnd01_lvs_alpha.col",
		txd = "files/v4_alpha_textures.txd",
		transparent = true,
		flags = {
			"no_zbuffer_write"
		},
		lodDistance = 250
	},
	["garage_int"] = {
		type = "object",
		model = "object",
		dff = "files/garage/garage_int.dff",
		col = "files/garage/garage_int.col",
		txd = "files/garage/garage_int.txd",
		transparent = true
	},
	["garage_floor"] = {
		type = "object",
		model = "object",
		dff = "files/garage/garage_floor.dff",
		col = "files/garage/garage_int.col",
		txd = "files/garage/garage_int.txd",
		transparent = true
	},
	["garage_furnitures_1"] = {
		type = "object",
		model = "object",
		dff = "files/garage/garage_furnitures_1.dff",
		col = "files/garage/garage_furnitures_1.col",
		txd = "files/garage/garage_int.txd",
		transparent = true
	},
	["garage_furnitures_2"] = {
		type = "object",
		model = "object",
		dff = "files/garage/garage_furnitures_2.dff",
		col = "files/garage/garage_furnitures_2.col",
		txd = "files/garage/garage_int.txd",
		transparent = true
	},
	["garage_wall_1_1"] = {
		type = "object",
		model = "object",
		dff = "files/garage/garage_wall_1_1.dff",
		col = "files/garage/garage_wall_1_1.col",
		txd = "files/garage/garage_int.txd",
		transparent = true
	},
	["garage_wall_2_1"] = {
		type = "object",
		model = "object",
		dff = "files/garage/garage_wall_2_1.dff",
		col = "files/garage/garage_wall_2_1.col",
		txd = "files/garage/garage_int.txd",
		transparent = true
	},
	["garage_wall_1_2"] = {
		type = "object",
		model = "object",
		dff = "files/garage/garage_wall_1_2.dff",
		col = "files/garage/garage_wall_1_2.col",
		txd = "files/garage/garage_int.txd",
		transparent = true
	},
	["garage_wall_2_2"] = {
		type = "object",
		model = "object",
		dff = "files/garage/garage_wall_2_2.dff",
		col = "files/garage/garage_wall_2_2.col",
		txd = "files/garage/garage_int.txd",
		transparent = true
	},
	["v4_carlift_base"] = {
		type = "object",
		model = 3897,
		dff = "files/garage/v4_carlift_base.dff",
		col = "files/garage/v4_carlift_base.col",
		txd = "files/garage/v4_carlift.txd"
	},
	["v4_carlift_runway"] = {
		type = "object",
		model = 3916,
		dff = "files/garage/v4_carlift_runway.dff",
		col = "files/garage/v4_carlift_runway.col",
		txd = "files/garage/v4_carlift.txd"
	},
	["v4_workbench"] = {
		type = "object",
		model = 937,
		dff = "files/garage/v4_workbench.dff",
		col = "files/garage/v4_workbench.col",
		txd = "files/garage/v4_workbench.txd",
		transparent = true
	},
	["v4_hangar_int"] = {
		type = "object",
		model = 14784,
		dff = "files/garage/v4_hangar_int.dff",
		col = "files/garage/v4_hangar_int.col",
		txd = "files/garage/v4_hangar_int.txd"
	},
	["v4_hangar_frame"] = {
		type = "object",
		model = "object",
		dff = "files/garage/v4_hangar_frame.dff",
		col = "files/garage/v4_hangar_frame.col",
		txd = "files/garage/v4_hangar_int.txd",
		transparent = true
	},
	["v4_hangar_alpha"] = {
		type = "object",
		model = "object",
		dff = "files/garage/v4_hangar_alpha.dff",
		col = "files/garage/v4_hangar_alpha.col",
		txd = "files/v4_alpha_textures.txd",
		transparent = true,
		flags = {
			"no_zbuffer_write"
		},
		lodDistance = 250
	},
	["v4_hangar_lights"] = {
		type = "object",
		model = "object",
		dff = "files/garage/v4_hangar_lights.dff",
		col = "files/garage/v4_hangar_lights.col",
		txd = "files/garage/v4_hangar_int.txd"
	},
	["v4_soil_station"] = {
		type = "object",
		model = "object",
		dff = "files/petrol_station/v4_soil_station.dff",
		col = "files/petrol_station/v4_soil_station.col",
		txd = "files/petrol_station/v4_soil.txd",
		lodDistance = 300
	},
	["v4_soil_station_mid"] = {
		type = "object",
		model = "object",
		dff = "files/petrol_station/v4_soil_station_mid.dff",
		col = "files/petrol_station/v4_soil_station_mid.col",
		txd = "files/petrol_station/v4_soil.txd",
		lodDistance = 300
	},
	["v4_soil_station_LOD"] = {
		type = "object",
		model = "object",
		dff = "files/petrol_station/v4_soil_station_LOD.dff",
		txd = "files/petrol_station/v4_soil_LOD.txd",
		lodDistance = 10000
	},
	["v4_soil_station_mid_LOD"] = {
		type = "object",
		model = "object",
		dff = "files/petrol_station/v4_soil_station_mid_LOD.dff",
		txd = "files/petrol_station/v4_soil_LOD.txd",
		lodDistance = 10000
	},
	["v4_soil_pump"] = {
		type = "object",
		model = 1676,
		dff = "files/petrol_station/v4_soil_pump.dff",
		col = "files/petrol_station/v4_soil_pump.col",
		txd = "files/petrol_station/v4_soil.txd"
	},
	["v4_soil_store"] = {
		type = "object",
		model = "object",
		dff = "files/petrol_station/v4_soil_store.dff",
		col = "files/petrol_station/v4_soil_store.col",
		txd = "files/petrol_station/v4_soil.txd",
		lodDistance = 300
	},
	["v4_soil_store_LOD"] = {
		type = "object",
		model = "object",
		dff = "files/petrol_station/v4_soil_store_LOD.dff",
		txd = "files/petrol_station/v4_soil_LOD.txd",
		lodDistance = 10000
	},
	["v4_soil_store_alpha"] = {
		type = "object",
		model = "object",
		dff = "files/petrol_station/v4_soil_store_alpha.dff",
		col = "files/petrol_station/v4_soil_store.col",
		txd = "files/petrol_station/v4_soil.txd",
		transparent = true,
		lodDistance = 300
	},
	["v4_soil_store_prods"] = {
		type = "object",
		model = "object",
		dff = "files/petrol_station/v4_soil_store_prods.dff",
		col = "files/petrol_station/v4_soil_store.col",
		txd = "files/petrol_station/v4_soil.txd",
		lodDistance = 150
	},
	["v4_soil_sign"] = {
		type = "object",
		model = "object",
		dff = "files/petrol_station/v4_soil_sign.dff",
		col = "files/petrol_station/v4_soil_sign.col",
		txd = "files/petrol_station/v4_soil.txd",
		lodDistance = 300
	},
	["v4_soil_sign_LOD"] = {
		type = "object",
		model = "object",
		dff = "files/petrol_station/v4_soil_sign_LOD.dff",
		txd = "files/petrol_station/v4_soil_LOD.txd",
		lodDistance = 10000
	},
	["v4_soil_door"] = {
		type = "object",
		model = "object",
		dff = "files/petrol_station/v4_soil_door.dff",
		col = "files/petrol_station/v4_soil_door.col",
		txd = "files/petrol_station/v4_soil.txd",
		transparent = true,
		lodDistance = 300
	},
	["v4_soil_fuelnozzle"] = {
		type = "object",
		model = "object",
		dff = "files/petrol_station/v4_soil_fuelnozzle.dff",
		txd = "files/petrol_station/v4_soil.txd",
		lodDistance = 100
	},
	["v4_soil_fuelnozzle_diesel"] = {
		type = "object",
		model = "object",
		dff = "files/petrol_station/v4_soil_fuelnozzle_diesel.dff",
		txd = "files/petrol_station/v4_soil.txd",
		lodDistance = 100
	},
	["laeroad24"] = {
		type = "object",
		model = 5489,
		dff = "files/petrol_station/ground/laeroad24.dff",
		col = "files/petrol_station/ground/laeroad24.col",
		txd = "files/petrol_station/ground/v4_soil_ground.txd"
	},
	["laeroad24_alpha"] = {
		type = "object",
		model = "object",
		dff = "files/petrol_station/ground/laeroad24_alpha.dff",
		col = "files/petrol_station/ground/laeroad24_alpha.col",
		txd = "files/v4_alpha_textures.txd",
		transparent = true,
		flags = {
			"no_zbuffer_write"
		},
		lodDistance = 250
	},
	["laeroad24_LOD"] = {
		type = "object",
		model = 5533,
		dff = "files/petrol_station/ground/laeroad24_LOD.dff",
		col = "files/petrol_station/ground/laeroad24.col",
		txd = "files/petrol_station/ground/v4_soil_groundLOD.txd"
	},
	["laeroad38"] = {
		type = "object",
		model = 5503,
		dff = "files/petrol_station/ground/laeroad38.dff",
		col = "files/petrol_station/ground/laeroad38.col",
		txd = "files/petrol_station/ground/v4_soil_ground.txd"
	},
	["carwashalphas_lae"] = {
		type = "object",
		model = 5681,
		dff = "files/petrol_station/ground/carwashalphas_lae.dff",
		col = "files/petrol_station/ground/carwashalphas_lae.col",
		txd = "files/petrol_station/ground/v4_soil_ground.txd",
		transparent = true
	},
	["snpedteew1vv_las"] = {
		type = "object",
		model = 4983,
		dff = "files/petrol_station/ground/snpedteew1vv_las.dff",
		col = "files/petrol_station/ground/snpedteew1vv_las.col",
		txd = "files/petrol_station/ground/v4_soil_ground.txd",
		transparent = true
	},
	["sunset21_lawn"] = {
		type = "object",
		model = 5853,
		dff = "files/petrol_station/ground/sunset21_lawn.dff",
		col = "files/petrol_station/ground/sunset21_lawn.col",
		txd = "files/petrol_station/ground/v4_soil_ground.txd"
	},
	["sunset21_lawn_LOD"] = {
		type = "object",
		model = 5898,
		dff = "files/petrol_station/ground/sunset21_lawn_LOD.dff",
		col = "files/petrol_station/ground/sunset21_lawn.col",
		txd = "files/petrol_station/ground/v4_soil_groundLOD.txd"
	},
	["road_lawn13"] = {
		type = "object",
		model = 5752,
		dff = "files/petrol_station/ground/road_lawn13.dff",
		col = "files/petrol_station/ground/road_lawn13.col",
		txd = "files/petrol_station/ground/v4_soil_ground.txd"
	},
	["cuntwland49b"] = {
		type = "object",
		model = 17301,
		dff = "files/petrol_station/ground/cuntwland49b.dff",
		col = "files/petrol_station/ground/cuntwland49b.col",
		txd = "files/petrol_station/ground/v4_soil_ground.txd"
	},
	["cuntwland49b_alpha"] = {
		type = "object",
		model = "object",
		dff = "files/petrol_station/ground/cuntwland49b_alpha.dff",
		col = "files/petrol_station/ground/cuntwland49b_alpha.col",
		txd = "files/v4_alpha_textures.txd",
		transparent = true,
		flags = {
			"no_zbuffer_write"
		},
		lodDistance = 250
	},
	["cuntwland49b_LOD"] = {
		type = "object",
		model = 17421,
		dff = "files/petrol_station/ground/cuntwland49b_LOD.dff",
		col = "files/petrol_station/ground/cuntwland49b.col",
		txd = "files/petrol_station/ground/v4_soil_groundLOD.txd"
	},
	["cuntsrod13"] = {
		type = "object",
		model = 18484,
		dff = "files/petrol_station/ground/cuntsrod13.dff",
		col = "files/petrol_station/ground/cuntsrod13.col",
		txd = "files/petrol_station/ground/v4_soil_ground.txd"
	},
	["w_townwires_02"] = {
		type = "object",
		model = 18205,
		dff = "files/petrol_station/ground/w_townwires_02.dff",
		txd = "files/petrol_station/ground/v4_soil_ground.txd",
		transparent = true
	},
	["w_townwires_01"] = {
		type = "object",
		model = 18204,
		dff = "files/petrol_station/ground/w_townwires_01.dff",
		txd = "files/petrol_station/ground/v4_soil_ground.txd",
		transparent = true
	},
	["bigjunct_09_sfse"] = {
		type = "object",
		model = 10865,
		dff = "files/petrol_station/ground/bigjunct_09_sfse.dff",
		col = "files/petrol_station/ground/bigjunct_09_sfse.col",
		txd = "files/petrol_station/ground/v4_soil_ground.txd"
	},
	["roadssfse74"] = {
		type = "object",
		model = 11127,
		dff = "files/petrol_station/ground/roadssfse74.dff",
		col = "files/petrol_station/ground/roadssfse74.col",
		txd = "files/petrol_station/ground/v4_soil_ground.txd"
	},
	["sw_sheds_base"] = {
		type = "object",
		model = 12926,
		dff = "files/petrol_station/ground/sw_sheds_base.dff",
		col = "files/petrol_station/ground/sw_sheds_base.col",
		txd = "files/petrol_station/ground/v4_soil_ground.txd"
	},
	["sw_sheds_base_alpha"] = {
		type = "object",
		model = "object",
		dff = "files/petrol_station/ground/sw_sheds_base_alpha.dff",
		col = "files/petrol_station/ground/sw_sheds_base_alpha.col",
		txd = "files/v4_alpha_textures.txd",
		transparent = true,
		flags = {
			"no_zbuffer_write"
		},
		lodDistance = 250
	},
	["cunte_roads65"] = {
		type = "object",
		model = 12996,
		dff = "files/petrol_station/ground/cunte_roads65.dff",
		col = "files/petrol_station/ground/cunte_roads65.col",
		txd = "files/petrol_station/ground/v4_soil_ground.txd"
	},
	["cunte_roads59"] = {
		type = "object",
		model = 12893,
		dff = "files/petrol_station/ground/cunte_roads59.dff",
		col = "files/petrol_station/ground/cunte_roads59.col",
		txd = "files/petrol_station/ground/v4_soil_ground.txd"
	},
	["nw_bit_23"] = {
		type = "object",
		model = 11525,
		dff = "files/petrol_station/ground/nw_bit_23.dff",
		col = "files/petrol_station/ground/nw_bit_23.col",
		txd = "files/petrol_station/ground/v4_soil_ground.txd"
	},
	["nw_bit_23_grounddecals"] = {
		type = "object",
		model = "object",
		dff = "files/petrol_station/ground/nw_bit_23_grounddecals.dff",
		col = "files/petrol_station/ground/nw_bit_23_grounddecals.col",
		txd = "files/v4_alpha_textures.txd",
		transparent = true,
		flags = {
			"no_zbuffer_write"
		},
		lodDistance = 250
	},
	["nw_bit_23_plants"] = {
		type = "object",
		model = "object",
		dff = "files/petrol_station/ground/nw_bit_23_plants.dff",
		col = "files/petrol_station/ground/nw_bit_23_plants.col",
		txd = "files/petrol_station/ground/v4_soil_ground.txd",
		transparent = true
	},
	["nw_bit_10_grounddecals"] = {
		type = "object",
		model = "object",
		dff = "files/petrol_station/ground/nw_bit_10_grounddecals.dff",
		col = "files/petrol_station/ground/nw_bit_10_grounddecals.col",
		txd = "files/v4_alpha_textures.txd",
		transparent = true,
		flags = {
			"no_zbuffer_write"
		},
		lodDistance = 250
	},
	["CEgroundT201"] = {
		type = "object",
		model = 13297,
		dff = "files/petrol_station/ground/CEgroundT201.dff",
		col = "files/petrol_station/ground/CEgroundT201.col",
		txd = "files/petrol_station/ground/v4_soil_ground.txd"
	},
	["CEgroundT201_grounddecals"] = {
		type = "object",
		model = "object",
		dff = "files/petrol_station/ground/CEgroundT201_grounddecals.dff",
		col = "files/petrol_station/ground/CEgroundT201_grounddecals.col",
		txd = "files/v4_alpha_textures.txd",
		transparent = true,
		flags = {
			"no_zbuffer_write"
		},
		lodDistance = 250
	},
	["CE_nitewindows10"] = {
		type = "object",
		model = 13485,
		dff = "files/petrol_station/ground/CE_nitewindows10.dff",
		txd = "files/petrol_station/ground/v4_soil_ground.txd"
	},
	["carshop_int"] = {
		type = "object",
		model = "object",
		dff = "files/carshop/carshop_int.dff",
		col = "files/carshop/carshop_int.col",
		txd = "files/carshop/carshop.txd"
	},
	["carshop_int_floor"] = {
		type = "object",
		model = "object",
		dff = "files/carshop/carshop_int_floor.dff",
		col = "files/carshop/carshop_int.col",
		txd = "files/carshop/carshop.txd"
	},
	["laeJeffers02"] = {
		type = "object",
		model = 5414,
		dff = "files/carshop/laeJeffers02.dff",
		txd = "files/carshop/v4_carshopexterior.txd"
	},
	["motelalpha"] = {
		type = "object",
		model = 5632,
		dff = "files/carshop/motelalpha.dff",
		col = "files/carshop/motelalpha.col",
		txd = "files/carshop/v4_carshopexterior.txd"
	},
	["spinner1_chrome"] = {
		type = "object",
		model = "object",
		dff = "files/spinners/spinner1_chrome.dff",
		txd = "files/spinners/spinners.txd"
	},
	["spinner1_color"] = {
		type = "object",
		model = "object",
		dff = "files/spinners/spinner1_color.dff",
		txd = "files/spinners/spinners.txd"
	},
	["spinner2_chrome"] = {
		type = "object",
		model = "object",
		dff = "files/spinners/spinner2_chrome.dff",
		txd = "files/spinners/spinners.txd"
	},
	["spinner2_color"] = {
		type = "object",
		model = "object",
		dff = "files/spinners/spinner2_color.dff",
		txd = "files/spinners/spinners.txd"
	},
	["spinner3_chrome"] = {
		type = "object",
		model = "object",
		dff = "files/spinners/spinner3_chrome.dff",
		txd = "files/spinners/spinners.txd"
	},
	["spinner3_color"] = {
		type = "object",
		model = "object",
		dff = "files/spinners/spinner3_color.dff",
		txd = "files/spinners/spinners.txd"
	},
	["spinner4_chrome"] = {
		type = "object",
		model = "object",
		dff = "files/spinners/spinner4_chrome.dff",
		txd = "files/spinners/spinners.txd"
	},
	["spinner4_color"] = {
		type = "object",
		model = "object",
		dff = "files/spinners/spinner4_color.dff",
		txd = "files/spinners/spinners.txd"
	},
	["neon_white"] = {
		type = "object",
		model = "object",
		dff = "files/neons/neon_white.dff",
		col = "files/neons/neons.col"
	},
	["neon_white_lil"] = {
		type = "object",
		model = "object",
		dff = "files/neons/neon_white_lil.dff",
		col = "files/neons/neons.col"
	},
	["neon_blue"] = {
		type = "object",
		model = "object",
		dff = "files/neons/neon_blue.dff",
		col = "files/neons/neons.col"
	},
	["neon_blue_lil"] = {
		type = "object",
		model = "object",
		dff = "files/neons/neon_blue_lil.dff",
		col = "files/neons/neons.col"
	},
	["neon_lightblue"] = {
		type = "object",
		model = "object",
		dff = "files/neons/neon_lightblue.dff",
		col = "files/neons/neons.col"
	},
	["neon_lightblue_lil"] = {
		type = "object",
		model = "object",
		dff = "files/neons/neon_lightblue_lil.dff",
		col = "files/neons/neons.col"
	},
	["neon_red"] = {
		type = "object",
		model = "object",
		dff = "files/neons/neon_red.dff",
		col = "files/neons/neons.col"
	},
	["neon_red_lil"] = {
		type = "object",
		model = "object",
		dff = "files/neons/neon_red_lil.dff",
		col = "files/neons/neons.col"
	},
	["neon_orange"] = {
		type = "object",
		model = "object",
		dff = "files/neons/neon_orange.dff",
		col = "files/neons/neons.col"
	},
	["neon_orange_lil"] = {
		type = "object",
		model = "object",
		dff = "files/neons/neon_orange_lil.dff",
		col = "files/neons/neons.col"
	},
	["neon_green"] = {
		type = "object",
		model = "object",
		dff = "files/neons/neon_green.dff",
		col = "files/neons/neons.col"
	},
	["neon_green_lil"] = {
		type = "object",
		model = "object",
		dff = "files/neons/neon_green_lil.dff",
		col = "files/neons/neons.col"
	},
	["neon_yellow"] = {
		type = "object",
		model = "object",
		dff = "files/neons/neon_yellow.dff",
		col = "files/neons/neons.col"
	},
	["neon_yellow_lil"] = {
		type = "object",
		model = "object",
		dff = "files/neons/neon_yellow_lil.dff",
		col = "files/neons/neons.col"
	},
	["neon_pink"] = {
		type = "object",
		model = "object",
		dff = "files/neons/neon_pink.dff",
		col = "files/neons/neons.col"
	},
	["neon_pink_lil"] = {
		type = "object",
		model = "object",
		dff = "files/neons/neon_pink_lil.dff",
		col = "files/neons/neons.col"
	},
	["neon_purple"] = {
		type = "object",
		model = "object",
		dff = "files/neons/neon_purple.dff",
		col = "files/neons/neons.col"
	},
	["neon_purple_lil"] = {
		type = "object",
		model = "object",
		dff = "files/neons/neon_purple_lil.dff",
		col = "files/neons/neons.col"
	},
	["traffi"] = {
		type = "object",
		model = "object",
		dff = "files/group_models/traffi.dff",
		col = "files/group_models/traffi.col",
		txd = "files/group_models/traffi.txd"
	},
	["traffi_car"] = {
		type = "object",
		model = "object",
		dff = "files/group_models/traffi_car.dff",
		txd = "files/group_models/traffi_car.txd"
	},
	["v4_siren"] = {
		type = "object",
		model = "object",
		dff = "files/group_models/v4_siren.dff",
		txd = "files/group_models/v4_siren.txd"
	},
	["handcuff"] = {
		type = "object",
		model = "object",
		dff = "files/group_models/handcuff.dff",
		txd = "files/group_models/handcuff.txd"
	},
	["spike"] = {
		type = "object",
		model = "object",
		dff = "files/group_models/spike.dff",
		col = "files/group_models/spike.col",
		txd = "files/group_models/spike.txd"
	},
	["police_shield"] = {
		type = "object",
		model = "object",
		dff = "files/group_models/police_shield.dff",
		txd = "files/group_models/police_shield.txd",
		col = "files/group_models/police_shield.col",
		transparent = true
	},
	["omsz_bag"] = {
		type = "object",
		model = "object",
		dff = "files/group_models/omsz_bag.dff",
		col = "files/group_models/omsz_bag.col",
		txd = "files/group_models/omsz_bag.txd"
	},
	["v4_stretcher"] = {
		type = "object",
		model = "object",
		dff = "files/group_models/v4_stretcher.dff",
		txd = "files/group_models/v4_stretcher.txd",
		col = "files/group_models/v4_stretcher.col"
	},
	["v4_stretcher_case"] = {
		type = "object",
		model = "object",
		dff = "files/group_models/v4_stretcher_case.dff",
		txd = "files/group_models/v4_stretcher.txd",
		col = "files/group_models/v4_stretcher_case.col"
	},
	["v4_stretcher_wheels"] = {
		type = "object",
		model = "object",
		dff = "files/group_models/v4_stretcher_wheels.dff",
		txd = "files/group_models/v4_stretcher.txd",
		col = "files/group_models/v4_stretcher_wheels.col"
	},
	["v4_hosp_inti"] = {
		type = "object",
		model = "object",
		dff = "files/group_models/v4_hosp_inti.dff",
		col = "files/group_models/v4_hosp_inti.col",
		txd = "files/group_models/v4_hosp_inti.txd"
	},
	["pd_inti"] = {
		type = "object",
		model = "object",
		dff = "files/group_models/v4/pd_inti.dff",
		col = "files/group_models/v4/pd_inti.col",
		txd = "files/group_models/v4/pd_inti.txd"
	},
	["pd_table"] = {
		type = "object",
		model = "object",
		dff = "files/group_models/v4/pd_table.dff",
		col = "files/group_models/v4/pd_table.col",
		txd = "files/group_models/v4/pd_table.txd"
	},
	["firehouseland_sfs"] = {
		type = "object",
		model = 11139,
		dff = "files/group_models/v4/okf/firehouseland_sfs.dff",
		col = "files/group_models/v4/okf/firehouseland_sfs.col",
		txd = "files/group_models/v4/okf/okf_hq.txd"
	},
	["firehouseland_sfs_fences"] = {
		type = "object",
		model = "object",
		dff = "files/group_models/v4/okf/firehouseland_sfs_fences.dff",
		col = "files/group_models/v4/okf/firehouseland_sfs_fences.col",
		txd = "files/group_models/v4/okf/okf_hq.txd",
		lodDistance = 200,
		transparent = true
	},
	["firehouseland_sfs_props"] = {
		type = "object",
		model = "object",
		dff = "files/group_models/v4/okf/firehouseland_sfs_props.dff",
		col = "files/group_models/v4/okf/firehouseland_sfs_props.col",
		txd = "files/group_models/v4/okf/okf_hq.txd",
		lodDistance = 200
	},
	["okf_firedep"] = {
		type = "object",
		model = "object",
		dff = "files/group_models/v4/okf/okf_firedep.dff",
		col = "files/group_models/v4/okf/okf_firedep.col",
		txd = "files/group_models/v4/okf/okf_hq.txd",
		lodDistance = 200
	},
	["okf_firedep_lod"] = {
		type = "object",
		model = "object",
		dff = "files/group_models/v4/okf/okf_firedep_lod.dff",
		txd = "files/group_models/v4/okf/okf_hq.txd",
		lodDistance = 9999
	},
	["okf_firedep_door"] = {
		type = "object",
		model = 11243,
		dff = "files/group_models/v4/okf/okf_firedep_door.dff",
		col = "files/group_models/v4/okf/okf_firedep_door.col",
		txd = "files/group_models/v4/okf/okf_hq.txd",
		lodDistance = 200
	},
	["okf_firedep_int"] = {
		type = "object",
		model = "object",
		dff = "files/group_models/v4/okf/okf_firedep_int.dff",
		col = "files/group_models/v4/okf/okf_firedep_int.col",
		txd = "files/group_models/v4/okf/okf_hq.txd",
		lodDistance = 100
	},
	["okf_firedep_int_off"] = {
		type = "object",
		model = "object",
		dff = "files/group_models/v4/okf/okf_firedep_int_off.dff",
		col = "files/group_models/v4/okf/okf_firedep_int_off.col",
		txd = "files/group_models/v4/okf/okf_hq.txd",
		lodDistance = 50
	},
	["okf_firedep_int_off2"] = {
		type = "object",
		model = "object",
		dff = "files/group_models/v4/okf/okf_firedep_int_off2.dff",
		col = "files/group_models/v4/okf/okf_firedep_int_off2.col",
		txd = "files/group_models/v4/okf/okf_hq.txd",
		lodDistance = 50
	},
	["okf_firedep_int2"] = {
		type = "object",
		model = "object",
		dff = "files/group_models/v4/okf/okf_firedep_int2.dff",
		col = "files/group_models/v4/okf/okf_firedep_int2.col",
		txd = "files/group_models/v4/okf/okf_hq.txd",
		lodDistance = 100
	},
	["okf_firedep_win"] = {
		type = "object",
		model = "object",
		dff = "files/group_models/v4/okf/okf_firedep_win.dff",
		col = "files/group_models/v4/okf/okf_firedep_win.col",
		txd = "files/group_models/v4/okf/okf_hq.txd",
		lodDistance = 200,
		transparent = true
	},
	["v4_fire_nozzle"] = {
		type = "object",
		model = "object",
		dff = "files/group_models/v4_fire_nozzle.dff",
		txd = "files/group_models/v4_fire.txd"
	},
	["v4_fire_waterhose"] = {
		type = "object",
		model = "object",
		dff = "files/group_models/v4_fire_waterhose.dff",
		txd = "files/group_models/v4_fire.txd"
	},
	["v4_fire_hose_balljoint"] = {
		type = "object",
		model = "object",
		dff = "files/group_models/v4_fire_hose_balljoint.dff",
		txd = "files/group_models/v4_fire.txd"
	},
	["v4_fire_watertank"] = {
		type = "object",
		model = "object",
		dff = "files/group_models/v4_fire_watertank.dff",
		col = "files/group_models/v4_fire_watertank.col",
		txd = "files/group_models/v4_fire.txd",
		lodDistance = 150
	},
	["laehospital1"] = {
		type = "object",
		model = 5403,
		dff = "files/group_models/v4/nni/laehospital1.dff",
		col = "files/group_models/v4/nni/laehospital1.col",
		txd = "files/group_models/v4/nni/v4_nni.txd"
	},
	["v4_nni_props1"] = {
		type = "object",
		model = "object",
		dff = "files/group_models/v4/nni/v4_nni_props1.dff",
		col = "files/group_models/v4/nni/v4_nni_props1.col",
		txd = "files/group_models/v4/nni/v4_nni.txd"
	},
	["v4_nni_props2"] = {
		type = "object",
		model = "object",
		dff = "files/group_models/v4/nni/v4_nni_props2.dff",
		col = "files/group_models/v4/nni/v4_nni_props2.col",
		txd = "files/group_models/v4/nni/v4_nni.txd"
	},
	["v4_nni_shell"] = {
		type = "object",
		model = "object",
		dff = "files/group_models/v4/nni/v4_nni_shell.dff",
		col = "files/group_models/v4/nni/v4_nni_shell.col",
		txd = "files/group_models/v4/nni/v4_nni.txd",
		lodDistance = 155
	},
	["rbs1"] = {
		type = "object",
		model = "object",
		dff = "files/group_models/rbs1.dff",
		col = "files/group_models/rbs1.col",
		txd = "files/group_models/rbs.txd",
		lodDistance = 300
	},
	["rbs2"] = {
		type = "object",
		model = "object",
		dff = "files/group_models/rbs2.dff",
		col = "files/group_models/rbs2.col",
		txd = "files/group_models/rbs.txd",
		lodDistance = 300
	},
	["rbs3"] = {
		type = "object",
		model = "object",
		dff = "files/group_models/rbs3.dff",
		col = "files/group_models/rbs3-4.col",
		txd = "files/group_models/rbs.txd",
		lodDistance = 300
	},
	["rbs4"] = {
		type = "object",
		model = "object",
		dff = "files/group_models/rbs4.dff",
		col = "files/group_models/rbs3-4.col",
		txd = "files/group_models/rbs.txd",
		lodDistance = 300
	},
	["rbs5"] = {
		type = "object",
		model = "object",
		dff = "files/group_models/rbs5.dff",
		col = "files/group_models/rbs5.col",
		txd = "files/group_models/rbs.txd",
		lodDistance = 300
	},
	["rbs6"] = {
		type = "object",
		model = "object",
		dff = "files/group_models/rbs6.dff",
		col = "files/group_models/rbs6.col",
		txd = "files/group_models/rbs.txd",
		lodDistance = 300
	},
	["rbs7"] = {
		type = "object",
		model = "object",
		dff = "files/group_models/rbs7.dff",
		col = "files/group_models/rbs7-8.col",
		txd = "files/group_models/rbs.txd",
		lodDistance = 300
	},
	["rbs8"] = {
		type = "object",
		model = "object",
		dff = "files/group_models/rbs8.dff",
		col = "files/group_models/rbs7-8.col",
		txd = "files/group_models/rbs.txd",
		lodDistance = 300
	},
	["rbs9"] = {
		type = "object",
		model = "object",
		dff = "files/group_models/rbs9.dff",
		col = "files/group_models/rbs9.col",
		txd = "files/group_models/rbs.txd",
		lodDistance = 300
	},
	["rbs10"] = {
		type = "object",
		model = "object",
		dff = "files/group_models/rbs10.dff",
		col = "files/group_models/rbs10.col",
		txd = "files/group_models/rbs.txd",
		lodDistance = 300
	},
	["rbs11"] = {
		type = "object",
		model = "object",
		dff = "files/group_models/rbs11.dff",
		col = "files/group_models/rbs11.col",
		txd = "files/group_models/rbs.txd",
		lodDistance = 300
	},
	["rbs12"] = {
		type = "object",
		model = "object",
		dff = "files/group_models/rbs12.dff",
		col = "files/group_models/rbs12.col",
		txd = "files/group_models/rbs.txd",
		lodDistance = 300
	},
	["rbs13"] = {
		type = "object",
		model = "object",
		dff = "files/group_models/rbs13.dff",
		col = "files/group_models/rbs13.col",
		txd = "files/group_models/rbs.txd",
		lodDistance = 300
	},
	["rbs14"] = {
		type = "object",
		model = "object",
		dff = "files/group_models/rbs14.dff",
		col = "files/group_models/rbs14.col",
		txd = "files/group_models/rbs.txd",
		lodDistance = 300
	},
	["rbs15"] = {
		type = "object",
		model = "object",
		dff = "files/group_models/rbs15.dff",
		col = "files/group_models/rbs15.col",
		txd = "files/group_models/rbs.txd",
		lodDistance = 300
	},
	["rbs16"] = {
		type = "object",
		model = "object",
		dff = "files/group_models/rbs16.dff",
		col = "files/group_models/rbs16.col",
		txd = "files/group_models/rbs.txd",
		lodDistance = 300
	},
	["rbs16_2"] = {
		type = "object",
		model = "object",
		dff = "files/group_models/rbs16_2.dff",
		col = "files/group_models/rbs16_2.col",
		txd = "files/group_models/rbs.txd",
		lodDistance = 300
	},
	["rbs17"] = {
		type = "object",
		model = "object",
		dff = "files/group_models/rbs17.dff",
		col = "files/group_models/rbs17-35.col",
		txd = "files/group_models/rbs.txd",
		lodDistance = 300
	},
	["rbs18"] = {
		type = "object",
		model = "object",
		dff = "files/group_models/rbs18.dff",
		col = "files/group_models/rbs17-35.col",
		txd = "files/group_models/rbs.txd",
		lodDistance = 300
	},
	["rbs19"] = {
		type = "object",
		model = "object",
		dff = "files/group_models/rbs19.dff",
		col = "files/group_models/rbs17-35.col",
		txd = "files/group_models/rbs.txd",
		lodDistance = 300
	},
	["rbs20"] = {
		type = "object",
		model = "object",
		dff = "files/group_models/rbs20.dff",
		col = "files/group_models/rbs17-35.col",
		txd = "files/group_models/rbs.txd",
		lodDistance = 300
	},
	["rbs21"] = {
		type = "object",
		model = "object",
		dff = "files/group_models/rbs21.dff",
		col = "files/group_models/rbs17-35.col",
		txd = "files/group_models/rbs.txd",
		lodDistance = 300
	},
	["rbs22"] = {
		type = "object",
		model = "object",
		dff = "files/group_models/rbs22.dff",
		col = "files/group_models/rbs17-35.col",
		txd = "files/group_models/rbs.txd",
		lodDistance = 300
	},
	["rbs23"] = {
		type = "object",
		model = "object",
		dff = "files/group_models/rbs23.dff",
		col = "files/group_models/rbs17-35.col",
		txd = "files/group_models/rbs.txd",
		lodDistance = 300
	},
	["rbs24"] = {
		type = "object",
		model = "object",
		dff = "files/group_models/rbs24.dff",
		col = "files/group_models/rbs17-35.col",
		txd = "files/group_models/rbs.txd",
		lodDistance = 300
	},
	["rbs25"] = {
		type = "object",
		model = "object",
		dff = "files/group_models/rbs25.dff",
		col = "files/group_models/rbs17-35.col",
		txd = "files/group_models/rbs.txd",
		lodDistance = 300
	},
	["rbs26"] = {
		type = "object",
		model = "object",
		dff = "files/group_models/rbs26.dff",
		col = "files/group_models/rbs17-35.col",
		txd = "files/group_models/rbs.txd",
		lodDistance = 300
	},
	["rbs27"] = {
		type = "object",
		model = "object",
		dff = "files/group_models/rbs27.dff",
		col = "files/group_models/rbs17-35.col",
		txd = "files/group_models/rbs.txd",
		lodDistance = 300
	},
	["rbs28"] = {
		type = "object",
		model = "object",
		dff = "files/group_models/rbs28.dff",
		col = "files/group_models/rbs17-35.col",
		txd = "files/group_models/rbs.txd",
		lodDistance = 300
	},
	["rbs29"] = {
		type = "object",
		model = "object",
		dff = "files/group_models/rbs29.dff",
		col = "files/group_models/rbs17-35.col",
		txd = "files/group_models/rbs.txd",
		lodDistance = 300
	},
	["rbs30"] = {
		type = "object",
		model = "object",
		dff = "files/group_models/rbs30.dff",
		col = "files/group_models/rbs17-35.col",
		txd = "files/group_models/rbs.txd",
		lodDistance = 300
	},
	["rbs31"] = {
		type = "object",
		model = "object",
		dff = "files/group_models/rbs31.dff",
		col = "files/group_models/rbs17-35.col",
		txd = "files/group_models/rbs.txd",
		lodDistance = 300
	},
	["rbs32"] = {
		type = "object",
		model = "object",
		dff = "files/group_models/rbs32.dff",
		col = "files/group_models/rbs17-35.col",
		txd = "files/group_models/rbs.txd",
		lodDistance = 300
	},
	["rbs33"] = {
		type = "object",
		model = "object",
		dff = "files/group_models/rbs33.dff",
		col = "files/group_models/rbs17-35.col",
		txd = "files/group_models/rbs.txd",
		lodDistance = 300
	},
	["rbs34"] = {
		type = "object",
		model = "object",
		dff = "files/group_models/rbs34.dff",
		col = "files/group_models/rbs17-35.col",
		txd = "files/group_models/rbs.txd",
		lodDistance = 300
	},
	["rbs35"] = {
		type = "object",
		model = "object",
		dff = "files/group_models/rbs35.dff",
		col = "files/group_models/rbs17-35.col",
		txd = "files/group_models/rbs.txd",
		lodDistance = 300
	},
	["rbs36"] = {
		type = "object",
		model = "object",
		dff = "files/group_models/rbs36.dff",
		col = "files/group_models/rbs17-35.col",
		txd = "files/group_models/rbs.txd",
		lodDistance = 300
	},
	["rbs37"] = {
		type = "object",
		model = "object",
		dff = "files/group_models/rbs37.dff",
		col = "files/group_models/rbs37.col",
		txd = "files/group_models/rbs.txd",
		lodDistance = 300
	},
	["rbs37_2"] = {
		type = "object",
		model = "object",
		dff = "files/group_models/rbs37_2.dff",
		col = "files/group_models/rbs37_2.col",
		txd = "files/group_models/rbs.txd",
		lodDistance = 300
	},
	["rbs38"] = {
		type = "object",
		model = "object",
		dff = "files/group_models/rbs38.dff",
		col = "files/group_models/rbs38.col",
		txd = "files/group_models/rbs.txd",
		lodDistance = 300
	},
	["rbs39"] = {
		type = "object",
		model = "object",
		dff = "files/group_models/rbs39.dff",
		col = "files/group_models/rbs39-40.col",
		txd = "files/group_models/rbs.txd",
		lodDistance = 300
	},
	["rbs40"] = {
		type = "object",
		model = "object",
		dff = "files/group_models/rbs40.dff",
		col = "files/group_models/rbs39-40.col",
		txd = "files/group_models/rbs.txd",
		lodDistance = 300
	},
	["rbs41"] = {
		type = "object",
		model = "object",
		dff = "files/group_models/rbs41.dff",
		col = "files/group_models/rbs41.col",
		txd = "files/group_models/rbs.txd",
		lodDistance = 300
	},
	["rbs42"] = {
		type = "object",
		model = "object",
		dff = "files/group_models/rbs42.dff",
		col = "files/group_models/rbs42-44.col",
		txd = "files/group_models/rbs.txd",
		lodDistance = 150
	},
	["rbs43"] = {
		type = "object",
		model = "object",
		dff = "files/group_models/rbs43.dff",
		col = "files/group_models/rbs42-44.col",
		txd = "files/group_models/rbs.txd",
		lodDistance = 150
	},
	["rbs44"] = {
		type = "object",
		model = "object",
		dff = "files/group_models/rbs44.dff",
		col = "files/group_models/rbs42-44.col",
		txd = "files/group_models/rbs.txd",
		lodDistance = 150
	},
	["v4_backpack_greenarmy"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bag/v4_backpack_greenarmy.dff",
		txd = "files/clothing/bag/v4_backpacks.txd"
	},
	["v4_backpack_whitearmy"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bag/v4_backpack_whitearmy.dff",
		txd = "files/clothing/bag/v4_backpacks.txd"
	},
	["v4_backpack_blackchanel"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bag/v4_backpack_blackchanel.dff",
		txd = "files/clothing/bag/v4_backpacks.txd"
	},
	["v4_backpack_blackgucci"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bag/v4_backpack_blackgucci.dff",
		txd = "files/clothing/bag/v4_backpacks.txd"
	},
	["v4_backpack_browngucci"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bag/v4_backpack_browngucci.dff",
		txd = "files/clothing/bag/v4_backpacks.txd"
	},
	["v4_backpack_luivuitton"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bag/v4_backpack_luivuitton.dff",
		txd = "files/clothing/bag/v4_backpacks.txd"
	},
	["v4_backpack_tiger"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bag/v4_backpack_tiger.dff",
		txd = "files/clothing/bag/v4_backpacks.txd"
	},
	["gucci_backpack"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bag/gucci_backpack.dff",
		txd = "files/clothing/bag/gucci_backpack.txd"
	},
	["gucci_belt_bag"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bag/gucci_belt_bag.dff",
		txd = "files/clothing/bag/gucci_belt_bag.txd"
	},
	["purse_black"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bag/purse_black.dff",
		txd = "files/clothing/bag/purse.txd"
	},
	["purse_grey"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bag/purse_grey.dff",
		txd = "files/clothing/bag/purse.txd"
	},
	["purse_pink"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bag/purse_pink.dff",
		txd = "files/clothing/bag/purse.txd"
	},
	["purse_red"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bag/purse_red.dff",
		txd = "files/clothing/bag/purse.txd"
	},
	["purse_yellow"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bag/purse_yellow.dff",
		txd = "files/clothing/bag/purse.txd"
	},
	["v4_sidebag_black"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bag/v4_sidebag_black.dff",
		txd = "files/clothing/bag/v4_sidebags.txd"
	},
	["v4_sidebag_gucci"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bag/v4_sidebag_gucci.dff",
		txd = "files/clothing/bag/v4_sidebags.txd"
	},
	["v4_sidebag_luivuitton"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bag/v4_sidebag_luivuitton.dff",
		txd = "files/clothing/bag/v4_sidebags.txd"
	},
	["v4_sidebag_versace"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bag/v4_sidebag_versace.dff",
		txd = "files/clothing/bag/v4_sidebags.txd"
	},
	["v4_neckbag_black"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bag/v4_neckbag_black.dff",
		txd = "files/clothing/bag/v4_neckbags.txd"
	},
	["v4_neckbag_green"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bag/v4_neckbag_green.dff",
		txd = "files/clothing/bag/v4_neckbags.txd"
	},
	["v4_neckbag_pink"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bag/v4_neckbag_pink.dff",
		txd = "files/clothing/bag/v4_neckbags.txd"
	},
	["v4_neckbag_red"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bag/v4_neckbag_red.dff",
		txd = "files/clothing/bag/v4_neckbags.txd"
	},
	["v4_suitcase_black"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bag/v4_suitcase_black.dff",
		txd = "files/clothing/bag/v4_suitcase.txd"
	},
	["v4_suitcase_brown"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bag/v4_suitcase_brown.dff",
		txd = "files/clothing/bag/v4_suitcase.txd"
	},
	["v4_suitcase_grey"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bag/v4_suitcase_grey.dff",
		txd = "files/clothing/bag/v4_suitcase.txd"
	},
	["v4_suitcase_red"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bag/v4_suitcase_red.dff",
		txd = "files/clothing/bag/v4_suitcase.txd"
	},
	["supreme_backpack_green"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bag/supreme_backpack_green.dff",
		txd = "files/clothing/bag/supreme_backpack.txd"
	},
	["supreme_backpack_red"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bag/supreme_backpack_red.dff",
		txd = "files/clothing/bag/supreme_backpack.txd"
	},
	["BackPack1"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bag/BackPack1.dff",
		txd = "files/clothing/bag/BackPack1.txd"
	},
	["BackPack2"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bag/BackPack2.dff",
		txd = "files/clothing/bag/BackPack2.txd"
	},
	["BackPack3"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bag/BackPack3.dff",
		txd = "files/clothing/bag/BackPack3.txd"
	},
	["BackPack4"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bag/BackPack4.dff",
		txd = "files/clothing/bag/BackPack4.txd"
	},
	["BackPack5"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bag/BackPack5.dff",
		txd = "files/clothing/bag/BackPack5.txd"
	},
	["BackPack6"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bag/BackPack6.dff",
		txd = "files/clothing/bag/BackPack6.txd"
	},
	["hasitasi"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bag/hasitasi.dff",
		txd = "files/clothing/bag/hasitasi.txd"
	},
	["HikerBackpack1"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bag/HikerBackpack1.dff",
		txd = "files/clothing/bag/HikerBackpack1.txd"
	},
	["duffelbag"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bag/v3_duffelbag1.dff",
		txd = "files/clothing/bag/v3_duffelbag.txd"
	},
	["duffelbag2"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bag/v3_duffelbag2.dff",
		txd = "files/clothing/bag/v3_duffelbag.txd"
	},
	["oldaltaska"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bag/oldaltaska.dff",
		txd = "files/clothing/bag/oldaltaska.txd"
	},
	["SchoolPack"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bag/SchoolPack1.dff",
		txd = "files/clothing/bag/SchoolPack.txd"
	},
	["SchoolPack2"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bag/SchoolPack2.dff",
		txd = "files/clothing/bag/SchoolPack.txd"
	},
	["SchoolPack3"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bag/SchoolPack3.dff",
		txd = "files/clothing/bag/SchoolPack.txd"
	},
	["v4_szatyor"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bag/v4_szatyor.dff",
		txd = "files/clothing/bag/v4_szatyor.txd"
	},
	["v4_bandana1_black"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bandana/v4_bandana1_black.dff",
		txd = "files/clothing/bandana/v4_bandanas.txd"
	},
	["v4_bandana1_blue"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bandana/v4_bandana1_blue.dff",
		txd = "files/clothing/bandana/v4_bandanas.txd"
	},
	["v4_bandana1_camo1"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bandana/v4_bandana1_camo1.dff",
		txd = "files/clothing/bandana/v4_bandanas.txd"
	},
	["v4_bandana1_camo2"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bandana/v4_bandana1_camo2.dff",
		txd = "files/clothing/bandana/v4_bandanas.txd"
	},
	["v4_bandana1_darkblue"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bandana/v4_bandana1_darkblue.dff",
		txd = "files/clothing/bandana/v4_bandanas.txd"
	},
	["v4_bandana1_darkgreen"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bandana/v4_bandana1_darkgreen.dff",
		txd = "files/clothing/bandana/v4_bandanas.txd"
	},
	["v4_bandana1_green"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bandana/v4_bandana1_green.dff",
		txd = "files/clothing/bandana/v4_bandanas.txd"
	},
	["v4_bandana1_grey"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bandana/v4_bandana1_grey.dff",
		txd = "files/clothing/bandana/v4_bandanas.txd"
	},
	["v4_bandana1_purple"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bandana/v4_bandana1_purple.dff",
		txd = "files/clothing/bandana/v4_bandanas.txd"
	},
	["v4_bandana1_red"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bandana/v4_bandana1_red.dff",
		txd = "files/clothing/bandana/v4_bandanas.txd"
	},
	["v4_bandana1_redneck"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bandana/v4_bandana1_redneck.dff",
		txd = "files/clothing/bandana/v4_bandanas.txd"
	},
	["v4_bandana1_yellow"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bandana/v4_bandana1_yellow.dff",
		txd = "files/clothing/bandana/v4_bandanas.txd"
	},
	["v4_bandana2_black"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bandana/v4_bandana2_black.dff",
		txd = "files/clothing/bandana/v4_bandanas.txd"
	},
	["v4_bandana2_blue"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bandana/v4_bandana2_blue.dff",
		txd = "files/clothing/bandana/v4_bandanas.txd"
	},
	["v4_bandana2_camo1"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bandana/v4_bandana2_camo1.dff",
		txd = "files/clothing/bandana/v4_bandanas.txd"
	},
	["v4_bandana2_camo2"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bandana/v4_bandana2_camo2.dff",
		txd = "files/clothing/bandana/v4_bandanas.txd"
	},
	["v4_bandana2_darkblue"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bandana/v4_bandana2_darkblue.dff",
		txd = "files/clothing/bandana/v4_bandanas.txd"
	},
	["v4_bandana2_darkgreen"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bandana/v4_bandana2_darkgreen.dff",
		txd = "files/clothing/bandana/v4_bandanas.txd"
	},
	["v4_bandana2_green"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bandana/v4_bandana2_green.dff",
		txd = "files/clothing/bandana/v4_bandanas.txd"
	},
	["v4_bandana2_grey"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bandana/v4_bandana2_grey.dff",
		txd = "files/clothing/bandana/v4_bandanas.txd"
	},
	["v4_bandana2_purple"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bandana/v4_bandana2_purple.dff",
		txd = "files/clothing/bandana/v4_bandanas.txd"
	},
	["v4_bandana2_red"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bandana/v4_bandana2_red.dff",
		txd = "files/clothing/bandana/v4_bandanas.txd"
	},
	["v4_bandana2_yellow"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bandana/v4_bandana2_yellow.dff",
		txd = "files/clothing/bandana/v4_bandanas.txd"
	},
	["v4_bandana3_black"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bandana/v4_bandana3_black.dff",
		txd = "files/clothing/bandana/v4_bandanas.txd"
	},
	["v4_bandana3_blue"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bandana/v4_bandana3_blue.dff",
		txd = "files/clothing/bandana/v4_bandanas.txd"
	},
	["v4_bandana3_camo1"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bandana/v4_bandana3_camo1.dff",
		txd = "files/clothing/bandana/v4_bandanas.txd"
	},
	["v4_bandana3_camo2"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bandana/v4_bandana3_camo2.dff",
		txd = "files/clothing/bandana/v4_bandanas.txd"
	},
	["v4_bandana3_darkblue"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bandana/v4_bandana3_darkblue.dff",
		txd = "files/clothing/bandana/v4_bandanas.txd"
	},
	["v4_bandana3_darkgreen"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bandana/v4_bandana3_darkgreen.dff",
		txd = "files/clothing/bandana/v4_bandanas.txd"
	},
	["v4_bandana3_green"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bandana/v4_bandana3_green.dff",
		txd = "files/clothing/bandana/v4_bandanas.txd"
	},
	["v4_bandana3_grey"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bandana/v4_bandana3_grey.dff",
		txd = "files/clothing/bandana/v4_bandanas.txd"
	},
	["v4_bandana3_purple"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bandana/v4_bandana3_purple.dff",
		txd = "files/clothing/bandana/v4_bandanas.txd"
	},
	["v4_bandana3_red"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bandana/v4_bandana3_red.dff",
		txd = "files/clothing/bandana/v4_bandanas.txd"
	},
	["v4_bandana3_redneck"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bandana/v4_bandana3_redneck.dff",
		txd = "files/clothing/bandana/v4_bandanas.txd"
	},
	["v4_bandana3_yellow"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bandana/v4_bandana3_yellow.dff",
		txd = "files/clothing/bandana/v4_bandanas.txd"
	},
	["v4_bandana4_black"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bandana/v4_bandana4_black.dff",
		txd = "files/clothing/bandana/v4_bandanas.txd"
	},
	["v4_bandana4_blue"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bandana/v4_bandana4_blue.dff",
		txd = "files/clothing/bandana/v4_bandanas.txd"
	},
	["v4_bandana4_camo1"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bandana/v4_bandana4_camo1.dff",
		txd = "files/clothing/bandana/v4_bandanas.txd"
	},
	["v4_bandana4_camo2"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bandana/v4_bandana4_camo2.dff",
		txd = "files/clothing/bandana/v4_bandanas.txd"
	},
	["v4_bandana4_darkblue"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bandana/v4_bandana4_darkblue.dff",
		txd = "files/clothing/bandana/v4_bandanas.txd"
	},
	["v4_bandana4_darkgreen"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bandana/v4_bandana4_darkgreen.dff",
		txd = "files/clothing/bandana/v4_bandanas.txd"
	},
	["v4_bandana4_green"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bandana/v4_bandana4_green.dff",
		txd = "files/clothing/bandana/v4_bandanas.txd"
	},
	["v4_bandana4_grey"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bandana/v4_bandana4_grey.dff",
		txd = "files/clothing/bandana/v4_bandanas.txd"
	},
	["v4_bandana4_purple"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bandana/v4_bandana4_purple.dff",
		txd = "files/clothing/bandana/v4_bandanas.txd"
	},
	["v4_bandana4_red"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bandana/v4_bandana4_red.dff",
		txd = "files/clothing/bandana/v4_bandanas.txd"
	},
	["v4_bandana4_yellow"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bandana/v4_bandana4_yellow.dff",
		txd = "files/clothing/bandana/v4_bandanas.txd"
	},
	["v4_bandana5_black"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bandana/v4_bandana5_black.dff",
		txd = "files/clothing/bandana/v4_bandanas.txd"
	},
	["v4_bandana5_blue"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bandana/v4_bandana5_blue.dff",
		txd = "files/clothing/bandana/v4_bandanas.txd"
	},
	["v4_bandana5_camo1"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bandana/v4_bandana5_camo1.dff",
		txd = "files/clothing/bandana/v4_bandanas.txd"
	},
	["v4_bandana5_camo2"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bandana/v4_bandana5_camo2.dff",
		txd = "files/clothing/bandana/v4_bandanas.txd"
	},
	["v4_bandana5_darkblue"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bandana/v4_bandana5_darkblue.dff",
		txd = "files/clothing/bandana/v4_bandanas.txd"
	},
	["v4_bandana5_darkgreen"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bandana/v4_bandana5_darkgreen.dff",
		txd = "files/clothing/bandana/v4_bandanas.txd"
	},
	["v4_bandana5_green"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bandana/v4_bandana5_green.dff",
		txd = "files/clothing/bandana/v4_bandanas.txd"
	},
	["v4_bandana5_grey"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bandana/v4_bandana5_grey.dff",
		txd = "files/clothing/bandana/v4_bandanas.txd"
	},
	["v4_bandana5_purple"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bandana/v4_bandana5_purple.dff",
		txd = "files/clothing/bandana/v4_bandanas.txd"
	},
	["v4_bandana5_red"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bandana/v4_bandana5_red.dff",
		txd = "files/clothing/bandana/v4_bandanas.txd"
	},
	["v4_bandana5_redneck"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bandana/v4_bandana5_redneck.dff",
		txd = "files/clothing/bandana/v4_bandanas.txd"
	},
	["v4_bandana5_yellow"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bandana/v4_bandana5_yellow.dff",
		txd = "files/clothing/bandana/v4_bandanas.txd"
	},
	["v4_bandana6_black"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bandana/v4_bandana6_black.dff",
		txd = "files/clothing/bandana/v4_bandanas.txd"
	},
	["v4_bandana6_blue"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bandana/v4_bandana6_blue.dff",
		txd = "files/clothing/bandana/v4_bandanas.txd"
	},
	["v4_bandana6_camo1"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bandana/v4_bandana6_camo1.dff",
		txd = "files/clothing/bandana/v4_bandanas.txd"
	},
	["v4_bandana6_camo2"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bandana/v4_bandana6_camo2.dff",
		txd = "files/clothing/bandana/v4_bandanas.txd"
	},
	["v4_bandana6_darkblue"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bandana/v4_bandana6_darkblue.dff",
		txd = "files/clothing/bandana/v4_bandanas.txd"
	},
	["v4_bandana6_darkgreen"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bandana/v4_bandana6_darkgreen.dff",
		txd = "files/clothing/bandana/v4_bandanas.txd"
	},
	["v4_bandana6_green"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bandana/v4_bandana6_green.dff",
		txd = "files/clothing/bandana/v4_bandanas.txd"
	},
	["v4_bandana6_grey"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bandana/v4_bandana6_grey.dff",
		txd = "files/clothing/bandana/v4_bandanas.txd"
	},
	["v4_bandana6_purple"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bandana/v4_bandana6_purple.dff",
		txd = "files/clothing/bandana/v4_bandanas.txd"
	},
	["v4_bandana6_red"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bandana/v4_bandana6_red.dff",
		txd = "files/clothing/bandana/v4_bandanas.txd"
	},
	["v4_bandana6_redneck"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bandana/v4_bandana6_redneck.dff",
		txd = "files/clothing/bandana/v4_bandanas.txd"
	},
	["v4_bandana6_skull"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bandana/v4_bandana6_skull.dff",
		txd = "files/clothing/bandana/v4_bandanas.txd"
	},
	["v4_bandana6_yellow"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/bandana/v4_bandana6_yellow.dff",
		txd = "files/clothing/bandana/v4_bandanas.txd"
	},
	["GlassesType1"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/glasses/GlassesType1.dff",
		txd = "files/clothing/glasses/MatGlasses.txd",
		transparent = true
	},
	["GlassesType2"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/glasses/GlassesType2.dff",
		txd = "files/clothing/glasses/MatGlasses.txd",
		transparent = true
	},
	["GlassesType3"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/glasses/GlassesType3.dff",
		txd = "files/clothing/glasses/MatGlasses.txd",
		transparent = true
	},
	["GlassesType4"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/glasses/GlassesType4.dff",
		txd = "files/clothing/glasses/MatGlasses.txd",
		transparent = true
	},
	["GlassesType5"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/glasses/GlassesType5.dff",
		txd = "files/clothing/glasses/MatGlasses.txd",
		transparent = true
	},
	["GlassesType6"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/glasses/GlassesType6.dff",
		txd = "files/clothing/glasses/MatGlasses.txd",
		transparent = true
	},
	["GlassesType7"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/glasses/GlassesType7.dff",
		txd = "files/clothing/glasses/MatGlasses.txd",
		transparent = true
	},
	["GlassesType8"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/glasses/GlassesType8.dff",
		txd = "files/clothing/glasses/MatGlasses.txd",
		transparent = true
	},
	["GlassesType9"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/glasses/GlassesType9.dff",
		txd = "files/clothing/glasses/MatGlasses.txd",
		transparent = true
	},
	["GlassesType10"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/glasses/GlassesType10.dff",
		txd = "files/clothing/glasses/MatGlasses.txd",
		transparent = true
	},
	["GlassesType11"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/glasses/GlassesType11.dff",
		txd = "files/clothing/glasses/MatGlasses.txd",
		transparent = true
	},
	["GlassesType12"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/glasses/GlassesType12.dff",
		txd = "files/clothing/glasses/MatGlasses.txd",
		transparent = true
	},
	["GlassesType13"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/glasses/GlassesType13.dff",
		txd = "files/clothing/glasses/MatGlasses.txd",
		transparent = true
	},
	["GlassesType14"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/glasses/GlassesType14.dff",
		txd = "files/clothing/glasses/MatGlasses.txd",
		transparent = true
	},
	["GlassesType15"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/glasses/GlassesType15.dff",
		txd = "files/clothing/glasses/MatGlasses.txd",
		transparent = true
	},
	["GlassesType16"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/glasses/GlassesType16.dff",
		txd = "files/clothing/glasses/MatGlasses.txd",
		transparent = true
	},
	["GlassesType17"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/glasses/GlassesType17.dff",
		txd = "files/clothing/glasses/MatGlasses.txd",
		transparent = true
	},
	["GlassesType18"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/glasses/GlassesType18.dff",
		txd = "files/clothing/glasses/MatGlasses.txd",
		transparent = true
	},
	["GlassesType19"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/glasses/GlassesType19.dff",
		txd = "files/clothing/glasses/MatGlasses.txd",
		transparent = true
	},
	["GlassesType20"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/glasses/GlassesType20.dff",
		txd = "files/clothing/glasses/MatGlasses.txd",
		transparent = true
	},
	["GlassesType21"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/glasses/GlassesType21.dff",
		txd = "files/clothing/glasses/MatGlasses.txd",
		transparent = true
	},
	["GlassesType22"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/glasses/GlassesType22.dff",
		txd = "files/clothing/glasses/MatGlasses.txd",
		transparent = true
	},
	["GlassesType23"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/glasses/GlassesType23.dff",
		txd = "files/clothing/glasses/MatGlasses.txd",
		transparent = true
	},
	["GlassesType24"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/glasses/GlassesType24.dff",
		txd = "files/clothing/glasses/MatGlasses.txd",
		transparent = true
	},
	["Szemuveg_1"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/glasses/Szemuveg_1.dff",
		txd = "files/clothing/glasses/Szemuveg_1.txd"
	},
	["v4_beard1_black"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/hair/v4_beard1_black.dff",
		txd = "files/clothing/hair/v4_beards_and_mustache.txd"
	},
	["v4_beard1_brown"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/hair/v4_beard1_brown.dff",
		txd = "files/clothing/hair/v4_beards_and_mustache.txd"
	},
	["v4_beard1_darkbrown"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/hair/v4_beard1_darkbrown.dff",
		txd = "files/clothing/hair/v4_beards_and_mustache.txd"
	},
	["v4_beard1_grey"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/hair/v4_beard1_grey.dff",
		txd = "files/clothing/hair/v4_beards_and_mustache.txd"
	},
	["v4_beard1_white"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/hair/v4_beard1_white.dff",
		txd = "files/clothing/hair/v4_beards_and_mustache.txd"
	},
	["v4_beard2_black"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/hair/v4_beard2_black.dff",
		txd = "files/clothing/hair/v4_beards_and_mustache.txd"
	},
	["v4_beard2_brown"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/hair/v4_beard2_brown.dff",
		txd = "files/clothing/hair/v4_beards_and_mustache.txd"
	},
	["v4_beard2_darkbrown"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/hair/v4_beard2_darkbrown.dff",
		txd = "files/clothing/hair/v4_beards_and_mustache.txd"
	},
	["v4_beard2_grey"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/hair/v4_beard2_grey.dff",
		txd = "files/clothing/hair/v4_beards_and_mustache.txd"
	},
	["v4_beard2_white"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/hair/v4_beard2_white.dff",
		txd = "files/clothing/hair/v4_beards_and_mustache.txd"
	},
	["v4_beard3_black"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/hair/v4_beard3_black.dff",
		txd = "files/clothing/hair/v4_beards_and_mustache.txd"
	},
	["v4_beard3_brown"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/hair/v4_beard3_brown.dff",
		txd = "files/clothing/hair/v4_beards_and_mustache.txd"
	},
	["v4_beard3_darkbrown"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/hair/v4_beard3_darkbrown.dff",
		txd = "files/clothing/hair/v4_beards_and_mustache.txd"
	},
	["v4_beard3_grey"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/hair/v4_beard3_grey.dff",
		txd = "files/clothing/hair/v4_beards_and_mustache.txd"
	},
	["v4_beard3_white"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/hair/v4_beard3_white.dff",
		txd = "files/clothing/hair/v4_beards_and_mustache.txd"
	},
	["v4_beard4_black"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/hair/v4_beard4_black.dff",
		txd = "files/clothing/hair/v4_beards_and_mustache.txd"
	},
	["v4_beard4_brown"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/hair/v4_beard4_brown.dff",
		txd = "files/clothing/hair/v4_beards_and_mustache.txd"
	},
	["v4_beard4_darkbrown"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/hair/v4_beard4_darkbrown.dff",
		txd = "files/clothing/hair/v4_beards_and_mustache.txd"
	},
	["v4_beard4_grey"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/hair/v4_beard4_grey.dff",
		txd = "files/clothing/hair/v4_beards_and_mustache.txd"
	},
	["v4_beard4_white"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/hair/v4_beard4_white.dff",
		txd = "files/clothing/hair/v4_beards_and_mustache.txd"
	},
	["v4_beard5_black"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/hair/v4_beard5_black.dff",
		txd = "files/clothing/hair/v4_beards_and_mustache.txd"
	},
	["v4_beard5_brown"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/hair/v4_beard5_brown.dff",
		txd = "files/clothing/hair/v4_beards_and_mustache.txd"
	},
	["v4_beard5_darkbrown"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/hair/v4_beard5_darkbrown.dff",
		txd = "files/clothing/hair/v4_beards_and_mustache.txd"
	},
	["v4_beard5_grey"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/hair/v4_beard5_grey.dff",
		txd = "files/clothing/hair/v4_beards_and_mustache.txd"
	},
	["v4_beard5_white"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/hair/v4_beard5_white.dff",
		txd = "files/clothing/hair/v4_beards_and_mustache.txd"
	},
	["v4_beard6_black"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/hair/v4_beard6_black.dff",
		txd = "files/clothing/hair/v4_beards_and_mustache.txd"
	},
	["v4_beard6_brown"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/hair/v4_beard6_brown.dff",
		txd = "files/clothing/hair/v4_beards_and_mustache.txd"
	},
	["v4_beard6_darkbrown"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/hair/v4_beard6_darkbrown.dff",
		txd = "files/clothing/hair/v4_beards_and_mustache.txd"
	},
	["v4_beard6_grey"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/hair/v4_beard6_grey.dff",
		txd = "files/clothing/hair/v4_beards_and_mustache.txd"
	},
	["v4_beard6_white"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/hair/v4_beard6_white.dff",
		txd = "files/clothing/hair/v4_beards_and_mustache.txd"
	},
	["v4_mustache1_black"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/hair/v4_mustache1_black.dff",
		txd = "files/clothing/hair/v4_beards_and_mustache.txd"
	},
	["v4_mustache1_brown"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/hair/v4_mustache1_brown.dff",
		txd = "files/clothing/hair/v4_beards_and_mustache.txd"
	},
	["v4_mustache1_darkbrown"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/hair/v4_mustache1_darkbrown.dff",
		txd = "files/clothing/hair/v4_beards_and_mustache.txd"
	},
	["v4_mustache1_grey"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/hair/v4_mustache1_grey.dff",
		txd = "files/clothing/hair/v4_beards_and_mustache.txd"
	},
	["v4_mustache1_white"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/hair/v4_mustache1_white.dff",
		txd = "files/clothing/hair/v4_beards_and_mustache.txd"
	},
	["v4_mustache2_black"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/hair/v4_mustache2_black.dff",
		txd = "files/clothing/hair/v4_beards_and_mustache.txd"
	},
	["v4_mustache2_brown"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/hair/v4_mustache2_brown.dff",
		txd = "files/clothing/hair/v4_beards_and_mustache.txd"
	},
	["v4_mustache2_darkbrown"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/hair/v4_mustache2_darkbrown.dff",
		txd = "files/clothing/hair/v4_beards_and_mustache.txd"
	},
	["v4_mustache2_grey"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/hair/v4_mustache2_grey.dff",
		txd = "files/clothing/hair/v4_beards_and_mustache.txd"
	},
	["v4_mustache2_white"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/hair/v4_mustache2_white.dff",
		txd = "files/clothing/hair/v4_beards_and_mustache.txd"
	},
	["v4_mustache3_black"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/hair/v4_mustache3_black.dff",
		txd = "files/clothing/hair/v4_beards_and_mustache.txd"
	},
	["v4_mustache3_brown"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/hair/v4_mustache3_brown.dff",
		txd = "files/clothing/hair/v4_beards_and_mustache.txd"
	},
	["v4_mustache3_darkbrown"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/hair/v4_mustache3_darkbrown.dff",
		txd = "files/clothing/hair/v4_beards_and_mustache.txd"
	},
	["v4_mustache3_grey"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/hair/v4_mustache3_grey.dff",
		txd = "files/clothing/hair/v4_beards_and_mustache.txd"
	},
	["v4_mustache3_white"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/hair/v4_mustache3_white.dff",
		txd = "files/clothing/hair/v4_beards_and_mustache.txd"
	},
	["v4_mustache4_black"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/hair/v4_mustache4_black.dff",
		txd = "files/clothing/hair/v4_beards_and_mustache.txd"
	},
	["v4_mustache4_brown"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/hair/v4_mustache4_brown.dff",
		txd = "files/clothing/hair/v4_beards_and_mustache.txd"
	},
	["v4_mustache4_darkbrown"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/hair/v4_mustache4_darkbrown.dff",
		txd = "files/clothing/hair/v4_beards_and_mustache.txd"
	},
	["v4_mustache4_grey"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/hair/v4_mustache4_grey.dff",
		txd = "files/clothing/hair/v4_beards_and_mustache.txd"
	},
	["v4_mustache4_white"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/hair/v4_mustache4_white.dff",
		txd = "files/clothing/hair/v4_beards_and_mustache.txd"
	},
	["v4_hair_dreadlock1"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/hair/v4_hair_dreadlock1.dff",
		txd = "files/clothing/hair/v4_hairs.txd"
	},
	["v4_hair_dreadlock2"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/hair/v4_hair_dreadlock2.dff",
		txd = "files/clothing/hair/v4_hairs.txd"
	},
	["v4_hair_long1_black"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/hair/v4_hair_long1_black.dff",
		txd = "files/clothing/hair/v4_hairs.txd"
	},
	["v4_hair_long1_brown"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/hair/v4_hair_long1_brown.dff",
		txd = "files/clothing/hair/v4_hairs.txd"
	},
	["v4_hair_long2_black"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/hair/v4_hair_long2_black.dff",
		txd = "files/clothing/hair/v4_hairs.txd"
	},
	["v4_hair_long2_brown"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/hair/v4_hair_long2_brown.dff",
		txd = "files/clothing/hair/v4_hairs.txd"
	},
	["v4_hair_long3_black"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/hair/v4_hair_long3_black.dff",
		txd = "files/clothing/hair/v4_hairs.txd"
	},
	["v4_hair_long3_brown"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/hair/v4_hair_long3_brown.dff",
		txd = "files/clothing/hair/v4_hairs.txd"
	},
	["v4_hair_microfon_black"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/hair/v4_hair_microfon_black.dff",
		txd = "files/clothing/hair/v4_hairs.txd"
	},
	["v4_hair_microfon_brown"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/hair/v4_hair_microfon_brown.dff",
		txd = "files/clothing/hair/v4_hairs.txd"
	},
	["v4_hair_microfon_darkbrown"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/hair/v4_hair_microfon_darkbrown.dff",
		txd = "files/clothing/hair/v4_hairs.txd"
	},
	["v4_hair_punk_black"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/hair/v4_hair_punk_black.dff",
		txd = "files/clothing/hair/v4_hairs.txd"
	},
	["v4_hair_punk_blue"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/hair/v4_hair_punk_blue.dff",
		txd = "files/clothing/hair/v4_hairs.txd"
	},
	["v4_hair_punk_green"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/hair/v4_hair_punk_green.dff",
		txd = "files/clothing/hair/v4_hairs.txd"
	},
	["v4_hair_punk_pink"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/hair/v4_hair_punk_pink.dff",
		txd = "files/clothing/hair/v4_hairs.txd"
	},
	["v4_hair_punk_red"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/hair/v4_hair_punk_red.dff",
		txd = "files/clothing/hair/v4_hairs.txd"
	},
	["v4_hair_punk_yellow"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/hair/v4_hair_punk_yellow.dff",
		txd = "files/clothing/hair/v4_hairs.txd"
	},
	["v4_hair_short1_black"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/hair/v4_hair_short1_black.dff",
		txd = "files/clothing/hair/v4_hairs.txd"
	},
	["v4_hair_short1_brown"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/hair/v4_hair_short1_brown.dff",
		txd = "files/clothing/hair/v4_hairs.txd"
	},
	["v4_hair_short2_black"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/hair/v4_hair_short2_black.dff",
		txd = "files/clothing/hair/v4_hairs.txd"
	},
	["v4_hair_short2_brown"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/hair/v4_hair_short2_brown.dff",
		txd = "files/clothing/hair/v4_hairs.txd"
	},
	["v4_hair_short3_black"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/hair/v4_hair_short3_black.dff",
		txd = "files/clothing/hair/v4_hairs.txd"
	},
	["v4_hair_short3_brown"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/hair/v4_hair_short3_brown.dff",
		txd = "files/clothing/hair/v4_hairs.txd"
	},
	["v4_cilinder_blackandgrey"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/v4_cilinder_blackandgrey.dff",
		txd = "files/clothing/headwear/v4_cilinderek.txd"
	},
	["v4_cilinder_blackandwhite"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/v4_cilinder_blackandwhite.dff",
		txd = "files/clothing/headwear/v4_cilinderek.txd"
	},
	["v4_cilinder_blueandblack"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/v4_cilinder_blueandblack.dff",
		txd = "files/clothing/headwear/v4_cilinderek.txd"
	},
	["v4_cilinder_greenandblack"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/v4_cilinder_greenandblack.dff",
		txd = "files/clothing/headwear/v4_cilinderek.txd"
	},
	["v4_cilinder_greyandblack"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/v4_cilinder_greyandblack.dff",
		txd = "files/clothing/headwear/v4_cilinderek.txd"
	},
	["v4_cilinder_pinkandwhite"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/v4_cilinder_pinkandwhite.dff",
		txd = "files/clothing/headwear/v4_cilinderek.txd"
	},
	["v4_cilinder_purpleandblack"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/v4_cilinder_purpleandblack.dff",
		txd = "files/clothing/headwear/v4_cilinderek.txd"
	},
	["v4_cilinder_redandblack"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/v4_cilinder_redandblack.dff",
		txd = "files/clothing/headwear/v4_cilinderek.txd"
	},
	["v4_cilinder_whiteandblack"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/v4_cilinder_whiteandblack.dff",
		txd = "files/clothing/headwear/v4_cilinderek.txd"
	},
	["headband1_black"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/headband1_black.dff",
		txd = "files/clothing/headwear/headband.txd"
	},
	["headband1_red"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/headband1_red.dff",
		txd = "files/clothing/headwear/headband.txd"
	},
	["headband1_pink"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/headband1_pink.dff",
		txd = "files/clothing/headwear/headband.txd"
	},
	["headband2_black"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/headband2_black.dff",
		txd = "files/clothing/headwear/headband.txd"
	},
	["headband2_red"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/headband2_red.dff",
		txd = "files/clothing/headwear/headband.txd"
	},
	["headband2_pink"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/headband2_pink.dff",
		txd = "files/clothing/headwear/headband.txd"
	},
	["headband3_black"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/headband3_black.dff",
		txd = "files/clothing/headwear/headband.txd"
	},
	["headband3_red"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/headband3_red.dff",
		txd = "files/clothing/headwear/headband.txd"
	},
	["headband3_pink"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/headband3_pink.dff",
		txd = "files/clothing/headwear/headband.txd"
	},
	["headband4_black"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/headband4_black.dff",
		txd = "files/clothing/headwear/headband.txd"
	},
	["headband4_red"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/headband4_red.dff",
		txd = "files/clothing/headwear/headband.txd"
	},
	["headband4_pink"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/headband4_pink.dff",
		txd = "files/clothing/headwear/headband.txd"
	},
	["eyepatch_left"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/eyepatch_left.dff",
		txd = "files/clothing/headwear/eyepatch.txd"
	},
	["eyepatch_right"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/eyepatch_right.dff",
		txd = "files/clothing/headwear/eyepatch.txd"
	},
	["BPeaky"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/BPeaky.dff",
		txd = "files/clothing/headwear/PeakyHat.txd"
	},
	["KPeaky"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/KPeaky.dff",
		txd = "files/clothing/headwear/PeakyHat.txd"
	},
	["PPeaky"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/PPeaky.dff",
		txd = "files/clothing/headwear/PeakyHat.txd"
	},
	["SzPeaky"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/SzPeaky.dff",
		txd = "files/clothing/headwear/PeakyHat.txd"
	},
	["blackbikerhelmet"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/blackbikerhelmet.dff",
		txd = "files/clothing/headwear/blackbikerhelmet.txd"
	},
	["CapTrucker"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/CapTrucker.dff",
		txd = "files/clothing/headwear/CapTrucker.txd"
	},
	["CapTrucker1"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/CapTrucker1.dff",
		txd = "files/clothing/headwear/CapTrucker.txd"
	},
	["CapTrucker2"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/CapTrucker2.dff",
		txd = "files/clothing/headwear/CapTrucker.txd"
	},
	["CapTrucker3"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/CapTrucker3.dff",
		txd = "files/clothing/headwear/CapTrucker.txd"
	},
	["CapTrucker4"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/CapTrucker4.dff",
		txd = "files/clothing/headwear/CapTrucker.txd"
	},
	["CapTrucker5"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/CapTrucker5.dff",
		txd = "files/clothing/headwear/CapTrucker.txd"
	},
	["CapTrucker6"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/CapTrucker6.dff",
		txd = "files/clothing/headwear/CapTrucker.txd"
	},
	["cross_helmet"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/cross_helmet1.dff",
		txd = "files/clothing/headwear/cross_helmet.txd"
	},
	["cross_helmet2"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/cross_helmet2.dff",
		txd = "files/clothing/headwear/cross_helmet.txd"
	},
	["cross_helmet3"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/cross_helmet3.dff",
		txd = "files/clothing/headwear/cross_helmet.txd"
	},
	["cross_helmet4"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/cross_helmet4.dff",
		txd = "files/clothing/headwear/cross_helmet.txd"
	},
	["mikulassapka"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/mikulassapka.dff",
		txd = "files/clothing/headwear/mikulassapka.txd"
	},
	["MotorcycleHelmet1"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/MotorcycleHelmet1.dff",
		txd = "files/clothing/headwear/MotorcycleHelmet.txd"
	},
	["MotorcycleHelmet2"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/MotorcycleHelmet2.dff",
		txd = "files/clothing/headwear/MotorcycleHelmet.txd"
	},
	["MotorcycleHelmet3"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/MotorcycleHelmet3.dff",
		txd = "files/clothing/headwear/MotorcycleHelmet.txd"
	},
	["MotorcycleHelmet4"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/MotorcycleHelmet4.dff",
		txd = "files/clothing/headwear/MotorcycleHelmet.txd"
	},
	["greencamobikerhelmet"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/greencamobikerhelmet.dff",
		txd = "files/clothing/headwear/greencamobikerhelmet.txd"
	},
	["HardHat1"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/HardHat1.dff",
		txd = "files/clothing/headwear/HardHat1.txd"
	},
	["Hat1"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/Hat1.dff",
		txd = "files/clothing/headwear/hats_v3.txd"
	},
	["Hat2"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/Hat2.dff",
		txd = "files/clothing/headwear/hats_v3.txd"
	},
	["Hat3"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/Hat3.dff",
		txd = "files/clothing/headwear/hats_v3.txd"
	},
	["Hat4"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/Hat4.dff",
		txd = "files/clothing/headwear/hats_v3.txd"
	},
	["Hat5"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/Hat5.dff",
		txd = "files/clothing/headwear/hats_v3.txd"
	},
	["Hat6"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/Hat6.dff",
		txd = "files/clothing/headwear/hats_v3.txd"
	},
	["Hat7"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/Hat7.dff",
		txd = "files/clothing/headwear/hats_v3.txd"
	},
	["Hat8"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/Hat8.dff",
		txd = "files/clothing/headwear/hats_v3.txd"
	},
	["Hat9"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/Hat9.dff",
		txd = "files/clothing/headwear/hats_v3.txd"
	},
	["Hat10"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/Hat10.dff",
		txd = "files/clothing/headwear/hats_v3.txd"
	},
	["HatBowler1"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/HatBowler1.dff",
		txd = "files/clothing/headwear/hats_v3.txd"
	},
	["HatBowler2"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/HatBowler2.dff",
		txd = "files/clothing/headwear/hats_v3.txd"
	},
	["HatBowler3"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/HatBowler3.dff",
		txd = "files/clothing/headwear/hats_v3.txd"
	},
	["HatBowler4"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/HatBowler4.dff",
		txd = "files/clothing/headwear/hats_v3.txd"
	},
	["HatBowler5"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/HatBowler5.dff",
		txd = "files/clothing/headwear/hats_v3.txd"
	},
	["HatCool1"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/HatCool1.dff",
		txd = "files/clothing/headwear/hats_v3.txd"
	},
	["HatCool2"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/HatCool2.dff",
		txd = "files/clothing/headwear/hats_v3.txd"
	},
	["HatCool3"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/HatCool3.dff",
		txd = "files/clothing/headwear/hats_v3.txd"
	},
	["balaclava"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/balaclava.dff",
		txd = "files/clothing/headwear/balaclava.txd"
	},
	["guccisapi"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/guccisapi.dff",
		txd = "files/clothing/headwear/guccisapi.txd"
	},
	["v3_hut1"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/v3_hut1.dff",
		txd = "files/clothing/headwear/v3_hut.txd"
	},
	["v3_hut2"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/v3_hut2.dff",
		txd = "files/clothing/headwear/v3_hut.txd"
	},
	["v3_hut3"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/v3_hut3.dff",
		txd = "files/clothing/headwear/v3_hut.txd"
	},
	["nikebuckethat"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/nikebuckethat.dff",
		txd = "files/clothing/headwear/nikebuckethat.txd"
	},
	["jordanbuckethat"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/jordanbuckethat.dff",
		txd = "files/clothing/headwear/jordanbuckethat.txd"
	},
	["manosapka"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/manosapka.dff",
		txd = "files/clothing/headwear/manosapka.txd"
	},
	["sadboybuckethat"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/sadboybuckethat.dff",
		txd = "files/clothing/headwear/sadboybuckethat.txd"
	},
	["Sapka_7"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/Sapka_7.dff",
		txd = "files/clothing/headwear/Sapka_7.txd"
	},
	["SkullyCap1"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/SkullyCap1.dff",
		txd = "files/clothing/headwear/SkullyCap.txd"
	},
	["SkullyCap2"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/SkullyCap2.dff",
		txd = "files/clothing/headwear/SkullyCap.txd"
	},
	["SkullyCap3"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/SkullyCap3.dff",
		txd = "files/clothing/headwear/SkullyCap.txd"
	},
	["usanka"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/usanka.dff",
		txd = "files/clothing/headwear/usanka.txd"
	},
	["whitecamobikerhelmet"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/whitecamobikerhelmet.dff",
		txd = "files/clothing/headwear/whitecamobikerhelmet.txd"
	},
	["WitchesHat1"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/WitchesHat1.dff",
		txd = "files/clothing/headwear/WitchesHat1.txd"
	},
	["cow"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/cowboy_hat1.dff",
		txd = "files/clothing/headwear/cowboy_hats.txd"
	},
	["cow2"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/cowboy_hat2.dff",
		txd = "files/clothing/headwear/cowboy_hats.txd"
	},
	["cow3"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/cowboy_hat3.dff",
		txd = "files/clothing/headwear/cowboy_hats.txd"
	},
	["cow4"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/cowboy_hat4.dff",
		txd = "files/clothing/headwear/cowboy_hats.txd"
	},
	["cow5"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/cowboy_hat5.dff",
		txd = "files/clothing/headwear/cowboy_hats.txd"
	},
	["cow6"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/cowboy_hat6.dff",
		txd = "files/clothing/headwear/cowboy_hats.txd"
	},
	["cow7"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/cowboy_hat7.dff",
		txd = "files/clothing/headwear/cowboy_hats.txd"
	},
	["Sapka_1"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/Sapka_1.dff",
		txd = "files/clothing/headwear/Sapka_1.txd"
	},
	["Sapka_2"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/Sapka_2.dff",
		txd = "files/clothing/headwear/Sapka_2.txd"
	},
	["Sapka_3"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/Sapka_3.dff",
		txd = "files/clothing/headwear/Sapka_3.txd"
	},
	["Sapka_4"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/Sapka_4.dff",
		txd = "files/clothing/headwear/Sapka_4.txd"
	},
	["Sapka_5"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/Sapka_5.dff",
		txd = "files/clothing/headwear/Sapka_5.txd"
	},
	["Sapka_6"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/Sapka_6.dff",
		txd = "files/clothing/headwear/Sapka_6.txd"
	},
	["Sapka_7"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/Sapka_7.dff",
		txd = "files/clothing/headwear/Sapka_7.txd"
	},
	["newera_angels"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/newera_angels.dff",
		txd = "files/clothing/headwear/newera.txd"
	},
	["newera_bostonredsox"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/newera_bostonredsox.dff",
		txd = "files/clothing/headwear/newera.txd"
	},
	["newera_dodgers"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/newera_dodgers.dff",
		txd = "files/clothing/headwear/newera.txd"
	},
	["newera_houstonastros"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/newera_houstonastros.dff",
		txd = "files/clothing/headwear/newera.txd"
	},
	["newera_oaklandathletics"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/newera_oaklandathletics.dff",
		txd = "files/clothing/headwear/newera.txd"
	},
	["newera_phillies"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/newera_phillies.dff",
		txd = "files/clothing/headwear/newera.txd"
	},
	["newera_raiders"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/newera_raiders.dff",
		txd = "files/clothing/headwear/newera.txd"
	},
	["newera_sfgiants"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/newera_sfgiants.dff",
		txd = "files/clothing/headwear/newera.txd"
	},
	["newera_washingtonnationals"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/newera_washingtonnationals.dff",
		txd = "files/clothing/headwear/newera.txd"
	},
	["newera_yankees"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/newera_yankees.dff",
		txd = "files/clothing/headwear/newera.txd"
	},
	["newera_reds"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/newera_reds.dff",
		txd = "files/clothing/headwear/newera.txd"
	},
	["newera_sox"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/newera_sox.dff",
		txd = "files/clothing/headwear/newera.txd"
	},
	["v4_burlap_sack"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/v4_burlap_sack.dff",
		txd = "files/clothing/headwear/v4_burlap_sack.txd"
	},
	["seedyno_cap"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/headwear/seedyno_cap.dff",
		txd = "files/clothing/headwear/seedyno_cap.txd"
	},
	["earring1_gold"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/earring1_gold.dff",
		txd = "files/clothing/jewellery/earring.txd"
	},
	["earring2_gold"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/earring2_gold.dff",
		txd = "files/clothing/jewellery/earring.txd"
	},
	["earring3_gold"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/earring3_gold.dff",
		txd = "files/clothing/jewellery/earring.txd"
	},
	["earring4_gold"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/earring4_gold.dff",
		txd = "files/clothing/jewellery/earring.txd"
	},
	["earring1_silver"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/earring1_silver.dff",
		txd = "files/clothing/jewellery/earring.txd"
	},
	["earring2_silver"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/earring2_silver.dff",
		txd = "files/clothing/jewellery/earring.txd"
	},
	["earring3_silver"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/earring3_silver.dff",
		txd = "files/clothing/jewellery/earring.txd"
	},
	["earring4_silver"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/earring4_silver.dff",
		txd = "files/clothing/jewellery/earring.txd"
	},
	["bracelet_gold"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/bracelet_gold.dff",
		txd = "files/clothing/jewellery/bracelet.txd"
	},
	["bracelet_silver"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/bracelet_silver.dff",
		txd = "files/clothing/jewellery/bracelet.txd"
	},
	["bracelet2"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/bracelet2.dff",
		txd = "files/clothing/jewellery/bracelet2.txd"
	},
	["bracelet3"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/bracelet3.dff",
		txd = "files/clothing/jewellery/bracelet2.txd"
	},
	["necklace_gold_black"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/necklace_gold_black.dff",
		txd = "files/clothing/jewellery/necklace_iced.txd"
	},
	["necklace_gold_blue"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/necklace_gold_blue.dff",
		txd = "files/clothing/jewellery/necklace_iced.txd"
	},
	["necklace_gold_pink"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/necklace_gold_pink.dff",
		txd = "files/clothing/jewellery/necklace_iced.txd"
	},
	["necklace_gold_red"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/necklace_gold_red.dff",
		txd = "files/clothing/jewellery/necklace_iced.txd"
	},
	["necklace_gold_white"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/necklace_gold_white.dff",
		txd = "files/clothing/jewellery/necklace_iced.txd"
	},
	["necklace_silver_black"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/necklace_silver_black.dff",
		txd = "files/clothing/jewellery/necklace_iced.txd"
	},
	["necklace_silver_blue"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/necklace_silver_blue.dff",
		txd = "files/clothing/jewellery/necklace_iced.txd"
	},
	["necklace_silver_pink"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/necklace_silver_pink.dff",
		txd = "files/clothing/jewellery/necklace_iced.txd"
	},
	["necklace_silver_red"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/necklace_silver_red.dff",
		txd = "files/clothing/jewellery/necklace_iced.txd"
	},
	["necklace_silver_white"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/necklace_silver_white.dff",
		txd = "files/clothing/jewellery/necklace_iced.txd"
	},
	["necklace_csonti"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/necklace_csonti.dff",
		txd = "files/clothing/jewellery/necklace.txd"
	},
	["necklace_fu"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/necklace_fu.dff",
		txd = "files/clothing/jewellery/necklace.txd"
	},
	["necklace_gang"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/necklace_gang.dff",
		txd = "files/clothing/jewellery/necklace.txd"
	},
	["necklace_gang2"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/necklace_gang2.dff",
		txd = "files/clothing/jewellery/necklace.txd"
	},
	["necklace_heart"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/necklace_heart.dff",
		txd = "files/clothing/jewellery/necklace.txd"
	},
	["necklace_joker"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/necklace_joker.dff",
		txd = "files/clothing/jewellery/necklace.txd"
	},
	["necklace_maci"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/necklace_maci.dff",
		txd = "files/clothing/jewellery/necklace.txd"
	},
	["necklace_maszk"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/necklace_maszk.dff",
		txd = "files/clothing/jewellery/necklace.txd"
	},
	["necklace_nba"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/necklace_nba.dff",
		txd = "files/clothing/jewellery/necklace.txd"
	},
	["necklace_snake"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/necklace_snake.dff",
		txd = "files/clothing/jewellery/necklace.txd"
	},
	["necklace_snitch"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/necklace_snitch.dff",
		txd = "files/clothing/jewellery/necklace.txd"
	},
	["necklace_v"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/necklace_v.dff",
		txd = "files/clothing/jewellery/necklace.txd"
	},
	["rocker_necklace"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/rocker_necklace.dff",
		txd = "files/clothing/jewellery/rocker_necklace.txd"
	},
	["rocker_necklace2"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/rocker_necklace2.dff",
		txd = "files/clothing/jewellery/rocker_necklace.txd"
	},
	["necklace_heart_gold_black"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/necklace_heart_gold_black.dff",
		txd = "files/clothing/jewellery/necklace_heart.txd"
	},
	["necklace_heart_gold_blue"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/necklace_heart_gold_blue.dff",
		txd = "files/clothing/jewellery/necklace_heart.txd"
	},
	["necklace_heart_gold_pink"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/necklace_heart_gold_pink.dff",
		txd = "files/clothing/jewellery/necklace_heart.txd"
	},
	["necklace_heart_gold_red"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/necklace_heart_gold_red.dff",
		txd = "files/clothing/jewellery/necklace_heart.txd"
	},
	["necklace_heart_gold_silver"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/necklace_heart_gold_silver.dff",
		txd = "files/clothing/jewellery/necklace_heart.txd"
	},
	["necklace_heart_silver_black"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/necklace_heart_silver_black.dff",
		txd = "files/clothing/jewellery/necklace_heart.txd"
	},
	["necklace_heart_silver_blue"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/necklace_heart_silver_blue.dff",
		txd = "files/clothing/jewellery/necklace_heart.txd"
	},
	["necklace_heart_silver_pink"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/necklace_heart_silver_pink.dff",
		txd = "files/clothing/jewellery/necklace_heart.txd"
	},
	["necklace_heart_silver_red"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/necklace_heart_silver_red.dff",
		txd = "files/clothing/jewellery/necklace_heart.txd"
	},
	["piera1"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/piera1.dff",
		txd = "files/clothing/jewellery/piercing.txd"
	},
	["piera2"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/piera2.dff",
		txd = "files/clothing/jewellery/piercing.txd"
	},
	["piera3"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/piera3.dff",
		txd = "files/clothing/jewellery/piercing.txd"
	},
	["piera4"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/piera4.dff",
		txd = "files/clothing/jewellery/piercing.txd"
	},
	["piera5"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/piera5.dff",
		txd = "files/clothing/jewellery/piercing.txd"
	},
	["pieraa1"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/pieraa1.dff",
		txd = "files/clothing/jewellery/piercing.txd"
	},
	["pieraa2"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/pieraa2.dff",
		txd = "files/clothing/jewellery/piercing.txd"
	},
	["pieraa3"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/pieraa3.dff",
		txd = "files/clothing/jewellery/piercing.txd"
	},
	["pieraa4"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/pieraa4.dff",
		txd = "files/clothing/jewellery/piercing.txd"
	},
	["pieraa5"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/pieraa5.dff",
		txd = "files/clothing/jewellery/piercing.txd"
	},
	["pieraaa1"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/pieraaa1.dff",
		txd = "files/clothing/jewellery/piercing.txd"
	},
	["pieraaaa1"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/pieraaaa1.dff",
		txd = "files/clothing/jewellery/piercing.txd"
	},
	["pieraaaa2"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/pieraaaa2.dff",
		txd = "files/clothing/jewellery/piercing.txd"
	},
	["pieraaaa3"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/pieraaaa3.dff",
		txd = "files/clothing/jewellery/piercing.txd"
	},
	["pieraaaa4"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/pieraaaa4.dff",
		txd = "files/clothing/jewellery/piercing.txd"
	},
	["pieraaaa5"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/pieraaaa5.dff",
		txd = "files/clothing/jewellery/piercing.txd"
	},
	["pieraaaaa1"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/pieraaaaa1.dff",
		txd = "files/clothing/jewellery/piercing.txd"
	},
	["pieraaaaa2"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/pieraaaaa2.dff",
		txd = "files/clothing/jewellery/piercing.txd"
	},
	["pieraaaaa3"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/pieraaaaa3.dff",
		txd = "files/clothing/jewellery/piercing.txd"
	},
	["pieraaaaa4"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/pieraaaaa4.dff",
		txd = "files/clothing/jewellery/piercing.txd"
	},
	["pieraaaaa5"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/pieraaaaa5.dff",
		txd = "files/clothing/jewellery/piercing.txd"
	},
	["piere1"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/piere1.dff",
		txd = "files/clothing/jewellery/piercing.txd"
	},
	["piere2"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/piere2.dff",
		txd = "files/clothing/jewellery/piercing.txd"
	},
	["piere3"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/piere3.dff",
		txd = "files/clothing/jewellery/piercing.txd"
	},
	["piere4"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/piere4.dff",
		txd = "files/clothing/jewellery/piercing.txd"
	},
	["piere5"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/piere5.dff",
		txd = "files/clothing/jewellery/piercing.txd"
	},
	["pieree1"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/pieree1.dff",
		txd = "files/clothing/jewellery/piercing.txd"
	},
	["pieree2"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/pieree2.dff",
		txd = "files/clothing/jewellery/piercing.txd"
	},
	["pieree3"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/pieree3.dff",
		txd = "files/clothing/jewellery/piercing.txd"
	},
	["pieree4"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/pieree4.dff",
		txd = "files/clothing/jewellery/piercing.txd"
	},
	["pieree5"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/pieree5.dff",
		txd = "files/clothing/jewellery/piercing.txd"
	},
	["piereee1"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/piereee1.dff",
		txd = "files/clothing/jewellery/piercing.txd"
	},
	["piereeee1"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/piereeee1.dff",
		txd = "files/clothing/jewellery/piercing.txd"
	},
	["piereeee2"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/piereeee2.dff",
		txd = "files/clothing/jewellery/piercing.txd"
	},
	["piereeee3"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/piereeee3.dff",
		txd = "files/clothing/jewellery/piercing.txd"
	},
	["piereeee4"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/piereeee4.dff",
		txd = "files/clothing/jewellery/piercing.txd"
	},
	["piereeee5"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/piereeee5.dff",
		txd = "files/clothing/jewellery/piercing.txd"
	},
	["piereeeee1"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/piereeeee1.dff",
		txd = "files/clothing/jewellery/piercing.txd"
	},
	["piereeeee2"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/piereeeee2.dff",
		txd = "files/clothing/jewellery/piercing.txd"
	},
	["piereeeee3"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/piereeeee3.dff",
		txd = "files/clothing/jewellery/piercing.txd"
	},
	["piereeeee4"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/piereeeee4.dff",
		txd = "files/clothing/jewellery/piercing.txd"
	},
	["piereeeee5"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/piereeeee5.dff",
		txd = "files/clothing/jewellery/piercing.txd"
	},
	["v3_necklace1"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v3_necklace1.dff",
		txd = "files/clothing/jewellery/v3_necklace.txd",
		transparent = true
	},
	["v3_necklace2"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v3_necklace2.dff",
		txd = "files/clothing/jewellery/v3_necklace.txd",
		transparent = true
	},
	["v3_necklace3"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v3_necklace3.dff",
		txd = "files/clothing/jewellery/v3_necklace.txd",
		transparent = true
	},
	["v3_necklace4"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v3_necklace4.dff",
		txd = "files/clothing/jewellery/v3_necklace.txd",
		transparent = true
	},
	["v3_necklace5"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v3_necklace5.dff",
		txd = "files/clothing/jewellery/v3_necklace.txd",
		transparent = true
	},
	["v3_necklace6"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v3_necklace6.dff",
		txd = "files/clothing/jewellery/v3_necklace.txd",
		transparent = true
	},
	["v3_necklace7"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v3_necklace7.dff",
		txd = "files/clothing/jewellery/v3_necklace.txd",
		transparent = true
	},
	["v3_necklace8"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v3_necklace8.dff",
		txd = "files/clothing/jewellery/v3_necklace.txd",
		transparent = true
	},
	["WatchType1"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/WatchType1.dff",
		txd = "files/clothing/jewellery/WatchType.txd"
	},
	["WatchType2"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/WatchType2.dff",
		txd = "files/clothing/jewellery/WatchType.txd"
	},
	["WatchType3"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/WatchType3.dff",
		txd = "files/clothing/jewellery/WatchType.txd"
	},
	["WatchType4"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/WatchType4.dff",
		txd = "files/clothing/jewellery/WatchType.txd"
	},
	["WatchType5"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/WatchType5.dff",
		txd = "files/clothing/jewellery/WatchType.txd"
	},
	["WatchType6"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/WatchType6.dff",
		txd = "files/clothing/jewellery/WatchType.txd"
	},
	["WatchType7"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/WatchType7.dff",
		txd = "files/clothing/jewellery/WatchType.txd"
	},
	["WatchType8"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/WatchType8.dff",
		txd = "files/clothing/jewellery/WatchType.txd"
	},
	["WatchType9"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/WatchType9.dff",
		txd = "files/clothing/jewellery/WatchType.txd"
	},
	["WatchType10"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/WatchType10.dff",
		txd = "files/clothing/jewellery/WatchType.txd"
	},
	["WatchType11"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/WatchType11.dff",
		txd = "files/clothing/jewellery/WatchType.txd"
	},
	["WatchType12"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/WatchType12.dff",
		txd = "files/clothing/jewellery/WatchType.txd"
	},
	["WatchType13"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/WatchType13.dff",
		txd = "files/clothing/jewellery/WatchType.txd"
	},
	["WatchType14"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/WatchType14.dff",
		txd = "files/clothing/jewellery/WatchType.txd"
	},
	["WatchType15"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/WatchType15.dff",
		txd = "files/clothing/jewellery/WatchType.txd"
	},
	["Nyaklanc_1"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/Nyaklanc_1.dff",
		txd = "files/clothing/jewellery/Nyaklanc_1.txd"
	},
	["Nyaklanc_2"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/Nyaklanc_2.dff",
		txd = "files/clothing/jewellery/Nyaklanc_2.txd"
	},
	["Nyaklanc_3"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/Nyaklanc_3.dff",
		txd = "files/clothing/jewellery/Nyaklanc_3.txd"
	},
	["Nyaklanc_4"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/Nyaklanc_4.dff",
		txd = "files/clothing/jewellery/Nyaklanc_4.txd"
	},
	["Nyaklanc_5"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/Nyaklanc_5.dff",
		txd = "files/clothing/jewellery/Nyaklanc_5.txd"
	},
	["Ora_1"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/Ora_1.dff",
		txd = "files/clothing/jewellery/Ora_1.txd"
	},
	["Ora_2"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/Ora_2.dff",
		txd = "files/clothing/jewellery/Ora_2.txd"
	},
	["Ora_3"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/Ora_3.dff",
		txd = "files/clothing/jewellery/Ora_3.txd"
	},
	["v4_black_casio_watch"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_black_casio_watch.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd"
	},
	["v4_black_gold_casio_watch"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_black_gold_casio_watch.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd"
	},
	["v4_black_rosegold_watch"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_black_rosegold_watch.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd"
	},
	["v4_black_silver_casio_watch"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_black_silver_casio_watch.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd"
	},
	["v4_black_silver_watch"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_black_silver_watch.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd"
	},
	["v4_black_sunglass"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_black_sunglass.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd",
		transparent = true
	},
	["v4_brown_sunglass"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_brown_sunglass.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd",
		transparent = true
	},
	["v4_darkbrown_sunglass"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_darkbrown_sunglass.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd",
		transparent = true
	},
	["v4_glasses"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_glasses.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd",
		transparent = true
	},
	["v4_golden_bracelet"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_golden_bracelet.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd"
	},
	["v4_golden_golden_bracelet"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_golden_golden_bracelet.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd"
	},
	["v4_gold_big_blackruby_ring"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_gold_big_blackruby_ring.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd"
	},
	["v4_gold_big_blueruby_ring"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_gold_big_blueruby_ring.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd"
	},
	["v4_gold_big_greenruby_ring"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_gold_big_greenruby_ring.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd"
	},
	["v4_gold_big_pinkruby_ring"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_gold_big_pinkruby_ring.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd"
	},
	["v4_gold_big_redruby_ring"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_gold_big_redruby_ring.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd"
	},
	["v4_gold_big_whiteruby_ring"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_gold_big_whiteruby_ring.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd"
	},
	["v4_gold_black_koves_kereszt_fux"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_gold_black_koves_kereszt_fux.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd"
	},
	["v4_gold_black_rolex_watch"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_gold_black_rolex_watch.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd"
	},
	["v4_gold_blue_koves_kereszt_fux"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_gold_blue_koves_kereszt_fux.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd"
	},
	["v4_gold_green_koves_kereszt_fux"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_gold_green_koves_kereszt_fux.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd"
	},
	["v4_gold_green_rolex_watch"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_gold_green_rolex_watch.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd"
	},
	["v4_gold_karika_ring"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_gold_karika_ring.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd"
	},
	["v4_gold_lion_ring"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_gold_lion_ring.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd"
	},
	["v4_gold_medium_blackruby_ring"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_gold_medium_blackruby_ring.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd"
	},
	["v4_gold_medium_blueruby_ring"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_gold_medium_blueruby_ring.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd"
	},
	["v4_gold_medium_greenruby_ring"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_gold_medium_greenruby_ring.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd"
	},
	["v4_gold_medium_pinkruby_ring"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_gold_medium_pinkruby_ring.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd"
	},
	["v4_gold_medium_redruby_ring"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_gold_medium_redruby_ring.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd"
	},
	["v4_gold_medium_whiteruby_ring"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_gold_medium_whiteruby_ring.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd"
	},
	["v4_gold_megafux"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_gold_megafux.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd"
	},
	["v4_gold_nyaklanc_kereszt"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_gold_nyaklanc_kereszt.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd"
	},
	["v4_gold_nyaklanc_kereszt2"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_gold_nyaklanc_kereszt2.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd"
	},
	["v4_gold_pink_koves_kereszt_fux"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_gold_pink_koves_kereszt_fux.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd"
	},
	["v4_gold_raj_glass"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_gold_raj_glass.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd",
		transparent = true
	},
	["v4_gold_red_koves_kereszt_fux"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_gold_red_koves_kereszt_fux.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd"
	},
	["v4_gold_small_blackruby_ring"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_gold_small_blackruby_ring.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd"
	},
	["v4_gold_small_blueruby_ring"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_gold_small_blueruby_ring.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd"
	},
	["v4_gold_small_greenruby_ring"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_gold_small_greenruby_ring.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd"
	},
	["v4_gold_small_pinkruby_ring"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_gold_small_pinkruby_ring.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd"
	},
	["v4_gold_small_redruby_ring"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_gold_small_redruby_ring.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd"
	},
	["v4_gold_small_whiteruby_ring"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_gold_small_whiteruby_ring.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd"
	},
	["v4_gold_vastag_nyaklanc"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_gold_vastag_nyaklanc.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd"
	},
	["v4_gold_watch"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_gold_watch.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd"
	},
	["v4_gold_white_koves_kereszt_fux"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_gold_white_koves_kereszt_fux.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd"
	},
	["v4_rugosbeke_gold"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_rugosbeke_gold.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd"
	},
	["v4_rugosbeke_silver"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_rugosbeke_silver.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd"
	},
	["v4_silver_big_blackruby_ring"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_silver_big_blackruby_ring.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd"
	},
	["v4_silver_big_blueruby_ring"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_silver_big_blueruby_ring.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd"
	},
	["v4_silver_big_greenruby_ring"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_silver_big_greenruby_ring.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd"
	},
	["v4_silver_big_pinkruby_ring"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_silver_big_pinkruby_ring.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd"
	},
	["v4_silver_big_redruby_ring"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_silver_big_redruby_ring.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd"
	},
	["v4_silver_big_whiteruby_ring"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_silver_big_whiteruby_ring.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd"
	},
	["v4_silver_black_koves_kereszt_fux"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_silver_black_koves_kereszt_fux.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd"
	},
	["v4_silver_blue_koves_kereszt_fux"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_silver_blue_koves_kereszt_fux.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd"
	},
	["v4_silver_blue_rolex_watch"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_silver_blue_rolex_watch.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd"
	},
	["v4_silver_bracelet"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_silver_bracelet.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd"
	},
	["v4_silver_casio_watch"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_silver_casio_watch.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd"
	},
	["v4_silver_gold_rolex_watch"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_silver_gold_rolex_watch.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd"
	},
	["v4_silver_gold_watch"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_silver_gold_watch.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd"
	},
	["v4_silver_green_koves_kereszt_fux"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_silver_green_koves_kereszt_fux.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd"
	},
	["v4_silver_karika_ring"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_silver_karika_ring.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd"
	},
	["v4_silver_lion_ring"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_silver_lion_ring.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd"
	},
	["v4_silver_medium_blackruby_ring"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_silver_medium_blackruby_ring.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd"
	},
	["v4_silver_medium_blueruby_ring"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_silver_medium_blueruby_ring.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd"
	},
	["v4_silver_medium_greenruby_ring"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_silver_medium_greenruby_ring.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd"
	},
	["v4_silver_medium_pinkruby_ring"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_silver_medium_pinkruby_ring.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd"
	},
	["v4_silver_medium_redruby_ring"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_silver_medium_redruby_ring.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd"
	},
	["v4_silver_medium_whiteruby_ring"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_silver_medium_whiteruby_ring.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd"
	},
	["v4_silver_megafux"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_silver_megafux.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd"
	},
	["v4_silver_nyaklanc_kereszt"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_silver_nyaklanc_kereszt.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd"
	},
	["v4_silver_nyaklanc_kereszt2"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_silver_nyaklanc_kereszt2.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd"
	},
	["v4_silver_pink_koves_kereszt_fux"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_silver_pink_koves_kereszt_fux.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd"
	},
	["v4_silver_raj_glass"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_silver_raj_glass.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd",
		transparent = true
	},
	["v4_silver_red_koves_kereszt_fux"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_silver_red_koves_kereszt_fux.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd"
	},
	["v4_silver_rosegold_rolex_watch"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_silver_rosegold_rolex_watch.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd"
	},
	["v4_silver_rosegold_watch"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_silver_rosegold_watch.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd"
	},
	["v4_silver_silver_bracelet"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_silver_silver_bracelet.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd"
	},
	["v4_silver_small_blackruby_ring"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_silver_small_blackruby_ring.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd"
	},
	["v4_silver_small_blueruby_ring"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_silver_small_blueruby_ring.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd"
	},
	["v4_silver_small_greenruby_ring"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_silver_small_greenruby_ring.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd"
	},
	["v4_silver_small_pinkruby_ring"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_silver_small_pinkruby_ring.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd"
	},
	["v4_silver_small_redruby_ring"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_silver_small_redruby_ring.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd"
	},
	["v4_silver_small_whiteruby_ring"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_silver_small_whiteruby_ring.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd"
	},
	["v4_silver_vastag_nyaklanc"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_silver_vastag_nyaklanc.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd"
	},
	["v4_silver_watch"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_silver_watch.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd"
	},
	["v4_silver_white_koves_kereszt_fux"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_silver_white_koves_kereszt_fux.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd"
	},
	["v4_white_sunglass"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/v4_white_sunglass.dff",
		txd = "files/clothing/jewellery/v4_carlos_jewpack.txd",
		transparent = true
	},
	["headset_camo"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/other/headset_camo.dff",
		txd = "files/clothing/other/headset.txd"
	},
	["headset_camo2"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/other/headset_camo2.dff",
		txd = "files/clothing/other/headset.txd"
	},
	["headset_harleyquinn"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/other/headset_harleyquinn.dff",
		txd = "files/clothing/other/headset.txd"
	},
	["headset_helo"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/other/headset_helo.dff",
		txd = "files/clothing/other/headset.txd"
	},
	["headset_joker"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/other/headset_joker.dff",
		txd = "files/clothing/other/headset.txd"
	},
	["piere1"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/piere1.dff",
		txd = "files/clothing/jewellery/piercing.txd"
	},
	["piere2"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/piere2.dff",
		txd = "files/clothing/jewellery/piercing.txd"
	},
	["piere3"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/piere3.dff",
		txd = "files/clothing/jewellery/piercing.txd"
	},
	["piere4"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/piere4.dff",
		txd = "files/clothing/jewellery/piercing.txd"
	},
	["piere5"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/jewellery/piere5.dff",
		txd = "files/clothing/jewellery/piercing.txd"
	},
	["tie_blue"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/other/tie_blue.dff",
		txd = "files/clothing/other/tie.txd"
	},
	["tie_red"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/other/tie_red.dff",
		txd = "files/clothing/other/tie.txd"
	},
	["tie_grey"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/other/tie_grey.dff",
		txd = "files/clothing/other/tie.txd"
	},
	["rose_black"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/other/rose_black.dff",
		txd = "files/clothing/other/rose.txd"
	},
	["rose_blue"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/other/rose_blue.dff",
		txd = "files/clothing/other/rose.txd"
	},
	["rose_red"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/other/rose_red.dff",
		txd = "files/clothing/other/rose.txd"
	},
	["rose_white"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/other/rose_white.dff",
		txd = "files/clothing/other/rose.txd"
	},
	["bowtie_black"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/other/bowtie_black.dff",
		txd = "files/clothing/other/bowtie.txd"
	},
	["bowtie_red"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/other/bowtie_red.dff",
		txd = "files/clothing/other/bowtie.txd"
	},
	["bowtie_blue"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/other/bowtie_blue.dff",
		txd = "files/clothing/other/bowtie.txd"
	},
	["fehersal"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/other/fehersal.dff",
		txd = "files/clothing/other/fehersal.txd"
	},
	["fejhallgato"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/other/fejhallgato.dff",
		txd = "files/clothing/other/fejhallgato.txd"
	},
	["fejhallgato2"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/other/fejhallgato2.dff",
		txd = "files/clothing/other/fejhallgato2.txd"
	},
	["pirossal"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/other/pirossal.dff",
		txd = "files/clothing/other/pirossal.txd"
	},
	["TheParrot1"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/other/TheParrot1.dff",
		txd = "files/clothing/other/TheParrot1.txd"
	},
	["zoldsal"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/other/zoldsal.dff",
		txd = "files/clothing/other/zoldsal.txd"
	},
	["v4_weapon_sling1"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/other/weapon_sling1.dff",
		txd = "files/clothing/other/v4_tactical_accs.txd"
	},
	["v4_weapon_sling2"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/other/weapon_sling2.dff",
		txd = "files/clothing/other/v4_tactical_accs.txd"
	},
	["v4_holster"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/other/v4_holster.dff",
		txd = "files/clothing/other/v4_tactical_accs.txd"
	},
	["v4_gunbag"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/other/v4_gunbag.dff",
		txd = "files/clothing/other/v4_tactical_accs.txd"
	},
	["v4_cigar"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/other/v4_cigar.dff",
		txd = "files/clothing/other/v4_cigarette.txd"
	},
	["v4_cigarette"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/other/v4_cigarette.dff",
		txd = "files/clothing/other/v4_cigarette.txd"
	},
	["v4_joint"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/other/v4_joint.dff",
		txd = "files/clothing/other/v4_cigarette.txd"
	},
	["ferfimelleny"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/vest/ferfimelleny.dff",
		txd = "files/clothing/vest/ferfimelleny.txd"
	},
	["ferfimelleny2"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/vest/ferfimelleny2.dff",
		txd = "files/clothing/vest/ferfimelleny2.txd"
	},
	["noimelleny"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/vest/noimelleny.dff",
		txd = "files/clothing/vest/noimelleny.txd"
	},
	["noimelleny2"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/vest/noimelleny2.dff",
		txd = "files/clothing/vest/noimelleny2.txd"
	},
	["v3_civilianvest1"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/vest/v3_civilianvest1.dff",
		txd = "files/clothing/vest/v3_civilianvest.txd"
	},
	["v3_civilianvest2"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/vest/v3_civilianvest2.dff",
		txd = "files/clothing/vest/v3_civilianvest.txd"
	},
	["v3_civilianvest3"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/vest/v3_civilianvest3.dff",
		txd = "files/clothing/vest/v3_civilianvest.txd"
	},
	["v3_civilianvest4"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/vest/v3_civilianvest4.dff",
		txd = "files/clothing/vest/v3_civilianvest.txd"
	},
	["v3_civilianvest5"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/vest/v3_civilianvest5.dff",
		txd = "files/clothing/vest/v3_civilianvest.txd"
	},
	["v3_civilianvest6"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/vest/v3_civilianvest6.dff",
		txd = "files/clothing/vest/v3_civilianvest.txd"
	},
	["v3_civilianvest7"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/vest/v3_civilianvest7.dff",
		txd = "files/clothing/vest/v3_civilianvest.txd"
	},
	["v3_civilianvest8"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/vest/v3_civilianvest8.dff",
		txd = "files/clothing/vest/v3_civilianvest.txd"
	},
	["v3_civilianvest9"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/vest/v3_civilianvest9.dff",
		txd = "files/clothing/vest/v3_civilianvest.txd"
	},
	["v3_civilianvest10"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/vest/v3_civilianvest10.dff",
		txd = "files/clothing/vest/v3_civilianvest.txd"
	},
	["v3_civilianvest11"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/vest/v3_civilianvest11.dff",
		txd = "files/clothing/vest/v3_civilianvest.txd"
	},
	["v3_civilianvest12"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/vest/v3_civilianvest12.dff",
		txd = "files/clothing/vest/v3_civilianvest.txd"
	},
	["JESSE_Triko"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/vest/JESSE_Triko.dff",
		txd = "files/clothing/vest/JESSE_Triko.txd"
	},
	------
	["v4_armor1"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/vest/v4_armor1.dff",
		txd = "files/clothing/vest/v4_armor.txd"
	},
	["v4_armor2"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/vest/v4_armor2.dff",
		txd = "files/clothing/vest/v4_armor.txd"
	},
	["v4_armor3"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/vest/v4_armor3.dff",
		txd = "files/clothing/vest/v4_armor.txd"
	},
	["v4_armor4"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/vest/v4_armor4.dff",
		txd = "files/clothing/vest/v4_armor.txd"
	},
	------
	["armor_camo"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/faction/v4/armor_camo.dff",
		txd = "files/clothing/faction/v4/armor.txd"
	},
	["polgi_armor"] = { -- elv bekerult uj
		type = "object",
		model = "object",
		dff = "files/clothing/faction/v4/armor_polgi.dff",
		txd = "files/clothing/faction/v4/armor.txd",
	},
	["v4_pd_vest"] = { -- van
		type = "object",
		model = "object",
		dff = "files/clothing/faction/v4/v4_pd_vest.dff",
		txd = "files/clothing/faction/v4/v4_pd_vest.txd"
	},
	["v4_pd_vest_kr"] = { -- bekerült elv.
		type = "object",
		model = "object",
		dff = "files/clothing/faction/v4/v4_pd_vest_kr.dff",
		txd = "files/clothing/faction/v4/v4_pd_vest_kr.txd"
	},
	["armor_pd"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/faction/v4/armor_pd.dff",
		txd = "files/clothing/faction/v4/armor.txd"
	},
	["nav_badge"] = { -- Nyakbaakasztós
		type = "object",
		model = "object",
		dff = "files/clothing/faction/v4/nav_badge.dff",
		txd = "files/clothing/faction/v4/nav_badge.txd"
	},
	["nav_traffic_vest"] = { -- Nokedli narancs színű mellény
		type = "object",
		model = "object",
		dff = "files/clothing/faction/v4/nav_traffic_vest.dff",
		txd = "files/clothing/faction/v4/nav_traffic_vest.txd"
	},
	["nav_cap"] = { -- Zöld sapka
		type = "object",
		model = "object",
		dff = "files/clothing/faction/v4/nav_cap.dff",
		txd = "files/clothing/faction/v4/nav_cap.txd"
	},
	["merkur_vest"] = { 
		type = "object",
		model = "object",
		dff = "files/clothing/faction/v4/merkur_vest.dff",
		txd = "files/clothing/faction/v4/merkur_vest.txd"
	},
	["armor_nav"] = { -- NAV Feliratos fekete mellény
		type = "object",
		model = "object",
		dff = "files/clothing/faction/v4/armor_nav.dff",
		txd = "files/clothing/faction/v4/armor_nav.txd"
	},
	["v4_army_armor"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/faction/v4/v4_army_armor.dff",
		txd = "files/clothing/faction/v4/v4_army_armor.txd"
	},
	["v4_army_armor2"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/faction/v4/v4_army_armor2.dff",
		txd = "files/clothing/faction/v4/v4_army_armor.txd"
	},
	["BMS_tool_pouch"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/faction/v4/BMS_tool_pouch.dff",
		txd = "files/clothing/faction/v4/BMS_tool_pouch.txd"
	},
	["BMS_vest"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/faction/v4/BMS_vest.dff",
		txd = "files/clothing/faction/v4/BMS_vest.txd"
	},
	["FIX_tool_pouch"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/faction/v4/FIX_tool_pouch.dff",
		txd = "files/clothing/faction/v4/FIX_tool_pouch.txd"
	},
	["FIX_vest"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/faction/v4/FIX_vest.dff",
		txd = "files/clothing/faction/v4/FIX_vest.txd"
	},
	["v4_pd_jelveny"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/faction/v4/v4_pd_jelveny.dff",
		txd = "files/clothing/faction/v4/v4_pd_jelveny.txd"
	},
	["v4_pd_ovjelveny"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/faction/v4/v4_pd_ovjelveny.dff",
		txd = "files/clothing/faction/v4/v4_pd_ovjelveny.txd"
	},
	["v4_pd_sapkaNEW"] = { -- van
		type = "object",
		model = "object",
		dff = "files/clothing/faction/v4/v4_pd_sapkaNEW.dff",
		txd = "files/clothing/faction/v4/v4_pd_sapkaNEW.txd"
	},
	["v4_pd_sapka"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/faction/v4/v4_pd_sapka.dff",
		txd = "files/clothing/faction/v4/v4_pd_sapka.txd"
	},
	["v4_pd_medicpatch"] = { -- Beírtam
		type = "object",
		model = "object",
		dff = "files/clothing/faction/v4/v4_pd_medicpatch.dff",
		txd = "files/clothing/faction/v4/v4_pd_medicpatch.txd"
	},
	["v4_pd_motoros_sisak"] = { -- Beírtam
		type = "object",
		model = "object",
		dff = "files/clothing/faction/v4/v4_pd_motoros_sisak.dff",
		txd = "files/clothing/faction/v4/v4_pd_motoros_sisak.txd"
	},
	["v4_pd_sisak"] = { -- ILYEN NINCS (?)
		type = "object",
		model = "object",
		dff = "files/clothing/faction/v4/v4_pd_sisak.dff",
		txd = "files/clothing/faction/v4/v4_pd_sisak.txd"
	},
	["v4_army_armor"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/faction/v4/v4_army_armor.dff",
		txd = "files/clothing/faction/v4/v4_army_armor.txd"
	},
	["v4_army_armor2"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/faction/v4/v4_army_armor2.dff",
		txd = "files/clothing/faction/v4/v4_army_armor.txd"
	},
	["v4_army_backpack"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/faction/v4/v4_army_backpack.dff",
		txd = "files/clothing/faction/v4/v4_army_backpack.txd"
	},
	["v4_army_baseballcap"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/faction/v4/v4_army_baseballcap.dff",
		txd = "files/clothing/faction/v4/v4_army_helmets.txd"
	},
	["v4_army_berettcap_green"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/faction/v4/v4_army_berettcap_green.dff",
		txd = "files/clothing/faction/v4/v4_army_berettcap.txd"
	},
	["v4_army_berettcap_red"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/faction/v4/v4_army_berettcap_red.dff",
		txd = "files/clothing/faction/v4/v4_army_berettcap.txd"
	},
	["v4_army_cap"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/faction/v4/v4_army_cap.dff",
		txd = "files/clothing/faction/v4/v4_army_helmets.txd"
	},
	["v4_army_helmet"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/faction/v4/v4_army_helmet.dff",
		txd = "files/clothing/faction/v4/v4_army_helmets.txd"
	},
	["v4_army_helmet_medic"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/faction/v4/v4_army_helmet_medic.dff",
		txd = "files/clothing/faction/v4/v4_army_helmets.txd"
	},
	["v4_army_helmet_pilot"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/faction/v4/v4_army_helmet_pilot.dff",
		txd = "files/clothing/faction/v4/v4_army_helmets.txd"
	},
	["OMSZmelleny"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/faction/v4/OMSZmelleny.dff",
		txd = "files/clothing/faction/v4/OMSZmelleny.txd"
	},
	["OMSZsisak"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/faction/v4/OMSZsisak.dff",
		txd = "files/clothing/faction/v4/OMSZsisak.txd"
	},
	["OMSZsztetoszkop"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/faction/v4/OMSZsztetoszkop.dff",
		txd = "files/clothing/faction/v4/OMSZsztetoszkop.txd"
	},
	["sons_of_odin_vest"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/faction/v4/sons_of_odin_vest.dff",
		txd = "files/clothing/faction/v4/sons_of_odin_vest.txd"
	},
	["army_nvhelmet"] = { -- EZT BELEÍRTAM MEGNÉZNI KELL
		type = "object",
		model = "object",
		dff = "files/clothing/faction/v4/army_nvhelmet.dff",
		txd = "files/clothing/faction/v4/army_nvhelmet.txd"
	},
	["army_mask"] = { -- EZT BELEÍRTAM MEGNÉZNI KELL
		type = "object",
		model = "object",
		dff = "files/clothing/faction/v4/army_mask.dff",
		txd = "files/clothing/faction/v4/army_mask.txd"
	},
	["v4_nni_jelveny"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/faction/v4/v4_nni_jelveny.dff",
		txd = "files/clothing/faction/v4/v4_nni_jelveny.txd"
	},
	["CNC_Melleny"] = { -- ILYEN NEM LÉTEZIK (?)
		type = "object",
		model = "object",
		dff = "files/clothing/faction/v4/CNC_Melleny.dff",
		txd = "files/clothing/faction/v4/CNC_Melleny.txd"
	},
	["v4_nni_vestNEW"] = { -- EZT BELEÍRTAM MEGNÉZNI KELL
		type = "object",
		model = "object",
		dff = "files/clothing/faction/v4/v4_nni_vestNEW.dff",
		txd = "files/clothing/faction/v4/v4_nni_vestNEW.txd"
	},
	["v4_nni_vest"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/faction/v4/v4_nni_vest.dff",
		txd = "files/clothing/faction/v4/v4_nni_vest.txd"
	},
	["okf_feherokf"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/faction/v4/okf_feherokf.dff",
		txd = "files/clothing/faction/v4/okf_feherokf.txd"
	},
	["okf_kekokf"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/faction/v4/okf_kekokf.dff",
		txd = "files/clothing/faction/v4/okf_kekokf.txd"
	},
	["okf_legzouj"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/faction/v4/okf_legzouj.dff",
		txd = "files/clothing/faction/v4/okf_legzouj.txd"
	},
	["okf_palack"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/faction/v4/okf_palack.dff",
		txd = "files/clothing/faction/v4/okf_palack.txd"
	},
	["okf_melleny"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/faction/v4/okf_melleny.dff",
		txd = "files/clothing/faction/v4/okf_melleny.txd"
	},
	["legzoalarc"] = { -- Gázálarc/Bűvár álarc
		type = "object",
		model = "object",
		dff = "files/clothing/faction/v4/legzoalarc.dff",
		txd = "files/clothing/faction/v4/legzoalarc.txd"
	},
	["okf_pirosokf"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/faction/v4/okf_pirosokf.dff",
		txd = "files/clothing/faction/v4/okf_pirosokf.txd"
	},
	["okf_tanyersapka"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/faction/v4/okf_tanyersapka.dff",
		txd = "files/clothing/faction/v4/okf_tanyersapka.txd"
	},
	["okf_otemelleny"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/faction/v4/okf_otemelleny.dff",
		txd = "files/clothing/faction/v4/okf_otemelleny.txd"
	},
	["v4_polgaror_vest"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/faction/v4/v4_polgaror_vest.dff",
		txd = "files/clothing/faction/v4/v4_polgaror_vest.txd"
	},
	["v4_polgaror_cap"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/faction/v4/v4_polgaror_cap.dff",
		txd = "files/clothing/faction/v4/v4_polgaror_cap.txd"
	},
	["v4_polgaror_badge"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/faction/v4/v4_polgaror_badge.dff",
		txd = "files/clothing/faction/v4/v4_polgaror_badge.txd"
	},
-----
	["v4_tek_cap"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/faction/v4/v4_tek_cap.dff",
		txd = "files/clothing/faction/v4/v4_tek_cap.txd"
	},
	["v4_tek_helmet_new"] = { -- ILYEN NINCS
		type = "object",
		model = "object",
		dff = "files/clothing/faction/v4/v4_tek_helmet_new.dff",
		txd = "files/clothing/faction/v4/v4_tek_helmet_new.txd"
	},
	["v4_tek_helmet"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/faction/v4/v4_tek_helmet.dff",
		txd = "files/clothing/faction/v4/v4_tek_helmet.txd"
	},
	["v4_tek_plate"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/faction/v4/v4_tek_plate.dff",
		txd = "files/clothing/faction/v4/v4_tek_plate.txd"
	},
	["v4_tek_peltor"] = { -- ILYEN NINCS (?)
		type = "object",
		model = "object",
		dff = "files/clothing/faction/v4/v4_tek_peltor.dff",
		txd = "files/clothing/faction/v4/v4_tek_peltor.txd"
	},
	["v4_tek_vest_black"] = { 
		type = "object",
		model = "object",
		dff = "files/clothing/faction/v4/v4_tek_vest_black.dff",
		txd = "files/clothing/faction/v4/v4_tek_vest_black.txd"
	},
	["v4_tek_vest_green"] = {
		type = "object",
		model = "object",
		dff = "files/clothing/faction/v4/v4_tek_vest_green.dff",
		txd = "files/clothing/faction/v4/v4_tek_vest_green.txd"
	},
--------------------------------------
["phouse"] = {
	type = "object",
	model = 13756,
	dff = "files/mansions/phouse.dff",
	col = "files/mansions/phouse.col",
	txd = "files/mansions/phouse.txd"
},
["phouse_lod"] = {
	type = "object",
	model = 13879,
	dff = "files/mansions/phouse_lod.dff",
	col = "files/mansions/phouse.col",
	txd = "files/mansions/phouse_lod.txd"
},
["CEgroundT204"] = {
	type = "object",
	model = 13083,
	dff = "files/mansions/CEgroundT204.dff",
	col = "files/mansions/CEgroundT204.col",
	txd = "files/mansions/v3_phouse2.txd"
},
["CEgroundT204_alpha"] = {
	type = "object",
	model = "object",
	dff = "files/mansions/CEgroundT204_alpha.dff",
	col = "files/mansions/CEgroundT204_alpha.col",
	txd = "files/mansions/v3_phouse2.txd",
	transparent = true,
	lodDistance = 299
},
["CEgroundT204_LOD"] = {
	type = "object",
	model = 13087,
	dff = "files/mansions/CEgroundT204_LOD.dff",
	col = "files/mansions/CEgroundT204.col",
	txd = "files/mansions/v3_phouse2_LOD.txd"
},
["v3_phouse2"] = {
	type = "object",
	model = "object",
	dff = "files/mansions/v3_phouse2.dff",
	col = "files/mansions/v3_phouse2.col",
	txd = "files/mansions/v3_phouse2.txd",
	lodDistance = 299
},
["cunte_roads66"] = {
	type = "object",
	model = 12966,
	dff = "files/mansions/cunte_roads66.dff",
	col = "files/mansions/cunte_roads66.col",
	txd = "files/mansions/v3_phouse2.txd"
},
["kresz11453"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/kresz5.dff",
	col = "files/kresz/kresz.col",
	txd = "files/kresz/kresz_ti01.txd"
},
["kresz3444"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/kresz5.dff",
	col = "files/kresz/kresz.col",
	txd = "files/kresz/kresz_ti17.txd"
},
["kresz8037"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/kresz5.dff",
	col = "files/kresz/kresz.col",
	txd = "files/kresz/kresz_ti21.txd"
},
["kresz8081"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/kresz5.dff",
	col = "files/kresz/kresz.col",
	txd = "files/kresz/kresz_ti25.txd"
},
["kresz8082"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/kresz5.dff",
	col = "files/kresz/kresz.col",
	txd = "files/kresz/kresz_ti26.txd"
},
["kresz8083"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/kresz5.dff",
	col = "files/kresz/kresz.col",
	txd = "files/kresz/kresz_ti27.txd"
},
["kresz8134"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/kresz5.dff",
	col = "files/kresz/kresz.col",
	txd = "files/kresz/kresz_ti32.txd"
},
["kresz8201"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/kresz5.dff",
	col = "files/kresz/kresz.col",
	txd = "files/kresz/kresz_ti33.txd"
},
["kresz8245"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/kresz5.dff",
	col = "files/kresz/kresz.col",
	txd = "files/kresz/kresz_ti34.txd"
},
["kresz8247"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/kresz5.dff",
	col = "files/kresz/kresz.col",
	txd = "files/kresz/kresz_ti35.txd"
},
["kresz8249"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/kresz5.dff",
	col = "files/kresz/kresz.col",
	txd = "files/kresz/kresz_ti36.txd"
},
["kresz8251"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/kresz5.dff",
	col = "files/kresz/kresz.col",
	txd = "files/kresz/kresz_ti37.txd"
},
["kresz8286"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/kresz5.dff",
	col = "files/kresz/kresz.col",
	txd = "files/kresz/kresz_ti39.txd"
},
["kresz8287"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/kresz5.dff",
	col = "files/kresz/kresz.col",
	txd = "files/kresz/kresz_ti40.txd"
},
["kresz8400"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/kresz5.dff",
	col = "files/kresz/kresz.col",
	txd = "files/kresz/kresz_ti51.txd"
},
["kresz8402"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/kresz5.dff",
	col = "files/kresz/kresz.col",
	txd = "files/kresz/kresz_ti52.txd"
},
["kresz8409"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/kresz6.dff",
	col = "files/kresz/kresz.col",
	txd = "files/kresz/kresz_ve01.txd"
},
["kresz8411"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/kresz6.dff",
	col = "files/kresz/kresz.col",
	txd = "files/kresz/kresz_ve02.txd"
},
["kresz8416"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/kresz6.dff",
	col = "files/kresz/kresz.col",
	txd = "files/kresz/kresz_ve04.txd"
},
["kresz8419"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/kresz6.dff",
	col = "files/kresz/kresz.col",
	txd = "files/kresz/kresz_ve05.txd"
},
["kresz8421"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/kresz6.dff",
	col = "files/kresz/kresz.col",
	txd = "files/kresz/kresz_ve06.txd"
},
["kresz8422"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/kresz6.dff",
	col = "files/kresz/kresz.col",
	txd = "files/kresz/kresz_ve07.txd"
},
["kresz8425"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/kresz6.dff",
	col = "files/kresz/kresz.col",
	txd = "files/kresz/kresz_ve09.txd"
},
["kresz8426"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/kresz6.dff",
	col = "files/kresz/kresz.col",
	txd = "files/kresz/kresz_ve10.txd"
},
["kresz8428"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/kresz6.dff",
	col = "files/kresz/kresz.col",
	txd = "files/kresz/kresz_ve12.txd"
},
["kresz8430"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/kresz6.dff",
	col = "files/kresz/kresz.col",
	txd = "files/kresz/kresz_ve14.txd"
},
["kresz8431"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/kresz6.dff",
	col = "files/kresz/kresz.col",
	txd = "files/kresz/kresz_ve15.txd"
},
["kresz8435"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/kresz6.dff",
	col = "files/kresz/kresz.col",
	txd = "files/kresz/kresz_ve16.txd"
},
["kresz8436"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/kresz6.dff",
	col = "files/kresz/kresz.col",
	txd = "files/kresz/kresz_ve17.txd"
},
["kresz8437"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/kresz6.dff",
	col = "files/kresz/kresz.col",
	txd = "files/kresz/kresz_ve18.txd"
},
["kresz8461"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/kresz6.dff",
	col = "files/kresz/kresz.col",
	txd = "files/kresz/kresz_ve20.txd"
},
["kresz8482"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/kresz6.dff",
	col = "files/kresz/kresz.col",
	txd = "files/kresz/kresz_ve24.txd"
},
["kresz8492"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/kresz6.dff",
	col = "files/kresz/kresz.col",
	txd = "files/kresz/kresz_ve28.txd"
},
["kresz8493"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/kresz6.dff",
	col = "files/kresz/kresz.col",
	txd = "files/kresz/kresz_ve29.txd"
},
["kresz8494"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/kresz6.dff",
	col = "files/kresz/kresz.col",
	txd = "files/kresz/kresz_ve30.txd"
},
["kresz8499"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/kresz6.dff",
	col = "files/kresz/kresz.col",
	txd = "files/kresz/kresz_ve35.txd"
},
["kresz8503"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/kresz6.dff",
	col = "files/kresz/kresz.col",
	txd = "files/kresz/kresz_ve37.txd"
},
["kresz8504"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/kresz5.dff",
	col = "files/kresz/kresz.col",
	txd = "files/kresz/kresz_us01.txd"
},
["kresz8505"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/kresz5.dff",
	col = "files/kresz/kresz.col",
	txd = "files/kresz/kresz_us02.txd"
},
["kresz8506"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/kresz5.dff",
	col = "files/kresz/kresz.col",
	txd = "files/kresz/kresz_us03.txd"
},
["kresz8507"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/kresz5.dff",
	col = "files/kresz/kresz.col",
	txd = "files/kresz/kresz_us04.txd"
},
["kresz8508"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/kresz5.dff",
	col = "files/kresz/kresz.col",
	txd = "files/kresz/kresz_us05.txd"
},
["kresz8527"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/kresz5.dff",
	col = "files/kresz/kresz.col",
	txd = "files/kresz/kresz_us09.txd"
},
["kresz8528"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/kresz5.dff",
	col = "files/kresz/kresz.col",
	txd = "files/kresz/kresz_us10.txd"
},
["kresz8565"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/kresz1.dff",
	col = "files/kresz/kresz.col",
	txd = "files/kresz/kresz_us25.txd"
},
["kresz8566"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/kresz1.dff",
	col = "files/kresz/kresz.col",
	txd = "files/kresz/kresz_us26.txd"
},
["kresz8591"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/kresz1.dff",
	col = "files/kresz/kresz.col",
	txd = "files/kresz/kresz_ut01.txd"
},
["kresz8593"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/kresz1.dff",
	col = "files/kresz/kresz.col",
	txd = "files/kresz/kresz_ut02.txd"
},
["kresz8594"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/kresz1.dff",
	col = "files/kresz/kresz.col",
	txd = "files/kresz/kresz_ut03.txd"
},
["kresz8595"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/kresz1.dff",
	col = "files/kresz/kresz.col",
	txd = "files/kresz/kresz_ut04.txd"
},
["kresz8608"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/kresz1.dff",
	col = "files/kresz/kresz.col",
	txd = "files/kresz/kresz_tj03.txd"
},
["kresz8620"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/kresz1.dff",
	col = "files/kresz/kresz.col",
	txd = "files/kresz/kresz_tj05.txd"
},
["kresz8654"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/kresz1.dff",
	col = "files/kresz/kresz.col",
	txd = "files/kresz/kresz_tj10.txd"
},
["kresz8655"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/kresz1.dff",
	col = "files/kresz/kresz.col",
	txd = "files/kresz/kresz_tj11.txd"
},
["kresz8667"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/kresz1.dff",
	col = "files/kresz/kresz.col",
	txd = "files/kresz/kresz_tj15.txd"
},
["kresz8668"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/kresz1.dff",
	col = "files/kresz/kresz.col",
	txd = "files/kresz/kresz_tj16.txd"
},
["kresz8669"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/kresz1.dff",
	col = "files/kresz/kresz.col",
	txd = "files/kresz/kresz_tj17.txd"
},
["kresz8676"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/kresz1.dff",
	col = "files/kresz/kresz.col",
	txd = "files/kresz/kresz_tj19.txd"
},
["kresz8677"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/kresz1.dff",
	col = "files/kresz/kresz.col",
	txd = "files/kresz/kresz_tj20.txd"
},
["kresz8678"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/kresz1.dff",
	col = "files/kresz/kresz.col",
	txd = "files/kresz/kresz_tj21.txd"
},
["kresz8680"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/kresz1.dff",
	col = "files/kresz/kresz.col",
	txd = "files/kresz/kresz_tj22.txd"
},
["kresz8681"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/kresz1.dff",
	col = "files/kresz/kresz.col",
	txd = "files/kresz/kresz_tj23.txd"
},
["kresz8688"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/kresz1.dff",
	col = "files/kresz/kresz.col",
	txd = "files/kresz/kresz_tj30.txd"
},
["kresz8689"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/kresz1.dff",
	col = "files/kresz/kresz.col",
	txd = "files/kresz/kresz_tj31.txd"
},
["kresz8842"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/kresz1.dff",
	col = "files/kresz/kresz.col",
	txd = "files/kresz/kresz_tj36.txd"
},
["kresz8845"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/kresz1.dff",
	col = "files/kresz/kresz.col",
	txd = "files/kresz/kresz_tj37.txd"
},
["kresz8849"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/kresz1.dff",
	col = "files/kresz/kresz.col",
	txd = "files/kresz/kresz_tj38.txd"
},
["kresz9046"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/kresz1.dff",
	col = "files/kresz/kresz.col",
	txd = "files/kresz/kresz_tj47.txd"
},
["kresz9054"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/kresz1.dff",
	col = "files/kresz/kresz.col",
	txd = "files/kresz/kresz_tj48.txd"
},
["kresz9055"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/kresz3.dff",
	col = "files/kresz/kresz.col",
	txd = "files/kresz/kresz_es01.txd"
},
["kresz9066"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/kresz4.dff",
	col = "files/kresz/kresz.col",
	txd = "files/kresz/kresz_es02.txd"
},
["kresz9076"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/kresz7.dff",
	col = "files/kresz/kresz.col",
	txd = "files/kresz/kresz_ki02.txd"
},
["kresz9078"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/kresz7.dff",
	col = "files/kresz/kresz.col",
	txd = "files/kresz/kresz_ki03.txd"
},
["kresz9162"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/kresz7.dff",
	col = "files/kresz/kresz.col",
	txd = "files/kresz/kresz_ki07.txd"
},
["kresz9163"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/kresz7.dff",
	col = "files/kresz/kresz.col",
	txd = "files/kresz/kresz_ki08.txd"
},
["kresz8079"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/kresz2.dff",
	col = "files/kresz/kresz.col",
	txd = "files/kresz/kresz_fu01.txd"
},
["kresz8675"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/kresz2.dff",
	col = "files/kresz/kresz.col",
	txd = "files/kresz/kresz_fu02.txd"
},
["kreszborder"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/border.dff",
	col = "files/kresz/border.col",
	txd = "files/kresz/speed.txd"
},
["kreszspeed30"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/speed30.dff",
	col = "files/kresz/speed.col",
	txd = "files/kresz/speed.txd"
},
["kreszspeed50"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/speed50.dff",
	col = "files/kresz/speed.col",
	txd = "files/kresz/speed.txd"
},
["kreszspeed70"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/speed70.dff",
	col = "files/kresz/speed.col",
	txd = "files/kresz/speed.txd"
},
["kreszspeed90"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/speed90.dff",
	col = "files/kresz/speed.col",
	txd = "files/kresz/speed.txd"
},
["kreszspeed100"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/speed100.dff",
	col = "files/kresz/speed.col",
	txd = "files/kresz/speed.txd"
},
["kreszspeed110"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/speed110.dff",
	col = "files/kresz/speed.col",
	txd = "files/kresz/speed.txd"
},
["kreszspeed120"] = {
	loadFromPath = true,
	model = "object",
	type = "object",
	dff = "files/kresz/speed120.dff",
	col = "files/kresz/speed.col",
	txd = "files/kresz/speed.txd"
},
["skin_dummy"] = {
	type = "skin",
	model = "ped",
	dff = "files/skins/dummy_skin.dff"
},
["skin_1"] = {
	type = "skin",
	model = 1,
	dff = "files/skins/1.dff",
	txd = "files/skins/1.txd"
},
["skin_100"] = {
	type = "skin",
	model = 100,
	dff = "files/skins/100.dff",
	txd = "files/skins/100.txd"
},
["skin_11"] = {
	type = "skin",
	model = 11,
	dff = "files/skins/11.dff",
	txd = "files/skins/11.txd"
},
["skin_114"] = {
	type = "skin",
	model = 114,
	dff = "files/skins/114.dff",
	txd = "files/skins/114.txd"
},
["skin_115"] = {
	type = "skin",
	model = 115,
	dff = "files/skins/115.dff",
	txd = "files/skins/115.txd"
},
["skin_116"] = {
	type = "skin",
	model = 116,
	dff = "files/skins/116.dff",
	txd = "files/skins/116.txd"
},
["skin_129"] = {
	type = "skin",
	model = 129,
	dff = "files/skins/129.dff",
	txd = "files/skins/129.txd"
},
["skin_13"] = {
	type = "skin",
	model = 13,
	dff = "files/skins/13.dff",
	txd = "files/skins/13.txd"
},
["skin_130"] = {
	type = "skin",
	model = 130,
	dff = "files/skins/130.dff",
	txd = "files/skins/130.txd"
},
["skin_134"] = {
	type = "skin",
	model = 134,
	dff = "files/skins/134.dff",
	txd = "files/skins/134.txd"
},
["skin_135"] = {
	type = "skin",
	model = 135,
	dff = "files/skins/135.dff",
	txd = "files/skins/135.txd"
},
["skin_139"] = {
	type = "skin",
	model = 139,
	dff = "files/skins/139.dff",
	txd = "files/skins/139.txd"
},
["skin_140"] = {
	type = "skin",
	model = 140,
	dff = "files/skins/140.dff",
	txd = "files/skins/140.txd"
},
["skin_144"] = {
	type = "skin",
	model = 144,
	dff = "files/skins/144.dff",
	txd = "files/skins/144.txd"
},
["skin_145"] = {
	type = "skin",
	model = 145,
	dff = "files/skins/145.dff",
	txd = "files/skins/145.txd"
},
["skin_173"] = {
	type = "skin",
	model = 173,
	dff = "files/skins/173.dff",
	txd = "files/skins/173.txd"
},
["skin_190"] = {
	type = "skin",
	model = 190,
	dff = "files/skins/190.dff",
	txd = "files/skins/190.txd"
},
["skin_194"] = {
	type = "skin",
	model = 194,
	dff = "files/skins/194.dff",
	txd = "files/skins/194.txd"
},
["skin_199"] = {
	type = "skin",
	model = 199,
	dff = "files/skins/199.dff",
	txd = "files/skins/199.txd"
},
["skin_2"] = {
	type = "skin",
	model = 2,
	dff = "files/skins/2.dff",
	txd = "files/skins/2.txd"
},
["skin_201"] = {
	type = "skin",
	model = 201,
	dff = "files/skins/201.dff",
	txd = "files/skins/201.txd"
},
["skin_203"] = {
	type = "skin",
	model = 203,
	dff = "files/skins/203.dff",
	txd = "files/skins/203.txd"
},
["skin_22"] = {
	type = "skin",
	model = 22,
	dff = "files/skins/22.dff",
	txd = "files/skins/22.txd"
},
["skin_232"] = {
	type = "skin",
	model = 232,
	dff = "files/skins/232.dff",
	txd = "files/skins/232.txd"
},
["skin_24"] = {
	type = "skin",
	model = 24,
	dff = "files/skins/24.dff",
	txd = "files/skins/24.txd"
},
["skin_241"] = {
	type = "skin",
	model = 241,
	dff = "files/skins/241.dff",
	txd = "files/skins/241.txd"
},
["skin_249"] = {
	type = "skin",
	model = 249,
	dff = "files/skins/249.dff",
	txd = "files/skins/249.txd"
},
["skin_256"] = {
	type = "skin",
	model = 256,
	dff = "files/skins/256.dff",
	txd = "files/skins/256.txd"
},
["skin_257"] = {
	type = "skin",
	model = 257,
	dff = "files/skins/257.dff",
	txd = "files/skins/257.txd"
},
["skin_26"] = {
	type = "skin",
	model = 26,
	dff = "files/skins/26.dff",
	txd = "files/skins/26.txd"
},
["skin_264"] = {
	type = "skin",
	model = 264,
	dff = "files/skins/264.dff",
	txd = "files/skins/264.txd"
},
["skin_277"] = {
	type = "skin",
	model = 277,
	dff = "files/skins/277.dff",
	txd = "files/skins/277.txd"
},
["skin_278"] = {
	type = "skin",
	model = 278,
	dff = "files/skins/278.dff",
	txd = "files/skins/278.txd"
},
["skin_27"] = {
	type = "skin",
	model = 27,
	dff = "files/skins/27.dff",
	txd = "files/skins/27.txd"
},
["skin_296"] = {
	type = "skin",
	model = 296,
	dff = "files/skins/296.dff",
	txd = "files/skins/296.txd"
},
["skin_297"] = {
	type = "skin",
	model = 297,
	dff = "files/skins/297.dff",
	txd = "files/skins/297.txd"
},
["skin_298"] = {
	type = "skin",
	model = 298,
	dff = "files/skins/298.dff",
	txd = "files/skins/298.txd"
},
["skin_300"] = {
	type = "skin",
	model = 300,
	dff = "files/skins/300.dff",
	txd = "files/skins/300.txd"
},
["skin_301"] = {
	type = "skin",
	model = 301,
	dff = "files/skins/301.dff",
	txd = "files/skins/301.txd"
},
["skin_304"] = {
	type = "skin",
	model = 304,
	dff = "files/skins/304.dff",
	txd = "files/skins/304.txd"
},
["skin_31"] = {
	type = "skin",
	model = 31,
	dff = "files/skins/31.dff",
	txd = "files/skins/31.txd"
},
["skin_311"] = {
	type = "skin",
	model = 311,
	dff = "files/skins/311.dff",
	txd = "files/skins/311.txd"
},
["skin_37"] = {
	type = "skin",
	model = 37,
	dff = "files/skins/37.dff",
	txd = "files/skins/37.txd"
},
["skin_49"] = {
	type = "skin",
	model = 49,
	dff = "files/skins/49.dff",
	txd = "files/skins/49.txd"
},
["skin_51"] = {
	type = "skin",
	model = 51,
	dff = "files/skins/51.dff",
	txd = "files/skins/51.txd"
},
["skin_52"] = {
	type = "skin",
	model = 52,
	dff = "files/skins/52.dff",
	txd = "files/skins/52.txd"
},
["skin_54"] = {
	type = "skin",
	model = 54,
	dff = "files/skins/54.dff",
	txd = "files/skins/54.txd"
},
["skin_55"] = {
	type = "skin",
	model = 55,
	dff = "files/skins/55.dff",
	txd = "files/skins/55.txd"
},
["skin_61"] = {
	type = "skin",
	model = 61,
	dff = "files/skins/61.dff",
	txd = "files/skins/61.txd"
},
["skin_77"] = {
	type = "skin",
	model = 77,
	dff = "files/skins/77.dff",
	txd = "files/skins/77.txd"
},
["skin_79"] = {
	type = "skin",
	model = 79,
	dff = "files/skins/79.dff",
	txd = "files/skins/79.txd"
},
["skin_88"] = {
	type = "skin",
	model = 88,
	dff = "files/skins/88.dff",
	txd = "files/skins/88.txd"
},
["skin_9"] = {
	type = "skin",
	model = 9,
	dff = "files/skins/9.dff",
	txd = "files/skins/9.txd"
},
["skin_97"] = {
	type = "skin",
	model = 97,
	dff = "files/skins/97.dff",
	txd = "files/skins/97.txd"
},
["skin_10"] = {
	type = "skin",
	model = 10,
	dff = "files/skins/10.dff",
	txd = "files/skins/10.txd"
},
["skin_18"] = {
	type = "skin",
	model = 18,
	dff = "files/skins/18.dff",
	txd = "files/skins/18.txd"
},
["skin_19"] = {
	type = "skin",
	model = 19,
	dff = "files/skins/19.dff",
	txd = "files/skins/19.txd"
},
["skin_38"] = {
	type = "skin",
	model = 38,
	dff = "files/skins/38.dff",
	txd = "files/skins/38.txd"
},
["skin_39"] = {
	type = "skin",
	model = 39,
	dff = "files/skins/39.dff",
	txd = "files/skins/39.txd"
},
["skin_45"] = {
	type = "skin",
	model = 45,
	dff = "files/skins/45.dff",
	txd = "files/skins/45.txd"
},
["skin_53"] = {
	type = "skin",
	model = 53,
	dff = "files/skins/53.dff",
	txd = "files/skins/53.txd"
},
["skin_62"] = {
	type = "skin",
	model = 62,
	dff = "files/skins/62.dff",
	txd = "files/skins/62.txd"
},
["skin_63"] = {
	type = "skin",
	model = 63,
	dff = "files/skins/63.dff",
	txd = "files/skins/63.txd"
},
["skin_64"] = {
	type = "skin",
	model = 64,
	dff = "files/skins/64.dff",
	txd = "files/skins/64.txd"
},
["skin_71"] = {
	type = "skin",
	model = 71,
	dff = "files/skins/71.dff",
	txd = "files/skins/71.txd"
},
["skin_75"] = {
	type = "skin",
	model = 75,
	dff = "files/skins/75.dff",
	txd = "files/skins/75.txd"
},
["skin_80"] = {
	type = "skin",
	model = 80,
	dff = "files/skins/80.dff",
	txd = "files/skins/80.txd"
},
["skin_81"] = {
	type = "skin",
	model = 81,
	dff = "files/skins/81.dff",
	txd = "files/skins/81.txd"
},
["skin_82"] = {
	type = "skin",
	model = 82,
	dff = "files/skins/82.dff",
	txd = "files/skins/82.txd"
},
["skin_83"] = {
	type = "skin",
	model = 83,
	dff = "files/skins/83.dff",
	txd = "files/skins/83.txd"
},
["skin_84"] = {
	type = "skin",
	model = 84,
	dff = "files/skins/84.dff",
	txd = "files/skins/84.txd"
},
["skin_87"] = {
	type = "skin",
	model = 87,
	dff = "files/skins/87.dff",
	txd = "files/skins/87.txd"
},
["skin_89"] = {
	type = "skin",
	model = 89,
	dff = "files/skins/89.dff",
	txd = "files/skins/89.txd"
},
["skin_94"] = {
	type = "skin",
	model = 94,
	dff = "files/skins/94.dff",
	txd = "files/skins/94.txd"
},
["skin_96"] = {
	type = "skin",
	model = 96,
	dff = "files/skins/96.dff",
	txd = "files/skins/96.txd"
},
["skin_102"] = {
	type = "skin",
	model = 102,
	dff = "files/skins/102.dff",
	txd = "files/skins/102.txd"
},
["skin_103"] = {
	type = "skin",
	model = 103,
	dff = "files/skins/103.dff",
	txd = "files/skins/103.txd"
},
["skin_104"] = {
	type = "skin",
	model = 104,
	dff = "files/skins/104.dff",
	txd = "files/skins/104.txd"
},
["skin_105"] = {
	type = "skin",
	model = 105,
	dff = "files/skins/105.dff",
	txd = "files/skins/105.txd"
},
["skin_106"] = {
	type = "skin",
	model = 106,
	dff = "files/skins/106.dff",
	txd = "files/skins/106.txd"
},
["skin_107"] = {
	type = "skin",
	model = 107,
	dff = "files/skins/107.dff",
	txd = "files/skins/107.txd"
},
["skin_108"] = {
	type = "skin",
	model = 108,
	dff = "files/skins/108.dff",
	txd = "files/skins/108.txd"
},
["skin_109"] = {
	type = "skin",
	model = 109,
	dff = "files/skins/109.dff",
	txd = "files/skins/109.txd"
},
["skin_110"] = {
	type = "skin",
	model = 110,
	dff = "files/skins/110.dff",
	txd = "files/skins/110.txd"
},
["skin_131"] = {
	type = "skin",
	model = 131,
	dff = "files/skins/131.dff",
	txd = "files/skins/131.txd"
},
["skin_132"] = {
	type = "skin",
	model = 132,
	dff = "files/skins/132.dff",
	txd = "files/skins/132.txd"
},
["skin_137"] = {
	type = "skin",
	model = 137,
	dff = "files/skins/137.dff",
	txd = "files/skins/137.txd"
},
["skin_138"] = {
	type = "skin",
	model = 138,
	dff = "files/skins/138.dff",
	txd = "files/skins/138.txd"
},
["skin_142"] = {
	type = "skin",
	model = 142,
	dff = "files/skins/142.dff",
	txd = "files/skins/142.txd"
},
["skin_143"] = {
	type = "skin",
	model = 143,
	dff = "files/skins/143.dff",
	txd = "files/skins/143.txd"
},
["skin_146"] = {
	type = "skin",
	model = 146,
	dff = "files/skins/146.dff",
	txd = "files/skins/146.txd"
},
["skin_153"] = {
	type = "skin",
	model = 153,
	dff = "files/skins/153.dff",
	txd = "files/skins/153.txd"
},
["skin_154"] = {
	type = "skin",
	model = 154,
	dff = "files/skins/154.dff",
	txd = "files/skins/154.txd"
},
["skin_155"] = {
	type = "skin",
	model = 155,
	dff = "files/skins/155.dff",
	txd = "files/skins/155.txd"
},
["skin_159"] = {
	type = "skin",
	model = 159,
	dff = "files/skins/159.dff",
	txd = "files/skins/159.txd"
},
["skin_163"] = {
	type = "skin",
	model = 163,
	dff = "files/skins/163.dff",
	txd = "files/skins/163.txd"
},
["skin_164"] = {
	type = "skin",
	model = 164,
	dff = "files/skins/164.dff",
	txd = "files/skins/164.txd"
},
["skin_167"] = {
	type = "skin",
	model = 167,
	dff = "files/skins/167.dff",
	txd = "files/skins/167.txd"
},
["skin_178"] = {
	type = "skin",
	model = 178,
	dff = "files/skins/178.dff",
	txd = "files/skins/178.txd"
},
["skin_196"] = {
	type = "skin",
	model = 196,
	dff = "files/skins/196.dff",
	txd = "files/skins/196.txd"
},
["skin_197"] = {
	type = "skin",
	model = 197,
	dff = "files/skins/197.dff",
	txd = "files/skins/197.txd"
},
["skin_200"] = {
	type = "skin",
	model = 200,
	dff = "files/skins/200.dff",
	txd = "files/skins/200.txd"
},
["skin_204"] = {
	type = "skin",
	model = 204,
	dff = "files/skins/204.dff",
	txd = "files/skins/204.txd"
},
["skin_205"] = {
	type = "skin",
	model = 205,
	dff = "files/skins/205.dff",
	txd = "files/skins/205.txd"
},
["skin_207"] = {
	type = "skin",
	model = 207,
	dff = "files/skins/207.dff",
	txd = "files/skins/207.txd"
},
["skin_209"] = {
	type = "skin",
	model = 209,
	dff = "files/skins/209.dff",
	txd = "files/skins/209.txd"
},
["skin_212"] = {
	type = "skin",
	model = 212,
	dff = "files/skins/212.dff",
	txd = "files/skins/212.txd"
},
["skin_213"] = {
	type = "skin",
	model = 213,
	dff = "files/skins/213.dff",
	txd = "files/skins/213.txd"
},
["skin_218"] = {
	type = "skin",
	model = 218,
	dff = "files/skins/218.dff",
	txd = "files/skins/218.txd"
},
["skin_230"] = {
	type = "skin",
	model = 230,
	dff = "files/skins/230.dff",
	txd = "files/skins/230.txd"
},
["skin_231"] = {
	type = "skin",
	model = 231,
	dff = "files/skins/231.dff",
	txd = "files/skins/231.txd"
},
["skin_236"] = {
	type = "skin",
	model = 236,
	dff = "files/skins/236.dff",
	txd = "files/skins/236.txd"
},
["skin_237"] = {
	type = "skin",
	model = 237,
	dff = "files/skins/237.dff",
	txd = "files/skins/237.txd"
},
["skin_238"] = {
	type = "skin",
	model = 238,
	dff = "files/skins/238.dff",
	txd = "files/skins/238.txd"
},
["skin_243"] = {
	type = "skin",
	model = 243,
	dff = "files/skins/243.dff",
	txd = "files/skins/243.txd"
},
["skin_244"] = {
	type = "skin",
	model = 244,
	dff = "files/skins/244.dff",
	txd = "files/skins/244.txd"
},
["skin_246"] = {
	type = "skin",
	model = 246,
	dff = "files/skins/246.dff",
	txd = "files/skins/246.txd"
},
["skin_247"] = {
	type = "skin",
	model = 247,
	dff = "files/skins/247.dff",
	txd = "files/skins/247.txd"
},
["skin_251"] = {
	type = "skin",
	model = 251,
	dff = "files/skins/251.dff",
	txd = "files/skins/251.txd"
},
["skin_252"] = {
	type = "skin",
	model = 252,
	dff = "files/skins/252.dff",
	txd = "files/skins/252.txd"
},
["skin_253"] = {
	type = "skin",
	model = 253,
	dff = "files/skins/253.dff",
	txd = "files/skins/253.txd"
},
["skin_255"] = {
	type = "skin",
	model = 255,
	dff = "files/skins/255.dff",
	txd = "files/skins/255.txd"
},
["skin_260"] = {
	type = "skin",
	model = 260,
	dff = "files/skins/260.dff",
	txd = "files/skins/260.txd"
},
["skin_263"] = {
	type = "skin",
	model = 263,
	dff = "files/skins/263.dff",
	txd = "files/skins/263.txd"
},
["skin_118"] = {
	type = "skin",
	model = 118,
	dff = "files/skins/118.dff",
	txd = "files/skins/118.txd"
},
["skin_310"] = {
	type = "skin",
	model = 310,
	dff = "files/skins/310.dff",
	txd = "files/skins/310.txd"
},
["wheel_gn1"] = {
	type = "vehicle",
	model = 1082,
	dff = "files/wheels/wheel_gn1.dff",
	txd = "files/wheels/wheels.txd",
	nonDynamic = true,
	skipImg = true
},
["wheel_gn2"] = {
	type = "vehicle",
	model = 1085,
	dff = "files/wheels/wheel_gn2.dff",
	txd = "files/wheels/wheels.txd",
	nonDynamic = true,
	skipImg = true
},
["wheel_gn3"] = {
	type = "vehicle",
	model = 1096,
	dff = "files/wheels/wheel_gn3.dff",
	txd = "files/wheels/wheels.txd",
	nonDynamic = true,
	skipImg = true
},
["wheel_gn4"] = {
	type = "vehicle",
	model = 1097,
	dff = "files/wheels/wheel_gn4.dff",
	txd = "files/wheels/wheels.txd",
	nonDynamic = true,
	skipImg = true
},
["wheel_gn5"] = {
	type = "vehicle",
	model = 1098,
	dff = "files/wheels/wheel_gn5.dff",
	txd = "files/wheels/wheels.txd",
	nonDynamic = true,
	skipImg = true
},
["wheel_sr1"] = {
	type = "vehicle",
	model = 1079,
	dff = "files/wheels/wheel_sr1.dff",
	txd = "files/wheels/wheels.txd",
	nonDynamic = true,
	skipImg = true
},
["wheel_sr2"] = {
	type = "vehicle",
	model = 1075,
	dff = "files/wheels/wheel_sr2.dff",
	txd = "files/wheels/wheels.txd",
	nonDynamic = true,
	skipImg = true
},
["wheel_sr3"] = {
	type = "vehicle",
	model = 1074,
	dff = "files/wheels/wheel_sr3.dff",
	txd = "files/wheels/wheels.txd",
	nonDynamic = true,
	skipImg = true
},
["wheel_sr4"] = {
	type = "vehicle",
	model = 1081,
	dff = "files/wheels/wheel_sr4.dff",
	txd = "files/wheels/wheels.txd",
	nonDynamic = true,
	skipImg = true
},
["wheel_sr5"] = {
	type = "vehicle",
	model = 1080,
	dff = "files/wheels/wheel_sr5.dff",
	txd = "files/wheels/wheels.txd",
	nonDynamic = true,
	skipImg = true
},
["wheel_sr6"] = {
	type = "vehicle",
	model = 1073,
	dff = "files/wheels/wheel_sr6.dff",
	txd = "files/wheels/wheels.txd",
	nonDynamic = true,
	skipImg = true
},
["wheel_lr1"] = {
	type = "vehicle",
	model = 1077,
	dff = "files/wheels/wheel_lr1.dff",
	txd = "files/wheels/wheels.txd",
	nonDynamic = true,
	skipImg = true
},
["wheel_lr2"] = {
	type = "vehicle",
	model = 1083,
	dff = "files/wheels/wheel_lr2.dff",
	txd = "files/wheels/wheels.txd",
	nonDynamic = true,
	skipImg = true
},
["wheel_lr3"] = {
	type = "vehicle",
	model = 1078,
	dff = "files/wheels/wheel_lr3.dff",
	txd = "files/wheels/wheels.txd",
	nonDynamic = true,
	skipImg = true
},
["wheel_lr4"] = {
	type = "vehicle",
	model = 1076,
	dff = "files/wheels/wheel_lr4.dff",
	txd = "files/wheels/wheels.txd",
	nonDynamic = true,
	skipImg = true
},
["wheel_lr5"] = {
	type = "vehicle",
	model = 1084,
	dff = "files/wheels/wheel_lr5.dff",
	txd = "files/wheels/wheels.txd",
	nonDynamic = true,
	skipImg = true
},
["wheel1"] = {
	type = "vehicle",
	model = 1025,
	dff = "files/wheels/wheel1.dff",
	txd = "files/wheels/wheels.txd",
	nonDynamic = true,
	skipImg = true
},
["bollard"] = {
	type = "object",
	model = 1214,
	static = true,
	lodDistance = 150
},
["bollardlight"] = {
	type = "object",
	model = 1215,
	static = true,
	lodDistance = 150
},
["DYN_ROADBARRIER_5b"] = {
	type = "object",
	model = 1435,
	static = true
},
["1352"] = {
	type = "object",
	model = 1352,
	lodDistance = 150
},
["3516"] = {
	type = "object",
	model = 3516,
	lodDistance = 150
},
["9131"] = {
	type = "object",
	model = 9131,
	lodDistance = 150
},
["918"] = {
	type = "object",
	model = 918,
	static = true
},
["1676"] = {
	type = "object",
	model = 1676,
	static = true
},
["v4_church"] = {
	type = "object",
	model = "object",
	dff = "files/church/v4_church.dff",
	txd = "files/church/v4_church.txd",
	col = "files/church/v4_church.col"
},
["v4_church_alpha"] = {
	type = "object",
	model = "object",
	dff = "files/church/v4_church_alpha.dff",
	txd = "files/church/v4_church.txd",
	col = "files/church/v4_church_alpha.col"
},
["v4_church_lights"] = {
	type = "object",
	model = "object",
	dff = "files/church/v4_church_lights.dff",
	txd = "files/church/v4_church.txd",
	col = "files/church/v4_church_lights.col"
},
["v4_church_props"] = {
	type = "object",
	model = "object",
	dff = "files/church/v4_church_props.dff",
	txd = "files/church/v4_church.txd",
	col = "files/church/v4_church_props.col",
	transparent = true,
	flags = {
		"no_zbuffer_write"
	}
},
["chapel_SFN"] = {
	type = "object",
	model = 9310,
	dff = "files/church/chapel_SFN.dff",
	txd = "files/church/presidio01_SFN.txd",
	lodDistance = 250
},
["v4_brass_sheet"] = {
	type = "object",
	model = "object",
	dff = "files/ammo_craft/v4_brass_sheet.dff",
	txd = "files/ammo_craft/v4_sheetpress.txd",
},
["v4_bulletcase"] = {
	type = "object",
	model = "object",
	dff = "files/ammo_craft/v4_bulletcase.dff",
	txd = "files/ammo_craft/v4_bulletpress.txd",
},
["v4_bulletpress"] = {
	type = "object",
	model = "object",
	dff = "files/ammo_craft/v4_bulletpress.dff",
	txd = "files/ammo_craft/v4_bulletpress.txd",
},
["v4_bulletpress_handle"] = {
	type = "object",
	model = "object",
	dff = "files/ammo_craft/v4_bulletpress_handle.dff",
	txd = "files/ammo_craft/v4_bulletpress.txd",
},
["v4_presser"] = {
	type = "object",
	model = "object",
	dff = "files/ammo_craft/v4_presser.dff",
	txd = "files/ammo_craft/v4_sheetpress.txd",
},
["v4_sheetpress"] = {
	type = "object",
	model = "object",
	dff = "files/ammo_craft/v4_sheetpress.dff",
	txd = "files/ammo_craft/v4_sheetpress.txd",
},
["v4_vacation_chest"] = {
	type = "object",
	model = "object",
	dff = "files/objects/v4_vacation_chest.dff",
	txd = "files/objects/v4_vacation_chest.txd",
},
["v4_vacation_chest_lock"] = {
	type = "object",
	model = "object",
	dff = "files/objects/v4_vacation_chest_lock.dff",
	txd = "files/objects/v4_vacation_chest.txd",
},
["v4_vacation_chest_top"] = {
	type = "object",
	model = "object",
	dff = "files/objects/v4_vacation_chest_top.dff",
	txd = "files/objects/v4_vacation_chest.txd",
},
["mp5lng"] = {
type = "object",
model = "object",
dff = "files/weapons/mp5lng.dff",
txd = "files/weapons/mp5lng.txd",
},
["sniper"] = {
	type = "object",
	model = "object",
	dff = "files/weapons/sniper.dff",
	txd = "files/weapons/sniper.txd",
},
}
function getModelId(model)
	if modelList[model] and tonumber(modelList[model].model) then
		return modelList[model].model
	end
	
	return false
end
function getModelNameById(id)
	for name, dat in pairs(modelList) do
		if dat.model == id then
			return name
		end
	end
	return false
end

for modelName in pairs(modelList) do
	if toImg[modelName] then
		local modelData = modelList[modelName]
		if not modelData.img then
			modelData.img = true
			if modelData.dff then
				modelData.dff = imgLinks[modelData.dff] .. ".dff"
			end
			if modelData.txd then
				modelData.txd = imgLinks[modelData.txd] .. ".txd"
			end
		end
	end
end

for modelName in pairs(modelList) do
    if not toImg[modelName] then
      local modelData = modelList[modelName]
      if modelData.img then
       modelData.img = true
        if modelData.dff then
          modelData.dff = imgLinks[modelData.dff] .. ".dff"
        end
        if modelData.txd then
          modelData.txd = imgLinks[modelData.txd] .. ".txd"
        end
      end
    end
  end
