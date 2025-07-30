commandTable = {
---PARANCSOK RENDSZEREKBŐL
--Casino
    --BlackJack
    ["deleteblackjack"] = {level = 9, title = "BlackJack asztal kitörlése", syntax = "[ID]"},
    --Horsee
    ["horseemaffia"] = {level =8, title = "Horsight nyertes beállítása", syntax = "[szám]"}, -- használathoz szöveg
    ["horseewinners"] = {level =8, title = "Horsight jövőbeli rangsor megtekintése", syntax = ""}, -- parancshoz asztalnál kell ülnöd szöveg
--Farm
    ["getfarmowner"] = {level =1, title = "Farm tulajdonosának lekérése", syntax = "[Farm ID]"}, -- ha olyat kérdezel le ami nincs bérelve errorozik
    ["renamefarm"] = {level =4, title = "Farm nevének megváltoztatása", syntax = "[Farm ID] [név]"}, -- nem béreltnél ne lehessen változtatni, most mindig sikeres
    ["resettools"] = {level =1, title = "Farm eszközeinek alaphelyzetbe állítása", syntax = "[Farm ID]"},
--Impound
    ["lefoglal"] = {level =2, title = "Jármű lefoglalása", syntax = ""},
    ["impounded"] = {level =6, title = "Játékos lefoglalt járműveinek kezelése", syntax = "[Játékos Név / ID]"},
--freecam
    ["freecam"] = {level =6, title = "Freecam nézet", syntax = ""}, -- applyFreeCamAlpha missing
--runcode
    ["srun"] = {level =11, title = "Kód futtatás", syntax = ""},
    ["crun"] = {level =11, title = "Kód futtatás", syntax = ""},
--Interior
    ["createinterior"] = {level =6, title = "Interior létrehozása", syntax = "[Belső Azonosító (0: DUMMY)] [Típus] [Ár] [Név]"},
    ["deleteinterior"] = {level =6, title = "Interior törlése", syntax = "[Interior ID]"},
    ["resetinterior"] = {level =6, title = "Interior alaphelyzetbe állítása", syntax = "[Interior ID]"},
    ["setinteriorentrance"] = {level =6, title = "Interior bejáratának áthelyezése", syntax = "[Interior ID]"},
    ["setinteriorexit"] = {level =6, title = "Interior kijáratának áthelyezése", syntax = "[Interior ID]"},
    ["setinteriorname"] = {level =6, title = "Interior nevének módosítása", syntax = "[Interior ID] [Név]"},
    ["setinteriorgroup"] = {level =6, title = "Interior frakcióhoz kötése", syntax = "[Interior ID] [Frakció | (0 - Levétel)]"},
    ["setinterioreditable"] = {level =6, title = "Interior szerkeszthetővé alakítása", syntax = "[Interior ID] [X] [Y]"},
    ["getinterioreditable"] = {level =6, title = "Interior szerkeszthetőségének lekérése", syntax = "[Interior ID]"}, -- nincs használat hozzá
    ["getinteriorowner"] = {level =6, title = "Interior tulajdonosának lekérése", syntax = "[Interior ID]"},
    ["gotointerior"] = {level =1, title = "Interiorhoz teleportálás", syntax = "[Interior ID]"}, -- ha nem létezőhöz TP-zel errorozik
    ["changelock2int"] = {level =6, title = "Interiorhoz kulcs másolás", syntax = "[Interior ID]"},
    ["setinteriorowner"] = {level =6, title = "Interiorhoz tulajdonosának beállítása", syntax = "[Interior ID] [Játékos Név / ID]"},
    ["setinteriorprice"] = {level =6, title = "Interior vásárlási ár módosítása", syntax = "[Interior ID] [Ár]"},
    ["setinteriorid"] = {level =6, title = "Interior belső módosítása", syntax = "[Interior ID] [Belső ID]"},
    ["setinteriorunowned"] = {level =6, title = "Interior szabaddá tétele", syntax = "[Interior ID]"},
    ["groupinteriors"] = {level =6, title = "Frakció interiorjainak listája", syntax = "[Frakció prefix (pl. PD, NAV)]"},
--Discord
    ["settwofactorstate"] = {level =8, title = "Discord kétlépcsős összekötés (másnak)", syntax = "[Játékos Név / ID]"},
--Goldrob
    ["resetgoldrob"] = {level =8, title = "Aranybank alaphelyzetbe állítása", syntax = ""}, -- Ehhez jó lenne egy megerősítés mint az unjail-hez
    ["gotosecuricar"] = {level =4, title = "Aranyrúd szállítóhoz teleportálás ", syntax = "[Jármű azonosítója]"},
    ["deletesecuricar"] = {level =4, title = "Aranyrúd szállító törlése", syntax = "[Jármű azonosítója]"},
    ["nearbysecuricars"] = {level =4, title = "Közeledben lévő aranyrúd szállítók", syntax = ""},
    --getsecuricar
    ["robgoldbank"] = {level =8, title = "Aranybank kirablása", syntax = ""}, -- Ehhez jó lenne egy megerősítés mint az unjail-hez // ?
--Luraph
    ["luraphresourcefile"] = {level =11, title = "Resource levédése", syntax = "[resourceName] [fileName]"},
--Coupon
    ["createcoupon"] = {level =8, title = "Kupon létrehozása", syntax = ""},
    ["couponlist"] = {level =8, title = "Elérhető kuponok megtekintése", syntax = ""},
--Shutdown
    ["startshutdown"] = {level =8, title = "Szerver leállítása", syntax = "[Másodperc] [Indok]"},
    ["stopshutdown"] = {level =8, title = "Szerver leállításának leállítása", syntax = ""},
--Mining
    ["givemineloco"] = {level =8, title = "Mozdony adása bányába", syntax = ""},
    ["removemineloco"] = {level =8, title = "Mozdony adása bányába", syntax = ""},
    ["giveminecart"] = {level =11, title = "Csille adása bányába", syntax = "[Mennyiség]"}, -- nem jó
    ["takeminecart"] = {level =11, title = "Csille elvétele bányából", syntax = "[Mennyiség]"}, -- nem jó
    ["setmineinventory"] = {level =8, title = "Bánya inventory módosítása", syntax = "[railIrons | railWoods | mineLamps] [Mennyiség]"},
    ["setminefueltank"] = {level =8, title = "Bánya üzemanyagtartály szint módosítása", syntax = "[Liter]"},
    ["mineevent"] = {level =8, title = "Bánya eventek indítása", syntax = "[0: Nincs ; 1: Miner Event ; 2: Miner Chest Event]"},
    ["forcesavemine"] = {level =8, title = "Bánya adatainak mentése", syntax = "[ID]"},
    ["scheduleminesaving"] = {level =10, title = "ne birizgáljad", syntax = "[ID]"},
    ["getmineinfo"] = {level =10, title = "Bánya adatainak megtekintése", syntax = "[Bánya ID]"}, -- Érces ládák, vonat/csille szám még mehetne bele
--Fire
    ["generatefire"] = {level =11, title = "Random tűz létrehozása (OKF)", syntax = "ne birizgáld"}, -- Feléleszteni ezt, csak akkor működjön ha nincs tűz a mappon (mert max 1db lehet)
--Accounts
    ["saveme"] = {level =8, title = "Adatmentés", syntax = ""},
    ["payday"] = {level =10, title = "Fizetés kiküldése magadnak", syntax = ""},
--Adminhelp
    ["adminhelp"] = {level =1, title = "Adminhelp megtekintése", syntax = ""}, -- Nincs adminszint mögé dugva
--Administration
    ["fly"] = {level = 1, title = "Repülés be/ki kapcsolása", syntax = ""},
    ["delmark"] = {level = 1, title = "Teleport mark törlése", syntax = "[Név]"},
    ["marks"] = {level = 1, title = "Teleport jelölések megtekintése", syntax = ""},
    ["mark"] = {level = 1, title = "Teleport jelölések megtekintése", syntax = "[Név]"},
    ["gotomark"] = {level = 1, title = "Markhoz teleportálás", syntax = ""},
    ["spectate"] = {level = 1, title = "Játékos megfigyelése", syntax = "[Játékos Név / ID] [Indok]"},
    ["crash"] = {level = 10, title = "Játékos kifagyása okának megtekintése", syntax = "[Játékos Név / ID]"},
    ["forcereconnect"] = {level = 7, title = "Játékos újracsatlakoztatása", syntax = "[Játékos Név / ID]"},
    ["goto"] = {level = 1, title = "Játékoshoz teleportálás", syntax = "[Játékos Név / ID]"},
    ["gethere"] = {level = 1, title = "Játékos magadhoz teleportálása", syntax = "[Játékos Név / ID]"},
    ["vanish"] = {level = 1, title = "Láthatatlan mód", syntax = ""},
    ["setadminlevel"] = {level = 7, title = "Adminszint változtatása", syntax = "[Játékos Név / ID] [Szint < 0 - 11 >]"},
    ["setadminnick"] = {level = 7, title = "Adminnév változtatása", syntax = "[Játékos Név / ID] [Új név]"},
    ["sethelperlevel"] = {level = 3, title = "Adminsegéd szint változtatása", syntax = "[Játékos Név / ID] [Szint < 0 - 2 >]"},
    ["aduty"] = {level = 1, title = "Adminszolgálatba állás", syntax = ""},
    ["a"] = {level = 1, title = "Adminchat", syntax = "[Üzenet]"},
    ["fa"] = {level = 6, title = "FőAdmin chat", syntax = "[Üzenet]"},
    ["gc"] = {level = 1, title = "RP Őr chat", syntax = "[Üzenet]"},
    ["as"] = {level = 1, title = "Adminsegéd chat", syntax = "[Üzenet]"},
    ["togonline"] = {level = 6, title = "Online státusz", syntax = ""},
    ["nocol"] = {level = 6, title = "Online státusz", syntax = "[Idő (mp)]"},
    ["asay"] = {level = 1, title = "Felhívás létrehozása", syntax = "[Üzenet]"},
    ["vhspawn"] = {level = 1, title = "Játékos városházára teleportálása", syntax = "[Játékos Név / ID]"},
    ["akspawn"] = {level = 1, title = "Játékos autókereskedéshez teleportálása", syntax = "[Játékos Név / ID]"},
    ["sethp"] = {level = 1, title = "Játékos életerejének megváltoztatása", syntax = "[Játékos Név / ID] [Életerő < 0 - 100 >]"},
    ["setskin"] = {level = 1, title = "Játékos kinézetének megváltoztatása", syntax = "[Játékos Név / ID] [Skin ID]"},
    ["changename"] = {level = 2, title = "Játékos nevének megváltoztatása", syntax = "[Játékos Név / ID] [Új név]"},
    ["givemoney"] = {level = 7, title = "Játékos készpénz egyenlegének növelése", syntax = "[Játékos Név / ID] [Összeg]"},
    ["givepp"] = {level = 7, title = "Játékos Prémium Pont egyenlegének megnövelése", syntax = "[Játékos Név / ID] [Összeg]"},
    ["setpp"] = {level = 7, title = "Játékos Prémium Pont egyenlegének beállítása", syntax = "[Játékos Név / ID] [Összeg]"},
    ["takepp"] = {level = 7, title = "Játékos Prémium Pont egyenlegének beállítása", syntax = "[Játékos Név / ID] [Összeg]"},
    ["takemoney"] = {level = 6, title = "Játékos készpénz egyenlegének csökkentése", syntax = "[Játékos Név / ID] [Összeg]"},
    ["freeze"] = {level = 1, title = "Játékos lefagyasztása", syntax = "[Játékos Név / ID]"},
    ["togalog"] = {level = 1, title = "AdminNapló ki/ -bekapcsolása", syntax = ""},
    ["giveopp"] = {level = 7, title = "Játékos offline Prémium Pont egyenlegének megnövelése", syntax = "[Accont ID] [Mennyiség]"},
    ["setguardlevel"] = {level = 9, title = "Játékos RP Őr szintjének módosítása", syntax = "[Játékos Név / ID] [Szint < 0 - 4 >]"},
    ["getip"] = {level = 7, title = "Játékos IP címének lekérdezése", syntax = "[Játékos Név / ID]"},
    ["getaccid"] = {level = 1, title = "Játékos KarakterID lekérdezése", syntax = "[Játékos Név / ID]"},
    ["getserial"] = {level = 8, title = "Játékos serial lekérése", syntax = "[Játékos Név / ID]"},
    ["setbankmoney"] = {level = 7, title = "Játékos banki egyenlegének beállítása", syntax = "[Játékos Név / ID] [Összeg]"},
    ["setmoney"] = {level = 7, title = "Játékos készpénz egyenlegének beállítása", syntax = "[Játékos Név / ID] [Összeg]"},
    ["setplayedtime"] = {level = 11, title = "Játékos játszott idejének beállítása", syntax = "[Játékos Név / ID] [Perc]"},
    ["sethunger"] = {level = 1, title = "Játékos éhség szintjének beállítása", syntax = "[Játékos Név / ID] [Éhség < 0 - 100 >]"},
    ["setthirst"] = {level = 1, title = "Játékos szomjúság szintjének beállítása", syntax = "[Játékos Név / ID] [Szomjúság < 0 - 100 >]"},
    ["adutyba"] = {level = 7, title = "Adminisztrátor szolgálatba állítása", syntax = "[Játékos Név / ID]"},
    ["setserverpassword"] = {level = 11, title = "Szerver jelszavának beállítása", syntax = "[Jelszó]"},
    ["removeserverpassword"] = {level = 11, title = "Szerver jelszavának törlése", syntax = ""},
    ["asegit"] = {level = 1, title = "Játékos felsegítése", syntax = "[Játékos Név / ID] [silent=1]"},
    ["agyogyit"] = {level = 1, title = "Játékos gyógyítása", syntax = "[Játékos Név / ID] [silent=1]"},
    ["setdim"] = {level = 1, title = "Játékos dimenziójának beállítása", syntax = "[Játékos Név / ID] [Dimenzió]"},
    ["setint"] = {level = 1, title = "Játékos interiorjának beállítása", syntax = "[Játékos Név / ID] [Interior]"},
    ["ban"] = {level = 2, title = "Játékos kitíltása", syntax = "[Játékos Név / ID] [Óra < 0 = örök >] [Indok]"},
    ["oban"] = {level = 2, title = "Játékos offline kitíltása", syntax = "[Játékos Név pl. (John_Doe)] [Óra < 0 = örök >] [Indok]"},
    ["unban"] = {level = 2, title = "Játékos kitiltásának feloldása", syntax = "[Serial] [Indok]"},
    ["stats"] = {level = 1, title = "Játékos adatainak lekérése", syntax = "[Játékos Név / ID]"},
    ["getradio"] = {level = 2, title = "Játékos rádió csatorjáinak lekérése", syntax = "[Játékos Név / ID]"},
    ["getradiomembers"] = {level = 5, title = "Frekvencián tartózkodó játékosok kilistázása", syntax = "[Frekvencia]"},
    ["gotoatm"] = {level = 6, title = "ATM-hez teleportálás", syntax = "[ATM ID]"},
    ["getphoneowner"] = {level = 4, title = "Telefon tulajdonosa telefonszám alapján", syntax = "[Telefonszám (pl. 3873294576)]"},
    ["avariant"] = {level = 7, title = "Variáns felszerelése járműre", syntax = "[Játékos Név / ID] [Variáns (0 - 255)]"},
    ["setAbs"] = {level = 6, title = "ABS állítása járműben", syntax = "[Játékos Név / ID] [ABS (0 - 3)]"},
    ["bizonylat"] = {level = 6, title = "Fegyverbizonylat útólagos kiállítása", syntax = "[Játékos Név / ID] [Fegyver item ID] [Sorozatszám (csak szám)] [Vételár]"},

    ["getinteriorpeds"] = {level = 7, title = "Interiorban lévő pedek kilistázása", syntax = ""},
    ["gotoped"] = {level = 7, title = "PED-hez teleportálás ID alapján", syntax = "[Ped ID]"},
    ["moveped"] = {level = 7, title = "PED mozgatása a saját koordinátáidhoz", syntax = "[Ped ID]"},
    ["rotateped"] = {level = 7, title = "PED forgatása a saját koordinátáid alapján", syntax = "[Ped ID]"},
    ["deleteped"] = {level = 7, title = "PED törlése ID alapján", syntax = "[Ped ID]"},

    ["getlawduty"] = {level = 7, title = "Szolgálatban lévő rendvédelmi tagok száma", syntax = ""},

    ["changelock2gate"] = {level = 6, title = "Kulcs másolás gate kapuhoz", syntax = "[Gate ID]"},
    ["gotogate"] = {level = 5, title = "Gate kapuhoz teleportálás ID alapján", syntax = "[Gate ID]"},

    ["anamesstate"] = {level = 7, title = "Adminisztrátori nevek használatának megtekintése", syntax = "[Játékos Név / ID]"},
    ["eco"] = {level = 5, title = "Játékos pénzügyeinek lekérése", syntax = "[Játékos Név / ID]"},
    ["kick"] = {level = 1, title = "Játékos kirugása", syntax = "[Játékos Név / ID] [Indok]"},
    ["gotopos"] = {level = 1, title = "Pozicióhoz teleportálás", syntax = "[X] [Y] [Z]"},
    ["rtc2"] = {level = 1, title = "Jármű visszaállítása", syntax = "[Távolság (Méter)]"},
    ["setpaintedtime"] = {level = 6, title = "Arcfestés idejének módosítása", syntax = "[Játékos Név / ID] [Idő (perc)]"},
    ["abekot"] = {level = 1, title = "Játékos biztonsági övének bekötése", syntax = "[Játékos Név / ID]"},
    ["akiszed"] = {level = 1, title = "Játékos kiszedése járműből", syntax = "[Játékos Név / ID]"},
    ["acuff"] = {level = 1, title = "Játékos megbilincselése", syntax = "[Játékos Név / ID]"},
    ["pm"] = {level = 1, title = "Privát üzenet küldése játékosnak", syntax = "[Játékos Név / ID] [Üzenet]"},
    ["getvehowner"] = {level = 5, title = "Autó tulajdonosának lekérdezése", syntax = "[Autó ID]"},
    ["changelock2"] = {level = 6, title = "Autóhoz kulcsmásolás", syntax = ""},
    ["connectdiscord"] = {level = 8, title = "Discord - SightMTA fiókok manuális összekötése", syntax = "[Account ID] [Discord ID] [Discord Név]"},
    ["setvehicleowner"] = {level = 7, title = "Autó tulajdonosának módosítása", syntax = "[Játékos Név /ID] [Autó ID]"},
--
    ["gotoveh"] = {level = 1, title = "Autóhoz teleportálás", syntax = "[Jármű azonosító]"},
    ["getveh"] = {level = 1, title = "Autó magadhoz teleportálása", syntax = "[Jármű azonosító]"},
    ["fixveh"] = {level = 1, title = "Autó megszerelése", syntax = "[Szerelési típus] [Játékos Név / ID]"},
    ["startveh"] = {level = 6, title = "Autó beindítása", syntax = "[Játékos Név / ID]"},
    ["blowveh"] = {level = 8, title = "Jármű felrobbantása", syntax = "[Jármű ID]"},
    ["respawnveh"] = {level = 1, title = "Jármű visszaállítása", syntax = "[Jármű ID]"},
    ["setvehcolor"] = {level = 6, title = "Jármű színének módosítása", syntax = "[Játékos Név / ID] [HEX SZÍN]"},
    ["oilveh"] = {level = 1, title = "Jármű motorolajának cseréje", syntax = "[Játékos Név / ID]"},
    ["setvehhp"] = {level = 1, title = "Jármű életerejének módosítása", syntax = "[Játékos Név / ID] [32-100%]"},
    ["setvehfuel"] = {level = 1, title = "Jármű üzemanyagszintjének módosítása", syntax = "[Játékos Név / ID] [Fuel 1-100%]"},
    ["getvehfuel"] = {level = 1, title = "Jármű üzemanyagszintjének lekérése", syntax = "[Játékos Név / ID]"},
    ["unflip"] = {level = 1, title = "Jármű visszaforgátasa", syntax = "[Játékos Név / ID]"},
    ["amuszaki"] = {level = 6, title = "Jármű műszakiztatása", syntax = "[Jármű ID]"},
    ["removeplate"] = {level = 6, title = "Egyedi rendszám eltávolítása", syntax = ""},
    ["setvehicleplate"] = {level = 6, title = "Egyedi rendszám felszerelése", syntax = "[Rendszám]"},
    ["beszall"] = {level = 7, title = "Legközelebbi járműbe beülés", syntax = ""},
    ["nitrolevel"] = {level = 7, title = "Jármű feltöltése nitróval", syntax = "[Jármű ID] [Típus (1 - Sima, 2 - Prémium)] [Nitró Szint (1 - 4)]"},
--Animals
    ["nearbypets"] = {level = 6, title = "Közeledben lévő PET-ek", syntax = ""},
    ["renamepet"] = {level = 6, title = "PET átnevezése", syntax = "[Pet ID] [Név]"},
--Bank
    ["createatm"] = {level = 8, title = "ATM Létrehozása (restartig)", syntax = ""},
    ["nearbyatms"] = {level = 6, title = "Közeledben lévő ATM-ek kilistázása", syntax = ""},
--Carry
    ["budspencer"] = {level = 7, title = "Bud Spencer mód", syntax = ""},
    ["carcarry"] = {level = 7, title = "Közeledben lévő autó felemelése", syntax = ""},
--Clothesshop
    ["setarmor"] = {level = 1, title = "Armor addolása játékosnak", syntax = "[Játékos Név / ID] [Armor type (1-5) (5 PD többi civil)]"},
--Core
    ["setosveny"] = {level = 11, title = "Connect szerver megnyitása", syntax = "[Lezárás indoka (Engedélyezés = gyertek)]"},
    ["setjobmultiplier"] = {level = 11, title = "Munkaszorzó állítás", syntax = "[Munka ID] [Szorzó (max 5x)]"},
    ["getjobmultiplier"] = {level = 11, title = "Munkaszorzó lekérdezése", syntax = "TBD"},
    ["resetallmultiplier"] = {level = 11, title = "Munkaszorzó visszaállítása", syntax = "TBD"},
--CustomPJ
    ["delpj"] = {level = 6, title = "Egyedi paintjob törlése", syntax = ""},
--Dashboard
    ["addinteriorlimit"] = {level = 7, title = "Interior limit növelése", syntax = "[Játékos Név / ID] [Mennyiség]"},
    ["setinteriorlimit"] = {level = 7, title = "Interior limit beállítása", syntax = "[Játékos Név / ID] [Mennyiség]"},

    ["giveachievenment"] = {level = 11, title = "Achievenment adása játékosnak", syntax = "TBD"},
    ["changeinvitecode"] = {level = 11, title = "Játékos meghívókódjának megváltoztatása", syntax = "[Játékos Név / ID] [Invite kód (min. 3, max 6)]"},
    ["resetinvitecode"] = {level = 11, title = "Játékos meghívókódjának visszaállítása", syntax = "[Játékos Név / ID]"},

    ["addvehlimit"] = {level = 7, title = "Jármű limit növelése", syntax = "[Játékos Név / ID] [Mennyiség]"},
    ["setvehlimit"] = {level = 7, title = "Jármű limit beállítása", syntax = "[Játékos Név / ID] [Mennyiség]"},
--Dice
    ["dicemaffia"] = {level = 8, title = "Dice gép szimbólum beállítása", syntax = "[Szám (1-10ig)]"},
--Drugs
    ["setdose"] = {level = 5, title = "Játékos drogszintjének módosítása", syntax = "[Játékos Név / ID] [Típus (shroom, lsd, weed, coke, para, speed, ex)] [Dózis (0 - 100)]"},
--Gates
    ["gotogate"] = {level = 5, title = "Gatehez teleportálás", syntax = "[Gate ID]"},
--Graffiti
    ["ginfo"] = {level = 1, title = "Graffiti információk", syntax = ""},
--Groups
    ["grouplist"] = {level = 6, title = "Szerveren található frakciók listája (konzolba)", syntax = ""},
    ["setvehiclegroup"] = {level = 6, title = "Jármű frakcióra helyezése/eltávolítása", syntax = "[Jármű ID] [Frakció (0 - Levétel)]"},
    ["groupmonetary"] = {level = 7, title = "Frakció pénzügyek kezelése", syntax = ""},
    ["addplayergroup"] = {level = 6, title = "Játékos felvétele frakcióba", syntax = "[Játékos Név / ID] [Frakció]"},
    ["removeplayergroup"] = {level = 6, title = "Játékos kirúgása frakcióból", syntax = "[Játékos Név / ID] [Frakció]"},
    ["setplayerleader"] = {level = 6, title = "Játékos frakció leaderré tétele", syntax = "[Játékos Név / ID] [Frakció] [0 - Elvétel | 1 - Adás]"},
    ["alnev"] = {level = 6, title = "Álnév", syntax = "[Név (6-24 kar.)]"},
--Inventory
    ["itemlist"] = {level = 6, title = "Szerveren megtalálható tárgyak listája", syntax = ""},
    ["giveitem"] = {level = 6, title = "Tárgy lekérése", syntax = "[Játékos Név / ID] [Item ID] [Mennyiség] [ < Data 1 | Data 2 | Data 3 > ]"},
    ["seeinv"] = {level = 1, title = "Játékos inventoryjának megtekintése", syntax = "[Játékos Név / ID]"},
    ["clearinv"] = {level = 7, title = "Játékos inventoryjának törlése", syntax = "[Játékos Név / ID]"},
    ["addweaponwarn"] = {level = 2, title = "Fegyver figyelmeztetés kiosztása", syntax = "[Sorozatszám]"},
--
    ["nearbysafes"] = {level = 5, title = "Közeledben lévő széfek megtekintése", syntax = ""},
    ["createsafe"] = {level = 7, title = "Széf létrehozása", syntax = "[groupId (pl: PD) vagy 0] [safeType 1 = kicsi 2 = közepes 3 = nagy]"},
    ["deletesafe"] = {level = 7, title = "Széf törlése", syntax = "[ID]"},
    ["changelock2safe"] = {level = 6, title = "Széf kulcs másolása", syntax = "[ID]"},
    ["movesafe"] = {level = 5, title = "Széf mozgatása saját koordinátáid alapján", syntax = "[ID]"},
    ["gotosafe"] = {level = 5, title = "Széfhez teleportálás", syntax = "[ID]"},
    ["rotatesafe"] = {level = 5, title = "Széf forgatása saját koordinátáid alapján", syntax = "[ID]"},
    ["setsafegroup"] = {level = 6, title = "Széf frakcióhoz kötése", syntax = "[ID]"},
--
    ["nearbytrashes"] = {level = 6, title = "Közeledben lévő kukák listázása", syntax = ""},
    ["createtrash"] = {level = 6, title = "Kuka létrehozása", syntax = "[modellID]"},
    ["deletetrash"] = {level = 6, title = "Kuka törlése", syntax = "[Azonosító]"},
--Jail
    ["ajail"] = {level = 1, title = "Játékos börtönbe helyezése", syntax = "[Játékos Név / ID] [Időtartam] [Típus (1: Normál, 2: Válaszolós, 3: Írós)] [Indok]"},
    ["offajail"] = {level = 2, title = "Játékos börtönbe helyezése", syntax = "[Játékos Név / Account ID] [Időtartam] [Típus (1: Normál, 2: Válaszolós, 3: Írós)] [Indok]"},
    ["unjail"] = {level = 1, title = "Játékos kivétele börtönből", syntax = "[Játékos Név / ID]"},
    ["jailed"] = {level = 1, title = "AdminJailben lévő játékosok listája", syntax = ""},
--Job_raktar
    ["getjobvehicle"] = {level = 1, title = "MiguTrans munkajármű teleportálása", syntax = "[Jármű azonosító]"},
    ["gotojobvehicle"] = {level = 1, title = "MiguTrans munkajárműhöz teleportálás", syntax = "[Jármű azonosító]"},
    ["deljobvehicle"] = {level = 1, title = "MiguTrans munkajármű törlése", syntax = "[Jármű azonosító]"},
    ["getjobvehof"] = {level = 1, title = "MiguTrans munkajármű tulajdonosának lekérése", syntax = "[Jármű azonosító]"},
--Maps
    ["nearbymaps"] = {level = 6, title = "Közeledben lévő mappolások", syntax = ""},
    ["nearbyobjects"] = {level = 6, title = "Közeledben lévő objectek", syntax = ""},
    ["melyikmap"] = {level = 6, title = "Általad éríntett mappolás neve", syntax = ""},
    ["markobjects"] = {level = 8, title = "Objectek megjelölése", syntax = "[objectID]"},
    ["mapeditor"] = {level = 7, title = "MapEditor", syntax = "TBD"},
--MDC
    ["asiren"] = {level = 7, title = "Szirénahíd, villogó felszerelése rendvédelemnek", syntax = "[Sziréna típusa]"},
    ["asiren1"] = {level = 7, title = "Tollfelvásárló", syntax = ""},
    ["asiren2"] = {level = 7, title = "Family Frost", syntax = ""},
--Misc
    ["ostor"] = {level = 8, title = "Népnevelő eszköz", syntax = ""},
--Mobile
    ["delnionmessage"] = {level = 1, title = "SightNion üzenet törlése", syntax = "[Üzenet ID]"},
    ["anoid"] = {level = 1, title = "SightNion felhasználó ID alapján Név / Account ID lekérése", syntax = "[Ano ID]"},
--Modloader
    ["reloadmodel"] = {level = 11, title = "Modell újratöltése kliensnek", syntax = "[Modell ID]"},
--Names
    ["anames"] = {level = 1, title = "Adminisztrátori nevek", syntax = ""},
--Paintjob
    ["apaintjob"] = {level = 6, title = "Paintjob felfestése (frakciós)", syntax = "[Jármű ID] [Paintjob ID]"},
    ["aheadlight"] = {level = 6, title = "Lámpa PJ felfestése", syntax = "[Jármű ID] [Headlight ID]"},
    ["awheeltext"] = {level = 6, title = "Kerék PJ felfestése", syntax = "[Jármű ID] [KerékPJ ID]"},
--Paintshop
    ["fillMix"] = {level = 6, title = "MiguItalia keverőgép megtöltése", syntax = "[műhelyID]"},
    --forcereply,forceto,forceoffer -> ezek jók csak admin exportot tegyél bele
--Pavilion
    ["pavilionradio"] = {level = 7, title = "Pavilion rádió kezelése", syntax = "[Rádió azonosító (0 - 48)]"},
    ["fishradio"] = {level = 7, title = "Palominó rádió kezelése", syntax = "[Rádió azonosító (0 - 48)]"},
    ["clubradio"] = {level = 7, title = "Alhambra rádió kezelése", syntax = "[Rádió azonosító (0 - 48)]"},
--Peds
    ["nearbypeds"] = {level = 7, title = "Közeledben lévő Bolt PED-ek", syntax = ""},
    ["createped"] = {level = 7, title = "Bolt PED létrehozása", syntax = ""},
    ["pedwp"] = {level = 8, title = "Bolt PED nagykereskedelmi árak igazítása", syntax = ""},
    ["editped"] = {level = 8, title = "Bolt PED szerkesztése", syntax = "[ID]"},
--Police
    ["nearbyspikes"] = {level = 1, title = "Közeledben lévő spike-ok", syntax = ""},
    ["delspike"] = {level = 1, title = "Spike törlése", syntax = "[ID]"},
    ["nearbyrbs"] = {level = 1, title = "Közeledben lévő útzárak listája", syntax = ""},
--Radar
    ["showplayers"] = {level = 6, title = "Játékosok mutatása térképen (F11)", syntax = ""},
--Reports
    ["reports"] = {level = 1, title = "Report panel megnyitása", syntax = ""},
--Ring
    ["ringlayout"] = {level = 7, title = "SightRing vonalvezetés módosítása", syntax = "[1 - 4]"},
--Roulette
    ["rulettemaffia"] = {level = 8, title = "Roulette kerék nyerőszám beállítása", syntax = "[1 - 36]"},
--Studentdriver
    ["givekresz"] = {level = 6, title = "Kresz vizsga adása játékosnak", syntax = "[Játékos Név / ID]"},
    ["givejogsi"] = {level = 6, title = "Jogosítvány adása játékosnak", syntax = "[Játékos Név / ID]"},
--Tuning
    ["atuning"] = {level = 6, title = "Tuningműhelybe belépés bárhonnan", syntax = ""},
--Vehicles
    ["nearbyvehicles"] = {level = 1, title = "Közeledben lévő járművek", syntax = ""},
    ["loadbestecu"] = {level = 7, title = "Optimális ECU beállítás betöltése", syntax = ""},
    ["makeveh"] = {level = 6, title = "Jármű létrehozása", syntax = "[Név / ID] [Model ID] [Frakció ID] [Szín 1] [Szín 2] [Szín 3]"},
    ["delveh"] = {level = 6, title = "Jármű kitörlése", syntax = "[Jármű ID]"},
    ["setfueltype"] = {level = 7, title = "Jármű üzemanyag típúsának módosítása", syntax = "[Autó azonosítója] [Típus (1 - Dízel, 2 - Benzines)]"},
--Voice
    ["givevoice"] = {level = 1, title = "Játékosnak VoiceChat jog adás", syntax = "[Játékos Név / ID]"},
    ["takevoice"] = {level = 1, title = "Játékostól VoiceChat jog megvonása", syntax = "[Játékos Név / ID]"},
--Vpanel
    ["vpanel"] = {level = 7, title = "Venom panel kezelése", syntax = ""},
--Weather
    ["settime"] = {level = 8, title = "Szerver idő kezelése", syntax = "[* = Aktuális idő / Idó (Órában)]"},
    ["setweather"] = {level = 8, title = "Szerver időjárás kezelése", syntax = "[Weather ID (0 - 255) alap: 2]"},
--Whitelist
    ["addwhitelist"] = {level = 11, title = "Whitelist listához adás", syntax = "[Serial] [Név]"},
    ["removewhitelist"] = {level = 11, title = "Whitelist listáról levétel", syntax = "[Serial]"},
--Workaround
    ["gototrailer"] = {level = 1, title = "Utánfutóhoz teleportálás", syntax = "[Utánfutó Azonosító]"},
    ["gettrailer"] = {level = 1, title = "Utánfutóhoz magadhoz teleportálása", syntax = "[Utánfutó Azonosító]"},
    ["createtrailer"] = {level = 3, title = "Utánfutó létrehozása", syntax = "[Utánfutó típus [1 / 2]]"},
    ["deletetrailer"] = {level = 3, title = "Utánfutó kitörlése", syntax = "[Utánfutó Azonosító]"},
    ["nearbytrailers"] = {level = 1, title = "Közeledben lévő utánfutók listája", syntax = ""},
}

addEventHandler("onElementDataChange", root, function(elementData, oldValue, newValue)
    if getElementType(source) == "player" then
        if elementData == "loggedIn" and newValue then
            if getElementData(source, "acc.adminLevel") >= 1 then
                triggerClientEvent(source, "gotAdminhelpCommands", source, commandTable)
            end
        end
    end

    if elementData == "acc.adminLevel" and newValue >= 1 then
        triggerClientEvent(source, "gotAdminhelpCommands", source, commandTable)
    end
end)

addEventHandler("onResourceStart", resourceRoot, function()
    setTimer(function()
        for _, playerElement in pairs(getElementsByType("player")) do
            if getElementData(playerElement, "acc.adminLevel") >= 1 then
                triggerClientEvent(playerElement, "gotAdminhelpCommands", playerElement, commandTable)
            end
        end
    end, 500, 1)
end)