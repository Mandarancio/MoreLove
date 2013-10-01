require "rectangle"

Camera = {}
Camera.__index=Camera

function  Camera.new(x,y,w,h)
	local inst = {
			_name="Camera"
		}
	inst._size=Dimension.new(w,h)
	inst._pos=Point.new(x,y)
	inst._limitatad=false
	inst._limts=Rectangle.new(0,0,0,0)
	setmetatable(inst,Camera)
	return inst
end

setmetatable(Camera,{__index = Rectangle})

function Camera:move( dx,dy )
	if not self._limitatad then
		self:setPosition(self:x()+dx,self:y()+dy)
	else
		x=self:x()+dx
		if (x<self._limits:x()) then
			x=self._limits:x()
		elseif x+self:width()>self._limits:x()+self._limits:width() then
			x=self._limits:x()+self._limits:width()-self:width()
		end
		y=self:y()+dy
		if (y<self._limits:y()) then
			y=self._limits:y()
		elseif y+self:height()>self._limits:y()+self._limits:height() then
			y=self._limits:y()+self._limits:height()-self:height()
		end
		self:setPosition(x,y)
	end
end

function Camera:setLimits(rect )
	self._limitatad=true
	self._limits=rect
end

function Camera:enableLimits()
	self._limitatad=true
end


function Camera:disableLimits(  )
	self._limitatad=false
end

function Camera:limits(  )
	return self._limits
end