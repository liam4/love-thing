
local util = require 'util'
local Actor = require 'actor'
local Backdrop = require 'backdrop'
local Dialog = require 'dialog'
local Events = require 'timeline-events'
local Jukebox = require 'jukebox'
local Timeline = require 'event-timeline'

function love.load()
  jukebox = util:construct(Jukebox)
  jukebox:setFile('sound/andre_4.mp3')
  jukebox:play()

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
      Events:setBackdrop{backdrop=backdrop, file='image/trebolbgs4a.png'},
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
    },
    Events:group{
      Events:pose{actor=median, file='image/median2.png'},
      Events:hide{actor=beleth},
      Events:show{actor=median},
      Events:setBackdrop{backdrop=backdrop, file='image/trebolbgs4b.png'},
      Events:dialog{actor=median, dialog=dialog, text='Where could they have gotten to..?'}
    }
  })
end

function love.update()
  timeline:update()
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
