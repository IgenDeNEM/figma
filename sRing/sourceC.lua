local sightexports = {
  sGui = false,
  sSpeedo = false,
  sModloader = false
}
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
local sightlangCondHandlState0 = false
local function sightlangCondHandl0(cond, prio)
  cond = cond and true or false
  if cond ~= sightlangCondHandlState0 then
    sightlangCondHandlState0 = cond
    if cond then
      addEventHandler("onClientPreRender", getRootElement(), preRenderInSeeRing, true, prio)
    else
      removeEventHandler("onClientPreRender", getRootElement(), preRenderInSeeRing)
    end
  end
end
origFE = fileExists
origFC = fileCreate
origFO = fileOpen
origFD = fileDelete
origFCP = fileCopy
function fileCopy(source, target, ow)
  return origFCP("!sightring_sight/" .. source, "!sightring_sight/" .. target, ow)
end
function fileExists(f)
  return origFE("!sightring_sight/" .. f)
end
function fileCreate(f)
  return origFC("!sightring_sight/" .. f)
end
function fileOpen(f)
  return origFO("!sightring_sight/" .. f)
end
function fileDelete(f)
  return origFD("!sightring_sight/" .. f)
end
local screenX, screenY = guiGetScreenSize()
local pitLimiter = createColPolygon(-1218.087890625, 217.5185546875, -1218.087890625, 217.5185546875, -1205.7822265625, 204.0380859375, -1211.4697265625, 197.5, -1188.541015625, 174.4326171875, -1371.5908203125, -7.80859375, -1395.1611328125, 16.0615234375, -1427.8291015625, -16.0546875, -1439.818359375, -3.951171875)
local curves = {
  {
    {
      {
        -1330.09375,
        119.9931640625,
        14.9140625
      },
      {
        -1320.09375,
        129.9931640625,
        14.9140625
      },
      {
        -1310.09375,
        139.9931640625,
        14.9140625
      }
    },
    {
      {
        -1160.543,
        286.729,
        965.586
      },
      {
        -1150.543,
        296.729,
        965.586
      },
      {
        -1132.166,
        315.864,
        965.586
      }
    },
    {
      {
        -1038.651,
        410.631,
        963.897
      },
      {
        -967.955,
        340.233,
        965.586
      },
      {
        -902.559,
        275.113,
        967.149
      }
    },
    {
      {
        -915.99,
        196.022,
        965.586
      },
      {
        -955.418,
        125.733,
        965.586
      },
      {
        -964.881,
        108.863,
        965.586
      }
    },
    {
      {
        -1064.36,
        -74.281,
        965.586
      },
      {
        -1100.035,
        -142.924,
        965.586
      },
      {
        -1113.272,
        -168.394,
        965.586
      }
    },
    {
      {
        -1078.867,
        -164.623,
        965.586
      },
      {
        -1088.682,
        -192.341,
        965.586
      },
      {
        -1120.832,
        -283.128,
        965.586
      }
    },
    {
      {
        -1218.142,
        -577.227,
        993.133
      },
      {
        -1235.793,
        -624.822,
        996.027
      },
      {
        -1244.649,
        -648.701,
        997.478
      }
    },
    {
      {
        -1269.475,
        -655.763,
        999.79
      },
      {
        -1279.874,
        -657.263,
        1000.457
      },
      {
        -1332.909,
        -664.913,
        1003.859
      }
    },
    {
      {
        -1417.893,
        -674.32,
        1006.121
      },
      {
        -1464.668,
        -674.733,
        1005.4
      },
      {
        -1511.888,
        -675.149,
        1004.673
      }
    },
    {
      {
        -1587.105,
        -671.409,
        993.967
      },
      {
        -1629.26,
        -656.372,
        985.586
      },
      {
        -1650.498,
        -648.796,
        981.365
      }
    },
    {
      {
        -1694.096,
        -627.923,
        965.586
      },
      {
        -1699.096,
        -556.818,
        965.586
      },
      {
        -1701.049,
        -529.042,
        965.586
      }
    },
    {
      {
        -1702.102,
        -481.771,
        965.586
      },
      {
        -1702.102,
        -481.771,
        965.586
      },
      {
        -1702.102,
        -481.771,
        965.586
      }
    },
    {
      {
        -1701.677,
        -400.124,
        965.586
      },
      {
        -1701.716,
        -389.77,
        965.586
      },
      {
        -1701.823,
        -360.729,
        965.586
      }
    },
    {
      {
        -1695.127,
        -262.801,
        965.586
      },
      {
        -1693.442,
        -252.585,
        965.586
      },
      {
        -1684.767,
        -199.994,
        965.586
      }
    },
    {
      {
        -1663.408,
        -172.655,
        965.586
      },
      {
        -1657.948,
        -163.849,
        965.586
      },
      {
        -1650.803,
        -152.328,
        965.586
      }
    },
    {
      {
        -1636.369,
        -136.632,
        965.586
      },
      {
        -1624.621,
        -129.96,
        965.586
      },
      {
        -1607.278,
        -120.109,
        965.586
      }
    },
    {
      {
        -1591.113,
        -123.875,
        965.586
      },
      {
        -1579.531,
        -140.146,
        965.586
      },
      {
        -1560.565,
        -166.791,
        965.586
      }
    },
    {
      {
        -1551.831,
        -167.796,
        965.586
      },
      {
        -1540.283,
        -173.604,
        965.586
      },
      {
        -1525.166,
        -181.208,
        965.586
      }
    },
    {
      {
        -1506.986,
        -179.467,
        965.586
      },
      {
        -1494.646,
        -174.495,
        965.586
      },
      {
        -1476.383,
        -167.135,
        965.586
      }
    },
    {
      {
        -1352.295,
        -100.13,
        965.586
      },
      {
        -1340.539,
        -82.546,
        965.586
      },
      {
        -1324.412,
        -58.424,
        965.586
      }
    },
    {
      {
        -1350.25,
        -17.852,
        965.586
      },
      {
        -1395.585,
        -43.506,
        965.586
      },
      {
        -1421.898,
        -58.397,
        965.586
      }
    },
    {
      {
        -1448.135,
        -88.86,
        965.586
      },
      {
        -1474.167,
        -57.472,
        965.586
      },
      {
        -1493.014,
        -34.748,
        965.586
      }
    },
    {
      {
        -1454.466,
        -4.564,
        965.586
      },
      {
        -1447.539,
        2.845,
        965.586
      },
      {
        -1429.356,
        22.294,
        965.586
      }
    }
  },
  {
    {
      {
        -1330.09375,
        119.9931640625,
        14.9140625
      },
      {
        -1320.09375,
        129.9931640625,
        14.9140625
      },
      {
        -1310.09375,
        139.9931640625,
        14.9140625
      }
    },
    {
      {
        -1160.543,
        286.729,
        965.586
      },
      {
        -1150.543,
        296.729,
        965.586
      },
      {
        -1132.166,
        315.864,
        965.586
      }
    },
    {
      {
        -1038.651,
        410.631,
        963.897
      },
      {
        -967.955,
        340.233,
        965.586
      },
      {
        -902.559,
        275.113,
        967.149
      }
    },
    {
      {
        -915.99,
        196.022,
        965.586
      },
      {
        -955.418,
        125.733,
        965.586
      },
      {
        -964.881,
        108.863,
        965.586
      }
    },
    {
      {
        -1064.36,
        -74.281,
        965.586
      },
      {
        -1100.035,
        -142.924,
        965.586
      },
      {
        -1113.272,
        -168.394,
        965.586
      }
    },
    {
      {
        -1078.867,
        -164.623,
        965.586
      },
      {
        -1088.682,
        -192.341,
        965.586
      },
      {
        -1120.832,
        -283.128,
        965.586
      }
    },
    {
      {
        -1185.643,
        -452.374,
        980.24
      },
      {
        -1191.871,
        -498.318,
        984.893
      },
      {
        -1196.873,
        -535.213,
        988.63
      }
    },
    {
      {
        -1240.214,
        -514.82,
        987.539
      },
      {
        -1257.395,
        -516.373,
        987.597
      },
      {
        -1333.616,
        -523.262,
        987.855
      }
    },
    {
      {
        -1273.302,
        -456.494,
        989.647
      },
      {
        -1383.564,
        -470.463,
        981.229
      },
      {
        -1392.094,
        -471.544,
        980.578
      }
    },
    {
      {
        -1409.613,
        -472.033,
        980.008
      },
      {
        -1439.016,
        -463.032,
        980.009
      },
      {
        -1473.006,
        -452.625,
        980.01
      }
    },
    {
      {
        -1505.081,
        -443.986,
        977.577
      },
      {
        -1503.668,
        -414.215,
        975.34
      },
      {
        -1502.199,
        -383.271,
        973.016
      }
    },
    {
      {
        -1495.771,
        -299.269,
        969.945
      },
      {
        -1493.858,
        -244.465,
        966.639
      },
      {
        -1492.654,
        -209.976,
        964.558
      }
    },
    {
      {
        -1476.337,
        -186.486,
        964.921
      },
      {
        -1457.665,
        -166.57,
        964.921
      },
      {
        -1422.251,
        -128.798,
        964.921
      }
    },
    {
      {
        -1352.295,
        -100.13,
        965.586
      },
      {
        -1340.539,
        -82.546,
        965.586
      },
      {
        -1324.412,
        -58.424,
        965.586
      }
    },
    {
      {
        -1350.25,
        -17.852,
        965.586
      },
      {
        -1395.585,
        -43.506,
        965.586
      },
      {
        -1421.898,
        -58.397,
        965.586
      }
    },
    {
      {
        -1448.135,
        -88.86,
        965.586
      },
      {
        -1474.167,
        -57.472,
        965.586
      },
      {
        -1493.014,
        -34.748,
        965.586
      }
    },
    {
      {
        -1454.466,
        -4.564,
        965.586
      },
      {
        -1447.539,
        2.845,
        965.586
      },
      {
        -1429.356,
        22.294,
        965.586
      }
    }
  },
  {
    {
      {
        -1330.09375,
        119.9931640625,
        14.9140625
      },
      {
        -1320.09375,
        129.9931640625,
        14.9140625
      },
      {
        -1310.09375,
        139.9931640625,
        14.9140625
      }
    },
    {
      {
        -1160.543,
        286.729,
        965.586
      },
      {
        -1150.543,
        296.729,
        965.586
      },
      {
        -1132.166,
        315.864,
        965.586
      }
    },
    {
      {
        -1038.651,
        410.631,
        963.897
      },
      {
        -967.955,
        340.233,
        965.586
      },
      {
        -902.559,
        275.113,
        967.149
      }
    },
    {
      {
        -915.99,
        196.022,
        965.586
      },
      {
        -955.418,
        125.733,
        965.586
      },
      {
        -964.881,
        108.863,
        965.586
      }
    },
    {
      {
        -1074.2626953125,
        -109.041015625,
        16.640991210938
      },
      {
        -1104.063,
        -129.784,
        964.668
      },
      {
        -1152.419,
        -172.941,
        964.668
      }
    },
    {
      {
        -1158.384765625,
        -174.4589843755,
        14.650242805481
      },
      {
        -1217.29296875,
        -181.8408203125,
        14.722231864929
      },
      {
        -1244.7431640625,
        -193.3154296875,
        17.638603210449
      }
    },
    {
      {
        -1296.5390625,
        -265.0068359375,
        14.7265625
      },
      {
        -1317.118,
        -325.6,
        965.009
      },
      {
        -1345.244,
        -464.889,
        979.062
      }
    },
    {
      {
        -1348.150390625,
        -430.7802734375,
        983
      },
      {
        -1368.015,
        -463.442,
        982.332
      },
      {
        -1383.358,
        -476.798,
        982.332
      }
    },
    {
      {
        -1410.167,
        -504.821,
        983.942
      },
      {
        -1410.167,
        -538.141,
        988.009
      },
      {
        -1410.167,
        -555.252,
        990.098
      }
    },
    {
      {
        -1410.167,
        -590.378,
        993.077
      },
      {
        -1410.167,
        -607.188,
        996.414
      },
      {
        -1410.167,
        -637.245,
        1002.381
      }
    },
    {
      {
        -1441.495,
        -675.786,
        1003.966
      },
      {
        -1467.401,
        -675.27,
        1003.966
      },
      {
        -1510.559,
        -674.411,
        1003.966
      }
    },
    {
      {
        -1587.105,
        -671.409,
        993.967
      },
      {
        -1629.26,
        -656.372,
        985.586
      },
      {
        -1650.498,
        -648.796,
        981.365
      }
    },
    {
      {
        -1694.096,
        -627.923,
        965.586
      },
      {
        -1699.096,
        -556.818,
        965.586
      },
      {
        -1701.049,
        -529.042,
        965.586
      }
    },
    {
      {
        -1702.102,
        -481.771,
        965.586
      },
      {
        -1702.102,
        -481.771,
        965.586
      },
      {
        -1702.102,
        -481.771,
        965.586
      }
    },
    {
      {
        -1701.677,
        -400.124,
        965.586
      },
      {
        -1701.716,
        -389.77,
        965.586
      },
      {
        -1701.823,
        -360.729,
        965.586
      }
    },
    {
      {
        -1695.127,
        -262.801,
        965.586
      },
      {
        -1693.442,
        -252.585,
        965.586
      },
      {
        -1684.767,
        -199.994,
        965.586
      }
    },
    {
      {
        -1663.408,
        -172.655,
        965.586
      },
      {
        -1657.948,
        -163.849,
        965.586
      },
      {
        -1650.803,
        -152.328,
        965.586
      }
    },
    {
      {
        -1636.369,
        -136.632,
        965.586
      },
      {
        -1624.621,
        -129.96,
        965.586
      },
      {
        -1607.278,
        -120.109,
        965.586
      }
    },
    {
      {
        -1591.113,
        -123.875,
        965.586
      },
      {
        -1579.531,
        -140.146,
        965.586
      },
      {
        -1560.565,
        -166.791,
        965.586
      }
    },
    {
      {
        -1551.831,
        -167.796,
        965.586
      },
      {
        -1540.283,
        -173.604,
        965.586
      },
      {
        -1525.166,
        -181.208,
        965.586
      }
    },
    {
      {
        -1506.986,
        -179.467,
        965.586
      },
      {
        -1494.646,
        -174.495,
        965.586
      },
      {
        -1476.383,
        -167.135,
        965.586
      }
    },
    {
      {
        -1352.295,
        -100.13,
        965.586
      },
      {
        -1340.539,
        -82.546,
        965.586
      },
      {
        -1324.412,
        -58.424,
        965.586
      }
    },
    {
      {
        -1350.25,
        -17.852,
        965.586
      },
      {
        -1395.585,
        -43.506,
        965.586
      },
      {
        -1421.898,
        -58.397,
        965.586
      }
    },
    {
      {
        -1448.135,
        -88.86,
        965.586
      },
      {
        -1474.167,
        -57.472,
        965.586
      },
      {
        -1493.014,
        -34.748,
        965.586
      }
    },
    {
      {
        -1454.466,
        -4.564,
        965.586
      },
      {
        -1447.539,
        2.845,
        965.586
      },
      {
        -1429.356,
        22.294,
        965.586
      }
    }
  },
  {
    {
      {
        -1330.09375,
        119.9931640625,
        14.9140625
      },
      {
        -1320.09375,
        129.9931640625,
        14.9140625
      },
      {
        -1310.09375,
        139.9931640625,
        14.9140625
      }
    },
    {
      {
        -1160.543,
        286.729,
        965.586
      },
      {
        -1150.543,
        296.729,
        965.586
      },
      {
        -1132.166,
        315.864,
        965.586
      }
    },
    {
      {
        -1038.651,
        410.631,
        963.897
      },
      {
        -967.955,
        340.233,
        965.586
      },
      {
        -902.559,
        275.113,
        967.149
      }
    },
    {
      {
        -915.99,
        196.022,
        965.586
      },
      {
        -955.418,
        125.733,
        965.586
      },
      {
        -964.881,
        108.863,
        965.586
      }
    },
    {
      {
        -1064.36,
        -74.281,
        965.586
      },
      {
        -1100.035,
        -142.924,
        965.586
      },
      {
        -1113.272,
        -168.394,
        965.586
      }
    },
    {
      {
        -1078.867,
        -164.623,
        965.586
      },
      {
        -1088.682,
        -192.341,
        965.586
      },
      {
        -1120.832,
        -283.128,
        965.586
      }
    },
    {
      {
        -1117.664,
        -289.312,
        971.311
      },
      {
        -1132.99,
        -320.756,
        971.311
      },
      {
        -1163.032,
        -382.393,
        971.311
      }
    },
    {
      {
        -1194.402,
        -380.362,
        975.798
      },
      {
        -1227.194,
        -371.581,
        972.645
      },
      {
        -1280.309,
        -357.359,
        967.538
      }
    },
    {
      {
        -1259.195,
        -310.903,
        965.053
      },
      {
        -1312.048,
        -298.933,
        965.053
      },
      {
        -1356.045,
        -288.968,
        965.053
      }
    },
    {
      {
        -1363.167,
        -287.25,
        965.053
      },
      {
        -1441.072,
        -288.181,
        965.053
      },
      {
        -1508.223,
        -288.982,
        965.053
      }
    },
    {
      {
        -1535.067,
        -291.7,
        965.053
      },
      {
        -1554.792,
        -264.545,
        965.053
      },
      {
        -1585.932,
        -221.677,
        965.053
      }
    },
    {
      {
        -1628.356,
        -216.178,
        965.053
      },
      {
        -1639.946,
        -264.42,
        965.053
      },
      {
        -1654.588,
        -325.364,
        965.053
      }
    },
    {
      {
        -1645.948,
        -369.181,
        965.046
      },
      {
        -1641.967,
        -399.083,
        965.043
      },
      {
        -1631.641,
        -476.629,
        965.037
      }
    },
    {
      {
        -1614.796,
        -460.338,
        963.575
      },
      {
        -1618.679,
        -554.398,
        976.961
      },
      {
        -1621.905,
        -632.562,
        988.086
      }
    },
    {
      {
        -1571.312,
        -650.397,
        996.327
      },
      {
        -1532.517,
        -612.324,
        994.513
      },
      {
        -1468.964,
        -549.954,
        991.542
      }
    },
    {
      {
        -1506.611,
        -472.36,
        977.64
      },
      {
        -1503.555,
        -416.651,
        975.34
      },
      {
        -1493.71,
        -237.232,
        967.934
      }
    },
    {
      {
        -1495.771,
        -299.269,
        969.945
      },
      {
        -1493.858,
        -244.465,
        966.639
      },
      {
        -1492.654,
        -209.976,
        964.558
      }
    },
    {
      {
        -1476.337,
        -186.486,
        964.921
      },
      {
        -1457.665,
        -166.57,
        964.921
      },
      {
        -1422.251,
        -128.798,
        964.921
      }
    },
    {
      {
        -1352.295,
        -100.13,
        965.586
      },
      {
        -1340.539,
        -82.546,
        965.586
      },
      {
        -1324.412,
        -58.424,
        965.586
      }
    },
    {
      {
        -1350.25,
        -17.852,
        965.586
      },
      {
        -1395.585,
        -43.506,
        965.586
      },
      {
        -1421.898,
        -58.397,
        965.586
      }
    },
    {
      {
        -1448.135,
        -88.86,
        965.586
      },
      {
        -1474.167,
        -57.472,
        965.586
      },
      {
        -1493.014,
        -34.748,
        965.586
      }
    },
    {
      {
        -1454.466,
        -4.564,
        965.586
      },
      {
        -1447.539,
        2.845,
        965.586
      },
      {
        -1429.356,
        22.294,
        965.586
      }
    }
  }
}
function calculateBezierPoint(t, p0x, p0y, p1x, p1y, p2x, p2y, p3x, p3y)
  local u = 1 - t
  local tt = t * t
  local uu = u * u
  local uuu = uu * u
  local ttt = tt * t
  px = uuu * p0x
  px = px + 3 * uu * t * p1x
  px = px + 3 * u * tt * p2x
  px = px + ttt * p3x
  py = uuu * p0y
  py = py + 3 * uu * t * p1y
  py = py + 3 * u * tt * p2y
  py = py + ttt * p3y
  return px, py
