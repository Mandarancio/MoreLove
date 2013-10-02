require "class"
require "state"

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
	if (state==nil)then
		print("ERROR")
	else
		self._currentState=state
	end

end

function StateMachine:add( state )
	self._size=self._size+1
	self._states[self._size]=state
end

function StateMachine:back()
	current=self._currentState
	self._currentState=current:previous()
	if (self._currentState== nil) then
    	love.event.push("quit")   -- actually causes the app to quit
	end
end

function StateMachine:forward()
	self._currentState=self._currentState:next()
end

function StateMachine:getCallBack(  )
	return self.forward
end