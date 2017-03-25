
local Backdrop = {}

function Backdrop:init (self)
  self.image = nil
end

function Backdrop:setImage (image)
  self.image = image
end

function Backdrop:draw ()
  if self.image then
    love.graphics.draw(self.image, 0, 0)
  end
end

return Backdrop
