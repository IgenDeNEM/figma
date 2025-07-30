local discordWebookURL = {
--AntiCheat
    ["anticheat"] =        "https://discord.com/api/webhooks/1359847978558296154/6SjCdFn0yhyUGnse-doOoeS2_RUWdxNng8x4BydeG7r0Zy0Y7xEg71hxthYEJN6f_xep", -- Nem logol
    ["vpnlog"] =           "https://discordapp.com/api/webhooks/1359157811501600978/fdxR60kzzOEK_0jkU2IkXc-W1T2mmyLrtW4cQm-JiR-oC6i7tJ3MttDXWcHs_Ju7W_8f", --DONE
    ["screenshot"] =       "https://discord.com/api/webhooks/1123543295444918333/j6wPeMv4K0Oa-TcyTogueqowsHlYPzaeWmjcXAdicmYzKgfNuxTSpRumaV1_qlqFX2e9", --DONE
    ["resources"] =        "https://discord.com/api/webhooks/1359849649321803960/7M_GoigXQMb5Lr9ZFYKiUBIWK_Jb4bQu7IFeskMDZFVbzttHjk0XX_7y_vbiVFED6hEm", --Start/Stop/Restart
    ["stackalert"] =       "https://discord.com/api/webhooks/1335751458812854413/VEW-BVdR_IPiO-ncxwUilQuzbF7XaX6OXKLOEdm-QlJLk3vtNTmiUPeft0-UsboF5n8f", --DONE (?)
 --Player related
    ["kill"] =              "https://discord.com/api/webhooks/1299450249252704377/xK9Onv9aIDlL4PwRv9-yfMH5kaqSZo2Vs2uKSRkIkWneZfcJhiD-X9rNZ45OTE3zJN0p", --TBD
    ["trunk"] =             "https://discord.com/api/webhooks/1299347185342615602/huDBokJvJcGZaCTRg0XlrkubRiXLbFOvQCbTIvnaME1oSaOUZooUDSu40NoRGs6QkRp-", --DONE
    ["atm"] =               "https://discord.com/api/webhooks/1299423560183578714/cx409WKxsxkNOL74FzHrLSE5519VFPWVCutqIcm0MyI-yXRiKaFbBIJdAonpLNgEWc1q", --DONE
    ["ooc"] =               "https://discord.com/api/webhooks/1299440995615903836/meP8QblJV7U1_3x-PtEKHGttPbXAaHWuyRSG9Vma3QJLyZ2hkD9viTdGnk1o4Ef_Csxl", --DONE
    ["rp"] =                "https://discord.com/api/webhooks/1299458302228435067/Y5-JRGnz-GTUQP9miqdDOxEQqps0FA5aR83JnFs5ddXfZV2cTAF5XglYVyVM3ur2Lkka", --DONE
    ["trash"] =             "https://discord.com/api/webhooks/1299465707448434688/GeXtUBxd5bgkXbqJTrCq5QeL5XvhHP9Hoh9rhKgkqcMdau5gqw10yW10kYBp_rf4Hi5i", --Megafon hianyzik
    ["premiumshop"] =       "https://discord.com/api/webhooks/1299469105396453436/os9F8dRI4NreMhBLeEQD7-ubh9S_GIHnXU3N05vl7HdWO4RHGNZVrWQ_LTFVq5HSQU3h", --DONE
    ["safe"] =              "https://discord.com/api/webhooks/1299621844097437706/qfrDR7w5bx1REo3YpbiqESg6YOZEphJK3NvgAAW_PYxEAJEBkx8SHuaRwOv4QK9fNQyv", --DONE
    ["icchat"] =            "https://discord.com/api/webhooks/1299654418416930837/ncQpt-JivjCLk9pZqDCxNrlcFPlZYnh3ZgeZ4OXhEb1g630upPS7I8bO-Ts-nzmroxG5", --TBD (Shout/Chat)
--  ["casino"] =            "https://discord.com/api/webhooks/1124265649762484314/nHR8V3MR4ix1h--1L5Vdz2n7bLcVwZ7V8kLp5JP3Xoe-AHkmeciBvX06pFafV4Hdxpxo", --Win/Lose
--  ["ssc"] =               "https://discord.com/api/webhooks/1123315301778464788/ZJ9qCCK73hRLBtbLGt8x6uEWlG6WlcvKvcR_cHQAGRhk6b0CPdv59EFnomfQC3SgkXjq", --Buy/Sell
--  ["moneylog"] =          "https://discord.com/api/webhooks/1123543295444918333/j6wPeMv4K0Oa-TcyTogueqowsHlYPzaeWmjcXAdicmYzKgfNuxTSpRumaV1_qlqFX2e9", --Pay
--  ["interioreconomy"] =   "https://discord.com/api/webhooks/1123543295444918333/j6wPeMv4K0Oa-TcyTogueqowsHlYPzaeWmjcXAdicmYzKgfNuxTSpRumaV1_qlqFX2e9", --Interior Sell/Buy
--  ["vehicleeconomy"] =    "https://discord.com/api/webhooks/1123543295444918333/j6wPeMv4K0Oa-TcyTogueqowsHlYPzaeWmjcXAdicmYzKgfNuxTSpRumaV1_qlqFX2e9", --Vehicle Sell/Buy CarShop Sell/Buy
--  ["pawnshop"] =          "https://discord.com/api/webhooks/1123543295444918333/j6wPeMv4K0Oa-TcyTogueqowsHlYPzaeWmjcXAdicmYzKgfNuxTSpRumaV1_qlqFX2e9", --PawnShop Sell
--  ["fish"] =              "https://discord.com/api/webhooks/1123543295444918333/j6wPeMv4K0Oa-TcyTogueqowsHlYPzaeWmjcXAdicmYzKgfNuxTSpRumaV1_qlqFX2e9", --Fish Sell
--Admin related
--  ["teleport"] =          "https://discord.com/api/webhooks/1299740057380585555/9ixRYWIJK-FpIRZJlODEvqOdCSoPC08uULW8jAVVAEcjVApG3MJV3bv2ZDyW3iVVz3m-", --TBD
--  ["recon"] =             "https://discord.com/api/webhooks/1123543846169620511/5NRpOQnmhzJcTgSmeedEzPC7u3Uz9_sNxwN7xr-Q42lWHKpKT9nOY-UpqBbm1LzEkiv_", --TBD
    ["give"] =              "https://discord.com/api/webhooks/1299451632567717979/waD1d076Q9uUzdJkJtrC2-pI80ltpB1WbPD0ptQHHPbu_bt4KC5iwqBLvKSwL52IDZvQ", --DONE
    ["adminchat"] =         "https://discord.com/api/webhooks/1299657542477025310/wlyAzAAaPpv3IYqJXc7bx3eRNeOLyTfr6JQNCGGb991PAoho9VfxjmbfgSMZ5ju6sXh5", --DONE
    ["aj"] =                "https://discord.com/api/webhooks/1299657542477025310/wlyAzAAaPpv3IYqJXc7bx3eRNeOLyTfr6JQNCGGb991PAoho9VfxjmbfgSMZ5ju6sXh5", --TBD
    ["changename"] =        "https://discord.com/api/webhooks/1299657542477025310/wlyAzAAaPpv3IYqJXc7bx3eRNeOLyTfr6JQNCGGb991PAoho9VfxjmbfgSMZ5ju6sXh5", --TBD
    ["kick"] =              "https://discord.com/api/webhooks/1299657542477025310/wlyAzAAaPpv3IYqJXc7bx3eRNeOLyTfr6JQNCGGb991PAoho9VfxjmbfgSMZ5ju6sXh5", --TBD
    ["ban"] =               "https://discord.com/api/webhooks/1299657542477025310/wlyAzAAaPpv3IYqJXc7bx3eRNeOLyTfr6JQNCGGb991PAoho9VfxjmbfgSMZ5ju6sXh5", --TBD
    ["unban"] =             "https://discord.com/api/webhooks/1299657542477025310/wlyAzAAaPpv3IYqJXc7bx3eRNeOLyTfr6JQNCGGb991PAoho9VfxjmbfgSMZ5ju6sXh5", --TBD
--  ["getplayer"] =         "https://discord.com/api/webhooks/1123543491344076951/hblaFOJ0V5kR8ZWdd-3aQf93DN7pF_6n1AeBv3itvpjNMFpjM7YtZRvUkEK8rMtbwREb", --TBD
    ["setadminlevel"] =     "https://discord.com/api/webhooks/1299745002309685259/J37pjiK9_rM_BvcvzgKOkb2b77vqOFEhxpXlLCWEWzmLpMjq_2PdQ7EDDw0BDSnvTa-Q", --DONE
--  ["setadminnick"] =      "https://discord.com/api/webhooks/1123543491344076951/hblaFOJ0V5kR8ZWdd-3aQf93DN7pF_6n1AeBv3itvpjNMFpjM7YtZRvUkEK8rMtbwREb", --TBD
--  ["sethelperlevel"] =    "https://discord.com/api/webhooks/1123543491344076951/hblaFOJ0V5kR8ZWdd-3aQf93DN7pF_6n1AeBv3itvpjNMFpjM7YtZRvUkEK8rMtbwREb", --TBD
--  ["aduty"] =             "https://discord.com/api/webhooks/1123543491344076951/hblaFOJ0V5kR8ZWdd-3aQf93DN7pF_6n1AeBv3itvpjNMFpjM7YtZRvUkEK8rMtbwREb", --TBD
--  ["helperchat"] =        "https://discord.com/api/webhooks/1123543491344076951/hblaFOJ0V5kR8ZWdd-3aQf93DN7pF_6n1AeBv3itvpjNMFpjM7YtZRvUkEK8rMtbwREb", --TBD
--  ["asay"] =              "https://discord.com/api/webhooks/1123543491344076951/hblaFOJ0V5kR8ZWdd-3aQf93DN7pF_6n1AeBv3itvpjNMFpjM7YtZRvUkEK8rMtbwREb", --TBD
--  ["setstuff"] =          "https://discord.com/api/webhooks/1123543491344076951/hblaFOJ0V5kR8ZWdd-3aQf93DN7pF_6n1AeBv3itvpjNMFpjM7YtZRvUkEK8rMtbwREb", --SetSkin/SetHP
--  ["changename"] =        "https://discord.com/api/webhooks/1123543491344076951/hblaFOJ0V5kR8ZWdd-3aQf93DN7pF_6n1AeBv3itvpjNMFpjM7YtZRvUkEK8rMtbwREb", --TBD
--  ["unflip"] =            "https://discord.com/api/webhooks/1123543491344076951/hblaFOJ0V5kR8ZWdd-3aQf93DN7pF_6n1AeBv3itvpjNMFpjM7YtZRvUkEK8rMtbwREb", --TBD
--  ["removeplate"] =       "https://discord.com/api/webhooks/1123543491344076951/hblaFOJ0V5kR8ZWdd-3aQf93DN7pF_6n1AeBv3itvpjNMFpjM7YtZRvUkEK8rMtbwREb", --TBD
--  ["setplatetext"] =      "https://discord.com/api/webhooks/1123543491344076951/hblaFOJ0V5kR8ZWdd-3aQf93DN7pF_6n1AeBv3itvpjNMFpjM7YtZRvUkEK8rMtbwREb", --TBD
--  ["setdim"] =            "https://discord.com/api/webhooks/1123543491344076951/hblaFOJ0V5kR8ZWdd-3aQf93DN7pF_6n1AeBv3itvpjNMFpjM7YtZRvUkEK8rMtbwREb", --TBD
--  ["setint"] =            "https://discord.com/api/webhooks/1123543491344076951/hblaFOJ0V5kR8ZWdd-3aQf93DN7pF_6n1AeBv3itvpjNMFpjM7YtZRvUkEK8rMtbwREb", --TBD
--  ["teleport"] =          "https://discord.com/api/webhooks/1123543491344076951/hblaFOJ0V5kR8ZWdd-3aQf93DN7pF_6n1AeBv3itvpjNMFpjM7YtZRvUkEK8rMtbwREb", --TBD
    ["ahelp"] =             "https://discord.com/api/webhooks/1299742708440764626/AmZKfVAG2fTisHfvjDiBONAX8kE36Ymj3a181Xyu0EOUTbCwvf3b_FqYpv9GlycO71m0", --DONE
    ["astats"] =            "https://discord.com/api/webhooks/1299757580104499231/2O0GDqKCxyKUJkaMYytq-rHs5XKQeaDybUfCW-55BxhVe8f--mDpfwM_pHnogi_Gl5PL", --DONE
    ["amoney"] =            "https://discord.com/api/webhooks/1299752713692647485/M5_pDzp1j2M6nBLsfmws84MqRL7t7Lm9eyW52uln3yzG7eGiF160stSfxDInQCJPY0zM", --/setmoney hianyzik
    ["badgecreate"] =       "https://discord.com/api/webhooks/1334521991591628902/XP0hm97A_S0FZwOCR6pEnu8RxjkDIGRP-dPNJq6J2yDaWU9HIYsG9kbke0uqfHNA1cQM", --DONE
    ["premiumItem"] =       "https://discord.com/api/webhooks/1338170386042585209/s6WjEsENu3waeqiP_-o4PstTmUc2wrZyCDiySU-07Xt7G8bXZwaDMKdUZYy3rEXAcCGD", --DONE
--  ["adminvehicle"] =      "https://discord.com/api/webhooks/1123543491344076951/hblaFOJ0V5kR8ZWdd-3aQf93DN7pF_6n1AeBv3itvpjNMFpjM7YtZRvUkEK8rMtbwREb", --MakeVeh/DelVeh
--Management related
--  ["cuponcreate"] =       "https://discord.com/api/webhooks/1123543128683581481/hHmLniSNYlL-PE9rAgIQPo2UBfPpnsCWeNrA43bAtRANlCmkZkP1Pg17VXkqNlwZM8Sf", -Admin/Usable/Available use/Content
--  ["cuponuse"] =          "https://discord.com/api/webhooks/1123543128683581481/hHmLniSNYlL-PE9rAgIQPo2UBfPpnsCWeNrA43bAtRANlCmkZkP1Pg17VXkqNlwZM8Sf", -Player
}

