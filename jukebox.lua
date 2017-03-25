
local Jukebox = {}

local WILL_NOT_PLAY = 'WILL_NOT_PLAY'
local NO_FILE = 'NO_FILE'
local NO_TRACK = 'NO_TRACK'

function Jukebox:init ()
  self.currentFile = NO_FILE
  self.currentTrack = NO_TRACK
  self.willPlayFile = WILL_NOT_PLAY
end

function Jukebox:play ()
  if not (self.currentTrack == NO_TRACK) then
    love.audio.play(self.currentTrack)
  end
end

function Jukebox:stop ()
  if not (self.currentTrack == NO_TRACK) then
    love.audio.stop(self.currentTrack)
  end
end

function Jukebox:setFile (file)
  self:stop()
  self.currentFile = file

  if file == NO_FILE then
    self.currentTrack = NO_TRACK
  else
    self.currentTrack = love.audio.newSource(file, 'stream')
  end
end

function Jukebox:getFile ()
  return self.currentFile
end

function Jukebox:fadePlayFile (file)
  self.willPlayFile = file
end

function Jukebox:update ()
  function done ()
    self:stop()
    self:setFile(self.willPlayFile)
    self:play()
    self.willPlayFile = WILL_NOT_PLAY
  end

  if not (self.willPlayFile == WILL_NOT_PLAY) then
    if self.currentTrack == NO_TRACK then
      done()
    else
      local curVolume = self.currentTrack:getVolume()
      if curVolume > 0 then
        self.currentTrack:setVolume(math.max(0, curVolume - 0.05))
      else
        done()
      end
    end
  end
end

return Jukebox
