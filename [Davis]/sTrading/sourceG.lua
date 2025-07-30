indexes = {
	AMB = {
		base = 1000,
		mining = true,
	},
	AME = {
		base = 1000,
		mining = true,
	},
	ALU = {
		base = 1000,
		mining = true,
	},
	CHR = {
		base = 1000,
		mining = true,
	},
	COL = {
		base = 1000,
		mining = true,
	},
	COP = {
		base = 1000,
		mining = true,
	},
	DIA = {
		base = 1000,
		mining = true,
	},
	EMD = {
		base = 1000,
		mining = true,
	},
	GOL = {
		base = 1000,
		mining = true,
	},
	IRN = {
		base = 1000,
		mining = true,
	},
	NIK = {
		base = 1000,
		mining = true,
	},
	PLT = {
		base = 1000,
		mining = true,
	},
	RUB = {
		base = 1000,
		mining = true,
	},
	SRC = {
		base = 1000,
		mining = true,
	},
}

function priceFromRate(r0_1, r1_1)
	return (100 + math.pow(math.max(0, (r0_1 - 1)), 3) * 20 - math.pow(math.max(0, (1 - r0_1)), 2) * 50) / 100 * r1_1
end

indexList = {}

for k, v in pairs(indexes) do
	table.insert(indexList, k)
end

function getIndexList()
	return indexList
end
function getHistory(index)
	return indexes[index].history
end
function getPrice(index)
	return indexes[index].price
end
function getTrend(index)
	return indexes[index].trend
end
function isValidIndex(index)
	return indexes[index] and true or false
end

function avgMed(r0_7)
	local r1_7 = 0
	local r2_7 = 0
	local r3_7 = {}
	local r4_7 = 0
	for r8_7 = 1, #r0_7, 1 do
		if r0_7[r8_7] then
			r1_7 = r1_7 + r0_7[r8_7]
			r2_7 = r2_7 + 1
			if r2_7 > 1 then
				local r9_7 = false
				for r13_7 = 1, #r3_7, 1 do
					if r0_7[r8_7] < r3_7[r13_7] then
						table.insert(r3_7, r13_7, r0_7[r8_7])
						r9_7 = true
						break
					end
				end
				if not r9_7 then
					table.insert(r3_7, r0_7[r8_7])
				end
				r4_7 = r4_7 + 1
			else
				table.insert(r3_7, r0_7[r8_7])
				r4_7 = 1
			end
		end
	end
	local r5_7 = 0
	if r4_7 > 0 then
		if r4_7 % 2 == 0 then
			r5_7 = (r3_7[r4_7 / 2] + r3_7[r4_7 / 2 + 1]) / 2
		else
			r5_7 = r3_7[math.ceil(r4_7 / 2)]
		end
	end
	return r1_7 / r2_7, r5_7
end

function getStats(index)
	local currentIndex = indexes[index]

	if currentIndex.last12Hourly or currentIndex.hour12List then
		local stats = {}
		table.insert(stats, currentIndex.last12Hourly)
		for i = 1, 3, 1 do
			if currentIndex.hour12List and currentIndex.hour12List[i] then
				table.insert(stats, currentIndex.hour12List[i])
			else
				table.insert(stats, {
					0,
					0
				})
			end
		end
		return stats
	end
end
