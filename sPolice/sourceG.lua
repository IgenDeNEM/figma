rbsList = {
  [552] = {
    "rbs1",
    "rbs2",
    "rbs37",
    "rbs38",
    "rbs3",
    "rbs4",
    "rbs5",
    "rbs6",
    "rbs7",
    "rbs8",
    "rbs39",
    "rbs40",
    "rbs41",
    "rbs9",
    "rbs10",
    "rbs11",
    "rbs12",
    "rbs13",
    "rbs14",
    "rbs15",
    "rbs16",
    "rbs36",
    "rbs17",
    "rbs18",
    "rbs19",
    "rbs20",
    "rbs21",
    "rbs22",
    "rbs23",
    "rbs24",
    "rbs25",
    "rbs26",
    "rbs27",
    "rbs28",
    "rbs29",
    "rbs30",
    "rbs31",
    "rbs32",
    "rbs33",
    "rbs34",
    "rbs35",
    "rbs42",
    "rbs43",
    "rbs44"
  }
}
local smallRbsVehicles = {
  443,
  466,
  580,
  404,
  596,
  492,
  445,
  598,
  400,
  413,
  470,
  500,
  438,
  582,
  579,
  566,
  597,
  418,
  458,
  490,
  416,
  548,
  476,
  593,
  433,
  601,
  427,
  544,
  407,
  505
}
for i = 1, #smallRbsVehicles do
  rbsList[smallRbsVehicles[i]] = {
    "rbs1",
    "rbs2",
    "rbs3",
    "rbs4",
    "rbs5",
    "rbs6",
    "rbs7",
    "rbs8",
    "rbs9",
    "rbs10",
    "rbs11",
    "rbs12",
    "rbs13",
    "rbs35",
    "rbs36",
    "rbs37",
    "rbs38",
    "rbs39",
    "rbs40",
    "rbs42",
    "rbs43",
    "rbs44"
  }
end
sharedRBSVehicles = {
  [552] = true,
  [596] = true,
  [490] = true,
  [598] = true,
  [597] = true
}
rbsVehicles = {}
validRBSModels = {}
for model in pairs(rbsList) do
  rbsVehicles[model] = true
  for i = 1, #rbsList[model] do
    validRBSModels[rbsList[model][i]] = true
  end
end
