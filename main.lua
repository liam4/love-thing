
local util = require 'util'
local Actor = require 'actor'
local Backdrop = require 'backdrop'
local Dialog = require 'dialog'
local Events = require 'timeline-events'
local Jukebox = require 'jukebox'
local Timeline = require 'event-timeline'

function love.load ()
  jukebox = util:construct(Jukebox)

  love.window.setMode(1024, 800)
  love.mouse.setVisible(false)

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

  opaopa = util:construct(Actor)
  opaopa:setName('Opa-Opa')
  opaopa:setColor(190, 190, 190)
  opaopa:setPosition(-40, 100)

  gorfzorf = util:construct(Actor)
  gorfzorf:setName('Gorfzorf')
  gorfzorf:setColor(145, 145, 145)

  timeline = util:construct(Timeline)
  timeline:setEvents({
    Events:group{
      Events:setMusic(jukebox, 'sound/egg_atmosphere.mp3'),
      Events:setBackdrop(backdrop, 'image/oh dear.jpg'),
      Events:poseActor(beleth, 'image/beleth1.png'),
      Events:poseActor(median, 'image/median1a.png'),
      Events:showActor(median),
      Events:speak(median, dialog, 'Hello..?')
    },
    Events:group{
      Events:poseActor(median, 'image/median1.png'),
      Events:poseActor(opaopa, 'image/opaopa2-2.png'),
      Events:showActor(opaopa),
      Events:speak(opaopa, dialog, '...')
    },
    Events:speak(median, dialog, '...'),
    Events:group{
      Events:poseActor(opaopa, 'image/opaopa4-2.png'),
      Events:speak(opaopa, dialog, '...')
    },
    Events:speak(median, dialog, '...'),
    Events:group{
      Events:poseActor(opaopa, 'image/opaopa2-2.png'),
      Events:speak(opaopa, dialog, 'Wow, I just realized that writing dialogue for a real person\nis actually sort of weird.')
    },
    Events:speak(opaopa, dialog, 'I don\'t know if it\'s actually possible to do this in a\nrespectful way.'),
    Events:group{
      Events:poseActor(median, 'image/median2.png'),
      Events:speak(median, dialog, 'It\'s a good thing you\'ve said that before, then.')
    },
    Events:group{
      Events:poseActor(median, 'image/median1.png'),
      Events:poseActor(opaopa, 'image/opaopa4-2.png'),
      Events:speak(opaopa, dialog, '...')
    },
    Events:speak(median, dialog, '...'),
    Events:group{
      Events:poseActor(opaopa, 'image/opaopa2-2.png'),
      Events:poseActor(median, 'image/median5.png'),
      Events:setBackdrop(backdrop, 'image/trebolbgs4a.png'),
      Events:speak(opaopa, dialog, 'tweeting from a broom closet')
    },
    Events:speak(median, dialog, '...what.'),
    Events:group{
      Events:poseActor(opaopa, 'image/opaopa2-2.png'),
      Events:setBackdrop(backdrop, 'image/oh dear.jpg'),
      Events:speak(opaopa, dialog, 'RT/Like if you want Opa-Opa to be your demon!')
    },
    Events:group{
      Events:poseActor(opaopa, 'image/opaopa2-2.png'),
      Events:speak(opaopa, dialog, 'Floraverse\'s plot follows the Beleth twins, Red & White, who\nget yelled at by their boss Jupupet, their dad Andrew,\nand their mom Amadehorse')
    },
    Events:group{
      Events:poseActor(gorfzorf, 'image/gorfzorf-2.png'),
      Events:showActor(gorfzorf),
      Events:hideActor(median),
      Events:speak(gorfzorf, dialog, 'OPA NO')
    },
    Events:group{
      Events:poseActor(opaopa, 'image/opaopa2-2.png'),
      Events:speak(opaopa, dialog, 'I DON\'T KNOW WHAT\'S WRONG WITH ME TODAY')
    },
    Events:speak(gorfzorf, dialog, 'more like something\'s HORRIBLY RIGHT--'),
    Events:group{
      Events:hideActor(opaopa),
      Events:hideActor(gorfzorf),
      Events:showActor(median),
      Events:showActor(beleth),
      Events:poseActor(median, 'image/median2.png'),
      Events:poseActor(beleth, 'image/beleth1.png'),
      Events:speak(beleth, dialog, 'What\'s going on here..?')
    },
    Events:group{
      Events:poseActor(median, 'image/median4.png'),
      Events:speak(median, dialog, 'This mole is tweeting dumb jokes.')
    },
    Events:group{
      Events:poseActor(median, 'image/median1.png'),
      Events:poseActor(beleth, 'image/beleth1b.png'),
      Events:speak(median, dialog, 'It\'s also cheating while simultaneously dropping sick burns.'),
    },
    Events:group{
      Events:hideActor(beleth),
      Events:showActor(opaopa),
      Events:poseActor(opaopa, 'image/opaopa1-2.png'),
      Events:speak(opaopa, dialog, 'In my dreams, I am Shadow the Hedgehog\'s Shadow\nthe Hedgehog.')
    },
    Events:speak(opaopa, dialog, 'I look to the right, and see Shadow the Hedgehog.'),
    Events:group{
      Events:poseActor(median, 'image/median2.png'),
      Events:speak(opaopa, dialog, 'And to his right, his Shadow the Hedgehog')
    },
    Events:speak(opaopa, dialog, 'And so on, onto infinity'),
    Events:group{
      Events:poseActor(opaopa, 'image/opaopa4-2.png'),
      Events:speak(opaopa, dialog, 'Infinite Shadow the Hedgehogs sprawling away\ninto the incomprehensible distance')
    },
    Events:speak(median, dialog, '...'),
    Events:group{
      Events:poseActor(opaopa, 'image/opaopa4-2.png'),
      Events:speak(opaopa, dialog, 'Red Beleth... is White Beleth\'s Shadow the Hedgehog.')
    },
    Events:group{
      Events:poseActor(median, 'image/median4.png'),
      Events:poseActor(beleth, 'image/beleth1c.png'),
      Events:showActor(beleth),
      Events:hideActor(opaopa),
      Events:speak(beleth, dialog, 'What\'s he on to..?')
    },
    Events:group{
      Events:hideActor(beleth),
      Events:showActor(opaopa),
      Events:poseActor(opaopa, 'image/opaopa5-2.png'),
      Events:poseActor(median, 'image/median5.png'),
      Events:speak(opaopa, dialog, '*with four in my mouth at once*\n"eeaa iee laaaer, shoo soom sel-cohntrul"')
    }
    -- Events:group{
    --   Events:poseActor(median, 'image/median1.png'),
    --   Events:speak(median, dialog, 'Nobody\'s home..')
    -- },
    -- Events:group{
    --   Events:hideActor(median),
    --   Events:hideDialog(dialog),
    --   Events:waitForInput()
    -- },
    -- Events:group{
    --   Events:showActor(beleth),
    --   Events:speak(beleth, dialog, 'Wait, what?')
    -- },
    -- Events:group{
    --   Events:poseActor(beleth, 'image/beleth1c.png'),
    --   Events:speak(beleth, dialog, 'What was that..?')
    -- },
    -- Events:group{
    --   Events:poseActor(median, 'image/median2.png'),
    --   Events:hideActor(beleth),
    --   Events:showActor(median),
    --   Events:setBackdrop(backdrop, 'image/trebolbgs4b.png'),
    --   Events:setMusic(jukebox, 'sound/sleepy_med.mp3'),
    --   Events:speak(median, dialog, 'Where could they have gotten to..?')
    -- }
  })
end

function love.update ()
  timeline:update()
  jukebox:update()
end

function love.draw ()
  backdrop:draw()
  median:draw()
  beleth:draw()
  opaopa:draw()
  gorfzorf:draw()
  dialog:draw()
end

function love.keypressed (key)
  -- Pressing the escape key should toggle the cursor visibility.
  if key == 'escape' then
    local state = not love.mouse.isVisible()
    love.mouse.setVisible(state)
    return
  end

  -- Pressing the left arrow key should go back in history.
  if key == 'left' then
    timeline:scheduleBack()
  end

  timeline:gotKeypressed(key)
end