function sendWebhookMessage(message, type)
    if not discordWebookURL[type] then
        print("Unable to find type!")
        return
    end

    local sendOptions = {formFields = {content = message}}
    fetchRemote(discordWebookURL[type], sendOptions, webhookCallBackFunction)
end

local embedDatas = {}

local formattedTypeNames = {
    ["badgecreate"] = "Jelvény létrehozás",
}

local embedColors = {
    ["green"] = 65280, -- 0x00FF00
    ["red"] = 16711680, -- 0xFF0000
    -- SightMTA Colors
    ["sightgreen"] = 0x3CB882,         -- (60, 184, 130)
    ["sightgreen-second"] = 0x3CB8AA,  -- (60, 184, 170)

    ["sightred"] = 0xF35A5A,           -- (243, 90, 90)
    ["sightred-second"] = 0xFA785F,    -- (250, 120, 95)

    ["sightblue"] = 0x319AD7,          -- (49, 154, 215)
    ["sightblue-second"] = 0x31B4E1,   -- (49, 180, 225)

    ["sightyellow"] = 0xF3D65A,        -- (243, 214, 90)
    ["sightyellow-second"] = 0xFAF082, -- (250, 240, 130)

    ["sightorange"] = 0xFF9514,        -- (255, 149, 20)
    ["sightorange-second"] = 0xFAB328, -- (250, 179, 40)

    ["sightpurple"] = 0x943CB8,        -- (148, 60, 184)
    ["sightpurple-second"] = 0xB64CE2  -- (182, 76, 226)
}

