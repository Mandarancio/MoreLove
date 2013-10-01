require "class"

Dimension = {}
Dimension.__index=Dimension

function  Dimension.new(width,height)
	local inst = {
			_width=width,
			_height=height,
			_name="Dimension"
		}
	setmetatable(inst,Dimension)
	return inst
end

setmetatable(Dimension,{__index = Class})

function Dimension:toString(  )
	return self:name().."("..self._width..","..self._height..")"
end

function Dimension:width(  )
	return self._width	
end

function Dimension:height(  )
	return self._height
end

function Dimension:setSize(width,height)
	self._width=width
	self._height=height
end

function Dimension:setSize( size )
	self:setSize(size:width(),size:height())
end

function Dimension:equals( size )
	return (self._width==size:width() and self._height==size:height())
end
