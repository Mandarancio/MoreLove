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
	love.graphics.setColor(0,0,0)
	love.graphics.rectangle("fill",self._position:x(),self._position:y(),self._size,self._height)
	love.graphics.setColor(200,200,200)
	love.graphics.rectangle("line",self._position:x(),self._position:y(),self._size,self._height)

end

function MenuCursor:update( dt )
end

function MenuCursor:setY( y )
	self._position:setPosition(self._position:x(),y)
end