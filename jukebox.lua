
local Jukebox = {}

function Jukebox:init ()
  self.currentTrack = nil
end

function Jukebox:play ()
  if not (self.currentTrack == nil) then
    love.audio.play(self.currentTrack)
  end
end

function Jukebox:stop ()
  if not (self.currentTrack == nil) then
    love.audio.stop(self.currentTrack)
  end
end

function Jukebox:setFile (file)
  self.currentTrack = love.audio.newSource(file, 'stream')
end

return Jukebox
