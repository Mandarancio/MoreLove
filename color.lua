require "class"

Color = {}
Color.__index=Color

function  Color.new(r,g,b,a)
	local inst = {
			_r=r,
			_g=g,
			_b=b,
			_a=a,
			_name="Color"
		}
	setmetatable(inst,Color)
	return inst
end

setmetatable(Color,{__index = Class})

function Color:r()
	return self._r
end

function Color:g(  )
	return self._g
end

function Color:b(  )
	return self._b	
end

function Color:a(  )
	return self._a
end