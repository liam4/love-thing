
local Backdrop = {}

function Backdrop:init (self)
  self.image = nil
end

function Backdrop:setImage (self, image)
  self.image = image
end

function Backdrop:draw (self)
  if self.image then
    love.graphics.draw(self.image, 0, 0)
  end
end

return Backdrop
