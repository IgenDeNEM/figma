Phase = {}
Phase.__index = Phase
Animation = setmetatable({}, {__index = Phase})
Animation.__index = Animation
Animation.collection = {}
function Animation.create(elem, ...)
  local anim = setmetatable({
    elem = elem,
    ...
  }, Animation)
  anim:_setup()
  return anim
end
function Animation.createAndPlay(elem, ...)
  local anim = Animation.create(elem, ...)
  anim:play()
  return anim
end
function Animation.createNamed(name, elem, ...)
  local anim = Animation.getNamed(name) or Animation.create(elem, ...)
  anim.name = name
  return anim
end
function Animation.createNamedAndPlay(name, elem, ...)
  local anim = Animation.createNamed(name, elem, ...)
  anim:play()
  return anim
end
function Animation.getNamed(name)
  local i, anim = table.find(Animation.collection, "name", name)
  return i and anim
end
function Animation:isPlaying()
  return self.playing or false
end
function Animation.playingAnimationsExist()
  return table.find(Animation.collection, "playing", true) and true
end
function Animation:play()
  if self.playing then
    return
  end
  if not table.find(Animation.collection, self) then
    table.insert(Animation.collection, self)
  end
  if not Animation.playingAnimationsExist() then
    addEventHandler("onClientRender", getRootElement(), updateAnim)
  end
  self.playing = true
end
function Animation:pause()
  self.playing = false
  if not Animation.playingAnimationsExist() then
    removeEventHandler("onClientRender", getRootElement(), updateAnim)
  end
end
function Animation:remove()
  table.removevalue(Animation.collection, self)
  if not Animation.playingAnimationsExist() then
    removeEventHandler("onClientRender", getRootElement(), updateAnim)
  end
  self.playing = false
end
function Phase:_setup(parent)
  self.parent = parent
  if self[1] then
    for i, phase in ipairs(self) do
      if type(phase) == "function" then
        phase = {fn = phase}
        self[i] = phase
      end
      setmetatable(phase, Phase)
      phase:_setup(self)
    end
    self.curphase = 1
  elseif self.time then
    self.from = self.from or 0
    self.to = self.to or 1
    self.speed = (self.to - self.from) / self.time
  end
  self.repeats = self.repeats or 1
  self.currepeat = 1
