require "class"
require "observer"

MenuItem = {}
MenuItem.__index=MenuItem

function  MenuItem.new(text)
	local inst = {
		_name="MenuItem",
		_text=text
	}

	inst._reg,inst._dereg,inst._notify=observer.create()
	inst._signal=observer.signal(inst,inst._notify,text)

	setmetatable(inst,MenuItem)
	return inst
end

setmetatable(MenuItem,{__index = Class})

function MenuItem:text(  )
	return self._text
end

function MenuItem:register(reciver,slot)
	self:_reg(self._text,reciver,slot)
end

function MenuItem:signal(  )
	self._signal(self._text)
end