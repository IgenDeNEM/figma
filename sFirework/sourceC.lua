local screenX, screenY = guiGetScreenSize()
local lights = {}
function shootFirework(x, y, z, t, mode, fast)
  local sound = playSound3D("files/ignite.mp3", x, y, z)
  setSoundMinDistance(sound, 100)
  local cx, cy, cz = getCameraMatrix()
  if getElementDimension(localPlayer) == 0 and getDistanceBetweenPoints2D(x, y, cx, cy) < 1100 then
    local dist = getDistanceBetweenPoints3D(x, y, z, cx, cy, cz)
    local time = math.max(dist / 750 * 1000, 50)
    local delay = fast and 100 or 12500
    setTimer(playShoot, time + delay, 1, x, y, z)
    local dat = {}
    dat.pos = {
      x,
      y,
      z - 1
    }
    dat.velocity = {
      0,
      0,
      30
    }
    dat.delay = delay
    dat.variant = math.random(0, 5)
    dat.col = {
      255,
      255,
      255,
      240
    }
    dat.size = math.random(80, 120) / 100 * 3.5
    dat.grow = 1
    dat.growSpeed = 1.5
    dat.texture = t
    if mode == "sparkleIn" then
      dat.lightsToGenSec = math.random(60, 70)
      dat.lightsToGen = math.random(70, 90)
      dat.lightsToGen = dat.lightsToGen + dat.lightsToGenSec
    elseif mode == "sparkle" then
      dat.lightsToGen = math.random(95, 115)
    else
      dat.lightsToGen = math.random(80, 100)
    end
    dat.genData = {}
    dat.boom = math.random(3650, 3850)
    dat.boomMode = mode
    table.insert(lights, dat)
  end
end
addEvent("shootFirework", true)
addEventHandler("shootFirework", getRootElement(), function(theType, c, x, y, z, fast)
  if theType == 1 then
    shootFirework(x, y, z, c, "sparkle", fast)
  elseif theType == 2 then
    shootFirework(x, y, z, c, "sparkleIn", fast)
  elseif theType == 3 then
    shootFirework(x, y, z, c, nil, fast)
  end
end)
local tailColors = {
  {
    240,
    200,
    80
  },
  {
    248,
    120,
    17
  },
  {
    224,
    50,
    50
  },
  {
    255,
    105,
    180
  },
  {
    0,
    108,
    255
  },
  {
    0,
    255,
    6
  }
}
function playShoot(x, y, z)
  local sound = playSound3D("files/shoot.mp3", x, y, z)
  setSoundMinDistance(sound, 200)
  setSoundMaxDistance(sound, 1200)
end
function playBoom(x, y, z)
  local sound = playSound3D("files/boom.mp3", x, y, z)
  setSoundMinDistance(sound, 500)
  setSoundMaxDistance(sound, 1500)
end
function playBoom2(x, y, z)
  local sound = playSound3D("files/boom2.mp3", x, y, z)
  setSoundMinDistance(sound, 500)
  setSoundMaxDistance(sound, 1500)
end
function playBoom3(x, y, z)
  local sound = playSound3D("files/boom3.mp3", x, y, z)
  setSoundMinDistance(sound, 500)
  setSoundMaxDistance(sound, 1500)
end
function boomLightsSparkleInside3(size, particleSize, texture, data, i)
  local vx = math.random(-100, 100)
  local vy = math.random(-100, 100)
  local vz = math.random(-100, 100)
  local len = math.sqrt(vx * vx + vy * vy + vz * vz)
  vx = vx / len * math.random(100, 105) / 100 * 0.15 * size
  vy = vy / len * math.random(100, 105) / 100 * 0.15 * size
  vz = vz / len * math.random(100, 105) / 100 * 0.15 * size
  local dat = {}
  dat.pos = {
    x,
    y,
    z
  }
  dat.velocity = {
    vx,
    vy,
    vz
  }
  dat.size = math.random(80, 120) / 100 * 3.5 * particleSize
  dat.grow = 1
  dat.growSpeed = 2.5
  dat.variant = math.random(0, 5)
  dat.col = {
    255,
    255,
    255,
    math.random(230, 255)
  }
  dat.boost = {
    15 * size,
    math.random(350, 450) / 100 * size
  }
  if i % 2 == 0 then
    dat.tails = {}
    dat.tailTiming = 400
    dat.tailFadeOut = 0.75
    dat.lastTail = 0
    dat.tailColor = tailColors[1]
  end
  dat.texture = 1
  dat.blink = true
  dat.fadeOut = math.random(25, 31) / 10
  table.insert(data, dat)
