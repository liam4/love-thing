
local Events = {}

Events.template = {}

function Events.template:run ()
  --[[

    Called when the event is run, regardless of progression-direction.
    (That is, if going backwards and ending up on this event, the run method
    will still be called.)

  ]]
end

function Events.template:runForwards ()
  --[[

    Called when the event is run, but only if we ended up on this event by
    going forwards. Generally, state-changing should happen here.

    This is called before run.

  ]]
end

function Events.template:runBackwards ()
  --[[

    Called when the event is run, but only if we ended up on this event by
    going backwards.

    This is called before run.

  ]]
end

function Events.template:restore ()
  --[[

    Called when we're going back FROM this event. State should be restored
    here.

  ]]
end

function Events.template:update ()
  --[[

    Called on every LÖVE update. If this returns false, the event will be
    considered not done, and the timeline will not continue to the next event.

  ]]

  return true
end

function Events.template:gotKeypressed (key, scancode, isRepeat)
  --[[

    Called when the LÖVE window gets keyboard data.

  ]]
end

function Events:createTemplateEvent ()
  local event = {}

  function get (table, key)
    return Events.template[key]
  end

  setmetatable(event, {__index = get})

  return event
end

function Events:waitFrames (frames)
  --[[

    Quick example event that waits for a number of frames to be finished
    before continuing.

  ]]

  local event = Events:createTemplateEvent()

  local framesToWait = 0

  function event:run ()
    framesToWait = frames
  end

  function event:update ()
    if framesToWait <= 0 then
      return true
    else
      framesToWait = framesToWait - 1
      return false
    end
  end

  return event
end

function Events:waitForInput ()
  --[[

    Example event that waits for the user to input a key from the keyboard
    before continuing.

  ]]

  local event = Events:createTemplateEvent()

  local gotInput = false

  function event:run ()
    gotInput = false
  end

  function event:update ()
    return gotInput
  end

  function event:gotKeypressed ()
    gotInput = true
  end

  return event
end

function Events:group (events)
  --[[

    Groups functions together so that they can all be treated as a single
    event in the history stack.

  ]]

  local event = Events:createTemplateEvent()

  function event:run ()
    for count = 1, #events do
      events[count]:run()
    end
  end

  function event:runForwards ()
    for count = 1, #events do
      events[count]:runForwards()
    end
  end

  function event:runBackwards ()
    for count = 1, #events do
      events[count]:runBackwards()
    end
  end

  function event:restore ()
    for count = 1, #events do
      events[count]:restore()
    end
  end

  function event:gotKeypressed (...)
    for count = 1, #events do
      events[count]:gotKeypressed(...)
    end
  end

  function event:update ()
    local allDone = true

    for count = 1, #events do
      if not events[count]:update() then
        allDone = false
      end
    end

    return allDone
  end

  return event
end

function Events:speak (actor, dialog, text)
  local event = Events:createTemplateEvent()

  local gotContinue = false

  function event:run ()
    gotContinue = false
    dialog:setText(text)

    if actor then
      dialog:setActor(actor)
    else
      dialog:setActor(nil)
    end
  end

  function event:update ()
    if not dialog.isDone then
      dialog:update()
    end

    return dialog.isDone and gotContinue
  end

  function event:gotKeypressed (key)
    if key == 'space' then
      gotContinue = true
    end
  end

  return event
end

function Events:poseActor (actor, file)
  local oldPose = nil

  local event = Events:createTemplateEvent()

  function event:runForwards ()
    oldPose = actor.pose
    actor:setPose(love.graphics.newImage(file))
  end

  function event:restore ()
    actor:setPose(oldPose)
  end

  return event
end

function Events:showActor (actor)
  local wasVisible = nil

  local event = Events:createTemplateEvent()

  function event:runForwards ()
    wasVisible = actor.visible
    actor:show()
  end

  function event:restore ()
    actor:setVisible(wasVisible)
  end

  return event
end

function Events:hideActor (actor)
  local wasVisible = nil

  local event = Events:createTemplateEvent()

  function event:runForwards ()
    wasVisible = actor.visible
    actor:hide()
  end

  function event:restore ()
    actor:setVisible(wasVisible)
  end

  return event
end

function Events:hideDialog (dialog)
  local event = Events:createTemplateEvent()

  function event:run ()
    dialog:hide()
  end

  return event
end

function Events:setBackdrop (backdrop, file)
  local event = Events:createTemplateEvent()

  local oldImage = nil

  function event:runForwards ()
    oldImage = backdrop.image

    backdrop:setImage(love.graphics.newImage(file))
  end

  function event:restore ()
    backdrop:setImage(oldImage)
  end

  return event
end

function Events:fadeSetMusic (jukebox, file)
  local event = Events:createTemplateEvent()

  local oldFile = nil

  function event:runForwards ()
    oldFile = jukebox:getFile()

    jukebox:fadePlayFile(file)
  end

  function event:restore ()
    jukebox:fadePlayFile(oldFile)
  end

  return event
end

function Events:setMusic (jukebox, file)
  local event = Events:createTemplateEvent()

  local oldFile = nil

  function event:runForwards ()
    oldFile = jukebox:getFile()

    jukebox:setFile(file)
    jukebox:play()
  end

  function event:restore ()
    jukebox:setFile(oldFile)
    jukebox:play()
  end

  return event
end

return Events
