require "class"

MenuItem = {}
MenuItem.__index=MenuItem

function  MenuItem.new(text)
	local inst = {
		_name=text,
	}



	setmetatable(inst,MenuItem)
	return inst
end

setmetatable(MenuItem,{__index = Class})

function MenuItem:text(  )
	return self._name
end

function MenuItem:register(reciver,slot)
	self:_reg(self._name,reciver,slot)
end
