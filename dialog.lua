
local Dialog = {}

function Dialog:init (self)
  self.text = ""
  self.displayText = ""
  self.index = 0
  self.isDone = true
  self.actor = nil
end

function Dialog:setText (self, text)
  self.text = text
  self.displayText = ""
  self.index = 0
  self.isDone = false
end

function Dialog:setActor (self, actor)
  self.actor = actor
end

function Dialog:update (self)
  if self.index <= string.len(self.text) then
    self.displayText = (self.displayText ..
      string.sub(self.text, self.index, self.index))
    self.index = self.index + 1
  else
    self.isDone = true
  end
end

function Dialog:draw (self)
  local height = 180
  local top = love.graphics.getHeight() - height
  local width = love.graphics.getWidth()

  if self.actor then
    local color = self.actor.color
    love.graphics.setColor(color[1], color[2], color[3], 128)
  else
    love.graphics.setColor(0, 0, 0, 128)
  end

  love.graphics.rectangle("fill", 0, top, width, height)
  love.graphics.line(0, top, width, top)

  love.graphics.setColor(255, 255, 255)
  love.graphics.print(self.displayText, 40, top + 40)
end

return Dialog
