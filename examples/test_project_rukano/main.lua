require "LICK"
require "LICK/lib"
ez = require "LICK/lib/hlpr"

--lick.clearFlag = true
lick.clearFlag = false

rot = rot or 0
--p = Point(0, 0, ez.color("red", 255), 3, "smooth")
--p = Polygon({100, 100, 200, 200, 100, 300, 400, 500, 234, 432, 123, 321}, ez.color("red"), "line")

p = Rect(100, 100, 400, 300, ez.color("blue"), "fill")
ez.setBlendMode("alpha")

function love.update(dt)
   rot = (rot + 0.5) % 35 -- would be nice to trigger via osc
end

function love.draw()
   ez.cls(255)

   ez.push()
   p:draw("fill")
   
--[[   for i=1,500 do
      ez.translate(rot/2, rot)
      p:set("x", i*3)
      p:draw()
   end

   --]]

   ez.pop()
end

test = function (...)
	  print(...)
       end

test({234, 234, 234, 234, 234, 234})