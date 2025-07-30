local mapList = {
-- Event Maps
    --"event-maps/bayside_ice.map", 
    --"event-maps/bayside_ice_szlalom.map", 
    --"event-maps/karacsony.map", 
-- Group Maps
    --Illegal
    "group-maps/illegal/BalkanskoBratstvo.map", 
    "group-maps/illegal/bocg.map", 
    "group-maps/illegal/cam.map", 
    "group-maps/illegal/CartelDeGolfo.map", 
    "group-maps/illegal/ccv.map", 
    "group-maps/illegal/charlestown_mob.map", 
    "group-maps/illegal/dv.map", 
    "group-maps/illegal/dv_inti.map", 
    "group-maps/illegal/kyokuryu_kai.map", 
    "group-maps/illegal/levequemob.map", 
    "group-maps/illegal/ms.map", 
    "group-maps/illegal/ndrangheta.map", 
    "group-maps/illegal/north_side_mob.map", 
    "group-maps/illegal/CrniZmajSavez.map", 
    "group-maps/illegal/CrniZmajSavez_inti.map",
    "group-maps/illegal/rob.map", 
    "group-maps/illegal/rob_inti.map", 
    "group-maps/illegal/scandinavian_forlangning.map", 
    "group-maps/illegal/scandinavian_forlangning_inti.map", 
    "group-maps/illegal/turkish.map", 
    "group-maps/illegal/turkish_inti.map", 
    --Legal
   --Országos Rendőr-főkapitányság 
    "group-maps/legal/PD.map",
    "group-maps/legal/PD-INT.map",
    "group-maps/legal/PD-Tierra.map", 
    "group-maps/legal/PD-Dillimore.map", 
    "group-maps/legal/PD-Dillimore-INT.map",
    "group-maps/legal/PD-Akademia.map",
   --Terrorelhárítási Központ  
    "group-maps/legal/TEK.map", 
    "group-maps/legal/TEK-INT.map",
   --Nemzeti Nyomozó Iroda
    "group-maps/legal/NNI-LS.map",
    "group-maps/legal/NNI-LS-INT.map",
    "group-maps/legal/NNI-SF.map",
    "group-maps/legal/NNI-SF-INT.map",
   --Honvédség
    "group-maps/legal/ARMY.map",
    "group-maps/legal/ARMY-INT.map",
   --Nemzeti Adó- és Vámhivatal 
    "group-maps/legal/NAV.map", 
    "group-maps/legal/NAV-INT.map",

   --Szerelő 
    "group-maps/legal/BMS.map", 
    "group-maps/legal/FIX.map", 
    "group-maps/legal/APMS.map",
   --Mentőszolgálat
    "group-maps/legal/LS-Korhaz.map", 
    "group-maps/legal/LS-Korhaz-INT.map",
    "group-maps/legal/SF-Korhaz.map", 
    "group-maps/legal/SF-Korhaz-INT.map", 
    "group-maps/legal/Montgomery-Korhaz.map", 
    "group-maps/legal/Montgomery-Korhaz-INT.map",
    "group-maps/legal/Tierra-Korhaz.map", 
    "group-maps/legal/Tierra-Korhaz-INT.map", 
    "group-maps/legal/OMSZ-Kozpont.map", 
    "group-maps/legal/OMSZ-Kozpont-INT.map", 
   --Katasztrófavédelem 
    "group-maps/legal/OKF-LS-KIKEPZO-INTERIOROK.map", 
    "group-maps/legal/OKF-LS.map",
    "group-maps/legal/OKF-SF.map", 
   --Parkolás Felügyelet 
    "group-maps/legal/PF.map", 
    "group-maps/legal/PF-INT.map",
   --Taxi 
    "group-maps/legal/TAXI.map", 
    "group-maps/legal/TAXI-INT.map",
   --The Club Management 
    "group-maps/legal/TheClubManagement.map",
-- Public Maps
    "public-maps/club.map", 
    "public-maps/dancehut.map", 
    "public-maps/billiard.map", 
    "public-maps/fishing_remove.map", 
    "public-maps/fuel.map", 
    "public-maps/hangar.map", 
    "public-maps/lotteryinti_fix.map", 
    "public-maps/makvirag.map", 
    "public-maps/mining_co.map", 
    "public-maps/pawnshop.map", 
    "public-maps/piac.map", 
    "public-maps/SightCity-Admiral.map", 
    "public-maps/SightRing.map", 
    "public-maps/tierra_bank.map", 
    "public-maps/bballpalya.map", 
    "public-maps/PigPen.map", 
    "public-maps/delibollard.map", 
    "public-maps/farmnagyker.map", 
    "public-maps/fishing.map", 
    "public-maps/GroveStreet.map", 
    "public-maps/gyar_ls.map", 
    "public-maps/gyar_sf.map", 
    "public-maps/hajobonto.map", 
    "public-maps/hatar_bb.map", 
    "public-maps/hatar_deli.map", 
    "public-maps/hatar_eszaki.map", 
    "public-maps/hatar_garver_bridge.map", 
    "public-maps/hatar_sf.map", 
    "public-maps/kivalto.map", 
    "public-maps/kreszlampak.map", 
    "public-maps/lsoktato.map", 
    "public-maps/methlab.map", 
    "public-maps/palolezaras.map", 
    "public-maps/palominoto.map", 
    "public-maps/sf_casino.map", 
    "public-maps/taxilezaras.map", 
    "public-maps/ujfarmok.map", 
    "public-maps/kreszfekvok.map", 
    "public-maps/aircraft_dealer.map", 
    "public-maps/autoker.map", 
    "public-maps/billboards.map", 
    "public-maps/goldbank.map", 
    "public-maps/industrialpark_ls.map", 
    --"public-maps/kreszkieg.map", [kiveszi a menekuloutak 95%-at]
    "public-maps/kreszmap.map", 
    "public-maps/map_expansion.map", 
    "public-maps/map_fixes.map", 
    "public-maps/paintshop.map", 
    "public-maps/PershingSquare.map", 
    "public-maps/sightburger.map", 
    "public-maps/SightCityHall.map", 
    "public-maps/SightCityMall.map", 
    "public-maps/migutrans_ls.map", 
    "public-maps/welcomeshops.map",
    "public-maps/othermechanic_doors.map",
    "public-maps/church.map", -- @noffy
-- Private Maps 
    "private-maps/adambirtok.map", 
    --"private-maps/banhidi_birtok.map", [4 savos mellett birtok]
    --"private-maps/BBgatedepo.map", [nagyker melletti hegyen birtok]
    "private-maps/birtok.map", 
    --"private-maps/birtokplusz.map", --[modellezett birtok,a sightcity tabla mogott]
    --"private-maps/egyedipeco1.map", --[proppok a birtokpluszhoz]
    --"private-maps/Borisz.map", [ls deli hatarral szemben farm helyen]
    --"private-maps/BoriszSFMaganbirtok.map", [sf kozepen geci ronda]
    "private-maps/BuckyPalotaV2.map", 
    "private-maps/CsabeszBirtokBeach.map", 
    "private-maps/Debo-birtok2.map", 
    "private-maps/GNI-Spar53.map", --[konicssal eggyutt]
    "private-maps/konics.map", --[spar53al eggyutt]
    "private-maps/Koztarsasag_2022_12_08.map", --??
    "private-maps/mapolas-vegleges.map", 
    "private-maps/Notic3sFINALbirtok.map", 
    --"private-maps/Palobirtok.map",
    "private-maps/phouse2kesz.map",
    --"private-maps/shifty.map", --sfben van kint az elejen, szerintem csunya
    "private-maps/Sib-birtok.map", 
    "private-maps/snezzy-gni.map", 
    "private-maps/snezzy.map", 
    "private-maps/snezzynew.map", 
    "private-maps/veglegesbirtok.map", 
    "private-maps/Viko-brtok-21-02-05.map", 
    --"private-maps/Wesquecmontgo.map", [Montgomery mögött birtok]
    --"private-maps/yegoruj.map" [Pietrak,Vito,stb. birtok LS parton]
}

