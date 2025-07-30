config = {
    name = "SIGHT ANTICHEAT",
    prefix = "sight::",

    last = {
        health = 0,
        armor = 0
    },

    banReasons = {
        ["0x01"] = "Suspicious E-DATA CHANGE",
        ["0x02"] = "Player has been reached event limit",
        ["0x03"] = "Player switched to a illegal weapon",
        ["0x04"] = "Player fired an illegal weapon",
        ["0x05"] = "Illegal function use",
        ["0x06"] = "Illegal health value",
        ["0x07"] = "Illegal armor value",
        ["0x08"] = "ANTI VPN",
        ["0x09"] = "ANTI SERIAL SPOOF",
        ["0x10"] = "ANTI RESOURCE STOP"
    },

    blockedWeapons = {
        [35] = true,
        [36] = true,
        [38] = true
    },

    protectedFunctions = {
        "setElementData",
        "triggerServerEvent",
        "loadstring",
        "addDebugHook",
        "removeDebugHook",
        "setPedOnFire",
        "setPedArmor",
        "addEventHandler",
        "removeEventHandler",
    },

    protectedElementDatas = {
        player = {
            ["acc.adminLevel"] = true,
            ["acc.premiumPoints"] = true,
            ["char.playedMinutes"] = true,
            ["char.name"] = true,
            ["char.ID"] = true,
            ["visibleName"] = true,
            ["badgeData"] = true,
            ["badgeExData"] = true,
            ["char.bankMoney"] = true,
            ["char.slotCoins"] = true,
            ["char.Money"] = true,
            ["char.level"] = true,
            ["acc.helperLevel"] = true,
            ["loggedIn"] = true,
            ["tazed"] = true,
            ["carryingGold"] = true,
        },

        vehicle = {
            ["vehicle.dbID"] = true,
            ["vehicle.Engine"] = true,
            ["vehicle.Turbo"] = true,
            ["vehicle.Ecu"] = true,
            ["vehicle.Transmission"] = true,
            ["vehicle.Suspension"] = true,
            ["vehicle.Brakess"] = true,
            ["vehicle.Tiress"] = true,
            ["vehicle.WeightReduction"] = true,
            ["vehicle.tuning.airRide"] = true
        },

        object = {
            ["breakable"] = true,
        }
    },

    illegalWorldSpecialProperties = {
        ["hovercars"] = true,
        ["aircars"] = true,
        ["extrabunny"] = true,
        ["extrajump"] = true,
        --["randomfoliage"] = false -- // GTA:SA Növényzet
    },

    illegalExplosions = {
        --[1] = true,
        [2] = true,
        [3] = true,
        [4] = true,
        [5] = true,
        [6] = true,
        [7] = true,
        [8] = true,
        [9] = true,
        [10] = true,
        [11] = true,
        [12] = true
    }
}