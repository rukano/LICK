-- hlpr libary: it's not about nice coding, ist about fast and easy coding
-- by Rukano and Headchant, 2011

-- global math
pi = math.pi
sin = math.sin
deg = math.deg
rad = math.rad

-- global love.graphics functions
clear = love.graphics.clear
draw =  love.graphics.draw
drawq =  love.graphics.drawq
setColor = love.graphics.setColor
rectangle = love.graphics.rectangle
getWidth = love.graphics.getWidth
getHeight = love.graphics.getHeight
push = love.graphics.push
pop = love.graphics.pop
translate = love.graphics.translate
rotate = love.graphics.rotate
scale = love.graphics.scale
circle = love.graphics.circle
printOnScreen = love.graphics.print

-- love.graphics.getBackgroundColor
-- love.graphics.getBlendMode
-- love.graphics.getCaption
-- love.graphics.getColor
-- love.graphics.getColorMode
-- love.graphics.getFont
-- love.graphics.getHeight
-- love.graphics.getLineStipple
-- love.graphics.getLineStyle
-- love.graphics.getLineWidth
-- love.graphics.getMaxPointSize
-- love.graphics.getModes
-- love.graphics.getPointSize
-- love.graphics.getPointStyle
-- love.graphics.getScissor
-- love.graphics.getWidth
-- love.graphics.isCreated
-- love.graphics.line
-- love.graphics.newFont
-- love.graphics.newFramebuffer
-- love.graphics.newImage
-- love.graphics.newImageFont
-- love.graphics.newParticleSystem
-- love.graphics.newQuad
-- love.graphics.newScreenshot
-- love.graphics.newSpriteBatch
-- love.graphics.point
-- love.graphics.polygon
-- love.graphics.pop
-- love.graphics.present
-- love.graphics.print
-- love.graphics.printf
-- love.graphics.push
-- love.graphics.quad
-- love.graphics.rectangle
-- love.graphics.reset
-- love.graphics.rotate
-- love.graphics.scale
-- love.graphics.setBackgroundColor
-- love.graphics.setBlendMode
-- love.graphics.setCaption
-- love.graphics.setColor
-- love.graphics.setColorMode
-- love.graphics.setFont
-- love.graphics.setIcon
-- love.graphics.setLine
-- love.graphics.setLineStipple
-- love.graphics.setLineStyle
-- love.graphics.setLineWidth
-- love.graphics.setMode
-- love.graphics.setPoint
-- love.graphics.setPointSize
-- love.graphics.setPointStyle
-- love.graphics.setRenderTarget
-- love.graphics.setScissor
-- love.graphics.toggleFullscreen
-- love.graphics.translate
-- love.graphics.triangle

-- get color table
require "LICK/lib/color"

-- start the capsulated module
module(...,package.seeall)

function color(r,g,b,a)
	local color={}
	local alpha=a or 255
	local name=r or "azure"
	if type(r) == "string" then
		alpha = g or alpha
		color = x11_color_table[name]
	else
		color[1]=r
		color[2]=g
		color[3]=b
	end
	color[4]=alpha
	return color
end

function print(s, x, y, c)
   -- ez is easy.. if you need more parameters
   -- use printOnScreen!
   local s=string or "lick with love"
   local x=x or 100
   local y=y or 100
   local c=color or "white"
   setColor(color(c))
end


-- clip withing range (by redlock)
function clip(n,min,max)
	return math.min(math.max(n, min or -math.huge), max or math.huge) 
end

-- wrap within range, updated version
function wrap(n, min, max)
	local min = min or 0
	return ((n - min) % ((max or 0) - min)) + min
end

-- setColor white
function white()
	love.graphics.setColor(255,255,255,255)
end

-- setColor black
function black()
	love.graphics.setColor(0,0,0,255)
end

-- shorter setColor white
function w()
	white()
end

-- shorter setColor black
function b()
	black()
end

-- fill the screen with translucent black
function clear(alpha)
	love.graphics.setColor(0,0,0,alpha)
	love.graphics.rectangle("fill", 0,0,800,600)
end

-- shorter clear
function cls(alpha)
	clear(alpha)
end

-- one time clear
function cls_once()
	love.graphics.setColor(0,0,0,255)
	love.graphics.rectangle("fill", 0,0,800,600)
end


-- returns random values from -1 to 1, g sets the equidistance
function norm_random()
	return 2 * math.random() - 1
end

-- shorte norm_random
function n_rnd()
	return norm_random()
end

