local sightexports = {sGui = false}
local setAdminValue = {}
local setHelperValue = {}
local shader = dxCreateShader([[
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
]])



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
local sightlangStatImgHand = false
local sightlangStaticImage = {}
local sightlangStaticImageToc = {}
local sightlangStaticImageUsed = {}
local sightlangStaticImageDel = {}
local processsightlangStaticImage = {}
sightlangStaticImageToc[0] = true
sightlangStaticImageToc[1] = true
sightlangStaticImageToc[2] = true
sightlangStaticImageToc[3] = true
sightlangStaticImageToc[4] = true
sightlangStaticImageToc[5] = true
sightlangStaticImageToc[6] = true
sightlangStaticImageToc[7] = true
sightlangStaticImageToc[8] = true
sightlangStaticImageToc[9] = true
sightlangStaticImageToc[10] = true
sightlangStaticImageToc[11] = true
sightlangStaticImageToc[12] = true
sightlangStaticImageToc[13] = true
sightlangStaticImageToc[14] = true
sightlangStaticImageToc[15] = true
sightlangStaticImageToc[16] = true
sightlangStaticImageToc[17] = true
sightlangStaticImageToc[18] = true
sightlangStaticImageToc[19] = true
sightlangStaticImageToc[20] = true
sightlangStaticImageToc[21] = true
sightlangStaticImageToc[22] = true
sightlangStaticImageToc[23] = true
sightlangStaticImageToc[24] = true
sightlangStaticImageToc[25] = true
sightlangStaticImageToc[26] = true
sightlangStaticImageToc[27] = true
local sightlangStatImgPre
function sightlangStatImgPre()
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
  if sightlangStaticImageUsed[1] then
    sightlangStaticImageUsed[1] = false
    sightlangStaticImageDel[1] = false
  elseif sightlangStaticImage[1] then
    if sightlangStaticImageDel[1] then
      if now >= sightlangStaticImageDel[1] then
        if isElement(sightlangStaticImage[1]) then
          destroyElement(sightlangStaticImage[1])
        end
        sightlangStaticImage[1] = nil
        sightlangStaticImageDel[1] = false
        sightlangStaticImageToc[1] = true
        return
      end
    else
      sightlangStaticImageDel[1] = now + 5000
    end
  else
    sightlangStaticImageToc[1] = true
  end
  if sightlangStaticImageUsed[2] then
    sightlangStaticImageUsed[2] = false
    sightlangStaticImageDel[2] = false
  elseif sightlangStaticImage[2] then
    if sightlangStaticImageDel[2] then
      if now >= sightlangStaticImageDel[2] then
        if isElement(sightlangStaticImage[2]) then
          destroyElement(sightlangStaticImage[2])
        end
        sightlangStaticImage[2] = nil
        sightlangStaticImageDel[2] = false
        sightlangStaticImageToc[2] = true
        return
      end
    else
      sightlangStaticImageDel[2] = now + 5000
    end
  else
    sightlangStaticImageToc[2] = true
  end
  if sightlangStaticImageUsed[8] then
    sightlangStaticImageUsed[8] = false
    sightlangStaticImageDel[8] = false
  elseif sightlangStaticImage[8] then
    if sightlangStaticImageDel[8] then
      if now >= sightlangStaticImageDel[8] then
        if isElement(sightlangStaticImage[8]) then
          destroyElement(sightlangStaticImage[8])
        end
        sightlangStaticImage[8] = nil
        sightlangStaticImageDel[8] = false
        sightlangStaticImageToc[8] = true
        return
      end
    else
      sightlangStaticImageDel[8] = now + 5000
    end
  else
    sightlangStaticImageToc[8] = true
  end
  if sightlangStaticImageUsed[9] then
    sightlangStaticImageUsed[9] = false
    sightlangStaticImageDel[9] = false
  elseif sightlangStaticImage[9] then
    if sightlangStaticImageDel[9] then
      if now >= sightlangStaticImageDel[9] then
        if isElement(sightlangStaticImage[9]) then
          destroyElement(sightlangStaticImage[9])
        end
        sightlangStaticImage[9] = nil
        sightlangStaticImageDel[9] = false
        sightlangStaticImageToc[9] = true
        return
      end
    else
      sightlangStaticImageDel[9] = now + 5000
    end
  else
    sightlangStaticImageToc[9] = true
  end
  if sightlangStaticImageUsed[10] then
    sightlangStaticImageUsed[10] = false
    sightlangStaticImageDel[10] = false
  elseif sightlangStaticImage[10] then
    if sightlangStaticImageDel[10] then
      if now >= sightlangStaticImageDel[10] then
        if isElement(sightlangStaticImage[10]) then
          destroyElement(sightlangStaticImage[10])
        end
        sightlangStaticImage[10] = nil
        sightlangStaticImageDel[10] = false
        sightlangStaticImageToc[10] = true
        return
      end
    else
      sightlangStaticImageDel[10] = now + 5000
    end
  else
    sightlangStaticImageToc[10] = true
  end
  if sightlangStaticImageUsed[11] then
    sightlangStaticImageUsed[11] = false
    sightlangStaticImageDel[11] = false
  elseif sightlangStaticImage[11] then
    if sightlangStaticImageDel[11] then
      if now >= sightlangStaticImageDel[11] then
        if isElement(sightlangStaticImage[11]) then
          destroyElement(sightlangStaticImage[11])
        end
        sightlangStaticImage[11] = nil
        sightlangStaticImageDel[11] = false
        sightlangStaticImageToc[11] = true
        return
      end
    else
      sightlangStaticImageDel[11] = now + 5000
    end
  else
    sightlangStaticImageToc[11] = true
  end
  if sightlangStaticImageUsed[12] then
    sightlangStaticImageUsed[12] = false
    sightlangStaticImageDel[12] = false
  elseif sightlangStaticImage[12] then
    if sightlangStaticImageDel[12] then
      if now >= sightlangStaticImageDel[12] then
        if isElement(sightlangStaticImage[12]) then
          destroyElement(sightlangStaticImage[12])
        end
        sightlangStaticImage[12] = nil
        sightlangStaticImageDel[12] = false
        sightlangStaticImageToc[12] = true
        return
      end
    else
      sightlangStaticImageDel[12] = now + 5000
    end
  else
    sightlangStaticImageToc[12] = true
  end
  if sightlangStaticImageUsed[13] then
    sightlangStaticImageUsed[13] = false
    sightlangStaticImageDel[13] = false
  elseif sightlangStaticImage[13] then
    if sightlangStaticImageDel[13] then
      if now >= sightlangStaticImageDel[13] then
        if isElement(sightlangStaticImage[13]) then
          destroyElement(sightlangStaticImage[13])
        end
        sightlangStaticImage[13] = nil
        sightlangStaticImageDel[13] = false
        sightlangStaticImageToc[13] = true
        return
      end
    else
      sightlangStaticImageDel[13] = now + 5000
    end
  else
    sightlangStaticImageToc[13] = true
  end
  if sightlangStaticImageUsed[14] then
    sightlangStaticImageUsed[14] = false
    sightlangStaticImageDel[14] = false
  elseif sightlangStaticImage[14] then
    if sightlangStaticImageDel[14] then
      if now >= sightlangStaticImageDel[14] then
        if isElement(sightlangStaticImage[14]) then
          destroyElement(sightlangStaticImage[14])
        end
        sightlangStaticImage[14] = nil
        sightlangStaticImageDel[14] = false
        sightlangStaticImageToc[14] = true
        return
      end
    else
      sightlangStaticImageDel[14] = now + 5000
    end
  else
    sightlangStaticImageToc[14] = true
  end
  if sightlangStaticImageUsed[15] then
    sightlangStaticImageUsed[15] = false
    sightlangStaticImageDel[15] = false
  elseif sightlangStaticImage[15] then
    if sightlangStaticImageDel[15] then
      if now >= sightlangStaticImageDel[15] then
        if isElement(sightlangStaticImage[15]) then
          destroyElement(sightlangStaticImage[15])
        end
        sightlangStaticImage[15] = nil
        sightlangStaticImageDel[15] = false
        sightlangStaticImageToc[15] = true
        return
      end
    else
      sightlangStaticImageDel[15] = now + 5000
    end
  else
    sightlangStaticImageToc[15] = true
  end
  if sightlangStaticImageUsed[16] then
    sightlangStaticImageUsed[16] = false
    sightlangStaticImageDel[16] = false
  elseif sightlangStaticImage[16] then
    if sightlangStaticImageDel[16] then
      if now >= sightlangStaticImageDel[16] then
        if isElement(sightlangStaticImage[16]) then
          destroyElement(sightlangStaticImage[16])
        end
        sightlangStaticImage[16] = nil
        sightlangStaticImageDel[16] = false
        sightlangStaticImageToc[16] = true
        return
      end
    else
      sightlangStaticImageDel[16] = now + 5000
    end
  else
    sightlangStaticImageToc[16] = true
  end
  if sightlangStaticImageUsed[17] then
    sightlangStaticImageUsed[17] = false
    sightlangStaticImageDel[17] = false
  elseif sightlangStaticImage[17] then
    if sightlangStaticImageDel[17] then
      if now >= sightlangStaticImageDel[17] then
        if isElement(sightlangStaticImage[17]) then
          destroyElement(sightlangStaticImage[17])
        end
        sightlangStaticImage[17] = nil
        sightlangStaticImageDel[17] = false
        sightlangStaticImageToc[17] = true
        return
      end
    else
      sightlangStaticImageDel[17] = now + 5000
    end
  else
    sightlangStaticImageToc[17] = true
  end
  if sightlangStaticImageUsed[18] then
    sightlangStaticImageUsed[18] = false
    sightlangStaticImageDel[18] = false
  elseif sightlangStaticImage[18] then
    if sightlangStaticImageDel[18] then
      if now >= sightlangStaticImageDel[18] then
        if isElement(sightlangStaticImage[18]) then
          destroyElement(sightlangStaticImage[18])
        end
        sightlangStaticImage[18] = nil
        sightlangStaticImageDel[18] = false
        sightlangStaticImageToc[18] = true
        return
      end
    else
      sightlangStaticImageDel[18] = now + 5000
    end
  else
    sightlangStaticImageToc[18] = true
  end
  if sightlangStaticImageUsed[19] then
    sightlangStaticImageUsed[19] = false
    sightlangStaticImageDel[19] = false
  elseif sightlangStaticImage[19] then
    if sightlangStaticImageDel[19] then
      if now >= sightlangStaticImageDel[19] then
        if isElement(sightlangStaticImage[19]) then
          destroyElement(sightlangStaticImage[19])
        end
        sightlangStaticImage[19] = nil
        sightlangStaticImageDel[19] = false
        sightlangStaticImageToc[19] = true
        return
      end
    else
      sightlangStaticImageDel[19] = now + 5000
    end
  else
    sightlangStaticImageToc[19] = true
  end
  if sightlangStaticImageUsed[20] then
    sightlangStaticImageUsed[20] = false
    sightlangStaticImageDel[20] = false
  elseif sightlangStaticImage[20] then
    if sightlangStaticImageDel[20] then
      if now >= sightlangStaticImageDel[20] then
        if isElement(sightlangStaticImage[20]) then
          destroyElement(sightlangStaticImage[20])
        end
        sightlangStaticImage[20] = nil
        sightlangStaticImageDel[20] = false
        sightlangStaticImageToc[20] = true
        return
      end
    else
      sightlangStaticImageDel[20] = now + 5000
    end
  else
    sightlangStaticImageToc[20] = true
  end
  if sightlangStaticImageUsed[21] then
    sightlangStaticImageUsed[21] = false
    sightlangStaticImageDel[21] = false
  elseif sightlangStaticImage[21] then
    if sightlangStaticImageDel[21] then
      if now >= sightlangStaticImageDel[21] then
        if isElement(sightlangStaticImage[21]) then
          destroyElement(sightlangStaticImage[21])
        end
        sightlangStaticImage[21] = nil
        sightlangStaticImageDel[21] = false
        sightlangStaticImageToc[21] = true
        return
      end
    else
      sightlangStaticImageDel[21] = now + 5000
    end
  else
    sightlangStaticImageToc[21] = true
  end
  if sightlangStaticImageUsed[22] then
    sightlangStaticImageUsed[22] = false
    sightlangStaticImageDel[22] = false
  elseif sightlangStaticImage[22] then
    if sightlangStaticImageDel[22] then
      if now >= sightlangStaticImageDel[22] then
        if isElement(sightlangStaticImage[22]) then
          destroyElement(sightlangStaticImage[22])
        end
        sightlangStaticImage[22] = nil
        sightlangStaticImageDel[22] = false
        sightlangStaticImageToc[22] = true
        return
      end
    else
      sightlangStaticImageDel[22] = now + 5000
    end
  else
    sightlangStaticImageToc[22] = true
  end
  if sightlangStaticImageUsed[23] then
    sightlangStaticImageUsed[23] = false
    sightlangStaticImageDel[23] = false
  elseif sightlangStaticImage[23] then
    if sightlangStaticImageDel[23] then
      if now >= sightlangStaticImageDel[23] then
        if isElement(sightlangStaticImage[23]) then
          destroyElement(sightlangStaticImage[23])
        end
        sightlangStaticImage[23] = nil
        sightlangStaticImageDel[23] = false
        sightlangStaticImageToc[23] = true
        return
      end
    else
      sightlangStaticImageDel[23] = now + 5000
    end
  else
    sightlangStaticImageToc[23] = true
  end
  if sightlangStaticImageUsed[24] then
    sightlangStaticImageUsed[24] = false
    sightlangStaticImageDel[24] = false
  elseif sightlangStaticImage[24] then
    if sightlangStaticImageDel[24] then
      if now >= sightlangStaticImageDel[24] then
        if isElement(sightlangStaticImage[24]) then
          destroyElement(sightlangStaticImage[24])
        end
        sightlangStaticImage[24] = nil
        sightlangStaticImageDel[24] = false
        sightlangStaticImageToc[24] = true
        return
      end
    else
      sightlangStaticImageDel[24] = now + 5000
    end
  else
    sightlangStaticImageToc[24] = true
  end
  if sightlangStaticImageUsed[25] then
    sightlangStaticImageUsed[25] = false
    sightlangStaticImageDel[25] = false
  elseif sightlangStaticImage[25] then
    if sightlangStaticImageDel[25] then
      if now >= sightlangStaticImageDel[25] then
        if isElement(sightlangStaticImage[25]) then
          destroyElement(sightlangStaticImage[25])
        end
        sightlangStaticImage[25] = nil
        sightlangStaticImageDel[25] = false
        sightlangStaticImageToc[25] = true
        return
      end
    else
      sightlangStaticImageDel[25] = now + 5000
    end
  else
    sightlangStaticImageToc[25] = true
  end
  if sightlangStaticImageUsed[26] then
    sightlangStaticImageUsed[26] = false
    sightlangStaticImageDel[26] = false
  elseif sightlangStaticImage[26] then
    if sightlangStaticImageDel[26] then
      if now >= sightlangStaticImageDel[26] then
        if isElement(sightlangStaticImage[26]) then
          destroyElement(sightlangStaticImage[26])
        end
        sightlangStaticImage[26] = nil
        sightlangStaticImageDel[26] = false
        sightlangStaticImageToc[26] = true
        return
      end
    else
      sightlangStaticImageDel[26] = now + 5000
    end
  else
    sightlangStaticImageToc[26] = true
  end
  if sightlangStaticImageUsed[27] then
    sightlangStaticImageUsed[27] = false
    sightlangStaticImageDel[27] = false
  elseif sightlangStaticImage[27] then
    if sightlangStaticImageDel[27] then
      if now >= sightlangStaticImageDel[27] then
        if isElement(sightlangStaticImage[27]) then
          destroyElement(sightlangStaticImage[27])
        end
        sightlangStaticImage[27] = nil
        sightlangStaticImageDel[27] = false
        sightlangStaticImageToc[27] = true
        return
      end
    else
      sightlangStaticImageDel[27] = now + 5000
    end
  else
    sightlangStaticImageToc[27] = true
  end
  if sightlangStaticImageToc[0] and sightlangStaticImageToc[1] and sightlangStaticImageToc[2] and sightlangStaticImageToc[3] and sightlangStaticImageToc[4] and sightlangStaticImageToc[5] and sightlangStaticImageToc[6] and sightlangStaticImageToc[7] and sightlangStaticImageToc[8] and sightlangStaticImageToc[9] and sightlangStaticImageToc[10] and sightlangStaticImageToc[11] and sightlangStaticImageToc[12] and sightlangStaticImageToc[13] and sightlangStaticImageToc[14] and sightlangStaticImageToc[15] and sightlangStaticImageToc[16] and sightlangStaticImageToc[17] and sightlangStaticImageToc[18] and sightlangStaticImageToc[19] and sightlangStaticImageToc[20] and sightlangStaticImageToc[21] and sightlangStaticImageToc[22] and sightlangStaticImageToc[23] and sightlangStaticImageToc[24] and sightlangStaticImageToc[25] and sightlangStaticImageToc[26] and sightlangStaticImageToc[27] then
    sightlangStatImgHand = false
    removeEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre)
  end
