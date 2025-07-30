local floor = math.floor

local function SAFEMUL32(a, b)
	local alo = floor(a % 65536)
	local ahi = floor(a / 65536) % 65536
	local blo = floor(b % 65536)
	local bhi = floor(b / 65536) % 65536
	local lolo = alo * blo
	local lohi = alo * bhi
	local hilo = ahi * blo
	local llhh = lohi + hilo
	return floor((llhh * 65536 + lolo) % 4294967296)
end

local AND = bitAnd
local OR = bitOr
local XOR = bitXor

local SHR1  = function(y) return floor(y / 2)          end
local SHR30 = function(y) return floor(y / 1073741824) end
local SHR11 = function(y) return floor(y / 2048)       end
local SHL7  = function(y) return (y * 128)             end
local SHL15 = function(y) return (y * 32768)           end
local SHR18 = function(y) return floor(y / 262144)     end
local BIT0  = function(y) return (y % 2)               end

local N = 624
local M = 397
local MATRIX_A = 0x9908B0DF
local UPPER_MASK = 0x80000000
local LOWER_MASK = 0x7FFFFFFF
local DIVISOR = 2.3283064370807974e-10
local DEFAULT_SEED = 5489

local mt19937ar = {} -- mersenne twister algorithm

function rngRandomSeed()
	return math.random(100000000, 999999999)
end

function rngSetSeed(id, seed)
	local rng = mt19937ar[id]

	if rng then
		rng.mt[0] = AND(seed, 0xFFFFFFFF)

		for i = 1, N - 1 do
			rng.mt[i] = SAFEMUL32(1812433253, XOR(rng.mt[i - 1], SHR30(rng.mt[i - 1]))) + i
			rng.mt[i] = AND(rng.mt[i], 0xFFFFFFFF)
		end

		rng.mti = N
	end
end

function rngCreate(seed)
	local id = 1

	while mt19937ar[id] do
		id = id + 1
	end

	mt19937ar[id] = {}
	mt19937ar[id].mt = {}
	rngSetSeed(id, seed)

	return id
end

function rngDelete(id)
	mt19937ar[id] = nil
	collectgarbage()
end

function rngSkip(id, value)
	local rng = mt19937ar[id]

	if rng then
		local mt = rng.mt

		for i = 1, value do
			if N <= rng.mti then
				local y = nil

				if rng.mti == N + 1 then
					rngSetSeed(id, DEFAULT_SEED)
				end

				for kk = 0, N-M-1 do
					y = OR(AND(mt[kk], UPPER_MASK), AND(mt[kk + 1], LOWER_MASK))
					mt[kk] = XOR(mt[kk + M], XOR(SHR1(y), BIT0(y) * MATRIX_A))
					kk = kk + 1
				end

				for kk = N-M, N-2 do
					y = OR(AND(mt[kk], UPPER_MASK), AND(mt[kk + 1], LOWER_MASK))
					mt[kk] = XOR(mt[kk + M - N], XOR(SHR1(y), BIT0(y) * MATRIX_A))
					kk = kk + 1
				end

				y = OR(AND(mt[N - 1], UPPER_MASK), AND(mt[0], LOWER_MASK))
				mt[N - 1] = XOR(mt[M - 1], XOR(SHR1(y), BIT0(y) * MATRIX_A))
				rng.mti = 0
			end

			rng.mti = rng.mti + 1
		end
	end
end

function rngGetValue(id)
	local rng = mt19937ar[id]

	if rng then
		local mt = rng.mt
		local y = nil

		if N <= rng.mti then
			if rng.mti == N + 1 then
				rngSetSeed(id, DEFAULT_SEED)
			end

			for kk = 0, N-M-1 do
				y = OR(AND(mt[kk], UPPER_MASK), AND(mt[kk + 1], LOWER_MASK))
				mt[kk] = XOR(mt[kk + M], XOR(SHR1(y), BIT0(y) * MATRIX_A))
				kk = kk + 1
			end

			for kk = N-M, N-2 do
				y = OR(AND(mt[kk], UPPER_MASK), AND(mt[kk + 1], LOWER_MASK))
				mt[kk] = XOR(mt[kk + M - N], XOR(SHR1(y), BIT0(y) * MATRIX_A))
				kk = kk + 1
			end

			y = OR(AND(mt[N - 1], UPPER_MASK), AND(mt[0], LOWER_MASK))
			mt[N - 1] = XOR(mt[M - 1], XOR(SHR1(y), BIT0(y) * MATRIX_A))
			rng.mti = 0
		end

		y = mt[rng.mti]
		rng.mti = rng.mti + 1

		y = XOR(y, SHR11(y))
		y = XOR(y, AND(SHL7(y), 0x9D2C5680))
		y = XOR(y, AND(SHL15(y), 0xEFC60000))
		y = XOR(y, SHR18(y))

		return y * DIVISOR
	end
end
