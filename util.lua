
-- Whee, the dreaded util file. As per usual.

local util = {}

function util:construct (fn, o)
  o = o or {}
  setmetatable(o, fn)
  fn.__index = fn
  return o, fn:init(o)
end

return util
