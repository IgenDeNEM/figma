local seexports = {
  sPattach = false,
  sModloader = false,
  sControls = false,
  sGui = false,
  sItems = false
}
local function seelangProcessExports()
  for k in pairs(seexports) do
    local res = getResourceFromName(k)
    if res and getResourceState(res) == "running" then
      seexports[k] = exports[k]
    else
      seexports[k] = false
    end
  end
end
seelangProcessExports()
if triggerServerEvent then
  addEventHandler("onClientResourceStart", getRootElement(), seelangProcessExports, true, "high+9999999999")
end
if triggerClientEvent then
  addEventHandler("onResourceStart", getRootElement(), seelangProcessExports, true, "high+9999999999")
end
local seelangWaiterState0 = false
local function seelangProcessResWaiters()
  if not seelangWaiterState0 then
    local res0 = getResourceFromName("sModloader")
    if res0 and getResourceState(res0) == "running" then
      modloaderStartedG()
      seelangWaiterState0 = true
    end
  end
end
if triggerServerEvent then
  addEventHandler("onClientResourceStart", getRootElement(), seelangProcessResWaiters)
end
if triggerClientEvent then
  addEventHandler("onResourceStart", getRootElement(), seelangProcessResWaiters)
end
function shuffleTable(t)
  local rand = math.random
  local iterations = #t
  local j
  for i = iterations, 2, -1 do
    j = rand(i)
    t[i], t[j] = t[j], t[i]
  end
  return t
end
blockSize = 1
local shoploadPosTmp = {}
local attachOffsets = {
  bucket = {
    0.056901613296593,
    0.01741374449994,
    0.02618921598504,
    0.52479364206387,
    0.44776747438497,
    0.65784175560803,
    -0.3022253244035
  },
  crate = {
    0.11516103419687,
    0.17530775169285,
    -0.18859961461062,
    0.46023540294394,
    0.63196508625411,
    -0.50497534267942,
    -0.36579148010672
  },
  crate2 = {
    0.11471470250211,
    0.2,
    -0.2,
    0.46023540294394,
    0.63196508625411,
    -0.50497534267942,
    -0.36579148010672
  },
  hoe = {
    0.07562780548158,
    0.029708179194076,
    0.046597970361063,
    0.66179844884741,
    0,
    0.74968180790463,
    0
  },
  pitchfork = {
    0.085215696593491,
    0.037548118437492,
    5.913029689873E-19,
    0.013978756467498,
    3.4329441333813E-4,
    0.9996008443749,
    0.024548491634897
  },
  minihoe = {
    0.085098836256006,
    0.023397622041476,
    6.781434450472E-19,
    -0.0038556632671398,
    0.63009380398321,
    -0.014209050488422,
    0.77637944004653
  },
  kanna = {
    0.015469855585054,
    -7.2335122467893E-11,
    -0.0012005306488992,
    0.76714874038499,
    -1.1127726406342E-18,
    -0.64146925890936,
    0
  }
}
function processBoneAttach(obj, client, offset)
  seexports.sPattach:attach(obj, client, 24, -attachOffsets[offset][3], attachOffsets[offset][2], attachOffsets[offset][1], 0, 0, 0)
  seexports.sPattach:setRotationQuaternion(obj, {
    attachOffsets[offset][4],
    attachOffsets[offset][5],
    attachOffsets[offset][6],
    attachOffsets[offset][7]
  })
end
function modloaderStartedG()
  globalModels = {
    crate = seexports.sModloader:getModelId("farm:crate"),
    crate2 = seexports.sModloader:getModelId("farm:crate2"),
    furik = seexports.sModloader:getModelId("farm:furik"),
    bucket = seexports.sModloader:getModelId("farm:bucket"),
    kanna = seexports.sModloader:getModelId("farm:kanna")
  }
end
shoploadPosTmp = {
  {
    -1445.0498046875,
    -1489.4052734375,
    -1442.454296875,
    -1492.9052734375,
    100.9,
    160,
    -1448.259765625,
    -1499.361328125,
    101.868309021,
    270,
    true,
    "Demeter József",
    "Nagyker"
  },
  {
    -1431.02734375,
    -1524.388671875,
    -1426.90234375,
    -1526.8134765625,
    100.9,
    183,
    -1423.0224609375,
    -1530.0556640625,
    101.868309021,
    0,
    true,
    "Mészáros Károly",
    "Nagyker"
  },
  {
    -1431.02734375,
    -1545.188671875,
    -1426.90234375,
    -1547.6134765625,
    100.9,
    133,
    -1424.37109375,
    -1550.6083984375,
    101.868309021,
    0,
    true,
    "Erick Bauer",
    "Nagyker"
  },
  {
    -5.4619140625,
    -250.9462890625,
    -2.51171875,
    -247.27148437,
    4.5,
    153,
    -7.8427734375,
    -247.1123046875,
    5.4296875,
    270,
    false,
    "Mészáros Gyuri bá'",
    "Böllér"
  }
}
shopLoadPos = {}
shopLoadCol = {}
for i = 1, #shoploadPosTmp do
  shopLoadPos[i] = {}
  shopLoadPos[i][1] = math.min(shoploadPosTmp[i][1], shoploadPosTmp[i][3])
  shopLoadPos[i][2] = math.min(shoploadPosTmp[i][2], shoploadPosTmp[i][4])
  shopLoadPos[i][3] = math.max(shoploadPosTmp[i][1], shoploadPosTmp[i][3])
  shopLoadPos[i][4] = math.max(shoploadPosTmp[i][2], shoploadPosTmp[i][4])
  shopLoadPos[i][5] = shoploadPosTmp[i][5]
  shopLoadPos[i][6] = shoploadPosTmp[i][6]
  shopLoadPos[i][7] = shoploadPosTmp[i][7]
  shopLoadPos[i][8] = shoploadPosTmp[i][8]
  shopLoadPos[i][9] = shoploadPosTmp[i][9]
  shopLoadPos[i][10] = shoploadPosTmp[i][10]
  shopLoadPos[i][11] = shoploadPosTmp[i][11]
  shopLoadPos[i][12] = shoploadPosTmp[i][12]
  shopLoadPos[i][13] = shoploadPosTmp[i][13]
  shopLoadCol[i] = createColRectangle(shopLoadPos[i][1], shopLoadPos[i][2], shopLoadPos[i][3] - shopLoadPos[i][1], shopLoadPos[i][4] - shopLoadPos[i][2])