end
function boomLightsSparkleInside2(size, particleSize, texture, data)
  local vx = math.random(-100, 100)
  local vy = math.random(-100, 100)
  local vz = math.random(-100, 100)
  local len = math.sqrt(vx * vx + vy * vy + vz * vz)
  vx = vx / len * math.random(100, 105) / 100 * 0.5 * size
  vy = vy / len * math.random(100, 105) / 100 * 0.5 * size
  vz = vz / len * math.random(100, 105) / 100 * 0.5 * size
  local dat = {}
  dat.pos = {
    x,
    y,
    z
  }
  dat.velocity = {
    vx,
    vy,
    vz
  }
  dat.size = math.random(80, 120) / 100 * 3.5 * particleSize
  dat.grow = 1
  dat.growSpeed = 2.5
  dat.variant = math.random(0, 5)
  dat.col = {
    255,
    255,
    255,
    math.random(230, 255)
  }
  dat.boost = {
    15 * size,
    math.random(350, 450) / 100 * size
  }
  dat.texture = texture
  dat.fadeOut = math.random(40, 50) / 10
  table.insert(data, dat)
end
function boomLightsSparkle2(size, particleSize, texture, data)
  local vx = math.random(-100, 100)
  local vy = math.random(-100, 100)
  local vz = math.random(-100, 100)
  local len = math.sqrt(vx * vx + vy * vy + vz * vz)
  vx = vx / len * math.random(100, 105) / 100 * 0.5 * size
  vy = vy / len * math.random(100, 105) / 100 * 0.5 * size
  vz = vz / len * math.random(100, 105) / 100 * 0.5 * size
  local dat = {}
  dat.velocity = {
    vx,
    vy,
    vz
  }
  dat.size = math.random(80, 120) / 100 * 3.5 * particleSize
  dat.grow = 1
  dat.growSpeed = 2.5
  dat.variant = math.random(0, 5)
  dat.col = {
    255,
    255,
    255,
    math.random(230, 255)
  }
  dat.boost = {
    15 * size,
    math.random(350, 450) / 100 * size
  }
  dat.texture = texture
  dat.blink = true
  dat.fadeOut = math.random(45, 55) / 10
  table.insert(data, dat)
end
function boomLights2(size, particleSize, texture, data)
  local vx = math.random(-100, 100)
  local vy = math.random(-100, 100)
  local vz = math.random(-100, 100)
  local len = math.sqrt(vx * vx + vy * vy + vz * vz)
  vx = vx / len * math.random(100, 105) / 100 * 0.5 * size
  vy = vy / len * math.random(100, 105) / 100 * 0.5 * size
  vz = vz / len * math.random(100, 105) / 100 * 0.5 * size
  local dat = {}
  dat.velocity = {
    vx,
    vy,
    vz
  }
  dat.size = math.random(80, 120) / 100 * 3.5 * particleSize
  dat.grow = 1
  dat.growSpeed = 2.5
  dat.variant = math.random(0, 5)
  dat.col = {
    255,
    255,
    255,
    math.random(230, 255)
  }
  dat.boost = {
    15 * size,
    math.random(350, 450) / 100 * size
  }
  dat.tails = {}
  dat.tailTiming = 400
  dat.tailFadeOut = 0.75
  dat.texture = texture
  dat.tailColor = tailColors[texture]
  dat.lastTail = 0
  dat.fadeOut = math.random(45, 50) / 10
  table.insert(data, dat)
end
function boomLights(soundFunction, x, y, z, data)
  local cx, cy, cz = getCameraMatrix()
  local dist = getDistanceBetweenPoints3D(x, y, z, cx, cy, cz)
  local time = math.max(dist / 750 * 1000, 50)
  setTimer(soundFunction, time, 1, x, y, z)
  for i = 1, #data do
    data[i].pos = {
      x,
      y,
      z
    }
    table.insert(lights, data[i])
  end
end
function spawnSpark(x, y, z, size, fadeOut, alpha)
  table.insert(sparks, {
    x,
    y,
    z,
    size * math.random(80, 120) / 100,
    math.random(0, 23),
    0,
    alpha,
    fadeOut,
    false
  })
end
local lightTextures = {
  dxCreateTexture("files/1.dds"),
  dxCreateTexture("files/2.dds"),
  dxCreateTexture("files/3.dds"),
  dxCreateTexture("files/4.dds"),
  dxCreateTexture("files/5.dds"),
  dxCreateTexture("files/6.dds")
}
local sparkTexture = dxCreateTexture("files/spark.png")
function renderParticle(x, y, z, px, py, pz, ps, tex, u, v, us, vs, c)
  dxDrawMaterialSectionLine3D(px + x * ps, py + y * ps, pz + z * ps, px - x * ps, py - y * ps, pz - z * ps, u, v, us, vs, tex, ps, c)
