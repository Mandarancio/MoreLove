require "class"


Background = {}
Background.__index=Background

function  Background.new(bounds,level)
	local inst = {
			_name="Background",
			_bounds=bounds,
			_level=level, 
			_objects
		
		}


	setmetatable(inst,Background)
	return inst
end

setmetatable(Background,{__index = Class})