end
local oldCurve = {}
local res = 20
for k in pairs(curves) do
  local tmp = {}
  for i = 1, #curves[k] - 1 do
    for t = 0, 1, 1 / res do
      local p0x, p0y = curves[k][i][2][1], curves[k][i][2][2]
      local p1x, p1y = curves[k][i][3][1], curves[k][i][3][2]
      local p2x, p2y = curves[k][i + 1][1][1], curves[k][i + 1][1][2]
      local p3x, p3y = curves[k][i + 1][2][1], curves[k][i + 1][2][2]
      local x, y = calculateBezierPoint(t, p0x, p0y, p1x, p1y, p2x, p2y, p3x, p3y)
      table.insert(tmp, {x, y})
    end
  end
  local fx, fy = tmp[1][1], tmp[1][2]
  local lx, ly = tmp[#tmp][1], tmp[#tmp][2]
  local x = fx - lx
  local y = fy - ly
  for i = 0, 1, 1 / res do
    table.insert(tmp, {
      lx + x * i,
      ly + y * i
    })
  end
  for i = 1, #tmp - 1 do
    if tmp[i + 1] then
      tmp[i][4] = tmp[i + 1][1] - tmp[i][1]
      tmp[i][5] = tmp[i + 1][2] - tmp[i][2]
      tmp[i][3] = tmp[i][4] * tmp[i][4] + tmp[i][5] * tmp[i][5]
      while tmp[i][3] <= 0 do
        table.remove(tmp, i + 1)
        tmp[i][4] = tmp[i + 1][1] - tmp[i][1]
        tmp[i][5] = tmp[i + 1][2] - tmp[i][2]
        tmp[i][3] = tmp[i][4] * tmp[i][4] + tmp[i][5] * tmp[i][5]
      end
    end
  end
  oldCurve[k] = curves[k]
  curves[k] = tmp
end
function pDistance(x, y, x1, y1, C, D, len_sq)
  local A = x - x1
  local B = y - y1
  local dot = A * C + B * D
  local param = -1
  if len_sq ~= 0 then
    param = dot / len_sq
  end
  return param, x1 + param * C, y1 + param * D
end
local timerVeh = false
local timerStart = false
local currentSec = 1
local currentLayout = false
local font = false
local fontScale = false
local fontHeight = false
local green = false
local yellow = false
local blue = false
local zeroW = false
local bestLapTime = {}
local lastLapTime = {}
local currentLapDelta = {}
local lastLapDelta = {}
local bestLapDelta = {}
local bestGhostModel = {}
local lastGhostModel = {}
local bestGhostName = {}
local lastGhostName = {}
local currentGhostData = {}
local lastGhostData = {}
local bestGhostData = {}
local ghostCar, ghostCar2
local veh = false
function createGhostCar(best)
  if best then
    if isElement(ghostCar2) then
      destroyElement(ghostCar2)
    end
    ghostCar2 = false
    if bestGhostModel[currentLayout] then
      ghostCar2 = createVehicle(bestGhostModel[currentLayout], 0, 0, 0)
      setElementCollisionsEnabled(ghostCar2, false)
      setElementAlpha(ghostCar2, 153)
      setVehicleColor(ghostCar2, green[1], green[2], green[3], green[1], green[2], green[3])
      setVehicleVariant(ghostCar2, 255, 255)
    end
  else
    if isElement(ghostCar) then
      destroyElement(ghostCar)
    end
    ghostCar = false
    if lastGhostModel[currentLayout] then
      ghostCar = createVehicle(lastGhostModel[currentLayout], 0, 0, 0)
      setElementCollisionsEnabled(ghostCar, false)
      setElementAlpha(ghostCar, 153)
      setVehicleColor(ghostCar, blue[1], blue[2], blue[3], blue[1], blue[2], blue[3])
      setVehicleVariant(ghostCar, 255, 255)
    end
  end
end
function deleteGhostCars()
  if isElement(ghostCar) then
    destroyElement(ghostCar)
  end
  ghostCar = false
  if isElement(ghostCar2) then
    destroyElement(ghostCar2)
  end
  ghostCar2 = false
end
function guiRefreshColors()
  local resource = getResourceFromName("sGui")
  if resource and getResourceState(resource) == "running" then
    font = sightexports.sGui:getFont("22/BebasNeueBold.otf")
    fontScale = sightexports.sGui:getFontScale("22/BebasNeueBold.otf")
    fontHeight = sightexports.sGui:getFontHeight("22/BebasNeueBold.otf")
    zeroW = 0
    for i = 0, 9 do
      zeroW = sightexports.sGui:getTextWidthFont(tostring(i), "22/BebasNeueBold.otf")
    end
    green = sightexports.sGui:getColorCode("sightgreen")
    yellow = sightexports.sGui:getColorCode("sightyellow")
    blue = sightexports.sGui:getColorCode("sightblue")
    if isElement(ghostCar) then
      setVehicleColor(ghostCar, blue[1], blue[2], blue[3], blue[1], blue[2], blue[3])
    end
    if isElement(ghostCar2) then
      setVehicleColor(ghostCar2, green[1], green[2], green[3], green[1], green[2], green[3])
    end
  end
end
addEvent("onGuiRefreshColors", true)
addEventHandler("onGuiRefreshColors", getRootElement(), guiRefreshColors)
addEventHandler("onClientResourceStart", getResourceRootElement(), guiRefreshColors)
function dxDrawTextEx(text, x, y, scale, r, g, b, a)
  dxDrawText(text, x + 1, y + 1, x + 1, y + 1, tocolor(0, 0, 0, a or 255), fontScale * scale, font, "center", "center")
  dxDrawText(text, x, y, x, y, tocolor(r, g, b, a or 255), fontScale * scale, font, "center", "center")
end
addEventHandler("onClientResourceStart", getResourceRootElement(), function()
  triggerServerEvent("getSeeringLayout", localPlayer)
  for i = 1, 4 do
    lastLapDelta[i] = {}
    bestLapDelta[i] = {}
    lastGhostData[i] = {}
    bestGhostData[i] = {}
    if fileExists("lasttime" .. i .. ".sight") then
      local file = fileOpen("lasttime" .. i .. ".sight")
      if file then
        local data = fileRead(file, fileGetSize(file))
        if tonumber(data) then
          lastLapTime[i] = tonumber(data)
        end
        fileClose(file)
      end
    end
    if fileExists("besttime" .. i .. ".sight") then
      local file = fileOpen("besttime" .. i .. ".sight")
      if file then
        local data = fileRead(file, fileGetSize(file))
        if tonumber(data) then
          bestLapTime[i] = tonumber(data)
        end
        fileClose(file)
      end
    end
    if fileExists("lastdelta" .. i .. ".sight") then
      local file = fileOpen("lastdelta" .. i .. ".sight")
      if file then
        local data = fileRead(file, fileGetSize(file))
        data = split(data, ",")
        for j = 1, #data do
          if tonumber(data[j]) then
            table.insert(lastLapDelta[i], tonumber(data[j]))
          end
        end
        fileClose(file)
      end
    end
    if fileExists("bestdelta" .. i .. ".sight") then
      local file = fileOpen("bestdelta" .. i .. ".sight")
      if file then
        local data = fileRead(file, fileGetSize(file))
        data = split(data, ",")
        for j = 1, #data do
          if tonumber(data[j]) then
            table.insert(bestLapDelta[i], tonumber(data[j]))
          end
        end
        fileClose(file)
      end
    end
    if fileExists("lastghost" .. i .. ".sight") then
      local file = fileOpen("lastghost" .. i .. ".sight")
      if file then
        local data = fileRead(file, fileGetSize(file))
        data = split(data, ",")
        if tonumber(data[1]) then
          lastGhostModel[i] = tonumber(data[1])
          lastGhostName[i] = tostring(data[2])
          table.remove(data, 1)
          table.remove(data, 1)
          for j = 1, #data, 8 do
            local tmp = {}
            for k = j, j + 7 do
              if tonumber(data[k]) then
                table.insert(tmp, tonumber(data[k]))
              end
            end
            if #tmp == 8 then
              table.insert(lastGhostData[i], tmp)
            end
          end
        end
        fileClose(file)
      end
    end
    if fileExists("bestghost" .. i .. ".sight") then
      local file = fileOpen("bestghost" .. i .. ".sight")
      if file then
        local data = fileRead(file, fileGetSize(file))
        data = split(data, ",")
        if tonumber(data[1]) then
          bestGhostModel[i] = tonumber(data[1])
          bestGhostName[i] = tostring(data[2])
          table.remove(data, 1)
          table.remove(data, 1)
          for j = 1, #data, 8 do
            local tmp = {}
            for k = j, j + 7 do
              if tonumber(data[k]) then
                table.insert(tmp, tonumber(data[k]))
              end
            end
            if #tmp == 8 then
              table.insert(bestGhostData[i], tmp)
            end
          end
        end
        fileClose(file)
      end
    end
  end
end)
local canStart = false
local raceTimer = false
local widgetX, widgetY = screenX / 2, math.floor(screenY * 0.85)
local lastGhostSector = 1
local bestGhostSector = 1
local dragX, dragY = false, false
addEventHandler("onClientRender", getRootElement(), function()
  if currentLayout and raceTimer then
    local mins = math.floor(raceTimer / 60000)
    local secs = math.floor(raceTimer % 60000 / 1000)
    local ms = raceTimer % 1000
    local cx, cy = getCursorPosition()
    if cx then
      cx, cy = cx * screenX, cy * screenY
      if dragX then
        if getKeyState("mouse1") then
          widgetX = math.max(zeroW * 7, math.min(screenX - zeroW * 7, cx - dragX))
          widgetY = math.max(fontHeight / 2, math.min(screenY - fontHeight * 1.8, cy - dragY))
        else
          dragX = false
          dragY = false
        end
      elseif cx >= widgetX - zeroW * 7 and cy >= widgetY - fontHeight / 2 and cx <= widgetX + zeroW * 7 and cy <= widgetY + fontHeight * 1.8 and getKeyState("mouse1") then
        dragX, dragY = cx - widgetX, cy - widgetY
      end
    elseif dragX then
      dragX = false
      dragY = false
    end
    local x = widgetX - zeroW * 3.5
    local y = widgetY
    dxDrawTextEx(math.floor(mins / 10), x, y, 1, 255, 255, 255, 255)
    x = x + zeroW
    dxDrawTextEx(mins % 10, x, y, 1, 255, 255, 255, 255)
    x = x + zeroW
    dxDrawTextEx(":", x - zeroW * 0.25, y, 1, 255, 255, 255, 255)
    x = x + zeroW * 0.5
    dxDrawTextEx(math.floor(secs / 10), x, y, 1, 255, 255, 255, 255)
    x = x + zeroW
    dxDrawTextEx(secs % 10, x, y, 1, 255, 255, 255, 255)
    x = x + zeroW
    dxDrawTextEx(".", x - zeroW * 0.25, y, 1, 255, 255, 255, 255)
    x = x + zeroW * 0.5
    dxDrawTextEx(math.floor(ms / 100), x, y, 1, 255, 255, 255, 255)
    x = x + zeroW
    dxDrawTextEx(math.floor(ms / 10) % 10, x, y, 1, 255, 255, 255, 255)
    x = x + zeroW
    dxDrawTextEx(ms % 10, x, y, 1, 255, 255, 255, 255)
    x = widgetX - zeroW * 7 / 2
    y = y + fontHeight / 2 + fontHeight * 0.8 / 2
    if lastLapDelta[currentLayout][currentSec - 1] and currentLapDelta[currentSec - 1] then
      local delta = (currentLapDelta[currentSec - 1] - lastLapDelta[currentLayout][currentSec - 1]) / 1000
      local pos = 0 < delta
      delta = math.abs(delta)
      local col = pos and yellow or green
      local mins = 0
      if 60 <= delta then
        mins = math.floor(delta / 60)
        delta = delta - mins * 60
      end
      local secs = math.floor(delta)
      local ms = delta % 1 * 1000
      local str = 0 < mins and string.format("%02d:%02d", mins, secs) or string.format("%02d.%03d", secs, ms)
      dxDrawTextEx((pos and "+" or "-") .. str, x, y, 0.8, col[1], col[2], col[3], 255)
    else
      dxDrawTextEx("--.---", x, y, 0.8, 255, 255, 255, 255)
    end
    x = widgetX + zeroW * 7 / 2
    if bestLapDelta[currentLayout][currentSec - 1] and currentLapDelta[currentSec - 1] then
      local delta = (currentLapDelta[currentSec - 1] - bestLapDelta[currentLayout][currentSec - 1]) / 1000
      local pos = 0 < delta
      delta = math.abs(delta)
      local col = pos and yellow or green
      local mins = 0
      if 60 <= delta then
        mins = math.floor(delta / 60)
        delta = delta - mins * 60
      end
      local secs = math.floor(delta)
      local ms = delta % 1 * 1000
      local str = 0 < mins and string.format("%02d:%02d", mins, secs) or string.format("%02d.%03d", secs, ms)
      dxDrawTextEx((pos and "+" or "-") .. str, x, y, 0.8, col[1], col[2], col[3], 255)
    else
      dxDrawTextEx("--.---", x, y, 0.8, 255, 255, 255, 255)
    end
    y = y + fontHeight * 0.8 / 2 + fontHeight * 0.5 / 2
    dxDrawTextEx("DELTA-ELŐZŐ", widgetX - zeroW * 7 / 2, y, 0.5, 255, 255, 255, 255)
    dxDrawTextEx("DELTA-LEGJOBB", widgetX + zeroW * 7 / 2, y, 0.5, 255, 255, 255, 255)
    if isElement(ghostCar) then
      local x, y, z = getElementPosition(ghostCar)
      local x, y = getScreenFromWorldPosition(x, y, z + 1.25, 128)
      if x then
        y = y - fontHeight * 0.75 / 2 - fontHeight * 0.5
        dxDrawTextEx("ELŐZŐ KÖR", x, y, 0.75, 255, 255, 255, 191.25)
        if lastGhostName[currentLayout] then
          dxDrawTextEx(lastGhostName[currentLayout], x, y + fontHeight * 0.75 / 2 + fontHeight * 0.5 / 2, 0.5, 255, 255, 255, 191.25)
        end
      end
    end
    if isElement(ghostCar2) then
      local x, y, z = getElementPosition(ghostCar2)
      local x, y = getScreenFromWorldPosition(x, y, z + 1.25, 128)
      if x then
        y = y - fontHeight * 0.75 / 2 - fontHeight * 0.5
        dxDrawTextEx("LEGJOBB KÖR", x, y, 0.75, 255, 255, 255, 191.25)
        if bestGhostName[currentLayout] then
          dxDrawTextEx(bestGhostName[currentLayout], x, y + fontHeight * 0.75 / 2 + fontHeight * 0.5 / 2, 0.5, 255, 255, 255, 191.25)
        end
      end
    end
  end
end)
function rotToQ(x, y, z)
  x = math.rad(x / 2)
  y = math.rad(y / 2)
  z = math.rad(z / 2)
  local sinX = math.sin(x)
  local cosX = math.cos(x)
  local sinY = math.sin(y)
  local cosY = math.cos(y)
  local sinZ = math.sin(z)
  local cosZ = math.cos(z)
  local qw = cosY * cosX * cosZ + sinY * sinX * sinZ
  local qx = cosY * sinX * cosZ + sinY * cosX * sinZ
  local qy = sinY * cosX * cosZ - cosY * sinX * sinZ
  local qz = cosY * cosX * sinZ - sinY * sinX * cosZ
  return qx, qy, qz, qw
end
function qToRot(x, y, z, w)
  local check = 2 * (y * z - w * x)
  if check < 0.999 then
    if -0.999 < check then
      x, y, z = -math.asin(check), math.atan2(2 * (x * z + w * y), 1 - 2 * (x * x + y * y)), math.atan2(2 * (x * y + w * z), 1 - 2 * (x * x + z * z))
    else
      x, y, z = math.pi / 2, math.atan2(2 * (x * y - w * z), 1 - 2 * (y * y + z * z)), 0
    end
  else
    x, y, z = -math.pi / 2, math.atan2(-2 * (x * y - w * z), 1 - 2 * (y * y + z * z)), 0
  end
  x = math.deg(x)
  y = math.deg(y)
  z = math.deg(z)
  return x, y, z
end
function qLerp(q1x, q1y, q1z, q1w, q2x, q2y, q2z, q2w, t)
  local qx, qy, qz, qw
  local dot = q1x * q2x + q1y * q2y + q1z * q2z + q1w * q2w
  if dot < 0 then
    qx = q1x + t * (-q2x - q1x)
    qy = q1y + t * (-q2y - q1y)
    qz = q1z + t * (-q2z - q1z)
    qw = q1w + t * (-q2w - q1w)
  else
    qx = q1x + (q2x - q1x) * t
    qy = q1y + (q2y - q1y) * t
    qz = q1z + (q2z - q1z) * t
    qw = q1w + (q2w - q1w) * t
  end
  local n = qx * qx + qy * qy + qz * qz + qw * qw
  if n ~= 1 and 0 < n then
    n = 1 / math.sqrt(n)
    qx = qx * n
    qy = qy * n
    qz = qz * n
    qw = qw * n
  end
  return qx, qy, qz, qw
end
function saveCurrentData(model, name)
  if fileExists("lasttime" .. currentLayout .. ".sight") then
    fileDelete("lasttime" .. currentLayout .. ".sight")
  end
  local file = fileCreate("lasttime" .. currentLayout .. ".sight")
  if file then
    fileWrite(file, tostring(raceTimer))
    fileClose(file)
  end
  if fileExists("lastdelta" .. currentLayout .. ".sight") then
    fileDelete("lastdelta" .. currentLayout .. ".sight")
  end
  local file = fileCreate("lastdelta" .. currentLayout .. ".sight")
  if file then
    for i = 1, #currentLapDelta do
      fileWrite(file, tostring(currentLapDelta[i]))
      fileWrite(file, ",")
    end
    fileClose(file)
  end
  if fileExists("lastghost" .. currentLayout .. ".sight") then
    fileDelete("lastghost" .. currentLayout .. ".sight")
  end
  local file = fileCreate("lastghost" .. currentLayout .. ".sight")
  if file then
    fileWrite(file, tostring(model))
    fileWrite(file, ",")
    fileWrite(file, tostring(name))
    fileWrite(file, ",")
    for i = 1, #currentGhostData do
      fileWrite(file, tostring(currentGhostData[i][1]))
      fileWrite(file, ",")
      fileWrite(file, tostring(currentGhostData[i][2]))
      fileWrite(file, ",")
      fileWrite(file, tostring(currentGhostData[i][3]))
      fileWrite(file, ",")
      fileWrite(file, tostring(currentGhostData[i][4]))
      fileWrite(file, ",")
      fileWrite(file, tostring(currentGhostData[i][5]))
      fileWrite(file, ",")
      fileWrite(file, tostring(currentGhostData[i][6]))
      fileWrite(file, ",")
      fileWrite(file, tostring(currentGhostData[i][7]))
      fileWrite(file, ",")
      fileWrite(file, tostring(currentGhostData[i][8]))
      fileWrite(file, ",")
    end
    fileClose(file)
  end
end
function endRaceTimer()
  raceTimer = false
  timerStart = false
  deleteGhostCars()
  currentLapDelta = {}
  currentGhostData = {}
end
function isPlayerInSeeRing()
  return isElementWithinColShape(localPlayer, syncZone)
end
addEventHandler("onClientColShapeHit", syncZone, function(he)
  if he == localPlayer then
    sightlangCondHandl0(true)
    triggerEvent("refreshPlayerInSeering", localPlayer)
  end
end)
function preRenderInSeeRing()
  if not isPlayerInSeeRing() then
    sightlangCondHandl0(false)
    triggerEvent("refreshPlayerInSeering", localPlayer)
    return
  end
  veh = getPedOccupiedVehicle(localPlayer)
  if veh and getVehicleType(veh) ~= "Bike" and getVehicleType(veh) ~= "Automobile" then
    veh = false
  end
  local now = getTickCount()
  if curves[currentLayout] and veh then
    local x, y, z = getElementPosition(veh)
    if raceTimer then
      if timerStart then
        raceTimer = now - timerStart
        if timerVeh ~= veh then
          endRaceTimer()
          return
        end
      end
      if isElementWithinColShape(veh, pitLimiter) then
        sightexports.sGui:showInfobox("e", "Az időmérő megállt, mivel bementél a boxutcába!")
        endRaceTimer()
        return
      end
      if timerStart and lastGhostData[currentLayout][lastGhostSector] and lastGhostData[currentLayout][lastGhostSector][8] and bestLapTime[currentLayout] ~= lastLapTime[currentLayout] then
        while raceTimer >= lastGhostData[currentLayout][lastGhostSector][8] do
          lastGhostSector = lastGhostSector + 1
          if not lastGhostData[currentLayout][lastGhostSector] then
            break
          end
        end
        if lastGhostData[currentLayout][lastGhostSector - 1] and lastGhostData[currentLayout][lastGhostSector] then
          local p = (raceTimer - lastGhostData[currentLayout][lastGhostSector - 1][8]) / (lastGhostData[currentLayout][lastGhostSector][8] - lastGhostData[currentLayout][lastGhostSector - 1][8])
          if not isElement(ghostCar) then
            createGhostCar(false)
          elseif getElementModel(ghostCar) ~= lastGhostModel[currentLayout] then
            setElementModel(ghostCar, lastGhostModel[currentLayout])
          end
          if ghostCar then
            local x, y, z = interpolateBetween(lastGhostData[currentLayout][lastGhostSector - 1][1], lastGhostData[currentLayout][lastGhostSector - 1][2], lastGhostData[currentLayout][lastGhostSector - 1][3], lastGhostData[currentLayout][lastGhostSector][1], lastGhostData[currentLayout][lastGhostSector][2], lastGhostData[currentLayout][lastGhostSector][3], p, "Linear")
            setElementPosition(ghostCar, x, y, z)
            local x, y, z, w = qLerp(lastGhostData[currentLayout][lastGhostSector - 1][4], lastGhostData[currentLayout][lastGhostSector - 1][5], lastGhostData[currentLayout][lastGhostSector - 1][6], lastGhostData[currentLayout][lastGhostSector - 1][7], lastGhostData[currentLayout][lastGhostSector][4], lastGhostData[currentLayout][lastGhostSector][5], lastGhostData[currentLayout][lastGhostSector][6], lastGhostData[currentLayout][lastGhostSector][7], p)
            local rx, ry, rz = qToRot(x, y, z, w)
            setElementRotation(ghostCar, rx, ry, rz)
          end
        end
      elseif ghostCar then
        if isElement(ghostCar) then
          destroyElement(ghostCar)
        end
        ghostCar = false
      end
      if timerStart and bestGhostData[currentLayout][bestGhostSector] and bestGhostData[currentLayout][bestGhostSector][8] then
        while raceTimer >= bestGhostData[currentLayout][bestGhostSector][8] do
          bestGhostSector = bestGhostSector + 1
          if not bestGhostData[currentLayout][bestGhostSector] then
            break
          end
        end
        if bestGhostData[currentLayout][bestGhostSector - 1] and bestGhostData[currentLayout][bestGhostSector] then
          local p = (raceTimer - bestGhostData[currentLayout][bestGhostSector - 1][8]) / (bestGhostData[currentLayout][bestGhostSector][8] - bestGhostData[currentLayout][bestGhostSector - 1][8])
          if not isElement(ghostCar2) then
            createGhostCar(true)
          elseif getElementModel(ghostCar2) ~= bestGhostModel[currentLayout] then
            setElementModel(ghostCar2, bestGhostModel[currentLayout])
          end
          if ghostCar2 then
            local x, y, z = interpolateBetween(bestGhostData[currentLayout][bestGhostSector - 1][1], bestGhostData[currentLayout][bestGhostSector - 1][2], bestGhostData[currentLayout][bestGhostSector - 1][3], bestGhostData[currentLayout][bestGhostSector][1], bestGhostData[currentLayout][bestGhostSector][2], bestGhostData[currentLayout][bestGhostSector][3], p, "Linear")
            setElementPosition(ghostCar2, x, y, z)
            local x, y, z, w = qLerp(bestGhostData[currentLayout][bestGhostSector - 1][4], bestGhostData[currentLayout][bestGhostSector - 1][5], bestGhostData[currentLayout][bestGhostSector - 1][6], bestGhostData[currentLayout][bestGhostSector - 1][7], bestGhostData[currentLayout][bestGhostSector][4], bestGhostData[currentLayout][bestGhostSector][5], bestGhostData[currentLayout][bestGhostSector][6], bestGhostData[currentLayout][bestGhostSector][7], p)
            local rx, ry, rz = qToRot(x, y, z, w)
            setElementRotation(ghostCar2, rx, ry, rz)
          end
        end
      elseif ghostCar2 then
        if isElement(ghostCar2) then
          destroyElement(ghostCar2)
        end
        ghostCar2 = false
      end
      if curves[currentLayout][currentSec] then
        while true do
          local p, tx, ty = pDistance(x, y, curves[currentLayout][currentSec][1], curves[currentLayout][currentSec][2], curves[currentLayout][currentSec][4], curves[currentLayout][currentSec][5], curves[currentLayout][currentSec][3])
          if getDistanceBetweenPoints2D(x, y, tx, ty) > 20 then
            endRaceTimer()
            sightexports.sGui:showInfobox("e", "Az időmérő megállt, mivel elhagytad a pályát!")
            return
          end
          if p < -5 then
            endRaceTimer()
            sightexports.sGui:showInfobox("e", "Az időmérő megállt, mivel rossz irányba indultál!")
            return
          end
          if not timerStart and currentSec == 1 and 0 <= p then
            currentSec = 1
            timerStart = now
            timerVeh = veh
            raceTimer = 0
            lastGhostSector = 1
            bestGhostSector = 1
            local rx, ry, rz = getElementRotation(veh)
            local rx, ry, rz, rw = rotToQ(rx, ry, rz)
            table.insert(currentGhostData, {
              x,
              y,
              z,
              rx,
              ry,
              rz,
              rw,
              raceTimer
            })
          end
          if raceTimer and 300000 < raceTimer then
            endRaceTimer()
            return
          end
          local spd = getVehicleSpeed(veh)
          if 1 < p then
            currentLapDelta[currentSec] = raceTimer
            currentSec = currentSec + 1
            local rx, ry, rz = getElementRotation(veh)
            local rx, ry, rz, rw = rotToQ(rx, ry, rz)
            table.insert(currentGhostData, {
              x,
              y,
              z,
              rx,
              ry,
              rz,
              rw,
              raceTimer
            })
            if currentSec >= #curves[currentLayout] then
              currentSec = 1
              lastGhostSector = 1
              bestGhostSector = 1
              if timerStart then
                local mins = math.floor(raceTimer / 60000)
                local secs = math.floor(raceTimer % 60000 / 1000)
                local ms = raceTimer % 1000
                local model = getElementData(veh, "vehicle.customModel") or getElementModel(veh)
                local driver = getVehicleController(veh) or localPlayer
                local name = getElementData(driver, "visibleName") or ""
                name = string.gsub(name, "[%p%c%s]", " ")
                saveCurrentData(model, name)
                if not bestLapTime[currentLayout] or raceTimer < bestLapTime[currentLayout] then
                  bestLapTime[currentLayout] = raceTimer
                  bestLapDelta[currentLayout] = currentLapDelta
                  bestGhostData[currentLayout] = currentGhostData
                  bestGhostModel[currentLayout] = model
                  bestGhostName[currentLayout] = name
                  if fileExists("lasttime" .. currentLayout .. ".sight") then
                    fileCopy("lasttime" .. currentLayout .. ".sight", "data/besttime" .. currentLayout .. ".sight", true)
                  end
                  if fileExists("lastdelta" .. currentLayout .. ".sight") then
                    fileCopy("lastdelta" .. currentLayout .. ".sight", "data/bestdelta" .. currentLayout .. ".sight", true)
                  end
                  if fileExists("lastghost" .. currentLayout .. ".sight") then
                    fileCopy("lastghost" .. currentLayout .. ".sight", "data/bestghost" .. currentLayout .. ".sight", true)
                  end
                  sightexports.sGui:showInfobox("i", "Köridő: " .. string.format("%02d:%02d.%03d", mins, secs, ms) .. " (új saját legjobb kör)")
                else
                  sightexports.sGui:showInfobox("i", "Köridő: " .. string.format("%02d:%02d.%03d", mins, secs, ms))
                end
                lastLapTime[currentLayout] = raceTimer
                lastLapDelta[currentLayout] = currentLapDelta
                currentLapDelta = {}
                lastGhostData[currentLayout] = currentGhostData
                currentGhostData = {}
                lastGhostModel[currentLayout] = model
                lastGhostName[currentLayout] = name
              end
              currentSec = 1
              timerStart = now
              timerVeh = veh
              raceTimer = 0
              table.insert(currentGhostData, {
                x,
                y,
                z,
                rx,
                ry,
                rz,
                rw,
                raceTimer
              })
            end
          else
            if currentGhostData[#currentGhostData] and currentGhostData[#currentGhostData][8] and 1 < spd and raceTimer - currentGhostData[#currentGhostData][8] >= math.max(150, 200 / spd * 150) then
              local rx, ry, rz = getElementRotation(veh)
              local rx, ry, rz, rw = rotToQ(rx, ry, rz)
              table.insert(currentGhostData, {
                x,
                y,
                z,
                rx,
                ry,
                rz,
                rw,
                raceTimer
              })
            end
            break
          end
        end
      end
    elseif not isElementWithinColShape(veh, pitLimiter) and curves[currentLayout][1] then
      local p, tx, ty = pDistance(x, y, curves[currentLayout][1][1], curves[currentLayout][1][2], curves[currentLayout][1][4], curves[currentLayout][1][5], curves[currentLayout][1][3])
      local d = getDistanceBetweenPoints2D(x, y, tx, ty)
      if d <= 12 then
        if p < 0 then
          canStart = -60 <= p
        elseif canStart then
          endRaceTimer()
          currentSec = 1
          timerStart = now
          timerVeh = veh
          raceTimer = 0
          lastGhostSector = 1
          bestGhostSector = 1
          canStart = false
        end
      else
        canStart = false
      end
    end
  elseif raceTimer then
    endRaceTimer()
  end
end
function getVehicleSpeed(currentElement)
  if isElement(currentElement) then
    local x, y, z = getElementVelocity(currentElement)
    local speed = math.sqrt(x ^ 2 + y ^ 2 + z ^ 2)
    return speed * 180 * 1.1
  end
  return 0
end
local pitLimiterHandled = false
function pitLimiterRender()
  if veh then
    dxDrawTextEx("* PIT LIMITER ON *", screenX / 2, screenY * 0.85, 1, yellow[1], yellow[2], yellow[3], 255)
  end
end
function pitLimiterHandler()
  if not isElementWithinColShape(localPlayer, pitLimiter) then
    pitLimiterHandled = false
    removeEventHandler("onClientPreRender", getRootElement(), pitLimiterHandler)
    removeEventHandler("onClientRender", getRootElement(), pitLimiterRender)
    sightexports.sSpeedo:togglePitLimiter(false)
    return
  end
end
addEventHandler("onClientColShapeHit", pitLimiter, function(he)
  if he == localPlayer and not pitLimiterHandled then
    pitLimiterHandled = true
    addEventHandler("onClientPreRender", getRootElement(), pitLimiterHandler)
    addEventHandler("onClientRender", getRootElement(), pitLimiterRender)
    sightexports.sSpeedo:togglePitLimiter(true)
  end
end)
local layouts = {
  {
    {
      "SeeRing_tirewall2",
      -1094.3346,
      -110.2104,
      13.8127,
      0.5077,
      0.2679,
      242.1808
    },
    {
      "SeeRing_tirewall2",
      -1100.8601,
      -122.6666,
      13.7473,
      0.5104,
      0.2629,
      242.7469
    },
    {
      "SeeRing_tirewall2",
      -1107.0581,
      -135.2111,
      13.6852,
      0.5221,
      0.2388,
      245.419
    },
    {
      "SeeRing_tirewall2",
      -1111.0249,
      -148.0918,
      13.6455,
      0.5651,
      0.1013,
      259.838
    },
    {
      "SeeRing_tirewall1",
      -1092.0958,
      -102.8036,
      13.8408,
      0,
      0,
      -80.6253
    },
    {
      "SeeRing_tirewall1",
      -1092.9105,
      -102.9381,
      13.8408,
      0,
      0,
      -80.6253
    },
    {
      "SeeRing_tirewall1",
      -1093.5642,
      -98.9784,
      13.8408,
      0,
      0,
      -80.6253
    },
    {
      "SeeRing_tirewall1",
      -1092.7495,
      -98.8439,
      13.8408,
      0,
      0,
      -80.6253
    },
    {
      "SeeRing_tirewall1",
      -1112.09,
      -157.651,
      13.7909,
      0,
      1.9794,
      -92.0783
    },
    {
      "SeeRing_tirewall1",
      -1112.8041,
      -157.2291,
      13.7897,
      0,
      1.9794,
      -92.0783
    },
    {
      "SeeRing_tirewall1",
      -1112.236,
      -161.7095,
      13.796,
      0,
      -0.8829,
      -92.0783
    },
    {
      "SeeRing_tirewall1",
      -1112.9513,
      -161.2873,
      13.7947,
      0,
      -0.8829,
      -92.0783
    },
    {
      "SeeRing_tirewall1",
      -1112.3815,
      -165.7197,
      13.8237,
      0,
      -0.0503,
      -92.0783
    },
    {
      "SeeRing_tirewall1",
      -1113.0968,
      -165.2975,
      13.8225,
      0,
      -0.0503,
      -92.0783
    },
    {
      "SeeRing_tirewall1",
      -1112.527,
      -169.7302,
      13.8141,
      0,
      -0.1802,
      -92.0783
    },
    {
      "SeeRing_tirewall1",
      -1113.2423,
      -169.308,
      13.8129,
      0,
      -0.1802,
      -92.0783
    },
    {
      "SeeRing_tirewall1",
      -1112.6725,
      -173.7409,
      13.8268,
      0,
      -0.1802,
      -92.0783
    },
    {
      "SeeRing_tirewall1",
      -1113.3878,
      -173.3186,
      13.8255,
      0,
      -0.1802,
      -92.0783
    },
    {
      "SeeRing_tirewall1",
      -1112.818,
      -177.7515,
      13.8394,
      0,
      -0.1802,
      -92.0783
    },
    {
      "SeeRing_tirewall1",
      -1113.5333,
      -177.3293,
      13.8381,
      0,
      -0.1802,
      -92.0783
    },
    {
      "SeeRing_tirewall1",
      -1112.9635,
      -181.7621,
      13.852,
      0,
      -0.1802,
      -92.0783
    },
    {
      "SeeRing_tirewall1",
      -1113.6788,
      -181.3398,
      13.8508,
      0,
      -0.1802,
      -92.0783
    },
    {
      "rbs40",
      -1097.6472,
      -116.4303,
      13.8627,
      0,
      0,
      -116.0342
    },
    {
      "rbs40",
      -1104.0599,
      -128.8488,
      13.8627,
      0,
      0,
      -116.0342
    },
    {
      "rbs40",
      -1109.7847,
      -141.3681,
      13.8627,
      0,
      0,
      -103.0234
    },
    {
      "rbs40",
      -1112.0991,
      -154.8063,
      13.8627,
      0,
      0,
      -94.7488
    },
    {
      "SeeRing_tirewall1",
      -1170.9423,
      -350.6991,
      21.9459,
      -0.1511,
      0.5581,
      -97.332
    },
    {
      "SeeRing_tirewall1",
      -1171.7504,
      -350.5951,
      21.948,
      -0.1511,
      0.5581,
      -97.332
    },
    {
      "SeeRing_tirewall1",
      -1171.5591,
      -354.686,
      21.9399,
      0.0126,
      0.1163,
      -102.1208
    },
    {
      "SeeRing_tirewall1",
      -1172.3672,
      -354.582,
      21.9421,
      0.0126,
      0.1163,
      -102.1208
    },
    {
      "SeeRing_tirewall1",
      -1180.8743,
      -394.3871,
      24.4557,
      6.9583,
      -3.8297,
      -119.0915
    },
    {
      "SeeRing_tirewall1",
      -1181.5984,
      -393.9918,
      24.3553,
      6.9583,
      -3.8297,
      -119.0915
    },
    {
      "SeeRing_tirewall1",
      -1178.962,
      -390.8051,
      24.1932,
      4.2609,
      -4.0153,
      -115.805
    },
    {
      "SeeRing_tirewall1",
      -1179.6862,
      -390.4099,
      24.0927,
      4.2609,
      -4.0153,
      -115.805
    },
    {
      "SeeRing_tirewall1",
      -1177.2072,
      -387.1697,
      23.9096,
      4.1144,
      -4.1653,
      -113.7518
    },
    {
      "SeeRing_tirewall1",
      -1177.9313,
      -386.7745,
      23.8092,
      4.1144,
      -4.1653,
      -113.7518
    },
    {
      "SeeRing_tirewall1",
      -1175.4795,
      -383.6862,
      23.6396,
      4.1144,
      -4.1653,
      -113.7518
    },
    {
      "SeeRing_tirewall1",
      -1176.2036,
      -383.291,
      23.5392,
      4.1144,
      -4.1653,
      -113.7518
    },
    {
      "SeeRing_tirewall2",
      -1172.3889,
      -363.3226,
      21.9099,
      8.2268,
      -3.5156,
      265.4173
    },
    {
      "SeeRing_tirewall2",
      -1173.8013,
      -375.2583,
      22.6073,
      6.6747,
      -2.8861,
      260.3053
    },
    {
      "SeeRing_tirewall1",
      -1219.7738,
      -500.516,
      35.3089,
      -1.5863,
      -2.1489,
      -82.354
    },
    {
      "SeeRing_tirewall1",
      -1220.5281,
      -500.6165,
      35.33,
      -1.5863,
      -2.1489,
      -82.354
    },
    {
      "SeeRing_tirewall1",
      -1223.9419,
      -529.9566,
      36.9767,
      0.5286,
      -4.7903,
      -107.2153
    },
    {
      "SeeRing_tirewall1",
      -1225.129,
      -533.7876,
      37.3128,
      0.5286,
      -4.7903,
      -107.2153
    },
    {
      "SeeRing_tirewall1",
      -1225.99,
      -533.8168,
      37.3289,
      0.5286,
      -4.7903,
      -107.2153
    },
    {
      "SeeRing_tirewall1",
      -1224.8029,
      -529.9858,
      36.9928,
      0.5286,
      -4.7903,
      -107.2153
    },
    {
      "SeeRing_tirewall2",
      -1221.6444,
      -521.9629,
      36.2997,
      1.1188,
      -3.5715,
      256.6222
    },
    {
      "SeeRing_tirewall2",
      -1219.817,
      -508.7397,
      35.4585,
      0.641,
      -2.2995,
      266.5577
    },
    {
      "rbs40",
      -1219.9403,
      -515.4459,
      35.9347,
      -1.4824,
      -3.3821,
      -94.2622
    },
    {
      "rbs40",
      -1332.0948,
      -653.5823,
      51.3623,
      4.085,
      -2.3663,
      -175.0498
    },
    {
      "rbs40",
      -1346.541,
      -655.1516,
      51.9797,
      3.5133,
      -1.7007,
      -175.0056
    },
    {
      "rbs40",
      -1360.6422,
      -656.6879,
      52.2804,
      8.3855,
      -1.2277,
      -174.9254
    },
    {
      "rbs40",
      -1379.9359,
      -658.5243,
      52.879,
      1.7475,
      -3.4584,
      227.324
    },
    {
      "rbs40",
      -1393.6759,
      -660.0458,
      53.179,
      5.5812,
      -0.8643,
      185.0651
    },
    {
      "rbs40",
      -1407.6401,
      -661.045,
      53.3157,
      7.9625,
      2.5057,
      160.4056
    },
    {
      "rbs40",
      -1422.9778,
      -662.0755,
      53.5546,
      7.8868,
      -2.7359,
      196.7751
    },
    {
      "rbs40",
      -1438.0898,
      -663.2242,
      53.7641,
      5.9027,
      -0.0808,
      181.8214
    },
    {
      "rbs40",
      -1440.7814,
      -663.2012,
      53.7566,
      5.9026,
      0.0922,
      180.1482
    },
    {
      "SeeRing_tirewall2",
      -1339.2268,
      -654.5014,
      51.6198,
      4.0297,
      -2.3852,
      185.9649
    },
    {
      "SeeRing_tirewall2",
      -1353.8362,
      -655.9672,
      52.1146,
      8.3628,
      -1.3748,
      186.0747
    },
    {
      "SeeRing_tirewall2",
      -1386.4728,
      -659.5656,
      53.0657,
      -3.596,
      1.4427,
      5.9843
    },
    {
      "SeeRing_tirewall2",
      -1400.7686,
      -660.77,
      53.2938,
      -5.5867,
      0.8283,
      4.6964
    },
    {
      "SeeRing_tirewall2",
      -1430.4865,
      -662.9075,
      53.7175,
      -8.302,
      0.8489,
      3.5603
    },
    {
      "SeeRing_tirewall2",
      -1447.8932,
      -663.4683,
      53.7689,
      -5.9032,
      0.033,
      1.3587
    },
    {
      "SeeRing_tirewall1",
      -1665.1223,
      -603.0087,
      27.251,
      -0.413,
      -10.209,
      -64.2681
    },
    {
      "SeeRing_tirewall1",
      -1664.3027,
      -602.615,
      27.2445,
      -0.413,
      -10.209,
      -64.2681
    },
    {
      "SeeRing_tirewall1",
      -1666.837,
      -599.4506,
      26.5397,
      -0.413,
      -10.209,
      -64.2681
    },
    {
      "SeeRing_tirewall1",
      -1666.0176,
      -599.0569,
      26.5332,
      -0.413,
      -10.209,
      -64.2681
    },
    {
      "SeeRing_tirewall1",
      -1676.0985,
      -568.9341,
      23.3643,
      3.4971,
      -1.9716,
      -85.4143
    },
    {
      "SeeRing_tirewall1",
      -1675.2849,
      -568.9688,
      23.4171,
      3.4971,
      -1.9716,
      -85.4143
    },
    {
      "SeeRing_tirewall2",
      -1669.5167,
      -590.9933,
      25.355,
      0.1586,
      -5.9612,
      -71.0359
    },
    {
      "SeeRing_tirewall2",
      -1673.8734,
      -577.8751,
      23.9803,
      -0.2057,
      -5.3932,
      -72.6677
    },
    {
      "rbs40",
      -1671.7734,
      -584.4802,
      24.6372,
      -0.1031,
      5.9625,
      109.4982
    },
    {
      "SeeRing_tirewall2",
      -1488.3271,
      -188.0316,
      13.947,
      2.6399,
      1.3983,
      23.177
    },
    {
      "SeeRing_tirewall2",
      -1474.5977,
      -182.2443,
      13.9173,
      -0.0542,
      0.0924,
      25.6589
    },
    {
      "SeeRing_tirewall2",
      -1461.5613,
      -175.7536,
      13.8304,
      0.0854,
      -0.5565,
      27.5543
    },
    {
      "SeeRing_tirewall2",
      -1448.6497,
      -168.9354,
      13.9338,
      0.6135,
      0.2243,
      27.5591
    },
    {
      "SeeRing_tirewall1",
      -1441.1774,
      -165.3113,
      13.8987,
      0.5843,
      0.2922,
      21.0713
    },
    {
      "SeeRing_tirewall1",
      -1440.8794,
      -166.0849,
      13.8903,
      0.5843,
      0.2922,
      21.0713
    },
    {
      "rbs40",
      -1481.4246,
      -185.2274,
      13.9508,
      -0.7023,
      0.9474,
      19.4901
    },
    {
      "rbs40",
      -1467.9814,
      -179.0499,
      13.8779,
      0.3507,
      0.0089,
      25.4591
    },
    {
      "rbs40",
      -1455.0765,
      -172.3917,
      13.9034,
      0.0715,
      -0.5584,
      28.9802
    }
  },
  {
    {
      "SeeRing_tirewall2",
      -1094.3346,
      -110.2104,
      13.8127,
      0.5077,
      0.2679,
      242.1808
    },
    {
      "SeeRing_tirewall2",
      -1100.8601,
      -122.6666,
      13.7473,
      0.5104,
      0.2629,
      242.7469
    },
    {
      "SeeRing_tirewall2",
      -1107.0581,
      -135.2111,
      13.6852,
      0.5221,
      0.2388,
      245.419
    },
    {
      "SeeRing_tirewall2",
      -1111.0249,
      -148.0918,
      13.6455,
      0.5651,
      0.1013,
      259.838
    },
    {
      "SeeRing_tirewall1",
      -1092.0958,
      -102.8036,
      13.8408,
      0,
      0,
      -80.6253
    },
    {
      "SeeRing_tirewall1",
      -1092.9105,
      -102.9381,
      13.8408,
      0,
      0,
      -80.6253
    },
    {
      "SeeRing_tirewall1",
      -1093.5642,
      -98.9784,
      13.8408,
      0,
      0,
      -80.6253
    },
    {
      "SeeRing_tirewall1",
      -1092.7495,
      -98.8439,
      13.8408,
      0,
      0,
      -80.6253
    },
    {
      "SeeRing_tirewall1",
      -1112.09,
      -157.651,
      13.7909,
      0,
      1.9794,
      -92.0783
    },
    {
      "SeeRing_tirewall1",
      -1112.8041,
      -157.2291,
      13.7897,
      0,
      1.9794,
      -92.0783
    },
    {
      "SeeRing_tirewall1",
      -1112.236,
      -161.7095,
      13.796,
      0,
      -0.8829,
      -92.0783
    },
    {
      "SeeRing_tirewall1",
      -1112.9513,
      -161.2873,
      13.7947,
      0,
      -0.8829,
      -92.0783
    },
    {
      "SeeRing_tirewall1",
      -1112.3815,
      -165.7197,
      13.8237,
      0,
      -0.0503,
      -92.0783
    },
    {
      "SeeRing_tirewall1",
      -1113.0968,
      -165.2975,
      13.8225,
      0,
      -0.0503,
      -92.0783
    },
    {
      "SeeRing_tirewall1",
      -1112.527,
      -169.7302,
      13.8141,
      0,
      -0.1802,
      -92.0783
    },
    {
      "SeeRing_tirewall1",
      -1113.2423,
      -169.308,
      13.8129,
      0,
      -0.1802,
      -92.0783
    },
    {
      "SeeRing_tirewall1",
      -1112.6725,
      -173.7409,
      13.8268,
      0,
      -0.1802,
      -92.0783
    },
    {
      "SeeRing_tirewall1",
      -1113.3878,
      -173.3186,
      13.8255,
      0,
      -0.1802,
      -92.0783
    },
    {
      "SeeRing_tirewall1",
      -1112.818,
      -177.7515,
      13.8394,
      0,
      -0.1802,
      -92.0783
    },
    {
      "SeeRing_tirewall1",
      -1113.5333,
      -177.3293,
      13.8381,
      0,
      -0.1802,
      -92.0783
    },
    {
      "SeeRing_tirewall1",
      -1112.9635,
      -181.7621,
      13.852,
      0,
      -0.1802,
      -92.0783
    },
    {
      "SeeRing_tirewall1",
      -1113.6788,
      -181.3398,
      13.8508,
      0,
      -0.1802,
      -92.0783
    },
    {
      "rbs40",
      -1097.6472,
      -116.4303,
      13.8627,
      0,
      0,
      -116.0342
    },
    {
      "rbs40",
      -1104.0599,
      -128.8488,
      13.8627,
      0,
      0,
      -116.0342
    },
    {
      "rbs40",
      -1109.7847,
      -141.3681,
      13.8627,
      0,
      0,
      -103.0234
    },
    {
      "rbs40",
      -1112.0991,
      -154.8063,
      13.8627,
      0,
      0,
      -94.7488
    },
    {
      "SeeRing_tirewall1",
      -1170.9423,
      -350.6991,
      21.9459,
      -0.1511,
      0.5581,
      -97.332
    },
    {
      "SeeRing_tirewall1",
      -1171.7504,
      -350.5951,
      21.948,
      -0.1511,
      0.5581,
      -97.332
    },
    {
      "SeeRing_tirewall1",
      -1171.5591,
      -354.686,
      21.9399,
      0.0126,
      0.1163,
      -102.1208
    },
    {
      "SeeRing_tirewall1",
      -1172.3672,
      -354.582,
      21.9421,
      0.0126,
      0.1163,
      -102.1208
    },
    {
      "SeeRing_tirewall1",
      -1180.8743,
      -394.3871,
      24.4557,
      6.9583,
      -3.8297,
      -119.0915
    },
    {
      "SeeRing_tirewall1",
      -1181.5984,
      -393.9918,
      24.3553,
      6.9583,
      -3.8297,
      -119.0915
    },
    {
      "SeeRing_tirewall1",
      -1178.962,
      -390.8051,
      24.1932,
      4.2609,
      -4.0153,
      -115.805
    },
    {
      "SeeRing_tirewall1",
      -1179.6862,
      -390.4099,
      24.0927,
      4.2609,
      -4.0153,
      -115.805
    },
    {
      "SeeRing_tirewall1",
      -1177.2072,
      -387.1697,
      23.9096,
      4.1144,
      -4.1653,
      -113.7518
    },
    {
      "SeeRing_tirewall1",
      -1177.9313,
      -386.7745,
      23.8092,
      4.1144,
      -4.1653,
      -113.7518
    },
    {
      "SeeRing_tirewall1",
      -1175.4795,
      -383.6862,
      23.6396,
      4.1144,
      -4.1653,
      -113.7518
    },
    {
      "SeeRing_tirewall1",
      -1176.2036,
      -383.291,
      23.5392,
      4.1144,
      -4.1653,
      -113.7518
    },
    {
      "SeeRing_tirewall2",
      -1172.3889,
      -363.3226,
      21.9099,
      8.2268,
      -3.5156,
      265.4173
    },
    {
      "SeeRing_tirewall2",
      -1173.8013,
      -375.2583,
      22.6073,
      6.6747,
      -2.8861,
      260.3053
    },
    {
      "SeeRing_tirewall1",
      -1185.3146,
      -524.682,
      35.6497,
      0.6832,
      -3.6541,
      -145.1286
    },
    {
      "SeeRing_tirewall1",
      -1184.8837,
      -525.2996,
      35.6587,
      0.6832,
      -3.6541,
      -145.1286
    },
    {
      "SeeRing_tirewall1",
      -1188.4293,
      -527.3138,
      35.9135,
      1.3021,
      -3.4822,
      -155.0479
    },
    {
      "SeeRing_tirewall1",
      -1188.7478,
      -526.6315,
      35.8964,
      1.3021,
      -3.4822,
      -155.0479
    },
    {
      "SeeRing_tirewall1",
      -1222.6735,
      -534.4844,
      37.3593,
      4.4355,
      -0.7405,
      -180.5579
    },
    {
      "SeeRing_tirewall1",
      -1222.6804,
      -535.2873,
      37.4216,
      4.4355,
      -0.7405,
      -180.5579
    },
    {
      "SeeRing_tirewall1",
      -1218.6946,
      -534.3156,
      37.2918,
      -175.6691,
      -178.7886,
      5.5809
    },
    {
      "SeeRing_tirewall1",
      -1218.7015,
      -535.1185,
      37.3541,
      -175.6691,
      -178.7886,
      5.5809
    },
    {
      "SeeRing_tirewall2",
      -1196.2739,
      -529.7418,
      36.4691,
      3.2613,
      -2.9494,
      201.2149
    },
    {
      "SeeRing_tirewall2",
      -1210.7175,
      -533.5587,
      37.0606,
      4.2964,
      -1.434,
      186.7099
    },
    {
      "rbs40",
      -1203.379,
      -532.3723,
      36.8546,
      -3.4959,
      2.667,
      16.4282
    },
    {
      "SeeRing_tirewall1",
      -1272.082,
      -534.7904,
      37.5872,
      2.3071,
      -3.1218,
      -189.3911
    },
    {
      "SeeRing_tirewall1",
      -1272.2163,
      -535.614,
      37.6208,
      2.3071,
      -3.1218,
      -189.3911
    },
    {
      "SeeRing_tirewall1",
      -1276.1511,
      -534.7303,
      37.8901,
      2.2976,
      -4.1465,
      -194.3281
    },
    {
      "SeeRing_tirewall1",
      -1276.0168,
      -533.9068,
      37.8566,
      2.2976,
      -4.1465,
      -194.3281
    },
    {
      "SeeRing_tirewall1",
      -1279.9441,
      -533.5333,
      38.1641,
      5.2271,
      -2.9667,
      -202.4124
    },
    {
      "SeeRing_tirewall1",
      -1279.8098,
      -532.7098,
      38.1305,
      5.2271,
      -2.9667,
      -202.4124
    },
    {
      "SeeRing_tirewall1",
      -1308.8608,
      -520.7693,
      39.1539,
      7.4893,
      2.8053,
      -213.0935
    },
    {
      "SeeRing_tirewall1",
      -1308.3854,
      -520.1176,
      39.0499,
      7.4893,
      2.8053,
      -213.0935
    },
    {
      "SeeRing_tirewall1",
      -1312.1951,
      -518.4974,
      38.9453,
      7.3534,
      3.1458,
      -215.7105
    },
    {
      "SeeRing_tirewall1",
      -1311.7196,
      -517.8456,
      38.8413,
      7.3534,
      3.1458,
      -215.7105
    },
    {
      "SeeRing_tirewall2",
      -1287.8553,
      -530.4761,
      38.4057,
      5.028,
      -2.672,
      160.4607
    },
    {
      "SeeRing_tirewall2",
      -1301.2087,
      -524.2585,
      38.9456,
      6.3149,
      -1.77,
      150.2123
    },
    {
      "rbs40",
      -1294.8669,
      -527.8649,
      38.7467,
      -5.2778,
      2.1353,
      -25.4902
    },
    {
      "SeeRing_tirewall1",
      -1335.7369,
      -451.7816,
      29.7888,
      10.2398,
      5.14,
      -184.711
    },
    {
      "SeeRing_tirewall1",
      -1335.6478,
      -450.8782,
      29.6255,
      10.2398,
      5.14,
      -184.711
    },
    {
      "SeeRing_tirewall1",
      -1339.8066,
      -451.4463,
      29.4215,
      10.2398,
      5.14,
      -184.711
    },
    {
      "SeeRing_tirewall1",
      -1339.7175,
      -450.5429,
      29.2582,
      10.2398,
      5.14,
      -184.711
    },
    {
      "SeeRing_tirewall1",
      -1372.7494,
      -450.4885,
      30.6943,
      9.3152,
      -0.537,
      -184.4311
    },
    {
      "SeeRing_tirewall1",
      -1372.6895,
      -449.6989,
      30.5644,
      9.3152,
      -0.537,
      -184.4311
    },
    {
      "SeeRing_tirewall1",
      -1376.7094,
      -450.1249,
      30.5131,
      10.8882,
      3.1214,
      -183.7792
    },
    {
      "SeeRing_tirewall1",
      -1376.6494,
      -449.3353,
      30.3832,
      10.8882,
      3.1214,
      -183.7792
    },
    {
      "SeeRing_tirewall2",
      -1349.1821,
      -450.3234,
      29.23,
      -4.018,
      3.3,
      -4.7327
    },
    {
      "SeeRing_tirewall2",
      -1364.4467,
      -450.0334,
      30.1767,
      -3.59,
      3.761,
      2.208
    },
    {
      "rbs40",
      -1356.9092,
      -449.7602,
      29.6841,
      3.8965,
      -3.4424,
      177.3335
    },
    {
      "SeeRing_tirewall1",
      -1369.2344,
      -489.2532,
      31.7447,
      8.2214,
      3.0116,
      -203.5502
    },
    {
      "SeeRing_tirewall1",
      -1372.9633,
      -487.6279,
      31.5307,
      8.2214,
      3.0116,
      -203.5502
    },
    {
      "SeeRing_tirewall1",
      -1369.2744,
      -490.0919,
      31.7768,
      1.8783,
      3.1753,
      -203.5023
    },
    {
      "SeeRing_tirewall1",
      -1373.0042,
      -488.47,
      31.5512,
      1.8783,
      3.1753,
      -203.5023
    },
    {
      "SeeRing_tirewall1",
      -1458.0188,
      -473.2583,
      30.6127,
      0.5772,
      1.3582,
      -185.995
    },
    {
      "SeeRing_tirewall1",
      -1458.1024,
      -474.0526,
      30.6207,
      0.5772,
      1.3582,
      -185.995
    },
    {
      "SeeRing_tirewall2",
      -1381.6255,
      -485.8204,
      31.2495,
      1.777,
      -0.5661,
      175.285
    },
    {
      "SeeRing_tirewall2",
      -1396.2874,
      -484.5023,
      31.4214,
      0,
      0.053,
      -5.7715
    },
    {
      "SeeRing_tirewall2",
      -1423.061,
      -481.386,
      31.351,
      0,
      0.011,
      -13.3781
    },
    {
      "SeeRing_tirewall2",
      -1436.5146,
      -478.1869,
      31.1245,
      0,
      -1.893,
      -13.2945
    },
    {
      "SeeRing_tirewall2",
      -1449.9993,
      -474.8846,
      30.6854,
      0,
      -2.004,
      -15.6479
    },
    {
      "rbs40",
      -1389.0148,
      -485.058,
      31.405,
      -1.7381,
      1.0623,
      -2.5493
    },
    {
      "rbs40",
      -1403.0966,
      -483.8078,
      31.4165,
      -5.7051,
      -0.0615,
      -5.8557
    },
    {
      "rbs40",
      -1416.5873,
      -482.716,
      31.4564,
      -5.1607,
      0.4596,
      -5.9053
    },
    {
      "rbs40",
      -1429.8373,
      -479.8085,
      31.3532,
      -2.5428,
      -0.0165,
      -13.5028
    },
    {
      "rbs40",
      -1443.4448,
      -476.6575,
      30.9138,
      3.3297,
      -0.2964,
      -13.5047
    },
    {
      "SeeRing_tirewall1",
      -1490.5165,
      -458.3053,
      28.644,
      -4.3118,
      20.4203,
      -210.4801
    },
    {
      "SeeRing_tirewall1",
      -1490.9146,
      -459.0243,
      28.5859,
      -4.3118,
      20.4203,
      -210.4801
    },
    {
      "SeeRing_tirewall1",
      -1512.1957,
      -435.7584,
      25.5782,
      -0.7544,
      3.9315,
      -239.8004
    },
    {
      "SeeRing_tirewall1",
      -1512.8905,
      -436.1635,
      25.5677,
      -0.7544,
      3.9315,
      -239.8004
    },
    {
      "SeeRing_tirewall1",
      -1514.8662,
      -432.6822,
      25.3069,
      -3.6131,
      4.0999,
      -239.8069
    },
    {
      "SeeRing_tirewall1",
      -1514.1714,
      -432.277,
      25.3175,
      -3.6131,
      4.0999,
      -239.8069
    },
    {
      "SeeRing_tirewall2",
      -1497.64,
      -453.3251,
      27.2561,
      -1.3301,
      -4.7205,
      -39.6018
    },
    {
      "SeeRing_tirewall2",
      -1507.4843,
      -442.7417,
      26.1633,
      0.3757,
      -3.9855,
      -54.3188
    },
    {
      "rbs40",
      -1503.1196,
      -448.5793,
      26.6993,
      -1.5579,
      -4.0644,
      -44.7464
    },
    {
      "SeeRing_tirewall2",
      -1491.9043,
      -185.3419,
      13.9169,
      -2.9683,
      -1.4164,
      -122.2762
    },
    {
      "SeeRing_tirewall2",
      -1483.5072,
      -173.4158,
      13.9147,
      0,
      0,
      -127.6016
    },
    {
      "SeeRing_tirewall2",
      -1474.3436,
      -161.6751,
      13.9147,
      0,
      0,
      -128.9815
    },
    {
      "SeeRing_tirewall2",
      -1465.3,
      -150.7484,
      13.9147,
      0,
      0,
      -131.1665
    },
    {
      "SeeRing_tirewall1",
      -1460.7941,
      -143.819,
      13.9147,
      -3.0E-4,
      2.0E-4,
      58.0896
    },
    {
      "SeeRing_tirewall1",
      -1460.1006,
      -144.2508,
      13.9147,
      -3.0E-4,
      2.0E-4,
      58.0896
    },
    {
      "rbs40",
      -1487.92,
      -179.2755,
      13.9167,
      0,
      0,
      -123.0334
    },
    {
      "rbs40",
      -1479.0062,
      -167.4851,
      13.9167,
      0,
      0,
      -127.7745
    },
    {
      "rbs40",
      -1469.8873,
      -156.1233,
      13.9167,
      0,
      0,
      -127.7745
    }
  },
  {
    {
      "SeeRing_tirewall1",
      -1066.2847,
      -116.6693,
      14.1012,
      0,
      1.7233,
      -160.752
    },
    {
      "SeeRing_tirewall1",
      -1066.5558,
      -115.8927,
      14.1012,
      0,
      1.7233,
      -160.752
    },
    {
      "SeeRing_tirewall1",
      -1070.0701,
      -117.9911,
      13.9806,
      0,
      1.7233,
      -160.752
    },
    {
      "SeeRing_tirewall1",
      -1070.3412,
      -117.2145,
      13.9806,
      0,
      1.7233,
      -160.752
    },
    {
      "SeeRing_tirewall1",
      -1126.0024,
      -172.7158,
      13.7141,
      0.8475,
      -0.1391,
      -129.1696
    },
    {
      "SeeRing_tirewall1",
      -1126.6713,
      -172.1709,
      13.7014,
      0.8475,
      -0.1391,
      -129.1696
    },
    {
      "SeeRing_tirewall1",
      -1128.5358,
      -175.8253,
      13.7239,
      0.8475,
      -0.1391,
      -129.1696
    },
    {
      "SeeRing_tirewall1",
      -1129.2046,
      -175.2804,
      13.7111,
      0.8475,
      -0.1391,
      -129.1696
    },
    {
      "SeeRing_tirewall2",
      -1077.1511,
      -123.1175,
      13.9832,
      -0.3438,
      -0.0896,
      407.6756
    },
    {
      "SeeRing_tirewall2",
      -1087.5437,
      -134.1449,
      13.958,
      -0.3403,
      -0.1023,
      405.5489
    },
    {
      "SeeRing_tirewall2",
      -1098.5409,
      -145.1016,
      13.9286,
      -0.3367,
      -0.1136,
      404.0151
    },
    {
      "SeeRing_tirewall2",
      -1109.5236,
      -155.5569,
      13.7894,
      -1.9795,
      -0.3314,
      403.9006
    },
    {
      "SeeRing_tirewall2",
      -1120.1814,
      -165.6408,
      13.7002,
      -1.9746,
      -0.3597,
      403.0807
    },
    {
      "rbs40",
      -1082.33,
      -128.7703,
      13.9731,
      -0.3374,
      -0.1113,
      44.0262
    },
    {
      "rbs40",
      -1093.0352,
      -139.8305,
      13.946,
      -0.3367,
      -0.1135,
      44.0262
    },
    {
      "rbs40",
      -1104.0557,
      -150.4044,
      13.9067,
      -0.3142,
      -0.1815,
      44.0266
    },
    {
      "rbs40",
      -1114.8271,
      -160.7032,
      13.7497,
      -1.9802,
      -0.3269,
      44.0295
    },
    {
      "SeeRing_tirewall1",
      -1334.9761,
      -453.4643,
      30.1795,
      10.0283,
      -6.0879,
      -129.6096
    },
    {
      "SeeRing_tirewall1",
      -1335.6232,
      -452.9488,
      30.034,
      10.0283,
      -6.0879,
      -129.6096
    },
    {
      "SeeRing_tirewall1",
      -1337.5288,
      -456.5489,
      30.6065,
      10.0283,
      -6.0879,
      -129.6096
    },
    {
      "SeeRing_tirewall1",
      -1338.1759,
      -456.0334,
      30.4611,
      10.0283,
      -6.0879,
      -129.6096
    },
    {
      "SeeRing_tirewall1",
      -1360.4241,
      -481.1324,
      32.0121,
      6.1822,
      1.2676,
      -128.5619
    },
    {
      "SeeRing_tirewall1",
      -1359.8242,
      -481.6129,
      32.0954,
      6.1822,
      1.2676,
      -128.5619
    },
    {
      "SeeRing_tirewall1",
      -1362.9325,
      -484.2789,
      31.9231,
      6.1822,
      1.2676,
      -128.5619
    },
    {
      "SeeRing_tirewall1",
      -1362.3326,
      -484.7595,
      32.0063,
      6.1822,
      1.2676,
      -128.5619
    },
    {
      "SeeRing_tirewall1",
      -1364.8318,
      -487.8943,
      31.9176,
      6.1822,
      1.2676,
      -128.5619
    },
    {
      "SeeRing_tirewall1",
      -1365.4316,
      -487.4138,
      31.8344,
      6.1822,
      1.2676,
      -128.5619
    },
    {
      "SeeRing_tirewall2",
      -1343.9348,
      -463.1057,
      31.1184,
      -10.3218,
      2.6199,
      47.6422
    },
    {
      "SeeRing_tirewall2",
      -1354.2153,
      -474.2226,
      31.809,
      -8.7077,
      2.2776,
      47.1791
    },
    {
      "rbs40",
      -1349.0931,
      -468.6069,
      31.4995,
      -8.6436,
      2.5116,
      48.7137
    },
    {
      "SeeRing_tirewall1",
      -1383.2942,
      -454.0883,
      30.8676,
      -5.5707,
      7.0503,
      -294.9679
    },
    {
      "SeeRing_tirewall1",
      -1384.0209,
      -453.7627,
      30.7687,
      -5.5707,
      7.0503,
      -294.9679
    },
    {
      "SeeRing_tirewall1",
      -1385.0438,
      -457.6385,
      31.2937,
      -7.0916,
      3.357,
      -294.5565
    },
    {
      "SeeRing_tirewall1",
      -1385.7705,
      -457.3128,
      31.1948,
      -7.0916,
      3.357,
      -294.5565
    },
    {
      "SeeRing_tirewall1",
      -1421.4181,
      -535.415,
      36.4867,
      4.5513,
      -5.1871,
      -124.2643
    },
    {
      "SeeRing_tirewall1",
      -1422.0835,
      -534.9686,
      36.4232,
      4.5513,
      -5.1871,
      -124.2643
    },
    {
      "SeeRing_tirewall2",
      -1390.5681,
      -465.3013,
      31.235,
      0.0921,
      -0.264,
      52.7447
    },
    {
      "SeeRing_tirewall2",
      -1399.28,
      -477.338,
      31.0566,
      -3.2948,
      0.9398,
      55.0658
    },
    {
      "SeeRing_tirewall2",
      -1412.8953,
      -501.2551,
      32.7652,
      -3.7623,
      5.4537,
      65.5705
    },
    {
      "SeeRing_tirewall2",
      -1417.2585,
      -514.0657,
      34.2001,
      -2.4444,
      6.3315,
      75.8673
    },
    {
      "SeeRing_tirewall2",
      -1419.6378,
      -527.5508,
      35.6516,
      -1.7293,
      5.6995,
      84.6806
    },
    {
      "rbs40",
      -1394.9954,
      -471.1477,
      31.1665,
      0.3805,
      0.1031,
      -124.901
    },
    {
      "rbs40",
      -1403.2921,
      -482.8298,
      31.3209,
      3.0432,
      -4.8284,
      -127.5174
    },
    {
      "rbs40",
      -1403.2921,
      -482.8298,
      31.3209,
      3.0432,
      -4.8284,
      -127.5174
    },
    {
      "rbs40",
      -1409.9774,
      -495.0012,
      32.2728,
      0.1861,
      -2.9835,
      -118.5474
    },
    {
      "rbs40",
      -1415.5883,
      -507.4374,
      33.4608,
      3.238,
      -6.568,
      -109.7509
    },
    {
      "rbs40",
      -1418.9927,
      -520.6506,
      34.9596,
      2.09,
      -5.8603,
      -100.6231
    },
    {
      "SeeRing_tirewall1",
      -1396.5742,
      -605.4406,
      45.3034,
      5.6082,
      -5.0166,
      -115.6454
    },
    {
      "SeeRing_tirewall1",
      -1395.7695,
      -605.8449,
      45.3466,
      5.6082,
      -5.0166,
      -115.6454
    },
    {
      "SeeRing_tirewall1",
      -1397.5275,
      -609.4988,
      45.6639,
      2.7709,
      -7.7024,
      -117.0512
    },
    {
      "SeeRing_tirewall1",
      -1398.3322,
      -609.0944,
      45.6207,
      2.7709,
      -7.7024,
      -117.0512
    },
    {
      "SeeRing_tirewall1",
      -1459.7871,
      -685.3475,
      53.78,
      -3.574,
      2.4451,
      -154.3649
    },
    {
      "SeeRing_tirewall1",
      -1459.4296,
      -686.0875,
      53.7287,
      -3.574,
      2.4451,
      -154.3649
    },
    {
      "SeeRing_tirewall1",
      -1463.4116,
      -687.0868,
      53.6083,
      -3.574,
      2.4451,
      -154.3649
    },
    {
      "SeeRing_tirewall1",
      -1463.0541,
      -687.8268,
      53.5571,
      -3.574,
      2.4451,
      -154.3649
    },
    {
      "SeeRing_tirewall1",
      -1467.0094,
      -688.8132,
      53.438,
      -3.574,
      2.4451,
      -154.3649
    },
    {
      "SeeRing_tirewall1",
      -1466.6519,
      -689.5532,
      53.3867,
      -3.574,
      2.4451,
      -154.3649
    },
    {
      "SeeRing_tirewall2",
      -1400.6064,
      -617.5488,
      47.0936,
      -1.7744,
      9.151,
      79.8295
    },
    {
      "SeeRing_tirewall2",
      -1404.1748,
      -631.3591,
      49.1521,
      -3.9883,
      6.9603,
      70.2725
    },
    {
      "SeeRing_tirewall2",
      -1410.0328,
      -644.0499,
      50.4185,
      -5.29,
      4.648,
      60.5181
    },
    {
      "SeeRing_tirewall2",
      -1427.0354,
      -666.3777,
      53.6851,
      -5.7931,
      -0.2501,
      39.4584
    },
    {
      "SeeRing_tirewall2",
      -1438.6851,
      -674.761,
      53.8799,
      -0.0025,
      -0.0046,
      31.002
    },
    {
      "SeeRing_tirewall2",
      -1451.5369,
      -681.6419,
      53.8972,
      -0.1931,
      -0.4493,
      25.2424
    },
    {
      "rbs40",
      -1401.912,
      -624.519,
      48.2416,
      -2.7748,
      8.1709,
      79.0681
    },
    {
      "rbs40",
      -1406.615,
      -637.9926,
      50.01,
      -4.4045,
      4.6162,
      67.339
    },
    {
      "rbs40",
      -1413.4023,
      -649.9863,
      51.2303,
      -5.6842,
      9.7666,
      58.0881
    },
    {
      "rbs40",
      -1421.8196,
      -662.1481,
      53.5586,
      -7.0585,
      4.4629,
      29.9098
    },
    {
      "rbs40",
      -1432.5887,
      -670.8768,
      53.8591,
      0.2524,
      0.3446,
      39.5473
    },
    {
      "rbs40",
      -1444.9769,
      -678.4637,
      53.9029,
      -0.0021,
      -0.0048,
      26.4462
    },
    {
      "SeeRing_tirewall1",
      -1665.1223,
      -603.0087,
      27.251,
      -0.413,
      -10.209,
      -64.2681
    },
    {
      "SeeRing_tirewall1",
      -1664.3027,
      -602.615,
      27.2445,
      -0.413,
      -10.209,
      -64.2681
    },
    {
      "SeeRing_tirewall1",
      -1666.837,
      -599.4506,
      26.5397,
      -0.413,
      -10.209,
      -64.2681
    },
    {
      "SeeRing_tirewall1",
      -1666.0176,
      -599.0569,
      26.5332,
      -0.413,
      -10.209,
      -64.2681
    },
    {
      "SeeRing_tirewall1",
      -1676.0985,
      -568.9341,
      23.3643,
      3.4971,
      -1.9716,
      -85.4143
    },
    {
      "SeeRing_tirewall1",
      -1675.2849,
      -568.9688,
      23.4171,
      3.4971,
      -1.9716,
      -85.4143
    },
    {
      "SeeRing_tirewall2",
      -1669.5167,
      -590.9933,
      25.355,
      0.1586,
      -5.9612,
      -71.0359
    },
    {
      "SeeRing_tirewall2",
      -1673.8734,
      -577.8751,
      23.9803,
      -0.2057,
      -5.3932,
      -72.6677
    },
    {
      "rbs40",
      -1671.7734,
      -584.4802,
      24.6372,
      -0.1031,
      5.9625,
      109.4982
    },
    {
      "SeeRing_tirewall2",
      -1488.3271,
      -188.0316,
      13.947,
      2.6399,
      1.3983,
      23.177
    },
    {
      "SeeRing_tirewall2",
      -1474.5977,
      -182.2443,
      13.9173,
      -0.0542,
      0.0924,
      25.6589
    },
    {
      "SeeRing_tirewall2",
      -1461.5613,
      -175.7536,
      13.8304,
      0.0854,
      -0.5565,
      27.5543
    },
    {
      "SeeRing_tirewall2",
      -1448.6497,
      -168.9354,
      13.9338,
      0.6135,
      0.2243,
      27.5591
    },
    {
      "SeeRing_tirewall1",
      -1441.1774,
      -165.3113,
      13.8987,
      0.5843,
      0.2922,
      21.0713
    },
    {
      "SeeRing_tirewall1",
      -1440.8794,
      -166.0849,
      13.8903,
      0.5843,
      0.2922,
      21.0713
    },
    {
      "rbs40",
      -1481.4246,
      -185.2274,
      13.9508,
      -0.7023,
      0.9474,
      19.4901
    },
    {
      "rbs40",
      -1467.9814,
      -179.0499,
      13.8779,
      0.3507,
      0.0089,
      25.4591
    },
    {
      "rbs40",
      -1455.0765,
      -172.3917,
      13.9034,
      0.0715,
      -0.5584,
      28.9802
    }
  },
  {
    {
      "SeeRing_tirewall2",
      -1094.3346,
      -110.2104,
      13.8127,
      0.5077,
      0.2679,
      242.1808
    },
    {
      "SeeRing_tirewall2",
      -1100.8601,
      -122.6666,
      13.7473,
      0.5104,
      0.2629,
      242.7469
    },
    {
      "SeeRing_tirewall2",
      -1107.0581,
      -135.2111,
      13.6852,
      0.5221,
      0.2388,
      245.419
    },
    {
      "SeeRing_tirewall2",
      -1111.0249,
      -148.0918,
      13.6455,
      0.5651,
      0.1013,
      259.838
    },
    {
      "SeeRing_tirewall1",
      -1092.0958,
      -102.8036,
      13.8408,
      0,
      0,
      -80.6253
    },
    {
      "SeeRing_tirewall1",
      -1092.9105,
      -102.9381,
      13.8408,
      0,
      0,
      -80.6253
    },
    {
      "SeeRing_tirewall1",
      -1093.5642,
      -98.9784,
      13.8408,
      0,
      0,
      -80.6253
    },
    {
      "SeeRing_tirewall1",
      -1092.7495,
      -98.8439,
      13.8408,
      0,
      0,
      -80.6253
    },
    {
      "SeeRing_tirewall1",
      -1112.09,
      -157.651,
      13.7909,
      0,
      1.9794,
      -92.0783
    },
    {
      "SeeRing_tirewall1",
      -1112.8041,
      -157.2291,
      13.7897,
      0,
      1.9794,
      -92.0783
    },
    {
      "SeeRing_tirewall1",
      -1112.236,
      -161.7095,
      13.796,
      0,
      -0.8829,
      -92.0783
    },
    {
      "SeeRing_tirewall1",
      -1112.9513,
      -161.2873,
      13.7947,
      0,
      -0.8829,
      -92.0783
    },
    {
      "SeeRing_tirewall1",
      -1112.3815,
      -165.7197,
      13.8237,
      0,
      -0.0503,
      -92.0783
    },
    {
      "SeeRing_tirewall1",
      -1113.0968,
      -165.2975,
      13.8225,
      0,
      -0.0503,
      -92.0783
    },
    {
      "SeeRing_tirewall1",
      -1112.527,
      -169.7302,
      13.8141,
      0,
      -0.1802,
      -92.0783
    },
    {
      "SeeRing_tirewall1",
      -1113.2423,
      -169.308,
      13.8129,
      0,
      -0.1802,
      -92.0783
    },
    {
      "SeeRing_tirewall1",
      -1112.6725,
      -173.7409,
      13.8268,
      0,
      -0.1802,
      -92.0783
    },
    {
      "SeeRing_tirewall1",
      -1113.3878,
      -173.3186,
      13.8255,
      0,
      -0.1802,
      -92.0783
    },
    {
      "SeeRing_tirewall1",
      -1112.818,
      -177.7515,
      13.8394,
      0,
      -0.1802,
      -92.0783
    },
    {
      "SeeRing_tirewall1",
      -1113.5333,
      -177.3293,
      13.8381,
      0,
      -0.1802,
      -92.0783
    },
    {
      "SeeRing_tirewall1",
      -1112.9635,
      -181.7621,
      13.852,
      0,
      -0.1802,
      -92.0783
    },
    {
      "SeeRing_tirewall1",
      -1113.6788,
      -181.3398,
      13.8508,
      0,
      -0.1802,
      -92.0783
    },
    {
      "rbs40",
      -1097.6472,
      -116.4303,
      13.8627,
      0,
      0,
      -116.0342
    },
    {
      "rbs40",
      -1104.0599,
      -128.8488,
      13.8627,
      0,
      0,
      -116.0342
    },
    {
      "rbs40",
      -1109.7847,
      -141.3681,
      13.8627,
      0,
      0,
      -103.0234
    },
    {
      "rbs40",
      -1112.0991,
      -154.8063,
      13.8627,
      0,
      0,
      -94.7488
    },
    {
      "SeeRing_tirewall1",
      -1120.9802,
      -343.349,
      22.0645,
      6.015,
      0.5561,
      -154.0264
    },
    {
      "SeeRing_tirewall1",
      -1120.6385,
      -344.0523,
      22.1469,
      6.015,
      0.5561,
      -154.0264
    },
    {
      "SeeRing_tirewall1",
      -1124.5597,
      -345.0928,
      22.0259,
      6.015,
      0.5561,
      -154.0264
    },
    {
      "SeeRing_tirewall1",
      -1124.218,
      -345.7961,
      22.1083,
      6.015,
      0.5561,
      -154.0264
    },
    {
      "SeeRing_tirewall1",
      -1128.1571,
      -346.8453,
      21.987,
      6.015,
      0.5561,
      -154.0264
    },
    {
      "SeeRing_tirewall1",
      -1128.1571,
      -346.8453,
      21.987,
      6.015,
      0.5561,
      -154.0264
    },
    {
      "SeeRing_tirewall1",
      -1127.8154,
      -347.5486,
      22.0694,
      6.015,
      0.5561,
      -154.0264
    },
    {
      "SeeRing_tirewall1",
      -1168.9692,
      -391.806,
      25.3901,
      9.3058,
      4.5919,
      -158.4657
    },
    {
      "SeeRing_tirewall1",
      -1168.683,
      -392.5605,
      25.5219,
      9.3058,
      4.5919,
      -158.4657
    },
    {
      "SeeRing_tirewall1",
      -1172.3549,
      -394.0158,
      25.2056,
      9.1665,
      4.8657,
      -160.155
    },
    {
      "SeeRing_tirewall1",
      -1172.6411,
      -393.2613,
      25.0738,
      9.1665,
      4.8657,
      -160.155
    },
    {
      "SeeRing_tirewall1",
      -1176.2064,
      -395.2901,
      24.956,
      8.2229,
      2.3834,
      -160.5353
    },
    {
      "SeeRing_tirewall1",
      -1176.4927,
      -394.5356,
      24.8242,
      8.2229,
      2.3834,
      -160.5353
    },
    {
      "SeeRing_tirewall1",
      -1180.066,
      -396.4555,
      24.7451,
      8.0388,
      2.9484,
      -164.4923
    },
    {
      "SeeRing_tirewall1",
      -1180.3523,
      -395.701,
      24.6133,
      8.0388,
      2.9484,
      -164.4923
    },
    {
      "SeeRing_tirewall2",
      -1133.9531,
      -353.7985,
      22.393,
      -0.8476,
      3.8122,
      420.8577
    },
    {
      "SeeRing_tirewall2",
      -1142.4298,
      -366.7442,
      23.4052,
      -1.2987,
      3.6831,
      413.9638
    },
    {
      "SeeRing_tirewall2",
      -1151.2241,
      -377.9203,
      24.3568,
      -1.683,
      3.5243,
      407.8554
    },
    {
      "SeeRing_tirewall2",
      -1161.3867,
      -387.1591,
      25.267,
      -2.459,
      3.4398,
      395.8403
    },
    {
      "rbs40",
      -1137.8174,
      -360.467,
      22.9556,
      -1.0311,
      3.7667,
      58.0811
    },
    {
      "rbs40",
      -1146.6309,
      -372.5835,
      23.9253,
      -1.3892,
      3.7588,
      51.1185
    },
    {
      "rbs40",
      -1155.9062,
      -383.0432,
      24.8516,
      -2.1296,
      3.6532,
      41.1515
    },
    {
      "SeeRing_tirewall1",
      -1631.7112,
      -549.6065,
      22.7729,
      -5.3081,
      -0.6929,
      -87.4896
    },
    {
      "SeeRing_tirewall1",
      -1632.5294,
      -549.6414,
      22.849,
      -5.3081,
      -0.6929,
      -87.4896
    },
    {
      "SeeRing_tirewall1",
      -1631.5344,
      -553.6401,
      22.8217,
      -5.3081,
      -0.6929,
      -87.4896
    },
    {
      "SeeRing_tirewall1",
      -1632.3527,
      -553.675,
      22.8978,
      -5.3081,
      -0.6929,
      -87.4896
    },
    {
      "SeeRing_tirewall1",
      -1628.9816,
      -584.2307,
      27.0761,
      3.6054,
      -9.338,
      -76.0132
    },
    {
      "SeeRing_tirewall1",
      -1629.7792,
      -584.1144,
      26.9782,
      3.6054,
      -9.338,
      -76.0132
    },
    {
      "SeeRing_tirewall1",
      -1628.0243,
      -588.0741,
      27.7274,
      3.6054,
      -9.338,
      -76.0132
    },
    {
      "SeeRing_tirewall1",
      -1628.8219,
      -587.9578,
      27.6295,
      3.6054,
      -9.338,
      -76.0132
    },
    {
      "SeeRing_tirewall2",
      -1631.4697,
      -562.2386,
      23.9045,
      2.5741,
      -8.273,
      -87.6889
    },
    {
      "SeeRing_tirewall2",
      -1630.2784,
      -576.2228,
      25.8899,
      4.1666,
      -7.9751,
      -83.1234
    },
    {
      "rbs40",
      -1631.157,
      -569.2763,
      24.8201,
      3.2192,
      -8.6452,
      278.8061
    },
    {
      "SeeRing_tirewall1",
      -1488.3931,
      -457.4073,
      28.7693,
      3.8092,
      19.1278,
      -271.8163
    },
    {
      "SeeRing_tirewall1",
      -1487.6085,
      -457.4493,
      28.7199,
      3.8092,
      19.1278,
      -271.8163
    },
    {
      "SeeRing_tirewall1",
      -1485.8431,
      -426.7426,
      26.197,
      -1.9842,
      8.1778,
      -279.993
    },
    {
      "SeeRing_tirewall1",
      -1485.0898,
      -426.8715,
      26.2232,
      -1.9842,
      8.1778,
      -279.993
    },
    {
      "SeeRing_tirewall1",
      -1485.1581,
      -422.8548,
      25.6297,
      -1.9842,
      8.1778,
      -279.993
    },
    {
      "SeeRing_tirewall1",
      -1484.4048,
      -422.9837,
      25.6559,
      -1.9842,
      8.1778,
      -279.993
    },
    {
      "SeeRing_tirewall2",
      -1487.4172,
      -449.1116,
      27.7104,
      5.2738,
      -2.76,
      -95.7401
    },
    {
      "SeeRing_tirewall2",
      -1486.1863,
      -434.8983,
      26.9804,
      5.8168,
      -3.4964,
      -94.2118
    },
    {
      "rbs40",
      -1486.7467,
      -442.0215,
      27.4115,
      -4.4433,
      2.2047,
      83.3446
    },
    {
      "SeeRing_tirewall2",
      -1491.9043,
      -185.3419,
      13.9169,
      -2.9683,
      -1.4164,
      -122.2762
    },
    {
      "SeeRing_tirewall2",
      -1483.5072,
      -173.4158,
      13.9147,
      0,
      0,
      -127.6016
    },
    {
      "SeeRing_tirewall2",
      -1474.3436,
      -161.6751,
      13.9147,
      0,
      0,
      -128.9815
    },
    {
      "SeeRing_tirewall2",
      -1465.3,
      -150.7484,
      13.9147,
      0,
      0,
      -131.1665
    },
    {
      "SeeRing_tirewall1",
      -1460.7941,
      -143.819,
      13.9147,
      -3.0E-4,
      2.0E-4,
      58.0896
    },
    {
      "SeeRing_tirewall1",
      -1460.1006,
      -144.2508,
      13.9147,
      -3.0E-4,
      2.0E-4,
      58.0896
    },
    {
      "rbs40",
      -1487.92,
      -179.2755,
      13.9167,
      0,
      0,
      -123.0334
    },
    {
      "rbs40",
      -1479.0062,
      -167.4851,
      13.9167,
      0,
      0,
      -127.7745
    },
    {
      "rbs40",
      -1469.8873,
      -156.1233,
      13.9167,
      0,
      0,
      -127.7745
    }
  }
}
local models = {}
for i = 1, #layouts do
  for j = 1, #layouts[i] do
    models[layouts[i][j][1]] = true
  end
end
local layoutObjects = {}
local modelsLoaded = false
function refreshLayout()
  for i = 1, #layoutObjects do
    if isElement(layoutObjects[i]) then
      destroyElement(layoutObjects[i])
    end
    layoutObjects[i] = nil
  end
  if currentLayout and modelsLoaded then
    for i = 1, #layouts[currentLayout] do
      layoutObjects[i] = createObject(models[layouts[currentLayout][i][1]], layouts[currentLayout][i][2], layouts[currentLayout][i][3], layouts[currentLayout][i][4], layouts[currentLayout][i][5], layouts[currentLayout][i][6], layouts[currentLayout][i][7])
    end
  end
end
addEvent("gotSeeringLayout", true)
addEventHandler("gotSeeringLayout", getRootElement(), function(layout)
  if currentLayout ~= layout then
    currentLayout = layout
    if isPlayerInSeeRing() then
      sightexports.sGui:showInfobox("i", "Új pályakiosztás: '" .. string.char(64 + layout) .. "' vonalvezetés.")
    end
    refreshLayout()
    endRaceTimer()
  end
end)
function loadModels()
  for model in pairs(models) do
    models[model] = sightexports.sModloader:getModelId(model)
  end
  modelsLoaded = true
  refreshLayout()
end
addEvent("modloaderLoaded", false)
addEventHandler("modloaderLoaded", getRootElement(), loadModels)
if getElementData(localPlayer, "loggedIn") then
  addEventHandler("onClientResourceStart", getResourceRootElement(), loadModels)
end
