
local util = require 'util'
local Actor = require 'actor'
local Dialog = require 'dialog'
local Timeline = require 'event-timeline'
local Events = require 'timeline-events'

function love.load()
  love.window.setMode(1024, 800)
  love.mouse.setVisible(false)
  love.graphics.setNewFont("font/Comfortaa-Regular.ttf", 30)

  median = util:construct(Actor)
  median:setName(median, 'Median')
  median:setColor(median, 132, 9, 93)

  dialog = util:construct(Dialog)
  dialog:setText(dialog, "Okay..now what?")

  timeline = util:construct(Timeline)
  timeline:setEvents(timeline, {
    Events:pose{actor=median, file='image/median1a.png'},
    Events:dialog{actor=median, dialog=dialog, text='Hello..?'},
    Events:pose{actor=median, file='image/median1.png'},
    Events:dialog{actor=median, dialog=dialog, text='Nobody\'s home..'}
  })
end

function love.update()
  timeline:update(timeline)
end

function love.draw()
  median:draw(median)
  dialog:draw(dialog)
end

function love.keypressed (key)
  -- Pressing the escape key should toggle the cursor visibility.
  if key == "escape" then
    local state = not love.mouse.isVisible()
    love.mouse.setVisible(state)
  end

  timeline:gotKeypressed(timeline, key)
end