end
processsightlangStaticImage[0] = function()
  if not isElement(sightlangStaticImage[0]) then
    sightlangStaticImageToc[0] = false
    sightlangStaticImage[0] = dxCreateTexture("files/afk.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[1] = function()
  if not isElement(sightlangStaticImage[1]) then
    sightlangStaticImageToc[1] = false
    sightlangStaticImage[1] = dxCreateTexture("files/grave1.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[2] = function()
  if not isElement(sightlangStaticImage[2]) then
    sightlangStaticImageToc[2] = false
    sightlangStaticImage[2] = dxCreateTexture("files/grave2.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[7] = function()
  if not isElement(sightlangStaticImage[7]) then
    sightlangStaticImageToc[7] = false
    sightlangStaticImage[7] = dxCreateTexture("files/logo.dds", "argb", true)
    
    setShaderValue = {}

    dxSetShaderValue(shader, "logoTexture", sightlangStaticImage[7])
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
--[[
processsightlangStaticImage[8] = function()
  if not isElement(sightlangStaticImage[8]) then
    sightlangStaticImageToc[8] = false
    sightlangStaticImage[8] = dxCreateTexture("files/logo2.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[9] = function()
  if not isElement(sightlangStaticImage[9]) then
    sightlangStaticImageToc[9] = false
    sightlangStaticImage[9] = dxCreateTexture("files/logo3.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
]]
processsightlangStaticImage[10] = function()
  if not isElement(sightlangStaticImage[10]) then
    sightlangStaticImageToc[10] = false
    sightlangStaticImage[10] = dxCreateTexture("files/anim.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[11] = function()
  if not isElement(sightlangStaticImage[11]) then
    sightlangStaticImageToc[11] = false
    sightlangStaticImage[11] = dxCreateTexture("files/bag1.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[12] = function()
  if not isElement(sightlangStaticImage[12]) then
    sightlangStaticImageToc[12] = false
    sightlangStaticImage[12] = dxCreateTexture("files/bag3.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[13] = function()
  if not isElement(sightlangStaticImage[13]) then
    sightlangStaticImageToc[13] = false
    sightlangStaticImage[13] = dxCreateTexture("files/bag2.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[14] = function()
  if not isElement(sightlangStaticImage[14]) then
    sightlangStaticImageToc[14] = false
    sightlangStaticImage[14] = dxCreateTexture("files/cuff1.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[15] = function()
  if not isElement(sightlangStaticImage[15]) then
    sightlangStaticImageToc[15] = false
    sightlangStaticImage[15] = dxCreateTexture("files/cuff2.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[16] = function()
  if not isElement(sightlangStaticImage[16]) then
    sightlangStaticImageToc[16] = false
    sightlangStaticImage[16] = dxCreateTexture("files/tazer.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[17] = function()
  if not isElement(sightlangStaticImage[17]) then
    sightlangStaticImageToc[17] = false
    sightlangStaticImage[17] = dxCreateTexture("files/hospital.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[18] = function()
  if not isElement(sightlangStaticImage[18]) then
    sightlangStaticImageToc[18] = false
    sightlangStaticImage[18] = dxCreateTexture(":sHud/files/feather.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[19] = function()
  if not isElement(sightlangStaticImage[19]) then
    sightlangStaticImageToc[19] = false
    sightlangStaticImage[19] = dxCreateTexture(":sHud/files/featherTop.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[20] = function()
  if not isElement(sightlangStaticImage[20]) then
    sightlangStaticImageToc[20] = false
    sightlangStaticImage[20] = dxCreateTexture(":sHud/files/corner.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[21] = function()
  if not isElement(sightlangStaticImage[21]) then
    sightlangStaticImageToc[21] = false
    sightlangStaticImage[21] = dxCreateTexture("files/mic.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[22] = function()
  if not isElement(sightlangStaticImage[22]) then
    sightlangStaticImageToc[22] = false
    sightlangStaticImage[22] = dxCreateTexture("files/death.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[23] = function()
  if not isElement(sightlangStaticImage[23]) then
    sightlangStaticImageToc[23] = false
    sightlangStaticImage[23] = dxCreateTexture("files/wep.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[24] = function()
  if not isElement(sightlangStaticImage[24]) then
    sightlangStaticImageToc[24] = false
    sightlangStaticImage[24] = dxCreateTexture("files/armor.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[25] = function()
  if not isElement(sightlangStaticImage[25]) then
    sightlangStaticImageToc[25] = false
    sightlangStaticImage[25] = dxCreateTexture("files/belt.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[26] = function()
  if not isElement(sightlangStaticImage[26]) then
    sightlangStaticImageToc[26] = false
    sightlangStaticImage[26] = dxCreateTexture("files/id.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[27] = function()
  if not isElement(sightlangStaticImage[27]) then
    sightlangStaticImageToc[27] = false
    sightlangStaticImage[27] = dxCreateTexture("files/badge.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
local sightlangGuiRefreshColors = function()
  local res = getResourceFromName("sGui")
  if res and getResourceState(res) == "running" then
    refreshColors()
  end
end
addEventHandler("onGuiRefreshColors", getRootElement(), sightlangGuiRefreshColors)
addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangGuiRefreshColors)
local sightlangCondHandlState1 = false
local function sightlangCondHandl1(cond, prio)
  cond = cond and true or false
  if cond ~= sightlangCondHandlState1 then
    sightlangCondHandlState1 = cond
    if cond then
      addEventHandler("onClientRender", getRootElement(), renderNametag, true, prio)
    else
      removeEventHandler("onClientRender", getRootElement(), renderNametag)
    end
  end
end
local sightlangCondHandlState0 = false
local function sightlangCondHandl0(cond, prio)
  cond = cond and true or false
  if cond ~= sightlangCondHandlState0 then
    sightlangCondHandlState0 = cond
    if cond then
      addEventHandler("onClientRender", getRootElement(), renderSquadSigns, true, prio)
    else
      removeEventHandler("onClientRender", getRootElement(), renderSquadSigns)
    end
  end
end
local charsetSize = 64
local charsetData = {
  bebas = {
    checksum = "1D38DAA36B2A81D8B44D3E7201EC611C2B208057D16E75DA9C8917F072A2AE02",
    letters = {
      [" "] = 6,
      A = 15,
      B = 15,
      C = 14,
      D = 15,
      E = 13,
      F = 13,
      G = 15,
      H = 16,
      I = 7,
      J = 10,
      K = 16,
      L = 13,
      M = 20,
      N = 16,
      O = 15,
      P = 14,
      Q = 15,
      R = 15,
      S = 14,
      T = 14,
      U = 15,
      V = 14,
      W = 21,
      X = 15,
      Y = 15,
      Z = 13,
      a = 14,
      b = 15,
      c = 14,
      d = 15,
      e = 14,
      f = 10,
      g = 14,
      h = 15,
      i = 7,
      j = 7,
      k = 15,
      l = 7,
      m = 22,
      n = 15,
      o = 14,
      p = 15,
      q = 15,
      r = 10,
      s = 13,
      t = 10,
      u = 15,
      v = 14,
      w = 20,
      x = 14,
      y = 13,
      z = 12,
      ["0"] = 15,
      ["1"] = 11,
      ["2"] = 14,
      ["3"] = 14,
      ["4"] = 15,
      ["5"] = 14,
      ["6"] = 15,
      ["7"] = 13,
      ["8"] = 15,
      ["9"] = 15,
      ["Á"] = 15,
      ["É"] = 13,
      ["Í"] = 7,
      ["Ó"] = 15,
      ["Ö"] = 15,
      ["Ő"] = 15,
      ["Ú"] = 15,
      ["Ü"] = 15,
      ["Ű"] = 15,
      ["á"] = 14,
      ["é"] = 14,
      ["í"] = 7,
      ["ó"] = 14,
      ["ö"] = 14,
      ["ő"] = 14,
			["ú"] = 15,
      ["ü"] = 15,
      ["ű"] = 15,
      ["("] = 10,
      [")"] = 10,
      ["<"] = 15,
      [">"] = 15,
      ["-"] = 10,
      ["+"] = 10,
      ["."] = 8,
      ["\226\128\162"] = 11,
      [","] = 8,
      [":"] = 8,
      ["["] = 10,
      ["]"] = 10,
      ["'"] = 7,
      ["\""] = 12,
      [";"] = 8,
      ["?"] = 14,
      ["!"] = 8,
      ["*"] = 16,
      ["/"] = 15,
      ["\\"] = 15,
      ["$"] = 15,
      ["&"] = 16,
      ["@"] = 26,
      ["#"] = 15,
      _ = 11,
      ["\226\156\154"] = 28,
      ["\226\152\133"] = 27,
      ["\226\152\134"] = 27
    }
  },
  ubuntu = {
    checksum = "27E4A97E32E72A890176523EC2CC31800CE5F274D88C7F715B9BA5791955D601",
    letters = {
      [" "] = 7,
      A = 19,
      B = 19,
      C = 18,
      D = 21,
      E = 17,
      F = 16,
      G = 20,
      H = 21,
      I = 8,
      J = 15,
      K = 19,
      L = 16,
      M = 25,
      N = 21,
      O = 22,
      P = 18,
      Q = 22,
      R = 19,
      S = 16,
      T = 18,
      U = 20,
      V = 19,
      W = 27,
      X = 19,
      Y = 18,
      Z = 17,
      a = 15,
      b = 17,
      c = 14,
      d = 17,
      e = 16,
      f = 12,
      g = 17,
      h = 16,
      i = 8,
      j = 6,
      k = 16,
      l = 8,
      m = 24,
      n = 16,
      o = 17,
      p = 17,
      q = 17,
      r = 11,
      s = 14,
      t = 12,
      u = 16,
      v = 15,
      w = 21,
      x = 16,
      y = 15,
      z = 14,
      ["0"] = 16,
      ["1"] = 16,
      ["2"] = 16,
      ["3"] = 16,
      ["4"] = 16,
      ["5"] = 16,
      ["6"] = 16,
      ["7"] = 16,
      ["8"] = 16,
      ["9"] = 16,
      ["Á"] = 19,
      ["É"] = 17,
      ["Í"] = 8,
      ["Ó"] = 22,
      ["Ö"] = 22,
      ["Ő"] = 22,
      ["Ú"] = 20,
      ["Ü"] = 20,
      ["Ű"] = 20,
      ["á"] = 15,
      ["é"] = 16,
      ["í"] = 8,
      ["ó"] = 17,
      ["ö"] = 17,
      ["ő"] = 17,
			["ú"] = 16,
      ["ü"] = 16,
      ["ű"] = 16,
      ["("] = 10,
      [")"] = 10,
      ["<"] = 16,
      [">"] = 16,
      ["-"] = 10,
      ["+"] = 10,
      ["."] = 7,
      ["\226\128\162"] = 10,
      [","] = 7,
      [":"] = 7,
      ["["] = 10,
      ["]"] = 10,
      ["'"] = 6,
      ["\""] = 13,
      [";"] = 7,
      ["?"] = 13,
      ["!"] = 8,
      ["*"] = 14,
      ["/"] = 12,
      ["\\"] = 12,
      ["$"] = 16,
      ["&"] = 20,
      ["@"] = 27,
      ["#"] = 20,
      _ = 14,
      ["\226\156\154"] = 22,
      ["\226\152\133"] = 21,
      ["\226\152\134"] = 21
    }
  }
}
local helperColor = {
  255,
  255,
  255
}
local colors = {
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
  sightgrey2a = {
    35,
    39,
    42,
    125
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
    255,
    149,
    20
  },
  ["sightpurple-second"] = {
    250,
    179,
    40
  }
}
function refreshColors()
  for k in pairs(colors) do
    colors[k] = sightexports.sGui:getColorCode(k) or {
      255,
      255,
      255
    }
  end
  helperColor[1] = (colors["sightred-second"][1] + colors["sightpurple-second"][1]) / 2
  helperColor[2] = (colors["sightred-second"][2] + colors["sightpurple-second"][2]) / 2
  helperColor[3] = (colors["sightred-second"][3] + colors["sightpurple-second"][3]) / 2
end
local charsetTexture = {}
local currentCharset = "bebas"
function loadCharsetTexture(name)
  if isElement(charsetTexture) then
    destroyElement(charsetTexture)
  end
  local invalid = true
  if fileExists("files/charset_" .. name .. ".sight") then
    local image = fileOpen("files/charset_" .. name .. ".sight", true)
    if image then
      local data = fileRead(image, fileGetSize(image))
      fileClose(image)
      local checksum = sha256(data)
      if checksum == charsetData[name].checksum then
        invalid = false
        charsetTexture[name] = dxCreateTexture(data, "argb")
      end
    end
  end
end
addEventHandler("onClientResourceStop", getResourceRootElement(), function()
  for k in pairs(charsetData) do
    if isElement(charsetTexture[k]) then
      destroyElement(charsetTexture[k])
    end
  end
end)
for k in pairs(charsetData) do
  loadCharsetTexture(k)
  for l in pairs(charsetData[k].letters) do
    charsetData[k].letters[l] = math.ceil(charsetData[k].letters[l])
  end
end
local charset = {
  "A",
  "B",
  "C",
  "D",
  "E",
  "F",
  "G",
  "H",
  "I",
  "J",
  "K",
  "L",
  "M",
  "N",
  "O",
  "P",
  "Q",
  "R",
  "S",
  "T",
  "U",
  "V",
  "W",
  "X",
  "Y",
  "Z",
  "a",
  "b",
  "c",
  "d",
  "e",
  "f",
  "g",
  "h",
  "i",
  "j",
  "k",
  "l",
  "m",
  "n",
  "o",
  "p",
  "q",
  "r",
  "s",
  "t",
  "u",
  "v",
  "w",
  "x",
  "y",
  "z",
  "0",
  "1",
  "2",
  "3",
  "4",
  "5",
  "6",
  "7",
  "8",
  "9",
  "Á",
  "É",
  "Í",
  "Ó",
  "Ö",
  "Ő",
  "Ú",
  "Ü",
  "Ű",
  "á",
  "é",
  "í",
  "ó",
  "ö",
  "ő",
  "ú",
  "ü",
  "ű",
  "(",
  ")",
  "<",
  ">",
  "-",
  ".",
  "\226\128\162",
  ",",
  ":",
  "[",
  "]",
  "'",
  "\"",
  ";",
  "?",
  "!",
  "*",
  "/",
  "\\",
  "$",
  "&",
  "@",
  "#",
  "_",
  "\226\156\154",
  "\226\152\133",
  "\226\152\134"
}
local charsetPos = {}
for i = 1, #charset do
  charsetPos[charset[i]] = i
end
function getSpecialTextWidth(scale, text, charset)
  charset = charset or currentCharset
  local len = utf8.len(text)
  local w = 0
  for i = 1, len do
    local c = utf8.sub(text, i, i)
    if charsetPos[c] then
      w = w + charsetData[charset].letters[c] * scale
    else
      w = w + charsetData[charset].letters[" "] * scale
    end
  end
  return w
end
function drawSpecialText(x, y, scale, color, text, left, w, charset, r, wave)
  y = y - charsetSize * scale / 2
  local len = utf8.len(text)
  charset = charset or currentCharset
  if not left then
    w = w or getSpecialTextWidth(scale, text, charset)
    x = x - w / 2
  end
  local t = getTickCount() / 1000 % 1000 * math.pi
  for i = 1, len do
    local c = utf8.sub(text, i, i)
    if charsetPos[c] then
      local w = charsetData[charset].letters[c] * scale
      local wy = 0
      if wave then
        local t = getTickCount() / 150
        wy = math.sin((wave + i) * math.pi / 5 + t) * charsetSize * scale * 0.15
      end
      local col = color
      if c == "\226\156\154" then
        col = tocolor(colors.sightred[1], colors.sightred[2], colors.sightred[3])
      end
      if r then
        local sy = charsetSize * scale
        if 0 <= r then
          dxDrawImageSection(x - charsetSize * scale / 2 + w / 2, y + wy + sy * (1 - math.sin(r)), charsetSize * scale, sy * math.sin(r), 64 * (charsetPos[c] - 1), 0, charsetSize, charsetSize, charsetTexture[charset], 0, 0, 0, col)
        else
          r = math.abs(r)
          dxDrawImageSection(x - charsetSize * scale / 2 + w / 2, y + wy, charsetSize * scale, sy * math.sin(r), 64 * (charsetPos[c] - 1), 0, charsetSize, charsetSize, charsetTexture[charset], 0, 0, 0, col)
        end
      else
        dxDrawImageSection(x - charsetSize * scale / 2 + w / 2, y + wy, charsetSize * scale, charsetSize * scale, 64 * (charsetPos[c] - 1), 0, charsetSize, charsetSize, charsetTexture[charset], 0, 0, 0, col)
      end
      x = x + w
    else
      x = x + charsetData[charset].letters[" "] * scale
    end
  end
end
local showSelf = false
local globalScale = 0.85
local maximumDistance = 35
local anamesDistance = {1000, 1000}
local maxScale = 0.95
local minScale = 0.05
local nameSizeRange = {0.6, 1.05}
function getNameSize()
  return (maxScale - nameSizeRange[1]) / (nameSizeRange[2] - nameSizeRange[1]) * 100
end
function setNameSize(p)
  maxScale = nameSizeRange[1] + (nameSizeRange[2] - nameSizeRange[1]) * (p / 100)
end
local nameAlpha = 1
function getNameAlpha()
  return nameAlpha * 255
end
function setNameAlpha(p)
  nameAlpha = p / 255
end
function getNameFont()
  return currentCharset == "bebas" and "Betűtípus #1" or "Betűtípus #2"
end
function setNameFont(p)
  currentCharset = p == "Betűtípus #1" and "bebas" or "ubuntu"
end
local namesData = {}
local namesList = {}
local afkStart = {}
local animStart = {}
function helperLevelData(dat)
  if dat and 0 < dat then
    local text = dat == 1 and " (Ideiglenes Adminsegéd)" or " (S.G.H. Adminsegéd)"
    return {text, 0}
  else
    return false
  end
end
function adminDutyData(el, dat)
  if dat then
    local lvl = getElementData(el, "acc.adminLevel") or 1
    local color = "sightgreen"
    local text = " (Admin " .. lvl .. ")"
    local name = getElementData(el, "acc.adminNick") or getElementData(el, "visibleName") or getPlayerName(el)
    if lvl == 11 then
      color = "sightred"
      text = "(Tulajdonos)"
    elseif lvl == 10 then
      color = "sightblue"
      text = "</Fejlesztő>"
    elseif lvl == 9 then
      color = "sightblue-second"
      text = "(Rendszergazda)"
    elseif lvl == 8 then
      color = "sightgreen-second"
      text = "(Manager)"
    elseif lvl == 7 then
      color = "sightorange"
      text = "(SzuperAdmin)"
    elseif lvl == 6 then
      color = "sightyellow"
      text = "(FőAdmin)"
    end
    return {
      text,
      color,
      name,
      0,
      8 <= lvl
    }
  else
    return false
  end
end
function refreshElementNameData(el, elType, data)
  elType = elType or getElementType(el)
  if data and namesData[el] then
    for k, v in pairs(data) do
      namesData[el][k] = v
    end
  else
    data = data or {}
    if elType == "player" then
      namesData[el] = {
        visibleName = data.visibleName or getElementData(el, "visibleName") or getPlayerName(el),
        playerID = data.playerID or getElementData(el, "playerID"),
        tazed = data.tazed or getElementData(el, "tazed"),
        visibleWeapon = data.visibleWeapon or getElementData(el, "visibleWeapon"),
        usingArmor = data.usingArmor or getElementData(el, "usingArmor"),
        deathTag = data.deathTag or getElementData(el, "deathTag"),
        helperLevel = data.helperLevel or helperLevelData(getElementData(el, "acc.helperLevel")),
        facePaint = data.facePaint or getElementData(el, "facePaint"),
        cuffed = data.cuffed or getElementData(el, "cuffed"),
        dashboardState = data.dashboardState or getElementData(el, "dashboardState"),
        inventoryState = data.inventoryState or getElementData(el, "inventoryState"),
        badgeData = data.badgeData or getElementData(el, "badgeData"),
        badgeExData = data.badgeExData or getElementData(el, "badgeExData"),
        adminDuty = data.adminDuty or adminDutyData(el, getElementData(el, "adminDuty")),
        lastRespawn = data.lastRespawn or getElementData(el, "lastRespawn"),
        playerGlueState = data.playerGlueState or getElementData(el, "playerGlueState"),
        bloodDamage = data.bloodDamage or getElementData(el, "bloodDamage"),
        seatBelt = data.seatBelt or getElementData(el, "seatBelt"),
        chat = data.chat,
        console = data.console,
        health = getElementHealth(el),
        type = "player",
        bubbles = {},
        adrenaline = getElementData(el, "adrenaline") or false,
		    airsoft = getElementData(el, "airsoftColor") or data.airsoft
      }
      if getElementData(el, "afk") then
        local time = afkStart[el] or getTickCount() - (getElementData(el, "afkMinutes") or 0) * 60 * 1000
        afkStart[el] = time
        namesData[el].afkTimer = {
          time,
          "0",
          "0",
          ":",
          "0",
          "0",
          ":",
          "0",
          "0"
        }
      end
      if 0 < (getElementData(el, "inAnimTime") or 0) then
        local time = animStart[el] or getTickCount() - (getElementData(el, "inAnimTime") or 0)
        animStart[el] = time
        namesData[el].animTimer = {
          time,
          "0",
          "0",
          ":",
          "1",
          "0",
          ":",
          "0",
          "0"
        }
      end
    elseif elType == "ped" then
      namesData[el] = {
        visibleName = data.visibleName or getElementData(el, "visibleName"),
        pedNameType = data.pedNameType or getElementData(el, "pedNameType"),
        petType = data.petType or getElementData(el, "petType"),
        deathPed = data.deathPed or getElementData(el, "deathPed"),
        type = "ped"
      }
    end
  end
  if namesData[el] and namesData[el].cuffed and not tonumber(namesData[el].cuffed) then
    namesData[el].cuffed = getTickCount()
  end
  if namesData[el] and namesData[el].dashboardState and not tonumber(namesData[el].dashboardState) then
    namesData[el].dashboardState = getTickCount()
  end
  if namesData[el] and namesData[el].inventoryState and not tonumber(namesData[el].inventoryState) then
    namesData[el].inventoryState = getTickCount()
  end
  if namesData[el] and namesData[el].visibleName then
    namesData[el].visibleName = utf8.gsub(namesData[el].visibleName, "_", " ")
  end
end
addEvent("syncChatState", true)
addEventHandler("syncChatState", getRootElement(), function(state)
  if isElement(source) and (source ~= localPlayer or showSelf) and isElementStreamedIn(source) then
    local hc = false
    if not state and (not namesData[el] or namesData[el].console) then
      hc = getTickCount()
    end
    refreshElementNameData(source, "player", {
      chat = state and getTickCount(),
      hideChat = hc
    })
  end
end)
addEvent("syncConsoleState", true)
addEventHandler("syncConsoleState", getRootElement(), function(state)
  if isElement(source) and (source ~= localPlayer or showSelf) and isElementStreamedIn(source) then
    local hc = false
    if not state and (not namesData[el] or namesData[el].console) then
      hc = getTickCount()
    end
    refreshElementNameData(source, "player", {
      console = state and getTickCount(),
      hideConsole = hc
    })
  end
end)
local anamesState = 0
function getPlayerAfkStart(el)
  return afkStart[el]
end
function setVoiceState(el, state)
  if namesData[el] then
    namesData[el].voice = state
  end
end
function dataChangeHandler(data, old, new)
  new = new or false
  local elType = getElementType(source)
  if (source ~= localPlayer or showSelf) and (elType == "player" or elType == "ped") then
    if data == "inAnimTime" then
      if new and 0 < new then
        animStart[source] = getTickCount() - new
      else
        animStart[source] = false
      end
    elseif data == "afk" then
      afkStart[source] = new and getTickCount() - (getElementData(source, "afkMinutes") or 0) * 60 * 1000 or false
    elseif data == "afkMinutes" then
      afkStart[source] = new and getTickCount() - (getElementData(source, "afkMinutes") or 0) * 60 * 1000 or false
    end
    if isElementStreamedIn(source) then
      if data == "visibleName" then
        if new and not namesData[source] then
          for i = 1, #namesList do
            if namesList[i] == source then
              return
            end
          end
          table.insert(namesList, source)
        end
        refreshElementNameData(source, elType, {visibleName = new})
      elseif data == "pedNameType" then
        refreshElementNameData(source, elType, {pedNameType = new})
      elseif data == "petType" then
        refreshElementNameData(source, elType, {petType = new})
      elseif data == "playerID" then
        refreshElementNameData(source, elType, {playerID = new})
      elseif data == "facePaint" then
        refreshElementNameData(source, elType, {facePaint = new})
      elseif data == "tazed" then
        refreshElementNameData(source, elType, {tazed = new})
      elseif data == "visibleWeapon" then
        refreshElementNameData(source, elType, {visibleWeapon = new})
      elseif data == "usingArmor" then
        refreshElementNameData(source, elType, {usingArmor = new})
      elseif data == "acc.helperLevel" then
        refreshElementNameData(source, elType, {
          helperLevel = helperLevelData(new)
        })
      elseif data == "deathTag" then
        refreshElementNameData(source, elType, {deathTag = new})
      elseif data == "cuffed" then
        if not new and old then
          refreshElementNameData(source, elType, {
            cuffedOff = getTickCount(),
            cuffed = new
          })
        else
          refreshElementNameData(source, elType, {cuffed = new})
        end
      elseif data == "acc.adminLevel" then
        if namesData[source] and namesData[source].adminDuty then
          refreshElementNameData(source, elType, {
            adminDuty = adminDutyData(source, true)
          })
        end
      elseif data == "adminDuty" then
        refreshElementNameData(source, elType, {
          adminDuty = adminDutyData(source, new)
        })
      elseif data == "deathPed" then
        refreshElementNameData(source, elType, {deathPed = new})
      elseif data == "dashboardState" then
        if not new and old then
          refreshElementNameData(source, elType, {
            dashboardOff = getTickCount(),
            dashboardState = new
          })
        else
          refreshElementNameData(source, elType, {dashboardState = new})
        end
      elseif data == "inventoryState" then
        if not new and old then
          refreshElementNameData(source, elType, {
            inventoryOff = getTickCount(),
            inventoryState = new
          })
        else
          refreshElementNameData(source, elType, {inventoryState = new})
        end
      elseif data == "acc.adminNick" then
        if namesData[source] and namesData[source].adminDuty then
          refreshElementNameData(source, elType, {
            adminDuty = adminDutyData(source, new)
          })
        end
      elseif data == "lastRespawn" then
        refreshElementNameData(source, elType, {lastRespawn = new})
      elseif data == "badgeData" then
        refreshElementNameData(source, elType, {badgeData = new})
      elseif data == "badgeExData" then
        refreshElementNameData(source, elType, {badgeExData = new})
      elseif data == "playerGlueState" then
        refreshElementNameData(source, elType, {playerGlueState = new})
      elseif data == "seatBelt" then
        refreshElementNameData(source, elType, {seatBelt = new})
      elseif data == "bloodDamage" then
        refreshElementNameData(source, elType, {bloodDamage = new})
      elseif data == "inAnimTime" then
        if new and 0 < new then
          refreshElementNameData(source, elType, {
            animTimer = {
              animStart[source],
              "0",
              "0",
              ":",
              "1",
              "0",
              ":",
              "0",
              "0"
            }
          })
        else
          refreshElementNameData(source, elType, {animTimer = false})
        end
      elseif data == "afk" then
        if new then
          refreshElementNameData(source, elType, {
            afkTimer = {
              afkStart[source],
              "0",
              "0",
              ":",
              "0",
              "0",
              ":",
              "0",
              "0"
            }
          })
        else
          refreshElementNameData(source, elType, {afkTimer = false})
        end
      elseif data == "adrenaline" then
        refreshElementNameData(source, elType, {adrenaline = new})
      end
    end
  end
end
addEventHandler("onClientPlayerDataChange", getRootElement(), dataChangeHandler)
addEventHandler("onClientPedDataChange", getRootElement(), dataChangeHandler)
addEventHandler("onClientElementDataChange", getRootElement(), dataChangeHandler)
addEventHandler("onClientElementStreamIn", getRootElement(), function()
  local elType = getElementType(source)
  if (source ~= localPlayer or showSelf) and (elType == "player" or elType == "ped") then
    local visibleName = getElementData(source, "visibleName")
    if elType == "player" or elType == "ped" and visibleName then
      refreshElementNameData(source, elType, {visibleName = visibleName})
      for i = 1, #namesList do
        if namesList[i] == source then
          return
        end
      end
      table.insert(namesList, source)
    end
  end
end)
addEventHandler("onClientElementStreamOut", getRootElement(), function()
  local elType = getElementType(source)
  if (source ~= localPlayer or showSelf) and (elType == "player" or elType == "ped") then
    for i = 1, #namesList do
      if namesList[i] == source then
        table.remove(namesList, i)
        break
      end
    end
    namesData[source] = nil
  end
end)
addEventHandler("onClientPedDestroy", getRootElement(), function()
  for i = 1, #namesList do
    if namesList[i] == source then
      table.remove(namesList, i)
      break
    end
  end
  namesData[source] = nil
end)
addEventHandler("onClientPlayerQuit", getRootElement(), function()
  for i = 1, #namesList do
    if namesList[i] == source then
      table.remove(namesList, i)
      break
    end
  end
  namesData[source] = nil
  afkStart[source] = nil
end)
addEventHandler("onClientResourceStart", getResourceRootElement(), function()
  local players = getElementsByType("player", getRootElement(), true)
  for i = 1, #players do
    local player = players[i]
    if player and isElementStreamedIn(player) and (player ~= localPlayer or showSelf) then
      table.insert(namesList, player)
      refreshElementNameData(player, "player")
    end
  end
  local peds = getElementsByType("ped", getRootElement(), true)
  for i = 1, #peds do
    local ped = peds[i]
    if ped and isElementStreamedIn(ped) and getElementData(ped, "visibleName") then
      table.insert(namesList, ped)
      refreshElementNameData(ped, "ped")
    end
  end
end)
local bowAnim = {}
addEvent("npcChatBubble", true)
addEventHandler("npcChatBubble", getRootElement(), function(theType, text)
  if isElement(source) and (source ~= localPlayer or showSelf) and isElementStreamedIn(source) and namesData[source] then
    local x, y, z = getElementPosition(source)
    local px, py, pz = getElementPosition(localPlayer)
    local d = getDistanceBetweenPoints3D(x, y, z, px, py, pz)
    if d <= 12 then
      local color = 255
      color = 50 + 205 * (1 - d / 12)
      outputChatBox(namesData[source].visibleName .. " mondja: " .. text, color, color, color)
      if not namesData[source].bubbles then
        namesData[source].bubbles = {}
      end
      table.insert(namesData[source].bubbles, {
        getTickCount(),
        text,
        theType
      })
    end
  end
end)
addEvent("chatBubble", true)
addEventHandler("chatBubble", getRootElement(), function(theType, text)
  if isElement(source) and (source ~= localPlayer or showSelf) and isElementStreamedIn(source) and namesData[source] then
    for i = #namesData[source].bubbles, 1, -1 do
      if namesData[source].bubbles[i][3] == theType and namesData[source].bubbles[i][2] == text then
        table.remove(namesData[source].bubbles, i)
      end
    end
    if #namesData[source].bubbles >= 5 then
      table.remove(namesData[source].bubbles, 1)
    end
    table.insert(namesData[source].bubbles, {
      getTickCount(),
      text,
      theType
    })
  end
end)
local currentChatState = false
local currentConsoleState = false
function dxDrawLine2(x, y, x2, y2, r, g, b, a)
  dxDrawLine(x + 1, y + 1, x2 + 1, y2 + 1, tocolor(0, 0, 0, a * 0.75))
  dxDrawLine(x, y, x2, y2, tocolor(r, g, b, a))
end
function dxDrawLineEx(p, x, y, x2, y2, r, g, b, a)
  if x <= p and p <= x2 then
    local pr = (p - x) / (x2 - x)
    dxDrawLine2(x, y, x + (x2 - x) * pr, y + (y2 - y) * pr, r, g, b, a)
    dxDrawLine2(x, y, x + (x2 - x) * (1 - pr), y + (y2 - y) * (1 - pr), r, g, b, a * 0.25)
    return y + (y2 - y) * pr
  elseif x2 <= p then
    dxDrawLine2(x, y, x2, y2, r, g, b, a)
  elseif p <= x then
    dxDrawLine2(x, y, x2, y2, r, g, b, a * 0.25)
  end
end
addEventHandler("onClientElementDataChange", localPlayer, function(dataName, oldValue, newValue)
  if dataName == "anamesState" then
    anamesState = newValue or 0
  end
end)
local tick = getTickCount()
function dxDrawRectangleEx(x, y, w, h, col, a)
  dxDrawRectangle(x + 2 + 1, y + 2 + 1, w - 4, h - 4, tocolor(0, 0, 0, a))
  dxDrawRectangle(x + 2, y + 2, w - 4, h - 4, col)
end
local squadSigns = {}
function setVehicleSquad(veh, color, name)
  for i = #squadSigns, 1, -1 do
    if squadSigns[i][1] == veh then
      table.remove(squadSigns, i)
    end
  end
  if color and name then
    table.insert(squadSigns, {
      veh,
      color,
      name
    })
  end
end
local showSquadSigns = true
function setSquadsVisible(val)
  showSquadSigns = val
  sightlangCondHandl0(showSquadSigns)
end
function getSquadsVisible()
  return showSquadSigns
end
addEventHandler("onClientPreRender", getRootElement(), function()
  local state = isChatBoxInputActive()
  if state ~= currentChatState then
    currentChatState = state
    local players = getElementsByType("player", getRootElement(), true)
    --if 1 < #players then
      triggerServerEvent("syncChatState", localPlayer, players, state)
    --end
  end
  state = isConsoleActive()
  if state ~= currentConsoleState then
    currentConsoleState = state
    local players = getElementsByType("player", getRootElement(), true)
    --if 1 < #players then
      triggerServerEvent("syncConsoleState", localPlayer, players, state)
    --end
  end
end)
function renderSquadSigns()
  local camX, camY, camZ = getCameraMatrix()
  for i = #squadSigns, 1, -1 do
    local veh = squadSigns[i][1]
    if isElement(veh) then
      if isElementStreamedIn(veh) and isElementOnScreen(veh) then
        local m = getElementMatrix(veh)
        if m then
          local x, y, z = m[4][1], m[4][2], m[4][3]
          local px, py, pz = getVehicleComponentPosition(veh, "bump_rear_dummy")
          if px then
            x = x + m[2][1] * py + m[1][1] * px
            y = y + m[2][2] * py + m[1][2] * px
            z = z + m[2][3] * py + m[1][3] * px
          end
          local currentDistance = getDistanceBetweenPoints3D(camX, camY, camZ, x, y, z)
          if currentDistance <= maximumDistance then
            local sx, sy = getScreenFromWorldPosition(x, y, z, 512)
            local clear = isLineOfSightClear(camX, camY, camZ, x, y, z, true, true, false, true, false, true, false, veh)
            if sx and clear then
              local p = currentDistance / maximumDistance
              local scale = minScale + (maxScale - minScale) * (1 - p)
              scale = scale * globalScale * 1.1
              local col = "sight" .. squadSigns[i][2]
              local a = 1
              if 0.55 < p then
                a = 1 - (p - 0.55) / 0.44999999999999996
              end
              a = a * nameAlpha
              drawSpecialText(sx, sy, scale, tocolor(colors[col][1], colors[col][2], colors[col][3], 200 * a), squadSigns[i][3])
            end
          end
        end
      end
    else
      table.remove(squadSigns, i)
    end
  end
end
local showItems = {}
function updateItemShowList(list)
  if list then
    for i = 1, #list do
      local t = 0
      if showItems[list[i][1]] then
        t = showItems[list[i][1]][2]
      end
      showItems[list[i][1]] = {
        list[i][4],
        t
      }
    end
  end
end
function checkSpeed(el)
  local x, y, z = getElementVelocity(el)
  if x ^ 2 + y ^ 2 + z ^ 2 > 1.0E-4 then
    return true
  end
  local veh = getPedOccupiedVehicle(el)
  if veh then
    local x, y, z = getElementVelocity(veh)
    local speed = math.sqrt(x ^ 2 + y ^ 2 + z ^ 2)
    if speed * 180 * 1.1 > 1 then
      return true
    end
  end
  return false
end
function renderNametag()
  local now = getTickCount()
  local camX, camY, camZ, lookX, lookY, lookZ = getCameraMatrix()
  local localX, localY, localZ = getElementPosition(localPlayer)
  local delta = now - tick
  tick = now
  for i = 1, #namesList do
    local el = namesList[i]
    local data = namesData[el]
    if isElement(el) and data then
      local x, y, z = getPedBonePosition(el, 5)
      if not (x and y) or not z then
        x, y, z = 0, 0, 0
      end
      if x ~= x or y ~= y or z ~= z then
        x, y, z = 0, 0, 0
      end
      z = z + 0.325
      local currentDistance = getDistanceBetweenPoints3D(camX, camY, camZ, x, y, z)
      local maxD = data.type == "player" and 0 < anamesState and anamesDistance[2] or maximumDistance
      if currentDistance <= maxD and isElementOnScreen(el) then
        local sx, sy = getScreenFromWorldPosition(x, y, z, 256)
        if sx then
          local clear = true
          if (data.type ~= "player" or anamesState < 3) and getElementAlpha(el) < 50 then
            clear = false
          end
          if (data.type ~= "player" or anamesState < 3) and clear then
            local veh = getPedOccupiedVehicle(el) or data.playerGlueState
            clear = isLineOfSightClear(camX, camY, camZ, x, y, z, true, true, false, true, false, true, false, veh)
          end
          if clear then
            local p = currentDistance / maxD
            local scale = minScale + (maxScale - minScale) * (1 - p)
            scale = scale * globalScale
            if 0 < anamesState then
              scale = scale * 0.75
            end
            if not data.adminDuty and (data.badgeData or data.facePaint or data.badgeExData) then
              sy = sy - charsetSize * 0.6 * scale
            end
            if data.helperLevel then
              sy = sy - charsetSize * 0.65 * scale
            end
            if 0 < anamesState then
              sy = sy - 20 * scale
            end
            local a = 1
            if 0.55 < p then
              a = 1 - (p - 0.55) / 0.44999999999999996
            end
            a = a * nameAlpha
            local hp = getElementHealth(el)
            if data.type == "player" then
              if hp ~= data.health then
                if hp < data.health then
                  data.hpMinus = now
                  namesData[el].hpMinus = now
                end
                namesData[el].health = hp
              end
              if data.afkTimer then
                local s = scale * 0.6
                local sec = math.max(0, math.floor((now - data.afkTimer[1]) / 1000))
                local col = 0
                if 1200 <= sec then
                  col = tocolor(colors.sightred[1], colors.sightred[2], colors.sightred[3], 200 * a)
                elseif 600 <= sec then
                  col = tocolor(colors.sightorange[1], colors.sightorange[2], colors.sightorange[3], 200 * a)
                else
                  col = 0 < hp and tocolor(colors.hudwhite[1], colors.hudwhite[2], colors.hudwhite[3], 200 * a) or tocolor(80, 80, 80, 200 * a)
                end
                local control = checkSpeed(el)
                if control then
                  if not data.afkP then
                    data.afkP = 0
                  end
                  if 1 > data.afkP then
                    data.afkP = data.afkP + delta / 250
                    if 1 < data.afkP then
                      data.afkP = 1
                    end
                  end
                elseif data.afkP and 0 < data.afkP then
                  data.afkP = data.afkP - delta / 250
                  if 0 > data.afkP then
                    data.afkP = 0
                  end
                end
                local ip = data.afkP or 0
                local ims = 128 * s
                local imy = sy - charsetSize * 0.8 * scale - ims
                local imx = sx - ims
                local w = getSpecialTextWidth(s, "0")
                if 0 < ip then
                  ims = ims + (charsetSize / 2 * scale - ims) * ip
                  imy = imy + (sy - charsetSize * 0.6 * scale - ims / 2 - imy) * ip
                  imx = sx - ims * (1 - ip) - (w * 4 + charsetSize / 2 * scale * 1.25) * ip
                end
                sightlangStaticImageUsed[0] = true
                if sightlangStaticImageToc[0] then
                  processsightlangStaticImage[0]()
                end
                dxDrawImage(imx, imy, ims * 2, ims, sightlangStaticImage[0], 0, 0, 0, col)
                s = scale * 0.8
                min = math.floor(sec / 60)
                sec = sec - 60 * min
                hour = math.floor(min / 60)
                min = min - 60 * hour
                local text = string.format("%02d:%02d:%02d", hour, min, sec)
                local cw = charsetData[currentCharset].letters["0"] * s
                local sx = sx - w * 8 / 2
                if 0 < ip then
                  sx = sx + charsetSize / 2 * scale * 1.25 * ip / 2
                end
                for i = 1, 8 do
                  local c = utf8.sub(text, i, i)
                  local old = type(data.afkTimer[1 + i]) == "table" and data.afkTimer[1 + i][2] or data.afkTimer[1 + i]
                  if old ~= c then
                    data.afkTimer[1 + i] = {
                      old,
                      c,
                      now
                    }
                  end
                  local dat = data.afkTimer[1 + i]
                  if type(dat) == "table" then
                    local p = (now - dat[3]) / 500
                    if 1 <= p then
                      p = 1
                    end
                    p = p * 2
                    local tw = cw - charsetData[currentCharset].letters[dat[1]] * s
                    local r = math.rad(90 - 90 * math.min(1, p))
                    drawSpecialText(sx + tw / 2, sy - charsetSize * 0.6 * scale, s, col, dat[1], true, false, false, r)
                    p = p - 1
                    local tw = cw - charsetData[currentCharset].letters[dat[2]] * s
                    local r = math.rad(90 * math.max(0, p))
                    drawSpecialText(sx + tw / 2, sy - charsetSize * 0.6 * scale, s, col, dat[2], true, false, false, -r)
                    if 1 <= p then
                      data.afkTimer[1 + i] = dat[2]
                    end
                  else
                    local tw = cw - charsetData[currentCharset].letters[c] * s
                    drawSpecialText(sx + tw / 2, sy - charsetSize * 0.6 * scale, s, col, c, true, false, false, r)
                  end
                  sx = sx + w
                end
              else
                local animY = 0
                if hp <= 0 then
                  local p = now % 4900 / 700
                  local s = scale * 0.4
                  animY = charsetSize * 0.6 * scale + 256 * s
                  local p1 = math.min(0.5, p) / 0.5
                  local p2 = getEasingValue(math.min(1, p), "OutBounce", 0.4, 0.5)
                  sightlangStaticImageUsed[1] = true
                  if sightlangStaticImageToc[1] then
                    processsightlangStaticImage[1]()
                  end
                  dxDrawImage(sx - 128 * s, sy - charsetSize * 0.6 * scale - 256 * s * (4 - p2 * 3), 256 * s, 256 * s, sightlangStaticImage[1], 0, 0, 0, tocolor(80, 80, 80, 200 * a * p1))
                  sightlangStaticImageUsed[2] = true
                  if sightlangStaticImageToc[2] then
                    processsightlangStaticImage[2]()
                  end
                  dxDrawImage(sx - 128 * s, sy - charsetSize * 0.6 * scale - 256 * s, 256 * s, 256 * s, sightlangStaticImage[2], 0, 0, 0, tocolor(80, 80, 80, 200 * a))
                  local cw = 10 * s
                  local ch = 70 * s
                  local cw2 = ch * 0.6
                  local p3 = math.max(0, math.min(1, (p - 1) / 0.35))
                  local p4 = math.max(0, math.min(1, (p - 1.5) / 0.35))
                  dxDrawRectangle(sx - cw / 2 + 1, sy - charsetSize * 0.6 * scale - 128 * s - ch / 2 + 1, cw, ch * p3, tocolor(0, 0, 0, 125 * a))
                  dxDrawRectangle(sx - cw2 / 2 + 1, sy - charsetSize * 0.6 * scale - 128 * s - ch / 2 + ch * 0.3 - cw / 2 + 1, cw2 * p4, cw, tocolor(0, 0, 0, 125 * a))
                  dxDrawRectangle(sx - cw / 2, sy - charsetSize * 0.6 * scale - 128 * s - ch / 2, cw, ch * p3, tocolor(80, 80, 80, 255 * a))
                  dxDrawRectangle(sx - cw2 / 2, sy - charsetSize * 0.6 * scale - 128 * s - ch / 2 + ch * 0.3 - cw / 2, cw2 * p4, cw, tocolor(80, 80, 80, 255 * a))
                elseif showItems[el] then
                  local p = 1
                  showItems[el][2] = showItems[el][2] + delta / 1000
                  if 5 < showItems[el][2] then
                    p = 1 - (showItems[el][2] - 5) / 0.5
                  elseif showItems[el][2] < 0.5 then
                    p = showItems[el][2] / 0.5
                  end
                  if p < 0 then
                    showItems[el] = nil
                  elseif not isElement(showItems[el][1]) then
                    showItems[el] = nil
                  elseif 0 < p then
                    local s = scale * 1.25
                    animY = 132 * s
                    dxDrawImage(sx - 512 * s / 2, sy - 132 * s, 512 * s, 132 * s, showItems[el][1], 0, 0, 0, tocolor(255, 255, 255, 230 * a * p))
                  end
                elseif data.dashboardState or data.dashboardOff then
                  local p = math.min(1, (getTickCount() - (data.dashboardState or data.dashboardOff)) / 1000)
                  animY = charsetSize * 0.55 * scale + 110 * scale
                  if not data.dashboardState then
                    p = 1 - p
                    if p <= 0 then
                      namesData[el].dashboardOff = nil
                    end
                  end
                  local w = 110 * scale / 6
                  local h = 64 * scale / 4
                  local x = sx - 110 * scale / 2
                  local y = sy - charsetSize * 0.55 * scale - 64 * scale
                  if p < 1 then
                    local r, g, b = colors.hudwhite[1], colors.hudwhite[2], colors.hudwhite[3]
                    p = p * 4
                    local p2 = 0
                    p2 = math.min(1, math.max(0, p))
                    dxDrawRectangleEx(x, y + h - 32 * scale * (1 - p2), w * 2, h, tocolor(r, g, b, 225 * a * p2), 125 * a * p2)
                    p = p - 1
                    p2 = math.min(1, math.max(0, p))
                    dxDrawRectangleEx(x, y - 32 * scale * (1 - p2), w * 2, h, tocolor(r, g, b, 225 * a * p2), 125 * a * p2)
                    p = p - 1
                    p2 = math.min(1, math.max(0, p))
                    dxDrawRectangleEx(x + w * 2, y - 32 * scale * (1 - p2), w * 2, h * 2, tocolor(r, g, b, 225 * a * p2), 125 * a * p2)
                    p = p - 1
                    p2 = math.min(1, math.max(0, p))
                    dxDrawRectangleEx(x + w * 4, y - 32 * scale * (1 - p2), w * 2, h * 2, tocolor(r, g, b, 225 * a * p2), 125 * a * p2)
                    p = (p + 3) / 4
                    p = p * 6
                    p2 = math.min(1, math.max(0, p))
                    dxDrawRectangleEx(x, y + h * 2 + 32 * scale * (1 - p2), w, h, tocolor(255, 255, 255, 225 * a * p2), 125 * a * p2)
                    p = p - 1
                    p2 = math.min(1, math.max(0, p))
                    dxDrawRectangleEx(x + w, y + h * 2 + 32 * scale * (1 - p2), w, h, tocolor(255, 255, 255, 225 * a * p2), 125 * a * p2)
                    p = p - 1
                    p2 = math.min(1, math.max(0, p))
                    dxDrawRectangleEx(x, y + h * 3 + 32 * scale * (1 - p2), w * 2, h, tocolor(255, 255, 255, 225 * a * p2), 125 * a * p2)
                    p = p - 1
                    p2 = math.min(1, math.max(0, p))
                    dxDrawRectangleEx(x + w * 2, y + h * 2 + 32 * scale * (1 - p2), w * 2, h * 2, tocolor(255, 255, 255, 225 * a * p2), 125 * a * p2)
                    p = p - 1
                    p2 = math.min(1, math.max(0, p))
                    dxDrawRectangleEx(x + w * 4, y + h * 2 + 32 * scale * (1 - p2), w * 2, h, tocolor(255, 255, 255, 225 * a * p2), 125 * a * p2)
                    p = p - 1
                    p2 = math.min(1, math.max(0, p))
                    dxDrawRectangleEx(x + w * 4, y + h * 3 + 32 * scale * (1 - p2), w * 2, h, tocolor(255, 255, 255, 225 * a * p2), 125 * a * p2)
                  else
                    local col = tocolor(colors.hudwhite[1], colors.hudwhite[2], colors.hudwhite[3], 225 * a)
                    dxDrawRectangleEx(x, y, w * 2, h, col, 125 * a * p)
                    dxDrawRectangleEx(x, y + h, w * 2, h, col, 125 * a * p)
                    dxDrawRectangleEx(x + w * 2, y, w * 2, h * 2, col, 125 * a * p)
                    dxDrawRectangleEx(x + w * 4, y, w * 2, h * 2, col, 125 * a * p)
                    dxDrawRectangleEx(x + w * 2, y + h * 2, w * 2, h * 2, col, 125 * a * p)
                    dxDrawRectangleEx(x, y + h * 2, w, h, col, 125 * a * p)
                    dxDrawRectangleEx(x + w, y + h * 2, w, h, col, 125 * a * p)
                    dxDrawRectangleEx(x, y + h * 3, w * 2, h, col, 125 * a * p)
                    dxDrawRectangleEx(x + w * 4, y + h * 2, w * 2, h, col, 125 * a * p)
                    dxDrawRectangleEx(x + w * 4, y + h * 3, w * 2, h, col, 125 * a * p)
                  end
                elseif data.adminDuty then
                  local s = scale * 0.4
                  animY = (data.adminDuty[5] and 350 or 384) * s
                  local control = checkSpeed(el)
                  if not control then
                    if 1 > data.adminDuty[4] then
                      data.adminDuty[4] = data.adminDuty[4] + delta / 650
                      if 1 < data.adminDuty[4] then
                        data.adminDuty[4] = 1
                      end
                    end
                  elseif 0 < data.adminDuty[4] then
                    data.adminDuty[4] = data.adminDuty[4] - delta / 650
                    if 0 > data.adminDuty[4] then
                      data.adminDuty[4] = 0
                    end
                  end
                  local p = data.adminDuty[4]
                  animY = animY * p
                  local col = data.adminDuty[2]
                  sightlangStaticImageUsed[7] = true
                  if sightlangStaticImageToc[7] then
                    processsightlangStaticImage[7]()
                  end
                  
                  local colorTable = {colors[col][1] / 255, colors[col][2] / 255, colors[col][3] / 255}
                  if not setAdminValue[colorTable] then
                    dxSetShaderValue(shader, "logoColor", colors[col][1] / 255, colors[col][2] / 255, colors[col][3] / 255, (255 * a * p) / 255)
                    setAdminValue[colorTable] = true
                  end

                  dxDrawImage(sx - 256 * s, sy - charsetSize * 0.225 * scale - 402 * s, 512 * s, 512 * s, shader, 0, 0, 0)
                elseif data.animTimer and 0 < hp then
                  local s = scale * 0.6
                  local pin = now - data.animTimer[1]
                  local maxAnimTime = data.adrenaline and 15 or 10
                  local sec = maxAnimTime * 60 - math.floor(pin / 1000)
                  if sec < 0 then
                    sec = 0
                  end
                  local col = 0
                  sightlangStaticImageUsed[10] = true
                  if sightlangStaticImageToc[10] then
                    processsightlangStaticImage[10]()
                  end
                  s = scale * 0.8
                  local w = getSpecialTextWidth(s, "0")
                  local cw = charsetData[currentCharset].letters["0"] * s
                  if sec <= 120 then
                    col = tocolor(colors.sightred[1], colors.sightred[2], colors.sightred[3], 200 * a)
                  elseif sec <= 240 then
                    col = tocolor(colors.sightorange[1], colors.sightorange[2], colors.sightorange[3], 200 * a)
                  else
                    col = tocolor(colors.hudwhite[1], colors.hudwhite[2], colors.hudwhite[3], 200 * a)
                  end
                  local ey = 30 * scale
                  local ew = w * 0.5
                  local y = sy - charsetSize * 0.8 * scale - ey * 1.35
                  animY = ey * 2 + charsetSize * 0.8 * scale
                  if sec <= 240 then
                    ey = 30 * scale * (sec / 240)
                  end
                  local p = sx - ew * 10 + pin % 2000 / 2000 * ew * 20
                  local ly = y
                  local ny = dxDrawLineEx(p, sx - ew * 5 - ew * 5, y, sx - ew * 5 - ew * 2, y, colors.sightred[1], colors.sightred[2], colors.sightred[3], 200 * a)
                  ly = ny or ly
                  local ny = dxDrawLineEx(p, sx - ew * 5 - ew * 2, y, sx - ew * 5 - ew, y - ey, colors.sightred[1], colors.sightred[2], colors.sightred[3], 200 * a)
                  ly = ny or ly
                  local ny = dxDrawLineEx(p, sx - ew * 5 - ew, y - ey, sx - ew * 5 + ew * 0.7, y + ey * 0.5, colors.sightred[1], colors.sightred[2], colors.sightred[3], 200 * a)
                  ly = ny or ly
                  local ny = dxDrawLineEx(p, sx - ew * 5 + ew * 0.7, y + ey * 0.5, sx - ew * 5 + ew * 1.4, y, colors.sightred[1], colors.sightred[2], colors.sightred[3], 200 * a)
                  ly = ny or ly
                  local ny = dxDrawLineEx(p, sx - ew * 5 + ew * 1.4, y, sx - ew * 5 + ew * 5, y, colors.sightred[1], colors.sightred[2], colors.sightred[3], 200 * a)
                  ly = ny or ly
                  local ny = dxDrawLineEx(p, sx + ew * 5 - ew * 5, y, sx + ew * 5 - ew * 2, y, colors.sightred[1], colors.sightred[2], colors.sightred[3], 200 * a)
                  ly = ny or ly
                  local ny = dxDrawLineEx(p, sx + ew * 5 - ew * 2, y, sx + ew * 5 - ew, y - ey, colors.sightred[1], colors.sightred[2], colors.sightred[3], 200 * a)
                  ly = ny or ly
                  local ny = dxDrawLineEx(p, sx + ew * 5 - ew, y - ey, sx + ew * 5 + ew * 0.7, y + ey * 0.5, colors.sightred[1], colors.sightred[2], colors.sightred[3], 200 * a)
                  ly = ny or ly
                  local ny = dxDrawLineEx(p, sx + ew * 5 + ew * 0.7, y + ey * 0.5, sx + ew * 5 + ew * 1.4, y, colors.sightred[1], colors.sightred[2], colors.sightred[3], 200 * a)
                  ly = ny or ly
                  local ny = dxDrawLineEx(p, sx + ew * 5 + ew * 1.4, y, sx + ew * 5 + ew * 5, y, colors.sightred[1], colors.sightred[2], colors.sightred[3], 200 * a)
                  ly = ny or ly
                  dxDrawRectangle(p - 2 + 1, ly - 2 + 1, 4, 4, tocolor(0, 0, 0, 150 * a))
                  dxDrawRectangle(p - 2, ly - 2, 4, 4, tocolor(colors.sightred[1], colors.sightred[2], colors.sightred[3], 200 * a))
                  min = math.floor(sec / 60)
                  sec = sec - 60 * min
                  hour = math.floor(min / 60)
                  min = min - 60 * hour
                  local text = string.format("%02d:%02d:%02d", hour, min, sec)
                  local sx = sx - w * 8 / 2
                  for i = 1, 8 do
                    local c = utf8.sub(text, i, i)
                    local old = type(data.animTimer[1 + i]) == "table" and data.animTimer[1 + i][2] or data.animTimer[1 + i]
                    if old ~= c then
                      data.animTimer[1 + i] = {
                        old,
                        c,
                        now
                      }
                    end
                    local dat = data.animTimer[1 + i]
                    if type(dat) == "table" then
                      local p = (now - dat[3]) / 500
                      if 1 <= p then
                        p = 1
                      end
                      p = p * 2
                      local tw = cw - charsetData[currentCharset].letters[dat[1]] * s
                      local r = math.rad(90 - 90 * math.min(1, p))
                      drawSpecialText(sx + tw / 2, sy - charsetSize * 0.6 * scale, s, col, dat[1], true, false, false, r)
                      p = p - 1
                      local tw = cw - charsetData[currentCharset].letters[dat[2]] * s
                      local r = math.rad(90 * math.max(0, p))
                      drawSpecialText(sx + tw / 2, sy - charsetSize * 0.6 * scale, s, col, dat[2], true, false, false, -r)
                      if 1 <= p then
                        data.animTimer[1 + i] = dat[2]
                      end
                    else
                      local tw = cw - charsetData[currentCharset].letters[c] * s
                      drawSpecialText(sx + tw / 2, sy - charsetSize * 0.6 * scale, s, col, c, true, false, false, r)
                    end
                    sx = sx + w
                  end
                elseif data.inventoryState or data.inventoryOff then
                  local p = math.min(1, (getTickCount() - (data.inventoryState or data.inventoryOff)) / 1000)
                  if not data.inventoryState then
                    p = 1 - p
                    if p <= 0 then
                      p = 0
                      namesData[el].inventoryOff = nil
                    end
                  end
                  if p < 1 then
                    p = getEasingValue(p, "InOutQuad")
                  end
                  local s = scale * 0.6
                  local ts = 200
                  local ty = 64
                  local p2 = math.max(0, math.min(1, p / 0.25))
                  p = math.max(0, (p - 0.25) / 0.75)
                  animY = ts * s + 32 * s
                  local a2 = math.min(1, math.abs(1 - 2 * p) / 0.25)
                  sightlangStaticImageUsed[11] = true
                  if sightlangStaticImageToc[11] then
                    processsightlangStaticImage[11]()
                  end
                  dxDrawImage(sx - ts / 2 * s, sy - ts * s - 32 * s, ts * s, ts * s, sightlangStaticImage[11], 0, 0, 0, tocolor(255, 255, 255, 225 * a * p2))
                  sightlangStaticImageUsed[12] = true
                  if sightlangStaticImageToc[12] then
                    processsightlangStaticImage[12]()
                  end
                  dxDrawImage(sx - ts / 2 * s, sy - ts / 2 * s - 32 * s - ty * s, ts * s, ty * s, sightlangStaticImage[12], 0, 0, 0, tocolor(255, 255, 255, 225 * a * p2 * p))
                  sightlangStaticImageUsed[13] = true
                  if sightlangStaticImageToc[13] then
                    processsightlangStaticImage[13]()
                  end
                  dxDrawImage(sx - ts / 2 * s, sy - ts / 2 * s - 32 * s - ty * s, ts * s, ty * s * (1 - 2 * p), sightlangStaticImage[13], 0, 0, 0, tocolor(255, 255, 255, 225 * a * p2 * a2))
                elseif data.cuffed or data.cuffedOff then
                  local p = 0
                  if data.cuffedOff then
                    p = 5 - (now - data.cuffedOff) / 200
                  else
                    p = (now - data.cuffed) / 200
                  end
                  if 5 < p then
                    p = 5
                  end
                  if p < 0 then
                    p = 0
                    namesData[el].cuffedOff = false
                  end
                  local s = scale * 0.6
                  local tx = 200
                  local ty = 162
                  local ts2 = 128
                  local p2 = math.max(0, math.min(1, p / 0.5))
                  p = p - 1.5
                  animY = ty * s - 32 * s
                  sightlangStaticImageUsed[14] = true
                  if sightlangStaticImageToc[14] then
                    processsightlangStaticImage[14]()
                  end
                  dxDrawImage(sx - tx / 2 * s - 45 * s, sy - ty * s - 32 * s + 50 * s, ts2 * s, ts2 * s, sightlangStaticImage[14], 10 - 70 * math.max(0, math.min(1, p)), 0, 0, tocolor(120, 120, 120, 225 * a * p2))
                  p = p - 2.5
                  sightlangStaticImageUsed[14] = true
                  if sightlangStaticImageToc[14] then
                    processsightlangStaticImage[14]()
                  end
                  dxDrawImage(sx + tx / 2 * s + 46 * s, sy - ty * s - 32 * s + 50 * s, -ts2 * s, ts2 * s, sightlangStaticImage[14], -10 + 70 * math.max(0, math.min(1, p)), 0, 0, tocolor(120, 120, 120, 225 * a * p2))
                  sightlangStaticImageUsed[15] = true
                  if sightlangStaticImageToc[15] then
                    processsightlangStaticImage[15]()
                  end
                  dxDrawImage(sx - tx / 2 * s, sy - ty * s - 32 * s, tx * s, ty * s, sightlangStaticImage[15], 0, 0, 0, tocolor(120, 120, 120, 225 * a * p2))
                elseif data.tazed then
                  local s = scale * 0.85
                  animY = 256 * s
                  local x = 0
                  local lx = 0
                  for i = 1, 6.75 do
                    x = math.random(-40, 40) / 10 * s
                    dxDrawLine(sx - 128 * s + 188 * s + lx, sy - 256 * s + 80 * s + (i - 1) * 4 * s, sx - 128 * s + 188 * s + x, sy - 256 * s + 80 * s + i * 4 * s, tocolor(colors["sightblue-second"][1], colors["sightblue-second"][2], colors["sightblue-second"][3], 175 * a))
                    lx = x
                  end
                  sightlangStaticImageUsed[16] = true
                  if sightlangStaticImageToc[16] then
                    processsightlangStaticImage[16]()
                  end
                  dxDrawImage(sx - 128 * s, sy - 256 * s, 256 * s, 256 * s, sightlangStaticImage[16], 0, 0, 0, tocolor(255, 255, 255, 175 * a))
                elseif data.lastRespawn then
                  local p = now % 4900 / 700
                  local s = scale * 0.4
                  animY = charsetSize * 0.8 * scale + 256 * s
                  local p1 = math.min(0.5, p) / 0.5
                  local p2 = getEasingValue(math.min(1, p), "OutBounce", 0.4, 0.5)
                  sightlangStaticImageUsed[17] = true
                  if sightlangStaticImageToc[17] then
                    processsightlangStaticImage[17]()
                  end
                  dxDrawImage(sx - 128 * s, sy - charsetSize * 0.8 * scale - 256 * s * (4 - p2 * 3), 256 * s, 256 * s, sightlangStaticImage[17], 0, 0, 0, tocolor(colors.sightred[1], colors.sightred[2], colors.sightred[3], 225 * a * p1))
                  local cw = 64 * s
                  local ch = 16 * s
                  local p3 = math.max(0, math.min(1, (p - 1) / 0.35))
                  local p4 = math.max(0, math.min(1, (p - 1.5) / 0.35))
                  dxDrawRectangle(sx - cw / 2 + 1, sy - charsetSize * 0.8 * scale - 256 * s + 50 * s - ch / 2 + 1, cw * p3, ch, tocolor(0, 0, 0, 125 * a))
                  dxDrawRectangle(sx - ch / 2 + 1, sy - charsetSize * 0.8 * scale - 256 * s + 50 * s - cw / 2 + 1, ch, cw * p4, tocolor(0, 0, 0, 125 * a))
                  dxDrawRectangle(sx - cw / 2, sy - charsetSize * 0.8 * scale - 256 * s + 50 * s - ch / 2, cw * p3, ch, tocolor(colors.sightred[1], colors.sightred[2], colors.sightred[3], 255 * a))
                  dxDrawRectangle(sx - ch / 2, sy - charsetSize * 0.8 * scale - 256 * s + 50 * s - cw / 2, ch, cw * p4, tocolor(colors.sightred[1], colors.sightred[2], colors.sightred[3], 255 * a))
                  if 0 < data.lastRespawn then
                    drawSpecialText(sx, sy - charsetSize * scale * 0.6, scale * 0.8, tocolor(colors.hudwhite[1], colors.hudwhite[2], colors.hudwhite[3], 225 * a), data.lastRespawn .. " perce éledt újra")
                  else
                    drawSpecialText(sx, sy - charsetSize * scale * 0.6, scale * 0.8, tocolor(colors.hudwhite[1], colors.hudwhite[2], colors.hudwhite[3], 225 * a), "Most éledt újra")
                  end
                elseif data.helperLevel then
                  local s = scale * 0.4
                  animY = 384 * s
                  local control = checkSpeed(el)
                  if not control then
                    if 1 > data.helperLevel[2] then
                      data.helperLevel[2] = data.helperLevel[2] + delta / 650
                      if 1 < data.helperLevel[2] then
                        data.helperLevel[2] = 1
                      end
                    end
                  elseif 0 < data.helperLevel[2] then
                    data.helperLevel[2] = data.helperLevel[2] - delta / 650
                    if 0 > data.helperLevel[2] then
                      data.helperLevel[2] = 0
                    end
                  end
                  local p = data.helperLevel[2]
                  animY = animY * math.min(1, p * 2)
                  sightlangStaticImageUsed[7] = true
                  if sightlangStaticImageToc[7] then
                    processsightlangStaticImage[7]()
                  end
                  
                  colorTable = {helperColor[1] / 255, helperColor[2] / 255, helperColor[3] / 255}
                  if not setHelperValue[colorTable] then
                    dxSetShaderValue(shader, "logoColor", helperColor[1] / 255, helperColor[2] / 255, helperColor[3] / 255, (255 * a * p) / 255)
                    setHelperValue[colorTable] = true
                  end

                  dxDrawImage(sx - 256 * s, sy - charsetSize * 0.225 * scale - 402 * s, 512 * s, 512 * s, shader, 0, 0, 0)
                end
                if data.chat or data.console or data.hideChat or data.hideConsole then
                  local t = now - (data.chat or data.console or data.hideChat or data.hideConsole)
                  local s = scale * 0.9
                  local y = charsetSize * scale * 0.75 + animY
                  local char = "\226\128\162"
                  if data.console or data.hideConsole then
                    char = "_"
                  end
                  local w1 = getSpecialTextWidth(s, char) + 8 * scale
                  local inP = math.min(1, t / 300)
                  if data.hideChat or data.hideConsole then
                    inP = 1 - inP
                    if inP <= 0 then
                      inP = 0
                      namesData[el].hideChat = false
                      namesData[el].hideConsole = false
                    end
                  end
                  if data.chat or data.console or data.hideChat or data.hideConsole then
                    local sx = sx - w1
                    if data.console or data.hideConsole then
                      sx = sx - w1 / 2
                      drawSpecialText(sx - w1, sy - y, s + 0.4 * p, tocolor(colors.hudwhite[1], colors.hudwhite[2], colors.hudwhite[3], 255 * a), ">")
                    end
                    for i = 1, 3 do
                      local p = 0
                      if 1 <= inP then
                        p = (t - 300) / 300 % 3
                      end
                      p = math.min(math.max(p - i + 1, 0), 1)
                      p = p * 2
                      if 1 < p then
                        p = 2 - p
                      end
                      if data.console then
                        drawSpecialText(sx, sy - y, s, tocolor(colors.hudwhite[1], colors.hudwhite[2], colors.hudwhite[3], 255 * a * p), char)
                      else
                        local a2 = 0.75 + 0.25 * p
                        drawSpecialText(sx, sy - y, s, tocolor(colors.hudwhite[1], colors.hudwhite[2], colors.hudwhite[3], 255 * a * a2), char)
                      end
                      sx = sx + w1 * inP
                    end
                  end
                end
                if 0 < #data.bubbles then
                  local y = charsetSize * scale * 0.75 * ((data.chat or data.console or data.hideChat or data.hideConsole) and 2 or 1) + animY
                  for j = #data.bubbles, 1, -1 do
                    local text = data.bubbles[j][2]
                    local msgType = data.bubbles[j][3]
                    if msgType == "me" or msgType == "trygreen" or msgType == "tryred" then
                      text = "* " .. text
                    elseif msgType == "melow" then
                      text = "[LOW] * " .. text
                    elseif msgType == "ame" then
                      text = "> " .. text
                    elseif msgType == "do" then
                      text = "* " .. text
                    elseif msgType == "dolow" then
                      text = "[LOW] * " .. text
                    elseif msgType == "megaphone" then
                      text = "<O " .. text
                    end
                    local d = now - data.bubbles[j][1]
                    local p = d / 25
                    local len = utf8.len(text)
                    local a2 = math.min(3, p) / 3
                    if p > math.max(175, len * 5) then
                      local p = p - math.max(175, len * 5)
                      p = p / 3
                      if 1 < p then
                        p = 1
                      end
                      a2 = 1 - p
                    end
                    if p > len then
                      p = len
                    end
                    local bubbleColor = tocolor(0, 0, 0, 150 * a * a2)
                    local tr, tg, tb = colors.hudwhite[1], colors.hudwhite[2], colors.hudwhite[3]
                    if msgType == "me" then
                      tr, tg, tb = 194, 162, 218
                    elseif msgType == "melow" then
                      tr, tg, tb = 219, 197, 235
                    elseif msgType == "ame" then
                      tr, tg, tb = 149, 108, 180
                    elseif msgType == "do" then
                      tr, tg, tb = 255, 40, 80
                    elseif msgType == "dolow" then
                      tr, tg, tb = 255, 102, 130
                    elseif msgType == "trygreen" then
                      tr, tg, tb = colors.sightgreen[1], colors.sightgreen[2], colors.sightgreen[3]
                    elseif msgType == "tryred" then
                      tr, tg, tb = colors.sightred[1], colors.sightred[2], colors.sightred[3]
                    elseif msgType == "megaphone" then
                      tr, tg, tb = 255, 255, 0
                    end
                    local char = 1 + math.floor(p)
                    local text1 = utf8.sub(text, 1, char - 1)
                    local text2 = utf8.sub(text, char, char)
                    local s = scale * 0.8
                    local w = getSpecialTextWidth(s, text, "ubuntu")
                    local w2 = getSpecialTextWidth(s, text1, "ubuntu")
                    local w3 = getSpecialTextWidth(s, text2, "ubuntu")
                    local p2 = p % 1
                    local feather = math.ceil(12 * s)
                    local bx = math.floor(sx - w / 2)
                    local by = math.floor(sy - y - 17 * s)
                    local bw = math.ceil(w2 + w3 * p2)
                    local bh = math.ceil(34 * s)
                    sightlangStaticImageUsed[18] = true
                    if sightlangStaticImageToc[18] then
                      processsightlangStaticImage[18]()
                    end
                    dxDrawImage(bx, by, -feather, bh, sightlangStaticImage[18], 0, 0, 0, bubbleColor)
                    sightlangStaticImageUsed[18] = true
                    if sightlangStaticImageToc[18] then
                      processsightlangStaticImage[18]()
                    end
                    dxDrawImage(bx + bw, by, feather, bh, sightlangStaticImage[18], 0, 0, 0, bubbleColor)
                    sightlangStaticImageUsed[19] = true
                    if sightlangStaticImageToc[19] then
                      processsightlangStaticImage[19]()
                    end
                    dxDrawImage(bx, by, bw, -feather, sightlangStaticImage[19], 0, 0, 0, bubbleColor)
                    sightlangStaticImageUsed[19] = true
                    if sightlangStaticImageToc[19] then
                      processsightlangStaticImage[19]()
                    end
                    dxDrawImage(bx, by + bh, bw, feather, sightlangStaticImage[19], 0, 0, 0, bubbleColor)
                    sightlangStaticImageUsed[20] = true
                    if sightlangStaticImageToc[20] then
                      processsightlangStaticImage[20]()
                    end
                    dxDrawImage(bx, by, -feather, -feather, sightlangStaticImage[20], 90, 0, 0, bubbleColor)
                    sightlangStaticImageUsed[20] = true
                    if sightlangStaticImageToc[20] then
                      processsightlangStaticImage[20]()
                    end
                    dxDrawImage(bx + bw, by, feather, -feather, sightlangStaticImage[20], 270, 0, 0, bubbleColor)
                    sightlangStaticImageUsed[20] = true
                    if sightlangStaticImageToc[20] then
                      processsightlangStaticImage[20]()
                    end
                    dxDrawImage(bx, by + bh, -feather, feather, sightlangStaticImage[20], 270, 0, 0, bubbleColor)
                    sightlangStaticImageUsed[20] = true
                    if sightlangStaticImageToc[20] then
                      processsightlangStaticImage[20]()
                    end
                    dxDrawImage(bx + bw, by + bh, feather, feather, sightlangStaticImage[20], 90, 0, 0, bubbleColor)
                    dxDrawRectangle(bx, by, bw, bh, bubbleColor)
                    drawSpecialText(bx, by + 17 * s, s, tocolor(tr, tg, tb, 255 * a * a2), text1, true, false, "ubuntu")
                    drawSpecialText(bx + w2, by + 17 * s, s, tocolor(tr, tg, tb, 255 * a * a2 * p2), text2, true, false, "ubuntu")
                    if a2 <= 0 and 1 <= p then
                      table.remove(namesData[el].bubbles, j)
                    end
                    y = y + bh + feather * 2 + 4 * scale
                  end
                end
              end
              if data.helperLevel then
                drawSpecialText(sx, sy, scale * 0.85, tocolor(helperColor[1], helperColor[2], helperColor[3], 255 * a), data.helperLevel[1])
                sy = sy + charsetSize * 0.65 * scale
              end
              local white = 0 < anamesState and "sightred" or "hudwhite"
              if 0 < anamesState then
                local w = 230 * scale
                local sx = sx - w / 2
                local sy = sy + 32 * scale
                if not data.adminDuty and (data.badgeData or data.facePaint or data.badgeExData) then
                  sy = sy + charsetSize * 0.6 * scale
                end
                dxDrawRectangle(sx - 2, sy - 1, w + 4, 12 * scale + 2, tocolor(0, 0, 0, 200 * a))
                dxDrawRectangle(sx - 1, sy, w / 2 + 1, 12 * scale, tocolor(colors.sightgreen[1] * 0.5, colors.sightgreen[2] * 0.5, colors.sightgreen[3] * 0.5, 200 * a))
                dxDrawRectangle(sx + w / 2, sy, w / 2 + 1, 12 * scale, tocolor(colors.sightblue[1] * 0.5, colors.sightblue[2] * 0.5, colors.sightblue[3] * 0.5, 200 * a))
                dxDrawRectangle(sx - 1, sy, w / 2 * getElementHealth(el) / 100, 12 * scale, tocolor(colors.sightgreen[1], colors.sightgreen[2], colors.sightgreen[3], 255 * a))
                dxDrawRectangle(sx + w / 2 + 1, sy, w / 2 * getPedArmor(el) / 100, 12 * scale, tocolor(colors.sightblue[1], colors.sightblue[2], colors.sightblue[3], 255 * a))
                dxDrawRectangle(sx + w / 2 - 1, sy, 2, 12 * scale, tocolor(0, 0, 0, 200 * a))
              end
              if data.adminDuty then
                local w = getSpecialTextWidth(scale, data.adminDuty[3] .. " ")
                local w2 = getSpecialTextWidth(scale, data.adminDuty[1])
                sx = sx - (w + w2) / 2
                local col = data.adminDuty[2]
                if 0 < anamesState then
                  local w3 = getSpecialTextWidth(scale, "(" .. data.playerID .. ") ")
                  sx = sx - w3 / 3
                  drawSpecialText(sx, sy, scale, 0 < hp and tocolor(colors[white][1], colors[white][2], colors[white][3], 255 * a) or tocolor(80, 80, 80, 225 * a), data.adminDuty[3], true, w)
                  drawSpecialText(sx + w, sy, scale, 0 < hp and tocolor(colors.hudwhite[1], colors.hudwhite[2], colors.hudwhite[3], 255 * a) or tocolor(80, 80, 80, 225 * a), "(" .. data.playerID .. ")", true, w2)
                  drawSpecialText(sx + w + w3, sy, scale, 0 < hp and tocolor(colors[col][1], colors[col][2], colors[col][3], 255 * a) or tocolor(80, 80, 80, 225 * a), data.adminDuty[1], true, w3)
                else
                  drawSpecialText(sx, sy, scale, 0 < hp and tocolor(colors[white][1], colors[white][2], colors[white][3], 255 * a) or tocolor(80, 80, 80, 225 * a), data.adminDuty[3], true, w)
                  drawSpecialText(sx + w, sy, scale, 0 < hp and tocolor(colors[col][1], colors[col][2], colors[col][3], 255 * a) or tocolor(80, 80, 80, 225 * a), data.adminDuty[1], true, w2)
                end
                if data.voice then
                  local vx = sx
                  local isy = charsetSize * scale / 2
                  local isx2 = 0.9375 * isy
                  local col = baseColor
                  sightlangStaticImageUsed[21] = true
                  if sightlangStaticImageToc[21] then
                    processsightlangStaticImage[21]()
                  end
                  dxDrawImage(vx - isx2 * 1.1, sy - isy * 0.42, isx2, isy, sightlangStaticImage[21], 0, 0, 0, col)
                end
              else
                local baseColor = tocolor(colors[white][1], colors[white][2], colors[white][3], 255 * a)
                if data.hpMinus then
                  local col1 = colors[0 < anamesState and "sightred" or "hudwhite"]
                  local col2 = colors[0 < anamesState and "hudwhite" or "sightred"]
                  local p = 1 - (now - data.hpMinus) / 500
                  if p < 0 then
                    namesData[el].hpMinus = false
                    p = 0
                  end
                  local r, g, b = interpolateBetween(col1[1], col1[2], col1[3], col2[1], col2[2], col2[3], p, "Linear")
                  baseColor = tocolor(r, g, b, 255 * a)
                elseif data.bloodDamage then
                  local col1 = colors[0 < anamesState and "sightred" or "hudwhite"]
                  local col2 = colors[0 < anamesState and "hudwhite" or "sightred"]
                  local p = now % 1000 / 1000
                  p = p * 2
                  if 1 < p then
                    p = 2 - p
                  end
                  local r, g, b = interpolateBetween(col1[1], col1[2], col1[3], col2[1], col2[2], col2[3], p, "Linear")
                  baseColor = tocolor(r, g, b, 255 * a)
                end
                if 0 < anamesState then
                  local isy = charsetSize * scale / 2
                  local isx = 1.4375 * isy
                  local isx2 = 0.9375 * isy
                  local armor = data.usingArmor and 0 < getPedArmor(el)
                  local w = getSpecialTextWidth(scale, data.visibleName .. " ")
                  local w2 = getSpecialTextWidth(scale, "(" .. data.playerID .. ")" .. ((data.visibleWeapon or armor or data.deathTag) and " " or ""))
                  local col = 0 < hp and tocolor(colors.hudwhite[1], colors.hudwhite[2], colors.hudwhite[3], 255 * a) or tocolor(80, 80, 80, 225 * a)
                  if data.playerGlueState then
                    local w3 = getSpecialTextWidth(scale, " [G]")
                    local sx = sx - (w + w2 + w3) / 2
                    local wp = data.visibleWeapon
                    if wp or data.deathTag then
                      sx = sx - isx / 2
                    end
                    if armor then
                      sx = sx - isx2 / 2
                      if wp then
                        sx = sx - isx * 0.1 / 2
                      end
                    end
                    drawSpecialText(sx, sy, scale, airsoft and airsoftColor or 0 < hp and baseColor or tocolor(80, 80, 80, 225 * a), data.visibleName, true)
                    drawSpecialText(sx + w, sy, scale, col, "(" .. data.playerID .. ")", true)
                    if data.deathTag then
                      sightlangStaticImageUsed[22] = true
                      if sightlangStaticImageToc[22] then
                        processsightlangStaticImage[22]()
                      end
                      dxDrawImage(sx + w + w2, sy - isy * 0.42, isx, isy, sightlangStaticImage[22], 0, 0, 0, col)
                      drawSpecialText(sx + w + w2 + isx, sy, scale, 0 < hp and tocolor(120, 120, 120, 255 * a) or tocolor(80, 80, 80, 225 * a), " [G]", true)
                    elseif wp and armor then
                      sightlangStaticImageUsed[23] = true
                      if sightlangStaticImageToc[23] then
                        processsightlangStaticImage[23]()
                      end
                      dxDrawImage(sx + w + w2, sy - isy * 0.42, isx, isy, sightlangStaticImage[23], 0, 0, 0, col)
                      sightlangStaticImageUsed[24] = true
                      if sightlangStaticImageToc[24] then
                        processsightlangStaticImage[24]()
                      end
                      dxDrawImage(sx + w + w2 + isx * 1.1, sy - isy * 0.42, isx2, isy, sightlangStaticImage[24], 0, 0, 0, col)
                      drawSpecialText(sx + w + w2 + isx * 1.1 + isx2, sy, scale, 0 < hp and tocolor(120, 120, 120, 255 * a) or tocolor(80, 80, 80, 225 * a), " [G]", true)
                    elseif armor then
                      sightlangStaticImageUsed[24] = true
                      if sightlangStaticImageToc[24] then
                        processsightlangStaticImage[24]()
                      end
                      dxDrawImage(sx + w + w2, sy - isy * 0.42, isx2, isy, sightlangStaticImage[24], 0, 0, 0, col)
                      drawSpecialText(sx + w + w2 + isx2, sy, scale, 0 < hp and tocolor(120, 120, 120, 255 * a) or tocolor(80, 80, 80, 225 * a), " [G]", true)
                    elseif wp then
                      sightlangStaticImageUsed[23] = true
                      if sightlangStaticImageToc[23] then
                        processsightlangStaticImage[23]()
                      end
                      dxDrawImage(sx + w + w2, sy - isy * 0.42, isx, isy, sightlangStaticImage[23], 0, 0, 0, col)
                      drawSpecialText(sx + w + w2 + isx, sy, scale, 0 < hp and tocolor(120, 120, 120, 255 * a) or tocolor(80, 80, 80, 225 * a), " [G]", true)
                    else
                      drawSpecialText(sx + w + w2, sy, scale, 0 < hp and tocolor(120, 120, 120, 255 * a) or tocolor(80, 80, 80, 225 * a), " [G]", true)
                    end
                    if data.voice then
                      local vx = sx
                      local isy = charsetSize * scale / 2
                      local isx2 = 0.9375 * isy
                      local col = baseColor
                      sightlangStaticImageUsed[21] = true
                      if sightlangStaticImageToc[21] then
                        processsightlangStaticImage[21]()
                      end
                      dxDrawImage(vx - isx2 * 1.1, sy - isy * 0.42, isx2, isy, sightlangStaticImage[21], 0, 0, 0, col)
                    end
                  else
                    local sx = sx - (w + w2) / 2
                    if data.visibleWeapon or data.deathTag then
                      sx = sx - isx / 2
                    end
                    local armor = data.usingArmor and 0 < getPedArmor(el)
                    if armor then
                      sx = sx - isx2 / 2
                    end
                    drawSpecialText(sx, sy, scale, airsoft and airsoftColor or 0 < hp and baseColor or tocolor(80, 80, 80, 225 * a), data.visibleName, true)
                    drawSpecialText(sx + w, sy, scale, col, "(" .. data.playerID .. ")", true)
                    if data.deathTag then
                      sightlangStaticImageUsed[22] = true
                      if sightlangStaticImageToc[22] then
                        processsightlangStaticImage[22]()
                      end
                      dxDrawImage(sx + w + w2, sy - isy * 0.42, isx, isy, sightlangStaticImage[22], 0, 0, 0, col)
                    elseif data.visibleWeapon and armor then
                      sightlangStaticImageUsed[23] = true
                      if sightlangStaticImageToc[23] then
                        processsightlangStaticImage[23]()
                      end
                      dxDrawImage(sx + w + w2, sy - isy * 0.42, isx, isy, sightlangStaticImage[23], 0, 0, 0, col)
                      sightlangStaticImageUsed[24] = true
                      if sightlangStaticImageToc[24] then
                        processsightlangStaticImage[24]()
                      end
                      dxDrawImage(sx + w + w2 + isx * 1.1, sy - isy * 0.42, isx2, isy, sightlangStaticImage[24], 0, 0, 0, col)
                    elseif armor then
                      sightlangStaticImageUsed[24] = true
                      if sightlangStaticImageToc[24] then
                        processsightlangStaticImage[24]()
                      end
                      dxDrawImage(sx + w + w2, sy - isy * 0.42, isx2, isy, sightlangStaticImage[24], 0, 0, 0, col)
                    elseif data.visibleWeapon then
                      sightlangStaticImageUsed[23] = true
                      if sightlangStaticImageToc[23] then
                        processsightlangStaticImage[23]()
                      end
                      dxDrawImage(sx + w + w2, sy - isy * 0.42, isx, isy, sightlangStaticImage[23], 0, 0, 0, col)
                    end
                    if data.voice then
                      local vx = sx
                      local isy = charsetSize * scale / 2
                      local isx2 = 0.9375 * isy
                      local col = baseColor
                      sightlangStaticImageUsed[21] = true
                      if sightlangStaticImageToc[21] then
                        processsightlangStaticImage[21]()
                      end
                      dxDrawImage(vx - isx2 * 1.1, sy - isy * 0.42, isx2, isy, sightlangStaticImage[21], 0, 0, 0, col)
                    end
                  end
                else
                  local wave = isElementInWater(el)
                  local wp = false
                  local armor = false
                  local belt = data.seatBelt
                  if not isPedInVehicle(el) then
                    wp = data.visibleWeapon
                    armor = data.usingArmor and 0 < getPedArmor(el)
                  end
                  if data.playerGlueState then
                    local text = data.visibleName .. " (" .. data.playerID .. ")"
                    if wp or armor or data.deathTag then
                      text = text .. " "
                    end
                    local w = getSpecialTextWidth(scale, text)
                    local w2 = getSpecialTextWidth(scale, " [G]")
                    local sx = sx - (w + w2) / 2
                    local isy = charsetSize * scale / 2
                    local isx = 1.4375 * isy
                    if wp or data.deathTag then
                      sx = sx - isx / 2
                    end
                    if armor then
                      sx = sx - isx / 2
                      if wp then
                        sx = sx - isx * 0.1 / 2
                      end
                    end
                    local col = airsoft and airsoftColor or 0 < hp and baseColor or tocolor(80, 80, 80, 225 * a)
                    drawSpecialText(sx, sy, scale, col, text, true, false, false, false, wave and 0)
                    if data.deathTag then
                      sightlangStaticImageUsed[22] = true
                      if sightlangStaticImageToc[22] then
                        processsightlangStaticImage[22]()
                      end
                      dxDrawImage(sx + w, sy - isy * 0.42, isx, isy, sightlangStaticImage[22], 0, 0, 0, col)
                      drawSpecialText(sx + w + isx, sy, scale, 0 < hp and tocolor(120, 120, 120, 255 * a) or tocolor(80, 80, 80, 225 * a), " [G]", true, false, false, false, wave and utf8.len(text))
                    elseif wp and armor then
                      sightlangStaticImageUsed[23] = true
                      if sightlangStaticImageToc[23] then
                        processsightlangStaticImage[23]()
                      end
                      dxDrawImage(sx + w, sy - isy * 0.42, isx, isy, sightlangStaticImage[23], 0, 0, 0, col)
                      sightlangStaticImageUsed[24] = true
                      if sightlangStaticImageToc[24] then
                        processsightlangStaticImage[24]()
                      end
                      dxDrawImage(sx + w + isx * 1.1, sy - isy * 0.42, isx2, isy, sightlangStaticImage[24], 0, 0, 0, col)
                      drawSpecialText(sx + w + isx * 1.1 + isx2, sy, scale, 0 < hp and tocolor(120, 120, 120, 255 * a) or tocolor(80, 80, 80, 225 * a), " [G]", true, false, false, false, wave and utf8.len(text))
                    elseif armor then
                      sightlangStaticImageUsed[24] = true
                      if sightlangStaticImageToc[24] then
                        processsightlangStaticImage[24]()
                      end
                      dxDrawImage(sx + w, sy - isy * 0.42, isx2, isy, sightlangStaticImage[24], 0, 0, 0, col)
                      drawSpecialText(sx + w + isx2, sy, scale, 0 < hp and tocolor(120, 120, 120, 255 * a) or tocolor(80, 80, 80, 225 * a), " [G]", true, false, false, false, wave and utf8.len(text))
                    elseif wp then
                      sightlangStaticImageUsed[23] = true
                      if sightlangStaticImageToc[23] then
                        processsightlangStaticImage[23]()
                      end
                      dxDrawImage(sx + w, sy - isy * 0.42, isx, isy, sightlangStaticImage[23], 0, 0, 0, col)
                      drawSpecialText(sx + w + isx, sy, scale, 0 < hp and tocolor(120, 120, 120, 255 * a) or tocolor(80, 80, 80, 225 * a), " [G]", true, false, false, false, wave and utf8.len(text))
                    else
                      drawSpecialText(sx + w, sy, scale, 0 < hp and tocolor(120, 120, 120, 255 * a) or tocolor(80, 80, 80, 225 * a), " [G]", true, false, false, false, wave and utf8.len(text))
                    end
                    if data.voice then
                      local vx = sx
                      local isy = charsetSize * scale / 2
                      local isx2 = 0.9375 * isy
                      local col = baseColor
                      sightlangStaticImageUsed[21] = true
                      if sightlangStaticImageToc[21] then
                        processsightlangStaticImage[21]()
                      end
                      dxDrawImage(vx - isx2 * 1.1, sy - isy * 0.42, isx2, isy, sightlangStaticImage[21], 0, 0, 0, col)
                    end
                  else
                    local vx = false
                    local airsoft = data.airsoft
                    local text = data.visibleName .. " (" .. data.playerID .. ")"
                    if airsoft and airsoft == "sightblue" then
                      airsoftColor = tocolor(colors.sightblue[1], colors.sightblue[2], colors.sightblue[3], 255 * a)
                    elseif airsoft and airsoft == "sightred" then
                      airsoftColor = tocolor(colors.sightred[1], colors.sightred[2], colors.sightred[3], 255 * a)
                    elseif airsoft and airsoft == "sightgreen" then
                      airsoftColor = tocolor(colors.sightgreen[1], colors.sightgreen[2], colors.sightgreen[3], 255 * a)
                    end
                    if data.deathTag then
                      text = text .. " "
                      local w = getSpecialTextWidth(scale, text)
                      local isy = charsetSize * scale / 2
                      local isx = 1.4375 * isy
                      local sx = sx - (isx + w) / 2
                      local col = airsoft and airsoftColor or 0 < hp and baseColor or tocolor(80, 80, 80, 225 * a)
                      drawSpecialText(sx, sy, scale, col, text, true, false, false, false, wave and 0)
                      sightlangStaticImageUsed[22] = true
                      if sightlangStaticImageToc[22] then
                        processsightlangStaticImage[22]()
                      end
                      dxDrawImage(sx + w, sy - isy * 0.42, isx, isy, sightlangStaticImage[22], 0, 0, 0, col)
                      vx = sx
                    elseif wp and armor then
                      text = text .. " "
                      local w = getSpecialTextWidth(scale, text)
                      local isy = charsetSize * scale / 2
                      local isx = 1.4375 * isy
                      local isx2 = 0.9375 * isy
                      local sx = sx - (isx * 1.1 + isx2 + w) / 2
                      local col = airsoft and airsoftColor or 0 < hp and baseColor or tocolor(80, 80, 80, 225 * a)
                      drawSpecialText(sx, sy, scale, col, text, true, false, false, false, wave and 0)
                      sightlangStaticImageUsed[23] = true
                      if sightlangStaticImageToc[23] then
                        processsightlangStaticImage[23]()
                      end
                      dxDrawImage(sx + w, sy - isy * 0.42, isx, isy, sightlangStaticImage[23], 0, 0, 0, col)
                      sightlangStaticImageUsed[24] = true
                      if sightlangStaticImageToc[24] then
                        processsightlangStaticImage[24]()
                      end
                      dxDrawImage(sx + w + isx * 1.1, sy - isy * 0.42, isx2, isy, sightlangStaticImage[24], 0, 0, 0, col)
                      vx = sx
                    elseif belt then
                      text = text .. " "
                      local w = getSpecialTextWidth(scale, text)
                      local isy = charsetSize * scale / 2
                      local isx2 = 0.9375 * isy
                      local sx = sx - (isx2 + w) / 2
                      local col = airsoft and airsoftColor or 0 < hp and baseColor or tocolor(80, 80, 80, 225 * a)
                      drawSpecialText(sx, sy, scale, col, text, true, false, false, false, wave and 0)
                      sightlangStaticImageUsed[25] = true
                      if sightlangStaticImageToc[25] then
                        processsightlangStaticImage[25]()
                      end
                      dxDrawImage(sx + w, sy - isy * 0.42, isx2, isy, sightlangStaticImage[25], 0, 0, 0, col)
                      vx = sx
                    elseif armor then
                      text = text .. " "
                      local w = getSpecialTextWidth(scale, text)
                      local isy = charsetSize * scale / 2
                      local isx2 = 0.9375 * isy
                      local sx = sx - (isx2 + w) / 2
                      local col = airsoft and airsoftColor or 0 < hp and baseColor or tocolor(80, 80, 80, 225 * a)
                      drawSpecialText(sx, sy, scale, col, text, true, false, false, false, wave and 0)
                      sightlangStaticImageUsed[24] = true
                      if sightlangStaticImageToc[24] then
                        processsightlangStaticImage[24]()
                      end
                      dxDrawImage(sx + w, sy - isy * 0.42, isx2, isy, sightlangStaticImage[24], 0, 0, 0, col)
                      vx = sx
                    elseif wp then
                      text = text .. " "
                      local w = getSpecialTextWidth(scale, text)
                      local isy = charsetSize * scale / 2
                      local isx = 1.4375 * isy
                      local sx = sx - (isx + w) / 2
                      local col = airsoft and airsoftColor or 0 < hp and baseColor or tocolor(80, 80, 80, 225 * a)
                      drawSpecialText(sx, sy, scale, col, text, true, false, false, false, wave and 0)
                      sightlangStaticImageUsed[23] = true
                      if sightlangStaticImageToc[23] then
                        processsightlangStaticImage[23]()
                      end
                      dxDrawImage(sx + w, sy - isy * 0.42, isx, isy, sightlangStaticImage[23], 0, 0, 0, col)
                      vx = sx
                    else
                      drawSpecialText(sx, sy, scale, airsoft and airsoftColor or 0 < hp and baseColor or tocolor(80, 80, 80, 225 * a), text, false, false, false, false, wave and 0)
                    end
                    if data.voice then
                      vx = vx or sx - getSpecialTextWidth(scale, text) / 2
                      local isy = charsetSize * scale / 2
                      local isx2 = 0.9375 * isy
                      local col = baseColor
                      sightlangStaticImageUsed[21] = true
                      if sightlangStaticImageToc[21] then
                        processsightlangStaticImage[21]()
                      end
                      dxDrawImage(vx - isx2 * 1.1, sy - isy * 0.42, isx2, isy, sightlangStaticImage[21], 0, 0, 0, col)
                    end
                  end
                end
                if data.badgeExData then
                  local is = 32 * scale * 0.9
                  local w = getSpecialTextWidth(scale, data.badgeExData)
                  sx = sx - (w + is + 4 * scale) / 2
                  local y = sy + charsetSize * 0.6 * scale
                  sightlangStaticImageUsed[26] = true
                  if sightlangStaticImageToc[26] then
                    processsightlangStaticImage[26]()
                  end
                  dxDrawImage(sx, y + 2 * scale - is / 2, is, is, sightlangStaticImage[26], 0, 0, 0, 0 < hp and tocolor(colors.sightblue[1], colors.sightblue[2], colors.sightblue[3], 255 * a) or tocolor(80, 80, 80, 225 * a))
                  drawSpecialText(sx + 4 * scale + is, y, scale * 0.9, 0 < hp and tocolor(colors.sightblue[1], colors.sightblue[2], colors.sightblue[3], 255 * a) or tocolor(80, 80, 80, 225 * a), data.badgeExData, true)
                elseif data.badgeData then
                  local is = 32 * scale * 0.9
                  local w = getSpecialTextWidth(scale, data.badgeData)
                  sx = sx - (w + is + 4 * scale) / 2
                  local y = sy + charsetSize * 0.6 * scale
                  sightlangStaticImageUsed[27] = true
                  if sightlangStaticImageToc[27] then
                    processsightlangStaticImage[27]()
                  end
                  dxDrawImage(sx, y + 2 * scale - is / 2, is, is, sightlangStaticImage[27], 0, 0, 0, 0 < hp and tocolor(colors.sightyellow[1], colors.sightyellow[2], colors.sightyellow[3], 255 * a) or tocolor(80, 80, 80, 225 * a))
                  drawSpecialText(sx + 4 * scale + is, y, scale * 0.9, 0 < hp and tocolor(colors.sightyellow[1], colors.sightyellow[2], colors.sightyellow[3], 255 * a) or tocolor(80, 80, 80, 225 * a), data.badgeData, true)
                elseif data.facePaint and not getPedOccupiedVehicle(el) then
                  drawSpecialText(sx, sy + charsetSize * 0.6 * scale, scale * 0.9, 0 < hp and tocolor(colors.sightpurple[1], colors.sightpurple[2], colors.sightpurple[3], 255 * a) or tocolor(80, 80, 80, 225 * a), "* festékes az arca *")
                end
              end
            elseif data.type == "ped" then
              local text = ""
              if data.bubbles and 0 < #data.bubbles then
                local y = charsetSize * scale * 0.75 * ((data.chat or data.console or data.hideChat or data.hideConsole) and 2 or 1)
                for j = #data.bubbles, 1, -1 do
                  local text = data.bubbles[j][2]
                  local msgType = data.bubbles[j][3]
                  if msgType == "me" or msgType == "trygreen" or msgType == "tryred" then
                    text = "* " .. text
                  elseif msgType == "melow" then
                    text = "[LOW] * " .. text
                  elseif msgType == "ame" then
                    text = "> " .. text
                  elseif msgType == "do" then
                    text = "* " .. text
                  elseif msgType == "dolow" then
                    text = "[LOW] * " .. text
                  elseif msgType == "megaphone" then
                    text = "<O " .. text
                  end
                  local d = now - data.bubbles[j][1]
                  local p = d / 25
                  local len = utf8.len(text)
                  local a2 = math.min(3, p) / 3
                  if p > math.max(100, len * 3) then
                    local p = p - math.max(100, len * 3)
                    p = p / 3
                    if 1 < p then
                      p = 1
                    end
                    a2 = 1 - p
                  end
                  if p > len then
                    p = len
                  end
                  local bubbleColor = tocolor(0, 0, 0, 150 * a * a2)
                  local tr, tg, tb = colors.hudwhite[1], colors.hudwhite[2], colors.hudwhite[3]
                  if msgType == "me" then
                    tr, tg, tb = 194, 162, 218
                  elseif msgType == "melow" then
                    tr, tg, tb = 219, 197, 235
                  elseif msgType == "ame" then
                    tr, tg, tb = 149, 108, 180
                  elseif msgType == "do" then
                    tr, tg, tb = 255, 40, 80
                  elseif msgType == "dolow" then
                    tr, tg, tb = 255, 102, 130
                  elseif msgType == "trygreen" then
                    tr, tg, tb = colors.sightgreen[1], colors.sightgreen[2], colors.sightgreen[3]
                  elseif msgType == "tryred" then
                    tr, tg, tb = colors.sightred[1], colors.sightred[2], colors.sightred[3]
                  elseif msgType == "megaphone" then
                    tr, tg, tb = 255, 255, 0
                  end
                  local char = 1 + math.floor(p)
                  local text1 = utf8.sub(text, 1, char - 1)
                  local text2 = utf8.sub(text, char, char)
                  local s = scale * 0.8
                  local w = getSpecialTextWidth(s, text, "ubuntu")
                  local w2 = getSpecialTextWidth(s, text1, "ubuntu")
                  local w3 = getSpecialTextWidth(s, text2, "ubuntu")
                  local p2 = p % 1
                  local feather = math.ceil(12 * s)
                  local bx = math.floor(sx - w / 2)
                  local by = math.floor(sy - y - 17 * s)
                  local bw = math.ceil(w2 + w3 * p2)
                  local bh = math.ceil(34 * s)
                  sightlangStaticImageUsed[18] = true
                  if sightlangStaticImageToc[18] then
                    processsightlangStaticImage[18]()
                  end
                  dxDrawImage(bx, by, -feather, bh, sightlangStaticImage[18], 0, 0, 0, bubbleColor)
                  sightlangStaticImageUsed[18] = true
                  if sightlangStaticImageToc[18] then
                    processsightlangStaticImage[18]()
                  end
                  dxDrawImage(bx + bw, by, feather, bh, sightlangStaticImage[18], 0, 0, 0, bubbleColor)
                  sightlangStaticImageUsed[19] = true
                  if sightlangStaticImageToc[19] then
                    processsightlangStaticImage[19]()
                  end
                  dxDrawImage(bx, by, bw, -feather, sightlangStaticImage[19], 0, 0, 0, bubbleColor)
                  sightlangStaticImageUsed[19] = true
                  if sightlangStaticImageToc[19] then
                    processsightlangStaticImage[19]()
                  end
                  dxDrawImage(bx, by + bh, bw, feather, sightlangStaticImage[19], 0, 0, 0, bubbleColor)
                  sightlangStaticImageUsed[20] = true
                  if sightlangStaticImageToc[20] then
                    processsightlangStaticImage[20]()
                  end
                  dxDrawImage(bx, by, -feather, -feather, sightlangStaticImage[20], 90, 0, 0, bubbleColor)
                  sightlangStaticImageUsed[20] = true
                  if sightlangStaticImageToc[20] then
                    processsightlangStaticImage[20]()
                  end
                  dxDrawImage(bx + bw, by, feather, -feather, sightlangStaticImage[20], 270, 0, 0, bubbleColor)
                  sightlangStaticImageUsed[20] = true
                  if sightlangStaticImageToc[20] then
                    processsightlangStaticImage[20]()
                  end
                  dxDrawImage(bx, by + bh, -feather, feather, sightlangStaticImage[20], 270, 0, 0, bubbleColor)
                  sightlangStaticImageUsed[20] = true
                  if sightlangStaticImageToc[20] then
                    processsightlangStaticImage[20]()
                  end
                  dxDrawImage(bx + bw, by + bh, feather, feather, sightlangStaticImage[20], 90, 0, 0, bubbleColor)
                  dxDrawRectangle(bx, by, bw, bh, bubbleColor)
                  drawSpecialText(bx, by + 17 * s, s, tocolor(tr, tg, tb, 255 * a * a2), text1, true, false, "ubuntu")
                  drawSpecialText(bx + w2, by + 17 * s, s, tocolor(tr, tg, tb, 255 * a * a2 * p2), text2, true, false, "ubuntu")
                  if a2 <= 0 and 1 <= p then
                    table.remove(namesData[el].bubbles, j)
                  end
                  y = y + bh + feather * 2 + 4 * scale
                end
              end
              if data.deathPed then
                local p = now % 4900 / 700
                local s = scale * 0.4
                local p1 = math.min(0.5, p) / 0.5
                local p2 = getEasingValue(math.min(1, p), "OutBounce", 0.4, 0.5)
                sightlangStaticImageUsed[1] = true
                if sightlangStaticImageToc[1] then
                  processsightlangStaticImage[1]()
                end
                dxDrawImage(sx - 128 * s, sy - charsetSize * 0.8 * scale - 256 * s * (4 - p2 * 3), 256 * s, 256 * s, sightlangStaticImage[1], 0, 0, 0, tocolor(80, 80, 80, 200 * a * p1))
                sightlangStaticImageUsed[2] = true
                if sightlangStaticImageToc[2] then
                  processsightlangStaticImage[2]()
                end
                dxDrawImage(sx - 128 * s, sy - charsetSize * 0.8 * scale - 256 * s, 256 * s, 256 * s, sightlangStaticImage[2], 0, 0, 0, tocolor(80, 80, 80, 200 * a))
                local cw = 10 * s
                local ch = 70 * s
                local cw2 = ch * 0.6
                local p3 = math.max(0, math.min(1, (p - 1) / 0.35))
                local p4 = math.max(0, math.min(1, (p - 1.5) / 0.35))
                dxDrawRectangle(sx - cw / 2 + 1, sy - charsetSize * 0.8 * scale - 128 * s - ch / 2 + 1, cw, ch * p3, tocolor(0, 0, 0, 125 * a))
                dxDrawRectangle(sx - cw2 / 2 + 1, sy - charsetSize * 0.8 * scale - 128 * s - ch / 2 + ch * 0.3 - cw / 2 + 1, cw2 * p4, cw, tocolor(0, 0, 0, 125 * a))
                dxDrawRectangle(sx - cw / 2, sy - charsetSize * 0.8 * scale - 128 * s - ch / 2, cw, ch * p3, tocolor(80, 80, 80, 255 * a))
                dxDrawRectangle(sx - cw2 / 2, sy - charsetSize * 0.8 * scale - 128 * s - ch / 2 + ch * 0.3 - cw / 2, cw2 * p4, cw, tocolor(80, 80, 80, 255 * a))
                drawSpecialText(sx, sy - charsetSize * scale * 0.5, scale * 0.8, tocolor(80, 80, 80, 225 * a), "Halál oka: " .. data.deathPed[3])
                drawSpecialText(sx, sy, scale, tocolor(80, 80, 80, 225 * a), data.visibleName .. " (" .. data.deathPed[2] .. ")")
              else
                if data.petType then
                  text = "(PET - " .. data.petType .. ")"
                elseif data.pedNameType then
                  text = "(NPC - " .. data.pedNameType .. ")"
                else
                  text = "(NPC)"
                end
                local w = getSpecialTextWidth(scale, data.visibleName .. " ")
                local w2 = getSpecialTextWidth(scale, text)
                sx = sx - (w + w2) / 2
                drawSpecialText(sx, sy, scale, tocolor(colors.hudwhite[1], colors.hudwhite[2], colors.hudwhite[3], 255 * a), data.visibleName, true, w)
                drawSpecialText(sx + w, sy, scale, tocolor(colors.sightorange[1], colors.sightorange[2], colors.sightorange[3], 255 * a), text, true, w2)
              end
            end
          end
        end
      end
    end
  end
end
local namesState = true
sightlangCondHandl1(true)
function getNamesState()
  return namesState
end
function setNamesState(state)
  namesState = state
  if namesState then
    sightlangCondHandl1(true)
  else
    sightlangCondHandl1(false)
  end
end
addCommandHandler("tognames", function()
  namesState = not namesState
  if namesState then
    sightlangCondHandl1(true)
  else
    sightlangCondHandl1(false)
  end
end)
function generateCharsetFile(name, fontIn)
  local font = sightexports.sGui:getFont(fontIn)
  local fontScale = 1
  local height = dxGetFontHeight(fontScale, font)
  outputChatBox(fontIn .. ":")
  outputChatBox("h:" .. height)
  local rt = dxCreateRenderTarget(charsetSize * #charset, charsetSize, true)
  local x = 0
  dxSetRenderTarget(rt)
  local w = dxGetTextWidth(" ", fontScale, font)
  local log = fileCreate("data_" .. name .. ".lua")
  fileWrite(log, "[\"letters\"] = {\n")
  fileWrite(log, "[\"" .. " " .. "\"] = " .. w .. ",\n")
  for i = 1, #charset do
    dxDrawText(charset[i], x + 1, 1, x + charsetSize + 1, charsetSize + 1, tocolor(0, 0, 0), fontScale, font, "center", "center")
    dxDrawText(charset[i], x, 0, x + charsetSize, charsetSize, tocolor(colors.hudwhite[1], colors.hudwhite[2], colors.hudwhite[3]), fontScale, font, "center", "center")
    local w = dxGetTextWidth(charset[i], fontScale, font)
    fileWrite(log, "[\"" .. charset[i] .. "\"] = " .. w .. ",\n")
    x = x + charsetSize
  end
  fileWrite(log, "},\n")
  dxSetRenderTarget()
  if isElement(rt) then
    local pixels = dxGetTexturePixels(rt)
    destroyElement(rt)
    if pixels then
      local convertedPixels = dxConvertPixels(pixels, "plain")
      if convertedPixels then
        local checksum = sha256(convertedPixels)
        if fileExists("charset_" .. name .. ".sight") then
          fileDelete("charset_" .. name .. ".sight")
        end
        local convertedFile = fileCreate("charset_" .. name .. ".sight")
        if convertedFile then
          fileWrite(convertedFile, convertedPixels)
          fileClose(convertedFile)
        end
        fileWrite(log, "--charset checksum: " .. checksum .. "\n")
      end
      local convertedPixels = dxConvertPixels(pixels, "png")
      if convertedPixels then
        local checksum = sha256(convertedPixels)
        if fileExists("charset_" .. name .. ".png") then
          fileDelete("charset_" .. name .. ".png")
        end
        local convertedFile = fileCreate("charset_" .. name .. ".png")
        if convertedFile then
          fileWrite(convertedFile, convertedPixels)
          fileClose(convertedFile)
        end
        fileWrite(log, "--charset checksum: " .. checksum .. "\n")
      end
    end
  end
  fileClose(log)
end
local xp = 0
addCommandHandler("togmyname", function()
  showSelf = not showSelf
  if showSelf then
    local visibleName = getElementData(localPlayer, "visibleName")
    refreshElementNameData(localPlayer, "player", {visibleName = visibleName})
    for i = 1, #namesList do
      if namesList[i] == localPlayer then
        return
      end
    end
    table.insert(namesList, localPlayer)
  else
    for i = 1, #namesList do
      if namesList[i] == localPlayer then
        table.remove(namesList, i)
        break
      end
    end
  end
end)

local placedDoMessages = {}

--[[
local messageText = table.concat({...}, " ")
if messageText == "" then
    outputChatBox("Használat: /placedo [üzenet]", 255, 0, 0)
    return
end

local x, y, z = getElementPosition(localPlayer)
local dimension = getElementDimension(localPlayer)
local interior = getElementInterior(localPlayer)
local characterId = getElementData(localPlayer, "char.Id") or 0
local currentTime = getTickCount()

table.insert(placedDoMessages, {
    position = {x, y, z},
    dimension = dimension,
    interior = interior,
    messageText = messageText,
    characterId = characterId,
    creationTime = currentTime,
})
    ]]

addEvent("processDoRequest", true)
addEventHandler("processDoRequest", getRootElement(), function(messageDatas, isDeleted)
  if isDeleted[1] then
    for k, v in ipairs(placedDoMessages) do
      if v.messageId == isDeleted[2] then
        table.remove(placedDoMessages, k)
      end
    end
    return
  end
  messageDatas.creationTime = getTickCount()
  table.insert(placedDoMessages, messageDatas)
end)

local maxScale = 0.8
local minScale = 0.1

local maxAlpha = 200
local minAlpha = 0

local featherImage = false
local featherTopImage = false
local cornerImage = false
local screenWidth, screenHeight = guiGetScreenSize()

addEventHandler("onClientRender", root, function()
  local cameraX, cameraY, cameraZ = getElementPosition(localPlayer)
  local cursorX, cursorY = getCursorPosition()
  if cursorX then
      cursorX = cursorX * screenWidth
      cursorY = cursorY * screenHeight
  else
      cursorX = -1
      cursorY = -1
  end

  local playerDimension = getElementDimension(localPlayer)
  local playerInterior = getElementInterior(localPlayer)
  local myCharacterId = getElementData(localPlayer, "char.Id") or 0
  local myAdminLevel = getElementData(localPlayer, "acc.adminLevel") or 0

  for index, messageData in ipairs(placedDoMessages) do
      if messageData.dimension == playerDimension and messageData.interior == playerInterior then
          local posX, posY, posZ = messageData.position[1], messageData.position[2], messageData.position[3] - 0.15
          if isLineOfSightClear(cameraX, cameraY, cameraZ, posX, posY, posZ, true, false, false, true, false, true, false) then
              local screenX, screenY = getScreenFromWorldPosition(posX, posY, posZ - 0.5, 0, false)
              if screenX and screenY then
                  local distanceBetween = getDistanceBetweenPoints3D(cameraX, cameraY, cameraZ, posX, posY, posZ)
                  local maxVisibleDistance = 20
                  if distanceBetween <= maxVisibleDistance then
                      local distanceProgress = distanceBetween / maxVisibleDistance
                      local scaleMultiplier = interpolateBetween(maxScale, 0, 0, minScale, 0, 0, distanceProgress, "Linear")
                      local scaleProgress = scaleMultiplier

                      local alpha = interpolateBetween(maxAlpha, 0, 0, minAlpha, 0, 0, distanceProgress, "Linear")
                      local bubbleColor = tocolor(20, 20, 20, alpha)
                      local textColor = tocolor(250, 100, 95, alpha)

                      local timeSinceCreated = getTickCount() - messageData.creationTime
                      local typingSpeed = 50
                      local totalCharacters = utf8.len(messageData.messageText)
                      local charactersToShow = math.floor(timeSinceCreated / typingSpeed)

                      if charactersToShow > totalCharacters then
                          charactersToShow = totalCharacters
                      end

                      local messageToDisplay = utf8.sub(messageData.messageText, 1, charactersToShow)

                      local playerName = messageData.charName
                      playerName = playerName:gsub("_", " ")
                      local fullMessage = messageToDisplay .. " ((" .. playerName .. "))"

                      local font = sightexports.sGui:getFont("10/BebasNeueRegular.otf")
                      local textScale = scaleProgress
                      local textWidth = dxGetTextWidth(fullMessage, textScale, font)
                      local textHeight = dxGetFontHeight(textScale, font)
                      local boxWidth = textWidth + 10
                      local boxHeight = textHeight + 7.5

                      local boxX = screenX - boxWidth / 2
                      local boxY = screenY - boxHeight / 2

                      local featherSize = 12 * textScale

                      dxDrawRectangle(boxX, boxY, boxWidth, boxHeight, bubbleColor)

                      if not featherImage or not featherTopImage or not cornerImage then
                          featherImage = dxCreateTexture(":sHud/files/feather.dds", "dxt5", true, "clamp")
                          featherTopImage = dxCreateTexture(":sHud/files/featherTop.dds", "dxt5", true, "clamp")
                          cornerImage = dxCreateTexture(":sHud/files/corner.dds", "dxt5", true, "clamp")
                      end

                      dxDrawImage(boxX - featherSize, boxY, featherSize, boxHeight, featherImage, 180, 0, 0, bubbleColor)
                      dxDrawImage(boxX + boxWidth, boxY, featherSize, boxHeight, featherImage, 0, 0, 0, bubbleColor)
                      dxDrawImage(boxX, boxY - featherSize, boxWidth, featherSize, featherTopImage, 180, 0, 0, bubbleColor)
                      dxDrawImage(boxX, boxY + boxHeight, boxWidth, featherSize, featherTopImage, 0, 0, 0, bubbleColor)
                      dxDrawImage(boxX - featherSize, boxY - featherSize, featherSize, featherSize, cornerImage, 270, 0, 0, bubbleColor)
                      dxDrawImage(boxX + boxWidth, boxY - featherSize, featherSize, featherSize, cornerImage, 0, 0, 0, bubbleColor)
                      dxDrawImage(boxX - featherSize, boxY + boxHeight, featherSize, featherSize, cornerImage, 180, 0, 0, bubbleColor)
                      dxDrawImage(boxX + boxWidth, boxY + boxHeight, featherSize, featherSize, cornerImage, 90, 0, 0, bubbleColor)

                      dxDrawText(fullMessage, boxX + 5, boxY, boxX + boxWidth - 5, boxY + boxHeight, textColor, textScale, font, "center", "center", true, true)

                      if distanceBetween <= 10 then
                          if messageData.characterId == myCharacterId or myAdminLevel >= 1 then
                              local iconSize = 32 * textScale
                              local iconX = screenX - iconSize / 2
                              local iconY = boxY + boxHeight + 10
                              local trashImage = "files/trash.png"
                              local iconAlpha = alpha

                              if cursorX >= iconX and cursorX <= iconX + iconSize and cursorY >= iconY and cursorY <= iconY + iconSize then
                                  dxDrawImage(iconX, iconY, iconSize, iconSize, trashImage, 0, 0, 0, tocolor(255, 40, 80, iconAlpha))
                                  if getKeyState("mouse1") and not messageData.clicked then
                                      messageData.clicked = true
                                      triggerServerEvent("tryToDeletePlacedo", localPlayer, messageData.messageId)
                                  elseif not getKeyState("mouse1") then
                                      messageData.clicked = false
                                  end
                              else
                                  dxDrawImage(iconX, iconY, iconSize, iconSize, trashImage, 0, 0, 0, tocolor(255, 40, 80, iconAlpha * 0.6))
                              end
                          end
                      end
                  end 
              end
          end
      end
  end
end)

function setAirsoftColor(el, color)
	setElementData(el, "airsoftColor", false)
	setElementData(el, "airsoftColor", color)
	refreshElementNameData(el, "player", {airsoft = color})
	if namesData[el] then
		namesData[el].airsoft = color
	end
end