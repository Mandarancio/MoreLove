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

function StateMachine:restartNext(  )
	self._currentState=self._currentState:next()
	self._currentState:initialize()

	-- body
end

function StateMachine:back()
	self._currentState=self._currentState
end

function StateMachine:forward()
	self._currentState=self._currentState:next()
end

function StateMachine:getCallBack(  )
	return self.forward
end

function StateMachine:draw(  )
	self._currentState:scene():draw()
end

function StateMachine:update( dt )
	self._currentState:scene():update(dt)
end

function StateMachine:keypressed( key )
	self._currentState:scene():keyPressed(key)
end