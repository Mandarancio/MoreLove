require "class"

Point = {}
Point.__index=Point

function  Point.new(x,y)
	local point = {
			_x=x,
			_y=y,
			_name="Point"
		}
	setmetatable(point,Point)
	return point
end

setmetatable(Point,{__index = Class})

function Point:toString()

	return self:name().."("..self._x..","..self._y..")"
end

function Point:x()
	return self._x
end

function Point:y( )
	return self._y
end

function Point:setPosition( x,y )
	self._x=x
	self._y=y
end

function Point:set( point )
	self._x=point:x()
	self._y=point:y()
end

function Point:distance( point )
	return self:distance(point:x(),point:y())
end

function Point:distance( x,y )
	dx=self._x-x
	dy=self._y-y

	return math.sqrt(dx*dx+dy*dy)
end

function Point:equals( point )
	return (self._x==point:x() and self._y==point:y())
end

function Point:sum( point )
	self._x=self._x+point:x()
	self._y=self._y+point:y()
end

function Point:divide(n)
	self._x=self._x/n
	self._y=self._y/n
end