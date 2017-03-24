
local Dialog = {}

local fontFile = "font/Comfortaa-Regular.ttf"
local speechFont = love.graphics.newFont(fontFile, 32)
local labelFont = love.graphics.newFont(fontFile, 24)

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
  love.graphics.setFont(speechFont)
  love.graphics.print(self.displayText, 40, top + 40)

  if self.actor then
    local labelWidth = 240
    local labelHeight = 40
    local labelTop = top - labelHeight
    local labelLeft = 0

    love.graphics.stencil(function ()
      love.graphics.rectangle("fill",
        labelLeft, labelTop, labelWidth, labelHeight)
    end)

    love.graphics.setStencilTest("greater", 0)

    local color = self.actor.color
    love.graphics.setColor(color[1], color[2], color[3], 200)
    love.graphics.rectangle("fill",
      labelLeft, labelTop, labelWidth, labelHeight)

    love.graphics.setColor(255, 255, 255)
    love.graphics.setFont(labelFont)
    love.graphics.print(self.actor.name, labelLeft + 20, top - 33)

    love.graphics.setStencilTest()
  end
end

return Dialog
