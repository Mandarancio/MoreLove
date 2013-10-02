require "class"
require "scene"
require "menu"

State = {}
State.__index=State

function  State.new(previous,next)
	local hud = {
		_scene={},
		_prevous=previous,
		_next=next,
		_setup
	}
	setmetatable(hud,State)
	return hud
end

setmetatable(State,{__index = Class})


function State:setupFunction( fun )
	self._setup=fun
end

function State:scene(  )
	return self._scene
end

function State:setNext( next )

	self._next=next
end

function State:setPrevious( prev )
	self._prevous=prev
end

function State:next(  )
	return self._next
end

function State:previous(  )
	return self._prevous
end

function State:callBack() 
	print("hereee")
end

function State:initialize(  )
	self._scene=self._setup()
end