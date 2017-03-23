
local Dialog = {}

function Dialog:new (o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o, self:init(o)
end

function Dialog:init (self)
  self.text = ""
  self.displayText = ""
  self.index = 0
end

function Dialog:setText (self, text)
  self.text = text
  self.index = 0
end

function Dialog:update (self)
  if self.index <= string.len(self.text) then
    self.displayText = (self.displayText ..
      string.sub(self.text, self.index, self.index))
    self.index = self.index + 1
  end
end

function Dialog:draw (self)
  local height = 180
  local top = love.graphics.getHeight() - height
  local width = love.graphics.getWidth()

  love.graphics.setColor(128, 40, 128, 128)
  love.graphics.rectangle("fill", 0, top, width, height)
  love.graphics.line(0, top, width, top)

  love.graphics.setColor(255, 255, 255)
  love.graphics.print(self.displayText, 40, top + 40)
end

return Dialog
