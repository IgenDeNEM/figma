emergencyCallList = {
  {
    "Rendőrség",
    {
      "PD",
      "NNI",
      "TEK",
      "OPSZ"
    },
    "siren-on",
    "emergency",
    "Járőrt szeretnék"
  },
  {
    "Mentők",
    {"OMSZ"},
    "briefcase-medical",
    "emergency",
    "Mentőt szeretnék"
  },
  {
    "Tűzoltók",
    {"OKF"},
    "fire-smoke",
    "emergency",
    "Tűzoltót szeretnék"
  },
  {
    "Autómentő",
    {
      "BMS",
      "FIX",
      "APMS",
      "RING",
      "TOW"
    },
    "car-mechanic",
    "services",
    "Autómentőt szeretnék"
  },
  {
    "Taxi",
    {"TAXI"},
    "taxi",
    "services",
    "Sofőrt szeretnék"
  },
  {
    "Parkolásfelügyelet",
    {"PF"},
    "parking",
    "services",
    "Parkolóőrt szeretnék"
  },
  {
    "NAV",
    {"NAV"},
    "coins",
    "services",
    "Pénzügyőrt szeretnék"
  }
}
byGroupPrefix = {}
for i = 1, #emergencyCallList do
  for j = 1, #emergencyCallList[i][2] do
    byGroupPrefix[emergencyCallList[i][2][j]] = i
  end
end
byEmergencyType = {}
for i = 1, #emergencyCallList do
  if not byEmergencyType[emergencyCallList[i][4]] then
    byEmergencyType[emergencyCallList[i][4]] = {}
  end
  byEmergencyType[emergencyCallList[i][4]][i] = emergencyCallList[i]
end
function getEmergencyCallList(theType)
  return byEmergencyType[theType]
end
