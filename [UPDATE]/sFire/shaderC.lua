local function r1_0(r0_1, r1_1, r2_1)
	if r0_1 and r1_1 and r2_1 then
		r0_1 = base64Decode(r0_1)
		r1_1 = utf8.byte(r1_1)
		r2_1 = math.floor(utf8.byte(r2_1) / 2)
		local r3_1 = ""
		local r4_1 = utf8.len(r0_1)
		local r5_1 = 1
		for r9_1 = 1, r4_1, 1 do
			if r5_1 == r2_1 then
				r1_1 = utf8.byte(utf8.sub(r0_1, r9_1, r9_1))
				r5_1 = 1
			else
				r5_1 = r5_1 + 1
				r3_1 = r3_1 .. utf8.char(bitXor(utf8.byte(utf8.sub(r0_1, r9_1, r9_1)), r1_1))
			end
		end
		return r3_1
	end
end
local function r2_0(r0_2, r1_2, r2_2, r3_2, r4_2)
	-- line: [1, 1] id: 2
	local r5_2 = ""
	local r6_2 = utf8.len(r0_2)
	local r7_2 = nil
	local r8_2 = nil
	local r9_2 = nil
	for r13_2 = 1, r6_2, 1 do
		local r14_2 = utf8.sub(r0_2, r13_2, r13_2)
		if r14_2 == "ö" or r14_2 == "ü" or r14_2 == "ó" or r14_2 == "ő" or r14_2 == "ú" or r14_2 == "é" or r14_2 == "á" or r14_2 == "ű" or r14_2 == "Ö" or r14_2 == "Ü" or r14_2 == "Ó" or r14_2 == "Ő" or r14_2 == "Ú" or r14_2 == "Á" or r14_2 == "Ű" or r14_2 == "É" then
			if r9_2 then
				r5_2 = r5_2 .. r1_0(r9_2, r7_2, r8_2)
				r9_2 = nil
				r7_2 = nil
				r8_2 = nil
			else
				r9_2 = ""
			end
		elseif r9_2 then
			if not r7_2 then
				r7_2 = r14_2
			elseif not r8_2 then
				r8_2 = r14_2
			else
				r9_2 = r9_2 .. r14_2
			end
		else
			r5_2 = r5_2 .. r14_2
		end
	end
	local r10_2 = dxCreateShader(r5_2, r1_2, r2_2, r3_2, r4_2)
	r5_2 = nil
	collectgarbage("collect")
	return r10_2
end
shader = false
rt = false
safeZone = 110
maxSpriteSize = safeZone * math.sin(math.rad(45)) * 2
particles = {}
function spawnParticle()
	-- line: [12, 28] id: 3
	local rnd = math.random() * 0.75 + 0.5
	table.insert(particles, {
		x = math.random() * 2 - 1,
		y = 0,
		r = math.random() * 360,
		s = math.random() * 0.75 + 0.25,
		rp = math.random() * 60 - 120,
		sxp = math.random() * 0.5 + 0.5,
		syp = rnd,
		shr = math.random() * 0.75 + 0.25,
		tx = (math.random() * 2 - 1) * 0.125,
		f = 0,
		fo = 2 + math.random() * (1 / rnd * 0.5 - 2),
		a = 10 + 100 * math.random(),
	})
end
local r3_0 = [[
texture fireTexture;
sampler fireSampler = sampler_state { Texture = <fireTexture>; };

float3 partCol(float p) {
	float3 color1 = float3(255, 255, 200);
	float3 color2 = float3(255, 200, 20);
	float3 color3 = float3(255, 50, 15);

	if (p < 0.5) {
		return color1 + (color2 - color1) * p * 2;
	} else {
		return color2 + (color3 - color2) * (p - 0.5) * 2;
	}
}

float4 PixelShaderFunction(float2 TexCoord : TEXCOORD0) : COLOR0 {
	float4 fire = tex2D(fireSampler, TexCoord);
	return float4(partCol(1-fire.r)/255, fire.a);
}

technique Technique1 {
	pass Pass1 {
		PixelShader = compile ps_2_0 PixelShaderFunction();
	}
}
]]
local r4_0 = false
function setupFireShaders(r0_4)
	-- line: [73, 86] id: 4
	if r0_4 ~= r4_0 then
		if isElement(rt) then
			destroyElement(rt)
		end
		rt = nil
		if isElement(shader) then
			destroyElement(shader)
		end
		shader = nil
		if r0_4 then
			shader = r2_0(r3_0)
			rt = dxCreateRenderTarget(256, 512, true)
			dxSetShaderValue(shader, "fireTexture", rt)
		end
		r4_0 = r0_4
	end
end