end
plantDetails = {
  kaposzta = {
    displayName = "Káposzta",
    growTime = 172800000,
    seeds = 403,
    yield = {
      [388] = 1
    },
    objects = {
      {
        model = "plants/Kaposzta/kaposzta",
        offset = {
          {
            0,
            0,
            0,
            0,
            0,
            0
          },
          {
            0,
            0,
            0,
            0,
            0,
            45
          },
          {
            0,
            0,
            0,
            0,
            0,
            90
          },
          {
            0,
            0,
            0,
            0,
            0,
            130
          },
          {
            0,
            0,
            0,
            0,
            0,
            180
          },
          {
            0,
            0,
            0,
            0,
            0,
            240
          }
        },
        grow = {0, 1},
        scale = {0, 0.8}
      }
    }
  },
  salata = {
    displayName = "Saláta",
    growTime = 172800000,
    seeds = 398,
    yield = {
      [383] = 1
    },
    objects = {
      {
        model = "plants/Salata/salata",
        offset = {
          {
            0,
            0,
            0,
            0,
            0,
            0
          },
          {
            0,
            0,
            0,
            0,
            0,
            45
          },
          {
            0,
            0,
            0,
            0,
            0,
            90
          },
          {
            0,
            0,
            0,
            0,
            0,
            130
          },
          {
            0,
            0,
            0,
            0,
            0,
            180
          },
          {
            0,
            0,
            0,
            0,
            0,
            240
          }
        },
        grow = {0, 1},
        scale = {0, 1}
      }
    }
  },
  karalabe = {
    displayName = "Karalábé",
    growTime = 172800000,
    seeds = 402,
    yield = {
      [387] = 1
    },
    objects = {
      {
        model = "plants/Karalabe/karalabe",
        offset = {
          {
            0,
            0,
            -0.1,
            0,
            0,
            0
          },
          {
            0,
            0,
            -0.1,
            0,
            0,
            45
          },
          {
            0,
            0,
            -0.1,
            0,
            0,
            90
          },
          {
            0,
            0,
            -0.1,
            0,
            0,
            130
          },
          {
            0,
            0,
            -0.1,
            0,
            0,
            180
          },
          {
            0,
            0,
            -0.1,
            0,
            0,
            240
          }
        },
        grow = {0, 1},
        scale = {0, 1.2}
      }
    }
  },
  lilahagyma = {
    displayName = "Lilahagyma",
    growTime = 172800000,
    seeds = 394,
    yield = {
      [379] = 1
    },
    objects = {
      {
        model = "plants/Lilahagyma/lilahagyma_szar",
        offset = {
          {
            0,
            0,
            -0.02,
            0,
            0,
            0
          },
          {
            0,
            0,
            -0.02,
            0,
            0,
            45
          },
          {
            0,
            0,
            -0.02,
            0,
            0,
            80
          },
          {
            0,
            0,
            -0.02,
            0,
            0,
            170
          },
          {
            0,
            0,
            -0.02,
            0,
            0,
            340
          }
        },
        grow = {0.1, 1},
        scale = {0, 1.1}
      },
      {
        model = "plants/Lilahagyma/lilahagyma_termes",
        offset = {
          {
            0,
            0,
            -0.02,
            0,
            0,
            0
          },
          {
            0,
            0,
            -0.02,
            0,
            0,
            45
          },
          {
            0,
            0,
            -0.02,
            0,
            0,
            80
          },
          {
            0,
            0,
            -0.02,
            0,
            0,
            170
          },
          {
            0,
            0,
            -0.02,
            0,
            0,
            340
          }
        },
        grow = {0, 1},
        scale = {0.5, 1.1}
      }
    }
  },
  voroshagyma = {
    displayName = "Vöröshagyma",
    growTime = 172800000,
    seeds = 393,
    yield = {
      [378] = 1
    },
    objects = {
      {
        model = "plants/Voroshagyma/voroshagyma_szar",
        offset = {
          {
            0,
            0,
            -0.02,
            0,
            0,
            0
          },
          {
            0,
            0,
            -0.02,
            0,
            0,
            45
          },
          {
            0,
            0,
            -0.02,
            0,
            0,
            80
          },
          {
            0,
            0,
            -0.02,
            0,
            0,
            170
          },
          {
            0,
            0,
            -0.02,
            0,
            0,
            340
          }
        },
        grow = {0.3, 1},
        scale = {0, 1.1}
      },
      {
        model = "plants/Voroshagyma/voroshagyma_termes",
        offset = {
          {
            0,
            0,
            -0.02,
            0,
            0,
            0
          },
          {
            0,
            0,
            -0.02,
            0,
            0,
            45
          },
          {
            0,
            0,
            -0.02,
            0,
            0,
            80
          },
          {
            0,
            0,
            -0.02,
            0,
            0,
            170
          },
          {
            0,
            0,
            -0.02,
            0,
            0,
            340
          }
        },
        grow = {0, 1},
        scale = {0.5, 1.1}
      }
    }
  },
  petrezselyem = {
    displayName = "Petrezselyem",
    growTime = 172800000,
    seeds = 401,
    yield = {
      [386] = 1
    },
    objects = {
      {
        model = "plants/Petrezselyem/petrezselyem_szar",
        offset = {
          {
            0,
            0,
            0.01,
            0,
            0,
            0
          },
          {
            0,
            0,
            0.01,
            0,
            0,
            45
          },
          {
            0,
            0,
            0.01,
            0,
            0,
            80
          },
          {
            0,
            0,
            0.01,
            0,
            0,
            170
          },
          {
            0,
            0,
            0.01,
            0,
            0,
            340
          }
        },
        grow = {0, 1},
        scale = {0, 1.5}
      },
      {
        model = "plants/Petrezselyem/petrezselyem_termes",
        offset = {
          {
            0,
            0,
            0.01,
            0,
            0,
            0
          },
          {
            0,
            0,
            0.01,
            0,
            0,
            45
          },
          {
            0,
            0,
            0.01,
            0,
            0,
            80
          },
          {
            0,
            0,
            0.01,
            0,
            0,
            170
          },
          {
            0,
            0,
            0.01,
            0,
            0,
            340
          }
        },
        grow = {0.3, 1},
        scale = {0, 1.5}
      }
    }
  },
  repa = {
    displayName = "Sárgarépa",
    growTime = 172800000,
    seeds = 400,
    yield = {
      [385] = 1
    },
    objects = {
      {
        model = "plants/Repa/repa_szar",
        offset = {
          {
            0,
            0,
            0.01,
            0,
            0,
            0
          },
          {
            0,
            0,
            0.01,
            0,
            0,
            45
          },
          {
            0,
            0,
            0.01,
            0,
            0,
            80
          },
          {
            0,
            0,
            0.01,
            0,
            0,
            170
          },
          {
            0,
            0,
            0.01,
            0,
            0,
            340
          }
        },
        grow = {0, 1},
        scale = {0, 1.5}
      },
      {
        model = "plants/Repa/repa_termes",
        offset = {
          {
            0,
            0,
            0.01,
            0,
            0,
            0
          },
          {
            0,
            0,
            0.01,
            0,
            0,
            45
          },
          {
            0,
            0,
            0.01,
            0,
            0,
            80
          },
          {
            0,
            0,
            0.01,
            0,
            0,
            170
          },
          {
            0,
            0,
            0.01,
            0,
            0,
            340
          }
        },
        grow = {0.3, 1},
        scale = {0, 1.3}
      }
    }
  },
  retek = {
    displayName = "Retek",
    growTime = 172800000,
    seeds = 399,
    yield = {
      [384] = 1
    },
    objects = {
      {
        model = "plants/Retek/retek_szar",
        offset = {
          {
            0,
            0,
            0.01,
            0,
            0,
            0
          },
          {
            0,
            0,
            0.01,
            0,
            0,
            45
          },
          {
            0,
            0,
            0.01,
            0,
            0,
            80
          },
          {
            0,
            0,
            0.01,
            0,
            0,
            170
          },
          {
            0,
            0,
            0.01,
            0,
            0,
            340
          }
        },
        grow = {0, 1},
        scale = {0, 1.3}
      },
      {
        model = "plants/Retek/retek_termes",
        offset = {
          {
            0,
            0,
            0.01,
            0,
            0,
            0
          },
          {
            0,
            0,
            0.01,
            0,
            0,
            45
          },
          {
            0,
            0,
            0.01,
            0,
            0,
            80
          },
          {
            0,
            0,
            0.01,
            0,
            0,
            170
          },
          {
            0,
            0,
            0.01,
            0,
            0,
            340
          }
        },
        grow = {0.3, 1},
        scale = {0, 1.2}
      }
    }
  },
  paprika_tv = {
    displayName = "TV paprika",
    growTime = 172800000,
    seeds = 390,
    yield = {
      [375] = 10
    },
    objects = {
      {
        model = "plants/Paprika/paprika_bokor",
        offset = {
          {
            0,
            0,
            0,
            0,
            0,
            0
          }
        },
        grow = {0, 0.6},
        scale = {0, 1}
      },
      {
        model = "plants/Paprika/paprika_tv",
        offset = {
          {
            0,
            0.25,
            0.65,
            0,
            0,
            270
          },
          {
            -0.05,
            -0.3,
            0.6,
            0,
            0,
            180
          }
        },
        grow = {0.6, 1},
        scale = {0, 1},
        green = true
      },
      {
        model = "plants/Paprika/paprika_tv",
        offset = {
          {
            0.12,
            -0.1,
            0.4,
            0,
            0,
            90
          },
          {
            -0.25,
            0,
            0.4,
            0,
            0,
            0
          }
        },
        grow = {0.6, 1},
        scale = {0, 1},
        green = true
      },
      {
        model = "plants/Paprika/paprika_tv",
        offset = {
          {
            -0.3,
            0,
            0.8,
            0,
            0,
            0
          },
          {
            0.25,
            0,
            0.7,
            0,
            0,
            180
          }
        },
        grow = {0.6, 1},
        scale = {0, 1},
        green = true
      }
    }
  },
  paprika_chili = {
    displayName = "Chilipaprika",
    growTime = 172800000,
    seeds = 392,
    yield = {
      [377] = 14
    },
    objects = {
      {
        model = "plants/Paprika/paprika_bokor",
        offset = {
          {
            0,
            0,
            0,
            0,
            0,
            0
          }
        },
        grow = {0, 0.6},
        scale = {0, 1}
      },
      {
        model = "plants/Paprika/paprika_chili",
        offset = {
          {
            0,
            0.25,
            0.65,
            0,
            0,
            270
          },
          {
            -0.05,
            -0.3,
            0.6,
            0,
            0,
            180
          }
        },
        grow = {0.6, 1},
        scale = {0, 1},
        green = true
      },
      {
        model = "plants/Paprika/paprika_chili",
        offset = {
          {
            0.12,
            -0.1,
            0.4,
            0,
            0,
            90
          },
          {
            -0.25,
            0,
            0.4,
            0,
            0,
            0
          }
        },
        grow = {0.6, 1},
        scale = {0, 1},
        green = true
      },
      {
        model = "plants/Paprika/paprika_chili",
        offset = {
          {
            -0.3,
            0,
            0.8,
            0,
            0,
            0
          },
          {
            0.25,
            0,
            0.7,
            0,
            0,
            180
          }
        },
        grow = {0.6, 1},
        scale = {0, 1},
        green = true
      }
    }
  },
  paprika_alma = {
    displayName = "Almapaprika",
    growTime = 172800000,
    seeds = 391,
    yield = {
      [376] = 10
    },
    objects = {
      {
        model = "plants/Paprika/paprika_bokor",
        offset = {
          {
            0,
            0,
            0,
            0,
            0,
            0
          }
        },
        grow = {0, 0.6},
        scale = {0, 1}
      },
      {
        model = "plants/Paprika/paprika_alma",
        offset = {
          {
            0,
            0.25,
            0.7,
            0,
            0,
            270
          },
          {
            -0.05,
            -0.3,
            0.65,
            0,
            0,
            180
          }
        },
        grow = {0.6, 1},
        scale = {0, 1},
        green = true
      },
      {
        model = "plants/Paprika/paprika_alma",
        offset = {
          {
            0.12,
            -0.1,
            0.45,
            0,
            0,
            90
          },
          {
            -0.25,
            0,
            0.45,
            0,
            0,
            0
          }
        },
        grow = {0.6, 1},
        scale = {0, 1},
        green = true
      },
      {
        model = "plants/Paprika/paprika_alma",
        offset = {
          {
            -0.3,
            0,
            0.85,
            0,
            0,
            0
          },
          {
            0.25,
            0,
            0.75,
            0,
            0,
            180
          }
        },
        grow = {0.6, 1},
        scale = {0, 1},
        green = true
      }
    }
  },
  gorogdinnye = {
    displayName = "Görögdinnye",
    growTime = 172800000,
    seeds = 397,
    yield = {
      [382] = 3
    },
    objects = {
      {
        model = "plants/Dinnyek/palanta",
        offset = {
          {
            -0.125,
            0,
            0,
            0,
            0,
            45
          }
        },
        grow = {0, 0.6},
        scale = {0, 1},
        green = true
      },
      {
        model = "plants/Dinnyek/gorogdinnye",
        offset = {
          {
            -0.125,
            0.25,
            0.125,
            0,
            0,
            45
          },
          {
            -0.175,
            0.25,
            0.125,
            0,
            0,
            225
          },
          {
            -0.325,
            0.1,
            0.125,
            0,
            0,
            225
          }
        },
        grow = {0.6, 1},
        scale = {0, 1},
        green = true
      },
      {
        model = "plants/Dinnyek/gorogdinnye",
        offset = {
          {
            0.125,
            -0.1,
            0.125,
            0,
            0,
            30
          },
          {
            0.275,
            -0.2,
            0.125,
            0,
            0,
            210
          }
        },
        grow = {0.6, 1},
        scale = {0, 1},
        green = true
      }
    }
  },
  sargadinnye = {
    displayName = "Sárgadinnye",
    growTime = 172800000,
    seeds = 396,
    yield = {
      [381] = 3
    },
    objects = {
      {
        model = "plants/Dinnyek/palanta",
        offset = {
          {
            -0.125,
            0,
            0,
            0,
            0,
            45
          }
        },
        grow = {0, 0.6},
        scale = {0, 1}
      },
      {
        model = "plants/Dinnyek/sargadinnye",
        offset = {
          {
            -0.125,
            0.25,
            0.125,
            0,
            0,
            45
          },
          {
            -0.175,
            0.25,
            0.125,
            0,
            0,
            225
          },
          {
            -0.275,
            0.1,
            0.125,
            0,
            0,
            225
          }
        },
        grow = {0.6, 1},
        scale = {0, 1.5},
        green = true
      },
      {
        model = "plants/Dinnyek/sargadinnye",
        offset = {
          {
            0.15000000000000002,
            -0.1,
            0.125,
            0,
            0,
            30
          },
          {
            0.375,
            -0.15,
            0.125,
            0,
            0,
            210
          },
          {
            0.024999999999999994,
            -0.25,
            0.125,
            0,
            0,
            210
          }
        },
        grow = {0.6, 1},
        scale = {0, 1.2},
        green = true
      }
    }
  },
  uborka = {
    displayName = "Uborka",
    growTime = 172800000,
    seeds = 404,
    yield = {
      [389] = 8
    },
    objects = {
      {
        model = "plants/Uborka/iborka_szar",
        offset = {
          {
            0,
            0,
            0,
            0,
            0,
            0
          }
        },
        grow = {0, 0.6},
        scale = {0, 1}
      },
      {
        model = "plants/Uborka/iborka_termes",
        offset = {
          {
            0,
            0,
            0.025,
            90,
            0,
            45
          },
          {
            -0.12,
            0.25,
            0.025,
            90,
            0,
            225
          }
        },
        grow = {0.6, 1},
        scale = {0, 2}
      },
      {
        model = "plants/Uborka/iborka_termes",
        offset = {
          {
            -0.2,
            -0.4,
            0.025,
            90,
            0,
            90
          },
          {
            -0.1,
            -0.4,
            0.025,
            90,
            0,
            270
          }
        },
        grow = {0.6, 1},
        scale = {0, 2}
      },
      {
        model = "plants/Uborka/iborka_termes",
        offset = {
          {
            0.15,
            0,
            0.025,
            90,
            0,
            -45
          },
          {
            0.2,
            -0.15,
            0.025,
            90,
            0,
            -45
          }
        },
        grow = {0.6, 1},
        scale = {0, 2}
      }
    }
  },
  sutotok = {
    displayName = "Sütőtök",
    growTime = 172800000,
    seeds = 395,
    yield = {
      [380] = 3
    },
    objects = {
      {
        model = "plants/Tokok/palanta",
        offset = {
          {
            0,
            0,
            0,
            0,
            0,
            25
          }
        },
        grow = {0, 0.6},
        scale = {0, 1}
      },
      {
        model = "plants/Tokok/sutotok",
        offset = {
          {
            0.1,
            0,
            0.05,
            90,
            0,
            -45
          },
          {
            0.1,
            0,
            0.05,
            90,
            0,
            45
          },
          {
            0.1,
            0,
            0.05,
            90,
            0,
            135
          }
        },
        grow = {0.6, 1},
        scale = {0, 1.25}
      },
      {
        model = "plants/Tokok/sutotok",
        offset = {
          {
            0.2,
            -0.4,
            0.05,
            90,
            0,
            -45
          },
          {
            0.2,
            -0.4,
            0.05,
            90,
            0,
            225
          },
          {
            0.2,
            -0.4,
            0.05,
            90,
            0,
            135
          }
        },
        grow = {0.6, 1},
        scale = {0, 1.25}
      },
      {
        model = "plants/Tokok/sutotok",
        offset = {
          {
            0.07,
            0.45,
            0.05,
            90,
            0,
            90
          },
          {
            0.07,
            0.45,
            0.05,
            90,
            0,
            45
          }
        },
        grow = {0.6, 1},
        scale = {0, 1.25}
      }
    }
  },
  marihuana = {
    displayName = "Kender",
    growTime = 172800000,
    seeds = 57,
    cantSell = true,
    yield = {
      [13] = {1, 3},
      seeds = {
        0,
        1,
        1,
        1,
        2
      }
    },
    SHTG = true,
    objects = {
      {
        model = "marihuana",
        offset = {
          {
            0,
            0,
            0,
            0,
            0,
            0
          },
          {
            0,
            0,
            0,
            0,
            0,
            45
          },
          {
            0,
            0,
            0,
            0,
            0,
            90
          },
          {
            0,
            0,
            0,
            0,
            0,
            135
          },
          {
            0,
            0,
            0,
            0,
            0,
            180
          },
          {
            0,
            0,
            0,
            0,
            0,
            270
          }
        },
        grow = {0, 1},
        scale = {0, 1}
      }
    }
  },
  kokacserje = {
    displayName = "Kokacserje",
    growTime = 172800000,
    seeds = 11,
    cantSell = true,
    yield = {
      [14] = {1, 3},
      seeds = {
        0,
        1,
        1,
        1,
        2
      }
    },
    SHTG = true,
    objects = {
      {
        model = "kokacserje",
        offset = {
          {
            0,
            0,
            -0.075,
            0,
            0,
            0
          },
          {
            0,
            0,
            -0.075,
            0,
            0,
            45
          },
          {
            0,
            0,
            -0.075,
            0,
            0,
            90
          },
          {
            0,
            0,
            -0.075,
            0,
            0,
            135
          },
          {
            0,
            0,
            -0.075,
            0,
            0,
            180
          },
          {
            0,
            0,
            -0.075,
            0,
            0,
            270
          }
        },
        grow = {0, 1},
        scale = {0, 0.75}
      }
    }
  },
  mushroom = {
    displayName = "Gomba",
    growTime = 172800000,
    seeds = 448,
    cantSell = true,
    yield = {
      [451] = {1, 6},
      seeds = {
        0,
        1,
        1,
        1,
        2
      }
    },
    SHTG = true,
    objects = {
      {
        model = "magic_mushroom",
        offset = {
          {
            0.3064,
            -0.3871,
            -0.0078,
            28.5679,
            18.8259,
            32.242
          },
          {
            0.1372,
            -0.4367,
            -0.0166,
            -14.8556,
            -10.9726,
            349.1799
          },
          {
            0.375,
            -0.2531,
            -0.0166,
            -15.7121,
            19.2524,
            184.2644
          },
          {
            0.1805,
            -0.1849,
            -0.0166,
            -15.7121,
            19.2524,
            222.8519
          },
          {
            0.2998,
            -0.1489,
            -0.0335,
            -13.685,
            -20.9896,
            325.1887
          }
        },
        grow = {0, 1},
        scale = {0, 1}
      },
      {
        model = "magic_mushroom",
        offset = {
          {
            -0.1406,
            -0.3545,
            -0.0184,
            -39.6465,
            -5.0453,
            256.4993
          },
          {
            -0.0179,
            -0.2749,
            -0.0184,
            -39.6465,
            -5.0453,
            359.6268
          },
          {
            -0.201,
            -0.3907,
            -0.0038,
            -15.196,
            -13.0282,
            459.2374
          },
          {
            -0.2282,
            -0.2438,
            -0.0335,
            -8.6052,
            -9.7252,
            251.3665
          },
          {
            -0.0681,
            -0.0983,
            -0.0184,
            -39.6465,
            -5.0453,
            423.7692
          }
        },
        grow = {0, 1},
        scale = {0, 1}
      },
      {
        model = "magic_mushroom",
        offset = {
          {
            -0.4003,
            -0.321,
            -0.0078,
            28.5679,
            18.8259,
            -40.8865
          },
          {
            -0.3249,
            -0.1975,
            -0.0166,
            -15.7121,
            19.2524,
            149.7234
          },
          {
            -0.2673,
            -0.0867,
            -0.0078,
            28.5679,
            18.8259,
            193.8395
          }
        },
        grow = {0, 1},
        scale = {0, 1}
      },
      {
        model = "magic_mushroom",
        offset = {
          {
            0.3387,
            -0.0137,
            -0.0056,
            -20.3943,
            7.593,
            329.7009
          },
          {
            0.4309,
            0.1712,
            -0.0166,
            -15.7121,
            19.2524,
            154.3409
          },
          {
            0.1305,
            0.0755,
            -0.0184,
            -39.6465,
            -5.0453,
            256.4993
          },
          {
            0.0333,
            -0.039,
            0,
            0,
            0,
            39.5272
          },
          {
            -0.0212,
            0.096,
            -0.0166,
            -14.8556,
            -10.9726,
            448.3943
          }
        },
        grow = {0, 1},
        scale = {0, 1}
      },
      {
        model = "magic_mushroom",
        offset = {
          {
            0.3886,
            0.2927,
            -0.0078,
            28.5679,
            18.8259,
            137.6927
          },
          {
            0.1912,
            0.3674,
            -0.0038,
            -15.196,
            -13.0282,
            637.8165
          },
          {
            0.1582,
            0.2532,
            -0.0166,
            -15.7121,
            19.2524,
            178.8421
          },
          {
            -0.047,
            0.3423,
            -0.0184,
            -39.6465,
            -5.0453,
            315.617
          }
        },
        grow = {0, 1},
        scale = {0, 1}
      },
      {
        model = "magic_mushroom",
        offset = {
          {
            -0.2598,
            0.1122,
            -0.0082,
            9.6624,
            -21.0753,
            476.42
          },
          {
            -0.3931,
            0.1973,
            -0.0166,
            -15.7121,
            19.2524,
            258.0635
          },
          {
            -0.1822,
            0.254,
            -0.0078,
            8.5036,
            23.2795,
            9.6045
          },
          {
            -0.1384,
            0.3705,
            -0.0061,
            14.6439,
            21.482,
            189.0199
          },
          {
            -0.4003,
            0.4365,
            -0.0078,
            28.5679,
            18.8259,
            -40.8865
          }
        },
        grow = {0, 1},
        scale = {0, 1}
      }
    }
  },
  parazen = {
    displayName = "Parazen",
    growTime = 172800000,
    seeds = 428,
    yield = {
      [432] = {1, 3},
      seeds = {
        0,
        0,
        0,
        1,
        1,
        0,
        0,
        0,
        2
      }
    },
    SHTG = true,
    objects = {
      {
        model = "plants/parazen/szar",
        offset = {
          {
            0,
            0,
            -0.1,
            0,
            0,
            0
          }
        },
        grow = {0, 0.85},
        scale = {0, 1}
      },
      {
        model = "plants/parazen/virag",
        offset = {
          {
            0.216,
            0.359,
            1.035,
            0,
            0,
            0
          },
          {
            0.157,
            -0.111,
            1.107,
            0,
            0,
            0
          }
        },
        grow = {0.85, 1},
        scale = {0, 1}
      },
      {
        model = "plants/parazen/virag",
        offset = {
          {
            0.098,
            -0.042,
            0.539,
            0,
            5.275,
            0
          },
          {
            -0.18,
            0.236,
            1.1509999999999998,
            0,
            0,
            0
          }
        },
        grow = {0.85, 1},
        scale = {0, 1}
      },
      {
        model = "plants/parazen/virag",
        offset = {
          {
            -0.178,
            0.006,
            1.2229999999999999,
            4.637,
            0,
            0
          },
          {
            0.224,
            -0.537,
            1.263,
            -8.034,
            -9.436,
            1.326
          }
        },
        grow = {0.85, 1},
        scale = {0, 1}
      },
      {
        model = "plants/parazen/virag",
        offset = {
          {
            -0.178,
            0.006,
            1.2229999999999999,
            4.637,
            0,
            0
          },
          {
            -0.575,
            0.204,
            1.053,
            0,
            11.037,
            0
          }
        },
        grow = {0.85, 1},
        scale = {0, 1}
      }
    }
  }
}
pricePerPCS = {}
crateItems = {}
local mainPrice = 2000
for k, v in pairs(plantDetails) do
  if v.yield then
    for k2, v2 in pairs(v.yield) do
      if tonumber(k2) then
        crateItems[tonumber(k2)] = true
        if not v.cantSell then
          local num = tonumber(v2)
          if not num then
            if #v2 == 2 then
              num = v2[1] + (v2[2] - v2[1]) / 2
            else
              for k = 1, #v2 do
                num = num + v2[k]
              end
              num = num / #v2
            end
          end
          pricePerPCS[tonumber(k2)] = math.ceil(mainPrice / num)
        end
      end
    end
  end
