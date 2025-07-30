NPC_SPEED_ONFOOT = {
  walk = 1.5559,
  run = 5.706,
  sprint = 9.562,
  sprintfast = 12.281
}
NPC_DATAINFO_NPC = -1
NPC_DATAINFO_TRUEDATA = -2
NPC_DATA_BEHAVIOR_WALK_SPEED = 1
NPC_DATA_BEHAVIOR_WEAPON_ACCURACY = 2
NPC_DATA_TASKNUM_FIRST = 3
NPC_DATA_TASKNUM_LAST = 4
NPC_DATA_TASKNUM_THIS = 5
NPC_TASK_WALK_TO_POS = 1
NPC_TASK_WALK_ALONG_LINE = 2
NPC_TASK_WALK_FOLLOW_ELEMENT = 3
NPC_TASK_SHOOT_POINT = 4
NPC_TASK_SHOOT_ELEMENT = 5
NPC_TASK_KILL_PED = 6
availablePets = {
  Husky = 9,
  Rottweiler = 296,
  Doberman = 297,
  ["Bull Terrier"] = 298,
  Boxer = 257,
  ["Francia Bulldog"] = 256,
  Kecske = 278,
  Diszno = 277
}

function getAvailablePets()
  return availablePets
end
function getPercentageInLine(x, y, x1, y1, x2, y2)
  x, y = x - x1, y - y1
  local yx, yy = x2 - x1, y2 - y1
  return (x * yx + y * yy) / (yx * yx + yy * yy)
end
function getAngleInBend(x, y, x0, y0, x1, y1, x2, y2)
  x, y = x - x0, y - y0
  local yx, yy = x1 - x0, y1 - y0
  local xx, xy = x2 - x0, y2 - y0
  local rx = (x * yy - y * yx) / (xx * yy - xy * yx)
  local ry = (x * xy - y * xx) / (yx * xy - yy * xx)
  return math.atan2(rx, ry)
end
function getPosFromBend(angle, x0, y0, x1, y1, x2, y2)
  local yx, yy = x1 - x0, y1 - y0
  local xx, xy = x2 - x0, y2 - y0
  local rx, ry = math.sin(angle), math.cos(angle)
  return rx * xx + ry * yx + x0, rx * xy + ry * yy + y0
end
function isHLCEnabled(npc)
  return isElement(npc) and getElementData(npc, "ped.isControllable") or false
end
function getNPCWalkSpeed(npc)
  if not isHLCEnabled(npc) then
    return false
  end
  return getElementData(npc, "ped.walk_speed")
end
function getNPCWeaponAccuracy(npc)
  return getElementData(npc, "ped.accuracy")
end
