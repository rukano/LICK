require "LICK"
require "LICK/lib"
ez = require "LICK/lib/hlpr"

lick.clearFlag = true

-- two states are already created:
-- State.frame and State.time

-- you can add your own states
State:add("scene", 0)

-- use it for whatever you want
-- you don't have to nil check it anymore

x, y = 0, 0

function love.update(dt)
   -- increment the frame and time at wish
   State:increment("frame", 1)
   State:increment("time", dt)

   -- try out changing the randomness
   x = 50 + State.time % 600 + math.random(10)
   y = 50 + State.frame % 400 + math.random(10)

end

function love.draw()
   -- also try out changing the colors, alpha, radius, etc
   -- the state remains
   ez.cls(10)
   setColor(ez.color("red", 10))
   ez.circle("fill", x, y, 40, 40)
   screenPrint(State.second, 100, 100)
end
