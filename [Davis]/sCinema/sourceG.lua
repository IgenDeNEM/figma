rooms = {
  {
    1117.59,
    -1490.01,
    32.7188,
    1,
    1,
    50,
    false,
    1154.55615,
    -1529.63989,
    15.78209,
    0,
    0
  },
  {
    1117.59,
    -1490.01,
    32.7188,
    1,
    2,
    50,
    false,
    1164.05261,
    -1531.70166,
    22.84216,
    0,
    0
  }
}
ticketPrice = 50
for i = 1, #rooms do
  rooms[i][7] = createColSphere(rooms[i][1], rooms[i][2], rooms[i][3], rooms[i][6])
  setElementInterior(rooms[i][7], rooms[i][4])
  setElementDimension(rooms[i][7], rooms[i][5])
end