-- drunk, brownnoise/drunk walk: x = x +/- random(width)
function drunk(x, width, g)
	x = x or 0
	width = width or 1
	g = g or 100
	return (x + width*norm_random())
end


-- drnk, shorter version of drunk, start is only used the first time
-- this makes some sense whatsoever...
function drnk(width) 
	local last = 0 
	return function() 
		last = last + width * norm_random() 
		return last
	end 
end

-- scaling functions:

function linlin(n,inMin,inMax,outMin,outMax,clip)
   -- ported and adapted from:
   -- SuperCollider SimpleNumber:linlin

   local n=n or 0 -- to avoid giving back nil
   local clip=clip or "minmax" -- default:clip minmax

   if (inMin == nil) or (inMax == nil) or (outMin == nil) or (outMax == nil) then
      -- just in case you forgot the parameters...
      return n
   end

   if clip == "minmax" then
      if n <= inMin then
	 return minoutMin
      elseif n >= inMax then
	 return outMax
      end
   elseif clip == "min" then
      if n <= inMin then
	 return outMin
      end
   elseif clip == "max" then
      if n >= inMax then
	 return outMax
      end
   end

   -- here is the magic!
   n = (((n-inMin)/(inMax-inMin)) * (outMax-outMin)) + outMin 
   return n
end

function linexp(n,inMin,inMax,outMin,outMax,clip)
   -- ported and adapted from:
   -- SuperCollider SimpleNumber:linexp

   local n=n or 0.00001 -- to avoid giving back nil
   local clip=clip or "minmax" -- default:clip minmax

   if (inMin == nil) or (inMax == nil) or (outMin == nil) or (outMax == nil) then
      -- just in case...
      return n
   end

   if clip == "minmax" then
      if n <= inMin then
	 return outMin
      elseif n >= inMax then
	 return outMax
      end
   elseif clip == "min" then
      if n <= inMin then
	 return outMin
      end
   elseif clip == "max" then
      if n >= inMax then
	 return outMax
      end
   end

   -- here is the magic!
   n = math.pow(outMax/outMin, (n-inMin)/(inMax-inMin)) * outMin
   return n
end

function explin(n,inMin,inMax,outMin,outMax,clip)
   -- ported and adapted from:
   -- SuperCollider SimpleNumber:explin

   local n=n or 0.00001 -- to avoid giving back nil
   local clip=clip or "minmax" -- default:clip minmax

   if (inMin == nil) or (inMax == nil) or (outMin == nil) or (outMax == nil) then
      -- just in case...
      return n
   end

   if clip == "minmax" then
      if n <= inMin then
	 return outMin
      elseif n >= inMax then
	 return outMax
      end
   elseif clip == "min" then
      if n <= inMin then
	 return outMin
      end
   elseif clip == "max" then
      if n >= inMax then
	 return outMax
      end
   end

   -- here is the magic!
   n = (((math.log(n/inMin)) / (math.log(inMax/inMin))) * (outMax-outMin)) + outMin
   return n
end

function expexp(n,inMin,inMax,outMin,outMax,clip)
   -- ported and adapted from:
   -- SuperCollider SimpleNumber:expexp

   local n=n or 0.00001 -- to avoid giving back nil
   local clip=clip or "minmax" -- default:clip minmax

   if (inMin == nil) or (inMax == nil) or (outMin == nil) or (outMax == nil) then
      -- just in case...
      return n
   end

   if clip == "minmax" then
      if n <= inMin then
	 return outMin
      elseif n >= inMax then
	 return outMax
      end
   elseif clip == "min" then
      if n <= inMin then
	 return outMin
      end
   elseif clip == "max" then
      if n >= inMax then
	 return outMax
      end
   end
   -- here is the magic!
   n = math.pow(outMax/outMin, math.log(n/inMin) / math.log(inMax/inMin)) * outMin
   return n
end

-- returns easy sine oscillator
function sin()
	local x = 0
	return function(dt)
		x = x + (dt or 0)
		if x > 2 * pi then x = x - 2*pi end
		return math.sin(x)
	end
end

-- updates all objects in the _object table
function update_objects()
	for i,v in ipairs(_internal_object_table) do
		v:update(dt)
	end
end

-- rotate around center
function rotateCenter(angle)
   local angle=angle or 0
   local w, h = getWidth(), getHeight()
   translate(w/2, h/2)
   rotate(angle)
   translate(-w/2, -h/2)
end

-- return a random table entry
function choose(table)
	return table[math.random(#table)]
end
