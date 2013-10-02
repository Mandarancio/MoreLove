require "class"

Menu = {}
Menu.__index=Menu

function  Menu.new(res,size)
	local hud = {
			_name="Menu",
			_resolution={res[1],res[2]},
			_size={size[1],size[2]},
			_items={},
			_nitems=0,
			_selected=1,
			_step=30
		}

	setmetatable(hud,Menu)
	hud._unit=0.01*res[2]/size[2]
	hud._fontSize=30*hud._unit
	hud._font = love.graphics.newFont(hud._fontSize) -- the number denotes the font size

	return hud
end

setmetatable(Menu,{__index = Class})

function Menu:addItem( item )
	self._nitems=self._nitems+1
	self._items[self._nitems]=item
end

function Menu:draw(  )
	love.graphics.setColor(255,255,255)
	love.graphics.setFont(self._font)

	dh=self._resolution[2]/2-(self._nitems*(self._step*2*self._unit+self._fontSize))/2
	y=self._step*self._unit+dh
	

	for i=1, self._nitems do 
		x=self._resolution[1]/2-self._font:getWidth(self._items[i])/2
		love.graphics.print(self._items[i],x,y)
		y=y+self._step*self._unit+self._fontSize
	end	
end

function Menu:selected()
	return self._selected
end