end
function Phase:addPhase(phase)
  setmetatable(phase, Phase)
  self[#self + 1] = phase
  if #self == 1 then
    self.curphase = 1
  end
  phase:_setup(self)
end
function Phase:addPhases(...)
  for i, phase in ipairs({
    ...
  }) do
    self:addPhase(phase)
  end
end
function updateAnim()
  local elem, phase
  local curTick = getTickCount()
  local phaseEnded
  for i, anim in ipairs(Animation.collection) do
    if anim.playing then
      phase = anim
      while phase.curphase do
        if phase.elem then
          elem = phase.elem
        end
        phase = phase[phase.curphase]
      end
      phaseEnded = false
      if type(elem) == "userdata" and not isElement(elem) then
        anim:remove()
        phaseEnded = true
      elseif not phase.time then
        phase.fn(elem, phase)
        phaseEnded = true
      else
        if not phase.starttick then
          phase.starttick = curTick
        end
        phase.prevpassed = phase.passed
        phase.passed = (curTick - phase.starttick) % phase.time
        if phase.prevpassed and phase.passed < phase.prevpassed then
          phase.currepeat = phase.currepeat + 1
          phaseEnded = phase.repeats > 0 and phase.currepeat > phase.repeats
        end
      end
      if phaseEnded then
        repeat
          phase.currepeat = 1
          phase.starttick = nil
          phase.passed = nil
          phase = phase.parent
          phase.curphase = phase.curphase + 1
          if phase.curphase > #phase then
            phase.curphase = 1
            phase.currepeat = phase.currepeat + 1
            if phase.repeats == 0 or phase.currepeat <= phase.repeats then
              do break end
              else
                break
              end
            end
        until phase == anim
        if phase == anim and phase.currepeat > phase.repeats then
          anim:remove()
          anim = false
        else
          phase = phase[phase.curphase]
          if not phase.time then
            anim = false
          elseif not phase.passed then
            phase.passed = 0
          end
        end
      end
      if anim and phase.fn then
        phase.value = phase.from + phase.speed * phase.passed
        if elem then
          phase.fn(elem, phase.transform and phase.transform(phase.value) or phase.value, phase)
        else
          phase.fn(phase.transform and phase.transform(phase.value) or phase.value, phase)
        end
      end
    end
  end
end
function table.find(t, ...)
  local args = {
    ...
  }
  if #args == 0 then
    for k, v in pairs(t) do
      if v then
        return k, v
      end
    end
    return false
  end
  local value = table.remove(args)
  if value == "[nil]" then
    value = nil
  end
  for k, v in pairs(t) do
    for i, index in ipairs(args) do
      if type(index) == "function" then
        v = index(v)
      else
        if index == "[last]" then
          index = #v
        end
        v = v[index]
      end
    end
    if v == value then
      return k, t[k]
    end
  end
  return false
end
function table.removevalue(t, val)
  for i, v in ipairs(t) do
    if v == val then
      table.remove(t, i)
      return i
    end
  end
  return false
end
Animation.presets = {}
function Animation.presets.guiPulse(time, value, phase)
  if type(time) ~= "userdata" then
    return {
      from = 0,
      to = 2 * math.pi,
      transform = math.sin,
      time = time,
      repeats = 0,
      fn = Animation.presets.guiPulse
    }
  else
    local elem = time
    if not phase.width then
      phase.width, phase.height = guiGetSize(elem, false)
      phase.centerX, phase.centerY = guiGetPosition(elem, false)
      phase.centerX = phase.centerX + math.floor(phase.width / 2)
      phase.centerY = phase.centerY + math.floor(phase.height / 2)
    end
    local pct = 1 - (value + 1) * 0.1
    local width = pct * phase.width
    local height = pct * phase.height
    local x = phase.centerX - math.floor(width / 2)
    local y = phase.centerY - math.floor(height / 2)
    guiSetPosition(elem, x, y, false)
    guiSetSize(elem, width, height, false)
  end
end
function Animation.presets.guiFadeIn(time)
  return {
    from = 0,
    to = 1,
    time = time or 1000,
    fn = guiSetAlpha
  }
end
function Animation.presets.guiFadeOut(time)
  return {
    from = 1,
    to = 0,
    time = time or 1000,
    fn = guiSetAlpha
  }
end
function Animation.presets.guiMove(endX, endY, time, loop, startX, startY, speedUpSlowDown)
  if type(endX) ~= "userdata" then
    return {
      from = speedUpSlowDown and -math.pi / 2 or 0,
      to = speedUpSlowDown and math.pi / 2 or 1,
      time = time or 1000,
      repeats = loop and 0 or 1,
      fn = Animation.presets.guiMove,
      startX = startX,
      startY = startY,
      endX = endX,
      endY = endY,
      speedUpSlowDown = speedUpSlowDown
    }
  else
    local elem, value, phase = endX, endY, time
    if phase.speedUpSlowDown then
      value = (value + 1) / 2
    end
    if not phase.startX then
      phase.startX, phase.startY = guiGetPosition(elem, false)
    end
    guiSetPosition(elem, phase.startX + (phase.endX - phase.startX) * value, phase.startY + (phase.endY - phase.startY) * value, false)
  end
end
function Animation.presets.guiMoveResize(endX, endY, endWidth, endHeight, time, loop, startX, startY, startWidth, startHeight, speedUpSlowDown)
  if type(endX) ~= "userdata" then
    return {
      from = speedUpSlowDown and -math.pi / 2 or 0,
      to = speedUpSlowDown and math.pi / 2 or 1,
      time = time or 1000,
      repeats = loop and 0 or 1,
      transform = math.sin,
      fn = Animation.presets.guiMoveResize,
      startX = startX,
      startY = startY,
      startWidth = startWidth,
      startHeight = startHeight,
      endX = endX,
      endY = endY,
      endWidth = endWidth,
      endHeight = endHeight,
      speedUpSlowDown = speedUpSlowDown
    }
  else
    local elem, value, phase = endX, endY, endWidth
    if phase.speedUpSlowDown then
      value = (value + 1) / 2
    end
    if not phase.startX then
      phase.startX, phase.startY = guiGetPosition(elem, false)
      phase.startWidth, phase.startHeight = guiGetSize(elem, false)
    end
    guiSetPosition(elem, math.floor(phase.startX + value * (phase.endX - phase.startX)), math.floor(phase.startY + value * (phase.endY - phase.startY)), false)
    guiSetSize(elem, math.floor(phase.startWidth + value * (phase.endWidth - phase.startWidth)), math.floor(phase.startHeight + value * (phase.endHeight - phase.startHeight)), false)
  end
end
