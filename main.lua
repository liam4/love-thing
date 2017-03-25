
local util = require 'util'
local Actor = require 'actor'
local Backdrop = require 'backdrop'
local Dialog = require 'dialog'
local Events = require 'timeline-events'
local Jukebox = require 'jukebox'
local Timeline = require 'event-timeline'

function love.load()
  jukebox = util:construct(Jukebox)

  love.window.setMode(1024, 800)
  love.mouse.setVisible(false)
  love.graphics.setNewFont("font/Comfortaa-Regular.ttf", 30)

  dialog = util:construct(Dialog)

  backdrop = util:construct(Backdrop)

  median = util:construct(Actor)
  median:setName('Median')
  median:setColor(132, 9, 93)
  median:setPosition(-120, 40)

  beleth = util:construct(Actor)
  beleth:setName('Beleth')
  beleth:setColor(210, 46, 130)
  beleth:setPosition(0, 30)

  timeline = util:construct(Timeline)
  timeline:setEvents({
    Events:group{
      Events:setMusic(jukebox, 'sound/andre_4.mp3'),
      Events:setBackdrop(backdrop, 'image/trebolbgs4a.png'),
      Events:poseActor(beleth, 'image/beleth1.png'),
      Events:poseActor(median, 'image/median1a.png'),
      Events:showActor(median),
      Events:speak(median, dialog, 'Hello..?')
    },
    Events:group{
      Events:poseActor(median, 'image/median1.png'),
      Events:speak(median, dialog, 'Nobody\'s home..')
    },
    Events:group{
      Events:hideActor(median),
      Events:hideDialog(dialog),
      Events:waitForInput()
    },
    Events:group{
      Events:showActor(beleth),
      Events:speak(beleth, dialog, 'Wait, what?')
    },
    Events:group{
      Events:poseActor(beleth, 'image/beleth1c.png'),
      Events:speak(beleth, dialog, 'What was that..?')
    },
    Events:group{
      Events:poseActor(median, 'image/median2.png'),
      Events:hideActor(beleth),
      Events:showActor(median),
      Events:setBackdrop(backdrop, 'image/trebolbgs4b.png'),
      Events:setMusic(jukebox, 'sound/sleepy_med.mp3'),
      Events:speak(median, dialog, 'Where could they have gotten to..?')
    }
  })
end

function love.update()
  timeline:update()
  jukebox:update()
end

function love.draw()
  backdrop:draw()
  median:draw()
  beleth:draw()
  dialog:draw()
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
    timeline:scheduleBack()
  end

  timeline:gotKeypressed(key)
end
