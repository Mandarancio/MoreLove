require "class"
require "point"
require "rectangle"

GObject = {}
GObject.__index=GObject

function  GObject.new()
	local inst = {
			_name="GObject"
		}
	inst._bounds=Rectangle.new(0.1,0.1,0.2,0.2)
	inst._visible=true
	inst._scale={}
	inst._scale[0]=1.0
	inst._scale[1]=1.0
	setmetatable(inst,GObject)
	return inst
end

setmetatable(GObject,{__index = Class})
--debug flag for more graphical info
debug=true

function  GObject:bounds(  )
	return self._bounds
end

function GObject:setBounds( x,y,width,height )
	self._bounds=Rectangle.new(x,y,width,height)
end

-- function GObject:color(  )
-- 	return self._color
-- end

function GObject:draw(  )
	if (self._visible) then
		if debug then
			love.graphics.setColor(0,255,0)
			love.graphics.rectangle("line",self:bounds():x()*self._scale[0],self:bounds():y()*self._scale[1],self:bounds():width()*self._scale[0],self:bounds():height()*self._scale[1])
		end
		self:drawObject()
	end
end


function GObject:drawObject(  )
	-- Nothing to do here
end

function GObject:center(  )
	bounds = self:bounds()
	return Point.new(bounds:x()+bounds:width()/2,bounds:y()+bounds:height()/2)
end

function GObject:isVisible(  )
	return self._visible
end

function GObject:setVisible( flag )
	self._visible=flag
end

function GObject:setScale(sx,sy )
	self._scale[0]=sx
	self._scale[1]=sy	
end