end
function preRenderFireworks(delta)
  local x, y, z = getWorldFromScreenPosition(screenX / 2, 0, 128)
  local x2, y2, z2 = getWorldFromScreenPosition(screenX / 2, screenY / 2, 128)
  x = x2 - x
  y = y2 - y
  z = z2 - z
  local len = math.sqrt(x * x + y * y + z * z) * 2
  x = x / len
  y = y / len
  z = z / len
  local dMul = delta / 1000
  local genC = 0
  for i = #lights, 1, -1 do
    local dat = lights[i]
    if dat then
      local boost = 1
      if dat.boost then
        dat.boost[1] = dat.boost[1] - dat.boost[2] * dMul
        if 0 > dat.boost[1] then
          dat.boost = nil
        else
          boost = boost + dat.boost[1]
        end
      end
      local a = 1
      if dat.fadeOut then
        dat.fadeOut = dat.fadeOut - dMul
        if 1 > dat.fadeOut then
          a = dat.fadeOut
        end
      end
      local size = dat.size
      if dat.delay then
        dat.delay = dat.delay - delta
        if 0 > dat.delay then
          dat.delay = nil
        end
      end
      if dat.lightsToGen and 0 < dat.lightsToGen then
        local c = 0
        for i = 1, dat.lightsToGen do
          c = c + 1
          if dat.boomMode == "sparkle" then
            boomLightsSparkle2(1.5, 3, dat.texture, dat.genData)
          elseif dat.boomMode == "sparkleIn" then
            if dat.lightsToGen - c < dat.lightsToGenSec then
              boomLightsSparkleInside3(1.5, 3, dat.texture, dat.genData, i)
            else
              boomLightsSparkleInside2(1.5, 3, dat.texture, dat.genData)
            end
          else
            boomLights2(1.5, 3, dat.texture, dat.genData)
          end
          genC = genC + 1
          if 10 < genC then
            break
          end
        end
        dat.lightsToGen = dat.lightsToGen - c
      end
      if dat.boom and not dat.delay then
        dat.boom = dat.boom - delta
        if 0 >= dat.lightsToGen and 0 > dat.boom then
          a = -1
          if dat.boomMode == "sparkle" then
            boomLights(playBoom3, dat.pos[1], dat.pos[2], dat.pos[3], dat.genData)
          elseif dat.boomMode == "sparkleIn" then
            boomLights(playBoom2, dat.pos[1], dat.pos[2], dat.pos[3], dat.genData)
          else
            boomLights(playBoom, dat.pos[1], dat.pos[2], dat.pos[3], dat.genData)
          end
        end
      end
      if 0 < a and not dat.delay then
        dat.pos[1] = dat.pos[1] + dat.velocity[1] * dMul * boost
        dat.pos[2] = dat.pos[2] + dat.velocity[2] * dMul * boost
        dat.pos[3] = dat.pos[3] + dat.velocity[3] * dMul * boost - 1 / boost * dMul
        if dat.grow then
          dat.grow = dat.grow - dat.growSpeed * delta / 1000
          if 0 > dat.grow then
            dat.grow = false
          else
            size = size * (1 - dat.grow)
          end
        end
        if dat.tails then
          dat.lastTail = dat.lastTail - delta
          if 0 > dat.lastTail then
            table.insert(dat.tails, {
              dat.pos[1],
              dat.pos[2],
              dat.pos[3],
              size * 0.025,
              1
            })
            dat.lastTail = dat.tailTiming
          end
        end
      end
      if dat.tails then
        local lx, ly, lz = dat.pos[1], dat.pos[2], dat.pos[3]
        for j = #dat.tails, 1, -1 do
          dat.tails[j][5] = dat.tails[j][5] - dat.tailFadeOut * delta / 1000
          if 0 > dat.tails[j][5] then
            table.remove(dat.tails, j)
          else
            local x, y, z = dat.tails[j][1], dat.tails[j][2], dat.tails[j][3]
            dxDrawLine3D(x, y, z, lx, ly, lz, tocolor(dat.tailColor[1], dat.tailColor[2], dat.tailColor[3], 220 * dat.tails[j][5]), dat.tails[j][4] / 0.013333333333333334)
            lx, ly, lz = x, y, z
          end
        end
      end
      if dat.blink then
        a = a * math.random(50, 1000) / 1000
      end
      if a < 0 and (not dat.tails or 0 >= #dat.tails) then
        table.remove(lights, i)
      elseif 0 < a then
        renderParticle(x, y, z, dat.pos[1], dat.pos[2], dat.pos[3], size, lightTextures[dat.texture], 64 * dat.variant, 0, 64, 64, tocolor(dat.col[1], dat.col[2], dat.col[3], a * dat.col[4]))
      end
    else
      table.remove(lights, i)
    end
  end
end
addEventHandler("onClientPreRender", getRootElement(), preRenderFireworks)
