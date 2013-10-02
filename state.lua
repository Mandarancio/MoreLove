require "class"
require "scene"
require "menu"

State = {}
State.__index=State

function  State.new(previous,scene)
	local hud = {
		_scene=scene,
		_prevous=previous,
		_next={}
	}
	setmetatable(hud,State)
	return hud
end

setmetatable(State,{__index = Class})


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