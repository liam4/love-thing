
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
  median:setPosition(median, -120, 40)

  beleth = util:construct(Actor)
  beleth:setName(beleth, 'Beleth')
  beleth:setColor(beleth, 210, 46, 130)
  beleth:setPosition(beleth, 0, 40)

  dialog = util:construct(Dialog)
  dialog:setText(dialog, "Okay..now what?")

  timeline = util:construct(Timeline)
  timeline:setEvents(timeline, {
    Events:group{
      Events:pose{actor=beleth, file='image/beleth1.png'},
      Events:pose{actor=median, file='image/median1a.png'},
      Events:show{actor=median},
      Events:dialog{actor=median, dialog=dialog, text='Hello..?'}
    },
    Events:group{
      Events:pose{actor=median, file='image/median1.png'},
      Events:dialog{actor=median, dialog=dialog, text='Nobody\'s home..'}
    },
    Events:group{
      Events:hide{actor=median},
      Events:hideDialog{dialog=dialog},
      Events:waitForInput()
    },
    Events:group{
      Events:show{actor=beleth},
      Events:dialog{actor=beleth, dialog=dialog, text='Wait, what?'}
    },
    Events:group{
      Events:pose{actor=beleth, file='image/beleth1c.png'},
      Events:dialog{actor=beleth, dialog=dialog, text='What was that..?'}
    }
  })
end

function love.update()
  timeline:update(timeline)
end

function love.draw()
  median:draw(median)
  beleth:draw(beleth)
  dialog:draw(dialog)
end

function love.keypressed (key)
  -- Pressing the escape key should toggle the cursor visibility.
  if key == "escape" then
    local state = not love.mouse.isVisible()
    love.mouse.setVisible(state)
    return
  end

  -- Pressing the left arrow key should go back in history.
  if key == "left" then
    timeline:scheduleBack(timeline)
  end

  timeline:gotKeypressed(timeline, key)
end
