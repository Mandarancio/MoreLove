require "class"
require "dimension"
require "point"

Rectangle = {}
Rectangle.__index=Rectangle

function  Rectangle.new(x,y,width,height)
	local inst = {
			_name="Rectangle"
		}
	setmetatable(inst,Rectangle)
	inst._size=Dimension.new(width,height)
	inst._pos=Point.new(x,y)
	return inst
end

setmetatable(Rectangle,{__index = Class})

function Rectangle:toString(  )
	return self._name.."("..self:x()..","..self:y()..","..self:width()..","..self:height()..")"
end

function Rectangle:x(  )
	return self._pos:x()
end

function Rectangle:y( )
	return self._pos:y()
end

function Rectangle:width(  )
	return self._size:width()
end

function Rectangle:height(  )
	return self._size:height()
end

function Rectangle:setPosition(x,y )
	self._pos:setPosition(x,y)
end

function Rectangle:setSize(width,height )
	self._size:setSize(width,height)
end

function Rectangle:containPoint(point)
	return self:contains(point:x(),point:y())
end

function Rectangle:contains( x,y )
	return (x>=self:x() and x<=self:x()+self:width() and y>=self:y() and y<=self:y()+self:height())
end

function Rectangle:intersect( rect )
	if self:contains(rect:x(),rect:y()) then
		return true
	end
	if self:contains(rect:x(),rect:y()+rect:height()) then
		return true
	end
	if self:contains(rect:x()+rect:width(),rect:height()+rect:y()) then
		return true
	end
	if self:contains(rect:x()+rect:width(),rect:y()) then
		return true
	end
	if rect:contains(self:x(),self:y()) then
		return true
	end
	if rect:contains(self:x(),self:y()+self:height()) then
		return true
	end
	if rect:contains(self:x()+self:width(),self:y()+self:height()) then
		return true
	end
	if rect:contains(self:x()+self:width(),self:y()) then
		return true
	end
	return false
end

function Rectangle:containRect( rect )
	local a=Point.new(rect:x(),rect:y())
	local b=Point.new(rect:x(),rect:y()+rect:height())
	local c=Point.new(rect:x()+rect:width(),rect:y()+rect:height())
	local d=Point.new(rect:x()+rect:width(),rect:y())
	return (self:containPoint(a) and self:containPoint(b) and self:containPoint(c) and self:containPoint(d))
end