addEvent("requestInitialMapList", true)
addEventHandler("requestInitialMapList", getRootElement(), function()
    if client == source then
        triggerClientEvent(client, "refreshMapList", client, mapList)
    end
end)

addEvent("requestMapData", true)
addEventHandler("requestMapData", getRootElement(), function(map)
    if map and fileExists(map) then
        local file = fileOpen(map)
        local size = fileGetSize(file)
        local buffer = fileRead(file, size)
        fileClose(file)
        
        if buffer then
            triggerLatentClientEvent(client, "gotMapData", 50000000, client, map, fromJSON(buffer))
        end
    end
end)

local editorState = {}

addCommandHandler("mapeditor", function(sourcePlayer, commandName)
    if exports.sPermission:hasPermission(sourcePlayer, "mapeditor") then
        if not editorState[sourcePlayer] then
            editorState[sourcePlayer] = false
        end

        editorState[sourcePlayer] = not editorState[sourcePlayer]
        triggerClientEvent(sourcePlayer, "toggleEditorMode", sourcePlayer, editorState[sourcePlayer])
    end
end)

addEvent("toggleEditorMode", true)
addEventHandler("toggleEditorMode", root, function()
    if editorState[client] then
        editorState[client] = false
    end

    editorState[client] = false

    triggerClientEvent(client, "toggleEditorMode", client, editorState[client])
end)