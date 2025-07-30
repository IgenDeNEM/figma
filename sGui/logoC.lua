local sightlangStatImgHand = false
local sightlangStaticImage = {}
local sightlangStaticImageToc = {}
local sightlangStaticImageUsed = {}
local sightlangStaticImageDel = {}
local processsightlangStaticImage = {}

sightlangStaticImageToc[0] = true

local function sightlangStatImgPre()
    local now = getTickCount()
    if sightlangStaticImageUsed[0] then
        sightlangStaticImageUsed[0] = false
        sightlangStaticImageDel[0] = false
    elseif sightlangStaticImage[0] then
        if sightlangStaticImageDel[0] then
            if now >= sightlangStaticImageDel[0] then
                if isElement(sightlangStaticImage[0]) then
                    destroyElement(sightlangStaticImage[0])
                end
                sightlangStaticImage[0] = nil
                sightlangStaticImageDel[0] = false
                sightlangStaticImageToc[0] = true
                return
            end
        else
            sightlangStaticImageDel[0] = now + 5000
        end
    else
        sightlangStaticImageToc[0] = true
    end
    if sightlangStaticImageToc[0] then
        sightlangStatImgHand = false
        removeEventHandler("onClientPreRender", root, sightlangStatImgPre)
    end
end

processsightlangStaticImage[0] = function()
    if not isElement(sightlangStaticImage[0]) then
        sightlangStaticImageToc[0] = false
        sightlangStaticImage[0] = dxCreateTexture("logo/4.dds", "argb", true)
    end
    if not sightlangStatImgHand then
        sightlangStatImgHand = true
        addEventHandler("onClientPreRender", root, sightlangStatImgPre, true, "high+999999999")
    end
end
local shaderCode = [[
    float Time;

    texture logoTexture;
    sampler baseSampler = sampler_state {Texture=logoTexture;};

    float4 shine_color = float4(1.0, 1.0, 1.0, 0.4); 
    float4 logoColor; 
    float line_width = 0.1;
    float angle = 0.785398163397; 

    float speed = 0.5;
    float wait_cycle = 1.0;

    float2 rotate_precalculated(float2 _pos, float _sine, float _cosine) {
        return float2(_pos.x * _cosine - _pos.y * _sine, _pos.x * _sine + _pos.y * _cosine);
    }

    float4 logo(float2 tx: TEXCOORD0): COLOR0 {
        float sine = sin(angle);
        float cosine = cos(angle);
        float len = 1.5-max(abs(sine),abs(cosine))+line_width;
        float result_line = smoothstep(-line_width,line_width,rotate_precalculated(tx-0.5,sine,cosine).y-fmod(Time*speed,(len*2.0)*wait_cycle)+len);

        float3 color = shine_color.rgb*shine_color.a*(result_line*(1.0-result_line)*4.0);
        float4 tex_color = tex2D(baseSampler,tx)*logoColor;
        return float4(tex_color.rgb+color*tex_color.a,tex_color.a);
    }

    technique {
        pass P0 {
            PixelShader = compile ps_2_0 logo();
        }
    }
]]

local shader
guiElements = guiElements or {}
colors = colors or {
    sightgreen = {0, 255, 0}
}

function setLogoAnimated(el, animated)
    if tonumber(el) and guiElements[el] then
        if guiElements[el].type == "logo" then
            shader = dxCreateShader(shaderCode)
            guiElements[el].animatedLogo = animated
        else
            outputDebugString("setLogoAnimated: guiElement is not a logo", 1)
        end
    else
        outputDebugString("setLogoAnimated: invalid guiElement", 1)
    end
end

function playLogoAnimation(el, animType, animationTime)
    if not (tonumber(el) and guiElements[el]) then
        outputDebugString("playLogoAnimation: invalid guiElement", 1)
        return
    end
    if guiElements[el].type ~= "logo" then
        outputDebugString("playLogoAnimation: guiElement is not a logo", 1)
        return
    end

    local now = getTickCount()
    local animTime = animationTime or 1000

    if animType == "in" or animType == "out" then
        guiElements[el].logoAnimationType = animType
        guiElements[el].logoAnimations = { startTick = now, duration = animTime }
        if animType == "in" then
            guiElements[el].faded = false
        end
    else
        outputDebugString("playLogoAnimation: animType must be 'in' or 'out'", 1)
    end
