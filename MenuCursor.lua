require "class"

MenuCursor = {}
MenuCursor.__index=MenuCursor



function  MenuCursor.new(pos,w,h)
	local hud = {
			_size=w,
			_height=h,
			_position=pos,
			_name="MenuCursor"
		}
	setmetatable(hud,MenuCursor)
	return hud
end

setmetatable(MenuCursor,{__index = Class})

function MenuCursor:draw(  )
	
end

function MenuCursor:update( dt )
end