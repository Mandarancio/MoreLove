require "observer"

Class ={}
Class.__index=Class

function Class.new()
	local obj={_name="Class",_reg,_dereg,_notify}
	obj._sign={}
	setmetatable(obj,Class)
	return obj
end

function Class:initRegister(  )
	self._reg,self._dereg,self._notify=observer.create()
	self._sign={}
end

function Class:toString(  )
	return self._name
end

function Class:name(  )
	return self._name
end

function Class:equals(obj)
	return obj:name()==self:name()
end

function Class:register(signal,reciver,slot)
	self:_reg(signal,reciver,slot)
end

function Class:signal(name)
	self._sign[name](self._text)
end

function Class:createSignal( name )
	self._sign[name]=observer.signal(self,self._notify,name)
end