end

local hadLogoAnimation = false

function renderFunctions.logo(el)
    if not guiElements[el] or guiElements[el].type ~= "logo" then
        if hadLogoAnimation then
            destroyElement(shader)
            shader = nil
            collectgarbage("collect")
            hadLogoAnimation = false
        end

        return
    end

    local hadLogoAnimation = true
    local now = getTickCount()

    local fadeAlpha = 1

    if guiElements[el].fadeIn then
        local progress = getEasingValue(
            math.min(1, (now - guiElements[el].fadeIn) / guiElements[el].fadeInTime),
            "InOutQuad"
        )
        fadeAlpha = progress
        guiElements[el].faded = false
        if progress >= 1 then
            guiElements[el].fadeIn = false
        end
    end

    if guiElements[el].fadeOut then
        local progress = 1 - getEasingValue(
            math.min(1, (now - guiElements[el].fadeOut) / guiElements[el].fadeOutTime),
            "InOutQuad"
        )
        fadeAlpha = progress
        if progress <= 0 then
            guiElements[el].fadeOut = false
            guiElements[el].faded = true
        end
    end

    if guiElements[el].faded then return end

    if guiElements[el].animatedLogo and guiElements[el].logoAnimations then
        local animData = guiElements[el].logoAnimations
        local animType = guiElements[el].logoAnimationType
        local startT   = animData.startTick
        local duration = animData.duration
        local progress = 0

        if duration and duration > 0 then
            progress = math.min(math.max((now - startT) / duration, 0), 1)
        else
            progress = 1
        end

        local alpha, scale = 0, 1
        if animType == "in" then
            alpha, scale = interpolateBetween(0, 1.2, 0, 255, 1, 0, progress, "OutQuad")
            alpha2 = interpolateBetween(0, 0, 0, 255, 1, 0, progress * 2, "OutQuad")
        else
            alpha, scale = interpolateBetween(255, 1, 0, 0, 1.2, 0, progress, "OutQuad")
        end

        alpha = alpha * fadeAlpha

        if shader and isElement(shader) and isElement(sightlangStaticImage[0]) then
            local r, g, b = colors["sightgreen"][1], colors["sightgreen"][2], colors["sightgreen"][3]
            dxSetShaderValue(shader, "logoColor", r/255, g/255, b/255, alpha/255)
            dxSetShaderValue(shader, "logoTexture", sightlangStaticImage[0])
        end

        local drawW = guiElements[el].sx * scale
        local drawH = guiElements[el].sy * scale

        local normalW = guiElements[el].sx
        local normalH = guiElements[el].sy
        local normalX = guiElements[el].x - normalW / 2
        local normalY = guiElements[el].y - normalH / 2

        local drawX = guiElements[el].x - drawW / 2
        local drawY = guiElements[el].y - drawH / 2

        if shader and isElement(shader) then
            if alpha ~= 255 then
                dxDrawImage(drawX, drawY, drawW, drawH, shader, 0, 0, 0, tocolor(255,255,255,255))
            end
            dxDrawImage(normalX, normalY, normalW, normalH, shader, 0, 0, 0, tocolor(255,255,255,255))
        else
            if alpha ~= 255 then
                dxDrawImage(drawX, drawY, drawW, drawH, sightlangStaticImage[0], 0,0,0, tocolor(255,255,255, alpha))
            end
            dxDrawImage(normalX, normalY, normalW, normalH, sightlangStaticImage[0], 0,0,0, tocolor(255,255,255, alpha2))
        end

        if progress == 1 then
            if animType == "out" then
                guiElements[el].faded = true
            end
            guiElements[el].logoAnimations = nil
            guiElements[el].logoAnimationType = nil
        end

    else
        sightlangStaticImageUsed[0] = true
        if sightlangStaticImageToc[0] then
            processsightlangStaticImage[0]()
        end

        local r, g, b = colors["sightgreen"][1], colors["sightgreen"][2], colors["sightgreen"][3]
        local drawX   = guiElements[el].x - guiElements[el].sx/2
        local drawY   = guiElements[el].y - guiElements[el].sy/2

        dxDrawImage(
            drawX,
            drawY,
            guiElements[el].sx,
            guiElements[el].sy,
            shader,
            0, 0, 0,
            tocolor(r, g, b, 255 * fadeAlpha)
        )
    end
end
