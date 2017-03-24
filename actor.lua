
local Actor = {}

function Actor:init (self)
  self:setPosition(self, 0, 0)
  self:setColor(self, 128, 128, 128)
  self:setName(self, 'Unnamed Actor')

  self.visible = false

  self.oldPose = nil
  self.oldPoseX = 0
  self.oldPoseGhost = 0
  self.visibilityGhost = 0
  self.visibilityOffsetX = 0
end

function Actor:setPosition (self, x, y)
  -- The position that the actor image is drawn on the screen.
  self.x = x
  self.y = y
end

function Actor:setPose (self, image)
  -- The actor image that is drawn to the screen.

  if self.visible then
    self.oldPose = self.pose
    self.oldPoseX = 0
    self.newPoseX = 120
    self.oldPoseGhost = 0
  end

  self.pose = image
end

function Actor:setColor (self, r, g, b)
  -- The color that represents the actor in dialog boxes and such.

  self.color = { r, g, b }
end

function Actor:setName (self, name)
  -- The name that represents the actor. Human-readable, obviously.

  self.name = name
end

function Actor:show (self)
  self.visible = true
  self.visibilityOffsetX = -80
  self.visibilityGhost = 0
end

function Actor:hide (self)
  self.visible = false
  self.visibilityOffsetX = 0
  self.visibilityGhost = 1
end

function Actor:setVisible (self, visible)
  if visible then
    self:show(self)
  else
    self:hide(self)
  end
end

function Actor:draw (self)
  local mainX = self.x
  local mainGhost = 1

  if self.oldPose then
    local ghost = self.oldPoseGhost

    love.graphics.setColor(255, 255, 255, 255 * (1 - ghost))
    love.graphics.draw(self.oldPose, self.x + self.oldPoseX, self.y)

    mainX = mainX + self.newPoseX
    mainGhost = mainGhost * ghost

    love.graphics.setColor(255, 255, 255)
  end

  mainGhost = mainGhost * self.visibilityGhost
  mainX = mainX + self.visibilityOffsetX

  if self.pose then
    love.graphics.setColor(255, 255, 255, 255 * mainGhost)
    love.graphics.draw(self.pose, mainX, self.y)
  end

  if self.oldPose then
    self.oldPoseX = self.oldPoseX + 0.05 * (-180 - self.oldPoseX)
    self.newPoseX = self.newPoseX + 0.4 * (0 - self.newPoseX)
    self.oldPoseGhost = self.oldPoseGhost + 0.1

    if self.oldPoseGhost >= 1 then
      self.oldPose = nil
    end
  end

  if self.visible then
    if self.visibilityGhost < 1 then
      local delta = 0 - self.visibilityOffsetX
      self.visibilityOffsetX = self.visibilityOffsetX + 0.4 * delta
      self.visibilityGhost = self.visibilityGhost + 0.1
    end
  else
    if self.visibilityGhost > 0 then
      local delta = -60 - self.visibilityOffsetX
      self.visibilityOffsetX = self.visibilityOffsetX + 0.4 * delta
      self.visibilityGhost = self.visibilityGhost - 0.1
    end
  end
end

return Actor
