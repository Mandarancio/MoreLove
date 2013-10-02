require "class"

Intro = {}
Intro.__index=Intro

function  Intro.new(r,g,b,a)
	local inst = {
			_ended=false
			_name="Intro"
		}
	setmetatable(inst,Intro)
	return inst
end

setmetatable(Intro,{__index = Class})

function Intro:isEnded()
	return self._ended
end

function Intro:update( dt )
	-- do something
end

function Intro:draw(  )
	-- paint the intro
end