function sendEmbedMessage(messageDetails, webhookType)
    local currentDateTime = os.date('%Y-%m-%d %H:%M:%S')

    local embedData = {
        username = messageDetails.username or "SightMTA - Anticheat ["..(formattedTypeNames[webhookType] or "Nincs beállítva!").."]",
        avatar_url = 'https://images-ext-1.discordapp.net/external/U9Uda5iajX0VRheayu8mD6U_ddnqn-VPNHZe1NSXf-E/https/i.imgur.com/mIi8vQP.png?format=webp&quality=lossless&width=468&height=468',
        embeds = {
            {
                title = messageDetails.title or "SightMTA - Log",
                color = embedColors[messageDetails.color] or 16711680,
                timestamp = currentDateTime,
                fields = messageDetails.embedData and messageDetails.embedData.embedFields or {},
                thumbnail = {
                    url = 'https://images-ext-1.discordapp.net/external/U9Uda5iajX0VRheayu8mD6U_ddnqn-VPNHZe1NSXf-E/https/i.imgur.com/mIi8vQP.png?format=webp&quality=lossless&width=468&height=468'
                },
                footer = {
                    text = "SightMTA | sightmta.hu | @eznemgergo",
                    icon_url = 'https://images-ext-1.discordapp.net/external/U9Uda5iajX0VRheayu8mD6U_ddnqn-VPNHZe1NSXf-E/https/i.imgur.com/mIi8vQP.png?format=webp&quality=lossless&width=468&height=468'
                }
            }
        }
    }

    local jsonData = toJSON(embedData, true)
    jsonData = jsonData:sub(2):sub(1, #jsonData - 2)

    local sendOptions = {
        queueName = "discord",
        connectionAttempts = 100,
        connectTimeout = 150000,
        method = "POST",
        postData = jsonData,
        headers = {
            ["Content-Type"] = "application/json",
        }
    }

    fetchRemote(discordWebookURL[webhookType], sendOptions, function(...) return arg end)
end

--[[
function testEmbed()
    local embedDatas = {
        username = "SightMTA - Log [Kitiltás]",
        title = "SightMTA | sightmta.hu",
        color = "sightred",

        embedData = {
            embedFields = {
                {    
                    name = "Játékos neve - [Account ID]",
                    value = "```Dennis Mercury - [2]```",
                    inline = true
                },
                {
                    name = "Adminisztrátor",
                    value = "```Baross```",
                    inline = true
                },
                {
                    name = "Indok",
                    value = "```Teszt```",
                },
                {
                    name = "Lejárat:",
                    value = "```Teszt```",
                },
            },
        },
    }

    exports.sAnticheat:sendEmbedMessage(embedDatas, "badgecreate")
end
testEmbed()
]]
--sendEmbedMessage(false, "badgecreate")

local developmentMode = false

function webhookCallBackFunction(responseData, err)
    if developmentMode then
        if responseData then
        end
        if err then
        end
    end
    return
end