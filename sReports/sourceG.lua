reportCategories = {
	"Bug/Hiba",
	"Kérdések",
	"Segítségkérés",
	"Szabálysértés/Panasz",
	"FőAdmin/SzuperAdmin",
	"Egyéb"
}
categoryColors = {
	["Bug/Hiba"] = "sightred",
	["Kérdések"] = "sightblue",
	["Segítségkérés"] = "sightpurple",
	["Szabálysértés/Panasz"] = "sightyellow",
	["FőAdmin/SzuperAdmin"] = "sightorange"
}
if triggerClientEvent then
	if fileExists("categorycolors.sight") then
		fileDelete("categorycolors.sight")
	end
	local file = fileCreate("categorycolors.sight")
	for i, v in pairs(categoryColors) do
		fileWrite(file, i .. ";" .. v:gsub("sight", "") .. "\n")
	end
	fileClose(file)
end
actionButtons = {
	{
		"goto",
		"hozzád teleportált."
	},
	{"spec", false},
	{"stats", false},
	{"eco", false},
	{
		"asegit",
		"felsegített."
	},
	{
		"agyogyit",
		"meggyógyított."
	},
	{
		"vhspawn",
		"a városházára teleportált."
	},
	{
		"gethere",
		"magához teleportált."
	}
}
function getReportCategories()
	return reportCategories
end
