Class ={}
Class.__index=Class

function Class.new()
	local obj={_name="Class"}
	setmetatable(obj,Class)
	return obj
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