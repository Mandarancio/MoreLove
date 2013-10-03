require "class"
Test={}

function Test.new()
	local inst=Class.new()
	inst._name="test"
	return inst
end
