local sightexports = {
  sItems = false,
  sGui = false,
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
wantedItems = {
  {
    17,
    1,
    10,
    8000,
    16000,
    1.2,
    "drug"
  },
  {
    18,
    1,
    10,
    8000,
    16000,
    1.25,
    "drug"
  },
  {
    65,
    1,
    20,
    4000,
    8000,
    1.7,
    "drug"
  },
  {
    233,
    1,
    10,
    5000,
    10000,
    1.3,
    "drug"
  },
  {
    444,
    1,
    15,
    5000,
    10000,
    1.45,
    "drug"
  },
  {
    445,
    1,
    10,
    5000,
    10000,
    1.35,
    "drug"
  },
  {
    431,
    1,
    15,
    4000,
    8000,
    1.6,
    "drug"
  },
  {
    531,
    30,
    300,
    1500,
    2800,
    1.5,
    "ammo"
  },
  {
    534,
    50,
    500,
    125,
    150,
    1.9,
    "ammo"
  },
  {
    537,
    20,
    290,
    1800,
    2800,
    1.35,
    "ammo"
  },
  {
    538,
    50,
    500,
    1200,
    2200,
    1.55,
    "ammo"
  },
  {
    539,
    50,
    450,
    1700,
    2700,
    1.6,
    "ammo"
  },
  {
    540,
    20,
    240,
    1800,
    2800,
    1.3,
    "ammo"
  },
  {
    541,
    30,
    350,
    1600,
    2600,
    1.4,
    "ammo"
  },
  {
    542,
    50,
    500,
    125,
    150,
    1.9,
    "ammo"
  },
  {
    70,
    1,
    1,
    20000,
    55000,
    1.9,
    "weapon"
  },
  {
    76,
    1,
    1,
    112500,
    150000,
    1.9,
    "weapon"
  },
  {
    77,
    1,
    1,
    200000,
    300000,
    1.3,
    "weapon"
  },
  {
    78,
    1,
    1,
    150000,
    280000,
    1.2,
    "weapon"
  },
  {
    79,
    1,
    1,
    50000,
    170000,
    1.7,
    "weapon"
  },
  {
    82,
    1,
    1,
    60000,
    200000,
    1.4,
    "weapon"
  },
  {
    83,
    1,
    1,
    150000,
    350000,
    1.3,
    "weapon"
  },
  {
    84,
    1,
    1,
    60000,
    200000,
    1.4,
    "weapon"
  },
  {
    85,
    1,
    1,
    70000,
    250000,
    1.7,
    "weapon"
  },
  {
    86,
    1,
    1,
    100000,
    500000,
    1.3,
    "weapon"
  },
  {
    87,
    1,
    1,
    70000,
    150000,
    1.2,
    "weapon"
  },
  {
    88,
    1,
    1,
    300000,
    1000000,
    1.2,
    "weapon"
  },
  {
    102,
    1,
    1,
    50000,
    120000,
    1.3,
    "weapon"
  },
  {
    493,
    1,
    1,
    112500,
    150000,
    1.9,
    "weapon"
  },
}
itemCategories = {}
for i = 1, #wantedItems, 1 do
  local temp = wantedItems[i]
  itemCategories[temp[1]] = temp[7]
end
adMessages = {
  "Megbízható forrást keresek, [név] kellene, van rá [összeg] zsebben.",
  "Ha van nálad [név], írj. Azonnal viszem, [összeg] a keret.",
  "Csendben intézném, [név] érdekel, fizetek érte [összeg].",
  "Privátban jöhet, [név] kéne sürgősen. Nem alku, [összeg] fix.",
  "Régi kapcsolat eltűnt, most mást keresek. [név] kellene, [összeg] nálam van.",
  "Csak minőség érdekel. [név], nem boltban kapható. [összeg] készpénzben.",
  "Sietős lenne. [név] most kell, van érte [összeg].",
  "Nem kérdezek semmit. [név] érdekel, viszem azonnal. [összeg].",
  "Estére kéne valami komolyabb. [név], [összeg] a keretem.",
  "Van valakinek [név]? [összeg] azonnal megy érte.",
  "Nem játszom, csak hozd. [név]. [összeg].",
  "Diszkréten keresek: [név]. [összeg] a zsebemben.",
  "Ma este kéne [név], nem várok sokáig. [összeg] a keret.",
  "Régi forrás megszűnt. [név] sürgősen kellene, [összeg].",
  "Tiszta ügylet, gyors találka. [név] kell, [összeg].",
  "Nincs időm köröket futni. [név], [összeg], most.",
  "Csak egy dolgot keresek: [név]. [összeg] a limit.",
  "Nem vagyok kezdő. [név] kéne, jó pénzért. [összeg].",
  "Gyors, csendes üzlet. [név], [összeg], most.",
  "Megbízható vevő vagyok. [név] érdekel, [összeg] az ajánlat.",
  "A régi már nem játszik. Új arcot keresek. [név], [összeg].",
  "Nem érdekel a sztori, csak [név]. [összeg] az ár.",
  "Üzenj, ha nálad van [név]. Fizetek, [összeg] kézbe.",
  "Komoly szándék. [név] sürgős, van rá [összeg].",
  "Megbízható forrást keresek hosszú távra. Első kör: [név], [összeg].",
  "Sima ügylet érdekel. [név] kellene, nálam van a [összeg].",
  "Csak egy jó kontakt kellene. [név], [összeg], gyorsan.",
  "Tud valaki valamit [név] ügyben? [összeg] a keret.",
  "Akinek van [név], az tudja, hogy mennyit ér. Nálam [összeg].",
  "Régóta keresek ilyet. [név], [összeg], nem alkuszom.",
  "Ha nálad van a jó cucc ([név]), akkor nálam van érte [összeg].",
  "Nem vagyok rendőr. [név] kéne, [összeg] a táskámban.",
  "Privátban írj, ha van [név]. [összeg] a max.",
  "Fix üzletet akarok. [név], azonnal viszem, [összeg].",
  "Nem nyomozok, csak vásárolok. [név] érdekel, [összeg].",
  "Ma este kéne még egy kör. [név], [összeg], sürgősen.",
  "Kis mennyiség, nagy megbecsülés. [név], [összeg].",
  "Megbízhatóságért fizetek. [név] kell, [összeg] jár érte.",
  "Komoly ajánlat: [név], azonnal, [összeg].",
}
warnMessages = {
  drug = {
    "Csak bontatlan érdekel, ne hozz maradékot.",
    "Ha egyszer is nyúltak hozzá, nem kell.",
    "Csak tiszta, érintetlen cucc jöhet szóba.",
    "Nem veszek olyat, amit már más is nézegetett.",
    "Friss legyen, zárt, különben elfelejtheted.",
    "Bontottat ne is próbálj hozni.",
    "Tökéletes állapotban kérem. Ha piszkálták, bukó.",
    "Csak első kézből, nem kérek újracsomagoltat.",
    "Ha már megvolt valakinél, nem érdekel.",
    "Ne hozz semmit, ami nem eredeti állapotban van.",
    "Érintetlen legyen, ennyi a feltétel.",
    "Ami nem gyári, megy vissza.",
    "Tiszta csomag kell. Ha szétnyitották, nem fizetek.",
    "Ne gyere használttal. Komolyan mondom.",
    "Kizárólag bontatlan, máshoz nem nyúlok.",
    "Ne trükközz, meglátom, ha nem új.",
    "Csak az jöhet, amit senki nem piszkált.",
    "Nem kockáztatok bontottal, szóval ne is próbáld.",
    "Kézhez kapott állapotban várom.",
    "Olyan legyen, amire még nem tettek ujjat.",
    "Ha egyszer is kibontották, már nem kell.",
    "Tiszta forrás, bontatlan csomag – csak ez számít.",
    "Ha van benne ujjlenyomat, bukod az üzletet.",
    "Semmi újracsomagolt, csak eredeti.",
    "Ne gyere használttal, nem vagyok idióta.",
    "Friss, érintetlen – más nem érdekel.",
    "Amit más már piszkált, az nálam kuka.",
    "Ne hozz visszazártat, csak gyárit kérek.",
    "Szűz legyen a csomag. Nem alku tárgya.",
    "Első kéz, gyári csomagolás. Különben felejtsd el."
  },
  weapon = {
    "Az ár a hibátlan állapotra vonatkozik. Minden kopás levonás.",
    "Csak tökéletes állapotban kapod meg a teljes összeget.",
    "Ha karcos vagy rozsdás, az mínusz a végösszegből.",
    "Ez az ár új fegyverre szól. Minden hiba pénzbe kerül.",
    "Ne gyere csálé sátorvassal, mert nem fizetem ki rendesen.",
    "A legkisebb hiba is lecsúsztat a teljes árról.",
    "100% állapot = 100% fizetés. Minden más csak részlet.",
    "Ez nem zálogház. Csak patika állapotú vasért fizetek teljesen.",
    "Kopás, horpadás? Ne is próbáld teljes árat kérni.",
    "Az összeg arányos az állapottal. Ne mondd, hogy nem szóltam.",
    "Ez az ajánlat makulátlan darabra szól.",
    "Ha nem 100% a cucc, a pénz sem lesz 100%.",
    "Fizetek – de csak a tökéletesért teljesen.",
    "Minden hiba – százalék mínusz. Így működik.",
    "Ne próbálj rozsdás holmit aranyáron eladni.",
    "Teljes árat csak gyári állapotú vas kap.",
    "Ha nem csúszik úgy, ahogy kell, csúszik az összeg is.",
    "Nem fizetek romokra prémiumot.",
    "Ez nem múzeum, ez üzlet. Csak hibátlan vasért fizetek.",
    "Az alku a minőségre vonatkozik. Gyengébb? Kevesebb.",
    "Az ajánlat csak makulátlan darabra él.",
    "Állapottól függ az ár, nem a történettől.",
    "Ne mesélj, mutasd meg. És majd látjuk, mit ér.",
    "Ránézek, és ha nem csillog, csökken a díj.",
    "Nem alkuszom, csak levonok. Állapot szerint.",
    "Ez az összeg nem jár rozsdának.",
    "Használtnál ne várj újat. Árban sem.",
    "Ha lötyög vagy kattog, kevesebbet kapsz, ennyi.",
    "Ez nem érzelem, ez érték. És az a cső állapotától függ.",
    "Csak egyben és hibátlanul éri meg – neked is, nekem is."
  },
}
responseMessages = {
  "Megoldható, hozom, maradjon nálad a [összeg].",
  "Csendben megy a dolog. A [név] nálam van, találkozunk.",
  "Oké, indulok. [név] nálam, készítsd elő az összeget.",
  "Nem kérdezek, csak hozom. [név], ahogy kérted.",
  "[név] úton van, nálad ott legyen a suska.",
  "Rendben, intézve.",
  "Ez a tétel tiszta. [név], ahogy szeretted volna. Indulok.",
  "Találka fix, [név] nálam. Te meg hozd a pénzt.",
  "Nem lesz gond. [név] nálam, intézzük el gyorsan.",
  "Sok ilyet vittem már. [név] lesz, ne aggódj. Csak legyen nálad a pénz: [összeg].",
  "Okés. Csendben, gyorsan. [név] megy, ahogy mondtad.",
  "Leszállítom. Nem most kezdtem. [név], [összeg], sima ügy.",
  "Rendben, elhozom a csomagot. [név], ne feledd: [összeg] kézbe.",
  "Lefutjuk. [név], [összeg], és nincs több szó.",
  "Hozom. Jó cucc, nem fogsz csalódni. [összeg] rendben lesz, ugye?",
  "Nem kell több üzenet. [név] már nálam van, találkozzunk.",
  "Rendezzük, ahogy szoktuk.",
  "Megoldva. A többit tudod.",
  "Ismered a szabályokat. Nincs kérdés.",
  "A szokásos módon zajlik.",
  "Nincs akadály. Már mozgásban van.",
  "Előbb jön, mint gondolnád.",
  "A dolog már úton van.",
  "Csak maradj csendben. A többi jön.",
  "Ne kérdezz, csak legyél készen.",
  "[összeg]? Ennyiért elintézhető.",
  "A cucc ([név]) rendben lesz. Készítsd a suskát.",
  "Nem most kezdtem. [név], [összeg] – sima ügy.",
  "Láttam mit kérsz. [név] megy, ha ott lesz [összeg].",
  "[név] nem gond, a [összeg] viszont ne legyen vicc.",
  "Nem kérdezek, csak hozom. [név], [összeg].",
  "Ennyiért ([összeg]) [név] ritkán jön szembe."
}
buyerResponseMessages = {
  "Koordináta ment, legyél ott [meddig]-ig.",
  "Küldtem a helyet, [meddig] a határ.",
  "Ne késs, [meddig]-ra legyél ott. Cím küldve.",
  "GPS szerint menni fog. [meddig]-re várlak.",
  "Koordináta ment, [meddig] a végső idő.",
  "A pontot átdobtam. [meddig]-ig zárjuk le.",
  "Nem szeretek várni. [meddig]-ra ott kell lenned.",
  "Csekkold az üzenetet. [meddig] a limit.",
  "Térkép ment, [meddig]-ig várok, tovább nem.",
  "Célpont küldve. [meddig] után ne is gyere.",
  "Megvan a hely, [meddig] előtt legyél ott.",
  "Helyszín megosztva. [meddig], és nincs több esély.",
  "Koordináta kint van. [meddig] a maximum.",
  "Ne bohóckodj. [meddig]-ig ott akarlak látni.",
  "Látod a pontot? [meddig] a zárás.",
  "Átdobtam a helyet. [meddig], és ennyi volt.",
  "Itt a lokáció. [meddig] a vége.",
  "Elküldtem, [meddig]-ig gyere, vagy bukod.",
  "A hely stimmel, [meddig] előtt oldjuk meg.",
  "GPS már nálad, [meddig] után nincs alku.",
  "Koordináta küldve, legyél ott [meddig]-ig.",
  "A helyszínt megkaptad, [meddig]-ig várok.",
  "A pont aktív, de csak [meddig]-ig.",
  "GPS ment, [meddig]-ig intézzük el.",
  "Térkép rendben, de [meddig]-ig legyen meg.",
  "A címet megkaptad, [meddig]-ig találkozunk.",
  "A hely él, de csak [meddig]-ig tartom.",
  "Ne késlekedj, [meddig]-ig várok max.",
  "Helyszín küldve, érkezz [meddig]-ig.",
  "Nem húzom sokáig, [meddig]-ig van időd.",
  "A pont nyitva [meddig]-ig, utána zárva.",
  "Koordináta ment, de [meddig]-ig kell ott lenned.",
  "Ha nem jössz [meddig]-ig, vége.",
  "Ne keress később, [meddig]-ig van lehetőség.",
  "A helyszín nem vár tovább, csak [meddig]-ig.",
  "Minden tiszta [meddig]-ig, utána ne gyere.",
  "Nálam a suska, de csak [meddig]-ig.",
  "Nálam a pénz, de csak [meddig]-ig.",
}
welcomeMessages = {
  "Te vagy az? Jól van, gyere közelebb.",
  "Na, végre megérkeztél.",
  "Na, mutasd, mit hoztál.",
  "Pont rád vártam.",
  "Nézlek egy ideje. Most már beszélhetünk.",
  "Azt hittem, nem jössz el.",
  "Remélem, nem jöttél üres kézzel.",
  "Látom, nem ma kezdted.",
  "Tartsd lent a hangod, itt nem szokás kiabálni.",
  "Ez a környék nem a barátkozásról szól.",
  "Nem nézel ki veszélyesnek. De majd kiderül.",
  "Csak te vagy? Jó. Nem szeretem a meglepetéseket.",
  "Kíváncsi vagyok, mennyire lehet rád számítani.",
  "Szóval tényleg eljöttél. Azt hittem, csak duma volt.",
  "A cipőd hangosabb, mint kéne. Legközelebb figyelj.",
  "Ha hoztad, amit kell, nem lesz gond.",
  "Ha bajt hoztál, akkor most fordulj vissza.",
  "Nem sokan mernek idáig eljönni.",
  "Kezdhetjük, vagy csak nézelődni jöttél?",
  "Nálam nincs felesleges kör. Beszélünk, vagy mész.",
  "Ne húzzuk az időt. Térjünk a lényegre.",
  "Te írtál a hirdetésre, ugye?",
  "Hirdetés miatt jöttél? Akkor beszélhetünk.",
  "Te vagy az, aki a cucc miatt keresett?",
  "Nézd, nem barátkozni vagyunk itt.",
  "Amit írtál, az egy dolog. Amit hozol, az számít.",
  "Ha valódi vagy, nincs gond. Ha nem, akkor baj lesz.",
  "Ha nem a dolog miatt jöttél, akkor most menj el.",
  "Te válaszoltál az üzenetre, igaz?",
  "Hirdetésre jöttél? Akkor ne kavarj.",
  "Én csak nyitottam egy ajtót. A többit te hozod.",
  "Ne nézz körbe ennyit. Itt nincs kirakat.",
  "Nem szokásom kimenni idegenekhez. Remélem, megéri.",
  "Szóval csak egy név nélküli profil vagy. Lássuk.",
  "A szöveged alapján többet vártam. Ne okozz csalódást.",
  "Ez nem az a hely, ahol sokáig időzünk.",
  "Ha csak kíváncsiskodsz, rossz helyen kopogtál.",
  "A neten könnyű dumálni. Most mutasd, mit tudsz élőben.",
  "Nem hoztál mást, ugye? Egyedül jöttél?",
  "Ha játszol velem, rossz játék lesz belőle.",
  "Ez a beszélgetés rövid lesz, ha mellébeszélsz.",
  "Sokan írnak. Kevesen mernek eljönni. Te eljöttél.",
}
failResponseMessages = {
  "Ez nem [név], ne nézz madárnak.",
  "Ez komoly? Ez nem [név], haver.",
  "Azt mondtam, [név], nem ezt a szemetet.",
  "Ne próbálj átverni. Ez nem [név].",
  "Vidd vissza. Addig nincs üzlet, míg nincs [név].",
  "Ez csak időpazarlás. Hol van [név]?",
  "Ez nem fog menni. Ez nem [név].",
  "Ez valami más. Nem erről volt szó. [név] kell.",
  "Nézd meg még egyszer. Ez nem [név].",
  "Amit hoztál, nem az. [név] kell, nem ez a kacat.",
  "Ez nem lesz jó. Nem ez volt az alku tárgya. [név] kell.",
  "Azt hiszed, nem veszem észre? Ez nem [név].",
  "Ez nem [név], ne nézz hülyének.",
  "Nem erről volt szó, [név] kellett volna.",
  "Hol van pontosan [név]?",
  "Ez biztos nem [név], ne próbálkozz.",
  "Nekem [név] lett volna az alku része.",
  "Mit kezdjek ezzel? [név] hiányzik.",
  "Ez távol áll attól, hogy [név] legyen.",
  "Ez nem úgy néz ki, mint [név].",
  "Ez vicc? [név] kéne, nem ez a vacak.",
  "Nézd meg mit hoztál, ez nem [név].",
  "Addig nem haladunk tovább, amíg nincs nálad [név].",
  "Ez nem üzlet így, amíg nem látom [név].",
  "Valami nem stimmel, ez nem hasonlít [név] kinézetére.",
  "Ha ez [név], akkor én vagyok az elnök.",
  "Ne keverj bele mást, csak hozd ide [név].",
  "Nem kérek magyarázatot, csak [név].",
  "Ami nálad van, az nem [név].",
  "Ez valami más, nem [név].",
  "Akkor beszélhetünk, ha végre elhozod [név].",
  "Ez nem játszik, amíg nincs meg [név].",
  "Bármit is hoztál, az nem [név].",
  "Ne told túl, ez nem hasonlít [név] kinézetére.",
  "Most komolyan, azt hitted ez [név]?",
  "Ez nem az, amit vártam. Hol van [név]?",
  "Amit hoztál, azzal nem tudok mit kezdeni. [név] kéne.",
}
successResponseMessages = {
  "Rendben voltál. Megjegyezlek.",
  "Szép munka. Jöhetsz máskor is.",
  "Na, ez így korrekt volt.",
  "Ezt becsülöm. Pontos voltál.",
  "Megbízható vagy. Kevés ilyen van.",
  "Tartottad magad a szavadhoz. Ritka manapság.",
  "Simán ment. Nem húztad az időm.",
  "Ez így frankó volt. Jövünk még egymásnak.",
  "Okos gyerek vagy. Ügyesebben csináltad, mint sok öreg róka.",
  "Látom, nem először csinálod.",
  "Nem kellett csalódnom. Ez már valami.",
  "Ami jár, az jár. Megkapod a tiszteletet.",
  "Kerek volt, tiszta volt. Így kell ezt.",
  "Nem dumáltál feleslegesen, csak hoztad, amit kellett. Jó ez.",
  "Így kell egy ügyletet lezárni.",
  "Legközelebb nem kérdezek, csak hívlak.",
  "Jó érzésem volt veled kapcsolatban. Bejött.",
  "Tartottad a tempót. Sokan már itt elvéreztek volna.",
  "Ez nem az első, és ne legyen az utolsó se.",
  "Tudod, mit csinálsz. Ez látszik.",
  "Tiszták voltak a lapok. Ez már valami.",
  "Nem volt para. Nem volt felesleges kör. Ez tetszik.",
  "Jó volt veled dolgozni. Kevés ilyet mondok.",
  "Ennyi. Pipa. Kész.",
  "Ügyes voltál, haver. Komolyan mondom.",
  "Ne felejtsd: az ilyen meló után számíthatsz rám.",
  "Nem vártál, nem kérdeztél, csak hoztad. Ez profi szint.",
  "Ez most rendben volt. Legyen így mindig.",
  "Tiszta játék. Ennyit várok el, nem többet.",
  "Rend van. A pénz ment, a cucc stimmelt. Mi kell még?",
  "Látod? Ilyenkor működik a dolog.",
  "Ezért szeretem az ilyen gyors embereket.",
  "Ha ilyen tempóban hozod, hamar híred lesz.",
  "Meglepően gördülékeny volt. Pozitív csalódás.",
  "Nem volt kérdés, csak megoldás. Így jó.",
  "Ügyesebben csináltad, mint pár öreg motoros.",
  "Okos vagy, és tudsz viselkedni. Ez nálam pontot ér.",
  "Ami itt történt, azt elraktam fejben. Jó helyen vagy.",
  "Megtartalak a listámon. Ez nem duma.",
  "Túl vagyunk rajta. És még mosolyogni is tudok. Ez ritka."
}
function formatResponseMessage(r0_2)
  local r1_2 = responseMessages[r0_2.respone]
  if not r0_2.itemName then
    r0_2.itemName = sightexports.sItems:getItemName(r0_2.itemId)
  end
  local text = r1_2 
  text = string.gsub(
      text,
      "%[név%]",
      r0_2.amount .. " db " .. r0_2.itemName 
  )

  text = string.gsub(
      text,
      "%[összeg%]",
      sightexports.sGui:thousandsStepper(r0_2.price) .. " $"
  )

  return text
end
function formatBuyerResponseMessage(r0_3)
  local r1_3 = buyerResponseMessages[r0_3.buyerResponse]
  if not r0_3.itemName then
    r0_3.itemName = sightexports.sItems:getItemName(r0_3.itemId)
  end
  r1_3 = string.gsub(string.gsub(r1_3, "%[név%]", r0_3.amount .. " db " .. r0_3.itemName), "%[összeg%]", sightexports.sGui:thousandsStepper(r0_3.price) .. " $")
  if r0_3.valid then
    local r2_3 = getRealTime(math.floor(((r0_3.started + r0_3.valid) / 300 + 0.5)) * 300)
    r1_3 = string.gsub(r1_3, "%[meddig%]", string.format("%02d:%02d", r2_3.hour, r2_3.minute))
  end
  return r1_3
end
function formatFailResponseMessage(r0_4)
  local r1_4 = failResponseMessages[math.random(1, #failResponseMessages)]
  if not r0_4.itemName then
    r0_4.itemName = sightexports.sItems:getItemName(r0_4.itemId)
  end
  return string.gsub(string.gsub(r1_4, "%[név%]", r0_4.amount .. " db " .. r0_4.itemName), "%[összeg%]", sightexports.sGui:thousandsStepper(r0_4.price) .. " $")
end
