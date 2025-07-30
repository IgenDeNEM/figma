local classInstance
CoreClassC = {}
function CoreClassC:constructor()
  self.screenWidth, self.screenHeight = guiGetScreenSize()
  self.screenSource = dxCreateScreenSource(self.screenWidth, self.screenHeight)
  self.waterNormal = dxCreateTexture("res/textures/waterNormal.png")
  self.waterDrop = dxCreateTexture("res/textures/waterDrop.png")
  self.wetSurfaceShader = dxCreateShader("res/shaders/waterEffects.fx")
  self.player = getLocalPlayer()
  self.element = nil
  self.effectIsStarted = "false"
  self.maxWetValue = 56
  self.wetValue = 0
  self.wetType = 1
  if not (self.screenSource and self.waterNormal and self.waterDrop) or not self.wetSurfaceShader then
  end
  self.m_Update = bind(self.update, self)
  addEventHandler("onClientRender", root, self.m_Update)
end
function CoreClassC:update()
  if self.screenSource and self.waterNormal and self.waterDrop and self.wetSurfaceShader and self.player then
    self.vehicle = self.player:getOccupiedVehicle()
    if self.vehicle then
      self.element = self.vehicle
      if self.vehicle:getVehicleType() == "Boat" then
        self:setWetLevel(self.maxWetValue * 0.5, 1)
      end
    else
      self.element = self.player
    end
    if self.element and isElement(self.element) then
      if getRainLevel() <= 0 then
        if self.element:isInWater() == true then
          self.effectIsStarted = "true"
        elseif self.effectIsStarted == "true" then
          self:setWetLevel(self.maxWetValue * 1, 2)
          self.effectIsStarted = "false"
        end
      else
        local wetValue = getRainLevel()
        self:setWetLevel(self.maxWetValue * getRainLevel(), 1)
      end
    end
    self.wetValue = self.wetValue - 0.5
    if 0 < self.wetValue then
      self.screenSource:update(true)
    end
    self.wetSurfaceShader:setValue("screenSource", self.screenSource)
    self.wetSurfaceShader:setValue("waterNormal", self.waterNormal)
    self.wetSurfaceShader:setValue("waterDrop", self.waterDrop)
    self.wetSurfaceShader:setValue("wetValue", self.wetValue)
    self.wetSurfaceShader:setValue("wetType", self.wetType)
    if 0 > self.wetValue then
      self.wetValue = 0
    end
    if 0 < self.wetValue then
      dxDrawImage(0, 0, self.screenWidth, self.screenHeight, self.wetSurfaceShader)
    end
  end
end
function CoreClassC:setWetLevel(amount, wetType)
  if amount and wetType then
    self.wetValue = amount
    self.wetType = wetType
  end
end
function CoreClassC:destructor()
  removeEventHandler("onClientRender", root, self.m_Update)
  if self.screenSource then
    self.screenSource:destroy()
    self.screenSource = nil
  end
  if self.waterNormal then
    self.waterNormal:destroy()
    self.waterNormal = nil
  end
  if self.waterDrop then
    self.waterDrop:destroy()
    self.waterDrop = nil
  end
  if self.wetSurfaceShader then
    self.wetSurfaceShader:destroy()
    self.wetSurfaceShader = nil
  end
end
function createWaterEffect()
  classInstance = new(CoreClassC)
end
function destroyWaterEffect()
  if classInstance then
    delete(classInstance)
    classInstance = nil
  end
end
local stored = false
function setWaterEffectState(state)
  if state ~= stored then
    stored = state
    if state then
      createWaterEffect()
    else
      destroyWaterEffect()
    end
  end
end
function getWaterEffectState()
  return stored
end
