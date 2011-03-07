require "LICK"
require "LICK/lib"
ez = require "LICK/lib/hlpr"

lick.clearFlag = true

rot = rot or 0
p = Point(0, 0, ez.color("azure", 255), 3, "smooth")

ez.setBlendMode("alpha")

function love.update(dt)
   rot = (rot + 0.5) % 35 -- would be nice to trigger via osc
end

function love.draw()
   ez.cls(5)

   ez.push()
   ez.rotate(0.5)
   ez.scale(4, 4)
   for i=1,500 do
      ez.translate(rot/2, rot)
      p:set("x", i*3)
      p:draw()
   end
   ez.pop()
end
