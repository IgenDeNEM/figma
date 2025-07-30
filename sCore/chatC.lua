local colors = {}

local function replaceColorCodes(input)
    local color, rest = input:match("%[color=(.-)%](.*)")
    if color and colorTable[color] then
        return colorTable[color] .. rest
    else
        return input
    end
end
  
local function processText(input)
    local output = input:gsub("%[color=(.-)%]", replaceColorCodes)
    return output
end
  
addEventHandler("onClientChatMessage", getRootElement(), function(text, r, g, b)
    if string.find(text, "%[color=(.-)%]") then
        local output = string.gsub(text, "%[color=(.-)%]", function(color, content)
            local r, g, b = 255, 255, 255
            if colors[color] then
                r, g, b = unpack(colors[color])
            end
            return string.format("#%.2X%.2X%.2X", r, g, b) or tostring(color)
        end)
        outputChatBox(output, r, g, b, true)
        cancelEvent()
    end
end)

function registerChatColor(color, toC)
    colors[color] = {bitExtract(toC, 16, 8), bitExtract(toC, 8, 8), bitExtract(toC, 0, 8)}
end

local defaultColorSet = {
    hudwhite = {
      255,
      255,
      255
    },
    sightgrey1 = {
      26,
      27,
      31
    },
    sightgrey2 = {
      35,
      39,
      42
    },
    sightgrey3 = {
      51,
      53,
      61
    },
    sightgrey4 = {
      30,
      33,
      36
    },
    sightmidgrey = {
      84,
      86,
      93
    },
    sightlightgrey = {
      186,
      190,
      196
    },
    sightgreen = {
      60,
      184,
      130
    },
    ["sightgreen-second"] = {
      60,
      184,
      170
    },
    sightred = {
      243,
      90,
      90
    },
    ["sightred-second"] = {
      250,
      120,
      95
    },
    sightblue = {
      49,
      154,
      215
    },
    ["sightblue-second"] = {
      49,
      180,
      225
    },
    sightyellow = {
      243,
      214,
      90
    },
    ["sightyellow-second"] = {
      250,
      240,
      130
    },
    sightorange = {
      255,
      149,
      20
    },
    ["sightorange-second"] = {
      250,
      179,
      40
    },
    sightpurple = {
      148,
      60,
      184
    },
    ["sightpurple-second"] = {
      182,
      76,
      226
    }
}

for k, v in pairs(defaultColorSet) do
    registerChatColor(k, tocolor(v[1], v[2], v[3]))
end