end
pricePerPCS[587] = 1220
pricePerPCS[588] = 4300
pricePerPCS[585] = 17500
function round(num, numDecimalPlaces)
  local mult = 10 ^ (numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end
plantsTable = {}
for k in pairs(plantDetails) do
  table.insert(plantsTable, k)
end
farmSizes = {small = 1}
textureSize = 128
farmPermissionGroups = {
  [1] = {
    "Farm nyitás/zárás",
    {"lock"}
  },
  [2] = {
    "Szerszámhasználat",
    {"usetools"}
  },
  [3] = {
    "Földművelés",
    {
      "cultivate",
      "dighole",
      "fillHole",
      "water"
    }
  },
  [4] = {
    "Növény ültetés",
    {"plant"}
  },
  [5] = {
    "Növény betakarítás",
    {"harvest"}
  },
  [6] = {
    "Láda mozgatás",
    {"movecrate"}
  },
  [7] = {
    "Állatgondozás",
    {
      "removedirt",
      "placehay",
      "placemanure",
      "feedanimals"
    }
  },
  [8] = {
    "Fejés, tojásgyűjtés, birkanyírás",
    {"milkeggs"}
  },
  [9] = {
    "Nagyker vásárlás",
    {"buyanimals"}
  },
  [10] = {
    "Állat eladás",
    {
      "sellanimals"
    }
  }
}
permissionsByType = {
  [1] = {
    1,
    2,
    3,
    4,
    5,
    6
  },
  [2] = {
    1,
    2,
    7,
    8,
    9,
    10
  }
}
farmPermissionGroupsEx = {}
for group, v in pairs(farmPermissionGroups) do
  for k, permission in pairs(v[2]) do
    farmPermissionGroupsEx[permission] = group
  end
end
function map(x, in_min, in_max, out_min, out_max)
  if x < in_min then
    x = in_min
  end
  if in_max < x then
    x = in_max
  end
  return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min
end
growRate = 1
textureRefreshInterval = 10000
dirtFactor = 0.135 * growRate
dryFactor = 0.1 * growRate
dryFactorPlanted = 0.135 * growRate
whenRot = 75
whenTooDirty = 140.25
rottenStart = 1.55
rottenEnd = 1.75
function initPlantData(plantType)
  return {
    type = plantType,
    startRotten = 0,
    rotten = 0,
    growth = 0,
    elasped = 0,
    growRate = growRate,
    startTime = 0
  }
end
function rotateAround(deg, pointX, pointY, centerX, centerY)
  local angle = math.rad(deg)
  local drawX = centerX + (pointX - centerX) * math.cos(angle) - (pointY - centerY) * math.sin(angle)
  local drawY = centerY + (pointX - centerX) * math.sin(angle) + (pointY - centerY) * math.cos(angle)
  return drawX, drawY
end
function calculatePlant(plantData)
  local elasped = getTickCount() - plantData.startTime
  plantData.elasped = elasped
  if plantData.rotten < 0.25 or plantData.growth > 1 then
    plantData.growth = elasped / plantDetails[plantData.type].growTime * plantData.growRate
  end
  local growthRot = map(plantData.growth, rottenStart, rottenEnd, 0, 1)
  local rot = 0
  if elasped > plantData.startRotten then
    local calculated = (elasped - plantData.startRotten) / (whenRot / dryFactorPlanted * 60 * 1000)
    rot = math.min(1, calculated)
  end
  plantData.rotten = math.max(plantData.rotten, rot, growthRot)
end
function initLandData(theType)
  if theType == 2 then
    return {hay = false, dirt = 0}
  else
    return {
      landState = false,
      currentDryFactor = dryFactor * math.random(90, 110) / 100,
      fromWetness = 0,
      wetness = 0,
      lastWatering = -1,
      objects = {},
      plant = false
    }
  end
end
function landDataFromJson(landData, data, theType)
  local data = fromJSON(data)
  if not data.hay then
    data.hay = {}
  end
  if not data.dirt then
    data.dirt = {}
  end
  if not data.wetness then
    data.wetness = {}
  end
  if not data.plant then
    data.plant = {}
  end
  if not data.landState then
    data.landState = {}
  end
  if theType == 2 then
    for k, v in pairs(data.hay) do
      local c = split(k, ",")
      local x, y = tonumber(c[1]), tonumber(c[2])
      landData[x][y].hay = tonumber(v) == 1
    end
    for k, v in pairs(data.dirt) do
      local c = split(k, ",")
      local x, y = tonumber(c[1]), tonumber(c[2])
      landData[x][y].dirt = tonumber(v)
    end
  elseif theType == 1 then
    for k, v in pairs(data.wetness) do
      local c = split(k, ",")
      local x, y = tonumber(c[1]), tonumber(c[2])
      landData[x][y].wetness = tonumber(v[1])
      landData[x][y].fromWetness = tonumber(v[1])
      landData[x][y].lastWatering = getTickCount()
      landData[x][y].currentDryFactor = tonumber(v[2])
    end
    for k, v in pairs(data.plant) do
      local c = split(k, ",")
      local x, y = tonumber(c[1]), tonumber(c[2])
      if plantDetails[v.type] then
        landData[x][y].plant = initPlantData(v.type)
        landData[x][y].plant.rotten = tonumber(v.rotten)
        landData[x][y].plant.growRate = tonumber(v.growRate)
        landData[x][y].plant.growth = tonumber(v.growth)
        landData[x][y].plant.elasped = tonumber(v.elasped)
        landData[x][y].plant.startTime = getTickCount() - tonumber(v.elasped)
        landData[x][y].plant.boosted = tonumber(v.boosted) == 1
        landData[x][y].plant.startRotten = getTickCount() - landData[x][y].plant.startTime + (landData[x][y].wetness - whenRot) / dryFactorPlanted * 60 * 1000
      end
    end
    for k, v in pairs(data.landState) do
      local c = split(k, ",")
      local x, y = tonumber(c[1]), tonumber(c[2])
      if v:find("c") then
        local dat = split(v, ":")
        landData[x][y].landState = "cultivated:" .. (dat[2] or 255)
      elseif v == "p" then
        if not landData[x][y].plant then
          landData[x][y].landState = "hole"
        else
          landData[x][y].landState = "planted"
        end
      elseif v == "h" then
        landData[x][y].landState = "hole"
      end
    end
  end
end
function landDataToJson(land, theType)
  local data = {}
  if theType == 2 then
    data.hay = {}
    data.dirt = {}
  else
    data.wetness = {}
    data.landState = {}
    data.plant = {}
  end
  for x in pairs(land) do
    for y in pairs(land[x]) do
      if theType == 2 then
        if 0 < (land[x][y].dirt or 0) then
          data.dirt[x .. "," .. y] = land[x][y].dirt
        end
        if land[x][y].hay then
          data.hay[x .. "," .. y] = 1
        end
      else
        land[x][y].wetness = calculateWetness(land[x][y])
        if land[x][y].wetness > 0 then
          data.wetness[x .. "," .. y] = {
            land[x][y].wetness,
            land[x][y].currentDryFactor
          }
        end
        if land[x][y].landState then
          data.landState[x .. "," .. y] = utf8.sub(land[x][y].landState, 1, 1)
          if land[x][y].landState:find("cultivated") then
            local dat = split(land[x][y].landState, ":")
            data.landState[x .. "," .. y] = data.landState[x .. "," .. y] .. ":" .. (dat[2] or 255)
          end
        end
        if land[x][y].plant then
          local plantData = land[x][y].plant
          calculatePlant(plantData)
          data.plant[x .. "," .. y] = {
            type = plantData.type,
            rotten = plantData.rotten,
            growRate = plantData.growRate,
            growth = plantData.growth,
            elasped = plantData.elasped,
            boosted = plantData.boosted and 1 or 0
          }
        end
      end
    end
  end
  return toJSON(data, true)
end
balePrice = 100
otherFoodPrice = 1500
chickenFoodPrice = 3000
foodBagNum = 8
baleNum = 5
farmSizeDetails = {
  [farmSizes.small] = {
    modelid = "inti_kicsi",
    size = {5, 10},
    lineOffset = {
      0,
      0,
      0.92
    },
    offset = {
      0,
      -9.25,
      -1.5
    },
    insideMarkerOffset = {
      0,
      -2,
      0.5
    },
    hoeOffset = {
      2.44,
      -2.275,
      0.9,
      0
    },
    miniHoeOffset = {
      2.45,
      -2.85,
      1,
      180
    },
    forkOffset = {
      -2.44433,
      -5.87233,
      2.28713,
      -12.8735,
      0,
      0
    },
    crateOffset = {
      1.75,
      -2.15,
      -0.25,
      -5
    },
    bucketOffset = {
      -0.477643,
      5.44131,
      1.49262
    },
    furikOffset = {
      -1.81053,
      -3.92979,
      1.16605,
      -99,
      90
    },
    panelOffset = {
      2,
      -7.26,
      2
    }
  },
  animal = {
    modelid = "animalfarm",
    size = {5, 10},
    lineOffset = {
      0,
      0,
      0.92
    },
    offset = {
      0,
      -9.25,
      -1.5
    },
    insideMarkerOffset = {
      0,
      -2,
      0.5
    },
    hoeOffset = {
      2.44,
      -2.275,
      0.9,
      0
    },
    miniHoeOffset = {
      2.45,
      -2.85,
      1,
      180
    },
    forkOffset = {
      -2.44433,
      -5.87233,
      2.28713,
      -12.8735,
      0,
      0
    },
    crateOffset = {
      1.75,
      -2.15,
      -0.25,
      -5
    },
    bucketOffset = {
      -0.477643,
      5.44131,
      1.49262
    },
    furikOffset = {
      -1.81053,
      -3.92979,
      1.16605,
      -99,
      90
    },
    panelOffset = {
      -0.182188,
      -5.1447,
      2.15661
    }
  }
}
animalTrailerPoses = {
  cow = {
    [0] = {
      {
        0,
        0,
        1,
        125
      },
      {
        0,
        1,
        1,
        45
      }
    },
    [1] = {
      {
        0,
        0.25,
        1,
        170
      }
    }
  },
  pig = {
    [0] = {
      {
        -0.35,
        -0.75,
        1,
        56
      },
      {
        0.45,
        -0.6,
        1,
        135
      },
      {
        -0.25,
        0.15,
        1,
        40
      },
      {
        0.35,
        0,
        1,
        135
      },
      {
        -0.4,
        1,
        1,
        52
      },
      {
        0.35,
        0.9,
        1,
        48
      }
    },
    [1] = {
      {
        0.575,
        -0.3,
        1,
        130
      },
      {
        0.45,
        1,
        1,
        140
      }
    }
  },
  goat = {
    [0] = {
      {
        -0.35,
        -0.65,
        1,
        26
      },
      {
        -0.45,
        0.2,
        1,
        190
      },
      {
        0.25,
        0.25,
        1,
        125
      },
      {
        0.35,
        1.2,
        1,
        45
      }
    },
    [1] = {
      {
        0.05,
        0.3,
        1,
        100
      },
      {
        0.15,
        -0.4,
        1,
        105
      },
      {
        0.1,
        1,
        1,
        110
      }
    }
  },
  chicken = {
    [0] = {
      {
        -0.215,
        1.125,
        1,
        49
      },
      {
        -0.125,
        0.65,
        1,
        95
      },
      {
        0.625,
        0.75,
        1,
        125
      },
      {
        0.55,
        1.525,
        1,
        55
      },
      {
        0.125,
        -0.25,
        1,
        123
      },
      {
        0.645,
        -0.5,
        1,
        45
      },
      {
        -0.665,
        0.85,
        1,
        26
      },
      {
        0.545,
        0.15,
        1,
        126
      },
      {
        -0.615,
        0,
        1,
        51
      },
      {
        -0.65,
        -0.5,
        1,
        180
      }
    },
    [1] = {
      {
        0.525,
        0.75,
        1,
        220
      },
      {
        -0.415,
        1.125,
        1,
        31
      },
      {
        0.545,
        -0.5,
        1,
        22
      },
      {
        -0.35,
        -0.25,
        1,
        124
      },
      {
        0.45,
        1.525,
        1,
        41
      },
      {
        -0.225,
        0.65,
        1,
        120
      },
      {
        0.445,
        0.15,
        1,
        251
      }
    }
  },
  sheep = {
    [0] = {
      {
        -0.35,
        -0.45,
        1,
        26
      },
      {
        -0.45,
        0.45,
        1,
        190
      },
      {
        0.25,
        0.25,
        1,
        125
      },
      {
        0.35,
        1.2,
        1,
        45
      }
    },
    [1] = {
      {
        0.05,
        0.3,
        1,
        100
      },
      {
        0.15,
        -0.4,
        1,
        105
      },
      {
        0.1,
        1,
        1,
        110
      }
    }
  }
}
function rateFromHour(h)
  return 1 / h / 60 * 100
  --return 1 / 0.01 / 60 * 100
end
animalTypes = {
  cow = {
    name = "Tehén",
    size = {0.65, 1.1},
    morph = {-0.0055, 0.005},
    growthRate = rateFromHour(144),
    healthRate = rateFromHour(24),
    fatRate = rateFromHour(24),
    moodRate = rateFromHour(12),
    dirtRate = 2.95,
    waterConsumption = 5.9,
    foodConsumption = 5.9,
    farmSlot = 28,
    variations = {2, 5},
    lifeExpectancy = 3.75,
    moveRange = {
      -farmSizeDetails.animal.size[1] / 2 + 1.5,
      -farmSizeDetails.animal.size[2] / 2 + 1,
      farmSizeDetails.animal.size[1] / 2 - 1.5,
      farmSizeDetails.animal.size[2] / 2 - 2
    },
    milking = rateFromHour(24),
    basePrice = 20000,
    sellPrice = 122500
  },
  pig = {
    name = "Sertés",
    size = {0.5, 1.1},
    morph = {-0.0055, 0.005},
    growthRate = rateFromHour(120),
    healthRate = rateFromHour(24),
    fatRate = rateFromHour(24),
    moodRate = rateFromHour(12),
    dirtRate = 1.475,
    waterConsumption = 2.95,
    foodConsumption = 2.95,
    farmSlot = 15,
    variations = {1, 4},
    lifeExpectancy = 4,
    moveRange = {
      -farmSizeDetails.animal.size[1] / 2 + 1.5,
      -farmSizeDetails.animal.size[2] / 2 + 1.5,
      farmSizeDetails.animal.size[1] / 2 - 1.5,
      farmSizeDetails.animal.size[2] / 2 - 1.5
    },
    basePrice = 8000,
    sellPrice = 51000
  },
  goat = {
    name = "Kecske",
    size = {0.65, 1},
    morph = {-0.0065, 0.0025},
    growthRate = rateFromHour(96),
    healthRate = rateFromHour(24),
    fatRate = rateFromHour(24),
    moodRate = rateFromHour(12),
    dirtRate = 1.105,
    waterConsumption = 2.21,
    foodConsumption = 2.21,
    farmSlot = 12,
    variations = {1, 3},
    lifeExpectancy = 4.75,
    moveRange = {
      -farmSizeDetails.animal.size[1] / 2 + 1.25,
      -farmSizeDetails.animal.size[2] / 2 + 1.5,
      farmSizeDetails.animal.size[1] / 2 - 1.25,
      farmSizeDetails.animal.size[2] / 2 - 1.25
    },
    basePrice = 5000,
    sellPrice = 30500
  },
  chicken = {
    name = "Tyúk",
    size = {0.35, 0.575},
    morph = {-0.0075, 0.0075},
    growthRate = rateFromHour(72),
    healthRate = rateFromHour(24),
    fatRate = rateFromHour(24),
    moodRate = rateFromHour(12),
    dirtRate = 0.2675,
    waterConsumption = 0.535,
    foodConsumption = 0.535,
    farmSlot = 3,
    variations = {1, 6},
    lifeExpectancy = 6,
    moveRange = {
      -farmSizeDetails.animal.size[1] / 2 + 1,
      -farmSizeDetails.animal.size[2] / 2 + 0.5,
      farmSizeDetails.animal.size[1] / 2 - 1.5,
      farmSizeDetails.animal.size[2] / 2 - 1
    },
    eggLaying = rateFromHour(18),
    basePrice = 800,
    sellPrice = 5500
  },
  sheep = {
    name = "Bárány",
    size = {0.65, 1},
    morph = {-0.0065, 0.0025},
    growthRate = rateFromHour(96),
    healthRate = rateFromHour(24),
    fatRate = rateFromHour(24),
    moodRate = rateFromHour(12),
    dirtRate = 1.105,
    waterConsumption = 2.21,
    foodConsumption = 2.21,
    farmSlot = 12,
    variations = {1, 4},
    lifeExpectancy = 4.75,
    moveRange = {
      -farmSizeDetails.animal.size[1] / 2 + 1.25,
      -farmSizeDetails.animal.size[2] / 2 + 1.5,
      farmSizeDetails.animal.size[1] / 2 - 1.25,
      farmSizeDetails.animal.size[2] / 2 - 1.25
    },
    basePrice = 5000,
    sellPrice = 30500,
    shearing = rateFromHour(24)
  }
}
animalCratePositions = {
  {
    1.95541,
    -3.61681,
    1.0587,
    0,
    0,
    85.54
  },
  {
    1.66453,
    -4.50405,
    1.0587,
    0,
    0,
    -3.5304
  },
  {
    0.648197,
    -4.48818,
    1.0587,
    0,
    0,
    4.904
  },
  {
    -0.429879,
    -4.48314,
    1.0587,
    0,
    0,
    -6.7177
  }
}
eggCratePositions = {
  {
    {
      2.01568,
      -3.5249,
      0.9821,
      -53.8,
      0,
      -56.12
    },
    {
      2.00877,
      -3.64845,
      0.970372,
      -89.33,
      -8.17,
      88.7
    },
    {
      1.95618,
      -3.73947,
      0.982871,
      -82.7,
      -9.7,
      2020
    },
    {
      1.90844,
      -3.60472,
      0.976359,
      -173,
      -67.36,
      125
    }
  },
  {
    {
      1.74065,
      -4.482,
      0.970372,
      -53.82,
      0,
      -43.43
    },
    {
      1.65295,
      -4.52628,
      0.970372,
      -89.33,
      -8.17,
      13.65
    },
    {
      1.64262,
      -4.42439,
      0.976359,
      -53.82,
      0,
      -43.43
    },
    {
      1.5607,
      -4.49571,
      0.970372,
      -82.715,
      -9.7,
      53.57
    }
  },
  {
    {
      0.738243,
      -4.43819,
      0.970372,
      -45.97,
      -24.76,
      -58.65
    },
    {
      0.670943,
      -4.51904,
      0.970372,
      -119.77,
      -65.94,
      -93.98
    },
    {
      0.584367,
      -4.43819,
      0.970372,
      -61.29,
      -14.98,
      11.69
    }
  },
  {
    {
      -0.377268,
      -4.52821,
      0.970372,
      359.49,
      -58.97,
      -241
    },
    {
      -0.417453,
      -4.44737,
      0.970372,
      339.1,
      -35.07,
      -71.359
    },
    {
      -0.522229,
      -4.47316,
      0.970372,
      -61.29,
      -14.98,
      69.827
    }
  }
}
function processFeeding(animalData, land, hay, shit, chick, delta, sumConsumptionFood, sumConsumptionWater)
  if 0 < sumConsumptionFood and 0 < sumConsumptionWater then
    local timeForFood = animalData.food[(chick and "chicken" or "other") .. "Food"] / sumConsumptionFood
    local timeForWater = animalData.food[(chick and "chicken" or "other") .. "Water"] / sumConsumptionWater
    local timeWithoutFood = math.min(timeForFood, timeForWater)
    local time = math.min(delta, timeWithoutFood)
    local timeWater = math.min(delta, timeForWater)
    local timeFood = math.min(delta, timeForFood)
    local timeForHealth = timeWithoutFood - delta
    local timeForFat = math.min(math.min(delta, timeForFood), timeForFood - delta)
    animalData.food[(chick and "chicken" or "other") .. "Food"] = math.max(0, animalData.food[(chick and "chicken" or "other") .. "Food"] - sumConsumptionFood * timeFood)
    animalData.food[(chick and "chicken" or "other") .. "Water"] = math.max(0, animalData.food[(chick and "chicken" or "other") .. "Water"] - sumConsumptionWater * timeWater)
    local hayMood = hay * 2 - 1
    local shitValue = 0
    for i = 1, #animalData.animals do
      local bool = false
      if chick then
        bool = animalData.animals[i].type == "chicken"
      else
        bool = animalData.animals[i].type ~= "chicken"
      end
      if bool then
        local plus = animalData.animals[i].growthRate * timeForFat / 100
        if 0 < plus then
          shitValue = shitValue + plus * animalTypes[animalData.animals[i].type].dirtRate * ((4 + 2 * (1 - hay)) / 4)
        end
      end
    end
    if 0 < shitValue then
      local shitSum = 0
      local count = 0
      for x in pairs(land) do
        for y in pairs(land[x]) do
          local new = (land[x][y].dirt or 0) + shitValue * math.random(90, 110) / 100
          land[x][y].dirt = math.min(255, new)
          shitSum = shitSum + land[x][y].dirt
          count = count + 1
        end
      end
      shit = (shit + shitSum / count / 255) / 2
    end
    local shitMood = 1 - shit * 2
    if 0.5 < shit then
      shit = (shit - 0.5) / 0.5
    else
      shit = 0
    end
    local hayDelta = delta
    if hayMood <= 0 then
      local lastHayUpdate = (animalData.lastHayUpdate or 0) + 900000
      local hayDelta = (getTickCount() - lastHayUpdate) / 60000
      if hayDelta < 0 then
        hayDelta = 0
      end
    end
    hayMood = hayMood * math.min(hayDelta, delta)
    shitMood = shitMood * delta
    local eggPlus = 0
    for i = #animalData.animals, 1, -1 do
      local bool = false
      if chick then
        bool = animalData.animals[i].type == "chicken"
      else
        bool = animalData.animals[i].type ~= "chicken"
      end
      if bool and not animalData.animals[i].forSale then
        local gRate = animalData.animals[i].growthRate * animalTypes[animalData.animals[i].type].growthRate * (0.9 + hay * 0.1)
        local new = animalData.animals[i].growth + gRate * time / 100
        animalData.animals[i].growth = math.min(1, new)
        if animalTypes[animalData.animals[i].type].shearing then
          local timeToAdult = (1 - animalData.animals[i].growth) / (gRate / 100)
          if 0 < time then
            local shearTime = time - timeToAdult
            if 0 < shearTime and 1 > (animalData.animals[i].wool or 0) then
              local shearing = animalTypes[animalData.animals[i].type].shearing / 100
              animalData.animals[i].wool = math.min(1, (animalData.animals[i].wool or 1) + shearTime * shearing)
            end
          end
        elseif animalTypes[animalData.animals[i].type].milking then
          local timeToAdult = (1 - animalData.animals[i].growth) / (gRate / 100)
          if 0 < time then
            local milkTime = time - timeToAdult
            if 0 < milkTime and 1 > (animalData.animals[i].milk or 0) then
              local milking = animalTypes[animalData.animals[i].type].milking / 100
              animalData.animals[i].milk = math.min(1, (animalData.animals[i].milk or 0) + milkTime * milking)
            end
          end
        elseif animalTypes[animalData.animals[i].type].eggLaying then
          local timeToAdult = (1 - animalData.animals[i].growth) / (gRate / 100)
          if 0 < time then
            local eggTime = time - timeToAdult
            if 0 < eggTime then
              eggPlus = eggPlus + eggTime * animalTypes[animalData.animals[i].type].eggLaying / 100
            end
          end
        end
        animalData.animals[i].life = animalData.animals[i].life + animalData.animals[i].growthRate * animalTypes[animalData.animals[i].type].growthRate * time / 100
        if timeForHealth < 0 then
          local new = animalData.animals[i].health + animalData.animals[i].growthRate * animalTypes[animalData.animals[i].type].healthRate * timeForHealth / 100
          animalData.animals[i].health = math.min(1, math.max(0, new))
        end
        if 0 < shit then
          local new = animalData.animals[i].health + animalData.animals[i].growthRate * animalTypes[animalData.animals[i].type].healthRate * -shit * delta / 100
          animalData.animals[i].health = math.min(1, math.max(0, new))
        end
        local moodPlus = animalData.animals[i].growthRate * animalTypes[animalData.animals[i].type].moodRate * math.min(time, timeForHealth, hayMood, shitMood) / 100
        local new = animalData.animals[i].mood + moodPlus
        animalData.animals[i].mood = math.min(1, math.max(0, new))
        if moodPlus < 0 then
          animalData.animals[i].moodMinus = animalData.animals[i].moodMinus + math.abs(moodPlus)
        end
        local plus = animalData.animals[i].growthRate * animalTypes[animalData.animals[i].type].fatRate * timeForFat / 100
        local new = animalData.animals[i].fat + plus
        animalData.animals[i].fat = math.min(1, math.max(0, new))
        if 0 >= animalData.animals[i].health or animalData.animals[i].life >= animalTypes[animalData.animals[i].type].lifeExpectancy then
          table.insert(animalData.reportDead, animalData.animals[i].type)
          table.remove(animalData.animals, i)
        end
      end
    end
    if 0 < eggPlus then
      animalData.eggs = animalData.eggs + eggPlus
      for i = 1, math.floor(animalData.eggs) do
        local crate = math.random(1, 4)
        animalData.eggCrates[crate] = (animalData.eggCrates[crate] or 0) + 1
        animalData.eggs = animalData.eggs - 1
      end
    end
  end
end
function animalGrowth(animalData, land)
  local now = getTickCount()
  local lastUpdate = animalData.lastUpdate
  local delta = (now - lastUpdate) / 60000
  animalData.lastUpdate = now
  local sumConsumptionFood = 0
  local sumConsumptionWater = 0
  local sumConsumptionFoodChick = 0
  local sumConsumptionWaterChick = 0
  for i = 1, #animalData.animals do
    if animalData.animals[i].type == "chicken" then
      sumConsumptionFoodChick = sumConsumptionFoodChick + animalData.animals[i].growthRate * animalTypes[animalData.animals[i].type].foodConsumption / 100 * math.random(90, 110) / 100
      sumConsumptionWaterChick = sumConsumptionWaterChick + animalData.animals[i].growthRate * animalTypes[animalData.animals[i].type].waterConsumption / 100 * math.random(90, 110) / 100
    else
      sumConsumptionFood = sumConsumptionFood + animalData.animals[i].growthRate * animalTypes[animalData.animals[i].type].foodConsumption / 100 * math.random(90, 110) / 100
      sumConsumptionWater = sumConsumptionWater + animalData.animals[i].growthRate * animalTypes[animalData.animals[i].type].waterConsumption / 100 * math.random(90, 110) / 100
    end
  end
  animalData.food.hourlyFood = sumConsumptionFood * 60
  animalData.food.hourlyWater = sumConsumptionWater * 60
  animalData.food.hourlyFoodChick = sumConsumptionFoodChick * 60
  animalData.food.hourlyWaterChick = sumConsumptionWaterChick * 60
  local count = 0
  local hayCount = 0
  local shitValue = 0
  for x in pairs(land) do
    for y in pairs(land[x]) do
      count = count + 1
      if land[x][y].hay then
        hayCount = hayCount + 1
      end
      if land[x][y].dirt and 0 < land[x][y].dirt then
        shitValue = shitValue + land[x][y].dirt
      end
    end
  end
  processFeeding(animalData, land, hayCount / count, shitValue / count / 255, false, delta, sumConsumptionFood, sumConsumptionWater)
  processFeeding(animalData, land, hayCount / count, shitValue / count / 255, true, delta, sumConsumptionFoodChick, sumConsumptionWaterChick)
end
function newAnimal(type, variation, growth, fat)
  if animalTypes[type] then
    return {
      type = type,
      growth = math.min(1, growth),
      growthRate = math.random(95, 105) / 100,
      health = 1,
      fat = math.min(1, fat),
      mood = 1,
      variation = variation,
      life = math.min(1, growth),
      moodMinus = 0
    }
  end
end
function animalDataFromJson(data)
  local converted = {
    animals = {},
    reportDead = {},
    food = {},
    hay = 0,
    otherStock = 0,
    chickenStock = 0,
    lastUpdate = getTickCount(),
    lastHayUpdate = getTickCount(),
    eggs = 0,
    eggCrates = {}
  }
  data = fromJSON(data)
  for i = 1, #data.animals do
    converted.animals[i] = {
      type = data.animals[i][1] or data.animals[i]["1"],
      growth = tonumber(data.animals[i][2] or data.animals[i]["2"]) or 0,
      growthRate = tonumber(data.animals[i][3] or data.animals[i]["3"]) or 1,
      health = tonumber(data.animals[i][4] or data.animals[i]["4"]) or 1,
      fat = tonumber(data.animals[i][5] or data.animals[i]["5"]) or 1,
      mood = tonumber(data.animals[i][6] or data.animals[i]["6"]) or 1,
      variation = tonumber(data.animals[i][7] or data.animals[i]["7"]) or 1,
      life = tonumber(data.animals[i][8] or data.animals[i]["8"]) or 0,
      moodMinus = tonumber(data.animals[i][9] or data.animals[i]["9"]) or 0,
      milk = tonumber(data.animals[i][10] or data.animals[i]["10"]),
      wool = tonumber(data.animals[i][11] or data.animals[i]["11"])
    }
  end
  converted.hay = tonumber(data.hay) or 0
  converted.chickenStock = tonumber(data.chickenStock) or 0
  converted.otherStock = tonumber(data.otherStock) or 0
  converted.food = data.food
  converted.eggs = tonumber(data.eggs) or 0
  converted.eggCrates = data.eggCrates
  converted.reportDead = data.reportDead or {}
  converted.farmSlots = tonumber(data.farmSlots) or 100
  return converted
end
function defaultAnimalData()
  return {
    animals = {},
    reportDead = {},
    hay = 0,
    otherStock = 0,
    chickenStock = 0,
    food = {
      otherFood = 0,
      chickenFood = 0,
      otherWater = 0,
      chickenWater = 0
    },
    lastUpdate = getTickCount(),
    lastHayUpdate = getTickCount(),
    eggs = 0,
    eggCrates = {
      0,
      0,
      0,
      0
    },
    farmSlots = 100
  }
end
function animalDataToJson(animalData)
  local data = {
    animals = {},
    reportDead = animalData.reportDead,
    food = animalData.food,
    hay = animalData.hay,
    otherStock = animalData.otherStock,
    chickenStock = animalData.chickenStock,
    eggs = animalData.eggs,
    eggCrates = animalData.eggCrates,
    farmSlots = animalData.farmSlots
  }
  for i = 1, #animalData.animals do
    data.animals[i] = {
      animalData.animals[i].type,
      animalData.animals[i].growth,
      animalData.animals[i].growthRate,
      animalData.animals[i].health,
      animalData.animals[i].fat,
      animalData.animals[i].mood,
      animalData.animals[i].variation,
      animalData.animals[i].life,
      animalData.animals[i].moodMinus,
      animalData.animals[i].milk,
      animalData.animals[i].wool
    }
  end
  return toJSON(data, true)
end
function initLandDataTables(landData, xs, ys, theType)
  for x = 1, xs do
    landData[x] = {}
    for y = 1, ys do
      landData[x][y] = initLandData(theType)
    end
  end
end
function calculateWetness(lData)
  return math.max((lData.fromWetness or 0) - (getTickCount() - lData.lastWatering) / 60000 * lData.currentDryFactor, 0)
end
function initSizeTable(table, xs, ys)
  for x = 1, xs do
    table[x] = {}
    for y = 1, ys do
      table[x][y] = false
    end
  end
end
taskTimes = {
  placemanure = 3500,
  placehay = 3500,
  removeDirt = 4000,
  fillHole = 4000,
  dighole = 4000,
  harvest = 10300,
  plant = 4000,
  cultivate = 800,
  water = 39.21568627450981
}
function checkDistanceFromLand(element, farmId, x, y)
  local px, py = getElementPosition(element)
  if getElementDimension(element) ~= farmId then
    return false
  end
  local sx, sy = getLandPosition(farmId, x, y)
  local d = getDistanceBetweenPoints2D(px, py, sx, sy)
  return d <= 1.6
end
function getPositionFromMatrixOffset(m, offX, offY, offZ)
  local x = offX * m[1][1] + offY * m[2][1] + offZ * m[3][1] + m[4][1]
  local y = offX * m[1][2] + offY * m[2][2] + offZ * m[3][2] + m[4][2]
  local z = offX * m[1][3] + offY * m[2][3] + offZ * m[3][3] + m[4][3]
  return x, y, z
end
function getPositionFromElementOffset(element, offX, offY, offZ)
  local m = getElementMatrix(element)
  local x = offX * m[1][1] + offY * m[2][1] + offZ * m[3][1] + m[4][1]
  local y = offX * m[1][2] + offY * m[2][2] + offZ * m[3][2] + m[4][2]
  local z = offX * m[1][3] + offY * m[2][3] + offZ * m[3][3] + m[4][3]
  return x, y, z
end
farmExteriors = {}
nameLineOffsets = {
  [5] = {
    10.035,
    5.5,
    1.44,
    -9.965,
    5.5,
    1.44
  },
  [10] = {
    20,
    5.475,
    1.44,
    -20,
    5.475,
    1.44
  },
  [15] = {
    30,
    5.5,
    1.44,
    -30,
    5.5,
    1.44
  }
}
farmExteriors[1] = {
  size = 5,
  price = 2000,
  pp = 1200,
  pos = {
    -140.2,
    -67.7,
    2.1,
    0,
    0,
    338
  },
  names = {}
}
farmExteriors[2] = {
  size = 5,
  price = 2000,
  pp = 1200,
  pos = {
    -84,
    -4.3,
    2.1,
    0,
    0,
    338.5
  },
  names = {}
}
farmExteriors[3] = {
  size = 5,
  price = 2000,
  pp = 1200,
  pos = {
    -72.4,
    -78.1,
    2.1,
    0,
    0,
    57.75
  },
  names = {}
}
farmExteriors[4] = {
  size = 5,
  price = 2000,
  pp = 1200,
  pos = {
    -1739.8,
    -18.8,
    2.5,
    0,
    0,
    180
  },
  names = {}
}
farmExteriors[5] = {
  size = 5,
  price = 2000,
  pp = 1200,
  pos = {
    26.5,
    -2638.5,
    39.3,
    0,
    0,
    182
  },
  names = {}
}
farmExteriors[6] = {
  size = 5,
  price = 2000,
  pp = 1200,
  pos = {
    27.5,
    -2655.6001,
    39.3,
    0,
    0,
    2
  },
  names = {}
}
farmExteriors[7] = {
  size = 5,
  price = 2000,
  pp = 1200,
  pos = {
    -1011.3,
    -1050.8,
    128.10001,
    0,
    0,
    89.247
  },
  names = {}
}
farmExteriors[8] = {
  size = 5,
  price = 2000,
  pp = 1200,
  pos = {
    -1032.6,
    -1050.5,
    128.10001,
    0,
    0,
    89.247
  },
  names = {}
}
farmExteriors[9] = {
  size = 5,
  price = 2000,
  pp = 1200,
  pos = {
    -1053.9,
    -1050.6,
    128.10001,
    0,
    0,
    89.247
  },
  names = {}
}
farmExteriors[10] = {
  size = 5,
  price = 2000,
  pp = 1200,
  pos = {
    -1076.4,
    -1050.5,
    128.10001,
    0,
    0,
    89.247
  },
  names = {}
}
farmExteriors[11] = {
  size = 5,
  price = 2000,
  pp = 1200,
  pos = {
    -1100,
    -1050.3,
    128.10001,
    0,
    0,
    89.247
  },
  names = {}
}
farmExteriors[12] = {
  size = 5,
  price = 2000,
  pp = 1200,
  pos = {
    -1122.9,
    -1050.5,
    128.10001,
    0,
    0,
    89.247
  },
  names = {}
}
farmExteriors[13] = {
  size = 5,
  price = 2000,
  pp = 1200,
  pos = {
    -1146.4,
    -1050.4,
    128.10001,
    0,
    0,
    89.247
  },
  names = {}
}
farmExteriors[14] = {
  size = 5,
  price = 2000,
  pp = 1200,
  pos = {
    -1167.4,
    -1050.6,
    128.10001,
    0,
    0,
    89.247
  },
  names = {}
}
farmExteriors[15] = {
  size = 5,
  price = 2000,
  pp = 1200,
  pos = {
    -1188.2,
    -1050.3,
    128.10001,
    0,
    0,
    89.247
  },
  names = {}
}
farmExteriors[16] = {
  size = 10,
  price = 2000,
  pp = 1200,
  pos = {
    -67.7,
    14.9,
    2.1,
    0,
    0,
    158.75
  },
  names = {}
}
farmExteriors[17] = {
  size = 10,
  price = 2000,
  pp = 1200,
  pos = {
    -115.8,
    -12.6,
    2,
    0,
    0,
    248.747
  },
  names = {}
}
farmExteriors[18] = {
  size = 10,
  price = 2000,
  pp = 1200,
  pos = {
    -162.39999,
    -162.2,
    1.3,
    0,
    0,
    167.995
  },
  names = {}
}
farmExteriors[19] = {
  size = 10,
  price = 2000,
  pp = 1200,
  pos = {
    -212.89999,
    -151.8,
    1.4,
    0,
    0,
    167.992
  },
  names = {}
}
farmExteriors[20] = {
  size = 10,
  price = 2000,
  pp = 1200,
  pos = {
    -148.5,
    -132,
    2.1,
    0,
    0,
    353.742
  },
  names = {}
}
farmExteriors[21] = {
  size = 10,
  price = 2000,
  pp = 1200,
  pos = {
    -212.5,
    -125.8,
    2.1,
    0,
    0,
    353.738
  },
  names = {}
}
farmExteriors[22] = {
  size = 10,
  price = 2000,
  pp = 1200,
  pos = {
    -261.5,
    -113.1,
    2.1,
    0,
    0,
    331.738
  },
  names = {}
}
farmExteriors[23] = {
  size = 10,
  price = 2000,
  pp = 1200,
  pos = {
    -2254,
    2306,
    3.8,
    0,
    0,
    90
  },
  names = {}
}
farmExteriors[24] = {
  size = 10,
  price = 2000,
  pp = 1200,
  pos = {
    -2284.2,
    2405.5,
    3.7,
    0,
    0,
    314
  },
  names = {}
}
farmExteriors[25] = {
  size = 10,
  price = 2000,
  pp = 1200,
  pos = {
    -2462.5,
    2226.6001,
    3.8,
    0,
    0,
    0.25
  },
  names = {}
}
farmExteriors[26] = {
  size = 15,
  price = 2000,
  pp = 1200,
  pos = {
    -53.4,
    -30.5,
    2.1,
    0,
    0,
    68.75
  },
  names = {}
}
farmExteriors[27] = {
  size = 15,
  price = 2000,
  pp = 1200,
  pos = {
    -15.6,
    60.4,
    2.1,
    0,
    0,
    248.747
  },
  names = {}
}
farmExteriors[28] = {
  size = 15,
  price = 2000,
  pp = 1200,
  pos = {
    -54.8,
    75.6,
    2.1,
    0,
    0,
    338.747
  },
  names = {}
}
farmExteriors[29] = {
  size = 15,
  price = 2000,
  pp = 1200,
  pos = {
    -46,
    97.6,
    2.1,
    0,
    0,
    338.741
  },
  names = {}
}
farmExteriors[30] = {
  size = 15,
  price = 2000,
  pp = 1200,
  pos = {
    -93.59961,
    40.90039,
    2.1,
    0,
    0,
    248.494
  },
  names = {}
}
farmExteriors[31] = {
  size = 15,
  price = 2000,
  pp = 1200,
  pos = {
    -1849.4,
    141.3,
    14,
    0,
    0,
    262.75
  },
  names = {}
}
farmExteriors[32] = {
  size = 15,
  price = 2000,
  pp = 1200,
  pos = {
    -1853.9,
    74.2,
    14,
    0,
    0,
    269.998
  },
  names = {}
}
farmExteriors[33] = {
  size = 15,
  price = 2000,
  pp = 1200,
  pos = {
    -1828.1,
    73.4,
    14.1,
    0,
    0,
    89.745
  },
  names = {}
}
farmExteriors[34] = {
  size = 15,
  price = 2000,
  pp = 1200,
  pos = {
    -1854,
    8.9,
    14,
    0,
    0,
    269.995
  },
  names = {}
}
farmExteriors[35] = {
  size = 15,
  price = 2000,
  pp = 1200,
  pos = {
    -1828.2,
    8.4,
    14,
    0,
    0,
    89.742
  },
  names = {}
}
farmExteriors[36] = {
  size = 15,
  price = 2000,
  pp = 1200,
  pos = {
    -2270.2,
    2313.3,
    3.8,
    0,
    0,
    270
  },
  names = {}
}
farmExteriors[37] = {
  size = 15,
  price = 2000,
  pp = 1200,
  pos = {
    -1652.6,
    -41.7,
    2.6,
    0,
    0,
    135.245
  },
  names = {}
}
farmExteriors[38] = {
  size = 15,
  price = 2000,
  pp = 1200,
  pos = {
    -1667.9,
    -58,
    2.5,
    0,
    0,
    135.242
  },
  names = {}
}
farmExteriors[39] = {
  size = 15,
  price = 2000,
  pp = 1200,
  pos = {
    -1684.6,
    -74.7,
    2.5,
    0,
    0,
    135.242
  },
  names = {}
}
farmExteriors[40] = {
  size = 15,
  price = 2000,
  pp = 1200,
  pos = {
    -1702.8,
    -92.4,
    2.5,
    0,
    0,
    135.242
  },
  names = {}
}
farmExteriors[41] = {
  size = 15,
  price = 2000,
  pp = 1200,
  pos = {
    -1719.5,
    -109,
    2.5,
    0,
    0,
    135.242
  },
  names = {}
}
farmExteriors[42] = {
  size = 15,
  price = 2000,
  pp = 1200,
  pos = {
    -1740.2,
    -153.89999,
    2.5,
    0,
    0,
    44.992
  },
  names = {}
}
farmExteriors[43] = {
  size = 15,
  price = 2000,
  pp = 1200,
  pos = {
    -2963.2002,
    467.40039,
    3.9,
    0,
    0,
    0
  },
  names = {}
}
farmExteriors[44] = {
  size = 15,
  price = 2000,
  pp = 1200,
  pos = {
    -2917.8,
    452,
    3.9,
    0,
    0,
    270
  },
  names = {}
}
farmExteriors[45] = {
  size = 15,
  price = 2000,
  pp = 1200,
  pos = {
    -2899.3999,
    452.29999,
    3.9,
    0,
    0,
    90.25
  },
  names = {}
}
farmExteriors[46] = {
  size = 15,
  price = 2000,
  pp = 1200,
  pos = {
    -2878.1001,
    452.39999,
    3.9,
    0,
    0,
    270
  },
  names = {}
}
farmExteriors[47] = {
  size = 15,
  price = 2000,
  pp = 1200,
  pos = {
    -2895,
    498,
    3.9,
    0,
    0,
    180
  },
  names = {}
}
farmExteriors[48] = {
  size = 15,
  price = 2000,
  pp = 1200,
  pos = {
    -1606.6,
    -2712.6001,
    47.5,
    0,
    0,
    142
  },
  names = {}
}
farmExteriors[49] = {
  size = 15,
  price = 2000,
  pp = 1200,
  pos = {
    -1011,
    -941.5,
    128.2,
    0,
    0,
    90
  },
  names = {}
}
farmExteriors[50] = {
  size = 15,
  price = 2000,
  pp = 1200,
  pos = {
    -1011.2,
    -1005.9,
    128.2,
    0,
    0,
    90
  },
  names = {}
}
farmExteriors[51] = {
  size = 15,
  price = 2000,
  pp = 1200,
  pos = {
    -1032.3,
    -941.5,
    128.2,
    0,
    0,
    90
  },
  names = {}
}
farmExteriors[52] = {
  size = 15,
  price = 2000,
  pp = 1200,
  pos = {
    -1032.4,
    -1006,
    128.2,
    0,
    0,
    90
  },
  names = {}
}
farmExteriors[53] = {
  size = 15,
  price = 2000,
  pp = 1200,
  pos = {
    -1053.8,
    -941.59998,
    128.2,
    0,
    0,
    90
  },
  names = {}
}
farmExteriors[54] = {
  size = 15,
  price = 2000,
  pp = 1200,
  pos = {
    -1053.7,
    -1006.2,
    128.2,
    0,
    0,
    90
  },
  names = {}
}
farmExteriors[55] = {
  size = 15,
  price = 2000,
  pp = 1200,
  pos = {
    -1076.6,
    -941.90002,
    128.2,
    0,
    0,
    90
  },
  names = {}
}
farmExteriors[56] = {
  size = 15,
  price = 2000,
  pp = 1200,
  pos = {
    -1076.3,
    -1006.5,
    128.2,
    0,
    0,
    90
  },
  names = {}
}
farmExteriors[57] = {
  size = 15,
  price = 2000,
  pp = 1200,
  pos = {
    -1099.7,
    -942.40002,
    128.2,
    0,
    0,
    90
  },
  names = {}
}
farmExteriors[58] = {
  size = 15,
  price = 2000,
  pp = 1200,
  pos = {
    -1099.7,
    -1006.8,
    128.2,
    0,
    0,
    90
  },
  names = {}
}
farmExteriors[59] = {
  size = 15,
  price = 2000,
  pp = 1200,
  pos = {
    -1122.9,
    -942.59998,
    128.2,
    0,
    0,
    90
  },
  names = {}
}
farmExteriors[60] = {
  size = 15,
  price = 2000,
  pp = 1200,
  pos = {
    -1122.9,
    -1007.1,
    128.2,
    0,
    0,
    90
  },
  names = {}
}
farmExteriors[61] = {
  size = 15,
  price = 2000,
  pp = 1200,
  pos = {
    -1146,
    -1007.5,
    128.2,
    0,
    0,
    90
  },
  names = {}
}
farmExteriors[62] = {
  size = 15,
  price = 2000,
  pp = 1200,
  pos = {
    -1146.1,
    -942.59998,
    128.2,
    0,
    0,
    90
  },
  names = {}
}
farmExteriors[63] = {
  size = 15,
  price = 2000,
  pp = 1200,
  pos = {
    -1167.9,
    -1007.7,
    128.2,
    0,
    0,
    90
  },
  names = {}
}
farmExteriors[64] = {
  size = 15,
  price = 2000,
  pp = 1200,
  pos = {
    -1167.8,
    -942.40002,
    128.2,
    0,
    0,
    90
  },
  names = {}
}
farmExteriors[65] = {
  size = 15,
  price = 2000,
  pp = 1200,
  pos = {
    -1188,
    -1007.6,
    128.2,
    0,
    0,
    90
  },
  names = {}
}
farmExteriors[66] = {
  size = 15,
  price = 2000,
  pp = 1200,
  pos = {
    -1188,
    -942.20001,
    128.10001,
    0,
    0,
    90
  },
  names = {}
}
farmExteriors[67] = {
  size = 5,
  price = 2000,
  pp = 1200,
  pos = {
    -1943.9,
    1346.9,
    6.1,
    0,
    0,
    269.5
  },
  names = {}
}
farmExteriors[68] = {
  size = 5,
  price = 2000,
  pp = 1200,
  pos = {
    -1924.8,
    1346.8,
    6.1,
    0,
    0,
    269.495
  },
  names = {}
}
farmExteriors[69] = {
  size = 5,
  price = 2000,
  pp = 1200,
  pos = {
    -1875.8,
    1385.6,
    6.1,
    0,
    0,
    179.995
  },
  names = {}
}
farmExteriors[70] = {
  size = 5,
  price = 2000,
  pp = 1200,
  pos = {
    -2074.2,
    1355.8,
    5.9,
    0,
    0,
    180.25
  },
  names = {}
}
farmExteriors[71] = {
  size = 15,
  price = 2000,
  pp = 1200,
  pos = {
    -1983.7,
    1385.5,
    6.1,
    0,
    0,
    180
  },
  names = {}
}
farmExteriors[72] = {
  size = 15,
  price = 2000,
  pp = 1200,
  pos = {
    -1983.9,
    1368.4,
    6.1,
    0,
    0,
    359.745
  },
  names = {}
}
farmExteriors[73] = {
  size = 15,
  price = 2000,
  pp = 1200,
  pos = {
    -1984.1,
    1351.6,
    6.1,
    0,
    0,
    179.995
  },
  names = {}
}
farmExteriors[74] = {
  size = 15,
  price = 2000,
  pp = 1200,
  pos = {
    -1984.4,
    1333.2,
    6.1,
    0,
    0,
    359.742
  },
  names = {}
}
farmExteriors[74] = {
  size = 15,
  price = 2000,
  pp = 1200,
  pos = {
    -1920.1,
    1368.4,
    6.1,
    0,
    0,
    359.742
  },
  names = {}
}
farmExteriors[75] = {
  size = 15,
  price = 2000,
  pp = 1200,
  pos = {
    -1920,
    1385.5,
    6.1,
    0,
    0,
    179.995
  },
  names = {}
}
farmExteriors[76] = {
  size = 15,
  price = 2000,
  pp = 1200,
  pos = {
    -2086.3,
    1401.6,
    6,
    0,
    0,
    270
  },
  names = {}
}
farmExteriors[77] = {
  size = 15,
  price = 2000,
  pp = 1200,
  pos = {
    -2070,
    1401.7,
    6,
    0,
    0,
    89.75
  },
  names = {}
}
farmExteriors[78] = {
  size = 15,
  price = 2000,
  pp = 1200,
  pos = {
    -1971.6,
    -505.39999,
    34.1,
    0,
    0,
    90
  },
  names = {}
}
farmExteriors[79] = {
  size = 15,
  price = 2000,
  pp = 1200,
  pos = {
    -2105.5,
    -966.79999,
    31,
    0,
    0,
    270.25
  },
  names = {}
}
farmExteriors[80] = {
  size = 15,
  price = 2000,
  pp = 1200,
  pos = {
    -1971.8,
    -428.5,
    34.1,
    0,
    0,
    90
  },
  names = {}
}
farmExteriors[81] = {
  size = 15,
  price = 2000,
  pp = 1200,
  pos = {
    -1995.7,
    -428.39999,
    34.1,
    0,
    0,
    90
  },
  names = {}
}
farmExteriors[82] = {
  size = 15,
  price = 2000,
  pp = 1200,
  pos = {
    -1995.7,
    -505.5,
    34.1,
    0,
    0,
    90.25
  },
  names = {}
}
farmExteriors[83] = {
  size = 15,
  price = 2000,
  pp = 1200,
  pos = {
    -2021.4,
    -428.10001,
    34.1,
    0,
    0,
    90
  },
  names = {}
}
farmExteriors[84] = {
  size = 15,
  price = 2000,
  pp = 1200,
  pos = {
    -2021.4,
    -505.70001,
    34.1,
    0,
    0,
    90.247
  },
  names = {}
}
farmExteriors[85] = {
  size = 15,
  price = 2000,
  pp = 1200,
  pos = {
    -2048,
    -505.20001,
    34.1,
    0,
    0,
    90.247
  },
  names = {}
}
farmExteriors[86] = {
  size = 15,
  price = 2000,
  pp = 1200,
  pos = {
    -2048.2,
    -427.70001,
    34.1,
    0,
    0,
    90
  },
  names = {}
}
farmExteriors[87] = {
  size = 15,
  price = 2000,
  pp = 1200,
  pos = {
    -2074.8999,
    -427.5,
    34.1,
    0,
    0,
    90
  },
  names = {}
}
farmExteriors[88] = {
  size = 15,
  price = 2000,
  pp = 1200,
  pos = {
    -2103.3999,
    -427.29999,
    34.1,
    0,
    0,
    90
  },
  names = {}
}
farmExteriors[89] = {
  size = 15,
  price = 2000,
  pp = 1200,
  pos = {
    -2153.3,
    -449.89999,
    34.1,
    0,
    0,
    314.25
  },
  names = {}
}
farmExteriors[90] = {
  size = 15,
  price = 2000,
  pp = 1200,
  pos = {
    -2105.7,
    -898.29999,
    31,
    0,
    0,
    270.247
  },
  names = {}
}
farmExteriors[91] = {
  size = 15,
  price = 2000,
  pp = 1200,
  pos = {
    -2105.7,
    -829.5,
    31,
    0,
    0,
    270.247
  },
  names = {}
}
farmExteriors[92] = {
  size = 15,
  price = 2000,
  pp = 1200,
  pos = {
    -2106.1001,
    -760.5,
    31,
    0,
    0,
    270.247
  },
  names = {}
}
farmExteriors[93] = {
  size = 15,
  price = 2000,
  pp = 1200,
  pos = {
    -2079.1001,
    -966.79999,
    31,
    0,
    0,
    270.247
  },
  names = {}
}
farmExteriors[94] = {
  size = 15,
  price = 2000,
  pp = 1200,
  pos = {
    -2079.3,
    -898.40002,
    31,
    0,
    0,
    270.247
  },
  names = {}
}
farmExteriors[95] = {
  size = 15,
  price = 2000,
  pp = 1200,
  pos = {
    -2079.3999,
    -829.5,
    31,
    0,
    0,
    270.247
  },
  names = {}
}
farmExteriors[96] = {
  size = 15,
  price = 2000,
  pp = 1200,
  pos = {
    -2079.5996,
    -760.40039,
    31,
    0,
    0,
    270.242
  },
  names = {}
}
farmExteriors[97] = {
  size = 15,
  price = 2000,
  pp = 1200,
  pos = {
    -2055,
    -760.29999,
    31,
    0,
    0,
    270.247
  },
  names = {}
}
farmExteriors[98] = {
  size = 15,
  price = 2000,
  pp = 1200,
  pos = {
    -2054.7,
    -829.5,
    31,
    0,
    0,
    270.247
  },
  names = {}
}
farmExteriors[99] = {
  size = 15,
  price = 2000,
  pp = 1200,
  pos = {
    -2054.3,
    -898.40002,
    31,
    0,
    0,
    270.247
  },
  names = {}
}
farmExteriors[100] = {
  size = 15,
  price = 2000,
  pp = 1200,
  pos = {
    -2054,
    -966.70001,
    31,
    0,
    0,
    270.247
  },
  names = {}
}
farmExteriors[101] = {
  size = 15,
  price = 2000,
  pp = 1200,
  pos = {
    -2030.7,
    -760.40002,
    31,
    0,
    0,
    270.247
  },
  names = {}
}
farmExteriors[102] = {
  size = 15,
  price = 2000,
  pp = 1200,
  pos = {
    -2030.3,
    -829.40002,
    31,
    0,
    0,
    270.247
  },
  names = {}
}
farmExteriors[103] = {
  size = 15,
  price = 2000,
  pp = 1200,
  pos = {
    -2029.9,
    -898.40002,
    31,
    0,
    0,
    270.247
  },
  names = {}
}
farmExteriors[104] = {
  size = 15,
  price = 2000,
  pp = 1200,
  pos = {
    -2029.7,
    -966.70001,
    31,
    0,
    0,
    270.247
  },
  names = {}
}
farmExteriors[105] = {
  size = 15,
  price = 2000,
  pp = 1200,
  pos = {
    -2005.4004,
    -966.7002,
    31,
    0,
    0,
    270.247
  },
  names = {}
}
farmExteriors[106] = {
  size = 15,
  price = 2000,
  pp = 1200,
  pos = {
    -2005.8,
    -898.20001,
    31,
    0,
    0,
    270.247
  },
  names = {}
}
farmExteriors[107] = {
  size = 15,
  price = 2000,
  pp = 1200,
  pos = {
    -2006.1,
    -829.29999,
    31,
    0,
    0,
    270.247
  },
  names = {}
}
farmExteriors[108] = {
  size = 15,
  price = 2000,
  pp = 1200,
  pos = {
    -2006.4004,
    -760.5,
    31,
    0,
    0,
    270.247
  },
  names = {}
}
farmExteriors[109] = {
  size = 10,
  price = 2000,
  pp = 1200,
  pos = {
    -2155.8999,
    -382.89999,
    34.2,
    0,
    0,
    180
  },
  names = {}
}
farmExteriors[110] = {
  size = 5,
  price = 2000,
  pp = 1200,
  pos = {
    -2075.7,
    -525.09998,
    34.2,
    0,
    0,
    328.25
  },
  names = {}
}
farmExteriors[111] = {
  size = 5,
  price = 2000,
  pp = 1200,
  pos = {
    -2097.5,
    -508.29999,
    34.2,
    0,
    0,
    318.25
  },
  names = {}
}
farmExteriors[112] = {
  size = 5,
  price = 2000,
  pp = 1200,
  pos = {
    -2117,
    -489.20001,
    34.2,
    0,
    0,
    314.996
  },
  names = {}
}
farmExteriors[113] = {
  size = 5,
  price = 2000,
  pp = 1200,
  pos = {
    -2182.3999,
    -407.5,
    34.2,
    0,
    0,
    275.745
  },
  names = {}
}
farmExteriors[113] = {
  size = 15,
  price = 2000,
  pp = 1200,
  pos = {
    -1005.7158203125,
    -1612.1875,
    75.3671875,
    0,
    0,
    180
  },
  names = {}
}
farmDetails = {}
function getLandPosition(farmId, x, y)
  x = x - 1
  y = y - 1
  local currentSize = farmDetails[farmId].size
  local ox, oy = rotateAround(farmDetails[farmId].pos[4], farmSizeDetails[currentSize].offset[1], farmSizeDetails[currentSize].offset[2], 0, 0)
  local farmInteriorX, farmInteriorY, farmInteriorZ = farmDetails[farmId].pos[1] + ox, farmDetails[farmId].pos[2] + oy, farmDetails[farmId].pos[3] + farmSizeDetails[currentSize].offset[3]
  farmInteriorRot = farmDetails[farmId].pos[4] + 180
  local olx = farmInteriorX + farmSizeDetails[currentSize].lineOffset[1]
  local oly = farmInteriorY + farmSizeDetails[currentSize].lineOffset[2]
  return rotateAround(farmInteriorRot, (x + 0.5) * blockSize + olx - farmSizeDetails[currentSize].size[1] * blockSize / 2, (y + 0.5) * blockSize + oly - farmSizeDetails[currentSize].size[2] * blockSize / 2, olx, oly)
end
markerOffsets = {
  [5] = {
    -7.987500000000001,
    6.25,
    1,
    4
  },
  [10] = {
    -17.975,
    6.25,
    1,
    4
  },
  [15] = {
    -27.950000000000003,
    6.25,
    1,
    4
  }
}
trashOffsets = {
  [5] = {
    -10.8,
    -4.15,
    0.9,
    270
  },
  [10] = {
    -20.85,
    -4.15,
    0.9,
    270
  },
  [15] = {
    -30.825000000000003,
    -4.15,
    0.9,
    270
  }
}
waterOffsets = {
  [5] = {
    -10.8,
    3.9,
    0.9
  },
  [10] = {
    -20.85,
    3.9,
    0.9
  },
  [15] = {
    -30.825000000000003,
    3.9,
    0.9
  }
}
furikElements = {}
bucketElements = {}
crateElements = {}
crateElements2 = {}
crateElementIds = {}
bucketContents = {}
function getInteriorMarker(farmId)
  local v = farmDetails[farmId]
  local ox, oy = rotateAround(v.pos[4], farmSizeDetails[v.size].insideMarkerOffset[1], farmSizeDetails[v.size].insideMarkerOffset[2], 0, 0)
  return v.pos[1] + ox, v.pos[2] + oy, v.pos[3] + farmSizeDetails[v.size].insideMarkerOffset[3]
end
waterCols = {}
inWaterCol = {}
function wateringInfo(player, md)
  if getElementType(player) == "player" then
    local currentBucket = getElementData(player, "currentBucket")
    seexports.sControls:toggleControl(player, "enter_exit", false, "watering")
    if currentBucket then
      if not bucketContents[currentBucket[3]] then
        inWaterCol[player] = true
        seexports.sGui:showInfobox(player, "i", "A vödör megtöltéséhez nyomj [F] gombot.")
      end
    else
      seexports.sGui:showInfobox(player, "i", "Az üres kanna megtöltéséhez kattints rá az inventoryban (jobb egérgomb).")
    end
  end
end
function wateringLeave(player, md)
  if getElementType(player) == "player" then
    inWaterCol[player] = false
    seexports.sControls:toggleControl(player, "enter_exit", true, "watering")
  end
end
function syncCrateElements(farmId)
  if isElement(crateElements[farmId]) then
    local x, y, z = getElementPosition(crateElements[farmId])
    local rx, ry, rz = getElementRotation(crateElements[farmId])
    setElementPosition(crateElements2[farmId], x, y, z - 0.17)
    setElementRotation(crateElements2[farmId], rx, ry, rz)
    seexports.sPattach:detach(crateElements2[farmId])
    setObjectScale(crateElements2[farmId], 0)
    if triggerClientEvent and farmDetails[farmId] and farmDetails[farmId].inventory then
      local weight = 0
      for k, v in pairs(farmDetails[farmId].inventory) do
        local w = tonumber(seexports.sItems:getItemWeight(k)) or 0
        weight = weight + w * v
      end
      weight = weight / 25
      if 0 < weight then
        setObjectScale(crateElements2[farmId], 0.99, 0.99, weight)
      end
    end
    setElementCollisionsEnabled(crateElements2[farmId], false)
    setElementDimension(crateElements2[farmId], getElementDimension(crateElements[farmId]))
  end
end
function convertTableText(t)
  t = t or " "
  t = utf8.upper(t)
  local text = {}
  utf8.gsub(t, ".", function(c)
    table.insert(text, c)
  end)
  return text
end
sizeMultipler = 1
letterXSize = 12 * sizeMultipler
letterYSize = 28 * sizeMultipler
xs = letterXSize / (180 * sizeMultipler)
ys = letterYSize / (180 * sizeMultipler)
local num = 0
kiado = convertTableText("KIADÓ!")
function refreshTablePoses(k)
  farmExteriors[k].tposes = {}
  local one = 1 / farmExteriors[k].size
  local oneLetter = xs / math.abs(farmExteriors[k].nameLineOffset[4] - farmExteriors[k].nameLineOffset[1])
  local x1, y1, z1 = getPositionFromMatrixOffset(farmExteriors[k].matrix, farmExteriors[k].nameLineOffset[1], farmExteriors[k].nameLineOffset[2], farmExteriors[k].nameLineOffset[3])
  local x2, y2, z2 = getPositionFromMatrixOffset(farmExteriors[k].matrix, farmExteriors[k].nameLineOffset[4], farmExteriors[k].nameLineOffset[5], farmExteriors[k].nameLineOffset[6])
  local x3, y3, z3 = getPositionFromMatrixOffset(farmExteriors[k].matrix, farmExteriors[k].nameLineOffset[1], farmExteriors[k].nameLineOffset[2] + 1, farmExteriors[k].nameLineOffset[3])
  local x4, y4, z4 = getPositionFromMatrixOffset(farmExteriors[k].matrix, farmExteriors[k].nameLineOffset[4], farmExteriors[k].nameLineOffset[5] + 1, farmExteriors[k].nameLineOffset[6])
  for i = 1, farmExteriors[k].size do
    local text = farmExteriors[k].names[farmExteriors[k].size - i + 1] and farmExteriors[k].names[farmExteriors[k].size - i + 1][1] or kiado
    local size = (#text + 2) * oneLetter / 2
    local j = 1
    farmExteriors[k].tposes[i] = {}
    farmExteriors[k].tposes[i][j] = {}
    farmExteriors[k].tposes[i][j][1], farmExteriors[k].tposes[i][j][2], farmExteriors[k].tposes[i][j][3] = interpolateBetween(x1, y1, z1, x2, y2, z2, one * (i - 0.5) - size + oneLetter * j, "Linear")
    for j = 2, #text + 1 do
      farmExteriors[k].tposes[i][j] = {}
      local xa, ya, za = interpolateBetween(x1, y1, z1, x2, y2, z2, one * (i - 0.5) - size + oneLetter * j, "Linear")
      farmExteriors[k].tposes[i][j][1] = xa
      farmExteriors[k].tposes[i][j][2] = ya
      farmExteriors[k].tposes[i][j][3] = za
      local xb, yb, zb = interpolateBetween(x3, y3, z3, x4, y4, z4, one * (i - 0.5) - size + oneLetter * j, "Linear")
      farmExteriors[k].tposes[i][j][4] = xb
      farmExteriors[k].tposes[i][j][5] = yb
      farmExteriors[k].tposes[i][j][6] = zb
    end
  end
  local x1, y1, z1 = getPositionFromMatrixOffset(farmExteriors[k].matrix, farmExteriors[k].nameLineOffset[1], farmExteriors[k].nameLineOffset[2], farmExteriors[k].nameLineOffset[3] - ys)
  local x2, y2, z2 = getPositionFromMatrixOffset(farmExteriors[k].matrix, farmExteriors[k].nameLineOffset[4], farmExteriors[k].nameLineOffset[5], farmExteriors[k].nameLineOffset[6] - ys)
  local x3, y3, z3 = getPositionFromMatrixOffset(farmExteriors[k].matrix, farmExteriors[k].nameLineOffset[1], farmExteriors[k].nameLineOffset[2] + 1, farmExteriors[k].nameLineOffset[3] - ys)
  local x4, y4, z4 = getPositionFromMatrixOffset(farmExteriors[k].matrix, farmExteriors[k].nameLineOffset[4], farmExteriors[k].nameLineOffset[5] + 1, farmExteriors[k].nameLineOffset[6] - ys)
  for i = 1, farmExteriors[k].size do
    if farmExteriors[k].names[farmExteriors[k].size - i + 1] then
      local text = farmExteriors[k].names[farmExteriors[k].size - i + 1][2]
      if type(text) == "table" then
        local size = (#text + 2) * oneLetter / 2
        local j = 1
        farmExteriors[k].tposes[i][j][7], farmExteriors[k].tposes[i][j][8], farmExteriors[k].tposes[i][j][9] = interpolateBetween(x1, y1, z1, x2, y2, z2, one * (i - 0.5) - size + oneLetter * j, "Linear")
        for j = 2, #text + 1 do
          if not farmExteriors[k].tposes[i][j] then
            farmExteriors[k].tposes[i][j] = {}
          end
          local xa, ya, za = interpolateBetween(x1, y1, z1, x2, y2, z2, one * (i - 0.5) - size + oneLetter * j, "Linear")
          farmExteriors[k].tposes[i][j][7] = xa
          farmExteriors[k].tposes[i][j][8] = ya
          farmExteriors[k].tposes[i][j][9] = za
          local xb, yb, zb = interpolateBetween(x3, y3, z3, x4, y4, z4, one * (i - 0.5) - size + oneLetter * j, "Linear")
          farmExteriors[k].tposes[i][j][10] = xb
          farmExteriors[k].tposes[i][j][11] = yb
          farmExteriors[k].tposes[i][j][12] = zb
        end
      end
    end
  end
end
crateBasePoses = {}
furikBasePoses = {}
bucketBasePoses = {}
trashPositions = {}
for k, v in pairs(farmExteriors) do
  if triggerServerEvent then
    farmExteriors[k].lod = createObject(2805, v.pos[1], v.pos[2], v.pos[3], v.pos[4], v.pos[5], v.pos[6], true)
    setElementDimension(farmExteriors[k].lod, 0)
  end
  local obj = createObject(2805, v.pos[1], v.pos[2], v.pos[3], v.pos[4], v.pos[5], v.pos[6])
  farmExteriors[k].object = obj
  farmExteriors[k].matrix = getElementMatrix(obj)
  setElementDimension(obj, 0)
  farmExteriors[k].nameLineOffset = nameLineOffsets[v.size]
  farmExteriors[k].markerOffsets = markerOffsets[v.size]
  if triggerServerEvent then
    refreshTablePoses(k)
  end
  if triggerClientEvent then
    local x, y, z = getPositionFromElementOffset(obj, trashOffsets[v.size][1], trashOffsets[v.size][2], trashOffsets[v.size][3])
    local trash = createObject(1246, x, y, z, v.pos[4], v.pos[5], v.pos[6] + trashOffsets[v.size][4])
    trashPositions[k] = {
      x,
      y,
      z
    }
    local x, y, z = getPositionFromElementOffset(obj, waterOffsets[v.size][1], waterOffsets[v.size][2], waterOffsets[v.size][3])
    local sphere = createColSphere(x, y, z, 1)
    waterCols[k] = sphere
    addEventHandler("onColShapeHit", sphere, wateringInfo)
    addEventHandler("onColShapeLeave", sphere, wateringLeave)
  else
    local x, y, z = getPositionFromElementOffset(obj, trashOffsets[v.size][1], trashOffsets[v.size][2], trashOffsets[v.size][3])
    trashPositions[k] = {
      x,
      y,
      z
    }
  end
  local x, y, z = getPositionFromElementOffset(obj, waterOffsets[v.size][1] + 0.575, waterOffsets[v.size][2] - 0.05, waterOffsets[v.size][3])
  farmExteriors[k].wateringIcon = {
    x,
    y,
    z
  }
  local x, y, z = getPositionFromElementOffset(obj, waterOffsets[v.size][1] + 0.4, waterOffsets[v.size][2] - 0.3, waterOffsets[v.size][3] - 0.115)
  local x2, y2, z2 = getPositionFromElementOffset(obj, waterOffsets[v.size][1] + 0.375, waterOffsets[v.size][2], waterOffsets[v.size][3] + 0.05)
  farmExteriors[k].wateringPosition = {
    x,
    y,
    z,
    x2,
    y2,
    z2
  }
  num = num + v.size
  for j = 1, v.size do
    local x, y, z = getPositionFromElementOffset(obj, v.markerOffsets[1] + (j - 1) * v.markerOffsets[4], v.markerOffsets[2], v.markerOffsets[3])
    local x2, y2, z2 = getPositionFromElementOffset(obj, v.markerOffsets[1] + (j - 1) * v.markerOffsets[4], v.markerOffsets[2] * 1.4, v.markerOffsets[3])
    farmDetails[k * 100 + j] = {
      size = farmSizes.small,
      rentedBy = false,
      renterName = "",
      pos = {
        x,
        y,
        z,
        v.pos[6]
      },
      loadpos = {
        x2,
        y2,
        z2
      },
      exteriorId = {k, j},
      locked = true,
      hoe = 2,
      miniHoe = 2,
      fork = 2
    }
  end
  if triggerClientEvent then
    if isElement(obj) then
      destroyElement(obj)
    end
    obj = nil
    farmExteriors[k].object = nil
    farmExteriors[k].matrix = nil
    for j = 1, v.size do
      local farmId = k * 100 + j
      local ox, oy = rotateAround(farmDetails[farmId].pos[4], farmSizeDetails[farmDetails[farmId].size].crateOffset[1], farmSizeDetails[farmDetails[farmId].size].crateOffset[2], 0, 0)
      crateBasePoses[farmId] = {
        farmDetails[farmId].pos[1] + ox,
        farmDetails[farmId].pos[2] + oy,
        farmDetails[farmId].pos[3] + farmSizeDetails[farmDetails[farmId].size].crateOffset[3],
        farmDetails[farmId].pos[4] + farmSizeDetails[farmDetails[farmId].size].crateOffset[4]
      }
      local ox, oy = rotateAround(farmDetails[farmId].pos[4], farmSizeDetails[farmDetails[farmId].size].offset[1] + farmSizeDetails[farmDetails[farmId].size].furikOffset[1], farmSizeDetails[farmDetails[farmId].size].offset[2] + farmSizeDetails[farmDetails[farmId].size].furikOffset[2], 0, 0)
      furikBasePoses[farmId] = {
        farmDetails[farmId].pos[1] + ox,
        farmDetails[farmId].pos[2] + oy,
        farmDetails[farmId].pos[3] + farmSizeDetails[farmDetails[farmId].size].offset[3] + farmSizeDetails[farmDetails[farmId].size].furikOffset[3],
        farmSizeDetails[farmDetails[farmId].size].furikOffset[4],
        0,
        farmDetails[farmId].pos[4] + farmSizeDetails[farmDetails[farmId].size].furikOffset[5]
      }
      local ox, oy = rotateAround(farmDetails[farmId].pos[4], farmSizeDetails[farmDetails[farmId].size].offset[1] + farmSizeDetails[farmDetails[farmId].size].bucketOffset[1], farmSizeDetails[farmDetails[farmId].size].offset[2] + farmSizeDetails[farmDetails[farmId].size].bucketOffset[2], 0, 0)
      bucketBasePoses[farmId] = {
        farmDetails[farmId].pos[1] + ox,
        farmDetails[farmId].pos[2] + oy,
        farmDetails[farmId].pos[3] + farmSizeDetails[farmDetails[farmId].size].offset[3] + farmSizeDetails[farmDetails[farmId].size].bucketOffset[3]
      }
    end
  else
    for j = 1, v.size do
      local farmId = k * 100 + j
      local ox, oy = rotateAround(farmDetails[farmId].pos[4], farmSizeDetails[farmDetails[farmId].size].offset[1] + farmSizeDetails[farmDetails[farmId].size].furikOffset[1], farmSizeDetails[farmDetails[farmId].size].offset[2] + farmSizeDetails[farmDetails[farmId].size].furikOffset[2], 0, 0)
      furikBasePoses[farmId] = {
        farmDetails[farmId].pos[1] + ox,
        farmDetails[farmId].pos[2] + oy,
        farmDetails[farmId].pos[3] + farmSizeDetails[farmDetails[farmId].size].offset[3] + farmSizeDetails[farmDetails[farmId].size].furikOffset[3],
        farmSizeDetails[farmDetails[farmId].size].furikOffset[4],
        0,
        farmDetails[farmId].pos[4] + farmSizeDetails[farmDetails[farmId].size].furikOffset[5]
      }
    end
  end
end
