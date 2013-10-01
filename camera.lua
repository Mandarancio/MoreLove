require "rectangle"
require "buffer"

Camera = {}
Camera.__index=Camera

function  Camera.new(x,y,w,h)
	local inst = {
			_name="Camera",
			_follow={},
			_isFollowing=false,
			_followingPosition={}
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

function Camera:addFollow( object,size )
	if (size<=0) then
		size=1
	end
	self._followingPosition=Buffer.new(size)
	self._followingPosition:add(object:center())
	self._follow=object
	self._isFollowing=true
end

function Camera:computePosition(  )
	local p=Point.new(0,0)
	for i=0,self._followingPosition:size()-1 do
		p:sum(self._followingPosition:get(i))
	end
	p:divide(self._followingPosition:size())
	p:sum(Point.new(-self:width()/2,-self:height()/2))
	self:setPosition(p:x(),p:y())
end

function Camera:update(  )
	if (self._isFollowing) then
		self._followingPosition:add(self._follow:center())
		self:computePosition()
	end
end