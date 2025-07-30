pavilionPoses = {}
for d = 1.5, 6.5, 1.25 do
  for r = 0, math.pi * 2, math.pi / 8 do
    table.insert(pavilionPoses, {d, r})
  end
end
clubPoses = {}
for x = 0, 9 do
  for y = 0, 10 do
    table.insert(clubPoses, {x, y})
  end
end
danceAnims = {
  {"DANCING", "dance_loop"},
  {"DANCING", "DAN_Down_A"},
  {"DANCING", "DAN_Left_A"},
  {"DANCING", "DAN_Loop_A"},
  {
    "DANCING",
    "DAN_Right_A"
  },
  {"DANCING", "DAN_Up_A"},
  {"DANCING", "dnce_M_a"},
  {"DANCING", "dnce_M_b"},
  {"DANCING", "dnce_M_c"},
  {"DANCING", "dnce_M_d"},
  {"DANCING", "dnce_M_e"},
  {
    "SGSDdnce_M_e",
    "dnce_M_e"
  },
  {
    "SGSDdnce_M_b",
    "dnce_M_b"
  },
  {
    "SGSDdnce_M_a",
    "dnce_M_a"
  },
  {
    "SGSDDAN_Up_A",
    "DAN_Up_A"
  },
  {
    "SGSDDAN_Right_A",
    "DAN_Right_A"
  },
  {
    "SGSDDAN_Loop_A",
    "DAN_Loop_A"
  },
  {
    "SGSDDAN_Left_A",
    "DAN_Left_A"
  },
  {
    "SGSDDAN_Down_A",
    "DAN_Down_A"
  },
  {
    "SGSDdance_loop",
    "dance_loop"
  },
  {
    "SGSDbd_clap1",
    "bd_clap1"
  },
  {
    "SGSDbd_clap",
    "bd_clap"
  },
  {
    "GYMNASIUM",
    "GYMshadowbox"
  },
  {"CRACK", "crckdeth2"},
  {
    "SGSSEcrckidle2",
    "crckidle2"
  },
  {
    "SGSclap1_tran_gtup",
    "tran_gtup"
  },
  {
    "SGSclap2_tran_hng",
    "tran_hng"
  },
  {
    "COP_AMBIENT",
    "Coplook_shake"
  }
}
