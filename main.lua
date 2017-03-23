
local Actor = require 'actor'
local Dialog = require 'dialog'

function love.load()
  love.window.setMode(1024, 800)
  love.graphics.setNewFont("font/Comfortaa-Regular.ttf", 30)

  dialog = Dialog:new()
  dialog:setText(dialog, "Okay..now what?")

  avjoe = Actor:new()
  avjoe:setPose(avjoe, love.graphics.newImage("image/avjoe1.png"))
end

function love.update()
  dialog:update(dialog)
end

function love.draw()
  avjoe:draw(avjoe)
  dialog:draw(dialog)
end

function love.mousepressed()
  n = math.ceil(math.random() * 4)

  avjoe:setPose(avjoe, love.graphics.newImage("image/avjoe" .. n .. ".png"))
end
