examPrice1 = 1000
examPrice2 = 2000
tasks = {
  {
    task = "Nyisd ki a járművet!",
    description = "Állj a jármű mellé (kék jármű ikon), majd nyomd meg a [K] gombot.",
    markVehicle = true,
    check = function(client, veh)
      return not isVehicleLocked(veh)
    end
  },
  {
    task = "Szállj be a járműbe!",
    description = "Kék jármű ikon a térképen.",
    markVehicle = true,
    check = function(client, veh)
      return getPedOccupiedVehicle(client) == veh and getPedOccupiedVehicleSeat(client) == 0
    end
  },
  {
    task = "Kösd be a biztonsági öved!",
    description = "Ezt az [F5] gombbal teheted meg.",
    check = function(client, veh)
      return getElementData(client, "seatBelt")
    end
  },
  {
    task = "Adj gyújtást a járműre!",
    description = "Nyomd meg a [J] gombot.",
    afterTip = "Gyújtást levenni a [Shift]+[J] kombinációval tudod.",
    check = function(client, veh)
      return getElementData(veh, "vehicle.ignition")
    end
  },
  {
    task = "Indítsd be a motort!",
    description = "Tartsd lenyomva a [J] gombot, amíg a motor be nem indul.",
    afterTip = "Ha a motor nehezen indul, ellenőrizd az akkumulátort és az üzemanyag szintet.",
    check = function(client, veh)
      return getElementData(veh, "vehicle.engine")
    end
  },
  {
    task = "Kapcsold fel a lámpákat!",
    description = "Nyomd meg az [L] gombot.",
    check = function(client, veh)
      return getVehicleOverrideLights(veh) == 2
    end
  },
  {
    task = "Használd a jobb irányjelzőt!",
    description = "Nyomd meg a jobb egérgombot.",
    check = function(client, veh)
      return getElementData(veh, "signalState") == "right"
    end
  },
  {
    task = "Használd a bal irányjelzőt!",
    description = "Nyomd meg a bal egérgombot.",
    check = function(client, veh)
      return getElementData(veh, "signalState") == "left"
    end
  },
  {
    task = "Kapcsold ki az irányjelzőt!",
    description = "Nyomd meg újra a bal egérgombot.",
    check = function(client, veh)
      return not getElementData(veh, "signalState")
    end
  },
  {
    task = "Engedd ki a kéziféket!",
    description = "Nyomd meg a [Space] gombot.",
    check = function(client, veh)
      return not getElementData(veh, "vehicle.handbrake")
    end
  },
  {
    task = "Tedd a sebességváltót D (előremenet) fokozatba!",
    description = "A sebességváltót a [Shift] és [Ctrl] gombokkal tudod kezelni.",
    afterTip = "D fokozatban az autó alapjáratban gurul. Ha üresbe szeretnéd tenni, előbb tartsd lenyomva a féket.",
    check = function(client, veh)
      return getElementData(veh, "vehicle.gear") == "D"
    end
  },
  {
    task = "Vezess el a megadott pontra!",
    description = "Kék jelzés a térképen. [F11]: térkép, ahol dupla kattintással bekapcsolhatod a GPS-t. Tempomat: [C]",
    tip = "Figyelj a sebességedre, a közlekedési lámpákra, arra, hogy ne hagyd el az úttestet, valamint kerüld el a koccanásokat!",
    cityBlip = true,
    check = function(client, veh, playerExam)
      return isElementWithinColShape(veh, playerExam.cityCol)
    end
  },
  {
    task = "Vezess el a megadott pontra!",
    description = "Kék jelzés a térképen. [F11]: térkép, ahol dupla kattintással bekapcsolhatod a GPS-t. Tempomat: [C]",
    tip = "Figyelj a sebességedre, a közlekedési lámpákra, arra, hogy ne hagyd el az úttestet, valamint kerüld el a koccanásokat!",
    countryBlip = true,
    check = function(client, veh, playerExam)
      return isElementWithinColShape(veh, playerExam.countryCol)
    end
  },
  {
    task = "Menj vissza az autósiskolához!",
    description = "Kék jelzés a térképen. [F11]: térkép, ahol dupla kattintással bekapcsolhatod a GPS-t. Tempomat: [C]",
    tip = "Figyelj a sebességedre, a közlekedési lámpákra, arra, hogy ne hagyd el az úttestet, valamint kerüld el a koccanásokat!",
    getBackBlip = true,
    check = function(client, veh, playerExam)
      return isElementWithinColShape(veh, playerExam.getBackCol)
    end
  }
}
getBackPos = {
  1111.6650390625,
  -1740.830078125,
  13.402463912964
}
cityPoses = {
  {
    2733.068359375,
    -1657.447265625,
    13.0703125
  },
  {
    2714.4814453125,
    -1957.84375,
    13.369675636292
  },
  {
    2279.548828125,
    -1732.28125,
    13.3828125
  },
  {
    1961.7822265625,
    -2099.640625,
    13.390205383301
  },
  {
    2116.373046875,
    -2247.9775390625,
    13.3828125
  },
  {
    1739.6767578125,
    -2166.48046875,
    13.486988067627
  },
  {
    484.4423828125,
    -1216.1494140625,
    46.592559814453
  },
  {
    1129.513671875,
    -767.2607421875,
    108.97789001465
  },
  {
    2169.8466796875,
    -1262.42578125,
    23.8203125
  }
}
countryPoses = {
  {
    2186.7158203125,
    42.2724609375,
    26.3359375
  },
  {
    94.1494140625,
    -211.4775390625,
    1.4390659332275
  },
  {
    2444.7626953125,
    41.7900390625,
    26.3359375
  },
  {
    527.0810546875,
    -139.0693359375,
    37.828125
  },
  {
    681.8193359375,
    -562.921875,
    16.1875
  }
}
instructors = {
  {
    name = "Oktató Géza",
    skin = 182,
    vehicle = 458,
    paintjob = 1,
    anim = {
      "COP_AMBIENT",
      "Coplook_think"
    },
    pos = {
      1496.2607421875,
      1309.5029296875,
      1093.2867431641,
      180,
      3,
      78
    }
  },
  {
    name = "Oktató Joci",
    skin = 45,
    vehicle = 561,
    paintjob = 1,
    anim = {"GANGS", "leanIDLE"},
    pos = {
      1502.25,
      1306.4130859375,
      1093.2890625,
      90,
      3,
      78
    }
  },
  {
    name = "Oktató Feri",
    skin = 113,
    vehicle = 550,
    paintjob = 1,
    anim = {
      "COP_AMBIENT",
      "Coplook_loop"
    },
    pos = {
      1499.1884765625,
      1309.50390625,
      1093.2890625,
      180,
      3,
      78
    }
  }
}