require "class"

StateMachine = {}
StateMachine.__index=StateMachine

function  StateMachine.new()
	local hud = {
		_currentState={},
		_states={},
		_size=0
	}

	setmetatable(hud,StateMachine)
	return hud
end

setmetatable(StateMachine,{__index = Class})

function StateMachine:currentState(	 )
	return self._currentState
end

function StateMachine:setCurrentState( state )
	self._currentState=state
end

function StateMachine:add( state )
	self._size=self._size+1
	self._states[self._size]=state
end