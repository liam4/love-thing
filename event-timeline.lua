
--[[

  History rule of thumb:
  All state-changing events must be reversible.


  Events that take a significant amount of user-visible time should be
  skippable. This means that the event will be able to be skipped to the end
  of its animation; sometimes, it will also mean continuing to the next event
  (such as a fade-to-black transition) and other times not (such as immediately
  causing all the text in a dialog box to be displayed).


  The basic execution loop follows such:
  * event -> run(); cleanup()
  * (move to next event)
  * event -> run(); cleanup()
  * (move to next event)
  * ...

  However, sometimes the user will request the history to go back an event:
  * current event -> cancel(); restore(); cleanup()
  * (move to previous event)
  * (go to the normal execution loop)


  Correction: because we need to be able to deal with events that take more
  than a single frame to execute, the basic execution loop ends up being more
  like this:
  * Call the current event's "run" method.
  * Call the current event's "update" method.
    - If it returns true, continue and loop again.
    - If it returns false, instead, next update, run the "update" method agian.
  * Cleanup stuff should happen once the event is finished.


  To move to the next event:
  * Move the current event index ahead by 1. (++)
  * Set the current event to be the event list's item at the current index.
  * Push the current event index to the history stack.

  To move to the previous event:
  * Pop the last item off of the history stack.
  * Set the current event index to be the new top item on the history stack.
  * Set the current event to be the event list's item at the current index.
  Note that if there is only one item on the history stack, the current event
  will be set to nil. This is because there is no event before the first.

]]

local Timeline = {}

function Timeline:init (self)
  self.index = 0
  self.currentEvent = nil
  self.events = {}
  self.historyStack = {}
end

function Timeline:setEvents (self, events)
  self.events = events
end

function Timeline:moveForwards (self)
  self.index = self.index + 1
  self.currentEvent = self.events[self.index]
  self.historyStack[#self.historyStack + 1] = self.index
end

function Timeline:moveBackwards (self)
  if self.currentEvent then
    self.currentEvent:restore()
  end

  table.remove(self.historyStack)
  self.index = self.historyStack[#self.historyStack]
  self.currentEvent = self.events[self.index]
end

function Timeline:runNext (self)
  -- If we've gotten to the end of the event list, we can't continue!
  if self.index >= #self.events then
    return false
  end

  self:moveForwards(self)
  self.currentEvent:runForwards()
  self.currentEvent:run()
end

function Timeline:runPrevious (self)
  -- If we've gotten to the beginning of the event stack, we can't continue!
  if #self.historyStack <= 1 then
    return false
  end

  self:moveBackwards(self)
  self.currentEvent:run()
end

function Timeline:scheduleBack (self)
  --[[

    Schedules going back in history; it won't actually go back until the
    next update call.

  ]]

  self.willUpdateNext = false
  self.willGoBack = true
end

function Timeline:update (self)
  if self.willUpdateNext then
    if self.currentEvent:update() then
      self.willUpdateNext = false
    end
  else
    if self.willGoBack then
      self.willGoBack = false
      self:runPrevious(self)
    else
      self:runNext(self)
    end

    if not self.currentEvent:update() then
      self.willUpdateNext = true
    end
  end
end

function Timeline:gotKeypressed (self, ...)
  if self.currentEvent then
    self.currentEvent:gotKeypressed(...)
  end
end

return Timeline
